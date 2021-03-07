{**********************************************}
{   TeeChart PageNum Tool                      }
{   Copyright (c) 2000-2009 by David Berneda   }
{**********************************************}
unit TeePageNumTool;
{$I TeeDefs.inc}

// This unit implements a Chart Tool example:

{
   TPageNumTool

      This tool derives from Annotation tool.
      It is used to display the current chart page number.

      The Chart.Pages.MaxPointsPerPage property should be bigger than zero,
      to divide a chart in pages.

      Can be useful both for screen and print / print preview.

      This tool is automatically used by the Chart Editor dialog at
      "Paging" tab, when this unit is used in your application.
}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QStdCtrls, QComCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, StdCtrls, ComCtrls, ExtCtrls,
     {$ENDIF}
     TeCanvas, TeEngine, Chart, TeeTools, TeeAnnToolEdit,
     TeePenDlg, TeeEdiGrad;

type
  TPageNumTool=class(TAnnotationTool)
  private
    FButtonPen   : TChartPen;
    FButtons     : Boolean;
    FButtonWidth : Integer;
    FDisabledButton: TTeeGradient;
    FEnabledButton : TTeeGradient;
    FFormat        : String;

    function IsFormatStored: Boolean;
    procedure LeftTriangle(out Value:TTrianglePoints);
    procedure RightTriangle(out Value:TTrianglePoints);
    procedure SetButtons(Value:Boolean);
    procedure SetButtonWidth(Value:Integer);
    procedure SetDisabledButton(const Value: TTeeGradient);
    procedure SetEnabledButton(const Value: TTeeGradient);
    procedure SetFormat(const Value: String);
    procedure SetButtonPen(const Value: TChartPen);
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    Procedure DrawText; override;
    class Function GetEditorClass:String; override;
    Function GetText:String; override;
    Function GetTextBounds(out NumLines,x,y:Integer):TRect; override;
    function GetXOffset:Integer; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property ButtonPen:TChartPen read FButtonPen write SetButtonPen;
    property ButtonWidth:Integer read FButtonWidth write SetButtonWidth default 12;
    property DisabledButton:TTeeGradient read FDisabledButton write SetDisabledButton;
    property EnabledButton:TTeeGradient read FEnabledButton write SetEnabledButton;
    property Format:String read FFormat write SetFormat stored IsFormatStored;
    property ShowButtons:Boolean read FButtons write SetButtons default True;
  end;

  TPageNumToolEdit=class(TAnnotationToolEdit)
    TagPaging: TTabSheet;
    CBButtons: TCheckBox;
    Label16: TLabel;
    EWidth: TEdit;
    UDButtonWidth: TUpDown;
    BEnabled: TButtonGradient;
    BDisabled: TButtonGradient;
    BBorder: TButtonPen;
    Timer1: TTimer;
    procedure EWidthChange(Sender: TObject);
    procedure CBButtonsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  public
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
  SysUtils, TeeConst, TeeProcs, TeeProCo, Math;

{ TPageNumTool }
Constructor TPageNumTool.Create(AOwner: TComponent);
begin
  inherited;

  FFormat:=TeeMsg_PageOfPages;
  FButtonWidth:=12;
  FButtons:=True;

  FDisabledButton:=TTeeGradient.Create(CanvasChanged);
  FDisabledButton.Visible:=True;
  FDisabledButton.StartColor:=clWhite;
  FDisabledButton.EndColor:=clSilver;

  FEnabledButton:=TTeeGradient.Create(CanvasChanged);
  FEnabledButton.Visible:=True;
  FEnabledButton.StartColor:=clBlack;
  FEnabledButton.EndColor:=clSilver;

  FButtonPen:=CreateChartPen;
end;

Function TPageNumTool.GetText:String;
begin
  with TCustomChart(ParentChart).Pages do
       result:= SysUtils.Format(Format,[Current,Count]);
end;

class function TPageNumTool.Description: String;
begin
  result:=TeeMsg_PageNumber;
end;

function TPageNumTool.IsFormatStored: Boolean;
begin
  result:=FFormat<>TeeMsg_PageOfPages;
end;

class function TPageNumTool.LongDescription: String;
begin
  result:=TeeMsg_PageNumberDesc;
end;

procedure TPageNumTool.SetFormat(const Value: String);
begin
  SetStringProperty(FFormat,Value);
end;

function TPageNumTool.GetXOffset:Integer;
begin
  result:=inherited GetXOffset;

  if FButtons then
     if Shape.CustomPosition or
       (Position=ppLeftTop) or (Position=ppLeftBottom) then

        case TextAlignment of
          taRightJustify: Dec(result,ButtonWidth+2+2);
                taCenter: ;
        else
          Inc(result,ButtonWidth+2+2)
        end
     else
        case TextAlignment of
          taLeftJustify: Inc(result,ButtonWidth+2+2);
                taCenter: ;
        else
          Dec(result,ButtonWidth+2+2)
        end
end;

function TPageNumTool.GetTextBounds(out NumLines, x, y: Integer): TRect;
begin
  result:=inherited GetTextBounds(NumLines,x,y);

  if AutoSize and FButtons then
     if Shape.CustomPosition or
       (Position=ppLeftTop) or (Position=ppLeftBottom) then
        Inc(result.Right,2*ButtonWidth+2*4)
     else
        Dec(result.Left,2*ButtonWidth+2*4);

  x:=GetXOffset;

  Shape.ShapeBounds:=result;
end;

