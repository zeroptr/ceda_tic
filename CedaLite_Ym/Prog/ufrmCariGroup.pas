unit ufrmCariGroup;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 Db, StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons, IBODataset, Grids, DBGrids,
 IB_Components, IB_Controls, IB_Grid,Variants;

type
  TfrmCariGroup = class(TForm)
    Panel1: TPanel;
    qryCariGrup: TIB_Query;
    dtsCariGrup: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Memo1: TIB_Memo;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    IB_ComboBox1: TIB_ComboBox;
    btnKaydet: TButton;
    btnYeni: TBitBtn;
    btnIPTAL: TButton;
    btnSil: TButton;
    grdCGROUP: TIB_Grid;
    IB_Grid1: TIB_Grid;
    IB_Query1: TIB_Query;
    IB_DataSource1: TIB_DataSource;
    IB_Query2: TIB_Query;
    IB_Grid2: TIB_Grid;
    IB_DataSource2: TIB_DataSource;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
//****************************************************************************//
    function  Form_Open(Menu: Boolean): Integer;
    function  CariGrupNo(CariGroup_SAYAC:INTEGER):String;
    function  Form_Before_Post:Boolean;
    function  Form_Before_Delete:Boolean;
//****************************************************************************//
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure qryCariGrupAfterInsert(IB_Dataset: TIB_Dataset);
    procedure IB_Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Memo1Enter(Sender: TObject);
    procedure IB_Memo1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure IB_ComboBox1Enter(Sender: TObject);
    procedure IB_ComboBox1Exit(Sender: TObject);
    procedure qryCariGrupBeforePost(IB_Dataset: TIB_Dataset);
    procedure dtsCariGrupStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure qryCariGrupAfterScroll(IB_Dataset: TIB_Dataset);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
  end;
  const cns_cari_group = 2;
var
  frmCariGroup: TfrmCariGroup;

implementation

uses unDataMod,unFunc,Main, unLogger;

{$R *.DFM}

function TfrmCariGroup.Form_Open(Menu: Boolean): Integer;
var
  local_can_update,local_can_delete:Boolean;
