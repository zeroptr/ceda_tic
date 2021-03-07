{$I iInclude.inc}

{$ifdef iVCL}unit  iInstrumentPackPropertyEditorsReg;{$endif}
{$ifdef iCLX}unit QiInstrumentPackPropertyEditorsReg;{$endif}

interface

uses
{$I iIncludeUses.inc}
{$IFDEF iVCL}{$IFDEF COMPILER_6_UP}DesignIntf, DesignEditors,{$ELSE}Dsgnintf,{$ENDIF} iComponentEditor,{$ENDIF}
{$IFDEF iCLX}DesignIntf, DesignEditors,                                              QiComponentEditor,{$ENDIF}

{$ifdef iVCL}
  iAnalogDisplay,           iAnalogDisplayComponentEditor,
  iAnalogOutput,            iAnalogOutputComponentEditor,
  iAngularGauge,            iAngularGaugeComponentEditor,
  iEdit,                    iEditComponentEditor,
  iGradient,                iGradientComponentEditor,
  iIntegerOutput,           iIntegerOutputComponentEditor,
  iKnob,                    iKnobComponentEditor,
  iLabel,                   iLabelComponentEditor,
  iLedBar,                  iLedBarComponentEditor,
  iLedRectangle,            iLedRectangleComponentEditor,
  iLedRound,                iLedRoundComponentEditor,
  iLedSpiral,               iLedSpiralComponentEditor,
  iLinearGauge,             iLinearGaugeComponentEditor,
  iModeComboBox,            iModeComboBoxComponentEditor,
  iOdometer,                iOdometerComponentEditor,
  iSevenSegmentAnalog,      iSevenSegmentAnalogComponentEditor,
  iSevenSegmentBinary,      iSevenSegmentBinaryComponentEditor,
  iSevenSegmentCharacter,   iSevenSegmentCharacterComponentEditor,
  iSevenSegmentClock,       iSevenSegmentClockComponentEditor,
  iSevenSegmentHexadecimal, iSevenSegmentHexadecimalComponentEditor,
  iSevenSegmentInteger,     iSevenSegmentIntegerComponentEditor,
  iSlider,                  iSliderComponentEditor,
  {$IFNDEF EVAL}
  iStripChart,              iStripChartComponentEditor,
  {$ENDIF}
  iSwitchLed,               iSwitchLedComponentEditor,
  iSwitchPanel,             iSwitchPanelComponentEditor,
  iSwitchRotary,            iSwitchRotaryComponentEditor,
  iSwitchSlider,            iSwitchSliderComponentEditor,
  iSwitchToggle,            iSwitchToggleComponentEditor,
  iThermometer,             iThermometerComponentEditor;
{$endif}

{$ifdef iCLX}
  QiAnalogDisplay,           QiAnalogDisplayComponentEditor,
  QiAnalogOutput,            QiAnalogOutputComponentEditor,
  QiAngularGauge,            QiAngularGaugeComponentEditor,
  QiEdit,                    QiEditComponentEditor,
  QiGradient,                QiGradientComponentEditor,
  QiIntegerOutput,           QiIntegerOutputComponentEditor,
  QiKnob,                    QiKnobComponentEditor,
  QiLabel,                   QiLabelComponentEditor,
  QiLedBar,                  QiLedBarComponentEditor,
  QiLedRectangle,            QiLedRectangleComponentEditor,
  QiLedRound,                QiLedRoundComponentEditor,
  QiLedSpiral,               QiLedSpiralComponentEditor,
  QiLinearGauge,             QiLinearGaugeComponentEditor,
  QiModeComboBox,            QiModeComboBoxComponentEditor,
  QiOdometer,                QiOdometerComponentEditor,
  QiSevenSegmentAnalog,      QiSevenSegmentAnalogComponentEditor,
  QiSevenSegmentBinary,      QiSevenSegmentBinaryComponentEditor,
  QiSevenSegmentCharacter,   QiSevenSegmentCharacterComponentEditor,
  QiSevenSegmentClock,       QiSevenSegmentClockComponentEditor,
  QiSevenSegmentHexadecimal, QiSevenSegmentHexadecimalComponentEditor,
  QiSevenSegmentInteger,     QiSevenSegmentIntegerComponentEditor,
  QiSlider,                  QiSliderComponentEditor,
  {$IFNDEF EVAL}
  QiStripChart,              QiStripChartComponentEditor,
  {$ENDIF}
  QiSwitchLed,               QiSwitchLedComponentEditor,
  QiSwitchPanel,             QiSwitchPanelComponentEditor,
  QiSwitchRotary,            QiSwitchRotaryComponentEditor,
  QiSwitchSlider,            QiSwitchSliderComponentEditor,
  QiSwitchToggle,            QiSwitchToggleComponentEditor,
  QiThermometer,             QiThermometerComponentEditor;
{$endif}

