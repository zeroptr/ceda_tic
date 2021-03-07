{******************************************}
{    TDonutSeries Editor Dialog            }
{ Copyright (c) 1999-2009 by David Berneda }
{******************************************}
unit TeeDonutEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     Chart, Series, TeeDonut, TeeProcs, TeCanvas;

type
  TDonutSeriesEditor = class(TForm)
    EDonut: TEdit;
    UDDonut: TUpDown;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure EDonutChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Donut : TDonutSeries;
    FPieForm : TCustomForm;
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

Uses TeeConst, TeeProCo, TeePieEdit, TeeEdiSeri;

procedure TDonutSeriesEditor.FormShow(Sender: TObject);
begin
  Donut:=TDonutSeries(Tag);

  if Assigned(Donut) then
  begin
    if not Assigned(FPieForm) then
       FPieForm:=TFormTeeSeries.InsertSeriesForm(Parent,TPieSeriesEditor,
                                                 1,TeeMsg_GalleryDonut,
                                                 Donut);

    UDDonut.Position:=Donut.DonutPercent;
  end;
end;

procedure TDonutSeriesEditor.EDonutChange(Sender: TObject);
begin
  if Showing then Donut.DonutPercent:=UDDonut.Position;
end;

procedure TDonutSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

procedure TDonutSeriesEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FPieForm);
end;

initialization
  RegisterClass(TDonutSeriesEditor);
end.
