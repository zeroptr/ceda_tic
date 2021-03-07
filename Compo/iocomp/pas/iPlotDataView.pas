{*******************************************************}
{                                                       }
{       TiPlotDataView                                  }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotDataView;{$endif}
{$ifdef iCLX}unit QiPlotDataView;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iPlotObjects,  iPlotAxis;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiPlotObjects, QiPlotAxis;{$ENDIF}

type
  TiPlotZoomBoxEvent      = procedure(ARect : TRect) of object;
  TiPlotDataViewMode      = (ipdvmNone, ipdvmZoomBox, ipdvmSelect, ipdvmScrollZoom);
  TiPlotAxesControlStyle  = (ipacsXAxis, ipacsYAxis, ipacsBoth, ipacsNone);

  TiPlotDataView = class(TiPlotLayoutObject)
  private
    FXAxis                        : TiPlotXAxis;
    FYAxis                        : TiPlotYAxis;

    FMouseDownObject              : TiPlotObject;

    FMouseDown                    : Boolean;
    FMouseDownRight               : Boolean;
    FZoomBoxActive                : Boolean;
    FMouseDownX                   : Integer;
    FMouseDownY                   : Integer;
    FMouseMoveX                   : Integer;
    FMouseMoveY                   : Integer;
    FDirectionLock                : Boolean;
    FDirectionLockXAxis           : Boolean;

    FTitle                        : String;
    FBackgroundTransparent        : Boolean;
    FBackgroundColor              : TColor;
    FGridShow                     : Boolean;
    FAxesControlEnabled           : Boolean;
    FAxesControlWheelStyle        : TiPlotAxesControlStyle;
    FAxesControlMouseStyle        : TiPlotAxesControlStyle;

    FGridYAxisName                : String;
    FGridXAxisName                : String;
    FGridLineColor                : TColor;
    FGridLineShowLeft             : Boolean;
    FGridLineShowTop              : Boolean;
    FGridLineShowRight            : Boolean;
    FGridLineShowBottom           : Boolean;
    FGridLineShowXMajors          : Boolean;
    FGridLineShowXMinors          : Boolean;
    FGridLineShowYMajors          : Boolean;
    FGridLineShowYMinors          : Boolean;
    FGridLineMajorStyle           : TiPlotGridLineStyle;
    FGridLineMinorStyle           : TiPlotGridLineStyle;

    FGridLineXMajorCustom         : Boolean;
    FGridLineXMajorColor          : TColor;
    FGridLineXMajorWidth          : Integer;
    FGridLineXMajorStyle          : TiPlotGridLineStyle;

    FGridLineXMinorCustom         : Boolean;
    FGridLineXMinorColor          : TColor;
    FGridLineXMinorWidth          : Integer;
    FGridLineXMinorStyle          : TiPlotGridLineStyle;

    FGridLineYMajorCustom         : Boolean;
    FGridLineYMajorColor          : TColor;
    FGridLineYMajorWidth          : Integer;
    FGridLineYMajorStyle          : TiPlotGridLineStyle;

    FGridLineYMinorCustom         : Boolean;
    FGridLineYMinorColor          : TColor;
    FGridLineYMinorWidth          : Integer;
    FGridLineYMinorStyle          : TiPlotGridLineStyle;

    FAxesControlAllowInSelectMode : Boolean;
  protected
    procedure SetTitle                       (const Value: String);
    procedure SetBackgroundColor             (const Value: TColor);
    procedure SetBackgroundTransparent       (const Value: Boolean);
    procedure SetGridShow                    (const Value: Boolean);
    procedure SetAxesControlEnabled          (const Value: Boolean);
    procedure SetGridXAxisName               (const Value: String);
    procedure SetGridYAxisName               (const Value: String);
    procedure SetGridLineColor               (const Value: TColor);
    procedure SetGridLineShowLeft            (const Value: Boolean);
    procedure SetGridLineShowTop             (const Value: Boolean);
    procedure SetGridLineShowRight           (const Value: Boolean);
    procedure SetGridLineShowBottom          (const Value: Boolean);
    procedure SetGridLineShowXMajors         (const Value: Boolean);
    procedure SetGridLineShowXMinors         (const Value: Boolean);
    procedure SetGridLineShowYMajors         (const Value: Boolean);
    procedure SetGridLineShowYMinors         (const Value: Boolean);
    procedure SetGridLineMajorStyle          (const Value: TiPlotGridLineStyle);
    procedure SetGridLineMinorStyle          (const Value: TiPlotGridLineStyle);

    procedure SetGridLineXMajorCustom        (const Value: Boolean);
    procedure SetGridLineXMajorColor         (const Value: TColor);
    procedure SetGridLineXMajorWidth         (const Value: Integer);
    procedure SetGridLineXMajorStyle         (const Value: TiPlotGridLineStyle);

    procedure SetGridLineXMinorCustom        (const Value: Boolean);
    procedure SetGridLineXMinorColor         (const Value: TColor);
    procedure SetGridLineXMinorWidth         (const Value: Integer);
    procedure SetGridLineXMinorStyle         (const Value: TiPlotGridLineStyle);

    procedure SetGridLineYMajorCustom        (const Value: Boolean);
    procedure SetGridLineYMajorColor         (const Value: TColor);
    procedure SetGridLineYMajorWidth         (const Value: Integer);
    procedure SetGridLineYMajorStyle         (const Value: TiPlotGridLineStyle);

    procedure SetGridLineYMinorCustom        (const Value: Boolean);
    procedure SetGridLineYMinorColor         (const Value: TColor);
    procedure SetGridLineYMinorWidth         (const Value: Integer);
    procedure SetGridLineYMinorStyle         (const Value: TiPlotGridLineStyle);

    procedure SetAxesControlAllowInSelectMode(const Value: Boolean);

    procedure XAxisNeeded;
    procedure YAxisNeeded;

    procedure NotificationRemove  (Sender: TObject);                                                               override;
    procedure NotificationRename  (Sender: TObject);                                                               override;
    procedure NotificationSetFocus(Sender: TObject);                                                               override;

    function  GetMousePointer(APoint: TPoint): TCursor;                                                            override;
    function  GetMouseObject(X, Y: Integer): TiPlotObject;                                                         override;

    function  GetMode      : TiPlotDataViewMode;

    procedure Draw          (const Canvas: TCanvas; const BackGroundColor: TColor);                                override;
    procedure DrawGrid      (const Canvas: TCanvas; const BackGroundColor: TColor);
    procedure DrawBackground(const Canvas: TCanvas                               );
    procedure DrawForeground(const Canvas: TCanvas                               );

    procedure DoMouseLeft (MouseData: TiPlotMouseData);                                                            override;
    procedure DoMouseRight(MouseData: TiPlotMouseData);                                                            override;
    procedure DoMouseMove (MouseData: TiPlotMouseData);                                                            override;
    procedure DoMouseUp   (MouseData: TiPlotMouseData);                                                            override;

    function  DoMouseWheel(WheelDelta: Integer; Shift: TShiftState; AX, AY: Integer): Boolean;                     override;

    procedure iKeyDown    (var CharCode: Word; Shift: TShiftState; PopupMenu : TPopupMenu);                        override;

    procedure DoZoom(ARect: TRect);

    procedure AddMenuItems(PopupMenu: TPopUpMenu);                                                                 override;

    property Mode                 : TiPlotDataViewMode      read GetMode;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);                 override;
    destructor  Destroy;                                                                                           override;

    function  PixelsXToPositionPercent(Value: Integer): Double;
    function  PixelsYToPositionPercent(Value: Integer): Double;
    function  PositionPercentToPixelsX(Value: Double ): Integer;
    function  PositionPercentToPixelsY(Value: Double ): Integer;
  published
    property Title                        : String                 read FTitle                        write SetTitle;

    property BackgroundTransparent        : Boolean                read FBackgroundTransparent        write SetBackgroundTransparent        default True;
    property BackgroundColor              : TColor                 read FBackgroundColor              write SetBackgroundColor              default clTeal;

    property GridXAxisName                : String                 read FGridXAxisName                write SetGridXAxisName;
    property GridYAxisName                : String                 read FGridYAxisName                write SetGridYAxisName;

    property GridShow                     : Boolean                read FGridShow                     write SetGridShow                     default True;
    property GridLineColor                : TColor                 read FGridLineColor                write SetGridLineColor                default clGreen;

    property GridLineShowLeft             : Boolean                read FGridLineShowLeft             write SetGridLineShowLeft             default True;
    property GridLineShowRight            : Boolean                read FGridLineShowRight            write SetGridLineShowRight            default True;
    property GridLineShowTop              : Boolean                read FGridLineShowTop              write SetGridLineShowTop              default True;
    property GridLineShowBottom           : Boolean                read FGridLineShowBottom           write SetGridLineShowBottom           default True;

    property GridLineShowXMajors          : Boolean                read FGridLineShowXMajors          write SetGridLineShowXMajors          default True;
    property GridLineShowXMinors          : Boolean                read FGridLineShowXMinors          write SetGridLineShowXMinors          default False;
    property GridLineShowYMajors          : Boolean                read FGridLineShowYMajors          write SetGridLineShowYMajors          default True;
    property GridLineShowYMinors          : Boolean                read FGridLineShowYMinors          write SetGridLineShowYMinors          default False;

    property GridLineMajorStyle           : TiPlotGridLineStyle    read FGridLineMajorStyle           write SetGridLineMajorStyle           default ipglsSolid;
    property GridLineMinorStyle           : TiPlotGridLineStyle    read FGridLineMinorStyle           write SetGridLineMinorStyle           default ipglsSolid;

    property GridLineXMajorCustom         : Boolean                read FGridLineXMajorCustom         write SetGridLineXMajorCustom         default False;
    property GridLineXMajorColor          : TColor                 read FGridLineXMajorColor          write SetGridLineXMajorColor          default clGreen;
    property GridLineXMajorWidth          : Integer                read FGridLineXMajorWidth          write SetGridLineXMajorWidth          default 0;
    property GridLineXMajorStyle          : TiPlotGridLineStyle    read FGridLineXMajorStyle          write SetGridLineXMajorStyle          default ipglsSolid;

    property GridLineXMinorCustom         : Boolean                read FGridLineXMinorCustom         write SetGridLineXMinorCustom         default False;
    property GridLineXMinorColor          : TColor                 read FGridLineXMinorColor          write SetGridLineXMinorColor          default clGreen;
    property GridLineXMinorWidth          : Integer                read FGridLineXMinorWidth          write SetGridLineXMinorWidth          default 0;
    property GridLineXMinorStyle          : TiPlotGridLineStyle    read FGridLineXMinorStyle          write SetGridLineXMinorStyle          default ipglsSolid;

    property GridLineYMajorCustom         : Boolean                read FGridLineYMajorCustom         write SetGridLineYMajorCustom         default False;
    property GridLineYMajorColor          : TColor                 read FGridLineYMajorColor          write SetGridLineYMajorColor          default clGreen;
    property GridLineYMajorWidth          : Integer                read FGridLineYMajorWidth          write SetGridLineYMajorWidth          default 0;
    property GridLineYMajorStyle          : TiPlotGridLineStyle    read FGridLineYMajorStyle          write SetGridLineYMajorStyle          default ipglsSolid;

    property GridLineYMinorCustom         : Boolean                read FGridLineYMinorCustom         write SetGridLineYMinorCustom         default False;
    property GridLineYMinorColor          : TColor                 read FGridLineYMinorColor          write SetGridLineYMinorColor          default clGreen;
    property GridLineYMinorWidth          : Integer                read FGridLineYMinorWidth          write SetGridLineYMinorWidth          default 0;
    property GridLineYMinorStyle          : TiPlotGridLineStyle    read FGridLineYMinorStyle          write SetGridLineYMinorStyle          default ipglsSolid;

    property AxesControlEnabled           : Boolean                read FAxesControlEnabled           write SetAxesControlEnabled;
    property AxesControlMouseStyle        : TiPlotAxesControlStyle read FAxesControlMouseStyle        write FAxesControlMouseStyle;
    property AxesControlWheelStyle        : TiPlotAxesControlStyle read FAxesControlWheelStyle        write FAxesControlWheelStyle;

    property AxesControlAllowInSelectMode : Boolean                read FAxesControlAllowInSelectMode write SetAxesControlAllowInSelectMode default False;
  end;

