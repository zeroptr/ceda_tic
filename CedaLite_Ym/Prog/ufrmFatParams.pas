unit ufrmFatParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Mask, IB_Controls, IB_Components,
  Buttons;

type
  TfrmFatParams = class(TForm)
    PageControl1: TPageControl;
    Panel1: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    btnTAMAM: TBitBtn;
    btnIPTAL: TBitBtn;
    qry_FatParams: TIB_Query;
    dts_FatParams: TIB_DataSource;
    pnlAck: TPanel;
    IB_Edit2: TIB_Edit;
    IB_Edit1: TIB_Edit;
    IB_Edit3: TIB_Edit;
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
    Panel3: TPanel;
    Label1: TLabel;
    chk_EK_ACK_KUL: TIB_CheckBox;
    IB_CheckBox1: TIB_CheckBox;
    IB_CheckBox2: TIB_CheckBox;
    IB_CheckBox3: TIB_CheckBox;
    IB_CheckBox4: TIB_CheckBox;
    IB_CheckBox5: TIB_CheckBox;
    IB_CheckBox6: TIB_CheckBox;
    IB_CheckBox7: TIB_CheckBox;
    IB_CheckBox8: TIB_CheckBox;
    IB_CheckBox9: TIB_CheckBox;
    IB_CheckBox10: TIB_CheckBox;
    IB_CheckBox11: TIB_CheckBox;
    IB_CheckBox12: TIB_CheckBox;
    IB_CheckBox13: TIB_CheckBox;
    txtFATNUM: TEdit;
    Button1: TButton;
    Label2: TLabel;
    txtSERINO: TEdit;
    Label3: TLabel;
    IB_CheckBox14: TIB_CheckBox;
//****************************************************************************//
    function Form_Open(Menu:Boolean;Tip:Byte):Boolean;
//****************************************************************************//
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTAMAMClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chk_EK_ACK_KULClick(Sender: TObject);
    procedure IB_Edit2Enter(Sender: TObject);
    procedure IB_Edit2Exit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PageControl1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure qry_FatParamsBeforePost(IB_Dataset: TIB_Dataset);
    procedure qry_FatParamsBeforeDelete(IB_Dataset: TIB_Dataset);
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
    prv_Tip : Byte;
  public
    { Public declarations }
  end;
  const cns_fatparams = 16;
  const cns_irsparams = 18;
var
  frmFatParams : TfrmFatParams;
  frmIrsParams : TfrmFatParams;
implementation
uses unDataMod,unFunc,main;
{$R *.dfm}


function TfrmFatParams.Form_Open(Menu:Boolean;Tip:Byte):Boolean;
var
  local_can_update,local_can_delete:Boolean;
begin
  case Tip of
  1://satýþ faturasý parametreleri
    begin
//****************************************************************************//
      if not DataMod.Modul_Hak(cns_fatparams,local_can_update,local_can_delete) then
      begin
        Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
        exit;
      end
      else
      begin
        if MainForm.FindChildFrm(Application, 'frmFatParams') then
        begin
          Application.MessageBox('Fatura Parametreleri modülü açýk.','Dikkat',MB_ICONWARNING);
          Exit;
        end
        else
        begin
          Application.CreateForm(TfrmFatParams, frmFatParams);
          with frmFatParams do
          begin
            Caption := 'Satýþ Faturasý Parametreleri';
            prv_CanUpdate := local_can_update;
            prv_CanDelete := local_can_delete;
            prv_Tip := Tip;
            Label2.Caption:='Fatura Numarasý';
            TabSheet2.Caption:='Fatura Bilgileri';
            with qry_FatParams do
            begin
              Close;
              ParamByName('PRM_FAT_PARAMS_ID').AsInteger := Tip;
              Open;
              if RecordCount = 0 then
              begin
                Append;
                FieldByName('FAT_PARAMS_ID').AsInteger := Tip;
                FieldByName('EK_ACK_KUL').AsInteger := 1;
                FieldByName('ACK_30K_1_KUL').AsSmallint := 0;
                FieldByName('ACK_30K_2_KUL').AsSmallint := 0;
                FieldByName('ACK_30K_3_KUL').AsSmallint := 0;
                FieldByName('ACK_50K_1_KUL').AsSmallint := 0;
                FieldByName('ACK_50K_2_KUL').AsSmallint := 0;
                FieldByName('ACK_50K_3_KUL').AsSmallint := 0;
                FieldByName('ACK_50K_4_KUL').AsSmallint := 0;
                FieldByName('ACK_50K_5_KUL').AsSmallint := 0;
                FieldByName('ACK_100K_1_KUL').AsSmallint := 0;
                FieldByName('ACK_100K_2_KUL').AsSmallint := 0;
                FieldByName('ACK_100K_3_KUL').AsSmallint := 0;
                FieldByName('ACK_100K_4_KUL').AsSmallint := 0;
                FieldByName('ACK_100K_5_KUL').AsSmallint := 0;
              end
              else
              begin
                if FieldByName('EK_ACK_KUL').AsInteger = 1 Then
                begin
                  pnlAck.Enabled := True;
                end
                else
                begin
                  pnlAck.Enabled := False;
                end;
                Edit;
              end;
            end;
            PageControl1.ActivePageIndex := 0;
          end;//end with frmFatParams do
        end;//end else if MainForm.FindChildFrm(Application, 'frmFatParams') then
      end;
