
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumTreeList                                       }
{                                                                    }
{       Copyright (c) 1998-2009 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMTREELIST AND ALL        }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxDBTL;

{$I cxVer.inc}

interface

uses
  SysUtils, Classes, {$IFDEF DELPHI6} Variants, {$ENDIF} cxVariants, DB, cxEdit,
  cxDBEdit, cxControls, cxClasses, cxDataStorage, cxCustomData, cxDB, cxDBData, cxDataUtils,
  cxInplaceContainer, cxEditDBRegisteredRepositoryItems, cxTL, cxTLData;

type
  TcxCustomDBTreeList = class;
  TcxDBTreeListColumn = class;
  TcxDBTreeListDataController = class;
  TcxDBTreeListOptionsData = class;

  TcxDBTreeListNode = class(TcxTreeListNode)
  private
    FKeyValue: Variant;
    FParentKeyValue: Variant;
  protected
    procedure RestoreStateAfterRefresh; virtual;
    procedure SaveStateBeforeRefresh; virtual;
  public
    property KeyValue: Variant read FKeyValue write FKeyValue;
    property ParentKeyValue: Variant read FParentKeyValue write FParentKeyValue;
  end;

  { TcxTreeListDataLink }

  TcxTreeListDataLink = class(TDataLink)
  private
    FDataController: TcxDBTreeListDataController;
    FModified: Boolean;
    function GetDataBusy: Boolean;
    function GetDataLocate: Boolean;
    function GetOptionsData: TcxDBTreeListOptionsData;
    function GetTreeList: TcxCustomDBTreeList;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
  public
    constructor Create(ADataController: TcxDBTreeListDataController); virtual;

    property DataBusy: Boolean read GetDataBusy;
    property DataLocate: Boolean read GetDataLocate;
    property DataController: TcxDBTreeListDataController read FDataController;
    property Modified: Boolean read FModified write FModified;
    property OptionsData: TcxDBTreeListOptionsData read GetOptionsData;
    property TreeList: TcxCustomDBTreeList read GetTreeList;
  end;

  { TcxDBTreeListDataController }

  TcxDBTreeListDataController = class(TcxDataTreeListDataController)
  private
    FDataLink: TcxTreeListDataLink;
    FImageIndexField: TField;
    FImageIndexFieldName: string;
    FKeyField: TField;
    FKeyFieldName: string;
    FParentKeyField: TField; 
    FParentKeyFieldName: string;
    FStateIndexFieldName: string;
    FStateIndexField: TField;
    function GetDataSet: TDataSet;
    function GetDataSource: TDataSource;
    function GetTreeList: TcxCustomDBTreeList;
    procedure SetDataSource(AValue: TDataSource);
    procedure SetImageIndexFieldName(const AValue: string);
    procedure SetKeyFieldName(const AValue: string);
    procedure SetParentKeyFieldName(const AValue: string);
    procedure SetStateIndexFieldName(const AValue: string);
  protected
    function CanLocateByNode(AOldNode, ANode: TcxDBTreeListNode): Boolean;
    function CreateDataLink: TcxTreeListDataLink; virtual;
    function CreateLoader: TcxTreeListStructureLoader; override;
    procedure DataScrolled(ADistance: Integer); override;
    procedure DeleteNode(ANode: TcxTreeListNode); override;
    procedure DestroyInternalFields; virtual;
    procedure DoCopyTo(AttachNode: TcxDBTreeListNode;
      AttachMode: TcxTreeListNodeAttachMode; ANodes: TList);
    procedure DoInitInsertingNode(ANode: TcxTreeListNode); override;
    function GetFieldByName(const AFieldName: string): TField;
    function GetIsKeyFieldsEmpty: Boolean;
    function GetUniqueKeyValue(Delta: Integer = 0): Variant;
    function IsDataMode: Boolean; override;
    function IsSmartLoad: Boolean; override;
    procedure PostRecord; override;
    procedure PostValues; override;
    procedure SetFieldName(var AField: string; const AValue: string);
    procedure SetNodeParentValue(ANode: TcxDBTreeListNode; const AValue: Variant);
    procedure SyncFocused(ANode: TcxTreeListNode); override;
    procedure UpdateActive;
    procedure UpdateFocused; override;
    procedure UpdateInternalFields; virtual;

    property DataLink: TcxTreeListDataLink read FDataLink;
    property DBKeyField: TField read FKeyField;
    property DBParentField: TField read FParentKeyField;
    property DBStateIndexField: TField read FStateIndexField;
    property DBImageIndexField: TField read FImageIndexField;
    property IsKeyFieldsEmpty: Boolean read GetIsKeyFieldsEmpty;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Cancel; override;
    procedure CreateAllItems; virtual;
    procedure Edit; override;
    procedure FocusControl(AItemIndex: Integer; var Done: Boolean); override;
    function LocateByKey(const AKeyValue: Variant): Boolean;
    function SetEditValue(AItemIndex: Integer; const AValue: Variant;
      AEditValueSource: TcxDataEditValueSource): Boolean; override;

    property DataSet: TDataSet read GetDataSet;
    property TreeList: TcxCustomDBTreeList read GetTreeList;
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ImageIndexField: string read FImageIndexFieldName write SetImageIndexFieldName;
    property ParentField: string read FParentKeyFieldName write SetParentKeyFieldName;
    property KeyField: string read FKeyFieldName write SetKeyFieldName;
    property StateIndexField: string read FStateIndexFieldName write SetStateIndexFieldName;
  end;

  { TcxDBTreeListDefaultValuesProvider }

  TcxDBTreeListDefaultValuesProvider = class(TcxCustomDBEditDefaultValuesProvider)
  public
    function IsDisplayFormatDefined(AIsCurrencyValueAccepted: Boolean): Boolean; override;
  end;

  { TcxDBItemDataBinding }

  TcxDBItemDataBinding = class(TcxCustomItemDataBinding, IUnknown)
  private
    FField: TField;
    FFieldName: string;
    function GetDataController: TcxDBTreeListDataController;
    function GetDefaultValuesProviderProperty: TcxDBTreeListDefaultValuesProvider;
    function GetFieldName: string;
    function GetTreeList: TcxCustomDBTreeList;
    procedure SetFieldName(const AValue: string);
  protected
    procedure Changed; virtual;
    function DefaultRepositoryItem: TcxEditRepositoryItem; override;
    function GetDefaultCaption: string; override;
    function GetDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass; override;
    function GetValueTypeClass: TcxValueTypeClass; override;
    procedure Init; override;
    procedure InitializeField;
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;

    property DefaultValuesProvider: TcxDBTreeListDefaultValuesProvider read GetDefaultValuesProviderProperty;
  public
    procedure Assign(Source: TPersistent); override;

    property DataController: TcxDBTreeListDataController read GetDataController;
    property Field: TField read FField;
    property TreeList: TcxCustomDBTreeList read GetTreeList;
  published
    property FieldName: string read GetFieldName write SetFieldName;
  end;

  { TcxDBTreeListColumn }

  TcxDBTreeListColumn = class(TcxTreeListColumn)
  private
    function GetDataBinding: TcxDBItemDataBinding;
    function GetField: TField;
    procedure SetDataBinding(Value: TcxDBItemDataBinding);
  protected
    procedure AssignValueFromField(ANode: TcxTreeListNode);
    function GetDataBindingClass: TcxItemDataBindingClass; override;
    function GetEditValue: Variant; override;
    function GetIsCurrency: Boolean; override;
    function GetIsTextStored: Boolean; override;

    property Field: TField read GetField;
  published
    property DataBinding: TcxDBItemDataBinding read GetDataBinding write SetDataBinding;
  end;

  { TcxDBTreeListOptionsData }

  TcxDBTreeListOptionsData = class(TcxVirtualTreeListOptionsData)
  private
    FAutoCalcKeyValue: Boolean;
    FSmartRefresh: Boolean;
    FSyncMode: Boolean;
    function GetTreeList: TcxCustomDBTreeList;
    procedure SetSmartRefresh(AValue: Boolean);
    procedure SetSyncMode(AValue: Boolean);
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;

    property TreeList: TcxCustomDBTreeList read GetTreeList;
  published
    property AutoCalcKeyValue: Boolean read FAutoCalcKeyValue write FAutoCalcKeyValue default False;
    property SmartRefresh: Boolean read FSmartRefresh write SetSmartRefresh default False;
    property SyncMode: Boolean read FSyncMode write SetSyncMode default True;
    property SmartLoad;
  end;

  { TcxDBTreeListLoader }

  TcxDBTreeListLoader = class(TcxTreeListStructureLoader)
  private
    FDataSetBookmark: TObject;
    function GetDataController: TcxDBTreeListDataController;
    function GetDataSet: TDataSet;
    function GetTreeList: TcxCustomDBTreeList;
    function GetKeyField: TField;
    function GetKeyFieldName: string;
    function GetParentKeyField: TField;
    function GetParentKeyFieldName: string;
  protected
    HasChildren: TList;
    procedure AssignValues(ANode: TcxTreeListNode); override;
    procedure DoLoad(ALoadingNode: TcxTreeListNode); override;
    function FindLoadedNode(const AParentValue: Variant; var AIndex: Integer): Boolean;
    function FindNode(var ANode: TcxDBTreeListNode; const AValue: Variant): Boolean;
    function GetImageIndex(ANode: TcxTreeListNode; AIndexType: TcxTreeListImageIndexType): Integer; override;
    function GetImageIndexAsInteger(AField: TField): Integer;
    function IsChildrenExist(ANode: TcxTreeListNode): Boolean; override;
    function IsExistKeyRoot(AParentValue: Variant): Boolean; virtual;
    procedure LoadLevel(ANode: TcxDBTreeListNode; const AParentValue: Variant; ANewNodes: TList);
    procedure LoadLevelBack(AParentValue: Variant);
    function LoadValues(const AKeyValue, AParentKeyValue: Variant): TcxDBTreeListNode;
    procedure RestorePos; override;
    procedure SavePos; override;
  public
    constructor Create(AOwner: TcxDataTreeListDataController); override;
    destructor Destroy; override;
    procedure Load(ANode: TcxTreeListNode); override;

    property DataController: TcxDBTreeListDataController read GetDataController;
    property DataSet: TDataSet read GetDataSet;
    property KeyField: TField read GetKeyField;
    property KeyFieldName: string read GetKeyFieldName;
    property ParentKeyField: TField read GetParentKeyField;
    property ParentKeyFieldName: string read GetParentKeyFieldName;
    property TreeList: TcxCustomDBTreeList read GetTreeList;
  end;

  { TcxCustomDBTreeList }

  TcxDBTreeListGetUniqueKeyValueEvent = procedure(Sender: TcxCustomDBTreeList; var KeyValue: Variant) of object;
  TcxDBTreeListInitInsertingRecordEvent = procedure(Sender: TcxCustomDBTreeList; AFocusedNode: TcxDBTreeListNode; var AHandled: Boolean) of object;

  TcxCustomDBTreeList = class(TcxCustomDataTreeList)
  private
    FDataBusy: Boolean;
    FDataLocate: Boolean;
    FIsRefresh: Boolean;
    FIsRefreshValues: Boolean; 
    FRootValue: Variant;
    FUpdatingNode: TcxDBTreeListNode;
    FOnGetUniqueKeyValue: TcxDBTreeListGetUniqueKeyValueEvent;
    FOnInitInsertingRecord: TcxDBTreeListInitInsertingRecordEvent;
    function GetDataController: TcxDBTreeListDataController;
    function GetDataSet: TDataSet;
    function GetLoader: TcxDBTreeListLoader;
    function GetOptionsData: TcxDBTreeListOptionsData;
    procedure SetDataController(AValue: TcxDBTreeListDataController);
    procedure SetOptionsData(AValue: TcxDBTreeListOptionsData);
    procedure SetRootValue(const AValue: Variant);
  protected
    procedure AssignData(ASource: TcxCustomTreeList); override;
    procedure CreateAllItems; override;
    function CreateNode: TcxTreeListNode; override;
    procedure DataChanged; override;
    procedure DataModeChanged; override;
    procedure DoClear; override;
    procedure DoDeleteNode(ANode: TcxTreeListNode); override;
    procedure DeleteNodes(AList: TList); override;
    function DoInitInsertingNode(ANode: TcxDBTreeListNode): Boolean; virtual;
    procedure DoMoveTo(AttachNode: TcxTreeListNode;
      AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean); override;
    function FindLoadedNodeByKeyValue(const AValue: Variant): TcxDBTreeListNode;
    procedure FindNodeById;
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetOptionsDataClass: TcxControlOptionsDataClass; override;
    function GetTreeListColumnClass: TcxTreeListColumnClass; override;
    procedure InitializeFields; override;
    function InsertNode(ARelative: TcxTreeListNode; IsAppend: Boolean): Boolean; override;
    procedure InternalInsertNode(IsAppend: Boolean);
    function IsAutoCalcKeyValue: Boolean;
    function IsDataSettingsValid: Boolean; override;
    function IsNodeInserting(ANode: TcxTreeListNode): Boolean; override;
    function IsTreeListLocked: Boolean; override;
    procedure RefreshTree;
    procedure LoadListByID(const AKeyValue: Variant; AList: TList);
    procedure LoadListByNode(ANode: TcxDBTreeListNode; AList: TList);
    procedure RefreshFields; override;
    function SupportCreateAllItems: Boolean; override;
    procedure UpdateFocusedNode(AColumn: TcxTreeListColumn); override;

    property DataBusy: Boolean read FDataBusy write FDataBusy;
    property DataController: TcxDBTreeListDataController read GetDataController write SetDataController;
    property DataLocate: Boolean read FDataLocate write FDataLocate;
    property DataSet: TDataSet read GetDataSet;
    property IsRefresh: Boolean read FIsRefresh write FIsRefresh;
    property IsRefreshValues: Boolean read FIsRefreshValues write FIsRefreshValues; 
    property Loader: TcxDBTreeListLoader read GetLoader;
    property OptionsData: TcxDBTreeListOptionsData read GetOptionsData write SetOptionsData;
    property RootValue: Variant read FRootValue write SetRootValue;
    property UpdatingNode: TcxDBTreeListNode read FUpdatingNode write FUpdatingNode;
    property OnGetUniqueKeyValue: TcxDBTreeListGetUniqueKeyValueEvent read FOnGetUniqueKeyValue write FOnGetUniqueKeyValue;
    property OnInitInsertingRecord: TcxDBTreeListInitInsertingRecordEvent read FOnInitInsertingRecord write FOnInitInsertingRecord;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function FindNodeByKeyValue(const AKeyValue: Variant; AStartNode: TcxTreeListNode = nil;
      AExpandedOnly: Boolean = False; AForward: Boolean = True): TcxDBTreeListNode;
  end;

  { TcxDBTreeList }

  TcxDBTreeList = class(TcxCustomDBTreeList)
  public
    property Customizing;
    property ColumnCount;
    property Columns;
    property FocusedColumn;
    property FocusedNode;
    property HitTest;
    property IsEditing;
    property SelectionCount;
    property Selections;
    property Sorted;
    property SortedColumnCount;
    property SortedColumns;
    property TopVisibleNode;
    property VisibleColumnCount;
    property VisibleColumns;
    property VisibleCount;
  published
    property Align;
    property Anchors;
    property Bands;
    property BorderStyle;
    property Constraints;
    property Cursor;
    property DataController; 
    property DefaultLayout;
    property DefaultRowHeight;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property Images;
    property LookAndFeel;
    property OptionsBehavior;
    property OptionsCustomizing;
    property OptionsData;
    property OptionsSelection;
    property OptionsView;
    property ParentColor;
    property ParentFont;
    property PopupMenu;
    property PopupMenus;
    property Preview;
    property RootValue;
    property StateImages;
    property Styles;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnAfterSummary;
    property OnBandHeaderClick;
    property OnBandSizeChanged;
    property OnBeginDragNode;
    property OnCanFocusNode;
    property OnCanResize;
    property OnCanSelectNode;
    property OnChange;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnColumnHeaderClick;
    property OnColumnSizeChanged;
    property OnCompare;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnCustomDrawBackgroundCell;
    property OnCustomDrawBandCell;
    property OnCustomDrawBandHeaderCell;
    property OnCustomDrawDataCell;
    property OnCustomDrawFooterCell;
    property OnCustomDrawHeaderCell;
    property OnCustomDrawIndentCell;
    property OnCustomDrawIndicatorCell;
    property OnCustomDrawPreviewCell;
    property OnCustomizationFormVisibleChanged;
    property OnDataChanged;
    property OnDblClick;
    property OnDeletion;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    property OnEditValueChanged;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanded;
    property OnExpanding;
    property OnFocusedColumnChanged;
    property OnFocusedNodeChanged;
    property OnGetCellHint;
    property OnGetDragDropText;
    property OnGetLevelImages;
    property OnGetNodeHeight;
    property OnGetNodeImageIndex;
    property OnGetNodePreviewHeight;
    property OnGetSiteInfo;
    property OnGetStoredProperties;
    property OnGetStoredPropertyValue;
    property OnGetUniqueKeyValue;
    property OnHotTrackNode;
    property OnInitEdit;
    property OnInitInsertingRecord;
    property OnInitStoredObject;
    property OnIsGroupNode;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLayoutChanged;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnMoveTo;
    property OnNodeChanged;
    property OnResize;
    property OnSelectionChanged;
    property OnSetStoredPropertyValue;
    property OnSorted;
    property OnSorting;
    property OnStartDock;
    property OnStartDrag;
    property OnSummary;
    property OnTopRecordIndexChanged;
    property OnUnDock;
    property PopupMenusEvents;
    property StylesEvents;
  end;

