{*******************************************************}
{                                                       }
{       iGPFunctions (General Purpose)                  }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iGPFunctions;{$endif}         
{$ifdef iCLX}unit QiGPFunctions;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iMath,  Printers;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiMath, QPrinters;{$ENDIF}


procedure GetAutoScaleValuesAdjustable(DesiredMin, DesiredMax: Double; DesiredTicks, MaxTicks: Integer;
                                       var NewMin: Double; var NewMax: Double; var NewTicks: Integer);

procedure GetAutoScaleValuesFixed     (DesiredMin, DesiredMax: Double; DesiredTicks, MaxTicks: Integer;
                                       var NewMin: Double; var NewMax: Double; var NewTicks: Integer);

function DimColor(Value: TColor; Divisor: Integer): TColor;

function ColorLighten1(AColor: TColor):TColor;
function ColorLighten2(AColor: TColor):TColor;
function ColorLighten3(AColor: TColor):TColor;
function ColorLighten4(AColor: TColor):TColor;

function ColorDarken1 (AColor: TColor):TColor;
function ColorDarken2 (AColor: TColor):TColor;
function ColorDarken3 (AColor: TColor):TColor;
function ColorDarken4 (AColor: TColor):TColor;

function ColorOffset(AColor: TColor; AOffset: Byte; AIncrease: Boolean): TColor;

function ColorMouseDownBright (AColor: TColor):TColor;
function ColorMouseDownBright2(AColor: TColor):TColor; 
function ColorGradientBright  (AColor: TColor):TColor;
function ColorGradientDim     (AColor: TColor):TColor;

procedure LineBevel       (Canvas: TCanvas; X1, Y1, X2, Y2: Integer; Style: TiBevelStyle);
procedure Line            (Canvas: TCanvas; Left, Top, Right, Bottom: Integer);
procedure DrawRaisedBorder(Canvas: TCanvas; ARect : TRect);
procedure DrawSunkenBorder(Canvas: TCanvas; ARect : TRect);

procedure DrawGradient(ACanvas: TCanvas; BackColor, ShawdowColor: TColor; ARect: TRect; ReverseColors: Boolean);

procedure DrawGradientCircle      (Canvas: TCanvas; StartColor, StopColor: TColor ; const CenterPoint: TPoint; Radius: Integer; ReverseColors: Boolean);
procedure DrawGradientCircleRaised(Canvas: TCanvas; AColor: TColor;                 const CenterPoint: TPoint; Radius: Integer);
procedure DrawGradientCircleSunken(Canvas: TCanvas; AColor: TColor;                 const CenterPoint: TPoint; Radius: Integer);

procedure DrawGradientDirection(Canvas: TCanvas; ARect: TRect; Direction: TiFillDirection; ColorStart, ColorStop: TColor);

//Kylix TODO
{$ifndef iCLX}
function FillFontInfo(Font : TFont; Rotation : Integer) : TLogFont;
{$endif}
function GetDecimalPoints(Max, Min : Double; Precision: Integer; PrecisionStyle : TiPrecisionStyle): Integer;

function GetXYRadPoint(AngleDegrees : Double; Radius : Double; Offset : TPoint) : TPoint;
function GetXYRadPointDouble(AngleDegrees : Double; Radius : Double; Offset : TPointDouble) : TPointDouble;

function GetCenterPointRect(X, Y, Width, Height: Integer): TRect;

function iFormatPrecisionStyle(Value, Span : Double; Precision : Integer; PrecisionStyle : TiPrecisionStyle) : String;

function PointOrientation(X, Y : Integer; Orientation : TiOrientation) : TPoint;
function RectOrientation(Left, Top, Right, Bottom : Integer; Orientation : TiOrientation) : TRect;

function iPointReverse(Reverse : Boolean; X, Y: Integer) : TPoint;

function TruncHalf(Value : Double) : Integer;
function PointDoubleToPoint(PointDouble : TPointDouble) : TPoint;

procedure ArcSegment(Canvas:TCanvas; StartDegrees, EndDegress : Double; Radius1, Radius2 : Integer; Offset : TPoint; AColor : TColor);

function  GetPropertyValueString(const PropName : String; var PropString : String; const AList: TStringList): Boolean;
procedure SeparateStrings(const AText: String; Seperator : String; var LeftString: String; var RightString: String);
procedure SaveObjectToStringList  (Instance: TPersistent; Path: String; DataList: TStringList; IgnoreList: TStringList);
procedure LoadObjectFromStringList(Instance: TPersistent; RootPath: String; DataList: TStringList);
function  GetObjectProperty(Instance: TPersistent; const PropName: string): TObject;
procedure AssignObject(Source, Destination: TPersistent);


function GetCustomFormOwner(AComponent: TComponent): TWinControl;

function  iDrawText       (Canvas: TCanvas; AText : String; var ARect : TRect; AFlags: TiTextFlags; AEnabled: Boolean; ABackgroundColor: TColor): Integer;
function  iDrawRotatedText(Canvas: TCanvas; AText : String; ARect : TRect; Angle: TiRotationAngle; TextLineAlignment: TiAlignmentHorizontal; AEnabled: Boolean; ABackgroundColor: TColor): TRect;
procedure iDrawFocusRect  (Canvas: TCanvas; ARect: TRect; BackgroundColor: TColor);
procedure iDrawFocusRect2 (Canvas: TCanvas; ARect: TRect);
procedure iDrawEdge       (Canvas: TCanvas; ARect: TRect; Style: TiDrawEdgeStyle);

procedure iDrawTriangle   (Canvas: TCanvas; ARect: TRect; Direction: TiDirection);

procedure iDrawButtonArrowUp  (Canvas: TCanvas; ARect: TRect; Down: Boolean);
procedure iDrawButtonArrowDown(Canvas: TCanvas; ARect: TRect; Down: Boolean);

function  iTextWidth           (Canvas: TCanvas; AText: String): Integer;
function  iTextHeight          (Canvas: TCanvas; AText: String): Integer;
function  iTextHeightFixedWidth(Canvas: TCanvas; AText: String; FixedWidth: Integer): Integer;

function  iRect(Left, Top, Right, Bottom: Integer): TRect;
function  iXYReverseRect (XYReverse: Boolean; XAxis1, YAxis1, XAxis2, YAxis2: Integer): TRect;
function  iXYReversePoint(XYReverse: Boolean; XAxisValue, YAxisValue: Integer): TPoint;

procedure iRectangle(Canvas: TCanvas; ARect: TRect);

procedure iDecodeDate(const DateTime: TDateTime; var Year, Month, Day: Integer);

function GetShiftDown: Boolean;
function GetCtrlDown : Boolean;
function GetAltDown  : Boolean;

procedure iSetDesigning(AComponent: TComponent);

procedure iAlignVCenterControl(RefControl, AlignControl : TControl);

function DateToMilliSeconds(Value: TDateTime) : Integer;
function DateToSeconds     (Value: TDateTime) : Integer;
function DateToMinutes     (Value: TDateTime) : Integer;
function DateToHours       (Value: TDateTime) : Integer;

procedure WriterWriteProperties(Writer: TWriter; Instance: TPersistent);

function iGetRValue(rgb: DWORD): Byte;
function iGetGValue(rgb: DWORD): Byte;
function iGetBValue(rgb: DWORD): Byte;

procedure SwapIntegers(var Integer1, Integer2 : Integer);

function GetClickRect(const Data: array of TPoint; MinSizePixels: Integer): TRect;

function PointDouble(X, Y: Double): TPointDouble;

function iStrToInt(Value: String): LongWord;
function iIntToStr(Value: LongWord; Format: TiIntegerFormatStyle; MaxLength: Integer; LeadingZeros: Boolean): String;

procedure iSetFocus(WinControl: TWinControl);

procedure SetActivePageIndex(PageControl: TPageControl; Index: Integer);
function GetActivePageIndex (PageControl: TPageControl): Integer;

function GetQuadDirection(Orientation : TiOrientation; Side : TiOrientationSide; ReverseOrientation, ReverseSide: Boolean): TiQuadDirection;

function GetRectCenterPoint(ARect: TRect): TPoint;
function GetSign(Value: Double): Double;

function ChangeColorIntensity(Value: TColor; RGBOffset: Integer): TColor;

function MMToInches(MMValue: Double):Double;

function GetAngleNormalized(Value: Double):Double;

procedure GetPaperTypePaperSize(PaperType: Smallint; var PaperWidthInches, PaperHeightInches: Double);
procedure GetPrinterPaperSize(var PaperWidthInches, PaperHeightInches: Double);

implementation

uses
  {$IFDEF iVCL} iEditorBasicComponents;{$ENDIF}
  {$IFDEF iCLX}QiEditorBasicComponents;{$ENDIF}

type
  TWriterAccess          = class(TWriter    )end;
  TReaderAccess          = class(TReader    )end;
  TPersistentAccess      = class(TPersistent)end;
  TComponentAccess       = class(TComponent )end;
  TCanvasAccess          = class(TCanvas    )end;
//****************************************************************************************************************************************************
function DimColor(Value: TColor; Divisor: Integer): TColor;
var
  Red,Green,Blue : Integer;
begin
  if Divisor > 0 then
    begin
      Red      := ((Value and     $FF)       ) div Divisor;
      Green    := ((Value and   $FF00) shr 8 ) div Divisor;
      Blue     := ((Value and $FF0000) shr 16) div Divisor;
    end
  else
    begin
      Red      :=  (Value and     $FF)         * -Divisor;
      Green    := ((Value and   $FF00) shr 8 ) * -Divisor;
      Blue     := ((Value and $FF0000) shr 16) * -Divisor;
    end;

  if Red   > 255 then Red   := 255;
  if Green > 255 then Green := 255;
  if Blue  > 255 then Blue  := 255;

  if Red   <   0 then Red   := 0;
  if Green <   0 then Green := 0;
  if Blue  <   0 then Blue  := 0;

  Result := Red + (Green shl 8) + (Blue shl 16);
end;
//*********************************************************************************************************************
function ColorLightenMultiplier(AColor: TColor; AMultiplier: Double): TColor;
var
  ARed, AGreen, ABlue : Integer;
begin
 AColor := ColorToRGB(AColor);

 ARed   := (AColor and     $FF);
 AGreen := (AColor and   $FF00) shr 8;
 ABlue  := (AColor and $FF0000) shr 16;

 ARed   := Trunc(ARed   + (255 - ARed  )*AMultiplier);
 AGreen := Trunc(AGreen + (255 - AGreen)*AMultiplier);
 ABlue  := Trunc(ABlue  + (255 - ABlue )*AMultiplier);

 if ARed   > 255 then ARed   := 255;
 if AGreen > 255 then AGreen := 255;
 if ABlue  > 255 then ABlue  := 255;

 if ARed   <   0 then ARed   := 0;
 if AGreen <   0 then AGreen := 0;
 if ABlue  <   0 then ABlue  := 0;

 Result := ARed + (AGreen shl 8) + (ABlue shl 16);
end;
//*********************************************************************************************************************
function ColorDarkenMultiplier(AColor: TColor; AMultiplier: Double): TColor;
var
  ARed, AGreen, ABlue : Integer;
begin
 AColor := ColorToRGB(AColor);

 ARed   := (AColor and     $FF);
 AGreen := (AColor and   $FF00) shr 8;
 ABlue  := (AColor and $FF0000) shr 16;

 ARed   := Trunc(ARed   - ARed  *AMultiplier);
 AGreen := Trunc(AGreen - AGreen*AMultiplier);
 ABlue  := Trunc(ABlue  - ABlue *AMultiplier);


 if ARed   > 255 then ARed   := 255;
 if AGreen > 255 then AGreen := 255;
 if ABlue  > 255 then ABlue  := 255;

 if ARed   <   0 then ARed   := 0;
 if AGreen <   0 then AGreen := 0;
 if ABlue  <   0 then ABlue  := 0;

 Result := ARed + (AGreen shl 8) + (ABlue shl 16);
end;
//*********************************************************************************************************************
function ColorOffset(AColor: TColor; AOffset: Byte; AIncrease: Boolean): TColor;
var
  ARed, AGreen, ABlue : Integer;
begin
 AColor := ColorToRGB(AColor);

 ARed   := (AColor and     $FF);
 AGreen := (AColor and   $FF00) shr 8;
 ABlue  := (AColor and $FF0000) shr 16;

 if AIncrease then
   begin
     ARed   := ARed   + AOffset;
     AGreen := AGreen + AOffset;
     ABlue  := ABlue  + AOffset;
   end
 else
   begin
     ARed   := ARed   - AOffset;
     AGreen := AGreen - AOffset;
     ABlue  := ABlue  - AOffset;
   end;

 if ARed   > 255 then ARed   := 255;
 if AGreen > 255 then AGreen := 255;
 if ABlue  > 255 then ABlue  := 255;

 if ARed   <   0 then ARed   := 0;
 if AGreen <   0 then AGreen := 0;
 if ABlue  <   0 then ABlue  := 0;

 Result := ARed + (AGreen shl 8) + (ABlue shl 16);
