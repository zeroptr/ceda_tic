{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvCommonExecDlg.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse att buypin dott com]
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvCommonExecDlg.pas 10612 2006-05-19 19:04:09Z jfudickar $

unit JvCommonExecDlg;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, Classes,
  JvBaseDlg;

type
  TJvCommonExecDialog = class(TJvCommonDialogP)
  private
    FOwnerWindow: THandle;
  public
    constructor Create(AOwner: TComponent); override;
    property OwnerWindow: THandle read FOwnerWindow;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/run/JvCommonExecDlg.pas $';
    Revision: '$Revision: 10612 $';
    Date: '$Date: 2006-05-19 21:04:09 +0200 (ven., 19 mai 2006) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  Controls, JvTypes;

constructor TJvCommonExecDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner is TWinControl then
    FOwnerWindow := (AOwner as TWinControl).Handle
  else
    FOwnerWindow := HWND_DESKTOP;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

