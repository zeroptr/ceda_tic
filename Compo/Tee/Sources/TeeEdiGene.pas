{**********************************************}
{  TCustomChart (or derived) Editor Dialog     }
{  Copyright (c) 1996-2009 by David Berneda    }
{**********************************************}
unit TeeEdiGene;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     Qt, QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     {$ENDIF}
     Chart, TeCanvas, TeePenDlg, TeeProcs, TeeNavigator, TeeEdiFont;

type
  TFormTeeGeneral = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    LSteps: TLabel;
    Label1: TLabel;
    CBAllowZoom: TCheckBox;
    CBAnimatedZoom: TCheckBox;
    SEAniZoomSteps: TEdit;
    UDAniZoomSteps: TUpDown;
    BZoomPen: TButtonPen;
    BZoomColor: TButton;
    EMinPix: TEdit;
    UDMinPix: TUpDown;
    TabSheet2: TTabSheet;
    RGPanning: TRadioGroup;
    Label2: TLabel;
    CBDir: TComboFlat;
    Label3: TLabel;
    CBZoomMouse: TComboFlat;
    Label4: TLabel;
    CBScrollMouse: TComboFlat;
    CBUpLeft: TCheckBox;
    TabCursor: TTabSheet;
    Label6: TLabel;
    CBCursor: TComboFlat;
    GroupBox1: TGroupBox;
    ImageCursor: TImage;
    TabFont: TTabSheet;
    LBFonts: TListBox;
    Panel1: TPanel;
    PanelFont: TPanel;
    Splitter1: TSplitter;
    BLoad: TButton;
    OpenDialog1: TOpenDialog;
    procedure CBAllowZoomClick(Sender: TObject);
    procedure CBAnimatedZoomClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RGPanningClick(Sender: TObject);
    procedure SEAniZoomStepsChange(Sender: TObject);
    procedure BZoomColorClick(Sender: TObject);
    procedure EMinPixChange(Sender: TObject);
    procedure CBDirChange(Sender: TObject);
    procedure CBZoomMouseChange(Sender: TObject);
    procedure CBScrollMouseChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBCursorChange(Sender: TObject);
    procedure CBUpLeftClick(Sender: TObject);
    procedure LBFontsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure LBFontsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageControl1Change(Sender: TObject);
    procedure BLoadClick(Sender: TObject);
  private
    { Private declarations }
    IBackup     : TTeeFont;
    IFont       : TTeeFont;
    IFontEditor : TTeeFontEditor;
    OldChange   : TNotifyEvent;

    procedure ChangeCursor(ACursor:TCursor);
    procedure ChangedFont(Sender: TObject);
    Procedure EnableZoomControls;

    {$IFDEF D6}
    procedure FillFonts;
    {$ENDIF}

    procedure ResetIFont;
    function SelectedFont(Index:Integer):TTeeFont;
  public
    { Public declarations }
    TheChart : TCustomChart;

    Constructor CreateChart(Owner:TComponent; AChart:TCustomChart);
  end;

  // 5.03 Moved here from TeeNavigator.pas unit.
  // Now TeeNavigator is an abstract class.

  TChartPageNavigator=class(TCustomTeeNavigator)
  private
    function GetChart: TCustomChart;
    procedure SetChart(const Value: TCustomChart);
  protected
    procedure BtnClick(Index: TTeeNavigateBtn); override;
    procedure DoTeeEvent(Event: TTeeEvent); override;
    procedure SetPanel(const Value: TCustomTeePanel); override;
  public
    procedure EnableButtons; override;
    Function PageCount:Integer; override;
    procedure Print; override;
  published
    property Chart:TCustomChart read GetChart write SetChart;
    property OnButtonClicked;
  end;

Procedure ChartPreview(AOwner:TComponent; TeePanel:TCustomTeePanel);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  {$IFDEF D6}
  TypInfo,
  {$ENDIF}
  {$IFDEF CLX}
  TeePreviewPanel,
  {$ENDIF}
  TeeConst, TeEngine, TeeStore, TeeBrushDlg, TeePrevi;

