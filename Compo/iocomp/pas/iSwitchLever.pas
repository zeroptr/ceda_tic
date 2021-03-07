{*******************************************************}
{                                                       }
{       TiSwitchLever Component                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchLever;{$endif}
{$ifdef iCLX}unit QiSwitchLever;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent,  iMath;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent, QiMath;{$ENDIF}

type
  TiSwitchLever = class(TiCustomComponent)
  private
    FMouseDown         : Boolean;
    FSpaceKeyDown      : Boolean;
    FActive            : Boolean;
    FMouseControlStyle : TiMouseControlStyle;
    FShowFocusRect     : Boolean;
    FOnChange          : TNotifyEvent;
    FOnChangeUser      : TNotifyEvent;
    FUserGenerated     : Boolean;

    procedure SetActive       (const Value: Boolean);
    procedure SetShowFocusRect(const Value: Boolean);
    function GetIndicatorRect : TRect;
  protected
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure iKeyUp  (var CharCode: Word; Shift: TShiftState);                    override;
    procedure iKeyDown(var CharCode: Word; Shift: TShiftState);                    override;

    procedure iDoKillFocus;                                                        override;
    procedure iPaintTo(Canvas: TCanvas);                                           override;
    property  SwitchRect : TRect read GetIndicatorRect;
    procedure DoChange;
  public
    constructor Create(AOwner: TComponent);  override;
    procedure   SetActiveNoEvent(const Value: Boolean);
  published
    property Active            : Boolean             read FActive            write SetActive          default False;
    property MouseControlStyle : TiMouseControlStyle read FMouseControlStyle write FMouseControlStyle default imcsClickAnyWhere;
    property ShowFocusRect     : Boolean             read FShowFocusRect     write SetShowFocusRect   default True;
    property OnChange          : TNotifyEvent        read FOnChange          write FOnChange;
    property OnChangeUser      : TNotifyEvent        read FOnChangeUser      write FOnChangeUser;
    property TabOrder;
    property TabStop          default True;
    property BackGroundColor;
    property Transparent;
    property Color;
    property Width            default 25;
    property Height           default 50;
  end;

implementation
//*************************************************************************************************************************************
constructor TiSwitchLever.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width   := 25;
  Height  := 50;
  TabStop := True;

  FShowFocusRect := True;
end;
//*************************************************************************************************************************************
procedure TiSwitchLever.DoChange;
begin
  if not Loading then
    begin
      if                        Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Active');
      if                        Assigned(FOnChange)         then FOnChange        (Self);
      if FUserGenerated then if Assigned(FOnChangeUser)     then FOnChangeUser    (Self);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLever.SetShowFocusRect(const Value: Boolean);begin SetBooleanProperty(Value,FShowFocusRect, irtInvalidate);end;
//*************************************************************************************************************************************
procedure TiSwitchLever.SetActiveNoEvent(const Value: Boolean);
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange := FOnChange;
  FOnChange    := nil;
  try
    SetActive(Value);
  finally
    FOnChange := TempOnChange;
  end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLever.SetActive(const Value: Boolean);
var
  CanEdit     : Boolean;
  TempBoolean : Boolean;
begin
  if ord(Value) = 0 then TempBoolean := False else TempBoolean := True;
  if FActive <> TempBoolean then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Active', CanEdit);
      if CanEdit then
        begin
          FActive := TempBoolean;
          InvalidateChange;
          DoChange;
          {$ifdef iVCL}OPCOutputData('Active', FActive);{$endif}
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLever.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  OkToStart : Boolean;
begin
  OkToStart := False;
  if Button = mbLeft then
    begin
      SetFocus;
      case FMouseControlStyle of
        imcsClickAnyWhere  : OkToStart := True;
        imcsClickIndicator : if PtInRect(SwitchRect, Point(X,Y)) then OkToStart := True;
      end;
    end;

  if OkToStart then
    begin
      FMouseDown  := True;
    end;
  InvalidateChange;
end;
//*************************************************************************************************************************************
procedure TiSwitchLever.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      FUserGenerated := True;
      try
        FMouseDown    := False;
        FSpaceKeyDown := False;
        if PtInRect(Rect(0, 0 ,Width, Height), Point(X,Y)) then Active := not Active;
        InvalidateChange;
      finally
        FUserGenerated := False;
      end;
    end;
end;
//*************************************************************************************************************************************
function TiSwitchLever.GetIndicatorRect : TRect;
var
  DrawRect : TRect;
begin
  DrawRect := Rect(0,0,Width, Height);

  with DrawRect do
    begin
        if FActive then Result := Rect(0, Height div 2, Width, Height)
          else          Result := Rect(0, 0, Width, Height div 2);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLever.iPaintTo(Canvas: TCanvas);
var
  DrawRect    : TRect;
  CenterPoint : TPoint;
  HalfWidth   : Integer;
  OuterRect   : TRect;
  AColor      : TColor;
begin
  with Canvas, DrawRect do
    begin
      DrawBackGround(Canvas, BackGroundColor);
      CenterPoint := GetCenterPoint(Canvas);

      if FMouseDown or FSpaceKeyDown then AColor := ColorMouseDownBright(Color)
      else                                AColor := Color;

      DrawRect  := Rect(0, 0 ,Width, Height);
      HalfWidth := (Width div 2) - 1;

      OuterRect   := Rect(CenterPoint.x - HalfWidth, CenterPoint.y - HalfWidth,
                          CenterPoint.x + HalfWidth, CenterPoint.y + HalfWidth);

      DrawGradientCircleRaised(Canvas, AColor, CenterPoint, HalfWidth);

      Brush.Style := bsSolid;

      if Active then
        begin
          Brush.Color := ColorGradientDim(AColor);
          Pen.Color   := Brush.Color;

          Polygon([Point(CenterPoint.x - Width div 4, CenterPoint.y + Width div 8),
                   Point(CenterPoint.x + Width div 4, CenterPoint.y + Width div 8),
                   Point(CenterPoint.x + HalfWidth, Width div 4),
                   Point(CenterPoint.x - HalfWidth, Width div 4)]);

          Brush.Color := ColorGradientBright(AColor);
          Pen.Color   := Brush.Color;

          Rectangle(CenterPoint.x - HalfWidth, 0, CenterPoint.x + HalfWidth + 1, Width div 4);
        end
      else
        begin
          Brush.Color := ColorGradientBright(AColor);
          Pen.Color   := Brush.Color;                       

          Polygon([Point(CenterPoint.x - Width div 4, CenterPoint.y - Width div 8),
                   Point(CenterPoint.x + Width div 4, CenterPoint.y - Width div 8),
                   Point(CenterPoint.x + HalfWidth, Height-1 - Width div 4),
                   Point(CenterPoint.x - HalfWidth, Height-1 - Width div 4)]);
          Brush.Color := ColorGradientDim(AColor);
          Pen.Color   := Brush.Color;
          Rectangle(CenterPoint.x - HalfWidth, Height-1 - Width div 4, CenterPoint.x + HalfWidth + 1, Height-1);
        end;

      if ShowFocusRect and HasFocus then iDrawFocusRect(Canvas, ClientRect, BackGroundColor);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLever.iDoKillFocus;
begin
  FMouseDown    := False;
  FSpaceKeyDown := False;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiSwitchLever.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    begin
      FSpaceKeyDown := True;
      FMouseDown    := False;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLever.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    if FSpaceKeyDown then
      begin
        InvalidateChange;
        FSpaceKeyDown  := False;
        FMouseDown     := False;
        FUserGenerated := True;
        try
          Active := not Active;
        finally
          FUserGenerated := False;
        end;
      end;
end;
//*************************************************************************************************************************************
end.


