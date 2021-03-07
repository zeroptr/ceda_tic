{******************************************}
{    TPieSeries Editor Dialog              }
{ Copyright (c) 1996-2009 by David Berneda }
{******************************************}
unit TeePieEdit;
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
     Chart, Series, TeCanvas, TeePenDlg, TeeProcs, TeeCircledEdit, TeeEdiGrad;

type
  TPieSeriesEditor = class(TForm)
    PageControl1: TPageControl;
    TabOptions: TTabSheet;
    TabGroup: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    CBOther: TComboFlat;
    EOtherValue: TEdit;
    EOtherLabel: TEdit;
    Button2: TButton;
    Label4: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    CBDark3d: TCheckBox;
    SEExpBig: TEdit;
    UDExpBig: TUpDown;
    CBPatterns: TCheckBox;
    BPen: TButtonPen;
    Edit1: TEdit;
    UDAngleSize: TUpDown;
    BGradient: TButtonGradient;
    Edit2: TEdit;
    UpDown1: TUpDown;
    Label3: TLabel;
    CBMultiple: TComboFlat;
    TabSheet1: TTabSheet;
    CBColorEach: TCheckBox;
    BColor: TButtonColor;
    TabSheet2: TTabSheet;
    CBMarksAutoPosition: TCheckBox;
    CBVertCenter: TCheckBox;
    Label8: TLabel;
    SBLegSize: TScrollBar;
    Label9: TLabel;
    CBPalette: TComboFlat;
    Label10: TLabel;
    TBBright: TTrackBar;
    LBright: TLabel;
    procedure FormShow(Sender: TObject);
    procedure CBDark3dClick(Sender: TObject);
    procedure CBPatternsClick(Sender: TObject);
    procedure CBOtherChange(Sender: TObject);
    procedure EOtherValueChange(Sender: TObject);
    procedure EOtherLabelChange(Sender: TObject);
    procedure SEExpBigChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBMarksAutoPositionClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure CBMultipleChange(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBVertCenterClick(Sender: TObject);
    procedure SBLegSizeChange(Sender: TObject);
    procedure CBPaletteChange(Sender: TObject);
    procedure TBBrightChange(Sender: TObject);
  private
    { Private declarations }
    Pie : TPieSeries;
    tmpCircled  : TCircledSeriesEditor;
    public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses
  TeeConst, TeEngine, TeeEdiLege;

procedure TPieSeriesEditor.FormShow(Sender: TObject);
begin
  Pie:=TPieSeries(Tag);

  if Assigned(Pie) then
  begin
    BColor.LinkProperty(Pie,'SeriesColor');

    With Pie do
    begin
      UDExpBig.Position  :=ExplodeBiggest;
      CBDark3D.Checked   :=Dark3D;
      CBDark3D.Enabled   :=Assigned(ParentChart) and ParentChart.View3D;
      CBPatterns.Checked :=UsePatterns;

      if MultiPie=mpAutomatic then
         CBMultiple.ItemIndex:=0
      else
         CBMultiple.ItemIndex:=1;

      CBColorEach.Checked:=ColorEachPoint;

      CBPalette.Clear;
      ColorPalettes.AddTo(CBPalette.Items,True);

      CBPalette.Enabled:=Assigned(ParentChart);

      if Assigned(ParentChart) then
         CBPalette.ItemIndex:=(ParentChart as TCustomChart).ColorPaletteIndex+1;

      With OtherSlice do
      begin
        EOtherLabel.Text:=Text;
        EOtherValue.Text:=FloatToStr(Value);
        CBOther.ItemIndex:=Ord(Style);
        EnableControls(Style<>poNone,[EOtherLabel,EOtherValue]);
      end;

      UDAngleSize.Position:=AngleSize;
      CBMarksAutoPosition.Checked:=AutoMarkPosition;
      BPen.LinkPen(PiePen);
      UpDown1.Position:=DarkPen;

      CBVertCenter.Checked:=PieMarks.VertCenter;
      SBLegSize.Position:=PieMarks.LegSize;

      BGradient.Gradient:=Gradient;
      BGradient.OnlyStart:=True;

      TBBright.Position:=GradientBright;
    end;

    if not Assigned(tmpCircled) then
       tmpCircled:=TCircledSeriesEditor.CreateForm(Self,Pie);

    tmpCircled.BBack.Hide;
    tmpCircled.CBTransp.Hide;
    tmpCircled.BGradient.Hide;
  end;

  PageControl1.ActivePage:=TabOptions;
  TeetranslateControl(Self);
end;

procedure TPieSeriesEditor.CBDark3DClick(Sender: TObject);
begin
  if Showing then Pie.Dark3D:=CBDark3D.Checked;
end;

procedure TPieSeriesEditor.CBPatternsClick(Sender: TObject);
begin
  Pie.UsePatterns:=CBPatterns.Checked;
end;

procedure TPieSeriesEditor.CBOtherChange(Sender: TObject);
begin
  With Pie.OtherSlice do
  begin
    Style:=TPieOtherStyle(CBOther.ItemIndex);
    EnableControls(Style<>poNone,[EOtherLabel,EOtherValue]);
  end;
end;

procedure TPieSeriesEditor.EOtherValueChange(Sender: TObject);
begin
  if EOtherValue.Text<>'' then
     Pie.OtherSlice.Value:=StrToFloat(EOtherValue.Text);
end;

procedure TPieSeriesEditor.EOtherLabelChange(Sender: TObject);
begin
  if Assigned(Pie) then
     Pie.OtherSlice.Text:=EOtherLabel.Text;
end;

procedure TPieSeriesEditor.SEExpBigChange(Sender: TObject);
begin
  if Showing and Assigned(Pie) then
     Pie.ExplodeBiggest:=UDExpBig.Position;
end;

procedure TPieSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing and Assigned(Pie) then
     Pie.AngleSize:=UDAngleSize.Position;
end;

procedure TPieSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

procedure TPieSeriesEditor.CBMarksAutoPositionClick(Sender: TObject);
begin
  Pie.AutoMarkPosition:=CBMarksAutoPosition.Checked;
end;

procedure TPieSeriesEditor.Button2Click(Sender: TObject);
begin
  with TFormTeeLegend.CreateLegend(Self,Pie.OtherSlice.Legend) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TPieSeriesEditor.Edit2Change(Sender: TObject);
begin
  if Showing and Assigned(Pie) then
     Pie.DarkPen:=UpDown1.Position;
end;

procedure TPieSeriesEditor.CBMultipleChange(Sender: TObject);
begin
  if CBMultiple.ItemIndex=0 then
     Pie.MultiPie:=mpAutomatic
  else
     Pie.MultiPie:=mpDisabled;
end;

procedure TPieSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  Pie.ColorEachPoint:=CBColorEach.Checked;
  BColor.Enabled:=not Pie.ColorEachPoint;
  CBPalette.Enabled:=Pie.ColorEachPoint;
end;

procedure TPieSeriesEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(tmpCircled);
end;

procedure TPieSeriesEditor.CBVertCenterClick(Sender: TObject);
begin
  Pie.PieMarks.VertCenter:=CBVertCenter.Checked;
end;

procedure TPieSeriesEditor.SBLegSizeChange(Sender: TObject);
begin
  Pie.PieMarks.LegSize:=SBLegSize.Position;
end;

procedure TPieSeriesEditor.CBPaletteChange(Sender: TObject);
begin
  TCustomChart(Pie.ParentChart).ColorPaletteIndex:=CBPalette.ItemIndex-1;
end;

procedure TPieSeriesEditor.TBBrightChange(Sender: TObject);
begin
  Pie.GradientBright:=TBBright.Position;
  LBright.Caption:=IntToStr(Pie.GradientBright);
end;

initialization
  RegisterClass(TPieSeriesEditor);
end.
