unit ufrmSETTINGS;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls,IniFiles, Buttons, ExtCtrls,GR32, ComCtrls;

type
  TfrmSettings = class(TForm)
    btnSaveSettings: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    txtRastering: TEdit;
    chkPRESCAN: TCheckBox;
    ColorDialog1: TColorDialog;
    TabSheet3: TTabSheet;
    Label9: TLabel;
    Label10: TLabel;
    cboPORTLIST: TComboBox;
    Label11: TLabel;
    cboCAP_DEVICE: TComboBox;
    Label1: TLabel;
    txtBaseColor: TEdit;
    btnChooseBaseColor: TSpeedButton;
    sqColor: TShape;
    sqAvarage_Color: TShape;
    btnChooseAvarage_Color: TSpeedButton;
    txtAverage_Color: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    txtEven_Color: TEdit;
    btnChooseEven_Color: TSpeedButton;
    sqEven_Color: TShape;
    Label3: TLabel;
    txtImageWidth: TEdit;
    Label8: TLabel;
    txtImageHeight: TEdit;
    procedure WriteSettings;
    Procedure ReadSettings;
    Procedure TextToVariables;
    procedure btnSaveSettingsClick(Sender: TObject);
    procedure btnChooseBaseColorClick(Sender: TObject);
    procedure btnChooseAvarage_ColorClick(Sender: TObject);
    procedure btnChooseEven_ColorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Function  EnumComPorts(Ports: TStringList):Boolean;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSettings: TfrmSettings;

implementation

uses MAIN,DSUtil, DirectShow9,unGLOBALS;

{$R *.dfm}

procedure TfrmSettings.WriteSettings;
var
  ServerIni: TIniFile;
begin
  ServerIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Settings.ini');
  ServerIni.WriteString('Settings', 'BaseColor', Trim(txtBaseColor.Text) );
  ServerIni.WriteString('Settings', 'Average_Color', Trim(txtAverage_Color.Text) );
  ServerIni.WriteString('Settings', 'Even_Color', Trim(txtEven_Color.Text) );
  ServerIni.WriteString('Settings', 'Rastering', Trim(txtRastering.Text) );
  ServerIni.WriteBool ('Settings','PreScan', chkPRESCAN.Checked);
  ServerIni.WriteString('Settings', 'ImageWidth', Trim(txtImageWidth.Text) );
  ServerIni.WriteString('Settings', 'ImageHeight', Trim(txtImageHeight.Text) );
  ServerIni.WriteString('Settings', 'ComPort', Trim(cboPORTLIST.Text) );
  ServerIni.WriteString('Settings', 'CapturingSource', Trim(cboCAP_DEVICE.Text));
  ServerIni.Free;
  TextToVariables;
end;

Procedure TfrmSettings.ReadSettings;
var
  ServerIni: TIniFile;
begin
  ServerIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Settings.ini');
  txtBaseColor.Text := ServerIni.ReadString('Settings', 'BaseColor', '');
  txtAverage_Color.Text := ServerIni.ReadString('Settings', 'Average_Color', '');
  txtEven_Color.Text := ServerIni.ReadString('Settings', 'Even_Color', '');
  txtRastering.Text := ServerIni.ReadString('Settings', 'Rastering', '10');
  chkPRESCAN.Checked := ServerIni.ReadBool('Settings','PreScan', FALSE);
  txtImageWidth.Text := ServerIni.ReadString('Settings', 'ImageWidth', '1024' );
  txtImageHeight.Text := ServerIni.ReadString('Settings', 'ImageHeight', '768' );
  cboPORTLIST.Text := ServerIni.ReadString('Settings', 'ComPort','' );
  cboCAP_DEVICE.Text := ServerIni.ReadString('Settings', 'CapturingSource','');
  ServerIni.Free;
  TextToVariables;
end;

