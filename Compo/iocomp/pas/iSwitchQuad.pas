{*******************************************************}
{                                                       }
{       TiSwitchQuad Component                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchQuad;{$endif}
{$ifdef iCLX}unit QiSwitchQuad;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiQuadState  = (iqsNone, iqsLeft, iqsTop, iqsRight, iqsBottom);

  TiSwitchQuad = class(TiCustomComponent)
  private
    FArrowKeyDown       : Boolean;
    FMouseDown          : Boolean;
    FShowFocusRect      : Boolean;
    FLeftRect           : TRect;
    FTopRect            : TRect;
    FRightRect          : TRect;                   
    FBottomRect         : TRect;
    FOnClickDown        : TNotifyEvent;
    FOnClickRight       : TNotifyEvent;
    FOnClickLeft        : TNotifyEvent;
    FOnClickUp          : TNotifyEvent;
    FRepeatInitialDelay : Integer;
    FRepeatInterval     : Integer;
    FIncrementX         : Double;
    FValueY             : Double;
    FValueX             : Double;
    FIncrementY         : Double;
    FOnValueYChange     : TNotifyEvent;
    FOnValueXChange     : TNotifyEvent;
    FOnValueYChangeUser : TNotifyEvent;
    FOnValueXChangeUser : TNotifyEvent;
    FUseArrowKeys       : Boolean;
    FUserGenerated      : Boolean;
    FQuadState          : TiQuadState;
  protected
    procedure SetShowFocusRect(const Value: Boolean);
    procedure SetValueX       (const Value: Double);
    procedure SetValueY       (const Value: Double);

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);   override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);   override;

    procedure iWantSpecialKey(var CharCode: Word; var Result: Longint);              override;
    procedure iKeyUp         (var CharCode: Word; Shift: TShiftState);               override;
    procedure iKeyDown       (var CharCode: Word; Shift: TShiftState);               override;

    procedure iDoKillFocus; override;
    procedure iPaintTo(Canvas: TCanvas); override;

    procedure DoClickLeft;
    procedure DoClickRight;
    procedure DoClickUp;
    procedure DoClickDown;
    procedure DoValueXChange;
    procedure DoValueYChange;
    procedure DoQuadEvent;

    procedure TimerEvent(Sender : TObject);

    procedure CalcRects;
  public
    constructor Create(AOwner: TComponent);                       override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure   SetValueXNoEvent(const Value : Double);
    procedure   SetValueYNoEvent(const Value : Double);
  published
    property ShowFocusRect      : Boolean      read FShowFocusRect      write SetShowFocusRect    default True;
    property RepeatInitialDelay : Integer      read FRepeatInitialDelay write FRepeatInitialDelay default 500;
    property RepeatInterval     : Integer      read FRepeatInterval     write FRepeatInterval     default 50;
    property ValueX             : Double       read FValueX             write SetValueX;
    property ValueY             : Double       read FValueY             write SetValueY;
    property IncrementX         : Double       read FIncrementX         write FIncrementX;
    property IncrementY         : Double       read FIncrementY         write FIncrementY;
    property UseArrowKeys       : Boolean      read FUseArrowKeys       write FUseArrowKeys       default True;

    property OnClickLeft        : TNotifyEvent read FOnClickLeft        write FOnClickLeft;
    property OnClickUp          : TNotifyEvent read FOnClickUp          write FOnClickUp;
    property OnClickRight       : TNotifyEvent read FOnClickRight       write FOnClickRight;
    property OnClickDown        : TNotifyEvent read FOnClickDown        write FOnClickDown;
    property OnValueXChange     : TNotifyEvent read FOnValueXChange     write FOnValueXChange;
    property OnValueYChange     : TNotifyEvent read FOnValueYChange     write FOnValueYChange;
    property OnValueXChangeUser : TNotifyEvent read FOnValueXChangeUser write FOnValueXChangeUser;
    property OnValueYChangeUser : TNotifyEvent read FOnValueYChangeUser write FOnValueYChangeUser;

    property Enabled;
    property BackGroundColor;
    property TabOrder;
    property TabStop          default True;
    property Transparent;
    property Color;
    property Width            default 65;
    property Height           default 65;
  end;

implementation
//*************************************************************************************************************************************
constructor TiSwitchQuad.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width   := 65;
  Height  := 65;
  TabStop := True;

  FIncrementX         := 1;
  FIncrementY         := 1;

  FUseArrowKeys       := True;

  FShowFocusRect      := True;
  FRepeatInitialDelay := 500;
  FRepeatInterval     := 50;

  OnInternalTimer     := TimerEvent;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if AWidth  <> Width  then
    begin
      AHeight := AWidth;
      AWidth  := AWidth;
    end
  else if AHeight <> Height then
    begin
      AHeight := AHeight;
      AWidth  := AHeight;
    end;

  inherited;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.SetShowFocusRect(const Value: Boolean);begin SetBooleanProperty(Value,FShowFocusRect, irtInvalidate);end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.SetValueXNoEvent(const Value: Double);
