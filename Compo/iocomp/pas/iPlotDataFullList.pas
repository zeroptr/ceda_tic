{*******************************************************}
{                                                       }
{       TiPlotDataFullList                              }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotDataFullList;{$endif}
{$ifdef iCLX}unit QiPlotDataFullList;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iPlotDataCustomList;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiPlotDataCustomList;{$ENDIF}

type
  TiPlotDataFull = record
    X                : Double;
    Y                : Double;
    Null             : Boolean;
    Empty            : Boolean;

    High             : Double;
    Low              : Double;
    Open             : Double;
    Close            : Double;

    TraceLineColor   : TColor;
    TraceLineWidth   : Integer;
    TraceLineStyle   : TiPlotLineStyle;

    MarkerVisible    : Boolean;
    MarkerSize       : Integer;
    MarkerStyle      : TiPlotMarkerStyle;
    MarkerPenColor   : TColor;
    MarkerPenWidth   : Integer;
    MarkerPenStyle   : TPenStyle;
    MarkerBrushColor : TColor;
    MarkerBrushStyle : TBrushStyle;
    MarkerCharacter  : Char;

    BarVisible       : Boolean;
    BarReference     : Double;
    BarWidth         : Double;
    BarPenColor      : TColor;
    BarPenWidth      : Integer;
    BarPenStyle      : TPenStyle;
    BarBrushColor    : TColor;
    BarBrushStyle    : TBrushStyle;
  end;
