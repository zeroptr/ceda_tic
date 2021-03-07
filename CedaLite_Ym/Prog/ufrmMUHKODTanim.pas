unit ufrmMUHKODTanim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, IB_UpdateBar, IB_NavigationBar, StdCtrls, Buttons,
  ExtCtrls, Grids, IB_Grid, IB_Components, IB_Controls;

type
  TfrmMUHKODTanim = class(TForm)
    qryMUHKOD: TIB_Query;
    dtsMUHKOD: TIB_DataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    tcMUHKOD: TTabControl;
    IB_Grid1: TIB_Grid;
    qryRAPKODPARAMS: TIB_Query;
    dtsRAPKODPARAMS: TIB_DataSource;
    Panel2: TPanel;
    btnCikis: TBitBtn;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    Panel3: TPanel;
    btnCikis1: TBitBtn;
    btnYeni1: TBitBtn;
    btnKaydet1: TButton;
    btnIPTAL1: TButton;
    btnSil1: TButton;
    IB_Grid2: TIB_Grid;
    IB_Text1: TIB_Text;
    procedure btnCikisClick(Sender: TObject);
    procedure dtsMUHKODStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tcMUHKODChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tcMUHKODChange(Sender: TObject);
    procedure qryMUHKODBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnYeni1Click(Sender: TObject);
    procedure qryRAPKODPARAMSBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnKaydet1Click(Sender: TObject);
    procedure btnIPTAL1Click(Sender: TObject);
    procedure btnSil1Click(Sender: TObject);
    procedure dtsRAPKODPARAMSStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
////////////////////////////////////////////////////////////////////////////////
    function form_open(Menu:Boolean):Boolean;
    function form_before_post:Boolean;
    function form_before_delete:Boolean;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
  end;
  const cns_muhkod_tanim = 19;
var
  frmMUHKODTanim: TfrmMUHKODTanim;

implementation
uses unDataMod, main;
{$R *.dfm}

function TfrmMUHKODTanim.Form_Open(Menu:Boolean):Boolean;
var
  local_can_update,local_can_delete : Boolean;
begin
  if not DataMod.Modul_Hak(cns_muhkod_tanim,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application, 'frmMUHKODTanim') then
    begin
      Application.CreateForm(TfrmMUHKODTanim,frmMUHKODTanim);
      with frmMUHKODTanim do
      begin
        qryMUHKOD.ParamByName('PRM_KOD_TIP').AsInteger := tcMUHKOD.TabIndex;
        qryMUHKOD.Active := True;
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;
      end;
      if not glb_YONETICI then
      begin
        frmMUHKODTanim.PageControl1.Pages[1].TabVisible := False;
      end
      else
      begin
        frmMUHKODTanim.qryRAPKODPARAMS.Active := True;
      end;
      frmMUHKODTanim.PageControl1.ActivePageIndex := 0;
    end;
  end;
end;

procedure TfrmMUHKODTanim.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMUHKODTanim.dtsMUHKODStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    if ADataset.State in [dssEdit] then btnSil.Enabled := True else btnSil.Enabled := False;
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

procedure TfrmMUHKODTanim.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case PageControl1.ActivePageIndex of
  0:
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
        end;//acase end
      end; ///if Shift = [] then ENd
    end;//end case 0
  1:
    begin
      if Shift = [ssCtrl] then
      begin
        case Key of
        83: //s kaydet
          begin
            if btnKAYDET1.Enabled then btnKAYDET1Click(Self);
          end; //83 end
        80: //p iptal
          begin
            if btnIptal1.Enabled Then btnIptal1Click(Self);
          end;
        46: // del delete
          begin
            if btnSIL1.Enabled Then btnSIL1Click(self);
          end;
        end; // case end;
      end//Shift = [ssCtrl] then end
      else
      if Shift = [] then
      begin
        case Key of
        45: //ins kaydet
          begin
            if btnYeni1.Enabled then btnYeni1Click(Self);
          end;
        end;//acase end
      end; ///if Shift = [] then ENd
    end;
  end;
  case Key Of
    VK_F6:PageControl1.SelectNextPage(True);
  end;
end;

