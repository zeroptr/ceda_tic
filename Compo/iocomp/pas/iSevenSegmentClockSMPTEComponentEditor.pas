{*******************************************************}
{                                                       }
{       TiSevenSegmentClockSMPTEComponentEditor         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentClockSMPTEComponentEditor;{$endif}
{$ifdef iCLX}unit QiSevenSegmentClockSMPTEComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSevenSegmentClockSMPTE,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSevenSegmentClockSMPTE,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSevenSegmentClockSMPTEComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    ShowOffSegmentsCheckBox: TiComponentEditorCheckBox;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    ShowFieldNumberCheckBox: TiComponentEditorCheckBox;
    SegmentGroupBox: TGroupBox;
    Label2: TLabel;
    SegmentSeperationEdit: TiComponentEditorEdit;
    SegmentSeperationUpDown: TiUpDown;
    Label3: TLabel;
    SegmentSizeEdit: TiComponentEditorEdit;
    SegmentSizeUpDown: TiUpDown;
    Label4: TLabel;
    SegmentMarginEdit: TiComponentEditorEdit;
    SegmentMarginUpDown: TiUpDown;
    SegmentColorPicker: TiComponentEditorColorPicker;
    Label7: TLabel;
    DigitsGroupBox: TGroupBox;
    Label1: TLabel;
    DigitSpacingEdit: TiComponentEditorEdit;
    DigitSpacingUpDown: TiUpDown;
    Label8: TLabel;
    TimeEdit: TiComponentEditorEdit;
    ShowFrameNumberCheckBox: TiComponentEditorCheckBox;
    HourStyleRadioGroup: TiComponentEditorRadioGroup;
    Label5: TLabel;
    Label6: TLabel;
    FrameNumberEdit: TiComponentEditorEdit;
    FieldNumberEdit: TiComponentEditorEdit;
    FrameNumberUpDown: TiUpDown;
    FieldNumberUpDown: TiUpDown;
    FrameStyleRadioGroup: TiComponentEditorRadioGroup;
    Label9: TLabel;
    HourEdit: TiComponentEditorEdit;
    HourUpDown: TiUpDown;
    Label10: TLabel;
    MinEdit: TiComponentEditorEdit;
    MinUpDown: TiUpDown;
    Label11: TLabel;
    SecondEdit: TiComponentEditorEdit;
    SecondUpDown: TiUpDown;
    AutoSegmentOffColorCheckBox: TiComponentEditorCheckBox;
    SegmentOffColorPicker: TiComponentEditorColorPicker;
    Label12: TLabel;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label31: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    procedure HourMinSecChange(Sender: TObject);
    procedure TimeChange(Sender: TObject);
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSevenSegmentClockSMPTEComponentEditorForm: TiSevenSegmentClockSMPTEComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTEComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSevenSegmentClockSMPTE.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTEComponentEditorForm.HourMinSecChange(Sender: TObject);
begin
  TimeEdit.AsFloat := EncodeTime(HourEdit.AsInteger, MinEdit.AsInteger, SecondEdit.AsInteger, 0);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTEComponentEditorForm.TimeChange(Sender: TObject);
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  DecodeTime(TimeEdit.AsFloat, Hour, Min, Sec, MSec);

  HourEdit.AsInteger    := Hour;
  MinEdit.AsInteger     := Min;
  SecondEdit.AsInteger  := Sec;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTEComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSevenSegmentClockSMPTE : TiSevenSegmentClockSMPTE;
begin
  iSevenSegmentClockSMPTE := Component as TiSevenSegmentClockSMPTE;

  TimeEdit.AsFloat                      := iSevenSegmentClockSMPTE.Time;

  HourEdit.AsInteger                    := iSevenSegmentClockSMPTE.Hours;
  MinEdit.AsInteger                     := iSevenSegmentClockSMPTE.Minutes;
  SecondEdit.AsInteger                  := iSevenSegmentClockSMPTE.Seconds;

  FrameNumberEdit.AsInteger             := iSevenSegmentClockSMPTE.FrameNumber;
  FieldNumberEdit.AsInteger             := iSevenSegmentClockSMPTE.FieldNumber;

  AutoSizeCheckBox.AsBoolean            := iSevenSegmentClockSMPTE.AutoSize;
  ShowOffSegmentsCheckBox.AsBoolean     := iSevenSegmentClockSMPTE.ShowOffSegments;
  AutoSegmentOffColorCheckBox.AsBoolean := iSevenSegmentClockSMPTE.AutoSegmentOffColor;
  ShowFrameNumberCheckBox.AsBoolean     := iSevenSegmentClockSMPTE.ShowFrameNumber;
  ShowFieldNumberCheckBox.AsBoolean     := iSevenSegmentClockSMPTE.ShowFieldNumber;
  TransparentCheckBox.AsBoolean         := iSevenSegmentClockSMPTE.Transparent;
  AutoFrameRateCheckBox.AsBoolean       := iSevenSegmentClockSMPTE.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iSevenSegmentClockSMPTE.UpdateFrameRate;

  BackGroundColorPicker.Color           := iSevenSegmentClockSMPTE.BackGroundColor;

  FrameStyleRadioGroup.AsInteger        := ord(iSevenSegmentClockSMPTE.FrameStyle);
  HourStyleRadioGroup.AsInteger         := ord(iSevenSegmentClockSMPTE.HourStyle);
  BorderStyleRadioGroup.AsInteger       := ord(iSevenSegmentClockSMPTE.BorderStyle);

  DigitSpacingEdit.AsInteger            := iSevenSegmentClockSMPTE.DigitSpacing;

  SegmentSizeEdit.AsInteger             := iSevenSegmentClockSMPTE.SegmentSize;
  SegmentSeperationEdit.AsInteger       := iSevenSegmentClockSMPTE.SegmentSeperation;
  SegmentMarginEdit.AsInteger           := iSevenSegmentClockSMPTE.SegmentMargin;
  SegmentColorPicker.Color              := iSevenSegmentClockSMPTE.SegmentColor;
  SegmentOffColorPicker.Color           := iSevenSegmentClockSMPTE.SegmentOffColor;

  UpLoadOPCProperties(iSevenSegmentClockSMPTE, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTEComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSevenSegmentClockSMPTE : TiSevenSegmentClockSMPTE;
begin
  iSevenSegmentClockSMPTE := Component as TiSevenSegmentClockSMPTE;

  iSevenSegmentClockSMPTE.Time                := TimeEdit.AsFloat;
  iSevenSegmentClockSMPTE.FrameNumber         := FrameNumberEdit.AsInteger;
  iSevenSegmentClockSMPTE.FieldNumber         := FieldNumberEdit.AsInteger;


  iSevenSegmentClockSMPTE.AutoSize            := AutoSizeCheckBox.AsBoolean;
  iSevenSegmentClockSMPTE.ShowOffSegments     := ShowOffSegmentsCheckBox.AsBoolean;
  iSevenSegmentClockSMPTE.AutoSegmentOffColor := AutoSegmentOffColorCheckBox.AsBoolean;
  iSevenSegmentClockSMPTE.ShowFrameNumber     := ShowFrameNumberCheckBox.AsBoolean;
  iSevenSegmentClockSMPTE.ShowFieldNumber     := ShowFieldNumberCheckBox.AsBoolean;
  iSevenSegmentClockSMPTE.Transparent         := TransparentCheckBox.AsBoolean;
  iSevenSegmentClockSMPTE.AutoFrameRate       := AutoFrameRateCheckBox.AsBoolean;
  iSevenSegmentClockSMPTE.UpdateFrameRate     := UpdateFrameRateEdit.AsInteger;

  iSevenSegmentClockSMPTE.BackGroundColor     := BackGroundColorPicker.Color;

  iSevenSegmentClockSMPTE.FrameStyle          := TiFrameStyle(FrameStyleRadioGroup.AsInteger);
  iSevenSegmentClockSMPTE.HourStyle           := TiClockHourStyle(HourStyleRadioGroup.AsInteger);
  iSevenSegmentClockSMPTE.BorderStyle         := TiBevelStyle(BorderStyleRadioGroup.AsInteger);

  iSevenSegmentClockSMPTE.DigitSpacing        := DigitSpacingEdit.AsInteger;

  iSevenSegmentClockSMPTE.SegmentSize         := SegmentSizeEdit.AsInteger;
  iSevenSegmentClockSMPTE.SegmentSeperation   := SegmentSeperationEdit.AsInteger;
  iSevenSegmentClockSMPTE.SegmentMargin       := SegmentMarginEdit.AsInteger;
  iSevenSegmentClockSMPTE.SegmentColor        := SegmentColorPicker.Color;
  iSevenSegmentClockSMPTE.SegmentOffColor     := SegmentOffColorPicker.Color;

  DownLoadOPCProperties(iSevenSegmentClockSMPTE, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
