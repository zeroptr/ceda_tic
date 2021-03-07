{*******************************************************}
{                                                       }
{       TiTimers Component                              }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iTimers;{$endif}
{$ifdef iCLX}unit QiTimers;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath;{$ENDIF}

type
  TiTimers = class(TCustomControl)
  private
    {$ifndef iCLX}
    FWindowHandle : HWND;

    FHandle1   : Integer;
    FHandle2   : Integer;
    FHandle3   : Integer;
    FHandle4   : Integer;
    FHandle5   : Integer;
    FHandle6   : Integer;
    FHandle7   : Integer;
    FHandle8   : Integer;
    FHandle9   : Integer;
    {$else}
    FHandle1   : QTimerH;
    FHandle2   : QTimerH;
    FHandle3   : QTimerH;
    FHandle4   : QTimerH;
    FHandle5   : QTimerH;
    FHandle6   : QTimerH;
    FHandle7   : QTimerH;
    FHandle8   : QTimerH;
    FHandle9   : QTimerH;

    FHook1     : QTimer_hookH;
    FHook2     : QTimer_hookH;
    FHook3     : QTimer_hookH;
    FHook4     : QTimer_hookH;
    FHook5     : QTimer_hookH;
    FHook6     : QTimer_hookH;
    FHook7     : QTimer_hookH;
    FHook8     : QTimer_hookH;
    FHook9     : QTimer_hookH;
    {$endif}

    FEnabled1  : Boolean;
    FEnabled2  : Boolean;
    FEnabled3  : Boolean;
    FEnabled4  : Boolean;
    FEnabled5  : Boolean;
    FEnabled6  : Boolean;
    FEnabled7  : Boolean;
    FEnabled8  : Boolean;
    FEnabled9  : Boolean;

    FInterval1 : Integer;
    FInterval2 : Integer;
    FInterval3 : Integer;
    FInterval4 : Integer;
    FInterval5 : Integer;
    FInterval6 : Integer;
    FInterval7 : Integer;
    FInterval8 : Integer;
    FInterval9 : Integer;

    FOnTimer1  : TNotifyEvent;
    FOnTimer2  : TNotifyEvent;
    FOnTimer3  : TNotifyEvent;
    FOnTimer4  : TNotifyEvent;
    FOnTimer5  : TNotifyEvent;
    FOnTimer6  : TNotifyEvent;
    FOnTimer7  : TNotifyEvent;
    FOnTimer8  : TNotifyEvent;
    FOnTimer9  : TNotifyEvent;

    procedure SetEnabled1  (const Value: Boolean);
    procedure SetEnabled2  (const Value: Boolean);
    procedure SetEnabled3  (const Value: Boolean);
    procedure SetEnabled4  (const Value: Boolean);
    procedure SetEnabled5  (const Value: Boolean);
    procedure SetEnabled6  (const Value: Boolean);
    procedure SetEnabled7  (const Value: Boolean);
    procedure SetEnabled8  (const Value: Boolean);
    procedure SetEnabled9  (const Value: Boolean);
    procedure SetInterval1 (const Value: Integer);
    procedure SetInterval2 (const Value: Integer);
    procedure SetInterval3 (const Value: Integer);
    procedure SetInterval4 (const Value: Integer);
    procedure SetInterval5 (const Value: Integer);
    procedure SetInterval6 (const Value: Integer);
    procedure SetInterval7 (const Value: Integer);
    procedure SetInterval8 (const Value: Integer);
    procedure SetInterval9 (const Value: Integer);

    {$ifndef iCLX}
    procedure TimerProc(var Msg: TMessage);
    {$else}
    procedure TimerCallBack1; cdecl;
    procedure TimerCallBack2; cdecl;
    procedure TimerCallBack3; cdecl;
    procedure TimerCallBack4; cdecl;
    procedure TimerCallBack5; cdecl;
    procedure TimerCallBack6; cdecl;
    procedure TimerCallBack7; cdecl;
    procedure TimerCallBack8; cdecl;
    procedure TimerCallBack9; cdecl;
    {$endif}

  protected
    procedure Paint;                                              override;
  public
    constructor Create(AOwner: TComponent);                       override;
    destructor  Destroy;                                          override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property    OnDblClick;
  published
    property Enabled1  : Boolean      read FEnabled1  write SetEnabled1   default False;
    property Enabled2  : Boolean      read FEnabled2  write SetEnabled2   default False;
    property Enabled3  : Boolean      read FEnabled3  write SetEnabled3   default False;
    property Enabled4  : Boolean      read FEnabled4  write SetEnabled4   default False;
    property Enabled5  : Boolean      read FEnabled5  write SetEnabled5   default False;
    property Enabled6  : Boolean      read FEnabled6  write SetEnabled6   default False;
    property Enabled7  : Boolean      read FEnabled7  write SetEnabled7   default False;
    property Enabled8  : Boolean      read FEnabled8  write SetEnabled8   default False;
    property Enabled9  : Boolean      read FEnabled9  write SetEnabled9   default False;

    property Interval1 : Integer      read FInterval1  write SetInterval1 default 1000;
    property Interval2 : Integer      read FInterval2  write SetInterval2 default 1000;
    property Interval3 : Integer      read FInterval3  write SetInterval3 default 1000;
    property Interval4 : Integer      read FInterval4  write SetInterval4 default 1000;
    property Interval5 : Integer      read FInterval5  write SetInterval5 default 1000;
    property Interval6 : Integer      read FInterval6  write SetInterval6 default 1000;
    property Interval7 : Integer      read FInterval7  write SetInterval7 default 1000;
    property Interval8 : Integer      read FInterval8  write SetInterval8 default 1000;
    property Interval9 : Integer      read FInterval9  write SetInterval9 default 1000;

    property OnTimer1  : TNotifyEvent read FOnTimer1   write FOnTimer1;
    property OnTimer2  : TNotifyEvent read FOnTimer2   write FOnTimer2;
    property OnTimer3  : TNotifyEvent read FOnTimer3   write FOnTimer3;
    property OnTimer4  : TNotifyEvent read FOnTimer4   write FOnTimer4;
    property OnTimer5  : TNotifyEvent read FOnTimer5   write FOnTimer5;
    property OnTimer6  : TNotifyEvent read FOnTimer6   write FOnTimer6;
    property OnTimer7  : TNotifyEvent read FOnTimer7   write FOnTimer7;
    property OnTimer8  : TNotifyEvent read FOnTimer8   write FOnTimer8;
    property OnTimer9  : TNotifyEvent read FOnTimer9   write FOnTimer9;

    property Visible default False;
    property PopupMenu;

    property Width  default 28;
    property Height default 28;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiTimers.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csReplicatable];

  Width   := 28;
  Height  := 28;
  Visible := False;

  FInterval1 := 1000;
  FInterval2 := 1000;
  FInterval3 := 1000;
  FInterval4 := 1000;
  FInterval5 := 1000;
  FInterval6 := 1000;
  FInterval7 := 1000;
  FInterval8 := 1000;
  FInterval9 := 1000;

 {$WARNINGS OFF}
  {$ifndef iCLX}
  FWindowHandle := AllocateHWnd(TimerProc);
  {$endif}
 {$WARNINGS ON}