implementation

uses
{$ifdef iVCL} iPlotDataCursor,  iPlotComponent;{$endif}
{$ifdef iCLX}QiPlotDataCursor, QiPlotComponent;{$endif}

type
  TiPlotAxisAccess       = class(TiPlotAxis      )end;
  TiPlotDataCursorAccess = class(TiPlotDataCursor)end;
  TiPlotObjectAccess     = class(TiPlotObject    )end;
  TiPlotComponentAccess  = class(TiPlotComponent )end;

//****************************************************************************************************************************************************
constructor TiPlotDataView.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited;
  FBackgroundTransparent := True;
  FBackgroundColor       := clTeal;
  FAxesControlMouseStyle := ipacsBoth;

  FGridShow              := True;
  FGridLineColor         := clGreen;
  FGridLineShowLeft      := True;
  FGridLineShowTop       := True;
  FGridLineShowRight     := True;
  FGridLineShowBottom    := True;
  FGridLineShowXMajors   := True;
  FGridLineShowXMinors   := False;
  FGridLineShowYMajors   := True;
  FGridLineShowYMinors   := False;

  FGridLineXMajorCustom  := False;
  FGridLineXMajorColor   := clGreen;
  FGridLineXMajorWidth   := 0;
  FGridLineXMajorStyle   := ipglsSolid;

  FGridLineXMinorCustom  := False;
  FGridLineXMinorColor   := clGreen;
  FGridLineXMinorWidth   := 0;
  FGridLineXMinorStyle   := ipglsSolid;

  FGridLineYMajorCustom  := False;
  FGridLineYMajorColor   := clGreen;
  FGridLineYMajorWidth   := 0;
  FGridLineYMajorStyle   := ipglsSolid;

  FGridLineYMinorCustom  := False;
  FGridLineYMinorColor   := clGreen;
  FGridLineYMinorWidth   := 0;
  FGridLineYMinorStyle   := ipglsSolid;
