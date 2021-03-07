{******************************************}
{  TeeChart Series DB Virtual DataSet      }
{ Copyright (c) 1996-2009 by David Berneda }
{          All Rights Reserved             }
{******************************************}
unit TeeData;
{$I TeeDefs.inc}

{$R-}

{ This unit contains two VIRTUAL TDATASET derived components.

  1) The TSeriesDataSet component is an intermediary between a
  Series component and a TDataSource.

  You can show Series values in a DBGrid, for example:

  SeriesDataSet1.Series := Series1;
  DataSource1.DataSet   := SeriesDataSet1;
  DBGrid1.DataSource    := DataSource1;

  To refresh data:

  SeriesDataSet1.Close;
  Series1.Add(....)
  SeriesDataSet1.Open;

  2) The TChartDataSet component is an intermediary between a
  Chart (or DBChart or QRChart) component and a TDataSource.

  ChartDataSet1.Chart := Chart1;
  DataSource1.DataSet := ChartDataSet1;
  DBGrid1.DataSource  := DataSource1;

  Additional information under Delphi \Demos\TextData example project.

  NOTE: This component is not available in Delphi and C++ Builder
        STANDARD versions, because they do not include Database components.

}
interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     DB, Classes,
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeEngine, TeeProcs, Chart;

Const
  MaxLabelLen=128;

