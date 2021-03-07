{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Common Editing Library            }
{                                                                    }
{           Copyright (c) 2000-2009 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE COMMONEDITINGLIBRARY AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit cxInplaceContainerReg;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils,
{$IFDEF DELPHI6}
  DesignIntf, DesignEditors,
{$ELSE}
  DsgnWnds, DsgnIntf,
{$ENDIF}
  cxClasses, cxPropEditors, cxEdit, cxDesignWindows, cxInplaceContainer;

type
  TItemDataBindingAccess = class(TcxItemDataBinding);

  { TcxstPropEventsProperty }

  TcxInplaceEditContainerPropertiesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxInplaceEditContainerPropertiesProperty }

  TcxInplaceEditContainerPropertiesProperty = class(TClassProperty)
  protected
    function HasSubProperties: Boolean;
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxValueTypeClassProperty }

  TcxValueTypeClassProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxDesignSelectionHelper }

  TcxDesignSelectionHelper = class(TcxCustomDesignSelectionHelper
    {$IFDEF DELPHI6}, IUnknown, IDesignNotification{$ENDIF})
  private
    FDesignHelper: TcxDesignHelper;
  protected
  {$IFDEF DELPHI6}
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    // IDesignNotification
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemInserted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemsModified(const ADesigner: IDesigner);
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
    procedure DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean);
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
  {$ENDIF}
  public
    constructor Create(AControl: TcxEditingControl); override;
    destructor Destroy; override;
    function IsObjectSelected(AObject: TPersistent): Boolean; override;
    procedure Select(AObject: TPersistent; AShift: TShiftState); override;
    procedure SetSelection(AList: TList); override;
    procedure UnselectObject(AObject: TPersistent); override;
  end;

procedure Register;

implementation

uses
  Windows;

{ TcxInplaceEditContainerPropertiesEventsProperty }

function TcxInplaceEditContainerPropertiesEventsProperty.GetInstance: TPersistent;
var
  AIntf: IcxEditorPropertiesContainer;
begin
  if Supports(GetComponent(0), IcxEditorPropertiesContainer, AIntf) then 
    Result := AIntf.GetProperties
  else
    Result := nil;
end;

{ TcxInplaceEditContainerPropertiesProperty }

function TcxInplaceEditContainerPropertiesProperty.HasSubProperties: Boolean;
var
  I: Integer;
  AIntf: IcxEditorPropertiesContainer;
begin
  for I := 0 to PropCount - 1 do
  begin
    Result := Supports(GetComponent(I), IcxEditorPropertiesContainer, AIntf) and
      (AIntf.GetProperties <> nil);
    if not Result then Exit;
  end;
  Result := True;
end;

function TcxInplaceEditContainerPropertiesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  if not HasSubProperties then
    Exclude(Result, paSubProperties);
  Result := Result - [paReadOnly] + [paValueList, paSortList, paRevertable] +
    {$IFDEF DELPHI6}[paVolatileSubProperties] {$ELSE } [] {$ENDIF};
end;

function TcxInplaceEditContainerPropertiesProperty.GetValue: string;
begin
  if HasSubProperties then
    Result := GetRegisteredEditProperties.GetDescriptionByClass(
      TcxCustomEditProperties(GetOrdValue).ClassType)
  else
    Result := '';
end;

procedure TcxInplaceEditContainerPropertiesProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to GetRegisteredEditProperties.Count - 1 do
    Proc(GetRegisteredEditProperties.Descriptions[I]);
end;

procedure TcxInplaceEditContainerPropertiesProperty.SetValue(const Value: string);
var
  APropertiesClass: TcxCustomEditPropertiesClass;
  I: Integer;
  AIntf: IcxEditorPropertiesContainer;
begin
  {$IFNDEF DELPHI7}
    ObjectInspectorCollapseProperty;
  {$ENDIF}
  APropertiesClass := TcxCustomEditPropertiesClass(
    GetRegisteredEditProperties.FindByClassName(Value));
  if APropertiesClass = nil then
    APropertiesClass := TcxCustomEditPropertiesClass(
      GetRegisteredEditProperties.FindByDescription(Value));
  for I := 0 to PropCount - 1 do
    if Supports(GetComponent(I), IcxEditorPropertiesContainer, AIntf) then
      AIntf.SetPropertiesClass(APropertiesClass);
  Modified;
