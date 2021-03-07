unit ufrmSofor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, StdCtrls, Mask, IB_Controls, IB_UpdateBar, ExtCtrls,
  IB_NavigationBar, Buttons,Variants, IB_Grid, ExtDlgs;

type
  TfrmSofor = class(TForm)
    qrySofor: TIB_Query;
    dtsSofor: TIB_DataSource;
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
    IB_Edit3: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit15: TIB_Edit;
    IB_CheckBox1: TIB_CheckBox;
    Button1: TButton;
    Button2: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    Button3: TButton;
    Image1: TImage;
    IB_CheckBox2: TIB_CheckBox;
    IB_Memo1: TIB_Memo;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;Sofor_KOD:String;ISLEM_TIP:Byte);
    procedure DataSet_Open(Sofor_KOD:String;ISLEM_TIP:Byte);
    function SoforNo(Sofor_SAYAC:INTEGER):String;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrySoforAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qrySoforBeforePost(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure qrySoforBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure dtsSoforStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure IB_Image1DblClick(Sender: TObject);
    procedure qrySoforAfterScroll(IB_Dataset: TIB_Dataset);
    procedure Button4Click(Sender: TObject);
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

  const cns_Sofor = 46;

var
  frmSofor: TfrmSofor;

implementation

uses unDataMod, main, unFunc, unLogger, //ufrmGRABBER_WINDOW,
  ufrmResimTamEkran, jpeg;

{$R *.DFM}

procedure TfrmSofor.Form_Open(Menu:Boolean;Sofor_KOD:String;ISLEM_TIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Sofor,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM_TIP = 1) and (not local_can_update)) then
    begin
      Application.MessageBox('Bu modülde yeni Þöför tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
  if not MainForm.FindChildFrm(Application,'frmSofor') then
  begin
    Application.CreateForm(TfrmSofor, frmSofor);
    with frmSofor do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      DataSet_Open(Sofor_KOD,ISLEM_TIP);
    end;
  end
  else
  begin
    Application.MessageBox('Þöför formu açýk.','Dikkat',MB_ICONINFORMATION);
    Exit;
  end;
////////////////////////////////////////////////////////////////////////////////
end;

procedure TfrmSofor.DataSet_Open(Sofor_KOD:String;ISLEM_TIP:Byte);
begin
  Image1.Picture.Graphic:=Nil;
  with qrySofor do
  begin
    Active := False;
    ParamByName('PRM_SOFOR_KOD').AsString := Sofor_KOD;
    Active := True;
    IB_Edit1.SetFocus;
  end;
  case ISLEM_TIP of
  0://edit
    begin
      qrySofor.Edit;
    end;
  1://insert
    begin
      qrySofor.Insert;
    end;
  end;
end;


procedure TfrmSofor.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmSofor.qrySoforAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qrySofor do
  begin
    FieldByName('SOFOR_KOD').AsString := SoforNo(Int64(DataMod.GET_SAYAC_NUM('SOFOR',True,False,0)));
    FieldByName('SOFOR_SID').AsInteger := glb_SID;
    FieldByName('BORC').AsCurrency := 0;
    FieldByName('ALACAK').AsCurrency := 0;
    FieldByName('LISTEDEN_CIKAR').AsInteger := 0;
    FieldByName('DEVREDEN_BORC').AsFloat:= 0;
    FieldByName('DEVREDEN_ALACAK').AsFloat:= 0;
    FieldByName('KARA_LISTE').AsInteger:= 0;
  end;
  IB_Edit1.SetFocus;  
end;

function TfrmSofor.SoforNo(Sofor_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(Sofor_SAYAC,TRIM(DataMod.GetParam(cns_Sofor ,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_Sofor,'KOD_LENGTH',0)));
end;

procedure TfrmSofor.qrySoforBeforePost(IB_Dataset: TIB_Dataset);
var
  FuncDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qrySofor,'SOFOR','SOFOR_KOD,ADI_SOYADI','SOFOR_KOD');
  if  funcDeger<> '' Then
  begin
    ShowMessage(funcDeger);
    Abort;
  end;
  if not DataMod.Post_Update('SOFOR',qrySofor.FieldByName('SOFOR_KOD').OldAsString,qrySofor.FieldByName('SOFOR_KOD').AsString,Nil) then Abort;
end;

procedure TfrmSofor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qrySofor.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qrySofor.Active := False;
  end;
end;

procedure TfrmSofor.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSofor.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmSofor.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmSofor.IB_Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmSofor.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmSofor);
  with frmSofor.qrySofor do
  begin
    FieldByName('BORC').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ALACAK').DisplayFormat := glb_DOV_FIELD_PF;
  end;
end;

procedure TfrmSofor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSofor.qrySoforBeforeDelete(IB_Dataset: TIB_Dataset);
var
  StrMesaj:String;
