{***************************************}
{ TeeTree version 2                     }
{ Many examples and demos.              }
{ Copyright 1998-2007 by David Berneda. }
{ All Rights Reserved.                  }
{***************************************}
unit TreeMain;
{$I TeeDefs.inc}

{$IFDEF D6}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}
{$ENDIF}

interface

uses
   {$IFNDEF LINUX}
   Windows, Messages,
   {$ENDIF}
   SysUtils, Classes,
   {$IFDEF CLX}
   QGraphics, QControls, QForms, QDialogs, QComCtrls, QImgList, QExtCtrls,
   QStdCtrls, QMenus, QButtons,
   {$ELSE}
   Graphics, Controls, Forms, Dialogs, ComCtrls, ImgList, ExtCtrls,
   StdCtrls, Menus, Buttons,
   {$ENDIF}
   {$IFNDEF CLR}
   {$IFDEF D5}
   SHDocVw,
   {$ENDIF}
   {$ENDIF}
   {$IFNDEF CLR}
   AnimatedGIF,
   {$ENDIF}
   TeeAbout, TeeProcs, TeeTree, TreeFlow;

type
  TTeeTree2Form = class(TForm)
    StatusBar1: TStatusBar;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    Images: TImageList;
    PopupMenu1: TPopupMenu;
    ShowAll1: TMenuItem;
    Button2: TSpeedButton;
    Draw3D1: TTree;
    BPrevious: TSpeedButton;
    BNext: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TreeView1: TTree;
    Timer1: TTimer;
    Presentation1: TMenuItem;
    Memo1: TMemo;
    Timer2: TTimer;
    PageExample: TPageControl;
    TabExample: TTabSheet;
    TabSource: TTabSheet;
    TabWeb: TTabSheet;
    ButtonConfig: TButton;
    TreeNodeShape1: TTreeNodeShape;
    ArrowRightShape1: TArrowRightShape;
    Timer3: TTimer;
    TreeNodeShape2: TTreeNodeShape;
    procedure FormCreate(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure BPreviousClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ShowAll1Click(Sender: TObject);
    procedure Draw3D1AfterDraw(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Presentation1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageExampleChange(Sender: TObject);
    procedure ButtonConfigClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer3Timer(Sender: TObject);
    procedure TreeView1SelectShape(Sender: TTreeNodeShape);
    procedure TreeView1ExpandedCollapsed(Sender: TTreeNodeShape);
    procedure TreeNodeShape2Click(Sender: TTreeNodeShape;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TreeView1UnSelectShape(Sender: TTreeNodeShape);
  private
     { Private declarations }

     {$IFNDEF CLX}
     RichEditCode       : TRichEdit;
     {$ENDIF}

     tmpForm            : TForm;
     VersionFontColor   : TColor;
     VersionBorderColor : TColor;
     OldCodeFile        : String;

     {$IFNDEF CLR}
     {$IFDEF D5}
     WebBrowser1        : TWebBrowser;
     {$ENDIF}
     {$ENDIF}

     DeltaSize          : Integer;
     procedure ShowForm(ATree:TCustomTree);
     procedure ShowFormClass(AClass: TFormClass);
     Function TheTree:TTree;
     Function CodeFile:String;
  public
     { Public declarations }
  end;

var
   TeeTree2Form: TTeeTree2Form;

implementation

{$R *.DFM}

Uses TeCanvas, MMSystem, Registry, FileCtrl, TreeEd, TeePenDlg,
     TreeUML, TreeElectric, TreeTransit, TeeVMLCanvas,
     TeePDFCanvas, TeeSVGCanvas, TeePSCanvas;

type TTeeFormInfo=packed record
       FormClass : TFormClass;
       UnitName  : String;
     end;
     PTeeFormInfo={$IFNDEF CLR}^{$ENDIF}TTeeFormInfo;

procedure TTeeTree2Form.FormCreate(Sender: TObject);

  Procedure LoadTree(ATree:TTree; AMemo:TMemo);
  var i,
      t        : Integer;
      tmpClass : String;
      tmpUnit  : String;
      tmp      : TStringList;
      s        : {$IFDEF CLR}TMemoryStream{$ELSE}TStringStream{$ENDIF};
      FormInfo : PTeeFormInfo;
  begin
    {$IFDEF CLR}  // Workaround for Classes.pas TStringStream bug...
    s:=TMemoryStream.Create;
    AMemo.Lines.SaveToStream(s);
    s.Position:=0;
    {$ELSE}
    s:=TStringStream.Create(AMemo.Lines.Text);
    {$ENDIF}
    try
      tmp:=TStringList.Create;
      try
        tmp.LoadFromStream(s);
        ATree.LoadFromStrings(tmp);
      finally
        tmp.Free;
      end;
    finally
      s.Free;
    end;

    with ATree do
    begin
      GlobalFormat.Border.Visible:=False;
      GlobalFormat.Connection.ArrowTo.Style:=casNone;

      for t:=0 to Items.Count-1 do
      with Items[t] do
      begin
        if Count>0 then ImageListIndex:=0
                   else ImageListIndex:=1;

        Transparent:=True;

        i:=Pos(',', SimpleText);
        if i>0 then
        begin
          tmpClass:=Copy(SimpleText, i+1, Length(SimpleText));
          SimpleText:=Copy(SimpleText, 1, i-1);

          tmpUnit:='';
          i:=Pos(',',tmpClass);
          if i>0 then
          begin
            tmpUnit:=Copy(tmpClass,i+1,Length(tmpClass));
            tmpClass:=Copy(tmpClass,1,i-1);
          end;

          {$IFDEF CLR}
          if tmpClass='TAnimatedGIFForm' then
             continue;
          {$ENDIF}

          {$IFNDEF CLR}
          New(FormInfo);
          {$ENDIF}

          FormInfo.FormClass:=TFormClass(FindClass(tmpClass));  // FindClass
          FormInfo.UnitName:=tmpUnit;
          Data:=FormInfo;
        end;
      end;

      with Items[0] do
      begin
        Expanded:=True;
        Selected:=True;
        Font.Style:=[fsBold];
        Font.Size:=10;
        Font.Name:='Courier New';
      end;
    end;
 end;

begin
  DeltaSize:=-1;
  PageControl1.ActivePage:=TabSheet1;
  LoadTree(TreeView1,Memo1);
  TreeView1.Items[0].Children[0].Expanded:=True;
  TreeView1.HotTrack.Active:=True;

  with TreeView1.CrossBox do
  begin
    Border.Color:=clYellow;
    Brush.Color:=clBlue;
    SignPen.Color:=clWhite;
  end;

  {$IFDEF D4}
  PageExample.HotTrack:=True;
  {$ENDIF}

  VersionFontColor:=clRed;
  VersionBorderColor:=clWhite;
end;

procedure TTeeTree2Form.ShowFormClass(AClass: TFormClass);
begin
  { create and insert a Form, then show it... }
  if Assigned(AClass) then
  begin
    tmpForm:=AClass.Create(Self);
    with tmpForm do
    begin
      Visible:=False;
      BorderStyle:=TeeFormBorderStyle;
      Parent:=TabExample;
      Align:=alClient;
      Show;
    end;
  end;
end;

{ Find the Form corresponding to the Tree item, and create it }
procedure TTeeTree2Form.ShowForm(ATree:TCustomTree);
var tmp : {$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF};
begin
  if ATree.Selected.First<>nil then
  begin

    tmp:=ATree.Selected.Data;

    if Assigned(tmp) then
    begin
      tmpForm.Free;
      tmpForm:=nil;
      ShowFormClass(PTeeFormInfo(tmp).FormClass);
    end;

    StatusBar1.SimpleText:=ATree.Selected.Text;
  end;
end;

{ Show the corresponding Form, enable / disable the buttons }
Function TTeeTree2Form.TheTree:TTree;
begin
  result:=TreeView1;
end;

procedure TTeeTree2Form.BNextClick(Sender: TObject);
var tmp : Integer;
begin
  with TheTree do
  begin
    tmp:=Shapes.IndexOf(Selected.First);
    if tmp<Shapes.Count-1 then
    begin
      Selected.Clear;
      Inc(tmp);
      Items[tmp].Selected := True;
      if Assigned(Items[tmp].Parent) then
         Items[tmp].Parent.Expanded:=True;
    end;
  end;
end;

procedure TTeeTree2Form.BPreviousClick(Sender: TObject);
var tmp : Integer;
begin
  with TheTree do
  begin
    tmp:=Shapes.IndexOf(Selected.FirsT);
    if tmp>0 then
    begin
      Selected.Clear;
      Dec(tmp);
      Items[tmp].Selected := True;
      if Assigned(Items[tmp].Parent) then
         Items[tmp].Parent.Expanded:=True;
    end;
  end;
end;

procedure TTeeTree2Form.Button1Click(Sender: TObject);
begin
  Close;
end;

// Returns an string containing the build number (version information)
// of this executable.
function BuildNumber: String;
{$IFNDEF CLR}
var tmpSize   : Cardinal;
    tmpHandle : Cardinal;
    tmpInfo   : {$IFDEF CLR}IntPtr{$ELSE}Pointer{$ENDIF};
    tmpName   : {$IFDEF CLR}String{$ELSE}PChar{$ENDIF};
    tmpFileInfo : PVSFixedFileInfo;
    tmpFileSize : Cardinal;
{$ENDIF}
begin
  result:='';

  {$IFNDEF CLR}
  tmpName:=PChar(Application.ExeName);
  tmpSize:=GetFileVersionInfoSize(tmpName,tmpHandle);

  if tmpSize>0 then
  begin
    GetMem(tmpInfo,tmpSize);
    try
      Win32Check(GetFileVersionInfo(tmpName,0,tmpSize,tmpInfo));
      Win32Check(VerQueryValue(tmpInfo,'\',Pointer(tmpFileInfo),tmpFileSize));

      with tmpFileInfo^ do
           result:=IntToStr(LongRec(dwFileVersionMS).Hi)+'.'+
                   IntToStr(LongRec(dwFileVersionMS).Lo)+'.'+
                   IntToStr(LongRec(dwFileVersionLS).Hi)+'.'+
                   IntToStr(LongRec(dwFileVersionLS).Lo);
    finally
      FreeMem(tmpInfo);
    end;
  end;
  {$ENDIF}
end;

procedure TTeeTree2Form.Button2Click(Sender: TObject);
begin
  TeeShowTreeAbout(BuildNumber);
end;

procedure TTeeTree2Form.ShowAll1Click(Sender: TObject);
var t : Integer;
begin
  With TheTree do
  for t:=0 to Items.Count-1 do
  begin
    Selected.Clear;
    Items[t].Selected:=True;
    Application.ProcessMessages;
  end;
end;

procedure TTeeTree2Form.Draw3D1AfterDraw(Sender: TObject);
var tmp : TTeeFont;
begin
  With Draw3D1.Canvas do
  begin
    tmp:=TTeeFont.Create(nil);
    try
      With tmp do
      begin
        Name:='Arial Black';
        Outline.Style:=psSolid;
        OutLine.Visible:=True;
        OutLine.Width:=1;
        OutLine.Color:=VersionBorderColor;
        Style:=[fsBold,fsItalic];
        Size:=26;
        Shadow.HorizSize:=2;
        Shadow.VertSize:=2;
        Color:=VersionFontColor;
      end;
      AssignFont(tmp);
      TextOut(350,-8,'2');
    finally
      tmp.Free;
    end;
  end;
end;

procedure TTeeTree2Form.PageControl1Change(Sender: TObject);
begin
  TreeView1SelectShape(TheTree.Selected.First);
end;

procedure TTeeTree2Form.Presentation1Click(Sender: TObject);
begin
  Presentation1.Checked:=not Presentation1.Checked;
  Timer1.Enabled:=Presentation1.Checked;
  if Timer1.Enabled then TheTree.Selected.Add(TheTree.Items[0]);
end;

procedure TTeeTree2Form.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;
  With TheTree do Selected.Add(Items[Shapes.IndexOf(Selected.First)+1]);
  Timer1.Enabled:=True;
end;

{$R Sound.Res}

Procedure PlaySoundResource(Const Sound:String);
{$IFNDEF CLR}
var tmp : Integer;
{$ENDIF}
begin
  {$IFNDEF CLR}
  tmp:=LoadResource(HInstance,FindResource(HInstance,PChar(Sound),RT_RCDATA));
  PlaySound(LockResource(tmp),HInstance,SND_MEMORY or SND_ASYNC or SND_NODEFAULT);
  {$ENDIF}
end;

procedure TTeeTree2Form.FormDestroy(Sender: TObject);
begin
  PlaySoundResource('THANKYOU');
end;

procedure TTeeTree2Form.Timer2Timer(Sender: TObject);
begin
  Case VersionFontColor of
    clRed   : begin VersionFontColor:=clYellow; VersionBorderColor:=clBlack; end;
    clYellow: begin VersionFontColor:=clBlue;   VersionBorderColor:=clYellow; end;
    clBlue  : begin VersionFontColor:=clGreen;  VersionBorderColor:=clRed; end;
  else        begin VersionFontColor:=clRed;    VersionBorderColor:=clWhite; end;
  end;
  Draw3D1.Repaint;
end;

procedure TTeeTree2Form.FormShow(Sender: TObject);
var tmp : String;

  Function FindItem(ATree:TTree):Boolean;
  var t : Integer;
  begin
    result:=False;
    With ATree do
    for t:=0 to Items.Count-1 do
    if Assigned(Items[t].Data) and
       (UpperCase(PTeeFormInfo(Items[t].Data).FormClass.ClassName)=tmp) then
    begin
      Items[t].Selected:=True;
      result:=True;
      exit;
    end;
  end;

begin
  if IsWindowsNT then { minimize used memory in Windows NT... }
     SetProcessWorkingSetSize(GetCurrentProcess,$FFFFFFFF,$FFFFFFFF);

  {$IFNDEF D5}
  TabWeb.TabVisible:=False;
  {$ENDIF}

  if ParamCount>0 then { find a Form... }
  begin
    tmp:=UpperCase(ParamStr(1));
    FindItem(TreeView1);
  end;
  PageExample.ActivePage:=TabExample;
end;

Const Tee5RegistryKey='\Software\Steema Software\TeeTree v2 VCL';
      SteemaDotCom='http://www.steema.com/support/teetree/2/examples';
      ProjectFileName='TeeTree2New.dpr';

Function CodePath:String;
begin
  result:='';
  With TRegistry.Create do
  try
    if {$IFNDEF D4}OpenKey{$ELSE}OpenKeyReadOnly{$ENDIF}(Tee5RegistryKey
                     {$IFNDEF D4},False{$ENDIF}) then
       result:=ReadString('DemoPath');
  finally
    Free;
  end;
  if result='' then
     if FileExists(ProjectFileName) then
        result:=GetCurrentDir
     else
     if FileExists('Sources\'+ProjectFileName) then
        result:=GetCurrentDir+'\Sources';
end;

Function TTeeTree2Form.CodeFile:String;
begin
  if Assigned(TheTree.Selected) and
     Assigned(TheTree.Selected.Data) then
     result:=PTeeFormInfo(TheTree.Selected.Data).UnitName
  else
     result:='';
end;

{$IFNDEF CLX}
Procedure HighLight(RichEdit:TCustomRichEdit);
var p   : Integer;
    Len : Integer;
    tmp : String;

  Function IsKeyword(Const S:String):Boolean;
  Const Keywords:Array[0..35] of String=
         ('UNIT','INTERFACE','BEGIN','IMPLEMENTATION','PROCEDURE','INHERITED',
          'INITIALIZATION','END','CLASS','TYPE','VAR','PRIVATE','PUBLIC',
          'IF','ELSE','WHILE','FOR','REPEAT','RECORD','OBJECT','FUNCTION',
          'STRING','CONST','AND','NOT','IN','DO','THEN','WITH','USES',
          'TRY','FINALLY','EXCEPT','PACKED','CASE','OF');

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
      else 
         Inc(p);
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

{$WARNINGS OFF}
procedure TTeeTree2Form.PageExampleChange(Sender: TObject);

  {$IFNDEF CLR}
  {$IFDEF D5}
  Procedure WebWrite(Const S:String);
  begin
    WebBrowser1.Navigate('about:'+S);
  end;
  {$ENDIF}
  {$ENDIF}

{$IFDEF D5}
var URL       : String;
{$ENDIF}
begin
  if PageExample.ActivePage=TabSource then
  begin
    if not FileExists(CodePath+'\TeeTree2New.dpr') then
    With TRegistry.Create do
    try
      DeleteKey(Tee5RegistryKey);
    finally
      Free;
    end;

    ButtonConfig.Visible:=CodePath='';
    if (CodePath<>'') and (CodeFile<>'') then
    begin
      if OldCodeFile<>CodeFile then
      begin
        {$IFNDEF CLX}
        RichEditCode.Free;
        RichEditCode:=TRichEdit.Create(Self);

        With RichEditCode do
        begin
          Align:=alClient;

          ReadOnly:=True;
          WordWrap:=False;

          ScrollBars:=ssBoth;
          Font.Name:='Courier New';
          Font.Size:=9;
          Parent:=TabSource;
          Lines.LoadFromFile(CodePath+'\'+CodeFile+'.pas');
        end;

        HighLight(RichEditCode);
        {$ENDIF}

        OldCodeFile:=CodeFile;
      end;
    end
    {$IFNDEF CLX}
    else RichEditCode.Free;
    {$ENDIF}
  end
  {$IFDEF D5}
  {$IFNDEF CLX} 
  else
  if PageExample.ActivePage=TabWeb then
  begin
    {$IFNDEF CLR}
    if not Assigned(WebBrowser1) then
    begin
      WebBrowser1:=TWebBrowser.Create(Self);
      WebBrowser1.Align:=alClient;
      TabWeb.InsertControl(WebBrowser1);
    end;

    if Assigned(TheTree.Selected) and
       Assigned(TheTree.Selected.Data) then
    begin
      WebWrite('Loading page from Steema.com ...');
      URL:=SteemaDotCom+'/'+PTeeFormInfo(TheTree.Selected.Data).FormClass.ClassName+'.htm';
      WebBrowser1.Navigate(URL);
      StatusBar1.SimpleText:=URL;
    end
    else
       WebWrite('All information about TeeTree at <a href="http://www.steema.com">www.Steema.com</a> !');
    {$ENDIF}
    
  end;
  {$ENDIF}
  {$ENDIF}
end;
{$WARNINGS ON}

procedure TTeeTree2Form.ButtonConfigClick(Sender: TObject);
var tmpDir : String;
begin
  {$IFDEF D4}
  if SelectDirectory('Folder with TeeTree v2 Demo Sources',
                     '',tmpDir) then
  {$ELSE}
  if SelectDirectory(tmpDir,[],0) then
  {$ENDIF}
  begin
    With TRegistry.Create do
    try
      if OpenKey(Tee5RegistryKey,True) then
         WriteString('DemoPath',tmpDir);
    finally
      Free;
    end;
    PageExampleChange(Self);
  end;
end;

procedure TTeeTree2Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled:=False;
  Timer2.Enabled:=False;
  Timer3.Enabled:=False;
end;

procedure TTeeTree2Form.Timer3Timer(Sender: TObject);
begin
  with TreeNodeShape1.Font do
  begin
    InterCharSize:=InterCharSize+DeltaSize;
    if InterCharSize=7 then DeltaSize:=-1 else
    if InterCharSize=0 then DeltaSize:=1;
  end;
  ArrowRightShape1.Left:=ArrowRightShape1.Left+2*DeltaSize;
end;

procedure TTeeTree2Form.TreeView1SelectShape(Sender: TTreeNodeShape);
begin
  // nice formatting...
  with Sender.Font do Style:=Style+[fsBold];
  Sender.Font.Shadow.HorizSize:=2;
  Sender.Font.Shadow.Color:=clBlack;
  Sender.Font.Color:=clBlue;

  PageExample.ActivePage:=TabExample;

  ShowForm(Sender.Tree);

  with Sender.Tree do
  begin
    BPrevious.Enabled := (Selected.Count>0) and
                      (Shapes.IndexOf(Selected.First)>0);
    BNext.Enabled := Assigned(Selected) and (Shapes.IndexOf(Selected.First)<Items.Count-1);
    TabSource.TabVisible:=CodeFile<>'';
  end;
end;

procedure TTeeTree2Form.TreeView1ExpandedCollapsed(Sender: TTreeNodeShape);
begin
  if Sender.Expanded then Sender.ImageListIndex:=2
                     else Sender.ImageListIndex:=0;
end;

procedure TTeeTree2Form.TreeNodeShape2Click(Sender: TTreeNodeShape;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TeeGotoURL(Handle, Sender.SimpleText);
end;

procedure TTeeTree2Form.TreeView1UnSelectShape(Sender: TTreeNodeShape);
begin
  with Sender.Font do Style:=Style-[fsBold];
  Sender.Font.Shadow.HorizSize:=0;
  Sender.Font.Color:=clBlack;
end;

end.