end;
//****************************************************************************************************************************************************
destructor TiPlotDataView.Destroy;
begin
  inherited;                         
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.NotificationRemove(Sender: TObject);
begin
  if Sender = FXAxis then FXAxis := nil;
  if Sender = FYAxis then FYAxis := nil;
  if Sender = FMouseDownObject then FMouseDownObject := nil;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.NotificationRename(Sender: TObject);
begin
  if Sender = FXAxis then FGridXAxisName := (Sender as TiPlotXAxis).Name;
  if Sender = FYAxis then FGridYAxisName := (Sender as TiPlotYAxis).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.AddMenuItems(PopupMenu: TPopUpMenu);
begin
  inherited AddMenuItems(PopupMenu);
  AddEditMenuItems(PopupMenu);
end;
//****************************************************************************************************************************************************
function TiPlotDataView.GetMousePointer(APoint: TPoint): TCursor;
begin
  Result := inherited GetMousePointer(APoint);
  if MouseOverObject = Self then
    case Mode of
      ipdvmZoomBox    : Result := crDrag;
      ipdvmScrollZoom : Result := crHandPoint
      else              Result := crDefault;
    end;

  TiPlotComponentAccess(Owner).DoGetMouseCursor(Self, Result);
end;
//****************************************************************************************************************************************************
function TiPlotDataView.GetMouseObject(X, Y: Integer): TiPlotObject;
begin
  Result          := Self;
  MouseOverObject := Result;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.DoMouseLeft(MouseData: TiPlotMouseData);
