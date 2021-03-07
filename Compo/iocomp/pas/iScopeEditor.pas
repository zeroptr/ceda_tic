{*******************************************************}
{                                                       }
{       TiScopeComponentEditor                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScopeEditor;{$endif}
{$ifdef iCLX}unit QiScopeEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL}  iTypes,  Printers, {$ENDIF}
  {$IFDEF iCLX} QiTypes, QPrinters, {$ENDIF}

  {$IFDEF iVCL} StdCtrls,  Controls,  ComCtrls,  ExtCtrls, Classes,  Menus,  iComponent,  iVCLComponent,  iEditorBasicComponents,  iSpinSelector,
  iRadioGroup, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX}QStdCtrls, QControls, QComCtrls, QExtCtrls, Classes, QMenus, QiComponent, QiCLXComponent, QiEditorBasicComponents, QiSpinSelector;{$ENDIF}

type
  TiScopeEditorForm = class(TiCustomEditorForm)
    PageControl: TiComponentEditorPageControl;
    ControlTabSheet: TTabSheet;
    ChannelsTabSheet: TTabSheet;
    iChannelListBox: TiComponentEditorListBox;
    iChannelAddButton: TButton;
    ChannelRemoveButton: TButton;
    ControlPageControl: TiComponentEditorPageControl;
    ControlGeneralTabSheet: TTabSheet;
    ControlPrintTabSheet: TTabSheet;
    PrinterMarginGroupBox: TGroupBox;
    PrintMarginLeftEdit: TiComponentEditorEdit;
    PrintMarginTopEdit: TiComponentEditorEdit;
    PrintMarginBottomEdit: TiComponentEditorEdit;
    PrintMarginRightEdit: TiComponentEditorEdit;
    PrintOrientationRadioGroup: TiComponentEditorRadioGroup;
    PrintShowDialogCheckBox: TiComponentEditorCheckBox;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    Label175: TLabel;
    PrintDocumentNameEdit: TiComponentEditorEdit;
    ChannelPageControl: TiComponentEditorPageControl;
    ChannelGeneralTabSheet: TTabSheet;
    Label4: TLabel;
    Label6: TLabel;
    ChannelColorPicker: TiComponentEditorColorPicker;
    ChannelTitleEdit: TiComponentEditorEdit;
    TimeBaseTabSheet: TTabSheet;
    TriggerTabSheet: TTabSheet;
    ChannelTraceGroupBox: TGroupBox;
    Label5: TLabel;
    ChannelTraceLineWidthUpDown: TiUpDown;
    ChannelTraceLineWidthEdit: TiComponentEditorEdit;
    ChannelTraceVisibleCheckBox: TiComponentEditorCheckBox;
    Label2: TLabel;
    SamplesPerSecondEdit: TiComponentEditorEdit;
    Label208: TLabel;
    ChannelVoltsPerDivSpinSelector: TiSpinSelector;
    Label7: TLabel;
    ChannelPositionSpinSelector: TiSpinSelector;
    Label3: TLabel;
    ChannelCouplingSpinSelector: TiSpinSelector;
    Label8: TLabel;
    TimeBaseSecPerDivSpinSelector: TiSpinSelector;
    Label9: TLabel;
    TimeBasePositionSpinSelector: TiSpinSelector;
    Label10: TLabel;
    TimeBasePreCaptureSpinSelector: TiSpinSelector;
    Label11: TLabel;
    TimeBasePostCaptureSpinSelector: TiSpinSelector;
    Label12: TLabel;
    TriggerLevelSpinSelector: TiSpinSelector;
    Label13: TLabel;
    TriggerSourceSpinSelector: TiSpinSelector;
    TriggerPositiveSlopeCheckBox: TiComponentEditorCheckBox;
    TriggerAutoCheckBox: TiComponentEditorCheckBox;
    ChannelRefLineShowCheckBox: TiComponentEditorCheckBox;
    ChannelScalerGroupBox: TiComponentEditorGroupBox;
    Label14: TLabel;
    ChannelScalerMultiplierEdit: TiComponentEditorEdit;
    Label15: TLabel;
    ChannelScalerOffsetEdit: TiComponentEditorEdit;
    DisplayTabSheet: TTabSheet;
    Label1: TLabel;
    DisplayGridColorPicker: TiComponentEditorColorPicker;
    DisplayTextShowCheckBox: TiComponentEditorCheckBox;
    DisplayHorzScrollShowCheckBox: TiComponentEditorCheckBox;
    procedure iChannelListBoxClick(Sender: TObject);
    procedure ChannelChange(Sender: TObject);
    procedure iChannelAddButtonClick(Sender: TObject);
    procedure ChannelRemoveButtonClick(Sender: TObject);
    procedure iChannelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure GeneralChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FOnGeneralChange : TNotifyEvent;
    FIsClosing       : Boolean;

    FScope           : TWinControl;

    procedure DisableAllEditControlsStartingWith(Value: String);
    procedure EnableAllEditControlsStartingWith(Value: String);
  protected

  public
    property  OnGeneralChange : TNotifyEvent read FOnGeneralChange write FOnGeneralChange;
    procedure UpdateChannelEdit;

    procedure UpdateAll;

    property  IsClosing : Boolean read FIsClosing;

    property Scope: TwinControl read FScope write FScope;
  end;

