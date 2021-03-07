{**********************************************}
{   TWorldSeries GIS / Mapping Charts          }
{   Copyright (c) 2009 by Steema Software      }
{**********************************************}
unit TeeWorldSeries;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Classes,
  {$ENDIF}
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QExtCtrls, QButtons, QGrids, QComCtrls,
  {$ELSE}
  Controls, Graphics, StdCtrls, ExtCtrls, Buttons, Grids, ComCtrls,
  {$ENDIF}
  TeCanvas, TeeProcs, TeEngine, Chart, Series, TeeMapSeries,
  TeeMapSeriesEdit, TeeLisB, TeeNavigator, TeeChartGrid, TeeEdiGrad, TeePenDlg;

type
  TWorldMap=(wmWorld,wmAfrica,wmAsia,wmAustralia,wmCentralAmerica,
             wmEurope,wmEurope15,wmEurope27,wmSpain,
             wmMiddleEast,wmNorthAmerica,wmSouthAmerica,
             wmUSA,wmUSAHawaiiAlaska);

  TWorldSeries=class(TMapSeries)
  private
    FMap      : TWorldMap;

    InGallery : Boolean;

    procedure LoadMapShapes;
    class function LoadStrings(const AName:String):TStringList;
    class function ResourceHandle(const AName:String):THandle;
    procedure SetMap(const Value:TWorldMap);
  protected
    procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    class procedure CreateSubGallery(AddSubChart: TChartSubGalleryProc); override;
    procedure GalleryChanged3D(Is3D: Boolean); override;
    class Function GetEditorClass:String; override;
    procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
    class procedure SetSubGallery(ASeries: TChartSeries; Index: Integer); override;
  public
    Constructor Create(AOwner:TComponent); override;

    class procedure AddCities(DestSeries:TChartSeries);
    procedure Assign(Source:TPersistent); override;
    Procedure FillSampleValues(NumValues:Integer=0); override;

    class procedure LoadMapFromResource(Series:TMapSeries;
                                        const ShpName,ShxName:String);
  published
    property Map:TWorldMap read FMap write SetMap default wmWorld;
    property Shapes stored False;
  end;

  TWorldSeriesEditor=class(TMapSeriesEditor)
    Label7: TLabel;
    CBMap: TComboFlat;
    procedure CBMapChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  {$IFDEF CLR}
  WinUtils,
  {$ENDIF}
  SysUtils, TeeShp, TeeProCo;

{$R TeeWorld.res}
{$R TeeSpain.res}
{$R TeeUSAStates.res}

{ TWorldSeries }
Constructor TWorldSeries.Create(AOwner: TComponent);
begin
  inherited;

  if (csDesigning in ComponentState) or
     (not Assigned(Owner)) or
     (not (csLoading in Owner.ComponentState)) then
        if (not Assigned(Owner)) or
           (Owner.ClassName<>'TGalleryChart') then
              LoadMapShapes;

  ManualData:=True;
  CanSaveData:=True;
end;

procedure TWorldSeries.Assign(Source: TPersistent);
begin
  if Source is TWorldSeries then
     FMap:=TWorldSeries(Source).Map;

  inherited;
end;

class function TWorldSeries.ResourceHandle(const AName:String):THandle;
begin
  if FindResource(MainInstance, {$IFNDEF CLR}PChar{$ENDIF}(AName), 
                  RT_RCDATA) <> 0 then
     result:=MainInstance
  else 
     result:=HInstance;
end;

class procedure TWorldSeries.LoadMapFromResource(Series:TMapSeries;
                                               const ShpName,ShxName:String);
var shp : TResourceStream;
    shx : TResourceStream;
    tmp : THandle;
begin
  tmp:=ResourceHandle(ShpName);

  shp:=TResourceStream.Create(tmp,ShpName,RT_RCDATA);
  try
    shx:=TResourceStream.Create(tmp,ShxName,RT_RCDATA);
    try
      LoadMap(Series,shp,shx);
    finally
      shx.Free;
    end;
  finally
    shp.Free;
  end;
end;

class function TWorldSeries.LoadStrings(const AName:String):TStringList;
var r : TResourceStream;
begin
  r:=TResourceStream.Create(ResourceHandle(AName),AName,RT_RCDATA);
  try
    result:=TStringList.Create;
    result.LoadFromStream(r);
  finally
    r.Free;
  end;
end;