type
  PSeriesPoint=^TSeriesPoint;
  TSeriesPoint=packed record
    Color  : TColor; { 4 bytes (TColor is 4 bytes Integer in x86) }
    X      : TChartValue;  { 8 bytes by default TChartValue is a Double }
    Values : packed Array[0..10] of TChartValue; { 10*SizeOf(TChartValue) (88 bytes by default) }
    ALabel : String; { Unicode }
  end;

  PSeriesPoints=^TSeriesPoints;
  TSeriesPoints=packed Array[0..0] of TSeriesPoint;

  PRecInfo = ^TRecInfo;
  TRecInfo = packed record
    Bookmark     : Integer;
    BookmarkFlag : TBookmarkFlag;
  end;

  TTeeDataSet=class(TDataSet)
  private
    FBookMarks    : TList;
    FCurRec       : Integer;
    FLastBookmark : Integer;

    IAllocated    : Integer;

    Procedure DoCreateField(Const AFieldName:String; AType:TFieldType; ASize:Integer);
    Function RecBufSize: Integer;
  protected
    procedure AddSeriesFields(Series:TChartSeries; PrefixSeriesName:Boolean=False);

    function AllocRecordBuffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}; override;

    Procedure DoAddSeriesPoint(const Buffer:TSeriesPoint; Series:TChartSeries);
    Procedure DoFillBuffer(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}); virtual; abstract;
    Procedure FillSeriesBuffer(var Buffer:TSeriesPoint; Series:TChartSeries);

    procedure FreeRecordBuffer(var Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}); override;

    {$IFDEF CLR}
    procedure GetBookmarkData(Buffer: TRecordBuffer; var Bookmark: TBookmark); override;
    {$ELSE}
    procedure GetBookmarkData(Buffer:{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}; Data: Pointer); override;
    {$ENDIF}

    function GetBookmarkFlag(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}): TBookmarkFlag; override;
    function GetRecNo: Integer; override;
    function GetRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    function GetSeriesBuffer(FieldIndex:Integer; var Active:TSeriesPoint; Buffer: Pointer; Series:TChartSeries):Boolean;

    procedure InternalAddRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}Pointer{$ENDIF}; Append: Boolean); override;
    procedure InternalClose; override;
    procedure InternalDelete; override;
    procedure InternalFirst; override;
    procedure InternalGotoBookmark({$IFDEF CLR}const Bookmark:TBookmark{$ELSE}Bookmark: Pointer{$ENDIF}); override;
    procedure InternalHandleException; override;
    procedure InternalInitRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}); override;
    procedure InternalLast; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    procedure InternalSetToRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}); override;
    function IsCursorOpen: Boolean; override;

    procedure PostToSeries(Series:TChartSeries; const Buffer:TSeriesPoint);

    Function RecInfoOfs:Integer; virtual; abstract;

    {$IFDEF CLR}
    procedure SetBookmarkData(Buffer: TRecordBuffer; const Bookmark: TBookmark); override;
    {$ELSE}
    procedure SetBookmarkData(Buffer: {$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}; Data: Pointer); override;
    {$ENDIF}

    procedure SetBookmarkFlag(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}; Value: TBookmarkFlag); override;
    procedure SetFieldData(Field: TField; Buffer: {$IFDEF CLR}TValueBuffer{$ELSE}Pointer{$ENDIF}); override;
    procedure SetRecNo(Value: Integer); override;

    procedure SetSeriesBuffer(FieldIndex:Integer; const Active:TSeriesPoint; Buffer:Pointer; Series:TChartSeries);
  public
  published
    property Active;
    property AutoCalcFields;
    property BeforeOpen;
    property AfterOpen;
    property BeforeClose;
    property AfterClose;
    property BeforeInsert;
    property AfterInsert;
    property BeforeEdit;
    property AfterEdit;
    property BeforePost;
    property AfterPost;
    property BeforeCancel;
    property AfterCancel;
    property BeforeDelete;
    property AfterDelete;
    property BeforeScroll;
    property AfterScroll;

    {$IFDEF D5}
    property AfterRefresh;
    property BeforeRefresh;
    {$ENDIF}

    property OnCalcFields;
    property OnDeleteError;
    property OnEditError;
    property OnNewRecord;
    property OnPostError;
  end;

  TSeriesDataSet = class(TTeeDataSet,ITeeEventListener)
  private
    FSeries       : TChartSeries;

    procedure TeeEvent(Event: TTeeEvent);
  protected

    { Overriden abstract methods (required) }
    Procedure DoFillBuffer(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}); override;
    function GetRecordSize: Word; override;

    procedure InternalAddRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}Pointer{$ENDIF}; Append: Boolean); override;
    procedure InternalDelete; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    function IsCursorOpen: Boolean; override;

    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;

    procedure SetFieldData(Field: TField; Buffer: {$IFDEF CLR}TValueBuffer{$ELSE}Pointer{$ENDIF}); override;

    { Additional overrides (optional) }
    function GetRecordCount: Integer; override;
    Function RecInfoOfs: Integer; override;
    Procedure SetSeries(ASeries:TChartSeries); virtual;
  public
    function GetFieldData(Field: TField; Buffer: {$IFDEF CLR}TValueBuffer{$ELSE}Pointer{$ENDIF}): Boolean; override;
  published
    property Series: TChartSeries read FSeries write SetSeries stored True;
  end;

  TChartDataSet = class(TTeeDataSet,ITeeEventListener)
  private
    FChart : TCustomChart;

    procedure CalcFieldSeries(Field:Integer; var Index,Series:Integer);
    procedure SetChart(Value:TCustomChart);
    procedure TeeEvent(Event: TTeeEvent);
  protected
    Procedure DoFillBuffer(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}); override;
    function GetRecordCount: Integer; override;
    function GetRecordSize: Word; override;
    procedure InternalAddRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}Pointer{$ENDIF}; Append: Boolean); override;
    procedure InternalDelete; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    function IsCursorOpen: Boolean; override;
    Function RecInfoOfs: Integer; override;
    procedure SetFieldData(Field: TField; Buffer: {$IFDEF CLR}TValueBuffer{$ELSE}Pointer{$ENDIF}); override;
  public
    function GetFieldData(Field: TField; Buffer: {$IFDEF CLR}TValueBuffer{$ELSE}Pointer{$ENDIF}): Boolean; override;
  published
    property Chart:TCustomChart read FChart write SetChart;
  end;

implementation

uses SysUtils,
     {$IFDEF CLX}
     QForms,
     {$ELSE}
     Forms,
     {$ENDIF}
     TeeConst, TeCanvas;

type
  PChartValue=^TChartValue;

{ TTeeDataset }
Function TTeeDataSet.RecBufSize: Integer;
begin
  result:=RecInfoOfs + SizeOf(TRecInfo);
end;

procedure TTeeDataSet.InternalClose;
begin
  {$IFDEF D5}
  FreeAndNil(FBookMarks);
  {$ELSE}
  FBookMarks.Free;
  FBookMarks:=nil;
  {$ENDIF}

  if DefaultFields then
     DestroyFields;

  FLastBookmark := 0;
  FCurRec := -1;
end;

