{*******************************************************}
{                                                       }
{       TiSwitchRocker3Way Component                    }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchRocker3Way;{$endif}
{$ifdef iCLX}unit QiSwitchRocker3Way;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiSwitchState = (issDown, issCenter, issUp);

  TiSwitchRocker3Way = class(TiCustomComponent)
  private
    FMouseDown          : Boolean;
    FKeyDown            : Boolean;
    FShowFocusRect      : Boolean;
    FBorderMargin       : Integer;
    FState              : TiSwitchState;
    FOnUpClick          : TNotifyEvent;
    FOnDownClick        : TNotifyEvent;
    FRepeatInitialDelay : Integer;
    FRepeatInterval     : Integer;
    FValue              : Double;
    FIncrement          : Double;
    FUseArrowKeys       : Boolean;
    FUserGenerated      : Boolean;
    FOnValueChange      : TNotifyEvent;
    FOnValueChangeUser  : TNotifyEvent;
  protected
    procedure SetShowFocusRect(const Value: Boolean);
    procedure SetBorderMargin (const Value: Integer);
    procedure SetValue        (const Value: Double);

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure iWantSpecialKey(var CharCode: Word; var Result: Longint);            override;
    procedure iKeyUp         (var CharCode: Word; Shift: TShiftState);             override;
    procedure iKeyDown       (var CharCode: Word; Shift: TShiftState);             override;

    procedure iDoKillFocus;                                                        override;
    procedure iPaintTo(Canvas: TCanvas);                                           override;
    procedure TimerEvent(Sender : TObject);
    procedure DoUpClick;
    procedure DoDownClick;
    procedure DoValueChange;
  public
    constructor Create(AOwner: TComponent);  override;
    procedure   SetValueNoEvent(const Value: Double);

    property State              : TiSwitchState read FState;
  published
    property ShowFocusRect      : Boolean       read FShowFocusRect      write SetShowFocusRect    default True;
    property BorderMargin       : Integer       read FBorderMargin       write SetBorderMargin     default 2;
    property RepeatInitialDelay : Integer       read FRepeatInitialDelay write FRepeatInitialDelay default 500;
    property RepeatInterval     : Integer       read FRepeatInterval     write FRepeatInterval     default 50;
    property Value              : Double        read FValue              write SetValue;
    property Increment          : Double        read FIncrement          write FIncrement;
    property UseArrowKeys       : Boolean       read FUseArrowKeys       write FUseArrowKeys       default True;
    property OnValueChange      : TNotifyEvent  read FOnValueChange      write FOnValueChange;
    property OnValueChangeUser  : TNotifyEvent  read FOnValueChangeUser  write FOnValueChangeUser;
    property OnUpClick          : TNotifyEvent  read FOnUpClick          write FOnUpClick;
    property OnDownClick        : TNotifyEvent  read FOnDownClick        write FOnDownClick;
    property TabOrder;
    property TabStop          default True;
    property BackGroundColor;
    property Transparent;
    property Color;
    property Width            default 25;
    property Height           default 50;
  end;

implementation
//*************************************************************************************************************************************
constructor TiSwitchRocker3Way.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width   := 25;
  Height  := 50;
  TabStop := True;

  FState              := issCenter;
  FRepeatInitialDelay := 500;
  FRepeatInterval     := 50;
  FShowFocusRect      := True;
  FBorderMargin       := 2;
  FIncrement          := 1;
  FUseArrowKeys       := True;

  OnInternalTimer     := TimerEvent;