type
  TiPlotDataFullArray = array[0..(Maxint div SizeOf(TiPlotDataFull)) - 1] of TiPlotDataFull;
  PiPlotDataFullArray = ^TiPlotDataFullArray;

  TiPlotDataFullList = class(TiPlotDataCustomList)
  private
    FList : PiPlotDataFullArray;
  protected
    function  GetX               (const Index: Integer): Double;                        override;
    function  GetY               (const Index: Integer): Double;                        override;
    function  GetNull            (const Index: Integer): Boolean;                       override;
    function  GetEmpty           (const Index: Integer): Boolean;                       override;

    function  GetHigh            (const Index: Integer): Double;                        override;
    function  GetLow             (const Index: Integer): Double;                        override;
    function  GetOpen            (const Index: Integer): Double;                        override;
    function  GetClose           (const Index: Integer): Double;                        override;

    procedure SetX               (const Index: Integer; const Value: Double);           override;
    procedure SetY               (const Index: Integer; const Value: Double);           override;
    procedure SetNull            (const Index: Integer; const Value: Boolean);          override;
    procedure SetEmpty           (const Index: Integer; const Value: Boolean);          override;

    procedure SetHigh            (const Index: Integer; const Value: Double);           override;
    procedure SetLow             (const Index: Integer; const Value: Double);           override;
    procedure SetOpen            (const Index: Integer; const Value: Double);           override;
    procedure SetClose           (const Index: Integer; const Value: Double);           override;

    function  GetTraceLineColor  (const Index: Integer): TColor;                        override;
    function  GetTraceLineWidth  (const Index: Integer): Integer;                       override;
    function  GetTraceLineStyle  (const Index: Integer): TiPlotLineStyle;               override;
    function  GetMarkerVisible   (const Index: Integer): Boolean;                       override;
    function  GetMarkerSize      (const Index: Integer): Integer;                       override;
    function  GetMarkerStyle     (const Index: Integer): TiPlotMarkerStyle;             override;
    function  GetMarkerPenColor  (const Index: Integer): TColor;                        override;
    function  GetMarkerPenWidth  (const Index: Integer): Integer;                       override;
    function  GetMarkerPenStyle  (const Index: Integer): TPenStyle;                     override;
    function  GetMarkerBrushColor(const Index: Integer): TColor;                        override;
    function  GetMarkerBrushStyle(const Index: Integer): TBrushStyle;                   override;
    function  GetMarkerCharacter (const Index: Integer): Char;                          override;
    function  GetBarVisible      (const Index: Integer): Boolean;                       override;
    function  GetBarReference    (const Index: Integer): Double;                        override;
    function  GetBarWidth        (const Index: Integer): Double;                        override;
    function  GetBarPenColor     (const Index: Integer): TColor;                        override;
    function  GetBarPenWidth     (const Index: Integer): Integer;                       override;
    function  GetBarPenStyle     (const Index: Integer): TPenStyle;                     override;
    function  GetBarBrushColor   (const Index: Integer): TColor;                        override;
    function  GetBarBrushStyle   (const Index: Integer): TBrushStyle;                   override;

    procedure SetTraceLineColor  (const Index: Integer; const Value: TColor);           override;
    procedure SetTraceLineWidth  (const Index: Integer; const Value: Integer);          override;
    procedure SetTraceLineStyle  (const Index: Integer; const Value: TiPlotLineStyle);  override;
    procedure SetMarkerVisible   (const Index: Integer; const Value: Boolean);          override;
    procedure SetMarkerSize      (const Index: Integer; const Value: Integer);          override;
    procedure SetMarkerStyle     (const Index: Integer; const Value: TiPlotMarkerStyle);override;
    procedure SetMarkerPenColor  (const Index: Integer; const Value: TColor);           override;
    procedure SetMarkerPenWidth  (const Index: Integer; const Value: Integer);          override;
    procedure SetMarkerPenStyle  (const Index: Integer; const Value: TPenStyle);        override;
    procedure SetMarkerBrushColor(const Index: Integer; const Value: TColor);           override;
    procedure SetMarkerBrushStyle(const Index: Integer; const Value: TBrushStyle);      override;
    procedure SetMarkerCharacter (const Index: Integer; const Value: Char);             override;
    procedure SetBarVisible      (const Index: Integer; const Value: Boolean);          override;
    procedure SetBarReference    (const Index: Integer; const Value: Double);           override;
    procedure SetBarWidth        (const Index: Integer; const Value: Double);           override;
    procedure SetBarPenColor     (const Index: Integer; const Value: TColor);           override;
    procedure SetBarPenWidth     (const Index: Integer; const Value: Integer);          override;
    procedure SetBarPenStyle     (const Index: Integer; const Value: TPenStyle);        override;
    procedure SetBarBrushColor   (const Index: Integer; const Value: TColor);           override;
    procedure SetBarBrushStyle   (const Index: Integer; const Value: TBrushStyle);      override;

    procedure FreeMemory;                                                               override;
  public
    constructor Create;                                                                 override;

    function  Add(const X, Y: Double; const Null, Empty: Boolean): Integer;             override;
    procedure SetCapacity(const NewCapacity: Integer);                                  override;
    procedure DeletePoints(const Size : Integer);                                       override;

    procedure GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean); override;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiPlotDataFullList.Create;
begin
  inherited Create;
  SetDataPointSize(SizeOf(TiPlotDataFull));
end;
//****************************************************************************************************************************************************
function TiPlotDataFullList.Add(const X, Y: Double; const Null, Empty: Boolean): Integer;
var
  ActualIndex : Integer;
  Item        : TiPlotDataFull;
begin
  Item.X                := X;
  Item.Y                := Y;
  Item.Null             := Null;
  Item.Empty            := Empty;
  Item.High             := 0;
  Item.Low              := 0;

  Item.TraceLineColor   := StoredTraceLineColor;
  Item.TraceLineWidth   := StoredTraceLineWidth;
  Item.TraceLineStyle   := StoredTraceLineStyle;

  Item.MarkerVisible    := StoredMarkerVisible;
  Item.MarkerSize       := StoredMarkerSize;
  Item.MarkerStyle      := StoredMarkerStyle;
  Item.MarkerPenColor   := StoredMarkerPenColor;
  Item.MarkerPenStyle   := StoredMarkerPenStyle;
  Item.MarkerPenWidth   := StoredMarkerPenWidth;
  Item.MarkerBrushColor := StoredMarkerBrushColor;
  Item.MarkerBrushStyle := StoredMarkerBrushStyle;
  Item.MarkerCharacter  := #0;

  Item.BarVisible       := StoredBarVisible;
  Item.BarWidth         := StoredBarWidth;
  Item.BarReference     := StoredBarReference;
  Item.BarPenColor      := StoredBarPenColor;
  Item.BarPenStyle      := StoredBarPenStyle;
  Item.BarPenWidth      := StoredBarPenWidth;
  Item.BarBrushColor    := StoredBarBrushColor;
  Item.BarBrushStyle    := StoredBarBrushStyle;

  if RingBufferEnabled then
    begin
      if Count < Capacity then
        begin
          FList^[Count] := Item;
          Result := Count;
          Count := Count + 1;
        end
      else
        begin
          Tail := Tail + 1;
          if Tail = Count then Tail := 0;
          if Tail <> 0 then ActualIndex := Tail-1 else ActualIndex := Count-1;
          FList^[ActualIndex] := Item;
          Result := ActualIndex;
        end;
    end
  else
    begin
      Result := Count;
      if Result = Capacity then Grow;

      FList^[Result] := Item;
      Count := Count + 1;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataFullList.FreeMemory;
