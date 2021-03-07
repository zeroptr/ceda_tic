{*******************************************************}
{                                                       }
{       iPlotManagers                                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotManagers;{$endif}
{$ifdef iCLX}unit QiPlotManagers;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iPlotObjects,{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiPlotObjects,{$ENDIF}

  {$ifdef iVCL} iPlotToolBar,  iPlotLegend,  iPlotAxis,  iPlotChannelCustom,  iPlotDataView,  iPlotDataCursor,  iPlotLimit,  iPlotLabel,  iPlotAnnotation,  iPlotTable;{$endif}
  {$ifdef iCLX}QiPlotToolBar, QiPlotLegend, QiPlotAxis, QiPlotChannelCustom, QiPlotDataView, QiPlotDataCursor, QiPlotLimit, QiPlotLabel, QiPlotAnnotation, QiPlotTable;{$endif}

type
  TiColorCountObject = class(TObject)
  public
    Color : TColor;
    Count : Integer;
  end;

  //----------------------------------------------------------------------------
  TiPlotObjectManagerCustom = class(TObject)
  private
    FList      : TStringList;
    FOwner     : TWinControl;
    FOnChange  : TNotifyEvent;
    FOnRemove  : TNotifyEvent;
    FOnInsert  : TNotifyEvent;
    FOnRename  : TNotifyEvent;
  protected                                        
    function  GetCount: Integer;

    function  GetObject(Index: Integer): TiPlotObject;
    function  GetItem  (Index: Integer): TiPlotObject;
    function  CreateObject : TiPlotObject; virtual; abstract;
    function  GetName : String;            virtual; abstract;
    procedure DoChange;
                                                                   
    procedure RemovingObject(AObject : TiPlotObject); virtual;

    property  Owner : TWinControl read FOwner;
  public
    constructor Create(AOwner: TWinControl; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); virtual;
    destructor  Destroy; override;

    procedure InsertObject(AObject: TiPlotObject);

    procedure NotificationRemove  (Sender : TObject); virtual;
    procedure NotificationInsert  (Sender : TObject); virtual; abstract;
    procedure NotificationRename  (Sender : TObject); virtual;
    procedure NotificationSetFocus(Sender : TObject); virtual;

    function  DoWriteToStream : Boolean;
    procedure WriteToStream (Writer: TWriter);
    procedure ReadFromStream(Reader: TReader);

    procedure Clear;                                 virtual;
    procedure Delete(Index: Integer);                virtual;

    function  GetNextName : String;

    function  GetIndex       (AObject : TiPlotObject): Integer;
    function  GetObjectByName(Value   : String      ): TiPlotObject;
    function  GetIndexByName (Value   : String      ): Integer;

    property  Items[Index: Integer]: TiPlotObject read GetItem;

    property Count     : Integer      read GetCount;
    property OnChange  : TNotifyEvent read FOnChange  write FOnChange;
    property OnInsert  : TNotifyEvent read FOnInsert  write FOnInsert;
    property OnRemove  : TNotifyEvent read FOnRemove  write FOnRemove;
    property OnRename  : TNotifyEvent read FOnRename  write FOnRename;
  end;
  //----------------------------------------------------------------------------
  TiPlotObjectOwnedManager  = class(TiPlotObjectManagerCustom)
  public
    procedure Clear;                                override;
//    procedure Delete            (Index  : Integer); override;
    procedure NotificationRemove(Sender : TObject); override;
  end;
  //----------------------------------------------------------------------------
  TiPlotToolBarManager = class(TiPlotObjectOwnedManager)
  private
    function  GetItem(Index: Integer): TiPlotToolBar;
  protected
    function  CreateObject : TiPlotObject; override;
    function  GetName : String;            override;
  public
    procedure NotificationInsert(Sender : TObject); override;
    property  Items[Index: Integer]: TiPlotToolBar read GetItem;
  end;
  //----------------------------------------------------------------------------
  TiPlotLegendManager = class(TiPlotObjectOwnedManager)
  private
    function  GetItem(Index: Integer): TiPlotLegend;
  protected
    function  CreateObject : TiPlotObject;          override;
    function  GetName : String;                     override;
  public
    procedure NotificationInsert(Sender : TObject); override;
    property  Items[Index: Integer]: TiPlotLegend read GetItem;
  end;
  //----------------------------------------------------------------------------
  TiPlotXAxisManager = class(TiPlotObjectOwnedManager)
  private
    function  GetItem(Index: Integer): TiPlotXAxis;
  protected
    function  CreateObject : TiPlotObject; override;
    function  GetName : String;            override;
  public
    procedure NotificationInsert(Sender : TObject); override;
    property  Items[Index: Integer]: TiPlotXAxis read GetItem;
  end;
  //----------------------------------------------------------------------------
  TiPlotYAxisManager = class(TiPlotObjectOwnedManager)
  private
    function  GetItem(Index: Integer): TiPlotYAxis;
  protected
    function  CreateObject : TiPlotObject; override;
    function  GetName : String;            override;
  public
    procedure NotificationInsert(Sender : TObject); override;
    property  Items[Index: Integer]: TiPlotYAxis read GetItem;
  end;
  //----------------------------------------------------------------------------
  TiPlotChannelManager = class(TiPlotObjectOwnedManager)
  private
    FXAxisManager : TiPlotXAxisManager;
    FYAxisManager : TiPlotYAxisManager;
    FChannelClass : TiPlotChannelCustomClass;
    function  GetItem(Index: Integer): TiPlotChannelCustom;
  protected
    function  GetName : String;            override;
  public
    property  XAxisManager : TiPlotXAxisManager read FXAxisManager write FXAxisManager;
    property  YAxisManager : TiPlotYAxisManager read FYAxisManager write FYAxisManager;

    function  CreateObject : TiPlotObject; override;
    function  GetNextChannelColor: TColor;
    procedure NotificationInsert(Sender : TObject); override;
    procedure NotificationRemove(Sender : TObject); override;
    property  Items[Index: Integer]: TiPlotChannelCustom      read GetItem;
    property  ChannelClass         : TiPlotChannelCustomClass read FChannelClass  write FChannelClass;
  end;
  //----------------------------------------------------------------------------
  TiPlotDataViewManager = class(TiPlotObjectOwnedManager)
  private
    FXAxisManager : TiPlotXAxisManager;
    FYAxisManager : TiPlotYAxisManager;
    function  GetItem(Index: Integer): TiPlotDataView;
  protected
    function  CreateObject : TiPlotObject; override;
    function  GetName : String;            override;
  public
    property  XAxisManager : TiPlotXAxisManager read FXAxisManager write FXAxisManager;
    property  YAxisManager : TiPlotYAxisManager read FYAxisManager write FYAxisManager;

    procedure NotificationInsert(Sender : TObject); override;
    procedure NotificationRemove(Sender : TObject); override;
    property  Items[Index: Integer]: TiPlotDataView read GetItem;
  end;
  //----------------------------------------------------------------------------
  TiPlotDataCursorManager = class(TiPlotObjectOwnedManager)
  private
    FChannelManager  : TiPlotChannelManager;
    FDataViewManager : TiPlotDataViewManager;
    function  GetItem(Index: Integer): TiPlotDataCursor;
  protected
    function  CreateObject : TiPlotObject; override;
    function  GetName : String;            override;
  public
    property  ChannelManager  : TiPlotChannelManager  read FChannelManager  write FChannelManager;
    property  DataViewManager : TiPlotDataViewManager read FDataViewManager write FDataViewManager;
    procedure NotificationInsert(Sender : TObject); override;
    procedure NotificationRemove(Sender : TObject); override;
    property  Items[Index: Integer]: TiPlotDataCursor read GetItem;
  end;
  //----------------------------------------------------------------------------
  TiPlotLimitManager = class(TiPlotObjectOwnedManager)
  private
    FXAxisManager : TiPlotXAxisManager;
    FYAxisManager : TiPlotYAxisManager;
    function  GetItem(Index: Integer): TiPlotLimit;
  protected
    function  CreateObject : TiPlotObject; override;
    function  GetName : String;            override;
  public
    property  XAxisManager : TiPlotXAxisManager read FXAxisManager write FXAxisManager;
    property  YAxisManager : TiPlotYAxisManager read FYAxisManager write FYAxisManager;
    procedure NotificationInsert(Sender : TObject); override;
    procedure NotificationRemove(Sender : TObject); override;
    property  Items[Index: Integer]: TiPlotLimit read GetItem;
  end;
  //----------------------------------------------------------------------------
  TiPlotLabelManager = class(TiPlotObjectOwnedManager)
  private
    function  GetItem(Index: Integer): TiPlotLabel;
  protected
    function  CreateObject : TiPlotObject; override;
    function  GetName : String;            override;
  public
    procedure NotificationInsert(Sender : TObject); override;
    property  Items[Index: Integer]: TiPlotLabel read GetItem;
  end;
  //----------------------------------------------------------------------------
  TiPlotTableManager = class(TiPlotObjectOwnedManager)
  private
    function  GetItem(Index: Integer): TiPlotTable;
  protected
    function  CreateObject : TiPlotObject; override;
    function  GetName : String;            override;
  public
    procedure NotificationInsert(Sender : TObject); override;
    property  Items[Index: Integer]: TiPlotTable read GetItem;
  end;
  //----------------------------------------------------------------------------
  TiPlotAnnotationManager = class(TiPlotObjectOwnedManager)
  private
    function  GetItem(Index: Integer): TiPlotAnnotation;
  protected
    function  CreateObject : TiPlotObject; override;
    function  GetName : String;            override;
  public
    procedure NotificationInsert(Sender : TObject); override;
    property  Items[Index: Integer]: TiPlotAnnotation read GetItem;
  end;
  //----------------------------------------------------------------------------
  TiPlotObjectManager = class(TiPlotObjectManagerCustom)
  protected
    function  CreateObject : TiPlotObject; override;
    function  GetName : String;            override;
  public
    procedure NotificationInsert(Sender : TObject); override;

    procedure ShutDownSetup;

    procedure ClearAllUserSelections;
    procedure SetShiftState(Value: TShiftState);

    procedure MouseDownFocusObjects (Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer;                          PopupMenu: TPopupMenu);
    procedure MouseMoveFocusObjects (HintData: TiHintData; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; DblClickActive: Boolean                       );
    procedure MouseUpFocusObjects   (Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; DblClickActive: Boolean; PopupMenu: TPopupMenu);
    function  MouseWheelFocusObjects(WheelDelta: Integer;  Shift: TShiftState; const MousePos: TPoint): Boolean;
    procedure KeyDownFocusObjects  (var CharCode: Word; Shift: TShiftState; PopupMenu : TPopupMenu);
  end;

implementation

type
  TWriterAccess          = class(TWriter         ) end;
  TReaderAccess          = class(TReader         ) end;
  TPersistentAccess      = class(TPersistent     ) end;
  TiPlotObjectAccess     = class(TiPlotObject    )end;
  TiPlotDataCursorAccess = class(TiPlotDataCursor)end;
//*************************************************************************************************************************************
{TiPlotObjectManager}
//*************************************************************************************************************************************
constructor TiPlotObjectManagerCustom.Create(AOwner: TWinControl; AOnChange, AOnInsert, AOnRemove, AOnRename : TNotifyEvent);
begin
  if not Assigned(AOwner)     then raise Exception.Create('Owner must be Assigned');
  if not Assigned(AOnChange)  then raise Exception.Create('OnChange event handler can not be null');
  if not Assigned(AOnInsert)  then raise Exception.Create('OnInsert event handler can not be null');
  if not Assigned(AOnRemove)  then raise Exception.Create('OnRemove event handler can not be null');
  if not Assigned(AOnRename)  then raise Exception.Create('AOnRename event handler can not be null');

  FList := TStringList.Create;
  FList.Sorted := False;

  FOwner     := AOwner;
  FOnChange  := AOnChange;
  FOnInsert  := AOnInsert;
  FOnRemove  := AOnRemove;
  FOnRename  := AOnRename;

  FOnInsert(Self);
end;
//*************************************************************************************************************************************
destructor TiPlotObjectManagerCustom.Destroy;
begin
  Clear;
  FOnRemove(Self); //Must be after clear
  FList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
function TiPlotObjectManagerCustom.GetNextName: String;
var
  x            : Integer;
  HighestFound : Integer;
  BaseName     : String;
  SearchName   : String;
  iPlotObject  : TiPlotObject;
  PostBase     : String;
begin
  HighestFound := 0;
  BaseName     := GetName;
  Result       := BaseName;

  for x := 0 to FList.Count-1 do
    begin
      iPlotObject := FList.Objects[x] as TiPlotObject;
      SearchName := iPlotObject.Name;
      if UpperCase(Copy(SearchName, 1, Length(BaseName))) = UpperCase(BaseName) then
        begin
          PostBase := Copy(SearchName, Length(BaseName)+1, Length(SearchName) - Length(BaseName));
          try
            if StrToInt(PostBase) > HighestFound then HighestFound := StrToInt(PostBase);
          except
            on Exception do;
          end;
        end;
    end;
  Result := BaseName + ' ' + IntToStr(HighestFound + 1);
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManagerCustom.InsertObject(AObject: TiPlotObject);
begin
  if FList.IndexOfObject(AObject) = -1 then FList.AddObject('', AObject)
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManagerCustom.NotificationRemove(Sender: TObject);
var
  x : Integer;
begin
  for x := Count-1 downto 0 do
    if (FList.Objects[x] = Sender) then
      begin
        FList.Delete(x);
        RemovingObject(Sender as TiPlotObject);
        DoChange;
        Break;
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManagerCustom.NotificationRename(Sender: TObject);
var
  x : Integer;
begin
  for x := 0 to Count-1 do
    TiPlotObjectAccess((FList.Objects[x] as TiPlotObject)).NotificationRename(Sender);
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManagerCustom.NotificationSetFocus(Sender: TObject);
var
  x : Integer;
begin
  for x := 0 to Count-1 do
    TiPlotObjectAccess((FList.Objects[x] as TiPlotObject)).NotificationSetFocus(Sender);
end;
//*************************************************************************************************************************************
procedure TiPlotObjectManagerCustom.Clear;
begin
{  while FList.Count <> 0 do
    begin
      TiPlotObjectAccess(Items[Count-1]).OnLayoutChange := nil;
      TiPlotObjectAccess(Items[Count-1]).OnChange       := nil;
      Delete(Count-1);
    end;
 DoChange;}
end;
//*************************************************************************************************************************************
procedure TiPlotObjectManagerCustom.Delete(Index : Integer);
begin
  FList.Delete(Index);
end;
//*************************************************************************************************************************************
procedure TiPlotObjectManagerCustom.DoChange;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManagerCustom.RemovingObject(AObject: TiPlotObject);
begin

end;
//*************************************************************************************************************************************
function TiPlotObjectManagerCustom.GetCount: Integer;
begin
  Result := FList.Count;  
end;
//*************************************************************************************************************************************
function TiPlotObjectManagerCustom.GetObject(Index : Integer): TiPlotObject;
begin
  Result := FList.Objects[Index] as TiPlotObject;
end;
//****************************************************************************************************************************************************
function TiPlotObjectManagerCustom.GetItem(Index: Integer): TiPlotObject;
begin
  Result := GetObject(Index) as TiPlotObject;
end;
//*************************************************************************************************************************************
function TiPlotObjectManagerCustom.DoWriteToStream: Boolean;
begin
  Result := Count <> 0;
end;
//*************************************************************************************************************************************
procedure TiPlotObjectManagerCustom.WriteToStream(Writer: TWriter);
var
  x : Integer;
begin
  Writer.RootAncestor := Owner;
  TWriterAccess(Writer).WriteValue(vaCollection);
  for x := 0 to Count - 1 do
  begin
    Writer.WriteListBegin;
    WriterWriteProperties(Writer, GetObject(x));
    Writer.WriteListEnd;
  end;
  Writer.WriteListEnd;
end;
//*************************************************************************************************************************************
procedure TiPlotObjectManagerCustom.ReadFromStream(Reader: TReader);
var
  Item : TiPlotObject;
begin
  Clear;
  if not Reader.EndOfList then Clear;
  if TReaderAccess(Reader).ReadValue <> vaCollection then exit;
  while not Reader.EndOfList do
  begin
    Item := CreateObject;
    Reader.ReadListBegin;
    while not Reader.EndOfList do TReaderAccess(Reader).ReadProperty(Item);
    Reader.ReadListEnd;
    TiPlotObjectAccess(Item).Loaded;
  end;
  Reader.ReadListEnd;
end;
//****************************************************************************************************************************************************
function TiPlotObjectManagerCustom.GetIndex(AObject: TiPlotObject): Integer;
begin
  Result := FList.IndexOfObject(AObject);
end;
//****************************************************************************************************************************************************
function TiPlotObjectManagerCustom.GetObjectByName(Value: String): TiPlotObject;
var
  x           : Integer;
  iPlotObject : TiPlotObject;
begin
  Result := nil;
  for x := 0 to FList.Count-1 do
    begin
      iPlotObject := FList.Objects[x] as TiPlotObject;
      if UpperCase(iPlotObject.Name) = UpperCase(Value) then
        begin
          Result := iPlotObject;
          Exit;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotObjectManagerCustom.GetIndexByName(Value: String): Integer;
var
  x : Integer;
begin
  Result := -1;
  for x := 0 to Count-1 do
    if UpperCase(Items[x].Name) = UpperCase(Value) then
      begin
        Result := x;
        Exit;
      end;
end;
//*************************************************************************************************************************************
{ TiPlotObjectOwnedManager }
//****************************************************************************************************************************************************
procedure TiPlotObjectOwnedManager.Clear;
var
  AList : TStringList;
begin
  AList := TStringList.Create;
  try
    AList.Assign(FList);

    while AList.Count <> 0 do
      begin
        AList.Objects[0].Free;
        AList.Delete(0);
      end;
  finally          
    AList.Free;
  end;
end;
{//****************************************************************************************************************************************************
procedure TiPlotObjectOwnedManager.Delete(Index: Integer);
var
  AObject : TObject;
begin
  AObject := FList.Objects[Index];
  //inherited Delete(Index);
  AObject.Free;
  DoChange;
end;}
//****************************************************************************************************************************************************
procedure TiPlotObjectOwnedManager.NotificationRemove(Sender: TObject);
var
  x : Integer;
begin
  if Sender = Self then exit;

  for x := 0 to Count-1 do
    if FList.Objects[x] <> Sender then
      TiPlotObjectAccess((FList.Objects[x] as TiPlotObject)).NotificationRemove(Sender);

  inherited NotificationRemove(Sender);
end;
//****************************************************************************************************************************************************
{TiPlotToolBarManager}
//****************************************************************************************************************************************************
function TiPlotToolBarManager.CreateObject : TiPlotObject;
begin
  Result := TiPlotToolBar.Create(FOwner, FOnChange, FOnInsert, FOnRemove, FOnRename);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBarManager.NotificationInsert(Sender: TObject);
var
  iPlotToolBar : TiPlotToolBar;
begin
  if Sender is TiPlotToolBar then
    begin
      iPlotToolBar := Sender as TiPlotToolBar;
      InsertObject(iPlotToolBar);
      if iPlotToolBar.Name = '' then
        begin
          iPlotToolBar.Name := GetNextName;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotToolBarManager.GetItem(Index: Integer): TiPlotToolBar;
begin
  Result := GetObject(Index) as TiPlotToolBar;
end;
//****************************************************************************************************************************************************
function TiPlotToolBarManager.GetName: String;
begin
  Result := 'Toolbar';
end;
//****************************************************************************************************************************************************
{TiPlotLegendManager}
//****************************************************************************************************************************************************
function TiPlotLegendManager.CreateObject : TiPlotObject;
begin
  Result := TiPlotLegend.Create(FOwner, FOnChange, FOnInsert, FOnRemove, FOnRename);
end;
//****************************************************************************************************************************************************
procedure TiPlotLegendManager.NotificationInsert(Sender: TObject);
var
  iPlotLegend : TiPlotLegend;
begin
  if Sender is TiPlotLegend then
    begin
      iPlotLegend := Sender as TiPlotLegend;
      InsertObject(iPlotLegend);
      if iPlotLegend.Name = '' then
        begin
          iPlotLegend.Name := GetNextName;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotLegendManager.GetItem(Index: Integer): TiPlotLegend;
begin
  Result := GetObject(Index) as TiPlotLegend;
end;
//****************************************************************************************************************************************************
function TiPlotLegendManager.GetName: String;
begin
  Result := 'Legend';
end;
//****************************************************************************************************************************************************
{TiPlotXAxisManager}
//****************************************************************************************************************************************************
function TiPlotXAxisManager.CreateObject : TiPlotObject;
begin
  Result := TiPlotXAxis.Create(FOwner, FOnChange, FOnInsert, FOnRemove, FOnRename);
end;
//****************************************************************************************************************************************************
procedure TiPlotXAxisManager.NotificationInsert(Sender: TObject);
var
  iPlotXAxis : TiPlotXAxis;
begin
  if Sender is TiPlotXAxis then
    begin
      iPlotXAxis := Sender as TiPlotXAxis;
      InsertObject(iPlotXAxis);
      if iPlotXAxis.Name = '' then
        begin
          iPlotXAxis.Name  := GetNextName;
          iPlotXAxis.Title := iPlotXAxis.Name;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotXAxisManager.GetItem(Index: Integer): TiPlotXAxis;
begin
  Result := GetObject(Index) as TiPlotXAxis;
end;
//****************************************************************************************************************************************************
function TiPlotXAxisManager.GetName: String;
begin
  Result := 'X-Axis';
end;
//****************************************************************************************************************************************************
{ TiPlotYAxisManager }
//****************************************************************************************************************************************************
function TiPlotYAxisManager.CreateObject : TiPlotObject;
begin
  Result := TiPlotYAxis.Create(FOwner, FOnChange, FOnInsert, FOnRemove, FOnRename);
end;
//****************************************************************************************************************************************************
procedure TiPlotYAxisManager.NotificationInsert(Sender: TObject);
var
  iPlotYAxis : TiPlotYAxis;
begin
  if Sender is TiPlotYAxis then
    begin
      iPlotYAxis := Sender as TiPlotYAxis;
      InsertObject(iPlotYAxis);
      if iPlotYAxis.Name = '' then
        begin
          iPlotYAxis.Name  := GetNextName;
          iPlotYAxis.Title := iPlotYAxis.Name;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotYAxisManager.GetItem(Index: Integer): TiPlotYAxis;
begin
  Result := GetObject(Index) as TiPlotYAxis;
end;
//****************************************************************************************************************************************************
function TiPlotYAxisManager.GetName: String;
begin
  Result := 'Y-Axis';
end;
//****************************************************************************************************************************************************
{TiPlotChannelManager}
//****************************************************************************************************************************************************
function TiPlotChannelManager.CreateObject : TiPlotObject;
begin
  Result := FChannelClass.Create(FOwner, FOnChange, FOnInsert, FOnRemove, FOnRename);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelManager.NotificationInsert(Sender: TObject);
var
  iPlotChannel : TiPlotChannelCustom;
begin
  if Sender is TiPlotChannelCustom then
    begin
      iPlotChannel := Sender as TiPlotChannelCustom;
      InsertObject(iPlotChannel);
      if iPlotChannel.Name = '' then
        begin
          iPlotChannel.Name      := GetNextName;
          iPlotChannel.TitleText := iPlotChannel.Name;
          iPlotChannel.Color     := GetNextChannelColor;

          if Assigned(FXAxisManager) then if FXAxisManager.Count <> 0 then iPlotChannel.XAxisName := FXAxisManager.Items[0].Name;
          if Assigned(FYAxisManager) then if FYAxisManager.Count <> 0 then iPlotChannel.YAxisName := FYAxisManager.Items[0].Name;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelManager.NotificationRemove(Sender: TObject);
begin
  inherited;
  if Sender = FXAxisManager then FXAxisManager := nil;
  if Sender = FYAxisManager then FYAxisManager := nil;
end;
//****************************************************************************************************************************************************
function TiPlotChannelManager.GetItem(Index: Integer): TiPlotChannelCustom;
begin
  Result := GetObject(Index) as TiPlotChannelCustom;
end;
//****************************************************************************************************************************************************
function TiPlotChannelManager.GetName: String;
begin
  Result := 'Channel';
end;
//****************************************************************************************************************************************************
function TiPlotChannelManager.GetNextChannelColor: TColor;
var
  ColorCountList   : TStringList;
  iColorCount      : TiColorCountObject;
  x, y             : Integer;
  iChannelObject   : TiPlotChannelCustom;
  LowestCount      : Integer;
begin
  Result := clRed;

  if Count > 1 then
    begin
      ColorCountList := TStringList.Create;
      ColorCountList.Sorted := False;

      iColorCount := TiColorCountObject.Create; iColorCount.Color := clRed;    ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := clYellow; ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := clBlue;   ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := clFuchsia;ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := clAqua;   ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := clLime;   ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := clWhite;  ColorCountList.AddObject('', iColorCount);

      iColorCount := TiColorCountObject.Create; iColorCount.Color := $000080;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $008000;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $008080;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $800000;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $800080;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $808000;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $808080;  ColorCountList.AddObject('', iColorCount);

      iColorCount := TiColorCountObject.Create; iColorCount.Color := $0000C0;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $00C000;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $00C0C0;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $C00000;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $C000C0;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $C0C000;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $C0C0C0;  ColorCountList.AddObject('', iColorCount);

      iColorCount := TiColorCountObject.Create; iColorCount.Color := $0080FF;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $8000FF;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $8080FF;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $FF0080;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $FF8000;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $FF8080;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $00FF80;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $80FF00;  ColorCountList.AddObject('', iColorCount);
      iColorCount := TiColorCountObject.Create; iColorCount.Color := $80FF80;  ColorCountList.AddObject('', iColorCount);

      for x := 0 to Count-1 do
        begin
          iChannelObject := Items[x];
          for y := 0 to ColorCountList.Count -1 do
            begin
              iColorCount := (ColorCountList.Objects[y] as TiColorCountObject);
              if iChannelObject.Color = iColorCount.Color then iColorCount.Count := iColorCount.Count + 1;
            end;
        end;

      LowestCount := Maxint;
      for x := 0 to ColorCountList.Count -1 do
        begin
          iColorCount := (ColorCountList.Objects[x] as TiColorCountObject);
          if iColorCount.Count < LowestCount then LowestCount := iColorCount.Count;
        end;

      for x := 0 to ColorCountList.Count -1 do
        begin
          iColorCount := (ColorCountList.Objects[x] as TiColorCountObject);
          if iColorCount.Count = LowestCount then
            begin
              Result := iColorCount.Color;
              Break;
            end;
        end;

      while ColorCountList.Count <> 0 do
        begin
          ColorCountList.Objects[0].Free;
          ColorCountList.Delete(0);
        end;
      ColorCountList.Free;
  end;
end;
//****************************************************************************************************************************************************
{ TiPlotDataViewManager }
//****************************************************************************************************************************************************
function TiPlotDataViewManager.CreateObject : TiPlotObject;
begin
  Result := TiPlotDataView.Create(FOwner, FOnChange, FOnInsert, FOnRemove, FOnRename);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataViewManager.NotificationInsert(Sender: TObject);
var
  iPlotDataView : TiPlotDataView;
begin
  if Sender is TiPlotDataView then
    begin
      iPlotDataView := Sender as TiPlotDataView;
      InsertObject(iPlotDataView);
      if iPlotDataView.Name = '' then
        begin
          iPlotDataView.Name := GetNextName;

          if Assigned(FXAxisManager) then if FXAxisManager.Count <> 0 then iPlotDataView.GridXAxisName := FXAxisManager.Items[0].Name;
          if Assigned(FYAxisManager) then if FYAxisManager.Count <> 0 then iPlotDataView.GridYAxisName := FYAxisManager.Items[0].Name;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataViewManager.NotificationRemove(Sender: TObject);
begin
  inherited;
  if Sender = FXAxisManager then FXAxisManager := nil;
  if Sender = FYAxisManager then FYAxisManager := nil;
end;
//****************************************************************************************************************************************************
function TiPlotDataViewManager.GetItem(Index: Integer): TiPlotDataView;
begin
  Result := GetObject(Index) as TiPlotDataView;
end;
//****************************************************************************************************************************************************
function TiPlotDataViewManager.GetName: String;
begin
  Result := 'Data View';
end;
//****************************************************************************************************************************************************
{ TiPlotCursorManager }
//****************************************************************************************************************************************************
function TiPlotDataCursorManager.CreateObject: TiPlotObject;
begin
  Result := TiPlotDataCursor.Create(FOwner, FOnChange, FOnInsert, FOnRemove, FOnRename);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursorManager.NotificationInsert(Sender: TObject);
var
  iPlotDataCursor : TiPlotDataCursor;
begin
  if Sender is TiPlotDataCursor then
    begin
      iPlotDataCursor := Sender as TiPlotDataCursor;
      InsertObject(iPlotDataCursor);
      if iPlotDataCursor.Name = '' then
        begin
          iPlotDataCursor.Name  := GetNextName;
          if Assigned(FDataViewManager) then if FDataViewManager.Count <> 0 then TiPlotDataCursorAccess(iPlotDataCursor).DataView := FDataViewManager.Items[0];
          if Assigned(FChannelManager ) then if FChannelManager.Count  <> 0 then iPlotDataCursor.ChannelName := FChannelManager.Items[0].Name;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursorManager.NotificationRemove(Sender: TObject);
begin
  inherited;
  if Sender = FChannelManager then FChannelManager := nil;
end;
//****************************************************************************************************************************************************
function TiPlotDataCursorManager.GetItem(Index: Integer): TiPlotDataCursor;
begin
  Result := GetObject(Index) as TiPlotDataCursor;
end;
//****************************************************************************************************************************************************
function TiPlotDataCursorManager.GetName: String;
begin
  Result := 'Cursor';
end;
//****************************************************************************************************************************************************
{ TiPlotLimitManager }
//****************************************************************************************************************************************************
function TiPlotLimitManager.CreateObject: TiPlotObject;
begin
  Result := TiPlotLimit.Create(FOwner, FOnChange, FOnInsert, FOnRemove, FOnRename);
end;
//****************************************************************************************************************************************************
function TiPlotLimitManager.GetItem(Index: Integer): TiPlotLimit;
begin
  Result := GetObject(Index) as TiPlotLimit;
end;
//****************************************************************************************************************************************************
function TiPlotLimitManager.GetName: String;
begin
  Result := 'Limit';
end;
//****************************************************************************************************************************************************
procedure TiPlotLimitManager.NotificationInsert(Sender: TObject);
var
  iPlotLimit : TiPlotLimit;
begin
  if Sender is TiPlotLimit then
    begin
      iPlotLimit := Sender as TiPlotLimit;
      InsertObject(iPlotLimit);
      if iPlotLimit.Name = '' then
        begin
          iPlotLimit.Name := GetNextName;

          if Assigned(FXAxisManager) then if FXAxisManager.Count <> 0 then iPlotLimit.XAxisName := FXAxisManager.Items[0].Name;
          if Assigned(FYAxisManager) then if FYAxisManager.Count <> 0 then iPlotLimit.YAxisName := FYAxisManager.Items[0].Name;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimitManager.NotificationRemove(Sender: TObject);
begin
  inherited NotificationRemove(Sender);
  if Sender = FXAxisManager then FXAxisManager := nil;
  if Sender = FYAxisManager then FYAxisManager := nil;
end;
//****************************************************************************************************************************************************
{ TiPlotLabelManager }
//****************************************************************************************************************************************************
function TiPlotLabelManager.CreateObject: TiPlotObject;
begin
  Result := TiPlotLabel.Create(FOwner, FOnChange, FOnInsert, FOnRemove, FOnRename);
end;
//****************************************************************************************************************************************************
function TiPlotLabelManager.GetItem(Index: Integer): TiPlotLabel;
begin
  Result := GetObject(Index) as TiPlotLabel;
end;
//****************************************************************************************************************************************************
function TiPlotLabelManager.GetName: String;
begin
  Result := 'Label';
end;
//****************************************************************************************************************************************************
procedure TiPlotLabelManager.NotificationInsert(Sender: TObject);
var
  iPlotLabel : TiPlotLabel;
begin
  if Sender is TiPlotLabel then
    begin
      iPlotLabel := Sender as TiPlotLabel;
      InsertObject(iPlotLabel);
      if iPlotLabel.Name = '' then
        begin
          iPlotLabel.Name    := GetNextName;
          iPlotLabel.Caption := iPlotLabel.Name;
        end;
    end;
end;
//****************************************************************************************************************************************************
{ TiPlotAnnotationManager }
function TiPlotAnnotationManager.CreateObject: TiPlotObject;
begin
  Result := TiPlotAnnotation.Create(FOwner, FOnChange, FOnInsert, FOnRemove, FOnRename);
end;
//****************************************************************************************************************************************************
function TiPlotAnnotationManager.GetItem(Index: Integer): TiPlotAnnotation;
begin
  Result := GetObject(Index) as TiPlotAnnotation;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotationManager.GetName: String;
begin
  Result := 'Annotation';
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotationManager.NotificationInsert(Sender: TObject);
begin
  if Sender is TiPlotAnnotation then
    begin
      InsertObject(TiPlotObject(Sender));
    end;
end;
//****************************************************************************************************************************************************
{ TiPlotTableManager }
//****************************************************************************************************************************************************
function TiPlotTableManager.CreateObject: TiPlotObject;
begin
  Result := TiPlotTable.Create(FOwner, FOnChange, FOnInsert, FOnRemove, FOnRename);
end;
//****************************************************************************************************************************************************
function TiPlotTableManager.GetItem(Index: Integer): TiPlotTable;
begin
  Result := GetObject(Index) as TiPlotTable;
end;
//****************************************************************************************************************************************************
function TiPlotTableManager.GetName: String;
begin
  Result := 'Table';
end;
//****************************************************************************************************************************************************
procedure TiPlotTableManager.NotificationInsert(Sender: TObject);
var
  iPlotTable : TiPlotTable;
begin
  if Sender is TiPlotTable then
    begin
      iPlottable := Sender as TiPlotTable;
      InsertObject(iPlotTable);
      if iPlotTable.Name = '' then
        begin
          iPlotTable.Name    := GetNextName;
        end;
    end;
end;
//****************************************************************************************************************************************************
{ TiPlotViewManager }
//****************************************************************************************************************************************************
function TiPlotObjectManager.CreateObject: TiPlotObject;
begin
  raise Exception.Create('Object Manager does not support creation of objects');
end;
//****************************************************************************************************************************************************
function TiPlotObjectManager.GetName: String;
begin
  Result := 'n/a';
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManager.NotificationInsert(Sender: TObject);
begin
  if Sender is TiPlotObject then
    begin
      InsertObject(Sender as TiPlotObject);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManager.ClearAllUserSelections;
var
  x : Integer;
begin
  for x := 0 to Count-1 do
    TiPlotObjectAccess(Items[x]).SetUserSelected(False);
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManager.SetShiftState(Value: TShiftState);
var
  x : Integer;
begin
  for x := 0 to Count-1 do
    TiPlotObjectAccess(Items[x]).SetShiftState(Value);
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManager.MouseDownFocusObjects(Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; PopupMenu : TPopupMenu);
var
  i : Integer;
begin
  for i := 0 to Count-1 do
    if TiPlotObjectAccess(Items[i]).UserSelected
      then TiPlotObjectAccess(Items[i]).iMouseDown(Button, Shift, X, Y, ScreenX, ScreenY, PopUpMenu);
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManager.MouseMoveFocusObjects(HintData: TiHintData; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; DblClickActive: Boolean);
var
  i : Integer;
begin
  for i := 0 to Count-1 do
    if TiPlotObjectAccess(Items[i]).UserSelected then
      TiPlotObjectAccess(Items[i]).iMouseMove(HintData, Shift, X, Y, ScreenX, ScreenY, DblClickActive);
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManager.MouseUpFocusObjects(Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; DblClickActive: Boolean; PopupMenu: TPopupMenu);
var
  i : Integer;
begin
  for i := 0 to Count-1 do
    if TiPlotObjectAccess(Items[i]).UserSelected then
      TiPlotObjectAccess(Items[i]).iMouseUp(Button, Shift, X, Y, ScreenX, ScreenY, DblClickActive, PopupMenu);
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManager.KeyDownFocusObjects(var CharCode: Word; Shift: TShiftState; PopupMenu : TPopupMenu);
var
  i : Integer;
begin
  for i := 0 to Count-1 do
    if TiPlotObjectAccess(Items[i]).UserSelected then
      TiPlotObjectAccess(Items[i]).iKeyDown(CharCode, Shift, PopupMenu);
end;
//****************************************************************************************************************************************************
function TiPlotObjectManager.MouseWheelFocusObjects(WheelDelta: Integer; Shift: TShiftState; const MousePos: TPoint): Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to Count-1 do
    if TiPlotObjectAccess(Items[i]).UserSelected then
      if TiPlotObjectAccess(Items[i]).iMouseWheel(WheelDelta, Shift, MousePos) then Result := True
end;
//****************************************************************************************************************************************************
procedure TiPlotObjectManager.ShutDownSetup;
var
  i : Integer;
begin
  for i := 0 to Count-1 do
    begin
      TiPlotObjectAccess(Items[i]).OnRemove       := nil;
      TiPlotObjectAccess(Items[i]).OnLayoutChange := nil;
      TiPlotObjectAccess(Items[i]).OnChange       := nil;
    end;
end;
//****************************************************************************************************************************************************
end.


