{*******************************************************}
{                                                       }
{       TiScopePanelToolBar Component                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScopePanelToolBar;{$endif}
{$ifdef iCLX}unit QiScopePanelToolBar;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  Buttons, iGPFunctions,   iEditorBasicComponents,  iSpinSelector;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QButtons, QiGPFunctions, QiEditorBasicComponents, QiSpinSelector;{$ENDIF}

type
  TiScopePanelToolBar = class(TCustomControl)
  private
    FCreationComplete : Boolean;

    FScope            : TWinControl;

    FCursorButton     : TSpeedButton;
    FEditButton       : TSpeedButton;
    FCopyButton       : TSpeedButton;
    FSaveButton       : TSpeedButton;
    FPrintButton      : TSpeedButton;

    FOnEditClick      : TNotifyEvent;
  protected
    procedure Resize;  override;
    procedure AdjustLayout;

    function GetCursorActive: Boolean;

    procedure Paint; override;

    procedure CursorClick(Sender: TObject);
    procedure EditClick  (Sender: TObject);
    procedure CopyClick  (Sender: TObject);
    procedure SaveClick  (Sender: TObject);
    procedure PrintClick (Sender: TObject);
  public
    procedure DoButtonClickCursor;
    procedure DoButtonClickEdit;
    procedure DoButtonClickCopy;
    procedure DoButtonClickSave;
    procedure DoButtonClickPrint;

    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    property Scope         : TWinControl  read FScope            write FScope;

    property CursorActive  : Boolean      read GetCursorActive;
    property OnEditClick   : TNotifyEvent read FOnEditClick      write FOnEditClick;
  end;

implementation

uses
  {$IFDEF iVCL} iScope;{$ENDIF}
  {$IFDEF iCLX}QiScope;{$ENDIF}

type
  TiScopeAccess = class(TiScope)end;
//****************************************************************************************************************************************************
constructor TiScopePanelToolBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width      := 200;
  Height     := 37;

  FCursorButton := TSpeedButton.Create(Self);
  with FCursorButton do
    begin
      Parent     := Self;
      Left       := 10;
      Top        := 4;
      Width      := 30;
      Height     := 30;
      GroupIndex := 1;
      AllowAllUp := True;
      OnClick    := CursorClick;
      Glyph.LoadFromResourceName(HInstance,'CURSOR');
    end;

  FEditButton := TSpeedButton.Create(Self);
  with FEditButton do
    begin
      Parent     := Self;
      Left       := FCursorButton.Left + FCursorButton.Width + 10;
      Top        := 4;
      Width      := 30;
      Height     := 30;
      OnClick    := EditClick;
      Glyph.LoadFromResourceName(HInstance,'PROPERTIES');
    end;

  FCopyButton := TSpeedButton.Create(Self);
  with FCopyButton do
    begin
      Parent     := Self;
      Left       := FEditButton.Left + FEditButton.Width + 10;
      Top        := 4;
      Width      := 30;
      Height     := 30;
      OnClick    := CopyClick;
      Glyph.LoadFromResourceName(HInstance,'Copy');
    end;

  FSaveButton := TSpeedButton.Create(Self);
  with FSaveButton do
    begin
      Parent     := Self;
      Left       := FCopyButton.Left + FCopyButton.Width;
      Top        := 4;
      Width      := 30;
      Height     := 30;
      OnClick    := SaveClick;
      Glyph.LoadFromResourceName(HInstance,'Save');
    end;

  FPrintButton := TSpeedButton.Create(Self);
  with FPrintButton do
    begin
      Parent     := Self;
      Left       := FSaveButton.Left + FSaveButton.Width;
      Top        := 4;
      Width      := 30;
      Height     := 30;
      OnClick    := PrintClick;
      Glyph.LoadFromResourceName(HInstance,'Printer');
    end;

  FCreationComplete := True;
end;
//****************************************************************************************************************************************************
destructor TiScopePanelToolBar.Destroy;
begin
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelToolBar.Resize;
begin
  inherited Resize;
  AdjustLayout;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelToolBar.AdjustLayout;
begin
  if not FCreationComplete then Exit;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelToolBar.Paint;
var
  DrawRect : TRect;                   
begin
  inherited;
  with Canvas do
    begin
      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;
      DrawRect := Rect(0, 0, Width, Height);
      FillRect(DrawRect);
      iDrawEdge(Canvas, DrawRect, idesRaised);
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelToolBar.CursorClick(Sender: TObject);
begin
  if TiScopeAccess(FScope as TiScope).Plot.ChannelCount < 2 then Exit;

  if TiScopeAccess(FScope as TiScope).Plot.DataCursor[0].ChannelName = TiScopeAccess(FScope as TiScope).Plot.Channel[0].Name then
    TiScopeAccess(FScope as TiScope).Plot.DataCursor[0].ChannelName := TiScopeAccess(FScope as TiScope).Plot.Channel[1].Name;

  TiScopeAccess(FScope as TiScope).Plot.DataCursor[0].Visible := FCursorButton.Down;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelToolBar.EditClick(Sender: TObject);
begin
  if Assigned(FOnEditClick) then FOnEditClick(Self);
end;
//****************************************************************************************************************************************************
procedure TiScopePanelToolBar.CopyClick (Sender: TObject);begin TiScopeAccess(FScope as TiScope).Plot.ToolBar[0].DoButtonClickCopy; end;
procedure TiScopePanelToolBar.PrintClick(Sender: TObject);begin TiScopeAccess(FScope as TiScope).Plot.ToolBar[0].DoButtonClickPrint;end;
procedure TiScopePanelToolBar.SaveClick (Sender: TObject);begin TiScopeAccess(FScope as TiScope).Plot.ToolBar[0].DoButtonClickSave; end;
//****************************************************************************************************************************************************
function TiScopePanelToolBar.GetCursorActive: Boolean;
begin
  Result := FCursorButton.Down;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelToolBar.DoButtonClickCopy;
begin
  TiScopeAccess(FScope as TiScope).Plot.ToolBar[0].DoButtonClickCopy;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelToolBar.DoButtonClickCursor;
begin
  if TiScopeAccess(FScope as TiScope).Plot.ChannelCount < 2 then Exit;
  if TiScopeAccess(FScope as TiScope).Plot.DataCursor[0].ChannelName = TiScopeAccess(FScope as TiScope).Plot.Channel[0].Name then
    TiScopeAccess(FScope as TiScope).Plot.DataCursor[0].ChannelName := TiScopeAccess(FScope as TiScope).Plot.Channel[1].Name;

  FCursorButton.Down := not FCursorButton.Down;
  TiScopeAccess(FScope as TiScope).Plot.DataCursor[0].Visible := FCursorButton.Down;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelToolBar.DoButtonClickEdit;
begin
  if Assigned(FOnEditClick) then FOnEditClick(Self);
end;
//****************************************************************************************************************************************************
procedure TiScopePanelToolBar.DoButtonClickPrint;
begin
  TiScopeAccess(FScope as TiScope).Plot.ToolBar[0].DoButtonClickPrint;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelToolBar.DoButtonClickSave;
begin
  TiScopeAccess(FScope as TiScope).Plot.ToolBar[0].DoButtonClickSave;
end;
//****************************************************************************************************************************************************
end.


