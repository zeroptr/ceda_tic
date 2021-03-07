unit IB_FlatEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IB_Controls, IB_Components;

type
  TIB_FlatEdit = class(TIB_Edit)
  private
    FParentColor: Boolean;
    FFocusedColor: TColor;
    FBorderColor: TColor;
    FFlatColor: TColor;
    MouseInControl: Boolean;
    procedure Loaded; override;
    procedure SetColors (Index: Integer; Value: TColor);
    procedure SetParentColor (Value: Boolean);
    procedure RedrawBorder (const Clip: HRGN);
    procedure NewAdjustHeight;
    procedure CMEnabledChanged (var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged (var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave (var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMSetFocus (var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus (var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCCalcSize (var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint (var Message: TMessage); message WM_NCPAINT;
    procedure CMSysColorChange (var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMParentColorChanged (var Message: TWMNoParams); message CM_PARENTCOLORCHANGED;

  protected
  public
    constructor Create( AOwner: TComponent ); override;
  published
    property ColorFocused: TColor index 0 read FFocusedColor write SetColors default clWhite;
    property ColorBorder: TColor index 1 read FBorderColor write SetColors default $008396A0;
    property ColorFlat: TColor index 2 read FFlatColor write SetColors default $00E1EAEB;
    property CharCase;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property MaxLength;
    property OEMConvert;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('iboFlatControls', [TIB_FlatEdit]);
end;

constructor TIB_FlatEdit.Create( AOwner: TComponent );
begin
  inherited Create(AOwner);
  ParentFont := True;
  FFocusedColor := clWhite;
  FBorderColor := $008396A0;
  FFlatColor := $00E1EAEB;
  FParentColor := True;
  AutoSize := False;
  Ctl3D := False;
  BorderStyle := bsNone;
  ControlStyle := ControlStyle - [csFramed];
  SetBounds(0, 0, 121, 19);

end;

procedure TIB_FlatEdit.SetParentColor (Value: Boolean);
begin
  if Value <> FParentColor then
  begin
    FParentColor := Value;
    if FParentColor then
    begin
      if Parent <> nil then
        FFlatColor := TForm(Parent).Color;
      RedrawBorder(0);
    end;
  end;
end;

 procedure TIB_FlatEdit.CMSysColorChange (var Message: TMessage);
begin
    if FParentColor then
    begin
      if Parent <> nil then
        FFlatColor := TForm(Parent).Color;
    end;
  RedrawBorder(0);
end;

  procedure TIB_FlatEdit.CMParentColorChanged (var Message: TWMNoParams);
begin
    if FParentColor then
    begin
      if Parent <> nil then
        FFlatColor := TForm(Parent).Color;
    end;
  RedrawBorder(0);
end;

procedure TIB_FlatEdit.SetColors (Index: Integer; Value: TColor);
begin
  case Index of
    0: FFocusedColor := Value;
    1: FBorderColor := Value;
    2: FFlatColor := Value;
  end;
  if Index = 2 then
    FParentColor := False;
  RedrawBorder(0);
end;

procedure TIB_FlatEdit.CMMouseEnter (var Message: TMessage);
begin
  inherited;
  if (GetActiveWindow <> 0) then
  begin
    MouseInControl := True;
    RedrawBorder(0);
  end;
end;
procedure TIB_FlatEdit.CMMouseLeave (var Message: TMessage);
begin
  inherited;
  MouseInControl := False;
  RedrawBorder(0);
end;

procedure TIB_FlatEdit.NewAdjustHeight;
var
  DC: HDC;
  SaveFont: HFONT;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Height := Metrics.tmHeight + 6;
end;

procedure TIB_FlatEdit.Loaded;
begin
  inherited;
  if not(csDesigning in ComponentState) then
    NewAdjustHeight;
end;

procedure TIB_FlatEdit.CMEnabledChanged (var Message: TMessage);
const
  EnableColors: array[Boolean] of TColor= (clBtnFace, clWindow);
begin
  inherited;
  Color := EnableColors[Enabled];
  RedrawBorder(0);
end;

procedure TIB_FlatEdit.CMFontChanged (var Message: TMessage);
begin
  inherited;
  if not((csDesigning in ComponentState) and (csLoading in ComponentState)) then
    NewAdjustHeight;
end;

procedure TIB_FlatEdit.WMSetFocus (var Message: TWMSetFocus);
begin
  inherited;
  if not(csDesigning in ComponentState) then
    RedrawBorder(0);
end;

procedure TIB_FlatEdit.WMKillFocus (var Message: TWMKillFocus);
begin
  inherited;
  if not(csDesigning in ComponentState) then
    RedrawBorder(0);
end;

procedure TIB_FlatEdit.WMNCCalcSize (var Message: TWMNCCalcSize);
begin
  inherited;
  InflateRect(Message.CalcSize_Params^.rgrc[0], -3, -3);
end;

procedure TIB_FlatEdit.WMNCPaint (var Message: TMessage);
begin
  inherited;
  RedrawBorder(HRGN(Message.WParam));
end;

procedure TIB_FlatEdit.RedrawBorder (const Clip: HRGN);
var
  DC: HDC;
  R: TRect;
  BtnFaceBrush, WindowBrush, FocusBrush: HBRUSH;
begin
  DC := GetWindowDC(Handle);
  try
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    BtnFaceBrush := CreateSolidBrush(ColorToRGB(FBorderColor));
    WindowBrush := CreateSolidBrush(ColorToRGB(FFlatColor));
    FocusBrush := CreateSolidBrush(ColorToRGB(FFocusedColor));
    if (not(csDesigning in ComponentState) and
      (Focused or (MouseInControl and not(Screen.ActiveControl is TIB_FlatEdit)))) then
    begin
      { Focus }
      Color := FFocusedColor;
      FrameRect(DC, R, BtnFaceBrush);
      InflateRect(R, -1, -1);
      FrameRect(DC, R, FocusBrush);
      InflateRect(R, -1, -1);
      FrameRect(DC, R, FocusBrush);
    end
    else
    begin
      { non Focus }
      Color := FFlatColor;
      FrameRect(DC, R, BtnFaceBrush);
      InflateRect(R, -1, -1);
      FrameRect(DC, R, WindowBrush);
      InflateRect(R, -1, -1);
      FrameRect(DC, R, WindowBrush);
    end;
  finally
    ReleaseDC(Handle, DC);
  end;
  DeleteObject(WindowBrush);
  DeleteObject(BtnFaceBrush);
  DeleteObject(FocusBrush);
end;



end.
