{*******************************************************}
{                                                       }
{       TiPlotAnnotation                                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotAnnotation;{$endif}
{$ifdef iCLX}unit QiPlotAnnotation;{$endif}

interface
                                                                      
uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iPlotObjects,  iPlotDataView,  iPlotChannelCustom,  iPlotAxis,  iMath,  ImgList;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiPlotObjects, QiPlotDataView, QiPlotChannelCustom, QiPlotAxis, QiMath, QImgList;{$ENDIF}

type
  TiPlotReferenceType         = (iprtDataView, iprtChannel, iprtXChannelYDataView, iprtXDataViewYChannel);
  TiPlotReferenceIndividual   = (ipriDataView, ipriChannel, ipriAuto);
  TiPlotReferenceAnchor       = (ipraDataView, ipraChannel);
  TiPlotAnnotationStyle       = (ipasText, ipasLine, ipasRectangle, ipasLineX, ipasLineY, ipasImage, ipasTextRectangle, ipasEllipse, ipasTextBox, ipasEllipse2, ipasPolygon, ipasRectangle2);
  TiPlotAnnotationSelectStyle = (ipassNone, ipassMove, ipassSizeTopLeft, ipassSizeTopRight, ipassSizeBottomLeft, ipassSizeBottomRight);

  TiPlotAnnotationPoint = class(TObject)
  public
    X : Double;
    Y : Double;
  end;

  TiPlotAnnotation = class(TiPlotObject)
  private
    FStyle                     : TiPlotAnnotationStyle;
    FReference                 : TiPlotReferenceType;
    FReferencePositionX        : TiPlotReferenceIndividual;
    FReferencePositionY        : TiPlotReferenceIndividual;
    FReferenceSizeX            : TiPlotReferenceIndividual;
    FReferenceSizeY            : TiPlotReferenceIndividual;

    FSelectStyle               : TiPlotAnnotationSelectStyle;

    FSizeTopLeftRect           : TRect;
    FSizeTopRightRect          : TRect;
    FSizeBottomLeftRect        : TRect;
    FSizeBottomRightRect       : TRect;

    FPolyPoints                : TStringList;

    FX                         : Double;
    FY                         : Double;
    FY2                        : Double;
    FX2                        : Double;
    FWidth                     : Double;
    FHeight                    : Double;

    FPenColor                  : TColor;
    FPenWidth                  : Integer;
    FPenStyle                  : TPenStyle;

    FBrushColor                : TColor;
    FBrushStyle                : TBrushStyle;

    FText                      : String;
    FFont                      : TFont;

    FChannelName               : String;
    FDataView                  : TiPlotDataView;
    FChannel                   : TiPlotChannelCustom;
    FTextRotation              : TiRotationAngle;

    FShowing                   : Boolean;
    FDrawRect                  : TRect;
    FClickRect                 : TRect;
    FRectChange                : Boolean;
    FUserCanMove               : Boolean;
    FUserCanSize               : Boolean;
    FSelectModeOnlyInteraction : Boolean;
    FClipToAxes                : Boolean;

    FMouseDown                 : Boolean;
    FMouseDownX                : Integer;
    FMouseDownY                : Integer;
    FMouseDownWidth            : Double;
    FMouseDownHeight           : Double;
    FMouseDownPositionPixelsX  : Integer;
    FMouseDownPositionPixelsY  : Integer;
    FMouseDownRect             : TRect;

    FImage                     : TBitmap;
    FImageListIndex            : Integer;
    FImageIndex                : Integer;
    FTextHorzAlignment         : TiAlignmentHorizontal;
    FTextVertAlignment         : TiAlignmentVertical;
    FTextLineAlignment         : TiAlignmentHorizontal;
    FTextHorzMargin            : Double;
    FTextVertMargin            : Double;
    FShowFocusRect             : Boolean;

    FMouseDownXValue           : Double;
    FMouseDownYValue           : Double;
    FMouseDownX2Value          : Double;
    FMouseDownY2Value          : Double;
    FOuterMargin               : Integer;

  protected
    procedure SetBrushColor        (const Value: TColor);
    procedure SetBrushStyle        (const Value: TBrushStyle);
    procedure SetHeight            (const Value: Double);
    procedure SetReference         (const Value: TiPlotReferenceType);
    procedure SetReferencePositionX(const Value: TiPlotReferenceIndividual);
    procedure SetReferencePositionY(const Value: TiPlotReferenceIndividual);
    procedure SetReferenceSizeX    (const Value: TiPlotReferenceIndividual);
    procedure SetReferenceSizeY    (const Value: TiPlotReferenceIndividual);
    procedure SetPenColor          (const Value: TColor);
    procedure SetPenStyle          (const Value: TPenStyle);
    procedure SetPenWidth          (const Value: Integer);
    procedure SetStyle             (const Value: TiPlotAnnotationStyle);
    procedure SetWidth             (const Value: Double);
    procedure SetX                 (const Value: Double);
    procedure SetY                 (const Value: Double);
    procedure SetX2                (const Value: Double);
    procedure SetY2                (const Value: Double);
    procedure SetFont              (const Value: TFont);
    procedure SetText              (const Value: String);
    procedure SetChannelName       (const Value: String);
    procedure SetTextRotation      (const Value: TiRotationAngle);
    procedure SetClipToAxes        (const Value: Boolean);
    procedure SetImageListIndex    (const Value: Integer);
    procedure SetImageIndex        (const Value: Integer);
    procedure SetTextHorzAlignment (const Value: TiAlignmentHorizontal);
    procedure SetTextVertAlignment (const Value: TiAlignmentVertical);
    procedure SetTextLineAlignment (const Value: TiAlignmentHorizontal);
    procedure SetTextHorzMargin    (const Value: Double);
    procedure SetTextVertMargin    (const Value: Double);
    procedure SetShowFocusRect     (const Value: Boolean);
    procedure SetOuterMargin       (const Value: Integer);
    procedure SetImage             (const Value: TBitmap);

    procedure NotificationRemove  (Sender: TObject);                                                   override;
    procedure NotificationSetFocus(Sender: TObject);                                                   override;
    procedure NotificationRename  (Sender: TObject);                                                   override;

    procedure DoMouseLeft(MouseData: TiPlotMouseData);                                                 override;
    procedure DoMouseMove(MouseData: TiPlotMouseData);                                                 override;
    procedure DoMouseUp  (MouseData: TiPlotMouseData);                                                 override;

    function  GetChannel: TiPlotChannelCustom;
    function  GetXMax: Integer;
    function  GetXMin: Integer;
    function  GetYMax: Integer;
    function  GetYMin: Integer;
    function  GetPolyPointX(Index: Integer): Double;
    function  GetPolyPointY(Index: Integer): Double;

    function GetPolyPoint(Index: Integer): TiPlotAnnotationPoint;
    function GetPolyPointsCount: Integer;

    function GetAnchorReferencePositionX: TiPlotReferenceAnchor;
    function GetAnchorReferencePositionY: TiPlotReferenceAnchor;
    function GetAnchorReferenceSizeX    : TiPlotReferenceAnchor;
    function GetAnchorReferenceSizeY    : TiPlotReferenceAnchor;

    procedure SetPolyPointX(Index: Integer; const Value: Double);
    procedure SetPolyPointY(Index: Integer; const Value: Double);

    function SizeXToPixels(Value: Double) : Integer;
    function SizeYToPixels(Value: Double) : Integer;
    function PixelsToSizeX(Value: Integer): Double;
    function PixelsToSizeY(Value: Integer): Double;

    procedure UpdateSizingRects(const r: TRect);

    function  GetMousePointer(APoint: TPoint): TCursor;                                                override;

    function  iMouseHitTest(MouseData: TiPlotMouseData): Boolean;                                      override;

    procedure Draw              (const Canvas: TCanvas; const BackGroundColor: TColor);                override;
    procedure ConvertPixelRectangle(ARect: TRect);

    function IsMoveable: Boolean;
    function IsSizeable: Boolean;

    property DataView                   : TiPlotDataView         read FDataView        write FDataView;
    property Channel                    : TiPlotChannelCustom    read GetChannel;
    property AnchorReferencePositionX   : TiPlotReferenceAnchor  read GetAnchorReferencePositionX;
    property AnchorReferencePositionY   : TiPlotReferenceAnchor  read GetAnchorReferencePositionY;
    property AnchorReferenceSizeX       : TiPlotReferenceAnchor  read GetAnchorReferenceSizeX;
    property AnchorReferenceSizeY       : TiPlotReferenceAnchor  read GetAnchorReferenceSizeY;

    property PolyPoint[Index: Integer]  : TiPlotAnnotationPoint  read GetPolyPoint;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); override;
    destructor  Destroy;                                                                           override;

    function  PositionXToPixels(Value: Double ): Integer;
    function  PositionYToPixels(Value: Double ): Integer;
    function  PixelsXToPosition(Value: Integer): Double;
    function  PixelsYToPosition(Value: Integer): Double;

    procedure ImageClear;
    procedure ImageLoadFromFile(FileName: String);

    function  PolyPointAdd(X, Y: Double): Integer;
    procedure PolyPointsClear;
    property  PolyPointsCount            : Integer                   read GetPolyPointsCount;
    property  PolyPointX[Index: Integer] : Double                    read GetPolyPointX              write SetPolyPointX;
    property  PolyPointY[Index: Integer] : Double                    read GetPolyPointY              write SetPolyPointY;

    property  ClickRect                  : TRect                     read FClickRect;
    property  Image                      : TBitmap                   read FImage                     write SetImage;
  published
    property  Style                      : TiPlotAnnotationStyle     read FStyle                     write SetStyle                    default ipasText;
    property  Reference                  : TiPlotReferenceType       read FReference                 write SetReference                default iprtDataView;
    property  ReferencePositionX         : TiPlotReferenceIndividual read FReferencePositionX        write SetReferencePositionX       default ipriAuto;
    property  ReferencePositionY         : TiPlotReferenceIndividual read FReferencePositionY        write SetReferencePositionY       default ipriAuto;
    property  ReferenceSizeX             : TiPlotReferenceIndividual read FReferenceSizeX            write SetReferenceSizeX           default ipriAuto;
    property  ReferenceSizeY             : TiPlotReferenceIndividual read FReferenceSizeY            write SetReferenceSizeY           default ipriAuto;

    property  X                          : Double                    read FX                         write SetX;
    property  Y                          : Double                    read FY                         write SetY;
    property  X2                         : Double                    read FX2                        write SetX2;
    property  Y2                         : Double                    read FY2                        write SetY2;
    property  Width                      : Double                    read FWidth                     write SetWidth;
    property  Height                     : Double                    read FHeight                    write SetHeight;

    property  PenColor                   : TColor                    read FPenColor                  write SetPenColor                  default clWhite;
    property  PenStyle                   : TPenStyle                 read FPenStyle                  write SetPenStyle                  default psSolid;
    property  PenWidth                   : Integer                   read FPenWidth                  write SetPenWidth                  default 1;

    property  BrushColor                 : TColor                    read FBrushColor                write SetBrushColor                default clWhite;
    property  BrushStyle                 : TBrushStyle               read FBrushStyle                write SetBrushStyle                default bsSolid;

    property  Text                       : String                    read FText                      write SetText;
    property  TextRotation               : TiRotationAngle           read FTextRotation              write SetTextRotation              default ira000;
    property  TextHorzAlignment          : TiAlignmentHorizontal     read FTextHorzAlignment         write SetTextHorzAlignment         default iahCenter;
    property  TextVertAlignment          : TiAlignmentVertical       read FTextVertAlignment         write SetTextVertAlignment         default iavCenter;
    property  TextLineAlignment          : TiAlignmentHorizontal     read FTextLineAlignment         write SetTextLineAlignment         default iahCenter;
    property  TextHorzMargin             : Double                    read FTextHorzMargin            write SetTextHorzMargin;
    property  TextVertMargin             : Double                    read FTextVertMargin            write SetTextVertMargin;
    property  Font                       : TFont                     read FFont                      write SetFont;
    property  OuterMargin                : Integer                   read FOuterMargin               write SetOuterMargin               default 0;

    property  ImageListIndex             : Integer                   read FImageListIndex            write SetImageListIndex            default 0;
    property  ImageIndex                 : Integer                   read FImageIndex                write SetImageIndex                default 0;

    property  ChannelName                : String                    read FChannelName               write SetChannelName;

    property  UserCanMove                : Boolean                   read FUserCanMove               write FUserCanMove                 default False;
    property  UserCanSize                : Boolean                   read FUserCanSize               write FUserCanSize                 default False;

    property  SelectModeOnlyInteraction  : Boolean                   read FSelectModeOnlyInteraction write FSelectModeOnlyInteraction   default True;

    property  ClipToAxes                 : Boolean                   read FClipToAxes                write SetClipToAxes                default False;
    property  ShowFocusRect              : Boolean                   read FShowFocusRect             write SetShowFocusRect             default True;
  end;