begin
  if DataMod.Delete_Control('SOFOR',qrySofor.FieldByName('SOFOR_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmSofor.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSofor.btnAraClick(Sender: TObject);
var
  SOFOR_KOD,SOFOR_AD:String;
begin
  if DataMod.LS_SOFOR(SOFOR_KOD,SOFOR_AD) then
  DataSet_Open(SOFOR_KOD,0);
end;

procedure TfrmSofor.dtsSoforStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
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

procedure TfrmSofor.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni Þöför tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataSet_Open('',1);
end;

procedure TfrmSofor.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qrySofor.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SOFOR,',0,0,0,0,1,'SOFOR');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmSofor.btnIPTALClick(Sender: TObject);
begin
  qrySofor.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmSofor.btnSilClick(Sender: TObject);
var
   Dosya:String;
begin
  try
    Dosya:='';

    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      Dosya:= qrySofor.FieldByName('RESIM').AsString;
      qrySofor.Delete;
      if Dosya<>'' then
      if not DataMod.Resim_Bul(Dosya,'SFR') then
      begin
          DeleteFile(Dosya);
      end;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SOFOR,',0,0,0,0,2,'SOFOR');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
  Image1.Picture.Graphic:=Nil;
end;

procedure TfrmSofor.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

function TfrmSofor.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmSofor.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmSofor.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmSofor.Button1Click(Sender: TObject);
var
   Dosya_Adi:String;
begin
  if OpenPictureDialog1.Execute<>False then
  begin
     //qrySofor.FieldByName('RESIM').AsString:=OpenPictureDialog1.FileName;
     Dosya_Adi:=glb_IMAGE_DIR+'\'+ 'Sof'+ExtractFileName(OpenPictureDialog1.FileName);
     FileCopy(OpenPictureDialog1.FileName,Dosya_Adi);
     qrySofor.FieldByName('RESIM').AsString:=Dosya_Adi;
     qrySoforAfterScroll(qrySofor);
  end;
  //  qrySofor.FieldByName('RESIM').LoadFromFile(OpenPictureDialog1.FileName);
  //ShowMessage(ExtractFileName(OpenPictureDialog1.FileName));
end;

procedure TfrmSofor.Button2Click(Sender: TObject);
begin
  if not DataMod.Resim_Bul(qrySofor.FieldByName('RESIM').AsString,'SFR') then
  begin
    MoveFile(Pchar(qrySofor.FieldByName('RESIM').AsString),Pchar(glb_IMAGE_DIR+'\Silinen\'+ExtractFilename(qrySofor.FieldByName('RESIM').AsString)));
    DeleteFile(qrySofor.FieldByName('RESIM').AsString);
  end;
  qrySofor.FieldByName('RESIM').AsString :='';
  Image1.Picture.Graphic:=Nil;
end;

procedure TfrmSofor.Button3Click(Sender: TObject);
begin
{  Application.CreateForm(TfrmGRABBER_WINDOW, frmGRABBER_WINDOW);
  frmGRABBER_WINDOW.Kaynak:='Sofor';
  frmGRABBER_WINDOW.ShowModal;
  frmGRABBER_WINDOW.Release; }
end;

procedure TfrmSofor.IB_Image1DblClick(Sender: TObject);
begin
  Application.CreateForm(TfrmResimTamEkran, frmResimTamEkran);
  frmResimTamEkran.Image1.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
  frmResimTamEkran.ShowModal;
  frmResimTamEkran.Release;
end;

procedure TfrmSofor.qrySoforAfterScroll(IB_Dataset: TIB_Dataset);
begin
   if not qrySofor.FieldByName('RESIM').IsNull then
   begin
       //     qrySofor.FieldByName('RESIM').SaveToFile(glb_WINDOWS_DIR+'\Tempx.jpg');
       //     Image1.Picture.LoadFromFile(glb_WINDOWS_DIR+'\tempx.jpg');
       //Image1.Picture.LoadFromFile(glb_IMAGE_DIR'\'+qrySofor.FieldByName('RESIM').AsString);
       try
       Image1.Picture.LoadFromFile(qrySofor.FieldByName('RESIM').AsString);
       except
           Application.MessageBox(Pchar(qrySofor.FieldByName('RESIM').AsString +' adlý dosya bulunamadý Resmi Sil butonu ile ya boþaltýn yada Yeni Resim Seçiniz'),'Dikkat',MB_ICONWARNING);
       end;
   end;
end;

procedure TfrmSofor.Button4Click(Sender: TObject);
begin
   Image1.Picture.Graphic:=Nil;
end;


procedure TfrmSofor.Geri_AL;
begin
     if qrySofor.State in [DssEdit,DssInsert] then qrySofor.Cancel;
     qrySofor.Close;
end;

procedure TfrmSofor.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 SOFOR_KOD FROM SOFOR WHERE SOFOR_KOD>:SOFOR_KOD ORDER BY SOFOR_KOD';
     qryDeg1.ParamByName('SOFOR_KOD').AsString:=qrySofor.FieldByName('SOFOR_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('SOFOR_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('SOFOR_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;

procedure TfrmSofor.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 SOFOR_KOD FROM SOFOR WHERE SOFOR_KOD<:SOFOR_KOD ORDER BY SOFOR_KOD DESC';
     qryDeg1.ParamByName('SOFOR_KOD').AsString:=qrySofor.FieldByName('SOFOR_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('SOFOR_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('SOFOR_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;

end.
