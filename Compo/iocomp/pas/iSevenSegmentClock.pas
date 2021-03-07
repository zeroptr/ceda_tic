{*******************************************************}
{                                                       }
{       TiSevenSegmentClock Component                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentClock;{$endif}
{$ifdef iCLX}unit QiSevenSegmentClock;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iSevenSegmentCharacter,  iSevenSegmentDisplay;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiSevenSegmentCharacter, QiSevenSegmentDisplay;{$ENDIF}

type

  TiSevenSegmentClock = class(TiSevenSegmentDisplay)
  private
    FStartTime           : TDateTime;
    FOriginalTime        : TDateTime;
    FTime                : Double;
    FShowSeconds         : Boolean;
    FShowHours           : Boolean;
    FHourStyle           : TiClockHourStyle;
    FCountDirection      : TiCountDirection;
    FOnCountDownComplete : TNotifyEvent;
    
    procedure SetTime             (const Value: Double);
    procedure SetShowHours        (const Value: Boolean);
    procedure SetShowSeconds      (const Value: Boolean);
    procedure SetHourStyle        (const Value: TiClockHourStyle);
    procedure SetHours            (const Value: Integer);
    procedure SetMinutes          (const Value: Integer);
    procedure SetSeconds          (const Value: Integer);
    procedure SetCountDirection   (const Value: TiCountDirection);
    procedure SetCountTimerEnabled(const Value: Boolean);

    function  GetCountTimerEnabled : Boolean;
    function  GetHours             : Integer;
    function  GetMinutes           : Integer;
    function  GetSeconds           : Integer;
  protected
    procedure iPaintTo(Canvas: TCanvas);     override;
    function  GetAutoSize : TPoint;          override;
    procedure TimerEvent(Sender : TObject);
    procedure DoChange;
  public
    constructor Create(AOwner: TComponent);  override;
    procedure   SetTimeNoEvent(const Value: Double);
    procedure   ResetToZero;
    procedure   SetTimeInSeconds(Value: Integer);

    property CountTimerEnabled   : Boolean          read GetCountTimerEnabled write SetCountTimerEnabled;
  published
    property Time                : Double           read FTime                write SetTime;
    property ShowSeconds         : Boolean          read FShowSeconds         write SetShowSeconds    default True;
    property ShowHours           : Boolean          read FShowHours           write SetShowHours      default True;
    property HourStyle           : TiClockHourStyle read FHourStyle           write SetHourStyle      default ichs24;
    property Hours               : Integer          read GetHours             write SetHours          default 0;
    property Minutes             : Integer          read GetMinutes           write SetMinutes        default 0;
    property Seconds             : Integer          read GetSeconds           write SetSeconds        default 0;
    property CountDirection      : TiCountDirection read FCountDirection      write SetCountDirection default icdDown;
    property OnCountDownComplete : TNotifyEvent     read FOnCountDownComplete write FOnCountDownComplete;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiSevenSegmentClock.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FShowSeconds := True;
  FShowHours   := True;

  OnInternalTimer := TimerEvent;

  DoAutoSize;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.DoChange;
begin
  if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Time');
  if Assigned(OnValueChange)     then OnValueChange(Self);
end;
//****************************************************************************************************************************************************
function TiSevenSegmentClock.GetAutoSize: TPoint;
var
  TotalWidth : Integer;
begin
  TotalWidth := 2*SegmentMargin - DigitSpacing;

  SevenSegmentCharacter.Character := '0';
  TotalWidth := TotalWidth +  (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing) * 2;

  if FShowHours then
    begin
      SevenSegmentCharacter.Character := '0';
      TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing) * 2;
      SevenSegmentCharacter.Character := ':';
      TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing);
    end;
  if ShowSeconds then
    begin
      SevenSegmentCharacter.Character := '0';
      TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing) * 2;
      SevenSegmentCharacter.Character := ':';
      TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing);
    end;

  Result.X  := TotalWidth;
  Result.Y := SevenSegmentCharacter.GetCharacterHeight + 2*SegmentMargin;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.SetTimeNoEvent(const Value: Double);