implementation

uses Math;

type
  TDataSetAccess = class(TDataSet);

  TDataSetBookmark = class
  public
    SaveActiveRecord: Integer;
    SaveBOF: Boolean;
    SaveBookmark: TcxBookMark;
    SaveEOF: Boolean;
  end;

function cxDataSetCreateBookmark(ADataSet: TDataSet): TDataSetBookmark;
begin
  Result := TDataSetBookmark.Create;
  with TDataSetAccess(ADataSet) do
  begin
    if BookmarkAvailable then
      Result.SaveBookmark := Bookmark;
    Result.SaveActiveRecord := ActiveRecord;
    Result.SaveBOF := BOF;
    Result.SaveEOF := EOF;
  end;
end;

procedure cxDataSetRestoreBookmark(ADataSet: TDataSet; var ABookmark: TDataSetBookmark);
begin
  try
    with TDataSetAccess(ADataSet) do
    begin
      if (Length(ABookmark.SaveBookmark) > 0) and BookmarkValid(TBookmark(ABookmark.SaveBookmark)) then
      try
        Bookmark := ABookmark.SaveBookmark;
        if ActiveRecord > ABookmark.SaveActiveRecord then
        begin
          MoveBy(BufferCount - ActiveRecord - 1 + ActiveRecord - ABookmark.SaveActiveRecord);
          MoveBy(ABookmark.SaveActiveRecord - BufferCount + 1);
        end
        else
          if ActiveRecord < ABookmark.SaveActiveRecord then
          begin
            MoveBy(-ActiveRecord + ActiveRecord - ABookmark.SaveActiveRecord);
            MoveBy(ABookmark.SaveActiveRecord);
          end;
        if ABookmark.SaveBOF and not BOF then Prior;
        if ABookmark.SaveEOF and not EOF then Next;
      except
        on EDatabaseError do;
      end;
    end;
  finally
    FreeAndNil(ABookmark);
  end;
