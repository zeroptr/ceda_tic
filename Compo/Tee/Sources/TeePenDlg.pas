{**********************************************}
{   TPenDialog                                 }
{   Copyright (c) 1996-2009 by David Berneda   }
{**********************************************}
unit TeePenDlg;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     Qt, QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     Types,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     {$IFDEF LCL}
     Buttons,
     {$ENDIF}
     TeCanvas, TeeProcs;

type
  TPenDialog = class(TForm)
    CBVisible: TCheckBox;
    SEWidth: TEdit;
    LWidth: TLabel;
    BOk: TButton;
    BCancel: TButton;
    UDWidth: TUpDown;
    LStyle: TLabel;
    CBStyle: TComboFlat;
    BColor: TButtonColor;
    CBEndStyle: TComboFlat;
    LSpace: TLabel;
    ESpace: TEdit;
    UDSpace: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure SEWidthChange(Sender: TObject);
    procedure CBVisibleClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    {$IFDEF CLX}
    procedure CBStyleDrawItem(Sender: TObject; Index: Integer;
      Rect: TRect; State: TOwnerDrawState; var Handled:Boolean);
    {$ELSE}
    procedure CBStyleDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    {$ENDIF}
    procedure BColorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBEndStyleChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ESpaceChange(Sender: TObject);
  private
    { Private declarations }
    BackupPen   : TChartPen;
    ModifiedPen : Boolean;
    Procedure EnablePenStyle;
  public
    { Public declarations }
    ThePen : TPen;
  end;

Function EditChartPen(AOwner:TComponent; ChartPen:TChartPen; HideColor:Boolean=False):Boolean;

{ Show / Hide controls in array }
Procedure ShowControls(Show:Boolean; Const AControls:Array of TControl);

{ Asks the user a question and returns Yes or No }
Function TeeYesNo(Const Message:String; Owner:TControl=nil):Boolean;
{ Same as above, but using predefined "Sure to Delete?" message }
Function TeeYesNoDelete(Const Message:String; Owner:TControl=nil):Boolean;

type
  TButtonPen=class(TTeeButton)
  private
    FEditor     : TPenDialog;
    FOldDestroy : TNotifyEvent;

    procedure EditorDestroy(Sender:TObject);
    function GetPen:TChartPen;
    function GetEditor:TPenDialog;
  protected
    procedure DrawSymbol(ACanvas:TTeeCanvas); override;
  public
    HideColor : Boolean;
    procedure Click; override;
    procedure LinkPen(APen:TChartPen);

    property Editor:TPenDialog read GetEditor;
    property Pen:TChartPen read GetPen write LinkPen; // 7.01
  end;

{$IFDEF CLX}
Procedure TeeFixParentedForm(AForm:TForm);
{$ENDIF}

Procedure AddFormTo(AForm:TForm; AParent:TWinControl); overload;
Procedure AddFormTo(AForm:TForm; AParent:TWinControl; ATag:TPersistent); overload;

{$IFNDEF CLR}
Procedure AddFormTo(AForm:TForm; AParent:TWinControl; ATag:Integer); overload;
{$ENDIF}

Procedure AddDefaultValueFormats(AItems:TStrings);

Procedure TeeLoadArrowBitmaps(AUp,ADown:TBitmap);

{ Helper listbox items routines }
procedure MoveList(Source,Dest:TCustomListBox);
procedure MoveListAll(Source,Dest:TStrings);

// Adds all cursors and special "crTeeHand" cursor to ACombo.
// Sets combo ItemIndex to ACursor.
procedure TeeFillCursors(ACombo:TComboFlat; ACursor:TCursor);
Function TeeSetCursor(ACursor:TCursor; const S:String):TCursor;

Const
  TeeFormBorderStyle={$IFDEF CLX}fbsNone{$ELSE}bsNone{$ENDIF};

// Creates a new form, sets form Align to none, centers it to screen
// or owner.center, and changes Form border style to "bsDialog".
Function TeeCreateForm(FormClass:TFormClass; AOwner:TComponent):TForm;

// Returns the name representation of ACursor in AName parameter.
// Returns "True" if succeed.
Function TeeCursorToIdent(ACursor:Integer; Var AName:String):Boolean;

