{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2009 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeFuncEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QButtons, QExtCtrls,
     QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,
     {$ENDIF}
     TeeSelectList, TeEngine, TeeProcs, TeeEdiPeri, TeeSourceEdit, TeCanvas;

type
  TTeeFuncEditor = class(TBaseSourceEditor, ITeeEventListener)
    PageControl1: TPageControl;
    TabSource: TTabSheet;
    TabOptions: TTabSheet;
    PanSingle: TPanel;
    Label1: TLabel;
    CBSingle: TComboFlat;
    LValues: TLabel;
    CBValues: TComboFlat;
    BNone: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBSourcesChange(Sender: TObject);
    procedure BApplyClick(Sender: TObject);
    procedure CBSingleChange(Sender: TObject);
    procedure BNoneClick(Sender: TObject);
    procedure CBValuesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    Filling : Boolean;
    IOptions : TForm;
    ISources : TSelectListForm;

    Procedure FillSeries; // Fill selection combos...
    procedure TryCreateNewFunction;

  {$IFDEF CLR}
  protected
  {$ENDIF}
    procedure TeeEvent(Event: TTeeEvent);  { interface }
  public
    { Public declarations }
    TheSeries : TChartSeries;

    Function FunctionClass:TTeeFunctionClass;
    class procedure SetValueListCombo(Series:TChartSeries; Combo:TComboFlat);
    procedure Translate; override;
  end;

// Internal use. See TeeEdiSeri.pas
Procedure FillSeriesSources(AItems,AItems2:TStrings; TheSeries:TChartSeries; AddCurrent:Boolean);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeeConst, Chart, TeePenDlg, TeeGally;

{ Helper functions }
procedure FillTeeFunctions(ACombo:TComboBox);
var t : Integer;
begin
  With ACombo.Items do
  begin
    BeginUpdate;

    Clear;
    Add(TeeMsg_FunctionNone);

    With TeeSeriesTypes do
    for t:=0 to Count-1 do
      With Items[t] do
      if Assigned(FunctionClass) and
         (not Assigned(SeriesClass)) and
         (IndexOfObject(TObject(FunctionClass))=-1) then
             AddObject(ReplaceChar(Description {$IFNDEF CLR}^{$ENDIF},TeeLineSeparator,' '),
                       TObject(FunctionClass));

    EndUpdate;
  end;
end;

Procedure FillSeriesSources(AItems,AItems2:TStrings; TheSeries:TChartSeries; AddCurrent:Boolean);

  Procedure AddSource(ASeries: TChartSeries; const Prefix:String);
  var tmp : String;
  begin
    if TheSeries.ParentChart.IsValidDataSource(TheSeries,ASeries) then
    begin
      tmp:=SeriesTitleOrName(ASeries);

      if Prefix<>'' then
         tmp:=Prefix+' '+tmp;

      if Assigned(AItems2) then
         AItems2.AddObject(tmp,ASeries);

      if AddCurrent or (TheSeries.DataSources.IndexOf(ASeries)=-1) then
         if Assigned(AItems) then
            AItems.AddObject(tmp,ASeries);
    end;
  end;

  procedure AddFrom(Component:TComponent; const Prefix:String);
  var t : Integer;
  begin
    with Component do
       for t:=0 to ComponentCount-1 do
       begin
           if Components[t] is TChartSeries then
              AddSource(TChartSeries(Components[t]),Prefix);

           //recurse because series may be owned by other components as well!
           AddFrom(Components[t],'');
       end;
  end;

  {$IFNDEF LCL}
  function IsMDIApplication:Boolean;
  begin
    result:=Assigned(Application) and Assigned(Application.MainForm) and
            {$IFDEF CLX}
            (Application.MainForm is TForm) and (TForm(Application.MainForm).FormStyle=fsMDIForm);
            {$ELSE}
            (Application.MainForm.FormStyle=fsMDIForm);
            {$ENDIF}
  end;

  {$IFNDEF CLX}
  procedure AddMDISources;
  var t : Integer;
  begin
    with Application.MainForm.ActiveMDIChild do  // 8.0 TV52012071
      for t:=0 to ComponentCount-1 do
        //Charts may, also reside on frames of MDI forms
        if (Components[t] is TCustomChart)
            {$IFNDEF D4}or (Components[t] is TCustomFrame){$ENDIF} then
        begin
          if Assigned(TheSeries.Owner) then
            AddFrom(TheSeries.Owner,'');
          break;
        end;
  end;
  {$ENDIF}
  {$ENDIF}

begin
  {$IFNDEF LCL}
  {$IFNDEF CLX}
  if IsMDIApplication then
     AddMDISources
  else
  {$ENDIF}
  {$ENDIF}
  if Assigned(TheSeries.Owner) then
     AddFrom(TheSeries.Owner,'');
end;

{ TTeeFuncEditor }
procedure TTeeFuncEditor.FormCreate(Sender: TObject);
begin
  inherited;

  {$IFNDEF CLX}
  CBSources.Sorted:=True;
  {$ENDIF}

  FillTeeFunctions(CBSources);
end;

Function TTeeFuncEditor.FunctionClass:TTeeFunctionClass;
begin
  result:=TTeeFunctionClass(CBSources.SelectedObject);
end;

Procedure TTeeFuncEditor.FillSeries; // Fill selection combos...
var t         : Integer;
    tmp       : TChartSeries;
    tmpSource : TObject;
    tmpIndex  : Integer;
begin
  CBSingle.Items.Clear;

  With ISources do
  begin
    FromList.Items.Clear;

    FillSeriesSources(FromList.Items,CBSingle.Items,TheSeries,False);

    With ToList do
    begin
      Items.BeginUpdate;
      try
        Clear;

        With TheSeries do
        if Assigned(DataSource) then
        for t:=0 to DataSources.Count-1 do
            if TComponent(DataSources[t]) is TChartSeries then
            begin
              tmp:=TChartSeries(DataSources[t]);
              Items.AddObject(SeriesTitleOrName(tmp),tmp);

              with FromList.Items do
                   Delete(IndexOfObject(tmp));
            end;
      finally
        Items.EndUpdate;
      end;
    end;
  end;

  if PanSingle.Visible then
  begin
    // Set current selected single series
    tmpSource:=TheSeries.DataSource;
    if Assigned(tmpSource) and
       (tmpSource is TChartSeries) then
    begin
      with CBSingle do
      begin
        tmpIndex:=Items.IndexOfObject(tmpSource);
        if tmpIndex<>ItemIndex then
        begin
          ItemIndex:=tmpIndex;

          Filling:=True;
          try
            CBSingleChange(Self);
          finally
            Filling:=False;
          end;
        end;
      end;

      SetValueListCombo(TheSeries,CBValues);
    end
    else CBSingle.ItemIndex:=-1;
  end;
end;

class procedure TTeeFuncEditor.SetValueListCombo(Series:TChartSeries; Combo:TComboFlat);
var tmpList : String;
begin
  tmpList:=Series.MandatoryValueList.ValueSource;

  if tmpList='' then
     Combo.ItemIndex:=0
  else
     Combo.ItemIndex:=Combo.Items.IndexOf(tmpList);
end;

type
  TFunctionAccess=class(TTeeFunction);
  {$IFNDEF CLR}
  TTeePanelAccess=class(TCustomAxisPanel);
  {$ENDIF}

procedure TTeeFuncEditor.FormShow(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage:=TabSource;
  TheSeries:=TChartSeries({$IFDEF CLR}TObject{$ENDIF}(Tag));

  if Assigned(TheSeries) and Assigned(TheSeries.ParentChart) then
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(TheSeries.ParentChart).Listeners.Add(Self);

  // Create multi-list form
  ISources:=TSelectListForm.Create(Self);
  With ISources do
  begin
    FromList.Height:=FromList.Height-5;
    ToList.Height:=ToList.Height-5;
    Height:=Height-8;
    Align:=alClient;
    OnChange:=CBSourcesChange;
  end;

  AddFormTo(ISources,TabSource,TheSeries);

  TeeTranslateControl(ISources);

  if Assigned(TheSeries) then
  begin
    FillSeries;

    // Select current at list of functions
    With CBSources do
    if Assigned(TheSeries.FunctionType) then
       ItemIndex:=Items.IndexOfObject(TObject(TheSeries.FunctionType.ClassType))
    else
       ItemIndex:=Items.IndexOf(TeeMsg_FunctionNone);

    CBSourcesChange(Self);

    BApply.Enabled:=(not Assigned(TheSeries.FunctionType))
                    and (TheSeries.DataSource=nil);
  end;

  ISources.EnableButtons;
end;

procedure TTeeFuncEditor.TryCreateNewFunction;
var tmpClass : TTeeFunctionClass;
begin
  { Create a new function... }
  tmpClass:=FunctionClass;

  if Assigned(tmpClass) then
  begin
    if (not Assigned(TheSeries.FunctionType)) or
       (TheSeries.FunctionType.ClassType<>tmpClass) then
    begin
      TheSeries.FunctionType:=nil;
      CreateNewTeeFunction(TheSeries,tmpClass);

      BApply.Enabled:=False;
    end;
  end
  else TheSeries.FunctionType:=nil;
end;

procedure TTeeFuncEditor.CBSourcesChange(Sender: TObject);

  Procedure CreateEditorForm(const EditorClass:String);
  var tmpF : TFormClass;
  begin
    FreeAndNil(IOptions);

    tmpF:=TFormClass(GetClass(EditorClass));
    if Assigned(tmpF) then
    begin
      IOptions:=tmpF.Create(Self);
      TeeTranslateControl(IOptions);

      AddFormTo(IOptions,TabOptions,TheSeries.FunctionType);
    end;
  end;

var tmpEdit : String;
    tmp     : TTeeFunction;
    tmpNoSource : Boolean;
begin
  inherited;

  TabOptions.TabVisible:=FunctionClass<>nil;

  if TabOptions.TabVisible then
  begin
    TryCreateNewFunction;

    tmp:=FunctionClass.Create(nil);  // temporary function
    try
      tmpEdit:=TFunctionAccess(tmp).GetEditorClass;
      tmpNoSource:=TFunctionAccess(tmp).NoSourceRequired;

      PanSingle.Visible:=(not tmpNoSource) and TFunctionAccess(tmp).SingleSource;

      if PanSingle.Visible then
      begin
        LValues.Visible:=not TFunctionAccess(tmp).HideSourceList;
        CBValues.Visible:=LValues.Visible;
      end;

      if tmpEdit='' then TabOptions.TabVisible:=False
                    else CreateEditorForm(tmpEdit);

      if tmpNoSource then
      begin
        TabOptions.Visible:=True;
        PageControl1.ActivePage:=TabOptions;
      end;

      TabSource.TabVisible:=not tmpNoSource;

      // Hack due to a VCL bug in TPageControl. See OnTimer1
      // Anybody knows a better solution?
      if ((TheSeries.DataSource<>nil) or tmpNoSource)
         and Assigned(IOptions) then
             Timer1.Enabled:=True;
    finally
      tmp.Free;
    end;

    BApply.Enabled:=True;
  end
  else
  begin
    TabSource.TabVisible:=True;
    PanSingle.Visible:=False;
  end;

  ISources.Visible:=not PanSingle.Visible;

  // Hack due to a VCL bug in TPageControl. See OnTimer2
  // Anybody knows a better solution?
  if ISources.Visible then
     Timer2.Enabled:=True;
end;

type TSeriesAccess=class(TChartSeries);

procedure TTeeFuncEditor.BApplyClick(Sender: TObject);

  procedure DoApply;
  var t : Integer;
      // tmp : TChartSeries;
  begin
    { Set datasources... }
    if PanSingle.Visible then
    begin
      if CBSingle.ItemIndex=-1 then
      begin
        TheSeries.DataSource:=nil;
        TheSeries.MandatoryValueList.ValueSource:='';
      end
      else
      begin
        TheSeries.DataSource:=TChartSeries(CBSingle.SelectedObject);

        if CBValues.ItemIndex=-1 then
           TheSeries.MandatoryValueList.ValueSource:=''
        else
           TheSeries.MandatoryValueList.ValueSource:=CBValues.CurrentItem;
      end;
    end
    else
    begin
      if ISources.ToList.Items.Count=0 then TheSeries.DataSource:=nil
      else
      begin
        With ISources.ToList.Items do
           for t:=0 to Count-1 do
               TheSeries.CheckOtherSeries(TChartSeries(Objects[t]));

        With TheSeries.DataSources do
        begin
          // for t:=0 to Count-1 do  // 6.02
          //   TSeriesAccess(Items[t]).RemoveLinkedSeries(TheSeries);

          Clear;

          With ISources.ToList.Items do
          for t:=0 to Count-1 do
            // tmp:=TChartSeries(Objects[t]);

            TheSeries.DataSources.Add(TChartSeries(Objects[t]));

            //TSeriesAccess(tmp).AddLinkedSeries(TheSeries); // 6.02
        end;
      end;
    end;

    TryCreateNewFunction;
  end;

var tmp : Boolean;
begin
  inherited;

  if Assigned(IOptions) and Assigned(IOptions.OnCloseQuery) then
  begin
    tmp:=True;
    IOptions.OnCloseQuery(IOptions,tmp);
  end;

  TheSeries.BeginUpdate;
  DoApply;
  TheSeries.EndUpdate;
  TheSeries.CheckDataSource;

  BApply.Enabled:=False;
end;

procedure TTeeFuncEditor.CBSingleChange(Sender: TObject);
var tmp : TChartSeries;
    t   : Integer;
begin
  BApply.Enabled:=not Filling;

  with CBValues do
  begin
    Items.Clear;
    Enabled:=CBSingle.ItemIndex<>-1;
    BNone.Enabled:=Enabled;

    if Enabled then
    begin
      tmp:=TChartSeries(CBSingle.SelectedObject);

      for t:=1 to tmp.ValuesList.Count-1 do
          Items.Add(tmp.ValuesList[t].Name);

      CBValues.ItemIndex:=0;
    end;
  end;
end;

procedure TTeeFuncEditor.BNoneClick(Sender: TObject);
begin
  CBSingle.ItemIndex:=-1;
  CBSingleChange(Self);
end;

procedure TTeeFuncEditor.CBValuesChange(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TTeeFuncEditor.TeeEvent(Event: TTeeEvent);
begin
  if not (csDestroying in ComponentState) then
  if Event is TTeeSeriesEvent then
  With TTeeSeriesEvent(Event) do
  Case Event of
    seRemove :
      if Series<>TheSeries then FillSeries
                           else BApply.Enabled:=False;
      seAdd,
      seSwap: if Series<>TheSeries then FillSeries
                                   else BApply.Enabled:=False;
  end;
end;

procedure TTeeFuncEditor.FormDestroy(Sender: TObject);
begin
  if Assigned(TheSeries) and Assigned(TheSeries.ParentChart) then
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(TheSeries.ParentChart).RemoveListener(Self);

  inherited;
end;

procedure TTeeFuncEditor.Timer1Timer(Sender: TObject);
begin
  // Force pagecontrol to re-show again our tab with the correct controls on it.
  // This must be done using a timer to delay until parent form is totally
  // visible. Anybody knows a better solution?
  Timer1.Enabled:=False;
  {$IFNDEF CLX}
  PageControl1.ActivePage:=nil;
  PageControl1.ActivePage:=TabOptions;
  {$ENDIF}
end;

procedure TTeeFuncEditor.Timer2Timer(Sender: TObject);
begin
  // Force pagecontrol to re-show again our tab with the correct controls on it.
  // This must be done using a timer to delay until parent form is totally
  // visible. Anybody knows a better solution?
  Timer2.Enabled:=False;
  {$IFNDEF CLX}
  PageControl1.ActivePage:=nil;
  PageControl1.ActivePage:=TabSource;
  {$ENDIF}
end;

procedure TTeeFuncEditor.SpeedButton1Click(Sender: TObject);
var tmpFunc  : TTeefunctionClass;
begin
  tmpFunc:=GetChartGalleryFunction(GetParentForm(Self));

  if Assigned(tmpFunc) then
  begin
    CBSources.ItemIndex:=CBSources.Items.IndexOfObject(TObject(tmpFunc));
    CBSourcesChange(Self);
  end;
end;

procedure TTeeFuncEditor.Translate;
begin
  TeeTranslateControl(Self,[CBSingle]);
end;

end.
