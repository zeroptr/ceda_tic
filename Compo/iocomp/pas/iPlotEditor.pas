{*******************************************************}
{                                                       }
{       TiPlotXYComponentEditor                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotEditor;{$endif}
{$ifdef iCLX}unit QiPlotEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL}  iPlotMasterManager,  iPlotObjects,  iTypes, {$ENDIF}
  {$IFDEF iCLX} QiPlotMasterManager, QiPlotObjects, QiTypes, {$ENDIF}

  {$IFDEF iVCL} StdCtrls,  Controls,  ComCtrls,  ExtCtrls, Classes,  Menus,  iComponent,  iPlotLayoutViewer,  iVCLComponent,  iEditorBasicComponents,  iCustomComponent,  iCheckBox,  iRadioGroup;{$ENDIF}
  {$IFDEF iCLX}QStdCtrls, QControls, QComCtrls, QExtCtrls, Classes, QMenus, QiComponent, QiPlotLayoutViewer, QiCLXComponent, QiEditorBasicComponents, QiCustomComponent, QiCheckBox, QiRadioGroup;{$ENDIF}

type
  TiPlotEditorForm = class(TiCustomEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    LayoutTabSheet: TTabSheet;
    ChannelsTabSheet: TTabSheet;
    ChannelListBox: TiComponentEditorListBox;
    iChannelAddButton: TButton;
    ChannelRemoveButton: TButton;
    XAxesTabSheet: TTabSheet;
    YAxesTabSheet: TTabSheet;
    XAxisListBox: TiComponentEditorListBox;
    XAxesAddButton: TButton;
    XAxisRemoveButton: TButton;
    YAxisListBox: TiComponentEditorListBox;
    YAxesAddButton: TButton;
    YAxisRemoveButton: TButton;
    ToolBarTabSheet: TTabSheet;
    LegendTabSheet: TTabSheet;
    DataViewTabSheet: TTabSheet;
    ToolBarHiddenGroupBox: TGroupBox;
    Label64: TLabel;
    ToolBarListBox: TiComponentEditorListBox;
    ToolBarNameEdit: TiComponentEditorEdit;
    ChannelPageControl: TiComponentEditorPageControl;
    ChannelGeneralTabSheet: TTabSheet;
    ChannelMarkersTabSheet: TTabSheet;
    iPlotLayoutViewer: TiPlotLayoutViewer;
    XAxisPageControl: TiComponentEditorPageControl;
    XAxisGeneralTabSheet: TTabSheet;
    XAxisTitleTabSheet: TTabSheet;
    Label23: TLabel;
    Label44: TLabel;
    XAxisTitleMarginEdit: TiComponentEditorEdit;
    XAxisTitleFontPicker: TiComponentEditorFontPicker;
    XAxisTitleTextEdit: TiComponentEditorEdit;
    XAxisTitleShowCheckBox: TiComponentEditorCheckBox;
    XAxisScaleTabSheet: TTabSheet;
    Label25: TLabel;
    Label26: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    XAxisScaleLinesColorPicker: TiComponentEditorColorPicker;
    XAxisMajorLengthEdit: TiComponentEditorEdit;
    XAxisMajorLengthUpDown: TiUpDown;
    XAxisMinorCountEdit: TiComponentEditorEdit;
    XAxisMinorLengthEdit: TiComponentEditorEdit;
    XAxisMinorCountUpDown: TiUpDown;
    XAxisMinorLengthUpDown: TiUpDown;
    XaxisTrackingTabSheet: TTabSheet;
    Label43: TLabel;
    Label48: TLabel;
    Label50: TLabel;
    XAxisTrackingEnabledCheckBox: TiComponentEditorCheckBox;
    XAxisTrackingStyleComboBox: TiComponentEditorComboBox;
    XAxisTrackingScrollCompressMaxEdit: TiComponentEditorEdit;
    XAxisTrackingAlignFirstStyleComboBox: TiComponentEditorComboBox;
    YAxisPageControl: TiComponentEditorPageControl;
    YAxisGeneralTabSheet: TTabSheet;
    YAxisTitleTabSheet: TTabSheet;
    Label22: TLabel;
    Label27: TLabel;
    YAxisTitleMarginEdit: TiComponentEditorEdit;
    YAxisTitleTextEdit: TiComponentEditorEdit;
    YAxisTitleFontPicker: TiComponentEditorFontPicker;
    YAxisTitleShowCheckBox: TiComponentEditorCheckBox;
    YAxisScaleTabSheet: TTabSheet;
    YAxisLabelsTabSheet: TTabSheet;
    YAxisTrackingTabSheet: TTabSheet;
    Label47: TLabel;
    Label49: TLabel;
    Label51: TLabel;
    YAxisTrackingEnabledCheckBox: TiComponentEditorCheckBox;
    YAxisTrackingStyleComboBox: TiComponentEditorComboBox;
    YAxisTrackingScrollCompressMaxEdit: TiComponentEditorEdit;
    YAxisTrackingAlignFirstStyleComboBox: TiComponentEditorComboBox;
    ChannelFillTabSheet: TTabSheet;
    ChannelFillEnabledCheckBox: TiComponentEditorCheckBox;
    Label72: TLabel;
    ChannelFillReferenceEdit: TiComponentEditorEdit;
    ChannelFillUseChannelColorCheckBox: TiComponentEditorCheckBox;
    Label73: TLabel;
    ChannelFillStyleComboBox: TiComponentEditorComboBox;
    Label74: TLabel;
    ChannelFillColorPicker: TiComponentEditorColorPicker;
    ChannelTraceTabSheet: TTabSheet;
    Label3: TLabel;
    Label5: TLabel;
    ChannelTraceLineStyleComboBox: TiComponentEditorComboBox;
    ChannelTraceLineWidthEdit: TiComponentEditorEdit;
    ChannelTraceLineWidthUpDown: TiUpDown;
    ChannelTraceVisibleCheckBox: TiComponentEditorCheckBox;
    ChannelDigitalTabSheet: TTabSheet;
    ChannelDigitalEnabledCheckBox: TiComponentEditorCheckBox;
    Label83: TLabel;
    ChannelDigitalReferenceHighEdit: TiComponentEditorEdit;
    Label84: TLabel;
    ChannelDigitalReferenceLowEdit: TiComponentEditorEdit;
    Label85: TLabel;
    ChannelDigitalReferenceStyleComboBox: TiComponentEditorComboBox;
    ChannelFileIOTabSheet: TTabSheet;
    ChannelLogGroupBox: TGroupBox;
    Label86: TLabel;
    Label88: TLabel;
    ChannelLogFileNameEdit: TiComponentEditorEdit;
    ChannelLogBufferSizeEdit: TiComponentEditorEdit;
    ChannelLogBufferSizeUpDown: TiUpDown;
    ChannelPropertiesGroupBox: TGroupBox;
    ChannelLogActivateButton: TButton;
    ChannelLogDeactivateButton: TButton;
    ControlPageControl: TiComponentEditorPageControl;
    ControlGeneralTabSheet: TTabSheet;
    OuterMarginGroupBox: TGroupBox;
    OuterMarginLeftEdit: TiComponentEditorEdit;
    OuterMarginLeftUpDown: TiUpDown;
    OuterMarginTopEdit: TiComponentEditorEdit;
    OuterMarginTopUpDown: TiUpDown;
    OuterMarginBottomEdit: TiComponentEditorEdit;
    OuterMarginBottomUpDown: TiUpDown;
    OuterMarginRightEdit: TiComponentEditorEdit;
    OuterMarginRightUpDown: TiUpDown;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    ControlTitleTabSheet: TTabSheet;
    Label81: TLabel;
    Label82: TLabel;
    TitleTextEdit: TiComponentEditorEdit;
    TitleVisibleCheckBox: TiComponentEditorCheckBox;
    TitleFontPicker: TiComponentEditorFontPicker;
    TitleMarginEdit: TiComponentEditorEdit;
    ControlPrintTabSheet: TTabSheet;
    PrinterMarginGroupBox: TGroupBox;
    PrintMarginLeftEdit: TiComponentEditorEdit;
    PrintMarginTopEdit: TiComponentEditorEdit;
    PrintMarginBottomEdit: TiComponentEditorEdit;
    PrintMarginRightEdit: TiComponentEditorEdit;
    PrintOrientationRadioGroup: TiComponentEditorRadioGroup;
    PrintShowDialogCheckBox: TiComponentEditorCheckBox;
    ControlHintsTabSheet: TTabSheet;
    Label78: TLabel;
    Label79: TLabel;
    HintsShowCheckBox: TiComponentEditorCheckBox;
    HintsPauseEdit: TiComponentEditorEdit;
    HintsPauseUpDown: TiUpDown;
    HintsHidePauseEdit: TiComponentEditorEdit;
    HintsHidePauseUpDown: TiUpDown;
    ControlFileIOTabSheet: TTabSheet;
    FileIOPropertiesGroupBox: TGroupBox;
    ControlPropertiesOpenPicker: TiComponentEditorOpenPicker;
    ControlPropertiesSavePicker: TiComponentEditorSavePicker;
    FileIODataGroupBox: TGroupBox;
    ControlDataSavePicker: TiComponentEditorSavePicker;
    ControlDataOpenPicker: TiComponentEditorOpenPicker;
    ChannelPropertiesOpenPicker: TiComponentEditorOpenPicker;
    ChannelPropertiesSavePicker: TiComponentEditorSavePicker;
    ChannelDataGroupBox: TGroupBox;
    ChannelDataOpenPicker: TiComponentEditorOpenPicker;
    ChannelDataSavePicker: TiComponentEditorSavePicker;
    ChannelLogFileNamePicker: TiComponentEditorOpenPicker;
    LogGroupBox: TGroupBox;
    Label89: TLabel;
    Label90: TLabel;
    ControlLogFileNameEdit: TiComponentEditorEdit;
    ControlLogBufferSizeEdit: TiComponentEditorEdit;
    ControlLogBufferSizeUpDown: TiUpDown;
    ControlLogActivateButton: TButton;
    ControlLogDeactivateButton: TButton;
    ControlLogFileNamePicker: TiComponentEditorOpenPicker;
    TabSheet1: TTabSheet;
    ChannelStatsRefreshButton: TiComponentEditorButton;

    ChannelStatsPointCountLabel: TLabel;
    ChannelStatsMemoryLabel: TLabel;
    ChannelStatsXMinLabel: TLabel;
    ChannelStatsXMaxLabel: TLabel;
    ChannelStatsXMeanLabel: TLabel;
    ChannelStatsPointCountDisplay: TLabel;
    ChannelStatsMemoryDisplay: TLabel;
    ChannelStatsXMinDisplay: TLabel;
    ChannelStatsXMaxDisplay: TLabel;
    ChannelStatsXMeanDisplay: TLabel;
    ChannelStatsYMinLabel: TLabel;
    ChannelStatsYMaxLabel: TLabel;
    ChannelStatsYMeanLabel: TLabel;
    ChannelStatsYMinDisplay: TLabel;
    ChannelStatsYMaxDisplay: TLabel;
    ChannelStatsYMeanDisplay: TLabel;
    DataCursorTabSheet: TTabSheet;
    DataCursorPageControl: TiComponentEditorPageControl;
    DataCursorGeneralTabSheet: TTabSheet;
    DataCursorHintTabSheet: TTabSheet;
    Label100: TLabel;
    DataCursorHintShowCheckBox: TiComponentEditorCheckBox;
    DataCursorHintHideOnReleaseCheckBox: TiComponentEditorCheckBox;
    DataCursorOrientationSideRadioGroup: TiComponentEditorRadioGroup;
    DataCursorHintPositionEdit: TiComponentEditorEdit;
    DataCursorListBox: TiComponentEditorListBox;
    iDataCursorAddButton: TButton;
    DataCursorRemoveButton: TButton;
    XAxisInnerMarginUpDown: TiUpDown;
    XAxisOuterMarginUpDown: TiUpDown;
    Label20: TLabel;
    Label13: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label54: TLabel;
    XAxisInnerMarginEdit: TiComponentEditorEdit;
    XAxisOuterMarginEdit: TiComponentEditorEdit;
    XAxisStartPercentEdit: TiComponentEditorEdit;
    XAxisStopPercentEdit: TiComponentEditorEdit;
    XAxisStackingEndsMarginEdit: TiComponentEditorEdit;
    TabSheet2: TTabSheet;
    Label104: TLabel;
    XAxisCursorScalerEdit: TiComponentEditorEdit;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    YAxisMajorLengthUpDown: TiUpDown;
    YAxisMinorCountUpDown: TiUpDown;
    YAxisMinorLengthUpDown: TiUpDown;
    Label17: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label40: TLabel;
    Label55: TLabel;
    YAxisInnerMarginUpDown: TiUpDown;
    YAxisOuterMarginUpDown: TiUpDown;
    YAxisScaleLinesColorPicker: TiComponentEditorColorPicker;
    YAxisMajorLengthEdit: TiComponentEditorEdit;
    YAxisMinorCountEdit: TiComponentEditorEdit;
    YAxisMinorLengthEdit: TiComponentEditorEdit;
    YAxisInnerMarginEdit: TiComponentEditorEdit;
    YAxisOuterMarginEdit: TiComponentEditorEdit;
    YAxisStartPercentEdit: TiComponentEditorEdit;
    YAxisStopPercentEdit: TiComponentEditorEdit;
    YAxisStackingEndsMarginEdit: TiComponentEditorEdit;
    TabSheet3: TTabSheet;
    Label106: TLabel;
    YAxisCursorScalerEdit: TiComponentEditorEdit;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    DataCursorStyleComboBox: TiComponentEditorComboBox;
    DataCursorFontPicker: TiComponentEditorFontPicker;
    DataCursorColorPicker: TiComponentEditorColorPicker;
    DataCursorUseChannelColorCheckBox: TiComponentEditorCheckBox;
    DataCursorNameEdit: TiComponentEditorEdit;
    DataCursorPointer1PositionEdit: TiComponentEditorEdit;
    DataCursorPointer2PositionEdit: TiComponentEditorEdit;
    LimitTabSheet: TTabSheet;
    LimitListBox: TiComponentEditorListBox;
    iLimitAddButton: TButton;
    LimitRemoveButton: TButton;
    LimitPageControl: TiComponentEditorPageControl;
    LimitGeneralTabSheet: TTabSheet;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    LimitNameEdit: TiComponentEditorEdit;
    LimitXAxisNameComboBox: TiComponentEditorComboBox;
    LimitYAxisNameComboBox: TiComponentEditorComboBox;
    LimitStyleComboBox: TiComponentEditorComboBox;
    LimitLine1PositionEdit: TiComponentEditorEdit;
    LimitLine2PositionEdit: TiComponentEditorEdit;
    Label118: TLabel;
    Label117: TLabel;
    Label122: TLabel;
    LimitLineWidthUpDown: TiUpDown;
    Label123: TLabel;
    LimitColorPicker: TiComponentEditorColorPicker;
    LimitLineStyleComboBox: TiComponentEditorComboBox;
    LimitLineWidthEdit: TiComponentEditorEdit;
    LimitFillStyleCombobox: TiComponentEditorComboBox;
    LimitVisibleCheckBox: TiComponentEditorCheckBox;
    DataCursorPopupEnabledCheckBox: TiComponentEditorCheckBox;
    Label12: TLabel;
    Label19: TLabel;
    Label87: TLabel;
    Label94: TLabel;
    XAxisSpanEdit: TiComponentEditorEdit;
    XAxisMinEdit: TiComponentEditorEdit;
    XAxisVisibleCheckBox: TiComponentEditorCheckBox;
    XAxisReverseScaleCheckBox: TiComponentEditorCheckBox;
    XAxisNameEdit: TiComponentEditorEdit;
    XAxisScaleTypeRadioGroup: TiComponentEditorRadioGroup;
    XAxisMinTimePicker: TiComponentEditorValueConverterPicker;
    XAxisSpanTimePicker: TiComponentEditorValueConverterPicker;
    XAxisDesiredIncrementEdit: TiComponentEditorEdit;
    XAxisDesiredIncrementTimePicker: TiComponentEditorValueConverterPicker;
    XAxisEnabledCheckBox: TiComponentEditorCheckBox;
    XAxisPopupEnabledCheckBox: TiComponentEditorCheckBox;
    Label2: TLabel;
    Label16: TLabel;
    Label41: TLabel;
    Label95: TLabel;
    YAxisSpanEdit: TiComponentEditorEdit;
    YAxisMinEdit: TiComponentEditorEdit;
    YAxisVisibleCheckBox: TiComponentEditorCheckBox;
    YAxisReverseScaleCheckBox: TiComponentEditorCheckBox;
    YAxisNameEdit: TiComponentEditorEdit;
    YAxisScaleTypeRadioGroup: TiComponentEditorRadioGroup;
    YAxisMinTimePicker: TiComponentEditorValueConverterPicker;
    YAxisSpanTimePicker: TiComponentEditorValueConverterPicker;
    YAxisDesiredIncrementEdit: TiComponentEditorEdit;
    YAxisDesiredIncrementTimePicker: TiComponentEditorValueConverterPicker;
    YAxisEnabledCheckBox: TiComponentEditorCheckBox;
    YAxisPopupEnabledCheckBox: TiComponentEditorCheckBox;
    Label127: TLabel;
    ToolBarVisibleCheckBox: TiComponentEditorCheckBox;
    ToolBarEnabledCheckBox: TiComponentEditorCheckBox;
    ToolBarPopupEnabledCheckBox: TiComponentEditorCheckBox;
    ToolBarZoomInOutFactorEdit: TiComponentEditorEdit;
    XAxisRestoreValuesOnResumeCheckBox: TiComponentEditorCheckBox;
    YAxisRestoreValuesOnResumeCheckBox: TiComponentEditorCheckBox;
    Label1: TLabel;
    Label80: TLabel;
    Label91: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    XAxisScrollTabSheet: TTabSheet;
    YAxisScrollTabSheet: TTabSheet;
    Label130: TLabel;
    Label131: TLabel;
    XAxisScrollMinMaxEnabledCheckBox: TiComponentEditorCheckBox;
    XAxisScrollMinEdit: TiComponentEditorEdit;
    XAxisScrollMaxEdit: TiComponentEditorEdit;
    Label132: TLabel;
    Label133: TLabel;
    YAxisScrollMinMaxEnabledCheckBox: TiComponentEditorCheckBox;
    YAxisScrollMinEdit: TiComponentEditorEdit;
    YAxisScrollMaxEdit: TiComponentEditorEdit;
    LabelsTabSheet: TTabSheet;
    LabelListBox: TiComponentEditorListBox;
    iLabelAddButton: TButton;
    LabelRemoveButton: TButton;
    LabelPageControl: TiComponentEditorPageControl;
    TabSheet4: TTabSheet;
    Label135: TLabel;
    Label134: TLabel;
    Label136: TLabel;
    LabelNameEdit: TiComponentEditorEdit;
    LabelVisibleCheckBox: TiComponentEditorCheckBox;
    LabelFontPicker: TiComponentEditorFontPicker;
    LabelMarginGroupBox: TGroupBox;
    LabelMarginLeftEdit: TiComponentEditorEdit;
    LabelMarginTopEdit: TiComponentEditorEdit;
    LabelMarginBottomEdit: TiComponentEditorEdit;
    LabelMarginRightEdit: TiComponentEditorEdit;
    LabelCaptionMemo: TiComponentEditorEdit;
    LabelAlignmentComboBox: TiComponentEditorComboBox;
    XAxisMasterUIInputCheckBox: TiComponentEditorCheckBox;
    YAxisMasterUIInputCheckBox: TiComponentEditorCheckBox;
    Label112: TLabel;
    XAxisDesiredStartEdit: TiComponentEditorEdit;
    XAxisDesiredStartTimePicker: TiComponentEditorValueConverterPicker;
    Label113: TLabel;
    YAxisDesiredStartEdit: TiComponentEditorEdit;
    YAxisDesiredStartTimePicker: TiComponentEditorValueConverterPicker;
    HintsFontPicker: TiComponentEditorFontPicker;
    AnnotationDefaultsTabSheet: TTabSheet;
    ChannelHighLowTabSheet: TTabSheet;
    ToolBarShowGroupBox: TGroupBox;
    ToolBarShowEditButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowCopyButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowSaveButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowPrintButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowResumeButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowPauseButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowAxesModeButtonsCheckBox: TiComponentEditorCheckBox;
    ToolBarShowZoomInOutButtonsCheckBox: TiComponentEditorCheckBox;
    ToolBarShowZoomBoxButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowCursorButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowSelectButtonCheckBox: TiComponentEditorCheckBox;
    Label4: TLabel;
    Label6: TLabel;
    Label45: TLabel;
    Label42: TLabel;
    Label46: TLabel;
    Label77: TLabel;
    ChannelColorPicker: TiComponentEditorColorPicker;
    ChannelTitleEdit: TiComponentEditorEdit;
    ChannelNameEdit: TiComponentEditorEdit;
    ChannelXAxisNameComboBox: TiComponentEditorComboBox;
    ChannelXAxisTrackingEnabled: TiComponentEditorCheckBox;
    ChannelYAxisNameComboBox: TiComponentEditorComboBox;
    ChannelYAxisTrackingEnabled: TiComponentEditorCheckBox;
    ChannelVisibleCheckBox: TiComponentEditorCheckBox;
    ChannelVisibleInLegendCheckBox: TiComponentEditorCheckBox;
    ChannelRingBufferSizeEdit: TiComponentEditorEdit;
    ChannelPopupEnabledCheckBox: TiComponentEditorCheckBox;
    ChannelFastDrawCheckBox: TiComponentEditorCheckBox;
    LimitUserCanMoveCheckBox: TiComponentEditorCheckBox;
    FileIOAnnotationsGroupBox: TGroupBox;
    ControlAnnotationSavePicker: TiComponentEditorSavePicker;
    ControlAnnotationOpenPicker: TiComponentEditorOpenPicker;
    ChannelBarTabSheet: TTabSheet;
    DataViewPageControl: TiComponentEditorPageControl;
    DataViewGeneralTabSheet: TTabSheet;
    DataViewEnabledCheckBox: TiComponentEditorCheckBox;
    DataViewPopupEnabledCheckBox: TiComponentEditorCheckBox;
    DataViewBackgroundGroupBox: TGroupBox;
    Label66: TLabel;
    DataViewBackGroundTransparentCheckBox: TiComponentEditorCheckBox;
    DataViewBackgroundColorPicker: TiComponentEditorColorPicker;
    DataViewGridLinesTabSheet: TTabSheet;
    DataViewHiddenTabSheet: TTabSheet;
    DataViewHiddenGroupBox: TGroupBox;
    Label65: TLabel;
    DataViewListBox: TiComponentEditorListBox;
    DataViewNameEdit: TiComponentEditorEdit;
    DataViewGridGroupBox: TiComponentEditorGroupBox;
    Label67: TLabel;
    Label68: TLabel;
    DataViewGridXAxisNameComboBox: TiComponentEditorComboBox;
    DataViewGridYAxisNameComboBox: TiComponentEditorComboBox;
    DataViewGridShow: TiComponentEditorCheckBox;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    DataViewGridLineColorPicker: TiComponentEditorColorPicker;
    DataViewGridLineMajorStyleComboBox: TiComponentEditorComboBox;
    DataViewGridLineMinorStyleComboBox: TiComponentEditorComboBox;
    DataViewGridLineShowGroupBox: TGroupBox;
    DataViewGridLineShowLeft: TiComponentEditorCheckBox;
    DataViewGridLineShowRight: TiComponentEditorCheckBox;
    DataViewGridLineShowTop: TiComponentEditorCheckBox;
    DataViewGridLineShowBottom: TiComponentEditorCheckBox;
    DataViewGridLinesCustomPageControl: TiComponentEditorPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    DataViewGridLineXMajorCustomCheckBox: TiComponentEditorCheckBox;
    DataViewGridLineShowXMajorsCheckBox: TiComponentEditorCheckBox;
    DataViewGridLineXMinorCustomCheckBox: TiComponentEditorCheckBox;
    DataViewGridLineShowXMinorsCheckBox: TiComponentEditorCheckBox;
    DataViewGridLineYMajorCustomCheckBox: TiComponentEditorCheckBox;
    DataViewGridLineShowYMajorsCheckBox: TiComponentEditorCheckBox;
    DataViewGridLineYMinorCustomCheckBox: TiComponentEditorCheckBox;
    DataViewGridLineShowYMinorsCheckBox: TiComponentEditorCheckBox;
    DataViewXMajorsCustomGroupBox: TiComponentEditorGroupBox;
    Label148: TLabel;
    Label149: TLabel;
    DataViewGridLineXMajorWidthUpDown: TiUpDown;
    Label150: TLabel;
    DataViewGridLineXMajorColorColorPicker: TiComponentEditorColorPicker;
    DataViewGridLineXMajorWidthEdit: TiComponentEditorEdit;
    DataViewGridLineXMajorStyleComboBox: TiComponentEditorComboBox;
    DataViewXMinorsCustomGroupBox: TiComponentEditorGroupBox;
    Label151: TLabel;
    Label152: TLabel;
    DataViewGridLineXMinorWidthUpDown: TiUpDown;
    Label153: TLabel;
    DataViewGridLineXMinorColorColorPicker: TiComponentEditorColorPicker;
    DataViewGridLineXMinorWidthEdit: TiComponentEditorEdit;
    DataViewGridLineXMinorStyleComboBox: TiComponentEditorComboBox;
    DataViewYMajorsCustomGroupBox: TiComponentEditorGroupBox;
    Label154: TLabel;
    Label155: TLabel;
    DataViewGridLineYMajorWidthUpDown: TiUpDown;
    Label156: TLabel;
    DataViewGridLineYMajorColorColorPicker: TiComponentEditorColorPicker;
    DataViewGridLineYMajorWidthEdit: TiComponentEditorEdit;
    DataViewGridLineYMajorStyleComboBox: TiComponentEditorComboBox;
    DataViewYMinorsCustomGroupBox: TiComponentEditorGroupBox;
    Label157: TLabel;
    Label158: TLabel;
    DataViewGridLineYMinorWidthUpDown: TiUpDown;
    Label159: TLabel;
    DataViewGridLineYMinorColorColorPicker: TiComponentEditorColorPicker;
    DataViewGridLineYMinorWidthEdit: TiComponentEditorEdit;
    DataViewGridLineYMinorStyleComboBox: TiComponentEditorComboBox;
    Label61: TLabel;
    Label62: TLabel;
    ChannelMarkersSizeUpDown: TiUpDown;
    Label168: TLabel;
    ChannelMarkersTurnOffLimitUpDown: TiUpDown;
    ChannelMarkersPenGroupBox: TGroupBox;
    Label56: TLabel;
    Label58: TLabel;
    Label60: TLabel;
    ChannelMarkersPenWidthUpDown: TiUpDown;
    ChannelMarkersPenStyleComboBox: TiComponentEditorComboBox;
    ChannelMarkersPenColorPicker: TiComponentEditorColorPicker;
    ChannelMarkersPenWidthEdit: TiComponentEditorEdit;
    ChannelMarkersPenUseChannelColorCheckBox: TiComponentEditorCheckBox;
    ChannelMarkersBrushGroupBox: TGroupBox;
    Label57: TLabel;
    Label59: TLabel;
    ChannelMarkersBrushStyleComboBox: TiComponentEditorComboBox;
    ChannelMarkersBrushColorPicker: TiComponentEditorColorPicker;
    ChannelMarkersBrushUseChannelColorCheckBox: TiComponentEditorCheckBox;
    ChannelMarkersSizeEdit: TiComponentEditorEdit;
    ChannelMarkersStyleComboBox: TiComponentEditorComboBox;
    ChannelMarkersVisible: TiComponentEditorCheckBox;
    ChannelMarkersAllowIndividual: TiComponentEditorCheckBox;
    ChannelMarkersTurnOffLimitEdit: TiComponentEditorEdit;
    Label129: TLabel;
    Label137: TLabel;
    ChannelBarEnabledCheckBox: TiComponentEditorCheckBox;
    ChannelBarReferenceEdit: TiComponentEditorEdit;
    ChannelBarPenGroupBox: TGroupBox;
    Label138: TLabel;
    Label139: TLabel;
    Label145: TLabel;
    ChannelBarPenWidthUpDown: TiUpDown;
    ChannelBarPenStyleComboBox: TiComponentEditorComboBox;
    ChannelBarPenColorPicker: TiComponentEditorColorPicker;
    ChannelBarPenWidthEdit: TiComponentEditorEdit;
    ChannelBarPenUseChannelColorCheckBox: TiComponentEditorCheckBox;
    ChannelBarBrushGroupBox: TGroupBox;
    Label146: TLabel;
    Label147: TLabel;
    ChannelBarBrushStyleComboBox: TiComponentEditorComboBox;
    ChannelBarBrushColorPicker: TiComponentEditorColorPicker;
    ChannelBarBrushUseChannelColorCheckBox: TiComponentEditorCheckBox;
    ChannelBarWidthEdit: TiComponentEditorEdit;
    iComponentEditorValueConverterPicker1: TiComponentEditorValueConverterPicker;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    Label170: TLabel;
    CopyToClipBoardFormatComboBox: TiComponentEditorComboBox;
    LimitPopUpEnabledCheckBox: TiComponentEditorCheckBox;
    XAxisCartesianTabSheet: TTabSheet;
    Label160: TLabel;
    XAxisCartesianStyleComboBox: TiComponentEditorComboBox;
    Label161: TLabel;
    XAxisCartesianChildRefAxisNameComboBox: TiComponentEditorComboBox;
    Label162: TLabel;
    XAxisCartesianChildRefValueEdit: TiComponentEditorEdit;
    XAxisCartesianChildRefValuePicker: TiComponentEditorValueConverterPicker;
    YAxisCartesianTabSheet: TTabSheet;
    Label163: TLabel;
    YAxisCartesianStyleComboBox: TiComponentEditorComboBox;
    Label164: TLabel;
    YAxisCartesianChildRefAxisNameComboBox: TiComponentEditorComboBox;
    Label165: TLabel;
    YAxisCartesianChildRefValueEdit: TiComponentEditorEdit;
    YAxisCartesianChildRefValuePicker: TiComponentEditorValueConverterPicker;
    Label166: TLabel;
    Label167: TLabel;
    ChannelStatsDataPointSizeDisplay: TLabel;
    ChannelStatsMaxDataPointsDisplay: TLabel;
    Label172: TLabel;
    Label173: TLabel;
    Label169: TLabel;
    ChannelStatsPointCapacityDisplay: TLabel;
    Label174: TLabel;
    Label171: TLabel;
    ChannelDataStyleComboBox: TiComponentEditorComboBox;
    XAxisGridLinesVisibleCheckBox: TiComponentEditorCheckBox;
    YAxisGridLinesVisibleCheckBox: TiComponentEditorCheckBox;
    Label175: TLabel;
    PrintDocumentNameEdit: TiComponentEditorEdit;
    LegendPageControl: TiComponentEditorPageControl;
    General: TTabSheet;
    LegendColumnsTabSheet: TTabSheet;
    LegendHiddenTabSheet: TTabSheet;
    LegendHiddenGroupBox: TGroupBox;
    Label28: TLabel;
    LegendListBox: TiComponentEditorListBox;
    LegendNameEdit: TiComponentEditorEdit;
    Label63: TLabel;
    LegendColumnSpacingEdit: TiComponentEditorEdit;
    LegendFontPicker: TiComponentEditorFontPicker;
    LegendVisibleCheckbox: TiComponentEditorCheckBox;
    LegendEnabledCheckbox: TiComponentEditorCheckBox;
    LegendPopupEnabledCheckbox: TiComponentEditorCheckBox;
    LegendShowColumnGroupBox: TGroupBox;
    LegendShowXAxisTitleCheckbox: TiComponentEditorCheckBox;
    LegendShowYAxisTitleCheckbox: TiComponentEditorCheckBox;
    LegendShowMarkerCheckbox: TiComponentEditorCheckBox;
    LegendShowXValueCheckbox: TiComponentEditorCheckBox;
    LegendShowYValueCheckbox: TiComponentEditorCheckBox;
    LegendShowLineCheckbox: TiComponentEditorCheckBox;
    LegendShowYMaxCheckbox: TiComponentEditorCheckBox;
    LegendShowYMinCheckbox: TiComponentEditorCheckBox;
    LegendShowYMeanCheckbox: TiComponentEditorCheckBox;
    LegendColumnTitlesGroupBox: TGroupBox;
    LegendColumnTitlesVisibleCheckbox: TiComponentEditorCheckBox;
    LegendColumnTitlesFontPicker: TiComponentEditorFontPicker;
    Label176: TLabel;
    iUpDown2: TiUpDown;
    ChannelLayerEdit: TiComponentEditorEdit;
    Label177: TLabel;
    iUpDown3: TiUpDown;
    XAxisLayerEdit: TiComponentEditorEdit;
    Label178: TLabel;
    iUpDown4: TiUpDown;
    YAxisLayerEdit: TiComponentEditorEdit;
    Label179: TLabel;
    DataViewLayerUpDown: TiUpDown;
    DataViewLayerEdit: TiComponentEditorEdit;
    Label180: TLabel;
    LimitLayerUpDown: TiUpDown;
    LimitLayerEdit: TiComponentEditorEdit;
    LayoutPopupMenu: TPopupMenu;
    XYAxesReverseMenuItem: TMenuItem;
    N1: TMenuItem;
    AddXAxisMenuItem: TMenuItem;
    AddYAxisMenuItem: TMenuItem;
    AddLabelMenuItem: TMenuItem;
    N2: TMenuItem;
    DeleteMenuItem: TMenuItem;
    ClipAnnotationsToAxesCheckBox: TiComponentEditorCheckBox;
    XAxisScaleLinesShowCheckBox: TiComponentEditorCheckBox;
    YAxisScaleLinesShowCheckBox: TiComponentEditorCheckBox;
    VisibleMenuItem: TMenuItem;
    ToolBarFlatButtonsCheckBox: TiComponentEditorCheckBox;
    ToolBarSmallButtonsCheckBox: TiComponentEditorCheckBox;
    TabSheet9: TTabSheet;
    Label96: TLabel;
    DataCursorChannelNameComboBox: TiComponentEditorComboBox;
    DataCursorChannelAllowAllCheckBox: TiComponentEditorCheckBox;
    DataCursorChannelShowAllInLegendCheckBox: TiComponentEditorCheckBox;
    LegendWrapTabSheet: TTabSheet;
    LegendWrapColGroupBox: TGroupBox;
    LegendWrapColAutoCountGroupBox: TGroupBox;
    LegendWrapColAutoCountEnabledCheckBox: TiComponentEditorCheckBox;
    Label181: TLabel;
    LegendWrapDesiredColCountUpDown: TiUpDown;
    LegendWrapColDesiredCountEdit: TiComponentEditorEdit;
    Label184: TLabel;
    LegendWrapAutoMaxColCountUpDown: TiUpDown;
    LegendWrapColAutoCountMaxEdit: TiComponentEditorEdit;
    LegendWrapRowGroupBox: TGroupBox;
    Label183: TLabel;
    LegendWrapDesiredRowCountUpDown: TiUpDown;
    LegendWrapRowAutoCountGroupBox: TGroupBox;
    Label185: TLabel;
    LegendWrapAutoMaxRowCountUpDown: TiUpDown;
    LegendWrapRowAutoCountEnabledCheckBox: TiComponentEditorCheckBox;
    LegendWrapRowAutoCountMaxEdit: TiComponentEditorEdit;
    LegendWrapRowDesiredCountEdit: TiComponentEditorEdit;
    LegendWrapColSpacingCountGroupBox: TGroupBox;
    Label186: TLabel;
    LegendWrapColSpacingAutoCheckBox: TiComponentEditorCheckBox;
    LegendWrapColSpacingMinEdit: TiComponentEditorEdit;
    LegendWrapRowSpacingCountGroupBox: TGroupBox;
    Label182: TLabel;
    LegendWrapRowSpacingAutoCheckBox: TiComponentEditorCheckBox;
    LegendWrapRowSpacingMinEdit: TiComponentEditorEdit;
    TabSheet10: TTabSheet;
    XAxisLabelsPageControl: TiComponentEditorPageControl;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    XAxisLabelPrecisionUpDown: TiUpDown;
    Label15: TLabel;
    XAxisLabelPrecisionEdit: TiComponentEditorEdit;
    XAxisDateTimeFormatComboBox: TiComponentEditorComboBox;
    XAxisLabelFormatStyleComboBox: TiComponentEditorComboBox;
    XAxisLabelPrecisionStyleComboBox: TiComponentEditorComboBox;
    XAxisLabelFontPicker: TiComponentEditorFontPicker;
    XAxisLabelVisibleCheckBox: TiComponentEditorCheckBox;
    Label52: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    XAxisLabelMarginEdit: TiComponentEditorEdit;
    XAxisLabelMinLengthEdit: TiComponentEditorEdit;
    XAxisLabelSeparationEdit: TiComponentEditorEdit;
    XAxisLabelMinLengthAutoAdjustCheckBox: TiComponentEditorCheckBox;
    Label33: TLabel;
    Label187: TLabel;
    Label188: TLabel;
    XAxisCursorPrecisionUpDown: TiUpDown;
    Label189: TLabel;
    XAxisCursorPrecisionEdit: TiComponentEditorEdit;
    XAxisCursorDateTimeFormatComboBox: TiComponentEditorComboBox;
    XAxisCursorFormatStyleComboBox: TiComponentEditorComboBox;
    XAxisCursorPrecisionStyleComboBox: TiComponentEditorComboBox;
    Label190: TLabel;
    XAxisCursorMinLengthEdit: TiComponentEditorEdit;
    XAxisCursorMinLengthAutoAdjustCheckBox: TiComponentEditorCheckBox;
    XAxisCursorUseDefaultFormatCheckBox: TiComponentEditorCheckBox;
    Label191: TLabel;
    Label192: TLabel;
    Label193: TLabel;
    XAxisLegendPrecisionUpDown: TiUpDown;
    Label194: TLabel;
    XAxisLegendPrecisionEdit: TiComponentEditorEdit;
    XAxisLegendDateTimeFormatComboBox: TiComponentEditorComboBox;
    XAxisLegendFormatStyleComboBox: TiComponentEditorComboBox;
    XAxisLegendPrecisionStyleComboBox: TiComponentEditorComboBox;
    Label195: TLabel;
    XAxisLegendMinLengthEdit: TiComponentEditorEdit;
    XAxisLegendMinLengthAutoAdjustCheckBox: TiComponentEditorCheckBox;
    XAxisLegendUseDefaultFormatCheckBox: TiComponentEditorCheckBox;
    ToolBarFlatBorderCheckBox: TiComponentEditorCheckBox;
    XAxisCursorCopyDefaultButton: TiComponentEditorButton;
    XAxisLegendCopyDefaultButton: TiComponentEditorButton;
    Label103: TLabel;
    YAxisLabelsPageControl: TiComponentEditorPageControl;
    TabSheet14: TTabSheet;
    Label14: TLabel;
    Label24: TLabel;
    Label34: TLabel;
    YAxisLabelPrecisionUpDown: TiUpDown;
    Label35: TLabel;
    Label53: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    YAxisLabelPrecisionEdit: TiComponentEditorEdit;
    YAxisDateTimeFormatComboBox: TiComponentEditorComboBox;
    YAxisLabelFormatStyleComboBox: TiComponentEditorComboBox;
    YAxisLabelPrecisionStyleComboBox: TiComponentEditorComboBox;
    YAxisLabelFontPicker: TiComponentEditorFontPicker;
    YAxisLabelVisibleCheckBox: TiComponentEditorCheckBox;
    YAxisLabelMarginEdit: TiComponentEditorEdit;
    YAxisLabelMinLengthEdit: TiComponentEditorEdit;
    YAxisLabelSeparationEdit: TiComponentEditorEdit;
    YAxisLabelMinLengthAutoAdjustCheckBox: TiComponentEditorCheckBox;
    TabSheet15: TTabSheet;
    Label196: TLabel;
    Label197: TLabel;
    Label198: TLabel;
    YAxisCursorPrecisionUpDown: TiUpDown;
    Label199: TLabel;
    Label200: TLabel;
    YAxisCursorPrecisionEdit: TiComponentEditorEdit;
    YAxisCursorDateTimeFormatComboBox: TiComponentEditorComboBox;
    YAxisCursorFormatStyleComboBox: TiComponentEditorComboBox;
    YAxisCursorPrecisionStyleComboBox: TiComponentEditorComboBox;
    YAxisCursorMinLengthEdit: TiComponentEditorEdit;
    YAxisCursorMinLengthAutoAdjustCheckBox: TiComponentEditorCheckBox;
    YAxisCursorUseDefaultFormatCheckBox: TiComponentEditorCheckBox;
    YAxisCursorCopyDefaultButton: TiComponentEditorButton;
    TabSheet16: TTabSheet;
    Label201: TLabel;
    Label202: TLabel;
    Label203: TLabel;
    YAxisLegendPrecisionUpDown: TiUpDown;
    Label204: TLabel;
    Label205: TLabel;
    YAxisLegendPrecisionEdit: TiComponentEditorEdit;
    YAxisLegendDateTimeFormatComboBox: TiComponentEditorComboBox;
    YAxisLegendFormatStyleComboBox: TiComponentEditorComboBox;
    YAxisLegendPrecisionStyleComboBox: TiComponentEditorComboBox;
    YAxisLegendMinLengthEdit: TiComponentEditorEdit;
    YAxisLegendMinLengthAutoAdjustCheckBox: TiComponentEditorCheckBox;
    YAxisLegendUseDefaultFormatCheckBox: TiComponentEditorCheckBox;
    YAxisLegendCopyDefaultButton: TiComponentEditorButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label105: TLabel;
    EditMenuItem: TMenuItem;
    BackGroundTabSheet: TTabSheet;
    Label75: TLabel;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    BackGroundGradientGroupBox: TGroupBox;
    BackGroundGradientEnabledCheckBox: TiComponentEditorCheckBox;
    Label206: TLabel;
    BackGroundGradientStartColorPicker: TiComponentEditorColorPicker;
    Label207: TLabel;
    BackGroundGradientStopColorPicker: TiComponentEditorColorPicker;
    Label208: TLabel;
    BackGroundGradientDirectionComboBox: TiComponentEditorComboBox;
    Label209: TLabel;
    DataCursorPointerPenWidthUpDown: TiUpDown;
    DataCursorPointerPenWidthEdit: TiComponentEditorEdit;
    TablesTabSheet: TTabSheet;
    TablePageControl: TiComponentEditorPageControl;
    TablesGeneralTabSheet: TTabSheet;
    TableListBox: TiComponentEditorListBox;
    iTableAddButton: TButton;
    TableRemoveButton: TButton;
    TableMarginGroupBox: TGroupBox;
    TableLeftMarginEdit: TiComponentEditorEdit;
    TableTopMarginEdit: TiComponentEditorEdit;
    TableBottomMarginEdit: TiComponentEditorEdit;
    TableRightMarginEdit: TiComponentEditorEdit;
    TableVisibleCheckbox: TiComponentEditorCheckBox;
    TableEnabledCheckbox: TiComponentEditorCheckBox;
    TablePopupEnabledCheckbox: TiComponentEditorCheckBox;
    TablesGridTabSheet: TTabSheet;
    TableGridBackgroundGroupBox: TGroupBox;
    Label210: TLabel;
    TableGridBackGroundTransparentCheckBox: TiComponentEditorCheckBox;
    TableGridBackgroundColorPicker: TiComponentEditorColorPicker;
    TableLinesGroupBox: TGroupBox;
    Label211: TLabel;
    TableGridLinesShowCheckBox: TiComponentEditorCheckBox;
    TableGridLinesColorPicker: TiComponentEditorColorPicker;
    TableDataGroupBox: TGroupBox;
    TableDataFontPicker: TiComponentEditorFontPicker;
    TableColumnTitlesGroupBox: TGroupBox;
    TableColumnTitlesFontPicker: TiComponentEditorFontPicker;
    TableColumnTitlesVisibleCheckBox: TiComponentEditorCheckBox;
    Label212: TLabel;
    TableColumnSpacingEdit: TiComponentEditorEdit;
    Label213: TLabel;
    TableRowSpacingEdit: TiComponentEditorEdit;
    Label214: TLabel;
    TableNameEdit: TiComponentEditorEdit;
    Label215: TLabel;
    TableRowsMaxEdit: TiComponentEditorEdit;
    ChannelMarkersFontPicker: TiComponentEditorFontPicker;
    Label216: TLabel;
    XAxisAlignRefAxisNameComboBox: TiComponentEditorComboBox;
    Label217: TLabel;
    YAxisAlignRefAxisNameComboBox: TiComponentEditorComboBox;
    ChannelInterpolationStyleLabel: TLabel;
    ChannelInterpolationStyleComboBox: TiComponentEditorComboBox;
    XAxisForceStackingCheckBox: TiComponentEditorCheckBox;
    YAxisForceStackingCheckBox: TiComponentEditorCheckBox;
    DataViewAxesControlGroupBox: TiComponentEditorGroupBox;
    Label237: TLabel;
    Label238: TLabel;
    DataViewAxesControlWheelStyleComboBox: TiComponentEditorComboBox;
    DataViewAxesControlEnabledCheckBox: TiComponentEditorCheckBox;
    DataViewAxesControlMouseStyleComboBox: TiComponentEditorComboBox;
    TablesLayoutTabSheet: TTabSheet;
    Label226: TLabel;
    Label227: TLabel;
    TableStartPercentEdit: TiComponentEditorEdit;
    TableStopPercentEdit: TiComponentEditorEdit;
    Label144: TLabel;
    FileColumnSeparatorComboBox: TiComponentEditorComboBox;
    Label243: TLabel;
    ChannelHighLowEnabledCheckBox: TiComponentEditorCheckBox;
    ChannelHighLowStyleComboBox: TiComponentEditorComboBox;
    iComponentEditorPageControl1: TiComponentEditorPageControl;
    ChannelHighLowOpenCloseTabSheet: TTabSheet;
    TabSheet18: TTabSheet;
    Label242: TLabel;
    ChannelHighLowShadowColorPicker: TiComponentEditorColorPicker;
    ChannelHighLowOpenGroupBox: TGroupBox;
    Label231: TLabel;
    Label232: TLabel;
    Label233: TLabel;
    ChannelHighLowOpenColorPicker: TiComponentEditorColorPicker;
    ChannelHighLowOpenWidthEdit: TiComponentEditorEdit;
    ChannelHighLowOpenShowCheckBox: TiComponentEditorCheckBox;
    ChannelHighLowOpenHeightEdit: TiComponentEditorEdit;
    ChannelHighLowOpenWidthPicker: TiComponentEditorValueConverterPicker;
    ChannelHighLowOpenHeightPicker: TiComponentEditorValueConverterPicker;
    ChannelHighLowCloseGroupBox: TGroupBox;
    Label234: TLabel;
    Label235: TLabel;
    Label236: TLabel;
    ChannelHighLowCloseColorPicker: TiComponentEditorColorPicker;
    ChannelHighLowCloseWidthEdit: TiComponentEditorEdit;
    ChannelHighLowCloseShowCheckBox: TiComponentEditorCheckBox;
    ChannelHighLowCloseHeightEdit: TiComponentEditorEdit;
    ChannelHighLowCloseWidthPicker: TiComponentEditorValueConverterPicker;
    ChannelHighLowCloseHeightPicker: TiComponentEditorValueConverterPicker;
    ChannelHighLowBarGroupBox: TGroupBox;
    Label229: TLabel;
    Label230: TLabel;
    ChannelHighLowBarColorPicker: TiComponentEditorColorPicker;
    ChannelHighLowBarWidthEdit: TiComponentEditorEdit;
    ChannelHighLowBarWidthPicker: TiComponentEditorValueConverterPicker;
    Label218: TLabel;
    ChannelHighLowBullishColorPicker: TiComponentEditorColorPicker;
    Label219: TLabel;
    ChannelHighLowBearishColorPicker: TiComponentEditorColorPicker;
    Label220: TLabel;
    XAxisLabelRotationComboBox: TiComponentEditorComboBox;
    Label221: TLabel;
    YAxisLabelRotationComboBox: TiComponentEditorComboBox;
    ToolBarShowPreviewButtonCheckBox: TiComponentEditorCheckBox;
    XAxisTitleRotatedCheckBox: TiComponentEditorCheckBox;
    YAxisTitleRotatedCheckBox: TiComponentEditorCheckBox;
    Label128: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label248: TLabel;
    AnnotationDefaultFontPicker: TiComponentEditorFontPicker;
    AnnotationDefaultsBrushGroupBox: TGroupBox;
    Label143: TLabel;
    Label222: TLabel;
    AnnotationDefaultBrushColorPicker: TiComponentEditorColorPicker;
    AnnotationDefaultBrushStyleComboBox: TiComponentEditorComboBox;
    AnnotationDefaultsPenGroupBox: TGroupBox;
    Label223: TLabel;
    Label224: TLabel;
    Label225: TLabel;
    iUpDown1: TiUpDown;
    AnnotationDefaultPenColorPicker: TiComponentEditorColorPicker;
    AnnotationDefaultPenStyleComboBox: TiComponentEditorComboBox;
    AnnotationDefaultPenWidthEdit: TiComponentEditorEdit;
    AnnotationDefaultReferenceComboBox: TiComponentEditorComboBox;
    AnnotationDefaultReferencePositionXComboBox: TiComponentEditorComboBox;
    AnnotationDefaultReferencePositionYComboBox: TiComponentEditorComboBox;
    AnnotationDefaultReferenceSizeXComboBox: TiComponentEditorComboBox;
    AnnotationDefaultReferenceSizeYComboBox: TiComponentEditorComboBox;
    ChannelUserCanMoveDataPointsCheckBox: TiComponentEditorCheckBox;
    Label239: TLabel;
    ChannelUserCanMoveDataPointsStyleComboBox: TiComponentEditorComboBox;
    DataCursorSnapToDataPointCheckBox: TiComponentEditorCheckBox;
    LegendMarginGroupBox: TGroupBox;
    LegendLeftMarginEdit: TiComponentEditorEdit;
    LegendTopMarginEdit: TiComponentEditorEdit;
    LegendBottomMarginEdit: TiComponentEditorEdit;
    LegendRightMarginEdit: TiComponentEditorEdit;
    LegendSelectedItemGroupBox: TGroupBox;
    Label37: TLabel;
    LegendSelectedItemFontPicker: TiComponentEditorFontPicker;
    LegendSelectedItemColorPicker: TiComponentEditorColorPicker;
    LegendBackgroundGroupBox: TGroupBox;
    Label36: TLabel;
    LegendBackGroundTransparentCheckBox: TiComponentEditorCheckBox;
    LegendBackgroundColorPicker: TiComponentEditorColorPicker;
    LegendChannelNameGroupBox: TGroupBox;
    Label114: TLabel;
    Label241: TLabel;
    LegendChannelNameMaxWidthEdit: TiComponentEditorEdit;
    LegendChannelNameColorStyleComboBox: TiComponentEditorComboBox;
    LineColumnGroupBox: TGroupBox;
    Label250: TLabel;
    Label251: TLabel;
    LegendLineColumnWidthEdit: TiComponentEditorEdit;
    LegendLineColumnHeightEdit: TiComponentEditorEdit;
    ChannelClipToAxesCheckBox: TiComponentEditorCheckBox;
    LimitClipToAxesCheckBox: TiComponentEditorCheckBox;
    Label252: TLabel;
    XAxisTrackingIncrementStyleComboBox: TiComponentEditorComboBox;
    Label253: TLabel;
    YAxisTrackingIncrementStyleComboBox: TiComponentEditorComboBox;
    Label254: TLabel;
    Label255: TLabel;
    Label256: TLabel;
    XAxisTrackingSpanMinimumEdit: TiComponentEditorEdit;
    XAxisTrackingMaxMarginEdit: TiComponentEditorEdit;
    XAxisTrackingMinMarginEdit: TiComponentEditorEdit;
    Label257: TLabel;
    Label258: TLabel;
    Label259: TLabel;
    YAxisTrackingSpanMinimumEdit: TiComponentEditorEdit;
    YAxisTrackingMaxMarginEdit: TiComponentEditorEdit;
    YAxisTrackingMinMarginEdit: TiComponentEditorEdit;
    DataViewAxesControlAllowInSelectModeCheckBox: TiComponentEditorCheckBox;
    Label260: TLabel;
    iUpDown5: TiUpDown;
    Label261: TLabel;
    iUpDown6: TiUpDown;
    LabelImageListIndexEdit: TiComponentEditorEdit;
    LabelImageIndexEdit: TiComponentEditorEdit;
    procedure ChannelListBoxClick(Sender: TObject);
    procedure ChannelChange(Sender: TObject);
    procedure iChannelAddButtonClick(Sender: TObject);
    procedure ChannelRemoveButtonClick(Sender: TObject);
    procedure XAxesAddButtonClick(Sender: TObject);
    procedure XAxisRemoveButtonClick(Sender: TObject);
    procedure XAxisListBoxClick(Sender: TObject);
    procedure ChannelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure XAxisListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure YAxesAddButtonClick(Sender: TObject);
    procedure YAxisRemoveButtonClick(Sender: TObject);
    procedure YAxisListBoxClick(Sender: TObject);
    procedure YAxisListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure XAxisChange(Sender: TObject);
    procedure YAxisChange(Sender: TObject);
    procedure XAxisNameComboBoxDropDown(Sender: TObject);
    procedure YAxisNameComboBoxDropDown(Sender: TObject);
    procedure LegendListBoxClick(Sender: TObject);
    procedure LegendListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure LegendChange(Sender: TObject);
    procedure ToolBarListBoxClick(Sender: TObject);
    procedure ToolBarListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure ToolBarChange(Sender: TObject);
    procedure DataViewListBoxClick(Sender: TObject);
    procedure DataViewListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure DataViewChange(Sender: TObject);
    procedure GeneralChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChannelLogActivateButtonClick(Sender: TObject);
    procedure ChannelLogDeactivateButtonClick(Sender: TObject);
    procedure ControlPropertiesOpenPickerChange(Sender: TObject);
    procedure ControlPropertiesSavePickerChange(Sender: TObject);
    procedure ControlDataSavePickerChange(Sender: TObject);
    procedure ControlDataOpenPickerChange(Sender: TObject);
    procedure ChannelPropertiesSavePickerChange(Sender: TObject);
    procedure ChannelPropertiesOpenPickerChange(Sender: TObject);
    procedure ChannelDataSavePickerChange(Sender: TObject);
    procedure ChannelDataOpenPickerChange(Sender: TObject);
    procedure ChannelLogFileNamePickerChange(Sender: TObject);
    procedure ControlLogFileNamePickerChange(Sender: TObject);
    procedure ControlLogActivateButtonClick(Sender: TObject);
    procedure ControlLogDeactivateButtonClick(Sender: TObject);
    procedure ChannelStatsRefreshButtonClick(Sender: TObject);
    procedure ChannelNameComboBoxDropDown(Sender: TObject);
    procedure DataCursorChange(Sender: TObject);
    procedure DataCursorListBoxClick(Sender: TObject);
    procedure DataCursorListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure iDataCursorAddButtonClick(Sender: TObject);
    procedure DataCursorRemoveButtonClick(Sender: TObject);
    procedure LimitChange(Sender: TObject);
    procedure LimitListBoxClick(Sender: TObject);
    procedure LimitListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure iLimitAddButtonClick(Sender: TObject);
    procedure LimitRemoveButtonClick(Sender: TObject);
    procedure LabelChange(Sender: TObject);
    procedure LabelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure LabelListBoxClick(Sender: TObject);
    procedure iLabelAddButtonClick(Sender: TObject);
    procedure LabelRemoveButtonClick(Sender: TObject);
    procedure TitleChange(Sender: TObject);
    procedure DataViewGridXAxisNameComboBoxDropDown(Sender: TObject);
    procedure DataViewGridYAxisNameComboBoxDropDown(Sender: TObject);
    procedure iPlotLayoutViewerChange(Sender: TObject);
    procedure ControlAnnotationSavePickerChange(Sender: TObject);
    procedure ControlAnnotationOpenPickerChange(Sender: TObject);
    procedure iCustomEditorFormClose(Sender: TObject; var Action: TCloseAction);
    procedure LayoutPopupMenuPopup(Sender: TObject);
    procedure AddXAxisMenuItemClick(Sender: TObject);
    procedure AddYAxisMenuItemClick(Sender: TObject);
    procedure AddLabelMenuItemClick(Sender: TObject);
    procedure DeleteMenuItemClick(Sender: TObject);
    procedure XYAxesReverseMenuItemClick(Sender: TObject);
    procedure VisibleMenuItemClick(Sender: TObject);
    procedure DataCursorChannelNameComboBoxDropDown(Sender: TObject);
    procedure iPlotLayoutViewerMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure XAxisCursorCopyDefaultButtonClick(Sender: TObject);
    procedure XAxisLegendCopyDefaultButtonClick(Sender: TObject);
    procedure YAxisCursorCopyDefaultButtonClick(Sender: TObject);
    procedure YAxisLegendCopyDefaultButtonClick(Sender: TObject);
    procedure EditMenuItemClick(Sender: TObject);
    procedure TableListBoxClick(Sender: TObject);
    procedure TableListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure iTableAddButtonClick(Sender: TObject);
    procedure TableRemoveButtonClick(Sender: TObject);
    procedure TableChange(Sender: TObject);
  private
    FOnGeneralChange       : TNotifyEvent;
    FIsClosing             : Boolean;
    FRightClickObject      : TiPlotLayoutObject;

    procedure DisableAllEditControlsStartingWith(Value: String);
    procedure EnableAllEditControlsStartingWith(Value: String);

    procedure ChannelStatsClear;
    procedure RefreshChannelStats;
  protected
    {$IFDEF iVCL}procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;{$endif}
  public
    Master        : TiPlotMasterManager;
    PlotComponent : TWinControl;

    destructor Destroy; override;

    property  OnGeneralChange : TNotifyEvent read FOnGeneralChange write FOnGeneralChange;
    procedure UpdateToolBarEdit;
    procedure UpdateLegendEdit;
    procedure UpdateTableEdit;
    procedure UpdateXAxesEdit;
    procedure UpdateYAxesEdit;
    procedure UpdateChannelEdit;
    procedure UpdateDataViewEdit;
    procedure UpdateDataCursorEdit;
    procedure UpdateLimitEdit;
    procedure UpdateLabelEdit;

    procedure UpdateAll;

    property  IsClosing : Boolean read FIsClosing;

    procedure SetFormTranslationMethod(Value: TFormTranslationMethod);
  end;

implementation

uses
  {$IFDEF iVCL}  iPlotAxis,  iPlotLegend,  iPlotTable,  iPlotToolBar,  iPlotChannelCustom,  iPlotChannel,  iPlotLimit,  iXYPlotChannel,  iPlotDataView,  iPlotLabel,  iPlotDataCursor,  iPlotComponent,  iPlotDataNullList;{$endif}
  {$ifdef iCLX} QiPlotAxis, QiPlotLegend, QiPlotTable, QiPlotToolBar, QiPlotChannelCustom, QiPlotChannel, QiPlotLimit, QiXYPlotChannel, QiPlotDataView, QiPlotLabel, QiPlotDataCursor, QiPlotComponent, QiPlotDataNullList;{$endif}

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.FormCreate(Sender: TObject);
begin
  {$IFDEF iVCL}BorderStyle := bsDialog;   {$endif}
  {$IFDEF iCLX}BorderStyle := fbsDialog;  {$endif}
end;
//****************************************************************************************************************************************************
destructor TiPlotEditorForm.Destroy;
begin
  if Assigned((PlotComponent as TiPlotComponent).OnAfterCloseEditor) then (PlotComponent as TiPlotComponent).OnAfterCloseEditor(Self);
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.iCustomEditorFormClose(Sender: TObject; var Action: TCloseAction);
begin
  FIsClosing := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.UpdateAll;
begin
  UpdateToolBarEdit;
  UpdateLegendEdit;
  UpdateXAxesEdit;
  UpdateYAxesEdit;
  UpdateChannelEdit;
  UpdateDataViewEdit;
  UpdateDataCursorEdit;
  UpdateLimitEdit;
  UpdateLabelEdit;
  UpdateTableEdit;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.XAxisNameComboBoxDropDown(Sender: TObject);
var
  x : Integer;
  OldText : String;
begin
  if not Assigned(Master.XAxisManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add(Master.TranslationManager.FindReplacement('<None>'));
      for x := 0 to Master.XAxisManager.Count-1 do
        Items.Add(Master.XAxisManager.Items[x].Name);
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.DataViewGridXAxisNameComboBoxDropDown(Sender: TObject);
var
  x : Integer;
  OldText : String;
begin
  if not Assigned(Master.XAxisManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add(Master.TranslationManager.FindReplacement('<None>'));
      for x := 0 to Master.XAxisManager.Count-1 do
        Items.Add(Master.XAxisManager.Items[x].Name);
      Items.Add(Master.TranslationManager.FindReplacement('<All>'));
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.YAxisNameComboBoxDropDown(Sender: TObject);
var
  x       : Integer;
  OldText : String;
begin
  if not Assigned(Master.YAxisManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add(Master.TranslationManager.FindReplacement('<None>'));
      for x := 0 to Master.YAxisManager.Count-1 do
        Items.Add(Master.YAxisManager.Items[x].Name);
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.DataViewGridYAxisNameComboBoxDropDown(Sender: TObject);
var
  x       : Integer;
  OldText : String;
begin
  if not Assigned(Master.YAxisManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add(Master.TranslationManager.FindReplacement('<None>'));
      for x := 0 to Master.YAxisManager.Count-1 do
        Items.Add(Master.YAxisManager.Items[x].Name);
      Items.Add(Master.TranslationManager.FindReplacement('<All>'));
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelNameComboBoxDropDown(Sender: TObject);
var
  x       : Integer;
  OldText : String;
begin
  if not Assigned(Master.ChannelManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add(Master.TranslationManager.FindReplacement('<None>'));
      for x := 0 to Master.ChannelManager.Count-1 do
        Items.Add(Master.ChannelManager.Items[x].Name);
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.DataCursorChannelNameComboBoxDropDown(Sender: TObject);
var
  x       : Integer;
  OldText : String;
begin
  if not Assigned(Master.ChannelManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add(Master.TranslationManager.FindReplacement('<All>'));
      for x := 0 to Master.ChannelManager.Count-1 do
        Items.Add(Master.ChannelManager.Items[x].Name);
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ToolBarListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  AText  := (ToolBarListBox.Items.Objects[Index] as TiPlotToolBar).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.LegendListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  AText  := (LegendListBox.Items.Objects[Index] as TiPlotLegend).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.XAxisListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (XAxisListBox.Items.Objects[Index] as TiPlotXAxis).LabelsFont.Color;
  AText  := (XAxisListBox.Items.Objects[Index] as TiPlotXAxis).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.YAxisListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (YAxisListBox.Items.Objects[Index] as TiPlotYAxis).LabelsFont.Color;
  AText  := (YAxisListBox.Items.Objects[Index] as TiPlotYAxis).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.DataViewListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  AText  := (DataViewListBox.Items.Objects[Index] as TiPlotDataView).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (ChannelListBox.Items.Objects[Index] as TiPlotChannelCustom).Color;
  AText  := (ChannelListBox.Items.Objects[Index] as TiPlotChannelCustom).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.DataCursorListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (DataCursorListBox.Items.Objects[Index] as TiPlotDataCursor).Color;
  AText  := (DataCursorListBox.Items.Objects[Index] as TiPlotDataCursor).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.LimitListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (LimitListBox.Items.Objects[Index] as TiPlotLimit).Color;
  AText  := (LimitListBox.Items.Objects[Index] as TiPlotLimit).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.TableListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  AText  := (TableListBox.Items.Objects[Index] as TiPlotTable).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.LabelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  AText  := (LabelListBox.Items.Objects[Index] as TiPlotLabel).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.LegendListBoxClick    (Sender: TObject);begin UpdateLegendEdit;                       end;
procedure TiPlotEditorForm.YAxisListBoxClick     (Sender: TObject);begin UpdateYAxesEdit;                        end;
procedure TiPlotEditorForm.XAxisListBoxClick     (Sender: TObject);begin UpdateXAxesEdit;                        end;
procedure TiPlotEditorForm.ChannelListBoxClick   (Sender: TObject);begin UpdateChannelEdit;   ChannelStatsClear; end;
procedure TiPlotEditorForm.DataViewListBoxClick  (Sender: TObject);begin UpdateDataViewEdit;                     end;
procedure TiPlotEditorForm.ToolBarListBoxClick   (Sender: TObject);begin UpdateToolBarEdit;                      end;
procedure TiPlotEditorForm.DataCursorListBoxClick(Sender: TObject);begin UpdateDataCursorEdit;                   end;
procedure TiPlotEditorForm.LimitListBoxClick     (Sender: TObject);begin UpdateLimitEdit;                        end;
procedure TiPlotEditorForm.LabelListBoxClick     (Sender: TObject);begin UpdateLabelEdit;                        end;
procedure TiPlotEditorForm.TableListBoxClick     (Sender: TObject);begin UpdateTableEdit;                        end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.XAxesAddButtonClick      (Sender:TObject);begin Master.AddXAxis;     XAxisListBox.SelectLast;     UpdateXAxesEdit;                       end;
procedure TiPlotEditorForm.YAxesAddButtonClick      (Sender:TObject);begin Master.AddYAxis;     YAxisListBox.SelectLast;     UpdateYAxesEdit;                       end;
procedure TiPlotEditorForm.iChannelAddButtonClick   (Sender:TObject);begin Master.AddChannel;   ChannelListBox.SelectLast;   UpdateChannelEdit;   ChannelStatsClear;end;
procedure TiPlotEditorForm.iDataCursorAddButtonClick(Sender:TObject);begin Master.AddDataCursor;DataCursorListBox.SelectLast;UpdateDataCursorEdit;                  end;
procedure TiPlotEditorForm.iLimitAddButtonClick     (Sender:TObject);begin Master.AddLimit;     LimitListBox.SelectLast;     UpdateLimitEdit;                       end;
procedure TiPlotEditorForm.iLabelAddButtonClick     (Sender:TObject);begin Master.AddLabel;     LabelListBox.SelectLast;     UpdateLabelEdit;                       end;
procedure TiPlotEditorForm.iTableAddButtonClick     (Sender:TObject);begin Master.AddTable;     TableListBox.SelectLast;     UpdateTableEdit;                       end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.XAxisRemoveButtonClick     (Sender:TObject);begin XAxisListBox.DeleteSelectedObject;     UpdateChannelEdit;UpdateXAxesEdit;  end;
procedure TiPlotEditorForm.YAxisRemoveButtonClick     (Sender:TObject);begin YAxisListBox.DeleteSelectedObject;     UpdateChannelEdit;UpdateYAxesEdit;  end;
procedure TiPlotEditorForm.ChannelRemoveButtonClick   (Sender:TObject);begin ChannelListBox.DeleteSelectedObject;   UpdateChannelEdit;ChannelStatsClear;end;
procedure TiPlotEditorForm.DataCursorRemoveButtonClick(Sender:TObject);begin DataCursorListBox.DeleteSelectedObject;UpdateDataCursorEdit;               end;
procedure TiPlotEditorForm.LimitRemoveButtonClick     (Sender:TObject);begin LimitListBox.DeleteSelectedObject;     UpdateLimitEdit;                    end;
procedure TiPlotEditorForm.LabelRemoveButtonClick     (Sender:TObject);begin LabelListBox.DeleteSelectedObject;     UpdateLabelEdit;                    end;
procedure TiPlotEditorForm.TableRemoveButtonClick     (Sender:TObject);begin TableListBox.DeleteSelectedObject;     UpdateTableEdit;                    end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.UpdateToolBarEdit;
var
  iToolBar : TiPlotToolBar;
begin
  if ToolBarListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('ToolBar')
    else
      begin
        EnableAllEditControlsStartingWith('ToolBar');

        iToolBar := ToolBarListBox.Items.Objects[ToolBarListBox.ItemIndex] as TiPlotToolBar;

        ToolBarNameEdit.AsString                      := iToolBar.Name;
        ToolBarVisibleCheckbox.AsBoolean              := iToolBar.Visible;
        ToolBarEnabledCheckBox.AsBoolean              := iToolBar.Enabled;
        ToolBarPopupEnabledCheckBox.AsBoolean         := iToolBar.PopupEnabled;
        ToolBarFlatBorderCheckBox.AsBoolean           := iToolBar.FlatBorder;
        ToolBarFlatButtonsCheckBox.AsBoolean          := iToolBar.FlatButtons;
        ToolBarSmallButtonsCheckBox.AsBoolean         := iToolBar.SmallButtons;

        ToolBarShowResumeButtonCheckBox.AsBoolean     := iToolBar.ShowResumeButton;
        ToolBarShowPauseButtonCheckBox.AsBoolean      := iToolBar.ShowPauseButton;
        ToolBarShowAxesModeButtonsCheckBox.AsBoolean  := iToolBar.ShowAxesModeButtons;
        ToolBarShowZoomInOutButtonsCheckBox.AsBoolean := iToolBar.ShowZoomInOutButtons;
        ToolBarShowSelectButtonCheckBox.AsBoolean     := iToolBar.ShowSelectButton;
        ToolBarShowZoomBoxButtonCheckBox.AsBoolean    := iToolBar.ShowZoomBoxButton;
        ToolBarShowCursorButtonCheckBox.AsBoolean     := iToolBar.ShowCursorButton;

        ToolBarShowEditButtonCheckBox.AsBoolean       := iToolBar.ShowEditButton;
        ToolBarShowCopyButtonCheckBox.AsBoolean       := iToolBar.ShowCopyButton;
        ToolBarShowSaveButtonCheckBox.AsBoolean       := iToolBar.ShowSaveButton;
        ToolBarShowPrintButtonCheckBox.AsBoolean      := iToolBar.ShowPrintButton;
        ToolBarShowPreviewButtonCheckBox.AsBoolean    := iToolBar.ShowPreviewButton;

        ToolBarZoomInOutFactorEdit.AsFloat            := iToolBar.ZoomInOutFactor;

        ToolBarListBox.Invalidate;
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.UpdateLegendEdit;
var
  iLegend : TiPlotLegend;
begin
  if LegendListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Legend')
    else
      begin
        EnableAllEditControlsStartingWith('Legend');

        iLegend := LegendListBox.Items.Objects[LegendListBox.ItemIndex] as TiPlotLegend;

        LegendNameEdit.AsString                         := iLegend.Name;
        LegendVisibleCheckbox.AsBoolean                 := iLegend.Visible;
        LegendEnabledCheckbox.AsBoolean                 := iLegend.Enabled;
        LegendPopupEnabledCheckbox.AsBoolean            := iLegend.PopupEnabled;

        LegendTopMarginEdit.AsFloat                     := iLegend.MarginTop;
        LegendBottomMarginEdit.AsFloat                  := iLegend.MarginBottom;
        LegendLeftMarginEdit.AsFloat                    := iLegend.MarginLeft;
        LegendRightMarginEdit.AsFloat                   := iLegend.MarginRight;

        LegendChannelNameMaxWidthEdit.AsFloat           := iLegend.ChannelNameMaxWidth;
        LegendChannelNameColorStyleComboBox.AsInteger   := ord(iLegend.ChannelNameColorStyle);
        LegendLineColumnWidthEdit.AsInteger             := iLegend.LineColumnWidth;
        LegendLineColumnHeightEdit.AsInteger            := iLegend.LineColumnHeight;
        LegendColumnSpacingEdit.AsFloat                 := iLegend.ColumnSpacing;
        LegendBackGroundTransparentCheckBox.AsBoolean   := iLegend.BackGroundTransparent;
        LegendBackgroundColorPicker.Color               := iLegend.BackGroundColor;
        LegendSelectedItemColorPicker.Color             := iLegend.SelectedItemBackGroundColor;

        LegendShowLineCheckbox.AsBoolean                := iLegend.ShowColumnLine;
        LegendShowMarkerCheckbox.AsBoolean              := iLegend.ShowColumnMarker;
        LegendShowXAxisTitleCheckbox.AsBoolean          := iLegend.ShowColumnXAxisTitle;
        LegendShowYAxisTitleCheckbox.AsBoolean          := iLegend.ShowColumnYAxisTitle;
        LegendShowXValueCheckbox.AsBoolean              := iLegend.ShowColumnXValue;
        LegendShowYValueCheckbox.AsBoolean              := iLegend.ShowColumnYValue;
        LegendShowYMaxCheckbox.AsBoolean                := iLegend.ShowColumnYMax;
        LegendShowYMinCheckbox.AsBoolean                := iLegend.ShowColumnYMin;
        LegendShowYMeanCheckbox.AsBoolean               := iLegend.ShowColumnYMean;

        LegendWrapColDesiredCountEdit.AsInteger         := iLegend.WrapColDesiredCount;
        LegendWrapColAutoCountEnabledCheckBox.AsBoolean := iLegend.WrapColAutoCountEnabled;
        LegendWrapColAutoCountMaxEdit.AsInteger         := iLegend.WrapColAutoCountMax;
        LegendWrapColSpacingMinEdit.AsFloat             := iLegend.WrapColSpacingMin;
        LegendWrapColSpacingAutoCheckBox.AsBoolean      := iLegend.WrapColSpacingAuto;

        LegendWrapRowDesiredCountEdit.AsInteger         := iLegend.WrapRowDesiredCount;
        LegendWrapRowAutoCountEnabledCheckBox.AsBoolean := iLegend.WrapRowAutoCountEnabled;
        LegendWrapRowAutoCountMaxEdit.AsInteger         := iLegend.WrapRowAutoCountMax;
        LegendWrapRowSpacingMinEdit.AsFloat             := iLegend.WrapRowSpacingMin;
        LegendWrapRowSpacingAutoCheckBox.AsBoolean      := iLegend.WrapRowSpacingAuto;

        LegendColumnTitlesVisibleCheckbox.AsBoolean     := iLegend.ColumnTitlesVisible;

        LegendFontPicker.Font.Assign            (iLegend.Font);
        LegendSelectedItemFontPicker.Font.Assign(iLegend.SelectedItemFont);
        LegendColumnTitlesFontPicker.Font.Assign(iLegend.ColumnTitlesFont);

        LegendListBox.Invalidate;
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.UpdateTableEdit;
var
  iTable : TiPlotTable;
begin
  if TableListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Table')
    else
      begin
        EnableAllEditControlsStartingWith('Table');

        iTable := TableListBox.Items.Objects[TableListBox.ItemIndex] as TiPlotTable;

        TableNameEdit.AsString                           := iTable.Name;
        TableVisibleCheckbox.AsBoolean                   := iTable.Visible;
        TableEnabledCheckbox.AsBoolean                   := iTable.Enabled;
        TablePopupEnabledCheckbox.AsBoolean              := iTable.PopupEnabled;

        TableTopMarginEdit.AsFloat                       := iTable.MarginTop;
        TableLeftMarginEdit.AsFloat                      := iTable.MarginLeft;
        TableRightMarginEdit.AsFloat                     := iTable.MarginRight;
        TableBottomMarginEdit.AsFloat                    := iTable.MarginBottom;

        TableColumnSpacingEdit.AsFloat                   := iTable.ColumnSpacing;
        TableRowSpacingEdit.AsFloat                      := iTable.RowSpacing;
        TableRowsMaxEdit.AsInteger                       := iTable.RowsMax;

        TableColumnTitlesVisibleCheckBox.AsBoolean       := iTable.ColumnTitlesVisible;

        TableGridLinesShowCheckBox.AsBoolean             := iTable.GridLinesShow;
        TableGridLinesColorPicker.Color                  := iTable.GridLinesColor;

        TableStartPercentEdit.AsFloat                    := iTable.StartPercent;
        TableStopPercentEdit.AsFloat                     := iTable.StopPercent;

        TableGridBackGroundTransparentCheckBox.AsBoolean := iTable.GridBackGroundTransparent;
        TableGridBackgroundColorPicker.Color             := iTable.GridBackGroundColor;

        TableDataFontPicker.Font.Assign(iTable.DataFont);
        TableColumnTitlesFontPicker.Font.Assign(iTable.ColumnTitlesFont);
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.UpdateXAxesEdit;
var
  iAxis : TiPlotXAxis;
begin
  if XAxisListBox.ItemIndex = - 1 then  DisableAllEditControlsStartingWith('XAxis')
    else
      begin
        EnableAllEditControlsStartingWith('XAxis');

        iAxis := XAxisListBox.Items.Objects[XAxisListBox.ItemIndex] as TiPlotXAxis;

        YAxisNameComboBoxDropDown(XAxisCartesianChildRefAxisNameComboBox);
        XAxisNameComboBoxDropDown(XAxisAlignRefAxisNameComboBox);

        XAxisNameEdit.AsString                            := iAxis.Name;
        XAxisVisibleCheckBox.AsBoolean                    := iAxis.Visible;
        XAxisGridLinesVisibleCheckBox.AsBoolean           := iAxis.GridLinesVisible;
        XAxisEnabledCheckBox.AsBoolean                    := iAxis.Enabled;
        XAxisPopupEnabledCheckBox.AsBoolean               := iAxis.PopupEnabled;
        XAxisLayerEdit.AsInteger                          := iAxis.Layer;

        XAxisStartPercentEdit.AsFloat                     := iAxis.StartPercent;
        XAxisStopPercentEdit.AsFloat                      := iAxis.StopPercent;

        XAxisMinEdit.AsFloat                              := iAxis.Min;
        XAxisSpanEdit.AsFloat                             := iAxis.Span;
        XAxisDesiredStartEdit.AsFloat                     := iAxis.DesiredStart;
        XAxisDesiredIncrementEdit.AsFloat                 := iAxis.DesiredIncrement;
        XAxisReverseScaleCheckBox.AsBoolean               := iAxis.ReverseScale;
        XAxisRestoreValuesOnResumeCheckBox.AsBoolean      := iAxis.RestoreValuesOnResume;
        XAxisMasterUIInputCheckBox.AsBoolean              := iAxis.MasterUIInput;
        XAxisInnerMarginEdit.AsInteger                    := iAxis.InnerMargin;
        XAxisOuterMarginEdit.AsInteger                    := iAxis.OuterMargin;

        XAxisTitleTextEdit.AsString                       := iAxis.Title;
        XAxisTitleMarginEdit.AsFloat                      := iAxis.TitleMargin;
        XAxisTitleShowCheckBox.AsBoolean                  := iAxis.TitleShow;
        XAxisTitleRotatedCheckBox.AsBoolean               := iAxis.TitleRotated;

        XAxisScaleLinesShowCheckBox.AsBoolean             := iAxis.ScaleLinesShow;
        XAxisScaleLinesColorPicker.Color                  := iAxis.ScaleLinesColor;
        XAxisMajorLengthEdit.AsInteger                    := iAxis.MajorLength;
        XAxisMinorLengthEdit.AsInteger                    := iAxis.MinorLength;
        XAxisMinorCountEdit.AsInteger                     := iAxis.MinorCount;

        XAxisLabelVisibleCheckBox.AsBoolean               := iAxis.LabelsVisible;

        XAxisLabelMarginEdit.AsFloat                      := iAxis.LabelsMargin;

        XAxisLabelRotationComboBox.AsInteger              := ord(iAxis.LabelsRotation);
        XAxisLabelFormatStyleComboBox.AsInteger           := ord(iAxis.LabelsFormatStyle);
        XAxisDateTimeFormatComboBox.AsString              := iAxis.DateTimeFormat;
        XAxisLabelPrecisionStyleComboBox.AsInteger        := ord(iAxis.LabelsPrecisionStyle);
        XAxisLabelPrecisionEdit.AsInteger                 := iAxis.LabelsPrecision;
        XAxisLabelMinLengthEdit.AsFloat                   := iAxis.LabelsMinLength;
        XAxisLabelMinLengthAutoAdjustCheckBox.AsBoolean   := iAxis.LabelsMinLengthAutoAdjust;

        XAxisCursorUseDefaultFormatCheckBox.AsBoolean     := iAxis.CursorUseDefaultFormat;
        XAxisCursorFormatStyleComboBox.AsInteger          := ord(iAxis.CursorFormatStyle);
        XAxisCursorDateTimeFormatComboBox.AsString        := iAxis.CursorDateTimeFormat;
        XAxisCursorPrecisionStyleComboBox.AsInteger       := ord(iAxis.CursorPrecisionStyle);
        XAxisCursorPrecisionEdit.AsInteger                := iAxis.CursorPrecision;
        XAxisCursorMinLengthEdit.AsFloat                  := iAxis.CursorMinLength;
        XAxisCursorMinLengthAutoAdjustCheckBox.AsBoolean  := iAxis.CursorMinLengthAutoAdjust;

        XAxisLegendUseDefaultFormatCheckBox.AsBoolean     := iAxis.LegendUseDefaultFormat;
        XAxisLegendFormatStyleComboBox.AsInteger          := ord(iAxis.LegendFormatStyle);
        XAxisLegendDateTimeFormatComboBox.AsString        := iAxis.LegendDateTimeFormat;
        XAxisLegendPrecisionStyleComboBox.AsInteger       := ord(iAxis.LegendPrecisionStyle);
        XAxisLegendPrecisionEdit.AsInteger                := iAxis.LegendPrecision;
        XAxisLegendMinLengthEdit.AsFloat                  := iAxis.LegendMinLength;
        XAxisLegendMinLengthAutoAdjustCheckBox.AsBoolean  := iAxis.LegendMinLengthAutoAdjust;

        XAxisTrackingEnabledCheckBox.AsBoolean            := iAxis.TrackingEnabled;
        XAxisTrackingStyleComboBox.AsInteger              := ord(iAxis.TrackingStyle);
        XAxisTrackingIncrementStyleComboBox.AsInteger     := ord(iAxis.TrackingIncrementStyle);
        XAxisTrackingAlignFirstStyleComboBox.AsInteger    := ord(iAxis.TrackingAlignFirstStyle);
        XAxisTrackingScrollCompressMaxEdit.AsFloat        := iAxis.TrackingScrollCompressMax;
        XAxisTrackingSpanMinimumEdit.AsFloat              := iAxis.TrackingSpanMinimum;
        XAxisTrackingMaxMarginEdit.AsFloat                := iAxis.TrackingMaxMargin;
        XAxisTrackingMinMarginEdit.AsFloat                := iAxis.TrackingMinMargin;

        XAxisStackingEndsMarginEdit.AsFloat               := iAxis.StackingEndsMargin;
        XAxisForceStackingCheckBox.AsBoolean              := iAxis.ForceStacking;

        XAxisLabelSeparationEdit.AsFloat                  := iAxis.LabelSeparation;
        XAxisScaleTypeRadioGroup.AsInteger                := ord(iAxis.ScaleType);

        XAxisCursorScalerEdit.AsFloat                     := iAxis.CursorScaler;

        XAxisScrollMinMaxEnabledCheckBox.AsBoolean        := iAxis.ScrollMinMaxEnabled;
        XAxisScrollMinEdit.AsFloat                        := iAxis.ScrollMin;
        XAxisScrollMaxEdit.AsFloat                        := iAxis.ScrollMax;

        XAxisCartesianStyleComboBox.AsInteger             := ord(iAxis.CartesianStyle);
        XAxisCartesianChildRefAxisNameComboBox.ItemIndex  := XAxisCartesianChildRefAxisNameComboBox.Items.IndexOf(iAxis.CartesianChildRefAxisName);
        XAxisCartesianChildRefValueEdit.AsFloat           := iAxis.CartesianChildRefValue;

        XAxisAlignRefAxisNameComboBox.ItemIndex           := XAxisAlignRefAxisNameComboBox.Items.IndexOf(iAxis.AlignRefAxisName);

        XAxisTitleFontPicker.Font.Assign(iAxis.TitleFont);
        XAxisLabelFontPicker.Font.Assign(iAxis.LabelsFont);

        XAxisListBox.Invalidate;
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.UpdateYAxesEdit;
var
  iAxis : TiPlotYAxis;
begin
  if YAxisListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('YAxis')
    else
      begin
        EnableAllEditControlsStartingWith('YAxis');

        iAxis := YAxisListBox.Items.Objects[YAxisListBox.ItemIndex] as TiPlotYAxis;

        XAxisNameComboBoxDropDown(YAxisCartesianChildRefAxisNameComboBox);
        YAxisNameComboBoxDropDown(YAxisAlignRefAxisNameComboBox);

        YAxisNameEdit.AsString                            := iAxis.Name;
        YAxisVisibleCheckBox.AsBoolean                    := iAxis.Visible;
        YAxisGridLinesVisibleCheckBox.AsBoolean           := iAxis.GridLinesVisible;
        YAxisEnabledCheckBox.AsBoolean                    := iAxis.Enabled;
        YAxisPopupEnabledCheckBox.AsBoolean               := iAxis.PopupEnabled;
        YAxisLayerEdit.AsInteger                          := iAxis.Layer;

        YAxisStartPercentEdit.AsFloat                     := iAxis.StartPercent;
        YAxisStopPercentEdit.AsFloat                      := iAxis.StopPercent;

        YAxisMinEdit.AsFloat                              := iAxis.Min;
        YAxisSpanEdit.AsFloat                             := iAxis.Span;
        YAxisDesiredStartEdit.AsFloat                     := iAxis.DesiredStart;
        YAxisDesiredIncrementEdit.AsFloat                 := iAxis.DesiredIncrement;
        YAxisReverseScaleCheckBox.AsBoolean               := iAxis.ReverseScale;
        YAxisRestoreValuesOnResumeCheckBox.AsBoolean      := iAxis.RestoreValuesOnResume;
        YAxisMasterUIInputCheckBox.AsBoolean              := iAxis.MasterUIInput;
        YAxisInnerMarginEdit.AsInteger                    := iAxis.InnerMargin;
        YAxisOuterMarginEdit.AsInteger                    := iAxis.OuterMargin;

        YAxisTitleTextEdit.AsString                       := iAxis.Title;
        YAxisTitleMarginEdit.AsFloat                      := iAxis.TitleMargin;
        YAxisTitleShowCheckBox.AsBoolean                  := iAxis.TitleShow;
        YAxisTitleRotatedCheckBox.AsBoolean               := iAxis.TitleRotated;

        YAxisScaleLinesShowCheckBox.AsBoolean             := iAxis.ScaleLinesShow;
        YAxisScaleLinesColorPicker.Color                  := iAxis.ScaleLinesColor;
        YAxisMajorLengthEdit.AsInteger                    := iAxis.MajorLength;
        YAxisMinorLengthEdit.AsInteger                    := iAxis.MinorLength;
        YAxisMinorCountEdit.AsInteger                     := iAxis.MinorCount;

        YAxisLabelVisibleCheckBox.AsBoolean               := iAxis.LabelsVisible;
        YAxisLabelMarginEdit.AsFloat                      := iAxis.LabelsMargin;

        YAxisLabelFormatStyleComboBox.AsInteger           := ord(iAxis.LabelsFormatStyle);
        YAxisLabelRotationComboBox.AsInteger              := ord(iAxis.LabelsRotation);
        YAxisDateTimeFormatComboBox.AsString              := iAxis.DateTimeFormat;
        YAxisLabelPrecisionStyleComboBox.AsInteger        := ord(iAxis.LabelsPrecisionStyle);
        YAxisLabelPrecisionEdit.AsInteger                 := iAxis.LabelsPrecision;
        YAxisLabelMinLengthEdit.AsFloat                   := iAxis.LabelsMinLength;
        YAxisLabelMinLengthAutoAdjustCheckBox.AsBoolean   := iAxis.LabelsMinLengthAutoAdjust;

        YAxisCursorUseDefaultFormatCheckBox.AsBoolean     := iAxis.CursorUseDefaultFormat;
        YAxisCursorFormatStyleComboBox.AsInteger          := ord(iAxis.CursorFormatStyle);
        YAxisCursorDateTimeFormatComboBox.AsString        := iAxis.CursorDateTimeFormat;
        YAxisCursorPrecisionStyleComboBox.AsInteger       := ord(iAxis.CursorPrecisionStyle);
        YAxisCursorPrecisionEdit.AsInteger                := iAxis.CursorPrecision;
        YAxisCursorMinLengthEdit.AsFloat                  := iAxis.CursorMinLength;
        YAxisCursorMinLengthAutoAdjustCheckBox.AsBoolean  := iAxis.CursorMinLengthAutoAdjust;

        YAxisLegendUseDefaultFormatCheckBox.AsBoolean     := iAxis.LegendUseDefaultFormat;
        YAxisLegendFormatStyleComboBox.AsInteger          := ord(iAxis.LegendFormatStyle);
        YAxisLegendDateTimeFormatComboBox.AsString        := iAxis.LegendDateTimeFormat;
        YAxisLegendPrecisionStyleComboBox.AsInteger       := ord(iAxis.LegendPrecisionStyle);
        YAxisLegendPrecisionEdit.AsInteger                := iAxis.LegendPrecision;
        YAxisLegendMinLengthEdit.AsFloat                  := iAxis.LegendMinLength;
        YAxisLegendMinLengthAutoAdjustCheckBox.AsBoolean  := iAxis.LegendMinLengthAutoAdjust;

        YAxisTrackingEnabledCheckBox.AsBoolean            := iAxis.TrackingEnabled;
        YAxisTrackingStyleComboBox.AsInteger              := ord(iAxis.TrackingStyle);
        YAxisTrackingIncrementStyleComboBox.AsInteger     := ord(iAxis.TrackingIncrementStyle);
        YAxisTrackingAlignFirstStyleComboBox.AsInteger    := ord(iAxis.TrackingAlignFirstStyle);
        YAxisTrackingScrollCompressMaxEdit.AsFloat        := iAxis.TrackingScrollCompressMax;
        YAxisTrackingSpanMinimumEdit.AsFloat             := iAxis.TrackingSpanMinimum;
        YAxisTrackingMaxMarginEdit.AsFloat               := iAxis.TrackingMaxMargin;
        YAxisTrackingMinMarginEdit.AsFloat               := iAxis.TrackingMinMargin;

        YAxisStackingEndsMarginEdit.AsFloat               := iAxis.StackingEndsMargin;
        YAxisForceStackingCheckBox.AsBoolean              := iAxis.ForceStacking;

        YAxisLabelSeparationEdit.AsFloat                  := iAxis.LabelSeparation;
        YAxisScaleTypeRadioGroup.AsInteger                := ord(iAxis.ScaleType);

        YAxisCursorScalerEdit.AsFloat                     := iAxis.CursorScaler;

        YAxisScrollMinMaxEnabledCheckBox.AsBoolean        := iAxis.ScrollMinMaxEnabled;
        YAxisScrollMinEdit.AsFloat                        := iAxis.ScrollMin;
        YAxisScrollMaxEdit.AsFloat                        := iAxis.ScrollMax;

        YAxisCartesianStyleComboBox.AsInteger             := ord(iAxis.CartesianStyle);
        YAxisCartesianChildRefAxisNameComboBox.ItemIndex  := YAxisCartesianChildRefAxisNameComboBox.Items.IndexOf(iAxis.CartesianChildRefAxisName);
        YAxisCartesianChildRefValueEdit.AsFloat           := iAxis.CartesianChildRefValue;

        YAxisAlignRefAxisNameComboBox.ItemIndex           := YAxisAlignRefAxisNameComboBox.Items.IndexOf(iAxis.AlignRefAxisName);

        YAxisTitleFontPicker.Font.Assign(iAxis.TitleFont);
        YAxisLabelFontPicker.Font.Assign(iAxis.LabelsFont);

        YAxisListBox.Invalidate;
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.UpdateDataViewEdit;
var
  iDataView : TiPlotDataView;
begin
  DataViewGridXAxisNameComboBoxDropDown(DataViewGridXAxisNameComboBox);
  DataViewGridYAxisNameComboBoxDropDown(DataViewGridYAxisNameComboBox);

  if DataViewListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('DataView')
    else
      begin
        EnableAllEditControlsStartingWith('DataView');

        iDataView := DataViewListBox.Items.Objects[DataViewListBox.ItemIndex] as TiPlotDataView;

        DataViewNameEdit.AsString                              := iDataView.Name;
        DataViewEnabledCheckBox.AsBoolean                      := iDataView.Enabled;
        DataViewPopupEnabledCheckBox.AsBoolean                 := iDataView.PopupEnabled;
        DataViewLayerEdit.AsInteger                            := iDataView.Layer;

        DataViewBackGroundTransparentCheckBox.AsBoolean        := iDataView.BackgroundTransparent;
        DataViewBackgroundColorPicker.Color                    := iDataView.BackgroundColor;
        DataViewGridShow.AsBoolean                             := iDataView.GridShow;

        DataViewAxesControlEnabledCheckBox.AsBoolean           := iDataView.AxesControlEnabled;
        DataViewAxesControlAllowInSelectModeCheckBox.AsBoolean := iDataView.AxesControlAllowInSelectMode;
        DataViewAxesControlMouseStyleComboBox.AsInteger        := ord(iDataView.AxesControlMouseStyle);
        DataViewAxesControlWheelStyleComboBox.AsInteger        := ord(iDataView.AxesControlWheelStyle);

        DataViewGridLineColorPicker.Color                      := iDataView.GridLineColor;
        DataViewGridLineShowLeft.AsBoolean                     := iDataView.GridLineShowLeft;
        DataViewGridLineShowTop.AsBoolean                      := iDataView.GridLineShowTop;
        DataViewGridLineShowRight.AsBoolean                    := iDataView.GridLineShowRight;
        DataViewGridLineShowBottom.AsBoolean                   := iDataView.GridLineShowBottom;
        DataViewGridLineShowXMajorsCheckBox.AsBoolean          := iDataView.GridLineShowXMajors;
        DataViewGridLineShowXMinorsCheckBox.AsBoolean          := iDataView.GridLineShowXMinors;
        DataViewGridLineShowYMajorsCheckBox.AsBoolean          := iDataView.GridLineShowYMajors;
        DataViewGridLineShowYMinorsCheckBox.AsBoolean          := iDataView.GridLineShowYMinors;
        DataViewGridLineMajorStyleComboBox.AsInteger           := ord(iDataView.GridLineMajorStyle);
        DataViewGridLineMinorStyleComboBox.AsInteger           := ord(iDataView.GridLineMinorStyle);

        DataViewGridLineXMajorCustomCheckBox.AsBoolean         := iDataView.GridLineXMajorCustom;
        DataViewGridLineXMajorColorColorPicker.Color           := iDataView.GridLineXMajorColor;
        DataViewGridLineXMajorWidthEdit.AsInteger              := iDataView.GridLineXMajorWidth;
        DataViewGridLineXMajorStyleComboBox.AsInteger          := ord(iDataView.GridLineXMajorStyle);

        DataViewGridLineXMinorCustomCheckBox.AsBoolean         := iDataView.GridLineXMinorCustom;
        DataViewGridLineXMinorColorColorPicker.Color           := iDataView.GridLineXMinorColor;
        DataViewGridLineXMinorWidthEdit.AsInteger              := iDataView.GridLineXMinorWidth;
        DataViewGridLineXMinorStyleComboBox.AsInteger          := ord(iDataView.GridLineXMinorStyle);

        DataViewGridLineYMajorCustomCheckBox.AsBoolean         := iDataView.GridLineYMajorCustom;
        DataViewGridLineYMajorColorColorPicker.Color           := iDataView.GridLineYMajorColor;
        DataViewGridLineYMajorWidthEdit.AsInteger              := iDataView.GridLineYMajorWidth;
        DataViewGridLineYMajorStyleComboBox.AsInteger          := ord(iDataView.GridLineYMajorStyle);

        DataViewGridLineYMinorCustomCheckBox.AsBoolean         := iDataView.GridLineYMinorCustom;
        DataViewGridLineYMinorColorColorPicker.Color           := iDataView.GridLineYMinorColor;
        DataViewGridLineYMinorWidthEdit.AsInteger              := iDataView.GridLineYMinorWidth;
        DataViewGridLineYMinorStyleComboBox.AsInteger          := ord(iDataView.GridLineYMinorStyle);

        DataViewGridXAxisNameComboBox.ItemIndex := DataViewGridXAxisNameComboBox.Items.IndexOf(iDataView.GridXAxisName);
        DataViewGridYAxisNameComboBox.ItemIndex := DataViewGridYAxisNameComboBox.Items.IndexOf(iDataView.GridYAxisName);

        DataViewListBox.Invalidate;
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.UpdateChannelEdit;
var
  iChannelObject : TiPlotChannelCustom;
begin
  XAxisNameComboBoxDropDown(ChannelXAxisNameComboBox);
  YAxisNameComboBoxDropDown(ChannelYAxisNameComboBox);

  if Master.ChannelClass = TiXYPlotChannel then
    begin
      ChannelFillTabSheet.TabVisible            := False;
      ChannelDigitalTabSheet.TabVisible         := False;
      ChannelFastDrawCheckBox.Visible           := False;
      ChannelHighLowTabSheet.TabVisible         := False;
      ChannelBarTabSheet.TabVisible             := False;
      ChannelInterpolationStyleComboBox.Visible := False;
      ChannelInterpolationStyleLabel.Visible    := False;
    end
  else
    begin
      ChannelFillTabSheet.TabVisible            := True;
      ChannelDigitalTabSheet.TabVisible         := True;
      ChannelFastDrawCheckBox.Visible           := True;
      ChannelHighLowTabSheet.TabVisible         := True;
      ChannelBarTabSheet.TabVisible             := True;
      ChannelInterpolationStyleComboBox.Visible := True;
      ChannelInterpolationStyleLabel.Visible    := True;
    end;

  if ChannelListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Channel')
    else
      begin
        EnableAllEditControlsStartingWith('Channel');

        iChannelObject := ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom;
        ChannelNameEdit.AsString                             := iChannelObject.Name;
        ChannelVisibleCheckBox.AsBoolean                     := iChannelObject.Visible;
        ChannelPopupEnabledCheckBox.AsBoolean                := iChannelObject.PopupEnabled;
        ChannelLayerEdit.AsInteger                           := iChannelObject.Layer;

        ChannelTitleEdit.AsString                            := iChannelObject.TitleText;
        ChannelVisibleInLegendCheckBox.AsBoolean             := iChannelObject.VisibleInLegend;
        ChannelUserCanMoveDataPointsCheckBox.AsBoolean       := iChannelObject.UserCanMoveDataPoints;
        ChannelUserCanMoveDataPointsStyleComboBox.AsInteger  := ord(iChannelObject.UserCanMoveDataPointsStyle);
        ChannelRingBufferSizeEdit.AsInteger                  := iChannelObject.RingBufferSize;
        ChannelColorPicker.Color                             := iChannelObject.Color;
        ChannelXAxisTrackingEnabled.AsBoolean                := iChannelObject.XAxisTrackingEnabled;
        ChannelYAxisTrackingEnabled.AsBoolean                := iChannelObject.YAxisTrackingEnabled;
        ChannelDataStyleComboBox.AsInteger                   := ord(iChannelObject.DataStyle);

        ChannelTraceVisibleCheckBox.AsBoolean                := iChannelObject.TraceVisible;
        ChannelTraceLineStyleComboBox.AsInteger              := ord(iChannelObject.TraceLineStyle);
        ChannelTraceLineWidthEdit.AsInteger                  := iChannelObject.TraceLineWidth;

        ChannelMarkersVisible.AsBoolean                      := iChannelObject.MarkersVisible;
        ChannelMarkersAllowIndividual.AsBoolean              := iChannelObject.MarkersAllowIndividual;
        ChannelMarkersStyleComboBox.AsInteger                := ord(iChannelObject.MarkersStyle);
        ChannelMarkersSizeEdit.AsInteger                     := iChannelObject.MarkersSize;
        ChannelMarkersPenStyleComboBox.AsInteger             := ord(iChannelObject.MarkersPenStyle);
        ChannelMarkersPenColorPicker.Color                   := iChannelObject.MarkersPenColor;
        ChannelMarkersPenUseChannelColorCheckBox.AsBoolean   := iChannelObject.MarkersPenUseChannelColor;
        ChannelMarkersPenWidthEdit.AsInteger                 := iChannelObject.MarkersPenWidth;
        ChannelMarkersBrushStyleComboBox.AsInteger           := ord(iChannelObject.MarkersBrushStyle);
        ChannelMarkersBrushColorPicker.Color                 := iChannelObject.MarkersBrushColor;
        ChannelMarkersBrushUseChannelColorCheckBox.AsBoolean := iChannelObject.MarkersBrushUseChannelColor;
        ChannelMarkersTurnOffLimitEdit.AsInteger             := iChannelObject.MarkersTurnOffLimit;

        ChannelLogFileNameEdit.AsString                      := iChannelObject.LogFileName;
        ChannelLogBufferSizeEdit.AsInteger                   := iChannelObject.LogBufferSize;

        ChannelMarkersFontPicker.Font.Assign(iChannelObject.MarkersFont);

        if iChannelObject.LoggingActive then
          begin
            ChannelLogFileNameEdit.Enabled := False;
            ChannelLogFileNamePicker.Disable;
          end
        else
          begin
            ChannelLogFileNameEdit.Enabled := True;
            ChannelLogFileNamePicker.Enable;
          end;

        if iChannelObject is TiPlotChannel then
          begin
            ChannelFillEnabledCheckBox.AsBoolean             := (iChannelObject as TiPlotChannel).FillEnabled;
            ChannelFillReferenceEdit.AsFloat                 := (iChannelObject as TiPlotChannel).FillReference;
            ChannelFillStyleComboBox.AsInteger               := ord((iChannelObject as TiPlotChannel).FillStyle);
            ChannelFillColorPicker.Color                     := (iChannelObject as TiPlotChannel).FillColor;
            ChannelFillUseChannelColorCheckBox.AsBoolean     := (iChannelObject as TiPlotChannel).FillUseChannelColor;

            ChannelBarEnabledCheckBox.AsBoolean              := (iChannelObject as TiPlotChannel).BarEnabled;
            ChannelBarWidthEdit.AsFloat                      := (iChannelObject as TiPlotChannel).BarWidth;
            ChannelBarReferenceEdit.AsFloat                  := (iChannelObject as TiPlotChannel).BarReference;
            ChannelBarPenUseChannelColorCheckBox.AsBoolean   := (iChannelObject as TiPlotChannel).BarPenUseChannelColor;
            ChannelBarPenStyleComboBox.AsInteger             := ord((iChannelObject as TiPlotChannel).BarPenStyle);
            ChannelBarPenColorPicker.Color                   := (iChannelObject as TiPlotChannel).BarPenColor;
            ChannelBarPenWidthEdit.AsInteger                 := (iChannelObject as TiPlotChannel).BarPenWidth;
            ChannelBarBrushUseChannelColorCheckBox.AsBoolean := (iChannelObject as TiPlotChannel).BarBrushUseChannelColor;
            ChannelBarBrushStyleComboBox.AsInteger           := ord((iChannelObject as TiPlotChannel).BarBrushStyle);
            ChannelBarBrushColorPicker.Color                 := (iChannelObject as TiPlotChannel).BarBrushColor;

            ChannelHighLowStyleComboBox.AsInteger            := ord((iChannelObject as TiPlotChannel).HighLowStyle);
            ChannelHighLowEnabledCheckBox.AsBoolean          := (iChannelObject as TiPlotChannel).HighLowEnabled;
            ChannelHighLowBarColorPicker.Color               := (iChannelObject as TiPlotChannel).HighLowBarColor;
            ChannelHighLowBarWidthEdit.AsFloat               := (iChannelObject as TiPlotChannel).HighLowBarWidth;
            ChannelHighLowOpenShowCheckBox.AsBoolean         := (iChannelObject as TiPlotChannel).HighLowOpenShow;
            ChannelHighLowOpenColorPicker.Color              := (iChannelObject as TiPlotChannel).HighLowOpenColor;
            ChannelHighLowOpenWidthEdit.AsFloat              := (iChannelObject as TiPlotChannel).HighLowOpenWidth;
            ChannelHighLowOpenHeightEdit.AsFloat             := (iChannelObject as TiPlotChannel).HighLowOpenHeight;
            ChannelHighLowCloseShowCheckBox.AsBoolean        := (iChannelObject as TiPlotChannel).HighLowCloseShow;
            ChannelHighLowCloseColorPicker.Color             := (iChannelObject as TiPlotChannel).HighLowCloseColor;
            ChannelHighLowCloseWidthEdit.AsFloat             := (iChannelObject as TiPlotChannel).HighLowCloseWidth;
            ChannelHighLowCloseHeightEdit.AsFloat            := (iChannelObject as TiPlotChannel).HighLowCloseHeight;
            ChannelHighLowShadowColorPicker.Color            := (iChannelObject as TiPlotChannel).HighLowShadowColor;
            ChannelHighLowBullishColorPicker.Color           := (iChannelObject as TiPlotChannel).HighLowBullishColor;
            ChannelHighLowBearishColorPicker.Color           := (iChannelObject as TiPlotChannel).HighLowBearishColor;

            ChannelDigitalEnabledCheckBox.AsBoolean          := (iChannelObject as TiPlotChannel).DigitalEnabled;
            ChannelDigitalReferenceHighEdit.AsFloat          := (iChannelObject as TiPlotChannel).DigitalReferenceHigh;
            ChannelDigitalReferenceLowEdit.AsFloat           := (iChannelObject as TiPlotChannel).DigitalReferenceLow;
            ChannelDigitalReferenceStyleComboBox.AsInteger   := ord((iChannelObject as TiPlotChannel).DigitalReferenceStyle);

            ChannelFastDrawCheckBox.AsBoolean                := (iChannelObject as TiPlotChannel).FastDrawEnabled;
            ChannelClipToAxesCheckBox.AsBoolean              := (iChannelObject as TiPlotChannel).ClipToAxes;

            ChannelInterpolationStyleComboBox.AsInteger      := ord((iChannelObject as TiPlotChannel).InterpolationStyle);
          end;

        ChannelXAxisNameComboBox.ItemIndex := ChannelXAxisNameComboBox.Items.IndexOf(iChannelObject.XAxisName);
        ChannelYAxisNameComboBox.ItemIndex := ChannelYAxisNameComboBox.Items.IndexOf(iChannelObject.YAxisName);

        ChannelLogActivateButton.Enabled   := not iChannelObject.LoggingActive;
        ChannelLogDeactivateButton.Enabled :=     iChannelObject.LoggingActive;

        ChannelListBox.Invalidate;
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.UpdateDataCursorEdit;
var
  iDataCursor : TiPlotDataCursor;
begin
  DataCursorChannelNameComboBoxDropDown(DataCursorChannelNameComboBox);

  if DataCursorListBox.ItemIndex = - 1 then
    begin
      DisableAllEditControlsStartingWith('DataCursor');
    end
  else
    begin
      EnableAllEditControlsStartingWith('DataCursor');

      iDataCursor := DataCursorListBox.Items.Objects[DataCursorListBox.ItemIndex] as TiPlotDataCursor;

      DataCursorNameEdit.AsString                        := iDataCursor.Name;
      DataCursorPopupEnabledCheckBox.AsBoolean           := iDataCursor.PopupEnabled;
      DataCursorPointerPenWidthEdit.AsInteger            := iDataCursor.PointerPenWidth;
      DataCursorSnapToDataPointCheckBox.AsBoolean        := iDataCursor.SnapToDataPoint;

      DataCursorStyleComboBox.AsInteger                  := ord(iDataCursor.Style);
      DataCursorColorPicker.Color                        := iDataCursor.Color;
      DataCursorUseChannelColorCheckBox.AsBoolean        := iDataCursor.UseChannelColor;

      DataCursorHintPositionEdit.AsFloat                 := iDataCursor.HintPosition;
      DataCursorHintShowCheckBox.AsBoolean               := iDataCursor.HintShow;
      DataCursorHintHideOnReleaseCheckBox.AsBoolean      := iDataCursor.HintHideOnRelease;
      DataCursorOrientationSideRadioGroup.AsInteger      := ord(iDataCursor.HintOrientationSide);
      DataCursorPointer1PositionEdit.AsFloat             := iDataCursor.Pointer1Position;
      DataCursorPointer2PositionEdit.AsFloat             := iDataCursor.Pointer2Position;
      DataCursorPointerPenWidthEdit.AsInteger            := iDataCursor.PointerPenWidth;

      DataCursorChannelAllowAllCheckBox.AsBoolean        := iDataCursor.ChannelAllowAll;
      DataCursorChannelShowAllInLegendCheckBox.AsBoolean := iDataCursor.ChannelShowAllInLegend;

      DataCursorFontPicker.Font.Assign(iDataCursor.Font);

      DataCursorChannelNameComboBox.ItemIndex := DataCursorChannelNameComboBox.Items.IndexOf(iDataCursor.ChannelName);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.UpdateLimitEdit;
var
  iLimit : TiPlotLimit;
begin
  XAxisNameComboBoxDropDown(LimitXAxisNameComboBox);
  YAxisNameComboBoxDropDown(LimitYAxisNameComboBox);

  if LimitListBox.ItemIndex = - 1 then
    begin
      DisableAllEditControlsStartingWith('Limit');
    end
  else
    begin
      EnableAllEditControlsStartingWith('Limit');

      iLimit := LimitListBox.Items.Objects[LimitListBox.ItemIndex] as TiPlotLimit;

      LimitNameEdit.AsString              := iLimit.Name;
      LimitVisibleCheckBox.AsBoolean      := iLimit.Visible;
      LimitUserCanMoveCheckBox.AsBoolean  := iLimit.UserCanMove;
      LimitPopUpEnabledCheckBox.AsBoolean := iLimit.PopupEnabled;
      LimitClipToAxesCheckBox.AsBoolean   := iLimit.ClipToAxes;
      LimitLayerEdit.AsInteger            := iLimit.Layer;

      LimitStyleComboBox.AsInteger        := ord(iLimit.Style);
      LimitLine1PositionEdit.AsFloat      := iLimit.Line1Position;
      LimitLine2PositionEdit.AsFloat      := iLimit.Line2Position;

      LimitFillStyleCombobox.AsInteger    := ord(iLimit.FillStyle);
      LimitLineStyleComboBox.AsInteger    := ord(iLimit.LineStyle);
      LimitLineWidthEdit.AsInteger        := iLimit.LineWidth;
      LimitColorPicker.Color              := iLimit.Color;

      LimitXAxisNameComboBox.ItemIndex    := LimitXAxisNameComboBox.Items.IndexOf(iLimit.XAxisName);
      LimitYAxisNameComboBox.ItemIndex    := LimitYAxisNameComboBox.Items.IndexOf(iLimit.YAxisName);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.UpdateLabelEdit;
var
  iLable : TiPlotLabel;
begin
  if LabelListBox.ItemIndex = -1 then
    begin
      DisableAllEditControlsStartingWith('Label');
    end
  else
    begin
      EnableAllEditControlsStartingWith('Label');

      iLable := LabelListBox.Items.Objects[LabelListBox.ItemIndex] as TiPlotLabel;

      LabelNameEdit.AsString            := iLable.Name;
      LabelVisibleCheckBox.AsBoolean    := iLable.Visible;
      LabelCaptionMemo.AsString         := iLable.Caption;
      LabelMarginLeftEdit.AsFloat       := iLable.MarginLeft;
      LabelMarginTopEdit.AsFloat        := iLable.MarginTop;
      LabelMarginRightEdit.AsFloat      := iLable.MarginRight;
      LabelMarginBottomEdit.AsFloat     := iLable.MarginBottom;
      LabelAlignmentComboBox.AsInteger  := ord(iLable.Alignment);
      LabelImageListIndexEdit.AsInteger := iLable.ImageListIndex;
      LabelImageIndexEdit.AsInteger     := iLable.ImageIndex;

      LabelFontPicker.Font.Assign(iLable.Font);

      if LabelListBox.ItemIndex = 0 then LabelRemoveButton.Enabled := False;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelStatsClear;
begin
  if ChannelListBox.ItemIndex = - 1 then
    begin
      ChannelStatsPointCountDisplay.Caption    := '';
      ChannelStatsPointCapacityDisplay.Caption := '';
      ChannelStatsMemoryDisplay.Caption        := '';
      ChannelStatsDataPointSizeDisplay.Caption := '';
      ChannelStatsMaxDataPointsDisplay.Caption := '';
      ChannelStatsXMinDisplay.Caption          := '';
      ChannelStatsXMaxDisplay.Caption          := '';
      ChannelStatsXMeanDisplay.Caption         := '';
      ChannelStatsYMinDisplay.Caption          := '';
      ChannelStatsYMaxDisplay.Caption          := '';
      ChannelStatsYMeanDisplay.Caption         := '';
    end
  else
    begin
      ChannelStatsPointCountDisplay.Caption    := 'Click Refresh';
      ChannelStatsPointCapacityDisplay.Caption := 'Click Refresh';
      ChannelStatsMemoryDisplay.Caption        := 'Click Refresh';
      ChannelStatsDataPointSizeDisplay.Caption := 'Click Refresh';
      ChannelStatsMaxDataPointsDisplay.Caption := 'Click Refresh';
      ChannelStatsXMinDisplay.Caption          := 'Click Refresh';
      ChannelStatsXMaxDisplay.Caption          := 'Click Refresh';
      ChannelStatsXMeanDisplay.Caption         := 'Click Refresh';
      ChannelStatsYMinDisplay.Caption          := 'Click Refresh';
      ChannelStatsYMaxDisplay.Caption          := 'Click Refresh';
      ChannelStatsYMeanDisplay.Caption         := 'Click Refresh';
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.RefreshChannelStats;
var
  iChannelObject : TiPlotChannelCustom;
begin
  if ChannelListBox.ItemIndex = - 1 then ChannelStatsClear
  else
    begin
      iChannelObject := ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom;

      ChannelStatsPointCountDisplay.Caption    := IntToStr(iChannelObject.Count);
      ChannelStatsPointCapacityDisplay.Caption := IntToStr(iChannelObject.Capacity);
      ChannelStatsMemoryDisplay.Caption        := IntToStr(iChannelObject.MemoryUsed)    + ' Bytes';
      ChannelStatsDataPointSizeDisplay.Caption := IntToStr(iChannelObject.DataPointSize) + ' Bytes';
      ChannelStatsMaxDataPointsDisplay.Caption := IntToStr(iChannelObject.MaxDataPoints);

      iChannelObject.ReCalcRunningMinMaxMean;

      if Assigned(iChannelObject.XAxis) then
        begin
          ChannelStatsXMinDisplay.Caption          := iChannelObject.XAxis.GetLabelText(iChannelObject.RunningXMin);
          ChannelStatsXMaxDisplay.Caption          := iChannelObject.XAxis.GetLabelText(iChannelObject.RunningXMax);
          ChannelStatsXMeanDisplay.Caption         := iChannelObject.XAxis.GetLabelText(iChannelObject.RunningXMean);
        end
      else
        begin
          ChannelStatsXMinDisplay.Caption          := FloatToStr(iChannelObject.RunningXMin);
          ChannelStatsXMaxDisplay.Caption          := FloatToStr(iChannelObject.RunningXMax);
          ChannelStatsXMeanDisplay.Caption         := FloatToStr(iChannelObject.RunningXMean);
        end;

      if Assigned(iChannelObject.YAxis) then
        begin
          ChannelStatsYMinDisplay.Caption          := iChannelObject.YAxis.GetLabelText(iChannelObject.RunningYMin);
          ChannelStatsYMaxDisplay.Caption          := iChannelObject.YAxis.GetLabelText(iChannelObject.RunningYMax);
          ChannelStatsYMeanDisplay.Caption         := iChannelObject.YAxis.GetLabelText(iChannelObject.RunningYMean);
        end
      else
        begin
          ChannelStatsYMinDisplay.Caption          := FloatToStr(iChannelObject.RunningYMin);
          ChannelStatsYMaxDisplay.Caption          := FloatToStr(iChannelObject.RunningYMax);
          ChannelStatsYMeanDisplay.Caption         := FloatToStr(iChannelObject.RunningYMean);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ToolBarChange(Sender: TObject);
var
  iToolBar : TiPlotToolBar;
begin
  if ToolBarListBox.ItemIndex = -1 then exit;

  iToolBar := ToolBarListBox.Items.Objects[ToolBarListBox.ItemIndex] as TiPlotToolBar;

  iToolBar.Name                 := ToolBarNameEdit.AsString;
  iToolBar.Visible              := ToolBarVisibleCheckbox.AsBoolean;
  iToolBar.Enabled              := ToolBarEnabledCheckBox.AsBoolean;
  iToolBar.PopupEnabled         := ToolBarPopupEnabledCheckBox.AsBoolean;
  iToolBar.FlatBorder           := ToolBarFlatBorderCheckBox.AsBoolean;
  iToolBar.FlatButtons          := ToolBarFlatButtonsCheckBox.AsBoolean;
  iToolBar.SmallButtons         := ToolBarSmallButtonsCheckBox.AsBoolean;

  iToolBar.ShowResumeButton     := ToolBarShowResumeButtonCheckBox.AsBoolean;
  iToolBar.ShowPauseButton      := ToolBarShowPauseButtonCheckBox.AsBoolean;
  iToolBar.ShowAxesModeButtons  := ToolBarShowAxesModeButtonsCheckBox.AsBoolean;
  iToolBar.ShowZoomInOutButtons := ToolBarShowZoomInOutButtonsCheckBox.AsBoolean;
  iToolBar.ShowSelectButton     := ToolBarShowSelectButtonCheckBox.AsBoolean;
  iToolBar.ShowZoomBoxButton    := ToolBarShowZoomBoxButtonCheckBox.AsBoolean;
  iToolBar.ShowCursorButton     := ToolBarShowCursorButtonCheckBox.AsBoolean;
  iToolBar.ShowEditButton       := ToolBarShowEditButtonCheckBox.AsBoolean;
  iToolBar.ShowCopyButton       := ToolBarShowCopyButtonCheckBox.AsBoolean;
  iToolBar.ShowSaveButton       := ToolBarShowSaveButtonCheckBox.AsBoolean;
  iToolBar.ShowPrintButton      := ToolBarShowPrintButtonCheckBox.AsBoolean;
  iToolBar.ShowPreviewButton    := ToolBarShowPreviewButtonCheckBox.AsBoolean;

  iToolBar.ZoomInOutFactor      := ToolBarZoomInOutFactorEdit.AsFloat;

  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.LegendChange(Sender: TObject);
var
  iLegend : TiPlotLegend;
begin
  if ChannelListBox.ItemIndex = -1 then exit;

  iLegend := LegendListBox.Items.Objects[LegendListBox.ItemIndex] as TiPlotLegend;

  iLegend.Name                        := LegendNameEdit.AsString;
  iLegend.Visible                     := LegendVisibleCheckbox.AsBoolean;
  iLegend.Enabled                     := LegendEnabledCheckbox.AsBoolean;
  iLegend.PopupEnabled                := LegendPopupEnabledCheckbox.AsBoolean;

  iLegend.MarginTop                   := LegendTopMarginEdit.AsFloat;
  iLegend.MarginBottom                := LegendBottomMarginEdit.AsFloat;
  iLegend.MarginLeft                  := LegendLeftMarginEdit.AsFloat;
  iLegend.MarginRight                 := LegendRightMarginEdit.AsFloat;

  iLegend.ChannelNameMaxWidth         := LegendChannelNameMaxWidthEdit.AsFloat;
  iLegend.ChannelNameColorStyle       := TiPlotLegendChannelNameColorStyle(LegendChannelNameColorStyleComboBox.AsInteger);
  iLegend.LineColumnWidth             := LegendLineColumnWidthEdit.AsInteger;
  iLegend.LineColumnHeight            := LegendLineColumnHeightEdit.AsInteger;
  iLegend.ColumnSpacing               := LegendColumnSpacingEdit.AsFloat;
  iLegend.BackGroundTransparent       := LegendBackGroundTransparentCheckBox.AsBoolean;
  iLegend.BackGroundColor             := LegendBackgroundColorPicker.Color;
  iLegend.SelectedItemBackGroundColor := LegendSelectedItemColorPicker.Color;

  iLegend.ShowColumnLine              := LegendShowLineCheckbox.AsBoolean;
  iLegend.ShowColumnMarker            := LegendShowMarkerCheckbox.AsBoolean;
  iLegend.ShowColumnXAxisTitle        := LegendShowXAxisTitleCheckbox.AsBoolean;
  iLegend.ShowColumnYAxisTitle        := LegendShowYAxisTitleCheckbox.AsBoolean;
  iLegend.ShowColumnXValue            := LegendShowXValueCheckbox.AsBoolean;
  iLegend.ShowColumnYValue            := LegendShowYValueCheckbox.AsBoolean;
  iLegend.ShowColumnYMax              := LegendShowYMaxCheckbox.AsBoolean;
  iLegend.ShowColumnYMin              := LegendShowYMinCheckbox.AsBoolean;
  iLegend.ShowColumnYMean             := LegendShowYMeanCheckbox.AsBoolean;

  iLegend.WrapColDesiredCount         := LegendWrapColDesiredCountEdit.AsInteger;
  iLegend.WrapColAutoCountEnabled     := LegendWrapColAutoCountEnabledCheckBox.AsBoolean;
  iLegend.WrapColAutoCountMax         := LegendWrapColAutoCountMaxEdit.AsInteger;
  iLegend.WrapColSpacingMin           := LegendWrapColSpacingMinEdit.AsFloat;
  iLegend.WrapColSpacingAuto          := LegendWrapColSpacingAutoCheckBox.AsBoolean;

  iLegend.WrapRowDesiredCount         := LegendWrapRowDesiredCountEdit.AsInteger;
  iLegend.WrapRowAutoCountEnabled     := LegendWrapRowAutoCountEnabledCheckBox.AsBoolean;
  iLegend.WrapRowAutoCountMax         := LegendWrapRowAutoCountMaxEdit.AsInteger;
  iLegend.WrapRowSpacingMin           := LegendWrapRowSpacingMinEdit.AsFloat;
  iLegend.WrapRowSpacingAuto          := LegendWrapRowSpacingAutoCheckBox.AsBoolean;

  iLegend.ColumnTitlesVisible         := LegendColumnTitlesVisibleCheckbox.AsBoolean;

  iLegend.Font.Assign            (LegendFontPicker.Font);
  iLegend.SelectedItemFont.Assign(LegendSelectedItemFontPicker.Font);
  iLegend.ColumnTitlesFont.Assign(LegendColumnTitlesFontPicker.Font);

  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.TableChange(Sender: TObject);
var
  iTable : TiPlotTable;
begin
  if ChannelListBox.ItemIndex = -1 then exit;

  iTable := TableListBox.Items.Objects[TableListBox.ItemIndex] as TiPlotTable;

  iTable.Name                      := TableNameEdit.AsString;
  iTable.Visible                   := TableVisibleCheckbox.AsBoolean;
  iTable.Enabled                   := TableEnabledCheckbox.AsBoolean;
  iTable.PopupEnabled              := TablePopupEnabledCheckbox.AsBoolean;

  iTable.MarginTop                 := TableTopMarginEdit.AsFloat;
  iTable.MarginLeft                := TableLeftMarginEdit.AsFloat;
  iTable.MarginRight               := TableRightMarginEdit.AsFloat;
  iTable.MarginBottom              := TableBottomMarginEdit.AsFloat;

  iTable.ColumnSpacing             := TableColumnSpacingEdit.AsFloat;
  iTable.RowSpacing                := TableRowSpacingEdit.AsFloat;
  iTable.RowsMax                   := TableRowsMaxEdit.AsInteger;

  iTable.ColumnTitlesVisible       := TableColumnTitlesVisibleCheckBox.AsBoolean;

  iTable.GridLinesShow             := TableGridLinesShowCheckBox.AsBoolean;
  iTable.GridLinesColor            := TableGridLinesColorPicker.Color;

  iTable.StartPercent              := TableStartPercentEdit.AsFloat;
  iTable.StopPercent               := TableStopPercentEdit.AsFloat;

  iTable.GridBackGroundTransparent := TableGridBackGroundTransparentCheckBox.AsBoolean;
  iTable.GridBackGroundColor       := TableGridBackgroundColorPicker.Color;

  iTable.DataFont.Assign(TableDataFontPicker.Font);
  iTable.ColumnTitlesFont.Assign(TableColumnTitlesFontPicker.Font);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.XAxisChange(Sender: TObject);
var
  iAxis : TiPlotXAxis;
begin
  if XAxisListBox.ItemIndex = -1 then exit;

  iAxis := XAxisListBox.Items.Objects[XAxisListBox.ItemIndex] as TiPlotXAxis;

  iAxis.Name                      := XAxisNameEdit.AsString;
  iAxis.Visible                   := XAxisVisibleCheckBox.AsBoolean;
  iAxis.GridLinesVisible          := XAxisGridLinesVisibleCheckBox.AsBoolean;
  iAxis.Enabled                   := XAxisEnabledCheckBox.AsBoolean;
  iAxis.PopupEnabled              := XAxisPopupEnabledCheckBox.AsBoolean;
  iAxis.Layer                     := XAxisLayerEdit.AsInteger;

  iAxis.StartPercent              := XAxisStartPercentEdit.AsFloat;
  iAxis.StopPercent               := XAxisStopPercentEdit.AsFloat;

  iAxis.Min                       := XAxisMinEdit.AsFloat;
  iAxis.Span                      := XAxisSpanEdit.AsFloat;
  iAxis.DesiredStart              := XAxisDesiredStartEdit.AsFloat;
  iAxis.DesiredIncrement          := XAxisDesiredIncrementEdit.AsFloat;
  iAxis.ReverseScale              := XAxisReverseScaleCheckBox.AsBoolean;
  iAxis.RestoreValuesOnResume     := XAxisRestoreValuesOnResumeCheckBox.AsBoolean;
  iAxis.MasterUIInput             := XAxisMasterUIInputCheckBox.AsBoolean;
  iAxis.InnerMargin               := XAxisInnerMarginEdit.AsInteger;
  iAxis.OuterMargin               := XAxisOuterMarginEdit.AsInteger;

  iAxis.Title                     := XAxisTitleTextEdit.AsString;
  iAxis.TitleMargin               := XAxisTitleMarginEdit.AsFloat;
  iAxis.TitleShow                 := XAxisTitleShowCheckBox.AsBoolean;
  iAxis.TitleRotated              := XAxisTitleRotatedCheckBox.AsBoolean;

  iAxis.ScaleLinesShow            := XAxisScaleLinesShowCheckBox.AsBoolean;
  iAxis.ScaleLinesColor           := XAxisScaleLinesColorPicker.Color;
  iAxis.MajorLength               := XAxisMajorLengthEdit.AsInteger;
  iAxis.MinorLength               := XAxisMinorLengthEdit.AsInteger;
  iAxis.MinorCount                := XAxisMinorCountEdit.AsInteger;

  iAxis.LabelsVisible             := XAxisLabelVisibleCheckBox.AsBoolean;
  iAxis.LabelsMargin              := XAxisLabelMarginEdit.AsFloat;

  iAxis.LabelsFormatStyle         := TiPlotTextFormat(XAxisLabelFormatStyleComboBox.AsInteger);
  iAxis.LabelsRotation            := TiRotationAngle(XAxisLabelRotationComboBox.AsInteger);
  iAxis.DateTimeFormat            := XAxisDateTimeFormatComboBox.AsString;
  iAxis.LabelsPrecisionStyle      := TiPrecisionStyle(XAxisLabelPrecisionStyleComboBox.AsInteger);
  iAxis.LabelsPrecision           := XAxisLabelPrecisionEdit.AsInteger;
  iAxis.LabelsMinLength           := XAxisLabelMinLengthEdit.AsFloat;
  iAxis.LabelsMinLengthAutoAdjust := XAxisLabelMinLengthAutoAdjustCheckBox.AsBoolean;

  iAxis.CursorUseDefaultFormat    := XAxisCursorUseDefaultFormatCheckBox.AsBoolean;
  iAxis.CursorFormatStyle         := TiPlotTextFormat(XAxisCursorFormatStyleComboBox.AsInteger);
  iAxis.CursorDateTimeFormat      := XAxisCursorDateTimeFormatComboBox.AsString;
  iAxis.CursorPrecisionStyle      := TiPrecisionStyle(XAxisCursorPrecisionStyleComboBox.AsInteger);
  iAxis.CursorPrecision           := XAxisCursorPrecisionEdit.AsInteger;
  iAxis.CursorMinLength           := XAxisCursorMinLengthEdit.AsFloat;
  iAxis.CursorMinLengthAutoAdjust := XAxisCursorMinLengthAutoAdjustCheckBox.AsBoolean;

  iAxis.LegendUseDefaultFormat    := XAxisLegendUseDefaultFormatCheckBox.AsBoolean;
  iAxis.LegendFormatStyle         := TiPlotTextFormat(XAxisLegendFormatStyleComboBox.AsInteger);
  iAxis.LegendDateTimeFormat      := XAxisLegendDateTimeFormatComboBox.AsString;
  iAxis.LegendPrecisionStyle      := TiPrecisionStyle(XAxisLegendPrecisionStyleComboBox.AsInteger);
  iAxis.LegendPrecision           := XAxisLegendPrecisionEdit.AsInteger;
  iAxis.LegendMinLength           := XAxisLegendMinLengthEdit.AsFloat;
  iAxis.LegendMinLengthAutoAdjust := XAxisLegendMinLengthAutoAdjustCheckBox.AsBoolean;

  iAxis.TrackingEnabled           := XAxisTrackingEnabledCheckBox.AsBoolean;
  iAxis.TrackingStyle             := TiPlotTrackingStyle(XAxisTrackingStyleComboBox.AsInteger);
  iAxis.TrackingIncrementStyle    := TiPlotTrackingIncrementStyle(XAxisTrackingIncrementStyleComboBox.AsInteger);
  iAxis.TrackingAlignFirstStyle   := TiPlotAlignFirstStyle(XAxisTrackingAlignFirstStyleComboBox.AsInteger);
  iAxis.TrackingScrollCompressMax := XAxisTrackingScrollCompressMaxEdit.AsFloat;
  iAxis.TrackingSpanMinimum       := XAxisTrackingSpanMinimumEdit.AsFloat;
  iAxis.TrackingMaxMargin         := XAxisTrackingMaxMarginEdit.AsFloat;
  iAxis.TrackingMinMargin         := XAxisTrackingMinMarginEdit.AsFloat;

  iAxis.StackingEndsMargin        := XAxisStackingEndsMarginEdit.AsFloat;
  iAxis.ForceStacking             := XAxisForceStackingCheckBox.AsBoolean;

  iAxis.LabelSeparation           := XAxisLabelSeparationEdit.AsFloat;
  iAxis.ScaleType                 := TiPlotScaleType(XAxisScaleTypeRadioGroup.AsInteger);

  iAxis.CursorScaler              := XAxisCursorScalerEdit.AsFloat;

  iAxis.ScrollMinMaxEnabled       := XAxisScrollMinMaxEnabledCheckBox.AsBoolean;
  iAxis.ScrollMin                 := XAxisScrollMinEdit.AsFloat;
  iAxis.ScrollMax                 := XAxisScrollMaxEdit.AsFloat;

  iAxis.CartesianStyle            := TiPlotCartesianStyle(XAxisCartesianStyleComboBox.AsInteger);
  iAxis.CartesianChildRefAxisName := XAxisCartesianChildRefAxisNameComboBox.AsString;
  iAxis.CartesianChildRefValue    := XAxisCartesianChildRefValueEdit.AsFloat;

  iAxis.AlignRefAxisName          := XAxisAlignRefAxisNameComboBox.AsString;

  iAxis.TitleFont.Assign (XAxisTitleFontPicker.Font);
  iAxis.LabelsFont.Assign(XAxisLabelFontPicker.Font);

  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.YAxisChange(Sender: TObject);
var
  iAxis : TiPlotYAxis;
begin
  if YAxisListBox.ItemIndex = -1 then exit;

  iAxis := YAxisListBox.Items.Objects[YAxisListBox.ItemIndex] as TiPlotYAxis;

  iAxis.Name                      := YAxisNameEdit.AsString;
  iAxis.Visible                   := YAxisVisibleCheckBox.AsBoolean;
  iAxis.GridLinesVisible          := YAxisGridLinesVisibleCheckBox.AsBoolean;
  iAxis.Enabled                   := YAxisEnabledCheckBox.AsBoolean;
  iAxis.PopupEnabled              := YAxisPopupEnabledCheckBox.AsBoolean;
  iAxis.Layer                     := YAxisLayerEdit.AsInteger;

  iAxis.StartPercent              := YAxisStartPercentEdit.AsFloat;
  iAxis.StopPercent               := YAxisStopPercentEdit.AsFloat;

  iAxis.Min                       := YAxisMinEdit.AsFloat;
  iAxis.Span                      := YAxisSpanEdit.AsFloat;
  iAxis.DesiredIncrement          := YAxisDesiredIncrementEdit.AsFloat;
  iAxis.DesiredStart              := YAxisDesiredStartEdit.AsFloat;
  iAxis.ReverseScale              := YAxisReverseScaleCheckBox.AsBoolean;
  iAxis.RestoreValuesOnResume     := YAxisRestoreValuesOnResumeCheckBox.AsBoolean;
  iAxis.MasterUIInput             := YAxisMasterUIInputCheckBox.AsBoolean;
  iAxis.InnerMargin               := YAxisInnerMarginEdit.AsInteger;
  iAxis.OuterMargin               := YAxisOuterMarginEdit.AsInteger;

  iAxis.Title                     := YAxisTitleTextEdit.AsString;
  iAxis.TitleMargin               := YAxisTitleMarginEdit.AsFloat;
  iAxis.TitleShow                 := YAxisTitleShowCheckBox.AsBoolean;
  iAxis.TitleRotated              := YAxisTitleRotatedCheckBox.AsBoolean;

  iAxis.ScaleLinesShow            := YAxisScaleLinesShowCheckBox.AsBoolean;
  iAxis.ScaleLinesColor           := YAxisScaleLinesColorPicker.Color;
  iAxis.MajorLength               := YAxisMajorLengthEdit.AsInteger;
  iAxis.MinorLength               := YAxisMinorLengthEdit.AsInteger;
  iAxis.MinorCount                := YAxisMinorCountEdit.AsInteger;

  iAxis.LabelsVisible             := YAxisLabelVisibleCheckBox.AsBoolean;
  iAxis.LabelsMargin              := YAxisLabelMarginEdit.AsFloat;

  iAxis.LabelsRotation            := TiRotationAngle(YAxisLabelRotationComboBox.AsInteger);
  iAxis.LabelsFormatStyle         := TiPlotTextFormat(YAxisLabelFormatStyleComboBox.AsInteger);
  iAxis.DateTimeFormat            := YAxisDateTimeFormatComboBox.AsString;
  iAxis.LabelsPrecisionStyle      := TiPrecisionStyle(YAxisLabelPrecisionStyleComboBox.AsInteger);
  iAxis.LabelsPrecision           := YAxisLabelPrecisionEdit.AsInteger;
  iAxis.LabelsMinLength           := YAxisLabelMinLengthEdit.AsFloat;
  iAxis.LabelsMinLengthAutoAdjust := YAxisLabelMinLengthAutoAdjustCheckBox.AsBoolean;

  iAxis.CursorUseDefaultFormat    := YAxisCursorUseDefaultFormatCheckBox.AsBoolean;
  iAxis.CursorFormatStyle         := TiPlotTextFormat(YAxisCursorFormatStyleComboBox.AsInteger);
  iAxis.CursorDateTimeFormat      := YAxisCursorDateTimeFormatComboBox.AsString;
  iAxis.CursorPrecisionStyle      := TiPrecisionStyle(YAxisCursorPrecisionStyleComboBox.AsInteger);
  iAxis.CursorPrecision           := YAxisCursorPrecisionEdit.AsInteger;
  iAxis.CursorMinLength           := YAxisCursorMinLengthEdit.AsFloat;
  iAxis.CursorMinLengthAutoAdjust := YAxisCursorMinLengthAutoAdjustCheckBox.AsBoolean;

  iAxis.LegendUseDefaultFormat    := YAxisLegendUseDefaultFormatCheckBox.AsBoolean;
  iAxis.LegendFormatStyle         := TiPlotTextFormat(YAxisLegendFormatStyleComboBox.AsInteger);
  iAxis.LegendDateTimeFormat      := YAxisLegendDateTimeFormatComboBox.AsString;
  iAxis.LegendPrecisionStyle      := TiPrecisionStyle(YAxisLegendPrecisionStyleComboBox.AsInteger);
  iAxis.LegendPrecision           := YAxisLegendPrecisionEdit.AsInteger;
  iAxis.LegendMinLength           := YAxisLegendMinLengthEdit.AsFloat;
  iAxis.LegendMinLengthAutoAdjust := YAxisLegendMinLengthAutoAdjustCheckBox.AsBoolean;

  iAxis.TrackingEnabled           := YAxisTrackingEnabledCheckBox.AsBoolean;
  iAxis.TrackingStyle             := TiPlotTrackingStyle(YAxisTrackingStyleComboBox.AsInteger);
  iAxis.TrackingIncrementStyle    := TiPlotTrackingIncrementStyle(YAxisTrackingIncrementStyleComboBox.AsInteger);
  iAxis.TrackingAlignFirstStyle   := TiPlotAlignFirstStyle(YAxisTrackingAlignFirstStyleComboBox.AsInteger);
  iAxis.TrackingScrollCompressMax := YAxisTrackingScrollCompressMaxEdit.AsFloat;
  iAxis.TrackingSpanMinimum       := YAxisTrackingSpanMinimumEdit.AsFloat;
  iAxis.TrackingMaxMargin         := YAxisTrackingMaxMarginEdit.AsFloat;
  iAxis.TrackingMinMargin         := YAxisTrackingMinMarginEdit.AsFloat;

  iAxis.StackingEndsMargin        := YAxisStackingEndsMarginEdit.AsFloat;
  iAxis.ForceStacking             := YAxisForceStackingCheckBox.AsBoolean;

  iAxis.LabelSeparation           := YAxisLabelSeparationEdit.AsFloat;
  iAxis.ScaleType                 := TiPlotScaleType(YAxisScaleTypeRadioGroup.AsInteger);

  iAxis.CursorPrecision           := YAxisCursorPrecisionEdit.AsInteger;
  iAxis.CursorScaler              := YAxisCursorScalerEdit.AsFloat;

  iAxis.ScrollMinMaxEnabled       := YAxisScrollMinMaxEnabledCheckBox.AsBoolean;
  iAxis.ScrollMin                 := YAxisScrollMinEdit.AsFloat;
  iAxis.ScrollMax                 := YAxisScrollMaxEdit.AsFloat;

  iAxis.CartesianStyle            := TiPlotCartesianStyle(YAxisCartesianStyleComboBox.AsInteger);
  iAxis.CartesianChildRefAxisName := YAxisCartesianChildRefAxisNameComboBox.AsString;
  iAxis.CartesianChildRefValue    := YAxisCartesianChildRefValueEdit.AsFloat;

  iAxis.AlignRefAxisName          := YAxisAlignRefAxisNameComboBox.AsString;

  iAxis.TitleFont.Assign (YAxisTitleFontPicker.Font);
  iAxis.LabelsFont.Assign(YAxisLabelFontPicker.Font);

  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.DataViewChange(Sender: TObject);
var
  iDataView : TiPlotDataView;
begin
  if DataViewListBox.ItemIndex = -1 then exit;

  iDataView := DataViewListBox.Items.Objects[DataViewListBox.ItemIndex] as TiPlotDataView;

  iDataView.Name                         := DataViewNameEdit.AsString;
  iDataView.Enabled                      := DataViewEnabledCheckBox.AsBoolean;
  iDataView.PopupEnabled                 := DataViewPopupEnabledCheckBox.AsBoolean;
  iDataView.Layer                        := DataViewLayerEdit.AsInteger;

  iDataView.BackgroundTransparent        := DataViewBackGroundTransparentCheckBox.AsBoolean;
  iDataView.BackgroundColor              := DataViewBackgroundColorPicker.Color;
  iDataView.GridShow                     := DataViewGridShow.AsBoolean;
  iDataView.GridXAxisName                := DataViewGridXAxisNameComboBox.AsString;
  iDataView.GridYAxisName                := DataViewGridYAxisNameComboBox.AsString;

  iDataView.AxesControlEnabled           := DataViewAxesControlEnabledCheckBox.AsBoolean;
  iDataView.AxesControlAllowInSelectMode := DataViewAxesControlAllowInSelectModeCheckBox.AsBoolean;
  iDataView.AxesControlMouseStyle        := TiPlotAxesControlStyle(DataViewAxesControlMouseStyleComboBox.AsInteger);
  iDataView.AxesControlWheelStyle        := TiPlotAxesControlStyle(DataViewAxesControlWheelStyleComboBox.AsInteger);

  iDataView.GridLineColor                := DataViewGridLineColorPicker.Color;
  iDataView.GridLineShowLeft             := DataViewGridLineShowLeft.AsBoolean;
  iDataView.GridLineShowRight            := DataViewGridLineShowRight.AsBoolean;
  iDataView.GridLineShowTop              := DataViewGridLineShowTop.AsBoolean;
  iDataView.GridLineShowBottom           := DataViewGridLineShowBottom.AsBoolean;
  iDataView.GridLineShowXMajors          := DataViewGridLineShowXMajorsCheckBox.AsBoolean;
  iDataView.GridLineShowXMinors          := DataViewGridLineShowXMinorsCheckBox.AsBoolean;
  iDataView.GridLineShowYMajors          := DataViewGridLineShowYMajorsCheckBox.AsBoolean;
  iDataView.GridLineShowYMinors          := DataViewGridLineShowYMinorsCheckBox.AsBoolean;
  iDataView.GridLineMajorStyle           := TiPlotGridLineStyle(DataViewGridLineMajorStyleComboBox.AsInteger);
  iDataView.GridLineMinorStyle           := TiPlotGridLineStyle(DataViewGridLineMinorStyleComboBox.AsInteger);

  iDataView.GridLineXMajorCustom         := DataViewGridLineXMajorCustomCheckBox.AsBoolean;
  iDataView.GridLineXMajorColor          := DataViewGridLineXMajorColorColorPicker.Color;
  iDataView.GridLineXMajorWidth          := DataViewGridLineXMajorWidthEdit.AsInteger;
  iDataView.GridLineXMajorStyle          := TiPlotGridLineStyle(DataViewGridLineXMajorStyleComboBox.AsInteger);

  iDataView.GridLineXMinorCustom         := DataViewGridLineXMinorCustomCheckBox.AsBoolean;
  iDataView.GridLineXMinorColor          := DataViewGridLineXMinorColorColorPicker.Color;
  iDataView.GridLineXMinorWidth          := DataViewGridLineXMinorWidthEdit.AsInteger;
  iDataView.GridLineXMinorStyle          := TiPlotGridLineStyle(DataViewGridLineXMinorStyleComboBox.AsInteger);

  iDataView.GridLineYMajorCustom         := DataViewGridLineYMajorCustomCheckBox.AsBoolean;
  iDataView.GridLineYMajorColor          := DataViewGridLineYMajorColorColorPicker.Color;
  iDataView.GridLineYMajorWidth          := DataViewGridLineYMajorWidthEdit.AsInteger;
  iDataView.GridLineYMajorStyle          := TiPlotGridLineStyle(DataViewGridLineYMajorStyleComboBox.AsInteger);

  iDataView.GridLineYMinorCustom         := DataViewGridLineYMinorCustomCheckBox.AsBoolean;
  iDataView.GridLineYMinorColor          := DataViewGridLineYMinorColorColorPicker.Color;
  iDataView.GridLineYMinorWidth          := DataViewGridLineYMinorWidthEdit.AsInteger;
  iDataView.GridLineYMinorStyle          := TiPlotGridLineStyle(DataViewGridLineYMinorStyleComboBox.AsInteger);

  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelChange(Sender: TObject);
var
  iChannelObject : TiPlotChannelCustom;
begin
  if ChannelListBox.ItemIndex = -1 then exit;

  iChannelObject := ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom;

  iChannelObject.Name                        := ChannelNameEdit.AsString;
  iChannelObject.Visible                     := ChannelVisibleCheckBox.AsBoolean;
  iChannelObject.PopupEnabled                := ChannelPopupEnabledCheckBox.AsBoolean;
  iChannelObject.Layer                       := ChannelLayerEdit.AsInteger;

  iChannelObject.TitleText                   := ChannelTitleEdit.AsString;
  iChannelObject.VisibleInLegend             := ChannelVisibleInLegendCheckBox.AsBoolean;
  iChannelObject.UserCanMoveDataPoints       := ChannelUserCanMoveDataPointsCheckBox.AsBoolean;
  iChannelObject.UserCanMoveDataPointsStyle  := TiPlotChannelDataPointMoveStyle(ChannelUserCanMoveDataPointsStyleComboBox.AsInteger);
  iChannelObject.RingBufferSize              := ChannelRingBufferSizeEdit.AsInteger;
  iChannelObject.Color                       := ChannelColorPicker.Color;
  iChannelObject.XAxisName                   := ChannelXAxisNameComboBox.AsString;
  iChannelObject.YAxisName                   := ChannelYAxisNameComboBox.AsString;
  iChannelObject.XAxisTrackingEnabled        := ChannelXAxisTrackingEnabled.AsBoolean;
  iChannelObject.YAxisTrackingEnabled        := ChannelYAxisTrackingEnabled.AsBoolean;
  iChannelObject.DataStyle                   := TiPlotDataStyle(ChannelDataStyleComboBox.AsInteger);

  iChannelObject.TraceVisible                := ChannelTraceVisibleCheckBox.AsBoolean;
  iChannelObject.TraceLineStyle              := TiPlotLineStyle(ChannelTraceLineStyleComboBox.AsInteger);
  iChannelObject.TraceLineWidth              := ChannelTraceLineWidthEdit.AsInteger;

  iChannelObject.MarkersVisible              := ChannelMarkersVisible.AsBoolean;
  iChannelObject.MarkersAllowIndividual      := ChannelMarkersAllowIndividual.AsBoolean;
  iChannelObject.MarkersSize                 := ChannelMarkersSizeEdit.AsInteger;
  iChannelObject.MarkersStyle                := TiPlotMarkerStyle(ChannelMarkersStyleComboBox.AsInteger);
  iChannelObject.MarkersPenColor             := ChannelMarkersPenColorPicker.Color;
  iChannelObject.MarkersPenUseChannelColor   := ChannelMarkersPenUseChannelColorCheckBox.AsBoolean;
  iChannelObject.MarkersPenStyle             := TPenStyle(ChannelMarkersPenStyleComboBox.AsInteger);
  iChannelObject.MarkersPenWidth             := ChannelMarkersPenWidthEdit.AsInteger;
  iChannelObject.MarkersBrushColor           := ChannelMarkersBrushColorPicker.Color;
  iChannelObject.MarkersBrushUseChannelColor := ChannelMarkersBrushUseChannelColorCheckBox.AsBoolean;
  iChannelObject.MarkersBrushStyle           := TBrushStyle(ChannelMarkersBrushStyleComboBox.AsInteger);
  iChannelObject.MarkersTurnOffLimit         := ChannelMarkersTurnOffLimitEdit.AsInteger;

  iChannelObject.LogFileName                 := ChannelLogFileNameEdit.AsString;
  iChannelObject.LogBufferSize               := ChannelLogBufferSizeEdit.AsInteger;

  ChannelLogFileNamePicker.FileName          := iChannelObject.LogFileName;

  iChannelObject.MarkersFont.Assign(ChannelMarkersFontPicker.Font);

  if iChannelObject is TiPlotChannel then
    begin
      (iChannelObject as TiPlotChannel).FillEnabled             := ChannelFillEnabledCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).FillReference           := ChannelFillReferenceEdit.AsFloat;
      (iChannelObject as TiPlotChannel).FillStyle               := TBrushStyle(ChannelFillStyleComboBox.AsInteger);
      (iChannelObject as TiPlotChannel).FillColor               := ChannelFillColorPicker.Color;
      (iChannelObject as TiPlotChannel).FillUseChannelColor     := ChannelFillUseChannelColorCheckBox.AsBoolean;

      (iChannelObject as TiPlotChannel).BarEnabled              := ChannelBarEnabledCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).BarWidth                := ChannelBarWidthEdit.AsFloat;
      (iChannelObject as TiPlotChannel).BarReference            := ChannelBarReferenceEdit.AsFloat;
      (iChannelObject as TiPlotChannel).BarPenUseChannelColor   := ChannelBarPenUseChannelColorCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).BarPenStyle             := TPenStyle(ChannelBarPenStyleComboBox.AsInteger);
      (iChannelObject as TiPlotChannel).BarPenColor             := ChannelBarPenColorPicker.Color;
      (iChannelObject as TiPlotChannel).BarPenWidth             := ChannelBarPenWidthEdit.AsInteger;
      (iChannelObject as TiPlotChannel).BarBrushUseChannelColor := ChannelBarBrushUseChannelColorCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).BarBrushStyle           := TBrushStyle(ChannelBarBrushStyleComboBox.AsInteger);
      (iChannelObject as TiPlotChannel).BarBrushColor           := ChannelBarBrushColorPicker.Color;

      (iChannelObject as TiPlotChannel).HighLowStyle            :=  TiPlotHighLowStyle(ChannelHighLowStyleComboBox.AsInteger);
      (iChannelObject as TiPlotChannel).HighLowEnabled          :=  ChannelHighLowEnabledCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).HighLowBarColor         :=  ChannelHighLowBarColorPicker.Color;
      (iChannelObject as TiPlotChannel).HighLowBarWidth         :=  ChannelHighLowBarWidthEdit.AsFloat;
      (iChannelObject as TiPlotChannel).HighLowOpenShow         :=  ChannelHighLowOpenShowCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).HighLowOpenColor        :=  ChannelHighLowOpenColorPicker.Color;
      (iChannelObject as TiPlotChannel).HighLowOpenWidth        :=  ChannelHighLowOpenWidthEdit.AsFloat;
      (iChannelObject as TiPlotChannel).HighLowOpenHeight       :=  ChannelHighLowOpenHeightEdit.AsFloat;
      (iChannelObject as TiPlotChannel).HighLowCloseShow        :=  ChannelHighLowCloseShowCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).HighLowCloseColor       :=  ChannelHighLowCloseColorPicker.Color;
      (iChannelObject as TiPlotChannel).HighLowCloseWidth       :=  ChannelHighLowCloseWidthEdit.AsFloat;
      (iChannelObject as TiPlotChannel).HighLowCloseHeight      :=  ChannelHighLowCloseHeightEdit.AsFloat;
      (iChannelObject as TiPlotChannel).HighLowShadowColor      :=  ChannelHighLowShadowColorPicker.Color;
      (iChannelObject as TiPlotChannel).HighLowBullishColor     :=  ChannelHighLowBullishColorPicker.Color;
      (iChannelObject as TiPlotChannel).HighLowBearishColor     :=  ChannelHighLowBearishColorPicker.Color;

      (iChannelObject as TiPlotChannel).DigitalEnabled          := ChannelDigitalEnabledCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).DigitalReferenceHigh    := ChannelDigitalReferenceHighEdit.AsFloat;
      (iChannelObject as TiPlotChannel).DigitalReferenceLow     := ChannelDigitalReferenceLowEdit.AsFloat;
      (iChannelObject as TiPlotChannel).DigitalReferenceStyle   := TiPlotDigitalReferenceStyle(ChannelDigitalReferenceStyleComboBox.AsInteger);

      (iChannelObject as TiPlotChannel).FastDrawEnabled         := ChannelFastDrawCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).ClipToAxes              := ChannelClipToAxesCheckBox.AsBoolean;

      (iChannelObject as TiPlotChannel).InterpolationStyle      := TiPlotInterpolationStyle(ChannelInterpolationStyleComboBox.AsInteger);
    end;

  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.DataCursorChange(Sender: TObject);
