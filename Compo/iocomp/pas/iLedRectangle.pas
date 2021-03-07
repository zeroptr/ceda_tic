{*******************************************************}
{                                                       }
{       TiLedRectangle Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedRectangle;{$endif}
{$ifdef iCLX}unit QiLedRectangle;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iClasses,  iLed;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiClasses, QiLed;{$ENDIF}

type
  TiLedRectangle = class(TiLed)
  private
    FCenterLabelText              : String;
    FCenterLabelFontInactiveColor : TColor;
    FCenterLabelFontActiveColor   : TColor;
    FCenterLabelFont              : TFont;
    FShowReflection               : Boolean;
    FCenterLabelWordWrap          : Boolean;
    FCenterLabelEndsMargin        : Integer;
    FCenterLabelAlignment         : TiAlignmentHorizontal;
    procedure SetCenterLabelFontActiveColor  (const Value: TColor);
    procedure SetCenterLabelFontInactiveColor(const Value: TColor);
    procedure SetCenterLabelText             (const Value: String);
    procedure SetCenterLabelFont             (const Value: TFont);
    procedure SetShowReflection              (const Value: Boolean);
    procedure SetCenterLabelWordWrap         (const Value: Boolean);
    procedure SetCenterLabelEndsMargin       (const Value: Integer);
    procedure SetCenterLabelAlignment(const Value: TiAlignmentHorizontal);
  protected
    procedure iPaintTo(Canvas: TCanvas);     override;
  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;
  published
    property CenterLabelText              : String                read FCenterLabelText              write SetCenterLabelText;
    property CenterLabelFont              : TFont                 read FCenterLabelFont              write SetCenterLabelFont;
    property CenterLabelFontActiveColor   : TColor                read FCenterLabelFontActiveColor   write SetCenterLabelFontActiveColor    default clBlack;
    property CenterLabelFontInactiveColor : TColor                read FCenterLabelFontInactiveColor write SetCenterLabelFontInactiveColor  default clWhite;
    property CenterLabelWordWrap          : Boolean               read FCenterLabelWordWrap          write SetCenterLabelWordWrap           default False;
    property CenterLabelEndsMargin        : Integer               read FCenterLabelEndsMargin        write SetCenterLabelEndsMargin         default 5;
    property CenterLabelAlignment         : TiAlignmentHorizontal read FCenterLabelAlignment         write SetCenterLabelAlignment          default iahCenter;
    property ShowReflection               : Boolean               read FShowReflection               write SetShowReflection                default True;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiLedRectangle.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FShowReflection               := True;
  FCenterLabelFontInactiveColor := clWhite;
  FCenterLabelFont              := TFont.Create;
  FCenterLabelFont.OnChange     := BackGroundChangeEvent;
  FCenterLabelEndsMargin        := 5;
  FCenterLabelAlignment         := iahCenter;
end;
//****************************************************************************************************************************************************
destructor TiLedRectangle.Destroy;
begin
  FCenterLabelFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiLedRectangle.SetCenterLabelFontActiveColor  (const Value:TColor); begin SetColorProperty  (Value,FCenterLabelFontActiveColor,  irtBackGround);end;
procedure TiLedRectangle.SetCenterLabelFontInactiveColor(const Value:TColor); begin SetColorProperty  (Value,FCenterLabelFontInactiveColor,irtBackGround);end;
procedure TiLedRectangle.SetCenterLabelText             (const Value:String); begin SetStringProperty (Value,FCenterLabelText,             irtBackGround);end;
procedure TiLedRectangle.SetShowReflection              (const Value:Boolean);begin SetBooleanProperty(Value,FShowReflection,              irtBackGround);end;
procedure TiLedRectangle.SetCenterLabelWordWrap         (const Value:Boolean);begin SetBooleanProperty(Value,FCenterLabelWordWrap,         irtBackGround);end;
procedure TiLedRectangle.SetCenterLabelEndsMargin       (const Value:Integer);begin SetIntegerProperty(Value,FCenterLabelEndsMargin,       irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiLedRectangle.SetCenterLabelAlignment(const Value: TiAlignmentHorizontal);
begin
  if FCenterLabelAlignment <> Value then
    begin
      FCenterLabelAlignment := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedRectangle.SetCenterLabelFont(const Value: TFont);
begin
  FCenterLabelFont.Assign(Value);
end;
//****************************************************************************************************************************************************
procedure TiLedRectangle.iPaintTo(Canvas: TCanvas);
var
  DrawRect    : TRect;
  CenterPoint : TPoint;
  ATextRect   : TRect;
  AText       : String;
  ATextHeight : Integer;
  AFlags      : TiTextFlags;
begin
  with Canvas, DrawRect do
    begin
      DrawRect := Rect(0, 0 ,Width, Height);

      if Active then
        begin
          Brush.Color := ActiveColor;
          Pen.Color   := ActiveColor;
        end
      else
        begin
          if AutoInactiveColor then
            begin
              Brush.Color := DimColor(ActiveColor, 3);
              Pen.Color   := Brush.Color;
            end
          else
            begin
              Brush.Color := InactiveColor;
              Pen.Color   := Brush.Color;
            end
        end;

      FillRect(DrawRect);

      case BevelStyle of
        ibsLowered : iDrawEdge(Canvas, DrawRect, idesSunken);
        ibsRaised  : iDrawEdge(Canvas, DrawRect, idesRaised);
      end;

      if FShowReflection then
        begin
          Pen.Color := clWhite;
          Polyline([Point(Left + 3, Top + 3), Point(Left + 5, Top + 3)]);
        end;

      if Trim(FCenterLabelText) <> '' then
        begin
          Brush.Style := bsClear;
          Font.Assign(FCenterLabelFont);
          if Active then Font.Color := FCenterLabelFontActiveColor else Font.Color := FCenterLabelFontInactiveColor;
          CenterPoint := GetCenterPoint(Canvas);
          AText       := FCenterLabelText;

          AFlags := [itfVCenter, itfNoClip];

          if FCenterLabelWordWrap then AFlags := AFlags + [itfWordBreak];

          case FCenterLabelAlignment of
            iahCenter : AFlags := AFlags + [itfHCenter];
            iahLeft   : AFlags := AFlags + [itfHLeft];
            iahRight  : AFlags := AFlags + [itfHRight];
          end;

          AText       := FCenterLabelText;
          ATextRect   := Rect(Left  + 2 + FCenterLabelEndsMargin, Top    + 2,
                              Right - 2 - FCenterLabelEndsMargin, Bottom - 2);

          ATextHeight := iDrawText(Canvas, AText, ATextRect, AFlags + [itfCalcRect], True, BackGroundColor);

          ATextRect   := Rect(Left  + 2 + FCenterLabelEndsMargin, CenterPoint.Y - ATextHeight div 2,
                              Right - 2 - FCenterLabelEndsMargin, CenterPoint.Y + ATextHeight div 2);

          iDrawText(Canvas, AText, ATextRect, AFlags, True, BackGroundColor);
        end;
    end;
end;
//****************************************************************************************************************************************************
end.
