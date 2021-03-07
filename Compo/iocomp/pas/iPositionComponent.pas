{*******************************************************}
{                                                       }
{       TiPositionComponent                             }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPositionComponent;{$endif}
{$ifdef iCLX}unit QiPositionComponent;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iClasses,  iGaugePointer,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiClasses, QiGaugePointer, QiCustomComponent;{$ENDIF}

type
  TiPositionComponent = class(TiCustomComponent)
  private
    FLimitList                : TStringList;
    FPosition                 : Double;
    FPositionMax              : Double;
    FPositionMin              : Double;
    FShowMaxPointer           : Boolean;
    FShowMinPointer           : Boolean;
    FMinMaxPointerMargin      : Integer;
    FMinMaxPointerSize        : Integer;
    FMinPointerColor          : TColor;
    FMaxPointerColor          : TColor;
    FOnPositionChange         : TNotifyEvent;
    FOnCurrentMaxChange       : TNotifyEvent;
    FOnCurrentMinChange       : TNotifyEvent;
    FOnPositionChangeFinished : TNotifyEvent;
    FOnPositionOverMax        : TNotifyEvent;
    FOnPositionUnderMin       : TNotifyEvent;
    FPositionDirty            : Boolean;
    FMinMaxFixed              : Boolean;
    FMinMaxUserCanMove        : Boolean;
    FOnPositionOverLimit      : TOnPositionLimit;
    FOnPositionUnderLimit     : TOnPositionLimit;
    FUserGenerated            : Boolean;
    FOnPositionChangeUser     : TNotifyEvent;

    FMinPointer               : TiGaugePointer;
    FMaxPointer               : TiGaugePointer;

    procedure SetShowMaxPointer         (const Value: Boolean);
    procedure SetShowMinPointer         (const Value: Boolean);
    procedure SetCurrentMax             (      Value: Double);
    procedure SetCurrentMin             (      Value: Double);
    procedure SetMinMaxPointerMargin    (const Value: Integer);
    procedure SetMinMaxPointerSize      (const Value: Integer);
    procedure SetMaxPointerColor        (const Value: TColor);
    procedure SetMinPointerColor        (const Value: TColor);
    procedure SetPositionPercent        (const Value: Double);
    procedure SetMinMaxFixed            (const Value: Boolean);
    procedure SetMinMaxUserCanMove      (const Value: Boolean);
    procedure SetLimitUpperValue        (Index: Integer; const Value: Double);
    procedure SetLimitLowerValue        (Index: Integer; const Value: Double);
    procedure SetLimitUpperPointerColor (Index: Integer; const Value: TColor);
    procedure SetLimitPointerMargin     (Index: Integer; const Value: Integer);
    procedure SetLimitPointerSize       (Index: Integer; const Value: Integer);
    procedure SetLimitShowUpperPointer  (Index: Integer; const Value: Boolean);
    procedure SetLimitDrawScaleSide     (Index: Integer; const Value: Boolean);
    function GetLimitLowerValue         (Index: Integer): Double;
    function GetLimitUpperPointerColor  (Index: Integer): TColor;
    function GetLimitPointerMargin      (Index: Integer): Integer;
    function GetLimitPointerSize        (Index: Integer): Integer;
    function GetLimitShowUpperPointer   (Index: Integer): Boolean;
    function GetLimitUpperValue         (Index: Integer): Double;
    function GetLimitDrawScaleSide      (Index: Integer): Boolean;
    function GetPositionPercent : Double;
    function GetLimitCount      : Integer;
    function GetCurrentMin      : Double;
    function GetCurrentMax      : Double;
    function GetLimitLowerPointerColor(Index: Integer): TColor;
    function GetLimitShowLowerPointer(Index: Integer): Boolean;
    procedure SetLimitLowerPointerColor(Index: Integer; const Value: TColor);
    procedure SetLimitShowLowerPointer(Index: Integer; const Value: Boolean);

    procedure SetMinMaxStyle3D(const Value: Boolean);
    function GetMinMaxStyle3D : Boolean;

  protected
    function GetPosition: Double;               virtual;
    procedure SetPosition(const Value: Double); virtual;

    function ValuePercent(Value : Double) : Double;

    procedure DefineProperties (Filer  : TFiler); override;
    procedure WritePositionMax2(Writer : TWriter);
    procedure ReadPositionMax2 (Reader : TReader);

    procedure DoPositionChange;
    procedure DoCurrentMaxChange;
    procedure DoCurrentMinChange;
    procedure DoPositionOverMax;
    procedure DoPositionUnderMin;
    procedure DoPositionChangeFinished;
    procedure DoOPCPositionChangeFinished; virtual;

    procedure DoPositionOverLimit(Index : Integer);
    procedure DoPositionUnderLimit(Index : Integer);

    procedure SetPositionMin(const Value : Double); virtual;
    procedure SetPositionMax(const Value : Double); virtual;
    procedure SetPositionMinMax(Min, Max : Double);
    procedure DoLimitBounds;       
    procedure DoPointerBounds;                      virtual;

    function  GetLimitObject(Index : Integer) : TiLimitObject;

    procedure UpdateMinMaxAndLimits(Value: Double);

    property MinPointer               : TiGaugePointer read FMinPointer;
    property MaxPointer               : TiGaugePointer read FMaxPointer;

    property UserGenerated            : Boolean        read FUserGenerated            write  FUserGenerated;

    property ShowMaxPointer           : Boolean        read FShowMaxPointer           write SetShowMaxPointer       default False;
    property ShowMinPointer           : Boolean        read FShowMinPointer           write SetShowMinPointer       default False;
    property MinMaxPointerSize        : Integer        read FMinMaxPointerSize        write SetMinMaxPointerSize    default 8;
    property MinMaxPointerMargin      : Integer        read FMinMaxPointerMargin      write SetMinMaxPointerMargin  default 0;
    property MaxPointerColor          : TColor         read FMaxPointerColor          write SetMaxPointerColor      default clAqua;
    property MinPointerColor          : TColor         read FMinPointerColor          write SetMinPointerColor      default clYellow;
    property PositionDirty            : Boolean        read FPositionDirty            write FPositionDirty;
    property MinMaxUserCanMove        : Boolean        read FMinMaxUserCanMove        write SetMinMaxUserCanMove    default False;
    property MinMaxStyle3D            : Boolean        read GetMinMaxStyle3D          write SetMinMaxStyle3D        default False;

    property OnPositionChangeFinished : TNotifyEvent   read FOnPositionChangeFinished write FOnPositionChangeFinished;
    property OnPositionChangeUser     : TNotifyEvent   read FOnPositionChangeUser     write FOnPositionChangeUser;
  public
    constructor Create(AOwner: TComponent);    override;
    destructor  Destroy;                       override;

    procedure   AddLimit(PointerSize, PointerMargin : Integer; DrawScaleSide : Boolean; UpperValue, LowerValue : Double; UpperPointerColor, LowerPointerColor : TColor);
    procedure   RemoveLimit(Index : Integer);
    procedure   RemoveAllLimits;
    property    LimitUpperValue       [Index : Integer] : Double  read GetLimitUpperValue        write SetLimitUpperValue;
    property    LimitLowerValue       [Index : Integer] : Double  read GetLimitLowerValue        write SetLimitLowerValue;
    property    LimitPointerSize      [Index : Integer] : Integer read GetLimitPointerSize       write SetLimitPointerSize;
    property    LimitPointerMargin    [Index : Integer] : Integer read GetLimitPointerMargin     write SetLimitPointerMargin;
    property    LimitUpperPointerColor[Index : Integer] : TColor  read GetLimitUpperPointerColor write SetLimitUpperPointerColor;
    property    LimitLowerPointerColor[Index : Integer] : TColor  read GetLimitLowerPointerColor write SetLimitLowerPointerColor;
    property    LimitShowUpperPointer [Index : Integer] : Boolean read GetLimitShowUpperPointer  write SetLimitShowUpperPointer;
    property    LimitShowLowerPointer [Index : Integer] : Boolean read GetLimitShowLowerPointer  write SetLimitShowLowerPointer;
    property    LimitDrawScaleSide    [Index : Integer] : Boolean read GetLimitDrawScaleSide     write SetLimitDrawScaleSide;
    property    LimitCount                              : Integer read GetLimitCount;

    procedure   SetPositionNoEvent(const Value : Double);
    procedure   ResetMinMax;
    property    PositionPercent      : Double           read GetPositionPercent       write SetPositionPercent;
  published
    property Position                : Double           read GetPosition              write SetPosition;
    property PositionMax             : Double           read FPositionMax             write SetPositionMax;
    property PositionMin             : Double           read FPositionMin             write SetPositionMin;

    property CurrentMax              : Double           read GetCurrentMax            write SetCurrentMax;
    property CurrentMin              : Double           read GetCurrentMin            write SetCurrentMin;
    property MinMaxFixed             : Boolean          read FMinMaxFixed             write SetMinMaxFixed       default False;

    property OnPositionChange        : TNotifyEvent     read FOnPositionChange        write FOnPositionChange;
    property OnCurrentMaxChange      : TNotifyEvent     read FOnCurrentMaxChange      write FOnCurrentMaxChange;
    property OnCurrentMinChange      : TNotifyEvent     read FOnCurrentMinChange      write FOnCurrentMinChange;
    property OnPositionOverMax       : TNotifyEvent     read FOnPositionOverMax       write FOnPositionOverMax;
    property OnPositionUnderMin      : TNotifyEvent     read FOnPositionUnderMin      write FOnPositionUnderMin;

    property OnPositionOverLimit     : TOnPositionLimit read FOnPositionOverLimit     write FOnPositionOverLimit;
    property OnPositionUnderLimit    : TOnPositionLimit read FOnPositionUnderLimit    write FOnPositionUnderLimit;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiPositionComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPositionMax       := 100;
  FPositionMin       := 0;
  FMaxPointerColor   := clAqua;
  FMinPointerColor   := clYellow;
  FMinMaxPointerSize := 8;

  FLimitList         := TStringList.Create;

  FMinPointer        := TiGaugePointer.Create(nil);
  FMaxPointer        := TiGaugePointer.Create(nil);
