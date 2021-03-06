unit ChartListBox_Editor;
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
  ChartListBox_Radio, TeeLisB, Series, TeEngine, TeeProcs, Chart;

type
  TChartListBoxEditor = class(TChartListBoxRadio)
    CBEditor: TCheckBox;
    procedure CBEditorClick(Sender: TObject);
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

procedure TChartListBoxEditor.CBEditorClick(Sender: TObject);
begin
  if CBEditor.Checked then ChartListBox1.ShowEditor
                      else ChartListBox1.HideEditor;
end;

initialization
  RegisterClass(TChartListBoxEditor);
end.
