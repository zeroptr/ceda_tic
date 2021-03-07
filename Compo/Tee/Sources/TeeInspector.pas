{**********************************************}
{   TeeChart Office / TeeTree                  }
{   Inspector object.                          }
{   Copyright (c) 2001-2009 by David Berneda   }
{**********************************************}
unit TeeInspector;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     {$IFDEF CLX}
     QGrids, QGraphics, QStdCtrls, QMenus, QForms, QControls, Qt,
     {$ELSE}
     Grids, Graphics, Controls, Forms, StdCtrls, Menus,
     {$ENDIF}

     {$IFDEF D6}
     Variants,
     {$ENDIF}
     {$IFDEF LCL}
     Variants,
     TeeTranslate, // <-- due to StripHotKey function
     {$ENDIF}

     Classes, SysUtils, TeCanvas, TeeProcs;

type
  TInspectorItemStyle=( iiBoolean, iiString, iiSelection, iiColor, iiPen,
                        iiGradient, iiBrush, iiFont, iiImage, iiButton,
                        iiInteger, iiDouble );

  TInspectorItem=class;

  TGetItemProc=procedure(Const S:String; AObject:TObject=nil) of object;
  TGetInspectorItems=procedure(Sender:TInspectorItem; Proc:TGetItemProc) of object;
  TGetItemIndex=procedure(Sender:TInspectorItem; var Index:Integer) of object;
  TSetItemIndex=procedure(Sender:TInspectorItem; Index:Integer) of object;

  TTeeInspector=class;

  TInspectorItem=class(TCollectionItem)
  private
    FCaption  : String;
    FData     : TObject;
    FEnabled  : Boolean;
    FExpanded : Boolean;
    FOwner    : TObject;
    FStyle    : TInspectorItemStyle;
    FValue    : Variant;
    FVisible  : Boolean;

    IData     : TObject;
    IParent   : TInspectorItem;

    FOnChange   : TNotifyEvent;
    FOnGetItemIndex : TGetItemIndex;
    FOnGetItems : TGetInspectorItems;
    FOnSetItemIndex : TSetItemIndex;

    Procedure Changed;
    Procedure RebuildInspector;
    procedure SetCaption(const Value: String);
    procedure SetVisible(const Value: Boolean);
    procedure SetValue(const Value: Variant);
    procedure SetData(const Value: TObject);
    procedure SetStyle(const Value: TInspectorItemStyle);
  protected
    procedure FillItems(Items:TStrings);
    function GetSelectedIndex(Items:TStrings):Integer; virtual;
    Function StyleToInt:Integer;
  public
    Constructor Create(Collection:TCollection); override;
    Function Inspector:TTeeInspector;

    property Data:TObject read FData write SetData;
    property Owner:TObject read FOwner write FOwner;
    property Parent:TInspectorItem read IParent write IParent;

    {$IFDEF LCL}  // Published Variants not supported by FPC
    property Value:Variant read FValue write SetValue;
    {$ENDIF}
  published
    property Caption:String read FCaption write SetCaption;
    property Enabled:Boolean read FEnabled write FEnabled default True;

    property Expanded:Boolean read FExpanded write FExpanded;

    property Style:TInspectorItemStyle read FStyle write SetStyle default iiBoolean;

    {$IFNDEF LCL}  // Published Variants not supported by FPC
    property Value:Variant read FValue write SetValue;
    {$ENDIF}

    property Visible:Boolean read FVisible write SetVisible default True;

    property OnChange:TNotifyEvent read FOnChange write FOnChange;
    property OnGetItemIndex:TGetItemIndex read FOnGetItemIndex write FOnGetItemIndex;
    property OnGetItems:TGetInspectorItems read FOnGetItems write FOnGetItems;
    property OnSetItemIndex:TSetItemIndex read FOnSetItemIndex write FOnSetItemIndex;
  end;

  TInspectorItems=class(TOwnedCollection)
  private
    Function Get(Index:Integer):TInspectorItem;
    Procedure Put(Index:Integer; Const Value:TInspectorItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    Inspector : TTeeInspector;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  AData:TObject):TInspectorItem; overload;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  AData:TObject; AOnChange:TNotifyEvent):TInspectorItem; overload;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  AOnChange:TNotifyEvent):TInspectorItem; overload;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  InitialValue:Variant; AOnChange:TNotifyEvent):TInspectorItem; overload;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  InitialValue:Variant):TInspectorItem; overload;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  InitialValue:Variant; AData:TObject;
                  AOnChange:TNotifyEvent):TInspectorItem; overload;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  InitialValue:Variant; AData:TObject):TInspectorItem; overload;

    property Item[Index:Integer]:TInspectorItem read Get write Put; default;
  end;

  TComboFlatGrid=class(TComboFlat)
  {$IFNDEF CLX}
  private
    {$IFNDEF CLR}
    {$IFNDEF LCL}
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    {$ENDIF}
    {$ENDIF}
  {$ELSE}
  protected
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
  {$ENDIF}
  end;

  TEditGrid=class(TEdit)
  {$IFNDEF CLX}
  private
    {$IFNDEF CLR}
    {$IFNDEF LCL}
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    {$ENDIF}
    {$ENDIF}
  {$ELSE}
  protected
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
  {$ENDIF}
  end;

  TInspectorHeader=class(TPersistent)
  private
    FFont    : TFont;
    FVisible : Boolean;
    Procedure CanvasChanged(Sender:TObject);
    procedure SetFont(const Value: TFont);
    procedure SetVisible(const Value: Boolean);
  public
    Inspector : TTeeInspector;
    Constructor Create;
    Destructor Destroy; override;

    Procedure Update;
  published
    property Font:TFont read FFont write SetFont;
    property Visible:Boolean read FVisible write SetVisible default True;
  end;

  TTeeInspector=class(TStringGrid)
  private
    FHeader    : TInspectorHeader;
    FItems     : TInspectorItems;
    FOnExpandCollapse : TNotifyEvent;

    IComboGrid : TComboFlatGrid;
    IEditGrid  : TEditGrid;

    function CanDrawEllipsi(ARow:Integer):Boolean;
    Function CellType(ARow:Integer):Integer;
    function ClickedCross(X,Y:Integer):Integer;
    procedure ComboChange(Sender: TObject);
    procedure ComboKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    Procedure CreateCombo;
    Procedure CreateEdit;
    procedure DrawCross(const R:TRect; Plus:Boolean);
    procedure EditChange(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ExpandCollapse(ARow:Integer);
    Procedure HideCombos;
    procedure InternalSetHeader;
    function ItemCrossRect(const R:TRect):TRect;
    function ItemOffset(ARow:Integer):Integer;
    Function MinRow:Integer;
    Procedure SetComboIndex;
    procedure SetHeader(Const Value:TInspectorHeader);
    Procedure SetItems(const Value:TInspectorItems);
    Function ValidRow(ARow:Integer):Boolean;
  protected
    procedure AddComboItem(Const S:String; AObject:TObject);

    {$IFNDEF CLX}
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    {$ENDIF}

    procedure DrawCell(ACol, ARow: Integer; ARect: TRect;
      AState: TGridDrawState); override;
    Procedure DoPositionCombos(WhenVisible:Boolean);
    Function Item(ARow:Integer):TInspectorItem;
    function ItemExpandable(ARow:Integer):Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                      X, Y: Integer); override;
    function RecalcRowCount:Integer; // 7.02
    procedure Resize; override;
    function SelectCell(ACol, ARow: Integer): Boolean; override;
    {$IFDEF CLX}
    Procedure SetParent(const Value: TWidgetControl); override;
    {$ELSE}
    Procedure SetParent(AParent: TWinControl); override;
    {$ENDIF}
    procedure TopLeftChanged; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure Clear;
    procedure Rebuild;
    Procedure SetProperties(const AMenu:TPopupMenu);

    property OnExpandCollapse:TNotifyEvent read FOnExpandCollapse
                                           write FOnExpandCollapse;
  published
    property Items:TInspectorItems read FItems write SetItems;
    property Color default clBtnFace;
    property ColCount default 2;
    property DefaultColWidth default 82;
    property DefaultRowHeight default 19;
    property FixedCols default 0;
    property GridLineWidth default 0;
    property RowCount default 1;
    property Header:TInspectorHeader read FHeader write SetHeader;
    {$IFDEF CLX}
    property ScrollBars default ssAutoBoth;
    {$ENDIF}
  end;

