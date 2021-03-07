{*******************************************************}
{                                                       }
{       TiValve Component                               }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iValve;{$endif}
{$ifdef iCLX}unit QiValve;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiValve = class(TiCustomComponent)
  private
    FOpened          : Boolean;
    FOpenedColor     : TColor;
    FClosedColor     : TColor;
    FChangeBodyColor : Boolean;
    FOnChange        : TNotifyEvent;
    FOnChangeUser    : TNotifyEvent;
    FMouseDown       : Boolean;
    FSpaceKeyDown    : Boolean;
    FUserGenerated   : Boolean;
    FOrientation     : TiOrientation;
  protected
    procedure SetOpened         (const Value: Boolean);
    procedure SetClosedColor    (const Value: TColor);
    procedure SetOpenedColor    (const Value: TColor);
    procedure SetChangeBodyColor(const Value: Boolean);
    procedure SetOrientation(const Value: TiOrientation);

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure iKeyUp  (var CharCode: Word; Shift: TShiftState);                    override;
    procedure iKeyDown(var CharCode: Word; Shift: TShiftState);                    override;

    procedure iDoKillFocus;                                                        override;

    procedure iPaintTo      (Canvas: TCanvas);                                     override;
    procedure DrawHorizontal(Canvas: TCanvas);
    procedure DrawVertical  (Canvas: TCanvas);

    procedure DoChange;
  public
    constructor Create(AOwner: TComponent);                                        override;
    destructor  Destroy;                                                           override;
  published
    property Opened          : Boolean       read FOpened          write SetOpened;
    property OpenedColor     : TColor        read FOpenedColor     write SetOpenedColor;
    property ClosedColor     : TColor        read FClosedColor     write SetClosedColor;
    property ChangeBodyColor : Boolean       read FChangeBodyColor write SetChangeBodyColor;
    property Orientation     : TiOrientation read FOrientation     write SetOrientation default ioHorizontal;

    property OnChange        : TNotifyEvent read FOnChange        write FOnChange;
    property OnChangeUser    : TNotifyEvent read FOnChangeUser    write FOnChangeUser;

    property BackGroundColor;
    property Width            default 50;
    property Height           default 50;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiValve.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width            := 50;
  Height           := 50;

  FOpenedColor     := clLime;
  FClosedColor     := clRed;
  FChangeBodyColor := True;
  FOrientation     := ioHorizontal;
end;
//****************************************************************************************************************************************************
destructor TiValve.Destroy;
begin
  inherited;
