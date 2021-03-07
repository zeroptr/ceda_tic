{*******************************************************}
{                                                       }
{       TiXYPlotChannel                                 }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iXYPlotChannel;{$endif}
{$ifdef iCLX}unit QiXYPlotChannel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iClasses,  iPlotObjects,  iPlotDataNullList,  iPlotChannelCustom,  iPlotAxis,  iOPCManager, iOPCItem;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiClasses, QiPlotObjects, QiPlotDataNullList, QiPlotChannelCustom, QiPlotAxis, QiOPCManager;{$ENDIF}

type
  TiXYPlotChannel = class(TiPlotChannelCustom)
  private
    {$IFDEF iVCL}
    FOPCManager     : TiOPCManager;
    FOPCItemManager : TiOPCItemManager;
    {$endif}

    function GetDataCursorDisplayText(Style: TiPlotDataCursorStyle; XValue, YValue: Double; Status: TiPlotDataPointStatus): String;
    {$IFDEF iVCL}
    procedure AfterGroupUpdate(Sender: TObject; GroupName: String);
    {$endif}
  protected
    procedure DrawSetup(const Canvas: TCanvas);                                override;
    procedure Draw     (const Canvas: TCanvas; const BackGroundColor: TColor); override;
    procedure CalcStartXIndex; override;
    procedure CalcStopXIndex;  override;

    function  GetVisibleMaxX : Double; override;
    function  GetVisibleMinX : Double; override;
    function  GetVisibleMaxY : Double; override;
    function  GetVisibleMinY : Double; override;

   {$IFDEF iVCL}
    procedure SetOPCComputerName(const Value: String);
    procedure SetOPCItemName    (const Value: String);
    procedure SetOPCItem2Name   (const Value: String);
    procedure SetOPCServerName  (const Value: String);
    procedure SetOPCUpdateRate  (const Value: Integer);
    procedure SetOPCScalar      (const Value: Double);
    procedure SetOPCOffset      (const Value: Double);
    procedure SetOPCScalar2     (const Value: Double);
    procedure SetOPCOffset2     (const Value: Double);
    procedure SetOPCAutoConnect (const Value: Boolean);

    function GetOPCComputerName : String;
    function GetOPCItemName     : String;
    function GetOPCItem2Name    : String;
    function GetOPCServerName   : String;
    function GetOPCUpdateRate   : Integer;
    function GetOPCScalar       : Double;
    function GetOPCOffset       : Double;
    function GetOPCScalar2      : Double;
    function GetOPCOffset2      : Double;
    function GetOPCAutoConnect  : Boolean;
    function GetOPCActive       : Boolean;
    function GetOPCQualityGood  : Boolean;
    {$endif}

    procedure DataCursorUpate(Sender: TObject); override;
    procedure Loaded;                           override;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); override;
    destructor  Destroy;                                                                           override;

   {$IFDEF iVCL}
    procedure OPCActivate;
    procedure OPCActivateSuspend;
    procedure OPCDeactivate;
    procedure OPCUpdateSuspend;
    procedure OPCUpdateResume;

    property OPCActive      : Boolean read GetOPCActive;
    property OPCQualityGood : Boolean read GetOPCQualityGood;
    {$endif}

    function AddNull  : Integer;
    function AddEmpty : Integer;
  published
    {$IFDEF iVCL}
    property OPCComputerName : String  read GetOPCComputerName write SetOPCComputerName;
    property OPCServerName   : String  read GetOPCServerName   write SetOPCServerName;
    property OPCItemName     : String  read GetOPCItemName     write SetOPCItemName;
    property OPCUpdateRate   : Integer read GetOPCUpdateRate   write SetOPCUpdateRate  default 500;
    property OPCScalar       : Double  read GetOPCScalar       write SetOPCScalar;
    property OPCOffset       : Double  read GetOPCOffset       write SetOPCOffset;
    property OPCScalar2      : Double  read GetOPCScalar2      write SetOPCScalar2;
    property OPCOffset2      : Double  read GetOPCOffset2      write SetOPCOffset2;
    property OPCAutoConnect  : Boolean read GetOPCAutoConnect  write SetOPCAutoConnect default True;
    property OPCItem2Name    : String  read GetOPCItem2Name    write SetOPCItem2Name;
   {$endif}
  end;