// Returns the Cursor index that corresponds to AName string parameter.
// Returns "True" if succeed.
Function TeeIdentToCursor(Const AName:String; Var ACursor:Integer):Boolean;

// Sets Form parameter position to center of screen or center of Form.Owner,
// if available and for Delphi v5 and up.
procedure PositionToCenter(const Form:TForm);

// Fills a Picture with a Cursor image
procedure TeePreviewCursor(ACursor:TCursor; APicture:TPicture);

// Scales AForm PixelsPerInch to match it's Parent Form, if any
procedure TeeScaleForm(AForm:TForm);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFNDEF CLX}
     ExtDlgs,
     {$ENDIF}
     {$IFDEF CLR}
     Variants,
     {$ENDIF}
     {$IFDEF LCL}
     LCLType, // Pending to move odSelected to StdCtrls unit
     {$ENDIF}
     Math, TypInfo, TeeConst;

{$IFDEF CLR}
{$R TeeArrowDown.bmp}
{$R TeeArrowUp.bmp}
{$ENDIF}

procedure PositionToCenter(const Form:TForm);
begin
  {$IFDEF D5}
  if Assigned(Form.Owner) then
     Form.Position:=poOwnerFormCenter
  else
  {$ENDIF}
     Form.Position:=poScreenCenter;
end;

Function TeeCreateForm(FormClass:TFormClass; AOwner:TComponent):TForm;

  Function TeeGetParentForm(AOwner:TComponent):TComponent;
  begin
    result:=AOwner;
    if Assigned(result) and (result is TControl) then
    begin
      result:=GetParentForm(TControl(result));
      if not Assigned(result) then result:=AOwner;
    end;
  end;

begin
  result:=FormClass.Create(TeeGetParentForm(AOwner));

  with result do
  begin
    Align:=alNone;
    PositionToCenter(result);
    BorderStyle:=TeeBorderStyle;
  end;
end;

function CreatePenDialog(AOwner:TComponent; ChartPen:TChartPen; HideColor:Boolean=False):TPenDialog;
begin
  result:=TeeCreateForm(TPenDialog,AOwner) as TPenDialog;
  result.ThePen:=ChartPen;
  if HideColor then
     result.BColor.Hide;
end;

Function EditChartPen(AOwner:TComponent; ChartPen:TChartPen; HideColor:Boolean=False):Boolean;
Begin
  with CreatePenDialog(AOwner,ChartPen,HideColor) do
  try
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

procedure TPenDialog.FormShow(Sender: TObject);
var tmpFirstTime : Boolean;
begin
  tmpFirstTime:=not Assigned(BackupPen);

  if tmpFirstTime then
     BackupPen:=TChartPen.Create(nil);

  if Assigned(ThePen) then
  begin
    BackupPen.Assign(ThePen);

    if ThePen is TChartPen then
    begin
      CBVisible.Checked:=TChartPen(ThePen).Visible;
      BackupPen.Visible:=CBVisible.Checked;

      if IsWindowsNT then
         CBStyle.Items.Add(TeeMsg_SmallDotsPen);

      if TChartPen(ThePen).SmallDots then
      begin
        CBStyle.ItemIndex:=CBStyle.Items.Count-1;

        UDWidth.Enabled:=False;
        SEWidth.Enabled:=False;

        UDSpace.Enabled:=True;
        ESpace.Enabled:=True;
      end
      else
        CBStyle.ItemIndex:=Ord(ThePen.Style);

      if IsWindowsNT then
      begin
        CBEndStyle.ItemIndex:=Ord(TChartPen(ThePen).EndStyle);
        {$IFDEF CLX}
        CBEndStyle.OnSelect:=CBEndStyleChange;
        {$ENDIF}
      end
      else
        CBEndStyle.Visible:=False;

      UDSpace.Position:=TChartPen(ThePen).SmallSpace;
    end
    else
    begin
      CBVisible.Visible:=False;
      CBStyle.ItemIndex:=Ord(ThePen.Style);
    end;

    UDWidth.Position:=ThePen.Width;

    EnablePenStyle;

    BColor.LinkProperty(ThePen,'Color');
  end;

  if tmpFirstTime then
     TeeTranslateControl(Self);

  ModifiedPen:=False;
