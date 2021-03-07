{**********************************************}
{   TImageBarSeries Component Editor Dialog    }
{   Copyright (c) 1996-2009 by David Berneda   }
{**********************************************}
unit TeeImaEd;
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
     Chart, Series, TeeProcs, ImageBar;

type
  TImageBarSeriesEditor = class(TForm)
    GroupBox1: TGroupBox;
    Image1: TImage;
    BBrowse: TButton;
    CBTiled: TCheckBox;
    Bevel1: TBevel;
    Button1: TButton;
    CBTransp: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BBrowseClick(Sender: TObject);
    procedure CBTiledClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBTranspClick(Sender: TObject);
  private
    { Private declarations }
    ImageBarSeries : TImageBarSeries;
    FBarForm : TCustomForm;
    
    procedure EnableImageControls;
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

uses
  {$IFNDEF CLX}
  ExtDlgs,
  {$ENDIF}
  TeCanvas,
  TeePenDlg, TeeBrushDlg, TeeConst, TeeBarEdit, TeeEdiSeri, TeeEdiPane,
  TeeFiltersEditor;

procedure TImageBarSeriesEditor.FormShow(Sender: TObject);
begin
  ImageBarSeries:=TImageBarSeries(Tag);

  if Assigned(ImageBarSeries) then
  begin
    With ImageBarSeries do
    begin
      CBTiled.Checked:=ImageTiled;
      CBTransp.Checked:=ImageTransparent;

      Image1.Picture.Assign(Image);
    end;

    if not Assigned(FBarForm) then
       FBarForm:=TFormTeeSeries.InsertSeriesForm( Parent,TBarSeriesEditor,
                                                  1,TeeMsg_GalleryBar,
                                                  ImageBarSeries);

    with FBarForm as TBarSeriesEditor do
    begin
      LStyle.Visible:=False;
      CBBarStyle.Visible:=False;
    end;

    EnableImageControls;
  end;
end;

procedure TImageBarSeriesEditor.EnableImageControls;
begin
  CBTiled.Enabled:=Assigned(ImageBarSeries.Image.Graphic);

  if CBTiled.Enabled then BBrowse.Caption:=TeeMsg_ClearImage
                     else BBrowse.Caption:=TeeMsg_BrowseImage;

  Image1.Picture.Assign(ImageBarSeries.Image);
end;

procedure TImageBarSeriesEditor.BBrowseClick(Sender: TObject);
begin
  TeeLoadClearImage(Self,ImageBarSeries.Image);
  EnableImageControls;
end;

procedure TImageBarSeriesEditor.CBTiledClick(Sender: TObject);
begin
  ImageBarSeries.ImageTiled:=CBTiled.Checked;
end;

procedure TImageBarSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
  {$IFDEF D6}
  Image1.HelpContext:=1934;
  {$ENDIF}
end;

procedure TImageBarSeriesEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FBarForm);
end;

procedure TImageBarSeriesEditor.Button1Click(Sender: TObject);
begin
  ShowFiltersEditor(Self, ImageBarSeries.Image);
end;

procedure TImageBarSeriesEditor.CBTranspClick(Sender: TObject);
begin
  ImageBarSeries.ImageTransparent:=CBTransp.Checked;
end;

initialization
  RegisterClass(TImageBarSeriesEditor);
end.
