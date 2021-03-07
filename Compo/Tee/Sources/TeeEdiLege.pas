{**********************************************}
{  TCustomChartLegend (or derived) Editor      }
{  Copyright (c) 1996-2009 by David Berneda    }
{**********************************************}
unit TeeEdiLege;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
     Buttons,
     {$ENDIF}
     Chart, TeeCustomShapeEditor, TeeProcs, TeCanvas, TeePenDlg, TeeEdiGrad;

type
  TFormTeeLegend = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    L12: TLabel;
    L7: TLabel;
    CBShow: TCheckBox;
    CBInverted: TCheckBox;
    CBLegendStyle: TComboFlat;
    CBLegStyle: TComboFlat;
    BDivLines: TButtonPen;
    TabSymbol: TTabSheet;
    TabSheet3: TTabSheet;
    CBResizeChart: TCheckBox;
    L10: TLabel;
    SETopPos: TEdit;
    UDTopPos: TUpDown;
    L1: TLabel;
    SEMargin: TEdit;
    UDMargin: TUpDown;
    RGPosition: TRadioGroup;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    ECustLeft: TEdit;
    UDLeft: TUpDown;
    Label5: TLabel;
    ECustTop: TEdit;
    UDTop: TUpDown;
    Label1: TLabel;
    EVertSpacing: TEdit;
    UDVertSpacing: TUpDown;
    CBCustPos: TCheckBox;
    CBFontColor: TCheckBox;
    CBCheckBoxes: TComboFlat;
    TabTitle: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    Label6: TLabel;
    MemoText: TMemo;
    Label7: TLabel;
    CBTextAlign: TComboFlat;
    CBTitleVisible: TCheckBox;
    CBPosPercent: TCheckBox;
    Button1: TButton;
    procedure SEMarginChange(Sender: TObject);
    procedure CBLegendStyleChange(Sender: TObject);
    procedure SETopPosChange(Sender: TObject);
    procedure CBLegStyleChange(Sender: TObject);
    procedure CBShowClick(Sender: TObject);
    procedure CBResizeChartClick(Sender: TObject);
    procedure CBInvertedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EVertSpacingChange(Sender: TObject);
    procedure RGPositionClick(Sender: TObject);
    procedure ECustLeftChange(Sender: TObject);
    procedure ECustTopChange(Sender: TObject);
    procedure CBCustPosClick(Sender: TObject);
    procedure CBFontColorClick(Sender: TObject);
    procedure CBCheckBoxesChange(Sender: TObject);
    procedure CBTitleVisibleClick(Sender: TObject);
    procedure CBTextAlignChange(Sender: TObject);
    procedure MemoTextChange(Sender: TObject);
    procedure CBPosPercentClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    FLegend      : TChartLegend;
    ITeeObject   : TFormTeeShape;
    ITitleObject : TFormTeeShape;

    Function CanChangePos:Boolean;
    Procedure EnableCustomPosition;
    Procedure EnableMarginControls;
    procedure SetLeftTop;
    procedure SetLegend(Value:TChartLegend);
  public
    { Public declarations }
    Constructor Create(Owner:TComponent); override;
    Constructor CreateLegend(Owner:TComponent; ALegend:TChartLegend);

    property Legend:TChartLegend read FLegend write SetLegend;
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
  TeEngine, TeeSymbolEditor, TeeStringsEditor;

Constructor TFormTeeLegend.CreateLegend(Owner:TComponent; ALegend:TChartLegend);
begin
  {$IFDEF CLR}
  inherited Create(Owner);
  CreatingForm:=True;
  {$ELSE}
  Create(Owner);
  {$ENDIF}

  Legend:=ALegend;
end;

Constructor TFormTeeLegend.Create(Owner:TComponent);
begin
  inherited;
  CreatingForm:=True;
end;

procedure TFormTeeLegend.SetLegend(Value:TChartLegend);
begin
  FLegend:=Value;
  ITeeObject:=InsertTeeObjectForm(PageControl1,FLegend);
  ITitleObject:=InsertTeeObjectForm(PageControl2,FLegend.Title);;
end;