Procedure ChartPreview(AOwner:TComponent; TeePanel:TCustomTeePanel);
Begin
  with TChartPreview.Create(AOwner) do
  try
    PageNavigatorClass:=TChartPageNavigator;
    TeePreviewPanel1.Panel:=TeePanel;
    ShowModal;
  finally
    Free;
    TeePanel.Repaint;
  end;
end;

{ Chart General Editor }
Constructor TFormTeeGeneral.CreateChart(Owner:TComponent; AChart:TCustomChart);
begin
  inherited Create(Owner);
  TheChart:=AChart;
  {$IFDEF D6}
  FillFonts;
  {$ENDIF}
end;

Procedure TFormTeeGeneral.EnableZoomControls;
begin
  EnableControls(TheChart.Zoom.Allow,[ CBAnimatedZoom, UDAniZoomSteps,
                                       SEAniZoomSteps,EMinPix,UDMinPix,
                                       BZoomPen,BZoomColor,CBDir,CBZoomMouse,
                                       CBUpLeft]);
end;

procedure TFormTeeGeneral.CBAllowZoomClick(Sender: TObject);
begin
  TheChart.Zoom.Allow:=CBAllowZoom.Checked;
  EnableZoomControls;
end;

procedure TFormTeeGeneral.CBAnimatedZoomClick(Sender: TObject);
begin
  TheChart.Zoom.Animated:=CBAnimatedZoom.Checked;
end;

procedure TFormTeeGeneral.FormShow(Sender: TObject);
begin
  if Assigned(TheChart) then
  With TheChart do
  begin
    RGPanning.ItemIndex    :=Ord(AllowPanning);

    With Zoom do
    begin
      CBAllowZoom.Checked    :=Allow;
      CBAnimatedZoom.Checked :=Animated;
      UDAniZoomSteps.Position:=AnimatedSteps;
      EnableZoomControls;
      UDMinPix.Position      :=MinimumPixels;
      CBDir.ItemIndex        :=Ord(Direction);
      CBZoomMouse.ItemIndex  :=Ord(MouseButton);
      CBUpLeft.Checked       :=UpLeftZooms;
      BZoomPen.LinkPen(Pen);
    end;

    CBScrollMouse.ItemIndex  :=Ord(ScrollMouseButton);
    CBScrollMouse.Enabled    :=AllowPanning<>pmNone;

    TeeFillCursors(CBCursor,Cursor);
    TeePreviewCursor(Cursor,ImageCursor.Picture);

    {$IFNDEF CLX}
    BLoad.Visible:=not (csDesigning in ComponentState);
    {$ENDIF}
  end;
end;

{$IFDEF D6}
function FontOfPersistent(Instance:TPersistent; FilterOut:TPersistent=nil):TTeeFont;
var t : Integer;
    n : Integer;
    tmpProps : {$IFDEF CLR}TPropList{$ELSE}PPropList{$ENDIF};
    tmpProp  : TObject;
begin
  result:=nil;

  {$IFDEF CLR}
  tmpProps:=GetPropList(Instance);
  n:=Length(tmpProps);
  {$ELSE}
  n:=GetPropList(Instance,tmpProps);
  {$ENDIF}

  if n>0 then
  try
    for t:=0 to n-1 do
    with tmpProps[t]{$IFNDEF CLR}^{$ENDIF} do
    if ({$IFDEF CLR}TypeInfo.TypeKind{$ELSE}PropType^.Kind{$ENDIF}=tkClass) {$IFNDEF CLR}and Assigned(GetProc){$ENDIF} then
    begin
      tmpProp:=GetObjectProp(Instance,tmpProps[t]);

      if tmpProp is TTeeFont then
      begin
        if tmpProp<>FilterOut then
        begin
          result:=TTeeFont(tmpProp);
          break;
        end;
      end
      else
      if tmpProp is TPersistent then
         if not (tmpProp is TComponent) then
         begin
           result:=FontOfPersistent(TPersistent(tmpProp),FilterOut);

           if Assigned(result) then
              break;
         end;
    end;

  finally
    {$IFDEF CLR}
    tmpProps:=nil;
    {$ELSE}
    FreeMemory(tmpProps);
    {$ENDIF}
  end;
end;

