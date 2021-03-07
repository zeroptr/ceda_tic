{$INCLUDE directive.inc}
unit ufrmMasrafTan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Controls, StdCtrls, Buttons, ExtCtrls, Mask, IB_Components,
  Grids, IB_Grid, ComCtrls;

type
  TfrmMasrafTan = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    edtMasrafKod: TIB_Edit;
    edtAd: TIB_Edit;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    edtAck: TIB_Edit;
    edtBorc: TIB_Currency;
    edtAlacak: TIB_Currency;
    qryMasraf: TIB_Query;
    dtsMasrafTan: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    IB_Grid2: TIB_Grid;
    btnGEkle: TButton;
    btnGSil: TButton;
    btnGrupTan: TButton;
    btnVarsayilan: TButton;
    qryMasrafGrupUye: TIB_Query;
    dtsMasrafGrupUye: TIB_DataSource;
    qryMasrafGrup: TIB_Query;
    dtsMasrafGrup: TIB_DataSource;
    chkDevir: TIB_CheckBox;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
////////////////////////////////////////////////////////////////////////////////
    function Form_Open(Menu:Boolean;MasrafKod:String;Islem:Integer):Boolean;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure Dataset_Open(MasrafKod: String;Islem: Integer);
    procedure Form_Post;
    procedure Form_Delete;
    procedure DataSet_Grup_Open;
////////////////////////////////////////////////////////////////////////////////
    procedure edtMasrafKodEnter(Sender: TObject);
    procedure edtMasrafKodExit(Sender: TObject);
    procedure edtBorcEnter(Sender: TObject);
    procedure edtBorcExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCikisClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dtsMasrafTanStateChanged(Sender: TIB_DataSource;      ADataset: TIB_Dataset);
    procedure qryMasrafAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qryMasrafBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure qryMasrafBeforePost(IB_Dataset: TIB_Dataset);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure btnGrupTanClick(Sender: TObject);
    procedure btnVarsayilanClick(Sender: TObject);
    procedure btnGEkleClick(Sender: TObject);
    procedure btnGSilClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    prv_CanUpdate,prv_CanDelete:Boolean;
    procedure Geri_AL;
  public
    { Public declarations }
  end;
////////////////////////////////////////////////////////////////////////////////
  const cns_masraf = 21;
var
  frmMasrafTan: TfrmMasrafTan;

implementation

{$R *.dfm}
uses unDataMod,main, unLogger,ufrmMasrafGroup,unFunc;

function TfrmMasrafTan.Form_Open(Menu:Boolean;MasrafKod:String;Islem:Integer):Boolean;
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_masraf,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((MasrafKod = '') and (local_can_update = False)) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
    if MainForm.FindChildFrm(Application,'frmMasrafTan') = False then
    begin
      Application.CreateForm(TfrmMasrafTan,frmMasrafTan);
      with frmMasrafTan do
      begin
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;
        Dataset_Open(MasrafKod,Islem);
      end;
    end;
  end;
end;

