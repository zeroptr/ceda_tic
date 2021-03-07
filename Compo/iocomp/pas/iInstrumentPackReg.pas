{$I iInclude.inc}

{$ifdef iVCL}unit  iInstrumentPackReg;{$endif}
{$ifdef iCLX}unit QiInstrumentPackReg;{$endif}

interface

uses
{$I iIncludeUses.inc}

{$IFDEF iVCL}{$ENDIF}
{$IFDEF iCLX}{$ENDIF}

{$ifdef iVCL}
  iAnalogDisplay,
  iAnalogOutput,
  iAngularGauge,
  iEdit,
  iGradient,
  iIntegerOutput,
  iKnob,
  iLabel,
  iLedBar,
  iLedRectangle,
  iLedRound,
  iLedSpiral,
  iLinearGauge,
  iModeComboBox,
  iOdometer,
  iSevenSegmentAnalog,
  iSevenSegmentBinary,
  iSevenSegmentCharacter,
  iSevenSegmentClock,
  iSevenSegmentHexadecimal,
  iSevenSegmentInteger,
  iSlider,
  {$IFNDEF EVAL}
  iStripChart,
  {$ENDIF}
  iSwitchLed,
  iSwitchPanel,
  iSwitchRotary,
  iSwitchSlider,
  iSwitchToggle,
  iThermometer;
{$endif}

{$ifdef iCLX}
  QiAnalogDisplay,
  QiAnalogOutput,
  QiAngularGauge,
  QiEdit,
  QiGradient,
  QiIntegerOutput,
  QiKnob,
  QiLabel,
  QiLedBar,
  QiLedRectangle,
  QiLedRound,
  QiLedSpiral,
  QiLinearGauge,
  QiModeComboBox,
  QiOdometer,
  QiSevenSegmentAnalog,
  QiSevenSegmentBinary,
  QiSevenSegmentCharacter,
  QiSevenSegmentClock,
  QiSevenSegmentHexadecimal,
  QiSevenSegmentInteger,
  QiSlider,
  {$IFNDEF EVAL}
  QiStripChart,
  {$ENDIF}
  QiSwitchLed,
  QiSwitchPanel,
  QiSwitchRotary,
  QiSwitchSlider,
  QiSwitchToggle,
  QiThermometer;
{$endif}

procedure Register;

implementation
//****************************************************************************************************************************************************
procedure Register;
begin
  RegisterComponents('Iocomp Std', [TiAnalogDisplay]);
  RegisterComponents('Iocomp Std', [TiAnalogOutput]);
  RegisterComponents('Iocomp Std', [TiAngularGauge]);
  RegisterComponents('Iocomp Std', [TiEdit]);
  RegisterComponents('Iocomp Std', [TiGradient]);
  RegisterComponents('Iocomp Std', [TiIntegerOutput]);
  RegisterComponents('Iocomp Std', [TiKnob]);
  RegisterComponents('Iocomp Std', [TiLabel]);
  RegisterComponents('Iocomp Std', [TiLedBar]);
  RegisterComponents('Iocomp Std', [TiLedRectangle]);
  RegisterComponents('Iocomp Std', [TiLedRound]);
  RegisterComponents('Iocomp Std', [TiLedSpiral]);
  RegisterComponents('Iocomp Std', [TiLinearGauge]);
  RegisterComponents('Iocomp Std', [TiModeComboBox]);
  RegisterComponents('Iocomp Std', [TiOdometer]);
  RegisterComponents('Iocomp Std', [TiSevenSegmentAnalog]);
  RegisterComponents('Iocomp Std', [TiSevenSegmentBinary]);
  RegisterComponents('Iocomp Std', [TiSevenSegmentCharacter]);
  RegisterComponents('Iocomp Std', [TiSevenSegmentClock]);
  RegisterComponents('Iocomp Std', [TiSevenSegmentHexadecimal]);
  RegisterComponents('Iocomp Std', [TiSevenSegmentInteger]);
  RegisterComponents('Iocomp Std', [TiSlider]);
  {$IFNDEF EVAL}
  RegisterComponents('Iocomp Std', [TiStripChart]);
  {$ENDIF}
  RegisterComponents('Iocomp Std', [TiSwitchLed]);
  RegisterComponents('Iocomp Std', [TiSwitchPanel]);
  RegisterComponents('Iocomp Std', [TiSwitchRotary]);
  RegisterComponents('Iocomp Std', [TiSwitchSlider]);
  RegisterComponents('Iocomp Std', [TiSwitchToggle]);
  RegisterComponents('Iocomp Std', [TiThermometer]);
end;
//****************************************************************************************************************************************************
end.