end;
//*************************************************************************************************************************************
procedure TiValve.DoChange;
begin
  if not Loading then
    begin
      if                        Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Opened');
      if                        Assigned(FOnChange)         then FOnChange        (Self);
      if FUserGenerated then if Assigned(FOnChangeUser)     then FOnChangeUser    (Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiValve.SetOpened(const Value: Boolean);
var
  CanEdit     : Boolean;
  TempBoolean : Boolean;
begin
  if ord(Value) = 0 then TempBoolean := False else TempBoolean := True;
  if FOpened <> TempBoolean then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Opened', CanEdit);
      if CanEdit then
        begin
          FOpened := TempBoolean;
          InvalidateChange;
          DoChange;
          {$ifdef iVCL}OPCOutputData('Opened', FOpened);{$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiValve.SetClosedColor    (const Value: TColor );begin SetColorProperty  (Value, FClosedColor,    irtInvalidate);end;
procedure TiValve.SetOpenedColor    (const Value: TColor );begin SetColorProperty  (Value, FOpenedColor,    irtInvalidate);end;
procedure TiValve.SetChangeBodyColor(const Value: Boolean);begin SetBooleanProperty(Value, FChangeBodyColor,irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiValve.SetOrientation(const Value: TiOrientation);
var
  TempWidth : Integer;
begin
  if FOrientation <> Value then
    begin
      if not Loading then
        begin
          TempWidth := Width;
          Width     := Height;
          Height    := TempWidth;
        end;
      FOrientation := Value;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiValve.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      SetFocus;
      FMouseDown := True;
    end;
  InvalidateChange;
end;
//*************************************************************************************************************************************
procedure TiValve.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      FUserGenerated := True;
      try
        FMouseDown    := False;
        FSpaceKeyDown := False;
        if PtInRect(Rect(0, 0 ,Width, Height), Point(X,Y)) then Opened := not Opened;
        InvalidateChange;
      finally
        FUserGenerated := False;
      end;
    end;
end;
//*************************************************************************************************************************************
procedure TiValve.iDoKillFocus;
begin
  FMouseDown    := False;
  FSpaceKeyDown := False;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiValve.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    begin
      FSpaceKeyDown := True;
      FMouseDown    := False;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiValve.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    if FSpaceKeyDown then
      begin
        InvalidateChange;
        FSpaceKeyDown  := False;
        FMouseDown     := False;
        FUserGenerated := True;
        try
          Opened := not Opened;
        finally
          FUserGenerated := False;
        end;
      end;
end;
//****************************************************************************************************************************************************
procedure TiValve.iPaintTo(Canvas: TCanvas);
begin
  case FOrientation of
    ioVertical   : DrawVertical(Canvas);
    ioHorizontal : DrawHorizontal(Canvas);
  end;
end;
//****************************************************************************************************************************************************
procedure TiValve.DrawVertical(Canvas: TCanvas);
var
  DrawRect   : TRect;
  BodyMidX   : Integer;
  BodyMidY   : Integer;
  BodyTop    : Integer;

  StemLeft   : Integer;
  StemRight  : Integer;
  StemTop    : Integer;
  StemBottom : Integer;

  KnobRadius : Integer;
  KnobRect   : TRect;

  KnobColor  : TColor;
begin
  DrawRect := Rect(0, 0, Width - 1, Height -1);
  with Canvas, DrawRect do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      BodyMidX   := (Width div 4)*3;
      BodyMidY   := Height div 2;
      BodyTop    := Width div 2;

      KnobRadius := Height div 4;
      KnobRect   := Rect(Left, BodyMidY - KnobRadius, 2*KnobRadius, BodyMidY + KnobRadius);

      StemLeft   := KnobRadius;
      StemRight  := BodyMidX;
      StemTop    := BodyMidY - 2;
      StemBottom := BodyMidY + 2;

      if Opened then KnobColor := OpenedColor else KnobColor := ClosedColor;

      DrawGradient(Canvas, BackGroundColor, KnobColor, KnobRect, False);

      Brush.Style := bsSolid;
      Brush.Color := BackGroundColor;
      Pen.Style   := psClear;

      KnobRect.Left := KnobRadius;
      FillRect(KnobRect);

      if FChangeBodyColor then Brush.Color := KnobColor else Brush.Color := clBtnFace;

      Polygon([Point(BodyMidX,  BodyMidY), Point(BodyTop,  Bottom), Point(Right, Bottom)]);
      Polygon([Point(BodyMidX,  BodyMidY), Point(BodyTop,  Top   ), Point(Right, Top   )]); 

      Rectangle(StemLeft, StemTop, StemRight, StemBottom);

      Pen.Style := psSolid;
      Pen.Color := clWhite;
      Line(Canvas, BodyMidX, BodyMidY, BodyTop,  Bottom);
      Line(Canvas, BodyMidX, BodyMidY, BodyTop,  Top);
      Line(Canvas, BodyTop,  Top,      Right, Top);
      Line(Canvas, StemLeft, StemTop, StemRight, StemTop);

      Pen.Color := clGray;
      Line(Canvas, BodyMidX, BodyMidY, Right, Bottom);
      Line(Canvas, BodyMidX, BodyMidY, Right, Top);

      Pen.Color := clBlack;
      Line(Canvas, BodyTop, Bottom, Right, Bottom);
      Line(Canvas, StemLeft, StemBottom, StemRight, StemBottom);
    end;
end;
//****************************************************************************************************************************************************
procedure TiValve.DrawHorizontal(Canvas: TCanvas);
var
  DrawRect   : TRect;
  BodyMidX   : Integer;
  BodyMidY   : Integer;
  BodyTop    : Integer;

  StemLeft   : Integer;
  StemRight  : Integer;
  StemTop    : Integer;
  StemBottom : Integer;

  KnobRadius : Integer;
  KnobRect   : TRect;

  KnobColor  : TColor;
begin
  DrawRect := Rect(0, 0, Width - 1, Height -1);
  with Canvas, DrawRect do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      BodyMidX   := Width div 2;
      BodyMidY   := (Height div 4)*3;
      BodyTop    := Height div 2;

      KnobRadius := Width div 4;
      KnobRect   := Rect(BodyMidX - KnobRadius, Top, BodyMidX + KnobRadius, 2*KnobRadius);

      StemLeft   := BodyMidX - 2;
      StemRight  := BodyMidX + 2;
      StemTop    := KnobRadius;
      StemBottom := BodyMidY;

      if Opened then KnobColor := OpenedColor else KnobColor := ClosedColor;

      DrawGradient(Canvas, BackGroundColor, KnobColor, KnobRect, False);

      Brush.Style := bsSolid;
      Brush.Color := BackGroundColor;
      Pen.Style   := psClear;

      KnobRect.Top := KnobRadius;
      FillRect(KnobRect);

      if FChangeBodyColor then Brush.Color := KnobColor else Brush.Color := clBtnFace;

      Polygon([Point(Left,  BodyTop), Point(Left,  Bottom), Point(BodyMidX, BodyMidY)]); //Left Body
      Polygon([Point(Right, BodyTop), Point(Right, Bottom), Point(BodyMidX, BodyMidY)]); //Right Body

      Rectangle(StemLeft, StemTop, StemRight, StemBottom);

      Pen.Style := psSolid;
      Pen.Color := clWhite;
      Line(Canvas, BodyMidX, BodyMidY, Right, BodyTop);
      Line(Canvas, Left, BodyTop, Left, Bottom);
      Line(Canvas, Left, BodyTop, BodyMidX, BodyMidY);
      Line(Canvas, StemLeft, StemTop, StemLeft, StemBottom);

      Pen.Color := clGray;
      Line(Canvas, Left, Bottom, BodyMidX, BodyMidY);
      Line(Canvas, BodyMidX, BodyMidY, Right, Bottom);

      Pen.Color := clBlack;
      Line(Canvas, Right, Bottom, Right, BodyTop);
      Line(Canvas, StemRight, StemTop, StemRight, StemBottom);
    end;
end;
//****************************************************************************************************************************************************
end.
