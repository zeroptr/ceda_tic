{*******************************************************}
{                                                       }
{       TiPlotLayoutManager                             }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotLayoutManager;{$endif}
{$ifdef iCLX}unit QiPlotLayoutManager;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iPlotObjects,  iPlotManagers;{$ENDIF}                
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiPlotObjects, QiPlotManagers;{$ENDIF}

type
  TiQuadSide           = (iqsLeft, iqsRight, iqsTop, iqsBottom);
  TiInsertDirection    = (iidMerge, iidBelow, iidAbove);
  
  TiPlotDataViewLayout = class(TiPlotLayoutObject)   end;
  TiPlotDataViewHorz   = class(TiPlotDataViewLayout) end;
  TiPlotDataViewVert   = class(TiPlotDataViewLayout) end;

  //----------------------------------------------------------------------------
  TiPlotLayoutManager = class(TiPlotObjectManagerCustom)
  private
    FXYAxesReverse        : Boolean;
    FDataViewHorz         : TiPlotDataViewHorz;
    FDataViewVert         : TiPlotDataViewVert;
    FEnabled              : Boolean;
    FUpdating             : Boolean;
    FUpdateOccured        : Boolean;

    FTopList              : TStringList;
    FBottomList           : TStringList;
    FLeftList             : TStringList;
    FRightList            : TStringList;
    FLeftUniqueCount      : Integer;
    FRightUniqueCount     : Integer;
    FBottomUniqueCount    : Integer;
    FTopUniqueCount       : Integer;

  protected
    function  GetItem(Index: Integer): TiPlotLayoutObject;
    function  GetName : String;                                                                        override;

    function GetUniqueCount(AList : TStringList) : Integer;

    procedure DoLayoutChange(Sender : TObject);
    procedure RemovingObject(AObject : TiPlotObject);                                                  override;

    procedure FlipXYAxes;
    procedure SetXYAxesReverse(const Value: Boolean);
    procedure SetEnabled      (const Value: Boolean);
  public
    constructor Create(AOwner: TWinControl; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); override;
    destructor  Destroy;                                                                               override;

    function  VisibleCount(AList: TStringList): Integer;

    procedure InsertZOrder(NewObject: TiPlotLayoutObject; DesiredZOrder: Integer; InsertDirection: TiInsertDirection);
    procedure RemoveZOrder(AObject : TiPlotLayoutObject);

    procedure NotificationInsert(Sender : TObject); override;

    property Items[Index: Integer]: TiPlotLayoutObject read GetItem;

    property XYAxesReverse        : Boolean            read FXYAxesReverse write SetXYAxesReverse;

    property DataViewHorz         : TiPlotDataViewHorz read FDataViewHorz;
    property DataViewVert         : TiPlotDataViewVert read FDataViewVert;

    property TopList              : TStringList        read FTopList;
    property BottomList           : TStringList        read FBottomList;
    property LeftList             : TStringList        read FLeftList;
    property RightList            : TStringList        read FRightList;

    property TopUniqueCount       : Integer            read FTopUniqueCount;
    property BottomUniqueCount    : Integer            read FBottomUniqueCount;
    property LeftUniqueCount      : Integer            read FLeftUniqueCount;
    property RightUniqueCount     : Integer            read FRightUniqueCount;

    property Enabled              : Boolean            read FEnabled      write SetEnabled;
  end;

implementation

uses
{$ifdef iVCL} iPlotToolBar,  iPlotLegend,  iPlotAxis,  iPlotChannel,  iPlotDataView,  iPlotLabel;{$endif}
{$ifdef iCLX}QiPlotToolBar, QiPlotLegend, QiPlotAxis, QiPlotChannel, QiPlotDataView, QiPlotLabel;{$endif}

type
  TiPlotLayoutAccess = class(TiPlotLayoutObject) end;

