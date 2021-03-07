{*******************************************************}
{                                                       }
{       TiLedMatrix Component                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedMatrix;{$endif}
{$ifdef iCLX}unit QiLedMatrix;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes, iGPFunctions,   iCustomComponent, iOPCItem;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;          {$ENDIF}

type
  TClickIndicatorEvent = procedure(Row, Col: Integer) of object;
  
  TLedCacheObject = class(TObject)
  public
    ActiveBitmap   : TBitmap;
    InActiveBitmap : TBitmap;
    Color          : TColor;
    destructor Destroy; override;
  end;

  TLedCache = class(TObject)
  private
    FCacheList : TList;
  public
    constructor Create;
    destructor  Destroy; override;
    function  Find(AColor: TColor) : TLedCacheObject;
    procedure Add(LedCacheObject: TLedCacheObject);
    procedure Clear;
  end;

  TIndicatorData = record
    Color     : TColor;
    Caption   : String[50];
    Active    : Boolean;
    Dirty     : Boolean;
    ARect     : TRect;
    MouseDown : Boolean;
  end;

  PIndicatorList = ^TIndicatorList;

  TIndicatorList = array[0..100000] of TIndicatorData;

  TiLedMatrixIndiatorStyle = (ilmisRound, ilmisRectangle);

  TiLedMatrix = class(TiCustomComponent)
  private
    FLedCache                     : TLedCache;
    FFillBackGround               : Boolean;
    FIndicatorList                : PIndicatorList;
    FIndicatorActiveColor         : TColor;
    FColCount                     : Integer;
    FRowCount                     : Integer;
    FIndicatorStyle               : TiLedMatrixIndiatorStyle;
    FIndicatorHeight              : Integer;
    FIndicatorWidth               : Integer;
    FIndicatorBevelStyle          : TiBevelStyle;
    FSpacingHorizontal            : Integer;
    FOuterMargin                  : Integer;
    FSpacingVertical              : Integer;
    FAutoSize                     : Boolean;
    FOnAutoSize                   : TNotifyEvent;
    FIndicatorCaptionInactiveFont : TFont;
    FIndicatorCaptionActiveFont   : TFont;
    FIndicatorShowReflection      : Boolean;
    FDoingAutoSize                : Boolean;
    FOnMouseUpIndicator           : TClickIndicatorEvent;
    FOnMouseMoveIndicator         : TClickIndicatorEvent;
    FOnMouseDownIndicator         : TClickIndicatorEvent;
    FOnClickIndicator             : TClickIndicatorEvent;
    FOnDblClickIndicator          : TClickIndicatorEvent;

    FClickRow                     : Integer;
    FClickCol                     : Integer;

    procedure SetIndicatorActiveColor(const Value: TColor);
    procedure SetColCount            (const Value: Integer);
    procedure SetRowCount            (const Value: Integer);
    procedure SetIndicatorStyle      (const Value: TiLedMatrixIndiatorStyle);
    procedure SetIndicatorBevelStyle (const Value: TiBevelStyle);
    procedure SetIndicatorHeight     (const Value: Integer);
    procedure SetIndicatorWidth      (const Value: Integer);
    procedure SetOuterMargin         (const Value: Integer);
    procedure SetSpacingHorizontal   (const Value: Integer);
    procedure SetSpacingVertical     (const Value: Integer);
    procedure iSetAutoSize           (const Value: Boolean);
    procedure SetIndicatorActive     (Row, Col: Integer; const Value: Boolean);
    procedure SetIndicatorColor      (Row, Col: Integer; const Value: TColor);
    function GetIndicatorActive      (Row, Col: Integer): Boolean;
    function GetIndicatorColor       (Row, Col: Integer): TColor;
    function GetIndicatorCaption     (Row, Col: Integer): String;
    procedure SetIndicatorCaption    (Row, Col: Integer; const Value: String);
    procedure SetIndicatorCaptionActiveFont  (const Value: TFont);
    procedure SetIndicatorCaptionInactiveFont(const Value: TFont);
    procedure SetIndicatorShowReflection     (const Value: Boolean);
  protected
    function  GetAutoSize : TPoint;
    function  GetLedAtXY(X, Y: Integer): Integer;
    procedure SetTransparent    (const Value: Boolean);                           override;
    procedure SetBackGroundColor(const Value: TColor);                            override;
    procedure SetBorderStyle    (const Value: TiBevelStyle);                      override;
    procedure SetCachedDrawing  (const Value: Boolean);                           override;
    procedure DoAutoSize;
    procedure SetCapacity;
    procedure iPaintTo       (Canvas: TCanvas);                                   override;
    procedure iPaintCached   (Canvas: TCanvas);
    procedure iPaintNonCached(Canvas: TCanvas);
    procedure DrawRound    (Canvas: TCanvas; DrawRect: TRect; Active: Boolean; AColor: TColor);
    procedure DrawRectangle(Canvas: TCanvas; DrawRect: TRect; Active: Boolean; AColor: TColor);
    procedure RedoAll;
    procedure ClearMouseDown;
    procedure iDoKillFocus;
                                                                                   override;
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DblClick; override;

    {$ifdef iVCL}
    procedure UpdateOPCSpecialList;                                                  override;
    function  OPCNewDataSpecial(PropertyName: String; NewData: OleVariant): Boolean; override;
    {$endif}
  public
    constructor Create(AOwner: TComponent);                                        override;
    destructor  Destroy;                                                           override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer);                  override;

    property IndicatorActive [Row, Col: Integer] : Boolean      read GetIndicatorActive  write SetIndicatorActive;
    property IndicatorColor  [Row, Col: Integer] : TColor       read GetIndicatorColor   write SetIndicatorColor;
    property IndicatorCaption[Row, Col: Integer] : String       read GetIndicatorCaption write SetIndicatorCaption;
    property OnAutoSize                          : TNotifyEvent read FOnAutoSize         write FOnAutoSize;
  published
    property AutoSize                     : Boolean                  read FAutoSize                     write iSetAutoSize                    default True;
    property IndicatorActiveColor         : TColor                   read FIndicatorActiveColor         write SetIndicatorActiveColor         default clLime;
    property ColCount                     : Integer                  read FColCount                     write SetColCount                     default 5;
    property RowCount                     : Integer                  read FRowCount                     write SetRowCount                     default 5;
    property IndicatorStyle               : TiLedMatrixIndiatorStyle read FIndicatorStyle               write SetIndicatorStyle               default ilmisRectangle;
    property IndicatorWidth               : Integer                  read FIndicatorWidth               write SetIndicatorWidth               default 10;
    property IndicatorHeight              : Integer                  read FIndicatorHeight              write SetIndicatorHeight              default 10;
    property IndicatorBevelStyle          : TiBevelStyle             read FIndicatorBevelStyle          write SetIndicatorBevelStyle          default ibsNone;
    property IndicatorCaptionActiveFont   : TFont                    read FIndicatorCaptionActiveFont   write SetIndicatorCaptionActiveFont;
    property IndicatorCaptionInactiveFont : TFont                    read FIndicatorCaptionInactiveFont write SetIndicatorCaptionInactiveFont;
    property OuterMargin                  : Integer                  read FOuterMargin                  write SetOuterMargin                  default 5;
    property SpacingHorizontal            : Integer                  read FSpacingHorizontal            write SetSpacingHorizontal            default 2;
    property SpacingVertical              : Integer                  read FSpacingVertical              write SetSpacingVertical              default 2;
    property IndicatorShowReflection      : Boolean                  read FIndicatorShowReflection      write SetIndicatorShowReflection      default True;

    property OnMouseDownIndicator         : TClickIndicatorEvent     read FOnMouseDownIndicator         write FOnMouseDownIndicator;
    property OnMouseMoveIndicator         : TClickIndicatorEvent     read FOnMouseMoveIndicator         write FOnMouseMoveIndicator;
    property OnMouseUpIndicator           : TClickIndicatorEvent     read FOnMouseUpIndicator           write FOnMouseUpIndicator;
    property OnClickIndicator             : TClickIndicatorEvent     read FOnClickIndicator             write FOnClickIndicator;
    property OnDblClickIndicator          : TClickIndicatorEvent     read FOnDblClickIndicator          write FOnDblClickIndicator;

    property BackGroundColor;
    property BorderStyle;
    property Transparent;
    property CachedDrawing;
    property Width  default 150;
    property Height default 150;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiLedMatrix.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 150;
  Height := 150;

  FIndicatorActiveColor    := clLime;
  FIndicatorShowReflection := True;
  FColCount                := 5;
  FRowCount                := 5;
  FAutoSize                := True;

  FOuterMargin             := 5;

  FIndicatorWidth          := 10;
  FIndicatorHeight         := 10;

  FIndicatorStyle          := ilmisRectangle;

  FSpacingHorizontal       := 2;
  FSpacingVertical         := 2;

  SetCapacity;

  FIndicatorCaptionActiveFont            := TFont.Create;
  FIndicatorCaptionActiveFont.OnChange   := BackGroundChangeEvent;

  FIndicatorCaptionInactiveFont          := TFont.Create;
  FIndicatorCaptionInactiveFont.OnChange := BackGroundChangeEvent;
  FIndicatorCaptionInactiveFont.Color    := clWhite;

  FLedCache := TLedCache.Create;
