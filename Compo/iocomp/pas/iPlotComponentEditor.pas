{*******************************************************}
{                                                       }
{       TiPlotXYComponentEditor                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotComponentEditor;{$endif}
{$ifdef iCLX}unit QiPlotComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  Printers,  iTypes,  iClasses,  iPlotMasterManager,  iPlotObjects,  iPlotAnnotation, iOPCDLLLoader,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QPrinters, QiTypes, QiClasses, QiPlotMasterManager, QiPlotObjects, QiPlotAnnotation, QiOPCDLLLoader,{$ENDIF}

  {$IFDEF iVCL} StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,{$ENDIF}
  {$IFDEF iCLX}QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents,{$ENDIF}

  {$IFDEF iVCL} iAboutPanel,  Menus,  iComponent,  iVCLComponent,  iPlotLayoutViewer,  iComponentEditorImageEditorPanel,  iCheckBox,  iCustomComponent,  iRadioGroup,  iOPCBrowserPanel;{$ENDIF}
  {$IFDEF iCLX}QiAboutPanel, QMenus, QiComponent, QiCLXComponent, QiPlotLayoutViewer, QiComponentEditorImageEditorPanel, QiCheckBox, QiCustomComponent, QiRadioGroup, QiOPCBrowserPanel;{$ENDIF}

type
  TiPlotComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    ControlTabSheet: TTabSheet;
    iPlotLayoutViewer: TiPlotLayoutViewer;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
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
    XAxisPageControl: TiComponentEditorPageControl;
    XAxisLabelsTabSheet: TTabSheet;
    XAxisGeneralTabSheet: TTabSheet;
    Label12: TLabel;
    Label19: TLabel;
    XAxisSpanEdit: TiComponentEditorEdit;
    XAxisMinEdit: TiComponentEditorEdit;
    XAxisTitleTabSheet: TTabSheet;
    Label23: TLabel;
    XAxisTitleMarginEdit: TiComponentEditorEdit;
    XAxisTitleFontPicker: TiComponentEditorFontPicker;
    ToolBarTabSheet: TTabSheet;
    LegendTabSheet: TTabSheet;
    DataViewTabSheet: TTabSheet;
    XAxisScaleTabSheet: TTabSheet;
    YAxisPageControl: TiComponentEditorPageControl;
    YAxisGeneralTabSheet: TTabSheet;
    YAxisTitleTabSheet: TTabSheet;
    Label22: TLabel;
    Label27: TLabel;
    YAxisTitleMarginEdit: TiComponentEditorEdit;
    YAxisTitleTextEdit: TiComponentEditorEdit;
    YAxisTitleFontPicker: TiComponentEditorFontPicker;
    YAxisTitleShowCheckBox: TiComponentEditorCheckBox;
    YAxisLabelsTabSheet: TTabSheet;
    YAxisScaleTabSheet: TTabSheet;
    Label44: TLabel;
    XAxisTitleTextEdit: TiComponentEditorEdit;
    Label87: TLabel;
    XAxisNameEdit: TiComponentEditorEdit;
    Label2: TLabel;
    Label16: TLabel;
    YAxisSpanEdit: TiComponentEditorEdit;
    YAxisMinEdit: TiComponentEditorEdit;
    Label41: TLabel;
    YAxisNameEdit: TiComponentEditorEdit;
    ChannelPageControl: TiComponentEditorPageControl;
    ChannelGeneralTabSheet: TTabSheet;
    XaxisTrackingTabSheet: TTabSheet;
    XAxisTrackingEnabledCheckBox: TiComponentEditorCheckBox;
    YAxisTrackingTabSheet: TTabSheet;
    YAxisTrackingEnabledCheckBox: TiComponentEditorCheckBox;
    XAxisTitleShowCheckBox: TiComponentEditorCheckBox;
    XAxisTrackingStyleComboBox: TiComponentEditorComboBox;
    Label43: TLabel;
    YAxisTrackingStyleComboBox: TiComponentEditorComboBox;
    Label47: TLabel;
    Label48: TLabel;
    XAxisTrackingScrollCompressMaxEdit: TiComponentEditorEdit;
    Label49: TLabel;
    YAxisTrackingScrollCompressMaxEdit: TiComponentEditorEdit;
    Label50: TLabel;
    XAxisTrackingAlignFirstStyleComboBox: TiComponentEditorComboBox;
    Label51: TLabel;
    YAxisTrackingAlignFirstStyleComboBox: TiComponentEditorComboBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    YAxisScaleLinesColorPicker: TiComponentEditorColorPicker;
    YAxisMajorLengthEdit: TiComponentEditorEdit;
    YAxisMajorLengthUpDown: TiUpDown;
    YAxisMinorCountEdit: TiComponentEditorEdit;
    YAxisMinorLengthEdit: TiComponentEditorEdit;
    YAxisMinorCountUpDown: TiUpDown;
    YAxisMinorLengthUpDown: TiUpDown;
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
    ChannelMarkersTabSheet: TTabSheet;
    ToolBarHiddenGroupBox: TGroupBox;
    Label64: TLabel;
    ToolBarListBox: TiComponentEditorListBox;
    ToolBarNameEdit: TiComponentEditorEdit;
    ToolBarShowGroupBox: TGroupBox;
    ToolBarShowEditButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowCopyButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowSaveButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowPrintButtonCheckBox: TiComponentEditorCheckBox;
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
    ToolBarShowResumeButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowPauseButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowAxesModeButtonsCheckBox: TiComponentEditorCheckBox;
    ToolBarShowZoomInOutButtonsCheckBox: TiComponentEditorCheckBox;
    ToolBarShowZoomBoxButtonCheckBox: TiComponentEditorCheckBox;
    ToolBarShowCursorButtonCheckBox: TiComponentEditorCheckBox;
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
    ChannelLogFileNameEdit: TiComponentEditorEdit;
    Label88: TLabel;
    ChannelLogBufferSizeEdit: TiComponentEditorEdit;
    ChannelLogBufferSizeUpDown: TiUpDown;
    ControlPageControl: TiComponentEditorPageControl;
    ControlGeneralTabSheet: TTabSheet;
    ControlTitleTabSheet: TTabSheet;
    ControlHintsTabSheet: TTabSheet;
    Label78: TLabel;
    Label79: TLabel;
    HintsShowCheckBox: TiComponentEditorCheckBox;
    HintsPauseEdit: TiComponentEditorEdit;
    HintsPauseUpDown: TiUpDown;
    HintsHidePauseEdit: TiComponentEditorEdit;
    HintsHidePauseUpDown: TiUpDown;
    Label76: TLabel;
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
    UpdateFrameRateEdit: TiComponentEditorEdit;
    UpdateFrameRateUpDown: TiUpDown;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    UserCanEditObjectsCheckBox: TiComponentEditorCheckBox;
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
    ControlFileIOTabSheet: TTabSheet;
    ControlFileIOPropertiesGroupBox: TGroupBox;
    ControlPropertiesOpenPicker: TiComponentEditorOpenPicker;
    ControlPropertiesSavePicker: TiComponentEditorSavePicker;
    Label89: TLabel;
    ChannelPropertiesGroupBox: TGroupBox;
    ChannelPropertiesOpenPicker: TiComponentEditorOpenPicker;
    ChannelPropertiesSavePicker: TiComponentEditorSavePicker;
    ChannelLogFileNamePicker: TiComponentEditorOpenPicker;
    ControlFileIOLogGroupBox: TGroupBox;
    Label90: TLabel;
    Label91: TLabel;
    ControlLogFileNameEdit: TiComponentEditorEdit;
    ControlLogBufferSizeEdit: TiComponentEditorEdit;
    ControlLogBufferSizeUpDown: TiUpDown;
    ControlLogFileNamePicker: TiComponentEditorOpenPicker;
    XAxisMinTimePicker: TiComponentEditorValueConverterPicker;
    XAxisSpanTimePicker: TiComponentEditorValueConverterPicker;
    YAxisMinTimePicker: TiComponentEditorValueConverterPicker;
    YAxisSpanTimePicker: TiComponentEditorValueConverterPicker;
    DataCursorsTabSheet: TTabSheet;
    DataCursorListBox: TiComponentEditorListBox;
    iDataCursorAddButton: TButton;
    DataCursorRemoveButton: TButton;
    XAxisCursorTabSheet: TTabSheet;
    Label20: TLabel;
    Label13: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label54: TLabel;
    XAxisInnerMarginUpDown: TiUpDown;
    XAxisOuterMarginUpDown: TiUpDown;
    XAxisInnerMarginEdit: TiComponentEditorEdit;
    XAxisOuterMarginEdit: TiComponentEditorEdit;
    XAxisStartPercentEdit: TiComponentEditorEdit;
    XAxisStopPercentEdit: TiComponentEditorEdit;
    XAxisStackingEndsMarginEdit: TiComponentEditorEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label40: TLabel;
    Label55: TLabel;
    YAxisInnerMarginUpDown: TiUpDown;
    YAxisOuterMarginUpDown: TiUpDown;
    YAxisInnerMarginEdit: TiComponentEditorEdit;
    YAxisOuterMarginEdit: TiComponentEditorEdit;
    YAxisStartPercentEdit: TiComponentEditorEdit;
    YAxisStopPercentEdit: TiComponentEditorEdit;
    YAxisStackingEndsMarginEdit: TiComponentEditorEdit;
    YAxisCursorTabSheet: TTabSheet;
    Label104: TLabel;
    XAxisCursorScalerEdit: TiComponentEditorEdit;
    Label106: TLabel;
    YAxisCursorScalerEdit: TiComponentEditorEdit;
    LimitTabSheet: TTabSheet;
    LimitListBox: TiComponentEditorListBox;
    iLimitAddButton: TButton;
    LimitRemoveButton: TButton;
    LimitPageControl: TiComponentEditorPageControl;
    LimitGeneralTabSheet: TTabSheet;
    Label127: TLabel;
    ToolBarZoomInOutFactorEdit: TiComponentEditorEdit;
    TranslationTabSheet: TTabSheet;
    TranslationListBox: TiComponentEditorListBox;
    iTranslationAddButton: TiComponentEditorButton;
    TranslationRemoveButton: TiComponentEditorButton;
    TranslationOriginalStringEdit: TiComponentEditorEdit;
    TranslationReplacementStringEdit: TiComponentEditorEdit;
    Label128: TLabel;
    Label129: TLabel;
    TranslationClearAllButton: TiComponentEditorButton;
    TranslationSavePicker: TiComponentEditorSavePicker;
    iTranslationOpenPicker: TiComponentEditorOpenPicker;
    XAxisScrollTabSheet: TTabSheet;
    XAxisScrollMinMaxEnabledCheckBox: TiComponentEditorCheckBox;
    Label130: TLabel;
    XAxisScrollMinEdit: TiComponentEditorEdit;
    Label131: TLabel;
    XAxisScrollMaxEdit: TiComponentEditorEdit;
    YAxisScrollTabSheet: TTabSheet;
    YAxisScrollMinMaxEnabledCheckBox: TiComponentEditorCheckBox;
    Label132: TLabel;
    YAxisScrollMinEdit: TiComponentEditorEdit;
    Label133: TLabel;
    YAxisScrollMaxEdit: TiComponentEditorEdit;
    LabelTabSheet: TTabSheet;
    LabelListBox: TiComponentEditorListBox;
    iLabelAddButton: TButton;
    LabelRemoveButton: TButton;
    LabelsPageControl: TiComponentEditorPageControl;
    LabelsTabSheet: TTabSheet;
    Label135: TLabel;
    LabelNameEdit: TiComponentEditorEdit;
    LabelVisibleCheckBox: TiComponentEditorCheckBox;
    LabelFontPicker: TiComponentEditorFontPicker;
    LabelMarginGroupBox: TGroupBox;
    LabelMarginLeftEdit: TiComponentEditorEdit;
    LabelMarginTopEdit: TiComponentEditorEdit;
    LabelMarginBottomEdit: TiComponentEditorEdit;
    LabelMarginRightEdit: TiComponentEditorEdit;
    LabelCaptionMemo: TiComponentEditorEdit;
    Label134: TLabel;
    Label136: TLabel;
    LabelAlignmentComboBox: TiComponentEditorComboBox;
    Label137: TLabel;
    XAxisScaleTypeRadioGroup: TiComponentEditorRadioGroup;
    Label94: TLabel;
    XAxisDesiredIncrementEdit: TiComponentEditorEdit;
    XAxisDesiredIncrementTimePicker: TiComponentEditorValueConverterPicker;
    Label138: TLabel;
    XAxisDesiredStartEdit: TiComponentEditorEdit;
    XAxisDesiredStartTimePicker: TiComponentEditorValueConverterPicker;
    Label95: TLabel;
    YAxisScaleTypeRadioGroup: TiComponentEditorRadioGroup;
    YAxisDesiredIncrementEdit: TiComponentEditorEdit;
    YAxisDesiredIncrementTimePicker: TiComponentEditorValueConverterPicker;
    Label139: TLabel;
    YAxisDesiredStartEdit: TiComponentEditorEdit;
    YAxisDesiredStartTimePicker: TiComponentEditorValueConverterPicker;
    iAboutPanel1: TiAboutPanel;
    HintsFontPicker: TiComponentEditorFontPicker;
    AnnotationDefaultsTabSheet: TTabSheet;
    AnnotationDefaultFontPicker: TiComponentEditorFontPicker;
    AnnotationDefaultsBrushGroupBox: TGroupBox;
    Label80: TLabel;
    AnnotationDefaultBrushColorPicker: TiComponentEditorColorPicker;
    Label141: TLabel;
    AnnotationDefaultBrushStyleComboBox: TiComponentEditorComboBox;
    AnnotationDefaultsPenGroupBox: TGroupBox;
    Label142: TLabel;
    Label140: TLabel;
    AnnotationDefaultPenColorPicker: TiComponentEditorColorPicker;
    AnnotationDefaultPenStyleComboBox: TiComponentEditorComboBox;
    Label143: TLabel;
    iUpDown1: TiUpDown;
    AnnotationDefaultPenWidthEdit: TiComponentEditorEdit;
    ChannelHighLowTabSheet: TTabSheet;
    ToolBarShowSelectButtonCheckBox: TiComponentEditorCheckBox;
    ChannelOPCTabSheet: TTabSheet;
    UserCanAddRemoveCheckBox: TiComponentEditorCheckBox;
    ChannelBarTabSheet: TTabSheet;
    Label149: TLabel;
    ChannelBarEnabledCheckBox: TiComponentEditorCheckBox;
    ChannelBarReferenceEdit: TiComponentEditorEdit;
    ChannelBarPenGroupBox: TGroupBox;
    Label150: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    ChannelBarPenWidthUpDown: TiUpDown;
    ChannelBarPenStyleComboBox: TiComponentEditorComboBox;
    ChannelBarPenColorPicker: TiComponentEditorColorPicker;
    ChannelBarPenWidthEdit: TiComponentEditorEdit;
    ChannelBarPenUseChannelColorCheckBox: TiComponentEditorCheckBox;
    ChannelBarBrushGroupBox: TGroupBox;
    Label153: TLabel;
    Label154: TLabel;
    ChannelBarBrushStyleComboBox: TiComponentEditorComboBox;
    ChannelBarBrushColorPicker: TiComponentEditorColorPicker;
    ChannelBarBrushUseChannelColorCheckBox: TiComponentEditorCheckBox;
    Label155: TLabel;
    ChannelBarWidthEdit: TiComponentEditorEdit;
    iComponentEditorValueConverterPicker1: TiComponentEditorValueConverterPicker;
    DataViewPageControl: TiComponentEditorPageControl;
    DataViewGeneralTabSheet: TTabSheet;
    DataViewEnabledCheckBox: TiComponentEditorCheckBox;
    DataViewPopupEnabledCheckBox: TiComponentEditorCheckBox;
    DataViewBackgroundGroupBox: TGroupBox;
    Label66: TLabel;
    DataViewBackGroundTransparentCheckBox: TiComponentEditorCheckBox;
    DataViewBackgroundColorPicker: TiComponentEditorColorPicker;
    DataViewGridGroupBox: TiComponentEditorGroupBox;
    Label67: TLabel;
    Label68: TLabel;
    DataViewGridXAxisNameComboBox: TiComponentEditorComboBox;
    DataViewGridYAxisNameComboBox: TiComponentEditorComboBox;
    DataViewGridShow: TiComponentEditorCheckBox;
    DataViewGridLinesTabSheet: TTabSheet;
    DataViewHiddenTabSheet: TTabSheet;
    DataViewHiddenGroupBox: TGroupBox;
    Label167: TLabel;
    DataViewListBox: TiComponentEditorListBox;
    DataViewNameEdit: TiComponentEditorEdit;
    ControlImagesTabSheet: TTabSheet;
    iComponentEditorPageControl1: TiComponentEditorPageControl;
    ControlImagesCustom0TabSheet: TTabSheet;
    ControlImagesCustom1TabSheet: TTabSheet;
    ControlImagesCustom2TabSheet: TTabSheet;
    ImageEditorPanel0: TiComponentEditorImageEditorPanel;
    ImageEditorPanel1: TiComponentEditorImageEditorPanel;
    ImageEditorPanel2: TiComponentEditorImageEditorPanel;
    Label169: TLabel;
    EditorFormStyleComboBox: TiComponentEditorComboBox;
    Label170: TLabel;
    CopyToClipBoardFormatComboBox: TiComponentEditorComboBox;
    XAxisCartesianTabSheet: TTabSheet;
    YAxisCartesianTabSheet: TTabSheet;
    Label171: TLabel;
    XAxisCartesianStyleComboBox: TiComponentEditorComboBox;
    Label172: TLabel;
    XAxisCartesianChildRefAxisNameComboBox: TiComponentEditorComboBox;
    Label173: TLabel;
    XAxisCartesianChildRefValueEdit: TiComponentEditorEdit;
    XAxisCartesianChildRefValuePicker: TiComponentEditorValueConverterPicker;
    Label174: TLabel;
    YAxisCartesianStyleComboBox: TiComponentEditorComboBox;
    Label175: TLabel;
    YAxisCartesianChildRefAxisNameComboBox: TiComponentEditorComboBox;
    Label176: TLabel;
    YAxisCartesianChildRefValueEdit: TiComponentEditorEdit;
    YAxisCartesianChildRefValuePicker: TiComponentEditorValueConverterPicker;
    Label178: TLabel;
    PrintDocumentNameEdit: TiComponentEditorEdit;
    LegendPageControl: TiComponentEditorPageControl;
    General: TTabSheet;
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
    LegendColumnsTabSheet: TTabSheet;
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
    LegendCaptionGroupBox: TGroupBox;
    Label28: TLabel;
    Label179: TLabel;
    Label180: TLabel;
    Label181: TLabel;
    Label182: TLabel;
    Label183: TLabel;
    Label184: TLabel;
    Label185: TLabel;
    LegendCaptionColumnTitleEdit: TiComponentEditorEdit;
    LegendCaptionColumnXAxisTitleEdit: TiComponentEditorEdit;
    LegendCaptionColumnYAxisTitleEdit: TiComponentEditorEdit;
    LegendCaptionColumnXValueEdit: TiComponentEditorEdit;
    LegendCaptionColumnYValueEdit: TiComponentEditorEdit;
    LegendCaptionColumnYMaxEdit: TiComponentEditorEdit;
    LegendCaptionColumnYMinEdit: TiComponentEditorEdit;
    LegendCaptionColumnYMeanEdit: TiComponentEditorEdit;
    LegendHiddenTabSheet: TTabSheet;
    LegendHiddenGroupBox: TGroupBox;
    Label186: TLabel;
    LegendListBox: TiComponentEditorListBox;
    LegendNameEdit: TiComponentEditorEdit;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label118: TLabel;
    Label117: TLabel;
    Label122: TLabel;
    LimitLineWidthUpDown: TiUpDown;
    Label123: TLabel;
    LimitNameEdit: TiComponentEditorEdit;
    LimitXAxisNameComboBox: TiComponentEditorComboBox;
    LimitYAxisNameComboBox: TiComponentEditorComboBox;
    LimitStyleComboBox: TiComponentEditorComboBox;
    LimitLine1PositionEdit: TiComponentEditorEdit;
    LimitLine2PositionEdit: TiComponentEditorEdit;
    LimitColorPicker: TiComponentEditorColorPicker;
    LimitLineStyleComboBox: TiComponentEditorComboBox;
    LimitLineWidthEdit: TiComponentEditorEdit;
    LimitFillStyleCombobox: TiComponentEditorComboBox;
    LimitVisibleCheckBox: TiComponentEditorCheckBox;
    LimitUserCanMoveCheckBox: TiComponentEditorCheckBox;
    LimitPopUpEnabledCheckBox: TiComponentEditorCheckBox;
    Label188: TLabel;
    LimitLayerUpDown: TiUpDown;
    LimitLayerEdit: TiComponentEditorEdit;
    Label189: TLabel;
    iUpDown3: TiUpDown;
    XAxisLayerEdit: TiComponentEditorEdit;
    Label190: TLabel;
    iUpDown4: TiUpDown;
    YAxisLayerEdit: TiComponentEditorEdit;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label65: TLabel;
    DataViewLayerUpDown: TiUpDown;
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
    DataViewGridLineXMajorCustomCheckBox: TiComponentEditorCheckBox;
    DataViewGridLineShowXMajorsCheckBox: TiComponentEditorCheckBox;
    DataViewXMajorsCustomGroupBox: TiComponentEditorGroupBox;
    Label156: TLabel;
    Label157: TLabel;
    DataViewGridLineXMajorWidthUpDown: TiUpDown;
    Label158: TLabel;
    DataViewGridLineXMajorColorColorPicker: TiComponentEditorColorPicker;
    DataViewGridLineXMajorWidthEdit: TiComponentEditorEdit;
    DataViewGridLineXMajorStyleComboBox: TiComponentEditorComboBox;
    TabSheet6: TTabSheet;
    DataViewGridLineXMinorCustomCheckBox: TiComponentEditorCheckBox;
    DataViewGridLineShowXMinorsCheckBox: TiComponentEditorCheckBox;
    DataViewXMinorsCustomGroupBox: TiComponentEditorGroupBox;
    Label159: TLabel;
    Label160: TLabel;
    DataViewGridLineXMinorWidthUpDown: TiUpDown;
    Label161: TLabel;
    DataViewGridLineXMinorColorColorPicker: TiComponentEditorColorPicker;
    DataViewGridLineXMinorWidthEdit: TiComponentEditorEdit;
    DataViewGridLineXMinorStyleComboBox: TiComponentEditorComboBox;
    TabSheet7: TTabSheet;
    DataViewGridLineYMajorCustomCheckBox: TiComponentEditorCheckBox;
    DataViewGridLineShowYMajorsCheckBox: TiComponentEditorCheckBox;
    DataViewYMajorsCustomGroupBox: TiComponentEditorGroupBox;
    Label162: TLabel;
    Label163: TLabel;
    DataViewGridLineYMajorWidthUpDown: TiUpDown;
    Label164: TLabel;
    DataViewGridLineYMajorColorColorPicker: TiComponentEditorColorPicker;
    DataViewGridLineYMajorWidthEdit: TiComponentEditorEdit;
    DataViewGridLineYMajorStyleComboBox: TiComponentEditorComboBox;
    TabSheet8: TTabSheet;
    DataViewGridLineYMinorCustomCheckBox: TiComponentEditorCheckBox;
    DataViewGridLineShowYMinorsCheckBox: TiComponentEditorCheckBox;
    DataViewYMinorsCustomGroupBox: TiComponentEditorGroupBox;
    Label165: TLabel;
    Label166: TLabel;
    DataViewGridLineYMinorWidthUpDown: TiUpDown;
    Label191: TLabel;
    DataViewGridLineYMinorColorColorPicker: TiComponentEditorColorPicker;
    DataViewGridLineYMinorWidthEdit: TiComponentEditorEdit;
    DataViewGridLineYMinorStyleComboBox: TiComponentEditorComboBox;
    DataViewLayerEdit: TiComponentEditorEdit;
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
    DataCursorPageControl: TiComponentEditorPageControl;
    DataCursorGeneralTabSheet: TTabSheet;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    DataCursorStyleComboBox: TiComponentEditorComboBox;
    DataCursorFontPicker: TiComponentEditorFontPicker;
    DataCursorColorPicker: TiComponentEditorColorPicker;
    DataCursorUseChannelColorCheckBox: TiComponentEditorCheckBox;
    DataCursorNameEdit: TiComponentEditorEdit;
    TabSheet9: TTabSheet;
    Label96: TLabel;
    DataCursorChannelNameComboBox: TiComponentEditorComboBox;
    DataCursorChannelAllowAllCheckBox: TiComponentEditorCheckBox;
    DataCursorChannelShowAllInLegendCheckBox: TiComponentEditorCheckBox;
    DataCursorHintTabSheet: TTabSheet;
    Label100: TLabel;
    DataCursorHintShowCheckBox: TiComponentEditorCheckBox;
    DataCursorHintHideOnReleaseCheckBox: TiComponentEditorCheckBox;
    DataCursorOrientationSideRadioGroup: TiComponentEditorRadioGroup;
    DataCursorHintPositionEdit: TiComponentEditorEdit;
    TabSheet2: TTabSheet;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    DataCursorMenuItemVisibleValueXYCheckBox: TiComponentEditorCheckBox;
    DataCursorMenuItemVisibleValueXCheckBox: TiComponentEditorCheckBox;
    DataCursorMenuItemVisibleValueYCheckBox: TiComponentEditorCheckBox;
    DataCursorMenuItemVisibleDeltaXCheckBox: TiComponentEditorCheckBox;
    DataCursorMenuItemVisibleDeltaYCheckBox: TiComponentEditorCheckBox;
    DataCursorMenuItemVisibleInverseDeltaXCheckBox: TiComponentEditorCheckBox;
    DataCursorMenuItemCaptionValueXYCheckBox: TiComponentEditorEdit;
    DataCursorMenuItemCaptionValueXCheckBox: TiComponentEditorEdit;
    DataCursorMenuItemCaptionValueYCheckBox: TiComponentEditorEdit;
    DataCursorMenuItemCaptionDeltaXCheckBox: TiComponentEditorEdit;
    DataCursorMenuItemCaptionDeltaYCheckBox: TiComponentEditorEdit;
    DataCursorMenuItemCaptionInverseDeltaYCheckBox: TiComponentEditorEdit;
    LegendWrapTabSheet: TTabSheet;
    LegendWrapColGroupBox: TGroupBox;
    Label192: TLabel;
    LegendWrapDesiredColCountUpDown: TiUpDown;
    LegendWrapColAutoCountGroupBox: TGroupBox;
    Label193: TLabel;
    LegendWrapAutoMaxColCountUpDown: TiUpDown;
    LegendWrapColAutoCountEnabledCheckBox: TiComponentEditorCheckBox;
    LegendWrapColAutoCountMaxEdit: TiComponentEditorEdit;
    LegendWrapColDesiredCountEdit: TiComponentEditorEdit;
    LegendWrapColSpacingCountGroupBox: TGroupBox;
    Label194: TLabel;
    LegendWrapColSpacingAutoCheckBox: TiComponentEditorCheckBox;
    LegendWrapColSpacingMinEdit: TiComponentEditorEdit;
    LegendWrapRowGroupBox: TGroupBox;
    Label195: TLabel;
    LegendWrapDesiredRowCountUpDown: TiUpDown;
    LegendWrapRowAutoCountGroupBox: TGroupBox;
    Label196: TLabel;
    LegendWrapAutoMaxRowCountUpDown: TiUpDown;
    LegendWrapRowAutoCountEnabledCheckBox: TiComponentEditorCheckBox;
    LegendWrapRowAutoCountMaxEdit: TiComponentEditorEdit;
    LegendWrapRowDesiredCountEdit: TiComponentEditorEdit;
    LegendWrapRowSpacingCountGroupBox: TGroupBox;
    Label197: TLabel;
    LegendWrapRowSpacingAutoCheckBox: TiComponentEditorCheckBox;
    LegendWrapRowSpacingMinEdit: TiComponentEditorEdit;
    YAxisLabelsPageControl: TiComponentEditorPageControl;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    Label205: TLabel;
    Label206: TLabel;
    Label207: TLabel;
    YAxisCursorPrecisionUpDown: TiUpDown;
    Label208: TLabel;
    Label209: TLabel;
    Bevel5: TBevel;
    YAxisCursorPrecisionEdit: TiComponentEditorEdit;
    YAxisCursorDateTimeFormatComboBox: TiComponentEditorComboBox;
    YAxisCursorFormatStyleComboBox: TiComponentEditorComboBox;
    YAxisCursorPrecisionStyleComboBox: TiComponentEditorComboBox;
    YAxisCursorMinLengthEdit: TiComponentEditorEdit;
    YAxisCursorMinLengthAutoAdjustCheckBox: TiComponentEditorCheckBox;
    YAxisCursorUseDefaultFormatCheckBox: TiComponentEditorCheckBox;
    YAxisCursorCopyDefaultButton: TiComponentEditorButton;
    TabSheet16: TTabSheet;
    Label210: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    YAxisLegendPrecisionUpDown: TiUpDown;
    Label213: TLabel;
    Label214: TLabel;
    Bevel4: TBevel;
    YAxisLegendPrecisionEdit: TiComponentEditorEdit;
    YAxisLegendDateTimeFormatComboBox: TiComponentEditorComboBox;
    YAxisLegendFormatStyleComboBox: TiComponentEditorComboBox;
    YAxisLegendPrecisionStyleComboBox: TiComponentEditorComboBox;
    YAxisLegendMinLengthEdit: TiComponentEditorEdit;
    YAxisLegendMinLengthAutoAdjustCheckBox: TiComponentEditorCheckBox;
    YAxisLegendUseDefaultFormatCheckBox: TiComponentEditorCheckBox;
    YAxisLegendCopyDefaultButton: TiComponentEditorButton;
    XAxisLabelsPageControl: TiComponentEditorPageControl;
    TabSheet11: TTabSheet;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    XAxisLabelPrecisionUpDown: TiUpDown;
    Label15: TLabel;
    Label101: TLabel;
    Bevel1: TBevel;
    XAxisLabelPrecisionEdit: TiComponentEditorEdit;
    XAxisDateTimeFormatComboBox: TiComponentEditorComboBox;
    XAxisLabelFormatStyleComboBox: TiComponentEditorComboBox;
    XAxisLabelPrecisionStyleComboBox: TiComponentEditorComboBox;
    XAxisLabelMinLengthEdit: TiComponentEditorEdit;
    XAxisLabelMinLengthAutoAdjustCheckBox: TiComponentEditorCheckBox;
    TabSheet12: TTabSheet;
    Label33: TLabel;
    Label103: TLabel;
    Label105: TLabel;
    XAxisCursorPrecisionUpDown: TiUpDown;
    Label198: TLabel;
    Label199: TLabel;
    Bevel2: TBevel;
    XAxisCursorPrecisionEdit: TiComponentEditorEdit;
    XAxisCursorDateTimeFormatComboBox: TiComponentEditorComboBox;
    XAxisCursorFormatStyleComboBox: TiComponentEditorComboBox;
    XAxisCursorPrecisionStyleComboBox: TiComponentEditorComboBox;
    XAxisCursorMinLengthEdit: TiComponentEditorEdit;
    XAxisCursorMinLengthAutoAdjustCheckBox: TiComponentEditorCheckBox;
    XAxisCursorUseDefaultFormatCheckBox: TiComponentEditorCheckBox;
    XAxisCursorCopyDefaultButton: TiComponentEditorButton;
    TabSheet13: TTabSheet;
    Label200: TLabel;
    Label201: TLabel;
    Label202: TLabel;
    XAxisLegendPrecisionUpDown: TiUpDown;
    Label203: TLabel;
    Label204: TLabel;
    Bevel3: TBevel;
    XAxisLegendPrecisionEdit: TiComponentEditorEdit;
    XAxisLegendDateTimeFormatComboBox: TiComponentEditorComboBox;
    XAxisLegendFormatStyleComboBox: TiComponentEditorComboBox;
    XAxisLegendPrecisionStyleComboBox: TiComponentEditorComboBox;
    XAxisLegendMinLengthEdit: TiComponentEditorEdit;
    XAxisLegendMinLengthAutoAdjustCheckBox: TiComponentEditorCheckBox;
    XAxisLegendUseDefaultFormatCheckBox: TiComponentEditorCheckBox;
    XAxisLegendCopyDefaultButton: TiComponentEditorButton;
    Label215: TLabel;
    Label216: TLabel;
    EditMenuItem: TMenuItem;
    BackGroundTabSheet: TTabSheet;
    Label75: TLabel;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    BackGroundGradientGroupBox: TGroupBox;
    Label217: TLabel;
    Label218: TLabel;
    Label219: TLabel;
    BackGroundGradientEnabledCheckBox: TiComponentEditorCheckBox;
    BackGroundGradientStartColorPicker: TiComponentEditorColorPicker;
    BackGroundGradientStopColorPicker: TiComponentEditorColorPicker;
    BackGroundGradientDirectionComboBox: TiComponentEditorComboBox;
    DataCursorMenuItemShowOptionsCheckBox: TiComponentEditorCheckBox;
    Label115: TLabel;
    Label116: TLabel;
    Label220: TLabel;
    DataCursorPointerPenWidthUpDown: TiUpDown;
    DataCursorPointer1PositionEdit: TiComponentEditorEdit;
    DataCursorPointer2PositionEdit: TiComponentEditorEdit;
    DataCursorPointerPenWidthEdit: TiComponentEditorEdit;
    TablesTabSheet: TTabSheet;
    TablePageControl: TiComponentEditorPageControl;
    TablesGeneralTabSheet: TTabSheet;
    TablesGridTabSheet: TTabSheet;
    TableGridBackgroundGroupBox: TGroupBox;
    Label224: TLabel;
    TableGridBackGroundTransparentCheckBox: TiComponentEditorCheckBox;
    TableGridBackgroundColorPicker: TiComponentEditorColorPicker;
    TableLinesGroupBox: TGroupBox;
    Label225: TLabel;
    TableGridLinesShowCheckBox: TiComponentEditorCheckBox;
    TableGridLinesColorPicker: TiComponentEditorColorPicker;
    TableListBox: TiComponentEditorListBox;
    iTableAddButton: TButton;
    TableRemoveButton: TButton;
    Label221: TLabel;
    Label222: TLabel;
    Label223: TLabel;
    Label226: TLabel;
    TableMarginGroupBox: TGroupBox;
    TableLeftMarginEdit: TiComponentEditorEdit;
    TableTopMarginEdit: TiComponentEditorEdit;
    TableBottomMarginEdit: TiComponentEditorEdit;
    TableRightMarginEdit: TiComponentEditorEdit;
    TableDataGroupBox: TGroupBox;
    TableDataFontPicker: TiComponentEditorFontPicker;
    TableColumnTitlesGroupBox: TGroupBox;
    TableColumnTitlesFontPicker: TiComponentEditorFontPicker;
    TableColumnTitlesVisibleCheckBox: TiComponentEditorCheckBox;
    TableColumnSpacingEdit: TiComponentEditorEdit;
    TableRowSpacingEdit: TiComponentEditorEdit;
    TableNameEdit: TiComponentEditorEdit;
    TableRowsMaxEdit: TiComponentEditorEdit;
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
    ChannelMarkersFontPicker: TiComponentEditorFontPicker;
    Label227: TLabel;
    XAxisAlignRefAxisNameComboBox: TiComponentEditorComboBox;
    Label228: TLabel;
    YAxisAlignRefAxisNameComboBox: TiComponentEditorComboBox;
    Label3: TLabel;
    Label5: TLabel;
    ChannelTraceLineWidthUpDown: TiUpDown;
    ChannelInterpolationStyleLabel: TLabel;
    ChannelTraceLineStyleComboBox: TiComponentEditorComboBox;
    ChannelTraceLineWidthEdit: TiComponentEditorEdit;
    ChannelTraceVisibleCheckBox: TiComponentEditorCheckBox;
    ChannelInterpolationStyleComboBox: TiComponentEditorComboBox;
    XAxisForceStackingCheckBox: TiComponentEditorCheckBox;
    YAxisForceStackingCheckBox: TiComponentEditorCheckBox;
    DataViewAxesControlGroupBox: TiComponentEditorGroupBox;
    Label237: TLabel;
    DataViewAxesControlWheelStyleComboBox: TiComponentEditorComboBox;
    DataViewAxesControlEnabledCheckBox: TiComponentEditorCheckBox;
    Label238: TLabel;
    DataViewAxesControlMouseStyleComboBox: TiComponentEditorComboBox;
    TablesLayoutTabSheet: TTabSheet;
    Label239: TLabel;
    Label240: TLabel;
    TableStartPercentEdit: TiComponentEditorEdit;
    TableStopPercentEdit: TiComponentEditorEdit;
    Label144: TLabel;
    DataFileColumnSeparatorComboBox: TiComponentEditorComboBox;
    Label63: TLabel;
    LegendColumnSpacingEdit: TiComponentEditorEdit;
    LegendFontPicker: TiComponentEditorFontPicker;
    LegendVisibleCheckbox: TiComponentEditorCheckBox;
    LegendEnabledCheckbox: TiComponentEditorCheckBox;
    LegendPopupEnabledCheckbox: TiComponentEditorCheckBox;
    LegendChannelNameGroupBox: TGroupBox;
    Label1: TLabel;
    Label241: TLabel;
    LegendChannelNameMaxWidthEdit: TiComponentEditorEdit;
    LegendChannelNameColorStyleComboBox: TiComponentEditorComboBox;
    Label243: TLabel;
    ChannelHighLowEnabledCheckBox: TiComponentEditorCheckBox;
    ChannelHighLowStyleComboBox: TiComponentEditorComboBox;
    iComponentEditorPageControl2: TiComponentEditorPageControl;
    ChannelHighLowOpenCloseTabSheet: TTabSheet;
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
    TabSheet18: TTabSheet;
    Label242: TLabel;
    Label244: TLabel;
    Label245: TLabel;
    ChannelHighLowShadowColorPicker: TiComponentEditorColorPicker;
    ChannelHighLowBullishColorPicker: TiComponentEditorColorPicker;
    ChannelHighLowBearishColorPicker: TiComponentEditorColorPicker;
    Label52: TLabel;
    Label102: TLabel;
    XAxisLabelFontPicker: TiComponentEditorFontPicker;
    XAxisLabelVisibleCheckBox: TiComponentEditorCheckBox;
    XAxisLabelMarginEdit: TiComponentEditorEdit;
    XAxisLabelSeparationEdit: TiComponentEditorEdit;
    Label246: TLabel;
    XAxisLabelRotationComboBox: TiComponentEditorComboBox;
    Label14: TLabel;
    Label24: TLabel;
    Label34: TLabel;
    YAxisLabelPrecisionUpDown: TiUpDown;
    Label35: TLabel;
    Label53: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Bevel6: TBevel;
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
    Label247: TLabel;
    YAxisLabelRotationComboBox: TiComponentEditorComboBox;
    ToolBarShowPreviewButtonCheckBox: TiComponentEditorCheckBox;
    XAxisTitleRotatedCheckBox: TiComponentEditorCheckBox;
    YAxisTitleRotatedCheckBox: TiComponentEditorCheckBox;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    Label145: TLabel;
    AnnotationDefaultReferenceComboBox: TiComponentEditorComboBox;
    Label146: TLabel;
    AnnotationDefaultReferencePositionXComboBox: TiComponentEditorComboBox;
    Label147: TLabel;
    AnnotationDefaultReferencePositionYComboBox: TiComponentEditorComboBox;
    Label148: TLabel;
    AnnotationDefaultReferenceSizeXComboBox: TiComponentEditorComboBox;
    Label248: TLabel;
    AnnotationDefaultReferenceSizeYComboBox: TiComponentEditorComboBox;
    LayoutTabSheet: TTabSheet;
    Label4: TLabel;
    Label6: TLabel;
    Label45: TLabel;
    Label42: TLabel;
    Label46: TLabel;
    Label77: TLabel;
    Label177: TLabel;
    Label187: TLabel;
    iUpDown2: TiUpDown;
    Label249: TLabel;
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
    ChannelDataStyleComboBox: TiComponentEditorComboBox;
    ChannelLayerEdit: TiComponentEditorEdit;
    ChannelUserCanMoveDataPointsCheckBox: TiComponentEditorCheckBox;
    ChannelUserCanMoveDataPointsStyleComboBox: TiComponentEditorComboBox;
    LineColumnGroupBox: TGroupBox;
    Label250: TLabel;
    LegendLineColumnWidthEdit: TiComponentEditorEdit;
    Label251: TLabel;
    LegendLineColumnHeightEdit: TiComponentEditorEdit;
    ChannelClipToAxesCheckBox: TiComponentEditorCheckBox;
    LimitClipToAxesCheckBox: TiComponentEditorCheckBox;
    Label252: TLabel;
    XAxisTrackingIncrementStyleComboBox: TiComponentEditorComboBox;
    Label253: TLabel;
    YAxisTrackingIncrementStyleComboBox: TiComponentEditorComboBox;
    ChannelUserCanEditCheckBox: TiComponentEditorCheckBox;
    DataCursorPopupEnabledCheckBox: TiComponentEditorCheckBox;
    DataCursorSnapToDataPointCheckBox: TiComponentEditorCheckBox;
    DataCursorUserCanEditCheckBox: TiComponentEditorCheckBox;
    LimitUserCanEditCheckBox: TiComponentEditorCheckBox;
    LabelUserCanEditCheckBox: TiComponentEditorCheckBox;
    XAxisVisibleCheckBox: TiComponentEditorCheckBox;
    XAxisReverseScaleCheckBox: TiComponentEditorCheckBox;
    XAxisEnabledCheckBox: TiComponentEditorCheckBox;
    XAxisPopupEnabledCheckBox: TiComponentEditorCheckBox;
    XAxisRestoreValuesOnResumeCheckBox: TiComponentEditorCheckBox;
    XAxisMasterUIInputCheckBox: TiComponentEditorCheckBox;
    XAxisGridLinesVisibleCheckBox: TiComponentEditorCheckBox;
    XAxisUserCanEditCheckBox: TiComponentEditorCheckBox;
    YAxisVisibleCheckBox: TiComponentEditorCheckBox;
    YAxisReverseScaleCheckBox: TiComponentEditorCheckBox;
    YAxisEnabledCheckBox: TiComponentEditorCheckBox;
    YAxisPopupEnabledCheckBox: TiComponentEditorCheckBox;
    YAxisRestoreValuesOnResumeCheckBox: TiComponentEditorCheckBox;
    YAxisMasterUIInputCheckBox: TiComponentEditorCheckBox;
    YAxisGridLinesVisibleCheckBox: TiComponentEditorCheckBox;
    YAxisUserCanEditCheckBox: TiComponentEditorCheckBox;
    LegendUserCanEditCheckBox: TiComponentEditorCheckBox;
    TableVisibleCheckbox: TiComponentEditorCheckBox;
    TableEnabledCheckbox: TiComponentEditorCheckBox;
    TablePopupEnabledCheckbox: TiComponentEditorCheckBox;
    TableUserCanEditCheckBox: TiComponentEditorCheckBox;
    ToolBarVisibleCheckBox: TiComponentEditorCheckBox;
    ToolBarEnabledCheckBox: TiComponentEditorCheckBox;
    ToolBarPopupEnabledCheckBox: TiComponentEditorCheckBox;
    ToolBarFlatButtonsCheckBox: TiComponentEditorCheckBox;
    ToolBarSmallButtonsCheckBox: TiComponentEditorCheckBox;
    ToolBarFlatBorderCheckBox: TiComponentEditorCheckBox;
    ToolBarUserCanEditCheckBox: TiComponentEditorCheckBox;
    DataViewUserCanEditCheckBox: TiComponentEditorCheckBox;
    ChannelAdvancedTabSheet: TTabSheet;
    ChannelDrawOutOfOrderXValuesCheckBox: TiComponentEditorCheckBox;
    ChannelAllowOutOfOrderXValuesCheckBox: TiComponentEditorCheckBox;
    XAxisCanFocusCheckBox: TiComponentEditorCheckBox;
    YAxisCanFocusCheckBox: TiComponentEditorCheckBox;
    LegendCanFocusCheckBox: TiComponentEditorCheckBox;
    ChannelCanFocusCheckBox: TiComponentEditorCheckBox;
    DataCursorCanFocusCheckBox: TiComponentEditorCheckBox;
    LimitCanFocusCheckBox: TiComponentEditorCheckBox;
    LabelCanFocusCheckBox: TiComponentEditorCheckBox;
    TableCanFocusCheckBox: TiComponentEditorCheckBox;
    DataViewCanFocusCheckBox: TiComponentEditorCheckBox;
    DataCursorUseCachedInterpolatedDataCheckBox: TiComponentEditorCheckBox;
    Label254: TLabel;
    XAxisTrackingSpanMinimumEdit: TiComponentEditorEdit;
    Label255: TLabel;
    XAxisTrackingMaxMarginEdit: TiComponentEditorEdit;
    Label256: TLabel;
    XAxisTrackingMinMarginEdit: TiComponentEditorEdit;
    Label257: TLabel;
    YAxisTrackingSpanMinimumEdit: TiComponentEditorEdit;
    Label258: TLabel;
    YAxisTrackingMaxMarginEdit: TiComponentEditorEdit;
    Label259: TLabel;
    YAxisTrackingMinMarginEdit: TiComponentEditorEdit;
    ChannelResetStartTimeOnFirstDataPointCheckBox: TiComponentEditorCheckBox;
    ChannelShowDataPointHintsCheckBox: TiComponentEditorCheckBox;
    XValueSourcePanel: TPanel;
    ChannelOPCXValueSourceComboBox: TiComponentEditorComboBox;
    ChannelOPCXValueSourceLabel: TLabel;
    LimitSelectModeOnlyInteractionCheckBox: TiComponentEditorCheckBox;
    DataViewAxesControlAllowInSelectModeCheckBox: TiComponentEditorCheckBox;
    Label260: TLabel;
    iUpDown5: TiUpDown;
    LabelImageListIndexEdit: TiComponentEditorEdit;
    Label261: TLabel;
    iUpDown6: TiUpDown;
    LabelImageIndexEdit: TiComponentEditorEdit;
    procedure FormActivate(Sender: TObject);
    procedure ChannelListBoxClick(Sender: TObject);
    procedure ChannelChange(Sender: TObject);
    procedure iChannelAddButtonClick(Sender: TObject);
    procedure ChannelRemoveButtonClick(Sender: TObject);
    procedure iComponentEditorFormCreate(Sender: TObject);
    procedure XAxesAddButtonClick(Sender: TObject);
    procedure XAxisRemoveButtonClick(Sender: TObject);
    procedure XAxisListBoxClick(Sender: TObject);
    procedure ChannelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure XAxisListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure ModifiedEvent(Sender: TObject);
    procedure iComponentEditorFormDestroy(Sender: TObject);
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
    procedure ToolBarListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure ToolBarListBoxClick(Sender: TObject);
    procedure ToolBarChange(Sender: TObject);
    procedure DataViewListBoxClick(Sender: TObject);
    procedure DataViewListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure DataViewChange(Sender: TObject);
    procedure ControlPropertiesSavePickerChange(Sender: TObject);
    procedure ControlPropertiesOpenPickerChange(Sender: TObject);
    procedure ChannelPropertiesSavePickerChange(Sender: TObject);
    procedure ChannelPropertiesOpenPickerChange(Sender: TObject);
    procedure ChannelLogFileNamePickerChange(Sender: TObject);
    procedure iPlotLayoutViewerChange(Sender: TObject);
    procedure ControlLogFileNamePickerChange(Sender: TObject);
    procedure DataCursorListBoxClick(Sender: TObject);
    procedure DataCursorListBoxGetData(const Index: Integer;  var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure iDataCursorAddButtonClick(Sender: TObject);
    procedure DataCursorRemoveButtonClick(Sender: TObject);
    procedure ChannelNameComboBoxDropDown(Sender: TObject);
    procedure DataCursorChange(Sender: TObject);
    procedure LimitListBoxClick(Sender: TObject);
    procedure LimitListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure LimitChange(Sender: TObject);
    procedure iLimitAddButtonClick(Sender: TObject);
    procedure LimitRemoveButtonClick(Sender: TObject);
    procedure TranslationListBoxClick(Sender: TObject);
    procedure TranslationChange(Sender: TObject);
    procedure iTranslationAddButtonClick(Sender: TObject);
    procedure TranslationListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure TranslationClearAllButtonClick(Sender: TObject);
    procedure TranslationRemoveButtonClick(Sender: TObject);
    procedure TranslationSavePickerChange(Sender: TObject);
    procedure iTranslationOpenPickerChange(Sender: TObject);
    procedure LabelChange(Sender: TObject);
    procedure iLabelAddButtonClick(Sender: TObject);
    procedure LabelRemoveButtonClick(Sender: TObject);
    procedure LabelListBoxClick(Sender: TObject);
    procedure LabelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure TitleChange(Sender: TObject);
    procedure DataViewGridXAxisNameComboBoxDropDown(Sender: TObject);
    procedure DataViewGridYAxisNameComboBoxDropDown(Sender: TObject);
    procedure LayoutPopupMenuPopup(Sender: TObject);
    procedure XYAxesReverseMenuItemClick(Sender: TObject);
    procedure AddXAxisMenuItemClick(Sender: TObject);
    procedure AddYAxisMenuItemClick(Sender: TObject);
    procedure AddLabelMenuItemClick(Sender: TObject);
    procedure DeleteMenuItemClick(Sender: TObject);
    procedure VisibleMenuItemClick(Sender: TObject);
    procedure DataCursorChannelNameComboBoxDropDown(Sender: TObject);
    procedure iPlotLayoutViewerMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure XAxisCursorCopyDefaultButtonClick(Sender: TObject);
    procedure XAxisLegendCopyDefaultButtonClick(Sender: TObject);
    procedure YAxisCursorCopyDefaultButtonClick(Sender: TObject);
    procedure YAxisLegendCopyDefaultButtonClick(Sender: TObject);
    procedure EditMenuItemClick(Sender: TObject);
    procedure ControlLogFileNameEditUpdate(Sender: TObject);
    procedure TableChange(Sender: TObject);
    procedure TableListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure TableListBoxClick(Sender: TObject);
    procedure iTableAddButtonClick(Sender: TObject);
    procedure TableRemoveButtonClick(Sender: TObject);
  private
    FMaster               : TiPlotMasterManager;
    FLastToolBarIndex     : Integer;
    FLastLegendIndex      : Integer;
    FLastXAxisIndex       : Integer;
    FLastYAxisIndex       : Integer;
    FLastDataViewIndex    : Integer;
    FLastChannelIndex     : Integer;
    FLastDataCursorIndex  : Integer;
    FLastLimitIndex       : Integer;
    FLastTranslationIndex : Integer;
    FLastLabelIndex       : Integer;
    FLastTableIndex       : Integer;
    FTransferring         : Boolean;
    FRightClickObject     : TiPlotLayoutObject;
  protected
    procedure UpdateAll;
    procedure UpdateToolBarEdit;
    procedure UpdateLegendEdit;
    procedure UpdateTableEdit;
    procedure UpdateXAxesEdit;
    procedure UpdateYAxesEdit;
    procedure UpdateDataViewEdit;
    procedure UpdateChannelEdit;
    procedure UpdateDataCursorEdit;
    procedure UpdateLimitEdit;
    procedure UpdateTranslationEdit;
    procedure UpdateLabelEdit;

    procedure MasterChange(Sender : TObject);
    procedure MasterInsert(Sender : TObject);
    procedure MasterRemove(Sender : TObject);

    procedure CreateThemeInstance; override;

    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  public
  end;

var
  iPlotComponentEditorForm: TiPlotComponentEditorForm;

implementation

uses
{$IFDEF iVCL} iPlotComponent,  iPlot,  iXYPlot,  iPlotAxis,  iPlotLegend,  iPlotToolBar,  iPlotChannelCustom,  iPlotChannel,  iXYPlotChannel,  iPlotTable,{$ENDIF}
{$IFDEF iCLX}QiPlotComponent, QiPlot, QiXYPlot, QiPlotAxis, QiPlotLegend, QiPlotToolBar, QiPlotChannelCustom, QiPlotChannel, QiXYPlotChannel, QiPlotTable,{$ENDIF}

{$IFDEF iVCL}  iOPCComputerSelector, iOPCServerSelector, iOPCItemSelector,{$ENDIF}

{$IFDEF iVCL}  iPlotDataView,  iPlotLimit,  iPlotLabel,  iPlotDataCursor,  iPlotTranslation;{$ENDIF}
{$IFDEF iCLX} QiPlotDataView, QiPlotLimit, QiPlotLabel, QiPlotDataCursor, QiPlotTranslation;{$ENDIF}


type
  TiPlotComponentAccess = class(TiPlotComponent) end;

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.iComponentEditorFormCreate(Sender: TObject);
begin
  FMaster := TiPlotMasterManager.Create(Self);
  FMaster.OnChange := MasterChange;
  FMaster.OnInsert := MasterInsert;
  FMaster.OnRemove := MasterRemove;

  iPlotLayoutViewer.Master        := FMaster;
  iPlotLayoutViewer.LayoutManager := FMaster.LayOutManager;

  iOPCBrowserPanel.AddItem;
  iOPCBrowserPanel.UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.UpdateAll;
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
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.iComponentEditorFormDestroy(Sender: TObject);
begin
  FMaster.Free;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.CreateThemeInstance;
begin
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.FormActivate(Sender: TObject);
var
  MaxZoom : Double;
  XZoom   : Double;
  YZoom   : Double;
begin
  PageControl.ActivePage := LayoutTabSheet;

  XZoom := LayoutTabSheet.Width*0.95  / iComponent.Width;
  YZoom := LayoutTabSheet.Height*0.95 / iComponent.Height;

  if XZoom > YZoom then MaxZoom := YZoom else MaxZoom := XZoom;

  iPlotLayoutViewer.Width  := Round(iComponent.Width  * MaxZoom);
  iPlotLayoutViewer.Height := Round(iComponent.Height * MaxZoom);

  iPlotLayoutViewer.Left   := (LayoutTabSheet.Width  - iPlotLayoutViewer.Width ) div 2;
  iPlotLayoutViewer.Top    := (LayoutTabSheet.Height - iPlotLayoutViewer.Height) div 2;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ModifiedEvent(Sender: TObject);
begin
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.MasterChange(Sender: TObject);
begin
  iPlotLayoutViewer.Invalidate;
  if not FTransferring then Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.MasterInsert(Sender: TObject);
begin
  if Sender is TiPlotToolBar           then ToolBarListBox.Items.AddObject    ('',Sender);
  if Sender is TiPlotLegend            then LegendListBox.Items.AddObject     ('',Sender);
  if Sender is TiPlotTable             then TableListBox.Items.AddObject      ('',Sender);
  if Sender is TiPlotXAxis             then XAxisListBox.Items.AddObject      ('',Sender);
  if Sender is TiPlotYAxis             then YAxisListBox.Items.AddObject      ('',Sender);
  if Sender is TiPlotDataView          then DataViewListBox.Items.AddObject   ('',Sender);
  if Sender is TiPlotChannelCustom     then ChannelListBox.Items.AddObject    ('',Sender);
  if Sender is TiPlotDataCursor        then DataCursorListBox.Items.AddObject ('',Sender);
  if Sender is TiPlotLimit             then LimitListBox.Items.AddObject      ('',Sender);
  if Sender is TiPlotLabel             then LabelListBox.Items.AddObject      ('',Sender);
  if Sender is TiPlotTranslationObject then TranslationListBox.Items.AddObject('',Sender);

  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.MasterRemove(Sender: TObject);
begin
  if Sender is TiPlotToolBar           then ToolBarListBox.DeleteObjectIndex(Sender);
  if Sender is TiPlotLegend            then LegendListBox.DeleteObjectIndex(Sender);
  if Sender is TiPlotTable             then TableListBox.DeleteObjectIndex(Sender);
  if Sender is TiPlotXAxis             then XAxisListBox.DeleteObjectIndex(Sender);
  if Sender is TiPlotYAxis             then YAxisListBox.DeleteObjectIndex(Sender);
  if Sender is TiPlotDataView          then DataViewListBox.DeleteObjectIndex(Sender);
  if Sender is TiPlotChannelCustom     then ChannelListBox.DeleteObjectIndex(Sender);
  if Sender is TiPlotDataCursor        then DataCursorListBox.DeleteObjectIndex(Sender);
  if Sender is TiPlotLimit             then LimitListBox.DeleteObjectIndex(Sender);
  if Sender is TiPlotLabel             then LabelListBox.DeleteObjectIndex(Sender);
  if Sender is TiPlotTranslationObject then TranslationListBox.DeleteObjectIndex(Sender);
  
  if not FTransferring then Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.XAxisNameComboBoxDropDown(Sender: TObject);
var
  x : Integer;
  OldText : String;
begin
  if not Assigned(FMaster.XAxisManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add('<None>');
      for x := 0 to FMaster.XAxisManager.Count-1 do
        Items.Add(FMaster.XAxisManager.Items[x].Name);
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.DataViewGridXAxisNameComboBoxDropDown(Sender: TObject);
var
  x : Integer;
  OldText : String;
begin
  if not Assigned(FMaster.XAxisManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add('<None>');
      for x := 0 to FMaster.XAxisManager.Count-1 do
        Items.Add(FMaster.XAxisManager.Items[x].Name);
      Items.Add('<All>');
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.YAxisNameComboBoxDropDown(Sender: TObject);
var
  x       : Integer;
  OldText : String;
begin
  if not Assigned(FMaster.YAxisManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add('<None>');
      for x := 0 to FMaster.YAxisManager.Count-1 do
        Items.Add(FMaster.YAxisManager.Items[x].Name);
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.DataViewGridYAxisNameComboBoxDropDown(Sender: TObject);
var
  x       : Integer;
  OldText : String;
begin
  if not Assigned(FMaster.YAxisManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add('<None>');
      for x := 0 to FMaster.YAxisManager.Count-1 do
        Items.Add(FMaster.YAxisManager.Items[x].Name);
      Items.Add('<All>');
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ChannelNameComboBoxDropDown(Sender: TObject);
var
  x       : Integer;
  OldText : String;
begin
  if not Assigned(FMaster.ChannelManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add('<None>');
      for x := 0 to FMaster.ChannelManager.Count-1 do
        Items.Add(FMaster.ChannelManager.Items[x].Name);
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.DataCursorChannelNameComboBoxDropDown(Sender: TObject);
var
  x : Integer;
  OldText : String;
begin
  if not Assigned(FMaster.ChannelManager) then exit;
  with Sender as TiComponentEditorComboBox do
    begin
      OldText := AsString;
      Clear;
      Items.Add(FMaster.TranslationManager.FindReplacement('<All>'));
      for x := 0 to FMaster.ChannelManager.Count-1 do
        Items.Add(FMaster.ChannelManager.Items[x].Name);
      ItemIndex := Items.IndexOf(OldText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ToolBarListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  AText  := (ToolBarListBox.Items.Objects[Index] as TiPlotToolBar).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.LegendListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  AText  := (LegendListBox.Items.Objects[Index] as TiPlotLegend).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.TableListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  AText  := (TableListBox.Items.Objects[Index] as TiPlotTable).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.XAxisListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (XAxisListBox.Items.Objects[Index] as TiPlotXAxis).LabelsFont.Color;
  AText  := (XAxisListBox.Items.Objects[Index] as TiPlotXAxis).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.YAxisListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (YAxisListBox.Items.Objects[Index] as TiPlotYAxis).LabelsFont.Color;
  AText  := (YAxisListBox.Items.Objects[Index] as TiPlotYAxis).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.DataViewListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  AText  := (DataViewListBox.Items.Objects[Index] as TiPlotDataView).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ChannelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (ChannelListBox.Items.Objects[Index] as TiPlotChannelCustom).Color;
  AText  := (ChannelListBox.Items.Objects[Index] as TiPlotChannelCustom).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.DataCursorListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (DataCursorListBox.Items.Objects[Index] as TiPlotDataCursor).Color;
  AText  := (DataCursorListBox.Items.Objects[Index] as TiPlotDataCursor).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.LimitListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (LimitListBox.Items.Objects[Index] as TiPlotLimit).Color;
  AText  := (LimitListBox.Items.Objects[Index] as TiPlotLimit).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.LabelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  AText  := (LabelListBox.Items.Objects[Index] as TiPlotLabel).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.TranslationListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  with (TranslationListBox.Items.Objects[Index] as TiPlotTranslationObject) do
    AText  := OriginalString + ' : ' + ReplacementString;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ToolBarListBoxClick    (Sender: TObject);begin UpdateToolBarEdit;    end;
procedure TiPlotComponentEditorForm.LegendListBoxClick     (Sender: TObject);begin UpdateLegendEdit;     end;
procedure TiPlotComponentEditorForm.TableListBoxClick      (Sender: TObject);begin UpdateTableEdit;      end;
procedure TiPlotComponentEditorForm.XAxisListBoxClick      (Sender: TObject);begin UpdateXAxesEdit;      end;
procedure TiPlotComponentEditorForm.YAxisListBoxClick      (Sender: TObject);begin UpdateYAxesEdit;      end;
procedure TiPlotComponentEditorForm.DataViewListBoxClick   (Sender: TObject);begin UpdateDataViewEdit;   end;
procedure TiPlotComponentEditorForm.ChannelListBoxClick    (Sender: TObject);begin UpdateChannelEdit;    end;
procedure TiPlotComponentEditorForm.DataCursorListBoxClick (Sender: TObject);begin UpdateDataCursorEdit; end;
procedure TiPlotComponentEditorForm.LimitListBoxClick      (Sender: TObject);begin UpdateLimitEdit;      end;
procedure TiPlotComponentEditorForm.TranslationListBoxClick(Sender: TObject);begin UpdateTranslationEdit;end;
procedure TiPlotComponentEditorForm.LabelListBoxClick      (Sender: TObject);begin UpdateLabelEdit;      end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.XAxesAddButtonClick       (Sender:TObject);begin FMaster.AddXAxis;      XAxisListBox.SelectLast;      UpdateXAxesEdit;      end;
procedure TiPlotComponentEditorForm.YAxesAddButtonClick       (Sender:TObject);begin FMaster.AddYAxis;      YAxisListBox.SelectLast;      UpdateYAxesEdit;      end;
procedure TiPlotComponentEditorForm.iChannelAddButtonClick    (Sender:TObject);begin FMaster.AddChannel;    ChannelListBox.SelectLast;    UpdateChannelEdit;    end;
procedure TiPlotComponentEditorForm.iDataCursorAddButtonClick (Sender:TObject);begin FMaster.AddDataCursor; DataCursorListBox.SelectLast; UpdateDataCursorEdit; end;
procedure TiPlotComponentEditorForm.iLimitAddButtonClick      (Sender:TObject);begin FMaster.AddLimit;      LimitListBox.SelectLast;      UpdateLimitEdit;      end;
procedure TiPlotComponentEditorForm.iTranslationAddButtonClick(Sender:TObject);begin FMaster.AddTranslation;TranslationListBox.SelectLast;UpdateTranslationEdit;end;
procedure TiPlotComponentEditorForm.iLabelAddButtonClick      (Sender:TObject);begin FMaster.AddLabel;      LabelListBox.SelectLast;      UpdateLabelEdit;      end;
procedure TiPlotComponentEditorForm.iTableAddButtonClick      (Sender:TObject);begin FMaster.AddTable;      TableListBox.SelectLast;      UpdateTableEdit;      end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.XAxisRemoveButtonClick     (Sender:TObject);begin XAxisListBox.DeleteSelectedObject;     UpdateChannelEdit;UpdateXAxesEdit;end;
procedure TiPlotComponentEditorForm.YAxisRemoveButtonClick     (Sender:TObject);begin YAxisListBox.DeleteSelectedObject;     UpdateChannelEdit;UpdateYAxesEdit;end;
procedure TiPlotComponentEditorForm.ChannelRemoveButtonClick   (Sender:TObject);begin ChannelListBox.DeleteSelectedObject;   UpdateChannelEdit;                end;
procedure TiPlotComponentEditorForm.DataCursorRemoveButtonClick(Sender:TObject);begin DataCursorListBox.DeleteSelectedObject;UpdateDataCursorEdit;             end;
procedure TiPlotComponentEditorForm.LimitRemoveButtonClick     (Sender:TObject);begin LimitListBox.DeleteSelectedObject;     UpdateLimitEdit;                  end;
procedure TiPlotComponentEditorForm.LabelRemoveButtonClick     (Sender:TObject);begin LabelListBox.DeleteSelectedObject;     UpdateLabelEdit;                  end;
procedure TiPlotComponentEditorForm.TableRemoveButtonClick     (Sender:TObject);begin TableListBox.DeleteSelectedObject;     UpdateTableEdit;                  end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.TranslationRemoveButtonClick(Sender: TObject);
begin
  TranslationListBox.DeleteSelectedObject;
  UpdateTranslationEdit;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iPlotComponent : TiPlotComponent;
  Index          : Integer;
  x              : Integer;
  iTranslation   : TiPlotTranslationObject;
  AList          : TStringList;
begin
  FTransferring := True;
  iPlotComponent := Component as TiPlotComponent;

  TiPlotComponentAccess(iPlotComponent).BeforePropertyEditorLoad;

  iOPCBrowserPanel.Item2Caption := 'Item (Y-Axis)';

  if iPlotComponent is TiPlot then
    begin
      FMaster.ChannelClass           := TiPlotChannel;
      iOPCBrowserPanel.ItemCaption   := 'Item';
      iOPCBrowserPanel.Item2Visible  := False;
      iOPCBrowserPanel.ShowGroupName := True;
    end
  else if iPlotComponent is TiXYPlot then
    begin
      FMaster.ChannelClass := TiXYPlotChannel;
      iOPCBrowserPanel.ItemCaption   := 'Item (X-Axis)';
      iOPCBrowserPanel.Item2Visible  := True;
      iOPCBrowserPanel.ShowGroupName := True;
    end;

  FMaster.ToolBarManager.Clear;
  FMaster.LegendManager.Clear;
  FMaster.TableManager.Clear;
  FMaster.XAxisManager.Clear;
  FMaster.YAxisManager.Clear;
  FMaster.ChannelManager.Clear;
  FMaster.DataViewManager.Clear;
  FMaster.DataCursorManager.Clear;
  FMaster.LimitManager.Clear;
  FMaster.LabelManager.Clear;
  FMaster.TranslationManager.Clear;

  FMaster.LayOutManager.Enabled := False;

  with iPlotComponent do
    begin
      FMaster.LayOutManager.DataViewHorz.ZOrder             := DataViewZHorz;
      FMaster.LayOutManager.DataViewVert.ZOrder             := DataViewZVert;
      FMaster.XYAxesReverse                                 := XYAxesReverse;

      AutoFrameRateCheckBox.AsBoolean                       := AutoFrameRate;
      UpdateFrameRateEdit.AsInteger                         := UpdateFrameRate;
      BorderStyleRadioGroup.AsInteger                       := ord(BorderStyle);
      UserCanEditObjectsCheckBox.AsBoolean                  := UserCanEditObjects;
      UserCanAddRemoveCheckBox.AsBoolean                    := UserCanAddRemoveChannels;
      ClipAnnotationsToAxesCheckBox.AsBoolean               := ClipAnnotationsToAxes;
      EditorFormStyleComboBox.AsInteger                     := ord(EditorFormStyle);
      CopyToClipBoardFormatComboBox.AsInteger               := ord(CopyToClipBoardFormat);
      DataFileColumnSeparatorComboBox.AsInteger             := ord(DataFileColumnSeparator);

      OuterMarginTopEdit.AsInteger                          := OuterMarginTop;
      OuterMarginBottomEdit.AsInteger                       := OuterMarginBottom;
      OuterMarginLeftEdit.AsInteger                         := OuterMarginLeft;
      OuterMarginRightEdit.AsInteger                        := OuterMarginRight;

      BackGroundColorPicker.Color                           := BackGroundColor;
      BackGroundGradientDirectionComboBox.AsInteger         := ord(BackGroundGradientDirection);
      BackGroundGradientEnabledCheckBox.AsBoolean           := BackGroundGradientEnabled;
      BackGroundGradientStartColorPicker.Color              := BackGroundGradientStartColor;
      BackGroundGradientStopColorPicker.Color               := BackGroundGradientStopColor;

      TitleVisibleCheckBox.AsBoolean                        := TitleVisible;
      TitleMarginEdit.AsFloat                               := TitleMargin;
      TitleTextEdit.AsString                                := TitleText;

      TitleFontPicker.Font.Assign(TitleFont);

      ControlLogFileNameEdit.Text                           := LogFileName;
      ControlLogBufferSizeEdit.AsInteger                    := LogBufferSize;

      HintsShowCheckBox.AsBoolean                           := HintsShow;
      HintsPauseEdit.AsInteger                              := HintsPause;
      HintsHidePauseEdit.AsInteger                          := HintsHidePause;
      HintsFontPicker.Font.Assign(HintsFont);

      PrintOrientationRadioGroup.AsInteger                  := Ord(PrintOrientation);
      PrintShowDialogCheckBox.AsBoolean                     := PrintShowDialog;
      PrintMarginLeftEdit.AsFloat                           := PrintMarginLeft;
      PrintMarginTopEdit.AsFloat                            := PrintMarginTop;
      PrintMarginRightEdit.AsFloat                          := PrintMarginRight;
      PrintMarginBottomEdit.AsFloat                         := PrintMarginBottom;
      PrintDocumentNameEdit.AsString                        := PrintDocumentName;

      AnnotationDefaultPenColorPicker.Color                 := AnnotationDefaultPenColor;
      AnnotationDefaultPenStyleComboBox.AsInteger           := Ord(AnnotationDefaultPenStlye);
      AnnotationDefaultPenWidthEdit.AsInteger               := AnnotationDefaultPenWidth;
      AnnotationDefaultBrushColorPicker.Color               := AnnotationDefaultBrushColor;
      AnnotationDefaultBrushStyleComboBox.AsInteger         := Ord(AnnotationDefaultBrushStlye);

      AnnotationDefaultReferenceComboBox.AsInteger          := ord(AnnotationDefaultReference);
      AnnotationDefaultReferencePositionXComboBox.AsInteger := ord(AnnotationDefaultReferencePositionX);
      AnnotationDefaultReferencePositionYComboBox.AsInteger := ord(AnnotationDefaultReferencePositionY);
      AnnotationDefaultReferenceSizeXComboBox.AsInteger     := ord(AnnotationDefaultReferenceSizeX);
      AnnotationDefaultReferenceSizeYComboBox.AsInteger     := ord(AnnotationDefaultReferenceSizeY);

      ImageEditorPanel0.UpLoad(TiPlotComponentAccess(iPlotComponent).ImageList0);
      ImageEditorPanel1.UpLoad(TiPlotComponentAccess(iPlotComponent).ImageList1);
      ImageEditorPanel2.UpLoad(TiPlotComponentAccess(iPlotComponent).ImageList2);

      AnnotationDefaultFontPicker.Font.Assign(AnnotationDefaultFont);
      //------------------ Toolbar ----------------------------------
      for x := 0 to ToolBarCount - 1 do
        begin
          Index := FMaster.AddToolBar;
          FMaster.ToolBarManager.Items[Index].Name                 := ToolBar[x].Name;
          FMaster.ToolBarManager.Items[Index].Visible              := ToolBar[x].Visible;
          FMaster.ToolBarManager.Items[Index].Enabled              := ToolBar[x].Enabled;
          FMaster.ToolBarManager.Items[Index].PopupEnabled         := ToolBar[x].PopupEnabled;
          FMaster.ToolBarManager.Items[Index].UserCanEdit          := ToolBar[x].UserCanEdit;
          FMaster.ToolBarManager.Items[Index].Layer                := ToolBar[x].Layer;

          FMaster.ToolBarManager.Items[Index].ZOrder               := ToolBar[x].ZOrder;
          FMaster.ToolBarManager.Items[Index].Horizontal           := ToolBar[x].Horizontal;
          FMaster.ToolBarManager.Items[Index].StartPercent         := ToolBar[x].StartPercent;
          FMaster.ToolBarManager.Items[Index].StopPercent          := ToolBar[x].StopPercent;

          FMaster.ToolBarManager.Items[Index].ShowResumeButton     := ToolBar[x].ShowResumeButton;
          FMaster.ToolBarManager.Items[Index].ShowPauseButton      := ToolBar[x].ShowPauseButton;
          FMaster.ToolBarManager.Items[Index].ShowAxesModeButtons  := ToolBar[x].ShowAxesModeButtons;
          FMaster.ToolBarManager.Items[Index].ShowZoomInOutButtons := ToolBar[x].ShowZoomInOutButtons;
          FMaster.ToolBarManager.Items[Index].ShowSelectButton     := ToolBar[x].ShowSelectButton;
          FMaster.ToolBarManager.Items[Index].ShowZoomBoxButton    := ToolBar[x].ShowZoomBoxButton;
          FMaster.ToolBarManager.Items[Index].ShowCursorButton     := ToolBar[x].ShowCursorButton;
          FMaster.ToolBarManager.Items[Index].ShowEditButton       := ToolBar[x].ShowEditButton;
          FMaster.ToolBarManager.Items[Index].ShowCopyButton       := ToolBar[x].ShowCopyButton;
          FMaster.ToolBarManager.Items[Index].ShowSaveButton       := ToolBar[x].ShowSaveButton;
          FMaster.ToolBarManager.Items[Index].ShowPrintButton      := ToolBar[x].ShowPrintButton;
          FMaster.ToolBarManager.Items[Index].ShowPreviewButton    := ToolBar[x].ShowPreviewButton;
          FMaster.ToolBarManager.Items[Index].FlatBorder           := ToolBar[x].FlatBorder;
          FMaster.ToolBarManager.Items[Index].FlatButtons          := ToolBar[x].FlatButtons;
          FMaster.ToolBarManager.Items[Index].SmallButtons         := ToolBar[x].SmallButtons;

          FMaster.ToolBarManager.Items[Index].ZoomInOutFactor      := ToolBar[x].ZoomInOutFactor;
        end;
      //------------------ Legend -----------------------------------
      for x := 0 to LegendCount - 1 do
        begin
          Index := FMaster.AddLegend;
          FMaster.LegendManager.Items[Index].Name                        := Legend[x].Name;
          FMaster.LegendManager.Items[Index].Visible                     := Legend[x].Visible;
          FMaster.LegendManager.Items[Index].Enabled                     := Legend[x].Enabled;
          FMaster.LegendManager.Items[Index].PopupEnabled                := Legend[x].PopupEnabled;
          FMaster.LegendManager.Items[Index].UserCanEdit                 := Legend[x].UserCanEdit;
          FMaster.LegendManager.Items[Index].CanFocus                    := Legend[x].CanFocus;
          FMaster.LegendManager.Items[Index].Layer                       := Legend[x].Layer;

          FMaster.LegendManager.Items[Index].ZOrder                      := Legend[x].ZOrder;
          FMaster.LegendManager.Items[Index].Horizontal                  := Legend[x].Horizontal;
          FMaster.LegendManager.Items[Index].StartPercent                := Legend[x].StartPercent;
          FMaster.LegendManager.Items[Index].StopPercent                 := Legend[x].StopPercent;

          FMaster.LegendManager.Items[Index].MarginLeft                  := Legend[x].MarginLeft;
          FMaster.LegendManager.Items[Index].MarginTop                   := Legend[x].MarginTop;
          FMaster.LegendManager.Items[Index].MarginRight                 := Legend[x].MarginRight;
          FMaster.LegendManager.Items[Index].MarginBottom                := Legend[x].MarginBottom;

          FMaster.LegendManager.Items[Index].ChannelNameMaxWidth         := Legend[x].ChannelNameMaxWidth;
          FMaster.LegendManager.Items[Index].ChannelNameColorStyle       := Legend[x].ChannelNameColorStyle;
          FMaster.LegendManager.Items[Index].LineColumnWidth             := Legend[x].LineColumnWidth;
          FMaster.LegendManager.Items[Index].LineColumnHeight            := Legend[x].LineColumnHeight;
          FMaster.LegendManager.Items[Index].RowSpacing                  := Legend[x].RowSpacing;
          FMaster.LegendManager.Items[Index].ColumnSpacing               := Legend[x].ColumnSpacing;
          FMaster.LegendManager.Items[Index].BackGroundTransparent       := Legend[x].BackGroundTransparent;
          FMaster.LegendManager.Items[Index].BackGroundColor             := Legend[x].BackGroundColor;
          FMaster.LegendManager.Items[Index].SelectedItemBackGroundColor := Legend[x].SelectedItemBackGroundColor;

          FMaster.LegendManager.Items[Index].ShowColumnLine              := Legend[x].ShowColumnLine;
          FMaster.LegendManager.Items[Index].ShowColumnMarker            := Legend[x].ShowColumnMarker;
          FMaster.LegendManager.Items[Index].ShowColumnXAxisTitle        := Legend[x].ShowColumnXAxisTitle;
          FMaster.LegendManager.Items[Index].ShowColumnYAxisTitle        := Legend[x].ShowColumnYAxisTitle;
          FMaster.LegendManager.Items[Index].ShowColumnXValue            := Legend[x].ShowColumnXValue;
          FMaster.LegendManager.Items[Index].ShowColumnYValue            := Legend[x].ShowColumnYValue;
          FMaster.LegendManager.Items[Index].ShowColumnYMax              := Legend[x].ShowColumnYMax;
          FMaster.LegendManager.Items[Index].ShowColumnYMin              := Legend[x].ShowColumnYMin;
          FMaster.LegendManager.Items[Index].ShowColumnYMean             := Legend[x].ShowColumnYMean;

          FMaster.LegendManager.Items[Index].ColumnTitlesVisible         := Legend[x].ColumnTitlesVisible;

          FMaster.LegendManager.Items[Index].CaptionColumnTitle          := Legend[x].CaptionColumnTitle;
          FMaster.LegendManager.Items[Index].CaptionColumnXAxisTitle     := Legend[x].CaptionColumnXAxisTitle;
          FMaster.LegendManager.Items[Index].CaptionColumnYAxisTitle     := Legend[x].CaptionColumnYAxisTitle;
          FMaster.LegendManager.Items[Index].CaptionColumnXValue         := Legend[x].CaptionColumnXValue;
          FMaster.LegendManager.Items[Index].CaptionColumnYValue         := Legend[x].CaptionColumnYValue;
          FMaster.LegendManager.Items[Index].CaptionColumnYMax           := Legend[x].CaptionColumnYMax;
          FMaster.LegendManager.Items[Index].CaptionColumnYMin           := Legend[x].CaptionColumnYMin;
          FMaster.LegendManager.Items[Index].CaptionColumnYMean          := Legend[x].CaptionColumnYMean;

          FMaster.LegendManager.Items[Index].WrapColDesiredCount         := Legend[x].WrapColDesiredCount;
          FMaster.LegendManager.Items[Index].WrapColAutoCountEnabled     := Legend[x].WrapColAutoCountEnabled;
          FMaster.LegendManager.Items[Index].WrapColAutoCountMax         := Legend[x].WrapColAutoCountMax;
          FMaster.LegendManager.Items[Index].WrapColSpacingAuto          := Legend[x].WrapColSpacingAuto;
          FMaster.LegendManager.Items[Index].WrapColSpacingMin           := Legend[x].WrapColSpacingMin;

          FMaster.LegendManager.Items[Index].WrapRowDesiredCount         := Legend[x].WrapRowDesiredCount;
          FMaster.LegendManager.Items[Index].WrapRowAutoCountEnabled     := Legend[x].WrapRowAutoCountEnabled;
          FMaster.LegendManager.Items[Index].WrapRowAutoCountMax         := Legend[x].WrapRowAutoCountMax;
          FMaster.LegendManager.Items[Index].WrapRowSpacingAuto          := Legend[x].WrapRowSpacingAuto;
          FMaster.LegendManager.Items[Index].WrapRowSpacingMin           := Legend[x].WrapRowSpacingMin;

          FMaster.LegendManager.Items[Index].Font.Assign            (Legend[x].Font);
          FMaster.LegendManager.Items[Index].SelectedItemFont.Assign(Legend[x].SelectedItemFont);
          FMaster.LegendManager.Items[Index].ColumnTitlesFont.Assign(Legend[x].ColumnTitlesFont);
        end;
      //------------------ Table -----------------------------------
      for x := 0 to TableCount - 1 do
        begin
          Index := FMaster.AddTable;
          FMaster.TableManager.Items[Index].Name                      := Table[x].Name;
          FMaster.TableManager.Items[Index].Visible                   := Table[x].Visible;
          FMaster.TableManager.Items[Index].Enabled                   := Table[x].Enabled;
          FMaster.TableManager.Items[Index].PopupEnabled              := Table[x].PopupEnabled;
          FMaster.TableManager.Items[Index].UserCanEdit               := Table[x].UserCanEdit;
          FMaster.TableManager.Items[Index].CanFocus                  := Table[x].CanFocus;
          FMaster.TableManager.Items[Index].Layer                     := Table[x].Layer;

          FMaster.TableManager.Items[Index].ZOrder                    := Table[x].ZOrder;
          FMaster.TableManager.Items[Index].Horizontal                := Table[x].Horizontal;
          FMaster.TableManager.Items[Index].StartPercent              := Table[x].StartPercent;
          FMaster.TableManager.Items[Index].StopPercent               := Table[x].StopPercent;

          FMaster.TableManager.Items[Index].MarginLeft                := Table[x].MarginLeft;
          FMaster.TableManager.Items[Index].MarginTop                 := Table[x].MarginTop;
          FMaster.TableManager.Items[Index].MarginRight               := Table[x].MarginRight;
          FMaster.TableManager.Items[Index].MarginBottom              := Table[x].MarginBottom;

          FMaster.TableManager.Items[Index].GridBackGroundColor       := Table[x].GridBackGroundColor;
          FMaster.TableManager.Items[Index].GridBackGroundTransparent := Table[x].GridBackGroundTransparent;
          FMaster.TableManager.Items[Index].GridLinesColor            := Table[x].GridLinesColor;
          FMaster.TableManager.Items[Index].GridLinesShow             := Table[x].GridLinesShow;

          FMaster.TableManager.Items[Index].ColumnSpacing             := Table[x].ColumnSpacing;
          FMaster.TableManager.Items[Index].RowSpacing                := Table[x].RowSpacing;
          FMaster.TableManager.Items[Index].RowsMax                   := Table[x].RowsMax;

          FMaster.TableManager.Items[Index].ColumnTitlesVisible       := Table[x].ColumnTitlesVisible;

          FMaster.TableManager.Items[Index].StartPercent              := Table[x].StartPercent;
          FMaster.TableManager.Items[Index].StopPercent               := Table[x].StopPercent;

          FMaster.TableManager.Items[Index].DataFont.Assign(Table[x].DataFont);;
          FMaster.TableManager.Items[Index].ColumnTitlesFont.Assign(Table[x].ColumnTitlesFont);
        end;
      //------------------ XAxis ------------------------------------
      for x := 0 to XAxisCount - 1 do
        begin
          Index := FMaster.AddXAxis;
          FMaster.XAxisManager.Items[Index].Name                      := XAxis[x].Name;
          FMaster.XAxisManager.Items[Index].Visible                   := XAxis[x].Visible;
          FMaster.XAxisManager.Items[Index].GridLinesVisible          := XAxis[x].GridLinesVisible;
          FMaster.XAxisManager.Items[Index].Enabled                   := XAxis[x].Enabled;
          FMaster.XAxisManager.Items[Index].PopupEnabled              := XAxis[x].PopupEnabled;
          FMaster.XAxisManager.Items[Index].MasterUIInput             := XAxis[x].MasterUIInput;
          FMaster.XAxisManager.Items[Index].UserCanEdit               := XAxis[x].UserCanEdit;
          FMaster.XAxisManager.Items[Index].CanFocus                  := XAxis[x].CanFocus;
          FMaster.XAxisManager.Items[Index].Layer                     := XAxis[x].Layer;

          FMaster.XAxisManager.Items[Index].ZOrder                    := XAxis[x].ZOrder;
          FMaster.XAxisManager.Items[Index].StartPercent              := XAxis[x].StartPercent;
          FMaster.XAxisManager.Items[Index].StopPercent               := XAxis[x].StopPercent;

          FMaster.XAxisManager.Items[Index].Min                       := XAxis[x].Min;
          FMaster.XAxisManager.Items[Index].Span                      := XAxis[x].Span;
          FMaster.XAxisManager.Items[Index].DesiredStart              := XAxis[x].DesiredStart;
          FMaster.XAxisManager.Items[Index].DesiredIncrement          := XAxis[x].DesiredIncrement;
          FMaster.XAxisManager.Items[Index].ReverseScale              := XAxis[x].ReverseScale;
          FMaster.XAxisManager.Items[Index].RestoreValuesOnResume     := XAxis[x].RestoreValuesOnResume;
          FMaster.XAxisManager.Items[Index].InnerMargin               := XAxis[x].InnerMargin;
          FMaster.XAxisManager.Items[Index].OuterMargin               := XAxis[x].OuterMargin;
          FMaster.XAxisManager.Items[Index].ScaleLinesShow            := XAxis[x].ScaleLinesShow;
          FMaster.XAxisManager.Items[Index].ScaleLinesColor           := XAxis[x].ScaleLinesColor;
          FMaster.XAxisManager.Items[Index].MajorLength               := XAxis[x].MajorLength;
          FMaster.XAxisManager.Items[Index].MinorCount                := XAxis[x].MinorCount;
          FMaster.XAxisManager.Items[Index].MinorLength               := XAxis[x].MinorLength;
          FMaster.XAxisManager.Items[Index].LabelsVisible             := XAxis[x].LabelsVisible;
          FMaster.XAxisManager.Items[Index].LabelsMargin              := XAxis[x].LabelsMargin;
          FMaster.XAxisManager.Items[Index].LabelSeparation           := XAxis[x].LabelSeparation;
          FMaster.XAxisManager.Items[Index].StackingEndsMargin        := XAxis[x].StackingEndsMargin;
          FMaster.XAxisManager.Items[Index].ForceStacking             := XAxis[x].ForceStacking;
          FMaster.XAxisManager.Items[Index].Title                     := XAxis[x].Title;
          FMaster.XAxisManager.Items[Index].TitleShow                 := XAxis[x].TitleShow;
          FMaster.XAxisManager.Items[Index].TitleRotated              := XAxis[x].TitleRotated;
          FMaster.XAxisManager.Items[Index].TitleMargin               := XAxis[x].TitleMargin;
          FMaster.XAxisManager.Items[Index].TrackingEnabled           := XAxis[x].TrackingEnabled;
          FMaster.XAxisManager.Items[Index].TrackingStyle             := XAxis[x].TrackingStyle;
          FMaster.XAxisManager.Items[Index].TrackingIncrementStyle    := XAxis[x].TrackingIncrementStyle;
          FMaster.XAxisManager.Items[Index].TrackingAlignFirstStyle   := XAxis[x].TrackingAlignFirstStyle;
          FMaster.XAxisManager.Items[Index].TrackingScrollCompressMax := XAxis[x].TrackingScrollCompressMax;
          FMaster.XAxisManager.Items[Index].TrackingSpanMinimum       := XAxis[x].TrackingSpanMinimum;
          FMaster.XAxisManager.Items[Index].TrackingMaxMargin         := XAxis[x].TrackingMaxMargin;
          FMaster.XAxisManager.Items[Index].TrackingMinMargin         := XAxis[x].TrackingMinMargin;
          FMaster.XAxisManager.Items[Index].CursorScaler              := XAxis[x].CursorScaler;

          FMaster.XAxisManager.Items[Index].LabelsRotation            := XAxis[x].LabelsRotation;
          FMaster.XAxisManager.Items[Index].LabelsFormatStyle         := XAxis[x].LabelsFormatStyle;
          FMaster.XAxisManager.Items[Index].DateTimeFormat            := XAxis[x].DateTimeFormat;
          FMaster.XAxisManager.Items[Index].LabelsPrecisionStyle      := XAxis[x].LabelsPrecisionStyle;
          FMaster.XAxisManager.Items[Index].LabelsPrecision           := XAxis[x].LabelsPrecision;
          FMaster.XAxisManager.Items[Index].LabelsMinLength           := XAxis[x].LabelsMinLength;
          FMaster.XAxisManager.Items[Index].LabelsMinLengthAutoAdjust := XAxis[x].LabelsMinLengthAutoAdjust;

          FMaster.XAxisManager.Items[Index].CursorUseDefaultFormat    := XAxis[x].CursorUseDefaultFormat;
          FMaster.XAxisManager.Items[Index].CursorFormatStyle         := XAxis[x].CursorFormatStyle;
          FMaster.XAxisManager.Items[Index].CursorDateTimeFormat      := XAxis[x].CursorDateTimeFormat;
          FMaster.XAxisManager.Items[Index].CursorPrecisionStyle      := XAxis[x].CursorPrecisionStyle;
          FMaster.XAxisManager.Items[Index].CursorPrecision           := XAxis[x].CursorPrecision;
          FMaster.XAxisManager.Items[Index].CursorMinLength           := XAxis[x].CursorMinLength;
          FMaster.XAxisManager.Items[Index].CursorMinLengthAutoAdjust := XAxis[x].CursorMinLengthAutoAdjust;

          FMaster.XAxisManager.Items[Index].LegendUseDefaultFormat    := XAxis[x].LegendUseDefaultFormat;
          FMaster.XAxisManager.Items[Index].LegendFormatStyle         := XAxis[x].LegendFormatStyle;
          FMaster.XAxisManager.Items[Index].LegendDateTimeFormat      := XAxis[x].LegendDateTimeFormat;
          FMaster.XAxisManager.Items[Index].LegendPrecisionStyle      := XAxis[x].LegendPrecisionStyle;
          FMaster.XAxisManager.Items[Index].LegendPrecision           := XAxis[x].LegendPrecision;
          FMaster.XAxisManager.Items[Index].LegendMinLength           := XAxis[x].LegendMinLength;
          FMaster.XAxisManager.Items[Index].LegendMinLengthAutoAdjust := XAxis[x].LegendMinLengthAutoAdjust;

          FMaster.XAxisManager.Items[Index].ScrollMinMaxEnabled       := XAxis[x].ScrollMinMaxEnabled;
          FMaster.XAxisManager.Items[Index].ScrollMax                 := XAxis[x].ScrollMax;
          FMaster.XAxisManager.Items[Index].ScrollMin                 := XAxis[x].ScrollMin;

          FMaster.XAxisManager.Items[Index].ScaleType                 := XAxis[x].ScaleType;

          FMaster.XAxisManager.Items[Index].CartesianStyle            := XAxis[x].CartesianStyle;
          FMaster.XAxisManager.Items[Index].CartesianChildRefAxisName := XAxis[x].CartesianChildRefAxisName;
          FMaster.XAxisManager.Items[Index].CartesianChildRefValue    := XAxis[x].CartesianChildRefValue;

          FMaster.XAxisManager.Items[Index].AlignRefAxisName          := XAxis[x].AlignRefAxisName;

          FMaster.XAxisManager.Items[Index].TitleFont.Assign (XAxis[x].TitleFont);
          FMaster.XAxisManager.Items[Index].LabelsFont.Assign(XAxis[x].LabelsFont);
        end;
      //------------------ YAxis ------------------------------------
      for x := 0 to YAxisCount - 1 do
        begin
          Index := FMaster.AddYAxis;
          FMaster.YAxisManager.Items[Index].Name                      := YAxis[x].Name;
          FMaster.YAxisManager.Items[Index].Visible                   := YAxis[x].Visible;
          FMaster.YAxisManager.Items[Index].GridLinesVisible          := YAxis[x].GridLinesVisible;
          FMaster.YAxisManager.Items[Index].Enabled                   := YAxis[x].Enabled;
          FMaster.YAxisManager.Items[Index].PopupEnabled              := YAxis[x].PopupEnabled;
          FMaster.YAxisManager.Items[Index].MasterUIInput             := YAxis[x].MasterUIInput;
          FMaster.YAxisManager.Items[Index].UserCanEdit               := YAxis[x].UserCanEdit;
          FMaster.YAxisManager.Items[Index].CanFocus                  := YAxis[x].CanFocus;
          FMaster.YAxisManager.Items[Index].Layer                     := YAxis[x].Layer;

          FMaster.YAxisManager.Items[Index].ZOrder                    := YAxis[x].ZOrder;
          FMaster.YAxisManager.Items[Index].StartPercent              := YAxis[x].StartPercent;
          FMaster.YAxisManager.Items[Index].StopPercent               := YAxis[x].StopPercent;

          FMaster.YAxisManager.Items[Index].Min                       := YAxis[x].Min;
          FMaster.YAxisManager.Items[Index].Span                      := YAxis[x].Span;
          FMaster.YAxisManager.Items[Index].DesiredStart              := YAxis[x].DesiredStart;
          FMaster.YAxisManager.Items[Index].DesiredIncrement          := YAxis[x].DesiredIncrement;
          FMaster.YAxisManager.Items[Index].ReverseScale              := YAxis[x].ReverseScale;
          FMaster.YAxisManager.Items[Index].RestoreValuesOnResume     := YAxis[x].RestoreValuesOnResume;
          FMaster.YAxisManager.Items[Index].InnerMargin               := YAxis[x].InnerMargin;
          FMaster.YAxisManager.Items[Index].OuterMargin               := YAxis[x].OuterMargin;
          FMaster.YAxisManager.Items[Index].ScaleLinesShow            := YAxis[x].ScaleLinesShow;
          FMaster.YAxisManager.Items[Index].ScaleLinesColor           := YAxis[x].ScaleLinesColor;
          FMaster.YAxisManager.Items[Index].MajorLength               := YAxis[x].MajorLength;
          FMaster.YAxisManager.Items[Index].MinorCount                := YAxis[x].MinorCount;
          FMaster.YAxisManager.Items[Index].MinorLength               := YAxis[x].MinorLength;
          FMaster.YAxisManager.Items[Index].LabelsVisible             := YAxis[x].LabelsVisible;
          FMaster.YAxisManager.Items[Index].LabelsMargin              := YAxis[x].LabelsMargin;
          FMaster.YAxisManager.Items[Index].LabelSeparation           := YAxis[x].LabelSeparation;
          FMaster.YAxisManager.Items[Index].StackingEndsMargin        := YAxis[x].StackingEndsMargin;
          FMaster.YAxisManager.Items[Index].ForceStacking             := YAxis[x].ForceStacking;
          FMaster.YAxisManager.Items[Index].Title                     := YAxis[x].Title;
          FMaster.YAxisManager.Items[Index].TitleShow                 := YAxis[x].TitleShow;
          FMaster.YAxisManager.Items[Index].TitleRotated              := YAxis[x].TitleRotated;
          FMaster.YAxisManager.Items[Index].TitleMargin               := YAxis[x].TitleMargin;
          FMaster.YAxisManager.Items[Index].TrackingEnabled           := YAxis[x].TrackingEnabled;
          FMaster.YAxisManager.Items[Index].TrackingStyle             := YAxis[x].TrackingStyle;
          FMaster.YAxisManager.Items[Index].TrackingIncrementStyle    := YAxis[x].TrackingIncrementStyle;
          FMaster.YAxisManager.Items[Index].TrackingAlignFirstStyle   := YAxis[x].TrackingAlignFirstStyle;
          FMaster.YAxisManager.Items[Index].TrackingScrollCompressMax := YAxis[x].TrackingScrollCompressMax;
          FMaster.YAxisManager.Items[Index].TrackingSpanMinimum       := YAxis[x].TrackingSpanMinimum;
          FMaster.YAxisManager.Items[Index].TrackingMaxMargin         := YAxis[x].TrackingMaxMargin;
          FMaster.YAxisManager.Items[Index].TrackingMinMargin         := YAxis[x].TrackingMinMargin;
          FMaster.YAxisManager.Items[Index].CursorScaler              := YAxis[x].CursorScaler;

          FMaster.YAxisManager.Items[Index].LabelsRotation            := YAxis[x].LabelsRotation;
          FMaster.YAxisManager.Items[Index].LabelsFormatStyle         := YAxis[x].LabelsFormatStyle;
          FMaster.YAxisManager.Items[Index].DateTimeFormat            := YAxis[x].DateTimeFormat;
          FMaster.YAxisManager.Items[Index].LabelsPrecisionStyle      := YAxis[x].LabelsPrecisionStyle;
          FMaster.YAxisManager.Items[Index].LabelsPrecision           := YAxis[x].LabelsPrecision;
          FMaster.YAxisManager.Items[Index].LabelsMinLength           := YAxis[x].LabelsMinLength;
          FMaster.YAxisManager.Items[Index].LabelsMinLengthAutoAdjust := YAxis[x].LabelsMinLengthAutoAdjust;

          FMaster.YAxisManager.Items[Index].CursorUseDefaultFormat    := YAxis[x].CursorUseDefaultFormat;
          FMaster.YAxisManager.Items[Index].CursorFormatStyle         := YAxis[x].CursorFormatStyle;
          FMaster.YAxisManager.Items[Index].CursorDateTimeFormat      := YAxis[x].CursorDateTimeFormat;
          FMaster.YAxisManager.Items[Index].CursorPrecisionStyle      := YAxis[x].CursorPrecisionStyle;
          FMaster.YAxisManager.Items[Index].CursorPrecision           := YAxis[x].CursorPrecision;
          FMaster.YAxisManager.Items[Index].CursorMinLength           := YAxis[x].CursorMinLength;
          FMaster.YAxisManager.Items[Index].CursorMinLengthAutoAdjust := YAxis[x].CursorMinLengthAutoAdjust;

          FMaster.YAxisManager.Items[Index].LegendUseDefaultFormat    := YAxis[x].LegendUseDefaultFormat;
          FMaster.YAxisManager.Items[Index].LegendFormatStyle         := YAxis[x].LegendFormatStyle;
          FMaster.YAxisManager.Items[Index].LegendDateTimeFormat      := YAxis[x].LegendDateTimeFormat;
          FMaster.YAxisManager.Items[Index].LegendPrecisionStyle      := YAxis[x].LegendPrecisionStyle;
          FMaster.YAxisManager.Items[Index].LegendPrecision           := YAxis[x].LegendPrecision;
          FMaster.YAxisManager.Items[Index].LegendMinLength           := YAxis[x].LegendMinLength;
          FMaster.YAxisManager.Items[Index].LegendMinLengthAutoAdjust := YAxis[x].LegendMinLengthAutoAdjust;

          FMaster.YAxisManager.Items[Index].ScrollMinMaxEnabled       := YAxis[x].ScrollMinMaxEnabled;
          FMaster.YAxisManager.Items[Index].ScrollMax                 := YAxis[x].ScrollMax;
          FMaster.YAxisManager.Items[Index].ScrollMin                 := YAxis[x].ScrollMin;

          FMaster.YAxisManager.Items[Index].ScaleType                 := YAxis[x].ScaleType;

          FMaster.YAxisManager.Items[Index].CartesianStyle            := YAxis[x].CartesianStyle;
          FMaster.YAxisManager.Items[Index].CartesianChildRefAxisName := YAxis[x].CartesianChildRefAxisName;
          FMaster.YAxisManager.Items[Index].CartesianChildRefValue    := YAxis[x].CartesianChildRefValue;

          FMaster.YAxisManager.Items[Index].AlignRefAxisName          := YAxis[x].AlignRefAxisName;

          FMaster.YAxisManager.Items[Index].TitleFont.Assign (YAxis[x].TitleFont);
          FMaster.YAxisManager.Items[Index].LabelsFont.Assign(YAxis[x].LabelsFont);
        end;
      //------------------ Data View ---------------------------
      for x := 0 to DataViewCount - 1 do
        begin
          Index := FMaster.AddDataView;
          FMaster.DataViewManager.Items[Index].Name                         := DataView[x].Name;
          FMaster.DataViewManager.Items[Index].Visible                      := DataView[x].Visible;
          FMaster.DataViewManager.Items[Index].Enabled                      := DataView[x].Enabled;
          FMaster.DataViewManager.Items[Index].PopupEnabled                 := DataView[x].PopupEnabled;
          FMaster.DataViewManager.Items[Index].UserCanEdit                  := DataView[x].UserCanEdit;
          FMaster.DataViewManager.Items[Index].CanFocus                     := DataView[x].CanFocus;
          FMaster.DataViewManager.Items[Index].Layer                        := DataView[x].Layer;

          FMaster.DataViewManager.Items[Index].BackgroundTransparent        := DataView[x].BackgroundTransparent;
          FMaster.DataViewManager.Items[Index].BackgroundColor              := DataView[x].BackgroundColor;
          FMaster.DataViewManager.Items[Index].GridXAxisName                := DataView[x].GridXAxisName;
          FMaster.DataViewManager.Items[Index].GridYAxisName                := DataView[x].GridYAxisName;
          FMaster.DataViewManager.Items[Index].AxesControlEnabled           := DataView[x].AxesControlEnabled;
          FMaster.DataViewManager.Items[Index].AxesControlAllowInSelectMode := DataView[x].AxesControlAllowInSelectMode;
          FMaster.DataViewManager.Items[Index].AxesControlMouseStyle        := DataView[x].AxesControlMouseStyle;
          FMaster.DataViewManager.Items[Index].AxesControlWheelStyle        := DataView[x].AxesControlWheelStyle;

          FMaster.DataViewManager.Items[Index].GridShow                     := DataView[x].GridShow;
          FMaster.DataViewManager.Items[Index].GridLineColor                := DataView[x].GridLineColor;
          FMaster.DataViewManager.Items[Index].GridLineShowLeft             := DataView[x].GridLineShowLeft;
          FMaster.DataViewManager.Items[Index].GridLineShowTop              := DataView[x].GridLineShowTop;
          FMaster.DataViewManager.Items[Index].GridLineShowRight            := DataView[x].GridLineShowRight;
          FMaster.DataViewManager.Items[Index].GridLineShowBottom           := DataView[x].GridLineShowBottom;
          FMaster.DataViewManager.Items[Index].GridLineShowXMajors          := DataView[x].GridLineShowXMajors;
          FMaster.DataViewManager.Items[Index].GridLineShowXMinors          := DataView[x].GridLineShowXMinors;
          FMaster.DataViewManager.Items[Index].GridLineShowYMajors          := DataView[x].GridLineShowYMajors;
          FMaster.DataViewManager.Items[Index].GridLineShowYMinors          := DataView[x].GridLineShowYMinors;
          FMaster.DataViewManager.Items[Index].GridLineMajorStyle           := DataView[x].GridLineMajorStyle;
          FMaster.DataViewManager.Items[Index].GridLineMinorStyle           := DataView[x].GridLineMinorStyle;

          FMaster.DataViewManager.Items[Index].GridLineXMajorCustom         := DataView[x].GridLineXMajorCustom;
          FMaster.DataViewManager.Items[Index].GridLineXMajorColor          := DataView[x].GridLineXMajorColor;
          FMaster.DataViewManager.Items[Index].GridLineXMajorWidth          := DataView[x].GridLineXMajorWidth;
          FMaster.DataViewManager.Items[Index].GridLineXMajorStyle          := DataView[x].GridLineXMajorStyle;

          FMaster.DataViewManager.Items[Index].GridLineXMinorCustom         := DataView[x].GridLineXMinorCustom;
          FMaster.DataViewManager.Items[Index].GridLineXMinorColor          := DataView[x].GridLineXMinorColor;
          FMaster.DataViewManager.Items[Index].GridLineXMinorWidth          := DataView[x].GridLineXMinorWidth;
          FMaster.DataViewManager.Items[Index].GridLineXMinorStyle          := DataView[x].GridLineXMinorStyle;

          FMaster.DataViewManager.Items[Index].GridLineYMajorCustom         := DataView[x].GridLineYMajorCustom;
          FMaster.DataViewManager.Items[Index].GridLineYMajorColor          := DataView[x].GridLineYMajorColor;
          FMaster.DataViewManager.Items[Index].GridLineYMajorWidth          := DataView[x].GridLineYMajorWidth;
          FMaster.DataViewManager.Items[Index].GridLineYMajorStyle          := DataView[x].GridLineYMajorStyle;

          FMaster.DataViewManager.Items[Index].GridLineYMinorCustom         := DataView[x].GridLineYMinorCustom;
          FMaster.DataViewManager.Items[Index].GridLineYMinorColor          := DataView[x].GridLineYMinorColor;
          FMaster.DataViewManager.Items[Index].GridLineYMinorWidth          := DataView[x].GridLineYMinorWidth;
          FMaster.DataViewManager.Items[Index].GridLineYMinorStyle          := DataView[x].GridLineYMinorStyle;
        end;
      //------------------ Channels ------------------------------------
      for x := 0 to ChannelCount - 1 do
        begin
          Index := FMaster.AddChannel;
          FMaster.ChannelManager.Items[Index].Name                        := Channel[x].Name;
          FMaster.ChannelManager.Items[Index].Visible                     := Channel[x].Visible;
          FMaster.ChannelManager.Items[Index].Enabled                     := Channel[x].Enabled;
          FMaster.ChannelManager.Items[Index].PopupEnabled                := Channel[x].PopupEnabled;
          FMaster.ChannelManager.Items[Index].UserCanEdit                 := Channel[x].UserCanEdit;
          FMaster.ChannelManager.Items[Index].CanFocus                    := Channel[x].CanFocus;
          FMaster.ChannelManager.Items[Index].Layer                       := Channel[x].Layer;

          FMaster.ChannelManager.Items[Index].VisibleInLegend             := Channel[x].VisibleInLegend;
          FMaster.ChannelManager.Items[Index].ShowDataPointHints          := Channel[x].ShowDataPointHints;
          FMaster.ChannelManager.Items[Index].UserCanMoveDataPoints       := Channel[x].UserCanMoveDataPoints;
          FMaster.ChannelManager.Items[Index].UserCanMoveDataPointsStyle  := Channel[x].UserCanMoveDataPointsStyle;
          FMaster.ChannelManager.Items[Index].TitleText                   := Channel[x].TitleText;
          FMaster.ChannelManager.Items[Index].Color                       := Channel[x].Color;
          FMaster.ChannelManager.Items[Index].RingBufferSize              := Channel[x].RingBufferSize;
          FMaster.ChannelManager.Items[Index].TraceLineStyle              := Channel[x].TraceLineStyle;
          FMaster.ChannelManager.Items[Index].TraceLineWidth              := Channel[x].TraceLineWidth;
          FMaster.ChannelManager.Items[Index].TraceVisible                := Channel[x].TraceVisible;
          FMaster.ChannelManager.Items[Index].XAxisName                   := Channel[x].XAxisName;
          FMaster.ChannelManager.Items[Index].YAxisName                   := Channel[x].YAxisName;
          FMaster.ChannelManager.Items[Index].XAxisTrackingEnabled        := Channel[x].XAxisTrackingEnabled;
          FMaster.ChannelManager.Items[Index].YAxisTrackingEnabled        := Channel[x].YAxisTrackingEnabled;
          FMaster.ChannelManager.Items[Index].DataStyle                   := Channel[x].DataStyle;

          FMaster.ChannelManager.Items[Index].MarkersVisible              := Channel[x].MarkersVisible;
          FMaster.ChannelManager.Items[Index].MarkersAllowIndividual      := Channel[x].MarkersAllowIndividual;
          FMaster.ChannelManager.Items[Index].MarkersSize                 := Channel[x].MarkersSize;
          FMaster.ChannelManager.Items[Index].MarkersStyle                := Channel[x].MarkersStyle;
          FMaster.ChannelManager.Items[Index].MarkersPenColor             := Channel[x].MarkersPenColor;
          FMaster.ChannelManager.Items[Index].MarkersPenUseChannelColor   := Channel[x].MarkersPenUseChannelColor;
          FMaster.ChannelManager.Items[Index].MarkersPenStyle             := Channel[x].MarkersPenStyle;
          FMaster.ChannelManager.Items[Index].MarkersPenWidth             := Channel[x].MarkersPenWidth;
          FMaster.ChannelManager.Items[Index].MarkersBrushColor           := Channel[x].MarkersBrushColor;
          FMaster.ChannelManager.Items[Index].MarkersBrushUseChannelColor := Channel[x].MarkersBrushUseChannelColor;
          FMaster.ChannelManager.Items[Index].MarkersBrushStyle           := Channel[x].MarkersBrushStyle;
          FMaster.ChannelManager.Items[Index].MarkersTurnOffLimit         := Channel[x].MarkersTurnOffLimit;

          FMaster.ChannelManager.Items[Index].LogFileName                 := Channel[x].LogFileName;
          FMaster.ChannelManager.Items[Index].LogBufferSize               := Channel[x].LogBufferSize;

          FMaster.ChannelManager.Items[Index].MarkersFont.Assign(Channel[x].MarkersFont);

          {$IFDEF iCLX}
          ChannelOPCTabSheet.TabVisible := False;
          {$endif}

          if Channel[x] is TiXYPlotChannel then
            begin
              {$IFDEF iVCL}
              (FMaster.ChannelManager.Items[Index] as TiXYPlotChannel).OPCItem2Name          := (Channel[x] as TiXYPlotChannel).OPCItem2Name;
              (FMaster.ChannelManager.Items[Index] as TiXYPlotChannel).OPCComputerName       := (Channel[x] as TiXYPlotChannel).OPCComputerName;
              (FMaster.ChannelManager.Items[Index] as TiXYPlotChannel).OPCServerName         := (Channel[x] as TiXYPlotChannel).OPCServerName;
              (FMaster.ChannelManager.Items[Index] as TiXYPlotChannel).OPCItemName           := (Channel[x] as TiXYPlotChannel).OPCItemName;
              (FMaster.ChannelManager.Items[Index] as TiXYPlotChannel).OPCUpdateRate         := (Channel[x] as TiXYPlotChannel).OPCUpdateRate;
              (FMaster.ChannelManager.Items[Index] as TiXYPlotChannel).OPCScalar             := (Channel[x] as TiXYPlotChannel).OPCScalar;
              (FMaster.ChannelManager.Items[Index] as TiXYPlotChannel).OPCOffset             := (Channel[x] as TiXYPlotChannel).OPCOffset;
              (FMaster.ChannelManager.Items[Index] as TiXYPlotChannel).OPCScalar2            := (Channel[x] as TiXYPlotChannel).OPCScalar2;
              (FMaster.ChannelManager.Items[Index] as TiXYPlotChannel).OPCOffset2            := (Channel[x] as TiXYPlotChannel).OPCOffset2;
              (FMaster.ChannelManager.Items[Index] as TiXYPlotChannel).OPCAutoConnect        := (Channel[x] as TiXYPlotChannel).OPCAutoConnect;
              {$endif}
            end;

          if Channel[x] is TiPlotChannel then
            begin
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).FillEnabled                    := (Channel[x] as TiPlotChannel).FillEnabled;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).FillReference                  := (Channel[x] as TiPlotChannel).FillReference;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).FillStyle                      := (Channel[x] as TiPlotChannel).FillStyle;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).FillColor                      := (Channel[x] as TiPlotChannel).FillColor;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).FillUseChannelColor            := (Channel[x] as TiPlotChannel).FillUseChannelColor;

              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).BarEnabled                     := (Channel[x] as TiPlotChannel).BarEnabled;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).BarWidth                       := (Channel[x] as TiPlotChannel).BarWidth;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).BarReference                   := (Channel[x] as TiPlotChannel).BarReference;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).BarPenColor                    := (Channel[x] as TiPlotChannel).BarPenColor;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).BarPenUseChannelColor          := (Channel[x] as TiPlotChannel).BarPenUseChannelColor;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).BarPenStyle                    := (Channel[x] as TiPlotChannel).BarPenStyle;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).BarPenWidth                    := (Channel[x] as TiPlotChannel).BarPenWidth;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).BarBrushColor                  := (Channel[x] as TiPlotChannel).BarBrushColor;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).BarBrushUseChannelColor        := (Channel[x] as TiPlotChannel).BarBrushUseChannelColor;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).BarBrushStyle                  := (Channel[x] as TiPlotChannel).BarBrushStyle;

              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowStyle                   := (Channel[x] as TiPlotChannel).HighLowStyle;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowEnabled                 := (Channel[x] as TiPlotChannel).HighLowEnabled;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowBarColor                := (Channel[x] as TiPlotChannel).HighLowBarColor;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowBarWidth                := (Channel[x] as TiPlotChannel).HighLowBarWidth;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowOpenShow                := (Channel[x] as TiPlotChannel).HighLowOpenShow;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowOpenColor               := (Channel[x] as TiPlotChannel).HighLowOpenColor;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowOpenWidth               := (Channel[x] as TiPlotChannel).HighLowOpenWidth;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowOpenHeight              := (Channel[x] as TiPlotChannel).HighLowOpenHeight;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowCloseShow               := (Channel[x] as TiPlotChannel).HighLowCloseShow;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowCloseColor              := (Channel[x] as TiPlotChannel).HighLowCloseColor;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowCloseWidth              := (Channel[x] as TiPlotChannel).HighLowCloseWidth;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowCloseHeight             := (Channel[x] as TiPlotChannel).HighLowCloseHeight;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowShadowColor             := (Channel[x] as TiPlotChannel).HighLowShadowColor;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowBullishColor            := (Channel[x] as TiPlotChannel).HighLowBullishColor;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).HighLowBearishColor            := (Channel[x] as TiPlotChannel).HighLowBearishColor;

              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).DigitalEnabled                 := (Channel[x] as TiPlotChannel).DigitalEnabled;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).DigitalReferenceHigh           := (Channel[x] as TiPlotChannel).DigitalReferenceHigh;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).DigitalReferenceLow            := (Channel[x] as TiPlotChannel).DigitalReferenceLow;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).DigitalReferenceStyle          := (Channel[x] as TiPlotChannel).DigitalReferenceStyle;

              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).FastDrawEnabled                := (Channel[x] as TiPlotChannel).FastDrawEnabled;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).DrawOutOfOrderXValues          := (Channel[x] as TiPlotChannel).DrawOutOfOrderXValues;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).AllowOutOfOrderXValues         := (Channel[x] as TiPlotChannel).AllowOutOfOrderXValues;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).ResetStartTimeOnFirstDataPoint := (Channel[x] as TiPlotChannel).ResetStartTimeOnFirstDataPoint;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).ClipToAxes                     := (Channel[x] as TiPlotChannel).ClipToAxes;

              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).InterpolationStyle             := (Channel[x] as TiPlotChannel).InterpolationStyle;
              {$IFDEF iVCL}
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCXValueSource                := (Channel[x] as TiPlotChannel).OPCXValueSource;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCGroupName                   := (Channel[x] as TiPlotChannel).OPCGroupName;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCComputerName                := (Channel[x] as TiPlotChannel).OPCComputerName;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCServerName                  := (Channel[x] as TiPlotChannel).OPCServerName;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCItemName                    := (Channel[x] as TiPlotChannel).OPCItemName;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCUpdateRate                  := (Channel[x] as TiPlotChannel).OPCUpdateRate;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCScalar                      := (Channel[x] as TiPlotChannel).OPCScalar;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCOffset                      := (Channel[x] as TiPlotChannel).OPCOffset;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCAutoConnect                 := (Channel[x] as TiPlotChannel).OPCAutoConnect;

              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCItem2Name                   := (Channel[x] as TiPlotChannel).OPCItem2Name;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCScalar2                     := (Channel[x] as TiPlotChannel).OPCScalar2;
              (FMaster.ChannelManager.Items[Index] as TiPlotChannel).OPCOffset2                     := (Channel[x] as TiPlotChannel).OPCOffset2;
              {$endif}
            end;
        end;
      //------------------ Data Cursor ---------------------------
      for x := 0 to DataCursorCount - 1 do
        begin
          Index := FMaster.AddDataCursor;
          FMaster.DataCursorManager.Items[Index].Name                         := DataCursor[x].Name;
          FMaster.DataCursorManager.Items[Index].Visible                      := DataCursor[x].Visible;
          FMaster.DataCursorManager.Items[Index].Enabled                      := DataCursor[x].Enabled;
          FMaster.DataCursorManager.Items[Index].PopupEnabled                 := DataCursor[x].PopupEnabled;
          FMaster.DataCursorManager.Items[Index].UserCanEdit                  := DataCursor[x].UserCanEdit;
          FMaster.DataCursorManager.Items[Index].CanFocus                     := DataCursor[x].CanFocus;
          FMaster.DataCursorManager.Items[Index].SnapToDataPoint              := DataCursor[x].SnapToDataPoint;
          FMaster.DataCursorManager.Items[Index].UseCachedInterpolatedData    := DataCursor[x].UseCachedInterpolatedData;
          FMaster.DataCursorManager.Items[Index].Layer                        := DataCursor[x].Layer;

          FMaster.DataCursorManager.Items[Index].Style                        := DataCursor[x].Style;
          FMaster.DataCursorManager.Items[Index].Color                        := DataCursor[x].Color;
          FMaster.DataCursorManager.Items[Index].UseChannelColor              := DataCursor[x].UseChannelColor;
          FMaster.DataCursorManager.Items[Index].HintPosition                 := DataCursor[x].HintPosition;
          FMaster.DataCursorManager.Items[Index].HintShow                     := DataCursor[x].HintShow;
          FMaster.DataCursorManager.Items[Index].HintHideOnRelease            := DataCursor[x].HintHideOnRelease;
          FMaster.DataCursorManager.Items[Index].HintOrientationSide          := DataCursor[x].HintOrientationSide;
          FMaster.DataCursorManager.Items[Index].Pointer1Position             := DataCursor[x].Pointer1Position;
          FMaster.DataCursorManager.Items[Index].Pointer2Position             := DataCursor[x].Pointer2Position;
          FMaster.DataCursorManager.Items[Index].PointerPenWidth              := DataCursor[x].PointerPenWidth;

          FMaster.DataCursorManager.Items[Index].MenuItemVisibleValueXY       := DataCursor[x].MenuItemVisibleValueXY;
          FMaster.DataCursorManager.Items[Index].MenuItemVisibleValueX        := DataCursor[x].MenuItemVisibleValueX;
          FMaster.DataCursorManager.Items[Index].MenuItemVisibleValueY        := DataCursor[x].MenuItemVisibleValueY;
          FMaster.DataCursorManager.Items[Index].MenuItemVisibleDeltaX        := DataCursor[x].MenuItemVisibleDeltaX;
          FMaster.DataCursorManager.Items[Index].MenuItemVisibleDeltaY        := DataCursor[x].MenuItemVisibleDeltaY;
          FMaster.DataCursorManager.Items[Index].MenuItemVisibleInverseDeltaX := DataCursor[x].MenuItemVisibleInverseDeltaX;

          FMaster.DataCursorManager.Items[Index].MenuItemCaptionValueXY       := DataCursor[x].MenuItemCaptionValueXY;
          FMaster.DataCursorManager.Items[Index].MenuItemCaptionValueX        := DataCursor[x].MenuItemCaptionValueX;
          FMaster.DataCursorManager.Items[Index].MenuItemCaptionValueY        := DataCursor[x].MenuItemCaptionValueY;
          FMaster.DataCursorManager.Items[Index].MenuItemCaptionDeltaX        := DataCursor[x].MenuItemCaptionDeltaX;
          FMaster.DataCursorManager.Items[Index].MenuItemCaptionDeltaY        := DataCursor[x].MenuItemCaptionDeltaY;
          FMaster.DataCursorManager.Items[Index].MenuItemCaptionInverseDeltaX := DataCursor[x].MenuItemCaptionInverseDeltaX;

          FMaster.DataCursorManager.Items[Index].MenuUserCanChangeOptions     := DataCursor[x].MenuUserCanChangeOptions;

          FMaster.DataCursorManager.Items[Index].ChannelName                  := DataCursor[x].ChannelName;
          FMaster.DataCursorManager.Items[Index].ChannelAllowAll              := DataCursor[x].ChannelAllowAll;
          FMaster.DataCursorManager.Items[Index].ChannelShowAllInLegend       := DataCursor[x].ChannelShowAllInLegend;

          FMaster.DataCursorManager.Items[Index].Font.Assign(DataCursor[x].Font);
        end;
      //------------------ Limit ---------------------------
      for x := 0 to LimitCount - 1 do
        begin
          Index := FMaster.AddLimit;
          FMaster.LimitManager.Items[Index].Name                      := Limit[x].Name;
          FMaster.LimitManager.Items[Index].Visible                   := Limit[x].Visible;
          FMaster.LimitManager.Items[Index].UserCanMove               := Limit[x].UserCanMove;
          FMaster.LimitManager.Items[Index].ClipToAxes                := Limit[x].ClipToAxes;
          FMaster.LimitManager.Items[Index].Enabled                   := Limit[x].Enabled;
          FMaster.LimitManager.Items[Index].PopupEnabled              := Limit[x].PopupEnabled;
          FMaster.LimitManager.Items[Index].UserCanEdit               := Limit[x].UserCanEdit;
          FMaster.LimitManager.Items[Index].SelectModeOnlyInteraction := Limit[x].SelectModeOnlyInteraction;
          FMaster.LimitManager.Items[Index].CanFocus                  := Limit[x].CanFocus;
          FMaster.LimitManager.Items[Index].Layer                     := Limit[x].Layer;

          FMaster.LimitManager.Items[Index].Color                     := Limit[x].Color;
          FMaster.LimitManager.Items[Index].LineStyle                 := Limit[x].LineStyle;
          FMaster.LimitManager.Items[Index].LineWidth                 := Limit[x].LineWidth;
          FMaster.LimitManager.Items[Index].FillStyle                 := Limit[x].FillStyle;
          FMaster.LimitManager.Items[Index].XAxisName                 := Limit[x].XAxisName;
          FMaster.LimitManager.Items[Index].YAxisName                 := Limit[x].YAxisName;
          FMaster.LimitManager.Items[Index].Style                     := Limit[x].Style;
          FMaster.LimitManager.Items[Index].Line1Position             := Limit[x].Line1Position;
          FMaster.LimitManager.Items[Index].Line2Position             := Limit[x].Line2Position;
        end;
      //------------------ Label ---------------------------
      for x := 0 to LabelCount - 1 do
        begin
          Index := FMaster.AddLabel;
          FMaster.LabelManager.Items[Index].Name           := Labels[x].Name;
          FMaster.LabelManager.Items[Index].Visible        := Labels[x].Visible;
          FMaster.LabelManager.Items[Index].Enabled        := Labels[x].Enabled;
          FMaster.LabelManager.Items[Index].PopupEnabled   := Labels[x].PopupEnabled;
          FMaster.LabelManager.Items[Index].UserCanEdit    := Labels[x].UserCanEdit;
          FMaster.LabelManager.Items[Index].CanFocus       := Labels[x].CanFocus;
          FMaster.LabelManager.Items[Index].Layer          := Labels[x].Layer;

          FMaster.LabelManager.Items[Index].ZOrder         := Labels[x].ZOrder;
          FMaster.LabelManager.Items[Index].StartPercent   := Labels[x].StartPercent;
          FMaster.LabelManager.Items[Index].StopPercent    := Labels[x].StopPercent;
          FMaster.LabelManager.Items[Index].Horizontal     := Labels[x].Horizontal;

          FMaster.LabelManager.Items[Index].Caption        := Labels[x].Caption;
          FMaster.LabelManager.Items[Index].MarginLeft     := Labels[x].MarginLeft;
          FMaster.LabelManager.Items[Index].MarginTop      := Labels[x].MarginTop;
          FMaster.LabelManager.Items[Index].MarginRight    := Labels[x].MarginRight;
          FMaster.LabelManager.Items[Index].MarginBottom   := Labels[x].MarginBottom;
          FMaster.LabelManager.Items[Index].Alignment      := Labels[x].Alignment;
          FMaster.LabelManager.Items[Index].ImageListIndex := Labels[x].ImageListIndex;
          FMaster.LabelManager.Items[Index].ImageIndex     := Labels[x].ImageIndex;

          FMaster.LabelManager.Items[Index].Font.Assign(Labels[x].Font);
        end;
      //---------------------------------------------------------
      AList := TStringList.Create;
      try
        AList.Sorted := True;
        for x := 0 to TranslationCount - 1 do
          begin
            iTranslation := TiPlotTranslationObject.Create(nil, nil);
            iTranslation.OriginalString    := GetTranslationOriginalString(x);
            iTranslation.ReplacementString := GetTranslationReplacementString(x);

            AList.AddObject(iTranslation.OriginalString, iTranslation);
          end;

        for x := 0 to AList.Count-1 do
          begin
            Index := FMaster.AddTranslation;
            FMaster.TranslationManager.Items[Index].OriginalString    := (AList.Objects[x] as TiPlotTranslationObject).OriginalString;
            FMaster.TranslationManager.Items[Index].ReplacementString := (AList.Objects[x] as TiPlotTranslationObject).ReplacementString;
          end;

        while AList.Count <> 0 do
          begin
            AList.Objects[0].Free;
            AList.Delete(0);
          end;
      finally
        AList.Free;
      end;
      //---------------------------------------------------------
    end;

  FMaster.LayOutManager.Enabled := True;

  if ToolBarListBox.Items.Count     > FLastToolBarIndex     then ToolBarListBox.ItemIndex     := FLastToolBarIndex;
  if LegendListBox.Items.Count      > FLastLegendIndex      then LegendListBox.ItemIndex      := FLastLegendIndex;
  if TableListBox.Items.Count       > FLastTableIndex       then TableListBox.ItemIndex       := FLastTableIndex;
  if XAxisListBox.Items.Count       > FLastXAxisIndex       then XAxisListBox.ItemIndex       := FLastXAxisIndex;
  if YAxisListBox.Items.Count       > FLastYAxisIndex       then YAxisListBox.ItemIndex       := FLastYAxisIndex;
  if DataViewListBox.Items.Count    > FLastDataViewIndex    then DataViewListBox.ItemIndex    := FLastDataViewIndex;
  if ChannelListBox.Items.Count     > FLastChannelIndex     then ChannelListBox.ItemIndex     := FLastChannelIndex;
  if DataCursorListBox.Items.Count  > FLastDataCursorIndex  then DataCursorListBox.ItemIndex  := FLastDataCursorIndex;
  if LimitListBox.Items.Count       > FLastLimitIndex       then LimitListBox.ItemIndex       := FLastLimitIndex;
  if LabelListBox.Items.Count       > FLastLabelIndex       then LabelListBox.ItemIndex       := FLastLabelIndex;
  if TranslationListBox.Items.Count > FLastTranslationIndex then TranslationListBox.ItemIndex := FLastTranslationIndex;

  UpdateToolBarEdit;
  UpdateLegendEdit;
  UpdateTableEdit;
  UpdateXAxesEdit;
  UpdateYAxesEdit;
  UpdateDataViewEdit;
  UpdateChannelEdit;
  UpdateDataCursorEdit;
  UpdateLimitEdit;
  UpdateLabelEdit;
  UpdateTranslationEdit;

  ChannelChange(Self);

  FTransferring := False;
  Modified      := False;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iPlotComponent : TiPlotComponent;
  Index          : Integer;
  x              : Integer;
  ChannelSource  : TiPlotChannelCustom;
  ChannelTarget  : TiPlotChannelCustom;