end;
//*********************************************************************************************************************
function ColorMouseDownBright (AColor: TColor):TColor; begin Result := ColorOffset(AColor, $10, True );end;
function ColorMouseDownBright2(AColor: TColor):TColor; begin Result := ColorOffset(AColor, $30, True );end;
function ColorGradientBright  (AColor: TColor):TColor; begin Result := ColorOffset(AColor, $20, True );end;
function ColorGradientDim     (AColor: TColor):TColor; begin Result := ColorOffset(AColor, $40, False);end;
//*********************************************************************************************************************
function ColorLighten1(AColor: TColor):TColor; begin Result := ColorLightenMultiplier(AColor, 0.15);end;
function ColorLighten2(AColor: TColor):TColor; begin Result := ColorLightenMultiplier(AColor, 0.25);end;
function ColorLighten3(AColor: TColor):TColor; begin Result := ColorLightenMultiplier(AColor, 0.50);end;
function ColorLighten4(AColor: TColor):TColor; begin Result := ColorLightenMultiplier(AColor, 0.75);end;
//*********************************************************************************************************************
function ColorDarken1 (AColor: TColor):TColor; begin Result := ColorDarkenMultiplier (AColor, 0.15);end;
function ColorDarken2 (AColor: TColor):TColor; begin Result := ColorDarkenMultiplier (AColor ,0.25);end;
function ColorDarken3 (AColor: TColor):TColor; begin Result := ColorDarkenMultiplier (AColor ,0.50);end;
function ColorDarken4 (AColor: TColor):TColor; begin Result := ColorDarkenMultiplier (AColor ,0.75);end;
//*********************************************************************************************************************
function GetTickCount(DesiredTicks, MaxTicks: Integer; Span: Double): Integer;
var
  x                 : Integer;
  MatchFound        : Boolean;
  NewTickMajorCount : Integer;
  ClosestCount      : Integer;
  Step              : Double;
  StepDivisor       : Double;
begin
  ClosestCount      := 99999;
  NewTickMajorCount := 0;

  for x := 2 to MaxTicks do
    begin
      MatchFound := False;

      Step        := Span/(x-1);
      StepDivisor := (Power(10, Trunc(Log10(Step))));

      if Round(Step/StepDivisor*1000) =  100 then MatchFound := True;
      if Round(Step/StepDivisor*1000) =  200 then MatchFound := True;
      if Round(Step/StepDivisor*1000) =  250 then MatchFound := True;
      if Round(Step/StepDivisor*1000) =  500 then MatchFound := True;
      if Round(Step/StepDivisor*1000) =  750 then MatchFound := True;
      if Round(Step/StepDivisor*1000) = 1000 then MatchFound := True;
      if Round(Step/StepDivisor*1000) = 2000 then MatchFound := True;
      if Round(Step/StepDivisor*1000) = 2500 then MatchFound := True;
      if Round(Step/StepDivisor*1000) = 5000 then MatchFound := True;
      if Round(Step/StepDivisor*1000) = 7500 then MatchFound := True;

      if MatchFound then
        if ABS(DesiredTicks - x) <= ClosestCount then
          begin
            ClosestCount      := ABS(DesiredTicks - x);
            NewTickMajorCount := x;
          end;

    end;

  if ClosestCount < 99999 then Result := NewTickMajorCount else Result := MaxTicks + 1;
end;
//*************************************************************************************************************************************
function GetNewMinMax(ActualTicks: Integer; DesiredMin, DesiredMax: Double; NewRange : Double; var NewMax, NewMin: Double): Boolean;
var
  StepValue  : Double;
  CenterZero : Boolean;
begin
  StepValue  := NewRange /(ActualTicks - 1);
  CenterZero := (DesiredMax > 0) and (DesiredMin < 0);

  if CenterZero then
    begin
      NewMin := NewRange;
      while NewMin > DesiredMin do
        NewMin := NewMin - StepValue;
      NewMax := NewMin + NewRange;
    end
  else
    begin
      if DesiredMax > 0 then
        begin
          NewMax := 0;

          while NewMax < DesiredMax do
            NewMax := NewMax + StepValue;

          NewMin := NewMax - NewRange;
          while (DesiredMin >= 0) and (NewMin < 0) do
            begin
              NewMax := NewMax + StepValue;
              NewMin := NewMin + StepValue;
            end;
        end
      else
        begin
          NewMin := 0;

          while NewMin > DesiredMin do
            NewMin := NewMin - StepValue;

          NewMax := NewMin + NewRange;

          if (DesiredMax <= 0) and (NewMax > 0) then
            begin
              NewMax := NewMax - StepValue;
              NewMin := NewMin - StepValue;
            end;
        end
    end;

  Result := (NewMax >= DesiredMax) and (NewMin <= DesiredMin);
end;
//*************************************************************************************************************************************
function GetNewMinMaxFixed(ActualTicks: Integer; DesiredMin, DesiredMax: Double; NewRange : Double; var NewMax, NewMin: Double): Boolean;
var
  StepValue  : Double;
  CenterZero : Boolean;
  Fail       : Boolean;
begin
  StepValue  := NewRange /(ActualTicks - 1);
  CenterZero := (DesiredMax > 0) and (DesiredMin < 0);

  if CenterZero then
    begin
      NewMin := NewRange;
      while (NewMin >= DesiredMin) do
        NewMin := NewMin - StepValue;
      NewMin := NewMin + StepValue;
      NewMax := NewMin + NewRange;
    end
  else
    begin
      if DesiredMin >= 0 then
        begin
          NewMin := 0;

          while NewMin < DesiredMin do
            NewMin := NewMin + StepValue;

          NewMax := NewMin + NewRange;
        end
      else
        begin
          NewMax := 0;

          while NewMax > DesiredMax do
            NewMax := NewMax - StepValue;

          NewMin := NewMax - NewRange;
        end
    end;

  Fail := False;
  if NewMax > DesiredMax then Fail := True;
  if NewMin < DesiredMin then Fail := True;
  if (NewMax + StepValue) <= DesiredMax then Fail := True;

  Result := not Fail;

  //Result := not((NewMax > DesiredMax) or (NewMin < DesiredMin));
end;
//****************************************************************************************************************************************************
procedure GetAutoScaleValuesAdjustable(DesiredMin, DesiredMax: Double; DesiredTicks, MaxTicks: Integer;
                                       var NewMin: Double; var NewMax: Double; var NewTicks: Integer);
var
  DesiredRange : Extended;
  NewRange     : Double;
  RangeBase    : Double;
  x            : Integer;
begin
  if DesiredMin <> DesiredMax then
    begin
      DesiredRange := ABS(DesiredMax - DesiredMin);

      NewTicks     := DesiredTicks;

      RangeBase := Power(10, Trunc(Log10(DesiredRange)));
      if DesiredRange < 1 then RangeBase := RangeBase/10;

      for x := 2 to 40 do
        begin
          NewRange := RangeBase*0.5*x;
          if (NewRange >= DesiredRange) then
            begin
              NewTicks := GetTickCount(DesiredTicks, MaxTicks, NewRange);
              if (NewTicks <= MaxTicks) then
                if GetNewMinMax(NewTicks, DesiredMin, DesiredMax, NewRange, NewMax, NewMin) then Break;
            end;
        end;
    end
  else
    begin
      NewMin   := DesiredMin;
      NewMax   := DesiredMax;
      NewTicks := 2;
    end;
end;
//****************************************************************************************************************************************************
procedure GetAutoScaleValuesFixed(DesiredMin, DesiredMax: Double; DesiredTicks, MaxTicks: Integer;
                                  var NewMin: Double; var NewMax: Double; var NewTicks: Integer);
var
  DesiredRange : Extended;
  NewRange     : Double;
  RangeBase    : Double;
  x, Y         : Integer;
  Found        : Boolean;

begin
  if DesiredMin <> DesiredMax then
    begin
      DesiredRange := ABS(DesiredMax - DesiredMin);

      NewTicks     := DesiredTicks;
      Found := False;

      RangeBase := Power(10, Trunc(Log10(DesiredRange)));
      if DesiredRange < 1 then RangeBase := RangeBase/10;

      for x := 100 downto 2 do
        begin
          NewRange := RangeBase*0.1*x;
          if (NewRange <= DesiredRange) then
            begin
              for y := MaxTicks downto 2 do
                begin
                  NewTicks := GetTickCount(DesiredTicks, y, NewRange);

                  if (NewTicks <= y) then
                    if GetNewMinMaxFixed(NewTicks, DesiredMin, DesiredMax, NewRange, NewMax, NewMin) then
                      Found := True;
                  if Found then Break;
                end;          
            end;
          if Found then Break;
        end;
    end
  else
    begin
      NewMin   := DesiredMin;
      NewMax   := DesiredMax;
      NewTicks := 2;
    end;
end;
//****************************************************************************************************************************************************
procedure LineBevel(Canvas: TCanvas; X1, Y1, X2, Y2: Integer; Style: TiBevelStyle);
var
  TempInt : Integer;
begin
  with Canvas do
    begin
      if X1 = X2 then
        begin
          if Y1 > Y2 then
            begin
              TempInt := Y1;
              Y1 := Y2;
              Y2 := TempInt;
            end;
          case Style of
            ibsNone    : begin
                           Polyline([Point(X1, Y1),Point(X2, Y2)]);
                         end;
            ibsRaised  : begin
                           Pen.Color := clWhite; Polyline([Point(X1,   Y1),Point(X2,   Y2)]);
                           Pen.Color := clBlack; Polyline([Point(X1+1, Y1),Point(X2+1, Y2)]);
                         end;
            ibsLowered : begin
                           Pen.Color := clBlack; Polyline([Point(X1,   Y1),Point(X2,   Y2)]);
                           Pen.Color := clWhite; Polyline([Point(X1+1, Y1),Point(X2+1, Y2)]);
                          end;
          end;
        end
      else
        begin
          if X1 > X2 then
            begin
              TempInt := X1;
              X1 := X2;
              X2 := TempInt;
            end;
          case Style of
            ibsNone    : begin
                           Polyline([Point(X1, Y1),Point(X2, Y2)]);
                         end;
            ibsRaised  : begin
                           Pen.Color := clWhite; Polyline([Point(X1, Y1  ),Point(X2, Y2  )]);
                           Pen.Color := clBlack; Polyline([Point(X1, Y1+1),Point(X2, Y2+1)]);
                         end;
            ibsLowered : begin
                           Pen.Color := clBlack; Polyline([Point(X1, Y1  ),Point(X2, Y2  )]);
                           Pen.Color := clWhite; Polyline([Point(X1, Y1+1),Point(X2, Y2+1)]);
                         end;
          end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure Line(Canvas: TCanvas; Left, Top, Right, Bottom: Integer);
begin
  with Canvas do
    begin
      Polyline([Point(Left, Top), Point(Right, Bottom)]);
    end;
end;
//****************************************************************************************************************************************************
function GetDecimalPoints(Max, Min : Double; Precision: Integer; PrecisionStyle : TiPrecisionStyle): Integer;
var
  Span : Double;
begin
  Result := 0;
  case PrecisionStyle of
    ipsSignificantDigits : if Precision > 0 then
                             begin
                               Span := ABS(Max - Min);                                     
                               if Span  <> 0 then Result := Precision - (Trunc(Log10(Span))+1) else Result := 0;
                               if Span   < 1 then Result := Result + 1;
                               if Result < 0 then Result := 0;
                             end;
    ipsFixedDecimalPoints : Result := Precision;
  end;
end;
//****************************************************************************************************************************************************
//Kylix TODO
{$ifndef iCLX}
function FillFontInfo(Font : TFont; Rotation : Integer) : TLogFont;
begin
   with Result do
     begin
       lfHeight         := Font.Height;
       lfWidth          := FW_DONTCARE;
       lfEscapement     := Rotation;
       lfOrientation    := Rotation;
       lfItalic         := Byte(fsItalic    in Font.Style);
       lfUnderline      := Byte(fsUnderline in Font.Style);
       lfStrikeOut      := Byte(fsStrikeOut in Font.Style);
       lfCharSet        := DEFAULT_CHARSET;
       lfPitchAndFamily := VARIABLE_PITCH;
       lfQuality        := DEFAULT_QUALITY;
       lfOutPrecision   := OUT_DEFAULT_PRECIS;
       lfClipPrecision  := CLIP_DEFAULT_PRECIS;
       if fsBold in Font.Style then lfWeight := FW_BOLD else lfWeight := FW_NORMAL;
       StrPCopy(lfFaceName, Font.Name);
     end;
end;
{$endif}
//****************************************************************************************************************************************************
function GetXYRadPoint(AngleDegrees, Radius: Double; Offset : TPoint) : TPoint;
begin
  Result := Point(Offset.x + Round(Cos(DegToRad(AngleDegrees))*Radius),Offset.y - Round(Sin(DegToRad(AngleDegrees))*Radius));
end;
//****************************************************************************************************************************************************
function GetXYRadPointDouble(AngleDegrees : Double; Radius : Double; Offset : TPointDouble) : TPointDouble;
begin
  Result.X := Offset.X + Cos(DegToRad(AngleDegrees))*Radius;
  Result.Y := Offset.Y - Sin(DegToRad(AngleDegrees))*Radius;
end;
//****************************************************************************************************************************************************
function GetCenterPointRect(X, Y, Width, Height: Integer): TRect;
var
  HalfWidth  : Integer;
  HalfHeight : Integer;
