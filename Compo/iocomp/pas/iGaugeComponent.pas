{*******************************************************}
{                                                       }
{       TiGaugeComponent                                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iGaugeComponent;{$endif}
{$ifdef iCLX}unit QiGaugeComponent;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iScaleComponent,  iGaugePointer,  iPositionComponent, iOPCItem;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiScaleComponent, QiGaugePointer, QiPositionComponent;          {$ENDIF}

type
  TiGaugeComponent = class(TiScaleComponent)
  private
    FPointerManager           : TiGaugePointerManager;

    FSectionEnd1              : Double;
    FSectionEnd2              : Double;
    FSectionEnd3              : Double;
    FSectionEnd4              : Double;
    FSectionCount             : Integer;
    FSectionColor1            : TColor;
    FSectionColor2            : TColor;
    FSectionColor3            : TColor;
    FSectionColor4            : TColor;
    FSectionColor5            : TColor;
    FOnClickPointer           : TIndexObjectEvent;
    FOnPointerPositionChanged : TIndexObjectEvent;
  protected
    procedure SetSectionColor1(const Value: TColor);
    procedure SetSectionColor2(const Value: TColor);
    procedure SetSectionColor3(const Value: TColor);
    procedure SetSectionColor4(const Value: TColor);
    procedure SetSectionColor5(const Value: TColor);
    procedure SetSectionCount (const Value: Integer);
    procedure SetSectionEnd1  (const Value: Double);
    procedure SetSectionEnd2  (const Value: Double);
    procedure SetSectionEnd3  (const Value: Double);
    procedure SetSectionEnd4  (const Value: Double);

    function GetPosition: Double;                   override;
    procedure SetPosition(const Value: Double);     override;
    procedure DoPointerBounds;                      override;

    function GetPointers(Index: Integer): TiGaugePointer;
    function GetPointerCount: Integer;

    procedure DefineProperties(Filer : TFiler); override;

    procedure WriteSectionEnd1(Writer : TWriter);
    procedure WriteSectionEnd2(Writer : TWriter);
    procedure WriteSectionEnd3(Writer : TWriter);
    procedure WriteSectionEnd4(Writer : TWriter);

    procedure ReadSectionEnd1 (Reader : TReader);
    procedure ReadSectionEnd2 (Reader : TReader);
    procedure ReadSectionEnd3 (Reader : TReader);
    procedure ReadSectionEnd4 (Reader : TReader);

    property SectionColor1 : TColor  read FSectionColor1 write SetSectionColor1 default clGreen;
    property SectionColor2 : TColor  read FSectionColor2 write SetSectionColor2 default clYellow;
    property SectionColor3 : TColor  read FSectionColor3 write SetSectionColor3 default clRed;
    property SectionColor4 : TColor  read FSectionColor4 write SetSectionColor4 default clYellow;
    property SectionColor5 : TColor  read FSectionColor5 write SetSectionColor5 default clYellow;
    property SectionCount  : Integer read FSectionCount  write SetSectionCount  default 0;
    property SectionEnd1   : Double  read FSectionEnd1   write SetSectionEnd1;
    property SectionEnd2   : Double  read FSectionEnd2   write SetSectionEnd2;
    property SectionEnd3   : Double  read FSectionEnd3   write SetSectionEnd3;
    property SectionEnd4   : Double  read FSectionEnd4   write SetSectionEnd4;

    procedure InsertEvent         (Sender: Tobject);
    procedure RemoveEvent         (Sender: Tobject);
    procedure ChangeEvent         (Sender: Tobject);
    procedure PositionChangedEvent(Sender: TObject);

    property PointerManager : TiGaugePointerManager read FPointerManager;

    procedure InitializePointer(iGaugePointer : TiGaugePointer); virtual;
    {$ifdef iVCL}
    procedure UpdateOPCSpecialList;                                                  override;
    function  OPCNewDataSpecial(PropertyName: String; NewData: OleVariant): Boolean; override;
    {$endif}
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    function AddPointer: Integer;

    procedure RemoveAllPointers;
    procedure DeletePointer(Index: Integer);

    property PointerCount             : Integer        read GetPointerCount;
    property Pointers[Index: Integer] : TiGaugePointer read GetPointers;

    function GetPointersVisible (Index: Integer): Boolean;
    function GetPointersPosition(Index: Integer): Double;
    function GetPointersSize    (Index: Integer): Integer;
    function GetPointersColor   (Index: Integer): TColor;

    procedure SetPointersVisible (Index: Integer; Value: Boolean);
    procedure SetPointersPosition(Index: Integer; Value: Double);
    procedure SetPointersSize    (Index: Integer; Value: Integer);
    procedure SetPointersColor   (Index: Integer; Value: TColor);

    procedure SetPointersPositionNoEvent(const Index: Integer; const Value : Double);
  published
    property OnClickPointer          : TIndexObjectEvent read FOnClickPointer           write FOnClickPointer;
    property OnPointerPositionChanged: TIndexObjectEvent read FOnPointerPositionChanged write FOnPointerPositionChanged;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiGaugeComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FSectionColor1 := clGreen;
  FSectionColor2 := clYellow;
  FSectionColor3 := clRed;
  FSectionColor4 := clYellow;
  FSectionColor5 := clYellow;

  FSectionEnd1   := 50;
  FSectionEnd2   := 75;

  FPointerManager := TiGaugePointerManager.Create(ChangeEvent, InsertEvent, RemoveEvent, PositionChangedEvent);
  FPointerManager.Add;
end;
//****************************************************************************************************************************************************
destructor TiGaugeComponent.Destroy;
begin
  FPointerManager.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.SetSectionColor1(const Value: TColor);begin SetColorProperty  (Value,FSectionColor1,irtBackGround);end;
procedure TiGaugeComponent.SetSectionColor2(const Value: TColor);begin SetColorProperty  (Value,FSectionColor2,irtBackGround);end;
procedure TiGaugeComponent.SetSectionColor3(const Value: TColor);begin SetColorProperty  (Value,FSectionColor3,irtBackGround);end;
procedure TiGaugeComponent.SetSectionColor4(const Value: TColor);begin SetColorProperty  (Value,FSectionColor4,irtBackGround);end;
procedure TiGaugeComponent.SetSectionColor5(const Value: TColor);begin SetColorProperty  (Value,FSectionColor5,irtBackGround);end;
procedure TiGaugeComponent.SetSectionEnd1  (const Value: Double);begin SetDoubleProperty (Value,FSectionEnd1,  irtBackGround);end;
procedure TiGaugeComponent.SetSectionEnd2  (const Value: Double);begin SetDoubleProperty (Value,FSectionEnd2,  irtBackGround);end;
procedure TiGaugeComponent.SetSectionEnd3  (const Value: Double);begin SetDoubleProperty (Value,FSectionEnd3,  irtBackGround);end;
procedure TiGaugeComponent.SetSectionEnd4  (const Value: Double);begin SetDoubleProperty (Value,FSectionEnd4,  irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.SetSectionCount(const Value: Integer);
begin
  if FSectionCount <> Value then
    begin
      FSectionCount := Value;
      if FSectionCount < 0 then FSectionCount := 0;
      if FSectionCount > 5 then FSectionCount := 5;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('SectionEnd1_2', ReadSectionEnd1, WriteSectionEnd1, True);
  Filer.DefineProperty('SectionEnd2_2', ReadSectionEnd2, WriteSectionEnd2, True);
  Filer.DefineProperty('SectionEnd3_2', ReadSectionEnd3, WriteSectionEnd3, True);
  Filer.DefineProperty('SectionEnd4_2', ReadSectionEnd4, WriteSectionEnd4, True);

  Filer.DefineProperty('Pointers', FPointerManager.ReadFromStream, FPointerManager.WriteToStream, FPointerManager.DoWriteToStream);
end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.ReadSectionEnd1(Reader: TReader);begin FSectionEnd1 := Reader.ReadFloat;end;
procedure TiGaugeComponent.ReadSectionEnd2(Reader: TReader);begin FSectionEnd2 := Reader.ReadFloat;end;
procedure TiGaugeComponent.ReadSectionEnd3(Reader: TReader);begin FSectionEnd3 := Reader.ReadFloat;end;
procedure TiGaugeComponent.ReadSectionEnd4(Reader: TReader);begin FSectionEnd4 := Reader.ReadFloat;end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.WriteSectionEnd1(Writer: TWriter);begin Writer.WriteFloat(FSectionEnd1);end;
procedure TiGaugeComponent.WriteSectionEnd2(Writer: TWriter);begin Writer.WriteFloat(FSectionEnd2);end;
procedure TiGaugeComponent.WriteSectionEnd3(Writer: TWriter);begin Writer.WriteFloat(FSectionEnd3);end;
procedure TiGaugeComponent.WriteSectionEnd4(Writer: TWriter);begin Writer.WriteFloat(FSectionEnd4);end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.ChangeEvent(Sender: Tobject);
begin
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.PositionChangedEvent(Sender: TObject);
begin
  UpdateMinMaxAndLimits((Sender as TiGaugePointer).Position);

  if Assigned(FOnPointerPositionChanged) then FOnPointerPositionChanged(FPointerManager.IndexOfObject(Sender as TiGaugePointer));

  DoPositionChange;
end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.InsertEvent(Sender: Tobject);
begin
  if Sender is TiGaugePointer then InitializePointer(Sender as TiGaugePointer);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.RemoveEvent(Sender: Tobject);
begin
  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiGaugeComponent.GetPointers(Index: Integer): TiGaugePointer;
begin
  Result := FPointerManager.Items[Index];
end;
//****************************************************************************************************************************************************
function TiGaugeComponent.AddPointer: Integer;
begin
  Result := FPointerManager.Add;
end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.DeletePointer(Index: Integer);
begin
  if Index = 0 then raise Exception.Create('Pointer Index 0 can not be Deleted');
  FPointerManager.Delete(Index);
end;
//****************************************************************************************************************************************************
function TiGaugeComponent.GetPointerCount: Integer;
begin
  Result := FPointerManager.Count;
end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.RemoveAllPointers;
begin
  while FPointerManager.Count > 1 do
    FPointerManager.Delete(1);
end;
//****************************************************************************************************************************************************
function TiGaugeComponent.GetPointersVisible (Index: Integer): Boolean;begin Result := FPointerManager.Items[Index].Visible; end;
function TiGaugeComponent.GetPointersPosition(Index: Integer): Double; begin Result := FPointerManager.Items[Index].Position;end;
function TiGaugeComponent.GetPointersSize    (Index: Integer): Integer;begin Result := FPointerManager.Items[Index].Size;    end;
function TiGaugeComponent.GetPointersColor   (Index: Integer): TColor; begin Result := FPointerManager.Items[Index].Color;   end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.SetPointersVisible (Index: Integer; Value: Boolean);begin FPointerManager.Items[Index].Visible  := Value;end;
procedure TiGaugeComponent.SetPointersSize    (Index, Value: Integer         );begin FPointerManager.Items[Index].Size     := Value;end;
procedure TiGaugeComponent.SetPointersColor   (Index: Integer; Value: TColor );begin FPointerManager.Items[Index].Color    := Value;end;
//****************************************************************************************************************************************************
function TiGaugeComponent.GetPosition: Double;
begin
  Result := FPointerManager.Items[0].Position;
end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.SetPointersPosition(Index: Integer; Value: Double);
begin
  FPointerManager.Items[Index].Position := Value;

  if Value > CurrentMax then if not MinMaxFixed then CurrentMax := Value;
  if Value < CurrentMin then if not MinMaxFixed then CurrentMin := Value;

  if Value > CurrentMax then DoPositionOverMax;
  if Value < CurrentMin then DoPositionUnderMin;
end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.SetPosition(const Value: Double);
var
  TempValue : Double;
begin
  if Loading then
    begin
      FPointerManager.Items[0].Position := Value;
      Exit;
    end;

  TempValue := Value;

  if TempValue > PositionMax then TempValue := PositionMax;
  if TempValue < PositionMin then TempValue := PositionMin;

  if FPointerManager.Items[0].Position <> TempValue then
    begin
      FPointerManager.Items[0].Position := TempValue;

      UpdateMinMaxAndLimits(TempValue);

      DoPositionChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.DoPointerBounds;
var
  x : Integer;
begin
  for x := 0 to FPointerManager.Count - 1 do
    begin
      if FPointerManager.Items[x].Position < PositionMin then FPointerManager.Items[x].Position := PositionMin;
      if FPointerManager.Items[x].Position > PositionMax then FPointerManager.Items[x].Position := PositionMax;
    end;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiGaugeComponent.UpdateOPCSpecialList;
var
  x : Integer;
begin
  if not Assigned(OPCSpecialList) then Exit;
  OPCSpecialList.Clear;
  for x := 0 to PointerManager.Count-1 do
    OPCSpecialList.Add('Pointers(' + IntToStr(x) + ').Position');
end;
//****************************************************************************************************************************************************
function TiGaugeComponent.OPCNewDataSpecial(PropertyName: String; NewData: OleVariant): Boolean;
var
  x : Integer;
begin
  Result := inherited OPCNewDataSpecial(PropertyName, NewData);

  for x := 0 to PointerManager.Count-1 do
    if UpperCase('Pointers(' + IntToStr(x) + ').Position') = UpperCase(PropertyName) then
      begin
        Result := True;
        SetPointersPosition(x, NewData);
        DoPositionChange;
      end;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiGaugeComponent.InitializePointer(iGaugePointer: TiGaugePointer);
begin

end;
//****************************************************************************************************************************************************
procedure TiGaugeComponent.SetPointersPositionNoEvent(const Index: Integer; const Value : Double);
var
  TempOnPositionChange         : TNotifyEvent;
  TempOnPointerPositionChanged : TIndexObjectEvent;
begin
  TempOnPositionChange         := OnPositionChange;
  TempOnPointerPositionChanged := OnPointerPositionChanged;
  OnPositionChange             := nil;
  OnPointerPositionChanged     := nil;
  try
    SetPointersPosition(Index, Value);
  finally
    OnPositionChange         := TempOnPositionChange;
    OnPointerPositionChanged := TempOnPointerPositionChanged;
  end;
end;
//****************************************************************************************************************************************************
end.