var
  iDataCursor : TiPlotDataCursor;
begin
  if DataCursorListBox.ItemIndex = -1 then exit;

  iDataCursor := DataCursorListBox.Items.Objects[DataCursorListBox.ItemIndex] as TiPlotDataCursor;

  iDataCursor.Name                   := DataCursorNameEdit.AsString;
  iDataCursor.PopupEnabled           := DataCursorPopupEnabledCheckBox.AsBoolean;
  iDataCursor.SnapToDataPoint        := DataCursorSnapToDataPointCheckBox.AsBoolean;

  iDataCursor.Style                  := TiPlotDataCursorStyle(DataCursorStyleComboBox.AsInteger);
  iDataCursor.Color                  := DataCursorColorPicker.Color;
  iDataCursor.UseChannelColor        := DataCursorUseChannelColorCheckBox.AsBoolean;
  iDataCursor.HintPosition           := DataCursorHintPositionEdit.AsFloat;
  iDataCursor.HintShow               := DataCursorHintShowCheckBox.AsBoolean;
  iDataCursor.HintHideOnRelease      := DataCursorHintHideOnReleaseCheckBox.AsBoolean;
  iDataCursor.HintOrientationSide    := TiOrientationSide(DataCursorOrientationSideRadioGroup.AsInteger);
  iDataCursor.Pointer1Position       := DataCursorPointer1PositionEdit.AsFloat;
  iDataCursor.Pointer2Position       := DataCursorPointer2PositionEdit.AsFloat;
  iDataCursor.PointerPenWidth        := DataCursorPointerPenWidthEdit.AsInteger;

  iDataCursor.ChannelName            := DataCursorChannelNameComboBox.AsString;
  iDataCursor.ChannelAllowAll        := DataCursorChannelAllowAllCheckBox.AsBoolean;
  iDataCursor.ChannelShowAllInLegend := DataCursorChannelShowAllInLegendCheckBox.AsBoolean;

  iDataCursor.Font.Assign(DataCursorFontPicker.Font);

  UpdateDataCursorEdit;
  DataCursorListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.LimitChange(Sender: TObject);