begin
  iPlotComponent := Component as TiPlotComponent;

  with iPlotComponent do
    begin
      RemoveAllToolBars;
      RemoveAllLegends;
      RemoveAllTables;
      RemoveAllXAxes;
      RemoveAllYAxes;
      RemoveAllDataViews;
      RemoveAllChannels;
      RemoveAllDataCursors;
      RemoveAllLimits;
      RemoveAllLabels;
      RemoveAllTranslations;

      DisableLayoutManager;

      XYAxesReverse                := FMaster.XYAxesReverse;
      DataViewZHorz                := FMaster.LayOutManager.DataViewHorz.ZOrder;
      DataViewZVert                := FMaster.LayOutManager.DataViewVert.ZOrder;

      AutoFrameRate                := AutoFrameRateCheckBox.AsBoolean;
      UpdateFrameRate              := UpdateFrameRateEdit.AsInteger;
      BorderStyle                  := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
      UserCanEditObjects           := UserCanEditObjectsCheckBox.AsBoolean;
      UserCanAddRemoveChannels     := UserCanAddRemoveCheckBox.AsBoolean;
      ClipAnnotationsToAxes        := ClipAnnotationsToAxesCheckBox.AsBoolean;
      EditorFormStyle              := TiPlotFormStyle(EditorFormStyleComboBox.AsInteger);
      CopyToClipBoardFormat        := TiPlotExportFormat(CopyToClipBoardFormatComboBox.AsInteger);
      DataFileColumnSeparator      := TiPlotDataFileColumnSeparator(DataFileColumnSeparatorComboBox.AsInteger);

      OuterMarginTop               := OuterMarginTopEdit.AsInteger;
      OuterMarginBottom            := OuterMarginBottomEdit.AsInteger;
      OuterMarginLeft              := OuterMarginLeftEdit.AsInteger;
      OuterMarginRight             := OuterMarginRightEdit.AsInteger;

      BackGroundColor              := BackGroundColorPicker.Color;
      BackGroundGradientDirection  := TiFillDirection(BackGroundGradientDirectionComboBox.AsInteger);
      BackGroundGradientEnabled    := BackGroundGradientEnabledCheckBox.AsBoolean;
      BackGroundGradientStartColor := BackGroundGradientStartColorPicker.Color;
      BackGroundGradientStopColor  := BackGroundGradientStopColorPicker.Color;

      LogFileName                  := ControlLogFileNameEdit.Text;
      LogBufferSize                := ControlLogBufferSizeEdit.AsInteger;

      HintsShow                    := HintsShowCheckBox.AsBoolean;
      HintsPause                   := HintsPauseEdit.AsInteger;
      HintsHidePause               := HintsHidePauseEdit.AsInteger;
      HintsFont.Assign(HintsFontPicker.Font);

      PrintOrientation             := TPrinterOrientation(PrintOrientationRadioGroup.AsInteger);
      PrintShowDialog              := PrintShowDialogCheckBox.AsBoolean;
      PrintMarginLeft              := PrintMarginLeftEdit.AsFloat;
      PrintMarginTop               := PrintMarginTopEdit.AsFloat;
      PrintMarginRight             := PrintMarginRightEdit.AsFloat;
      PrintMarginBottom            := PrintMarginBottomEdit.AsFloat;
      PrintDocumentName            := PrintDocumentNameEdit.AsString;

      AnnotationDefaultPenColor    :=  AnnotationDefaultPenColorPicker.Color;
      AnnotationDefaultPenStlye    :=  TPenStyle(AnnotationDefaultPenStyleComboBox.AsInteger);
      AnnotationDefaultPenWidth    :=  AnnotationDefaultPenWidthEdit.AsInteger;
      AnnotationDefaultBrushColor  :=  AnnotationDefaultBrushColorPicker.Color;
      AnnotationDefaultBrushStlye  :=  TBrushStyle(AnnotationDefaultBrushStyleComboBox.AsInteger);

      AnnotationDefaultReference          := TiPlotReferenceType      (AnnotationDefaultReferenceComboBox.AsInteger);
      AnnotationDefaultReferencePositionX := TiPlotReferenceIndividual(AnnotationDefaultReferencePositionXComboBox.AsInteger);
      AnnotationDefaultReferencePositionY := TiPlotReferenceIndividual(AnnotationDefaultReferencePositionYComboBox.AsInteger);
      AnnotationDefaultReferenceSizeX     := TiPlotReferenceIndividual(AnnotationDefaultReferenceSizeXComboBox.AsInteger);
      AnnotationDefaultReferenceSizeY     := TiPlotReferenceIndividual(AnnotationDefaultReferenceSizeYComboBox.AsInteger);

      ImageEditorPanel0.DownLoad(TiPlotComponentAccess(iPlotComponent).ImageList0);
      ImageEditorPanel1.DownLoad(TiPlotComponentAccess(iPlotComponent).ImageList1);
      ImageEditorPanel2.DownLoad(TiPlotComponentAccess(iPlotComponent).ImageList2);

      AnnotationDefaultFont.Assign(AnnotationDefaultFontPicker.Font);
      //------------------ Toolbar ----------------------------------
      for x := 0 to FMaster.ToolBarManager.Count-1 do
        begin
          Index := AddToolBar;
          ToolBar[Index].Name                 := FMaster.ToolBarManager.Items[x].Name;
          ToolBar[Index].Visible              := FMaster.ToolBarManager.Items[x].Visible;
          ToolBar[Index].Enabled              := FMaster.ToolBarManager.Items[x].Enabled;
          ToolBar[Index].PopupEnabled         := FMaster.ToolBarManager.Items[x].PopupEnabled;
          ToolBar[Index].UserCanEdit          := FMaster.ToolBarManager.Items[x].UserCanEdit;
          ToolBar[Index].Layer                := FMaster.ToolBarManager.Items[x].Layer;

          ToolBar[Index].ZOrder               := FMaster.ToolBarManager.Items[x].ZOrder;
          ToolBar[Index].Horizontal           := FMaster.ToolBarManager.Items[x].Horizontal;
          ToolBar[Index].StartPercent         := FMaster.ToolBarManager.Items[x].StartPercent;
          ToolBar[Index].StopPercent          := FMaster.ToolBarManager.Items[x].StopPercent;

          ToolBar[Index].ShowResumeButton     := FMaster.ToolBarManager.Items[x].ShowResumeButton;
          ToolBar[Index].ShowPauseButton      := FMaster.ToolBarManager.Items[x].ShowPauseButton;
          ToolBar[Index].ShowAxesModeButtons  := FMaster.ToolBarManager.Items[x].ShowAxesModeButtons;
          ToolBar[Index].ShowZoomInOutButtons := FMaster.ToolBarManager.Items[x].ShowZoomInOutButtons;
          ToolBar[Index].ShowSelectButton     := FMaster.ToolBarManager.Items[x].ShowSelectButton;
          ToolBar[Index].ShowZoomBoxButton    := FMaster.ToolBarManager.Items[x].ShowZoomBoxButton;
          ToolBar[Index].ShowCursorButton     := FMaster.ToolBarManager.Items[x].ShowCursorButton;
          ToolBar[Index].ShowEditButton       := FMaster.ToolBarManager.Items[x].ShowEditButton;
          ToolBar[Index].ShowCopyButton       := FMaster.ToolBarManager.Items[x].ShowCopyButton;
          ToolBar[Index].ShowSaveButton       := FMaster.ToolBarManager.Items[x].ShowSaveButton;
          ToolBar[Index].ShowPrintButton      := FMaster.ToolBarManager.Items[x].ShowPrintButton;
          ToolBar[Index].ShowPreviewButton    := FMaster.ToolBarManager.Items[x].ShowPreviewButton;
          ToolBar[Index].FlatBorder           := FMaster.ToolBarManager.Items[x].FlatBorder;
          ToolBar[Index].FlatButtons          := FMaster.ToolBarManager.Items[x].FlatButtons;
          ToolBar[Index].SmallButtons         := FMaster.ToolBarManager.Items[x].SmallButtons;

          ToolBar[Index].ZoomInOutFactor      := FMaster.ToolBarManager.Items[x].ZoomInOutFactor;
        end;
      //------------------ Legend -----------------------------------
      for x := 0 to FMaster.LegendManager.Count-1 do
        begin
          Index := AddLegend;
          Legend[Index].Name                    := FMaster.LegendManager.Items[x].Name;
          Legend[Index].Visible                 := FMaster.LegendManager.Items[x].Visible;
          Legend[Index].Enabled                 := FMaster.LegendManager.Items[x].Enabled;
          Legend[Index].PopupEnabled            := FMaster.LegendManager.Items[x].PopupEnabled;
          Legend[Index].UserCanEdit             := FMaster.LegendManager.Items[x].UserCanEdit;
          Legend[Index].CanFocus                := FMaster.LegendManager.Items[x].CanFocus;
          Legend[Index].Layer                   := FMaster.LegendManager.Items[x].Layer;

          Legend[Index].ZOrder                  := FMaster.LegendManager.Items[x].ZOrder;
          Legend[Index].Horizontal              := FMaster.LegendManager.Items[x].Horizontal;
          Legend[Index].StartPercent            := FMaster.LegendManager.Items[x].StartPercent;
          Legend[Index].StopPercent             := FMaster.LegendManager.Items[x].StopPercent;

          Legend[x].MarginLeft                  := FMaster.LegendManager.Items[Index].MarginLeft;
          Legend[x].MarginTop                   := FMaster.LegendManager.Items[Index].MarginTop;
          Legend[x].MarginRight                 := FMaster.LegendManager.Items[Index].MarginRight;
          Legend[x].MarginBottom                := FMaster.LegendManager.Items[Index].MarginBottom;

          Legend[x].ChannelNameMaxWidth         := FMaster.LegendManager.Items[Index].ChannelNameMaxWidth;
          Legend[x].ChannelNameColorStyle       := FMaster.LegendManager.Items[Index].ChannelNameColorStyle;
          Legend[x].LineColumnWidth             := FMaster.LegendManager.Items[Index].LineColumnWidth;
          Legend[x].LineColumnHeight            := FMaster.LegendManager.Items[Index].LineColumnHeight;
          Legend[x].RowSpacing                  := FMaster.LegendManager.Items[Index].RowSpacing;
          Legend[x].ColumnSpacing               := FMaster.LegendManager.Items[Index].ColumnSpacing;
          Legend[x].BackGroundTransparent       := FMaster.LegendManager.Items[Index].BackGroundTransparent;
          Legend[x].BackGroundColor             := FMaster.LegendManager.Items[Index].BackGroundColor;
          Legend[x].SelectedItemBackGroundColor := FMaster.LegendManager.Items[Index].SelectedItemBackGroundColor;

          Legend[x].ShowColumnLine              := FMaster.LegendManager.Items[Index].ShowColumnLine;
          Legend[x].ShowColumnMarker            := FMaster.LegendManager.Items[Index].ShowColumnMarker;
          Legend[x].ShowColumnXAxisTitle        := FMaster.LegendManager.Items[Index].ShowColumnXAxisTitle;
          Legend[x].ShowColumnYAxisTitle        := FMaster.LegendManager.Items[Index].ShowColumnYAxisTitle;
          Legend[x].ShowColumnXValue            := FMaster.LegendManager.Items[Index].ShowColumnXValue;
          Legend[x].ShowColumnYValue            := FMaster.LegendManager.Items[Index].ShowColumnYValue;
          Legend[x].ShowColumnYMax              := FMaster.LegendManager.Items[Index].ShowColumnYMax;
          Legend[x].ShowColumnYMin              := FMaster.LegendManager.Items[Index].ShowColumnYMin;
          Legend[x].ShowColumnYMean             := FMaster.LegendManager.Items[Index].ShowColumnYMean;

          Legend[x].ColumnTitlesVisible         := FMaster.LegendManager.Items[Index].ColumnTitlesVisible;

          Legend[x].CaptionColumnTitle          := FMaster.LegendManager.Items[Index].CaptionColumnTitle;
          Legend[x].CaptionColumnXAxisTitle     := FMaster.LegendManager.Items[Index].CaptionColumnXAxisTitle;
          Legend[x].CaptionColumnYAxisTitle     := FMaster.LegendManager.Items[Index].CaptionColumnYAxisTitle;
          Legend[x].CaptionColumnXValue         := FMaster.LegendManager.Items[Index].CaptionColumnXValue;
          Legend[x].CaptionColumnYValue         := FMaster.LegendManager.Items[Index].CaptionColumnYValue;
          Legend[x].CaptionColumnYMax           := FMaster.LegendManager.Items[Index].CaptionColumnYMax;
          Legend[x].CaptionColumnYMin           := FMaster.LegendManager.Items[Index].CaptionColumnYMin;
          Legend[x].CaptionColumnYMean          := FMaster.LegendManager.Items[Index].CaptionColumnYMean;

          Legend[x].WrapColDesiredCount         := FMaster.LegendManager.Items[Index].WrapColDesiredCount;
          Legend[x].WrapColAutoCountEnabled     := FMaster.LegendManager.Items[Index].WrapColAutoCountEnabled;
          Legend[x].WrapColAutoCountMax         := FMaster.LegendManager.Items[Index].WrapColAutoCountMax;
          Legend[x].WrapColSpacingAuto          := FMaster.LegendManager.Items[Index].WrapColSpacingAuto;
          Legend[x].WrapColSpacingMin           := FMaster.LegendManager.Items[Index].WrapColSpacingMin;

          Legend[x].WrapRowDesiredCount         := FMaster.LegendManager.Items[Index].WrapRowDesiredCount;
          Legend[x].WrapRowAutoCountEnabled     := FMaster.LegendManager.Items[Index].WrapRowAutoCountEnabled;
          Legend[x].WrapRowAutoCountMax         := FMaster.LegendManager.Items[Index].WrapRowAutoCountMax;
          Legend[x].WrapRowSpacingAuto          := FMaster.LegendManager.Items[Index].WrapRowSpacingAuto;
          Legend[x].WrapRowSpacingMin           := FMaster.LegendManager.Items[Index].WrapRowSpacingMin;

          Legend[x].Font.Assign            (FMaster.LegendManager.Items[Index].Font);
          Legend[x].SelectedItemFont.Assign(FMaster.LegendManager.Items[Index].SelectedItemFont);
          Legend[x].ColumnTitlesFont.Assign(FMaster.LegendManager.Items[Index].ColumnTitlesFont);
        end;
      //------------------ Table -----------------------------------
      for x := 0 to FMaster.TableManager.Count-1 do
        begin
          Index := AddTable;
          Table[Index].Name                      := FMaster.TableManager.Items[x].Name;
          Table[Index].Visible                   := FMaster.TableManager.Items[x].Visible;
          Table[Index].Enabled                   := FMaster.TableManager.Items[x].Enabled;
          Table[Index].PopupEnabled              := FMaster.TableManager.Items[x].PopupEnabled;
          Table[Index].UserCanEdit               := FMaster.TableManager.Items[x].UserCanEdit;
          Table[Index].CanFocus                  := FMaster.TableManager.Items[x].CanFocus;
          Table[Index].Layer                     := FMaster.TableManager.Items[x].Layer;

          Table[Index].ZOrder                    := FMaster.TableManager.Items[x].ZOrder;
          Table[Index].Horizontal                := FMaster.TableManager.Items[x].Horizontal;
          Table[Index].StartPercent              := FMaster.TableManager.Items[x].StartPercent;
          Table[Index].StopPercent               := FMaster.TableManager.Items[x].StopPercent;

          Table[Index].MarginLeft                := FMaster.TableManager.Items[x].MarginLeft;
          Table[Index].MarginTop                 := FMaster.TableManager.Items[x].MarginTop;
          Table[Index].MarginRight               := FMaster.TableManager.Items[x].MarginRight;
          Table[Index].MarginBottom              := FMaster.TableManager.Items[x].MarginBottom;

          Table[Index].GridBackGroundColor       := FMaster.TableManager.Items[x].GridBackGroundColor;
          Table[Index].GridBackGroundTransparent := FMaster.TableManager.Items[x].GridBackGroundTransparent;
          Table[Index].GridLinesColor            := FMaster.TableManager.Items[x].GridLinesColor;
          Table[Index].GridLinesShow             := FMaster.TableManager.Items[x].GridLinesShow;

          Table[Index].ColumnSpacing             := FMaster.TableManager.Items[x].ColumnSpacing;
          Table[Index].RowSpacing                := FMaster.TableManager.Items[x].RowSpacing;
          Table[Index].RowsMax                   := FMaster.TableManager.Items[x].RowsMax;

          Table[Index].ColumnTitlesVisible       := FMaster.TableManager.Items[x].ColumnTitlesVisible;

          Table[Index].StartPercent              := FMaster.TableManager.Items[x].StartPercent;
          Table[Index].StopPercent               := FMaster.TableManager.Items[x].StopPercent;

          Table[Index].DataFont.Assign(FMaster.TableManager.Items[x].DataFont);
          Table[Index].ColumnTitlesFont.Assign(FMaster.TableManager.Items[x].ColumnTitlesFont);
        end;

      //------------------ XAxis ------------------------------------
      for x := 0 to XAxisListBox.Items.Count-1 do
        begin
          Index := AddXAxis;
          XAxis[Index].Name                      := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).Name;
          XAxis[Index].Visible                   := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).Visible;
          XAxis[Index].GridLinesVisible          := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).GridLinesVisible;
          XAxis[Index].Enabled                   := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).Enabled;
          XAxis[Index].PopupEnabled              := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).PopupEnabled;
          XAxis[Index].MasterUIInput             := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).MasterUIInput;
          XAxis[Index].UserCanEdit               := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).UserCanEdit;
          XAxis[Index].CanFocus                  := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CanFocus;
          XAxis[Index].Layer                     := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).Layer;

          XAxis[Index].ZOrder                    := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).ZOrder;
          XAxis[Index].StartPercent              := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).StartPercent;
          XAxis[Index].StopPercent               := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).StopPercent;

          XAxis[Index].Min                       := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).Min;
          XAxis[Index].Span                      := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).Span;
          XAxis[Index].DesiredStart              := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).DesiredStart;
          XAxis[Index].DesiredIncrement          := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).DesiredIncrement;
          XAxis[Index].ReverseScale              := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).ReverseScale;
          XAxis[Index].RestoreValuesOnResume     := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).RestoreValuesOnResume;
          XAxis[Index].InnerMargin               := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).InnerMargin;
          XAxis[Index].OuterMargin               := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).OuterMargin;
          XAxis[Index].ScaleLinesShow            := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).ScaleLinesShow;
          XAxis[Index].ScaleLinesColor           := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).ScaleLinesColor;
          XAxis[Index].MajorLength               := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).MajorLength;
          XAxis[Index].MinorCount                := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).MinorCount;
          XAxis[Index].MinorLength               := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).MinorLength;
          XAxis[Index].LabelsMargin              := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LabelsMargin;
          XAxis[Index].LabelsVisible             := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LabelsVisible;
          XAxis[Index].LabelSeparation           := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LabelSeparation;
          XAxis[Index].StackingEndsMargin        := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).StackingEndsMargin;
          XAxis[Index].ForceStacking             := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).ForceStacking;
          XAxis[Index].Title                     := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).Title;
          XAxis[Index].TitleShow                 := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).TitleShow;
          XAxis[Index].TitleRotated              := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).TitleRotated;
          XAxis[Index].TitleMargin               := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).TitleMargin;
          XAxis[Index].TrackingEnabled           := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).TrackingEnabled;
          XAxis[Index].TrackingStyle             := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).TrackingStyle;
          XAxis[Index].TrackingIncrementStyle    := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).TrackingIncrementStyle;
          XAxis[Index].TrackingAlignFirstStyle   := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).TrackingAlignFirstStyle;
          XAxis[Index].TrackingScrollCompressMax := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).TrackingScrollCompressMax;
          XAxis[Index].TrackingSpanMinimum       := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).TrackingSpanMinimum;
          XAxis[Index].TrackingMaxMargin         := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).TrackingMaxMargin;
          XAxis[Index].TrackingMinMargin         := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).TrackingMinMargin;
          XAxis[Index].CursorScaler              := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CursorScaler;

          XAxis[Index].LabelsRotation            := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LabelsRotation;
          XAxis[Index].LabelsFormatStyle         := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LabelsFormatStyle;
          XAxis[Index].DateTimeFormat            := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).DateTimeFormat;
          XAxis[Index].LabelsPrecisionStyle      := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LabelsPrecisionStyle;
          XAxis[Index].LabelsPrecision           := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LabelsPrecision;
          XAxis[Index].LabelsMinLength           := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LabelsMinLength;
          XAxis[Index].LabelsMinLengthAutoAdjust := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LabelsMinLengthAutoAdjust;

          XAxis[Index].CursorUseDefaultFormat    := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CursorUseDefaultFormat;
          XAxis[Index].CursorFormatStyle         := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CursorFormatStyle;
          XAxis[Index].CursorDateTimeFormat      := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CursorDateTimeFormat;
          XAxis[Index].CursorPrecisionStyle      := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CursorPrecisionStyle;
          XAxis[Index].CursorPrecision           := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CursorPrecision;
          XAxis[Index].CursorMinLength           := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CursorMinLength;
          XAxis[Index].CursorMinLengthAutoAdjust := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CursorMinLengthAutoAdjust;

          XAxis[Index].LegendUseDefaultFormat    := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LegendUseDefaultFormat;
          XAxis[Index].LegendFormatStyle         := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LegendFormatStyle;
          XAxis[Index].LegendDateTimeFormat      := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LegendDateTimeFormat;
          XAxis[Index].LegendPrecisionStyle      := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LegendPrecisionStyle;
          XAxis[Index].LegendPrecision           := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LegendPrecision;
          XAxis[Index].LegendMinLength           := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LegendMinLength;
          XAxis[Index].LegendMinLengthAutoAdjust := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).LegendMinLengthAutoAdjust;

          XAxis[Index].ScrollMinMaxEnabled       := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).ScrollMinMaxEnabled;
          XAxis[Index].ScrollMax                 := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).ScrollMax;
          XAxis[Index].ScrollMin                 := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).ScrollMin;

          XAxis[Index].ScaleType                 := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).ScaleType;

          XAxis[Index].CartesianStyle            := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CartesianStyle;
          XAxis[Index].CartesianChildRefAxisName := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CartesianChildRefAxisName;
          XAxis[Index].CartesianChildRefValue    := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).CartesianChildRefValue;

          XAxis[Index].AlignRefAxisName          := (XAxisListBox.Items.Objects[x] as TiPlotXAxis).AlignRefAxisName;

          XAxis[Index].TitleFont.Assign ((XAxisListBox.Items.Objects[x] as TiPlotXAxis).TitleFont);
          XAxis[Index].LabelsFont.Assign((XAxisListBox.Items.Objects[x] as TiPlotXAxis).LabelsFont);
        end;
      //------------------ YAxis ------------------------------------
      for x := 0 to YAxisListBox.Items.Count-1 do
        begin
          Index := AddYAxis;
          YAxis[Index].Name                      := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).Name;
          YAxis[Index].Visible                   := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).Visible;
          YAxis[Index].GridLinesVisible          := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).GridLinesVisible;
          YAxis[Index].Enabled                   := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).Enabled;
          YAxis[Index].PopupEnabled              := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).PopupEnabled;
          YAxis[Index].MasterUIInput             := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).MasterUIInput;
          YAxis[Index].UserCanEdit               := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).UserCanEdit;
          YAxis[Index].CanFocus                  := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CanFocus;
          YAxis[Index].Layer                     := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).Layer;

          YAxis[Index].ZOrder                    := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).ZOrder;
          YAxis[Index].StartPercent              := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).StartPercent;
          YAxis[Index].StopPercent               := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).StopPercent;

          YAxis[Index].Min                       := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).Min;
          YAxis[Index].Span                      := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).Span;
          YAxis[Index].DesiredStart              := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).DesiredStart;
          YAxis[Index].DesiredIncrement          := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).DesiredIncrement;
          YAxis[Index].ReverseScale              := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).ReverseScale;
          YAxis[Index].RestoreValuesOnResume     := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).RestoreValuesOnResume;
          YAxis[Index].InnerMargin               := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).InnerMargin;
          YAxis[Index].OuterMargin               := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).OuterMargin;
          YAxis[Index].ScaleLinesShow            := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).ScaleLinesShow;
          YAxis[Index].ScaleLinesColor           := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).ScaleLinesColor;
          YAxis[Index].MajorLength               := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).MajorLength;
          YAxis[Index].MinorCount                := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).MinorCount;
          YAxis[Index].MinorLength               := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).MinorLength;
          YAxis[Index].LabelsVisible             := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LabelsVisible;
          YAxis[Index].LabelsMargin              := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LabelsMargin;
          YAxis[Index].LabelSeparation           := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LabelSeparation;
          YAxis[Index].StackingEndsMargin        := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).StackingEndsMargin;
          YAxis[Index].ForceStacking             := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).ForceStacking;
          YAxis[Index].Title                     := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).Title;
          YAxis[Index].TitleShow                 := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).TitleShow;
          YAxis[Index].TitleRotated              := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).TitleRotated;
          YAxis[Index].TitleMargin               := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).TitleMargin;
          YAxis[Index].TrackingEnabled           := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).TrackingEnabled;
          YAxis[Index].TrackingStyle             := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).TrackingStyle;
          YAxis[Index].TrackingIncrementStyle    := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).TrackingIncrementStyle;
          YAxis[Index].TrackingAlignFirstStyle   := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).TrackingAlignFirstStyle;
          YAxis[Index].TrackingScrollCompressMax := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).TrackingScrollCompressMax;
          YAxis[Index].TrackingSpanMinimum       := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).TrackingSpanMinimum;
          YAxis[Index].TrackingMaxMargin         := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).TrackingMaxMargin;
          YAxis[Index].TrackingMinMargin         := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).TrackingMinMargin;
          YAxis[Index].CursorScaler              := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CursorScaler;

          YAxis[Index].LabelsRotation            := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LabelsRotation;
          YAxis[Index].LabelsFormatStyle         := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LabelsFormatStyle;
          YAxis[Index].DateTimeFormat            := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).DateTimeFormat;
          YAxis[Index].LabelsPrecisionStyle      := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LabelsPrecisionStyle;
          YAxis[Index].LabelsPrecision           := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LabelsPrecision;
          YAxis[Index].LabelsMinLength           := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LabelsMinLength;
          YAxis[Index].LabelsMinLengthAutoAdjust := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LabelsMinLengthAutoAdjust;

          YAxis[Index].CursorUseDefaultFormat    := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CursorUseDefaultFormat;
          YAxis[Index].CursorFormatStyle         := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CursorFormatStyle;
          YAxis[Index].CursorDateTimeFormat      := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CursorDateTimeFormat;
          YAxis[Index].CursorPrecisionStyle      := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CursorPrecisionStyle;
          YAxis[Index].CursorPrecision           := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CursorPrecision;
          YAxis[Index].CursorMinLength           := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CursorMinLength;
          YAxis[Index].CursorMinLengthAutoAdjust := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CursorMinLengthAutoAdjust;

          YAxis[Index].LegendUseDefaultFormat    := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LegendUseDefaultFormat;
          YAxis[Index].LegendFormatStyle         := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LegendFormatStyle;
          YAxis[Index].LegendDateTimeFormat      := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LegendDateTimeFormat;
          YAxis[Index].LegendPrecisionStyle      := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LegendPrecisionStyle;
          YAxis[Index].LegendPrecision           := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LegendPrecision;
          YAxis[Index].LegendMinLength           := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LegendMinLength;
          YAxis[Index].LegendMinLengthAutoAdjust := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).LegendMinLengthAutoAdjust;

          YAxis[Index].ScrollMinMaxEnabled       := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).ScrollMinMaxEnabled;
          YAxis[Index].ScrollMax                 := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).ScrollMax;
          YAxis[Index].ScrollMin                 := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).ScrollMin;

          YAxis[Index].ScaleType                 := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).ScaleType;

          YAxis[Index].CartesianStyle            := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CartesianStyle;
          YAxis[Index].CartesianChildRefAxisName := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CartesianChildRefAxisName;
          YAxis[Index].CartesianChildRefValue    := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).CartesianChildRefValue;

          YAxis[Index].AlignRefAxisName          := (YAxisListBox.Items.Objects[x] as TiPlotYAxis).AlignRefAxisName;

          YAxis[Index].TitleFont.Assign ((YAxisListBox.Items.Objects[x] as TiPlotYAxis).TitleFont);
          YAxis[Index].LabelsFont.Assign((YAxisListBox.Items.Objects[x] as TiPlotYAxis).LabelsFont);
        end;
      //------------------ Data View ---------------------------
      for x := 0 to FMaster.DataViewManager.Count-1 do
        begin
          Index := AddDataView;
          DataView[Index].Name                         := FMaster.DataViewManager.Items[x].Name;
          DataView[Index].Visible                      := FMaster.DataViewManager.Items[x].Visible;
          DataView[Index].Enabled                      := FMaster.DataViewManager.Items[x].Enabled;
          DataView[Index].PopupEnabled                 := FMaster.DataViewManager.Items[x].PopupEnabled;
          DataView[Index].UserCanEdit                  := FMaster.DataViewManager.Items[x].UserCanEdit;
          DataView[Index].CanFocus                     := FMaster.DataViewManager.Items[x].CanFocus;
          DataView[Index].Layer                        := FMaster.DataViewManager.Items[x].Layer;

          DataView[Index].BackgroundTransparent        := FMaster.DataViewManager.Items[x].BackgroundTransparent;
          DataView[Index].BackgroundColor              := FMaster.DataViewManager.Items[x].BackgroundColor;
          DataView[Index].GridXAxisName                := FMaster.DataViewManager.Items[x].GridXAxisName;
          DataView[Index].GridYAxisName                := FMaster.DataViewManager.Items[x].GridYAxisName;
          DataView[Index].AxesControlEnabled           := FMaster.DataViewManager.Items[x].AxesControlEnabled;
          DataView[Index].AxesControlAllowInSelectMode := FMaster.DataViewManager.Items[x].AxesControlAllowInSelectMode;
          DataView[Index].AxesControlMouseStyle        := FMaster.DataViewManager.Items[x].AxesControlMouseStyle;
          DataView[Index].AxesControlWheelStyle        := FMaster.DataViewManager.Items[x].AxesControlWheelStyle;

          DataView[Index].GridShow                     := FMaster.DataViewManager.Items[x].GridShow;
          DataView[Index].GridLineColor                := FMaster.DataViewManager.Items[x].GridLineColor;
          DataView[Index].GridLineShowLeft             := FMaster.DataViewManager.Items[x].GridLineShowLeft;
          DataView[Index].GridLineShowTop              := FMaster.DataViewManager.Items[x].GridLineShowTop;
          DataView[Index].GridLineShowRight            := FMaster.DataViewManager.Items[x].GridLineShowRight;
          DataView[Index].GridLineShowBottom           := FMaster.DataViewManager.Items[x].GridLineShowBottom;
          DataView[Index].GridLineShowXMajors          := FMaster.DataViewManager.Items[x].GridLineShowXMajors;
          DataView[Index].GridLineShowXMinors          := FMaster.DataViewManager.Items[x].GridLineShowXMinors;
          DataView[Index].GridLineShowYMajors          := FMaster.DataViewManager.Items[x].GridLineShowYMajors;
          DataView[Index].GridLineShowYMinors          := FMaster.DataViewManager.Items[x].GridLineShowYMinors;
          DataView[Index].GridLineMajorStyle           := FMaster.DataViewManager.Items[x].GridLineMajorStyle;
          DataView[Index].GridLineMinorStyle           := FMaster.DataViewManager.Items[x].GridLineMinorStyle;

          DataView[Index].GridLineXMajorCustom         := FMaster.DataViewManager.Items[x].GridLineXMajorCustom;
          DataView[Index].GridLineXMajorColor          := FMaster.DataViewManager.Items[x].GridLineXMajorColor;
          DataView[Index].GridLineXMajorWidth          := FMaster.DataViewManager.Items[x].GridLineXMajorWidth;
          DataView[Index].GridLineXMajorStyle          := FMaster.DataViewManager.Items[x].GridLineXMajorStyle;

          DataView[Index].GridLineXMinorCustom         := FMaster.DataViewManager.Items[x].GridLineXMinorCustom;
          DataView[Index].GridLineXMinorColor          := FMaster.DataViewManager.Items[x].GridLineXMinorColor;
          DataView[Index].GridLineXMinorWidth          := FMaster.DataViewManager.Items[x].GridLineXMinorWidth;
          DataView[Index].GridLineXMinorStyle          := FMaster.DataViewManager.Items[x].GridLineXMinorStyle;

          DataView[Index].GridLineYMajorCustom         := FMaster.DataViewManager.Items[x].GridLineYMajorCustom;
          DataView[Index].GridLineYMajorColor          := FMaster.DataViewManager.Items[x].GridLineYMajorColor;
          DataView[Index].GridLineYMajorWidth          := FMaster.DataViewManager.Items[x].GridLineYMajorWidth;
          DataView[Index].GridLineYMajorStyle          := FMaster.DataViewManager.Items[x].GridLineYMajorStyle;

          DataView[Index].GridLineYMinorCustom         := FMaster.DataViewManager.Items[x].GridLineYMinorCustom;
          DataView[Index].GridLineYMinorColor          := FMaster.DataViewManager.Items[x].GridLineYMinorColor;
          DataView[Index].GridLineYMinorWidth          := FMaster.DataViewManager.Items[x].GridLineYMinorWidth;
          DataView[Index].GridLineYMinorStyle          := FMaster.DataViewManager.Items[x].GridLineYMinorStyle;
        end;
      //------------------ Channels ------------------------------------
      for x := 0 to ChannelListBox.Items.Count-1 do
        begin
          Index := AddChannel;

          ChannelSource := (ChannelListBox.Items.Objects[x] as TiPlotChannelCustom);
          ChannelTarget := Channel[Index];
          ChannelTarget.Name                        := ChannelSource.Name;
          ChannelTarget.Visible                     := ChannelSource.Visible;
          ChannelTarget.Enabled                     := ChannelSource.Enabled;
          ChannelTarget.PopupEnabled                := ChannelSource.PopupEnabled;
          ChannelTarget.UserCanEdit                 := ChannelSource.UserCanEdit;
          ChannelTarget.CanFocus                    := ChannelSource.CanFocus;
          ChannelTarget.Layer                       := ChannelSource.Layer;

          ChannelTarget.TitleText                   := ChannelSource.TitleText;
          ChannelTarget.Color                       := ChannelSource.Color;
          ChannelTarget.RingBufferSize              := ChannelSource.RingBufferSize;
          ChannelTarget.TraceLineStyle              := ChannelSource.TraceLineStyle;
          ChannelTarget.TraceLineWidth              := ChannelSource.TraceLineWidth;
          ChannelTarget.VisibleInLegend             := ChannelSource.VisibleInLegend;
          ChannelTarget.ShowDataPointHints          := ChannelSource.ShowDataPointHints;
          ChannelTarget.UserCanMoveDataPoints       := ChannelSource.UserCanMoveDataPoints;
          ChannelTarget.UserCanMoveDataPointsStyle  := ChannelSource.UserCanMoveDataPointsStyle;
          ChannelTarget.TraceVisible                := ChannelSource.TraceVisible;
          ChannelTarget.XAxisName                   := ChannelSource.XAxisName;
          ChannelTarget.YAxisName                   := ChannelSource.YAxisName;
          ChannelTarget.XAxisTrackingEnabled        := ChannelSource.XAxisTrackingEnabled;
          ChannelTarget.YAxisTrackingEnabled        := ChannelSource.YAxisTrackingEnabled;
          ChannelTarget.DataStyle                   := ChannelSource.DataStyle;

          ChannelTarget.MarkersVisible              := ChannelSource.MarkersVisible;
          ChannelTarget.MarkersAllowIndividual      := ChannelSource.MarkersAllowIndividual;
          ChannelTarget.MarkersSize                 := ChannelSource.MarkersSize;
          ChannelTarget.MarkersStyle                := ChannelSource.MarkersStyle;
          ChannelTarget.MarkersPenColor             := ChannelSource.MarkersPenColor;
          ChannelTarget.MarkersPenUseChannelColor   := ChannelSource.MarkersPenUseChannelColor;
          ChannelTarget.MarkersPenStyle             := ChannelSource.MarkersPenStyle;
          ChannelTarget.MarkersPenWidth             := ChannelSource.MarkersPenWidth;
          ChannelTarget.MarkersBrushColor           := ChannelSource.MarkersBrushColor;
          ChannelTarget.MarkersBrushUseChannelColor := ChannelSource.MarkersBrushUseChannelColor;
          ChannelTarget.MarkersBrushStyle           := ChannelSource.MarkersBrushStyle;
          ChannelTarget.MarkersTurnOffLimit         := ChannelSource.MarkersTurnOffLimit;

          ChannelTarget.LogFileName                 := ChannelSource.LogFileName;
          ChannelTarget.LogBufferSize               := ChannelSource.LogBufferSize;

          ChannelTarget.MarkersFont.Assign(ChannelSource.MarkersFont);


          if Channel[x] is TiXYPlotChannel then
            begin
              {$IFDEF iVCL}
              (ChannelTarget as TiXYPlotChannel).OPCItem2Name          := (ChannelSource as TiXYPlotChannel).OPCItem2Name;
              (ChannelTarget as TiXYPlotChannel).OPCComputerName       := (ChannelSource as TiXYPlotChannel).OPCComputerName;
              (ChannelTarget as TiXYPlotChannel).OPCServerName         := (ChannelSource as TiXYPlotChannel).OPCServerName;
              (ChannelTarget as TiXYPlotChannel).OPCItemName           := (ChannelSource as TiXYPlotChannel).OPCItemName;
              (ChannelTarget as TiXYPlotChannel).OPCUpdateRate         := (ChannelSource as TiXYPlotChannel).OPCUpdateRate;
              (ChannelTarget as TiXYPlotChannel).OPCScalar             := (ChannelSource as TiXYPlotChannel).OPCScalar;
              (ChannelTarget as TiXYPlotChannel).OPCOffset             := (ChannelSource as TiXYPlotChannel).OPCOffset;
              (ChannelTarget as TiXYPlotChannel).OPCScalar2            := (ChannelSource as TiXYPlotChannel).OPCScalar2;
              (ChannelTarget as TiXYPlotChannel).OPCOffset2            := (ChannelSource as TiXYPlotChannel).OPCOffset2;
              (ChannelTarget as TiXYPlotChannel).OPCAutoConnect        := (ChannelSource as TiXYPlotChannel).OPCAutoConnect;
              {$endif}
           end;

          if Channel[x] is TiPlotChannel then
            begin
              (ChannelTarget as TiPlotChannel).FillEnabled                    := (ChannelSource as TiPlotChannel).FillEnabled;
              (ChannelTarget as TiPlotChannel).FillReference                  := (ChannelSource as TiPlotChannel).FillReference;
              (ChannelTarget as TiPlotChannel).FillStyle                      := (ChannelSource as TiPlotChannel).FillStyle;
              (ChannelTarget as TiPlotChannel).FillColor                      := (ChannelSource as TiPlotChannel).FillColor;
              (ChannelTarget as TiPlotChannel).FillUseChannelColor            := (ChannelSource as TiPlotChannel).FillUseChannelColor;

              (ChannelTarget as TiPlotChannel).BarEnabled                     := (ChannelSource as TiPlotChannel).BarEnabled;
              (ChannelTarget as TiPlotChannel).BarWidth                       := (ChannelSource as TiPlotChannel).BarWidth;
              (ChannelTarget as TiPlotChannel).BarReference                   := (ChannelSource as TiPlotChannel).BarReference;
              (ChannelTarget as TiPlotChannel).BarPenColor                    := (ChannelSource as TiPlotChannel).BarPenColor;
              (ChannelTarget as TiPlotChannel).BarPenUseChannelColor          := (ChannelSource as TiPlotChannel).BarPenUseChannelColor;
              (ChannelTarget as TiPlotChannel).BarPenStyle                    := (ChannelSource as TiPlotChannel).BarPenStyle;
              (ChannelTarget as TiPlotChannel).BarPenWidth                    := (ChannelSource as TiPlotChannel).BarPenWidth;
              (ChannelTarget as TiPlotChannel).BarBrushColor                  := (ChannelSource as TiPlotChannel).BarBrushColor;
              (ChannelTarget as TiPlotChannel).BarBrushUseChannelColor        := (ChannelSource as TiPlotChannel).BarBrushUseChannelColor;
              (ChannelTarget as TiPlotChannel).BarBrushStyle                  := (ChannelSource as TiPlotChannel).BarBrushStyle;

              (ChannelTarget as TiPlotChannel).HighLowStyle                   := (ChannelSource as TiPlotChannel).HighLowStyle;
              (ChannelTarget as TiPlotChannel).HighLowEnabled                 := (ChannelSource as TiPlotChannel).HighLowEnabled;
              (ChannelTarget as TiPlotChannel).HighLowBarColor                := (ChannelSource as TiPlotChannel).HighLowBarColor;
              (ChannelTarget as TiPlotChannel).HighLowBarWidth                := (ChannelSource as TiPlotChannel).HighLowBarWidth;
              (ChannelTarget as TiPlotChannel).HighLowOpenShow                := (ChannelSource as TiPlotChannel).HighLowOpenShow;
              (ChannelTarget as TiPlotChannel).HighLowOpenColor               := (ChannelSource as TiPlotChannel).HighLowOpenColor;
              (ChannelTarget as TiPlotChannel).HighLowOpenWidth               := (ChannelSource as TiPlotChannel).HighLowOpenWidth;
              (ChannelTarget as TiPlotChannel).HighLowOpenHeight              := (ChannelSource as TiPlotChannel).HighLowOpenHeight;
              (ChannelTarget as TiPlotChannel).HighLowCloseShow               := (ChannelSource as TiPlotChannel).HighLowCloseShow;
              (ChannelTarget as TiPlotChannel).HighLowCloseColor              := (ChannelSource as TiPlotChannel).HighLowCloseColor;
              (ChannelTarget as TiPlotChannel).HighLowCloseWidth              := (ChannelSource as TiPlotChannel).HighLowCloseWidth;
              (ChannelTarget as TiPlotChannel).HighLowCloseHeight             := (ChannelSource as TiPlotChannel).HighLowCloseHeight;
              (ChannelTarget as TiPlotChannel).HighLowShadowColor             := (ChannelSource as TiPlotChannel).HighLowShadowColor;
              (ChannelTarget as TiPlotChannel).HighLowBullishColor            := (ChannelSource as TiPlotChannel).HighLowBullishColor;
              (ChannelTarget as TiPlotChannel).HighLowBearishColor            := (ChannelSource as TiPlotChannel).HighLowBearishColor;

              (ChannelTarget as TiPlotChannel).DigitalEnabled                 := (ChannelSource as TiPlotChannel).DigitalEnabled;
              (ChannelTarget as TiPlotChannel).DigitalReferenceHigh           := (ChannelSource as TiPlotChannel).DigitalReferenceHigh;
              (ChannelTarget as TiPlotChannel).DigitalReferenceLow            := (ChannelSource as TiPlotChannel).DigitalReferenceLow;
              (ChannelTarget as TiPlotChannel).DigitalReferenceStyle          := (ChannelSource as TiPlotChannel).DigitalReferenceStyle;

              (ChannelTarget as TiPlotChannel).FastDrawEnabled                := (ChannelSource as TiPlotChannel).FastDrawEnabled;
              (ChannelTarget as TiPlotChannel).DrawOutOfOrderXValues          := (ChannelSource as TiPlotChannel).DrawOutOfOrderXValues;
              (ChannelTarget as TiPlotChannel).AllowOutOfOrderXValues         := (ChannelSource as TiPlotChannel).AllowOutOfOrderXValues;
              (ChannelTarget as TiPlotChannel).ResetStartTimeOnFirstDataPoint := (ChannelSource as TiPlotChannel).ResetStartTimeOnFirstDataPoint;
              (ChannelTarget as TiPlotChannel).ClipToAxes                     := (ChannelSource as TiPlotChannel).ClipToAxes;

              (ChannelTarget as TiPlotChannel).InterpolationStyle             := (ChannelSource as TiPlotChannel).InterpolationStyle;
              {$IFDEF iVCL}
              (ChannelTarget as TiPlotChannel).OPCXValueSource                := (ChannelSource as TiPlotChannel).OPCXValueSource;
              (ChannelTarget as TiPlotChannel).OPCGroupName                   := (ChannelSource as TiPlotChannel).OPCGroupName;
              (ChannelTarget as TiPlotChannel).OPCComputerName                := (ChannelSource as TiPlotChannel).OPCComputerName;
              (ChannelTarget as TiPlotChannel).OPCServerName                  := (ChannelSource as TiPlotChannel).OPCServerName;
              (ChannelTarget as TiPlotChannel).OPCItemName                    := (ChannelSource as TiPlotChannel).OPCItemName;
              (ChannelTarget as TiPlotChannel).OPCUpdateRate                  := (ChannelSource as TiPlotChannel).OPCUpdateRate;
              (ChannelTarget as TiPlotChannel).OPCScalar                      := (ChannelSource as TiPlotChannel).OPCScalar;
              (ChannelTarget as TiPlotChannel).OPCOffset                      := (ChannelSource as TiPlotChannel).OPCOffset;
              (ChannelTarget as TiPlotChannel).OPCAutoConnect                 := (ChannelSource as TiPlotChannel).OPCAutoConnect;

              (ChannelTarget as TiPlotChannel).OPCItem2Name                   := (ChannelSource as TiPlotChannel).OPCItem2Name;
              (ChannelTarget as TiPlotChannel).OPCScalar2                     := (ChannelSource as TiPlotChannel).OPCScalar2;
              (ChannelTarget as TiPlotChannel).OPCOffset2                     := (ChannelSource as TiPlotChannel).OPCOffset2;
              {$endif}
            end;
        end;
      //------------------ Data Cursor ---------------------------
      for x := 0 to FMaster.DataCursorManager.Count-1 do
        begin
          Index := AddDataCursor;

          DataCursor[Index].Name                      := FMaster.DataCursorManager.Items[x].Name;
          DataCursor[Index].Visible                   := FMaster.DataCursorManager.Items[x].Visible;
          DataCursor[Index].Enabled                   := FMaster.DataCursorManager.Items[x].Enabled;
          DataCursor[Index].PopupEnabled              := FMaster.DataCursorManager.Items[x].PopupEnabled;
          DataCursor[Index].UserCanEdit               := FMaster.DataCursorManager.Items[x].UserCanEdit;
          DataCursor[Index].CanFocus                  := FMaster.DataCursorManager.Items[x].CanFocus;
          DataCursor[Index].SnapToDataPoint           := FMaster.DataCursorManager.Items[x].SnapToDataPoint;
          DataCursor[Index].UseCachedInterpolatedData := FMaster.DataCursorManager.Items[x].UseCachedInterpolatedData;
          DataCursor[Index].Layer                     := FMaster.DataCursorManager.Items[x].Layer;

          DataCursor[Index].Style                     := FMaster.DataCursorManager.Items[x].Style;
          DataCursor[Index].Color                     := FMaster.DataCursorManager.Items[x].Color;
          DataCursor[Index].UseChannelColor           := FMaster.DataCursorManager.Items[x].UseChannelColor;
          DataCursor[Index].HintPosition              := FMaster.DataCursorManager.Items[x].HintPosition;
          DataCursor[Index].HintShow                  := FMaster.DataCursorManager.Items[x].HintShow;
          DataCursor[Index].HintHideOnRelease         := FMaster.DataCursorManager.Items[x].HintHideOnRelease;
          DataCursor[Index].HintOrientationSide       := FMaster.DataCursorManager.Items[x].HintOrientationSide;
          DataCursor[Index].Pointer1Position          := FMaster.DataCursorManager.Items[x].Pointer1Position;
          DataCursor[Index].Pointer2Position          := FMaster.DataCursorManager.Items[x].Pointer2Position;
          DataCursor[Index].PointerPenWidth           := FMaster.DataCursorManager.Items[x].PointerPenWidth;

          DataCursor[x].MenuItemVisibleValueXY        :=  FMaster.DataCursorManager.Items[Index].MenuItemVisibleValueXY;
          DataCursor[x].MenuItemVisibleValueX         :=  FMaster.DataCursorManager.Items[Index].MenuItemVisibleValueX;
          DataCursor[x].MenuItemVisibleValueY         :=  FMaster.DataCursorManager.Items[Index].MenuItemVisibleValueY;
          DataCursor[x].MenuItemVisibleDeltaX         :=  FMaster.DataCursorManager.Items[Index].MenuItemVisibleDeltaX;
          DataCursor[x].MenuItemVisibleDeltaY         :=  FMaster.DataCursorManager.Items[Index].MenuItemVisibleDeltaY;
          DataCursor[x].MenuItemVisibleInverseDeltaX  :=  FMaster.DataCursorManager.Items[Index].MenuItemVisibleInverseDeltaX;

          DataCursor[x].MenuItemCaptionValueXY        :=  FMaster.DataCursorManager.Items[Index].MenuItemCaptionValueXY;
          DataCursor[x].MenuItemCaptionValueX         :=  FMaster.DataCursorManager.Items[Index].MenuItemCaptionValueX;
          DataCursor[x].MenuItemCaptionValueY         :=  FMaster.DataCursorManager.Items[Index].MenuItemCaptionValueY;
          DataCursor[x].MenuItemCaptionDeltaX         :=  FMaster.DataCursorManager.Items[Index].MenuItemCaptionDeltaX;
          DataCursor[x].MenuItemCaptionDeltaY         :=  FMaster.DataCursorManager.Items[Index].MenuItemCaptionDeltaY;
          DataCursor[x].MenuItemCaptionInverseDeltaX  :=  FMaster.DataCursorManager.Items[Index].MenuItemCaptionInverseDeltaX;

          DataCursor[x].MenuUserCanChangeOptions      :=  FMaster.DataCursorManager.Items[Index].MenuUserCanChangeOptions;

          DataCursor[Index].ChannelName               := FMaster.DataCursorManager.Items[x].ChannelName;
          DataCursor[Index].ChannelAllowAll           := FMaster.DataCursorManager.Items[x].ChannelAllowAll;
          DataCursor[Index].ChannelShowAllInLegend    := FMaster.DataCursorManager.Items[x].ChannelShowAllInLegend;

          DataCursor[Index].Font.Assign(FMaster.DataCursorManager.Items[x].Font);
        end;
      //------------------ Limit ---------------------------
      for x := 0 to FMaster.LimitManager.Count-1 do
        begin
          Index := AddLimit;
          Limit[Index].Name                      := FMaster.LimitManager.Items[x].Name;
          Limit[Index].Visible                   := FMaster.LimitManager.Items[x].Visible;
          Limit[Index].UserCanMove               := FMaster.LimitManager.Items[x].UserCanMove;
          Limit[Index].ClipToAxes                := FMaster.LimitManager.Items[x].ClipToAxes;
          Limit[Index].Enabled                   := FMaster.LimitManager.Items[x].Enabled;
          Limit[Index].PopupEnabled              := FMaster.LimitManager.Items[x].PopupEnabled;
          Limit[Index].UserCanEdit               := FMaster.LimitManager.Items[x].UserCanEdit;
          Limit[Index].SelectModeOnlyInteraction := FMaster.LimitManager.Items[x].SelectModeOnlyInteraction;
          Limit[Index].CanFocus                  := FMaster.LimitManager.Items[x].CanFocus;
          Limit[Index].Layer                     := FMaster.LimitManager.Items[x].Layer;

          Limit[Index].Color                     := FMaster.LimitManager.Items[x].Color;
          Limit[Index].LineStyle                 := FMaster.LimitManager.Items[x].LineStyle;
          Limit[Index].LineWidth                 := FMaster.LimitManager.Items[x].LineWidth;
          Limit[Index].FillStyle                 := FMaster.LimitManager.Items[x].FillStyle;
          Limit[Index].XAxisName                 := FMaster.LimitManager.Items[x].XAxisName;
          Limit[Index].YAxisName                 := FMaster.LimitManager.Items[x].YAxisName;
          Limit[Index].Style                     := FMaster.LimitManager.Items[x].Style;
          Limit[Index].Line1Position             := FMaster.LimitManager.Items[x].Line1Position;
          Limit[Index].Line2Position             := FMaster.LimitManager.Items[x].Line2Position;
        end;
      //------------------ Label ---------------------------
      for x := 0 to FMaster.LabelManager.Count-1 do
        begin
          if x = 0 then
            Index := 0
          else
            Index := AddLabel;

          Labels[Index].Name           := FMaster.LabelManager.Items[x].Name;
          Labels[Index].Visible        := FMaster.LabelManager.Items[x].Visible;
          Labels[Index].Enabled        := FMaster.LabelManager.Items[x].Enabled;
          Labels[Index].PopupEnabled   := FMaster.LabelManager.Items[x].PopupEnabled;
          Labels[Index].UserCanEdit    := FMaster.LabelManager.Items[x].UserCanEdit;
          Labels[Index].CanFocus       := FMaster.LabelManager.Items[x].CanFocus;
          Labels[Index].Layer          := FMaster.LabelManager.Items[x].Layer;

          Labels[Index].ZOrder         := FMaster.LabelManager.Items[x].ZOrder;
          Labels[Index].StartPercent   := FMaster.LabelManager.Items[x].StartPercent;
          Labels[Index].StopPercent    := FMaster.LabelManager.Items[x].StopPercent;
          Labels[Index].Horizontal     := FMaster.LabelManager.Items[x].Horizontal;

          Labels[Index].Caption        := FMaster.LabelManager.Items[x].Caption;
          Labels[Index].MarginLeft     := FMaster.LabelManager.Items[x].MarginLeft;
          Labels[Index].MarginTop      := FMaster.LabelManager.Items[x].MarginTop;
          Labels[Index].MarginRight    := FMaster.LabelManager.Items[x].MarginRight;
          Labels[Index].MarginBottom   := FMaster.LabelManager.Items[x].MarginBottom;
          Labels[Index].Alignment      := FMaster.LabelManager.Items[x].Alignment;
          Labels[Index].ImageListIndex := FMaster.LabelManager.Items[x].ImageListIndex;
          Labels[Index].ImageIndex     := FMaster.LabelManager.Items[x].ImageIndex;

          Labels[Index].Font.Assign(FMaster.LabelManager.Items[Index].Font);
        end;
      //------------------ Translation ---------------------------
      for x := 0 to FMaster.TranslationManager.Count-1 do
        AddTranslation(FMaster.TranslationManager.Items[x].OriginalString, FMaster.TranslationManager.Items[x].ReplacementString);
      //---------------------------------------------------------
      EnableLayoutManager;
    end;
  FLastToolBarIndex     := ToolBarListBox.ItemIndex;
  FLastLegendIndex      := LegendListBox.ItemIndex;
  FLastTableIndex       := TableListBox.ItemIndex;
  FLastXAxisIndex       := XAxisListBox.ItemIndex;
  FLastYAxisIndex       := YAxisListBox.ItemIndex;;
  FLastDataViewIndex    := DataViewListBox.ItemIndex;
  FLastChannelIndex     := ChannelListBox.ItemIndex;
  FLastDataCursorIndex  := DataCursorListBox.ItemIndex;
  FLastLimitIndex       := LimitListBox.ItemIndex;
  FLastLabelIndex       := LabelListBox.ItemIndex;
  FLastTranslationIndex := TranslationListBox.ItemIndex;

  Modified := False;

  TiPlotComponentAccess(iPlotComponent).AfterPropertyEditorApply;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.UpdateToolBarEdit;
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
        ToolBarUserCanEditCheckBox.AsBoolean          := iToolBar.UserCanEdit;
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
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.UpdateLegendEdit;
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
        LegendUserCanEditCheckBox.AsBoolean             := iLegend.UserCanEdit;
        LegendCanFocusCheckBox.AsBoolean                := iLegend.CanFocus;

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

        LegendColumnTitlesVisibleCheckbox.AsBoolean     := iLegend.ColumnTitlesVisible;

        LegendCaptionColumnTitleEdit.AsString           := iLegend.CaptionColumnTitle;
        LegendCaptionColumnXAxisTitleEdit.AsString      := iLegend.CaptionColumnXAxisTitle;
        LegendCaptionColumnYAxisTitleEdit.AsString      := iLegend.CaptionColumnYAxisTitle;
        LegendCaptionColumnXValueEdit.AsString          := iLegend.CaptionColumnXValue;
        LegendCaptionColumnYValueEdit.AsString          := iLegend.CaptionColumnYValue;
        LegendCaptionColumnYMaxEdit.AsString            := iLegend.CaptionColumnYMax;
        LegendCaptionColumnYMinEdit.AsString            := iLegend.CaptionColumnYMin;
        LegendCaptionColumnYMeanEdit.AsString           := iLegend.CaptionColumnYMean;

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

        LegendFontPicker.Font.Assign            (iLegend.Font);
        LegendSelectedItemFontPicker.Font.Assign(iLegend.SelectedItemFont);
        LegendColumnTitlesFontPicker.Font.Assign(iLegend.ColumnTitlesFont);
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.UpdateTableEdit;
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
        TableUserCanEditCheckBox.AsBoolean               := iTable.UserCanEdit;
        TableCanFocusCheckbox.AsBoolean                  := iTable.CanFocus;

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
procedure TiPlotComponentEditorForm.UpdateXAxesEdit;
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
        XAxisMasterUIInputCheckBox.AsBoolean              := iAxis.MasterUIInput;
        XAxisUserCanEditCheckBox.AsBoolean                := iAxis.UserCanEdit;
        XAxisCanFocusCheckBox.AsBoolean                   := iAxis.CanFocus;
        XAxisLayerEdit.AsInteger                          := iAxis.Layer;

        XAxisStartPercentEdit.AsFloat                     := iAxis.StartPercent;
        XAxisStopPercentEdit.AsFloat                      := iAxis.StopPercent;

        XAxisMinEdit.AsFloat                              := iAxis.Min;
        XAxisSpanEdit.AsFloat                             := iAxis.Span;
        XAxisDesiredStartEdit.AsFloat                     := iAxis.DesiredStart;
        XAxisDesiredIncrementEdit.AsFloat                 := iAxis.DesiredIncrement;
        XAxisReverseScaleCheckBox.AsBoolean               := iAxis.ReverseScale;
        XAxisRestoreValuesOnResumeCheckBox.AsBoolean      := iAxis.RestoreValuesOnResume;
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
procedure TiPlotComponentEditorForm.UpdateYAxesEdit;
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

        YAxisNameEdit.AsString                           := iAxis.Name;
        YAxisVisibleCheckBox.AsBoolean                   := iAxis.Visible;
        YAxisGridLinesVisibleCheckBox.AsBoolean          := iAxis.GridLinesVisible;
        YAxisEnabledCheckBox.AsBoolean                   := iAxis.Enabled;
        YAxisPopupEnabledCheckBox.AsBoolean              := iAxis.PopupEnabled;
        YAxisMasterUIInputCheckBox.AsBoolean             := iAxis.MasterUIInput;
        YAxisUserCanEditCheckBox.AsBoolean               := iAxis.UserCanEdit;
        YAxisCanFocusCheckBox.AsBoolean                  := iAxis.CanFocus;
        YAxisLayerEdit.AsInteger                         := iAxis.Layer;

        YAxisStartPercentEdit.AsFloat                    := iAxis.StartPercent;
        YAxisStopPercentEdit.AsFloat                     := iAxis.StopPercent;

        YAxisMinEdit.AsFloat                             := iAxis.Min;
        YAxisSpanEdit.AsFloat                            := iAxis.Span;
        YAxisDesiredStartEdit.AsFloat                    := iAxis.DesiredStart;
        YAxisDesiredIncrementEdit.AsFloat                := iAxis.DesiredIncrement;
        YAxisReverseScaleCheckBox.AsBoolean              := iAxis.ReverseScale;
        YAxisRestoreValuesOnResumeCheckBox.AsBoolean     := iAxis.RestoreValuesOnResume;
        YAxisInnerMarginEdit.AsInteger                   := iAxis.InnerMargin;
        YAxisOuterMarginEdit.AsInteger                   := iAxis.OuterMargin;

        YAxisTitleTextEdit.AsString                      := iAxis.Title;
        YAxisTitleMarginEdit.AsFloat                     := iAxis.TitleMargin;
        YAxisTitleShowCheckBox.AsBoolean                 := iAxis.TitleShow;
        YAxisTitleRotatedCheckBox.AsBoolean              := iAxis.TitleRotated;

        YAxisScaleLinesShowCheckBox.AsBoolean            := iAxis.ScaleLinesShow;
        YAxisScaleLinesColorPicker.Color                 := iAxis.ScaleLinesColor;
        YAxisMajorLengthEdit.AsInteger                   := iAxis.MajorLength;
        YAxisMinorLengthEdit.AsInteger                   := iAxis.MinorLength;
        YAxisMinorCountEdit.AsInteger                    := iAxis.MinorCount;

        YAxisLabelVisibleCheckBox.AsBoolean              := iAxis.LabelsVisible;
        YAxisLabelMarginEdit.AsFloat                     := iAxis.LabelsMargin;

        YAxisLabelRotationComboBox.AsInteger             := ord(iAxis.LabelsRotation);
        YAxisLabelFormatStyleComboBox.AsInteger          := ord(iAxis.LabelsFormatStyle);
        YAxisDateTimeFormatComboBox.AsString             := iAxis.DateTimeFormat;
        YAxisLabelPrecisionStyleComboBox.AsInteger       := ord(iAxis.LabelsPrecisionStyle);
        YAxisLabelPrecisionEdit.AsInteger                := iAxis.LabelsPrecision;
        YAxisLabelMinLengthEdit.AsFloat                  := iAxis.LabelsMinLength;
        YAxisLabelMinLengthAutoAdjustCheckBox.AsBoolean  := iAxis.LabelsMinLengthAutoAdjust;

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

        YAxisTrackingEnabledCheckBox.AsBoolean           := iAxis.TrackingEnabled;
        YAxisTrackingStyleComboBox.AsInteger             := ord(iAxis.TrackingStyle);
        YAxisTrackingIncrementStyleComboBox.AsInteger    := ord(iAxis.TrackingIncrementStyle);
        YAxisTrackingAlignFirstStyleComboBox.AsInteger   := ord(iAxis.TrackingAlignFirstStyle);
        YAxisTrackingScrollCompressMaxEdit.AsFloat       := iAxis.TrackingScrollCompressMax;
        YAxisTrackingSpanMinimumEdit.AsFloat             := iAxis.TrackingSpanMinimum;
        YAxisTrackingMaxMarginEdit.AsFloat               := iAxis.TrackingMaxMargin;
        YAxisTrackingMinMarginEdit.AsFloat               := iAxis.TrackingMinMargin;

        YAxisStackingEndsMarginEdit.AsFloat              := iAxis.StackingEndsMargin;
        YAxisForceStackingCheckBox.AsBoolean             := iAxis.ForceStacking;

        YAxisLabelSeparationEdit.AsFloat                 := iAxis.LabelSeparation;
        YAxisScaleTypeRadioGroup.AsInteger               := ord(iAxis.ScaleType);

        YAxisCursorScalerEdit.AsFloat                    := iAxis.CursorScaler;

        YAxisScrollMinMaxEnabledCheckBox.AsBoolean       := iAxis.ScrollMinMaxEnabled;
        YAxisScrollMinEdit.AsFloat                       := iAxis.ScrollMin;
        YAxisScrollMaxEdit.AsFloat                       := iAxis.ScrollMax;

        YAxisCartesianStyleComboBox.AsInteger            := ord(iAxis.CartesianStyle);
        YAxisCartesianChildRefAxisNameComboBox.ItemIndex := YAxisCartesianChildRefAxisNameComboBox.Items.IndexOf(iAxis.CartesianChildRefAxisName);
        YAxisCartesianChildRefValueEdit.AsFloat          := iAxis.CartesianChildRefValue;

        YAxisAlignRefAxisNameComboBox.ItemIndex           := YAxisAlignRefAxisNameComboBox.Items.IndexOf(iAxis.AlignRefAxisName);

        YAxisTitleFontPicker.Font.Assign(iAxis.TitleFont);
        YAxisLabelFontPicker.Font.Assign(iAxis.LabelsFont);

        YAxisListBox.Invalidate;
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.UpdateDataViewEdit;
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
        DataViewUserCanEditCheckBox.AsBoolean                  := iDataView.UserCanEdit;
        DataViewCanFocusCheckBox.AsBoolean                     := iDataView.CanFocus;
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
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.UpdateChannelEdit;
var
  iChannelObject : TiPlotChannelCustom;
