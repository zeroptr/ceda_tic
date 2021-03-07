unit ufrmUrunGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, IBODataset, StdCtrls, DBCtrls, ExtCtrls, Mask, Buttons, IB_Components,
  IB_Controls, IB_Grid, Grids;

type
  TfrmUrunGroup = class(TForm)
    Panel1: TPanel;
    qryUrun_Grup: TIB_Query;
    dtsUrun_Grup: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Memo1: TIB_Memo;
    IB_Edit3: TIB_Edit;
    btnCikis: TBitBtn;
    btnAra: TBitBtn;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    cboDOVKOD: TIB_ComboBox;
    grdCGROUP: TIB_Grid;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    IB_Grid1: TIB_Grid;
    IB_Query1: TIB_Query;
    IB_DataSource1: TIB_DataSource;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    IB_Grid2: TIB_Grid;
    IB_Query2: TIB_Query;
    IB_DataSource2: TIB_DataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DBEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure qryUrun_GrupBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure qryUrun_GrupAfterInsert(IB_Dataset: TIB_Dataset);
    function Form_Open(Menu: Boolean): Boolean;
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Memo1Enter(Sender: TObject);
    procedure IB_Memo1Exit(Sender: TObject);
    Function Urun_GroupNo(Urun_Group_SAYAC:INTEGER):String;
    procedure btnAraClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure dtsUrun_GrupStateChanged(Sender: TIB_DataSource;      ADataset: TIB_Dataset);
    procedure qryUrun_GrupBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure qryUrun_GrupAfterScroll(IB_Dataset: TIB_Dataset);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
  end;

  const cns_urun_grup = 7 ;
var
  frmUrunGroup: TfrmUrunGroup;

implementation
uses unDataMod,unFunc, main, unLogger;
{$R *.DFM}

function TfrmUrunGroup.Form_Open(Menu: Boolean): Boolean;
var
  local_can_update,local_can_delete : Boolean;
