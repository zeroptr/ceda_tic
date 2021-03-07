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
{  ©Copyright 1997, P&R Software, Inc.                                         }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_LedgerEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,

{$IFDEF IBO_VCL60_OR_GREATER}
  DesignIntf, DesignEditors,
{$ELSE}
  DsgnIntf,
{$ENDIF}

  TypInfo, IB_Ledger, ComCtrls, Grids;

type
  TdlgIB_LedgerSetup = class(TForm)
    btnOk: TButton;
    btnPreview: TButton;
    btnCancel: TButton;
    ColorDialog1: TColorDialog;
    CellProperties: TGroupBox;
    cbFieldName: TComboBox;
    btnReset: TButton;
    btnHelp: TButton;
    GroupBox1: TGroupBox;
    AddRow: TSpeedButton;
    DelRow: TSpeedButton;
    UpRow: TSpeedButton;
    DnRow: TSpeedButton;
    lbRows: TListBox;
    Label6: TLabel;
    ColorPanel: TPanel;
    ColorCombo: TComboBox;
    Bevel1: TBevel;
    AddCell: TSpeedButton;
    DelCell: TSpeedButton;
    UpCell: TSpeedButton;
    DnCell: TSpeedButton;
    lbCells: TListBox;
    Label5: TLabel;
    RowProperties: TPanel;
    Label4: TLabel;
    Display: TLabel;
    Label3: TLabel;
    Width: TEdit;
    edDispName: TEdit;
    cbAllowClickTitle: TCheckBox;
    cbIndicateSort: TCheckBox;
    Panel1: TPanel;
    rbFixed: TRadioButton;
    rbVariable: TRadioButton;
    Panel2: TPanel;
    rbLeft: TRadioButton;
    rbCenter: TRadioButton;
    rbRight: TRadioButton;
    Panel3: TPanel;
    rbTLeft: TRadioButton;
    rbTCenter: TRadioButton;
    rbTRight: TRadioButton;
    cbPreview: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure lbRowsClick(Sender: TObject);
    procedure lbCellsClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure DnRowClick(Sender: TObject);
    procedure UpRowClick(Sender: TObject);
    procedure DelRowClick(Sender: TObject);
    procedure AddRowClick(Sender: TObject);
    procedure AddCellClick(Sender: TObject);
    procedure DelCellClick(Sender: TObject);
    procedure UpCellClick(Sender: TObject);
    procedure DnCellClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbAllowClickTitleClick(Sender: TObject);
    procedure cbIndicateSortClick(Sender: TObject);
    procedure WidthExit(Sender: TObject);
    procedure edDispNameExit(Sender: TObject);
    procedure cbFieldNameChange(Sender: TObject);
    procedure ColorComboDblClick(Sender: TObject);
    procedure ColorComboExit(Sender: TObject);
    procedure WidthTypeValueClick (Sender : TObject);
    procedure AlignmentValueClick (Sender : TObject);
    procedure TitleAlignValueClick (Sender : TObject);
    procedure cbPreviewClick(Sender: TObject);
  private
    { Private declarations }
    FLedger: TIB_Ledger;
    FWorkRowDefs, FSaveRowDefs: TIB_LedgerRowDefs;
    FModified: boolean;
    SettingCell: boolean;
    FWidthTypeValue : Integer;
    procedure SetLedger( ALedger: TIB_Ledger );
    procedure UpdateCellList;
    procedure SetCell(index: integer);
    procedure SetRow(index: integer);
    procedure LoadSetup;
    procedure ApplySetup;
    procedure AddColors(const S: string);
    procedure ConfirmColor;
    procedure putModified (Value : Boolean);
  public
    { Public declarations }
  published
    property WidthTypeValue : Integer     read FWidthTypeValue  write FWidthTypeValue;
    property Ledger         : TIB_Ledger  read FLedger          write SetLedger;
    property Modified       : Boolean     read FModified        write putModified;
  end;

  TIB_LedgerRowDefsProperty = class(TClassProperty)
  public
    function GetValue: string; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TIB_LedgerEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