procedure TFormTeeGeneral.FillFonts;

  procedure AddAxis(const Description:String; Axis:TChartAxis);
  begin
    with LBFonts.Items do
    begin
      AddObject(Description,Axis.LabelsFont);
      AddObject(TeeTranslateString(Description) +' ('+TeeMsg_AxisTitle+')',Axis.Title.Font);
    end;
  end;

var t   : Integer;
    tmp : TPersistent;
begin
  with LBFonts.Items do
  begin
    Clear;

    AddObject('Legend',TheChart.Legend.Font);
    AddObject('Legend title',TheChart.Legend.Title.Font);
    AddObject('Title',TheChart.Title.Font);
    AddObject('Footer',TheChart.Foot.Font);
    AddObject('SubTitle',TheChart.SubTitle.Font);
    AddObject('SubFooter',TheChart.SubFoot.Font);

    for t:=0 to TheChart.SeriesCount-1 do
    begin
      tmp:=FontOfPersistent(TheChart[t],TheChart[t].Marks.Font);

      if Assigned(tmp) then
         AddObject(SeriesTitleOrName(TheChart[t]),tmp);

      AddObject(SeriesTitleOrName(TheChart[t])+' ('+TeeTranslateString('marks')+')',TheChart[t].Marks.Font);
    end;

    for t:=0 to TheChart.Tools.Count-1 do
    begin
      tmp:=FontOfPersistent(TheChart.Tools[t]);

      if Assigned(tmp) then
         AddObject(TheChart.Tools[t].Name,tmp);
    end;
  end;

  // Do not translate string constants

  AddAxis('Left axis',TheChart.Axes.Left);
  AddAxis('Right axis',TheChart.Axes.Right);
  AddAxis('Top axis',TheChart.Axes.Top);
  AddAxis('Bottom axis',TheChart.Axes.Bottom);
  AddAxis('Depth Top axis',TheChart.Axes.DepthTop);
  AddAxis('Depth axis',TheChart.Axes.Depth);

  for t:=0 to TheChart.CustomAxes.Count-1 do
      AddAxis(TeeTranslateString('Custom axis')+' '+IntToStr(t),TheChart.CustomAxes[t]);

  LBFonts.ItemIndex:=LBFonts.Items.IndexOfObject(TheChart.Title.Font);
  LBFonts.Selected[LBFonts.ItemIndex]:=True;
  LBFontsClick(LBFonts);
end;
{$ENDIF}

procedure TFormTeeGeneral.RGPanningClick(Sender: TObject);
begin
  TheChart.AllowPanning:=TPanningMode(RGPanning.ItemIndex);
  CBScrollMouse.Enabled:=TheChart.AllowPanning<>pmNone;
end;

procedure TFormTeeGeneral.SEAniZoomStepsChange(Sender: TObject);
begin
  if Showing then
     TheChart.Zoom.AnimatedSteps:=UDAniZoomSteps.Position;
end;

procedure TFormTeeGeneral.BZoomColorClick(Sender: TObject);
begin
  EditChartBrush(Self,TheChart.Zoom.Brush);
end;

procedure TFormTeeGeneral.EMinPixChange(Sender: TObject);
begin
  if Showing then
     TheChart.Zoom.MinimumPixels:=UDMinPix.Position
end;

procedure TFormTeeGeneral.CBDirChange(Sender: TObject);
begin
  TheChart.Zoom.Direction:=TTeeZoomDirection(CBDir.ItemIndex);
end;

procedure TFormTeeGeneral.CBZoomMouseChange(Sender: TObject);
begin
  TheChart.Zoom.MouseButton:=TMouseButton(CBZoomMouse.ItemIndex)
end;

procedure TFormTeeGeneral.CBScrollMouseChange(Sender: TObject);
begin
  TheChart.ScrollMouseButton:=TMouseButton(CBScrollMouse.ItemIndex)
end;

procedure TFormTeeGeneral.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  PageControl1.ActivePage:=TabSheet1;

  {$IFNDEF D6}
  TabFont.TabVisible:=False;
  {$ENDIF}

  {$IFDEF D6}
  {$IFNDEF CLX}
  {$IFNDEF LCL}
  LBFonts.BevelInner:=bvNone;
  LBFonts.BevelOuter:=bvNone;
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
end;

