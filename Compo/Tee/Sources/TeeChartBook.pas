{*******************************************}
{  TeeChart Pro  - TChartBook Control       }
{  Copyright (c) 2004-2009 by David Berneda }
{*******************************************}
unit TeeChartBook;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QMenus, QComCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, Menus, ComCtrls, ExtCtrls,
  {$ENDIF}
  Chart, TeeComma;

type
  TChartBook=class;

  TNewChartEvent=procedure(Sender:TChartBook; Chart:TCustomChart) of object;
  TDeleteChartEvent=procedure(Sender:TChartBook; Chart:TCustomChart; var Delete:Boolean) of object;

  TChartBook=class(TPageControl)
  private
    FToolbar    : Boolean;
    MenuToolbar : TMenuItem;
    DeleteItem  : TMenuItem;

    FOnDelete   : TDeleteChartEvent;
    FOnNew      : TNewChartEvent;

    procedure CheckTab(ATab:TTabSheet);
    procedure CheckToolbar(const Value:Boolean);

    {$IFNDEF CLR}
    {$IFNDEF CLX}
    procedure CMControlListChange(var Message: TMessage); message CM_CONTROLLISTCHANGE;
    {$ENDIF}
    {$ENDIF}

    Procedure CreateChart(ATab:TTabSheet);
    Function CreateToolBar(AChart:TCustomChart):TTeeCommander;
    Procedure DeleteClick(Sender:TObject);
    Procedure EditClick(Sender:TObject);
    function HasChart(ATab:TTabSheet):TCustomChart;
    Procedure NewClick(Sender:TObject);
    Procedure Popup(Sender:TObject);
    Procedure RenameClick(Sender:TObject);
    procedure SetToolbar(const Value:Boolean);
    Procedure ToolbarClick(Sender:TObject);
  protected
    {$IFDEF CLR}
    procedure ControlListChange(Inserting: Boolean; Child: TControl); override;
    {$ENDIF}

    procedure Loaded; override;

    {$IFDEF D5}
    procedure UpdateActivePage; override;
    {$ENDIF}
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Function ActiveChart:TCustomChart;
    Function ActiveToolbar:TTeeCommander;
    function AddChart:TCustomChart;
  published
    property PopupMenu stored False;
    property ShowToolbar:Boolean read FToolbar write SetToolbar default False;

    {$IFNDEF CLX}
    property TabPosition default tpBottom;
    {$ENDIF}

    property OnDeleteChart:TDeleteChartEvent read FOnDelete write FOnDelete;
    property OnNewChart:TNewChartEvent read FOnNew write FOnNew;
  end;

implementation

uses
  TeeConst, TeeProcs, EditChar, TeeProCo, TeePenDlg;

{ TChartBook }

Constructor TChartBook.Create(AOwner: TComponent);
var P : TPopupMenu;
begin
  inherited;

  {$IFNDEF CLX}
  TabPosition:=tpBottom;
  {$ENDIF}

  P:=TPopupMenu.Create(Self);

  P.Items.Add(TMenuItem.Create(Self));
  P.Items[0].Caption:=TeeMsg_MenuNew;
  P.Items[0].OnClick:=NewClick;

  DeleteItem:=TMenuItem.Create(Self);
  P.Items.Add(DeleteItem);
  DeleteItem.Caption:=TeeMsg_MenuDelete;
  DeleteItem.OnClick:=DeleteClick;

  P.Items.Add(TMenuItem.Create(Self));
  P.Items[2].Caption:=TeeMsg_MenuRename;
  P.Items[2].OnClick:=RenameClick;

  P.Items.Add(TMenuItem.Create(Self));
  P.Items[3].Caption:='-'; // Do not localize

  P.Items.Add(TMenuItem.Create(Self));
  P.Items[4].Caption:=TeeMsg_MenuEdit;
  P.Items[4].OnClick:=EditClick;

  MenuToolBar:=TMenuItem.Create(Self);
  P.Items.Add(MenuToolbar);
  MenuToolbar.Caption:=TeeMsg_MenuViewToolbar;
  MenuToolbar.OnClick:=ToolbarClick;

  PopupMenu:=P;

  P.OnPopup:=Popup;
end;

Destructor TChartBook.Destroy;
begin
  if PopupMenu.Owner=Self then
     PopupMenu.Free;

  inherited;
end;

Procedure TChartBook.Popup(Sender:TObject);
var tmp : TTeeCommander;
begin
  DeleteItem.Enabled:=PageCount>0;

  tmp:=ActiveToolbar;
  MenuToolbar.Checked:=Assigned(tmp) and tmp.Visible;
end;

Procedure TChartBook.EditClick(Sender:TObject);
begin
  EditChart(nil,ActiveChart);
end;

function TChartBook.HasChart(ATab:TTabSheet):TCustomChart;
var t : Integer;
begin
  result:=nil;

  if Assigned(ATab) then
  for t:=0 to ATab.ControlCount-1 do
  if ATab.Controls[t] is TCustomChart then
  begin
    result:=TCustomChart(ATab.Controls[t]);
    break;
  end;
end;

Function TChartBook.ActiveChart:TCustomChart;
begin
  result:=HasChart(ActivePage);