end;
//****************************************************************************************************************************************************
destructor TiLedMatrix.Destroy;
begin
  FIndicatorCaptionActiveFont.Free;
  FIndicatorCaptionInactiveFont.Free;

  FLedCache.Free;
  FreeMem(FIndicatorList);
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if FAutoSize and not FDoingAutoSize then
    begin
      IndicatorWidth  := Trunc((AWidth  - 2*FOuterMargin)/FColCount) - FSpacingHorizontal;
      IndicatorHeight := Trunc((AHeight - 2*FOuterMargin)/FRowCount) - FSpacingVertical;
    end;
  RedoAll;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetIndicatorCaptionActiveFont  (const Value: TFont);begin FIndicatorCaptionActiveFont.Assign(Value);  end;
procedure TiLedMatrix.SetIndicatorCaptionInactiveFont(const Value: TFont);begin FIndicatorCaptionInactiveFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetBackGroundColor(const Value: TColor);
begin
  inherited;
  RedoAll;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetBorderStyle(const Value: TiBevelStyle);
begin
  inherited;
  RedoAll;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.RedoAll;
var
  Row, Col : Integer;
begin
  if Assigned(FIndicatorList) then
    begin
      for Row := 0 to FRowCount -1 do
        for Col := 0 to FColCount - 1 do
          FIndicatorList^[Col + Row*ColCount].Dirty  := True;
    end;
  if Assigned(FLedCache) then FLedCache.Clear;
  FFillBackGround := True;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetCapacity;
