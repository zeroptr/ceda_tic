{*****************************************}
{ TeeChart version 8                      }
{ Many examples and demos.                }
{ Copyright 1995-2008 by Steema Software. }
{ All Rights Reserved.                    }
{*****************************************}
unit Main;
{$I TeeDefs.inc}

interface

uses
   {$IFNDEF LINUX}
   Windows, Messages,
   {$ENDIF}
   SysUtils, Classes,

   {$IFDEF CLX}
   QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
   QComCtrls, QMenus, QButtons, Types, TeeURL, QTypes,
   QImgList,
   {$ELSE}
   Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
   ComCtrls, Menus, Buttons, RichEdit,
   ImgList,
   {$IFDEF D7}
   XPMan,
   {$ENDIF}
   {$ENDIF}

   {$IFDEF CLR}
   System.ComponentModel, System.Text, System.IO,
   {$ENDIF}

   Chart, TeeAbout, TeeProcs, TeeDraw3D, TeCanvas, TeEngine,
   {$IFNDEF TEENOTHEMES}
   TeeThemeEditor,
   {$ENDIF}
   TeeConst, TeeTools,
   {$IFNDEF CLR}
   jpeg,
   {$ENDIF}
   Base;

Const
  TeeRegistryKey = '\Software\Steema Software\TeeChart Pro v'+TeeChartVersion+' VCL';
  TeeIniFileName  = 'tee'+TeeChartVersion+'new.ini';