type
  TiAnalogDisplayComponentEditor           = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiAnalogOutputComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiAngularGaugeComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiEditComponentEditor                    = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiGradientComponentEditor                = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiIntegerOutputComponentEditor           = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiKnobComponentEditor                    = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiLabelComponentEditor                   = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiLedBarComponentEditor                  = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiLedRectangleComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiLedRoundComponentEditor                = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiLedSpiralComponentEditor               = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiLinearGaugeComponentEditor             = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiModeComboBoxComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiOdometerComponentEditor                = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSevenSegmentAnalogComponentEditor      = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSevenSegmentBinaryComponentEditor      = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSevenSegmentCharacterComponentEditor   = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSevenSegmentClockComponentEditor       = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSevenSegmentHexadecimalComponentEditor = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSevenSegmentIntegerComponentEditor     = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSliderComponentEditor                  = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  {$IFNDEF EVAL}
  TiStripChartComponentEditor              = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  {$ENDIF}
  TiSwitchLedComponentEditor               = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSwitchPanelComponentEditor             = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSwitchRotaryComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSwitchSliderComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSwitchToggleComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiThermometerComponentEditor             = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;

procedure Register;

implementation
//****************************************************************************************************************************************************
procedure TiAnalogDisplayComponentEditor.ExecuteVerb          (Index:Integer);begin DoEdit2(TiAnalogDisplayComponentEditorForm)           end;
procedure TiAnalogOutputComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiAnalogOutputComponentEditorForm)            end;
procedure TiAngularGaugeComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiAngularGaugeComponentEditorForm)            end;
procedure TiEditComponentEditor.ExecuteVerb                   (Index:Integer);begin DoEdit2(TiEditComponentEditorForm)                    end;
procedure TiGradientComponentEditor.ExecuteVerb               (Index:Integer);begin DoEdit2(TiGradientComponentEditorForm);               end;
procedure TiIntegerOutputComponentEditor.ExecuteVerb          (Index:Integer);begin DoEdit2(TiIntegerOutputComponentEditorForm)           end;
procedure TiKnobComponentEditor.ExecuteVerb                   (Index:Integer);begin DoEdit2(TiKnobComponentEditorForm);                   end;
procedure TiLabelComponentEditor.ExecuteVerb                  (Index:Integer);begin DoEdit2(TiLabelComponentEditorForm);                  end;
procedure TiLedBarComponentEditor.ExecuteVerb                 (Index:Integer);begin DoEdit2(TiLedBarComponentEditorForm);                 end;
procedure TiLedRectangleComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiLedRectangleComponentEditorForm);           end;
procedure TiLedRoundComponentEditor.ExecuteVerb               (Index:Integer);begin DoEdit2(TiLedRoundComponentEditorForm);               end;
procedure TiLedSpiralComponentEditor.ExecuteVerb              (Index:Integer);begin DoEdit2(TiLedSpiralComponentEditorForm);              end;
procedure TiLinearGaugeComponentEditor.ExecuteVerb            (Index:Integer);begin DoEdit2(TiLinearGaugeComponentEditorForm);            end;
procedure TiModeComboBoxComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiModeComboBoxComponentEditorForm)            end;
procedure TiOdometerComponentEditor.ExecuteVerb               (Index:Integer);begin DoEdit2(TiOdometerComponentEditorForm);               end;
procedure TiSevenSegmentAnalogComponentEditor.ExecuteVerb     (Index:Integer);begin DoEdit2(TiSevenSegmentAnalogComponentEditorForm);     end;
procedure TiSevenSegmentBinaryComponentEditor.ExecuteVerb     (Index:Integer);begin DoEdit2(TiSevenSegmentBinaryComponentEditorForm);     end;
procedure TiSevenSegmentCharacterComponentEditor.ExecuteVerb  (Index:Integer);begin DoEdit2(TiSevenSegmentCharacterComponentEditorForm);  end;
procedure TiSevenSegmentClockComponentEditor.ExecuteVerb      (Index:Integer);begin DoEdit2(TiSevenSegmentClockComponentEditorForm);      end;
procedure TiSevenSegmentHexadecimalComponentEditor.ExecuteVerb(Index:Integer);begin DoEdit2(TiSevenSegmentHexadecimalComponentEditorForm);end;
procedure TiSevenSegmentIntegerComponentEditor.ExecuteVerb    (Index:Integer);begin DoEdit2(TiSevenSegmentIntegerComponentEditorForm);    end;
procedure TiSliderComponentEditor.ExecuteVerb                 (Index:Integer);begin DoEdit2(TiSliderComponentEditorForm);                 end;
{$IFNDEF EVAL}
procedure TiStripChartComponentEditor.ExecuteVerb             (Index:Integer);begin DoEdit2(TiStripChartComponentEditorForm);             end;
  {$ENDIF}