var
  TempOnValueChange : TNotifyEvent;
begin
  TempOnValueChange := OnValueChange;
  OnValueChange     := nil;
  try
    SetTime(Value);
  finally
    OnValueChange := TempOnValueChange;
  end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.SetTime(const Value: Double);
var
  CanEdit : Boolean;
begin
  if FTime <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Time', CanEdit);
      if CanEdit then
        begin
          FTime         := Value;
          FOriginalTime := FTime;
          FStartTime    := Now;
          InvalidateChange;
          DoChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.SetShowHours(const Value: Boolean);
begin
  if FShowHours <> Value then
    begin
      FShowHours := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.SetShowSeconds(const Value: Boolean);
begin
  if FShowSeconds <> Value then
    begin
      FShowSeconds := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.SetHourStyle(const Value: TiClockHourStyle);
begin
  if FHourStyle <> Value then
    begin
      FHourStyle := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
function TiSevenSegmentClock.GetHours: Integer;
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  DecodeTime(FTime, Hour, Min, Sec, MSec);
  Result := Hour + Trunc(FTime) * 24;
end;
//****************************************************************************************************************************************************
function TiSevenSegmentClock.GetMinutes: Integer;
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  DecodeTime(FTime, Hour, Min, Sec, MSec);
  Result := Min;
end;
//****************************************************************************************************************************************************
function TiSevenSegmentClock.GetSeconds: Integer;
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  DecodeTime(FTime, Hour, Min, Sec, MSec);
  Result := Sec;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.SetHours(const Value: Integer);
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  if (Value < 0) or (Value > 99) then raise Exception.Create('Hours must be in the range of 0-99');
  DecodeTime(FTime, Hour, Min, Sec, MSec);
  if Value <> Hour then
    begin
      FTime         := EncodeTime(Value mod 24, Min, Sec, MSec) + Int(FTime);
      FOriginalTime := FTime;
      FStartTime    := Now;
      InvalidateChange;
      if Assigned(OnValueChange) then OnValueChange(Self)
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.SetMinutes(const Value: Integer);
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  if (Value < 0) or (Value > 59) then raise Exception.Create('Minutes must be in the range of 0-59');
  DecodeTime(FTime, Hour, Min, Sec, MSec);
  if Value <> Min then
    begin
      FTime         := Trunc(FTime) + EncodeTime(Hour , Value, Sec, MSec) + Int(FTime);
      FOriginalTime := FTime;
      FStartTime    := Now;
      InvalidateChange;
      if Assigned(OnValueChange) then OnValueChange(Self)
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.SetSeconds(const Value: Integer);
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  if (Value < 0) or (Value > 59) then raise Exception.Create('Seconds must be in the range of 0-59');
  DecodeTime(FTime, Hour, Min, Sec, MSec);
  if Value <> Sec then
    begin
      FTime         := Trunc(FTime) + EncodeTime(Hour, Min, Value, MSec) + Int(FTime);
      FOriginalTime := FTime;
      FStartTime    := Now;
      InvalidateChange;
      if Assigned(OnValueChange) then OnValueChange(Self)
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.SetTimeInSeconds(Value: Integer);
var
  TotalLeft : Integer;
  Hour      : Word;
  Min       : Word;
  Sec       : Word;
  MSec      : Word;
begin
  MSec      := 0; 
  TotalLeft := Value;
  Hour      := TotalLeft div (60*60);
  TotalLeft := TotalLeft - Hour*(60*60);
  Min       := TotalLeft div 60;
  Sec       := TotalLeft - Min*60;
  FTime     := EncodeTime(Hour mod 24, Min, Sec, MSec);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.ResetToZero;
begin
  FTime := 0;
  CountTimerEnabled := False;
end;
//****************************************************************************************************************************************************
function TiSevenSegmentClock.GetCountTimerEnabled: Boolean;
begin
  Result := TimerRunning;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.SetCountDirection(const Value: TiCountDirection);
