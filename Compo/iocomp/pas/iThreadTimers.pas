{*******************************************************}
{                                                       }
{       TiThreadTimers Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iThreadTimers;{$endif}
{$ifdef iCLX}unit QiThreadTimers;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath;{$ENDIF}

{$ifdef iVCL}
const
  WM_ITHREADTIMERMSG = WM_USER + 100;
{$ENDIF}

type
  {$ifdef iCLX}TiThreadPriority = (itpIdle, itpLowest, itpLower, itpNormal, itpHigher, itpHighest, itpTimeCritical);{$endif}
  {$ifdef iCLX}TiThreadPolicy   = (itpSCHED_OTHER, itpSCHED_FIFO, itpSCHED_RR);                                     {$endif}

  TiTimerThread = class(TThread)
  private
    {$ifdef iVCL}                  WindowHandle     : HWND;            {$ENDIF}
    {$ifdef LINUX}                 FPriorityWindows : TiThreadPriority;{$ENDIF}
    {$ifdef iCLX}{$ifdef MSWINDOWS}FPriorityLinux   : Integer;         {$ENDIF}{$ENDIF}
    {$ifdef iCLX}{$ifdef MSWINDOWS}FPolicyLinux     : TiThreadPolicy;  {$ENDIF}{$ENDIF}
  protected
    {$IFDEF iCLX}
    procedure SetPriorityWindows(const Value: TiThreadPriority);
    procedure SetPriorityLinux  (const Value: Integer);
    procedure SetPolicyLinux    (const Value: TiThreadPolicy);

    function GetPriorityWindows: TiThreadPriority;
    function GetPriorityLinux  : Integer;
    function GetPolicyLinux    : TiThreadPolicy;
    {$ENDIF}

    procedure Execute; override;
    {$ifdef iVCL}procedure MessageMethod(var Message: TMessage);{$ENDIF}
    procedure DoEvent;
  public
    Owner    : TComponent;
    OnTimer  : TNotifyEvent;
    Interval : Integer;
    {$IFDEF iCLX}
    property PriorityWindows : TiThreadPriority read GetPriorityWindows write SetPriorityWindows;
    property PriorityLinux   : Integer          read GetPriorityLinux   write SetPriorityLinux;
    property PolicyLinux     : TiThreadPolicy   read GetPolicyLinux     write SetPolicyLinux;
    {$ENDIF}
    procedure   AfterConstruction; override;
    destructor  Destroy;           override;
  end;

  TiThreadTimers = class(TCustomControl)
  private
    FTimer1   : TiTimerThread;
    FTimer2   : TiTimerThread;
    FTimer3   : TiTimerThread;
    FTimer4   : TiTimerThread;
    FTimer5   : TiTimerThread;
    FTimer6   : TiTimerThread;
    FTimer7   : TiTimerThread;
    FTimer8   : TiTimerThread;
    FTimer9   : TiTimerThread;

    FEnabled1 : Boolean;
    FEnabled2 : Boolean;
    FEnabled3 : Boolean;
    FEnabled4 : Boolean;
    FEnabled5 : Boolean;
    FEnabled6 : Boolean;
    FEnabled7 : Boolean;
    FEnabled8 : Boolean;
    FEnabled9 : Boolean;

    procedure SetEnabled1       (const Value: Boolean);
    procedure SetEnabled2       (const Value: Boolean);
    procedure SetEnabled3       (const Value: Boolean);
    procedure SetEnabled4       (const Value: Boolean);
    procedure SetEnabled5       (const Value: Boolean);
    procedure SetEnabled6       (const Value: Boolean);
    procedure SetEnabled7       (const Value: Boolean);
    procedure SetEnabled8       (const Value: Boolean);
    procedure SetEnabled9       (const Value: Boolean);

    procedure SetInterval1      (const Value: Integer);
    procedure SetInterval2      (const Value: Integer);
    procedure SetInterval3      (const Value: Integer);
    procedure SetInterval4      (const Value: Integer);
    procedure SetInterval5      (const Value: Integer);
    procedure SetInterval6      (const Value: Integer);
    procedure SetInterval7      (const Value: Integer);
    procedure SetInterval8      (const Value: Integer);
    procedure SetInterval9      (const Value: Integer);

    function GetInterval1       : Integer;
    function GetInterval2       : Integer;
    function GetInterval3       : Integer;
    function GetInterval4       : Integer;
    function GetInterval5       : Integer;
    function GetInterval6       : Integer;
    function GetInterval7       : Integer;
    function GetInterval8       : Integer;
    function GetInterval9       : Integer;

    procedure SetOnTimer1       (const Value: TNotifyEvent);
    procedure SetOnTimer2       (const Value: TNotifyEvent);
    procedure SetOnTimer3       (const Value: TNotifyEvent);
    procedure SetOnTimer4       (const Value: TNotifyEvent);
    procedure SetOnTimer5       (const Value: TNotifyEvent);
    procedure SetOnTimer6       (const Value: TNotifyEvent);
    procedure SetOnTimer7       (const Value: TNotifyEvent);
    procedure SetOnTimer8       (const Value: TNotifyEvent);
    procedure SetOnTimer9       (const Value: TNotifyEvent);

    function GetOnTimer1        : TNotifyEvent;
    function GetOnTimer2        : TNotifyEvent;
    function GetOnTimer3        : TNotifyEvent;
    function GetOnTimer4        : TNotifyEvent;
    function GetOnTimer5        : TNotifyEvent;
    function GetOnTimer6        : TNotifyEvent;
    function GetOnTimer7        : TNotifyEvent;
    function GetOnTimer8        : TNotifyEvent;
    function GetOnTimer9        : TNotifyEvent;

    {$ifdef iVCL}
    procedure SetThreadPriority1(const Value: TThreadPriority);
    procedure SetThreadPriority2(const Value: TThreadPriority);
    procedure SetThreadPriority3(const Value: TThreadPriority);
    procedure SetThreadPriority4(const Value: TThreadPriority);
    procedure SetThreadPriority5(const Value: TThreadPriority);
    procedure SetThreadPriority6(const Value: TThreadPriority);
    procedure SetThreadPriority7(const Value: TThreadPriority);
    procedure SetThreadPriority8(const Value: TThreadPriority);
    procedure SetThreadPriority9(const Value: TThreadPriority);

    function GetThreadPriority1 : TThreadPriority;
    function GetThreadPriority2 : TThreadPriority;
    function GetThreadPriority3 : TThreadPriority;
    function GetThreadPriority4 : TThreadPriority;
    function GetThreadPriority5 : TThreadPriority;
    function GetThreadPriority6 : TThreadPriority;
    function GetThreadPriority7 : TThreadPriority;
    function GetThreadPriority8 : TThreadPriority;
    function GetThreadPriority9 : TThreadPriority;
    {$endif}

    {$ifdef iCLX}
    procedure SetThreadPriorityWindows1(const Value: TiThreadPriority);
    procedure SetThreadPriorityWindows2(const Value: TiThreadPriority);
    procedure SetThreadPriorityWindows3(const Value: TiThreadPriority);
    procedure SetThreadPriorityWindows4(const Value: TiThreadPriority);
    procedure SetThreadPriorityWindows5(const Value: TiThreadPriority);
    procedure SetThreadPriorityWindows6(const Value: TiThreadPriority);
    procedure SetThreadPriorityWindows7(const Value: TiThreadPriority);
    procedure SetThreadPriorityWindows8(const Value: TiThreadPriority);
    procedure SetThreadPriorityWindows9(const Value: TiThreadPriority);

    procedure SetThreadPriorityLinux1(const Value: Integer);
    procedure SetThreadPriorityLinux2(const Value: Integer);
    procedure SetThreadPriorityLinux3(const Value: Integer);
    procedure SetThreadPriorityLinux4(const Value: Integer);
    procedure SetThreadPriorityLinux5(const Value: Integer);
    procedure SetThreadPriorityLinux6(const Value: Integer);
    procedure SetThreadPriorityLinux7(const Value: Integer);
    procedure SetThreadPriorityLinux8(const Value: Integer);
    procedure SetThreadPriorityLinux9(const Value: Integer);

    function GetThreadPriorityWindows1 : TiThreadPriority;
    function GetThreadPriorityWindows2 : TiThreadPriority;
    function GetThreadPriorityWindows3 : TiThreadPriority;
    function GetThreadPriorityWindows4 : TiThreadPriority;
    function GetThreadPriorityWindows5 : TiThreadPriority;
    function GetThreadPriorityWindows6 : TiThreadPriority;
    function GetThreadPriorityWindows7 : TiThreadPriority;
    function GetThreadPriorityWindows8 : TiThreadPriority;
    function GetThreadPriorityWindows9 : TiThreadPriority;

    function GetThreadPriorityLinux1 : Integer;
    function GetThreadPriorityLinux2 : Integer;
    function GetThreadPriorityLinux3 : Integer;
    function GetThreadPriorityLinux4 : Integer;
    function GetThreadPriorityLinux5 : Integer;
    function GetThreadPriorityLinux6 : Integer;
    function GetThreadPriorityLinux7 : Integer;
    function GetThreadPriorityLinux8 : Integer;
    function GetThreadPriorityLinux9 : Integer;

    procedure SetThreadPolicyLinux1(const Value: TiThreadPolicy);
    procedure SetThreadPolicyLinux2(const Value: TiThreadPolicy);
    procedure SetThreadPolicyLinux3(const Value: TiThreadPolicy);
    procedure SetThreadPolicyLinux4(const Value: TiThreadPolicy);
    procedure SetThreadPolicyLinux5(const Value: TiThreadPolicy);
    procedure SetThreadPolicyLinux6(const Value: TiThreadPolicy);
    procedure SetThreadPolicyLinux7(const Value: TiThreadPolicy);
    procedure SetThreadPolicyLinux8(const Value: TiThreadPolicy);
    procedure SetThreadPolicyLinux9(const Value: TiThreadPolicy);

    function GetThreadPolicyLinux1 : TiThreadPolicy;
    function GetThreadPolicyLinux2 : TiThreadPolicy;
    function GetThreadPolicyLinux3 : TiThreadPolicy;
    function GetThreadPolicyLinux4 : TiThreadPolicy;
    function GetThreadPolicyLinux5 : TiThreadPolicy;
    function GetThreadPolicyLinux6 : TiThreadPolicy;
    function GetThreadPolicyLinux7 : TiThreadPolicy;
    function GetThreadPolicyLinux8 : TiThreadPolicy;
    function GetThreadPolicyLinux9 : TiThreadPolicy;
    {$endif}
  protected
    procedure Paint;                                              override;
    procedure DestroyTimer(var ATimer: TiTimerThread);
    function  CreateTimer(Interval: Integer; AOnTimer: TNotifyEvent): TiTimerThread;
  public
    constructor Create(AOwner: TComponent);                       override;
    destructor  Destroy;                                          override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property    OnDblClick;
  published
    property Enabled1        : Boolean         read FEnabled1          write SetEnabled1       default False;
    property Enabled2        : Boolean         read FEnabled2          write SetEnabled2       default False;
    property Enabled3        : Boolean         read FEnabled3          write SetEnabled3       default False;
    property Enabled4        : Boolean         read FEnabled4          write SetEnabled4       default False;
    property Enabled5        : Boolean         read FEnabled5          write SetEnabled5       default False;
    property Enabled6        : Boolean         read FEnabled6          write SetEnabled6       default False;
    property Enabled7        : Boolean         read FEnabled7          write SetEnabled7       default False;
    property Enabled8        : Boolean         read FEnabled8          write SetEnabled8       default False;
    property Enabled9        : Boolean         read FEnabled9          write SetEnabled9       default False;

    property Interval1       : Integer         read GetInterval1       write SetInterval1       default 1000;
    property Interval2       : Integer         read GetInterval2       write SetInterval2       default 1000;
    property Interval3       : Integer         read GetInterval3       write SetInterval3       default 1000;
    property Interval4       : Integer         read GetInterval4       write SetInterval4       default 1000;
    property Interval5       : Integer         read GetInterval5       write SetInterval5       default 1000;
    property Interval6       : Integer         read GetInterval6       write SetInterval6       default 1000;
    property Interval7       : Integer         read GetInterval7       write SetInterval7       default 1000;
    property Interval8       : Integer         read GetInterval8       write SetInterval8       default 1000;
    property Interval9       : Integer         read GetInterval9       write SetInterval9       default 1000;

    {$ifdef iVCL}
    property ThreadPriority1 : TThreadPriority read GetThreadPriority1 write SetThreadPriority1 default tpNormal;
    property ThreadPriority2 : TThreadPriority read GetThreadPriority2 write SetThreadPriority2 default tpNormal;
    property ThreadPriority3 : TThreadPriority read GetThreadPriority3 write SetThreadPriority3 default tpNormal;
    property ThreadPriority4 : TThreadPriority read GetThreadPriority4 write SetThreadPriority4 default tpNormal;
    property ThreadPriority5 : TThreadPriority read GetThreadPriority5 write SetThreadPriority5 default tpNormal;
    property ThreadPriority6 : TThreadPriority read GetThreadPriority6 write SetThreadPriority6 default tpNormal;
    property ThreadPriority7 : TThreadPriority read GetThreadPriority7 write SetThreadPriority7 default tpNormal;
    property ThreadPriority8 : TThreadPriority read GetThreadPriority8 write SetThreadPriority8 default tpNormal;
    property ThreadPriority9 : TThreadPriority read GetThreadPriority9 write SetThreadPriority9 default tpNormal;
    {$endif}

    {$ifdef iCLX}
    property ThreadPriorityWindows1 : TiThreadPriority read GetThreadPriorityWindows1 write SetThreadPriorityWindows1;
    property ThreadPriorityWindows2 : TiThreadPriority read GetThreadPriorityWindows2 write SetThreadPriorityWindows2;
    property ThreadPriorityWindows3 : TiThreadPriority read GetThreadPriorityWindows3 write SetThreadPriorityWindows3;
    property ThreadPriorityWindows4 : TiThreadPriority read GetThreadPriorityWindows4 write SetThreadPriorityWindows4;
    property ThreadPriorityWindows5 : TiThreadPriority read GetThreadPriorityWindows5 write SetThreadPriorityWindows5;
    property ThreadPriorityWindows6 : TiThreadPriority read GetThreadPriorityWindows6 write SetThreadPriorityWindows6;
    property ThreadPriorityWindows7 : TiThreadPriority read GetThreadPriorityWindows7 write SetThreadPriorityWindows7;
    property ThreadPriorityWindows8 : TiThreadPriority read GetThreadPriorityWindows8 write SetThreadPriorityWindows8;
    property ThreadPriorityWindows9 : TiThreadPriority read GetThreadPriorityWindows9 write SetThreadPriorityWindows9;

    property ThreadPriorityLinux1   : Integer          read GetThreadPriorityLinux1   write SetThreadPriorityLinux1;
    property ThreadPriorityLinux2   : Integer          read GetThreadPriorityLinux2   write SetThreadPriorityLinux2;
    property ThreadPriorityLinux3   : Integer          read GetThreadPriorityLinux3   write SetThreadPriorityLinux3;
    property ThreadPriorityLinux4   : Integer          read GetThreadPriorityLinux4   write SetThreadPriorityLinux4;
    property ThreadPriorityLinux5   : Integer          read GetThreadPriorityLinux5   write SetThreadPriorityLinux5;
    property ThreadPriorityLinux6   : Integer          read GetThreadPriorityLinux6   write SetThreadPriorityLinux6;
    property ThreadPriorityLinux7   : Integer          read GetThreadPriorityLinux7   write SetThreadPriorityLinux7;
    property ThreadPriorityLinux8   : Integer          read GetThreadPriorityLinux8   write SetThreadPriorityLinux8;
    property ThreadPriorityLinux9   : Integer          read GetThreadPriorityLinux9   write SetThreadPriorityLinux9;

    property ThreadPolicyLinux1     : TiThreadPolicy   read GetThreadPolicyLinux1     write SetThreadPolicyLinux1 default itpSCHED_OTHER;
    property ThreadPolicyLinux2     : TiThreadPolicy   read GetThreadPolicyLinux2     write SetThreadPolicyLinux2 default itpSCHED_OTHER;
    property ThreadPolicyLinux3     : TiThreadPolicy   read GetThreadPolicyLinux3     write SetThreadPolicyLinux3 default itpSCHED_OTHER;
    property ThreadPolicyLinux4     : TiThreadPolicy   read GetThreadPolicyLinux4     write SetThreadPolicyLinux4 default itpSCHED_OTHER;
    property ThreadPolicyLinux5     : TiThreadPolicy   read GetThreadPolicyLinux5     write SetThreadPolicyLinux5 default itpSCHED_OTHER;
    property ThreadPolicyLinux6     : TiThreadPolicy   read GetThreadPolicyLinux6     write SetThreadPolicyLinux6 default itpSCHED_OTHER;
    property ThreadPolicyLinux7     : TiThreadPolicy   read GetThreadPolicyLinux7     write SetThreadPolicyLinux7 default itpSCHED_OTHER;
    property ThreadPolicyLinux8     : TiThreadPolicy   read GetThreadPolicyLinux8     write SetThreadPolicyLinux8 default itpSCHED_OTHER;
    property ThreadPolicyLinux9     : TiThreadPolicy   read GetThreadPolicyLinux9     write SetThreadPolicyLinux9 default itpSCHED_OTHER;
    {$endif}

    property OnTimer1        : TNotifyEvent    read GetOnTimer1        write SetOnTimer1;
    property OnTimer2        : TNotifyEvent    read GetOnTimer2        write SetOnTimer2;
    property OnTimer3        : TNotifyEvent    read GetOnTimer3        write SetOnTimer3;
    property OnTimer4        : TNotifyEvent    read GetOnTimer4        write SetOnTimer4;
    property OnTimer5        : TNotifyEvent    read GetOnTimer5        write SetOnTimer5;
    property OnTimer6        : TNotifyEvent    read GetOnTimer6        write SetOnTimer6;
    property OnTimer7        : TNotifyEvent    read GetOnTimer7        write SetOnTimer7;
    property OnTimer8        : TNotifyEvent    read GetOnTimer8        write SetOnTimer8;
    property OnTimer9        : TNotifyEvent    read GetOnTimer9        write SetOnTimer9;

    property Visible          default False;
    property Width            default 28;
    property Height           default 28;
    property PopupMenu;
  end;

implementation
//****************************************************************************************************************************************************
procedure TiTimerThread.AfterConstruction;
begin
  inherited;
  {$ifdef iVCL}WindowHandle := AllocateHWnd(MessageMethod);{$endif}
end;
//****************************************************************************************************************************************************
destructor TiTimerThread.Destroy;
begin
  {$ifdef iVCL}DeallocateHWnd(WindowHandle);{$endif}
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiTimerThread.DoEvent;
begin
  if Terminated then Exit;
  if Assigned(OnTimer) then OnTimer(Owner);
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiTimerThread.MessageMethod(var Message: TMessage);
begin
  if Suspended then Exit;
  if Message.Msg <> WM_ITHREADTIMERMSG then EXIT;
  if Terminated then Exit;
  if Assigned(OnTimer) then OnTimer(Owner);
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiTimerThread.Execute;
begin
  while (not Terminated) do
    begin                 
      Sleep(Interval);
      {$ifdef iVCL}if not Terminated then SendNotifyMessage(WindowHandle, WM_ITHREADTIMERMSG, 0, 0);{$endif}
      {$ifdef iCLX}if not Terminated then Synchronize(DoEvent);                                     {$endif}
    end;
end;
//****************************************************************************************************************************************************
{$ifdef iCLX}
procedure TiTimerThread.SetPriorityWindows(const Value: TiThreadPriority);
begin
  {$ifdef MSWINDOWS}Priority         := TThreadPriority(Value);{$endif}
  {$ifdef LINUX}    FPriorityWindows := Value;                 {$endif}
end;
//****************************************************************************************************************************************************
procedure TiTimerThread.SetPriorityLinux(const Value: Integer);
begin
  {$ifdef MSWINDOWS}FPriorityLinux := Value;{$endif}
  {$ifdef LINUX}    Priority       := Value;{$endif}
end;
//****************************************************************************************************************************************************
procedure TiTimerThread.SetPolicyLinux(const Value: TiThreadPolicy);
begin
  {$ifdef MSWINDOWS}FPolicyLinux := Value;     {$endif}
  {$ifdef LINUX}    Policy       := ord(Value);{$endif}
end;
//****************************************************************************************************************************************************
function TiTimerThread.GetPriorityWindows: TiThreadPriority;
begin
  {$ifdef MSWINDOWS}Result := TiThreadPriority(Priority);{$endif}
  {$ifdef LINUX}    Result := FPriorityWindows;          {$endif}
end;
//****************************************************************************************************************************************************
function TiTimerThread.GetPriorityLinux: Integer;
begin
  {$ifdef MSWINDOWS}Result := FPriorityLinux;{$endif}
  {$ifdef LINUX}    Result := Priority;      {$endif}
end;
//****************************************************************************************************************************************************
function TiTimerThread.GetPolicyLinux: TiThreadPolicy;
begin
  {$ifdef MSWINDOWS}Result := FPolicyLinux;          {$endif}
  {$ifdef LINUX}    Result := TiThreadPolicy(Policy);{$endif}
end;
{$endif}
//****************************************************************************************************************************************************
//****************************************************************************************************************************************************
//****************************************************************************************************************************************************
constructor TiThreadTimers.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width   := 28;                                 
  Height  := 28;

  Visible := False;

  FTimer1 := CreateTimer(1000, nil);
  FTimer2 := CreateTimer(1000, nil);
  FTimer3 := CreateTimer(1000, nil);
  FTimer4 := CreateTimer(1000, nil);
  FTimer5 := CreateTimer(1000, nil);
  FTimer6 := CreateTimer(1000, nil);
  FTimer7 := CreateTimer(1000, nil);
  FTimer8 := CreateTimer(1000, nil);
  FTimer9 := CreateTimer(1000, nil);

  {$ifdef iCLX}
  SetThreadPolicyLinux1(itpSCHED_OTHER);
  SetThreadPolicyLinux2(itpSCHED_OTHER);
  SetThreadPolicyLinux3(itpSCHED_OTHER);
  SetThreadPolicyLinux4(itpSCHED_OTHER);
  SetThreadPolicyLinux5(itpSCHED_OTHER);
  SetThreadPolicyLinux6(itpSCHED_OTHER);
  SetThreadPolicyLinux7(itpSCHED_OTHER);
  SetThreadPolicyLinux8(itpSCHED_OTHER);
  SetThreadPolicyLinux9(itpSCHED_OTHER);
  {$endif}
end;
//****************************************************************************************************************************************************
destructor TiThreadTimers.Destroy;
begin
  if Assigned(FTimer1) then DestroyTimer(FTimer1);
  if Assigned(FTimer2) then DestroyTimer(FTimer2);
  if Assigned(FTimer3) then DestroyTimer(FTimer3);
  if Assigned(FTimer4) then DestroyTimer(FTimer4);
  if Assigned(FTimer5) then DestroyTimer(FTimer5);
  if Assigned(FTimer6) then DestroyTimer(FTimer6);
  if Assigned(FTimer7) then DestroyTimer(FTimer7);
  if Assigned(FTimer8) then DestroyTimer(FTimer8);
  if Assigned(FTimer9) then DestroyTimer(FTimer9);
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  AWidth  := 28;
  AHeight := 28;
  inherited;
end;
//****************************************************************************************************************************************************
function TiThreadTimers.CreateTimer(Interval: Integer; AOnTimer: TNotifyEvent): TiTimerThread;
begin
  Result                 := TiTimerThread.Create(True);
  Result.Owner           := Self;
  Result.OnTimer         := AOnTimer;
  Result.Interval        := Interval;
  Result.FreeOnTerminate := False;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.DestroyTimer(var ATimer: TiTimerThread);
{$ifdef MSWINDOWS}
var
  ForceTerminate : Boolean;
{$endif}
begin
  if not ATimer.Suspended then
    begin
      ATimer.Suspend;
      {$ifdef MSWINDOWS}ForceTerminate := True;{$endif}
    end
  else {$ifdef MSWINDOWS}ForceTerminate := False{$endif};

  ATimer.Terminate;
  ATimer.Resume;
  {$ifdef MSWINDOWS}if ForceTerminate then TerminateThread(ATimer.Handle, 0);{$endif}
  ATimer.Free;
  ATimer := nil;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.Paint;
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

      PolyLine([Point(21,21), Point(26, 21)]);
      PolyLine([Point(23,21), Point(23, 26)]);

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
procedure TiThreadTimers.SetEnabled1(const Value: Boolean);
begin
  if FEnabled1 <> Value then
    begin
      FEnabled1 := Value;
      if not (csDesigning in ComponentState) then FTimer1.Suspended := not Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetEnabled2(const Value: Boolean);
begin
  if FEnabled2 <> Value then
    begin
      FEnabled2 := Value;
      if not (csDesigning in ComponentState) then FTimer2.Suspended := not Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetEnabled3(const Value: Boolean);
begin
  if FEnabled3 <> Value then
    begin
      FEnabled3 := Value;
      if not (csDesigning in ComponentState) then FTimer3.Suspended := not Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetEnabled4(const Value: Boolean);
begin
  if FEnabled4 <> Value then
    begin
      FEnabled4 := Value;
      if not (csDesigning in ComponentState) then FTimer4.Suspended := not Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetEnabled5(const Value: Boolean);
begin
  if FEnabled5 <> Value then
    begin
      FEnabled5 := Value;
      if not (csDesigning in ComponentState) then FTimer5.Suspended := not Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetEnabled6(const Value: Boolean);
begin
  if FEnabled6 <> Value then
    begin
      FEnabled6 := Value;
      if not (csDesigning in ComponentState) then FTimer6.Suspended := not Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetEnabled7(const Value: Boolean);
begin
  if FEnabled7 <> Value then
    begin
      FEnabled7 := Value;
      if not (csDesigning in ComponentState) then FTimer7.Suspended := not Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetEnabled8(const Value: Boolean);
begin
  if FEnabled8 <> Value then
    begin
      FEnabled8 := Value;
      if not (csDesigning in ComponentState) then FTimer8.Suspended := not Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetEnabled9(const Value: Boolean);
begin
  if FEnabled9 <> Value then
    begin
      FEnabled9 := Value;
      if not (csDesigning in ComponentState) then FTimer9.Suspended := not Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetInterval1(const Value: Integer);
var
  OldEvent  : TNotifyEvent;
  TempValue : Integer;
begin
  if Value < 1 then TempValue := 1 else TempValue := Value;

  if FEnabled1 then
    begin
      OldEvent := FTimer1.OnTimer;

      DestroyTimer(FTimer1);

      FTimer1           := CreateTimer(TempValue, OldEvent);
      FTimer1.Suspended := False;
    end
  else FTimer1.Interval := TempValue;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetInterval2(const Value: Integer);
var
  OldEvent  : TNotifyEvent;
  TempValue : Integer;
begin
  if Value < 1 then TempValue := 1 else TempValue := Value;

  if FEnabled2 then
    begin
      OldEvent := FTimer2.OnTimer;

      DestroyTimer(FTimer2);

      FTimer2           := CreateTimer(TempValue, OldEvent);
      FTimer2.Suspended := False;
    end
  else FTimer2.Interval := TempValue;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetInterval3(const Value: Integer);
var
  OldEvent  : TNotifyEvent;
  TempValue : Integer;
begin
  if Value < 1 then TempValue := 1 else TempValue := Value;

  if FEnabled3 then
    begin
      OldEvent := FTimer3.OnTimer;

      DestroyTimer(FTimer3);

      FTimer3           := CreateTimer(TempValue, OldEvent);
      FTimer3.Suspended := False;
    end
  else FTimer3.Interval := TempValue;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetInterval4(const Value: Integer);
var
  OldEvent  : TNotifyEvent;
  TempValue : Integer;
begin
  if Value < 1 then TempValue := 1 else TempValue := Value;

  if FEnabled4 then
    begin
      OldEvent := FTimer4.OnTimer;

      DestroyTimer(FTimer4);

      FTimer4           := CreateTimer(TempValue, OldEvent);
      FTimer4.Suspended := False;
    end
  else FTimer4.Interval := TempValue;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetInterval5(const Value: Integer);
var
  OldEvent  : TNotifyEvent;
  TempValue : Integer;
begin
  if Value < 1 then TempValue := 1 else TempValue := Value;

  if FEnabled5 then
    begin
      OldEvent := FTimer5.OnTimer;

      DestroyTimer(FTimer5);

      FTimer5           := CreateTimer(TempValue, OldEvent);
      FTimer5.Suspended := False;
    end
  else FTimer5.Interval := TempValue;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetInterval6(const Value: Integer);
var
  OldEvent  : TNotifyEvent;
  TempValue : Integer;
begin
  if Value < 1 then TempValue := 1 else TempValue := Value;

  if FEnabled6 then
    begin
      OldEvent := FTimer6.OnTimer;

      DestroyTimer(FTimer6);

      FTimer6           := CreateTimer(TempValue, OldEvent);
      FTimer6.Suspended := False;
    end
  else FTimer6.Interval := TempValue;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetInterval7(const Value: Integer);
var
  OldEvent  : TNotifyEvent;
  TempValue : Integer;
begin
  if Value < 1 then TempValue := 1 else TempValue := Value;

  if FEnabled7 then
    begin
      OldEvent := FTimer7.OnTimer;

      DestroyTimer(FTimer7);

      FTimer7           := CreateTimer(TempValue, OldEvent);
      FTimer7.Suspended := False;
    end
  else FTimer7.Interval := TempValue;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetInterval8(const Value: Integer);
var
  OldEvent  : TNotifyEvent;
  TempValue : Integer;
begin
  if Value < 1 then TempValue := 1 else TempValue := Value;

  if FEnabled8 then
    begin
      OldEvent := FTimer8.OnTimer;

      DestroyTimer(FTimer8);

      FTimer8           := CreateTimer(TempValue, OldEvent);
      FTimer8.Suspended := False;
    end
  else FTimer8.Interval := TempValue;
end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetInterval9(const Value: Integer);
var
  OldEvent  : TNotifyEvent;
  TempValue : Integer;
begin
  if Value < 1 then TempValue := 1 else TempValue := Value;

  if FEnabled9 then
    begin
      OldEvent := FTimer9.OnTimer;

      DestroyTimer(FTimer9);

      FTimer9           := CreateTimer(TempValue, OldEvent);
      FTimer9.Suspended := False;
    end
  else FTimer9.Interval := TempValue;
end;
//****************************************************************************************************************************************************
function TiThreadTimers.GetInterval1: Integer;begin Result := FTimer1.Interval;end;
function TiThreadTimers.GetInterval2: Integer;begin Result := FTimer2.Interval;end;
function TiThreadTimers.GetInterval3: Integer;begin Result := FTimer3.Interval;end;
function TiThreadTimers.GetInterval4: Integer;begin Result := FTimer4.Interval;end;
function TiThreadTimers.GetInterval5: Integer;begin Result := FTimer5.Interval;end;
function TiThreadTimers.GetInterval6: Integer;begin Result := FTimer6.Interval;end;
function TiThreadTimers.GetInterval7: Integer;begin Result := FTimer7.Interval;end;
function TiThreadTimers.GetInterval8: Integer;begin Result := FTimer8.Interval;end;
function TiThreadTimers.GetInterval9: Integer;begin Result := FTimer9.Interval;end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetOnTimer1(const Value: TNotifyEvent);begin FTimer1.OnTimer := Value end;
procedure TiThreadTimers.SetOnTimer2(const Value: TNotifyEvent);begin FTimer2.OnTimer := Value end;
procedure TiThreadTimers.SetOnTimer3(const Value: TNotifyEvent);begin FTimer3.OnTimer := Value end;
procedure TiThreadTimers.SetOnTimer4(const Value: TNotifyEvent);begin FTimer4.OnTimer := Value end;
procedure TiThreadTimers.SetOnTimer5(const Value: TNotifyEvent);begin FTimer5.OnTimer := Value end;
procedure TiThreadTimers.SetOnTimer6(const Value: TNotifyEvent);begin FTimer6.OnTimer := Value end;
procedure TiThreadTimers.SetOnTimer7(const Value: TNotifyEvent);begin FTimer7.OnTimer := Value end;
procedure TiThreadTimers.SetOnTimer8(const Value: TNotifyEvent);begin FTimer8.OnTimer := Value end;
procedure TiThreadTimers.SetOnTimer9(const Value: TNotifyEvent);begin FTimer9.OnTimer := Value end;
//****************************************************************************************************************************************************
function TiThreadTimers.GetOnTimer1: TNotifyEvent;begin Result := FTimer1.OnTimer;end;
function TiThreadTimers.GetOnTimer2: TNotifyEvent;begin Result := FTimer2.OnTimer;end;
function TiThreadTimers.GetOnTimer3: TNotifyEvent;begin Result := FTimer3.OnTimer;end;
function TiThreadTimers.GetOnTimer4: TNotifyEvent;begin Result := FTimer4.OnTimer;end;
function TiThreadTimers.GetOnTimer5: TNotifyEvent;begin Result := FTimer5.OnTimer;end;
function TiThreadTimers.GetOnTimer6: TNotifyEvent;begin Result := FTimer6.OnTimer;end;
function TiThreadTimers.GetOnTimer7: TNotifyEvent;begin Result := FTimer7.OnTimer;end;
function TiThreadTimers.GetOnTimer8: TNotifyEvent;begin Result := FTimer8.OnTimer;end;
function TiThreadTimers.GetOnTimer9: TNotifyEvent;begin Result := FTimer9.OnTimer;end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiThreadTimers.SetThreadPriority1(const Value: TThreadPriority);begin FTimer1.Priority := Value;end;
procedure TiThreadTimers.SetThreadPriority2(const Value: TThreadPriority);begin FTimer2.Priority := Value;end;
procedure TiThreadTimers.SetThreadPriority3(const Value: TThreadPriority);begin FTimer3.Priority := Value;end;
procedure TiThreadTimers.SetThreadPriority4(const Value: TThreadPriority);begin FTimer4.Priority := Value;end;
procedure TiThreadTimers.SetThreadPriority5(const Value: TThreadPriority);begin FTimer5.Priority := Value;end;
procedure TiThreadTimers.SetThreadPriority6(const Value: TThreadPriority);begin FTimer6.Priority := Value;end;
procedure TiThreadTimers.SetThreadPriority7(const Value: TThreadPriority);begin FTimer7.Priority := Value;end;
procedure TiThreadTimers.SetThreadPriority8(const Value: TThreadPriority);begin FTimer8.Priority := Value;end;
procedure TiThreadTimers.SetThreadPriority9(const Value: TThreadPriority);begin FTimer9.Priority := Value;end;
//****************************************************************************************************************************************************
function TiThreadTimers.GetThreadPriority1: TThreadPriority;begin Result := FTimer1.Priority;end;
function TiThreadTimers.GetThreadPriority2: TThreadPriority;begin Result := FTimer2.Priority;end;
function TiThreadTimers.GetThreadPriority3: TThreadPriority;begin Result := FTimer3.Priority;end;
function TiThreadTimers.GetThreadPriority4: TThreadPriority;begin Result := FTimer4.Priority;end;
function TiThreadTimers.GetThreadPriority5: TThreadPriority;begin Result := FTimer5.Priority;end;
function TiThreadTimers.GetThreadPriority6: TThreadPriority;begin Result := FTimer6.Priority;end;
function TiThreadTimers.GetThreadPriority7: TThreadPriority;begin Result := FTimer7.Priority;end;
function TiThreadTimers.GetThreadPriority8: TThreadPriority;begin Result := FTimer8.Priority;end;
function TiThreadTimers.GetThreadPriority9: TThreadPriority;begin Result := FTimer9.Priority;end;
{$endif}
//****************************************************************************************************************************************************
{$ifdef iCLX}
procedure TiThreadTimers.SetThreadPriorityWindows1(const Value: TiThreadPriority);begin FTimer1.PriorityWindows := Value;end;
procedure TiThreadTimers.SetThreadPriorityWindows2(const Value: TiThreadPriority);begin FTimer2.PriorityWindows := Value;end;
procedure TiThreadTimers.SetThreadPriorityWindows3(const Value: TiThreadPriority);begin FTimer3.PriorityWindows := Value;end;
procedure TiThreadTimers.SetThreadPriorityWindows4(const Value: TiThreadPriority);begin FTimer4.PriorityWindows := Value;end;
procedure TiThreadTimers.SetThreadPriorityWindows5(const Value: TiThreadPriority);begin FTimer5.PriorityWindows := Value;end;
procedure TiThreadTimers.SetThreadPriorityWindows6(const Value: TiThreadPriority);begin FTimer6.PriorityWindows := Value;end;
procedure TiThreadTimers.SetThreadPriorityWindows7(const Value: TiThreadPriority);begin FTimer7.PriorityWindows := Value;end;
procedure TiThreadTimers.SetThreadPriorityWindows8(const Value: TiThreadPriority);begin FTimer8.PriorityWindows := Value;end;
procedure TiThreadTimers.SetThreadPriorityWindows9(const Value: TiThreadPriority);begin FTimer9.PriorityWindows := Value;end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetThreadPriorityLinux1(const Value: Integer);begin FTimer1.PriorityLinux := Value;end;
procedure TiThreadTimers.SetThreadPriorityLinux2(const Value: Integer);begin FTimer2.PriorityLinux := Value;end;
procedure TiThreadTimers.SetThreadPriorityLinux3(const Value: Integer);begin FTimer3.PriorityLinux := Value;end;
procedure TiThreadTimers.SetThreadPriorityLinux4(const Value: Integer);begin FTimer4.PriorityLinux := Value;end;
procedure TiThreadTimers.SetThreadPriorityLinux5(const Value: Integer);begin FTimer5.PriorityLinux := Value;end;
procedure TiThreadTimers.SetThreadPriorityLinux6(const Value: Integer);begin FTimer6.PriorityLinux := Value;end;
procedure TiThreadTimers.SetThreadPriorityLinux7(const Value: Integer);begin FTimer7.PriorityLinux := Value;end;
procedure TiThreadTimers.SetThreadPriorityLinux8(const Value: Integer);begin FTimer8.PriorityLinux := Value;end;
procedure TiThreadTimers.SetThreadPriorityLinux9(const Value: Integer);begin FTimer9.PriorityLinux := Value;end;
//****************************************************************************************************************************************************
function TiThreadTimers.GetThreadPriorityWindows1: TiThreadPriority;begin Result := FTimer1.PriorityWindows;end;
function TiThreadTimers.GetThreadPriorityWindows2: TiThreadPriority;begin Result := FTimer2.PriorityWindows;end;
function TiThreadTimers.GetThreadPriorityWindows3: TiThreadPriority;begin Result := FTimer3.PriorityWindows;end;
function TiThreadTimers.GetThreadPriorityWindows4: TiThreadPriority;begin Result := FTimer4.PriorityWindows;end;
function TiThreadTimers.GetThreadPriorityWindows5: TiThreadPriority;begin Result := FTimer5.PriorityWindows;end;
function TiThreadTimers.GetThreadPriorityWindows6: TiThreadPriority;begin Result := FTimer6.PriorityWindows;end;
function TiThreadTimers.GetThreadPriorityWindows7: TiThreadPriority;begin Result := FTimer7.PriorityWindows;end;
function TiThreadTimers.GetThreadPriorityWindows8: TiThreadPriority;begin Result := FTimer8.PriorityWindows;end;
function TiThreadTimers.GetThreadPriorityWindows9: TiThreadPriority;begin Result := FTimer9.PriorityWindows;end;
//****************************************************************************************************************************************************
function TiThreadTimers.GetThreadPriorityLinux1: Integer;begin Result := FTimer1.PriorityLinux;end;
function TiThreadTimers.GetThreadPriorityLinux2: Integer;begin Result := FTimer2.PriorityLinux;end;
function TiThreadTimers.GetThreadPriorityLinux3: Integer;begin Result := FTimer3.PriorityLinux;end;
function TiThreadTimers.GetThreadPriorityLinux4: Integer;begin Result := FTimer4.PriorityLinux;end;
function TiThreadTimers.GetThreadPriorityLinux5: Integer;begin Result := FTimer5.PriorityLinux;end;
function TiThreadTimers.GetThreadPriorityLinux6: Integer;begin Result := FTimer6.PriorityLinux;end;
function TiThreadTimers.GetThreadPriorityLinux7: Integer;begin Result := FTimer7.PriorityLinux;end;
function TiThreadTimers.GetThreadPriorityLinux8: Integer;begin Result := FTimer8.PriorityLinux;end;
function TiThreadTimers.GetThreadPriorityLinux9: Integer;begin Result := FTimer9.PriorityLinux;end;
//****************************************************************************************************************************************************
procedure TiThreadTimers.SetThreadPolicyLinux1(const Value: TiThreadPolicy);begin FTimer1.PolicyLinux := Value;end;
procedure TiThreadTimers.SetThreadPolicyLinux2(const Value: TiThreadPolicy);begin FTimer2.PolicyLinux := Value;end;
procedure TiThreadTimers.SetThreadPolicyLinux3(const Value: TiThreadPolicy);begin FTimer3.PolicyLinux := Value;end;
procedure TiThreadTimers.SetThreadPolicyLinux4(const Value: TiThreadPolicy);begin FTimer4.PolicyLinux := Value;end;
procedure TiThreadTimers.SetThreadPolicyLinux5(const Value: TiThreadPolicy);begin FTimer5.PolicyLinux := Value;end;
procedure TiThreadTimers.SetThreadPolicyLinux6(const Value: TiThreadPolicy);begin FTimer6.PolicyLinux := Value;end;
procedure TiThreadTimers.SetThreadPolicyLinux7(const Value: TiThreadPolicy);begin FTimer7.PolicyLinux := Value;end;
procedure TiThreadTimers.SetThreadPolicyLinux8(const Value: TiThreadPolicy);begin FTimer8.PolicyLinux := Value;end;
procedure TiThreadTimers.SetThreadPolicyLinux9(const Value: TiThreadPolicy);begin FTimer9.PolicyLinux := Value;end;
//****************************************************************************************************************************************************
function TiThreadTimers.GetThreadPolicyLinux1: TiThreadPolicy;begin Result := FTimer1.PolicyLinux;end;
function TiThreadTimers.GetThreadPolicyLinux2: TiThreadPolicy;begin Result := FTimer2.PolicyLinux;end;
function TiThreadTimers.GetThreadPolicyLinux3: TiThreadPolicy;begin Result := FTimer3.PolicyLinux;end;
function TiThreadTimers.GetThreadPolicyLinux4: TiThreadPolicy;begin Result := FTimer4.PolicyLinux;end;
function TiThreadTimers.GetThreadPolicyLinux5: TiThreadPolicy;begin Result := FTimer5.PolicyLinux;end;
function TiThreadTimers.GetThreadPolicyLinux6: TiThreadPolicy;begin Result := FTimer6.PolicyLinux;end;
function TiThreadTimers.GetThreadPolicyLinux7: TiThreadPolicy;begin Result := FTimer7.PolicyLinux;end;
function TiThreadTimers.GetThreadPolicyLinux8: TiThreadPolicy;begin Result := FTimer8.PolicyLinux;end;
function TiThreadTimers.GetThreadPolicyLinux9: TiThreadPolicy;begin Result := FTimer9.PolicyLinux;end;
{$endif}
//****************************************************************************************************************************************************
end.


