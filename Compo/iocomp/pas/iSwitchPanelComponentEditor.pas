{*******************************************************}
{                                                       }
{       TiSwitchPanelComponentEditor                    }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}                 
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchPanelComponentEditor;{$endif}
{$ifdef iCLX}unit QiSwitchPanelComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSwitchPanel,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSwitchPanel,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSwitchPanelComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    EnabledCheckBox: TiComponentEditorCheckBox;
    MouseControlStyleRadioGroup: TiComponentEditorRadioGroup;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label13: TLabel;
    PositionUpDown: TiUpDown;
    PositionEdit: TiComponentEditorEdit;
    Label14: TLabel;
    PositionCountUpDown: TiUpDown;
    PositionCountEdit: TiComponentEditorEdit;
    Label15: TLabel;
    PositionCaption1Edit: TiComponentEditorEdit;
    Label16: TLabel;
    PositionCaption2Edit: TiComponentEditorEdit;
    Label17: TLabel;
    PositionCaption3Edit: TiComponentEditorEdit;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    DesignTabSheet: TTabSheet;
    DesignPageControl: TiComponentEditorPageControl;
    DesignGeneralTabSheet: TTabSheet;
    DesignKnobTabSheet: TTabSheet;
    DesignPanelTabSheet: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    KnobHandleWidthUpDown: TiUpDown;
    Label6: TLabel;
    KnobSideMarginUpDown: TiUpDown;
    KnobRadiusAutoSizeCheckBox: TiComponentEditorCheckBox;
    KnobHandleColorPicker: TiComponentEditorColorPicker;
    KnobOuterColorPicker: TiComponentEditorColorPicker;
    KnobInnerColorPicker: TiComponentEditorColorPicker;
    KnobRadiusEdit: TiComponentEditorEdit;
    KnobHandleWidthEdit: TiComponentEditorEdit;
    KnobSideMarginEdit: TiComponentEditorEdit;
    Label7: TLabel;
    PanelBackGroundColorPicker: TiComponentEditorColorPicker;
    PanelFontActivelPicker: TiComponentEditorFontPicker;
    PanelFontInactivelPicker: TiComponentEditorFontPicker;
    PanelMarginGroupBox: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    PanelMarginTopEdit: TiComponentEditorEdit;
    PanelMarginRowEdit: TiComponentEditorEdit;
    PanelMarginBottomEdit: TiComponentEditorEdit;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    Label11: TLabel;
    BackGroundColorTopPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    Label3: TLabel;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSwitchPanelComponentEditorForm: TiSwitchPanelComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSwitchPanelComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSwitchPanel.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSwitchPanelComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSwitchPanel : TiSwitchPanel;