var
  iLimit : TiPlotLimit;
begin
  if LimitListBox.ItemIndex = -1 then Exit;

  iLimit := LimitListBox.Items.Objects[LimitListBox.ItemIndex] as TiPlotLimit;

  iLimit.Name          := LimitNameEdit.AsString;
  iLimit.Visible       := LimitVisibleCheckBox.AsBoolean;
  iLimit.UserCanMove   := LimitUserCanMoveCheckBox.AsBoolean;
  iLimit.PopupEnabled  := LimitPopUpEnabledCheckBox.AsBoolean;
  iLimit.ClipToAxes    := LimitClipToAxesCheckBox.AsBoolean;
  iLimit.Layer         := LimitLayerEdit.AsInteger;

  iLimit.Style         := TiPlotLimitStyle(LimitStyleComboBox.AsInteger);
  iLimit.Line1Position := LimitLine1PositionEdit.AsFloat;
  iLimit.Line2Position := LimitLine2PositionEdit.AsFloat;

  iLimit.FillStyle     := TBrushStyle(LimitFillStyleCombobox.AsInteger);
  iLimit.LineStyle     := TPenStyle(LimitLineStyleComboBox.AsInteger);
  iLimit.LineWidth     := LimitLineWidthEdit.AsInteger;
  iLimit.Color         := LimitColorPicker.Color;

  iLimit.XAxisName     := LimitXAxisNameComboBox.AsString;
  iLimit.YAxisName     := LimitYAxisNameComboBox.AsString;

  UpdateLimitEdit;
  LimitListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.LabelChange(Sender: TObject);