//****************************************************************************//
    end;
  2://satýþ irsaliyesi parametreleri
    begin
//****************************************************************************//
      if not DataMod.Modul_Hak(cns_irsparams,local_can_update,local_can_delete) then
      begin
        Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
        exit;
      end
      else
      begin
        if MainForm.FindChildFrm(Application, 'frmIrsParams') then
        begin
          Application.MessageBox('Ýrsaliye Parametreleri modülü açýk.','Dikkat',MB_ICONWARNING);
          Exit;
        end
        else
        begin
          Application.CreateForm(TfrmFatParams, frmIrsParams);
          with frmIrsParams do
          begin
            Name := 'frmIrsParams';
            Caption := 'Satýþ Ýrsaliyesi Parametreleri';
            Label2.Caption:='Ýrsaliye Numarasý';
            TabSheet2.Caption:='Ýrsaliye Bilgileri';
            prv_CanUpdate := local_can_update;
            prv_CanDelete := local_can_delete;
            prv_Tip := Tip;
            with qry_FatParams do
            begin
              Close;
              ParamByName('PRM_FAT_PARAMS_ID').AsInteger := Tip;
              Open;
              if RecordCount = 0 then
              begin
                Append;
                FieldByName('FAT_PARAMS_ID').AsInteger := Tip;
                FieldByName('EK_ACK_KUL').AsInteger := 1;
                FieldByName('ACK_30K_1_KUL').AsSmallint := 0;
                FieldByName('ACK_30K_2_KUL').AsSmallint := 0;
                FieldByName('ACK_30K_3_KUL').AsSmallint := 0;
                FieldByName('ACK_50K_1_KUL').AsSmallint := 0;
                FieldByName('ACK_50K_2_KUL').AsSmallint := 0;
                FieldByName('ACK_50K_3_KUL').AsSmallint := 0;
                FieldByName('ACK_50K_4_KUL').AsSmallint := 0;
                FieldByName('ACK_50K_5_KUL').AsSmallint := 0;
                FieldByName('ACK_100K_1_KUL').AsSmallint := 0;
                FieldByName('ACK_100K_2_KUL').AsSmallint := 0;
                FieldByName('ACK_100K_3_KUL').AsSmallint := 0;
                FieldByName('ACK_100K_4_KUL').AsSmallint := 0;
                FieldByName('ACK_100K_5_KUL').AsSmallint := 0;
              end
              else
              begin
                if FieldByName('EK_ACK_KUL').AsInteger = 1 Then
                begin
                  pnlAck.Enabled := True;
                end
                else
                begin
                  pnlAck.Enabled := False;
                end;
                Edit;
              end;
            end;
            PageControl1.ActivePageIndex := 0;
          end;//end with frmIrsParams do
        end;
      end;
//****************************************************************************//
    end;
  end;//end case tip of
//****************************************************************************//
end;

