{*******************************************************}
{                                                       }
{       TiPlotDataCursor                                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotDataCursor;{$endif}
{$ifdef iCLX}unit QiPlotDataCursor;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iPlotObjects,  iPlotChannelCustom,  iPlotChannel, iPlotDataView;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiPlotObjects, QiPlotChannelCustom, QiPlotChannel, QiPlotDataView;{$ENDIF}

type
  TiPlotDataCursor = class(TiPlotManagerObject)
  private
    FMouseDownXPixels             : Integer;
    FMouseDownYPixels             : Integer;

    FMouseDownX                   : Integer;
    FMouseDownY                   : Integer;

    FMouseDownHint                : Boolean;

    FMouseDownPointer1            : Boolean;
    FMouseDownPointer2            : Boolean;

    FPointer1Rect                 : TRect;
    FPointer2Rect                 : TRect;

    FPointer1Show                 : Boolean;
    FPointer2Show                 : Boolean;

    FPointer1Orientation          : TiOrientation;
    FPointer2Orientation          : TiOrientation;

    FHintRect                     : TRect;
    FHintOrientation              : TiOrientation;
    FHintShowing                  : Boolean;

    FChannel                      : TiPlotChannelCustom;
    FDataView                     : TiPlotDataView;
    FChannelName                  : String;
    FStyle                        : TiPlotDataCursorStyle;
    FUseChannelColor              : Boolean;
    FPointer1Position             : Double;
    FPointer2Position             : Double;
    FPointerPenWidth              : Integer;
    FChannelShowAllInLegend       : Boolean;
    FChannelAllowAll              : Boolean;
    FColor                        : TColor;
    FFont                         : TFont;
    FHintShow                     : Boolean;
    FHintHideOnRelease            : Boolean;
    FHintOrientationSide          : TiOrientationSide;
    FHintHeight                   : Integer;
    FHintWidth                    : Integer;
    FHintPosition                 : Double;
    FCursorDisplayText            : String;
    FValueX                       : Double;
    FValueY                       : Double;
    FStatus                       : TiPlotDataPointStatus;
    FScopeStyle                   : Boolean;
    FSnapToDataPoint              : Boolean;
    FUseCachedInterpolatedData    : Boolean;

    FSnapToIndexChannel           : Integer;
    FSnapToIndexData              : Integer;

    FMenuItemCaptionValueXY       : String;
    FMenuItemCaptionValueX        : String;
    FMenuItemCaptionValueY        : String;
    FMenuItemCaptionDeltaX        : String;
    FMenuItemCaptionDeltaY        : String;
    FMenuItemCaptionInverseDeltaX : String;
    FMenuItemVisibleDeltaX        : Boolean;
    FMenuItemVisibleDeltaY        : Boolean;
    FMenuItemVisibleValueXY       : Boolean;
    FMenuItemVisibleInverseDeltaX : Boolean;
    FMenuItemVisibleValueX        : Boolean;
    FMenuItemVisibleValueY        : Boolean;
    FMenuUserCanChangeOptions     : Boolean;
  protected
    procedure SetChannelName           (const Value: String);
    procedure SetStyle                 (const Value: TiPlotDataCursorStyle);
    procedure SetUseChannelColor       (const Value: Boolean);
    procedure SetColor                 (const Value: TColor);
    procedure SetFont                  (const Value: TFont);
    procedure SetHintHideOnRelease     (const Value: Boolean);
    procedure SetHintShow              (const Value: Boolean);
    procedure SetHintOrientationSide   (const Value: TiOrientationSide);
    procedure SetHintPosition          (const Value: Double);
    procedure SetPointer1Position      (const Value: Double);
    procedure SetPointer2Position      (const Value: Double);
    procedure SetPointerPenWidth       (const Value: Integer);
    procedure SetChannelAllowAll       (const Value: Boolean);
    procedure SetChannelShowAllInLegend(const Value: Boolean);
    procedure SetScopeStyle            (const Value: Boolean);

    procedure AllChannelsMenuItemClick       (Sender: TObject);
    procedure ChannelNameMenuItemClick       (Sender: TObject);
    procedure FlipMenuItemClick              (Sender: TObject);
    procedure UseChannelColorMenuItemClick   (Sender: TObject);
    procedure HideHintOnReleaseMenuItemClick (Sender: TObject);
    procedure StyleValueXYMenuItemClick      (Sender: TObject);
    procedure StyleValueXMenuItemClick       (Sender: TObject);
    procedure StyleValueYMenuItemClick       (Sender: TObject);
    procedure StyleDeltaXMenuItemClick       (Sender: TObject);
    procedure StyleDeltaYMenuItemClick       (Sender: TObject);
    procedure StyleInverseDeltaXMenuItemClick(Sender: TObject);
    procedure SnapToDataPointMenuItemClick   (Sender: TObject);

    procedure SetData(XValue, YValue: Double; Status: TiPlotDataPointStatus);

    function  GetChannel: TiPlotChannelCustom;

    function  GetIsXYPlot: Boolean;

    procedure NotificationRemove (Sender : TObject); override;
    procedure NotificationRename (Sender : TObject); override;
    procedure NotificationSetFocus(Sender: TObject);                                                     override;

    procedure DoMouseLeft(MouseData: TiPlotMouseData);                                                   override;
    procedure DoMouseMove(MouseData: TiPlotMouseData);                                                   override;
    procedure DoMouseUp  (MouseData: TiPlotMouseData);                                                   override;
    procedure DoSetFocus;                                                                                override;

    function  iMouseHitTest(MouseData: TiPlotMouseData): Boolean;                                        override;
    function  GetMousePointer(APoint: TPoint): TCursor;                                                  override;

    procedure iKeyDown            (var CharCode: Word; Shift: TShiftState; PopupMenu : TPopupMenu);      override;
    procedure DoKeySnapToDataPoint(var CharCode: Word; Shift: TShiftState; PopupMenu: TPopupMenu);

    procedure SetVisible       (const Value: Boolean);                                                   override;
    procedure SetXYAxesReversed(const Value: Boolean);                                                   override;

    procedure AddMenuItems(PopupMenu: TPopUpMenu);                                                       override;

    procedure DoUpdate;

    procedure MoveHint(Direction : TiCountDirection);

    procedure MoveCursorToDataPoint(ChannelIndex, DataIndex, Delta, PointerNumber: Integer);
    function  GetNearestSnapToIndex(Channel: TiPlotChannel; TargetX, PointerPosition: Double; var Delta: Double): Integer;
    procedure DoSnapTo(PointerNumber: Integer);

    procedure DoSetup;

    procedure Draw       (const Canvas: TCanvas; const BackGroundColor: TColor);                         override;
    procedure DrawPointer(const Canvas: TCanvas; Position: Double; Orientation: TiOrientation; var PointerRect: TRect);

    procedure DrawHint   (const Canvas: TCanvas; const BackGroundColor: TColor);

    property CursorDisplayText            : String                read FCursorDisplayText write FCursorDisplayText;
    property DataView                     : TiPlotDataView        read FDataView          write FDataView;
    property Channel                      : TiPlotChannelCustom   read GetChannel;
    property ScopeStyle                   : Boolean               read FScopeStyle        write SetScopeStyle;
    property IsXYPlot                     : Boolean               read GetIsXYPlot;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);    override;
    destructor  Destroy;                                                                              override;

    function  GetInterpolatedYValue(ChannelName: String; XValue: Double; var YValue: Double): TiPlotDataPointStatus;

    procedure DoSnapToDataPoint();

    property ValueX                       : Double                read FValueX;
    property ValueY                       : Double                read FValueY;
    property Status                       : TiPlotDataPointStatus read FStatus;
  published
    property ChannelName                  : String                read FChannelName                  write SetChannelName;
    property ChannelAllowAll              : Boolean               read FChannelAllowAll              write SetChannelAllowAll;
    property ChannelShowAllInLegend       : Boolean               read FChannelShowAllInLegend       write SetChannelShowAllInLegend;

    property Style                        : TiPlotDataCursorStyle read FStyle                        write SetStyle;
    property Font                         : TFont                 read FFont                         write SetFont;
    property Color                        : TColor                read FColor                        write SetColor;
    property UseChannelColor              : Boolean               read FUseChannelColor              write SetUseChannelColor;

    property HintShow                     : Boolean               read FHintShow                     write SetHintShow;
    property HintHideOnRelease            : Boolean               read FHintHideOnRelease            write SetHintHideOnRelease;
    property HintOrientationSide          : TiOrientationSide     read FHintOrientationSide          write SetHintOrientationSide;
    property HintPosition                 : Double                read FHintPosition                 write SetHintPosition;

    property Pointer1Position             : Double                read FPointer1Position             write SetPointer1Position;
    property Pointer2Position             : Double                read FPointer2Position             write SetPointer2Position;

    property PointerPenWidth              : Integer               read FPointerPenWidth              write SetPointerPenWidth;

    property MenuUserCanChangeOptions     : Boolean               read FMenuUserCanChangeOptions     write FMenuUserCanChangeOptions  default True;

    property SnapToDataPoint              : Boolean               read FSnapToDataPoint              write FSnapToDataPoint           default False;

    property UseCachedInterpolatedData    : Boolean               read FUseCachedInterpolatedData    write FUseCachedInterpolatedData default False;

    property MenuItemVisibleValueXY       : Boolean               read FMenuItemVisibleValueXY       write FMenuItemVisibleValueXY;
    property MenuItemVisibleValueX        : Boolean               read FMenuItemVisibleValueX        write FMenuItemVisibleValueX;
    property MenuItemVisibleValueY        : Boolean               read FMenuItemVisibleValueY        write FMenuItemVisibleValueY;
    property MenuItemVisibleDeltaX        : Boolean               read FMenuItemVisibleDeltaX        write FMenuItemVisibleDeltaX;
    property MenuItemVisibleDeltaY        : Boolean               read FMenuItemVisibleDeltaY        write FMenuItemVisibleDeltaY;
    property MenuItemVisibleInverseDeltaX : Boolean               read FMenuItemVisibleInverseDeltaX write FMenuItemVisibleInverseDeltaX;

    property MenuItemCaptionValueXY       : String                read FMenuItemCaptionValueXY       write FMenuItemCaptionValueXY;
    property MenuItemCaptionValueX        : String                read FMenuItemCaptionValueX        write FMenuItemCaptionValueX;
    property MenuItemCaptionValueY        : String                read FMenuItemCaptionValueY        write FMenuItemCaptionValueY;
    property MenuItemCaptionDeltaX        : String                read FMenuItemCaptionDeltaX        write FMenuItemCaptionDeltaX;
    property MenuItemCaptionDeltaY        : String                read FMenuItemCaptionDeltaY        write FMenuItemCaptionDeltaY;
    property MenuItemCaptionInverseDeltaX : String                read FMenuItemCaptionInverseDeltaX write FMenuItemCaptionInverseDeltaX;
  end;

