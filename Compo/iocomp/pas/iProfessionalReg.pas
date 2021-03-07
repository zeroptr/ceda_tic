{$I iInclude.inc}

{$ifdef iVCL}unit  iProfessionalReg;{$endif}
{$ifdef iCLX}unit QiProfessionalReg;{$endif}

interface

uses
{$I iIncludeUses.inc}

{$IFDEF iVCL}{$ENDIF}
{$IFDEF iCLX}{$ENDIF}

{$ifdef iVCL}
  iAngularLogGauge,
  iCompass,
  iDualCompass,
  iImageDisplay,
  iKeyBoard,
  iLCDMatrix,
  iLedArrow,
  iLedDiamond,
  iLedMatrix,
  iLogGauge,
  iMotor,
  iObjectCanvas,
  iPanel,
  iPercentBar,
  iPhonePad,
  iPieChart,
  iPipe,
  iPipeJoint,
  iRotationDisplay,
  iSevenSegmentClockSMPTE,
  iSlidingCompass,
  iSlidingScale,
  iSpectrumDisplay,
  iSwitchLever,
  iSwitchQuad,
  iSwitchRocker,
  iSwitchRocker3Way,
  iTank,
  iThreadTimers,
  iTimers,
  iValve;
{$endif}

{$ifdef iCLX}
  QiAngularLogGauge,
  QiCompass,
  QiDualCompass,
  QiImageDisplay,
  QiKeyBoard,
  QiLCDMatrix,
  QiLedArrow,
  QiLedDiamond,
  QiLedMatrix,
  QiLogGauge,
  QiMotor,
  QiObjectCanvas,
  QiPanel,
  QiPercentBar,
  QiPhonePad,
  QiPieChart,
  QiPipe,
  QiPipeJoint,
  QiRotationDisplay,
  QiSevenSegmentClockSMPTE,
  QiSlidingCompass,
  QiSlidingScale,
  QiSpectrumDisplay,
  QiSwitchLever,
  QiSwitchQuad,
  QiSwitchRocker,
  QiSwitchRocker3Way,
  QiTank,
  QiThreadTimers,
  QiTimers,
  QiValve;
{$endif}

procedure Register;

implementation
//****************************************************************************************************************************************************
procedure Register;
begin
  RegisterComponents('Iocomp Pro', [TiAngularLogGauge]);
  RegisterComponents('Iocomp Pro', [TiCompass]);
  RegisterComponents('Iocomp Pro', [TiDualCompass]);
  RegisterComponents('Iocomp Pro', [TiImageDisplay]);
  RegisterComponents('Iocomp Pro', [TiKeyBoard]);
  RegisterComponents('Iocomp Pro', [TiLCDMatrix]);
  RegisterComponents('Iocomp Pro', [TiLedArrow]);
  RegisterComponents('Iocomp Pro', [TiLedDiamond]);
  RegisterComponents('Iocomp Pro', [TiLedMatrix]);
  RegisterComponents('Iocomp Pro', [TiLogGauge]);
  RegisterComponents('Iocomp Pro', [TiMotor]);
  RegisterComponents('Iocomp Pro', [TiObjectCanvas]);
  RegisterComponents('Iocomp Pro', [TiPanel]);
  RegisterComponents('Iocomp Pro', [TiPercentBar]);
  RegisterComponents('Iocomp Pro', [TiPhonePad]);
  RegisterComponents('Iocomp Pro', [TiPieChart]);
  RegisterComponents('Iocomp Pro', [TiPipe]);
  RegisterComponents('Iocomp Pro', [TiPipeJoint]);
  RegisterComponents('Iocomp Pro', [TiRotationDisplay]);
  RegisterComponents('Iocomp Pro', [TiSevenSegmentClockSMPTE]);
  RegisterComponents('Iocomp Pro', [TiSlidingCompass]);
  RegisterComponents('Iocomp Pro', [TiSlidingScale]);
  RegisterComponents('Iocomp Pro', [TiSpectrumDisplay]);
  RegisterComponents('Iocomp Pro', [TiSwitchLever]);
  RegisterComponents('Iocomp Pro', [TiSwitchQuad]);
  RegisterComponents('Iocomp Pro', [TiSwitchRocker]);
  RegisterComponents('Iocomp Pro', [TiSwitchRocker3Way]);
  RegisterComponents('Iocomp Pro', [TiTank]);
  RegisterComponents('Iocomp Pro', [TiThreadTimers]);
  RegisterComponents('Iocomp Pro', [TiTimers]);
  RegisterComponents('Iocomp Pro', [TiValve]);
end;
//****************************************************************************************************************************************************
end.
