unit ufrmArac_Marka;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, IB_Components, Buttons, StdCtrls, Mask, IB_Controls,Variants,
  Grids, IB_Grid, ComCtrls;

type
  TfrmArac_Marka = class(TForm)
    Panel1: TPanel;
    btnCikis: TBitBtn;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    ds_Marka: TIB_DataSource;
    qry_Marka: TIB_Query;
    Marka_Tip: TIB_DataSource;
    qry_Marka_Tip: TIB_Query;
    Pg_Marka: TPageControl;
    Tab_Marka: TTabSheet;
    Tab_Marka_Tip: TTabSheet;
    Grd_Marka: TIB_Grid;
    Grd_Marka_Tip: TIB_Grid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qry_MarkaAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure qry_MarkaBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure dts_MarkaStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure qry_MarkaBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;MARKA_KOD:String;ISLEM_TIP:Byte);
    procedure DataSet_Open(MARKA_KOD:String;ISLEM_TIP:Byte);
    function Form_Before_Post:Boolean;
    function Form_Before_Post_Tip: Boolean;
    function Form_Before_Delete:Boolean;
    function Form_Before_Delete_Tip: Boolean;
    procedure qry_MarkaAfterScroll(IB_Dataset: TIB_Dataset);
    procedure qry_Marka_TipAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qry_Marka_TipBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure Pg_MarkaChanging(Sender: TObject; var AllowChange: Boolean);
    procedure Grd_MarkaKeyPress(Sender: TObject; var Key: Char);
    procedure Grd_Marka_TipKeyPress(Sender: TObject; var Key: Char);
    procedure qry_Marka_TipBeforePost(IB_Dataset: TIB_Dataset);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;

  public
    { Public declarations }
  end;

  const cns_marka = 63;

var
  frmArac_Marka: TfrmArac_Marka;

implementation

uses unDataMod,Main,unFunc, unLogger;

{$R *.DFM}