implementation

Uses
  TeeConst, TeePenDlg, Math, TeeEdiGrad, TeeBrushDlg, TeeEdiFont, TeeBackImage;

{$IFNDEF D6}
function VarIsStr(const Value:Variant):Boolean;
var tmp : Word;
begin
  tmp:=TVarData(Value).VType; 
  result:=(tmp = varOleStr) or (tmp = varString);
end;
{$ENDIF}

{ TInspectorItems }
procedure TInspectorItem.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

constructor TInspectorItem.Create(Collection: TCollection);
begin
  inherited;
  FVisible:=True;
  FEnabled:=True;
  if csDesigning in Inspector.ComponentState then
     RebuildInspector;
end;

Procedure TInspectorItem.RebuildInspector;
begin
  if not (csLoading in Inspector.ComponentState) then
     Inspector.Rebuild;
end;

Function TInspectorItem.Inspector:TTeeInspector;
begin
  result:=TInspectorItems(Collection).Inspector;
end;

procedure TInspectorItem.SetCaption(const Value: String);
begin
  if FCaption<>Value then
  begin
    FCaption:=Value;
    RebuildInspector;
  end;
end;

procedure TInspectorItem.SetData(const Value: TObject);
begin
  if FData<>Value then
  begin
    FData:=Value;

    if Style=iiSelection then
    with Inspector do
         if Item(Row)=Self then
         begin
           SetComboIndex;
           Self.Value:=IComboGrid.CurrentItem;
         end;
  end;
end;

procedure TInspectorItem.SetValue(const Value: Variant);
begin
  FValue:=Value;
  Inspector.Invalidate;
end;

procedure TInspectorItem.SetVisible(const Value: Boolean);
begin
  if FVisible<>Value then
  begin
    FVisible:=Value;
    RebuildInspector;
  end;
end;

Function TInspectorItem.StyleToInt:Integer;
begin
  case FStyle of
    iiButton    : result:=0;
    iiBoolean   : result:=1;
    iiPen       : result:=3;
    iiGradient  : result:=4;
    iiColor     : result:=2;
    iiInteger,
    iiDouble,
    iiString    : result:=10;
    iiSelection : result:=0;
    iiFont      : result:=7;
    iiImage     : result:=8;
    iiBrush     : result:=9;
  else
    result:=-1;
  end;
end;

{ TInspectorItems }
Function TInspectorItems.Get(Index:Integer):TInspectorItem;
begin
  result:=TInspectorItem(inherited Items[Index]);
end;

Procedure TInspectorItems.Put(Index:Integer; Const Value:TInspectorItem);
begin
  inherited Items[Index]:=Value;
end;

Function TInspectorItems.Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                              InitialValue:Variant; AData:TObject):TInspectorItem;
var c : TNotifyEvent;
begin
  c:=nil;
  result:=Add(AStyle,ACaption,InitialValue,AData,c);
end;

Function TInspectorItems.Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                              AData:TObject):TInspectorItem;
var c : TNotifyEvent;
begin
  c:=nil;
  result:=Add(AStyle,ACaption,{$IFDEF CLR}varNull{$ELSE}vaNull{$ENDIF},AData,c);
end;

Function TInspectorItems.Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                              AData:TObject; AOnChange:TNotifyEvent):TInspectorItem;
begin
  result:=Add(AStyle,ACaption,{$IFDEF CLR}varNull{$ELSE}vaNull{$ENDIF},AData,AOnChange);
end;

Function TInspectorItems.Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                              AOnChange:TNotifyEvent):TInspectorItem;
begin
  result:=Add(AStyle,ACaption,{$IFDEF CLR}varNull{$ELSE}vaNull{$ENDIF},nil,AOnChange);
end;

Function TInspectorItems.Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                              InitialValue:Variant; AOnChange:TNotifyEvent):TInspectorItem;
begin
  result:=Add(AStyle,ACaption,InitialValue,nil,AOnChange);
end;