var
  x : Integer;
begin
  FDirectionLock := False;

  FMouseDown  := True;

  case Mode of
    ipdvmScrollZoom : begin
                        FMouseDownX := MouseData.X;
                        FMouseDownY := MouseData.Y;

                        for x := 0 to (Owner as TiPlotComponent).XAxisCount-1 do
                          TiPlotObjectAccess((Owner as TiPlotComponent).XAxis[x]).DoMouseLeft(MouseData);
                        for x := 0 to (Owner as TiPlotComponent).YAxisCount-1 do
                          TiPlotObjectAccess((Owner as TiPlotComponent).YAxis[x]).DoMouseLeft(MouseData);
                      end;
    ipdvmZoomBox    : begin
                        TiPlotComponentAccess(Owner).DisableAllTracking;
                        FMouseDownX    := MouseData.X;
                        FMouseDownY    := MouseData.Y;
                        FMouseMoveX    := MouseData.X;
                        FMouseMoveY    := MouseData.Y;
                        FZoomBoxActive := True;
                        TriggerInvalidateNow(Self);
                      end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.DoMouseRight(MouseData: TiPlotMouseData);
begin
  case Mode of
    ipdvmScrollZoom : begin
                        FMouseDownRight := True;
                        FMouseDownX     := MouseData.X;
                        FMouseDownY     := MouseData.Y;
                        FMouseMoveX     := MouseData.X;
                        FMouseMoveY     := MouseData.Y;
                      end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.DoMouseMove(MouseData: TiPlotMouseData);
var
  x       : Integer;
  ADeltaX : Integer;
  ADeltaY : Integer;

