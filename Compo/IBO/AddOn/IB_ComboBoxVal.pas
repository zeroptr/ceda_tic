unit IB_ComboBoxVal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IB_Controls, IB_Components;

type
  TIB_ComboBoxVal = class(TIB_ComboBox)
  private
    FUseValues: boolean;
    FValues: TStrings;
    procedure SetComboValue(const AValue: String);
    procedure SetUseValues(Value: boolean);
    function GetValue: String;
    procedure SetValues(Value: TStrings);
  protected
    procedure SysDataChange( IB_Field: TIB_Column ); override;
    procedure SysUpdateData( IB_Field: TIB_Column ); override;
  public
    constructor Create( AOwner: TComponent ); override;
  published
    property UseValues: boolean read FUseValues write SetUseValues;
    property Values: TStrings read FValues write SetValues;
    property Value: string read GetValue;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('IB Controls', [TIB_ComboBoxVal]);
end;

constructor TIB_ComboBoxVal.Create( AOwner: TComponent );
begin
  inherited Create(AOwner);
  FUseValues := False;
  FValues := TStringList.Create;
end;

procedure TIB_ComboBoxVal.SetUseValues;
begin
  if Value <> FUseValues then begin
    FUseValues := Value;
    if FUseValues = True then Style := csDropDownList;
  end;
end;

function TIB_ComboBoxVal.GetValue;
begin
  if ItemIndex = -1 then Result := ''
  else Result := Values[ItemIndex];
end;

procedure TIB_ComboBoxVal.SetValues;
begin
  FValues.Assign(Value);
end;

procedure TIB_ComboBoxVal.SysDataChange;
begin
  if UseValues and (Style = csDropDownList) then begin
    SetComboValue(DataLink.FieldText);
    MaxLength := DataLink.FieldMaxLength;
  end else begin
    inherited SysDataChange(IB_Field);
  end;
end;

procedure TIB_ComboBoxVal.SysUpdateData;
begin
  if (Style = csDropDownList) and  UseValues then begin
    DataLink.FieldText := Values[ItemIndex]
  end else begin
    inherited SysUpdateData(IB_Field);
  end;
end;

procedure TIB_ComboBoxVal.SetComboValue( const AValue: string );
var
  I: Integer;
begin
  if (ItemIndex = -1) or (AValue <> Values[ItemIndex]) then begin
    SendMessage( Handle, WM_SETREDRAW, 0, 0 );
    try
      if AValue = '' then begin
        I := -1
      end else begin
        I := Values.IndexOf( AValue );
      end;
      ItemIndex := I;
    finally
      SendMessage( Handle, WM_SETREDRAW, 1, 0 );
      Invalidate;
    end;  
    if I >= 0 then Exit;
    if ( csDesigning in ComponentState ) then Text := AValue
  end;
end;

end.
