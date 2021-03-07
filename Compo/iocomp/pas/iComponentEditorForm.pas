{*******************************************************}
{                                                       }
{       TiComponentEditorForm Component                 }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iComponentEditorForm;{$endif}
{$ifdef iCLX}unit QiComponentEditorForm;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes, iGPFunctions,   iEditorBasicComponents,  iComponentEditorButtonPanel,  iComponentEditorThemePanel,  iOPCBrowserPanel,  iVCLComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiEditorBasicComponents, QiComponentEditorButtonPanel, QiComponentEditorThemePanel, QiOPCBrowserPanel, QiCLXComponent;{$ENDIF}

type                                                                                            

  TiComponentEditorForm = class(TiCustomEditorForm)
  private
    FReadOnly           : Boolean;
    FChangesApplied     : Boolean;
    FModified           : Boolean;

    FButtonPanel        : TiComponentEditorButtonPanel;
    FThemePanel         : TiComponentEditorThemePanel;
    procedure SetModified(const Value: Boolean);
  protected
    iThemeInstance : TWinControl;       

    procedure Loaded; override;
    procedure CreateThemeInstance;                               virtual; abstract;
    
    procedure CopyPropertiesToForm     (Component: TWinControl); virtual; abstract;
    procedure CopyPropertiesToComponent(Component: TWinControl); virtual; abstract;

    procedure ThemePanelAcceptChanges(Sender: TObject);

    procedure DisableAllEditControlsStartingWith(Value : String);
    procedure EnableAllEditControlsStartingWith (Value : String);

    {$IFDEF iVCL}procedure UpLoadOPCProperties  (iComponent: TiVCLComponent; iOPCBrowserPanel: TiOPCBrowserPanel);{$endif}
    {$IFDEF iVCL}procedure DownLoadOPCProperties(iComponent: TiVCLComponent; iOPCBrowserPanel: TiOPCBrowserPanel);{$endif}
    {$IFDEF iCLX}procedure UpLoadOPCProperties  (iComponent: TiCLXComponent; iOPCBrowserPanel: TiOPCBrowserPanel);{$endif}
    {$IFDEF iCLX}procedure DownLoadOPCProperties(iComponent: TiCLXComponent; iOPCBrowserPanel: TiOPCBrowserPanel);{$endif}
  public
    iComponent : TWinControl;

    constructor Create(AOwner: TComponent); override;
    procedure SetupEditor;
    procedure SetupTheme;
    procedure UserChange; override;

    procedure ApplyChanges;

    procedure OkClicked;
    procedure CancelClicked;
    procedure ApplyClicked;

    property  ReadOnly       : Boolean                      read FReadOnly       write FReadOnly;
    property  ChangesApplied : Boolean                      read FChangesApplied write FChangesApplied;
    property  Modified       : Boolean                      read FModified       write SetModified;
    property  ButtonPanel    : TiComponentEditorButtonPanel read FButtonPanel    write FButtonPanel;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiComponentEditorForm.Create(AOwner: TComponent);
var
  x : Integer;
begin
  inherited;
  {$IFDEF iVCL} BorderStyle := bsDialog;   {$endif}
  {$IFDEF iCLX} BorderStyle := fbsDialog;  {$endif}
  {$IFDEF LINUX}Font.Name   := 'Helvetica';{$endif}
  {$IFDEF LINUX}Font.Size   := 10;         {$endif}

  for x := 0 to ComponentCount-1 do
    if Components[x] is TiComponentEditorRadioGroup then (Components[x] as TiComponentEditorRadioGroup).Constraints.MaxWidth := (Components[x] as TiComponentEditorRadioGroup).Width;

  AutoScroll  := False;
  Position    := poScreenCenter;

  if Assigned(ButtonPanel) then ButtonPanel.UpdateButtons;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorForm.Loaded;
var
  x           : Integer;
  PageControl : TPageControl;
{$IFDEF iCLX}
  OPCTabSheet : TTabSheet;
{$endif}
begin
  inherited;

  {$ifdef LINUX}
  Constraints.MaxHeight := Height;
  Constraints.MaxWidth  := Width;
  Constraints.MinHeight := Height;
  Constraints.MinWidth  := Width;
  Font.Color  := clText;
  Font.Height := 11;
  Font.Name   := 'helvetica';
  Font.Pitch  := fpVariable;
  Font.Style  := [];
  Font.Weight := 40;
  {$endif}

  FThemePanel := FindComponent('iComponentEditorThemePanel') as TiComponentEditorThemePanel;
  if Assigned(FThemePanel) then FThemePanel.OnAcceptChanges := ThemePanelAcceptChanges;

  if not (csDesigning in ComponentState) then
    begin
      for x := 0 to ComponentCount - 1 do
        if Components[x] is TPageControl then
          begin
            PageControl := (Components[x] as TPageControl);
            if PageControl.PageCount <> 0 then PageControl.ActivePage := PageControl.Pages[0];
          end;
      {$IFDEF iCLX}
       OPCTabSheet := FindComponent('OPCTabSheet') as TTabSheet;
       if Assigned(OPCTabSheet) then OPCTabSheet.TabVisible := False;
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorForm.SetupTheme;
begin
  if Assigned(FThemePanel) then
    begin
      if not Assigned(iThemeInstance) then
        begin
          CreateThemeInstance;
          iThemeInstance.Width  := iComponent.Width;
          iThemeInstance.Height := iComponent.Height;
          iSetDesigning(iThemeInstance);
          iThemeInstance.Visible := True;
          FThemePanel.iComponentPreview := iThemeInstance;
        end;
      FThemePanel.ResetThemePanel;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorForm.SetupEditor;
