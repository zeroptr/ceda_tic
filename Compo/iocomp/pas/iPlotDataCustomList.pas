{*******************************************************}
{                                                       }
{       TiPlotDataNullList                              }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotDataCustomList;{$endif}
{$ifdef iCLX}unit QiPlotDataCustomList;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes;{$ENDIF}
  {$IFDEF iCLX}QiTypes;{$ENDIF}

type
  TiPlotDataCustomList = class(TObject)
  private
    FCount                   : Integer;
    FCapacity                : Integer;
    FTail                    : Integer;
    FRingBufferEnabled       : Boolean;
    FDataPointSize           : Integer;
    FMaxDataPoints           : Integer;

    FStoredTraceLineColor    : TColor;
    FStoredTraceLineWidth    : Integer;
    FStoredTraceLineStyle    : TiPlotLineStyle;

    FStoredMarkerVisible     : Boolean;
    FStoredMarkerSize        : Integer;
    FStoredMarkerStyle       : TiPlotMarkerStyle;
    FStoredMarkerPenColor    : TColor;
    FStoredMarkerPenWidth    : Integer;
    FStoredMarkerPenStyle    : TPenStyle;
    FStoredMarkerBrushColor  : TColor;
    FStoredMarkerBrushStyle  : TBrushStyle;
    FStoredMarkerCharacter   : Char;

    FStoredBarVisible        : Boolean;
    FStoredBarReference      : Double;
    FStoredBarWidth          : Double;
    FStoredBarPenColor       : TColor;
    FStoredBarPenWidth       : Integer;
    FStoredBarPenStyle       : TPenStyle;
    FStoredBarBrushColor     : TColor;
    FStoredBarBrushStyle     : TBrushStyle;
  protected
    function  GetX               (const Index: Integer): Double;                        virtual; abstract;
    function  GetY               (const Index: Integer): Double;                        virtual; abstract;
    function  GetEmpty           (const Index: Integer): Boolean;                       virtual;
    function  GetNull            (const Index: Integer): Boolean;                       virtual;
    function  GetHigh            (const Index: Integer): Double;                        virtual;
    function  GetLow             (const Index: Integer): Double;                        virtual;
    function  GetOpen            (const Index: Integer): Double;                        virtual;
    function  GetClose           (const Index: Integer): Double;                        virtual;

    procedure SetX               (const Index: Integer; const Value: Double);           virtual; abstract;
    procedure SetY               (const Index: Integer; const Value: Double);           virtual; abstract;
    procedure SetEmpty           (const Index: Integer; const Value: Boolean);          virtual;
    procedure SetNull            (const Index: Integer; const Value: Boolean);          virtual;
    procedure SetHigh            (const Index: Integer; const Value: Double);           virtual;
    procedure SetLow             (const Index: Integer; const Value: Double);           virtual;
    procedure SetOpen            (const Index: Integer; const Value: Double);           virtual;
    procedure SetClose           (const Index: Integer; const Value: Double);           virtual;

    function  GetTraceLineColor  (const Index: Integer): TColor;                        virtual;
    function  GetTraceLineWidth  (const Index: Integer): Integer;                       virtual;
    function  GetTraceLineStyle  (const Index: Integer): TiPlotLineStyle;               virtual;
    function  GetMarkerVisible   (const Index: Integer): Boolean;                       virtual;
    function  GetMarkerSize      (const Index: Integer): Integer;                       virtual;
    function  GetMarkerStyle     (const Index: Integer): TiPlotMarkerStyle;             virtual;
    function  GetMarkerPenColor  (const Index: Integer): TColor;                        virtual;
    function  GetMarkerPenWidth  (const Index: Integer): Integer;                       virtual;
    function  GetMarkerPenStyle  (const Index: Integer): TPenStyle;                     virtual;
    function  GetMarkerBrushColor(const Index: Integer): TColor;                        virtual;
    function  GetMarkerBrushStyle(const Index: Integer): TBrushStyle;                   virtual;
    function  GetMarkerCharacter (const Index: Integer): Char;                          virtual;
    function  GetBarVisible      (const Index: Integer): Boolean;                       virtual;
    function  GetBarReference    (const Index: Integer): Double;                        virtual;
    function  GetBarWidth        (const Index: Integer): Double;                        virtual;
    function  GetBarPenColor     (const Index: Integer): TColor;                        virtual;
    function  GetBarPenWidth     (const Index: Integer): Integer;                       virtual;
    function  GetBarPenStyle     (const Index: Integer): TPenStyle;                     virtual;
    function  GetBarBrushColor   (const Index: Integer): TColor;                        virtual;
    function  GetBarBrushStyle   (const Index: Integer): TBrushStyle;                   virtual;

    procedure SetTraceLineColor  (const Index: Integer; const Value: TColor);           virtual;
    procedure SetTraceLineWidth  (const Index: Integer; const Value: Integer);          virtual;
    procedure SetTraceLineStyle  (const Index: Integer; const Value: TiPlotLineStyle);  virtual;
    procedure SetMarkerVisible   (const Index: Integer; const Value: Boolean);          virtual;
    procedure SetMarkerSize      (const Index: Integer; const Value: Integer);          virtual;
    procedure SetMarkerStyle     (const Index: Integer; const Value: TiPlotMarkerStyle);virtual;
    procedure SetMarkerPenColor  (const Index: Integer; const Value: TColor);           virtual;
    procedure SetMarkerPenWidth  (const Index: Integer; const Value: Integer);          virtual;
    procedure SetMarkerPenStyle  (const Index: Integer; const Value: TPenStyle);        virtual;
    procedure SetMarkerBrushColor(const Index: Integer; const Value: TColor);           virtual;
    procedure SetMarkerBrushStyle(const Index: Integer; const Value: TBrushStyle);      virtual;
    procedure SetMarkerCharacter (const Index: Integer; const Value: Char);             virtual;
    procedure SetBarVisible      (const Index: Integer; const Value: Boolean);          virtual;
    procedure SetBarReference    (const Index: Integer; const Value: Double);           virtual;
    procedure SetBarWidth        (const Index: Integer; const Value: Double);           virtual;
    procedure SetBarPenColor     (const Index: Integer; const Value: TColor);           virtual;
    procedure SetBarPenWidth     (const Index: Integer; const Value: Integer);          virtual;
    procedure SetBarPenStyle     (const Index: Integer; const Value: TPenStyle);        virtual;
    procedure SetBarBrushColor   (const Index: Integer; const Value: TColor);           virtual;
    procedure SetBarBrushStyle   (const Index: Integer; const Value: TBrushStyle);      virtual;

    function  GetRingBufferSize: Integer;
    procedure SetRingBufferSize(const Value: Integer);

    function GetActualIndex(Value: Integer): Integer;

    function GetMemoryUsed: Integer;

    procedure SetDataPointSize(Value: Integer);

    procedure Grow;
    procedure FreeMemory;                                                               virtual; abstract;

    property RingBufferEnabled : Boolean read FRingBufferEnabled;
    property Tail              : Integer read FTail               write FTail;
  public
    constructor Create;                                                                 virtual;
    destructor Destroy; override;

    function  Add(const X, Y: Double; const Null, Empty: Boolean): Integer;             virtual; abstract;
    procedure Clear;                                                                    virtual;
    procedure SetCapacity(const NewCapacity: Integer);                                  virtual; abstract;
    procedure DeletePoints(const Size : Integer);                                       virtual; abstract;

    procedure GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean); virtual; abstract;

    property DataPointSize                         : Integer           read FDataPointSize;
    property MaxDataPoints                         : Integer           read FMaxDataPoints;
    property MemoryUsed                            : Integer           read GetMemoryUsed;
    property Capacity                              : Integer           read FCapacity                write FCapacity;
    property RingBufferSize                        : Integer           read GetRingBufferSize        write SetRingBufferSize;

    property StoredTraceLineColor                  : TColor            read FStoredTraceLineColor    write FStoredTraceLineColor;
    property StoredTraceLineWidth                  : Integer           read FStoredTraceLineWidth    write FStoredTraceLineWidth;
    property StoredTraceLineStyle                  : TiPlotLineStyle   read FStoredTraceLineStyle    write FStoredTraceLineStyle;

    property StoredMarkerVisible                   : Boolean           read FStoredMarkerVisible     write FStoredMarkerVisible;
    property StoredMarkerSize                      : Integer           read FStoredMarkerSize        write FStoredMarkerSize;
    property StoredMarkerStyle                     : TiPlotMarkerStyle read FStoredMarkerStyle       write FStoredMarkerStyle;
    property StoredMarkerPenColor                  : TColor            read FStoredMarkerPenColor    write FStoredMarkerPenColor;
    property StoredMarkerPenWidth                  : Integer           read FStoredMarkerPenWidth    write FStoredMarkerPenWidth;
    property StoredMarkerPenStyle                  : TPenStyle         read FStoredMarkerPenStyle    write FStoredMarkerPenStyle;
    property StoredMarkerBrushColor                : TColor            read FStoredMarkerBrushColor  write FStoredMarkerBrushColor;
    property StoredMarkerBrushStyle                : TBrushStyle       read FStoredMarkerBrushStyle  write FStoredMarkerBrushStyle;
    property StoredMarkerCharacter                 : Char              read FStoredMarkerCharacter   write FStoredMarkerCharacter;

    property StoredBarVisible                      : Boolean           read FStoredBarVisible        write FStoredBarVisible;
    property StoredBarReference                    : Double            read FStoredBarReference      write FStoredBarReference;
    property StoredBarWidth                        : Double            read FStoredBarWidth          write FStoredBarWidth;
    property StoredBarPenColor                     : TColor            read FStoredBarPenColor       write FStoredBarPenColor;
    property StoredBarPenWidth                     : Integer           read FStoredBarPenWidth       write FStoredBarPenWidth;
    property StoredBarPenStyle                     : TPenStyle         read FStoredBarPenStyle       write FStoredBarPenStyle;
    property StoredBarBrushColor                   : TColor            read FStoredBarBrushColor     write FStoredBarBrushColor;
    property StoredBarBrushStyle                   : TBrushStyle       read FStoredBarBrushStyle     write FStoredBarBrushStyle;

    property Count                                 : Integer           read FCount                   write FCount;

    property X               [const Index: Integer]: Double            read GetX                     write SetX;
    property Y               [const Index: Integer]: Double            read GetY                     write SetY;

    property Null            [const Index: Integer]: Boolean           read GetNull                  write SetNull;
    property Empty           [const Index: Integer]: Boolean           read GetEmpty                 write SetEmpty;

    property High            [const Index: Integer]: Double            read GetHigh                  write SetHigh;
    property Low             [const Index: Integer]: Double            read GetLow                   write SetLow;
    property Open            [const Index: Integer]: Double            read GetOpen                  write SetOpen;
    property Close           [const Index: Integer]: Double            read GetClose                 write SetClose;

    property TraceLineColor  [const Index: Integer]: TColor            read GetTraceLineColor        write SetTraceLineColor;
    property TraceLineWidth  [const Index: Integer]: Integer           read GetTraceLineWidth        write SetTraceLineWidth;
    property TraceLineStyle  [const Index: Integer]: TiPlotLineStyle   read GetTraceLineStyle        write SetTraceLineStyle;

    property MarkerVisible   [const Index: Integer]: Boolean           read GetMarkerVisible         write SetMarkerVisible;
    property MarkerSize      [const Index: Integer]: Integer           read GetMarkerSize            write SetMarkerSize;
    property MarkerStyle     [const Index: Integer]: TiPlotMarkerStyle read GetMarkerStyle           write SetMarkerStyle;
    property MarkerPenColor  [const Index: Integer]: TColor            read GetMarkerPenColor        write SetMarkerPenColor;
    property MarkerPenWidth  [const Index: Integer]: Integer           read GetMarkerPenWidth        write SetMarkerPenWidth;
    property MarkerPenStyle  [const Index: Integer]: TPenStyle         read GetMarkerPenStyle        write SetMarkerPenStyle;
    property MarkerBrushColor[const Index: Integer]: TColor            read GetMarkerBrushColor      write SetMarkerBrushColor;
    property MarkerBrushStyle[const Index: Integer]: TBrushStyle       read GetMarkerBrushStyle      write SetMarkerBrushStyle;
    property MarkerCharacter [const Index: Integer]: Char              read GetMarkerCharacter       write SetMarkerCharacter;

    property BarVisible      [const Index: Integer]: Boolean           read GetBarVisible            write SetBarVisible;
    property BarReference    [const Index: Integer]: Double            read GetBarReference          write SetBarReference;
    property BarWidth        [const Index: Integer]: Double            read GetBarWidth              write SetBarWidth;
    property BarPenColor     [const Index: Integer]: TColor            read GetBarPenColor           write SetBarPenColor;
    property BarPenWidth     [const Index: Integer]: Integer           read GetBarPenWidth           write SetBarPenWidth;
    property BarPenStyle     [const Index: Integer]: TPenStyle         read GetBarPenStyle           write SetBarPenStyle;
    property BarBrushColor   [const Index: Integer]: TColor            read GetBarBrushColor         write SetBarBrushColor;
    property BarBrushStyle   [const Index: Integer]: TBrushStyle       read GetBarBrushStyle         write SetBarBrushStyle;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiPlotDataCustomList.Create;
