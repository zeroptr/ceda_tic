{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvgAlignForm.PAS, released on 2003-01-15.

The Initial Developer of the Original Code is Andrey V. Chudin,  [chudin att yandex dott ru]
Portions created by Andrey V. Chudin are Copyright (C) 2003 Andrey V. Chudin.
All Rights Reserved.

Contributor(s):
Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvgAlignForm.pas 11476 2007-08-18 16:59:46Z ahuser $

unit JvgAlignForm;

{$I jvcl.inc}

interface

uses
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$ENDIF USEJVCL}
  Classes, Forms,
  {$IFDEF USEJVCL}
  JvComponent,
  {$ENDIF USEJVCL}
  JvgTypes, StdCtrls, Controls, ExtCtrls;

type
  {$IFDEF USEJVCL}
  TAlignForm = class(TJvForm)
  {$ELSE}
  TAlignForm = class(TForm)
  {$ENDIF USEJVCL}
    g_Horz: TRadioGroup;
    g_Vert: TRadioGroup;
    B_Ok: TButton;
    B_Cancel: TButton;
    procedure B_OkClick(Sender: TObject);
  public
    Horz: TglHComponentAlign;
    Vert: TglVComponentAlign;
  end;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/design/JvgAlignForm.pas $';
    Revision: '$Revision: 11476 $';
    Date: '$Date: 2007-08-18 18:59:46 +0200 (sam., 18 ao??t 2007) $';
    LogPath: 'JVCL\design'
  );
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

implementation

{$R *.dfm}

procedure TAlignForm.B_OkClick(Sender: TObject);
begin
  Horz := TglHComponentAlign(g_Horz.ItemIndex);
  Vert := TglVComponentAlign(g_Vert.ItemIndex);
end;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

end.