procedure TFormTeeLegend.SEMarginChange(Sender: TObject);
begin
  if not CreatingForm then
  With FLegend do
  if Vertical then HorizMargin:=UDMargin.Position
              else VertMargin:=UDMargin.Position;
end;

procedure TFormTeeLegend.CBLegendStyleChange(Sender: TObject);
begin
  FLegend.LegendStyle:=TLegendStyle(CBLegendStyle.ItemIndex);
end;

procedure TFormTeeLegend.SETopPosChange(Sender: TObject);
begin
  if not CreatingForm then FLegend.TopPos:=UDTopPos.Position;
end;

procedure TFormTeeLegend.CBLegStyleChange(Sender: TObject);
begin
  FLegend.TextStyle:=TLegendTextStyle(CBLegStyle.ItemIndex);
end;

procedure TFormTeeLegend.CBShowClick(Sender: TObject);
begin
  FLegend.Visible:=CBShow.Checked;
end;

procedure TFormTeeLegend.CBResizeChartClick(Sender: TObject);
begin
  FLegend.ResizeChart:=CBResizeChart.Checked;
end;

procedure TFormTeeLegend.CBInvertedClick(Sender: TObject);
begin
  FLegend.Inverted:=CBInverted.Checked;
end;

procedure TFormTeeLegend.FormShow(Sender: TObject);
begin
  if Assigned(FLegend) then
  begin
    With FLegend do
    begin
      UDTopPos.Position      :=TopPos;

      CBCustPos.Checked      :=CustomPosition;
      CBPosPercent.Checked   :=PositionUnits=muPercent;

      SetLeftTop;

      CBFontColor.Checked    :=FontSeriesColor;
      CBResizeChart.Checked  :=ResizeChart;
      CBLegendStyle.ItemIndex:=Ord(LegendStyle);
      CBLegStyle.ItemIndex   :=Ord(TextStyle);
      CBShow.Checked         :=Visible;
      CBInverted.Checked     :=Inverted;

      if CheckBoxes then
         if CheckBoxesStyle=cbsCheck then
            CBCheckBoxes.ItemIndex:=1
         else
            CBCheckBoxes.ItemIndex:=2
      else
        CBCheckBoxes.ItemIndex:=0;

      RGPosition.ItemIndex   :=Ord(Alignment);
      UDVertSpacing.Position :=VertSpacing;
      BDivLines.LinkPen(DividingLines);
      EnableMarginControls;
      EnableCustomPosition;

      AddFormTo(TSymbolEditor.Create(Self),TabSymbol,Symbol);

      // Legend Title
      MemoText.Lines.Text:=Title.Text.Text;

      if Title.TextAlignment=taLeftJustify then
         CBTextAlign.ItemIndex:=0
      else
      if Title.TextAlignment=taCenter then
         CBTextAlign.ItemIndex:=1
      else
         CBTextAlign.ItemIndex:=2;

      CBTitleVisible.Checked:=Title.Visible;
    end;

    ITeeObject.RefreshControls(FLegend);
    ITitleObject.RefreshControls(FLegend.Title);
  end;

  CreatingForm:=False;
  TeeTranslateControl(self);
end;

Procedure TFormTeeLegend.EnableCustomPosition;
var tmp : Boolean;
    Old : Boolean;
begin
  Old:=CreatingForm;
  CreatingForm:=True;

  SetLeftTop;

  tmp:=FLegend.CustomPosition;
  ECustLeft.Enabled :=tmp;
  ECustTop.Enabled  :=tmp;
  UDLeft.Enabled    :=tmp;
  UDTop.Enabled     :=tmp;
  CBPosPercent.Enabled:=tmp;

  CBResizeChart.Enabled:=not tmp;
  UDMargin.Enabled:=not tmp;
  SEMargin.Enabled:=not tmp;
  SETopPos.Enabled:=not tmp;
  UDTopPos.Enabled:=not tmp;
  CreatingForm:=Old;
end;

Procedure TFormTeeLegend.EnableMarginControls;
begin
  With FLegend do
  if Vertical then UDMargin.Position:=HorizMargin
              else UDMargin.Position:=VertMargin;
