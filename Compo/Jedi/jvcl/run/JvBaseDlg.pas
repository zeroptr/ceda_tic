{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvBaseDlg.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse att buypin dott com]
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvBaseDlg.pas 11567 2007-11-14 23:24:35Z ahuser $

unit JvBaseDlg;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Dialogs,
  JVCLVer, JvComponentBase;

type

  TJvCommonDialog = class(TCommonDialog)
  private
    FAboutJVCL: TJVCLAboutInfo;
  published
    property AboutJVCL: TJVCLAboutInfo read FAboutJVCL write FAboutJVCL stored False;
  end;

  TJvCommonDialogP = class(TJvCommonDialog)
  public
//    procedure Execute; virtual; abstract;
  end;

  // (rom) alternative to TJvCommonDialogP
  TJvCommonDialogF = class(TJvCommonDialog)
  public
//    function Execute: Boolean; virtual; abstract;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/run/JvBaseDlg.pas $';
    Revision: '$Revision: 11567 $';
    Date: '$Date: 2007-11-15 00:24:35 +0100 (jeu., 15 nov. 2007) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

