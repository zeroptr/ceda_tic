{*******************************************************}
{                                                       }
{       TiPlotMasterManager                             }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iCLX}unit QiPlotMasterManager;{$endif}
{$ifdef iVCL}unit  iPlotMasterManager;{$endif}

interface

uses
{$I iIncludeUses.inc}
{$IFDEF iVCL} Menus,  Printers,  iTypes,  iGPFunctions,  iComponentEditorButtonPanel,  iEditorBasicComponents,{$endif}
{$IFDEF iCLX}QMenus, QPrinters, QiTypes, QiGPFunctions, QiComponentEditorButtonPanel, QiEditorBasicComponents,{$endif}

{$ifdef iVCL} iPlotManagers,  iPlotLayoutManager,  iPlotObjects,  iPlotChannelCustom,  iPlotDataCursor,  iPlotTranslation,  iPlotAnnotation;{$endif}
{$ifdef iCLX}QiPlotManagers, QiPlotLayoutManager, QiPlotObjects, QiPlotChannelCustom, QiPlotDataCursor, QiPlotTranslation, QiPlotAnnotation;{$endif}

type
  TWriterAccess = class(TWriter);
  TReaderAccess = class(TReader);

  //----------------------------------------------------------------------------
  TiPlotMasterManager = class(TObject)
  private
    FOwner                                   : TWinControl;
    FUserCanEditObjects                      : Boolean;
    FToolBarManager                          : TiPlotToolBarManager;
    FLegendManager                           : TiPlotLegendManager;
    FTableManager                            : TiPlotTableManager;
    FXAxisManager                            : TiPlotXAxisManager;
    FYAxisManager                            : TiPlotYAxisManager;
    FChannelManager                          : TiPlotChannelManager;
    FDataViewManager                         : TiPlotDataViewManager;
    FDataCursorManager                       : TiPlotDataCursorManager;
    FLimitManager                            : TiPlotLimitManager;
    FLabelManager                            : TiPlotLabelManager;
    FAnnotationManager                       : TiPlotAnnotationManager;
    FTranslationManager                      : TiPlotTranslationManager;
    FLayoutManager                           : TiPlotLayoutManager;
    FPlotObjectManager                       : TiPlotObjectManager;

    FOnInvalidateNow                         : TNotifyEvent;
    FOnChange                                : TNotifyEvent;
    FOnInsert                                : TNotifyEvent;
    FOnRemove                                : TNotifyEvent;

    FChannelClass                            : TiPlotChannelCustomClass;

    FMainPageControlIndex                    : Integer;
    FControlPageControlIndex                 : Integer;
    FChannelPageControlIndex                 : Integer;
    FXAxisPageControlIndex                   : Integer;
    FXAxisLabelsPageControlIndex             : Integer;
    FYAxisPageControlIndex                   : Integer;
    FYAxisLabelsPageControlIndex             : Integer;
    FDataCursorPageControlIndex              : Integer;
    FLimitPageControlIndex                   : Integer;
    FLabelPageControlIndex                   : Integer;
    FLegendPageControlIndex                  : Integer;
    FTablePageControlIndex                   : Integer;
    FDataViewPageControlIndex                : Integer;
    FDataViewGridLinesCustomPageControlIndex : Integer;

    FEditorForm                 : TCustomForm;
    FXYAxesReverse              : Boolean;

    procedure SetXYAxesReverse(const Value: Boolean);
  protected
    procedure SetChannelClass      (const Value: TiPlotChannelCustomClass);
    procedure SetUserCanEditObjects(const Value: Boolean);

    procedure NotificationChange       (Sender: TObject);
    procedure NotificationInsert       (Sender: TObject);
    procedure NotificationRemove       (Sender: TObject);
    procedure NotificationRename       (Sender: TObject);
    procedure NotificationSetFocus     (Sender: TObject);

    procedure CreateEditor;
    procedure DoTranslation(AForm: TCustomForm);

    procedure EditorClose(Sender: TObject; var Action: TCloseAction);

    procedure EditLayoutObject   (Sender: TObject);
  public
    constructor Create(AOwner : TWinControl);
    destructor  Destroy; override;

    procedure EditProperties;

    procedure DeSelectAll;

    procedure BasicPropertyChanged;

    procedure ShowToolBars  (Value : Boolean);

    procedure ClearAllData;

    function AddChannel     : Integer;
    function AddDataView    : Integer;
    function AddDataCursor  : Integer;
    function AddXAxis       : Integer;
    function AddYAxis       : Integer;
    function AddLegend      : Integer;
    function AddTable       : Integer;
    function AddToolBar     : Integer;
    function AddLimit       : Integer;
    function AddLabel       : Integer;
    function AddAnnotation  : Integer;
    function AddTranslation : Integer;

    property ObjectManager        : TiPlotObjectManager      read FPlotObjectManager;
    property ToolBarManager       : TiPlotToolBarManager     read FToolBarManager;
    property LegendManager        : TiPlotLegendManager      read FLegendManager;
    property TableManager         : TiPlotTableManager       read FTableManager;
    property XAxisManager         : TiPlotXAxisManager       read FXAxisManager;
    property YAxisManager         : TiPlotYAxisManager       read FYAxisManager;
    property ChannelManager       : TiPlotChannelManager     read FChannelManager;
    property DataViewManager      : TiPlotDataViewManager    read FDataViewManager;
    property DataCursorManager    : TiPlotDataCursorManager  read FDataCursorManager;
    property LimitManager         : TiPlotLimitManager       read FLimitManager;
    property LabelManager         : TiPlotLabelManager       read FLabelManager;
    property AnnotationManager    : TiPlotAnnotationManager  read FAnnotationManager;
    property TranslationManager   : TiPlotTranslationManager read FTranslationManager;
    property LayoutManager        : TiPlotLayoutManager      read FLayoutManager;

    property OnChange             : TNotifyEvent             read FOnChange             write FOnChange;
    property OnInsert             : TNotifyEvent             read FOnInsert             write FOnInsert;
    property OnInvalidateNow      : TNotifyEvent             read FOnInvalidateNow      write FOnInvalidateNow;
    property OnRemove             : TNotifyEvent             read FOnRemove             write FOnRemove;

    property UserCanEditObjects   : Boolean                  read FUserCanEditObjects   write SetUserCanEditObjects;

    property ChannelClass         : TiPlotChannelCustomClass read FChannelClass         write SetChannelClass;

    property XYAxesReverse        : Boolean                  read FXYAxesReverse        write SetXYAxesReverse;

    property Owner                : TWinControl              read FOwner;
  end;

implementation

uses
  {$ifdef iVCL}iPlotAxis,   iPlotLegend,  iPlotTable,  iPlotToolBar,  iPlotDataView,  iPlotLimit,  iPlotLabel,  iPlotEditor,  iPlotComponent,  iXYPlotChannel;{$endif}
  {$ifdef iCLX}QiPlotAxis, QiPlotLegend, QiPlotTable, QiPlotToolBar, QiPlotDataView, QiPlotLimit, QiPlotLabel, QiPlotEditor, QiPlotComponent, QiXYPlotChannel;{$endif}


