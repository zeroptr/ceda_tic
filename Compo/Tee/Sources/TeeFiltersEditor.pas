{********************************************}
{  TeeChart Pro Charting Library             }
{  Filters Editor Dialog                     }
{  Copyright (c) 2006-2009 by David Berneda  }
{  All Rights Reserved                       }
{********************************************}
unit TeeFiltersEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     QMenus, QCheckLst, QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons,
     Menus, CheckLst,
     {$ENDIF}
     {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeeProcs, TeCanvas, TeePenDlg, TeeDraw3D, TeeFilters;

{$IFDEF CLR}
{$UNSAFECODE ON}
{$ENDIF}

type
  TFormItem=class
  public
    PropName : String;
    OnChange : TNotifyEvent;
  end;

  TFormItems=class(TList)
  private
    function Get(Index:Integer):TFormItem;
  public
    Procedure Clear; override;
    property Items[Index:Integer]:TFormItem read Get; default;
  end;

  TFormCreator=class(TComponent,IFormCreator)
  private
    FParent   : TWinControl;
    FOnChange : TNotifyEvent;

    IChanging : Boolean;
    IPosY     : Integer;

    function AddItem(const PropName:String; AOnChange:TNotifyEvent=nil):TFormItem;
    procedure ChangeProp(Sender:TObject; const Value:Variant);
    procedure CheckBoxChanged(Sender:TObject);
    procedure ColorChanged(Sender:TObject);
    procedure ComboChanged(Sender:TObject);
    procedure EditChanged(Sender:TObject);
    procedure ScrollChanged(Sender:TObject);
  public
    Instance : TObject;
    Items    : TFormItems;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    function AddCheckBox(const PropName,ACaption:String; OnChange:TNotifyEvent=nil):TCheckBox;
    function AddColor(const PropName,ACaption:String):TButton;
    function AddCombo(const PropName:String):TComboBox;
    function AddInteger(const PropName,ACaption:String; AMin,AMax:Integer):TEdit;
    function AddScroll(const PropName:String; AMin,AMax:Integer):TScrollBar;

    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  end;

  TFiltersEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Panel2: TPanel;
    BAdd: TSpeedButton;
    BDelete: TSpeedButton;
    BMoveUp: TSpeedButton;
    BMoveDown: TSpeedButton;
    Filters: TCheckListBox;
    Image: TDraw3D;
    MenuFilters: TPopupMenu;
    PopupMenu1: TPopupMenu;
    Scaled1: TMenuItem;
    Panel3: TPanel;
    Panel4: TPanel;
    BOK: TButton;
    CBPreview: TCheckBox;
    CBScaled: TCheckBox;
    PageProps: TPageControl;
    Properties: TTabSheet;
    TabRegion: TTabSheet;
    Splitter2: TSplitter;
    Timer1: TTimer;
    Label1: TLabel;
    ELeft: TEdit;
    UDLeft: TUpDown;
    Label2: TLabel;
    ETop: TEdit;
    UDTop: TUpDown;
    Label3: TLabel;
    EWidth: TEdit;
    UDWidth: TUpDown;
    Label4: TLabel;
    EHeight: TEdit;
    UDHeight: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure FiltersClick(Sender: TObject);
    procedure BAddClick(Sender: TObject);
    procedure FiltersClickCheck(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure BMoveUpClick(Sender: TObject);
    procedure BMoveDownClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImageResize(Sender: TObject);
    procedure Scaled1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBPreviewClick(Sender: TObject);
    procedure CBScaledClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ELeftChange(Sender: TObject);
    procedure ETopChange(Sender: TObject);
    procedure EWidthChange(Sender: TObject);
    procedure EHeightChange(Sender: TObject);
  private
    { Private declarations }
    Backup      : TFilterItems;
    Creator     : TFormCreator;
    IBitmap     : TBitmap;
    IChanging   : Boolean;

    procedure ClearProperties;
    procedure ChangedProperties(Sender: TObject);
    Function CompareMenus(a,b:Integer):Integer;
    function CurrentFilter:TTeeFilter;
    procedure EnableButtons;
    procedure FilterSelected(Sender:TObject);
    procedure Preview(ReuseBitmap:Boolean=False);
    procedure Swap(A,B:Integer);
    Procedure SwapMenus(a,b:Integer);
  public
    { Public declarations }
    Changed     : TNotifyEvent;
    FilterItems : TFilterItems;
    Picture     : TGraphic;
  end;

function ShowFiltersEditor(AOwner:TComponent; APicture:TTeePicture):Boolean; overload;
function ShowFiltersEditor(AOwner:TComponent; APicture:TGraphic; AFilters:TFilterItems):Boolean; overload;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  Math,
  TeeConst,
  TypInfo;

function ShowFiltersEditor(AOwner:TComponent; APicture:TGraphic; AFilters:TFilterItems):Boolean;
begin
  with TFiltersEditor.Create(AOwner) do
  try
    Picture:=APicture;
    FilterItems:=AFilters;
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

function ShowFiltersEditor(AOwner:TComponent; APicture:TTeePicture):Boolean;
begin
  result:=ShowFiltersEditor(AOwner,APicture.Graphic,APicture.Filters);

  if result then 
     APicture.Repaint;
end;

procedure TFiltersEditor.FormCreate(Sender: TObject);
begin
  IChanging:=True;
  
  TeeLoadArrowBitmaps(BMoveUp.Glyph,BMoveDown.Glyph);
  Creator:=TFormCreator.Create(Properties);
  Creator.OnChange:=ChangedProperties;
end;

procedure TFiltersEditor.EnableButtons;
begin
  BDelete.Enabled:=Filters.ItemIndex<>-1;
  BMoveUp.Enabled:=Filters.ItemIndex>0;
  BMoveDown.Enabled:=BDelete.Enabled and (Filters.ItemIndex<Filters.Items.Count-1);
end;

procedure TFiltersEditor.ChangedProperties(Sender: TObject);
begin
  Preview;
end;

procedure TFiltersEditor.ClearProperties;
begin
  with Properties do
       while ControlCount>0 do Controls[0].Free;
end;

type
  TFilterAccess=class(TTeeFilter);

procedure TFiltersEditor.FiltersClick(Sender: TObject);

  procedure CreateProperties;
  var tmp : TTabSheet;
  begin
    if Filters.ItemIndex<>-1 then
    begin
      tmp:=PageProps.ActivePage;

      try
        Creator.Items.Clear;
        Creator.IPosY:=8;
        Creator.Instance:=CurrentFilter;

        {$IFDEF D5} // D4 does not support GetPropValue / SetPropValue
        Creator.IChanging:=True;
        try
          CurrentFilter.CreateEditor(Creator,ChangedProperties);
        finally
          Creator.IChanging:=False;
        end;
        {$ENDIF}

        Properties.TabVisible:=Properties.ControlCount>0;
        TabRegion.TabVisible:=TFilterAccess(Creator.Instance).AllowRegion;

        if (not Properties.TabVisible) and (not TabRegion.TabVisible) then
           PageProps.Hide
        else
        begin
          TeeTranslateControl(Properties);

          PageProps.Show;

          if not Properties.TabVisible then
             tmp:=TabRegion;

          if TabRegion.TabVisible then
          with CurrentFilter.Region do
          begin
            UDLeft.Position:=Left;
            UDTop.Position:=Top;
            UDWidth.Position:=Width;
            UDHeight.Position:=Height;
          end
          else
            tmp:=Properties;
        end;

      finally
        PageProps.ActivePage:=tmp;
      end;
    end;

    PageProps.Visible:=Filters.ItemIndex<>-1;
  end;

begin
  IChanging:=True;
  try
    EnableButtons;
    ClearProperties;
    CreateProperties;
  finally
    IChanging:=False;
  end;
end;

Function TFiltersEditor.CompareMenus(a,b:Integer):Integer;
var tmpA : TMenuItem;
    tmpB : TMenuItem;
begin
  tmpA:=MenuFilters.Items[a];
  tmpB:=MenuFilters.Items[b];

  if tmpA.Caption=tmpB.Caption then
     result:=0
  else
  if tmpA.Caption<tmpB.Caption then
     result:=-1
  else
     result:=1;
end;

Procedure TFiltersEditor.SwapMenus(a,b:Integer);
var tmpA : TMenuItem;
    tmpB : TMenuItem;
begin
  tmpA:=MenuFilters.Items[a];
  tmpB:=MenuFilters.Items[b];

  tmpA.MenuIndex:=b;
  tmpB.MenuIndex:=a;
end;

procedure TFiltersEditor.BAddClick(Sender: TObject);
var P : TPoint;
begin
  P.X:=BAdd.Left+BAdd.Width-1;
  P.Y:=BAdd.Top+BAdd.Height-1;
  P:=BAdd.ClientToScreen(P);
  MenuFilters.Popup(P.X,P.Y);
end;

procedure TFiltersEditor.FilterSelected(Sender:TObject);
var tmp : Integer;
    tmpFilter : TFilterClass;
    tmpItem   : TTeeFilter;
begin
  tmpFilter:=TFilterClass(FilterClasses[TMenuItem(Sender).Tag]);
  tmpItem:=tmpFilter.Create(FilterItems);

  tmp:=Filters.Items.AddObject(tmpFilter.Description,tmpItem);

  Filters.Checked[tmp]:=True;
  Filters.ItemIndex:=tmp;
  FiltersClick(Self);
  Preview;
  TeeTranslateControl(self);
end;

procedure StretchTo(Graphic:TGraphic; Picture:TPicture; AWidth,AHeight:Integer);
var tmpDest : TBitmap;
    tmp     : TBitmap;
begin
  tmpDest:=TBitmap.Create;
  try
    TeeSetBitmapSize(tmpDest,AWidth,AHeight);

    if Graphic is TBitmap then
       tmp:=TBitmap(Graphic)
    else
    begin
      tmp:=TBitmap.Create;
      tmp.Assign(Graphic);
    end;

    try
      SmoothStretch(tmp,tmpDest);
      Picture.Assign(tmpDest);
    finally
      if not (Graphic is TBitmap) then
         tmp.Free;
    end;
  finally
    tmpDest.Free;
  end;
end;

procedure TFiltersEditor.Preview(ReuseBitmap:Boolean=False);

  function GetFilteredBitmap:TGraphic;
  begin
    if not Assigned(IBitmap) then
       IBitmap:=TBitmap.Create;

    IBitmap.Assign(Picture);

    if Assigned(FilterItems) then
       FilterItems.ApplyTo(IBitmap);

    result:=IBitmap;
  end;

begin
  if CBPreview.Checked then
  begin
    Image.BackImageMode:=pbmCustom;

    if Scaled1.Checked then
       StretchTo(GetFilteredBitmap,Image.BackImage,Image.Width,Image.Height)
    else
       Image.BackImage.Assign(GetFilteredBitmap);
  end;

  if Assigned(Changed) then
     Changed(Self);
end;

function TFiltersEditor.CurrentFilter:TTeeFilter;
begin
  result:=TTeeFilter(Filters.Items.Objects[Filters.ItemIndex]);
end;

procedure TFiltersEditor.ImageResize(Sender: TObject);
begin
  Preview(True);
end;

procedure TFiltersEditor.FiltersClickCheck(Sender: TObject);
begin
  CurrentFilter.Enabled:=Filters.Checked[Filters.ItemIndex];
  Preview;
end;

procedure TFiltersEditor.BDeleteClick(Sender: TObject);
var tmp : Integer;
begin
  tmp:=Filters.ItemIndex;
  CurrentFilter.Free;

  Filters.Items.Delete(Filters.ItemIndex);

  if tmp>=Filters.Items.Count then
     tmp:=Filters.Items.Count-1;

  if tmp>=0 then
  begin
    Filters.ItemIndex:=tmp;
    FiltersClick(Self);
  end
  else
    ClearProperties;

  EnableButtons;
  PageProps.Visible:=Filters.ItemIndex<>-1;

  Preview;
end;

procedure TFiltersEditor.Swap(A,B:Integer);
var tmp : TTeeFilter;
begin
  Filters.Items.Exchange(A,B);
  tmp:=FilterItems.Item[B];
  FilterItems.Item[A].Index:=B;
  tmp.Index:=A;
  EnableButtons;
  Preview;
end;

procedure TFiltersEditor.BMoveUpClick(Sender: TObject);
begin
  with Filters do
  if ItemIndex>0 then
     Swap(ItemIndex,ItemIndex-1);
end;

procedure TFiltersEditor.BMoveDownClick(Sender: TObject);
begin
  with Filters do
  if (ItemIndex<>-1) and (ItemIndex<Items.Count-1) then
     Swap(ItemIndex,ItemIndex+1);
end;

procedure TFiltersEditor.FormShow(Sender: TObject);

  procedure AddMenuItems;
  var t : Integer;
      tmpItem : TMenuItem;
  begin
    for t:=0 to FilterClasses.Count-1 do
    begin
      tmpItem:=TMenuItem.Create(Self);

      tmpItem.Caption:=TFilterClass(FilterClasses[t]).Description;

      if tmpItem.Caption='' then
         tmpItem.Caption:=TFilterClass(FilterClasses[t]).ClassName;

      tmpItem.OnClick:=FilterSelected;
      tmpItem.Tag:={$IFDEF CLR}Variant{$ENDIF}(t);
      MenuFilters.Items.Add(tmpItem);
    end;
  end;

var t : Integer;
begin
  Backup:=TFilterItems.Create(Self,TTeeFilter);

  if Assigned(FilterItems) then
  begin
    Backup.Assign(FilterItems);

    for t:=0 to FilterItems.Count-1 do
    begin
      Filters.Items.AddObject(FilterItems[t].Description,FilterItems[t]);
      Filters.Checked[t]:=FilterItems[t].Enabled;
    end;
  end;

  PageProps.ActivePage:=Properties;

  if Filters.Items.Count>0 then
  begin
    Filters.ItemIndex:=0;
    FiltersClick(Self);
    Preview;
  end;

  PageProps.Visible:=Filters.Items.Count>0;

  AddMenuItems;

  TeeTranslateControl(Self);

  // After translation, sort list:
  TeeSort(0,FilterClasses.Count-1,CompareMenus,SwapMenus);
end;

procedure TFiltersEditor.Scaled1Click(Sender: TObject);
begin
  Scaled1.Checked:=not Scaled1.Checked;
  CBScaled.Checked:=Scaled1.Checked;

  Preview;
end;

procedure TFiltersEditor.FormDestroy(Sender: TObject);
begin
  Backup.Free;
  IBitmap.Free;
end;

procedure TFiltersEditor.CBPreviewClick(Sender: TObject);
begin
  CBScaled.Enabled:=CBPreview.Checked;

  if CBPreview.Checked then
     Preview
  else
     Image.BackImage:=nil;
end;

procedure TFiltersEditor.CBScaledClick(Sender: TObject);
begin
  Scaled1.Checked:=CBScaled.Checked;
  Preview;
end;

{ TFormCreator }

Constructor TFormCreator.Create(AOwner:TComponent);
begin
  inherited;
  FParent:=AOwner as TWinControl;
  Items:=TFormItems.Create;
end;

Destructor TFormCreator.Destroy;
begin
  while Items.Count>0 do
  begin
    TFormItem(Items[0]).Free;
    Items.Delete(0);
  end;

  Items.Free;
  inherited;
end;

function TFormCreator.AddCheckBox(const PropName,
  ACaption: String; OnChange:TNotifyEvent=nil): TCheckBox;
begin
  result:=TCheckBox.Create(FParent);

  with result do
  begin
    Parent:=FParent;
    SetBounds(4,IPosY,75,16);
    Caption:=ACaption;

    {$IFDEF D5}
    Checked:=GetPropValue(Instance,PropName);
    {$ENDIF}

    OnClick:=CheckBoxChanged;
    Inc(IPosY,Height+2);
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(AddItem(PropName,OnChange));
  end;
end;

function TFormCreator.AddItem(const PropName:String; AOnChange:TNotifyEvent=nil):TFormItem;
begin
  result:=TFormItem.Create;
  result.PropName:=PropName;
  result.OnChange:=AOnChange;
  Items.Add(result);
end;

function TFormCreator.AddScroll(const PropName: String; AMin,
  AMax: Integer): TScrollBar;
begin
  result:=TScrollBar.Create(FParent);

  with result do
  begin
    Parent:=FParent;
    SetBounds(4,IPosY,FParent.Width-8,16);
    Min:=AMin;
    Max:=AMax;

    {$IFDEF D5}
    Position:=GetPropValue(Instance,PropName);
    {$ENDIF}

    OnChange:=ScrollChanged;
    Inc(IPosY,Height+6);
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(AddItem(PropName));
  end;
end;

procedure TFormCreator.ScrollChanged(Sender:TObject);
begin
  ChangeProp(Sender,(Sender as TScrollBar).Position);
end;

procedure TFormCreator.ComboChanged(Sender:TObject);
begin
  ChangeProp(Sender,(Sender as TComboBox).ItemIndex);
end;

procedure TFormCreator.CheckBoxChanged(Sender:TObject);
begin
  ChangeProp(Sender,(Sender as TCheckBox).Checked);
end;

procedure TFormCreator.ChangeProp(Sender:TObject; const Value:Variant);
var tmp : TFormItem;
begin
  if not IChanging then
  begin
    tmp:=TFormItem((Sender as TComponent).Tag);

    {$IFDEF D5}
    SetPropValue(Instance,tmp.PropName,Value);
    {$ENDIF}

    if Assigned(tmp.OnChange) then
       tmp.OnChange(Sender);

    FOnChange(Instance);
  end;
end;

procedure TFormCreator.ColorChanged(Sender:TObject);
begin
  FOnChange(Instance);
end;

procedure TFormCreator.EditChanged(Sender:TObject);
begin
  ChangeProp(Sender,(Sender as TEdit).Text);
end;

function TFormCreator.AddColor(const PropName,ACaption: String): TButton;
begin
  result:=TButtonColor.Create(FParent);

  with result as TButtonColor do
  begin
    Parent:=FParent;
    Caption:=ACaption;
    LinkProperty(Self.Instance,PropName);
    Left:=4;
    Top:=IPosY;
    OnClick:=ColorChanged;
    Inc(IPosY,Height+6);
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(AddItem(PropName));
  end;
end;

function TFormCreator.AddCombo(const PropName: String): TComboBox;

  function GetReadableEnum(const S:String):String;
  var i : Integer;
  begin
    result:=S;

    //if ReadableEnums then
    begin
      while Length(result)>0 do
      begin
        if result[1]=UpCase(result[1]) then
           break
        else
           Delete(result,1,1)
      end;

      i:=2;
      while i<Length(result) do
      begin
        if result[i]=UpCase(result[i]) then
        begin
          Insert(' ',result,i);
          Inc(i,2);
        end
        else
           Inc(i);
      end;

      if result='' then
         result:=S;
    end;
  end;

{$IFDEF D5}
var P  : {$IFDEF CLR}TPropInfo{$ELSE}PPropInfo{$ENDIF};
    D  : {$IFDEF CLR}TTypeData{$ELSE}PTypeData{$ENDIF};
    t  : Integer;
    P2 : {$IFDEF CLR}TTypeInfo{$ELSE}PTypeInfo{$ENDIF};
{$ENDIF}
begin
  result:=TComboFlat.Create(FParent);

  with result do
  begin
    Parent:=FParent;
    SetBounds(4,IPosY,Parent.Width-8,16);
    Style:=csDropDownList;
    Inc(IPosY,Height+6);
    OnChange:=ComboChanged;

    {$IFDEF D5}
    P:=GetPropInfo(Instance,PropName);

    if Assigned(P) then
    begin
      P2:=P.{$IFDEF CLR}TypeInfo{$ELSE}PropType^{$ENDIF};

      // Warning: BaseType pending at VCL.Net TypInfo.pas
      D:={$IFNDEF CLR}GetTypeData{$ENDIF}(GetTypeData(P2){$IFNDEF CLR}.BaseType^{$ENDIF});

      for t:=D.MinValue to D.MaxValue do
          Items.Add(GetReadableEnum(GetEnumName(P2, t)));

      ItemIndex:=GetEnumValue(P2,GetPropValue(Instance,PropName));
    end;
    {$ENDIF}

    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(Self.AddItem(PropName));
  end;
end;

{$IFNDEF D5}
const
  cHotKeyPrefix = '&'; // Do not localize
{$ENDIF}

function TFormCreator.AddInteger(const PropName,ACaption:String; AMin,AMax:Integer): TEdit;
const
  SameRow=True;
begin
  result:=TEdit.Create(FParent);

  with TLabel.Create(FParent) do
  begin
    Parent:=FParent;
    Left:=4;
    Top:=IPosY+4;

    if ACaption='' then Caption:=PropName
                   else Caption:=ACaption;

    if not SameRow then
       Inc(IPosY,Height+2);

    FocusControl:=result;

    if Pos(cHotKeyPrefix,Caption)=0 then
       Caption:=cHotKeyPrefix+Caption;
  end;

  with result do
  begin
    Parent:=FParent;

    if SameRow then
       SetBounds(44,IPosY,Parent.Width-52-16,16)
    else
       SetBounds(4,IPosY,Parent.Width-8-16,16);

    Inc(IPosY,Height+6);
    OnChange:=EditChanged;
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(Self.AddItem(PropName));

    with TUpDown.Create(FParent) do
    begin
      Parent:=FParent;
      Handle;
      Associate:=result;
      Max:=AMax;
      Min:=AMin;

      {$IFDEF D5}
      Position:=GetPropValue(Instance,PropName);
      {$ENDIF}
    end;
  end;
end;

procedure TFiltersEditor.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;
  FiltersClick(Self);
end;

procedure TFiltersEditor.ELeftChange(Sender: TObject);
begin
  if not IChanging then
  begin
    CurrentFilter.Region.Left:=UDLeft.Position;
    ChangedProperties(Self);
  end;
end;

procedure TFiltersEditor.ETopChange(Sender: TObject);
begin
  if not IChanging then
  begin
    CurrentFilter.Region.Top:=UDTop.Position;
    ChangedProperties(Self);
  end;
end;

procedure TFiltersEditor.EWidthChange(Sender: TObject);
begin
  if not IChanging then
  begin
    CurrentFilter.Region.Width:=UDWidth.Position;
    ChangedProperties(Self);
  end;
end;

procedure TFiltersEditor.EHeightChange(Sender: TObject);
begin
  if not IChanging then
  begin
    CurrentFilter.Region.Height:=UDHeight.Position;
    ChangedProperties(Self);
  end;
end;

{ TFormItems }

procedure TFormItems.Clear;
var t : Integer;
begin
  for t:=0 to Count-1 do Items[t].Free;
  inherited;
end;

function TFormItems.Get(Index: Integer): TFormItem;
begin
  result:=TFormItem({$IFOPT R-}List{$ELSE}inherited Items{$ENDIF}[Index]);
end;

end.
