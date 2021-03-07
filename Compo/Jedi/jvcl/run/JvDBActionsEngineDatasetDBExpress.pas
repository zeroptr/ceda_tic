{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvDBActionsEngineDatasetDBExpress.Pas, released on 2004-12-30.

The Initial Developer of the Original Code is Jens Fudickar [jens dott fudicker  att oratool dott de]
Portions created by Jens Fudickar are Copyright (C) 2002 Jens Fudickar.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvDBActionsEngineDatasetDBExpress.pas 11427 2007-07-29 19:16:10Z jfudickar $

unit JvDBActionsEngineDatasetDBExpress;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Controls, Classes, DB,
  JvDBActionsEngine;

type
  TJvDatabaseActionDBExpressDatasetEngine = class(TJvDatabaseActionBaseDatasetEngine)
  public
    function GetSQL(AActionComponent: TComponent): string; override;
    function SupportsComponent(AActionComponent: TComponent): Boolean; override;
    function SupportsGetSQL(AActionComponent: TComponent): Boolean; override;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/run/JvDBActionsEngineDatasetDBExpress.pas $';
    Revision: '$Revision: 11427 $';
    Date: '$Date: 2007-07-29 21:16:10 +0200 (dim., 29 juil. 2007) $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  SqlExpr;

function TJvDatabaseActionDBExpressDatasetEngine.GetSQL(AActionComponent:
    TComponent): string;
begin
  Result := TSQLQuery(AActionComponent).SQL.Text;
end;

function TJvDatabaseActionDBExpressDatasetEngine.SupportsComponent(
    AActionComponent: TComponent): Boolean;
begin
  Result := (AActionComponent is TSQLQuery);
end;

function TJvDatabaseActionDBExpressDatasetEngine.SupportsGetSQL(
    AActionComponent: TComponent): Boolean;
begin
  Result := True;
end;

procedure InitActionEngineList;
begin
  RegisterDatabaseActionEngine(TJvDatabaseActionDBExpressDatasetEngine);
end;

initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}
  InitActionEngineList;

finalization
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.

