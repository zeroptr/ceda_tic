{$INCLUDE directive.inc}

unit ufrmKasa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, StdCtrls, IB_Grid, IB_Controls, ComCtrls, Grids, Mask,
  Menus, Buttons, ExtCtrls;

type
  TfrmKasa = class(TForm)
    dtsKasa: TIB_DataSource;
    Page: TPageControl;
    tabKasa: TTabSheet;
    qryKasa: TIB_Query;
    tabAy: TTabSheet;
    grd_kasa: TStringGrid;
    qryHareket: TIB_Query;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit6: TIB_Edit;
    chkVarsayilan: TIB_CheckBox;
    cboDOVKOD: TIB_ComboBox;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure qryKasaAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qryKasaBeforePost(IB_Dataset: TIB_Dataset);
    procedure PageChanging(Sender: TObject; var AllowChange: Boolean);
    procedure PageChange(Sender: TObject);
    procedure grd_kasaDrawCell(Sender: TObject; ACol, ARow: Integer;      Rect: TRect; State: TGridDrawState);
    procedure dtsKasaStateChanged(Sender: TIB_DataSource;       ADataset: TIB_Dataset);
    procedure FormCreate(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure qryKasaBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);

    procedure FormKeyDown(Sender: TObject; var Key: Word;        Shift: TShiftState);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure qryKasaAfterPost(IB_Dataset: TIB_Dataset);
    procedure FormShow(Sender: TObject);
    procedure cboDOVKODEnter(Sender: TObject);
    procedure cboDOVKODExit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
    function Form_Open(Menu : Boolean;KASA_KOD:String;ISLEM :Byte ; BelgeTuru: Byte):Boolean;
    function Dataset_Open(KASA_KOD:String;ISLEM:Byte): Boolean;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure data_ekle();
    procedure ay_ekle();
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    Belge_Turu:Byte;
    { Private declarations }
    Grd_Rect:TRect;
    Grid:TStringGrid;
    Grd_Col,Grd_Row:Integer;
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
    procedure Geri_AL;
  public
    { Public declarations }
  end;
//subelerdeki kullanýcýlarýn kasa ile oynamamasý için
//cns_kasa = 14 muhasebe = 19 ile deðiþtirildi.
  const cns_kasa = 14;
var
  frmKasa: TfrmKasa;

implementation

{$R *.DFM}
uses unDataMod, main, unStrGrd,unFunc,  unLogger;

function  TfrmKasa.Form_Open(Menu : Boolean;KASA_KOD:String;ISLEM :Byte ; BelgeTuru: Byte):Boolean;
var
  local_can_update,local_can_delete:Boolean;
