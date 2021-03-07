{**********************************************}
{   TDrawLineTool Editor                       }
{   Copyright (c) 1999-2009 by David Berneda   }
{**********************************************}
unit TeeDrawLineEditor;
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
     TeCanvas, TeePenDlg, TeeTools, TeeToolSeriesEdit;

type
  TDrawLineEdit = class(TSeriesToolEditor)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CBButton: TComboFlat;
    CBEnable: TCheckBox;
    CBSelect: TCheckBox;
    EPixels: TEdit;
    UDClick: TUpDown;
    CBSelectNew: TCheckBox;
    BPen: TButtonPen;
    Label4: TLabel;
    CBStyle: TComboFlat;
    procedure FormShow(Sender: TObject);
    procedure CBButtonChange(Sender: TObject);
    procedure CBEnableClick(Sender: TObject);
    procedure CBSelectClick(Sender: TObject);
    procedure EPixelsChange(Sender: TObject);
    procedure CBSelectNewClick(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
  private
    { Private declarations }
    Draw : TDrawLineTool;
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

procedure TDrawLineEdit.FormShow(Sender: TObject);
begin
  inherited;

  Draw:=TDrawLineTool(Tag);

  if Assigned(Draw) then
  with Draw do
  begin
    CBButton.ItemIndex:=Ord(Button);
    CBEnable.Checked:=EnableDraw;
    CBSelect.Checked:=EnableSelect;
    CBSelectNew.Checked:=SelectNewLines;
    BPen.LinkPen(Pen);
    UDClick.Position:=ClickTolerance;
    CBStyle.ItemIndex:=Ord(Style);
  end;
end;

procedure TDrawLineEdit.CBButtonChange(Sender: TObject);
begin
  Draw.Button:=TMouseButton(CBButton.ItemIndex);
end;

procedure TDrawLineEdit.CBEnableClick(Sender: TObject);
begin
  Draw.EnableDraw:=CBEnable.Checked
end;

procedure TDrawLineEdit.CBSelectClick(Sender: TObject);
begin
  Draw.EnableSelect:=CBSelect.Checked
end;

procedure TDrawLineEdit.EPixelsChange(Sender: TObject);
begin
  if Assigned(Draw) then
     Draw.ClickTolerance:=UDClick.Position;
end;

procedure TDrawLineEdit.CBSelectNewClick(Sender: TObject);
begin
  Draw.SelectNewLines:=CBSelectNew.Checked
end;

procedure TDrawLineEdit.CBStyleChange(Sender: TObject);
begin
  Draw.Style:=TDrawLineStyle(CBStyle.ItemIndex);
end;

initialization
  RegisterClass(TDrawLineEdit);
end.
