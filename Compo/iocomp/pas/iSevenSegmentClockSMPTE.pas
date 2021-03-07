{*******************************************************}
{                                                       }
{       TiSevenSegmentClockSMPTE Component              }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentClockSMPTE;{$endif}
{$ifdef iCLX}unit QiSevenSegmentClockSMPTE;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iSevenSegmentCharacter,  iSevenSegmentDisplay;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiSevenSegmentCharacter, QiSevenSegmentDisplay;{$ENDIF}

type
  TiFrameStyle = (ifsDropFrame, ifsNonDropFrame);
  TiSevenSegmentClockSMPTE = class(TiSevenSegmentDisplay)     
  private
    FTime            : Double;
    FHourStyle       : TiClockHourStyle;
    FShowFrameNumber : Boolean;
    FShowFieldNumber : Boolean;
    FFrameNumber     : Integer;
    FFieldNumber     : Integer;
    FFrameStyle      : TiFrameStyle;
    procedure SetTime           (const Value: Double);
    procedure SetHourStyle      (const Value: TiClockHourStyle);
    procedure SetShowFrameNumber(const Value: Boolean);
    procedure SetShowFieldNumber(const Value: Boolean);
    procedure SetFrameNumber    (const Value: Integer);
    procedure SetFieldNumber    (const Value: Integer);
    procedure SetFrameStyle     (const Value: TiFrameStyle);
    procedure SetHours          (const Value: Integer);
    procedure SetMinutes        (const Value: Integer);
    procedure SetSeconds        (const Value: Integer);
    function GetHours   : Integer;
    function GetMinutes : Integer;
    function GetSeconds : Integer;
  protected
    procedure iPaintTo(Canvas: TCanvas);     override;
    function  GetAutoSize : TPoint;          override;
    procedure DoChange;
 public
    constructor Create(AOwner: TComponent);  override;
    procedure   SetTimeNoEvent(const Value: Double);
  published
    property Time            : Double            read FTime            write SetTime;
    property FrameNumber     : Integer           read FFrameNumber     write SetFrameNumber     default 0;
    property FieldNumber     : Integer           read FFieldNumber     write SetFieldNumber     default 0;
    property FrameStyle      : TiFrameStyle      read FFrameStyle      write SetFrameStyle      default ifsDropFrame;
    property ShowFrameNumber : Boolean           read FShowFrameNumber write SetShowFrameNumber default True;
    property ShowFieldNumber : Boolean           read FShowFieldnumber write SetShowFieldNumber default True;
    property HourStyle       : TiClockHourStyle  read FHourStyle       write SetHourStyle       default ichs24;
    property Hours           : Integer           read GetHours         write SetHours           default 0;
    property Minutes         : Integer           read GetMinutes       write SetMinutes         default 0;
    property Seconds         : Integer           read GetSeconds       write SetSeconds         default 0;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiSevenSegmentClockSMPTE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FShowFrameNumber := True;
  FShowFieldNumber := True;

  DoAutoSize;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTE.DoChange;
begin
  if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Time');
  if Assigned(OnValueChange)     then OnValueChange(Self);
end;
//****************************************************************************************************************************************************
function TiSevenSegmentClockSMPTE.GetAutoSize: TPoint;
var
  TotalWidth : Integer;
begin
  TotalWidth := 2*SegmentMargin - DigitSpacing;

  SevenSegmentCharacter.Character := '0';
  TotalWidth := TotalWidth +  (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing) * 2;

  SevenSegmentCharacter.Character := '0';
  TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing) * 2;
  SevenSegmentCharacter.Character := ':';
  TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing);

  SevenSegmentCharacter.Character := '0';
  TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing) * 2;
  SevenSegmentCharacter.Character := ':';
  TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing);

  if FShowFrameNumber then
    begin
      SevenSegmentCharacter.Character := '0';
      TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing) * 2;
      SevenSegmentCharacter.Character := ':';
      TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing);
    end;

  if FShowFieldNumber then
    begin
      SevenSegmentCharacter.Character := '0';
      TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing) * 2;
      SevenSegmentCharacter.Character := '.';
      TotalWidth := TotalWidth + (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing);
    end;


  Result.X := TotalWidth;
  Result.Y := SevenSegmentCharacter.GetCharacterHeight + 2*SegmentMargin;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTE.SetTimeNoEvent(const Value: Double);
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
procedure TiSevenSegmentClockSMPTE.SetTime(const Value: Double);
var
  CanEdit : Boolean;
begin
  if FTime <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Time', CanEdit);
      if CanEdit then
        begin
          FTime := Value;
          InvalidateChange;
          DoChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTE.SetHours(const Value: Integer);
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  if (Value < 0) or (Value > 23) then raise Exception.Create('Hours must be in the range of 0-23');
  DecodeTime(FTime, Hour, Min, Sec, MSec);
  if Value <> Hour then
    begin
      FTime := EncodeTime(Value, Min, Sec, MSec);
      InvalidateChange;
      if Assigned(OnValueChange) then OnValueChange(Self)
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTE.SetMinutes(const Value: Integer);
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
      FTime := EncodeTime(Hour, Value, Sec, MSec);
      InvalidateChange;
      if Assigned(OnValueChange) then OnValueChange(Self)
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTE.SetSeconds(const Value: Integer);
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
      FTime := EncodeTime(Hour, Min, Value, MSec);
      InvalidateChange;
      if Assigned(OnValueChange) then OnValueChange(Self)
    end;