begin
  Result := False;
  if not DataMod.Modul_Hak(cns_kasa,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmKasa') then
    begin
      Application.CreateForm(TfrmKasa,frmKasa);
    end
    else
    begin
      Application.MessageBox('Kasa formu açýk.','Dikkat',MB_ICONWARNING);
      exit;
    end;
    with frmKasa do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      Belge_Turu := BelgeTuru;
      page.ActivePageIndex := 0 ;
      DataSet_Open(KASA_KOD,ISLEM);
    end;
  end;
  Result := True;
end;

function TfrmKasa.Dataset_Open(KASA_KOD:String;ISLEM:Byte): Boolean;
begin
  Result := False;
  if ((KASA_KOD='') and (ISLEM=0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  ay_ekle;
  with frmKasa.qryKasa do
  begin
    Active := False;
    ParamByName('PRM_KASA_KOD').AsString := KASA_KOD;
    Active := True;
  end;
  case islem of
  0:
    begin
      frmKasa.qryKasa.Insert;
    end;
  1:
    begin
      //qryKasa.Edit;
    end;
  end;
  Result := True;
end;

procedure TfrmKasa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TfrmKasa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
end;


procedure TfrmKasa.ay_ekle();
var
  i:integer;
  const aylar : Array[0..11] of ShortString = ('Ocak','Þubat','Mart','Nisan','Mayýs','Haziran','Temmuz','Aðustos','Eylül','Ekim','Kasým','Aralýk');
  const degerler : Array[0..5] of ShortString = ('Borç','Alacak','B/A','Borç VPB','Alacak VPB','Bakiye');
begin
  for i := 1 to 12 do
  begin
    with frmKasa.grd_kasa do
    begin
      Cells[0,i] := aylar[i-1];
      Cells[i,0] := degerler[i-1];
    end;
  end;
end;

function KasaNo(Kasa_SAYAC:INTEGER):String;
var
a :String;
begin
  a := DataMod.GetParam(cns_kasa,'KOD_LENGTH',0);
  Result := DataMod.Kod_Format(Kasa_SAYAC,TRIM(DataMod.GetParam(cns_kasa,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_kasa,'KOD_LENGTH',0)));
end;

procedure TfrmKasa.qryKasaAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryKasa do
  begin
    FieldByName('KASA_SID').AsInteger := glb_SID;
    FieldByName('DOVKOD').AsString := glb_DEFCUR;                                                                                                                                                       
    FieldByName('KASA_KOD').AsString := KasaNo(Int64(DataMod.GET_SAYAC_NUM('KASA',True,False,0)));
  end;
  IB_Edit1.SetFocus;
end;

procedure TfrmKasa.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qryKasa.State in [dssInsert,dssEdit] then
  begin
    Application.MessageBox('Yaptýðýnýz deðiþiklikleri kaydetmeden veya iptal etmeden modulden çýkamazsýnýz!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else CanClose := True;
end;

procedure TfrmKasa.qryKasaBeforePost(IB_Dataset: TIB_Dataset);
var
  FuncDeger : String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qryKasa,'KASA','KASA_KOD,DOVKOD,ACIKLAMA','KASA_KOD');
  if  funcDeger<> '' then
  begin
    ShowMessage(funcDeger);
    Abort;
  end;
  if not DataMod.Post_Update('KASA',qryKASA.FieldByName('KASA_KOD').OldAsString,qryKASA.FieldByName('KASA_KOD').AsString,Nil) then Abort;
end;

procedure TfrmKasa.PageChanging(Sender: TObject; var AllowChange: Boolean);
begin
  case page.ActivePageIndex of
  0:
    begin
    end;
  1:
    begin
      qryHareket.Active := false;
    end;
  end;
end;

procedure TfrmKasa.PageChange(Sender: TObject);
begin
  case page.ActivePageIndex of
  0:
    begin
    end;
  1:
    begin
      with qryHareket do
      begin
        ParamByName('PRM_KASA_KOD').AsString := qryKasa.FieldByName('KASA_KOD').Asstring;
        ParamByName('PRM_CALISMA_YIL').AsInteger := StrToInt(Datamod.GetParam(0,'CALISMA_YIL',0));
        Active := true;
      end;
      data_ekle;
    end;
  end;
end;

procedure TfrmKasa.data_ekle;
var
  deger : boolean;
  satir,sutun:shortint;
begin
  qryHareket.First;
  deger := false;
  while not (qryHareket.Eof) do
  begin
    case (qryHareket.FieldByName('AY').AsInteger) of
    1:
      begin
        grd_kasa.Cells[1,1] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,1] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,1] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,1] := ALACAK;
        end;
        grd_kasa.Cells[4,1] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,1] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,1] = BORC) then
        begin
          grd_kasa.Cells[6,1] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,1] = ALACAK) then
        begin
          grd_kasa.Cells[6,1] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    2:
      begin
        grd_kasa.Cells[1,2] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,2] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,2] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,2] := ALACAK;
        end;
        grd_kasa.Cells[4,2] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,2] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,2] = BORC) then
        begin
          grd_kasa.Cells[6,2] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,2] = ALACAK) then
        begin
          grd_kasa.Cells[6,2] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    3:
      begin
        grd_kasa.Cells[1,3] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,3] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,3] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,3] := ALACAK;
        end;
        grd_kasa.Cells[4,3] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,3] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,3] = BORC) then
        begin
          grd_kasa.Cells[6,3] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,3] = ALACAK) then
        begin
          grd_kasa.Cells[6,3] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    4:
      begin
        grd_kasa.Cells[1,4] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,4] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
           grd_kasa.Cells[3,4] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,4] := ALACAK;
        end;
        grd_kasa.Cells[4,4] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,4] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,4] = BORC) then
        begin
          grd_kasa.Cells[6,4] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,4] = ALACAK) then
        begin
          grd_kasa.Cells[6,4] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    5:
      begin
        grd_kasa.Cells[1,5] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,5] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,5] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,5] := ALACAK;
        end;
        grd_kasa.Cells[4,5] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,5] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,5] = BORC) then
        begin
          grd_kasa.Cells[6,5] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,5] = ALACAK) then
        begin
          grd_kasa.Cells[6,5] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    6:
      begin
        grd_kasa.Cells[1,6] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,6] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,6] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,6] := ALACAK;
        end;
        grd_kasa.Cells[4,6] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,6] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,6] = BORC) then
        begin
          grd_kasa.Cells[6,6] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,6] = ALACAK) then
        begin
          grd_kasa.Cells[6,6] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    7:
      begin
        grd_kasa.Cells[1,7] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,7] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,7] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,7] := ALACAK;
        end;
        grd_kasa.Cells[4,7] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,7] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,7] = BORC) then
        begin
          grd_kasa.Cells[6,7] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,7] = ALACAK) then
        begin
          grd_kasa.Cells[6,7] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    8:
      begin
        grd_kasa.Cells[1,8] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,8] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,8] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,8] := ALACAK;
        end;
        grd_kasa.Cells[4,8] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,8] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,8] = BORC) then
        begin
          grd_kasa.Cells[6,8] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,8] = ALACAK) then
        begin
          grd_kasa.Cells[6,8] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    9:
      begin
        grd_kasa.Cells[1,9] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,9] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,9] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,9] := ALACAK;
        end;
        grd_kasa.Cells[4,9] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,9] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,9] = BORC) then
        begin
          grd_kasa.Cells[6,9] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,9] = ALACAK) then
        begin
          grd_kasa.Cells[6,9] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    10:
      begin
        grd_kasa.Cells[1,10] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,10] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,10] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,10] := ALACAK;
        end;
        grd_kasa.Cells[4,10] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,10] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,10] = BORC) then
        begin
          grd_kasa.Cells[6,10] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,10] = ALACAK) then
        begin
          grd_kasa.Cells[6,10] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    11:
      begin
        grd_kasa.Cells[1,11] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,11] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,11] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,11] := ALACAK;
        end;
        grd_kasa.Cells[4,11] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,11] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,11] = BORC) then
        begin
          grd_kasa.Cells[6,11] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,11] = ALACAK) then
        begin
          grd_kasa.Cells[6,11] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    12:
      begin
        grd_kasa.Cells[1,12] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC').AsCurrency);
        grd_kasa.Cells[2,12] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK').AsCurrency);
        if (qryHareket.FieldByName('BORC').AsCurrency > qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,12] := BORC;
        end;
        if (qryHareket.FieldByName('BORC').AsCurrency < qryHareket.FieldByName('ALACAK').AsCurrency) then
        begin
          grd_kasa.Cells[3,12] := ALACAK;
        end;
        grd_kasa.Cells[4,12] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency);
        grd_kasa.Cells[5,12] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        if (grd_kasa.Cells[3,12] = BORC) then
        begin
          grd_kasa.Cells[6,12] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('BORC_VPB').AsCurrency - qryHareket.FieldByName('ALACAK_VPB').AsCurrency);
        end;
        if (grd_kasa.Cells[3,12] = ALACAK) then
        begin
          grd_kasa.Cells[6,12] := FormatCurr(glb_DOV_FIELD_PF,qryHareket.FieldByName('ALACAK_VPB').AsCurrency - qryHareket.FieldByName('BORC_VPB').AsCurrency);
        end;
      end;
    end;
    qryHareket.Next;
    deger := True;
  end;
  if (deger=false) then
  begin
    for satir := 1 to 12 do
    for sutun := 1 to 6 do
    begin
      grd_kasa.Cells[sutun,satir] := '';
    end;
  end;
