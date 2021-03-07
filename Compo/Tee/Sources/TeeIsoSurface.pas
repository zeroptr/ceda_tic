{*******************************************}
{ TeeChart Pro Charting Library             }
{ IsoSurface (Surface+Color Banding) Series }
{ Copyright (c) 2006-2009 by David Berneda  }
{ All Rights Reserved                       }
{*******************************************}
unit TeeIsoSurface;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  Classes,
  {$IFDEF CLX}
  QComCtrls, QStdCtrls, QControls, QExtCtrls,
  {$ELSE}
  ComCtrls, StdCtrls, Controls, ExtCtrls,
  {$ENDIF}
  TeeSurfa, TeeSurfEdit, TeePenDlg, TeCanvas;

type
  TIsoSurfaceEditor = class(TSurfaceSeriesEditor)
    BBandsPen: TButtonPen;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$IFDEF CLR}
{$R 'TIsoSurfaceSeries.bmp'} // Do not localize
{$ENDIF}

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  Chart, TeeProCo;

procedure TIsoSurfaceEditor.FormShow(Sender: TObject);
begin
  inherited;

  if Assigned(Surface) then
     BBandsPen.LinkPen(TIsoSurfaceSeries(Surface).BandPen);
end;

initialization
  RegisterClass(TIsoSurfaceEditor);
end.