end;

//
function cxCompareByKeyValue(ANode1, ANode2: TcxDBTreeListNode): Integer;
begin
  Result := VarCompare(ANode1.KeyValue, ANode2.KeyValue);
end;

function cxCompareByParentKey(ANode1, ANode2: TcxDBTreeListNode): Integer;
begin
  Result := VarCompare(ANode1.ParentKeyValue, ANode2.ParentKeyValue);
end;

function cxFindKey(ANode: TcxDBTreeListNode; AKey: PVariant): Boolean;
begin
  Result := VarCompare(ANode.KeyValue, AKey^) = 0;
end;

{ TcxDBTreeListNode }

procedure TcxDBTreeListNode.RestoreStateAfterRefresh;
begin
  if (Count > 0) and (nsSaveExpanded in State) then
    Exclude(State, nsCollapsed);
  Exclude(State, nsSaveExpanded);
end;

procedure TcxDBTreeListNode.SaveStateBeforeRefresh;
begin
  if Expanded then
    Include(State, nsSaveExpanded);
end;

{ TcxTreeListDataLink }

constructor TcxTreeListDataLink.Create(
  ADataController: TcxDBTreeListDataController);
begin
  FDataController := ADataController;
end;

procedure TcxTreeListDataLink.ActiveChanged;
begin
  TreeList.InternalClearAll; 
  TreeList.InitializeFields;
  if Active then
    TreeList.FullRefresh;
  TreeList.LayoutChanged;
end;

procedure TcxTreeListDataLink.DataSetChanged;
begin
  TreeList.ImageChanged;
  if DataSet.State <> dsInsert then
    TreeList.UpdatingNode := nil;
  if DataLocate then
  begin
    TreeList.BeginUpdate;
    try
      TreeList.UpdateFocusedNode(nil);
    finally
      TreeList.EndUpdate;
    end;
    TreeList.DataLocate := False;
    Exit;
  end;
  if DataBusy or TreeList.IsRefresh or (DataSet.State = dsEdit) or (DataSet.State = dsSetKey) then Exit;
  if not DataController.IsKeyFieldsEmpty and (DataSet.State = dsInsert) then
  begin
    TreeList.InternalInsertNode(DataSet.EOF);
    Exit;
  end;
  TreeList.RefreshTree;
{  if DataController.NodesCount = 0 then
    TreeList.LayoutChanged;}
  FModified := False;
end;

procedure TcxTreeListDataLink.DataSetScrolled(Distance: Integer);
begin
  DataController.DataScrolled(Distance);
end;

procedure TcxTreeListDataLink.FocusControl(Field: TFieldRef);
var
  I: Integer;
  ADone: Boolean;
begin
  if not Assigned(Field) or not Assigned(Field^) then Exit;
  ADone := False;
  for I := 0 to TreeList.ColumnCount - 1 do
    if TcxDBTreeListColumn(TreeList.Columns[I]).DataBinding.Field = Field^ then
    begin
      DataController.FocusControl(TcxDBTreeListColumn(TreeList.Columns[I]).ItemIndex, ADone);
      if ADone then Break;
    end;
  if ADone then 
    Field^ := nil;
end;

procedure TcxTreeListDataLink.LayoutChanged;
begin
  DataSetChanged;
end;

procedure TcxTreeListDataLink.RecordChanged(Field: TField);
var
  I: Integer;
  AColumn: TcxTreeListColumn;
begin
  if not (DataSet.State in dsEditModes) or TreeList.OptionsData.SmartRefresh then Exit;
  TreeList.BeginUpdate;
  try
    if Field = nil then
      TreeList.UpdateFocusedNode(nil)
    else
      for I := 0 to TreeList.ColumnCount - 1 do
      begin
        AColumn := TreeList.Columns[I];
        if TcxDBTreeListColumn(AColumn).DataBinding.Field = Field then
          TreeList.UpdateFocusedNode(AColumn);
      end;
  finally
    TreeList.EndUpdate;
  end; 
end;

procedure TcxTreeListDataLink.UpdateData;
begin
  TreeList.UpdateFocusedNode(nil);
end;

function TcxTreeListDataLink.GetDataBusy: Boolean;
begin
  Result := TreeList.DataBusy;
end;

function TcxTreeListDataLink.GetDataLocate: Boolean;
begin
  Result := TreeList.DataLocate;
end;

function TcxTreeListDataLink.GetOptionsData: TcxDBTreeListOptionsData;
begin
  Result := TreeList.OptionsData;
end;

function TcxTreeListDataLink.GetTreeList: TcxCustomDBTreeList;
begin
  Result := DataController.TreeList;
end;

{ TcxDBTreeListDataController }

constructor TcxDBTreeListDataController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := CreateDataLink;
end;

destructor TcxDBTreeListDataController.Destroy;
begin
  FDataLink.Free;
  inherited Destroy;
end;

procedure TcxDBTreeListDataController.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxDBTreeListDataController then
  begin
    DataSource := TcxDBTreeListDataController(Source).DataSource;
    ParentField := TcxDBTreeListDataController(Source).ParentField;
    KeyField := TcxDBTreeListDataController(Source).ParentField;
    ImageIndexField := TcxDBTreeListDataController(Source).ImageIndexField;
    StateIndexField := TcxDBTreeListDataController(Source).StateIndexField;
  end;
end;

procedure TcxDBTreeListDataController.Cancel;
begin
  inherited Cancel;
  if DataSet <> nil then
    DataSet.Cancel;
end;

procedure TcxDBTreeListDataController.CreateAllItems;
var
  I: Integer;
  ABand: TcxTreeListBand;
  AColumn: TcxDBTreeListColumn;
begin
  if (DataSet = nil) or (DataSet.FieldCount = 0) then Exit;
  TreeList.SetGlassCursor;
  try
    TreeList.BeginUpdate;
    try
      ABand := TreeList.GetDefaultColumnContainer;
      for I := 0 to DataSet.FieldCount - 1 do
      begin
        AColumn := TcxDBTreeListColumn(TreeList.CreateColumn(ABand));
        AColumn.DataBinding.FieldName := DataSet.Fields[I].FieldName;
        AColumn.Visible := DataSet.Fields[I].Visible;
      end;
    finally
      TreeList.EndUpdate;
    end;
  finally
    TreeList.RestoreCursor;
    TreeList.Modified;
  end;
end;

procedure TcxDBTreeListDataController.Edit;
begin
  if (DataSet = nil) or (DataSet.State = dsEdit) then Exit;
  if CanLocateByNode(nil, TcxDBTreeListNode(TreeList.FocusedNode)) then
    LocateByKey(TcxDBTreeListNode(TreeList.FocusedNode).KeyValue);
  DataLink.Edit;
  if DataSet.State <> dsEdit then Exit;
  inherited Edit;
end;

procedure TcxDBTreeListDataController.FocusControl(
  AItemIndex: Integer; var Done: Boolean);
begin
  TcxDBTreeListColumn(GetItem(AItemIndex)).Editing := True;
  Done := TcxDBTreeListColumn(GetItem(AItemIndex)).Editing;
end;

function TcxDBTreeListDataController.LocateByKey(
  const AKeyValue: Variant): Boolean;
var
  ANode: TcxDBTreeListNode;
begin
  Result := False;
  if Datalink.Active then
  begin
    TreeList.DataBusy := not (DataSet.State in dsEditModes);
    TreeList.DataLocate := True;
    if (EditingNode <> nil) and not IsValueChanged then
      Cancel;
    Result := DataSet.Locate(KeyField, AKeyValue, []);
    if Result then
    begin
      ANode := TreeList.FindNodeByKeyValue(GetFieldValue(DBKeyField));
      if ANode <> nil then
      begin
        ANode.Focused := True;
        ANode.MakeVisible;
      end;
    end;
    TreeList.DataLocate := False;
    TreeList.DataBusy := False; 
  end;