var
  TempOnValueXChange : TNotifyEvent;
begin
  TempOnValueXChange := FOnValueXChange;
  FOnValueXChange    := nil;
  try
    SetValueX(Value);
  finally
    FOnValueXChange := TempOnValueXChange;
  end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.SetValueYNoEvent(const Value: Double);
var
  TempOnValueYChange : TNotifyEvent;
begin
  TempOnValueYChange := FOnValueYChange;
  FOnValueYChange    := nil;
  try
    SetValueY(Value);
  finally
    FOnValueYChange := TempOnValueYChange;
  end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.SetValueX(const Value: Double);
var
  CanEdit : Boolean;
begin
  if FValueX <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'ValueX', CanEdit);
      if CanEdit then
        begin
          FValueX := Value;
          DoValueXChange;
          {$ifdef iVCL}OPCOutputData('ValueX', FValueX);{$endif}
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.SetValueY(const Value: Double);
var
  CanEdit : Boolean;
begin
  if FValueY <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'ValueY', CanEdit);
      if CanEdit then
        begin
          FValueY := Value;
          DoValueYChange;
          {$ifdef iVCL}OPCOutputData('ValueY', FValueY);{$endif}
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CalcRects;
  if Button = mbLeft then                      
    begin
      SetFocus;
      FMouseDown := True;

      if      PtInRect(FLeftRect,   Point(X,Y)) then FQuadState  := iqsLeft
      else if PtInRect(FTopRect,    Point(X,Y)) then FQuadState  := iqsTop
      else if PtInRect(FRightRect,  Point(X,Y)) then FQuadState  := iqsRight
      else if PtInRect(FBottomRect, Point(X,Y)) then FQuadState  := iqsBottom
      else                                           FQuadState  := iqsNone;

      if (FQuadState <> iqsNone) and (not FArrowKeyDown) then TimerStart(FRepeatInitialDelay, FRepeatInterval);
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      InvalidateChange;
      FMouseDown := False;
      TimerStop;

      if      FQuadState = iqsLeft   then begin if PtInRect(FLeftRect,  Point(X,Y)) then DoQuadEvent; end
      else if FQuadState = iqsRight  then begin if PtInRect(FRightRect, Point(X,Y)) then DoQuadEvent; end
      else if FQuadState = iqsTop    then begin if PtInRect(FTopRect,   Point(X,Y)) then DoQuadEvent; end
      else if FQuadState = iqsBottom then begin if PtInRect(FBottomRect,Point(X,Y)) then DoQuadEvent; end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.CalcRects;
begin
  FLeftRect   := Rect(0,                  Width div 3,     Width div 3, 2*(Width div 3));
  FRightRect  := Rect(2*(Width div 3),    Width div 3,     Width,       2*(Width div 3));
  FTopRect    := Rect(Width div 3,     0,               2*(Width div 3),   Width div 3);
  FBottomRect := Rect(Width div 3,     2*(Width div 3), 2*(Width div 3),   Width);
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.iPaintTo(Canvas: TCanvas);
var
  Point1 : TPoint;
  Point2 : TPoint;
  Point3 : TPoint;
begin
  CalcRects;
  with Canvas do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      Brush.Style := bsSolid;
      Brush.Color := Color;

      with FTopRect do
        begin
          Point1 := Point(Left, Bottom);
          Point2 := Point((Left + Right) div 2, Top);
          Point3 := Point(Right, Bottom);

          Polygon([Point1, Point2, Point3]);

          if (FQuadState = iqsTop) and (FMouseDown or FArrowKeyDown) then
            begin
              Pen.Color := clBlack; PolyLine([Point1, Point2]);
              Pen.Color := clWhite; PolyLine([Point2, Point3]);
              Pen.Color := clWhite; PolyLine([Point3, Point1]);
            end
          else
            begin
              Pen.Color := clWhite; PolyLine([Point1, Point2]);
              Pen.Color := clBlack; PolyLine([Point2, Point3]);
              Pen.Color := clBlack; PolyLine([Point3, Point1]);
            end;
        end;

      with FLeftRect do
        begin
          Point1 := Point(Left, (Top + Bottom) div 2);
          Point2 := Point(Right, Top);
          Point3 := Point(Right, Bottom);

          Polygon([Point1, Point2, Point3]);

          if (FQuadState = iqsLeft) and (FMouseDown or FArrowKeyDown) then
            begin
              Pen.Color := clBlack; PolyLine([Point1, Point2]);
              Pen.Color := clWhite; PolyLine([Point2, Point3]);
              Pen.Color := clWhite; PolyLine([Point3, Point1]);
            end
          else
            begin
              Pen.Color := clWhite; PolyLine([Point1, Point2]);
              Pen.Color := clBlack; PolyLine([Point2, Point3]);
              Pen.Color := clGray;  PolyLine([Point3, Point1]);
            end;
         end;

      with FRightRect do
        begin
          Point1 := Point(Left, Top);
          Point2 := Point(Right, (Top + Bottom) div 2);
          Point3 := Point(Left, Bottom);

          Polygon([Point1, Point2, Point3]);

          if (FQuadState = iqsRight) and (FMouseDown or FArrowKeyDown) then
            begin
              Pen.Color := clBlack; PolyLine([Point1, Point2]);
              Pen.Color := clWhite; PolyLine([Point2, Point3]);
              Pen.Color := clBlack; PolyLine([Point3, Point1]);
            end
          else
            begin
              Pen.Color := clWhite; PolyLine([Point1, Point2]);
              Pen.Color := clBlack; PolyLine([Point2, Point3]);
              Pen.Color := clWhite; PolyLine([Point3, Point1]);
            end;
        end;

      with FBottomRect do
        begin
          Point1 := Point(Left, Top);
          Point2 := Point(Right, Top);
          Point3 := Point((Left + Right) div 2, Bottom);

          Polygon([Point1, Point2, Point3]);

          if (FQuadState = iqsBottom) and (FMouseDown or FArrowKeyDown) then
            begin
              Pen.Color := clBlack; PolyLine([Point1, Point2]);
              Pen.Color := clWhite; PolyLine([Point2, Point3]);
              Pen.Color := clBlack; PolyLine([Point3, Point1]);
            end
          else
            begin
              Pen.Color := clWhite; PolyLine([Point1, Point2]);
              Pen.Color := clBlack; PolyLine([Point2, Point3]);
              Pen.Color := clGray;  PolyLine([Point3, Point1]);
            end;
        end;

      if ShowFocusRect and HasFocus then iDrawFocusRect(Canvas, ClientRect, BackGroundColor);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.iDoKillFocus;
