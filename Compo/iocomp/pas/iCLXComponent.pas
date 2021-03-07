{*******************************************************}
{                                                       }
{       TiCLXComponent                                  }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$IFDEF iCLX} unit QiCLXComponent;{$ENDIF}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes, iGPFunctions,   iComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiComponent;{$ENDIF}

type
  TiCLXComponent = class(TiComponent)
  private
    FOnInternalTimer   : TNotifyEvent;
    FTransparent       : Boolean;
    FTimerHandle       : QTimerH;
    FTimerHook         : QTimer_hookH;
    FTimerFirstMessage : Boolean;
    FTimerInterval     : Integer;
  protected
    procedure SetTransparent(const Value: Boolean);        virtual;
    procedure PaletteChanged(Sender: TObject);             override;

    procedure DoEnter;                                     override;
    procedure DoExit;                                      override;

    procedure Resize;                                      override;

    procedure TimerCallBack; cdecl;


    function  GetTimerRunning : Boolean;                   override;
    procedure TimerStart(InitialDelay, Interval: Integer); override;
    procedure TimerStop;                                   override;

    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; const MousePos: TPoint): Boolean; override;

    property  OnInternalTimer : TNotifyEvent read FOnInternalTimer write FOnInternalTimer;

    property  Transparent     : Boolean      read FTransparent     write SetTransparent        default False;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    procedure   Lock;                       override;
    procedure   Unlock;                     override;

    procedure SaveImageToJPEG(FileName: String; Compression: Integer; Progressive: Boolean);
    procedure SaveImageToPNG (FileName: String; Compression: Integer);
  published
  end;

implementation

type
  TWinControlAccess = class(TWinControl) end;
//****************************************************************************************************************************************************
constructor TiCLXComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  QWidget_SetBackgroundMode(Handle, QWidgetBackgroundMode_NoBackground);
end;
//****************************************************************************************************************************************************
destructor TiCLXComponent.Destroy;
begin
  if Assigned(FTimerHook)   then QTimer_hook_destroy(FTimerHook);
  if Assigned(FTimerHandle) then QTimer_destroy(FTimerHandle);
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.Lock;
begin

end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.Unlock;
begin

end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.PaletteChanged(Sender: TObject);
begin
  inherited PaletteChanged(Sender);
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.DoEnter;
begin
  UserGenerated := True;
  try
    iDoSetFocus;
    inherited;
  finally
    UserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.DoExit;
begin
  UserGenerated := True;
  try
    iDoKillFocus;
    inherited;
  finally
    UserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.SetTransparent(const Value: Boolean);
begin
  FTransparent := Value;
end;
//****************************************************************************************************************************************************
function TiCLXComponent.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; const MousePos: TPoint): Boolean;
begin
  Result := iMouseWheel(WheelDelta, Shift, MousePos);
end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.Resize;
begin
  inherited;
  if Assigned(BackGroundBitmap) then
    begin
      BackGroundBitmap.Width  := Width;
      BackGroundBitmap.Height := Height;
    end;
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.TimerStart(InitialDelay, Interval: Integer);
var
  Timeout : TMethod;
begin
  if (csDesigning in ComponentState) then Exit;

  FTimerInterval     := Interval;
  FTimerFirstMessage := True;

  if not Assigned(FTimerHandle) then
    begin
      FTimerHandle := QTimer_create(nil, nil);
      FTimerHook := QTimer_hook_create(FTimerHandle);
      QTimer_timeout_Event(Timeout) := TimerCallBack;
      QTimer_hook_hook_timeout(FTimerHook, Timeout);
    end;
  QTimer_start(FTimerHandle, InitialDelay, False);
end;
//****************************************************************************************************************************************************
function TiCLXComponent.GetTimerRunning: Boolean;
begin
  Result := False;
  if Assigned(FtimerHandle) then Result := QTimer_isActive(FTimerHandle);
end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.TimerStop;
begin
  if Assigned(FTimerHandle) then QTimer_stop(FTimerHandle);
end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.TimerCallBack;
begin
  try
    if FTimerFirstMessage then
      begin
        FTimerFirstMessage := False;
        QTimer_changeInterval(FTimerHandle, FTimerInterval);
      end;
    if Assigned(FOnInternalTimer) then FOnInternalTimer(Self);
  except
    Application.HandleException(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.SaveImageToJPEG(FileName: String; Compression: Integer; Progressive: Boolean);
var
  Bitmap      : TBitmap;
  AWideString : WideString;
begin
  if (Compression < 1) or (Compression > 100) then raise Exception.Create('Compression must be in the range of 1-100');
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width  := Width;
    Bitmap.Height := Height;
    iPaintTo(Bitmap.Canvas);

    {$IFDEF EVAL}
    with Bitmap.Canvas do
      begin
        Brush.Color := clBlack;
        Font.Color  := clYellow;
        Font.Style  := [fsBold];
        TextOut(0,0, 'Iocomp Evaluation');
      end;
    {$ENDIF}

    AWideString := FileName;
    QPixMap_save(Bitmap.Handle,@AWideString,PChar('JPEG'), Compression);
  finally
    Bitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiCLXComponent.SaveImageToPNG(FileName: String; Compression: Integer);
var
  Bitmap      : TBitmap;
  AWideString : WideString;
begin
  if (Compression < 0) or (Compression > 9) then raise Exception.Create('Compression must be in the range of 0-9');
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width  := Width;
    Bitmap.Height := Height;
    iPaintTo(Bitmap.Canvas);

    {$IFDEF EVAL}
    with Bitmap.Canvas do
      begin
        Brush.Color := clBlack;
        Font.Color  := clYellow;
        Font.Style  := [fsBold];
        TextOut(0,0, 'Iocomp Evaluation');
      end;
    {$ENDIF}

    AWideString := FileName;
    QPixMap_save(Bitmap.Handle,@AWideString,PChar('PNG'), Compression);
  finally
    Bitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
end.





