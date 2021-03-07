{*******************************************************}
{                                                       }
{       TiSevenSegmentAnalog Component                  }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentAnalog;{$endif}
{$ifdef iCLX}unit QiSevenSegmentAnalog;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iSevenSegmentCharacter,  iSevenSegmentDisplay;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiSevenSegmentCharacter, QiSevenSegmentDisplay;{$ENDIF}

type
  TiSevenSegmentAnalog = class(TiSevenSegmentDisplay)
  private
    FValue     : Double;
    FShowSign  : Boolean;
    FPrecision : Integer;
    procedure SetValue    (const Value: Double);
    procedure SetShowSign (const Value: Boolean);
    procedure SetPrecision(const Value: Integer);
  protected
    procedure iPaintTo(Canvas: TCanvas);    override;
    function  GetAutoSize : TPoint;         override;
    procedure DoChange;
  public
    constructor Create(AOwner: TComponent); override;
    procedure   SetValueNoEvent(const Value: Double);
  published
    property Precision : Integer read FPrecision write SetPrecision default 2;
    property Value     : Double  read FValue     write SetValue;
    property ShowSign  : Boolean read FShowSign  write SetShowSign  default True;
    property DigitCount;
    property LeadingStyle;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiSevenSegmentAnalog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FShowSign  := True;
  FPrecision := 2;

  DoAutoSize;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentAnalog.DoChange;
begin
  if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Value');
  if Assigned(OnValueChange)     then OnValueChange(Self);
end;
//****************************************************************************************************************************************************
function TiSevenSegmentAnalog.GetAutoSize: TPoint;
begin
  SevenSegmentCharacter.Character := '0';

  if FShowSign then Result.X := (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing) * (DigitCount + 1) + 2*SegmentMargin  - DigitSpacing
    else Result.X := (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing) * DigitCount + 2*SegmentMargin - DigitSpacing;
  Result.Y := SevenSegmentCharacter.GetCharacterHeight + 2*SegmentMargin;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentAnalog.SetPrecision(const Value: Integer);
var
  TempValue : Integer;
begin
  TempValue := Value;
  if TempValue > 13 then TempValue := 13;
  if FPrecision <> TempValue then
    begin
      FPrecision := TempValue;
      if FPrecision < 0 then FPrecision := 0;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentAnalog.SetValueNoEvent(const Value: Double);
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
procedure TiSevenSegmentAnalog.SetValue(const Value: Double);
var
  TempValue : Double;
  CanEdit   : Boolean;
begin
  TempValue := Value;
  if TempValue > 1E15 then TempValue := 1E15;
  if FValue <> TempValue then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Value', CanEdit);
      if CanEdit then
        begin
          FValue := TempValue;
          InvalidateChange;
          DoChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentAnalog.SetShowSign(const Value: Boolean);
begin
  if FShowSign <> Value then
    begin
      FShowSign := Value;
      InvalidateChange;
      DoAutoSize;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentAnalog.iPaintTo(Canvas: TCanvas);
var
  OffsetPoint    : TPoint;
  TempOffset     : TPoint;
  x              : Integer;
  FractionLength : Integer;
  DigitWidth     : Integer;
  CenterOffset   : Integer;
  DigitCountTemp : Integer;
  AHeight        : Integer;
  Character      : TSevenSegmentCharacter;
  ValueString    : String;
  IntegerString  : ShortString;
  FractionString : ShortString;
  Index          : Integer;
  FractionChar   : String;
  OverFlow       : Boolean;
begin
  SetupCharacter;                              
  DrawBackGround(Canvas, BackGroundColor);

                    DigitCountTemp := DigitCount;
  if FShowSign then DigitCountTemp := DigitCount + 1;

  DigitWidth := Trunc((Width - 2*SegmentMargin - DigitSpacing * (DigitCountTemp - 1))/DigitCountTemp);
  AHeight    := Height - 2*SegmentMargin;

  CenterOffset := (Width - DigitCountTemp*(DigitWidth + DigitSpacing) + DigitSpacing) div 2;

  OffsetPoint.x := CenterOffset;
  OffsetPoint.y := SegmentMargin;

  ValueString := Format('%.' + IntToStr(Precision) + 'f', [ABS(FValue)]);

  if Pos('.', ValueString) <> 0 then
    begin
      Index := Pos('.', ValueString);
      IntegerString  := Copy(ValueString, 1, Index-1);
      FractionString := Copy(ValueString, Index+1, Length(ValueString)-Index+1);
      FractionChar   := '.';
    end
  else
  if Pos(',', ValueString) <> 0 then
    begin
      Index := Pos(',', ValueString);
      IntegerString  := Copy(ValueString, 1, Index-1);
      FractionString := Copy(ValueString, Index+1, Length(ValueString)-Index+1);
      FractionChar   := ',';
    end
  else
    begin
      IntegerString  := ValueString;
      FractionString := '';
    end;

  if FShowSign then
    begin
      if FValue >= 0 then Character := sscPlus else Character := sscMinus;
      SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
      OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;
    end;

  OverFlow := False;

  case FPrecision of
    0  : if Length(ValueString) > DigitCount     then OverFlow := True;
    else if Length(ValueString) > DigitCount + 1 then OverFlow := True;
  end;

  if OverFlow then
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
        ilsZeros  : while Length(IntegerString) < (DigitCount - FPrecision) do
                      IntegerString := '0' + IntegerString;
        ilsSpaces : while Length(IntegerString) < (DigitCount - FPrecision) do
                      IntegerString := ' ' + IntegerString;
      end;
      for x := 1 to Length(IntegerString) do
        begin
          Character := SevenSegmentCharacter.ConvertCharacterToValue(IntegerString[x]);
          SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
          OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;
        end;

      if (FPrecision > 0) and (DigitCount > 1) then
        begin
          TempOffset.y := OffsetPoint.y;
          TempOffset.x := OffsetPoint.x - Round(DigitWidth/10 + DigitSpacing/2);
          if FractionChar = '.' then
            SevenSegmentCharacter.Draw(Canvas, TempOffset, DigitWidth div 5, AHeight, sscPeriod)
          else
            SevenSegmentCharacter.Draw(Canvas, TempOffset, DigitWidth div 5, AHeight, sscComma);


          while Length(FractionString) > FPrecision do
            FractionString := Copy(FractionString, 1, Length(FractionString) - 1);

          while Length(FractionString) < FPrecision do
            FractionString := '0' + FractionString;

          FractionLength := Length(FractionString);

          if FractionLength > (DigitCount - 1) then FractionLength := (DigitCount - 1);

          for x := 1 to FractionLength do
            begin
              Character := SevenSegmentCharacter.ConvertCharacterToValue(FractionString[x]);
              SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, Character);
              OffsetPoint.x := OffsetPoint.x + DigitWidth + DigitSpacing;
            end;

        end;
    end;
end;
//****************************************************************************************************************************************************
end.
