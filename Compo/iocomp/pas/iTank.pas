{*******************************************************}
{                                                       }
{       TiTank Component                                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iTank;{$endif}
{$ifdef iCLX}unit QiTank;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iPositionComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiPositionComponent;{$ENDIF}

type
  TiTankPointerStyle = (itpsBar, itpsCutOut1, itpsCutOut2, itpsLargeWindow, itpsCustom);

  TTankCustomPoint = class
  public
    X : Double;
    Y : Double;
  end;

  TiTank = class(TiPositionComponent)
  private
    FTankColor           : TColor;
    FTankShow            : Boolean;
    FTankShadowColor     : TColor;
    FAutoTankShadowColor : Boolean;
    FMaskingBitmap       : TBitmap;
    FPointerColor        : TColor;
    FPointerStyle        : TiTankPointerStyle;
    FOrientation         : TiOrientation;
    FOnAutoSize          : TNotifyEvent;
    FPointerReverse      : Boolean;
    FCustomList          : TStringList;
    FMaxPoint            : Double;
    FMinPoint            : Double;
  protected
    procedure SetTankColor          (const Value: TColor);
    procedure SetTankShow           (const Value: Boolean);
    procedure SetTankShadowColor    (const Value: TColor);
    procedure SetPointerColor       (const Value: TColor);
    procedure SetPointerStyle       (const Value: TiTankPointerStyle);
    procedure SetOrientation        (const Value: TiOrientation);
    procedure SetPointerReverse     (const Value: Boolean);
    procedure SetAutoTankShadowColor(const Value: Boolean);

    procedure iPaintTo(Canvas: TCanvas);                          override;

    procedure DrawCutOut            (Canvas: TCanvas; AColor: TColor);

    procedure DrawGradientBackGround(Canvas: TCanvas);
    property OnAutoSize      : TNotifyEvent       read FOnAutoSize        write FOnAutoSize;
  public
    constructor Create(AOwner: TComponent);                       override;
    destructor  Destroy;                                          override;

    function  CustomPointsAdd(X, Y: Double): Integer;
    procedure CustomPointsClear;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);   override;
  published
    property TankColor           : TColor             read FTankColor           write SetTankColor           default clBtnFace;
    property TankShadowColor     : TColor             read FTankShadowColor     write SetTankShadowColor     default clGray;
    property AutoTankShadowColor : Boolean            read FAutoTankShadowColor write SetAutoTankShadowColor default True;
    property TankShow            : Boolean            read FTankShow            write SetTankShow            default True;
    property PointerStyle        : TiTankPointerStyle read FPointerStyle        write SetPointerStyle        default itpsCutOut1;
    property PointerColor        : TColor             read FPointerColor        write SetPointerColor        default clBlue;
    property PointerReverse      : Boolean            read FPointerReverse      write SetPointerReverse      default False;
    property Orientation         : TiOrientation      read FOrientation         write SetOrientation         default ioVertical;

    property BackGroundColor;
    property Transparent;
    property Width            default 90;
    property Height           default 200;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiTank.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width                := 90;
  Height               := 200;

  FTankColor           := clBtnFace;
  FTankShow            := True;
  FTankShadowColor     := clGray;
  FAutoTankShadowColor := True;
  FPointerColor        := clBlue;
  FPointerReverse      := False;
  FOrientation         := ioVertical;

  FMaskingBitmap       := TBitmap.Create;
  FCustomList          := TStringList.Create;

  FPointerStyle        := itpsCutOut1;
end;
//****************************************************************************************************************************************************
destructor TiTank.Destroy;
begin
  FCustomList.Free;
  FMaskingBitmap.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiTank.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if Assigned(FMaskingBitmap) then
    begin
      FMaskingBitmap.Width  := Width;
      FMaskingBitmap.Height := Height;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTank.SetTankColor          (const Value: TColor );begin SetColorProperty  (Value, FTankColor,           irtBackGround);end;
