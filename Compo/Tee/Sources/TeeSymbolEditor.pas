{**********************************************}
{  TLegendSymbol (or derived) Editor Dialog    }
{  Copyright (c) 2006-2009 by David Berneda    }
{**********************************************}
unit TeeSymbolEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons,
     {$ENDIF}
     Chart, TeeProcs, TeCanvas, TeePenDlg, TeeEdiGrad;

type
  TSymbolEditor = class(TForm)
    L11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SEColWi: TEdit;
    UDColWi: TUpDown;
    CBColWUnits: TComboFlat;
    CBSymbolPos: TComboFlat;
    CBContinuous: TCheckBox;
    CBVisible: TCheckBox;
    CBSymPen: TCheckBox;
    BSymPen: TButtonPen;
    CBSquared: TCheckBox;
    BSymGradient: TButtonGradient;
    Button1: TButton;
    procedure CBVisibleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SEColWiChange(Sender: TObject);
    procedure CBColWUnitsChange(Sender: TObject);
    procedure CBSymbolPosChange(Sender: TObject);
    procedure CBContinuousClick(Sender: TObject);
    procedure CBSymPenClick(Sender: TObject);
    procedure CBSquaredClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    Symbol       : TLegendSymbol;

    Procedure EnableWidthControls;
  public
    { Public declarations }
    procedure RefreshSymbol(ASymbol:TLegendSymbol);
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
  TeeShadowEditor;
  
procedure TSymbolEditor.CBVisibleClick(Sender: TObject);
begin
  Symbol.Visible:=CBVisible.Checked
end;

procedure TSymbolEditor.RefreshSymbol(ASymbol:TLegendSymbol);
begin
  Symbol:=ASymbol;

  if Assigned(Symbol) then
  With Symbol do
  begin
    UDColWi.Position:=Width;

    if WidthUnits=lcsPercent then CBColWUnits.ItemIndex:=0
                             else CBColWUnits.ItemIndex:=1;

    if Position=spLeft then CBSymbolPos.ItemIndex:=0
                       else CBSymbolPos.ItemIndex:=1;

    CBContinuous.Checked:=Continuous;
    CBSquared.Checked:=Squared;
    CBVisible.Checked:=Visible;
    CBSymPen.Checked:=DefaultPen;
    BSymPen.LinkPen(Pen);
    BSymPen.Enabled:=not DefaultPen;

    BSymGradient.Gradient:=Gradient;
    BSymGradient.OnlyStart:=True;
  end;
end;

procedure TSymbolEditor.FormShow(Sender: TObject);
begin
  RefreshSymbol(TLegendSymbol(Tag));
  CreatingForm:=False;
  TeeTranslateControl(Self);
end;

procedure TSymbolEditor.SEColWiChange(Sender: TObject);
begin
  if not CreatingForm then
     Symbol.Width:=UDColWi.Position;
end;

Procedure TSymbolEditor.EnableWidthControls;
begin
  EnableControls(not Symbol.Squared,[UDColWi,SEColWi]);
end;

procedure TSymbolEditor.CBColWUnitsChange(Sender: TObject);
begin
  if CBColWUnits.ItemIndex=0 then
     Symbol.WidthUnits:=lcsPercent
  else
     Symbol.WidthUnits:=lcsPixels;
end;

procedure TSymbolEditor.CBSymbolPosChange(Sender: TObject);
begin
  if CBSymbolPos.ItemIndex=0 then Symbol.Position:=spLeft
                             else Symbol.Position:=spRight;
end;

procedure TSymbolEditor.CBContinuousClick(Sender: TObject);
begin
  Symbol.Continuous:=CBContinuous.Checked
end;

procedure TSymbolEditor.CBSymPenClick(Sender: TObject);
begin
  Symbol.DefaultPen:=CBSymPen.Checked;
  BSymPen.Enabled:=not CBSymPen.Checked;
end;

procedure TSymbolEditor.CBSquaredClick(Sender: TObject);
begin
  Symbol.Squared:=CBSquared.Checked;
  EnableWidthControls;
end;

procedure TSymbolEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
end;

procedure TSymbolEditor.Button1Click(Sender: TObject);
begin
  EditTeeShadow(Self, Symbol.Shadow);
end;

end.