begin
  XAxisNameComboBoxDropDown(ChannelXAxisNameComboBox);
  YAxisNameComboBoxDropDown(ChannelYAxisNameComboBox);

  if FMaster.ChannelClass = TiXYPlotChannel then
    begin
      ChannelFillTabSheet.TabVisible                        := False;
      ChannelDigitalTabSheet.TabVisible                     := False;
      ChannelFastDrawCheckBox.Visible                       := False;
      ChannelDrawOutOfOrderXValuesCheckBox.Visible          := False;
      ChannelAllowOutOfOrderXValuesCheckBox.Visible         := False;
      ChannelResetStartTimeOnFirstDataPointCheckBox.Visible := False;
      ChannelHighLowTabSheet.TabVisible                     := False;
      XValueSourcePanel.Visible                             := False;
      ChannelBarTabSheet.TabVisible                         := False;
      ChannelInterpolationStyleComboBox.Visible             := False;
      ChannelInterpolationStyleLabel.Visible                := False;
    end
  else
    begin
      ChannelFillTabSheet.TabVisible                        := True;
      ChannelDigitalTabSheet.TabVisible                     := True;
      ChannelFastDrawCheckBox.Visible                       := True;
      ChannelDrawOutOfOrderXValuesCheckBox.Visible          := True;
      ChannelAllowOutOfOrderXValuesCheckBox.Visible         := True;
      ChannelResetStartTimeOnFirstDataPointCheckBox.Visible := True;
      ChannelHighLowTabSheet.TabVisible                     := True;
      XValueSourcePanel.Visible                             := True;
      ChannelBarTabSheet.TabVisible                         := True;
      ChannelInterpolationStyleComboBox.Visible             := True;
      ChannelInterpolationStyleLabel.Visible                := True;
    end;

  if ChannelListBox.ItemIndex = - 1 then
    begin
      DisableAllEditControlsStartingWith('Channel');
    end
  else
    begin
      EnableAllEditControlsStartingWith('Channel');

      iChannelObject := ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom;

      ChannelNameEdit.AsString                             := iChannelObject.Name;
      ChannelVisibleCheckBox.AsBoolean                     := iChannelObject.Visible;
      ChannelPopupEnabledCheckBox.AsBoolean                := iChannelObject.PopupEnabled;
      ChannelUserCanEditCheckBox.AsBoolean                 := iChannelObject.UserCanEdit;
      ChannelCanFocusCheckBox.AsBoolean                    := iChannelObject.CanFocus;
      ChannelLayerEdit.AsInteger                           := iChannelObject.Layer;

      ChannelTitleEdit.AsString                            := iChannelObject.TitleText;
      ChannelVisibleInLegendCheckBox.AsBoolean             := iChannelObject.VisibleInLegend;
      ChannelShowDataPointHintsCheckBox.AsBoolean          := iChannelObject.ShowDataPointHints;
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


      if iChannelObject is TiXYPlotChannel then
        begin
          {$IFDEF iVCL}
          iOPCBrowserPanel.SetItem2Name   (0, (iChannelObject as TiXYPlotChannel).OPCItem2Name);
          iOPCBrowserPanel.SetComputerName(0, (iChannelObject as TiXYPlotChannel).OPCComputerName);
          iOPCBrowserPanel.SetServerName  (0, (iChannelObject as TiXYPlotChannel).OPCServerName);
          iOPCBrowserPanel.SetItemName    (0, (iChannelObject as TiXYPlotChannel).OPCItemName);
          iOPCBrowserPanel.SetUpdateRate  (0, (iChannelObject as TiXYPlotChannel).OPCUpdateRate);
          iOPCBrowserPanel.SetScalar      (0, (iChannelObject as TiXYPlotChannel).OPCScalar);
          iOPCBrowserPanel.SetOffset      (0, (iChannelObject as TiXYPlotChannel).OPCOffset);
          iOPCBrowserPanel.SetScalar2     (0, (iChannelObject as TiXYPlotChannel).OPCScalar2);
          iOPCBrowserPanel.SetOffset2     (0, (iChannelObject as TiXYPlotChannel).OPCOffset2);
          iOPCBrowserPanel.SetAutoConnect (0, (iChannelObject as TiXYPlotChannel).OPCAutoConnect);
          iOPCBrowserPanel.UpdateItemEdit;
          {$endif}
        end;

      if iChannelObject is TiPlotChannel then
        begin
          ChannelFillEnabledCheckBox.AsBoolean                    := (iChannelObject as TiPlotChannel).FillEnabled;
          ChannelFillReferenceEdit.AsFloat                        := (iChannelObject as TiPlotChannel).FillReference;
          ChannelFillStyleComboBox.AsInteger                      := ord((iChannelObject as TiPlotChannel).FillStyle);
          ChannelFillColorPicker.Color                            := (iChannelObject as TiPlotChannel).FillColor;
          ChannelFillUseChannelColorCheckBox.AsBoolean            := (iChannelObject as TiPlotChannel).FillUseChannelColor;

          ChannelBarEnabledCheckBox.AsBoolean                     := (iChannelObject as TiPlotChannel).BarEnabled;
          ChannelBarWidthEdit.AsFloat                             := (iChannelObject as TiPlotChannel).BarWidth;
          ChannelBarReferenceEdit.AsFloat                         := (iChannelObject as TiPlotChannel).BarReference;
          ChannelBarPenUseChannelColorCheckBox.AsBoolean          := (iChannelObject as TiPlotChannel).BarPenUseChannelColor;
          ChannelBarPenStyleComboBox.AsInteger                    := ord((iChannelObject as TiPlotChannel).BarPenStyle);
          ChannelBarPenColorPicker.Color                          := (iChannelObject as TiPlotChannel).BarPenColor;
          ChannelBarPenWidthEdit.AsInteger                        := (iChannelObject as TiPlotChannel).BarPenWidth;
          ChannelBarBrushUseChannelColorCheckBox.AsBoolean        := (iChannelObject as TiPlotChannel).BarBrushUseChannelColor;
          ChannelBarBrushStyleComboBox.AsInteger                  := ord((iChannelObject as TiPlotChannel).BarBrushStyle);
          ChannelBarBrushColorPicker.Color                        := (iChannelObject as TiPlotChannel).BarBrushColor;

          ChannelHighLowStyleComboBox.AsInteger                   := ord((iChannelObject as TiPlotChannel).HighLowStyle);
          ChannelHighLowEnabledCheckBox.AsBoolean                 := (iChannelObject as TiPlotChannel).HighLowEnabled;
          ChannelHighLowBarColorPicker.Color                      := (iChannelObject as TiPlotChannel).HighLowBarColor;
          ChannelHighLowBarWidthEdit.AsFloat                      := (iChannelObject as TiPlotChannel).HighLowBarWidth;
          ChannelHighLowOpenShowCheckBox.AsBoolean                := (iChannelObject as TiPlotChannel).HighLowOpenShow;
          ChannelHighLowOpenColorPicker.Color                     := (iChannelObject as TiPlotChannel).HighLowOpenColor;
          ChannelHighLowOpenWidthEdit.AsFloat                     := (iChannelObject as TiPlotChannel).HighLowOpenWidth;
          ChannelHighLowOpenHeightEdit.AsFloat                    := (iChannelObject as TiPlotChannel).HighLowOpenHeight;
          ChannelHighLowCloseShowCheckBox.AsBoolean               := (iChannelObject as TiPlotChannel).HighLowCloseShow;
          ChannelHighLowCloseColorPicker.Color                    := (iChannelObject as TiPlotChannel).HighLowCloseColor;
          ChannelHighLowCloseWidthEdit.AsFloat                    := (iChannelObject as TiPlotChannel).HighLowCloseWidth;
          ChannelHighLowCloseHeightEdit.AsFloat                   := (iChannelObject as TiPlotChannel).HighLowCloseHeight;
          ChannelHighLowShadowColorPicker.Color                   := (iChannelObject as TiPlotChannel).HighLowShadowColor;
          ChannelHighLowBullishColorPicker.Color                  := (iChannelObject as TiPlotChannel).HighLowBullishColor;
          ChannelHighLowBearishColorPicker.Color                  := (iChannelObject as TiPlotChannel).HighLowBearishColor;

          ChannelDigitalEnabledCheckBox.AsBoolean                 := (iChannelObject as TiPlotChannel).DigitalEnabled;
          ChannelDigitalReferenceHighEdit.AsFloat                 := (iChannelObject as TiPlotChannel).DigitalReferenceHigh;
          ChannelDigitalReferenceLowEdit.AsFloat                  := (iChannelObject as TiPlotChannel).DigitalReferenceLow;
          ChannelDigitalReferenceStyleComboBox.AsInteger          := ord((iChannelObject as TiPlotChannel).DigitalReferenceStyle);

          ChannelFastDrawCheckBox.AsBoolean                       := (iChannelObject as TiPlotChannel).FastDrawEnabled;
          ChannelDrawOutOfOrderXValuesCheckBox.AsBoolean          := (iChannelObject as TiPlotChannel).DrawOutOfOrderXValues;
          ChannelAllowOutOfOrderXValuesCheckBox.AsBoolean         := (iChannelObject as TiPlotChannel).AllowOutOfOrderXValues;
          ChannelResetStartTimeOnFirstDataPointCheckBox.AsBoolean := (iChannelObject as TiPlotChannel).ResetStartTimeOnFirstDataPoint;
          ChannelClipToAxesCheckBox.AsBoolean                     := (iChannelObject as TiPlotChannel).ClipToAxes;

          ChannelInterpolationStyleComboBox.AsInteger             := ord((iChannelObject as TiPlotChannel).InterpolationStyle);
          {$IFDEF iVCL}
          ChannelOPCXValueSourceComboBox.AsInteger                := ord((iChannelObject as TiPlotChannel).OPCXValueSource);

          iOPCBrowserPanel.SetGroupName   (0, (iChannelObject as TiPlotChannel).OPCGroupName);
          iOPCBrowserPanel.SetComputerName(0, (iChannelObject as TiPlotChannel).OPCComputerName);
          iOPCBrowserPanel.SetServerName  (0, (iChannelObject as TiPlotChannel).OPCServerName);
          iOPCBrowserPanel.SetItemName    (0, (iChannelObject as TiPlotChannel).OPCItemName);
          iOPCBrowserPanel.SetUpdateRate  (0, (iChannelObject as TiPlotChannel).OPCUpdateRate);
          iOPCBrowserPanel.SetScalar      (0, (iChannelObject as TiPlotChannel).OPCScalar);
          iOPCBrowserPanel.SetOffset      (0, (iChannelObject as TiPlotChannel).OPCOffset);
          iOPCBrowserPanel.SetAutoConnect (0, (iChannelObject as TiPlotChannel).OPCAutoConnect);
          iOPCBrowserPanel.SetItem2Name   (0, (iChannelObject as TiPlotChannel).OPCItem2Name);
          iOPCBrowserPanel.SetScalar2     (0, (iChannelObject as TiPlotChannel).OPCScalar2);
          iOPCBrowserPanel.SetOffset2     (0, (iChannelObject as TiPlotChannel).OPCOffset2);
          iOPCBrowserPanel.UpdateItemEdit;
          {$endif}
        end;

      ChannelXAxisNameComboBox.ItemIndex := ChannelXAxisNameComboBox.Items.IndexOf(iChannelObject.XAxisName);
      ChannelYAxisNameComboBox.ItemIndex := ChannelYAxisNameComboBox.Items.IndexOf(iChannelObject.YAxisName);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.UpdateDataCursorEdit;
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

      DataCursorNameEdit.AsString                              := iDataCursor.Name;
      DataCursorPopupEnabledCheckBox.AsBoolean                 := iDataCursor.PopupEnabled;
      DataCursorUserCanEditCheckBox.AsBoolean                  := iDataCursor.UserCanEdit;
      DataCursorCanFocusCheckBox.AsBoolean                     := iDataCursor.CanFocus;
      DataCursorSnapToDataPointCheckBox.AsBoolean              := iDataCursor.SnapToDataPoint;
      DataCursorUseCachedInterpolatedDataCheckBox.AsBoolean    := iDataCursor.UseCachedInterpolatedData;

      DataCursorStyleComboBox.AsInteger                        := ord(iDataCursor.Style);
      DataCursorColorPicker.Color                              := iDataCursor.Color;
      DataCursorUseChannelColorCheckBox.AsBoolean              := iDataCursor.UseChannelColor;

      DataCursorHintPositionEdit.AsFloat                       := iDataCursor.HintPosition;
      DataCursorHintShowCheckBox.AsBoolean                     := iDataCursor.HintShow;
      DataCursorHintHideOnReleaseCheckBox.AsBoolean            := iDataCursor.HintHideOnRelease;
      DataCursorOrientationSideRadioGroup.AsInteger            := ord(iDataCursor.HintOrientationSide);
      DataCursorPointer1PositionEdit.AsFloat                   := iDataCursor.Pointer1Position;
      DataCursorPointer2PositionEdit.AsFloat                   := iDataCursor.Pointer2Position;
      DataCursorPointerPenWidthEdit.AsInteger                  := iDataCursor.PointerPenWidth;

      DataCursorMenuItemVisibleValueXYCheckBox.AsBoolean       := iDataCursor.MenuItemVisibleValueXY;
      DataCursorMenuItemVisibleValueXCheckBox.AsBoolean        := iDataCursor.MenuItemVisibleValueX;
      DataCursorMenuItemVisibleValueYCheckBox.AsBoolean        := iDataCursor.MenuItemVisibleValueY;
      DataCursorMenuItemVisibleDeltaXCheckBox.AsBoolean        := iDataCursor.MenuItemVisibleDeltaX;
      DataCursorMenuItemVisibleDeltaYCheckBox.AsBoolean        := iDataCursor.MenuItemVisibleDeltaY;
      DataCursorMenuItemVisibleInverseDeltaXCheckBox.AsBoolean := iDataCursor.MenuItemVisibleInverseDeltaX;
      DataCursorMenuItemShowOptionsCheckBox.AsBoolean          := iDataCursor.MenuUserCanChangeOptions;

      DataCursorMenuItemCaptionValueXYCheckBox.AsString        := iDataCursor.MenuItemCaptionValueXY;
      DataCursorMenuItemCaptionValueXCheckBox.AsString         := iDataCursor.MenuItemCaptionValueX;
      DataCursorMenuItemCaptionValueYCheckBox.AsString         := iDataCursor.MenuItemCaptionValueY;
      DataCursorMenuItemCaptionDeltaXCheckBox.AsString         := iDataCursor.MenuItemCaptionDeltaX;
      DataCursorMenuItemCaptionDeltaYCheckBox.AsString         := iDataCursor.MenuItemCaptionDeltaY;
      DataCursorMenuItemCaptionInverseDeltaYCheckBox.AsString  := iDataCursor.MenuItemCaptionInverseDeltaX;

      DataCursorChannelAllowAllCheckBox.AsBoolean              := iDataCursor.ChannelAllowAll;
      DataCursorChannelShowAllInLegendCheckBox.AsBoolean       := iDataCursor.ChannelShowAllInLegend;

      DataCursorFontPicker.Font.Assign(iDataCursor.Font);

      DataCursorChannelNameComboBox.ItemIndex := DataCursorChannelNameComboBox.Items.IndexOf(iDataCursor.ChannelName);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.UpdateLimitEdit;
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

      LimitNameEdit.AsString                           := iLimit.Name;
      LimitVisibleCheckBox.AsBoolean                   := iLimit.Visible;
      LimitUserCanMoveCheckBox.AsBoolean               := iLimit.UserCanMove;
      LimitClipToAxesCheckBox.AsBoolean                := iLimit.ClipToAxes;
      LimitPopUpEnabledCheckBox.AsBoolean              := iLimit.PopupEnabled;
      LimitUserCanEditCheckBox.AsBoolean               := iLimit.UserCanEdit;
      LimitSelectModeOnlyInteractionCheckBox.AsBoolean := iLimit.SelectModeOnlyInteraction;
      LimitCanFocusCheckBox.AsBoolean                  := iLimit.CanFocus;
      LimitLayerEdit.AsInteger                         := iLimit.Layer;

      LimitStyleComboBox.AsInteger                     := ord(iLimit.Style);
      LimitLine1PositionEdit.AsFloat                   := iLimit.Line1Position;
      LimitLine2PositionEdit.AsFloat                   := iLimit.Line2Position;

      LimitFillStyleCombobox.AsInteger                 := ord(iLimit.FillStyle);
      LimitLineStyleComboBox.AsInteger                 := ord(iLimit.LineStyle);
      LimitLineWidthEdit.AsInteger                     := iLimit.LineWidth;
      LimitColorPicker.Color                           := iLimit.Color;

      LimitXAxisNameComboBox.ItemIndex := LimitXAxisNameComboBox.Items.IndexOf(iLimit.XAxisName);
      LimitYAxisNameComboBox.ItemIndex := LimitYAxisNameComboBox.Items.IndexOf(iLimit.YAxisName);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.UpdateLabelEdit;
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

      LabelNameEdit.AsString             := iLable.Name;
      LabelVisibleCheckBox.AsBoolean     := iLable.Visible;
      LabelUserCanEditCheckBox.AsBoolean := iLable.UserCanEdit;
      LabelCanFocusCheckBox.AsBoolean    := iLable.CanFocus;
      LabelCaptionMemo.AsString          := iLable.Caption;
      LabelMarginLeftEdit.AsFloat        := iLable.MarginLeft;
      LabelMarginTopEdit.AsFloat         := iLable.MarginTop;
      LabelMarginRightEdit.AsFloat       := iLable.MarginRight;
      LabelMarginBottomEdit.AsFloat      := iLable.MarginBottom;
      LabelAlignmentComboBox.AsInteger   := ord(iLable.Alignment);
      LabelImageListIndexEdit.AsInteger  := iLable.ImageListIndex;
      LabelImageIndexEdit.AsInteger      := iLable.ImageIndex;

      LabelFontPicker.Font.Assign(iLable.Font);

      if LabelListBox.ItemIndex = 0 then LabelRemoveButton.Enabled := False;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.UpdateTranslationEdit;