end;

function TcxDBTreeListDataController.SetEditValue(AItemIndex: Integer;
  const AValue: Variant; AEditValueSource: TcxDataEditValueSource): Boolean;
var
  AColumn: TcxDBTreeListColumn;
begin
  Result := inherited SetEditValue(AItemIndex, AValue, AEditValueSource);
  AColumn := TcxDBTreeListColumn(TreeList.ContainerList[AItemIndex]);
  if (DataSet.State in [dsInsert, dsEdit]) and (AColumn.Field <> nil) and (EditingNode <> nil) then
  begin
    if (AEditValueSource = evsText) or Assigned(AColumn.Field.OnSetText) then
      AColumn.Field.Text := VarToStr(AValue)
    else
       SetFieldValue(AColumn.Field, AValue);
  end;
end;

procedure TcxDBTreeListDataController.UpdateInternalFields;
begin
  FKeyField := GetFieldByName(KeyField);
  FParentKeyField := GetFieldByName(ParentField);
  FImageIndexField := GetFieldByName(ImageIndexField);
  FStateIndexField := GetFieldByName(StateIndexField);
end;

function TcxDBTreeListDataController.CanLocateByNode(AOldNode, ANode: TcxDBTreeListNode): Boolean;
begin
  Result := TreeList.OptionsData.SyncMode and  not IsKeyFieldsEmpty and
    (ANode <> nil) and not TreeList.DataBusy and not TreeList.IsRefresh;
  if not Result or ((AOldNode = ANode) and (GetFieldValue(DBKeyField) = ANode.KeyValue)) then Exit;
  Result := not ((ANode = TreeList.UpdatingNode) and
    DataLink.Active and (DataLink.DataSet.State = dsInsert));
end;

function TcxDBTreeListDataController.CreateDataLink: TcxTreeListDataLink;
begin
  Result := TcxTreeListDataLink.Create(Self);
end;

function TcxDBTreeListDataController.CreateLoader: TcxTreeListStructureLoader;
begin
  Result := TcxDBTreeListLoader.Create(Self);
end;

procedure TcxDBTreeListDataController.DataScrolled(ADistance: Integer);
var
  ANode: TcxTreeListNode;
begin
  UpdateActive;
  if IsSmartLoad and (ADistance <> 0) and not IsKeyFieldsEmpty then
  begin
    ANode := TreeList.FindNodeByKeyValue(GetFieldValue(DBKeyField));
    if ANode <> nil then
      ANode.MakeVisible;
  end;
//  inherited DataScrolled(ADistance);
end;

procedure TcxDBTreeListDataController.DeleteNode(ANode: TcxTreeListNode);
var
  I: Integer;
  AList: TList;
begin
  DataSet.DisableControls;
  try
    if not ANode.HasChildren then
    begin
      if LocateByKey(TcxDBTreeListNode(ANode).KeyValue) then
        DataSet.Delete
    end
    else
    begin
        AList := TList.Create;
        try
          if not TreeList.OptionsData.SmartLoad then
            TreeList.LoadListByNode(TcxDBTreeListNode(ANode), AList)
          else
            TreeList.LoadListByID(TcxDBTreeListNode(ANode).KeyValue, AList);
          // Delete Nodes
          for I := AList.Count - 1 downto 0 do
            if LocateByKey(PVariant(AList[I])^) then
              DataSet.Delete;
        finally
          for I := 0 to AList.Count - 1 do
            Dispose(AList[I]);
          AList.Free;
        end;
    end;
    inherited DeleteNode(ANode);
  finally
    DataSet.EnableControls;
  end;
end;

procedure TcxDBTreeListDataController.DestroyInternalFields;
begin
  FKeyField.Free;
  FParentKeyField.Free;
  FImageIndexField.Free;
  FStateIndexField.Free;
end;

procedure TcxDBTreeListDataController.DoCopyTo(AttachNode: TcxDBTreeListNode;
  AttachMode: TcxTreeListNodeAttachMode; ANodes: TList);

type
  PNodeBuffer =^TNodeBuffer;
  TNodeBuffer = record
    Key: Variant;
    Buffer: Variant;
    Items: TList;
  end;

var
  F: TField;
  I: Integer;
  AFieldList, BufferList: TList;
  AKeyField, AParentField: TField;
  NewParentValue, KeyValue, Delta: Variant;

  function LoadBufferValues(const AKeyValue: Variant): PNodeBuffer;
  var
    I: Integer;
  begin
    New(Result);
    Result^.Items := nil;
    Result^.Key := AKeyValue;
    Result^.Buffer := VarArrayCreate([0, AFieldList.Count - 1], varVariant);
    for I := 0 to AFieldList.Count - 1 do
      Result^.Buffer[I] := GetFieldValue(TField(AFieldList[I]));
  end;

  procedure LoadSubItems(PBuffer: PNodeBuffer);
  var
    AParentValue: Variant;
    I: Integer;
  begin
    with DataSet do
    begin
      AParentValue := PBuffer^.Key;
      if Locate(ParentField, AParentValue, []) then
      begin
        PBuffer^.Items := TList.Create;
        while not EOF and (GetFieldValue(AParentField) = AParentValue) do
        begin
          PBuffer^.Items.Add(LoadBufferValues(GetFieldValue(AKeyField)));
          Next;
        end;
        for I := 0 to PBuffer^.Items.Count - 1 do
          LoadSubItems(PNodeBuffer(PBuffer^.Items[I]));
      end;
    end;
  end;

  procedure AddNewNode(PBuffer: PNodeBuffer; const AParentValue: Variant);
  var
    I: Integer;
    Key: Variant;
  begin
    with DataSet do
    begin
      Insert;
      if AKeyField.IsNull and TreeList.OptionsData.AutoCalcKeyValue then
      begin
        SetFieldValue(AKeyField, GetUniqueKeyValue(Delta));
        Inc(Delta);
      end;
      SetFieldValue(AParentField, AParentValue);
      for I := 0 to AFieldList.Count - 1 do
        SetFieldValue(TField(AFieldList[I]), PBuffer^.Buffer[I]);
      Post;
      Key := GetFieldValue(AKeyField);
      // add children
      if PBuffer^.Items <> nil then
        for I := 0 to PBuffer^.Items.Count - 1 do
          AddNewNode(PBuffer^.Items[I], Key);
    end;
  end;

  procedure FreeBuffer(PBuffer: PNodeBuffer);
  var
    I: Integer;
    L: TList;
  begin
    L := PBuffer^.Items;
    if L <> nil then
    begin
      for I := 0 to L.Count - 1 do
        FreeBuffer(L[I]);
      FreeAndNil(L);
    end;
    Dispose(PBuffer);
  end;

begin
  AParentField := DBParentField;
  AKeyField := DBKeyField;
  with DataSet do
  begin
    if AttachMode in [tlamAddChild, tlamAddChildFirst] then
      NewParentValue := AttachNode.KeyValue
    else
      NewParentValue := AttachNode.ParentKeyValue;
    DisableControls;
    try
      // copy drag nodes
      AFieldList := TList.Create;
      try
        // create Field List
        for I := 0 to FieldCount - 1 do
        begin
          F := Fields[I];
          if F.FieldKind = fkLookup then
            F := FindField(F.KeyFields)
          else
          if (F = AKeyField) or (F = AParentField) or (F.FieldKind <> fkData) then
            F := nil;
          if Assigned(F) and F.CanModify then
            AFieldList.Add(F);
        end;
        if AFieldList.Count > 0 then
        begin
          // sort and remove duplicates
          ANodes.Sort(@cxCompareByParentKey);
          for I := ANodes.Count - 1 downto 1 do
            if TcxTreeListNode(ANodes[I]).HasAsParent(TcxTreeListNode(ANodes[I - 1])) then
              ANodes.Delete(I);
          // make Buffer List
          BufferList := TList.Create;
          try
            for I := 0 to ANodes.Count - 1 do
            begin
              KeyValue := TcxDBTreeListNode(ANodes[I]).KeyValue;
              if Locate(KeyField, KeyValue, []) then
              begin
                BufferList.Add(LoadBufferValues(KeyValue));
                LoadSubItems(BufferList[I]);
              end;
            end;
            // create new nodes
            Delta := 0;
            for I := 0 to BufferList.Count - 1 do
              AddNewNode(BufferList[I], NewParentValue);
          finally
            for I := 0 to BufferList.Count - 1 do
              FreeBuffer(PNodeBuffer(BufferList[I]));
            FreeAndNil(BufferList);
          end;
        end;
      finally
        FreeAndNil(AFieldList);
      end;
    finally
      EnableControls;
    end;
  end; 
end;

procedure TcxDBTreeListDataController.DoInitInsertingNode(
  ANode: TcxTreeListNode);
var
  AInit: Boolean;
