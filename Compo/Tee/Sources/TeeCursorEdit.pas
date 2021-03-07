{******************************************}
{ TCursorTool Editor Dialog                }
{ Copyright (c) 1999-2009 by David Berneda }
{******************************************}
unit TeeCursorEdit;
{$I TeeDefs.inc}

interface

uses SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     Buttons,
     {$ENDIF}
     Chart, TeeTools, TeCanvas, TeePenDlg, TeeToolSeriesEdit;

type
  TCursorToolEditor = class(TSeriesToolEditor)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    BPen: TButtonPen;
    TabSheet2: TTabSheet;
    CBZ: TCheckBox;
    CBSnap: TCheckBox;
    CBSnapStyle: TComboFlat;
    Label5: TLabel;
    CBStyle: TComboFlat;
    TabSheet3: TTabSheet;
    CBFollow: TCheckBox;
    Label3: TLabel;
    EPixels: TEdit;
    UDClick: TUpDown;
    Label4: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    UDHorizSize: TUpDown;
    Label7: TLabel;
    Edit2: TEdit;
    UDVertSize: TUpDown;
    Label9: TLabel;
    Label10: TLabel;
    EScope: TEdit;
    UDScope: TUpDown;
    Label6: TLabel;
    CBScopeStyle: TComboFlat;
    procedure FormShow(Sender: TObject);
    procedure CBSeriesChange(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure CBSnapClick(Sender: TObject);
    procedure CBFollowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBZClick(Sender: TObject);
    procedure EPixelsChange(Sender: TObject);
    procedure CBSnapStyleChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure EScopeChange(Sender: TObject);
    procedure CBScopeStyleChange(Sender: TObject);
  private
    { Private declarations }
    CursorTool : TCursorTool;

    procedure EnableSnap;
    procedure EnableScope;
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

Uses TeEngine, TeeConst, TeeProCo;

procedure TCursorToolEditor.FormShow(Sender: TObject);
begin
  inherited;
  CursorTool:=TCursorTool(Tag);

  if Assigned(CursorTool) then
  With CursorTool do
  begin
    CBStyle.ItemIndex:=Ord(Style);
    CBSnap.Checked:=Snap;
    CBSnapStyle.ItemIndex:=Ord(SnapStyle);
    CBZ.Checked:=UseSeriesZ;
    CBZ.Enabled:=CBSnap.Enabled;
    CBFollow.Checked:=FollowMouse;
    BPen.LinkPen(Pen);
    UDClick.Position:=ClickTolerance;
    UDHorizSize.Position:=HorizSize;
    UDVertSize.Position:=VertSize;
    UDScope.Position:=ScopeSize;
    CBScopeStyle.ItemIndex:=Ord(ScopeStyle);

    EnableSnap;
    EnableScope;
  end;
end;

procedure TCursorToolEditor.EnableSnap;
begin
  CBSnap.Enabled:=Assigned(CursorTool.Series);
  CBSnapStyle.Enabled:=CBSnap.Enabled and CursorTool.Snap;
end;

procedure TCursorToolEditor.CBSeriesChange(Sender: TObject);
begin
  inherited;
  EnableSnap;
  CBZ.Enabled:=CBSnap.Enabled;
end;

procedure TCursorToolEditor.CBStyleChange(Sender: TObject);
begin
  CursorTool.Style:=TCursorToolStyle(CBStyle.ItemIndex);

  if (CursorTool.Style=cssScope) or (CursorTool.Style=cssScopeOnly) then
  begin
    if CursorTool.HorizSize=0 then
       UDHorizSize.Position:=20;

    if CursorTool.VertSize=0 then
       UDVertSize.Position:=20;
  end;

  EnableScope;
end;

procedure TCursorToolEditor.EnableScope;
begin
  UDScope.Enabled:=(CursorTool.Style=cssScope) or (CursorTool.Style=cssScopeOnly);
  EScope.Enabled:=UDScope.Enabled;
end;

procedure TCursorToolEditor.CBSnapClick(Sender: TObject);
begin
  CursorTool.Snap:=CBSnap.Checked;
  EnableSnap;
end;

procedure TCursorToolEditor.CBFollowClick(Sender: TObject);
begin
  CursorTool.FollowMouse:=CBFollow.Checked
end;

procedure TCursorToolEditor.FormCreate(Sender: TObject);
begin
  inherited;
  Align:=alClient;
end;

procedure TCursorToolEditor.CBZClick(Sender: TObject);
begin
  CursorTool.UseSeriesZ:=CBZ.Checked
end;

procedure TCursorToolEditor.EPixelsChange(Sender: TObject);
begin
  if Assigned(CursorTool) then
     CursorTool.ClickTolerance:=UDClick.Position;
end;

procedure TCursorToolEditor.CBSnapStyleChange(Sender: TObject);
begin
  CursorTool.SnapStyle:=TSnapStyle(CBSnapStyle.ItemIndex);
end;

procedure TCursorToolEditor.Edit1Change(Sender: TObject);
begin
  if Assigned(CursorTool) then
     CursorTool.HorizSize:=UDHorizSize.Position;
end;

procedure TCursorToolEditor.Edit2Change(Sender: TObject);
begin
  if Assigned(CursorTool) then
     CursorTool.VertSize:=UDVertSize.Position;
end;

procedure TCursorToolEditor.EScopeChange(Sender: TObject);
begin
  if Assigned(CursorTool) then
     CursorTool.ScopeSize:=UDScope.Position;
end;

procedure TCursorToolEditor.CBScopeStyleChange(Sender: TObject);
begin
  CursorTool.ScopeStyle:=TScopeCursorStyle(CBScopeStyle.ItemIndex);
end;

initialization
  RegisterClass(TCursorToolEditor);
end.