begin
  if not (FMouseDown or FMouseDownRight) then Exit;

  if FZoomBoxActive then
    begin
      if not MouseData.DblClickActive then
        begin
          FMouseMoveX  := MouseData.X;
          FMouseMoveY  := MouseData.Y;
          TriggerInvalidateNow(Self);
        end;
    end
  else
    case Mode of
      ipdvmScrollZoom : begin
                          if FMouseDownRight and not FZoomBoxActive then
                            begin
                              ADeltaX := Abs(FMouseDownX - MouseData.X);
                              ADeltaY := Abs(FMouseDownY - MouseData.Y);

                              if (ADeltaX > 5) or (ADeltaY > 5) then
                                begin
                                  FMouseMoveX    := MouseData.X;
                                  FMouseMoveY    := MouseData.Y;
                                  FZoomBoxActive := True;
                                  CancelPopup;
                                  TiPlotComponentAccess(Owner).DisableAllTracking;
                                  TriggerInvalidateNow(Self);
                                end;

                            end
                          else
                            begin
                              case FAxesControlMouseStyle of
                                ipacsXAxis : if GetShiftDown then
                                               begin
                                                 FDirectionLock      := True;
                                                 FDirectionLockXAxis := False;
                                               end
                                             else
                                               begin
                                                 FDirectionLock      := True;
                                                 FDirectionLockXAxis := True;
                                               end;
                                ipacsYAxis : if GetShiftDown then
                                               begin
                                                 FDirectionLock      := True;
                                                 FDirectionLockXAxis := True;
                                               end
                                             else
                                               begin
                                                 FDirectionLock      := True;
                                                 FDirectionLockXAxis := False;
                                               end;
                                ipacsBoth  : begin
                                               if not FDirectionLock then if GetShiftDown then
                                                 begin
                                                   if ABS(MouseData.X - FMouseDownX) > 3 then
                                                     begin
                                                       FDirectionLock      := True;
                                                       FDirectionLockXAxis := True;
                                                     end;

                                                   if ABS(MouseData.Y - FMouseDownY) > 3 then
                                                     begin
                                                       FDirectionLock      := True;
                                                       FDirectionLockXAxis := False;
                                                     end;
                                                 end;
                                             end;
                                ipacsNone  : begin
                                               Exit;
                                             end;
                              end;

                              if not FDirectionLock or FDirectionLockXAxis then
                                for x := 0 to (Owner as TiPlotComponent).XAxisCount-1 do
                                  TiPlotObjectAccess((Owner as TiPlotComponent).XAxis[x]).DoMouseMove(MouseData);

                              if not FDirectionLock or not FDirectionLockXAxis then
                                  for x := 0 to (Owner as TiPlotComponent).YAxisCount-1 do
                                    TiPlotObjectAccess((Owner as TiPlotComponent).YAxis[x]).DoMouseMove(MouseData);
                            end;
                        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.DoMouseUp(MouseData: TiPlotMouseData);
var
  x : Integer;
begin
  if not (FMouseDown or FMouseDownRight) then Exit;

  if FZoomBoxActive then
    begin
      if not MouseData.DblClickActive then
        begin
          if (FMouseMoveX > FMouseDownX) and (FMouseMoveY > FMouseDownY) then
            begin
              DoZoom(Rect(FMouseDownX, FMouseDownY, FMouseMoveX, FMouseMoveY));
              TriggerInvalidateNow(Self);
            end;
        end;
    end
  else
    case Mode of
      ipdvmScrollZoom : begin
                          for x := 0 to (Owner as TiPlotComponent).XAxisCount-1 do
                            TiPlotObjectAccess((Owner as TiPlotComponent).XAxis[x]).DoMouseUp(MouseData);
                          for x := 0 to (Owner as TiPlotComponent).YAxisCount-1 do
                            TiPlotObjectAccess((Owner as TiPlotComponent).YAxis[x]).DoMouseUp(MouseData);
                        end;
    end;

  if PtInRect(DrawRect, Point(MouseData.X, MouseData.Y)) then TiPlotComponentAccess(Owner).DoObjectClick(Self);

  FMouseDown      := False;
  FMouseDownRight := False;
  FZoomBoxActive  := False;
  TriggerInvalidateNow(Self);
end;
//****************************************************************************************************************************************************
function TiPlotDataView.DoMouseWheel(WheelDelta: Integer; Shift: TShiftState; AX, AY: Integer): Boolean;
var
  x : Integer;
begin
  Result := False;
  case Mode of
    ipdvmScrollZoom : begin
                        case FAxesControlWheelStyle of
                          ipacsXAxis : if GetShiftDown then
                                         begin
                                           FDirectionLock      := True;
                                           FDirectionLockXAxis := False;
                                         end
                                       else
                                         begin
                                           FDirectionLock      := True;
                                           FDirectionLockXAxis := True;
                                         end;
                          ipacsYAxis : if GetShiftDown then
                                         begin
                                           FDirectionLock      := True;
                                           FDirectionLockXAxis := True;
                                         end
                                       else
                                         begin
                                           FDirectionLock      := True;
                                           FDirectionLockXAxis := False;
                                         end;
                          ipacsBoth  : begin
                                         FDirectionLock := False;
                                       end;
                          ipacsNone  : begin
                                         Exit;
                                       end;
                        end;

                        if not FDirectionLock or FDirectionLockXAxis then
                          for x := 0 to (Owner as TiPlotComponent).XAxisCount-1 do
                            TiPlotObjectAccess((Owner as TiPlotComponent).XAxis[x]).DoMouseWheel(WheelDelta, Shift, AX, AY);

                        if not FDirectionLock or not FDirectionLockXAxis then
                          for x := 0 to (Owner as TiPlotComponent).YAxisCount-1 do
                            TiPlotObjectAccess((Owner as TiPlotComponent).YAxis[x]).DoMouseWheel(WheelDelta, Shift, AX, AY);

                        Result := True;
                      end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.iKeyDown(var CharCode: Word; Shift: TShiftState; PopupMenu : TPopupMenu);