begin
  FreeMem(FList);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataFullList.SetCapacity(const NewCapacity: Integer);
begin
  if (NewCapacity > (Maxint div DataPointSize)) then raise Exception.Create('Exceed Maximum List Size');
  if NewCapacity <> Capacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(TiPlotDataFull));
    Capacity := NewCapacity;
    if Capacity < Count then Count := Capacity;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataFullList.DeletePoints(const Size: Integer);
begin
  if (Size < 0) or (Size >= Count) then raise Exception.Create('Delete Size Out Of Range');
  Count := Count - Size;
  if Count > 0 then System.Move(FList^[Size], FList^[0], (Count) * SizeOf(TiPlotDataFull));
end;
//****************************************************************************************************************************************************
procedure TiPlotDataFullList.GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean);
var
  Data : TiPlotDataFull;
begin
  Data  := FList^[GetActualIndex(Index)];
  X     := Data.X;
  Y     := Data.Y;
  Empty := Data.Empty;
  Null  := Data.Null;
end;
//****************************************************************************************************************************************************
function TiPlotDataFullList.GetX               (const Index:Integer):Double;           begin Result:=FList^[GetActualIndex(Index)].X;               end;
function TiPlotDataFullList.GetY               (const Index:Integer):Double;           begin Result:=FList^[GetActualIndex(Index)].Y;               end;
function TiPlotDataFullList.GetNull            (const Index:Integer):Boolean;          begin Result:=FList^[GetActualIndex(Index)].Null;            end;
function TiPlotDataFullList.GetEmpty           (const Index:Integer):Boolean;          begin Result:=FList^[GetActualIndex(Index)].Empty;           end;
//****************************************************************************************************************************************************
function TiPlotDataFullList.GetHigh            (const Index:Integer):Double;           begin Result:=FList^[GetActualIndex(Index)].High;            end;
function TiPlotDataFullList.GetLow             (const Index:Integer):Double;           begin Result:=FList^[GetActualIndex(Index)].Low;             end;
function TiPlotDataFullList.GetOpen            (const Index:Integer):Double;           begin Result:=FList^[GetActualIndex(Index)].Open;            end;
function TiPlotDataFullList.GetClose           (const Index:Integer):Double;           begin Result:=FList^[GetActualIndex(Index)].Close;           end;
//****************************************************************************************************************************************************
function TiPlotDataFullList.GetTraceLineColor  (const Index:Integer):TColor;           begin Result:=FList^[GetActualIndex(Index)].TraceLineColor;  end;
function TiPlotDataFullList.GetTraceLineWidth  (const Index:Integer):Integer;          begin Result:=FList^[GetActualIndex(Index)].TraceLineWidth;  end;
function TiPlotDataFullList.GetTraceLineStyle  (const Index:Integer):TiPlotLineStyle;  begin Result:=FList^[GetActualIndex(Index)].TraceLineStyle;  end;
function TiPlotDataFullList.GetMarkerVisible   (const Index:Integer):Boolean;          begin Result:=FList^[GetActualIndex(Index)].MarkerVisible;   end;
function TiPlotDataFullList.GetMarkerSize      (const Index:Integer):Integer;          begin Result:=FList^[GetActualIndex(Index)].MarkerSize;      end;
function TiPlotDataFullList.GetMarkerStyle     (const Index:Integer):TiPlotMarkerStyle;begin Result:=FList^[GetActualIndex(Index)].MarkerStyle;     end;
function TiPlotDataFullList.GetMarkerPenColor  (const Index:Integer):TColor;           begin Result:=FList^[GetActualIndex(Index)].MarkerPenColor;  end;
function TiPlotDataFullList.GetMarkerPenWidth  (const Index:Integer):Integer;          begin Result:=FList^[GetActualIndex(Index)].MarkerPenWidth;  end;
function TiPlotDataFullList.GetMarkerPenStyle  (const Index:Integer):TPenStyle;        begin Result:=FList^[GetActualIndex(Index)].MarkerPenStyle;  end;
function TiPlotDataFullList.GetMarkerBrushColor(const Index:Integer):TColor;           begin Result:=FList^[GetActualIndex(Index)].MarkerBrushColor;end;
function TiPlotDataFullList.GetMarkerBrushStyle(const Index:Integer):TBrushStyle;      begin Result:=FList^[GetActualIndex(Index)].MarkerBrushStyle;end;
function TiPlotDataFullList.GetMarkerCharacter (const Index:Integer):Char;             begin Result:=FList^[GetActualIndex(Index)].MarkerCharacter; end;
function TiPlotDataFullList.GetBarVisible      (const Index:Integer):Boolean;          begin Result:=FList^[GetActualIndex(Index)].BarVisible;      end;
function TiPlotDataFullList.GetBarReference    (const Index:Integer):Double;           begin Result:=FList^[GetActualIndex(Index)].BarReference;    end;
function TiPlotDataFullList.GetBarWidth        (const Index:Integer):Double;           begin Result:=FList^[GetActualIndex(Index)].BarWidth;        end;
function TiPlotDataFullList.GetBarPenColor     (const Index:Integer):TColor;           begin Result:=FList^[GetActualIndex(Index)].BarPenColor;     end;
function TiPlotDataFullList.GetBarPenWidth     (const Index:Integer):Integer;          begin Result:=FList^[GetActualIndex(Index)].BarPenWidth;     end;
function TiPlotDataFullList.GetBarPenStyle     (const Index:Integer):TPenStyle;        begin Result:=FList^[GetActualIndex(Index)].BarPenStyle;     end;
function TiPlotDataFullList.GetBarBrushColor   (const Index:Integer):TColor;           begin Result:=FList^[GetActualIndex(Index)].BarBrushColor;   end;
function TiPlotDataFullList.GetBarBrushStyle   (const Index:Integer):TBrushStyle;      begin Result:=FList^[GetActualIndex(Index)].BarBrushStyle;   end;
//****************************************************************************************************************************************************
procedure TiPlotDataFullList.SetX               (const Index:Integer;const Value:Double);           begin FList^[GetActualIndex(Index)].X               := Value;end;
procedure TiPlotDataFullList.SetY               (const Index:Integer;const Value:Double);           begin FList^[GetActualIndex(Index)].Y               := Value;end;
procedure TiPlotDataFullList.SetNull            (const Index:Integer;const Value:Boolean);          begin FList^[GetActualIndex(Index)].Null            := Value;end;
procedure TiPlotDataFullList.SetEmpty           (const Index:Integer;const Value:Boolean);          begin FList^[GetActualIndex(Index)].Empty           := Value;end;
//****************************************************************************************************************************************************
procedure TiPlotDataFullList.SetHigh            (const Index:Integer;const Value:Double);           begin FList^[GetActualIndex(Index)].High            := Value;end;
procedure TiPlotDataFullList.SetLow             (const Index:Integer;const Value:Double);           begin FList^[GetActualIndex(Index)].Low             := Value;end;
procedure TiPlotDataFullList.SetOpen            (const Index:Integer;const Value:Double);           begin FList^[GetActualIndex(Index)].Open            := Value;end;
procedure TiPlotDataFullList.SetClose           (const Index:Integer;const Value:Double);           begin FList^[GetActualIndex(Index)].Close           := Value;end;
//****************************************************************************************************************************************************
procedure TiPlotDataFullList.SetTraceLineColor  (const Index:Integer;const Value:TColor);           begin FList^[GetActualIndex(Index)].TraceLineColor  := Value;end;
procedure TiPlotDataFullList.SetTraceLineWidth  (const Index:Integer;const Value:Integer);          begin FList^[GetActualIndex(Index)].TraceLineWidth  := Value;end;
procedure TiPlotDataFullList.SetTraceLineStyle  (const Index:Integer;const Value:TiPlotLineStyle);  begin FList^[GetActualIndex(Index)].TraceLineStyle  := Value;end;
procedure TiPlotDataFullList.SetMarkerVisible   (const Index:Integer;const Value:Boolean);          begin FList^[GetActualIndex(Index)].MarkerVisible   := Value;end;
procedure TiPlotDataFullList.SetMarkerSize      (const Index:Integer;const Value:Integer);          begin FList^[GetActualIndex(Index)].MarkerSize      := Value;end;
procedure TiPlotDataFullList.SetMarkerStyle     (const Index:Integer;const Value:TiPlotMarkerStyle);begin FList^[GetActualIndex(Index)].MarkerStyle     := Value;end;
procedure TiPlotDataFullList.SetMarkerPenColor  (const Index:Integer;const Value:TColor);           begin FList^[GetActualIndex(Index)].MarkerPenColor  := Value;end;
procedure TiPlotDataFullList.SetMarkerPenWidth  (const Index:Integer;const Value:Integer);          begin FList^[GetActualIndex(Index)].MarkerPenWidth  := Value;end;
procedure TiPlotDataFullList.SetMarkerPenStyle  (const Index:Integer;const Value:TPenStyle);        begin FList^[GetActualIndex(Index)].MarkerPenStyle  := Value;end;
procedure TiPlotDataFullList.SetMarkerBrushColor(const Index:Integer;const Value:TColor);           begin FList^[GetActualIndex(Index)].MarkerBrushColor:= Value;end;
procedure TiPlotDataFullList.SetMarkerBrushStyle(const Index:Integer;const Value:TBrushStyle);      begin FList^[GetActualIndex(Index)].MarkerBrushStyle:= Value;end;
procedure TiPlotDataFullList.SetMarkerCharacter (const Index:Integer;const Value:Char);             begin FList^[GetActualIndex(Index)].MarkerCharacter := Value;end;
procedure TiPlotDataFullList.SetBarVisible      (const Index:Integer;const Value:Boolean);          begin FList^[GetActualIndex(Index)].BarVisible      := Value;end;
procedure TiPlotDataFullList.SetBarReference    (const Index:Integer;const Value:Double);           begin FList^[GetActualIndex(Index)].BarReference    := Value;end;
procedure TiPlotDataFullList.SetBarWidth        (const Index:Integer;const Value:Double);           begin FList^[GetActualIndex(Index)].BarWidth        := Value;end;
procedure TiPlotDataFullList.SetBarPenColor     (const Index:Integer;const Value:TColor);           begin FList^[GetActualIndex(Index)].BarPenColor     := Value;end;
procedure TiPlotDataFullList.SetBarPenWidth     (const Index:Integer;const Value:Integer);          begin FList^[GetActualIndex(Index)].BarPenWidth     := Value;end;
procedure TiPlotDataFullList.SetBarPenStyle     (const Index:Integer;const Value:TPenStyle);        begin FList^[GetActualIndex(Index)].BarPenStyle     := Value;end;
procedure TiPlotDataFullList.SetBarBrushColor   (const Index:Integer;const Value:TColor);           begin FList^[GetActualIndex(Index)].BarBrushColor   := Value;end;
procedure TiPlotDataFullList.SetBarBrushStyle   (const Index:Integer;const Value:TBrushStyle);      begin FList^[GetActualIndex(Index)].BarBrushStyle   := Value;end;
//****************************************************************************************************************************************************
end.