end;

procedure TFormTeeLegend.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  PageControl1.ActivePage:=TabSheet1;
end;

procedure TFormTeeLegend.EVertSpacingChange(Sender: TObject);
begin
  if (not CreatingForm) and Assigned(FLegend) then
     FLegend.VertSpacing:=UDVertSpacing.Position;
end;

procedure TFormTeeLegend.RGPositionClick(Sender: TObject);
begin
  FLegend.Alignment:=TLegendAlignment(RGPosition.ItemIndex);
end;

Function TFormTeeLegend.CanChangePos:Boolean;
begin
  result:=(not CreatingForm) and (FLegend.CustomPosition);
end;

procedure TFormTeeLegend.ECustLeftChange(Sender: TObject);
begin
  if CanChangePos then
     if FLegend.PositionUnits=muPercent then
        FLegend.LeftPercent:=UDLeft.Position
     else
        FLegend.Left:=UDLeft.Position;
end;

procedure TFormTeeLegend.ECustTopChange(Sender: TObject);
begin
  if CanChangePos then
     if FLegend.PositionUnits=muPercent then
        FLegend.TopPercent:=UDTop.Position
     else
        FLegend.Top:=UDTop.Position;
end;

procedure TFormTeeLegend.CBCustPosClick(Sender: TObject);
begin
  FLegend.CustomPosition:=CBCustPos.Checked;

  if FLegend.CustomPosition then
  begin
    FLegend.ResizeChart:=False;
    CBResizeChart.Checked:=False;
  end;

  EnableCustomPosition;
end;

procedure TFormTeeLegend.CBFontColorClick(Sender: TObject);
begin
  FLegend.FontSeriesColor:=CBFontColor.Checked
end;

procedure TFormTeeLegend.CBCheckBoxesChange(Sender: TObject);
begin
  FLegend.CheckBoxes:=CBCheckBoxes.ItemIndex>0;
  if FLegend.CheckBoxes then
    if CBCheckBoxes.ItemIndex=1 then
       FLegend.CheckBoxesStyle:=cbsCheck
    else
       FLegend.CheckBoxesStyle:=cbsRadio;
end;

procedure TFormTeeLegend.CBTitleVisibleClick(Sender: TObject);
begin
  FLegend.Title.Visible:=CBTitleVisible.Checked;
end;

procedure TFormTeeLegend.CBTextAlignChange(Sender: TObject);
begin
  case CBTextAlign.ItemIndex of
    0: FLegend.Title.TextAlignment:=taLeftJustify;
    1: FLegend.Title.TextAlignment:=taCenter;
  else
    FLegend.Title.TextAlignment:=taRightJustify;
  end;
end;

procedure TFormTeeLegend.MemoTextChange(Sender: TObject);
begin
  if not CreatingForm then
     FLegend.Title.Text.Text:=ReplaceChar(MemoText.Lines.Text,#10);
end;

procedure TFormTeeLegend.CBPosPercentClick(Sender: TObject);
begin
  if CBPosPercent.Checked then
     FLegend.PositionUnits:=muPercent
  else
     FLegend.PositionUnits:=muPixels;

  SetLeftTop;
end;

procedure TFormTeeLegend.SetLeftTop;
begin
  if FLegend.PositionUnits=muPercent then
     UDLeft.Position:=FLegend.LeftPercent
  else
     UDLeft.Position:=FLegend.Left;

  if FLegend.PositionUnits=muPercent then
     UDTop.Position:=FLegend.TopPercent
  else
     UDTop.Position:=FLegend.Top;
end;

procedure TFormTeeLegend.PageControl1Change(Sender: TObject);
begin
  if Assigned(ITeeObject) then
     ITeeObject.PC1Change(Sender);
end;

procedure TFormTeeLegend.PageControl2Change(Sender: TObject);
begin
  if Assigned(ITitleObject) then
     ITitleObject.PC1Change(Sender);
end;

procedure TFormTeeLegend.Button1Click(Sender: TObject);
begin
  TeeEditStrings(Self,MemoText.Lines);
end;

end.
