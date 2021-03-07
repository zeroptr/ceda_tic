{*******************************************************}
{                                                       }
{       TiSwitchRocker Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchRocker;{$endif}
{$ifdef iCLX}unit QiSwitchRocker;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiSwitchRocker = class(TiCustomComponent)
  private
    FMouseDown            : Boolean;
    FSpaceKeyDown         : Boolean;
    FActive               : Boolean;
    FMouseControlStyle    : TiMouseControlStyle;
    FShowFocusRect        : Boolean;
    FIndicatorActiveColor : TColor;
    FIndicatorMargin      : Integer;
    FBorderMargin         : Integer;
    FOnChange             : TNotifyEvent;
    FOnChangeUser         : TNotifyEvent;
    FUserGenerated        : Boolean;
  protected
    procedure SetActive              (const Value: Boolean);
    procedure SetShowFocusRect       (const Value: Boolean);
    procedure SetIndicatorActiveColor(const Value: TColor);
    procedure SetBorderMargin        (const Value: Integer);
    procedure SetIndicatorMargin     (const Value: Integer);
    function GetIndicatorRect : TRect;

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure iKeyUp  (var CharCode: Word; Shift: TShiftState);                    override;
    procedure iKeyDown(var CharCode: Word; Shift: TShiftState);                    override;

    procedure iDoKillFocus;                                                        override;
    procedure iPaintTo(Canvas: TCanvas);                                           override;
    property  SwitchRect : TRect read GetIndicatorRect;
    procedure DoChange;
  public
    constructor Create(AOwner: TComponent);                                        override;
    procedure   SetActiveNoEvent(const Value: Boolean);
  published
    property Active               : Boolean             read FActive               write SetActive               default False;
    property MouseControlStyle    : TiMouseControlStyle read FMouseControlStyle    write FMouseControlStyle      default imcsClickAnyWhere;
    property ShowFocusRect        : Boolean             read FShowFocusRect        write SetShowFocusRect        default True;
    property IndicatorActiveColor : TColor              read FIndicatorActiveColor write SetIndicatorActiveColor default clLime;
    property IndicatorMargin      : Integer             read FIndicatorMargin      write SetIndicatorMargin      default 3;
    property BorderMargin         : Integer             read FBorderMargin         write SetBorderMargin         default 2;
    property OnChange             : TNotifyEvent        read FOnChange             write FOnChange;
    property OnChangeUser         : TNotifyEvent        read FOnChangeUser         write FOnChangeUser;
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
constructor TiSwitchRocker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width   := 25;
  Height  := 50;
  TabStop := True;

  FShowFocusRect        := True;
  FBorderMargin         := 2;
  FIndicatorMargin      := 3;
  FIndicatorActiveColor := clLime;
end;
//*************************************************************************************************************************************
procedure TiSwitchRocker.DoChange;
begin
  if not Loading then
    begin
      if                        Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Active');
      if                        Assigned(FOnChange)         then FOnChange        (Self);
      if FUserGenerated then if Assigned(FOnChangeUser)     then FOnChangeUser    (Self);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRocker.SetShowFocusRect       (const Value:Boolean);begin SetBooleanProperty(Value,FShowFocusRect,       irtInvalidate);end;
procedure TiSwitchRocker.SetIndicatorActiveColor(const Value:TColor); begin SetColorProperty  (Value,FIndicatorActiveColor,irtInvalidate);end;
procedure TiSwitchRocker.SetBorderMargin        (const Value:Integer);begin SetIntegerProperty(Value,FBorderMargin,        irtInvalidate);end;
procedure TiSwitchRocker.SetIndicatorMargin     (const Value:Integer);begin SetIntegerProperty(Value,FIndicatorMargin,     irtInvalidate);end;
//*************************************************************************************************************************************
procedure TiSwitchRocker.SetActiveNoEvent(const Value: Boolean);
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
procedure TiSwitchRocker.SetActive(const Value: Boolean);
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
procedure TiSwitchRocker.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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
procedure TiSwitchRocker.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      InvalidateChange;
      FMouseDown     := False;
      FUserGenerated := True;
      try
        if PtInRect(Rect(0, 0 ,Width, Height), Point(X,Y)) then Active := not Active;
      finally
        FUserGenerated := False;
      end;
    end;
end;
//*************************************************************************************************************************************
function TiSwitchRocker.GetIndicatorRect : TRect;
var
  DrawRect : TRect;
begin
  DrawRect := Rect(0,0,Width, Height);

  with DrawRect do
    begin
        if FActive then Result := Rect(2 + FBorderMargin, Height div 2, Width - 2 - FBorderMargin, Height - 2 - FBorderMargin)
          else          Result := Rect(2 + FBorderMargin, 2 + FBorderMargin, Width - 2 - FBorderMargin, Height div 2);

    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRocker.iPaintTo(Canvas: TCanvas);
var                                             
  DrawRect        : TRect;
  IndicatorHeight : Integer;
  ShadowHeight    : Integer;
  TotalMargin     : Integer;
  AColor          : TColor;
begin
  with Canvas, DrawRect do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      DrawRect := Rect(0, 0 ,Width, Height);
      InflateRect(DrawRect, -2, -2);
      Brush.Color := clBlack;
      FillRect(DrawRect);

      IndicatorHeight := Round(Height * 0.1);
      if IndicatorHeight < 5 then IndicatorHeight := 5;

      ShadowHeight := 3;
      TotalMargin  := BorderMargin + 2;

      if FMouseDown or FSpaceKeyDown then AColor := ColorMouseDownBright(Color)
      else                                AColor := Color;

      if Active then
        begin
          Brush.Color := AColor;
          DrawRect    := Rect(TotalMargin, TotalMargin ,Width - TotalMargin, Round(Height * 0.50) );
          FillRect(DrawRect);

          Brush.Color := ColorGradientBright(AColor);
          DrawRect    := Rect(TotalMargin, Round(Height * 0.50) ,Width - TotalMargin, Height - TotalMargin - ShadowHeight);
          FillRect(DrawRect);

          Brush.Color := ColorGradientDim(AColor);
          DrawRect    := Rect(TotalMargin, Height - TotalMargin - ShadowHeight ,Width - TotalMargin, Height - TotalMargin);
          FillRect(DrawRect);

          Brush.Color := FIndicatorActiveColor;
          Pen.Color   := clBlack;
          DrawRect    := Rect(TotalMargin + FIndicatorMargin, TotalMargin + FIndicatorMargin ,Width - TotalMargin - FIndicatorMargin, TotalMargin + FIndicatorMargin + IndicatorHeight);
          Rectangle(DrawRect.Left, DrawRect.Top, DrawRect.Right, DrawRect.Bottom);

          Pen.Color := clWhite;
          PolyLine([Point(Left, Bottom-1), Point(Right-1,Bottom-1), Point(Right-1, Top-1)]);
        end
      else
        begin
          Brush.Color := ColorGradientBright(AColor);

          DrawRect    := Rect(TotalMargin, TotalMargin ,Width - TotalMargin, TotalMargin + ShadowHeight);
          FillRect(DrawRect);

          Brush.Color := ColorGradientDim(AColor);
          DrawRect    := Rect(TotalMargin, TotalMargin + ShadowHeight ,Width - TotalMargin, Round(Height * 0.50) );
          FillRect(DrawRect);

          Brush.Color := AColor;
          DrawRect    := Rect(TotalMargin, Round(Height * 0.50) ,Width - TotalMargin, Height - TotalMargin);
          FillRect(DrawRect);

          Brush.Color := DimColor(FIndicatorActiveColor, 3);
          Pen.Color   := clBlack;

          DrawRect    := Rect(TotalMargin + FIndicatorMargin + 1, TotalMargin + ShadowHeight + FIndicatorMargin ,Width - TotalMargin - FIndicatorMargin, TotalMargin + ShadowHeight + FIndicatorMargin + IndicatorHeight);
          Rectangle(DrawRect.Left, DrawRect.Top, DrawRect.Right, DrawRect.Bottom);

          Pen.Color := clWhite;
          PolyLine([Point(Left, Bottom-1), Point(Right-1,Bottom-1), Point(Right-1, Top-1)]);
        end;

      if ShowFocusRect and HasFocus then iDrawFocusRect(Canvas, ClientRect, BackGroundColor);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRocker.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    begin
      FSpaceKeyDown := True;
      FMouseDown    := False;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRocker.iKeyUp(var CharCode: Word; Shift: TShiftState);
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
procedure TiSwitchRocker.iDoKillFocus;
begin
  FMouseDown    := False;
  FSpaceKeyDown := False;
  inherited;
end;
//*************************************************************************************************************************************
end.


