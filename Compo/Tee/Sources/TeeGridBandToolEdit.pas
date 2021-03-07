{******************************************}
{ TGridBandTool Editor Dialog              }
{ Copyright (c) 1999-2009 by David Berneda }
{******************************************}
unit TeeGridBandToolEdit;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls, Types,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
  {$ENDIF}
  TeeAxisToolEdit, TeCanvas, TeePenDlg, TeeProcs, TeeDraw3D, TeeTools,
  TeeEdiGrad;

type
  TGridBandToolEdit = class(TAxisToolEditor)
    TabControl1: TTabControl;
    Label2: TLabel;
    BBand1: TButton;
    Draw3D1: TDraw3D;
    ButtonColor1: TButtonColor;
    Edit1: TEdit;
    UpDown1: TUpDown;
    ButtonGradient1: TButtonGradient;
    procedure FormCreate(Sender: TObject);
    procedure BBand1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Draw3D1AfterDraw(Sender: TObject);
    procedure ButtonColor1Click(Sender: TObject);
    procedure Draw3D1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure ButtonGradient1Click(Sender: TObject);
  private
    { Private declarations }
    GridBand : TGridBandTool;

    function Band:TGridBandBrush;
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

uses
  TeeBrushDlg;

procedure TGridBandToolEdit.FormCreate(Sender: TObject);
begin
  inherited;

  // CLX needs creating tabs by code:
  
  TabControl1.Tabs.Add('Band 1'); // Do not localize
  TabControl1.Tabs.Add('Band 2'); // Do not localize

  BPen.Visible:=False;
  BBand1.Top:=Draw3D1.Top;
end;

function TGridBandToolEdit.Band:TGridBandBrush;
begin
  if TabControl1.TabIndex=0 then result:=GridBand.Band1
                            else result:=GridBand.Band2;
end;

procedure TGridBandToolEdit.BBand1Click(Sender: TObject);
begin
  EditChartBrush(Self,Band);
  Draw3D1.Invalidate;
end;

procedure TGridBandToolEdit.FormShow(Sender: TObject);
begin
  inherited;
  GridBand:=TGridBandTool(Tag);
  TabControl1.TabIndex:=0;
  TabControl1Change(Self);
end;

procedure TGridBandToolEdit.Draw3D1AfterDraw(Sender: TObject);
var tmpR : TRect;
begin
  if Assigned(GridBand) and (not Band.Gradient.Visible) then
  with Draw3D1 do
  begin
    Canvas.AssignBrush(Band,Band.Color,GridBand.BandBackColor(Band));
    tmpR:=ChartBounds;
    InflateRect(tmpR,-1,-1);
    Canvas.FillRect(tmpR);
  end;
end;

procedure TGridBandToolEdit.ButtonColor1Click(Sender: TObject);
begin
  Draw3D1.Invalidate;
end;

procedure TGridBandToolEdit.Draw3D1Click(Sender: TObject);
begin
  with Band do Color:=EditColor(Self,Color);
  Draw3D1.Invalidate;
end;

procedure TGridBandToolEdit.Edit1Change(Sender: TObject);
begin
  if Showing then
     Band.Transparency:=UpDown1.Position;
end;

procedure TGridBandToolEdit.TabControl1Change(Sender: TObject);
begin
  if Assigned(GridBand) then
  begin
    ButtonColor1.LinkProperty(Band,'BackColor'); // Do not localize

    UpDown1.Position:=Band.Transparency;
    ButtonGradient1.LinkGradient(Band.Gradient);

    Draw3D1.Gradient:=Band.Gradient;
    Draw3D1.Invalidate;
  end;
end;

procedure TGridBandToolEdit.ButtonGradient1Click(Sender: TObject);
begin
  Draw3D1.Gradient:=Band.Gradient;
  Draw3D1.Invalidate;
end;

initialization
  RegisterClass(TGridBandToolEdit);
end.
