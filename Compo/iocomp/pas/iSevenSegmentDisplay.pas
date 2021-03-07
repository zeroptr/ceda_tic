{*******************************************************}
{                                                       }
{       TiSevenSegmentDisplay Component                 }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentDisplay;{$endif}
{$ifdef iCLX}unit QiSevenSegmentDisplay;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iSevenSegmentCharacter,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiSevenSegmentCharacter, QiCustomComponent;{$ENDIF}

type
  TiSevenSegmentDisplay = class(TiCustomComponent)
  private
    FSevenSegmentCharacter : TiSevenSegmentCharacter;

    FAutoSize            : Boolean;
    FDigitCount          : Integer;
    FDigitSpacing        : Integer;
    FLeadingStyle        : TiLeadingStyle;
    FSegmentMargin       : Integer;
    FSegmentColor        : TColor;
    FSegmentSeperation   : Integer;
    FSegmentSize         : Integer;
    FShowOffSegments     : Boolean;
    FPowerOff            : Boolean;

    FOnValueChange       : TNotifyEvent;
    FOnAutoSize          : TNotifyEvent;
    FAutoSegmentOffColor : Boolean;
    FSegmentOffColor     : TColor;

    procedure iSetAutoSize          (const Value: Boolean);
    procedure SetDigitCount         (const Value: Integer);
    procedure SetDigitSpacing       (const Value: Integer);
    procedure SetLeadingStyle       (const Value: TiLeadingStyle);
    procedure SetSegmentMargin      (const Value: Integer);
    procedure SetSegmentColor       (const Value: TColor);
    procedure SetSegmentSize        (const Value: Integer);
    procedure SetSegmentSeperation  (const Value: Integer);
    procedure SetShowOffSegments    (const Value: Boolean);
    procedure SetPowerOff           (const Value: Boolean);
    procedure SetAutoSegmentOffColor(const Value: Boolean);
    procedure SetSegmentOffColor    (const Value: TColor);
  protected
    procedure SetupCharacter;
    procedure DoAutoSize;
    function  GetAutoSize : TPoint; virtual; abstract;

    property  SevenSegmentCharacter : TiSevenSegmentCharacter read FSevenSegmentCharacter;
    property  DigitCount            : Integer                 read FDigitCount             write SetDigitCount           default 4;
    property  LeadingStyle          : TiLeadingStyle          read FLeadingStyle           write SetLeadingStyle         default ilsSpaces;
  public
    constructor Create(AOwner: TComponent);  override;
    property OnAutoSize             : TNotifyEvent            read FOnAutoSize             write FOnAutoSize;
  published
    property AutoSize               : Boolean                 read FAutoSize               write iSetAutoSize            default True;
    property DigitSpacing           : Integer                 read FDigitSpacing           write SetDigitSpacing         default 6;
    property SegmentMargin          : Integer                 read FSegmentMargin          write SetSegmentMargin        default 5;
    property SegmentColor           : TColor                  read FSegmentColor           write SetSegmentColor         default clWhite;
    property SegmentSeperation      : Integer                 read FSegmentSeperation      write SetSegmentSeperation    default 1;
    property SegmentSize            : Integer                 read FSegmentSize            write SetSegmentSize          default 1;
    property ShowOffSegments        : Boolean                 read FShowOffSegments        write SetShowOffSegments      default True;
    property PowerOff               : Boolean                 read FPowerOff               write SetPowerOff             default False;
    property SegmentOffColor        : TColor                  read FSegmentOffColor        write SetSegmentOffColor      default clGray;
    property AutoSegmentOffColor    : Boolean                 read FAutoSegmentOffColor    write SetAutoSegmentOffColor  default True;
    property OnValueChange          : TNotifyEvent            read FOnValueChange          write FOnValueChange;
    property BackGroundColor default clBlack;
    property BorderStyle;
    property Transparent;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiSevenSegmentDisplay.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 15;
  Height := 15;

  FAutoSize            := True;
  FDigitSpacing        := 6;
  FDigitCount          := 4;
  FLeadingStyle        := ilsSpaces;
  FSegmentMargin       := 5;
  FSegmentColor        := clWhite;
  FSegmentOffColor     := clGray;
  FAutoSegmentOffColor := True;
  FSegmentSize         := 1;
  FSegmentSeperation   := 1;
  FShowOffSegments     := True;

  BackGroundColor      := clBlack;

  FSevenSegmentCharacter               := TiSevenSegmentCharacter.Create(Self);
  FSevenSegmentCharacter.BeginUpdate;
  FSevenSegmentCharacter.SegmentMargin := 0;
  FSevenSegmentCharacter.AutoSize      := False;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetDigitCount(const Value: Integer);
