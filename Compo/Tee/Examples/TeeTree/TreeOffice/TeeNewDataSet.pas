{************************************************}
{   TeeChart Office - DataSet Creation / Editing }
{   Copyright (c) 2001 by David Berneda          }
{   All Rights Reserved.                         }
{************************************************}
unit TeeNewDataSet;
{$I TeeDefs.inc}

interface

{$IFNDEF D5}
{$UNDEF TEEENTERPRISE}
{$ENDIF}

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QButtons, QExtCtrls,
  QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  {$ENDIF}
  {$IFDEF TEEENTERPRISE}
  {$IFNDEF LINUX}
  ADODB,
  {$ENDIF}
  {$ENDIF}
  Db, SysUtils, Classes;

type
  TNewDataSet = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    DatabaseStyle: TRadioGroup;
    TabBDE: TTabSheet;
    Label1: TLabel;
    ComboAlias: TComboBox;
    SpeedButton1: TSpeedButton;
    ButtonBack: TButton;
    ButtonNext: TButton;
    Button3: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ComboTables: TComboBox;
    Memo1: TMemo;
    TabADO: TTabSheet;
    Label2: TLabel;
    ADOConnection: TMemo;
    Button4: TButton;
    RadioButton3: TRadioButton;
    ComboADOTables: TComboBox;
    RadioButton4: TRadioButton;
    MemoADO: TMemo;
    procedure ButtonNextClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonBackClick(Sender: TObject);
    procedure ComboAliasChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Memo1Enter(Sender: TObject);
    procedure ComboTablesEnter(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure ComboTablesChange(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure MemoADOEnter(Sender: TObject);
    procedure ComboADOTablesEnter(Sender: TObject);
  private
    { Private declarations }
    {$IFDEF TEEENTERPRISE}
    ADOConnection1: TADOConnection;
    {$ENDIF}
  public
    { Public declarations }
    Function CreateDataSet(AOwner:TComponent):TDataSet;
    Procedure SetOptions(ASource:TComponent);
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$IFDEF D6}
{$WARN UNIT_PLATFORM OFF}
{$ENDIF}

Uses {$IFNDEF CLX}
     DbTables,
     {$IFDEF TEEENTERPRISE}
     ADOConEd,
     {$ENDIF}
     {$ENDIF}
     {$IFNDEF LINUX}
     FileCtrl,
     {$ENDIF}
     {$IFDEF TEETRANSLATE}
     TeeTranslate,
     {$ENDIF}
     TeeProcs, TeeOfficeConstants;

procedure TNewDataSet.ButtonNextClick(Sender: TObject);
begin { Go Next }
  with PageControl1 do
  begin
    if ActivePage=TabSheet1 then
    begin
      TabSheet1.TabVisible:=False;
      {$IFDEF TEEENTERPRISE}
      Case DatabaseStyle.ItemIndex of
        0: ActivePage:=TabADO;
        1: ActivePage:=TabBDE;
      end;
      {$ELSE}
      ActivePage:=TabBDE;
      {$ENDIF}
      ActivePage.TabVisible:=True;
      PageControl1Change(Self);
    end
    else
      ModalResult:=mrOk;
  end;
  ButtonBack.Enabled:=True;
end;

procedure TNewDataSet.PageControl1Change(Sender: TObject);
begin { Go Next }
  if PageControl1.ActivePage=TabBDE then
     Session.GetAliasNames(ComboAlias.Items);

  if PageControl1.ActivePage<>TabSheet1 then
     ButtonNext.Caption:=TeeMsg_Close;
end;

Function TNewDataSet.CreateDataSet(AOwner:TComponent):TDataSet;
begin
  { create a data-set object }
  if PageControl1.ActivePage=TabADO then
  begin
     {$IFDEF TEEENTERPRISE}
     if RadioButton3.Checked then
     begin
       { ADO Table }
       result:=TADOTable.Create(AOwner);
       with TADOTable(result) do
       begin
         Name:='ADOTable1';
         ConnectionString:=ADOConnection.Text;
         TableName:=ComboADOTables.Text;
         ReadOnly:=True;
       end;
     end
     else
     begin
       { ADO SQL Query }
       result:=TADOQuery.Create(AOwner);
       with TADOQuery(result) do
       begin
         Name:='ADOQuery1';
         ConnectionString:=ADOConnection.Text;
         SQL.Assign(MemoADO.Lines);
       end;
     end
     {$ELSE}
     result:=nil;
     {$ENDIF}
  end
  else
  begin
     if RadioButton1.Checked then
     begin
       { BDE Table }
       result:=TTable.Create(AOwner);
       with TTable(result) do
       begin
         Name:=TeeGetUniqueName(AOwner,TeeMsg_Table);
         DatabaseName:=ComboAlias.Text;
         TableName:=ComboTables.Text;
         ReadOnly:=True;
       end;
     end
     else
     begin
       { BDE SQL Query }
       result:=TQuery.Create(AOwner);
       with TQuery(result) do
       begin
         Name:=TeeGetUniqueName(AOwner,TeeMsg_Query);
         DatabaseName:=ComboAlias.Text;
         SQL.Assign(Memo1.Lines);
       end;
     end;
  end;
  result.Open;
end;

procedure TNewDataSet.SpeedButton1Click(Sender: TObject);
var tmp : String;
begin { Select a BDE folder }
  if SelectDirectory(TeeMsg_SelectFolder,'',tmp) then
     with ComboAlias do ItemIndex:=Items.Add(tmp);
end;

procedure TNewDataSet.Button3Click(Sender: TObject);
begin { cancel dialog }
  ModalResult:=mrCancel;
end;

procedure TNewDataSet.ButtonBackClick(Sender: TObject);
begin { Go Back }
  with PageControl1 do
  begin
    TabADO.TabVisible:=False;
    TabBDE.TabVisible:=False;
    ActivePage:=TabSheet1;
    ActivePage.TabVisible:=True;
  end;
end;

procedure TNewDataSet.ComboAliasChange(Sender: TObject);
begin { fill BDE Table names for selected BDE Alias }
  Session.GetTableNames(ComboAlias.Text,'',True,True,ComboTables.Items);
  ComboTables.Enabled:=ComboTables.Items.Count>0;
end;

procedure TNewDataSet.FormCreate(Sender: TObject);
begin
  {$IFDEF TEEENTERPRISE}
  ADOConnection1:=nil;
  {$ELSE}
  DatabaseStyle.Items.Delete(0); { remove "ADO" option }
  {$ENDIF}
  TabADO.TabVisible:=False;
  TabBDE.TabVisible:=False;
  {$IFDEF TEETRANSLATE}
  TeeTranslateControl(Self);
  {$ENDIF}
end;

procedure TNewDataSet.RadioButton2Click(Sender: TObject);
begin
  Memo1.SetFocus;
end;

procedure TNewDataSet.Memo1Enter(Sender: TObject);
begin
  RadioButton2.Checked:=True;
end;

procedure TNewDataSet.ComboTablesEnter(Sender: TObject);
begin
  RadioButton1.Checked:=True;
end;

procedure TNewDataSet.RadioButton1Click(Sender: TObject);
begin
  ComboTables.SetFocus;
end;

procedure TNewDataSet.ComboTablesChange(Sender: TObject);
begin
  ButtonNext.Enabled:=True;
end;

procedure TNewDataSet.Memo1Change(Sender: TObject);
begin
  ButtonNext.Enabled:=True;
end;

procedure TNewDataSet.Button4Click(Sender: TObject);
begin { Select a new ADO Connection string }
  {$IFDEF TEEENTERPRISE}
  if not Assigned(ADOConnection1) then
     ADOConnection1:=TADOConnection.Create(Self);

  if EditConnectionString(ADOConnection1) then
  begin
    ADOConnection.Text:=ADOConnection1.ConnectionString;
    ADOConnection1.GetTableNames(ComboADOTables.Items);
  end;
  {$ENDIF}
end;

procedure TNewDataSet.RadioButton3Click(Sender: TObject);
begin
  ComboADOTables.SetFocus;
end;

procedure TNewDataSet.RadioButton4Click(Sender: TObject);
begin
  MemoADO.SetFocus;
end;

procedure TNewDataSet.MemoADOEnter(Sender: TObject);
begin
  RadioButton4.Checked:=True;
end;

procedure TNewDataSet.ComboADOTablesEnter(Sender: TObject);
begin
  RadioButton3.Checked:=True;
end;

procedure TNewDataSet.SetOptions(ASource: TComponent);
begin
  {$IFDEF TEEENTERPRISE}
  if ASource is TCustomADODataSet then
  begin
    DatabaseStyle.ItemIndex:=0;
    ADOConnection.Text:=TCustomADODataSet(ASource).ConnectionString;
  end
  else
  {$ENDIF}
  begin
    DatabaseStyle.ItemIndex:=1;
    ComboAlias.Text:=TDBDataSet(ASource).DatabaseName;
    ComboAliasChange(Self);
    if ASource is TTable then
    begin
      ComboTables.Text:=TTable(ASource).TableName;
      ComboTables.ItemIndex:=ComboTables.Items.IndexOf(TTable(ASource).TableName);
    end
    else
       Memo1.Lines:=TQuery(ASource).SQL;
  end;
end;

end.