procedure TPageNumTool.DrawText;
var P : TTrianglePoints;
begin
  inherited;

  if FButtons then
  with ParentChart.Canvas do
  begin
    AssignVisiblePen(ButtonPen);

    LeftTriangle(P);
    if ParentChart.Pages.Current>1 then
       PolygonGradient(P,EnabledButton)
    else
       PolygonGradient(P,DisabledButton);

    RightTriangle(P);
    if ParentChart.Pages.Current<ParentChart.Pages.Count then
       PolygonGradient(P,EnabledButton)
    else
       PolygonGradient(P,DisabledButton);
  end;
end;

procedure TPageNumTool.LeftTriangle(out Value:TTrianglePoints);
var tmpX : Integer;
    tmpY : Integer;
begin
  with Shape.ShapeBounds do
  begin
    tmpY:=(Top+Bottom) div 2;
    tmpX:=Left+3;
  end;

  Value[0]:=TeePoint(tmpX,tmpY);
  Value[1]:=TeePoint(tmpX+ButtonWidth,Shape.ShapeBounds.Top+4);
  Value[2]:=TeePoint(tmpX+ButtonWidth,Shape.ShapeBounds.Bottom-4);
end;

procedure TPageNumTool.RightTriangle(out Value:TTrianglePoints);
var tmpX : Integer;
    tmpY : Integer;
begin
  with Shape.ShapeBounds do
  begin
    tmpY:=(Top+Bottom) div 2;
    tmpX:=Right-3-1;
  end;

  Value[0]:=TeePoint(tmpX,tmpY);
  Value[1]:=TeePoint(tmpX-ButtonWidth,Shape.ShapeBounds.Top+4);
  Value[2]:=TeePoint(tmpX-ButtonWidth,Shape.ShapeBounds.Bottom-4);
end;

procedure TPageNumTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var PLeft  : TTrianglePoints;
    PRight : TTrianglePoints;
    P      : TPoint;
begin
  if FButtons then
  begin
    P.X:=X;
    P.Y:=Y;

    if (AEvent=cmeDown) and (Button=mbLeft) then
    begin
      LeftTriangle(PLeft);

      if PointInPolygon(P,PLeft) then
      begin
        ParentChart.Pages.PreviousPage;
        Exit;
      end
      else
      begin
        RightTriangle(PRight);

        if PointInPolygon(P,PRight) then
        begin
          ParentChart.Pages.NextPage;
          Exit;
        end;
      end;
    end
    else
    if AEvent=cmeMove then
    begin
      LeftTriangle(PLeft);
      RightTriangle(PRight);

      if ((ParentChart.Pages.Current>1) and PointInPolygon(P,PLeft)) or
         ((ParentChart.Pages.Current<ParentChart.Pages.Count) and PointInPolygon(P,PRight)) then
      begin
        ParentChart.Cursor:=crHandPoint;
        ParentChart.CancelMouse:=True;
        Exit;
      end;
    end;
  end;

  inherited;
end;

procedure TPageNumTool.SetButtons(Value: Boolean);
begin
  SetBooleanProperty(FButtons,Value);
end;

procedure TPageNumTool.SetButtonWidth(Value:Integer);
begin
  SetIntegerProperty(FButtonWidth,Value);
end;

procedure TPageNumToolEdit.EWidthChange(Sender: TObject);
begin
  if Showing then
     TPageNumTool(Tool).ButtonWidth:=UDButtonWidth.Position;
end;

procedure TPageNumToolEdit.CBButtonsClick(Sender: TObject);
begin
  TPageNumTool(Tool).ShowButtons:=CBButtons.Checked;
end;

procedure TPageNumToolEdit.FormShow(Sender: TObject);
begin
  inherited;

  if Assigned(Tool) then
  with TPageNumTool(Tool) do
  begin
    CBButtons.Checked:=ShowButtons;
    UDButtonWidth.Position:=ButtonWidth;
    BBorder.LinkPen(ButtonPen);
    BEnabled.LinkGradient(EnabledButton);
    BDisabled.LinkGradient(DisabledButton);
  end;

  Timer1.Enabled:=True;
end;

class function TPageNumTool.GetEditorClass: String;
begin
  result:='TPageNumToolEdit';
end;

procedure TPageNumTool.SetDisabledButton(const Value: TTeeGradient);
begin
  FDisabledButton.Assign(Value);
end;

procedure TPageNumTool.SetEnabledButton(const Value: TTeeGradient);
begin
  FEnabledButton.Assign(Value);
end;

Destructor TPageNumTool.Destroy;
begin
  FButtonPen.Free;
  FEnabledButton.Free;
  FDisabledButton.Free;
  inherited;
end;

procedure TPageNumTool.SetButtonPen(const Value: TChartPen);
begin
  FButtonPen.Assign(Value);
end;

procedure TPageNumTool.Assign(Source: TPersistent);
begin
  if Source is TPageNumTool then
  with TPageNumTool(Source) do
  begin
    Self.FButtonWidth:=FButtonWidth;
    Self.ButtonPen:=ButtonPen;
    Self.EnabledButton:=EnabledButton;
    Self.DisabledButton:=DisabledButton;
    Self.Format:=Format;
    Self.FButtons:=FButtons;
  end;

  inherited;
end;

procedure TPageNumToolEdit.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;
  PageControl1.ActivePage:=TagPaging;
end;

initialization
  RegisterClass(TPageNumToolEdit);

  RegisterTeeTools([TPageNumTool]);
  TeePageNumToolClass:=TPageNumTool;
finalization
  TeePageNumToolClass:=nil;
  UnRegisterTeeTools([TPageNumTool]);
end.