implementation

uses
{$ifdef iVCL} iPlotComponent,  iPlotDataCursor,  iPlotDataCustomList,  iPlotDataView;{$endif}
{$ifdef iCLX}QiPlotComponent, QiPlotDataCursor, QiPlotDataCustomList, QiPlotDataView;{$endif}

type
  TiPlotComponentAccess  = class(TiPlotComponent )end;
  TiPlotDataCursorAccess = class(TiPlotDataCursor)end;
  TiPlotAxisAccess       = class(TiPlotAxis      )end;
//****************************************************************************************************************************************************
constructor TiXYPlotChannel.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited;

  {$IFDEF iVCL}
  FOPCManager                    := TiOPCManager.Create(nil);
  FOPCManager.OnAfterGroupUpdate := AfterGroupUpdate;

  FOPCItemManager                := TiOPCItemManager.Create;
  FOPCItemManager.OnGetDesigning := TiPlotComponentAccess(Owner).DoIsDesigning;

  FOPCItemManager.Add; FOPCItemManager.Items[0].PropertyName := 'Data';
  FOPCItemManager.Add; FOPCItemManager.Items[1].PropertyName := 'Data';
  {$endif}
end;
//****************************************************************************************************************************************************
destructor TiXYPlotChannel.Destroy;
begin
  {$IFDEF iVCL}
  FOPCItemManager.Free;
  FOPCManager.Free;
  {$endif}
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiXYPlotChannel.Loaded;
begin
  inherited;
  {$IFDEF iVCL}
  if FOPCItemManager.Items[0].AutoConnect then OPCActivate;
  {$endif}
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiXYPlotChannel.AfterGroupUpdate(Sender: TObject; GroupName: String);
begin
  AddXY(FOPCItemManager.Items[0].Data, FOPCItemManager.Items[1].Data);
end;
{$endif}
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiXYPlotChannel.OPCActivate;
begin
  if TiPlotComponentAccess(Owner).IsDesigning then Exit;

  FOPCItemManager.Items[0].Deactivate;
  FOPCItemManager.Items[1].Deactivate;

  FOPCManager.GroupClear;
  FOPCManager.GroupAdd(Format('%p', [@FOPCManager]),
                       FOPCItemManager.Items[0].ComputerName,
                       FOPCItemManager.Items[0].ServerName,
                       FOPCItemManager.Items[0].UpdateRate);

  FOPCItemManager.Items[0].GroupName := FOPCManager.Group[0].Name;
  FOPCItemManager.Items[1].GroupName := FOPCManager.Group[0].Name;

  FOPCItemManager.Items[0].Activate;
  FOPCItemManager.Items[1].Activate;
end;
//****************************************************************************************************************************************************
procedure TiXYPlotChannel.OPCActivateSuspend;
begin
  OPCActivate;
  OPCUpdateSuspend;
