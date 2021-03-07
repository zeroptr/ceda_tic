{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System(tm) COMPONENT SUITE                  }
{                                                                   }
{       Copyright (C) 1998-2009 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPSPopupMan;

interface

{$I cxVer.inc}

uses
  Classes, Controls, Windows, Menus, dxBase, dxPSSngltn;

type
  TdxPSPopupMenuBuilderClass = class of TAbstractdxPSPopupMenuBuilder;

  TAbstractdxPSPopupMenuBuilder = class
  protected
    function BuildPopup(const AControl: TControl; 
      const APopupMenu: TPopupMenu): TComponent; virtual; abstract;
    class function CanShowPopup(const APopupMenu: TPopupMenu): Boolean; virtual; 
    procedure FreePopup(var APopupMenu: TComponent); virtual; abstract;
    procedure InvokePopup(const X, Y: Integer; const AControl: TControl; 
      const APopupMenu: TComponent); virtual; abstract;
    class function RequireProcessDoPopup: Boolean; virtual;
  public
    constructor Create; virtual;
  end;

  TdxStandardPSPopupMenuBuilder = class(TAbstractdxPSPopupMenuBuilder)
  protected
    function BuildPopup(const AControl: TControl; 
      const APopupMenu: TPopupMenu): TComponent; override;
    procedure FreePopup(var APopupMenu: TComponent); override;
    procedure InvokePopup(const X, Y: Integer; const AControl: TControl; 
      const APopupMenu: TComponent); override;
  end;

  TdxPSPopupMenuController = class(TBasedxPSSingleton)
  private
    FBuilders: TdxClassList;
    FControls: TList;
    FKbdHook: HHOOK;
    FMouseHook: HHOOK;
    FNexus: TComponent;
    function GetActiveBuilder: TdxPSPopupMenuBuilderClass;
    function GetBuilder(Index: Integer): TdxPSPopupMenuBuilderClass;
    function GetBuilderCount: Integer;
    function GetControl(Index: Integer): TControl;
    function GetControlCount: Integer;

    procedure FreeAndNilControls;
  protected  
    procedure FinalizeInstance; override;
    procedure InitializeInstance; override;
    
    function IndexOfControl(AControl: TControl): Integer;
    procedure Notification(AComponent: TComponent; AOperation: TOperation);
    function TryShowPopup(AControl: TControl; Pt: TPoint): Boolean;
    
    property Nexus: TComponent read FNexus;
  public
    class function Instance: TdxPSPopupMenuController; reintroduce; overload;

    procedure ShowPopup(const X, Y: Integer; const AControl: TControl; const APopupMenu: TPopupMenu);
    procedure ShowPopupAtMousePos(const AControl: TControl; const APopupMenu: TPopupMenu);

    procedure RegisterBuilder(ABuilder: TdxPSPopupMenuBuilderClass);
    procedure UnregisterBuilder(ABuilder: TdxPSPopupMenuBuilderClass);
        
    procedure RegisterControl(AControl: TControl);
    procedure UnregisterControl(AControl: TControl);

    property ActiveBuilder: TdxPSPopupMenuBuilderClass read GetActiveBuilder;
    property BuilderCount: Integer read GetBuilderCount;    
    property Builders[Index: Integer]: TdxPSPopupMenuBuilderClass read GetBuilder;
    property ControlCount: Integer read GetControlCount;
    property Controls[Index: Integer]: TControl read GetControl;
  end;

function dxPSPopupMenuController: TdxPSPopupMenuController;

implementation

uses
  SysUtils, Messages, Forms, dxPSGlbl, dxPSUtl;

type 
  TdxPSPopupMenuControllerNexus = class(TComponent)
  private
    FController: TdxPSPopupMenuController;
    constructor CreateEx(AController: TdxPSPopupMenuController);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    property Controller: TdxPSPopupMenuController read FController;
  end;
  
function dxPSPopupMenuController: TdxPSPopupMenuController;  
begin
  Result := TdxPSPopupMenuController.Instance;
end;

{$IFDEF DELPHI5}
procedure EatWMContextMenu(Wnd: HWND);
var
  Msg: TMsg;
begin
  PeekMessage(Msg, Wnd, WM_CONTEXTMENU, WM_CONTEXTMENU, PM_REMOVE);
end;
{$ENDIF}

function dxPSPopupManKbdHook(Code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT;  stdcall; 

  function IsProcessKey(AKey, AKeyData: Longint; AKeyPressed: Boolean): Boolean;
  begin
    Result := 
      ((AKey = VK_F10) and (GetAsyncKeyState(VK_SHIFT) < 0)) or 
      ((AKey = VK_APPS) and ((AKeyData shr 29) and 1 <> 1));
  end;

 function GetVCLControl(Wnd: HWND): TWinControl;
 begin
   repeat
     Result := FindControl(Wnd);
     if Result <> nil then Exit;
     Wnd := GetParent(Wnd);
   until Wnd = 0;
 end;
  
const 
  KbdMessages: array[Boolean] of Cardinal = (WM_KEYUP, WM_KEYDOWN);
var
  KeyPressed: Boolean;
  Wnd: HWND;
  Control: TWinControl;
  R: LRESULT;
begin
  Result := 0;
  KeyPressed := (lParam shr 31) and 1 <> 1;
  if (Code >= 0) and IsProcessKey(wParam, lParam, KeyPressed) then 
  begin 
    Wnd := GetFocus;
    Control := GetVCLControl(Wnd);
    if Control <> nil then 
    begin          
      if dxPSPopupMenuController.IndexOfControl(Control) > -1 then 
      begin
       {$IFDEF DELPHI5}
        EatWMContextMenu(Wnd);
       {$ENDIF}
        dxPSPopupMenuController.TryShowPopup(Control, Control.ClientToScreen(NullPoint));
        Result := 1;
      end;
    end;  
  end;  
  R := CallNextHookEx(dxPSPopupMenuController.FKbdHook, Code, wParam, lParam);
  if Result = 0 then Result := R;
end;
   
function dxPSPopupManMouseHook(Code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT;   stdcall; 
 
  function FindControl(Wnd: HWND; const Pt: TPoint): TControl;

    function IsRegisteredControl(AControl: TControl; const Pt: TPoint): Boolean;
    begin
      Result := PtInRect(AControl.ClientRect, AControl.ScreenToClient(Pt)) and
        (dxPSPopupMenuController.IndexOfControl(AControl) > -1);
    end;

    function FindInChildren(AControl: TWinControl; const Pt: TPoint): TControl;
    var
      I: Integer;
    begin
      for I := 0 to AControl.ControlCount - 1 do 
      begin
        Result := AControl.Controls[I];
        if IsRegisteredControl(Result, Pt) then Exit;
      end;
      Result := nil;
    end;
  
    function FindInParents(AControl: TWinControl; const Pt: TPoint): TWinControl;
    begin
      Result := AControl;
      while Result <> nil do
      begin
        if IsRegisteredControl(Result, Pt) then Exit;
        Result := Result.Parent;
      end;
    end;
    
  var 
    TargetControl: TWinControl;  
  begin
    Result := nil;
    TargetControl := Controls.FindControl(Wnd);
    if TargetControl = nil then Exit;
    Result := FindInChildren(TargetControl, Pt);
    if Result = nil then 
    begin
      Result := TargetControl;    
      if dxPSPopupMenuController.IndexOfControl(Result) > -1 then Exit;
      Result := FindInParents(TargetControl, Pt);
    end;
  end;
  
var
  MouseHookStruct: TMouseHookStruct;
  Control: TControl;
  Rslt: LRESULT;
begin
  Result := 0;
  if (Code >= 0) and ((wParam = WM_RBUTTONUP) or (wParam = WM_RBUTTONDOWN)) then
  begin
    MouseHookStruct := PMouseHookStruct(lParam)^;
    with MouseHookStruct do 
    begin    
      Control := FindControl(HWND, Pt);
      if Control <> nil then 
      begin
        if wParam = WM_RBUTTONUP then 
        begin
          (*{$IFDEF DELPHI5}
          EatWMContextMenu(HWND);
          {$ENDIF}*)
          dxPSPopupMenuController.TryShowPopup(Control, Pt);
        end;
        Result := 1;
      end;  
    end;
  end;  
  Rslt := CallNextHookEx(dxPSPopupMenuController.FMouseHook, Code, wParam, lParam);
  if Result = 0 then Result := Rslt;
end;

{ TdxPSPopupMenuControllerNexus }

constructor TdxPSPopupMenuControllerNexus.CreateEx(AController: TdxPSPopupMenuController);
begin
  inherited Create(nil);
  FController := AController;
end;
    
procedure TdxPSPopupMenuControllerNexus.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited;
  Controller.Notification(AComponent, AOperation);
end;

{ TdxPSPopupMenuController }

class function TdxPSPopupMenuController.Instance: TdxPSPopupMenuController;
begin
  Result := inherited Instance as TdxPSPopupMenuController;
end;

procedure TdxPSPopupMenuController.ShowPopup(const X, Y: Integer; 
  const AControl: TControl; const APopupMenu: TPopupMenu);
var
  PopupMenuBuilder: TAbstractdxPSPopupMenuBuilder;
  PopupMenu: TComponent;
begin
  if APopupMenu = nil then Exit;

  if AControl <> nil then 
    dxPSUtl.Control_SendCancelMode(AControl, nil);
   
  if ActiveBuilder.RequireProcessDoPopup then 
    dxPSUtl.PopupMenu_DoPopup(APopupMenu);
                          
  PopupMenuBuilder := ActiveBuilder.Create;
  with PopupMenuBuilder do
  try
    PopupMenu := BuildPopup(AControl, APopupMenu);
    if PopupMenu <> nil then
    try
      try
        InvokePopup(X, Y, AControl, PopupMenu);
      except
        Application.HandleException(Self);
      end;  
    finally
      FreePopup(PopupMenu);
    end;  
  finally
    Free;
  end;  
end;

procedure TdxPSPopupMenuController.ShowPopupAtMousePos(const AControl: TControl; 
  const APopupMenu: TPopupMenu);
begin
  with Mouse.CursorPos do 
    ShowPopup(X, Y, AControl, APopupMenu);
end;  

procedure TdxPSPopupMenuController.RegisterBuilder(ABuilder: TdxPSPopupMenuBuilderClass);
begin
  FBuilders.Add(ABuilder);
end;

procedure TdxPSPopupMenuController.UnregisterBuilder(ABuilder: TdxPSPopupMenuBuilderClass);
begin
  FBuilders.Remove(ABuilder);
end;

procedure TdxPSPopupMenuController.RegisterControl(AControl: TControl);
begin
  if (AControl <> nil) and (IndexOfControl(AControl) = -1) then 
  begin 
    FControls.Add(AControl);
    AControl.FreeNotification(Nexus);
  end;
end;    

procedure TdxPSPopupMenuController.UnregisterControl(AControl: TControl);
begin
  FControls.Remove(AControl);
 {$IFDEF DELPHI5}
  if (AControl <> nil) and (Nexus <> nil) then 
    AControl.RemoveFreeNotification(Nexus);
 {$ENDIF} 
end;    

procedure TdxPSPopupMenuController.FinalizeInstance;
begin
  if FMouseHook <> 0 then UnhookWindowsHookEx(FMouseHook);  
  if FKbdHook <> 0 then UnhookWindowsHookEx(FKbdHook);
  FreeAndNil(FBuilders);
  FreeAndNilControls;
  FreeAndNil(FNexus);
  inherited;
end;

procedure TdxPSPopupMenuController.InitializeInstance;
begin
  inherited;
  FBuilders := TdxClassList.Create;
  FControls := TList.Create; 
  FKbdHook := SetWindowsHookEx(WH_KEYBOARD, dxPSPopupManKbdHook, 0, GetCurrentThreadId);
  FMouseHook := SetWindowsHookEx(WH_MOUSE, dxPSPopupManMouseHook, 0, GetCurrentThreadId);
  FNexus := TdxPSPopupMenuControllerNexus.CreateEx(Self);
end;

function TdxPSPopupMenuController.IndexOfControl(AControl: TControl): Integer;
begin
  Result := FControls.IndexOf(AControl);
end;

procedure TdxPSPopupMenuController.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  if (AOperation = opRemove) and (AComponent is TControl) then
    UnregisterControl(TControl(AComponent));
end;

function TdxPSPopupMenuController.TryShowPopup(AControl: TControl; Pt: TPoint): Boolean;

  function GetPopupMenu(var AControl: TControl): TPopupMenu;
  begin
    if AControl <> nil then 
    begin
      Result := dxPSUtl.Control_GetPopupMenu(AControl);
      while (Result = nil) and (AControl.Parent <> nil) do 
      begin
        AControl := AControl.Parent;
        Result := dxPSUtl.Control_GetPopupMenu(AControl);
      end;
    end
    else
      Result := nil;
  end;

  function CheckPopupMenu(AControl: TControl; const Pt: TPoint): TPopupMenu;
  begin
    Result := GetPopupMenu(AControl);
    if (Result <> nil) and not Result.AutoPopup then 
      Result := nil;
      
    if (Result <> nil) and (Pt.X >= 0) and 
      not PtInRect(AControl.ClientRect, AControl.ScreenToClient(Pt)) then
      Result := nil;
  end;
  
var 
  PopupMenu: TPopupMenu; 
begin
  PopupMenu := CheckPopupMenu(AControl, Pt);
  Result := (PopupMenu <> nil) and ActiveBuilder.CanShowPopup(PopupMenu);
  if not Result then Exit;
  dxPSUtl.Control_DoContextPopup(AControl, Pt, Result);
  if Result then Exit;

  Result := True;
  if Pt.X < 0 then 
    Pt := AControl.ClientToScreen(NullPoint);
  ShowPopup(Pt.X, Pt.Y, AControl, PopupMenu);
end;

function TdxPSPopupMenuController.GetActiveBuilder: TdxPSPopupMenuBuilderClass;
begin
  if BuilderCount <> 0 then 
    Result := Builders[BuilderCount - 1]
  else
    Result := TdxStandardPSPopupMenuBuilder;
end;

function TdxPSPopupMenuController.GetBuilder(Index: Integer): TdxPSPopupMenuBuilderClass;
begin
  Result := TdxPSPopupMenuBuilderClass(FBuilders[Index]);
end;

function TdxPSPopupMenuController.GetBuilderCount: Integer;
begin
  Result := FBuilders.Count;
end;

function TdxPSPopupMenuController.GetControl(Index: Integer): TControl;
begin
  Result := TControl(FControls[Index]);
end;

function TdxPSPopupMenuController.GetControlCount: Integer;
begin
  Result := FControls.Count;
end;

procedure TdxPSPopupMenuController.FreeAndNilControls;
begin
  while ControlCount > 0 do 
    UnregisterControl(Controls[ControlCount - 1]);
  FreeAndNil(FControls);
end;

{ TAbstractdxPSPopupMenuBuilder }      

constructor TAbstractdxPSPopupMenuBuilder.Create;
begin
  inherited Create;
end;

class function TAbstractdxPSPopupMenuBuilder.CanShowPopup(const APopupMenu: TPopupMenu): Boolean;
begin
  Result := True;
end;

class function TAbstractdxPSPopupMenuBuilder.RequireProcessDoPopup: Boolean;
begin
  Result := False;
end;

{ TdxStandardPSPopupMenuBuilder }
                                                 
function TdxStandardPSPopupMenuBuilder.BuildPopup(const AControl: TControl; 
  const APopupMenu: TPopupMenu): TComponent;
begin
  Result := APopupMenu;
  TPopupMenu(Result).PopupComponent := AControl;
end;
  
procedure TdxStandardPSPopupMenuBuilder.FreePopup(var APopupMenu: TComponent);
begin
end;

procedure TdxStandardPSPopupMenuBuilder.InvokePopup(const X, Y: Integer; 
  const AControl: TControl; const APopupMenu: TComponent);
begin
  TPopupMenu(APopupMenu).Popup(X, Y);
end;

initialization
  dxPSPopupMenuController.RegisterBuilder(TdxStandardPSPopupMenuBuilder);
  
end.
