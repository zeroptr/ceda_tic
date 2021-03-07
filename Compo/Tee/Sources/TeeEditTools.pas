{******************************************}
{ TeeChart Tools Editor                    }
{ Copyright (c) 2000-2009 by David Berneda }
{******************************************}
unit TeeEditTools;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QButtons,
     QMenus, Types,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Menus,
     {$ENDIF}
     TeCanvas, TeEngine, Chart, TeePenDlg, TeeProcs;

type
  TFormTeeTools = class(TForm)
    LBTools: TListBox;
    PanelToolEditor: TPanel;
    PTop: TPanel;
    BAdd: TButton;
    BDelete: TButton;
    CBActive: TCheckBox;
    PBottom: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    BMoveUp: TSpeedButton;
    BMoveDown: TSpeedButton;
    CBShowInEditor: TCheckBox;
    BClone: TSpeedButton;
    PopupMenu1: TPopupMenu;
    procedure LBToolsClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure CBActiveClick(Sender: TObject);
    procedure BAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BMoveUpClick(Sender: TObject);
    procedure BMoveDownClick(Sender: TObject);
    {$IFNDEF CLX}
    procedure LBToolsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    {$ELSE}
    procedure LBToolsDrawItem(Sender: TObject; Index: Integer; Rect: TRect;
      State: TOwnerDrawState; var Handled: Boolean);
    {$ENDIF}
    procedure CBShowInEditorClick(Sender: TObject);
    procedure BCloneClick(Sender: TObject);
  private
    { Private declarations }
    {$IFDEF CLX}
    ICreating : Boolean;
    {$ENDIF}

    {$IFDEF TEEOCX}
    function TeeAXGetUniqueName(Const AStartName:String):String;
    {$ENDIF}

    Function CurrentTool:TTeeCustomTool;
    procedure DeleteForm;
    procedure EnableButtons;
    procedure FillAndSet;
    procedure FillTools;
    procedure SwapTool(A,B:Integer);

    {$IFNDEF CLX}
    {$IFNDEF LCL}
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    {$ENDIF}
    {$ENDIF}
  protected

    OnAdded   : TNotifyEvent;
    OnDeleted : TNotifyEvent;

    function CloneTool(Tool:TTeeCustomTool):TTeeCustomTool; virtual;
    function GetNewTool:TTeeCustomTool; virtual;
  public
    { Public declarations }
    Tools : TChartTools;

    Procedure Reload;
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
  TeeConst, TeeToolsGallery;

procedure TFormTeeTools.FillTools;
var t : Integer;
begin
  PBottom.Caption:='';

  With LBTools do
  begin
    Clear;
    
    for t:=0 to Tools.Count-1 do
        if (csDesigning in Tools[t].ComponentState) or
           Tools[t].ShowInEditor then
              Items.AddObject(Tools[t].Description,Tools[t]);
  end;

  CBActive.Enabled:=LBTools.Items.Count>0;

  if CBShowInEditor.Visible then
     CBShowInEditor.Enabled:=CBActive.Enabled;

  BDelete.Enabled:=CBActive.Enabled;
  BClone.Enabled:=BDelete.Enabled;
end;

type
  TToolAccess=class(TTeeCustomTool);

procedure TFormTeeTools.DeleteForm;
begin
  if PanelToolEditor.ControlCount>0 then
     PanelToolEditor.Controls[0].Free;
end;

procedure TFormTeeTools.LBToolsClick(Sender: TObject);
var tmpClass : TClass;
    tmp      : TForm;
begin
  {$IFDEF CLX}
  if not ICreating then
  if (PanelToolEditor.ControlCount=0) or
     (PanelToolEditor.Controls[0].Tag<>Integer(CurrentTool)) then
  {$ENDIF}
  if CurrentTool<>nil then
  begin

    if PanelToolEditor.ControlCount>0 then
    begin
      if not TForm(PanelToolEditor.Controls[0]).CloseQuery then
         LBTools.ItemIndex:=Tools.IndexOf(TTeeCustomTool(PanelToolEditor.Controls[0].Tag));
    end;

    CBActive.Checked:=CurrentTool.Active;
    DeleteForm;

    tmpClass:=GetClass(TToolAccess(CurrentTool).GetEditorClass);
    if Assigned(tmpClass) then
    begin
      tmp:=TFormClass(tmpClass).Create(Self);
      TeeTranslateControl(tmp);
      tmp.Align:=alClient;
      AddFormTo(tmp,PanelToolEditor,CurrentTool);
    end;

    CBShowInEditor.Visible:=csDesigning in CurrentTool.ComponentState;

    if CBShowInEditor.Visible then
    begin
      CBShowInEditor.Checked:=CurrentTool.ShowInEditor;
      CBActive.Top:=3;
    end;

    EnableButtons;

    if PBottom.Visible and (CurrentTool<>nil) then
       PBottom.Caption:=CurrentTool.Name+' ('+CurrentTool.ClassName+')'; // Do not localize
  end;
