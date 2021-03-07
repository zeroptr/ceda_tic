{*******************************************************}
{                                                       }
{       TiAnalogOutput Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iAnalogOutput;{$endif}             
{$ifdef iCLX}unit QiAnalogOutput;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iComponent,  iEditCustom,  iTypes, iGPFunctions; {$ENDIF}
  {$IFDEF iCLX}QiComponent, QiEditCustom, QiTypes, QiGPFunctions;{$ENDIF}

type                                     
  TiAnalogOutput = class(TiEditCustom)
  private
    FPrecision               : Integer;
    FUnitsText               : String;
    FValue                   : Double;
    FValueMax                : Double;
    FValueMin                : Double;
    FFilterStyle             : TiFilterInputStyle;
    FBeepOnError             : Boolean;
    FUndoOnError             : Boolean;
    FOnBeforeChange          : TOnBeforeChangeDouble;
    FOnChangeUser            : TNotifyEvent;
    FOnBeforeUserChange      : TOnBeforeChangeDouble;
    FBlockValueUpdate        : Boolean;

    procedure SetPrecision  (const Value: Integer);
    procedure SetValue      (const Value: Double);
    procedure SetValueMax   (const Value: Double);
    procedure SetValueMin   (const Value: Double);
    procedure SetUnitsText  (const Value: String);
  protected
    function  GetValue(Value: String): Double;
    function  iGetText (Value: Double): String;

    procedure UpdateText;
    procedure DoChange;                            override;
    procedure CompleteChange;                      override;
    function  AllowKey(Key: Char): Boolean;        override;
  public
    constructor Create(AOwner: TComponent);  override;
    procedure   SetValueNoEvent(const Value : Double);

    procedure SelectAll; override;

    {$ifdef iVCL}
    procedure OPCItemActivateSend(Index:Integer);
    {$endif}

    property Text;
  published
    property Precision          : Integer               read FPrecision          write SetPrecision    default 1;
    property Value              : Double                read FValue              write SetValue;
    property ValueMax           : Double                read FValueMax           write SetValueMax;
    property ValueMin           : Double                read FValueMin           write SetValueMin;
    property UnitsText          : String                read FUnitsText          write SetUnitsText;
    property FilterStyle        : TiFilterInputStyle    read FFilterStyle        write FFilterStyle    default ifisAuto;
    property UndoOnError        : Boolean               read FUndoOnError        write FUndoOnError    default True;
    property BeepOnError        : Boolean               read FBeepOnError        write FBeepOnError    default False;
    property OnChangeUser       : TNotifyEvent          read FOnChangeUser       write FOnChangeUser;
    property OnBeforeChange     : TOnBeforeChangeDouble read FOnBeforeChange     write FOnBeforeChange;
    property OnBeforeUserChange : TOnBeforeChangeDouble read FOnBeforeUserChange write FOnBeforeUserChange;

    property Alignment    default taCenter;

    property TabOrder;
    property TabStop      default True;

    property ErrorActive;
    property ErrorText;
    property ErrorFont;
    property ErrorBackGroundColor;

  end;

implementation
//****************************************************************************************************************************************************
constructor TiAnalogOutput.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Alignment    := taCenter;
  Font.Style   := [fsBold];

  FPrecision   := 1;
  FFilterStyle := ifisAuto;
  FUndoOnError := True;

  Value        := 0;
end;
//****************************************************************************************************************************************************
procedure TiAnalogOutput.DoChange;
begin
  if not(csLoading in ComponentState) then
    begin
      if                        Assigned(OnChangeProtected)  then OnChangeProtected(Self, 'Value');
      if                        Assigned(OnChange)           then OnChange         (Self);
      if UserGenerated then  if Assigned(FOnChangeUser)      then FOnChangeUser    (Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiAnalogOutput.SetValueNoEvent(const Value: Double);
var
  TempOnValueChange : TNotifyEvent;
begin
  TempOnValueChange := OnChange;
  OnChange:= nil;
  try
    SetValue(Value);
  finally
    OnChange := TempOnValueChange;
  end;
end;
//****************************************************************************************************************************************************
procedure TiAnalogOutput.SetValue(const Value: Double);
var
  TempValue : Double;
  CanChange : Boolean;
begin
  TempValue := Value;

  if not ((FValueMax = 0) and (FValueMin = 0)) and not Loading then
    begin
      if TempValue > FValueMax then TempValue := FValueMax;
      if TempValue < FValueMin then TempValue := FValueMin;
    end;

  if FValue <> TempValue then
    begin
      CanChange := True;
      if UserGenerated then if Assigned(FOnBeforeUserChange) then FOnBeforeUserChange(Self, FValue, TempValue, CanChange);
                            if Assigned(FOnBeforeChange)     then FOnBeforeChange    (Self, FValue, TempValue, CanChange);
      if CanChange then
        begin
          if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Value', CanChange);
          if CanChange then
            begin
              if not ((FValueMax = 0) and (FValueMin = 0)) then
                begin
                  if TempValue > FValueMax then TempValue := FValueMax;
                  if TempValue < FValueMin then TempValue := FValueMin;
                end;
              {$ifdef iVCL}if not OPCOutputData('Value', TempValue) then {$ENDIF}
              begin
                FValue := TempValue;
                UndoText := iGetText(FValue);
                UpdateText;
                DoChange;
              end;
            end;
        end;
      UpdateText;
    end
  else UpdateText;
end;
//****************************************************************************************************************************************************
procedure TiAnalogOutput.SetPrecision(const Value: Integer);
begin
  if FPrecision <> Value then
    begin
      FPrecision := Value;
      FBlockValueUpdate := True;
      try
        UpdateText;
      finally
        FBlockValueUpdate := False;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAnalogOutput.SetValueMax(const Value: Double);
begin
  if FValueMax <> Value then
    begin
      FValueMax  := Value;
      Self.Value := FValue;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAnalogOutput.SetValueMin(const Value: Double);
begin
  if FValueMin <> Value then
    begin
      FValueMin  := Value;
      Self.Value := FValue;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAnalogOutput.SetUnitsText(const Value: String);
begin
  if FUnitsText <> Value then
    begin
      FUnitsText := Value;
      if Trim(FUnitsText) = '' then FUnitsText := '';
      FBlockValueUpdate := True;
      try
        UpdateText;
      finally
        FBlockValueUpdate := False;
      end;
    end;
end;
//****************************************************************************************************************************************************
function TiAnalogOutput.AllowKey(Key: Char): Boolean;
var
  BadKey               : Boolean;
  DecimalSeperatorChar : String;
begin
  DecimalSeperatorChar := Copy(Format('%1.1f', [0.0]), 2, 1);

  Result := True;
  if FFilterStyle = ifisAuto then
    begin
      BadKey := True;
      if Key in ['0'..'9', '-']                            then BadKey := False;
      if (Precision <> 0) and (Key = DecimalSeperatorChar) then BadKey := False;
      if Pos(UpperCase(Key), UpperCase(UnitsText)) <> 0    then BadKey := False;

      if BadKey then
        begin
          if FBeepOnError then Beep;
          Result := False;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAnalogOutput.UpdateText;
begin
  Text := iGetText(FValue);
end;
//****************************************************************************************************************************************************
function TiAnalogOutput.GetValue(Value: String): Double;
begin
  Value := StringReplace(Value, Trim(FUnitsText), '', [rfReplaceAll, rfIgnoreCase]);

  try
    Result := StrToFloat(Value);
  except
    on e : exception do
      begin
        if FUndoOnError then
          begin
            Undo;
            Result := FValue;
            if FBeepOnError then Beep;
          end
        else raise;
      end;
  end;
end;
//****************************************************************************************************************************************************
function TiAnalogOutput.iGetText(Value: Double): String;
begin
  if FPrecision >= 0 then
    Result := Trim(Format('%.' + IntToStr(FPrecision) + 'f', [Value])) + FUnitsText
  else
    Result := Trim(Format('%g', [Value])) + FUnitsText
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiAnalogOutput.OPCItemActivateSend(Index: Integer);
var
  OldValue : Double;
begin
  OldValue := Value;
  OPCItemActivate(Index);
  OPCItem[Index].Data := OldValue;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiAnalogOutput.SelectAll;
var
  UnitsSelLength : Integer;
begin
  if Length(FUnitsText) = 0 then UnitsSelLength := 0 else UnitsSelLength := Length(FUnitsText);
  SelStart  := 0;
  SelLength := Length(Text) - UnitsSelLength;
end;
//****************************************************************************************************************************************************
procedure TiAnalogOutput.CompleteChange;
begin
  if Text <> UndoText then
    begin
      if not FBlockValueUpdate then Value := GetValue(Text);
      UndoText := iGetText(FValue);
      SelectAll;
    end
  else SelectAll;
end;
//****************************************************************************************************************************************************
end.


