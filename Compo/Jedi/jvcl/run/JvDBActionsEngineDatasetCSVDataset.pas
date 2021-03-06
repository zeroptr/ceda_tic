{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvDBActionsEngineDatasetCSVDataset.Pas, released on 2004-12-30.

The Initial Developer of the Original Code is Jens Fudickar [jens dott fudicker  att oratool dott de]
Portions created by Jens Fudickar are Copyright (C) 2002 Jens Fudickar.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvDBActionsEngineDatasetCSVDataset.pas 11641 2007-12-24 16:34:00Z outchy $

unit JvDBActionsEngineDatasetCSVDataset;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Classes, DB,
  JvDBActionsEngine;

type
  TJvDatabaseActionCSVDatasetEngine = class(TJvDatabaseActionBaseDatasetEngine)
  public
    function GetSQL(AActionComponent : TComponent): string; override;
    function SupportsComponent(AActionComponent : TComponent): Boolean; override;
    function SupportsGetSQL(AActionComponent : TComponent): Boolean; override;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/run/JvDBActionsEngineDatasetCSVDataset.pas $';
    Revision: '$Revision: 11641 $';
    Date: '$Date: 2007-12-24 17:34:00 +0100 (lun., 24 déc. 2007) $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  JvCsvData;

function TJvDatabaseActionCSVDatasetEngine.GetSQL(AActionComponent :
    TComponent): string;
begin
  if Assigned(GetDataset(AActionComponent)) then
    Result := 'SELECT '+TJvCsvDataSet(GetDataset(AActionComponent)).CsvFieldDef+#13#10+
              '  FROM '+TJvCsvDataSet(GetDataset(AActionComponent)).filename;
end;

function TJvDatabaseActionCSVDatasetEngine.SupportsComponent(AActionComponent
    : TComponent): Boolean;
begin
  Result := (GetDataset(AActionComponent) is TJvCsvDataSet);
end;

function TJvDatabaseActionCSVDatasetEngine.SupportsGetSQL(AActionComponent :
    TComponent): Boolean;
begin
  Result := True;
end;


procedure InitActionEngineList;
begin
  RegisterDatabaseActionEngine(TJvDatabaseActionCSVDatasetEngine);
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

