{*******************************************************}
{                                                       }
{       TiPhonePad Component                            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPhonePad;{$endif}
{$ifdef iCLX}unit QiPhonePad;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iClasses,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiClasses, QiCustomComponent;{$ENDIF}

type
  TiPhonePadKeyEvent = procedure(Sender : TObject; KeyCode : Integer; AChar: Char) of object;

  TiPhonePad = class(TiCustomComponent)
  private
    FButtonWidth     : Integer;
    FButtonHeight    : Integer;
    FMarginVert      : Integer;
    FMarginHorz      : Integer;
    FSpacingVert     : Integer;
    FSpacingHorz     : Integer;

    FFont            : TFont;
    FOuterMargin     : Double;
    FButtonSpacing   : Double;

    FButtonList      : TStringList;
    FMouseDownObject : TiButton;

    FButton0         : TiButton;
    FButton1         : TiButton;
    FButton2         : TiButton;
    FButton3         : TiButton;
    FButton4         : TiButton;
    FButton5         : TiButton;
    FButton6         : TiButton;
    FButton7         : TiButton;
    FButton8         : TiButton;
    FButton9         : TiButton;
    FButtonA         : TiButton;
    FButtonP         : TiButton;
    FShowFocusRect   : Boolean;
    FOnKeyClick      : TiPhonePadKeyEvent;
  protected
    procedure SetFont         (const Value: TFont);
    procedure SetOuterMargin  (const Value: Double);
    procedure SetButtonSpacing(const Value: Double);
    procedure SetShowFocusRect(const Value: Boolean);

    procedure SetButtonVisible0(const Value: Boolean);
    procedure SetButtonVisible1(const Value: Boolean);
    procedure SetButtonVisible2(const Value: Boolean);
    procedure SetButtonVisible3(const Value: Boolean);
    procedure SetButtonVisible4(const Value: Boolean);
    procedure SetButtonVisible5(const Value: Boolean);
    procedure SetButtonVisible6(const Value: Boolean);
    procedure SetButtonVisible7(const Value: Boolean);
    procedure SetButtonVisible8(const Value: Boolean);
    procedure SetButtonVisible9(const Value: Boolean);
    procedure SetButtonVisibleA(const Value: Boolean);
    procedure SetButtonVisibleP(const Value: Boolean);

    procedure SetButtonCaption0(const Value: String);
    procedure SetButtonCaption1(const Value: String);
    procedure SetButtonCaption2(const Value: String);
    procedure SetButtonCaption3(const Value: String);
    procedure SetButtonCaption4(const Value: String);
    procedure SetButtonCaption5(const Value: String);
    procedure SetButtonCaption6(const Value: String);
    procedure SetButtonCaption7(const Value: String);
    procedure SetButtonCaption8(const Value: String);
    procedure SetButtonCaption9(const Value: String);
    procedure SetButtonCaptionP(const Value: String);
    procedure SetButtonCaptionA(const Value: String);

    function GetButtonVisible0: Boolean;
    function GetButtonVisible1: Boolean;
    function GetButtonVisible2: Boolean;
    function GetButtonVisible3: Boolean;
    function GetButtonVisible4: Boolean;
    function GetButtonVisible5: Boolean;
    function GetButtonVisible6: Boolean;
    function GetButtonVisible7: Boolean;
    function GetButtonVisible8: Boolean;
    function GetButtonVisible9: Boolean;
    function GetButtonVisibleA: Boolean;
    function GetButtonVisibleP: Boolean;

    function GetButtonCaption0: String;
    function GetButtonCaption1: String;
    function GetButtonCaption2: String;
    function GetButtonCaption3: String;
    function GetButtonCaption4: String;
    function GetButtonCaption5: String;
    function GetButtonCaption6: String;
    function GetButtonCaption7: String;
    function GetButtonCaption8: String;
    function GetButtonCaption9: String;
    function GetButtonCaptionP: String;
    function GetButtonCaptionA: String;

    procedure CalcRects;

    function  CreateButton(Caption : String): TiButton;

    procedure ButtonInvalidate(Sender : TObject);
    procedure FontChange      (Sender : TObject);
    procedure ButtonClick     (Sender : TObject);

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    procedure iDoKillFocus;                 override;
    procedure iPaintTo(Canvas: TCanvas);    override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;
  published
    property Font               : TFont              read FFont                 write SetFont;
    property OuterMargin        : Double             read FOuterMargin          write SetOuterMargin;
    property ButtonSpacing      : Double             read FButtonSpacing        write SetButtonSpacing;
    property ShowFocusRect      : Boolean            read FShowFocusRect        write SetShowFocusRect default True;

    property ButtonVisible0     : Boolean            read GetButtonVisible0 write SetButtonVisible0 default True;
    property ButtonVisible1     : Boolean            read GetButtonVisible1 write SetButtonVisible1 default True;
    property ButtonVisible2     : Boolean            read GetButtonVisible2 write SetButtonVisible2 default True;
    property ButtonVisible3     : Boolean            read GetButtonVisible3 write SetButtonVisible3 default True;
    property ButtonVisible4     : Boolean            read GetButtonVisible4 write SetButtonVisible4 default True;
    property ButtonVisible5     : Boolean            read GetButtonVisible5 write SetButtonVisible5 default True;
    property ButtonVisible6     : Boolean            read GetButtonVisible6 write SetButtonVisible6 default True;
    property ButtonVisible7     : Boolean            read GetButtonVisible7 write SetButtonVisible7 default True;
    property ButtonVisible8     : Boolean            read GetButtonVisible8 write SetButtonVisible8 default True;
    property ButtonVisible9     : Boolean            read GetButtonVisible9 write SetButtonVisible9 default True;
    property ButtonVisibleStar  : Boolean            read GetButtonVisibleA write SetButtonVisibleA default True;
    property ButtonVisiblePound : Boolean            read GetButtonVisibleP write SetButtonVisibleP default True;

    property ButtonCaption0     : String             read GetButtonCaption0 write SetButtonCaption0;
    property ButtonCaption1     : String             read GetButtonCaption1 write SetButtonCaption1;
    property ButtonCaption2     : String             read GetButtonCaption2 write SetButtonCaption2;
    property ButtonCaption3     : String             read GetButtonCaption3 write SetButtonCaption3;
    property ButtonCaption4     : String             read GetButtonCaption4 write SetButtonCaption4;
    property ButtonCaption5     : String             read GetButtonCaption5 write SetButtonCaption5;
    property ButtonCaption6     : String             read GetButtonCaption6 write SetButtonCaption6;
    property ButtonCaption7     : String             read GetButtonCaption7 write SetButtonCaption7;
    property ButtonCaption8     : String             read GetButtonCaption8 write SetButtonCaption8;
    property ButtonCaption9     : String             read GetButtonCaption9 write SetButtonCaption9;
    property ButtonCaptionStar  : String             read GetButtonCaptionA write SetButtonCaptionA;
    property ButtonCaptionPound : String             read GetButtonCaptionP write SetButtonCaptionP;

    property OnKeyClick         : TiPhonePadKeyEvent read FOnKeyClick           write FOnKeyClick;

    property BackGroundColor;
    property Transparent;
    property BorderStyle;
    property Width            default 115;
    property Height           default 140;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiPhonePad.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width   := 115;
  Height  := 140;

  FButtonSpacing := 0.10;
  FOuterMargin   := 0.05;
  FShowFocusRect := True;

  FFont := TFont.Create; Font.OnChange := FontChange;

  FButtonList := TStringList.Create;

  FButton0:=CreateButton('0');
  FButton1:=CreateButton('1');
  FButton2:=CreateButton('2');
  FButton3:=CreateButton('3');
  FButton4:=CreateButton('4');
  FButton5:=CreateButton('5');
  FButton6:=CreateButton('6');
  FButton7:=CreateButton('7');
  FButton8:=CreateButton('8');
  FButton9:=CreateButton('9');
  FButtonA:=CreateButton('*');
  FButtonP:=CreateButton('#');
end;
//****************************************************************************************************************************************************
destructor TiPhonePad.Destroy;
begin
  FFont.Free;

  FButton0.Free;
  FButton1.Free;
  FButton2.Free;
  FButton3.Free;
  FButton4.Free;
  FButton5.Free;
  FButton6.Free;
  FButton7.Free;
  FButton8.Free;
  FButton9.Free;
  FButtonA.Free;
  FButtonP.Free;

  FButtonList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
function TiPhonePad.CreateButton(Caption: String): TiButton;
begin
  Result              := TiButton.Create;
  Result.Caption      := Caption;
  Result.OnInvalidate := ButtonInvalidate;
  Result.OnClick      := ButtonClick;

  FButtonList.AddObject('', Result);
end;
//****************************************************************************************************************************************************
procedure TiPhonePad.SetOuterMargin        (const Value:Double );begin SetDoubleProperty (Value,FOuterMargin,        irtInvalidate);end;
procedure TiPhonePad.SetButtonSpacing      (const Value:Double );begin SetDoubleProperty (Value,FButtonSpacing,      irtInvalidate);end;
procedure TiPhonePad.SetShowFocusRect      (const Value:Boolean);begin SetBooleanProperty(Value,FShowFocusRect,      irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiPhonePad.SetFont(const Value: TFont);begin FFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiPhonePad.FontChange(Sender: TObject);
var
  i       : Integer;
  iButton : TiButton;
begin
  for i := 0 to FButtonList.Count-1 do
    begin
      iButton := FButtonList.Objects[i] as TiButton;
      iButton.Font.Assign(FFont);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPhonePad.SetButtonVisible0(const Value:Boolean);begin FButton0.Visible:=Value;end;
procedure TiPhonePad.SetButtonVisible1(const Value:Boolean);begin FButton1.Visible:=Value;end;
procedure TiPhonePad.SetButtonVisible2(const Value:Boolean);begin FButton2.Visible:=Value;end;
procedure TiPhonePad.SetButtonVisible3(const Value:Boolean);begin FButton3.Visible:=Value;end;
procedure TiPhonePad.SetButtonVisible4(const Value:Boolean);begin FButton4.Visible:=Value;end;
procedure TiPhonePad.SetButtonVisible5(const Value:Boolean);begin FButton5.Visible:=Value;end;
procedure TiPhonePad.SetButtonVisible6(const Value:Boolean);begin FButton6.Visible:=Value;end;
procedure TiPhonePad.SetButtonVisible7(const Value:Boolean);begin FButton7.Visible:=Value;end;
procedure TiPhonePad.SetButtonVisible8(const Value:Boolean);begin FButton8.Visible:=Value;end;
procedure TiPhonePad.SetButtonVisible9(const Value:Boolean);begin FButton9.Visible:=Value;end;
procedure TiPhonePad.SetButtonVisibleA(const Value:Boolean);begin FButtonA.Visible:=Value;end;
procedure TiPhonePad.SetButtonVisibleP(const Value:Boolean);begin FButtonP.Visible:=Value;end;
//****************************************************************************************************************************************************
function TiPhonePad.GetButtonVisible0: Boolean;begin Result := FButton0.Visible;end;
function TiPhonePad.GetButtonVisible1: Boolean;begin Result := FButton1.Visible;end;
function TiPhonePad.GetButtonVisible2: Boolean;begin Result := FButton2.Visible;end;
function TiPhonePad.GetButtonVisible3: Boolean;begin Result := FButton3.Visible;end;
function TiPhonePad.GetButtonVisible4: Boolean;begin Result := FButton4.Visible;end;
function TiPhonePad.GetButtonVisible5: Boolean;begin Result := FButton5.Visible;end;
function TiPhonePad.GetButtonVisible6: Boolean;begin Result := FButton6.Visible;end;
function TiPhonePad.GetButtonVisible7: Boolean;begin Result := FButton7.Visible;end;
function TiPhonePad.GetButtonVisible8: Boolean;begin Result := FButton8.Visible;end;
function TiPhonePad.GetButtonVisible9: Boolean;begin Result := FButton9.Visible;end;
function TiPhonePad.GetButtonVisibleA: Boolean;begin Result := FButtonA.Visible;end;
function TiPhonePad.GetButtonVisibleP: Boolean;begin Result := FButtonP.Visible;end;
//****************************************************************************************************************************************************
function TiPhonePad.GetButtonCaption0: String;begin Result := FButton0.Caption;end;
function TiPhonePad.GetButtonCaption1: String;begin Result := FButton1.Caption;end;
function TiPhonePad.GetButtonCaption2: String;begin Result := FButton2.Caption;end;
function TiPhonePad.GetButtonCaption3: String;begin Result := FButton3.Caption;end;
function TiPhonePad.GetButtonCaption4: String;begin Result := FButton4.Caption;end;
function TiPhonePad.GetButtonCaption5: String;begin Result := FButton5.Caption;end;
function TiPhonePad.GetButtonCaption6: String;begin Result := FButton6.Caption;end;
function TiPhonePad.GetButtonCaption7: String;begin Result := FButton7.Caption;end;
function TiPhonePad.GetButtonCaption8: String;begin Result := FButton8.Caption;end;
function TiPhonePad.GetButtonCaption9: String;begin Result := FButton9.Caption;end;
function TiPhonePad.GetButtonCaptionA: String;begin Result := FButtonA.Caption;end;
function TiPhonePad.GetButtonCaptionP: String;begin Result := FButtonP.Caption;end;
//****************************************************************************************************************************************************
procedure TiPhonePad.SetButtonCaption0(const Value: String);begin FButton0.Caption := Value;end;
procedure TiPhonePad.SetButtonCaption1(const Value: String);begin FButton1.Caption := Value;end;
procedure TiPhonePad.SetButtonCaption2(const Value: String);begin FButton2.Caption := Value;end;
procedure TiPhonePad.SetButtonCaption3(const Value: String);begin FButton3.Caption := Value;end;
procedure TiPhonePad.SetButtonCaption4(const Value: String);begin FButton4.Caption := Value;end;
procedure TiPhonePad.SetButtonCaption5(const Value: String);begin FButton5.Caption := Value;end;
procedure TiPhonePad.SetButtonCaption6(const Value: String);begin FButton6.Caption := Value;end;
procedure TiPhonePad.SetButtonCaption7(const Value: String);begin FButton7.Caption := Value;end;
procedure TiPhonePad.SetButtonCaption8(const Value: String);begin FButton8.Caption := Value;end;
procedure TiPhonePad.SetButtonCaption9(const Value: String);begin FButton9.Caption := Value;end;
procedure TiPhonePad.SetButtonCaptionA(const Value: String);begin FButtonA.Caption := Value;end;
procedure TiPhonePad.SetButtonCaptionP(const Value: String);begin FButtonP.Caption := Value;end;
//****************************************************************************************************************************************************
procedure TiPhonePad.ButtonInvalidate(Sender: TObject);
begin
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiPhonePad.ButtonClick(Sender: TObject);
var
  KeyCode : Integer;
  AChar   : Char;
begin
  KeyCode := 0;
  AChar   := '0';
  if      Sender = FButton0 then begin KeyCode :=  0; AChar := '0'; end
  else if Sender = FButton1 then begin KeyCode :=  1; AChar := '1'; end
  else if Sender = FButton2 then begin KeyCode :=  2; AChar := '2'; end
  else if Sender = FButton3 then begin KeyCode :=  3; AChar := '3'; end
  else if Sender = FButton4 then begin KeyCode :=  4; AChar := '4'; end
  else if Sender = FButton5 then begin KeyCode :=  5; AChar := '5'; end
  else if Sender = FButton6 then begin KeyCode :=  6; AChar := '6'; end
  else if Sender = FButton7 then begin KeyCode :=  7; AChar := '7'; end
  else if Sender = FButton8 then begin KeyCode :=  8; AChar := '8'; end
  else if Sender = FButton9 then begin KeyCode :=  9; AChar := '9'; end
  else if Sender = FButtonA then begin KeyCode := 10; AChar := '*'; end
  else if Sender = FButtonP then begin KeyCode := 11; AChar := '#'; end;

  if Assigned(FOnKeyClick) then FOnKeyClick(Self, KeyCode, AChar);
end;
//****************************************************************************************************************************************************
procedure TiPhonePad.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i           : Integer;
  iButton     : TiButton;
  ScreenPoint : TPoint;
begin
  if (csDesigning in ComponentState) then exit;
  if Button <> mbLeft                then exit;
  SetFocus;
  ScreenPoint := ClientToScreen(Point(X, Y));

  for i := 0 to FButtonList.Count-1 do
    begin
      iButton := FButtonList.Objects[i] as TiButton;
      if not iButton.Visible then Continue;
      if PtInRect(iButton.DrawRect, Point(X, Y)) then
        begin
          FMouseDownObject := iButton;
          FMouseDownObject.iMouseDown(Button, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPhonePad.iMouseMove(Shift: TShiftState; X, Y: Integer);
begin

end;
//****************************************************************************************************************************************************
procedure TiPhonePad.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ScreenPoint : TPoint;
begin
  if (csDesigning in ComponentState) then exit;

  ScreenPoint := ClientToScreen(Point(X, Y));

  if Assigned(FMouseDownObject) then
    begin
      FMouseDownObject.iMouseUp(Button, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y);
      FMouseDownObject := nil;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPhonePad.iDoKillFocus;
var
  i : Integer;
begin
  if (csDesigning in ComponentState) then exit;

  for i := 0 to FButtonList.Count-1 do
    (FButtonList.Objects[i] as TiButton).MouseDown := False;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPhonePad.CalcRects;
var
  PixelsPerPercent : Double;
  ALeft            : Integer;
  ATop             : Integer;
begin
  PixelsPerPercent := Width / (3 + 2*FOuterMargin + 2*FButtonSpacing);

  FSpacingHorz := Round(PixelsPerPercent * FButtonSpacing);
  FButtonWidth := Round(PixelsPerPercent * 1.00          );

  FMarginHorz  := (Width - 3*FButtonWidth - 2*FSpacingHorz) div 2;

  PixelsPerPercent := Height / (4 + 2*FOuterMargin + 3*FButtonSpacing);

  FSpacingVert  := Round(PixelsPerPercent * FButtonSpacing);
  FButtonHeight := Round(PixelsPerPercent * 1.00          );

  FMarginVert   := (Height - 4*FButtonHeight - 3*FSpacingVert) div 2;

  ALeft := FMarginHorz;
  ATop  := FMarginVert;

  FButton1.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);ALeft := ALeft+FButtonWidth+FSpacingHorz;
  FButton2.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);ALeft := ALeft+FButtonWidth+FSpacingHorz;
  FButton3.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);

  ALeft := FMarginHorz;
  ATop  := ATop + FButtonHeight + FSpacingVert;

  FButton4.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);ALeft := ALeft+FButtonWidth+FSpacingHorz;
  FButton5.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);ALeft := ALeft+FButtonWidth+FSpacingHorz;
  FButton6.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);

  ALeft := FMarginHorz;
  ATop  := ATop + FButtonHeight + FSpacingVert;

  FButton7.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);ALeft := ALeft+FButtonWidth+FSpacingHorz;
  FButton8.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);ALeft := ALeft+FButtonWidth+FSpacingHorz;
  FButton9.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);

  ALeft := FMarginHorz;
  ATop  := ATop + FButtonHeight + FSpacingVert;

  FButtonA.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);ALeft := ALeft+FButtonWidth+FSpacingHorz;
  FButton0.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);ALeft := ALeft+FButtonWidth+FSpacingHorz;
  FButtonP.DrawRect := Rect(ALeft, ATop, ALeft+FButtonWidth, ATop+FButtonHeight);
end;
//****************************************************************************************************************************************************
procedure TiPhonePad.iPaintTo(Canvas: TCanvas);
var
  i      : Integer;
  ARect  : TRect;
  Button : TiButton;
begin
  with Canvas do
    begin
      CalcRects;
      DrawBackGround(Canvas, BackGroundColor);
      Font.Assign(FFont);
      Brush.Style := bsClear;

      for i := 0 to FButtonList.Count-1 do
        begin
          Button := (FButtonList.Objects[i] as TiButton);

          if not Button.Visible then Continue;

          Brush.Style := bsSolid;
          Brush.Color := BackGroundColor;
          with Button.DrawRect do
            Rectangle(Left, Top, Right, Bottom);

          Button.Draw(Canvas, Enabled);
        end;

      if HasFocus and FShowFocusRect then
        begin
          ARect := Rect(0, 0 ,Width, Height);
          if BorderStyle <> ibsNone then InflateRect(ARect, -3, -3);
          Brush.Style := bsSolid;
          iDrawFocusRect(Canvas, ARect, BackGroundColor);
        end;
    end;
end;
//****************************************************************************************************************************************************
end.