implementation

uses
{$ifdef iVCL} iPlotComponent;{$endif}
{$ifdef iCLX}QiPlotComponent;{$endif}

type
  TiPlotChannelCustomAccess = class(TiPlotChannelCustom)end;
  TiPlotAxisAccess          = class(TiPlotAxis)         end;
  TiPlotComponentAccess     = class(TiPlotComponent    )end;
//****************************************************************************************************************************************************
constructor TiPlotAnnotation.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited Create(AOwner, AOnChange, AOnInsert, AOnRemove, AOnRename);
  
  FFont                      := TFont.Create;
  Font.Name                  := 'Arial';
  FFont.OnChange             := TriggerChange;
  FFont.Color                := clWhite;

  FTextHorzMargin            := 1;
  FTextVertMargin            := 1;

  FShowFocusRect             := True;

  FBrushColor                := clWhite;
  FPenColor                  := clWhite;

  FReferencePositionX        := ipriAuto;
  FReferencePositionY        := ipriAuto;
  FReferenceSizeX            := ipriAuto;
  FReferenceSizeY            := ipriAuto;

  FSelectModeOnlyInteraction := True;
end;
//****************************************************************************************************************************************************
destructor TiPlotAnnotation.Destroy;
begin
  FFont.Free;
  if Assigned(FPolyPoints) then
    begin
      PolyPointsClear;
      FPolyPoints.Free;
      FPolyPoints := nil;
    end;

  if Assigned(FImage) then
    begin
     FImage.Free;
     FImage := nil;
    end;

  inherited;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetChannel: TiPlotChannelCustom;
begin
  if not Assigned(FChannel) then FChannel := (Owner as TiPlotComponent).GetChannelByName(ChannelName);
  Result := FChannel;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.NotificationRemove(Sender: TObject);
begin
  if Sender = FDataView then FDataView := nil;
  if Sender = FChannel  then FChannel  := nil;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.NotificationRename(Sender: TObject);
begin
  if Sender = FChannel then FChannelName := (Sender as TiPlotObject).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetChannelName(const Value: String);
begin
  if FChannelName <> Value then
    begin
      FChannelName := Value;
      FChannel     := nil;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetFont(const Value: TFont);begin FFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetBrushColor    (const Value: TColor );begin SetColorProperty  (Value,FBrushColor,    TriggerChange);end;