var
  iTranslationObject : TiPlotTranslationObject;
begin
  if TranslationListBox.ItemIndex = - 1 then
    begin
      DisableAllEditControlsStartingWith('Translation');
    end
  else
    begin
      EnableAllEditControlsStartingWith('Translation');

      iTranslationObject := TranslationListBox.Items.Objects[TranslationListBox.ItemIndex] as TiPlotTranslationObject;

      TranslationOriginalStringEdit.AsString    := iTranslationObject.OriginalString;
      TranslationReplacementStringEdit.AsString := iTranslationObject.ReplacementString;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ToolBarChange(Sender: TObject);
var
  iToolBar : TiPlotToolBar;
begin
  if ToolBarListBox.ItemIndex = -1 then exit;

  iToolBar := ToolBarListBox.Items.Objects[ToolBarListBox.ItemIndex] as TiPlotToolBar;

  iToolBar.Name                 := ToolBarNameEdit.AsString;
  iToolBar.Visible              := ToolBarVisibleCheckbox.AsBoolean;
  iToolBar.Enabled              := ToolBarEnabledCheckBox.AsBoolean;
  iToolBar.PopupEnabled         := ToolBarPopupEnabledCheckBox.AsBoolean;
  iToolBar.UserCanEdit          := ToolBarUserCanEditCheckBox.AsBoolean;
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
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.LegendChange(Sender: TObject);
var
  iLegend : TiPlotLegend;
