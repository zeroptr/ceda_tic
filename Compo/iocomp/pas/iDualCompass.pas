{*******************************************************}
{                                                       }
{       TiDualCompass Component                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iDualCompass;{$endif}
{$ifdef iCLX}unit QiDualCompass;{$endif}

interface
                                                         
uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent;{$ENDIF}

type
  TiDualCompass = class(TiCustomComponent)
  private
    FCenterPoint                  : TPoint;
    FScaleHeight                  : Integer;
    FScaleInnerRadius             : Integer;
    FScaleOuterRadius             : Integer;
    FScaleCenterRadius            : Integer;
    FCenterDisplayRect            : TRect;

    FOuterMargin                  : Integer;
    FScaleBackGroundColor         : TColor;
    FScaleLabelMargin             : Double;
    FScaleFont                    : TFont;
    FLabelTopFont                 : TFont;
    FLabelBottomFont              : TFont;
    FCenterDisplayFont            : TFont;
    FPointer1Position             : Double;
    FCenterDisplayPosition        : Double;
    FPointer2Position             : Double;
    FPointer2Height               : Double;
    FPointer2Width                : Double;
    FPointer1Width                : Integer;
    FCenterDisplayBackGroundColor : TColor;
    FCenterDisplayWidth           : Double;
    FCenterDisplayHeight          : Double;
    FCenterDisplayPrecision       : Integer;
    FLabelTopMargin               : Double;
    FLabelBottomMargin            : Double;
    FLabelBottomText              : String;
    FLabelTopText                 : String;
    FInnerColor                   : TColor;
    FShowCenterDisplay            : Boolean;
    FShowPointer2                 : Boolean;
    FShowPointer1                 : Boolean;
    FPointer1Color                : TColor;
    FNCaption                     : String;
    FNWCaption                    : String;
    FWCaption                     : String;
    FSWCaption                    : String;
    FSCaption                     : String;
    FSECaption                    : String;
    FECaption                     : String;
    FNECaption                    : String;
    FOnCustomizeTickLabel         : TOnCustomizeTickLabel;

    procedure SetOuterMargin                 (const Value: Integer);
    procedure SetScaleBackGroundColor        (const Value: TColor);
    procedure SetScaleLabelMargin            (const Value: Double);
    procedure SetScaleFont                   (const Value: TFont);
    procedure SetLabelTopFont                (const Value: TFont);
    procedure SetLabelBottomFont             (const Value: TFont);
    procedure SetCenterDisplayFont           (const Value: TFont);
    procedure SetCenterDisplayPosition       (const Value: Double);
    procedure SetPointer1Position            (const Value: Double);
    procedure SetPointer2Position            (const Value: Double);
    procedure SetPointer2Height              (const Value: Double);
    procedure SetPointer2Width               (const Value: Double);
    procedure SetPointer1Width               (const Value: Integer);
    procedure SetCenterDisplayBackGroundColor(const Value: TColor);
    procedure SetCenterDisplayWidth          (const Value: Double);
    procedure SetCenterDisplayHeight         (const Value: Double);
    procedure SetCenterDisplayPrecision      (const Value: Integer);
    procedure SetLabelBottomMargin           (const Value: Double);
    procedure SetLabelBottomText             (const Value: String);
    procedure SetLabelTopMargin              (const Value: Double);
    procedure SetLabelTopText                (const Value: String);
    procedure SetInnerColor                  (const Value: TColor);
    procedure SetPointer1Color               (const Value: TColor);
    procedure SetShowCenterDisplay           (const Value: Boolean);
    procedure SetShowPointer1                (const Value: Boolean);
    procedure SetShowPointer2                (const Value: Boolean);
    procedure SetNCaption                    (const Value: String);
    procedure SetNWCaption                   (const Value: String);
    procedure SetWCaption                    (const Value: String);
    procedure SetSWCaption                   (const Value: String);
    procedure SetSCaption                    (const Value: String);
    procedure SetSECaption                   (const Value: String);
    procedure SetECaption                    (const Value: String);
    procedure SetNECaption                   (const Value: String);
  protected
    procedure CalcPoints(Canvas: TCanvas);
    procedure iPaintTo(Canvas: TCanvas);                          override;
    procedure DrawScaleBackGround(Canvas : TCanvas);
    procedure DrawPointer1       (Canvas : TCanvas);
    procedure DrawPointer2       (Canvas : TCanvas);
    procedure DrawScaleLabels    (Canvas : TCanvas);
    procedure DrawCenterDisplay  (Canvas : TCanvas);
    procedure DrawLabels         (Canvas : TCanvas);
  public
    constructor Create(AOwner: TComponent);                       override;
    destructor  Destroy;                                          override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property OuterMargin                  : Integer               read FOuterMargin                  write SetOuterMargin                  default 5;
    property InnerColor                   : TColor                read FInnerColor                   write SetInnerColor                   default clBlack;

    property ScaleBackGroundColor         : TColor                read FScaleBackGroundColor         write SetScaleBackGroundColor         default $00C0FFFF;
    property ScaleLabelMargin             : Double                read FScaleLabelMargin             write SetScaleLabelMargin;
    property ScaleFont                    : TFont                 read FScaleFont                    write SetScaleFont;

    property LabelTopFont                 : TFont                 read FLabelTopFont                 write SetLabelTopFont;
    property LabelTopMargin               : Double                read FLabelTopMargin               write SetLabelTopMargin;
    property LabelTopText                 : String                read FLabelTopText                 write SetLabelTopText;

    property LabelBottomFont              : TFont                 read FLabelBottomFont              write SetLabelBottomFont;
    property LabelBottomMargin            : Double                read FLabelBottomMargin            write SetLabelBottomMargin;
    property LabelBottomText              : String                read FLabelBottomText              write SetLabelBottomText;

    property CenterDisplayFont            : TFont                 read FCenterDisplayFont            write SetCenterDisplayFont;
    property CenterDisplayBackGroundColor : TColor                read FCenterDisplayBackGroundColor write SetCenterDisplayBackGroundColor default clWhite;
    property CenterDisplayPosition        : Double                read FCenterDisplayPosition        write SetCenterDisplayPosition;
    property CenterDisplayWidth           : Double                read FCenterDisplayWidth           write SetCenterDisplayWidth;
    property CenterDisplayHeight          : Double                read FCenterDisplayHeight          write SetCenterDisplayHeight;
    property CenterDisplayPrecision       : Integer               read FCenterDisplayPrecision       write SetCenterDisplayPrecision       default 1;

    property Pointer1Position             : Double                read FPointer1Position             write SetPointer1Position;
    property Pointer1Width                : Integer               read FPointer1Width                write SetPointer1Width                default 3;
    property Pointer1Color                : TColor                read FPointer1Color                write SetPointer1Color                default clBlack;

    property Pointer2Position             : Double                read FPointer2Position             write SetPointer2Position;
    property Pointer2Height               : Double                read FPointer2Height               write SetPointer2Height;
    property Pointer2Width                : Double                read FPointer2Width                write SetPointer2Width;

    property ShowPointer1                 : Boolean               read FShowPointer1                 write SetShowPointer1                 default True;
    property ShowPointer2                 : Boolean               read FShowPointer2                 write SetShowPointer2                 default True;
    property ShowCenterDisplay            : Boolean               read FShowCenterDisplay            write SetShowCenterDisplay            default True;

    property NCaption                     : String                read FNCaption                     write SetNCaption;
    property NWCaption                    : String                read FNWCaption                    write SetNWCaption;
    property WCaption                     : String                read FWCaption                     write SetWCaption;
    property SWCaption                    : String                read FSWCaption                    write SetSWCaption;
    property SCaption                     : String                read FSCaption                     write SetSCaption;
    property SECaption                    : String                read FSECaption                    write SetSECaption;
    property ECaption                     : String                read FECaption                     write SetECaption;
    property NECaption                    : String                read FNECaption                    write SetNECaption;

    property OnCustomizeTickLabel         : TOnCustomizeTickLabel read FOnCustomizeTickLabel         write FOnCustomizeTickLabel;

    property BackGroundColor  default clBlack;
    property BorderStyle;
    property Transparent;
    property CachedDrawing;
    property Width            default 150;
    property Height           default 150;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiDualCompass.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width           := 150;
  Height          := 150;
  BackGroundColor := clBlack;

  FNCaption  := 'N';
  FNWCaption := 'NW';
  FWCaption  := 'W';
  FSWCaption := 'SW';
  FSCaption  := 'S';
  FSECaption := 'SE';
  FECaption  := 'E';
  FNECaption := 'NE';

  FOuterMargin                  := 5;
  FScaleBackGroundColor         := $00C0FFFF;
  FScaleLabelMargin             := 0.25;

  FPointer1Width                := 3;
  FPointer2Height               := 0.5;
  FPointer2Width                := 0.5;

  FCenterDisplayBackGroundColor := clWhite;
  FCenterDisplayWidth           := 8;
  FCenterDisplayHeight          := 1.50;
  FCenterDisplayPrecision       := 1;

  FLabelTopMargin               := 0.5;
  FLabelTopText                 := 'Label';

  FLabelBottomMargin            := 0.5;
  FLabelBottomText              := 'Label';

  FShowCenterDisplay            := True;
  FShowPointer1                 := True;
  FShowPointer2                 := True;

  FScaleFont                    := TFont.Create;
  FScaleFont.Style              := [fsBold];
  FScaleFont.OnChange           := BackGroundChangeEvent;

  FCenterDisplayFont            := TFont.Create;
  FCenterDisplayFont.Style      := [fsBold];
  FCenterDisplayFont.OnChange   := BackGroundChangeEvent;

  FLabelTopFont                 := TFont.Create;
  FLabelTopFont.Style           := [fsBold];
  FLabelTopFont.Color           := clWhite;
  FLabelTopFont.OnChange        := BackGroundChangeEvent;

  FLabelBottomFont              := TFont.Create;
  FLabelBottomFont.Style        := [fsBold];
  FLabelBottomFont.Color        := clWhite;
  FLabelBottomFont.OnChange     := BackGroundChangeEvent;
end;
//****************************************************************************************************************************************************
destructor TiDualCompass.Destroy;
begin
  FScaleFont.Free;
  FCenterDisplayFont.Free;
  FLabelTopFont.Free;
  FLabelBottomFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiDualCompass.SetOuterMargin                 (const Value:Integer);begin SetIntegerProperty(Value,FOuterMargin,                 irtBackGround);end;
procedure TiDualCompass.SetScaleBackGroundColor        (const Value:TColor );begin SetColorProperty  (Value,FScaleBackGroundColor,        irtBackGround);end;
procedure TiDualCompass.SetScaleLabelMargin            (const Value:Double );begin SetDoubleProperty (Value,FScaleLabelMargin,            irtBackGround);end;
procedure TiDualCompass.SetCenterDisplayPosition       (const Value:Double );begin SetDoubleProperty (Value,FCenterDisplayPosition,       irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiDualCompass.SetPointer1Width               (const Value:Integer);begin SetIntegerProperty(Value,FPointer1Width,               irtBackGround);end;
procedure TiDualCompass.SetPointer2Height              (const Value:Double );begin SetDoubleProperty (Value,FPointer2Height,              irtInvalidate);end;
procedure TiDualCompass.SetPointer2Width               (const Value:Double );begin SetDoubleProperty (Value,FPointer2Width,               irtInvalidate);end;
procedure TiDualCompass.SetCenterDisplayBackGroundColor(const Value:TColor );begin SetColorProperty  (Value,FCenterDisplayBackGroundColor,irtInvalidate);end;
procedure TiDualCompass.SetCenterDisplayWidth          (const Value:Double );begin SetDoubleProperty (Value,FCenterDisplayWidth,          irtInvalidate);end;
procedure TiDualCompass.SetCenterDisplayHeight         (const Value:Double );begin SetDoubleProperty (Value,FCenterDisplayHeight,         irtInvalidate);end;
procedure TiDualCompass.SetCenterDisplayPrecision      (const Value:Integer);begin SetIntegerProperty(Value,FCenterDisplayPrecision,      irtInvalidate);end;
procedure TiDualCompass.SetLabelBottomMargin           (const Value:Double );begin SetDoubleProperty (Value,FLabelBottomMargin,           irtBackGround);end;
procedure TiDualCompass.SetLabelBottomText             (const Value:String );begin SetStringProperty (Value,FLabelBottomText,             irtBackGround);end;
procedure TiDualCompass.SetLabelTopMargin              (const Value:Double );begin SetDoubleProperty (Value,FLabelTopMargin,              irtBackGround);end;
procedure TiDualCompass.SetLabelTopText                (const Value:String );begin SetStringProperty (Value,FLabelTopText,                irtBackGround);end;
procedure TiDualCompass.SetInnerColor                  (const Value:TColor );begin SetColorProperty  (Value,FInnerColor,                  irtBackGround);end;
procedure TiDualCompass.SetPointer1Color               (const Value:TColor );begin SetColorProperty  (Value,FPointer1Color,               irtBackGround);end;
procedure TiDualCompass.SetShowCenterDisplay           (const Value:Boolean);begin SetBooleanProperty(Value,FShowCenterDisplay,           irtInvalidate);end;
procedure TiDualCompass.SetShowPointer1                (const Value:Boolean);begin SetBooleanProperty(Value,FShowPointer1,                irtBackGround);end;
procedure TiDualCompass.SetShowPointer2                (const Value:Boolean);begin SetBooleanProperty(Value,FShowPointer2,                irtInvalidate);end;
procedure TiDualCompass.SetNCaption                    (const Value:String );begin SetStringProperty (Value,FNCaption,                    irtBackGround);end;
procedure TiDualCompass.SetNWCaption                   (const Value:String );begin SetStringProperty (Value,FNWCaption,                   irtBackGround);end;
procedure TiDualCompass.SetWCaption                    (const Value:String );begin SetStringProperty (Value,FWCaption,                    irtBackGround);end;
procedure TiDualCompass.SetSWCaption                   (const Value:String );begin SetStringProperty (Value,FSWCaption,                   irtBackGround);end;
procedure TiDualCompass.SetSCaption                    (const Value:String );begin SetStringProperty (Value,FSCaption,                    irtBackGround);end;
procedure TiDualCompass.SetSECaption                   (const Value:String );begin SetStringProperty (Value,FSECaption,                   irtBackGround);end;
procedure TiDualCompass.SetECaption                    (const Value:String );begin SetStringProperty (Value,FECaption,                    irtBackGround);end;
procedure TiDualCompass.SetNECaption                   (const Value:String );begin SetStringProperty (Value,FNECaption,                   irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiDualCompass.SetScaleFont        (const Value: TFont);begin FScaleFont.Assign(Value);        end;
procedure TiDualCompass.SetLabelTopFont     (const Value: TFont);begin FLabelTopFont.Assign(Value);     end;
procedure TiDualCompass.SetLabelBottomFont  (const Value: TFont);begin FLabelBottomFont.Assign(Value);  end;
procedure TiDualCompass.SetCenterDisplayFont(const Value: TFont);begin FCenterDisplayFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiDualCompass.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
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
//****************************************************************************************************************************************************
procedure TiDualCompass.SetPointer1Position(const Value:Double);
var
  CanEdit : Boolean;
begin
  if FPointer1Position <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Pointer1Position', CanEdit);
      if CanEdit then
        begin
          FPointer1Position := Value;
          InvalidateChange;
          if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Pointer1Position');
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiDualCompass.SetPointer2Position(const Value:Double);
var
  CanEdit : Boolean;
begin
  if FPointer2Position <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Pointer2Position', CanEdit);
      if CanEdit then
        begin
          FPointer2Position := Value;
          InvalidateChange;
          if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Pointer2Position');
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiDualCompass.CalcPoints(Canvas: TCanvas);
var
  ATextWidth             : Integer;
  ATextHeight            : Integer;
  ScaleLabelMarginPixels : Integer;
begin
  FCenterPoint := GetCenterPoint(Canvas);

  Canvas.Font.Assign(FScaleFont);

  ATextWidth := 0;
  if Canvas.TextWidth(FNCaption ) > ATextWidth then ATextWidth := Canvas.TextWidth(FNCaption);
  if Canvas.TextWidth(FNWCaption) > ATextWidth then ATextWidth := Canvas.TextWidth(FNWCaption);
  if Canvas.TextWidth(FWCaption ) > ATextWidth then ATextWidth := Canvas.TextWidth(FWCaption);
  if Canvas.TextWidth(FSWCaption) > ATextWidth then ATextWidth := Canvas.TextWidth(FSECaption);
  if Canvas.TextWidth(FSCaption ) > ATextWidth then ATextWidth := Canvas.TextWidth(FSCaption);
  if Canvas.TextWidth(FSECaption) > ATextWidth then ATextWidth := Canvas.TextWidth(FSECaption);
  if Canvas.TextWidth(FECaption ) > ATextWidth then ATextWidth := Canvas.TextWidth(FECaption);
  if Canvas.TextWidth(FNECaption) > ATextWidth then ATextWidth := Canvas.TextWidth(FNECaption);

  ScaleLabelMarginPixels := Round(FScaleLabelMargin*ATextWidth);

  FScaleHeight := ScaleLabelMarginPixels + ATextWidth;

  FScaleOuterRadius  := Round(Width/2 - FOuterMargin);
  FScaleInnerRadius  := FScaleOuterRadius - FScaleHeight;

  FScaleCenterRadius := (FScaleOuterRadius + FScaleInnerRadius) div 2;

  Canvas.Font.Assign(FCenterDisplayFont);
  ATextHeight := Round(Canvas.TextHeight('0') * FCenterDisplayHeight);
  ATextWidth  := Round(Canvas.TextWidth ('0') * FCenterDisplayWidth);

  FCenterDisplayRect := Rect(FCenterPoint.x - ATextWidth  div 2, FCenterPoint.y - ATextHeight div 2,
                             FCenterPoint.x + ATextWidth  div 2, FCenterPoint.y + ATextHeight div 2);
end;
//****************************************************************************************************************************************************
procedure TiDualCompass.iPaintTo(Canvas: TCanvas);
begin
  CalcPoints(Canvas);

  if CachedDrawing then
    begin
      if BackGroundChanged then
        begin
          CreateBackGroundBitmap;
          DrawBackGround     (BackGroundBitmap.Canvas, BackGroundColor);
          DrawScaleBackGround(BackGroundBitmap.Canvas);
          DrawLabels         (BackGroundBitmap.Canvas);

          if FShowPointer1 then DrawPointer1(BackGroundBitmap.Canvas);

          ResetBackGroundChange;
        end;

      TransferBackGround (Canvas);
      DrawScaleLabels    (Canvas);

      if FShowPointer2      then DrawPointer2     (Canvas);
      if FShowCenterDisplay then DrawCenterDisplay(Canvas);
    end
  else
    begin
                                 DrawBackGround     (Canvas, BackGroundColor);
                                 DrawScaleBackGround(Canvas);
                                 DrawLabels         (Canvas);
      if FShowPointer1      then DrawPointer1       (Canvas);
                                 DrawScaleLabels    (Canvas);
      if FShowPointer2      then DrawPointer2       (Canvas);
      if FShowCenterDisplay then DrawCenterDisplay  (Canvas);
    end;
end;
//****************************************************************************************************************************************************
procedure TiDualCompass.DrawScaleBackGround(Canvas: TCanvas);
begin
  with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := FScaleBackGroundColor;
      Pen.Color   := FScaleBackGroundColor;
      Ellipse(FCenterPoint.x - FScaleOuterRadius, FCenterPoint.y - FScaleOuterRadius,
              FCenterPoint.x + FScaleOuterRadius, FCenterPoint.y + FScaleOuterRadius);

      Brush.Color := FInnerColor;
      Pen.Color   := FInnerColor;

      Ellipse(FCenterPoint.x - FScaleInnerRadius, FCenterPoint.y - FScaleInnerRadius,
              FCenterPoint.x + FScaleInnerRadius, FCenterPoint.y + FScaleInnerRadius);
    end;
end;
//****************************************************************************************************************************************************
procedure TiDualCompass.DrawPointer1(Canvas: TCanvas);
begin
  with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := FPointer1Color;
      Pen.Color   := FPointer1Color;
      Rectangle(FCenterPoint.x                  - FPointer1Width div 2, FCenterPoint.y - FScaleOuterRadius,
                FCenterPoint.x + FPointer1Width - FPointer1Width div 2, FCenterPoint.y - FScaleInnerRadius);
    end;
end;
//****************************************************************************************************************************************************
procedure TiDualCompass.DrawScaleLabels(Canvas: TCanvas);
var
  x              : Integer;
  DegreePosition : Double;
  AText          : String;
  ALabelPoint    : TPoint;
begin
  with Canvas do
    begin
      Brush.Style := bsClear;

      Font.Assign(FScaleFont);
      for x := 0 to 7 do
        begin
          case x of
            0 : AText := FNCaption;
            1 : AText := FNECaption;
            2 : AText := FECaption;
            3 : AText := FSECaption;
            4 : AText := FSCaption;
            5 : AText := FSWCaption;
            6 : AText := FWCaption;
            7 : AText := FNWCaption;
          end;

          if Assigned(FOnCustomizeTickLabel) then FOnCustomizeTickLabel(Self, x, AText);

          DegreePosition := -x*45 + 90 + FPointer1Position;

          ALabelPoint := GetXYRadPoint(DegreePosition, FScaleCenterRadius, FCenterPoint);
          TextOut(ALabelPoint.x - TextWidth (AText) div 2, ALabelPoint.y - TextHeight(AText) div 2, AText);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiDualCompass.DrawPointer2(Canvas: TCanvas);
var
  OuterPoint  : TPoint;
  BasePoint   : TPoint;
  InnerPoint1 : TPoint;
  InnerPoint2 : TPoint;
  DegreePosition : Double;
begin
  with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := FInnerColor;
      Pen.Color   := FInnerColor;

      DegreePosition := 90 - FPointer2Position + FPointer1Position;

      OuterPoint := GetXYRadPoint(DegreePosition, FScaleInnerRadius+FPointer2Height*FScaleHeight, FCenterPoint);

      BasePoint   := GetXYRadPoint(DegreePosition, FScaleInnerRadius-2, FCenterPoint);
      InnerPoint1 := GetXYRadPoint(DegreePosition + 90, FPointer2Width*FScaleHeight/2, BasePoint);
      InnerPoint2 := GetXYRadPoint(DegreePosition - 90, FPointer2Width*FScaleHeight/2, BasePoint);
      Polygon([InnerPoint1, OuterPoint, InnerPoint2]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiDualCompass.DrawCenterDisplay(Canvas: TCanvas);
var
  AText           : String;
  PrecisionString : String;
  x               : Integer;
begin
  with Canvas, FCenterDisplayRect do
    begin
      Brush.Style := bsSolid;
      Brush.Color := FCenterDisplayBackGroundColor;
      Pen.Color   := FCenterDisplayBackGroundColor;
      Rectangle(FCenterDisplayRect.Left, FCenterDisplayRect.Top, FCenterDisplayRect.Right, FCenterDisplayRect.Bottom);

      Font.Assign(FCenterDisplayFont);
      Brush.Style := bsClear;

      for x := 1 to FCenterDisplayPrecision do
        PrecisionString := PrecisionString + '0';

      AText := Trim(FormatFloat('0.' + PrecisionString, FCenterDisplayPosition));

      TextOut((Left + Right) div 2 - TextWidth(AText) div 2, (Top + Bottom) div 2 - TextHeight(AText) div 2, AText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiDualCompass.DrawLabels(Canvas: TCanvas);
var
  AText        : String;
  ARect        : TRect;
  AHeight      : Integer;
  MarginPixels : Integer;
begin
  with Canvas do
    begin
      //-------------------- Top -----------------------------------------------------------------------------
      Font.Assign(FLabelTopFont);
      Brush.Style := bsClear;

      AText   := FLabelTopText;
      AHeight := TextHeight(AText);
      MarginPixels := Round(AHeight*FLabelTopMargin);
      ARect   := Rect(FCenterDisplayRect.Left,  FCenterDisplayRect.Top - MarginPixels - AHeight,
                      FCenterDisplayRect.Right, FCenterDisplayRect.Top - MarginPixels);

      with ARect do
        TextOut((Left + Right) div 2 - TextWidth(AText) div 2, (Top + Bottom) div 2 - TextHeight(AText) div 2, AText);
      //-------------------- Bottom --------------------------------------------------------------------------
      Font.Assign(FLabelBottomFont);
      Brush.Style := bsClear;

      AText   := FLabelBottomText;
      AHeight := TextHeight(AText);
      MarginPixels := Round(AHeight*FLabelBottomMargin);
      ARect   := Rect(FCenterDisplayRect.Left,  FCenterDisplayRect.Bottom + MarginPixels,
                      FCenterDisplayRect.Right, FCenterDisplayRect.Bottom + MarginPixels + AHeight);

      with ARect do
        TextOut((Left + Right) div 2 - TextWidth(AText) div 2, (Top + Bottom) div 2 - TextHeight(AText) div 2, AText);
    end;
end;
//****************************************************************************************************************************************************
end.