Procedure TTeeDataSet.DoCreateField(Const AFieldName:String; AType:TFieldType; ASize:Integer);
begin
  {$IFDEF C3D4}
  With TFieldDef.Create(FieldDefs) do
  begin
    Name      := AFieldName;
    Size      := ASize;
    Required  := False;
    DataType  := AType;
  end;
  {$ELSE}
  TFieldDef.Create(FieldDefs, AFieldName, AType, ASize, False, FieldDefs.Count+1)
  {$ENDIF}
end;

procedure TTeeDataSet.InternalHandleException;
begin
  Application.HandleException(Self);
end;

procedure TTeeDataSet.InternalDelete;
begin
  FBookMarks.Delete(FCurRec);

  if FCurRec >= RecordCount then
     Dec(FCurRec);
end;

procedure TTeeDataSet.InternalGotoBookmark({$IFDEF CLR}const Bookmark:TBookmark{$ELSE}Bookmark: Pointer{$ENDIF});
var Index: Integer;
begin
  Index := FBookMarks.IndexOf({$IFDEF CLR}Bookmark{$ELSE}Pointer(PInteger(Bookmark)^){$ENDIF});
  if Index <> -1 then
     FCurRec := Index
  else
     DatabaseError('Bookmark not found');
end;

procedure TTeeDataSet.InternalSetToRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF});
begin
  {$IFDEF CLR}
  InternalGotoBookmark(TRecordBuffer(Longint(Buffer) + FBookmarkOfs));
  {$ELSE}
  InternalGotoBookmark(@PRecInfo(Buffer + RecInfoOfs).Bookmark);
  {$ENDIF}
end;

procedure TTeeDataSet.InternalAddRecord(Buffer: Pointer; Append: Boolean);
begin
  Inc(FLastBookmark);
  if Append then InternalLast;
end;

function TTeeDataSet.GetBookmarkFlag(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}): TBookmarkFlag;
begin
  {$IFDEF CLR}
  with Marshal do
    Result := TBookmarkFlag(ReadByte(Buffer, FRecInfoOfs + 5)); // TRecInfo.BookmarkFlag
  {$ELSE}
  Result := PRecInfo(Buffer + RecInfoOfs).BookmarkFlag;
  {$ENDIF}
end;

procedure TTeeDataSet.SetBookmarkFlag(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}; Value: TBookmarkFlag);
begin
  {$IFDEF CLR}
  with Marshal do
    WriteByte(Buffer, FRecInfoOfs + 5, Byte(Value)); // TRecInfo.BookmarkFlag
  {$ELSE}
  PRecInfo(Buffer + RecInfoOfs).BookmarkFlag := Value;
  {$ENDIF}
end;

{$IFDEF CLR}
procedure TTeeDataSet.GetBookmarkData(Buffer: TRecordBuffer; var Bookmark: TBookmark);
{$ELSE}
procedure TTeeDataSet.GetBookmarkData(Buffer: {$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}; Data: Pointer);
{$ENDIF}
begin
  PInteger(Data)^ := PRecInfo(Buffer + RecInfoOfs).Bookmark;
end;

{$IFDEF CLR}
procedure TTeeDataSet.SetBookmarkData(Buffer: TRecordBuffer; const Bookmark: TBookmark);
{$ELSE}
procedure TTeeDataSet.SetBookmarkData(Buffer: {$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}; Data: Pointer);
{$ENDIF}
begin
  PRecInfo(Buffer + RecInfoOfs).Bookmark := PInteger(Data)^;
end;

function TTeeDataSet.AllocRecordBuffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF};
begin
  IAllocated:=RecBufSize;
  GetMem(Result, IAllocated);
end;

procedure TTeeDataSet.FreeRecordBuffer(var Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF});
begin
  FreeMem(Buffer, IAllocated);
end;

procedure TTeeDataSet.InternalInitRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF});
begin
  ZeroMemory(Buffer, RecordSize);
end;

procedure TTeeDataSet.InternalFirst;
begin
  FCurRec := -1;
end;

function TTeeDataSet.GetRecNo: Integer;
begin
  UpdateCursorPos;

  if (FCurRec = -1) and (RecordCount > 0) then
     Result := 1
  else
     Result := FCurRec + 1;
end;