procedure TfrmMUHKODTanim.btnYeniClick(Sender: TObject);
begin
  with qryMUHKOD do
  begin
    Append;
    FieldByName('RAP_KOD_TIP').AsInteger := ParamByName('PRM_KOD_TIP').AsInteger;
  end;
end;

procedure TfrmMUHKODTanim.btnKaydetClick(Sender: TObject);
begin
  if not Form_Before_Post then exit;
  qryMUHKOD.Post;
end;

procedure TfrmMUHKODTanim.btnIPTALClick(Sender: TObject);
begin
  qryMUHKOD.Cancel;
end;

procedure TfrmMUHKODTanim.btnSilClick(Sender: TObject);
begin
  if not Form_Before_Delete then exit;
//  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then Exit;
  qryMUHKOD.Delete;
end;

procedure TfrmMUHKODTanim.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmMUHKODTanim.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qryMUHKOD.State in [dssInsert,dssEdit] then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli ya da Ýptal etmelisiniz','Dikkat',MB_ICONHAND);
    CanClose := False;
  end;
end;

procedure TfrmMUHKODTanim.tcMUHKODChanging(Sender: TObject;var AllowChange: Boolean);
begin
  if qryMUHKOD.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli ya da Ýptal etmelisiniz','Dikkat',MB_ICONHAND);
    AllowChange := False;
  end;
end;

procedure TfrmMUHKODTanim.tcMUHKODChange(Sender: TObject);
begin
  with qryMUHKOD do
  begin
    Active := False;
    ParamByName('PRM_KOD_TIP').AsInteger := tcMUHKOD.TabIndex;
    Active := True;
  end;
end;

procedure TfrmMUHKODTanim.qryMUHKODBeforePost(IB_Dataset: TIB_Dataset);
begin
  if Trim(qryMUHKOD.FieldByName('KOD').AsString) = '' then
  begin
    Application.MessageBox('Mutlaka bir kod belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('RAP_KOD_PARAMS',qryMUHKOD.FieldByName('KOD').OldAsString, qryMUHKOD.FieldByName('KOD').AsString,nil) then Abort;
end;

procedure TfrmMUHKODTanim.btnYeni1Click(Sender: TObject);
begin
  qryRAPKODPARAMS.Append;
end;

procedure TfrmMUHKODTanim.qryRAPKODPARAMSBeforePost(IB_Dataset: TIB_Dataset);
begin
  if Trim(qryRAPKODPARAMS.FieldByName('BELGE').AsString) = '' then
  begin
    Application.MessageBox('Mutlaka bir belge belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;



procedure TfrmMUHKODTanim.btnKaydet1Click(Sender: TObject);
begin
  qryRAPKODPARAMS.Post;
end;

procedure TfrmMUHKODTanim.btnIPTAL1Click(Sender: TObject);
begin
  qryRAPKODPARAMS.Cancel;
end;

procedure TfrmMUHKODTanim.btnSil1Click(Sender: TObject);
begin
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then Exit;
  qryRAPKODPARAMS.Delete;
end;

procedure TfrmMUHKODTanim.dtsRAPKODPARAMSStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) Then
  begin
    btnYeni1.Enabled:=False;
    if ADataset.State in [dssEdit] then btnSil1.Enabled := True else btnSil1.Enabled := False;
    btnCikis1.Enabled := False;
    btnKaydet1.Enabled := True;
    btnIPTAL1.Enabled := True;
  end
  else
  begin
    btnYeni1.Enabled:=True;
    if not ((ADataset.Eof) and (ADataset.Bof)) then btnSil1.Enabled := True
    else btnSil1.Enabled := False;
    btnCikis1.Enabled := True;
    btnKaydet1.Enabled := False;
    btnIPTAL1.Enabled := False;
  end;
end;

function TfrmMUHKODTanim.Form_Before_Delete: Boolean;
var
  strMesaj:String;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if DataMod.Delete_Control('RAP_KOD_PARAMS',qryMUHKOD.FieldByName('KOD').AsString,strMesaj) then
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

function TfrmMUHKODTanim.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmMUHKODTanim.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl,True,True);
  end;
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
end;

end.