var
  Col, Row : Integer;
begin
  if ((FRowCount * FColCount) > MaxListSize) then Exception.Create('Exceed Maximum Matrix Size');

  ReallocMem(FIndicatorList, FRowCount * FColCount * SizeOf(TIndicatorData));
  for Col := 0 to FColCount -1 do
    for Row := 0 to FRowCount - 1 do
      begin
        FIndicatorList^[Col + Row*ColCount].Active  := False;
        FIndicatorList^[Col + Row*ColCount].Color   := FIndicatorActiveColor;
        FIndicatorList^[Col + Row*ColCount].Dirty   := True;
        FIndicatorList^[Col + Row*ColCount].Caption := '';
      end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.iDoKillFocus;
begin
  inherited;
  ClearMouseDown;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.ClearMouseDown;
var
  x : Integer;
begin
  for x := 0 to (ColCount*RowCount)-1 do
    FIndicatorList^[x].MouseDown := False;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Index : Integer;
  Row   : Integer;
  Col   : Integer;
begin
  inherited;
  Index := GetLedAtXY(X, Y);

  if Index <> -1 then
    begin
      FIndicatorList^[Index].MouseDown := True;
      Row := Index div ColCount;
      Col := Index mod ColCount;
      if Assigned(FOnMouseDownIndicator) then FOnMouseDownIndicator(Row, Col);
    end;

end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.iMouseMove(Shift: TShiftState; X, Y: Integer);
var
  Index : Integer;
  Row   : Integer;
  Col   : Integer;
begin
  inherited;
  Index := GetLedAtXY(X, Y);

  if Index <> -1 then
    begin
      Row := Index div ColCount;
      Col := Index mod ColCount;
      if Assigned(FOnMouseMoveIndicator) then FOnMouseMoveIndicator(Row, Col);
    end;

end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Index : Integer;
  Row   : Integer;
  Col   : Integer;
