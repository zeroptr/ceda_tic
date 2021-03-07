{*******************************************************}
{                                                       }
{       TiPlotLimit                                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotLimit;{$endif}
{$ifdef iCLX}unit QiPlotLimit;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iClasses,  iPlotObjects,  iPlotDataView,  iPlotAxis;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiClasses, QiPlotObjects, QiPlotDataView, QiPlotAxis;{$ENDIF}

type
  TiPlotLimitStyle            = (iplsLineX, iplsLineY, iplsBandX, iplsBandY, iplsPolyBandX, iplsPolyBandY);
  TiPlotLimitLinePositionAxis = (iplpaXAxis, iplpaYAxis);

  TiPlotLimit = class(TiPlotObject)
  private
    FPointList                 : TiLimitDataList;

    FMouseDownLine1            : Boolean;
    FMouseDownLine2            : Boolean;

    FXAxis                     : TiPlotXAxis;
    FYAxis                     : TiPlotYAxis;

    FYAxisName                 : String;
    FXAxisName                 : String;

    FStyle                     : TiPlotLimitStyle;

    FColor                     : TColor;
    FLineWidth                 : Integer;
    FLineStyle                 : TPenStyle;
    FFillStyle                 : TBrushStyle;

    FLine1Show                 : Boolean;
    FLine2Show                 : Boolean;

    FLine1Position             : Double;
    FLine2Position             : Double;

    FLine1ClickRect            : TRect;
    FLine2ClickRect            : TRect;
    FUserCanMove               : Boolean;
    FSelectModeOnlyInteraction : Boolean;
    FClipToAxes                : Boolean;
  protected
    procedure SetFillStyle    (const Value: TBrushStyle);
    procedure SetColor        (const Value: TColor);
    procedure SetLineStyle    (const Value: TPenStyle);
    procedure SetLineWidth    (const Value: Integer);
    procedure SetStyle        (const Value: TiPlotLimitStyle);
    procedure SetXAxisName    (const Value: String);
    procedure SetYAxisName    (const Value: String);
    procedure SetLine1Position(const Value: Double);
    procedure SetLine2Position(const Value: Double);
    procedure SetUserCanMove  (const Value: Boolean);
    procedure SetClipToAxes   (const Value: Boolean);

    procedure NotificationRemove  (Sender: TObject); override;
    procedure NotificationRename  (Sender: TObject); override;
    procedure NotificationSetFocus(Sender: TObject); override;

    function GetXAxis : TiPlotXAxis;
    function GetYAxis : TiPlotYAxis;

    function GetIsFillType       : Boolean;
    function GetLinePositionAxis : TiPlotLimitLinePositionAxis;

    procedure Draw         (const Canvas: TCanvas; const BackGroundColor: TColor); override;
    procedure DrawLineX    (const Canvas: TCanvas; const BackGroundColor: TColor);
    procedure DrawLineY    (const Canvas: TCanvas; const BackGroundColor: TColor);
    procedure DrawBandX    (const Canvas: TCanvas; const BackGroundColor: TColor);
    procedure DrawBandY    (const Canvas: TCanvas; const BackGroundColor: TColor);             
    procedure DrawPolyBandX(const Canvas: TCanvas; const BackGroundColor: TColor);
    procedure DrawPolyBandY(const Canvas: TCanvas; const BackGroundColor: TColor);

    procedure DoMouseLeft(MouseData: TiPlotMouseData);                                                 override;
    procedure DoMouseMove(MouseData: TiPlotMouseData);                                                 override;
    procedure DoMouseUp  (MouseData: TiPlotMouseData);                                                 override;

    procedure AddMenuItems(PopupMenu: TPopUpMenu);                                                     override;

    function  GetMousePointer(APoint: TPoint): TCursor;                                                override;

    function  iMouseHitTest(MouseData: TiPlotMouseData): Boolean;                                      override;

    property LinePositionAxis : TiPlotLimitLinePositionAxis read GetLinePositionAxis;

    property IsFillType    : Boolean          read GetIsFillType;

    property XAxis         : TiPlotXAxis      read GetXAxis;
    property YAxis         : TiPlotYAxis      read GetYAxis;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); override;
    destructor  Destroy;                                                                               override;

    procedure ClearAllElements;
    procedure AddBandElement(Position, UpperLimit, LowerLimit: Double);
  published
    property Color                     : TColor                    read FColor                     write SetColor;
    property LineStyle                 : TPenStyle                 read FLineStyle                 write SetLineStyle;
    property LineWidth                 : Integer                   read FLineWidth                 write SetLineWidth;
    property FillStyle                 : TBrushStyle               read FFillStyle                 write SetFillStyle;

    property XAxisName                 : String                    read FXAxisName                 write SetXAxisName;
    property YAxisName                 : String                    read FYAxisName                 write SetYAxisName;

    property Style                     : TiPlotLimitStyle          read FStyle                     write SetStyle;

    property Line1Position             : Double                    read FLine1Position             write SetLine1Position;
    property Line2Position             : Double                    read FLine2Position             write SetLine2Position;

    property UserCanMove               : Boolean                   read FUserCanMove               write SetUserCanMove;
    property SelectModeOnlyInteraction : Boolean                   read FSelectModeOnlyInteraction write FSelectModeOnlyInteraction;
    property ClipToAxes                : Boolean                   read FClipToAxes                write SetClipToAxes;
  end;

