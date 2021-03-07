unit ufrmCariSDLG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, Grids, ExtCtrls, Buttons,
  IB_Components, IB_Grid;

type
  TfrmCariSDLG = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    txtVeri: TEdit;
    btnAra: TButton;
    cboAlanAdi: TComboBox;
    rdoTip: TRadioGroup;
    chkGrup: TCheckBox;
    qryCari_Grup: TIB_Query;
    qryCari: TIB_Query;
    dtsCari_Grup: TIB_DataSource;
    dtsCari: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    IB_Grid2: TIB_Grid;
    btnTamam: TBitBtn;
    cmdCancel: TBitBtn;
    rg_Bakiye: TRadioGroup;
    procedure CariGrupSec;
    procedure CariSec;
    procedure FormShow(Sender: TObject);
    procedure rdoTipClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure txtVeriKeyPress(Sender: TObject; var Key: Char);
    procedure wwDBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure wwDBGrid2DblClick(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure chkGrupClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cmdCancelClick(Sender: TObject);
    function Form_Open(Menu:Boolean;var CARI_KOD:String;Var CARI_AD:String ; Banka:SmallInt):Boolean;
    procedure chkGrupEnter(Sender: TObject);
    procedure chkGrupExit(Sender: TObject);
    procedure rdoTipEnter(Sender: TObject);
    procedure rdoTipExit(Sender: TObject);
    procedure cboAlanAdiEnter(Sender: TObject);
    procedure cboAlanAdiExit(Sender: TObject);
    procedure txtVeriEnter(Sender: TObject);
    procedure txtVeriExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryCariCalculateField(Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
    procedure txtVeriKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rg_BakiyeClick(Sender: TObject);
  private
    { Private declarations }
    prv_Banka:SmallInt;

  public
    { Public declarations }
    Kontrol : Boolean;//False:CariID=0 iptalle cýkýldý true ise tamam ile cýkýldý
  end;

var
  frmCariSDLG: TfrmCariSDLG;

implementation

uses unDataMod,unFunc,Main,ufrmCariKart;

{$R *.DFM}

function TfrmCariSDLG.Form_Open(Menu:Boolean;var CARI_KOD:String;Var CARI_AD:String; Banka:SmallInt):Boolean;
//carideki tip alaný
//1- ALICI
//2- SATICI
//3- BANKA
//4- DIGER
//Banka Parametresi
/// 0-Sadece Bankalar
/// 1-Bankalar Dahil Hepsi
/// 2-Bankalar Haric Hepsi
var
  i : integer;
begin
  Application.CreateForm(TfrmCariSDLG, frmCariSDLG);
  with frmCariSDLG do
  begin
    prv_Banka := Banka ;
    qryCari.FieldByName('BAKIYE').DisplayFormat := glb_VPB_FIELD_PF;
    ShowModal;
    if not Kontrol then
    begin
      CARI_KOD:='';
      Result := False;
    end
    else
    begin
      CARI_KOD := qryCari.FieldByName('CARI_KOD').AsString;
      CARI_AD := qryCari.FieldByName('CARI_AD').AsString;
      Result:= True;
    end;
    qryCari.Close;
    qryCari_Grup.Close;
    Release;
  end;
end;

procedure TfrmCariSDLG.CariSec ;
//carideki tip alaný
//1- ALICI
//2- SATICI
//3- BANKA
//4- DIGER
//Banka Parametresi
/// 0-Sadece Bankalar
/// 1-Bankalar Dahil Hepsi
/// 2-Bankalar Haric Hepsi
var
  strSQL:String;
begin
  if (chkGrup.Checked = True ) then
  begin

    if rg_Bakiye.ItemIndex=0 then
    strSQL := 'SELECT CARI.CARI_SID,CARI.CARI_KOD,CARI.CARI_AD,CARI.BORC,CARI.ALACAK,CARI.DEVREDEN_BORC,CARI.DEVREDEN_ALACAK '
            + 'FROM CARI INNER JOIN CARI_GRUP_UYE ON (CARI.CARI_KOD = CARI_GRUP_UYE.CARI_KOD)  '
            + 'WHERE CARI_GRUP_UYE.CARI_GRUP_KOD=' + SQL_Katar(qryCari_Grup.FieldByName('CARI_GRUP_KOD').AsString);

    if rg_Bakiye.ItemIndex=1 then
    strSQL :=
    'SELECT CARI.CARI_SID,CARI.CARI_KOD,CARI.CARI_AD '+
    ',sum(case when  carihar.TIP=''B'' then '+
    'carihar.TUTAR_VPB else 0 end) Borc '+
    ',Sum(case when  carihar.TIP=''A'' then '+
    'carihar.TUTAR_VPB else 0 end) Alacak, '+
    'CARI.DEVREDEN_BORC,CARI.DEVREDEN_ALACAK  FROM CARI '+
    'INNER JOIN CARI_GRUP_UYE ON (CARI.CARI_KOD = CARI_GRUP_UYE.CARI_KOD)  '+
    'left outer join carihar on (cari.cari_kod=carihar.cari_kod) '+
    'WHERE CARI_GRUP_UYE.CARI_GRUP_KOD=' + SQL_Katar(qryCari_Grup.FieldByName('CARI_GRUP_KOD').AsString);


    if (trim(txtVERI.Text)<> '') then
      case cboAlanAdi.ItemIndex  of
      0 : strSQL := strSQL + ' AND CARI.CARI_KOD LIKE'  + SQL_Katar(txtVeri.Text + '%');
      1 : strSQL := strSQL + ' AND CARI.CARI_AD LIKE' + SQL_Katar(txtVeri.Text + '%');
      2 : strSQL := strSQL + ' AND CARI.YETKISI LIKE' + SQL_Katar(txtVeri.Text + '%');

    end;
  end
  else
  begin


{
SELECT CARI.CARI_SID,CARI.CARI_KOD,CARI.CARI_AD
,sum(case when  carihar.TIP='B' then
carihar.TUTAR_VPB else 0 end) Borc
,Sum(case when  carihar.TIP='A' then
carihar.TUTAR_VPB else 0 end) Alacak,
CARI.DEVREDEN_BORC,CARI.DEVREDEN_ALACAK  FROM CARI
left outer join carihar on (cari.cari_kod=carihar.cari_kod)
group by CARI.CARI_SID,CARI.CARI_KOD,CARI.CARI_AD,CARI.DEVREDEN_BORC,CARI.DEVREDEN_ALACAK

}

    if rg_Bakiye.ItemIndex=0 then
    strSQL := 'SELECT CARI.CARI_SID,CARI.CARI_KOD,CARI.CARI_AD,CARI.BORC,CARI.ALACAK,CARI.DEVREDEN_BORC,CARI.DEVREDEN_ALACAK  FROM CARI WHERE ';

    if rg_Bakiye.ItemIndex=1 then
    strSQL :=
    'SELECT CARI.CARI_SID,CARI.CARI_KOD,CARI.CARI_AD '+
    ',sum(case when  carihar.TIP=''B'' then '+
    'carihar.TUTAR_VPB else 0 end) Borc '+
    ',Sum(case when  carihar.TIP=''A'' then '+
    'carihar.TUTAR_VPB else 0 end) Alacak, '+
    'CARI.DEVREDEN_BORC,CARI.DEVREDEN_ALACAK  FROM CARI '+
    'left outer join carihar on (cari.cari_kod=carihar.cari_kod) WHERE ';


    case cboAlanAdi.ItemIndex  of
    0 : strSQL := strSQL + 'CARI.CARI_KOD LIKE'  + SQL_Katar(txtVeri.Text + '%');
    1 : strSQL := strSQL + 'CARI.CARI_AD LIKE' + SQL_Katar(txtVeri.Text + '%');
    2 : strSQL := strSQL + 'CARI.YETKISI LIKE' + SQL_Katar(txtVeri.Text + '%');
    end;


  end;

  case  frmCariSDLG.prv_Banka of
  0: strSQL := strSQL + ' AND CARI.TIP=3'; /// sadece banka
  2: strSQL := strSQL + ' AND CARI.TIP<>3'; // bankalar haric;

  15: strSQL := strSQL + ' AND CARI.TIP=5'; /// sadece mozotçu

  end;

    if rg_Bakiye.ItemIndex=0 then
    case cboAlanAdi.ItemIndex  of
    0 : strSQL := strSQL + ' ORDER BY CARI.CARI_KOD';
    1 : strSQL := strSQL + ' ORDER BY CARI.CARI_AD';
    2 : strSQL := strSQL + ' ORDER BY CARI.YETKISI';
    end;

    if rg_Bakiye.ItemIndex=1 then
    case cboAlanAdi.ItemIndex  of
    0 : strSQL := strSQL + ' group by CARI.CARI_SID,CARI.CARI_KOD,CARI.CARI_AD,CARI.DEVREDEN_BORC,CARI.DEVREDEN_ALACAK';
    1 : strSQL := strSQL + ' group by CARI.CARI_SID,CARI.CARI_AD,CARI.CARI_KOD,CARI.DEVREDEN_BORC,CARI.DEVREDEN_ALACAK';
    2 : strSQL := strSQL + ' group by CARI.CARI_SID,CARI.CARI_KOD,CARI.CARI_AD,CARI.DEVREDEN_BORC,CARI.DEVREDEN_ALACAK';
    end;




//    strSQL := strSQL + ' ORDER BY CARI_KOD ASC';

  with qryCari do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;
//  IB_Grid2.SetFocus;
    txtVeri.SetFocus;

end;


procedure TfrmCariSDLG.CariGrupSec;
var
  strSQL:String;
begin
  case rdoTip.ItemIndex of
  1:strSQL := 'SELECT * FROM CARI_GRUP WHERE  TIP = 1 ORDER BY CARI_GRUP_KOD'; //alýcý
  2:strSQL := 'SELECT * FROM CARI_GRUP WHERE TIP = 0 ORDER BY CARI_GRUP_KOD';//satýcý
  0:strSQL := 'SELECT * FROM CARI_GRUP ORDER BY CARI_GRUP_KOD'; //hepsi
  end;
  with qryCari_Grup do
  begin
    Active := False;
    Sql.Clear;
    SQL.Add (strSQL);
    Active := True;
  end;
end;

procedure TfrmCariSDLG.FormShow(Sender: TObject);
begin
  qryCari_Grup.Active := False;
  qryCari.Active := False;
  Kontrol := False;
  cboAlanAdi.ItemIndex := 1;
end;

procedure TfrmCariSDLG.rdoTipClick(Sender: TObject);
begin
  CariGrupSec ;
end;

procedure TfrmCariSDLG.btnAraClick(Sender: TObject);
begin
  CariSec ;
end;

procedure TfrmCariSDLG.txtVeriKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
  if key=#13 then
  begin
  //btnAraClick(Self);
  btnTamamClick(Self);
  Exit;
  end;

  btnAraClick(Self);
//  txtVeri.SetFocus;
end;

procedure TfrmCariSDLG.wwDBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
  begin
    Kontrol :=True;
    Close;
  end;
end;

procedure TfrmCariSDLG.wwDBGrid2DblClick(Sender: TObject);
begin
  btnAraClick(self);
end;

procedure TfrmCariSDLG.btnTamamClick(Sender: TObject);
begin
  if Trim(qryCari.FieldByName('CARI_KOD').AsString)='' then exit;

  if (qryCari.Active = True) Then
  begin
    Kontrol := True;
    Close;
  end
  else
  begin
    case Application.MessageBox('Arama yapmadýnýz forma geri dönmek için YES Cýkmak için NO','Dikkat',MB_YESNO) of
    7:
      begin
        Kontrol := False;
        Close;
      end;
    end;
  end;
end;

procedure TfrmCariSDLG.chkGrupClick(Sender: TObject);
begin
  if chkGrup.Checked then
  begin
    rdoTip.Enabled := True;
    IB_Grid1.Enabled := True;
    CariGrupSec;
  end
  else
  begin
    rdoTip.Enabled := False;
    IB_Grid1.Enabled := False;
    qryCari_Grup.Active := False;
  end;
end;

procedure TfrmCariSDLG.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ActiveControl.Name = 'IB_Grid2' then
  begin
    if key=#13 then
    begin
      btnTamamClick(Self);
    end;
  end;
  if key = #27 then
  begin
    if cmdCancel.Enabled then cmdCancelClick(Self);
  end;
end;

procedure TfrmCariSDLG.cmdCancelClick(Sender: TObject);
begin
  Kontrol := False;
  Close;
end;

procedure TfrmCariSDLG.chkGrupEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCariSDLG.chkGrupExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmCariSDLG.rdoTipEnter(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCariSDLG.rdoTipExit(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := clBtnFace;
end;

procedure TfrmCariSDLG.cboAlanAdiEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCariSDLG.cboAlanAdiExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmCariSDLG.txtVeriEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCariSDLG.txtVeriExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmCariSDLG.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmCariSDLG);
end;

procedure TfrmCariSDLG.qryCariCalculateField(Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
var
  borc_vpb,alacak_vpb : Currency;
begin

  if (ARow.ByName('BORC').AsCurrency+ARow.ByName('DEVREDEN_BORC').AsCurrency) > (ARow.ByName('ALACAK').AsCurrency+ARow.ByName('DEVREDEN_ALACAK').AsCurrency) then
  begin
    ARow.ByName('BAKIYE').AsCurrency := (ARow.ByName('BORC').AsCurrency+ARow.ByName('DEVREDEN_BORC').AsCurrency) - (ARow.ByName('ALACAK').AsCurrency+ARow.ByName('DEVREDEN_ALACAK').AsCurrency);
    ARow.ByName('BA').AsString := BORC;
  end
  else
  begin
    ARow.ByName('BAKIYE').AsCurrency := (ARow.ByName('ALACAK').AsCurrency+ARow.ByName('DEVREDEN_ALACAK').AsCurrency) - (ARow.ByName('BORC').AsCurrency+ARow.ByName('DEVREDEN_BORC').AsCurrency);
    ARow.ByName('BA').AsString := ALACAK;
  end;


end;

procedure TfrmCariSDLG.txtVeriKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if Key=Vk_Up then
     begin
          if not qryCari.Bof then
          qryCari.Prior;
     end;
     if Key=Vk_Down then
     begin
          if not qryCari.Eof then
          qryCari.Next;
     end;
end;

procedure TfrmCariSDLG.rg_BakiyeClick(Sender: TObject);
begin
  CariSec ;
end;

end.