type
  {$IFDEF CLX}
  TRichEdit=class(TMemo);
  {$ENDIF}

  TTeeFormInfo=class
  public
    FormClass : TFormClass;
    UnitName  : String;
  end;

  TTee8Form = class(TForm)
    StatusBar1: TStatusBar;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Images: TImageList;
    PopupMenu1: TPopupMenu;
    ShowAll1: TMenuItem;
    Draw3D1: TDraw3D;
    BPrevious: TSpeedButton;
    BNext: TSpeedButton;
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TreeView1: TTreeView;
    TabSheet2: TTabSheet;
    TreeView2: TTreeView;
    Timer1: TTimer;
    Presentation1: TMenuItem;
    Memo2: TMemo;
    Memo1: TMemo;
    Timer2: TTimer;
    PageExample: TPageControl;
    TabExample: TTabSheet;
    TabSource: TTabSheet;
    TabSupport: TTabSheet;
    ButtonConfig: TButton;
    Checksource1: TMenuItem;
    TabSearch: TTabSheet;
    Panel1: TPanel;
    Label2: TLabel;
    CBSearch: TComboFlat;
    Label3: TLabel;
    CBSearchSource: TCheckBox;
    CBFindAll: TCheckBox;
    TreeSearch: TTreeView;
    SearchButton: TSpeedButton;
    Label5: TLabel;
    LabelTopic: TLabel;
    Label6: TLabel;
    MemoSupport: TMemo;
    BSupport: TBitBtn;
    Chart1: TChart;
    N1: TMenuItem;
    Exportall1: TMenuItem;
    TabForm: TTabSheet;
    Memo3: TMemo;
    N2: TMenuItem;
    CanvasGDI1: TMenuItem;
    CanvasOpenGL1: TMenuItem;
    N3: TMenuItem;
    MemoryStatus1: TMenuItem;
    ExporttoHTML1: TMenuItem;
    FullScreenChart1: TMenuItem;
    CanvasAntiAlias1: TMenuItem;
    Panel3: TPanel;
    Button2: TButton;
    Button1: TButton;
    N4: TMenuItem;
    VerifyallMemos1: TMenuItem;
    CanvasGDI2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure BNextClick(Sender: TObject);
    procedure BPreviousClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ShowAll1Click(Sender: TObject);
    procedure TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure TreeView1GetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure Draw3D1AfterDraw(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Presentation1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageExampleChange(Sender: TObject);
    procedure ButtonConfigClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Checksource1Click(Sender: TObject);
    procedure CBSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBSearchChange(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure MemoSupportChange(Sender: TObject);
    procedure BSupportClick(Sender: TObject);
    procedure Exportall1Click(Sender: TObject);
    procedure CanvasGDI1Click(Sender: TObject);
    procedure CanvasOpenGL1Click(Sender: TObject);
    procedure ExporttoHTML1Click(Sender: TObject);
    procedure FullScreenChart1Click(Sender: TObject);
    procedure CanvasAntiAlias1Click(Sender: TObject);
    procedure VerifyallMemos1Click(Sender: TObject);
    procedure CanvasGDI2Click(Sender: TObject);
  private
     { Private declarations }
     OldCodeFile     : String;
     RichEditCode    : TRichEdit;
     RichEditForm    : TRichEdit;

     CheckSource     : Boolean;
     FullScreen      : TFullScreenTool;

     {$IFNDEF CLX}
     FindDialog      : TFindDialog;
     {$ENDIF}

     procedure ChangeCanvas(Style:TNewCanvasStyle);
     Procedure CheckRegistry;
     Function CodeFile:String;
     Function CodePath:String;
     Function CreateRichEdit(AParent:TWinControl):TRichEdit;
     function CurrentTeePanel:TCustomTeePanel;
     Procedure DoSearch;
     Function ImageIndex(Node:TTreeNode):Integer;

     {$IFNDEF CLX}
     procedure FindDialogFind(Sender: TObject);
     procedure RichEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
     {$ENDIF}

     procedure ShowForm(ATree:TTreeView);
     procedure ShowFormClass(AClass: TFormClass);
     Procedure ShowFormText;
     Procedure ShowSourceCode;
  public
     { Public declarations }

     InternalCodePath : String;

     TheForm : TForm;

     procedure AddFormCode(st:TStrings);
     Function FormOf(ANode:TTreeNode):TTeeFormInfo;
     Function HasForm(ANode:TTreeNode):Boolean;
     Function TheTree:TTreeView;
  end;

var
   Tee8Form: TTee8Form;

Procedure TrimWorkingSet;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$IFDEF D6}
{$WARN UNIT_PLATFORM OFF}
{$ENDIF}

Uses {$IFDEF LINUX}
     IniFiles,
     {$ELSE}
     MAPI, Registry ,MMSystem, FileCtrl,
     {$ENDIF}

     {$IFNDEF LINUX} // OpenGL examples not available in Linux
     Draw3D_Canvas,
     OpenGL_Editor,
     OpenGL_Football,
     OpenGL_Surface,
     OpenGL_TriSurface,
     OpenGL_Canvas,
     {$ENDIF}

     {$IFNDEF CLX}   // Database Examples not available in CLX
     TeeChartWizardDemo,
     Base_DBChart,
     DBChart_Speed,
     DBChart_Summary,
     DBChart_SummaryOrder,
     DBChart_Order,

     // Problem: 
     // Delphi 8 cannot compile this demo when using TeeChart "Standard" version
     // when using the following DBChart_xxx demo units.
     //
     // With TeeChart "Pro" or BDS2005/2006 there is no problem. 
     // 
     // The error is: 
     // "Fatal: Unit Borland.Vcl.DBCtrls was compiled with a 
     //  different version of Borland.Vcl.Db.dsInactive"

     {$IFNDEF D8TeeStandard}
     DBChart_LocateRecord,
     DBChart_MasterDetail,
     DBChart_CrossTab,
     DBChart_SingleRecord,
     {$ENDIF}

     DBChart_AnyDataSet,

     {$IFNDEF CLR}
     Series_DataSet,
     ChartDataSet,
     {$ENDIF}

     DBChart_Agg,
     ChartEditor_HideDataSets,
     DBChart_CrossTabSource,
     RichText_Drawing,
     TeeDemoGDIPlus,
     {$ELSE}
     CLX_NotAvail,
     {$ENDIF}

     Export_PDF,
     Export_JPEG,
     Export_PNG,
     Export_GIF,

     Series_XMLSource,
     Series_XMLSourceWeb,

     {$IFNDEF CLR}
     Export_PCX,
     Export_Email,
     Tool_Video,
     Tool_VideoPlayer,
     {$ENDIF}

     {$IFDEF CLR}
     CLR_NotAvail,
     {$ENDIF}

     {$IFNDEF LINUX}
     TeeExpForm,
     {$ENDIF}

     TeeDataTableEditor,

     EditChar, TeePenDlg, TeeVMLCanvas, TeeSVGCanvas, TeeExport,
     TeePNG, TeeToolsGalleryDemos, TeeStringsEditor,
     TeeXAMLCanvas, TeeFlexCanvas;

Const
  FolderSeparator = {$IFDEF LINUX} '/' {$ELSE} '\' {$ENDIF} ;

procedure TTee8Form.FormCreate(Sender: TObject);

  Function StringIn(Const S:String; Const Strings:Array of String):Boolean;
  var t : Integer;
  begin
    result:=False;
    for t:=Low(Strings) to High(Strings) do
    if Strings[t]=S then
    begin
      result:=True;
      exit;
    end;
  end;

  Procedure LoadTree(ATree:TTreeView; AMemo:TMemo);
  var i,
      t        : Integer;
      tmpClass : String;
      tmpUnit  : String;
      tmp      : {$IFDEF CLR}TStream{$ELSE}TStringStream{$ENDIF};
      FormInfo : TTeeFormInfo;
      {$IFDEF CLX}
      tmpLine  : Integer;
      tmpPos   : Integer;
      s        : String;
      {$ENDIF}
 begin
    {$IFDEF CLX}
    with AMemo.Lines do
    begin
      BeginUpdate;
      for tmpLine:=0 to Count-1 do
      begin
        s:=Strings[tmpLine];
        for tmpPos:=1 to Length(s) do
        if s[tmpPos]=' ' then s[tmpPos]:=#9
                         else break;
        Strings[tmpLine]:=s;
      end;
      EndUpdate;
    end;

    {$IFDEF D6}
    {$IFNDEF CLR}
    ActivateClassGroup(TControl);
    {$ENDIF}
    {$ENDIF}

    {$ENDIF}

    {$IFDEF CLR}  // Workaround for Classes.pas TStringStream bug...

    tmp:=TMemoryStream.Create;
    AMemo.Lines.SaveToStream(tmp);
    tmp.Position:=0;

    {$ELSE}

    tmp:=TStringStream.Create(AMemo.Lines.Text);

    {$ENDIF}

    try
      ATree.Visible:=False;
      ATree.LoadFromStream(tmp);
      ATree.Visible:=True;
    finally
      tmp.Free;
    end;

    with ATree do
    begin
      for t:=0 to Items.Count-1 do
      with Items[t] do
      begin
        i:=Pos(',', Text);
        if i>0 then
        begin
          tmpClass:=Copy(Text, i+1, Length(Text));
          Text:=Copy(Text, 1, i-1);

          tmpUnit:='';
          i:=Pos(',',tmpClass);
          if i>0 then
          begin
            tmpUnit:=Copy(tmpClass,i+1,Length(tmpClass));
            tmpClass:=Copy(tmpClass,1,i-1);
          end;

          {$IFDEF CLX}
          if StringIn(tmpClass, [ 'TBaseDBChart',
                                  'TDBChartSpeed',
                                  'TDBChartSummary',
                                  'TDBChartOrder',
                                  'TDBChartRecordLocate',
                                  'TLinkedTablesForm',
                                  'TDBChartCrossTab',
                                  'TDBChartAny',
                                  'TDBChartSingleRecord',
                                  'TDBChartAgg',
                                  'TDBSummaryOrder',
                                  'TSeriesDataSetForm',
                                  'TChartEditorHideDataSets',
                                  'TChartWizardDemo',
                                  'TDBCrossTabSourceDemo',
                                  'TRichTextDrawing',
                                  'TGDIPlusForm',
                                  'TChartDataSetDemo']) then
               tmpClass:='TCLXNotAvail';
          {$ENDIF}

          {$IFDEF D8TeeStandard}
          if StringIn(tmpClass, [ 'TDBChartRecordLocate',
                                  'TLinkedTablesForm',
                                  'TDBChartCrossTab',
                                  'TDBChartSingleRecord']) then

               tmpClass:='TCLRNotAvail';
          {$ENDIF}

          {$IFDEF LINUX}
          if StringIn(tmpClass, [ 'TOpenGLEditorForm',
                                  'TOpenGLTriSurface',
                                  'TOpenGLCanvas'    ,
                                  'TOpenGLFootball',
                                  'TOpenGLSurface',
                                  'TDraw3DCanvas'
                                  ]) then
               tmpClass:='TCLXNotAvail';
          {$ENDIF}

          {$IFDEF CLR}
          if StringIn(tmpClass, [ 'TPCXExportForm',
                                  'TExportEmailForm',
                                  'TSeriesDataSetForm',
                                  'TChartDataSetDemo',
                                  'TVideoPlayerToolForm',
                                  'TVideoToolForm'
                                  ]) then
               tmpClass:='TCLRNotAvail';
          {$ENDIF}

          FormInfo:=TTeeFormInfo.Create;
          FormInfo.FormClass:=TFormClass(FindClass(tmpClass));
          FormInfo.UnitName:=tmpUnit;
          Data:=FormInfo;
        end;
      end;

      Items[0].Expand(False);
    end;
 end;

begin

  {$IFDEF TEELITE}
  Application.Title:='TeeChart Standard v'+TeeChartVersion+' - What''s New !';
  ShowMessage('Attention:'#13#13+'Please be aware that a number of the forms in this demo'#13'were compiled with the TeeChart Professional version.');
  Caption:=Application.Title;
  {$ENDIF}

  Label1.Transparent:=True;  // <--- To solve D7 VCL design-time bug

  PageControl1.ActivePage:=TabSheet1;
  LoadTree(TreeView1,Memo1);
  LoadTree(TreeView2,Memo2);
  TreeView1.Items[0].Item[0].Expand(False);

  {$IFNDEF CLX}
  TreeView1.HotTrack:=True;
  TreeView2.HotTrack:=True;

  {$IFDEF D7}
  Panel2.ParentBackground:=False;
  Panel3.ParentBackground:=False;
  {$ENDIF}
  
  {$ENDIF}

  PageExample.HotTrack:=True;

  if (Screen.Width<1024) or (Screen.Height<768) then
     WindowState:=wsMaximized
  else
  begin
    Width:=980;
    Height:=750;
  end;
end;

procedure TTee8Form.ShowFormClass(AClass: TFormClass);
begin
  { create and insert a Form, then show it... }
  TheForm:=AClass.Create(Self);

  {$IFDEF CLX}
  AddFormTo(TheForm,TabExample);
  {$ELSE}

  with TheForm do
  begin
    Visible:=False;
    BorderStyle:=bsNone;
    Parent:=TabExample;
    Align:=alClient;
    Show;
  end;
  {$ENDIF}
end;

Function TTee8Form.HasForm(ANode:TTreeNode):Boolean;
begin
  result:=Assigned(ANode) and Assigned(ANode.Data);
end;

Function TTee8Form.FormOf(ANode:TTreeNode):TTeeFormInfo;
begin
  result:=TTeeFormInfo(ANode.Data)
end;

procedure TTee8Form.ShowForm(ATree:TTreeView);
var s : String;
    tmpClass : TFormClass;
begin
  if ATree.Selected<>nil then
  begin
    if HasForm(ATree.Selected) then
    begin
      // Find the Form corresponding to the Tree item, and create it
      tmpClass:=FormOf(ATree.Selected).FormClass;

      // If selected form is different than current form...
      if (not Assigned(TheForm)) or (tmpClass<>TheForm.ClassType) then
      begin
        FreeAndNil(TheForm);
        ShowFormClass(tmpClass);

        if CheckSource and (CodeFile<>'') then
           if not FileExists(CodePath+FolderSeparator+CodeFile+'.pas') then
              Raise Exception.Create(CodeFile+'.pas not found.');
      end;
    end;

    s:=CodeFile;
    if s<>'' then s:=' ('+s+'.pas)';

    StatusBar1.SimpleText:=ATree.Selected.Text+s;
  end;
end;

{ Show the corresponding Form, enable / disable the buttons }
procedure TTee8Form.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  PageExample.ActivePage:=TabExample;

  ShowForm(Sender as TTreeView);

  with Sender as TTreeView do
  begin
    BPrevious.Enabled := Assigned(Selected) and (Selected.AbsoluteIndex>0);
    BNext.Enabled := Assigned(Selected) and (Selected.AbsoluteIndex<Items.Count-1);
    TabSource.TabVisible:=CodeFile<>'';
    TabForm.TabVisible:=TabSource.TabVisible;
  end;
end;

Function TTee8Form.TheTree:TTreeView;
begin
  if PageControl1.ActivePage=TabSheet1 then result:=TreeView1
  else
  if PageControl1.ActivePage=TabSheet2 then result:=TreeView2
                                       else result:=TreeSearch;
end;

procedure TTee8Form.BNextClick(Sender: TObject);
begin
  with TheTree do Items[Selected.AbsoluteIndex+1].Selected := true
end;

procedure TTee8Form.BPreviousClick(Sender: TObject);
begin
  with TheTree do Items[Selected.AbsoluteIndex-1].Selected := true
end;

procedure TTee8Form.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TTee8Form.Label1Click(Sender: TObject);
begin
  TeeGotoURL(Handle, Label1.Caption);
end;

procedure TTee8Form.Button2Click(Sender: TObject);
begin
  TeeShowAboutBox;
end;

procedure TTee8Form.ShowAll1Click(Sender: TObject);
var t : Integer;
    t1, t2 : Longint;
begin
  t1:=GetTickCount;

  With TheTree do
  for t:=0 to Items.Count-1 do
  begin
    Selected:=Items[t];
    Application.ProcessMessages;
  end;

  t2:=GetTickCount;

  StatusBar1.SimpleText:='Time: '+IntToStr(t2-t1)+' msec.';
end;

Function TTee8Form.ImageIndex(Node:TTreeNode):Integer;
begin
  if Node.HasChildren then
     if Node.Expanded then result:= 1
                      else result:= 0
  else
  if Node.TreeView=TreeView1 then
     result:= 2
  else
     result:= 3;
end;

procedure TTee8Form.TreeView1GetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  Node.ImageIndex:=ImageIndex(Node);
end;

procedure TTee8Form.TreeView1GetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  Node.SelectedIndex:=ImageIndex(Node);
end;

procedure TTee8Form.Draw3D1AfterDraw(Sender: TObject);
//const
//  TeeChartText='TeeChart '+{$IFDEF TEELITE}'Std'{$ELSE}'Pro'{$ENDIF};
begin
  exit;

  (*
  BannerFont.Color:=clNavy;
  BannerFont.OutLine.Color:=clWhite;
  BannerFont.Gradient.Visible:=True;

  With Draw3D1.Canvas do
  begin
    AssignFont(BannerFont);
    TextOut(72,-6,TeeChartText);

    BannerFont.OutLine.Color:=BannerBorderColor;
    BannerFont.Color:=BannerFontColor;
    BannerFont.Gradient.Visible:=False;

    AssignFont(BannerFont);
    TextOut(72+TextWidth(TeeChartText)+(TextWidth(' ') div 2),-6,TeeChartVersion);
  end;
  *)
end;

Function StringFromRegistry(const AValue:String):String;
begin
  result:='';

  {$IFDEF LINUX}
  with TIniFile.Create(TeeIniFileName) do
  try
    result:=ReadString('code',AValue,'');
  finally
    Free;
  end;
  {$ELSE}
  With TRegistry.Create do
  try
    if OpenKeyReadOnly(TeeRegistryKey) then
       result:=ReadString(AValue);
  finally
    Free;
  end;
  {$ENDIF}
end;

var
  SearchReaden:Boolean=False;

procedure TTee8Form.PageControl1Change(Sender: TObject);

  procedure ReadSearchCombo;
  var t : Integer;
      tmp : String;
  begin
    CBSearch.Clear;

    for t:=0 to 20 do
    begin
      tmp:=StringFromRegistry('Search'+IntToStr(t));
      if tmp<>'' then
         CBSearch.Items.Add(tmp);
    end;

    SearchReaden:=True;
  end;

begin
  if PageControl1.ActivePage=TabSearch then
  begin
    BPrevious.Enabled:=False;
    BNext.Enabled:=False;
    CBSearchSource.Enabled:=CodePath<>'';
    if not CBSearchSource.Enabled then CBSearchSource.Checked:=False;

    if (not SearchReaden) and (CBSearch.Items.Count=0) then
       ReadSearchCombo;

    CBSearch.SetFocus;
  end
  else
  begin
    TreeSearch.Selected:=nil;
    TreeView1Change(TheTree,TheTree.Selected);
  end;
end;

procedure TTee8Form.Presentation1Click(Sender: TObject);
begin
  Presentation1.Checked:=not Presentation1.Checked;
  Timer1.Enabled:=Presentation1.Checked;
  if Timer1.Enabled then TheTree.Selected:=TheTree.Items[0];
end;

procedure TTee8Form.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;
  With TheTree do Selected:=Items[Selected.AbsoluteIndex+1];
  Timer1.Enabled:=True;
end;

{$IFNDEF LINUX}
{$R Sound.Res}

Procedure PlaySoundResource(Const Sound:String);
{$IFNDEF CLR}
var tmp : Integer;
{$ENDIF}
begin
  {$IFNDEF CLR}
  tmp:=LoadResource(HInstance,FindResource(HInstance,PChar(Sound),RT_RCDATA));
  PlaySound(LockResource(tmp),HInstance,
    SND_MEMORY or SND_SYNC or SND_NODEFAULT or SND_NOWAIT);
  {$ENDIF}
end;
{$ENDIF}

Procedure StringToRegistry(const AKey,AValue:String);
begin
  {$IFDEF LINUX}
  with TIniFile.Create(TeeIniFileName) do
  try
    WriteString('code',AKey,AValue);
    UpdateFile;
  finally
    Free;
  end;
  {$ELSE}
  With TRegistry.Create do
  try
    if OpenKey(TeeRegistryKey,True) then
       WriteString(AKey,AValue);
  finally
    Free;
  end;
  {$ENDIF}
end;

procedure TTee8Form.FormDestroy(Sender: TObject);

  procedure StoreSearchCombo;
  var t: Integer;
  begin
    for t:=0 to 20 do
        if CBSearch.Items.Count>t then
           StringToRegistry('Search'+IntToStr(t),CBSearch.Items[t]);
  end;

  procedure ClearTreeNodes(Tree:TTreeView);
  var t:Integer;
  begin
    for t:=0 to Tree.Items.Count-1 do
    if Assigned(Tree.Items[t].Data) then
       TTeeFormInfo(Tree.Items[t].Data).Free;
  end;

begin
  StoreSearchCombo;

  ClearTreeNodes(TreeView1);
  ClearTreeNodes(TreeView2);

  {$IFNDEF LINUX}
  {$IFOPT D-}
  PlaySoundResource('THANKYOU');
  {$ENDIF}
  {$ENDIF}
end;

{$IFDEF CLX}
type  TTreeViewAccess=class(TTreeView);
{$ENDIF}

procedure TTee8Form.FormShow(Sender: TObject);
var tmp : String;

  Function FindItem(ATree:TTreeView):Boolean;
  var t : Integer;
  begin
    result:=False;
    With ATree do
    for t:=0 to Items.Count-1 do
    if HasForm(Items[t]) and
       (UpperCase(FormOf(Items[t]).FormClass.ClassName)=tmp) then
    begin
      Selected:=Items[t];
      result:=True;
      exit;
    end;
  end;

begin
  {$IFNDEF LINUX}
  if IsWindowsNT then { minimize used memory by Windows... }
     SetProcessWorkingSetSize(GetCurrentProcess,$FFFFFFFF,$FFFFFFFF);
  {$ENDIF}

  PageExample.ActivePage:=TabExample;

  if ParamCount>0 then { find an specific demo Form... (ie: TSmithForm) }
  begin
    tmp:=UpperCase(ParamStr(1));
    if not FindItem(TreeView1) then
       if FindItem(TreeView2) then
          PageControl1.ActivePage:=TabSheet2;

    Timer2.Enabled:=False;
  end
  else TreeView1.Selected:=TreeView1.Items[0];

  {$IFDEF CLX}
  // Fix CLX bug, when showing a TreeView...
  TTreeViewAccess(TreeView1).UpdateControl;
  {$ENDIF}

  TrimWorkingSet;
end;

Procedure DeleteFromRegistry(const AValue:String);
begin
  {$IFDEF LINUX}
  with TIniFile.Create(TeeIniFileName) do
  try
    DeleteKey('code',AValue);
    UpdateFile;
  finally
    Free;
  end;
  {$ELSE}
  With TRegistry.Create do
  try
    if OpenKey(TeeRegistryKey,False) then
       DeleteValue(AValue);
  finally
    Free;
  end;
  {$ENDIF}
end;

Function TTee8Form.CodePath:String;
begin
  if InternalCodePath='' then
  begin
    result:=Trim(StringFromRegistry('DemoPath'));

    if result='' then
       if FileExists('Tee'+TeeChartVersion+'New.dpr') then
          result:=GetCurrentDir;
  end
  else
    result:=InternalCodePath;
end;

Function TTee8Form.CodeFile:String;
begin
  if HasForm(TheTree.Selected) then
     result:=Trim(FormOf(TheTree.Selected).UnitName)
  else
     result:='';
end;

{$IFNDEF CLX}
Procedure HighLight(RichEdit:TCustomRichEdit);
var p   : Integer;
    Len : Integer;
    tmp : String;

  Function IsKeyword(Const S:String):Boolean;
  Const Keywords:Array[0..45] of String=
         ('UNIT','INTERFACE','BEGIN','IMPLEMENTATION','PROCEDURE','INHERITED',
          'INITIALIZATION','END','CLASS','TYPE','VAR','PRIVATE','PUBLIC',
          'IF','ELSE','WHILE','FOR','REPEAT','RECORD','OBJECT','FUNCTION',
          'STRING','CONST','AND','NOT','IN','DO','THEN','WITH','USES',
          'TRY','FINALLY','EXCEPT','PACKED','CASE','OF','OVERLOAD','DEPRECATED',
          'AS','IS','FINALIZATION','OVERRIDE','SEALED','STATIC','OPERATOR',
          'STRICT');

  var t:Integer;
  begin
    for t:=0 to High(Keywords) do
    if Keywords[t]=S then
    begin
      result:=True;
      exit;
    end;
    result:=False;
  end;

  Function NextWordIsKeyword:Boolean;

    Procedure HighLightComment(EndChar:Char);
    begin
      RichEdit.SelStart:=p-1;
      Inc(p);
      While (p<=Len) and (tmp[p]<>EndChar) do Inc(p);
      With RichEdit do
      begin
        SelLength:=p-SelStart;
        With SelAttributes do
        begin
          Style:=[fsItalic];
          Color:=clNavy;
        end;
        SelStart:=0;
        SelLength:=0;
      end;
    end;

  Const Valid=['A'..'Z','a'..'z','_'];
  var p2  : Integer;
      Key : String;
  begin
    While p<=Len do
    begin
      if ({$IFDEF CLR}AnsiChar{$ENDIF}(tmp[p]) in Valid) then
         break
      else
      if tmp[p]='{' then HighLightComment('}')
      else
      if (tmp[p]='/') and ((p+1)<=Len) and (tmp[p+1]='/') then
         HighLightComment(#13)
      else Inc(p);
    end;

    p2:=p;

    While (p<=Len) and ({$IFDEF CLR}AnsiChar{$ENDIF}(tmp[p]) in Valid) do Inc(p);

    if p=Len then Inc(p);
    if p>p2 then
    begin
      key:=Copy(tmp,p2,p-p2);
      result:=IsKeyword(UpperCase(Key));
      RichEdit.SelStart:=p2-1;
      RichEdit.SelLength:=p-p2;
      Inc(p);
    end
    else result:=False;
  end;

begin
  RichEdit.Lines.BeginUpdate;
  try
    p:=1;
    tmp:=RichEdit.Lines.Text;
    Len:=Length(tmp);
    While p<Len do
       if NextWordIsKeyword then
          RichEdit.SelAttributes.Style:=[fsBold];
    RichEdit.SelStart:=0;
    RichEdit.SelLength:=0;
  finally
    RichEdit.Lines.EndUpdate;
  end;
end;
{$ENDIF}

Function TTee8Form.CreateRichEdit(AParent:TWinControl):TRichEdit;
begin
  result:=TRichEdit.Create(Self);
  With result do
  begin
    Align:=alClient;
    ReadOnly:=True;
    WordWrap:=False;
    ScrollBars:=ssBoth;
    Font.Name:='Courier New';
    Font.Size:=9;
    Parent:=AParent;

    {$IFNDEF CLX}
    OnKeyDown:=RichEditKeyDown;
    PlainText:=True;  // 5.02
    {$ENDIF}
  end;
end;

procedure TTee8Form.CheckRegistry;
begin
  if not FileExists(CodePath+FolderSeparator+'Tee'+TeeChartVersion+'New.dpr') then
     DeleteFromRegistry('DemoPath');
end;

Procedure TTee8Form.ShowFormText;
var tmpForm : TFileStream;
    tmpOutput : TMemoryStream;
    tmpFileName : String;
begin
  CheckRegistry;
  ButtonConfig.Visible:=CodePath='';

  if (CodePath<>'') and (CodeFile<>'') then
  begin
    RichEditForm.Free;
    RichEditForm:=CreateRichEdit(TabForm);

    tmpFileName:=CodePath+FolderSeparator+CodeFile;

    {$IFDEF CLX}
    tmpFileName:=tmpFileName+'.xfm';
    {$ELSE}
    tmpFileName:=tmpFileName+'.dfm';
    {$ENDIF}

    tmpForm:=TFileStream.Create(tmpFileName,fmOpenRead);
    try
      {$IFDEF CLX}
      RichEditForm.Lines.LoadFromStream(tmpForm);
      {$ELSE}

      tmpOutput:=TMemoryStream.Create;
      try
        tmpForm.Position:=0;
        ObjectResourceToText(tmpForm,tmpOutput);

        // show form at RichEdit
        tmpOutput.Position:=0;
        RichEditForm.Lines.LoadFromStream(tmpOutput);

        {$IFNDEF CLX}
        HighLight(RichEditForm);
        {$ENDIF}
      finally
        tmpOutput.Free;
      end;

      {$ENDIF}
    finally
      tmpForm.Free;
    end;
  end;
end;

Procedure TTee8Form.ShowSourceCode;
var UnitFileName : String;
begin
  CheckRegistry;
  ButtonConfig.Visible:=CodePath='';

  if (CodePath<>'') and (CodeFile<>'') then
  begin
    if OldCodeFile<>CodeFile then
    begin
      RichEditCode.Free;
      RichEditCode:=CreateRichEdit(TabSource);

      UnitFileName:=CodePath+FolderSeparator+CodeFile+'.pas';
      RichEditCode.Lines.LoadFromFile(UnitFileName);
      StatusBar1.SimpleText:=UnitFileName;

      {$IFNDEF CLX}
      HighLight(RichEditCode);
      {$ENDIF}

      RichEditCode.SetFocus;

      OldCodeFile:=CodeFile;
    end;
  end
  else
  begin
    FreeAndNil(RichEditCode);
    OldCodeFile:='';
  end;
end;

procedure TTee8Form.PageExampleChange(Sender: TObject);
begin
  if PageExample.ActivePage=TabSource then ShowSourceCode
  else
  if PageExample.ActivePage=TabForm then ShowFormText
  else
  if PageExample.ActivePage=TabSupport then
  begin
    LabelTopic.Caption:=CodeFile;
    MemoSupport.Lines.Clear;
    MemoSupport.SetFocus;
  end;
end;

procedure TTee8Form.ButtonConfigClick(Sender: TObject);
var tmpDir : String;
begin
  {$IFNDEF LINUX}
  tmpDir:='';
  if TeeSelectFolder('Folder with TeeChart Pro v'+TeeChartVersion+
                     ' Demo Sources','',tmpDir) then
  begin
    StringToRegistry('DemoPath',tmpDir);
    PageExampleChange(Self);
  end;
  {$ENDIF}
end;

procedure TTee8Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled:=False;
  Timer2.Enabled:=False;
end;

procedure TTee8Form.Checksource1Click(Sender: TObject);
begin
  CheckSource:=True;
  try
    ShowAll1Click(Self);
  finally
    CheckSource:=False;
  end;
end;

type TTeeCustomMemo={$IFDEF CLX}TMemo{$ELSE}TCustomMemo{$ENDIF};

Procedure TTee8Form.DoSearch;

var SearchText : Array[1..100] of String;
    NumWords   : Integer;
    tmpMemo    : TStringList;
    FindAllWords : Boolean;

 // Return true if search found in S string...
 Function FoundTextIn(S:String):Boolean;
 var t : Integer;
 begin
   result:=False;
   S:=UpperCase(S);

   if FindAllWords then
   begin
     for t:=1 to NumWords do
         if Pos(SearchText[t],S)=0 then exit;
     result:=True;
   end
   else
   begin
     for t:=1 to NumWords do
         if Pos(SearchText[t],S)>0 then
         begin
           result:=True;
           exit;
         end;
   end;
 end;

 // Add AItem to search result tree...
 Procedure AddResult(AItem:TTreeNode);
 begin
   TreeSearch.Items.Add(nil,AItem.Text).Data:=AItem.Data;
 end;

 // Return true if search found in any of Lines...
 Function SearchInLines(Lines:TStrings):Boolean;
 var tt : Integer;
 begin
   result:=False;
   for tt:=0 to Lines.Count-1 do
       if FoundTextIn(Lines[tt]) then
       begin
         result:=True;
         break;
       end;
 end;

var tmpProg  : TProgressBar;
    tmpForms : TList;

 Procedure DoSearchTree(Tree:TTreeView; Offset:Integer);

   Function FoundTextInNode(Node:TTreeNode):Boolean;

     // Return true if search found in AMemo lines or text...
     Function SearchInMemo(AMemo:TTeeCustomMemo):Boolean;
     begin
       if AMemo.Lines.Count>0 then
          result:=SearchInLines(AMemo.Lines)
       else
          result:=FoundTextIn(AMemo.Text);
     end;

     // Return true if search found in AForm components
     Function SearchInForm(AForm:TCustomForm):Boolean;
     var t : Integer;
     begin
       result:=False;
       for t:=0 to AForm.ComponentCount-1 do
       if AForm.Components[t] is TTeeCustomMemo then
       begin
         result:=SearchInMemo(TTeeCustomMemo(AForm.Components[t]));
         if result then break;
       end;
     end;

   var tmpCodeFile  : String;
       tmpFileName  : String;
       tmpForm      : TForm;
       tmpFormClass : TFormClass;
   begin
     result:=False;

     if HasForm(Node) then
     begin
       // Avoid processing same form twice...
       tmpFormClass:=FormOf(Node).FormClass;
       if tmpForms.IndexOf({$IFDEF CLR}TObject{$ENDIF}(tmpFormClass))<>-1 then exit;
       tmpForms.Add({$IFDEF CLR}TObject{$ENDIF}(tmpFormClass));

       // First of all, search in tree node Text...
       result:=FoundTextIn(Node.Text);

       if not result then
       begin
         // Create form and search ...
         tmpForm:=tmpFormClass.Create(nil);
         try
           if tmpForm is TBaseForm then
              result:=SearchInMemo(TBaseForm(tmpForm).Memo1)
           {$IFNDEF CLX}
           else
           if tmpForm is TBaseDBChart then
              result:=SearchInMemo(TBaseDBChart(tmpForm).Memo1)
           {$ENDIF}
           else
              result:=SearchInForm(tmpForm);
         finally
//           StrPCopy(St,tmpForm.ClassName);
//           OutputDebugString(St);
           tmpForm.Free;
         end;

         if not result then
         begin
           // Load form source code and search...

           tmpCodeFile:=FormOf(Node).UnitName;

           if CBSearchSource.Checked and (tmpCodeFile<>'') then
           begin
             tmpFileName:=CodePath+FolderSeparator+tmpCodeFile+'.pas';
             if FileExists(tmpFileName) then
             begin
               tmpMemo.LoadFromFile(tmpFileName);
               result:=SearchInLines(tmpMemo);
             end;
           end;
         end;
       end;
     end;
   end;

  var t   : Integer;
      tmp : Integer;
  begin
    with Tree do
    for t:=0 to Items.Count-1 do
    begin
      tmp:=Offset+Round(t*50/Items.Count);
      if tmpProg.Position<>tmp then tmpProg.Position:=tmp;

      if FoundTextInNode(Items[t]) then AddResult(Items[t]);
    end;
  end;

  // Divide S string in words, using space as separator
  Procedure SplitWords(S:String);
  var i : Integer;
  begin
    NumWords:=0;

    Repeat
      i:=Pos(' ',S);

      if i>0 then
      begin
        Inc(NumWords);
        SearchText[NumWords]:=UpperCase(Copy(S,1,i-1));
        Delete(S,1,i);
      end;
    Until (i=0) or (S='');

    if S<>'' then
    begin
      Inc(NumWords);
      SearchText[NumWords]:=UpperCase(S);
    end;
  end;

var tmpSearchText : String;
begin
  Screen.Cursor:=crHourGlass;
  try
    TreeSearch.Items.BeginUpdate;
    try
      TreeSearch.Items.Clear;
      FreeAndNil(TheForm);

      tmpSearchText:=CBSearch.Text;

      if tmpSearchText<>'' then
      begin
        if CBSearch.Items.IndexOf(tmpSearchText)=-1 then
           CBSearch.Items.Add(tmpSearchText);

        tmpMemo:=TStringList.Create;
        try
          SplitWords(tmpSearchText);

          FindAllWords:=CBFindAll.Checked;

          tmpProg:=TProgressBar.Create(nil);
          try
            tmpProg.Top:=3;
            tmpProg.Width:=PageControl1.Width;
            if tmpProg.Width>200 then tmpProg.Width:=200;
            tmpProg.Parent:=StatusBar1;
            tmpProg.Position:=0;

            tmpForms:=TList.Create;
            try
              DoSearchTree(TreeView1,0);
              DoSearchTree(TreeView2,50);
            finally
              tmpForms.Free;
            end;
            tmpProg.Position:=100;
            
          finally
            tmpProg.Free;
          end;
        finally
          tmpMemo.Free;
        end;
      end;
    finally
      TreeSearch.Items.EndUpdate;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TTee8Form.CBSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=TeeKey_Return then DoSearch;
end;

procedure TTee8Form.CBSearchChange(Sender: TObject);
begin
  SearchButton.Enabled:=CBSearch.Text<>'';
end;

procedure TTee8Form.Panel1Resize(Sender: TObject);
begin
  SearchButton.Left:=Panel1.Width-29;
  CBSearch.Width:=Panel1.Width-40;
end;

procedure TTee8Form.SearchButtonClick(Sender: TObject);
begin
  DoSearch;
end;

{$IFNDEF CLX}
procedure TTee8Form.RichEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_F3) or ((Key=Ord('F')) and (ssCtrl in Shift)) then
  begin
    if not Assigned(FindDialog) then
    begin
      FindDialog:=TFindDialog.Create(Self);
      FindDialog.OnFind:=FindDialogFind;
      FindDialog.Options:=FindDialog.Options+[frHideUpDown];
    end;

    with FindDialog do
    begin
      Position:=RichEditCode.ClientOrigin;
      FindDialog.Execute;
    end;
  end;
end;

type TRichEditAccess=class(TCustomRichEdit);

// From Delphi Help...
procedure TTee8Form.FindDialogFind(Sender: TObject);
var FoundAt, StartPos, ToEnd: Integer;
    tmpOptions : TSearchTypes;
begin
  with RichEditCode do
  begin
    StartPos:=SelStart;

    if SelLength<>0 then Inc(StartPos,SelLength);

    ToEnd:=Length(Text)-StartPos;

    tmpOptions:=[];

    if frMatchCase in FindDialog.Options then
       tmpOptions:=tmpOptions+[stMatchCase];
    if frWholeWord in FindDialog.Options then
       tmpOptions:=tmpOptions+[stWholeWord];

    FoundAt:=FindText(FindDialog.FindText,StartPos,ToEnd,tmpOptions);

    if FoundAt<>-1 then
    begin
      SelStart:=FoundAt;
      SelLength:=Length(FindDialog.FindText);
      SetFocus;
    end;
  end;
end;
{$ENDIF}

procedure TTee8Form.PopupMenu1Popup(Sender: TObject);
begin
  ShowAll1.Caption:='Show all ('+IntToStr(TheTree.Items.Count)+')';
end;

procedure TTee8Form.MemoSupportChange(Sender: TObject);
begin
  BSupport.Enabled:=MemoSupport.Text<>'';
end;

{$IFDEF CLR}
{$UNSAFECODE ON}
{$ENDIF}

procedure SendEmail(Text,Subject:String); {$IFDEF CLR}unsafe;{$ENDIF}
{$IFNDEF LINUX}
var MapiMessage  : TMapiMessage;
    MError       : Cardinal;
    Recipients   : TMapiRecipDesc;
    s : String;
{$ENDIF}
begin
  {$IFNDEF LINUX}
  Screen.Cursor:=crHourGlass;
  try
    Subject:='[Tee'+TeeChartVersion+'New: '+Subject+']';

    with Recipients do
    begin
      ulReserved:=0;
      ulRecipClass:=MAPI_TO;
      lpszName:='TeeChart Support';

      s:='support@steema.com';
      lpszAddress:={$IFDEF CLR}IntPtr(@{$ELSE}{$IFDEF D12}PAnsiChar({$ELSE}PChar({$ENDIF}{$ENDIF}s);

      ulEIDSize:=0;
      lpEntryID:=nil;
    end;

    with MapiMessage do
    begin
      ulReserved := 0;

      lpszSubject := {$IFNDEF CLR}{$IFDEF D12}PAnsiChar{$ELSE}PChar{$ENDIF}{$ENDIF}(Subject);
      lpszNoteText := {$IFNDEF CLR}{$IFDEF D12}PAnsiChar{$ELSE}PChar{$ENDIF}{$ENDIF}(Text);

      lpszMessageType := nil;
      lpszDateReceived := nil;
      lpszConversationID := nil;
      flFlags := 0;
      lpOriginator := nil;
      nRecipCount := 1;
      lpRecips := {$IFDEF CLR}IntPtr{$ENDIF}(@Recipients);
      nFileCount := 0;
      lpFiles := nil;
    end;

    MError:=MapiSendMail(0, {$IFDEF CLX}0{$ELSE}Application.Handle{$ENDIF},
      MapiMessage,
      MAPI_LOGON_UI or MAPI_NEW_SESSION, 0);

    if MError<>0 then
       if MError<>MAPI_E_USER_ABORT then
          raise Exception.CreateFmt('Error sending email',[MError]);
  finally
    Screen.Cursor:=crDefault;
  end;

  ShowMessage('Email to Steema Support is now at your Outbox.');
  {$ENDIF}
end;

{$IFDEF CLR}
{$UNSAFECODE OFF}
{$ENDIF}

{$IFNDEF LINUX}
{$IFNDEF CLR}
// Routines to obtain file version, cpu, windows version, etc...
Function ExtractVersionInfo:String;
var ExeName   : String;
    Len       : DWord;
    I         : DWord;
    InfoSize  : Integer;
    InfoBuf   : PChar;
    Value     : PChar;
    Charset   : DWORD;
    Language  : WORD;
begin
  ExeName:=Application.ExeName;
  InfoSize:=GetFileVersionInfoSize(PChar(ExeName), I);

  if InfoSize > 0 then
  begin
    InfoBuf := AllocMem(InfoSize);
    GetFileVersionInfo(PChar(ExeName), 0, InfoSize, InfoBuf);

    if VerQueryValue(InfoBuf, '\VarFileInfo\Translation',Pointer(Value), Len) then
    begin
       Language := PWORD(Value)^;
       CharSet  := PWORD(Value + 2)^;
    end
    else
    begin
      Language := 0;
      CharSet  := 0;
    end;

    result:=Format('%-16s : ''%s''', ['Language',IntToHex(Language, 4)])+#13#10;
    result:=result+Format('%-16s : ''%s''', ['Charset',  IntToHex(Charset,4)])+#13#10;

    if VerQueryValue(InfoBuf,PChar('StringFileInfo\' +
                     IntToHex(Language, 4)+IntToHex(Charset, 4) + '\'+'FileVersion'),
                     Pointer(Value),Len) then
          result:=result+Format('%-16s : ''%s''', ['TeeChart Version', Value]);

    FreeMem(InfoBuf, InfoSize);
  end
  else result:='';
end;

function CPUType: string;
begin
  CPUType := '';

  with TRegistry.Create do
  try
    RootKey:=HKEY_LOCAL_MACHINE;
    if OpenKeyReadOnly('\Hardware\Description\System\CentralProcessor\0') then
       CPUType:=ReadString('Identifier');
  finally
    Free;
  end;
end;

function WindowsVersion:String;
var WinVer : TOSVersionInfo;
begin
  result:='';
  WinVer.dwOSVersionInfoSize:=SizeOf(WinVer);
  if (GetVersionEx(WinVer)=Boolean(0)) then Exit;

  with WinVer do
  begin
    result:=Format('Windows v%d.%d (%d)', [dwMajorVersion, dwMinorVersion, dwPlatformId]);

    case dwPlatformId of
    VER_PLATFORM_WIN32_WINDOWS:
         case dwMajorVersion of
           3: result:=Format('Win v%d.%d', [dwMajorVersion, dwMinorVersion]);
           4: case dwMinorVersion of
                0:  result:='Windows 95';
               10:  result:='Windows 98';
               90:  result:='Windows ME';
              end;
         end;

    VER_PLATFORM_WIN32_NT:
         begin
           case dwMajorVersion of
             3,4: result:=Format('Windows NT v%d.%d', [dwMajorVersion, dwMinorVersion]);
               5: case dwMinorVersion of
                    0:  result := 'Windows 2000';
                    1:  result := 'Windows XP'
                  end;
           end;
         end;
    end;
  end;

  result:=result+' '+StrPas({$IFDEF D12}PWideChar{$ENDIF}(@WinVer.szCSDVersion));
end;
{$ENDIF}
{$ENDIF}

procedure TTee8Form.BSupportClick(Sender: TObject);
begin
  TeeGotoURL({$IFDEF CLX}nil{$ELSE}0{$ENDIF},
     'http://www.teechart.net/support/modules.php?name=Search&query='+MemoSupport.Text);
//  SendEmail(MemoSupport.Text,LabelTopic.Caption)
end;

Procedure TrimWorkingSet;
{$IFNDEF LINUX}
var MainHandle : THandle;
{$ENDIF}
begin  { reduce allocated memory at startup }
  {$IFNDEF LINUX}
  MainHandle:=OpenProcess(PROCESS_ALL_ACCESS,False,GetCurrentProcessID);
  SetProcessWorkingSetSize(MainHandle,$ffffffff,$ffffffff);
  CloseHandle(MainHandle);
  {$ENDIF}
end;

function TTee8Form.CurrentTeePanel:TCustomTeePanel;
var t : Integer;
begin
  with TheForm do
  for t:=0 to ControlCount-1 do
      if Controls[t] is TCustomTeePanel then
      begin
        result:=Controls[t] as TCustomTeePanel;
        exit;
      end;

  result:=nil;
end;

procedure TTee8Form.Exportall1Click(Sender: TObject);
var tmp,
    tmpName : String;
    t       : Integer;
    tmpForm : TForm;
    LBFormat : TListBox;
    tmpFormat,
    tmpSelec : TTeeExportFormat;
    tmpPanel : TCustomTeePanel;
begin
  tmpSelec:=nil;

  tmpForm:=TForm.Create(Self);

  with tmpForm do
  try
    Position:=poScreenCenter;
    LBFormat:=TListBox.Create(tmpForm);
    LBFormat.Align:=alClient;
    LBFormat.Parent:=tmpForm;

    for t:=0 to TeeExportFormats.Count-1 do
    begin
      tmpFormat:=TeeExportFormats[t].Create;
      LBFormat.Items.AddObject(ReplaceChar(tmpFormat.Description,'&'),tmpFormat);
    end;

    ShowModal;

    if LBFormat.ItemIndex<>-1 then
       tmpSelec:=TTeeExportFormat(LBFormat.Items.Objects[LBFormat.ItemIndex]);
  finally
    Free;
  end;

  if Assigned(tmpSelec) and SelectDirectory('Select folder','',tmp) then
  begin
    tmp:=tmp+'\TeeNew';
    CreateDir(tmp);

    With TheTree do
    for t:=0 to Items.Count-1 do
    begin
      Selected:=Items[t];
      Application.ProcessMessages;

      tmpPanel:=CurrentTeePanel;

      if Assigned(tmpPanel) then
      begin
        tmpName:=tmp+'\'+TheForm.Name;

        if ExtractFileExt(tmpName)='' then
           tmpName:=tmpName+'.'+tmpSelec.FileExtension;

        tmpSelec.Panel:=tmpPanel;
        tmpSelec.SaveToFile(tmpName);

        //Src.LoadFromFile(tmpName);
        //SmoothStrecth(Src,Dst);
        //Dst.SaveToFile(tmp+'\'+TheForm.Name+'.bmp');
      end;
    end;
  end;
end;

procedure TTee8Form.ChangeCanvas(Style:TNewCanvasStyle);
begin
  CanvasGDI1.Checked:= Style = ncGDI;
  CanvasOpenGL1.Checked:= Style = ncOpenGL;
  CanvasAntiAlias1.Checked:= Style = ncAntiAlias;
  CanvasGDI2.Checked:= Style = ncGDIPlus;

  TeeNewCanvas:=Style;

  FreeAndNil(TheForm);
  ShowForm(TheTree);
end;

procedure TTee8Form.CanvasGDI1Click(Sender: TObject);
begin
  ChangeCanvas(ncGDI);
end;

procedure TTee8Form.CanvasOpenGL1Click(Sender: TObject);
begin
  ChangeCanvas(ncOpenGL);
end;

procedure TTee8Form.AddFormCode(st:TStrings);
var sCode : TStrings;
    tmpFileName : String;
    t           : Integer;
    tmpForm     : TFileStream;
    tmpOutput   : TMemoryStream;
begin
  CheckRegistry;

  if (CodePath<>'') and (CodeFile<>'') then
  begin
    // Source code *.pas file

    sCode:=TStringList.Create;
    try
      sCode.LoadFromFile(CodePath+FolderSeparator+CodeFile+'.pas');

      {$IFNDEF CLX}
      //HighLight(sCode);
      {$ENDIF}

      st.Add('<br><br><b>'+CodeFile+'.pas</b><br><br>');
      st.Add('<font name="Courier">');
      st.Add('<pre>');
      st.AddStrings(sCode);
      st.Add('</pre>');
      st.Add('</font>');
    finally
      sCode.Free;
    end;

    // DFM / XFM form file

    st.Add('<br><b>'+CodeFile+'.dfm</b><br><br>');

    tmpFileName:=CodePath+FolderSeparator+CodeFile;

    {$IFDEF CLX}
    tmpFileName:=tmpFileName+'.xfm';
    {$ELSE}
    tmpFileName:=tmpFileName+'.dfm';
    {$ENDIF}

    tmpForm:=TFileStream.Create(tmpFileName,fmOpenRead);
    try
      tmpOutput:=TMemoryStream.Create;
      try
        tmpForm.Position:=0;
        ObjectResourceToText(tmpForm,tmpOutput);

        tmpOutput.Position:=0;

        sCode:=TStringList.Create;
        try
          sCode.LoadFromStream(tmpOutput);

          st.Add('<font name="Courier">');
          st.Add('<pre>');

          for t:=0 to sCode.Count-1 do
              st.Add(sCode[t]);

          st.Add('</pre>');
          st.Add('</font>');
        finally
          sCode.Free;
        end;
      finally
        tmpOutput.Free;
      end;
    finally
      tmpForm.Free;
    end;
  end;
end;

procedure TTee8Form.ExporttoHTML1Click(Sender: TObject);
var tmpSelec : TTeeExportFormat;
    tmpI,
    tmp : String;
    st,
    stI : TStrings;

  procedure Process(ATree:TTreeView);
  var
    tmpName : String;
    t,
    tt      : Integer;
    HasMemo : TMemo;
    HasChart : Boolean;
  begin
    With ATree do
    for t:=0 to Items.Count-1 do
    begin
      Selected:=Items[t];

      StatusBar1.SimpleText:=IntToStr(t)+'/'+IntToStr(Items.Count)+' '+Selected.Text;

      Application.ProcessMessages;

      if HasForm(Selected) then
      begin
        HasMemo:=nil;
        HasChart:=False;

        with TheForm do
        for tt:=0 to ControlCount-1 do
        begin
          if (not HasChart) and (Controls[tt] is TCustomTeePanel) then
          begin
            tmpName:=tmpI+'\'+TheForm.Name;
            if ExtractFileExt(tmpName)='' then
               tmpName:=tmpName+'.'+tmpSelec.FileExtension;

            tmpSelec.Panel:=Controls[tt] as TCustomTeePanel;

            if tmpSelec.Panel.Color=clBtnFace then
            begin
              if (not (tmpSelec.Panel is TCustomTeePanelExtended)) or
                 (not TCustomTeePanelExtended(tmpSelec.Panel).Gradient.Visible) then
              begin
                tmpSelec.Panel.Color:=clWhite;
                tmpSelec.Panel.BevelInner:=bvNone;
                tmpSelec.Panel.BevelOuter:=bvNone;
              end;
            end;

            tmpSelec.SaveToFile(tmpName);

            HasChart:=True;
          end
          else
          if Controls[tt] is TMemo then
             HasMemo:=TMemo(Controls[tt]);

          if HasChart and Assigned(HasMemo) then
             break;
        end;

        if Assigned(HasMemo) then
        begin
          st.Clear;
          st.Add('<html><body style="font-family: Verdana">');

          with HasMemo.Lines do
          for tt:=0 to Count-1 do
              st.Add(Strings[tt]+'<br>');

          if HasChart then
             st.Add('<br><img src="images/'+TheForm.Name+'.'+tmpSelec.FileExtension+'">');

          AddFormCode(st);

          st.Add('</body></html>');

          st.SaveToFile(tmp+'\'+TheForm.Name+'.htm');

          stI.Add('<a href="'+TheForm.Name+'.htm" target="main">'+Selected.Text+'</a><br>');
        end;
      end;
    end;
  end;

  procedure ExportAllForms;
  var tmpName : String;
  begin
    tmp:=tmp+'\TeeNew';
    tmpI:=tmp+'\images';

    CreateDir(tmp);
    CreateDir(tmpI);

    st:=TStringList.Create;
    stI:=TStringList.Create;
    stI.Add('<html><head><title>'+Caption+'</title></head><body>');

    PageControl1.ActivePage:=TabSheet1;
    Process(TreeView1);

    PageControl1.ActivePage:=TabSheet2;
    Process(TreeView2);

    st.Free;

    stI.SaveToFile(tmp+'\contents.htm');
    stI.Free;

    st:=TStringList.Create;
    try
      st.Add('<html><head><title>'+Caption+'</title></head>');
      st.Add('<frameset cols="15%,85%">');
      st.Add(' <frame name="contents" target="main" src="contents.htm">');
      st.Add(' <frame name="main" src="welcome.htm">');
      st.Add('</frameset>');
      st.Add('<noframes><body>');
      st.Add('<p>This page uses frames, but your browser does not support them.</p>');
      st.Add('</body></noframes>');
      st.Add('</frameset>');
      st.Add('</html>');

      tmpName:=tmp+'\index.htm';

      st.SaveToFile(tmpName);

      st.Clear;
      st.Add('<html><body>Welcome to TeeChart '+TeeChartVersion+'</body><html>');
      st.SaveToFile(tmp+'\welcome.htm');
    finally
      st.Free;
    end;

    TeeGotoURL(Handle, 'file:///'+tmpName);
  end;

begin
  tmpSelec:=TPNGExportFormat.Create;

  if Assigned(tmpSelec) and SelectDirectory('Select folder to export html','',tmp) then
  begin
    Screen.Cursor:=crHourGlass;
    try
      ExportAllForms;
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TTee8Form.FullScreenChart1Click(Sender: TObject);
var tmp : TCustomTeePanel;
begin
  tmp:=CurrentTeePanel;

  if Assigned(tmp) and (tmp is TCustomChart) then
  begin
    FullScreen:=TFullScreenTool.Create(Self);
    FullScreen.ParentChart:=TCustomChart(tmp);
    FullScreen.Active:=True;
  end;
end;

procedure TTee8Form.CanvasAntiAlias1Click(Sender: TObject);
begin
  ChangeCanvas(ncAntiAlias);
end;

procedure TTee8Form.VerifyallMemos1Click(Sender: TObject);

  function CurrentMemo:TMemo;
  var t : Integer;
  begin
    with TheForm do
    for t:=0 to ControlCount-1 do
        if Controls[t] is TMemo then
        begin
          result:=Controls[t] as TMemo;
          exit;
        end;

    result:=nil;
  end;

  function NodePathText(Node:TTreeNode):String;
  begin
    result:=Node.Text;
    while Assigned(Node.Parent) do
    begin
      Node:=Node.Parent;
      result:=Node.Text+'.'+result;
    end;
  end;

var t : Integer;
    st : TStringList;
    tmpMemo : TMemo;
begin
  st:=TStringList.Create;
  try
    With TheTree do
    for t:=0 to Items.Count-1 do
    begin
      Selected:=Items[t];
      Application.ProcessMessages;

      tmpMemo:=CurrentMemo;
      if Assigned(tmpMemo) and (tmpMemo.Text='') then
         st.Add(NodePathText(Selected));
    end;

    TeeEditStrings(Self,st,True);
  finally
    st.Free;
  end;
end;

procedure TTee8Form.CanvasGDI2Click(Sender: TObject);
begin
  ChangeCanvas(ncGDIPlus);
end;

end.
