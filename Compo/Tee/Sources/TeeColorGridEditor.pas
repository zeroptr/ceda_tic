{**********************************************}
{   TColorGridSeries Editor dialog             }
{   Copyright (c) 2000-2009 by David Berneda   }
{**********************************************}
unit TeeColorGridEditor;
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
     {$IFNDEF CLX}
     ExtDlgs,
     {$ENDIF}
     TeeGriEd, TeCanvas, TeePenDlg, TeeSurfa;

type
  TColorGridEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    CBSmooth: TCheckBox;
    ButtonPen1: TButtonPen;
    BGrid: TButtonPen;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label1: TLabel;
    Edit2: TEdit;
    UDX: TUpDown;
    Edit1: TEdit;
    UDZ: TUpDown;
    Label3: TLabel;
    Edit4: TEdit;
    UDPosition: TUpDown;
    CBPlane: TComboFlat;
    CBCentered: TCheckBox;
    Button2: TButton;
    Label2: TLabel;
    Edit3: TEdit;
    UDTransp: TUpDown;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBCenteredClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CBSmoothClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure CBPlaneChange(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
  private
    { Private declarations }
    Creating   : Boolean;
    ColorGrid  : TColorGridSeries;
    Grid3DForm : TGrid3DSeriesEditor;
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
  TeeBrushDlg, TeEngine;

procedure TColorGridEditor.FormShow(Sender: TObject);
begin
  if Tag<>{$IFDEF CLR}nil{$ELSE}0{$ENDIF} then
     ColorGrid:=TColorGridSeries(Tag);

  if Assigned(ColorGrid) then
  begin
    with ColorGrid do
    begin
      BGrid.LinkPen(Pen);
      CBCentered.Checked:=CenteredPoints;
      UDX.Position:=XGridEvery;
      UDZ.Position:=ZGridEvery;
      CBSmooth.Checked:=SmoothBitmap;
      UDTransp.Position:=Transparency;
      CBPlane.ItemIndex:=Ord(DrawPlane3D);
      UDPosition.Position:=DrawPosition;
      
      ButtonPen1.LinkPen(Frame);

      Creating:=False;
    end;

    if not Assigned(Grid3DForm) then
       Grid3DForm:=TGrid3DSeriesEditor(TeeInsertGrid3DForm(Parent,ColorGrid));
  end;
end;

procedure TColorGridEditor.FormCreate(Sender: TObject);
begin
  Creating:=True;
  Align:=alClient;
end;

procedure TColorGridEditor.CBCenteredClick(Sender: TObject);
begin
  ColorGrid.CenteredPoints:=CBCentered.Checked;
end;

procedure TColorGridEditor.Button2Click(Sender: TObject);
var tmpSt : String;
    tmp   : TPicture;
begin
  tmpSt:=TeeGetPictureFileName(Self);

  if tmpSt<>'' then
  begin
    tmp:=TPicture.Create;
    try
      tmp.LoadFromFile(tmpSt);
      ColorGrid.Bitmap:=tmp.Bitmap;
      Grid3DForm.BRemove.Enabled:=HasColors(ColorGrid);
    finally
      tmp.Free;
    end;
  end;
end;

procedure TColorGridEditor.CBSmoothClick(Sender: TObject);
begin
  ColorGrid.SmoothBitmap:=CBSmooth.Checked;
end;

procedure TColorGridEditor.Edit2Change(Sender: TObject);
begin
  if not Creating then
     ColorGrid.XGridEvery:=UDX.Position;
end;

procedure TColorGridEditor.Edit1Change(Sender: TObject);
begin
  if not Creating then
     ColorGrid.ZGridEvery:=UDZ.Position;
end;

procedure TColorGridEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Grid3DForm);
end;

procedure TColorGridEditor.Edit3Change(Sender: TObject);
begin
  if Showing then
     ColorGrid.Transparency:=UDTransp.Position;
end;

procedure TColorGridEditor.CBPlaneChange(Sender: TObject);
begin
  ColorGrid.DrawPlane3D:=TCanvas3DPlane(CBPlane.ItemIndex);
end;

procedure TColorGridEditor.Edit4Change(Sender: TObject);
begin
  if Showing and Assigned(ColorGrid) then
     ColorGrid.DrawPosition:=UDPosition.Position;
end;

initialization
  RegisterClass(TColorGridEditor);
end.
