unit Axes_LabelsFormat;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  {$ENDIF}
  Base, TeeProcs, TeEngine, Chart, Series;

type
  TAxesLabelsFormat = class(TBaseForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Series1: TBarSeries;
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Function LabelsFormat:TTeeShape;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.dfm}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeeCustomShapeEditor;

Function TAxesLabelsFormat.LabelsFormat:TTeeShape;
begin
  case ComboBox1.ItemIndex of
    0: result:=Chart1.Axes.Left.Items.Format;
    1: result:=Chart1.Axes.Top.Items.Format;
    2: result:=Chart1.Axes.Right.Items.Format;
  else result:=Chart1.Axes.Bottom.Items.Format;
  end;
end;

procedure TAxesLabelsFormat.ComboBox1Change(Sender: TObject);
begin
  CheckBox1.Checked:=LabelsFormat.Transparent;
end;

procedure TAxesLabelsFormat.CheckBox1Click(Sender: TObject);
begin
  LabelsFormat.Transparent:=CheckBox1.Checked;
end;

procedure TAxesLabelsFormat.Button1Click(Sender: TObject);
begin
  EditTeeCustomShape(Self,LabelsFormat);
end;

procedure TAxesLabelsFormat.FormCreate(Sender: TObject);
begin
  inherited;
  ComboBox1.ItemIndex:=0;
  Series1.FillSampleValues(5);
end;

initialization
  RegisterClass(TAxesLabelsFormat);
end.
