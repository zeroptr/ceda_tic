{**********************************************}
{   TeeChart Annotation Tool Editor            }
{   Copyright (c) 2000-2009 by David Berneda   }
{**********************************************}
unit TeeAnnToolEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, Buttons,
     {$ENDIF}
     TeeProcs, TeeTools, TeCanvas, TeeCustomShapeEditor, TeePenDlg, TeeMargins;

type
  TAnnotationToolEdit = class(TForm)
    PageControl1: TPageControl;
    TabText: TTabSheet;
    Label1: TLabel;
    MemoText: TMemo;
    TabPosition: TTabSheet;
    Label2: TLabel;
    CBPos: TComboFlat;
    CBCustPos: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    ECustLeft: TEdit;
    UDLeft: TUpDown;
    ECustTop: TEdit;
    UDTop: TUpDown;
    Label3: TLabel;
    CBTextAlign: TComboFlat;
    TabCallout: TTabSheet;
    BCalloutPen: TButtonPen;
    BCalloutPointer: TButton;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    EX: TEdit;
    Label7: TLabel;
    EY: TEdit;
    Label8: TLabel;
    EZ: TEdit;
    CBCursor: TComboFlat;
    Label9: TLabel;
    Label10: TLabel;
    EArrowDist: TEdit;
    UDArrowDist: TUpDown;
    Label11: TLabel;
    CBHead: TComboFlat;
    Label12: TLabel;
    Edit1: TEdit;
    UDHeadSize: TUpDown;
    Label13: TLabel;
    CBUnits: TComboFlat;
    TabSize: TTabSheet;
    Label14: TLabel;
    Label15: TLabel;
    ECustWidth: TEdit;
    ECustHeight: TEdit;
    UDWidth: TUpDown;
    UDHeight: TUpDown;
    CBAutoSize: TCheckBox;
    CBVisible: TCheckBox;
    CBClip: TCheckBox;
    Button1: TButton;
    TabMargins: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure EFormatChange(Sender: TObject);
    procedure CBPosChange(Sender: TObject);
    procedure ECustLeftChange(Sender: TObject);
    procedure CBCustPosClick(Sender: TObject);
    procedure ECustTopChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBTextAlignChange(Sender: TObject);
    procedure BCalloutPointerClick(Sender: TObject);
    procedure EXChange(Sender: TObject);
    procedure EYChange(Sender: TObject);
    procedure EZChange(Sender: TObject);
    procedure CBCursorChange(Sender: TObject);
    procedure EArrowDistChange(Sender: TObject);
    procedure CBHeadChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CBUnitsChange(Sender: TObject);
    procedure CBAutoSizeClick(Sender: TObject);
    procedure ECustWidthChange(Sender: TObject);
    procedure ECustHeightChange(Sender: TObject);
    procedure CBVisibleClick(Sender: TObject);
    procedure CBClipClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    ShapeForm    : TFormTeeShape;
    MarginsForm  : TMarginsEditor;

    Function CanChangePos:Boolean;
    Function CanChangeSize:Boolean;
    Procedure EnableCustomPosition;
    Procedure EnableCustomSize;
  protected
    Tool : TAnnotationTool;
  public
    { Public declarations }
    procedure RefreshControls(ATool:TAnnotationTool);
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
  TeEngine, TeePoEdi, TeeStringsEditor;