begin
  AInit := TreeList.DoInitInsertingNode(TcxDBTreeListNode(ANode));
  if not AInit and TreeList.IsAutoCalcKeyValue then
    SetFieldValue(DBKeyField, GetUniqueKeyValue(0))
  else
    if AInit then
    begin
      SetFieldValue(DBKeyField, TcxDBTreeListNode(ANode).KeyValue);
      SetFieldValue(DBParentField, TcxDBTreeListNode(ANode).ParentKeyValue);
    end;
  TreeList.Loader.AssignValues(ANode);
end;

function TcxDBTreeListDataController.GetFieldByName(
  const AFieldName: string): TField;
begin
  Result := nil;
  if DataSet <> nil then 
    Result := DataSet.FindField(AFieldName);
end;

function TcxDBTreeListDataController.GetIsKeyFieldsEmpty: Boolean;
begin
  Result := not Assigned(DBParentField) or not Assigned(DBKeyField);
end;

function TcxDBTreeListDataController.GetUniqueKeyValue(
  Delta: Integer = 0): Variant;
var
  AList: TList;
begin
  Result := Null;
  if Assigned(TreeList.FOnGetUniqueKeyValue) then
    TreeList.FOnGetUniqueKeyValue(TreeList, Result)
  else
    if not TreeList.OptionsData.SmartLoad then
    try
      AList := TcxDBTreeListLoader(Loader).CloneList(TreeList.AbsoluteItemsList);
      try
        if not IsKeyFieldsEmpty and (AList.Count > 0) then
        begin
          AList.Sort(@cxCompareByKeyValue);
          Result := TcxDBTreeListNode(AList.Last).KeyValue;
        end;
      finally
        AList.Free;
      end;
      if VarType(Result) in [varSmallint, varInteger, varSingle, varDouble, varCurrency] then
        Result := Result + 1 + Delta
      else
        Result := 0;
    except
      Result := Null;
    end;
end;

function TcxDBTreeListDataController.IsDataMode: Boolean;
begin
  Result := True; 
end;

function TcxDBTreeListDataController.IsSmartLoad: Boolean;
begin
  Result := TreeList.OptionsData.SmartLoad;
end;

procedure TcxDBTreeListDataController.PostRecord;
begin
  if DataSet.State in dsEditModes then
    DataSet.Post;
end;

procedure TcxDBTreeListDataController.PostValues;
begin
end;

procedure TcxDBTreeListDataController.SetFieldName(
  var AField: string; const AValue: string);
begin
  if AField <> AValue then
  begin
    AField := AValue;
    TreeList.FullRefresh;
  end;
end;

procedure TcxDBTreeListDataController.SetNodeParentValue(
  ANode: TcxDBTreeListNode; const AValue: Variant);
begin
  if DataSet.Locate(KeyField, ANode.KeyValue, []) then
  begin
    DataSet.Edit;
    ANode.ParentKeyValue := AValue;
    SetFieldValue(DBParentField, AValue);
    DataSet.Post;
    if TreeList.OptionsData.SmartRefresh then
      Load(ANode);
  end;
end;

procedure TcxDBTreeListDataController.SyncFocused(ANode: TcxTreeListNode);
begin
  if not CanLocateByNode(TcxDBTreeListNode(TreeList.Controller.PrevFocusedNode), TcxDBTreeListNode(ANode)) then Exit;
  try
    LocateByKey((ANode as TcxDBTreeListNode).KeyValue);
  finally
    TreeList.DataLocate := False;
    TreeList.DataBusy := False;
  end;
end;

procedure TcxDBTreeListDataController.UpdateActive;
begin
  if not (Datalink.Active and Datalink.DataSet.Active) or TreeList.IsLoading then Exit;
  TreeList.FindNodeById;
  TreeList.UpdateData;
end;

procedure TcxDBTreeListDataController.UpdateFocused;
var
  ANode: TcxTreeListNode;
begin
  ANode := TreeList.FindLoadedNodeByKeyValue(GetFieldValue(DBKeyField));
  if TreeList.UpdatingNode <> nil then
    ANode := TreeList.UpdatingNode;
  if ANode <> nil then
    ANode.Focused := True;
end;

function TcxDBTreeListDataController.GetDataSet: TDataSet;
begin
  if DataSource <> nil then
    Result := DataSource.DataSet
  else
    Result := nil;
end;

function TcxDBTreeListDataController.GetDataSource: TDataSource;
begin
  Result := DataLink.DataSource;
end;

function TcxDBTreeListDataController.GetTreeList: TcxCustomDBTreeList;
begin
  Result := TcxCustomDBTreeList(GetOwner)
end;

procedure TcxDBTreeListDataController.SetDataSource(AValue: TDataSource);
begin
  DataLink.DataSource := AValue;
  TreeList.DataChanged;
end;

procedure TcxDBTreeListDataController.SetImageIndexFieldName(
  const AValue: string);
begin
  SetFieldName(FImageIndexFieldName, AValue);
end;

procedure TcxDBTreeListDataController.SetKeyFieldName(const AValue: string);
begin
  SetFieldName(FKeyFieldName, AValue);
end;

procedure TcxDBTreeListDataController.SetParentKeyFieldName(
  const AValue: string);
begin
  SetFieldName(FParentKeyFieldName, AValue);
end;

procedure TcxDBTreeListDataController.SetStateIndexFieldName(
  const AValue: string);
begin
  SetFieldName(FStateIndexFieldName, AValue);
end;

{ TcxDBTreeListDefaultValuesProvider }

function TcxDBTreeListDefaultValuesProvider.IsDisplayFormatDefined(
  AIsCurrencyValueAccepted: Boolean): Boolean;
begin
  Result := TcxDBItemDataBinding(Owner).IsDisplayFormatDefined(AIsCurrencyValueAccepted);
end;

{ TcxDBItemDataBinding }

procedure TcxDBItemDataBinding.Assign(Source: TPersistent);
begin
  if Source is TcxDBItemDataBinding then
    FieldName := TcxDBItemDataBinding(Source).FieldName
  else
    inherited Assign(Source);
end;

procedure TcxDBItemDataBinding.Changed;
begin
  TreeList.AddDataChanges([dtcStructure]);
  TreeList.LayoutChanged;
end;

function TcxDBItemDataBinding.DefaultRepositoryItem: TcxEditRepositoryItem;
begin
  Result := GetDefaultEditDBRepositoryItems.GetItemByField(Field);
end;

function TcxDBItemDataBinding.GetDefaultCaption: string;
begin
  if Field <> nil then 
    Result := Field.DisplayName
  else
    Result := FieldName;
end;

function TcxDBItemDataBinding.GetDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
begin
  Result := TcxDBTreeListDefaultValuesProvider;
end;

function TcxDBItemDataBinding.GetValueTypeClass: TcxValueTypeClass;
begin
  Result := GetValueTypeClassByField(Field);
end;

procedure TcxDBItemDataBinding.Init;
begin
  InitializeField;
  DefaultValuesProvider.DataSource := DataController.DataSource;
  if DefaultValuesProvider.Field <> Field then
  begin
    DefaultValuesProvider.Field := Field;
    ValueTypeClassChanged;
  end;
  inherited Init;
end;

procedure TcxDBItemDataBinding.InitializeField;
begin
  FField := nil;
  if (DataController.DataSet <> nil) and DataController.DataLink.Active then
    FField := DataController.DataSet.FindField(FieldName)
end;

function TcxDBItemDataBinding._AddRef: Integer;
begin
  Result := -1;
end;

function TcxDBItemDataBinding._Release: Integer;
begin
  Result := -1;
end;

