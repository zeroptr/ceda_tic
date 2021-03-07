{******************************************}
{   TeeChart Axis Divider Tool             }
{ Copyright (c) 2001-2005 by David Berneda }
{        All Rights Reserved               }
{******************************************}
unit TeeAxisDivider;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages, 
  {$ENDIF}
  SysUtils, Classes, 
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls,
  {$ENDIF}
  TeeColorLineEditor, TeCanvas, TeePenDlg, TeEngine, TeeTools, ComCtrls,
  ExtCtrls;

type
  TAxisDividerTool=class(TColorLineTool)
  private
    FAxis2: TChartAxis;
    procedure ReadAxis2(Reader: TReader);
    procedure SetAxis2(const Value: TChartAxis);
    procedure WriteAxis2(Writer: TWriter);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoEndDragLine; override;
    class Function GetEditorClass:String; override;
  public
    class Function Description:String; override;
  published
    property Axis2:TChartAxis read FAxis2 write SetAxis2 stored False;
  end;

  TAxisDividerEditor = class(TColorLineToolEditor)
    CBAxis2: TComboBox;
    Label4: TLabel;
    procedure CBAxisChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBAxis2Change(Sender: TObject);
  private
    { Private declarations }
    Procedure AddAxes2;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst, Chart, TeeChartOfficeConstants;

{ TAxisDividerTool }

procedure TAxisDividerTool.ChartEvent(AEvent: TChartToolEvent);
begin
  if Assigned(Axis) and
     Assigned(Axis2) and
     (AEvent=cteBeforeDrawSeries) then
  begin
    if Axis.StartPosition<=Axis2.StartPosition then
       Value:=Axis.Minimum
    else
       Value:=Axis.Maximum;
  end;
  inherited;
end;

procedure TAxisDividerTool.ReadAxis2(Reader: TReader);
begin
  Axis2:=ParentChart.Axes[Reader.ReadInteger];
end;

procedure TAxisDividerTool.SetAxis2(const Value: TChartAxis);
begin
  FAxis2:=Value;
  Repaint;
end;

procedure TAxisDividerTool.WriteAxis2(Writer: TWriter);
begin
  Writer.WriteInteger(ParentChart.Axes.IndexOf(Axis2));
end;

class function TAxisDividerTool.GetEditorClass: String;
begin
  result:='TAxisDividerEditor';
end;

class function TAxisDividerTool.Description: String;
begin
  result:=TeeMsg_AxisDivider;
end;

procedure TAxisDividerTool.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Axis2ID',ReadAxis2,WriteAxis2,Assigned(Axis2));
end;

procedure TAxisDividerTool.DoEndDragLine;
begin
  if Assigned(Axis) and Assigned(Axis2) then
  begin 
    if Axis.StartPosition<=Axis2.StartPosition then
    begin
      if Axis.Minimum<>0 then
         Axis2.StartPosition:=Axis.CalcPosValue(Value)*100.0/Axis.Maximum;
      Axis.EndPosition:=Axis2.StartPosition;
    end
    else
    begin
      if Axis.Maximum<>0 then
         Axis.StartPosition:=Axis.CalcPosValue(Value)*100.0/Axis.Maximum;
      Axis2.EndPosition:=Axis.StartPosition;
    end;
  end;
  inherited;
end;

{ TAxisDividerEditor }

procedure TAxisDividerEditor.AddAxes2;

  Procedure AddAxis(Const St:String; Axis:TChartAxis);
  begin
    if Axis<>AxisTool.Axis then
       CBAxis2.Items.AddObject(St,Axis);
  end;

var t : Integer;
begin
  CBAxis2.Items.Clear;
  if Assigned(AxisTool.Axis) then
  begin
    if AxisTool.Axis.Horizontal then
    begin
      AddAxis(TeeMsg_TopAxis,AxisTool.ParentChart.TopAxis);
      AddAxis(TeeMsg_BottomAxis,AxisTool.ParentChart.BottomAxis);
    end
    else
    begin
      AddAxis(TeeMsg_LeftAxis,AxisTool.ParentChart.LeftAxis);
      AddAxis(TeeMsg_RightAxis,AxisTool.ParentChart.RightAxis);
    end;

    with AxisTool.ParentChart.CustomAxes do
    for t:=0 to Count-1 do
    if Items[t].Horizontal=AxisTool.Axis.Horizontal then
       AddAxis(TeeMsg_CustomAxesEditor+IntToStr(t),Items[t]);
  end;
end;

procedure TAxisDividerEditor.CBAxisChange(Sender: TObject);
begin
  inherited;
  AddAxes2;
end;

procedure TAxisDividerEditor.FormShow(Sender: TObject);
begin
  inherited;
  CBNoLimitDrag.Visible:=False;
  
  AddAxes2;

  { find axis2 }
  with TAxisDividerTool(AxisTool) do
  if Assigned(Axis) and Assigned(Axis2) then
     with CBAxis2 do ItemIndex:=Items.IndexOfObject(Axis2)
  else
     CBAxis2.ItemIndex:=-1;
end;

procedure TAxisDividerEditor.CBAxis2Change(Sender: TObject);
begin
  inherited;
  TAxisDividerTool(AxisTool).Axis2:=TChartAxis(CBAxis2.Items.Objects[CBAxis2.ItemIndex]);
end;

initialization
  RegisterClass(TAxisDividerEditor);
  RegisterTeeTools([TAxisDividerTool]);
finalization
  UnRegisterTeeTools([TAxisDividerTool]);
end.
