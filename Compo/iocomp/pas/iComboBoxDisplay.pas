{*******************************************************}
{                                                       }
{       TiComboBoxDisplay                               }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iComboBoxDisplay;{$endif}
{$ifdef iCLX}unit QiComboBoxDisplay;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiModeComboBoxDisplay = class(TiCustomComponent)
  private
    FItems          : TStringList;
    FFont           : TFont;
    FOnSelectItem   : TNotifyEvent;
    FMinWidth       : Integer;
    FOnDestroy      : TNotifyEvent;
    FNeededWidth    : Integer;
    FNeededHeight   : Integer;
    FSelectIndex    : Integer;
    FItemHeight     : Integer;
    FMaster         : TWinControl;
    FColor          : TColor;
  protected
    procedure SetSelectIndex(const Value: Integer);
    procedure SetColor      (const Value: TColor);

    procedure iPaintTo(Canvas: TCanvas); override;

    procedure FontChange(Sender: TObject);

    function GetItemRect(Index: Integer): TRect;
    function GetIsShowing: Boolean;

    {$ifdef iVCL}
    procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;
    {$endif}

    procedure iMouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp   (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove (                      Shift: TShiftState; X, Y: Integer); override;

    procedure iKeyPress   (var Key: Char);                         override;    
    procedure iKeyDown   (var CharCode: Word; Shift: TShiftState); override;

    procedure iDoSetFocus;                                         override;
    procedure iDoKillFocus;                                        override;

    procedure DoSelectItem;
    procedure DoLostFocus;

    {$ifdef iVCL}
    procedure CreateParams(var Params: TCreateParams); override;
    {$endif}
  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;

    procedure Setup;
    procedure Execute;

    property Font         : TFont        read FFont;
    property MinWidth     : Integer      read FMinWidth     write FMinWidth;
    property Items        : TStringList  read FItems        write FItems;
    property NeededWidth  : Integer      read FNeededWidth  write FNeededWidth;
    property NeededHeight : Integer      read FNeededHeight write FNeededHeight;
    property SelectIndex  : Integer      read FSelectIndex  write SetSelectIndex;
    property Color        : TColor       read FColor        write SetColor;

    property IsShowing    : Boolean      read GetIsShowing;

    property Master       : TWinControl  read FMaster      write FMaster;

    property OnSelectItem : TNotifyEvent read FOnSelectItem write FOnSelectItem;
    property OnDestroy    : TNotifyEvent read FOnDestroy    write FOnDestroy;
  end;


implementation
//****************************************************************************************************************************************************
constructor TiModeComboBoxDisplay.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FItems        := TStringList.Create;

  FFont         := TFont.Create;
  Font.OnChange := FontChange;
end;
//****************************************************************************************************************************************************
destructor TiModeComboBoxDisplay.Destroy;
begin
  if Assigned(FOnDestroy) then FOnDestroy(Self);
  FItems.Free;
  FFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.FontChange(Sender: TObject);
begin
  Invalidate;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiModeComboBoxDisplay.WMGetDLGCode(var Message: TMessage);
begin
  inherited;
  Message.Result := Message.Result + DLGC_WANTARROWS;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style     := WS_CHILD;
    ExStyle   := WS_EX_TOOLWINDOW;
    WndParent := GetDesktopWindow;
  end;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.iDoKillFocus;
begin
  {$ifdef iVCL}
  if GetCapture = Handle then ReleaseCapture;
  {$endif}
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.iDoSetFocus;
begin
  {$ifdef iVCL}
  if GetCapture <> Handle then SetCapture(Handle);
  {$endif}
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.Execute;
begin
  {$ifdef iVCL}
  Windows.SetFocus(Handle);
  {$endif}
  {$ifdef CLX}
  SetFocus;
  {$endif}
  iDoSetFocus;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.Setup;
var
  x         : Integer;
  MaxWidth  : Integer;
  MinHeight : Integer;
  MaxHeight : Integer;
begin
  MaxWidth := 0;
  with Canvas do
    begin
      Font.Assign(FFont);

      FItemHeight := TextHeight('ABC');

      for x := 0 to FItems.Count-1 do
        if TextWidth(FItems.Strings[x]) > MaxWidth then MaxWidth := TextWidth(FItems.Strings[x]);

      MinHeight := FItemHeight;
      MaxHeight := FItemHeight * FItems.Count;

      MaxWidth  := MaxWidth  + 6;
      MaxHeight := MaxHeight + 2;

      if MaxHeight > MinHeight then FNeededHeight := MaxHeight else FNeededHeight := MinHeight;
    end;

  if MaxWidth > MinWidth then FNeededWidth := MaxWidth else FNeededWidth := MinWidth;

  {$ifdef iVCL}
  SetWindowPos(Handle, HWND_BOTTOM, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
  {$endif}
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  case CharCode of
    iVK_LEFT,
    iVK_UP     : begin
                   if FSelectIndex > 0 then Dec(FSelectIndex);
                   InvalidateChange;
                 end;
    iVK_RIGHT,
    iVK_DOWN   : begin
                   if FSelectIndex < FItems.Count - 1 then Inc(FSelectIndex);
                   InvalidateChange;
                 end;
    iVK_HOME   : begin
                   FSelectIndex := 0;
                   InvalidateChange;
                 end;
    iVK_END    : begin
                   FSelectIndex := FItems.Count-1;
                   InvalidateChange;
                 end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.iKeyPress(var Key: Char);
begin
  case ord(Key) of
    iVK_RETURN  : DoSelectItem;
    iVK_ESCAPE  : DoLostFocus;
  end;
end;
//****************************************************************************************************************************************************
function TiModeComboBoxDisplay.GetItemRect(Index: Integer): TRect;
begin
  Result := Rect(1, FItemHeight*Index + 1, Width-1, FItemHeight*Index + FItemHeight + 1);
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.iPaintTo(Canvas: TCanvas);
var
  x             : Integer;
  HighLightRect : TRect;
  ATextRect     : TRect;
begin
  with Canvas do
    begin
      Brush.Color := FColor;
      Pen.Color   := clBlack;
      Brush.Style := bsSolid;
      Pen.Style   := psSolid;
      Pen.Width   := 0;

      Rectangle(0, 0, Width, Height);

      Font.Assign(FFont);

      for x := 0 to FItems.Count -  1 do
        begin
          HighLightRect  := GetItemRect(x);
          ATextRect      := HighLightRect;
          ATextRect.Left := 3;

          if x = FSelectIndex then
            begin
              Brush.Style := bsSolid;
              Brush.Color := clHighlight;
              Pen.Color   := clHighlight;
              FillRect(HighLightRect);
              Font.Color := clHighlightText;
              iDrawText     (Canvas, FItems.Strings[x], ATextRect, [itfHLeft], Enabled, BackGroundColor);
              iDrawFocusRect(Canvas, HighLightRect, clHighlight);
            end
          else
            begin
              Font.Color := FFont.Color;
              Brush.Style := bsClear;
              iDrawText(Canvas, FItems.Strings[x], ATextRect, [itfHLeft], Enabled, BackGroundColor);
            end;

        end; 
    end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if not PtInRect(Rect(0, 0 ,Width, Height), Point(X, Y)) then
    begin
      DoLostFocus;
    end
  else DoSelectItem;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.iMouseMove(Shift: TShiftState; X, Y: Integer);
var
  i : Integer;
begin
  //if GetCapture <> Handle then SetCapture(Handle);
  if not PtInRect(Rect(1, 1, Width-1, Height-1), Point(X, Y)) then Exit;
  
  Invalidate;
  FSelectIndex := - 1;
  for i := 0 to FItems.Count - 1 do
    if PtInRect(GetItemRect(i), Point(X,Y)) then
      begin
        FSelectIndex := i;
        Exit;
      end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.DoSelectItem;
begin
  Width := 0;
  Master.SetFocus;
  if Assigned(FOnSelectItem) then FOnSelectItem(Self);
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.DoLostFocus;
begin
  Width := 0;
  Master.SetFocus;
end;
//****************************************************************************************************************************************************
function TiModeComboBoxDisplay.GetIsShowing: Boolean;
begin
  Result := Width <> 0;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.SetSelectIndex(const Value: Integer);
begin
  if FSelectIndex <> Value then
    begin
      FSelectIndex := Value;
      if Width <> 0 then InvalidateNow;
    end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxDisplay.SetColor(const Value: TColor);
begin
  if FColor <> Value then
    begin
      FColor := Value;
      InvalidateNow;
    end;
end;
//****************************************************************************************************************************************************
end.


