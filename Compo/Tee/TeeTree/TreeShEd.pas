{**********************************************}
{   TTree Component                            }
{   Copyright (c) 1998-2009 by David Berneda   }
{**********************************************}
{$I TeeDefs.inc}
unit TreeShEd;

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls, QButtons,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ExtDlgs, ComCtrls, Buttons,
  {$ENDIF}
  TeeTree, TeCanvas, TeePenDlg, TeeFiltersEditor, TeeEdiGrad;

type
  TNodeTreeEditor = class(TForm)
    PageControl1: TPageControl;
    TabText: TTabSheet;
    TabImage: TTabSheet;
    Label6: TLabel;
    ComboBox4: TComboFlat;
    Image1: TImage;
    Button5: TButton;
    TabFormat: TTabSheet;
    Label2: TLabel;
    CheckBox3: TCheckBox;
    Label1: TLabel;
    CBStyle: TComboFlat;
    Button1: TButton;
    TabGradient: TTabSheet;
    CheckBox2: TCheckBox;
    CBGradientStyle: TComboFlat;
    Label4: TLabel;
    TabShadow: TTabSheet;
    TabPosition: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    CheckBox1: TCheckBox;
    Label10: TLabel;
    Label11: TLabel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label12: TLabel;
    ScrollBar2: TScrollBar;
    Label13: TLabel;
    ScrollBar3: TScrollBar;
    Label14: TLabel;
    ScrollBar4: TScrollBar;
    Label15: TLabel;
    ScrollBar5: TScrollBar;
    Bevel1: TBevel;
    Label16: TLabel;
    CBCursor: TComboFlat;
    CheckBox4: TCheckBox;
    Shape4: TShape;
    Label18: TLabel;
    ComboBox3: TComboFlat;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Edit5: TEdit;
    UpDown5: TUpDown;
    Label3: TLabel;
    Label19: TLabel;
    Edit6: TEdit;
    UpDown6: TUpDown;
    Label20: TLabel;
    ComboBox5: TComboFlat;
    GroupBox1: TGroupBox;
    Shape2: TShape;
    Shape3: TShape;
    Button4: TButton;
    Shape5: TShape;
    Button2: TButton;
    Shape6: TShape;
    BBackColor: TButtonColor;
    CheckBox7: TCheckBox;
    Label21: TLabel;
    ETransp: TEdit;
    UDTransp: TUpDown;
    CheckBox8: TCheckBox;
    CBConnStyle: TComboFlat;
    Label22: TLabel;
    CBImgTransp: TCheckBox;
    Button6: TButton;
    ButtonGradient1: TButtonGradient;
    Panel1: TPanel;
    Button3: TButton;
    LRoundSize: TLabel;
    ERoundSize: TEdit;
    UDRound: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure CBGradientStyleChange(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure Shape2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar4Change(Sender: TObject);
    procedure ScrollBar5Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure CBCursorChange(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Shape4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox3Change(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure Shape5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BBackColorClick(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure ETranspChange(Sender: TObject);
    procedure CBConnStyleChange(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CBImgTranspClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ERoundSizeChange(Sender: TObject);
  private
    { Private declarations }
    Changing  : Boolean;
    OldX      : Integer;
    OldY      : Integer;
    procedure CheckImgTransp;
    procedure Image1Assign(Value:TPicture);
    procedure ProcGetCursors(const S: string);
    Procedure SetUpDowns;
  public
    { Public declarations }
    Tree1     : TCustomTree;
  end;

type TTreeShapeTabs=(stFormat,stText,stImage,stGradient,stShadow,stPosition);

Procedure EditTreeShape(AOwner:TComponent; AShape:TTreeNodeShape);
Procedure EditTreeShapePage( AOwner:TComponent; AShape:TTreeNodeShape;
                             ATab:TTreeShapeTabs; ShowPosition:Boolean);

Procedure InternalEditTreeShapePage( AOwner:TComponent; AShape:TTreeNodeShape;
                             ATab:TTreeShapeTabs; ShowPosition:Boolean;
                             CallOnShow:TNotifyEvent);

Function PictureDialog:TOpenDialog;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeeBrushDlg, TeeProcs, TreeTeEd, TeeTranslate, TreeConst, TeeShadowEditor;

Procedure EditTreeShape(AOwner:TComponent; AShape:TTreeNodeShape);
begin
  EditTreeShapePage(AOwner,AShape,stFormat,True);
end;

Procedure EditTreeShapePage( AOwner:TComponent; AShape:TTreeNodeShape;
                             ATab:TTreeShapeTabs; ShowPosition:Boolean);
begin
  InternalEditTreeShapePage(AOwner,AShape,ATab,ShowPosition,nil);
end;

type TSelectedAccess=class(TSelectedShapeList);

Procedure InternalEditTreeShapePage( AOwner:TComponent; AShape:TTreeNodeShape;
                             ATab:TTreeShapeTabs; ShowPosition:Boolean;
                             CallOnShow:TNotifyEvent);
var OldSelected : Boolean;
    tmpEditor   : TNodeTreeEditor;
begin
  tmpEditor:=TNodeTreeEditor.Create(AOwner);
  with tmpEditor do
  try
    TabPosition.TabVisible:=ShowPosition;
    OldSelected:=AShape.Selected;
    Tree1:=TTree(AShape.Tree);
    if not Assigned(Tree1) then
    begin
      Tree1:=TCustomTree.Create(nil);
      TSelectedAccess(Tree1.Selected).InternalAdd(AShape);
    end
    else
    begin
      //Tree1.Selected.Clear;  //tom 25/08/2002: change all selected objects
      AShape.Selected:=True;
    end;

    Case ATab of
      stFormat    : PageControl1.ActivePage:=TabFormat;
      stText      : PageControl1.ActivePage:=TabText;
      stImage     : PageControl1.ActivePage:=TabImage;
      stGradient  : PageControl1.ActivePage:=TabGradient;
      stShadow    : PageControl1.ActivePage:=TabShadow;
      stPosition  : PageControl1.ActivePage:=TabPosition;
    end;

    if Assigned(CallOnShow) then CallOnShow(tmpEditor);

    PageControl1Change(PageControl1);

    ShowModal;
    AShape.Selected:=OldSelected;

    if not Assigned(AShape.Tree) then Tree1.Free;
  finally
    Free;
  end;
end;

procedure TNodeTreeEditor.Button1Click(Sender: TObject);
var t : Integer;
begin
  With Tree1 do
  if Selected.Count>0 then
    if EditChartPen(Self,Selected[0].Border) then
       for t:=1 to Selected.Count-1 do
           Selected[t].Border.Assign(Selected[0].Border);
end;

procedure TNodeTreeEditor.Button2Click(Sender: TObject);
var t : Integer;
begin
  With Tree1 do
  if Selected.Count>0 then
    if EditChartBrush(Self,Selected[0].Brush) then
       for t:=1 to Selected.Count-1 do
           Selected[t].Brush.Assign(Selected[0].Brush);
end;

Function PictureDialog:TOpenDialog;
begin
  {$IFDEF D4}
  {$IFDEF CLX}
  result:=TOpenDialog.Create(nil);
  {$ELSE}
  result:=TOpenPictureDialog.Create(nil);
  {$ENDIF}
  {$ELSE}
  result:=TOpenDialog.Create(nil);
  {$ENDIF}
  result.Filter:=GraphicFilter(TGraphic);
end;

procedure TNodeTreeEditor.CheckImgTransp;
begin
  CBImgTransp.Enabled:=Assigned(Image1.Picture.Graphic);
  CBImgTransp.Checked:=CBImgTransp.Enabled and Image1.Picture.Graphic.Transparent;
end;

procedure TNodeTreeEditor.Image1Assign(Value:TPicture);
begin
  Image1.Picture.Assign(Value);
  Image1.Transparent:=Assigned(Value) and Assigned(Value.Graphic)
                                      and Value.Graphic.Transparent;
  CheckImgTransp;
end;

procedure TNodeTreeEditor.Button5Click(Sender: TObject);
var t : Integer;
begin
  With Tree1 do
  if Selected.Count>0 then
  if Button5.Caption=TreeMsg_Browse then
  begin
    with PictureDialog do
    try
      if Execute then
      begin
        Selected[0].ImageIndex:=tiNone;
        Selected[0].Image.LoadFromFile(FileName);

        for t:=1 to Selected.Count-1 do
        begin
          Selected[t].ImageIndex:=tiNone;
          Selected[t].Image.Assign(Selected[0].Image);
        end;

        Image1Assign(Selected[0].Image);

        ComboBox3.ItemIndex:=0;
        Button5.Caption:=TreeMsg_Clear;
      end;
    finally
      Free;
    end;
  end
  else
  begin
    for t:=0 to Selected.Count-1 do
    begin
      Selected[t].ImageIndex:=tiNone;
      Selected[t].Image.Assign(nil);
    end;

    Tree1.Repaint;
    Image1Assign(nil);
    ComboBox3.ItemIndex:=0;
    Button5.Caption:=TreeMsg_Browse;
  end;
end;

procedure TNodeTreeEditor.CheckBox2Click(Sender: TObject);
var t : Integer;
begin
  if not Changing then
  With Tree1 do
  for t:=0 to Selected.Count-1 do
      Selected[t].Gradient.Visible:=CheckBox2.Checked;
end;

procedure TNodeTreeEditor.CheckBox3Click(Sender: TObject);
var t : Integer;
begin
  With Tree1 do
  for t:=0 to Selected.Count-1 do
      Selected[t].Transparent:=CheckBox3.Checked;
end;

procedure TNodeTreeEditor.CBStyleChange(Sender: TObject);
var t : Integer;
    tmp : Integer;
begin
  tmp:=CBStyle.ItemIndex;
  if tmp>11 then Inc(tmp); // <-- skip "tssCustom"

  With Tree1 do
  for t:=0 to Selected.Count-1 do
  With Selected[t] do
  begin
    Style:=TTreeShapeStyle(tmp);
    Border.Visible:=True;
  end;
end;

procedure TNodeTreeEditor.CBGradientStyleChange(Sender: TObject);
var t : Integer;
begin
  if not Changing then
  With Tree1 do
  for t:=0 to Selected.Count-1 do
      Selected[t].Gradient.Direction:=TGradientDirection(CBGradientStyle.ItemIndex);
end;

procedure TNodeTreeEditor.ComboBox4Change(Sender: TObject);
var t : Integer;
begin
  With Tree1.Selected do
  for t:=0 to Count-1 do
  with Items[t] do
  begin
    ImageAlignment:=TTreeImageAlignment(ComboBox4.ItemIndex);
    if ImageAlignment=iaCenter then Transparent:=True;
  end;
end;

procedure TNodeTreeEditor.Shape2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var t        : Integer;
    tmpColor : TColor;
    OldColor : TColor;
begin
  With Tree1 do
  if Selected.Count>0 then
  begin
    OldColor:=Selected[0].Gradient.StartColor;
    tmpColor:=EditColor(Self,OldColor);

    if tmpColor<>OldColor then
    begin
      for t:=0 to Selected.Count-1 do
          Selected[t].Gradient.StartColor:=tmpColor;

      Shape2.Brush.Color:=tmpColor;
    end;
  end;
end;

procedure TNodeTreeEditor.Shape3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var t        : Integer;
    tmpColor : TColor;
    OldColor : TColor;
begin
  With Tree1 do
  if Selected.Count>0 then
  begin
    OldColor:=Selected[0].Gradient.EndColor;
    tmpColor:=EditColor(Self,OldColor);

    if tmpColor<>OldColor then
    begin
      for t:=0 to Selected.Count-1 do
          Selected[t].Gradient.EndColor:=tmpColor;

      Shape3.Brush.Color:=tmpColor;
    end;
  end;
end;

procedure TNodeTreeEditor.Button3Click(Sender: TObject);
begin
  Close;
end;

Const TeeCursorPrefix='cr';

Function DeleteCursorPrefix(Const S:String):String;
begin
  result:=S;
  if Copy(result,1,2)=TeeCursorPrefix then Delete(result,1,2);
end;

procedure TNodeTreeEditor.FormShow(Sender: TObject);
var tmpSt : String;
    tmp   : Integer;
begin
  if Ord(High(TGradientDirection))>6 then
     CBGradientStyle.Add('Radial');

  if Assigned(Tree1) then
  if Tree1.Selected.Count>0 then
  with Tree1.Selected[0] do
  begin
    Shape4.Brush.Color:=Brush.Color;
    Shape5.Brush.Color:=Border.Color;

    if ImageIndex=tiNone then
    begin
      if Assigned(Image) and Assigned(Image.Graphic) then
      begin
        Image1Assign(Image);
        Button5.Caption:=TreeMsg_Clear;
      end
      else
        Button5.Caption:=TreeMsg_Browse;
    end
    else
    begin
      Button5.Caption:=TreeMsg_Clear;
      Image1Assign(GetPicture);
    end;

    BBackColor.LinkProperty(Tree1.Selected[0],'BackColor');
    CheckBox2.Checked:=Gradient.Visible;

    tmp:=Ord(Style);
    if tmp>11 then Dec(tmp); // skip "tssCustom"

    CBStyle.ItemIndex:=tmp;

    ShowControls(Style<>tssCustom, [CBStyle,UDRound,ERoundSize,LRoundSize,Label1]);

    CheckBox3.Checked:=Transparent;

    Case ShowCross of
      scAuto: ComboBox5.ItemIndex:=0;
      scAlways: ComboBox5.ItemIndex:=1;
      scNever: ComboBox5.ItemIndex:=2;
    end;

    { gradient }
    ButtonGradient1.LinkGradient(Gradient);
    CBGradientStyle.ItemIndex:=Ord(Gradient.Direction);
    Shape2.Brush.Color:=Gradient.StartColor;
    Shape3.Brush.Color:=Gradient.EndColor;

    if Gradient.MidColor=clNone then
        Shape6.Brush.Color:=GroupBox1.Color
    else
        Shape6.Brush.Color:=Gradient.MidColor;

    CheckBox7.Enabled:=Gradient.MidColor<>clNone;

    { transparency }
    UDTransp.Position:=Transparency;

    UDRound.Position:=RoundSize;

    ComboBox4.ItemIndex:=Ord(ImageAlignment);
    ComboBox3.ItemIndex:=Ord(ImageIndex);

    InsertTeeShadowEditor(TabShadow).RefreshControls(Shadow);

    CheckBox1.Checked:=AutoSize;
    CheckBox5.Checked:=AutoPosition.Left;
    CheckBox6.Checked:=AutoPosition.Top;
    Edit3.Enabled:=not AutoSize;
    Edit4.Enabled:=not AutoSize;
    ScrollBar4.Enabled:=not CheckBox1.Checked;
    ScrollBar5.Enabled:=not CheckBox1.Checked;
    SetUpDowns;
    Changing:=True;
    ScrollBar2.Position:=0;
    ScrollBar3.Position:=0;
    ScrollBar4.Position:=X1-X0;
    ScrollBar5.Position:=Y1-Y0;
    CheckBox4.Checked:=GradientClip;

    CheckBox8.Checked:=Text.ClipText;

    if Connections.Count=0 then
       CBConnStyle.ItemIndex:=0
    else
       CBConnStyle.ItemIndex:=Ord(Connections[0].Style);

    With CBCursor do
    begin
      Items.BeginUpdate;
      Clear;
      GetCursorValues(ProcGetCursors);
      ProcGetCursors(TeeMsg_TeeHand);
      Items.EndUpdate;
    end;

    With CBCursor do
    if TeeCursorToIdent(Cursor,tmpSt) then
       ItemIndex:=Items.IndexOf(DeleteCursorPrefix(tmpSt))
    else
       ItemIndex:=-1;

    UpDown5.Position:=ImageWidth;
    UpDown6.Position:=ImageHeight;

    CheckImgTransp;

    if csDesigning in ComponentState then
       Caption:=TreeMsg_EditingMode+Name;

    Changing:=False;
  end;
end;

Procedure TNodeTreeEditor.SetUpDowns;

  Procedure ChangeUpDown(UpDown:TUpDown; Value:Integer);
  var tmp : TEdit;
  begin
    if Abs(Value)<=32767 then
       UpDown.Position:=Value
    else
    begin
      tmp:=TEdit(UpDown.Associate);
      UpDown.Associate:=nil;
      tmp.Text:=TeeStr(Value);
    end;
  end;

begin
  Changing:=True;
  if Tree1.Selected.Count>0 then
  with Tree1.Selected[0] do
  begin
    ChangeUpDown(UpDown1,X0);
    ChangeUpDown(UpDown2,Y0);
    ChangeUpDown(UpDown3,X1);
    ChangeUpDown(UpDown4,Y1);
  end;
  Changing:=False;
end;

procedure TNodeTreeEditor.CheckBox1Click(Sender: TObject);
var t : Integer;
begin
  if not Changing then
  begin
    With Tree1 do
    for t:=0 to Selected.Count-1 do
    With Selected[t] do AutoSize:=CheckBox1.Checked;
    Edit3.Enabled:=not CheckBox1.Checked;
    Edit4.Enabled:=not CheckBox1.Checked;
    ScrollBar4.Enabled:=not CheckBox1.Checked;
    ScrollBar5.Enabled:=not CheckBox1.Checked;
  end;
end;

procedure TNodeTreeEditor.Edit2Change(Sender: TObject);
begin
  if not Changing then
  With Tree1 do
  if Selected.Count>0 then Selected[0].Y0:=UpDown2.Position;
end;

procedure TNodeTreeEditor.Edit1Change(Sender: TObject);
begin
  if not Changing then
  With Tree1 do
  if Selected.Count>0 then Selected[0].X0:=UpDown1.Position;
end;

procedure TNodeTreeEditor.Edit3Change(Sender: TObject);
begin
  if not Changing then
  With Tree1 do
  if Selected.Count>0 then Selected[0].X1:=UpDown3.Position;
end;

procedure TNodeTreeEditor.Edit4Change(Sender: TObject);
begin
  if not Changing then
  With Tree1 do
  if Selected.Count>0 then Selected[0].Y1:=UpDown4.Position;
end;

procedure TNodeTreeEditor.ProcGetCursors(const S: string);
begin
  CBCursor.Add(DeleteCursorPrefix(S));
end;

procedure TNodeTreeEditor.FormCreate(Sender: TObject);
begin
  Changing:=True;
  OldX:=0;
  OldY:=0;

  TeeTranslateControl(Self);
end;

procedure TNodeTreeEditor.ScrollBar2Change(Sender: TObject);
var t   : Integer;
    tmp : Integer;
begin
  if not Changing then
  begin
    tmp:=(ScrollBar2.Position-OldX);
    With Tree1.Selected do
    for t:=0 to Count-1 do
        Items[t].MoveRelative(tmp,0,False);

    OldX:=ScrollBar2.Position;
    SetUpDowns;
  end;
end;

procedure TNodeTreeEditor.ScrollBar4Change(Sender: TObject);
var t : Integer;
begin
  if not Changing then
  begin
    With Tree1 do
    for t:=0 to Selected.Count-1 do
    With Selected[t] do X1:=X0+ScrollBar4.Position;
    SetUpDowns;
  end;
end;

procedure TNodeTreeEditor.ScrollBar5Change(Sender: TObject);
var t : Integer;
begin
  if not Changing then
  begin
    With Tree1 do
    for t:=0 to Selected.Count-1 do
    With Selected[t] do Y1:=Y0+ScrollBar5.Position;
    SetUpDowns;
  end;
end;

procedure TNodeTreeEditor.ScrollBar3Change(Sender: TObject);
var t   : Integer;
    tmp : Integer;
begin
  if not Changing then
  begin
    tmp:=(ScrollBar3.Position-OldY);
    With Tree1.Selected do
    for t:=0 to Count-1 do
        Items[t].MoveRelative(0,tmp,False);

    OldY:=ScrollBar3.Position;
    SetUpDowns;
  end;
end;

procedure TNodeTreeEditor.CBCursorChange(Sender: TObject);
var tmpCursor : Longint;
    t         : Integer;
begin
  if TeeIdentToCursor(TeeCursorPrefix+CBCursor.CurrentItem,tmpCursor) then
     With Tree1 do
     for t:=0 to Selected.Count-1 do
         Selected[t].Cursor:=tmpCursor;
end;

procedure TNodeTreeEditor.Button4Click(Sender: TObject);
var t   : Integer;
    tmp : TColor;
begin
  for t:=0 to Tree1.Selected.Count-1 do
  With Tree1.Selected[t].Gradient do
  begin
    tmp:=StartColor;
    StartColor:=EndColor;
    EndColor:=tmp;
    Shape2.Brush.Color:=StartColor;
    Shape3.Brush.Color:=EndColor;
  end;
end;

procedure TNodeTreeEditor.CheckBox4Click(Sender: TObject);
var t : Integer;
begin
  if not Changing then
  for t:=0 to Tree1.Selected.Count-1 do
      Tree1.Selected[t].GradientClip:=CheckBox4.Checked;
end;

procedure TNodeTreeEditor.Shape4MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmpColor : TColor;
    t        : Integer;
    OldColor : TColor;
begin
  OldColor:=Tree1.Selected[0].Brush.Color;
  tmpColor:=EditColor(Self,OldColor);

  if tmpColor<>OldColor then
  begin
    for t:=0 to Tree1.Selected.Count-1 do
    begin
      Tree1.Selected[t].Brush.Color:=tmpColor;
      Tree1.Selected[t].Transparent:=False;
    end;

    Shape4.Brush.Color:=tmpColor;
    CheckBox3.Checked:=False;
  end;
end;

procedure TNodeTreeEditor.ComboBox3Change(Sender: TObject);
var t : Integer;
begin
  With Tree1 do
  for t:=0 to Selected.Count-1 do
      Selected[t].ImageIndex:=TTreeNodeImageIndex(ComboBox3.ItemIndex);

  Image1Assign(Tree1.Selected[0].GetPicture);
end;

procedure TNodeTreeEditor.CheckBox5Click(Sender: TObject);
var t : Integer;
begin
  if not Changing then
  With Tree1 do
  for t:=0 to Selected.Count-1 do
  With Selected[t] do AutoPosition.Left:=CheckBox5.Checked;
end;

procedure TNodeTreeEditor.PageControl1Change(Sender: TObject);
var tmp : TFormTeeText;
begin
  if (Sender as TPageControl).ActivePage=TabText then
  if TabText.ControlCount=0 then
  begin
    tmp:=TFormTeeText.Create(Self);
    tmp.Tree1:=Tree1;
    tmp.Connection1:=nil;

    AddFormTo(tmp,TabText{$IFNDEF D4},0{$ENDIF});
    tmp.ReAlign; //tom:01/09/2002
  end;
end;

procedure TNodeTreeEditor.CheckBox6Click(Sender: TObject);
var t : Integer;
begin
  if not Changing then
  With Tree1 do
  for t:=0 to Selected.Count-1 do
  With Selected[t] do AutoPosition.Top:=CheckBox6.Checked;
end;

procedure TNodeTreeEditor.Edit5Change(Sender: TObject);
var t:Integer;
begin
  if not Changing then
  With Tree1 do
  for t:=0 to Selected.Count-1 do
  With Selected[t] do
  if Sender=Edit5 then ImageWidth:=UpDown5.Position
                  else ImageHeight:=UpDown6.Position;
end;

procedure TNodeTreeEditor.ComboBox5Change(Sender: TObject);
var t : Integer;
begin
  if not Changing then
  With Tree1 do
  for t:=0 to Selected.Count-1 do
  With Selected[t] do
  Case ComboBox5.ItemIndex of
    0: ShowCross:=scAuto;
    1: ShowCross:=scAlways;
    2: ShowCross:=scNever;
  end;
end;

procedure TNodeTreeEditor.Shape5MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmpColor : TColor;
    t        : Integer;
    OldColor : TColor;
begin
  OldColor:=Tree1.Selected[0].Border.Color;
  tmpColor:=EditColor(Self,OldColor);

  if tmpColor<>OldColor then
  begin
    for t:=0 to Tree1.Selected.Count-1 do
        Tree1.Selected[t].Border.Color:=tmpColor;

    Shape5.Brush.Color:=tmpColor;
  end;
end;

procedure TNodeTreeEditor.Shape6MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var t        : Integer;
    tmpColor : TColor;
    OldColor : TColor;
begin
  With Tree1 do
  if Selected.Count>0 then
  begin
    OldColor:=Selected[0].Gradient.MidColor;
    tmpColor:=EditColor(Self,OldColor);

    if tmpColor<>OldColor then
    begin
      for t:=0 to Selected.Count-1 do
          Selected[t].Gradient.MidColor:=tmpColor;

      Shape6.Brush.Color:=tmpColor;
    end;
  end;

  CheckBox7.Enabled:=True;
end;

procedure TNodeTreeEditor.BBackColorClick(Sender: TObject);
var t : Integer;
begin
  With Tree1.Selected do
  if Count>0 then
     for t:=1 to Count-1 do Items[t].BackColor:=Items[0].BackColor;
end;

procedure TNodeTreeEditor.CheckBox7Click(Sender: TObject);
var t : Integer;
begin
  if CheckBox7.Checked then
  for t:=0 to Tree1.Selected.Count-1 do
      Tree1.Selected[t].Gradient.MidColor:=clNone;

  CheckBox7.Enabled:=not CheckBox7.Checked;

  if CheckBox7.Checked then Shape6.Brush.Color:=GroupBox1.Color;
end;

procedure TNodeTreeEditor.ETranspChange(Sender: TObject);
var t : Integer;
begin
  if Showing then
  for t:=0 to Tree1.Selected.Count-1 do
      Tree1.Selected[t].Transparency:=UDTransp.Position;
end;

procedure TNodeTreeEditor.CBConnStyleChange(Sender: TObject);
var t  : Integer;
    tt : Integer;
begin
  if not Changing then
  With Tree1 do
  for t:=0 to Selected.Count-1 do
  With Selected[t] do
       for tt:=0 to Connections.Count-1 do
           Connections[tt].Style:=TTreeConnectionStyle(CBConnStyle.ItemIndex);
end;

procedure TNodeTreeEditor.CheckBox8Click(Sender: TObject);
var t: Integer;
begin
  if not Changing then
  With Tree1 do
  for t:=0 to Selected.Count-1 do Selected[t].Text.ClipText:=CheckBox8.Checked;
end;

procedure TNodeTreeEditor.CBImgTranspClick(Sender: TObject);
var t : Integer;
begin
  With Tree1 do
  begin
    for t:=0 to Selected.Count-1 do
        Selected[t].Image.Transparent:=CBImgTransp.Checked;

    Invalidate;
  end;
end;

procedure TNodeTreeEditor.Button6Click(Sender: TObject);
begin
  ShowFiltersEditor(Self, Tree1.Selected[0].GetImage);
end;

procedure TNodeTreeEditor.ERoundSizeChange(Sender: TObject);
var t : Integer;
begin
  if Showing then
  for t:=0 to Tree1.Selected.Count-1 do
      Tree1.Selected[t].RoundSize:=UDRound.Position;
end;

end.