begin
  if LegendListBox.ItemIndex = -1 then exit;

  iLegend := LegendListBox.Items.Objects[LegendListBox.ItemIndex] as TiPlotLegend;

  iLegend.Name                        := LegendNameEdit.AsString;
  iLegend.Visible                     := LegendVisibleCheckbox.AsBoolean;
  iLegend.Enabled                     := LegendEnabledCheckbox.AsBoolean;
  iLegend.PopupEnabled                := LegendPopupEnabledCheckbox.AsBoolean;
  iLegend.UserCanEdit                 := LegendUserCanEditCheckBox.AsBoolean;
  iLegend.CanFocus                    := LegendCanFocusCheckbox.AsBoolean;

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

  iLegend.ColumnTitlesVisible         := LegendColumnTitlesVisibleCheckbox.AsBoolean;

  iLegend.CaptionColumnTitle          := LegendCaptionColumnTitleEdit.AsString;
  iLegend.CaptionColumnXAxisTitle     := LegendCaptionColumnXAxisTitleEdit.AsString;
  iLegend.CaptionColumnYAxisTitle     := LegendCaptionColumnYAxisTitleEdit.AsString;
  iLegend.CaptionColumnXValue         := LegendCaptionColumnXValueEdit.AsString;
  iLegend.CaptionColumnYValue         := LegendCaptionColumnYValueEdit.AsString;
  iLegend.CaptionColumnYMax           := LegendCaptionColumnYMaxEdit.AsString;
  iLegend.CaptionColumnYMin           := LegendCaptionColumnYMinEdit.AsString;
  iLegend.CaptionColumnYMean          := LegendCaptionColumnYMeanEdit.AsString;

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

  iLegend.Font.Assign            (LegendFontPicker.Font);
  iLegend.SelectedItemFont.Assign(LegendSelectedItemFontPicker.Font);
  iLegend.ColumnTitlesFont.Assign(LegendColumnTitlesFontPicker.Font);

  UpdateLegendEdit;
  LegendListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.TableChange(Sender: TObject);
