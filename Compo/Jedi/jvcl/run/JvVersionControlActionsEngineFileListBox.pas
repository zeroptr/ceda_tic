{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvVersionControlActionsEngineFileListBox.Pas, released on 2008-07-13.

The Initial Developer of the Original Code is Jens Fudickar [jens dott fudicker  att oratool dott de]
Portions created by Jens Fudickar are Copyright (C) 2002 Jens Fudickar.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvVersionControlActionsEngineFileListBox.pas 11916 2008-09-23 20:42:56Z jfudickar $

unit JvVersionControlActionsEngineFileListBox;

{$I jvcl.inc}
{$I windowsonly.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$IFDEF MSWINDOWS}
  Windows, ImgList, Graphics, ComCtrls,
  {$ENDIF MSWINDOWS}
  Forms, Controls, Classes, JvVersionControlActionsEngine;

type


  TjvVersionControlActionFileListBoxEngine = class(TjvVersionControlActionEngine)
  private
  protected
  public
    function GetFilename(aActionComponent: TComponent): string; override;
    function SupportsComponent(aActionComponent: TComponent): Boolean; override;
    function SupportsGetFileName(aActionComponent: TComponent): Boolean; override;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/run/JvVersionControlActionsEngineFileListBox.pas $';
    Revision: '$Revision: 11916 $';
    Date: '$Date: 2008-09-23 22:42:56 +0200 (mar., 23 sept. 2008) $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils, Grids, TypInfo,
  {$IFDEF HAS_UNIT_STRUTILS}
  StrUtils,
  {$ENDIF HAS_UNIT_STRUTILS}
  {$IFDEF HAS_UNIT_VARIANTS}
  Variants,
  {$ENDIF HAS_UNIT_VARIANTS}
  Dialogs, StdCtrls, Clipbrd, FileCtrl;


procedure InitActionEngineList;
begin
  RegisterVersionControlActionEngine (TjvVersionControlActionFileListBoxEngine);
end;

function TjvVersionControlActionFileListBoxEngine.SupportsComponent(aActionComponent:
    TComponent): Boolean;
begin
  Result := aActionComponent is TFilelistBox;
end;

function TjvVersionControlActionFileListBoxEngine.GetFilename(aActionComponent:
    TComponent): string;
begin
  Result := TFilelistBox(aActionComponent).FileName;
end;

function TjvVersionControlActionFileListBoxEngine.SupportsGetFileName(
    aActionComponent: TComponent): Boolean;
begin
  Result := True;
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