Function TInspectorItems.Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                               InitialValue:Variant):TInspectorItem;
var c : TNotifyEvent;
begin
  c:=nil;
  result:=Add(AStyle,ACaption,InitialValue,nil,c);
end;

Function TInspectorItems.Add(AStyle:TInspectorItemStyle; Const ACaption:String;
                              InitialValue:Variant; AData:TObject;
                              AOnChange:TNotifyEvent):TInspectorItem;
begin
  result:=TInspectorItem(inherited Add);

  with result do
  begin
    FStyle:=AStyle;
    FCaption:=ACaption;
    FValue:=InitialValue;
    FData:=AData;
    FOnChange:=AOnChange;
  end;

  with Inspector do
  begin
    RecalcRowCount;
    Cells[0,RowCount-1]:=ACaption;
    Objects[0,RowCount-1]:=result;
  end;
end;

procedure TInspectorItems.Update(Item: TCollectionItem);
begin
  if not (csLoading in Inspector.ComponentState) then
     Inspector.Rebuild;
end;

{ TTeeInspector }
Constructor TTeeInspector.Create(AOwner:TComponent);
begin
  inherited;

  FHeader:=TInspectorHeader.Create;
  FHeader.Inspector:=Self;
  FHeader.Font.Color:=clNavy;

  FItems:=TInspectorItems.Create(Self,TInspectorItem);
  FItems.Inspector:=Self;

  Color:=clBtnFace;
  ColCount:=2;
  DefaultColWidth:=82;
  DefaultRowHeight:=19;

  FixedCols:=0;
  RowCount:=1;
  GridLineWidth:=0;
  Options:=[goFixedVertLine, goVertLine, goHorzLine, goColSizing, goThumbTracking];

  {$IFDEF CLX}
  ScrollBars:=ssAutoBoth;
  {$ENDIF}

  Header.Update;

  CreateCombo;
  CreateEdit;

  {$IFDEF D9}  // Delphi 2005,2006,2007,...
  if (SysLocale.PriLangID=LANG_JAPANESE) then
  begin
     Font.Name:=TeCanvas.GetDefaultFontName;
     Font.Size:=TeCanvas.GetDefaultFontSize;
  end;
  {$ENDIF}
end;

Destructor TTeeInspector.Destroy;
begin
  FItems.Free;
  FHeader.Free;
  inherited;
end;

Procedure TTeeInspector.SetItems(const Value:TInspectorItems);
begin
  FItems.Assign(Value);
end;

procedure TTeeInspector.SetHeader(Const Value:TInspectorHeader);
begin
  FHeader.Assign(Value);
end;

Procedure TTeeInspector.InternalSetHeader;
begin { set header cells text }
  if Header.Visible then
  begin
    Cells[0,0]:=TeeMsg_Property;
    Cells[1,0]:=TeeMsg_Value;
  end
  else Rows[0].Clear;
end;

Procedure TTeeInspector.CreateEdit;
begin { create edit box }
  IEditGrid:=TEditGrid.Create(Self);

  with IEditGrid do
  begin
    Name:='IEditGrid'; // Do not localize
    Visible:=False;

    {$IFNDEF CLX}
    {$IFNDEF LCL}
    BevelInner:=bvNone;
    BevelKind:=bkFlat;
    {$ENDIF}
    {$ENDIF}

    BorderStyle:=bsNone;

    OnChange:=Self.EditChange;
    OnKeyDown:=Self.EditKeyDown;
  end;
end;

Procedure TTeeInspector.SetComboIndex;
begin
  Item(Row).FillItems(IComboGrid.Items);
  IComboGrid.ItemIndex:=Item(Row).GetSelectedIndex(IComboGrid.Items);
end;

// Create combobox
Procedure TTeeInspector.CreateCombo;
begin
  IComboGrid:=TComboFlatGrid.Create(Self);

  with IComboGrid do
  begin
    Name:='IComboGrid'; // Do not localize

    Style:=csDropDownList;
    DropDownCount:=12;
    ItemHeight:=21;
    Visible:=False;

    OnChange:=Self.ComboChange;
    IComboGrid.OnKeyDown:=Self.ComboKeyDown;
  end;
end;

Procedure TTeeInspector.Resize;
begin
  inherited;

  if ColCount>0 then
     {$IFDEF CLX}
     if (not Assigned(Owner)) or (not (csReading in Owner.ComponentState)) then
        if Assigned(Parent) then
     {$ENDIF}
        ColWidths[1]:=ClientWidth-ColWidths[0];

  // resize combobox width (if visible)
  DoPositionCombos(True);

  {$IFNDEF LCL} // Same method in LCL does a different thing
  if (Row=0) and (RowCount>MinRow) then
     MoveColRow(1,MinRow,True,True);
  {$ENDIF}
end;

{$IFDEF CLX}
Procedure TTeeInspector.SetParent(const Value: TWinControl);
{$ELSE}
Procedure TTeeInspector.SetParent(AParent: TWinControl);
{$ENDIF}
begin
  inherited;

  if (not (csDestroying in ComponentState)) and
     (not (csDesigning in ComponentState)) then
  begin
    IComboGrid.Parent:=Parent;
    IEditGrid.Parent:=Parent;
  end;
end;

procedure TTeeInspector.ComboKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
 TeeKey_Escape: begin
                  HideCombos;
                  SetFocus;
                end;
  end;
end;

procedure TTeeInspector.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
 TeeKey_Escape,
 TeeKey_Return: begin
                  HideCombos;
                  SetFocus;
                end;
     TeeKey_Up: begin
                  HideCombos;
                  SetFocus;
                  if Row>=MinRow then Row:=Row-1;
                end;
   TeeKey_Down: begin
                  HideCombos;
                  SetFocus;
                  if Row<RowCount-1 then Row:=Row+1;
                end;
  end;
end;

Function TTeeInspector.Item(ARow:Integer):TInspectorItem;
begin
  result:=TInspectorItem(Objects[0,ARow]);
end;

procedure TTeeInspector.EditChange(Sender: TObject);
begin { the inspector edit box has changed }
  with Item(Row) do
  begin
    if Style=iiString then
       Value:=IEditGrid.Text
    else
    if Style=iiInteger then
       Value:=StrToIntDef(IEditGrid.Text,Value)
    else
    if Style=iiDouble then
       Value:=StrToFloatDef(IEditGrid.Text,Value); // 8.01 TV52012259

    Changed;
  end;