procedure TfrmArac_Marka.Form_Open(Menu:Boolean;MARKA_KOD:String;ISLEM_TIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_marka,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM_TIP = 1) and (not local_can_update)) then
    begin
      Application.MessageBox('Bu modülde yeni Marka tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
  if not MainForm.FindChildFrm(Application, 'frmArac_Marka') then
  begin
    Application.CreateForm(TfrmArac_Marka, frmArac_Marka);

    with frmArac_Marka do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      DataSet_Open(MARKA_KOD,ISLEM_TIP);
      frmArac_Marka.Pg_Marka.ActivePage:=frmArac_Marka.Tab_Marka;      
    end;
  end
  else
  begin
    Application.MessageBox('Araç Marka Taným formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
end;

procedure TfrmArac_Marka.DataSet_Open(MARKA_KOD:String;ISLEM_TIP:Byte);
begin
  with qry_Marka do
  begin
    Active := False;
    //Where MARKA_KOD=:PRM_MARKA_KOD
   // ParamByName('PRM_MARKA_KOD').AsString := MARKA_KOD;
    Active := True;
  end;
  case ISLEM_TIP of
  0://edit
    begin
     // qry_Marka.Edit;
    end;
  1://insert
    begin
    //  qry_Marka.Insert;
    end;
  end;
end;

procedure TfrmArac_Marka.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  dmLOGGER.dbaMain_CancelMonitoring;
  Action := caFree;
end;

procedure TfrmArac_Marka.qry_MarkaAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qry_Marka do
  begin
    FieldByName('MARKA_SID').AsInteger := glb_SID;
  end;
end;

procedure TfrmArac_Marka.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmArac_Marka.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmArac_Marka.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmArac_Marka.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmArac_Marka.qry_MarkaBeforeDelete(IB_Dataset: TIB_Dataset);
var
 StrMesaj:String;
begin
  if DataMod.Delete_Control('SRV_ARAC_MARKA',qry_Marka.FieldByName('MARKA_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmArac_Marka.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (qry_Marka.State in [dssInsert,dssEdit]) or
  (qry_Marka_Tip.State in [dssInsert,dssEdit])
  Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qry_Marka.Active := False;
    qry_Marka_Tip.Active := False;
  end;
end;

procedure TfrmArac_Marka.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmArac_Marka);
end;

procedure TfrmArac_Marka.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmArac_Marka.dts_MarkaStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    btnSil.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
  end
  else
  begin
    btnYeni.Enabled:=True;
    if not ((ADataset.Eof) and (ADataset.Bof)) then btnSil.Enabled := True
    else btnSil.Enabled := False;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmArac_Marka.qry_MarkaBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qry_Marka,'SRV_ARAC_MARKA','MARKA_KOD,MARKA_SID','MARKA_KOD');
  if funcDeger<>'' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('SRV_ARAC_MARKA',qry_Marka.FieldByName('MARKA_KOD').OldAsString,qry_Marka.FieldByName('MARKA_KOD').AsString,Nil) then Abort;
end;

procedure TfrmArac_Marka.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni marka tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  //DataSet_Open('',1);
  if Pg_Marka.ActivePage=Tab_Marka then
  qry_Marka.Append;

  if Pg_Marka.ActivePage=Tab_Marka_Tip then
  qry_Marka_Tip.Append;

end;

procedure TfrmArac_Marka.btnKaydetClick(Sender: TObject);
begin
  if Pg_Marka.ActivePage=Tab_Marka then
  begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Marka.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARAC_MARKA,',0,0,0,0,1,'SRV_ARAC_MARKA');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
  end;

  if Pg_Marka.ActivePage=Tab_Marka_Tip then
  begin
  try
    if not Form_Before_Post_Tip then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Marka_Tip.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARAC_MARKA_TIP,',0,0,0,0,1,'SRV_ARAC_MARKA_TIP');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
  end;

end;

procedure TfrmArac_Marka.btnIPTALClick(Sender: TObject);
begin
  if Pg_Marka.ActivePage=Tab_Marka then
  qry_Marka.Cancel;

  if Pg_Marka.ActivePage=Tab_Marka_Tip then
  qry_Marka_Tip.Cancel;
end;

procedure TfrmArac_Marka.btnSilClick(Sender: TObject);
begin
  if Pg_Marka.ActivePage=Tab_Marka then
  begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Marka.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARAC_MARKA,',0,0,0,0,2,'SRV_ARAC_MARKA');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
  end;

  if Pg_Marka.ActivePage=Tab_Marka_Tip then
  begin
  try
    if not Form_Before_Delete_Tip then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Marka_Tip.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARAC_MARKA_TIP,',0,0,0,0,2,'SRV_ARAC_MARKA_TIP');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
  end;
end;

procedure TfrmArac_Marka.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

function TfrmArac_Marka.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmArac_Marka.Form_Before_Delete_Tip: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;


function TfrmArac_Marka.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if Trim(qry_Marka.FieldByName('MARKA_KOD').AsString)='' then
  begin
    Application.MessageBox('Araç Markasýný Giriniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;


function TfrmArac_Marka.Form_Before_Post_Tip: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if Trim(qry_Marka_Tip.FieldByName('MARKA_KOD').AsString)='' then
  begin
    Application.MessageBox('Araç Markasýný Giriniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if Trim(qry_Marka_Tip.FieldByName('MARKA_TIP_KOD').AsString)='' then
  begin
    Application.MessageBox('Araç Marka Tipini Giriniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmArac_Marka.qry_MarkaAfterScroll(IB_Dataset: TIB_Dataset);
begin
  with qry_Marka_Tip do
  begin
    Active:=False;
    ParamByName('PRM_MARKA_KOD').AsString := qry_Marka.FieldByName('MARKA_KOD').AsString;
    Active:=True;
  end;
end;

procedure TfrmArac_Marka.qry_Marka_TipAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qry_Marka_Tip do
  begin
    FieldByName('MARKA_TIP_SID').AsInteger := glb_SID;
    FieldByName('MARKA_KOD').AsString := qry_Marka.FieldByName('MARKA_KOD').AsString;
  end;
end;

procedure TfrmArac_Marka.qry_Marka_TipBeforeDelete(IB_Dataset: TIB_Dataset);
var
 StrMesaj:String;
begin
  if DataMod.Delete_Control('SRV_ARAC_MARKA_TIP',qry_Marka_Tip.FieldByName('MARKA_TIP_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmArac_Marka.Pg_MarkaChanging(Sender: TObject; var AllowChange: Boolean);
begin
     if Pg_Marka.ActivePage=Tab_Marka then
     begin
          if qry_Marka.State in [dssEdit,dssInsert] Then
          begin
            Application.MessageBox('Marka bilgilerini kaydediniz.','Dikkat',MB_ICONWARNING);
            AllowChange := False;
          end;

          if Trim(qry_Marka.FieldByName('MARKA_KOD').AsString)='' then
          begin
            Application.MessageBox('Marka bilgilerini kaydediniz.','Dikkat',MB_ICONWARNING);
            AllowChange := False;
          end;

     end;

     if Pg_Marka.ActivePage=Tab_Marka_Tip then
     begin
          if qry_Marka_Tip.State in [dssEdit,dssInsert] Then
          begin
            Application.MessageBox('Marka Tip bilgilerini kaydediniz.','Dikkat',MB_ICONWARNING);
            AllowChange := False;
          end
     end;
end;

procedure TfrmArac_Marka.Grd_MarkaKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmArac_Marka.Grd_Marka_TipKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmArac_Marka.qry_Marka_TipBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qry_Marka_Tip,'SRV_ARAC_MARKA_TIP','MARKA_TIP_KOD,MARKA_KOD,MARKA_TIP_SID','MARKA_TIP_KOD');
  if funcDeger<>'' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('SRV_ARAC_MARKA_TIP',qry_Marka_Tip.FieldByName('MARKA_TIP_KOD').OldAsString,qry_Marka_Tip.FieldByName('MARKA_TIP_KOD').AsString,Nil) then Abort;
end;

end.