begin
  FArrowKeyDown := False;
  FMouseDown    := False;
  TimerStop;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.TimerEvent(Sender: TObject);
begin
  DoQuadEvent;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if FUseArrowKeys then
    begin
      //KYLIX TODO
      {$ifndef iCLX}
      if      CharCode = VK_LEFT  then FQuadState := iqsLeft
      else if CharCode = VK_RIGHT then FQuadState := iqsRight
      else if CharCode = VK_UP    then FQuadState := iqsTop
      else if CharCode = VK_DOWN  then FQuadState := iqsBottom
      else                             FQuadState := iqsNone;

      if (FQuadState <> iqsNone) then
        begin
          CharCode := 0;
          FArrowKeyDown    := True;
          TimerStart(FRepeatInitialDelay, FRepeatInterval);
          InvalidateChange;
        end;
      {$endif}
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.iWantSpecialKey(var CharCode: Word; var Result: Longint);
begin
  Result := 0;
  if FUseArrowKeys then if CharCode in [VK_LEFT, VK_DOWN, VK_RIGHT, VK_UP] then Result := 1;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  if FArrowKeyDown then
    begin
      //KYLIX TODO
      {$ifndef iCLX}
      if (CharCode = VK_LEFT) or (CharCode = VK_RIGHT) or (CharCode = VK_UP) or (CharCode = VK_DOWN) then
        begin
          FArrowKeyDown := False;
          InvalidateChange;
          DoQuadEvent;
          CharCode := 0;
        end;
      {$endif}
    end;
  TimerStop;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.DoQuadEvent;
begin
  FUserGenerated := True;
  try
    if      FQuadState = iqsLeft   then DoClickLeft
    else if FQuadState = iqsRight  then DoClickRight
    else if FQuadState = iqsTop    then DoClickUp
    else if FQuadState = iqsBottom then DoClickDown;
  finally
    FUserGenerated := False;
  end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.DoClickLeft;
begin
  if not Loading then
    begin
      ValueX := ValueX - IncrementX;
      if Assigned(FOnClickLeft) then FOnClickLeft(Self);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.DoClickRight;
begin
  if not Loading then
    begin
      ValueX := ValueX + IncrementX;
      if Assigned(FOnClickRight) then FOnClickRight(Self);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.DoClickUp;
begin
  if not Loading then
    begin
      ValueY := ValueY + IncrementY;
      if Assigned(FOnClickUp) then FOnClickUp(Self);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.DoClickDown;
begin
  if not Loading then
    begin
      ValueY := ValueY - IncrementY;
      if Assigned(FOnClickDown) then FOnClickDown(Self);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.DoValueXChange;
begin
  if not Loading then
    begin
      if                        Assigned(OnChangeProtected)   then OnChangeProtected  (Self, 'ValueX');
      if                        Assigned(FOnValueXChange)     then FOnValueXChange    (Self);
      if FUserGenerated then if Assigned(FOnValueXChangeUser) then FOnValueXChangeUser(Self);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchQuad.DoValueYChange;
begin
  if not Loading then
    begin
      if                        Assigned(OnChangeProtected)   then OnChangeProtected  (Self, 'ValueY');
      if                        Assigned(FOnValueYChange)     then FOnValueYChange    (Self);
      if FUserGenerated then if Assigned(FOnValueYChangeUser) then FOnValueYChangeUser(Self);
    end;
end;
//*************************************************************************************************************************************
end.