end;

Procedure TChartBook.DeleteClick(Sender:TObject);
var tmp       : Integer;
    tmpDelete : Boolean;
begin
  if TeeYesNo(Format(TeeMsg_SureToDelete,[ActivePage.Caption])) then
  begin
    tmpDelete:=True;

    if Assigned(FOnDelete) then
       FOnDelete(Self,HasChart(ActivePage),tmpDelete);

    if tmpDelete then
    begin
      tmp:=ActivePage.PageIndex;
      ActivePage.Free;

      if tmp<PageCount then
         ActivePage:=Pages[tmp];
    end;
  end;
end;

Procedure TChartBook.ToolbarClick(Sender:TObject);
begin
  MenuToolbar.Checked:=not MenuToolbar.Checked;
  CheckToolbar(MenuToolbar.Checked);
end;

Procedure TChartBook.NewClick(Sender:TObject);
begin
  AddChart;
  ActivePage:=Pages[PageCount-1];
end;

Function TChartBook.CreateToolBar(AChart:TCustomChart):TTeeCommander;
var B : TBevel;
begin
  result:=TTeeCommander.Create(Owner);

  with result do
  begin
    Align:=alTop;
    BevelOuter:=bvNone;
    Panel:=AChart;
    B:=TBevel.Create(Owner);
    B.Height:=1;
    B.Shape:=bsBottomLine;
    B.Style:=bsLowered;
    B.Align:=alBottom;
    InsertControl(B);
  end;
end;

Procedure TChartBook.CreateChart(ATab:TTabSheet);
var C : TChart;
begin
  with ATab do
  begin
    C:=TChart.Create(Owner);
    C.Align:=alClient;
    C.BevelOuter:=bvNone;
    InsertControl(C);

    C.Name:=TeeGetUniqueName(Owner,'Chart'); // Do not localize

    if Self.ShowToolbar then
       InsertControl(CreateToolbar(C));
  end;

  if Assigned(FOnNew) then
     FOnNew(Self,C);
end;

function TChartBook.AddChart:TCustomChart;
var tmp : TTabSheet;
begin
  tmp:=TTabSheet.Create(Owner);
  tmp.PageControl:=Self;
  CheckTab(tmp);
  result:=HasChart(tmp);
end;

procedure TChartBook.RenameClick(Sender: TObject);
var tmp : String;
begin
  tmp:=ActivePage.Caption;

  if InputQuery(TeeMsg_RenamePage,TeeMsg_NewName,tmp) then
     ActivePage.Caption:=tmp;
end;

procedure TChartBook.Loaded;
begin
  inherited;
  if FToolbar then
     CheckToolbar(FToolbar);
end;

procedure TChartBook.SetToolbar(const Value: Boolean);
begin
  FToolbar:=Value;
  CheckToolbar(FToolbar);
end;

procedure TChartBook.CheckToolbar(const Value:Boolean);
begin
  if Value then
  begin
    if ActiveToolbar=nil then
    begin
      if ActiveChart<>nil then
         ActivePage.InsertControl(CreateToolBar(ActiveChart))
    end
    else
    if ActiveChart<>nil then
    begin
      ActiveToolbar.Panel:=ActiveChart;
      ActiveToolbar.Show;
    end;
  end
  else
  if ActiveToolbar<>nil then
     ActiveToolbar.Visible:=False;
end;

function TChartBook.ActiveToolbar: TTeeCommander;
var t : Integer;
begin
  if Assigned(ActivePage) then
  with ActivePage do
  for t:=0 to ControlCount-1 do
  if Controls[t] is TTeeCommander then
  begin
    result:=TTeeCommander(Controls[t]);
    exit;
  end;

  result:=nil;
end;

{$IFDEF CLR}
procedure TChartBook.ControlListChange(Inserting: Boolean; Child: TControl);
begin
  inherited;
  
  if Child is TTabSheet then
     CheckTab(TTabSheet(Child));
end;
{$ELSE}
{$IFNDEF CLX}
procedure TChartBook.CMControlListChange(var Message: TMessage);
var tmp : TControl;
begin
  tmp:=TControl(Message.WParam);

  if Message.LParam=Integer(True) then
     if tmp is TTabSheet then
        CheckTab(TTabSheet(tmp));
end;
{$ENDIF}
{$ENDIF}

procedure TChartBook.CheckTab(ATab:TTabSheet);
var tmp : Integer;
    tmpChart : TCustomChart;
begin
  if Assigned(ATab) then
  begin
    tmpChart:=HasChart(ATab);

    if not (csLoading in ComponentState) then
       if not Assigned(tmpChart) then
          CreateChart(ATab);

    if ATab.Caption='' then
    begin
      tmp:=ATab.PageIndex;

      if tmp=-1 then
         tmp:=PageCount;

      if Assigned(tmpChart) and (tmpChart.Name<>'') then
         ATab.Caption:=tmpChart.Name
      else
         ATab.Caption:=TeeCommanMsg_Chart+IntToStr(tmp+1);
    end;
  end;
end;

{$IFDEF D5}
procedure TChartBook.UpdateActivePage;
begin
  inherited;
  CheckTab(ActivePage);
end;
{$ENDIF}

end.