end;

procedure TTeeInspector.ComboChange(Sender: TObject);
var tmpItem : TMenuItem;
begin { the inspector combobox has changed, select subitem }
  if IComboGrid.Tag {$IFDEF CLR}<>nil{$ELSE}<>0{$ENDIF} then
  begin
    tmpItem:=TMenuItem(IComboGrid.Tag).Items[IComboGrid.ItemIndex];
    tmpItem.Checked:=True;

    if Assigned(tmpItem.OnClick) then
       tmpItem.OnClick(tmpItem);
  end
  else
  with Item(Row) do
  begin
    if Assigned(FOnSetItemIndex) then
       FOnSetItemIndex(Item(Row),IComboGrid.ItemIndex)
    else
    begin
      Value:=IComboGrid.CurrentItem;
      Data:=IComboGrid.SelectedObject;
    end;

    Changed;
  end;
end;

Procedure TTeeInspector.Clear;
begin
  Items.Clear;
  HideCombos;
end;

// A Menu can be used to fill the Inspector.

Procedure TTeeInspector.SetProperties(const AMenu:TPopupMenu);
var t     : Integer;
    tmpSt : String;
    tmp   : Integer;
    tmp2  : Integer;
    tmpInspectorItem : TInspectorItem;
    tmpEllipsi : Boolean;
begin { set properties at inspector, if any }

  HideCombos;

  Items.Clear;

  tmp:=0;

  if Assigned(AMenu) then
  with AMenu do
  begin
    { call OnPopup to prepare items }
    if Assigned(OnPopup) then OnPopup(AMenu);

    RowCount:=Items.Count;

    { fill properties... }
    for t:=0 to Items.Count-1 do
    begin
      if {$IFDEF D5}(not Items[t].IsLine){$ELSE}(Items[t].Caption<>'-'){$ENDIF} // Do not localize
         and (Items[t].Enabled)
         and (Items[t].HelpContext<>5) then { 5 means "dont put at inspector" }
      begin
        tmpSt:=StripHotkey(Items[t].Caption);

        tmpEllipsi:=Copy(tmpSt,Length(tmpSt)-2,3)='...'; // Do not localize

        { remove trailing ellipsi "..." }
        if tmpEllipsi then
           While tmpSt[Length(tmpSt)]='.' do // Do not localize
                 Delete(tmpSt,Length(tmpSt),1);

        Inc(tmp);

        tmpInspectorItem:=TInspectorItem(Self.Items.Add);

        with tmpInspectorItem do
        begin
          Caption:=tmpSt;
          Data:=TObject(AMenu.Items[t].Tag);
          IData:=AMenu.Items[t];

          if Header.Visible then tmp2:=tmp
                            else tmp2:=tmp-1;

          if Items[t].Count>0 then
             Style:=iiSelection
          else
          (*
          // Problem here: Cannot set automatic style due to TeeChartOffice
          // duplication of click event (menuitem and inspector ellipsi)
          case CellType(tmp2) of
            3: Style:=iiPen;
            4: Style:=iiGradient;
            7: Style:=iiFont;
            9: Style:=iiBrush;
          else
          *)
            if tmpEllipsi then
               Style:=iiButton;
          //end;
        end;

        Cells[0,tmp2]:=tmpSt;
        Objects[1,tmp2]:=tmpInspectorItem;
      end;
    end;
  end;

  if Header.Visible then RowCount:=tmp+1
                    else RowCount:=tmp;

  { enable / disable inspector }
  Enabled:=Assigned(AMenu);

  { resize grid column }
  ColWidths[1]:=ClientWidth-ColWidths[0];
end;

function TTeeInspector.ItemOffset(ARow:Integer):Integer;
var tmp : TInspectorItem;
begin
  result:=0;

  tmp:=Item(ARow).Parent;

  while Assigned(tmp) do
  begin
    Inc(result,16);
    tmp:=tmp.Parent;
  end;
end;

function TTeeInspector.CanDrawEllipsi(ARow:Integer):Boolean;
begin
  with Item(ARow) do
    result:=((Style=iiColor) or (Style=iiGradient) or (Style=iiImage) or
             (Style=iiPen) or (Style=iiBrush) or (Style=iiFont))
            or
            (
            (Style<>iiSelection) and
            (Style<>iiString) and
            (Style<>iiInteger) and
            (Style<>iiDouble) and
            ((Style=iiButton) and (Assigned(FOnChange)))
            );
end;

{ returns the type of the cell if it points to a menu item }
Function TTeeInspector.CellType(ARow:Integer):Integer;
var tmp : TInspectorItem;
begin
  result:= -1;

  tmp:=Item(ARow);

  if Assigned(tmp) then
    if Assigned(tmp.IData) then
    begin
      if tmp.IData is TMenuItem then
         result:=(tmp.IData as TMenuItem).HelpContext
    end
    else
      result:=tmp.StyleToInt;
end;

const
  TeeInspectorButtonSize=16;