begin
  iSwitchPanel := Component as TiSwitchPanel;

  EnabledCheckBox.AsBoolean             := iSwitchPanel.Enabled;
  PositionCountEdit.AsInteger           := iSwitchPanel.PositionCount;
  PositionEdit.AsInteger                := iSwitchPanel.Position;
  PositionCaption1Edit.AsString         := iSwitchPanel.PositionCaption1;
  PositionCaption2Edit.AsString         := iSwitchPanel.PositionCaption2;
  PositionCaption3Edit.AsString         := iSwitchPanel.PositionCaption3;

  MouseControlStyleRadioGroup.AsInteger := ord(iSwitchPanel.MouseControlStyle);
  BorderStyleRadioGroup.AsInteger       := ord(iSwitchPanel.BorderStyle);

  BackGroundColorPicker.Color           := iSwitchPanel.BackGroundColor;
  BackGroundColorTopPicker.Color        := iSwitchPanel.BackGroundColorTop;
  AutoFrameRateCheckBox.AsBoolean       := iSwitchPanel.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iSwitchPanel.UpdateFrameRate;

  KnobRadiusAutoSizeCheckBox.AsBoolean  := iSwitchPanel.KnobRadiusAutoSize;
  KnobRadiusEdit.AsInteger              := iSwitchPanel.KnobRadius;
  KnobSideMarginEdit.AsInteger          := iSwitchPanel.KnobSideMargin;
  KnobHandleWidthEdit.AsInteger         := iSwitchPanel.KnobHandleWidth;
  KnobHandleColorPicker.Color           := iSwitchPanel.KnobHandleColor;
  KnobOuterColorPicker.Color            := iSwitchPanel.KnobOuterColor;
  KnobInnerColorPicker.Color            := iSwitchPanel.KnobInnerColor;

  PanelMarginTopEdit.AsFloat            := iSwitchPanel.PanelMarginTop;
  PanelMarginRowEdit.AsFloat            := iSwitchPanel.PanelMarginRow;
  PanelMarginBottomEdit.AsFloat         := iSwitchPanel.PanelMarginBottom;
  PanelBackGroundColorPicker.Color      := iSwitchPanel.PanelBackGroundColor;

  PanelFontActivelPicker.Font.Assign  (iSwitchPanel.PanelFontActive);
  PanelFontInactivelPicker.Font.Assign(iSwitchPanel.PanelFontInactive);

  UpLoadOPCProperties(iSwitchPanel, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSwitchPanelComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSwitchPanel : TiSwitchPanel;
begin
  iSwitchPanel := Component as TiSwitchPanel;

  iSwitchPanel.Enabled                 :=  EnabledCheckBox.AsBoolean;
  iSwitchPanel.PositionCount           :=  PositionCountEdit.AsInteger;
  iSwitchPanel.Position                :=  PositionEdit.AsInteger;
  iSwitchPanel.PositionCaption1        :=  PositionCaption1Edit.AsString;
  iSwitchPanel.PositionCaption2        :=  PositionCaption2Edit.AsString;
  iSwitchPanel.PositionCaption3        :=  PositionCaption3Edit.AsString;

  iSwitchPanel.MouseControlStyle       :=  TiSwitchPanelMouseControlStyle(MouseControlStyleRadioGroup.AsInteger);
  iSwitchPanel.BorderStyle             :=  TiSwitchPanelBorderStyle(BorderStyleRadioGroup.AsInteger);

  iSwitchPanel.BackGroundColor         :=  BackGroundColorPicker.Color;
  iSwitchPanel.BackGroundColorTop      :=  BackGroundColorTopPicker.Color;
  iSwitchPanel.AutoFrameRate           := AutoFrameRateCheckBox.AsBoolean;
  iSwitchPanel.UpdateFrameRate         := UpdateFrameRateEdit.AsInteger;

  iSwitchPanel.KnobRadiusAutoSize      :=  KnobRadiusAutoSizeCheckBox.AsBoolean;
  iSwitchPanel.KnobRadius              :=  KnobRadiusEdit.AsInteger;
  iSwitchPanel.KnobSideMargin          :=  KnobSideMarginEdit.AsInteger;
  iSwitchPanel.KnobHandleWidth         :=  KnobHandleWidthEdit.AsInteger;
  iSwitchPanel.KnobHandleColor         :=  KnobHandleColorPicker.Color;
  iSwitchPanel.KnobOuterColor          :=  KnobOuterColorPicker.Color;
  iSwitchPanel.KnobInnerColor          :=  KnobInnerColorPicker.Color;

  iSwitchPanel.PanelMarginTop          :=  PanelMarginTopEdit.AsFloat;
  iSwitchPanel.PanelMarginRow          :=  PanelMarginRowEdit.AsFloat;
  iSwitchPanel.PanelMarginBottom       :=  PanelMarginBottomEdit.AsFloat;
  iSwitchPanel.PanelBackGroundColor    :=  PanelBackGroundColorPicker.Color;

  iSwitchPanel.PanelFontActive.Assign  (PanelFontActivelPicker.Font);
  iSwitchPanel.PanelFontInactive.Assign(PanelFontInactivelPicker.Font);

  DownLoadOPCProperties(iSwitchPanel, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