procedure TiSwitchLedComponentEditor.ExecuteVerb              (Index:Integer);begin DoEdit2(TiSwitchLedComponentEditorForm);              end;
procedure TiSwitchPanelComponentEditor.ExecuteVerb            (Index:Integer);begin DoEdit2(TiSwitchPanelComponentEditorForm);            end;
procedure TiSwitchRotaryComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiSwitchRotaryComponentEditorForm);           end;
procedure TiSwitchSliderComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiSwitchSliderComponentEditorForm);           end;
procedure TiSwitchToggleComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiSwitchToggleComponentEditorForm);           end;
procedure TiThermometerComponentEditor.ExecuteVerb            (Index:Integer);begin DoEdit2(TiThermometerComponentEditorForm);            end;
//****************************************************************************************************************************************************
procedure Register;
begin
  RegisterComponentEditor(TiAnalogDisplay,           TiAnalogDisplayComponentEditor);
  RegisterComponentEditor(TiAnalogOutput,            TiAnalogOutputComponentEditor);
  RegisterComponentEditor(TiAngularGauge,            TiAngularGaugeComponentEditor);
  RegisterComponentEditor(TiEdit,                    TiEditComponentEditor);
  RegisterComponentEditor(TiGradient,                TiGradientComponentEditor);
  RegisterComponentEditor(TiIntegerOutput,           TiIntegerOutputComponentEditor);
  RegisterComponentEditor(TiKnob,                    TiKnobComponentEditor);
  RegisterComponentEditor(TiLabel,                   TiLabelComponentEditor);
  RegisterComponentEditor(TiLedBar,                  TiLedBarComponentEditor);
  RegisterComponentEditor(TiLedRectangle,            TiLedRectangleComponentEditor);
  RegisterComponentEditor(TiLedRound,                TiLedRoundComponentEditor);
  RegisterComponentEditor(TiLedSpiral,               TiLedSpiralComponentEditor);
  RegisterComponentEditor(TiLinearGauge,             TiLinearGaugeComponentEditor);
  RegisterComponentEditor(TiModeComboBox,            TiModeComboBoxComponentEditor);
  RegisterComponentEditor(TiOdometer,                TiOdometerComponentEditor);
  RegisterComponentEditor(TiSevenSegmentAnalog,      TiSevenSegmentAnalogComponentEditor);
  RegisterComponentEditor(TiSevenSegmentBinary,      TiSevenSegmentBinaryComponentEditor);
  RegisterComponentEditor(TiSevenSegmentCharacter,   TiSevenSegmentCharacterComponentEditor);
  RegisterComponentEditor(TiSevenSegmentClock,       TiSevenSegmentClockComponentEditor);
  RegisterComponentEditor(TiSevenSegmentHexadecimal, TiSevenSegmentHexadecimalComponentEditor);
  RegisterComponentEditor(TiSevenSegmentInteger,     TiSevenSegmentIntegerComponentEditor);
  RegisterComponentEditor(TiSlider,                  TiSliderComponentEditor);
  {$IFNDEF EVAL}
  RegisterComponentEditor(TiStripChart,              TiStripChartComponentEditor);
  {$ENDIF}
  RegisterComponentEditor(TiSwitchLed,               TiSwitchLedComponentEditor);
  RegisterComponentEditor(TiSwitchPanel,             TiSwitchPanelComponentEditor);
  RegisterComponentEditor(TiSwitchRotary,            TiSwitchRotaryComponentEditor);
  RegisterComponentEditor(TiSwitchSlider,            TiSwitchSliderComponentEditor);
  RegisterComponentEditor(TiSwitchToggle,            TiSwitchToggleComponentEditor);
  RegisterComponentEditor(TiThermometer,             TiThermometerComponentEditor);
end;
//****************************************************************************************************************************************************
end.
