{                                                                              }
{ IBF_GenCalcFields                                                            }
{                                                                              }

{***************************************************************}
{                                                               }
{          IB Objects Components and Resources Library          }
{                                                               }
{          Copyright (C) 1996-2001 Jason Wharton                }
{          and Computer Programming Solutions, Mesa, AZ         }
{                                                               }
{  This source code unit is released under the terms of the     }
{  CPS Trustware License.                                       }
{  It may be distributed or deployed as source code or in       }
{  compiled form only in compliance with the terms and          }
{  conditions of the CPS Trustware License which may be         )
{  examined at http://www.ibobjects.com/ibo_trustware.html      )
{                                                               }
{***************************************************************}

{******************************************************************************}
{  CONTRIBUTED MODIFICATIONS                                                   }
{  Additions or modifications listed below using format:                       }
{                                                                              }
{  Joe Citizen <joe@joecitizen.com>                                            }
{  mm/dd/yyyy                                                                  }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{            Copyright (C) 2001 Joe Citizen                                    }
{                                                                              }
{------------------------------------------------------------------------------}
{  Place your credits and information in the top of the section                }
{  below with any other descriptions or explanations desired.                  }
{------------------------------------------------------------------------------}
{                                                                              }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IBF_GenCalcFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IB_Components, Buttons, XSpin;

type
  TfrmGenCalcFields = class(TForm)
    edFieldName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    cbFieldType: TComboBox;
    txPrecLength: TLabel;
    Label4: TLabel;
    BitBtnOk: TBitBtn;
    BitBtn2: TBitBtn;
    sePrecision: TXSpinEdit;
    seScale: TXSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure cbFieldTypeChange(Sender: TObject);
    procedure sePrecisionChange(Sender: TObject);
    procedure edFieldNameKeyPress(Sender: TObject; var Key: Char);
    procedure seScaleChange(Sender: TObject);
    procedure InputsChange(Sender: TObject);
    procedure BitBtnOkClick(Sender: TObject);
  private
    { Private declarations }
    AConnection: TIB_Connection;
    calcMemo: TMemo;
    MaxPrecision: Byte;
    function GetSafeV6OrGreaterEquivalent: Boolean;
    procedure EnableGUI;
  public
    { Public declarations }
    procedure InitValues(cn: TIB_Connection; cMemo: TMemo);
  end;

var
  frmGenCalcFields: TfrmGenCalcFields;

implementation

{$R *.DFM}

procedure TfrmGenCalcFields.InitValues(cn: TIB_Connection; cMemo: TMemo);
begin
  AConnection := cn;
  calcMemo := cMemo;
  if Assigned(AConnection) and Assigned(calcMemo)
  then With AConnection do
  begin
    try
    Connect;
    except
      On E: Exception do
        Application.HandleException(E)
    end;
    With cbFieldType.Items do
    begin
      if Connected and (SQLDialect > 1)
      then begin
        Add('TIMESTAMP');
        Add('DATE');
        Add('TIME');
        //sePrecision.MaxValue := 18;
        MaxPrecision := 18
      end
      else begin
        if Connected and GetSafeV6OrGreaterEquivalent
        then Add('TIMESTAMP')
        else Add('DATE');
        //sePrecision.MaxValue := 15;
        MaxPrecision := 15
      end;
    end;
    edFieldName.Enabled := True;
    cbFieldType.Enabled := True;
    cbFieldType.Sorted := True
  end
end;

function TfrmGenCalcFields.GetSafeV6OrGreaterEquivalent: Boolean;
begin
  Result := False;
  if AConnection.Characteristics.dbBase_Level >= 6
  then Result := True
  else With TIB_Cursor.Create(nil) do
  try
    IB_Connection := AConnection;
    SQL.Add('SELECT COUNT(*) AS C FROM RDB$RELATION_FIELDS');
    SQL.Add('WHERE RDB$RELATION_NAME = ''RDB$FIELDS''');
    SQL.Add('AND RDB$FIELD_NAME = ''RDB$FIELD_PRECISION''');
    try
      First;
      Result := Fields[0].AsBoolean
    except
      On E: Exception do
        Application.HandleException(E)
    end
  finally
    Free
  end
end;

procedure TfrmGenCalcFields.FormCreate(Sender: TObject);
begin
  with sePrecision do
  begin
    Value := 1;
    MaxValue := 18;
    MinValue := 1;
  end;
  with seScale do
  begin
    MaxValue := 0;
    MinValue := 0;
  end;
  with cbFieldType.Items do
  begin
    Add('INTEGER');
    Add('CHAR');
    Add('VARCHAR');
    Add('SMALLINT');
    Add('FLOAT');
    Add('DOUBLE PRECISION');
    Add('NUMERIC');
    // Other types are dependant on the server version and SQL dialect
  end
end;

procedure TfrmGenCalcFields.cbFieldTypeChange(Sender: TObject);
begin
  With cbFieldType do
  begin
    sePrecision.Enabled := (Text = 'CHAR') or (Text = 'VARCHAR')
      or (Text = 'NUMERIC');
    seScale.Enabled := Text = 'NUMERIC';
    if (Text = 'CHAR') or (Text = 'VARCHAR')
    then begin
      sePrecision.MaxValue := 32767;
      txPrecLength.Caption := 'Length'
    end
    else With sePrecision do
    begin
      MaxValue := MaxPrecision;
      if Value > MaxValue
      then Value := MaxValue;
      seScale.MaxValue := 0;
      txPrecLength.Caption := 'Precision'
    end
  end;
  InputsChange(Sender)
end;

procedure TfrmGenCalcFields.sePrecisionChange(Sender: TObject);
begin
  With seScale do
  begin
    MaxValue := sePrecision.Value;
    Value := 0
  end;
  InputsChange(Sender)
end;

procedure TfrmGenCalcFields.edFieldNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9', 'A'..'Z', 'a'..'z', '_', Chr(VK_BACK)]
  then // nothing
  else Key := #0
end;

procedure TfrmGenCalcFields.EnableGUI;
var
  val: Boolean;
  s: String;
begin
  s := cbFieldType.Text;
  val := (Length(edFieldName.Text) > 0) and (Length(s) > 0);
  val := val and (s = 'INTEGER')
    or ((s = 'CHAR') or (s = 'VARCHAR'))
      and (sePrecision.Value > 1) and (sePrecision.Value <= 32767)
    or (s = 'SMALLINT') or (s = 'FLOAT') or (s = 'DOUBLE PRECISION')
    or (s = 'NUMERIC')
      and (sePrecision.Value > 0) and (seScale.Value <= sePrecision.Value)
    or (s = 'TIMESTAMP') or (s = 'DATE') or (s = 'TIME');
  BitBtnOk.Enabled := val
end;

procedure TfrmGenCalcFields.seScaleChange(Sender: TObject);
begin
  With seScale do
    if Value < 0
    then Value := 0
    else if Value > sePrecision.Value
    then Value := sePrecision.Value;
  InputsChange(Sender)
end;

procedure TfrmGenCalcFields.InputsChange(Sender: TObject);
begin
  EnableGUI
end;

procedure TfrmGenCalcFields.BitBtnOkClick(Sender: TObject);
const
  quest = 'Do you want to replace existing calculated field with same name?';
var
  s, res: String;
begin
  With calcMemo.Lines do
  begin
    if IndexOfName(edFieldName.Text) > -1
    then begin
      if MessageDlg(quest, mtConfirmation, [mbYes, mbNo], 0) <> mrYes
      then Exit
    end;
    s := cbFieldType.Text;
    if (s = 'CHAR') or (s = 'VARCHAR') or (s = 'NUMERIC')
    then begin
      res := s + '(' + IntToStr(sePrecision.Value);
      if s = 'NUMERIC'
      then res := res + ',' + IntToStr(seScale.value) + ')'
      else res := res + ')'
    end
    else res := s;
    Values[edFieldName.Text] := res
  end
end;

end.