var
  iLabel : TiPlotLabel;
begin
  if LabelListBox.ItemIndex = -1 then exit;

  iLabel := LabelListBox.Items.Objects[LabelListBox.ItemIndex] as TiPlotLabel;

  iLabel.Name           := LabelNameEdit.AsString;
  iLabel.Visible        := LabelVisibleCheckBox.AsBoolean;
  iLabel.Caption        := LabelCaptionMemo.AsString;
  iLabel.MarginLeft     := LabelMarginLeftEdit.AsFloat;
  iLabel.MarginTop      := LabelMarginTopEdit.AsFloat;
  iLabel.MarginRight    := LabelMarginRightEdit.AsFloat;
  iLabel.MarginBottom   := LabelMarginBottomEdit.AsFloat;
  iLabel.Alignment      := TiAlignmentHorizontal(LabelAlignmentComboBox.AsInteger);
  iLabel.ImageListIndex := LabelImageListIndexEdit.AsInteger;
  iLabel.ImageIndex     := LabelImageIndexEdit.AsInteger;

  iLabel.Font.Assign(LabelFontPicker.Font);

  UpdateLabelEdit;
  LabelListBox.Invalidate;

  if LabelListBox.ItemIndex = 0 then
    begin
      TitleVisibleCheckBox.AsBoolean := iLabel.Visible;
      TitleTextEdit.AsString         := iLabel.Caption;
      TitleMarginEdit.AsFloat        := iLabel.MarginBottom;
      TitleFontPicker.Font.Assign(iLabel.Font);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.TitleChange(Sender: TObject);
