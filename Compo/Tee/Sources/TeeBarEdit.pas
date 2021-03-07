{**********************************************}
{   TBarSeries Component Editor Dialog         }
{   Copyright (c) 1996-2009 by David Berneda   }
{**********************************************}
unit TeeBarEdit;
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
     Chart, Series, TeeProcs, TeCanvas, TeePenDlg;

type
  TBarSeriesEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    LStyle: TLabel;
    CBBarStyle: TComboFlat;
    BBarBrush: TButton;
    GroupBox2: TGroupBox;
    CBColorEach: TCheckBox;
    BBarColor: TButtonColor;
    BGradient: TButton;
    BTickLines: TButtonPen;
    CBDarkBar: TCheckBox;
    Label1: TLabel;
    Label3: TLabel;
    SEBarwidth: TEdit;
    SEBarOffset: TEdit;
    UDBarWidth: TUpDown;
    UDBarOffset: TUpDown;
    Label2: TLabel;
    Edit1: TEdit;
    UDDepth: TUpDown;
    CBBarSideMargins: TCheckBox;
    CBMarksAutoPosition: TCheckBox;
    TabShadow: TTabSheet;
    TabSheet3: TTabSheet;
    BBarPen: TButtonPen;
    LBevel: TLabel;
    EBevel: TEdit;
    UDBevel: TUpDown;
    Label4: TLabel;
    Edit2: TEdit;
    UDDarkPen: TUpDown;
    LTransp: TLabel;
    TBTransp: TTrackBar;
    procedure FormShow(Sender: TObject);
    procedure SEBarwidthChange(Sender: TObject);
    procedure CBBarStyleChange(Sender: TObject);
    procedure BBarBrushClick(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure CBDarkBarClick(Sender: TObject);
    procedure CBBarSideMarginsClick(Sender: TObject);
    procedure SEBarOffsetChange(Sender: TObject);
    procedure CBMarksAutoPositionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BGradientClick(Sender: TObject);
    procedure EBevelChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure TBTranspChange(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    Bar          : TCustomBarSeries;
    FStackEditor : TCustomForm;

    Procedure AddStackBarEditor;
    Procedure CheckControls;
    Procedure RefreshShape;
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
  TeeBrushDlg, TeeEdiGrad, TeeEdiSeri, TeeStackBarEdit, TeeConst,
  TeeShadowEditor;

procedure TBarSeriesEditor.FormShow(Sender: TObject);
begin
  Bar:=TCustomBarSeries(Tag);

  if Assigned(Bar) then
  begin
    With Bar do
    begin
      CBBarStyle.ItemIndex :=Ord(BarStyle);
      UDBarWidth.Position  :=BarWidthPercent;
      UDBarOffset.Position :=OffsetPercent;
      UDDepth.Position     :=DepthPercent;
      CBColorEach.Checked  :=ColorEachPoint;
      CBMarksAutoPosition.Checked:=AutoMarkPosition;
      CBDarkBar.Checked    :=Dark3D;
      CBBarSideMargins.Checked:=SideMargins;
      BBarPen.LinkPen(BarPen);
      BTickLines.LinkPen(TickLines);
      UDBevel.Position     :=BevelSize;
      UDDarkPen.Position   :=DarkPen;
      TBTransp.Position    :=Transparency;

      InsertTeeShadowEditor(TabShadow).RefreshControls(Shadow);
    end;

    CheckControls;

    BBarColor.LinkProperty(Bar,'SeriesColor'); // Do not localize
    RefreshShape;

    AddStackBarEditor;
  end;

  CreatingForm:=False;
end;

Procedure TBarSeriesEditor.AddStackBarEditor;
Begin
  if not Assigned(FStackEditor) then
     FStackEditor:=TFormTeeSeries.InsertSeriesForm(Parent,TStackBarSeriesEditor,
                                                   1,TeeMsg_Stack,Bar);
end;

Procedure TBarSeriesEditor.RefreshShape;
Begin
  BBarColor.Enabled:=not Bar.ColorEachPoint;

  if BBarColor.Enabled then
     BBarColor.Repaint;
end;

procedure TBarSeriesEditor.SEBarWidthChange(Sender: TObject);
begin
  if (not CreatingForm) and Assigned(Bar) then
     Bar.BarWidthPercent:=UDBarWidth.Position;
end;

Procedure TBarSeriesEditor.CheckControls;
begin
  BGradient.Enabled:=(Bar.BarStyle=bsRectGradient) or (Bar.BarStyle=bsRectangle);
  EnableControls(Bar.BarStyle=bsBevel,[LBevel,EBevel,UDBevel]);
end;

procedure TBarSeriesEditor.CBBarStyleChange(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Bar.BarStyle:=TBarStyle(CBBarStyle.ItemIndex);
    CheckControls;
  end;
end;

procedure TBarSeriesEditor.BBarBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,Bar.BarBrush);
end;

procedure TBarSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Bar.ColorEachPoint:=CBColorEach.Checked;
    RefreshShape;
  end;
end;

procedure TBarSeriesEditor.CBDarkBarClick(Sender: TObject);
begin
  if not CreatingForm then
     Bar.Dark3D:=CBDarkBar.Checked;
end;

procedure TBarSeriesEditor.CBBarSideMarginsClick(Sender: TObject);
begin
  if not CreatingForm then
     Bar.SideMargins:=CBBarSideMargins.Checked;
end;

procedure TBarSeriesEditor.SEBarOffsetChange(Sender: TObject);
begin
  if (not CreatingForm) and Assigned(Bar) then
     Bar.OffsetPercent:=UDBarOffset.Position;
end;

procedure TBarSeriesEditor.CBMarksAutoPositionClick(Sender: TObject);
begin
  Bar.AutoMarkPosition:=CBMarksAutoPosition.Checked;
end;

procedure TBarSeriesEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  PageControl1.ActivePage:=TabSheet1;
  Align:=alClient;
end;

procedure TBarSeriesEditor.BGradientClick(Sender: TObject);
begin
  Bar.BarStyle:=bsRectGradient;
  CBBarStyle.ItemIndex:=6;
  EditTeeGradient(Self,Bar.Gradient,True,True);
end;

procedure TBarSeriesEditor.EBevelChange(Sender: TObject);
begin
  if not CreatingForm then
     Bar.BevelSize:=UDBevel.Position;
end;

procedure TBarSeriesEditor.Edit1Change(Sender: TObject);
begin
  if (not CreatingForm) and Assigned(Bar) then
     Bar.DepthPercent:=UDDepth.Position;
end;

procedure TBarSeriesEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FStackEditor);
end;

procedure TBarSeriesEditor.Edit2Change(Sender: TObject);
begin
  if not CreatingForm then
     if Assigned(Bar) then
        Bar.DarkPen:=UDDarkPen.Position;
end;

procedure TBarSeriesEditor.TBTranspChange(Sender: TObject);
begin
  Bar.Transparency:=TBTransp.Position;
end;

initialization
  RegisterClass(TBarSeriesEditor);
end.
