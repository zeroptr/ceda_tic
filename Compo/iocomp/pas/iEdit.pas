{*******************************************************}
{                                                       }
{       TiEdit Component                                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iEdit;{$endif}
{$ifdef iCLX}unit QiEdit;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iEditCustom,  iTypes, iGPFunctions, ActiveX, iOPCItem;{$ENDIF}
  {$IFDEF iCLX}QiEditCustom, QiTypes, QiGPFunctions;                 {$ENDIF}

type
  TiEdit = class(TiEditCustom)          
  private
    FValue              : String;
    FOnChange           : TNotifyEvent;
    FOnBeforeChange     : TOnBeforeChangeString;
    FOnChangeUser       : TNotifyEvent;
    FOnBeforeUserChange : TOnBeforeChangeString;
    FSettingValue       : Boolean;

    procedure SetValue      (const Value: String);
  protected
    function  GetValue : String;
    procedure UpdateText;
    procedure SelectValue;
    procedure DoChange;        override;
    procedure CompleteChange;  override;
  public
    constructor Create(AOwner: TComponent);  override;
    procedure   SetValueNoEvent(const Value : String);
    {$ifdef iVCL}
    procedure OPCItemActivateSend(Index:Integer);
    {$endif}                                                         
  published
    property Value              : String                read GetValue            write SetValue;
    property OnChange           : TNotifyEvent          read FOnChange           write FOnChange;
    property OnChangeUser       : TNotifyEvent          read FOnChangeUser       write FOnChangeUser;
    property OnBeforeChange     : TOnBeforeChangeString read FOnBeforeChange     write FOnBeforeChange;
    property OnBeforeUserChange : TOnBeforeChangeString read FOnBeforeUserChange write FOnBeforeUserChange;

    property Alignment    default taRightJustify;

    property TabOrder;
    property TabStop      default True;

    property ErrorActive;
    property ErrorText;
    property ErrorFont;
    property ErrorBackGroundColor;
    property PasswordChar;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Alignment  := taRightJustify;
  Font.Style := [fsBold];
  Value      := '';
end;
//****************************************************************************************************************************************************
procedure TiEdit.DoChange;
begin
  if not(csLoading in ComponentState) then
    begin
      if                        Assigned(OnChangeProtected)  then OnChangeProtected(Self, 'Value');
      if                        Assigned(FOnChange)          then FOnChange         (Self);
      if UserGenerated then  if Assigned(FOnChangeUser)      then FOnChangeUser     (Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiEdit.SetValueNoEvent(const Value: String);
var
  TempOnValueChange : TNotifyEvent;
begin
  TempOnValueChange := FOnChange;
  FOnChange:= nil;
  try
    SetValue(Value);
  finally
    FOnChange := TempOnValueChange;
  end;
end;
//****************************************************************************************************************************************************
procedure TiEdit.SetValue(const Value: String);
var
  TempValue : String;
  CanChange : Boolean;
begin
  if FSettingValue then Exit;
  FSettingValue := True;
  try
    TempValue := Value;

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
                  UpdateText;
                  DoChange;
                end;
              end;
          end;
        UpdateText;
      end
    else UpdateText;
  finally
    FSettingValue := False;
  end;
end;
//****************************************************************************************************************************************************
function TiEdit.GetValue: String;
begin
  Result := Text;
end;
//****************************************************************************************************************************************************
procedure TiEdit.SelectValue;
begin                                              
  SelStart := 0;
  SelLength := Length(Text);
end;
//****************************************************************************************************************************************************
procedure TiEdit.UpdateText;
begin
  Text := FValue;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiEdit.OPCItemActivateSend(Index: Integer);
var
  OldValue : String;
begin
  OldValue := Value;
  OPCItemActivate(Index);
  OPCItem[Index].Data := OldValue;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiEdit.CompleteChange;
begin
  if Text <> UndoText then
    begin
      Value    := Text;
      UndoText := Value;
      if AutoSelect then SelectAll;
    end
  else if AutoSelect then SelectAll;
end;
//****************************************************************************************************************************************************
end.