var
  iLabel : TiPlotLabel;
begin
  iLabel := LabelListBox.Items.Objects[0] as TiPlotLabel;

  iLabel.Visible      := TitleVisibleCheckBox.AsBoolean;
  iLabel.Caption      := TitleTextEdit.AsString;
  iLabel.MarginBottom := TitleMarginEdit.AsFloat;

  iLabel.Font.Assign(TitleFontPicker.Font);

  UpdateLabelEdit;
  LabelListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.DisableAllEditControlsStartingWith(Value: String);
var
  x : Integer;
begin
  for x := 0 to ComponentCount-1 do
    if Copy(UpperCase(Components[x].Name), 1, Length(Value)) = UpperCase(Value) then
      begin
        if      Components[x] is TPageControl then Continue
        else if Components[x] is TTabSheet    then Continue
        else if Components[x] is TLabel       then Continue;

        if      Components[x] is TiComponentEditorComboBox    then (Components[x] as TiComponentEditorComboBox   ).Disable
        else if Components[x] is TiComponentEditorRadioGroup  then (Components[x] as TiComponentEditorRadioGroup ).Disable
        else if Components[x] is TiComponentEditorListBox     then (Components[x] as TiComponentEditorListBox    ).Enabled := False
        else if Components[x] is TiComponentEditorEdit        then (Components[x] as TiComponentEditorEdit       ).Disable
        else if Components[x] is TiComponentEditorCheckBox    then (Components[x] as TiComponentEditorCheckBox   ).Disable
        else if Components[x] is TiComponentEditorColorPicker then (Components[x] as TiComponentEditorColorPicker).Disable
        else if Components[x] is TiComponentEditorFontPicker  then (Components[x] as TiComponentEditorFontPicker ).Disable
        else if Components[x] is TiUpDown                     then (Components[x] as TiUpDown                    ).Disable
        else if Components[x] is TControl                     then (Components[x] as TControl                    ).Enabled := False;
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.EnableAllEditControlsStartingWith(Value: String);
var
  x : Integer;
