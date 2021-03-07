{*******************************************************}
{                                                       }
{       TiLogGaugeComponentEditor                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLogGaugeComponentEditor;{$endif}
{$ifdef iCLX}unit QiLogGaugeComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iLogGauge,  iGaugePointer,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiLogGauge, QiGaugePointer,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,  iRadioGroup,  iComponent,  iVCLComponent,  iCustomComponent,  iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel, QiRadioGroup, QiComponent, QiCLXComponent, QiCustomComponent, QiCheckBox;{$ENDIF}

type
  TiLogGaugeComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    PositionEdit: TiComponentEditorEdit;
    PositionMaxEdit: TiComponentEditorEdit;
    PositionMinEdit: TiComponentEditorEdit;
    DesignTabSheet: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    CurrentMaxEdit: TiComponentEditorEdit;
    CurrentMinEdit: TiComponentEditorEdit;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    TransparentCheckBox: TiComponentEditorCheckBox;
    CachedDrawingCheckBox: TiComponentEditorCheckBox;
    iAboutPanel1: TiAboutPanel;
    DesignPageControl: TiComponentEditorPageControl;
    DesignGeneralTabSheet: TTabSheet;
    DesignPointersTabSheet: TTabSheet;
    DesignMinMaxTabSheet: TTabSheet;
    DesignTicksTabSheet: TTabSheet;
    DesignSectionsTabSheet: TTabSheet;
    Label10: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    SectionCountUpDown: TiUpDown;
    SectionColor1Picker: TiComponentEditorColorPicker;
    SectionColor2Picker: TiComponentEditorColorPicker;
    SectionColor3Picker: TiComponentEditorColorPicker;
    SectionColor4Picker: TiComponentEditorColorPicker;
    SectionColor5Picker: TiComponentEditorColorPicker;
    SectionEnd1Edit: TiComponentEditorEdit;
    SectionEnd2Edit: TiComponentEditorEdit;
    SectionCountEdit: TiComponentEditorEdit;
    SectionEnd3Edit: TiComponentEditorEdit;
    SectionEnd4Edit: TiComponentEditorEdit;
    Label28: TLabel;
    TickMarginUpDown: TiUpDown;
    LabelsGroupBox: TGroupBox;
    Label15: TLabel;
    Label19: TLabel;
    TickLabelPrecisionUpDown: TiUpDown;
    TickLabelMarginUpDown: TiUpDown;
    TickLabelFontPicker: TiComponentEditorFontPicker;
    TickLabelPrecisionEdit: TiComponentEditorEdit;
    TickLabelMarginEdit: TiComponentEditorEdit;
    TickLabelStyleRadioGroup: TiComponentEditorRadioGroup;
    MinorGroupBox: TGroupBox;
    Label25: TLabel;
    Label27: TLabel;
    TickMinorLengthUpDown: TiUpDown;
    TickMinorColorPicker: TiComponentEditorColorPicker;
    TickMinorLengthEdit: TiComponentEditorEdit;
    TickMinorStyleRadioGroup: TiComponentEditorRadioGroup;
    TickMinorAlignmentRadioGroup: TiComponentEditorRadioGroup;
    TickMarginEdit: TiComponentEditorEdit;
    MajorGroupBox: TGroupBox;
    Label20: TLabel;
    Label24: TLabel;
    TickMajorLengthUpDown: TiUpDown;
    TickMajorColorPicker: TiComponentEditorColorPicker;
    TickMajorLengthEdit: TiComponentEditorEdit;
    TickMajorStyleRadioGroup: TiComponentEditorRadioGroup;
    ShowTicksAxisCheckBox: TiComponentEditorCheckBox;
    iPointerListBox: TiComponentEditorListBox;
    PointersGeneralPageControl: TiComponentEditorPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label4: TLabel;
    PointerOffsetUpDown: TiUpDown;
    PointerSizeUpDown: TiUpDown;
    Label9: TLabel;
    Label50: TLabel;
    PointerOffsetEdit: TiComponentEditorEdit;
    PointerSizeEdit: TiComponentEditorEdit;
    PointerStyleRadioGroup: TiComponentEditorRadioGroup;
    PointerColorPicker: TiComponentEditorColorPicker;
    PointerPositionEdit: TiComponentEditorEdit;
    iPointerAddButton: TButton;
    PointerRemoveButton: TButton;
    Label2: TLabel;
    Label11: TLabel;
    MinMaxPointerSizeUpDown: TiUpDown;
    MinMaxPointerMarginUpDown: TiUpDown;
    MinMaxPointerSizeEdit: TiComponentEditorEdit;
    MinMaxPointerMarginEdit: TiComponentEditorEdit;
    MaxGroupBox: TGroupBox;
    Label7: TLabel;
    MaxPointerColorPicker: TiComponentEditorColorPicker;
    ShowMaxPointerCheckBox: TiComponentEditorCheckBox;
    MinGroupBox: TGroupBox;
    Label8: TLabel;
    MinPointerColorPicker: TiComponentEditorColorPicker;
    ShowMinPointerCheckBox: TiComponentEditorCheckBox;
    MinMaxFixedCheckBox: TiComponentEditorCheckBox;
    MinMaxUserCanMoveCheckBox: TiComponentEditorCheckBox;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    Label3: TLabel;
    Label29: TLabel;
    EndsMarginUpDown: TiUpDown;
    OrientationRadioGroup: TiComponentEditorRadioGroup;
    OrientationTickMarksRadioGroup: TiComponentEditorRadioGroup;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    OffsetGroupBox: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    OffsetXUpDown: TiUpDown;
    OffsetYUpDown: TiUpDown;
    OffsetXEdit: TiComponentEditorEdit;
    OffsetYEdit: TiComponentEditorEdit;
    ReverseScaleCheckBox: TiComponentEditorCheckBox;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    EndsMarginEdit: TiComponentEditorEdit;
    AutoCenterCheckBox: TiComponentEditorCheckBox;
    PointerVisibleCheckBox: TiComponentEditorCheckBox;
    PointerUserCanMoveCheckBox: TiComponentEditorCheckBox;
    procedure iComponentEditorFormCreate(Sender: TObject);
    procedure iComponentEditorFormDestroy(Sender: TObject);
    procedure iPointerListBoxClick(Sender: TObject);
    procedure iPointerListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure iPointerAddButtonClick(Sender: TObject);
    procedure PointerRemoveButtonClick(Sender: TObject);
    procedure PositionEditChange(Sender: TObject);
    procedure PointerChange(Sender: TObject);
  private
    FPointerManager   : TiGaugePointerManager;
    FLastPointerIndex : Integer;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;

    procedure InsertEvent(Sender: TObject);
    procedure RemoveEvent(Sender: TObject);
    procedure ChangeEvent(Sender: TObject);

    procedure UpdatePointers;
  end;

var
  iLogGaugeComponentEditorForm: TiLogGaugeComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiLogGauge.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iLogGauge : TiLogGauge;
  x         : Integer;
begin
  iLogGauge := Component as TiLogGauge;

  //-------------- General ---------------------------------------------------------------------------------------------------------------------------
  PositionEdit.AsFloat                             := iLogGauge.Position;
  PositionMaxEdit.AsFloat                          := iLogGauge.PositionMax;
  PositionMinEdit.AsFloat                          := iLogGauge.PositionMin;
  CurrentMaxEdit.AsFloat                           := iLogGauge.CurrentMax;
  CurrentMinEdit.AsFloat                           := iLogGauge.CurrentMin;
  EndsMarginEdit.AsInteger                         := iLogGauge.EndsMargin;
  BackGroundColorPicker.Color                      := iLogGauge.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean                  := iLogGauge.AutoFrameRate;
  AutoCenterCheckBox.AsBoolean                     := iLogGauge.AutoCenter;
  UpdateFrameRateEdit.AsInteger                    := iLogGauge.UpdateFrameRate;

  BorderStyleRadioGroup.AsInteger                  := ord(iLogGauge.BorderStyle);
  OrientationRadioGroup.AsInteger                  := ord(iLogGauge.Orientation);
  OrientationTickMarksRadioGroup.AsInteger         := ord(iLogGauge.OrientationTickMarks);
  ReverseScaleCheckBox.AsBoolean                   := iLogGauge.ReverseScale;
  CachedDrawingCheckBox.AsBoolean                  := iLogGauge.CachedDrawing;
  TransparentCheckBox.AsBoolean                    := iLogGauge.Transparent;

  OffsetXEdit.AsInteger                            := iLogGauge.OffsetX;
  OffsetYEdit.AsInteger                            := iLogGauge.OffsetY;
  //-------------- Pointers --------------------------------------------------------------------------------------------------------------------------
  PointerOffsetEdit.AsInteger                      := iLogGauge.PointerOffSet;
  PointerSizeEdit.AsInteger                        := iLogGauge.PointerSize;
  PointerStyleRadioGroup.AsInteger                 := ord(iLogGauge.PointerStyle);
  PointerColorPicker.Color                         := iLogGauge.PointerColor;

  MinMaxPointerSizeEdit.AsInteger                  := iLogGauge.MinMaxPointerSize;
  MinMaxPointerMarginEdit.AsInteger                := iLogGauge.MinMaxPointerMargin;
  MinMaxFixedCheckBox.AsBoolean                    := iLogGauge.MinMaxFixed;
  MinMaxUserCanMoveCheckBox.AsBoolean              := iLogGauge.MinMaxUserCanMove;

  ShowMaxPointerCheckBox.AsBoolean                 := iLogGauge.ShowMaxPointer;
  MaxPointerColorPicker.Color                      := iLogGauge.MaxPointerColor;

  ShowMinPointerCheckBox.AsBoolean                 := iLogGauge.ShowMinPointer;
  MinPointerColorPicker.Color                      := iLogGauge.MinPointerColor;
  //-------------- Ticks -----------------------------------------------------------------------------------------------------------------------------
  ShowTicksAxisCheckBox.AsBoolean                  := iLogGauge.ShowTicksAxis;
  TickMarginEdit.AsInteger                         := iLogGauge.TickMargin;

  TickLabelPrecisionEdit.AsInteger                 := iLogGauge.TickLabelPrecision;
  TickLabelMarginEdit.AsInteger                    := iLogGauge.TickLabelMargin;
  TickLabelStyleRadioGroup.AsInteger               := ord(iLogGauge.TickLabelStyle);

  TickMajorLengthEdit.AsInteger                    := iLogGauge.TickMajorLength;
  TickMajorColorPicker.Color                       := iLogGauge.TickMajorColor;
  TickMajorStyleRadioGroup.AsInteger               := ord(iLogGauge.TickMajorStyle);

  TickMinorLengthEdit.AsInteger                    := iLogGauge.TickMinorLength;
  TickMinorColorPicker.Color                       := iLogGauge.TickMinorColor;
  TickMinorAlignmentRadioGroup.AsInteger           := ord(iLogGauge.TickMinorAlignment);
  TickMinorStyleRadioGroup.AsInteger               := ord(iLogGauge.TickMinorStyle);
  //-------------- Sections --------------------------------------------------------------------------------------------------------------------------
  SectionCountEdit.AsInteger                       := iLogGauge.SectionCount;
  SectionColor1Picker.Color                        := iLogGauge.SectionColor1;
  SectionColor2Picker.Color                        := iLogGauge.SectionColor2;
  SectionColor3Picker.Color                        := iLogGauge.SectionColor3;
  SectionColor4Picker.Color                        := iLogGauge.SectionColor4;
  SectionColor5Picker.Color                        := iLogGauge.SectionColor5;

  SectionEnd1Edit.AsFloat                          := iLogGauge.SectionEnd1;
  SectionEnd2Edit.AsFloat                          := iLogGauge.SectionEnd2;
  SectionEnd3Edit.AsFloat                          := iLogGauge.SectionEnd3;
  SectionEnd4Edit.AsFloat                          := iLogGauge.SectionEnd4;

  UpLoadOPCProperties(iLogGauge, iOPCBrowserPanel);

  FPointerManager.Clear;

  for x := 0 to iLogGauge.PointerCount-1 do
    begin
      FPointerManager.Add;
      FPointerManager.Items[x].Visible     := iLogGauge.Pointers[x].Visible;
      FPointerManager.Items[x].UserCanMove := iLogGauge.Pointers[x].UserCanMove;
      FPointerManager.Items[x].Position    := iLogGauge.Pointers[x].Position;
      FPointerManager.Items[x].Size        := iLogGauge.Pointers[x].Size;
      FPointerManager.Items[x].Margin      := iLogGauge.Pointers[x].Margin;
      FPointerManager.Items[x].Color       := iLogGauge.Pointers[x].Color;
      FPointerManager.Items[x].Style       := iLogGauge.Pointers[x].Style;
    end;

  TickLabelFontPicker.Font.Assign(iLogGauge.TickLabelFont);

  if iPointerListBox.Items.Count > FLastPointerIndex then iPointerListBox.ItemIndex := FLastPointerIndex;

  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iLogGauge : TiLogGauge;
  x         : Integer;
begin
  iLogGauge := Component as TiLogGauge;

  //-------------- General ---------------------------------------------------------------------------------------------------------------------------
  iLogGauge.Position                 := PositionEdit.AsFloat;
  iLogGauge.PositionMax              := PositionMaxEdit.AsFloat;
  iLogGauge.PositionMin              := PositionMinEdit.AsFloat;
  iLogGauge.CurrentMax               := CurrentMaxEdit.AsFloat;
  iLogGauge.CurrentMin               := CurrentMinEdit.AsFloat;
  iLogGauge.EndsMargin               := EndsMarginEdit.AsInteger;
  iLogGauge.BackGroundColor          := BackGroundColorPicker.Color;
  iLogGauge.AutoFrameRate            := AutoFrameRateCheckBox.AsBoolean;
  iLogGauge.AutoCenter               := AutoCenterCheckBox.AsBoolean;
  iLogGauge.UpdateFrameRate          := UpdateFrameRateEdit.AsInteger;

  iLogGauge.BorderStyle              := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iLogGauge.Orientation              := TiOrientation(OrientationRadioGroup.AsInteger);
  iLogGauge.OrientationTickMarks     := TiOrientationSide(OrientationTickMarksRadioGroup.AsInteger);
  iLogGauge.ReverseScale             := ReverseScaleCheckBox.AsBoolean;
  iLogGauge.CachedDrawing            := CachedDrawingCheckBox.AsBoolean;
  iLogGauge.Transparent              := TransparentCheckBox.AsBoolean;

  iLogGauge.OffsetX                  := OffsetXEdit.AsInteger;
  iLogGauge.OffsetY                  := OffsetYEdit.AsInteger;
  //-------------- Pointers --------------------------------------------------------------------------------------------------------------------------
  iLogGauge.PointerOffSet            := PointerOffsetEdit.AsInteger;
  iLogGauge.PointerSize              := PointerSizeEdit.AsInteger;
  iLogGauge.PointerStyle             := TiLinearGaugePointerStyle(PointerStyleRadioGroup.AsInteger);
  iLogGauge.PointerColor             := PointerColorPicker.Color;

  iLogGauge.MinMaxPointerSize        := MinMaxPointerSizeEdit.AsInteger;
  iLogGauge.MinMaxPointerMargin      := MinMaxPointerMarginEdit.AsInteger;
  iLogGauge.MinMaxFixed              := MinMaxFixedCheckBox.AsBoolean;
  iLogGauge.MinMaxUserCanMove        := MinMaxUserCanMoveCheckBox.AsBoolean;

  iLogGauge.ShowMaxPointer           := ShowMaxPointerCheckBox.AsBoolean;
  iLogGauge.MaxPointerColor          := MaxPointerColorPicker.Color;

  iLogGauge.ShowMinPointer           := ShowMinPointerCheckBox.AsBoolean;
  iLogGauge.MinPointerColor          := MinPointerColorPicker.Color;
  //-------------- Ticks -----------------------------------------------------------------------------------------------------------------------------
  iLogGauge.ShowTicksAxis            := ShowTicksAxisCheckBox.AsBoolean;
  iLogGauge.TickMargin               := TickMarginEdit.AsInteger;

  iLogGauge.TickLabelPrecision       := TickLabelPrecisionEdit.AsInteger;
  iLogGauge.TickLabelMargin          := TickLabelMarginEdit.AsInteger;
  iLogGauge.TickLabelStyle           := TiLogLabelStyle(TickLabelStyleRadioGroup.AsInteger);

  iLogGauge.TickMajorLength          := TickMajorLengthEdit.AsInteger;
  iLogGauge.TickMajorColor           := TickMajorColorPicker.Color;
  iLogGauge.TickMajorStyle           := TiBevelStyle(TickMajorStyleRadioGroup.AsInteger);

  iLogGauge.TickMinorLength          := TickMinorLengthEdit.AsInteger;
  iLogGauge.TickMinorColor           := TickMinorColorPicker.Color;
  iLogGauge.TickMinorAlignment       := TiTickMinorAlignment(TickMinorAlignmentRadioGroup.AsInteger);
  iLogGauge.TickMinorStyle           := TiBevelStyle(TickMinorStyleRadioGroup.AsInteger);
  //-------------- Sections --------------------------------------------------------------------------------------------------------------------------
  iLogGauge.SectionCount             := SectionCountEdit.AsInteger;
  iLogGauge.SectionColor1            := SectionColor1Picker.Color;
  iLogGauge.SectionColor2            := SectionColor2Picker.Color;
  iLogGauge.SectionColor3            := SectionColor3Picker.Color;
  iLogGauge.SectionColor4            := SectionColor4Picker.Color;
  iLogGauge.SectionColor5            := SectionColor5Picker.Color;

  iLogGauge.SectionEnd1              := SectionEnd1Edit.AsFloat;
  iLogGauge.SectionEnd2              := SectionEnd2Edit.AsFloat;
  iLogGauge.SectionEnd3              := SectionEnd3Edit.AsFloat;
  iLogGauge.SectionEnd4              := SectionEnd4Edit.AsFloat;

  DownLoadOPCProperties(iLogGauge, iOPCBrowserPanel);

  iLogGauge.RemoveAllPointers;
  for x := 0 to FPointerManager.Count-1 do
    begin
      if x <> 0 then iLogGauge.AddPointer;

      iLogGauge.Pointers[x].Visible     := FPointerManager.Items[x].Visible;
      iLogGauge.Pointers[x].UserCanMove := FPointerManager.Items[x].UserCanMove;
      iLogGauge.Pointers[x].Position    := FPointerManager.Items[x].Position;
      iLogGauge.Pointers[x].Size        := FPointerManager.Items[x].Size;
      iLogGauge.Pointers[x].Margin      := FPointerManager.Items[x].Margin;
      iLogGauge.Pointers[x].Color       := FPointerManager.Items[x].Color;
      iLogGauge.Pointers[x].Style       := FPointerManager.Items[x].Style;
    end;

  iLogGauge.TickLabelFont.Assign(TickLabelFontPicker.Font);

  FLastPointerIndex := iPointerListBox.ItemIndex;
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.iComponentEditorFormCreate(Sender: TObject);
begin
  FPointerManager := TiGaugePointerManager.Create(ChangeEvent, InsertEvent, RemoveEvent, nil);
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.iComponentEditorFormDestroy(Sender: TObject);
begin
  FPointerManager.Free;
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.iPointerListBoxClick(Sender: TObject);
begin
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.iPointerListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (iPointerListBox.Items.Objects[Index] as TiGaugePointer).Color;
  AText  := 'Pointer(' + IntToStr(Index) + ')';
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.InsertEvent(Sender: TObject);
begin
  if Sender is TiGaugePointer then
    begin
      iPointerListBox.Items.AddObject('',Sender);
      with Sender as TiGaugePointer do
        begin
          Position := 1;
          Size     := 10;
          Color    := clBlue;
          Style    := ord(ilgpsPointer);
        end;
      iPointerListBox.SelectLast;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.RemoveEvent(Sender: TObject);
begin
  iPointerListBox.Items.Delete(iPointerListBox.Items.IndexOfObject(Sender));
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.ChangeEvent(Sender: TObject);
begin

end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.iPointerAddButtonClick(Sender: TObject);
begin
  FPointerManager.Add;
  UpdatePointers;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.PointerRemoveButtonClick(Sender: TObject);
begin
  iPointerListBox.DeleteSelectedObject;
  UpdatePointers;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.PositionEditChange(Sender: TObject);
begin
  FPointerManager.Items[0].Position := PositionEdit.AsFloat;
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.UpdatePointers;
var
  iPointer : TiGaugePointer;
begin
  if iPointerListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Pointer')
    else
      begin
        EnableAllEditControlsStartingWith('Pointer');

        iPointer := iPointerListBox.Items.Objects[iPointerListBox.ItemIndex] as TiGaugePointer;

        PointerVisibleCheckBox.AsBoolean     := iPointer.Visible;
        PointerUserCanMoveCheckBox.AsBoolean := iPointer.UserCanMove;
        PointerPositionEdit.AsFloat          := iPointer.Position;
        PointerSizeEdit.AsInteger            := iPointer.Size;
        PointerOffSetEdit.AsInteger          := iPointer.Margin;
        PointerColorPicker.Color             := iPointer.Color;
        PointerStyleRadioGroup.AsInteger     := iPointer.Style;

        iPointerListBox.Invalidate;

        if iPointerListBox.ItemIndex = 0 then PointerRemoveButton.Enabled := False;
      end;
end;
//****************************************************************************************************************************************************
procedure TiLogGaugeComponentEditorForm.PointerChange(Sender: TObject);
var
  iPointer : TiGaugePointer;
begin
  if iPointerListBox.ItemIndex = -1 then exit;

  iPointer := iPointerListBox.Items.Objects[iPointerListBox.ItemIndex] as TiGaugePointer;

  iPointer.Visible     := PointerVisibleCheckBox.AsBoolean;
  iPointer.UserCanMove := PointerUserCanMoveCheckBox.AsBoolean;
  iPointer.Position    := PointerPositionEdit.AsFloat;
  iPointer.Size        := PointerSizeEdit.AsInteger;
  iPointer.Margin      := PointerOffSetEdit.AsInteger;
  iPointer.Color       := PointerColorPicker.Color;
  iPointer.Style       := PointerStyleRadioGroup.AsInteger;

  if iPointerListBox.ItemIndex = 0 then
    begin
      PositionEdit.AsFloat := PointerPositionEdit.AsFloat;
    end;

  UpdatePointers;
end;
//****************************************************************************************************************************************************
end.