Procedure TfrmSettings.TextToVariables;
begin
   if txtBaseColor.Text <> '' then begin glb_Base_Color := Color32(StringToColor(txtBaseColor.Text)); sqColor.Brush.Color := StringToColor(txtBaseColor.Text); end;
   if txtAverage_Color.Text <> '' then begin glb_Average_Color := Color32(StringToColor(txtAverage_Color.Text)); sqAvarage_Color.Brush.Color := StringToColor(txtAverage_Color.Text); end;
   if txtEven_Color.Text <> '' then begin glb_Even_Color := Color32(StringToColor(txtEven_Color.Text)); sqEven_Color.Brush.Color := StringToColor(txtEven_Color.Text); end;
   if txtRastering.Text <> '' then begin glb_Rastering := StrToInt(txtRastering.Text) end;
   glb_PRE_SCAN := chkPRESCAN.Checked;
   glb_ImageWidth := StrToInt(txtImageWidth.Text);
   glb_ImageHeight := StrToInt(txtImageHeight.Text);
   glb_ComPort := cboPORTLIST.Text;
   glb_CapturingSource := cboCAP_DEVICE.Text;
end;

procedure TfrmSettings.btnSaveSettingsClick(Sender: TObject);
begin
  WriteSettings;
  Close;
end;

procedure TfrmSettings.btnChooseBaseColorClick(Sender: TObject);
begin
 if ColorDialog1.Execute then
 begin
   txtBaseColor.Text := ColorToString(ColorDialog1.Color);
   sqColor.Brush.Color := ColorDialog1.Color;
 end;
end;

procedure TfrmSettings.btnChooseAvarage_ColorClick(Sender: TObject);
begin
 if ColorDialog1.Execute then
 begin
   txtAverage_Color.Text := ColorToString(ColorDialog1.Color);
   sqAvarage_Color.Brush.Color := ColorDialog1.Color;
 end;
end;

procedure TfrmSettings.btnChooseEven_ColorClick(Sender: TObject);
begin
 if ColorDialog1.Execute then
 begin
   txtEven_Color.Text := ColorToString(ColorDialog1.Color);
   sqEven_Color.Brush.Color := ColorDialog1.Color;
 end;
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
Var Ports:TStringList;
    i : Integer;
    SysDev: TSysDevEnum;
begin
   Ports := TStringList.Create;
   if EnumComPorts(Ports) then cboPORTLIST.Items.Assign(Ports) else cboPORTLIST.Items.Add('No Comport Found!' );
   cboPORTLIST.ItemIndex := 0;
   SysDev := TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
   if SysDev.CountFilters > 0 then
   begin
     for i := 0 to SysDev.CountFilters - 1 do
     begin
       cboCAP_DEVICE.Items.Add(SysDev.Filters[i].FriendlyName);
     end;
   end;
   frmSETTINGS.ReadSettings;
   TabSheet1.TabVisible:=False;
   TabSheet3.TabVisible:=False;
end;

Function TfrmSettings.EnumComPorts(Ports: TStringList):Boolean;
var
  KeyHandle: HKEY;
  ErrCode, Index: Integer;
  ValueName, Data: string;
  ValueLen, DataLen, ValueType: DWORD;
begin
  Result := True;
  ErrCode := RegOpenKeyEx(
    HKEY_LOCAL_MACHINE,
    'HARDWARE\DEVICEMAP\SERIALCOMM',
    0,
    KEY_READ,
    KeyHandle);

  if ErrCode <> ERROR_SUCCESS then Result := False;

  try
    Index := 0;
    repeat
      ValueLen := 256;
      DataLen := 256;
      SetLength(ValueName, ValueLen);
      SetLength(Data, DataLen);
      ErrCode := RegEnumValue(
        KeyHandle,
        Index,
        PChar(ValueName),
{$IFDEF DELPHI_4_OR_HIGHER}
        Cardinal(ValueLen),
{$ELSE}
        ValueLen,
{$ENDIF}
        nil,
        @ValueType,
        PByte(PChar(Data)),
        @DataLen);

      if ErrCode = ERROR_SUCCESS then
      begin
        SetLength(Data, DataLen);
        Ports.Add(Data);
        Inc(Index);
      end
      else
        if ErrCode <> ERROR_NO_MORE_ITEMS then  Result := False;

    until (ErrCode <> ERROR_SUCCESS) ;
  finally
    RegCloseKey(KeyHandle);
  end;
end;

procedure TfrmSettings.FormShow(Sender: TObject);
begin
   PageControl1.TabIndex := 0;
end;

procedure TfrmSettings.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 then Close;
end;

end.