procedure TTeeInspector.DrawCell(ACol, ARow: Integer; ARect: TRect;
                                       AState: TGridDrawState);

  Function BooleanCell(ARow:Integer):Boolean;
  var tmp : TObject;
  begin { returns True if the inspector cell (menu item) is True }
    result:=False;
    tmp:=Item(ARow).IData;

    if Assigned(tmp) then
    begin
      if tmp is TMenuItem then
         result:=(tmp as TMenuItem).Checked;
    end
    else result:=Item(ARow).Value;
  end;

  Procedure DrawEllipsis;
  {$IFNDEF CLX}
  var tmpColor : TColor;
  {$ENDIF}
  begin { draw small "ellipsis" buttons }
    with Canvas do
    begin
      {$IFDEF CLX}
      Pen.Color:=clBlack;
      Pen.Style:=psSolid;
      DrawPoint(ARect.Left+4,ARect.Bottom-6);
      DrawPoint(ARect.Left+6,ARect.Bottom-6);
      DrawPoint(ARect.Left+8,ARect.Bottom-6);
      {$ELSE}

      if Self.Enabled and Item(ARow).Enabled then
         tmpColor:=clBlack
      else
         tmpColor:=clDkGray;

      Pen.Handle:=TeeCreatePenSmallDots(tmpColor);

      MoveTo(ARect.Left+4,ARect.Bottom-6);
      LineTo(ARect.Left+10,ARect.Bottom-6);
      {$ENDIF}
    end;
  end;

  Function CurrentItem:TMenuItem;
  begin { returns the Menu Item associated to current grid cell }
    result:=TMenuItem(Item(ARow).IData);
  end;

  Function CurrentItemCount:Integer;
  var tmp : TMenuItem;
  begin
    tmp:=CurrentItem;
    if Assigned(tmp) then result:=tmp.Count
                     else result:=0;
  end;

  Function RectangleItem:TRect;
  begin
    result:=TeeRect(ARect.Right+2,ARect.Top+2,ARect.Right+40,ARect.Bottom-2);
  end;

  Procedure DrawText(Const S:String; LeftPos:Integer=-1; EnableColor:Boolean=True);
  begin
    if LeftPos=-1 then
       LeftPos:=ARect.Right+2;

    if EnableColor then
       if Enabled and Item(ARow).Enabled then
          if (gdSelected in AState) and (not (gdFocused in AState)) then
             Canvas.Font.Color:=clHighlightText
          else
             Canvas.Font.Color:=Font.Color
       else
       if gdSelected in AState then
          Canvas.Font.Color:=clSilver
       else
          Canvas.Font.Color:=clDkGray;

    Canvas.TextOut(LeftPos,ARect.Top,S);
  end;

var tmp       : Integer;
    tmpSt     : String;
    tmpMiddle : Integer;
    tmpCanvas : TTeeCanvas3D;
    tmpGrad   : TCustomTeeGradient;
    tmpFont   : TTeeFont;
    tmpImage  : TPicture;
    tmpItem   : TMenuItem;
    tmpPen    : TChartPen;
    tmpColor  : TColor;
    tmpData   : TObject;
    {$IFDEF CLX}
    QC        : QColorH;
    {$ENDIF}
    tmpBrush  : TChartBrush;