end;
//****************************************************************************************************************************************************
destructor TiTimers.Destroy;
begin
  {$ifndef iCLX}
  if FHandle1  <> 0 then KillTimer(FWindowHandle, 1);
  if FHandle2  <> 0 then KillTimer(FWindowHandle, 2);
  if FHandle3  <> 0 then KillTimer(FWindowHandle, 3);
  if FHandle4  <> 0 then KillTimer(FWindowHandle, 4);
  if FHandle5  <> 0 then KillTimer(FWindowHandle, 5);
  if FHandle6  <> 0 then KillTimer(FWindowHandle, 6);
  if FHandle7  <> 0 then KillTimer(FWindowHandle, 7);
  if FHandle8  <> 0 then KillTimer(FWindowHandle, 8);
  if FHandle9  <> 0 then KillTimer(FWindowHandle, 9);
 {$WARNINGS OFF}
  DeallocateHWnd(FWindowHandle);
 {$WARNINGS ON}
  {$else}
  if Assigned(FHook1) then QTimer_hook_destroy(FHook1);
  if Assigned(FHook2) then QTimer_hook_destroy(FHook2);
  if Assigned(FHook3) then QTimer_hook_destroy(FHook3);
  if Assigned(FHook4) then QTimer_hook_destroy(FHook4);
  if Assigned(FHook5) then QTimer_hook_destroy(FHook5);
  if Assigned(FHook6) then QTimer_hook_destroy(FHook6);
  if Assigned(FHook7) then QTimer_hook_destroy(FHook7);
  if Assigned(FHook8) then QTimer_hook_destroy(FHook8);
  if Assigned(FHook9) then QTimer_hook_destroy(FHook9);
  if Assigned(FHandle1) then QTimer_destroy(FHandle1);
  if Assigned(FHandle2) then QTimer_destroy(FHandle2);
  if Assigned(FHandle3) then QTimer_destroy(FHandle3);
  if Assigned(FHandle4) then QTimer_destroy(FHandle4);
  if Assigned(FHandle5) then QTimer_destroy(FHandle5);
  if Assigned(FHandle6) then QTimer_destroy(FHandle6);
  if Assigned(FHandle7) then QTimer_destroy(FHandle7);
  if Assigned(FHandle8) then QTimer_destroy(FHandle8);
  if Assigned(FHandle9) then QTimer_destroy(FHandle9);
  {$endif}
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  AWidth  := 28;
  AHeight := 28;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiTimers.Paint;