var
  iTable : TiPlotTable;
begin
  if TableListBox.ItemIndex = -1 then exit;

  iTable := TableListBox.Items.Objects[TableListBox.ItemIndex] as TiPlotTable;

  iTable.Name                      := TableNameEdit.AsString;
  iTable.Visible                   := TableVisibleCheckbox.AsBoolean;
  iTable.Enabled                   := TableEnabledCheckbox.AsBoolean;
  iTable.PopupEnabled              := TablePopupEnabledCheckbox.AsBoolean;
  iTable.UserCanEdit               := TableUserCanEditCheckBox.AsBoolean;
  iTable.CanFocus                  := TableCanFocusCheckbox.AsBoolean;

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
procedure TiPlotComponentEditorForm.XAxisChange(Sender: TObject);
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
  iAxis.MasterUIInput             := XAxisMasterUIInputCheckBox.AsBoolean;
  iAxis.UserCanEdit               := XAxisUserCanEditCheckBox.AsBoolean;
  iAxis.CanFocus                  := XAxisCanFocusCheckBox.AsBoolean;
  iAxis.Layer                     := XAxisLayerEdit.AsInteger;

  iAxis.StartPercent              := XAxisStartPercentEdit.AsFloat;
  iAxis.StopPercent               := XAxisStopPercentEdit.AsFloat;

  iAxis.Min                       := XAxisMinEdit.AsFloat;
  iAxis.Span                      := XAxisSpanEdit.AsFloat;
  iAxis.DesiredStart              := XAxisDesiredStartEdit.AsFloat;
  iAxis.DesiredIncrement          := XAxisDesiredIncrementEdit.AsFloat;
  iAxis.ReverseScale              := XAxisReverseScaleCheckBox.AsBoolean;
  iAxis.RestoreValuesOnResume     := XAxisRestoreValuesOnResumeCheckBox.AsBoolean;
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

  iAxis.LabelsRotation            := TiRotationAngle(XAxisLabelRotationComboBox.AsInteger);
  iAxis.LabelsFormatStyle         := TiPlotTextFormat(XAxisLabelFormatStyleComboBox.AsInteger);
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

  UpdateXAxesEdit;
  XAxisListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.YAxisChange(Sender: TObject);
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
  iAxis.MasterUIInput             := YAxisMasterUIInputCheckBox.AsBoolean;
  iAxis.UserCanEdit               := YAxisUserCanEditCheckBox.AsBoolean;
  iAxis.CanFocus                  := YAxisCanFocusCheckBox.AsBoolean;
  iAxis.Layer                     := YAxisLayerEdit.AsInteger;

  iAxis.StartPercent              := YAxisStartPercentEdit.AsFloat;
  iAxis.StopPercent               := YAxisStopPercentEdit.AsFloat;

  iAxis.Min                       := YAxisMinEdit.AsFloat;
  iAxis.Span                      := YAxisSpanEdit.AsFloat;
  iAxis.DesiredIncrement          := YAxisDesiredIncrementEdit.AsFloat;
  iAxis.DesiredStart              := YAxisDesiredStartEdit.AsFloat;
  iAxis.ReverseScale              := YAxisReverseScaleCheckBox.AsBoolean;
  iAxis.RestoreValuesOnResume     := YAxisRestoreValuesOnResumeCheckBox.AsBoolean;
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

  UpdateYAxesEdit;
  YAxisListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.DataViewChange(Sender: TObject);