procedure TTeeDataSet.SetRecNo(Value: Integer);
begin
  if (Value >= 0) and (Value <= RecordCount) then
  begin
    FCurRec := Value - 1;
    Resync([]);
  end;
end;

procedure TTeeDataSet.InternalOpen;
var t : Integer;
begin
  { Fabricate integral bookmark values }
  FBookMarks:=TList.Create;

  for t:=1 to RecordCount do
      FBookMarks.Add({$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF}(t));

  FLastBookmark:=RecordCount;

  FCurRec:=-1;

  BookmarkSize := SizeOf(Integer);

  InternalInitFieldDefs;

  if DefaultFields then
     CreateFields;

  BindFields(True);
end;

procedure TTeeDataSet.InternalLast;
begin
  FCurRec:=RecordCount;
end;

function TTeeDataSet.IsCursorOpen: Boolean;
begin
  Result:=Assigned(FBookMarks);
end;

procedure TTeeDataSet.AddSeriesFields(Series:TChartSeries; PrefixSeriesName:Boolean=False);

  Function GetFieldName(Const ADefault,AName:String):String;
  begin
    if PrefixSeriesName then
    begin
      result:=Series.Name;

      if (result='') and Assigned(Series.ParentChart) then
         result:=TeeMsg_Series+TeeStr(1+Series.ParentChart.SeriesList.IndexOf(Series));

      result:=result+'.';
    end
    else
       result:='';

    if AName='' then result:=result+ADefault
                else result:=result+AName;

  end;

  Procedure AddField(IsDateTime:Boolean; Const FieldName:String);
  begin
    if IsDateTime then DoCreateField(FieldName,ftDateTime,0)
                  else DoCreateField(FieldName,ftFloat,0);
  end;

var tmp:String;
    t:Integer;
begin
  {$IFDEF C3D4}
  With TFieldDef.Create(FieldDefs) do
  begin
    Name:=GetFieldName('','Color');
    DataType:=ftInteger;
    Size:=0;
    Required:=False;
    FieldNo:=1;
  end;
  {$ELSE}
  TFieldDef.Create(FieldDefs, GetFieldName('','Color'), ftInteger, 0, False, 1);
  {$ENDIF}

  With Series.XValues do AddField(DateTime,GetFieldName('X',Name));
  With Series.YValues do AddField(DateTime,GetFieldName('Y',Name));

  {$IFDEF C3D4}
  With TFieldDef.Create(FieldDefs) do
  begin
    Name:=GetFieldName('','Label');
    DataType:=ftString;
    Size:=MaxLabelLen;
    Required:=False;
    FieldNo:=4;
  end;
  {$ELSE}
  TFieldDef.Create(FieldDefs, GetFieldName('','Label'), ftString, MaxLabelLen, False, 4);
  {$ENDIF}

  for t:=2 to Series.ValuesList.Count-1 do
  With Series.ValuesList[t] do
  begin
    tmp:=Name;

    if Name='' then tmp:='Value'+TeeStr(t)
               else tmp:=Name;

    AddField(DateTime,GetFieldName('',tmp));
  end;
end;

procedure TTeeDataSet.SetSeriesBuffer(FieldIndex:Integer; const Active:TSeriesPoint; Buffer:Pointer; Series:TChartSeries);

   Function GetAValue(IsDateTime:Boolean):TChartValue;
   begin
     result:=PChartValue(Buffer)^;

     if IsDateTime then
        result:=TimeStampToDateTime(MSecsToTimeStamp(result));
   end;

begin
  with PSeriesPoint(ActiveBuffer)^ do
  Case FieldIndex of
    1: Color:=PInteger(Buffer)^;
    2: X:=GetAValue(Series.XValues.DateTime);
    3: Values[0]:=GetAValue(Series.YValues.DateTime);
    4: ALabel:=PChar(Buffer);
  else
    Values[FieldIndex-4]:=GetAValue(Series.ValuesList[FieldIndex-3].DateTime);
  end;
end;

procedure TTeeDataSet.SetFieldData(Field: TField; Buffer: Pointer);
begin
  DataEvent(deFieldChange, Integer(Field));
end;

