{                                                                              }
{ IBF_GenCustomSQL                                                             }
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
  IBF_GenCustomSQL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, IB_Components, Buttons, ExtCtrls;

type
  TfrmGenCustomSQL = class(TForm)
    StringGridProc: TStringGrid;
    cbTables: TComboBox;
    Label2: TLabel;
    lbFields: TListBox;
    chbEdit: TCheckBox;
    chbInsert: TCheckBox;
    chbDelete: TCheckBox;
    BitBtnApply: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    BitBtnProc: TBitBtn;
    Label3: TLabel;
    ShapeValue: TShape;
    Label4: TLabel;
    chbTryToUseNumber: TCheckBox;
    stProc: TLabel;
    procedure StringGridProcDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure StringGridProcDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure lbFieldsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbTablesChange(Sender: TObject);
    procedure chbAllClick(Sender: TObject);
    procedure BitBtnProcClick(Sender: TObject);
    procedure BitBtnApplyClick(Sender: TObject);
    procedure ShapeValueMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    AConnection: TIB_Connection;
    editMemo, insertMemo, deleteMemo: TMemo;
    wasAltPressed: Boolean;
    procedure Auxlbondblclick(Sender: TObject);
    procedure Auxlbonkeypress(Sender: TObject; var Key: Char);
    procedure EnableGUI(val: Boolean);
    function CheckGrid: Boolean;
    function MkOld(const tblName: string): String;
    function StOld(const tblName: String): String;
    procedure GenCustomSQL(slOutput: TStringList; gen_action: char);
  public
    { Public declarations }
    procedure InitValues(cn: TIB_Connection; eMemo, iMemo, dMemo: TMemo);
  end;

var
  frmGenCustomSQL: TfrmGenCustomSQL; // Do not delete it, used as placeholder

function CreateDialogOnDemand(refControl: TWinControl; var lb: TListBox): TForm;


implementation

uses IB_Parse, IB_Constants;

{$R *.DFM}

function CreateDialogOnDemand(refControl: TWinControl;
  var lb: TListBox): TForm;
var
  ppos: TPoint;
begin
  Result := TForm.Create(refControl.Owner);
  with Result do
  begin {try}
    ppos := refControl.ClientToScreen(Point(0, 0));
    SetBounds(ppos.X, ppos.Y, 200, 200);
    BorderStyle := bsToolWindow;//bsNone;
    With TPanel.Create(Result) do
    begin
      Parent := Result;
      Align := AlTop;
      BevelInner := bvNone;
      BevelOuter := bvNone;
      InsertControl(TLabel.Create(Result));
      With Controls[0] as TLabel do
      begin
        AutoSize := False;
        Alignment := taCenter;
        SetBounds(2, 2, Parent.ClientWidth - 2, Parent.ClientHeight - 2);
        WordWrap := True;
        Caption := M_GCSQL_DoubleClickOrEnterItem
      end;
    end;
    lb := TListBox.Create( Result );
    With lb do
    begin
      Parent := Result;
      Align := alClient;
      OnDblClick := frmGenCustomSQL.Auxlbondblclick;
      OnKeyPress := FrmGenCustomSQL.Auxlbonkeypress;
    end;
    with TBitBtn.Create(Result) do
    begin
      Parent := Result;
      Align := alBottom;
      Kind := bkCancel;
    end;
  {except
    Result.Free;
    Result := nil;}
  end
end;

procedure TfrmGenCustomSQL.Auxlbondblclick(Sender: TObject);
begin
  With Sender as TListBox do
    if ItemIndex > -1
    then (Owner as TForm).ModalResult := mrOk
end;