end;
//****************************************************************************************************************************************************
destructor TiPositionComponent.Destroy;
begin
  FMinPointer.Free;
  FMaxPointer.Free;

  FLimitList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.SetShowMaxPointer     (const Value:Boolean);begin SetBooleanProperty(Value,FShowMaxPointer     ,irtBackGround);end;
procedure TiPositionComponent.SetShowMinPointer     (const Value:Boolean);begin SetBooleanProperty(Value,FShowMinPointer     ,irtBackGround);end;
procedure TiPositionComponent.SetMinMaxPointerMargin(const Value:Integer);begin SetIntegerProperty(Value,FMinMaxPointerMargin,irtBackGround);end;
procedure TiPositionComponent.SetMinMaxPointerSize  (const Value:Integer);begin SetIntegerProperty(Value,FMinMaxPointerSize  ,irtBackGround);end;
procedure TiPositionComponent.SetMaxPointerColor    (const Value:TColor); begin SetColorProperty  (Value,FMaxPointerColor    ,irtInvalidate);end;
procedure TiPositionComponent.SetMinPointerColor    (const Value:TColor); begin SetColorProperty  (Value,FMinPointerColor    ,irtInvalidate);end;
procedure TiPositionComponent.SetMinMaxFixed        (const Value:Boolean);begin SetBooleanProperty(Value,FMinMaxFixed        ,irtInvalidate);end;
procedure TiPositionComponent.SetMinMaxUserCanMove  (const Value:Boolean);begin SetBooleanProperty(Value,FMinMaxUserCanMove  ,irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.SetMinMaxStyle3D(const Value:Boolean);begin FMinPointer.Style3D := Value; FMaxPointer.Style3D := Value; end;
function  TiPositionComponent.GetMinMaxStyle3D: Boolean;            begin Result := FMinPointer.Style3D                               end;
//****************************************************************************************************************************************************
function TiPositionComponent.GetLimitUpperValue       (Index:Integer):Double; begin Result:=GetLimitObject(Index).UpperValue;       end;
function TiPositionComponent.GetLimitLowerValue       (Index:Integer):Double; begin Result:=GetLimitObject(Index).LowerValue;       end;
function TiPositionComponent.GetLimitUpperPointerColor(Index:Integer):TColor; begin Result:=GetLimitObject(Index).UpperPointerColor;end;
function TiPositionComponent.GetLimitLowerPointerColor(Index:Integer):TColor; begin Result:=GetLimitObject(Index).LowerPointerColor;end;
function TiPositionComponent.GetLimitPointerMargin    (Index:Integer):Integer;begin Result:=GetLimitObject(Index).PointerMargin;    end;
function TiPositionComponent.GetLimitPointerSize      (Index:Integer):Integer;begin Result:=GetLimitObject(Index).PointerSize;      end;
function TiPositionComponent.GetLimitShowUpperPointer (Index:Integer):Boolean;begin Result:=GetLimitObject(Index).ShowUpperPointer; end;
function TiPositionComponent.GetLimitShowLowerPointer (Index:Integer):Boolean;begin Result:=GetLimitObject(Index).ShowLowerPointer; end;
function TiPositionComponent.GetLimitDrawScaleSide    (Index:Integer):Boolean;begin Result:=GetLimitObject(Index).DrawScaleSide;    end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.SetLimitUpperValue       (Index:Integer;const Value:Double); begin GetLimitObject(Index).UpperValue       := Value;BackGroundChange;end;
procedure TiPositionComponent.SetLimitLowerValue       (Index:Integer;const Value:Double); begin GetLimitObject(Index).LowerValue       := Value;BackGroundChange;end;
procedure TiPositionComponent.SetLimitPointerMargin    (Index:Integer;const Value:Integer);begin GetLimitObject(Index).PointerMargin    := Value;BackGroundChange;end;
procedure TiPositionComponent.SetLimitPointerSize      (Index:Integer;const Value:Integer);begin GetLimitObject(Index).PointerSize      := Value;BackGroundChange;end;
procedure TiPositionComponent.SetLimitUpperPointerColor(Index:Integer;const Value:TColor); begin GetLimitObject(Index).UpperPointerColor:= Value;BackGroundChange;end;
procedure TiPositionComponent.SetLimitLowerPointerColor(Index:Integer;const Value:TColor); begin GetLimitObject(Index).LowerPointerColor:= Value;BackGroundChange;end;
procedure TiPositionComponent.SetLimitShowUpperPointer (Index:Integer;const Value:Boolean);begin GetLimitObject(Index).ShowUpperPointer := Value;BackGroundChange;end;
procedure TiPositionComponent.SetLimitShowLowerPointer (Index:Integer;const Value:Boolean);begin GetLimitObject(Index).ShowLowerPointer := Value;BackGroundChange;end;
procedure TiPositionComponent.SetLimitDrawScaleSide    (Index:Integer;const Value:Boolean);begin GetLimitObject(Index).DrawScaleSide    := Value;BackGroundChange;end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.SetPositionNoEvent(const Value: Double);
var
  TempOnPositionChange : TNotifyEvent;
begin
  TempOnPositionChange := FOnPositionChange;
  FOnPositionChange    := nil;
  try
    SetPosition(Value);
  finally
    FOnPositionChange := TempOnPositionChange;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.SetPosition(const Value : Double);
var
  CanEdit   : Boolean;
  TempValue : Double;
begin
  if Loading then
    begin
      FPosition := Value;
      Exit;
    end;

  TempValue := Value;

  if TempValue > FPositionMax then TempValue := FPositionMax;
  if TempValue < FPositionMin then TempValue := FPositionMin;

  if FPosition <> TempValue then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Position', CanEdit);

      if CanEdit then
        begin
          FPosition      := TempValue;
          FPositionDirty := True;

          UpdateMinMaxAndLimits(Position);

          InvalidateChange;
          DoPositionChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.SetPositionMax(const Value: Double);
begin
  if FPositionMax <> Value then
    begin
      SetPositionMinMax(FPositionMin, Value);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.SetPositionMin(const Value: Double);
begin
  if FPositionMin <> Value then
    begin
      SetPositionMinMax(Value, FPositionMax);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.DoLimitBounds;
begin
  if not Loading then
    begin
      if not MinMaxFixed then
        begin
          if CurrentMin < PositionMin then CurrentMin := PositionMin;
          if CurrentMax > PositionMax then CurrentMax := PositionMax;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.DoPointerBounds;
begin
  if not Loading then
    begin
      if Position < PositionMin then Position := PositionMin;
      if Position > PositionMax then Position := PositionMax;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.SetPositionMinMax(Min, Max: Double);
begin
  if (FPositionMin <> Min) or (FPositionMax <> Max) then
    begin
      FPositionMin := Min;
      FPositionMax := Max;
      DoLimitBounds;
      DoPointerBounds;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.ResetMinMax;
begin
  CurrentMax := Position;
  CurrentMin := Position;
end;
//****************************************************************************************************************************************************
function TiPositionComponent.GetCurrentMin: Double;begin Result := FMinPointer.Position;end;
function TiPositionComponent.GetCurrentMax: Double;begin Result := FMaxPointer.Position;end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.SetCurrentMin(Value: Double);
begin
  if not Loading then
    begin
      if Value < FPositionMin then Value := FPositionMin;
      if Value > FPositionMax then Value := FPositionMax;
    end;

  if CurrentMin <> Value then
    begin
      FMinPointer.Position := Value;
      if ShowMinPointer then InvalidateChange;
      DoCurrentMinChange;
      if not Loading then if FPosition < CurrentMin then DoPositionUnderMin;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.SetCurrentMax(Value: Double);
begin
  if not Loading then
    begin
      if Value < FPositionMin then Value := FPositionMin;
      if Value > FPositionMax then Value := FPositionMax;
    end;

  if CurrentMax <> Value then
    begin
      FMaxPointer.Position := Value;
      if ShowMaxPointer then InvalidateChange;
      DoCurrentMaxChange;
      if not Loading then if FPosition > CurrentMax then DoPositionOverMax;
    end;
end;
//****************************************************************************************************************************************************
function TiPositionComponent.ValuePercent(Value : Double): Double;
begin
  if      Value       > FPositionMax then Result := 1
   else if Value       < FPositionMin then Result := 0
    else if FPositionMax = FPositionMin then Result := 0
     else                                     Result := (Value - FPositionMin)/(FPositionMax - FPositionMin);
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('PositionMax_2', ReadPositionMax2, WritePositionMax2, True);
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.ReadPositionMax2(Reader: TReader);
begin
  FPositionMax := Reader.ReadFloat;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.WritePositionMax2(Writer: TWriter);
begin
  Writer.WriteFloat(FPositionMax);
end;
//****************************************************************************************************************************************************
function TiPositionComponent.GetPositionPercent: Double;
begin
  Result := ValuePercent(FPosition);
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.SetPositionPercent(const Value: Double);
begin
  Position := Value*(FPositionMax- FPositionMin) + FPositionMin
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.DoCurrentMaxChange;                 begin if not Loading then if Assigned(FOnCurrentMaxChange)      then FOnCurrentMaxChange      (Self);      end;
procedure TiPositionComponent.DoCurrentMinChange;                 begin if not Loading then if Assigned(FOnCurrentMinChange)      then FOnCurrentMinChange      (Self);      end;
procedure TiPositionComponent.DoPositionOverMax;                  begin if not Loading then if Assigned(FOnPositionOverMax)       then FOnPositionOverMax       (Self);      end;
procedure TiPositionComponent.DoPositionUnderMin;                 begin if not Loading then if Assigned(FOnPositionUnderMin)      then FOnPositionUnderMin      (Self);      end;
procedure TiPositionComponent.DoPositionOverLimit (Index:Integer);begin if not Loading then if Assigned(FOnPositionOverLimit)     then FOnPositionOverLimit     (Self,Index);end;
procedure TiPositionComponent.DoPositionUnderLimit(Index:Integer);begin if not Loading then if Assigned(FOnPositionUnderLimit)    then FOnPositionUnderLimit    (Self,Index);end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.DoPositionChange;
begin
  if not Loading then
    begin
      if (not FUserGenerated) then                                         DoOPCPositionChangeFinished;
      if                              Assigned(OnChangeProtected)     then OnChangeProtected    (Self, 'Position');
      if                              Assigned(FOnPositionChange)     then FOnPositionChange    (Self);
      if (FUserGenerated)     then if Assigned(FOnPositionChangeUser) then FOnPositionChangeUser(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.DoPositionChangeFinished;
begin
  if not Loading then
    begin
      if PositionDirty then
        begin
          PositionDirty := False;
          DoOPCPositionChangeFinished;
          if Assigned(FOnPositionChangeFinished)then FOnPositionChangeFinished(Self);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.AddLimit(PointerSize, PointerMargin : Integer; DrawScaleSide : Boolean; UpperValue, LowerValue : Double; UpperPointerColor, LowerPointerColor : TColor);
var
  iLimitObject : TiLimitObject;
begin
  iLimitObject := TiLimitObject.Create;

  iLimitObject.UpperValue        := UpperValue;
  iLimitObject.LowerValue        := LowerValue;
  iLimitObject.ShowUpperPointer  := True;
  iLimitObject.ShowLowerPointer  := True;
  iLimitObject.UpperPointerColor := UpperPointerColor;
  iLimitObject.LowerPointerColor := LowerPointerColor;
  iLimitObject.PointerSize       := PointerSize;
  iLimitObject.PointerMargin     := PointerMargin;
  iLimitObject.DrawScaleSide     := DrawScaleSide;

  FLimitList.AddObject('', iLimitObject);
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.RemoveLimit(Index: Integer);
begin
  GetLimitObject(Index).Free;
  FLimitList.Delete(Index);
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.RemoveAllLimits;
begin
  while LimitCount > 0 do
    RemoveLimit(0);
end;
//****************************************************************************************************************************************************
function TiPositionComponent.GetLimitCount: Integer;
begin
  Result := FLimitList.Count
end;
//****************************************************************************************************************************************************
function TiPositionComponent.GetLimitObject(Index: Integer): TiLimitObject;
begin
  if (Index < 0) or (Index >(LimitCount -1)) then raise Exception.Create('Limit Index out of bounds');
  Result := FLimitList.Objects[Index] as TiLimitObject;
end;
//****************************************************************************************************************************************************
function TiPositionComponent.GetPosition: Double;
begin
  Result := FPosition;
end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.DoOPCPositionChangeFinished;
begin

end;
//****************************************************************************************************************************************************
procedure TiPositionComponent.UpdateMinMaxAndLimits(Value: Double);
var
  i : Integer;
begin
  if MinMaxFixed then Exit;
  if IsDesigning then Exit;

  if Value > CurrentMax then
    begin
      CurrentMax := Value;
      DoPositionOverMax;
    end;

  if Value < CurrentMin then
    begin
      CurrentMin := Value;
      DoPositionUnderMin;
    end;

  for i := 0 to FLimitList.Count - 1 do
    begin
      if Value > (FLimitList.Objects[i] as TiLimitObject).UpperValue then DoPositionOverLimit (i);
      if Value < (FLimitList.Objects[i] as TiLimitObject).LowerValue then DoPositionUnderLimit(i);
    end;
end;
//****************************************************************************************************************************************************
end.