type
  TiPlotToolBarAccess      = class(TiPlotToolBar     ) end;
  TiPlotLayoutObjectAccess = class(TiPlotLayoutObject) end;
  TiPlotObjectAccess       = class(TiPlotObject      ) end;
  TiPlotDataViewAccess     = class(TiPlotDataView    ) end;
  TiPlotDataCursorAccess   = class(TiPlotDataCursor  ) end;
  TiPlotLegendAccess       = class(TiPlotLegend      ) end;
  TiPlotTableAccess        = class(TiPlotTable       ) end;
  TiPlotComponentAccess    = class(TiPlotComponent   ) end;
  TiPlotXAxisAccess        = class(TiPlotXAxis       ) end;
  TiPlotYAxisAccess        = class(TiPlotYAxis       ) end;
  TControlAccess           = class(TControl          ) end;
  TCustomFormAccess        = class(TCustomForm       ) end;
//*************************************************************************************************************************************
constructor TiPlotMasterManager.Create(AOwner : TWinControl);
begin
  FOwner := AOwner;

  TiPlotObjectManager.Create     (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotToolBarManager.Create    (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotLegendManager.Create     (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotTableManager.Create      (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotChannelManager.Create    (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotDataCursorManager.Create (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotDataViewManager.Create   (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotXAxisManager.Create      (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotYAxisManager.Create      (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotLimitManager.Create      (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotLabelManager.Create      (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotAnnotationManager.Create (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotLayoutManager.Create     (FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotTranslationManager.Create(                            NotificationInsert, NotificationRemove);

  FChannelManager.XAxisManager       := FXAxisManager;
  FChannelManager.YAxisManager       := FYAxisManager;

  FDataViewManager.XAxisManager      := FXAxisManager;
  FDataViewManager.YAxisManager      := FYAxisManager;

  FDataCursorManager.ChannelManager  := FChannelManager;
  FDataCursorManager.DataViewManager := FDataViewManager;

  FLimitManager.XAxisManager         := FXAxisManager;
  FLimitManager.YAxisManager         := FYAxisManager;

  FUserCanEditObjects := True;
end;
//*************************************************************************************************************************************
destructor TiPlotMasterManager.Destroy;
begin
  if FOwner is TiPlotComponent then
    begin
      if Assigned(FEditorForm) then
        begin
          FEditorForm.Free;
          FEditorForm := nil;
        end;
    end;

  if Assigned(FToolBarManager    ) then FToolBarManager.Free;
  if Assigned(FLegendManager     ) then FLegendManager.Free;
  if Assigned(FTableManager      ) then FTableManager.Free;
  if Assigned(FChannelManager    ) then FChannelManager.Free;
  if Assigned(FXAxisManager      ) then FXAxisManager.Free;
  if Assigned(FYAxisManager      ) then FYAxisManager.Free;
  if Assigned(FDataViewManager   ) then FDataViewManager.Free;
  if Assigned(FDataCursorManager ) then FDataCursorManager.Free;
  if Assigned(FLimitManager      ) then FLimitManager.Free;
  if Assigned(FLabelManager      ) then FLabelManager.Free;
  if Assigned(FAnnotationManager ) then FAnnotationManager.Free;
  if Assigned(FTranslationManager) then FTranslationManager.Free;

  if Assigned(FPlotObjectManager ) then FPlotObjectManager.Free;
  if Assigned(FLayoutManager)      then FLayoutManager.Free;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.SetUserCanEditObjects(const Value: Boolean);
var
  x : Integer;
begin
  FUserCanEditObjects := Value;

  for x := 0 to FChannelManager.Count-1    do TiPlotObjectAccess(FChannelManager.Items[x]   ).UserCanEdit := Value;
  for x := 0 to FXAxisManager.Count-1      do TiPlotObjectAccess(FXAxisManager.Items[x]     ).UserCanEdit := Value;
  for x := 0 to FYAxisManager.Count-1      do TiPlotObjectAccess(FYAxisManager.Items[x]     ).UserCanEdit := Value;
  for x := 0 to FDataViewManager.Count-1   do TiPlotObjectAccess(FDataViewManager.Items[x]  ).UserCanEdit := Value;
  for x := 0 to FToolBarManager.Count-1    do TiPlotObjectAccess(FToolBarManager.Items[x]   ).UserCanEdit := Value;
  for x := 0 to FLegendManager.Count-1     do TiPlotObjectAccess(FLegendManager.Items[x]    ).UserCanEdit := Value;
  for x := 0 to FTableManager.Count-1      do TiPlotObjectAccess(FTableManager.Items[x]     ).UserCanEdit := Value;
  for x := 0 to FDataCursorManager.Count-1 do TiPlotObjectAccess(FDataCursorManager.Items[x]).UserCanEdit := Value;
  for x := 0 to FLimitManager.Count-1      do TiPlotObjectAccess(FLimitManager.Items[x]     ).UserCanEdit := Value;
  for x := 0 to FLabelManager.Count-1      do TiPlotObjectAccess(FLabelManager.Items[x]     ).UserCanEdit := Value;
  for x := 0 to FAnnotationManager.Count-1 do TiPlotObjectAccess(FAnnotationManager.Items[x]).UserCanEdit := Value;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.SetXYAxesReverse(const Value: Boolean);
var
  x : Integer;
begin
  FXYAxesReverse := Value;

  FLayoutManager.XYAxesReverse := Value;

  for x := 0 to FChannelManager.Count-1    do TiPlotObjectAccess(FChannelManager.Items[x]   ).XYAxesReversed := Value;
  for x := 0 to FXAxisManager.Count-1      do TiPlotObjectAccess(FXAxisManager.Items[x]     ).XYAxesReversed := Value;
  for x := 0 to FYAxisManager.Count-1      do TiPlotObjectAccess(FYAxisManager.Items[x]     ).XYAxesReversed := Value;
  for x := 0 to FDataViewManager.Count-1   do TiPlotObjectAccess(FDataViewManager.Items[x]  ).XYAxesReversed := Value;
  for x := 0 to FToolBarManager.Count-1    do TiPlotObjectAccess(FToolBarManager.Items[x]   ).XYAxesReversed := Value;
  for x := 0 to FLegendManager.Count-1     do TiPlotObjectAccess(FLegendManager.Items[x]    ).XYAxesReversed := Value;
  for x := 0 to FTableManager.Count-1      do TiPlotObjectAccess(FTableManager.Items[x]     ).XYAxesReversed := Value;
  for x := 0 to FDataCursorManager.Count-1 do TiPlotObjectAccess(FDataCursorManager.Items[x]).XYAxesReversed := Value;
  for x := 0 to FLimitManager.Count-1      do TiPlotObjectAccess(FLimitManager.Items[x]     ).XYAxesReversed := Value;
  for x := 0 to FLabelManager.Count-1      do TiPlotObjectAccess(FLabelManager.Items[x]     ).XYAxesReversed := Value;
  for x := 0 to FAnnotationManager.Count-1 do TiPlotObjectAccess(FAnnotationManager.Items[x]).XYAxesReversed := Value;

  if Assigned(FOnInvalidateNow) then FOnInvalidateNow(Self);
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.NotificationInsert(Sender: TObject);
begin
  if Sender is TiPlotObject then
    begin
      if Assigned(FPlotObjectManager) then if Sender is TiPlotObject        then FPlotObjectManager.NotificationInsert(Sender);
      if Assigned(FLayoutManager    ) then if Sender is TiPlotLayoutObject  then FLayoutManager.NotificationInsert(Sender);

      if Assigned(FToolBarManager   ) then if Sender is TiPlotToolBar       then FToolBarManager.NotificationInsert(Sender);
      if Assigned(FLegendManager    ) then if Sender is TiPlotLegend        then FLegendManager.NotificationInsert(Sender);
      if Assigned(FTableManager     ) then if Sender is TiPlotTable         then FTableManager.NotificationInsert(Sender);
      if Assigned(FXAxisManager     ) then if Sender is TiPlotXAxis         then FXAxisManager.NotificationInsert(Sender);
      if Assigned(FYAxisManager     ) then if Sender is TiPlotYAxis         then FYAxisManager.NotificationInsert(Sender);
      if Assigned(FChannelManager   ) then if Sender is TiPlotChannelCustom then FChannelManager.NotificationInsert(Sender);
      if Assigned(FDataViewManager  ) then if Sender is TiPlotDataView      then FDataViewManager.NotificationInsert(Sender);
      if Assigned(FDataCursorManager) then if Sender is TiPlotDataCursor    then FDataCursorManager.NotificationInsert(Sender);
      if Assigned(FLimitManager     ) then if Sender is TiPlotLimit         then FLimitManager.NotificationInsert(Sender);
      if Assigned(FLabelManager     ) then if Sender is TiPlotLabel         then FLabelManager.NotificationInsert(Sender);
      if Assigned(FAnnotationManager) then if Sender is TiPlotAnnotation    then FAnnotationManager.NotificationInsert(Sender);

      if Sender is TiPlotObject then
        begin
          TiPlotObjectAccess(Sender as TiPlotObject).OnSetFocus      := NotificationSetFocus;
          TiPlotObjectAccess(Sender as TiPlotObject).OnInvalidateNow := FOnInvalidateNow;
          TiPlotObjectAccess(Sender as TiPlotObject).UserCanEdit     := FUserCanEditObjects;
          TiPlotObjectAccess(Sender as TiPlotObject).OnEdit          := EditLayoutObject;
          TiPlotObjectAccess(Sender as TiPlotObject).XYAxesReversed  := FXYAxesReverse;
        end;

      if Assigned(FEditorForm) then if not (FEditorForm as TiPlotEditorForm).IsClosing then
        with FEditorForm as TiPlotEditorForm do
          begin
            if Sender is TiPlotToolBar then
              begin
                ToolBarListBox.Items.AddObject ('',Sender);
                ToolBarListBox.ItemIndex := ToolBarListBox.Items.Count-1;
                UpdateToolBarEdit;
              end
            else if Sender is TiPlotLegend then
              begin
                LegendListBox.Items.AddObject ('',Sender);
                LegendListBox.ItemIndex := LegendListBox.Items.Count-1;
                UpdateLegendEdit;
              end
            else if Sender is TiPlotTable then
              begin
                TableListBox.Items.AddObject ('',Sender);
                TableListBox.ItemIndex := TableListBox.Items.Count-1;
                UpdateTableEdit;
              end
            else if Sender is TiPlotXAxis   then
              begin
                XAxisListBox.Items.AddObject  ('',Sender);
                XAxisListBox.ItemIndex := XAxisListBox.Items.Count-1;
                UpdateXAxesEdit;
              end
            else if Sender is TiPlotYAxis   then
              begin
                YAxisListBox.Items.AddObject  ('',Sender);
                YAxisListBox.ItemIndex := YAxisListBox.Items.Count-1;
                UpdateYAxesEdit;
              end
            else if Sender is TiPlotDataView then
              begin
                DataViewListBox.Items.AddObject('',Sender);
                DataViewListBox.ItemIndex := DataViewListBox.Items.Count-1;
                UpdateDataViewEdit;
              end
            else if Sender is TiPlotChannelCustom then
              begin
                ChannelListBox.Items.AddObject('',Sender);
                ChannelListBox.ItemIndex := ChannelListBox.Items.Count-1;
                UpdateChannelEdit;
              end
            else if Sender is TiPlotDataCursor then
              begin
                DataCursorListBox.Items.AddObject('',Sender);
                DataCursorListBox.ItemIndex := DataCursorListBox.Items.Count-1;
                UpdateDataCursorEdit;
              end
            else if Sender is TiPlotLimit then
              begin
                LimitListBox.Items.AddObject('',Sender);
                LimitListBox.ItemIndex := LimitListBox.Items.Count-1;
                UpdateLimitEdit;
              end
            else if Sender is TiPlotLabel then
              begin
                LabelListBox.Items.AddObject('',Sender);
                LabelListBox.ItemIndex := LabelListBox.Items.Count-1;
                UpdateLabelEdit;
              end
          end;
    end
  else if Sender is TiPlotTranslationObject  then FTranslationManager.NotificationInsert(Sender)
  else if Sender is TiPlotObjectManager      then FPlotObjectManager  := Sender as TiPlotObjectManager
  else if Sender is TiPlotToolBarManager     then FToolBarManager     := Sender as TiPlotToolBarManager
  else if Sender is TiPlotLegendManager      then FLegendManager      := Sender as TiPlotLegendManager
  else if Sender is TiPlotTableManager       then FTableManager       := Sender as TiPlotTableManager
  else if Sender is TiPlotXAxisManager       then FXAxisManager       := Sender as TiPlotXAxisManager
  else if Sender is TiPlotYAxisManager       then FYAxisManager       := Sender as TiPlotYAxisManager
  else if Sender is TiPlotChannelManager     then FChannelManager     := Sender as TiPlotChannelManager
  else if Sender is TiPlotDataViewManager    then FDataViewManager    := Sender as TiPlotDataViewManager
  else if Sender is TiPlotDataCursorManager  then FDataCursorManager  := Sender as TiPlotDataCursorManager
  else if Sender is TiPlotLimitManager       then FLimitManager       := Sender as TiPlotLimitManager
  else if Sender is TiPlotLabelManager       then FLabelManager       := Sender as TiPlotLabelManager
  else if Sender is TiPlotAnnotationManager  then FAnnotationManager  := Sender as TiPlotAnnotationManager
  else if Sender is TiPlotLayoutManager      then FLayoutManager      := Sender as TiPlotLayoutManager
  else if Sender is TiPlotTranslationManager then FTranslationManager := Sender as TiPlotTranslationManager;

  if Assigned(FOnInsert) then FOnInsert(Sender);
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.NotificationRemove(Sender: TObject);
begin
  if Assigned(FOnRemove) then FOnRemove(Sender);

  if Assigned(FTranslationManager) then if Sender is TiPlotTranslationObject then
    begin
      FTranslationManager.NotificationRemove(Sender);
      Exit;
    end;

  if (Sender is TiPlotObject) then
    begin
      if Assigned(FEditorForm) then if not (FEditorForm as TiPlotEditorForm).IsClosing then
        with FEditorForm as TiPlotEditorForm do
          begin
            if      Sender is TiPlotToolBar       then ToolBarListBox.DeleteObjectIndex(Sender)
            else if Sender is TiPlotLegend        then LegendListBox.DeleteObjectIndex(Sender)
            else if Sender is TiPlotTable         then TableListBox.DeleteObjectIndex(Sender)
            else if Sender is TiPlotXAxis         then XAxisListBox.DeleteObjectIndex(Sender)
            else if Sender is TiPlotYAxis         then YAxisListBox.DeleteObjectIndex(Sender)
            else if Sender is TiPlotDataView      then DataViewListBox.DeleteObjectIndex(Sender)
            else if Sender is TiPlotChannelCustom then ChannelListBox.DeleteObjectIndex(Sender)
            else if Sender is TiPlotDataCursor    then DataCursorListBox.DeleteObjectIndex(Sender)
            else if Sender is TiPlotLimit         then LimitListBox.DeleteObjectIndex(Sender)
            else if Sender is TiPlotLabel         then LabelListBox.DeleteObjectIndex(Sender);
          end;

      if Assigned(FPlotObjectManager)then FPlotObjectManager.NotificationRemove(Sender);
      if Assigned(FLayoutManager)    then FLayoutManager.NotificationRemove    (Sender);

      if Assigned(FToolBarManager)   then FToolBarManager.NotificationRemove   (Sender);
      if Assigned(FLegendManager)    then FLegendManager.NotificationRemove    (Sender);
      if Assigned(FTableManager)     then FTableManager.NotificationRemove     (Sender);
      if Assigned(FXAxisManager)     then FXAxisManager.NotificationRemove     (Sender);
      if Assigned(FYAxisManager)     then FYAxisManager.NotificationRemove     (Sender);
      if Assigned(FChannelManager)   then FChannelManager.NotificationRemove   (Sender);
      if Assigned(FDataViewManager)  then FDataViewManager.NotificationRemove  (Sender);
      if Assigned(FDataCursorManager)then FDataCursorManager.NotificationRemove(Sender);
      if Assigned(FLimitManager)     then FLimitManager.NotificationRemove     (Sender);
      if Assigned(FLabelManager)     then FLabelManager.NotificationRemove     (Sender);
      if Assigned(FAnnotationManager)then FAnnotationManager.NotificationRemove(Sender);
    end;

  if      Sender = FPlotObjectManager  then FPlotObjectManager  := nil
  else if Sender = FToolBarManager     then FToolBarManager     := nil
  else if Sender = FLegendManager      then FLegendManager      := nil
  else if Sender = FTableManager       then FTableManager       := nil
  else if Sender = FXAxisManager       then FXAxisManager       := nil
  else if Sender = FYAxisManager       then FYAxisManager       := nil
  else if Sender = FChannelManager     then FChannelManager     := nil
  else if Sender = FDataViewManager    then FDataViewManager    := nil
  else if Sender = FDataCursorManager  then FDataCursorManager  := nil
  else if Sender = FLimitManager       then FLimitManager       := nil
  else if Sender = FLabelManager       then FLabelManager       := nil
  else if Sender = FAnnotationManager  then FAnnotationManager  := nil
  else if Sender = FLayoutManager      then FLayoutManager      := nil
  else if Sender = FTranslationManager then FTranslationManager := nil;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.NotificationSetFocus(Sender: TObject);
begin
  if Assigned(FToolBarManager   ) then FToolBarManager.NotificationSetFocus(Sender);
  if Assigned(FLegendManager    ) then FLegendManager.NotificationSetFocus(Sender);
  if Assigned(FTableManager     ) then FTableManager.NotificationSetFocus(Sender);
  if Assigned(FXAxisManager     ) then FXAxisManager.NotificationSetFocus(Sender);
  if Assigned(FYAxisManager     ) then FYAxisManager.NotificationSetFocus(Sender);
  if Assigned(FChannelManager   ) then FChannelManager.NotificationSetFocus(Sender);
  if Assigned(FDataViewManager  ) then FDataViewManager.NotificationSetFocus(Sender);
  if Assigned(FDataCursorManager) then FDataCursorManager.NotificationSetFocus(Sender);
  if Assigned(FLimitManager     ) then FLimitManager.NotificationSetFocus(Sender);
  if Assigned(FLabelManager     ) then FLabelManager.NotificationSetFocus(Sender);
  if Assigned(FAnnotationManager) then FAnnotationManager.NotificationSetFocus(Sender);
  if Assigned(FLayoutManager    ) then FLayoutManager.NotificationSetFocus(Sender);
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.NotificationRename(Sender: TObject);
var
  NewName : String;
begin
  if Assigned(FToolBarManager   ) then FToolBarManager.NotificationRename(Sender);
  if Assigned(FLegendManager    ) then FLegendManager.NotificationRename(Sender);
  if Assigned(FTableManager     ) then FTableManager.NotificationRename(Sender);
  if Assigned(FXAxisManager     ) then FXAxisManager.NotificationRename(Sender);
  if Assigned(FYAxisManager     ) then FYAxisManager.NotificationRename(Sender);
  if Assigned(FChannelManager   ) then FChannelManager.NotificationRename(Sender);
  if Assigned(FDataViewManager  ) then FDataViewManager.NotificationRename(Sender);
  if Assigned(FDataCursorManager) then FDataCursorManager.NotificationRename(Sender);
  if Assigned(FLimitManager     ) then FLimitManager.NotificationRename(Sender);
  if Assigned(FLabelManager     ) then FLabelManager.NotificationRename(Sender);
  if Assigned(FAnnotationManager) then FAnnotationManager.NotificationRename(Sender);
  if Assigned(FLayoutManager    ) then FLayoutManager.NotificationRename(Sender);

  if Assigned(FEditorForm) then if not (FEditorForm as TiPlotEditorForm).IsClosing then
    with FEditorForm as TiPlotEditorForm do
      begin
        if Sender is TiPlotXAxis then
          begin
            NewName := (Sender as TiPlotXAxis).Name;
            if ChannelXAxisNameComboBox.Text = TiPlotObjectAccess(Sender as TiPlotXAxis).NameOld then
              begin
                XAxisNameComboBoxDropDown(ChannelXAxisNameComboBox);
                ChannelXAxisNameComboBox.ItemIndex := ChannelXAxisNameComboBox.Items.IndexOf(NewName);
              end;
            if LimitXAxisNameComboBox.Text = TiPlotObjectAccess(Sender as TiPlotXAxis).NameOld then
              begin
                XAxisNameComboBoxDropDown(LimitXAxisNameComboBox);
                LimitXAxisNameComboBox.ItemIndex := LimitXAxisNameComboBox.Items.IndexOf(NewName);
              end;
            if DataViewGridXAxisNameComboBox.Text = TiPlotObjectAccess(Sender).NameOld then
              begin
                XAxisNameComboBoxDropDown(DataViewGridXAxisNameComboBox);
                DataViewGridXAxisNameComboBox.ItemIndex := DataViewGridXAxisNameComboBox.Items.IndexOf(NewName);
              end;
          end;
        if Sender is TiPlotYAxis then
          begin
            NewName := (Sender as TiPlotYAxis).Name;
            if ChannelYAxisNameComboBox.Text = TiPlotObjectAccess(Sender as TiPlotYAxis).NameOld then
              begin
                YAxisNameComboBoxDropDown(ChannelYAxisNameComboBox);
                ChannelYAxisNameComboBox.ItemIndex := ChannelYAxisNameComboBox.Items.IndexOf(NewName);
              end;
            if LimitYAxisNameComboBox.Text = TiPlotObjectAccess(Sender as TiPlotYAxis).NameOld then
              begin
                YAxisNameComboBoxDropDown(LimitYAxisNameComboBox);
                LimitYAxisNameComboBox.ItemIndex := LimitYAxisNameComboBox.Items.IndexOf(NewName);
              end;
            if DataViewGridYAxisNameComboBox.Text = TiPlotObjectAccess(Sender).NameOld then
              begin
                YAxisNameComboBoxDropDown(DataViewGridYAxisNameComboBox);
                DataViewGridYAxisNameComboBox.ItemIndex := DataViewGridYAxisNameComboBox.Items.IndexOf(NewName);
              end;
          end;
        if Sender is TiPlotChannelCustom then
          begin
            NewName := (Sender as TiPlotChannelCustom).Name;
            if DataCursorChannelNameComboBox.Text = TiPlotObjectAccess(Sender).NameOld then
              begin
                ChannelNameComboBoxDropDown(DataCursorChannelNameComboBox);
                DataCursorChannelNameComboBox.ItemIndex := DataCursorChannelNameComboBox.Items.IndexOf(NewName);
              end;
          end
      end;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.NotificationChange(Sender: TObject);
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddChannel: Integer;
var
  iChannel : TiPlotChannelCustom;
begin
  iChannel := FChannelClass.Create(FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotObjectAccess(iChannel).Loaded;
  Result := FChannelManager.Count-1;
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddDataView: Integer;
var
  iDataView : TiPlotDataView;
begin
  iDataView := TiPlotDataView.Create(FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotObjectAccess(iDataView).Loaded;
  Result := FDataViewManager.Count-1;
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddDataCursor: Integer;
var
  iCursor : TiPlotDataCursor;
begin
  iCursor := TiPlotDataCursor.Create(FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotObjectAccess(iCursor).Loaded;
  Result := FDataCursorManager.Count-1;
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddLimit: Integer;
var
  iLimit : TiPlotLimit;
begin
  iLimit := TiPlotLimit.Create(FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotObjectAccess(iLimit).Loaded;
  Result := FLimitManager.Count-1;
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddLabel: Integer;
var
  iLabel : TiPlotLabel;
begin
  iLabel := TiPlotLabel.Create(FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotObjectAccess(iLabel).Loaded;
  Result := FLabelManager.Count-1;
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddAnnotation: Integer;
var
  iAnnotation : TiPlotAnnotation;                 
begin
  iAnnotation := TiPlotAnnotation.Create(FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotObjectAccess(iAnnotation).Loaded; 
  Result := FAnnotationManager.Count-1;
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddLegend: Integer;
var
  iLegend : TiPlotLegend;
begin
  iLegend := TiPlotLegend.Create(FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotObjectAccess(iLegend).Loaded;
  Result := FLegendManager.Count-1;
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddTable: Integer;
var
  iTable : TiPlotTable;
begin
  iTable := TiPlotTable.Create(FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotObjectAccess(iTable).Loaded;
  Result := FTableManager.Count-1;
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddToolBar: Integer;
var
  iToolBar : TiPlotToolBar;
begin
  iToolBar := TiPlotToolBar.Create(FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotObjectAccess(iToolBar).Loaded;
  Result := ToolBarManager.Count-1;
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddXAxis: Integer;
var
  iXAxis : TiPlotXAxis;
begin
  iXAxis := TiPlotXAxis.Create(FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotObjectAccess(iXAxis).Loaded;
  Result := XAxisManager.Count-1;
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddYAxis: Integer;
var
  iYAxis : TiPlotYAxis;
begin
  iYAxis := TiPlotYAxis.Create(FOwner, NotificationChange, NotificationInsert, NotificationRemove, NotificationRename);
  TiPlotObjectAccess(iYAxis).Loaded;
  Result := YAxisManager.Count-1;
end;
//*************************************************************************************************************************************
function TiPlotMasterManager.AddTranslation: Integer;
begin
  Result := FTranslationManager.Add;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.CreateEditor;
var
  x : Integer;
begin
  if FOwner is TiPlotComponent then
    begin
      FEditorForm := TiPlotEditorForm.Create(FOwner);
      with FEditorForm as TiPlotEditorForm do
        begin
          SetFormTranslationMethod(DoTranslation);
          OnClose                              := EditorClose;
          Master                               := Self;
          iPlotLayoutViewer.Master             := Self;
          iPlotLayoutViewer.LayoutManager      := FLayOutManager;
          iPlotLayoutViewer.TranslationManager := FTranslationManager;

          for x := 0 to FToolBarManager.Count-1 do
            ToolBarListBox.Items.AddObject ('',FToolBarManager.Items[x]);
          if ToolBarListBox.Items.Count <> 0 then ToolBarListBox.ItemIndex := 0 else ToolBarListBox.ItemIndex := -1;
          UpdateToolBarEdit;

          for x := 0 to FLegendManager.Count-1 do
            LegendListBox.Items.AddObject ('',FLegendManager.Items[x]);
          if LegendListBox.Items.Count <> 0 then LegendListBox.ItemIndex := 0 else LegendListBox.ItemIndex := -1;
          UpdateLegendEdit;

          for x := 0 to FTableManager.Count-1 do
            TableListBox.Items.AddObject ('',FTableManager.Items[x]);
          if TableListBox.Items.Count <> 0 then TableListBox.ItemIndex := 0 else TableListBox.ItemIndex := -1;
          UpdateTableEdit;

          for x := 0 to FXAxisManager.Count-1 do
            XAxisListBox.Items.AddObject ('',FXAxisManager.Items[x]);
          if XAxisListBox.Items.Count <> 0 then XAxisListBox.ItemIndex := 0 else XAxisListBox.ItemIndex := -1;
          UpdateXAxesEdit;

          for x := 0 to FYAxisManager.Count-1 do
            YAxisListBox.Items.AddObject ('',FYAxisManager.Items[x]);
          if YAxisListBox.Items.Count <> 0 then YAxisListBox.ItemIndex := 0 else YAxisListBox.ItemIndex := -1;
          UpdateYAxesEdit;

          for x := 0 to FDataViewManager.Count-1 do
            DataViewListBox.Items.AddObject ('',FDataViewManager.Items[x]);
          if DataViewListBox.Items.Count <> 0 then DataViewListBox.ItemIndex := 0 else DataViewListBox.ItemIndex := -1;
          UpdateDataViewEdit;

          for x := 0 to FChannelManager.Count-1 do
            ChannelListBox.Items.AddObject ('',FChannelManager.Items[x]);
          if ChannelListBox.Items.Count <> 0 then ChannelListBox.ItemIndex := 0 else ChannelListBox.ItemIndex := -1;
          UpdateChannelEdit;

          for x := 0 to FDataCursorManager.Count-1 do
            DataCursorListBox.Items.AddObject ('',FDataCursorManager.Items[x]);
          if DataCursorListBox.Items.Count <> 0 then DataCursorListBox.ItemIndex := 0 else DataCursorListBox.ItemIndex := -1;
          UpdateDataCursorEdit;

          for x := 0 to FLimitManager.Count-1 do
            LimitListBox.Items.AddObject ('',FLimitManager.Items[x]);
          if LimitListBox.Items.Count <> 0 then LimitListBox.ItemIndex := 0 else LimitListBox.ItemIndex := -1;
          UpdateLimitEdit;

          for x := 0 to FLabelManager.Count-1 do
            LabelListBox.Items.AddObject ('',FLabelManager.Items[x]);
          if LabelListBox.Items.Count <> 0 then LabelListBox.ItemIndex := 0 else LabelListBox.ItemIndex := -1;
          UpdateLabelEdit;

          SetActivePageIndex(PageControl,                        FMainPageControlIndex);
          SetActivePageIndex(ControlPageControl,                 FControlPageControlIndex);
          SetActivePageIndex(ChannelPageControl,                 FChannelPageControlIndex);
          SetActivePageIndex(XAxisPageControl,                   FXAxisPageControlIndex);
          SetActivePageIndex(XAxisLabelsPageControl,             FXAxisLabelsPageControlIndex);
          SetActivePageIndex(YAxisPageControl,                   FYAxisPageControlIndex);
          SetActivePageIndex(YAxisLabelsPageControl,             FYAxisLabelsPageControlIndex);
          SetActivePageIndex(DataCursorPageControl,              FDataCursorPageControlIndex);
          SetActivePageIndex(LimitPageControl,                   FLimitPageControlIndex);
          SetActivePageIndex(LabelPageControl,                   FLabelPageControlIndex);
          SetActivePageIndex(LegendPageControl,                  FLegendPageControlIndex);
          SetActivePageIndex(TablePageControl,                   FTablePageControlIndex);
          SetActivePageIndex(DataViewPageControl,                FDataViewPageControlIndex);
          SetActivePageIndex(DataViewGridLinesCustomPageControl, FDataViewGridLinesCustomPageControlIndex);

          if TiPlotComponent(FOwner).UserCanAddRemoveChannels then
            begin
              iChannelAddButton.Visible   := True;
              ChannelRemoveButton.Visible := True;
            end
          else
            begin
              iChannelAddButton.Visible   := False;
              ChannelRemoveButton.Visible := False;
            end;

        end;
    end;
  DoTranslation(FEditorForm);
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.EditProperties;
begin
  if not Assigned(FEditorForm) then CreateEditor;
  try
    with FEditorForm as TiPlotEditorForm do
      begin
        UpdateAll;

        PlotComponent := FOwner;

        if FOwner is TiPlotComponent then
          begin
            AutoFrameRateCheckBox.AsBoolean               := TiPlotComponentAccess(FOwner).AutoFrameRate;
            UpdateFrameRateEdit.AsInteger                 := TiPlotComponentAccess(FOwner).UpdateFrameRate;
            ClipAnnotationsToAxesCheckBox.AsBoolean       := TiPlotComponentAccess(FOwner).ClipAnnotationsToAxes;
            BorderStyleRadioGroup.AsInteger               := ord(TiPlotComponentAccess(FOwner).BorderStyle);
            CopyToClipBoardFormatComboBox.AsInteger       := ord(TiPlotComponentAccess(FOwner).CopyToClipBoardFormat);
            FileColumnSeparatorComboBox.AsInteger         := ord(TiPlotComponentAccess(FOwner).DataFileColumnSeparator);

            BackGroundColorPicker.Color                   := TiPlotComponentAccess(FOwner).BackGroundColor;
            BackGroundGradientDirectionComboBox.AsInteger := ord(TiPlotComponentAccess(FOwner).BackGroundGradientDirection);
            BackGroundGradientEnabledCheckBox.AsBoolean   := TiPlotComponentAccess(FOwner).BackGroundGradientEnabled;
            BackGroundGradientStartColorPicker.Color      := TiPlotComponentAccess(FOwner).BackGroundGradientStartColor;
            BackGroundGradientStopColorPicker.Color       := TiPlotComponentAccess(FOwner).BackGroundGradientStopColor;

            OuterMarginLeftEdit.AsInteger                 := TiPlotComponentAccess(FOwner).OuterMarginLeft;
            OuterMarginTopEdit.AsInteger                  := TiPlotComponentAccess(FOwner).OuterMarginTop;
            OuterMarginRightEdit.AsInteger                := TiPlotComponentAccess(FOwner).OuterMarginRight;
            OuterMarginBottomEdit.AsInteger               := TiPlotComponentAccess(FOwner).OuterMarginBottom;

            TitleVisibleCheckBox.AsBoolean                := TiPlotComponentAccess(FOwner).TitleVisible;
            TitleMarginEdit.AsFloat                       := TiPlotComponentAccess(FOwner).TitleMargin;
            TitleTextEdit.AsString                        := TiPlotComponentAccess(FOwner).TitleText;

            TitleFontPicker.Font.Assign(TiPlotComponentAccess(FOwner).TitleFont);

            ControlLogFileNameEdit.Text                   := TiPlotComponentAccess(FOwner).LogFileName;
            ControlLogBufferSizeEdit.AsInteger            := TiPlotComponentAccess(FOwner).LogBufferSize;

            HintsShowCheckBox.AsBoolean                   := TiPlotComponentAccess(FOwner).HintsShow;
            HintsPauseEdit.AsInteger                      := TiPlotComponentAccess(FOwner).HintsPause;
            HintsHidePauseEdit.AsInteger                  := TiPlotComponentAccess(FOwner).HintsHidePause;
            HintsFontPicker.Font.Assign(TiPlotComponentAccess(FOwner).HintsFont);

            AnnotationDefaultPenColorPicker.Color         := TiPlotComponentAccess(FOwner).AnnotationDefaultPenColor;
            AnnotationDefaultPenStyleComboBox.AsInteger   := ord(TiPlotComponentAccess(FOwner).AnnotationDefaultPenStlye);
            AnnotationDefaultPenWidthEdit.AsInteger       := TiPlotComponentAccess(FOwner).AnnotationDefaultPenWidth;
            AnnotationDefaultBrushColorPicker.Color       := TiPlotComponentAccess(FOwner).AnnotationDefaultBrushColor;
            AnnotationDefaultBrushStyleComboBox.AsInteger := ord(TiPlotComponentAccess(FOwner).AnnotationDefaultBrushStlye);

            AnnotationDefaultReferenceComboBox.AsInteger          := ord(TiPlotComponentAccess(FOwner).AnnotationDefaultReference);
            AnnotationDefaultReferencePositionXComboBox.AsInteger := ord(TiPlotComponentAccess(FOwner).AnnotationDefaultReferencePositionX);
            AnnotationDefaultReferencePositionYComboBox.AsInteger := ord(TiPlotComponentAccess(FOwner).AnnotationDefaultReferencePositionY);
            AnnotationDefaultReferenceSizeXComboBox.AsInteger     := ord(TiPlotComponentAccess(FOwner).AnnotationDefaultReferenceSizeX);
            AnnotationDefaultReferenceSizeYComboBox.AsInteger     := ord(TiPlotComponentAccess(FOwner).AnnotationDefaultReferenceSizeY);

            AnnotationDefaultFontPicker.Font.Assign(TiPlotComponentAccess(FOwner).AnnotationDefaultFont);

            PrintShowDialogCheckBox.AsBoolean             := TiPlotComponentAccess(FOwner).PrintShowDialog;
            PrintOrientationRadioGroup.AsInteger          := Ord(TiPlotComponentAccess(FOwner).PrintOrientation);
            PrintMarginLeftEdit.AsFloat                   := TiPlotComponentAccess(FOwner).PrintMarginLeft;
            PrintMarginTopEdit.AsFloat                    := TiPlotComponentAccess(FOwner).PrintMarginTop;
            PrintMarginRightEdit.AsFloat                  := TiPlotComponentAccess(FOwner).PrintMarginRight;
            PrintMarginBottomEdit.AsFloat                 := TiPlotComponentAccess(FOwner).PrintMarginBottom;
            PrintDocumentNameEdit.AsString                := TiPlotComponentAccess(FOwner).PrintDocumentName;
          end;

        ControlLogActivateButton.Enabled   := not TiPlotComponentAccess(FOwner).LoggingActive;
        ControlLogDeactivateButton.Enabled :=     TiPlotComponentAccess(FOwner).LoggingActive;

        if TiPlotComponentAccess(FOwner).LoggingActive then
          begin
            ControlLogFileNameEdit.Enabled := False;
            ControlLogFileNamePicker.Disable;
          end
        else
          begin
            ControlLogFileNameEdit.Enabled := True;
            ControlLogFileNamePicker.Enable;
          end;

        FEditorForm.Left := Screen.Width  div 2 - FEditorForm.Width  div 2;
        FEditorForm.Top  := Screen.Height div 2 - FEditorForm.Height div 2;

        if Assigned(TiPlotComponentAccess(FOwner).OnAfterOpenEditor) then TiPlotComponentAccess(FOwner).OnAfterOpenEditor(Self);

        case TiPlotComponentAccess(FOwner).EditorFormStyle of
          ipfsModal : begin
                        ShowModal;
                      end;
          else        begin
                       TCustomFormAccess(FEditorForm).FormStyle := fsStayOnTop;
                       FEditorForm.Show;
                      end;
        end;

        FMainPageControlIndex                    := GetActivePageIndex(PageControl);
        FControlPageControlIndex                 := GetActivePageIndex(ControlPageControl);
        FChannelPageControlIndex                 := GetActivePageIndex(ChannelPageControl);
        FXAxisPageControlIndex                   := GetActivePageIndex(XAxisPageControl);
        FXAxisLabelsPageControlIndex             := GetActivePageIndex(XAxisLabelsPageControl);
        FYAxisPageControlIndex                   := GetActivePageIndex(YAxisPageControl);
        FYAxisLabelsPageControlIndex             := GetActivePageIndex(YAxisLabelsPageControl);
        FDataCursorPageControlIndex              := GetActivePageIndex(DataCursorPageControl);
        FLimitPageControlIndex                   := GetActivePageIndex(LimitPageControl);
        FLabelPageControlIndex                   := GetActivePageIndex(LabelPageControl);
        FLegendPageControlIndex                  := GetActivePageIndex(LegendPageControl);
        FTablePageControlIndex                   := GetActivePageIndex(TablePageControl);
        FDataViewPageControlIndex                := GetActivePageIndex(DataViewPageControl);
        FDataViewGridLinesCustomPageControlIndex := GetActivePageIndex(DataViewGridLinesCustomPageControl);
      end;
    finally
        case TiPlotComponentAccess(FOwner).EditorFormStyle of
          ipfsModal : begin
                        FEditorForm.Free;
                        FEditorForm := nil;
                      end;
          else        begin
                       //Do Nothing. Handled in EditorClose.
                      end;
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.EditorClose(Sender: TObject; var Action: TCloseAction);
begin
  case TiPlotComponentAccess(FOwner).EditorFormStyle of
    ipfsModal : begin
                  //Do Nothing. Handled in EditProperties
                end;
    else        begin
                  FEditorForm.Free;
                  FEditorForm := nil;
                end;
  end;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.BasicPropertyChanged;
begin
  if not Assigned(FEditorForm)                   then Exit;
  if (FEditorForm as TiPlotEditorForm).IsClosing then Exit;

  if FOwner is TiPlotComponent then
    with FEditorForm as TiPlotEditorForm do
      begin
        TiPlotComponentAccess(FOwner).AutoFrameRate                := AutoFrameRateCheckBox.AsBoolean;
        TiPlotComponentAccess(FOwner).UpdateFrameRate              := UpdateFrameRateEdit.AsInteger;
        TiPlotComponentAccess(FOwner).ClipAnnotationsToAxes        := ClipAnnotationsToAxesCheckBox.AsBoolean;
        TiPlotComponentAccess(FOwner).BorderStyle                  := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
        TiPlotComponentAccess(FOwner).CopyToClipBoardFormat        := TiPlotExportFormat(CopyToClipBoardFormatComboBox.AsInteger);
        TiPlotComponentAccess(FOwner).DataFileColumnSeparator      := TiPlotDataFileColumnSeparator(FileColumnSeparatorComboBox.AsInteger);

        TiPlotComponentAccess(FOwner).BackGroundColor              := BackGroundColorPicker.Color;
        TiPlotComponentAccess(FOwner).BackGroundGradientDirection  := TiFillDirection(BackGroundGradientDirectionComboBox.AsInteger);
        TiPlotComponentAccess(FOwner).BackGroundGradientEnabled    := BackGroundGradientEnabledCheckBox.AsBoolean;
        TiPlotComponentAccess(FOwner).BackGroundGradientStartColor := BackGroundGradientStartColorPicker.Color;
        TiPlotComponentAccess(FOwner).BackGroundGradientStopColor  := BackGroundGradientStopColorPicker.Color;

        TiPlotComponentAccess(FOwner).OuterMarginLeft              := OuterMarginLeftEdit.AsInteger;
        TiPlotComponentAccess(FOwner).OuterMarginTop               := OuterMarginTopEdit.AsInteger;
        TiPlotComponentAccess(FOwner).OuterMarginRight             := OuterMarginRightEdit.AsInteger;
        TiPlotComponentAccess(FOwner).OuterMarginBottom            := OuterMarginBottomEdit.AsInteger;

        TiPlotComponentAccess(FOwner).TitleVisible                 := TitleVisibleCheckBox.AsBoolean;
        TiPlotComponentAccess(FOwner).TitleMargin                  := TitleMarginEdit.AsFloat;
        TiPlotComponentAccess(FOwner).TitleText                    := TitleTextEdit.AsString;

        TiPlotComponentAccess(FOwner).TitleFont.Assign(TitleFontPicker.Font);

        TiPlotComponentAccess(FOwner).LogFileName                  := ControlLogFileNameEdit.Text;
        TiPlotComponentAccess(FOwner).LogBufferSize                := ControlLogBufferSizeEdit.AsInteger;

        if TiPlotComponentAccess(FOwner).LoggingActive then
          begin
            ControlLogFileNameEdit.Enabled := False;
            ControlLogFileNamePicker.Disable;
          end
        else
          begin
            ControlLogFileNameEdit.Enabled := True;
            ControlLogFileNamePicker.Enable;
          end;

        TiPlotComponentAccess(FOwner).HintsShow         := HintsShowCheckBox.AsBoolean;
        TiPlotComponentAccess(FOwner).HintsPause        := HintsPauseEdit.AsInteger;
        TiPlotComponentAccess(FOwner).HintsHidePause    := HintsHidePauseEdit.AsInteger;
        TiPlotComponentAccess(FOwner).HintsFont.Assign(HintsFontPicker.Font);

        TiPlotComponentAccess(FOwner).AnnotationDefaultPenColor           := AnnotationDefaultPenColorPicker.Color;
        TiPlotComponentAccess(FOwner).AnnotationDefaultPenStlye           := TPenStyle(AnnotationDefaultPenStyleComboBox.AsInteger);
        TiPlotComponentAccess(FOwner).AnnotationDefaultPenWidth           := AnnotationDefaultPenWidthEdit.AsInteger;
        TiPlotComponentAccess(FOwner).AnnotationDefaultBrushColor         := AnnotationDefaultBrushColorPicker.Color;
        TiPlotComponentAccess(FOwner).AnnotationDefaultBrushStlye         := TBrushStyle(AnnotationDefaultBrushStyleComboBox.AsInteger);

        TiPlotComponentAccess(FOwner).AnnotationDefaultReference          := TiPlotReferenceType      (AnnotationDefaultReferenceComboBox.AsInteger);
        TiPlotComponentAccess(FOwner).AnnotationDefaultReferencePositionX := TiPlotReferenceIndividual(AnnotationDefaultReferencePositionXComboBox.AsInteger);
        TiPlotComponentAccess(FOwner).AnnotationDefaultReferencePositionY := TiPlotReferenceIndividual(AnnotationDefaultReferencePositionYComboBox.AsInteger);
        TiPlotComponentAccess(FOwner).AnnotationDefaultReferenceSizeX     := TiPlotReferenceIndividual(AnnotationDefaultReferenceSizeXComboBox.AsInteger);
        TiPlotComponentAccess(FOwner).AnnotationDefaultReferenceSizeY     := TiPlotReferenceIndividual(AnnotationDefaultReferenceSizeYComboBox.AsInteger);

        TiPlotComponentAccess(FOwner).AnnotationDefaultBrushStlye := TBrushStyle(AnnotationDefaultBrushStyleComboBox.AsInteger);

        TiPlotComponentAccess(FOwner).AnnotationDefaultFont.Assign(AnnotationDefaultFontPicker.Font);

        TiPlotComponentAccess(FOwner).PrintShowDialog   := PrintShowDialogCheckBox.AsBoolean;
        TiPlotComponentAccess(FOwner).PrintOrientation  := TPrinterOrientation(PrintOrientationRadioGroup.AsInteger);
        TiPlotComponentAccess(FOwner).PrintMarginLeft   := PrintMarginLeftEdit.AsFloat;
        TiPlotComponentAccess(FOwner).PrintMarginTop    := PrintMarginTopEdit.AsFloat;
        TiPlotComponentAccess(FOwner).PrintMarginRight  := PrintMarginRightEdit.AsFloat;
        TiPlotComponentAccess(FOwner).PrintMarginBottom := PrintMarginBottomEdit.AsFloat;
        TiPlotComponentAccess(FOwner).PrintDocumentName := PrintDocumentNameEdit.AsString;

        ControlLogActivateButton.Enabled   := not TiPlotComponentAccess(FOwner).LoggingActive;
        ControlLogDeactivateButton.Enabled :=     TiPlotComponentAccess(FOwner).LoggingActive;
      end;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.EditLayoutObject(Sender: TObject);
begin
  if not Assigned(FEditorForm) then CreateEditor;
  with FEditorForm as TiPlotEditorForm do
    begin
      if Sender is TiPlotXAxis then
        begin
          PageControl.ActivePage := XAxesTabSheet;
          XAxisListBox.ItemIndex := XAxisListBox.Items.IndexOfObject(Sender);
        end
      else if Sender is TiPlotYAxis then
        begin
          PageControl.ActivePage := YAxesTabSheet;
          YAxisListBox.ItemIndex := YAxisListBox.Items.IndexOfObject(Sender);
        end
      else if Sender is TiPlotLegend then
        begin
          PageControl.ActivePage  := LegendTabSheet;
          LegendListBox.ItemIndex := LegendListBox.Items.IndexOfObject(Sender);
        end
      else if Sender is TiPlotTable then
        begin
          PageControl.ActivePage  := TablesTabSheet;
          TableListBox.ItemIndex := TableListBox.Items.IndexOfObject(Sender);
        end
      else if Sender is TiPlotToolBar then
        begin
          PageControl.ActivePage   := ToolBarTabSheet;
          ToolBarListBox.ItemIndex := ToolBarListBox.Items.IndexOfObject(Sender);
        end
      else if Sender is TiPlotDataView then
        begin
          PageControl.ActivePage    := DataViewTabSheet;
          DataViewListBox.ItemIndex := DataViewListBox.Items.IndexOfObject(Sender);
        end
      else if Sender is TiPlotChannelCustom then
        begin
          PageControl.ActivePage   := ChannelsTabSheet;
          ChannelListBox.ItemIndex := ChannelListBox.Items.IndexOfObject(Sender);
        end
      else if Sender is TiPlotDataCursor then
        begin
          PageControl.ActivePage      := DataCursorTabSheet;
          DataCursorListBox.ItemIndex := DataCursorListBox.Items.IndexOfObject(Sender);
        end
      else if Sender is TiPlotLimit then
        begin
          PageControl.ActivePage := LimitTabSheet;
          LimitListBox.ItemIndex := LimitListBox.Items.IndexOfObject(Sender);
        end;
      EditProperties;
    end;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.ShowToolBars(Value: Boolean);
var
  x : Integer;
begin
  for x := 0 to FToolBarManager.Count-1 do
    FToolBarManager.Items[x].Visible :=Value;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.ClearAllData;
var
  x : Integer;
begin
  for x := 0 to FChannelManager.Count-1 do
    FChannelManager.Items[x].Clear;

  for x := 0 to FXAxisManager.Count-1 do
    FXAxisManager.Items[x].ResetFirstAlign;

  for x := 0 to FYAxisManager.Count-1 do
    FYAxisManager.Items[x].ResetFirstAlign;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.DeSelectAll;
begin
  FPlotObjectManager.ClearAllUserSelections;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.SetChannelClass(const Value: TiPlotChannelCustomClass);
begin
  FChannelClass := Value;
  FChannelManager.ChannelClass := Value;
end;
//*************************************************************************************************************************************
procedure TiPlotMasterManager.DoTranslation(AForm: TCustomForm);
var
  x, y : Integer;
begin
  if not Assigned(AForm)                                                           then Exit;
  if AForm is TiPlotEditorForm then if (FEditorForm as TiPlotEditorForm).IsClosing then Exit;

  if FTranslationManager.Count = 0 then Exit;

  with AForm do                 
    begin
      Caption := FTranslationManager.FindReplacement(Caption);
      for x := 0 to ComponentCount - 1 do
        begin
          if Components[x] is TControl then
            begin
              TControlAccess(Components[x]).Caption := FTranslationManager.FindReplacement(TControlAccess(Components[x]).Caption);
            end;
          if Components[x] is TiComponentEditorCheckBox then
            begin
              (Components[x] as TiComponentEditorCheckBox).Caption := FTranslationManager.FindReplacement((Components[x] as TiComponentEditorCheckBox).Caption);
            end;
          if Components[x] is TiComponentEditorRadioGroup then
            with Components[x] as TiComponentEditorRadioGroup do
              begin
                Caption := FTranslationManager.FindReplacement(Caption);
                for y := 0 to Items.Count-1 do
                  Items.Strings[y] := FTranslationManager.FindReplacement(Items.Strings[y]);
              end;
          if Components[x] is TiComponentEditorComboBox then
            with Components[x] as TiComponentEditorComboBox do
              begin
                for y := 0 to Items.Count-1 do
                  Items.Strings[y] := FTranslationManager.FindReplacement(Items.Strings[y]);
              end;
          if Components[x] is TPopupMenu then
            with Components[x] as TPopupMenu do
              begin
                for y := 0 to Items.Count-1 do     
                  Items[y].Caption := FTranslationManager.FindReplacement(Items[y].Caption);
              end;
        end;
    end;
end;
//*************************************************************************************************************************************
end.