end;

Procedure TPenDialog.EnablePenStyle;
begin
  {$IFNDEF CLX}
  if not IsWindowsNT then
     CBStyle.Enabled:=ThePen.Width=1;
  {$ENDIF}
end;

procedure TPenDialog.SEWidthChange(Sender: TObject);
begin
  if Showing then
  begin
    ThePen.Width:=UDWidth.Position;
    EnablePenStyle;
    ModifiedPen:=True;
  end;
end;

procedure TPenDialog.CBEndStyleChange(Sender: TObject);
begin
  TChartPen(ThePen).EndStyle:=TPenEndStyle(CBEndStyle.ItemIndex);
  ModifiedPen:=True;
end;

procedure TPenDialog.CBVisibleClick(Sender: TObject);
begin
  if Showing then
  begin
    TChartPen(ThePen).Visible:=CBVisible.Checked;
    ModifiedPen:=True;
  end;
end;

procedure TPenDialog.BCancelClick(Sender: TObject);
begin
  if ModifiedPen then
  begin
    ThePen.Assign(BackupPen);

    if ThePen is TChartPen then
    begin
      TChartPen(ThePen).Visible:=BackupPen.Visible;

      if Assigned(ThePen.OnChange) then
         ThePen.OnChange(Self);
    end;
  end;

  ModalResult:=mrCancel;
end;

procedure TPenDialog.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

procedure TPenDialog.CBStyleChange(Sender: TObject);
var tmp : Boolean;
begin
  if (ThePen is TChartPen) and IsWindowsNT and
     (CBStyle.ItemIndex=CBStyle.Items.Count-1) then
  begin
    TChartPen(ThePen).SmallDots:=True;
    tmp:=False;
  end
  else
  begin
    tmp:=True;
    ThePen.Style:=TPenStyle(CBStyle.ItemIndex);

    if ThePen is TChartPen then
       TChartPen(ThePen).SmallDots:=False;
  end;

  UDWidth.Enabled:=tmp; { 5.01 }
  SEWidth.Enabled:=tmp;

  UDSpace.Enabled:=not tmp;
  ESpace.Enabled:=not tmp;

  ModifiedPen:=True;
end;

procedure TPenDialog.BColorClick(Sender: TObject);
begin
  CBStyle.Repaint;
  ModifiedPen:=True;
end;

{$IFDEF CLX}
procedure TPenDialog.CBStyleDrawItem(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled:Boolean);
{$ELSE}
procedure TPenDialog.CBStyleDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
{$ENDIF}
var tmp : TColor;
begin
  With TControlCanvas(CBStyle.Canvas) do
  begin
    {$IFDEF CLX}
    Brush.Style:=bsSolid;
    if (odFocused in State) or (odSelected in State) then
       Brush.Color:=clHighLight;
    {$ENDIF}

    FillRect(Rect);

    {$IFNDEF CLX}
    if Index<>CBStyle.Items.Count-1 then
    {$ENDIF}
       Pen.Style:=TPenStyle(Index);

    Pen.Color:=ThePen.Color;
    if odSelected in State then tmp:=clHighLight
                           else tmp:=CBStyle.Color;
    if Pen.Color=ColorToRGB(tmp) then
       if Pen.Color=clWhite then Pen.Color:=clBlack
                            else Pen.Color:=clWhite;

    {$IFNDEF CLX}
    if IsWindowsNT and (Index=CBStyle.Items.Count-1) then { 5.01 }
       Pen.Handle:=TeeCreatePenSmallDots(Pen.Color);
    {$ENDIF}

    MoveTo(Rect.Left+2,Rect.Top+8);
    LineTo(Rect.Left+30,Rect.Top+8);
    Brush.Style:=bsClear;
    
    {$IFDEF CLX}
    if not (odSelected in State) then
       Font.Color:=ColorToRGB(clText);
    {$ELSE}
    {$IFDEF LCL}
    if not (odSelected in State) then
       Font.Color:=ColorToRGB(clText);
    {$ELSE}
    UpdateTextFlags;
    {$ENDIF}
    {$ENDIF}

    TextOut(Rect.Left+34,Rect.Top+{$IFDEF CLX}1{$ELSE}2{$ENDIF},CBStyle.Items[Index]);
  end;
