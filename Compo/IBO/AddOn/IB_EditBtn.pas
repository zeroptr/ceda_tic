unit IB_EditBtn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, IB_Controls;

type
  TButtonStyle = (lsNormal, lsEllipsis);

  TIB_EditBtn = class(TIB_Edit)
  private
    { Private declarations }
    fButtonWidth : integer;
    fButtonStyle : TButtonStyle;
    fPressed : boolean;
    fTracking : boolean;
    fOnButtonClick : TNotifyEvent;
    procedure StopTracking;
    procedure SetButtonStyle(Value: TButtonStyle);
    procedure TrackButton(X,Y: Integer);
    procedure WMPaint(var Message: TWMPaint); message WM_Paint;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
  protected
    { Protected declarations }
    procedure BoundsChanged;
    procedure EditButtonClick;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure PaintWindow(DC: HDC); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property ButtonStyle: TButtonStyle read fButtonStyle write SetButtonStyle default lsNormal;
    property OnButtonClick : TNotifyEvent read fOnButtonClick write fOnButtonClick;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TDL', [TIB_EditBtn]);
end;
constructor TIB_EditBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  fButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  fButtonStyle := lsNormal;
end; // Create

destructor TIB_EditBtn.Destroy;
begin
  inherited Destroy;
end; // Destroy

procedure TIB_EditBtn.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
    { in order to use the EM_SETRECT later, we must make the edit control
      a type MULTILINE }
  with Params do
  begin
    Style := Style or ES_MULTILINE;
  end;
end;  // CreateParams

procedure TIB_EditBtn.BoundsChanged;
var
  R: TRect;
begin
    { Determine the size of the text area in the control - it will
      be smaller by the width of the button if one is present }
  SetRect(R, 0, 0, ClientWidth - 2, ClientHeight + 1); // +1 is workaround for windows paint bug
  if (fButtonStyle <> lsNormal) and focused then Dec(R.Right, fButtonWidth);
  SendMessage(Handle, EM_SETRECT, 0, LongInt(@R));
  Repaint;
end; // BoundsChanged

procedure TIB_EditBtn.SetButtonStyle(Value: TButtonStyle);
begin
    { if the link style is different then change it,
      remember to redraw it if the control is currently
      focused }
  if Value = fButtonStyle then Exit;
  fButtonStyle := Value;
  if not HandleAllocated then exit;
  if focused or (csDesigning in ComponentState) then
    BoundsChanged;
end; // SetButtonStyle

procedure TIB_EditBtn.EditButtonClick;
begin
  if Assigned(fOnButtonClick) then fOnButtonClick(Self);
end; // EditButtonClick

procedure TIB_EditBtn.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
  inherited;
end; // WMPaint

procedure TIB_EditBtn.WMSetCursor(var Msg: TWMSetCursor);
var
  P: TPoint;
begin
    { Normally, the Edit control changes the Cursor to an I-bar when over
      the control.  We need to set it back to an arrow when over the button }
  if (fButtonStyle <> lsNormal)
  and PtInRect(Rect(Width - FButtonWidth - 4, 0, ClientWidth, ClientHeight), ScreenToClient(P)) then
    begin
    GetCursorPos(P);
    Windows.SetCursor(LoadCursor(0, idc_Arrow));
    end
  else
    inherited;
end; // WMSetCursor

procedure TIB_EditBtn.KeyDown(var Key: Word; Shift: TShiftState);
var
  Msg: TMsg;
begin
    { simulate the mouse pressing the ellipsis button from the
      keyboard by the user pressing CTRL+ENTER }
  if  (fButtonStyle = lsEllipsis)
  and (Key = VK_RETURN)
  and (Shift = [ssCtrl]) then
  begin
    EditButtonClick;
    PeekMessage(Msg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE);
  end
  else
    inherited KeyDown(Key, Shift);
end;  // KeyDown

procedure TIB_EditBtn.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  WasPressed: Boolean;
begin
     { if the mouse was released (after being pressed) on the button
       then perform its associated action }
  WasPressed := fPressed;
  StopTracking;
  if (Button = mbLeft) and (fButtonStyle = lsEllipsis) and WasPressed then
    EditButtonClick;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TIB_EditBtn.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
    { Check if thhe position passed is over the area of the button -
      if so then set the state to pressed and redraw the depressed
      button }
  SetRect(R, ClientWidth - fButtonWidth, 0, ClientWidth, ClientHeight);
  NewState := PtInRect(R, Point(X, Y));
  if fPressed <> NewState then
  begin
    fPressed := NewState;
    InvalidateRect(Handle, @R, False);
  end;
end; // TrackButton

procedure TIB_EditBtn.PaintWindow(DC: HDC);
var
  R: TRect;
  Flags: Integer;
  W: Integer;
begin
     { here's where we draw the little elipsis button when necessary -
      most times it is normal (raised) state, but sometimes it is pressed }
  if (fButtonStyle <> lsNormal) and (focused or (csDesigning in ComponentState)) then
  begin
    SetRect(R, ClientWidth - fButtonWidth, 0, ClientWidth, ClientHeight);
    Flags := 0;
    if FPressed then
      Flags := BF_FLAT;
    DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
    Flags := ((R.Right - R.Left) shr 1) - 1 + Ord(fPressed);
    W := Height shr 3;
    if W = 0 then W := 1;
    PatBlt(DC, R.Left + Flags, R.Top + Flags, W, W, BLACKNESS);
    PatBlt(DC, R.Left + Flags - (W * 2), R.Top + Flags, W, W, BLACKNESS);
    PatBlt(DC, R.Left + Flags + (W * 2), R.Top + Flags, W, W, BLACKNESS);
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited PaintWindow(DC);
end; // PaintWindow

procedure TIB_EditBtn.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
    { Not only must you press the button with the mouse, but it must be
      released over the same button.  If the button has been pressed, we
      need to redraw it depressed, then track the mouse movements to see
      if the user moves off it before releasing. }
  if (Button = mbLeft) and (fButtonStyle <> lsNormal) and focused
  and PtInRect(Rect(Width - fButtonWidth, 0, Width, Height), Point(X,Y)) then
    begin
    MouseCapture := True;
    FTracking := True;
    TrackButton(X, Y);
    end;
  inherited MouseDown(Button, Shift, X, Y);
end; // MouseDown

procedure TIB_EditBtn.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
    { if we are tracking the mouse, the mouse must have been pressed over
      the button part of the control.  Check to see we are still over it. }
  if PtInRect(Rect(Width - fButtonWidth, 0, Width, Height), Point(X,Y))
  then Screen.Cursor := crArrow
  else Screen.Cursor := crDefault;
  if fTracking then TrackButton(X, Y);
  inherited MouseMove(Shift, X, Y);
end; // MouseMove

procedure TIB_EditBtn.StopTracking;
begin
    { we are finished tracking the mouse over the control.  Reset everything }
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end; // StopTracking;

procedure TIB_EditBtn.DoEnter;
begin
    { In use the elipsis button is only shown when we the control has focus }
  if (fButtonStyle <> lsNormal) then BoundsChanged;
  inherited DoEnter;
end; // DoEnter

procedure TIB_EditBtn.DoExit;
begin
    { Remove the elipsis button (if present) when we lose focus }
  if (fButtonStyle <> lsNormal) then BoundsChanged;
  inherited DoExit;
end;

end.
