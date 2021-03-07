{*******************************************************}
{                                                       }
{       TiSevenSegmentHexadecimal Component             }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentHexadecimal;{$endif}
{$ifdef iCLX}unit QiSevenSegmentHexadecimal;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iSevenSegmentCharacter,  iSevenSegmentDisplay;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiSevenSegmentCharacter, QiSevenSegmentDisplay;{$ENDIF}

type
  TiSevenSegmentHexadecimal = class(TiSevenSegmentDisplay)
  private
    FValue : String;
  protected
    procedure SetValue(const Value: String);

    procedure iPaintTo(Canvas: TCanvas);    override;
    function  GetAutoSize : TPoint;         override;
    procedure DoChange;
  public
    constructor Create(AOwner: TComponent);  override;
    procedure   SetValueNoEvent(const Value: String);
  published
    property Value : String read FValue write SetValue;
    property DigitCount;
    property LeadingStyle     default ilsZeros;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiSevenSegmentHexadecimal.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  LeadingStyle := ilsZeros;

  FValue := '0';
  DoAutoSize;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentHexadecimal.DoChange;
begin
  if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Value');
  if Assigned(OnValueChange)     then OnValueChange(Self);
end;
//****************************************************************************************************************************************************
function TiSevenSegmentHexadecimal.GetAutoSize: TPoint;
begin
  SevenSegmentCharacter.Character := '0';
  Result.X := (SevenSegmentCharacter.GetCharacterWidth + DigitSpacing) * DigitCount - DigitSpacing + 2*SegmentMargin;
  Result.Y := SevenSegmentCharacter.GetCharacterHeight + 2*SegmentMargin;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentHexadecimal.SetValueNoEvent(const Value: String);
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
procedure TiSevenSegmentHexadecimal.SetValue(const Value: String);
var
  x          : Integer;
  TempString : ShortString;
  CanEdit    : Boolean;
begin
  if Length(Value) > 255 then raise Exception.Create(Value + ' exceeds 255 characters');

  if Copy(Value,1,1) = '$' then TempString := Copy(Value, 2, Length(Value) - 1)
    else if Copy(Value, 1,2) = '0x' then TempString := Copy(Value, 3, Length(Value) - 2)
      else TempString := Value;

  while (Copy(TempString, 1, 1) = '0') and (Length(TempString) > 1) do
    TempString := Copy(TempString, 2, Length(TempString) - 1);

  for x := 1 to Length(TempString) do
    begin
      if      TempString[x] = 'a' then TempString[x] := 'A'
       else if TempString[x] = 'b' then TempString[x] := 'B'
        else if TempString[x] = 'c' then TempString[x] := 'C'
         else if TempString[x] = 'd' then TempString[x] := 'D'
          else if TempString[x] = 'e' then TempString[x] := 'E'
           else if TempString[x] = 'f' then TempString[x] := 'F'
    end;

  if Trim(TempString) = '' then
    begin
      TempString := '0';
    end
  else
    begin
      for x := 1 to Length(TempString) do
        begin
          if not(TempString[x] in ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','A','B','C','D','E','F']) then
            raise Exception.Create(Value + ' not a valid Hexidecimal number');
        end;
    end;

  if FValue <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Value', CanEdit);
      if CanEdit then
        begin
          FValue := TempString;
          InvalidateChange;
          DoChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentHexadecimal.iPaintTo(Canvas: TCanvas);
var
  x             : Integer;
  OffsetPoint   : TPoint;
  IntegerString : ShortString;
  DigitWidth    : Integer;
  CenterOffset  : Integer;
  AHeight       : Integer;
  Character     : TSevenSegmentCharacter;
begin
  SetupCharacter;
  DrawBackGround(Canvas, BackGroundColor);

  DigitWidth := Trunc((Width - 2*SegmentMargin - DigitSpacing * (DigitCount - 1))/DigitCount);
  AHeight    := Height - 2*SegmentMargin;

  CenterOffset := (Width - DigitCount*(DigitWidth + DigitSpacing) + DigitSpacing) div 2;

  OffsetPoint.x := CenterOffset;
  OffsetPoint.y := SegmentMargin;

  IntegerString := FValue;

  if Length(IntegerString) > DigitCount then
    begin
      for x := 1 to DigitCount do
        begin
          SevenSegmentCharacter.Draw(Canvas, OffsetPoint, DigitWidth, AHeight, sscUpArrow);
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