procedure TFormTeeGeneral.ChangeCursor(ACursor:TCursor);
begin
  with TheChart do
  begin
    Cursor:=ACursor;
    OriginalCursor:=Cursor;
    TeePreviewCursor(Cursor,ImageCursor.Picture);
  end;
end;

procedure TFormTeeGeneral.CBCursorChange(Sender: TObject);
begin
  ChangeCursor(TeeSetCursor(TheChart.Cursor,CBCursor.CurrentItem));
end;

procedure TFormTeeGeneral.CBUpLeftClick(Sender: TObject);
begin
  TheChart.Zoom.UpLeftZooms:=CBUpLeft.Checked;
end;

function TFormTeeGeneral.SelectedFont(Index:Integer):TTeeFont;
begin
  result:=TTeeFont(LBFonts.Items.Objects[Index]);
end;

procedure TFormTeeGeneral.ResetIFont;
begin
  if Assigned(IFont) then
  begin
    IFont.OnChange:=OldChange;
    IFont:=nil;
  end;

  FreeAndNil(IBackup);
end;

procedure TFormTeeGeneral.LBFontsClick(Sender: TObject);
begin
  ResetIFont;

  if LBFonts.ItemIndex<>-1 then
  begin
    IFont:=SelectedFont(LBFonts.ItemIndex);
    IBackup:=TTeeFont.Create(nil);
    IBackup.Assign(IFont);

    if not Assigned(IFontEditor) then
    begin
      IFontEditor:=TTeeFontEditor.Create(nil);
      IFontEditor.Align:=alClient;
      AddFormTo(IFontEditor,PanelFont);
    end;

    IFontEditor.RefreshControls(IFont);

    OldChange:=IFont.OnChange;
    IFont.OnChange:=ChangedFont;
  end;
end;

procedure TFormTeeGeneral.ChangedFont(Sender: TObject);
var t   : Integer;
    tmp : TTeeFont;
begin
  if Assigned(IFont) then
    if Showing then
    begin
      for t:=0 to LBFonts.Items.Count-1 do
      if LBFonts.Selected[t] then
      begin
        tmp:=SelectedFont(t);

        if tmp<>IFont then
        begin
          if IFont.Name<>IBackup.Name then
             tmp.Name:=IFont.Name;

          if IFont.Size<>IBackup.Size then
             tmp.Size:=IFont.Size;

          if IFont.Style<>IBackup.Style then
             tmp.Style:=IFont.Style;

          if IFont.Color<>IBackup.Color then
             tmp.Color:=IFont.Color;

          if IFont.InterCharSize<>IBackup.InterCharSize then
             tmp.InterCharSize:=IFont.InterCharSize;

          if IFont.Shadow.HorizSize<>IBackup.Shadow.HorizSize then
             tmp.Shadow.HorizSize:=IFont.Shadow.HorizSize;

          if IFont.Shadow.VertSize<>IBackup.Shadow.VertSize then
             tmp.Shadow.VertSize:=IFont.Shadow.VertSize;

          if IFont.Shadow.Color<>IBackup.Shadow.Color then
             tmp.Shadow.Color:=IFont.Shadow.Color;

          if IFont.Shadow.Visible<>IBackup.Shadow.Visible then
             tmp.Shadow.Visible:=IFont.Shadow.Visible;

          if IFont.Shadow.Transparency<>IBackup.Shadow.Transparency then
             tmp.Shadow.Transparency:=IFont.Shadow.Transparency;

          if IFont.Shadow.Smooth<>IBackup.Shadow.Smooth then
             tmp.Shadow.Smooth:=IFont.Shadow.Smooth;

          if IFont.Gradient.Visible<>IBackup.Gradient.Visible then
             tmp.Gradient.Visible:=IFont.Gradient.Visible;

          //tmp.Assign(IFont); // everything?
        end;
      end;

      IBackup.Assign(IFont);

      if Assigned(OldChange) then
         OldChange(IFont);
    end
    else
       ResetIFont;
end;

procedure TFormTeeGeneral.FormDestroy(Sender: TObject);
begin
  ResetIFont;
end;

{ TChartPageNavigator }
procedure TChartPageNavigator.BtnClick(Index: TTeeNavigateBtn);
var tmp : TChartPage;
begin
  tmp:=Chart.Pages;

  if Assigned(tmp) then
  with tmp do
  case Index of
    nbPrior : PreviousPage;
    nbNext  : NextPage;
    nbFirst : Current:=1;
    nbLast  : Current:=Count;
  end;

  EnableButtons;

  inherited;
