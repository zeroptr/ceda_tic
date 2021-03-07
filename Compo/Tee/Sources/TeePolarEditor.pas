{******************************************}
{    TPolarSeries Editor Dialog            }
{ Copyright (c) 1996-2009 by David Berneda }
{******************************************}
unit TeePolarEditor;
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
     Chart, Series, TeePolar, TeEngine, TeCanvas, TeePenDlg, TeeProcs,
     TeeEdiFont;

type
  TPolarSeriesEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CBAngleLabels: TCheckBox;
    CBLabelsRot: TCheckBox;
    CBClockWise: TCheckBox;
    CBInside: TCheckBox;
    Label2: TLabel;
    EMargin: TEdit;
    UDMargin: TUpDown;
    LAngleInc: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    CBClose: TCheckBox;
    SEAngleInc: TEdit;
    SERadiusInc: TEdit;
    BPen: TButtonPen;
    BPiePen: TButtonPen;
    BBrush: TButton;
    Edit1: TEdit;
    UDTransp: TUpDown;
    BColor: TButtonColor;
    CBColorEach: TCheckBox;
    TabFont: TTabSheet;
    Timer1: TTimer;
    Label3: TLabel;
    CBNulls: TComboFlat;
    procedure FormShow(Sender: TObject);
    procedure BPenClick(Sender: TObject);
    procedure CBCloseClick(Sender: TObject);
    procedure SEAngleIncChange(Sender: TObject);
    procedure SERadiusIncChange(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
    procedure CBAngleLabelsClick(Sender: TObject);
    procedure CBLabelsRotClick(Sender: TObject);
    procedure CBClockWiseClick(Sender: TObject);
    procedure CBInsideClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure EMarginChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CBNullsChange(Sender: TObject);
  private
    { Private declarations }
    PointerForm  : TCustomForm;
    IFontEditor  : TTeeFontEditor;
    FCircledForm : TCustomForm;

    procedure EnableLabels;
  protected
    Polar : TCustomPolarSeries;
    procedure HideAngleInc; virtual;
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
  TeeBrushDlg, TeePoEdi, TeeEdiSeri, TeeCircledEdit, TeeConst;

procedure TPolarSeriesEditor.HideAngleInc;
begin
  ShowControls(Polar is TPolarSeries,[LAngleInc,SEAngleInc]);
end;

procedure TPolarSeriesEditor.FormShow(Sender: TObject);
begin
  Polar:=TCustomPolarSeries(Tag);

  if Assigned(Polar) then
  begin
    With Polar do
    begin
      CBClose.Checked       :=CloseCircle;
      CBClockWise.Checked   :=ClockWiseLabels;

      SEAngleInc.Text       :=FloatToStr(AngleIncrement);
      SERadiusInc.Text      :=FloatToStr(RadiusIncrement);

      CBAngleLabels.Checked :=CircleLabels;
      CBLabelsRot.Checked   :=CircleLabelsRotated;
      CBInside.Checked      :=CircleLabelsInside;

      BPiePen.LinkPen(CirclePen);
      BPen.LinkPen(Pen);

      UDMargin.Position     :=LabelsMargin;
      UDTransp.Position     :=Transparency;
      CBColorEach.Checked   :=ColorEachPoint;
      CBNulls.ItemIndex     :=Ord(TreatNulls);

      IFontEditor.RefreshControls(CircleLabelsFont);
    end;

    BColor.LinkProperty(Polar,'SeriesColor');

    EnableLabels;

    if not Assigned(FCircledForm) then
       FCircledForm:=TCircledSeriesEditor.CreateForm(Self,Polar);

    if not Assigned(PointerForm) then
       PointerForm:=TeeInsertPointerForm(Parent,Polar.Pointer,TeeMsg_GalleryPoint);

    Timer1.Enabled:=True;
  end;
end;

procedure TPolarSeriesEditor.BPenClick(Sender: TObject);
begin
  With Polar do SeriesColor:=Pen.Color;
end;

procedure TPolarSeriesEditor.CBCloseClick(Sender: TObject);
begin
  Polar.CloseCircle:=CBClose.Checked;
end;

procedure TPolarSeriesEditor.SEAngleIncChange(Sender: TObject);
begin
  if Showing then
     Polar.AngleIncrement:=StrToFloatDef(SEAngleInc.Text,Polar.AngleIncrement);
end;

procedure TPolarSeriesEditor.SERadiusIncChange(Sender: TObject);
begin
  if Showing then
     Polar.RadiusIncrement:=StrToFloatDef(SERadiusInc.Text,Polar.RadiusIncrement);
end;

procedure TPolarSeriesEditor.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,Polar.Brush);
end;

procedure TPolarSeriesEditor.CBAngleLabelsClick(Sender: TObject);
begin
  Polar.CircleLabels:=CBAngleLabels.Checked;
  EnableLabels;
end;

procedure TPolarSeriesEditor.EnableLabels;
begin
  EnableControls(CBAngleLabels.Checked,[CBLabelsRot,CBClockWise])
end;

procedure TPolarSeriesEditor.CBLabelsRotClick(Sender: TObject);
begin
  Polar.CircleLabelsRotated:=CBLabelsRot.Checked;
end;

procedure TPolarSeriesEditor.CBClockWiseClick(Sender: TObject);
begin
  Polar.ClockWiseLabels:=CBClockWise.Checked;
end;

procedure TPolarSeriesEditor.CBInsideClick(Sender: TObject);
begin
  Polar.CircleLabelsInside:=CBInside.Checked;
end;

procedure TPolarSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing then Polar.Transparency:=UDTransp.Position;
end;

procedure TPolarSeriesEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  IFontEditor:=InsertTeeFontEditor(TabFont);
end;

procedure TPolarSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  Polar.ColorEachPoint:=CBColorEach.Checked;
end;

procedure TPolarSeriesEditor.EMarginChange(Sender: TObject);
begin
  if Showing and Assigned(Polar) then
     Polar.LabelsMargin:=UDMargin.Position;
end;

procedure TPolarSeriesEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(PointerForm);
  FreeAndNil(FCircledForm);
end;

procedure TPolarSeriesEditor.Timer1Timer(Sender: TObject);
begin
  // Trick to workaround a VCL bug, calling HideAngleInc at FormShow does
  // not hide SEAngleInc and UDAngleInc controls.
  Timer1.Enabled:=False;
  HideAngleInc;
end;

procedure TPolarSeriesEditor.CBNullsChange(Sender: TObject);
begin
  Polar.TreatNulls:=TTreatNullsStyle(CBNulls.ItemIndex);
end;

initialization
  RegisterClass(TPolarSeriesEditor);
end.
