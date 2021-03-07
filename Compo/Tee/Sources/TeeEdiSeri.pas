{**************************************************}
{  TCustomChartSeries (or derived) Editor Dialog   }
{  Copyright (c) 1996-2009 by David Berneda        }
{**************************************************}
unit TeeEdiSeri;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     QButtons, QGrids, QTypes,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     Grids,
     {$ENDIF}
     {$IFDEF LINUX}
     Types,
     {$ENDIF}
     {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeEngine, TeeCustomShapeEditor, TeeProcs, TeCanvas, TeePenDlg,
     Chart, TeeSourceEdit, TeeChartGrid, TeeNavigator, TeeLisB, TeeMargins;

type
  TFormTeeSeries=class;

  TNotifyTeeEvent=procedure(Sender:TFormTeeSeries; Event:TTeeEvent) of object;

  TFormTeeSeries = class(TForm,ITeeEventListener)
    CBPersistent: TCheckBox;
    PageSeries: TPageControl;
    TheTabSheet: TTabSheet;
    TabGeneral: TTabSheet;
    GB5: TGroupBox;
    L27: TLabel;
    CBShowInLegend: TCheckBox;
    CBCursor: TComboFlat;
    GB2: TGroupBox;
    L15: TLabel;
    L21: TLabel;
    EPercentFormat: TEdit;
    TabMarks: TTabSheet;
    TabDataSource: TTabSheet;
    GBHorizAxis: TGroupBox;
    CBHorizAxis: TComboFlat;
    CBXDateTime: TCheckBox;
    GBVertAxis: TGroupBox;
    CBVertAxis: TComboFlat;
    CBYDateTime: TCheckBox;
    PageControlMarks: TPageControl;
    TabSheet1: TTabSheet;
    CBMarksVisible: TCheckBox;
    CBMarkClip: TCheckBox;
    L23: TLabel;
    SEMarksAngle: TEdit;
    UDMarksAngle: TUpDown;
    Label3: TLabel;
    EMarksEvery: TEdit;
    UDEvery: TUpDown;
    CBMultiLine: TCheckBox;
    LSort: TLabel;
    CBSort: TComboFlat;
    CBSeries: TComboFlat;
    ImageSeries: TImage;
    LabelSeriesClass: TLabel;
    Panel1: TPanel;
    CBFormat: TComboFlat;
    Panel2: TPanel;
    PanTop: TPanel;
    CBDataSourcestyle: TComboFlat;
    LDepth: TLabel;
    EDepth: TEdit;
    UDDepth: TUpDown;
    CBDepth: TCheckBox;
    CBAllVisible: TCheckBox;
    PaintBox1: TPaintBox;
    Panel3: TPanel;
    RGMarkStyle: TComboFlat;
    Label1: TLabel;
    NewDataButton: TButton;
    EditDataButton: TButton;
    DeleteDataButton: TButton;
    ChartGrid1: TChartGrid;
    ChartGridNavigator1: TChartGridNavigator;
    PanelRandomSource: TPanel;
    PanelSeriesSource: TPanel;
    Label2: TLabel;
    ESamples: TEdit;
    CBSamplesDefault: TCheckBox;
    BApplyRandom: TButton;
    TabSheet2: TTabSheet;
    BMarkLinCol: TButtonPen;
    L32: TLabel;
    SEArrowLength: TEdit;
    UDArrowsLength: TUpDown;
    Label4: TLabel;
    EArrowDist: TEdit;
    UDArrowDist: TUpDown;
    BCalloutPointer: TButton;
    Label11: TLabel;
    CBHead: TComboFlat;
    Label12: TLabel;
    Edit1: TEdit;
    UDHeadSize: TUpDown;
    Timer1: TTimer;
    TabSymbol: TTabSheet;
    CBZDateTime: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CBShowInEditor: TCheckBox;
    Label5: TLabel;
    CBSeriesSource: TComboFlat;
    BApplySource: TButton;
    BClearSource: TButton;
    Label6: TLabel;
    CBTextAlign: TComboFlat;
    TabMargins: TTabSheet;
    CBFontSeriesColor: TCheckBox;
    procedure EPercentFormatChange(Sender: TObject);
    procedure PageSeriesChange(Sender: TObject);
    procedure CBSeriesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RGMarkStyleClick(Sender: TObject);
    procedure CBPersistentClick(Sender: TObject);
    procedure CBYDateTimeClick(Sender: TObject);
    procedure CBXDateTimeClick(Sender: TObject);
    procedure CBDataSourcestyleChange(Sender: TObject);
    procedure CBShowInLegendClick(Sender: TObject);
    procedure CBCursorChange(Sender: TObject);
    procedure SEArrowLengthChange(Sender: TObject);
    procedure CBMarkClipClick(Sender: TObject);
    procedure CBMarksVisibleClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SEMarksAngleChange(Sender: TObject);
    procedure CBHorizAxisChange(Sender: TObject);
    procedure CBVertAxisChange(Sender: TObject);
    procedure EMarksEveryChange(Sender: TObject);
    procedure CBMultiLineClick(Sender: TObject);
    procedure CBSortChange(Sender: TObject);
    procedure CBFormatChange(Sender: TObject);
    procedure PageSeriesChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure CBDepthClick(Sender: TObject);
    procedure EDepthChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CBAllVisibleClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure CBSamplesDefaultClick(Sender: TObject);
    procedure ESamplesChange(Sender: TObject);
    procedure BApplyRandomClick(Sender: TObject);
    procedure EArrowDistChange(Sender: TObject);
    procedure BCalloutPointerClick(Sender: TObject);
    procedure CBHeadChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ChartGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure Timer1Timer(Sender: TObject);
    procedure CBZDateTimeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CBShowInEditorClick(Sender: TObject);
    procedure CBSeriesSourceChange(Sender: TObject);
    procedure BApplySourceClick(Sender: TObject);
    procedure BClearSourceClick(Sender: TObject);
    procedure PageControlMarksChange(Sender: TObject);
    procedure CBTextAlignChange(Sender: TObject);
    procedure CBFontSeriesColorClick(Sender: TObject);
  private
    { Private declarations }
    TheChart        : TCustomAxisPanel;
    CreatingForm    : Boolean;
    ChangingPage    : Boolean;
    IMarksMargins   : TMarginsEditor;
    IMarksObject    : TFormTeeShape;
    IMarksSymbol    : TFormTeeShape;
    LastSeries      : TChartSeries;
    FOnTeeEvent     : TNotifyTeeEvent;

    Function AddToTab(AForm:TForm; ATab:TTabSheet; AObject:TPersistent):TForm;
    Function AllSeriesMarksVisible:Boolean;
    Function CanModifySeries:Boolean;
    Function CheckCanClose:Boolean;
    procedure CheckCBSamples;
    procedure DestroyDataSourceForm;
    procedure EnableMultiLine;
    procedure FillAxis(Items:TStrings; Horizontal:Boolean);
    Function FindZList:TChartValueList;  // 7.0
    procedure SetTabDataSource;

  {$IFDEF CLR}
  protected
  {$ENDIF}
    procedure TeeEvent(Event: TTeeEvent);  { interface }

  protected
    procedure CreateDataSourceForm;
  public
    { Public declarations }
    TheSeries             : TChartSeries;
    IsDssGraph            : Boolean;
    ShowTabDataSource     : Boolean;
    ShowTabGeneral        : Boolean;
    ShowTabMarks          : Boolean;
    DataSourceStyle       : TBaseSourceEditor;
    TheListBox            : TChartListBox;

    procedure DestroySeriesForms;
    Procedure FillAxes;

    class function InsertSeriesForm( AParent:TControl;
                                     EditorClass:TFormClass;
                                     Position:Integer;
                                     Const EditorTabName:String;
                                     AnObject:TPersistent):TCustomForm;

    class Function MarkSymbolsForm(AOwner: TComponent;
                              Symbol:TSeriesMarksSymbol;
                              AParent:TWinControl=nil):TFormTeeShape;
    Procedure SetCBSeries;

    property OnTeeEvent:TNotifyTeeEvent read FOnTeeEvent write FOnTeeEvent;
  end;

  { Used by TeeChart Pro ActiveX and TeeChartOffice }
  TOnCreateEditSeries=Procedure(Sender:TFormTeeSeries; AChart:TCustomChart);
  TOnCreateEditSeriesObj=Procedure(Sender:TFormTeeSeries; AChart:TCustomChart) of object;

var InternalOnCreateEditSeries:TOnCreateEditSeries=nil;
    InternalOnCreateEditSeriesObj:TOnCreateEditSeriesObj=nil;

Function SeriesEditorForm(Series:TChartSeries):TFormClass;

// Modally shows the Series editor dialog for ASeries
procedure EditSeriesDialog(AOwner:TComponent; ASeries:TChartSeries);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst, TeeGally, TeeBrushDlg, TeeFuncEdit, TeePoEdi, TeeFormatting,
     Series // <-- used due to TPointSeries editor trick
     ;

procedure EditSeriesDialog(AOwner:TComponent; ASeries:TChartSeries);
var tmp : TFormTeeSeries;
begin
  tmp := TeeCreateForm(TFormTeeSeries,AOwner) as TFormTeeSeries;
  with tmp do
  try
    TeeTranslateControl(tmp);

    BorderIcons:=[biSystemMenu];
    BorderStyle:={$IFDEF CLX}fbsSizeable{$ELSE}bsSizeable{$ENDIF};

    {$IFNDEF LCL}
    Scaled:=False;
    {$ENDIF}
    Caption:=Format(TeeMsg_Editing,[ASeries.Name]);
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(ASeries);

    Panel1.Hide;

    ShowTabDataSource:=False;
    TheSeries:=ASeries;
    CBSeries.AddItem(ASeries.Name,TheSeries);
    CBSeries.ItemIndex:=0;
    CBSeriesChange(CBSeries);

    ShowModal;
  finally
    Free;
  end;
end;

{ TFormTeeSeries}
procedure TFormTeeSeries.EPercentFormatChange(Sender: TObject);
begin
  TheSeries.PercentFormat:=LocalToDelphiFormat(EPercentFormat.Text);
end;

Procedure TFormTeeSeries.SetCBSeries;
begin
  if Assigned(TheSeries) then
  begin
    CBSeries.ItemIndex:=CBSeries.Items.IndexOfObject(TheSeries);
    CBSeriesChange(Self);
  end
  else PageSeries.Visible:=False;
end;

procedure TFormTeeSeries.EnableMultiLine;
begin
  CBMultiLine.Enabled:=TheSeries.Marks.Style in
    [smsLabelPercent,smsLabelValue,smsPercentTotal,smsLabelPercentTotal,smsXY];
end;

procedure TFormTeeSeries.FillAxis(Items:TStrings; Horizontal:Boolean);
var t : Integer;
begin
  With Items do While Count>3 do Delete(Count-1);

  With TheSeries.ParentChart do
  begin
    for t:=TeeInitialCustomAxis to Axes.Count-1 do
    if (Axes[t].Horizontal and Horizontal) or
       ((not Axes[t].Horizontal) and (not Horizontal)) then
         Items.AddObject(TeeMsg_CustomAxesEditor+' '+IntToStr(t-TeeInitialCustomAxis),Axes[t]);
  end;
end;

Function TFormTeeSeries.AllSeriesMarksVisible:Boolean;
var t : Integer;
begin
  result:=True;
  With TheSeries.ParentChart do
  for t:=0 to SeriesCount-1 do
  if not Series[t].Marks.Visible then
  begin
    result:=False;
    exit;
  end;
end;

class Function TFormTeeSeries.MarkSymbolsForm(AOwner: TComponent;
              Symbol:TSeriesMarksSymbol; AParent:TWinControl=nil):TFormTeeShape;
var tmp : TCheckBox;
begin
  // Speed optimization, pass "nil" as owner.
  result:=TFormTeeShape.CreateForm(nil {AOwner},Symbol,AParent);

  with result do
  begin
    BBackColor.Hide;
    PC1.HandleNeeded;
    TabText.TabVisible:=False;

    tmp:=TCheckBox.Create(result);
    with tmp do
    begin
      Left:=BBackColor.Left;
      Top:=BBackColor.Top;
      Width:=BBackColor.Width;
      Caption:='&Visible'; // Do not localize
      Checked:=Symbol.Visible;
      OnClick:=CBVisibleChecked;
      Parent:=TabFormat;
    end;
  end;
end;

procedure TFormTeeSeries.PageSeriesChange(Sender: TObject);

  procedure SetTabSeriesMarks;
  begin
    if not Assigned(IMarksObject) then
    begin
      IMarksObject:=InsertTeeObjectForm(PageControlMarks,nil);
      IMarksSymbol:=MarkSymbolsForm(Self,TheSeries.Marks.Symbol,TabSymbol);

      IMarksMargins:=TMarginsEditor.Create(Self);
      AddFormTo(IMarksMargins,TabMargins);
    end;

    With TheSeries.Marks do
    begin
      RGMarkStyle.ItemIndex  :=Ord(Style);
      UDArrowsLength.Position:=Callout.Length;
      UDArrowDist.Position   :=Callout.Distance;
      UDMarksAngle.Position  :=Angle;
      CBMarkClip.Checked     :=Clip;
      UDEvery.Position       :=DrawEvery;
      CBMultiLine.Checked    :=MultiLine;
      CBMarksVisible.Checked :=Visible;
      BMarkLinCol.LinkPen(Callout.Arrow);
      CBHead.ItemIndex       :=Ord(Callout.ArrowHead);
      UDHeadSize.Position    :=Callout.ArrowHeadSize;
      CBTextAlign.ItemIndex  :=Ord(TextAlign);
      CBFontSeriesColor.Checked := FontSeriesColor;
    end;

    CBAllVisible.Checked:=AllSeriesMarksVisible;
    EnableMultiLine;

    IMarksMargins.RefreshControls(TheSeries.Marks.Margins);
    IMarksObject.RefreshControls(TheSeries.Marks);
    IMarksSymbol.RefreshControls(TheSeries.Marks.Symbol);
  end;

  procedure SetTabSeriesGeneral;
  var tmpSt     : String;
      tmpCursor : TCursor;
      tmpList   : TChartValueList;
  begin
    if Assigned(TheSeries) then
    With TheSeries do
    begin
      CBShowInLegend.Checked   :=ShowInLegend;
      CBDepth.Checked          :=Depth=-1;
      if Depth=-1 then UDDepth.Position:=0
                  else UDDepth.Position:=Depth;

      AddDefaultValueFormats(CBFormat.Items);

      tmpSt:=DelphiToLocalFormat(ValueFormat);
      With CBFormat.Items do if IndexOf(tmpSt)=-1 then Add(tmpSt);
      CBFormat.Text:=tmpSt;

      EPercentFormat.Text:=DelphiToLocalFormat(PercentFormat);

      FillAxes;

      With CBHorizAxis do
      Case TheSeries.HorizAxis of
        aTopAxis:       ItemIndex:=0;
        aBottomAxis:    ItemIndex:=1;
        aBothHorizAxis: ItemIndex:=2;
      else
        ItemIndex:=Items.IndexOfObject(TheSeries.CustomHorizAxis);
      end;

      With CBVertAxis do
      Case TheSeries.VertAxis of
        aLeftAxis:     ItemIndex:=0;
        aRightAxis:    ItemIndex:=1;
        aBothVertAxis: ItemIndex:=2;
      else
        ItemIndex:=Items.IndexOfObject(TheSeries.CustomVertAxis);
      end;

      CBXDateTime.Checked:=XValues.DateTime;
      CBYDateTime.Checked:=YValues.DateTime;

      tmpList:=FindZList;
      CBZDateTime.Visible:=Assigned(tmpList);
      if CBZDateTime.Visible then
         CBZDateTime.Checked:=tmpList.DateTime;

      Case MandatoryValueList.Order of
        loNone       : CBSort.ItemIndex:= 2;
        loAscending  : CBSort.ItemIndex:= 0;
        loDescending : CBSort.ItemIndex:= 1;
      end;

      ShowControls(ValuesList.Count<=2,[CBSort,LSort,LDepth,EDepth,UDDepth,CBDepth]);

      tmpCursor:=Cursor;
    end
    else tmpCursor:=crDefault;

    TeeFillCursors(CBCursor,tmpCursor);
  end;

begin
  With PageSeries do
  if ActivePage=TabGeneral then SetTabSeriesGeneral else
  if ActivePage=TabMarks then SetTabSeriesMarks     else
  if ActivePage=TabDataSource then SetTabDataSource;

  ChangingPage:=False;
end;

Procedure TFormTeeSeries.FillAxes;
begin
  FillAxis(CBHorizAxis.Items,True);
  FillAxis(CBVertAxis.Items,False);
end;

type
   TChartSeriesAccess=class(TChartSeries);

procedure TFormTeeSeries.SetTabDataSource;
var tmp : Integer;
    t   : Integer;
    tmpSource : TTeeSeriesSourceClass;
begin
  {$IFDEF CLX}
  if not Assigned(TheSeries) then exit;
  {$ENDIF}

  tmp:=CBDataSourceStyle.ItemIndex;

  if Assigned(TheSeries.FunctionType) then
     CBDataSourceStyle.ItemIndex:=3
  else
  if not Assigned(TheSeries.DataSource) then
  begin
    if (TheSeries.Count>0) and (not TChartSeriesAccess(TheSeries).ManualData) then
       CBDataSourceStyle.ItemIndex:=1
    else
       CBDataSourceStyle.ItemIndex:=0;
  end
  else
  if TheSeries.DataSource is TChartSeries then
     CBDataSourceStyle.ItemIndex:=2
  else
  begin
    tmpSource:=nil;
    for t:=0 to TeeSources.Count-1 do
    if TTeeSeriesSourceClass(TeeSources[t]).HasSeries(TheSeries) then
    begin
      tmpSource:=TTeeSeriesSourceClass(TeeSources[t]);
      break;
    end;

    With CBDataSourceStyle do
    if Assigned(tmpSource) then
       ItemIndex:=Items.IndexOfObject(TObject(tmpSource))
    else
       ItemIndex:=0;
  end;

  if CBDataSourceStyle.ItemIndex<>tmp then
     CreateDataSourceForm;
end;

Function TFormTeeSeries.AddToTab(AForm:TForm; ATab:TTabSheet; AObject:TPersistent):TForm;
begin
  result:=AForm;
  result.Align:=alClient;
  TeeTranslateControl(result);
  AddFormTo(result,ATab,AObject);
end;

class function TFormTeeSeries.InsertSeriesForm(AParent:TControl;
                                               EditorClass:TFormClass;
                                               Position:Integer;
                                               Const EditorTabName:String;
                                               AnObject:TPersistent):TCustomForm;
var tmpPage  : TTabSheet;
begin
  if Assigned(AParent) and Assigned(AParent.Owner) and
     (AParent.Owner is TFormTeeSeries) then
  begin
    tmpPage:=TTabSheet.Create(AParent.Owner);

    With tmpPage do
    begin
      PageControl:=TFormTeeSeries(AParent.Owner).PageSeries;
      PageIndex:=Position;
      Caption:=EditorTabName;
    end;

    result:=TFormTeeSeries(AParent.Owner).AddToTab(EditorClass.Create(AParent.Owner),tmpPage,AnObject);
  end
  else
  begin
    result:=EditorClass.Create(AParent);
    result.Caption:=EditorTabName;
    result.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(AnObject);
  end;
end;

{$IFNDEF CLR}
type
  TTeePanelAccess=class(TCustomTeePanel);
{$ENDIF}

procedure TFormTeeSeries.DestroySeriesForms;
var t       : Integer;
    tmpPage : TTabSheet;
begin
  while TheTabSheet.ControlCount>0 do
        TheTabSheet.Controls[0].Free;

  t:=0;

  while t<PageSeries.PageCount do
  begin
    tmpPage:=PageSeries.Pages[t];

    if (tmpPage<>TheTabSheet) and (tmpPage<>TabGeneral) and
       (tmpPage<>TabMarks) and (tmpPage<>TabDataSource) then
    begin
      while tmpPage.ControlCount>0 do
            tmpPage.Controls[0].Free;

      if (tmpPage.PageIndex>0) and
         (not (csDestroying in tmpPage.PageControl.ComponentState)) and
         (not (csDestroying in tmpPage.ComponentState)) then
              tmpPage.Free
      else
         Inc(t);
    end
    else Inc(t);
  end;

  DestroyDataSourceForm;
end;

Function SeriesEditorForm(Series:TChartSeries):TFormClass;
begin
  result:=TFormClass(GetClass(Series.EditorClass));
end;

procedure TFormTeeSeries.CBSeriesChange(Sender: TObject);

  Procedure CreateTheSeriesForm;
  var tmpClass : TFormClass;
  begin
    tmpClass:=SeriesEditorForm(TheSeries);
    if Assigned(tmpClass) then
       AddToTab(tmpClass.Create(Self),TheTabSheet,TheSeries)
    else
    begin
      DestroySeriesForms;
      TheTabSheet.TabVisible:=False;
    end;
  end;

  Procedure HideSeriesPage;
  begin
    ImageSeries.Visible:=False;
    LabelSeriesClass.Caption:='';
    PageSeries.Visible:=False;
  end;

  Function FindTab(Const ATab:String):TTabSheet;
  var t : Integer;
  begin
    with PageSeries do
    begin
      result:=nil;
      for t:=0 to PageCount-1 do
      if Pages[t].Caption=ATab then
      begin
        result:=Pages[t];
        break;
      end;
    end;
  end;

  Procedure AddTeeSources;
  var t: Integer;
      tmpSource : TTeeSeriesSourceClass;
  begin
    { remove source styles from combobox }
    with CBDataSourceStyle.Items do
         while Count>4 do Delete(Count-1);

    { add sources that are available for this chart type }
    for t:=0 to TeeSources.Count-1 do { 5.02 }
    begin
      tmpSource:=TTeeSeriesSourceClass(TeeSources[t]);
      if CBDataSourceStyle.Items.IndexOfObject(TObject(tmpSource))=-1 then
         if tmpSource.Available(TheSeries.ParentChart) then
            CBDataSourceStyle.Items.AddObject(tmpSource.Description,TObject(tmpSource));
    end;
  end;

  procedure ChangeSeriesForms(OldTab:String);
  const
    MenuShortCut='&';  // Do not localize

  var tmpBitmap : TBitmap;
      tmpString : string;
      Index: Integer;
  begin
    TheChart:=TheSeries.ParentChart;

    if Assigned(TheChart) then
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(TheChart).Listeners.Add(Self);

    AddTeeSources;

    tmpBitmap:=TBitmap.Create;
    try
      TeeGetBitmapEditor(TheSeries,tmpBitmap);
      ImageSeries.Picture.Assign(tmpBitmap);
    finally
      tmpBitmap.Free;
    end;

    PaintBox1.Visible:=TChartSeriesAccess(TheSeries).IUseSeriesColor;

    tmpString := GetGallerySeriesName(TheSeries);

    // Example: Replace "Point & Figure" with --> "Point && Figure"

    Index := Pos(MenuShortCut, tmpString);

    if Index > 0 then
       Insert(MenuShortCut, tmpString, Index + 1);

    LabelSeriesClass.Caption:=tmpString+': '+SeriesTitleOrName(TheSeries); // Do not localize

    ImageSeries.Visible:=True;
    PageSeries.Visible:=True;
    TabGeneral.TabVisible:=ShowTabGeneral;
    TabMarks.TabVisible:=ShowTabMarks;
    TabDataSource.TabVisible:=ShowTabDataSource and
                              ( (not (tssIsTemplate in TheSeries.Style)) and
                                (not (tssHideDataSource in TheSeries.Style)) );

    if (OldTab='') or
       ((OldTab=TabDataSource.Caption) and (not TabDataSource.TabVisible)) then
         OldTab:=TheTabSheet.Caption;

    ShowControls(TheSeries.UseAxis,[ GBHorizAxis,GBVertAxis ]);
    CBPersistent.Visible:=IsDssGraph and (not (tssIsTemplate in TheSeries.Style));
    if CBPersistent.Visible then
       CBPersistent.Checked:=(tssIsPersistent in TheSeries.Style);

    DestroySeriesForms;
    CreateTheSeriesForm;

    PageSeries.ActivePage:=FindTab(OldTab);
    if (OldTab='') or (PageSeries.ActivePage=nil) then
       PageSeries.ActivePage:=TheTabSheet;

    if not PageSeries.ActivePage.TabVisible then
       PageSeries.ActivePage:=TabGeneral;

    CBDataSourceStyle.ItemIndex:=-1;
    PageSeriesChange(Self);

    PaintBox1.Repaint; { 5.02 }
  end;

var OldTab : String;
begin
  CreatingForm:=True;

  if Assigned(PageSeries.ActivePage) then OldTab:=PageSeries.ActivePage.Caption
                                     else OldTab:='';

  With CBSeries do
  if ItemIndex<>-1 then
  begin
    TheSeries:=TChartSeries(SelectedObject);

    if Assigned(TheSeries) then
    begin
      if Assigned(TheListBox) then
      begin
        TheListBox.ClearSelection;
        TheListBox.SelectedSeries:=TheSeries; // 6.0 Synchronize main ChartListBox
      end;

      if TheSeries<>LastSeries then
      begin
        ChangeSeriesForms(OldTab);
        LastSeries:=TheSeries;
      end;
    end
    else HideSeriesPage;
  end
  else HideSeriesPage;

  CreatingForm:=False;
end;

procedure TFormTeeSeries.FormCreate(Sender: TObject);
begin
  ChangingPage:=False;
  CreatingForm:=True;

  ShowTabDataSource:=True;
  ShowTabGeneral:=True;
  ShowTabMarks:=True;
  IsDssGraph:=False;

  CBDataSourceStyle.DropDownCount:=12; { 5.02 }
  CBDataSourceStyle.Items.Objects[3]:=TObject(TTeeFuncEditor); { 5.02 }
  PageSeries.ActivePage:=TheTabSheet;
  PageControlMarks.ActivePage:=TabSheet1;
end;

procedure TFormTeeSeries.RGMarkStyleClick(Sender: TObject);
begin
  TheSeries.Marks.Style:=TSeriesMarksStyle(RGMarkStyle.ItemIndex);
  EnableMultiLine;
end;

procedure TFormTeeSeries.CBPersistentClick(Sender: TObject);
begin
  With TheSeries do
  if CBPersistent.Checked then Style:=Style+[tssIsPersistent]
                          else Style:=Style-[tssIsPersistent];
end;

procedure TFormTeeSeries.CBYDateTimeClick(Sender: TObject);
begin
  if Assigned(TheSeries) then
     TheSeries.YValues.DateTime:=CBYDateTime.Checked;
end;

procedure TFormTeeSeries.CBXDateTimeClick(Sender: TObject);
begin
  if Assigned(TheSeries) then
     TheSeries.XValues.DateTime:=CBXDateTime.Checked;
end;

procedure TFormTeeSeries.CBDataSourcestyleChange(Sender: TObject);

  Procedure CheckOldSource;
  var tmpSource : TTeeSeriesSource;
  begin
    { if the datasource is an internal "Series Source",
      remove and free it ! }
    if Assigned(TheSeries.DataSource) and
       (TheSeries.DataSource is TTeeSeriesSource) and
       (TheSeries.DataSource.Owner=TheSeries) then
    begin
      tmpSource:=TTeeSeriesSource(TheSeries.DataSource);
      tmpSource.Series:=nil;
      tmpSource.Free;
      TheSeries.DataSource:=nil;
      TheSeries.Clear;
    end;

    TheSeries.SetFunction(nil);
  end;

begin
  if Assigned(DataSourceStyle) then
     DataSourceStyle.BApply.Enabled:=False;

  { change datasource form }
  Case CBDataSourceStyle.ItemIndex of
     0: begin  // Manual data. No source.
          CheckOldSource;
          TChartSeriesAccess(TheSeries).ManualData:=True;
        end;
     1: CheckOldSource; // Random values.
  end;

  CreateDataSourceForm;
end;

procedure TFormTeeSeries.DestroyDataSourceForm;
begin
  if Assigned(DataSourceStyle) and DataSourceStyle.CloseQuery then
     FreeAndNil(DataSourceStyle);
end;

procedure TFormTeeSeries.CreateDataSourceForm;

  Procedure EnableButton(AButton:TButton);
  begin
    AButton.Visible:=Assigned(AButton.OnClick);
  end;

var tmpForm   : TCustomForm;
    tmpSource : TTeeSeriesSourceClass;
    tmpNum    : Integer;
begin
  DestroyDataSourceForm;

  if not Assigned(DataSourceStyle) then
  begin
    NewDataButton.Visible:=False;
    EditDataButton.Visible:=False;
    DeleteDataButton.Visible:=False;

    ChartGrid1.Visible:=False;
    ChartGridNavigator1.Visible:=False;

    PanelRandomSource.Visible:=False;
    PanelSeriesSource.Visible:=False;

    case CBDataSourceStyle.ItemIndex of
      0: begin
           ChartGrid1.Chart:=TCustomChart(TheSeries.ParentChart);
           ChartGrid1.Series:=TheSeries;
           ChartGrid1.Visible:=True;
           ChartGridNavigator1.Visible:=True;
         end;

      1: begin
           PanelRandomSource.Visible:=True;
           tmpNum:=TChartSeriesAccess(TheSeries).INumSampleValues;

           CheckCBSamples;

           if tmpNum=0 then
              tmpNum:=TheSeries.NumSampleValues;

           ESamples.Text:=IntToStr(tmpNum);

           PanelRandomSource.BringToFront;
         end;

      2: begin
           PanelSeriesSource.Visible:=True;
           CBSeriesSource.Clear;
           FillSeriesSources(nil,CBSeriesSource.Items,TheSeries,False);

           CBSeriesSource.ItemIndex:=CBSeriesSource.Items.IndexOfObject(TheSeries.DataSource);

           PanelSeriesSource.BringToFront;

           BClearSource.Enabled:=CBSeriesSource.ItemIndex<>-1;

           BApplySource.Enabled:=False;
         end;
    else
    begin
      With CBDataSourceStyle do
      if ItemIndex=3 then
         tmpForm:=TFormClass(SelectedObject).Create(Self)
      else
      begin
        tmpSource:=TTeeSeriesSourceClass(SelectedObject);

        if tmpSource.HasNew then
        begin
          EnableButton(NewDataButton);
          EnableButton(EditDataButton);
          EnableButton(DeleteDataButton);
        end;

        tmpForm:=TFormClass(tmpSource.Editor).Create(Self);
      end;

      DataSourceStyle:=TBaseSourceEditor(tmpForm);
      DataSourceStyle.Align:=alClient;
      AddFormTo(DataSourceStyle,Panel2,TheSeries);

      DataSourceStyle.Translate;

      // Hack.
      Timer1.Enabled:=True;
    end;
    end;
  end;
end;

procedure TFormTeeSeries.CBShowInLegendClick(Sender: TObject);
begin
  if Assigned(TheSeries) then
     TheSeries.ShowInLegend:=CBShowInLegend.Checked;
end;

procedure TFormTeeSeries.CBCursorChange(Sender: TObject);
begin
  with TheSeries do
       Cursor:=TeeSetCursor(Cursor,CBCursor.CurrentItem);
end;

procedure TFormTeeSeries.SEArrowLengthChange(Sender: TObject);
begin
  if CanModifySeries then
     TheSeries.Marks.Callout.Length:=UDArrowsLength.Position;
end;

procedure TFormTeeSeries.CBMarkClipClick(Sender: TObject);
begin
  TheSeries.Marks.Clip:=CBMarkClip.Checked;
end;

procedure TFormTeeSeries.CBMarksVisibleClick(Sender: TObject);
var Old : Boolean;
begin
  TheSeries.Marks.Visible:=CBMarksVisible.Checked;
  Old:=ChangingPage;
  ChangingPage:=True;
  CBAllVisible.Checked:=AllSeriesMarksVisible;
  ChangingPage:=Old;
end;

procedure TFormTeeSeries.FormDestroy(Sender: TObject);
begin
  DestroySeriesForms;

  if Assigned(TheChart) then
     {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(TheChart).RemoveListener(Self);
end;

procedure TFormTeeSeries.FormShow(Sender: TObject);
begin
  CreatingForm:=False;

  if Assigned(InternalOnCreateEditSeries) and Assigned(TheSeries) then
     InternalOnCreateEditSeries(Self,TCustomChart(TheSeries.ParentChart));

  if Assigned(InternalOnCreateEditSeriesObj) and Assigned(TheSeries) then
     InternalOnCreateEditSeriesObj(Self,TCustomChart(TheSeries.ParentChart));

  if Assigned(TheSeries) then
  begin
    CBShowInEditor.Visible:=csDesigning in TheSeries.ComponentState;
    CBShowInEditor.Checked:=TheSeries.ShowInEditor;
  end;
end;

procedure TFormTeeSeries.SEMarksAngleChange(Sender: TObject);
begin
  if CanModifySeries then
     TheSeries.Marks.Angle:=UDMarksAngle.Position;
end;

procedure TFormTeeSeries.CBHorizAxisChange(Sender: TObject);
begin
  With CBHorizAxis do
  if ItemIndex<3 then
     TheSeries.HorizAxis:=THorizAxis(ItemIndex)
  else
  begin
    TheSeries.HorizAxis:=aCustomHorizAxis;
    TheSeries.CustomHorizAxis:=TChartAxis(SelectedObject);
  end;
end;

procedure TFormTeeSeries.CBVertAxisChange(Sender: TObject);
begin
  With CBVertAxis do
  if ItemIndex<3 then
     TheSeries.VertAxis:=TVertAxis(ItemIndex)
  else
  begin
    TheSeries.VertAxis:=aCustomVertAxis;
    TheSeries.CustomVertAxis:=TChartAxis(SelectedObject);
  end;
end;

procedure TFormTeeSeries.EMarksEveryChange(Sender: TObject);
begin
  if CanModifySeries then // 5.02
     TheSeries.Marks.DrawEvery:=UDEvery.Position;
end;

procedure TFormTeeSeries.CBMultiLineClick(Sender: TObject);
begin
  TheSeries.Marks.MultiLine:=CBMultiLine.Checked;
end;

procedure TFormTeeSeries.CBSortChange(Sender: TObject);
begin // Change sorting order...
  With TheSeries do
  begin
    NotMandatoryValueList.Order:=loNone;
    if CBSort.ItemIndex=2 then MandatoryValueList.Order:=loNone
    else
    begin
      if CBSort.ItemIndex=0 then MandatoryValueList.Order:=loAscending
                            else MandatoryValueList.Order:=loDescending;
      CheckOrder;
    end;
  end;
end;

procedure TFormTeeSeries.CBFormatChange(Sender: TObject);
begin
  TheSeries.ValueFormat:=LocalToDelphiFormat(CBFormat.Text);
end;

Function TFormTeeSeries.CheckCanClose:Boolean;
begin
  if Assigned(DataSourceStyle) then result:=DataSourceStyle.CloseQuery
                               else result:=True;
end;

procedure TFormTeeSeries.PageSeriesChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=CheckCanClose;

  if Sender<>Owner then
     ChangingPage:=AllowChange;
end;

procedure TFormTeeSeries.CBDepthClick(Sender: TObject);
begin
  if CanModifySeries then
     if CBDepth.Checked then TheSeries.Depth:=-1
                        else TheSeries.Depth:=UDDepth.Position;
end;

Function TFormTeeSeries.CanModifySeries:Boolean;
begin
  result:=(not CreatingForm) and (not ChangingPage) and Assigned(TheSeries);  // 7.0
end;

procedure TFormTeeSeries.EDepthChange(Sender: TObject);
begin
  if CanModifySeries then
  begin
    TheSeries.Depth:=UDDepth.Position;
    CBDepth.Checked:=False;
  end;
end;

procedure TFormTeeSeries.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=CheckCanClose;
end;

procedure TFormTeeSeries.CBAllVisibleClick(Sender: TObject);
var t : Integer;
begin
  if CanModifySeries then
  begin
    With TheSeries.ParentChart do
    for t:=0 to SeriesCount-1 do
      Series[t].Marks.Visible:=CBAllVisible.Checked;
    CBMarksVisible.Checked:=CBAllVisible.Checked;
  end;
end;

procedure TFormTeeSeries.PaintBox1Paint(Sender: TObject);
var R : TRect;
begin
  if Assigned(TheSeries) then
  begin
    with PaintBox1.Canvas do
    begin
      Brush.Style:=bsSolid;
      Brush.Color:=PaintBox1.Color;
      R:=PaintBox1.ClientRect;
      InflateRect(R,0,-4);
      FillRect(R);
    end;

    PaintSeriesLegend(TheSeries,PaintBox1.Canvas,R);
  end;
end;

procedure TFormTeeSeries.PaintBox1Click(Sender: TObject);
var tmp : TColor;
begin
  if Assigned(TheSeries) then
  begin
    tmp:=TheSeries.SeriesColor;
    if EditColorDialog(Self,tmp) then
    begin
      TheSeries.SeriesColor:=tmp;
      PaintBox1.Repaint;
    end;
  end;
end;

procedure TFormTeeSeries.CBSamplesDefaultClick(Sender: TObject);
begin
  if CBSamplesDefault.Checked then
  begin
    ESamples.Text:=IntToStr(TheSeries.NumSampleValues);
    CBSamplesDefault.Enabled:=False;
  end;
end;

procedure TFormTeeSeries.CheckCBSamples;
var tmpNum : Integer;
begin
  tmpNum:=TChartSeriesAccess(TheSeries).INumSampleValues;
  CBSamplesDefault.Checked:=(tmpNum=0) or (tmpNum=TheSeries.NumSampleValues);
  CBSamplesDefault.Enabled:=not CBSamplesDefault.Checked;
end;

procedure TFormTeeSeries.ESamplesChange(Sender: TObject);
var tmpNum : Integer;
begin
  tmpNum:=StrToIntDef(ESamples.Text,0);
  TChartSeriesAccess(TheSeries).INumSampleValues:=tmpNum;
  CheckCBSamples;
  BApplyRandom.Enabled:=True;
end;

procedure TFormTeeSeries.BApplyRandomClick(Sender: TObject);
var tmpNum : Integer;
begin
  TheSeries.DataSource:=nil;
  
  tmpNum:=TChartSeriesAccess(TheSeries).INumSampleValues;
  if tmpNum=0 then TheSeries.FillSampleValues
              else TheSeries.FillSampleValues(tmpNum);
end;

procedure TFormTeeSeries.TeeEvent(Event:TTeeEvent);
begin
  if not (csDestroying in ComponentState) then
  begin
    if Event is TTeeSeriesEvent then
       with TTeeSeriesEvent(Event) do
       if Event=seChangeColor then
          PaintBox1.Invalidate
       else
       if (Event=seRemove) and (Series=TheSeries) then
       begin
         DestroySeriesForms;
         TheSeries:=nil;
         CBSeriesChange(Self);
       end;

    if Assigned(OnTeeEvent) then
       OnTeeEvent(Self,Event);
  end;
end;

procedure TFormTeeSeries.EArrowDistChange(Sender: TObject);
begin
  if CanModifySeries then
     TheSeries.Marks.Callout.Distance:=UDArrowDist.Position;
end;

procedure TFormTeeSeries.BCalloutPointerClick(Sender: TObject);
begin
  EditSeriesPointer(Self,TheSeries.Marks.Callout);
end;

procedure TFormTeeSeries.CBHeadChange(Sender: TObject);
begin
  if CanModifySeries then
     TheSeries.Marks.Callout.ArrowHead:=TArrowHeadStyle(CBHead.ItemIndex);
end;

procedure TFormTeeSeries.Edit1Change(Sender: TObject);
begin
  if CanModifySeries then
     TheSeries.Marks.Callout.ArrowHeadSize:=UDHeadSize.Position;
end;

procedure TFormTeeSeries.ChartGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  if ChartGrid1.Series<>nil then
     ChartGrid1.Series.RefreshSeries;
end;

procedure TFormTeeSeries.Timer1Timer(Sender: TObject);
begin
  // VCL bug workaround:
  // Force pagecontrol to re-show again our tab with the correct controls on it.
  // This must be done using a timer to delay until parent form is totally
  // visible. Anybody knows a better solution?
  Timer1.Enabled:=False;

  {$IFNDEF CLX}
  PageSeries.ActivePage:=nil;
  PageSeries.ActivePage:=TabDataSource;
  {$ENDIF}
end;

Function TFormTeeSeries.FindZList:TChartValueList;
begin
  result:=TChartSeriesAccess(TheSeries).ValueListOfAxis(TheSeries.ParentChart.DepthAxis);
  if not Assigned(result) then
     result:=TChartSeriesAccess(TheSeries).ValueListOfAxis(TheSeries.ParentChart.DepthTopAxis);
end;

procedure TFormTeeSeries.CBZDateTimeClick(Sender: TObject);
var tmpList : TChartValueList;
begin
  tmpList:=FindZList;
  if Assigned(tmpList) then
     tmpList.DateTime:=CBZDateTime.Checked
  else
     CBZDateTime.Hide;
end;

procedure TFormTeeSeries.Button1Click(Sender: TObject);
begin
  CBFormat.Text:=TFormatEditor.Change(Self,CBFormat.Text);
  CBFormatChange(Self);
end;

procedure TFormTeeSeries.Button2Click(Sender: TObject);
begin
  EPercentFormat.Text:=TFormatEditor.Change(Self,EPercentFormat.Text);
  EPercentFormatChange(Self);
end;

procedure TFormTeeSeries.Button3Click(Sender: TObject);
begin
  TheSeries.Clear;
  CBDataSourcestyle.ItemIndex:=0;
  CBDataSourcestyleChange(Self);
end;

procedure TFormTeeSeries.CBShowInEditorClick(Sender: TObject);
begin
  TheSeries.ShowInEditor:=CBShowInEditor.Checked;
end;

procedure TFormTeeSeries.CBSeriesSourceChange(Sender: TObject);
begin
  BApplySource.Enabled:=True;
end;

procedure TFormTeeSeries.BApplySourceClick(Sender: TObject);
begin
  TheSeries.DataSource:=TComponent(CBSeriesSource.SelectedObject);
  BApplySource.Enabled:=False;
  BClearSource.Enabled:=CBSeriesSource.ItemIndex<>-1;
end;

procedure TFormTeeSeries.BClearSourceClick(Sender: TObject);
begin
  CBSeriesSource.ItemIndex:=-1;
  BApplySourceClick(Self);
end;

procedure TFormTeeSeries.PageControlMarksChange(Sender: TObject);
begin
  IMarksObject.PC1Change(Sender);
end;

procedure TFormTeeSeries.CBTextAlignChange(Sender: TObject);
begin
  if CanModifySeries then
     TheSeries.Marks.TextAlign:=TAlignment(CBTextAlign.ItemIndex);
end;

procedure TFormTeeSeries.CBFontSeriesColorClick(Sender: TObject);
begin
  TheSeries.Marks.FontSeriesColor:=CBFontSeriesColor.Checked;
end;

end.

