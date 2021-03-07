{*******************************************************}
{                                                       }
{       TiSevenSegmentCharacter Component               }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentCharacter;{$endif}
{$ifdef iCLX}unit QiSevenSegmentCharacter;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent;{$ENDIF}

type
  TSegment               = (segA, segB, segC, segD, segE, segF, segG);
  TSevenSegmentCharacter = (ssc0, ssc1, ssc2, ssc3, ssc4, ssc5, ssc6, ssc7, ssc8, ssc9, sscA, sscB, sscC, sscD, sscE, sscF,
                            sscPeriod, sscColon, sscPlus, sscMinus, sscBlank, sscLine, sscUpArrow, sscDownArrow, sscSemiColon, sscComma);
  TSegments = set of TSegment;

  TiSevenSegmentCharacter = class(TiCustomComponent)
  private
    FAutoSize            : Boolean;
    FSegmentMargin       : Integer;
    FShowOffSegments     : Boolean;
    FSegmentSeperation   : Integer;
    FSegmentSize         : Integer;
    FSegmentColor        : TColor;
    FValue               : TSevenSegmentCharacter;
    FPowerOff            : Boolean;
    FSegCOn              : Boolean;
    FSegDOn              : Boolean;
    FSegGOn              : Boolean;
    FSegAOn              : Boolean;
    FSegFOn              : Boolean;
    FSegBOn              : Boolean;
    FSegEOn              : Boolean;
    FUseSegmentBits      : Boolean;
    FAutoSegmentOffColor : Boolean;
    FSegmentOffColor     : TColor;
    FOnAutoSize          : TNotifyEvent;

    function  GetCharacter: Char;
    procedure DoAutoSize;
    procedure iSetAutoSize          (const Value: Boolean);
    procedure SetCharacter          (const AValue: Char);
    procedure SetSegmentMargin      (const Value: Integer);
    procedure SetSegmentSeperation  (const Value: Integer);
    procedure SetSegmentSize        (const Value: Integer);
    procedure SetSegmentColor       (const Value: TColor);
    procedure SetShowOffSegments    (const Value: Boolean);
    procedure SetValue              (const Value: TSevenSegmentCharacter);
    procedure SetPowerOff           (const Value: Boolean);
    procedure SetSegAOn             (const Value: Boolean);
    procedure SetSegBOn             (const Value: Boolean);
    procedure SetSegCOn             (const Value: Boolean);
    procedure SetSegDOn             (const Value: Boolean);
    procedure SetSegEOn             (const Value: Boolean);
    procedure SetSegFOn             (const Value: Boolean);
    procedure SetSegGOn             (const Value: Boolean);
    procedure SetUseSegmentBits     (const Value: Boolean);
    procedure SetAutoSegmentOffColor(const Value: Boolean);
    procedure SetSegmentOffColor    (const Value: TColor);
    function GetSegmentBits: Byte;
  protected
    procedure DrawSegments         (Canvas: TCanvas; OnColor, OffColor: TColor; Offset: TPoint; Segments: TSegments; AWidth, AHeight: Integer);
    procedure DrawSegmentA         (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentB         (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentC         (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentD         (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentE         (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentF         (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentG         (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentPeriod    (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentColon     (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentSemiColon (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentComma     (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentPlus      (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentMinus     (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentLine      (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentUpArrow   (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure DrawSegmentDownArrow (Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
    procedure iPaintTo(Canvas: TCanvas);     override;
    procedure DoChange;
  public
    constructor Create(AOwner: TComponent);  override;
    procedure   Draw(Canvas: TCanvas; OffsetPoint: TPoint; AWidth, AHeight: Integer; AValue : TSevenSegmentCharacter);
    function    GetCharacterWidth  : Integer;
    function    GetCharacterHeight : Integer;
    function    ConvertCharacterToValue(AChar : Char): TSevenSegmentCharacter;
    procedure   SetSegmentBits(Value: Byte);
    property    OnAutoSize       : TNotifyEvent           read FOnAutoSize          write FOnAutoSize;
  published
    property AutoSize            : Boolean                read FAutoSize            write iSetAutoSize            default True;
    property Character           : Char                   read GetCharacter         write SetCharacter;
    property PowerOff            : Boolean                read FPowerOff            write SetPowerOff             default False;
    property SegmentColor        : TColor                 read FSegmentColor        write SetSegmentColor         default clLime;
    property SegmentMargin       : Integer                read FSegmentMargin       write SetSegmentMargin        default 2;
    property SegmentSeperation   : Integer                read FSegmentSeperation   write SetSegmentSeperation    default 1;
    property SegmentSize         : Integer                read FSegmentSize         write SetSegmentSize          default 1;
    property ShowOffSegments     : Boolean                read FShowOffSegments     write SetShowOffSegments      default True;
    property SegmentBits         : Byte                   read GetSegmentBits       write SetSegmentBits          default 0;
    property UseSegmentBits      : Boolean                read FUseSegmentBits      write SetUseSegmentBits       default False;
    property SegAOn              : Boolean                read FSegAOn              write SetSegAOn               default False;
    property SegBOn              : Boolean                read FSegBOn              write SetSegBOn               default False;
    property SegCOn              : Boolean                read FSegCOn              write SetSegCOn               default False;
    property SegDOn              : Boolean                read FSegDOn              write SetSegDOn               default False;
    property SegEOn              : Boolean                read FSegEOn              write SetSegEOn               default False;
    property SegFOn              : Boolean                read FSegFOn              write SetSegFOn               default False;
    property SegGOn              : Boolean                read FSegGOn              write SetSegGOn               default False;
    property Value               : TSevenSegmentCharacter read FValue               write SetValue;
    property SegmentOffColor     : TColor                 read FSegmentOffColor     write SetSegmentOffColor      default $00008000;
    property AutoSegmentOffColor : Boolean                read FAutoSegmentOffColor write SetAutoSegmentOffColor  default True;
    property BackGroundColor                                                                                      default clBlack;
    property Transparent;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiSevenSegmentCharacter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FSegmentColor        := clLime;
  FSegmentOffColor     := $00008000;
  FAutoSegmentOffColor := True;

  BackGroundColor      := clBlack;

  FAutoSize            := True;
  FShowOffSegments     := True;
  FSegmentMargin       := 2;
  FSegmentSize         := 1;
  FSegmentSeperation   := 1;
  DoAutoSize;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DoChange;
begin
  if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Value');
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.SetSegAOn             (const Value:Boolean);begin SetBooleanProperty(Value,FSegAOn,             irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetSegBOn             (const Value:Boolean);begin SetBooleanProperty(Value,FSegBOn,             irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetSegCOn             (const Value:Boolean);begin SetBooleanProperty(Value,FSegCOn,             irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetSegDOn             (const Value:Boolean);begin SetBooleanProperty(Value,FSegDOn,             irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetSegEOn             (const Value:Boolean);begin SetBooleanProperty(Value,FSegEOn,             irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetSegFOn             (const Value:Boolean);begin SetBooleanProperty(Value,FSegFOn,             irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetSegGOn             (const Value:Boolean);begin SetBooleanProperty(Value,FSegGOn,             irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetUseSegmentBits     (const Value:Boolean);begin SetBooleanProperty(Value,FUseSegmentBits,     irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetAutoSegmentOffColor(const Value:Boolean);begin SetBooleanProperty(Value,FAutoSegmentOffColor,irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetShowOffSegments    (const Value:Boolean);begin SetBooleanProperty(Value,FShowOffSegments,    irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetPowerOff           (const Value:Boolean);begin SetBooleanProperty(Value,FPowerOff,           irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetSegmentOffColor    (const Value:TColor );begin SetColorProperty  (Value,FSegmentOffColor,    irtInvalidate);end;
procedure TiSevenSegmentCharacter.SetSegmentColor       (const Value:TColor );begin SetColorProperty  (Value,FSegmentColor,       irtInvalidate);end;
//****************************************************************************************************************************************************
function TiSevenSegmentCharacter.GetCharacterWidth : Integer;
begin
  case FValue of
    sscPeriod    : Result := 2*FSegmentMargin + FSegmentSize * 2;
    sscColon     : Result := 2*FSegmentMargin + FSegmentSize * 2;
    sscSemiColon : Result := 2*FSegmentMargin + FSegmentSize * 2;
    sscComma     : Result := 2*FSegmentMargin + FSegmentSize * 2;
    else           Result := 2*FSegmentMargin + FSegmentSize * 10;
  end;
end;
//****************************************************************************************************************************************************
function TiSevenSegmentCharacter.GetCharacterHeight : Integer;
begin
  Result := 2*FSegmentMargin + FSegmentSize * 18;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DoAutoSize;
begin
  if not Loading then
    begin
      if FAutoSize then
        begin
          Height := GetCharacterHeight + 1;
          Width  := GetCharacterWidth  + 1;

          if Assigned(FOnAutoSize) then FOnAutoSize(Self);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.SetValue(const Value : TSevenSegmentCharacter);
var
  CanEdit : Boolean;
begin
  if FValue <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Value', CanEdit);
      if CanEdit then
        begin
          FValue := Value;
          InvalidateChange;
          DoAutoSize;
          DoChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.SetSegmentSize(const Value : Integer);
begin
  if FSegmentSize <> Value then
    begin
      FSegmentSize := Value;
      if FSegmentSize < 1 then FSegmentSize := 1;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.SetSegmentSeperation(const Value : Integer);
begin
  if FSegmentSeperation <> Value then
    begin
      FSegmentSeperation := Value;
      if FSegmentSeperation < 0 then FSegmentSeperation := 0;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.SetSegmentMargin(const Value : Integer);
begin
  if FSegmentMargin <> Value then
    begin
      FSegmentMargin := Value;
      if FSegmentMargin < 0 then FSegmentMargin := 0;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
function TiSevenSegmentCharacter.ConvertCharacterToValue(AChar : Char): TSevenSegmentCharacter;
begin
  case AChar of
    '0'      : Result := ssc0;
    '1'      : Result := ssc1;
    '2'      : Result := ssc2;
    '3'      : Result := ssc3;
    '4'      : Result := ssc4;
    '5'      : Result := ssc5;
    '6'      : Result := ssc6;
    '7'      : Result := ssc7;
    '8'      : Result := ssc8;
    '9'      : Result := ssc9;
    'a', 'A' : Result := sscA;
    'b', 'B' : Result := sscB;
    'c', 'C' : Result := sscC;
    'd', 'D' : Result := sscD;
    'e', 'E' : Result := sscE;
    'f', 'F' : Result := sscF;
    ' '      : Result := sscBlank;
    '.'      : Result := sscPeriod;
    '+'      : Result := sscPlus;
    '-'      : Result := sscMinus;
    ':'      : Result := sscColon;
    ';'      : Result := sscSemiColon;
    ','      : Result := sscComma;
    '_'      : Result := sscLine;
    '<'      : Result := sscUpArrow;
    '>'      : Result := sscDownArrow;
    else       Result := sscBlank;
  end;
end;
//****************************************************************************************************************************************************
function TiSevenSegmentCharacter.GetCharacter: Char;
begin
  case FValue of
    ssc0         : Result := '0';
    ssc1         : Result := '1';
    ssc2         : Result := '2';
    ssc3         : Result := '3';
    ssc4         : Result := '4';
    ssc5         : Result := '5';
    ssc6         : Result := '6';
    ssc7         : Result := '7';
    ssc8         : Result := '8';
    ssc9         : Result := '9';
    sscA         : Result := 'a';
    sscB         : Result := 'b';
    sscC         : Result := 'c';
    sscD         : Result := 'd';
    sscE         : Result := 'e';
    sscF         : Result := 'f';
    sscBlank     : Result := ' ';
    sscPeriod    : Result := '.';
    sscPlus      : Result := '+';
    sscMinus     : Result := '-';
    sscColon     : Result := ':';
    sscSemiColon : Result := ';';
    sscComma     : Result := ',';
    sscLine      : Result := '_';
    sscUpArrow   : Result := '<';
    sscDownArrow : Result := '>';
    else           Result := '?';
  end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.SetCharacter(const AValue: Char);
begin
  Value := ConvertCharacterToValue(AValue);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.iPaintTo(Canvas: TCanvas);
var
  OffsetPoint : TPoint;
begin
  DrawBackGround(Canvas, BackGroundColor);
  OffsetPoint := Point(0, 0);
  Draw(Canvas, OffsetPoint, Width, Height, FValue);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.Draw(Canvas: TCanvas; OffsetPoint: TPoint; AWidth, AHeight: Integer; AValue : TSevenSegmentCharacter);
var
  OnColor, OffColor : TColor;
  Segments          : TSegments;
begin
  if AutoSegmentOffColor then OffColor  := $02000000 + DimColor(SegmentColor,3)
    else OffColor := FSegmentOffColor;

  OnColor   := $02000000 + FSegmentColor;

  if FPowerOff then OnColor := OffColor;

  if FUseSegmentBits then
    begin
      Segments := [];
      if SegAOn then Segments := Segments + [segA];
      if SegBOn then Segments := Segments + [segB];
      if SegCOn then Segments := Segments + [segC];
      if SegDOn then Segments := Segments + [segD];
      if SegEOn then Segments := Segments + [segE];
      if SegFOn then Segments := Segments + [segF];
      if SegGOn then Segments := Segments + [segG];
      DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, Segments, AWidth, AHeight);
    end
  else case AValue of
    ssc0         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segB, segC, segD, segE, segF      ],AWidth,AHeight);   //                A
    ssc1         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segB, segC                              ],AWidth,AHeight);   //                --
    ssc2         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segB, segD, segE, segG            ],AWidth,AHeight);   //               |  |
    ssc3         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segB, segC, segD, segG            ],AWidth,AHeight);   //             F |  | B          . = H
    ssc4         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segB, segC, segF, segG                  ],AWidth,AHeight);   //                --             : = I
    ssc5         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segC, segD, segF, segG            ],AWidth,AHeight);   //               |G |            + = J
    ssc6         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segC, segD, segE, segF, segG      ],AWidth,AHeight);   //             E |  | C          - = K
    ssc7         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segB, segC                        ],AWidth,AHeight);   //                --             _ = L
    ssc8         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segB, segC, segD, segE, segF, segG],AWidth,AHeight);   //                D      UpArrow   = M
    ssc9         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segB, segC, segF, segG            ],AWidth,AHeight);   //                       DownArrow = N
    sscA         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segB, segC, segE, segF, SegG      ],AWidth,AHeight);   //
    sscB         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segC, segD, segE, segF, segG            ],AWidth,AHeight);   //              5x9
    sscC         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segD, segF, segE                  ],AWidth,AHeight);
    sscD         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segB, segC, segD, segE, segG            ],AWidth,AHeight);
    sscE         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segD, segE, segF, segG            ],AWidth,AHeight);
    sscF         : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [segA, segE, segF, segG                  ],AWidth,AHeight);
    sscBlank     : DrawSegments(Canvas, OnColor, OffColor, OffsetPoint, [                                        ],AWidth,AHeight);

    sscPeriod    : DrawSegmentPeriod   (Canvas, OffsetPoint, OnColor,AWidth,AHeight);
    sscColon     : DrawSegmentColon    (Canvas, OffsetPoint, OnColor,AWidth,AHeight);
    sscSemiColon : DrawSegmentSemiColon(Canvas, OffsetPoint, OnColor,AWidth,AHeight);
    sscComma     : DrawSegmentComma    (Canvas, OffsetPoint, OnColor,AWidth,AHeight);
    sscPlus      : begin
                     DrawSegmentPlus(Canvas, OffsetPoint, OnColor,AWidth,AHeight);
                     if FShowOffSegments then DrawSegmentMinus(Canvas, OffsetPoint, OffColor,AWidth,AHeight);
                   end;
    sscMinus     : begin
                     DrawSegmentMinus(Canvas, OffsetPoint, OnColor,AWidth,AHeight);
                     if FShowOffSegments then DrawSegmentPlus(Canvas, OffsetPoint, OffColor,AWidth,AHeight);
                   end;
    sscLine      : DrawSegmentLine(Canvas, OffsetPoint, OnColor,AWidth,AHeight);
    sscUpArrow   : DrawSegmentUpArrow(Canvas, OffsetPoint, OnColor,AWidth,AHeight);
    sscDownArrow : DrawSegmentDownArrow(Canvas, OffsetPoint, OnColor,AWidth,AHeight);
  end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegments(Canvas: TCanvas; OnColor, OffColor: TColor; Offset: TPoint; Segments: TSegments; AWidth, AHeight: Integer);