begin
  inherited iKeyDown(CharCode, Shift, PopupMenu);

  if CharCode = VK_ESCAPE then
    begin
      FZoomBoxActive := False;
      TriggerInvalidateNow(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.DoZoom(ARect: TRect);
var
  x        : Integer;
  Cancel   : Boolean;
  ZoomRect : TRect;
begin
  Cancel   := False;
  ZoomRect := ARect;

  if Assigned(TiPlotComponentAccess(Owner).OnBeforeZoomBox) then TiPlotComponentAccess(Owner).OnBeforeZoomBox(ZoomRect, Cancel);

  if not Cancel then
    begin
      with TiPlotComponentAccess(Owner) do
        begin
          for x := 0 to XAxisCount-1 do
            TiPlotAxisAccess(XAxis[x]).ZoomRect(ZoomRect);

          for x := 0 to YAxisCount-1 do
            TiPlotAxisAccess(YAxis[x]).ZoomRect(ZoomRect);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.SetTitle                       (const Value:String );begin SetStringProperty (Value,FTitle,                       TriggerChange );end;
procedure TiPlotDataView.SetBackgroundColor             (const Value:TColor );begin SetColorProperty  (Value,FBackgroundColor,             TriggerChange );end;
procedure TiPlotDataView.SetBackgroundTransparent       (const Value:Boolean);begin SetBooleanProperty(Value,FBackgroundTransparent,       TriggerChange );end;
procedure TiPlotDataView.SetGridShow                    (const Value:Boolean);begin SetBooleanProperty(Value,FGridShow,                    TriggerChange );end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.SetGridLineColor               (const Value:TColor );begin SetColorProperty  (Value,FGridLineColor,               TriggerChange);end;
procedure TiPlotDataView.SetGridLineShowLeft            (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineShowLeft,            TriggerChange);end;
procedure TiPlotDataView.SetGridLineShowTop             (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineShowTop,             TriggerChange);end;
procedure TiPlotDataView.SetGridLineShowRight           (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineShowRight,           TriggerChange);end;
procedure TiPlotDataView.SetGridLineShowBottom          (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineShowBottom,          TriggerChange);end;
procedure TiPlotDataView.SetGridLineShowXMajors         (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineShowXMajors,         TriggerChange);end;
procedure TiPlotDataView.SetGridLineShowXMinors         (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineShowXMinors,         TriggerChange);end;
procedure TiPlotDataView.SetGridLineShowYMajors         (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineShowYMajors,         TriggerChange);end;
procedure TiPlotDataView.SetGridLineShowYMinors         (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineShowYMinors,         TriggerChange);end;

procedure TiPlotDataView.SetGridLineXMajorCustom        (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineXMajorCustom,        TriggerChange);end;
procedure TiPlotDataView.SetGridLineXMajorColor         (const Value:TColor );begin SetColorProperty  (Value,FGridLineXMajorColor,         TriggerChange);end;
procedure TiPlotDataView.SetGridLineXMajorWidth         (const Value:Integer);begin SetIntegerProperty(Value,FGridLineXMajorWidth,         TriggerChange);end;
procedure TiPlotDataView.SetGridLineXMinorCustom        (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineXMinorCustom,        TriggerChange);end;
procedure TiPlotDataView.SetGridLineXMinorColor         (const Value:TColor );begin SetColorProperty  (Value,FGridLineXMinorColor,         TriggerChange);end;
procedure TiPlotDataView.SetGridLineXMinorWidth         (const Value:Integer);begin SetIntegerProperty(Value,FGridLineXMinorWidth,         TriggerChange);end;

procedure TiPlotDataView.SetGridLineYMajorCustom        (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineYMajorCustom,        TriggerChange);end;
procedure TiPlotDataView.SetGridLineYMajorColor         (const Value:TColor );begin SetColorProperty  (Value,FGridLineYMajorColor,         TriggerChange);end;
procedure TiPlotDataView.SetGridLineYMajorWidth         (const Value:Integer);begin SetIntegerProperty(Value,FGridLineYMajorWidth,         TriggerChange);end;
procedure TiPlotDataView.SetGridLineYMinorCustom        (const Value:Boolean);begin SetBooleanProperty(Value,FGridLineYMinorCustom,        TriggerChange);end;
procedure TiPlotDataView.SetGridLineYMinorColor         (const Value:TColor );begin SetColorProperty  (Value,FGridLineYMinorColor,         TriggerChange);end;
procedure TiPlotDataView.SetGridLineYMinorWidth         (const Value:Integer);begin SetIntegerProperty(Value,FGridLineYMinorWidth,         TriggerChange);end;

procedure TiPlotDataView.SetAxesControlEnabled          (const Value:Boolean);begin SetBooleanProperty(Value,FAxesControlEnabled,          nil          );end;
procedure TiPlotDataView.SetAxesControlAllowInSelectMode(const Value:Boolean);begin SetBooleanProperty(Value,FAxesControlAllowInSelectMode,TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.SetGridXAxisName(const Value:String );
begin
  if FGridXAxisName <> Value then
    begin
      FGridXAxisName := Value;
      FXAxis := nil;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.SetGridYAxisName(const Value:String );
begin
  if FGridYAxisName <> Value then
    begin
      FGridYAxisName := Value;
      FYAxis := nil;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.SetGridLineMajorStyle(const Value: TiPlotGridLineStyle);
begin
  if FGridLineMajorStyle <> Value then
    begin
      FGridLineMajorStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.SetGridLineMinorStyle(const Value: TiPlotGridLineStyle);
begin
  if FGridLineMinorStyle <> Value then
    begin
      FGridLineMinorStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.SetGridLineXMajorStyle(const Value: TiPlotGridLineStyle);
begin
  if FGridLineXMajorStyle <> Value then
    begin
      FGridLineXMajorStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.SetGridLineXMinorStyle(const Value: TiPlotGridLineStyle);
begin
  if FGridLineXMinorStyle <> Value then
    begin
      FGridLineXMinorStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.SetGridLineYMajorStyle(const Value: TiPlotGridLineStyle);
begin
  if FGridLineYMajorStyle <> Value then
    begin
      FGridLineYMajorStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.SetGridLineYMinorStyle(const Value: TiPlotGridLineStyle);
begin
  if FGridLineYMinorStyle <> Value then
    begin
      FGridLineYMinorStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
begin
  inherited;
  with Canvas do
    begin
      DrawGrid(Canvas, BackGroundColor);
      if UserSelected then
        begin
          Pen.Color   := BackGroundColor;
          Brush.Style := bsClear;
          Brush.Color := BackGroundColor;

          PolyLine([Point(DrawRect.Left,  DrawRect.Top   ), Point(DrawRect.Left,    DrawRect.Bottom)]);
          PolyLine([Point(DrawRect.Right, DrawRect.Top   ), Point(DrawRect.Right,   DrawRect.Bottom)]);
          PolyLine([Point(DrawRect.Left,  DrawRect.Top   ), Point(DrawRect.Right,   DrawRect.Top   )]);
          PolyLine([Point(DrawRect.Left,  DrawRect.Bottom), Point(DrawRect.Right+1, DrawRect.Bottom)]);

          Font.Color := clWhite;
          iDrawFocusRect2(Canvas, Rect(DrawRect.Left, DrawRect.Top, DrawRect.Right+1, DrawRect.Bottom+1));
        end;

    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.DrawForeground(const Canvas: TCanvas);
begin
  with Canvas do
    begin
      if FZoomBoxActive then
        begin
          Font.Color := clWhite;
          iDrawFocusRect2(Canvas, Rect(FMouseDownX, FMouseDownY, FMouseMoveX, FMouseMoveY));
        end;

    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.DrawGrid(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  x          : Integer;
  MajorColor : TColor;
  MinorColor : TColor;
  MajorWidth : Integer;
  MinorWidth : Integer;
  MajorStyle : TiPlotGridLineStyle;
  MinorStyle : TiPlotGridLineStyle;
begin
  if not FGridShow then Exit;

  with Canvas do
    begin
      Brush.Color := BackGroundColor;
      
      if FGridLineXMajorCustom then
        begin
          MajorColor := FGridLineXMajorColor;
          MajorWidth := FGridLineXMajorWidth;
          MajorStyle := FGridLineXMajorStyle;
        end
      else
        begin
          MajorColor := FGridLineColor;
          {$IFDEF iCLX}
          MajorWidth := 1;
          {$ELSE}
          MajorWidth := 0;
          {$ENDIF}

          MajorStyle := FGridLineMajorStyle;
        end;

      if FGridLineXMinorCustom then
        begin
          MinorColor := FGridLineXMinorColor;
          MinorWidth := FGridLineXMinorWidth;
          MinorStyle := FGridLineXMinorStyle;
        end
      else
        begin
          MinorColor := FGridLineColor;
          {$IFDEF iCLX}
          MinorWidth := 1;
          {$ELSE}
          MinorWidth := 0;
          {$ENDIF}
          MinorStyle := FGridLineMinorStyle;
        end;

      if UpperCase(FGridXAxisName) = '<ALL>' then
        with Owner as TiPlotComponent do
          begin
            for x := 0 to XAxisCount-1 do
            TiPlotAxisAccess(XAxis[x]).DrawGridLines(Canvas, DrawRect, FGridLineShowXMajors, FGridLineShowXMinors, MajorStyle, MinorStyle,  MajorColor, MinorColor, MajorWidth, MinorWidth);
          end
      else
        begin
          XAxisNeeded;
          if Assigned(FXAxis) then
            TiPlotAxisAccess(FXAxis).DrawGridLines(Canvas, DrawRect, FGridLineShowXMajors, FGridLineShowXMinors, MajorStyle, MinorStyle,  MajorColor, MinorColor, MajorWidth, MinorWidth);
        end;

      if FGridLineYMajorCustom then
        begin
          MajorColor := FGridLineYMajorColor;
          MajorWidth := FGridLineYMajorWidth;
          MajorStyle := FGridLineYMajorStyle;
        end
      else
        begin
          MajorColor := FGridLineColor;
          MajorWidth := 0;
          MajorStyle := FGridLineMajorStyle;
        end;

      if FGridLineYMinorCustom then
        begin
          MinorColor := FGridLineYMinorColor;
          MinorWidth := FGridLineYMinorWidth;
          MinorStyle := FGridLineYMinorStyle;
        end
      else
        begin
          MinorColor := FGridLineColor;
          MinorWidth := 0;
          MinorStyle := FGridLineMinorStyle;
        end;

      if UpperCase(FGridYAxisName) = '<ALL>' then
        with Owner as TiPlotComponent do
          begin
            for x := 0 to YAxisCount-1 do
            TiPlotAxisAccess(YAxis[x]).DrawGridLines(Canvas, DrawRect, FGridLineShowYMajors, FGridLineShowYMinors, MajorStyle, MinorStyle,  MajorColor, MinorColor, MajorWidth, MinorWidth);
          end
      else
        begin
          YAxisNeeded;
          if Assigned(FYAxis) then
          TiPlotAxisAccess(FYAxis).DrawGridLines(Canvas, DrawRect, FGridLineShowYMajors, FGridLineShowYMinors, MajorStyle, MinorStyle,  MajorColor, MinorColor, MajorWidth, MinorWidth);
        end;

      Pen.Color := FGridLineColor;
      Pen.Style := psSolid;
      Pen.Width := 0;

      if FGridLineShowLeft   then PolyLine([Point(DrawRect.Left,  DrawRect.Top   ), Point(DrawRect.Left,    DrawRect.Bottom)]);
      if FGridLineShowRight  then PolyLine([Point(DrawRect.Right, DrawRect.Top   ), Point(DrawRect.Right,   DrawRect.Bottom)]);
      if FGridLineShowTop    then PolyLine([Point(DrawRect.Left,  DrawRect.Top   ), Point(DrawRect.Right,   DrawRect.Top   )]);
      if FGridLineShowBottom then PolyLine([Point(DrawRect.Left,  DrawRect.Bottom), Point(DrawRect.Right+1, DrawRect.Bottom)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.DrawBackground(const Canvas: TCanvas);
begin
  with Canvas do
    begin
      if not FBackgroundTransparent then
        begin
          Brush.Style := bsSolid;
          Brush.Color := FBackgroundColor;
          FillRect(DrawRect);
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotDataView.PixelsXToPositionPercent(Value: Integer): Double;
begin
  Result := (Value - Left)/Width*100;
end;
//****************************************************************************************************************************************************
function TiPlotDataView.PixelsYToPositionPercent(Value: Integer): Double;
begin
  Result := (1 - (Value - Top)/Height)*100;
end;
//****************************************************************************************************************************************************
function TiPlotDataView.PositionPercentToPixelsX(Value: Double): Integer;
begin
  Result := Round(Left + (Width)*Value/100);
end;
//****************************************************************************************************************************************************
function TiPlotDataView.PositionPercentToPixelsY(Value: Double): Integer;
begin
  Result := round(Top + (Height)*(100.0-Value)/100.0);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.NotificationSetFocus(Sender: TObject);
begin
  if Sender = Self                             then Exit;
  if not (Sender as TiPlotObject).UserSelected then Exit;
            
  SetUserSelected(False);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.XAxisNeeded;
begin
  if not Assigned(FXAxis) then FXAxis := (Owner as TiPlotComponent).GetXAxisByName(FGridXAxisName);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataView.YAxisNeeded;
begin
  if not Assigned(FYAxis) then FYAxis := (Owner as TiPlotComponent).GetYAxisByName(FGridYAxisName);
end;
//****************************************************************************************************************************************************
function TiPlotDataView.GetMode: TiPlotDataViewMode;
begin
  Result := ipdvmNone;

  if FAxesControlEnabled then Result := ipdvmScrollZoom;

  if (Owner as TiPlotComponent).ToolBar[0].ZoomBoxActive                                      then Result := ipdvmZoomBox;
  if (Owner as TiPlotComponent).ToolBar[0].SelectActive and not FAxesControlAllowInSelectMode then Result := ipdvmSelect;
end;
//****************************************************************************************************************************************************
end.
