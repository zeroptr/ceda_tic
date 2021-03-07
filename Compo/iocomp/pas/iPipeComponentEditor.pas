{*******************************************************}
{                                                       }
{       TiPipeComponentEditor                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPipeComponentEditor;{$endif}
{$ifdef iCLX}unit QiPipeComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iPipe,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiPipe,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes,{$ENDIF}

  {$IFDEF iVCL}  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,  iComponent,  iVCLComponent,  iCustomComponent,  iCheckBox,
  iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel, QiComponent, QiCLXComponent, QiCustomComponent, QiCheckBox;{$ENDIF}


type
  TiPipeComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label31: TLabel;
    TubeColorPicker: TiComponentEditorColorPicker;
    FlowGroupBox: TGroupBox;
    Label2: TLabel;
    FlowIntervalUpDown: TiUpDown;
    FlowIntervalEdit: TiComponentEditorEdit;
    FlowOnCheckBox: TiComponentEditorCheckBox;
    FlowReverseCheckBox: TiComponentEditorCheckBox;
    FlowIndicatorGroupBox: TGroupBox;
    FlowIndicatorStyleRadioGroup: TiComponentEditorRadioGroup;
    Label1: TLabel;
    FlowIndicatorSizeUpDown: TiUpDown;
    FlowIndicatorSizeEdit: TiComponentEditorEdit;
    Label44: TLabel;
    FlowIndicatorSpacingUpDown: TiUpDown;
    FlowIndicatorSpacingEdit: TiComponentEditorEdit;
    Label3: TLabel;
    FlowIndicatorColorPicker: TiComponentEditorColorPicker;
    FlowIndicatorHideWhenOffCheckBox: TiComponentEditorCheckBox;
    FlowIndicatorUseTubeColorCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iPipeComponentEditorForm: TiPipeComponentEditorForm;

implementation

{$R *.dfm}
type
  TiPipeAccess = class(TiPipe) end;
//****************************************************************************************************************************************************
procedure TiPipeComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiPipe.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiPipeComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iPipe : TiPipe;
begin
  iPipe := Component as TiPipe;

  TubeColorPicker.Color                       := iPipe.TubeColor;
  FlowOnCheckBox.AsBoolean                    := iPipe.FlowOn;
  FlowIntervalEdit.AsInteger                  := iPipe.FlowInterval;
  FlowReverseCheckBox.AsBoolean               := iPipe.FlowReverse;
  FlowIndicatorStyleRadioGroup.AsInteger      := ord(iPipe.FlowIndicatorStyle);
  FlowIndicatorSizeEdit.AsInteger             := iPipe.FlowIndicatorSize;
  FlowIndicatorSpacingEdit.AsInteger          := iPipe.FlowIndicatorSpacing;
  FlowIndicatorColorPicker.Color              := iPipe.FlowIndicatorColor;
  FlowIndicatorHideWhenOffCheckBox.AsBoolean  := iPipe.FlowIndicatorHideWhenOff;
  FlowIndicatorUseTubeColorCheckBox.AsBoolean := iPipe.FlowIndicatorUseTubeColor;

  UpLoadOPCProperties(iPipe, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiPipeComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iPipe : TiPipe;
begin
  iPipe := Component as TiPipe;

  iPipe.TubeColor                 := TubeColorPicker.Color;
  iPipe.FlowOn                    := FlowOnCheckBox.AsBoolean;
  iPipe.FlowInterval              := FlowIntervalEdit.AsInteger;
  iPipe.FlowReverse               := FlowReverseCheckBox.AsBoolean;
  iPipe.FlowIndicatorStyle        := TiPipeFlowIndicatorStyle(FlowIndicatorStyleRadioGroup.AsInteger);
  iPipe.FlowIndicatorSize         := FlowIndicatorSizeEdit.AsInteger;
  iPipe.FlowIndicatorSpacing      := FlowIndicatorSpacingEdit.AsInteger;
  iPipe.FlowIndicatorColor        := FlowIndicatorColorPicker.Color;
  iPipe.FlowIndicatorHideWhenOff  := FlowIndicatorHideWhenOffCheckBox.AsBoolean;
  iPipe.FlowIndicatorUseTubeColor := FlowIndicatorUseTubeColorCheckBox.AsBoolean;

  DownLoadOPCProperties(iPipe, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.