end;

{ TcxValueTypeClassProperty }

function TcxValueTypeClassProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes - [paReadOnly] + [paValueList];
end;

procedure TcxValueTypeClassProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to cxieValueTypeClassRepository.Count - 1 do
    Proc(cxieValueTypeClassRepository.Description[I]);
end;

procedure TcxValueTypeClassProperty.SetValue(const Value: string);
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
    TItemDataBindingAccess(GetComponent(I)).ValueType := Value;
end;

{ TcxDesignSelectionHelper }

constructor TcxDesignSelectionHelper.Create(AControl: TcxEditingControl);
begin
  inherited Create(AControl);
  FDesignHelper := TcxDesignHelper.Create(Control);
{$IFDEF DELPHI6}
  RegisterDesignNotification(Self);
{$ENDIF}
end;

destructor TcxDesignSelectionHelper.Destroy;
begin
{$IFDEF DELPHI6}
  UnregisterDesignNotification(Self);
{$ENDIF}
  FDesignHelper.Free;
  inherited Destroy;
end;

function TcxDesignSelectionHelper.IsObjectSelected(
  AObject: TPersistent): Boolean;
begin
  Result := FDesignHelper.IsObjectSelected(AObject);
end;

procedure TcxDesignSelectionHelper.Select(AObject: TPersistent;
  AShift: TShiftState);
begin
  if AShift * [ssCtrl, ssAlt] <> [] then Exit;
  if AObject = nil then
    FDesignHelper.SelectObject(Control)
  else
    if ssShift in AShift then
      FDesignHelper.ChangeSelection(AObject)
    else
      FDesignHelper.SelectObject(AObject);
end;

procedure TcxDesignSelectionHelper.SetSelection(AList: TList);
begin
  FDesignHelper.SetSelection(AList);
end;

procedure TcxDesignSelectionHelper.UnselectObject(AObject: TPersistent);
begin
  FDesignHelper.UnselectObject(AObject);
end;

{$IFDEF DELPHI6}
function TcxDesignSelectionHelper._AddRef: Integer; stdcall;
begin
  Result := -1;
end;

function TcxDesignSelectionHelper._Release: Integer; stdcall;
begin
  Result := -1;
end;

function TcxDesignSelectionHelper.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := cxE_NOINTERFACE;
end;

procedure TcxDesignSelectionHelper.ItemDeleted(const ADesigner: IDesigner;
  AItem: TPersistent);
begin
end;

procedure TcxDesignSelectionHelper.ItemInserted(const ADesigner: IDesigner;
  AItem: TPersistent);
begin
end;

procedure TcxDesignSelectionHelper.ItemsModified(const ADesigner: IDesigner);
begin
end;

procedure TcxDesignSelectionHelper.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
begin
  Control.LayoutChanged;
  Control.Invalidate;
end;

procedure TcxDesignSelectionHelper.DesignerOpened(const ADesigner: IDesigner;
  AResurrecting: Boolean);
begin
end;

procedure TcxDesignSelectionHelper.DesignerClosed(const ADesigner: IDesigner;
  AGoingDormant: Boolean);
begin
end;
{$ENDIF}

procedure Register;
begin
  RegisterClasses([TcxCustomInplaceEditContainer]);
  RegisterNoIcon([TcxCustomInplaceEditContainer]);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomInplaceEditContainer, 'PropertiesEvents',
    TcxInplaceEditContainerPropertiesEventsProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxCustomInplaceEditContainer,
    'PropertiesClassName', nil);
  RegisterPropertyEditor(TypeInfo(TcxCustomEditProperties), TcxCustomInplaceEditContainer,
    'Properties', TcxInplaceEditContainerPropertiesProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxItemDataBinding,
    'ValueType', TcxValueTypeClassProperty);
end;

initialization
{$IFDEF DELPHI6}
  cxDesignSelectionHelperClass := TcxDesignSelectionHelper;
{$ENDIF}

end.
