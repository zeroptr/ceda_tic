unit ufrmSDLG;
interface
uses
  Windows, Messages, SysUtils, Classes,  Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, IB_Grid, IB_Components, Grids,Graphics;
type
  TfrmSrcDlg = class(TForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    cmdOK: TBitBtn;
    cmdCancel: TBitBtn;
    txtAra: TEdit;
    btnAra: TButton;
    cboFields: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    qrySRCDLG: TIB_Query;
    IB_DataSource1: TIB_DataSource;
    grdSel: TIB_Grid;
    Function List(ColumnCount : Byte ; Columns : TStringList ; AnaSQL : String ; WhereClouse : String ; SortedColumn : integer; HidedColumnCount : Integer ):Boolean;
    procedure cmdOKClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cboFieldsClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure txtAraKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cboFieldsEnter(Sender: TObject);
    procedure cboFieldsExit(Sender: TObject);
    procedure txtAraEnter(Sender: TObject);
    procedure txtAraExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtAraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    prAnaSql,prWhereClouse : String;
    PrKolonlar : TStringList;
    prKolSay : Byte;
    Cancelled : Boolean;
    SColumn,prHidedColumnCount : Integer;
  public
    { Public declarations }
  end;
var
  frmSrcDlg: TfrmSrcDlg;

implementation

uses unDataMod,unFUNC;

{$R *.DFM}

Function TfrmSrcDlg.List(ColumnCount : Byte ; Columns : TStringList ; AnaSQL : String ;
  WhereClouse : String ; SortedColumn : integer; HidedColumnCount : Integer ):Boolean;
{Burak ÖZLER}
var
  i,v,j :Integer;
begin
  with frmSrcDlg do
  begin
    prAnaSql := AnaSQL;
    prWhereClouse := WhereClouse;
    PrKolonlar := Columns;
    prKolSay := ColumnCount;
    cboFields.Items.Clear;
    SColumn := SortedColumn;
    prHidedColumnCount := HidedColumnCount;
    v := 1;
    //qrySRCDLG.Fields[0].Visible := False;
    for i := 1  to ColumnCount do
    begin
      frmSrcDlg.cboFields.Items.Add(Columns[V]);
      V := V + 3;
    end;
  end;

  if frmSrcDlg.cbofields.Items.Count <= SortedColumn then
  begin
    frmSrcDlg.cboFields.ItemIndex := 0
  end
  else
  begin
    frmSrcDlg.cboFields.ItemIndex := SortedColumn;
  end;

  frmSrcDlg.cboFieldsClick(Self);
  for j:=0 to ColumnCount-1 Do
  begin
    frmSrcDlg.qrySRCDLG.Fields[j].DisplayWidth := StrToInt(Columns[(j*3)+2]);
    frmSrcDlg.qrySRCDLG.Fields[j].DisplayLabel  := Columns[(j*3)+1];
  end;
  frmSrcDlg.ShowModal;

  Columns.Clear;
  if not Cancelled and (frmSrcDlg.qrySRCDLG.RecordCount <> 0)  Then
  begin
    for i := 0 to frmSrcDlg.qrySRCDLG.Fields.ColumnCount - 1 Do
    begin
      Columns.Add(frmSrcDlg.qrySRCDLG.Fields[i].AsString);
    end;
  end
  else
  begin
    Columns.add('CNC-LLD');
  end;
  frmSrcDlg.qrySRCDLG.Close;
  frmSrcDlg.Release;
  Result := True;
end;

procedure TfrmSrcDlg.cmdOKClick(Sender: TObject);
begin
  if qrySRCDLG.RecordCount<=0 then exit;
  if Trim(qrySRCDLG.Fields[0].AsString)='' then exit;
  Cancelled := False;
  Close;
end;

procedure TfrmSrcDlg.cmdCancelClick(Sender: TObject);
begin
  Cancelled := True;
  Close;
end;

procedure TfrmSrcDlg.cboFieldsClick(Sender: TObject);
var
i,v:Byte;
begin
  Screen.Cursor := crHourGlass;
  with qrySRCDLG do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(prAnaSql);
    SQL.Add(' ' + prWhereClouse);
    SQL.Add(' Order By ' + PrKolonlar[cboFields.ItemIndex * 3]);
    //ShowMessage(Sql.Text);
  end;
  try
    qrySRCDLG.Active := True;
  except
    ShowMessage('Sorguyu iþletirken hata oluþtu ');
    Screen.Cursor := crDefault;
    cmdCancelClick(Self);
  end;
  if prHidedColumnCount <> 0 then
  begin
    V := 1;
    for i := 0 to prHidedColumnCount-1 do
    begin
      qrySRCDLG.Fields[i].Visible := False;
    end;

    //ibo kaldýrýldý
    for i := prHidedColumnCount  to (prHidedColumnCount+prKolSay)-1 do
    begin
      qrySRCDLG.Fields[i].GridDisplayLabel := PrKolonlar[v];
      qrySRCDLG.Fields[i].DisplayWidth := StrToInt(prKolonlar[v+1]);
      V := V + 3;
    end;

  end;
  Screen.Cursor := crDefault;
end;

procedure TfrmSrcDlg.btnAraClick(Sender: TObject);
var
  Aranan : Variant;
  Bulundu: Boolean;
begin
  if cboFields.ItemIndex = -1 then
  begin
    ShowMessage(' Mutlaka bir Saha Seçmelisiniz! ');
    exit;
  end;
  Aranan := txtAra.Text;
  Bulundu := qrySRCDLG.Locate(PrKolonlar[(cboFields.ItemIndex) * 3],Aranan,[LopPartialKey,LopCaseinsensitive]);
  //if Bulundu then grdSel.SetFocus;
  txtAra.SetFocus;
end;

procedure TfrmSrcDlg.txtAraKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    //btnAraClick(txtAra);
    cmdOKClick(Self);
    Exit;
  end;
  if not isDigit(Key) then Key := toUpper(Key);
  btnAraClick(Self);
end;

procedure TfrmSrcDlg.FormShow(Sender: TObject);
begin
  Cancelled := False;
end;

procedure TfrmSrcDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ActiveControl.Name = 'grdSel' Then
  begin
    if Key=#13 Then
    begin
      cmdOKClick(self);
    end;
  end;
end;

procedure TfrmSrcDlg.cboFieldsEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSrcDlg.cboFieldsExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmSrcDlg.txtAraEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSrcDlg.txtAraExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmSrcDlg.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(Self);
end;

procedure TfrmSrcDlg.txtAraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if Key=Vk_Up then
     begin
          if not qrySRCDLG.Bof then
          qrySRCDLG.Prior;
     end;
     if Key=Vk_Down then
     begin
          if not qrySRCDLG.Eof then
          qrySRCDLG.Next;
     end;

end;

end.
