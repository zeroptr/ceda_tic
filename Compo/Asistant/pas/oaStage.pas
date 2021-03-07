{------------------------------------------------------------------------------}
{                                                                              }
{  Office Assistant                                                            }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

{$I DELPHIAREA.INC}

unit oaStage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, oaDirect;

type

  THintBulb = class;

  TAssistantStage = class(TCustomForm)
  private
    Director: TAssistantDirector;
    fHintBulb: THintBulb;
    fVisible: Boolean;
    fAppActive: Boolean;
    fAlwaysOnTop: Boolean;
    fDraggable: Boolean;
    fDragging: Boolean;
    fOnBeginDrag: TNotifyEvent;
    fOnDragging: TNotifyEvent;
    fOnEndDrag: TNotifyEvent;
    procedure WMMoving(var Message: TMessage); message WM_MOVING;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMEnable(var Message: TWMEnable); message WM_ENABLE;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMActivateApp(var Message: TWMActivateApp); message WM_ACTIVATEAPP;
    {$IFDEF COMPILER4_UP}
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    {$ENDIF}
    procedure SetVisible(Value: Boolean);
  protected
    function GetPalette: HPALETTE; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AssistantDirector: TAssistantDirector);
      {$IFDEF COMPILER4_UP} reintroduce; {$ENDIF}
    procedure BringToFront;
    procedure RefreshRegion;
    property HintBulb: THintBulb read fHintBulb;
    property AppActive: Boolean read fAppActive;
    property IsDragging: Boolean read fDragging;
    property AlwaysOnTop: Boolean read fAlwaysOnTop write fAlwaysOnTop;
    property Draggable: Boolean read fDraggable write fDraggable;
    property Visible: Boolean read fVisible write SetVisible;
    property PopupMenu;
    property OnClick;
    property OnDblClick;
    property OnBeginDrag: TNotifyEvent read fOnBeginDrag write fOnBeginDrag;
    property OnDragging: TNotifyEvent read fOnDragging write fOnDragging;
    property OnEndDrag: TNotifyEvent read fOnEndDrag write fOnEndDrag;
    property OnShow;
    property OnHide;
    property OnMouseUp;
    property OnMouseDown;
    property OnActivate;
    property OnDeactivate;
    property OnResize;
  end;

  THintBulbState = (bsUp, bsDisabled, bsDown, bsHot);

  THintBulb = class(TCustomControl)
  private
    Glyphs: TBitmap;
    fRegion: HRGN;
    fState: THintBulbState;
    fMouseIsDown: Boolean;
    fVisible: Boolean;
    procedure SetVisible(Value: Boolean);
    procedure SetState(Value: THintBulbState);
  protected
    procedure Paint; override;
    procedure CreateWnd; override;
    function GetPalette: HPALETTE; override;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    property State: THintBulbState read fState write SetState;
    property MouseIsDown: Boolean read fMouseIsDown;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Region: HRGN read fRegion;
    property Visible: Boolean read fVisible write SetVisible;
    property OnClick;
  end;

implementation

{$R *.RES}

uses
  oaBitmap, oaEngine;

{ THintBulb }

constructor THintBulb.Create(AOwner: TComponent);
var
  TmpBmp: TBitmap;
begin
  inherited Create(AOwner);
  Glyphs := TBitmap.Create;
  Glyphs.LoadFromResourceName(hInstance, 'BULBGLYPHS256');
  SetBounds(0, 0, Glyphs.Width div 4, Glyphs.Height);
  TmpBmp := TBitmap.Create;
  try
    TmpBmp.Width := Width;
    TmpBmp.Height := Height;
    BitBlt(TmpBmp.Canvas.Handle, 0, 0, Width, Height,
           Glyphs.Canvas.Handle, 0, 0, SRCCOPY);
    fRegion := CreateBitmapRgn(TmpBmp, TmpBmp.TransparentColor);
  finally
    TmpBmp.Free;
  end;
  fState := bsUp;
  inherited Visible := False;
end;

destructor THintBulb.Destroy;
begin
  DeleteObject(Region);
  Glyphs.Free;
  inherited Destroy;
end;

procedure THintBulb.SetVisible(Value: Boolean);
begin
  if Visible <> Value then
  begin
    fVisible := Value;
    TAssistantStage(Parent).RefreshRegion;
    inherited Visible := Visible;
    if Visible then UpdateWindow(WindowHandle);
  end;
end;

procedure THintBulb.SetState(Value: THintBulbState);
begin
  if State <> Value then
  begin
    fState := Value;
    if Visible then
    begin
      InvalidateRgn(WindowHandle, Region, False);
      UpdateWindow(WindowHandle);
    end;
  end;
