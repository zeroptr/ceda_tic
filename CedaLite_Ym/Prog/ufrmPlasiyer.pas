unit ufrmPlasiyer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, StdCtrls, Mask, IB_Controls, IB_UpdateBar, ExtCtrls,
  IB_NavigationBar, Buttons,Variants, IB_Grid;

type
  TfrmPlasiyer = class(TForm)
    qryPlasiyer: TIB_Query;
    dtsPlasiyer: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit8: TIB_Edit;
    IB_Edit9: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    Panel1: TPanel;
    btnCikis: TBitBtn;
    btnAra: TBitBtn;
    IB_Currency1: TIB_Currency;
    IB_Currency2: TIB_Currency;
    IB_Currency3: TIB_Currency;
    IB_Currency4: TIB_Currency;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    IB_CheckBox1: TIB_CheckBox;
    cboDOVKOD: TIB_ComboBox;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;PLASIYER_KOD:String;ISLEM_TIP:Byte);
    procedure DataSet_Open(PLASIYER_KOD:String;ISLEM_TIP:Byte);
    function PlasiyerNo(Plasiyer_SAYAC:INTEGER):String;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryPlasiyerAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qryPlasiyerBeforePost(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure qryPlasiyerBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure dtsPlasiyerStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cboDOVKODEnter(Sender: TObject);
    procedure cboDOVKODExit(Sender: TObject);
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
  const cns_plasiyer = 10;
var
  frmPlasiyer: TfrmPlasiyer;

implementation

uses unDataMod, main, unFunc, unLogger;

{$R *.DFM}

{ TfrmPlasiyer }
procedure TfrmPlasiyer.Form_Open(Menu:Boolean;PLASIYER_KOD:String;ISLEM_TIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_plasiyer,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM_TIP = 1) and (not local_can_update)) then
    begin
      Application.MessageBox('Bu modülde yeni proje tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
  if not MainForm.FindChildFrm(Application,'frmPlasiyer') then
  begin
    Application.CreateForm(TfrmPlasiyer, frmPlasiyer);
    with frmPlasiyer do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      DataSet_Open(PLASIYER_KOD,ISLEM_TIP);
    end;
  end
  else
  begin
    Application.MessageBox('Plasiyer formu açýk.','Dikkat',MB_ICONINFORMATION);
    Exit;
  end;
////////////////////////////////////////////////////////////////////////////////
end;

procedure TfrmPlasiyer.DataSet_Open(PLASIYER_KOD:String;ISLEM_TIP:Byte);
begin
  with qryPlasiyer do
  begin
    Active := False;
    ParamByName('PRM_PLASIYER_KOD').AsString := PLASIYER_KOD;
    Active := True;
  end;
  case ISLEM_TIP of
  0://edit
    begin
      qryPlasiyer.Edit;
    end;
  1://insert
    begin
      qryPlasiyer.Insert;
    end;
  end;
end;


procedure TfrmPlasiyer.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmPlasiyer.qryPlasiyerAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryPlasiyer do
  begin
    FieldByName('PLASIYER_SID').AsInteger := glb_SID;
    FieldByName('PLASIYER_KOD').AsString := PlasiyerNo(Int64(DataMod.GET_SAYAC_NUM('PLASIYER',True,False,0)));
    FieldByName('FIRMA_ID').AsInteger := 0;
    FieldByName('BORC').AsCurrency := 0;
    FieldByName('BORC_VPB').AsCurrency := 0;
    FieldByName('ALACAK').AsCurrency := 0;
    FieldByName('ALACAK_VPB').AsCurrency := 0;
    FieldByName('DOVKOD').AsString := glb_DEFCUR;
  end;
  IB_Edit1.SetFocus;  
end;

function TfrmPlasiyer.PlasiyerNo(Plasiyer_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(Plasiyer_SAYAC,TRIM(DataMod.GetParam(cns_plasiyer ,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_plasiyer,'KOD_LENGTH',0)));
end;

procedure TfrmPlasiyer.qryPlasiyerBeforePost(IB_Dataset: TIB_Dataset);
var
  FuncDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qryPlasiyer,'PLASIYER','PLASIYER_KOD,ADISOY','PLASIYER_KOD');
  if  funcDeger<> '' Then
  begin
    ShowMessage(funcDeger);
    Abort;
  end;
  if not DataMod.Post_Update('PLASIYER',qryPlasiyer.FieldByName('PLASIYER_KOD').OldAsString,qryPlasiyer.FieldByName('PLASIYER_KOD').AsString,Nil) then Abort;
end;

procedure TfrmPlasiyer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qryPlasiyer.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qryPlasiyer.Active := False;
  end;
end;

procedure TfrmPlasiyer.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmPlasiyer.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmPlasiyer.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmPlasiyer.IB_Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmPlasiyer.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmPlasiyer);
  with frmPlasiyer.qryPlasiyer do
  begin
    FieldByName('BORC').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ALACAK').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('ALACAK_VPB').DisplayFormat := glb_VPB_FIELD_PF;
  end;
end;

procedure TfrmPlasiyer.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPlasiyer.qryPlasiyerBeforeDelete(IB_Dataset: TIB_Dataset);
var
  StrMesaj:String;
begin
  if DataMod.Delete_Control('PLASIYER',qryPlasiyer.FieldByName('PLASIYER_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmPlasiyer.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPlasiyer.btnAraClick(Sender: TObject);
var
  Plasiyer_KOD,Plasiyer_AD:String;
begin
  if DataMod.LS_Plasiyer(Plasiyer_KOD,Plasiyer_AD,0) then
  DataSet_Open(Plasiyer_KOD,0);
end;

procedure TfrmPlasiyer.dtsPlasiyerStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
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

procedure TfrmPlasiyer.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni proje tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataSet_Open('',1);
end;

procedure TfrmPlasiyer.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryPlasiyer.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('PLASIYER,',0,0,0,0,1,'PLASIYER');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmPlasiyer.btnIPTALClick(Sender: TObject);
begin
  qryPlasiyer.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmPlasiyer.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryPlasiyer.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('PLASIYER,',0,0,0,0,2,'PLASIYER');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmPlasiyer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

function TfrmPlasiyer.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmPlasiyer.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmPlasiyer.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmPlasiyer.cboDOVKODEnter(Sender: TObject);
begin
  cboDOVKOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmPlasiyer.cboDOVKODExit(Sender: TObject);
begin
  cboDOVKOD.Color := clWindow;
end;


procedure TfrmPlasiyer.Geri_AL;
begin
     if qryPlasiyer.State in [DssEdit,DssInsert] then qryPlasiyer.Cancel;
     qryPlasiyer.Close;
end;

procedure TfrmPlasiyer.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 PLASIYER_KOD FROM PLASIYER WHERE PLASIYER_KOD>:PLASIYER_KOD ORDER BY PLASIYER_KOD';
     qryDeg1.ParamByName('PLASIYER_KOD').AsString:=qryPlasiyer.FieldByName('PLASIYER_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('PLASIYER_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('PLASIYER_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure TfrmPlasiyer.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 PLASIYER_KOD FROM PLASIYER WHERE PLASIYER_KOD<:PLASIYER_KOD ORDER BY PLASIYER_KOD DESC';
     qryDeg1.ParamByName('PLASIYER_KOD').AsString:=qryPlasiyer.FieldByName('PLASIYER_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('PLASIYER_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('PLASIYER_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);


end;

end.
