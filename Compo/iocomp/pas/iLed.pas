{*******************************************************}
{                                                       }
{       TiLed Component                                 }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLed;{$endif}
{$ifdef iCLX}unit QiLed;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiLed = class(TiCustomComponent)
  private
    FActive            : Boolean;
    FBevelStyle        : TiBevelStyle;
    FActiveColor       : TColor;
    FOnChange          : TNotifyEvent;
    FAutoInactiveColor : Boolean;
    FInactiveColor     : TColor;
    procedure SetBevelStyle       (const Value: TiBevelStyle);
    procedure SetActiveColor      (const Value: TColor);
    procedure SetActive           (const Value: Boolean);
    procedure SetAutoInactiveColor(const Value: Boolean);
    procedure SetInactiveColor    (const Value: TColor);
  protected
    procedure DoChange;
  public
    constructor Create(AOwner: TComponent);  override;
    procedure   SetActiveNoEvent(const Value: Boolean);
  published
    property Active            : Boolean      read FActive            write SetActive            default False;
    property ActiveColor       : TColor       read FActiveColor       write SetActiveColor       default clLime;
    property AutoInactiveColor : Boolean      read FAutoInactiveColor write SetAutoInactiveColor default True;
    property InactiveColor     : TColor       read FInactiveColor     write SetInactiveColor     default $00005500;
    property BevelStyle        : TiBevelStyle read FBevelStyle        write SetBevelStyle        default ibsLowered;
    property OnChange          : TNotifyEvent read FOnChange          write FOnChange;

    property Width   default 20;
    property Height  default 20;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiLed.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 20;
  Height := 20;

  FActiveColor       := clLime;
  FAutoInactiveColor := True;
  FInactiveColor     := $00005500;
  FBevelStyle        := ibsLowered;
end;
//****************************************************************************************************************************************************
procedure TiLed.DoChange;
begin
  if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Active');
  if Assigned(FOnChange)         then FOnChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiLed.SetActiveColor(const Value: TColor);
begin
  if FActiveColor <> Value then
    begin
      FActiveColor := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLed.SetActiveNoEvent(const Value: Boolean);
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange := FOnChange;
  FOnChange    := nil;
  try
    SetActive(Value);
  finally
    FOnChange := TempOnChange;
  end;
end;
//****************************************************************************************************************************************************
procedure TiLed.SetActive(const Value : Boolean);
var
  CanEdit : Boolean;
begin
  if FActive <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Active', CanEdit);
      if CanEdit then
        begin
          FActive := Value;
          BackGroundChange;
          DoChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLed.SetAutoInactiveColor(const Value: Boolean);
begin
  if FAutoInactiveColor <> Value then
    begin
      FAutoInactiveColor := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLed.SetInactiveColor(const Value: TColor);
begin
  if FInactiveColor <> Value then
    begin
      FInactiveColor := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLed.SetBevelStyle(const Value: TiBevelStyle);
begin
  if FBevelStyle <> Value then
    begin
      FBevelStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
end.


