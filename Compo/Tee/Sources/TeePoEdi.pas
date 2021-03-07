{**********************************************}
{   TSeriesPointer Component Editor Dialog     }
{   Copyright (c) 1996-2009 by David Berneda   }
{**********************************************}
unit TeePoEdi;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     Types, Qt,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     Buttons,
     {$ENDIF}
     TeeProcs, Chart, TeEngine, TeCanvas, Series, TeePenDlg;

type
  TSeriesPointerEditor = class(TForm)
    GPPoint: TGroupBox;
    CBDrawPoint: TCheckBox;
    CB3dPoint: TCheckBox;
    CBInflate: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    SEPointHorizSize: TEdit;
    SEPointVertSize: TEdit;
    CBStyle: TComboFlat;
    Label3: TLabel;
    UDPointHorizSize: TUpDown;
    UDPointVertSize: TUpDown;
    CBPoDark: TCheckBox;
    GroupBox1: TGroupBox;
    BPointFillColor: TButton;
    CBDefBrushColor: TCheckBox;
    CBColorEach: TCheckBox;
    BGradient: TButton;
    BPoinPenCol: TButtonPen;
    PanelBottom: TPanel;
    Button1: TButton;
    CBIgnoreNulls: TCheckBox;
    Button2: TButton;
    LTransp: TLabel;
    TBTransp: TTrackBar;
    procedure FormShow(Sender: TObject);
    procedure CBDrawPointClick(Sender: TObject);
    procedure CB3dPointClick(Sender: TObject);
    procedure SEPointHorizSizeChange(Sender: TObject);
    procedure BPointFillColorClick(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure SEPointVertSizeChange(Sender: TObject);
    procedure CBInflateClick(Sender: TObject);
    procedure CBPoDarkClick(Sender: TObject);
    procedure CBDefBrushColorClick(Sender: TObject);
    {$IFNDEF CLX}
    procedure CBStyleDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    {$ELSE}
    procedure CBStyleDrawItem(Sender:TObject; Index: Integer;
      Rect: TRect; State: TOwnerDrawState; Var Handled:Boolean);
    {$ENDIF}
    procedure CBColorEachClick(Sender: TObject);
    procedure BPoinPenColClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BGradientClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBIgnoreNullsClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TBTranspChange(Sender: TObject);
  private
    { Private declarations }

    Procedure CheckDefColor;
    function CustomSeries:TCustomSeries;
    Procedure Enable3DPoint;
    procedure SetPointerVisible(Value:Boolean);
  protected
    ThePointer : TSeriesPointer;
  public
    { Public declarations }

    procedure HideSizeOptions;
  end;

// Modally show the Pointer editor dialog
function EditSeriesPointer(AOwner:TComponent; APointer:TSeriesPointer):Boolean;

{ Adds a new sub-tab Form into the Series tab at EditChart dialog }
Function TeeInsertPointerForm( AParent:TControl;
                               APointer:TSeriesPointer;
                               Const Title:String):TCustomForm;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses {$IFNDEF CLR}
     TypInfo,
     {$ELSE}
     Variants,
     {$ENDIF}
     TeeBrushDlg, TeeConst, TeeEdiSeri, TeeEdiGrad, TeeShadowEditor;

function EditSeriesPointer(AOwner:TComponent; APointer:TSeriesPointer):Boolean;
var tmp : TSeriesPointerEditor;
begin
  tmp:=TSeriesPointerEditor(TeeCreateForm(TSeriesPointerEditor,AOwner));

  with tmp do
  try
    PositionToCenter(tmp);
    Caption:='Pointer'; // <-- do not translate
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(APointer);
    CBInflate.Hide;
    CBColorEach.Hide;
    PanelBottom.Visible:=True;

    TeeTranslateControl(tmp);
    ShowModal;

    result:=True;
  finally
    Free;
  end;
end;

Function TeeInsertPointerForm( AParent:TControl;
                               APointer:TSeriesPointer;
                               Const Title:String):TCustomForm;

begin
  result:=TFormTeeSeries.InsertSeriesForm(AParent,TSeriesPointerEditor,1,Title,APointer);
end;

Procedure TSeriesPointerEditor.Enable3DPoint;
begin
  With ThePointer do
  CB3DPoint.Enabled:= Assigned(ParentChart) and
                      ParentChart.View3D and
                      ( (Style=psRectangle) or
                        (Style=psTriangle) or
                        (Style=psDownTriangle) or
                        (ParentChart.Canvas.SupportsFullRotation
                         and (Style=psCircle))
                      );

  CBPoDark.Enabled:=CB3DPoint.Enabled and CB3DPoint.Checked;
end;


type TPointerAccess=class(TSeriesPointer);

procedure TSeriesPointerEditor.FormShow(Sender: TObject);
begin
  if Tag<>{$IFDEF CLR}nil{$ELSE}0{$ENDIF} then
  begin
    if TPersistent({$IFDEF CLR}TObject{$ENDIF}(Tag)) is TSeriesPointer then
    begin
      ThePointer:=TSeriesPointer({$IFDEF CLR}TObject{$ENDIF}(Tag));

      CBColorEach.Enabled:=False;
      CBColorEach.Visible:=False;

      CBIgnoreNulls.Enabled:=False;
      CBIgnoreNulls.Visible:=False;
    end
    else
    begin
      ThePointer:=CustomSeries.Pointer;
      CBColorEach.Visible:=True;
      CBColorEach.Checked:=CustomSeries.ColorEachPoint;

      CBIgnoreNulls.Visible:=True;
      CBIgnoreNulls.Checked:= CustomSeries.TreatNulls=tnIgnore;
    end;

    With ThePointer do
    Begin
      SetPointerVisible(Visible);
      CBDrawPoint.Checked:=Visible;
      CB3DPoint.Checked:=Draw3D;
      Enable3DPoint;
      UDPointHorizSize.Position:=HorizSize;
      UDPointVertSize.Position :=VertSize;
      CBStyle.ItemIndex:=Ord(Style);
      CBInflate.Checked:=InflateMargins;
      CBPoDark.Checked:=Dark3D;
      CheckDefColor;
      BPoinPenCol.LinkPen(Pen);
      TBTransp.Position:=Transparency;

      if not TPointerAccess(ThePointer).AllowChangeSize then
         ShowControls(False,[ Label1,Label2,SEPointHorizSize,
                              SEPointVertSize,UDPointHorizSize,UDPointVertSize]);
    end;
  end;
  TeeTranslateControl(Self);
end;

Procedure TSeriesPointerEditor.CheckDefColor;
begin
  with ThePointer do
       CBDefBrushColor.Checked:=(Color=clTeeColor) and (Pen.Color=clTeeColor);
end;

procedure TSeriesPointerEditor.SetPointerVisible(Value:Boolean);
begin
  ThePointer.Visible:=Value;

  if Value then Enable3DPoint
  else
  begin
    CB3DPoint.Enabled:=False;
    CBPoDark.Enabled:=False;
  end;

  EnableControls(Value,[ CBInflate,SEPointHorizSize,SEPointVertSize,
                         UDPointHorizSize,UDPointVertSize,BPointFillColor,
                         CBStyle,BPoinPenCol,CBDefBrushColor] );
end;

procedure TSeriesPointerEditor.CBDrawPointClick(Sender: TObject);
begin
  SetPointerVisible(CBDrawPoint.Checked);
end;

procedure TSeriesPointerEditor.CB3dPointClick(Sender: TObject);
begin
  ThePointer.Draw3D:=CB3DPoint.Checked;
  CBPoDark.Enabled:=CB3DPoint.Checked;
end;

procedure TSeriesPointerEditor.SEPointHorizSizeChange(Sender: TObject);
begin
  if Showing then
     ThePointer.HorizSize:=UDPointHorizSize.Position;
end;

procedure TSeriesPointerEditor.BPointFillColorClick(Sender: TObject);
begin
  EditChartBrush(Self,ThePointer.Brush);
  CheckDefColor;
  CBStyle.Repaint;
end;

procedure TSeriesPointerEditor.CBStyleChange(Sender: TObject);
begin
  ThePointer.Style:=TSeriesPointerStyle(CBStyle.ItemIndex);
  Enable3DPoint;
end;

procedure TSeriesPointerEditor.SEPointVertSizeChange(Sender: TObject);
begin
  if Showing then
     ThePointer.VertSize:=UDPointVertSize.Position;
end;

procedure TSeriesPointerEditor.CBInflateClick(Sender: TObject);
begin
  ThePointer.InflateMargins:=CBInflate.Checked;
end;

procedure TSeriesPointerEditor.CBPoDarkClick(Sender: TObject);
begin
  ThePointer.Dark3D:=CBPoDark.Checked;
end;

procedure TSeriesPointerEditor.CBDefBrushColorClick(Sender: TObject);
begin
  if CBDefBrushColor.Checked then
  begin
    ThePointer.Color:=clTeeColor;
    ThePointer.Pen.Color:=clTeeColor;
  end
  else
  if ThePointer.Pen.Color=clTeeColor then
     ThePointer.Pen.Color:=clBlack;

  BPoinPenCol.Invalidate;
  CBStyle.Repaint;
end;

{$IFNDEF CLX}
procedure TSeriesPointerEditor.CBStyleDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ELSE}
procedure TSeriesPointerEditor.CBStyleDrawItem(Sender:TObject; Index: Integer;
      Rect: TRect; State: TOwnerDrawState; Var Handled:Boolean);
{$ENDIF}
var tmp : TColor;
    Old : TColor;
    ACanvas: TTeeCanvas3D;
{$IFDEF CLX}
Var QC : QColorH;
{$ENDIF}
begin
  Old:=CBStyle.Canvas.Brush.Color;
  {$IFNDEF CLX}
  // background
  CBStyle.Canvas.FillRect(Rect);
  {$ENDIF}

  // pointer shape
  With {$IFNDEF CLR}TPointerAccess{$ENDIF}(ThePointer) do
  begin
    ACanvas:=TTeeCanvas3D.Create;
    try
      ACanvas.ReferenceCanvas:=CBStyle.Canvas;

      tmp:=Brush.Color;
      if (tmp=clTeeColor) and Assigned(ParentSeries) then
         tmp:=ParentSeries.SeriesColor;

      PrepareCanvas(ACanvas,tmp);

      case TSeriesPointerStyle(Index) of
        psCross,
        psDiagCross,
        psStar,
        psSmallDot:
            if not Pen.Visible then
            with ACanvas.Pen do
            begin
              Style:=psSolid;
              Width:=1;
              Color:=tmp;
            end;
      end;

      DrawPointer(ACanvas,False,Rect.Left+6,Rect.Top+6+2,4,4,tmp,TSeriesPointerStyle(Index));
    finally
      ACanvas.Free;
    end;
  end;

  // text
  With CBStyle,Canvas do
  begin
    {$IFNDEF CLX}
    Brush.Style:=bsClear;
    {$ENDIF}

    Brush.Color:=Old;

    {$IFNDEF CLX}
    {$IFNDEF LCL}
    TControlCanvas(CBStyle.Canvas).UpdateTextFlags;
    {$ENDIF}
    {$ELSE}
    QC:=QColor(Old);
    Start(True);
    QPainter_setBackgroundColor(Handle,QC);
    Stop;
    QColor_destroy(QC);
    {$ENDIF}

    TextOut(Rect.Left+14,Rect.Top+2,Items[Index]);
  end;