begin
  FStoredBarVisible := True;
end;
//****************************************************************************************************************************************************
destructor TiPlotDataCustomList.Destroy;
begin
  FreeMemory;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCustomList.SetDataPointSize(Value: Integer);
begin
  FDataPointSize := Value;
  FMaxDataPoints := Maxint div FDataPointSize;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCustomList.Clear;
begin
  FCount := 0;
  FTail  := 0;
  if not FRingBufferEnabled then SetCapacity(0);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCustomList.Grow;
var
  Delta   : Integer;
begin
  if FCapacity > 64 then
    Delta := FCapacity div 4
  else
    if FCapacity > 8 then
      Delta := 16
    else
      Delta := 4;
  SetCapacity(FCapacity + Delta);
end;
//****************************************************************************************************************************************************
function TiPlotDataCustomList.GetRingBufferSize: Integer;
begin
  if FRingBufferEnabled then Result := FCapacity else Result := 0;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCustomList.SetRingBufferSize(const Value: Integer);
begin
  if (Value = 0) and FRingBufferEnabled then
    begin
      FRingBufferEnabled := False;
      if FTail <> 0 then Clear;
    end;

  if Value <> 0 then
    begin
      FRingBufferEnabled := True;
      if Value <> FCapacity then
        begin
          if FTail <> 0 then Clear;
          if Value > FCapacity then
            begin
              SetCapacity(Value);
            end
          else
            if Value < FCapacity then
              begin
                if FCount > Value then DeletePoints(FCount - Value);
                SetCapacity(Value);
              end;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotDataCustomList.GetMemoryUsed: Integer;