implementation

uses
{$ifdef iVCL} iPlotComponent,  iPlotAxis,  iPlot,  iXYPlot;{$endif}
{$ifdef iCLX}QiPlotComponent, QiPlotAxis, QiPlot, QiXYPlot;{$endif}

const
  SelectionMargin = 5;
type
  TiPlotChannelCustomAccess = class(TiPlotChannelCustom)end;
  TiPlotAxisAccess          = class(TiPlotAxis         )end;
  TiPlotLayoutAccess        = class(TiPlotLayoutObject )end;
  TiPlotComponentAccess     = class(TiPlotComponent    )end;
//****************************************************************************************************************************************************
constructor TiPlotDataCursor.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited Create(AOwner, AOnChange, AOnInsert, AOnRemove, AOnRename);

  Visible := False;

  Enabled                   := True;
  FUseChannelColor          := True;
  FHintShow                 := True;
  FHintPosition             := 50;
  FPointer1Position         := 50;
  FPointer2Position         := 60;
  FPointerPenWidth          := 1;
  FColor                    := clYellow;
  FChannelAllowAll          := True;
  FChannelShowAllInLegend   := True;

  FMenuUserCanChangeOptions := True;

  FMenuItemVisibleValueXY       := True;
  FMenuItemVisibleValueX        := True;
  FMenuItemVisibleValueY        := True;
  FMenuItemVisibleDeltaX        := True;
  FMenuItemVisibleDeltaY        := True;
  FMenuItemVisibleInverseDeltaX := True;

  FMenuItemCaptionValueXY       := 'Value X-Y';
  FMenuItemCaptionValueX        := 'Value X';
  FMenuItemCaptionValueY        := 'Value Y';
  FMenuItemCaptionDeltaX        := 'Period';
  FMenuItemCaptionDeltaY        := 'Peak-Peak';
  FMenuItemCaptionInverseDeltaX := 'Frequency';

  FFont := TFont.Create; FFont.OnChange := TriggerChange;

  DoSetup;
end;
//****************************************************************************************************************************************************
destructor TiPlotDataCursor.Destroy;
begin
  FFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
function TiPlotDataCursor.GetChannel: TiPlotChannelCustom;
begin
  if not Assigned(FChannel) then FChannel := (Owner as TiPlotComponent).GetChannelByName(ChannelName);
  Result := FChannel;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.NotificationRemove(Sender: TObject);
begin
  if Sender = FChannel then FChannel := nil;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.NotificationRename(Sender: TObject);
begin
  if Sender = FChannel then FChannelName := (Sender as TiPlotObject).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SetChannelName(const Value: String);
begin
  if FChannelName <> Value then
    begin
      FChannelName := Value;
      FChannel     := nil;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SetXYAxesReversed(const Value: Boolean);
begin
  inherited;
  DoSetup;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.DoSetup;
