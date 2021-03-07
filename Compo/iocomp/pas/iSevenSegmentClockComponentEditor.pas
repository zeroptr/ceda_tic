{*******************************************************}
{                                                       }
{       TiSevenSegmentClockComponentEditor              }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentClockComponentEditor;{$endif}
{$ifdef iCLX}unit QiSevenSegmentClockComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSevenSegmentClock,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSevenSegmentClock,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSevenSegmentClockComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    ShowOffSegmentsCheckBox: TiComponentEditorCheckBox;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    ShowHoursCheckBox: TiComponentEditorCheckBox;
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
    ShowSecondsCheckBox: TiComponentEditorCheckBox;
    HourStyleRadioGroup: TiComponentEditorRadioGroup;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    HourEdit: TiComponentEditorEdit;
    HourUpDown: TiUpDown;
    MinEdit: TiComponentEditorEdit;
    MinUpDown: TiUpDown;
    SecondEdit: TiComponentEditorEdit;
    SecondUpDown: TiUpDown;
    CountDirectionRadioGroup: TiComponentEditorRadioGroup;
    AutoSegmentOffColorCheckBox: TiComponentEditorCheckBox;
    SegmentOffColorPicker: TiComponentEditorColorPicker;
    Label5: TLabel;
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
  iSevenSegmentClockComponentEditorForm: TiSevenSegmentClockComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSevenSegmentClock.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockComponentEditorForm.HourMinSecChange(Sender: TObject);
begin
  TimeEdit.AsFloat := EncodeTime(HourEdit.AsInteger, MinEdit.AsInteger, SecondEdit.AsInteger, 0);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockComponentEditorForm.TimeChange(Sender: TObject);
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
procedure TiSevenSegmentClockComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSevenSegmentClock : TiSevenSegmentClock;
begin
  iSevenSegmentClock := Component as TiSevenSegmentClock;

  AutoSizeCheckBox.AsBoolean            := iSevenSegmentClock.AutoSize;
  ShowOffSegmentsCheckBox.AsBoolean     := iSevenSegmentClock.ShowOffSegments;
  AutoSegmentOffColorCheckBox.AsBoolean := iSevenSegmentClock.AutoSegmentOffColor;
  ShowHoursCheckBox.AsBoolean           := iSevenSegmentClock.ShowHours;
  ShowSecondsCheckBox.AsBoolean         := iSevenSegmentClock.ShowSeconds;
  TransparentCheckBox.AsBoolean         := iSevenSegmentClock.Transparent;
  AutoFrameRateCheckBox.AsBoolean       := iSevenSegmentClock.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iSevenSegmentClock.UpdateFrameRate;

  TimeEdit.AsFloat                      := iSevenSegmentClock.Time;

  BackGroundColorPicker.Color           := iSevenSegmentClock.BackGroundColor;

  CountDirectionRadioGroup.AsInteger    := ord(iSevenSegmentClock.CountDirection);
  BorderStyleRadioGroup.AsInteger       := ord(iSevenSegmentClock.BorderStyle);
  HourStyleRadioGroup.AsInteger         := ord(iSevenSegmentClock.HourStyle);

  DigitSpacingEdit.AsInteger            := iSevenSegmentClock.DigitSpacing;

  SegmentSizeEdit.AsInteger             := iSevenSegmentClock.SegmentSize;
  SegmentSeperationEdit.AsInteger       := iSevenSegmentClock.SegmentSeperation;
  SegmentMarginEdit.AsInteger           := iSevenSegmentClock.SegmentMargin;
  SegmentColorPicker.Color              := iSevenSegmentClock.SegmentColor;
  SegmentOffColorPicker.Color           := iSevenSegmentClock.SegmentOffColor;

  UpLoadOPCProperties(iSevenSegmentClock, iOPCBrowserPanel);

  TimeChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSevenSegmentClock : TiSevenSegmentClock;
begin
  iSevenSegmentClock := Component as TiSevenSegmentClock;

  iSevenSegmentClock.AutoSize            := AutoSizeCheckBox.AsBoolean;
  iSevenSegmentClock.ShowOffSegments     := ShowOffSegmentsCheckBox.AsBoolean;
  iSevenSegmentClock.AutoSegmentOffColor := AutoSegmentOffColorCheckBox.AsBoolean;
  iSevenSegmentClock.ShowHours           := ShowHoursCheckBox.AsBoolean;
  iSevenSegmentClock.ShowSeconds         := ShowSecondsCheckBox.AsBoolean;
  iSevenSegmentClock.Transparent         := TransparentCheckBox.AsBoolean;
  iSevenSegmentClock.AutoFrameRate       := AutoFrameRateCheckBox.AsBoolean;
  iSevenSegmentClock.UpdateFrameRate     := UpdateFrameRateEdit.AsInteger;

  iSevenSegmentClock.Time                := TimeEdit.AsFloat;

  iSevenSegmentClock.BackGroundColor     := BackGroundColorPicker.Color;

  iSevenSegmentClock.CountDirection      := TiCountDirection(CountDirectionRadioGroup.AsInteger);
  iSevenSegmentClock.BorderStyle         := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iSevenSegmentClock.HourStyle           := TiClockHourStyle(HourStyleRadioGroup.AsInteger);

  iSevenSegmentClock.DigitSpacing        := DigitSpacingEdit.AsInteger;

  iSevenSegmentClock.SegmentSize         := SegmentSizeEdit.AsInteger;
  iSevenSegmentClock.SegmentSeperation   := SegmentSeperationEdit.AsInteger;
  iSevenSegmentClock.SegmentMargin       := SegmentMarginEdit.AsInteger;
  iSevenSegmentClock.SegmentColor        := SegmentColorPicker.Color;
  iSevenSegmentClock.SegmentOffColor     := SegmentOffColorPicker.Color;

  DownLoadOPCProperties(iSevenSegmentClock, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
