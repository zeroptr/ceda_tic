{**********************************************}
{   TContourSeries Editor Dialog               }
{   Copyright (c) 1996-2009 by David Berneda   }
{**********************************************}
unit TeeContourEdit;
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
     Chart, TeeSurfa, TeCanvas, TeePenDlg, TeeProcs;

type
  TContourSeriesEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CBAutoLevels: TCheckBox;
    Label4: TLabel;
    SENum: TEdit;
    UDNum: TUpDown;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    SHColor: TShape;
    Label3: TLabel;
    ELevel: TEdit;
    UDLevel: TUpDown;
    EValue: TEdit;
    BLevelPen: TButtonPen;
    cbDefaultPen: TCheckBox;
    Button2: TButtonPen;
    CBColorEach: TCheckBox;
    CBSmooth: TCheckBox;
    CBInterpolate: TCheckBox;
    CBFill: TCheckBox;
    TabSheet3: TTabSheet;
    CBMarksSegments: TCheckBox;
    CBMarksColor: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    BMarksColor: TButtonColor;
    Edit1: TEdit;
    Edit2: TEdit;
    UDDensity: TUpDown;
    UDMargin: TUpDown;
    CBMarks: TCheckBox;
    Label7: TLabel;
    Edit3: TEdit;
    UDTransp: TUpDown;
    TabPointer: TTabSheet;
    CBEmpty: TCheckBox;
    SBLevel: TScrollBar;
    BFrame: TButtonPen;
    TabSheet4: TTabSheet;
    Label2: TLabel;
    SEYPos: TEdit;
    CBYPosLevel: TCheckBox;
    CBBottom: TCheckBox;
    CBOverlap: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure SENumChange(Sender: TObject);
    procedure CBYPosLevelClick(Sender: TObject);
    procedure SEYPosChange(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure CBAutoLevelsClick(Sender: TObject);
    procedure SHColorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ELevelChange(Sender: TObject);
    procedure EValueChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BLevelPenClick(Sender: TObject);
    procedure cbDefaultPenClick(Sender: TObject);
    procedure CBSmoothClick(Sender: TObject);
    procedure CBInterpolateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBFillClick(Sender: TObject);
    procedure CBMarksColorClick(Sender: TObject);
    procedure CBMarksSegmentsClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure CBMarksClick(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure CBEmptyClick(Sender: TObject);
    procedure SBLevelChange(Sender: TObject);
    procedure CBBottomClick(Sender: TObject);
    procedure CBOverlapClick(Sender: TObject);
  private
    { Private declarations }
    Contour : TContourSeries;
    CreatingForm : Boolean;
    Grid3DForm : TCustomForm;

    procedure CheckBottom;
    procedure DoCreateAutoLevels;
    function Level:TContourLevel;
    procedure SetLevel;
    function VisualColor:TColor;
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
  TeEngine, TeePoEdi, TeeGriEd;

procedure TContourSeriesEditor.FormShow(Sender: TObject);
var tmpPointer : TSeriesPointerEditor;
begin
  Contour:=TContourSeries(Tag);

  if Assigned(Contour) then
  begin

    With Contour do
    begin
      CBColorEach.Checked :=ColorEachPoint;
      CBYPosLevel.Checked :=YPositionLevel;
      SEYPos.Enabled      :=not YPositionLevel;
      SEYPos.Text         :=FloatToStr(YPosition);

      CheckBottom;

      CBAutoLevels.Checked:=AutomaticLevels;
      UDNum.Position      :=NumLevels;

      UDLevel.Max         :=NumLevels-1;
      SBLevel.Max         :=UDLevel.Max;

      CBSmooth.Checked    :=Smoothing.Active;
      CBInterpolate.Checked:=Smoothing.Interpolate;
      CBInterpolate.Enabled:=Smoothing.Active;
      CBFill.Checked      :=Brush.Style<>bsClear;

      Button2.LinkPen(Pen);
      BFrame.LinkPen(Frame);

      with ContourMarks do
      begin
        CBMarks.Checked:=Visible;
        CBMarksSegments.Checked:=AtSegments;
        CBMarksColor.Checked:=ColorLevel;
        UDDensity.Position:=Density;
        UDMargin.Position:=Margin;
        CBOverlap.Checked:=AntiOverlap;
      end;

      UDTransp.Position:=Transparency;

      BMarksColor.LinkProperty(Contour.Marks.Font,'Color'); // Do not localize
      BMarksColor.Enabled:=not ContourMarks.ColorLevel;

      EnableControls(AutomaticLevels,[SENum,UDNum,CBColorEach]);

      tmpPointer:=TSeriesPointerEditor.Create(nil);
      AddFormTo(tmpPointer,TabPointer,Pointer);
    end;

    if not Assigned(Grid3DForm) then
       Grid3DForm:=TeeInsertGrid3DForm(Parent,Contour);

    SetLevel;
  end;

  CreatingForm:=False;
end;

function TContourSeriesEditor.Level:TContourLevel;
begin
  result:=Contour.Levels[UDLevel.Position];
end;

procedure TContourSeriesEditor.SetLevel;
var OldCreating : Boolean;
    tmp         : TColor;
    tmpOk       : Boolean;
begin
  OldCreating:=CreatingForm;
  CreatingForm:=True;

  tmpOk:=Contour.Levels.Count>UDLevel.Position;

  EnableControls(tmpOk, [ELevel, UDLevel, EValue, BLevelPen,
                         cbDefaultPen, SHColor, SBLevel]);

  if tmpOk then
  With Level do
  begin
    tmp:=VisualColor;
    SHColor.Brush.Color:=tmp;
    CBEmpty.Checked:=tmp=clNone;

    EValue.Text:=FormatFloat('0.###',UpToValue); // Do not localize

    cbDefaultPen.Checked:=DefaultPen;
    BLevelPen.Enabled:=not DefaultPen;

    if BLevelPen.Enabled then BLevelPen.LinkPen(Pen)
                         else BLevelPen.LinkPen(nil);

    SBLevel.Position:=UDLevel.Position;
  end
  else BLevelPen.LinkPen(nil);

  CreatingForm:=OldCreating;
end;

procedure TContourSeriesEditor.DoCreateAutoLevels;
begin
  if Contour.AutomaticLevels then
     Contour.CreateAutoLevels;
end;

procedure TContourSeriesEditor.SENumChange(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Contour.NumLevels:=UDNum.Position;
    DoCreateAutoLevels;

    With UDLevel do
    begin
      Max:=Contour.NumLevels-1;
      SBLevel.Max:=Max;
      ELevel.Text:=TeeStr(Position);
      SetLevel;
    end;
  end;
end;

procedure TContourSeriesEditor.CBYPosLevelClick(Sender: TObject);
begin
  Contour.YPositionLevel:=CBYPosLevel.Checked;
  SEYPos.Enabled:=not CBYPosLevel.Checked;
end;

procedure TContourSeriesEditor.SEYPosChange(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Contour.YPosition:=StrToFloatDef(SEYPos.Text,Contour.YPosition);
    CheckBottom;
  end;
end;

procedure TContourSeriesEditor.CheckBottom;
begin
  CBBottom.Checked:=Contour.YPosition=Contour.MinYValue;
  CBBottom.Enabled:=not CBBottom.Checked;
end;

procedure TContourSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Contour.ColorEachPoint:=CBColorEach.Checked;
    Contour.CreateAutoLevels;
    SetLevel;
  end;
end;

procedure TContourSeriesEditor.CBAutoLevelsClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Contour.AutomaticLevels:=CBAutoLevels.Checked;
    DoCreateAutoLevels;
    EnableControls(Contour.AutomaticLevels,[SENum,UDNum,CBColorEach]);
    SetLevel;
  end;
end;

procedure TContourSeriesEditor.SHColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp : TColor;
begin
  if SHColor.Enabled then
  With Level do
  begin
    tmp:=Color;

    if EditColorDialog(Self,tmp) then
    begin
      SHColor.Brush.Color:=tmp;
      Color:=tmp;

      if not DefaultPen then
      begin
        Pen.Color:=Color;
        bLevelPen.Invalidate;
      end;

      CBEmpty.Checked:=Color=clNone;
    end;
  end;

  CBAutoLevels.Checked:=Contour.AutomaticLevels;
end;

procedure TContourSeriesEditor.ELevelChange(Sender: TObject);
begin
  if not CreatingForm and (Contour.Levels.Count>0) then
     SetLevel;
end;

procedure TContourSeriesEditor.EValueChange(Sender: TObject);
begin
  if not CreatingForm then
  if EValue.Enabled then 
  begin
    Level.UpToValue:=StrToFloat(EValue.Text);
    CBAutoLevels.Checked:=Contour.AutomaticLevels;
  end;
end;

procedure TContourSeriesEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  BorderStyle:=TeeBorderStyle;
end;

procedure TContourSeriesEditor.BLevelPenClick(Sender: TObject);
begin
  if BLevelPen.Enabled then
  with Level do
  begin
    cbDefaultPen.Checked:=DefaultPen;
    Color:=Pen.Color;
    SHColor.Brush.Color:=Color;
  end;
end;

procedure TContourSeriesEditor.cbDefaultPenClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    BLevelPen.Enabled:=not cbDefaultPen.Checked;

    if cbDefaultPen.Checked then
    begin
      Level.Pen:=nil;
      BLevelPen.LinkPen(nil);
    end
    else
      BLevelPen.LinkPen(Level.Pen);
  end;
end;

procedure TContourSeriesEditor.CBSmoothClick(Sender: TObject);
begin
  Contour.Smoothing.Active:=CBSmooth.Checked;
  CBInterpolate.Enabled:=CBSmooth.Checked;
end;

procedure TContourSeriesEditor.CBInterpolateClick(Sender: TObject);
begin
  Contour.Smoothing.Interpolate:=CBInterpolate.Checked;
end;

procedure TContourSeriesEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Grid3DForm);
end;

procedure TContourSeriesEditor.CBFillClick(Sender: TObject);
begin
  if CBFill.Checked then
     Contour.Brush.Style:=bsSolid
  else
     Contour.Brush.Style:=bsClear;

  Contour.Brush.Image:=nil;
end;

procedure TContourSeriesEditor.CBMarksColorClick(Sender: TObject);
begin
  Contour.ContourMarks.ColorLevel:=CBMarksColor.Checked;
  BMarksColor.Enabled:=not Contour.ContourMarks.ColorLevel;
end;

procedure TContourSeriesEditor.CBMarksSegmentsClick(Sender: TObject);
begin
  Contour.ContourMarks.AtSegments:=CBMarksSegments.Checked;
end;

procedure TContourSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Assigned(Contour) then
     Contour.ContourMarks.Density:=UDDensity.Position;
end;

procedure TContourSeriesEditor.Edit2Change(Sender: TObject);
begin
  if Assigned(Contour) then
     Contour.ContourMarks.Margin:=UDMargin.Position;
end;

procedure TContourSeriesEditor.CBMarksClick(Sender: TObject);
begin
  Contour.Marks.Visible:=CBMarks.Checked;
end;

procedure TContourSeriesEditor.Edit3Change(Sender: TObject);
begin
  if Showing then
     Contour.Transparency:=UDTransp.Position;
end;

function TContourSeriesEditor.VisualColor:TColor;
begin
 result:=Level.Color;

 if result=clTeeColor then
    if Assigned(Contour.ParentChart) then
       result:=Contour.ParentChart.GetDefaultColor(UDLevel.Position) // 7.04
    else
       result:=clWhite;
end;

procedure TContourSeriesEditor.CBEmptyClick(Sender: TObject);
begin
  if CBEmpty.Checked then
     Level.Color:=clNone
  else
  if Level.Color=clNone then
     Level.Color:=clTeeColor;

  SHColor.Brush.Color:=VisualColor;
  Level.Pen.Color:=Level.Color;
  BLevelPen.Invalidate;
end;

procedure TContourSeriesEditor.SBLevelChange(Sender: TObject);
begin
  UDLevel.Position:=SBLevel.Position;
end;

procedure TContourSeriesEditor.CBBottomClick(Sender: TObject);
begin
  Contour.YPosition:=Contour.MinYValue;
  CBBottom.Enabled:=False;
end;

procedure TContourSeriesEditor.CBOverlapClick(Sender: TObject);
begin
  Contour.ContourMarks.AntiOverlap:=CBOverlap.Checked;
end;

initialization
  RegisterClass(TContourSeriesEditor);
end.