begin
  if Owner is TiXYPlot then
    case FStyle of
      ipcsValueXY       : begin
                            FPointer1Show := True; FPointer1Orientation := ioVertical;
                            FPointer2Show := True; FPointer2Orientation := ioHorizontal;
                                                   FHintOrientation     := ioVertical;
                          end;
      ipcsValueX        : begin
                            FPointer1Show := True; FPointer1Orientation := ioVertical;
                            FPointer2Show := False;
                                                   FHintOrientation     := ioVertical;
                          end;
      ipcsValueY        : begin
                            FPointer1Show := False;
                            FPointer2Show := True; FPointer2Orientation := ioHorizontal;
                                                   FHintOrientation     := ioHorizontal;
                          end;
      ipcsDeltaX        : begin
                            FPointer1Show := True; FPointer1Orientation := ioVertical;
                            FPointer2Show := True; FPointer2Orientation := ioVertical;
                                                   FHintOrientation     := ioVertical;
                          end;
      ipcsDeltaY        : begin
                            FPointer1Show := True; FPointer1Orientation := ioHorizontal;
                            FPointer2Show := True; FPointer2Orientation := ioHorizontal;
                                                   FHintOrientation     := ioHorizontal;
                          end;
      ipcsInverseDeltaX : begin
                            FPointer1Show := True; FPointer1Orientation := ioVertical;
                            FPointer2Show := True; FPointer2Orientation := ioVertical;
                                                   FHintOrientation     := ioVertical;
                          end;
    end
  else
    case FStyle of
      ipcsValueXY       : begin
                            FPointer1Show := True; FPointer1Orientation := ioVertical;
                            FPointer2Show := False;
                                                   FHintOrientation     := ioVertical;
                          end;
      ipcsValueX        : begin
                            FPointer1Show := True; FPointer1Orientation := ioVertical;
                            FPointer2Show := False;
                                                   FHintOrientation     := ioVertical;
                          end;
      ipcsValueY        : begin
                            if FScopeStyle then
                              begin
                                FPointer1Show := False;
                                FPointer2Show := True; FPointer2Orientation := ioHorizontal;
                                                       FHintOrientation     := ioHorizontal;
                              end
                            else
                              begin
                                FPointer1Show := True; FPointer1Orientation := ioVertical;
                                FPointer2Show := False;
                                                       FHintOrientation     := ioVertical;
                              end;
                          end;
      ipcsDeltaX        : begin
                            FPointer1Show := True; FPointer1Orientation := ioVertical;
                            FPointer2Show := True; FPointer2Orientation := ioVertical;
                                                   FHintOrientation     := ioVertical;
                          end;
      ipcsDeltaY        : begin
                            FPointer1Show := True; FPointer1Orientation := ioHorizontal;
                            FPointer2Show := True; FPointer2Orientation := ioHorizontal;
                                                   FHintOrientation     := ioHorizontal;
                          end;
      ipcsInverseDeltaX : begin
                            FPointer1Show := True; FPointer1Orientation := ioVertical;
                            FPointer2Show := True; FPointer2Orientation := ioVertical;
                                                   FHintOrientation     := ioVertical;
                          end;
    end;

  if XYAxesReversed then
    begin
      if FPointer1Orientation = ioVertical then FPointer1Orientation := ioHorizontal else FPointer1Orientation := ioVertical;
      if FPointer2Orientation = ioVertical then FPointer2Orientation := ioHorizontal else FPointer2Orientation := ioVertical;
      if FHintOrientation     = ioVertical then FHintOrientation     := ioHorizontal else FHintOrientation     := ioVertical;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SetUseChannelColor       (const Value:Boolean);begin SetBooleanProperty(Value,FUseChannelColor,       TriggerChange);end;
