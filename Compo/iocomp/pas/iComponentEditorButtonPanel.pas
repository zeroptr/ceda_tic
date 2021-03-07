{*******************************************************}
{                                                       }
{       TiComponentEditorButtonPanel Component          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iComponentEditorButtonPanel;{$endif}
{$ifdef iCLX}unit QiComponentEditorButtonPanel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL}  iTypes, iGPFunctions; {$ENDIF}
  {$IFDEF iCLX} QiTypes, QiGPFunctions;{$ENDIF}

type
  TiComponentEditorButtonPanel = class(TCustomControl)
  private
    FCreationComplete : Boolean;
    FOkButton         : TButton;
    FCancelButton     : TButton;
    FApplyButton      : TButton;
  protected
    procedure OkButtonClick    (Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ApplyButtonClick (Sender: TObject);
    procedure Resize;  override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateButtons;
  published
  end;

implementation

{$IFDEF iVCL} uses  iComponentEditorForm;{$ENDIF}
{$IFDEF iCLX} uses QiComponentEditorForm;{$ENDIF}
//****************************************************************************************************************************************************
constructor TiComponentEditorButtonPanel.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  if Owner is TiComponentEditorForm  then (AOwner as TiComponentEditorForm).ButtonPanel := Self;

  Height  := 37;
  Align   := alBottom;
  Caption := ' ';

  FOkButton     := TButton.Create(Self);
  FCancelButton := TButton.Create(Self);
  FApplyButton  := TButton.Create(Self);

  with FOkButton do
    begin
      Parent  := Self;
      Caption := '&OK';
      Height  := 25;
      Width   := 70;
      Left    := 264;
      Top     := 8;
      OnClick := OkButtonClick;
    end;
  with FCancelButton do
    begin
      Parent  := Self;
      Caption := '&Cancel';
      Height  := 25;
      Width   := 70;
      Left    := 344;
      Top     := 8;
      ModalResult := mrCancel;
      OnClick := CancelButtonClick;
    end;
  with FApplyButton do
    begin
      Parent  := Self;
      Caption := '&Apply';
      Height  := 25;
      Width   := 70;
      Left    := 424;
      Top     := 8;
      OnClick := ApplyButtonClick;
    end;

  FCreationComplete := True;
  Resize;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorButtonPanel.OkButtonClick(Sender: TObject);
begin
  if Owner is TiComponentEditorForm then (Owner as TiComponentEditorForm).OkClicked;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorButtonPanel.CancelButtonClick(Sender: TObject);
begin
  if Owner is TiComponentEditorForm then (Owner as TiComponentEditorForm).CancelClicked;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorButtonPanel.ApplyButtonClick(Sender: TObject);
begin
  if Owner is TiComponentEditorForm then (Owner as TiComponentEditorForm).ApplyClicked;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorButtonPanel.UpdateButtons;
begin
  if Owner is TiComponentEditorForm then
    with (Owner as TiComponentEditorForm) do
      begin
        if Modified then FApplyButton.Enabled := True
          else           FApplyButton.Enabled := False;
      end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorButtonPanel.Resize;
begin
  inherited;
  if not FCreationComplete then Exit;

  FApplyButton.Left  := Width              - FApplyButton.Width  -10;
  FCancelButton.Left := FApplyButton.Left  - FCancelButton.Width -10;
  FOkButton.Left     := FCancelButton.Left - FOkButton.Width     -10;
end;
//****************************************************************************************************************************************************
end.
