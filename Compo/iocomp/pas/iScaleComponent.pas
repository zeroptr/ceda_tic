{*******************************************************}
{                                                       }
{       TiScaleComponent                                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScaleComponent;{$endif}
{$ifdef iCLX}unit QiScaleComponent;{$endif}

interface
                                     
uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iScaleObject,  iPositionComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiScaleObject, QiPositionComponent;{$ENDIF}

type
  TiScaleComponent = class(TiPositionComponent)
  private
    FScaleObject           : TiScaleObject;
    FAutoScaleEnabled      : Boolean;
    FAutoScaleDesiredTicks : Integer;
    FAutoScaleMaxTicks     : Integer;
    FAutoScaleStyle        : TiAutoScaleStyle;

    procedure SetShowTicksAxis          (const Value: Boolean);
    procedure SetShowTickLabels         (const Value: Boolean);
    procedure SetShowTicksMajor         (const Value: Boolean);
    procedure SetShowTicksMinor         (const Value: Boolean);
    procedure SetTickLabelFont          (const Value: TFont);
    procedure SetTickLabelMargin        (const Value: Integer);
    procedure SetTickLabelPrecision     (const Value: Integer);
    procedure SetTickMajorColor         (const Value: TColor);
    procedure SetTickMajorCount         (const Value: Integer);
    procedure SetTickMajorLength        (const Value: Integer);
    procedure SetTickMargin             (const Value: Integer);
    procedure SetTickMinorAlignment     (const Value: TiTickMinorAlignment);
    procedure SetTickMinorColor         (const Value: TColor);
    procedure SetTickMinorCount         (const Value: Integer);
    procedure SetTickMinorLength        (const Value: Integer);
    procedure SetTickMajorStyle         (const Value: TiBevelStyle);
    procedure SetTickMinorStyle         (const Value: TiBevelStyle);
    procedure SetShowTicksMajorFirstLast(const Value: Boolean);
    procedure SetPrecisionStyle         (const Value: TiPrecisionStyle);
    procedure SetAutoScaleDesiredTicks  (const Value: Integer);
    procedure SetAutoScaleEnabled       (const Value: Boolean);
    procedure SetAutoScaleMaxTicks      (const Value: Integer);
    procedure SetAutoScaleStyle         (const Value: TiAutoScaleStyle);
    procedure SetOnCustomizeTickLabel   (const Value: TOnCustomizeTickLabel);

    function GetShowTicksAxis           : Boolean;
    function GetShowTickLabels          : Boolean;
    function GetShowTicksMajor          : Boolean;
    function GetShowTicksMinor          : Boolean;
    function GetTickLabelFont           : TFont;
    function GetTickLabelMargin         : Integer;
    function GetTickLabelPrecision      : Integer;
    function GetTickMajorColor          : TColor;
    function GetTickMajorCount          : Integer;
    function GetTickMajorLength         : Integer;
    function GetTickMargin              : Integer;
    function GetTickMinorAlignment      : TiTickMinorAlignment;
    function GetTickMinorColor          : TColor;
    function GetTickMinorCount          : Integer;
    function GetTickMinorLength         : Integer;
    function GetTickMajorStyle          : TiBevelStyle;
    function GetTickMinorStyle          : TiBevelStyle;
    function GetShowTicksMajorFirstLast : Boolean;
    function GetPrecisionStyle          : TiPrecisionStyle;
    function GetOnCustomizeTickLabel    : TOnCustomizeTickLabel;
  protected
    FAutoScaleMaxTick : Double;
    FAutoScaleMinTick : Double;
    
    procedure SetPositionMin(const Value : Double); override;
    procedure SetPositionMax(const Value : Double); override;
    procedure DoAutoScale   (DesiredMin, DesiredMax: Double);
    function  GetDecimalPoints : Integer; virtual;

    procedure ScaleChange(Sender : TObject);

    property  ScaleObject             : TiScaleObject         read FScaleObject;
    property  ShowTicksAxis           : Boolean               read GetShowTicksAxis           write SetShowTicksAxis           default True;
    property  ShowTicksMajorFirstLast : Boolean               read GetShowTicksMajorFirstLast write SetShowTicksMajorFirstLast default True;
    property  TickMajorStyle          : TiBevelStyle          read GetTickMajorStyle          write SetTickMajorStyle          default ibsNone;
    property  TickMinorStyle          : TiBevelStyle          read GetTickMinorStyle          write SetTickMinorStyle          default ibsNone;

    property  ShowTicksMajor          : Boolean               read GetShowTicksMajor          write SetShowTicksMajor          default True;
    property  ShowTicksMinor          : Boolean               read GetShowTicksMinor          write SetShowTicksMinor          default True;
    property  ShowTickLabels          : Boolean               read GetShowTickLabels          write SetShowTickLabels          default True;
    property  TickMajorCount          : Integer               read GetTickMajorCount          write SetTickMajorCount          default 5;
    property  TickMajorColor          : TColor                read GetTickMajorColor          write SetTickMajorColor          default clBlack;
    property  TickMajorLength         : Integer               read GetTickMajorLength         write SetTickMajorLength         default 7;
    property  TickMinorAlignment      : TiTickMinorAlignment  read GetTickMinorAlignment      write SetTickMinorAlignment      default itmnaInside;
    property  TickMinorCount          : Integer               read GetTickMinorCount          write SetTickMinorCount          default 4;
    property  TickMinorColor          : TColor                read GetTickMinorColor          write SetTickMinorColor          default clBlack;
    property  TickMinorLength         : Integer               read GetTickMinorLength         write SetTickMinorLength         default 3;
    property  TickMargin              : Integer               read GetTickMargin              write SetTickMargin              default 5;
    property  TickLabelMargin         : Integer               read GetTickLabelMargin         write SetTickLabelMargin         default 5;
    property  TickLabelFont           : TFont                 read GetTickLabelFont           write SetTickLabelFont;
    property  TickLabelPrecision      : Integer               read GetTickLabelPrecision      write SetTickLabelPrecision      default 0;
    property  PrecisionStyle          : TiPrecisionStyle      read GetPrecisionStyle          write SetPrecisionStyle          default ipsFixedDecimalPoints;
    property  AutoScaleEnabled        : Boolean               read FAutoScaleEnabled          write SetAutoScaleEnabled        default False;
    property  AutoScaleDesiredTicks   : Integer               read FAutoScaleDesiredTicks     write SetAutoScaleDesiredTicks   default 5;
    property  AutoScaleMaxTicks       : Integer               read FAutoScaleMaxTicks         write SetAutoScaleMaxTicks       default 6;
    property  AutoScaleStyle          : TiAutoScaleStyle      read FAutoScaleStyle            write SetAutoScaleStyle          default iassAutoMinMax;
    property  OnCustomizeTickLabel    : TOnCustomizeTickLabel read GetOnCustomizeTickLabel    write SetOnCustomizeTickLabel;
  public
    constructor Create(AOwner: TComponent);    override;
    destructor  Destroy;                       override;
    procedure   Loaded;                        override;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiScaleComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FScaleObject   := TiScaleObject.Create;
  PrecisionStyle := ipsFixedDecimalPoints;
  FScaleObject.OnChange := ScaleChange;

  AutoScaleDesiredTicks := 5;
  AutoScaleMaxTicks     := 6;

  ShowTicksAxis         := True;
  ShowTicksMajor        := True;
  ShowTicksMinor        := True;
  ShowTickLabels        := True;
end;
//****************************************************************************************************************************************************
destructor TiScaleComponent.Destroy;
begin
  FScaleObject.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiScaleComponent.Loaded;
begin
  inherited;
  DoAutoScale(PositionMin, PositionMax);
end;
//****************************************************************************************************************************************************
function TiScaleComponent.GetShowTickLabels          : Boolean;              begin Result := FScaleObject.ShowTickLabels          end;
function TiScaleComponent.GetShowTicksAxis           : Boolean;              begin Result := FScaleObject.ShowTicksAxis;          end;
function TiScaleComponent.GetShowTicksMajor          : Boolean;              begin Result := FScaleObject.ShowTicksMajor          end;
function TiScaleComponent.GetShowTicksMinor          : Boolean;              begin Result := FScaleObject.ShowTicksMinor          end;
function TiScaleComponent.GetShowTicksMajorFirstLast : Boolean;              begin Result := FScaleObject.ShowTicksMajorFirstLast end;
function TiScaleComponent.GetTickLabelFont           : TFont;                begin Result := FScaleObject.TickLabelFont           end;
function TiScaleComponent.GetTickLabelMargin         : Integer;              begin Result := FScaleObject.TickLabelMargin         end;
function TiScaleComponent.GetTickLabelPrecision      : Integer;              begin Result := FScaleObject.TickLabelPrecision      end;
function TiScaleComponent.GetTickMajorColor          : TColor;               begin Result := FScaleObject.TickMajorColor          end;
function TiScaleComponent.GetTickMajorCount          : Integer;              begin Result := FScaleObject.TickMajorCount          end;
function TiScaleComponent.GetTickMajorLength         : Integer;              begin Result := FScaleObject.TickMajorLength         end;
function TiScaleComponent.GetTickMajorStyle          : TiBevelStyle;         begin Result := FScaleObject.TickMajorStyle          end;
function TiScaleComponent.GetTickMargin              : Integer;              begin Result := FScaleObject.TickMargin              end;
function TiScaleComponent.GetTickMinorAlignment      : TiTickMinorAlignment; begin Result := FScaleObject.TickMinorAlignment      end;
function TiScaleComponent.GetTickMinorColor          : TColor;               begin Result := FScaleObject.TickMinorColor          end;
function TiScaleComponent.GetTickMinorCount          : Integer;              begin Result := FScaleObject.TickMinorCount          end;
function TiScaleComponent.GetTickMinorLength         : Integer;              begin Result := FScaleObject.TickMinorLength         end;
function TiScaleComponent.GetTickMinorStyle          : TiBevelStyle;         begin Result := FScaleObject.TickMinorStyle          end;
function TiScaleComponent.GetPrecisionStyle          : TiPrecisionStyle;     begin Result := FScaleObject.PrecisionStyle          end;
function TiScaleComponent.GetOnCustomizeTickLabel    : TOnCustomizeTickLabel;begin Result := FScaleObject.OnCustomizeTickLabel    end;
//****************************************************************************************************************************************************
procedure TiScaleComponent.SetShowTicksAxis          (const Value: Boolean);              begin FScaleObject.ShowTicksAxis           := Value; end;
procedure TiScaleComponent.SetShowTickLabels         (const Value: Boolean);              begin FScaleObject.ShowTickLabels          := Value; end;
procedure TiScaleComponent.SetShowTicksMajor         (const Value: Boolean);              begin FScaleObject.ShowTicksMajor          := Value; end;
procedure TiScaleComponent.SetShowTicksMinor         (const Value: Boolean);              begin FScaleObject.ShowTicksMinor          := Value; end;
procedure TiScaleComponent.SetShowTicksMajorFirstLast(const Value: Boolean);              begin FScaleObject.ShowTicksMajorFirstLast := Value; end;
procedure TiScaleComponent.SetTickLabelFont          (const Value: TFont  );              begin FScaleObject.TickLabelFont           := Value; end;
procedure TiScaleComponent.SetTickLabelMargin        (const Value: Integer);              begin FScaleObject.TickLabelMargin         := Value; end;
procedure TiScaleComponent.SetTickLabelPrecision     (const Value: Integer);              begin FScaleObject.TickLabelPrecision      := Value; end;
procedure TiScaleComponent.SetTickMajorColor         (const Value: TColor );              begin FScaleObject.TickMajorColor          := Value; end;
procedure TiScaleComponent.SetTickMajorCount         (const Value: Integer);              begin FScaleObject.TickMajorCount          := Value; end;
procedure TiScaleComponent.SetTickMajorLength        (const Value: Integer);              begin FScaleObject.TickMajorLength         := Value; end;
procedure TiScaleComponent.SetTickMajorStyle         (const Value: TiBevelStyle);         begin FScaleObject.TickMajorStyle          := Value; end;
procedure TiScaleComponent.SetTickMargin             (const Value: Integer);              begin FScaleObject.TickMargin              := Value; end;
procedure TiScaleComponent.SetTickMinorAlignment     (const Value: TiTickMinorAlignment); begin FScaleObject.TickMinorAlignment      := Value; end;
procedure TiScaleComponent.SetTickMinorColor         (const Value: TColor );              begin FScaleObject.TickMinorColor          := Value; end;
procedure TiScaleComponent.SetTickMinorCount         (const Value: Integer);              begin FScaleObject.TickMinorCount          := Value; end;
procedure TiScaleComponent.SetTickMinorLength        (const Value: Integer);              begin FScaleObject.TickMinorLength         := Value; end;
procedure TiScaleComponent.SetTickMinorStyle         (const Value: TiBevelStyle);         begin FScaleObject.TickMinorStyle          := Value; end;
procedure TiScaleComponent.SetPrecisionStyle         (const Value: TiPrecisionStyle);     begin FScaleObject.PrecisionStyle          := Value; end;
procedure TiScaleComponent.SetOnCustomizeTickLabel   (const Value: TOnCustomizeTickLabel);begin FScaleObject.OnCustomizeTickLabel    := Value; end;
//****************************************************************************************************************************************************
procedure TiScaleComponent.ScaleChange(Sender : TObject);
begin
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiScaleComponent.SetAutoScaleEnabled(const Value: Boolean);
begin
  if FAutoScaleEnabled <> Value then
    begin
      FAutoScaleEnabled := Value;
      FScaleObject.AutoScaleEnabled := Value;
      DoAutoScale(PositionMin, PositionMax);
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleComponent.SetAutoScaleDesiredTicks(const Value: Integer);
begin
  if Value < 2 then exit;
  if FAutoScaleDesiredTicks <> Value then
    begin
      FAutoScaleDesiredTicks := Value;
      FScaleObject.AutoScaleDesiredTicks := Value;
      DoAutoScale(PositionMin, PositionMax);
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleComponent.SetAutoScaleMaxTicks(const Value: Integer);
begin
  if Value < 2 then exit;
  if FAutoScaleMaxTicks <> Value then
    begin
      FAutoScaleMaxTicks := Value;
      FScaleObject.AutoScaleMaxTicks := Value;
      DoAutoScale(PositionMin, PositionMax);
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleComponent.SetAutoScaleStyle(const Value: TiAutoScaleStyle);
begin
  if FAutoScaleStyle <> Value then
    begin
      FAutoScaleStyle := Value;
      FScaleObject.AutoScaleStyle := Value;
      DoAutoScale(PositionMin, PositionMax);
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleComponent.DoAutoScale(DesiredMin, DesiredMax: Double);
var
  NewMin   : Double;
  NewMax   : Double;
  NewTicks : Integer;
begin
  if FAutoScaleEnabled and not Loading then
    begin
      case FAutoScaleStyle of
        iassAutoMinMax : begin
                           GetAutoScaleValuesAdjustable(DesiredMin, DesiredMax, FAutoScaleDesiredTicks, FAutoScaleMaxTicks, NewMin, NewMax, NewTicks);
                           SetPositionMinMax(NewMin, NewMax);
                         end;
        iassFixedMinMax : begin
                           GetAutoScaleValuesFixed(DesiredMin, DesiredMax, FAutoScaleDesiredTicks, FAutoScaleMaxTicks, NewMin, NewMax, NewTicks);
                           SetPositionMinMax(DesiredMin, DesiredMax);
                           FAutoScaleMaxTick := NewMax;
                           FAutoScaleMinTick := NewMin;
                           FScaleObject.AutoScaleMaxTick := NewMax;
                           FScaleObject.AutoScaleMinTick := NewMin;
                           BackGroundChange;
                          end;
      end;
      TickMajorCount := NewTicks;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleComponent.SetPositionMax(const Value: Double);
begin
  if FAutoScaleEnabled and not Loading then
    begin
      DoAutoScale(PositionMin, Value)
    end
  else inherited;
end;
//****************************************************************************************************************************************************
procedure TiScaleComponent.SetPositionMin(const Value: Double);
begin
  if FAutoScaleEnabled and not Loading then
    begin
      DoAutoScale(Value, PositionMax)
    end
  else inherited;
end;
//****************************************************************************************************************************************************
function TiScaleComponent.GetDecimalPoints: Integer;
var
  Span : Double;
begin
  Result := 0;
  case PrecisionStyle of
    ipsSignificantDigits : if TickLabelPrecision > 0 then
                             begin
                               Span := ABS(PositionMax - PositionMin);
                               if Span <> 0 then Result := TickLabelPrecision - (Trunc(Log10(Span))+1) else Result := 0;
                               if Span < 1 then Result := Result + 1;
                               if Result < 0 then Result := 0;
                             end;
    ipsFixedDecimalPoints : Result := TickLabelPrecision;
  end;
end;
//****************************************************************************************************************************************************
end.


