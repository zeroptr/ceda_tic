{*******************************************************}
{                                                       }
{       TiAngularLogGauge Component                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iAngularLogGauge;{$endif}
{$ifdef iCLX}unit QiAngularLogGauge;{$endif}

interface                                            

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes, iGPFunctions,   iMath,  iGaugeComponent,  iGaugePointer;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiGaugeComponent, QiGaugePointer;{$ENDIF}

type
  TiAngularLogGauge = class(TiGaugeComponent)
  private
    FArcRangeDegrees       : Integer;
    FArcRadius             : Integer;
    FArcStartDegrees       : Integer;
    FPointerStyle          : TiAngularGaugePointerStyle;
    FShowInnerArcRadius    : Boolean;
    FPointerSize           : Integer;

    FShowHub               : Boolean;
    FHubSize               : Integer;
    FHub3D                 : Boolean;
    FHubColor              : TColor;

    FShowFace              : Boolean;
    FFaceColor             : TColor;
    FFaceStyle             : TiDrawEdgeStyle;
    FFaceBevelSize         : Integer;
    FFaceBevelStyle        : TiDrawEdgeStyle;

    FShowOuterArcRadius    : Boolean;
    FMinMaxPointerStyle    : TiAngularGaugePointerStyle;
    FShowLabel2            : Boolean;
    FShowLabel1            : Boolean;
    FLabel1OffsetX         : Integer;
    FLabel2OffsetY         : Integer;
    FLabel1OffsetY         : Integer;
    FLabel2OffsetX         : Integer;
    FLabel2Text            : String;
    FLabel1Text            : String;
    FLabel1Font            : TFont;
    FLabel2Font            : TFont;
    FLabel1AlignHorizontal : TiAlignmentHorizontal;
    FLabel2AlignHorizontal : TiAlignmentHorizontal;
    FLabel1AlignVertical   : TiAlignmentVertical;
    FLabel2AlignVertical   : TiAlignmentVertical;
    FTickLabelStyle        : TiLogLabelStyle;
    FTickLabelAlignment    : TiLabelAlignment;
    FAutoSize              : Boolean;
    FAutoCenter            : Boolean;
    FOuterMargin           : Integer;
    FReverseScale          : Boolean;

    FMouseDownX            : Integer;
    FMouseDownY            : Integer;
    FMouseDownDegrees      : Double;
    FOldCurrentValue       : Double;
    FCenterPoint           : TPoint;

    FMinPointer           : TiGaugePointer;
    FMaxPointer           : TiGaugePointer;

    procedure SetArcRadius            (const Value: Integer);
    procedure SetArcRangeDegrees      (const Value: Integer);
    procedure SetArcStartDegrees      (const Value: Integer);
    procedure SetPointerMargin        (const Value: Integer);
    procedure SetPointerStyle         (const Value: TiAngularGaugePointerStyle);
    procedure SetMinMaxPointerStyle   (const Value: TiAngularGaugePointerStyle);
    procedure SetShowInnerArcRadius   (const Value: Boolean);
    procedure SetPointerColor         (const Value: TColor);
    procedure SetPointerSize          (const Value: Integer);
    procedure SetShowHub              (const Value: Boolean);
    procedure SetHubSize              (const Value: Integer);
    procedure SetHubColor             (const Value: TColor);
    procedure SetHub3D                (const Value: Boolean);
    procedure SetShowFace             (const Value: Boolean);
    procedure SetFaceColor            (const Value: TColor);
    procedure SetFaceStyle            (const Value: TiDrawEdgeStyle);
    procedure SetFaceBevelSize        (const Value: Integer);
    procedure SetFaceBevelStyle       (const Value: TiDrawEdgeStyle);
    procedure SetShowOuterArcRadius   (const Value: Boolean);
    procedure SetLabel1Text           (const Value: String);
    procedure SetLabel1AlignHorizontal(const Value: TiAlignmentHorizontal);
    procedure SetLabel1AlignVertical  (const Value: TiAlignmentVertical);
    procedure SetLabel1OffsetX        (const Value: Integer);
    procedure SetLabel1OffsetY        (const Value: Integer);
    procedure SetLabel1Font           (const Value: TFont);
    procedure SetLabel2Text           (const Value: String);
    procedure SetLabel2AlignHorizontal(const Value: TiAlignmentHorizontal);
    procedure SetLabel2AlignVertical  (const Value: TiAlignmentVertical);
    procedure SetLabel2OffsetX        (const Value: Integer);
    procedure SetLabel2OffsetY        (const Value: Integer);
    procedure SetLabel2Font           (const Value: TFont);
    procedure SetShowLabel1           (const Value: Boolean);
    procedure SetShowLabel2           (const Value: Boolean);
    procedure SetTickLabelStyle       (const Value: TiLogLabelStyle);
    procedure SetReverseScale         (const Value: Boolean);
    procedure iSetAutoSize            (const Value: Boolean);
    procedure SetAutoCenter           (const Value: Boolean);
    procedure SetOuterMargin          (const Value: Integer);

    function GetPointerColor : TColor;
    function GetPointerMargin: Integer;
    function GetPointerSize  : Integer;
    function GetPointerStyle : TiAngularGaugePointerStyle;
  protected
    function  GetLabelValue(Index: Integer): Double;
    function  GetLabelText(Index: Integer; Position: Double): String;
    function  GetLabelRect(Canvas: TCanvas; Index: Integer; Position: Double; Origin: TPoint): TRect;
    function  GetCenterPoint(Canvas: TCanvas): TPoint; override;

    procedure SetPositionMin(const Value : Double);    override;
    procedure DrawTicks    (Canvas: TCanvas; const OffsetPoint: TPoint);
    procedure DrawSections (Canvas: TCanvas; const OffsetPoint: TPoint);
    procedure DrawArcRadius(Canvas: TCanvas; const OffsetPoint: TPoint);
    procedure DrawIndicator(Canvas: TCanvas; const OffsetPoint: TPoint; APointer: TiGaugePointer);
    procedure DrawHub      (Canvas: TCanvas; const OffsetPoint: TPoint);
    procedure DrawFace     (Canvas: TCanvas; const OffsetPoint: TPoint);
    procedure DrawMinMax   (Canvas: TCanvas; const OffsetPoint: TPoint);
    procedure DrawLimits   (Canvas: TCanvas; const OffsetPoint: TPoint);
    procedure DrawLabels   (Canvas: TCanvas; const CenterPoint: TPoint);

    procedure iPaintTo(Canvas: TCanvas);                                           override;

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    procedure InitializePointer(iGaugePointer : TiGaugePointer);                   override;

    function  PositionToDegrees(Value: Double): Double;

    procedure AdjustArcRadius(Canvas:TCanvas);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    function GetPointersMargin(Index: Integer): Integer;
    function GetPointersStyle (Index: Integer): TiAngularGaugePointerStyle;

    procedure SetPointersMargin(Index: Integer; Value: Integer);
    procedure SetPointersStyle(Index: Integer; Value: TiAngularGaugePointerStyle);
  published
    property ArcRadius             : Integer                    read FArcRadius             write SetArcRadius             default 60;
    property ArcRangeDegrees       : Integer                    read FArcRangeDegrees       write SetArcRangeDegrees       default 90;
    property ArcStartDegrees       : Integer                    read FArcStartDegrees       write SetArcStartDegrees       default 180;

    property ShowLabel1            : Boolean                    read FShowLabel1            write SetShowLabel1            default False;
    property Label1Text            : String                     read FLabel1Text            write SetLabel1Text;
    property Label1Font            : TFont                      read FLabel1Font            write SetLabel1Font;
    property Label1AlignVertical   : TiAlignmentVertical        read FLabel1AlignVertical   write SetLabel1AlignVertical   default iavCenter;
    property Label1AlignHorizontal : TiAlignmentHorizontal      read FLabel1AlignHorizontal write SetLabel1AlignHorizontal default iahCenter;
    property Label1OffsetX         : Integer                    read FLabel1OffsetX         write SetLabel1OffsetX         default -15;
    property Label1OffsetY         : Integer                    read FLabel1OffsetY         write SetLabel1OffsetY         default -35;

    property ShowLabel2            : Boolean                    read FShowLabel2            write SetShowLabel2            default False;
    property Label2Text            : String                     read FLabel2Text            write SetLabel2Text;
    property Label2Font            : TFont                      read FLabel2Font            write SetLabel2Font;
    property Label2AlignVertical   : TiAlignmentVertical        read FLabel2AlignVertical   write SetLabel2AlignVertical   default iavCenter;
    property Label2AlignHorizontal : TiAlignmentHorizontal      read FLabel2AlignHorizontal write SetLabel2AlignHorizontal default iahCenter;
    property Label2OffsetX         : Integer                    read FLabel2OffsetX         write SetLabel2OffsetX         default -15;
    property Label2OffsetY         : Integer                    read FLabel2OffsetY         write SetLabel2OffsetY         default -25;

    property ShowHub               : Boolean                    read FShowHub               write SetShowHub               default True;
    property HubSize               : Integer                    read FHubSize               write SetHubSize               default 14;
    property HubColor              : TColor                     read FHubColor              write SetHubColor              default clBlack;
    property Hub3D                 : Boolean                    read FHub3D                 write SetHub3D                 default False;

    property ShowFace              : Boolean                    read FShowFace              write SetShowFace              default False;
    property FaceColor             : TColor                     read FFaceColor             write SetFaceColor             default clWhite;
    property FaceStyle             : TiDrawEdgeStyle            read FFaceStyle             write SetFaceStyle             default idesFlat;
    property FaceBevelSize         : Integer                    read FFaceBevelSize         write SetFaceBevelSize         default 5;
    property FaceBevelStyle        : TiDrawEdgeStyle            read FFaceBevelStyle        write SetFaceBevelStyle        default idesSunken;

    property MinMaxPointerStyle    : TiAngularGaugePointerStyle read FMinMaxPointerStyle    write SetMinMaxPointerStyle    default iagpsArrowLine;

    property PointerMargin         : Integer                    read GetPointerMargin       write SetPointerMargin         default 0;
    property PointerColor          : TColor                     read GetPointerColor        write SetPointerColor          default clBlack;
    property PointerSize           : Integer                    read GetPointerSize         write SetPointerSize           default 10;
    property PointerStyle          : TiAngularGaugePointerStyle read GetPointerStyle        write SetPointerStyle          default iagpsTriangle;

    property ShowInnerArcRadius    : Boolean                    read FShowInnerArcRadius    write SetShowInnerArcRadius    default False;
    property ShowOuterArcRadius    : Boolean                    read FShowOuterArcRadius    write SetShowOuterArcRadius    default False;
    property TickLabelStyle        : TiLogLabelStyle            read FTickLabelStyle        write SetTickLabelStyle        default illsValue;

    property AutoSize              : Boolean                    read FAutoSize              write iSetAutoSize             default False;
    property AutoCenter            : Boolean                    read FAutoCenter            write SetAutoCenter            default True;
    property OuterMargin           : Integer                    read FOuterMargin           write SetOuterMargin           default 5;

    property ReverseScale          : Boolean                    read FReverseScale          write SetReverseScale          default False;

    property OffsetX;
    property OffsetY;
    property BackGroundColor;
    property BorderStyle;
    property BackGroundPicture;
    property CachedDrawing;
    property Transparent;
    property ShowDisabledState;

    property TickMajorColor;
    property TickMajorLength;
    property TickMinorAlignment;
    property TickMinorColor;
    property TickMinorLength;
    property TickMargin;
    property TickLabelMargin       default 15;
    property TickLabelFont;
    property TickLabelPrecision;
    property OnCustomizeTickLabel;

    property SectionColor1;
    property SectionColor2;
    property SectionColor3;
    property SectionColor4;
    property SectionColor5;
    property SectionCount;
    property SectionEnd1;
    property SectionEnd2;
    property SectionEnd3;
    property SectionEnd4;

    property ShowMaxPointer;
    property ShowMinPointer;
    property MinMaxPointerSize;
    property MinMaxPointerMargin;
    property MaxPointerColor;
    property MinPointerColor;
    property MinMaxUserCanMove;
  end;

implementation

type
  TiGaugePointerAccess = class(TiGaugePointer)end;
//****************************************************************************************************************************************************
constructor TiAngularLogGauge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width              := 150;
  Height             := 150;
  TickLabelMargin    := 15;
  PositionMin        := 1;

  FArcRadius         := 60;
  FArcRangeDegrees   := 90;
  FArcStartDegrees   := 180;

  FShowHub           := True;
  FHub3D             := False;
  FShowFace          := False;
  FHubSize           := 14;
  FFaceColor         := clWhite;
  FFaceStyle         := idesFlat;
  FFaceBevelSize     := 5;
  FFaceBevelStyle    := idesSunken;

  FPointerSize       := 10;
  FPointerStyle      := iagpsTriangle;

  FLabel1OffsetX     := -15;
  FLabel1OffsetY     := -35;

  FLabel2OffsetX     := -15;
  FLabel2OffsetY     := -20;

  FOuterMargin       := 5;

  FAutoCenter        := True;

  FLabel1Font        := TFont.Create; FLabel1Font.OnChange := BackGroundChangeEvent;
  FLabel2Font        := TFont.Create; FLabel2Font.OnChange := BackGroundChangeEvent;

  FMinPointer        := TiGaugePointer.Create(nil);
  FMaxPointer        := TiGaugePointer.Create(nil);

  PointerColor         := clBlack;


  CreateBackGroundPicture;
end;
//****************************************************************************************************************************************************
destructor TiAngularLogGauge.Destroy;
begin
  FMinPointer.Free;
  FMaxPointer.Free;
  FLabel1Font.Free;
  FLabel2Font.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetArcRadius         (const Value:Integer);begin SetIntegerProperty(Value,FArcRadius,         irtBackGround);end;
procedure TiAngularLogGauge.SetArcStartDegrees   (const Value:Integer);begin SetIntegerProperty(Value,FArcStartDegrees,   irtBackGround);end;
procedure TiAngularLogGauge.SetShowInnerArcRadius(const Value:Boolean);begin SetBooleanProperty(Value,FShowInnerArcRadius,irtBackGround);end;
procedure TiAngularLogGauge.SetShowOuterArcRadius(const Value:Boolean);begin SetBooleanProperty(Value,FShowOuterArcRadius,irtBackGround);end;
procedure TiAngularLogGauge.SetHubSize           (const Value:Integer);begin SetIntegerProperty(Value,FHubSize,           irtBackGround);end;
procedure TiAngularLogGauge.SetHubColor          (const Value:TColor); begin SetColorProperty  (Value,FHubColor,          irtBackGround);end;
procedure TiAngularLogGauge.SetHub3D             (const Value:Boolean);begin SetBooleanProperty(Value,FHub3D,             irtBackGround);end;
procedure TiAngularLogGauge.SetFaceColor         (const Value:TColor );begin SetColorProperty  (Value,FFaceColor,         irtBackGround);end;
procedure TiAngularLogGauge.SetFaceBevelSize     (const Value:Integer);begin SetIntegerProperty(Value,FFaceBevelSize,     irtBackGround);end;
procedure TiAngularLogGauge.SetShowHub           (const Value:Boolean);begin SetBooleanProperty(Value,FShowHub,           irtBackGround);end;
procedure TiAngularLogGauge.SetShowFace          (const Value:Boolean);begin SetBooleanProperty(Value,FShowFace,          irtBackGround);end;
procedure TiAngularLogGauge.SetShowLabel1        (const Value:Boolean);begin SetBooleanProperty(Value,FShowLabel1,        irtBackGround);end;
procedure TiAngularLogGauge.SetShowLabel2        (const Value:Boolean);begin SetBooleanProperty(Value,FShowLabel2,        irtBackGround);end;
procedure TiAngularLogGauge.SetLabel1Text        (const Value:String); begin SetStringProperty (Value,FLabel1Text,        irtBackGround);end;
procedure TiAngularLogGauge.SetLabel1OffsetX     (const Value:Integer);begin SetIntegerProperty(Value,FLabel1OffsetX,     irtBackGround);end;
procedure TiAngularLogGauge.SetLabel1OffsetY     (const Value:Integer);begin SetIntegerProperty(Value,FLabel1OffsetY,     irtBackGround);end;
procedure TiAngularLogGauge.SetLabel2Text        (const Value:String); begin SetStringProperty (Value,FLabel2Text,        irtBackGround);end;
procedure TiAngularLogGauge.SetLabel2OffsetX     (const Value:Integer);begin SetIntegerProperty(Value,FLabel2OffsetX,     irtBackGround);end;
procedure TiAngularLogGauge.SetLabel2OffsetY     (const Value:Integer);begin SetIntegerProperty(Value,FLabel2OffsetY,     irtBackGround);end;
procedure TiAngularLogGauge.iSetAutoSize         (const Value:Boolean);begin SetBooleanProperty(Value,FAutoSize,          irtBackGround);end;
procedure TiAngularLogGauge.SetAutoCenter        (const Value:Boolean);begin SetBooleanProperty(Value,FAutoCenter,        irtBackGround);end;
procedure TiAngularLogGauge.SetOuterMargin       (const Value:Integer);begin SetIntegerProperty(Value,FOuterMargin,       irtBackGround);end;
procedure TiAngularLogGauge.SetReverseScale      (const Value:Boolean);begin SetBooleanProperty(Value,FReverseScale,      irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetLabel1Font       (const Value:TFont);  begin FLabel1Font.Assign(Value);       end;
procedure TiAngularLogGauge.SetLabel2Font       (const Value:TFont);  begin FLabel2Font.Assign(Value);       end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetFaceStyle(const Value: TiDrawEdgeStyle);
begin
  if FFaceStyle <> Value then
    begin
      FFaceStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetFaceBevelStyle(const Value: TiDrawEdgeStyle);
begin
  if FFaceBevelStyle <> Value then
    begin
      FFaceBevelStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetMinMaxPointerStyle(const Value: TiAngularGaugePointerStyle);
begin
  if FMinMaxPointerStyle <> Value then
    begin
      FMinMaxPointerStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetLabel1AlignHorizontal(const Value: TiAlignmentHorizontal);
begin
  if FLabel1AlignHorizontal <> Value then
    begin
      FLabel1AlignHorizontal := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetLabel1AlignVertical(const Value: TiAlignmentVertical);
begin
  if FLabel1AlignVertical <> Value then
    begin
      FLabel1AlignVertical := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetLabel2AlignHorizontal(const Value: TiAlignmentHorizontal);
begin
  if FLabel2AlignHorizontal <> Value then
    begin
      FLabel2AlignHorizontal := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetLabel2AlignVertical(const Value: TiAlignmentVertical);
begin
  if FLabel2AlignVertical <> Value then
    begin
      FLabel2AlignVertical := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetTickLabelStyle(const Value: TiLogLabelStyle);
begin
  if FTickLabelStyle <> Value then
    begin
      FTickLabelStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetArcRangeDegrees(const Value: Integer);
begin
  if FArcRangeDegrees <> Value then
    begin
      FArcRangeDegrees := Value;
      if FArcRangeDegrees > 360 then FArcRangeDegrees := 360;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
function TiAngularLogGauge.GetLabelValue(Index: Integer): Double;
var
  ActualMin : Double;
  ActualMax : Double;
begin
  if AutoScaleEnabled and (AutoScaleStyle = iassFixedMinMax) then
    begin
      ActualMin := FAutoScaleMinTick;
      ActualMax := FAutoScaleMaxTick;
    end
  else
    begin
      ActualMin := PositionMin;
      ActualMax := PositionMax;
    end;

  Result := (ActualMax - ActualMin)/(TickMajorCount-1)*Index + ActualMin;
end;
//****************************************************************************************************************************************************
function TiAngularLogGauge.GetLabelText(Index: Integer; Position: Double): String;
begin
  case FTickLabelStyle of
    illsValue      : Result  := Trim(SysUtils.Format('%.' + IntToStr(TickLabelPrecision  ) + 'f', [Position]));
    illsScientific : Result  := Trim(SysUtils.Format('%.' + IntToStr(TickLabelPrecision+1) + 'e', [Position]));
  end;

  if Assigned(OnCustomizeTickLabel) then TOnCustomizeTickLabel(OnCustomizeTickLabel)(Self, Index, Result);
end;
//****************************************************************************************************************************************************
function TiAngularLogGauge.GetLabelRect(Canvas: TCanvas; Index: Integer; Position: Double; Origin: TPoint): TRect;
var
  LabelRadius : Integer;
  TextPoint   : TPoint;
  AText       : String;
  Degrees     : Double;
begin
  AText   := GetLabelText(Index, Position);
  Degrees := PositionToDegrees(Position);                                             
  with Canvas do
    begin
      Font.Assign(TickLabelFont);
      LabelRadius := FArcRadius + TickMargin + TickMajorLength + TickLabelMargin + 4;
      TextPoint   := GetXYRadPoint(Degrees, LabelRadius, Origin);

      case FTickLabelAlignment of
        ilaCenter    :   Result := Rect(TextPoint.X - TextWidth (AText) div 2, TextPoint.Y - TextHeight(AText) div 2,
                                        TextPoint.X + TextWidth (AText) div 2, TextPoint.Y + TextHeight(AText) div 2);
        ilaJustified : if (Degrees = 0) then
                         Result := Rect(TextPoint.X,                   TextPoint.Y - TextHeight(AText) div 2,
                                        TextPoint.X + TextWidth(AText),TextPoint.Y + TextHeight(AText) div 2)
                       else if (Degrees > 0) and (Degrees < 90) then
                         Result := Rect(TextPoint.X,                   TextPoint.Y - TextHeight(AText),
                                        TextPoint.X + TextWidth(AText),TextPoint.Y)
                       else if (Degrees = 90) then
                         Result := Rect(TextPoint.X - TextWidth(AText) div 2, TextPoint.Y - TextHeight(AText),
                                        TextPoint.X + TextWidth(AText) div 2, TextPoint.Y)
                       else if (Degrees > 90) and (Degrees < 180) then
                         Result := Rect(TextPoint.X - TextWidth(AText), TextPoint.Y - TextHeight(AText),
                                        TextPoint.X,                    TextPoint.Y)
                       else if (Degrees = 180) then
                         Result := Rect(TextPoint.X - TextWidth(AText), TextPoint.Y - TextHeight(AText) div 2,
                                        TextPoint.X,                    TextPoint.Y + TextHeight(AText) div 2)
                       else if (Degrees > 180) and (Degrees < 270) then
                         Result := Rect(TextPoint.X - TextWidth(AText), TextPoint.Y,
                                        TextPoint.X,                     TextPoint.Y + TextHeight(AText))
                       else if (Degrees = 270) then
                         Result := Rect(TextPoint.X - TextWidth(AText) div 2, TextPoint.Y,
                                        TextPoint.X + TextWidth(AText) div 2, TextPoint.Y + TextHeight(AText) div 2)
                       else if (Degrees > 270) and (Degrees < 360) then
                         Result := Rect(TextPoint.X,                    TextPoint.Y,
                                        TextPoint.X + TextWidth(AText), TextPoint.Y + TextHeight(AText));
      end;
    end;
end;
//****************************************************************************************************************************************************
function TiAngularLogGauge.GetCenterPoint(Canvas: TCanvas): TPoint;
var
  x               : Integer;
  ARect           : TRect;
  MaxLeft         : Integer;
  MaxRight        : Integer;
  MaxTop          : Integer;
  MaxBottom       : Integer;

  SpaceLeft       : Integer;
  SpaceRight      : Integer;
  SpaceTop        : Integer;
  SpaceBottom     : Integer;
  CurrentPosition : Double;
  ARadius         : Integer;
  APoint          : TPoint;
  MajorCount      : Integer;
begin
  Result := inherited GetCenterPoint(Canvas);
  if (FAutoCenter or FAutoSize) and (not FShowFace) then
    with Canvas do
      begin
        Font.Assign(TickLabelFont);

        MaxLeft   := Result.x;
        MaxRight  := Result.x;
        MaxTop    := Result.y;
        MaxBottom := Result.y;

        ARect := Rect(Result.x - FHubSize div 2, Result.y - FHubSize div 2,
                      Result.x + FHubSize div 2, Result.y + FHubSize div 2);

        if ARect.Left   < MaxLeft   then MaxLeft   := ARect.Left;
        if ARect.Right  > MaxRight  then MaxRight  := ARect.Right;
        if ARect.Top    < MaxTop    then MaxTop    := ARect.Top;
        if ARect.Bottom > MaxBottom then MaxBottom := ARect.Bottom;

        CurrentPosition := PositionMin;
        while CurrentPosition < PositionMax do
          begin
            ARadius := FArcRadius + TickMargin + TickMinorLength;
            APoint  := GetXYRadPoint(PositionToDegrees(CurrentPosition), ARadius, Result);

            if APoint.X < MaxLeft   then MaxLeft   := APoint.X;
            if APoint.X > MaxRight  then MaxRight  := APoint.X;
            if APoint.Y < MaxTop    then MaxTop    := APoint.Y;
            if APoint.Y > MaxBottom then MaxBottom := APoint.Y;

            CurrentPosition := CurrentPosition  *10;
          end;

        MajorCount := Trunc(Log10(PositionMax) - Log10(PositionMin));

        for x := 0 to MajorCount do
          begin
            ARect := GetLabelRect(Canvas, x, PositionMin * Power(10, x), Result);

            if ARect.Left   < MaxLeft   then MaxLeft   := ARect.Left;
            if ARect.Right  > MaxRight  then MaxRight  := ARect.Right;
            if ARect.Top    < MaxTop    then MaxTop    := ARect.Top;
            if ARect.Bottom > MaxBottom then MaxBottom := ARect.Bottom;
          end;

        SpaceLeft   := MaxLeft;
        SpaceTop    := MaxTop;
        SpaceRight  := Width  - MaxRight;
        SpaceBottom := Height - MaxBottom;

        Result.x := Result.x - (SpaceLeft - SpaceRight ) div 2;
        Result.y := Result.y - (SpaceTop  - SpaceBottom) div 2;

        Result.x := Result.x + OffsetX;
        Result.y := Result.y - OffsetY;
    end;
  FCenterPoint := Result;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.AdjustArcRadius(Canvas:TCanvas);
var
  x           : Integer;
  ARect       : TRect;

  MaxLeft     : Integer;
  MaxRight    : Integer;
  MaxTop      : Integer;
  MaxBottom   : Integer;
  MaxWidth    : Integer;

  SpaceHorz   : Integer;
  SpaceVert   : Integer;
  SpaceMin    : Integer;

  SpaceLeft   : Integer;
  SpaceRight  : Integer;
  SpaceTop    : Integer;
  SpaceBottom : Integer;
begin
  FArcRadius := 0;
  with Canvas do
    begin
      Font.Assign(TickLabelFont);

      MaxLeft   := 0;
      MaxRight  := 0;
      MaxTop    := 0;
      MaxBottom := 0;
      MaxWidth  := 0;

      for x := 0 to TickMajorCount - 1 do
        begin
          ARect := GetLabelRect(Canvas, x, PositionMin * Power(10, x), Point(0, 0));

          if (ARect.Right - ARect.Left) > MaxWidth then MaxWidth := (ARect.Right - ARect.Left);

          if ARect.Left   < MaxLeft   then MaxLeft   := ARect.Left;
          if ARect.Right  > MaxRight  then MaxRight  := ARect.Right;

          if ARect.Top    < MaxTop    then MaxTop    := ARect.Top;
          if ARect.Bottom > MaxBottom then MaxBottom := ARect.Bottom;
        end;

      SpaceLeft   := MaxLeft;
      SpaceTop    := MaxTop;
      SpaceRight  := Width  - MaxRight;
      SpaceBottom := Height - MaxBottom;

      SpaceHorz  := SpaceLeft + SpaceRight;
      SpaceVert  := SpaceBottom + SpaceTop;

      if SpaceHorz > SpaceVert then SpaceMin := SpaceVert
        else                        SpaceMin := SpaceHorz;
  end;

  if   FShowFace then
    begin
      if Width < Height then FArcRadius := Width  div 2 - MaxWidth - TickMargin - TickMajorLength - TickLabelMargin - FOuterMargin - FFaceBevelSize
      else                   FArcRadius := Height div 2 - MaxWidth - TickMargin - TickMajorLength - TickLabelMargin - FOuterMargin - FFaceBevelSize
    end
  else if FArcRangeDegrees <= 90 then
    FArcRadius := SpaceMin - FOuterMargin - FHubSize
  else if FArcRangeDegrees <= 180 then
    FArcRadius := Round(SpaceMin/(1 +(FArcRangeDegrees-90)/90)) - FOuterMargin
  else
    FArcRadius := Round(SpaceMin /2) - FOuterMargin
end;
//****************************************************************************************************************************************************
function TiAngularLogGauge.PositionToDegrees(Value: Double): Double;
var
  OffsetAngle : Double;
begin
  OffsetAngle := FArcRangeDegrees * (Log10(Value) - Log10(PositionMin))/(Log10(PositionMax) - Log10(PositionMin));

  if FReverseScale then Result := FArcStartDegrees - FArcRangeDegrees + OffsetAngle
    else                Result := FArcStartDegrees - OffsetAngle;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.iPaintTo(Canvas: TCanvas);
var
  CenterPoint : TPoint;
  x           : Integer;
begin
  if FAutoSize then AdjustArcRadius(Canvas);
  CenterPoint := GetCenterPoint(Canvas);

  if CachedDrawing then
    begin
      if BackGroundChanged then
        begin
          CreateBackGroundBitmap;
          DrawBackGround(BackGroundBitmap.Canvas, BackGroundColor);
          DrawFace      (BackGroundBitmap.Canvas, CenterPoint);
          DrawSections  (BackGroundBitmap.Canvas, CenterPoint);
          DrawArcRadius (BackGroundBitmap.Canvas, CenterPoint);
          DrawTicks     (BackGroundBitmap.Canvas, CenterPoint);
          ResetBackGroundChange;
        end;

      TransferBackGround(Canvas);

      DrawLabels    (Canvas, CenterPoint);
      DrawMinMax    (Canvas, CenterPoint);
      DrawLimits    (Canvas, CenterPoint);

      for x := 0 to PointerManager.Count - 1 do
        begin
          if not PointerManager.Items[x].Visible then Continue;
          DrawIndicator (Canvas, CenterPoint, PointerManager.Items[x]);
        end;

      DrawHub(Canvas, CenterPoint);
    end
  else
    begin
      DrawBackGround(Canvas, BackGroundColor);
      DrawFace      (Canvas, CenterPoint);
      DrawSections  (Canvas, CenterPoint);
      DrawArcRadius (Canvas, CenterPoint);
      DrawTicks     (Canvas, CenterPoint);

      DrawLabels    (Canvas, CenterPoint);
      DrawMinMax    (Canvas, CenterPoint);
      DrawLimits    (Canvas, CenterPoint);

      for x := 0 to PointerManager.Count - 1 do
        begin
          if not PointerManager.Items[x].Visible then Continue;
          DrawIndicator (Canvas, CenterPoint, PointerManager.Items[x]);
        end;

      DrawHub(Canvas, CenterPoint);
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.DrawSections(Canvas: TCanvas; const OffsetPoint: TPoint);
var
  x              : Integer;
  LastStart      : Double;
  CurrentColor   : TColor;
  CurrentEnd     : Double;
  InnerRadius    : Integer;
  OuterRadius    : Integer;
begin
  LastStart   := PositionMin;
  InnerRadius := FArcRadius + TickMargin;
  OuterRadius := FArcRadius + TickMargin + TickMajorLength;

  for x := 1 to SectionCount do
    begin
      case x of
        1 :  begin CurrentColor := SectionColor1; CurrentEnd := SectionEnd1; end;
        2 :  begin CurrentColor := SectionColor2; CurrentEnd := SectionEnd2; end;
        3 :  begin CurrentColor := SectionColor3; CurrentEnd := SectionEnd3; end;
        4 :  begin CurrentColor := SectionColor4; CurrentEnd := SectionEnd4; end;
        else begin CurrentColor := SectionColor5; CurrentEnd := PositionMax; end;
      end;

      if CurrentEnd > PositionMax then CurrentEnd := PositionMax;
      if CurrentEnd < PositionMin then CurrentEnd := PositionMin;
      if CurrentEnd < LastStart   then CurrentEnd := PositionMax;
      if x = SectionCount         then CurrentEnd := PositionMax;

      ArcSegment(Canvas, PositionToDegrees(LastStart), PositionToDegrees(CurrentEnd), InnerRadius, OuterRadius, OffsetPoint, CurrentColor);

      LastStart := CurrentEnd;

      if CurrentEnd = FArcRangeDegrees then exit;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.DrawArcRadius(Canvas: TCanvas; const OffsetPoint: TPoint);
var
  InnerRadius    : Integer;
  OuterRadius    : Integer;
begin
  InnerRadius := FArcRadius + TickMargin;
  OuterRadius := FArcRadius + TickMargin + TickMajorLength;
  if FShowInnerArcRadius then ArcSegment(Canvas, PositionToDegrees(PositionMin), PositionToDegrees(PositionMax), InnerRadius, InnerRadius, OffsetPoint, TickMajorColor);
  if FShowOuterArcRadius then ArcSegment(Canvas, PositionToDegrees(PositionMin), PositionToDegrees(PositionMax), OuterRadius, OuterRadius, OffsetPoint, TickMajorColor);
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.DrawTicks(Canvas: TCanvas; const OffsetPoint: TPoint);
var
  MajorCount      : Integer;
  OuterPoint      : TPoint;
  InnerPoint      : TPoint;
  MajorRadius1    : Double;
  MajorRadius2    : Double;
  MinorRadius1    : Double;
  MinorRadius2    : Double;
  TextString      : String;
  x, y            : Integer;
  DegreeMinor     : Double;
  CurrentPosition : Double;
  PositionMinor   : Double;
  ActualMin       : Double;
  ActualMax       : Double;
  TextRect1       : TRect;
begin
  if PositionMax = PositionMin then exit;

  with Canvas do
    begin
      Brush.Style := bsClear;

      MajorRadius1 := FArcRadius + TickMargin;
      MajorRadius2 := FArcRadius + TickMargin + TickMajorLength;

      case TickMinorAlignment of
        itmnaInside  : begin
                         MinorRadius1 := MajorRadius1;
                         MinorRadius2 := MajorRadius1 + TickMinorLength;
                       end;
        itmnaCenter  : begin
                         MinorRadius1 := (MajorRadius1 + MajorRadius2)/2 - TickMinorLength/2;
                         MinorRadius2 := (MajorRadius1 + MajorRadius2)/2 + TickMinorLength/2;
                       end;
        else           begin
                         MinorRadius1 := MajorRadius2;
                         MinorRadius2 := MajorRadius2 - TickMinorLength;
                       end;
      end;

      if not ShowTicksMajor then MajorRadius1 := FArcRadius;

      if AutoScaleEnabled and (AutoScaleStyle = iassFixedMinMax) then
        begin
          ActualMin := FAutoScaleMinTick;
          ActualMax := FAutoScaleMaxTick;
        end
      else
        begin
          ActualMin := PositionMin;
          ActualMax := PositionMax;
        end;

      MajorCount := Trunc(Log10(ActualMax) - Log10(ActualMin));

      for x := 0 to MajorCount do
        begin
          CurrentPosition := PositionMin * Power(10, x);
          //------------------------------------------------------------------------------------------------------------------------------------------
          if ShowTicksMajor then
            begin
              if      not ShowDisabledState then Pen.Color  := TickMajorColor
              else if not Enabled then           Pen.Color  := clBtnShadow
              else                               Pen.Color  := TickMajorColor;

              OuterPoint := GetXYRadPoint(PositionToDegrees(CurrentPosition), MajorRadius1, OffsetPoint);
              InnerPoint := GetXYRadPoint(PositionToDegrees(CurrentPosition), MajorRadius2, OffsetPoint);
              Polyline([InnerPoint, OuterPoint]);
            end;
          //------------------------------------------------------------------------------------------------------------------------------------------
          if ShowTickLabels then
            begin
              Font.Assign(TickLabelFont);
              TextString := GetLabelText(x, CurrentPosition);
              TextRect1  := GetLabelRect(Canvas, x, CurrentPosition, OffsetPoint);
              if ShowDisabledState then iDrawText(Canvas, TextString, TextRect1, [itfHCenter, itfVCenter, itfSingleLine, itfNoClip], Enabled, BackGroundColor)
              else                      iDrawText(Canvas, TextString, TextRect1, [itfHCenter, itfVCenter, itfSingleLine, itfNoClip], True, BackGroundColor);
            end;
          //------------------------------------------------------------------------------------------------------------------------------------------
          for y := 2 to 9 do
            begin
              if (PositionMin * Power(10, x) * y) > PositionMax then Break;

              if      not ShowDisabledState then Pen.Color  := TickMinorColor
              else if not Enabled then           Pen.Color  := clBtnShadow
              else                               Pen.Color  := TickMinorColor;

              PositionMinor := CurrentPosition*(y-1);
              DegreeMinor   := PositionToDegrees(PositionMinor);

              OuterPoint := GetXYRadPoint(DegreeMinor, MinorRadius1, OffsetPoint);
              InnerPoint := GetXYRadPoint(DegreeMinor, MinorRadius2, OffsetPoint);
              Polyline([InnerPoint, OuterPoint]);
            end;
          //------------------------------------------------------------------------------------------------------------------------------------------
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.DrawHub(Canvas: TCanvas; const OffsetPoint: TPoint);
begin
  if not FShowHub then Exit;

  with Canvas do
    begin
      if FHub3D then
        begin
          DrawGradientCircle(Canvas, clWhite, ColorToRGB(clBtnFace) and $FFFFFF - $505050, OffsetPoint, FHubSize div 2 +1, False);
        end
      else
        begin
          Pen.Color   := FHubColor;
          Brush.Color := FHubColor;
          Ellipse(OffsetPoint.x + FHubSize div 2, OffsetPoint.y + FHubSize div 2, OffsetPoint.x - FHubSize div 2, OffsetPoint.y - FHubSize div 2);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.DrawFace(Canvas: TCanvas; const OffsetPoint: TPoint);
var
  AFaceRadius   : Integer;
  ASmallerDepth : Integer;
begin
  if not FShowFace then Exit;

  with Canvas do
    begin
      if Width < Height then ASmallerDepth := Width
      else                   ASmallerDepth := Height;

      AFaceRadius := ASmallerDepth div 2 - FOuterMargin;

      case FFaceBevelStyle of
        idesSunken : DrawGradientCircle(Canvas, clWhite, ColorToRGB(clBtnFace) and $FFFFFF - $505050, OffsetPoint, AFaceRadius, True);
        idesRaised : DrawGradientCircle(Canvas, clWhite, ColorToRGB(clBtnFace) and $FFFFFF - $505050, OffsetPoint, AFaceRadius, False);
      end;

      AFaceRadius := AFaceRadius - FFaceBevelSize;

      case FFaceStyle of
        idesFlat   : begin
                       Pen.Color   := FFaceColor;
                       Brush.Color := FFaceColor;
                       Canvas.Ellipse(OffsetPoint.X - AFaceRadius, OffsetPoint.Y - AFaceRadius, OffsetPoint.X + AFaceRadius, OffsetPoint.Y + AFaceRadius);
                     end;
        idesSunken : DrawGradientCircle(Canvas, clWhite, FFaceColor, OffsetPoint, AFaceRadius, True);
        idesRaised : DrawGradientCircle(Canvas, clWhite, FFaceColor, OffsetPoint, AFaceRadius, False);
      end;

    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.DrawMinMax(Canvas: TCanvas; const OffsetPoint: TPoint);
begin
  if ShowMaxPointer then
    begin
      FMaxPointer.Position      := CurrentMax;
      FMaxPointer.Style         := ord(MinMaxPointerStyle);
      FMaxPointer.Margin        := MinMaxPointerMargin;
      FMaxPointer.Size          := MinMaxPointerSize;
      FMaxPointer.DrawScaleSide := False;
      FMaxPointer.Color         := MaxPointerColor;

      DrawIndicator(Canvas, OffsetPoint, FMaxPointer);
    end;

  if ShowMinPointer then
    begin
      FMinPointer.Position      := CurrentMin;
      FMinPointer.Style         := ord(MinMaxPointerStyle);
      FMinPointer.Margin        := MinMaxPointerMargin;
      FMinPointer.Size          := MinMaxPointerSize;
      FMinPointer.DrawScaleSide := False;
      FMinPointer.Color         := MinPointerColor;

      DrawIndicator(Canvas, OffsetPoint, FMinPointer);
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.DrawLimits(Canvas: TCanvas; const OffsetPoint: TPoint);
var
  x        : Integer;
  APointer : TiGaugePointer;
begin
  for x := 0 to LimitCount -1 do
    begin
      if LimitShowUpperPointer[x] then
        begin
          APointer := TiGaugePointer.Create(nil);
          try
            APointer.Position      := LimitUpperValue[x];
            APointer.Style         := ord(iagpsArrow);
            APointer.Margin        := LimitPointerMargin[x];
            APointer.Size          := LimitPointerSize[x];
            APointer.DrawScaleSide := LimitDrawScaleSide[x];
            APointer.Color         := LimitUpperPointerColor[x];

            DrawIndicator(Canvas, OffsetPoint, APointer);
          finally
            APointer.Free;
          end;
        end;

      if LimitShowLowerPointer[x] then
        begin
          APointer := TiGaugePointer.Create(nil);
          try
            APointer.Position      := LimitLowerValue[x];
            APointer.Style         := ord(iagpsArrow);
            APointer.Margin        := LimitPointerMargin[x];
            APointer.Size          := LimitPointerSize[x];
            APointer.DrawScaleSide := LimitDrawScaleSide[x];
            APointer.Color         := LimitLowerPointerColor[x];

            DrawIndicator(Canvas, OffsetPoint, APointer);
          finally
            APointer.Free;
          end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.DrawIndicator(Canvas: TCanvas; const OffsetPoint: TPoint; APointer: TiGaugePointer);
var
  PointerEndPoint  : TPoint;
  PointerBasePoint : TPoint;
  PointerDegress   : Double;
  Point1           : TPoint;
  Point2           : TPoint;
  OuterRadius      : Integer;
  InnerRadius      : Integer;
  PointArray       : Array[0..2] of TPoint;
  ARect            : TRect;
begin
  with Canvas, APointer do
    begin
      Brush.Style := bsSolid;
      Brush.Color := Color;
      Pen.Color   := Color;

      PointerDegress := PositionToDegrees(Position);

      OuterRadius := FArcRadius - Margin;
      InnerRadius := FArcRadius - Margin - Size;

      PointerEndPoint := GetXYRadPoint(PointerDegress, OuterRadius, OffsetPoint);

      case TiAngularGaugePointerStyle(Style) of
        iagpsArrowLine : begin
                           Polyline([OffsetPoint, PointerEndPoint]);
                           PointerBasePoint := GetXYRadPoint(PointerDegress, InnerRadius, OffsetPoint);
                           Point1 := GetXYRadPoint(PointerDegress + 90, Size/2, PointerBasePoint);
                           Point2 := GetXYRadPoint(PointerDegress - 90, Size/2, PointerBasePoint);
                           Polygon([Point1, Point2, PointerEndPoint]);

                           PointArray[0] := Point1;
                           PointArray[1] := Point2;
                           PointArray[2] := PointerEndPoint;
                           {$IFDEF iVCL}
                           TiGaugePointerAccess(APointer).Region := CreatePolygonRgn(PointArray, 3, ALTERNATE);
                           {$ENDIF}
                         end;
        iagpsArrow     : begin
                           if DrawScaleSide then
                             begin
                               OuterRadius := FArcRadius + Margin + Size;
                               InnerRadius := FArcRadius + Margin;
                               PointerEndPoint := GetXYRadPoint(PointerDegress, InnerRadius, OffsetPoint);
                               PointerBasePoint := GetXYRadPoint(PointerDegress, OuterRadius, OffsetPoint);
                             end
                           else PointerBasePoint := GetXYRadPoint(PointerDegress, InnerRadius, OffsetPoint);

                           Point1 := GetXYRadPoint(PointerDegress + 90, Size/2, PointerBasePoint);
                           Point2 := GetXYRadPoint(PointerDegress - 90, Size/2, PointerBasePoint);
                           Polygon([Point1, Point2, PointerEndPoint]);

                           PointArray[0] := Point1;
                           PointArray[1] := Point2;
                           PointArray[2] := PointerEndPoint;
                           {$IFDEF iVCL}
                           TiGaugePointerAccess(APointer).Region := CreatePolygonRgn(PointArray, 3, ALTERNATE);
                           {$ENDIF}
                         end;
        iagpsLine      : begin
                           Polyline([OffsetPoint, PointerEndPoint]);

                           ARect := GetClickRect([PointerEndPoint], 8);
                           {$IFDEF iVCL}
                           TiGaugePointerAccess(APointer).Region := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                           {$ENDIF}
                         end;
        iagpsTriangle  : begin
                           Polyline([OffsetPoint, PointerEndPoint]);
                           Point1 := GetXYRadPoint(PointerDegress + 90, Size/2, OffsetPoint);
                           Point2 := GetXYRadPoint(PointerDegress - 90, Size/2, OffsetPoint);
                           Polygon([Point1, Point2, PointerEndPoint]);

                           PointArray[0] := Point1;
                           PointArray[1] := Point2;
                           PointArray[2] := PointerEndPoint;
                           {$IFDEF iVCL}
                           TiGaugePointerAccess(APointer).Region := CreatePolygonRgn(PointArray, 3, ALTERNATE);
                           {$ENDIF}
                         end;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.DrawLabels(Canvas: TCanvas; const CenterPoint: TPoint);
var
  TextString : String;
  x, y       : Integer;
begin
  with Canvas do
    begin
      if FShowLabel1 then
        begin
          Brush.Style := bsClear;
          Font.Assign(FLabel1Font);
          TextString := FLabel1Text;

          case FLabel1AlignVertical of
            iavCenter : y := FLabel1OffsetY + CenterPoint.y - TextHeight(TextString) div 2;
            iavBottom : y := FLabel1OffsetY + Height - TextHeight(TextString);
            iavTop    : y := FLabel1OffsetY + 0;
            else        y := FLabel1OffsetY + 0;
          end;

          case FLabel1AlignHorizontal of
            iahCenter : x := FLabel1OffsetX + CenterPoint.x - TextWidth(TextString) div 2;
            iahLeft   : x := FLabel1OffsetX + 0;
            iahRight  : x := FLabel1OffsetX + Width - TextWidth(TextString);
            else        x := FLabel1OffsetX + 0;
          end;

          TextOut(x, y, TextString);
        end;

      if FShowLabel2 then
        begin
          Brush.Style := bsClear;
          Font.Assign(FLabel2Font);
          TextString := FLabel2Text;

          case FLabel2AlignVertical of
            iavCenter : y := FLabel2OffsetY + CenterPoint.y - TextHeight(TextString) div 2;
            iavBottom : y := FLabel2OffsetY + Height - TextHeight(TextString);
            iavTop    : y := FLabel2OffsetY + 0;
            else        y := FLabel2OffsetY + 0;
          end;

          case FLabel2AlignHorizontal of
            iahCenter : x := FLabel2OffsetX + CenterPoint.x - TextWidth(TextString) div 2;
            iahLeft   : x := FLabel2OffsetX + 0;
            iahRight  : x := FLabel2OffsetX + Width - TextWidth(TextString);
            else        x := FLabel2OffsetX + 0;
          end;

          TextOut(x, y, TextString);
        end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetPositionMin(const Value: Double);
begin
  if Value <= 0 then raise Exception.Create('Position Min must be greater than 0');
  inherited SetPositionMin(Value);
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i : Integer;
begin
  if (Button = mbLeft) then
    begin
      if MinMaxUserCanMove then
        begin
          FMouseDownX := X;
          FMouseDownY := Y;
          if      ShowMinPointer {$IFDEF iVCL}and (TiGaugePointerAccess(FMinPointer).Region <> 0) and PtInRegion(TiGaugePointerAccess(FMinPointer).Region, X,Y) {$ENDIF}then
            begin
              TiGaugePointerAccess(FMinPointer).MouseDown := True;
              FOldCurrentValue                            := CurrentMin;
              FMouseDownDegrees                           := RadToDeg(ArcTan2(Y-FCenterPoint.y,X-FCenterPoint.x));
            end
          else if ShowMaxPointer {$IFDEF iVCL}and (TiGaugePointerAccess(FMaxPointer).Region <> 0) and PtInRegion(TiGaugePointerAccess(FMaxPointer).Region, X,Y){$ENDIF} then
            begin
              TiGaugePointerAccess(FMaxPointer).MouseDown := True;
              FOldCurrentValue                            := CurrentMax;
              FMouseDownDegrees                           := RadToDeg(ArcTan2(Y-FCenterPoint.y,X-FCenterPoint.x));
            end;
          InvalidateChange;
        end;

      if (not TiGaugePointerAccess(FMinPointer).MouseDown) and (not TiGaugePointerAccess(FMaxPointer).MouseDown) then
        for i := 0 to PointerCount-1 do
          begin
            TiGaugePointerAccess(PointerManager.Items[i]).MouseDown := True;
            if not PointerManager.Items[i].Visible then Continue;
            {$IFDEF iVCL}
            TiGaugePointerAccess(PointerManager.Items[i]).MouseDown := PtInRegion(TiGaugePointerAccess(PointerManager.Items[i]).Region, X, Y);
            {$ENDIF}
            FOldCurrentValue      := PointerManager.Items[i].Position;
            FMouseDownDegrees     := RadToDeg(ArcTan2(Y-FCenterPoint.y,X-FCenterPoint.x));
          end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.iMouseMove(Shift: TShiftState; X, Y: Integer);
var
  i              : Integer;
  CurrentDegrees : Double;
  DeltaAngle     : Double;
  APointer       : TiGaugePointer;
begin
  CurrentDegrees  := RadToDeg(ArcTan2(Y-FCenterPoint.y,X-FCenterPoint.x));

  if -CurrentDegrees > FArcStartDegrees then CurrentDegrees := -FArcStartDegrees;

  DeltaAngle      := FMouseDownDegrees - CurrentDegrees;
  if DeltaAngle >  200 then DeltaAngle := DeltaAngle - 360;
   if DeltaAngle < -200 then DeltaAngle := DeltaAngle + 360;

  FMouseDownDegrees := CurrentDegrees;


  if TiGaugePointerAccess(FMaxPointer).MouseDown then
    begin
      CurrentMax := CurrentMax - DeltaAngle/FArcRangeDegrees*(PositionMax - PositionMin);
      if CurrentMin > CurrentMax then CurrentMin := CurrentMax;
    end
  else if TiGaugePointerAccess(FMinPointer).MouseDown then
    begin
      CurrentMin := CurrentMin - DeltaAngle/FArcRangeDegrees*(PositionMax - PositionMin);
      if CurrentMax < CurrentMin then CurrentMax := CurrentMin;
    end
  else
    begin
      for i := 0 to PointerCount-1 do
        begin
          APointer := PointerManager.Items[i];
          if TiGaugePointerAccess(APointer).MouseDown and APointer.UserCanMove then
            begin
              APointer.Position := APointer.Position - DeltaAngle/FArcRangeDegrees*(PositionMax - PositionMin);
              if APointer.Position < PositionMin then APointer.Position := PositionMin;
              if APointer.Position > PositionMax then APointer.Position := PositionMax;

              break;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i : Integer;
begin
  TiGaugePointerAccess(FMinPointer).MouseDown := False;
  TiGaugePointerAccess(FMaxPointer).MouseDown := False;

  for i := 0 to PointerCount-1 do
    begin
      if not PointerManager.Items[i].Visible then Continue;
      if TiGaugePointerAccess(PointerManager.Items[i]).MouseDown then
        begin
          {$IFDEF iVCL}
          if PtInRegion(TiGaugePointerAccess(PointerManager.Items[i]).Region, X, Y) then if Assigned(OnClickPointer) then OnClickPointer(i);
          {$ENDIF}
        end;
      TiGaugePointerAccess(PointerManager.Items[i]).MouseDown := False;
    end;
end;
//****************************************************************************************************************************************************
function TiAngularLogGauge.GetPointerColor  : TColor;                    begin Result :=                            PointerManager.Items[0].Color; end;
function TiAngularLogGauge.GetPointerMargin : Integer;                   begin Result :=                            PointerManager.Items[0].Margin;end;
function TiAngularLogGauge.GetPointerSize   : Integer;                   begin Result :=                            PointerManager.Items[0].Size;  end;
function TiAngularLogGauge.GetPointerStyle  : TiAngularGaugePointerStyle;begin Result := TiAngularGaugePointerStyle(PointerManager.Items[0].Style);end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetPointerMargin(const Value: Integer);                   begin PointerManager.Items[0].Margin := Value;     end;
procedure TiAngularLogGauge.SetPointerColor (const Value: TColor);                    begin PointerManager.Items[0].Color  := Value;     end;
procedure TiAngularLogGauge.SetPointerSize  (const Value: Integer);                   begin PointerManager.Items[0].Size   := Value;     end;
procedure TiAngularLogGauge.SetPointerStyle (const Value: TiAngularGaugePointerStyle);begin PointerManager.Items[0].Style  := ord(Value);end;
//****************************************************************************************************************************************************
function TiAngularLogGauge.GetPointersMargin(Index:Integer):Integer;                   begin Result:=PointerManager.Items[Index].Margin;                           end;
function TiAngularLogGauge.GetPointersStyle (Index:Integer):TiAngularGaugePointerStyle;begin Result:=TiAngularGaugePointerStyle(PointerManager.Items[Index].Style);end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.SetPointersMargin(Index, Value: Integer                          );begin PointerManager.Items[Index].Margin:=Value;    end;
procedure TiAngularLogGauge.SetPointersStyle (Index:Integer; Value:TiAngularGaugePointerStyle);begin PointerManager.Items[Index].Style :=ord(Value);end;
//****************************************************************************************************************************************************
procedure TiAngularLogGauge.InitializePointer(iGaugePointer: TiGaugePointer);
begin
  iGaugePointer.Position := 1;
end;
//****************************************************************************************************************************************************
end.