begin
  HalfWidth  := Width  div 2;
  HalfHeight := Height div 2;

  Result := Rect(X - HalfWidth, Y - HalfHeight, X + Width - HalfWidth, Y + Height - HalfHeight);
end;
//****************************************************************************************************************************************************
function iFormatPrecisionStyle(Value, Span : Double; Precision : Integer; PrecisionStyle : TiPrecisionStyle) : String;
var
  PrecisionString : String;
  PrecisionCount  : Integer;
  x               : Integer;
begin
  PrecisionCount  := GetDecimalPoints(Span, 0, Precision, PrecisionStyle);

  PrecisionString := '';
  for x := 1 to PrecisionCount do
    PrecisionString := PrecisionString + '0';

  Result := Trim(FormatFloat('0.' + PrecisionString, Value));

end;
//****************************************************************************************************************************************************
function PointOrientation(X, Y : Integer; Orientation : TiOrientation) : TPoint;
var
  TempX : Integer;
  TempY : Integer;
begin
  case Orientation of
    ioVertical : begin
                   TempX := X;
                   TempY := Y;
                 end;
    else         begin
                   TempX := Y;
                   TempY := X;
                 end;
  end;
  Result := Point(TempX, TempY);
end;
//****************************************************************************************************************************************************
function RectOrientation(Left, Top, Right, Bottom : Integer; Orientation : TiOrientation) : TRect;
var
  TempLeft   : Integer;
  TempTop    : Integer;
  TempRight  : Integer;
  TempBottom : Integer;
begin
  case Orientation of
    ioVertical : begin
                   TempLeft   := Left;
                   TempTop    := Top;
                   TempRight  := Right;
                   TempBottom := Bottom;
                 end;
    else         begin
                   TempLeft   := Top;
                   TempTop    := Right;
                   TempRight  := Bottom;
                   TempBottom := Left;
                 end;
  end;
  Result := Rect(TempLeft, TempTop, TempRight, TempBottom);
end;
//****************************************************************************************************************************************************
function iDrawText(Canvas: TCanvas; AText : String; var ARect : TRect; AFlags: TiTextFlags; AEnabled: Boolean; ABackgroundColor: TColor): Integer;
var
               TextFlags    : UINT;
               OldFontColor : TColor;
               ATempRect    : TRect;
  {$ifdef iCLX}AWideString  : WideString;{$endif}
  {$ifdef iCLX}BoundingRect : TRect;{$endif}
begin
  {$ifdef iVCL}
  TextFlags := 0;
  if not (itfShowPrefix   in AFlags) then TextFlags := TextFlags + DT_NOPREFIX;
  if      itfHLeft        in AFlags  then TextFlags := TextFlags + DT_LEFT;
  if      itfHCenter      in AFlags  then TextFlags := TextFlags + DT_CENTER;
  if      itfHRight       in AFlags  then TextFlags := TextFlags + DT_RIGHT;
  if      itfVTop         in AFlags  then TextFlags := TextFlags + DT_TOP;
  if      itfVCenter      in AFlags  then TextFlags := TextFlags + DT_VCENTER;
  if      itfVBottom      in AFlags  then TextFlags := TextFlags + DT_BOTTOM;
  if      itfWordBreak    in AFlags  then TextFlags := TextFlags + DT_WORDBREAK;
  if      itfSingleLine   in AFlags  then TextFlags := TextFlags + DT_SINGLELINE;
  if      itfExpandTabs   in AFlags  then TextFlags := TextFlags + DT_EXPANDTABS;
  if      itfNoClip       in AFlags  then TextFlags := TextFlags + DT_NOCLIP;
  if      itfCalcRect     in AFlags  then TextFlags := TextFlags + DT_CALCRECT;
  if      itfEndEllipsis  in AFlags  then TextFlags := TextFlags + DT_END_ELLIPSIS;
  if      itfPathEllipsis in AFlags  then TextFlags := TextFlags + DT_PATH_ELLIPSIS;
  if      itfWordEllipsis in AFlags  then TextFlags := TextFlags + DT_WORD_ELLIPSIS;
  if      itfModifyString in AFlags  then TextFlags := TextFlags + DT_MODIFYSTRING;

  if not (AEnabled) and not (itfCalcRect in AFlags) and (ColorToRGB(ABackgroundColor) <> 0) then
    begin
      OldFontColor := Canvas.Font.Color;
      ATempRect    := ARect;

      //Canvas.Font.Color := clBtnHighlight; OffsetRect(ATempRect, 1 , 1);           DrawText(Canvas.Handle, PChar(AText), Length(AText), ATempRect, TextFlags);
      //Canvas.Font.Color := clBtnShadow;    OffsetRect(ATempRect,-1 ,-1); Result := DrawText(Canvas.Handle, PChar(AText), Length(AText), ATempRect, TextFlags);

      Canvas.Font.Color := ColorOffset(clBtnFace, $40, true); OffsetRect(ATempRect, 1 , 1);           DrawText(Canvas.Handle, PChar(AText), Length(AText), ATempRect, TextFlags);
      Canvas.Font.Color := ColorOffset(clBtnFace, $20, false);    OffsetRect(ATempRect,-1 ,-1); Result := DrawText(Canvas.Handle, PChar(AText), Length(AText), ATempRect, TextFlags);

      Canvas.Font.Color := OldFontColor;
    end
  else Result := DrawText(Canvas.Handle, PChar(AText), Length(AText), ARect, TextFlags);

  {$endif}

  {$ifdef iCLX}
  TextFlags := 0;
  if itfHLeft      in AFlags then TextFlags := TextFlags + UINT(AlignmentFlags_AlignLeft);
  if itfHCenter    in AFlags then TextFlags := TextFlags + UINT(AlignmentFlags_AlignHCenter);
  if itfHRight     in AFlags then TextFlags := TextFlags + UINT(AlignmentFlags_AlignRight);
  if itfVTop       in AFlags then TextFlags := TextFlags + UINT(AlignmentFlags_AlignTop);
  if itfVCenter    in AFlags then TextFlags := TextFlags + UINT(AlignmentFlags_AlignVCenter);
  if itfVBottom    in AFlags then TextFlags := TextFlags + UINT(AlignmentFlags_AlignBottom);
  if itfWordBreak  in AFlags then TextFlags := TextFlags + UINT(AlignmentFlags_WordBreak);
  if itfSingleLine in AFlags then TextFlags := TextFlags + UINT(AlignmentFlags_SingleLine);
  if itfExpandTabs in AFlags then TextFlags := TextFlags + UINT(AlignmentFlags_ExpandTabs);
  if itfNoClip     in AFlags then TextFlags := TextFlags + UINT(AlignmentFlags_DontClip);
  if itfShowPrefix in AFlags then TextFlags := TextFlags + UINT(AlignmentFlags_ShowPrefix);

  Result      := 0;
  AWideString := AText;
  Canvas.Start;
  TCanvasAccess(Canvas).RequiredState([csHandleValid, csFontValid]);
  if itfCalcRect in AFlags then
    begin
      QPainter_boundingRect(Canvas.Handle, @BoundingRect, @ARect, TextFlags, PWideString(@AWideString), -1, nil);
      Result := BoundingRect.Bottom - BoundingRect.Top;
    end
  else
    begin
      if not AEnabled then
        begin
          OldFontColor := Canvas.Font.Color;
          ATempRect    := ARect;

          Canvas.Font.Color := clBtnHighlight; OffsetRect(ATempRect, 1 , 1); QPainter_drawText(Canvas.Handle, @ATempRect, TextFlags, PWideString(@AWideString), -1, nil, nil);
          Canvas.Font.Color := clBtnShadow;    OffsetRect(ATempRect,-1 ,-1); QPainter_drawText(Canvas.Handle, @ATempRect, TextFlags, PWideString(@AWideString), -1, nil, nil);

          Canvas.Font.Color := OldFontColor;
        end
      else QPainter_drawText(Canvas.Handle, @ARect, TextFlags, PWideString(@AWideString), -1, nil, nil);
    end;
  Canvas.Stop;
  {$endif}
end;
//****************************************************************************************************************************************************
function iDrawRotatedText(Canvas: TCanvas; AText : String; ARect : TRect; Angle: TiRotationAngle; TextLineAlignment: TiAlignmentHorizontal; AEnabled: Boolean; ABackgroundColor: TColor): TRect;
  var
{$ifdef iVCL}
  NewFont      : HFont;
  OldFont      : HFont;
  FontInfo     : TLogFont;
  NewRect      : TRect;
{$endif}
  CenterPoint  : TPoint;
  ATextWidth   : Integer;
  ATextHeight  : Integer;
  AFlags       : TiTextFlags;
begin
  with ARect do
    begin
      CenterPoint := Point((Left + Right) div 2, (Top + Bottom) div 2);
      ATextWidth  := Canvas.TextWidth (AText);
      ATextHeight := Canvas.TextHeight(AText);
    end;
{$ifdef iVCL}

  AFlags := [itfHLeft, itfVTop, itfNoClip, itfSingleLine];

  case Angle of
    ira000 : begin
               AFlags := [itfVCenter, itfNoClip];
               case TextLineAlignment of
                 iahCenter : AFlags := AFlags + [itfHCenter];
                 iahLeft   : AFlags := AFlags + [itfHLeft];
                 else        AFlags := AFlags + [itfHRight];
               end;

               if Pos(#13, AText) <> 0 then
                 iDrawText(Canvas, AText, ARect, AFlags, AEnabled, ABackgroundColor)
               else
                 iDrawText(Canvas, AText, ARect, AFlags + [itfSingleLine], AEnabled, ABackgroundColor);

               Result := Rect(CenterPoint.X - ATextWidth div 2, CenterPoint.Y - ATextHeight div 2,
                              CenterPoint.X + ATextWidth div 2, CenterPoint.Y + ATextHeight div 2);
             end;       
    ira090 : begin              
               GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @FontInfo);
               FontInfo.lfEscapement := 900;
               NewFont := CreateFontIndirect(FontInfo);
               try
                 OldFont := SelectObject(Canvas.Handle,NewFont);
                 NewRect := Rect(CenterPoint.X - ATextHeight div 2, CenterPoint.Y + ATextWidth div 2,
                                 CenterPoint.X + ATextHeight div 2, CenterPoint.Y + ATextWidth div 2);

                 iDrawText(Canvas, AText, NewRect, AFlags, AEnabled, ABackgroundColor);

                 SelectObject(Canvas.Handle,OldFont);
               finally
                 DeleteObject(NewFont);
               end;
               Result := Rect(CenterPoint.X - ATextHeight div 2, CenterPoint.Y - ATextWidth div 2,
                              CenterPoint.X + ATextHeight div 2, CenterPoint.Y + ATextWidth div 2);
             end;
    ira180 : begin
               GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @FontInfo);
               FontInfo.lfEscapement := 1800;
               NewFont := CreateFontIndirect(FontInfo);
               try
                 OldFont := SelectObject(Canvas.Handle,NewFont);
                 NewRect := Rect(CenterPoint.X + ATextWidth div 2, CenterPoint.Y + ATextHeight div 2,
                                 CenterPoint.X + ATextWidth div 2, CenterPoint.Y + ATextHeight div 2);
                 iDrawText(Canvas, AText, NewRect, AFlags, AEnabled, ABackgroundColor);

                 SelectObject(Canvas.Handle,OldFont);
               finally
                 DeleteObject(NewFont);
               end;
               Result := Rect(CenterPoint.X - ATextWidth div 2, CenterPoint.Y - ATextHeight div 2,
                              CenterPoint.X + ATextWidth div 2, CenterPoint.Y + ATextHeight div 2);
             end;
    ira270 : begin
               GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @FontInfo);
               FontInfo.lfEscapement := 2700;
               NewFont := CreateFontIndirect(FontInfo);
               try
                 OldFont := SelectObject(Canvas.Handle,NewFont);
                 NewRect := Rect(CenterPoint.X - ATextHeight div 2 + ATextHeight, CenterPoint.Y - ATextWidth div 2,
                                 CenterPoint.X + ATextHeight div 2 + ATextHeight, CenterPoint.Y - ATextWidth div 2);
                 iDrawText(Canvas, AText, NewRect, AFlags, AEnabled, ABackgroundColor);

                 SelectObject(Canvas.Handle,OldFont);
               finally
                 DeleteObject(NewFont);
               end;
               Result := Rect(CenterPoint.X - ATextHeight div 2, CenterPoint.Y - ATextWidth div 2,
                              CenterPoint.X + ATextHeight div 2, CenterPoint.Y + ATextWidth div 2);
             end;
  end;
{$endif}

