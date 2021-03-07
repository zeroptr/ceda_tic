{*******************************************************}
{                                                       }
{       iComponentEditorThemePanelMaintenance           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iComponentEditorThemePanelMaintenance;{$endif}
{$ifdef iCLX}unit QiComponentEditorThemePanelMaintenance;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}
  {$IFDEF iVCL}  iTypes,  iGPFunctions,  StdCtrls,  Controls, Classes, ComCtrls,   iClasses,  iEditorBasicComponents,  iComponentEditorThemePanel;{$ENDIF}
  {$IFDEF iCLX} QiTypes, QiGPFunctions, QStdCtrls, QControls, Classes, QComCtrls, QiClasses, QiEditorBasicComponents, QiComponentEditorThemePanel;{$ENDIF}

const
  CleanAllSchemesMessage  = 'Are you sure you want to clean all schemes of missing/erroneous properties?';

type
  TiComponentEditorThemePanelMaintenanceForm = class(TForm)
    iComponentEditorPageControl1: TiComponentEditorPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    iComponentEditorButton1: TiComponentEditorButton;
    iComponentEditorButton2: TiComponentEditorButton;
    FThemeListBox: TiComponentEditorListBox;
    FReorderListBox: TiComponentEditorListBox;
    CleanAllSchemesButton: TiComponentEditorButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure iComponentEditorButton1Click(Sender: TObject);
    procedure ReorderListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure FThemeListBoxClick(Sender: TObject);
    procedure FThemeListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure CleanAllSchemesButtonClick(Sender: TObject);
  private
    FThemePanel   : TiComponentEditorThemePanel;
    PreviousIndex : Integer;
    procedure SetThemePanel(const Value: TiComponentEditorThemePanel);
  public
    property    ThemePanel : TiComponentEditorThemePanel  read FThemePanel write SetThemePanel;
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
  end;

var
  iComponentEditorThemePanelMaintenanceForm: TiComponentEditorThemePanelMaintenanceForm;
implementation

{$R *.dfm}

//****************************************************************************************************************************************************
constructor TiComponentEditorThemePanelMaintenanceForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
//****************************************************************************************************************************************************
destructor TiComponentEditorThemePanelMaintenanceForm.Destroy;
begin
  inherited Destroy;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanelMaintenanceForm.iComponentEditorButton1Click(Sender: TObject);
begin
  (FThemeListBox.Items.Objects[PreviousIndex] as TStringList).Assign(FReorderListBox.Items);
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanelMaintenanceForm.ReorderListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
var
  SchemeList     : TStringList;
begin
  SchemeList := FReorderListBox.Items.Objects[Index] as TStringList;
  if SchemeList is TiUserSchemeList then
    begin
      AColor := clBlue;
      AText  := FReorderListBox.Items.Strings[Index];
    end
  else
    begin
      AColor := clRed;
      AText  := 'Iocomp Scheme Type Locked';
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanelMaintenanceForm.SetThemePanel(const Value: TiComponentEditorThemePanel);
var
  x              : Integer;
begin
  FThemePanel := Value;

  for x := 0 to ThemePanel.SchemeCount - 1 do
    begin
      FThemeListBox.Items.AddObject(ThemePanel.GetSchemeName(x), ThemePanel.GetSchemeList(x));
    end;
  FThemeListBox.Selected[0] := True;
  PreviousIndex := FThemeListBox.ItemIndex;
  FReorderListBox.Items.Assign(FThemeListBox.Items.Objects[FThemeListBox.ItemIndex] as TStringList);
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanelMaintenanceForm.FThemeListBoxClick(Sender: TObject);
begin
  (FThemeListBox.Items.Objects[PreviousIndex] as TStringList).Assign(FReorderListBox.Items);
  FReorderListBox.Items.Assign(FThemeListBox.Items.Objects[FThemeListBox.ItemIndex] as TStringList);
  PreviousIndex := FThemeListBox.ItemIndex;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanelMaintenanceForm.FThemeListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := clBlue;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanelMaintenanceForm.CleanAllSchemesButtonClick(Sender: TObject);
begin
  if MessageDlg(CleanAllSchemesMessage, mtWarning, [mbYes, mbNo], 0) = mrNo then exit;
  ThemePanel.CleanAllSchemes;
  ModalResult := mrCancel;
end;
//****************************************************************************************************************************************************
end.