function TTeeDataSet.GetRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF}; GetMode: TGetMode; DoCheck: Boolean): TGetResult;
begin
  result:=grError;

  if IsCursorOpen then
  begin
    if RecordCount < 1 then Result := grEOF
    else
    begin
      Result := grOK;

      case GetMode of
        gmNext: if FCurRec >= RecordCount - 1  then result:=grEOF
                                               else Inc(FCurRec);
       gmPrior: if FCurRec <= 0 then result:=grBOF
                                else Dec(FCurRec);

     gmCurrent: if (FCurRec < 0) or (FCurRec >= RecordCount) then
                   result := grError;
      end;

      if result=grOK then
      begin
        DoFillBuffer(Buffer);

        with PRecInfo(Buffer + RecInfoOfs)^ do
        begin
          BookmarkFlag := bfCurrent;

          if Assigned(FBookMarks) and (FBookMarks.Count>FCurRec) and
             Assigned(FBookMarks[FCurRec]) then
             Bookmark := Integer(FBookMarks[FCurRec])
          else
             BookMark := -1;
        end;

      end
      else
      if (Result = grError) and DoCheck then
         DatabaseError('No Records');
    end;
  end
  else
  if DoCheck then DatabaseError('No Records');
end;

Procedure TTeeDataSet.FillSeriesBuffer(var Buffer:TSeriesPoint; Series:TChartSeries);
var t : Integer;
begin
  With Buffer do
  begin
    Color:=Series.ValueColor[FCurRec];
    X:=Series.XValues.Value[FCurRec];
    ALabel:=Series.Labels[FCurRec];

    for t:=1 to Series.ValuesList.Count-1 do
        Values[t-1]:=Series.ValuesList[t].Value[FCurRec];
  end;
end;

function TTeeDataSet.GetSeriesBuffer(FieldIndex:Integer; var Active:TSeriesPoint; Buffer: Pointer; Series:TChartSeries):Boolean;

   Function GetSeriesValue(AList:TChartValueList):TChartValue;
   var t : Integer;
   begin
     if AList=Series.XValues then
        result:=Active.X
     else
     begin
       result:=0;

       for t:=1 to Series.ValuesList.Count-1 do
       if AList=Series.ValuesList[t] then
       begin
         result:=Active.Values[t-1];
         break;
       end;
     end;

     if AList.DateTime then
        result:=TimeStampToMSecs(DateTimeToTimeStamp(result));
   end;

begin
  result:=Series.Count>0;

  if result and Assigned(Buffer) then
  Case FieldIndex of
    1: PInteger(Buffer)^:=Active.Color;
    2: PChartValue(Buffer)^:=GetSeriesValue(Series.XValues);
    3: PChartValue(Buffer)^:=GetSeriesValue(Series.YValues);
    4: begin
         StrPCopy(Buffer,Active.ALabel);
         result := PChar(Buffer)^ <> #0;
       end;
    else
    begin
      PChartValue(Buffer)^:=GetSeriesValue(Series.ValuesList[FieldIndex-3]);
    end;
  end;
end;

Procedure TTeeDataSet.DoAddSeriesPoint(const Buffer:TSeriesPoint; Series:TChartSeries);
var t : Integer;
begin
  With Buffer do
  begin
    for t:=2 to Series.ValuesList.Count-1 do
        Series.ValuesList[t].TempValue:=Values[t-1];

    Series.AddXY(X,Values[0],ALabel,Color);
  end;
end;

procedure TTeeDataSet.PostToSeries(Series:TChartSeries; const Buffer:TSeriesPoint);
var t : Integer;
begin
  With Buffer do
  Begin
    Series.ValueColor[FCurRec]:=Color;
    Series.XValues.Value[FCurRec]:=X;
    Series.YValues.Value[FCurRec]:=Values[0];
    Series.Labels[FCurRec]:=ALabel;

    for t:=2 to Series.ValuesList.Count-1 do
        Series.ValuesList[t].Value[FCurRec]:=Values[t-1];
  end;
end;

procedure TTeeDataSet.InternalPost;
begin
  if State <> dsEdit then
  begin
    Inc(FLastBookmark);
    FBookMarks.Add(Pointer(FLastBookMark));
  end;
end;

{ TSeriesDataSet }

{$IFNDEF CLR}
type
  TTeePanelAccess=class(TCustomTeePanel);
{$ENDIF}

Procedure TSeriesDataSet.DoFillBuffer(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF});
begin
  FillSeriesBuffer(PSeriesPoint(Buffer)^,FSeries);
end;