begin { draw checkboxes and buttons at Property Inspector }

  { draw thin dotted grid lines }
  with Canvas do
  begin
    {$IFDEF CLX}
    Start;
    {$ENDIF}

    if goHorzLine in Options then
    begin
      {$IFNDEF CLX}
      Pen.Handle:=TeeCreatePenSmallDots(clDkGray);
      {$ENDIF}

      MoveTo(ARect.Left,ARect.Bottom-1);
      LineTo(ARect.Right-1,ARect.Bottom-1);
    end;
  end;

  if (ARow=0) and Header.Visible then
  begin
    { draw top row text }
    with Canvas do
    begin
      tmpColor:=Font.Color;

      Font.Assign(Header.Font);

      if gdSelected in AState then
         Font.Color:=tmpColor;

      TextOut(ARect.Left+2,ARect.Top+{$IFDEF CLX}2{$ELSE}1{$ENDIF},Cells[ACol,0]);
    end;
  end
  else

  if (ACol=1) and ValidRow(ARow) then { draw value cells }
  with Canvas do
  begin
    { resize rectangle to button / checkbox size }
    Inc(ARect.Left,2);
    Inc(ARect.Top,2);
    Dec(ARect.Bottom,1);
    ARect.Right:=ARect.Left+TeeInspectorButtonSize;

    if CellType(ARow)=2 then { color property }
    begin
      tmpItem:=CurrentItem;

      if Assigned(tmpItem) {$IFDEF CLR}and Assigned(tmpItem.Tag){$ENDIF} then
         Brush.Color:={$IFDEF CLR}Integer{$ELSE}TColor{$ENDIF}(tmpItem.Tag)
      else
         Brush.Color:={$IFDEF CLR}Integer{$ELSE}TColor{$ENDIF}(Item(ARow).Value);

      Pen.Style:=psSolid;
      Pen.Width:=1;

      if Self.Enabled and
         ( (Brush.Color=clBlack) or (Brush.Color=clDkGray) ) then
         Pen.Color:=clWhite
      else
         Pen.Color:=clDkGray;

      Rectangle(ARect.Left,ARect.Top+1,ARect.Right-3,ARect.Bottom-2);

      tmpSt:=ColorToString(Brush.Color);

      if Copy(tmpSt,1,2)='cl' then // Do not localize
         tmpSt:=Copy(tmpSt,3,255);

      Brush.Style:=bsClear;
      DrawText(tmpSt);
    end
    else
    if CellType(ARow)=10 then // String
       DrawText(Item(ARow).Value,ARect.Left)
    else
    begin
      { draw button or check-box }
      if CellType(ARow)=1 then { boolean ? }
      begin
        if Self.Enabled and Item(ARow).Enabled then
           tmpColor:=Color
        else
           tmpColor:=clSilver;

        TeeDrawCheckBox(ARect.Left,ARect.Top,Canvas,BooleanCell(ARow),tmpColor);
      end
      else

      if (CellType(ARow)<>-1) and (CurrentItemCount=0) and
         CanDrawEllipsi(ARow) then
      begin { button }
        {$IFDEF CLX}
        Pen.Style:=psSolid;
        FillRect(ARect);
        {$ELSE}
        Dec(ARect.Bottom);
        Dec(ARect.Right,3);
        tmp:=DFCS_BUTTONPUSH or DFCS_FLAT;
        DrawFrameControl(Handle,ARect,DFC_BUTTON,tmp);
        {$ENDIF}
      end;

      tmpMiddle:=(ARect.Top+ARect.Bottom) div 2;

      case CellType(ARow) of
        0: if (CurrentItemCount=0) and
              (Item(ARow).Style<>iiSelection) then
           begin
             if CanDrawEllipsi(ARow) then
                DrawEllipsis; { button }

              if VarIsStr(Item(ARow).Value) then // TVC52010347
                 DrawText(Item(ARow).Value);
           end
           else
           begin { combobox (submenu items) }

             tmpSt:='';

             if CurrentItem<>nil then
             begin
               for tmp:=0 to CurrentItem.Count-1 do
               begin
                 tmpItem:=CurrentItem.Items[tmp];
                 if tmpItem.RadioItem and tmpItem.Checked then
                 begin
                   tmpSt:=StripHotKey(tmpItem.Caption);
                   break;
                 end;
               end;
             end
             else tmpSt:=Item(ARow).Value;

             if tmpSt<>'' then
                DrawText(tmpSt,ARect.Left);
           end;

        1: { boolean }
           begin
             { draw Yes/No }
             if BooleanCell(ARow) then tmpSt:=TeeMsg_Yes
                                  else tmpSt:=TeeMsg_No;
             DrawText(StripHotKey(tmpSt));
           end;

        3: begin { pen }
             DrawEllipsis;
             tmpPen:=TChartPen(Item(ARow).Data);

             if Assigned(tmpPen) then
             begin
               TeeSetTeePen(Pen,tmpPen,tmpPen.Color,Handle);

               MoveTo(ARect.Right+tmpPen.Width+1,tmpMiddle);
               LineTo(ARect.Right+30,tmpMiddle);
             end;
           end;

       4: begin { gradient }
            DrawEllipsis;
            tmpGrad:=TCustomTeeGradient(Item(ARow).Data);

            if Assigned(tmpGrad) then
            if tmpGrad.Visible then
            begin
              tmpCanvas:=TTeeCanvas3D.Create;
              try
                tmpCanvas.ReferenceCanvas:=Canvas;
                tmpGrad.Draw(tmpCanvas,RectangleItem);
              finally
                tmpCanvas.Free;
                {$IFDEF CLX}
                with Canvas.Brush do
                begin
                  QC:=QColor(clBtnFace);
                  try
                    QBrush_setColor(Handle, QC);
                  finally
                    QColor_destroy(QC);
                  end;
                end;
                {$ENDIF}
              end;
            end
            else DrawText(TeeMsg_None);
          end;

       6: begin { integer }
            // IntToStr(CurrentItem.HelpContext)

            DrawText(Item(ARow).Value);
          end;

       7: begin { font }
            DrawEllipsis;
            tmpFont:=TTeeFont(Item(ARow).Data);

            if Assigned(tmpFont) then
            with tmpFont do
            begin
              if Self.Enabled and Item(ARow).Enabled then
                 Font.Color:=Color
              else
                 Font.Color:=clDkGray;

              Font.Name:=Name;
              Font.Style:=Style;
            end
            else
              Font.Color:=clDkGray;

            DrawText(Font.Name,-1,False);
          end;

       8: begin { image }
            DrawEllipsis;

            tmpImage:=TPicture(Item(ARow).Data);

            if Assigned(tmpImage) and Assigned(tmpImage.Graphic) then
               tmpSt:=TeeMsg_Image
            else
               tmpSt:=TeeMsg_None;

            DrawText(tmpSt);
          end;

       9: begin { pattern brush }
            DrawEllipsis;

            tmpData:=Item(ARow).Data;

            if Assigned(tmpData) then
            begin
              tmpBrush:=TChartBrush(tmpData);

              if Assigned(tmpBrush.Image.Graphic) then
                 Brush.Bitmap:=tmpBrush.Image.Bitmap
              else
                 Brush.Assign(tmpBrush);
            end;

            {$IFNDEF CLX}
            if (CurrentItem<>nil) then
               SetBkColor(Handle,ColorToRGB(StrToInt(CurrentItem.Hint)));  // 6.01
            {$ENDIF}

            FillRect(RectangleItem);
            Brush.Style:=bsSolid;

            {$IFNDEF CLX}
            if (CurrentItem<>nil) then
               SetBkColor(Handle,ColorToRGB(Self.Color));  // 6.01
            {$ENDIF}
          end;
      end;
    end;

  end
  else
  if (ACol=0) and ValidRow(ARow) then { draw caption cells }
  begin
    Inc(ARect.Left,ItemOffset(ARow));
    Canvas.TextOut(ARect.Left+16,ARect.Top+2,Cells[ACol,ARow]);

    if ItemExpandable(ARow) then
       DrawCross(ItemCrossRect(ARect),not Item(ARow).Expanded);
  end
  else inherited;

  {$IFDEF CLX}
  Canvas.Stop;
  {$ENDIF}
end;

function TTeeInspector.ItemExpandable(ARow:Integer):Boolean;
var tmp : TInspectorItem;
begin
  tmp:=Item(ARow);

  result:=Assigned(tmp) and
          ((tmp.Style=iiBrush) or (tmp.Style=iiPen) or
           (tmp.Style=iiGradient) or (tmp.Style=iiImage) or (tmp.Style=iiFont));
end;

function TTeeInspector.ItemCrossRect(const R:TRect):TRect;
var tmp : Integer;
begin
  tmp:=R.Left+16;
  result:=TeeRect(tmp-13,R.Top+3,tmp-2,R.Top+14);
end;

procedure TTeeInspector.DrawCross(const R:TRect; Plus:Boolean);
var tmp : Integer;
begin
  with Canvas do
  begin
    Brush.Style:=bsSolid;
    Brush.Color:=clWhite;
    Pen.Color:=clDkGray;
    Pen.Width:=1;
    Pen.Style:=psSolid;

    {$IFDEF D5}
    Rectangle(R);
    {$ELSE}
    Rectangle(R.Left,R.Top,R.Right,R.Bottom);
    {$ENDIF}

    tmp:=R.Top+5;
    MoveTo(R.Left+3,tmp);
    LineTo(R.Left+8,tmp);

    if Plus then
    begin
      tmp:=R.Left+5;
      MoveTo(tmp,R.Top+3);
      LineTo(tmp,R.Top+8);
    end;

  end;
end;

procedure TTeeInspector.AddComboItem(Const S:String; AObject:TObject);
begin
  IComboGrid.Items.AddObject(S,AObject);
end;

{$IFNDEF CLX}
procedure TTeeInspector.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;
{$ENDIF}

Procedure TTeeInspector.HideCombos;
begin
  { remove previous combobox, if any }
  if Assigned(IComboGrid) then IComboGrid.Hide;

  { remove previous edit box, if any }
  if Assigned(IEditGrid) then IEditGrid.Hide;
end;