end;

function TSeriesPointerEditor.CustomSeries:TCustomSeries;
begin
  result:=TCustomSeries({$IFDEF CLR}TObject{$ENDIF}(Tag));
end;

procedure TSeriesPointerEditor.CBColorEachClick(Sender: TObject);
begin
  CustomSeries.ColorEachPoint:=CBColorEach.Checked;
end;

procedure TSeriesPointerEditor.BPoinPenColClick(Sender: TObject);
begin
  CheckDefColor;
  CBStyle.Repaint;
end;

procedure TSeriesPointerEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

procedure TSeriesPointerEditor.BGradientClick(Sender: TObject);
begin
  EditTeeGradient(Self,ThePointer.Gradient,
                  not TPointerAccess(ThePointer).FullGradient,False)
end;

procedure TSeriesPointerEditor.HideSizeOptions;
begin
  Label1.Visible:=False;
  SEPointHorizSize.Visible:=False;
  UDPointHorizSize.Visible:=False;
  Label2.Visible:=False;
  SEPointVertSize.Visible:=False;
  UDPointVertSize.Visible:=False;
end;

procedure TSeriesPointerEditor.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TSeriesPointerEditor.CBIgnoreNullsClick(Sender: TObject);
begin
  if CBIgnoreNulls.Checked then
     CustomSeries.TreatNulls:=tnIgnore
  else
     CustomSeries.TreatNulls:=tnDontPaint;
end;

procedure TSeriesPointerEditor.Button2Click(Sender: TObject);
begin
  EditTeeShadow(Self,ThePointer.Shadow)
end;

procedure TSeriesPointerEditor.TBTranspChange(Sender: TObject);
begin
  ThePointer.Transparency:=TBTransp.Position;
end;

initialization
  RegisterClass(TSeriesPointerEditor);
end.