begin
  for x := 0 to ComponentCount-1 do
    if Copy(UpperCase(Components[x].Name), 1, Length(Value)) = UpperCase(Value) then
      begin
        if      Components[x] is TPageControl then Continue
        else if Components[x] is TTabSheet    then Continue
        else if Components[x] is TLabel       then Continue;

        if      Components[x] is TiComponentEditorComboBox    then (Components[x] as TiComponentEditorComboBox   ).Enable
        else if Components[x] is TiComponentEditorRadioGroup  then (Components[x] as TiComponentEditorRadioGroup ).Enable
        else if Components[x] is TiComponentEditorListBox     then (Components[x] as TiComponentEditorListBox    ).Enabled := True
        else if Components[x] is TiComponentEditorEdit        then (Components[x] as TiComponentEditorEdit       ).Enable
        else if Components[x] is TiComponentEditorCheckBox    then (Components[x] as TiComponentEditorCheckBox   ).Enable
        else if Components[x] is TiComponentEditorColorPicker then (Components[x] as TiComponentEditorColorPicker).Enable
        else if Components[x] is TiComponentEditorFontPicker  then (Components[x] as TiComponentEditorFontPicker ).Enable
        else if Components[x] is TiUpDown                     then (Components[x] as TiUpDown                    ).Enable
        else if Components[x] is TControl                     then (Components[x] as TControl                    ).Enabled := True;
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.GeneralChanged(Sender: TObject);
begin
  Master.BasicPropertyChanged;
  ControlLogFileNamePicker.FileName := ControlLogFileNameEdit.AsString;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelLogActivateButtonClick(Sender: TObject);