implementation

uses
{$ifdef iVCL} iPlotComponent;{$endif}
{$ifdef iCLX}QiPlotComponent;{$endif}

type
  TiPlotComponentAccess = class(TiPlotComponent)end;
//****************************************************************************************************************************************************
constructor TiPlotLimit.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited Create(AOwner, AOnChange, AOnInsert, AOnRemove, AOnRename);

  FStyle         := iplsLineY;
  FColor         := clRed;
  FLine1Position := 50;
  FLine2Position := 50;

  FSelectModeOnlyInteraction := True;

  FPointList := TiLimitDataList.Create;
end;
//****************************************************************************************************************************************************
destructor TiPlotLimit.Destroy;
begin
  FPointList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
function TiPlotLimit.GetXAxis: TiPlotXAxis;
begin
  if not Assigned(FXAxis)then FXAxis:=(Owner as TiPlotComponent).GetXAxisByName(FXAxisName);
  Result := FXAxis;
end;
//****************************************************************************************************************************************************
function TiPlotLimit.GetYAxis: TiPlotYAxis;
begin
  if not Assigned(FYAxis)then FYAxis:=(Owner as TiPlotComponent).GetYAxisByName(FYAxisName);
  Result := FYAxis;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.NotificationRemove(Sender: TObject);
begin
  if Sender = FXAxis then FXAxis := nil;
  if Sender = FYAxis then FYAxis := nil;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.NotificationRename(Sender: TObject);
begin
  if Sender = FXAxis then FXAxisName := (Sender as TiPlotXAxis).Name;
  if Sender = FYAxis then FYAxisName := (Sender as TiPlotYAxis).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.SetXAxisName(const Value: String);
begin
  if FXAxisName <> Value then
    begin
      FXAxisName := Value;
      FXAxis     := nil;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.SetYAxisName(const Value: String);
begin
  if FYAxisName <> Value then
    begin
      FYAxisName := Value;
      FYAxis := nil;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.SetColor        (const Value: TColor );begin SetColorProperty  (Value,FColor,        TriggerChange );end;