implementation

uses                                                                
  {$IFDEF iVCL}iScope,   iScopeChannel;{$endif}
  {$ifdef iCLX}QiScope, QiScopeChannel;{$endif}

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiScopeEditorForm.FormCreate(Sender: TObject);
begin
  {$IFDEF iVCL}BorderStyle := bsDialog; {$endif}
  {$IFDEF iCLX}BorderStyle := fbsDialog;{$endif}
end;
//****************************************************************************************************************************************************
procedure TiScopeEditorForm.UpdateAll;
begin
  UpdateChannelEdit;
end;
//****************************************************************************************************************************************************
procedure TiScopeEditorForm.iChannelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (iChannelListBox.Items.Objects[Index] as TiScopeChannel).Color;
  AText  := (iChannelListBox.Items.Objects[Index] as TiScopeChannel).TitleText;
end;
//****************************************************************************************************************************************************
procedure TiScopeEditorForm.iChannelListBoxClick    (Sender:TObject);begin UpdateChannelEdit;                                      end;
procedure TiScopeEditorForm.iChannelAddButtonClick  (Sender:TObject);begin iChannelListBox.SelectLast;           UpdateChannelEdit;end;
procedure TiScopeEditorForm.ChannelRemoveButtonClick(Sender:TObject);begin iChannelListBox.DeleteSelectedObject; UpdateChannelEdit;end;
//****************************************************************************************************************************************************
procedure TiScopeEditorForm.UpdateChannelEdit;
var
  Channel : TiScopeChannel;
begin
  if iChannelListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Channel')
    else
      begin
        EnableAllEditControlsStartingWith('Channel');

        Channel := iChannelListBox.Items.Objects[iChannelListBox.ItemIndex] as TiScopeChannel;

        ChannelTitleEdit.AsString                := Channel.TitleText;
        ChannelColorPicker.Color                 := Channel.Color;
        ChannelRefLineShowCheckBox.AsBoolean     := Channel.RefLineShow;

        ChannelTraceVisibleCheckBox.AsBoolean    := Channel.TraceVisible;
        ChannelTraceLineWidthEdit.AsInteger      := Channel.TraceLineWidth;

        ChannelScalerMultiplierEdit.AsFloat      := Channel.ScalerMultiplier;
        ChannelScalerOffsetEdit.AsFloat          := Channel.ScalerOffset;

        ChannelVoltsPerDivSpinSelector.Value     := Channel.VoltsPerDivision;
        ChannelPositionSpinSelector.Value        := Channel.Position;

        ChannelCouplingSpinSelector.Value        := ord(Channel.Coupling);

        iChannelListBox.Invalidate;
      end;
