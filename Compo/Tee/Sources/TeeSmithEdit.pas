{******************************************}
{ TeeChart. Smith Series Editor            }
{ Copyright (c) 1996-2009 by David Berneda }
{******************************************}
unit TeeSmithEdit;
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
     TeeSmith, TeCanvas, TeePenDlg, TeeProcs;

type
  TSmithSeriesEdit = class(TForm)
    CBC: TCheckBox;
    CBR: TCheckBox;
    BCPen: TButtonPen;
    BRPen: TButtonPen;
    BCircle: TButtonPen;
    CBColorEach: TCheckBox;
    BBorder: TButtonPen;
    BCFont: TButton;
    BRFont: TButton;
    Label1: TLabel;
    EImag: TEdit;
    procedure FormShow(Sender: TObject);
    procedure CBCClick(Sender: TObject);
    procedure CBRClick(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure BCFontClick(Sender: TObject);
    procedure BRFontClick(Sender: TObject);
    procedure EImagChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CircledForm : TCustomForm;
    Smith       : TSmithSeries;
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
  TeeEdiSeri, TeePoEdi, TeeCircledEdit, TeeConst, TeeEdiFont;

procedure TSmithSeriesEdit.FormShow(Sender: TObject);
begin
  Smith:=TSmithSeries(Tag);

  if Assigned(Smith) then
  begin
    With Smith do
    begin
      CBC.Checked:=CLabels;
      CBR.Checked:=RLabels;
      BCPen.LinkPen(CCirclePen);
      BRPen.LinkPen(RCirclePen);
      BCircle.LinkPen(CirclePen);
      BBorder.LinkPen(Pen);
      CBColorEach.Checked:=ColorEachPoint;
      EImag.Text:=ImagSymbol;
    end;

    if not Assigned(CircledForm) then
       CircledForm:=TCircledSeriesEditor.CreateForm(Self, Smith);

//  if not Assigned(PointerForm) then
//     PointerForm:=TeeInsertPointerForm(Parent,Smith.Pointer,TeeMsg_GalleryPoint);
  end;
end;

procedure TSmithSeriesEdit.CBCClick(Sender: TObject);
begin
  Smith.CLabels:=CBC.Checked;
end;

procedure TSmithSeriesEdit.CBRClick(Sender: TObject);
begin
  Smith.RLabels:=CBR.Checked;
end;

procedure TSmithSeriesEdit.CBColorEachClick(Sender: TObject);
begin
  Smith.ColorEachPoint:=CBColorEach.Checked;
end;

procedure TSmithSeriesEdit.BCFontClick(Sender: TObject);
begin
  EditTeeFontEx(Self,Smith.CLabelsFont);
end;

procedure TSmithSeriesEdit.BRFontClick(Sender: TObject);
begin
  EditTeeFontEx(Self,Smith.RLabelsFont);
end;

procedure TSmithSeriesEdit.EImagChange(Sender: TObject);
begin
  Smith.ImagSymbol:=EImag.Text;
end;

procedure TSmithSeriesEdit.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

procedure TSmithSeriesEdit.FormDestroy(Sender: TObject);
begin
//  FreeAndNil(FPointerForm);
  FreeAndNil(CircledForm);
end;

initialization
  RegisterClass(TSmithSeriesEdit);
end.
