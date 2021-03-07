unit ufrmParametersTab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, IB_Controls, Grids, IB_Grid, Buttons,
  ExtCtrls, ComCtrls, Mask;

type
  TfrmParametersTab = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    btnExit: TBitBtn;
    GroupBox2: TGroupBox;
    IB_Grid3: TIB_Grid;
    Panel1: TPanel;
    IB_Grid4: TIB_Grid;
    IB_Memo2: TIB_Memo;
    Label1: TLabel;
    qry_Modul: TIB_Query;
    dts_Modul: TIB_DataSource;
    dts_Parameters: TIB_DataSource;
    qry_Parameters: TIB_Query;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    Edit3: TEdit;
    btn_Kaydet: TButton;
    btn_Iptal: TButton;
////////////////////////////////////////////////////////////////////////////////
    function Form_Open(Menu: Boolean): Integer;
    procedure data_kaydet();
    procedure data_getir();
////////////////////////////////////////////////////////////////////////////////
    procedure btnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure bosluk_kontrol(kontrol : TEdit);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure btn_IptalClick(Sender: TObject);
    procedure btn_KaydetClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmParametersTab: TfrmParametersTab;
implementation
uses unDataMod,unFunc;

{$R *.dfm}
function TfrmParametersTab.Form_Open(Menu: Boolean): Integer;
begin
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Application.CreateForm(TfrmParametersTab, frmParametersTab);
  frmParametersTab.PageControl1.ActivePageIndex := 0;
  if glb_YONETICI then
  begin
    with frmParametersTab do
    begin
      Edit1.Enabled := true;
      Edit2.Enabled := true;
      Edit3.Enabled := true;
      CheckBox1.Enabled := true;
      btn_Kaydet.Enabled := true;
      btn_Iptal.Enabled := true;
    end;
  end
  else
  begin
    with frmParametersTab do
    begin
      Edit1.Enabled := false;
      Edit2.Enabled := false;
      Edit3.Enabled := false;
      CheckBox1.Enabled := false;
      btn_Kaydet.Enabled := false;
      btn_Iptal.Enabled := false;
    end;
  end;
  with frmParametersTab do
  begin
    qry_Modul.Active := True;
    qry_Parameters.Active := True;
    data_getir;
////////////////////////////////////////////////////////////////////////////////
    ShowModal;
    Release;
  end;
end;


procedure TfrmParametersTab.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmParametersTab.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  qry_Modul.Active := False;
  qry_Parameters.Active := False;
end;

procedure TfrmParametersTab.PageControl1Change(Sender: TObject);
//var
//  strSQL : String;
begin
  case PageControl1.ActivePageIndex of
  0:
    begin
////////////////////////////////////////////////////////////////////////////////
      with qry_Modul do
      begin
        Active := false;
        SQL.Clear;
        SQL.Add('SELECT * FROM MODUL');
        Active := true;
      end;
////////////////////////////////////////////////////////////////////////////////
      with qry_Parameters do
      begin
        Active := False;
        if glb_YONETICI then
        begin
          Edit1.Enabled := true;
          Edit2.Enabled := true;
          Edit3.Enabled := true;
          CheckBox1.Enabled := true;
          btn_Kaydet.Enabled := true;
          btn_Iptal.Enabled := true;
        end
        else
        begin
          Edit1.Enabled := false;
          Edit2.Enabled := false;
          Edit3.Enabled := false;
          CheckBox1.Enabled := false;
          btn_Kaydet.Enabled := false;
          btn_Iptal.Enabled := false;
        end;
        SQL.Clear;
        SQL.Add('SELECT MODUL_ID,PARAM_NAME,DEGER FROM PARAMETERS WHERE KODLAMA = 0 AND MODUL_ID = 0 AND PARAM_NAME LIKE '+SQL_Katar('KOD%'));
        Active := True;
////////////////////////////////////////////////////////////////////////////////
        data_getir;
      end;//end with
    end;
  1:
    begin
      with qry_Modul do
      begin
        Active := false;
        SQL.Clear;
        SQL.Add('SELECT * FROM MODUL WHERE MODUL_ID <> 0');
        Active := true;
      end;
////////////////////////////////////////////////////////////////////////////////
      with qry_Parameters do
      begin
        Active := false;
        if glb_YONETICI then
        begin
          IB_Grid4.Enabled := true;
        end
        else
        begin
          IB_Grid4.Enabled := false;
        end;
        SQL.Clear;
        SQL.Add('SELECT MODUL_ID,PARAM_NAME,DEGER,PARAM_ACK FROM PARAMETERS WHERE KODLAMA = 1 AND MODUL_ID <> 0');
        Active := True;
      end;//end with qry_Parameters do
    end;
  end;//end case