var
  dlgIB_LedgerSetup: TdlgIB_LedgerSetup;

const
  undefined_field = '<undefined>';

implementation

{$R *.DFM}

procedure TdlgIB_LedgerSetup.SetLedger( ALedger: TIB_Ledger );
begin
  FLedger := ALedger;

  {Attempt to open dataset}
  if (FLedger.DataSource <> nil) and (FLedger.Datasource.Dataset <> nil) then
  with FLedger.DataSource do
  begin
    CellProperties.Caption := ' Add Columns from dataset ['+Dataset.Name+'] ';
    if Dataset.Active = False then
    try
      FLedger.DataSource.Dataset.Open;
    except
      ShowMessage('Unable to open dataset.');
    end;
  end;

  { Make a copy of the row defs structure in the ledger }
  FSaveRowDefs := TIB_LedgerRowDefs.Create( ALedger );
  FSaveRowDefs.Assign( Ledger.RowDefs );

  { create a row defs to work with and copy the ledger's row defs to it }
  FWorkRowDefs := TIB_LedgerRowDefs.Create( ALedger );
  FWorkRowDefs.Assign( ALedger.RowDefs );

  LoadSetup;
end;

procedure TdlgIB_LedgerSetup.ApplySetup;
begin
  FLedger.RowDefs := FWorkRowDefs;
end;

procedure TdlgIB_LedgerSetup.btnResetClick(Sender: TObject);
begin
  btnReset.SetFocus;
  if (not Modified) or
     (MessageDlg( 'Ledger Setup has been modified.  Lose changes ?',
                  mtWarning, [mbYes, mbNo], 0) = mrYes) then begin
    FWorkRowDefs.Assign(FSaveRowDefs);
    LoadSetup;
    ApplySetup;
  end;
end;

procedure TdlgIB_LedgerSetup.LoadSetup;
var
  ii: integer;
begin
  cbFieldName.Items.Clear;
  cbFieldName.Items.Add( undefined_field );
  if Assigned( Ledger.DataSource ) and
     Assigned( Ledger.DataSource.DataSet ) then
    with Ledger.DataSource.DataSet do
    begin
      Prepare;
      for ii := 0 to Fields.ColumnCount - 1 do
        cbFieldName.Items.Add( Fields[ii].FieldName );
      cbFieldName.ItemIndex := 0;
    end;
  lbRows.Items.Clear;
  for ii := 0 to FWorkRowDefs.Count - 1 do
    lbRows.Items.AddObject( FWorkRowDefs[ii].RowName, FWorkRowDefs[ii] );
  SetRow( 0 );
  Modified := false;
end;

procedure TdlgIB_LedgerSetup.putModified (Value : Boolean);
begin
  if cbPreview.Checked then
    btnPreviewClick(btnPreview);
  FModified := Value;
end;

procedure TdlgIB_LedgerSetup.SetCell(index: integer);
var
  cell: TIB_LedgerCellDefItem;
  name: string;
begin
  if (lbCells.Items.Count > 0) and (index < lbCells.Items.Count) then begin
    lbCells.ItemIndex := index;

    cell := TIB_LedgerCellDefItem(lbCells.Items.Objects[lbCells.ItemIndex]);

    SettingCell := true;

    case cell.WidthType of
      laFixed         : WidthTypeValueClick(rbFixed);
      laVariable      : WidthTypeValueClick(rbVariable);
    end;

    case cell.Alignment of
      taLeftJustify   : AlignmentValueClick(rbLeft);
      taCenter        : AlignmentValueClick(rbCenter);
      taRightJustify  : AlignmentValueClick(rbRight);
    end;

    case cell.TitleAlignment of
      taLeftJustify   : TitleAlignValueClick(rbTLeft);
      taCenter        : TitleAlignValueClick(rbTCenter);
      taRightJustify  : TitleAlignValueClick(rbTRight);
    end;

    Width.Text := IntToStr(cell.Width);

    edDispName.Text := cell.DispName;

    name := TIB_LedgerCellDefItem(lbCells.Items.Objects[lbCells.ItemIndex]).FieldName;
    if name = '' then
      cbFieldName.ItemIndex := 0
    else
      cbFieldName.ItemIndex := cbFieldName.Items.IndexOf(name);

    cbAllowClickTitle.Checked := cell.AllowClickTitle;

    cbIndicateSort.Checked := cell.IndicateSort;

    SettingCell := false;

    CellProperties.Visible := true;
  end else begin
    CellProperties.Visible := false;
  end;
end;

procedure TdlgIB_LedgerSetup.SetRow(index: integer);
begin
  if (lbRows.Items.Count > 0) and (index < lbRows.Items.Count)then
  begin
    lbRows.ItemIndex := index;

    ColorPanel.Color := TIB_LedgerRowDefItem(lbRows.Items.Objects[lbRows.ItemIndex]).Color;
    ColorCombo.Text := ColorToString(ColorPanel.Color);
    UpdateCellList;
    SetCell(0);
    RowProperties.Visible := true;
  end
  else
  begin
    RowProperties.Visible := false;
  end;
end;

procedure TdlgIB_LedgerSetup.btnCancelClick(Sender: TObject);
begin
  btnCancel.SetFocus;
  if (not Modified) or (MessageDlg('Ledger Setup has been modified.  Lose changes ?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
  begin
    FWorkRowDefs.Assign(FSaveRowDefs);
    LoadSetup;
    ApplySetup;
    Close;
  end;
end;

procedure TdlgIB_LedgerSetup.UpdateCellList;
var
  i,j: integer;
  name: string;
begin
  LockWindowUpdate(Self.Handle);
  lbCells.Clear;
  if lbRows.ItemIndex <> -1 then
  begin
    i := lbRows.ItemIndex;
    for j := 0 to FWorkRowDefs[i].CellDefs.Count - 1 do
    begin
      with FWorkRowDefs[i] do
      begin
        name := CellDefs[j].FieldName;
        if name = '' then
        begin
          name := undefined_field;
          DisplayName := '';
        end
        else
          DisplayName := Celldefs[j].DispName;
        lbCells.Items.AddObject( name, CellDefs[j] );
      end;
    end;
  end;
  LockWindowUpdate(0);
end;

procedure TdlgIB_LedgerSetup.lbRowsClick(Sender: TObject);
begin
  SetRow(lbRows.ItemIndex);
end;

procedure TdlgIB_LedgerSetup.lbCellsClick(Sender: TObject);
begin
  SetCell(lbCells.ItemIndex);
end;

procedure TdlgIB_LedgerSetup.btnOkClick(Sender: TObject);
begin
  btnOk.SetFocus;
  ApplySetup;
  Close;
end;

procedure TdlgIB_LedgerSetup.btnPreviewClick(Sender: TObject);
begin
  if btnPreview.Visible then
    btnPreview.SetFocus;
  ApplySetup;
end;

procedure TdlgIB_LedgerSetup.WidthExit(Sender: TObject);
var
  cell: TIB_LedgerCellDefItem;
begin
  cell := TIB_LedgerCellDefItem(lbCells.Items.Objects[lbCells.ItemIndex]);
  if cell.Width <> StrToInt(Width.Text) then begin
    try
      cell.Width := StrToInt(Width.Text);
    except
      Width.Text := '0';
      Width.SetFocus;
    end;

    if not SettingCell then Modified := true;
  end;
end;

procedure TdlgIB_LedgerSetup.cbFieldNameChange(Sender: TObject);
var
  cell: TIB_LedgerCellDefItem;
begin
  cell := TIB_LedgerCellDefItem(lbCells.Items.Objects[lbCells.ItemIndex]);
  if cell.FieldName <> cbFieldName.Items[cbFieldName.ItemIndex] then begin
    if cbFieldName.ItemIndex = 0 then begin
      lbCells.Items.Strings[lbCells.ItemIndex] := undefined_field;
      cell.FieldName := '';
    end else begin
      lbCells.Items.Strings[lbCells.ItemIndex] := cbFieldName.Text;
      cell.FieldName := cbFieldName.Items[cbFieldName.ItemIndex];
    end;

    if not SettingCell then Modified := true;
  end;
end;

procedure TdlgIB_LedgerSetup.edDispNameExit(Sender: TObject);
var
  cell: TIB_LedgerCellDefItem;
begin
  cell := TIB_LedgerCellDefItem(lbCells.Items.Objects[lbCells.ItemIndex]);
  if cell.DispName <> edDispName.Text then begin
    cell.DispName := edDispName.Text;
    if not SettingCell then begin
      Modified := true;
    end;
  end;
end;

procedure TdlgIB_LedgerSetup.cbAllowClickTitleClick(Sender: TObject);
var
  cell: TIB_LedgerCellDefItem;
begin
  cell := TIB_LedgerCellDefItem(lbCells.Items.Objects[lbCells.ItemIndex]);
  if cell.AllowClickTitle <> cbAllowClickTitle.Checked then
  begin
    cell.AllowClickTitle := cbAllowClickTitle.Checked;
    if not SettingCell then
      Modified := true;
  end;
end;

procedure TdlgIB_LedgerSetup.cbIndicateSortClick(Sender: TObject);
var
  cell: TIB_LedgerCellDefItem;
begin
  cell := TIB_LedgerCellDefItem(lbCells.Items.Objects[lbCells.ItemIndex]);
  if cell.IndicateSort <> cbIndicateSort.Checked then
  begin
    cell.IndicateSort := cbIndicateSort.Checked;
    if not SettingCell then
      Modified := true;
  end;
end;

procedure TdlgIB_LedgerSetup.AddRowClick(Sender: TObject);
var
  item: TIB_LedgerRowDefItem;
begin
  item := FWorkRowDefs.Add;
  ColorPanel.Color := item.Color;
  ColorCombo.Text := ColorToString(ColorPanel.Color);
  lbRows.Items.AddObject(item.RowName, item);
  SetRow(lbRows.Items.Count-1);
  Modified := true;
end;

procedure TdlgIB_LedgerSetup.DelRowClick(Sender: TObject);
var
  RowDef: TIB_LedgerRowDefItem;
  i: integer;
begin
  if lbRows.ItemIndex = -1 then
    Exit;
  if lbRows.Items.Count = 1 then begin
    MessageDlg('At least one row MUST exist.', mtWarning, [mbOk], 0);
    Exit;
  end;
  RowDef := TIB_LedgerRowDefItem(lbRows.Items.Objects[lbRows.ItemIndex]);
  for i := 0 to  FWorkRowDefs.Count - 1 do begin
    if FWorkRowDefs[i] = RowDef then begin
      FWorkRowDefs.Delete(i);
      break;
    end;
  end;
  i := lbRows.ItemIndex;
  lbRows.Items.Delete(i);
  if i >= lbRows.Items.Count then begin
    i := lbRows.Items.Count - 1;
  end;
  SetRow(i);
  Modified := true;
end;

procedure TdlgIB_LedgerSetup.DnRowClick(Sender: TObject);
var
  i: integer;
begin
  i := lbRows.ItemIndex;
  if i < lbRows.Items.Count-1 then begin
    FWorkRowDefs.Move(i,i+1);
    lbRows.Items.Move(i,i+1);
    SetRow(i+1);
    Modified := true;
  end;
end;

procedure TdlgIB_LedgerSetup.UpRowClick(Sender: TObject);
var
  i: integer;
begin
  i := lbRows.ItemIndex;
  if i > 0 then begin
    FWorkRowDefs.Move(i,i-1);
    lbRows.Items.Move(i,i-1);
    SetRow(i-1);
    Modified := true;
  end;
end;

procedure TdlgIB_LedgerSetup.AddCellClick(Sender: TObject);
var
  row: TIB_LedgerRowDefItem;
begin
  if lbRows.ItemIndex <> -1 then begin
    row := TIB_LedgerRowDefItem(lbRows.Items.Objects[lbRows.ItemIndex]);
    row.CellDefs.Add;
    UpdateCellList;
    SetCell(lbCells.Items.Count-1);
    Modified := true;
  end;
end;

procedure TdlgIB_LedgerSetup.DelCellClick(Sender: TObject);
var
  CellDef: TIB_LedgerCellDefItem;
  i: integer;
begin
  if (lbRows.ItemIndex = -1) or (lbCells.ItemIndex = -1) then
    Exit;

  if lbCells.Items.Count = 1 then begin
    MessageDlg( 'At least one cell MUST exist', mtWarning, [mbOk], 0 );
    Exit;
  end;
  CellDef := TIB_LedgerCellDefItem(lbCells.Items.Objects[lbCells.ItemIndex]);
  with FWorkRowDefs[lbRows.ItemIndex] do begin
    for i := 0 to CellDefs.Count-1 do begin
      if CellDefs[i] = CellDef then begin
        CellDefs.Delete(i);
        break;
      end;
    end;
  end;
  i := lbCells.ItemIndex;
  lbCells.Items.Delete(i);
  if i >= lbCells.Items.Count then begin
    i := lbCells.Items.Count - 1;
  end;
  SetCell(i);
  Modified := true;
end;

procedure TdlgIB_LedgerSetup.UpCellClick(Sender: TObject);
var
  i,j: integer;
begin
  i := lbRows.ItemIndex;
  if i <> -1 then begin
    j := lbCells.ItemIndex;

    if j > 0 then begin
      FWorkRowDefs[i].CellDefs.Move(j,j-1);
      lbCells.Items.Move(j,j-1);
      SetCell(j-1);
    end;
    Modified := true;
  end;
end;

procedure TdlgIB_LedgerSetup.DnCellClick(Sender: TObject);
var
  i,j: integer;
begin
  i := lbRows.ItemIndex;
  if i <> -1 then begin
    j := lbCells.ItemIndex;
    if j < lbCells.Items.Count-1 then begin
      FWorkRowDefs[i].CellDefs.Move(j,j+1);
      lbCells.Items.Move(j,j+1);
      SetCell(j+1);
    end;
    Modified := true;
  end;
end;

procedure TdlgIB_LedgerSetup.AddColors(const S: string);
begin
  if Assigned( ColorCombo ) then
    ColorCombo.Items.Add( S );
end;

procedure TdlgIB_LedgerSetup.FormCreate(Sender: TObject);
begin
  GetColorValues( AddColors );
  FModified := false;
end;

procedure TdlgIB_LedgerSetup.btnHelpClick(Sender: TObject);
begin
  ShowMessage('Not implemented yet');
end;

procedure TdlgIB_LedgerSetup.FormDestroy(Sender: TObject);
begin
  FWorkRowDefs.Free;
  FSaveRowDefs.Free;
end;

procedure TdlgIB_LedgerSetup.ColorComboDblClick(Sender: TObject);
var
  Row: TIB_LedgerRowDefItem;
begin
  if lbRows.ItemIndex <> -1 then begin
    ColorDialog1.Color := ColorPanel.Color;
    if ColorDialog1.Execute then begin
      ColorPanel.Color := ColorDialog1.Color;
      ColorCombo.Text := ColorToString(ColorPanel.Color);
      Row := TIB_LedgerRowDefItem(lbRows.items.Objects[lbRows.ItemIndex]);
      if Row.Color <> ColorPanel.Color then begin
        Row.Color := ColorPanel.Color;
        if not SettingCell then begin
          Modified := true;
        end;
      end;
    end;
  end;
end;

procedure TdlgIB_LedgerSetup.ConfirmColor;
var
  Row: TIB_LedgerRowDefItem;
begin
  try
    ColorPanel.Color := StringToColor(ColorCombo.Text);
    Row := TIB_LedgerRowDefItem(lbRows.items.Objects[lbRows.ItemIndex]);
    if Row.Color <> ColorPanel.Color then begin
      Row.Color := ColorPanel.Color;
      if not SettingCell then begin
        Modified := true;
      end;
    end;
    ColorCombo.Text := ColorToString(ColorPanel.Color);
  except
    ShowMessage( '''' + ColorCombo.Text + ''' is not a valid color' );
    ColorCombo.SetFocus;
  end;
end;

procedure TdlgIB_LedgerSetup.WidthTypeValueClick (Sender : TObject);
var
  cell: TIB_LedgerCellDefItem;
begin
  if WidthTypeValue <> (Sender as TRadioButton).Tag then
    WidthTypeValue := (Sender as TRadioButton).Tag;
  cell := TIB_LedgerCellDefItem(lbCells.Items.Objects[lbCells.ItemIndex]);
  case WidthTypeValue of
    0: begin
         if cell.WidthType <> laFixed then begin
           cell.WidthType := laFixed;
           if not SettingCell then
             Modified := true;
         end;
         if not rbFixed.Checked then
           rbFixed.Checked := True;
       end;
    1: begin
         if cell.WidthType <> laVariable then begin
           cell.WidthType := laVariable;
           if not SettingCell then
             Modified := true;
         end;
         if not rbVariable.Checked then
            rbVariable.Checked := True;
       end;
  end;
end;

procedure TdlgIB_LedgerSetup.AlignmentValueClick (Sender : TObject);
var
  cell: TIB_LedgerCellDefItem;

  procedure CheckAlignment(rb : TRadioButton; al : TAlignment);
  begin
    if cell.Alignment <> al then
      cell.Alignment := al;
    Modified := (cell.Alignment <> al) and not SettingCell;
    if not rb.Checked then rb.Checked := True;
  end;

begin
  cell := TIB_LedgerCellDefItem(lbCells.Items.Objects[lbCells.ItemIndex]);
  case (Sender as TRadioButton).Tag of
    0 : CheckAlignment(rbLeft,   taLeftJustify  );
    1 : CheckAlignment(rbCenter, taCenter       );
    2 : CheckAlignment(rbRight,  taRightJustify );
  end;
end;

procedure TdlgIB_LedgerSetup.TitleAlignValueClick (Sender : TObject);
var
  cell: TIB_LedgerCellDefItem;

  procedure CheckAlignment(rb : TRadioButton; al : TAlignment);
  begin
    if cell.TitleAlignment <> al then
      cell.TitleAlignment := al;
    Modified := (cell.TitleAlignment <> al) and not SettingCell;
    if not rb.Checked then rb.Checked := True;
  end;

begin
  cell := TIB_LedgerCellDefItem(lbCells.Items.Objects[lbCells.ItemIndex]);
  case (Sender as TRadioButton).Tag of
    0 : CheckAlignment(rbTLeft,   taLeftJustify  );
    1 : CheckAlignment(rbTCenter, taCenter       );
    2 : CheckAlignment(rbTRight,  taRightJustify );
  end;
end;

procedure TdlgIB_LedgerSetup.ColorComboExit(Sender: TObject);
begin
  ConfirmColor;
end;

{ Edit Row Definitions }

function EditRowDefs( ALedger: TIB_Ledger ): boolean;
begin
  with TdlgIB_LedgerSetup.Create( Application ) do try
    Ledger := ALedger;
    ShowModal;
    Result := Modified;
  finally
    Free;
  end;
end;

{ TIB_LedgerRowDefsProperty }

function TIB_LedgerRowDefsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TIB_LedgerRowDefsProperty.GetValue: String;
begin
  Result := '(' + GetPropType^.Name + ')';
end;

procedure TIB_LedgerRowDefsProperty.Edit;
begin
  if EditRowDefs( TIB_Ledger( GetComponent( 0 ))) then begin
    Modified;
  end;
end;

{ TIB_LedgerEditor }

procedure TIB_LedgerEditor.ExecuteVerb( Index: Integer );
begin
  if Index = 0 then begin
    if EditRowDefs( TIB_Ledger( Component )) then begin
      Designer.Modified;
    end;
  end;
end;

function TIB_LedgerEditor.GetVerb( Index: Integer ): string;
begin
  if Index = 0 then begin
    Result := '&Rows...';
  end;
end;

function TIB_LedgerEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TdlgIB_LedgerSetup.cbPreviewClick(Sender: TObject);
begin
  if cbPreview.Checked then
    btnPreviewClick(btnPreview);
  btnPreview.Visible := not cbPreview.Checked;
end;

end.