end;
//*************************************************************************************************************************************
procedure TiSwitchRocker3Way.SetShowFocusRect(const Value:Boolean);begin SetBooleanProperty(Value,FShowFocusRect,irtInvalidate);end;
procedure TiSwitchRocker3Way.SetBorderMargin (const Value:Integer);begin SetIntegerProperty(Value,FBorderMargin, irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiSwitchRocker3Way.SetValueNoEvent(const Value: Double);
var
  TempOnValueChange : TNotifyEvent;
begin
  TempOnValueChange := FOnValueChange;
  FOnValueChange    := nil;
  try
    SetValue(Value);
  finally
    FOnValueChange := TempOnValueChange;
  end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchRocker3Way.SetValue(const Value: Double);
var
  CanEdit : Boolean;
begin
  if FValue <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Value', CanEdit);
      if CanEdit then
        begin
          FValue := Value;
          InvalidateChange;
          DoValueChange;
          {$ifdef iVCL}OPCOutputData('Value', FValue);{$endif}
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRocker3Way.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      InvalidateChange;
      SetFocus;
      if Y > (Height div 2) then FState := issDown else FState := issUp;
      FMouseDown := True;
      FKeyDown   := False;
      TimerStart(FRepeatInitialDelay, FRepeatInterval);
      case FState of
        issUp   : DoUpClick;
        issDown : DoDownClick;
      end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRocker3Way.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      FMouseDown := False;
      FState     := issCenter;
      InvalidateChange;
    end;

  TimerStop;
end;
//*************************************************************************************************************************************
procedure TiSwitchRocker3Way.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if FUseArrowKeys then
    begin
      //KYLIX TODO
      {$ifndef iCLX}
      if      CharCode = VK_UP   then FState := issUp
      else if CharCode = VK_DOWN then FState := issDown
      else                                    FState := issCenter;
      {$endif}
    end;

  if FState <> issCenter then
    begin
      FKeyDown         := True;
      FMouseDown       := False;
      CharCode := 0;
      TimerStart(FRepeatInitialDelay, FRepeatInterval);
      InvalidateChange;
      case FState of
        issDown : DoDownClick;
        issUp   : DoUpClick;
      end;
    end
  else
    begin
      FKeyDown   := False;
      FMouseDown := False;
      TimerStop;
      InvalidateChange;
    end;

end;
//*************************************************************************************************************************************
procedure TiSwitchRocker3Way.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  if FKeyDown then
    begin
      InvalidateChange;
      FKeyDown   := False;
      FMouseDown := False;
      FState     := issCenter;
    end;
  TimerStop;
end;
//****************************************************************************************************************************************************
procedure TiSwitchRocker3Way.iWantSpecialKey(var CharCode: Word; var Result: Longint);
begin
  Result := 0;
  if FUseArrowKeys then if CharCode in [VK_DOWN, VK_UP] then Result := 1;
end;
//*************************************************************************************************************************************
procedure TiSwitchRocker3Way.iPaintTo(Canvas: TCanvas);
var
  DrawRect     : TRect;
  ShadowHeight : Integer;
  TotalMargin  : Integer;
  AColor       : TColor;
begin
  with Canvas, DrawRect do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      DrawRect := Rect(0, 0 ,Width, Height);
      InflateRect(DrawRect, -2, -2);
      Brush.Color := clBlack;
      FillRect(DrawRect);

      ShadowHeight := 3;
      TotalMargin  := BorderMargin + 2;

      AColor       := Color;

      case FState of
        issUp     : begin
                      Brush.Color := AColor;
                      DrawRect    := Rect(TotalMargin, TotalMargin ,Width - TotalMargin, Round(Height * 0.50) );
                      FillRect(DrawRect);

                      Brush.Color := ColorGradientBright(AColor);
                      DrawRect    := Rect(TotalMargin, Round(Height * 0.50) ,Width - TotalMargin, Height - TotalMargin - ShadowHeight*2);
                      FillRect(DrawRect);

                      Brush.Color := ColorGradientDim(AColor);
                      DrawRect    := Rect(TotalMargin, Height - TotalMargin - ShadowHeight*2 ,Width - TotalMargin, Height - TotalMargin);
                      FillRect(DrawRect);
                    end;
        issCenter : begin
                      Brush.Color := AColor;
                      DrawRect    := Rect(TotalMargin, TotalMargin ,Width - TotalMargin, TotalMargin + ShadowHeight);
                      FillRect(DrawRect);

                      Brush.Color := ColorGradientDim(AColor);
                      DrawRect    := Rect(TotalMargin, TotalMargin + ShadowHeight ,Width - TotalMargin, Round(Height * 0.50) );
                      FillRect(DrawRect);

                      Brush.Color := ColorGradientBright(AColor);
                      DrawRect    := Rect(TotalMargin, Round(Height * 0.50) ,Width - TotalMargin, Height - TotalMargin - ShadowHeight);
                      FillRect(DrawRect);

                      Brush.Color := AColor;
                      DrawRect    := Rect(TotalMargin, Height - TotalMargin - ShadowHeight ,Width - TotalMargin, Height - TotalMargin);
                      FillRect(DrawRect);
                    end;
        issDown   : begin
                      Brush.Color := ColorGradientBright(AColor);
                      DrawRect    := Rect(TotalMargin, TotalMargin ,Width - TotalMargin, TotalMargin + ShadowHeight*2);
                      FillRect(DrawRect);

                      Brush.Color := ColorGradientDim(AColor);

                      DrawRect    := Rect(TotalMargin, TotalMargin + ShadowHeight*2 ,Width - TotalMargin, Round(Height * 0.50) );
                      FillRect(DrawRect);

                      Brush.Color := AColor;
                      DrawRect    := Rect(TotalMargin, Round(Height * 0.50) ,Width - TotalMargin, Height - TotalMargin);
                      FillRect(DrawRect);
                    end;
        end;

      if ShowFocusRect and HasFocus then iDrawFocusRect(Canvas, ClientRect, BackGroundColor);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchRocker3Way.TimerEvent(Sender: TObject);
begin
  case FState of
    issUp   : DoUpClick;
    issDown : DoDownClick;
  end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchRocker3Way.DoUpClick;
begin
  FUserGenerated := True;
  try
    Value := Value + FIncrement;
  finally
    FUserGenerated := False;
  end;
  if Assigned(FOnUpClick) then FOnUpClick(Self);
end;
//****************************************************************************************************************************************************
procedure TiSwitchRocker3Way.DoDownClick;
begin
  FUserGenerated := True;
  try
    Value := Value - FIncrement;
  finally
    FUserGenerated := False;
  end;
  if Assigned(FOnDownClick) then FOnDownClick(Self);
end;
//****************************************************************************************************************************************************
procedure TiSwitchRocker3Way.iDoKillFocus;
begin
  FMouseDown := False;
  FKeyDown   := False;
  FState     := issCenter;
  TimerStop;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiSwitchRocker3Way.DoValueChange;
begin
  if not Loading then
    begin
      if                        Assigned(OnChangeProtected)  then OnChangeProtected(Self, 'Value');
      if                        Assigned(FOnValueChange)     then FOnValueChange(Self);
      if FUserGenerated then if Assigned(FOnValueChangeUser) then FOnValueChangeUser(Self);
    end;
end;
//****************************************************************************************************************************************************
end.