procedure TAnnotationToolEdit.RefreshControls(ATool:TAnnotationTool);
begin
  Tool:=ATool;

  ShapeForm.RefreshControls(Tool.Shape);
  MarginsForm.RefreshControls(Tool.Shape.Margins);

  With Tool do
  begin
    MemoText.Lines.Text:=Text;
    CBPos.ItemIndex:=Ord(Position);

    if PositionUnits=muPercent then CBUnits.ItemIndex:=0
                               else CBUnits.ItemIndex:=1;

    if TextAlignment=taLeftJustify then
       CBTextAlign.ItemIndex:=0
    else
    if TextAlignment=taCenter then
       CBTextAlign.ItemIndex:=1
    else
       CBTextAlign.ItemIndex:=2;

    CBVisible.Checked:=Visible;

    With Shape do
    begin
      CBCustPos.Checked:=CustomPosition;
      UDLeft.Position:=Left;
      ECustLeft.Text:=IntToStr(Left);
      UDTop.Position:=Top;
      ECustTop.Text:=IntToStr(Top);
    end;

    CBAutoSize.Checked:=AutoSize;
    UDWidth.Position:=Width;
    ECustWidth.Text:=IntToStr(Width);
    UDHeight.Position:=Height;
    ECustHeight.Text:=IntToStr(Height);
    CBClip.Checked:=ClipText;

    with Callout do
    begin
      BCalloutPen.LinkPen(Arrow);
      EX.Text:=IntToStr(XPosition);
      EY.Text:=IntToStr(YPosition);
      EZ.Text:=IntToStr(ZPosition);
      UDArrowDist.Position:=Distance;
      CBHead.ItemIndex:=Ord(ArrowHead);
      UDHeadSize.Position:=ArrowHeadSize;
    end;

    TeeFillCursors(CBCursor,Cursor);
  end;

  EnableCustomPosition;
  EnableCustomSize;

  CreatingForm:=False;
end;

procedure TAnnotationToolEdit.FormShow(Sender: TObject);
begin
  Tool:=TAnnotationTool(Tag);

  if Assigned(Tool) then
     RefreshControls(Tool);

  TeeTranslateControl(Self,[CBCursor]);
end;

