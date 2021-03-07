{*******************************************************}
{                                                       }
{       TiRotationDisplay Component                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iRotationDisplay;{$endif}
{$ifdef iCLX}unit QiRotationDisplay;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent;{$ENDIF}

type
  TiRotationDisplay = class(TiCustomComponent)
  private
    FPicture        : TBitmap;
    FRotationBitmap : TBitmap;
    FRotationAngle  : Double;
    FAutoSize       : Boolean;
    FOnAutoSize     : TNotifyEvent;
    FStretched      : Boolean;

    procedure SetPicture      (const Value: TBitmap);
    procedure SetRotationAngle(const Value: Double);
    procedure SetStretched    (const Value: Boolean);
    function  RotateBitmap    (const Bitmap: TBitmap; const Angle: Double): TBitmap;
    procedure iSetAutoSize    (const Value: Boolean);

    procedure DoAutoSize;
    procedure SetUpRotationBitmap;
    procedure ClearRotationBitmap;
    function  GetMaxSize : Integer;
  protected
    procedure iPaintTo(Canvas: TCanvas);                          override;
    procedure BitmapChange      (Sender : TObject);
    procedure SetBackGroundColor(const Value: TColor);            override;
  public
    constructor Create(AOwner: TComponent);                       override;
    destructor  Destroy;                                          override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property OnAutoSize        : TNotifyEvent read FOnAutoSize    write FOnAutoSize;
  published
    property Picture           : TBitmap      read FPicture       write SetPicture;
    property RotationAngle     : Double       read FRotationAngle write SetRotationAngle;
    property AutoSize          : Boolean      read FAutoSize      write iSetAutoSize      default False;
    property Stretched         : Boolean      read FStretched     write SetStretched      default False;
    property BorderStyle;
    property BackGroundColor;
    property CachedDrawing;
    property Width            default 100;
    property Height           default 100;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiRotationDisplay.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 100;
  Height := 100;
  
  FPicture          := TBitmap.Create;
  FRotationBitmap   := TBitmap.Create;

  FAutoSize         := False;
  FPicture.OnChange := BitmapChange;
end;
//****************************************************************************************************************************************************
destructor TiRotationDisplay.Destroy;
begin
  FPicture.Free;
  FRotationBitmap.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplay.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if HandleAllocated then
    begin
      if FAutoSize then
        begin
          if GetMaxSize <> 0 then
            begin
              AWidth  := GetMaxSize;
              AHeight := GetMaxSize;
            end;
        end;
      if Assigned(FRotationBitmap) then ClearRotationBitmap;
    end;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplay.ClearRotationBitmap;
begin
  FRotationBitmap.Width  := 0;
  FRotationBitmap.Height := 0;
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplay.SetUpRotationBitmap;
var
  MaxSize : Integer;
begin
  FPicture.Transparent := True;

  MaxSize := GetMaxSize;
  if MaxSize > 0 then
    begin
      FRotationBitmap.Width  := MaxSize;
      FRotationBitmap.Height := MaxSize;

      FRotationBitmap.Canvas.Brush.Color := BackGroundColor;
      FRotationBitmap.Canvas.FillRect(Rect(0, 0, FRotationBitmap.Width, FRotationBitmap.Height));
      FRotationBitmap.Canvas.Draw(FRotationBitmap.Width  div 2 - FPicture.Width  div 2,
                                  FRotationBitmap.Height div 2 - FPicture.Height div 2,
                                  FPicture);
    end
  else ClearRotationBitmap;
end;
//****************************************************************************************************************************************************
function TiRotationDisplay.GetMaxSize: Integer;
begin
  Result := Round(Sqrt(Sqr(FPicture.Width) + Sqr(FPicture.Height)));
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplay.SetBackGroundColor(const Value: TColor);
begin
  inherited;
  ClearRotationBitmap;
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplay.SetStretched(const Value:Boolean);begin SetBooleanProperty(Value, FStretched, irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiRotationDisplay.DoAutoSize;
begin
  if FAutoSize then
    begin
      if GetMaxSize <> 0 then
        begin
          Width  := GetMaxSize;
          Height := GetMaxSize;
        end;
      if Assigned(FOnAutoSize) then FOnAutoSize(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplay.SetPicture(const Value: TBitmap);
begin
  FPicture.Assign(Value);
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplay.BitmapChange(Sender: TObject);
begin
  ClearRotationBitmap;
  DoAutoSize;
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplay.SetRotationAngle(const Value: Double);
var
  CanEdit : Boolean;
begin
  if FRotationAngle <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'RotationAngle', CanEdit);
      if CanEdit then
        begin
          FRotationAngle := Value;
          BackGroundChange;
          if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'RotationAngle');
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplay.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      BackGroundChange;
      DoAutoSize;
    end;
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplay.iPaintTo(Canvas: TCanvas);
var
  RotatedBitmap : TBitmap;
begin
  if FRotationBitmap.Width = 0 then SetUpRotationBitmap;

  if CachedDrawing then
    begin
      if BackGroundChanged then
        begin
          CreateBackGroundBitmap;

          DrawBackGround(BackGroundBitmap.Canvas, BackGroundColor);

          if FRotationBitmap.Width > 0 then
            begin
              RotatedBitmap := RotateBitmap(FRotationBitmap, FRotationAngle/360 * 2*Pi);
              try
                if FStretched then
                  BackGroundBitmap.Canvas.StretchDraw(ClientRect, RotatedBitmap)
                else
                  BackGroundBitmap.Canvas.Draw(Width  div 2 - RotatedBitmap.Width  div 2,
                                               Height div 2 - RotatedBitmap.Height div 2,
                                               RotatedBitmap);
              finally
                RotatedBitmap.Free;
              end;
            end;

          DrawBorder(BackGroundBitmap.Canvas);
          ResetBackGroundChange;
        end;
      TransferBackGround(Canvas);
    end
  else
    begin
      DrawBackGround(Canvas, BackGroundColor);

      if FRotationBitmap.Width > 0 then
        begin
          RotatedBitmap := RotateBitmap(FRotationBitmap, FRotationAngle/360 * 2*Pi);
          try
            if FStretched then
              Canvas.StretchDraw(ClientRect, RotatedBitmap)
            else
              Canvas.Draw(Width  div 2 - RotatedBitmap.Width  div 2,
                          Height div 2 - RotatedBitmap.Height div 2,
                          RotatedBitmap);
          finally
            RotatedBitmap.Free;
          end;
        end;

      DrawBorder(Canvas);
    end;
end;
//****************************************************************************************************************************************************
function TiRotationDisplay.RotateBitmap(const Bitmap : TBitmap; const Angle : Double): TBitmap;
var
  SinAngle        : Extended;
  CosAngle        : Extended;
  x               : Integer;
  y               : Integer;
  OriginalX       : Integer;
  OriginalY       : Integer;
  NewX            : Integer;
  NewY            : Integer;
  //KYLIX TODO
  {$ifndef iCLX}
  RowOriginal     : pRGBTripleArray;
  RowRotated      : pRGBTRipleArray;
  {$endif}
  CenterPoint     : TPoint;
  NewYSinAngle    : Double;
  NewYCosAngle    : Double;
begin
  //KYLIX TODO
  {$ifndef iCLX}
  Bitmap.PixelFormat := pf24bit;
  {$endif}
  Result             := TBitmap.Create;
  Result.Width       := Bitmap.Width;
  Result.Height      := Bitmap.Height;
  //KYLIX TODO
  {$ifndef iCLX}
  Result.PixelFormat := pf24bit;
  {$endif}

  Result.Canvas.Brush.Color := BackGroundColor;
  Result.Canvas.FillRect(Rect(0,0,Result.Width, Result.Height));

  CenterPoint := Point(Bitmap.Width div 2, Bitmap.Height div 2);

  SinCos(Angle, SinAngle, CosAngle);

  for y := Result.Height-1 downto 0 do
    begin
      //KYLIX TODO
      {$ifndef iCLX}
      RowRotated := Result.Scanline[y];
      {$endif}
      NewY       := y - CenterPoint.Y;

      NewYSinAngle := NewY * SinAngle;
      NewYCosAngle := NewY * CosAngle;

      for x := Result.Width-1 downto 0 do
      begin
        NewX := x - CenterPoint.X;
        OriginalX := CenterPoint.X + Round(NewX * CosAngle - NewYSinAngle);
        OriginalY := CenterPoint.Y + Round(NewX * SinAngle + NewYCosAngle);

        if (OriginalX >= 0) and (OriginalX <= (Result.Width -1)) and (OriginalY >= 0) and (OriginalY <= (Result.Height-1)) then
          begin
            //KYLIX TODO
            {$ifndef iCLX}
            RowOriginal   := Bitmap.Scanline[OriginalY];
            RowRotated[x] := RowOriginal[OriginalX]
            {$endif}
          end;
      end;
    end;
end;
//****************************************************************************************************************************************************
end.
