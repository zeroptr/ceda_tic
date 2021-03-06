{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvPanel.pas, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse att buypin dott com]
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s):
Michael Beck [mbeck att bigfoot dott com].
pongtawat
Peter Thornqvist [peter3 at sourceforge dot net]
Jens Fudickar [jens dott fudickar att oratool dott de]
dejoy den [dejoy att ynl dott gov dott cn]

Changes:

>> dejoy --2005-04-28
  - Change TJvArrangeSettings to inherited from TJvPersistentProperty.
  - TJvCustomArrangePanel implemented interface of IJvHotTrack.
  - Renamed HotColor property to HotTrackOptions.Color.

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvPanel.pas 12118 2009-01-02 22:36:34Z jfudickar $

unit JvPanel;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, Messages,
  SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls,
  JvTypes, JvThemes, JvComponent, JvExtComponent, JvExControls,
  JvHotTrackPersistent;

type
  TJvPanelResizeParentEvent = procedure(Sender: TObject; nLeft, nTop, nWidth, nHeight: Integer) of object;
  TJvPanelChangedSizeEvent = procedure(Sender: TObject; ChangedSize: Integer) of object;
  TJvAutoSizePanel = (asNone, asWidth, asHeight, asBoth);

  TJvArrangeSettings = class(TJvPersistentProperty)
  private
    FAutoArrange: Boolean;
    FAutoSize: TJvAutoSizePanel;
    FWrapControls: Boolean;
    FBorderLeft: Integer;
    FBorderTop: Integer;
    FDistanceVertical: Integer;
    FDistanceHorizontal: Integer;
    FShowNotVisibleAtDesignTime: Boolean;
    FMaxWidth: Integer;
    procedure SetWrapControls(Value: Boolean);
    procedure SetAutoArrange(Value: Boolean);
    procedure SetAutoSize(Value: TJvAutoSizePanel);
    procedure SetBorderLeft(Value: Integer);
    procedure SetBorderTop(Value: Integer);
    procedure SetDistanceVertical(Value: Integer);
    procedure SetDistanceHorizontal(Value: Integer);
    procedure SetMaxWidth(Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  published
    property WrapControls: Boolean read FWrapControls write SetWrapControls default True;
    property BorderLeft: Integer read FBorderLeft write SetBorderLeft default 0;
    property BorderTop: Integer read FBorderTop write SetBorderTop default 0;
    property DistanceVertical: Integer read FDistanceVertical write SetDistanceVertical default 0;
    property DistanceHorizontal: Integer read FDistanceHorizontal write SetDistanceHorizontal default 0;
    property ShowNotVisibleAtDesignTime: Boolean read FShowNotVisibleAtDesignTime write FShowNotVisibleAtDesignTime default True;
    property AutoSize: TJvAutoSizePanel read FAutoSize write SetAutoSize default asNone;
    property AutoArrange: Boolean read FAutoArrange write SetAutoArrange default False;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth default 0;
  end;

  IJvArrangePanel = interface
  ['{8EE63749-CDDC-4436-9067-4EF0434B43C2}']
    procedure ArrangeControls; 
    procedure DisableArrange;
    procedure EnableArrange;
    function GetArrangeSettings: TJvArrangeSettings;
    procedure SetArrangeSettings(const Value: TJvArrangeSettings);
    property ArrangeSettings: TJvArrangeSettings read GetArrangeSettings write
        SetArrangeSettings;
  end;

  TJvPanelHotTrackOptions = class(TJvHotTrackOptions)
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property Color default clBtnFace;
  end;

  TJvPanelMoveEvent = procedure(Sender: TObject; X, Y: Integer; var Allow: Boolean) of object;

  TJvCustomArrangePanel = class(TJvCustomPanel, IJvDenySubClassing, IJvHotTrack, IJvArrangePanel)
  private
    FTransparent: Boolean;
    FFlatBorder: Boolean;
    FFlatBorderColor: TColor;
    FMultiLine: Boolean;
    FSizeable: Boolean;
    FDragging: Boolean;
    FLastPos: TPoint;
    FEnableArrangeCount: Integer;
    FArrangeControlActive: Boolean;
    FArrangeWidth: Integer;
    FArrangeHeight: Integer;
    FArrangeSettings: TJvArrangeSettings;
    FOnResizeParent: TJvPanelResizeParentEvent;
    FOnChangedWidth: TJvPanelChangedSizeEvent;
    FOnChangedHeight: TJvPanelChangedSizeEvent;
    FOnPaint: TNotifyEvent;
    FMovable: Boolean;
    FWasMoved: Boolean;
    FOnAfterMove: TNotifyEvent;
    FOnBeforeMove: TJvPanelMoveEvent;
    FHotTrack: Boolean;
    FHotTrackFont: TFont;
    FHotTrackFontOptions: TJvTrackFontOptions;
    FHotTrackOptions: TJvHotTrackOptions;
    FLastScreenCursor: TCursor;
    function GetArrangeSettings: TJvArrangeSettings;
    function GetHeight: Integer;
    procedure SetHeight(Value: Integer);
    function GetWidth: Integer;
    procedure SetWidth(Value: Integer);
    procedure SetArrangeSettings(const Value: TJvArrangeSettings);
    procedure SetTransparent(const Value: Boolean);
    procedure SetFlatBorder(const Value: Boolean);
    procedure SetFlatBorderColor(const Value: TColor);
    procedure SetMultiLine(const Value: Boolean);
    procedure SetSizeable(const Value: Boolean);

    {IJvHotTrack}   //added by dejoy 2005-04-28
    function GetHotTrack: Boolean;
    function GetHotTrackFont: TFont;
    function GetHotTrackFontOptions: TJvTrackFontOptions;
    function GetHotTrackOptions: TJvHotTrackOptions;
    procedure SetHotTrack(Value: Boolean);
    procedure SetHotTrackFont(Value: TFont);
    procedure SetHotTrackFontOptions(Value: TJvTrackFontOptions);
    procedure SetHotTrackOptions(Value: TJvHotTrackOptions);
    procedure IJvHotTrack_Assign(Source: IJvHotTrack);
    procedure IJvHotTrack.Assign = IJvHotTrack_Assign;
  protected
    procedure DrawCaption; dynamic;
    procedure DrawCaptionTo(ACanvas: TCanvas ); dynamic;
    procedure DrawBorders; dynamic;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseEnter(Control: TControl); override;
    procedure MouseLeave(Control: TControl); override;
    procedure ParentColorChanged; override;
    procedure TextChanged; override;
    procedure Paint; override;
    function DoEraseBackground(Canvas: TCanvas; Param: Integer): Boolean; override;
    procedure AdjustSize; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMExitSizeMove(var Msg: TMessage); message WM_EXITSIZEMOVE;
    function DoBeforeMove(X, Y: Integer): Boolean; dynamic;
    procedure DoAfterMove; dynamic;
    procedure Loaded; override;
    procedure Resize; override;
    procedure Rearrange;
    procedure DoArrangeSettingsPropertyChanged(Sender: TObject; const PropName: string); virtual;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    function GetNextControlByTabOrder(ATabOrder: Integer): TWinControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure ArrangeControls;
    procedure EnableArrange;
    procedure DisableArrange;
    function ArrangeEnabled: Boolean;
    property ArrangeWidth: Integer read FArrangeWidth;
    property ArrangeHeight: Integer read FArrangeHeight;
    property DockManager;
    property Canvas;

    property HotTrack: Boolean read GetHotTrack write SetHotTrack default False;
    property HotTrackFont: TFont read GetHotTrackFont write SetHotTrackFont;
    property HotTrackFontOptions: TJvTrackFontOptions read GetHotTrackFontOptions write SetHotTrackFontOptions default
      DefaultTrackFontOptions;
    property HotTrackOptions: TJvHotTrackOptions read GetHotTrackOptions write SetHotTrackOptions;

    property Movable: Boolean read FMovable write FMovable default False;
    property Sizeable: Boolean read FSizeable write SetSizeable default False;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property MultiLine: Boolean read FMultiLine write SetMultiLine default False;
    //FlatBorder used the BorderWidth to draw the border
    property FlatBorder: Boolean read FFlatBorder write SetFlatBorder default False;
    property FlatBorderColor: TColor read FFlatBorderColor write SetFlatBorderColor default clBtnShadow;
    property OnBeforeMove: TJvPanelMoveEvent read FOnBeforeMove write FOnBeforeMove;
    property OnAfterMove: TNotifyEvent Read FOnAfterMove write FOnAfterMove;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;

    property ArrangeSettings: TJvArrangeSettings read GetArrangeSettings write
        SetArrangeSettings;
    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
    property OnResizeParent: TJvPanelResizeParentEvent read FOnResizeParent write FOnResizeParent;
    property OnChangedWidth: TJvPanelChangedSizeEvent read FOnChangedWidth write FOnChangedWidth;
    property OnChangedHeight: TJvPanelChangedSizeEvent read FOnChangedHeight write FOnChangedHeight;
  end;

  TJvPanel = class(TJvCustomArrangePanel)
  private
    FFilerTag: string;
    procedure ReadData(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  published
    property HotTrack;
    property HotTrackFont;
    property HotTrackFontOptions;
    property HotTrackOptions;

    property Movable;
    property Sizeable;
    property HintColor;
    property Transparent;
    property MultiLine;
    property FlatBorder;
    property FlatBorderColor;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnBeforeMove;
    property OnAfterMove;
    property OnParentColorChange;
    property OnPaint;

    property ArrangeSettings;
    property Width;
    property Height;
    property OnResizeParent;
    property OnChangedWidth;
    property OnChangedHeight;

    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property FullRepaint;
    property Locked;
    property ParentBiDiMode;
    property OnCanResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property DragMode;
    property Enabled;
    property Font;
    {$IFDEF JVCLThemesEnabled}
    property ParentBackground default True;
    {$ENDIF JVCLThemesEnabled}
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/run/JvPanel.pas $';
    Revision: '$Revision: 12118 $';
    Date: '$Date: 2009-01-02 23:36:34 +0100 (ven., 02 janv. 2009) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  {$IFDEF HAS_UNIT_TYPES}
  Types,
  {$ENDIF HAS_UNIT_TYPES}
  JvJCLUtils, JvJVCLUtils;

const
  BkModeTransparent = TRANSPARENT;

(*function IsThemed: Boolean;
begin
  {$IFDEF JVCLThemesEnabled}
  Result := ThemeServices.ThemesEnabled;
  {$ELSE}
  Result := False;
  {$ENDIF JVCLThemesEnabled}
end;*)

//=== { TJvArrangeSettings } =================================================

constructor TJvArrangeSettings.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FMaxWidth := 0;
  FBorderLeft := 0;
  FBorderTop := 0;
  FDistanceVertical := 0;
  FDistanceHorizontal := 0;
  WrapControls := True;
  ShowNotVisibleAtDesignTime := True;
  FAutoSize := asNone;
  AutoArrange := False;
end;

procedure TJvArrangeSettings.SetWrapControls(Value: Boolean);
begin
  if Value <> FWrapControls then
  begin
    Changing;
    ChangingProperty('WrapControls');
    FWrapControls := Value;
    ChangedProperty('WrapControls');
    Changed;
  end;
end;

procedure TJvArrangeSettings.SetAutoArrange(Value: Boolean);
begin
  if Value <> FAutoArrange then
  begin
    Changing;
    ChangingProperty('AutoArrange');
    FAutoArrange := Value;
    ChangedProperty('AutoArrange');
    Changed;
  end;
end;

procedure TJvArrangeSettings.SetAutoSize(Value: TJvAutoSizePanel);
begin
  if Value <> FAutoSize then
  begin
    Changing;
    ChangingProperty('AutoSize');
    FAutoSize := Value;
    ChangedProperty('AutoSize');
    Changed;
  end;
end;

procedure TJvArrangeSettings.SetBorderLeft(Value: Integer);
begin
  if Value <> FBorderLeft then
  begin
    Changing;
    ChangingProperty('BorderLeft');
    FBorderLeft := Value;
    ChangedProperty('BorderLeft');
    Changed;
  end;
end;

procedure TJvArrangeSettings.SetBorderTop(Value: Integer);
begin
  if Value <> FBorderTop then
  begin
    Changing;
    ChangingProperty('BorderTop');
    FBorderTop := Value;
    ChangedProperty('BorderTop');
    Changed;
  end;
end;

procedure TJvArrangeSettings.SetDistanceVertical(Value: Integer);
begin
  if Value <> FDistanceVertical then
  begin
    Changing;
    ChangingProperty('DistanceVertical');
    FDistanceVertical := Value;
    ChangedProperty('DistanceVertical');
    Changed;
  end;
end;

procedure TJvArrangeSettings.SetDistanceHorizontal(Value: Integer);
begin
  if Value <> FDistanceHorizontal then
  begin
    Changing;
    ChangingProperty('DistanceHorizontal');
    FDistanceHorizontal := Value;
    ChangedProperty('DistanceHorizontal');
    Changed;
  end;
end;

procedure TJvArrangeSettings.SetMaxWidth(Value: Integer);
begin
  if Value <> FMaxWidth then
  begin
    Changing;
    ChangingProperty('MaxWidth');
    FMaxWidth := Value;
    ChangedProperty('MaxWidth');
    Changed;
  end;
end;

procedure TJvArrangeSettings.Assign(Source: TPersistent);
var
  A: TJvArrangeSettings;
begin
  if Source is TJvArrangeSettings then
  begin
    BeginUpdate;
    try
      A := TJvArrangeSettings(Source);
      AutoArrange := A.AutoArrange;
      AutoSize := A.AutoSize;
      WrapControls := A.WrapControls;
      BorderLeft := A.BorderLeft;
      BorderTop := A.BorderTop;
      DistanceVertical := A.DistanceVertical;
      DistanceHorizontal := A.DistanceHorizontal;
      ShowNotVisibleAtDesignTime := A.ShowNotVisibleAtDesignTime;
      MaxWidth := A.MaxWidth;
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

//=== { TJvPanelHotTrackOptions } ============================================

constructor TJvPanelHotTrackOptions.Create(AOwner: TPersistent);
begin
  inherited;
  Color := clBtnFace;
end;

//=== { TJvCustomArrangePanel } ==============================================

constructor TJvCustomArrangePanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  IncludeThemeStyle(Self, [csNeedsBorderPaint, csParentBackground]);
  FMultiLine := False;
  FTransparent := False;
  FFlatBorder := False;
  FFlatBorderColor := clBtnShadow;
  FHotTrack := False;
  FHotTrackFont := TFont.Create;
  FHotTrackFontOptions := DefaultTrackFontOptions;
  FHotTrackOptions := TJvPanelHotTrackOptions.Create(self);

  FArrangeSettings := TJvArrangeSettings.Create(nil);   // Do Not Assign Self, In some circumstances the autoarrange does not work
                                                        // TODO: Check why this happens
  FArrangeSettings.OnChangedProperty := DoArrangeSettingsPropertyChanged;
end;

destructor TJvCustomArrangePanel.Destroy;
begin
  FreeAndNil(FArrangeSettings);
//  FreeAndNil(FHotTrackOptions); // No longer necessary, autofree because of the self parent
  FreeAndNil(FHotTrackFont);
  inherited Destroy;
end;

procedure TJvCustomArrangePanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if Transparent {and not IsThemed} then
  begin
    // (rom) gives a better look in IDE if always set (not fully correct though)
    //if not (csDesigning in ComponentState) then
      Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
    ControlStyle := ControlStyle - [csOpaque];
  end
  else
  begin
    //if not (csDesigning in ComponentState) then
      Params.ExStyle := Params.ExStyle and not WS_EX_TRANSPARENT;
    ControlStyle := ControlStyle + [csOpaque];
  end;
end;

procedure TJvCustomArrangePanel.WMNCHitTest(var Msg: TWMNCHitTest);
var
  P: TPoint;
begin
  inherited;
  if not (csDesigning in ComponentState) and Movable then
  begin
    P := ScreenToClient(SmallPointToPoint(Msg.Pos));
    if (P.X > 5) and (P.Y > 5) and (P.X < Width - 5) and (P.Y < Height - 5) and DoBeforeMove(P.X,P.Y) then
    begin
      Msg.Result := HTCAPTION;
      FWasMoved := True;
    end;
  end;
end;

procedure TJvCustomArrangePanel.WMExitSizeMove(var Msg: TMessage);
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    if FWasMoved then
      DoAfterMove;
    FWasMoved := False;
  end;
end;

function TJvCustomArrangePanel.DoBeforeMove(X,Y: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnBeforeMove) then
    FOnBeforeMove(Self, X, Y, Result);
end;

procedure TJvCustomArrangePanel.DoAfterMove;
begin
  if Assigned(FOnAfterMove) then
    FOnAfterMove(Self);
end;

procedure TJvCustomArrangePanel.Paint;
var
  X, Y: Integer;
  R: TRect;
  OldPenColor:TColor;
  OldPenWidth: Integer;
begin
  if Assigned(FOnPaint) then
  begin
    FOnPaint(Self);
    Exit;
  end;

  // Mantis 3624: Draw our parent's image first if we are transparent.
  // This might not seem useful at first as we have removed the csOpaque
  // from our style and the API is doing the drawing just fine. But this
  // is required for other transparent controls placed on us. This way,
  // they call us with their own canvas into which we draw what we are
  // placed on. This way, there is an automatic chain of transparency up
  // to the controls at the bottom that are not transparent.
  if Transparent then
    CopyParentImage(Self, Canvas);

  if MouseOver and HotTrack then
  begin
    Canvas.Font := Self.HotTrackFont;
    if HotTrackOptions.Enabled then
    begin
      Canvas.Brush.Color := HotTrackOptions.Color;
      if HotTrackOptions.FrameVisible then
      begin
        Canvas.Brush.Style := bsSolid;
        OldPenColor := Canvas.Pen.Color;
        Canvas.Pen.Color := HotTrackOptions.FrameColor;
        Canvas.Rectangle(0, 0, Width, Height);
        Canvas.Pen.Color := OldPenColor;
      end
      else
      begin
        R := ClientRect;
        InflateRect(R, -BevelWidth, -BevelWidth);
        Canvas.FillRect(R);
      end;
    end;
  end
  else
  begin
    Canvas.Font := Self.Font;
    Canvas.Brush.Color := Color;
    if not Transparent {or IsThemed} then
      DrawThemedBackground(Self, Canvas, ClientRect)
    else
      Canvas.Brush.Style := bsClear;
    if FFlatBorder then
    begin
      if BorderWidth > 0 then
      begin
        OldPenWidth:= Canvas.Pen.Width;
        OldPenColor := Canvas.Pen.Color;
        Canvas.Pen.Width := BorderWidth;
        Canvas.Pen.Color := FFlatBorderColor;
        Canvas.Brush.Style := bsClear;

        R := ClientRect;
        X := (BorderWidth div 2);
        if Odd(BorderWidth) then
          Y := X
        else
          Y := X -1;

        Inc(R.Left,X);
        Inc(R.Top,X);
        Dec(R.Bottom,Y);
        Dec(R.Right,Y);

        Canvas.Rectangle(R);

        Canvas.Pen.Width := OldPenWidth;
        Canvas.Pen.Color := OldPenColor;
     end;
    end
    else
      DrawBorders;
  end;

  DrawCaption;
  if Sizeable then
  begin
    {$IFDEF JVCLThemesEnabled}
    if ThemeServices.ThemesEnabled then
      ThemeServices.DrawElement(Canvas.Handle, ThemeServices.GetElementDetails(tsGripper),
        Rect(ClientWidth - GetSystemMetrics(SM_CXVSCROLL) - BevelWidth - 2,
          ClientHeight - GetSystemMetrics(SM_CYHSCROLL) - BevelWidth - 2,
          ClientWidth - BevelWidth - 2, ClientHeight - BevelWidth - 2))
    else
    {$ENDIF JVCLThemesEnabled}
      begin
        Canvas.Font.Name := 'Marlett';
        Canvas.Font.Charset := DEFAULT_CHARSET;
        Canvas.Font.Size := 12;
        Canvas.Font.Style := [];
        Canvas.Brush.Style := bsClear;
        X := ClientWidth - GetSystemMetrics(SM_CXVSCROLL) - BevelWidth - 2;
        Y := ClientHeight - GetSystemMetrics(SM_CYHSCROLL) - BevelWidth - 2;
        // (rom) bsClear takes care of that already
        //if Transparent {and not IsThemed} then
        //  SetBkMode(Handle, BkModeTransparent);
        Canvas.Font.Color := clBtnHighlight;
        Canvas.TextOut(X, Y, 'o');
        Canvas.Font.Color := clBtnShadow;
        Canvas.TextOut(X, Y, 'p');
      end;
  end;
end;

procedure TJvCustomArrangePanel.AdjustSize;
begin
  inherited AdjustSize;
  if Transparent {and not IsThemed} then
  begin
    // (ahuser) That is the only way to draw the border of the contained controls.
    Width := Width + 1;
    Width := Width - 1;
  end;
end;

procedure TJvCustomArrangePanel.DrawBorders;
var
  Rect: TRect;
  TopColor, BottomColor: TColor;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then
      TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then
      BottomColor := clBtnHighlight;
  end;

begin
  Rect := ClientRect;
  if BevelOuter <> bvNone then
  begin
    AdjustColors(BevelOuter);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  Frame3D(Canvas, Rect, Color, Color, BorderWidth);
  if BevelInner <> bvNone then
  begin
    AdjustColors(BevelInner);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
end;

procedure TJvCustomArrangePanel.DrawCaption;
begin
  DrawCaptionTo(Self.Canvas);
end;

procedure TJvCustomArrangePanel.DrawCaptionTo(ACanvas: TCanvas );
const
  Alignments: array [TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWrap: array [Boolean] of Longint = (DT_SINGLELINE, DT_WORDBREAK);
var
  ATextRect: TRect;
  BevelSize: Integer;
  Flags: Longint;
begin
  with ACanvas do
  begin
    if Caption <> '' then
    begin
      if (MouseOver or FDragging) and HotTrack then
        ACanvas.Font := Self.HotTrackFont
      else
        ACanvas.Font := Self.Font;

      SetBkMode(Handle, BkModeTransparent);
      Font := Self.Font;
      ATextRect := GetClientRect;
      InflateRect(ATextRect, -BorderWidth, -BorderWidth);
      BevelSize := 0;
      if BevelOuter <> bvNone then
        Inc(BevelSize, BevelWidth);
      if BevelInner <> bvNone then
        Inc(BevelSize, BevelWidth);
      InflateRect(ATextRect, -BevelSize, -BevelSize);
      Flags := DT_EXPANDTABS or WordWrap[MultiLine] or Alignments[Alignment];
      Flags := DrawTextBiDiModeFlags(Flags);
      //calculate required rectangle size
      DrawText(ACanvas.Handle, Caption, -1, ATextRect, Flags or DT_CALCRECT);
      // adjust the rectangle placement
      OffsetRect(ATextRect, 0, -ATextRect.Top + (Height - (ATextRect.Bottom - ATextRect.Top)) div 2);
      case Alignment of
        taRightJustify:
          OffsetRect(ATextRect, -ATextRect.Left + (Width - (ATextRect.Right - ATextRect.Left) - BorderWidth -
            BevelSize), 0);
        taCenter:
          OffsetRect(ATextRect, -ATextRect.Left + (Width - (ATextRect.Right - ATextRect.Left)) div 2, 0);
      end;
      if not Enabled then
        Font.Color := clGrayText;
      //draw text
      if Transparent {and not IsThemed} then
        SetBkMode(ACanvas.Handle, BkModeTransparent);
      DrawText(ACanvas.Handle, Caption, -1, ATextRect, Flags);
    end;
  end;
end;

procedure TJvCustomArrangePanel.ParentColorChanged;
begin
  Invalidate;
  inherited ParentColorChanged;
end;

procedure TJvCustomArrangePanel.MouseEnter(Control: TControl);
var
  NeedRepaint: Boolean;
  OtherDragging:Boolean;
begin
  if csDesigning in ComponentState then
    Exit;

  if not MouseOver and Enabled and (Control = nil) then
  begin
    OtherDragging :=
       {$IFDEF COMPILER6_UP}
      Mouse.IsDragging;
       {$ELSE}
      KeyPressed(VK_LBUTTON);
      {$ENDIF COMPILER6_UP}
    NeedRepaint := not Transparent and
     ({IsThemed or} (FHotTrack and Enabled and not FDragging and not OtherDragging));
    inherited MouseEnter(Control); // set MouseOver
    if NeedRepaint then
      Repaint;
  end
  else
    inherited MouseEnter(Control);
end;

procedure TJvCustomArrangePanel.MouseLeave(Control: TControl);
var
  NeedRepaint: Boolean;
  OtherDragging:Boolean;
begin
  if csDesigning in ComponentState then
    Exit;
  OtherDragging :=
     {$IFDEF COMPILER6_UP}
    Mouse.IsDragging;
     {$ELSE}
    KeyPressed(VK_LBUTTON);
     {$ENDIF COMPILER6_UP}
  if MouseOver and Enabled and (Control = nil) then
  begin
    NeedRepaint := not Transparent and
     ({IsThemed or} (FHotTrack and (FDragging or (Enabled and not OtherDragging))));
    inherited MouseLeave(Control); // set MouseOver
    if NeedRepaint then
      Repaint;
  end
  else
    inherited MouseLeave(Control);
end;

procedure TJvCustomArrangePanel.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    {if not IsThemed then}
    begin
      RecreateWnd;
    end;
  end;
end;

procedure TJvCustomArrangePanel.SetFlatBorder(const Value: Boolean);
begin
  if Value <> FFlatBorder then
  begin
    FFlatBorder := Value;
    Invalidate;
  end;
end;

procedure TJvCustomArrangePanel.SetFlatBorderColor(const Value: TColor);
begin
  if Value <> FFlatBorderColor then
  begin
    FFlatBorderColor := Value;
    Invalidate;
  end;
end;

function TJvCustomArrangePanel.DoEraseBackground(Canvas: TCanvas; Param: Integer): Boolean;
begin
  if Transparent {and not IsThemed} then
    Result := True
  else
    Result := inherited DoEraseBackground(Canvas, Param);
end;

procedure TJvCustomArrangePanel.SetMultiLine(const Value: Boolean);
begin
  if FMultiLine <> Value then
  begin
    FMultiLine := Value;
    Invalidate;
  end;
end;

procedure TJvCustomArrangePanel.TextChanged;
begin
  inherited TextChanged;
  Invalidate;
end;

procedure TJvCustomArrangePanel.Invalidate;
begin
{  if Transparent and Visible and Assigned(Parent) and Parent.HandleAllocated and HandleAllocated then
    RedrawWindow(Parent.Handle, nil, 0, RDW_ERASE or RDW_FRAME or RDW_INTERNALPAINT or
      RDW_INVALIDATE or RDW_ERASENOW or RDW_UPDATENOW or RDW_ALLCHILDREN); }
  inherited Invalidate;
end;

procedure TJvCustomArrangePanel.SetSizeable(const Value: Boolean);
begin
  if FSizeable <> Value then
  begin
    FSizeable := Value;
    Invalidate;
  end;
end;

procedure TJvCustomArrangePanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Sizeable and (Button = mbLeft) and ((Width - X) < 12) and ((Height - Y) < 12) then
  begin
    FDragging := True;
    FLastPos := Point(X, Y);
    MouseCapture := True;
    FLastScreenCursor := Screen.Cursor;
    Screen.Cursor := crSizeNWSE;
  end
  else
    inherited MouseDown(Button, Shift, X, Y);
end;

procedure TJvCustomArrangePanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
  X1, Y1: Integer;
begin
  if FDragging and Sizeable then
  begin
    R := BoundsRect;
    X1 := R.Right - R.Left + X - FLastPos.X;
    Y1 := R.Bottom - R.Top + Y - FLastPos.Y;
    if (X1 > 1) and (Y1 > 1) then
    begin
      if X1 >= 0 then
        FLastPos.X := X;
      if Y1 >= 0 then
        FLastPos.Y := Y;
      SetBounds(Left, Top, X1, Y1);
      Refresh;
    end;
  end
  else
    inherited MouseMove(Shift, X, Y);
  if Sizeable then
  begin
    if ((Width - X) < 12) and ((Height - Y) < 12) then
      Screen.Cursor := crSizeNWSE
    else
      if Screen.Cursor = crSizeNWSE then
        Screen.Cursor := FLastScreenCursor;
  end;
end;

procedure TJvCustomArrangePanel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if FDragging and Sizeable then
  begin
    FDragging := False;
    MouseCapture := False;
    if Screen.Cursor = crSizeNWSE then
      Screen.Cursor := FLastScreenCursor;
    Refresh;
  end
  else
    inherited MouseUp(Button, Shift, X, Y);
end;

procedure TJvCustomArrangePanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if Transparent {and not IsThemed} then
    Invalidate;
end;

procedure TJvCustomArrangePanel.Resize;
begin
  if Assigned(FArrangeSettings) then // (asn)
    if FArrangeSettings.AutoArrange then
      ArrangeControls;
  inherited Resize;
end;

procedure TJvCustomArrangePanel.EnableArrange;
begin
  EnableAlign;
  if FEnableArrangeCount > 0 then
    Dec(FEnableArrangeCount);
end;

procedure TJvCustomArrangePanel.DisableArrange;
begin
  Inc(FEnableArrangeCount);
  DisableAlign;
end;

function TJvCustomArrangePanel.ArrangeEnabled: Boolean;
begin
  Result := FEnableArrangeCount <= 0;
end;

procedure TJvCustomArrangePanel.Loaded;
begin
  inherited Loaded;
  if FArrangeSettings.AutoArrange then
    ArrangeControls;
end;

procedure TJvCustomArrangePanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited AlignControls(AControl, Rect);
  if FArrangeSettings.AutoArrange then
    ArrangeControls;
end;

function TJvCustomArrangePanel.GetNextControlByTabOrder(ATabOrder: Integer): TWinControl;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ControlCount - 1 do
    if Controls[I] is TWinControl then
      if TWinControl(Controls[I]).TabOrder = ATabOrder then
      begin
        Result := TWinControl(Controls[I]);
        Break;
      end;
end;

procedure TJvCustomArrangePanel.ArrangeControls;
var
  AktX, AktY, NewX, NewY, MaxY, NewMaxX: Integer;
  ControlMaxX, ControlMaxY: Integer;
  TmpWidth, TmpHeight: Integer;
  LastTabOrder: Integer;
  CurrControl: TWinControl;
  I: Integer;
  OldHeight, OldWidth: Integer;
begin
  if (not ArrangeEnabled) or FArrangeControlActive or (ControlCount = 0) then
    Exit;
  if [csLoading, csReading] * ComponentState <> [] then
    Exit;
  FArrangeWidth := 0;
  FArrangeHeight := 0;
  FArrangeControlActive := True;
  try
    OldHeight := Height;
    OldWidth := Width;
    TmpHeight := Height;
    TmpWidth := Width;
    AktY := FArrangeSettings.BorderTop;
    AktX := FArrangeSettings.BorderLeft;
    LastTabOrder := -1;
    MaxY := -1;
    if (FArrangeSettings.AutoSize in [asWidth, asBoth]) then
      ControlMaxX := TmpWidth - 2 * FArrangeSettings.BorderLeft
    else
      ControlMaxX := -1;
    if (FArrangeSettings.AutoSize in [asHeight, asBoth]) then
      ControlMaxY := TmpHeight - 2 * FArrangeSettings.BorderTop
    else
      ControlMaxY := -1;

    for I := 0 to ControlCount - 1 do
      if Controls[I] is TWinControl then
      begin
        if Controls[I] is TJvCustomArrangePanel then
          TJvCustomArrangePanel(Controls[I]).Rearrange;
        if (Controls[I].Width + 2 * FArrangeSettings.BorderLeft > TmpWidth) then
          TmpWidth := Controls[I].Width + 2 * FArrangeSettings.BorderLeft;
      end;

    if (TmpWidth > FArrangeSettings.MaxWidth) and (FArrangeSettings.MaxWidth > 0) then
      TmpWidth := FArrangeSettings.MaxWidth ;
    CurrControl := GetNextControlByTabOrder(LastTabOrder+1);
    while Assigned(CurrControl) do
    begin
      LastTabOrder := CurrControl.TabOrder;
      if CurrControl.Visible or
        ((csDesigning in ComponentState) and FArrangeSettings.ShowNotVisibleAtDesignTime) then
      begin
        NewMaxX := AktX + CurrControl.Width + FArrangeSettings.DistanceHorizontal +
          FArrangeSettings.BorderLeft;
        if (((NewMaxX > TmpWidth) and not (FArrangeSettings.AutoSize in [asWidth, asBoth])) or
            ((NewMaxX > FArrangeSettings.MaxWidth) and (FArrangeSettings.MaxWidth > 0))) and
           (AktX > FArrangeSettings.BorderLeft) and // Only Valid if there is one control in the current line
           FArrangeSettings.WrapControls then
        begin
          AktX := FArrangeSettings.BorderLeft;
          AktY := AktY + MaxY + FArrangeSettings.DistanceVertical;
          MaxY := -1;
          NewX := AktX;
          NewY := AktY;
        end
        else
        begin
          NewX := AktX;
          NewY := AktY;
        end;
        AktX := AktX + CurrControl.Width;
        if AktX > ControlMaxX then
          ControlMaxX := AktX;
        AktX := AktX + FArrangeSettings.DistanceHorizontal;
        CurrControl.Left := NewX;
        CurrControl.Top := NewY;
        if CurrControl.Height > MaxY then
          MaxY := CurrControl.Height;
        ControlMaxY := AktY + MaxY;
      end;
      CurrControl := GetNextControlByTabOrder(LastTabOrder+1);
    end;

    if not (csLoading in ComponentState) then
    begin
      if (FArrangeSettings.AutoSize in [asWidth, asBoth]) then
        if ControlMaxX >= 0 then
          if (FArrangeSettings.MaxWidth > 0) and (ControlMaxX >= FArrangeSettings.MaxWidth) then
            TmpWidth := FArrangeSettings.MaxWidth
          else
            TmpWidth := ControlMaxX + FArrangeSettings.BorderLeft
        else
          TmpWidth := 0;
      if (FArrangeSettings.AutoSize in [asHeight, asBoth]) then
        if ControlMaxY >= 0 then
          TmpHeight := ControlMaxY + FArrangeSettings.BorderTop
        else
          TmpHeight := 0;
      Width := TmpWidth;
      Height := TmpHeight;
    end;
    FArrangeWidth := ControlMaxX + 2 * FArrangeSettings.BorderLeft;
    FArrangeHeight := ControlMaxY + 2 * FArrangeSettings.BorderTop;
    if (OldWidth <> TmpWidth) or (OldHeight <> Height) then
      SendMessage(GetFocus, WM_PAINT, 0, 0);
  finally
    FArrangeControlActive := False;
  end;
end;

procedure TJvCustomArrangePanel.SetWidth(Value: Integer);
var
  Changed: Boolean;
begin
  Changed := inherited Width <> Value;
  inherited Width := Value;
  if Changed then
  begin
    if Assigned(FOnChangedWidth) then
      FOnChangedWidth (Self, Value);
    if Assigned(FOnResizeParent) then
      FOnResizeParent(Self, Left, Top, Value, Height)
    else
    if Parent is TJvCustomArrangePanel then
      TJvCustomArrangePanel(Parent).Rearrange;
  end;
end;

function TJvCustomArrangePanel.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TJvCustomArrangePanel.SetHeight(Value: Integer);
var
  Changed: Boolean;
begin
  Changed := inherited Height <> Value;
  inherited Height := Value;
  if Changed then
  begin
    if Assigned(FOnChangedHeight) then
      FOnChangedHeight (Self, Value);
    if Assigned(FOnResizeParent) then
      FOnResizeParent(Self, Left, Top, Width, Value)
    else
    if Parent is TJvCustomArrangePanel then
      TJvCustomArrangePanel(Parent).Rearrange;
  end;
end;

function TJvCustomArrangePanel.GetHeight: Integer;
begin
  Result := inherited Height;
end;

procedure TJvCustomArrangePanel.SetArrangeSettings(const Value:
    TJvArrangeSettings);
begin
  if (Value <> nil) and (Value <> FArrangeSettings) then
    FArrangeSettings.Assign(Value);
end;

function TJvCustomArrangePanel.GetHotTrack: Boolean;
begin
  Result := FHotTrack;
end;

function TJvCustomArrangePanel.GetHotTrackFont: TFont;
begin
  Result := FHotTrackFont;
end;

function TJvCustomArrangePanel.GetHotTrackFontOptions: TJvTrackFontOptions;
begin
  Result := FHotTrackFontOptions;
end;

function TJvCustomArrangePanel.GetHotTrackOptions: TJvHotTrackOptions;
begin
  Result := FHotTrackOptions;
end;

procedure TJvCustomArrangePanel.SetHotTrack(Value: Boolean);
begin
  FHotTrack := Value;
end;

procedure TJvCustomArrangePanel.SetHotTrackFont(Value: TFont);
begin
  if (FHotTrackFont<>Value) and (Value <> nil) then
    FHotTrackFont.Assign(Value);
end;

procedure TJvCustomArrangePanel.SetHotTrackFontOptions(Value: TJvTrackFontOptions);
begin
  if FHotTrackFontOptions <> Value then
  begin
    FHotTrackFontOptions := Value;
    UpdateTrackFont(HotTrackFont, Font, FHotTrackFontOptions);
  end;
end;

procedure TJvCustomArrangePanel.SetHotTrackOptions(Value: TJvHotTrackOptions);
begin
  if (FHotTrackOptions <> Value) and (Value <> nil) then
    FHotTrackOptions.Assign(Value);
end;

procedure TJvCustomArrangePanel.IJvHotTrack_Assign(
  Source: IJvHotTrack);
begin
  if (Source <> nil) and (IJvHotTrack(Self) <> Source) then
  begin
    HotTrack := Source.HotTrack;
    HotTrackFont :=Source.HotTrackFont;
    HotTrackFontOptions := Source.HotTrackFontOptions;
    HotTrackOptions := Source.HotTrackOptions;
  end;
end;

procedure TJvCustomArrangePanel.Rearrange;
begin
  if FArrangeSettings.AutoArrange and not (csLoading in ComponentState) then
    ArrangeControls;
end;

procedure TJvCustomArrangePanel.DoArrangeSettingsPropertyChanged(Sender: TObject;
  const PropName: string);
begin
  if SameText(PropName, 'AutoArrange') then
  begin
    if ArrangeSettings.AutoArrange then
      Rearrange;
  end
  else
  if SameText(PropName, 'AutoSize') then
  begin
    if ArrangeSettings.AutoSize <> asNone then
      Rearrange;
  end
  else //otherwise call Rearrange
    Rearrange;
end;

function TJvCustomArrangePanel.GetArrangeSettings: TJvArrangeSettings;
begin
  Result := fArrangeSettings;
end;

{ TJvPanel }

procedure TJvPanel.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  { For backward compatibility }
  FFilerTag := 'HotColor';
  Filer.DefineProperty(FFilerTag, ReadData, nil, False);
end;

procedure TJvPanel.ReadData(Reader: TReader);
var
  C: Integer;
begin
  if SameText(FFilerTag, 'HotColor') then
  begin
    if Reader.NextValue = vaIdent then
    begin
      if IdentToColor(Reader.ReadIdent, C) then
        HotTrackOptions.Color := C;
    end
    else
      HotTrackOptions.Color := Reader.ReadInteger;
  end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.


