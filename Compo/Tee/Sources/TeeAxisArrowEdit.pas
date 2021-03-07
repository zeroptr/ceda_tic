{********************************************}
{  TAxisArrowTool Editor                     }
{  Copyright (c) 1996-2009 by David Berneda  }
{        All Rights Reserved                 }
{********************************************}
unit TeeAxisArrowEdit;
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
     TeeAxisToolEdit, TeCanvas, TeePenDlg, TeeTools;

type
  TAxisArrowToolEditor = class(TAxisToolEditor)
    Button1: TButton;
    UDLength: TUpDown;
    ELength: TEdit;
    LL: TLabel;
    Label2: TLabel;
    CBPos: TComboFlat;
    Label3: TLabel;
    Edit1: TEdit;
    UDScroll: TUpDown;
    Label4: TLabel;
    CBInv: TCheckBox;
    Label5: TLabel;
    UDSize: TUpDown;
    ESize: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    EWidth: TEdit;
    UDWidth: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ELC(Sender: TObject);
    procedure CBPosChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CBInvClick(Sender: TObject);
    procedure ESizeChange(Sender: TObject);
    procedure EWidthChange(Sender: TObject);
  private
    { Private declarations }
    AxisArrowTool : TAxisArrowTool;
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
  TeeBrushDlg, TeeProCo;

procedure TAxisArrowToolEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,AxisArrowTool.Brush);
end;

procedure TAxisArrowToolEditor.FormShow(Sender: TObject);
begin
  inherited;

  AxisArrowTool:=TAxisArrowTool(Tag);

  if Assigned(AxisArrowTool) then
  begin
    With AxisArrowTool do
    begin
      UDLength.Position:=Length;
      CBPos.ItemIndex:=Ord(Position);
      UDScroll.Position:=ScrollPercent;
      CBInv.Checked:=ScrollInverted;
      UDSize.Position:=SizePercent;
      UDWidth.Position:=HeadWidth;
    end;
  end;
end;

procedure TAxisArrowToolEditor.ELC(Sender: TObject);
begin
  if Showing then AxisArrowTool.Length:=UDLength.Position;
end;

procedure TAxisArrowToolEditor.CBPosChange(Sender: TObject);
begin
  AxisArrowTool.Position:=TAxisArrowToolPosition(CBPos.ItemIndex);
end;

procedure TAxisArrowToolEditor.Edit1Change(Sender: TObject);
begin
  if Showing then AxisArrowTool.ScrollPercent:=UDScroll.Position
end;

procedure TAxisArrowToolEditor.CBInvClick(Sender: TObject);
begin
  AxisArrowTool.ScrollInverted:=TCheckBox(Sender).Checked;
end;

procedure TAxisArrowToolEditor.ESizeChange(Sender: TObject);
begin
  if Showing then
     AxisArrowTool.SizePercent:=UDSize.Position;
end;

procedure TAxisArrowToolEditor.EWidthChange(Sender: TObject);
begin
  if Showing then
     AxisArrowTool.HeadWidth:=UDWidth.Position;
end;

initialization
  RegisterClass(TAxisArrowToolEditor);
end.