begin
  (ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom).LogActivate(False);
  UpdateChannelEdit;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelLogDeactivateButtonClick(Sender: TObject);
begin
  (ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom).LogDeactivate;
  UpdateChannelEdit;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ControlPropertiesOpenPickerChange(Sender: TObject);
begin                           
  (Master.Owner as TiPlotComponent).LoadPropertiesFromFile(ControlPropertiesOpenPicker.FileName);
  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ControlPropertiesSavePickerChange(Sender: TObject);
begin
  (Master.Owner as TiPlotComponent).SavePropertiesToFile(ControlPropertiesSavePicker.FileName);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ControlDataSavePickerChange(Sender: TObject);
begin
  (Master.Owner as TiPlotComponent).SaveDataToFile(ControlDataSavePicker.FileName);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ControlAnnotationSavePickerChange(Sender: TObject);
begin
  (Master.Owner as TiPlotComponent).SaveAnnotationsToFile(ControlAnnotationSavePicker.FileName);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ControlAnnotationOpenPickerChange(Sender: TObject);
begin
  (Master.Owner as TiPlotComponent).LoadAnnotationsFromFile(ControlAnnotationOpenPicker.FileName);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ControlDataOpenPickerChange(Sender: TObject);
begin
  (Master.Owner as TiPlotComponent).ClearAllData;
  (Master.Owner as TiPlotComponent).LoadDataFromFile(ControlDataOpenPicker.FileName);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelPropertiesSavePickerChange(Sender: TObject);