begin
  inherited;

  Index := GetLedAtXY(X, Y);

  if Index <> -1 then if FIndicatorList^[Index].MouseDown then
    begin
      Row := Index div ColCount;
      Col := Index mod ColCount;

      FClickRow := Row;
      FClickCol := Col;

      if Assigned(FOnMouseUpIndicator) then FOnMouseUpIndicator(Row, Col);
      if Assigned(FOnClickIndicator)   then FOnClickIndicator  (Row, Col);
      BackGroundChange;
    end
  else
    begin
      FClickRow := -1;
      FClickCol := -1
    end;

  ClearMouseDown;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.DblClick;
begin
  inherited;
  if (FClickRow <> - 1) and (FClickCol <> -1) then
    begin
      if Assigned(FOnDblClickIndicator) then FOnDblClickIndicator(FClickRow, FClickCol);
    end;
end;
//****************************************************************************************************************************************************
function TiLedMatrix.GetLedAtXY(X, Y: Integer): Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to (ColCount*RowCount)-1 do
    begin
      if PtInRect(FIndicatorList^[i].ARect, Point(X, Y)) then
        begin
          Result := i;
          Exit;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiLedMatrix.GetIndicatorActive(Row, Col: Integer): Boolean;
begin
  if (Row < 0) or (Row >= FRowCount) or (Col < 0) or (Col >= FColCount) then raise Exception.Create('Index out of bounds');
  Result := FIndicatorList^[Col + Row*ColCount].Active;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetIndicatorActive(Row, Col: Integer; const Value: Boolean);
begin
  if (Row < 0) or (Row >= FRowCount) or (Col < 0) or (Col >= FColCount) then raise Exception.Create('Index out of bounds');
  FIndicatorList^[Col + Row*ColCount].Active := Value;
  FIndicatorList^[Col + Row*ColCount].Dirty  := True;
  BackGroundChange;
end;
//****************************************************************************************************************************************************
function TiLedMatrix.GetIndicatorColor(Row, Col: Integer): TColor;
begin
  if (Row < 0) or (Row >= FRowCount) or (Col < 0) or (Col >= FColCount) then raise Exception.Create('Index out of bounds');
  Result := FIndicatorList^[Col + Row*ColCount].Color;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetIndicatorColor(Row, Col: Integer; const Value: TColor);
begin
  if (Row < 0) or (Row >= FRowCount) or (Col < 0) or (Col >= FColCount) then raise Exception.Create('Index out of bounds');
  FIndicatorList^[Col + Row*ColCount].Color := Value;
  FIndicatorList^[Col + Row*ColCount].Dirty := True;
  BackGroundChange;
end;
//****************************************************************************************************************************************************
function TiLedMatrix.GetIndicatorCaption(Row, Col: Integer): String;
begin
  if (Row < 0) or (Row >= FRowCount) or (Col < 0) or (Col >= FColCount) then raise Exception.Create('Index out of bounds');
  Result := FIndicatorList^[Col + Row*ColCount].Caption;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetIndicatorCaption(Row, Col: Integer; const Value: String);
begin
  if Length(Value) > 50                                                 then raise Exception.Create('Caption must be 50 or less characters');
  if (Row < 0) or (Row >= FRowCount) or (Col < 0) or (Col >= FColCount) then raise Exception.Create('Index out of bounds');
  FIndicatorList^[Col + Row*ColCount].Caption := Value;
  FIndicatorList^[Col + Row*ColCount].Dirty := True;
  BackGroundChange;
end;
//****************************************************************************************************************************************************
function TiLedMatrix.GetAutoSize: TPoint;
begin
  Result.x  := 2*FOuterMargin + FColCount*(FIndicatorWidth + FSpacingHorizontal);
  Result.y := 2*FOuterMargin + FRowCount*(FIndicatorHeight + FSpacingVertical);

  if Result.X > 3600 then Result.X := 3600;
  if Result.Y > 2880 then Result.Y := 2880;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.DoAutoSize;
var
  NewSize : TPoint;
begin
  if FDoingAutoSize then exit;
  if FAutoSize then
    begin
      FDoingAutoSize := True;
      try
        NewSize := GetAutoSize;
        Width  := NewSize.x;
        Height := NewSize.y;
        if Assigned(FOnAutoSize) then FOnAutoSize(Self);
      finally
        FDoingAutoSize := False;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetTransparent(const Value: Boolean);
begin
  inherited;
  RedoAll;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      DoAutoSize;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetColCount(const Value: Integer);
begin
  if Value < 1 then exit;
  if FColCount <> Value then
    begin
      FColCount := Value;
      SetCapacity;
      RedoAll;
      if not Loading then DoAutoSize;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetRowCount(const Value: Integer);