end;

procedure THintBulb.Paint;
begin
  BitBlt(Canvas.Handle, 0, 0, Width, Height,
         Glyphs.Canvas.Handle, Ord(State) * Width, 0, SRCCOPY);
end;

procedure THintBulb.CreateWnd;
var
  TmpRgn: HRGN;
begin
  inherited CreateWnd;
  TmpRgn := CreateRectRgn(0, 0, 0, 0);
  CombineRgn(TmpRgn, Region, 0, RGN_COPY);
  SetWindowRgn(WindowHandle, TmpRgn, False);
end;

function THintBulb.GetPalette: HPALETTE;
begin
  Result := Glyphs.Palette;
end;

procedure THintBulb.CMEnabledChanged(var Message: TMessage);
var
  MousePos: TPoint;
begin
  inherited;
  fMouseIsDown := False;
  if not Enabled then
    State := bsDisabled
  else
  begin
    GetCursorPos(MousePos);
    if WindowFromPoint(MousePos) = WindowHandle then
      State := bsHot
    else
      State := bsUp;
  end;
end;

procedure THintBulb.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if Enabled then
  begin
    fMouseIsDown := (GetCapture = WindowHandle);
    if MouseIsDown then
      State := bsDown
    else
      State := bsHot;
  end;
end;

procedure THintBulb.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if Enabled then State := bsUp;
end;

procedure THintBulb.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Enabled and (Button = mbLeft) then
  begin
    fMouseIsDown := True;
    State := bsDown;
  end;
end;

procedure THintBulb.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Enabled and (Button = mbLeft) and fMouseIsDown then
  begin
    fMouseIsDown := False;
    State := bsUp;
  end;
end;

{ TAssistantStage }

const
  TopMost: array[Boolean] of DWORD = (HWND_TOP, HWND_TOPMOST);

constructor TAssistantStage.Create(AssistantDirector: TAssistantDirector);
begin
  inherited CreateNew(nil);
  inherited Visible := False;
  Director := AssistantDirector;
  fHintBulb := THintBulb.Create(Self);
  fHintBulb.Parent := Self;
  fHintBulb.Visible := False;
  fDraggable := True;
  fAlwaysOnTop := True;
  fAppActive := Application.Active;
  BorderStyle := bsNone;
  {$IFDEF COMPILER4_UP}
  DefaultMonitor := dmDesktop;
  {$ENDIF}
end;

function TAssistantStage.GetPalette: HPALETTE;
begin
  Result := Director.Actor.Palette;
end;

procedure TAssistantStage.CreateParams(var Params: TCreateParams);
const
  WS_EX_NOACTIVATE = $08000000;
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if ParentWindow = 0 then
    begin
      WndParent := 0;
      Style := WS_POPUP;
    end
    else
      Style := WS_CHILD;
    // Windows 2000/XP
    if (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 5) then
      ExStyle := WS_EX_NOACTIVATE
    else
      ExStyle := 0;
    with WindowClass do
      Style := CS_NOCLOSE or CS_OWNDC;
  end;
end;

procedure TAssistantStage.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if Draggable and (Shift = [ssLeft]) then
  begin
    ReleaseCapture;
    fDragging := True;
    try
      if Assigned(fOnBeginDrag) then
        fOnBeginDrag(Self);
      try
        Perform(WM_SYSCOMMAND, $F012, 0);
      finally
        if Assigned(fOnEndDrag) then
          fOnEndDrag(Self);
      end;
    finally
      fDragging := True;
    end;
  end
  else
    inherited;
end;

procedure TAssistantStage.WMMoving(var Message: TMessage);
begin
  inherited;
  if IsDragging and Assigned(fOnDragging) then
    fOnDragging(Self);
end;

procedure TAssistantStage.WMSize(var Message: TWMSize);
begin
  if HintBulb <> nil then
    HintBulb.Left := Width - HintBulb.Width;
  if Visible then
    RefreshRegion;
  inherited;
end;

procedure TAssistantStage.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TAssistantStage.WMPaint(var Message: TWMPaint);
var
  PS: TPAINTSTRUCT;
  DC: HDC;
begin
  if Message.DC = 0 then
  begin
    DC := BeginPaint(WindowHandle, PS);
    try
      Director.Engine.DrawFrame(DC, 0, 0);
    finally
      EndPaint(WindowHandle, PS);
    end;
  end
  else
    Director.Engine.DrawFrame(Message.DC, 0, 0);
end;

