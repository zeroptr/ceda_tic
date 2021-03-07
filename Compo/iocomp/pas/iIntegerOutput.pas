{*******************************************************}
{                                                       }
{       TiIntegerOutput Component                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iIntegerOutput;{$endif}
{$ifdef iCLX}unit QiIntegerOutput;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iComponent,  iEditCustom,  iTypes, iGPFunctions; {$ENDIF}
  {$IFDEF iCLX}QiComponent, QiEditCustom, QiTypes, QiGPFunctions;{$ENDIF}

type
  TiIntegerOutput = class(TiEditCustom)
  private
    FValue              : Integer;
    FOnBeforeChange     : TOnBeforeChangeInteger;
    FOnChangeUser       : TNotifyEvent;
    FOnBeforeUserChange : TOnBeforeChangeInteger;
    FBeepOnError        : Boolean;
    FUndoOnError        : Boolean;
    FFormatStyle        : TiIntegerFormatStyle;
    FLeadingZeros       : Boolean;
    FValueMax           : Integer;
    FValueMin           : Integer;
  protected
    procedure SetValue       (const Value: Integer);
    procedure SetValueMax    (const Value: Integer);
    procedure SetValueMin    (const Value: Integer);
    procedure SetFormatStyle (const Value: TiIntegerFormatStyle);
    procedure SetLeadingZeros(const Value: Boolean);

    function  GetValue(Value: String): Integer;
    function  iGetText (Value: Integer): String;

    procedure UpdateText;
    procedure DoChange;                            override;
    procedure CompleteChange;                      override;
    function  AllowKey(Key: Char): Boolean;        override;
    procedure SetMaxLength(const Value: Integer);  override;
  public
    constructor Create(AOwner: TComponent);        override;

    procedure   SetValueNoEvent(const Value : Integer);

    {$ifdef iVCL}
    procedure OPCItemActivateSend(Index:Integer);
    {$endif}

    property Text;
  published
    property Value              : Integer                read FValue              write SetValue;
    property ValueMax           : Integer                read FValueMax           write SetValueMax;
    property ValueMin           : Integer                read FValueMin           write SetValueMin;
    property OnChangeUser       : TNotifyEvent           read FOnChangeUser       write FOnChangeUser;
    property OnBeforeChange     : TOnBeforeChangeInteger read FOnBeforeChange     write FOnBeforeChange;
    property OnBeforeUserChange : TOnBeforeChangeInteger read FOnBeforeUserChange write FOnBeforeUserChange;

    property UndoOnError        : Boolean                read FUndoOnError        write FUndoOnError    default True;
    property BeepOnError        : Boolean                read FBeepOnError        write FBeepOnError    default False;

    property FormatStyle        : TiIntegerFormatStyle   read FFormatStyle        write SetFormatStyle;
    property LeadingZeros       : Boolean                read FLeadingZeros       write SetLeadingZeros;

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
constructor TiIntegerOutput.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Alignment    := taCenter;
  Font.Style   := [fsBold];

  FUndoOnError := True;
  Text         := '0';
end;
//****************************************************************************************************************************************************
procedure TiIntegerOutput.DoChange;
begin
  if not(csLoading in ComponentState) then
    begin
      if                        Assigned(OnChangeProtected)  then OnChangeProtected(Self, 'Value');
      if                        Assigned(OnChange)           then OnChange          (Self);
      if UserGenerated then  if Assigned(FOnChangeUser)      then FOnChangeUser     (Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiIntegerOutput.SetLeadingZeros(const Value: Boolean);
begin
  if FLeadingZeros <> Value then
    begin
      FLeadingZeros := Value;
      UpdateText;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiIntegerOutput.SetFormatStyle(const Value: TiIntegerFormatStyle);
begin
  if FFormatStyle <> Value then
    begin
      FFormatStyle := Value;
      UpdateText;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiIntegerOutput.SetMaxLength(const Value: Integer);
begin
  inherited;
  UpdateText;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiIntegerOutput.SetValueMax(const Value: Integer);
begin
  if FValueMax <> Value then
    begin
      FValueMax  := Value;
      Self.Value := FValue;
    end;
end;
//****************************************************************************************************************************************************
procedure TiIntegerOutput.SetValueMin(const Value: Integer);
begin
  if FValueMin <> Value then
    begin
      FValueMin  := Value;
      Self.Value := FValue;
    end;
end;
//****************************************************************************************************************************************************
procedure TiIntegerOutput.SetValue(const Value: Integer);
var
  TempValue : Integer;
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
procedure TiIntegerOutput.SetValueNoEvent(const Value: Integer);
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
function TiIntegerOutput.AllowKey(Key: Char): Boolean;
var
  BadKey : Boolean;
begin
  Result := True;

  BadKey := True;
  case FormatStyle of
    iifsInteger : if Key in ['0'..'9']                     then BadKey := False;
    iifsHex     : if Key in ['0'..'9', 'a'..'f', 'A'..'F'] then BadKey := False;
    iifsBinary  : if Key in ['0'..'1']                     then BadKey := False;
    iifsOctal   : if Key in ['0'..'7']                     then BadKey := False;
  end;

  if BadKey then
    begin
      if FBeepOnError then Beep;
      Result := False;
    end;
end;
//****************************************************************************************************************************************************
procedure TiIntegerOutput.UpdateText;
begin
  Text := iGetText(FValue);
end;
//****************************************************************************************************************************************************
function TiIntegerOutput.GetValue(Value: String): Integer;
begin
  Result := 0;
  try
    case FFormatStyle of
      iifsInteger : Result := iStrToInt(      Value);
      iifsHex     : Result := iStrToInt('$' + Value);
      iifsBinary  : Result := iStrToInt('b' + Value);
      iifsOctal   : Result := iStrToInt('o' + Value);
    end;
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
function TiIntegerOutput.iGetText(Value: Integer): String;
var
  TempMaxLength : Integer;
begin
  TempMaxLength := MaxLength;
  case FFormatStyle of
    iifsInteger : begin
                    Result := iIntToStr(Value, iifsInteger, TempMaxLength, FLeadingZeros);
                  end;
    iifsHex     : begin
                    if TempMaxLength > 8 then TempMaxLength := 8;
                    if TempMaxLength = 0 then TempMaxLength := 8;
                    Result := iIntToStr(Value, iifsHex,     TempMaxLength, FLeadingZeros);
                  end;
    iifsBinary  : begin
                    if TempMaxLength > 32 then TempMaxLength := 32;
                    if TempMaxLength = 0  then TempMaxLength := 32;
                    Result := iIntToStr(Value, iifsBinary,  TempMaxLength, FLeadingZeros);
                  end;
    iifsOctal   : begin
                    if TempMaxLength > 10 then TempMaxLength := 10;
                    if TempMaxLength = 0  then TempMaxLength := 10;
                    Result := iIntToStr(Value, iifsOctal,   TempMaxLength, FLeadingZeros);
                  end;
  end;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiIntegerOutput.OPCItemActivateSend(Index: Integer);
var
  OldValue : Double;
begin
  OldValue := Value;
  OPCItemActivate(Index);
  OPCItem[Index].Data := OldValue;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiIntegerOutput.CompleteChange;
begin
  if Text <> UndoText then
    begin
      Value := GetValue(Text);
      UndoText := iGetText(FValue);
      SelectAll;
    end
  else SelectAll;
end;
//****************************************************************************************************************************************************
end.