begin
  if Value < 1 then exit;
  if FRowCount <> Value then
    begin
      FRowCount := Value;
      SetCapacity;
      RedoAll;
      if not Loading then DoAutoSize;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetIndicatorStyle(const Value: TiLedMatrixIndiatorStyle);
begin
  if FIndicatorStyle <> Value then
    begin
      FIndicatorStyle := Value;
      if FIndicatorHeight <> FIndicatorWidth then FIndicatorHeight := FIndicatorWidth;
      RedoAll;
      BackGroundChange;
      DoAutoSize;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetIndicatorBevelStyle(const Value: TiBevelStyle);
begin
  if FIndicatorBevelStyle <> Value then
    begin
      FIndicatorBevelStyle := Value;
      RedoAll;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetIndicatorHeight(const Value: Integer);
begin
  if FIndicatorHeight <> Value then
    begin
      FIndicatorHeight := Value;
      if FIndicatorStyle = ilmisRound then FIndicatorWidth := Value;
      RedoAll;
      BackGroundChange;
      DoAutoSize;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetIndicatorWidth(const Value: Integer);
begin
  if FIndicatorWidth <> Value then
    begin
      FIndicatorWidth := Value;
      if FIndicatorStyle = ilmisRound then FIndicatorHeight := Value;
      RedoAll;
      BackGroundChange;
      DoAutoSize;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetIndicatorShowReflection(const Value: Boolean);
begin
  if FIndicatorShowReflection <> Value then
    begin
      FIndicatorShowReflection := Value;
      RedoAll;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetIndicatorActiveColor(const Value: TColor);
var
  Row, Col : Integer;
begin
   if FIndicatorActiveColor <> Value then
    begin
      FIndicatorActiveColor := Value;
      for Row := 0 to FRowCount -1 do
        for Col := 0 to FColCount - 1 do
          FIndicatorList^[Col + Row*ColCount].Color  := Value;
      RedoAll;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetOuterMargin(const Value: Integer);
begin
  if FOuterMargin <> Value then
    begin
      FOuterMargin := Value;
      RedoAll;
      DoAutoSize;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetSpacingHorizontal(const Value: Integer);
begin
  if FSpacingHorizontal <> Value then
    begin
      FSpacingHorizontal := Value;
      RedoAll;
      DoAutoSize;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetSpacingVertical(const Value: Integer);
begin
  if FSpacingVertical <> Value then
    begin
      FSpacingVertical := Value;
      RedoAll;
      DoAutoSize;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.SetCachedDrawing(const Value: Boolean);
begin
  inherited;
  RedoAll;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.iPaintTo(Canvas: TCanvas);
begin
  if (FIndicatorWidth < 1) or (FIndicatorHeight < 1) then Exit;

  if CachedDrawing then iPaintCached(Canvas) else iPaintNonCached(Canvas);
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.iPaintCached(Canvas: TCanvas);
var
  Row, Col       : Integer;
  CurrentLeft    : Integer;
  CurrentTop     : Integer;
  ARect          : TRect;
  TempRect       : TRect;
  LedCacheObject : TLedCacheObject;
  IndicatorData  : TIndicatorData;
  CenterY        : Integer;
  ATextHeight    : Integer;
