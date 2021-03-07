unit ufrmMasrafGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IB_Components, IB_Controls, Mask,
  Grids, IB_Grid;

type
  TfrmMasrafGroup = class(TForm)
    Panel1: TPanel;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnKaydet: TButton;
    btnYeni: TBitBtn;
    btnIPTAL: TButton;
    btnSil: TButton;
    qryMasrafGrup: TIB_Query;
    dtsMasrafGrup: TIB_DataSource;
    grdCGROUP: TIB_Grid;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Memo1: TIB_Memo;
//****************************************************************************//
    function Form_Open(Menu: Boolean): Integer;
    function MasrafGrupNo(MasrafGroup_SAYAC:INTEGER):String;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
//****************************************************************************//
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qryMasrafGrupAfterInsert(IB_Dataset: TIB_Dataset);
    procedure btnCikisClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure qryMasrafGrupBeforePost(IB_Dataset: TIB_Dataset);
    procedure dtsMasrafGrupStateChanged(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Memo1Enter(Sender: TObject);
    procedure IB_Memo1Exit(Sender: TObject);
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
  end;
  const cns_masraf_group = 21;
var
  frmMasrafGroup: TfrmMasrafGroup;

implementation
uses unDataMod,unFunc,Main, unLogger;
{$R *.dfm}

function TfrmMasrafGroup.Form_Open(Menu: Boolean): Integer;
var
  local_can_update,local_can_delete:Boolean;
begin
  Result := 1;
  if not DataMod.Modul_Hak(cns_masraf_group,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application , 'frmMasrafGroup') then
    begin
      if Menu then
      begin
        Application.CreateForm(TfrmMasrafGroup, frmMasrafGroup);
        with frmMasrafGroup do
        begin
          prv_CanUpdate := local_can_update;
          prv_CanDelete := local_can_delete;
          qryMasrafGrup.Active := True;
        end;
      end
      else
      begin
        Application.CreateForm(TfrmMasrafGroup,frmMasrafGroup);
        with frmMasrafGroup do
        begin
          prv_CanUpdate := local_can_update;
          prv_CanDelete := local_can_delete;
          FormStyle := fsNormal;
          Visible := False;
          qryMasrafGrup.Active := True;
          ShowModal;
          qryMasrafGrup.Active := False;
          Release;
        end;
      end;
    end;
  end;
end;


procedure TfrmMasrafGroup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryMasrafGrup.Active := False;
  Action := caFree;
end;

procedure TfrmMasrafGroup.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qryMasrafGrup.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qryMasrafGrup.Active := False;
  end;
end;

procedure TfrmMasrafGroup.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ActiveControl.Name <> 'IB_Memo1' then
  begin
    if key = #13 then
    begin
      key := #0;
      SelectNext(ActiveControl as tWinControl, True, True );
    end;
  end;
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
end;

procedure TfrmMasrafGroup.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmMasrafGroup);
end;

procedure TfrmMasrafGroup.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmMasrafGroup.qryMasrafGrupAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with IB_DataSet do
  begin
    FieldByName('MASRAF_GRUP_SID').AsInteger := glb_SID ;
    FieldByName('MASRAF_GRUP_KOD').AsString := MasrafGrupNo(Int64(DataMod.GET_SAYAC_NUM('MASRAFGRUP',True,False,0)));
  end;
  IB_Edit1.SetFocus;
end;

function TfrmMasrafGroup.MasrafGrupNo(MasrafGroup_SAYAC: INTEGER): String;
begin
  Result := DataMod.Kod_Format(MasrafGroup_SAYAC,TRIM(DataMod.GetParam(cns_masraf_group,'M_GP_PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_masraf_group,'M_GP_KOD_LENGTH',0)));
end;

procedure TfrmMasrafGroup.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMasrafGroup.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  qryMasrafGrup.Append;
end;

procedure TfrmMasrafGroup.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryMasrafGrup.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('MASRAF_GRUP,',0,0,0,0,1,'MASRAF_GRUP');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

function TfrmMasrafGroup.Form_Before_Delete: Boolean;
var
  strMesaj:String;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;


  if DataMod.Delete_Control('MASRAF_GRUP',qryMasrafGrup.FieldByName('MASRAF_GRUP_KOD').AsString,strMesaj) then
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

function TfrmMasrafGroup.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmMasrafGroup.btnIPTALClick(Sender: TObject);
begin
  qryMasrafGrup.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmMasrafGroup.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    //if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_YESNO + MB_DEFBUTTON1+ MB_ICONQUESTION) = ID_NO then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryMasrafGrup.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('MASRAF_GRUP,',0,0,0,0,2,'MASRAF_GRUP');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmMasrafGroup.btnAraClick(Sender: TObject);
var
  Kod,Ad:String;
begin
  if DataMod.LS_MasrafGroup(Kod,Ad) then qryMasrafGrup.Locate('MASRAF_GRUP_KOD',Kod,[lopCaseInsensitive]);
end;

procedure TfrmMasrafGroup.qryMasrafGrupBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qryMasrafGrup,'MASRAF_GRUP','MASRAF_GRUP_KOD,MASRAF_GRUP_ADI','MASRAF_GRUP_KOD');
  if funcDeger <> '' then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('MASRAF_GRUP',qryMasrafGrup.FieldByName('MASRAF_GRUP_KOD').OldAsString,qryMasrafGrup.FieldByName('MASRAF_GRUP_KOD').AsString,nil) then Abort;
end;

procedure TfrmMasrafGroup.dtsMasrafGrupStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    btnSil.Enabled := False;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
    grdCGROUP.Enabled := False;
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
    grdCGROUP.Enabled := True;
  end;
end;

procedure TfrmMasrafGroup.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmMasrafGroup.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmMasrafGroup.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmMasrafGroup.IB_Memo1Enter(Sender: TObject);
begin
  IB_Memo1.Color := glb_Art_Alan_Renk;
end;

procedure TfrmMasrafGroup.IB_Memo1Exit(Sender: TObject);
begin
  IB_Memo1.Color := clWindow;
end;

end.
