{$I iInclude.inc}

{$ifdef iVCL}unit  iProfessionalPropertyEditorsReg;{$endif}
{$ifdef iCLX}unit QiProfessionalPropertyEditorsReg;{$endif}

interface

uses
{$I iIncludeUses.inc}
{$IFDEF iVCL}{$IFDEF COMPILER_6_UP}DesignIntf, DesignEditors,{$ELSE}Dsgnintf,{$ENDIF} iComponentEditor,{$ENDIF}
{$IFDEF iCLX}DesignIntf, DesignEditors,                                              QiComponentEditor,{$ENDIF}

{$ifdef iVCL}
  iAngularLogGauge,         iAngularLogGaugeComponentEditor,
  iCompass,                 iCompassComponentEditor,
  iDualCompass,             iDualCompassComponentEditor,
  iImageDisplay,            iImageDisplayComponentEditor,
  iKeyBoard,                iKeyBoardComponentEditor,
  iLCDMatrix,               iLCDMatrixComponentEditor,
  iLedArrow,                iLedArrowComponentEditor,
  iLedDiamond,              iLedDiamondComponentEditor,
  iLedMatrix,               iLedMatrixComponentEditor,
  iLogGauge,                iLogGaugeComponentEditor,
  iMotor,                   iMotorComponentEditor,
  iObjectCanvas,            iObjectCanvasComponentEditor,
  iPanel,                   iPanelComponentEditor,
  iPercentBar,              iPercentBarComponentEditor,
  iPhonePad,                iPhonePadComponentEditor,
  iPieChart,                iPieChartComponentEditor,
  iPipe,                    iPipeComponentEditor,
  iPipeJoint,               iPipeJointComponentEditor,
  iRotationDisplay,         iRotationDisplayComponentEditor,
  iSevenSegmentClockSMPTE,  iSevenSegmentClockSMPTEComponentEditor,
  iSlidingCompass,          iSlidingCompassComponentEditor,
  iSlidingScale,            iSlidingScaleComponentEditor,
  iSpectrumDisplay,         iSpectrumDisplayComponentEditor,
  iSwitchLever,             iSwitchLeverComponentEditor,
  iSwitchQuad,              iSwitchQuadComponentEditor,
  iSwitchRocker,            iSwitchRockerComponentEditor,
  iSwitchRocker3Way,        iSwitchRocker3WayComponentEditor,
  iTank,                    iTankComponentEditor,
  iThreadTimers,            iThreadTimersComponentEditor,
  iTimers,                  iTimersComponentEditor,
  iValve,                   iValveComponentEditor;
{$endif}

{$ifdef iCLX}
  QiAngularLogGauge,         QiAngularLogGaugeComponentEditor,
  QiCompass,                 QiCompassComponentEditor,
  QiDualCompass,             QiDualCompassComponentEditor,
  QiImageDisplay,            QiImageDisplayComponentEditor,
  QiKeyBoard,                QiKeyBoardComponentEditor,
  QiLCDMatrix,               QiLCDMatrixComponentEditor,
  QiLedArrow,                QiLedArrowComponentEditor,
  QiLedDiamond,              QiLedDiamondComponentEditor,
  QiLedMatrix,               QiLedMatrixComponentEditor,
  QiLogGauge,                QiLogGaugeComponentEditor,
  QiMotor,                   QiMotorComponentEditor,
  QiObjectCanvas,            QiObjectCanvasComponentEditor,
  QiPanel,                   QiPanelComponentEditor,
  QiPercentBar,              QiPercentBarComponentEditor,
  QiPhonePad,                QiPhonePadComponentEditor,
  QiPieChart,                QiPieChartComponentEditor,
  QiPipe,                    QiPipeComponentEditor,
  QiPipeJoint,               QiPipeJointComponentEditor,
  QiRotationDisplay,         QiRotationDisplayComponentEditor,
  QiSevenSegmentClockSMPTE,  QiSevenSegmentClockSMPTEComponentEditor,
  QiSlidingCompass,          QiSlidingCompassComponentEditor,
  QiSlidingScale,            QiSlidingScaleComponentEditor,
  QiSpectrumDisplay,         QiSpectrumDisplayComponentEditor,
  QiSwitchLever,             QiSwitchLeverComponentEditor,
  QiSwitchQuad,              QiSwitchQuadComponentEditor,
  QiSwitchRocker,            QiSwitchRockerComponentEditor,
  QiSwitchRocker3Way,        QiSwitchRocker3WayComponentEditor,
  QiTank,                    QiTankComponentEditor,
  QiThreadTimers,            QiThreadTimersComponentEditor,
  QiTimers,                  QiTimersComponentEditor,
  QiValve,                   QiValveComponentEditor;
{$endif}