end;

procedure TfrmParametersTab.bosluk_kontrol(kontrol: TEdit);
begin
  if length(TrimRight(TrimLeft(kontrol.text))) = 0 then
  begin
    Application.MessageBox('Üzerinde bulunduðunuz alaný boþ býrakamazsýnýz','Dikkat',MB_ICONWARNING);
    kontrol.SetFocus;
  end;
end;

procedure TfrmParametersTab.Edit1Exit(Sender: TObject);
begin
  bosluk_kontrol(edit1);
end;

procedure TfrmParametersTab.Edit2Exit(Sender: TObject);
begin
  bosluk_kontrol(edit2);
end;

procedure TfrmParametersTab.Edit3Exit(Sender: TObject);
begin
  bosluk_kontrol(edit3);
end;

procedure TfrmParametersTab.btn_IptalClick(Sender: TObject);
begin
  if Application.MessageBox('Yaptýðýnýz iþlemi iptal etmek istiyor musunuz?','Dikkat',MB_YESNO)=7 then
  begin
    exit;
  end;
  data_getir;
end;

procedure TfrmParametersTab.btn_KaydetClick(Sender: TObject);
begin
  case Application.MessageBox('Yapýlan deðiþiklikleri kaydetmek istediðinizden emin misiniz?','Dikkat',MB_ICONQUESTION+MB_YESNO) of
  6://yes
    begin
      data_kaydet;
    end;
  7://no
    begin
      data_getir;
    end;
  end;//end case
end;

procedure TfrmParametersTab.data_kaydet;
begin
  with frmParametersTab.qry_Parameters do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('PARAM_NAME').AsString = 'KODFILLCHAR' then
      begin
        FieldByName('DEGER').AsString := frmParametersTab.Edit1.Text;
      end;
////////////////////////////////////////////////////////////////////////////////
      if FieldByName('PARAM_NAME').AsString = 'KOD_LENGTH' then
      begin
        FieldByName('DEGER').AsString := frmParametersTab.Edit2.Text;
      end;
////////////////////////////////////////////////////////////////////////////////
      if FieldByName('PARAM_NAME').AsString = 'KOD_SUBE' then
      begin
        if frmParametersTab.CheckBox1.Checked then
        begin
          FieldByName('DEGER').AsString := '1';
        end
        else
        begin
          FieldByName('DEGER').AsString := '0';
        end;
      end;
////////////////////////////////////////////////////////////////////////////////
      if FieldByName('PARAM_NAME').AsString = 'KOD_SUBE_LENGTH' then
      begin
        FieldByName('DEGER').AsString := frmParametersTab.Edit3.Text;
      end;
////////////////////////////////////////////////////////////////////////////////
      Next;
    end;
  end;
end;

procedure TfrmParametersTab.data_getir;
begin
  with frmParametersTab.qry_Parameters do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('PARAM_NAME').AsString = 'KODFILLCHAR' then
      begin
        frmParametersTab.edit1.Text := FieldByName('DEGER').AsString;
      end;
////////////////////////////////////////////////////////////////////////////////
      if FieldByName('PARAM_NAME').AsString = 'KOD_LENGTH' then
      begin
        frmParametersTab.edit2.Text := FieldByName('DEGER').AsString;
      end;
////////////////////////////////////////////////////////////////////////////////
      if FieldByName('PARAM_NAME').AsString = 'KOD_SUBE' then
      begin
        if FieldByName('DEGER').AsString = '1' then
        begin
          frmParametersTab.CheckBox1.Checked := True;
        end;
        if FieldByName('DEGER').AsString = '0' then
        begin
          frmParametersTab.CheckBox1.Checked := True;
        end;
      end;
///////////////////////////////////////////////////////////////////////////////
      if FieldByName('PARAM_NAME').AsString = 'KOD_SUBE_LENGTH' then
      begin
        frmParametersTab.edit3.Text := FieldByName('DEGER').AsString
      end;
////////////////////////////////////////////////////////////////////////////////
      Next;
    end;
  end;
end;

procedure TfrmParametersTab.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl,True,True);
  end;
  if key = #27 then
  begin
    if btnExit.Enabled then btnExitClick(Self);
  end;
end;

end.
