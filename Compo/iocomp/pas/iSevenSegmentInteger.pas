{*******************************************************}
{                                                       }
{       TiSevenSegmentInteger Component                 }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentInteger;{$endif}
{$ifdef iCLX}unit QiSevenSegmentInteger;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iSevenSegmentCharacter,  iSevenSegmentDisplay;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiSevenSegmentCharacter, QiSevenSegmentDisplay;{$ENDIF}

type
  TiSevenSegmentInteger = class(TiSevenSegmentDisplay)
  private
    FValue    : Integer;
    FShowSign : Boolean;
  protected
    procedure SetValue    (const Value: Integer);
    procedure SetShowSign (const Value: Boolean);

    procedure iPaintTo(Canvas: TCanvas);    override;
    function  GetAutoSize : TPoint;         override;
    procedure DoChange;
  public
    constructor Create(AOwner: TComponent);  override;
    procedure   SetValueNoEvent(const Value: Integer);
  published
    property Value    : Integer read FValue     write SetValue;
    property ShowSign : Boolean read FShowSign  write SetShowSign default True;
    property DigitCount;
    property LeadingStyle;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiSevenSegmentInteger.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FShowSign  := True;

  DoAutoSize;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentInteger.DoChange;
begin
  if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Value');
  if Assigned(OnValueChange)     then OnValueChange(Self);
end;
//****************************************************************************************************************************************************
function TiSevenSegmentInteger.GetAutoSize: TPoint;
begin
  SevenSegmentCharacter.Character := '0';

  if FShowSign then Result.X := (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing)*(DigitCount + 1) + 2*SegmentMargin - DigitSpacing
    else Result.X := (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing)*DigitCount + 2*SegmentMargin - DigitSpacing;

  Result.Y := SevenSegmentCharacter.GetCharacterHeight + 2*SegmentMargin;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentInteger.SetValueNoEvent(const Value: Integer);
var
  TempOnValueChange : TNotifyEvent;
begin
  TempOnValueChange := OnValueChange;
  OnValueChange     := nil;
  try
    SetValue(Value);
  finally
    OnValueChange := TempOnValueChange;
  end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentInteger.SetValue(const Value: Integer);
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
          DoChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentInteger.SetShowSign(const Value: Boolean);
begin
  if FShowSign <> Value then
    begin
      FShowSign := Value;
      InvalidateChange;
      DoAutoSize;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentInteger.iPaintTo(Canvas: TCanvas);
var
  x              : Integer;
  OffsetPoint    : TPoint;
  IntegerString  : ShortString;
  DigitWidth     : Integer;
  CenterOffset   : Integer;
  DigitCountTemp : Integer;
  AHeight        : Integer;
  Character      : TSevenSegmentCharacter;
begin
  SetupCharacter;
  DrawBackGround(Canvas, BackGroundColor);

  if FShowSign then DigitCountTemp := DigitCount + 1 else DigitCountTemp := DigitCount;

  DigitWidth := Trunc((Width - 2*SegmentMargin - DigitSpacing * (DigitCountTemp - 1))/DigitCountTemp);
  AHeight    := Height - 2*SegmentMargin;

  CenterOffset := (Width - DigitCountTemp*(DigitWidth + DigitSpacing) + DigitSpacing) div 2;


  OffsetPoint.x := CenterOffset;
  OffsetPoint.y := SegmentMargin;

  IntegerString := IntToStr(ABS(FValue));

  if FShowSign then
    begin
      if FValue >= 0 then Character := sscPlus else Character := sscMinus;
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
      OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;
    end;

  if Length(IntegerString) > DigitCount then
    begin
      for x := 1 to DigitCount do
        begin
          if FValue >= 0 then Character := sscUpArrow else Character := sscDownArrow;
          SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
          OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;
        end;
    end
  else
    begin
      case LeadingStyle of
        ilsZeros  : while Length(IntegerString) < DigitCount do
                      IntegerString := '0' + IntegerString;
        ilsSpaces : while Length(IntegerString) < DigitCount do
                      IntegerString := ' ' + IntegerString;
      end;

      for x := 1 to Length(IntegerString) do
        begin
          Character := SevenSegmentCharacter.ConvertCharacterToValue(IntegerString[x]);
          SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
          OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;
        end;
    end;
end;
//****************************************************************************************************************************************************
end.