begin
  Result := FDataPointSize * FCapacity;
end;
//****************************************************************************************************************************************************
function TiPlotDataCustomList.GetActualIndex(Value: Integer): Integer;
begin
  if (Value < 0) or (Value >= Count) then raise Exception.Create('Index out of Bounds');

  if Tail <> 0 then
    begin
      Result := Value + Tail;
      if Result > (Count-1) then Result := Result - Count;
    end
  else Result := Value;
end;
//****************************************************************************************************************************************************
function TiPlotDataCustomList.GetEmpty            (const Index:Integer):Boolean;                      begin Result := False;     end;
function TiPlotDataCustomList.GetNull             (const Index:Integer):Boolean;                      begin Result := False;     end;
//****************************************************************************************************************************************************
function TiPlotDataCustomList.GetHigh             (const Index:Integer):Double;                       begin Result := 0;         end;
function TiPlotDataCustomList.GetLow              (const Index:Integer):Double;                       begin Result := 0;         end;
function TiPlotDataCustomList.GetOpen             (const Index:Integer):Double;                       begin Result := 0;         end;
function TiPlotDataCustomList.GetClose            (const Index:Integer):Double;                       begin Result := 0;         end;
//****************************************************************************************************************************************************
function TiPlotDataCustomList.GetTraceLineColor   (const Index:Integer):TColor;                       begin Result:=StoredTraceLineColor;  end;
function TiPlotDataCustomList.GetTraceLineStyle   (const Index:Integer):TiPlotLineStyle;              begin Result:=StoredTraceLineStyle;  end;
function TiPlotDataCustomList.GetTraceLineWidth   (const Index:Integer):Integer;                      begin Result:=StoredTraceLineWidth;  end;
function TiPlotDataCustomList.GetMarkerVisible    (const Index:Integer):Boolean;                      begin Result:=StoredMarkerVisible;   end;
function TiPlotDataCustomList.GetMarkerSize       (const Index:Integer):Integer;                      begin Result:=StoredMarkerSize;      end;
function TiPlotDataCustomList.GetMarkerStyle      (const Index:Integer):TiPlotMarkerStyle;            begin Result:=StoredMarkerStyle;     end;
function TiPlotDataCustomList.GetMarkerPenColor   (const Index:Integer):TColor;                       begin Result:=StoredMarkerPenColor;  end;
function TiPlotDataCustomList.GetMarkerPenWidth   (const Index:Integer):Integer;                      begin Result:=StoredMarkerPenWidth;  end;
function TiPlotDataCustomList.GetMarkerPenStyle   (const Index:Integer):TPenStyle;                    begin Result:=StoredMarkerPenStyle;  end;
function TiPlotDataCustomList.GetMarkerBrushColor (const Index:Integer):TColor;                       begin Result:=StoredMarkerBrushColor;end;
function TiPlotDataCustomList.GetMarkerBrushStyle (const Index:Integer):TBrushStyle;                  begin Result:=StoredMarkerBrushStyle;end;
function TiPlotDataCustomList.GetMarkerCharacter  (const Index:Integer):Char;                         begin Result:=StoredMarkerCharacter; end;
function TiPlotDataCustomList.GetBarVisible       (const Index:Integer):Boolean;                      begin Result:=StoredBarVisible;      end;
function TiPlotDataCustomList.GetBarReference     (const Index:Integer):Double;                       begin Result:=StoredBarReference;    end;
function TiPlotDataCustomList.GetBarWidth         (const Index:Integer):Double;                       begin Result:=StoredBarWidth;        end;
function TiPlotDataCustomList.GetBarPenColor      (const Index:Integer):TColor;                       begin Result:=StoredBarPenColor;     end;
function TiPlotDataCustomList.GetBarPenWidth      (const Index:Integer):Integer;                      begin Result:=StoredBarPenWidth;     end;
function TiPlotDataCustomList.GetBarPenStyle      (const Index:Integer):TPenStyle;                    begin Result:=StoredBarPenStyle;     end;
function TiPlotDataCustomList.GetBarBrushColor    (const Index:Integer):TColor;                       begin Result:=StoredBarBrushColor;   end;
function TiPlotDataCustomList.GetBarBrushStyle    (const Index:Integer):TBrushStyle;                  begin Result:=StoredBarBrushStyle;   end;
//****************************************************************************************************************************************************
procedure TiPlotDataCustomList.SetEmpty           (const Index:Integer;const Value:Boolean);          begin ;end;
procedure TiPlotDataCustomList.SetNull            (const Index:Integer;const Value:Boolean);          begin ;end;
//****************************************************************************************************************************************************
procedure TiPlotDataCustomList.SetHigh            (const Index:Integer;const Value:Double);           begin ;end;
procedure TiPlotDataCustomList.SetLow             (const Index:Integer;const Value:Double);           begin ;end;
procedure TiPlotDataCustomList.SetOpen            (const Index:Integer;const Value:Double);           begin ;end;
procedure TiPlotDataCustomList.SetClose           (const Index:Integer;const Value:Double);           begin ;end;
//****************************************************************************************************************************************************
procedure TiPlotDataCustomList.SetTraceLineColor  (const Index:Integer;const Value:TColor           );begin end;
procedure TiPlotDataCustomList.SetTraceLineStyle  (const Index:Integer;const Value:TiPlotLineStyle  );begin end;
procedure TiPlotDataCustomList.SetTraceLineWidth  (const Index:Integer;const Value:Integer          );begin end;
procedure TiPlotDataCustomList.SetMarkerVisible   (const Index:Integer;const Value:Boolean          );begin end;
procedure TiPlotDataCustomList.SetMarkerSize      (const Index:Integer;const Value:Integer          );begin end;
procedure TiPlotDataCustomList.SetMarkerStyle     (const Index:Integer;const Value:TiPlotMarkerStyle);begin end;
procedure TiPlotDataCustomList.SetMarkerPenColor  (const Index:Integer;const Value:TColor           );begin end;
procedure TiPlotDataCustomList.SetMarkerPenWidth  (const Index:Integer;const Value:Integer          );begin end;
procedure TiPlotDataCustomList.SetMarkerPenStyle  (const Index:Integer;const Value:TPenStyle        );begin end;
procedure TiPlotDataCustomList.SetMarkerBrushColor(const Index:Integer;const Value:TColor           );begin end;
procedure TiPlotDataCustomList.SetMarkerBrushStyle(const Index:Integer;const Value:TBrushStyle      );begin end;
procedure TiPlotDataCustomList.SetMarkerCharacter (const Index:Integer;const Value:Char             );begin end;
procedure TiPlotDataCustomList.SetBarVisible      (const Index:Integer;const Value:Boolean          );begin end;
procedure TiPlotDataCustomList.SetBarReference    (const Index:Integer;const Value:Double           );begin end;
procedure TiPlotDataCustomList.SetBarWidth        (const Index:Integer;const Value:Double           );begin end;
procedure TiPlotDataCustomList.SetBarPenColor     (const Index:Integer;const Value:TColor           );begin end;
procedure TiPlotDataCustomList.SetBarPenWidth     (const Index:Integer;const Value:Integer          );begin end;
procedure TiPlotDataCustomList.SetBarPenStyle     (const Index:Integer;const Value:TPenStyle        );begin end;
procedure TiPlotDataCustomList.SetBarBrushColor   (const Index:Integer;const Value:TColor           );begin end;
procedure TiPlotDataCustomList.SetBarBrushStyle   (const Index:Integer;const Value:TBrushStyle      );begin end;
//****************************************************************************************************************************************************
end.