begin
  Result := 1;
  if not DataMod.Modul_Hak(cns_cari_group,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm( Application , 'frmCariGroup') then
    begin
      if Menu then
      begin
        Application.CreateForm(TfrmCariGroup, frmCariGroup);
        with frmCariGroup do
        begin
          prv_CanUpdate := local_can_update;
          prv_CanDelete := local_can_delete;
          qryCariGrup.Active := True;
          IB_Query1.Open;
        end;
      end
      else
      begin
        Application.CreateForm(TfrmCariGroup, frmCariGroup);
        with frmCariGroup do
        begin
          prv_CanUpdate := local_can_update;
          prv_CanDelete := local_can_delete;
          FormStyle := fsNormal;
          Visible := False;
          qryCariGrup.Active := True;
          //IB_Query2.Open;
          IB_Query1.Open;

          ShowModal;
          qryCariGrup.Active := False;
          IB_Query2.Close;
          IB_Query1.Close;
          Release;
        end;
      end;
    end;
  end;
end;

procedure TfrmCariGroup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryCariGrup.Active := False;
  Action := caFree;
end;

procedure TfrmCariGroup.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qryCariGrup.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qryCariGrup.Active := False;
  end;
end;

procedure TfrmCariGroup.FormKeyPress(Sender: TObject; var Key: Char);
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


procedure TfrmCariGroup.qryCariGrupAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with IB_DataSet do
  begin
    FieldByName('CARI_GRUP_SID').AsInteger := glb_SID ;
    FieldByName('TIP').AsInteger := 1;
    FieldByName('CARI_GRUP_KOD').AsString := CariGrupNo(Int64(DataMod.GET_SAYAC_NUM('CARIGRUP',True,False,0)));
  end;
  IB_Edit1.SetFocus;  
end;

procedure TfrmCariGroup.IB_Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmCariGroup.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmCariGroup.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmCariGroup.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmCariGroup.IB_Memo1Enter(Sender: TObject);
begin
  IB_Memo1.Color := glb_Art_Alan_Renk;
end;

procedure TfrmCariGroup.IB_Memo1Exit(Sender: TObject);
begin
  IB_Memo1.Color := clWindow;
end;

function TfrmCariGroup.CariGrupNo(CariGroup_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(CariGroup_SAYAC,TRIM(DataMod.GetParam(cns_cari_group,'C_GP_PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_cari_group,'C_GP_KOD_LENGTH',0)));
end;

procedure TfrmCariGroup.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmCariGroup);
end;

procedure TfrmCariGroup.btnAraClick(Sender: TObject);
var
  CG_KOD,CG_AD:String;
begin
  if DataMod.LS_CariGroup(CG_KOD,CG_AD) then qryCariGrup.Locate('CARI_GRUP_KOD',CG_KOD,[lopCaseInsensitive]);
end;

procedure TfrmCariGroup.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCariGroup.IB_ComboBox1Enter(Sender: TObject);
begin
  IB_ComboBox1.Color := glb_Art_Alan_Renk;
end;

procedure TfrmCariGroup.IB_ComboBox1Exit(Sender: TObject);
begin
  IB_ComboBox1.Color := clWindow;
end;

procedure TfrmCariGroup.qryCariGrupBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qryCariGrup,'CARI_GRUP','CARI_GRUP_KOD,CGADI','CARI_GRUP_KOD');
  if funcDeger <> '' then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('CARI_GRUP',qryCariGrup.FieldByName('CARI_GRUP_KOD').OldAsString,qryCariGrup.FieldByName('CARI_GRUP_KOD').AsString,nil) then Abort;
end;

procedure TfrmCariGroup.dtsCariGrupStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
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

procedure TfrmCariGroup.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  qryCariGrup.Append;
end;

procedure TfrmCariGroup.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryCariGrup.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('CARI_GRUP,',0,0,0,0,1,'CARI_GRUP');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmCariGroup.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    //if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_YESNO + MB_DEFBUTTON1+ MB_ICONQUESTION) = ID_NO then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryCariGrup.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('CARI_GRUP,',0,0,0,0,2,'CARI_GRUP');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmCariGroup.btnIPTALClick(Sender: TObject);
begin
  qryCariGrup.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmCariGroup.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

function TfrmCariGroup.Form_Before_Delete: Boolean;
var
  strMesaj:String;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if DataMod.Delete_Control('CARI_GRUP',qryCariGrup.FieldByName('CARI_GRUP_KOD').AsString,strMesaj) then
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

function TfrmCariGroup.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmCariGroup.qryCariGrupAfterScroll(IB_Dataset: TIB_Dataset);
begin
     IB_Query2.Close;
     IB_Query2.ParamByName('Grup_Kod').AsString:=qryCariGrup.fieldbyName('CARI_GRUP_KOD').AsString;
     IB_Query2.Open;
end;

procedure TfrmCariGroup.BitBtn1Click(Sender: TObject);
var
  qryExecuter,Qry:TIB_Query;

begin

    if dmLOGGER.dbaMain_StartMonitoring then
    begin

       try
         DataMod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
         DataMod.CreateQuery(qry,Nil,False,DataMod.dbaMain);

         qry.Close;
         qry.SQL.Text:='Select Count(*) GELEN from CARI_GRUP_UYE where CARI_KOD=:CARI_KOD';
         qry.ParamByName('CARI_KOD').AsString:=IB_Query1.FieldByName('CARI_KOD').AsString;
         qry.Open;
         if qry.FieldByName('GELEN').AsInteger<=0 then
         begin
              qryExecuter.SQL.Add('INSERT INTO CARI_GRUP_UYE(CARI_GRUP_KOD,CARI_KOD,VARSAY) VALUES ('
                                  + SQL_Katar(qryCariGrup.FieldByName('CARI_GRUP_KOD').AsString)
                                  +','+ SQL_Katar(IB_Query1.FieldByName('CARI_KOD').AsString) + ',1)');
              qryExecuter.Execute;
         end
         else
         begin
              qryExecuter.SQL.Add('INSERT INTO CARI_GRUP_UYE(CARI_GRUP_KOD,CARI_KOD,VARSAY) VALUES ('
                                  + SQL_Katar(qryCariGrup.FieldByName('CARI_GRUP_KOD').AsString)
                                  +','+ SQL_Katar(IB_Query1.FieldByName('CARI_KOD').AsString) + ',0)');
              qryExecuter.Execute;
         end;

         dmLOGGER.dbaMain_StopMonitoringWrite2log('CARI_GRUP_UYE,',0,0,0,0,1,'CARI_GRUP_UYE');

       except
         dmLOGGER.dbaMain_CancelMonitoring;
       end;

    end;
    qryCariGrupAfterScroll(Nil);
end;

procedure TfrmCariGroup.BitBtn2Click(Sender: TObject);
var
  qryExecuter,Qry:TIB_Query;

begin
  if IB_Query2.RecordCount<>0 Then
  begin

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
    try
    DataMod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
    qryExecuter.SQL.Add('DELETE FROM CARI_GRUP_UYE WHERE CARI_KOD='+SQL_Katar(IB_Query2.FieldByName('CARI_KOD').AsString)
                      + ' AND CARI_GRUP_KOD = '+ SQL_Katar(qryCariGrup.FieldByName('CARI_GRUP_KOD').AsString));
    qryExecuter.Execute;
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CARI_GRUP_UYE,',0,0,0,0,2,'CARI_GRUP_UYE');
    except
      dmLOGGER.dbaMain_CancelMonitoring;
    end;
    end;
  end;
    qryCariGrupAfterScroll(Nil);  
end;

end.
