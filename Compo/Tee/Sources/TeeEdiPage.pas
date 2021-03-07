{**********************************************}
{  TCustomChart (or derived) Editor Dialog     }
{  Copyright (c) 1996-2009 by David Berneda    }
{**********************************************}
unit TeeEdiPage;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     TeCanvas,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons,
     {$ENDIF}
     {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeeProcs, TeEngine, Chart, TeeEdiGene, TeeNavigator, TeePenDlg;

type
  TFormTeePage = class(TForm)
    L17: TLabel;
    SEPointsPerPage: TEdit;
    CBScaleLast: TCheckBox;
    LabelPages: TLabel;
    UDPointsPerPage: TUpDown;
    CBPageLegend: TCheckBox;
    ChartPageNavigator1: TChartPageNavigator;
    CBPageNum: TCheckBox;
    CBAutoScale: TCheckBox;
    CBNoPages: TCheckBox;
    BEditTool: TButton;
    procedure SEPointsPerPageChange(Sender: TObject);
    procedure CBScaleLastClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBPageLegendClick(Sender: TObject);
    procedure CBPageNumClick(Sender: TObject);
    procedure ChartPageNavigator1ButtonClicked(Index: TTeeNavigateBtn);
    procedure CBAutoScaleClick(Sender: TObject);
    procedure CBNoPagesClick(Sender: TObject);
    procedure BEditToolClick(Sender: TObject);
  private
    { Private declarations }
    Function Chart:TCustomChart;
    Function PageNumTool(CreateTool:Boolean):TTeeCustomTool;
    procedure SetEditTool;
    procedure SetNoPages;
  public
    { Public declarations }
    Constructor CreateChart(Owner:TComponent; AChart:TCustomChart);
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
  TeeConst;

{ TFormTeePage }
Constructor TFormTeePage.CreateChart(Owner:TComponent; AChart:TCustomChart);
begin
  inherited Create(Owner);
  ChartPageNavigator1.Chart:=AChart;
end;

procedure TFormTeePage.SEPointsPerPageChange(Sender: TObject);
begin
  if Showing then
  begin
    With Chart.Pages do
    if SEPointsPerPage.Text='' then MaxPointsPerPage:=0
                               else MaxPointsPerPage:=UDPointsPerPage.Position;

    SetNoPages;

    ChartPageNavigator1ButtonClicked(nbCancel);
  end;
end;

procedure TFormTeePage.CBScaleLastClick(Sender: TObject);
begin
  Chart.Pages.ScaleLastPage:=CBScaleLast.Checked;
end;

procedure TFormTeePage.FormShow(Sender: TObject);
var tmp : TTeeCustomTool;
begin
  if Chart<>nil then
  With Chart do
  begin
    UDPointsPerPage.Position :=Pages.MaxPointsPerPage;
    CBScaleLast.Checked      :=Pages.ScaleLastPage;
    CBPageLegend.Checked     :=Legend.CurrentPage;
    CBAutoScale.Checked      :=Pages.AutoScale;

    SetNoPages;

    ChartPageNavigator1ButtonClicked(nbCancel);
  end;

  CBPageNum.Visible:=Assigned(TeePageNumToolClass);

  tmp:=PageNumTool(False);

  CBPageNum.Checked:=Assigned(tmp) and tmp.Active;

  SetEditTool;
end;

{ try to find a PageNumber tool in Chart. If not found, create it }
Function TFormTeePage.PageNumTool(CreateTool:Boolean):TTeeCustomTool;
var t   : Integer;
    tmp : TComponent;
begin
  if Chart<>nil then
  with Chart.Tools do
  for t:=0 to Count-1 do
      if Items[t] is TeePageNumToolClass then
      begin
        result:=Items[t];
        exit;
      end;

  { not found }
  if CreateTool then { do create }
  begin
    tmp:=Chart;
    if Assigned(tmp) and Assigned(tmp.Owner) then
       tmp:=tmp.Owner;

    result:=TeePageNumToolClass.Create(tmp);
    result.Name:=TeeGetUniqueName(tmp,TeeMsg_DefaultToolName);

    if Chart<>nil then Chart.Tools.Add(result);
  end
  else
     result:=nil;
end;

procedure TFormTeePage.CBPageLegendClick(Sender: TObject);
begin
  Chart.Legend.CurrentPage:=CBPageLegend.Checked;
end;

procedure TFormTeePage.ChartPageNavigator1ButtonClicked(
  Index: TTeeNavigateBtn);
begin
  With Chart.Pages do
      LabelPages.Caption:=Format(TeeMsg_PageOfPages,[Current,Count]);
end;

// Show / hide the Page Number tool
procedure TFormTeePage.CBPageNumClick(Sender: TObject);
begin
  PageNumTool(True).Active:=(Sender as TCheckBox).Checked; { 5.02 }

  SetEditTool;
end;

procedure TFormTeePage.SetEditTool;
begin
  BEditTool.Visible:=CBPageNum.Visible;
  BEditTool.Enabled:=BEditTool.Visible and Assigned(PageNumTool(False));
end;

function TFormTeePage.Chart: TCustomChart;
begin
  result:=ChartPageNavigator1.Chart;
end;

procedure TFormTeePage.CBAutoScaleClick(Sender: TObject);
begin
  Chart.Pages.AutoScale:=CBAutoScale.Checked;
end;

procedure TFormTeePage.CBNoPagesClick(Sender: TObject);
begin
  if CBNoPages.Checked then
     UDPointsPerPage.Position:=0;

  SetNoPages;
end;

procedure TFormTeePage.SetNoPages;
begin
  CBNoPages.Checked:=UDPointsPerPage.Position=0;
  CBNoPages.Enabled:=not CBNoPages.Checked;
end;

type
  TToolAccess=class(TTeeCustomTool);

procedure TFormTeePage.BEditToolClick(Sender: TObject);
var tmp : TTeeCustomTool;
    tmpClass : TClass;
    tmpForm : TForm;
begin
  tmp:=PageNumTool(False);

  if Assigned(tmp) then
  begin
    tmpClass:=GetClass(TToolAccess(tmp).GetEditorClass);

    if Assigned(tmpClass) then
    begin
      tmpForm:=TFormClass(tmpClass).Create(Self);
      try
        tmpForm.Align:=alNone;
        PositionToCenter(tmpForm);

        tmpForm.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(tmp);

        TeeTranslateControl(tmpForm);
        tmpForm.ShowModal;
      finally
        tmpForm.Free;
      end;
    end;
  end;
end;

end.