end;

{ TButtonPen }
function TButtonPen.GetEditor:TPenDialog;
begin
  if not Assigned(FEditor) then
  begin
    FEditor:=CreatePenDialog(Self,TChartPen(Instance),HideColor);
    FOldDestroy:=FEditor.OnDestroy;
    FEditor.OnDestroy:=EditorDestroy;
  end;

  result:=FEditor;
end;

procedure TButtonPen.EditorDestroy(Sender:TObject);
begin
  if Assigned(FOldDestroy) then
     FOldDestroy(FEditor);

  FEditor:=nil;
end;

procedure TButtonPen.Click;
var tmp : Boolean;
begin
  if Assigned(Instance) then
  begin
    tmp:=Editor.ShowModal=mrOk;
    try
      if tmp then
      begin
        Repaint;
        inherited;
      end;
    finally
      FreeAndNil(FEditor);
    end;
  end
  else inherited;
end;

procedure TButtonPen.DrawSymbol(ACanvas: TTeeCanvas);
Const tmpWidth={$IFDEF CLX}13{$ELSE}17{$ENDIF};
var OldChange : TNotifyEvent;
    OldWidth  : Integer;
begin
  if Enabled and Assigned(Instance) then
  begin
    // allow maximum 6 pixels for symbol height...
    with TChartPen(Instance) do
    if Width>6 then
    begin
      OldChange:=OnChange;
      OnChange:=nil;
      OldWidth:=Width;
      Width:=6;
    end
    else
    begin
      OldChange:=nil;
      OldWidth:=0;
    end;

    // draw line
    With ACanvas do
    begin
      Brush.Style:=bsClear;
      AssignVisiblePen(TChartPen(Instance));
      MoveTo(Width-tmpWidth,Height div 2);
      LineTo(Width-6,Height div 2);
    end;

    // reset back old pen width
    if Assigned(OldChange) then
    with TChartPen(Instance) do
    begin
      Width:=OldWidth;
      OnChange:=OldChange;
    end;
  end;
end;

procedure TButtonPen.LinkPen(APen: TChartPen);
begin
  LinkProperty(APen,'');
  Invalidate;
end;

function TButtonPen.GetPen:TChartPen; // 7.01
begin
  result:=TChartPen(Instance);
end;

{ Utility functions }
Procedure ShowControls(Show:Boolean; Const AControls:Array of TControl);
var t : Integer;
begin
  for t:=Low(AControls) to High(AControls) do AControls[t].Visible:=Show;
end;

Function TeeYesNo(Const Message:String; Owner:TControl=nil):Boolean;
var x : Integer;
    y : Integer;
Begin
  Screen.Cursor:=crDefault;
  if Assigned(Owner) then
  begin
    x:=Owner.ClientOrigin.X+20;
    y:=Owner.ClientOrigin.Y+30;
    result:=MessageDlgPos(Message,mtConfirmation,[mbYes,mbNo],0,x,y)=mrYes;
  end
  else result:=MessageDlg(Message,mtConfirmation,[mbYes,mbNo],0)=mrYes;
End;

Function TeeYesNoDelete(Const Message:String; Owner:TControl=nil):Boolean;
begin
  result:=TeeYesNo(Format(TeeMsg_SureToDelete,[Message]),Owner);
end;

{$IFDEF CLX}
Procedure TeeFixParentedForm(AForm:TForm);
var tmpPoint : TPoint;
    tmpFlags : Integer;
begin
  with AForm do
  begin   
    if not Parent.Showing then Parent.Show;
    tmpPoint:=Point(Left,Top);
    tmpFlags:=Integer( WidgetFlags_WStyle_NoBorder ) or
              Integer( WidgetFlags_WStyle_Customize );

    QWidget_reparent(Handle, ParentWidget, Cardinal(tmpFlags), @tmpPoint, Showing);
    QOpenWidget_clearWFlags(QOpenWidgetH(Handle), Integer($FFFFFFFF));
    QOpenWidget_setWFlags(QOpenWidgetH(Handle), Cardinal(tmpFlags));
    Left:=tmpPoint.X;
    Top:=tmpPoint.Y;
  end;