Procedure TSeriesDataSet.SetSeries(ASeries:TChartSeries);
Var WasActive : Boolean;
begin
  WasActive:=Active;
  Active:=False;

  if Assigned(FSeries) then
  begin
    {$IFDEF D5}
    FSeries.RemoveFreeNotification(Self);
    {$ENDIF}

    if Assigned(FSeries.ParentChart) then
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FSeries.ParentChart).RemoveListener(Self);
  end;

  FSeries:=ASeries;

  if Assigned(FSeries) then
  begin
    FSeries.FreeNotification(Self);
    if Assigned(FSeries.ParentChart) then
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FSeries.ParentChart).Listeners.Add(Self);
  end;

  if Assigned(FSeries) and WasActive then
     Active:=True;
end;

procedure TSeriesDataSet.Notification( AComponent: TComponent;
                            Operation: TOperation);
begin
  inherited;

  if (Operation=opRemove) and Assigned(FSeries) and (AComponent=FSeries) then
     Series:=nil;
end;

Function TSeriesDataSet.RecInfoOfs:Integer;
begin
  result:=SizeOf(TSeriesPoint);
end;

procedure TSeriesDataSet.InternalOpen;
begin
  if not Assigned(FSeries) then
     Raise Exception.Create('Cannot open SeriesDataSet. No Series assigned.');

  inherited;
end;

function TSeriesDataSet.IsCursorOpen: Boolean;
begin
  Result:=(inherited IsCursorOpen) and Assigned(FSeries);
end;

procedure TSeriesDataSet.InternalInitFieldDefs;
begin
  FieldDefs.Clear;

  if Assigned(FSeries) then
     AddSeriesFields(FSeries);
end;

function TSeriesDataSet.GetRecordSize: Word;
begin
  if Assigned(FSeries) then result:=SizeOf(TSeriesPoint)
                       else result:=0;
end;

function TSeriesDataSet.GetFieldData(Field: TField; Buffer: Pointer): Boolean;
begin
  result:=(ActiveBuffer<>nil) and GetSeriesBuffer(Field.FieldNo,PSeriesPoint(ActiveBuffer)^,Buffer,Series);
end;

procedure TSeriesDataSet.SetFieldData(Field: TField; Buffer: Pointer);
begin
  if ActiveBuffer<>nil then
     SetSeriesBuffer(Field.FieldNo,PSeriesPoint(ActiveBuffer)^,Buffer,FSeries);

  inherited;
end;

procedure TSeriesDataSet.InternalPost;
begin
  if State = dsEdit then
     PostToSeries(FSeries,PSeriesPoint(ActiveBuffer)^)
  else
     DoAddSeriesPoint(PSeriesPoint(ActiveBuffer)^,FSeries);

  inherited;
end;

procedure TSeriesDataSet.InternalAddRecord(Buffer: Pointer; Append: Boolean);
begin
  inherited;
  DoAddSeriesPoint(PSeriesPoint(Buffer)^,FSeries);
  FBookMarks.Add(Pointer(FLastBookMark));
end;

procedure TSeriesDataSet.InternalDelete;
begin
  FSeries.Delete(FCurRec);
  inherited;
end;

function TSeriesDataSet.GetRecordCount: Integer;
begin
  Result:=FSeries.Count;
end;

procedure TSeriesDataSet.TeeEvent(Event: TTeeEvent);
begin
  if Active and (Event is TTeeSeriesEvent) and
     (TTeeSeriesEvent(Event).Event=seDataChanged) then
  begin
    Close;
    Open;
  end;
end;

{ TChartDataset }

Procedure TChartDataSet.SetChart(Value:TCustomChart);
Var WasActive : Boolean;
begin
  WasActive:=Active;
  Active:=False;

  if Assigned(FChart) then
  begin
    {$IFDEF D5}
    FChart.RemoveFreeNotification(Self);
    {$ENDIF}

    {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FChart).RemoveListener(Self);
  end;

  FChart:=Value;

  if Assigned(FChart) then
  begin
    FChart.FreeNotification(Self);

    {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FChart).Listeners.Add(Self);
  end;

  if Assigned(FChart) and WasActive then
     Active:=True;
end;

procedure TChartDataSet.TeeEvent(Event: TTeeEvent);

  function ValidEvent(Value:TChartSeriesEvent):Boolean;
  begin
    result:=(Value=seAdd) or (Value=seRemove) or (Value=seDataChanged);
  end;