end;
//****************************************************************************************************************************************************
function TiSevenSegmentClockSMPTE.GetHours: Integer;
var
  Hour : Word;
  Min  : Word;
  Sec  : Word;
  MSec : Word;
begin
  DecodeTime(FTime, Hour, Min, Sec, MSec);
  Result := Hour;
end;
//****************************************************************************************************************************************************
function TiSevenSegmentClockSMPTE.GetMinutes: Integer;
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
function TiSevenSegmentClockSMPTE.GetSeconds: Integer;
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
procedure TiSevenSegmentClockSMPTE.SetFrameNumber(const Value: Integer);
begin
  if FFrameNumber <> Value then
    begin
      FFrameNumber := Value;
      InvalidateChange;
      if Assigned(OnValueChange) then OnValueChange(Self)
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTE.SetFieldNumber(const Value: Integer);
begin
  if FFieldNumber <> Value then
    begin
      FFieldNumber := Value;
      InvalidateChange;
      if Assigned(OnValueChange) then OnValueChange(Self)
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTE.SetShowFrameNumber(const Value: Boolean);
begin
  if FShowFrameNumber <> Value then
    begin
      FShowFrameNumber := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTE.SetShowFieldNumber(const Value: Boolean);
begin
  if FShowFieldNumber <> Value then
    begin
      FShowFieldNumber := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTE.SetHourStyle(const Value: TiClockHourStyle);
begin
  if FHourStyle <> Value then
    begin
      FHourStyle := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTE.SetFrameStyle(const Value: TiFrameStyle);
begin
  if FFrameStyle <> Value then
    begin
      FFrameStyle := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentClockSMPTE.iPaintTo(Canvas: TCanvas);
var
  OffsetPoint         : TPoint;
  Hour                : Word;
  Min                 : Word;
  Sec                 : Word;
  MSec                : Word;
  FrameNumberTemp     : Integer;
  FieldNumberTemp     : Integer;
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

  DigitCount := 6;
  ColonCount := 2;
  if FShowFrameNumber then
    begin
      DigitCount := DigitCount + 2;
      ColonCount := ColonCount + 1;
    end;
  if FShowFieldNumber then
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

  if FHourStyle = ichs12 then if Hour > 12 then Hour := Hour - 12;

  if Hour > 9 then Character := TSevenSegmentCharacter(Hour div 10) else Character := ssc0;
  SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
  OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

  if Hour <> 0 then Hour := Hour - (Hour div 10)*10 else Hour := 0;
  SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, TSevenSegmentCharacter(Hour));
  OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

  SevenSegmentCharacter.Draw(Canvas, OffsetPoint, ColonWidth, AHeight, sscColon);
  OffsetPoint.x := OffsetPoint.x + ColonWidth + DigitSpacing;

  if Min > 9 then Character := TSevenSegmentCharacter(Min div 10) else Character := ssc0;
  SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
  OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

  if Min <> 0 then Min := Min - (Min div 10)*10 else Min := 0;
  SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, TSevenSegmentCharacter(Min));
  OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

  SevenSegmentCharacter.Draw(Canvas, OffsetPoint, ColonWidth, AHeight, sscColon);
  OffsetPoint.x := OffsetPoint.x + ColonWidth + DigitSpacing;

  if Sec > 9 then Character := TSevenSegmentCharacter(Sec div 10) else Character := ssc0;
  SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
  OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

  if Sec <> 0 then Sec := Sec - (Sec div 10)*10 else Sec := 0;
  SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, TSevenSegmentCharacter(Sec));
  OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

  if FShowFrameNumber then
    begin
      case FFrameStyle of
        ifsDropFrame : Character := sscSemiColon;
        else           Character := sscColon;
      end;
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, ColonWidth, AHeight, Character);
      OffsetPoint.x := OffsetPoint.x + ColonWidth + DigitSpacing;

      if FFrameNumber > 9 then Character := TSevenSegmentCharacter(FFrameNumber div 10) else Character := ssc0;
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
      OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

      if FFrameNumber <> 0 then FrameNumberTemp := FFrameNumber - (FFrameNumber div 10)*10 else FrameNumberTemp := 0;
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, TSevenSegmentCharacter(FrameNumberTemp));
      OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;
    end;

  if FShowFieldNumber then
    begin
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, ColonWidth, AHeight, sscPeriod);
      OffsetPoint.x := OffsetPoint.x + ColonWidth + DigitSpacing;

      if FFieldNumber > 9 then Character := TSevenSegmentCharacter(FFieldNumber div 10) else Character := ssc0;
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
      OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;

      if FFieldNumber <> 0 then FieldNumberTemp := FFieldNumber - (FFieldNumber div 10)*10 else FieldNumberTemp := 0;
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, TSevenSegmentCharacter(FieldNumberTemp));
      OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;
    end;
end;
//****************************************************************************************************************************************************
end.