var
  iDataView : TiPlotDataView;
begin
  if DataViewListBox.ItemIndex = -1 then exit;

  iDataView := DataViewListBox.Items.Objects[DataViewListBox.ItemIndex] as TiPlotDataView;

  iDataView.Name                         := DataViewNameEdit.AsString;
  iDataView.Enabled                      := DataViewEnabledCheckBox.AsBoolean;
  iDataView.PopupEnabled                 := DataViewPopupEnabledCheckBox.AsBoolean;
  iDataView.UserCanEdit                  := DataViewUserCanEditCheckBox.AsBoolean;
  iDataView.CanFocus                     := DataViewCanFocusCheckBox.AsBoolean;
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
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ChannelChange(Sender: TObject);
var
  iChannelObject : TiPlotChannelCustom;
begin
  if ChannelListBox.ItemIndex = -1 then exit;

  iChannelObject := ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom;

  iChannelObject.Name                        := ChannelNameEdit.AsString;
  iChannelObject.Visible                     := ChannelVisibleCheckBox.AsBoolean;
  iChannelObject.PopupEnabled                := ChannelPopupEnabledCheckBox.AsBoolean;
  iChannelObject.UserCanEdit                 := ChannelUserCanEditCheckBox.AsBoolean;
  iChannelObject.CanFocus                    := ChannelCanFocusCheckBox.AsBoolean;
  iChannelObject.Layer                       := ChannelLayerEdit.AsInteger;

  iChannelObject.TitleText                   := ChannelTitleEdit.AsString;
  iChannelObject.VisibleInLegend             := ChannelVisibleInLegendCheckBox.AsBoolean;
  iChannelObject.ShowDataPointHints          := ChannelShowDataPointHintsCheckBox.AsBoolean;
  iChannelObject.UserCanMoveDataPoints       := ChannelUserCanMoveDataPointsCheckBox.AsBoolean;
  iChannelObject.UserCanMoveDataPointsStyle  := TiPlotChannelDataPointMoveStyle(ChannelUserCanMoveDataPointsStyleComboBox.AsInteger);
  iChannelObject.RingBufferSize              := ChannelRingBufferSizeEdit.AsInteger;
  iChannelObject.Color                       := ChannelColorPicker.Color;
  iChannelObject.XAxisName                   := ChannelXAxisNameComboBox.AsString;
  iChannelObject.YAxisName                   := ChannelYAxisNameComboBox.AsString;
  iChannelObject.XAxisTrackingEnabled        := ChannelXAxisTrackingEnabled.AsBoolean;
  iChannelObject.YAxisTrackingEnabled        := ChannelYAxisTrackingEnabled.AsBoolean;
  iChannelObject.DataStyle                   := TiPlotDataStyle(ChannelDataStyleComboBox.AsInteger);

  iChannelObject.TraceLineStyle              := TiPlotLineStyle(ChannelTraceLineStyleComboBox.AsInteger);
  iChannelObject.TraceVisible                := ChannelTraceVisibleCheckBox.AsBoolean;
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

  if (FMaster.ChannelClass = TiXYPlotChannel) or (TiOPCXValueSourceStyle(ChannelOPCXValueSourceComboBox.AsInteger) = iopcxvsOPCItem) then
    begin
      iOPCBrowserPanel.Item2Visible := True;
      iOPCBrowserPanel.ItemCaption  := 'Item (X-Axis)';
    end
  else
    begin
      iOPCBrowserPanel.ItemCaption  := 'Item';
      iOPCBrowserPanel.Item2Visible := False;
    end;

  if iChannelObject is TiXYPlotChannel then
    begin
      {$IFDEF iVCL}
      (iChannelObject as TiXYPlotChannel).OPCItem2Name    := iOPCBrowserPanel.GetItem2Name(0);
      (iChannelObject as TiXYPlotChannel).OPCComputerName := iOPCBrowserPanel.GetComputerName(0);
      (iChannelObject as TiXYPlotChannel).OPCServerName   := iOPCBrowserPanel.GetServerName(0);
      (iChannelObject as TiXYPlotChannel).OPCItemName     := iOPCBrowserPanel.GetItemName(0);
      (iChannelObject as TiXYPlotChannel).OPCUpdateRate   := iOPCBrowserPanel.GetUpdateRate(0);
      (iChannelObject as TiXYPlotChannel).OPCScalar       := iOPCBrowserPanel.GetScalar(0);
      (iChannelObject as TiXYPlotChannel).OPCOffset       := iOPCBrowserPanel.GetOffset(0);
      (iChannelObject as TiXYPlotChannel).OPCScalar2      := iOPCBrowserPanel.GetScalar2(0);
      (iChannelObject as TiXYPlotChannel).OPCOffset2      := iOPCBrowserPanel.GetOffset2(0);
      (iChannelObject as TiXYPlotChannel).OPCAutoConnect  := iOPCBrowserPanel.GetAutoConnect(0);
      {$endif}
    end;

  if iChannelObject is TiPlotChannel then
    begin
      (iChannelObject as TiPlotChannel).FillEnabled                    := ChannelFillEnabledCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).FillReference                  := ChannelFillReferenceEdit.AsFloat;
      (iChannelObject as TiPlotChannel).FillStyle                      := TBrushStyle(ChannelFillStyleComboBox.AsInteger);
      (iChannelObject as TiPlotChannel).FillColor                      := ChannelFillColorPicker.Color;
      (iChannelObject as TiPlotChannel).FillUseChannelColor            := ChannelFillUseChannelColorCheckBox.AsBoolean;

      (iChannelObject as TiPlotChannel).BarEnabled                     := ChannelBarEnabledCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).BarWidth                       := ChannelBarWidthEdit.AsFloat;
      (iChannelObject as TiPlotChannel).BarReference                   := ChannelBarReferenceEdit.AsFloat;
      (iChannelObject as TiPlotChannel).BarPenUseChannelColor          := ChannelBarPenUseChannelColorCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).BarPenStyle                    := TPenStyle(ChannelBarPenStyleComboBox.AsInteger);
      (iChannelObject as TiPlotChannel).BarPenColor                    := ChannelBarPenColorPicker.Color;
      (iChannelObject as TiPlotChannel).BarPenWidth                    := ChannelBarPenWidthEdit.AsInteger;
      (iChannelObject as TiPlotChannel).BarBrushUseChannelColor        := ChannelBarBrushUseChannelColorCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).BarBrushStyle                  := TBrushStyle(ChannelBarBrushStyleComboBox.AsInteger);
      (iChannelObject as TiPlotChannel).BarBrushColor                  := ChannelBarBrushColorPicker.Color;

      (iChannelObject as TiPlotChannel).HighLowStyle                   :=  TiPlotHighLowStyle(ChannelHighLowStyleComboBox.AsInteger);
      (iChannelObject as TiPlotChannel).HighLowEnabled                 :=  ChannelHighLowEnabledCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).HighLowBarColor                :=  ChannelHighLowBarColorPicker.Color;
      (iChannelObject as TiPlotChannel).HighLowBarWidth                :=  ChannelHighLowBarWidthEdit.AsFloat;
      (iChannelObject as TiPlotChannel).HighLowOpenShow                :=  ChannelHighLowOpenShowCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).HighLowOpenColor               :=  ChannelHighLowOpenColorPicker.Color;
      (iChannelObject as TiPlotChannel).HighLowOpenWidth               :=  ChannelHighLowOpenWidthEdit.AsFloat;
      (iChannelObject as TiPlotChannel).HighLowOpenHeight              :=  ChannelHighLowOpenHeightEdit.AsFloat;
      (iChannelObject as TiPlotChannel).HighLowCloseShow               :=  ChannelHighLowCloseShowCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).HighLowCloseColor              :=  ChannelHighLowCloseColorPicker.Color;
      (iChannelObject as TiPlotChannel).HighLowCloseWidth              :=  ChannelHighLowCloseWidthEdit.AsFloat;
      (iChannelObject as TiPlotChannel).HighLowCloseHeight             :=  ChannelHighLowCloseHeightEdit.AsFloat;
      (iChannelObject as TiPlotChannel).HighLowShadowColor             :=  ChannelHighLowShadowColorPicker.Color;
      (iChannelObject as TiPlotChannel).HighLowBullishColor            :=  ChannelHighLowBullishColorPicker.Color;
      (iChannelObject as TiPlotChannel).HighLowBearishColor            :=  ChannelHighLowBearishColorPicker.Color;

      (iChannelObject as TiPlotChannel).DigitalEnabled                 := ChannelDigitalEnabledCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).DigitalReferenceHigh           := ChannelDigitalReferenceHighEdit.AsFloat;
      (iChannelObject as TiPlotChannel).DigitalReferenceLow            := ChannelDigitalReferenceLowEdit.AsFloat;
      (iChannelObject as TiPlotChannel).DigitalReferenceStyle          := TiPlotDigitalReferenceStyle(ChannelDigitalReferenceStyleComboBox.AsInteger);

      (iChannelObject as TiPlotChannel).FastDrawEnabled                := ChannelFastDrawCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).DrawOutOfOrderXValues          := ChannelDrawOutOfOrderXValuesCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).AllowOutOfOrderXValues         := ChannelAllowOutOfOrderXValuesCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).ResetStartTimeOnFirstDataPoint := ChannelResetStartTimeOnFirstDataPointCheckBox.AsBoolean;
      (iChannelObject as TiPlotChannel).ClipToAxes                     := ChannelClipToAxesCheckBox.AsBoolean;

      (iChannelObject as TiPlotChannel).InterpolationStyle             := TiPlotInterpolationStyle(ChannelInterpolationStyleComboBox.AsInteger);
      {$IFDEF iVCL}
      (iChannelObject as TiPlotChannel).OPCXValueSource                := TiOPCXValueSourceStyle  (ChannelOPCXValueSourceComboBox.AsInteger);

      (iChannelObject as TiPlotChannel).OPCGroupName                   := iOPCBrowserPanel.GetGroupName(0);
      (iChannelObject as TiPlotChannel).OPCComputerName                := iOPCBrowserPanel.GetComputerName(0);
      (iChannelObject as TiPlotChannel).OPCServerName                  := iOPCBrowserPanel.GetServerName(0);
      (iChannelObject as TiPlotChannel).OPCItemName                    := iOPCBrowserPanel.GetItemName(0);
      (iChannelObject as TiPlotChannel).OPCUpdateRate                  := iOPCBrowserPanel.GetUpdateRate(0);
      (iChannelObject as TiPlotChannel).OPCScalar                      := iOPCBrowserPanel.GetScalar(0);
      (iChannelObject as TiPlotChannel).OPCOffset                      := iOPCBrowserPanel.GetOffset(0);
      (iChannelObject as TiPlotChannel).OPCAutoConnect                 := iOPCBrowserPanel.GetAutoConnect(0);
      (iChannelObject as TiPlotChannel).OPCItem2Name                   := iOPCBrowserPanel.GetItem2Name(0);
      (iChannelObject as TiPlotChannel).OPCScalar2                     := iOPCBrowserPanel.GetScalar2(0);
      (iChannelObject as TiPlotChannel).OPCOffset2                     := iOPCBrowserPanel.GetOffset2(0);
      {$endif}
    end;

  UpdateChannelEdit;
  ChannelListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.DataCursorChange(Sender: TObject);
