{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvComponent.PAS, released on 2000-09-22.

The Initial Developer of the Original Code is Joe Doe .
Portions created by Joe Doe are Copyright (C) 1999 Joe Doe.
Portions created by XXXX Corp. are Copyright (C) 1998, 1999 XXXX Corp.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvComponent.pas 11567 2007-11-14 23:24:35Z ahuser $

unit JvComponent;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Classes,
  {$IFDEF USE_DXGETTEXT}
  JvGnugettext,
  {$ENDIF USE_DXGETTEXT}
  Windows, Messages, Controls, Forms,
  JvConsts,
  JVCLVer, JvComponentBase, JvExControls, JvExForms, JvExStdCtrls;

type
  TJvGraphicControl = TJvExGraphicControl;
  TJvPubGraphicControl = TJvExPubGraphicControl;
  TJvCustomControl = TJvExCustomControl;
  TJvWinControl = TJvExWinControl;

  TJvForm = class(TJvExForm)
  private
    FIsFocusable: Boolean;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure WMMouseActivate(var Msg: TMessage); message WM_MOUSEACTIVATE;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    {$IFDEF USE_DXGETTEXT}
    procedure RefreshTranslation; virtual;
    {$ENDIF USE_DXGETTEXT}

    function ShowModal: Integer; override;
      { ShowNoActivate() shows the form but does not activate it. }
    procedure ShowNoActivate(CallActivate: Boolean = False);
  published
    property IsFocusable: Boolean read FIsFocusable write FIsFocusable default True;
  end;

//=== { TJvPopupListBox } ====================================================

type
  TJvPopupListBox = class(TJvExCustomListBox)
  private
    FSearchText: string;
    FSearchTickCount: Longint;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/run/JvComponent.pas $';
    Revision: '$Revision: 11567 $';
    Date: '$Date: 2007-11-15 00:24:35 +0100 (jeu., 15 nov. 2007) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

{$IFDEF COMPILER6_UP}
uses
  RTLConsts;
{$ELSE}
uses
  Consts;
{$ENDIF COMPILER6_UP}

{$IFDEF USE_DXGETTEXT}
const
  cDomainName = 'jvcl';
{$ENDIF USE_DXGETTEXT}

//=== { TJvForm } ============================================================

constructor TJvForm.Create(AOwner: TComponent);
begin
//  inherited Create(AOwner);
  CreateNew(AOwner, 0);
  {$IFDEF CLR}
  GlobalNameSpace.AcquireWriterLock(MaxInt);
  {$ELSE}
  GlobalNameSpace.BeginWrite;
  {$ENDIF CLR}
  try
    if (ClassType <> TJvForm) and not (csDesigning in ComponentState) then
    begin
      Include(FFormState, fsCreating);
      try
        if not InitInheritedComponent(Self, TJvForm) then
          {$IFDEF CLR}
          raise EResNotFound.CreateFmt(SResNotFound, [ClassName]);
          {$ELSE}
          raise EResNotFound.CreateResFmt(@SResNotFound, [ClassName]);
         {$ENDIF CLR}

        {$IFDEF USE_DXGETTEXT}
        TranslateComponent(Self, cDomainName);
        {$ENDIF USE_DXGETTEXT}
      finally
        Exclude(FFormState, fsCreating);
      end;
      {$IFNDEF CLR}
      if OldCreateOrder then
      {$ENDIF !CLR}
        DoCreate;
    end;
  finally
    {$IFDEF CLR}
    GlobalNameSpace.ReleaseWriterLock;
    {$ELSE}
    GlobalNameSpace.EndWrite;
    {$ENDIF CLR}
  end;
end;

constructor TJvForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
  FIsFocusable := True;
end;

{$IFDEF USE_DXGETTEXT}

procedure TJvForm.RefreshTranslation;
begin
  ReTranslateComponent(Self, cDomainName);
end;

{$ENDIF USE_DXGETTEXT}

procedure TJvForm.CMShowingChanged(var Message: TMessage);
var
  NewParent: HWND;
begin
  if Showing and (FormStyle <> fsMDIChild) then
  begin
    if FormStyle = fsStayOnTop then
    begin
      // restore StayOnTop
      NewParent := Application.Handle;
      if GetWindowLong(Handle, GWL_HWNDPARENT) <> Longint(NewParent) then
        SetWindowLong(Handle, GWL_HWNDPARENT, Longint(NewParent));
      SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE);
    end
    else
    begin
      // Fixing the Window Ghosting "bug", only for forms that don't have a parent assigned (Mantis 4032)
      if not Assigned(Parent) then
      begin
        NewParent := 0;
        if Assigned(Screen.ActiveForm) and (Screen.ActiveForm <> Self) then
        begin
          if fsModal in Screen.ActiveForm.FormState then
            NewParent := Screen.ActiveForm.Handle;
        end;
        if (NewParent = 0) and Assigned(Application.MainForm) and (Application.MainForm <> Self) then
          NewParent := Application.MainForm.Handle;
        if NewParent = 0 then
          NewParent := Application.Handle;
        if GetWindowLong(Handle, GWL_HWNDPARENT) <> Longint(NewParent) then
          SetWindowLong(Handle, GWL_HWNDPARENT, Longint(NewParent));
      end;
    end;
  end;
  inherited;
end;

function TJvForm.ShowModal: Integer;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, WM_ENABLE, WM_ENABLE, PM_REMOVE) do
    DispatchMessage(Msg);
  Result := inherited ShowModal;
end;

procedure TJvForm.WMMouseActivate(var Msg: TMessage);
begin
  if IsFocusable then
    inherited
  else
    Msg.Result := MA_NOACTIVATE;
end;

procedure TJvForm.ShowNoActivate(CallActivate: Boolean);
begin
  if CallActivate then
    Activate;
  SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE);
  Visible := True;
end;

//=== { TJvPopupListBox } ====================================================

procedure TJvPopupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TJvPopupListBox.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
end;

procedure TJvPopupListBox.KeyPress(var Key: Char);
var
  TickCount: Int64;
begin
  case Key of
    BackSpace, Esc:
      FSearchText := '';
    #32..#255:
      begin
        TickCount := GetTickCount;
        if TickCount < FSearchTickCount then
          Inc(TickCount, $100000000); // (ahuser) reduces the overflow
        if TickCount - FSearchTickCount >= 4000 then
          FSearchText := '';
        FSearchTickCount := TickCount;
        if Length(FSearchText) < 32 then
          FSearchText := FSearchText + Key;
        {$IFNDEF CLR}
        SendMessage(Handle, LB_SELECTSTRING, WPARAM(-1), LPARAM(PChar(FSearchText)));
        {$ELSE}
        SendTextMessage(Handle, LB_SELECTSTRING, WPARAM(-1), FSearchText);
        {$ENDIF !CLR}
        Key := #0;
      end;
  end;
  inherited KeyPress(Key);
end;

initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}
  {$IFDEF USE_DXGETTEXT}
  AddDomainForResourceString(cDomainName);
  {$ENDIF USE_DXGETTEXT}

{$IFDEF UNITVERSIONING}
finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