procedure TAnnotationToolEdit.EFormatChange(Sender: TObject);
{$IFDEF AXUNICODE}
var tmpText : String;

  function CheckChars : Boolean;
  var i : Integer;
  Begin
    result:=True;
    if Pos('@U#',MemoText.Lines.Text)=1 then
      for i:=4 to Length(MemoText.Lines.Text) do
      Begin
        if not (((MemoText.Lines.Text[i]>='0') and (MemoText.Lines.Text[i]<='9'))
           or ((UpperCase(MemoText.Lines.Text[i])>='A') and (UpperCase(MemoText.Lines.Text[i])<='F'))
           or (MemoText.Lines.Text[i]=' ')) then
           result:=False;
      end;
  end;
{$ENDIF}
begin
  if not CreatingForm then
{$IFDEF AXUNICODE}
  Begin
     tmpText:=ReplaceChar(MemoText.Lines.Text,#10);
     if not CheckChars then
       MemoText.Lines.Text:=Copy(tmpText,2,Length(tmpText));
     Tool.Text:=ReplaceChar(MemoText.Lines.Text,#10);
  end;
{$ELSE}
    Tool.Text:=ReplaceChar(MemoText.Lines.Text,#10);
{$ENDIF}
end;

procedure TAnnotationToolEdit.CBPosChange(Sender: TObject);
begin
  Tool.Position:=TAnnotationPosition(CBPos.ItemIndex);
  EnableCustomPosition;
end;

procedure TAnnotationToolEdit.ECustLeftChange(Sender: TObject);
begin
  if CanChangePos then Tool.Left:=UDLeft.Position;
end;

procedure TAnnotationToolEdit.CBCustPosClick(Sender: TObject);
begin
  Tool.Shape.CustomPosition:=CBCustPos.Checked;
  EnableCustomPosition;
end;

procedure TAnnotationToolEdit.ECustTopChange(Sender: TObject);
begin
  if CanChangePos then Tool.Top:=UDTop.Position
end;

Function TAnnotationToolEdit.CanChangePos:Boolean;
begin
  result:=(not CreatingForm) and (Tool.Shape.CustomPosition);
end;

Function TAnnotationToolEdit.CanChangeSize:Boolean;
begin
  result:=(not CreatingForm) and (not Tool.AutoSize);
end;

procedure TAnnotationToolEdit.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  Align:=alClient;

  ShapeForm:=InsertTeeObjectForm(PageControl1,nil);

  MarginsForm:=TMarginsEditor.Create(Self);
  AddFormTo(MarginsForm,TabMargins);

  PageControl1.ActivePage:=TabText;
end;

Procedure TAnnotationToolEdit.EnableCustomPosition;
var tmp : Boolean;
    Old : Boolean;
begin
  Old:=CreatingForm;
  CreatingForm:=True;

  tmp:=Tool.Shape.CustomPosition;

  EnableControls(tmp,[ECustLeft,ECustTop,UDLeft,UDTop,CBUnits]);

  CBCustPos.Checked :=tmp;

  if tmp then
  begin
    UDLeft.Position :=Tool.Shape.Left;
    UDTop.Position  :=Tool.Shape.Top;
  end;

  CreatingForm:=Old;
end;

Procedure TAnnotationToolEdit.EnableCustomSize;
var tmp : Boolean;
    Old : Boolean;
begin
  Old:=CreatingForm;
  CreatingForm:=True;

  tmp:=not Tool.AutoSize;

  EnableControls(tmp,[ECustWidth,ECustHeight,UDWidth,UDHeight]);

  CBAutoSize.Checked:=not tmp;

  if tmp then
  begin
    UDWidth.Position:=Tool.Width;
    UDHeight.Position:=Tool.Height;
  end;

  CreatingForm:=Old;
end;

procedure TAnnotationToolEdit.CBTextAlignChange(Sender: TObject);
begin
  case CBTextAlign.ItemIndex of
    0: Tool.TextAlignment:=taLeftJustify;
    1: Tool.TextAlignment:=taCenter;
  else
    Tool.TextAlignment:=taRightJustify;
  end;
end;

procedure TAnnotationToolEdit.BCalloutPointerClick(Sender: TObject);
begin
  EditSeriesPointer(Self,Tool.Callout);
end;

procedure TAnnotationToolEdit.EXChange(Sender: TObject);
begin
  if Showing then
     with Tool.Callout do
          XPosition:=StrToIntDef(EX.Text,XPosition);
end;

procedure TAnnotationToolEdit.EYChange(Sender: TObject);
begin
  if Showing then
     with Tool.Callout do
          YPosition:=StrToIntDef(EY.Text,YPosition);
end;

procedure TAnnotationToolEdit.EZChange(Sender: TObject);
begin
  if Showing then
     with Tool.Callout do
          ZPosition:=StrToIntDef(EZ.Text,ZPosition);
end;

procedure TAnnotationToolEdit.CBCursorChange(Sender: TObject);
begin
  with Tool do
       Cursor:=TeeSetCursor(Cursor,CBCursor.CurrentItem);
end;

procedure TAnnotationToolEdit.EArrowDistChange(Sender: TObject);
begin
  if Showing and Assigned(Tool) then
     Tool.Callout.Distance:=UDArrowDist.Position;
end;

procedure TAnnotationToolEdit.CBHeadChange(Sender: TObject);
begin
  if Showing then
     Tool.Callout.ArrowHead:=TArrowHeadStyle(CBHead.ItemIndex);
end;

procedure TAnnotationToolEdit.Edit1Change(Sender: TObject);
begin
  if Showing and Assigned(Tool) then
     Tool.Callout.ArrowHeadSize:=UDHeadSize.Position;
end;

procedure TAnnotationToolEdit.CBUnitsChange(Sender: TObject);
begin
  if CBUnits.ItemIndex=0 then
  begin
    Tool.PositionUnits:=muPercent;

    if UDLeft.Position>100 then UDLeft.Position:=100;
    if UDTop.Position>100 then UDTop.Position:=100;
  end
  else Tool.PositionUnits:=muPixels;
end;

procedure TAnnotationToolEdit.CBAutoSizeClick(Sender: TObject);
begin
  Tool.AutoSize:=CBAutoSize.Checked;
  EnableCustomSize;
end;

procedure TAnnotationToolEdit.ECustWidthChange(Sender: TObject);
begin
  if CanChangeSize then
     Tool.Width:=UDWidth.Position
end;

procedure TAnnotationToolEdit.ECustHeightChange(Sender: TObject);
begin
  if CanChangeSize then
     Tool.Height:=UDHeight.Position
end;

procedure TAnnotationToolEdit.CBVisibleClick(Sender: TObject);
begin
  Tool.Visible:=CBVisible.Checked;
end;

procedure TAnnotationToolEdit.CBClipClick(Sender: TObject);
begin
  Tool.ClipText:=CBClip.Checked;
end;

procedure TAnnotationToolEdit.PageControl1Change(Sender: TObject);
begin
  if Assigned(ShapeForm) then
     ShapeForm.PC1Change(PageControl1);
end;

procedure TAnnotationToolEdit.Button1Click(Sender: TObject);
begin
  TeeEditStrings(Self,MemoText.Lines);
end;

initialization
  RegisterClass(TAnnotationToolEdit);
end.
