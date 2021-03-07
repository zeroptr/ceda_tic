{*******************************************************}
{                                                       }
{       TiLinkedListBox Component                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLinkedListBox;{$endif}
{$ifdef iCLX}unit QiLinkedListBox;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iComponent,  iCustomComponent,  iComboBoxDisplay;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiComponent, QiCustomComponent, QiComboBoxDisplay;{$ENDIF}

type
  TGetItemCountEvent  = procedure(Sender: TObject;                 var Value : Integer) of object;
  TGetItemStringEvent = procedure(Sender: TObject; Index: Integer; var Value : String ) of object;
  TPaintItemEvent     = procedure(Sender: TObject; Canvas: TCanvas; ARect: TRect; State: TOwnerDrawState; Index: Integer; AText: String; var Handled: Boolean) of object;
  TPaintSetupEvent    = procedure(Sender: TObject; Canvas: TCanvas) of object;

  TiLinkedListBox = class(TiCustomComponent)
  private
    FItemIndex             : Integer;
    FFont                  : TFont;
    FColor                 : TColor;
    FTimer                 : TTimer;
    FRepeatInitialDelay    : Integer;
    FRepeatInterval        : Integer;
    FFirstTimerMessage     : Boolean;

    FStartIndex            : Integer;
    FStopIndex             : Integer;
    FLastIndex             : Integer;
    FItemCount             : Integer;
    FMaxCountVisible       : Integer;
    FBorderMargin          : Integer;
    FItemHeight            : Integer;
    FScrollBarRect         : TRect;
    FItemsRect             : TRect;
    FItemsMouseDown        : Boolean;

    FButtonUpRect          : TRect;
    FButtonDownRect        : TRect;
    FButtonUpMouseDown     : Boolean;
    FButtonDownMouseDown   : Boolean;

    FBarRect               : TRect;
    FBarButtonRect         : TRect;
    FBarButtonMouseDown    : Boolean;
    FBarButtonMouseDownTop : Integer;

    FMouseDownY            : Integer;
    FMouseMoveY            : Integer;

    FScrollBarVisible      : Boolean;

    FOnGetItemCount        : TGetItemCountEvent;
    FOnGetItemString       : TGetItemStringEvent;
    FOnPaintItem           : TPaintItemEvent;

    FSelectedColor         : TColor;
    FSelectedFontColor     : TColor;
    FShowFocusNoSelection  : Boolean;

    FOnChange              : TNotifyEvent;
    FOnPaintSetup          : TPaintSetupEvent;
  private
    function GetItemIndex: Integer;
  protected
    procedure SetItemIndex           (const Value: Integer);
    procedure SetColor               (const Value: TColor);
    procedure SetSelectedColor       (const Value: TColor);
    procedure SetSelectedFontColor   (const Value: TColor);
    procedure SetShowFocusNoSelection(const Value: Boolean);
    procedure SetFont                (const Value: TFont);

    function GetItemCount: Integer;

    procedure iMouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp   (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove (                      Shift: TShiftState; X, Y: Integer); override;

    procedure iWantSpecialKey(var CharCode: Word; var Result: Longint);             override;
    procedure iKeyDown   (var CharCode: Word; Shift: TShiftState);                  override;

    procedure iDoSetFocus;                                                          override;
    procedure iDoKillFocus;                                                         override;

    procedure TimerEvent(Sender: TObject);

    procedure iPaintTo(Canvas: TCanvas);                                            override;

    procedure DrawScrollBar(Canvas: TCanvas);

    procedure DoButtonUpClick;
    procedure DoButtonDownClick;
    procedure DoPageUpClick;
    procedure DoPageDownClick;

    procedure ScrollSelectedInView;

  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;

    property  ItemCount           : Integer             read GetItemCount;
    property ItemIndex            : Integer             read GetItemIndex          write SetItemIndex;
    property ShowFocusNoSelection : Boolean             read FShowFocusNoSelection write SetShowFocusNoSelection default True;
  published
    property Font                 : TFont               read FFont                 write SetFont;
    property Color                : TColor              read FColor                write SetColor                default clWindow;
    property SelectedColor        : TColor              read FSelectedColor        write SetSelectedColor        default clNavy;
    property SelectedFontColor    : TColor              read FSelectedFontColor    write SetSelectedFontColor    default clWhite;

    property OnGetItemCount       : TGetItemCountEvent  read FOnGetItemCount       write FOnGetItemCount;
    property OnGetItemString      : TGetItemStringEvent read FOnGetItemString      write FOnGetItemString;
    property OnPaintItem          : TPaintItemEvent     read FOnPaintItem          write FOnPaintItem;
    property OnPaintSetup         : TPaintSetupEvent    read FOnPaintSetup         write FOnPaintSetup;

    property OnChange             : TNotifyEvent        read FOnChange             write FOnChange;

    property Width        default 145;
    property Height       default 145;
    property TabStop      default True;
    property TabOrder;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiLinkedListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width                 := 145;
  Height                := 145;
  TabStop               := True;
  BorderStyle           := ibsLowered;
  BackGroundColor       := clWindow;

  FColor                := clWindow;
  FSelectedColor        := clNavy;
  FSelectedFontColor    := clWhite;

  FFont                 := TFont.Create;
  Font.Color            := clBlack;
  Font.OnChange         := InvalidateChangeEvent;

  FRepeatInitialDelay   := 500;
  FRepeatInterval       := 50;

  FItemIndex            := -1;

  FShowFocusNoSelection := True;

  FTimer                := TTimer.Create(Self);
  FTimer.Enabled        := False;
  FTimer.OnTimer        := TimerEvent;
end;
//****************************************************************************************************************************************************
destructor TiLinkedListBox.Destroy;
begin
  FFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.SetColor               (const Value:TColor );begin SetColorProperty  (Value, FColor,               irtInvalidate);end;
procedure TiLinkedListBox.SetSelectedColor       (const Value:TColor );begin SetColorProperty  (Value, FSelectedColor,       irtInvalidate);end;
procedure TiLinkedListBox.SetSelectedFontColor   (const Value:TColor );begin SetColorProperty  (Value, FSelectedFontColor,   irtInvalidate);end;
procedure TiLinkedListBox.SetShowFocusNoSelection(const Value:Boolean);begin SetBooleanProperty(Value, FShowFocusNoSelection,irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.SetFont (const Value: TFont );begin FFont.Assign(Value);end;
//****************************************************************************************************************************************************
function TiLinkedListBox.GetItemIndex: Integer;
var
  TempItemCount : Integer;
begin
  TempItemCount := ItemCount;
  if TempItemCount = -1 then FItemIndex := -1;
  if FItemIndex > (TempItemCount -1) then FItemIndex := TempItemCount-1;
  Result := FItemIndex;
end;
//****************************************************************************************************************************************************
function TiLinkedListBox.GetItemCount: Integer;
begin
  Result := 0;
  if Assigned(FonGetItemCount) then
    begin
      FOnGetItemCount(Self, FItemCount);
      if FItemCount <= 0 then
        begin
          FItemCount := 0;
          FItemIndex := -1;
        end;
      Result := FItemCount;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.SetItemIndex(const Value: Integer);
var
  OldItemIndex : Integer;
begin
  OldItemIndex := FItemIndex;
  FItemIndex := -1;

  if ItemCount <> 0 then
    begin
      if      Value < 0              then FItemIndex := 0
      else if Value > (FItemCount-1) then FItemIndex := FItemCount-1
      else                                FItemIndex := Value;
    end;

  if OldItemIndex <> FItemIndex then
    begin
      InvalidateChange;
      ScrollSelectedInView;
      if Assigned(FOnChange) then FOnChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.iPaintTo(Canvas: TCanvas);
var
  x         : Integer;
  AText     : String;
  ARect     : TRect;
  AFlags    : TiTextFlags;
  FocusRect : TRect;
  Handled   : Boolean;
  State     : TOwnerDrawState;
begin
  with Canvas do
    begin
      Font.Assign(FFont);
      if Assigned(FOnPaintSetup) then FOnPaintSetup(Self, Canvas);

      DrawBackGround(Canvas, FColor);

      FItemHeight := iTextHeight(Canvas, 'A');

      FBorderMargin := GetBorderMargin;

      FMaxCountVisible := (Height - 2*FBorderMargin) div FItemHeight;

      GetItemCount;

      if FItemCount = 0 then Exit;

      FLastIndex := FItemCount - 1;

      FScrollBarVisible := FItemCount > FMaxCountVisible;

      if FScrollBarVisible then DrawScrollBar(Canvas);
                                DrawBorder(Canvas);

      if FMaxCountVisible >= FItemCount then FStartIndex := 0;
      if FStartIndex      >  FLastIndex then FStartIndex := FLastIndex;

      FStopIndex := FStartIndex + FMaxCountVisible;
      if FStopIndex > FLastIndex then FStopIndex := FLastIndex;

      ARect          := Rect(FBorderMargin + 2, FBorderMargin, Width - FBorderMargin, FBorderMargin + FItemHeight);

      if FScrollBarVisible then ARect.Right := FScrollBarRect.Left;

      FocusRect      := ARect;
      FocusRect.Left := FBorderMargin;

      AFlags := [itfVCenter, itfHLeft, itfSingleLine];

      for x := FStartIndex to FStopIndex do
        begin
          Font.Assign(FFont);
          Brush.Style := bsClear;

          AText := '';
          if Assigned(FOnGetItemString) then FOnGetItemString(Self, x, AText);

          State := [];
          if HasFocus and (x = FItemIndex)                            then Include(State, odFocused);
          if (x = 0)  and (FItemIndex = -1) and FShowFocusNoSelection then Include(State, odFocused);
          if x = ItemIndex                                            then Include(State, odSelected);


          if Assigned(FOnPaintItem) then FOnPaintItem(Self, Canvas, FocusRect, State, x, AText, Handled);

          if not Handled then
            begin
              if odSelected in State then
                begin
                  Brush.Style := bsSolid;
                  Brush.Color := FSelectedColor;
                  Pen.Style   := psSolid;
                  Pen.Color   := FSelectedColor;
                  Rectangle(0, ARect.Top, ARect.Right, ARect.Bottom);
                  Font.Color := FSelectedFontColor;
                end
              else
                begin

                end;

              iDrawText(Canvas, AText, ARect, AFlags, True, clBtnFace);

              if odFocused in State then
                begin
                  iDrawFocusRect(Canvas, FocusRect, clNavy);
                end;
          end;

          OffsetRect(ARect,     0, FItemHeight);
          OffsetRect(FocusRect, 0, FItemHeight);
        end;

      DrawBorder(Canvas);

      FItemsRect := Rect(FBorderMargin, FBorderMargin, Width - FBorderMargin, Height - FBorderMargin);
      if FScrollBarVisible then FItemsRect.Right := FScrollBarRect.Left;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.DrawScrollBar(Canvas: TCanvas);
var
  ButtonSize       : Integer;
  BarPixelRange    : Integer;
  BarPercentHeight : Double;
  BarButtonHeight  : Integer;
  BarStartPercent  : Double;
begin
  with Canvas do
    begin
      ButtonSize   := 16;

      Brush.Color := $F0F0F0;
      Brush.Style := bsSolid;
      Pen.Color   := Brush.Color;
      Pen.Style   := psSolid;
      FScrollBarRect := Rect(Width - FBorderMargin - ButtonSize, FBorderMargin, Width - FBorderMargin, Height - FBorderMargin);
      Rectangle(FScrollBarRect.Left, FScrollBarRect.Top, FScrollBarRect.Right, FScrollBarRect.Bottom);

      Brush.Color := clBtnFace;
      Pen.Color   := clBtnFace;

      FButtonUpRect   := Rect(FScrollBarRect.Left, FScrollBarRect.Top,                 FScrollBarRect.Right, FScrollBarRect.Top + ButtonSize);
      FButtonDownRect := Rect(FScrollBarRect.Left, FScrollBarRect.Bottom - ButtonSize, FScrollBarRect.Right, FScrollBarRect.Bottom);

      FillRect(FButtonUpRect);
      FillRect(FButtonDownRect);

      if FButtonUpMouseDown   then iDrawEdge(Canvas, FButtonUpRect,   idesFlat) else iDrawEdge(Canvas, FButtonUpRect,   idesRaised);
      if FButtonDownMouseDown then iDrawEdge(Canvas, FButtonDownRect, idesFlat) else iDrawEdge(Canvas, FButtonDownRect, idesRaised);

      iDrawButtonArrowUp  (Canvas, FButtonUpRect,   FButtonUpMouseDown);
      iDrawButtonArrowDown(Canvas, FButtonDownRect, FButtonDownMouseDown);

      //---------------------------------------------------------------------------------------------------------------------------
      FBarRect       := Rect(FScrollBarRect.Left, FScrollBarRect.Top + ButtonSize, FScrollBarRect.Right, FScrollBarRect.Bottom - ButtonSize);
      FBarButtonRect := FBarRect;
      Brush.Color    := clBtnFace;

      BarPixelRange    := FBarRect.Bottom - FBarRect.Top;
      BarPercentHeight := FMaxCountVisible/FItemCount;
      BarButtonHeight  := Round(BarPixelRange * BarPercentHeight);

      if FBarButtonMouseDown then
        begin
          FBarButtonRect.Top := FBarButtonMouseDownTop + FMouseMoveY - FMouseDownY;
          if FBarButtonRect.Top                     < FBarRect.Top    then FBarButtonRect.Top := FBarRect.Top;
          if (FBarButtonRect.Top + BarButtonHeight) > FBarRect.Bottom then FBarButtonRect.Top := FBarRect.Bottom - BarButtonHeight;

          FStartIndex := Round((FBarButtonRect.Top - FBarRect.Top)/BarPixelRange * FItemCount);
        end
      else
        begin
          BarStartPercent    := FStartIndex/FItemCount;
          FBarButtonRect.Top := FBarButtonRect.Top + Round(BarStartPercent * BarPixelRange);
        end;

      FBarButtonRect.Bottom := FBarButtonRect.Top + BarButtonHeight;

      FillRect(FBarButtonRect);
      iDrawEdge(Canvas, FBarButtonRect, idesRaised);
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  iSetFocus(Self);

  FButtonUpMouseDown   := False;
  FButtonDownMouseDown := False;
  FBarButtonMouseDown  := False;
  FItemsMouseDown      := False;

  if FScrollBarVisible then
    begin
      if      PtInRect(FButtonUpRect,   Point(X, Y)) then begin FButtonUpMouseDown   := True; DoButtonUpClick;   end
      else if PtInRect(FButtonDownRect, Point(X, Y)) then begin FButtonDownMouseDown := True; DoButtonDownClick; end
      else if PtInRect(FBarRect, Point(X, Y)) then
        begin
          if      Y < FBarButtonRect.Top    then DoPageUpClick
          else if Y > FBarButtonRect.Bottom then DoPageDownClick
          else
            begin
              FBarButtonMouseDown    := True;
              FMouseDownY            := Y;
              FBarButtonMouseDownTop := FBarButtonRect.Top;
            end;
        end;
    end;

  if PtInRect(FItemsRect, Point(X, Y)) then FItemsMouseDown := True;

  if FButtonUpMouseDown or FButtonDownMouseDown then
    begin
      FTimer.Interval    := FRepeatInitialDelay;
      FTimer.Enabled     := True;
      FFirstTimerMessage := True;
    end
  else if FBarButtonMouseDown then
    begin


    end
  else if PtInRect(FItemsRect, Point(X, Y)) then
    begin
      ItemIndex := FStartIndex + (Y - FItemsRect.Top) div FItemHeight;
    end;

  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.iMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  FMouseMoveY := Y;
  if FItemsMouseDown then
    begin
      ItemIndex := FStartIndex + (Y - FItemsRect.Top) div FItemHeight;
    end
  else if FBarButtonMouseDown then InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FButtonUpMouseDown   := False;
  FButtonDownMouseDown := False;
  FBarButtonMouseDown  := False;
  FItemsMouseDown      := False;

  FTimer.Enabled := False;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.iDoSetFocus;
begin
  inherited iDoSetFocus;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.iDoKillFocus;
begin
  inherited iDoKillFocus;
  FButtonUpMouseDown   := False;
  FButtonDownMouseDown := False;
  FBarButtonMouseDown  := False;
  FItemsMouseDown      := False;

  FTimer.Enabled       := False;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  case CharCode of
    VK_LEFT,
    VK_UP     : ItemIndex := ItemIndex-1;
    VK_RIGHT,
    VK_DOWN   : ItemIndex := ItemIndex+1;
    VK_HOME   : ItemIndex := 0;
    VK_END    : ItemIndex := ItemCount-1;
    VK_PRIOR  : ItemIndex := ItemIndex - (FMaxCountVisible-1);
    VK_NEXT   : ItemIndex := ItemIndex + (FMaxCountVisible-1);
  end;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.TimerEvent(Sender: TObject);
begin
  if FFirstTimerMessage then
    begin
      FTimer.Interval := FRepeatInterval;
      FFirstTimerMessage := False;
    end;

  if FButtonUpMouseDown   then DoButtonUpClick;
  if FButtonDownMouseDown then DoButtonDownClick;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.DoButtonDownClick;
begin
  if (FStartIndex + FMaxCountVisible - 1) < FLastIndex then Inc(FStartIndex);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.DoButtonUpClick;
begin
  if FStartIndex > 0 then Dec(FStartIndex);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.DoPageUpClick;
begin
  FStartIndex := FStartIndex - (FMaxCountVisible - 1);
  if FStartIndex < 0 then FStartIndex := 0;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.DoPageDownClick;
begin
  FStartIndex := FStartIndex + (FMaxCountVisible - 1);
  if (FStartIndex + (FMaxCountVisible - 1)) > FLastIndex then FStartIndex := FLastIndex - (FMaxCountVisible - 1);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.ScrollSelectedInView;
begin
  if      FItemIndex < FStartIndex                          then FStartIndex := FItemIndex
  else if FItemIndex > (FStartIndex + FMaxCountVisible - 1) then FStartIndex := FItemIndex - FMaxCountVisible + 1;
end;
//****************************************************************************************************************************************************
procedure TiLinkedListBox.iWantSpecialKey(var CharCode: Word; var Result: Longint);
begin
  inherited iWantSpecialKey(CharCode, Result);
  if CharCode in [VK_LEFT, VK_DOWN, VK_RIGHT, VK_UP] then Result := 1 else Result := 0;
end;
//****************************************************************************************************************************************************
end.