begin
  if FDigitCount <> Value then
    begin
      FDigitCount := Value;
      if FDigitCount < 1  then FDigitCount := 1;
      if FDigitCount > 32 then FDigitCount := 32;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetDigitSpacing(const Value: Integer);
begin
  if FDigitSpacing <> Value then
    begin
      FDigitSpacing := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetSegmentColor(const Value: TColor);
begin
  if FSegmentColor <> Value then
    begin
      FSegmentColor := Value;
      FSevenSegmentCharacter.SegmentColor := FSegmentColor;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetAutoSegmentOffColor(const Value: Boolean);
begin
  if FAutoSegmentOffColor <> Value then
    begin
      FAutoSegmentOffColor := Value;
      FSevenSegmentCharacter.AutoSegmentOffColor := FAutoSegmentOffColor;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetSegmentOffColor(const Value: TColor);
begin
  if FSegmentOffColor <> Value then
    begin
      FSegmentOffColor := Value;
      FSevenSegmentCharacter.SegmentOffColor := FSegmentOffColor;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetSegmentSize(const Value: Integer);
begin
  if FSegmentSize <> Value then
    begin
      FSegmentSize := Value;
      if FSegmentSize < 1   then FSegmentSize := 1;
      if FSegmentSize > 100 then FSegmentSize := 100;
      FSevenSegmentCharacter.SegmentSize := FSegmentSize;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetSegmentSeperation(const Value: Integer);
begin
  if FSegmentSeperation <> Value then
    begin
      FSegmentSeperation := Value;
      if FSegmentSeperation < 0 then FSegmentSeperation := 0;
      FSevenSegmentCharacter.SegmentSeperation := FSegmentSeperation;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetSegmentMargin(const Value: Integer);
begin
  if FSegmentMargin <> Value then
    begin
      FSegmentMargin := Value;
      if FSegmentMargin < 0 then FSegmentMargin := 0;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetShowOffSegments(const Value: Boolean);
begin
  if FShowOffSegments <> Value then
    begin
      FShowOffSegments := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetLeadingStyle(const Value: TiLeadingStyle);
begin
  if FLeadingStyle <> Value then
    begin
      FLeadingStyle := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetPowerOff(const Value: Boolean);
begin
  if FPowerOff <> Value then
    begin
      FPowerOff := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.SetupCharacter;
begin
  FSevenSegmentCharacter.SegmentMargin       := 0;
  FSevenSegmentCharacter.SegmentColor        := FSegmentColor;
  FSevenSegmentCharacter.SegmentOffColor     := FSegmentOffColor;
  FSevenSegmentCharacter.AutoSegmentOffColor := FAutoSegmentOffColor;
  FSevenSegmentCharacter.SegmentSize         := FSegmentSize;
  FSevenSegmentCharacter.SegmentSeperation   := FSegmentSeperation;
  FSevenSegmentCharacter.ShowOffSegments     := FShowOffSegments;
  FSevenSegmentCharacter.PowerOff            := FPowerOff;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentDisplay.DoAutoSize;
var
  SizePoint : TPoint;
begin
  if not Loading then
    begin
      if AutoSize then
        begin
          SizePoint := GetAutoSize;
          Width     := SizePoint.X;
          Height    := SizePoint.Y;

          if Assigned(FOnAutoSize) then FOnAutoSize(Self);
        end;
    end;
end;
//****************************************************************************************************************************************************
end.