function TcxDBItemDataBinding.QueryInterface(
  const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := cxE_NOINTERFACE;
end;

function TcxDBItemDataBinding.GetDataController: TcxDBTreeListDataController;
begin
  Result := TcxDBTreeListDataController(inherited DataController);
end;

function TcxDBItemDataBinding.GetDefaultValuesProviderProperty: TcxDBTreeListDefaultValuesProvider;
begin
  Result := inherited DefaultValuesProvider as TcxDBTreeListDefaultValuesProvider;
end;

function TcxDBItemDataBinding.GetFieldName: string;
begin
  if Field <> nil then
    Result := Field.FieldName
  else
    Result := FFieldName;
  FFieldName := Result;  
end;

function TcxDBItemDataBinding.GetTreeList: TcxCustomDBTreeList;
begin
  Result := DataController.TreeList; 
end;

procedure TcxDBItemDataBinding.SetFieldName(const AValue: string);
begin
  if AValue <> FieldName then
  begin
    FFieldName := AValue;
    Changed;
  end;
end;

{ TcxDBTreeListOptionsData }

constructor TcxDBTreeListOptionsData.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FSyncMode := True;
end;

procedure TcxDBTreeListOptionsData.Assign(Source: TPersistent);
begin
  if Source is TcxDBTreeListOptionsData then
  begin
    AutoCalcKeyValue := TcxDBTreeListOptionsData(Source).AutoCalcKeyValue;
    SmartRefresh := TcxDBTreeListOptionsData(Source).SmartRefresh;
    SyncMode := TcxDBTreeListOptionsData(Source).SyncMode;
  end;
  inherited Assign(Source);
end;

function TcxDBTreeListOptionsData.GetTreeList: TcxCustomDBTreeList;
begin
  Result := GetOwner as TcxCustomDBTreeList
end;

procedure TcxDBTreeListOptionsData.SetSmartRefresh(AValue: Boolean);
begin
  if SmartRefresh <> AValue then
  begin
    FSmartRefresh := AValue;
    TreeList.DataModeChanged;
  end;
end;

procedure TcxDBTreeListOptionsData.SetSyncMode(AValue: Boolean);
begin
  if SyncMode <> AValue then
  begin
    FSyncMode := AValue;
    TreeList.DataModeChanged;
  end;
end;

{ TcxDBTreeListColumn }

procedure TcxDBTreeListColumn.AssignValueFromField(ANode: TcxTreeListNode);
var
  AText: string;
begin
  AText := '';
  if Field <> nil then
  begin
    DataController.SetNodeValue(ANode, ItemIndex, GetFieldValue(Field));
    if IsTextStored then
      AText := Field.DisplayText;
  end
  else
    DataController.SetNodeValue(ANode, ItemIndex, Null);
  if IsTextStored then
    TcxDataStorageHelper.SetDisplayText(TcxDBTreeListNode(ANode).Handle, ValueDef, AText);
end;

function TcxDBTreeListColumn.GetDataBindingClass: TcxItemDataBindingClass;
begin
  Result := TcxDBItemDataBinding;
end;

function TcxDBTreeListColumn.GetEditValue: Variant;
var
  AEditValueSource: TcxDataEditValueSource;
begin
  Result := Null;
  if Assigned(Field) then 
  begin
    AEditValueSource := PropertiesValue.GetEditValueSource(False);
    if AEditValueSource = evsText then
    begin
      if Field.IsNull and not Assigned(Field.OnGetText) then
        Result := Null
      else
        Result := Field.Text;
    end
    else
      if (AEditValueSource = evsKey) and (Field.KeyFields <> '') then
        Result := Field.DataSet.FieldValues[Field.KeyFields]
      else
        if not Field.IsNull then
          Result := Field.Value; // evsValue
  end
  else
    Result := inherited GetEditValue;
end;

function TcxDBTreeListColumn.GetIsCurrency: Boolean;
begin
  Result := (Field <> nil) and IsSimpleCurrencyField(Field);
end;

function TcxDBTreeListColumn.GetIsTextStored: Boolean;
begin
  Result := (Field <> nil) and IsFieldFormatted(Field,
    DataController.GetItemValueSource(ItemIndex) = evsText);
end;

function TcxDBTreeListColumn.GetDataBinding: TcxDBItemDataBinding;
begin
  Result := TcxDBItemDataBinding(inherited DataBinding);
end;

function TcxDBTreeListColumn.GetField: TField;
begin
  Result := DataBinding.Field;
end;

procedure TcxDBTreeListColumn.SetDataBinding(Value: TcxDBItemDataBinding);
begin
  DataBinding.Assign(Value);
end;

{ TcxDBTreeListLoader }

constructor TcxDBTreeListLoader.Create(AOwner: TcxDataTreeListDataController);
begin
  inherited Create(AOwner);
  HasChildren := TList.Create;
  Loaded := TList.Create;
end;

destructor TcxDBTreeListLoader.Destroy;
begin
  HasChildren.Free; 
  Loaded.Free;
  inherited Destroy;
end;

procedure TcxDBTreeListLoader.Load(ANode: TcxTreeListNode);
begin
  TreeList.DataBusy := True;
  try
    Loaded.Clear;
    HasChildren.Clear;
    Loaded.Count := TreeList.AbsoluteItemsList.Count;
    Move(TreeList.AbsoluteItemsList.List^, Loaded.List^, Loaded.Count * SizeOf(Pointer));
    Loaded.Sort(@cxCompareByKeyValue);
    if ANode = nil then
      Nodes := CloneList(Loaded);
    try
      DataSet.DisableControls;
      try
        inherited Load(ANode);
      finally
        DataSet.EnableControls;
        if Nodes <> nil then
        begin
          Nodes.Sort(@cxCompareByParentKey);
          InternalDelete(Nodes);
        end;
      end;
    finally
      FreeAndNil(Nodes);
    end;
  finally
    TreeList.DataBusy := False;
  end;
  TreeList.FindNodeById;
end;

procedure TcxDBTreeListLoader.AssignValues(ANode: TcxTreeListNode);
var
  I: Integer;
  APrevIsChanged: Boolean;
begin
  TreeList.IsRefreshValues := True;
  try
    APrevIsChanged := DataController.IsValueChanged;
    inherited AssignValues(ANode);
    for I := 0 to TreeList.ColumnCount - 1 do
      TcxDBTreeListColumn(TreeList.Columns[I]).AssignValueFromField(ANode);
    with DataController do
    begin
      if Assigned(DBImageIndexField) then
        TcxDBTreeListNode(ANode).FImageIndexes[tlitImageIndex] := GetImageIndexAsInteger(DBImageIndexField);
      if Assigned(DBStateIndexField) then
        TcxDBTreeListNode(ANode).FImageIndexes[tlitStateIndex] := GetImageIndexAsInteger(DBStateIndexField);
    end;
    TcxDBTreeListNode(ANode).KeyValue := GetFieldValue(KeyField);
    TcxDBTreeListNode(ANode).ParentKeyValue := GetFieldValue(ParentKeyField);
    DataController.IsValueChanged := APrevIsChanged or (not ANode.Inserting and (DataSet.State in dsEditModes));
  finally
     TreeList.IsRefreshValues := False;
  end;
end;

procedure TcxDBTreeListLoader.DoLoad(ALoadingNode: TcxTreeListNode);
var
  I, AIndex: Integer;
  ANode, APrev: TcxDBTreeListNode;
  AKeyValue, AParentKeyValue: Variant;
begin
  TreeList.ClearSelection;
  if IsLoadAllRecords then
  begin
    // Load From DataSet
    for I := 0 to Loaded.Count - 1 do
      TcxDBTreeListNode(Loaded[I]).SaveStateBeforeRefresh;
    DataSet.First;
    while not DataSet.EOF do
    begin
      LoadValues(GetFieldValue(KeyField), GetFieldValue(ParentKeyField));
      DataSet.Next;
    end;
    // Correct Parent
    for I := 0 to Nodes.Count - 1 do
      Include(TcxDBTreeListNode(Nodes[I]).State, nsDeleting);
    ANode := TcxDBTreeListNode(Root.GetLastChild);
    while ANode <> nil do
    begin
      APrev := TcxDBTreeListNode(ANode.GetPrevSibling);
      if not ANode.Deleting and FindLoadedNode(ANode.ParentKeyValue, AIndex) and
        ANode.CanMove(TcxTreeListNode(Loaded.List^[AIndex]), tlamAddChildFirst) then
        InternalMove(ANode, TcxTreeListNode(Loaded.List^[AIndex]), tlamAddChildFirst);
      ANode := APrev;
    end;
    for I := 0 to Loaded.Count - 1 do
      TcxDBTreeListNode(Loaded[I]).RestoreStateAfterRefresh;
  end
  else
    if ALoadingNode = nil then
    begin
      AKeyValue := GetFieldValue(KeyField);
      AParentKeyValue := GetFieldValue(ParentKeyField);
      LoadLevel(nil, TreeList.RootValue, nil);
      // check FocusedNode
      Loaded.Sort(@cxCompareByKeyValue);
      if (KeyField <> ParentKeyField) and IsExistKeyRoot(AParentKeyValue) and
        not FindLoadedNode(AKeyValue, I) then
        LoadLevelBack(AParentKeyValue);
    end
    else
      LoadLevel(TcxDBTreeListNode(ALoadingNode), TcxDBTreeListNode(ALoadingNode).KeyValue, nil);
end;

function TcxDBTreeListLoader.FindLoadedNode(
  const AParentValue: Variant; var AIndex: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Loaded.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := VarCompare(TcxDBTreeListNode(Loaded.List^[I]).KeyValue, AParentValue);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  AIndex := L;
end;

function TcxDBTreeListLoader.FindNode(var ANode: TcxDBTreeListNode;
  const AValue: Variant): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  if Nodes = nil then Exit;
  L := 0;
  H := Nodes.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    try
      ANode := TcxDBTreeListNode(Nodes.List^[I]);
      C := VarCompare(ANode.KeyValue,  AValue);
      if C = 0 then
      begin
        Nodes.Delete(I);
        Result := True;
        Break;
      end
      else
        if C < 0 then
          L := I + 1
        else
          H := I - 1;
    except
      Result := False; // Variant Error
      Break;
    end;
  end;
end;

function TcxDBTreeListLoader.GetImageIndex(
  ANode: TcxTreeListNode; AIndexType: TcxTreeListImageIndexType): Integer;
begin
  Result := -1;
end;

function TcxDBTreeListLoader.GetImageIndexAsInteger(AField: TField): Integer;
begin
  if AField = nil then
    Result := -1
  else
    try
      Result := AField.Value
    except
      on EVariantError do Result := -1;
    end;
end;

function TcxDBTreeListLoader.IsChildrenExist(ANode: TcxTreeListNode): Boolean;
begin
  Result := not TreeList.OptionsData.CheckHasChildren or
    DataSet.Locate(ParentKeyFieldName, TcxDBTreeListNode(ANode).KeyValue, []);
end;

function TcxDBTreeListLoader.IsExistKeyRoot(AParentValue: Variant): Boolean;
var
  ARootValue: Variant;
begin
  Result := False;
  ARootValue := TreeList.RootValue;
  repeat
    if AParentValue = ARootValue then
    begin
      Result := True;
      Break;
    end;
    if not DataSet.Locate(KeyFieldName, AParentValue, []) or
      (GetFieldValue(KeyField) = GetFieldValue(ParentKeyField)) then Break;
    AParentValue := GetFieldValue(ParentKeyField);
  until False;
end;

procedure TcxDBTreeListLoader.LoadLevel(ANode: TcxDBTreeListNode;
  const AParentValue: Variant; ANewNodes: TList);
var
  I: Integer;
  AList: TList;
  AItem: TcxDBTreeListNode;
begin
  if not DataSet.Locate(ParentKeyFieldName, AParentValue, []) then Exit;
  AList := TList.Create;
  try
    while not DataSet.EOF and (GetFieldValue(ParentKeyField) = AParentValue) do
    begin
      AItem := LoadValues(AParentValue, GetFieldValue(KeyField));
      if ANewNodes <> nil then ANewNodes.Add(AItem);
      if ANode = nil then AList.Add(AItem);
      DataSet.Next;
    end;
    if ANode = nil then
    begin
      for I := 0 to AList.Count - 1 do
      begin
        AItem := TcxDBTreeListNode(AList[I]);
        if AItem.Expanded then
          LoadLevel(AItem, AItem.KeyValue, nil)
        else
          if IsChildrenExist(AItem) then HasChildren.Add(AItem);
      end;
    end
    else
    begin
      ANode := TcxDBTreeListNode(ANode.GetFirstChild);
      while ANode <> nil do
      begin
        if ANode.Expanded then
          LoadLevel(ANode, ANode.KeyValue, nil)
        else
          if IsChildrenExist(ANode) then HasChildren.Add(ANode);
        ANode := TcxDBTreeListNode(ANode.GetNextSibling);
      end;
    end;
  finally
    for I := 0 to HasChildren.Count - 1 do
      TcxDBTreeListNode(HasChildren[I]).HasChildren := True;
    HasChildren.Clear;
    AList.Free;
  end;
end;

procedure TcxDBTreeListLoader.LoadLevelBack(AParentValue: Variant);
var
  I, AIndex: Integer;
  ANewNodes: TList;
  ANode: TcxDBTreeListNode;
begin
  ANewNodes := TList.Create;
  try
    repeat
      if FindLoadedNode(AParentValue, I) then
      begin
        LoadLevel(TcxDBTreeListNode(Loaded.List^[I]), AParentValue, nil);
        Break;
      end
      else
      begin
        LoadLevel(nil, AParentValue, ANewNodes);
        if not DataSet.Locate(KeyFieldName, AParentValue, []) then Break;
        AParentValue := GetFieldValue(ParentKeyField);
      end;
    until False;
    // Correct Parent
    for I := 0 to ANewNodes.Count - 1 do
    begin
      ANode := TcxDBTreeListNode(ANewNodes.List^[I]);
      if FindLoadedNode(ANode.ParentKeyValue, AIndex) and
         ANode.CanMove(TcxDBTreeListNode(Loaded.List^[I]), tlamAddChild) then
        InternalMove(ANode, Loaded[AIndex], tlamAddChild);
    end;
  finally
    FreeAndNil(ANewNodes);
  end;
end;

function TcxDBTreeListLoader.LoadValues(
  const AKeyValue, AParentKeyValue: Variant): TcxDBTreeListNode;
var
  I: Integer; 
  AFound: Boolean;
begin
  Result := nil;
  AFound := FindNode(Result, AKeyValue);
  if AFound then
  begin
    if ((Result.ParentKeyValue <> AParentKeyValue) or
      ((Result.Parent <> Root) and (TcxDBTreeListNode(Result.Parent).KeyValue <> AParentKeyValue))) and
      FindLoadedNode(AParentKeyValue, I) and Result.CanMove(TcxTreeListNode(Loaded.List^[I]), tlamAddChild) then
      InternalMove(Result, TcxTreeListNode(Loaded.List^[I]), tlamAddChild)
    else
      InternalMove(Result, Root, tlamAdd);
  end
  else
  begin
    if FindLoadedNode(AKeyValue, I) then
      Result := TcxDBTreeListNode(TcxTreeListNode(Loaded.List^[I]).AddChild)
    else
      Result := TcxDBTreeListNode(TreeList.Root.AddChild);
  end;
  AssignValues(Result);
  Result.ParentKeyValue := AParentKeyValue;
  Exclude(Result.State, nsInserting);
  if not AFound and not FindLoadedNode(Result.KeyValue, I) then
    Loaded.Insert(I, Result);
end;

procedure TcxDBTreeListLoader.SavePos;
begin
  inherited SavePos;
  FDataSetBookmark := cxDataSetCreateBookMark(DataSet);
end;

procedure TcxDBTreeListLoader.RestorePos;
begin
  inherited RestorePos;
  cxDataSetRestoreBookmark(DataSet, TDataSetBookmark(FDataSetBookmark));
end;

function TcxDBTreeListLoader.GetDataController: TcxDBTreeListDataController;
begin
  Result := TcxDBTreeListDataController(inherited DataController);
end;

function TcxDBTreeListLoader.GetDataSet: TDataSet;
begin
  Result := DataController.DataSet;
end;

function TcxDBTreeListLoader.GetTreeList: TcxCustomDBTreeList;
begin
  Result := TcxCustomDBTreeList(inherited TreeList);
end;

function TcxDBTreeListLoader.GetKeyField: TField;
begin
  Result := DataController.DBKeyField;
end;

function TcxDBTreeListLoader.GetKeyFieldName: string;
begin
  Result := DataController.KeyField;
end;

function TcxDBTreeListLoader.GetParentKeyField: TField;
begin
  Result := DataController.DBParentField;
end;

function TcxDBTreeListLoader.GetParentKeyFieldName: string;
begin
  Result := DataController.ParentField;
end;

{ TcxCustomDBTreeList }

constructor TcxCustomDBTreeList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner); 
  FRootValue := Integer(-1);
end;

destructor TcxCustomDBTreeList.Destroy;
begin
  BeginUpdate;
  DataController.DataSource := nil;
  inherited Destroy;
end;

procedure TcxCustomDBTreeList.Assign(Source: TPersistent); 
begin
  inherited Assign(Source);
  if Source is TcxCustomDBTreeList then
    FRootValue :=  TcxCustomDBTreeList(Source).FRootValue;
end;

function TcxCustomDBTreeList.FindNodeByKeyValue(
  const AKeyValue: Variant; AStartNode: TcxTreeListNode = nil;
  AExpandedOnly: Boolean = False; AForward: Boolean = True): TcxDBTreeListNode;
begin
  Result := Find(@AKeyValue, AStartNode, AExpandedOnly,
    AForward, TcxTreeListFindFunc(@cxFindKey)) as TcxDBTreeListNode;
end;

procedure TcxCustomDBTreeList.AssignData(ASource: TcxCustomTreeList);
begin
  inherited AssignData(ASource);
  if ASource is TcxCustomDBTreeList then
    DataController.DataSource := TcxCustomDBTreeList(ASource).DataController.DataSource;
end;
                                           
procedure TcxCustomDBTreeList.CreateAllItems;
begin
  DataController.CreateAllItems;
end;

function TcxCustomDBTreeList.CreateNode: TcxTreeListNode;
begin
  Result := TcxDBTreeListNode.Create(Self);
end;

procedure TcxCustomDBTreeList.DataChanged;
begin
  if DataController <> nil then
    DataController.UpdateInternalFields;
  inherited DataChanged;
end;

procedure TcxCustomDBTreeList.DataModeChanged;
begin
  if OptionsData.SmartLoad then
    OptionsData.SmartRefresh := False;
  inherited DataModeChanged;
end;

procedure TcxCustomDBTreeList.DoClear;
begin
  InternalClearAll;
end;

procedure TcxCustomDBTreeList.DoDeleteNode(ANode: TcxTreeListNode);
begin
  if ANode = UpdatingNode then
    FUpdatingNode := nil;
  inherited DoDeleteNode(ANode);
end;

procedure TcxCustomDBTreeList.DeleteNodes(AList: TList);
begin
  DataSet.DisableControls;
  try
    inherited DeleteNodes(AList);
  finally
    DataSet.EnableControls;
  end;
end;

function TcxCustomDBTreeList.DoInitInsertingNode(
  ANode: TcxDBTreeListNode): Boolean;
begin
  Result := False;
  // todo: 
  if (ANode <> nil) and (ANode <> Root) then
    ANode := TcxDBTreeListNode(ANode.Parent)
  else
    ANode := nil;
  //
  if Assigned(FOnInitInsertingRecord) then
    FOnInitInsertingRecord(Self, ANode, Result);
end;

procedure TcxCustomDBTreeList.DoMoveTo(AttachNode: TcxTreeListNode;
  AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean);
var
  I: Integer;
  NewParentValue: Variant;
begin
  if AttachMode in [tlamAddChild, tlamAddChildFirst] then
    NewParentValue := TcxDBTreeListNode(AttachNode).KeyValue
  else
    NewParentValue := TcxDBTreeListNode(AttachNode).ParentKeyValue;
  if not IsCopy then
  begin
    inherited DoMoveTo(AttachNode, AttachMode, ANodes, IsCopy);
    DataController.DataSet.DisableControls;
    try
      for I := 0 to ANodes.Count - 1 do
        DataController.SetNodeParentValue(
            TcxDBTreeListNode(ANodes.List^[I]), NewParentValue);
    finally
      DataController.DataSet.EnableControls;
    end;
  end
  else
  begin
    BeginUpdate;
    try
      DataController.DoCopyTo(TcxDBTreeListNode(AttachNode), AttachMode, ANodes);
    finally
      EndUpdate;
    end
  end;
  if OptionsData.SmartRefresh then
    DataChanged;
end;

function TcxCustomDBTreeList.FindLoadedNodeByKeyValue(
  const AValue: Variant): TcxDBTreeListNode;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to AbsoluteItemsList.Count - 1 do
    if VarEquals(TcxDBTreeListNode(AbsoluteItemsList[I]).KeyValue, AValue) then
    begin
      Result := TcxDBTreeListNode(AbsoluteItemsList[I]);
      Break;
    end;
end;

procedure TcxCustomDBTreeList.FindNodeById;
var
  ANode: TcxDBTreeListNode;
begin
  if DataLocate or DataBusy or DataController.IsKeyFieldsEmpty then Exit;
  ANode := FindNodeByKeyValue(GetFieldValue(DataController.DBKeyField));
  if ANode <> nil then
  begin
    ANode.Focused := True;
    ANode.MakeVisible;
  end;
end;

function TcxCustomDBTreeList.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxDBTreeListDataController;
end;

function TcxCustomDBTreeList.GetOptionsDataClass: TcxControlOptionsDataClass;
begin
  Result := TcxDBTreeListOptionsData;
end;

function TcxCustomDBTreeList.GetTreeListColumnClass: TcxTreeListColumnClass;
begin
  Result := TcxDBTreeListColumn;
end;

procedure TcxCustomDBTreeList.InitializeFields;
var
  I: Integer;
begin
  DataController.UpdateInternalFields;
  for I := 0 to ColumnCount - 1 do
    TcxDBTreeListColumn(Columns[I]).DataBinding.InitializeField;
  inherited InitializeFields; 
end;

function TcxCustomDBTreeList.InsertNode(ARelative: TcxTreeListNode; IsAppend: Boolean): Boolean;
var
  AParentKeyValue: Variant;
begin
  Result := True;
  HideEdit();
  DataSet.DisableControls;
  try
    AParentKeyValue := Null;
    if not DataSet.Eof then
    begin
      if IsAppend then
        AParentKeyValue := DataController.DBParentField.Value
      else
        AParentKeyValue := DataController.DBKeyField.Value;
    end;
    DataSet.Insert;
    if not VarIsNull(AParentKeyValue) then
      DataController.DBParentField.Value := AParentKeyValue;
  finally
    DataSet.EnableControls;
  end;
  ShowEdit;
end;

procedure TcxCustomDBTreeList.InternalInsertNode(IsAppend: Boolean);
var
  ANode: TcxDBTreeListNode;
begin
  if not IsDataSettingsValid then Exit;
  InternalCreationAddRef;
  try
    if (FocusedNode <> nil) then
    begin
      if (FocusedNode.Parent <> nil) and IsAppend then
        UpdatingNode := FocusedNode.Parent.AddChild as TcxDBTreeListNode
      else
        UpdatingNode := FocusedNode.AddChild as TcxDBTreeListNode;
    end
    else
      UpdatingNode := Root.AddChild as TcxDBTreeListNode;
    DataController.DoInitInsertingNode(UpdatingNode);
    if VarIsEmpty(UpdatingNode.ParentKeyValue) <> Null then
    begin
      ANode := FindNodeByKeyValue(UpdatingNode.ParentKeyValue);
      if ANode <> nil then
        UpdatingNode.MoveTo(ANode, tlamAddChild);
    end;
    UpdatingNode.Focused := True;
    UpdatingNode.MakeVisible;
    DataController.EditingNode := UpdatingNode;
    DataController.IsValueChanged := False;
    ClearSelection;
  finally
    InternalCreationRelease;
  end;
end;

function TcxCustomDBTreeList.IsAutoCalcKeyValue: Boolean;
begin
  Result := OptionsData.AutoCalcKeyValue and not OptionsData.SmartLoad;
end;

function TcxCustomDBTreeList.IsDataSettingsValid: Boolean;
begin
  Result := inherited IsDataSettingsValid and not IsLoading and not IsDestroying and
   (DataController.DataSet <> nil) and DataController.DataSet.Active and
    not DataController.IsKeyFieldsEmpty and not DataController.DataSet.ControlsDisabled;
end;

function TcxCustomDBTreeList.IsNodeInserting(ANode: TcxTreeListNode): Boolean;
begin
  Result := (ANode <> nil) and DataController.DataLink.Active and (DataSet.State = dsInsert) and 
    (TcxDBTreeListNode(ANode).KeyValue = GetFieldValue(DataController.DBKeyField));
end;

function TcxCustomDBTreeList.IsTreeListLocked: Boolean;
begin
  Result := inherited IsTreeListLocked or IsRefreshValues or IsRefresh;
end;

procedure TcxCustomDBTreeList.RefreshFields;
begin
  IsRefreshFields := True;
  try
    DataController.UpdateInternalFields;
    inherited RefreshFields;
  finally
    IsRefreshFields := False;
  end; 
end;

function TcxCustomDBTreeList.SupportCreateAllItems: Boolean;
begin
  Result := True;
end;

procedure TcxCustomDBTreeList.UpdateFocusedNode(
  AColumn: TcxTreeListColumn);
begin
  DataController.UpdateFocused;
  if (FocusedNode <> nil) then
  begin
    Loader.AssignValues(FocusedNode);
    if DataSet.State in dsEditModes then
      DataController.EditingNode := FocusedNode;
  end;
  inherited UpdateFocusedNode(AColumn);
end;

procedure TcxCustomDBTreeList.LoadListByNode(
  ANode: TcxDBTreeListNode; AList: TList);
var
  P: PVariant;
  I: Integer;
begin
  New(P);
  P^ := ANode.KeyValue;
  AList.Add(P);
  for I := 0 to ANode.Count - 1 do
    LoadListByNode(TcxDBTreeListNode(ANode[I]), AList);
end;

procedure TcxCustomDBTreeList.RefreshTree;
begin
  FIsRefresh := True;
  try
    InitializeFields;
    DataController.Load(nil);
    ClearSelection();
    FindNodeById;
  finally
    FIsRefresh := False;
  end;
  LayoutChanged;
end;

procedure TcxCustomDBTreeList.LoadListByID(
  const AKeyValue: Variant; AList: TList);
var
  P: PVariant;
  ATempList: TList;
  I: Integer;
begin
  New(P);
  P^ := AKeyValue;
  AList.Add(P);
  if not DataSet.Locate(DataController.ParentField, AKeyValue, []) then Exit;
  ATempList := TList.Create;
  try
    while not DataSet.Eof and (GetFieldValue(DataController.DBParentField) = AKeyValue) do
    begin
      New(P);
      P^ := GetFieldValue(DataController.DBKeyField);
      ATempList.Add(P);
      DataSet.Next;
    end;
    for I := 0 to ATempList.Count - 1 do
      LoadListByID(PVariant(ATempList[I])^, AList);
  finally
    for I := 0 to ATempList.Count - 1 do
      Dispose(ATempList[I]);
    ATempList.Free;
  end;             
end;

function TcxCustomDBTreeList.GetDataController: TcxDBTreeListDataController;
begin
  Result := TcxDBTreeListDataController(inherited DataController);
end;

function TcxCustomDBTreeList.GetDataSet: TDataSet;
begin
  if (DataController = nil) or (DataController.DataSource = nil) then
    Result := nil
  else
    Result := DataController.DataSource.DataSet;
end;

function TcxCustomDBTreeList.GetLoader: TcxDBTreeListLoader;
begin
  Result := inherited Loader as TcxDBTreeListLoader;
end;

function TcxCustomDBTreeList.GetOptionsData: TcxDBTreeListOptionsData;
begin
  Result := TcxDBTreeListOptionsData(inherited OptionsData); 
end;

procedure TcxCustomDBTreeList.SetDataController(
  AValue: TcxDBTreeListDataController);
begin
  DataController.Assign(AValue);
end;

procedure TcxCustomDBTreeList.SetOptionsData(AValue: TcxDBTreeListOptionsData);
begin
  OptionsData.Assign(AValue);
end;

procedure TcxCustomDBTreeList.SetRootValue(const AValue: Variant);
begin
  FRootValue := AValue;
  if OptionsData.SmartLoad then
    DataChanged;
end;

end.



