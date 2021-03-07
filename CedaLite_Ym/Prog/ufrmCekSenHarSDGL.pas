unit ufrmCekSenHarSDGL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, IB_Grid, IB_Components;

type
  TfrmCekSenHarSDGL = class(TForm)
    Panel2: TPanel;
    btnTamam: TBitBtn;
    cmdCancel: TBitBtn;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    lblCekSen_KOD: TLabel;
    lblKodName: TLabel;
    qry_Hareket_Liste: TIB_Query;
    dts_Liste: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    btnSec: TButton;
    procedure cmdCancelClick(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure qry_Hareket_ListeCalculateField(Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
    procedure btnSecClick(Sender: TObject);
    procedure Setting_Form_Caption(BELGE_ID : Integer);
    function Form_Open(Menu:Boolean;
                       CEKSEN:Byte;
                       Tip:Byte;
                       GISLEM:integer;
                       Tercihli:Boolean;
                       BELGE_ID:integer;
                       BELGE_SID:integer;
                       var ISLEM:Byte;
                       var CEKSENHAR_ID:integer;
                       var CEKSENHAR_SID:integer):Boolean;
    procedure SQL_Tazele(BELGE_ID , BELGE_SID : integer);
    procedure FormCreate(Sender: TObject);
    procedure IB_Grid1KeyPress(Sender: TObject; var Key: Char);


  private
    { Private declarations }
  public
     Kontrol:Boolean;
     prvTip : byte;
     // 1 - M��teri
     // 2 - Bor�
     prvIslem : integer;
     {
     M��teri �ek ve Senetleri
      1- Al�m
      2- Tahsile Verme
      3- Cirolama
      4- Tahsilden Gelen �Tahsil� Dekontu
      5- Tahsilden Gelen �Kar��l�ks�z� Dekontu
      6- Sat�c�dan  Gelen �Kar��l�ks�z�  Dekontu
      7- Portfoyde  �Kar��l�ks�z� Dekontu
      8- Portfoyde �Iade� Dekontu
      9- Kasaya Tahsil

      Bor� �ek ve Senetleri
      15- Verim
      16- �ade dekontu
      17- Bankadan Bor� �eki �deme Dekontu
      18- Kasadan �ek Senet �deme
     }
     prvCEKSEN : byte; // 1= Cek   2= Senet
     prvTercihli : Boolean;
     { Public declarations }
  end;

var
  frmCekSenHarSDGL: TfrmCekSenHarSDGL;

implementation

uses unDataMod,unFunc, DateUtils, StdConvs, ufrmCek, ufrmCekSenSDLG, unCekSenHar;

{$R *.dfm}

function TfrmCekSenHarSDGL.Form_Open(Menu:Boolean;
                                     CEKSEN:Byte;
                                     Tip: Byte;
                                     GISLEM:integer;
                                     Tercihli:Boolean;
                                     BELGE_ID:integer;
                                     BELGE_SID:integer;
                                     var ISLEM:Byte;
                                     var CEKSENHAR_ID:integer;
                                     var CEKSENHAR_SID:integer):Boolean;
begin
  Application.CreateForm(TfrmCekSenHarSDGL,frmCekSenHarSDGL);
  with frmCekSenHarSDGL do
  begin
    prvIslem:= GISLEM;
    prvTip:= Tip;
    prvCEKSEN:= CEKSEN;
    prvTercihli := Tercihli;
    case CEKSEN of
    CEK :
      begin
        if BELGE_ID <> 0 then
        begin
          Setting_Form_Caption(BELGE_ID);
          lblCekSen_KOD.Caption:=IntToStr ( BELGE_ID);
          btnSec.Enabled:=False;
        end;
        lblKodName.Caption := '�ek No';
      end;
    SENET:
      begin
        if BELGE_ID <> 0 then
        begin
          Setting_Form_Caption(BELGE_ID);
          lblCekSen_KOD.Caption:=IntToStr ( BELGE_ID);
          btnSec.Enabled:=False;
        end;
        lblKodName.Caption := 'Senet No';
      end;
    end;//end case CEKSEN of

    if (BELGE_ID<>0) and (BELGE_SID <> 0) then
    begin
      SQL_Tazele (BELGE_ID,BELGE_SID);
    end;
    ShowModal;

    if not Kontrol then
    begin
      ISLEM:=0;
      CEKSENHAR_ID:=0;
      CEKSENHAR_SID:=0;
      Result := False;
    end
    else
    begin
      CEKSENHAR_ID:=qry_Hareket_Liste.FieldByName('CEKSENHAR_ID').AsInteger;
      CEKSENHAR_SID:=qry_Hareket_Liste.FieldByName('CEKSENHAR_SID').AsInteger;
      ISLEM:= qry_Hareket_Liste.FieldByName('ISLEM').AsInteger;
      Result := True;
    end;
    qry_Hareket_Liste.Close; 
    Release;
  end;//end with
end;





procedure TfrmCekSenHarSDGL.SQL_Tazele (BELGE_ID , BELGE_SID : integer);
var
  WhereEk:Boolean;
begin
  WhereEk := False;
  with qry_Hareket_Liste do
  begin
    Active := False;
    sql.Clear;
    sql.Add ('SELECT CEKSENHAR_ID');
    sql.Add (' , CEKSENHAR_SID');
    sql.Add (' , ISLEM_TAR');
    sql.Add (' , BELGE_ID');
    sql.Add (' , BELGE_SID');
    sql.Add (' , CEKSEN');
    sql.Add (' , ISLEM');
    sql.Add (' , TUTAR_VPB');
    sql.Add (' , DOVKUR');
    sql.Add (' , CARI_KOD');
    sql.Add (' , (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD = CEKSENHAR.CARI_KOD) AS CARI_AD');
    sql.Add (' , CARIHAR_ACK');
    sql.Add (' FROM CEKSENHAR ');
    if prvIslem <> -1  then
    begin
      sql.Add ('WHERE ISLEM = '+ inttostr (prvIslem));
      WhereEk := True;
    end;

    if WhereEk then
    begin
      sql.Add (' AND BELGE_ID = '+ IntToStr(BELGE_ID ) + ' and BELGE_SID='+ IntToStr(BELGE_SID ));
    end
    else
    begin
      sql.Add (' WHERE BELGE_ID = '+ IntToStr(BELGE_ID ) + ' and BELGE_SID='+ IntToStr(BELGE_SID ));
    end;
  end;//with begin-end

  try
    qry_Hareket_Liste.Active := True;
  except
    Application.MessageBox('SQL c�mleci�inde hata olu�tu.','Dikkat',MB_ICONSTOP);
  end;

{
M��teri �ek ve Senetleri
1- Al�m
2- Tahsile Verme
3- Cirolama
4- Tahsilden Gelen �Tahsil� Dekontu
5- Tahsilden Gelen �Kar��l�ks�z� Dekontu
6- Sat�c�dan  Gelen �Kar��l�ks�z�  Dekontu
7- Portfoyde  �Kar��l�ks�z� Dekontu
8- Portfoyde �Iade� Dekontu
9- Kasaya Tahsil

Bor� �ek ve Senetleri
15- Verim
16- �ade dekontu
17- Bankadan Bor� �eki �deme Dekontu
18- Kasadan �ek Senet �deme
}

  if qry_Hareket_Liste.RecordCount = 0 then
  begin
    case prvIslem of
    1:Application.MessageBox('Se�ti�iniz belgenin ALIM ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    2:Application.MessageBox('Se�ti�iniz belgenin TAHS�LE VERME ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    3:Application.MessageBox('Se�ti�iniz belgenin C�ROLAMA ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    4:Application.MessageBox('Se�ti�iniz belgenin Tahsilden Gelen Tahsil Dekontu ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    5:Application.MessageBox('Se�ti�iniz belgenin Tahsilden Gelen Kar��l�ks�z Dekontu ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    6:Application.MessageBox('Se�ti�iniz belgenin Sat�c�dan  Gelen Kar��l�ks�z  Dekontu ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    7:Application.MessageBox('Se�ti�iniz belgenin Portfoyde  Kar��l�ks�z Dekontu ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    8:Application.MessageBox('Se�ti�iniz belgenin Portfoyde Iade Dekontu ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    9:Application.MessageBox('Se�ti�iniz belgenin Kasaya Tahsil ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    15:Application.MessageBox('Se�ti�iniz belgenin Verim ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    16:Application.MessageBox('Se�ti�iniz belgenin �ade dekontu ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    17:Application.MessageBox('Se�ti�iniz belgenin Bankadan Bor� �eki �deme Dekontu ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    18:Application.MessageBox('Se�ti�iniz belgenin Kasadan �ek/Senet �deme ile ilgili hi�bir hareketi yok.','Dikkat',MB_ICONSTOP);
    end;
  end;
end;

procedure TfrmCekSenHarSDGL.cmdCancelClick(Sender: TObject);
begin
  Kontrol := False;
  Close;
end;

procedure TfrmCekSenHarSDGL.btnTamamClick(Sender: TObject);
begin
  if (qry_Hareket_Liste.Active = True) Then
  begin
    if not (qry_Hareket_Liste.RecordCount = 0) then
    begin
      Kontrol := True;
      Close;
    end
    else
    begin
      Kontrol := False;
      Close;
    end;
  end
  else
  if Application.MessageBox('Se�im yapmad�n�z forma geri d�nmek i�in YES C�kmak i�in NO','Dikkat',MB_YESNO) = IDNO then
  begin
    Kontrol := False;
    Close;
  end;
end;

procedure TfrmCekSenHarSDGL.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then cmdCancelClick(self);
end;


{
M��teri �ek ve Senetleri
1- Al�m
2- Tahsile Verme
3- Cirolama
4- Tahsilden Gelen �Tahsil� Dekontu
5- Tahsilden Gelen �Kar��l�ks�z� Dekontu
6- Sat�c�dan  Gelen �Kar��l�ks�z�  Dekontu
7- Portfoyde  �Kar��l�ks�z� Dekontu
8- Portfoyde �Iade� Dekontu
9- Kasaya Tahsil

Bor� �ek ve Senetleri
15- Verim
16- �ade dekontu
17- Bankadan Bor� �eki �deme Dekontu
18- Kasadan �ek Senet �deme
}

procedure TfrmCekSenHarSDGL.qry_Hareket_ListeCalculateField(Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
  case  ARow.GetColumnValue('ISLEM') of
  1:  ARow.SetColumnValue('ISLEM_ACK','ALIM');
  2:  ARow.SetColumnValue('ISLEM_ACK','TAHS�LE VERME');
  3:  ARow.SetColumnValue('ISLEM_ACK','C�ROLAMA');
  4:  ARow.SetColumnValue('ISLEM_ACK','Tahsilden Gelen Tahsil Dekontu');
  5:  ARow.SetColumnValue('ISLEM_ACK','Tahsilden Gelen Kar��l�ks�z Dekontu');
  6:  ARow.SetColumnValue('ISLEM_ACK','Sat�c�dan  Gelen Kar��l�ks�z  Dekontu');
  7:  ARow.SetColumnValue('ISLEM_ACK','Portfoyde  Kar��l�ks�z Dekontu');
  8:  ARow.SetColumnValue('ISLEM_ACK','Portfoyde Iade Dekontu');
  9:  ARow.SetColumnValue('ISLEM_ACK','Kasaya Tahsil');
  15:  ARow.SetColumnValue('ISLEM_ACK','Verim');
  16:  ARow.SetColumnValue('ISLEM_ACK','�ade dekontu');
  17:  ARow.SetColumnValue('ISLEM_ACK','Bankadan Bor� �eki �deme Dekontu');
  18:  ARow.SetColumnValue('ISLEM_ACK','Kasadan �ek Senet �deme');
  end;
end;

procedure TfrmCekSenHarSDGL.btnSecClick(Sender: TObject);
var
  BELGE_ID,BELGE_SID:Integer;
begin
  case prvCEKSEN of
  CEK:
    begin
      if frmCekSenSDLG.Form_Open(true,CEK,BELGE_ID,BELGE_SID,prvTip,prvTercihli,prvTip,prvIslem) Then
      begin
        lblCekSen_KOD.Caption := inttostr(BELGE_ID);
        Setting_Form_Caption(BELGE_ID);
        SQL_Tazele(BELGE_ID,BELGE_SID);
      end;
    end;
  SENET:
    begin
      if frmCekSenSDLG.Form_Open(true,SENET,BELGE_ID,BELGE_SID,prvTip,prvTercihli,prvTip,prvIslem) Then
      begin
        lblCekSen_KOD.Caption := inttostr(BELGE_ID);
        Setting_Form_Caption(BELGE_ID);
        SQL_Tazele(BELGE_ID,BELGE_SID);
      end;
    end;
  end;
end;


{
M��teri �ek ve Senetleri
1- Al�m
2- Tahsile Verme
3- Cirolama
4- Tahsilden Gelen �Tahsil� Dekontu
5- Tahsilden Gelen �Kar��l�ks�z� Dekontu
6- Sat�c�dan  Gelen �Kar��l�ks�z�  Dekontu
7- Portfoyde  �Kar��l�ks�z� Dekontu
8- Portfoyde �Iade� Dekontu
9- Kasaya Tahsil

Bor� �ek ve Senetleri
15- Verim
16- �ade dekontu
17- Bankadan Bor� �eki �deme Dekontu
18- Kasadan �ek Senet �deme
}

procedure TfrmCekSenHarSDGL.Setting_Form_Caption(BELGE_ID : Integer);
begin
  case prvCEKSEN of
  CEK:
    case prvIslem of
    1:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Al�m)';
    2:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Tahsile Verme)';
    3:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Cirolama)';
    4:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Tahsilden Gelen Tahsil Dekontu)';
    5:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Tahsilden Gelen Kar��l�ks�z Dekontu)';
    6:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Sat�c�dan  Gelen Kar��l�ks�z  Dekontu)';
    7:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Portfoyde  Kar��l�ks�z Dekontu)';
    8:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Portfoyde Iade Dekontu)';
    9:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Kasaya Tahsil)';
    15:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Verim)';
    16:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (�ade dekontu)';
    17:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Bankadan Bor� �eki �deme Dekontu)';
    18:Caption := IntToStr (BELGE_ID) + ' Numaral� �ekin Hareketleri (Kasadan �ek �deme)';
    end;//end case prvIslem of
  SENET:
    case prvIslem of
    1:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Al�m)';
    2:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Tahsile Verme)';
    3:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Cirolama)';
    4:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Tahsilden Gelen Tahsil Dekontu)';
    5:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Tahsilden Gelen Kar��l�ks�z Dekontu)';
    6:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Sat�c�dan  Gelen Kar��l�ks�z  Dekontu)';
    7:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Portfoyde  Kar��l�ks�z Dekontu)';
    8:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Portfoyde Iade Dekontu)';
    9:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Kasaya Tahsil)';
    15:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Verim)';
    16:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (�ade dekontu)';
    17:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Bankadan Bor� �eki �deme Dekontu)';
    18:Caption := IntToStr (BELGE_ID) + ' Numaral� Senetin Hareketleri (Kasadan Senet �deme)';
    end;//end case prvIslem of
  end;//end case prvCEKSEN of
end;


procedure TfrmCekSenHarSDGL.FormCreate(Sender: TObject);
begin
  with frmCekSenHarSDGL.qry_Hareket_Liste do
  begin
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
  end;
end;

procedure TfrmCekSenHarSDGL.IB_Grid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key =#13 then
  begin
    Kontrol :=True;
    Close;
  end;

end;

end.
