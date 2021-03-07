unit ufrmPersonel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, StdCtrls, Mask, IB_Controls, IB_UpdateBar, ExtCtrls,
  IB_NavigationBar, Buttons,Variants, IB_Grid;

type
  TfrmPersonel = class(TForm)
    qryPersonel: TIB_Query;
    dtsPersonel: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit8: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    Panel1: TPanel;
    btnCikis: TBitBtn;
    btnAra: TBitBtn;
    IB_Currency1: TIB_Currency;
    IB_Currency3: TIB_Currency;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    IB_Date1: TIB_Date;
    IB_Date2: TIB_Date;
    IB_Date3: TIB_Date;
    IB_Edit3: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit15: TIB_Edit;
    IB_CheckBox1: TIB_CheckBox;
    IB_ComboBox3: TIB_ComboBox;
    IB_ComboBox1: TIB_ComboBox;
    IB_ComboBox2: TIB_ComboBox;
    IB_Date4: TIB_Date;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;Personel_KOD:String;ISLEM_TIP:Byte);
    procedure DataSet_Open(Personel_KOD:String;ISLEM_TIP:Byte);
    function PersonelNo(Personel_SAYAC:INTEGER):String;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryPersonelAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qryPersonelBeforePost(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure qryPersonelBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure dtsPersonelStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
  private

    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
    procedure Geri_AL;

  public
    { Public declarations }
  end;

  const cns_Personel = 35;

var
  frmPersonel: TfrmPersonel;

implementation

uses unDataMod, main, unFunc, unLogger;

{$R *.DFM}

procedure TfrmPersonel.Form_Open(Menu:Boolean;Personel_KOD:String;ISLEM_TIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Personel,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM_TIP = 1) and (not local_can_update)) then
    begin
      Application.MessageBox('Bu modülde yeni Personel tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
  if not MainForm.FindChildFrm(Application,'frmPersonel') then
  begin
    Application.CreateForm(TfrmPersonel, frmPersonel);
    with frmPersonel do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      DataSet_Open(Personel_KOD,ISLEM_TIP);
    end;
  end
  else
  begin
    Application.MessageBox('Personel formu açýk.','Dikkat',MB_ICONINFORMATION);
    Exit;
  end;
////////////////////////////////////////////////////////////////////////////////
end;

procedure TfrmPersonel.DataSet_Open(Personel_KOD:String;ISLEM_TIP:Byte);
begin
  with qryPersonel do
  begin
    Active := False;
    ParamByName('PRM_PERSONEL_KOD').AsString := Personel_KOD;
    Active := True;
    IB_Edit1.SetFocus;
  end;
  case ISLEM_TIP of
  0://edit
    begin
      qryPersonel.Edit;
    end;
  1://insert
    begin
      qryPersonel.Insert;
    end;
  end;
end;


procedure TfrmPersonel.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmPersonel.qryPersonelAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryPersonel do
  begin
    FieldByName('PERSONEL_KOD').AsString := PersonelNo(Int64(DataMod.GET_SAYAC_NUM('PERSONEL',True,False,0)));
    FieldByName('PERSONEL_SID').AsInteger := glb_SID;
    FieldByName('BORC').AsCurrency := 0;
    FieldByName('ALACAK').AsCurrency := 0;
    FieldByName('LISTEDEN_CIKAR').AsInteger := 0;
    FieldByName('VERGI_KARNE_TARIH').AsDATE:= DataMod.GET_SERVER_DATE;
    //FieldByName('CIKIC_TARIH').AsDATE:= DataMod.GET_SERVER_DATE;
    FieldByName('GIRIS_TARIH').AsDATE:= DataMod.GET_SERVER_DATE;
    FieldByName('DOGUM_TARIH').AsDATE:= DataMod.GET_SERVER_DATE;
    FieldByName('DEVREDEN_BORC').AsFloat:= 0;
    FieldByName('DEVREDEN_ALACAK').AsFloat:= 0;
  end;
  IB_Edit1.SetFocus;  
end;

function TfrmPersonel.PersonelNo(Personel_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(Personel_SAYAC,TRIM(DataMod.GetParam(cns_Personel ,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_Personel,'KOD_LENGTH',0)));
end;

procedure TfrmPersonel.qryPersonelBeforePost(IB_Dataset: TIB_Dataset);
var
  FuncDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qryPersonel,'PERSONEL','PERSONEL_KOD,ADI_SOYADI','PERSONEL_KOD');
  if  funcDeger<> '' Then
  begin
    ShowMessage(funcDeger);
    Abort;
  end;
  if not DataMod.Post_Update('PERSONEL',qryPersonel.FieldByName('PERSONEL_KOD').OldAsString,qryPersonel.FieldByName('PERSONEL_KOD').AsString,Nil) then Abort;
end;

procedure TfrmPersonel.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qryPersonel.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qryPersonel.Active := False;
  end;
end;

procedure TfrmPersonel.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmPersonel.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmPersonel.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmPersonel.IB_Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmPersonel.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmPersonel);
  with frmPersonel.qryPersonel do
  begin
    FieldByName('BORC').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ALACAK').DisplayFormat := glb_DOV_FIELD_PF;
  end;
end;

procedure TfrmPersonel.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPersonel.qryPersonelBeforeDelete(IB_Dataset: TIB_Dataset);
var
  StrMesaj:String;
begin
  if DataMod.Delete_Control('PERSONEL',qryPersonel.FieldByName('PERSONEL_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmPersonel.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPersonel.btnAraClick(Sender: TObject);
var
  Personel_KOD,Personel_AD:String;
begin
  if DataMod.LS_Personel(Personel_KOD,Personel_AD) then
  DataSet_Open(Personel_KOD,0);
end;

procedure TfrmPersonel.dtsPersonelStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
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
      btnSil.Enabled := True;
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

procedure TfrmPersonel.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni Personel tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataSet_Open('',1);
end;

procedure TfrmPersonel.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryPersonel.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('PERSONEL,',0,0,0,0,1,'PERSONEL');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmPersonel.btnIPTALClick(Sender: TObject);
begin
  qryPersonel.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmPersonel.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryPersonel.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('PERSONEL,',0,0,0,0,2,'PERSONEL');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmPersonel.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
  begin
    case Key of
    83: //s kaydet
      begin
        if btnKAYDET.Enabled Then btnKAYDETClick(Self);
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
    VK_ESCAPE: if btnCikis.Enabled then Close;
    end;//acase end
  end; ///if Shift = [] then ENd
end;

function TfrmPersonel.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmPersonel.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmPersonel.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;


procedure TfrmPersonel.Geri_AL;
begin
     if qryPersonel.State in [DssEdit,DssInsert] then qryPersonel.Cancel;
     qryPersonel.Close;
end;
procedure TfrmPersonel.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 PERSONEL_KOD FROM PERSONEL WHERE PERSONEL_KOD>:PERSONEL_KOD ORDER BY PERSONEL_KOD';
     qryDeg1.ParamByName('PERSONEL_KOD').AsString:=qryPersonel.FieldByName('PERSONEL_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('PERSONEL_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('PERSONEL_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,0);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;

procedure TfrmPersonel.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 PERSONEL_KOD FROM PERSONEL WHERE PERSONEL_KOD<:PERSONEL_KOD ORDER BY PERSONEL_KOD DESC';
     qryDeg1.ParamByName('PERSONEL_KOD').AsString:=qryPersonel.FieldByName('PERSONEL_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('PERSONEL_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('PERSONEL_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,0);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;

end.
