{*******************************************************}
{                                                       }
{       TiLedRound Component                            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedRound;{$endif}
{$ifdef iCLX}unit QiLedRound;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iClasses,  iLed,  iGradient;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiClasses, QiLed, QiGradient;{$ENDIF}

type
  TiLedRound = class(TiLed)
  private
    FShowReflection : Boolean;
    FOnAutoSize     : TNotifyEvent;
    procedure SetShowReflection(const Value: Boolean);
  protected
    procedure iPaintTo(Canvas: TCanvas);                          override;
  public
    constructor Create(AOwner: TComponent);                       override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property OnAutoSize     : TNotifyEvent read FOnAutoSize     write FOnAutoSize;
  published
    property ShowReflection : Boolean      read FShowReflection write SetShowReflection default True;
    property Active;
    property ActiveColor;
    property BevelStyle;
    property BackGroundColor;
    property Transparent;        
    property OnChange;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiLedRound.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShowReflection := True;
end;
//****************************************************************************************************************************************************
procedure TiLedRound.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if not (csLoading in componentState) then
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
    end; 
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiLedRound.SetShowReflection(const Value: Boolean);begin SetBooleanProperty(Value,FShowReflection,irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiLedRound.iPaintTo(Canvas: TCanvas);
var
               DrawRect : TRect;
  {$ifdef iVCL}ARegion  : HRGN;  {$endif}
               AColor   : TColor;
begin
  with Canvas, DrawRect do
    begin
      AColor := clBtnFace;
      DrawBackGround(Canvas, BackGroundColor);

      DrawRect := Rect(0, 0 ,Width, Height);

      case BevelStyle of
        ibsLowered : begin
                       {$ifdef iVCL}ARegion := CreateEllipticRgn(0, 0, Width, Height);{$endif}
                       {$ifdef iVCL}SelectClipRgn(Canvas.Handle, ARegion);            {$endif}
                       DrawGradientDirection(Canvas, DrawRect, ifdTopLeftBottomRight, ColorGradientDim(AColor), ColorGradientBright(AColor));
                       DrawRect := Rect(2, 2, Width-3, Height-3);
                       {$ifdef iVCL}SelectClipRgn(Canvas.Handle, 0);{$endif}
                       DeleteObject(ARegion);
                     end;
        ibsRaised : begin
                       {$ifdef iVCL}ARegion := CreateEllipticRgn(0, 0, Width, Height);{$endif}
                       {$ifdef iVCL}SelectClipRgn(Canvas.Handle, ARegion);            {$endif}
                       DrawGradientDirection(Canvas, DrawRect, ifdTopLeftBottomRight, ColorGradientBright(AColor), ColorGradientDim(AColor));
                       DrawRect := Rect(2, 2, Width-3, Height-3);
                       {$ifdef iVCL}SelectClipRgn(Canvas.Handle, 0);{$endif}
                       DeleteObject(ARegion);
                     end;
      end;



      if      Active            then Brush.Color := ActiveColor
      else if AutoInactiveColor then Brush.Color := DimColor(ActiveColor, 3)
      else                           Brush.Color := InactiveColor;

      Pen.Color   := Brush.Color;

      Ellipse(Left, Top, Right, Bottom);

      if FShowReflection then
        begin
          Pen.Color := clWhite;
          Arc(Left+Width div 4,  Top+Width div 4,  Right-Width div 4,  Bottom-Width div 4,  Right div 2,Top,Left,Bottom div 2);
          Arc(Left+Width div 4+1,Top+Width div 4+1,Right-Width div 4-1,Bottom-Width div 4-1,Right div 2,Top,Left,Bottom div 2);
        end;
    end;
end;
//****************************************************************************************************************************************************
end.
