unit ufrmDepo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, IB_Components, Buttons, StdCtrls, Mask, IB_Controls,Variants;

type
  TfrmDepo = class(TForm)
    Panel1: TPanel;
    qry_Depo: TIB_Query;
    dts_Depo: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit8: TIB_Edit;
    IB_Edit9: TIB_Edit;
    IB_Edit10: TIB_Edit;
    btnCikis: TBitBtn;
    btnAra: TBitBtn;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qry_DepoAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure qry_DepoBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure dts_DepoStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure qry_DepoBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;DEPO_KOD:String;ISLEM_TIP:Byte);
    procedure DataSet_Open(DEPO_KOD:String;ISLEM_TIP:Byte);
    function DepoNo(DEPO_SAYAC:INTEGER):String;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
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
  const cns_depo = 8;
var
  frmDepo: TfrmDepo;

implementation

uses unDataMod,Main,unFunc, unLogger;
{$R *.DFM}


procedure TfrmDepo.Form_Open(Menu:Boolean;DEPO_KOD:String;ISLEM_TIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_depo,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM_TIP = 1) and (not local_can_update)) then
    begin
      Application.MessageBox('Bu modülde yeni depo tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
  if not MainForm.FindChildFrm(Application, 'frmDepo') then
  begin
    Application.CreateForm(TfrmDepo, frmDepo);
    with frmDepo do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      DataSet_Open(DEPO_KOD,ISLEM_TIP);
    end;
  end
  else
  begin
    Application.MessageBox('Depo formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
end;

procedure TfrmDepo.DataSet_Open(DEPO_KOD:String;ISLEM_TIP:Byte);
begin
  with qry_Depo do
  begin
    Active := False;
    ParamByName('PRM_DEPO_KOD').AsString := DEPO_KOD;
    Active := True;
  end;
  case ISLEM_TIP of
  0://edit
    begin
      qry_Depo.Edit;
    end;
  1://insert
    begin
      qry_Depo.Insert;
    end;
  end;
end;


procedure TfrmDepo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmDepo.qry_DepoAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qry_Depo do
  begin
    FieldByName('DEPO_SID').AsInteger := glb_SID;
    FieldByName('DEPO_KOD').AsString := DepoNo(Int64(DataMod.GET_SAYAC_NUM('DEPO',True,False,0)));
  end;
  IB_Edit1.SetFocus;
end;

procedure TfrmDepo.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmDepo.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmDepo.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmDepo.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmDepo.qry_DepoBeforeDelete(IB_Dataset: TIB_Dataset);
var
 StrMesaj:String;
begin
  if DataMod.Delete_Control('DEPO',qry_Depo.FieldByName('DEPO_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmDepo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qry_Depo.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qry_Depo.Active := False;
    qry_Depo.Active := False;
  end;
end;

procedure TfrmDepo.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmDepo);
end;

function TfrmDepo.DepoNo(DEPO_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(DEPO_SAYAC,TRIM(DataMod.GetParam(cns_depo,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_depo,'KOD_LENGTH',0)));
end;


procedure TfrmDepo.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDepo.btnAraClick(Sender: TObject);
var
  DEPO_KOD,DEPO_AD:String;
begin
  if DataMod.LS_Depo(DEPO_KOD,DEPO_AD) then
  begin
    DataSet_Open(DEPO_KOD,0);
  end;
end;

procedure TfrmDepo.dts_DepoStateChanged(Sender: TIB_DataSource;
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
      Btn_Onceki.Enabled := True;
      Btn_Sonraki.Enabled := True;
      btnSil.Enabled := False;
    end;
    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmDepo.qry_DepoBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qry_DEPO,'DEPO','DEPO_KOD,ADI','DEPO_KOD');
  if funcDeger<>'' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('DEPO',qry_Depo.FieldByName('DEPO_KOD').OldAsString,qry_Depo.FieldByName('DEPO_KOD').AsString,Nil) then Abort;
end;

procedure TfrmDepo.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni depo tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataSet_Open('',1);
end;

procedure TfrmDepo.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Depo.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('DEPO,',0,0,0,0,1,'DEPO');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmDepo.btnIPTALClick(Sender: TObject);
begin
  qry_Depo.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmDepo.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Depo.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('DEPO,',0,0,0,0,2,'DEPO');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmDepo.FormKeyDown(Sender: TObject; var Key: Word;
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

function TfrmDepo.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmDepo.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;



procedure TfrmDepo.Geri_AL;
begin
     if qry_Depo.State in [DssEdit,DssInsert] then qry_Depo.Cancel;
     qry_Depo.Close;
end;

procedure TfrmDepo.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 DEPO_KOD FROM DEPO WHERE DEPO_KOD>:DEPO_KOD ORDER BY DEPO_KOD';
     qryDeg1.ParamByName('DEPO_KOD').AsString:=qry_Depo.FieldByName('DEPO_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('DEPO_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('DEPO_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure TfrmDepo.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 DEPO_KOD FROM DEPO WHERE DEPO_KOD<:DEPO_KOD ORDER BY DEPO_KOD DESC';
     qryDeg1.ParamByName('DEPO_KOD').AsString:=qry_Depo.FieldByName('DEPO_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('DEPO_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('DEPO_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);


end;

end.
