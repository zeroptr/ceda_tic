{*******************************************************}
{                                                       }
{       TiSwitchToggle Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchToggle;{$endif}
{$ifdef iCLX}unit QiSwitchToggle;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiSwitchToggle = class(TiCustomComponent)
  private
    FMouseDown         : Boolean;
    FMouseDownX        : Integer;
    FMouseDownY        : Integer;
    FActive            : Boolean;
    FDragToToggle      : Boolean;
    FMouseControlStyle : TiMouseControlStyle;
    FShowFocusRect     : Boolean;
    FSwitchHeight      : Integer;
    FSwitchBevelStyle  : TiBevelStyle;
    FSwitchOrientation : TiOrientation;
    FSpaceKeyDown      : Boolean;
    FOnChange          : TNotifyEvent;
    FUserGenerated     : Boolean;
    FOnChangeUser      : TNotifyEvent;

    procedure SetActive           (const Value: Boolean);
    procedure SetDragToToggle     (const Value: Boolean);
    procedure SetSwitchHeight     (const Value: Integer);
    procedure SetSwitchBevelStyle (const Value: TiBevelStyle);
    procedure SetSwitchOrientation(const Value: TiOrientation);
    procedure SetShowFocusRect    (const Value: Boolean);
    function GetIndicatorRect : TRect;
  protected
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    procedure iKeyUp  (var CharCode: Word; Shift: TShiftState);                    override;
    procedure iKeyDown(var CharCode: Word; Shift: TShiftState);                    override;

    procedure iDoKillFocus;                                                        override;
    procedure iPaintTo(Canvas: TCanvas);                                           override;
    property  SwitchRect : TRect read GetIndicatorRect;
    procedure DoChange;
  public
    constructor Create(AOwner: TComponent);                                        override;
    procedure   SetActiveNoEvent(const Value: Boolean);
  published
    property Active            : Boolean             read FActive            write SetActive            default False;
    property DragToToggle      : Boolean             read FDragToToggle      write SetDragToToggle      default False;
    property MouseControlStyle : TiMouseControlStyle read FMouseControlStyle write FMouseControlStyle   default imcsClickAnyWhere;
    property ShowFocusRect     : Boolean             read FShowFocusRect     write SetShowFocusRect     default True;
    property SwitchBevelStyle  : TiBevelStyle        read FSwitchBevelStyle  write SetSwitchBevelStyle  default ibsRaised;
    property SwitchHeight      : Integer             read FSwitchHeight      write SetSwitchHeight      default 22;
    property SwitchOrientation : TiOrientation       read FSwitchOrientation write SetSwitchOrientation default ioVertical;
    property OnChange          : TNotifyEvent        read FOnChange          write FOnChange;
    property OnChangeUser      : TNotifyEvent        read FOnChangeUser      write FOnChangeUser;
    property TabOrder;
    property Color;
    property BackGroundColor;
    property TabStop          default True;
    property Width            default 25;
    property Height           default 50;
  end;

implementation
//*************************************************************************************************************************************
constructor TiSwitchToggle.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width   := 25;
  Height  := 50;
  TabStop := True;

  FSwitchHeight     := 22;
  FSwitchBevelStyle := ibsRaised;
  FShowFocusRect    := True;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.DoChange;
begin
  if not Loading then
    begin
      if                        Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Active');
      if                        Assigned(FOnChange)         then FOnChange        (Self);
      if FUserGenerated then if Assigned(FOnChangeUser)     then FOnChangeUser    (Self);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.SetDragToToggle (const Value: Boolean);begin SetBooleanProperty(Value,FDragToToggle, irtInvalidate);end;
procedure TiSwitchToggle.SetShowFocusRect(const Value: Boolean);begin SetBooleanProperty(Value,FShowFocusRect,irtInvalidate);end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.SetActiveNoEvent(const Value: Boolean);
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange := FOnChange;
  FOnChange    := nil;
  try
    SetActive(Value);
  finally
    FOnChange := TempOnChange;
  end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.SetActive(const Value: Boolean);
var
  CanEdit     : Boolean;
  TempBoolean : Boolean;
begin
  if ord(Value) = 0 then TempBoolean := False else TempBoolean := True;
  if FActive <> TempBoolean then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Active', CanEdit);
      if CanEdit then
        begin
          FActive := TempBoolean;
          InvalidateChange;
          DoChange;
          {$ifdef iVCL}OPCOutputData('Active', FActive);{$endif}
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.SetSwitchBevelStyle(const Value: TiBevelStyle);
begin
  if FSwitchBevelStyle <> Value then
    begin
      FSwitchBevelStyle := Value;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.SetSwitchOrientation(const Value: TiOrientation);
var
  TempWidth : Integer;
begin
  if FSwitchOrientation <> Value then
    begin
      if not Loading then
        begin
          TempWidth := Width;
          Width     := Height;
          Height    := TempWidth;
        end;
      FSwitchOrientation := Value;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.SetSwitchHeight(const Value: Integer);
begin
  if FSwitchHeight <> Value then
    begin
      FSwitchHeight := Value;
      if FSwitchHeight < 3 then FSwitchHeight := 3;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  OkToStart : Boolean;
begin
  OkToStart := False;
  if Button = mbLeft then
    begin
      SetFocus;
      case FMouseControlStyle of
        imcsClickAnyWhere  : OkToStart := True;
        imcsClickIndicator : if PtInRect(SwitchRect, Point(X,Y)) then OkToStart := True;
      end;
    end;

  if OkToStart then
    begin
      FMouseDown  := True;
      FMouseDownX := X;
      FMouseDownY := Y;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.iMouseMove(Shift: TShiftState; X, Y: Integer);
var
  DragComplete : Boolean;
begin
  if DragToToggle and FMouseDown then
    begin
      FUserGenerated := True;
      try
        DragComplete := False;
        if FActive then
          begin
            case FSwitchOrientation of
              ioVertical   : if (Y - FMouseDownY) > (Height - 4 - FSwitchHeight) then DragComplete := True;
              ioHorizontal : if (FMouseDownX - X) > (Width  - 4 - FSwitchHeight) then DragComplete := True;
            end;
          end
        else
          begin
            case FSwitchOrientation of
              ioVertical   : if (FMouseDownY - Y) > (Height - 4 - FSwitchHeight) then DragComplete := True;
              ioHorizontal : if (X - FMouseDownX) > (Width  - 4 - FSwitchHeight) then DragComplete := True;
            end;
          end;

        if DragComplete then
          begin
            Active := not Active;
            FMouseDownX := X;
            FMouseDownY := Y;
          end;
      finally
        FUserGenerated := False;
      end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      InvalidateChange;
      FMouseDown     := False;
      FSpaceKeyDown  := False;
      FUserGenerated := True;
      try
        if not DragToToggle then if PtInRect(Rect(0, 0 ,Width, Height), Point(X,Y)) then Active := not Active;
      finally
        FUserGenerated := False;
      end;
    end;
end;
//*************************************************************************************************************************************
function TiSwitchToggle.GetIndicatorRect : TRect;
var
  DrawRect : TRect;
begin
  DrawRect := Rect(0,0,Width-1, Height-1);

  with DrawRect do
    begin
      case FSwitchOrientation of
        ioVertical   : if FActive then Result := Rect(Left+4, Top+3,                      Right-4, Top+3 + FSwitchHeight)
                         else          Result := Rect(Left+4, Bottom - 3 - FSwitchHeight, Right-4, Bottom - 3           );

        ioHorizontal : if FActive then Result := Rect(Right - 3 - FSwitchHeight, Top + 4, Right - 3,                Bottom - 4)
                         else          Result := Rect(Left + 3,                  Top + 4, Left + 3 + FSwitchHeight, Bottom - 4);
      end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.iPaintTo(Canvas: TCanvas);
var
  DrawRect   : TRect;
  BevelCount : Integer;
  x          : Integer;
  AColor     : TColor;
begin
  with Canvas, DrawRect do
    begin
      DrawRect := Rect(0,0,Width-1, Height-1);

      DrawBackGround  (Canvas, BackGroundColor);
      DrawSunkenBorder(Canvas, DrawRect);
      DrawRaisedBorder(Canvas, SwitchRect);

      if FMouseDown or FSpaceKeyDown then AColor := ColorMouseDownBright2(Color)
      else                                AColor := Color;

      with SwitchRect do
        begin
          Brush.Color := AColor;
          Pen.Color   := AColor;
          Rectangle(Left+2, Top+2, Right-1, Bottom-1);

          case FSwitchOrientation of
            ioVertical   : case FSwitchBevelStyle of
                             ibsRaised :  begin
                                            BevelCount := (Bottom - Top - 4) div 3;
                                            for x := 0 to BevelCount -1 do
                                              LineBevel(Canvas, Left + 2, Top + x*3 + 3, Right - 2, Top + x*3 + 3, ibsRaised);
                                          end;
                             ibsLowered : begin
                                            BevelCount := (Bottom - Top - 4) div 3;
                                            for x := 0 to BevelCount -1 do
                                              LineBevel(Canvas, Left + 2, Top + x*3 + 3, Right - 2, Top + x*3 + 3, ibsLowered);
                                          end;
                           end;
            ioHorizontal : case FSwitchBevelStyle of
                             ibsRaised :  begin
                                            BevelCount := (Right - Left - 4) div 3;
                                            for x := 0 to BevelCount -1 do
                                              LineBevel(Canvas, Left + x*3+ 3, Top + 2, Left + x*3+ 3, Bottom - 2, ibsRaised);
                                          end;
                             ibsLowered : begin
                                            BevelCount := (Right - Left - 4) div 3;
                                            for x := 0 to BevelCount -1 do
                                              LineBevel(Canvas, Left + x*3+ 3, Top + 2, Left + x*3+ 3, Bottom - 2, ibsLowered);
                                          end;
                           end;
          end;
        end;
    end;

  if ShowFocusRect and HasFocus then
    begin
      Canvas.Pen.Color   := clBtnFace;
      Canvas.Brush.Color := clBtnFace;
      DrawRect := Rect(DrawRect.Left + 3, DrawRect.Top + 3, DrawRect.Right - 2, DrawRect.Bottom - 2);
      iDrawFocusRect(Canvas, DrawRect, BackGroundColor);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    begin
      FSpaceKeyDown := True;
      FMouseDown    := False;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    if FSpaceKeyDown then
      begin
        InvalidateChange;
        FSpaceKeyDown  := False;
        FMouseDown     := False;
        FUserGenerated := True;
        try
          Active := not Active;
        finally
          FUserGenerated := False;
        end;
      end;
end;
//*************************************************************************************************************************************
procedure TiSwitchToggle.iDoKillFocus;
begin
  FMouseDown    := False;
  FSpaceKeyDown := False;
  inherited;
end;
//*************************************************************************************************************************************
end.