{$IFDEF iCLX}
  Canvas.Start;
  try
   Qt.QPainter_save(Canvas.Handle);

   case Angle of
     ira000 : begin
                AFlags := [itfVCenter, itfNoClip];
                case TextLineAlignment of
                  iahCenter : AFlags := AFlags + [itfHCenter];
                  iahLeft   : AFlags := AFlags + [itfHLeft];
                  else        AFlags := AFlags + [itfHRight];
                end;

                iDrawText(Canvas, AText, ARect, AFlags, AEnabled, ABackgroundColor);
                Result := Rect(CenterPoint.X - ATextWidth div 2, CenterPoint.Y - ATextHeight div 2,
                               CenterPoint.X + ATextWidth div 2, CenterPoint.Y + ATextHeight div 2);
              end;
     ira090 : begin
                Qt.QPainter_translate(Canvas.Handle, ARect.Left, ARect.Top + (ARect.Bottom - ARect.Top) div 2 + ATextWidth div 2);
                QPainter_rotate(Canvas.Handle, -90);
                Canvas.TextOut(0, 0, AText);                                                                              
              end;
     ira180 : begin
                Qt.QPainter_translate(Canvas.Handle, ARect.Left + (ARect.Right - ARect.Left) div 2 + ATextWidth div 2, ARect.Top + ATextHeight);
                QPainter_rotate(Canvas.Handle, -180);
                Canvas.TextOut(0, 0, AText);
              end;
     ira270 : begin
                Qt.QPainter_translate(Canvas.Handle, ARect.Left + ATextHeight, ARect.Top + (ARect.Bottom - ARect.Top) div 2 - ATextWidth div 2);
                QPainter_rotate(Canvas.Handle, -270);
                Canvas.TextOut(0, 0, AText);
              end;
   end;
 finally
   Qt.QPainter_restore(Canvas.Handle);
   Canvas.Stop;
 end;
{$ENDIF}
end;
//****************************************************************************************************************************************************
function iPointReverse(Reverse : Boolean; X, Y: Integer) : TPoint;
begin
  if Reverse then
    begin
      Result := Point(Y, X);
    end
  else                                                       
    begin
      Result := Point(X, Y);
    end;
end;
//****************************************************************************************************************************************************
function GetPropertyValueString(const PropName : String; var PropString : String; const AList: TStringList): Boolean;
var
  x      : Integer;
  AName  : String;
begin
  Result := False;
  for x := 0 to AList.Count-1 do
    begin
      SeparateStrings(Alist.Strings[x], '=', AName, PropString);
      if UpperCase(AName) = UpperCase(PropName) then
        begin
          Result := True;
          AList.Delete(x);
          Break;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure SeparateStrings(const AText: String; Seperator : String; var LeftString: String; var RightString: String);
var
  ASeparatorPosition: Integer;
begin
  ASeparatorPosition := AnsiPos(Seperator, AText);
  if (ASeparatorPosition <> 0) then
    begin
      LeftString  := Trim(Copy(AText, 1, ASeparatorPosition - 1));
      RightString := Trim(Copy(AText, ASeparatorPosition + 1, Length(AText) - ASeparatorPosition));
    end
  else
    begin
      LeftString  := '';
      RightString := '';
    end;
end;
//****************************************************************************************************************************************************
function GetObjectProperty(Instance: TPersistent; const PropName: string): TObject;
var
  PropInfo: PPropInfo;
begin
  Result := nil;
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, PropName);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
    Result := TObject(GetOrdProp(Instance, PropInfo));
end;
//****************************************************************************************************************************************************
procedure SaveObjectToStringList(Instance: TPersistent; Path: String; DataList: TStringList; IgnoreList: TStringList);
var
  I         : Integer;
  Count     : Integer;
  PropInfo  : PPropInfo;
  PropList  : PPropList;
  PropName  : ShortString;
  PropValue : ShortString;
  OutString : ShortString;
  SubClass  : TObject;