procedure TWorldSeries.LoadMapShapes;

  function SplitFilter(const Value:String; var Text:String):Integer;
  var i : Integer;
  begin
    i:=Pos(' ',Value);
    result:=StrToInt(Copy(Value,1,i-1));
    Text:=Copy(Value,i+1,Length(Value));
  end;

  procedure FilterShapes(const FilterName:String);
  var st : TStringList;
      t,
      shapeIndex : Integer;
      tmp        : String;
  begin
    st:=LoadStrings(FilterName);
    try
      for t:=0 to st.Count-1 do
      begin
        shapeIndex:=SplitFilter(st[t],tmp);
        Labels[shapeIndex]:=tmp;

        if FMap<>wmWorld then
           MandatoryValueList.Value[shapeIndex]:=12345678;
      end;
    finally
      st.Free;
    end;
  end;

  // Not valid.
  // We need to find another system, ie:
  // if City XY coordinates are inside any of the visible Shapes then...
  (*
  procedure FilterCities;
  var x : TChartValue;
      y : TChartValue;
      t : Integer;
  begin
    t:=0;

    while t<Cities.Count do
    begin
      x:=Cities.XValues.Value[t];
      y:=Cities.YValues.Value[t];

      if (x>=MinXValue) and (x<=MaxXValue) and
         (y>=MinYValue) and (y<=MaxYValue) then
         Inc(t)
      else
         Cities.Delete(t);
    end;
  end;
  *)

var st : TStringList;
    t  : Integer;
begin
  Clear;

  // Load shapes
  case FMap of
    wmSpain : LoadMapFromResource(Self,'TEESPAINSHP','TEESPAINSHX');
    wmUSA,
    wmUSAHawaiiAlaska : LoadMapFromResource(Self,'TEEUSASTATESSHP','TEEUSASTATESSHX');
  else
    begin
      LoadMapFromResource(Self,'TEEWORLDSHP','TEEWORLDSHX');
    end;
  end;

  case FMap of
    wmAfrica         : FilterShapes('TeeAfrica');
    wmAsia           : FilterShapes('TeeAsia');
    wmAustralia      : FilterShapes('TeeAustralia');
    wmCentralAmerica : FilterShapes('TeeCentralAmerica');
    wmEurope         : FilterShapes('TeeEurope');
    wmEurope15       : FilterShapes('TeeEurope15');
    wmEurope27       : FilterShapes('TeeEurope27');
    wmSpain          : FilterShapes('TeeSpain');
    wmMiddleEast     : FilterShapes('TeeMiddleEast');
    wmNorthAmerica   : FilterShapes('TeeNorthAmerica');
    wmSouthAmerica   : FilterShapes('TeeSouthAmerica');
    wmUSA            : FilterShapes('TeeUSA');
    wmUSAHawaiiAlaska : FilterShapes('TeeUSAAlaska');
    wmWorld  :
    begin
      st:=LoadStrings('TeeWorld');
      try
        for t:=0 to st.Count-1 do
            FilterShapes(st[t]);
      finally
        st.Free;
      end;
    end;
  end;

  if FMap<>wmWorld then
  begin
    t:=0;

    while t<Shapes.Count do
      if MandatoryValueList.Value[t]=12345678 then
         Inc(t)
      else
         Delete(t);
  end;

  // Clean values
  for t:=0 to Shapes.Count-1 do
      MandatoryValueList.Value[t]:=0;
end;

class procedure TWorldSeries.AddCities(DestSeries:TChartSeries);
var s : TStringList;
    Old : {$IFDEF CLR}String{$ELSE}Char{$ENDIF};
    t   : Integer;
    st  : String;
begin
  DestSeries.Clear;

  s:=LoadStrings('TEEWORLDCITIES');
  try
    Old:=DecimalSeparator;
    DecimalSeparator:='.';
    try
      for t:=0 to s.Count-1 do
      begin
        st:=s[t];
        DestSeries.AddXY( StrToFloat(TeeExtractField(st,2,';')),
                          StrToFloat(TeeExtractField(st,3,';')),
                          TeeExtractField(st,1,';'));
      end;
    finally
      DecimalSeparator:=Old;
    end;
  finally
    s.Free;
  end;
end;

procedure TWorldSeries.SetMap(const Value: TWorldMap);
begin
  if FMap<>Value then
  begin
    FMap:=Value;
    LoadMapShapes;
    Repaint;
  end;