procedure TfrmFatParams.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 1 then
  begin
    case prv_Tip of
    1://satýþ faturasý
      begin
        if glb_SUBELI then
        begin
          txtFATNUM.Text := inttostr(DataMod.GET_SAYAC_NUM('SATIS_FATURA',False,False,glb_SID));
          txtSERINO.Text := DataMod.GETPARAM(cns_fatparams,'FAT_SERI',glb_SID);
        end
        else
        begin
          txtFATNUM.Text := inttostr(DataMod.GET_SAYAC_NUM('SATIS_FATURA',False,False,0));
          txtSERINO.Text := DataMod.GETPARAM(cns_fatparams,'FAT_SERI',0);
        end;
      end;
    2://satýþ irsaliyesi
      begin
        if glb_SUBELI then
        begin
          txtFATNUM.Text := inttostr(DataMod.GET_SAYAC_NUM('SATIS_IRSALIYE',False,False,glb_SID));
          txtSERINO.Text := DataMod.GETPARAM(cns_irsparams,'IRS_SERI',glb_SID);
        end
        else
        begin
          txtFATNUM.Text := inttostr(DataMod.GET_SAYAC_NUM('SATIS_IRSALIYE',False,False,0));
          txtSERINO.Text := DataMod.GETPARAM(cns_irsparams,'IRS_SERI',0);
        end;
      end;
    end;//end case
  end
end;

procedure TfrmFatParams.Button1Click(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if not isNumeric(txtFATNUM.Text) then
  begin
    case prv_Tip of
    1:Application.MessageBox('Lütfen fatura numarasýný sayý ile giriniz.','Dikkat',MB_ICONERROR);
    2:Application.MessageBox('Lütfen irsaliye numarasýný sayý ile giriniz.','Dikkat',MB_ICONERROR);
    end;
    exit;
  end;
//****************************************************************************//
  case prv_Tip of
  1:
    begin
      if glb_SUBELI then
      begin
        DataMod.SET_SAYAC_NUM('SATIS_FATURA',StrToInt(txtFATNUM.Text),glb_SID);
        DataMod.SetParam(cns_fatparams,'FAT_SERI' ,txtSERINO.Text,glb_SID);
      end
      else
      begin
        DataMod.SET_SAYAC_NUM('SATIS_FATURA',StrToInt(txtFATNUM.Text),0);
        DataMod.SetParam(cns_fatparams,'FAT_SERI' ,txtSERINO.Text,0);
      end;
    end;
  2:
    begin
      if glb_SUBELI then
      begin
        DataMod.SET_SAYAC_NUM('SATIS_IRSALIYE',StrToInt(txtFATNUM.Text),glb_SID);
        DataMod.SetParam(cns_irsparams,'IRS_SERI' ,txtSERINO.Text,glb_SID);
      end
      else
      begin
        DataMod.SET_SAYAC_NUM('SATIS_IRSALIYE',StrToInt(txtFATNUM.Text),0);
        DataMod.SetParam(cns_irsparams,'IRS_SERI' ,txtSERINO.Text,0);
      end;
    end;
  end;//end case prv_tip of
//****************************************************************************//
end;

procedure TfrmFatParams.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFatParams.btnTAMAMClick(Sender: TObject);
begin
  if Application.MessageBox('Kaydetmek istiyor musunuz ?','Kayýt Ýþlemi',MB_ICONINFORMATION+MB_YESNO)= ID_YES Then
  begin
    qry_FatParams.Post;
  end;
  Close;
end;

procedure TfrmFatParams.btnIPTALClick(Sender: TObject);
begin
  qry_FatParams.Cancel;
  Close;
end;

procedure TfrmFatParams.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(Self);
end;

procedure TfrmFatParams.chk_EK_ACK_KULClick(Sender: TObject);
begin
  if chk_EK_ACK_KUL.Checked then
  begin
    pnlAck.Enabled := True;
  end
  else
  begin
    pnlAck.Enabled := False;
  end;
end;

procedure TfrmFatParams.IB_Edit2Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmFatParams.IB_Edit2Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmFatParams.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True);
  end;
end;

procedure TfrmFatParams.qry_FatParamsBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmFatParams.qry_FatParamsBeforeDelete(IB_Dataset: TIB_Dataset);
begin
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

end.