var
  ChannelObject : TiPlotChannelCustom;
begin
  ChannelObject := (ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom);
  ChannelObject.SavePropertiesToFile(ChannelPropertiesSavePicker.FileName);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelPropertiesOpenPickerChange(Sender: TObject);
var
  ChannelObject : TiPlotChannelCustom;
begin
  ChannelObject := (ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom);
  ChannelObject.LoadPropertiesFromFile(ChannelPropertiesOpenPicker.FileName);
  ChannelListBox.Invalidate;
end;                              
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelDataSavePickerChange(Sender: TObject);
var
  ChannelObject : TiPlotChannelCustom;
begin
  ChannelObject := (ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom);
  ChannelObject.SaveDataToFile(ChannelDataSavePicker.FileName);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelDataOpenPickerChange(Sender: TObject);
var
  ChannelObject : TiPlotChannelCustom;
begin
  ChannelObject := (ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom);
  ChannelObject.LoadDataFromFile(ChannelDataOpenPicker.FileName, True);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelLogFileNamePickerChange(Sender: TObject);
begin
  ChannelLogFileNameEdit.Text := ChannelLogFileNamePicker.FileName;
  ChannelChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ControlLogFileNamePickerChange(Sender: TObject);
begin
  ControlLogFileNameEdit.Text := ControlLogFileNamePicker.FileName;
  Master.BasicPropertyChanged;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ControlLogActivateButtonClick(Sender: TObject);
begin
  (Master.Owner as TiPlotComponent).LogActivate(False);
  Master.BasicPropertyChanged;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ControlLogDeactivateButtonClick(Sender: TObject);
begin
  (Master.Owner as TiPlotComponent).LogDeactivate;
  Master.BasicPropertyChanged;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.ChannelStatsRefreshButtonClick(Sender: TObject);
begin
  RefreshChannelStats;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.iPlotLayoutViewerChange(Sender: TObject);
begin
  UpdateAll;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiPlotEditorForm.WMActivate(var Message: TWMActivate);
begin
  inherited;
  if FormStyle = fsStayOnTop then UpdateAll;
end;
{$ENDIF}
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.SetFormTranslationMethod(Value: TFormTranslationMethod);
var
  x : Integer;
begin
  for x := 0 to ComponentCount -1 do
    if Components[x] is TiComponentEditorValueConverterPicker then (Components[x] as TiComponentEditorValueConverterPicker).TranslationMethod := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.iPlotLayoutViewerMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FRightClickObject := iPlotLayoutViewer.GetMouseOverBlock(X, Y);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.LayoutPopupMenuPopup(Sender: TObject);
begin
  XYAxesReverseMenuItem.Checked := Master.XYAxesReverse;
  DeleteMenuItem.Enabled  := False;
  VisibleMenuItem.Enabled := False;
  EditMenuItem.Enabled    := False;

  if Assigned(FRightClickObject) then
    begin
      if FRightClickObject is TiPlotAxis  then DeleteMenuItem.Enabled := True;
      if FRightClickObject is TiPlotTable then DeleteMenuItem.Enabled := True;
      if FRightClickObject is TiPlotLabel then
        begin
          if FRightClickObject <> Master.LabelManager.Items[0] then DeleteMenuItem.Enabled := True;
        end;

      if not (FRightClickObject is TiPlotDataView) then VisibleMenuItem.Enabled := True;
      VisibleMenuItem.Checked := FRightClickObject.Visible;
      EditMenuItem.Enabled    := True;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.AddXAxisMenuItemClick(Sender: TObject);
begin
  Master.AddXAxis;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.AddYAxisMenuItemClick(Sender: TObject);
begin
  Master.AddYAxis;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.AddLabelMenuItemClick(Sender: TObject);
begin
  Master.AddLabel;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.DeleteMenuItemClick(Sender: TObject);
begin
  FRightClickObject.Free;
  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.VisibleMenuItemClick(Sender: TObject);
begin
  FRightClickObject.Visible := not FRightClickObject.Visible;
  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.XYAxesReverseMenuItemClick(Sender: TObject);
begin
  Master.XYAxesReverse := not Master.XYAxesReverse;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.EditMenuItemClick(Sender: TObject);
begin
  if FRightClickObject is TiPlotXAxis then
    begin
      PageControl.ActivePage := XAxesTabSheet;
      XAxisListBox.ItemIndex := XAxisListBox.Items.IndexOfObject(FRightClickObject);
    end
  else if FRightClickObject is TiPlotYAxis then
    begin
      PageControl.ActivePage := YAxesTabSheet;
      YAxisListBox.ItemIndex := YAxisListBox.Items.IndexOfObject(FRightClickObject);
    end
  else if FRightClickObject is TiPlotLegend then
    begin
      PageControl.ActivePage  := LegendTabSheet;
      LegendListBox.ItemIndex := LegendListBox.Items.IndexOfObject(FRightClickObject);
    end
  else if FRightClickObject is TiPlotToolBar then
    begin
      PageControl.ActivePage   := ToolBarTabSheet;
      ToolBarListBox.ItemIndex := ToolBarListBox.Items.IndexOfObject(FRightClickObject);
    end
  else if FRightClickObject is TiPlotLabel then
    begin
      PageControl.ActivePage := LabelsTabSheet;
      LabelListBox.ItemIndex := LabelListBox.Items.IndexOfObject(FRightClickObject);
    end
  else if FRightClickObject is TiPlotDataView then
    begin
      PageControl.ActivePage    := DataViewTabSheet;
      DataViewListBox.ItemIndex := DataViewListBox.Items.IndexOfObject(FRightClickObject);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.XAxisCursorCopyDefaultButtonClick(Sender: TObject);
begin
  XAxisCursorFormatStyleComboBox.AsInteger         := XAxisLabelFormatStyleComboBox.AsInteger;
  XAxisCursorDateTimeFormatComboBox.AsString       := XAxisDateTimeFormatComboBox.AsString;
  XAxisCursorPrecisionStyleComboBox.AsInteger      := XAxisLabelPrecisionStyleComboBox.AsInteger;
  XAxisCursorPrecisionEdit.AsInteger               := XAxisLabelPrecisionEdit.AsInteger;
  XAxisCursorMinLengthEdit.AsFloat                 := XAxisLabelMinLengthEdit.AsFloat;
  XAxisCursorMinLengthAutoAdjustCheckBox.AsBoolean := XAxisLabelMinLengthAutoAdjustCheckBox.AsBoolean;
  XAxisChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.XAxisLegendCopyDefaultButtonClick(Sender: TObject);
begin
  XAxisLegendFormatStyleComboBox.AsInteger         := XAxisLabelFormatStyleComboBox.AsInteger;
  XAxisLegendDateTimeFormatComboBox.AsString       := XAxisDateTimeFormatComboBox.AsString;
  XAxisLegendPrecisionStyleComboBox.AsInteger      := XAxisLabelPrecisionStyleComboBox.AsInteger;
  XAxisLegendPrecisionEdit.AsInteger               := XAxisLabelPrecisionEdit.AsInteger;
  XAxisLegendMinLengthEdit.AsFloat                 := XAxisLabelMinLengthEdit.AsFloat;
  XAxisLegendMinLengthAutoAdjustCheckBox.AsBoolean := XAxisLabelMinLengthAutoAdjustCheckBox.AsBoolean;
  XAxisChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.YAxisCursorCopyDefaultButtonClick(Sender: TObject);
begin
  YAxisCursorFormatStyleComboBox.AsInteger         := YAxisLabelFormatStyleComboBox.AsInteger;
  YAxisCursorDateTimeFormatComboBox.AsString       := YAxisDateTimeFormatComboBox.AsString;
  YAxisCursorPrecisionStyleComboBox.AsInteger      := YAxisLabelPrecisionStyleComboBox.AsInteger;
  YAxisCursorPrecisionEdit.AsInteger               := YAxisLabelPrecisionEdit.AsInteger;
  YAxisCursorMinLengthEdit.AsFloat                 := YAxisLabelMinLengthEdit.AsFloat;
  YAxisCursorMinLengthAutoAdjustCheckBox.AsBoolean := YAxisLabelMinLengthAutoAdjustCheckBox.AsBoolean;
  YAxisChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotEditorForm.YAxisLegendCopyDefaultButtonClick(Sender: TObject);
begin
  YAxisLegendFormatStyleComboBox.AsInteger         := YAxisLabelFormatStyleComboBox.AsInteger;
  YAxisLegendDateTimeFormatComboBox.AsString       := YAxisDateTimeFormatComboBox.AsString;
  YAxisLegendPrecisionStyleComboBox.AsInteger      := YAxisLabelPrecisionStyleComboBox.AsInteger;
  YAxisLegendPrecisionEdit.AsInteger               := YAxisLabelPrecisionEdit.AsInteger;
  YAxisLegendMinLengthEdit.AsFloat                 := YAxisLabelMinLengthEdit.AsFloat;
  YAxisLegendMinLengthAutoAdjustCheckBox.AsBoolean := YAxisLabelMinLengthAutoAdjustCheckBox.AsBoolean;
  YAxisChange(Self);
end;
//****************************************************************************************************************************************************
end.