end;
//****************************************************************************************************************************************************
procedure TiXYPlotChannel.OPCDeactivate;     begin FOPCItemManager.Items[0].Deactivate; FOPCItemManager.Items[1].Deactivate end;
procedure TiXYPlotChannel.OPCUpdateSuspend;  begin FOPCManager.Group[0].Suspend; end;
procedure TiXYPlotChannel.OPCUpdateResume;   begin FOPCManager.Group[0].Resume;  end;
//****************************************************************************************************************************************************
procedure TiXYPlotChannel.SetOPCComputerName(const Value:String );begin FOPCItemManager.Items[0].ComputerName := Value; end;
procedure TiXYPlotChannel.SetOPCServerName  (const Value:String );begin FOPCItemManager.Items[0].ServerName   := Value; end;
procedure TiXYPlotChannel.SetOPCItemName    (const Value:String );begin FOPCItemManager.Items[0].ItemName     := Value; end;
procedure TiXYPlotChannel.SetOPCItem2Name   (const Value:String );begin FOPCItemManager.Items[1].ItemName     := Value; end;
procedure TiXYPlotChannel.SetOPCUpdateRate  (const Value:Integer);begin FOPCItemManager.Items[0].UpdateRate   := Value; end;
procedure TiXYPlotChannel.SetOPCScalar      (const Value:Double );begin FOPCItemManager.Items[0].Scalar       := Value; end;
procedure TiXYPlotChannel.SetOPCOffset      (const Value:Double );begin FOPCItemManager.Items[0].Offset       := Value; end;
procedure TiXYPlotChannel.SetOPCScalar2     (const Value:Double );begin FOPCItemManager.Items[1].Scalar       := Value; end;
procedure TiXYPlotChannel.SetOPCOffset2     (const Value:Double );begin FOPCItemManager.Items[1].Offset       := Value; end;
procedure TiXYPlotChannel.SetOPCAutoConnect (const Value:Boolean);begin FOPCItemManager.Items[0].AutoConnect  := Value; end;
//****************************************************************************************************************************************************
function TiXYPlotChannel.GetOPCComputerName : String;  begin Result := FOPCItemManager.Items[0].ComputerName; end;
function TiXYPlotChannel.GetOPCItemName     : String;  begin Result := FOPCItemManager.Items[0].ItemName;     end;
function TiXYPlotChannel.GetOPCItem2Name    : String;  begin Result := FOPCItemManager.Items[1].ItemName;     end;
function TiXYPlotChannel.GetOPCServerName   : String;  begin Result := FOPCItemManager.Items[0].ServerName;   end;
function TiXYPlotChannel.GetOPCUpdateRate   : Integer; begin Result := FOPCItemManager.Items[0].UpdateRate;   end;
function TiXYPlotChannel.GetOPCScalar       : Double;  begin Result := FOPCItemManager.Items[0].Scalar;       end;
function TiXYPlotChannel.GetOPCOffset       : Double;  begin Result := FOPCItemManager.Items[0].Offset;       end;
function TiXYPlotChannel.GetOPCScalar2      : Double;  begin Result := FOPCItemManager.Items[1].Scalar;       end;
function TiXYPlotChannel.GetOPCOffset2      : Double;  begin Result := FOPCItemManager.Items[1].Offset;       end;
function TiXYPlotChannel.GetOPCAutoConnect  : Boolean; begin Result := FOPCItemManager.Items[0].AutoConnect;  end;
function TiXYPlotChannel.GetOPCActive       : Boolean; begin Result := FOPCItemManager.Items[0].Active;       end;
function TiXYPlotChannel.GetOPCQualityGood  : Boolean; begin Result := FOPCItemManager.Items[0].QualityGood;  end;
{$endif}
//****************************************************************************************************************************************************
procedure TiXYPlotChannel.CalcStartXIndex;
begin
  StartIndex := 0;
end;
//****************************************************************************************************************************************************
procedure TiXYPlotChannel.CalcStopXIndex;
begin
  StopIndex := DataList.Count-1;
end;
//****************************************************************************************************************************************************
function TiXYPlotChannel.AddNull: Integer;
begin
  Result := DataList.Add(0, 0, True, False);

  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
function TiXYPlotChannel.AddEmpty: Integer;
begin
  Result := DataList.Add(0, 0, False, True);

  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiXYPlotChannel.DrawSetup;
begin
  CanDraw := False;

  if not Assigned(XAxis) then exit;
  if not Assigned(YAxis) then exit;
  if not Visible         then exit;
  if DataList.Count = 0  then exit;

  CalcStartXIndex;
  CalcStopXIndex;

  if StartIndex = - 1 then exit;
  if StopIndex  = - 1 then exit;

  CanDraw := True;
