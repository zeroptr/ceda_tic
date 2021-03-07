{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System(tm) COMPONENT SUITE                  }
{                                                                   }
{       Copyright (C) 1998-2009 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPScxScheduler2LnkReg;

interface

{$I cxVer.Inc}

procedure Register;

implementation

uses
   {$IFDEF DELPHI6}
    DesignIntf, DesignEditors, 
   {$ELSE}
    DsgnIntf,
   {$ENDIF} 
  Classes, TypInfo, cxStyles, cxStyleSheetEditor, dxPSCore, dxPScxScheduler2Lnk;

const
  sdxAllResources = '(All resources)';
  sdxAuto = 'Auto';
  sdxDefault = 'Default';
  sdxTypeDefault = '(Type "Default" to restore original Caption)';

{ TcxSchedulerReportLinkActiveStylePropertyEditor }

type

  TcxSchedulerReportLinkResourceCountPerPagePropertyEditor = class(TIntegerProperty)
  public
    function GetValue: string; override;
  end;

  { TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor }

  TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor = class(TComponentProperty)
  private
    FComponents: TStringList;
    function GetReportLink: TBasedxReportLink;
  protected
    procedure AddComponent(const AName: string);
    procedure GetComponents; virtual;
    function IsComponentValid(AComponent: TComponent): Boolean; virtual;
  public
    destructor Destroy; override;
    procedure Initialize; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    property ReportLink: TBasedxReportLink read GetReportLink;
  end;

{ TcxSchedulerReportLinkResourceCountPerPagePropertyEditor }

function TcxSchedulerReportLinkResourceCountPerPagePropertyEditor.GetValue: string;
begin
  Result := inherited GetValue;
  if GetOrdValue = 0 then
    Result := Result + ' ' + sdxAllResources;
end;

{ TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor }

destructor TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor.Destroy;
begin
  FComponents.Free;
  inherited Destroy;
end;

procedure TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor.Initialize;
begin
  inherited;
  FComponents := TStringList.Create;
end;

function TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes - [paMultiSelect];
end;

procedure TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  GetComponents;
  for I := 0 to FComponents.Count - 1 do
    Proc(FComponents[I]);
end;

function TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor.GetReportLink: TBasedxReportLink;
begin
  Result := TBasedxReportLink(GetComponent(0));
end;

procedure TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor.AddComponent(const AName: string);
begin
  if IsComponentValid(Designer.GetComponent(AName)) then FComponents.Add(AName);
end;

procedure TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor.GetComponents;
begin
  FComponents.Clear;
  Designer.GetComponentNames(GetTypeData(PTypeInfo(TBasedxReportLink.ClassInfo)), AddComponent);
end;

function TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor.IsComponentValid(AComponent: TComponent): Boolean;
begin
  Result := (AComponent <> GetComponent(0)) and TBasedxReportLink(AComponent).Aggregable;
end;
  
procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}  

  RegisterNoIcon([TcxSchedulerReportLink, TcxSchedulerReportLinkStyleSheet]);

  RegisterPropertyEditor(TypeInfo(Integer), TcxCustomSchedulerReportLinkPrintStyle,
    'ResourceCountPerPage', TcxSchedulerReportLinkResourceCountPerPagePropertyEditor);
  RegisterPropertyEditor(TypeInfo(TBasedxReportLink), TcxSchedulerReportLink,
    'TaskPadReportLink', TcxSchedulerReportLinkTaskPadReportLinkPropertyEditor);
end;

initialization
  cxStyles.RegisterStyleSheetClass(TcxSchedulerReportLinkStyleSheet);

finalization
  cxStyles.UnregisterStyleSheetClass(TcxSchedulerReportLinkStyleSheet);

end.