procedure TAssistantStage.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if not Enabled then
    Message.Result := htNoWhere
  else
    Message.Result := htClient;
end;

procedure TAssistantStage.WMMouseActivate(var Message: TWMMouseActivate);
begin
  if ParentWindow = 0 then
    if AppActive or IsIconic(Application.Handle) then
      Message.Result := MA_NOACTIVATE
    else
    begin
      Application.BringToFront;
      Message.Result := MA_NOACTIVATEANDEAT;
    end
  else
    inherited;
end;

procedure TAssistantStage.WMActivate(var Message: TWMActivate);

  procedure ActivateAppWindow;
  begin
    if (Screen.ActiveForm <> nil) and Screen.ActiveForm.Showing then
      SetActiveWindow(Screen.ActiveForm.Handle)
    else if (Application.MainForm <> nil) and Application.MainForm.Showing then
      SetActiveWindow(Application.MainForm.Handle);
  end;

begin
  if (Message.Active <> WA_INACTIVE) and (ParentWindow = 0) then
  begin
    if (GetWindowThreadProcessId(Message.ActiveWindow, nil) = MainThreadID) or
       (FindControl(Message.ActiveWindow) <> nil) then
    begin
      if IsWindowVisible(Message.ActiveWindow) then
        SetActiveWindow(Message.ActiveWindow)
      else
        ActivateAppWindow;
    end
    else
    begin
      Application.BringToFront;
      ActivateAppWindow;
    end;
    Message.Result := 0;
  end
  else
    inherited;
end;

procedure TAssistantStage.WMActivateApp(var Message: TWMActivateApp);
const
  TopState: array[Boolean] of DWORD = (HWND_NOTOPMOST, HWND_TOPMOST);
begin
  inherited;
  fAppActive := Message.Active;
  if (ParentWindow = 0) and Visible then
  begin
    SetWindowPos(WindowHandle, TopState[AppActive or AlwaysOnTop], 0, 0, 0, 0,
      SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOSENDCHANGING);
    UpdateWindow(WindowHandle);
  end;
end;

procedure TAssistantStage.WMEnable(var Message: TWMEnable);
begin
  inherited;
  if not Message.Enabled and Visible and (ParentWindow = 0) then
    EnableWindow(WindowHandle, True);
end;

{$IFDEF COMPILER4_UP}
procedure TAssistantStage.CMBiDiModeChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(PopupMenu) then PopupMenu.BiDiMode := BiDiMode;
end;
{$ENDIF}

procedure TAssistantStage.SetVisible(Value: Boolean);
begin
  if Visible <> Value then
  begin
    HandleNeeded;
    fVisible := Value;
    if Visible then
    begin
      RefreshRegion;
      if GetCurrentThreadID = MainThreadID then
      begin
        SetWindowPos(WindowHandle, TopMost[ParentWindow = 0], 0, 0, 0, 0,
          SWP_NOMOVE or SWP_NOSIZE or SWP_NOOWNERZORDER or SWP_SHOWWINDOW or
          SWP_NOACTIVATE or SWP_NOSENDCHANGING);
        inherited Visible := True;
      end
      else
        ShowWindowAsync(WindowHandle, SW_SHOWNOACTIVATE);
    end
    else
    begin
      if GetCurrentThreadID = MainThreadID then
        inherited Visible := False
      else
        ShowWindowAsync(WindowHandle, SW_HIDE);
    end;
  end;
end;

procedure TAssistantStage.BringToFront;
begin
  if Visible then
  begin
    SetWindowPos(WindowHandle, TopMost[ParentWindow = 0], 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOOWNERZORDER or SWP_SHOWWINDOW or
      SWP_NOACTIVATE or SWP_NOSENDCHANGING);
  end;
end;

procedure TAssistantStage.RefreshRegion;
var
  TmpRgn: HRGN;
begin
  if WindowHandle <> 0 then
  begin
    TmpRgn := CreateRectRgn(0, 0, 0, 0);
    if Director.Engine.Region <> 0 then
    begin
      if HintBulb.Visible then
      begin
        CombineRgn(TmpRgn, HintBulb.Region, 0, RGN_COPY);
        OffsetRgn(TmpRgn, HintBulb.Left, HintBulb.Top);
        CombineRgn(TmpRgn, TmpRgn, Director.Engine.Region, RGN_OR);
      end
      else
        CombineRgn(TmpRgn, Director.Engine.Region, 0, RGN_COPY);
      InvalidateRgn(WindowHandle, Director.Engine.Region, False);
    end;
    SetWindowRgn(WindowHandle, TmpRgn, True);
  end;
end;

end.