end;

procedure TFormTeeTools.BDeleteClick(Sender: TObject);
var tmp : Integer;
begin
  if (CurrentTool<>nil) and  { 5.01 }
     TeeYesNoDelete(CurrentTool.Description,Self) then
  begin
    tmp:=LBTools.ItemIndex;

    if Assigned(OnDeleted) then
       OnDeleted(CurrentTool);

    CurrentTool.Free;
    DeleteForm;
    FillTools;

    With LBTools do     { 5.01 }
    if tmp>1 then
       ItemIndex:=tmp-1
    else
    if Items.Count>0 then ItemIndex:=Items.Count-1;

    BDelete.Enabled:=LBTools.ItemIndex<>-1;
    BClone.Enabled:=BDelete.Enabled;

    if BDelete.Enabled then
       LBToolsClick(Self);
  end;
end;

procedure TFormTeeTools.CBActiveClick(Sender: TObject);
begin
  if CurrentTool<>nil then
     CurrentTool.Active:=CBActive.Checked;
end;

{$IFDEF TEEOCX}
function TFormTeeTools.TeeAXGetUniqueName(Const AStartName:String):String;
var i,tmp: integer;
Begin
  tmp:=0;
  for i:=0 to Tools.Count-1 do
  Begin
    if Tools.Items[i].Name=AStartName+TeeStr(tmp) then
      inc(tmp)
    else
      break;
  end;
  result:=AStartName+TeeStr(tmp);
end;
{$ENDIF}

function TFormTeeTools.GetNewTool:TTeeCustomTool;
var AOwner : TComponent;
    t      : Integer;
    tmpGally : TTeeToolsGallery;
begin
  result:=nil;

  tmpGally:=TTeeToolsGallery.Create(Owner);

  with tmpGally do
  try
    PositionToCenter(tmpGally);

    if ShowModal=mrOk then
    begin
      if Assigned(Tools.Owner) then
         AOwner:=Tools.Owner.Owner
      else
         AOwner:=nil;

      for t:=0 to Tools.Count-1 do { 5.01 }
      if Tools[t].Owner=Tools.Owner then
      begin
        AOwner:=Tools.Owner;
        break;
      end;

      result:=SelectedTool.Create(AOwner);

      with result do
      begin
        ParentChart:=Tools.Owner;
        {$IFNDEF TEEOCX}
        Name:=TeeGetUniqueName(AOwner,TeeMsg_DefaultToolName);
        {$ELSE}
        //due to Owner=nil in ocx version
        Name:=TeeAXGetUniqueName(TeeMsg_DefaultToolName);
        {$ENDIF}
      end;
    end;
  finally
    Free;
  end;
end;

procedure TFormTeeTools.BAddClick(Sender: TObject);
var tmpTool : TTeeCustomTool;
begin
  tmpTool:=GetNewTool;

  if Assigned(tmpTool) then
  begin
    {$IFDEF CLX}
    ICreating:=True;
    {$ENDIF}

    if Assigned(OnAdded) then
       OnAdded(tmpTool);

    FillTools;

    {$IFDEF CLX}
    ICreating:=False;
    {$ENDIF}

    LBTools.ItemIndex:=LBTools.Items.Count-1;

    {$IFDEF TEEOCX}
    if GetParentForm(Self)<>nil then
    {$ENDIF}
       LBTools.SetFocus;

    LBToolsClick(Self);
  end;
end;

function TFormTeeTools.CurrentTool: TTeeCustomTool;
begin
  if LBTools.ItemIndex=-1 then
     result:=nil
  else
     result:=TTeeCustomTool(LBTools.Items.Objects[LBTools.ItemIndex]);
end;

procedure TFormTeeTools.FillAndSet;
begin
  FillTools;

  With LBTools do
  if Items.Count>0 then
  begin
    ItemIndex:=0;
    LBToolsClick(Self);
  end
  else EnableButtons;