begin
  if BackGroundChanged then
    begin
      CreateBackGroundBitmap;
      with BackGroundBitmap, BackGroundBitmap.Canvas do
        begin
          if FFillBackGround then
            begin
              DrawBackGround(BackGroundBitmap.Canvas, BackGroundColor);
              FFillBackGround := False;
            end;

            CurrentLeft := (Width - (FIndicatorWidth + FSpacingHorizontal)*FColCount) div 2 + 1;

            for Col := 0 to FColCount - 1 do
            begin
              CurrentTop := (Height - (FIndicatorHeight + FSpacingVertical)*FRowCount) div 2 + 1;
              for Row := 0 to FRowCount - 1 do
                begin
                  ARect := Rect(CurrentLeft, CurrentTop, CurrentLeft + FIndicatorWidth, CurrentTop + FIndicatorHeight);
                  FIndicatorList^[Col + Row*ColCount].ARect := ARect;
                  IndicatorData := FIndicatorList^[Col + Row*ColCount];
                  if IndicatorData.Dirty then
                    begin
                      if not Transparent and (FIndicatorStyle <> ilmisRound) then
                        begin
                          LedCacheObject := FLedCache.Find(IndicatorData.Color);
                          if not Assigned(LedCacheObject) then
                            begin
                              ARect := Rect(0, 0, FIndicatorWidth, FIndicatorHeight);

                              LedCacheObject                     := TLedCacheObject.Create;
                              LedCacheObject.Color               := IndicatorData.Color;
                              LedCacheObject.ActiveBitmap        := TBitmap.Create;
                              LedCacheObject.ActiveBitmap.Width  := FIndicatorWidth;
                              LedCacheObject.ActiveBitmap.Height := FIndicatorHeight;

                              case FIndicatorStyle of
                                ilmisRound     : DrawRound    (LedCacheObject.ActiveBitmap.Canvas, ARect, True, IndicatorData.Color);
                                ilmisRectangle : DrawRectangle(LedCacheObject.ActiveBitmap.Canvas, ARect, True, IndicatorData.Color);
                              end;
                              LedCacheObject.InactiveBitmap        := TBitmap.Create;
                              LedCacheObject.InactiveBitmap.Width  := FIndicatorWidth;
                              LedCacheObject.InactiveBitmap.Height := FIndicatorHeight;

                              case FIndicatorStyle of
                                ilmisRound     : DrawRound    (LedCacheObject.InactiveBitmap.Canvas, ARect, False, IndicatorData.Color);
                                ilmisRectangle : DrawRectangle(LedCacheObject.InactiveBitmap.Canvas, ARect, False, IndicatorData.Color);
                              end;
                              FLedCache.Add(LedCacheObject);
                            end;

                          case IndicatorData.Active of
                            False : BackGroundBitmap.Canvas.Draw(CurrentLeft, CurrentTop, LedCacheObject.InactiveBitmap);
                            True  : BackGroundBitmap.Canvas.Draw(CurrentLeft, CurrentTop, LedCacheObject.ActiveBitmap);
                          end;
                        end
                      else
                        DrawRound(BackGroundBitmap.Canvas, Rect(CurrentLeft,CurrentTop,CurrentLeft+FIndicatorWidth,CurrentTop+FIndicatorWidth), IndicatorData.Active, IndicatorData.Color);

                      if Trim(IndicatorData.Caption) <> '' then
                        begin
                          case IndicatorData.Active of
                            False : Font.Assign(FIndicatorCaptionInactiveFont);
                            True  : Font.Assign(FIndicatorCaptionActiveFont);
                          end;

                          Brush.Style := bsClear;
                          ARect       := Rect(CurrentLeft+1, CurrentTop+1, CurrentLeft + FIndicatorWidth-1, CurrentTop + FIndicatorHeight-1);

                          CenterY := (ARect.Bottom + ARect.Top) div 2;

                          TempRect := ARect;
                          ATextHeight := iDrawText(Canvas, IndicatorData.Caption, TempRect, [itfHCenter, itfVTop, itfNoClip, itfCalcRect], True, BackGroundColor);

                          ARect.Top    := CenterY               - ATextHeight div 2;
                          ARect.Bottom := CenterY + ATextHeight - ATextHeight div 2;

                          iDrawText(Canvas, IndicatorData.Caption, ARect, [itfHCenter, itfVCenter], True, BackGroundColor);
                        end;

                      FIndicatorList^[Col + Row*ColCount].Dirty := False;
                    end;
                   CurrentTop := CurrentTop + FIndicatorHeight + FSpacingVertical;
                end;
              CurrentLeft := CurrentLeft + FIndicatorWidth + FSpacingHorizontal;
            end;
        end;
      ResetBackGroundChange;
    end;
  TransferBackGround(Canvas);
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.iPaintNonCached(Canvas: TCanvas);
var
  Row, Col      : Integer;
  CurrentLeft   : Integer;
  CurrentTop    : Integer;
  ARect         : TRect;
  TempRect      : TRect;
  IndicatorData : TIndicatorData;
  CenterY       : Integer;
  ATextHeight   : Integer;