begin
  if Active and (Event is TTeeSeriesEvent) and
     ValidEvent(TTeeSeriesEvent(Event).Event) then
  begin
    Close;
    Open;
  end;
end;

function TChartDataSet.GetRecordSize: Word;
begin
  result:=FChart.SeriesCount*SizeOf(TSeriesPoint);
end;

procedure TChartDataSet.InternalDelete;
var t : Integer;
begin
  for t:=0 to FChart.SeriesCount-1 do
      if FChart[t].Count>FCurRec then
         FChart[t].Delete(FCurRec);

  inherited;
end;

function TChartDataSet.GetRecordCount: Integer;
var t : Integer;
begin
  result:=0;

  for t:=0 to FChart.SeriesCount-1 do
  With FChart[t] do
       if (t=0) or (Count>result) then
           result:=Count;
end;

function TChartDataSet.IsCursorOpen: Boolean;
begin
  Result:=(inherited IsCursorOpen) and Assigned(FChart);
end;

procedure TChartDataSet.InternalOpen;
begin
  if not Assigned(FChart) then
     Raise Exception.Create('Cannot open Chart DataSet. No Chart assigned.');

  inherited;
end;

procedure TChartDataSet.InternalInitFieldDefs;
var t : Integer;
begin
  FieldDefs.Clear;

  for t:=0 to FChart.SeriesCount-1 do
     AddSeriesFields(FChart[t],FChart.SeriesCount>1);
end;

procedure TChartDataSet.CalcFieldSeries(Field:Integer; var Index,Series:Integer);
begin
  Index:=Field;
  Series:=0;

  while Index>(2+FChart[Series].ValuesList.Count) do
  begin
    Dec(Index,(2+FChart[Series].ValuesList.Count));
    Inc(Series);
  end;
end;

procedure TChartDataSet.SetFieldData(Field: TField; Buffer: Pointer);
var tmpIndex  : Integer;
    tmpSeries : Integer;
begin
  if ActiveBuffer<>nil then
  begin
    CalcFieldSeries(Field.FieldNo,tmpIndex,tmpSeries);
    SetSeriesBuffer(tmpIndex,PSeriesPoints(ActiveBuffer)[tmpSeries],Buffer,FChart[tmpSeries]);
  end;

  inherited;
end;

Function TChartDataSet.RecInfoOfs:Integer;
begin
  result:=SizeOf(TSeriesPoint);

  if Assigned(FChart) then
     result:=result*FChart.SeriesCount;
end;

Procedure TChartDataSet.DoFillBuffer(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}{$IFDEF D12}PByte{$ELSE}PChar{$ENDIF}{$ENDIF});
var t : Integer;
begin
  for t:=0 to FChart.SeriesCount-1 do
      FillSeriesBuffer(TSeriesPoint(PSeriesPoints(Buffer)[t]),FChart[t]);
end;

function TChartDataSet.GetFieldData(Field: TField; Buffer: {$IFDEF CLR}TValueBuffer{$ELSE}Pointer{$ENDIF}): Boolean;
var tmpIndex  : Integer;
    tmpSeries : Integer;
begin
  CalcFieldSeries(Field.FieldNo,tmpIndex,tmpSeries);
  result:=(ActiveBuffer<>nil) and GetSeriesBuffer(tmpIndex,PSeriesPoints(ActiveBuffer)[tmpSeries],Buffer,FChart[tmpSeries]);
end;

procedure TChartDataSet.InternalPost;
var t : Integer;
begin
  for t:=0 to FChart.SeriesCount-1 do
  if State = dsEdit then
     PostToSeries(FChart[t],PSeriesPoints(ActiveBuffer)[t])
  else
     DoAddSeriesPoint(PSeriesPoints(ActiveBuffer)[t],FChart[t]);

  inherited;
end;

procedure TChartDataSet.InternalAddRecord(Buffer: Pointer; Append: Boolean);
var t : Integer;
begin
  inherited;

  for t:=0 to FChart.SeriesCount-1 do
      DoAddSeriesPoint(PSeriesPoints(Buffer)[t],FChart[t]);

  FBookMarks.Add(Pointer(FLastBookMark));
end;

end.