var
  i, x, y : Integer;
begin
  with Canvas do
    begin
      Pen.Color := clBtnHighlight;
      PolyLine([Point(0,Height-1), Point(0,0), Point(Width-1,0)]);

      Pen.Color := clBtnShadow;
      PolyLine([Point(Width-1, 1), Point(Width-1,Height-1), Point(0,Height-1)]);

      Pen.Color := clBlack;
      Brush.Color := clWhite;

      Ellipse(6, 6, 23, 23);
      PolyLine([Point(14,9), Point(14,14), Point(18,14)]);

      Pen.Color := clMaroon;
      for i := 0 to 11 do
        begin
          x := 14 + Round(Cos(DegToRad(i*30))*6);
          y := 14 - Round(Sin(DegToRad(i*30))*6);
          {$ifdef iVCL}Polyline([Point(x, y), Point(x+1, y+1)]);{$endif}
          {$ifdef iCLX}Polyline([Point(x, y), Point(x,   y)  ]);{$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetEnabled1(const Value: Boolean);
{$ifdef iCLX}
var
  Timeout : TMethod;
{$endif}
begin
  if FEnabled1 <> Value then
    begin
      FEnabled1 := Value;
      {$ifndef iCLX}
      case FEnabled1 of
        False : if FHandle1 <> 0 then
                  begin
                    KillTimer(FWindowHandle, FHandle1);
                    FHandle1 := 0;
                  end;
        True  : if FHandle1 =  0 then FHandle1 := SetTimer(FWindowHandle, 1, FInterval1, nil);
      end;
      {$else}
      case FEnabled1 of
        False : if Assigned(FHandle1) then QTimer_stop(FHandle1);
        True  : if not (csDesigning in ComponentState) then
                  begin
                    if not Assigned(FHandle1) then
                      begin
                        FHandle1 := QTimer_create(nil, nil);
                        FHook1 := QTimer_hook_create(FHandle1);
                        QTimer_timeout_Event(Timeout) := TimerCallBack1;
                        QTimer_hook_hook_timeout(FHook1, Timeout);
                      end;
                      QTimer_start(FHandle1, FInterval1, False);
                  end;
      end;
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetEnabled2(const Value: Boolean);
{$ifdef iCLX}
var
  Timeout : TMethod;
{$endif}
begin
  if FEnabled2 <> Value then
    begin
      FEnabled2 := Value;
      {$ifndef iCLX}
      case FEnabled2 of
        False : if FHandle2 <> 0 then
                  begin
                    KillTimer(FWindowHandle, FHandle2);
                    FHandle2 := 0;
                  end;
        True  : if FHandle2 =  0 then FHandle2 := SetTimer(FWindowHandle, 2, FInterval2, nil);
      end;
      {$else}
      case FEnabled2 of
        False : if Assigned(FHandle2) then QTimer_stop(FHandle2);
        True  : if not (csDesigning in ComponentState) then
                  begin
                    if not Assigned(FHandle2) then
                      begin
                        FHandle2 := QTimer_create(nil, nil);
                        FHook2 := QTimer_hook_create(FHandle2);
                        QTimer_timeout_Event(Timeout) := TimerCallBack2;
                        QTimer_hook_hook_timeout(FHook2, Timeout);
                      end;
                      QTimer_start(FHandle2, FInterval2, False);
                  end;
      end;
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetEnabled3(const Value: Boolean);
{$ifdef iCLX}
var
  Timeout : TMethod;
{$endif}
begin
  if FEnabled3 <> Value then
    begin
      FEnabled3 := Value;
      {$ifndef iCLX}
      case FEnabled3 of
        False : if FHandle3 <> 0 then
                  begin
                    KillTimer(FWindowHandle, FHandle3);
                    FHandle3 := 0;
                  end;
        True  : if FHandle3 =  0 then FHandle3 := SetTimer(FWindowHandle, 3, FInterval3, nil);
      end;
      {$else}
      case FEnabled3 of
        False : if Assigned(FHandle3) then QTimer_stop(FHandle3);
        True  : if not (csDesigning in ComponentState) then
                  begin
                    if not Assigned(FHandle3) then
                      begin
                        FHandle3 := QTimer_create(nil, nil);
                        FHook3 := QTimer_hook_create(FHandle3);
                        QTimer_timeout_Event(Timeout) := TimerCallBack3;
                        QTimer_hook_hook_timeout(FHook3, Timeout);
                      end;
                      QTimer_start(FHandle3, FInterval3, False);
                  end;
      end;
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetEnabled4(const Value: Boolean);
{$ifdef iCLX}
var
  Timeout : TMethod;
{$endif}
begin
  if FEnabled4 <> Value then
    begin
      FEnabled4 := Value;
      {$ifndef iCLX}
      case FEnabled4 of
        False : if FHandle4 <> 0 then
                  begin
                    KillTimer(FWindowHandle, FHandle4);
                    FHandle4 := 0;
                  end;
        True  : if FHandle4 =  0 then FHandle4 := SetTimer(FWindowHandle, 4, FInterval4, nil);
      end;
      {$else}
      case FEnabled4 of
        False : if Assigned(FHandle4) then QTimer_stop(FHandle4);
        True  : if not (csDesigning in ComponentState) then
                  begin
                    if not Assigned(FHandle4) then
                      begin
                        FHandle4 := QTimer_create(nil, nil);
                        FHook4 := QTimer_hook_create(FHandle4);
                        QTimer_timeout_Event(Timeout) := TimerCallBack4;
                        QTimer_hook_hook_timeout(FHook4, Timeout);
                      end;
                      QTimer_start(FHandle4, FInterval4, False);
                  end;
      end;
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetEnabled5(const Value: Boolean);
{$ifdef iCLX}
var
  Timeout : TMethod;
{$endif}
begin
  if FEnabled5 <> Value then
    begin
      FEnabled5 := Value;
      {$ifndef iCLX}
      case FEnabled5 of
        False : if FHandle5 <> 0 then
                  begin
                    KillTimer(FWindowHandle, FHandle5);
                    FHandle5 := 0;
                  end;
        True  : if FHandle5 =  0 then FHandle5 := SetTimer(FWindowHandle, 5, FInterval5, nil);
      end;
      {$else}
      case FEnabled5 of
        False : if Assigned(FHandle5) then QTimer_stop(FHandle5);
        True  : if not (csDesigning in ComponentState) then
                  begin
                    if not Assigned(FHandle5) then
                      begin
                        FHandle5 := QTimer_create(nil, nil);
                        FHook5 := QTimer_hook_create(FHandle5);
                        QTimer_timeout_Event(Timeout) := TimerCallBack5;
                        QTimer_hook_hook_timeout(FHook5, Timeout);
                      end;
                      QTimer_start(FHandle5, FInterval5, False);
                  end;
      end;
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetEnabled6(const Value: Boolean);
{$ifdef iCLX}
var
  Timeout : TMethod;
{$endif}
begin
  if FEnabled6 <> Value then
    begin
      FEnabled6 := Value;
      {$ifndef iCLX}
      case FEnabled6 of
        False : if FHandle6 <> 0 then
                  begin
                    KillTimer(FWindowHandle, FHandle6);
                    FHandle6 := 0;
                  end;
        True  : if FHandle6 =  0 then FHandle6 := SetTimer(FWindowHandle, 6, FInterval6, nil);
      end;
      {$else}
      case FEnabled6 of
        False : if Assigned(FHandle6) then QTimer_stop(FHandle6);
        True  : if not (csDesigning in ComponentState) then
                  begin
                    if not Assigned(FHandle6) then
                      begin
                        FHandle6 := QTimer_create(nil, nil);
                        FHook6 := QTimer_hook_create(FHandle6);
                        QTimer_timeout_Event(Timeout) := TimerCallBack6;
                        QTimer_hook_hook_timeout(FHook6, Timeout);
                      end;
                      QTimer_start(FHandle6, FInterval6, False);
                  end;
      end;
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetEnabled7(const Value: Boolean);
{$ifdef iCLX}
var
  Timeout : TMethod;
{$endif}
begin
  if FEnabled7 <> Value then
    begin
      FEnabled7 := Value;
      {$ifndef iCLX}
      case FEnabled7 of
        False : if FHandle7 <> 0 then
                  begin
                    KillTimer(FWindowHandle, FHandle7);
                    FHandle7 := 0;
                  end;
        True  : if FHandle7 =  0 then FHandle7 := SetTimer(FWindowHandle, 7, FInterval7, nil);
      end;
      {$else}
      case FEnabled7 of
        False : if Assigned(FHandle7) then QTimer_stop(FHandle7);
        True  : if not (csDesigning in ComponentState) then
                  begin
                    if not Assigned(FHandle7) then
                      begin
                        FHandle7 := QTimer_create(nil, nil);
                        FHook7 := QTimer_hook_create(FHandle7);
                        QTimer_timeout_Event(Timeout) := TimerCallBack7;
                        QTimer_hook_hook_timeout(FHook7, Timeout);
                      end;
                      QTimer_start(FHandle7, FInterval7, False);
                  end;
      end;
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetEnabled8(const Value: Boolean);
{$ifdef iCLX}
var
  Timeout : TMethod;
{$endif}
begin
  if FEnabled8 <> Value then
    begin
      FEnabled8 := Value;
      {$ifndef iCLX}
      case FEnabled8 of
        False : if FHandle8 <> 0 then
                  begin
                    KillTimer(FWindowHandle, FHandle8);
                    FHandle8 := 0;
                  end;
        True  : if FHandle8 =  0 then FHandle8 := SetTimer(FWindowHandle, 8, FInterval8, nil);
      end;
      {$else}
      case FEnabled8 of
        False : if Assigned(FHandle8) then QTimer_stop(FHandle8);
        True  : if not (csDesigning in ComponentState) then
                  begin
                    if not Assigned(FHandle8) then
                      begin
                        FHandle8 := QTimer_create(nil, nil);
                        FHook8 := QTimer_hook_create(FHandle8);
                        QTimer_timeout_Event(Timeout) := TimerCallBack8;
                        QTimer_hook_hook_timeout(FHook8, Timeout);
                      end;
                      QTimer_start(FHandle8, FInterval8, False);
                  end;
      end;
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetEnabled9(const Value: Boolean);
{$ifdef iCLX}
var
  Timeout : TMethod;
{$endif}
begin
  if FEnabled9 <> Value then
    begin
      FEnabled9 := Value;
      {$ifndef iCLX}
      case FEnabled9 of
        False : if FHandle9 <> 0 then
                  begin
                    KillTimer(FWindowHandle, FHandle9);
                    FHandle9 := 0;
                  end;
        True  : if FHandle9 =  0 then FHandle9 := SetTimer(FWindowHandle, 9, FInterval9, nil);
      end;
      {$else}
      case FEnabled9 of
        False : if Assigned(FHandle9) then QTimer_stop(FHandle9);
        True  : if not (csDesigning in ComponentState) then
                  begin
                    if not Assigned(FHandle9) then
                      begin
                        FHandle9 := QTimer_create(nil, nil);
                        FHook9 := QTimer_hook_create(FHandle9);
                        QTimer_timeout_Event(Timeout) := TimerCallBack9;
                        QTimer_hook_hook_timeout(FHook9, Timeout);
                      end;
                      QTimer_start(FHandle9, FInterval9, False);
                  end;
      end;
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
//****************************************************************************************************************************************************
procedure TiTimers.SetInterval1(const Value: Integer);
begin
  if Value < 0 then raise Exception.Create('Value must be Positive');
  if FInterval1 <> Value then
    begin
      FInterval1 := Value;
      if FEnabled1 then
        begin
          {$ifndef iCLX}
          if (FHandle1 <> 0) then KillTimer(FWindowHandle, FHandle1);
          FHandle1 := SetTimer(FWindowHandle, 1, FInterval1, nil);
          {$else}
          if Assigned(FHandle1) then QTimer_changeInterval(FHandle1, FInterval1);
          {$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetInterval2(const Value: Integer);
begin
  if Value < 0 then raise Exception.Create('Value must be Positive');
  if FInterval2 <> Value then
    begin
      FInterval2 := Value;
      if FEnabled2 then
        begin
          {$ifndef iCLX}
          if (FHandle2 <> 0) then KillTimer(FWindowHandle, FHandle2);
          FHandle2 := SetTimer(FWindowHandle, 2, FInterval2, nil);
          {$else}
          if Assigned(FHandle2) then QTimer_changeInterval(FHandle2, FInterval2);
          {$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetInterval3(const Value: Integer);
begin
  if Value < 0 then raise Exception.Create('Value must be Positive');
  if FInterval3 <> Value then
    begin
      FInterval3 := Value;
      if FEnabled3 then
        begin
          {$ifndef iCLX}
          if (FHandle3 <> 0) then KillTimer(FWindowHandle, FHandle3);
          FHandle3 := SetTimer(FWindowHandle, 3, FInterval3, nil);
          {$else}
          if Assigned(FHandle3) then QTimer_changeInterval(FHandle3, FInterval3);
          {$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetInterval4(const Value: Integer);
begin
  if Value < 0 then raise Exception.Create('Value must be Positive');
  if FInterval4 <> Value then
    begin
      FInterval4 := Value;
      if FEnabled4 then
        begin
          {$ifndef iCLX}
          if (FHandle4 <> 0) then KillTimer(FWindowHandle, FHandle4);
          FHandle4 := SetTimer(FWindowHandle, 4, FInterval4, nil);
          {$else}
          if Assigned(FHandle4) then QTimer_changeInterval(FHandle4, FInterval4);
          {$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetInterval5(const Value: Integer);
begin
  if Value < 0 then raise Exception.Create('Value must be Positive');
  if FInterval5 <> Value then
    begin
      FInterval5 := Value;
      if FEnabled5 then
        begin
          {$ifndef iCLX}
          if (FHandle5 <> 0) then KillTimer(FWindowHandle, FHandle5);
          FHandle5 := SetTimer(FWindowHandle, 5, FInterval5, nil);
          {$else}
          if Assigned(FHandle5) then QTimer_changeInterval(FHandle5, FInterval5);
          {$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetInterval6(const Value: Integer);
begin
  if Value < 0 then raise Exception.Create('Value must be Positive');
  if FInterval6 <> Value then
    begin
      FInterval6 := Value;
      if FEnabled6 then
        begin
          {$ifndef iCLX}
          if (FHandle6 <> 0) then KillTimer(FWindowHandle, FHandle6);
          FHandle6 := SetTimer(FWindowHandle, 6, FInterval6, nil);
          {$else}
          if Assigned(FHandle6) then QTimer_changeInterval(FHandle6, FInterval6);
          {$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetInterval7(const Value: Integer);
begin
  if Value < 0 then raise Exception.Create('Value must be Positive');
  if FInterval7 <> Value then
    begin
      FInterval7 := Value;
      if FEnabled7 then
        begin
          {$ifndef iCLX}
          if (FHandle7 <> 0) then KillTimer(FWindowHandle, FHandle7);
          FHandle7 := SetTimer(FWindowHandle, 7, FInterval7, nil);
          {$else}
          if Assigned(FHandle7) then QTimer_changeInterval(FHandle7, FInterval7);
          {$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetInterval8(const Value: Integer);
begin
  if Value < 0 then raise Exception.Create('Value must be Positive');
  if FInterval8 <> Value then
    begin
      FInterval8 := Value;
      if FEnabled8 then
        begin
          {$ifndef iCLX}
          if (FHandle8 <> 0) then KillTimer(FWindowHandle, FHandle8);
          FHandle8 := SetTimer(FWindowHandle, 8, FInterval8, nil);
          {$else}
          if Assigned(FHandle8) then QTimer_changeInterval(FHandle8, FInterval8);
          {$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.SetInterval9(const Value: Integer);
begin
  if Value < 0 then raise Exception.Create('Value must be Positive');
  if FInterval9 <> Value then
    begin
      FInterval9 := Value;
      if FEnabled9 then
        begin
          {$ifndef iCLX}
          if (FHandle9 <> 0) then KillTimer(FWindowHandle, FHandle9);
          FHandle9 := SetTimer(FWindowHandle, 9, FInterval9, nil);
          {$else}
          if Assigned(FHandle9) then QTimer_changeInterval(FHandle9, FInterval9);
          {$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
{$ifndef iCLX}
procedure TiTimers.TimerProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_TIMER then
      case WParam of
        1 : if Assigned(FOnTimer1) then FOnTimer1(Self);
        2 : if Assigned(FOnTimer2) then FOnTimer2(Self);
        3 : if Assigned(FOnTimer3) then FOnTimer3(Self);
        4 : if Assigned(FOnTimer4) then FOnTimer4(Self);
        5 : if Assigned(FOnTimer5) then FOnTimer5(Self);
        6 : if Assigned(FOnTimer6) then FOnTimer6(Self);
        7 : if Assigned(FOnTimer7) then FOnTimer7(Self);
        8 : if Assigned(FOnTimer8) then FOnTimer8(Self);
        9 : if Assigned(FOnTimer9) then FOnTimer9(Self);
      end
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;
{$else}
//****************************************************************************************************************************************************
procedure TiTimers.TimerCallBack1;
begin
  try
    if Assigned(FOnTimer1) then FOnTimer1(Self);
  except
    Application.HandleException(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.TimerCallBack2;
begin
  try
    if Assigned(FOnTimer2) then FOnTimer2(Self);
  except
    Application.HandleException(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.TimerCallBack3;
begin
  try
    if Assigned(FOnTimer3) then FOnTimer3(Self);
  except
    Application.HandleException(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.TimerCallBack4;
begin
  try
    if Assigned(FOnTimer4) then FOnTimer4(Self);
  except
    Application.HandleException(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.TimerCallBack5;
begin
  try
    if Assigned(FOnTimer5) then FOnTimer5(Self);
  except
    Application.HandleException(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.TimerCallBack6;
begin
  try
    if Assigned(FOnTimer6) then FOnTimer6(Self);
  except
    Application.HandleException(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.TimerCallBack7;
begin
  try
    if Assigned(FOnTimer7) then FOnTimer7(Self);
  except
    Application.HandleException(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.TimerCallBack8;
begin
  try
    if Assigned(FOnTimer8) then FOnTimer8(Self);
  except
    Application.HandleException(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiTimers.TimerCallBack9;
begin
  try
    if Assigned(FOnTimer9) then FOnTimer9(Self);
  except
    Application.HandleException(Self);
  end;
end;
{$endif}
//****************************************************************************************************************************************************
end.