procedure TiPlotDataCursor.SetHintHideOnRelease     (const Value:Boolean);begin SetBooleanProperty(Value,FHintHideOnRelease,     TriggerChange);end;
procedure TiPlotDataCursor.SetHintShow              (const Value:Boolean);begin SetBooleanProperty(Value,FHintShow,              TriggerChange);end;
procedure TiPlotDataCursor.SetColor                 (const Value:TColor );begin SetColorProperty  (Value,FColor,                 TriggerChange);end;
procedure TiPlotDataCursor.SetHintPosition          (const Value:Double );begin SetDoubleProperty (Value,FHintPosition,          TriggerChange);end;
procedure TiPlotDataCursor.SetChannelAllowAll       (const Value:Boolean);begin SetBooleanProperty(Value,FChannelAllowAll,       TriggerChange);end;
procedure TiPlotDataCursor.SetChannelShowAllInLegend(const Value:Boolean);begin SetBooleanProperty(Value,FChannelShowAllInLegend,TriggerChange);end;
procedure TiPlotDataCursor.SetPointerPenWidth       (const Value:Integer);begin SetIntegerProperty(Value,FPointerPenWidth,       TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SetFont(const Value:TFont);begin FFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SetHintOrientationSide(const Value: TiOrientationSide);
begin
  if FHintOrientationSide <> Value then
    begin
      FHintOrientationSide := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SetStyle(const Value: TiPlotDataCursorStyle);
begin
  if FStyle <> Value then
    begin
      FStyle := Value;
      DoSetup;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SetScopeStyle(const Value:Boolean);
begin
  if FScopeStyle <> Value then
    begin
      FScopeStyle := Value;
      DoSetup;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SetPointer1Position(const Value: Double);
var
  TempValue : Double;
begin
  TempValue := Value;
  if TempValue <   0 then TempValue :=   0;
  if TempValue > 100 then TempValue := 100;
  if FPointer1Position <> TempValue then
    begin
      FPointer1Position := TempValue;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SetPointer2Position(const Value: Double);
var
  TempValue : Double;
begin
  TempValue := Value;
  if TempValue <   0 then TempValue :=   0;
  if TempValue > 100 then TempValue := 100;
  if FPointer2Position <> TempValue then
    begin
      FPointer2Position := TempValue;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotDataCursor.iMouseHitTest(MouseData: TiPlotMouseData): Boolean;
begin
  Result := False;
  if not Assigned(FDataView) then Exit;

  if FPointer1Show then if PtInRect(FPointer1Rect, Point(MouseData.X, MouseData.Y)) then Result := True;
  if FPointer2Show then if PtInRect(FPointer2Rect, Point(MouseData.X, MouseData.Y)) then Result := True;
  if FHintShowing  then if PtInRect(FHintRect,     Point(MouseData.X, MouseData.Y)) then Result := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.DoSetFocus;
begin
  inherited;
  if Assigned(Channel) then TiPlotChannelCustomAccess(Channel).SetUserSelected(True);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.NotificationSetFocus(Sender: TObject);
begin
  if Sender = Self                                                      then Exit;
  if not (Sender as TiPlotObject).UserSelected                          then Exit;

  if Sender is TiPlotChannelCustom then
    begin
      if Sender = Channel                                               then Exit;

      if UserSelected  then
        begin
          ChannelName := (Sender as TiPlotChannelCustom).Name;
          Exit;
        end;
    end;
  SetUserSelected(False);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.DoMouseLeft(MouseData: TiPlotMouseData);
begin
  inherited;

  FMouseDownX := MouseData.X;
  FMouseDownY := MouseData.Y;

  if not Assigned(FDataView) then Exit;

  if PtInRect(FHintRect, Point(MouseData.X, MouseData.Y)) then
    begin
      FMouseDownXPixels := FDataView.PositionPercentToPixelsX(FHintPosition);
      FMouseDownYPixels := FDataView.PositionPercentToPixelsY(FHintPosition);

      FMouseDownHint := True;

      TriggerInvalidateNow(Self);
    end
  else if FPointer1Show and PtInRect(FPointer1Rect, Point(MouseData.X, MouseData.Y)) then
    begin
      FMouseDownXPixels := FDataView.PositionPercentToPixelsX(FPointer1Position);
      FMouseDownYPixels := FDataView.PositionPercentToPixelsY(FPointer1Position);

      FMouseDownPointer1 := True;
      TriggerInvalidateNow(Self);
      DoUpdate;
    end
  else if FPointer2Show and PtInRect(FPointer2Rect, Point(MouseData.X, MouseData.Y)) then
    begin
      FMouseDownXPixels := FDataView.PositionPercentToPixelsX(FPointer2Position);
      FMouseDownYPixels := FDataView.PositionPercentToPixelsY(FPointer2Position);

      FMouseDownPointer2 := True;
      TriggerInvalidateNow(Self);
      DoUpdate;
    end
  else if PtInRect(FHintRect, Point(MouseData.X, MouseData.Y)) then
    begin
      FMouseDownXPixels := FDataView.PositionPercentToPixelsX(FHintPosition);
      FMouseDownYPixels := FDataView.PositionPercentToPixelsY(FHintPosition);

      FMouseDownHint := True;

      TriggerInvalidateNow(Self);
    end
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.DoMouseMove(MouseData: TiPlotMouseData);
begin
  if not Assigned(FDataView) then Exit;

  if FMouseDownHint then
    begin
      if FHintOrientation = ioVertical then
        FHintPosition := FDataView.PixelsYToPositionPercent(FMouseDownYPixels + (MouseData.Y - FMouseDownY))
      else
        FHintPosition := FDataView.PixelsXToPositionPercent(FMouseDownXPixels + (MouseData.X - FMouseDownX));

      if FHintPosition > 100 then FHintPosition := 100;
      if FHintPosition < 0   then FHintPosition := 0;

      DoUpdate;
      TriggerInvalidateNow(Self);
    end
  else if FMouseDownPointer1 then
    begin
      if FPointer1Orientation = ioVertical then
        FPointer1Position := FDataView.PixelsXToPositionPercent(FMouseDownXPixels + (MouseData.X - FMouseDownX))
      else
        FPointer1Position := FDataView.PixelsYToPositionPercent(FMouseDownYPixels + (MouseData.Y - FMouseDownY));

      if FPointer1Position > 100 then FPointer1Position := 100;
      if FPointer1Position < 0   then FPointer1Position := 0;

      DoUpdate;
      TriggerInvalidateNow(Self);
    end
  else if FMouseDownPointer2 then
    begin
      if FPointer2Orientation = ioVertical then
        FPointer2Position := FDataView.PixelsXToPositionPercent(FMouseDownXPixels + (MouseData.X - FMouseDownX))
      else
        FPointer2Position := FDataView.PixelsYToPositionPercent(FMouseDownYPixels + (MouseData.Y - FMouseDownY));

      if FPointer2Position > 100 then FPointer2Position := 100;
      if FPointer2Position < 0   then FPointer2Position := 0;

      DoUpdate;
      TriggerInvalidateNow(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.DoMouseUp(MouseData: TiPlotMouseData);
begin
  if not FMouseDownHint and not FMouseDownPointer1 and not FMouseDownPointer2 then exit;

  if      FMouseDownPointer1 then DoSnapTo(1)
  else if FMouseDownPointer2 then DoSnapTo(2);

  FMouseDownPointer1 := False;
  FMouseDownPointer2 := False;
  FMouseDownHint     := False;
  TriggerInvalidateNow(Self);

  if MouseDown then
    begin
      if iMouseHitTest(MouseData) then TiPlotComponentAccess(Owner).DoObjectClick(Self);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotDataCursor.GetNearestSnapToIndex(Channel: TiPlotChannel; TargetX, PointerPosition: Double; var Delta: Double): Integer;
var
  AIndexCalc : Integer;
  AIndexBest : Integer;
  ADeltaBest : Double;
  ADelta     : Double;
begin
  if Channel.Count = 0 then
    begin
      Result := -1;
      Exit;
    end;

  if TargetX >= Channel.DataX[Channel.Count-1] then
    begin
      Result := Channel.Count-1;
      Exit;
    end;

  if TargetX <= Channel.DataX[0] then
    begin
      Result := 0;
      Exit;
    end;

  AIndexCalc := (Channel as TiPlotChannel).CalcIndex(Channel.XAxis.PercentToPosition(PointerPosition/100));


  ADeltaBest := 1E300;
  AIndexBest := -1;
  
  if AIndexCalc <> -1 then
    begin
      AIndexBest := AIndexCalc;
      ADeltaBest := Abs(TargetX - Channel.DataX[AIndexCalc]);

      if (AIndexCalc > 0) then
      begin
        ADelta := Abs(TargetX - Channel.DataX[AIndexCalc-1]);
        if ADelta < ADeltaBest then
          begin
            ADeltaBest := ADelta;
            AIndexBest := AIndexCalc-1;
          end;
      end;

      if (AIndexCalc < Channel.Count-1) then
      begin
        ADelta := Abs(TargetX - Channel.DataX[AIndexCalc+1]);
        if ADelta < ADeltaBest then
          begin
            ADeltaBest := ADelta;
            AIndexBest := AIndexCalc+1;
          end;
      end;

    end;

  Delta  := ADeltaBest;
  Result := AIndexBest;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.DoSnapToDataPoint();
begin
  DoSnapTo(1);
  DoSnapTo(2);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.DoSnapTo(PointerNumber: Integer);
var
  ABestChannelIndex : Integer;
  ABestDataIndex    : Integer;
  ABestDelta        : Double;
  ADataIndex        : Integer;
  ADataDelta        : Double;
  ATargetPosition   : Double;
  APointerPosition  : Double;
  AChannel          : TiPlotChannel;
  APlot             : TiPlot;
  x                 : Integer;
begin
  if not SnapToDataPoint               then Exit;
  if not (Owner is TiPlot)             then Exit;

  if (Style = ipcsDeltaY)              then Exit;
  if (Style = ipcsValueY) and IsXYPlot then Exit;

  APlot := Owner as TiPlot;

  if PointerNumber = 1 then APointerPosition := Pointer1Position
  else                      APointerPosition := Pointer2Position;

  ABestDataIndex    := -1;
  ABestChannelIndex := -1;
  ABestDelta        := 1E300;

  if ChannelName = '<All>' then
    begin
      for x := 0 to TiPlotComponentAccess(Owner).ChannelCount-1 do
        begin
          AChannel := APlot.Channel[x] as TiPlotChannel;

          if not Assigned(AChannel)       then Continue;
          if not Assigned(AChannel.XAxis) then Continue;

          ATargetPosition := AChannel.XAxis.PercentToPosition(APointerPosition/100);

          ADataIndex := GetNearestSnapToIndex(AChannel, ATargetPosition, APointerPosition, ADataDelta);
          if (ADataIndex <> -1) and (ADataDelta < ABestDelta) then
            begin
              ABestChannelIndex := x;
              ABestDataIndex    := ADataIndex;
              ABestDelta        := ADataDelta;
            end;
        end;

      FSnapToIndexChannel := ABestChannelIndex;
      FSnapToIndexData    := ABestDataIndex;

      if PointerNumber = 1 then MoveCursorToDataPoint(FSnapToIndexChannel, FSnapToIndexData, 1, 0)
      else                      MoveCursorToDataPoint(FSnapToIndexChannel, FSnapToIndexData, 2, 0);
    end
  else if Assigned(Channel) then
    begin
      if not Assigned(Channel.XAxis) then Exit;

      ATargetPosition     := Channel.XAxis.PercentToPosition(APointerPosition/100);
      ABestDataIndex      := GetNearestSnapToIndex(Channel as TiPlotChannel, ATargetPosition, APointerPosition, ADataDelta);

      FSnapToIndexChannel := TiPlotComponentAccess(Owner).GetChannelIndexByName(ChannelName);
      FSnapToIndexData    := ABestDataIndex;

      if PointerNumber = 1 then MoveCursorToDataPoint(FSnapToIndexChannel, FSnapToIndexData, 0, 1)
      else                      MoveCursorToDataPoint(FSnapToIndexChannel, FSnapToIndexData, 0, 2);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.MoveCursorToDataPoint(ChannelIndex, DataIndex, Delta, PointerNumber: Integer);
var
  ANewPercent : Double;
  AChannel    : TiPlotChannelCustom;
  APlot       : TiPlotComponent;
  ADataX      : Double;
begin

  APlot := Owner as TiPlot;

  if not Assigned(APlot)                   then Exit;

  if ChannelIndex < 0                      then Exit;
  if ChannelIndex > APlot.ChannelCount-1   then Exit;

  AChannel := APlot.Channel[ChannelIndex];

  if not Assigned(AChannel)                then Exit;
  if not Assigned(AChannel.XAxis)          then Exit;

  if AChannel.XAxis.ReverseScale then DataIndex := DataIndex - Delta
  else                                DataIndex := DataIndex + Delta;

  if DataIndex > AChannel.Count-1 then DataIndex := AChannel.Count-1;
  if DataIndex < 0                then DataIndex := 0;

  if (DataIndex < 0) or (DataIndex > (AChannel.Count-1)) then Exit;
  
  ADataX := AChannel.DataX[DataIndex];

  if ADataX > AChannel.XAxis.Max then AChannel.XAxis.Min := ADataX - AChannel.XAxis.Span + AChannel.XAxis.Span/40;
  if ADataX < AChannel.XAxis.Min then AChannel.XAxis.Min := ADataX - AChannel.XAxis.Span/40;

  ANewPercent := AChannel.XAxis.PositionToPercent(AChannel.DataX[DataIndex]);


  if PointerNumber = 1 then Pointer1Position := ANewPercent*100
  else                      Pointer2Position := ANewPercent*100;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.DoKeySnapToDataPoint(var CharCode: Word; Shift: TShiftState; PopupMenu : TPopupMenu);
var
  APointerNumber : Integer;
begin
  if (ssCtrl in Shift) and not FPointer2Show then Exit;
  
  if not(ssCtrl in Shift) then APointerNumber := 1
  else                         APointerNumber := 2;


  case CharCode of
    VK_LEFT  : begin
                 DoSnapTo(APointerNumber);
                 if (not XYAxesReversed) then MoveCursorToDataPoint(FSnapToIndexChannel, FSnapToIndexData, -1, APointerNumber)
                 else                         MoveHint(icdDown);
               end;
    VK_DOWN  : begin
                 DoSnapTo(APointerNumber);
                 if (not XYAxesReversed) then MoveHint(icdDown)
                 else                         MoveCursorToDataPoint(FSnapToIndexChannel, FSnapToIndexData, -1, APointerNumber);
               end;
    VK_RIGHT : begin
                 DoSnapTo(APointerNumber);
                 if (not XYAxesReversed) then MoveCursorToDataPoint(FSnapToIndexChannel, FSnapToIndexData, +1, APointerNumber)
                 else                         MoveHint(icdUp);
               end;
    VK_UP    : begin
                 DoSnapTo(APointerNumber);
                 if (not XYAxesReversed) then MoveHint(icdUp)
                 else                         MoveCursorToDataPoint(FSnapToIndexChannel, FSnapToIndexData, +1, APointerNumber);
               end;
    VK_PRIOR : begin
                 DoSnapTo(APointerNumber);
                 MoveCursorToDataPoint(FSnapToIndexChannel, FSnapToIndexData, +5, APointerNumber);
               end;
    VK_NEXT  : begin
                 DoSnapTo(APointerNumber);
                 MoveCursorToDataPoint(FSnapToIndexChannel, FSnapToIndexData, -5, APointerNumber);
               end;
    VK_HOME  : begin
                 DoSnapTo(APointerNumber);
                 MoveCursorToDataPoint(FSnapToIndexChannel, 0,      0, APointerNumber);
               end;
    VK_END   : begin
                 DoSnapTo(APointerNumber);
                 MoveCursorToDataPoint(FSnapToIndexChannel, MaxInt, 0, APointerNumber);
               end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.MoveHint(Direction : TiCountDirection);
var
  XPixelPercent : Double;
  YPixelPercent : Double;
  ADelta        : Double;
begin
  if not Assigned(FDataView) then Exit;

  YPixelPercent := ABS(FDataView.PixelsYToPositionPercent(100) - FDataView.PixelsYToPositionPercent(101));
  XPixelPercent := ABS(FDataView.PixelsXToPositionPercent(101) - FDataView.PixelsXToPositionPercent(100));

  if FHintOrientation = ioVertical then ADelta := YPixelPercent
  else                                  ADelta := XPixelPercent;

  if Direction = icdDown then ADelta := -ADelta;

  FHintPosition := FHintPosition + ADelta;

  if FHintPosition > 100     then FHintPosition     := 100;
  if FHintPosition < 0       then FHintPosition     := 0;

  TriggerInvalidateNow(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.iKeyDown(var CharCode: Word; Shift: TShiftState; PopupMenu : TPopupMenu);
var
  XPixelPercent : Double;
  YPixelPercent : Double;
begin
  inherited iKeyDown(CharCode, Shift, PopupMenu);

  if not Assigned(FDataView) then Exit;

  if SnapToDataPoint then
    begin
      DoKeySnapToDataPoint(CharCode, Shift, PopupMenu);
      Exit;
    end;

  YPixelPercent := ABS(FDataView.PixelsYToPositionPercent(100) - FDataView.PixelsYToPositionPercent(101));
  XPixelPercent := ABS(FDataView.PixelsXToPositionPercent(101) - FDataView.PixelsXToPositionPercent(100));

  if not(ssCtrl in Shift) then
    begin
      case CharCode of
        VK_LEFT  : begin
                     if FHintShow     then if FHintOrientation     = ioHorizontal then FHintPosition     := FHintPosition     - XPixelPercent;
                     if FPointer1Show then if FPointer1Orientation = ioVertical   then FPointer1Position := FPointer1Position - XPixelPercent;
                   end;
        VK_DOWN  : begin
                     if FHintShow     then if FHintOrientation     = ioVertical   then FHintPosition     := FHintPosition     - YPixelPercent;
                     if FPointer1Show then if FPointer1Orientation = ioHorizontal then FPointer1Position := FPointer1Position - YPixelPercent;
                   end;
        VK_RIGHT : begin
                     if FHintShow     then if FHintOrientation     = ioHorizontal then FHintPosition     := FHintPosition     + XPixelPercent;
                     if FPointer1Show then if FPointer1Orientation = ioVertical   then FPointer1Position := FPointer1Position + XPixelPercent;
                   end;
        VK_UP    : begin
                     if FHintShow     then if FHintOrientation     = ioVertical   then FHintPosition     := FHintPosition     + YPixelPercent;
                     if FPointer1Show then if FPointer1Orientation = ioHorizontal then FPointer1Position := FPointer1Position + YPixelPercent;
                   end;
        VK_PRIOR : case FPointer1Orientation of
                     ioVertical : FPointer1Position := FPointer1Position + XPixelPercent * 5;
                     else         FPointer1Position := FPointer1Position + YPixelPercent * 5;
                   end;
        VK_NEXT  : case FPointer1Orientation of
                     ioVertical : FPointer1Position := FPointer1Position - XPixelPercent * 5;
                     else         FPointer1Position := FPointer1Position - YPixelPercent * 5;
                   end;
        VK_HOME  : FPointer1Position := 0;
        VK_END   : FPointer1Position := 100;
      end;
    end
  else if FPointer2Show then
    begin
      case CharCode of
        VK_LEFT  : if FPointer2Orientation = ioVertical   then FPointer2Position := FPointer2Position - XPixelPercent;
        VK_DOWN  : if FPointer2Orientation = ioHorizontal then FPointer2Position := FPointer2Position - YPixelPercent;
        VK_RIGHT : if FPointer2Orientation = ioVertical   then FPointer2Position := FPointer2Position + XPixelPercent;
        VK_UP    : if FPointer2Orientation = ioHorizontal then FPointer2Position := FPointer2Position + YPixelPercent;
        VK_PRIOR : case FPointer2Orientation of
                     ioVertical : FPointer2Position := FPointer2Position + XPixelPercent * 5;
                     else         FPointer2Position := FPointer2Position + YPixelPercent * 5;
                   end;
        VK_NEXT  : case FPointer2Orientation of
                     ioVertical : FPointer2Position := FPointer2Position - XPixelPercent * 5;
                     else         FPointer2Position := FPointer2Position - YPixelPercent * 5;
                   end;
        VK_HOME  : FPointer2Position := 0;
        VK_END   : FPointer2Position := 100;
      end;
    end;

  if FHintPosition > 100     then FHintPosition     := 100;
  if FHintPosition < 0       then FHintPosition     := 0;

  if FPointer1Position > 100 then FPointer1Position := 100;
  if FPointer1Position < 0   then FPointer1Position := 0;

  if FPointer2Position > 100 then FPointer2Position := 100;
  if FPointer2Position < 0   then FPointer2Position := 0;

  TriggerInvalidateNow(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.DrawHint(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  AWidth         : Integer;
  AHeight        : Integer;
  AText          : String;
  ARect          : TRect;
  Margin         : Integer;
  LineMid        : Integer;
  Dual           : Boolean;
  PositionPixels : Integer;
begin
  if not Assigned(Channel) then AText := GetTranslation('No Channel') else AText := FCursorDisplayText;

  TiPlotComponentAccess(Owner as TiPlotComponent).DoDataCursorCustomizeHint(Self, AText);

  with Canvas, TiPlotLayoutAccess(FDataView) do
    begin
      Pen.Style   := psSolid;
      Pen.Width   := 0;
      Font.Assign(FFont);

      AWidth   := iTextWidth(Canvas, AText);

      ARect    := Rect(0,0, AWidth, 0);
      AHeight  := iDrawText(Canvas, AText, ARect, [itfCalcRect, itfWordBreak], True, clBtnFace);

      //AHeight  := TextHeight(AText);
      Margin   := TextWidth('A');

      FHintHeight := AHeight + Margin div 2;
      FHintWidth  := AWidth  + Margin;

      if FStyle in [ipcsDeltaX, ipcsDeltaY, ipcsInverseDeltaX] then Dual := True else Dual := False;

      case FHintOrientation of
        ioVertical   : begin
                         if FPointer1Show then
                           LineMid := (FPointer1Rect.Left + FPointer1Rect.Right) div 2
                         else
                           LineMid := (FPointer2Rect.Left + FPointer2Rect.Right) div 2;

                         if (LineMid + 5 + Margin + AWidth) > Right then FHintOrientationSide := iosTopLeft;
                         if (LineMid - 5 - Margin - AWidth) < Left  then FHintOrientationSide := iosBottomRight;

                         PositionPixels := FDataView.PositionPercentToPixelsY(HintPosition);

                         if not Dual then
                           case FHintOrientationSide of
                             iosBottomRight : FHintRect := Rect(LineMid + 5,                   PositionPixels - FHintHeight div 2,
                                                                LineMid + 5 + AWidth + Margin, PositionPixels + FHintHeight div 2);
                             iosTopLeft     : FHintRect := Rect(LineMid - 5 - AWidth - Margin, PositionPixels - FHintHeight div 2,
                                                                LineMid - 5 ,                  PositionPixels + FHintHeight div 2);
                           end
                         else
                           begin
                             LineMid := (FPointer1Rect.Left + FPointer1Rect.Right + FPointer2Rect.Left + FPointer2Rect.Right) div 4;
                             FHintRect := Rect(LineMid - FHintWidth div 2, PositionPixels - FHintHeight div 2,
                                               LineMid + FHintWidth div 2, PositionPixels + FHintHeight div 2);
                           end;

                       end;
        ioHorizontal : begin
                         if FPointer1Show then
                           LineMid := (FPointer1Rect.Top + FPointer1Rect.Bottom) div 2
                         else
                           LineMid := (FPointer2Rect.Top + FPointer2Rect.Bottom) div 2;

                         if (LineMid + Margin + AHeight) > Bottom then FHintOrientationSide := iosTopLeft;
                         if (LineMid - Margin - AHeight) < Top    then FHintOrientationSide := iosBottomRight;

                         PositionPixels := FDataView.PositionPercentToPixelsX(HintPosition);

                         if not Dual then
                           case FHintOrientationSide of
                             iosBottomRight : FHintRect := Rect(PositionPixels - FHintWidth div 2, LineMid + 5,
                                                                PositionPixels + FHintWidth div 2, LineMid + 5 + FHintHeight);
                             iosTopLeft     : FHintRect := Rect(PositionPixels - FHintWidth div 2, LineMid - 5 - FHintHeight,
                                                                PositionPixels + FHintWidth div 2, LineMid - 5);
                           end
                         else
                           begin
                             LineMid := (FPointer1Rect.Top + FPointer1Rect.Bottom + FPointer2Rect.Top + FPointer2Rect.Bottom) div 4;
                             FHintRect := Rect(PositionPixels - FHintWidth div 2, LineMid - FHintHeight div 2,
                                               PositionPixels + FHintWidth div 2, LineMid + FHintHeight div 2);
                           end;
                       end;
      end;

      if FHintRect.Left   < Left   then OffsetRect(FHintRect, Left - FHintRect.Left, 0);
      if FHintRect.Right  > Right  then OffsetRect(FHintRect, Right - FHintRect.Right, 0);
      if FHintRect.Top    < Top    then OffsetRect(FHintRect, 0, Top - FHintRect.Top);
      if FHintRect.Bottom > Bottom then OffsetRect(FHintRect, 0, Bottom - FHintRect.Bottom);

      if Dual then
        begin
          Pen.Style   := psDot;
          if FUseChannelColor and Assigned(Channel) then Pen.Color := Channel.Color else Pen.Color := FColor;
          Brush.Style := bsClear;
          case FHintOrientation of
            ioVertical   : Polyline([Point((FPointer1Rect.Left + FPointer1Rect.Right) div 2, (FHintRect.Top     + FHintRect.Bottom    ) div 2),
                                     Point((FPointer2Rect.Left + FPointer2Rect.Right) div 2, (FHintRect.Top     + FHintRect.Bottom    ) div 2)]);
            ioHorizontal : Polyline([Point((FHintRect.Left     + FHintRect.Right    ) div 2, (FPointer1Rect.Top + FPointer1Rect.Bottom) div 2),
                                     Point((FHintRect.Left     + FHintRect.Right    ) div 2, (FPointer2Rect.Top + FPointer2Rect.Bottom) div 2)]);
          end
        end;

      Pen.Style := psSolid;
      if FUseChannelColor and Assigned(Channel) then Pen.Color := Channel.Color  else Pen.Color := clBlack;
      Brush.Color := clInfoBk;
      Brush.Style := bsSolid;
      Font.Color := clInfoText;

      ARect := Rect(FHintRect.Left, FHintRect.Top, FHintRect.Right, FHintRect.Bottom);
      Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);

      ARect := Rect(FHintRect.Left+2, FHintRect.Top+1, FHintRect.Right, FHintRect.Bottom);
      iDrawText(Canvas, AText, ARect, [itfHLeft, itfVCenter], True, clBtnFace);
      
      ARect := Rect(FHintRect.Left, FHintRect.Top, FHintRect.Right, FHintRect.Bottom);
      Brush.Style := bsClear;
      Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      InflateRect(ARect, 2, 2);

      if Self.UserSelected then
        begin
          Font.Color  := clWhite;
          Pen.Color   := clWhite;
          Brush.Style := bsClear;
          iDrawFocusRect2(Canvas, ARect);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
begin
  if not Assigned(FDataView) then Exit;
  if not Visible             then Exit;

  DoUpdate;

  with Canvas, FDataView do
    begin
      if FUseChannelColor and Assigned(Channel) then Pen.Color := Channel.Color else Pen.Color := FColor;

      Pen.Width := 0;
      Pen.Style := psSolid;

      if FPointer1Show then
        begin
          if FMouseDownPointer1 then Pen.Width := 0 else Pen.Width := FPointerPenWidth;
          DrawPointer(Canvas, FPointer1Position, FPointer1Orientation, FPointer1Rect);
        end;

      if FPointer2Show then
        begin
          if FMouseDownPointer2 then Pen.Width := 0 else Pen.Width := FPointerPenWidth;
          DrawPointer(Canvas, FPointer2Position, FPointer2Orientation, FPointer2Rect);
        end;

                                     FHintShowing := FHintShow;
      if FChannelName = '<All>' then FHintShowing := False;
      if FHintHideOnRelease and not FMouseDownPointer1 and not FMouseDownPointer2 then FHintShowing := False;
      if FHintShowing then DrawHint(Canvas, BackgroundColor);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.DrawPointer(const Canvas: TCanvas; Position: Double; Orientation: TiOrientation; var PointerRect: TRect);
var
  PositionPixels : Integer;
begin
  with Canvas, FDataView do
    begin
      case Orientation of
         ioVertical   : begin
                          PositionPixels := FDataView.PositionPercentToPixelsX(Position);
                          PolyLine([Point(PositionPixels, DrawRect.Top), Point(PositionPixels, DrawRect.Bottom)]);
                          PointerRect := Rect(PositionPixels-5, DrawRect.Top, PositionPixels+6, DrawRect.Bottom);
                        end;
         else           begin
                          PositionPixels := (FDataView.PositionPercentToPixelsY(Position));
                          PolyLine([Point(DrawRect.Left, PositionPixels), Point(DrawRect.Right, PositionPixels)]);
                          PointerRect := Rect(DrawRect.Left, PositionPixels - 5, DrawRect.Right, PositionPixels + 6);
                        end;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.DoUpdate;
var
  x : Integer;
begin
  TiPlotComponentAccess(Owner).DoBeforeDataCursorUpdate(Self);

  if ChannelName = '<All>' then
    begin
      for x := 0 to TiPlotComponentAccess(Owner).Master.ChannelManager.Count-1 do
        TiPlotChannelCustomAccess(TiPlotComponentAccess(Owner).Master.ChannelManager.Items[x]).DataCursorUpate(Self);
    end
  else if Assigned(Channel) then TiPlotChannelCustomAccess(Channel).DataCursorUpate(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SetVisible(const Value: Boolean);
begin
  inherited;
  if Value then DoUpdate;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.AddMenuItems(PopupMenu: TPopUpMenu);
var
  x               : Integer;
  MenuItem        : TiMenuItem;
  StyleMenuItem   : TMenuItem;
  OptionsMenuItem : TMenuItem;
  ChannelMenuItem : TMenuItem;
  PlotComponent   : TiPlotComponent;
  AText           : String;
begin
  inherited;

  ChannelMenuItem            := TMenuItem.Create(PopupMenu);
  ChannelMenuItem.Caption    := GetTranslation('Channel');
  PopupMenu.Items.Add(ChannelMenuItem);

  if FChannelAllowAll then
    begin
      MenuItem            := TiMenuItem.Create(PopupMenu);
      MenuItem.Caption    := GetTranslation('<All>');
      MenuItem.OnClick    := AllChannelsMenuItemClick;
      MenuItem.Checked    := ChannelName = '<All>';
      ChannelMenuItem.Add(MenuItem);
    end;

  PlotComponent := Owner as TiPlotComponent;
  for x := 0 to PlotComponent.ChannelCount - 1 do
    begin
      if not PlotComponent.Channel[x].Visible then Continue;
      
      MenuItem            := TiMenuItem.Create(PopupMenu);
      AText               := PlotComponent.Channel[x].TitleText;
      AText := StringReplace(AText, #13+#10, '', [rfReplaceAll, rfIgnoreCase]);
      MenuItem.Caption    := AText;
      MenuItem.AString    := PlotComponent.Channel[x].Name;
      MenuItem.Checked    := MenuItem.AString = ChannelName;
      MenuItem.OnClick    := ChannelNameMenuItemClick;
      ChannelMenuItem.Add(MenuItem);
    end;

  StyleMenuItem            := TMenuItem.Create(PopupMenu);
  StyleMenuItem.Caption    := GetTranslation('Style');
  PopupMenu.Items.Add(StyleMenuItem);

  MenuItem            := TiMenuItem.Create(PopupMenu);
  MenuItem.Caption    := GetTranslation(FMenuItemCaptionValueXY);
  MenuItem.OnClick    := StyleValueXYMenuItemClick;
  MenuItem.Checked    := FStyle = ipcsValueXY;
  MenuItem.Visible    := FMenuItemVisibleValueXY;
  StyleMenuItem.Add(MenuItem);

  MenuItem            := TiMenuItem.Create(PopupMenu);
  MenuItem.Caption    := GetTranslation(FMenuItemCaptionValueX);
  MenuItem.OnClick    := StyleValueXMenuItemClick;
  MenuItem.Checked    := FStyle = ipcsValueX;
  MenuItem.Visible    := FMenuItemVisibleValueX;
  StyleMenuItem.Add(MenuItem);

  MenuItem            := TiMenuItem.Create(PopupMenu);
  MenuItem.Caption    := GetTranslation(FMenuItemCaptionValueY);
  MenuItem.OnClick    := StyleValueYMenuItemClick;
  MenuItem.Checked    := FStyle = ipcsValueY;
  MenuItem.Visible    := FMenuItemVisibleValueY;
  StyleMenuItem.Add(MenuItem);

  MenuItem            := TiMenuItem.Create(PopupMenu);
  MenuItem.Caption    := GetTranslation(FMenuItemCaptionDeltaX);
  MenuItem.OnClick    := StyleDeltaXMenuItemClick;
  MenuItem.Checked    := FStyle = ipcsDeltaX;
  MenuItem.Visible    := FMenuItemVisibleDeltaX;
  StyleMenuItem.Add(MenuItem);

  MenuItem            := TiMenuItem.Create(PopupMenu);
  MenuItem.Caption    := GetTranslation(FMenuItemCaptionDeltaY);
  MenuItem.OnClick    := StyleDeltaYMenuItemClick;
  MenuItem.Checked    := FStyle = ipcsDeltaY;
  MenuItem.Visible    := FMenuItemVisibleDeltaY;
  StyleMenuItem.Add(MenuItem);

  MenuItem            := TiMenuItem.Create(PopupMenu);
  MenuItem.Caption    := GetTranslation(FMenuItemCaptionInverseDeltaX);
  MenuItem.OnClick    := StyleInverseDeltaXMenuItemClick;
  MenuItem.Checked    := FStyle = ipcsInverseDeltaX;
  MenuItem.Visible    := FMenuItemVisibleInverseDeltaX;
  StyleMenuItem.Add(MenuItem);

  if FMenuUserCanChangeOptions then
    begin
      OptionsMenuItem            := TiMenuItem.Create(PopupMenu);
      OptionsMenuItem.Caption    := GetTranslation('Options');
      PopupMenu.Items.Add(OptionsMenuItem);

      MenuItem            := TiMenuItem.Create(PopupMenu);
      MenuItem.Caption    := GetTranslation('Use Channel Color');
      MenuItem.OnClick    := UseChannelColorMenuItemClick;
      MenuItem.Checked    := FUseChannelColor;
      OptionsMenuItem.Add(MenuItem);

      MenuItem            := TiMenuItem.Create(PopupMenu);
      MenuItem.Caption    := GetTranslation('Hide Hint On Release');
      MenuItem.OnClick    := HideHintOnReleaseMenuItemClick;
      MenuItem.Checked    := FHintHideOnRelease;
      OptionsMenuItem.Add(MenuItem);

      MenuItem         := TiMenuItem.Create(PopupMenu);
      MenuItem.Caption := GetTranslation('Flip Alignment');
      MenuItem.OnClick := FlipMenuItemClick;
      MenuItem.Enabled := (FStyle in [ipcsValueXY, ipcsValueX, ipcsValueY]) and (UpperCase(FChannelName) <> UpperCase('<All>'));
      OptionsMenuItem.Add(MenuItem);
    end;

  if not IsXYPlot then
    begin
      MenuItem         := TiMenuItem.Create(PopupMenu);
      MenuItem.Caption := GetTranslation('Snap to Data-Point');
      MenuItem.OnClick := SnapToDataPointMenuItemClick;
      MenuItem.Checked := SnapToDataPoint;
      PopupMenu.Items.Add(MenuItem);
    end;

  AddEditMenuItems(PopupMenu);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.AllChannelsMenuItemClick(Sender: TObject);
var
  x : Integer;
begin
  ChannelName := '<All>';

  for x := 0 to TiPlotComponentAccess(Owner).Master.ChannelManager.Count-1 do
    TiPlotComponentAccess(Owner).Master.ChannelManager.Items[x].UserSelected := False;
end;
//****************************************************************************************************************************************************
function TiPlotDataCursor.GetIsXYPlot: Boolean;
begin
  Result := False;
  if Owner = nil then Exit;
  if Owner is TiXYPlot then Result := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.ChannelNameMenuItemClick(Sender: TObject);
begin
  ChannelName := (Sender as TiMenuItem).AString;
  if Assigned(Channel) then TiPlotChannelCustomAccess(Channel).SetUserSelected(True);
  DoSnapToDataPoint;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.FlipMenuItemClick(Sender: TObject);
begin
  if FHintOrientationSide = iosTopLeft then FHintOrientationSide := iosBottomRight else FHintOrientationSide := iosTopLeft;
  TriggerInvalidateNow(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SnapToDataPointMenuItemClick(Sender: TObject);
begin
  SnapToDataPoint := not SnapToDataPoint;
  if SnapToDataPoint then DoSnapToDataPoint;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.UseChannelColorMenuItemClick(Sender: TObject);
begin
  FUseChannelColor := not FUseChannelColor;
  TriggerInvalidateNow(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.HideHintOnReleaseMenuItemClick(Sender: TObject);
begin
  FHintHideOnRelease := not FHintHideOnRelease;
  TriggerInvalidateNow(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.StyleDeltaXMenuItemClick       (Sender: TObject);begin Style := ipcsDeltaX;        end;
procedure TiPlotDataCursor.StyleDeltaYMenuItemClick       (Sender: TObject);begin Style := ipcsDeltaY;        end;
procedure TiPlotDataCursor.StyleValueXMenuItemClick       (Sender: TObject);begin Style := ipcsValueX;        end;
procedure TiPlotDataCursor.StyleValueXYMenuItemClick      (Sender: TObject);begin Style := ipcsValueXY;       end;
procedure TiPlotDataCursor.StyleValueYMenuItemClick       (Sender: TObject);begin Style := ipcsValueY;        end;
procedure TiPlotDataCursor.StyleInverseDeltaXMenuItemClick(Sender: TObject);begin Style := ipcsInverseDeltaX; end;
//****************************************************************************************************************************************************
function TiPlotDataCursor.GetMousePointer(APoint: TPoint): TCursor;
begin
  Result := crHandPoint;

  TiPlotComponentAccess(Owner).DoGetMouseCursor(Self, Result);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCursor.SetData(XValue, YValue: Double; Status: TiPlotDataPointStatus);
begin
  if (XValue <> FValueX) or (YValue <> FValueY) or (Status <> FStatus) then
    begin
      FValueX := XValue;
      FValueY := YValue;
      FStatus := Status;

      TiPlotComponentAccess(Owner).DataCursorChange(Self);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotDataCursor.GetInterpolatedYValue(ChannelName: String; XValue: Double; var YValue: Double): TiPlotDataPointStatus;
var
  AChannelCustom       : TiPlotChannelCustom;
  AChannel             : TiPlotChannel;
  AXAxis               : TiPlotAxis;

  AOldVisible          : Boolean;
  AOldStyle            : TiPlotDataCursorStyle;
  AOldChannelName      : String;
  AOldMin              : Double;
  AOldPointer1Position : Double;
begin
  Result := ipdpsNull;
  YValue := 0;

  AChannelCustom := TiPlotComponentAccess(Owner).GetChannelByName(ChannelName);

  if AChannelCustom = nil                 then Exit;
  if not(AChannelCustom is TiPlotChannel) then Exit;
  if AChannelCustom.XAxis = nil           then Exit;

  TiPlotAxisAccess(AChannelCustom.XAxis).BlockMinSpanEvents := True;

  //Setup Pointers--------------------------------------------------------------
  AChannel    := AChannelCustom as TiPlotChannel;
  AXAxis      := AChannel.XAxis;
  //Store Restore Values--------------------------------------------------------
  AOldVisible          := Visible;
  AOldStyle            := Style;
  AOldChannelName      := ChannelName;
  AOldPointer1Position := Pointer1Position;
  AOldMin              := AXAxis.Min;
  //Setup-----------------------------------------------------------------------
  Visible              := True;
  Style                := ipcsValueXY;
  self.ChannelName     := ChannelName;
  //Make Measurement------------------------------------------------------------
  if not(FUseCachedInterpolatedData) then
    begin
      Pointer1Position     := 0;
      AXAxis.Min           := XValue;
      TiPlotComponentAccess(Owner).ReCalcLayout()
    end
  else
    begin
      Pointer1Position := AXAxis.PositionToPercent(XValue)*100;
      DoUpdate();
    end;

  Result               := Status;
  YValue               := ValueY;
  //Restore--------------------------------------------------------------------
  Visible              := AOldVisible;
  Style                := AOldStyle;
  self.ChannelName     := AOldChannelName;
  Pointer1Position     := AOldPointer1Position;
  AXAxis.Min           := AOldMin;

  TiPlotAxisAccess(AChannelCustom.XAxis).BlockMinSpanEvents := False;
end;
//****************************************************************************************************************************************************
end.