end;

Procedure TWorldSeries.FillSampleValues(NumValues:Integer=0);
begin
  // Do not call "Clear" here. We dont want to remove all Map shapes.
  RandSeed:=Random(7774444);

  BeginUpdate;
  try
    AddSampleValues(NumValues);
    CheckOrder;
  finally
    EndUpdate;
  end;
end;

Procedure TWorldSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
var t : Integer;
    s : TSeriesRandomBounds;
    tmpH : TChartValue;
begin
  if InGallery then
     inherited
  else
  begin
    s:=RandomBounds(NumValues);

    with s do
    begin
      tmpH:=DifY*0.25;

      for t:=0 to Count-1 do
      begin
        tmpY:=Abs(RandomValue(100)*tmpH*0.01-(tmpH*0.5));
        MandatoryValueList.Value[t]:=tmpY;
      end;
    end;

    MandatoryValueList.Modified:=True;
    Repaint;
  end;
end;

class procedure TWorldSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  if ASeries.ParentChart.ClassName<>'TGalleryChart' then
     TWorldSeries(ASeries).Map:=TWorldMap(Index);
end;

class procedure TWorldSeries.CreateSubGallery(AddSubChart: TChartSubGalleryProc);
var t : Integer;
begin
  // DO NOT CALL: inherited;

  for t:=0 to TeeSeriesTypes.Count-1 do
  with TeeSeriesTypes[t] do
  if SeriesClass=TWorldSeries then
     AddSubChart(Description{$IFNDEF CLR}^{$ENDIF});
end;

procedure TWorldSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  InGallery:=True;
  try
    inherited;
  finally
    InGallery:=False;
  end;

  //Pen.Hide;
{
  // This is very nice, but also *very* slow (when multiplied by 14 maps) :

  UsePalette:=True;
  UseColorRange:=False;

  Map:=TWorldMap(TWinControl(TControl(Owner).Parent).ControlCount-1);

  if Map=wmWorld then
     LoadMapShapes;
}
end;

procedure TWorldSeries.GalleryChanged3D(Is3D: Boolean);
begin
  inherited;
  ParentChart.View3D:=False;
end;

procedure TWorldSeries.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  // When this Series is added at design-time for first time into a Form,
  // set Chart to 2D mode.
  if Assigned(ParentChart) then
     if csDesigning in ComponentState then
        if not (csLoading in ComponentState) then
           ParentChart.View3D:=False;
end;

procedure RegisterWorld(var Title:String; SubIndex:Integer);
begin
  RegisterTeeSeriesFunction( TWorldSeries,nil, {$IFNDEF CLR}@{$ENDIF}Title,
                                 {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryMaps,1,SubIndex);
end;

procedure TWorldSeriesEditor.CBMapChange(Sender: TObject);
begin
  TWorldSeries(Map).Map:=TWorldMap(CBMap.ItemIndex);
end;

procedure TWorldSeriesEditor.FormShow(Sender: TObject);
begin
  inherited;

  if Assigned(Map) then
     CBMap.ItemIndex:=Ord(TWorldSeries(Map).Map);
end;

class function TWorldSeries.GetEditorClass: String;
begin
  result:='TWorldSeriesEditor';
end;

initialization
  RegisterClass(TWorldSeriesEditor);

  RegisterWorld(TeeMsg_GalleryWorld,0);
  RegisterWorld(TeeMsg_GalleryAfrica,1);
  RegisterWorld(TeeMsg_GalleryAsia,2);
  RegisterWorld(TeeMsg_GalleryAustralia,3);
  RegisterWorld(TeeMsg_GalleryCentralAmerica,4);
  RegisterWorld(TeeMsg_GalleryEurope,5);
  RegisterWorld(TeeMsg_GalleryEurope15,6);
  RegisterWorld(TeeMsg_GalleryEurope27,7);
  RegisterWorld(TeeMsg_GallerySpain,8);
  RegisterWorld(TeeMsg_GalleryMiddleEast,9);
  RegisterWorld(TeeMsg_GalleryNorthAmerica,10);
  RegisterWorld(TeeMsg_GallerySouthAmerica,11);
  RegisterWorld(TeeMsg_GalleryUSA,12);
  RegisterWorld(TeeMsg_GalleryUSAHawaiiAlaska,13);
finalization
  UnRegisterTeeSeries([TWorldSeries]);
end.