type
  TiAngularLogGaugeComponentEditor         = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiCompassComponentEditor                 = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiDualCompassComponentEditor             = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiImageDisplayComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiKeyBoardComponentEditor                = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiLCDMatrixComponentEditor               = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiLedArrowComponentEditor                = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiLedDiamondComponentEditor              = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiLedMatrixComponentEditor               = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiLogGaugeComponentEditor                = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiMotorComponentEditor                   = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiObjectCanvasComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiPanelComponentEditor                   = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiPercentBarComponentEditor              = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiPhonePadComponentEditor                = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiPieChartComponentEditor                = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiPipeComponentEditor                    = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiPipeJointComponentEditor               = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiRotationDisplayComponentEditor         = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSevenSegmentClockSMPTEComponentEditor  = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSlidingCompassComponentEditor          = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSlidingScaleComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSpectrumDisplayComponentEditor         = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSwitchLeverComponentEditor             = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSwitchQuadComponentEditor              = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSwitchRocker3WayComponentEditor        = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiSwitchRockerComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiTankComponentEditor                    = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiThreadTimersComponentEditor            = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiTimersComponentEditor                  = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiValveComponentEditor                   = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;

procedure Register;

implementation
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditor.ExecuteVerb        (Index:Integer);begin DoEdit2(TiAngularLogGaugeComponentEditorForm);       end;
procedure TiCompassComponentEditor.ExecuteVerb                (Index:Integer);begin DoEdit2(TiCompassComponentEditorForm);               end;
procedure TiDualCompassComponentEditor.ExecuteVerb            (Index:Integer);begin DoEdit2(TiDualCompassComponentEditorForm);           end;
procedure TiImageDisplayComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiImageDisplayComponentEditorForm);          end;
procedure TiKeyBoardComponentEditor.ExecuteVerb               (Index:Integer);begin DoEdit2(TiKeyBoardComponentEditorForm);              end;
procedure TiLCDMatrixComponentEditor.ExecuteVerb              (Index:Integer);begin DoEdit2(TiLCDMatrixComponentEditorForm);             end;
procedure TiLedArrowComponentEditor.ExecuteVerb               (Index:Integer);begin DoEdit2(TiLedArrowComponentEditorForm);              end;
procedure TiLedDiamondComponentEditor.ExecuteVerb             (Index:Integer);begin DoEdit2(TiLedDiamondComponentEditorForm);            end;
procedure TiLedMatrixComponentEditor.ExecuteVerb              (Index:Integer);begin DoEdit2(TiLedMatrixComponentEditorForm);             end;
procedure TiLogGaugeComponentEditor.ExecuteVerb               (Index:Integer);begin DoEdit2(TiLogGaugeComponentEditorForm);              end;
procedure TiMotorComponentEditor.ExecuteVerb                  (Index:Integer);begin DoEdit2(TiMotorComponentEditorForm);                 end;
procedure TiObjectCanvasComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiObjectCanvasComponentEditorForm);          end;
procedure TiPanelComponentEditor.ExecuteVerb                  (Index:Integer);begin DoEdit2(TiPanelComponentEditorForm);                 end;
procedure TiPercentBarComponentEditor.ExecuteVerb             (Index:Integer);begin DoEdit2(TiPercentBarComponentEditorForm);            end;
procedure TiPhonePadComponentEditor.ExecuteVerb               (Index:Integer);begin DoEdit2(TiPhonePadComponentEditorForm);              end;
procedure TiPieChartComponentEditor.ExecuteVerb               (Index:Integer);begin DoEdit2(TiPieChartComponentEditorForm);              end;
procedure TiPipeComponentEditor.ExecuteVerb                   (Index:Integer);begin DoEdit2(TiPipeComponentEditorForm);                  end;
procedure TiPipeJointComponentEditor.ExecuteVerb              (Index:Integer);begin DoEdit2(TiPipeJointComponentEditorForm);             end;
procedure TiRotationDisplayComponentEditor.ExecuteVerb        (Index:Integer);begin DoEdit2(TiRotationDisplayComponentEditorForm);       end;
procedure TiSevenSegmentClockSMPTEComponentEditor.ExecuteVerb (Index:Integer);begin DoEdit2(TiSevenSegmentClockSMPTEComponentEditorForm);end;
procedure TiSlidingCompassComponentEditor.ExecuteVerb         (Index:Integer);begin DoEdit2(TiSlidingCompassComponentEditorForm);        end;
procedure TiSlidingScaleComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiSlidingScaleComponentEditorForm);          end;
procedure TiSpectrumDisplayComponentEditor.ExecuteVerb        (Index:Integer);begin DoEdit2(TiSpectrumDisplayComponentEditorForm);       end;
procedure TiSwitchLeverComponentEditor.ExecuteVerb            (Index:Integer);begin DoEdit2(TiSwitchLeverComponentEditorForm);           end;
procedure TiSwitchQuadComponentEditor.ExecuteVerb             (Index:Integer);begin DoEdit2(TiSwitchQuadComponentEditorForm);            end;
procedure TiSwitchRocker3WayComponentEditor.ExecuteVerb       (Index:Integer);begin DoEdit2(TiSwitchRocker3WayComponentEditorForm);      end;
procedure TiSwitchRockerComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiSwitchRockerComponentEditorForm);          end;
procedure TiTankComponentEditor.ExecuteVerb                   (Index:Integer);begin DoEdit2(TiTankComponentEditorForm);                  end;
procedure TiThreadTimersComponentEditor.ExecuteVerb           (Index:Integer);begin DoEdit2(TiThreadTimersComponentEditorForm);          end;
procedure TiTimersComponentEditor.ExecuteVerb                 (Index:Integer);begin DoEdit2(TiTimersComponentEditorForm);                end;
procedure TiValveComponentEditor.ExecuteVerb                  (Index:Integer);begin DoEdit2(TiValveComponentEditorForm);                 end;
//****************************************************************************************************************************************************
procedure Register;
begin
  RegisterComponentEditor(TiAngularLogGauge,       TiAngularLogGaugeComponentEditor);           
  RegisterComponentEditor(TiCompass,               TiCompassComponentEditor);                   
  RegisterComponentEditor(TiDualCompass,           TiDualCompassComponentEditor);               
  RegisterComponentEditor(TiImageDisplay,          TiImageDisplayComponentEditor);
  RegisterComponentEditor(TiKeyBoard,              TiKeyBoardComponentEditor);                  
  RegisterComponentEditor(TiLCDMatrix,             TiLCDMatrixComponentEditor);                 
  RegisterComponentEditor(TiLedArrow,              TiLedArrowComponentEditor);                  
  RegisterComponentEditor(TiLedDiamond,            TiLedDiamondComponentEditor);                
  RegisterComponentEditor(TiLedMatrix,             TiLedMatrixComponentEditor);                 
  RegisterComponentEditor(TiLogGauge,              TiLogGaugeComponentEditor);                  
  RegisterComponentEditor(TiMotor,                 TiMotorComponentEditor);                     
  RegisterComponentEditor(TiObjectCanvas,          TiObjectCanvasComponentEditor);              
  RegisterComponentEditor(TiPanel,                 TiPanelComponentEditor);                     
  RegisterComponentEditor(TiPercentBar,            TiPercentBarComponentEditor);                
  RegisterComponentEditor(TiPhonePad,              TiPhonePadComponentEditor);                  
  RegisterComponentEditor(TiPieChart,              TiPieChartComponentEditor);                  
  RegisterComponentEditor(TiPipe,                  TiPipeComponentEditor);                      
  RegisterComponentEditor(TiPipeJoint,             TiPipeJointComponentEditor);                 
  RegisterComponentEditor(TiRotationDisplay,       TiRotationDisplayComponentEditor);           
  RegisterComponentEditor(TiSevenSegmentClockSMPTE,TiSevenSegmentClockSMPTEComponentEditor);    
  RegisterComponentEditor(TiSlidingCompass,        TiSlidingCompassComponentEditor);            
  RegisterComponentEditor(TiSlidingScale,          TiSlidingScaleComponentEditor);              
  RegisterComponentEditor(TiSpectrumDisplay,       TiSpectrumDisplayComponentEditor);           
  RegisterComponentEditor(TiSwitchLever,           TiSwitchLeverComponentEditor);               
  RegisterComponentEditor(TiSwitchQuad,            TiSwitchQuadComponentEditor);                
  RegisterComponentEditor(TiSwitchRocker3Way,      TiSwitchRocker3WayComponentEditor);          
  RegisterComponentEditor(TiSwitchRocker,          TiSwitchRockerComponentEditor);              
  RegisterComponentEditor(TiTank,                  TiTankComponentEditor);                      
  RegisterComponentEditor(TiThreadTimers,          TiThreadTimersComponentEditor);              
  RegisterComponentEditor(TiTimers,                TiTimersComponentEditor);                    
  RegisterComponentEditor(TiValve,                 TiValveComponentEditor);                     
end;
//****************************************************************************************************************************************************
end.