end;

procedure TfrmKasa.grd_kasaDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  i:byte;
begin
  Grd_Row := ARow;
  Grd_Col := ACol;
  Grid := grd_kasa;
  Grd_Rect := Rect;
  if ARow = 0 then Display(grd_kasa, grd_kasa.Cells[ACol, ARow], taCenter,Rect,'',8,[fsBold],clBlack,true);
  //if ACol = 0 then Display(grd_kasa, grd_kasa.Cells[ACol, ARow], taCenter);
  if ARow in [1..13] then Display(grd_kasa, grd_kasa.Cells[ACol, ARow], taRightJustify,Rect,'',8,[fsBold],clBlack,false);
  for i := 0 to 13 do
  begin
    if ((ACol=0) and (ARow=i)) then Display(grd_kasa, grd_kasa.Cells[ACol, ARow], taCenter,Rect,'',8,[fsBold],clBlack,true);
  end;
//ResizeStringGrid(grd_kasa);
end;

procedure TfrmKasa.dtsKasaStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    btnSil.Enabled := False;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
  end
  else
  begin
    btnYeni.Enabled:=True;
    if not ((ADataset.Eof) and (ADataset.Bof)) then
    begin
      Btn_Onceki.Enabled := True;
      Btn_Sonraki.Enabled := True;
      btnSil.Enabled := True
    end
    else
    begin
      Btn_Onceki.Enabled := False;
      Btn_Sonraki.Enabled := False;
      btnSil.Enabled := False;
    end;
    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmKasa.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmKasa);