end;

procedure TFormTeeTools.FormShow(Sender: TObject);
begin
  if not Assigned(Tools) then
     Tools:=TChartTools(Tag);

  if (not Assigned(Tools)) or
     (not Assigned(Tools.Owner)) or
     (not (csDesigning in Tools.Owner.ComponentState)) then
          CBActive.Top:=BAdd.Top+((BAdd.Height-CBActive.Height) div 2)
  else
  begin
    CBShowInEditor.Visible:=(csDesigning in Tools.Owner.ComponentState);
    CBShowInEditor.Enabled:=False;
  end;

  if Assigned(Tools) then
  begin
    if Assigned(Tools.Owner) then
       PBottom.Visible:=csDesigning in Tools.Owner.ComponentState;

    FillAndSet;
  end;

  {$IFDEF CLX}
  ICreating:=False;

  if LBTools.Items.Count>0 then
  begin
    if LBTools.ItemIndex=-1 then LBTools.ItemIndex:=0;
    LBToolsClick(Self);
  end;
  {$ENDIF}

  TeeTranslateControl(Self);
end;

procedure TFormTeeTools.FormCreate(Sender: TObject);
begin
  {$IFDEF CLX}
  ICreating:=True;
  {$ENDIF}

  TeeLoadArrowBitmaps(BMoveUp.Glyph,BMoveDown.Glyph);
end;

procedure TFormTeeTools.SwapTool(A,B:Integer);
var tmpIndex : Integer;
begin
  LBTools.Items.Exchange(A,B);

  {$IFDEF CLX}
  if LBTools.ItemIndex=A then
     LBTools.ItemIndex:=B;
  {$ENDIF}

  LBTools.Invalidate;

  Tools.Exchange(A,B);
  tmpIndex:=Tools[A].ComponentIndex;
  Tools[A].ComponentIndex:=Tools[B].ComponentIndex;
  Tools[B].ComponentIndex:=tmpIndex;
  Tools.Owner.Invalidate;

  EnableButtons;
end;

procedure TFormTeeTools.EnableButtons;
begin
  With LBTools do
  begin
    BMoveUp.Enabled  :=ItemIndex>0;
    BMoveDown.Enabled:=ItemIndex<Items.Count-1;
    BDelete.Enabled  :=ItemIndex<>-1;
    BClone.Enabled   :=BDelete.Enabled;
  end;
end;

procedure TFormTeeTools.BMoveUpClick(Sender: TObject);
begin
  With LBTools do SwapTool(ItemIndex,ItemIndex-1);
end;

procedure TFormTeeTools.BMoveDownClick(Sender: TObject);
begin
  With LBTools do SwapTool(ItemIndex,ItemIndex+1);
end;

Procedure TFormTeeTools.Reload;
begin
  if Assigned(Tools) and Assigned(Tools.Owner) then
     if Tools.Count<>LBTools.Items.Count then FillAndSet;

  if LBTools.ItemIndex<>-1 then LBToolsClick(Self);
end;

{$IFNDEF CLX}
procedure TFormTeeTools.LBToolsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ELSE}
procedure TFormTeeTools.LBToolsDrawItem(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
{$ENDIF}
begin
  TeeDrawTool(LBTools,Index,Rect,State,TTeeCustomTool(LBTools.Items.Objects[Index]));
end;

{$IFNDEF CLX}
{$IFNDEF LCL}
procedure TFormTeeTools.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(Parent) then
     Parent.UpdateControlState;
end;
{$ENDIF}
{$ENDIF}

procedure TFormTeeTools.CBShowInEditorClick(Sender: TObject);
begin
  if CurrentTool<>nil then
     CurrentTool.ShowInEditor:=CBShowInEditor.Checked;
end;

function TFormTeeTools.CloneTool(Tool:TTeeCustomTool):TTeeCustomTool;
begin
  result:=CloneChartTool(Tool,Tool.Owner);
  result.ParentChart:=Tool.ParentChart;
end;

procedure TFormTeeTools.BCloneClick(Sender: TObject);
var tmpNew : TTeeCustomTool;
begin
  tmpNew:=CloneTool(CurrentTool);
  LBTools.ItemIndex:=LBTools.Items.AddObject(tmpNew.Description,tmpNew);
  EnableButtons;
end;

end.