end;

procedure TChartPageNavigator.SetPanel(const Value: TCustomTeePanel);
begin
  if Value is TCustomAxisPanel then inherited
                               else inherited SetPanel(nil);
end;

procedure TChartPageNavigator.EnableButtons;
var tmp : TChartPage;
begin
  inherited;

  if Assigned(Chart) then
  begin
    tmp:=Chart.Pages;

    if Assigned(tmp) then
    begin
      Buttons[nbFirst].Enabled:=tmp.Current>1;
      Buttons[nbPrior].Enabled:=Buttons[nbFirst].Enabled;
      Buttons[nbNext].Enabled:=tmp.Current<tmp.Count;
      Buttons[nbLast].Enabled:=Buttons[nbNext].Enabled;
    end;
  end;
end;

procedure TChartPageNavigator.DoTeeEvent(Event: TTeeEvent);
begin
  if (Event is TChartChangePage) or
     ( (Event is TTeeSeriesEvent) and
       (TTeeSeriesEvent(Event).Event=seDataChanged)
      ) then
        EnableButtons;
end;

function TChartPageNavigator.GetChart: TCustomChart;
begin
  result:=TCustomChart(Panel);
end;

procedure TChartPageNavigator.SetChart(const Value: TCustomChart);
begin
  Panel:=Value;
end;

Function TChartPageNavigator.PageCount:Integer;
begin
  result:=Chart.NumPages;
end;

procedure TChartPageNavigator.Print;
begin
  {$IFNDEF LCL}  // Pending Lazarus TPrintDialog
  if PageCount>1 then
  With TPrintDialog.Create(Self) do
  try
    {$IFNDEF CLX}
    Options:=[poPageNums];
    PrintRange:=prPageNums;
    {$ENDIF}

    FromPage:=1;
    MinPage:=FromPage;
    ToPage:=Chart.NumPages;
    MaxPage:=ToPage;
    if Execute then Chart.PrintPages(FromPage,ToPage);
  finally
    Free;
  end
  else Chart.PrintPages(1,1);
  {$ENDIF}
end;

procedure TFormTeeGeneral.FormDeactivate(Sender: TObject);
begin
  ResetIFont;
end;

{$IFDEF CLX}
{$DEFINE SELECTALLFONTS}
{$ELSE}
{$IFNDEF D6}
{$DEFINE SELECTALLFONTS}
{$ENDIF}
{$ENDIF}

procedure TFormTeeGeneral.LBFontsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
 
{$IFDEF SELECTALLFONTS}
var t : Integer;
{$ENDIF}
begin
  if ssCtrl in Shift then
     if Key=Ord('A') then

        {$IFDEF SELECTALLFONTS}

        with LBFonts do
        for t:=0 to Items.Count-1 do 
            Selected[t]:=True;

        {$ELSE}
        LBFonts.SelectAll;
        {$ENDIF}
end;

procedure TFormTeeGeneral.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=TabFont then
     LBFonts.SetFocus;
end;

procedure TFormTeeGeneral.BLoadClick(Sender: TObject);
{$IFNDEF CLX}

  function CursorIndexOk:TCursor;
  var tmp : {$IFDEF CLX}QCursorH{$ELSE}HCursor{$ENDIF};
  begin
    tmp:=LoadCursor(0, IDC_ARROW);

    result:=TCursor(crTeeHand+1);

    while Screen.Cursors[result]<>tmp do
          Inc(result);
  end;

var tmp : TCursor;
    s   : String;
    {$IFNDEF CLR}
    St  : TeeString256;
    {$ENDIF}

{$ENDIF}
begin
  {$IFNDEF CLX}
  if OpenDialog1.Execute then
  begin
    tmp:=CursorIndexOk;
    s:=OpenDialog1.FileName;
    Screen.Cursors[tmp]:=LoadCursorFromFile({$IFNDEF CLR}StrPCopy(St,s){$ELSE}s{$ENDIF});
    ChangeCursor(tmp);
  end;
  {$ENDIF}
end;

end.