begin
  DrawBackGround(Canvas, BackGroundColor);

  with Canvas do
    begin
      CurrentLeft := (Width - (FIndicatorWidth + FSpacingHorizontal)*FColCount) div 2 + 1;

      for Col := 0 to FColCount - 1 do
        begin
          CurrentTop := (Height - (FIndicatorHeight + FSpacingVertical)*FRowCount) div 2 + 1;
          for Row := 0 to FRowCount - 1 do
            begin
              ARect := Rect(CurrentLeft, CurrentTop, CurrentLeft + FIndicatorWidth, CurrentTop + FIndicatorHeight);

              FIndicatorList^[Col + Row*ColCount].ARect := ARect;

              IndicatorData := FIndicatorList^[Col + Row*ColCount];

              case FIndicatorStyle of
                ilmisRound     : DrawRound    (Canvas, ARect, IndicatorData.Active, IndicatorData.Color);
                ilmisRectangle : DrawRectangle(Canvas, ARect, IndicatorData.Active, IndicatorData.Color);
              end;

              if Trim(IndicatorData.Caption) <> '' then
                begin
                  case IndicatorData.Active of
                    False : Font.Assign(FIndicatorCaptionInactiveFont);
                    True  : Font.Assign(FIndicatorCaptionActiveFont);
                  end;

                  Brush.Style := bsClear;
                  ARect       := Rect(CurrentLeft+1, CurrentTop+1, CurrentLeft + FIndicatorWidth-1, CurrentTop + FIndicatorHeight-1);

                  CenterY := (ARect.Bottom + ARect.Top) div 2;

                  TempRect := ARect;
                  ATextHeight := iDrawText(Canvas, IndicatorData.Caption, TempRect, [itfHCenter, itfVTop, itfNoClip, itfCalcRect], True, BackGroundColor);

                  ARect.Top    := CenterY               - ATextHeight div 2;
                  ARect.Bottom := CenterY + ATextHeight - ATextHeight div 2;

                  iDrawText(Canvas, IndicatorData.Caption, ARect, [itfHCenter, itfVCenter], True, BackGroundColor);
                end;
               CurrentTop := CurrentTop + FIndicatorHeight + FSpacingVertical;
            end;
          CurrentLeft := CurrentLeft + FIndicatorWidth + FSpacingHorizontal;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.DrawRectangle(Canvas: TCanvas; DrawRect: TRect; Active: Boolean; AColor: TColor);
begin
  with Canvas, DrawRect do
    begin
      if Active then
        begin
          Brush.Color := AColor;
          Pen.Color   := AColor;
        end
      else
        begin
          Brush.Color := DimColor(AColor, 3);
          Pen.Color   := DimColor(AColor, 3);
        end;

      Brush.Style := bsSolid;
      Pen.Style   := psSolid;

      Rectangle(Left, Top, Right, Bottom);

      case FIndicatorBevelStyle of
        ibsLowered : iDrawEdge(Canvas, Rect(Left, Top, Right, Bottom), idesSunken);
        ibsRaised  : iDrawEdge(Canvas, Rect(Left, Top, Right, Bottom), idesRaised);
      end;

      if FIndicatorShowReflection then
        begin
          if Active then Pen.Color := clWhite else Pen.Color := AColor;
          Polyline([Point(Left+3, Top+3), Point(Left+5, Top+3)]);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.DrawRound(Canvas: TCanvas; DrawRect: TRect; Active: Boolean; AColor: TColor);
var
  {$ifdef iVCL}
  SizeDiv2 : Integer;
  {$endif}
  SizeDiv4 : Integer;
  ARect    : TRect;
