{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2009 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeSourceEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
     {$ENDIF}
     {$IFDEF LCL}
     Buttons,
     {$ENDIF}
     TeEngine, TeeProcs, TeCanvas, Chart;

type
  TBaseSourceEditor = class(TForm)
    LLabel: TLabel;
    CBSources: TComboFlat;
    Pan: TPanel;
    PanelApply: TPanel;
    BApply: TButton;
    procedure CBSourcesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    Chart     : TCustomChart;
    TheSeries : TChartSeries;
    SkipValidation : Boolean;

    Procedure AddComponentDataSource( Const AComponent:TComponent;
                                      AItems:TStrings;
                                      AddCurrent:Boolean);
    procedure CheckReplaceSource(NewSource:TTeeSeriesSource);
    Function IsValid(AComponent:TComponent):Boolean; virtual;
  public
    { Public declarations }

    procedure Translate; dynamic;
  end;

  { special case for TFormDesigner in TeeCharteg unit }
  TAddComponentDataSource=Procedure( Const AComponent:TComponent;
                                     AItems:TStrings;
                                     AddCurrent:Boolean) of object;

  TOnGetDesignerNamesEvent=Procedure( AProc:TAddComponentDataSource;
                                      ASeries:TChartSeries;
                                      AItems:TStrings;
                                      AddCurrent:Boolean);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeeConst;

Procedure TBaseSourceEditor.AddComponentDataSource( Const AComponent:TComponent;
                                                 AItems:TStrings;
                                                 AddCurrent:Boolean);
Var tmp         : String;
    tmpFormName : TComponentName;
begin
  if AItems.IndexOfObject(AComponent)=-1 then { 5.01 }
  if AddCurrent or (TheSeries.DataSources.IndexOf(AComponent)=-1) then
  if IsValid(AComponent) then
     if SkipValidation or
        TheSeries.ParentChart.IsValidDataSource(TheSeries,AComponent) then
     begin
       if AComponent is TChartSeries then
          tmp:=SeriesTitleOrName(TChartSeries(AComponent))
       else
          tmp:=AComponent.Name;

       if (TheSeries.Owner<>AComponent.Owner) and
          Assigned(AComponent.Owner) then
       begin
         tmpFormName:=AComponent.Owner.Name;

         if tmpFormName<>'' then
            tmp:=tmpFormName+'.'+tmp;
       end;

       AItems.AddObject(tmp,AComponent);
     end;
end;

procedure TBaseSourceEditor.CBSourcesChange(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TBaseSourceEditor.FormShow(Sender: TObject);
var tmp : TObject;
begin
  // Trick. Use the "Tag" property to receive either a Series or a Chart

  tmp:=TObject(Tag);
  if tmp is TChartSeries then
     TheSeries:=TChartSeries(tmp)
  else
  if tmp is TCustomChart then
     Chart:=TCustomChart(tmp);

  BApply.Enabled:=False;
  TeeTranslateControl(self);
end;

type
  TButtonAccess=class(TButton);

procedure TBaseSourceEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  if BApply.Enabled then
  Case MessageDlg(TeeMsg_SureToApply,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
    mrYes: begin
             TButtonAccess(BApply).Click;
             CanClose:=not BApply.Enabled;
           end;
     mrNo: begin
            BApply.Enabled:=False;
            CanClose:=True;
           end;
 mrCancel: CanClose:=False;
  end;
end;

function TBaseSourceEditor.IsValid(AComponent: TComponent): Boolean;
begin
  result:=False;
end;

procedure TBaseSourceEditor.CheckReplaceSource(
  NewSource: TTeeSeriesSource);
var tmpSource : TTeeSeriesSource;
begin
  // Pending Chart.DataSource:
  if Assigned(Chart) and (not Assigned(TheSeries)) then
     TheSeries:=Chart.AddSeries(TeeSeriesTypes[0].SeriesClass);

  if TheSeries.DataSource<>NewSource then
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
    end;

    TheSeries.DataSource:=nil;

    if not Assigned(NewSource.Series) then
       NewSource.Series:=TheSeries;

    TheSeries.DataSource:=NewSource;
  end;
end;

procedure TBaseSourceEditor.FormCreate(Sender: TObject);
begin
  SkipValidation:=False;
  Align:=alClient;
end;

procedure TBaseSourceEditor.Translate;
begin
  TeeTranslateControl(Self);
end;

end.