var
  iDataCursor : TiPlotDataCursor;
begin
  if DataCursorListBox.ItemIndex = -1 then exit;

  iDataCursor := DataCursorListBox.Items.Objects[DataCursorListBox.ItemIndex] as TiPlotDataCursor;

  iDataCursor.Name                          := DataCursorNameEdit.AsString;
  iDataCursor.PopupEnabled                  := DataCursorPopupEnabledCheckBox.AsBoolean;
  iDataCursor.UserCanEdit                   := DataCursorUserCanEditCheckBox.AsBoolean;
  iDataCursor.CanFocus                      := DataCursorCanFocusCheckBox.AsBoolean;
  iDataCursor.SnapToDataPoint               := DataCursorSnapToDataPointCheckBox.AsBoolean;
  iDataCursor.UseCachedInterpolatedData     := DataCursorUseCachedInterpolatedDataCheckBox.AsBoolean;

  iDataCursor.Style                         := TiPlotDataCursorStyle(DataCursorStyleComboBox.AsInteger);
  iDataCursor.Color                         := DataCursorColorPicker.Color;
  iDataCursor.UseChannelColor               := DataCursorUseChannelColorCheckBox.AsBoolean;
  iDataCursor.HintPosition                  := DataCursorHintPositionEdit.AsFloat;
  iDataCursor.HintShow                      := DataCursorHintShowCheckBox.AsBoolean;
  iDataCursor.HintHideOnRelease             := DataCursorHintHideOnReleaseCheckBox.AsBoolean;
  iDataCursor.HintOrientationSide           := TiOrientationSide(DataCursorOrientationSideRadioGroup.AsInteger);
  iDataCursor.Pointer1Position              := DataCursorPointer1PositionEdit.AsFloat;
  iDataCursor.Pointer2Position              := DataCursorPointer2PositionEdit.AsFloat;
  iDataCursor.PointerPenWidth               := DataCursorPointerPenWidthEdit.AsInteger;

  iDataCursor.MenuItemVisibleValueXY        := DataCursorMenuItemVisibleValueXYCheckBox.AsBoolean;
  iDataCursor.MenuItemVisibleValueX         := DataCursorMenuItemVisibleValueXCheckBox.AsBoolean;
  iDataCursor.MenuItemVisibleValueY         := DataCursorMenuItemVisibleValueYCheckBox.AsBoolean;
  iDataCursor.MenuItemVisibleDeltaX         := DataCursorMenuItemVisibleDeltaXCheckBox.AsBoolean;
  iDataCursor.MenuItemVisibleDeltaY         := DataCursorMenuItemVisibleDeltaYCheckBox.AsBoolean;
  iDataCursor.MenuItemVisibleInverseDeltaX  := DataCursorMenuItemVisibleInverseDeltaXCheckBox.AsBoolean;
  iDataCursor.MenuUserCanChangeOptions      := DataCursorMenuItemShowOptionsCheckBox.AsBoolean;

  iDataCursor.MenuItemCaptionValueXY        := DataCursorMenuItemCaptionValueXYCheckBox.AsString;
  iDataCursor.MenuItemCaptionValueX         := DataCursorMenuItemCaptionValueXCheckBox.AsString;
  iDataCursor.MenuItemCaptionValueY         := DataCursorMenuItemCaptionValueYCheckBox.AsString;
  iDataCursor.MenuItemCaptionDeltaX         := DataCursorMenuItemCaptionDeltaXCheckBox.AsString;
  iDataCursor.MenuItemCaptionDeltaY         := DataCursorMenuItemCaptionDeltaYCheckBox.AsString;
  iDataCursor.MenuItemCaptionInverseDeltaX  := DataCursorMenuItemCaptionInverseDeltaYCheckBox.AsString;

  iDataCursor.ChannelName                   := DataCursorChannelNameComboBox.AsString;
  iDataCursor.ChannelAllowAll               := DataCursorChannelAllowAllCheckBox.AsBoolean;
  iDataCursor.ChannelShowAllInLegend        := DataCursorChannelShowAllInLegendCheckBox.AsBoolean;

  iDataCursor.Font.Assign(DataCursorFontPicker.Font);

  UpdateDataCursorEdit;
  DataCursorListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.LimitChange(Sender: TObject);
var
  iLimit : TiPlotLimit;
begin
  if LimitListBox.ItemIndex = -1 then exit;

  iLimit := LimitListBox.Items.Objects[LimitListBox.ItemIndex] as TiPlotLimit;

  iLimit.Name                      := LimitNameEdit.AsString;
  iLimit.Visible                   := LimitVisibleCheckBox.AsBoolean;
  iLimit.UserCanMove               := LimitUserCanMoveCheckBox.AsBoolean;
  iLimit.ClipToAxes                := LimitClipToAxesCheckBox.AsBoolean;
  iLimit.PopupEnabled              := LimitPopUpEnabledCheckBox.AsBoolean;
  iLimit.UserCanEdit               := LimitUserCanEditCheckBox.AsBoolean;
  iLimit.SelectModeOnlyInteraction := LimitSelectModeOnlyInteractionCheckBox.AsBoolean;
  iLimit.CanFocus                  := LimitCanFocusCheckBox.AsBoolean;
  iLimit.Layer                     := LimitLayerEdit.AsInteger;

  iLimit.Style                     := TiPlotLimitStyle(LimitStyleComboBox.AsInteger);
  iLimit.Line1Position             := LimitLine1PositionEdit.AsFloat;
  iLimit.Line2Position             := LimitLine2PositionEdit.AsFloat;

  iLimit.FillStyle                 := TBrushStyle(LimitFillStyleCombobox.AsInteger);
  iLimit.LineStyle                 := TPenStyle(LimitLineStyleComboBox.AsInteger);
  iLimit.LineWidth                 := LimitLineWidthEdit.AsInteger;
  iLimit.Color                     := LimitColorPicker.Color;

  iLimit.XAxisName                 := LimitXAxisNameComboBox.AsString;
  iLimit.YAxisName                 := LimitYAxisNameComboBox.AsString;

  UpdateLimitEdit;
  LimitListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.LabelChange(Sender: TObject);
var
  iLabel : TiPlotLabel;
begin
  if LabelListBox.ItemIndex = -1 then exit;

  iLabel := LabelListBox.Items.Objects[LabelListBox.ItemIndex] as TiPlotLabel;

  iLabel.Name           := LabelNameEdit.AsString;
  iLabel.Visible        := LabelVisibleCheckBox.AsBoolean;
  iLabel.UserCanEdit    := LabelUserCanEditCheckBox.AsBoolean;
  iLabel.CanFocus       := LabelCanFocusCheckBox.AsBoolean;
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
procedure TiPlotComponentEditorForm.TitleChange(Sender: TObject);
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
procedure TiPlotComponentEditorForm.TranslationChange(Sender: TObject);
var
  iTranslationObject : TiPlotTranslationObject;
begin
  if TranslationListBox.ItemIndex = -1 then exit;

  iTranslationObject := TranslationListBox.Items.Objects[TranslationListBox.ItemIndex] as TiPlotTranslationObject;

  iTranslationObject.OriginalString    := TranslationOriginalStringEdit.AsString;
  iTranslationObject.ReplacementString := TranslationReplacementStringEdit.AsString;

  UpdateTranslationEdit;
  TranslationListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ControlPropertiesSavePickerChange(Sender: TObject);
begin
  CopyPropertiesToComponent(iComponent);
  (iComponent as TiPlotComponent).SavePropertiesToFile(ControlPropertiesSavePicker.FileName);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ControlPropertiesOpenPickerChange(Sender: TObject);
begin
  (iComponent as TiPlotComponent).LoadPropertiesFromFile(ControlPropertiesOpenPicker.FileName);
  CopyPropertiesToForm(iComponent);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ChannelPropertiesSavePickerChange(Sender: TObject);
var
  ChannelObject : TiPlotChannelCustom;
begin
  ChannelObject := (ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom);
  ChannelObject.SavePropertiesToFile(ChannelPropertiesSavePicker.FileName);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ChannelPropertiesOpenPickerChange(Sender: TObject);
var
  ChannelObject : TiPlotChannelCustom;
begin
  ChannelObject := (ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiPlotChannelCustom);
  ChannelObject.LoadPropertiesFromFile(ChannelPropertiesOpenPicker.FileName);
  ChannelListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ChannelLogFileNamePickerChange(Sender: TObject);
begin
  ChannelLogFileNameEdit.Text := ChannelLogFileNamePicker.FileName;
  ChannelChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.iPlotLayoutViewerChange(Sender: TObject);
begin
  Modified := True;
  UpdateXAxesEdit;
  UpdateYAxesEdit;
  UpdateLabelEdit;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.ControlLogFileNamePickerChange(Sender: TObject);
begin
  ControlLogFileNameEdit.Text := ControlLogFileNamePicker.FileName;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.TranslationClearAllButtonClick(Sender: TObject);
begin
  FMaster.TranslationManager.Clear;
  UpdateTranslationEdit;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.TranslationSavePickerChange(Sender: TObject);
begin
  FMaster.TranslationManager.SaveToFile(TranslationSavePicker.FileName);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.iTranslationOpenPickerChange(Sender: TObject);
begin
  FMaster.TranslationManager.LoadFromFile(iTranslationOpenPicker.FileName);
  TranslationListBox.SelectLast;
  UpdateTranslationEdit;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.iPlotLayoutViewerMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FRightClickObject := iPlotLayoutViewer.GetMouseOverBlock(X, Y);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.LayoutPopupMenuPopup(Sender: TObject);
begin
  XYAxesReverseMenuItem.Checked := FMaster.XYAxesReverse;
  DeleteMenuItem.Enabled  := False;
  VisibleMenuItem.Enabled := False;
  EditMenuItem.Enabled    := False;

  if Assigned(FRightClickObject) then
    begin
      if FRightClickObject is TiPlotAxis  then DeleteMenuItem.Enabled := True;
      if FRightClickObject is TiPlotLabel then
        begin
          if FRightClickObject <> FMaster.LabelManager.Items[0] then DeleteMenuItem.Enabled := True;
        end;

      if not (FRightClickObject is TiPlotDataView) then VisibleMenuItem.Enabled := True;
      VisibleMenuItem.Checked := FRightClickObject.Visible;
      EditMenuItem.Enabled    := True;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.AddXAxisMenuItemClick(Sender: TObject);
begin
  FMaster.AddXAxis;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.AddYAxisMenuItemClick(Sender: TObject);
begin
  FMaster.AddYAxis;
  UpdateYAxesEdit;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.AddLabelMenuItemClick(Sender: TObject);
begin
  FMaster.AddLabel;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.DeleteMenuItemClick(Sender: TObject);
begin
  FRightClickObject.Free;
  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.XYAxesReverseMenuItemClick(Sender: TObject);
begin
  FMaster.XYAxesReverse := not FMaster.XYAxesReverse;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.VisibleMenuItemClick(Sender: TObject);
begin
  FRightClickObject.Visible := not FRightClickObject.Visible;
  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.EditMenuItemClick(Sender: TObject);
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
      PageControl.ActivePage := LabelTabSheet;
      LabelListBox.ItemIndex := LabelListBox.Items.IndexOfObject(FRightClickObject);
    end
  else if FRightClickObject is TiPlotDataView then
    begin
      PageControl.ActivePage    := DataViewTabSheet;
      DataViewListBox.ItemIndex := DataViewListBox.Items.IndexOfObject(FRightClickObject);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponentEditorForm.XAxisCursorCopyDefaultButtonClick(Sender: TObject);
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
procedure TiPlotComponentEditorForm.XAxisLegendCopyDefaultButtonClick(Sender: TObject);
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
procedure TiPlotComponentEditorForm.YAxisCursorCopyDefaultButtonClick(Sender: TObject);
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
procedure TiPlotComponentEditorForm.YAxisLegendCopyDefaultButtonClick(Sender: TObject);
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
procedure TiPlotComponentEditorForm.ControlLogFileNameEditUpdate(Sender: TObject);
begin
  ControlLogFileNamePicker.FileName := ControlLogFileNameEdit.AsString;
end;
//****************************************************************************************************************************************************
end.
