{**********************************************}
{   TGrid3DSeries Editor Dialog                }
{   Copyright (c) 1996-2009 by David Berneda   }
{**********************************************}
unit TeeGriEd;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     QGrids, QMenus,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     Grids, Menus,
     {$ENDIF}
     TeeProcs, TeEngine, Chart, TeeSurfa, TeCanvas, TeePenDlg, TeeChartGrid;

type
  TGrid3DSeriesEditor = class(TForm,ITeeEventListener)
    PageControl1: TPageControl;
    TabSingle: TTabSheet;
    BColor: TButtonColor;
    TabRange: TTabSheet;
    BFromColor: TButtonColor;
    BMidColor: TButtonColor;
    BToColor: TButtonColor;
    CheckBox1: TCheckBox;
    Button1: TButton;
    TabPalette: TTabSheet;
    BRemove: TButton;
    Timer1: TTimer;
    Button2: TButton;
    PageControl2: TPageControl;
    TabPaletteSteps: TTabSheet;
    TabSheet2: TTabSheet;
    Label4: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    SEPalette: TEdit;
    UDPalette: TUpDown;
    CBUseMin: TCheckBox;
    EPaletteMin: TEdit;
    EPaletteStep: TEdit;
    Edit1: TEdit;
    UDLegendEvery: TUpDown;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label5: TLabel;
    LDepth: TLabel;
    SEXGrid: TEdit;
    UDXGrid: TUpDown;
    SEZGrid: TEdit;
    UDZGrid: TUpDown;
    EDepth: TEdit;
    UDDepth: TUpDown;
    CBIrreg: TCheckBox;
    ChartGrid1: TChartGrid;
    Label8: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    CBPalStyle: TComboFlat;
    Label7: TLabel;
    CBPalettes: TComboFlat;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    Invert1: TMenuItem;
    Button4: TButton;
    procedure FormShow(Sender: TObject);
    procedure SEZGridChange(Sender: TObject);
    procedure SEPaletteChange(Sender: TObject);
    procedure EDepthChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBIrregClick(Sender: TObject);
    procedure CBPalStyleChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure CBUseMinClick(Sender: TObject);
    procedure EPaletteMinChange(Sender: TObject);
    procedure EPaletteStepChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure BMidColorClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure BRemoveClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CBPalettesChange(Sender: TObject);
    procedure ChartGrid1ChangeColor(Sender: TObject);
    procedure ChartGrid1EditingCell(Sender: TCustomChartGrid; ACol,
      ARow: Integer; var Allow: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure Invert1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    PaletteSeries : TChartSeries;
    Grid3D        : TCustom3DPaletteSeries;

    procedure CheckMidColor;
    function EditGradientColors(var AStart,AMid,AEnd:TColor;
                                HideTabColors:Boolean):Boolean;
    procedure SetCustomPalette;
    procedure UpdatePalette;

  {$IFDEF CLR}
  protected
  {$ENDIF}
    procedure TeeEvent(Event: TTeeEvent);  { interface }
  protected
    Creating : Boolean;
  public
    { Public declarations }
    class procedure ApplyPalette(Series:TCustom3DPaletteSeries; Index:Integer);
    procedure RefreshControls(AGrid:TCustom3DPaletteSeries);
  end;

Function TeeInsertGrid3DForm(AParent:TControl; AGrid3D:TCustom3DPaletteSeries):TCustomForm;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses
  TeeBrushDlg, TeeConst, TeeProCo, TeeEdiSeri, TeeEdiGrad;

Function TeeInsertGrid3DForm(AParent:TControl; AGrid3D:TCustom3DPaletteSeries):TCustomForm;
begin
  result:=TFormTeeSeries.InsertSeriesForm(AParent,TGrid3DSeriesEditor,
                                                     1,TeeMsg_Grid3D,
                                                     AGrid3D);
end;

{$IFNDEF CLR}
type
  TCustom3DGridSeriesAccess=class(TCustom3DGridSeries);
  TTeePanelAccess=class(TCustomTeePanel);
{$ENDIF}

procedure TGrid3DSeriesEditor.RefreshControls(AGrid:TCustom3DPaletteSeries);
var tmp : Boolean;
begin
  Grid3D:=AGrid;

  if Grid3D is TCustom3DGridSeries then
  With {$IFDEF CLR}Grid3D as TCustom3DGridSeries{$ELSE}TCustom3DGridSeriesAccess(Grid3D){$ENDIF} do
  begin
    UDXGrid.Position:=NumXValues;
    UDZGrid.Position:=NumZValues;
    CBIrreg.Checked :=IrregularGrid;

    // LCL workaround
    tmp:={$IFDEF LCL}TCustom3DGridSeriesAccess(Grid3D).{$ENDIF}CanCreateValues;

    EnableControls(tmp,[UDXGrid,UDZGrid,SEXGrid,SEZGrid]);
  end
  else
  begin
    EnableControls(False,[SEXGrid,SEZGrid,UDXGrid,UDZGrid]);
    CBIrreg.Visible:=False;
  end;

  if Assigned(Grid3D) then
  begin
    With Grid3D do
    begin
      UDDepth.Position:=TimesZOrder;
      UDPalette.Position:=PaletteSteps;

      CBPalStyle.ItemIndex:=Ord(PaletteStyle);
      UpdatePalette;

      if UseColorRange then
         PageControl1.ActivePage:=TabRange
      else
      if UsePalette then
      begin
        PageControl1.ActivePage:=TabPalette;
        PageControl2.ActivePage:=TabPaletteSteps;
      end
      else
         PageControl1.ActivePage:=TabSingle;

      CBUseMin.Checked:=UsePaletteMin;
      EPaletteMin.Text:=FloatToStr(PaletteMin);
      EPaletteMin.Enabled:=UsePaletteMin;
      EPaletteStep.Text:=FloatToStr(PaletteStep);

      UDLegendEvery.Position:=LegendEvery;

      CheckMidColor;
    end;

    BRemove.Enabled:=HasColors(Grid3D);

    BColor.LinkProperty(Grid3D,'SeriesColor'); // Do not localize
    BFromColor.LinkProperty(Grid3D,'StartColor'); // Do not localize
    BMidColor.LinkProperty(Grid3D,'MidColor'); // Do not localize
    BToColor.LinkProperty(Grid3D,'EndColor'); // Do not localize

    if Assigned(Grid3D.ParentChart) then
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(Grid3D.ParentChart).Listeners.Add(Self);
  end;
end;

procedure TGrid3DSeriesEditor.FormShow(Sender: TObject);
begin
  RefreshControls(TCustom3DPaletteSeries(Tag));
  Creating:=False;

  // Hack.
  Timer1.Enabled:=True;
end;

procedure TGrid3DSeriesEditor.SEZGridChange(Sender: TObject);
begin
  if not Creating then
  if Grid3D is TCustom3DGridSeries then
  With TCustom3DGridSeries(Grid3D) do
     if (UDXGrid.Position<>NumXValues) or (UDZGrid.Position<>NumZValues) then
        CreateValues(UDXGrid.Position,UDZGrid.Position);
end;

procedure TGrid3DSeriesEditor.SEPaletteChange(Sender: TObject);
begin
  if (not Creating) and UDPalette.Showing then
  begin
    Grid3D.PaletteSteps:=UDPalette.Position;
    UpdatePalette;
  end;
end;

procedure TGrid3DSeriesEditor.EDepthChange(Sender: TObject);
begin
  if not Creating then Grid3D.TimesZOrder:=UDDepth.Position;
end;

procedure TGrid3DSeriesEditor.FormCreate(Sender: TObject);
begin
  Creating:=True;
  Align:=alClient;

  ColorPalettes.AddTo(CBPalettes.Items);

  PaletteSeries:=TChartSeries.Create(nil);
  PaletteSeries.MandatoryValueList.Name:=TeeMsg_UpToValue;

  ChartGrid1.Series:=PaletteSeries;
  ChartGrid1.ShowFields:=False;
  ChartGrid1.EditorMode:=False;
  ChartGrid1.AllowAppend:=False;

  {$IFNDEF CLR}
  ChartGrid1.ColWidths[2]:=90;
  {$ELSE}
  {$IFDEF D10}
  ChartGrid1.ColWidths[2]:=90;
  {$ENDIF}
  {$ENDIF}
end;

procedure TGrid3DSeriesEditor.CBIrregClick(Sender: TObject);
begin
  TCustom3DGridSeries(Grid3D).IrregularGrid:=CBIrreg.Checked
end;

procedure TGrid3DSeriesEditor.CBPalStyleChange(Sender: TObject);
begin
  Grid3D.PaletteStyle:=TTeePaletteStyle(CBPalStyle.ItemIndex);
  UpdatePalette;
end;

procedure TGrid3DSeriesEditor.UpdatePalette;
var t : Integer;
begin
  CBPalettes.Enabled:=Grid3D.PaletteStyle=psCustom;
  ChartGrid1.ReadOnly:=not CBPalettes.Enabled;

  if (Grid3D.PaletteStyle<>psCustom) and (Length(Grid3D.Palette)=0) then
     Grid3D.CreateDefaultPalette;

  PaletteSeries.Clear;
  for t:=0 to Length(Grid3D.Palette)-1 do
      PaletteSeries.Add(Grid3D.Palette[t].UpToValue,'',Grid3D.Palette[t].Color);

  ChartGrid1.RecalcDimensions;
  ChartGrid1.Invalidate;
end;

procedure TGrid3DSeriesEditor.FormDestroy(Sender: TObject);
begin
  PaletteSeries.Free;

  if Assigned(Grid3D) and Assigned(Grid3D.ParentChart) then
     {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(Grid3D.ParentChart).RemoveListener(Self);
end;

procedure TGrid3DSeriesEditor.TeeEvent(Event: TTeeEvent);
begin
  if not (csDestroying in ComponentState) then
     if Event is TTeeSeriesEvent then
     With TTeeSeriesEvent(Event) do
          if Event=seChangeColor then BColor.Invalidate;
end;

procedure TGrid3DSeriesEditor.PageControl1Change(Sender: TObject);
begin
  if (not Creating) and Assigned(Grid3D) then
  begin
    if PageControl1.ActivePage=TabSingle then
    begin
      With Grid3D do
      begin
        ColorEachPoint:=True;
        ColorEachPoint:=False;
        UseColorRange:=False;
        UsePalette:=False;
      end;
    end
    else
    if PageControl1.ActivePage=TabRange then
    begin
      Grid3D.UseColorRange:=True;
      Grid3D.UsePalette:=False;
    end
    else
    begin
      Grid3D.UseColorRange:=False;
      Grid3D.UsePalette:=True;

      if Grid3D.PaletteStyle<>psCustom then
         Grid3D.ClearPalette;
         
      UpdatePalette;
    end;
  end;
end;

procedure TGrid3DSeriesEditor.CBUseMinClick(Sender: TObject);
begin
  Grid3D.UsePaletteMin:=CBUseMin.Checked;
  EPaletteMin.Enabled:=Grid3D.UsePaletteMin;
end;

procedure TGrid3DSeriesEditor.EPaletteMinChange(Sender: TObject);
begin
  if not Creating then
     with Grid3D do PaletteMin:=StrToFloatDef(EPaletteMin.Text,PaletteMin);
end;

procedure TGrid3DSeriesEditor.EPaletteStepChange(Sender: TObject);
begin
  if not Creating then
     with Grid3D do PaletteStep:=StrToFloatDef(EPaletteStep.Text,PaletteStep);
end;

procedure TGrid3DSeriesEditor.Button1Click(Sender: TObject);
var tmp : TColor;
begin
  with Grid3D do
  begin
    tmp:=StartColor;
    StartColor:=EndColor;
    EndColor:=tmp;
  end;

  BFromColor.Invalidate;
  BToColor.Invalidate;
end;

procedure TGrid3DSeriesEditor.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    Grid3D.MidColor:=clNone;
    BMidColor.Repaint;
  end;

  CheckBox1.Enabled:=not CheckBox1.Checked;
end;

procedure TGrid3DSeriesEditor.CheckMidColor;
begin
  CheckBox1.Checked:=Grid3D.MidColor=clNone;
  CheckBox1.Enabled:=not CheckBox1.Checked;
end;

procedure TGrid3DSeriesEditor.BMidColorClick(Sender: TObject);
begin
  CheckMidColor;
end;

procedure TGrid3DSeriesEditor.Edit1Change(Sender: TObject);
begin
  if not Creating then
     with Grid3D do LegendEvery:=UDLegendEvery.Position;
end;

procedure TGrid3DSeriesEditor.BRemoveClick(Sender: TObject);
var t : Integer;
begin
  with Grid3D do
  for t:=0 to Count-1 do ValueColor[t]:=clTeeColor;
  BRemove.Enabled:=False;
end;

procedure TGrid3DSeriesEditor.Timer1Timer(Sender: TObject);
var Old : TTabSheet;
begin
  Timer1.Enabled:=False;
  Old:=PageControl1.ActivePage;
  PageControl1.ActivePage:=nil;
  PageControl1.ActivePage:=Old;
end;

procedure TGrid3DSeriesEditor.Button2Click(Sender: TObject);
var tmpS : TColor;
    tmpM : TColor;
    tmpE : TColor;
begin
  tmpS:=Grid3D.StartColor;
  tmpM:=Grid3D.MidColor;
  tmpE:=Grid3D.EndColor;

  if EditGradientColors(tmpS,tmpM,tmpE,True) then
  begin
    Grid3D.StartColor:=tmpS;
    Grid3D.MidColor:=tmpM;
    Grid3D.EndColor:=tmpE;

    BFromColor.Invalidate;
    BMidColor.Invalidate;
    BToColor.Invalidate;
    CheckMidColor;
  end;
end;

function TGrid3DSeriesEditor.EditGradientColors(var AStart,AMid,AEnd:TColor;
                                                HideTabColors:Boolean):Boolean;
var tmp : TTeeGradient;

  Function EditedGradient:Boolean;
  var tmpEd : TTeeGradientEditor;
  begin
    tmpEd:=TTeeGradientEditor.Create(Self);
    with tmpEd do  // 7.0
    try
      Align:=alNone;

      // PositionToCenter(tmpEd);  <-- VCL bug when setting TabVisible:=False below

      RefreshGradient(tmp);

      Panel2.Hide;

      if HideTabColors then
         TabSheet1.TabVisible:=False;

      TabSheet2.TabVisible:=False;
      TabSheet4.TabVisible:=False;
      TabSheet5.TabVisible:=False;

      result:=ShowModal=mrOk;
    finally
      Free;
    end;
  end;

begin
  result:=False;

  tmp:=TTeeGradient.Create(nil);
  try
    tmp.Visible:=True;
    tmp.StartColor:=AStart;
    tmp.MidColor:=AMid;
    tmp.EndColor:=AEnd;

    if EditedGradient then
    begin
      AStart:=tmp.StartColor;
      AMid:=tmp.MidColor;
      AEnd:=tmp.EndColor;
      result:=True;
    end;
  finally
    tmp.Free;
  end;
end;

procedure TGrid3DSeriesEditor.CBPalettesChange(Sender: TObject);
begin
  ApplyPalette(Grid3D,CBPalettes.ItemIndex);
  UpdatePalette;
end;

class procedure TGrid3DSeriesEditor.ApplyPalette(Series:TCustom3DPaletteSeries;
                                                 Index:Integer);
begin
  case Index of
    0: Series.AddPalette(TeeProcs.ColorPalette);
    1: Series.AddPalette(ExcelPalette);
    2: Series.AddPalette(VictorianPalette);
    3: Series.AddPalette(PastelsPalette);
    4: Series.AddPalette(SolidPalette);
    5: Series.AddPalette(ClassicPalette);
    6: Series.AddPalette(WebPalette);
    7: Series.AddPalette(ModernPalette);
    8: Series.AddPalette(RainbowPalette);
    9: Series.AddPalette(WindowsXPPalette);
   10: Series.AddPalette(MacOSPalette);
   11: Series.AddPalette(WindowsVistaPalette);
   12: Series.AddPalette(GrayScalePalette);
   13: Series.AddPalette(OperaPalette);
   14: Series.AddPalette(WarmPalette);
   15: Series.AddPalette(CoolPalette);
  end;
end;

procedure TGrid3DSeriesEditor.ChartGrid1ChangeColor(Sender: TObject);
var Index : Integer;
begin
  Index:=ChartGrid1.Row-ChartGrid1.FirstRowNum;
  Grid3D.Palette[Index].Color:=PaletteSeries.ValueColor[Index];
  Grid3D.Repaint;
end;

procedure TGrid3DSeriesEditor.ChartGrid1EditingCell(
  Sender: TCustomChartGrid; ACol, ARow: Integer; var Allow: Boolean);
begin
  Allow:=ACol=Sender.ColorsColumn;
end;

type
  TCustom3DPaletteAccess=class(TCustom3DPaletteSeries);

procedure TGrid3DSeriesEditor.Button3Click(Sender: TObject);
var tmpS : TColor;
    tmpM : TColor;
    tmpE : TColor;
    tmpOldS : TColor;
    tmpOldM : TColor;
    tmpOldE : TColor;
begin
  tmpS:=clRed;
  tmpM:=clYellow;
  tmpE:=clGreen;

  if EditGradientColors(tmpS,tmpM,tmpE,False) then
  begin
    Grid3D.UsePalette:=False;
    Grid3D.UseColorRange:=True;

    tmpOldS:=Grid3D.StartColor;
    tmpOldM:=Grid3D.MidColor;
    tmpOldE:=Grid3D.EndColor;

    Grid3D.StartColor:=tmpS;
    Grid3D.MidColor:=tmpM;
    Grid3D.EndColor:=tmpE;

    TCustom3DPaletteAccess(Grid3D).GeneratePalette;

    Grid3D.StartColor:=tmpOldS;
    Grid3D.MidColor:=tmpOldM;
    Grid3D.EndColor:=tmpOldE;

    Grid3D.UseColorRange:=False;
    Grid3D.UsePalette:=True;

    SetCustomPalette;
  end;
end;

procedure TGrid3DSeriesEditor.SetCustomPalette;
begin
  Grid3D.PaletteStyle:=psCustom;
  CBPalStyle.ItemIndex:=Ord(Grid3D.PaletteStyle);
  CBPalettes.ItemIndex:=-1;
  UpdatePalette;
end;

procedure TGrid3DSeriesEditor.Invert1Click(Sender: TObject);
begin
  Grid3D.InvertPalette;
  SetCustomPalette;
end;

procedure TGrid3DSeriesEditor.Button4Click(Sender: TObject);
begin
  Invert1Click(Self);
end;

initialization
  RegisterClass(TGrid3DSeriesEditor);
end.