begin
  if segA in Segments then DrawSegmentA(Canvas,Offset,OnColor,AWidth,AHeight) else if FShowOffSegments then DrawSegmentA(Canvas,Offset,OffColor,AWidth,AHeight);
  if segB in Segments then DrawSegmentB(Canvas,Offset,OnColor,AWidth,AHeight) else if FShowOffSegments then DrawSegmentB(Canvas,Offset,OffColor,AWidth,AHeight);
  if segC in Segments then DrawSegmentC(Canvas,Offset,OnColor,AWidth,AHeight) else if FShowOffSegments then DrawSegmentC(Canvas,Offset,OffColor,AWidth,AHeight);
  if segD in Segments then DrawSegmentD(Canvas,Offset,OnColor,AWidth,AHeight) else if FShowOffSegments then DrawSegmentD(Canvas,Offset,OffColor,AWidth,AHeight);
  if segE in Segments then DrawSegmentE(Canvas,Offset,OnColor,AWidth,AHeight) else if FShowOffSegments then DrawSegmentE(Canvas,Offset,OffColor,AWidth,AHeight);
  if segF in Segments then DrawSegmentF(Canvas,Offset,OnColor,AWidth,AHeight) else if FShowOffSegments then DrawSegmentF(Canvas,Offset,OffColor,AWidth,AHeight);
  if segG in Segments then DrawSegmentG(Canvas,Offset,OnColor,AWidth,AHeight) else if FShowOffSegments then DrawSegmentG(Canvas,Offset,OffColor,AWidth,AHeight);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentA(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x +              FSegmentMargin + FSegmentSeperation,                      Offset.y + FSegmentMargin                 ),
               Point(Offset.x + AWidth - 1 - FSegmentMargin - FSegmentSeperation,                      Offset.y + FSegmentMargin                 ),
               Point(Offset.x + AWidth - 1 - FSegmentMargin - FSegmentSeperation - FSegmentSize *  2 , Offset.y + FSegmentMargin + 2*FSegmentSize),
               Point(Offset.x +              FSegmentMargin + FSegmentSeperation + FSegmentSize *  2 , Offset.y + FSegmentMargin + 2*FSegmentSize)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentB(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x + AWidth - 1 - FSegmentMargin,                     Offset.y + FSegmentMargin      + FSegmentSeperation                    ),
               Point(Offset.x + AWidth - 1 - FSegmentMargin,                     Offset.y + (AHeight - 1) div 2 - FSegmentSeperation                    ),
               Point(Offset.x + AWidth - 1 - FSegmentMargin - FSegmentSize *  2, Offset.y + (AHeight - 1) div 2 - FSegmentSeperation - FSegmentSize *  2),
               Point(Offset.x + AWidth - 1 - FSegmentMargin - FSegmentSize *  2, Offset.y + FSegmentMargin      + FSegmentSeperation + FSegmentSize *  2)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentC(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x + AWidth - 1 - FSegmentMargin,                     Offset.y + (AHeight - 1) div 2                  + FSegmentSeperation                    ),
               Point(Offset.x + AWidth - 1 - FSegmentMargin,                     Offset.y + (AHeight - 1)       - FSegmentMargin - FSegmentSeperation                    ),
               Point(Offset.x + AWidth - 1 - FSegmentMargin - FSegmentSize *  2, Offset.y + (AHeight - 1)       - FSegmentMargin - FSegmentSeperation - FSegmentSize *  2),
               Point(Offset.x + AWidth - 1 - FSegmentMargin - FSegmentSize *  2, Offset.y + (AHeight - 1) div 2                  + FSegmentSeperation + FSegmentSize *  2)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentD(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x +              FSegmentMargin + FSegmentSeperation,                      Offset.y + AHeight - 1 - FSegmentMargin                 ),
               Point(Offset.x + AWidth - 1 - FSegmentMargin - FSegmentSeperation,                      Offset.y + AHeight - 1 - FSegmentMargin                 ),
               Point(Offset.x + AWidth - 1 - FSegmentMargin - FSegmentSeperation - FSegmentSize *  2 , Offset.y + AHeight - 1 - FSegmentMargin - 2*FSegmentSize),
               Point(Offset.x +              FSegmentMargin + FSegmentSeperation + FSegmentSize *  2 , Offset.y + AHeight - 1 - FSegmentMargin - 2*FSegmentSize)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentE(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x + FSegmentMargin,                     Offset.y + (AHeight - 1) div 2 +                  FSegmentSeperation                    ),
               Point(Offset.x + FSegmentMargin,                     Offset.y + (AHeight - 1)       - FSegmentMargin - FSegmentSeperation                    ),
               Point(Offset.x + FSegmentMargin + FSegmentSize *  2, Offset.y + (AHeight - 1)       - FSegmentMargin - FSegmentSeperation - FSegmentSize *  2),
               Point(Offset.x + FSegmentMargin + FSegmentSize *  2, Offset.y + (AHeight - 1) div 2 +                  FSegmentSeperation + FSegmentSize *  2)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentF(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x + FSegmentMargin,                     Offset.y + FSegmentMargin      + FSegmentSeperation                    ),
               Point(Offset.x + FSegmentMargin,                     Offset.y + (AHeight - 1) div 2 - FSegmentSeperation                    ),
               Point(Offset.x + FSegmentMargin + FSegmentSize *  2, Offset.y + (AHeight - 1) div 2 - FSegmentSeperation - FSegmentSize *  2),
               Point(Offset.x + FSegmentMargin + FSegmentSize *  2, Offset.y + FSegmentMargin      + FSegmentSeperation + FSegmentSize *  2)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentG(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x +              FSegmentMargin + FSegmentSeperation,                Offset.y + (AHeight - 1) div 2               ),
               Point(Offset.x +              FSegmentMargin + FSegmentSeperation + FSegmentSize, Offset.y + (AHeight - 1) div 2 - FSegmentSize),
               Point(Offset.x + AWidth - 1 - FSegmentMargin - FSegmentSeperation - FSegmentSize, Offset.y + (AHeight - 1) div 2 - FSegmentSize),
               Point(Offset.x + AWidth - 1 - FSegmentMargin - FSegmentSeperation               , Offset.y + (AHeight - 1) div 2               ),
               Point(Offset.x + AWidth - 1 - FSegmentMargin - FSegmentSeperation - FSegmentSize, Offset.y + (AHeight - 1) div 2 + FSegmentSize),
               Point(Offset.x +              FSegmentMargin + FSegmentSeperation + FSegmentSize, Offset.y + (AHeight - 1) div 2 + FSegmentSize)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentColon(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + Round(AHeight *  5/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  5/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  7/18)),
               Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + Round(AHeight *  7/18))]);
      Polygon([Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + Round(AHeight *  11/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  11/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  13/18)),
               Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + Round(AHeight *  13/18))]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentSemiColon(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + Round(AHeight *  5/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  5/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  7/18)),
               Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + Round(AHeight *  7/18))]);
      Polygon([Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + Round(AHeight *  11/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  11/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  13/18)),
               Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + Round(AHeight *  13/18))]);

      Polygon([Point(Offset.x + AWidth div 2                     , Offset.y + Round(AHeight *  13/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  13/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  16/18)),
               Point(Offset.x + AWidth div 2                     , Offset.y + Round(AHeight *  16/18))]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentPeriod(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + AHeight - 2*FSegmentSize),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + AHeight - 2*FSegmentSize),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + AHeight                 ),
               Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + AHeight                 )]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentComma(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + Round(AHeight *  11/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  11/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  13/18)),
               Point(Offset.x + AWidth div 2 - (FSegmentSize * 1), Offset.y + Round(AHeight *  13/18))]);

      Polygon([Point(Offset.x + AWidth div 2                     , Offset.y + Round(AHeight *  13/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  13/18)),
               Point(Offset.x + AWidth div 2 + (FSegmentSize * 1), Offset.y + Round(AHeight *  16/18)),
               Point(Offset.x + AWidth div 2                     , Offset.y + Round(AHeight *  16/18))]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentPlus(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x + Round(AWidth * 2.5/10),               Offset.y + Round(AHeight*4.5/18 - 0.5*FSegmentSize)),
               Point(Offset.x + Round(AWidth * 7.5/10),               Offset.y + Round(AHeight*4.5/18 - 0.5*FSegmentSize)),
               Point(Offset.x + Round(AWidth * 7.5/10),               Offset.y + Round(AHeight*4.5/18 + 0.5*FSegmentSize)),
               Point(Offset.x + Round(AWidth * 2.5/10),               Offset.y + Round(AHeight*4.5/18 + 0.5*FSegmentSize))]);

      Polygon([Point(Offset.x + Round(AWidth*0.5 - 0.5*FSegmentSize), Offset.y + Round(AHeight*2.0/18)),
               Point(Offset.x + Round(AWidth*0.5 + 0.5*FSegmentSize), Offset.y + Round(AHeight*2.0/18)),
               Point(Offset.x + Round(AWidth*0.5 + 0.5*FSegmentSize), Offset.y + Round(AHeight*7.0/18)),
               Point(Offset.x + Round(AWidth*0.5 - 0.5*FSegmentSize), Offset.y + Round(AHeight*7.0/18))]);

    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentMinus(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x + Round(AWidth * 2.5/10), Offset.y + Round(AHeight*13.5/18 - 0.5*FSegmentSize)),
               Point(Offset.x + Round(AWidth * 7.5/10), Offset.y + Round(AHeight*13.5/18 - 0.5*FSegmentSize)),
               Point(Offset.x + Round(AWidth * 7.5/10), Offset.y + Round(AHeight*13.5/18 + 0.5*FSegmentSize)),
               Point(Offset.x + Round(AWidth * 2.5/10), Offset.y + Round(AHeight*13.5/18 + 0.5*FSegmentSize))]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentLine(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
begin
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;
      Polygon([Point(Offset.x + FSegmentMargin,            Offset.y + (AHeight-1) div 2 - FSegmentSize div 2),
               Point(Offset.x + AWidth-1 - FSegmentMargin, Offset.y + (AHeight-1) div 2 - FSegmentSize div 2),
               Point(Offset.x + AWidth-1 - FSegmentMargin, Offset.y + (AHeight-1) div 2 + FSegmentSize div 2),
               Point(Offset.x + FSegmentMargin,            Offset.y + (AHeight-1) div 2 + FSegmentSize div 2)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentUpArrow(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
var
  HalfWidth : Integer;
begin
  HalfWidth := (AWidth - 1 - 2*FSegmentMargin) div 2;
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;

      if (AHeight div 2 - HalfWidth) > FSegmentMargin then
        Polygon([Point(Offset.x + (AWidth-1) div 2 + HalfWidth, Offset.y + AHeight div 2            ),
                 Point(Offset.x + (AWidth-1) div 2 - HalfWidth, Offset.y + AHeight div 2            ),
                 Point(Offset.x + (AWidth-1) div 2            , Offset.y + AHeight div 2 - HalfWidth)])
      else
        Polygon([Point(Offset.x + (AWidth-1) div 2 + HalfWidth, Offset.y + AHeight div 2            ),
                 Point(Offset.x + (AWidth-1) div 2 - HalfWidth, Offset.y + AHeight div 2            ),
                 Point(Offset.x + (AWidth-1) div 2            , Offset.y + FSegmentMargin           )]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.DrawSegmentDownArrow(Canvas: TCanvas; Offset: TPoint; AColor: TColor; AWidth, AHeight: Integer);
var
  HalfWidth : Integer;
begin
  HalfWidth := (AWidth - 1 - 2*FSegmentMargin) div 2;
  with Canvas do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;

      if (AHeight div 2 + HalfWidth) < (AHeight - 1 - FSegmentMargin) then
        Polygon([Point(Offset.x + (AWidth-1) div 2 + HalfWidth, Offset.y + AHeight div 2                 ),
                 Point(Offset.x + (AWidth-1) div 2 - HalfWidth, Offset.y + AHeight div 2                 ),
                 Point(Offset.x + (AWidth-1) div 2            , Offset.y + AHeight div 2 + HalfWidth     )])
      else
        Polygon([Point(Offset.x + (AWidth-1) div 2 + HalfWidth, Offset.y + AHeight div 2                 ),
                 Point(Offset.x + (AWidth-1) div 2 - HalfWidth, Offset.y + AHeight div 2                 ),
                 Point(Offset.x + (AWidth-1) div 2            , Offset.y + AHeight - 1 - FSegmentMargin  )]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacter.SetSegmentBits(Value: Byte);
begin
  FSegAOn := Value and $01 <> 0;
  FSegBOn := Value and $02 <> 0;
  FSegCOn := Value and $04 <> 0;
  FSegDOn := Value and $08 <> 0;
  FSegEOn := Value and $10 <> 0;
  FSegFOn := Value and $20 <> 0;
  FSegGOn := Value and $40 <> 0;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiSevenSegmentCharacter.GetSegmentBits: Byte;
begin
  Result := 0;
  if FSegAOn then Result := Result or $01;
  if FSegBOn then Result := Result or $02;
  if FSegCOn then Result := Result or $04;
  if FSegDOn then Result := Result or $08;
  if FSegEOn then Result := Result or $10;
  if FSegFOn then Result := Result or $20;
  if FSegGOn then Result := Result or $40;
end;
//****************************************************************************************************************************************************
end.