procedure TiPlotLimit.SetLineWidth    (const Value: Integer);begin SetIntegerProperty(Value,FLineWidth,    TriggerChange );end;
procedure TiPlotLimit.SetUserCanMove  (const Value: Boolean);begin SetBooleanProperty(Value,FUserCanMove,  TriggerChange );end;
procedure TiPlotLimit.SetClipToAxes   (const Value: Boolean);begin SetBooleanProperty(Value,FClipToAxes,   TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.SetStyle    (const Value:TiPlotLimitStyle);begin if FStyle    <>Value then begin FStyle    :=Value;TriggerChange(Self);end;end;
procedure TiPlotLimit.SetLineStyle(const Value:TPenStyle       );begin if FLineStyle<>Value then begin FLineStyle:=Value;TriggerChange(Self);end;end;
procedure TiPlotLimit.SetFillStyle(const Value:TBrushStyle     );begin if FFillStyle<>Value then begin FFillStyle:=Value;TriggerChange(Self);end;end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.SetLine1Position(const Value: Double );
var
  OldValue  : Double;
begin
  if FLine1Position <> Value then
    begin
      OldValue := FLine1Position;
      FLine1Position := Value;
      TriggerChange(Self);
      if Owner is TiPlotComponent then
        TiPlotComponentAccess(Owner).DoLimitLine1PositionChange(Self, OldValue, Value);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.SetLine2Position(const Value: Double );
var
  OldValue  : Double;
begin
  if FLine2Position <> Value then
    begin
      OldValue := FLine2Position;
      FLine2Position := Value;
      TriggerChange(Self);
      if Owner is TiPlotComponent then
        TiPlotComponentAccess(Owner).DoLimitLine2PositionChange(Self, OldValue, Value);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotLimit.GetLinePositionAxis: TiPlotLimitLinePositionAxis;
begin
  case FStyle of
    iplsLineX     : Result := iplpaXAxis;
    iplsLineY     : Result := iplpaYAxis;
    iplsBandX     : Result := iplpaXAxis;
    iplsBandY     : Result := iplpaYAxis;
    iplsPolyBandX : Result := iplpaXAxis;
    iplsPolyBandY : Result := iplpaYAxis;
    else            Result := iplpaYAxis;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  ARect : TRect;
begin
  FLine1Show := False;
  FLine2Show := False;

  if not Visible then Exit;
  if not Assigned(XAxis) then Exit;
  if not Assigned(YAxis) then Exit;

  if (FClipToAxes) then
    begin
      if XYAxesReversed then ARect := iRect(YAxis.MinPixels, XAxis.MinPixels, YAxis.MaxPixels, XAxis.MaxPixels)
      else                   ARect := iRect(XAxis.MinPixels, YAxis.MinPixels, XAxis.MaxPixels, YAxis.MaxPixels);
      {$IFDEF iVCL}
      IntersectClipRect(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      {$ENDIF}
    end;

  case FStyle of
    iplsLineY     : DrawLineY    (Canvas, BackGroundColor);
    iplsLineX     : DrawLineX    (Canvas, BackGroundColor);
    iplsBandX     : DrawBandX    (Canvas, BackGroundColor);
    iplsBandY     : DrawBandY    (Canvas, BackGroundColor);
    iplsPolyBandX : DrawPolyBandX(Canvas, BackGroundColor);
    iplsPolyBandY : DrawPolyBandY(Canvas, BackGroundColor);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.DrawLineX(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  XPixels  : Integer;
  Y1Pixels : Integer;
  Y2Pixels : Integer;
begin
  if Line1Position > XAxis.Max then Exit;
  if Line1Position < XAxis.Min then Exit;

  with Canvas do
    begin
      Pen.Color   := Color;
      Pen.Width   := LineWidth;
      Pen.Style   := LineStyle;
      Brush.Color := BackGroundColor;

      XPixels   := XAxis.PositionToPixels(Line1Position);

      Y1Pixels  := YAxis.PositionToPixels(YAxis.Min);
      Y2Pixels  := YAxis.PositionToPixels(YAxis.Max);

      Polyline([iPointReverse(XYAxesReversed, XPixels, Y1Pixels), iPointReverse(XYAxesReversed, XPixels, Y2Pixels)]);

      FLine1Show      := True;
      FLine1ClickRect := iXYReverseRect(XYAxesReversed, XPixels - 5, Y1Pixels, XPixels + 5, Y2Pixels);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.DrawLineY(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  YPixels  : Integer;
  X1Pixels : Integer;
  X2Pixels : Integer;
begin
  if Line1Position > YAxis.Max then Exit;
  if Line1Position < YAxis.Min then Exit;

  with Canvas do
    begin
      Pen.Color   := Color;
      Pen.Width   := LineWidth;
      Pen.Style   := LineStyle;
      Brush.Color := BackGroundColor;

      YPixels  := YAxis.PositionToPixels(Line1Position);

      X1Pixels := XAxis.PositionToPixels(XAxis.Min);
      X2Pixels := XAxis.PositionToPixels(XAxis.Max);

      Polyline([iPointReverse(XYAxesReversed, X1Pixels, YPixels), iPointReverse(XYAxesReversed, X2Pixels, YPixels)]);

      FLine1Show      := True;
      FLine1ClickRect := iXYReverseRect(XYAxesReversed, X1Pixels, YPixels - 5, X2Pixels, YPixels + 5);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.DrawBandX(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  X1Pixels : Integer;
  X2Pixels : Integer;
  Y1Pixels : Integer;
  Y2Pixels : Integer;
begin
  with Canvas do
    begin
      Pen.Color := Color;

      Brush.Color := Color;
      Brush.Style := FillStyle;

      X1Pixels := XAxis.PositionToPixels(Line1Position);
      X2Pixels := XAxis.PositionToPixels(Line2Position);

      Y1Pixels := YAxis.PositionToPixels(YAxis.Min);
      Y2Pixels := YAxis.PositionToPixels(YAxis.Max);

      FLine1ClickRect := iXYReverseRect(XYAxesReversed, X1Pixels - 5, Y1Pixels, X1Pixels + 5, Y2Pixels);
      FLine1Show      := True;

      FLine2ClickRect := iXYReverseRect(XYAxesReversed, X2Pixels - 5, Y1Pixels, X2Pixels + 5, Y2Pixels);
      FLine2Show      := True;

      if FFillStyle = bsSolid then
        begin
          Pen.Style := LineStyle;
          Pen.Width := 1;
          if XYAxesReversed then
            Rectangle(Y1Pixels, X1Pixels, Y2Pixels, X2Pixels)
          else
            Rectangle(X1Pixels, Y1Pixels, X2Pixels, Y2Pixels);
        end
      else if FFillStyle = bsClear then
        begin
          Pen.Style := LineStyle;
          Pen.Width := LineWidth;
          Polyline([iPointReverse(XYAxesReversed, X1Pixels, Y1Pixels), iPointReverse(XYAxesReversed, X1Pixels, Y2Pixels)]);
          Polyline([iPointReverse(XYAxesReversed, X2Pixels, Y1Pixels), iPointReverse(XYAxesReversed, X2Pixels, Y2Pixels)]);
        end
      else
        begin
          Pen.Style := psClear;
          if XYAxesReversed then
            Rectangle(Y1Pixels, X1Pixels, Y2Pixels, X2Pixels)
          else
            Rectangle(X1Pixels, Y1Pixels, X2Pixels, Y2Pixels);

          Pen.Style := LineStyle;
          Pen.Width := 1;
          Polyline([iPointReverse(XYAxesReversed, X1Pixels, Y1Pixels), iPointReverse(XYAxesReversed, X1Pixels, Y2Pixels)]);
          Polyline([iPointReverse(XYAxesReversed, X2Pixels, Y1Pixels), iPointReverse(XYAxesReversed, X2Pixels, Y2Pixels)]);
        end
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.DrawBandY(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  X1Pixels : Integer;
  X2Pixels : Integer;
  Y1Pixels : Integer;
  Y2Pixels : Integer;
begin
  with Canvas do
    begin
      Pen.Color := Color;

      Brush.Color := Color;
      Brush.Style := FillStyle;

      Y1Pixels := YAxis.PositionToPixels(Line1Position);
      Y2Pixels := YAxis.PositionToPixels(Line2Position);

      X1Pixels := XAxis.PositionToPixels(XAxis.Min);
      X2Pixels := XAxis.PositionToPixels(XAxis.Max);

      FLine1Show      := True;
      FLine1ClickRect := iXYReverseRect(XYAxesReversed, X1Pixels, Y1Pixels - 5, X2Pixels, Y1Pixels + 5);

      FLine2Show      := True;
      FLine2ClickRect := iXYReverseRect(XYAxesReversed, X1Pixels, Y2Pixels - 5, X2Pixels, Y2Pixels + 5);

      if FFillStyle = bsSolid then
        begin
          Pen.Style := LineStyle;
          Pen.Width := 1;
          if XYAxesReversed then
            Rectangle(Y1Pixels, X1Pixels, Y2Pixels, X2Pixels)
          else
            Rectangle(X1Pixels, Y1Pixels, X2Pixels, Y2Pixels);
        end
      else if FFillStyle = bsClear then
        begin
          Pen.Style := LineStyle;
          Pen.Width := LineWidth;
          Polyline([iPointReverse(XYAxesReversed, X1Pixels, Y1Pixels), iPointReverse(XYAxesReversed, X2Pixels, Y1Pixels)]);
          Polyline([iPointReverse(XYAxesReversed, X1Pixels, Y2Pixels), iPointReverse(XYAxesReversed, X2Pixels, Y2Pixels)]);
        end
      else
        begin
          Pen.Style := psClear;
          if XYAxesReversed then
            Rectangle(Y1Pixels, X1Pixels, Y2Pixels, X2Pixels)
          else
            Rectangle(X1Pixels, Y1Pixels, X2Pixels, Y2Pixels);

          Pen.Style := LineStyle;
          Pen.Width := 1;
          Polyline([iPointReverse(XYAxesReversed, X1Pixels, Y1Pixels), iPointReverse(XYAxesReversed, X2Pixels, Y1Pixels)]);
          Polyline([iPointReverse(XYAxesReversed, X1Pixels, Y2Pixels), iPointReverse(XYAxesReversed, X2Pixels, Y2Pixels)]);
        end
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.DrawPolyBandX(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  x        : Integer;

  Data1    : Double;
  Data2    : Double;
  Data3    : Double;

  Point1   : TPoint;
  Point2   : TPoint;
  Point3   : TPoint;
  Point4   : TPoint;
begin
  if FPointList.Count < 2 then Exit;

  with Canvas do
    begin
      Pen.Color := Color;
      Pen.Width := 1;
      Pen.Style := psSolid;

      Brush.Color := Color;
      Brush.Style := FillStyle;

      for x := 1 to FPointList.Count-1 do
        begin
          if (FPointList.Item1[x-1] < YAxis.Min) and (FPointList.Item1[x] < YAxis.Min) then Continue;

          Data1 := FPointList.Item1[x-1];
          Data2 := FPointList.Item2[x-1];
          Data3 := FPointList.Item3[x-1];

          if Data1 > YAxis.Max then Break;

          Point1 := iPointReverse(XYAxesReversed,XAxis.PositionToPixels(Data2), YAxis.PositionToPixels(Data1));
          Point2 := iPointReverse(XYAxesReversed,XAxis.PositionToPixels(Data3), YAxis.PositionToPixels(Data1));

          Data1 := FPointList.Item1[x];
          Data2 := FPointList.Item2[x];
          Data3 := FPointList.Item3[x];

          Point3 := iPointReverse(XYAxesReversed,XAxis.PositionToPixels(Data2), YAxis.PositionToPixels(Data1));
          Point4 := iPointReverse(XYAxesReversed,XAxis.PositionToPixels(Data3), YAxis.PositionToPixels(Data1));

          if FFillStyle = bsSolid then
            begin
              Polygon([Point1, Point3, Point4, Point2]);
            end
          else
            begin
              Pen.Style := psClear;
              Polygon([Point1, Point3, Point4, Point2]);

              Pen.Style := psSolid;

              Polyline([Point1, Point3]);
              Polyline([Point2, Point4]);
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.DrawPolyBandY(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  x        : Integer;

  Data1    : Double;
  Data2    : Double;
  Data3    : Double;

  Point1   : TPoint;
  Point2   : TPoint;
  Point3   : TPoint;
  Point4   : TPoint;
begin
  if FPointList.Count < 2 then Exit;

  with Canvas do
    begin
      Pen.Color := Color;
      Pen.Width := 1;
      Pen.Style := psSolid;

      Brush.Color := Color;
      Brush.Style := FillStyle;

      for x := 1 to FPointList.Count-1 do
        begin
          if (FPointList.Item1[x-1] < XAxis.Min) and (FPointList.Item1[x] < XAxis.Min) then Continue;

          Data1 := FPointList.Item1[x-1];
          Data2 := FPointList.Item2[x-1];
          Data3 := FPointList.Item3[x-1];

          if Data1 > XAxis.Max then Break;

          Point1 := iPointReverse(XYAxesReversed,XAxis.PositionToPixels(Data1), YAxis.PositionToPixels(Data2));
          Point2 := iPointReverse(XYAxesReversed,XAxis.PositionToPixels(Data1), YAxis.PositionToPixels(Data3));

          Data1 := FPointList.Item1[x];
          Data2 := FPointList.Item2[x];
          Data3 := FPointList.Item3[x];

          Point3 := iPointReverse(XYAxesReversed,XAxis.PositionToPixels(Data1), YAxis.PositionToPixels(Data2));
          Point4 := iPointReverse(XYAxesReversed,XAxis.PositionToPixels(Data1), YAxis.PositionToPixels(Data3));

          if FFillStyle = bsSolid then
            begin
              Polygon([Point1, Point3, Point4, Point2]);
            end
          else
            begin
              Pen.Style := psClear;
              Polygon([Point1, Point3, Point4, Point2]);

              Pen.Style := psSolid;

              Polyline([Point1, Point3]);
              Polyline([Point2, Point4]);
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.AddBandElement(Position, UpperLimit, LowerLimit: Double);
begin
  if LowerLimit > UpperLimit then raise Exception.Create('the Upper Limit must be greater than or equal to the Lower Limit');
  FPointList.Add(Position, UpperLimit, LowerLimit);
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.ClearAllElements;
begin
  FPointList.Clear;
  TriggerChange(Self);                        
end;
//****************************************************************************************************************************************************
function TiPlotLimit.GetIsFillType: Boolean;
begin
                                                          Result := True;
  if  FStyle = iplsLineX                             then Result := False;
  if  FStyle = iplsLineY                             then Result := False;
  if (FStyle = iplsBandX) and (FFillStyle = bsClear) then Result := False;
  if (FStyle = iplsBandY) and (FFillStyle = bsClear) then Result := False;
end;
//****************************************************************************************************************************************************
function TiPlotLimit.iMouseHitTest(MouseData: TiPlotMouseData): Boolean;
begin
  Result := inherited iMouseHitTest(MouseData);

  if FSelectModeOnlyInteraction and not TiPlotComponentAccess(Owner).SelectModeActive then Exit;

  if FLine1Show then if PtInRect(FLine1ClickRect, Point(MouseData.X,MouseData.Y)) then Result := True;
  if FLine2Show then if PtInRect(FLine2ClickRect, Point(MouseData.X,MouseData.Y)) then Result := True;
end;
//****************************************************************************************************************************************************
function TiPlotLimit.GetMousePointer(APoint: TPoint): TCursor;
begin
  Result := crDefault;
  if not FUserCanMove then Exit;

  Result := crHandPoint;

  if FLine1Show and FLine2Show then
    begin
      if LinePositionAxis = iplpaXAxis then
        begin
          if XYAxesReversed then Result := crSizeNS else Result := crSizeWE;
        end
      else
        begin
          if XYAxesReversed then Result := crSizeWE else Result := crSizeNS;
        end;
    end;

  TiPlotComponentAccess(Owner).DoGetMouseCursor(Self, Result);
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.DoMouseLeft(MouseData: TiPlotMouseData);
begin
  if not FUserCanMove then Exit;

  if FLine1Show and PtInRect(FLine1ClickRect, Point(MouseData.X, MouseData.Y)) then
    begin
      FMouseDownLine1 := True;
      TriggerInvalidateNow(Self);
    end
  else if FLine2Show and PtInRect(FLine2ClickRect, Point(MouseData.X, MouseData.Y)) then
    begin
      FMouseDownLine2 := True;
      TriggerInvalidateNow(Self);
    end
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.DoMouseMove(MouseData: TiPlotMouseData);
begin
  if FMouseDownLine1 then
    begin
      case LinePositionAxis of
        iplpaXAxis : Line1Position := XAxis.PixelsToPosition(MouseData.XAxisPixels);
        iplpaYAxis : Line1Position := YAxis.PixelsToPosition(MouseData.YAxisPixels);
      end;
    end;
  if FMouseDownLine2 then
    begin
      case LinePositionAxis of
        iplpaXAxis : Line2Position := XAxis.PixelsToPosition(MouseData.XAxisPixels);
        iplpaYAxis : Line2Position := YAxis.PixelsToPosition(MouseData.YAxisPixels);
      end;
    end
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.DoMouseUp(MouseData: TiPlotMouseData);
begin
  if not FMouseDownLine1 and not FMouseDownLine2 then Exit;

  FMouseDownLine1 := False;
  FMouseDownLine2 := False;

  if iMouseHitTest(MouseData) then TiPlotComponentAccess(Owner).DoObjectClick(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.NotificationSetFocus(Sender: TObject);
begin
  if Sender = Self                             then Exit;
  if not (Sender as TiPlotObject).UserSelected then Exit;

  SetUserSelected(False);
end;
//****************************************************************************************************************************************************
procedure TiPlotLimit.AddMenuItems(PopupMenu: TPopUpMenu);
begin
  inherited;
  AddEditMenuItems(PopupMenu);
end;
//****************************************************************************************************************************************************
end.
