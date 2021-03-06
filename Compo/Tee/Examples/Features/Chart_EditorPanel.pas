unit Chart_EditorPanel;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  {$ENDIF}
  Base, TeeEdit, TeeProcs, TeEngine, Chart, Series, TeeTools;

type
  TChartEditorPanelForm = class(TBaseForm)
    ChartEditorPanel1: TChartEditorPanel;
    Series1: THorizLineSeries;
    Splitter1: TSplitter;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    ComboBox2: TComboBox;
    ChartTool1: TMarksTipTool;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Chart1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TChartEditorPanelForm.FormCreate(Sender: TObject);
begin
  inherited;
  Series1.FillSampleValues(10);
end;

procedure TChartEditorPanelForm.ComboBox1Change(Sender: TObject);
begin
  { change the tabs position }
  With ChartEditorPanel1.Editor.MainPage do
  Case ComboBox1.ItemIndex of
    0: {$IFNDEF CLX}TabPosition:=tpTop{$ENDIF};
    1: begin
         Style:=tsTabs;
         {$IFNDEF CLX}
         TabPosition:=tpBottom;
         {$ENDIF}
       end;
    2: begin
         Style:=tsTabs;
         {$IFNDEF CLX}
         TabPosition:=tpLeft;
         {$ENDIF}
       end;
    3: begin
         Style:=tsTabs;
         {$IFNDEF CLX}
         TabPosition:=tpRight;
         {$ENDIF}
       end;
  end;
end;

procedure TChartEditorPanelForm.ComboBox2Change(Sender: TObject);
begin
  { change the tabs style }
  With ChartEditorPanel1.Editor.MainPage do
  Case ComboBox2.ItemIndex of
    0: Style:=tsTabs;
    1: begin
         {$IFNDEF CLX}
         TabPosition:=tpTop;
         {$ENDIF}
         Style:=tsButtons;
       end;
    2: begin
         {$IFNDEF CLX}
         TabPosition:=tpTop;
         {$ENDIF}
         Style:=tsFlatButtons;
       end;
  end;
end;

procedure TChartEditorPanelForm.Chart1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  { On mouse down, show the appropiate tab in the editor... }
  ChartEditorPanel1.SelectUnderMouse;
end;

procedure TChartEditorPanelForm.FormShow(Sender: TObject);
begin
  inherited;
  ComboBox1.ItemIndex:=0;
  ComboBox2.ItemIndex:=0;
end;

initialization
  RegisterClass(TChartEditorPanelForm);
end.