//****************************************************************************************************************************************************
constructor TiPlotLayoutManager.Create(AOwner: TWinControl; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited;

  FTopList    := TStringList.Create; FTopList.Sorted    := True; FTopList.Duplicates    := dupAccept;
  FBottomList := TStringList.Create; FBottomList.Sorted := True; FBottomList.Duplicates := dupAccept;
  FLeftList   := TStringList.Create; FLeftList.Sorted   := True; FLeftList.Duplicates   := dupAccept;
  FRightList  := TStringList.Create; FRightList.Sorted  := True; FRightList.Duplicates  := dupAccept;

  FEnabled := False;

  FDataViewHorz    := TiPlotDataViewHorz.Create(Owner, AOnChange,  AOnInsert, AOnRemove, AOnRemove);
  with FDataViewHorz do
    begin
      Horizontal := True;
      ZOrder     := 1;
      Name       := 'Data View';
      Loaded;
    end;

  FDataViewVert    := TiPlotDataViewVert.Create(Owner, AOnChange,  AOnInsert, AOnRemove, AOnRemove);
  with FDataViewVert do
    begin
      Horizontal := False;
      ZOrder     := 1;
      Name       := 'Data View';
      Loaded;
    end;

  FEnabled := True;
end;
//****************************************************************************************************************************************************
destructor TiPlotLayoutManager.Destroy;
begin
  FDataViewHorz.Free; FDataViewHorz := nil;
  FDataViewVert.Free; FDataViewVert := nil;

  FTopList.Free;      FTopList      := nil;
  FBottomList.Free;   FBottomList   := nil;
  FLeftList.Free;     FLeftList     := nil;
  FRightList.Free;    FRightList    := nil;

  inherited Destroy;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutManager.GetItem(Index: Integer): TiPlotLayoutObject;                                                              
begin
  Result := GetObject(Index) as TiPlotLayoutObject;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutManager.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
    begin
      FEnabled := Value;
      if FEnabled then DoLayoutChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutManager.FlipXYAxes;
var
  AObject  : TiPlotLayoutObject;
  AxesList : TStringList;
  x        : Integer;
begin
  AxesList := TStringList.Create;
  try
    AxesList.Sorted := True;
    AxesList.Duplicates := dupAccept;
    for x := 0 to Count-1 do
      begin
        AObject := Items[x] as TiPlotLayoutObject;
        if AObject is TiPlotAxis then
          begin
            AxesList.AddObject(IntToStr(AObject.ZOrder), AObject);
          end;
      end;

    for x := 0 to AxesList.Count-1 do
      begin
        AObject := AxesList.Objects[x] as TiPlotLayoutObject;
        RemoveZOrder(AObject);
        if AObject is TiPlotXAxis then AObject.Horizontal := not FXYAxesReverse;
        if AObject is TiPlotYAxis then AObject.Horizontal :=     FXYAxesReverse;
        InsertZOrder(AObject, 0, iidMerge);
      end;                                              
  finally
    AxesList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutManager.NotificationInsert(Sender: TObject);
var
  iPlotLayoutObject : TiPlotLayoutObject;
begin
  if Sender is TiPlotLayoutObject then
    begin
      iPlotLayoutObject := Sender as TiPlotLayoutObject;
      InsertObject(iPlotLayoutObject);

      if (iPlotLayoutObject is TiPlotAxis    ) or
         (iPlotLayoutObject is TiPlotToolBar ) or
         (iPlotLayoutObject is TiPlotLegend  ) or
         (iPlotLayoutObject is TiPlotDataView) or
         (iPlotLayoutObject is TiPlotLabel   )
      then TiPlotLayoutAccess(iPlotLayoutObject).OnLayoutChange := DoLayoutChange;

      if iPlotLayoutObject is TiPlotXAxis then iPlotLayoutObject.Horizontal := not FXYAxesReverse;
      if iPlotLayoutObject is TiPlotYAxis then iPlotLayoutObject.Horizontal := FXYAxesReverse;

      if FEnabled then InsertZOrder(iPlotLayoutObject, 0, iidMerge);
    end;  //Do not Call Inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutManager.RemovingObject(AObject: TiPlotObject);
var
  iPlotLayoutObject : TiPlotLayoutObject;
begin
  iPlotLayoutObject := AObject as TiPlotLayoutObject;

  if Assigned(FTopList)   then if FTopList.IndexOfObject   (AObject)<>-1 then FTopList.Delete   (FTopList.IndexOfObject   (AObject));
  if Assigned(FBottomList)then if FBottomList.IndexOfObject(AObject)<>-1 then FBottomList.Delete(FBottomList.IndexOfObject(AObject));
  if Assigned(FLeftList)  then if FLeftList.IndexOfObject  (AObject)<>-1 then FLeftList.Delete  (FLeftList.IndexOfObject  (AObject));
  if Assigned(FRightList) then if FRightList.IndexOfObject (AObject)<>-1 then FRightList.Delete (FRightList.IndexOfObject (AObject));

  if FEnabled then RemoveZOrder(iPlotLayoutObject);
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutManager.InsertZOrder(NewObject: TiPlotLayoutObject; DesiredZOrder: Integer; InsertDirection: TiInsertDirection);
var
  x             : Integer;
  CanMerge      : Boolean;
  NeedsShifting : Boolean;
  NewZOrder     : Integer;
begin
  NewZOrder := DesiredZOrder;
  CanMerge := True;

  if InsertDirection = iidMerge then
    begin
      for x := 0 to Count -1 do
        begin
          if Items[x] is TiPlotDataView  then Continue;
          if (NewObject <> Items[x]) and (Items[x].Horizontal = NewObject.Horizontal) then
            if Items[x].ZOrder = NewZOrder then
              begin
                if (NewObject.StopPercent  > Items[x].StartPercent) and (NewObject.StartPercent < Items[x].StopPercent) or
                   (NewObject.StartPercent = Items[x].StartPercent) and (NewObject.StopPercent  = Items[x].StopPercent) then
                CanMerge := False;
              end;
        end;
    end
  else CanMerge := False;

  if not CanMerge then
    begin
      if InsertDirection = iidMerge then
        begin
          NeedsShifting := False;
          for x := 0 to Count -1 do
            if (NewObject <> Items[x]) and (Items[x].Horizontal = NewObject.Horizontal) and (Items[x].ZOrder = DesiredZOrder) then
              begin
                NeedsShifting := True;
                Break;
              end;
        end
      else NeedsShifting := True;

      if NeedsShifting then
        begin
          for x := 0 to Count -1 do
            begin
              if Items[x].Horizontal <> NewObject.Horizontal then Continue;
              if NewObject = Items[x]                        then Continue;
              if Items[x] is TiPlotDataView                  then Continue;

              case InsertDirection of
                iidMerge : if Items[x].ZOrder >= NewZOrder then Items[x].ZOrder := Items[x].ZOrder + 1;
                iidAbove : if Items[x].ZOrder >  NewZOrder then Items[x].ZOrder := Items[x].ZOrder + 1;
                iidBelow : if Items[x].ZOrder >= NewZOrder then Items[x].ZOrder := Items[x].ZOrder + 1;
              end;
            end;

          case InsertDirection of                               
            iidMerge : NewObject.ZOrder := NewZOrder;
            iidAbove : NewObject.ZOrder := NewZOrder + 1;
            iidBelow : NewObject.ZOrder := NewZOrder;
          end;
       end;
    end
  else NewObject.ZOrder := NewZOrder;
  DoLayoutChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutManager.RemoveZOrder(AObject: TiPlotLayoutObject);
var
  x             : Integer;
  NeedsShifting : Boolean;
  CanCheck      : Boolean;
begin
  NeedsShifting := True;
  for x := 0 to Count -1 do
    begin
                                                        CanCheck := True;
      if AObject =  Items[x]                       then CanCheck := False;
      if Items[x].Horizontal <> AObject.Horizontal then CanCheck := False;
      if Items[x] is TiPlotDataView                then CanCheck := False;

      if CanCheck and (Items[x].ZOrder = AObject.ZOrder) then NeedsShifting := False;
    end;

  if NeedsShifting then
    for x := 0 to Count -1 do
      if (AObject <> Items[x]) and (Items[x].Horizontal = AObject.Horizontal) then
        if Items[x].ZOrder > AObject.ZOrder then Items[x].ZOrder := Items[x].ZOrder- 1;

  DoLayoutChange(Self);
end;
//****************************************************************************************************************************************************
function TiPlotLayoutManager.VisibleCount(AList: TStringList): Integer;
var
  x : Integer;
begin
  Result := 0;
  for x := 0 to AList.Count-1 do
    if (AList.Objects[x] as TiPlotLayoutObject).Visible then Inc(Result);
end;
//****************************************************************************************************************************************************
function TiPlotLayoutManager.GetUniqueCount(AList : TStringList) : Integer;
var
  x           : Integer;
  LastZOrder  : Integer;
  ZOrderValue : Integer;
begin
  Result := 0;
  if AList.Count <> 0 then
    begin
      LastZOrder := StrToInt(Copy(AList.Strings[0], 1, 3));
      Result := Result + 1;
      for x := 1 to AList.Count-1 do
        begin
          ZOrderValue := StrToInt(Copy(AList.Strings[x], 1, 3));
          if ZOrderValue > LastZOrder then
            begin
              Result := Result + 1;
              LastZOrder := ZOrderValue;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutManager.DoLayoutChange(Sender: TObject);
var
  iLayoutObject : TiPlotLayoutObject;
  x             : Integer;
  SortString    : String;
begin
  if not FEnabled then exit;
  if not FUpdating then
    begin
      FTopList.Clear;
      FBottomList.Clear;
      FRightList.Clear;
      FLeftList.Clear;

      for x := 0 to Count-1 do
        begin
          iLayoutObject := Items[x];
          if iLayoutObject is TiPlotDataView       then Continue;
          if iLayoutObject is TiPlotDataViewLayout then Continue;

          SortString := TiPlotLayoutAccess(iLayoutObject).ZOrderString + TiPlotLayoutAccess(iLayoutObject).StartPercentString;

          if TiPlotLayoutAccess(iLayoutObject).IsHorz then
            begin                                                       
              TiPlotLayoutAccess(iLayoutObject).ReverseSide := (iLayoutObject.ZOrder > FDataViewHorz.ZOrder);
              if iLayoutObject.ZOrder > FDataViewHorz.ZOrder then FTopList.AddObject   (SortString, iLayoutObject)
                else                                              FBottomList.AddObject(SortString, iLayoutObject);
            end
          else
            begin
              TiPlotLayoutAccess(iLayoutObject).ReverseSide := (iLayoutObject.ZOrder > FDataViewVert.ZOrder);
              if iLayoutObject.ZOrder > FDataViewVert.ZOrder then FRightList.AddObject (SortString, iLayoutObject)
                else                                              FLeftList.AddObject  (SortString, iLayoutObject);
            end;
        end;

      FLeftUniqueCount   := GetUniqueCount(FLeftList);
      FRightUniqueCount  := GetUniqueCount(FRightList);
      FTopUniqueCount    := GetUniqueCount(FTopList);
      FBottomUniqueCount := GetUniqueCount(FBottomList);

      //if Assigned(OnChange) then OnChange(Self);  
    end
  else FUpdateOccured := True;           
end;
//****************************************************************************************************************************************************
function TiPlotLayoutManager.GetName: String;
begin
  Result := 'Layout Object'
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutManager.SetXYAxesReverse(const Value: Boolean);
begin
  if FXYAxesReverse <> Value then
    begin
      FXYAxesReverse := Value;
      if FEnabled then FlipXYAxes;
    end;
end;
//****************************************************************************************************************************************************
end.