end;    
{$ENDIF}

Procedure AddFormTo(AForm:TForm; AParent:TWinControl);
begin
  AddFormTo(AForm,AParent,nil);
end;

{$IFNDEF CLR}
Procedure AddFormTo(AForm:TForm; AParent:TWinControl; ATag:Integer);
begin
  AddFormTo(AForm,AParent,TComponent(ATag));
end;
{$ENDIF}

{$IFNDEF CLR}
type
  TCustomFormAccess=class(TCustomForm);
{$ENDIF}

Procedure AddFormTo(AForm:TForm; AParent:TWinControl; ATag:TPersistent);
{$IFNDEF CLX}
var OldVisibleFlag : Boolean;
{$ENDIF}
begin

  {$IFNDEF CLR}
  with TCustomFormAccess(AForm) do
  begin
    {$IFNDEF CLX}
    {$IFDEF D7}
    ParentBackground:=True;
    {$ENDIF}
    {$ENDIF}

    ParentColor:=True;
  end;
  {$ENDIF}

  With AForm do
  begin
    {$IFNDEF CLX}
    Position:=poDesigned;
    {$ENDIF}
    
    BorderStyle:=TeeFormBorderStyle;
    BorderIcons:=[];
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(ATag);

    Parent:=AParent;

    {$IFNDEF CLX}
    OldVisibleFlag:=Parent.Visible;
    Parent.Visible:=True;
    {$ENDIF}

    Left:=4; { ((AParent.ClientWidth-ClientWidth) div 2); }
    Top:=Math.Min(4,Abs(AParent.ClientHeight-ClientHeight) div 2);

    {$IFDEF CLX}
    Align:=alClient;
    TeeFixParentedForm(AForm);
    {$ENDIF}

    // dont here: TeeTranslateControl(AForm);

    TeeScaleForm(AForm);

    Show;

    {$IFNDEF CLX}
    Parent.Visible:=OldVisibleFlag;
    {$ENDIF}
  end;
end;

{ Utils }
Procedure AddDefaultValueFormats(AItems:TStrings);
begin
  AItems.Add(TeeMsg_DefValueFormat);
  AItems.Add('0');
  AItems.Add('0.0');
  AItems.Add('0.#');
  AItems.Add('#.#');
  AItems.Add('#,##0.00;(#,##0.00)');
  AItems.Add('00e-0');
  AItems.Add('#.0 "x10" E+0');
  AItems.Add('#.# x10E-#');
end;

Procedure TeeLoadArrowBitmaps(AUp,ADown: TBitmap);
begin
  TeeLoadBitmap(AUp,'TeeArrowUp','');
  TeeLoadBitmap(ADown,'TeeArrowDown','');
end;

{ Helper Listbox methods... }
procedure MoveList(Source,Dest:TCustomListBox);
var t:Integer;
begin
  with Source do
  begin
    for t:=0 to Items.Count-1 do
        if Selected[t] then Dest.Items.AddObject(Items[t],Items.Objects[t]);
    t:=0;
    While t<Items.Count do
    begin
      if Selected[t] then Items.Delete(t)
                     else Inc(t);
    end;
  end;
end;

procedure MoveListAll(Source,Dest:TStrings);
var t : Integer;
begin
  With Source do
  for t:=0 to Count-1 do Dest.AddObject(Strings[t],Objects[t]);
  Source.Clear;
end;

{ Routines to support "crTeeHand" cursor type }
Function TeeIdentToCursor(Const AName:String; Var ACursor:Integer):Boolean;
begin
  if AName=TeeMsg_TeeHand then
  begin
    ACursor:=crTeeHand;
    result:=True;
  end
  else result:=IdentToCursor(AName,ACursor);
end;

Const TeeCursorPrefix='cr';

Function TeeSetCursor(ACursor:TCursor; const S:String):TCursor;
var tmpCursor : Integer;
begin
  if TeeIdentToCursor(TeeCursorPrefix+S,tmpCursor) then
     result:=tmpCursor
  else
     result:=ACursor;