procedure TfrmMasrafTan.Dataset_Open(MasrafKod: String;Islem: Integer);
begin
  if ((MasrafKod = '') and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with qryMasraf do
  begin
    Active := False;
    ParamByName('PRM_MASRAF_KOD').AsString := MasrafKod;
    try
      Active := True;
    except
      Application.MessageBox('MASRAF sql cümleciðinde hata...','Dikkat',MB_ICONHAND);
      ShowMessage(qryMasraf.SQL.Text);
      raise;
    end;
  end;



  case Islem of
  0://yeni kayýt
    begin
      qryMasraf.Insert;
    end;
  1://edit
    begin
      //qryMasraf.Edit;
    end;
  end;
end;

procedure TfrmMasrafTan.edtMasrafKodEnter(Sender: TObject);
begin
  (Sender as TIB_Edit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmMasrafTan.edtMasrafKodExit(Sender: TObject);
begin
  if Length(Trim((Sender as TIB_Edit).Text))=0 then
  begin
    (Sender as TIB_Edit).Color := clWindow;
    exit;
  end
  else
  begin
    (Sender as TIB_Edit).Color := clWindow;
  end;
//****************************************************************************//
end;

procedure TfrmMasrafTan.edtBorcEnter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmMasrafTan.edtBorcExit(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := clWindow;
end;

procedure TfrmMasrafTan.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  DataMod.Form_Comp_Color(frmMasrafTan);
  with qryMasraf do
  begin
    FieldByName('BORC').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('ALACAK').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_BORC').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK').DisplayFormat := glb_VPB_FIELD_PF;
  end;
end;

procedure TfrmMasrafTan.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmMasrafTan.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end
  else
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);    
  end;
end;

procedure TfrmMasrafTan.btnCikisClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMasrafTan.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if PageControl1.ActivePageIndex = 0 Then
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
          if btnIptal.Enabled then btnIptalClick(Self);
        end;
      46: // del delete
        begin
          if btnSIL.Enabled then btnSILClick(self);
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
  case Key of
    VK_F6:PageControl1.SelectNextPage(True);
  end;
end;

procedure TfrmMasrafTan.btnYeniClick(Sender: TObject);
begin
  Dataset_Open('',0);
end;

procedure TfrmMasrafTan.btnKaydetClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmMasrafTan.btnIPTALClick(Sender: TObject);
begin
  case Application.MessageBox('Ýptal etmek istediðinizden emin misiniz.','Dikkat',MB_YESNO+MB_ICONEXCLAMATION) of
  6://yes
    begin
      qryMasraf.Cancel;
      dmLOGGER.dbaMain_CancelMonitoring;
    end;
  end;
end;

procedure TfrmMasrafTan.btnSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmMasrafTan.btnAraClick(Sender: TObject);
var
  MasrafKod : string;
  MasrafSid : integer;
begin
  if DataMod.LS_MASRAFTAN(MasrafKod) then
  begin
    Dataset_Open(MasrafKod,1);
  end;
end;

function TfrmMasrafTan.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmMasrafTan.Form_Before_Post: Boolean;
var
  Hesap_Ad : String;
begin
  Result := False;
//****************************************************************************//
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if Trim(qryMasraf.FieldByName('MASRAF_KOD').AsString)='' then
  begin
    edtMasrafKod.SetFocus;
    Application.MessageBox('Masraf kodunu boþ býrakamazsýnýz.Lütfen kontrol ediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if Trim(qryMasraf.FieldByName('ADI').AsString)='' then
  begin
    edtAd.SetFocus;
    Application.MessageBox('Adý alanýný boþ býrakamazsýnýz.Lütfen kontrol ediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmMasrafTan.Form_Delete;
begin
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz?','Dikkat',MB_YESNO+MB_ICONASTERISK) = IDNO then Exit;
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryMasraf.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('MASRAF,',0,0,0,0,2,'MASRAF');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmMasrafTan.Form_Post;
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryMasraf.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('MASRAF,',0,0,0,0,1,'MASRAF');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;


procedure TfrmMasrafTan.FormCloseQuery(Sender: TObject;var CanClose: Boolean);
begin
  case PageControl1.ActivePageIndex OF
  0://cari kart
    begin
      if qryMasraf.State in [dssEdit,dssInsert] then
      begin
        Application.MessageBox('Lütfen yaptýðýnýz iþlemi kaydediniz yada iptal ediniz.','Dikkat',MB_ICONWARNING);
        CanClose := False;
      end;
    end;
  1://gruplama
    begin
      if (qryMasrafGrupUye.RecordCount<>0) Then
      begin
        with DataMod.qryGENEL do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('SELECT COUNT(*) AS VARSAYCOUNT FROM MASRAF_GRUP_UYE WHERE MASRAF_KOD='+SQL_Katar(qryMasraf.FieldByName('MASRAF_KOD').AsString)+' AND VARSAY=1');
          Active := True;
        end;
        if (DataMod.qryGENEL.FieldByName('VARSAYCOUNT').AsInteger = 0) then
        begin
          CanClose := False;
          Application.MessageBox('Masraf gruplarýndan en az birini varsayýlan olarak tanýmlamalýsýnýz.','Dikkat',MB_ICONWARNING);
        end
        else
        begin
          qryMasrafGrup.Active := False;
          qryMasrafGrupUye.Active := False;
        end;
      end;
    end;
  end;//end case
end;

procedure TfrmMasrafTan.dtsMasrafTanStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
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
    if not ((ADataset.Eof) And (ADataset.Bof)) then
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

procedure TfrmMasrafTan.qryMasrafAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryMasraf do
  begin
    FieldByName('MASRAF_KOD').AsString := DataMod.Kod_Format(DataMod.GET_SAYAC_NUM('MASRAF',True,True,0),TRIM(DataMod.GetParam(cns_masraf,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_masraf,'KOD_LENGTH',0)));
    FieldByName('MASRAF_SID').AsInteger := glb_SID;
    FieldByName('DEVIR').AsInteger := 0;
    FieldByName('BORC').AsCurrency := 0;
    FieldByName('ALACAK').AsCurrency := 0;
    FieldByName('DEVREDEN_BORC').AsCurrency := 0;
    FieldByName('DEVREDEN_ALACAK').AsCurrency := 0;
  end;
  edtMasrafKod.SetFocus;
end;

procedure TfrmMasrafTan.qryMasrafBeforeDelete(IB_Dataset: TIB_Dataset);
var
  StrMesaj:String;
begin
  if DataMod.Delete_Control('MASRAF',qryMasraf.FieldByName('MASRAF_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmMasrafTan.qryMasrafBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
  prm_StringList : TStringList;
  New_Value,Old_Value:String;
begin
  if not DataMod.Post_Update('MASRAF',qryMasraf.FieldByName('MASRAF_KOD').OldAsString,qryMasraf.FieldByName('MASRAF_KOD').AsString,Nil) then Abort;
end;

procedure TfrmMasrafTan.PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  case PageControl1.ActivePage.TabIndex of
  0://masraf
    if qryMasraf.State in [dssInsert,dssEdit] then
    begin
      Application.MessageBox('Yaptýðýnýz deðiþiklikleri kaydediniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
    end
    else
    begin
      if ((qryMasraf.Eof) and (qryMasraf.Bof)) then
      begin
        Application.MessageBox('Cari bilgisi olmadan bu alana geçemezsiniz.','Dikkat',MB_ICONWARNING);
        AllowChange := False;
      end;
    end;
  1://masraf gruplarý
    begin
      if (qryMasrafGrupUye.RecordCount<>0) then
      begin
        with DataMod.qryGENEL do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('SELECT COUNT(*) AS VARSAYCOUNT FROM MASRAF_GRUP_UYE WHERE MASRAF_KOD='+SQL_Katar(qryMasraf.FieldByName('MASRAF_KOD').AsString)+' AND VARSAY=1');
          Active := True;
        end;
        if (DataMod.qryGENEL.FieldByName('VARSAYCOUNT').AsInteger=0) then
        begin
          AllowChange := False;
          Application.MessageBox('Masraf Gruplarýndan en az birini varsayýlan olarak tanýmlamalýsýnýz.','Dikkat',MB_ICONWARNING);
        end
        else
        begin
          qryMasrafGrup.Active := False;
          qryMasrafGrupUye.Active := False;
        end;
      end;//end if (qryCari_Grup_Uye.RecordCount<>0) then
    end;//end 2
  end;//end case
end;

procedure TfrmMasrafTan.PageControl1Change(Sender: TObject);
begin
  case PageControl1.ActivePage.TabIndex of
  1://masraf gruplarý
    begin
      DataSet_Grup_Open;
    end;
  end;
end;

procedure TfrmMasrafTan.DataSet_Grup_Open;
begin
  with qryMasrafGrup do
  begin
    Active := False;
    ParamByName('PRM_MASRAF_KOD').AsString := qryMasraf.FieldByName('MASRAF_KOD').AsString;
    Active := True;
  end;
  with qryMasrafGrupUye do
  begin
    Active := False;
    ParamByName('PRM_MASRAF_KOD').Asstring := qryMasraf.FieldByName('MASRAF_KOD').AsString;
    Active := True;
  end;
end;


procedure TfrmMasrafTan.btnGrupTanClick(Sender: TObject);
begin
  frmMasrafGroup.Form_Open(False);
  DataSet_Grup_Open;
end;

procedure TfrmMasrafTan.btnVarsayilanClick(Sender: TObject);
var
  qryExecuter:TIB_Query;
begin
  DataMod.CreateQuery(qryExecuter,nil,False,DataMod.dbaMain);
  if qryMasrafGrupUye.RecordCount <> 0 then
  begin
    with qryExecuter do
    begin
      SQL.Add('UPDATE MASRAF_GRUP_UYE SET VARSAY = 0 WHERE MASRAF_KOD = '+SQL_Katar(qryMasrafGrupUye.FieldByName('MASRAF_KOD').AsString));
      Execute;
      SQL.Clear;
      SQL.Add('UPDATE MASRAF_GRUP_UYE SET VARSAY = 1 WHERE MASRAF_KOD='+SQL_Katar(qryMasrafGrupUye.FieldByName('MASRAF_KOD').AsString)
                         +' AND MASRAF_GRUP_KOD = '+SQL_Katar(qryMasrafGrupUye.FieldByName('MASRAF_GRUP_KOD').AsString));
      Execute;
    end;
    dmLOGGER.Write2Log(0,0,0,0,1,qryExecuter.SQL.Text,'MASRAF_GRUP_UYE');
    DataSet_Grup_Open;
  end;
end;

procedure TfrmMasrafTan.btnGEkleClick(Sender: TObject);
var
  qryExecuter,Qry:TIB_Query;
begin
  if qryMasrafGrup.RecordCount <> 0 then
  begin
    DataMod.CreateQuery(qryExecuter,nil,False,DataMod.dbaMain);
    DataMod.CreateQuery(qry,Nil,False,DataMod.dbaMain);

    qry.Close;
    qry.SQL.Text:='Select Count(*) GELEN from MASRAF_GRUP_UYE where MASRAF_KOD=:MASRAF_KOD';
    qry.ParamByName('MASRAF_KOD').AsString:=qryMasraf.FieldByName('MASRAF_KOD').AsString;
    qry.Open;
    if qry.FieldByName('GELEN').AsInteger<=0 then
    begin

    qryExecuter.SQL.Add('INSERT INTO MASRAF_GRUP_UYE(MASRAF_GRUP_KOD,MASRAF_KOD,VARSAY) VALUES ('
                        + SQL_Katar(qryMasrafGrup.FieldByName('MASRAF_GRUP_KOD').AsString)
                        +','+ SQL_Katar(qryMasraf.FieldByName('MASRAF_KOD').AsString) + ',1)');
    qryExecuter.Execute;

    end
    else
    begin

    qryExecuter.SQL.Add('INSERT INTO MASRAF_GRUP_UYE(MASRAF_GRUP_KOD,MASRAF_KOD,VARSAY) VALUES ('
                        + SQL_Katar(qryMasrafGrup.FieldByName('MASRAF_GRUP_KOD').AsString)
                        +','+ SQL_Katar(qryMasraf.FieldByName('MASRAF_KOD').AsString) + ',0)');
    qryExecuter.Execute;

    end;
    dmLOGGER.Write2Log(0,0,0,0,1,qryExecuter.SQL.Text,'MASRAF_GRUP_UYE');
    DataSet_Grup_Open;
  end;

end;

procedure TfrmMasrafTan.btnGSilClick(Sender: TObject);
var
  qryExecuter:TIB_Query;
begin
  if qryMasrafGrupUye.RecordCount <> 0 then
  begin
    DataMod.CreateQuery(qryExecuter,nil,False,DataMod.dbaMain);
    qryExecuter.SQL.Add('DELETE FROM MASRAF_GRUP_UYE WHERE MASRAF_KOD='+SQL_Katar(qryMasrafGrupUye.FieldByName('MASRAF_KOD').AsString)
                      + ' AND MASRAF_GRUP_KOD = '+ SQL_Katar(qryMasrafGrupUye.FieldByName('MASRAF_GRUP_KOD').AsString));
    qryExecuter.Execute;
    dmLOGGER.Write2Log(0,0,0,0,2,qryExecuter.SQL.Text,'MASRAF_GRUP_UYE');
    DataSet_Grup_Open;
  end;
end;


procedure TfrmMasrafTan.Geri_AL;
begin
     if qryMasraf.State in [DssEdit,DssInsert] then qryMasraf.Cancel;
     qryMasrafGrupUye.Close;
     qryMasrafGrup.Close;
     qryMasraf.Close;
end;

procedure TfrmMasrafTan.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 MASRAF_KOD FROM MASRAF WHERE MASRAF_KOD>:MASRAF_KOD ORDER BY MASRAF_KOD';
     qryDeg1.ParamByName('MASRAF_KOD').AsString:=qryMasraf.FieldByName('MASRAF_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('MASRAF_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('MASRAF_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure TfrmMasrafTan.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 MASRAF_KOD FROM MASRAF WHERE MASRAF_KOD<:MASRAF_KOD ORDER BY MASRAF_KOD DESC';
     qryDeg1.ParamByName('MASRAF_KOD').AsString:=qryMasraf.FieldByName('MASRAF_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('MASRAF_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('MASRAF_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

end.