function TTeeInspector.RecalcRowCount:Integer;
var t : Integer;
begin
  result:=0;

  for t:=0 to Items.Count-1 do
      if Items[t].Visible then Inc(result);
  RowCount:=Math.Max(1,result);

  if Header.Visible then
  begin
    result:=1;
    if Items.Count>0 then
       RowCount:=RowCount+1;
  end
  else
    result:=0;

  if Header.Visible and (RowCount>1) then
     FixedRows:=1;
end;

// Reload grid cells with Visible Items
procedure TTeeInspector.Rebuild;
var t   : Integer;
    tmp : Integer;
begin
  tmp:=RecalcRowCount;

  for t:=0 to Items.Count-1 do
  if Items[t].Visible then
  begin
    Cells[0,tmp]:=Items[t].Caption;
    Objects[0,tmp]:=Items[t];
    Inc(tmp);
  end;
end;

procedure TTeeInspector.Loaded;
begin
  inherited;
  Rebuild;

  {$IFNDEF LCL} // Same method in LCL does a different thing
  if RowCount>MinRow then MoveColRow(1,MinRow,True,True);
  {$ENDIF}
end;

Function TTeeInspector.MinRow:Integer;
begin
  if Assigned(FHeader) and Header.Visible then result:=1
                                          else result:=0;
end;

procedure TTeeInspector.ExpandCollapse(ARow:Integer);
begin
  if Assigned(FOnExpandCollapse) then
     FOnExpandCollapse(Item(ARow));
end;

function TTeeInspector.ClickedCross(X,Y:Integer):Integer;
var tmpR : TRect;
    t    : Integer;
begin
  result:=-1;

  for t:=0 to RowCount-1 do
  if ItemExpandable(t) then
  begin
    tmpR:=CellRect(0,t);
    Inc(tmpR.Left,ItemOffset(t));
    tmpR:=ItemCrossRect(tmpR);

    if PointInRect(tmpR,X,Y) then
    begin
      result:=t;
      break;
    end;
  end;
end;

procedure TTeeInspector.MouseDown(Button: TMouseButton; Shift: TShiftState;
                                          X, Y: Integer);
var tmp     : TObject;
    tmpR    : TRect;
    t       : Integer;
    tmpItem : TInspectorItem;
    tmpChanged : Boolean;
    tmpColor   : TColor;
begin { execute the inspector property (menu item associated) }

  inherited;

  t:=ClickedCross(X,Y);

  if t<>-1 then
     ExpandCollapse(t)
  else
  if Enabled and (Col=1) and ValidRow(Row) then { clicked at column 1? }
  begin
    HideCombos;

    { calculate rectangle for button or checkbox }
    tmpR:=CellRect(Col,Row);

    { cell contains selection of items? }

    tmpItem:=Item(Row);

    if Assigned(tmpItem) and Enabled then
    begin

      if (tmpItem.Style=iiString) or (tmpItem.Style=iiInteger) or
         (tmpItem.Style=iiDouble) then
      begin
        with IEditGrid do
        begin
          { set Edit box position and size }
          DoPositionCombos(False);
          Text:={$IFDEF LCL}VarToStr({$ENDIF}Self.Item(Row).Value{$IFDEF LCL}){$ENDIF};
          Show;
          SetFocus;
        end;
      end
      else

      if tmpItem.Style=iiSelection then
      begin
        { create combobox }
        with IComboGrid do
        begin
          tmp:=tmpItem.IData;

          Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(tmp); { menu item }

          { set ComboBox position and size }
          DoPositionCombos(False);

          { fill combobox and select item }
          Items.Clear;

          if Assigned(tmp) and (tmp is TMenuItem) then
          begin
            with TMenuItem(tmp) do
            for t:=0 to Count-1 do
            if Items[t].RadioItem then
            begin
              IComboGrid.Items.Add(StripHotKey(Items[t].Caption));
              if Items[t].Checked then
                 ItemIndex:=t;
            end;
          end
          else
          begin
            with Self.Item(Row) do
            if Assigned(FOnGetItems) then
            begin
              FOnGetItems(tmpItem,AddComboItem);
              SetComboIndex;
            end
            else ItemIndex:=-1;
          end;

          Show;
          SetFocus;
        end;
      end;

      tmpR.Right:=tmpR.Left+TeeInspectorButtonSize;

      { clicked on ellipsis rectangle? }
      if PointInRect(tmpR,X,Y) then
      begin
        if tmpItem.Enabled then
        begin
          tmpChanged:=False;

          Case tmpItem.Style of
          iiBoolean: begin
                       if tmpItem.Value{$IFDEF CLR}=True{$ENDIF}{$IFDEF LCL}=True{$ENDIF} then
                          tmpItem.Value:=False
                       else
                          tmpItem.Value:=True;

                       tmpChanged:=True;
                     end;

            iiColor: begin
                       tmpColor:={$IFDEF CLR}TColor{$ENDIF}(tmpItem.Value);

                       tmpChanged:=EditColorDialog(Self,tmpColor);

                       if tmpChanged then
                          tmpItem.Value:=tmpColor;
                     end;

             iiFont: if tmpItem.Data is TTeeFont then
                        tmpChanged:=EditTeeFontEx(Self,TTeeFont(tmpItem.Data))
                     else
                        tmpChanged:=EditTeeFont(Self,TTeeFont(tmpItem.Data));

              iiPen: tmpChanged:=EditChartPen(Self,TChartPen(tmpItem.Data));
            iiBrush: tmpChanged:=EditChartBrush(Self,TChartBrush(tmpItem.Data));
         iiGradient: tmpChanged:=EditTeeGradient(Self,TCustomTeeGradient(tmpItem.Data));
            iiImage: tmpChanged:=EditTeePicture(Self,TTeePicture(tmpItem.Data));

          end;

          { repaing grid cell }
          if tmpItem.StyleToInt=0 then
             InvalidateCell(Col,Row);

          if tmpChanged then
             tmpItem.Changed;

          if Assigned(tmpItem.IData) and (tmpItem.IData is TMenuItem) then
             TMenuItem(tmpItem.IData).Click;

          { repaint clicked grid cell }
          InvalidateCell(Col,Row);
        end;
      end;
    end;
  end;
end;