begin
  with Canvas do
    begin
      if Active then
        begin
          Brush.Color := AColor;
          Pen.Color   := AColor;
        end
      else
        begin
          Brush.Color := DimColor(AColor, 3);
          Pen.Color   := DimColor(AColor, 3);
        end;

      Brush.Style := bsSolid;
      Pen.Style   := psSolid;

      {$ifdef iVCL}
      SizeDiv2 := FIndicatorWidth div 2;
      {$endif}
      SizeDiv4 := FIndicatorWidth div 4;

      with DrawRect do
        begin
          Ellipse(Left, Top, Right, Bottom);

          if FIndicatorShowReflection then
            begin
              if Active then Pen.Color := clWhite else Pen.Color := AColor;

              {$ifdef iVCL}
              Arc(Left + SizeDiv4,  Top + SizeDiv4,  Right - SizeDiv4,  Bottom - SizeDiv4,  Right - SizeDiv2,Top,Left,Bottom - SizeDiv2);
              Arc(Left + SizeDiv4+1,Top + SizeDiv4+1,Right - SizeDiv4-1,Bottom - SizeDiv4-1,Right - SizeDiv2,Top,Left,Bottom - SizeDiv2);
              {$endif}
              {$ifdef iCLX}
              ARect := Rect(Left + SizeDiv4,  Top + SizeDiv4,  Right - SizeDiv4,  Bottom - SizeDiv4);
              Arc(ARect.Left,  ARect.Top,  ARect.Right - ARect.Left,  ARect.Bottom - ARect.Top, 90*16, 90*16);

              InflateRect(ARect, 1, 1);
              Arc(ARect.Left,  ARect.Top,  ARect.Right - ARect.Left,  ARect.Bottom - ARect.Top, 90*16, 90*16);
              {$endif}
            end;

          case FIndicatorBevelStyle of
            ibsLowered :   begin
                             Pen.Color := clBtnShadow;
                             Arc(Left,   Top,   Right,   Bottom,   Right,   Top,   Left,   Bottom);
                             Arc(Left+1, Top+1, Right-1, Bottom-1, Right-1, Top+1, Left+1, Bottom-1);

                             Pen.Color := clBtnHighlight;
                             Arc(Left,   Top,   Right,   Bottom,   Left,   Bottom,   Right,   Top);
                             Arc(Left+1, Top+1, Right-1, Bottom-1, Left+1, Bottom-1, Right-1, Top+1);
                           end;
            ibsRaised    : begin
                             Pen.Color := clBtnHighlight;
                             Arc(Left,   Top,   Right,   Bottom,   Right,   Top,   Left,   Bottom);
                             Arc(Left+1, Top+1, Right-1, Bottom-1, Right-1, Top+1, Left+1, Bottom-1);

                             Pen.Color := clBtnShadow;
                             Arc(Left,   Top,   Right,   Bottom,   Left,   Bottom,   Right,   Top);
                             Arc(Left+1, Top+1, Right-1, Bottom-1, Left+1, Bottom-1, Right-1, Top+1);
                           end;
          end;
        end;
    end;
end;
//****************************************************************************************************************************************************
{ TLedCache }
//****************************************************************************************************************************************************
constructor TLedCache.Create;
begin
  inherited;
  FCacheList := TList.Create;
end;
//****************************************************************************************************************************************************
destructor TLedCache.Destroy;
begin
  Clear;
  FCacheList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TLedCache.Clear;
begin
  while FCacheList.Count > 0 do
    begin
      TLedCacheObject(FCacheList.Items[0]).Free;
      FCacheList.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
procedure TLedCache.Add(LedCacheObject: TLedCacheObject);
begin
  if FCacheList.Count = 10 then
    begin
      TObject(FCacheList.Items[0]).Free;
      FCacheList.Delete(0);
    end;
  FCacheList.Add(LedCacheObject);
end;
//****************************************************************************************************************************************************
function TLedCache.Find(AColor: TColor): TLedCacheObject;
var
  x : Integer;
begin
  Result := nil;
  for x := 0 to FCacheList.Count -1 do
    begin
      if TLedCacheObject(FCacheList.Items[x]).Color = AColor then
        begin
          Result := TLedCacheObject(FCacheList.Items[x]);
          Break;
        end;
    end;
end;
//****************************************************************************************************************************************************
{ TLedCacheObject }
destructor TLedCacheObject.Destroy;
begin
  ActiveBitmap.Free;
  InActiveBitmap.Free;
  inherited;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
function TiLedMatrix.OPCNewDataSpecial(PropertyName: String; NewData: OleVariant): Boolean;
var
  x : Integer;
begin
  Result := inherited OPCNewDataSpecial(PropertyName, NewData);

  for x := 0 to ColCount*RowCount-1 do
    if UpperCase('Row(' + IntToStr(x div ColCount) + ')Col(' + IntToStr(x mod ColCount) + ').Active') = UpperCase(PropertyName) then
      begin
        Result := True;
        IndicatorActive[x div ColCount, x mod ColCount] := NewData;
      end;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrix.UpdateOPCSpecialList;
var
  x : Integer;
begin
  if not Assigned(OPCSpecialList) then Exit;
  OPCSpecialList.Clear;
  for x := 0 to ColCount*RowCount-1 do
    OPCSpecialList.Add('Row(' + IntToStr(x div ColCount) + ')Col(' + IntToStr(x mod ColCount) + ').Active');
end;
{$endif}
//****************************************************************************************************************************************************
end.
