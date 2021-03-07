{*******************************************************}
{                                                       }
{       TiOdometer Component                            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOdometer;{$endif}
{$ifdef iCLX}unit QiOdometer;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent;{$ENDIF}

type
  TiOdometer = class(TiCustomComponent)
  private
    FAutoSize              : Boolean;
    FDigitsCount           : Integer;
    FDigitWidth            : Integer;
    FDigitFont             : TFont;
    FValue                 : Double;
    FDigitBackGroundColor  : TColor;
    FShowTenths            : Boolean;
    FTenthsBackGroundColor : TColor;
    FTenthsFont            : TFont;
    FBorderMargin          : Integer;
    FOnChange              : TNotifyEvent;
    FOnAutoSize            : TNotifyEvent;
    FDigitBorderShow       : Boolean;
    FDigitBorderColor      : TColor;
    FTenthsDigitCount      : Integer;
    FShowDecimalPoint      : Boolean;
  protected
    procedure iSetAutoSize            (const Value: Boolean);
    procedure SetDigitFont            (const Value: TFont);
    procedure SetDigitsCount          (const Value: Integer);
    procedure SetDigitWidth           (const Value: Integer);
    procedure SetValue                (const Value: Double);
    procedure SetDigitBackGroundColor (const Value: TColor);
    procedure SetShowTenths           (const Value: Boolean);
    procedure SetTenthsBackGroundColor(const Value: TColor);
    procedure SetTenthsFont           (const Value: TFont);
    procedure SetBorderMargin         (const Value: Integer);
    procedure SetDigitBorderColor     (const Value: TColor);
    procedure SetDigitBorderShow      (const Value: Boolean);
    procedure SetTenthsDigitCount     (const Value: Integer);
    procedure SetShowDecimalPoint     (const Value: Boolean);

    procedure DoChange;
    procedure DoAutoSize;

    procedure iPaintTo(Canvas: TCanvas);     override;
  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;
    procedure   SetValueNoEvent(const Value: Double);
    property OnAutoSize            : TNotifyEvent read FOnAutoSize            write FOnAutoSize;
  published
    property AutoSize              : Boolean      read FAutoSize              write iSetAutoSize             default True;
    property DigitsCount           : Integer      read FDigitsCount           write SetDigitsCount           default 5;
    property DigitFont             : TFont        read FDigitFont             write SetDigitFont;
    property DigitWidth            : Integer      read FDigitWidth            write SetDigitWidth            default 15;
    property DigitBackGroundColor  : TColor       read FDigitBackGroundColor  write SetDigitBackGroundColor  default clBlack;
    property DigitBorderShow       : Boolean      read FDigitBorderShow       write SetDigitBorderShow       default True;
    property DigitBorderColor      : TColor       read FDigitBorderColor      write SetDigitBorderColor      default clWhite;
    property ShowTenths            : Boolean      read FShowTenths            write SetShowTenths            default True;
    property ShowDecimalPoint      : Boolean      read FShowDecimalPoint      write SetShowDecimalPoint      default False;
    property TenthsBackGroundColor : TColor       read FTenthsBackGroundColor write SetTenthsBackGroundColor default clTeal;
    property TenthsFont            : TFont        read FTenthsFont            write SetTenthsFont;
    property TenthsDigitCount      : Integer      read FTenthsDigitCount      write SetTenthsDigitCount      default 1;
    property Value                 : Double       read FValue                 write SetValue;
    property BorderMargin          : Integer      read FBorderMargin          write SetBorderMargin          default 2;
    property OnChange              : TNotifyEvent read FOnChange              write FOnChange;
    property BorderStyle;
    property Transparent;
    property BackGroundColor;
    property Width            default 81;
    property Height           default 23;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiOdometer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width        := 81;
  Height       := 23;

  FDigitsCount           := 5;
  FDigitWidth            := 15;
  FBorderMargin          := 2;
  FShowTenths            := True;
  FAutoSize              := True;
  FDigitBorderShow       := True;
  FDigitBorderColor      := clWhite;
  FDigitBackGroundColor  := clBlack;
  FTenthsBackGroundColor := clTeal;
  FTenthsDigitCount      := 1;

  FDigitFont   := TFont.Create; FDigitFont.OnChange  := BackGroundChangeEvent;
  FTenthsFont  := TFont.Create; FTenthsFont.OnChange := BackGroundChangeEvent;

  FDigitFont.Color  := clWhite;
  FTenthsFont.Color := clWhite;
  FDigitFont.Style  := [fsBold];
  FTenthsFont.Style := [fsBold];
end;
//****************************************************************************************************************************************************
destructor TiOdometer.Destroy;
begin
  FDigitFont.Free;
  FTenthsFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiOdometer.DoChange;
begin
  if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Value');
  if Assigned(FOnChange) then FOnChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiOdometer.SetDigitBackGroundColor (const Value:TColor );begin SetColorProperty  (Value,FDigitBackGroundColor, irtBackGround);end;
procedure TiOdometer.SetTenthsBackGroundColor(const Value:TColor );begin SetColorProperty  (Value,FTenthsBackGroundColor,irtBackGround);end;
procedure TiOdometer.SetDigitBorderColor     (const Value:TColor );begin SetColorProperty  (Value,FDigitBorderColor,     irtBackGround);end;
procedure TiOdometer.SetDigitBorderShow      (const Value:Boolean);begin SetBooleanProperty(Value,FDigitBorderShow,      irtBackGround);end;
procedure TiOdometer.SetTenthsDigitCount     (const Value:Integer);begin SetIntegerProperty(Value,FTenthsDigitCount,     irtBackGround);end;
procedure TiOdometer.SetShowDecimalPoint     (const Value:Boolean);begin SetBooleanProperty(Value,FShowDecimalPoint,     irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiOdometer.SetDigitFont (const Value: TFont);begin FDigitFont.Assign(Value);end;
procedure TiOdometer.SetTenthsFont(const Value: TFont);begin FTenthsFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiOdometer.DoAutoSize;
begin
  if FAutoSize and not Loading then
    begin
      Width := FDigitWidth * FDigitsCount + 2*FBorderMargin;
      if Assigned(FOnAutoSize) then FOnAutoSize(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiOdometer.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      DoAutoSize;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOdometer.SetValueNoEvent(const Value: Double);
var
  TempOnValueChange : TNotifyEvent;
begin
  TempOnValueChange := FOnChange;
  FOnChange:= nil;
  try
    SetValue(Value);
  finally
    FOnChange := TempOnValueChange;
  end;
end;
//****************************************************************************************************************************************************
procedure TiOdometer.SetValue(const Value: Double);
var
  TempValue : Double;
  CanEdit   : Boolean;
begin
  TempValue := Value;
  if TempValue < 0 then TempValue := 0;

  if FValue <> TempValue then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Value', CanEdit);
      if CanEdit then
        begin
          FValue := TempValue;
          BackGroundChange;
          DoChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOdometer.SetDigitsCount(const Value: Integer);
begin
  if FDigitsCount <> Value then
    begin
      FDigitsCount := Value;
      if FDigitsCount < 1 then FDigitsCount := 1;
      DoAutoSize;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOdometer.SetDigitWidth(const Value: Integer);
begin
  if FDigitWidth <> Value then
    begin
      FDigitWidth := Value;
      DoAutoSize;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOdometer.SetShowTenths(const Value: Boolean);
begin
  if FShowTenths <> Value then
    begin
      FShowTenths := Value;
      DoAutoSize;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOdometer.SetBorderMargin(const Value: Integer);
begin
  if FBorderMargin <> Value then
    begin
      FBorderMargin := Value;
      DoAutoSize;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOdometer.iPaintTo(Canvas: TCanvas);
var
  x                : Integer;
  DigitRect        : TRect;
  ATextRect        : TRect;
  ALeft            : Integer;
  CenterY          : Integer;
  ATextHeight      : Integer;
  DigitValue       : Integer;
  TenthsOffset     : Integer;
  PreviousRotating : Boolean;
  RotationPercent  : Double;
  DisplayChar      : String;
  NextChar         : String;
  PrevChar         : String;
  AText            : String;
begin
  with Canvas, ATextRect do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      ALeft := Width - FBorderMargin;

      PreviousRotating := True;

      if FShowTenths then TenthsOffset := FTenthsDigitCount else TenthsOffset := 0;

      AText := Format('%.' + IntToStr(TenthsOffset) + 'd', [Trunc(ABS(FValue*Power(10, TenthsOffset)))]);

      RotationPercent := (FValue * Power(10, TenthsOffset) - StrToFloat(AText));

      while Length(AText) < FDigitsCount do
        AText := '0' + AText;

      for x := 1 to FDigitsCount do
        begin
          DigitRect  := Rect(ALeft - FDigitWidth, 0 , ALeft, Height);
          if FShowTenths and (x <= FTenthsDigitCount) then
            begin
              Pen.Color   := FTenthsBackGroundColor;
              Brush.Color := FTenthsBackGroundColor;
              Font.Assign(FTenthsFont);
            end
          else
            begin
              Pen.Color   := FDigitBackGroundColor;
              Brush.Color := FDigitBackGroundColor;
              Font.Assign(FDigitFont);
            end;

          ATextHeight := TextHeight('0');

          Brush.Style := bsSolid;
          Rectangle(DigitRect.Left, 0, DigitRect.Right, Height);

          DisplayChar := Copy(AText, Length(AText) - x + 1, 1);
          DigitValue  := strToInt(DisplayChar);

          if DigitValue = 9 then NextChar := '0' else NextChar := IntToStr(DigitValue + 1);
          if DigitValue = 0 then PrevChar := '9' else PrevChar := IntToStr(DigitValue - 1);

          CenterY := (DigitRect.Top + DigitRect.Bottom) div 2;

          if PreviousRotating then CenterY := CenterY - Round(ATextHeight * RotationPercent);

          Brush.Style := bsClear;
          ATextRect := DigitRect;
          TextOut((Left + Right) div 2 - TextWidth(DisplayChar) div 2, CenterY - TextHeight(DisplayChar) div 2, DisplayChar);

          ATextRect := Rect(DigitRect.Left, CenterY-ATextHeight, DigitRect.Right, CenterY-ATextHeight);
          TextOut((Left + Right) div 2 - TextWidth(PrevChar) div 2, (Top + Bottom) div 2 - TextHeight(PrevChar) div 2, PrevChar);

          ATextRect := Rect(DigitRect.Left, CenterY+ATextHeight, DigitRect.Right, CenterY+ATextHeight);
          TextOut((Left + Right) div 2 - TextWidth(NextChar) div 2, (Top + Bottom) div 2 - TextHeight(NextChar) div 2, NextChar);

          if FDigitBorderShow then
            begin
              Brush.Style := bsClear;
              Pen.Style   := psSolid;
              Pen.Color   := FDigitBorderColor;
              Rectangle(DigitRect.Left, DigitRect.Top, DigitRect.Right, DigitRect.Bottom);
            end;


          if DigitValue <> 9 then PreviousRotating := False;
          ALeft := ALeft - FDigitWidth;
        end;
        
        if FShowDecimalPoint and FShowTenths and (FTenthsDigitCount > 0) then
          begin
            Font.Assign(FDigitFont);
            ALeft := Width - FBorderMargin - FDigitWidth * FTenthsDigitCount;
            ATextRect := Rect(ALeft, DigitRect.Top, ALeft, DigitRect.Bottom);
            TextOut((Left + Right) div 2 - TextWidth('.') div 2, (Top + Bottom) div 2 - TextHeight('.') div 2, '.');
          end;
    end;
    DrawBorder(Canvas);
end;
//****************************************************************************************************************************************************
end.
