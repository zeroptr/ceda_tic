{**********************************************}
{   TImageTool Editor                          }
{   Copyright (c) 1999-2009 by David Berneda   }
{**********************************************}
unit TeeImageToolEdit;
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
     ExtDlgs,
     {$ENDIF}
     TeeToolSeriesEdit, TeeTools, TeCanvas, TeePenDlg;

type
  TChartImageToolEditor = class(TSeriesToolEditor)
    GroupBox2: TGroupBox;
    Image1: TImage;
    Button1: TButton;
    BSave: TButton;
    Button2: TButton;
    BBorder: TButtonPen;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BSaveClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    Image : TChartImageTool;
    Procedure CheckImageButton;
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

Uses {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeeBrushDlg, TeeConst, TeeFiltersEditor;

procedure TChartImageToolEditor.Button1Click(Sender: TObject);
var tmp : String;
begin
  if Button1.Tag={$IFDEF CLR}Variant{$ENDIF}(1) then
     Image.Picture:=nil
  else
  begin
    tmp:=TeeGetPictureFileName(Self);
    if tmp<>'' then
    begin
      Image.Picture.LoadFromFile(tmp);
      Image.Repaint;
    end;
  end;

  CheckImageButton;
end;

Procedure TChartImageToolEditor.CheckImageButton;
begin
  if Assigned(Image.Picture.Graphic) then
  begin
    Button1.Tag:=1;
    Button1.Caption:=TeeMsg_ClearImage;
    Image1.Picture.Assign(Image.Picture);
    BSave.Enabled:=True;
  end
  else
  begin
    Button1.Tag:=0;
    Button1.Caption:=TeeMsg_BrowseImage;
    Image1.Picture:=nil;
    BSave.Enabled:=False;
  end;
end;

procedure TChartImageToolEditor.FormShow(Sender: TObject);
begin
  inherited;
  Image:=TChartImageTool(Tag);

  if Assigned(Image) then
  begin
    CheckImageButton;
    BBorder.LinkPen(Image.Pen);
  end;
end;

procedure TChartImageToolEditor.FormCreate(Sender: TObject);
begin
  inherited;
  Align:=alClient;
end;

procedure TChartImageToolEditor.BSaveClick(Sender: TObject);
begin
  if Assigned(Image.Picture.Graphic) then
  with {$IFDEF CLX}TSaveDialog{$ELSE}TSavePictureDialog{$ENDIF}.Create(Self) do
  try
    Filter:=GraphicFilter(TGraphicClass(Image.Picture.Graphic.ClassType));
    if Execute then
       Image.Picture.Graphic.SaveToFile(FileName);
  finally
    Free;
  end;
end;

procedure TChartImageToolEditor.Button2Click(Sender: TObject);
begin
  ShowFiltersEditor(Self, Image.Picture);
end;

initialization
  RegisterClass(TChartImageToolEditor);
end.

