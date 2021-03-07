{******************************************}
{    TCircledSeries Editor Dialog          }
{ Copyright (c) 2000-2009 by David Berneda }
{******************************************}
unit TeeCircledEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     {$ENDIF}
     Chart, Series, TeEngine, TeeProcs, TeCanvas, TeePenDlg, TeeEdiGrad;

type
  TCircledSeriesEditor = class(TForm)
    PageControl1: TPageControl;
    TabOptions: TTabSheet;
    TabRadius: TTabSheet;
    TabShadow: TTabSheet;
    Label1: TLabel;
    CBCircled: TCheckBox;
    CB3D: TCheckBox;
    Edit1: TEdit;
    BBack: TButtonColor;
    CBTransp: TCheckBox;
    BGradient: TButtonGradient;
    UDRot: TUpDown;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    CBAutoXR: TCheckBox;
    Edit3: TEdit;
    CBAutoYR: TCheckBox;
    UDY: TUpDown;
    UDX: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure CBCircledClick(Sender: TObject);
    procedure SERotationChange(Sender: TObject);
    procedure SEXRadiusChange(Sender: TObject);
    procedure SEYRadiusChange(Sender: TObject);
    procedure CBAutoXRClick(Sender: TObject);
    procedure CBAutoYRClick(Sender: TObject);
    procedure CB3DClick(Sender: TObject);
    procedure BBackClick(Sender: TObject);
    procedure CBTranspClick(Sender: TObject);
    procedure BGradientClick(Sender: TObject);
  private
    { Private declarations }
    Circled      : TCircledSeries;
    CreatingForm : Boolean;
  public
    { Public declarations }
    class function CreateForm(AForm:TCustomForm;
                              const Circled:TCircledSeries):TCircledSeriesEditor;
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeeConst, TeeEdiSeri, TeeShadowEditor;

type
  TCircledSeriesAccess=class(TCircledSeries);

procedure TCircledSeriesEditor.FormShow(Sender: TObject);
begin
  CreatingForm:=True;
  Circled:=TCircledSeries(Tag);

  if Assigned(Circled) then
  begin
    With Circled do
    begin
      CBCircled.Checked:=Circled;
      CB3D.Checked     :=ParentChart.View3D;
      UDRot.Position   :=RotationAngle;
      UDX.Position     :=CustomXRadius;
      UDY.Position     :=CustomYRadius;
    end;

    CBTransp.Checked :=not TCircledSeriesAccess(Circled).HasBackColor;
    CBTransp.Enabled :=not CBTransp.Checked;

    BBack.LinkProperty(Circled,'CircleBackColor'); // Do not localize

    BGradient.Gradient:=TCircledSeriesAccess(Circled).CircleGradient;

    InsertTeeShadowEditor(TabShadow).RefreshControls(Circled.Shadow);
  end;

  CreatingForm:=False;
end;

procedure TCircledSeriesEditor.CBCircledClick(Sender: TObject);
begin
  Circled.Circled:=CBCircled.Checked;
end;

procedure TCircledSeriesEditor.SERotationChange(Sender: TObject);
begin
  if Showing then Circled.RotationAngle:=UDRot.Position;
end;

procedure TCircledSeriesEditor.SEXRadiusChange(Sender: TObject);
begin
  if Showing then
  begin
    Circled.CustomXRadius:=UDX.Position;
    CBAutoXR.Checked:=UDX.Position=0;
  end;
end;

procedure TCircledSeriesEditor.SEYRadiusChange(Sender: TObject);
begin
  if Showing then
  begin
    Circled.CustomYRadius:=UDY.Position;
    CBAutoYR.Checked:=UDY.Position=0;
  end;
end;

procedure TCircledSeriesEditor.CBAutoXRClick(Sender: TObject);
begin
  if CBAutoXR.Checked then UDX.Position:=0;
end;

procedure TCircledSeriesEditor.CBAutoYRClick(Sender: TObject);
begin
  if CBAutoYR.Checked then UDY.Position:=0;
end;

procedure TCircledSeriesEditor.CB3DClick(Sender: TObject);
begin
  Circled.ParentChart.View3D:=CB3D.Checked
end;

procedure TCircledSeriesEditor.BBackClick(Sender: TObject);
begin
  CBTransp.Checked:=False;
  CBTransp.Enabled:=True;
end;

procedure TCircledSeriesEditor.CBTranspClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    if CBTransp.Checked then
    begin
      Circled.CircleBackColor:=clTeeColor;
      TCircledSeriesAccess(Circled).CircleGradient.Visible:=False;

      BBack.Invalidate;
    end;

    CBTransp.Enabled:=not CBTransp.Checked;
  end;
end;

procedure TCircledSeriesEditor.BGradientClick(Sender: TObject);
begin
  if TCircledSeriesAccess(Circled).CircleGradient.Visible then
  begin
    CBTransp.Checked:=False;
    CBTransp.Enabled:=True;
  end;
end;


class function TCircledSeriesEditor.CreateForm(AForm:TCustomForm;
                             const Circled:TCircledSeries):TCircledSeriesEditor;
begin
  result:=TCircledSeriesEditor(
              TFormTeeSeries.InsertSeriesForm(AForm.Parent,TCircledSeriesEditor,
                                              1,TeeMsg_GalleryCircled,Circled));
end;

initialization
  RegisterClass(TCircledSeriesEditor);
end.