end;

procedure TfrmKasa.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryKasa.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('KASA,',0,0,0,0,1,'KASA');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmKasa.btnIPTALClick(Sender: TObject);
begin
  qryKasa.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmKasa.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryKasa.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('KASA,',0,0,0,0,2,'KASA');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmKasa.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmKasa.btnAraClick(Sender: TObject);
var
  KASA_KOD,KASA_AD,DOVKOD:String;
begin
  if DataMod.LS_KASA(KASA_KOD,KASA_AD,DOVKOD) then Dataset_Open(KASA_KOD,1);
end;

procedure TfrmKasa.qryKasaBeforeDelete(IB_Dataset: TIB_Dataset);
var
  StrMesaj:String;
begin
  if DataMod.Delete_Control('KASA',qryKasa.FieldByName('KASA_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmKasa.btnYeniClick(Sender: TObject);
begin
  Dataset_Open('',0)
end;

procedure TfrmKasa.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmKasa.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;


procedure TfrmKasa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Page.ActivePageIndex = 0 Then
  begin
    if Shift = [ssCtrl] then
    begin
      case Key of
      83: //s kaydet
        begin
          if btnKAYDET.Enabled then btnKAYDETClick(Self);
        end; //83 end
      80: //p iptal
        begin
          if btnIptal.Enabled Then btnIptalClick(Self);
        end;
      46: // del delete
        begin
          if btnSIL.Enabled Then btnSILClick(self);
        end;
      end; // case end;
    end//Shift = [ssCtrl] then end
    else
    if Shift = [] then
    begin
      case Key of
      45: //ins kaydet
        begin
          if btnYeni.Enabled then btnYeniClick(Self);
        end;
      end;//acase end
    end; ///if Shift = [] then ENd
  end;
end;

procedure TfrmKasa.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmKasa.qryKasaAfterPost(IB_Dataset: TIB_Dataset);
var
  PSql : string;
begin
  if chkVarsayilan.Checked = True then
  begin
    with DataMod.qryGENEL do
    begin
      Active := False;
      SQL.Clear;
      PSql := 'UPDATE KASA SET VARSAYILAN = 0  WHERE KASA_KOD<> '+ chr (39)+ qryKasa.FieldByName('KASA_KOD').AsString + chr (39);
      SQL.Add(psql);
      Execute;
    end;
  end;
end;

function TfrmKasa.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmKasa.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmKasa.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmKasa.cboDOVKODEnter(Sender: TObject);
begin
  (Sender as TIB_ComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmKasa.cboDOVKODExit(Sender: TObject);
begin
  (Sender as TIB_ComboBox).Color := clWindow;
end;


procedure TfrmKasa.Geri_AL;
begin
     if qryKasa.State in [DssEdit,DssInsert] then qryKasa.Cancel;
     qryHareket.Close;
     qryKasa.Close;
end;

procedure TfrmKasa.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 KASA_KOD FROM KASA WHERE KASA_KOD>:KASA_KOD ORDER BY KASA_KOD';
     qryDeg1.ParamByName('KASA_KOD').AsString:=qryKasa.FieldByName('KASA_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('KASA_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('KASA_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure TfrmKasa.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 KASA_KOD FROM KASA WHERE KASA_KOD<:KASA_KOD ORDER BY KASA_KOD DESC';
     qryDeg1.ParamByName('KASA_KOD').AsString:=qryKasa.FieldByName('KASA_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('KASA_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('KASA_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

end.