begin
  SetupTheme;
  CopyPropertiesToForm(iComponent);
  if Assigned(iThemeInstance) then
    begin
      CopyPropertiesToComponent(iThemeInstance);
      iThemeInstance.Width  := iComponent.Width;
      iThemeInstance.Height := iComponent.Height;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorForm.ThemePanelAcceptChanges(Sender: TObject);
begin
  CopyPropertiesToForm(iThemeInstance);
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorForm.DisableAllEditControlsStartingWith(Value: String);
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
procedure TiComponentEditorForm.EnableAllEditControlsStartingWith(Value: String);
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
procedure TiComponentEditorForm.ApplyChanges;
begin
  CopyPropertiesToComponent(iComponent);
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorForm.ApplyClicked;
begin
  if not FReadOnly then
    begin
      ApplyChanges;
      SetupEditor;
      FChangesApplied := True;
    end;
  Modified := False;
  If Assigned(ButtonPanel) then ButtonPanel.UpdateButtons;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorForm.CancelClicked;
begin
  ModalResult := mrCancel;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorForm.OkClicked;
begin
  if (FModified) and (not FReadOnly) then
    begin
      ApplyChanges;
      FChangesApplied := True;
    end;
  ModalResult := mrOK;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorForm.SetModified(const Value: Boolean);
begin
  FModified := Value;
  if Assigned(iThemeInstance) then CopyPropertiesToComponent(iThemeInstance);
  if Assigned(ButtonPanel) then ButtonPanel.UpdateButtons;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}procedure TiComponentEditorForm.UpLoadOPCProperties(iComponent: TiVCLComponent; iOPCBrowserPanel: TiOPCBrowserPanel);{$ENDIF}
{$IFDEF iCLX}procedure TiComponentEditorForm.UpLoadOPCProperties(iComponent: TiCLXComponent; iOPCBrowserPanel: TiOPCBrowserPanel);{$ENDIF}
{$IFDEF iVCL}
var
  x : Integer;
{$ENDIF}
begin
{$IFDEF iVCL}
  iOPCBrowserPanel.RemoveAllItems;

  for x := 0 to iComponent.OPCItemCount-1 do
    begin
      iOPCBrowserPanel.AddItem;

      iOPCBrowserPanel.SetPropertyName(x, iComponent.OPCItem[x].PropertyName);
      iOPCBrowserPanel.SetGroupName   (x, iComponent.OPCItem[x].GroupName);
      iOPCBrowserPanel.SetComputerName(x, iComponent.OPCItem[x].ComputerName);
      iOPCBrowserPanel.SetServerName  (x, iComponent.OPCItem[x].ServerName);
      iOPCBrowserPanel.SetItemName    (x, iComponent.OPCItem[x].ItemName);
      iOPCBrowserPanel.SetScalar      (x, iComponent.OPCItem[x].Scalar);
      iOPCBrowserPanel.SetOffset      (x, iComponent.OPCItem[x].Offset);
      iOPCBrowserPanel.SetUpdateRate  (x, iComponent.OPCItem[x].UpdateRate);
      iOPCBrowserPanel.SetAutoConnect (x, iComponent.OPCItem[x].AutoConnect);
      iOPCBrowserPanel.SetAutoError   (x, iComponent.OPCItem[x].AutoError);

    end;

  iOPCBrowserPanel.APersistent := iComponent;
  iOPCBrowserPanel.UpdateItemEdit;
{$ENDIF}
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}procedure TiComponentEditorForm.DownLoadOPCProperties(iComponent: TiVCLComponent; iOPCBrowserPanel: TiOPCBrowserPanel);{$ENDIF}
{$IFDEF iCLX}procedure TiComponentEditorForm.DownLoadOPCProperties(iComponent: TiCLXComponent; iOPCBrowserPanel: TiOPCBrowserPanel);{$ENDIF}
{$IFDEF iVCL}
var
  x : Integer;
{$ENDIF}
begin
{$IFDEF iVCL}
  iComponent.OPCRemoveAllItems;
  for x := 0 to iOPCBrowserPanel.ItemCount -1 do
    begin
      iComponent.OPCAddItem;

      iComponent.OPCItem[x].PropertyName := iOPCBrowserPanel.GetPropertyName(x);
      iComponent.OPCItem[x].GroupName    := iOPCBrowserPanel.GetGroupName(x);
      iComponent.OPCItem[x].ComputerName := iOPCBrowserPanel.GetComputerName(x);
      iComponent.OPCItem[x].ServerName   := iOPCBrowserPanel.GetServerName(x);
      iComponent.OPCItem[x].ItemName     := iOPCBrowserPanel.GetItemName(x);
      iComponent.OPCItem[x].Scalar       := iOPCBrowserPanel.GetScalar(x);
      iComponent.OPCItem[x].Offset       := iOPCBrowserPanel.GetOffset(x);
      iComponent.OPCItem[x].UpdateRate   := iOPCBrowserPanel.GetUpdateRate(x);
      iComponent.OPCItem[x].AutoConnect  := iOPCBrowserPanel.GetAutoConnect(x);
      iComponent.OPCItem[x].AutoError    := iOPCBrowserPanel.GetAutoError(x);

      iComponent.OPCItem[x].Loaded;
    end;
{$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorForm.UserChange;
begin
  Modified := True;
end;
//****************************************************************************************************************************************************
end.