begin
  if FCountDirection <> Value then
    begin
      FCountDirection := Value;
      FOriginalTime   := FTime;
      FStartTime      := Now;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.SetCountTimerEnabled(const Value: Boolean);
begin
  case Value of
    False : TimerStop;
    True  : begin
              TimerStart(0, 100);
              FOriginalTime := FTime;
              FStartTime    := Now;
            end;  
  end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.TimerEvent(Sender : TObject);
var
  Done : Boolean;
begin
  InvalidateChange;
  case FCountDirection of
    icdDown : FTime := FOriginalTime - (Now - FStartTime);
    icdUp   : FTime := FOriginalTime + (Now - FStartTime);
  end;

  if FCountDirection = icdDown then
    begin
      Done := FTime <= 0;

      if Done then
        begin
          FTime := 0;
          CountTimerEnabled := False;
          if Assigned(OnCountDownComplete) then OnCountDownComplete(Self);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClock.iPaintTo(Canvas: TCanvas);
var
  OffsetPoint         : TPoint;
  Hour                : Word;
  Min                 : Word;
  Sec                 : Word;
  MSec                : Word;
  DigitWidth          : Integer;
  ColonWidth          : Integer;
  DigitCount          : Integer;
  ColonCount          : Integer;
  CenterOffset        : Integer;
  CharacterTotalWidth : Integer;
  AHeight             : Integer;
  Character           : TSevenSegmentCharacter;
begin
  SetupCharacter;
  DrawBackGround(Canvas, BackGroundColor);

  DigitCount := 2;
  ColonCount := 0;
  if FShowHours then
    begin
      DigitCount := DigitCount + 2;
      ColonCount := ColonCount + 1;
    end;
  if FShowSeconds then
    begin
      DigitCount := DigitCount + 2;
      ColonCount := ColonCount + 1;
    end;

  CharacterTotalWidth := Width - 2*SegmentMargin;

  DigitWidth := Trunc( (5*CharacterTotalWidth - 5*DigitSpacing*(DigitCount + ColonCount - 1))/(5*DigitCount + ColonCount));
  ColonWidth := DigitWidth div 5;
  AHeight    := Height - 2*SegmentMargin;

  CenterOffset := (Width - DigitCount*(DigitWidth + DigitSpacing) - ColonCount*(ColonWidth + DigitSpacing)+ DigitSpacing) div 2;

  OffsetPoint.x := CenterOffset;
  OffsetPoint.y := SegmentMargin;

  DecodeTime(FTime, Hour, Min, Sec, MSec);

  if FTime <= 99 then Hour := Hour + Trunc(FTime)*24;

  if FHourStyle = ichs12 then if Hour > 12 then Hour := Hour - 12;

  if FShowHours then
    begin
      if Hour > 9 then Character := TSevenSegmentCharacter(Hour div 10) else Character := ssc0;
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
      OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

      if Hour <> 0 then Hour := Hour - (Hour div 10)*10 else Hour := 0;
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, TSevenSegmentCharacter(Hour));
      OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, ColonWidth, AHeight, sscColon);
      OffsetPoint.x := OffsetPoint.x + ColonWidth + DigitSpacing;

    end;

    if Min > 9 then Character := TSevenSegmentCharacter(Min div 10) else Character := ssc0;
    SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
    OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

    if Min <> 0 then Min := Min - (Min div 10)*10 else Min := 0;
    SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, TSevenSegmentCharacter(Min));
    OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

  if FShowSeconds then
    begin
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, ColonWidth, AHeight, sscColon);
      OffsetPoint.x := OffsetPoint.x + ColonWidth + DigitSpacing;

      if Sec > 9 then Character := TSevenSegmentCharacter(Sec div 10) else Character := ssc0;
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
      OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

      if Sec <> 0 then Sec := Sec - (Sec div 10)*10 else Sec := 0;
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, TSevenSegmentCharacter(Sec));
      OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;
    end;
end;
//****************************************************************************************************************************************************
end.