procedure TFrmGenCustomSQL.Auxlbonkeypress(Sender: TObject; var Key: Char);
begin
  With Sender as TListBox do
    if (ItemIndex > -1) and (Key = #13)
    then (Owner as TForm).ModalResult := mrOk
end;


procedure TfrmGenCustomSQL.InitValues(cn: TIB_Connection;
  eMemo, iMemo, dMemo: TMemo);
begin
  stProc.Caption := '';
  AConnection := cn;
  editMemo := eMemo;
  insertMemo := iMemo;
  deleteMemo := dMemo;
  if Assigned(AConnection)
    and (Assigned(editMemo) or Assigned(insertMemo) or Assigned(deleteMemo))
  then with AConnection.SchemaCache, cbTables, Items do
    if ProcedureNames.Count > 0
    then begin
      Assign(TableNames);
      Enabled := Count > 0;
      BitBtnProc.Enabled := Count > 0;
      lbFields.Enabled := Count > 0
    end;
  EnableGUI(false)
end;

procedure TfrmGenCustomSQL.StringGridProcDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  AColumn, ARow: Longint;
begin
  StringGridProc.MouseToCell(X, Y, AColumn, ARow);
  Accept := (AColumn = 1) and (ARow > 0) and (stProc.Caption <> '')
    and ((Source = lbFields) or (Source = ShapeValue))
end;

const
  ThisIsUnassigned = nil;
  ThisIsField = TObject(1);
  ThisIsOldField = TObject(2);
  ThisIsValue = TObject(3);
  ThisIsNull = TObject(4);

function TfrmGenCustomSQL.MkOld(const tblName: string): String;
var
  off, xpos: Integer;
  fn: String;
begin
  Result := tblName;
  if Length(Result) = 0
  then Exit;
  xpos := getLitSafePos('.', Result, 1);
  if xpos > 0
  then fn := Copy(tblName, 1, xpos - 1)
  else fn := Result;
  off := Ord(tblName[1] = ':') + Ord(AConnection.SQLDialect > 1);
  if Pos('OLD_', fn) <> off + 1
  then Insert('OLD_', Result, off + 1);
end;

function TfrmGenCustomSQL.StOld(const tblName: String): String;
var
  off, xpos: Integer;
  fn: String;
begin
  Result := tblName;
  if Length(Result) = 0
  then Exit;
  xpos := getLitSafePos('.', Result, 1);
  if xpos > 0
  then fn := Copy(tblName, 1, xpos -1)
  else fn := Result;
  off := Ord(tblName[1] = ':') + Ord(AConnection.SQLDialect > 1);
  if Pos('OLD_', fn) = off + 1
  then Delete(Result, off + 1, 4)
end;

procedure TfrmGenCustomSQL.StringGridProcDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  AColumn, ARow: Longint;
  s: String;
begin
  With StringGridProc do
  begin
    MouseToCell(X, Y, AColumn, ARow);
    if AColumn <> 1
    then raise
      Exception.Create('Logic error, only "Value" column should be accepted.');
    // Magic for dialect 3 syntax.
    if Source = lbFields
    then begin
      if WasAltPressed
      then s := MkOld(cbTables.Text)
      else s := cbTables.Text;
      with lbFields do
        Cells[AColumn, ARow] := ':' + s + '.' + Items[ItemIndex];
      if WasAltPressed
      then Objects[AColumn, ARow] := ThisIsOldField
      else Objects[AColumn, ARow] := ThisIsField;
      BitBtnApply.Enabled := CheckGrid
    end
    else if Source = ShapeValue
    then begin
      if WasAltPressed
      then begin
        Cells[AColumn, ARow] := '<NULL>';
        Objects[AColumn, ARow] := ThisIsNull
      end
      else if InputQuery(M_GCSQL_ParameterValue, Format (M_GCSQL_TypeAValueFor, [Cells[0, ARow]]), s)
      then begin
        Cells[AColumn, ARow] := s;
        Objects[AColumn, ARow] := ThisIsValue;
        BitBtnApply.Enabled := CheckGrid
      end
    end
    else raise
      Exception.Create('Logic error, the grid should not accept this drag operation.')
  end
end;

procedure TfrmGenCustomSQL.FormCreate(Sender: TObject);
begin
  With StringGridProc do
  begin
    ColWidths[1] := ClientWidth - CellRect(0,0).Right - GridLineWidth - 2
      {- GetSystemMetrics(SM_CYHSCROLL)};
    Cells[0, 0] := C_SG_Parameter;
    Cells[1, 0] := C_SG_Value;
  end
end;

procedure TfrmGenCustomSQL.lbFieldsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (lbFields.Items.Count > 0) and (Button = mbLeft)
    and (Shift - [ssAlt] = [ssLeft]) and (stProc.Caption <> '')
  then begin
    lbFields.BeginDrag(False);
    WasAltPressed := ssAlt in Shift
  end
end;

procedure TfrmGenCustomSQL.cbTablesChange(Sender: TObject);
begin
  if cbTables.Items.Count < 1
  then Exit;
  AConnection.SchemaCache.GetTableFields(cbTables.Text, lbFields.Items)
end;

procedure TfrmGenCustomSQL.chbAllClick(Sender: TObject);
begin
  BitBtnApply.Enabled := CheckGrid
end;

procedure TfrmGenCustomSQL.BitBtnProcClick(Sender: TObject);
var
  lbTemp: TListBox;
  pname: String;
  plist: TStringList;
  ProcIsValid: Boolean;
begin
  pname := '';
  ProcIsValid := False;
  With IBF_GenCustomSQL.CreateDialogOnDemand(StringGridProc, lbTemp)
  do try
    lbTemp.Items.Assign(AConnection.SchemaCache.ProcedureNames);
    if ShowModal = mrOk
    then pname := lbTemp.Items[lbTemp.ItemIndex]
  finally
    Free
  end;
  if pname = ''
  then Exit;
  // I had to use this intermediate step because TIB_StringList
  // doesn't honor Count call, it always returns 1 and Assing from
  // other component produces one line
  EnableGUI(false);
  plist := TStringList.Create;
  lbFields.Enabled := False;
  stProc.Caption := '';
  With StringGridProc, Cols[0] do
  try
    BeginUpdate;
    //ShowMessage(IntToStr(AConnection.SchemaCache.ProcedureParams.Count));
    //plist.AddStrings(AConnection.SchemaCache.ProcedureParams);
    // This is the only that works!
    AConnection.SchemaCache.GetProcedureParamNames(pname, true, plist);
    if plist.Count = 0
    then RowCount := 2
    else RowCount := plist.Count + 1;
    Clear;
    Cols[1].Clear;
    Cells[0, 0] := C_SG_Parameter;
    Cells[1, 0] := C_SG_Value;
    AddStrings(plist);
    if plist.Count > 0
    then ProcIsValid := True
  finally
    EndUpdate;
    plist.Free
  end;
  if ProcIsValid then begin
    lbFields.Enabled := True;
    stProc.Caption := pname;
    EnableGUI(true);
  end
  else ShowMessage(M_GCSQL_ProcedureWithoutParams)
end;

procedure TfrmGenCustomSQL.EnableGUI(val: Boolean);
begin
  val := val and (stProc.Caption <> '');
  chbEdit.Enabled := val and Assigned(editMemo);
  chbInsert.Enabled := val and Assigned(insertMemo);
  chbDelete.Enabled := val and Assigned(deleteMemo);
  if val
  then BitBtnApply.Enabled := val and CheckGrid
  else BitBtnApply.Enabled := val
end;

function TfrmGenCustomSQL.CheckGrid: Boolean;
var
  iter: Integer;
begin
  Result := {cbTables.Enabled
    and} (chbEdit.Enabled or chbInsert.Enabled or chbDelete.Enabled)
    and (chbEdit.Checked or chbInsert.Checked or chbDelete.Checked);
  if Result then
  with StringGridProc do
    for iter := 1 to RowCount - 1 do
    begin
      Result := Result and Assigned(Objects[1, iter]);
      if not Result
      then Exit
    end
end;

procedure TfrmGenCustomSQL.GenCustomSQL(slOutput: TStringList; gen_action: char);
var
  iter: Integer;
  aux: String;
  whatIs: TObject;
begin
  slOutput.Clear;
  gen_action := UpCase(gen_action);
  if not (gen_action in ['E', 'I', 'D'])
  then Exit;
  slOutput.Add('EXECUTE PROCEDURE ' + stProc.Caption + '(');
  with StringGridProc do
  for iter := 1 to RowCount - 1 do
  begin
    whatIs := Objects[1, iter];
    if not Assigned(whatIs)
    then raise Exception.Create('Found unassigned cell in the grid')
    else if whatIs = ThisIsField
    then begin
      if gen_action = 'D'
      then slOutput.Add('   ' + MkOld(Cells[1, iter]) + ',')
      else slOutput.Add('   ' + Cells[1, iter] + ',')
    end
    else if whatIs = ThisIsOldField
    then begin
      if gen_action = 'I'
      then slOutput.Add('   ' + StOld(Cells[1, iter]) + ',')
      else slOutput.Add('   ' + Cells[1, iter] + ',')
    end
    else if whatIs = ThisIsValue
    then begin
      if chbTryToUseNumber.Checked
      then try
        StrToFloat(Cells[1, iter]);
        aux := Cells[1, iter]
      except
        aux := '''' + Cells[1, iter] + ''''
      end
      else aux := '''' + Cells[1, iter] + '''';
      slOutput.Add('   ' + aux + ',')
    end
    else if whatIs = ThisIsNull
    then slOutput.Add('   NULL,')
    else raise Exception.Create('Found unrecognized cell in the grid')
  end;
  aux := slOutput[slOutput.Count -1];
  aux[Length(aux)] := ')';
  slOutput[slOutput.Count - 1] := aux;
end;

procedure TfrmGenCustomSQL.BitBtnApplyClick(Sender: TObject);
var
  slOutput: TStringList;
  goEdit, goInsert, goDelete: Boolean;
begin
  goEdit := chbEdit.Enabled and chbEdit.Checked;
  goInsert := chbInsert.Enabled and chbInsert.Checked;
  goDelete := chbDelete.Enabled and chbDelete.Checked;
  if not (goEdit or goInsert or goDelete)
  then Exit;
  slOutput := TStringList.Create;
  try
    if goEdit
    then begin
      GenCustomSQL(slOutput, 'E');
      editMemo.Lines.Assign(slOutput)
    end;
    if goInsert
    then begin
      GenCustomSQL(slOutput, 'I');
      insertMemo.Lines.Assign(slOutput)
    end;
    if goDelete
    then begin
      GenCustomSQL(slOutput, 'D');
      deleteMemo.Lines.Assign(slOutput)
    end
  finally
    slOutput.Free
  end
end;

procedure TfrmGenCustomSQL.ShapeValueMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if {(lbFields.Items.Count > 0) and} (Button = mbLeft)
    and (Shift - [ssAlt] = [ssLeft]) and (stProc.Caption <> '')
  then begin
    ShapeValue.BeginDrag(False);
    WasAltPressed := ssAlt in Shift
  end
end;

end.