procedure TiTank.SetTankShadowColor    (const Value: TColor );begin SetColorProperty  (Value, FTankShadowColor,     irtBackGround);end;
procedure TiTank.SetPointerColor       (const Value: TColor );begin SetColorProperty  (Value, FPointerColor,        irtBackGround);end;
procedure TiTank.SetTankShow           (const Value: Boolean);begin SetBooleanProperty(Value, FTankShow,            irtBackGround);end;
procedure TiTank.SetPointerReverse     (const Value: Boolean);begin SetBooleanProperty(Value, FPointerReverse,      irtBackGround);end;
procedure TiTank.SetAutoTankShadowColor(const Value: Boolean);begin SetBooleanProperty(Value, FAutoTankShadowColor, irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiTank.SetPointerStyle(const Value: TiTankPointerStyle);
begin
  if FPointerStyle <> Value then
    begin
      FPointerStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTank.SetOrientation(const Value: TiOrientation);
var
  TempWidth : Integer;
begin
  if FOrientation <> Value then
    begin
      FOrientation := Value;
      BackGroundChange;
      if not Loading then
        begin
          TempWidth := Width;
          Width     := Height;
          Height    := TempWidth;
          if Assigned(FOnAutoSize) then FOnAutoSize(Self);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTank.iPaintTo(Canvas: TCanvas);
var
  i              : Integer;
  Bitmap         : TBitmap;
  MaxPixels      : Integer;
  MinPixels      : Integer;
  PositionPixels : Integer;
begin
  if FPointerStyle = itpsCustom then
    begin
      FMaxPoint := 0;
      FMinPoint := 100;

      for i := 0 to FCustomList.Count-1 do
        begin
          if (FCustomList.Objects[i] as TTankCustomPoint).Y > FMaxPoint then FMaxPoint := (FCustomList.Objects[i] as TTankCustomPoint).Y;
          if (FCustomList.Objects[i] as TTankCustomPoint).Y < FMinPoint then FMinPoint := (FCustomList.Objects[i] as TTankCustomPoint).Y;
        end;
    end
  else
    begin
      FMaxPoint := 90;
      FMinPoint := 10;
    end;

  with Canvas do
    begin
      if BackGroundChanged then
        begin
          CreateBackGroundBitmap;
                            DrawBackGround        (BackGroundBitmap.Canvas, BackGroundColor);
          if FTankShow then DrawGradientBackGround(BackGroundBitmap.Canvas);

          DrawCutOut(BackGroundBitmap.Canvas, PointerColor);

          FMaskingBitmap.Canvas.Brush.Style := bsSolid;
          FMaskingBitmap.Canvas.Brush.Color := clBlack;
          FMaskingBitmap.Canvas.FillRect(Rect(0, 0 ,Width, Height));
          DrawCutOut(FMaskingBitmap.Canvas, clWhite);

          ResetBackGroundChange;
        end;

      TransferBackGround(Canvas);

      Bitmap := TBitmap.Create;
      try
        Bitmap.Width  := Width;
        Bitmap.Height := Height;

        Bitmap.Canvas.Brush.Style := bsSolid;
        Bitmap.Canvas.Brush.Color := clWhite;
        Bitmap.Canvas.FillRect(Rect(0, 0 ,Width, Height));

        Bitmap.Canvas.Brush.Style := bsSolid;
        Bitmap.Canvas.Brush.Color := clBlack;
        Bitmap.Canvas.Pen.Color   := clBlack;

        case FOrientation of
          ioVertical : begin
                         MaxPixels      := Round(Height* FMinPoint/100);
                         MinPixels      := Round(Height* FMaxPoint/100);

                         if FPointerReverse then
                           begin
                             PositionPixels := Round(MaxPixels - PositionPercent*(MaxPixels-MinPixels));
                             Bitmap.Canvas.Rectangle(0, MaxPixels, Width, PositionPixels);
                           end
                         else
                           begin
                             PositionPixels := Round(PositionPercent*(MaxPixels-MinPixels) + MinPixels);
                             Bitmap.Canvas.Rectangle(0, PositionPixels, Width, MinPixels);
                           end;
                       end
          else         begin
                         MaxPixels      := Round(Width* FMaxPoint/100);
                         MinPixels      := Round(Width* FMinPoint/100);

                         if FPointerReverse then
                           begin
                             PositionPixels := Round(MaxPixels - PositionPercent*(MaxPixels-MinPixels));
                             Bitmap.Canvas.Rectangle(PositionPixels, 0, MaxPixels+1, Height);
                           end
                         else
                           begin
                             PositionPixels := Round(PositionPercent*(MaxPixels-MinPixels) + MinPixels);
                             Bitmap.Canvas.Rectangle(MinPixels, 0, PositionPixels, Height);
                           end;
                       end;
        end;

        Bitmap.Canvas.CopyMode := cmSrcAnd;
        Bitmap.Canvas.CopyRect(Rect(0, 0 ,Width, Height), FMaskingBitmap.Canvas, Rect(0, 0 ,Width, Height));

        Bitmap.Canvas.CopyMode := cmNotSrcCopy;
        Bitmap.Canvas.CopyRect(Rect(0, 0 ,Width, Height), Bitmap.Canvas, Rect(0, 0 ,Width, Height));

        Canvas.CopyMode := cmSrcAnd;
        Canvas.CopyRect(Rect(0, 0 ,Width, Height), Bitmap.Canvas, Rect(0, 0 ,Width, Height));
      finally
        Bitmap.Free;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiTank.DrawCutOut(Canvas: TCanvas; AColor: TColor);
var
  DataArray  : Array[0..1000] of TPointDouble;
  PointArray : Array[0..1000] of TPoint;
  Count      : Integer;
  i          : Integer;
begin
  with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Count := 0;

      case FPointerStyle of
        itpsBar         : begin
                            DataArray[0].x := 40; DataArray[0].y := 10;
                            DataArray[1].x := 40; DataArray[1].y := 90;
                            DataArray[2].x := 60; DataArray[2].y := 90;
                            DataArray[3].x := 60; DataArray[3].y := 10;
                            Count := 4;
                          end;

        itpsCutOut1     : begin
                            DataArray[ 0].x := 47; DataArray[ 0].y := 10;
                            DataArray[ 1].x := 25; DataArray[ 1].y := 26;
                            DataArray[ 2].x := 25; DataArray[ 2].y := 41;
                            DataArray[ 3].x := 39; DataArray[ 3].y := 47;
                            DataArray[ 4].x := 26; DataArray[ 4].y := 58;
                            DataArray[ 5].x := 40; DataArray[ 5].y := 66;
                            DataArray[ 6].x := 29; DataArray[ 6].y := 78;
                            DataArray[ 7].x := 51; DataArray[ 7].y := 90;

                            DataArray[ 8].x := 83; DataArray[ 8].y := 75;
                            DataArray[ 9].x := 64; DataArray[ 9].y := 61;
                            DataArray[10].x := 75; DataArray[10].y := 55;
                            DataArray[11].x := 66; DataArray[11].y := 48;
                            DataArray[12].x := 77; DataArray[12].y := 35;
                            DataArray[13].x := 65; DataArray[13].y := 25;
                            DataArray[14].x := 65; DataArray[14].y := 15;
                            Count := 15;
                          end;
        itpsCutOut2     : begin
                            DataArray[ 0].x := 20; DataArray[ 0].y := 90;
                            DataArray[ 1].x := 30; DataArray[ 1].y := 70;
                            DataArray[ 2].x := 10; DataArray[ 2].y := 50;
                            DataArray[ 3].x := 30; DataArray[ 3].y := 30;
                            DataArray[ 4].x := 20; DataArray[ 4].y := 20;
                            DataArray[ 5].x := 30; DataArray[ 5].y := 10;
                            DataArray[ 6].x := 80; DataArray[ 6].y := 10;
                            DataArray[ 7].x := 70; DataArray[ 7].y := 20;
                            DataArray[ 8].x := 80; DataArray[ 8].y := 30;
                            DataArray[ 9].x := 60; DataArray[ 9].y := 50;
                            DataArray[10].x := 80; DataArray[10].y := 70;
                            DataArray[11].x := 70; DataArray[11].y := 80;
                            Count := 12;
                          end;
        itpsLargeWindow : begin
                            DataArray[ 0].x := 10; DataArray[ 0].y := 15;
                            DataArray[ 1].x := 10; DataArray[ 1].y := 85;
                            DataArray[ 2].x := 20; DataArray[ 2].y := 90;
                            DataArray[ 3].x := 80; DataArray[ 3].y := 90;
                            DataArray[ 4].x := 90; DataArray[ 4].y := 85;
                            DataArray[ 5].x := 90; DataArray[ 5].y := 15;
                            DataArray[ 6].x := 80; DataArray[ 6].y := 10;
                            DataArray[ 7].x := 20; DataArray[ 7].y := 10;
                            Count := 8;
                          end;
        itpsCustom      : begin
                            for i := 0 to FCustomList.Count-1 do
                              begin
                                DataArray[i].x := (FCustomList.Objects[i] as TTankCustomPoint).X;
                                DataArray[i].y := (FCustomList.Objects[i] as TTankCustomPoint).Y;
                              end;
                            Count := FCustomList.Count;
                          end;
      end;

      for i := 0 to Count-1 do
        begin
          case FOrientation of
            ioVertical : begin
                           PointArray[i].X := Round(DataArray[i].x*Width /100);
                           PointArray[i].Y := Round(DataArray[i].y*Height/100);
                         end;
            else         begin
                           PointArray[i].X := Round(DataArray[i].y*Width /100);
                           PointArray[i].Y := Round(DataArray[i].x*Height/100);
                         end;
          end;
        end;

      Polygon(Slice(PointArray, Count));

    end;
end;
//****************************************************************************************************************************************************
procedure TiTank.DrawGradientBackGround(Canvas: TCanvas);
var
  Red             : Integer;
  Green           : Integer;
  Blue            : Integer;
  StartRed        : Integer;
  StartGreen      : Integer;
  StartBlue       : Integer;
  StopRed         : Integer;
  StopGreen       : Integer;
  StopBlue        : Integer;
  DrawRect        : TRect;
  RefPoint        : TPoint;
  i               : Integer;
  LastOffset      : Integer;
  Size            : Integer;
  Offset          : Integer;
  Magnitude       : Integer;
  PercentComplete : Double;
  AColor          : TColor;
begin
  with Canvas do
    begin
      DrawRect := Rect(0, 0 ,Width, Height);

      if FAutoTankShadowColor then
        begin
          AColor     := ColorOffset(FTankColor, $40, False);
          StartRed   := (AColor and $0000FF);
          StartGreen := (AColor and $00FF00) shr 8;
          StartBlue  := (AColor and $FF0000) shr 16;

          AColor := ColorOffset(FTankColor, $20, True);

          StopRed    := (AColor and $0000FF);
          StopGreen  := (AColor and $00FF00) shr 8;
          StopBlue   := (AColor and $FF0000) shr 16;
        end
      else
        begin
          AColor     := TankShadowColor;
          StartRed   := (AColor and $0000FF);
          StartGreen := (AColor and $00FF00) shr 8;
          StartBlue  := (AColor and $FF0000) shr 16;

          AColor := ColorOffset(FTankColor, $20, True);

          StopRed    := (AColor and $0000FF);
          StopGreen  := (AColor and $00FF00) shr 8;
          StopBlue   := (AColor and $FF0000) shr 16;
        end;

      Brush.Style := bsClear;

      case FOrientation of
        ioVertical : Size := (DrawRect.Right  - DrawRect.Left) div 2;
        else         Size := (DrawRect.Bottom - DrawRect.Top ) div 2;
      end;

      if Size <> 0 then
        begin
          RefPoint   := Point(Size, Size);
          Pen.Color  := BackGroundColor;
          LastOffset := -1;

          for i := 0 to Size*4 do                 
            begin
              Offset    := Round(Cos(DegToRad(90*i/(Size*4))) * Size);
              Magnitude := Round(Sin(DegToRad(90*i/(Size*4))) * Size);
              if Offset = LastOffset then Continue;
              LastOffset := Offset;

              PercentComplete := i/(Size*4);

              Red   := Round(PercentComplete*StopRed    + (1-PercentComplete)*StartRed  );
              Green := Round(PercentComplete*StopGreen  + (1-PercentComplete)*StartGreen);
              Blue  := Round(PercentComplete*StopBlue   + (1-PercentComplete)*StartBlue );

              Pen.Color := Red + Green shl 8 + Blue shl 16;

              case FOrientation of
                ioVertical : begin
                               Polyline([Point(RefPoint.X + Offset-1, DrawRect.Top    + Size - Magnitude),
                                         Point(RefPoint.X + Offset-1, DrawRect.Bottom - Size + Magnitude)]);
                               Polyline([Point(RefPoint.X - Offset  , DrawRect.Top    + Size - Magnitude),
                                         Point(RefPoint.X - Offset  , DrawRect.Bottom - Size + Magnitude)]);
                             end;
                else         begin
                               Polyline([Point(DrawRect.Left  + Size - Magnitude, RefPoint.Y + Offset-1),
                                         Point(DrawRect.Right - Size + Magnitude, RefPoint.Y + Offset-1)]);
                               Polyline([Point(DrawRect.Left  + Size - Magnitude, RefPoint.Y - Offset  ),
                                         Point(DrawRect.Right - Size + Magnitude, RefPoint.Y - Offset  )]);
                             end;
              end;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiTank.CustomPointsAdd(X, Y: Double): Integer;
var
  TankCustomPoint : TTankCustomPoint;
begin
  TankCustomPoint := TTankCustomPoint.Create;
  TankCustomPoint.X := X;
  TankCustomPoint.Y := Y;
  Result := FCustomList.AddObject('', TankCustomPoint);
end;
//****************************************************************************************************************************************************
procedure TiTank.CustomPointsClear;
begin
  while FCustomList.Count <> 0 do
    begin
      FCustomList.Objects[0].Free;
      FCustomList.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
end.
