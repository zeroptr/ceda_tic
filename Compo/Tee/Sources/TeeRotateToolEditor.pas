{**********************************************}
{   TRotateTool Editor                         }
{   Copyright (c) 1999-2009 by David Berneda   }
{**********************************************}
unit TeeRotateToolEditor;
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
     {$ENDIF}
     TeeTools, TeCanvas, TeePenDlg;

type
  TRotateToolEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    BOutline: TButtonPen;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabelInertia: TLabel;
    CBInverted: TCheckBox;
    CBStyle: TComboFlat;
    CBButton: TComboFlat;
    ESpeed: TEdit;
    UDSpeed: TUpDown;
    SBInertia: TScrollBar;
    Label6: TLabel;
    CBCursor: TComboFlat;
    GroupBox1: TGroupBox;
    ImageCursor: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBInvertedClick(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure CBButtonChange(Sender: TObject);
    procedure ESpeedChange(Sender: TObject);
    procedure SBInertiaChange(Sender: TObject);
    procedure CBCursorChange(Sender: TObject);
  private
    { Private declarations }
    Tool : TRotateTool;
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

procedure TRotateToolEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  PageControl1.ActivePage:=TabSheet1;
end;

procedure TRotateToolEditor.FormShow(Sender: TObject);
begin
  Tool:=TRotateTool(Tag);

  if Assigned(Tool) then
  with Tool do
  begin
    CBInverted.Checked:=Inverted;
    CBStyle.ItemIndex:=Ord(Style);

    case Button of
      mbLeft: CBButton.ItemIndex:=0;
      mbMiddle: CBButton.ItemIndex:=1;
    else
      CBButton.ItemIndex:=2;
    end;

    BOutline.LinkPen(Pen);

    UDSpeed.Position:=Speed;
    SBInertia.Position:=Inertia;

    TeeFillCursors(CBCursor,Cursor);
    TeePreviewCursor(Cursor,ImageCursor.Picture);
  end;
end;

procedure TRotateToolEditor.CBInvertedClick(Sender: TObject);
begin
  Tool.Inverted:=CBInverted.Checked;
end;

procedure TRotateToolEditor.CBStyleChange(Sender: TObject);
begin
  Tool.Style:=TRotateToolStyles(CBStyle.ItemIndex);
end;

procedure TRotateToolEditor.CBButtonChange(Sender: TObject);
begin
  Case CBButton.ItemIndex of
    0: Tool.Button:=mbLeft;
    1: Tool.Button:=mbMiddle;
  else
    Tool.Button:=mbRight;
  end;
end;

procedure TRotateToolEditor.ESpeedChange(Sender: TObject);
begin
  if Assigned(Tool) then
     Tool.Speed:=UDSpeed.Position;
end;

procedure TRotateToolEditor.SBInertiaChange(Sender: TObject);
begin
  Tool.Inertia:=SBInertia.Position;
  LabelInertia.Caption:=IntToStr(Tool.Inertia);
end;

procedure TRotateToolEditor.CBCursorChange(Sender: TObject);
begin
  with Tool do
  begin
    Cursor:=TeeSetCursor(Cursor,CBCursor.CurrentItem);
    TeePreviewCursor(Cursor,ImageCursor.Picture);
  end;
end;

initialization
  RegisterClass(TRotateToolEditor);
end.
