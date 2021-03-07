unit ufrmProje;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Buttons, DBCtrls, ExtCtrls, StdCtrls, IB_Components, Mask,
  IB_Controls, IB_UpdateBar, IB_NavigationBar, Grids, IB_Grid, ComCtrls,Variants ;

type
  TfrmProje = class(TForm)
    qryPROJE: TIB_Query;
    dtsProje: TIB_DataSource;
    edt_Proje_Kod: TIB_Edit;
    edt_Proje_Ad: TIB_Edit;
    IB_Edit3: TIB_Edit;
    Panel2: TPanel;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    IB_Currency1: TIB_Currency;
    IB_Currency2: TIB_Currency;
    IB_Currency3: TIB_Currency;
    IB_Currency4: TIB_Currency;
    btnSil: TButton;
    btnIPTAL: TButton;
    btnKaydet: TButton;
    btnYeni: TBitBtn;
    IB_CheckBox1: TIB_CheckBox;
    cboDOVKOD: TIB_ComboBox;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
////////////////////////////////////////////////////////////////////////////////
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    function ProjeNo(PROJE_ID:INTEGER):String;
    procedure Form_Open(Menu:Boolean;PROJE_KOD:String;ISLEM_TIP:Byte);
    procedure DataSet_Open(PROJE_KOD:String;ISLEM_TIP:Byte);
////////////////////////////////////////////////////////////////////////////////
    procedure qryPROJEAfterInsert(IB_Dataset: TIB_Dataset);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edt_Proje_KodKeyPress(Sender: TObject; var Key: Char);
    procedure qryPROJEBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edt_Proje_KodEnter(Sender: TObject);
    procedure edt_Proje_KodExit(Sender: TObject);
    procedure IB_Edit3Exit(Sender: TObject);
    procedure edt_Proje_AdExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure dtsProjeStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure qryPROJEBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cboDOVKODEnter(Sender: TObject);
    procedure cboDOVKODExit(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
    procedure Geri_AL;
  public
    { Public declarations }
  end;

  const cns_proje = 9;

var
  frmProje: TfrmProje;

implementation
uses unDataMod,unFunc,Main, unLogger;
{$R *.DFM}
procedure TfrmProje.Form_Open(Menu: Boolean;PROJE_KOD:String;ISLEM_TIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_proje,local_can_update,local_can_delete) then
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
  if not MainForm.FindChildFrm(Application,'frmProje') then
  begin
    Application.CreateForm(TfrmProje, frmProje);
    with frmProje do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      DataSet_Open(PROJE_KOD,ISLEM_TIP);
    end;
  end
  else
  begin
    Application.MessageBox('Proje formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
////////////////////////////////////////////////////////////////////////////////
end;

procedure TfrmProje.DataSet_Open(PROJE_KOD:String;ISLEM_TIP:Byte);
begin
  with qryPROJE do
  begin
    Active := False;
    ParamByName('PRM_PROJE_KOD').AsString := PROJE_KOD;
    Active := True;
  end;
  case ISLEM_TIP of
  0://edit
    begin
      qryPROJE.Edit;
    end;
  1://insert
    begin
      qryPROJE.Insert;
    end;
  end;
end;

procedure TfrmProje.qryPROJEAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with IB_Dataset do
  begin
    FieldByName('PROJE_SID').AsInteger := glb_SID;
    FieldByName('PROJE_KOD').AsString := ProjeNo(Int64(DataMod.GET_SAYAC_NUM('PROJE',True,False,0)));
    FieldByName('DOVKOD').AsString := glb_DEFCUR;
    FieldByName('ALACAK').AsCurrency := 0;
    FieldByName('BORC').AsCurrency := 0;
    FieldByName('ALACAK_VPB').AsCurrency := 0;
    FieldByName('BORC_VPB').AsCurrency := 0;
    FieldByName('KAPANDI').AsSmallint := 0;
  end;
  edt_Proje_Kod.SetFocus;
end;

procedure TfrmProje.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmProje.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qryPROJE.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qryPROJE.Active := False;
  end;
end;


procedure TfrmProje.edt_Proje_KodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmProje.qryPROJEBeforeDelete(IB_Dataset: TIB_Dataset);
var
  StrMesaj:String;
begin
  if DataMod.Delete_Control('PROJE',qryPROJE.FieldByName('PROJE_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmProje.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmProje.edt_Proje_KodEnter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmProje.edt_Proje_KodExit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmProje.IB_Edit3Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmProje.edt_Proje_AdExit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmProje.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

function TfrmProje.ProjeNo(PROJE_ID:INTEGER):String;
begin
  Result := DataMod.Kod_Format(PROJE_ID,TRIM(DataMod.GetParam(cns_proje,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_proje,'KOD_LENGTH',0)));
end;

procedure TfrmProje.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmProje);
  with frmProje.qryPROJE do
  begin
    FieldByName('BORC').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ALACAK').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('ALACAK_VPB').DisplayFormat := glb_VPB_FIELD_PF;
  end;
end;

procedure TfrmProje.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProje.btnAraClick(Sender: TObject);
var
  PROJE_KOD,PROJE_AD : String;
begin
  if DataMod.LS_Proje(PROJE_KOD,PROJE_AD,0) then
  begin
    DataSet_Open(PROJE_KOD,0);
  end;
end;

procedure TfrmProje.dtsProjeStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) Then
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

procedure TfrmProje.qryPROJEBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qryPROJE,'PROJE','PROJE_KOD,PROJE_AD','PROJE_KOD');
  if  funcDeger<>'' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('PROJE',qryPROJE.FieldByName('PROJE_KOD').OldAsString,qryPROJE.FieldByName('PROJE_KOD').AsString,Nil) then Abort;
end;

procedure TfrmProje.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni proje tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataSet_Open('',1);
end;

procedure TfrmProje.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryPROJE.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('PROJE,',0,0,0,0,1,'PROJE');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmProje.btnIPTALClick(Sender: TObject);
begin
  qryPROJE.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmProje.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryPROJE.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('PROJE,',0,0,0,0,2,'PROJE');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmProje.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
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

function TfrmProje.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmProje.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmProje.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmProje.cboDOVKODEnter(Sender: TObject);
begin
  cboDOVKOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmProje.cboDOVKODExit(Sender: TObject);
begin
  cboDOVKOD.Color := clWindow;
end;



procedure TfrmProje.Geri_AL;
begin
     if qryPROJE.State in [DssEdit,DssInsert] then qryPROJE.Cancel;
     qryPROJE.Close;
end;


procedure TfrmProje.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 PROJE_KOD FROM PROJE WHERE PROJE_KOD>:PROJE_KOD ORDER BY PROJE_KOD';
     qryDeg1.ParamByName('PROJE_KOD').AsString:=qryPROJE.FieldByName('PROJE_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('PROJE_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('PROJE_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);


end;

procedure TfrmProje.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 PROJE_KOD FROM PROJE WHERE PROJE_KOD<:PROJE_KOD ORDER BY PROJE_KOD DESC';
     qryDeg1.ParamByName('PROJE_KOD').AsString:=qryPROJE.FieldByName('PROJE_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('PROJE_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('PROJE_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

end.








