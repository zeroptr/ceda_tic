{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvImageDlg.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse att buypin dott com]
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvImageDlg.pas 11413 2007-07-11 20:23:46Z ahuser $

unit JvImageDlg;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  SysUtils, Classes,
  Graphics, Controls, Forms, ExtCtrls,
  jpeg,
  JvBaseDlg, JvComponent, JvTypes;

type
  TJvImageDialog = class(TJvCommonDialogP)
  private
    FPicture: TPicture;
    FTitle: string;
    function GetPicture: TPicture;
    procedure SetPicture(const Value: TPicture);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Picture: TPicture read GetPicture write SetPicture;
    property Title: string read FTitle write FTitle;
    function Execute: Boolean; override;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/run/JvImageDlg.pas $';
    Revision: '$Revision: 11413 $';
    Date: '$Date: 2007-07-11 22:23:46 +0200 (mer., 11 juil. 2007) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  JvConsts, JvResources, JvExForms;

constructor TJvImageDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPicture := nil;
  FTitle := RsImageTitle;
end;

destructor TJvImageDialog.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;

function TJvImageDialog.Execute: Boolean;
var
  Form: TJvForm;
  Image1: TImage;
begin
  Result := False;
  if (Picture.Height <> 0) and (Picture.Width <> 0) then
  begin
    Form := TJvForm.CreateNew(Self);
    try
      Form.BorderStyle := bsDialog;
      Form.BorderIcons := [biSystemMenu];
      Form.Position := poScreenCenter;
      Image1 := TImage.Create(Form);
      Image1.Picture.Assign(Picture);
      Image1.Parent := Form;
      Form.ClientHeight := Picture.Height;
      Form.ClientWidth := Picture.Width;
      Form.Caption := FTitle;
      Image1.SetBounds(0,0,Picture.Width,Picture.Height);
      Image1.Anchors := [akTop, akLeft, akRight, akBottom];
      Result := Form.ShowModal = mrOk;
    finally
      Form.Free;
    end;
  end;
end;

function TJvImageDialog.GetPicture: TPicture;
begin
  if FPicture = nil then
    FPicture := TPicture.Create;
  Result := FPicture;
end;

procedure TJvImageDialog.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

