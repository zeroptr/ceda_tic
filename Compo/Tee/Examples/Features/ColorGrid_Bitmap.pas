unit ColorGrid_Bitmap;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  {$ENDIF}
  SysUtils, Classes, Base, TeCanvas, TeePenDlg, TeEngine, TeeSurfa, 
  {$IFNDEF CLX}
  {$IFNDEF CLR}
  jpeg,
  {$ENDIF}
  {$ENDIF}
  TeeProcs, Chart, TeeOpenGL;

type
  TColorGridBitmap = class(TBaseForm)
    Series1: TColorGridSeries;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    ButtonPen1: TButtonPen;
    ComboFlat1: TComboFlat;
    TeeOpenGL1: TTeeOpenGL;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboFlat1Change(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetFlower;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TColorGridBitmap.FormCreate(Sender: TObject);
begin
  inherited;
  ComboFlat1.ItemIndex:=0;

  SetFlower;

  ButtonPen1.LinkPen(Series1.Pen);
end;

procedure TColorGridBitmap.Button1Click(Sender: TObject);
begin
  Chart1.ZoomPercent(105);
end;

procedure TColorGridBitmap.Button2Click(Sender: TObject);
begin
  Chart1.ZoomPercent(95);
end;

procedure TColorGridBitmap.CheckBox1Click(Sender: TObject);
begin
end;

// set "flower" bitmap to color grid series...
procedure TColorGridBitmap.SetFlower;
var tmp : TBitmap;
begin
  // temporary bitmap:
  tmp:=TBitmap.Create;
  try
    tmp.Assign(Image1.Picture.Graphic);
    Series1.Bitmap:=tmp;
  finally
    tmp.Free;
  end;
end;

procedure TColorGridBitmap.ComboFlat1Change(Sender: TObject);
var t: Integer;
begin
  if ComboFlat1.ItemIndex=0 then SetFlower
  else
  begin
    // reset colors to "default" colors
    for t:=0 to Series1.Count-1 do Series1.ValueColor[t]:=clTeeColor;

    if ComboFlat1.ItemIndex=1 then
    begin
      Series1.UseColorRange:=True;
      Series1.UsePalette:=False;
    end
    else
    begin
      Series1.UseColorRange:=False;
      Series1.UsePalette:=True;
    end;
  end;
end;

procedure TColorGridBitmap.Memo1DblClick(Sender: TObject);
begin
  // protection just to avoid problems if user changes Series1
  ButtonPen1.LinkPen(nil);
  inherited;
  ButtonPen1.LinkPen(Series1.Pen);
end;

initialization
  RegisterClass(TColorGridBitmap);
end.