begin
  Result := False;
  if not DataMod.Modul_Hak(cns_urun_grup,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if Menu=True Then
    begin
      if MainForm.FindChildFrm( Application, 'frmUrunGroup') = False  then
      begin
        Application.CreateForm(TfrmUrunGroup, frmUrunGroup);
      end;
      with frmUrunGroup do
      begin
        qryUrun_Grup.Active := True;
        IB_Query1.Active := True;
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;
      end;
    end
    else
    begin
      Application.CreateForm(TfrmUrunGroup, frmUrunGroup);
      with frmUrunGroup do
      begin
        FormStyle := fsNormal;
        Visible := False;
        qryUrun_Grup.Active := True;
        IB_Query1.Active := True;
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;
        ShowModal;
        qryUrun_Grup.Active := False;
        IB_Query1.Active := False;
      end;
    end;
    Result := True;
  end;
end;

procedure TfrmUrunGroup.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmUrunGroup.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
  qryUrun_Grup.Active := True;
end;

procedure TfrmUrunGroup.DBEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmUrunGroup.DBEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmUrunGroup.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if qryUrun_Grup.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qryUrun_Grup.Active := False;
    qryUrun_Grup.Active := False;
  end;
end;

procedure TfrmUrunGroup.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmUrunGroup.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmUrunGroup.qryUrun_GrupBeforeDelete(IB_Dataset: TIB_Dataset);
begin
  if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
end;

procedure TfrmUrunGroup.qryUrun_GrupAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryUrun_Grup do
  begin
    FieldByName('URUN_GRUP_SID').AsInteger := glb_SID;
    FieldByName('URUN_GRUP_KOD').AsString := Urun_GroupNo(Int64(DataMod.GET_SAYAC_NUM('URUN_GRUP',True,False,0)));
    FieldByName('DOVKOD').AsString := glb_DEFCUR;
  end;
  IB_Edit1.SetFocus;  
end;

procedure TfrmUrunGroup.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmUrunGroup.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmUrunGroup.IB_Memo1Enter(Sender: TObject);
begin
  IB_Memo1.Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrunGroup.IB_Memo1Exit(Sender: TObject);
begin
  IB_Memo1.Color := clWindow;
end;

function TfrmUrunGroup.Urun_GroupNo(Urun_Group_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(Urun_Group_SAYAC,TRIM(DataMod.GetParam(cns_urun_grup,'U_GR_PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_urun_grup,'U_GR_KOD_LENGTH',0)));
end;


procedure TfrmUrunGroup.btnAraClick(Sender: TObject);
var
 URUN_GRUP_KOD,URUN_GRUP_AD:String;
begin
  if DataMod.LS_UrunGroup(URUN_GRUP_KOD,URUN_GRUP_AD) then
  begin
    qryUrun_Grup.Locate('URUN_GRUP_KOD',URUN_GRUP_KOD,[LopCaseINSensitive]);
  end;
end;

procedure TfrmUrunGroup.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUrunGroup.dtsUrun_GrupStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
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
    if not ((ADataset.Eof) and (ADataset.Bof)) then btnSil.Enabled := True
    else btnSil.Enabled := False;
    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmUrunGroup.qryUrun_GrupBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qryUrun_Grup,'URUN_GRUP','URUN_GRUP_KOD,UGADI','URUN_GRUP_KOD');
  if  funcDeger <> '' then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('URUN_GRUP',qryUrun_Grup.FieldByName('URUN_GRUP_KOD').OldAsString,qryUrun_Grup.FieldByName('URUN_GRUP_KOD').AsString,nil) then Abort;
end;

procedure TfrmUrunGroup.btnYeniClick(Sender: TObject);
begin
  qryUrun_Grup.Append;
end;

procedure TfrmUrunGroup.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryUrun_Grup.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('URUN_GRUP,',0,0,0,0,1,'URUN_GRUP');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmUrunGroup.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryUrun_Grup.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('URUN_GRUP,',0,0,0,0,2,'URUN_GRUP');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmUrunGroup.btnIPTALClick(Sender: TObject);
begin
  qryUrun_Grup.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;  
end;

procedure TfrmUrunGroup.FormKeyDown(Sender: TObject; var Key: Word;
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

function TfrmUrunGroup.Form_Before_Delete: Boolean;
var
  strMesaj:String;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if DataMod.Delete_Control('URUN_GRUP',qryUrun_Grup.FieldByName('URUN_GRUP_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then Exit;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Exit;
  end;


  Result := True;
end;

function TfrmUrunGroup.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmUrunGroup.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmUrunGroup);
end;

procedure TfrmUrunGroup.BitBtn1Click(Sender: TObject);
var
  qryExecuter,Qry:TIB_Query;

begin

    if dmLOGGER.dbaMain_StartMonitoring then
    begin

    try
    DataMod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
    DataMod.CreateQuery(qry,Nil,False,DataMod.dbaMain);

    qry.Close;
    qry.SQL.Text:='Select Count(*) GELEN from URUN_GRUP_UYE where URUN_KOD=:URUN_KOD';
    qry.ParamByName('URUN_KOD').AsString:=IB_Query1.FieldByName('URUN_KOD').AsString;
    qry.Open;
    if qry.FieldByName('GELEN').AsInteger<=0 then
    begin
         qryExecuter.SQL.Add('INSERT INTO URUN_GRUP_UYE(URUN_GRUP_KOD,URUN_KOD,VARSAY) VALUES ('
                             + SQL_Katar(qryUrun_Grup.FieldByName('URUN_GRUP_KOD').AsString)
                             +','+ SQL_Katar(IB_Query1.FieldByName('URUN_KOD').AsString) + ',1)');
         qryExecuter.Execute;
    end
    else
    begin
         qryExecuter.SQL.Add('INSERT INTO URUN_GRUP_UYE(URUN_GRUP_KOD,URUN_KOD,VARSAY) VALUES ('
                             + SQL_Katar(qryUrun_Grup.FieldByName('URUN_GRUP_KOD').AsString)
                             +','+ SQL_Katar(IB_Query1.FieldByName('URUN_KOD').AsString) + ',0)');
         qryExecuter.Execute;
    end;

    dmLOGGER.dbaMain_StopMonitoringWrite2log('URUN_GRUP_UYE,',0,0,0,0,1,'URUN_GRUP_UYE');

    except
      dmLOGGER.dbaMain_CancelMonitoring;
    end;

    end;
    qryUrun_GrupAfterScroll(Nil);


end;

procedure TfrmUrunGroup.qryUrun_GrupAfterScroll(IB_Dataset: TIB_Dataset);
begin
     IB_Query2.Close;
     IB_Query2.ParamByName('Grup_Kod').AsString:=qryUrun_Grup.fieldbyName('URUN_GRUP_KOD').AsString;
     IB_Query2.Open;
end;

procedure TfrmUrunGroup.BitBtn2Click(Sender: TObject);
var
  qryExecuter,Qry:TIB_Query;

begin
  if IB_Query2.RecordCount<>0 Then
  begin

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
    try
    DataMod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
    qryExecuter.SQL.Add('DELETE FROM URUN_GRUP_UYE WHERE URUN_KOD='+SQL_Katar(IB_Query2.FieldByName('URUN_KOD').AsString)
                      + ' AND URUN_GRUP_KOD = '+ SQL_Katar(qryUrun_Grup.FieldByName('URUN_GRUP_KOD').AsString));
    qryExecuter.Execute;
    dmLOGGER.dbaMain_StopMonitoringWrite2log('URUN_GRUP_UYE,',0,0,0,0,2,'URUN_GRUP_UYE');
    except
      dmLOGGER.dbaMain_CancelMonitoring;
    end;
    end;
  end;
    qryUrun_GrupAfterScroll(Nil);  


end;

end.
