{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid Utils                                     }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
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

unit cxGridPopupMenuReg;

{$I cxVer.inc}

interface

procedure Register;

implementation

uses
{$IFDEF DELPHI6}
    DesignIntf, DesignEditors,
  Types,
{$ELSE}
  DsgnIntf, cxClasses,
{$ENDIF}
  Windows, Classes, Messages, SysUtils, cxGridPopupMenu, cxGridCustomPopupMenu,
  cxGridReg, TypInfo, Dialogs;

type
  TcxGridPopupMenuEditor = class(TComponentEditor)
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TcxGridPopupMenuProperty = class(TComponentProperty)
  private
    FGetValuesStrProc: TGetStrProc;
  protected
    procedure ReceiveComponentNames(const S: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TComponent), TcxPopupMenuInfo, 'PopupMenu', TcxGridPopupMenuProperty);
  RegisterComponentEditor(TcxGridPopupMenu, TcxGridPopupMenuEditor);
  RegisterComponents('Dev Express', [TcxGridPopupMenu]);
end;

{ TcxGridPopupMenuEditor }

function TcxGridPopupMenuEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'ExpressQuantumGrid Suite ' + cxGridVersion;
    1: Result := 'www.devexpress.com';
  end;
end;

function TcxGridPopupMenuEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TcxGridPopupMenuProperty }

procedure TcxGridPopupMenuProperty.GetValues(Proc: TGetStrProc);
begin
  FGetValuesStrProc := Proc;
  try
    Designer.GetComponentNames(GetTypeData(GetPropType), ReceiveComponentNames);
  finally
    FGetValuesStrProc := nil;
  end;
end;

procedure TcxGridPopupMenuProperty.ReceiveComponentNames(const S: string);
var
  AComponent: TComponent;
begin
  AComponent := Designer.GetComponent(S);
  if Assigned(FGetValuesStrProc) and Assigned(AComponent) and
    (Supports(AComponent, IDoPopup) or (AComponent.ClassName = 'TPopupMenu') or
    (AComponent.ClassName = 'TdxBarPopupMenu')) then
      FGetValuesStrProc(S);
end;

end.
