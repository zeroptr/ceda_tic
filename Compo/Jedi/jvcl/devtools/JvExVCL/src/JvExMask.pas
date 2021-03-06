{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvExMask.pas, released on 2004-01-04

The Initial Developer of the Original Code is Andreas Hausladen [Andreas dott Hausladen att gmx dott de]
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvExMask.pas 11802 2008-05-12 19:54:51Z ahuser $

unit JvExMask;

{$I jvcl.inc}
{MACROINCLUDE JvExControls.macros}

WARNINGHEADER

interface

uses
  Windows, Messages,
  {$IFDEF HAS_UNIT_TYPES}
  Types,
  {$ENDIF HAS_UNIT_TYPES}
  SysUtils, Classes, Graphics, Controls, Forms, Mask,
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  JvConsts, JvTypes, JvThemes, JVCLVer, JvExControls;

type
  TJvExCustomMaskEdit = class(TCustomMaskEdit, IJvExControl)
  EDITCONTROL_DECL
  private
    FBeepOnError: Boolean;
  protected
    procedure DoBeepOnError; dynamic;
    procedure SetBeepOnError(Value: Boolean); virtual;
    property BeepOnError: Boolean read FBeepOnError write SetBeepOnError default True;
  end;

  TJvExMaskEdit = class(TMaskEdit, IJvExControl)
  EDITCONTROL_DECL
  private
    FBeepOnError: Boolean;
  protected
    procedure DoBeepOnError; dynamic;
    procedure SetBeepOnError(Value: Boolean); virtual;
    property BeepOnError: Boolean read FBeepOnError write SetBeepOnError default True;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/devtools/JvExVCL/src/JvExMask.pas $';
    Revision: '$Revision: 11802 $';
    Date: '$Date: 2008-05-12 21:54:51 +0200 (lun., 12 mai 2008) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

BEGIN_EDITCONTROL_CONSTRUCTOR(CustomMaskEdit)
  FBeepOnError := True;
END_CONSTRUCTOR

EDITCONTROL_IMPL(CustomMaskEdit)

EDITCONTROL_WNDPROC(CustomMaskEdit)

procedure TJvExCustomMaskEdit.DoBeepOnError;
begin
  if FBeepOnError then
    SysUtils.Beep;
end;

procedure TJvExCustomMaskEdit.SetBeepOnError(Value: Boolean);
begin
  FBeepOnError := Value;
end;

BEGIN_EDITCONTROL_CONSTRUCTOR(MaskEdit)
  FBeepOnError := True;
END_CONSTRUCTOR

EDITCONTROL_IMPL(MaskEdit)

EDITCONTROL_WNDPROC(MaskEdit)

procedure TJvExMaskEdit.DoBeepOnError;
begin
  if FBeepOnError then
    SysUtils.Beep;
end;

procedure TJvExMaskEdit.SetBeepOnError(Value: Boolean);
begin
  FBeepOnError := Value;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

{$UNDEF CONSTRUCTOR_CODE} // undefine at file end

end.