begin
  Count := GetTypeData(Instance.ClassInfo)^.PropCount;
  if Count > 0 then
  begin
    GetMem(PropList, Count * SizeOf(Pointer));
    try
      GetPropInfos(Instance.ClassInfo, PropList);
      for I := 0 to Count - 1 do
      begin
        PropInfo := PropList^[I];
        if PropInfo <> nil then
          begin
            if IsStoredProp(Instance, PropInfo) and Assigned(PropInfo^.SetProc) then
              begin
                if Trim(Path) <> '' then PropName  := Path + '.' + PropInfo.Name
                  else PropName  := PropInfo.Name;

                if Assigned(IgnoreList) then if IgnoreList.IndexOf(PropName) <> -1 then Continue;


                case PropInfo^.PropType^.Kind of
                  tkInteger, tkEnumeration, tkSet, tkChar : begin
                                                              if PropInfo.Default = GetOrdProp(Instance, PropInfo) then Continue;

                                                              PropValue := IntToStr(GetOrdProp(Instance, PropInfo));
                                                              OutString := PropName + ' = ' + PropValue;
                                                              DataList.Add(OutString);
                                                            end;
                  tkFloat                                 : begin
                                                              PropValue := FloatToStr(GetFloatProp(Instance, PropInfo));
                                                              OutString := PropName + ' = ' + PropValue;
                                                              DataList.Add(OutString);
                                                            end;
                  tkString, tkLString, tkWString          : begin
                                                              PropValue := GetStrProp(Instance, PropInfo);
                                                              PropValue := StringReplace(PropValue, #13, '#13', [rfReplaceAll, rfIgnoreCase]);
                                                              PropValue := StringReplace(PropValue, #10, '#10', [rfReplaceAll, rfIgnoreCase]);
                                                              OutString := PropName + ' = ' + PropValue;
                                                              DataList.Add(OutString);
                                                            end;
                  tkClass                                 : begin
                                                              SubClass := GetObjectProperty(Instance, PropInfo.Name);
                                                              if SubClass is TPersistent then
                                                                SaveObjectToStringList(SubClass as TPersistent, PropName, DataList, IgnoreList);
                                                            end;
                end;

              end;
          end
        else Break;
      end;
    finally
      FreeMem(PropList, Count * SizeOf(Pointer));
    end;
  end;
end;
//****************************************************************************************************************************************************
procedure SetObjectProperty(Instance: TPersistent; PropertyName: String; PropertyValue: String; DecimalChar : String);
var
  PropInfo         : PPropInfo;
  AValue           : String;
  APropertyName    : String;
  APropertySubName : String;
begin
  if Pos('.', PropertyName) <> 0 then
    begin
      SeparateStrings(PropertyName, '.', APropertyName, APropertySubName);

      {$IFDEF COMPILER_4}
        PropInfo := GetPropInfo(Instance.ClassInfo, APropertyName);
      {$ELSE}
        PropInfo := GetPropInfo(Instance, APropertyName);
      {$ENDIF}
      if PropInfo <> nil then
        SetObjectProperty(GetObjectProperty(Instance, APropertyName) as TPersistent, APropertySubName, PropertyValue, DecimalChar)
    end
  else
    begin
      {$IFDEF COMPILER_4}
        PropInfo := GetPropInfo(Instance.ClassInfo, PropertyName);
      {$ELSE}
        PropInfo := GetPropInfo(Instance, PropertyName);
      {$ENDIF}
      if PropInfo <> nil then
        begin
          case PropInfo^.PropType^.Kind of
            tkInteger, tkEnumeration, tkSet, tkChar : begin
                                                        SetOrdProp(Instance, PropInfo, StrToInt(PropertyValue));
                                                      end;
            tkFloat                                 : begin
                                                        if      DecimalChar = '.' then AValue := StringReplace(PropertyValue, ',', DecimalChar, [rfIgnoreCase])
                                                        else if DecimalChar = ',' then AValue := StringReplace(PropertyValue, '.', DecimalChar, [rfIgnoreCase]);

                                                        SetFloatProp(Instance, PropInfo, StrToFloat(AValue));
                                                      end;
            tkString, tkLString, tkWString          : begin
                                                        AValue := StringReplace(PropertyValue, '#13', #13, [rfReplaceAll, rfIgnoreCase]);
                                                        AValue := StringReplace(PropertyValue, '#10', #10, [rfReplaceAll, rfIgnoreCase]);

                                                        SetStrProp(Instance, PropInfo, AValue);
                                                      end;
          end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure StripInstanceName(RootPath: String; var PropertyPath: String; var RemovedPath: String);
var
  ALeftString  : String;
  ARightString : String;
begin
  RemovedPath := '';
  SeparateStrings(PropertyPath, '.', ALeftString, ARightString);
  if (UpperCase(RootPath) = UpperCase(ALeftString)) and (RootPath <> '') then
    begin
      RemovedPath := ALeftString;
      PropertyPath := Copy(PropertyPath, Length(ALeftString + '.') + 1, Length(PropertyPath) - Length(ALeftString + '.'));
    end;
end;
//****************************************************************************************************************************************************
procedure LoadObjectFromStringList(Instance: TPersistent; RootPath: String; DataList: TStringList);
var
  ADecimalChar   : String;
  APropertyPath  : String;
  ARemovedPath   : String;
  APropertyValue : String;
begin
  ADecimalChar := Copy(FloatToStr(1.1), 2,1);
  while DataList.Count > 0 do
  begin
    SeparateStrings(DataList.Strings[0], '=', APropertyPath, APropertyValue);
    StripInstanceName(RootPath, APropertyPath, ARemovedPath);

    if RootPath = ARemovedPath then
      begin
        SetObjectProperty(Instance, APropertyPath, APropertyValue, ADecimalChar);
        DataList.Delete(0);
      end
    else break;
  end;
end;
//****************************************************************************************************************************************************
function GetCustomFormOwner(AComponent: TComponent): TWinControl;
var
  AControl : TComponent;
begin
  Result := nil;

  AControl := AComponent;

  while (AControl is TComponent) do
    begin
      if AControl.Owner is TCustomForm then
        begin
          Result := AControl.Owner as TCustomForm;
          Exit;
        end
      else if AControl.Owner is TwinControl then
        begin
          Result := AControl.Owner as TWinControl;
        end;
      AControl := AControl.Owner;
    end;
end;
//****************************************************************************************************************************************************
procedure ArcSegment(Canvas:TCanvas; StartDegrees, EndDegress : Double; Radius1, Radius2 : Integer; Offset : TPoint; AColor : TColor);
var
  Radius1Start      : TPoint;
  Radius1Stop       : TPoint;
  Radius2Start      : TPoint;
  Radius2Stop       : TPoint;
  Degree1           : Double;
  Degree2           : Double;
  PointArray        : array[0..804] of TPoint;
  IndexCount        : Integer;
  StepSize          : Double;
  x                 : Integer;
begin
  with Canvas do
    begin
      Pen.Color   := AColor;
      Brush.Color := AColor;
      IndexCount  := 0;

      if StartDegrees > EndDegress then
        begin
          Degree1 := EndDegress;
          Degree2 := StartDegrees;               
        end
      else
        begin
          Degree1 := StartDegrees;
          Degree2 := EndDegress;
        end;

      Radius1Start := GetXYRadPoint(Degree1, Radius1, Offset);
      Radius1Stop  := GetXYRadPoint(Degree2, Radius1, Offset);
      Radius2Start := GetXYRadPoint(Degree1, Radius2, Offset);
      Radius2Stop  := GetXYRadPoint(Degree2, Radius2, Offset);

      PointArray[IndexCount] := Radius1Start; inc(IndexCount);

      StepSize  := (Degree2 - Degree1)/400;

      for x := 1 to 399 do
        begin
          PointArray[IndexCount] := GetXYRadPoint(Degree1 + x*StepSize, Radius1, Offset);
          inc(IndexCount);
        end;                          

      PointArray[IndexCount] := Radius1Stop; inc(IndexCount);
      if Radius1 <> Radius2 then
        begin
          PointArray[IndexCount] := Radius2Stop; inc(IndexCount);

          for x := 399 downto 1 do
            begin
              PointArray[IndexCount] := GetXYRadPoint(Degree1 + x*StepSize, Radius2, Offset);
              inc(IndexCount);
            end;

          PointArray[IndexCount] := Radius2Start; inc(IndexCount);
          PointArray[IndexCount] := Radius1Start; inc(IndexCount);
                       
          Polygon(Slice(PointArray, IndexCount));
        end
      else Polyline(Slice(PointArray, IndexCount));

    end;
end;
//****************************************************************************************************************************************************
function TruncHalf(Value : Double): Integer;
begin
  Result := Trunc(Value + 0.5);
end;
//****************************************************************************************************************************************************
function PointDoubleToPoint(PointDouble: TPointDouble): TPoint;
begin
  Result := Point(Round(PointDouble.X), Round(PointDouble.Y));
end;
//****************************************************************************************************************************************************
procedure DrawRaisedBorder(Canvas:TCanvas; ARect: TRect);
begin
  with Canvas, ARect do
    begin
      Pen.Color := clBtnShadow;    PolyLine([Point(Left,Bottom-1  ), Point(Left   ,Top     ), Point(Right-1, Top  )]); //Outer
      Pen.Color := clBlack;        PolyLine([Point(Left,Bottom    ), Point(Right  ,Bottom  ), Point(Right  , Top  )]); //Outer

      Pen.Color := clBtnHighlight; PolyLine([Point(Left+1,Bottom-2), Point(Left+1 ,Top+1   ), Point(Right-2, Top+1)]); //Inner
      Pen.Color := clBtnShadow;    PolyLine([Point(Left+1,Bottom-1), Point(Right-1,Bottom-1), Point(Right-1, Top+1)]); //Inner
    end;
end;
//****************************************************************************************************************************************************
procedure DrawSunkenBorder(Canvas:TCanvas; ARect: TRect);
begin
  with Canvas, ARect do
    begin
      Pen.Color := clBtnShadow;    PolyLine([Point(Left,Bottom-1  ), Point(Left   ,Top     ), Point(Right-1, Top  )]); //Outer
      Pen.Color := clBtnHighlight; PolyLine([Point(Left,Bottom    ), Point(Right  ,Bottom  ), Point(Right  , Top  )]); //Outer

      Pen.Color := clBlack;        PolyLine([Point(Left+1,Bottom-2), Point(Left+1 ,Top+1   ), Point(Right-2, Top+1)]); //Inner
      Pen.Color := clBtnShadow;    PolyLine([Point(Left+1,Bottom-1), Point(Right-1,Bottom-1), Point(Right-1, Top+1)]); //Inner
    end;
end;
//****************************************************************************************************************************************************
function DateToMilliSeconds(Value: TDateTime) : Integer;
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  DecodeTime(Value, Hour, Min, Sec, MSec);
  Result :=           Trunc(Value + 0.000000000000001) * 24*60*60*1000;
  Result := Result +  Hour *60*60*1000;
  Result := Result +  Min     *60*1000;
  Result := Result +  Sec        *1000;
  Result := Result +  MSec;
  if Result < 0 then Result := High(Integer);
end;
//****************************************************************************************************************************************************
function DateToSeconds(Value: TDateTime) : Integer;
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  DecodeTime(Value, Hour, Min, Sec, MSec);
  Result :=           Trunc(Value + 0.000000000000001) * 24*60*60;
  Result := Result +  Hour *60*60;
  Result := Result +  Min     *60;
  Result := Result +  Sec;
  if Result < 0 then Result := High(Integer);
end;
//****************************************************************************************************************************************************
function DateToMinutes(Value: TDateTime) : Integer;
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  DecodeTime(Value, Hour, Min, Sec, MSec);
  Result :=           Trunc(Value + 0.000000000000001) * 24*60;
  Result := Result +  Hour *60;
  Result := Result +  Min;
  if Result < 0 then Result := 10000;
end;
//****************************************************************************************************************************************************
function DateToHours(Value: TDateTime) : Integer;
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;           
  MSec : Word;
begin
  DecodeTime(Value, Hour, Min, Sec, MSec);
  Result :=           Trunc(Value + 0.000000000000001) * 24;
  Result := Result +  Hour;
  if Result < 0 then Result := High(Integer);
end;
//****************************************************************************************************************************************************
procedure iDrawFocusRect(Canvas: TCanvas; ARect: TRect; BackgroundColor: TColor);
begin
  with Canvas do
    begin
      Pen.Color   := BackGroundColor;
      Brush.Color := BackGroundColor;
      iDrawFocusRect2(Canvas, ARect)
    end;
end;
//****************************************************************************************************************************************************
procedure iDrawFocusRect2(Canvas: TCanvas; ARect: TRect);
begin
  {$ifndef iCLX}
 // Canvas.Brush.Color := clBlack;
  Windows.DrawFocusRect(Canvas.Handle, ARect);
  {$else}
  Canvas.DrawFocusRect(ARect);
  {$endif}
end;
//****************************************************************************************************************************************************
procedure iDrawEdge(Canvas: TCanvas; ARect: TRect; Style: TiDrawEdgeStyle);
begin
  {$ifdef iVCL}
  case Style of
    idesSunken  : DrawEdge(Canvas.Handle, ARect, EDGE_SUNKEN, BF_TOPLEFT or BF_BOTTOMRIGHT);
    idesRaised  : DrawEdge(Canvas.Handle, ARect, EDGE_RAISED, BF_TOPLEFT or BF_BOTTOMRIGHT);
    idesFlat    : begin
                    Canvas.Pen.Color := clBtnShadow;
                    Canvas.Pen.Style := psSolid;
                    Canvas.Polygon([Point(ARect.Left, Arect.Top),
                                    Point(ARect.Right-1, ARect.Top),
                                    Point(ARect.Right-1, ARect.Bottom-1),
                                    Point(ARect.Left, ARect.Bottom-1)]);
                  end;
  end;
  {$else}
  case Style of
    idesRaised  : DrawEdge(Canvas,        ARect,  esRaised,  esRaised, [ebLeft, ebRight, ebTop, ebBottom]);
    idesSunken  : DrawEdge(Canvas,        ARect, esLowered, esLowered, [ebLeft, ebRight, ebTop, ebBottom]);
    idesFlat    : begin
                    Canvas.Pen.Color := clBtnShadow;
                    Canvas.Pen.Style := psSolid;
                    Canvas.Polygon([Point(ARect.Left, Arect.Top),
                                    Point(ARect.Right-1, ARect.Top),
                                    Point(ARect.Right-1, ARect.Bottom-1),
                                    Point(ARect.Left, ARect.Bottom-1)]);
                  end;
  end;
  {$endif}
end;
//****************************************************************************************************************************************************
procedure WriterWriteProperties(Writer: TWriter; Instance: TPersistent);
var
  I, Count: Integer;
  PropInfo: PPropInfo;
  PropList: PPropList;
begin
  try
    Count := GetTypeData(Instance.ClassInfo)^.PropCount;
    if Count > 0 then
      begin
        GetMem(PropList, Count * SizeOf(Pointer));
        try
          GetPropInfos(Instance.ClassInfo, PropList);
          for I := 0 to Count - 1 do
          begin
            PropInfo := PropList^[I];
            if PropInfo = nil then Continue;
            if IsStoredProp(Instance, PropInfo) and Assigned(PropInfo^.SetProc) and Assigned(PropInfo^.GetProc) then
              TWriterAccess(Writer).WriteProperty(Instance, PropInfo);
          end;
        finally
          FreeMem(PropList, Count * SizeOf(Pointer));
        end;
      end;
    TPersistentAccess(Instance).DefineProperties(Writer);
  except
    on e: Exception do;// raise Exception.Create('WriterWriteProperties Error : ' + e.message);
  end;
end;
//****************************************************************************************************************************************************
procedure iSetDesigning(AComponent: TComponent);
begin
  {$ifdef COMPILER_4}
  TComponentAccess(AComponent).SetDesigning(True);
  {$else}
  TComponentAccess(AComponent).SetDesigning(True, False);
  {$endif}
end;
//****************************************************************************************************************************************************
function iGetRValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb);
end;
//****************************************************************************************************************************************************
function iGetGValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb shr 8);
end;
//****************************************************************************************************************************************************
function iGetBValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb shr 16);
end;
//****************************************************************************************************************************************************
function GetClickRect(const Data: array of TPoint; MinSizePixels: Integer): TRect;
var
  i      : Integer;
  MinX   : Integer;
  MaxX   : Integer;
  MinY   : Integer;
  MaxY   : Integer;
  Center : Integer;
begin
  MinX := High(Integer);
  MinY := High(Integer);
  MaxX := Low(Integer);
  MaxY := Low(Integer);

  for i := 0 to High(Data) do
    begin
      if Data[i].X < MinX then MinX := Data[i].X;
      if Data[i].X > MaxX then MaxX := Data[i].X;
      if Data[i].Y < MinY then MinY := Data[i].Y;
      if Data[i].Y > MaxY then MaxY := Data[i].Y;
    end;

  if (MaxX - MinX) > MinSizePixels then
    begin
      Result.Left  := MinX;
      Result.Right := MaxX;
    end
  else
    begin
      Center := (MinX + MaxX) div 2;
      Result.Left  := Center -                 MinSizePixels div 2;
      Result.Right := Center + MinSizePixels - MinSizePixels div 2;
    end;

  if (MaxY - MinY) > MinSizePixels then
    begin
      Result.Top    := MinY;
      Result.Bottom := MaxY;
    end
  else
    begin
      Center := (MinY + MaxY) div 2;
      Result.Top    := Center -                 MinSizePixels div 2;
      Result.Bottom := Center + MinSizePixels - MinSizePixels div 2;
    end;
end;
//****************************************************************************************************************************************************
function GetShiftDown: Boolean;
begin
  {$IFDEF MSWINDOWS}
  Result := GetKeyState(iVK_SHIFT) < 0;
  {$ENDIF}

  {$IFDEF LINUX}
  Result := ssShift in Application.KeyState;
  {$ENDIF}
end;
//****************************************************************************************************************************************************
function GetCtrlDown: Boolean;
begin
  {$IFDEF MSWINDOWS}
  Result := GetKeyState(iVK_CONTROL) < 0;
  {$ENDIF}

  {$IFDEF LINUX}
  Result := ssCtrl in Application.KeyState;
  {$ENDIF}
end;
//****************************************************************************************************************************************************
function GetAltDown: Boolean;
begin
  {$IFDEF MSWINDOWS}
  Result := GetKeyState(iVK_MENU) < 0;
  {$ENDIF}

  {$IFDEF LINUX}
  Result := ssAlt in Application.KeyState;
  {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure iDecodeDate(const DateTime: TDateTime; var Year, Month, Day: Integer);
var
  AYear, AMonth, ADay : Word;
begin
  DecodeDate(DateTime, AYear, AMonth, ADay);
  Year  := AYear;
  Month := AMonth;
  Day   := ADay;
end;
//****************************************************************************************************************************************************
procedure SwapIntegers(var Integer1, Integer2 : Integer);
var
  TempInteger: Integer;
begin
  TempInteger := Integer1;
  Integer1    := Integer2;
  Integer2    := TempInteger;
end;
//****************************************************************************************************************************************************
function iRect(Left, Top, Right, Bottom: Integer): TRect;
begin
  if Right > Left then
    begin
      Result.Left  := Left;
      Result.Right := Right;
    end
  else
    begin
      Result.Left  := Right;
      Result.Right := Left;
    end;

  if Bottom > Top then
    begin
      Result.Top  := Top;
      Result.Bottom := Bottom;
    end
  else
    begin
      Result.Top    := Bottom;
      Result.Bottom := Top;
    end;
end;
//****************************************************************************************************************************************************
procedure iRectangle(Canvas: TCanvas; ARect: TRect);
var
  NewRect : TRect;
begin
  NewRect := iRect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
  Canvas.Rectangle(NewRect.Left, NewRect.Top, NewRect.Right, NewRect.Bottom);
end;
//****************************************************************************************************************************************************
function  iXYReverseRect(XYReverse: Boolean; XAxis1, YAxis1, XAxis2, YAxis2: Integer): TRect;
begin
  if XYReverse then
       Result := iRect(YAxis1, XAxis1, YAXis2, XAxis2)
  else Result := iRect(XAxis1, YAxis1, XAxis2, YAxis2);
end;
//****************************************************************************************************************************************************
function  iXYReversePoint(XYReverse: Boolean; XAxisValue, YAxisValue: Integer): TPoint;
begin
  if XYReverse then
       Result := Point(YAxisValue, XAxisValue)
  else Result := Point(XAxisValue, YAxisValue);
end;
//****************************************************************************************************************************************************
procedure DrawGradient(ACanvas: TCanvas; BackColor, ShawdowColor: TColor; ARect: TRect; ReverseColors: Boolean);
var
  Red, Green, Blue : Integer;
  StartRed         : Integer;
  StartGreen       : Integer;
  StartBlue        : Integer;
  StopRed          : Integer;
  StopGreen        : Integer;
  StopBlue         : Integer;
  i, x, y          : Integer;
  NumOfLines       : Integer;
  CenterPoint      : TPoint;
  LastX            : Integer;
  Radius           : Integer;
begin
  with ACanvas, ARect do
    begin
      Pen.Style := psSolid;

      StartRed   := iGetRValue(ColorToRGB(clWhite));
      StartGreen := iGetGValue(ColorToRGB(clWhite));
      StartBlue  := iGetBValue(ColorToRGB(clWhite));

      StopRed    := iGetRValue(ShawdowColor);
      StopGreen  := iGetGValue(ShawdowColor);
      StopBlue   := iGetBValue(ShawdowColor);

      Radius      := (Right - Left + 1) div 2;
      NumOfLines  := Radius*4;

      if NumOfLines = 0 then exit;

      for x := 0 to NumOfLines-1 do
        begin
          if ReverseColors then
            begin
              Red   := Round((x/NumOfLines*StartRed   + (NumOfLines-x)/NumOfLines*StopRed  ));
              Green := Round((x/NumOfLines*StartGreen + (NumOfLines-x)/NumOfLines*StopGreen));
              Blue  := Round((x/NumOfLines*StartBlue  + (NumOfLines-x)/NumOfLines*StopBlue ));
            end
          else
            begin
              Red   := Round((x/NumOfLines*StopRed    + (NumOfLines-x)/NumOfLines*StartRed  ));
              Green := Round((x/NumOfLines*StopGreen  + (NumOfLines-x)/NumOfLines*StartGreen));
              Blue  := Round((x/NumOfLines*StopBlue   + (NumOfLines-x)/NumOfLines*StartBlue ));
            end;

          Pen.Color := $02000000 + (Red + Green shl 8 + Blue shl 16);

          if x < (NumOfLines div 2) then
            Polyline([Point(Left+x, Top), Point(Left, Top+x)])
          else
            Polyline([Point(Right, Top + x - NumOfLines div 2), Point(Left+x - NumOfLines div 2, Bottom)])
        end;

      Pen.Color := BackColor;  
      LastX         := - 1;
      CenterPoint.X := (Left + Right ) div 2;
      CenterPoint.Y := (Top  + Bottom) div 2;

      for i := 0 to NumOfLines*2 do
        begin
          X := Round(Cos(DegToRad(90*i/(NumOfLines*2))) * Radius);
          Y := Round(Sin(DegToRad(90*i/(NumOfLines*2))) * Radius);
          if X = LastX then Continue;
          LastX := X;

          Polyline([Point(CenterPoint.X + X, CenterPoint.Y - Y), Point(CenterPoint.X + X, Top-1       )]);
          Polyline([Point(CenterPoint.X - X, CenterPoint.Y - Y), Point(CenterPoint.X - X, Top-1       )]);
          Polyline([Point(CenterPoint.X + X, CenterPoint.Y + Y), Point(CenterPoint.X + X, ARect.Bottom)]);
          Polyline([Point(CenterPoint.X - X, CenterPoint.Y + Y), Point(CenterPoint.X - X, ARect.Bottom)]);
        end;
    end;
end;
//****************************************************************************************************************************************************
function GetXYRadPoint2(AngleDegrees, Radius: Double; OffsetX, OffsetY : Double) : TPoint;
begin
  Result := Point(Trunc(OffsetX + Cos(DegToRad(AngleDegrees))*Radius),Trunc(OffsetY - Sin(DegToRad(AngleDegrees))*Radius));
end;                               
//****************************************************************************************************************************************************
procedure DrawGradientCircleRaised(Canvas: TCanvas; AColor: TColor; const CenterPoint: TPoint; Radius: Integer);
begin
  DrawGradientCircle(Canvas, ColorGradientBright(AColor), ColorGradientDim(AColor), CenterPoint, Radius, False);
end;
//****************************************************************************************************************************************************
procedure DrawGradientCircleSunken(Canvas: TCanvas; AColor: TColor; const CenterPoint: TPoint; Radius: Integer);
begin
  DrawGradientCircle(Canvas, ColorGradientBright(AColor), ColorGradientDim(AColor), CenterPoint, Radius, True);
end;
//****************************************************************************************************************************************************
procedure DrawGradientCircle(Canvas: TCanvas; StartColor, StopColor: TColor; const CenterPoint: TPoint; Radius: Integer; ReverseColors: Boolean);
var
  Red, Green, Blue : Integer;
  StartRed         : Integer;
  StartGreen       : Integer;
  StartBlue        : Integer;
  StopRed          : Integer;
  StopGreen        : Integer;
  StopBlue         : Integer;
  NumOfLines       : Integer;
  PointRadius      : Double;
  Size             : Double;
  Point1           : TPoint;
  Point2           : TPoint;
  LinePoint1       : TPoint;
  LinePoint2       : TPoint;
  MidX, MidY       : Double;
  PercentComplete  : Double;
begin
  with Canvas do
    begin
      StartColor := ColorToRGB(StartColor);
      StopColor  := ColorToRGB(StopColor);

      StartRed   := iGetRValue(StartColor);
      StartGreen := iGetGValue(StartColor);
      StartBlue  := iGetBValue(StartColor);

      StopRed    := iGetRValue(StopColor);
      StopGreen  := iGetGValue(StopColor);
      StopBlue   := iGetBValue(StopColor);

      Brush.Style := bsClear;
      Pen.Style   := psSolid;

      NumOfLines := Radius*2;

      if NumOfLines = 0 then exit;
                                            
      MidX := -Trunc(Radius/Sqrt(2)+2);
      MidY :=  Trunc(Radius/Sqrt(2)+2);

      while MidX < Radius/Sqrt(2)+2 do
        begin
          PointRadius := Sqrt(MidX*MidX + MidY*MidY);

          MidX := MidX + 0.5;
          MidY := MidY - 0.5;

          if PointRadius > Radius then Continue;

          Size := Sqrt(Radius*Radius - PointRadius*PointRadius);

          Point1 := GetXYRadPoint2(45 - 90, Size, MidX, MidY);
          Point2 := Point(-Point1.Y, -Point1.X);

          PercentComplete := (MidX + Radius)/Radius/2;

          if ReverseColors then
            begin
              Red   := Round((PercentComplete*StartRed   + (1-PercentComplete)*StopRed  ));
              Green := Round((PercentComplete*StartGreen + (1-PercentComplete)*StopGreen));
              Blue  := Round((PercentComplete*StartBlue  + (1-PercentComplete)*StopBlue ));
            end
          else
            begin
              Red   := Round((PercentComplete*StopRed    + (1-PercentComplete)*StartRed  ));
              Green := Round((PercentComplete*StopGreen  + (1-PercentComplete)*StartGreen));
              Blue  := Round((PercentComplete*StopBlue   + (1-PercentComplete)*StartBlue ));
            end;

          Pen.Color := $02000000 or (Red + (Green shl 8) + (Blue shl 16));
          LinePoint1 := Point(CenterPoint.X + Point1.X - 1, CenterPoint.Y - Point1.Y - 1);
          LinePoint2 := Point(CenterPoint.X + Point2.X - 1, CenterPoint.Y - Point2.Y - 1);
          Polyline([LinePoint1, LinePoint2]);
        end;
    end;
end;
//****************************************************************************************************************************************************
function GetNextRowString(var StringCurrentPos, StringScanPos: PChar; var RowString: String): Boolean;
begin
  if StringScanPos^ <> #0 then
    begin
      Result := True;
      while not (StringScanPos^ in [#0, #13, #10]) do Inc(StringScanPos);

      SetString(RowString, StringCurrentPos, StringScanPos - StringCurrentPos);

      if StringScanPos^ = #13 then Inc(StringScanPos);
      if StringScanPos^ = #10 then Inc(StringScanPos);

      StringCurrentPos := StringScanPos;
    end
  else
    begin
      RowString := '';
      Result    := False;
    end;
end;
//****************************************************************************************************************************************************
function  iTextWidth(Canvas: TCanvas; AText: String): Integer;
var
  StringCurrentPos : PChar;
  StringScanPos    : PChar;
  RowString        : String;
  AWidth           : Integer;
begin
  if AText <> '' then
    begin
      with Canvas do
        begin
          Result           := 0;
          StringCurrentPos := Pointer(AText);
          StringScanPos    := StringCurrentPos;

          while GetNextRowString(StringCurrentPos, StringScanPos, RowString) do
            begin
              AWidth := TextWidth(RowString);
              if AWidth > Result then Result := AWidth;
            end;
        end;
    end
  else Result := 0;
end;
//****************************************************************************************************************************************************
function  iTextHeight(Canvas: TCanvas; AText: String): Integer;
var
  ARect : TRect;
begin
  ARect  := Rect(0, 0, 0, 0);
  Result := iDrawText(Canvas, AText, ARect, [itfCalcRect, itfNoClip], True, clBtnFace);
end;
//****************************************************************************************************************************************************
function  iTextHeightFixedWidth(Canvas: TCanvas; AText: String; FixedWidth: Integer): Integer;
var
  ARect : TRect;
begin
  ARect            := Rect(0, -800, FixedWidth, -100);
  Result := iDrawText(Canvas, AText, ARect, [itfHLeft,itfWordBreak, itfVTop], True, clBtnFace);
end;
//****************************************************************************************************************************************************
procedure iAlignVCenterControl(RefControl, AlignControl : TControl);
begin
  AlignControl.Top := RefControl.Top + RefControl.Height div 2 - AlignControl.Height div 2;
end;
//****************************************************************************************************************************************************
procedure iDrawButtonArrowUp(Canvas: TCanvas; ARect: TRect; Down: Boolean);
var
  CenterPoint : TPoint;
begin
  with Canvas, ARect do
    begin
      Pen.Color   := clBlack;
      Pen.Style   := psSolid;
      Brush.Color := clBlack;
      Brush.Style := bsSolid;

      CenterPoint := Point((Right + Left) div 2 - 1, (Bottom + Top) div 2);

      if Down then CenterPoint := Point(CenterPoint.X + 1, CenterPoint.Y + 1);

      Canvas.Polygon([Point(CenterPoint.X - 3, CenterPoint.Y + 1),
                      Point(CenterPoint.X + 3, CenterPoint.Y + 1),
                      Point(CenterPoint.X    , CenterPoint.Y - 2)]);
    end;
end;
//****************************************************************************************************************************************************
procedure iDrawButtonArrowDown(Canvas: TCanvas; ARect: TRect; Down: Boolean);
var
  CenterPoint : TPoint;
begin
  with Canvas, ARect do
    begin
      Pen.Color   := clBlack;
      Pen.Style   := psSolid;
      Brush.Color := clBlack;
      Brush.Style := bsSolid;

      CenterPoint := Point((Right + Left) div 2 - 1, (Bottom + Top) div 2 - 1);

      if Down then CenterPoint := Point(CenterPoint.X + 1, CenterPoint.Y + 1);

      Canvas.Polygon([Point(CenterPoint.X - 3, CenterPoint.Y - 2),
                      Point(CenterPoint.X + 3, CenterPoint.Y - 2),
                      Point(CenterPoint.X    , CenterPoint.Y + 1)]);
    end;
end;
//****************************************************************************************************************************************************
procedure AssignObject(Source, Destination: TPersistent);
var
  i        : Integer;
  Count    : Integer;
  PropInfo : PPropInfo;
  PropList : PPropList;
begin
  Count := GetTypeData(Source.ClassInfo)^.PropCount;
  if Count > 0 then
  begin
    GetMem(PropList, Count * SizeOf(Pointer));
    try
      GetPropInfos(Source.ClassInfo, PropList);
      for i := 0 to Count - 1 do
      begin
        PropInfo := PropList^[i];
        if PropInfo <> nil then
          begin
            if IsStoredProp(Source, PropInfo) and Assigned(PropInfo^.SetProc) then
              begin
                case PropInfo^.PropType^.Kind of
                  tkInteger, tkEnumeration, tkSet, tkChar : SetOrdProp  (Destination, GetPropInfo(PTypeInfo(Source.ClassInfo), PropInfo.Name), GetOrdProp  (Source, PropInfo));
                  tkFloat                                 : SetFloatProp(Destination, GetPropInfo(PTypeInfo(Source.ClassInfo), PropInfo.Name), GetFloatProp(Source, PropInfo));
                  tkString, tkLString, tkWString          : SetStrProp  (Destination, GetPropInfo(PTypeInfo(Source.ClassInfo), PropInfo.Name), GetStrProp  (Source, PropInfo));
                  tkClass                                 : ;
                end;
              end;
          end
        else Break;
      end;
    finally
      FreeMem(PropList, Count * SizeOf(Pointer));
    end;
  end;
end;
//****************************************************************************************************************************************************
function PointDouble(X, Y: Double): TPointDouble;
begin
  Result.x := X;
  Result.y := Y;
end;
//****************************************************************************************************************************************************
procedure DrawGradientDirection(Canvas: TCanvas; ARect: TRect; Direction: TiFillDirection; ColorStart, ColorStop: TColor);
var
  Red, Green, Blue : Integer;
  StartRed         : Integer;
  StartGreen       : Integer;
  StartBlue        : Integer;
  StopRed          : Integer;
  StopGreen        : Integer;
  StopBlue         : Integer;
  x                : Integer;
  MaxLines         : Integer;
  NumOfLines       : Integer;
  ReverseColors    : Boolean;
  AWidth           : Integer;
  AHeight          : Integer;
begin
  AWidth  := ARect.Right  - ARect.Left;
  AHeight := ARect.Bottom - ARect.Top;

  with Canvas, ARect do
    begin
      if      Right = Bottom then MaxLines := Right
      else if Right > Bottom then MaxLines := Right
      else                        MaxLines := Bottom;

      StartRed   := (ColorStart and $0000FF);
      StartGreen := (ColorStart and $00FF00) shr 8;
      StartBlue  := (ColorStart and $FF0000) shr 16;

      StopRed   := (ColorStop and $0000FF);
      StopGreen := (ColorStop and $00FF00) shr 8;
      StopBlue  := (ColorStop and $FF0000) shr 16;

      Brush.Style := bsClear;

      case Direction of
        ifdTopBottom          : begin NumOfLines := (AHeight  - 1);      ReverseColors := False; Pen.Width := 1; end;
        ifdBottomTop          : begin NumOfLines := (AHeight  - 1);      ReverseColors := True;  Pen.Width := 1; end;
        ifdLeftRight          : begin NumOfLines := (AWidth   - 1);      ReverseColors := False; Pen.Width := 1; end;
        ifdRightLeft          : begin NumOfLines := (AWidth   - 1);      ReverseColors := True;  Pen.Width := 1; end;
        ifdTopLeftBottomRight : begin NumOfLines := (MaxLines - 1)*2;    ReverseColors := False; Pen.Width := 1; end;
        ifdBottomRightTopLeft : begin NumOfLines := (MaxLines - 1)*2;    ReverseColors := True;  Pen.Width := 1; end;
        ifdBottomLeftTopRight : begin NumOfLines := (MaxLines - 1)*2;    ReverseColors := False; Pen.Width := 1; end;
        ifdTopRightBottomLeft : begin NumOfLines := (MaxLines - 1)*2;    ReverseColors := True;  Pen.Width := 1; end;
        ifdRectangleOut       : begin NumOfLines := (MaxLines - 1)div 3; ReverseColors := False; Pen.Width := 2; end;
        ifdRectangleIn        : begin NumOfLines := (MaxLines - 1)div 3; ReverseColors := True;  Pen.Width := 2; end;
        ifdCircleOut          : begin NumOfLines := (MaxLines - 1)div 8; ReverseColors := False; Pen.Width := 16;end;
        ifdCircleIn           : begin NumOfLines := (MaxLines - 1)div 8; ReverseColors := True;  Pen.Width := 16;end;
        else                    begin NumOfLines := 0;                   ReverseColors := False; Pen.Width := 1; end;
      end;

      for x := 0 to NumOfLines do
        begin
          if ReverseColors then
            begin
              Red   := Round((x/NumOfLines*StartRed   + (NumOfLines-x)/NumOfLines*StopRed  ));
              Green := Round((x/NumOfLines*StartGreen + (NumOfLines-x)/NumOfLines*StopGreen));
              Blue  := Round((x/NumOfLines*StartBlue  + (NumOfLines-x)/NumOfLines*StopBlue ));
            end
          else
            begin
              Red   := Round((x/NumOfLines*StopRed    + (NumOfLines-x)/NumOfLines*StartRed  ));
              Green := Round((x/NumOfLines*StopGreen  + (NumOfLines-x)/NumOfLines*StartGreen));
              Blue  := Round((x/NumOfLines*StopBlue   + (NumOfLines-x)/NumOfLines*StartBlue ));
            end;

          Pen.Color := Red + Green shl 8 + Blue shl 16;

          case Direction of
            ifdBottomTop,
            ifdTopBottom           : Polyline([Point(Left   , Top + x      ),
                                               Point(Right  , Top + x      )]);

            ifdRightLeft,
            ifdLeftRight           : Polyline([Point(Left + x, Top    ),
                                               Point(Left + x, Bottom)]);

            ifdTopLeftBottomRight,
            ifdBottomRightTopLeft  : Polyline([Point(Round(x/NumOfLines*2*(Right-1))-1, 0),
                                               Point(-1, Round(x/NumOfLines*2*(Bottom-1)))]);

            ifdBottomLeftTopRight,
            ifdTopRightBottomLeft  : Polyline([Point(0, Bottom-1-Round(x/NumOfLines*2*(Bottom-1))),
                                               Point(Round(x/NumOfLines*2*(Right-1)), Bottom-1)]);

            ifdRectangleOut,
            ifdRectangleIn         : Rectangle(Round((Right-1)/2-x/NumOfLines*(Right-1)/2),Round((Bottom-1)/2+x/NumOfLines*(Bottom-1)/2),
                                               Round((Right-1)/2+x/NumOfLines*(Right-1)/2),Round((Bottom-1)/2-x/NumOfLines*(Bottom-1)/2));

            ifdCircleOut,
            ifdCircleIn            : Ellipse  (Round((Right-1)/2-x/NumOfLines*1.414*(Right-1)/2),Round((Bottom-1)/2+x/NumOfLines*1.414*(Bottom-1)/2),
                                               Round((Right-1)/2+x/NumOfLines*1.414*(Right-1)/2),Round((Bottom-1)/2-x/NumOfLines*1.414*(Bottom-1)/2));
          end;
        end;
      //Kylix TODO
      {$ifndef iCLX}
      if Direction = ifdRectangleOut then Pixels[ARect.Left + AWidth div 2 - 1, ARect.Top + AHeight div 2 - 1] := ColorStart;
      if Direction = ifdRectangleIn  then Pixels[ARect.Left + AWidth div 2 - 1, ARect.Top + AHeight div 2 - 1] := ColorStop;
      {$else}
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
function iStrToInt(Value: String): LongWord;
var
  ACharacter   : String;
  AString      : String;
  CurrentPower : Integer;

begin
  Result       := 0;
  CurrentPower := 0;
  ACharacter   := Copy(Value, 1, 1);

  if ACharacter = 'b' then
    begin
      AString := Copy(Value, 2, Length(Value) -1);
      while Length(AString) <> 0 do
        begin
          ACharacter := Copy(AString, Length(AString), 1);
          Result := Result + StrToInt(ACharacter) * Trunc(Power(2, CurrentPower) + 0.0001);
          AString := Copy(AString, 1, Length(AString) -1);
          Inc(CurrentPower);
        end;
    end
  else if ACharacter = 'o' then
    begin
      AString := Copy(Value, 2, Length(Value) -1);
      while Length(AString) <> 0 do
        begin
          ACharacter := Copy(AString, Length(AString), 1);
          Result := Result + StrToInt(ACharacter) * Trunc(Power(8, CurrentPower) + 0.0001);
          AString := Copy(AString, 1, Length(AString) -1);
          Inc(CurrentPower);
        end;
    end
  else
    begin
      Result := StrToInt(Value);
    end;
end;
//****************************************************************************************************************************************************
function iIntToStr(Value: Longword; Format: TiIntegerFormatStyle; MaxLength: Integer; LeadingZeros: Boolean): String;
var
  x               : Integer;
  ShiftMultiplier : Integer;
  DigitValue      : Integer;
  TempValue       : Longword;
begin
  Result := '';

  ShiftMultiplier := 0;
  TempValue       := Value;

  case Format of
    iifsInteger : begin
                    Result := IntToStr(Value);
                  end;                               
    iifsHex     : begin
                    for x := 1 to 8 do
                      begin
                        if ShiftMultiplier <> 0 then TempValue := Value shr (4*ShiftMultiplier);
                        DigitValue := TempValue and $F;
                        Result := IntToHex(DigitValue, 1) + Result;
                        Inc(ShiftMultiplier);
                      end;
                  end;
    iifsBinary  : begin
                    for x := 1 to 32 do
                      begin
                        if ShiftMultiplier <> 0 then TempValue := Value shr (1*ShiftMultiplier);
                        DigitValue := TempValue and $1;
                        Result := IntToStr(DigitValue) + Result;
                        Inc(ShiftMultiplier);
                      end;
                  end;
    iifsOctal   : begin
                    for x := 1 to 10 do
                      begin
                        if ShiftMultiplier <> 0 then TempValue := Value shr (3*ShiftMultiplier);
                        DigitValue := TempValue and $7;
                        Result := IntToStr(DigitValue) + Result;
                        Inc(ShiftMultiplier);
                      end;
                  end;
  end;

  while Copy(Result, 1, 1) = '0' do
    Result := Copy(Result, 2, Length(Result) - 1);

  if LeadingZeros then
    begin
      while Length(Result) < MaxLength do
        Result := '0' + Result;
    end;

  if Result = '' then Result := '0';
end;
//****************************************************************************************************************************************************
procedure iDrawTriangle(Canvas: TCanvas; ARect: TRect; Direction: TiDirection);
begin
  case Direction of
    idLeft  : Canvas.Polygon([Point(ARect.Left,  (ARect.Top + ARect.Bottom) div 2),
                              Point(ARect.Right, (ARect.Top               )      ),
                              Point(ARect.Right, (ARect.Bottom            )      )]);
    idRight : Canvas.Polygon([Point(ARect.Right, (ARect.Top + ARect.Bottom) div 2),
                              Point(ARect.Left,  (ARect.Top               )      ),
                              Point(ARect.Left,  (ARect.Bottom            )      )]);

    idUp    : Canvas.Polygon([Point((ARect.Left + ARect.Right) div 2, ARect.Top   ),
                              Point((ARect.Left              ),       ARect.Bottom),
                              Point((ARect.Right             ),       ARect.Bottom)]);
    idDown  : Canvas.Polygon([Point((ARect.Left + ARect.Right) div 2, ARect.Bottom),
                              Point((ARect.Left              ),       ARect.Top   ),
                              Point((ARect.Right             ),       ARect.Top   )]);
  end;
end;
//****************************************************************************************************************************************************
procedure iSetFocus(WinControl: TWinControl);
begin
  {$ifdef iVCL} Windows.SetFocus(WinControl.Handle);{$endif}
  {$ifdef iCLX} WinControl.SetFocus      {$endif}
end;
//****************************************************************************************************************************************************
procedure SetActivePageIndex(PageControl: TPageControl; Index: Integer);
begin
  if Index < PageControl.PageCount then PageControl.ActivePage := PageControl.Pages[Index];
end;
//****************************************************************************************************************************************************
function GetActivePageIndex(PageControl: TPageControl): Integer;
var
  x : Integer;
begin
  Result := -1;
  for x := 0 to PageControl.PageCount-1 do
    begin
      if PageControl.Pages[x] = PageControl.ActivePage then
        begin
          Result := x;
          Exit;
        end;
    end;
end;
//****************************************************************************************************************************************************
function GetRectCenterPoint(ARect: TRect): TPoint;
begin
  Result.X := (ARect.Right + ARect.Left  ) div 2;
  Result.Y := (ARect.Top   + ARect.Bottom) div 2;
end;
//****************************************************************************************************************************************************
function GetQuadDirection(Orientation : TiOrientation; Side : TiOrientationSide; ReverseOrientation, ReverseSide: Boolean): TiQuadDirection;
var
  AOrientation : TiOrientation;
  ASide        : TiOrientationSide;
begin
  AOrientation := Orientation;
  ASide        := Side;

  if ReverseOrientation then
    begin
      if AOrientation = ioVertical then AOrientation := ioHorizontal
      else                              AOrientation := ioVertical;
    end;

  if ReverseSide then
    begin
      if ASide = iosBottomRight then ASide := iosTopLeft
      else                           ASide := iosBottomRight;
    end;

  if      (AOrientation = ioVertical)   and (ASide = iosBottomRight) then Result := iqdRight
  else if (AOrientation = ioVertical)   and (ASide = iosTopLeft    ) then Result := iqdLeft
  else if (AOrientation = ioHorizontal) and (ASide = iosBottomRight) then Result := iqdBottom
  else                                                                    Result := iqdTop;
end;
//****************************************************************************************************************************************************
function GetSign(Value: Double): Double;
begin
  if Value >= 0 then Result := 1 else Result := -1;
end;
//****************************************************************************************************************************************************
function ChangeColorIntensity(Value: TColor; RGBOffset: Integer):TColor;
var
  Red   : Integer;
  Green : Integer;
  Blue  : Integer;
begin
  Red   := iGetRValue(ColorToRGB(Value));
  Green := iGetGValue(ColorToRGB(Value));
  Blue  := iGetBValue(ColorToRGB(Value));

  Red   := Red   + RGBOffset;
  Green := Green + RGBOffset;
  Blue  := Blue  + RGBOffset;

  if Red   > $FF then Red   := $FF;
  if Green > $FF then Green := $FF;
  if Blue  > $FF then Blue  := $FF;

  if Red   < 0 then Red   := 0;
  if Green < 0 then Green := 0;
  if Blue  < 0 then Blue  := 0;

  Result := $02000000 + (Red + Green shl 8 + Blue shl 16);
end;
//****************************************************************************************************************************************************
function MMToInches(MMValue: Double):Double;
begin
  Result := MMValue/10/2.54;
end;
//****************************************************************************************************************************************************
procedure GetPaperTypePaperSize(PaperType: Smallint; var PaperWidthInches, PaperHeightInches: Double);
begin
  case PaperType of
    iDMPAPER_LETTER                  : begin PaperWidthInches  := 8.5;             PaperHeightInches := 11;              end; // 1 = {Letter                  8.5    x 11     in}
    iDMPAPER_LETTERSMALL             : begin PaperWidthInches  := 8.5;             PaperHeightInches := 11;              end; // 2 = {Letter Small            8.5    x 11     in}
    iDMPAPER_TABLOID                 : begin PaperWidthInches  := 11;              PaperHeightInches := 17;              end; // 3 = {Tabloid                 11     x 17     in}
    iDMPAPER_LEDGER                  : begin PaperWidthInches  := 17;              PaperHeightInches := 11;              end; // 4 = {Ledger                  17     x 11     in}
    iDMPAPER_LEGAL                   : begin PaperWidthInches  := 8.5;             PaperHeightInches := 14;              end; // 5 = {Legal                   8.5    x 14     in}
    iDMPAPER_STATEMENT               : begin PaperWidthInches  := 5.5;             PaperHeightInches := 8.5;             end; // 6 = {Statement               5.5    x 8.5    in}
    iDMPAPER_EXECUTIVE               : begin PaperWidthInches  := 7.25;            PaperHeightInches := 10.5;            end; // 7 = {Executive               7.25   x 10.5   in}
    iDMPAPER_A3                      : begin PaperWidthInches  := MMToInches(297); PaperHeightInches := MMToInches(420); end; // 8 = {A3                      297    x 420    mm}
    iDMPAPER_A4                      : begin PaperWidthInches  := MMToInches(210); PaperHeightInches := MMToInches(297); end; // 9 = {A4                      210    x 297    mm}
    iDMPAPER_A4SMALL                 : begin PaperWidthInches  := MMToInches(210); PaperHeightInches := MMToInches(297); end; //10 = {A4 Small                210    x 297    mm}
    iDMPAPER_A5                      : begin PaperWidthInches  := MMToInches(148); PaperHeightInches := MMToInches(210); end; //11 = {A5                      148    x 210    mm}
    iDMPAPER_B4                      : begin PaperWidthInches  := MMToInches(250); PaperHeightInches := MMToInches(354); end; //12 = {B4 (JIS)                250    x 354    mm}
    iDMPAPER_B5                      : begin PaperWidthInches  := MMToInches(182); PaperHeightInches := MMToInches(257); end; //13 = {B5 (JIS)                182    x 257    mm}
    iDMPAPER_FOLIO                   : begin PaperWidthInches  :=  8.50;           PaperHeightInches := 13;              end; //14 = {Folio                   8.5    x 13     in}
    iDMPAPER_QUARTO                  : begin PaperWidthInches  := MMToInches(215); PaperHeightInches := MMToInches(275); end; //15 = {Quarto                  215    x 275    mm}
    iDMPAPER_10X14                   : begin PaperWidthInches  := 10;              PaperHeightInches := 14;              end; //16 = {                        10     x 14     in}
    iDMPAPER_11X17                   : begin PaperWidthInches  := 11;              PaperHeightInches := 17;              end; //17 = {                        11     x 17     in}
    iDMPAPER_NOTE                    : begin PaperWidthInches  := 8.5;             PaperHeightInches := 11;              end; //18 = {Note                    8.5    x 11     in}
    iDMPAPER_ENV_9                   : begin PaperWidthInches  := 3.875;           PaperHeightInches := 8.875;           end; //19 = {Envelope #9             3.875  x 8.875  in}
    iDMPAPER_ENV_10                  : begin PaperWidthInches  := 4.125;           PaperHeightInches := 9.5;             end; //20 = {Envelope #10            4.125  x 9.5    in}
    iDMPAPER_ENV_11                  : begin PaperWidthInches  := 4.5;             PaperHeightInches := 10.375;          end; //21 = {Envelope #11            4.5    x 10.375 in}
    iDMPAPER_ENV_12                  : begin PaperWidthInches  := 4.75;            PaperHeightInches := 11;              end; //22 = {Envelope #12            4.75   x 11     in}
    iDMPAPER_ENV_14                  : begin PaperWidthInches  := 5;               PaperHeightInches := 11.5;            end; //23 = {Envelope #14            5      x 11.5   in}
    iDMPAPER_CSHEET                  : begin PaperWidthInches  := 17;              PaperHeightInches := 22;              end; //24 = {C size sheet            17     x 22     in}
    iDMPAPER_DSHEET                  : begin PaperWidthInches  := 22;              PaperHeightInches := 34;              end; //25 = {D size sheet            22     x 34     in}
    iDMPAPER_ESHEET                  : begin PaperWidthInches  := 34;              PaperHeightInches := 44;              end; //26 = {E size sheet            34     x 44     in}
    iDMPAPER_ENV_DL                  : begin PaperWidthInches  := MMToInches(110); PaperHeightInches := MMToInches(220); end; //27 = {Envelope DL             110    x 220    mm}
    iDMPAPER_ENV_C5                  : begin PaperWidthInches  := MMToInches(162); PaperHeightInches := MMToInches(229); end; //28 = {Envelope C5             162    x 229    mm}
    iDMPAPER_ENV_C3                  : begin PaperWidthInches  := MMToInches(324); PaperHeightInches := MMToInches(458); end; //29 = {Envelope C3             324    x 458    mm}
    iDMPAPER_ENV_C4                  : begin PaperWidthInches  := MMToInches(229); PaperHeightInches := MMToInches(324); end; //30 = {Envelope C4             229    x 324    mm}
    iDMPAPER_ENV_C6                  : begin PaperWidthInches  := MMToInches(114); PaperHeightInches := MMToInches(162); end; //31 = {Envelope C6             114    x 162    mm}
    iDMPAPER_ENV_C65                 : begin PaperWidthInches  := MMToInches(114); PaperHeightInches := MMToInches(229); end; //32 = {Envelope C65            114    x 229    mm}
    iDMPAPER_ENV_B4                  : begin PaperWidthInches  := MMToInches(250); PaperHeightInches := MMToInches(353); end; //33 = {Envelope B4             250    x 353    mm}
    iDMPAPER_ENV_B5                  : begin PaperWidthInches  := MMToInches(176); PaperHeightInches := MMToInches(250); end; //34 = {Envelope B5             176    x 250    mm}
    iDMPAPER_ENV_B6                  : begin PaperWidthInches  := MMToInches(176); PaperHeightInches := MMToInches(125); end; //35 = {Envelope B6             176    x 125    mm}
    iDMPAPER_ENV_ITALY               : begin PaperWidthInches  := MMToInches(110); PaperHeightInches := MMToInches(230); end; //36 = {Envelope                110    x 230    mm}
    iDMPAPER_ENV_MONARCH             : begin PaperWidthInches  := 3.875;           PaperHeightInches := 7.5;             end; //37 = {Envelope Monarch        3.875  x 7.5    in}
    iDMPAPER_ENV_PERSONAL            : begin PaperWidthInches  := 3.625;           PaperHeightInches := 6.5;             end; //38 = {6 34 Envelope           3.625  x 6.5    in}
    iDMPAPER_FANFOLD_US              : begin PaperWidthInches  := 14.875;          PaperHeightInches := 11;              end; //39 = {US Std Fanfold          14.875 x 11     in}
    iDMPAPER_FANFOLD_STD_GERMAN      : begin PaperWidthInches  := 8.5;             PaperHeightInches := 12;              end; //40 = {German Std Fanfold      8.5    x 12     in}
    iDMPAPER_FANFOLD_LGL_GERMAN      : begin PaperWidthInches  := 8.5;             PaperHeightInches := 13;              end; //41 = {German Legal Fanfold    8.5    x 13     in}
    iDMPAPER_ISO_B4                  : begin PaperWidthInches  := MMToInches(250); PaperHeightInches := MMToInches(353); end; //42 = {B4 (ISO)                250    x 353    mm}
    iDMPAPER_JAPANESE_POSTCARD       : begin PaperWidthInches  := MMToInches(100); PaperHeightInches := MMToInches(148); end; //43 = {Japanese Postcard       100    x 148    mm}
    iDMPAPER_9X11                    : begin PaperWidthInches  := 9;               PaperHeightInches := 11;              end; //44 = {                        9      x 11     in}
    iDMPAPER_10X11                   : begin PaperWidthInches  := 10;              PaperHeightInches := 11;              end; //45 = {                        10     x 11     in}
    iDMPAPER_15X11                   : begin PaperWidthInches  := 15;              PaperHeightInches := 11;              end; //46 = {                        15     x 11     in}
    iDMPAPER_ENV_INVITE              : begin PaperWidthInches  := MMToInches(220); PaperHeightInches := MMToInches(220); end; //47 = {Envelope Invite         220    x 220    mm}
    iDMPAPER_LETTER_EXTRA            : begin PaperWidthInches  := 9.5;             PaperHeightInches := 12;              end; //50 = {Letter Extra            9.5    x 12     in}
    iDMPAPER_LEGAL_EXTRA             : begin PaperWidthInches  := 9.5;             PaperHeightInches := 15;              end; //51 = {Legal Extra             9.5    x 15     in}
    iDMPAPER_TABLOID_EXTRA           : begin PaperWidthInches  := 11.69;           PaperHeightInches := 18;              end; //52 = {Tabloid Extra           11.69  x 18     in}
    iDMPAPER_A4_EXTRA                : begin PaperWidthInches  := 9.27;            PaperHeightInches := 12.69;           end; //53 = {A4 Extra                9.27   x 12.69  in}
    iDMPAPER_LETTER_TRANSVERSE       : begin PaperWidthInches  := 8.5;             PaperHeightInches := 11;              end; //54 = {Letter Transverse       8.5    x 11     in}
    iDMPAPER_A4_TRANSVERSE           : begin PaperWidthInches  := MMToInches(210); PaperHeightInches := MMToInches(297); end; //55 = {A4 Transverse           210    x 297    mm}
    iDMPAPER_LETTER_EXTRA_TRANSVERSE : begin PaperWidthInches  := 9.5;             PaperHeightInches := 12;              end; //56 = {Letter Extra Transverse 9.5    x 12     in}
    iDMPAPER_A_PLUS                  : begin PaperWidthInches  := MMToInches(227); PaperHeightInches := MMToInches(356); end; //57 = {SuperASuperAA4          227    x 356    mm}
    iDMPAPER_B_PLUS                  : begin PaperWidthInches  := MMToInches(305); PaperHeightInches := MMToInches(487); end; //58 = {SuperBSuperBA3          305    x 487    mm}
    iDMPAPER_LETTER_PLUS             : begin PaperWidthInches  := 8.5;             PaperHeightInches := 12.69;           end; //59 = {Letter Plus             8.5    x 12.69  in}
    iDMPAPER_A4_PLUS                 : begin PaperWidthInches  := MMToInches(210); PaperHeightInches := MMToInches(330); end; //60 = {A4 Plus                 210    x 330    mm}
    iDMPAPER_A5_TRANSVERSE           : begin PaperWidthInches  := MMToInches(148); PaperHeightInches := MMToInches(210); end; //61 = {A5 Transverse           148    x 210    mm}
    iDMPAPER_B5_TRANSVERSE           : begin PaperWidthInches  := MMToInches(182); PaperHeightInches := MMToInches(257); end; //62 = {B5 (JIS) Transverse     182    x 257    mm}
    iDMPAPER_A3_EXTRA                : begin PaperWidthInches  := MMToInches(322); PaperHeightInches := MMToInches(445); end; //63 = {A3 Extra                322    x 445    mm}
    iDMPAPER_A5_EXTRA                : begin PaperWidthInches  := MMToInches(174); PaperHeightInches := MMToInches(235); end; //64 = {A5 Extra                174    x 235    mm}
    iDMPAPER_B5_EXTRA                : begin PaperWidthInches  := MMToInches(201); PaperHeightInches := MMToInches(276); end; //65 = {B5 (ISO) Extra          201    x 276    mm}
    iDMPAPER_A2                      : begin PaperWidthInches  := MMToInches(420); PaperHeightInches := MMToInches(594); end; //66 = {A2                      420    x 594    mm}
    iDMPAPER_A3_TRANSVERSE           : begin PaperWidthInches  := MMToInches(297); PaperHeightInches := MMToInches(420); end; //67 = {A3 Transverse           297    x 420    mm}
    iDMPAPER_A3_EXTRA_TRANSVERSE     : begin PaperWidthInches  := MMToInches(322); PaperHeightInches := MMToInches(445); end; //68 = {A3 Extra Transverse     322    x 445    mm}
    else                               begin PaperWidthInches  := 8.5;             PaperHeightInches := 11;              end;
  end;
end;
//****************************************************************************************************************************************************
procedure GetPrinterPaperSize(var PaperWidthInches, PaperHeightInches: Double);
var
  {$ifdef iVCL}
  ADevice           : array[0..255] of Char;
  ADriver           : array[0..255] of Char;
  APort             : array[0..255] of Char;
  DeviceHandle      : THandle;
  DevMode           : PDeviceMode;
  {$endif}
  TempDouble        : Double;
begin
  {$ifdef iVCL}
  Printer.GetPrinter(ADevice, ADriver, APort, DeviceHandle);
  if DeviceHandle = 0 then
    begin
      Printer.PrinterIndex := Printer.PrinterIndex;
      Printer.GetPrinter(ADevice, ADriver, APort, DeviceHandle);
    end;
  if DeviceHandle = 0 then raise Exception.Create('Could not initialize printer DeviceMode Structure');

  DevMode := GlobalLock(DeviceHandle);
  try
    GetPaperTypePaperSize(DevMode^.dmPaperSize, PaperWidthInches, PaperHeightInches);
  finally
    GlobalUnlock(DeviceHandle);
  end;
  {$endif}

  {$ifdef iCLX}
  case Printer.PrintAdapter.PageSize of
    psLetter : begin PaperWidthInches  :=  8.5;            PaperHeightInches := 11.0;            end;
    psLegal  : begin PaperWidthInches  :=  8.5;            PaperHeightInches := 14.0;            end;
    psA3     : begin PaperWidthInches  := MMToInches(297); PaperHeightInches := MMToInches(420); end;
    psA4     : begin PaperWidthInches  := MMToInches(210); PaperHeightInches := MMToInches(297); end;
    psA5     : begin PaperWidthInches  := MMToInches(148); PaperHeightInches := MMToInches(210); end;
    else       begin PaperWidthInches  := 8.5;             PaperHeightInches := 11.0;            end;
  end;
  {$endif}

  if Printer.Orientation = poLandscape then
    begin
      TempDouble        := PaperWidthInches;
      PaperWidthInches  := PaperHeightInches;
      PaperHeightInches := TempDouble;
    end;
end;
//****************************************************************************************************************************************************
function GetAngleNormalized(Value: Double):Double;
begin
  if Value >= 360 then
    begin
      Result := Value - (Trunc(Value) div 360)*360;
    end
  else if Value < 0 then
    begin
      Result := Value + (Abs(Trunc(Value)) div 360)*360 + 360;
    end
  else Result := Value;
end;
//****************************************************************************************************************************************************
end.
