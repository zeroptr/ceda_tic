{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvExButtons.pas, released on 2004-01-04

The Initial Developer of the Original Code is Andreas Hausladen [Andreas dott Hausladen att gmx dott de]
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvExButtons.pas 11802 2008-05-12 19:54:51Z ahuser $

unit JvExButtons;

{$I jvcl.inc}
{MACROINCLUDE JvExControls.macros}

WARNINGHEADER

interface

uses
  Windows, Messages,
  {$IFDEF HAS_UNIT_TYPES}
  Types,
  {$ENDIF HAS_UNIT_TYPES}
  SysUtils, Classes, Graphics, Controls, Forms, Buttons, StdCtrls,
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  JvConsts, JvTypes, JvThemes, JVCLVer, JvExControls;

type
  CONTROL_DECL_DEFAULT(SpeedButton)

  WINCONTROL_DECL_DEFAULT(BitBtn)

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/devtools/JvExVCL/src/JvExButtons.pas $';
    Revision: '$Revision: 11802 $';
    Date: '$Date: 2008-05-12 21:54:51 +0200 (lun., 12 mai 2008) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

CONTROL_IMPL_DEFAULT(SpeedButton)

WINCONTROL_IMPL_DEFAULT(BitBtn)

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
