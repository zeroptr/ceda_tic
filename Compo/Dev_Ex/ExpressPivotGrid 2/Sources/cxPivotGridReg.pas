{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressPivotGrid                                 }
{                                                                    }
{       Copyright (c) 2005-2009 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPIVOTGRID AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
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

unit cxPivotGridReg;

{$I cxVer.inc}

interface

uses
  Windows, Classes, SysUtils, TypInfo,
  Types, DesignIntf, DesignEditors,  VCLEditors, Forms, DB, ShellApi, ImgList,
  cxDesignWindows, cxEditPropEditors, cxPropEditors, cxControls, cxEdit,
  cxStyles, cxPivotGridDesigner, cxCustomPivotGrid, cxDBPivotGrid,
  cxPivotGrid, cxPivotGridPredefinedStyles, cxPivotGridStyleSheetsPreview,
  cxPivotGridSummaryDataSet, cxPivotGridDrillDownDataSet, cxExportPivotGridLink;

procedure Register;

function cxPivotGridCustomComponentEditor: TComponentEditorClass;

implementation

uses
  dxCore, dxCoreReg, cxLibraryReg;

const
  scxDesigner = 'Designer...';
  scxMajorVersion = '2';
  scxProductName = 'ExpressPivotGrid';

type
  { TcxPivotGridFieldHeaderImageIndexProperty }

  TcxPivotGridFieldHeaderImageIndexProperty = class(TImageIndexProperty)
  public
    function GetImages: TCustomImageList; override;
  end;

  { TcxPivotGridFieldNameProperty }
  
  TcxPivotGridFieldNameProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
  end;

  { TcxPivotGridStylesEventsProperty }

  TcxPivotGridStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxPivotGridPopupMenusEventsProperty }

  TcxPivotGridPopupMenusEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxPivotGridFieldPropertiesEventsProperty }

  TcxPivotGridFieldPropertiesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxPivotGridFieldPropertiesProperty }

  TcxPivotGridFieldPropertiesProperty = class(TClassProperty)
  protected
    function HasSubProperties: Boolean;
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxCustomPivotGridComponentEditor }

  TcxCustomPivotGridComponentEditor = class(TdxComponentEditor)
  protected
    function GetProductMajorVersion: string; override;
    function GetProductName: string; override;
  end;

  { TcxPivotGridComponentEditor }

  TcxPivotGridComponentEditor = class(TcxCustomPivotGridComponentEditor)
  protected
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  end;

  { TcxPivotGridDesignHelper }

  TcxPivotGridDesignHelper = class(TcxPivotGridCustomDesignHelper, IUnknown,
    IcxPivotGridDesignerHelper {$IFDEF DELPHI6}, IDesignNotification{$ENDIF})
  protected
    Listeners: TList;
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
  {$IFDEF DELPHI6}
    // IDesignNotification
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemInserted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemsModified(const ADesigner: IDesigner);
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
    procedure DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean);
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
  {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddListener(APivotGrid: TcxCustomPivotGrid);
    procedure RemoveListener(APivotGrid: TcxCustomPivotGrid);
    function IsObjectSelected(AObject: TPersistent): Boolean;
    procedure Select(AObject: TPersistent; AShift: TShiftState);
  end;

{$IFDEF DELPHI6}
  TcxPivotGridSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxPivotGridFieldSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;
{$ENDIF}

  { TcxPivotGridFieldHeaderImageIndexProperty }

function TcxPivotGridFieldHeaderImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := nil;
  if GetComponent(0) is TcxPivotGridField then
    Result := TcxPivotGridField(GetComponent(0)).PivotGrid.FieldHeaderImages;
end;

{ TcxPivotGridFieldNameProperty }

function TcxPivotGridFieldNameProperty.GetDataSource: TDataSource;
begin
  Result := TcxDBPivotGrid(TcxDBPivotGridFieldDataBinding(
    GetComponent(0)).PivotGrid).DataSource;
end;

{ TcxPivotGridStylesEventsProperty }

function TcxPivotGridStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomPivotGrid(GetComponent(0)).Styles;
end;

{ TcxPivotGridPopupMenusEventsProperty }

function TcxPivotGridPopupMenusEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomPivotGrid(GetComponent(0)).PopupMenus;
end;

{ TcxPivotGridFieldPropertiesEventsProperty }

function TcxPivotGridFieldPropertiesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxPivotGridField(GetComponent(0)).Properties;
end;

{ TcxPivotGridFieldPropertiesProperty }

function TcxPivotGridFieldPropertiesProperty.HasSubProperties: Boolean;
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
  begin
    Result := TcxPivotGridField(GetComponent(I)).Properties <> nil;
    if not Result then Exit;
  end;
  Result := True;
end;

function TcxPivotGridFieldPropertiesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  if not HasSubProperties then
    Exclude(Result, paSubProperties);
  Result := Result - [paReadOnly] +
    [paValueList, paSortList, paRevertable{$IFDEF DELPHI6}, paVolatileSubProperties{$ENDIF}];
end;

function TcxPivotGridFieldPropertiesProperty.GetValue: string;
begin
  if HasSubProperties then
    Result := GetRegisteredEditProperties.GetDescriptionByClass(
      TcxPivotGridField(GetComponent(0)).Properties.ClassType)
  else
    Result := '';
end;

procedure TcxPivotGridFieldPropertiesProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to GetRegisteredEditProperties.Count - 1 do
    Proc(GetRegisteredEditProperties.Descriptions[I]);
end;

procedure TcxPivotGridFieldPropertiesProperty.SetValue(const Value: string);
var
  APropertiesClass: TcxCustomEditPropertiesClass;
  I: Integer;
begin
  APropertiesClass := TcxCustomEditPropertiesClass(GetRegisteredEditProperties.FindByClassName(Value));
  if APropertiesClass = nil then
    APropertiesClass := TcxCustomEditPropertiesClass(GetRegisteredEditProperties.FindByDescription(Value));
{$IFNDEF DELPHI7}
  if GetValue <> Value then
    ObjectInspectorCollapseProperty;
{$ENDIF}
  for I := 0 to PropCount - 1 do
    TcxPivotGridField(GetComponent(I)).PropertiesClass := APropertiesClass;
  Modified;
end;

{ TcxCustomPivotGridComponentEditor }

function TcxCustomPivotGridComponentEditor.GetProductMajorVersion: string;
begin
  Result := scxMajorVersion;
end;

function TcxCustomPivotGridComponentEditor.GetProductName: string;
begin
  Result := scxProductName;
end;

{ TcxPivotGridComponentEditor }

function TcxPivotGridComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  Result := scxDesigner;
end;

function TcxPivotGridComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TcxPivotGridComponentEditor.InternalExecuteVerb(AIndex: Integer);
begin
  ShowPivotGridDesigner(Designer, Component as TcxCustomPivotGrid);
end;

{ TcxPivotGridDesignHelper }

constructor TcxPivotGridDesignHelper.Create;
begin
  Listeners := TList.Create;
{$IFDEF DELPHI6}
  RegisterDesignNotification(Self);
{$ENDIF}
end;

destructor TcxPivotGridDesignHelper.Destroy;
begin
{$IFDEF DELPHI6}              
  UnregisterDesignNotification(Self);
{$ENDIF}
  Listeners.Free;
  inherited Destroy;
end;

procedure TcxPivotGridDesignHelper.AddListener(
  APivotGrid: TcxCustomPivotGrid);
begin
  Listeners.Add(APivotGrid);
end;

procedure TcxPivotGridDesignHelper.RemoveListener(
  APivotGrid: TcxCustomPivotGrid);
begin
  Listeners.Remove(APivotGrid);
end;

function TcxPivotGridDesignHelper.IsObjectSelected(
  AObject: TPersistent): Boolean;
begin
  Result := False; 
  if AObject = nil then Exit;
  with TcxDesignHelper.Create(AObject as TComponent) do
  try
    Result := IsObjectSelected(AObject);
  finally
    Free; 
  end;
end;

procedure TcxPivotGridDesignHelper.Select(
  AObject: TPersistent; AShift: TShiftState);
var
  ADesignHelper: TcxDesignHelper;
begin
  if AObject = nil then Exit;
  ADesignHelper := TcxDesignHelper.Create(AObject as TComponent);
  try
    if AShift * [ssCtrl, ssAlt] <> [] then Exit;
    if ssShift in AShift then
      ADesignHelper.ChangeSelection(AObject)
    else
      ADesignHelper.SelectObject(AObject);
  finally
    ADesignHelper.Free;
  end;
end;

// IUnknown
function TcxPivotGridDesignHelper._AddRef: Integer;
begin
  Result := -1;
end;

function TcxPivotGridDesignHelper._Release: Integer;
begin
  Result := -1;
end;

function TcxPivotGridDesignHelper.QueryInterface(
  const IID: TGUID; out Obj): HResult;
const
  cxE_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := cxE_NOINTERFACE;
end;

{$IFDEF DELPHI6}
type
  TcxCustomPivotGridAccess = class(TcxCustomPivotGrid);

// IDesignNotification
procedure TcxPivotGridDesignHelper.ItemDeleted(
  const ADesigner: IDesigner; AItem: TPersistent);
begin
  if AItem is TcxCustomPivotGrid then
    RemoveListener(AItem as TcxCustomPivotGrid);
end;

procedure TcxPivotGridDesignHelper.ItemInserted(
  const ADesigner: IDesigner; AItem: TPersistent);
begin
end;

procedure TcxPivotGridDesignHelper.ItemsModified(const ADesigner: IDesigner);
begin
end;

procedure TcxPivotGridDesignHelper.SelectionChanged(
  const ADesigner: IDesigner; const ASelection: IDesignerSelections);
var
  I: Integer;
begin
  for I := 0 to Listeners.Count - 1 do
    RefreshListener(TcxCustomPivotGrid(Listeners[I]));
end;

procedure TcxPivotGridDesignHelper.DesignerOpened(
  const ADesigner: IDesigner; AResurrecting: Boolean);
begin
end;

procedure TcxPivotGridDesignHelper.DesignerClosed(
  const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
end;

{ TcxPivotGridSelectionEditor }

procedure TcxPivotGridSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  Proc('cxClasses');
  Proc('cxGraphics');
  Proc('cxCustomData');
  Proc('cxStyles');
  Proc('cxEdit');
end;

{ TcxPivotGridFieldSelectionEditor }

procedure TcxPivotGridFieldSelectionEditor.RequiresUnits(Proc: TGetStrProc);
var
  I: Integer;
  AComponent: TComponent;
  AItem: TcxPivotGridField;
begin
  inherited RequiresUnits(Proc);
  for I := 0 to Designer.Root.ComponentCount - 1 do
  begin
    AComponent := Designer.Root.Components[I];
    if AComponent is TcxPivotGridField then
    begin
      AItem := TcxPivotGridField(AComponent);
      if AItem.Properties <> nil then
        Proc(dxShortStringToString(GetTypeData(PTypeInfo(AItem.Properties.ClassType.ClassInfo)).UnitName));
    end;
  end;
end;
{$ENDIF}

function cxPivotGridCustomComponentEditor: TComponentEditorClass;
begin
  Result := TcxCustomPivotGridComponentEditor; 
end;

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}

  RegisterComponents('Dev Express', [TcxPivotGrid, TcxDBPivotGrid,
    TcxPivotGridSummaryDataSet, TcxPivotGridDrillDownDataSet]);
  RegisterNoIcon([TcxPivotGridField, TcxDBPivotGridField, TcxPivotGridStyleSheet]);
  RegisterClasses([TcxPivotGridField, TcxDBPivotGridField, TcxPivotGridStyleSheet]);
  RegisterClasses([TcxPivotGridFieldDataBinding, TcxDBPivotGridFieldDataBinding]);
  RegisterComponentEditor(TcxCustomPivotGrid, TcxPivotGridComponentEditor);
  RegisterComponentEditor(TcxPivotGridSummaryDataSet, TcxCustomPivotGridComponentEditor);
  RegisterComponentEditor(TcxPivotGridDrillDownDataSet, TcxCustomPivotGridComponentEditor);  

  RegisterPropertyEditor(TypeInfo(Boolean),
    TcxPivotGridField, 'IsCaptionAssigned', nil);
  RegisterPropertyEditor(TypeInfo(Boolean),
    TcxPivotGridFieldGroup, 'IsCaptionAssigned', nil);
  RegisterPropertyEditor(TypeInfo(Boolean),
    TcxPivotGridOptionsDataField, 'IsCaptionAssigned', nil);

  RegisterPropertyEditor(TypeInfo(TComponent),
    TcxPivotGridFieldHeaderMenu, 'PopupMenu', TcxControlPopupMenuProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),
    TcxPivotGridGroupValueMenu, 'PopupMenu', TcxControlPopupMenuProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),
    TcxPivotGridHeaderAreaMenu, 'PopupMenu', TcxControlPopupMenuProperty);

  RegisterPropertyEditor(TypeInfo(TImageIndex), TcxPivotGridField,
    'ImageIndex', TcxPivotGridFieldHeaderImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomPivotGrid,
    'StylesEvents', TcxPivotGridStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomPivotGrid,
    'PopupMenusEvents', TcxPivotGridPopupMenusEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxPivotGridField,
    'PropertiesEvents', TcxPivotGridFieldPropertiesEventsProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBPivotGridFieldDataBinding,
    'FieldName', TcxPivotGridFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxPivotGridFieldDataBinding,
    'ValueType', TcxValueTypeProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxPivotGridField, 'PropertiesClassName', nil);
  RegisterPropertyEditor(TypeInfo(TcxCustomEditProperties), TcxPivotGridField,
    'Properties', TcxPivotGridFieldPropertiesProperty);

//  HideClassProperties(TcxPivotGridField, ['UniqueName']);
  HideClassProperties(TcxPivotGridOptionsView, ['TotalsLocation']);

{$IFDEF DELPHI6}
  RegisterSelectionEditor(TcxCustomPivotGrid, TcxPivotGridSelectionEditor);
  RegisterSelectionEditor(TcxPivotGridField, TcxPivotGridFieldSelectionEditor);
{$ENDIF}
end;

var
  ADesignerHelper: TcxPivotGridDesignHelper;

initialization
  DesignerHelper := nil;
  RegisterStyleSheetClass(TcxPivotGridStyleSheet);
  ADesignerHelper := TcxPivotGridDesignHelper.Create;
  DesignerHelper := ADesignerHelper as IcxPivotGridDesignerHelper;

finalization
  DesignerHelper := nil;
  UnRegisterStyleSheetClass(TcxPivotGridStyleSheet);
  FreeAndNil(ADesignerHelper);

end.

