{*******************************************************}
{                                                       }
{       TiImageDisplayComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iImageDisplayComponentEditor;{$endif}
{$ifdef iCLX}unit QiImageDisplayComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iImageDisplay,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiImageDisplay,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes,{$ENDIF}

  {$IFDEF iVCL}  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,  iComponentEditorImageEditorPanel,
  iComponent, iVCLComponent, iCustomComponent, iCheckBox, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel, QiComponentEditorImageEditorPanel;{$ENDIF}


type
  TiImageDisplayComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label31: TLabel;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    ImagesTabSheet: TTabSheet;
    ImageEditorPanel: TiComponentEditorImageEditorPanel;
    Label1: TLabel;
    ImageIndexUpDown: TiUpDown;
    ImageIndexEdit: TiComponentEditorEdit;
    TimerGroupBox: TGroupBox;
    TimerAutoRepeatCheckBox: TiComponentEditorCheckBox;
    Label2: TLabel;
    TimerIntervalUpDown: TiUpDown;
    TimerIntervalEdit: TiComponentEditorEdit;
    TimerIncrementUpCheckBox: TiComponentEditorCheckBox;
    TimerEnabledCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iImageDisplayComponentEditorForm: TiImageDisplayComponentEditorForm;

implementation

{$R *.dfm}
type
  TiImageDisplayAccess = class(TiImageDisplay) end;
//****************************************************************************************************************************************************
procedure TiImageDisplayComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiImageDisplay.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiImageDisplayComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iImageDisplay : TiImageDisplay;
begin
  iImageDisplay := Component as TiImageDisplay;

  ImageIndexEdit.AsInteger           := iImageDisplay.ImageIndex;
  AutoSizeCheckBox.AsBoolean         := iImageDisplay.AutoSize;
  TimerEnabledCheckBox.AsBoolean     := iImageDisplay.TimerEnabled;
  TimerAutoRepeatCheckBox.AsBoolean  := iImageDisplay.TimerAutoRepeat;
  TimerIncrementUpCheckBox.AsBoolean := iImageDisplay.TimerIncrementUp;
  TimerIntervalEdit.AsInteger        := iImageDisplay.TimerInterval;

  BorderStyleRadioGroup.AsInteger    := ord(iImageDisplay.BorderStyle);
  BackGroundColorPicker.Color        := iImageDisplay.BackGroundColor;

  ImageEditorPanel.UpLoad(TiImageDisplayAccess(iImageDisplay).ImageList);

  UpLoadOPCProperties(iImageDisplay, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiImageDisplayComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iImageDisplay : TiImageDisplay;
begin
  iImageDisplay := Component as TiImageDisplay;

  iImageDisplay.ImageIndex       :=  ImageIndexEdit.AsInteger;
  iImageDisplay.AutoSize         :=  AutoSizeCheckBox.AsBoolean;
  iImageDisplay.TimerEnabled     :=  TimerEnabledCheckBox.AsBoolean;
  iImageDisplay.TimerAutoRepeat  :=  TimerAutoRepeatCheckBox.AsBoolean;
  iImageDisplay.TimerIncrementUp :=  TimerIncrementUpCheckBox.AsBoolean;
  iImageDisplay.TimerInterval    :=  TimerIntervalEdit.AsInteger;

  iImageDisplay.BorderStyle      :=  tiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iImageDisplay.BackGroundColor  :=  BackGroundColorPicker.Color;

  ImageEditorPanel.DownLoad(TiImageDisplayAccess(iImageDisplay).ImageList);

  DownLoadOPCProperties(iImageDisplay, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.