end;
//****************************************************************************************************************************************************
procedure TiXYPlotChannel.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
{$IFDEF iVCL}
var
  ARect : TRect;
{$ENDIF}
begin
  {$IFDEF iVCL}
  if ClipToAxes then
    begin
      if XYAxesReversed then ARect := iRect(YAxis.MinPixels, XAxis.MinPixels, YAxis.MaxPixels, XAxis.MaxPixels)
      else                   ARect := iRect(XAxis.MinPixels, YAxis.MinPixels, XAxis.MaxPixels, YAxis.MaxPixels);

      IntersectClipRect(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    end;
  {$ENDIF}

  DrawConnectPoints(Canvas, XYAxesReversed, BackGroundColor);
  DrawMarkers      (Canvas, XYAxesReversed, BackGroundColor);
end;
//****************************************************************************************************************************************************
function TiXYPlotChannel.GetVisibleMaxX: Double;
var
  x      : Integer;
  AValue : Double;
begin
  CalcStartXIndex;
  CalcStopXIndex;

  Result := -1E300;
  if not AxesValid   then Exit;
  if not Visible     then Exit;
  if StartIndex = -1 then Exit;
  if StopIndex  = -1 then Exit;

  for x := 0 to Count-1 do
    begin
      if DataEmpty[x] then Continue;
      if DataNull [x] then Continue;
      AValue := DataXDrawMax[x];
      if AValue > Result then Result := AValue;
    end;
end;
//****************************************************************************************************************************************************
function TiXYPlotChannel.GetVisibleMinX: Double;
var
  x      : Integer;
  AValue : Double;
begin
  CalcStartXIndex;
  CalcStopXIndex;

  Result := 1E300;
  if not AxesValid   then Exit;
  if not Visible     then Exit;
  if StartIndex = -1 then Exit;
  if StopIndex  = -1 then Exit;

  for x := 0 to Count-1 do
    begin
      if DataEmpty[x] then Continue;
      if DataNull [x] then Continue;
      AValue := DataXDrawMin[x];
      if AValue < Result then Result := AValue;
    end;
end;
//****************************************************************************************************************************************************
function TiXYPlotChannel.GetVisibleMaxY: Double;
var
  x      : Integer;
  AValue : Double;
begin
  CalcStartXIndex;
  CalcStopXIndex;

  Result := -1E300;
  if not AxesValid   then Exit;
  if not Visible     then Exit;
  if StartIndex = -1 then Exit;
  if StopIndex  = -1 then Exit;

  for x := 0 to Count-1 do
    begin
      if DataEmpty[x] then Continue;
      if DataNull [x] then Continue;
      AValue := DataYDrawMax[x];
      if AValue > Result then Result := AValue;
    end;
end;
//****************************************************************************************************************************************************
function TiXYPlotChannel.GetVisibleMinY: Double;
var
  x      : Integer;
  AValue : Double;
begin
  CalcStartXIndex;
  CalcStopXIndex;

  Result := 1E300;
  if not AxesValid   then Exit;
  if not Visible     then Exit;
  if StartIndex = -1 then Exit;
  if StopIndex  = -1 then Exit;

  for x := 0 to Count-1 do
    begin
      if DataEmpty[x] then Continue;
      if DataNull [x] then Continue;                             
      AValue := DataYDrawMin[x];
      if AValue < Result then Result := AValue;
    end;
end;
//****************************************************************************************************************************************************
procedure TiXYPlotChannel.DataCursorUpate(Sender: TObject);
var
  iDataCursor : TiPlotDataCursor;
  iDataView   : TiPlotDataView;
  X1Value     : Double;
  Y1Value     : Double;
  X2Value     : Double;
  Y2Value     : Double;
  XValue      : Double;
  YValue      : Double;
  Status      : TiPlotDataPointStatus;
begin
  iDataCursor := Sender as TiPlotDataCursor;

  Status := ipdpsValid;
  XValue := 0;
  YValue := 0;

  if Assigned(XAxis) and Assigned(YAxis) then
    begin
      X1Value := XAxis.PercentToPosition(iDataCursor.Pointer1Position/100);
      X2Value := XAxis.PercentToPosition(iDataCursor.Pointer2Position/100);

      Y1Value := YAxis.PercentToPosition(iDataCursor.Pointer1Position/100);
      Y2Value := YAxis.PercentToPosition(iDataCursor.Pointer2Position/100);

      iDataView := TiPlotDataCursorAccess(iDataCursor).DataView;
                                                                    
      if Assigned(iDataView) then
        begin
          if (XAxis.StartPercent <> 0) and (XAxis.StopPercent <> 100) then
            begin
              X1Value := XAxis.PixelsToPosition(iDataView.PositionPercentToPixelsX(iDataCursor.Pointer1Position));
              X2Value := XAxis.PixelsToPosition(iDataView.PositionPercentToPixelsX(iDataCursor.Pointer2Position));
            end;

          if (YAxis.StartPercent <> 0) and (YAxis.StopPercent <> 100) then
            begin
              Y1Value := YAxis.PixelsToPosition(iDataView.PositionPercentToPixelsY(iDataCursor.Pointer1Position));
              Y2Value := YAxis.PixelsToPosition(iDataView.PositionPercentToPixelsY(iDataCursor.Pointer2Position));
            end;
        end;

      case iDataCursor.Style of
        ipcsValueXY       : begin
                              XValue := X1Value;
                              YValue := Y2Value;
                            end;
        ipcsValueX        : begin                                 
                              XValue := X1Value;
                              YValue := 0;
                            end;
        ipcsValueY        : begin
                              XValue := 0;
                              YValue := Y2Value;
                            end;
        ipcsDeltaX        : begin
                              XValue := ABS(X1Value - X2Value);
                              YValue := 0;
                            end;
        ipcsDeltaY        : begin
                              XValue := 0;
                              YValue := ABS(Y1Value - Y2Value);
                            end;
        ipcsInverseDeltaX : begin
                              if ((X1Value - X2Value) <> 0) and (XAxis.CursorScaler <> 0) then
                                XValue := ABS(1/((X1Value - X2Value)*XAxis.CursorScaler))
                              else
                                XValue := 1E320;
                              YValue := 0;
                            end;
      end;
  end;

  TiPlotDataCursorAccess(iDataCursor).SetData(XValue, YValue, Status);
  TiPlotDataCursorAccess(iDataCursor).CursorDisplayText := GetDataCursorDisplayText(iDataCursor.Style, XValue, YValue, Status);
end;
//****************************************************************************************************************************************************
function TiXYPlotChannel.GetDataCursorDisplayText(Style: TiPlotDataCursorStyle; XValue, YValue: Double; Status: TiPlotDataPointStatus): String;
begin
  FDataCursorXText  := '';
  FDataCursorYText  := '';
  FDataCursorXValue := XValue;
  FDataCursorYValue := YValue;
  FDataCursorStatus := Status;

  if Assigned(XAxis) then
    begin
      case Style of
        ipcsValueXY       : begin
                              FDataCursorXText := GetXValueText(XValue);
                              if Assigned(YAxis) then
                                begin
                                  case Status of
                                    ipdpsValid : FDataCursorYText := GetYValueText(YValue);
                                    ipdpsNull  : FDataCursorYText := GetTranslation('Null');
                                    ipdpsEmpty : FDataCursorYText := GetTranslation('Empty');
                                  end;
                                end
                              else FDataCursorYText := 'No Y-Axis';

                              Result := FDataCursorXText + ', ' + FDataCursorYText;
                            end;
        ipcsValueX        : begin
                              FDataCursorXText := GetXValueText(XValue);
                              Result := FDataCursorXText;
                            end;
        ipcsValueY        : begin
                              if Assigned(YAxis) then
                                begin
                                  case Status of
                                    ipdpsValid : FDataCursorYText := GetYValueText(YValue);
                                    ipdpsNull  : FDataCursorYText := GetTranslation('Null');
                                    ipdpsEmpty : FDataCursorYText := GetTranslation('Empty');
                                  end;
                                end
                              else FDataCursorYText := 'No Y-Axis';

                              Result := FDataCursorYText;
                            end;
        ipcsDeltaX        : begin
                              FDataCursorXText := GetXValueText(XValue);
                              Result := FDataCursorXText;
                            end;
        ipcsDeltaY        : begin
                              if Assigned(YAxis) then
                                begin
                                  FDataCursorYText := GetYValueText(YValue);
                                end
                              else FDataCursorYText := 'No Y-Axis';

                              Result := FDataCursorYText;
                            end;
        ipcsInverseDeltaX : begin
                              if XValue < 1E301 then
                                FDataCursorXText := GetXValueText(XValue)
                              else
                                FDataCursorXText := GetTranslation('Infinite');
                              Result := FDataCursorXText;
                            end;
      end;
    end
  else
    begin
      FDataCursorXText := GetTranslation('No X-Axis');
      Result := FDataCursorXText;
    end;
end;
//****************************************************************************************************************************************************
end.
