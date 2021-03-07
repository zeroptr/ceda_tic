{*******************************************************}
{                                                       }
{       TiSwitchPanel Component                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchPanel;{$endif}
{$ifdef iCLX}unit QiSwitchPanel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iClasses,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiClasses, QiCustomComponent;{$ENDIF}

type
  TiSwitchPanelMouseControlStyle = (ispmcsRotate, ispmcsIncrement);
  TiSwitchPanelBorderStyle       = (ispbsLine, ispbsRaised, ispbsLowered, ispbsTop, ispbsNone);

  TiSwitchPanel = class(TiCustomComponent)
  private
    FPanelFontInactive        : TFont;
    FPanelFontActive          : TFont;
    FPositionCaption1         : String;
    FPositionCaption2         : String;
    FPositionCaption3         : String;
    FPosition                 : Integer;
    FPositionCount            : Integer;
    FKnobRadiusAutoSize       : Boolean;
    FKnobRadius               : Integer;
    FKnobHandleWidth          : Integer;
    FKnobHandleColor          : TColor;
    FKnobInnerColor           : TColor;
    FKnobOuterColor           : TColor;

    FKnobCenterPoint          : TPoint;
    FKnobOuterRect            : TRect;
    FKnobInnerRect            : TRect;

    FCaptionRect1             : TRect;
    FCaptionRect2             : TRect;
    FCaptionRect3             : TRect;

    FMouseDownCaption1        : Boolean;
    FMouseDownCaption2        : Boolean;
    FMouseDownCaption3        : Boolean;

    FMouseDownKnob            : Boolean;
    FMouseDownDegrees         : Double;

    FMouseDown                : Boolean;
    FKeyDown                  : Boolean;
    FMouseControlStyle        : TiSwitchPanelMouseControlStyle;
    FPanelMarginTop           : Double;
    FPanelMarginRow           : Double;
    FPanelMarginBottom        : Double;
    FPanelBackGroundColor     : TColor;
    FKnobSideMargin           : Integer;
    FBorderStyle              : TiSwitchPanelBorderStyle;
    FBackGroundColorTop       : TColor;
    FOnPositionChange         : TNotifyEvent;
    FOnPositionChangeUser     : TNotifyEvent;
    FOnPositionChangeFinished : TNotifyEvent;
    FUserGenerated            : Boolean;
    FPositionedChanged        : Boolean;
  protected
    procedure SetPositionCaption1    (const Value: String);
    procedure SetPositionCaption2    (const Value: String);
    procedure SetPositionCaption3    (const Value: String);
    procedure SetPanelFontInactive   (const Value: TFont);
    procedure SetPanelFontActive     (const Value: TFont);
    procedure SetPosition            (const Value: Integer);
    procedure SetPositionCount       (const Value: Integer);
    procedure SetKnobRadiusAutoSize  (const Value: Boolean);
    procedure SetKnobHandleColor     (const Value: TColor);
    procedure SetKnobInnerColor      (const Value: TColor);
    procedure SetKnobOuterColor      (const Value: TColor);
    procedure SetKnobRadius          (const Value: Integer);
    procedure SetKnobHandleWidth     (const Value: Integer);
    procedure SetMouseControlStyle   (const Value: TiSwitchPanelMouseControlStyle);
    procedure SetPanelBackGroundColor(const Value: TColor);
    procedure SetPanelMarginBottom   (const Value: Double);
    procedure SetPanelMarginRow      (const Value: Double);
    procedure SetPanelMarginTop      (const Value: Double);
    procedure SetKnobSideMargin      (const Value: Integer);
    procedure SetBorderStyle         (const Value: TiSwitchPanelBorderStyle); reintroduce;
    procedure SetBackGroundColorTop  (const Value: TColor);

    procedure DoPositionChange;
    procedure DoPositionChangeFinished;

    procedure iPaintTo  (Canvas: TCanvas);   override;
    procedure DrawBorder(Canvas: TCanvas);   override;

    procedure iWantSpecialKey(var CharCode: Word; var Result: Longint); override;
    procedure iKeyUp         (var CharCode: Word; Shift: TShiftState);  override;
    procedure iKeyDown       (var CharCode: Word; Shift: TShiftState);  override;

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;
    procedure iDoKillFocus;                                                        override;

    property PositionedChanged        : Boolean                        read FPositionedChanged        write FPositionedChanged;
 public
    constructor Create(AOwner: TComponent);override;
    destructor  Destroy;                   override;
  published
    property PositionCaption1         : String                         read FPositionCaption1         write SetPositionCaption1;
    property PositionCaption2         : String                         read FPositionCaption2         write SetPositionCaption2;
    property PositionCaption3         : String                         read FPositionCaption3         write SetPositionCaption3;
    property PanelFontInactive        : TFont                          read FPanelFontInactive        write SetPanelFontInactive;
    property PanelFontActive          : TFont                          read FPanelFontActive          write SetPanelFontActive;

    property PanelBackGroundColor     : TColor                         read FPanelBackGroundColor     write SetPanelBackGroundColor;
    property PanelMarginTop           : Double                         read FPanelMarginTop           write SetPanelMarginTop;
    property PanelMarginRow           : Double                         read FPanelMarginRow           write SetPanelMarginRow;
    property PanelMarginBottom        : Double                         read FPanelMarginBottom        write SetPanelMarginBottom;

    property PositionCount            : Integer                        read FPositionCount            write SetPositionCount;
    property Position                 : Integer                        read FPosition                 write SetPosition;

    property KnobOuterColor           : TColor                         read FKnobOuterColor           write SetKnobOuterColor;
    property KnobInnerColor           : TColor                         read FKnobInnerColor           write SetKnobInnerColor;
    property KnobHandleColor          : TColor                         read FKnobHandleColor          write SetKnobHandleColor;
    property KnobHandleWidth          : Integer                        read FKnobHandleWidth          write SetKnobHandleWidth;
    property KnobRadius               : Integer                        read FKnobRadius               write SetKnobRadius;
    property KnobSideMargin           : Integer                        read FKnobSideMargin           write SetKnobSideMargin;

    property KnobRadiusAutoSize       : Boolean                        read FKnobRadiusAutoSize       write SetKnobRadiusAutoSize;
    property MouseControlStyle        : TiSwitchPanelMouseControlStyle read FMouseControlStyle        write SetMouseControlStyle;
    property BorderStyle              : TiSwitchPanelBorderStyle       read FBorderStyle              write SetBorderStyle;

    property BackGroundColorTop       : TColor                         read FBackGroundColorTop       write SetBackGroundColorTop;

    property OnPositionChange         : TNotifyEvent                   read FOnPositionChange         write FOnPositionChange;
    property OnPositionChangeUser     : TNotifyEvent                   read FOnPositionChangeUser     write FOnPositionChangeUser;
    property OnPositionChangeFinished : TNotifyEvent                   read FOnPositionChangeFinished write FOnPositionChangeFinished;

    property BackGroundColor;
    property Width            default 140;
    property Height           default 190;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiSwitchPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width            := 100;
  Height           := 150;

  FPanelFontActive            := TFont.Create;
  FPanelFontActive.Size       := 8;
  FPanelFontActive.Style      := [fsBold];
  FPanelFontActive.Color      := clAqua;
  FPanelFontActive.OnChange   := InvalidateChangeEvent;

  FPanelFontInactive          := TFont.Create;
  FPanelFontInactive.Size     := 8;
  FPanelFontInactive.Style    := [fsBold];
  FPanelFontInactive.Color    := clWhite;
  FPanelFontInactive.OnChange := InvalidateChangeEvent;

  FPanelMarginTop     := 0.25;
  FPanelMarginRow     := 0.25;
  FPanelMarginBottom  := 0.25;

  FPositionCount      := 3;

  FPositionCaption1   := 'On';
  FPositionCaption2   := 'Off';
  FPositionCaption3   := 'Manual';

  FKnobOuterColor     := clWhite;
  FKnobInnerColor     := clGray;
  FKnobHandleColor    := clGray;
  KnobHandleWidth     := 10;

  FBackGroundColorTop := clAqua;

  FKnobRadiusAutoSize := True;
end;
//****************************************************************************************************************************************************
destructor TiSwitchPanel.Destroy;
begin
  FPanelFontInactive.Free;
  FPanelFontActive.Free;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiSwitchPanel.DoPositionChange;
begin
  if not Loading then
    begin
      if                          Assigned(OnChangeProtected)     then OnChangeProtected    (Self, 'Position');
      if                          Assigned(FOnPositionChange)     then FOnPositionChange    (Self);
      if (FUserGenerated) then if Assigned(FOnPositionChangeUser) then FOnPositionChangeUser(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchPanel.SetPositionCaption1    (const Value: String );begin SetStringProperty (Value, FPositionCaption1,    irtInvalidate);end;
procedure TiSwitchPanel.SetPositionCaption2    (const Value: String );begin SetStringProperty (Value, FPositionCaption2,    irtInvalidate);end;
procedure TiSwitchPanel.SetPositionCaption3    (const Value: String );begin SetStringProperty (Value, FPositionCaption3,    irtInvalidate);end;
procedure TiSwitchPanel.SetKnobRadiusAutoSize  (const Value: Boolean);begin SetBooleanProperty(Value, FKnobRadiusAutoSize,  irtInvalidate);end;
procedure TiSwitchPanel.SetKnobHandleColor     (const Value: TColor );begin SetColorProperty  (Value, FKnobHandleColor,     irtInvalidate);end;
procedure TiSwitchPanel.SetKnobInnerColor      (const Value: TColor );begin SetColorProperty  (Value, FKnobInnerColor,      irtInvalidate);end;
procedure TiSwitchPanel.SetKnobOuterColor      (const Value: TColor );begin SetColorProperty  (Value, FKnobOuterColor,      irtInvalidate);end;
procedure TiSwitchPanel.SetKnobRadius          (const Value: Integer);begin SetIntegerProperty(Value, FKnobRadius,          irtInvalidate);end;
procedure TiSwitchPanel.SetKnobHandleWidth     (const Value: Integer);begin SetIntegerProperty(Value, FKnobHandleWidth,     irtInvalidate);end;
procedure TiSwitchPanel.SetPanelBackGroundColor(const Value: TColor );begin SetColorProperty  (Value, FPanelBackGroundColor,irtInvalidate);end;
procedure TiSwitchPanel.SetPanelMarginBottom   (const Value: Double );begin SetDoubleProperty (Value, FPanelMarginBottom,   irtInvalidate);end;
procedure TiSwitchPanel.SetPanelMarginRow      (const Value: Double );begin SetDoubleProperty (Value, FPanelMarginRow,      irtInvalidate);end;
procedure TiSwitchPanel.SetPanelMarginTop      (const Value: Double );begin SetDoubleProperty (Value, FPanelMarginTop,      irtInvalidate);end;
procedure TiSwitchPanel.SetKnobSideMargin      (const Value: Integer);begin SetIntegerProperty(Value, FKnobSideMargin,      irtInvalidate);end;
procedure TiSwitchPanel.SetBackGroundColorTop  (const Value: TColor );begin SetColorProperty  (Value, FBackGroundColorTop,  irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiSwitchPanel.SetPanelFontInactive(const Value: TFont);begin FPanelFontInactive.Assign(Value);end;
procedure TiSwitchPanel.SetPanelFontActive  (const Value: TFont);begin FPanelFontActive.Assign(Value);  end;
//****************************************************************************************************************************************************
procedure TiSwitchPanel.SetPositionCount(const Value: Integer);
var
  TempValue : Integer;
begin
  TempValue := Value;
  if TempValue < 2 then TempValue := 2;
  if TempValue > 3 then TempValue := 3;
  if FPositionCount <> TempValue then
    begin
      FPositionCount := TempValue;
      if (FPositionCount-1) > FPosition then FPosition := FPositionCount-1;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchPanel.SetPosition(const Value: Integer);
var
  CanEdit : Boolean;
begin
  if FPosition <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Position', CanEdit);
      if CanEdit then
        begin
          FPosition          := Value;
          FPositionedChanged := True;
          if not Loading then
            begin
              if FPosition < 0 then FPosition := 0;
              if FPosition > (FPositionCount-1) then FPosition := FPositionCount-1;
            end;
          BackGroundChange;
          DoPositionChange;
          {$ifdef iVCL}OPCOutputData('Position', FPosition);{$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchPanel.SetMouseControlStyle(const Value: TiSwitchPanelMouseControlStyle);
begin
  FMouseControlStyle := Value;
end;
//****************************************************************************************************************************************************
procedure TiSwitchPanel.SetBorderStyle(const Value: TiSwitchPanelBorderStyle);
begin
  if FBorderStyle <> Value then
    begin
      FBorderStyle := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchPanel.DrawBorder(Canvas: TCanvas);
var
  DrawRect : TRect;
begin                                
  with Canvas do
    begin
      DrawRect := Rect(0, 0 ,Width, Height);
      case FBorderStyle of
        ispbsLowered : iDrawEdge(Canvas, DrawRect, idesSunken);
        ispbsRaised  : iDrawEdge(Canvas, DrawRect, idesRaised);
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchPanel.iPaintTo(Canvas: TCanvas);
var
  DrawRect           : TRect;
  MaxHeight          : Integer;
  PanelHeight        : Integer;
  MarginTopPixels    : Integer;
  MarginRowPixels    : Integer;
  MarginBottomPixels : Integer;
  Row1Top            : Integer;
  Row2Top            : Integer;
  ARect              : TRect;
  AText              : String;
  ATextWidth         : Integer;
  ATextHeight        : Integer;
  CenterX1           : Integer;
  CenterX2           : Integer;
  CenterX3           : Integer;
  TopY1              : Integer;
  TopY2              : Integer;
  TopY3              : Integer;
  PanelRect          : TRect;
  KnobInnerRadius    : Integer;
  HandlePoint1       : TPoint;
  HandlePoint2       : TPoint;
  HandlePoint3       : TPoint;
  HandlePoint4       : TPoint;
  KnobAngle          : Double;
  TempCenterPoint    : TPoint;
begin
  with Canvas, DrawRect do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      DrawRect := Rect(0, 0, Width-1, Height-1);

      Font.Assign(FPanelFontInactive);
      MaxHeight := TextHeight('A');

      Font.Assign(FPanelFontActive);
      if TextHeight('A') > MaxHeight then
        begin
          MaxHeight := TextHeight('A');
        end;

      MarginTopPixels    := Round(MaxHeight * FPanelMarginTop);
      MarginRowPixels    := Round(MaxHeight * FPanelMarginRow);
      MarginBottomPixels := Round(MaxHeight * FPanelMarginBottom);

      Row1Top     := Top                 + MarginTopPixels;
      Row2Top     := Row1Top + MaxHeight + MarginRowPixels;

      case PositionCount of
        2  : begin
               CenterX1    :=  Width     div 4;
               CenterX2    := (Width *3) div 4;
               CenterX3    := 0;

               TopY1       := Row1Top;
               TopY2       := Row1Top;
               TopY3       := 0;
               PanelHeight := Row1Top + MaxHeight + MarginBottomPixels;

               case Position of
                 0    : KnobAngle := 120.0;
                 else   KnobAngle :=  60.0;
               end;
             end;
        else begin
               CenterX1    :=  Width     div 4;
               CenterX2    :=  Width     div 2;
               CenterX3    := (Width *3) div 4;

               TopY1       := Row2Top;
               TopY2       := Row1Top;
               TopY3       := Row2Top;
               PanelHeight := Row2Top + MaxHeight + MarginBottomPixels;

               case Position of
                 0    : KnobAngle := 120.0;
                 1    : KnobAngle :=  90.0;
                 else   KnobAngle :=  60.0;
               end;
             end;
      end;

      PanelRect := Rect(DrawRect.Left, DrawRect.Top, DrawRect.Right, DrawRect.Top + PanelHeight);

      FKnobCenterPoint.X := Width div 2;
      FKnobCenterPoint.Y := (Bottom + PanelRect.Bottom) div 2;

      if KnobRadiusAutoSize then
        begin
          FKnobRadius := Width div 2 - FKnobSideMargin;
          if (Height - PanelRect.Bottom) div 2 - FKnobSideMargin < FKnobRadius then
            FKnobRadius := (Height - PanelRect.Bottom) div 2 - FKnobSideMargin;

        end;

      KnobInnerRadius := FKnobRadius - KnobHandleWidth;

      TempCenterPoint := GetXYRadPoint(KnobAngle,       KnobInnerRadius,           FKnobCenterPoint);
      HandlePoint1    := GetXYRadPoint(KnobAngle +  90, KnobHandleWidth div 2 + 1, TempCenterPoint );
      HandlePoint2    := GetXYRadPoint(KnobAngle -  90, KnobHandleWidth div 2 + 1, TempCenterPoint );

      TempCenterPoint := GetXYRadPoint(KnobAngle + 180, KnobInnerRadius,           FKnobCenterPoint);
      HandlePoint4    := GetXYRadPoint(KnobAngle +  90, KnobHandleWidth div 2 + 1, TempCenterPoint );
      HandlePoint3    := GetXYRadPoint(KnobAngle -  90, KnobHandleWidth div 2 + 1, TempCenterPoint );

      Brush.Style := bsSolid;
      Pen.Style   := psSolid;
      Brush.Color := FPanelBackGroundColor;
      Pen.Color   := FPanelBackGroundColor;
      Rectangle(PanelRect.Left, PanelRect.Top, PanelRect.Right+1, PanelRect.Bottom+1);

      case FBorderStyle of
        ispbsRaised  : DrawBorder(Canvas);
        ispbsLowered : DrawBorder(Canvas);
        ispbsLine    : begin
                         Brush.Style := bsClear;
                         Pen.Color   := clBlack;
                         Pen.Style   := psSolid;
                         Rectangle(Left, Top, Right+1, Bottom+1);
                       end;
        ispbsTop     : if (FKnobSideMargin = 0) then
                         begin
                           Brush.Color := FBackGroundColorTop;
                           Pen.Color   := FBackGroundColorTop;
                           Rectangle(PanelRect.Left, PanelRect.Bottom, PanelRect.Right, FKnobCenterPoint.Y);
                           Pen.Color   := clBlack;
                           PolyLine([Point(PanelRect.Left,  PanelRect.Bottom), Point(PanelRect.Left,  FKnobCenterPoint.Y)]);
                           PolyLine([Point(PanelRect.Right, PanelRect.Bottom), Point(PanelRect.Right, FKnobCenterPoint.Y)]);
                         end;
      end;

      Brush.Style := bsClear;

      if PositionCount > 0 then
        begin
          if Position = 0 then Font.Assign(FPanelFontActive) else Font.Assign(FPanelFontInactive);
          AText := FPositionCaption1;
          ARect := Rect(CenterX1, TopY1, CenterX1, TopY1);
          iDrawText(Canvas, AText, ARect, [itfVTop, itfHCenter, itfNoClip], True, BackGroundColor);
          ATextHeight := TextHeight(AText);
          ATextWidth  := TextWidth(AText);
          FCaptionRect1 := Rect(ARect.Left - ATextWidth div 2, ARect.Top,
                                ARect.Left + ATextWidth div 2, ARect.Top + ATextHeight);
        end;
                                         
      if PositionCount > 1 then
        begin
          if Position = 1 then Font.Assign(FPanelFontActive) else Font.Assign(FPanelFontInactive);
          AText := FPositionCaption2;
          ARect := Rect(CenterX2, TopY2, CenterX2, TopY2);
          iDrawText(Canvas, AText, ARect, [itfVTop, itfHCenter, itfNoClip], True, BackGroundColor);
          ATextHeight := TextHeight(AText);
          ATextWidth  := TextWidth(AText);
          FCaptionRect2 := Rect(ARect.Left - ATextWidth div 2, ARect.Top,
                                ARect.Left + ATextWidth div 2, ARect.Top + ATextHeight);
        end;

      if PositionCount > 2 then
        begin
          if Position = 2 then Font.Assign(FPanelFontActive) else Font.Assign(FPanelFontInactive);
          AText := FPositionCaption3;
          ARect := Rect(CenterX3, TopY3, CenterX3, TopY3);
          iDrawText(Canvas, AText, ARect, [itfVTop, itfHCenter, itfNoClip], True, BackGroundColor);
          ATextHeight := TextHeight(AText);
          ATextWidth  := TextWidth(AText);
          FCaptionRect3 := Rect(ARect.Left - ATextWidth div 2, ARect.Top,
                                ARect.Left + ATextWidth div 2, ARect.Top + ATextHeight);
        end;

      Brush.Style := bssolid;
      Pen.Style   := psSolid;
      Pen.Color   := clBlack;

      Brush.Color    := KnobOuterColor;
      FKnobOuterRect := Rect(FKnobCenterPoint.X - KnobRadius, FKnobCenterPoint.Y - KnobRadius,
                             FKnobCenterPoint.X + KnobRadius, FKnobCenterPoint.Y + KnobRadius);
      Ellipse(FKnobOuterRect.Left, FKnobOuterRect.Top, FKnobOuterRect.Right, FKnobOuterRect.Bottom);

      Brush.Color    := KnobInnerColor;
      FKnobInnerRect := Rect(FKnobCenterPoint.X - KnobInnerRadius, FKnobCenterPoint.Y - KnobInnerRadius,
                             FKnobCenterPoint.X + KnobInnerRadius, FKnobCenterPoint.Y + KnobInnerRadius);
      Ellipse(FKnobInnerRect.Left, FKnobInnerRect.Top, FKnobInnerRect.Right, FKnobInnerRect.Bottom);

      Brush.Color := KnobHandleColor;
      Polygon([HandlePoint1, HandlePoint2, HandlePoint3, HandlePoint4]);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchPanel.iWantSpecialKey(var CharCode: Word; var Result: Longint);
begin
  if CharCode in [VK_LEFT, VK_DOWN, VK_RIGHT, VK_UP] then Result := 1 else Result := 0;
end;
//*************************************************************************************************************************************
procedure TiSwitchPanel.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  InvalidateChange;
  if FKeyDown then
    begin
      FKeyDown   := False;
      FMouseDown := False;
      if PositionedChanged then
        begin
          PositionedChanged := False;
          if Assigned(OnPositionChangeFinished) then OnPositionChangeFinished(Self)
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchPanel.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  FKeyDown      := True;
  FMouseDown    := False;
  UserGenerated := True;
  try
    //KYLIX TODO
    {$ifndef iCLX}
    if      (CharCode = VK_LEFT) or (CharCode = VK_DOWN) then
      begin
        Position := Position - 1;
        CharCode := 0;
      end
    else if (CharCode = VK_RIGHT) or (CharCode = VK_UP) then
      begin
        Position := Position + 1;
        CharCode := 0;
      end
    else if (CharCode = VK_PRIOR) then //PageUp
      begin
        Position := FPositionCount-1;
        CharCode := 0;
      end
    else if (CharCode = VK_NEXT) then //PageDown
      begin
        Position := 0;
        CharCode := 0;
      end
    else if (CharCode = VK_HOME) then
      begin
        Position := 0;
        CharCode := 0;
      end
    else if (CharCode = VK_END) then
      begin
        Position := FPositionCount-1;
        CharCode := 0;
      end;
    {$endif}
  finally
    UserGenerated := False;
  end;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiSwitchPanel.iDoKillFocus;
begin
  FMouseDown         := False;
  FKeyDown           := False;
  FMouseDownKnob     := False;
  FMouseDownCaption1 := False;
  FMouseDownCaption2 := False;
  FMouseDownCaption3 := False;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiSwitchPanel.DoPositionChangeFinished;
begin
  if not Loading then
    begin
      if PositionedChanged then
        begin
          PositionedChanged := False;
          if Assigned(FOnPositionChangeFinished)then FOnPositionChangeFinished(Self);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchPanel.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetFocus;

  if PositionCount > 0 then if PtInRect(FCaptionRect1, Point(X, Y)) then FMouseDownCaption1 := True;
  if PositionCount > 1 then if PtInRect(FCaptionRect2, Point(X, Y)) then FMouseDownCaption2 := True;
  if PositionCount > 2 then if PtInRect(FCaptionRect3, Point(X, Y)) then FMouseDownCaption3 := True;

  if PtInRect(FKnobOuterRect, Point(X, Y)) then
    begin
      FMouseDownKnob    := True;
      if FMouseControlStyle = ispmcsRotate then FMouseDownDegrees := RadToDeg(ArcTan2(Y-FKnobCenterPoint.y,X-FKnobCenterPoint.x));
    end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchPanel.iMouseMove(Shift: TShiftState; X, Y: Integer);
var
  CurrentDegrees : Double;
  DeltaAngle     : Double;
begin
  FUserGenerated := True;
  try
    if FMouseDownKnob then if FMouseControlStyle = ispmcsRotate then
      begin
        CurrentDegrees  := RadToDeg(ArcTan2(Y-FKnobCenterPoint.y,X-FKnobCenterPoint.x));

        DeltaAngle      := FMouseDownDegrees - CurrentDegrees;
        if DeltaAngle >  200 then DeltaAngle := DeltaAngle - 360;
        if DeltaAngle < -200 then DeltaAngle := DeltaAngle + 360;

        if DeltaAngle > 22.5 then
          begin
            Position          := Position - 1;
            FMouseDownDegrees := CurrentDegrees  - 22.5;
          end
        else if DeltaAngle < -22.5 then
          begin
            Position          := Position + 1;
            FMouseDownDegrees := CurrentDegrees + 22.5;
          end;
      end;
  finally
    FUserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchPanel.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NewPosisition : Integer;
begin
  FUserGenerated := True;
  try
    if FMouseDownCaption1 then if PtInRect(FCaptionRect1, Point(X, Y)) then Position := 0;
    if FMouseDownCaption2 then if PtInRect(FCaptionRect2, Point(X, Y)) then Position := 1;
    if FMouseDownCaption3 then if PtInRect(FCaptionRect3, Point(X, Y)) then Position := 2;

    if FMouseDownKnob then if FMouseControlStyle = ispmcsIncrement then if PtInRect(FKnobOuterRect, Point(X, Y)) then
      begin
        NewPosisition := FPosition + 1;
        if NewPosisition > PositionCount -1 then NewPosisition := 0;
        Position := NewPosisition;
      end;

    FMouseDown         := False;
    FKeyDown           := False;
    FMouseDownKnob     := False;
    FMouseDownCaption1 := False;
    FMouseDownCaption2 := False;
    FMouseDownCaption3 := False;

    DoPositionChangeFinished;
  finally
    FUserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
end.
