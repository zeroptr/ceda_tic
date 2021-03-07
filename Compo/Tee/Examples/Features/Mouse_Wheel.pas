unit Mouse_Wheel;
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
  Base, TeEngine, Series, TeeProcs, Chart;

type
  TMouseWheelForm = class(TBaseForm)
    Series1: THorizLineSeries;
    CheckBox1: TCheckBox;
    LabelMouse: TLabel;
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Chart1Click(Sender: TObject);
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

procedure TMouseWheelForm.CheckBox1Click(Sender: TObject);
begin
  TeeUseMouseWheel:=CheckBox1.Checked;
  Chart1.SetFocus;
end;

procedure TMouseWheelForm.FormCreate(Sender: TObject);
begin
  inherited;
  Series1.FillSampleValues(100);
  Chart1.TabStop:=True;
end;

procedure TMouseWheelForm.Chart1Click(Sender: TObject);
begin
  if not Chart1.Focused then Chart1.SetFocus;
end;

procedure TMouseWheelForm.FormShow(Sender: TObject);
begin
  inherited;

  {$IFNDEF CLX}
  if Mouse.WheelPresent then
     LabelMouse.Caption:='Mouse Wheel present.'
  else
     LabelMouse.Caption:='VCL tells your Mouse has no Wheel.';
  {$ENDIF}
end;

initialization
  RegisterClass(TMouseWheelForm);
end.