procedure TTeeInspector.KeyDown(var Key: Word; Shift: TShiftState);
begin { emulate mouse clicking when pressing the SPACE key }
  if Key=TeeKey_Space then
  begin
    with CellRect(1,Row) do
         MouseDown(mbLeft,[],Left+4,Top+4);

    Key:=0;
  end
  else
  if (Key=TeeKey_Right) and ItemExpandable(Row) then
     ExpandCollapse(Row)
  else
     inherited;
end;

Procedure TTeeInspector.DoPositionCombos(WhenVisible:Boolean);
var R : TRect;
begin { set inspector combobox position and size }
  R:=CellRect(Col,Row);

  if Assigned(IComboGrid) and ((not WhenVisible) or IComboGrid.Visible) then
  with IComboGrid do
  begin
    Left:=Self.Left+R.Left+1;
    Width:=R.Right-R.Left+1;
    Top:=Self.Top+R.Top;  // -1 7.02
  end;

  if Assigned(IEditGrid) and ((not WhenVisible) or IEditGrid.Visible) then
  with IEditGrid do
  begin
    Left:=Self.Left+R.Left+1+2;
    Width:=R.Right-R.Left+1-2;
    Height:=R.Bottom-R.Top+1;
    Top:=Self.Top+R.Top+1;
  end;
end;

procedure TTeeInspector.TopLeftChanged;
begin { reposition the inspector ComboBox (if visible) when scrolling }
  DoPositionCombos(True);
end;

Function TTeeInspector.ValidRow(ARow:Integer):Boolean;
begin
  if Assigned(FHeader) and Header.Visible then
     result:=ARow>0
  else
     result:=Assigned(Items) and (Items.Count>0);
end;

Function TTeeInspector.SelectCell(ACol, ARow: Integer): Boolean;
begin { Avoid selecting the first grid column (when clicking) }
  result:= (ACol>0) and
           ValidRow(ARow) and
           inherited SelectCell(ACol,ARow);
end;

procedure TTeeInspector.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var tmp:TGridState;
begin
  tmp:=FGridState;

  inherited;

  if tmp=gsColSizing then
     DoPositionCombos(True);
end;

procedure TTeeInspector.MouseMove(Shift: TShiftState; X, Y: Integer);
var tmpR      : TRect;
    tmp       : TGridCoord;
    tmpCursor : TCursor;
    tmpItem   : TInspectorItem;
begin
  inherited;

  {$IFNDEF LCL} // MouseCoord not supported

  tmpCursor:=crDefault;

  tmp:=MouseCoord(x,y); { mouse to grid Row,Col }

  if (tmp.X=0) and ValidRow(tmp.Y) and (ClickedCross(X,Y)<>-1) then
     tmpCursor:=crHandPoint
  else
  if (tmp.X=1) and ValidRow(tmp.Y) then { at column 1? }
  begin
    if CanDrawEllipsi(tmp.Y) then
    begin
      tmpItem:=Item(tmp.Y);

      if Assigned(tmpItem) and (tmpItem.Style<>iiSelection) then
      begin
        tmpR:=CellRect(tmp.X,tmp.Y); { Row,Col to screen pixel Rect }
        tmpR.Right:=tmpR.Left+TeeInspectorButtonSize;

        { clicked on rectangle? }
        if PointInRect(tmpR,X,Y) and tmpItem.Enabled then
           tmpCursor:=crHandPoint;
      end;
    end;
  end;

  Cursor:=tmpCursor;

  {$ENDIF}
end;

{ TComboFlatGrid }

{$IFNDEF CLX}
{$IFNDEF CLR}
{$IFNDEF LCL}
procedure TComboFlatGrid.CMFocusChanged(var Message: TCMFocusChanged);
begin
  if Visible then
     if GetFocus<>Handle then Hide;
end;
{$ENDIF}
{$ENDIF}
{$ELSE}
function TComboFlatGrid.EventFilter(Sender: QObjectH;
  Event: QEventH): Boolean;
begin
  Result := inherited EventFilter(Sender, Event);
  if QEvent_type(Event)=QEventType_FocusOut then
     if Visible then Hide;
end;
{$ENDIF}

{ TEditGrid }

{$IFNDEF CLX}
{$IFNDEF CLR}
{$IFNDEF LCL}
procedure TEditGrid.CMFocusChanged(var Message: TCMFocusChanged);
begin
  if Visible then
     if GetFocus<>Handle then Hide;
end;
{$ENDIF}
{$ENDIF}
{$ELSE}
function TEditGrid.EventFilter(Sender: QObjectH;
  Event: QEventH): Boolean;
begin
  Result := inherited EventFilter(Sender, Event);
  if QEvent_type(Event)=QEventType_FocusOut then
     if Visible then Hide;
end;
{$ENDIF}

{ TInspectorHeader }

constructor TInspectorHeader.Create;
begin
  inherited;
  FFont:=TTeeFont.Create(CanvasChanged);
  FVisible:=True;
end;

procedure TInspectorHeader.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

Procedure TInspectorHeader.CanvasChanged(Sender:TObject);
begin
  Inspector.Invalidate;
end;

procedure TInspectorHeader.SetVisible(const Value: Boolean);
begin
  if FVisible<>Value then
  begin
    FVisible:=Value;
    Inspector.InternalSetHeader;
    Inspector.Rebuild;
  end;
end;

procedure TInspectorHeader.Update;
begin
  Inspector.InternalSetHeader;
  CanvasChanged(nil);
end;

destructor TInspectorHeader.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TInspectorItem.SetStyle(const Value: TInspectorItemStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    Inspector.Invalidate;
  end;
end;

function TInspectorItem.GetSelectedIndex(Items:TStrings): Integer;
begin
  result:=-1;

  if Assigned(FOnGetItemIndex) then
     FOnGetItemIndex(Self,result)
  else
  if Assigned(Data) then
     result:=Items.IndexOfObject(Data)
  else
  if not VarIsEmpty(Value) then
     result:=Items.IndexOf(Value)
end;

procedure TInspectorItem.FillItems(Items: TStrings);
begin
  if (Items.Count=0) and Assigned(FOnGetItems) then
     FOnGetItems(Self,Inspector.AddComboItem);
end;

end.