end;

Function TeeCursorToIdent(ACursor:Integer; Var AName:String):Boolean;
begin
  if ACursor=crTeeHand then
  begin
    AName:=TeeMsg_TeeHand;
    result:=True;
  end
  else result:=CursorToIdent(ACursor,AName);
end;

type
  TTempCursors=class
  private
    FCombo : TComboFlat;
    procedure ProcGetCursors(const S: string);
  end;

Function DeleteCursorPrefix(Const S:String):String;
begin
  result:=S;
  if Copy(result,1,2)=TeeCursorPrefix then Delete(result,1,2);
end;

procedure TTempCursors.ProcGetCursors(const S: string);
begin
  FCombo.Items.Add(DeleteCursorPrefix(S));
end;

procedure TeeFillCursors(ACombo:TComboFlat; ACursor:TCursor);
var tmp   : TTempCursors;
    tmpSt : String;
begin
  With ACombo do
  begin
    Items.BeginUpdate;
    Clear;

//  Sorted:=True;  6.02, breaks new "Tree mode" chart editor
//  Set Sorted to True at design-time in forms, not here.

    tmp:=TTempCursors.Create;
    try
      tmp.FCombo:=ACombo;
      GetCursorValues(tmp.ProcGetCursors);
      tmp.ProcGetCursors(TeeMsg_TeeHand);
    finally
      tmp.Free;
    end;

    Items.EndUpdate;

    if TeeCursorToIdent(ACursor,tmpSt) then
       ItemIndex:=Items.IndexOf(DeleteCursorPrefix(tmpSt))
    else
       ItemIndex:=-1;
  end;
end;

procedure TPenDialog.FormDestroy(Sender: TObject);
begin
  BackupPen.Free;
end;

procedure TeePreviewCursor(ACursor:TCursor; APicture:TPicture);
{$IFNDEF CLX}
var
  tmpCursor : {$IFDEF CLX}QCursorH{$ELSE}THandle{$ENDIF};
  tmpBitmap : TBitmap;
{$ENDIF}
begin
  {$IFNDEF CLX}
  tmpCursor:=Screen.Cursors[ACursor];

  if tmpCursor<>0 then
  begin
    tmpBitmap:=TBitmap.Create;
    try
      TeeSetBitmapSize(tmpBitmap,GetSystemMetrics(SM_CXCURSOR),
                                 GetSystemMetrics(SM_CYCURSOR));

      DrawIconEx(tmpBitmap.Canvas.Handle,0,0,tmpCursor,
                 0,0,0,0,DI_NORMAL or DI_DEFAULTSIZE);
      APicture.Graphic:=tmpBitmap;
    finally
      tmpBitmap.Free;
    end;
  end
  else
    APicture.Graphic:=nil;
  {$ENDIF}
end;

// Scales AForm PixelsPerInch to match it's Parent Form, if any
procedure TeeScaleForm(AForm:TForm);

  function GetFirstParentForm(Control:TControl):TCustomForm;
  begin
    result:=nil;

    while Assigned(Control.Parent) do
    begin
      Control:=Control.Parent;

      if Control is TCustomForm then
      begin
        result:=TCustomForm(Control);
        break;
      end;
    end;
  end;

var tmpForm : TCustomForm;
begin
  tmpForm:=GetFirstParentForm(AForm);

  if Assigned(tmpForm) and (tmpForm is TForm) and
     (TForm(tmpForm).PixelsPerInch<>AForm.PixelsPerInch) then
  begin
    {$IFNDEF LCL} // No ScaleBy method in LCL

    AForm.ScaleBy(TForm(tmpForm).PixelsPerInch,AForm.PixelsPerInch);

    {$ENDIF}

    AForm.PixelsPerInch:=TForm(tmpForm).PixelsPerInch;
  end;
end;

procedure TPenDialog.ESpaceChange(Sender: TObject);
begin
  if Showing and (ThePen is TChartPen) then
  begin
    TChartPen(ThePen).SmallSpace:=UDSpace.Position;
    ModifiedPen:=True;
  end;
end;

end.
