{*******************************************************}
{                                                       }
{       TiSwitchLed Component                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchLed;{$endif}
{$ifdef iCLX}unit QiSwitchLed;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiSwitchLedCaptionAlignment = (islcaIndicator, islcaOppisiteSide);

  TiSwitchLed = class(TiCustomComponent)
  private
    FMouseDown            : Boolean;
    FKeyDown              : Boolean;
    FActive               : Boolean;
    FActiveColor          : TColor;
    FAutoLedSize          : Boolean;
    FCaption              : String;
    FCaptionFont          : TFont;
    FCaptionMargin        : Integer;
    FIndicatorHeight      : Integer;
    FIndicatorAlignment   : TiSideAlignment;
    FIndicatorMargin      : Integer;
    FIndicatorWidth       : Integer;
    FShowFocusRect        : Boolean;
    FOnChange             : TNotifyEvent;
    FCaptionAlignment     : TiSwitchLedCaptionAlignment;
    FUserGenerated        : Boolean;
    FWordWrap             : Boolean;
    FOnChangeUser         : TNotifyEvent;
    FBorderSize           : Integer;
    FGlyph                : TBitmap;
    FBorderShadowColor    : TColor;
    FBorderHighlightColor : TColor;
    FMomentaryStyle       : TiSwitchMomentaryStyle;

    procedure SetActive              (const Value: Boolean);
    procedure SetActiveColor         (const Value: TColor);
    procedure SetAutoLedSize         (const Value: Boolean);
    procedure SetCaption             (const Value: String);
    procedure SetCaptionFont         (const Value: TFont);
    procedure SetCaptionMargin       (const Value: Integer);
    procedure SetIndicatorAlignment  (const Value: TiSideAlignment);
    procedure SetMomentaryStyle      (const Value: TiSwitchMomentaryStyle);
    procedure SetIndicatorHeight     (const Value: Integer);
    procedure SetIndicatorMargin     (const Value: Integer);
    procedure SetIndicatorWidth      (const Value: Integer);
    procedure SetShowFocusRect       (const Value: Boolean);
    procedure SetCaptionAlignment    (const Value: TiSwitchLedCaptionAlignment);
    procedure SetWordWrap            (const Value: Boolean);
    procedure SetBorderSize          (const Value: Integer);
    procedure SetGlyph               (const Value: TBitmap);
    procedure SetBorderHighlightColor(const Value: TColor);
    procedure SetBorderShadowColor   (const Value: TColor);
  protected
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure iKeyUp  (var CharCode: Word; Shift: TShiftState);                    override;
    procedure iKeyDown(var CharCode: Word; Shift: TShiftState);                    override;

    procedure iDoKillFocus;                                                        override;

    procedure iPaintTo           (Canvas: TCanvas);                                override;
    procedure DrawBorder         (Canvas: TCanvas);                                reintroduce;
    procedure DrawEdgeTopLeft    (Canvas: TCanvas; Offset: Integer; AColor: TColor);
    procedure DrawEdgeBottomRight(Canvas: TCanvas; Offset: Integer; AColor: TColor);
    //Kylix TODO
    {$ifndef iCLX}
    procedure CMEnabledChanged(var Message: TMessage);      message CM_ENABLEDCHANGED;
    procedure CMDialogChar    (var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure WMSysChar       (var Message: TWMSysChar);    message WM_SYSCHAR;
    {$endif}
    procedure DefineProperties(Filer: TFiler); override;
    procedure WriteCaption    (Writer: TWriter);
    procedure ReadCaption     (Reader: TReader);
    procedure DoChange;
    {$IFDEF iVCL}
    procedure UpdateOPCSpecialList;            override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;
    procedure   SetActiveNoEvent(const Value: Boolean);
  published
    property Active               : Boolean                     read FActive               write SetActive             default False;
    property ActiveColor          : TColor                      read FActiveColor          write SetActiveColor        default clLime;
    property AutoLedSize          : Boolean                     read FAutoLedSize          write SetAutoLedSize        default True;
    property Caption              : String                      read FCaption              write SetCaption;
    property CaptionFont          : TFont                       read FCaptionFont          write SetCaptionFont;
    property CaptionMargin        : Integer                     read FCaptionMargin        write SetCaptionMargin;
    property CaptionAlignment     : TiSwitchLedCaptionAlignment read FCaptionAlignment     write SetCaptionAlignment   default islcaIndicator;
    property IndicatorAlignment   : TiSideAlignment             read FIndicatorAlignment   write SetIndicatorAlignment default isaBottom;
    property MomentaryStyle       : TiSwitchMomentaryStyle      read FMomentaryStyle       write SetMomentaryStyle     default ismsNone;
    property IndicatorHeight      : Integer                     read FIndicatorHeight      write SetIndicatorHeight    default 4;
    property IndicatorMargin      : Integer                     read FIndicatorMargin      write SetIndicatorMargin    default 5;
    property IndicatorWidth       : Integer                     read FIndicatorWidth       write SetIndicatorWidth     default 10;
    property ShowFocusRect        : Boolean                     read FShowFocusRect        write SetShowFocusRect      default True;
    property WordWrap             : Boolean                     read FWordWrap             write SetWordWrap           default False;
    property BorderSize           : Integer                     read FBorderSize           write SetBorderSize;
    property BorderHighlightColor : TColor                      read FBorderHighlightColor write SetBorderHighlightColor;
    property BorderShadowColor    : TColor                      read FBorderShadowColor    write SetBorderShadowColor;
    property OnChange             : TNotifyEvent                read FOnChange             write FOnChange;
    property OnChangeUser         : TNotifyEvent                read FOnChangeUser         write FOnChangeUser;

    property Glyph                : TBitmap                     read FGlyph                write SetGlyph;
    property Enabled;
    property TabOrder;
    property TabStop          default True;
    property Width            default 40;
    property Height           default 28;
    property BackGroundColor  default clBtnFace;
  end;

implementation
//*************************************************************************************************************************************
constructor TiSwitchLed.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width           := 40;
  Height          := 28;
  TabStop         := True;
  BackGroundColor := clBtnFace;

  FBorderHighlightColor := clBtnHighlight;
  FBorderShadowColor    := clBtnShadow;

  FActiveColor     := clLime;
  FAutoLedSize     := True;
  FCaptionMargin   := 2;
  FIndicatorHeight := 4;
  FIndicatorMargin := 5;
  FIndicatorWidth  := 10;
  FShowFocusRect   := True;
  FBorderSize      := 2;

  FCaptionFont := TFont.Create; FCaptionFont.OnChange := BackGroundChangeEvent;

  FGlyph                 := TBitmap.Create;
  FGlyph.Transparent     := True;
  FGlyph.TransparentMode := tmAuto;
  FGlyph.OnChange        := InvalidateChangeEvent;

  FCaption := 'On';               
end;
//*************************************************************************************************************************************
destructor TiSwitchLed.Destroy;
begin
  OnMouseUp := nil;
  FCaptionFont.Free;
  FGlyph.Free;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.DoChange;
begin
  if not Loading then
    begin
      if                        Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Active');
      if                        Assigned(FOnChange)         then FOnChange        (Self);
      if FUserGenerated then if Assigned(FOnChangeUser)     then FOnChangeUser    (Self);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.SetActiveColor         (const Value:TColor); begin SetColorProperty  (Value,FActiveColor,         irtInvalidate);end;
procedure TiSwitchLed.SetCaptionMargin       (const Value:Integer);begin SetIntegerProperty(Value,FCaptionMargin,       irtInvalidate);end;
procedure TiSwitchLed.SetIndicatorHeight     (const Value:Integer);begin SetIntegerProperty(Value,FIndicatorHeight,     irtInvalidate);end;
procedure TiSwitchLed.SetIndicatorMargin     (const Value:Integer);begin SetIntegerProperty(Value,FIndicatorMargin,     irtInvalidate);end;
procedure TiSwitchLed.SetIndicatorWidth      (const Value:Integer);begin SetIntegerProperty(Value,FIndicatorWidth,      irtInvalidate);end;
procedure TiSwitchLed.SetShowFocusRect       (const Value:Boolean);begin SetBooleanProperty(Value,FShowFocusRect,       irtInvalidate);end;
procedure TiSwitchLed.SetAutoLedSize         (const Value:Boolean);begin SetBooleanProperty(Value,FAutoLedSize,         irtInvalidate);end;
procedure TiSwitchLed.SetWordWrap            (const Value:Boolean);begin SetBooleanProperty(Value,FWordWrap,            irtInvalidate);end;
procedure TiSwitchLed.SetBorderHighlightColor(const Value:TColor );begin SetColorProperty  (Value,FBorderHighlightColor,irtInvalidate);end;
procedure TiSwitchLed.SetBorderShadowColor   (const Value:TColor );begin SetColorProperty  (Value,FBorderShadowColor,   irtInvalidate);end;
//*************************************************************************************************************************************
procedure TiSwitchLed.SetBorderSize(const Value: Integer);
var
  TempValue : Integer;
begin
  TempValue := Value;
  if TempValue <  2 then TempValue := 2;
  if FBorderSize <> TempValue then
    begin
      FBorderSize := TempValue;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.SetCaptionFont(const Value:TFont);begin FCaptionFont.Assign(Value);end;
//*************************************************************************************************************************************
procedure TiSwitchLed.SetActiveNoEvent(const Value: Boolean);
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
procedure TiSwitchLed.SetActive(const Value: Boolean);
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
procedure TiSwitchLed.SetCaption(const Value: String);
begin
  if FCaption <> Value then
    begin
      FCaption := Value;
      //Kylix TODO
      //Is this necessary?
      {$ifndef iCLX}
      Perform(WM_SETTEXT, 0, Longint(PChar(Value)));
      {$endif}
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.SetIndicatorAlignment(const Value: TiSideAlignment);
begin
  if FIndicatorAlignment <> Value then
    begin
      FIndicatorAlignment := Value;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.SetMomentaryStyle(const Value: TiSwitchMomentaryStyle);
begin
  if FMomentaryStyle <> Value then
    begin
      FMomentaryStyle := Value;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.SetCaptionAlignment(const Value: TiSwitchLedCaptionAlignment);
begin
  if FCaptionAlignment <> Value then
    begin
      FCaptionAlignment := Value;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      SetFocus;
      FMouseDown := True;
      InvalidateChange;

      FUserGenerated := True;
      try
        if MomentaryStyle = ismsSimple then Active := True;
      finally
        FUserGenerated := False;
      end;

      {$ifdef iVCL}OPCOutputData('{MouseDown}', True);{$endif}
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      {$ifdef iVCL}OPCOutputData('{MouseDown}', False);{$endif}
      InvalidateChange;
      FMouseDown     := False;

      FUserGenerated := True;
      try
        if MomentaryStyle = ismsNone then
          begin
            if PtInRect(Rect(0, 0 ,Width, Height), Point(X,Y)) then Active := not FActive;
          end
        else if MomentaryStyle = ismsSimple then
          begin
            Active := False;
          end;
      finally
        FUserGenerated := False;
      end;
      
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    begin
      FMouseDown := False;
      FKeyDown   := True;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    if FKeyDown then
      begin
        InvalidateChange;
        FMouseDown     := False;
        FKeyDown       := False;
        FUserGenerated := True;
        try
          Active := not Active;
        finally
          FUserGenerated := False;
        end;
      end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.iPaintTo(Canvas: TCanvas);
var
  DrawRect         : TRect;
  DrawWidth        : Integer;
  DrawHeight       : Integer;
  LedRect          : TRect;
  TempWidth        : Integer;
  TempHeight       : Integer;
  CenterPoint      : TPoint;
  ATextRect        : TRect;
  ATextFlags       : TiTextFlags;
begin
  CenterPoint := GetCenterPoint(Canvas);
  LedRect     := Rect(0,0,0,0);
  with Canvas, DrawRect do
    begin
      DrawBackGround(Canvas, BackGroundColor);
      DrawBorder(Canvas);

      DrawRect.Left   :=             (FBorderSize-2);
      DrawRect.Top    :=             (FBorderSize-2);
      DrawRect.Right  := Width  -1 - (FBorderSize-2);
      DrawRect.Bottom := Height -1 - (FBorderSize-2);

      DrawWidth       := DrawRect.Right  - DrawRect.Left;
      DrawHeight      := DrawRect.Bottom - DrawRect.Top;

      Font.Assign(FCaptionFont);

      if not FGlyph.Empty then
        begin
          TempWidth  := FGlyph.Width;
          TempHeight := FGlyph.Height;
        end
      else
        begin
          if FAutoLedSize then
            begin
              case FIndicatorAlignment of
                isaBottom : begin TempWidth := DrawWidth - 2*FIndicatorMargin; TempHeight := FIndicatorHeight;                end;
                isaTop    : begin TempWidth := DrawWidth - 2*FIndicatorMargin; TempHeight := FIndicatorHeight;                end;
                isaLeft   : begin TempWidth := FIndicatorWidth;                TempHeight := DrawHeight - 2*FIndicatorMargin; end;
                else        begin TempWidth := FIndicatorWidth;                TempHeight := DrawHeight - 2*FIndicatorMargin; end;
              end;
            end
          else
            begin
              TempWidth  := FIndicatorWidth;
              TempHeight := FIndicatorHeight;
            end;
        end;


      case FIndicatorAlignment of
        isaBottom : begin
                      LedRect := Rect(CenterPoint.X - TempWidth div 2, DrawRect.Bottom - FIndicatorMargin - TempHeight,
                                      CenterPoint.X + TempWidth div 2, DrawRect.Bottom - FIndicatorMargin);

                      ATextRect.Left  := DrawRect.Left;
                      ATextRect.Right := DrawRect.Right;

                      if FCaptionAlignment = islcaOppisiteSide then
                        begin
                          ATextFlags       := [itfHCenter, itfVTop];
                          ATextRect.Top    := DrawRect.Top + FCaptionMargin;
                          ATextRect.Bottom := LedRect.Top;
                        end
                      else
                        begin
                          ATextFlags       := [itfHCenter, itfVBottom];
                          ATextRect.Top    := DrawRect.Top;
                          ATextRect.Bottom := LedRect.Top - FCaptionMargin;
                        end;
                    end;
        isaTop    : begin
                      LedRect := Rect(CenterPoint.X - TempWidth div 2, DrawRect.Top + FIndicatorMargin,
                                      CenterPoint.X + TempWidth div 2, DrawRect.Top + FIndicatorMargin + TempHeight);

                      ATextRect.Left  := DrawRect.Left;
                      ATextRect.Right := DrawRect.Right;

                      if FCaptionAlignment = islcaOppisiteSide then
                        begin
                          ATextFlags       := [itfHCenter, itfVBottom];
                          ATextRect.Top    := LedRect.Bottom;
                          ATextRect.Bottom := DrawRect.Bottom - FCaptionMargin;
                        end
                      else
                        begin
                          ATextFlags       := [itfHCenter, itfVTop];
                          ATextRect.Top    := LedRect.Bottom + FCaptionMargin;
                          ATextRect.Bottom := DrawRect.Bottom;
                        end;
                    end;
        isaLeft   : begin
                      LedRect := Rect(Left + FIndicatorMargin,             CenterPoint.Y - TempHeight div 2,
                                      Left + FIndicatorMargin + TempWidth, CenterPoint.Y + TempHeight div 2);

                      ATextRect.Top    := DrawRect.Top;
                      ATextRect.Bottom := DrawRect.Bottom;

                      if FCaptionAlignment = islcaOppisiteSide then
                        begin
                          ATextFlags := [itfHRight, itfVCenter];
                          ATextRect.Left  := LedRect.Right;
                          ATextRect.Right := DrawRect.Right - FCaptionMargin;
                        end
                      else
                        begin
                          ATextFlags := [itfHLeft, itfVCenter];
                          ATextRect  := Rect(LedRect.Right + FCaptionMargin, DrawRect.Top, DrawRect.Right, DrawRect.Bottom);
                        end;
                    end;
        isaRight  : begin
                      LedRect := Rect(Right - FIndicatorMargin - TempWidth, CenterPoint.Y - TempHeight div 2,
                                      Right - FIndicatorMargin,             CenterPoint.Y + TempHeight div 2);

                      ATextRect.Top    := DrawRect.Top;
                      ATextRect.Bottom := DrawRect.Bottom;

                      if FCaptionAlignment = islcaOppisiteSide then
                        begin
                          ATextFlags := [itfHLeft, itfVCenter];
                          ATextRect.Left  := DrawRect.Left + FCaptionMargin;
                          ATextRect.Right := LedRect.Left;
                        end
                      else
                        begin
                          ATextFlags := [itfHRight, itfVCenter];
                          ATextRect.Left  := DrawRect.Left;
                          ATextRect.Right := LedRect.Left - FCaptionMargin;
                        end;
                   end;
      end;
                        ATextFlags := ATextFlags + [itfNoClip] + [itfShowPrefix];
      if FWordWrap then ATextFlags := ATextFlags + [itfWordBreak] else ATextFlags := ATextFlags + [itfSingleLine];


      if not Enabled then iDrawText(Canvas, FCaption, ATextRect, ATextFlags, Enabled, BackGroundColor)
      else
        begin
          if FMouseDown or FKeyDown  then OffsetRect(ATextRect, 1, 1);
          iDrawText(Canvas, FCaption, ATextRect, ATextFlags, Enabled, BackGroundColor);
        end;

      if (FIndicatorHeight > 1) and (FIndicatorWidth > 1) or (not FGlyph.Empty) then
        begin
          Brush.Style := bsSolid;
          if Active then Brush.Color := ActiveColor else Brush.Color := DimColor(ActiveColor, 3);
          Pen.Color   := clBlack;

          with LedRect do
            begin
              if FMouseDown or FKeyDown then OffsetRect(LedRect, 1, 1);
              if FGlyph.Empty then
                begin
                  Rectangle(Left, Top, Right+1, Bottom+1);
                  Pen.Color := clWhite;
                  PolyLine([Point(Left, Bottom), Point(Right,Bottom), Point(Right, Top-1)]);
                end
              else
                begin
                  //KYLIX TODO
                  {$ifndef iCLX}
                  FGlyph.TransparentColor := FGlyph.Canvas.Pixels[0, FGlyph.Height-1];
                  {$endif}
                  Canvas.Draw(Left, Top, FGlyph);
                end;
            end;
        end;

    end;

  if ShowFocusRect and HasFocus then
    begin
      Canvas.Pen.Color   := clBtnFace;
      Canvas.Brush.Color := clBtnFace;
      InflateRect(DrawRect, -3, -3);
      iDrawFocusRect(Canvas, DrawRect, BackGroundColor);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.DrawEdgeTopLeft(Canvas: TCanvas; Offset: Integer; AColor: TColor);
var
  DrawRect : TRect;
begin
  with Canvas, DrawRect do
    begin
      DrawRect := Rect(0, 0, Width-1, Height-1);
      Pen.Color := AColor;
      Polyline([Point(Left + Offset, Top + Offset), Point(Right - Offset , Top    + Offset  )]);
      Polyline([Point(Left + Offset, Top + Offset), Point(Left  + Offset,  Bottom - Offset  )]);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.DrawEdgeBottomRight(Canvas: TCanvas; Offset: Integer; AColor: TColor);
var
  DrawRect : TRect;
begin
  with Canvas, DrawRect do
    begin
      DrawRect := Rect(0, 0, Width-1, Height-1);
      Pen.Color := AColor;
      Polyline([Point(Right - Offset, Bottom - Offset), Point(Right - Offset,     Top + Offset - 1)]);
      Polyline([Point(Right - Offset, Bottom - Offset), Point(Left  + Offset - 1, Bottom - Offset)]);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.DrawBorder(Canvas: TCanvas);
var
  x : Integer;
begin
  with Canvas do
    begin
      Brush.Style := bsClear;

      if not HasFocus then
        begin
          DrawEdgeTopLeft    (Canvas, 0, clBtnHighlight);
          DrawEdgeBottomRight(Canvas, 0, clBlack);

          for x := 1 to FBorderSize - 1 do
            begin
              DrawEdgeTopLeft    (Canvas, x, FBorderHighlightColor);
              DrawEdgeBottomRight(Canvas, x, FBorderShadowColor);
            end;
        end
      else
        begin
          if not (FMouseDown or FKeyDown) then
            begin
              DrawEdgeTopLeft    (Canvas, 0, cl3DDkShadow);
              DrawEdgeBottomRight(Canvas, 0, clBlack);

              DrawEdgeTopLeft    (Canvas, 1, FBorderHighlightColor);
              DrawEdgeBottomRight(Canvas, 1, FBorderShadowColor);

              for x := 2 to FBorderSize - 1 do
                begin
                  DrawEdgeTopLeft    (Canvas, x, FBorderHighlightColor);
                  DrawEdgeBottomRight(Canvas, x, FBorderShadowColor);
                end;

              DrawEdgeBottomRight(Canvas, FBorderSize, FBorderShadowColor);
            end
          else
            begin
              DrawEdgeTopLeft    (Canvas, 0, clBlack);
              DrawEdgeBottomRight(Canvas, 0, clBlack);

              DrawEdgeTopLeft    (Canvas, 1, cl3DDkShadow);
              DrawEdgeBottomRight(Canvas, 1, cl3DDkShadow);

              for x := 2 to FBorderSize - 1 do
                begin
                  DrawEdgeTopLeft    (Canvas, x, FBorderShadowColor);
                  DrawEdgeBottomRight(Canvas, x, FBorderHighlightColor);
                end;
            end;
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.iDoKillFocus;
begin
  if FMouseDown then {$ifdef iVCL}OPCOutputData('{MouseDown}', False);{$endif}
  FMouseDown := False;
  FKeyDown   := False;
  InvalidateChange;
  inherited;
end;
//*************************************************************************************************************************************
//KYLIX TODO NOW
{$ifndef iCLX}
procedure TiSwitchLed.CMEnabledChanged(var Message: TMessage);
begin
  InvalidateChange;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.CMDialogChar(var Message: TCMDialogChar);
begin
  if Enabled then if IsAccel(Message.CharCode, Caption) and GetAltDown then
    begin
      SetFocus;
      InvalidateChange;
      FUserGenerated := True;
      try
        Active := not Active;
      finally
        FUserGenerated := False;
      end;
      Message.Result := 1;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.WMSysChar(var Message: TWMSysChar);
begin
  if Enabled then if IsAccel(Message.CharCode, Caption) then
    begin
      SetFocus;
      InvalidateChange;
      FUserGenerated := True;
      try
        Active := not Active;
      finally
        FUserGenerated := False;
      end;
      Message.Result := 1;
    end;
end;
{$endif}
//*************************************************************************************************************************************
procedure TiSwitchLed.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Caption_2', ReadCaption, WriteCaption, True);
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.ReadCaption(Reader: TReader);
begin
  FCaption := Reader.ReadString;
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.WriteCaption(Writer: TWriter);
begin
  Writer.WriteString(FCaption);
end;
//*************************************************************************************************************************************
procedure TiSwitchLed.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
  FGlyph.Transparent     := True;
  FGlyph.TransparentMode := tmAuto;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiSwitchLed.UpdateOPCSpecialList;
begin
  if not Assigned(OPCSpecialList) then Exit;
  OPCSpecialList.Clear;

  OPCSpecialList.Add('{MouseDown}');
end;
{$endif}
//*************************************************************************************************************************************
end.