procedure TiPlotAnnotation.SetPenColor      (const Value: TColor );begin SetColorProperty  (Value,FPenColor,      TriggerChange);end;
procedure TiPlotAnnotation.SetPenWidth      (const Value: Integer);begin SetIntegerProperty(Value,FPenWidth,      TriggerChange);end;
procedure TiPlotAnnotation.SetText          (const Value: String );begin SetStringProperty (Value,FText,          TriggerChange);end;
procedure TiPlotAnnotation.SetClipToAxes    (const Value: Boolean);begin SetBooleanProperty(Value,FClipToAxes,    TriggerChange);end;
procedure TiPlotAnnotation.SetImageIndex    (const Value: Integer);begin SetIntegerProperty(Value,FImageIndex,    TriggerChange);end;
procedure TiPlotAnnotation.SetImageListIndex(const Value: Integer);begin SetIntegerProperty(Value,FImageListIndex,TriggerChange);end;
procedure TiPlotAnnotation.SetTextHorzMargin(const Value: Double );begin SetDoubleProperty (Value,FTextHorzMargin,TriggerChange);end;
procedure TiPlotAnnotation.SetTextVertMargin(const Value: Double );begin SetDoubleProperty (Value,FTextVertMargin,TriggerChange);end;
procedure TiPlotAnnotation.SetShowFocusRect (const Value: Boolean);begin SetBooleanProperty(Value,FShowFocusRect, TriggerChange);end;
procedure TiPlotAnnotation.SetOuterMargin   (const Value: Integer);begin SetIntegerProperty(Value,FOuterMargin,   TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetImage(const Value: TBitmap);
begin
  if Assigned(Value) then
    begin
      if not Assigned(Image) then FImage := TBitmap.Create;
      FImage.Assign(Value);
    end
  else
    begin
      FImage.Free;
      FImage := nil;
    end;

  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetTextHorzAlignment(const Value: TiAlignmentHorizontal);
begin
  if FTextHorzAlignment <> Value then
    begin
      FTextHorzAlignment := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetTextVertAlignment(const Value: TiAlignmentVertical);
begin
  if FTextVertAlignment <> Value then
    begin
      FTextVertAlignment := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetTextLineAlignment(const Value: TiAlignmentHorizontal);
begin
  if FTextLineAlignment <> Value then
    begin
      FTextLineAlignment := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetWidth(const Value: Double);
begin
  if FWidth <> Value then
    begin
      FWidth := Value;
      TriggerChange(Self);
      TiPlotComponentAccess(Owner).DoAnnotationCoordinatesChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetHeight(const Value: Double);
begin
  if FHeight <> Value then
    begin
      FHeight := Value;
      TriggerChange(Self);
      TiPlotComponentAccess(Owner).DoAnnotationCoordinatesChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetX(const Value: Double);
begin
  if FX <> Value then
    begin
      FX := Value;
      TriggerChange(Self);
      TiPlotComponentAccess(Owner).DoAnnotationCoordinatesChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetY(const Value: Double);
begin
  if FY <> Value then
    begin
      FY := Value;
      TriggerChange(Self);
      TiPlotComponentAccess(Owner).DoAnnotationCoordinatesChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetX2(const Value: Double);
begin
  if FX2 <> Value then
    begin
      FX2 := Value;
      TriggerChange(Self);
      TiPlotComponentAccess(Owner).DoAnnotationCoordinatesChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetY2(const Value: Double);
begin
  if FY2 <> Value then
    begin
      FY2 := Value;
      TriggerChange(Self);
      TiPlotComponentAccess(Owner).DoAnnotationCoordinatesChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetStyle(const Value: TiPlotAnnotationStyle);
begin
  if FStyle <> Value then
    begin
      FStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetReference(const Value: TiPlotReferenceType);
begin
if FReference <> Value then
  begin
    FReference := Value;
    TriggerChange(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetReferencePositionX(const Value: TiPlotReferenceIndividual);
begin
if FReferencePositionX <> Value then
  begin
    FReferencePositionX := Value;
    TriggerChange(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetReferencePositionY(const Value: TiPlotReferenceIndividual);
begin
if FReferencePositionY <> Value then
  begin
    FReferencePositionY := Value;
    TriggerChange(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetReferenceSizeX(const Value: TiPlotReferenceIndividual);
begin
if FReferenceSizeX <> Value then
  begin
    FReferenceSizeX := Value;
    TriggerChange(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetReferenceSizeY(const Value: TiPlotReferenceIndividual);
begin
if FReferenceSizeY <> Value then
  begin
    FReferenceSizeY := Value;
    TriggerChange(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetPenStyle(const Value: TPenStyle);
begin
  if FPenStyle <> Value then
    begin
      FPenStyle := Value;
     TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetBrushStyle(const Value: TBrushStyle);
begin
  if FBrushStyle <> Value then
    begin
      FBrushStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetTextRotation(const Value: TiRotationAngle);
begin
  if FTextRotation <> Value then
    begin
      FTextRotation := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.UpdateSizingRects(const r: TRect);
begin
  IntersectRect(FSizeTopLeftRect,     Rect(r.Left -3, r.Top   -3, r.Left +3, r.Top   +3), FDataView.DrawRect);
  IntersectRect(FSizeTopRightRect,    Rect(r.Right-3, r.Top   -3, r.Right+3, r.Top   +3), FDataView.DrawRect);
  IntersectRect(FSizeBottomLeftRect,  Rect(r.Left -3, r.Bottom-3, r.Left +3, r.Bottom+3), FDataView.DrawRect);
  IntersectRect(FSizeBottomRightRect, Rect(r.Right-3, r.Bottom-3, r.Right+3, r.Bottom+3), FDataView.DrawRect);
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  i                     : Integer;
  PolyPointArray        : Array of TPoint;
  ARegion               : HRGN;

  ARect                 : TRect;
  ATextRect             : TRect;
  ATextWidth            : Integer;
  ATextHeight           : Integer;
  ATextHorzMarginPixels : Integer;
  ATextVertMarginPixels : Integer;

  APoint1               : TPoint;
  APoint2               : TPoint;
  ATemp                 : Integer;
  DummyRect             : TRect;
  XAxis                 : TiPlotXAxis;
  YAxis                 : TiPlotYAxis;
  NeedToClip            : Boolean;
  NeedDataView          : Boolean;
  NeedChannel           : Boolean;

  ImageList             : TImageList;

  PositionXPixels       : Integer;
  PositionYPixels       : Integer;
  PositionX2Pixels      : Integer;
  PositionY2Pixels      : Integer;
  PositionLeftPixels    : Integer;
  PositionTopPixels     : Integer;
  PositionRightPixels   : Integer;
  PositionBottomPixels  : Integer;
begin
  FShowing := False;
  if not Visible then Exit;

  XAxis := nil;
  YAxis := nil;

  NeedDataView := False;
  NeedChannel  := False;

  if AnchorReferencePositionX = ipraDataView then NeedDataView := True else NeedChannel := True;
  if AnchorReferencePositionY = ipraDataView then NeedDataView := True else NeedChannel := True;
  if AnchorReferenceSizeX     = ipraDataView then NeedDataView := True else NeedChannel := True;
  if AnchorReferenceSizeY     = ipraDataView then NeedDataView := True else NeedChannel := True;

  if (NeedDataView) and (not Assigned(FDataView)) then Exit;
  if (NeedChannel)  and (not Assigned(Channel  )) then Exit;

  if NeedChannel then
    begin
      XAxis := TiPlotChannelCustomAccess(Channel).XAxis;
      YAxis := TiPlotChannelCustomAccess(Channel).YAxis;

      if not Assigned(XAxis) then Exit;
      if not Assigned(YAxis) then Exit;
    end;

  PositionXPixels      := PositionXToPixels(X);
  PositionYPixels      := PositionYToPixels(Y);
  PositionX2Pixels     := PositionXToPixels(X2);
  PositionY2Pixels     := PositionYToPixels(Y2);
  PositionLeftPixels   := PositionXPixels - SizeXToPixels(Width/2);
  PositionRightPixels  := PositionXPixels + SizeXToPixels(Width/2);
  PositionTopPixels    := PositionYPixels - SizeYToPixels(Height/2);
  PositionBottomPixels := PositionYPixels + SizeYToPixels(Height/2);

                                                                                                NeedToClip := FClipToAxes;
  if (FReference = iprtChannel) then if TiPlotComponentAccess(Owner).ClipAnnotationsToAxes then NeedToClip := True;

  if NeedToClip then
    begin
      if XYAxesReversed then ARect := iRect(YAxis.MinPixels, XAxis.MinPixels, YAxis.MaxPixels, XAxis.MaxPixels)
      else                   ARect := iRect(XAxis.MinPixels, YAxis.MinPixels, XAxis.MaxPixels, YAxis.MaxPixels);
      {$IFDEF iVCL}
      IntersectClipRect(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      {$ENDIF}
    end;            

  with Canvas do
    begin
      case Style of
        ipasText          : begin
                              Font.Assign(Self.Font);
                              ATextWidth            := iTextWidth  (Canvas, FText);
                              ATextHeight           := iTextHeight (Canvas, FText);
                              ATextHorzMarginPixels := Round(TextWidth ('A')*FTextHorzMargin);
                              ATextVertMarginPixels := Round(TextHeight('A')*FTextVertMargin);

                              if XYAxesReversed                    then SwapIntegers(PositionXPixels, PositionYPixels);
                              if FTextRotation in [ira090, ira270] then SwapIntegers(ATextWidth, ATextHeight);

                              ATextRect := Rect(PositionXPixels - ATextWidth div 2,              PositionYPixels - ATextHeight div 2,
                                                PositionXPixels - ATextWidth div 2 + ATextWidth, PositionYPixels - ATextHeight div 2 + ATextHeight);

                              case FTextHorzAlignment of
                                iahLeft   : OffsetRect(ATextRect, +(ATextWidth div 2 + ATextHorzMarginPixels), 0);
                                iahRight  : OffsetRect(ATextRect, -(ATextWidth div 2 + ATextHorzMarginPixels), 0);
                              end;

                              case FTextVertAlignment of
                                iavTop    : OffsetRect(ATextRect, 0, +(ATextHeight div 2 + ATextVertMarginPixels));
                                iavBottom : OffsetRect(ATextRect, 0, -(ATextHeight div 2 + ATextVertMarginPixels));
                              end;

                              if not IntersectRect(DummyRect, FDataView.DrawRect, ATextRect) then Exit;

                              Brush.Style := bsClear;
                              iDrawRotatedText(Canvas, Text, ATextRect, FTextRotation, FTextLineAlignment, True, clBtnFace);

                              FShowing   := True;
                              FClickRect := ATextRect;
                            end;
        ipasTextBox       : begin
                              Font.Assign(Self.Font);
                              ATextWidth            := iTextWidth  (Canvas, FText) + 2*FOuterMargin;
                              ATextHeight           := iTextHeight (Canvas, FText) + 2*FOuterMargin;
                              ATextHorzMarginPixels := Round(TextWidth ('A')*FTextHorzMargin);
                              ATextVertMarginPixels := Round(TextHeight('A')*FTextVertMargin);

                              if XYAxesReversed                    then SwapIntegers(PositionXPixels, PositionYPixels);
                              if FTextRotation in [ira090, ira270] then SwapIntegers(ATextWidth, ATextHeight);

                              ATextRect := Rect(PositionXPixels - ATextWidth div 2,              PositionYPixels - ATextHeight div 2,
                                                PositionXPixels - ATextWidth div 2 + ATextWidth, PositionYPixels - ATextHeight div 2 + ATextHeight);

                              case FTextHorzAlignment of
                                iahLeft   : OffsetRect(ATextRect, +(ATextWidth div 2 + ATextHorzMarginPixels), 0);
                                iahRight  : OffsetRect(ATextRect, -(ATextWidth div 2 + ATextHorzMarginPixels), 0);
                              end;

                              case FTextVertAlignment of
                                iavTop    : OffsetRect(ATextRect, 0, +(ATextHeight div 2 + ATextVertMarginPixels));
                                iavBottom : OffsetRect(ATextRect, 0, -(ATextHeight div 2 + ATextVertMarginPixels));
                              end;

                              if not IntersectRect(DummyRect, FDataView.DrawRect, ATextRect) then Exit;

                              Pen.Color   := PenColor;
                              Pen.Width   := PenWidth;
                              Pen.Style   := PenStyle;
                              Brush.Color := BrushColor;
                              Brush.Style := BrushStyle;

                              Windows.SetBkColor(Canvas.Handle, BackGroundColor);

                              Rectangle(ATextRect.Left, ATextRect.Top, ATextRect.Right, ATextRect.Bottom);

                              DummyRect := ATextRect;
                              InflateRect(DummyRect, -FOuterMargin, -FOuterMargin);

                              Brush.Style := bsClear;
                              iDrawRotatedText(Canvas, Text, DummyRect, FTextRotation, FTextLineAlignment, True, clBtnFace);

                              FShowing    := True;
                              FClickRect  := ATextRect;
                            end;
        ipasTextRectangle : begin
                              Font.Assign(Self.Font);
                              ARect := iXYReverseRect(XYAxesReversed, PositionLeftPixels, PositionTopPixels, PositionRightPixels, PositionBottomPixels);

                              if not IntersectRect(DummyRect, FDataView.DrawRect, ARect) then Exit;

                              Pen.Color   := PenColor;
                              Pen.Width   := PenWidth;
                              Pen.Style   := PenStyle;

                              Brush.Color := BrushColor;
                              Brush.Style := BrushStyle;

                              Windows.SetBkColor(Canvas.Handle, BackGroundColor);

                              Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);

                              UpdateSizingRects(ARect);

                              if UserSelected and FShowFocusRect then
                                begin
                                  if Pen.Style = psSolid then Brush.Color := Pen.Color;
                                  Brush.Style := bsSolid;
                                  Pen.Style   := psSolid;

                                  {$IFDEF iVCL}
                                  InvertRect(Canvas.Handle, FSizeTopLeftRect);
                                  InvertRect(Canvas.Handle, FSizeTopRightRect);
                                  InvertRect(Canvas.Handle, FSizeBottomLeftRect);
                                  InvertRect(Canvas.Handle, FSizeBottomRightRect);
                                  {$ENDIF}

                                  {$IFDEF iCLX}
                                  iRectangle(Canvas, FSizeTopLeftRect);
                                  iRectangle(Canvas, FSizeTopRightRect);
                                  iRectangle(Canvas, FSizeBottomLeftRect);
                                  iRectangle(Canvas, FSizeBottomRightRect);
                                  {$ENDIF}
                                end;

                              Brush.Style := bsClear;

                              ATextRect             := ARect;
                              ATextWidth            := iTextWidth  (Canvas, FText);
                              ATextHeight           := iTextHeight (Canvas, FText);
                              ATextHorzMarginPixels := Round(TextWidth ('0')*FTextHorzMargin);
                              ATextVertMarginPixels := Round(TextHeight('A')*FTextVertMargin);

                              if FTextRotation in [ira090, ira270] then SwapIntegers(ATextWidth, ATextHeight);

                              case FTextHorzAlignment of
                                iahCenter : begin
                                              ATextRect.Left  := ARect.Left;
                                              ATextRect.Right := ARect.Right;
                                            end;
                                iahLeft   : begin
                                              ATextRect.Left  := ARect.Left + ATextHorzMarginPixels;
                                              ATextRect.Right := ATextRect.Left + ATextWidth;
                                            end;
                                iahRight  : begin
                                              ATextRect.Left  := ARect.Right - ATextHorzMarginPixels -ATextWidth;
                                              ATextRect.Right := ARect.Right - ATextHorzMarginPixels;
                                            end;
                              end;

                              case FTextVertAlignment of
                                iavCenter : begin
                                              ATextRect.Top    := ARect.Top;
                                              ATextRect.Bottom := ARect.Bottom;
                                            end;
                                iavTop    : begin
                                              ATextRect.Top    := ARect.Top + ATextVertMarginPixels;
                                              ATextRect.Bottom := ARect.Top + ATextVertMarginPixels + ATextHeight;
                                            end;
                                iavBottom : begin
                                              ATextRect.Top    := ARect.Bottom - ATextVertMarginPixels - ATextHeight;
                                              ATextRect.Bottom := ARect.Bottom - ATextVertMarginPixels;
                                            end;
                              end;                                            

                              iDrawRotatedText(Canvas, Text, ATextRect, FTextRotation, FTextLineAlignment, True, clBtnFace);

                              FShowing  := True;
                              FDrawRect := ARect;
                              IntersectRect(FClickRect, ARect, FDataView.DrawRect);
                            end;
        ipasLine          : begin
                              APoint1 := iXYReversePoint(XYAxesReversed, PositionXPixels,  PositionYPixels );
                              APoint2 := iXYReversePoint(XYAxesReversed, PositionX2Pixels, PositionY2Pixels);

                              if not LineIntersectsRect(APoint1, APoint2, FDataView.DrawRect) then Exit;

                              Pen.Color   := PenColor;
                              Pen.Width   := PenWidth;
                              Pen.Style   := PenStyle;
                              Brush.Color := BackGroundColor;

                              Windows.SetBkColor(Canvas.Handle, BackGroundColor);

                              Polyline([APoint1, APoint2]);
                            end;
        ipasLineX         : begin
                              APoint1 := iXYReversePoint(XYAxesReversed, PositionXPixels, GetYMax);
                              APoint2 := iXYReversePoint(XYAxesReversed, PositionXPixels, GetYMin);

                              if not LineIntersectsRect(APoint1, APoint2, FDataView.DrawRect) then Exit;

                              Pen.Color   := PenColor;
                              Pen.Width   := PenWidth;
                              Pen.Style   := PenStyle;
                              Brush.Color := BackGroundColor;

                              Windows.SetBkColor(Canvas.Handle, BackGroundColor);

                              Polyline([APoint1, APoint2]);

                              FShowing   := True;
                              FClickRect := iXYReverseRect(XYAxesReversed, PositionXPixels-5, GetYMax, PositionXPixels+5, GetYMin);
                            end;
        ipasLineY         : begin
                              APoint1 := iXYReversePoint(XYAxesReversed, GetXMax, PositionYPixels);
                              APoint2 := iXYReversePoint(XYAxesReversed, GetXMin, PositionYPixels);

                              if not LineIntersectsRect(APoint1, APoint2, FDataView.DrawRect) then Exit;

                              Pen.Color   := PenColor;
                              Pen.Width   := PenWidth;
                              Pen.Style   := PenStyle;
                              Brush.Color := BackGroundColor;

                              Windows.SetBkColor(Canvas.Handle, BackGroundColor);

                              Polyline([APoint1, APoint2]);

                              FShowing   := True;
                              FClickRect := iXYReverseRect(XYAxesReversed, GetXMax, PositionYPixels-5, GetXMin, PositionYPixels+5);
                            end;
        ipasRectangle     : begin
                              ARect := iXYReverseRect(XYAxesReversed, PositionLeftPixels, PositionTopPixels, PositionRightPixels, PositionBottomPixels);

                              if not IntersectRect(DummyRect, FDataView.DrawRect, ARect) then Exit;

                              Pen.Color   := PenColor;
                              Pen.Width   := PenWidth;
                              Pen.Style   := PenStyle;

                              Brush.Color := BrushColor;
                              Brush.Style := BrushStyle;

                              Windows.SetBkColor(Canvas.Handle, BackGroundColor);

                              Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);

                              FShowing  := True;
                              FDrawRect := ARect;

                              IntersectRect(FClickRect, ARect, FDataView.DrawRect);

                              UpdateSizingRects(ARect);

                              if UserSelected and FShowFocusRect then
                                begin
                                  if Pen.Style = psSolid then Brush.Color := Pen.Color;
                                  Brush.Style := bsSolid;
                                  Pen.Style   := psSolid;

                                  {$IFDEF iVCL}
                                  InvertRect(Canvas.Handle, FSizeTopLeftRect);
                                  InvertRect(Canvas.Handle, FSizeTopRightRect);
                                  InvertRect(Canvas.Handle, FSizeBottomLeftRect);
                                  InvertRect(Canvas.Handle, FSizeBottomRightRect);
                                  {$ENDIF}

                                  {$IFDEF iCLX}
                                  iRectangle(Canvas, FSizeTopLeftRect);
                                  iRectangle(Canvas, FSizeTopRightRect);
                                  iRectangle(Canvas, FSizeBottomLeftRect);
                                  iRectangle(Canvas, FSizeBottomRightRect);
                                  {$ENDIF}
                                end;
                            end;
        ipasRectangle2    : begin
                              ARect := iXYReverseRect(XYAxesReversed, PositionXPixels, PositionYPixels, PositionX2Pixels, PositionY2Pixels);

                              if not IntersectRect(DummyRect, FDataView.DrawRect, ARect) then Exit;

                              Pen.Color   := PenColor;
                              Pen.Width   := PenWidth;
                              Pen.Style   := PenStyle;

                              Brush.Color := BrushColor;
                              Brush.Style := BrushStyle;

                              Windows.SetBkColor(Canvas.Handle, BackGroundColor);

                              Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);

                              FShowing  := True;
                              FDrawRect := ARect;

                              IntersectRect(FClickRect, ARect, FDataView.DrawRect);

                              UpdateSizingRects(ARect);

                              if UserSelected and FShowFocusRect then
                                begin
                                  if Pen.Style = psSolid then Brush.Color := Pen.Color;
                                  Brush.Style := bsSolid;
                                  Pen.Style   := psSolid;

                                  {$IFDEF iVCL}
                                  InvertRect(Canvas.Handle, FSizeTopLeftRect);
                                  InvertRect(Canvas.Handle, FSizeTopRightRect);
                                  InvertRect(Canvas.Handle, FSizeBottomLeftRect);
                                  InvertRect(Canvas.Handle, FSizeBottomRightRect);
                                  {$ENDIF}

                                  {$IFDEF iCLX}
                                  iRectangle(Canvas, FSizeTopLeftRect);
                                  iRectangle(Canvas, FSizeTopRightRect);
                                  iRectangle(Canvas, FSizeBottomLeftRect);
                                  iRectangle(Canvas, FSizeBottomRightRect);
                                  {$ENDIF}
                                end;
                            end;
        ipasEllipse       : begin
                              ARect := iXYReverseRect(XYAxesReversed, PositionXPixels, PositionYPixels, PositionX2Pixels, PositionY2Pixels);

                              if not IntersectRect(DummyRect, FDataView.DrawRect, ARect) then Exit;

                              Pen.Color   := PenColor;
                              Pen.Width   := PenWidth;
                              Pen.Style   := PenStyle;

                              Brush.Color := BrushColor;
                              Brush.Style := BrushStyle;

                              Windows.SetBkColor(Canvas.Handle, BackGroundColor);

                              Ellipse(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);

                              FShowing  := True;
                              FDrawRect := ARect;

                              IntersectRect(FClickRect, ARect, FDataView.DrawRect);

                              UpdateSizingRects(ARect);

                              if UserSelected and FShowFocusRect then
                                begin
                                  if Pen.Style = psSolid then Brush.Color := Pen.Color;
                                  Brush.Style := bsSolid;
                                  Pen.Style   := psSolid;

                                  {$IFDEF iVCL}
                                  InvertRect(Canvas.Handle, FSizeTopLeftRect);
                                  InvertRect(Canvas.Handle, FSizeTopRightRect);
                                  InvertRect(Canvas.Handle, FSizeBottomLeftRect);
                                  InvertRect(Canvas.Handle, FSizeBottomRightRect);
                                  {$ENDIF}

                                  {$IFDEF iCLX}
                                  iRectangle(Canvas, FSizeTopLeftRect);
                                  iRectangle(Canvas, FSizeTopRightRect);
                                  iRectangle(Canvas, FSizeBottomLeftRect);
                                  iRectangle(Canvas, FSizeBottomRightRect);
                                  {$ENDIF}
                                end;
                            end;
         ipasEllipse2      : begin
                              ARect := iXYReverseRect(XYAxesReversed, PositionLeftPixels, PositionTopPixels, PositionRightPixels, PositionBottomPixels);

                              if not IntersectRect(DummyRect, FDataView.DrawRect, ARect) then Exit;

                              Pen.Color   := PenColor;
                              Pen.Width   := PenWidth;
                              Pen.Style   := PenStyle;

                              Brush.Color := BrushColor;
                              Brush.Style := BrushStyle;

                              Windows.SetBkColor(Canvas.Handle, BackGroundColor);

                              Ellipse(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);

                              FShowing  := True;
                              FDrawRect := ARect;

                              IntersectRect(FClickRect, ARect, FDataView.DrawRect);

                              UpdateSizingRects(ARect);

                              if UserSelected and FShowFocusRect then
                                begin
                                  if Pen.Style = psSolid then Brush.Color := Pen.Color;
                                  Brush.Style := bsSolid;
                                  Pen.Style   := psSolid;

                                  {$IFDEF iVCL}
                                  InvertRect(Canvas.Handle, FSizeTopLeftRect);
                                  InvertRect(Canvas.Handle, FSizeTopRightRect);
                                  InvertRect(Canvas.Handle, FSizeBottomLeftRect);
                                  InvertRect(Canvas.Handle, FSizeBottomRightRect);
                                  {$ENDIF}

                                  {$IFDEF iCLX}
                                  iRectangle(Canvas, FSizeTopLeftRect);
                                  iRectangle(Canvas, FSizeTopRightRect);
                                  iRectangle(Canvas, FSizeBottomLeftRect);
                                  iRectangle(Canvas, FSizeBottomRightRect);
                                  {$ENDIF}
                                end;
                            end;
         ipasPolygon      : begin
                              if PolyPointsCount < 2 then Exit;

                              SetLength(PolyPointArray, PolyPointsCount);

                              for i := 0 to PolyPointsCount-1 do
                                begin
                                  if not XYAxesReversed then
                                    begin
                                      PolyPointArray[i].X := PositionXToPixels(PolyPoint[i].X);
                                      PolyPointArray[i].Y := PositionYToPixels(PolyPoint[i].Y);
                                    end
                                  else
                                    begin
                                      PolyPointArray[i].X := PositionYToPixels(PolyPoint[i].Y);
                                      PolyPointArray[i].Y := PositionXToPixels(PolyPoint[i].X);
                                    end
                                end;

                              ARegion := CreatePolygonRgn(PolyPointArray[0], PolyPointsCount, WINDING);
                              try
                                GetRgnBox(ARegion, ARect);
                              finally
                                DeleteObject(ARegion);
                              end;

                              if not IntersectRect(DummyRect, FDataView.DrawRect, ARect) then Exit;

                              Pen.Color   := PenColor;
                              Pen.Width   := PenWidth;
                              Pen.Style   := PenStyle;

                              Brush.Color := BrushColor;
                              Brush.Style := BrushStyle;

                              Windows.SetBkColor(Canvas.Handle, BackGroundColor);

                              Canvas.Polygon(PolyPointArray);

                              FShowing  := True;
                              FDrawRect := ARect;

                              IntersectRect(FClickRect, ARect, FDataView.DrawRect);

                              UpdateSizingRects(ARect);

                              if UserSelected and FShowFocusRect then
                                begin
                                  if Pen.Style = psSolid then Brush.Color := Pen.Color;
                                  Brush.Style := bsSolid;
                                  Pen.Style   := psSolid;

                                  {$IFDEF iVCL}
                                  InvertRect(Canvas.Handle, FSizeTopLeftRect);
                                  InvertRect(Canvas.Handle, FSizeTopRightRect);
                                  InvertRect(Canvas.Handle, FSizeBottomLeftRect);
                                  InvertRect(Canvas.Handle, FSizeBottomRightRect);
                                  {$ENDIF}

                                  {$IFDEF iCLX}
                                  iRectangle(Canvas, FSizeTopLeftRect);
                                  iRectangle(Canvas, FSizeTopRightRect);
                                  iRectangle(Canvas, FSizeBottomLeftRect);
                                  iRectangle(Canvas, FSizeBottomRightRect);
                                  {$ENDIF}
                                end;
                            end;
        ipasImage         : begin
                              if Assigned(FImage) then
                                begin
                                  APoint1   := iXYReversePoint(XYAxesReversed, PositionXPixels, PositionYPixels);
                                  APoint1.X := APoint1.X - Image.Width  div 2;
                                  APoint1.Y := APoint1.Y - Image.Height div 2;
                                  ARect     := Rect(APoint1.X,               APoint1.Y,
                                                    APoint1.X + Image.Width, APoint1.Y + Image.Height);

                                  if not IntersectRect(DummyRect, FDataView.DrawRect, ARect) then Exit;

                                  FImage.TransparentColor := FImage.Canvas.Pixels[0, FImage.Height-1];

                                  FShowing := True;
                                  Canvas.Draw(APoint1.X, APoint1.Y, FImage);
                                  FClickRect := ARect;
                                end
                              else
                                begin
                                  case FImageListIndex of
                                    0    : ImageList := TiPlotComponentAccess(Owner).ImageList0;
                                    1    : ImageList := TiPlotComponentAccess(Owner).ImageList1;
                                    else   ImageList := TiPlotComponentAccess(Owner).ImageList2;
                                  end;

                                  APoint1   := iXYReversePoint(XYAxesReversed, PositionXPixels, PositionYPixels);
                                  APoint1.X := APoint1.X - ImageList.Width  div 2;
                                  APoint1.Y := APoint1.Y - ImageList.Height div 2;
                                  ARect     := Rect(APoint1.X,                   APoint1.Y,
                                                    APoint1.X + ImageList.Width, APoint1.Y + ImageList.Height);

                                  if not IntersectRect(DummyRect, FDataView.DrawRect, ARect) then Exit;

                                  FShowing := True;
                                  {$ifdef iVCL}ImageList.Draw(Canvas, APoint1.X, APoint1.Y, FImageIndex,          Enabled);{$endif}
                                  {$ifdef iCLX}ImageList.Draw(Canvas, APoint1.X, APoint1.Y, FImageIndex, itImage, Enabled);{$endif}

                                  FClickRect := ARect;
                                end;
                              end;
      end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.iMouseHitTest(MouseData: TiPlotMouseData): Boolean;
begin
  Result := False;
  
  if FSelectModeOnlyInteraction and not TiPlotComponentAccess(Owner).SelectModeActive then Exit;

  if FShowing then
    begin
      if PtInRect(FClickRect,           Point(MouseData.X, MouseData.Y)) then Result := True;
      if PtInRect(FSizeTopLeftRect,     Point(MouseData.X, MouseData.Y)) then Result := True;
      if PtInRect(FSizeTopRightRect,    Point(MouseData.X, MouseData.Y)) then Result := True;
      if PtInRect(FSizeBottomLeftRect,  Point(MouseData.X, MouseData.Y)) then Result := True;
      if PtInRect(FSizeBottomRightRect, Point(MouseData.X, MouseData.Y)) then Result := True;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetMousePointer(APoint: TPoint): TCursor;
begin
  if FUserCanSize and IsSizeable and UserSelected then
    begin
      if      PtInRect(FSizeTopLeftRect,     APoint) then Result := crSizeNWSE
      else if PtInRect(FSizeBottomRightRect, APoint) then Result := crSizeNWSE
      else if PtInRect(FSizeTopRightRect,    APoint) then Result := crSizeNESW
      else if PtInRect(FSizeBottomLeftRect,  APoint) then Result := crSizeNESW
      else                                                Result := crHandPoint;
    end
  else Result := crHandPoint;

  TiPlotComponentAccess(Owner).DoGetMouseCursor(Self, Result);
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.DoMouseLeft(MouseData: TiPlotMouseData);
begin
  if FShowing then
    begin
      FSelectStyle := ipassNone;
      if IsSizeable then
        begin
          if      PtInRect(FSizeTopLeftRect,     Point(MouseData.X, MouseData.Y)) then FSelectStyle := ipassSizeTopLeft
          else if PtInRect(FSizeBottomRightRect, Point(MouseData.X, MouseData.Y)) then FSelectStyle := ipassSizeBottomRight
          else if PtInRect(FSizeTopRightRect,    Point(MouseData.X, MouseData.Y)) then FSelectStyle := ipassSizeTopRight
          else if PtInRect(FSizeBottomLeftRect,  Point(MouseData.X, MouseData.Y)) then FSelectStyle := ipassSizeBottomLeft
        end;

      if IsMoveable and (FSelectStyle = ipassNone) then                                FSelectStyle := ipassMove;

      FMouseDown     := True;
      FMouseDownRect := FDrawRect;
      FRectChange    := False;

      FMouseDownXValue  := X;
      FMouseDownYValue  := Y;
      FMouseDownX2Value := X2;
      FMouseDownY2Value := Y2;

      if XYAxesReversed then
        begin
          FMouseDownX               := MouseData.X;
          FMouseDownY               := MouseData.Y;
          FMouseDownWidth           := FWidth;
          FMouseDownHeight          := FHeight;
          FMouseDownPositionPixelsX := PositionYToPixels(FY);
          FMouseDownPositionPixelsY := PositionXToPixels(FX);
        end
      else
        begin
          FMouseDownX               := MouseData.X;
          FMouseDownY               := MouseData.Y;
          FMouseDownWidth           := FWidth;
          FMouseDownHeight          := FHeight;
          FMouseDownPositionPixelsX := PositionXToPixels(FX);
          FMouseDownPositionPixelsY := PositionYToPixels(FY);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.DoMouseMove(MouseData: TiPlotMouseData);
var
  NewRect               : TRect;
  DeltaX                : Double;
  DeltaY                : Double;
  MouseDownDeltaPixelsX : Integer;
  MouseDownDeltaPixelsY : Integer;
begin
  if not UserSelected then Exit;
  if FMouseDown then
    begin
      MouseDownDeltaPixelsX := FMouseDownPositionPixelsX - FMouseDownX;
      MouseDownDeltaPixelsY := FMouseDownPositionPixelsY - FMouseDownY;

      if (XYAxesReversed) then
        begin
         DeltaX := PixelsXToPosition(MouseData.Y + MouseDownDeltaPixelsY);
         DeltaY := PixelsYToPosition(MouseData.X + MouseDownDeltaPixelsX);
        end
      else 
        begin
         DeltaX := PixelsXToPosition(MouseData.X + MouseDownDeltaPixelsX);
         DeltaY := PixelsYToPosition(MouseData.Y + MouseDownDeltaPixelsY);
        end;

      case FSelectStyle of
        ipassMove            : begin
                                 if (FStyle = ipasEllipse) or (FStyle = ipasRectangle2) then
                                   begin
                                     X  := DeltaX;
                                     Y  := DeltaY;
                                     X2 := DeltaX + (FMouseDownX2Value - FMouseDownXValue);
                                     Y2 := DeltaY + (FMouseDownY2Value - FMouseDownYValue);
                                   end
                                 else
                                   begin
                                     X := DeltaX;
                                     Y := DeltaY;
                                   end;
                                 FRectChange := True;
                                 TriggerChange(Self);
                                 TiPlotComponentAccess(Owner).DoAnnotationMoveUser(Self);
                                 TiPlotComponentAccess(Owner).DoAnnotationCoordinatesChange(Self);
                               end;
        ipassSizeTopLeft     : begin
                                 NewRect := FMouseDownRect;

                                 NewRect.Top    := FMouseDownRect.Top  + MouseData.Y - FMouseDownY;
                                 NewRect.Left   := FMouseDownRect.Left + MouseData.X - FMouseDownX;

                                 ConvertPixelRectangle(NewRect);
                                 TiPlotComponentAccess(Owner).DoAnnotationResizeUser(Self);
                               end;
        ipassSizeTopRight    : begin
                                 NewRect := FMouseDownRect;

                                 NewRect.Top    := FMouseDownRect.Top   + MouseData.Y - FMouseDownY;
                                 NewRect.Right  := FMouseDownRect.Right + MouseData.X - FMouseDownX;

                                 ConvertPixelRectangle(NewRect);
                                 TiPlotComponentAccess(Owner).DoAnnotationResizeUser(Self);
                               end;
        ipassSizeBottomLeft  : begin
                                 NewRect := FMouseDownRect;

                                 NewRect.Bottom := FMouseDownRect.Bottom + MouseData.Y - FMouseDownY;
                                 NewRect.Left   := FMouseDownRect.Left   + MouseData.X - FMouseDownX;

                                 ConvertPixelRectangle(NewRect);
                                 TiPlotComponentAccess(Owner).DoAnnotationResizeUser(Self);
                               end;
        ipassSizeBottomRight : begin
                                 NewRect := FMouseDownRect;


                                 NewRect.Bottom := FMouseDownRect.Bottom + MouseData.Y - FMouseDownY;
                                 NewRect.Right  := FMouseDownRect.Right + MouseData.X - FMouseDownX;

                                 ConvertPixelRectangle(NewRect);
                                 TiPlotComponentAccess(Owner).DoAnnotationResizeUser(Self);
                               end;
      end;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.DoMouseUp(MouseData: TiPlotMouseData);
begin
  if not FMouseDown then Exit;

  FMouseDown := False;
  if iMouseHitTest(MouseData) then TiPlotComponentAccess(Owner).DoObjectClick(Self);
  if FRectChange  then             TiPlotComponentAccess(Owner).DoAnnotationCoordinatesChangeFinished(Self);

  FSelectStyle := ipassNone;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.ConvertPixelRectangle(ARect: TRect);
begin
  with ARect do
     begin
       if XYAxesReversed then
         begin
           if (FStyle <> ipasEllipse) and (FStyle <> ipasRectangle2) then
             begin
               FX      :=    (PixelsXToPosition(Top)    + PixelsXToPosition(Bottom))/2;
               FY      :=    (PixelsYToPosition(Left)   + PixelsYToPosition(Right ))/2;
               FWidth  := ABS(PixelsXToPosition(Bottom) - PixelsXToPosition(Top   ));
               FHeight := ABS(PixelsYToPosition(Right)  - PixelsYToPosition(Left  ));
             end
           else
             begin
               FX  := PixelsXToPosition(Top   );
               FY  := PixelsYToPosition(Left  );
               FX2 := PixelsXToPosition(Bottom);
               FY2 := PixelsYToPosition(Right );
             end;
         end
       else
         begin
           if (FStyle <> ipasEllipse) and (FStyle <> ipasRectangle2) then
             begin
               FX      :=    (PixelsXToPosition(Left)   + PixelsXToPosition(Right ))/2;
               FY      :=    (PixelsYToPosition(Top)    + PixelsYToPosition(Bottom))/2;
               FWidth  := ABS(PixelsToSizeX    (Right)  - PixelsToSizeX    (Left  ));
               FHeight := ABS(PixelsToSizeY    (Bottom) - PixelsToSizeY    (Top   ));
             end
           else
             begin
               FX      := PixelsXToPosition(Left);
               FY      := PixelsYToPosition(Top);
               FX2     := PixelsXToPosition(Right);
               FY2     := PixelsYToPosition(Bottom);
             end;
         end
     end;
  FRectChange := True;
  TriggerChange(Self);
  TiPlotComponentAccess(Owner).DoAnnotationCoordinatesChange(Self);
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.PositionXToPixels(Value: Double): Integer;
begin
  Result := 0;

  case AnchorReferencePositionX of
    ipraDataView : begin
                     if not Assigned(FDataView) then Exit;
                     if XYAxesReversed then Result := FDataView.PositionPercentToPixelsY(Value)
                     else                   Result := FDataView.PositionPercentToPixelsX(Value)
                   end;
    ipraChannel  : begin
                     if not Assigned(Channel      ) then Exit;
                     if not Assigned(Channel.XAxis) then Exit;
                     if not Assigned(Channel.YAxis) then Exit;

                     Result := Channel.XAxis.PositionToPixels(Value);
                   end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.PositionYToPixels(Value: Double): Integer;
begin
  Result := 0;

  case AnchorReferencePositionY of
    ipraDataView : begin
                     if not Assigned(FDataView) then Exit;
                     if XYAxesReversed then Result := FDataView.PositionPercentToPixelsX(Value)
                     else                   Result := FDataView.PositionPercentToPixelsY(Value)
                   end;
    ipraChannel  : begin
                     if not Assigned(Channel      ) then Exit;
                     if not Assigned(Channel.XAxis) then Exit;
                     if not Assigned(Channel.YAxis) then Exit;

                     Result := Channel.YAxis.PositionToPixels(Value);
                   end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.PixelsXToPosition(Value: Integer): Double;
begin
  Result := 0;

  case AnchorReferencePositionX of                 
    ipraDataView : begin
                     if not Assigned(FDataView) then Exit;
                     if XYAxesReversed then Result := FDataView.PixelsYToPositionPercent(Value)
                     else                   Result := FDataView.PixelsXToPositionPercent(Value)
                   end;
    ipraChannel  : begin
                     if not Assigned(Channel)                                  then Exit;
                     if not Assigned(TiPlotChannelCustomAccess(Channel).XAxis) then Exit;
                     if not Assigned(TiPlotChannelCustomAccess(Channel).YAxis) then Exit;

                     Result := TiPlotChannelCustomAccess(Channel).XAxis.PixelsToPosition(Value);
                   end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.PixelsYToPosition(Value: Integer): Double;
begin
  Result := 0;

  case AnchorReferencePositionY of
    ipraDataView : begin
                     if not Assigned(FDataView) then Exit;
                     if XYAxesReversed then Result := FDataView.PixelsXToPositionPercent(Value)
                     else                   Result := FDataView.PixelsYToPositionPercent(Value)
                   end;
    ipraChannel  : begin
                     if not Assigned(Channel)                                  then Exit;
                     if not Assigned(TiPlotChannelCustomAccess(Channel).XAxis) then Exit;
                     if not Assigned(TiPlotChannelCustomAccess(Channel).YAxis) then Exit;

                     Result := TiPlotChannelCustomAccess(Channel).YAxis.PixelsToPosition(Value);
                   end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.SizeXToPixels(Value: Double): Integer;
begin
  Result := 0;

  case AnchorReferenceSizeX of
    ipraDataView : begin
                     if not Assigned(FDataView) then Exit;
                     if XYAxesReversed then Result := ABS(FDataView.PositionPercentToPixelsY(Value) - FDataView.PositionPercentToPixelsY(0))
                     else                   Result := ABS(FDataView.PositionPercentToPixelsX(Value) - FDataView.PositionPercentToPixelsX(0));
                   end;
    ipraChannel  : begin
                     if not Assigned(Channel      ) then Exit;
                     if not Assigned(Channel.XAxis) then Exit;
                     if not Assigned(Channel.YAxis) then Exit;

                     Result := ABS(Channel.XAxis.PositionToPixels(Channel.XAxis.Min + Value) - Channel.XAxis.PositionToPixels(Channel.XAxis.Min));
                   end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.SizeYToPixels(Value: Double): Integer;
begin
  Result := 0;

  case AnchorReferenceSizeY of
    ipraDataView : begin
                     if not Assigned(FDataView) then Exit;
                     if XYAxesReversed then Result := ABS(FDataView.PositionPercentToPixelsX(Value) - FDataView.PositionPercentToPixelsX(0))
                     else                   Result := ABS(FDataView.PositionPercentToPixelsY(Value) - FDataView.PositionPercentToPixelsY(0));
                   end;
    ipraChannel  : begin
                     if not Assigned(Channel      ) then Exit;
                     if not Assigned(Channel.XAxis) then Exit;
                     if not Assigned(Channel.YAxis) then Exit;

                     Result := ABS(Channel.YAxis.PositionToPixels(Channel.YAxis.Min + Value) - Channel.YAxis.PositionToPixels(Channel.YAxis.Min));
                   end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.PixelsToSizeX(Value: Integer): Double;
begin
  Result := 0;

  case AnchorReferenceSizeX of
    ipraDataView : begin
                     if not Assigned(FDataView) then Exit;
                     if XYAxesReversed then Result := FDataView.PixelsYToPositionPercent(Value)
                     else                   Result := FDataView.PixelsXToPositionPercent(Value)
                   end;
    ipraChannel  : begin
                     if not Assigned(Channel)                                  then Exit;
                     if not Assigned(TiPlotChannelCustomAccess(Channel).XAxis) then Exit;
                     if not Assigned(TiPlotChannelCustomAccess(Channel).YAxis) then Exit;

                     Result := TiPlotChannelCustomAccess(Channel).XAxis.PixelsToPosition(Value);
                   end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.PixelsToSizeY(Value: Integer): Double;
begin
  Result := 0;

  case AnchorReferenceSizeY of
    ipraDataView : begin
                     if not Assigned(FDataView) then Exit;
                     if XYAxesReversed then Result := FDataView.PixelsXToPositionPercent(Value)
                     else                   Result := FDataView.PixelsYToPositionPercent(Value)
                   end;
    ipraChannel  : begin
                     if not Assigned(Channel)                                  then Exit;
                     if not Assigned(TiPlotChannelCustomAccess(Channel).XAxis) then Exit;
                     if not Assigned(TiPlotChannelCustomAccess(Channel).YAxis) then Exit;

                     Result := TiPlotChannelCustomAccess(Channel).YAxis.PixelsToPosition(Value);
                   end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetAnchorReferencePositionX: TiPlotReferenceAnchor;
begin
  case ReferencePositionX of
    ipriDataView : Result := ipraDataView;
    ipriChannel  : Result := ipraChannel;
    else
      case Reference of
        iprtDataView          : Result := ipraDataView;
        iprtXDataViewYChannel : Result := ipraDataView;
        iprtChannel           : Result := ipraChannel;
        iprtXChannelYDataView : Result := ipraChannel;
        else                    Result := ipraDataView;
      end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetAnchorReferencePositionY: TiPlotReferenceAnchor;
begin
  case ReferencePositionY of
    ipriDataView : Result := ipraDataView;
    ipriChannel  : Result := ipraChannel;
    else
      case Reference of
        iprtDataView          : Result := ipraDataView;
        iprtXDataViewYChannel : Result := ipraChannel;
        iprtChannel           : Result := ipraChannel;
        iprtXChannelYDataView : Result := ipraDataView;
        else                    Result := ipraDataView;
      end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetAnchorReferenceSizeX: TiPlotReferenceAnchor;
begin
  case ReferenceSizeX of
    ipriDataView : Result := ipraDataView;
    ipriChannel  : Result := ipraChannel;
    else
      case Reference of
        iprtDataView          : Result := ipraDataView;
        iprtXDataViewYChannel : Result := ipraDataView;
        iprtChannel           : Result := ipraChannel;
        iprtXChannelYDataView : Result := ipraChannel;
        else                    Result := ipraDataView;
      end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetAnchorReferenceSizeY: TiPlotReferenceAnchor;
begin
  case ReferenceSizeY of
    ipriDataView : Result := ipraDataView;
    ipriChannel  : Result := ipraChannel;
    else
      case Reference of
        iprtDataView          : Result := ipraDataView;
        iprtXDataViewYChannel : Result := ipraChannel;
        iprtChannel           : Result := ipraChannel;
        iprtXChannelYDataView : Result := ipraDataView;
        else                    Result := ipraDataView;
      end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.NotificationSetFocus(Sender: TObject);
begin
  if Sender = Self                             then Exit;
  if not (Sender as TiPlotObject).UserSelected then Exit;
  SetUserSelected(False);
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.IsMoveable: Boolean;
begin
  Result := FUserCanMove;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.IsSizeable: Boolean;
begin
  Result := False;

  if not FUserCanSize then Exit;

  if FStyle = ipasRectangle     then Result := True;
  if FStyle = ipasRectangle2    then Result := True;
  if FStyle = ipasTextRectangle then Result := True;
  if FStyle = ipasEllipse       then Result := True;
  if FStyle = ipasEllipse2      then Result := True;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetXMax: Integer;
begin
  Result := 0;
  if not Assigned(FDataView) then Exit;

  if XYAxesReversed then Result := FDataView.DrawRect.Top
  else                   Result := FDataView.DrawRect.Right
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetXMin: Integer;
begin
  Result := 0;
  if not Assigned(FDataView) then Exit;

  if XYAxesReversed then Result := FDataView.DrawRect.Bottom
  else                   Result := FDataView.DrawRect.Left
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetYMax: Integer;
begin
  Result := 0;
  if not Assigned(FDataView) then Exit;

  if XYAxesReversed then Result := FDataView.DrawRect.Right
  else                   Result := FDataView.DrawRect.Top
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetYMin: Integer;
begin
  Result := 0;
  if not Assigned(FDataView) then Exit;

  if XYAxesReversed then Result := FDataView.DrawRect.Left
  else                   Result := FDataView.DrawRect.Bottom
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetPolyPoint(Index: Integer): TiPlotAnnotationPoint;
begin
  if not Assigned(FPolyPoints) then FPolyPoints := TStringList.Create;
  Result := FPolyPoints.Objects[Index] as TiPlotAnnotationPoint;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetPolyPointsCount: Integer;
begin
  if not Assigned(FPolyPoints) then FPolyPoints := TStringList.Create;
  Result := FPolyPoints.Count;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.PolyPointAdd(X, Y: Double): Integer;
var
  APolyPoint : TiPlotAnnotationPoint;
begin
  if not Assigned(FPolyPoints) then FPolyPoints := TStringList.Create;

  APolyPoint   := TiPlotAnnotationPoint.Create;
  APolyPoint.X := X;
  APolyPoint.Y := Y;

  Result := FPolyPoints.AddObject('', APolyPoint);
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.PolyPointsClear;
begin
  if not Assigned(FPolyPoints) then FPolyPoints := TStringList.Create;

  while PolyPointsCount <> 0 do
    begin
      FPolyPoints.Objects[0].Free;
      FPolyPoints.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetPolyPointX(Index: Integer): Double;
begin
  Result := PolyPoint[Index].X;
end;
//****************************************************************************************************************************************************
function TiPlotAnnotation.GetPolyPointY(Index: Integer): Double;
begin
  Result := PolyPoint[Index].Y;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetPolyPointX(Index: Integer; const Value: Double);
begin
  PolyPoint[Index].X := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.SetPolyPointY(Index: Integer; const Value: Double);
begin
  PolyPoint[Index].Y := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.ImageClear;
begin
  if Assigned(FImage) then
    begin
     FImage.Free;
     FImage := nil;
     TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAnnotation.ImageLoadFromFile(FileName: String);
var
  ABitmap : TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    ABitmap.LoadFromFile(FileName);
    Image := ABitmap;
  finally
    ABitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
end.

