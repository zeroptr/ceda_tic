{*******************************************}
{  TCustomChartWall Editor Dialog           }
{  Copyright (c) 1996-2009 by David Berneda }
{*******************************************}
unit TeeEdiWall;
{$I TeeDefs.inc}

interface

uses Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     {$ENDIF}
     Chart, TeCanvas, TeeProcs, TeePenDlg, TeeEdiGrad, TeeShadowEditor;

type
  TFormTeeWall = class(TForm)
    TabSubWalls: TTabControl;
    L33: TLabel;
    BWallColor: TButtonColor;
    BWallPen: TButtonPen;
    BWallBrush: TButton;
    SEWallSize: TEdit;
    CBTransp: TCheckBox;
    UDWallSize: TUpDown;
    CBDark3D: TCheckBox;
    BGradient: TButtonGradient;
    CBVisible: TCheckBox;
    Label1: TLabel;
    Edit1: TEdit;
    UDTransp: TUpDown;
    Panel1: TPanel;
    CBView3dWalls: TCheckBox;
    CBAutoHide: TCheckBox;
    Label2: TLabel;
    EAllSize: TEdit;
    UDAllSize: TUpDown;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Edit2: TEdit;
    UDStart: TUpDown;
    Label4: TLabel;
    Edit3: TEdit;
    UDEnd: TUpDown;
    BImage: TButton;
    BShadow: TButton;
    procedure TabSubWallsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBView3dWallsClick(Sender: TObject);
    procedure BWallBrushClick(Sender: TObject);
    procedure SEWallSizeChange(Sender: TObject);
    procedure CBTranspClick(Sender: TObject);
    procedure CBDark3DClick(Sender: TObject);
    procedure BGradientClick(Sender: TObject);
    procedure CBVisibleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CBAutoHideClick(Sender: TObject);
    procedure EAllSizeChange(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure BImageClick(Sender: TObject);
    procedure BShadowClick(Sender: TObject);
  private
    { Private declarations }
    SettingAllSize : Boolean;
    TheWall : TCustomChartWall;

    procedure SetWallControls;
    Function TheChart:TCustomChart;
  public
    { Public declarations }
    Constructor CreateWall(AOwner:TComponent; AWall:TCustomChartWall);

    procedure RefreshControls(Wall:TCustomChartWall);
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
  TeEngine, TeeBrushDlg, TeeBackImage;

Constructor TFormTeeWall.CreateWall(AOwner:TComponent; AWall:TCustomChartWall);
begin
  inherited Create(AOwner);
  TheWall:=AWall;
end;

procedure TFormTeeWall.RefreshControls(Wall:TCustomChartWall);
begin
  TheWall:=Wall;

  With TheChart.Walls do
  if TheWall=Left then TabSubWalls.TabIndex:=0 else
  if TheWall=Right then TabSubWalls.TabIndex:=1 else
  if TheWall=Bottom then TabSubWalls.TabIndex:=2 else
                         TabSubWalls.TabIndex:=3;

  SetWallControls;
end;

procedure TFormTeeWall.TabSubWallsChange(Sender: TObject);
begin
  with TheChart.Walls do
  case TabSubWalls.TabIndex of
    0: TheWall:=Left;
    1: TheWall:=Right;
    2: TheWall:=Bottom;
  else TheWall:=Back;
  end;

  SetWallControls;
end;

procedure TFormTeeWall.FormShow(Sender: TObject);
begin
  if Assigned(TheWall) then
     RefreshControls(TheWall);
end;

procedure TFormTeeWall.CBView3DWallsClick(Sender: TObject);
begin
  TheChart.View3DWalls:=CBView3DWalls.Checked;
end;

procedure TFormTeeWall.BWallBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,TheWall.Brush);
end;

procedure TFormTeeWall.SEWallSizeChange(Sender: TObject);
begin
  if Showing then
  begin
    TheWall.Size:=UDWallSize.Position;
    CBDark3D.Enabled:=TheWall.Size>0;
  end;
end;

procedure TFormTeeWall.SetWallControls;
begin
  CBView3DWalls.Checked:=TheChart.View3DWalls;

  With TheWall do
  begin
    UDWallSize.Position :=Size;
    CBTransp.Checked    :=Transparent;
    CBDark3D.Checked    :=Dark3D;
    CBDark3D.Enabled    :=Size>0;
    CBVisible.Checked   :=Visible;
    CBAutoHide.Checked  :=AutoHide;
    UDTransp.Position   :=Transparency;
    UDStart.Position    :=StartPosition;
    UDEnd.Position      :=EndPosition;
    BGradient.Gradient  :=Gradient;

    SettingAllSize:=True;
    try
      UDAllSize.Position    :=Size;
    finally
      SettingAllSize:=False;
    end;

    BWallPen.LinkPen(Pen);
  end;

  // AutoHide not applicable to Bottom Wall.
  CBAutoHide.Visible:=TheWall<>TheChart.Walls.Bottom;

  BShadow.Visible:=TheWall=TheChart.Walls.Back;

  BWallColor.LinkProperty(TheWall,'Color'); // Do not localize
  BWallColor.Repaint;
end;

procedure TFormTeeWall.CBTranspClick(Sender: TObject);
begin
  TheWall.Transparent:=CBTransp.Checked;
end;

procedure TFormTeeWall.CBDark3DClick(Sender: TObject);
begin
  TheWall.Dark3D:=CBDark3D.Checked;
end;

procedure TFormTeeWall.BGradientClick(Sender: TObject);
begin
  if TheWall.Gradient.Visible then { 5.02 }
  begin
    TheWall.Transparent:=False;
    CBTransp.Checked:=False;
  end;
end;

function TFormTeeWall.TheChart: TCustomChart;
begin
  result:=TCustomChart(TheWall.ParentChart);
end;

procedure TFormTeeWall.CBVisibleClick(Sender: TObject);
begin
  TheWall.Visible:=CBVisible.Checked;
end;

procedure TFormTeeWall.FormCreate(Sender: TObject);
begin
  Align:=alClient;

  With TabSubWalls.Tabs do
  begin
    Add('Left'); // Do not localize
    Add('Right'); // Do not localize
    Add('Bottom'); // Do not localize
    Add('Back'); // Do not localize
  end;
end;

procedure TFormTeeWall.Edit1Change(Sender: TObject);
begin
  if Showing then TheWall.Transparency:=UDTransp.Position;
end;

procedure TFormTeeWall.CBAutoHideClick(Sender: TObject);
begin
  TheWall.AutoHide:=CBAutoHide.Checked;
end;

procedure TFormTeeWall.EAllSizeChange(Sender: TObject);
begin
  if Showing and (not SettingAllSize) then
  begin
    TheChart.Walls.Size:=UDAllSize.Position;
    SetWallControls;
  end;
end;

procedure TFormTeeWall.Edit2Change(Sender: TObject);
begin
  if Showing then
     TheWall.StartPosition:=UDStart.Position;
end;

procedure TFormTeeWall.Edit3Change(Sender: TObject);
begin
  if Showing then
     TheWall.EndPosition:=UDEnd.Position;
end;

procedure TFormTeeWall.BImageClick(Sender: TObject);
var tmp : TBackImageEditor;
begin
  tmp:=TeeCreateForm(TBackImageEditor,GetParentForm(Self)) as TBackImageEditor;
  with tmp do
  try
    RefreshControls(TheWall.Picture);
    RGBitmap.Hide;
    GBPosition.Hide;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormTeeWall.BShadowClick(Sender: TObject);
begin
  EditTeeShadow(Self,TheWall.Shadow)
end;

end.