end;
//****************************************************************************************************************************************************
procedure TiScopeEditorForm.ChannelChange(Sender: TObject);
var
  Channel : TiScopeChannel;
begin
  if iChannelListBox.ItemIndex = -1 then exit;

  Channel := iChannelListBox.Items.Objects[iChannelListBox.ItemIndex] as TiScopeChannel;

   Channel.TitleText        := ChannelTitleEdit.AsString;
   Channel.Color            := ChannelColorPicker.Color;
   Channel.RefLineShow      := ChannelRefLineShowCheckBox.AsBoolean;

   Channel.TraceVisible     := ChannelTraceVisibleCheckBox.AsBoolean;
   Channel.TraceLineWidth   := ChannelTraceLineWidthEdit.AsInteger;

   Channel.ScalerMultiplier := ChannelScalerMultiplierEdit.AsFloat;
   Channel.ScalerOffset     := ChannelScalerOffsetEdit.AsFloat;

   Channel.VoltsPerDivision := ChannelVoltsPerDivSpinSelector.Value;
   Channel.Position         := ChannelPositionSpinSelector.Value;
   Channel.Coupling         := TiScopeChannelCoupling(Round(ChannelCouplingSpinSelector.Value));

  UpdateAll;
end;
//****************************************************************************************************************************************************
procedure TiScopeEditorForm.DisableAllEditControlsStartingWith(Value: String);
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
procedure TiScopeEditorForm.EnableAllEditControlsStartingWith(Value: String);
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
procedure TiScopeEditorForm.GeneralChanged(Sender: TObject);
begin
  (Scope as TiScope).SamplesPerSecond       := SamplesPerSecondEdit.AsInteger;
  (Scope as TiScope).AutoFrameRate          := AutoFrameRateCheckBox.AsBoolean;
  (Scope as TiScope).UpdateFrameRate        := UpdateFrameRateEdit.AsInteger;

  (Scope as TiScope).PrintOrientation       := TPrinterOrientation(PrintOrientationRadioGroup.AsInteger);
  (Scope as TiScope).PrintShowDialog        := PrintShowDialogCheckBox.AsBoolean;
  (Scope as TiScope).PrintMarginLeft        := PrintMarginLeftEdit.AsFloat;
  (Scope as TiScope).PrintMarginTop         := PrintMarginTopEdit.AsFloat;
  (Scope as TiScope).PrintMarginRight       := PrintMarginRightEdit.AsFloat;
  (Scope as TiScope).PrintMarginBottom      := PrintMarginBottomEdit.AsFloat;
  (Scope as TiScope).PrintDocumentName      := PrintDocumentNameEdit.AsString;

  (Scope as TiScope).Display.TextShow       := DisplayTextShowCheckBox.AsBoolean;
  (Scope as TiScope).Display.HorzScrollShow := DisplayHorzScrollShowCheckBox.AsBoolean;
  (Scope as TiScope).Display.GridColor      := DisplayGridColorPicker.Color;

  (Scope as TiScope).TimeBase.SecPerDiv     := TimeBaseSecPerDivSpinSelector.Value;
  (Scope as TiScope).TimeBase.Position      := TimeBasePositionSpinSelector.Value;
  (Scope as TiScope).TimeBase.PreCapture    := TimeBasePreCaptureSpinSelector.Value;
  (Scope as TiScope).TimeBase.PostCapture   := TimeBasePostCaptureSpinSelector.Value;

  (Scope as TiScope).Trigger.Level          := TriggerLevelSpinSelector.Value;
  (Scope as TiScope).Trigger.SourceIndex    := TriggerSourceSpinSelector.ItemIndex;
  (Scope as TiScope).Trigger.PositiveSlope  := TriggerPositiveSlopeCheckBox.AsBoolean;
  (Scope as TiScope).Trigger.Auto           := TriggerAutoCheckBox.AsBoolean;
end;
//****************************************************************************************************************************************************
end.
