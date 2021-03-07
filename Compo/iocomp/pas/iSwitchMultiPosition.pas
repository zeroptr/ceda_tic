{*******************************************************}
{                                                       }
{       TiSwitchMultiPosition Component                 }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchMultiPosition;{$endif}
{$ifdef iCLX}unit QiSwitchMultiPosition;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent;{$ENDIF}

type
  TiSwitchMultiPosition = class(TiCustomComponent)
  private
    FPosition                    : Integer;
    FPositionLabels              : String;
    FPositionLabelsList          : TStringList;
    FPositionLabelMargin         : Integer;
    FPositionLabelActiveFont     : TFont;
    FPositionLabelInactiveFont   : TFont;
    FShowPositionLabels          : Boolean;
    FShowPositionIndicators      : Boolean;
    FPositionIndicatorSize       : Integer;
    FPositionIndicatorMargin     : Integer;
    FPositionIndicatorColor      : TColor;
    FPositionIndicatorBevelStyle : TiBevelStyle;
    FKeyPageStepSize             : Integer;
    FKeyArrowStepSize            : Integer;
    FShowFocusRect               : Boolean;
    FOnPositionChange            : TNotifyEvent;
    FOnPositionChangeFinished    : TNotifyEvent;
    FPositionedChanged           : Boolean;
    FUserGenerated               : Boolean;
    FOnPositionChangeUser        : TNotifyEvent;
    FLastWheelTime               : TDateTime;

    function GetPositionLabel(Index: Integer): String;
    function GetPositionLabelCount           : Integer;

    procedure SetPosition                   (const Value: Integer);
    procedure SetPositionLabels             (const Value: String);
    procedure SetPositionLabelMargin        (const Value: Integer);
    procedure SetPositionLabelInactiveFont  (const Value: TFont);
    procedure SetShowPositionIndicators     (const Value: Boolean);
    procedure SetShowPositionLabels         (const Value: Boolean);
    procedure SetPositionIndicatorSize      (const Value: Integer);
    procedure SetPositionIndicatorMargin    (const Value: Integer);
    procedure SetPositionIndicatorColor     (const Value: TColor);
    procedure SetPositionLabelActiveFont    (const Value: TFont);
    procedure SetPositionIndicatorBevelStyle(const Value: TiBevelStyle);
    procedure SetKeyArrowStepSize           (const Value: Integer);
    procedure SetKeyPageStepSize            (const Value: Integer);
    procedure SetShowFocusRect              (const Value: Boolean);
    procedure SetPositionLabel              (Index: Integer; const Value: String);
  protected
    FMaxPositionCount : Integer;
    FMouseDown        : Boolean;
    FMaximumLabels    : Integer;
    FKeyDown          : Boolean;

    procedure UpdateLabelList;
    procedure DoPositionChange;
    procedure DoPositionChangeFinished;

    procedure iWantSpecialKey(var CharCode: Word; var Result: Longint); override;
    procedure iKeyUp         (var CharCode: Word; Shift: TShiftState);  override;
    procedure iKeyDown       (var CharCode: Word; Shift: TShiftState);  override;

    procedure iDoKillFocus; override;

    {$ifdef iVCL}function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint      ): Boolean; override;{$endif}
    {$ifdef iCLX}function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; const MousePos: TPoint): Boolean; override;{$endif}

    property UserGenerated               : Boolean           read FUserGenerated              write  FUserGenerated;
    property PositionLabelsList          : TStringList       read FPositionLabelsList;
    property PositionedChanged           : Boolean           read FPositionedChanged          write FPositionedChanged;
  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;
    procedure   SetPositionNoEvent(const Value : Integer);
    property    PositionLabel[Index : Integer] : String      read GetPositionLabel             write SetPositionLabel;
    property    PositionLabelCount             : Integer     read GetPositionLabelCount;
  published
    property Position                    : Integer           read FPosition                    write SetPosition                     default 0;
    property PositionLabels              : String            read FPositionLabels              write SetPositionLabels;
    property PositionLabelMargin         : Integer           read FPositionLabelMargin         write SetPositionLabelMargin          default 5;
    property PositionLabelInactiveFont   : TFont             read FPositionLabelInactiveFont   write SetPositionLabelInactiveFont;
    property PositionLabelActiveFont     : TFont             read FPositionLabelActiveFont     write SetPositionLabelActiveFont;
    property PositionIndicatorSize       : Integer           read FPositionIndicatorSize       write SetPositionIndicatorSize        default 3;
    property PositionIndicatorMargin     : Integer           read FPositionIndicatorMargin     write SetPositionIndicatorMargin      default 10;
    property PositionIndicatorColor      : TColor            read FPositionIndicatorColor      write SetPositionIndicatorColor       default clAqua;
    property ShowPositionIndicators      : Boolean           read FShowPositionIndicators      write SetShowPositionIndicators       default True;
    property ShowPositionLabels          : Boolean           read FShowPositionLabels          write SetShowPositionLabels           default True;
    property PositionIndicatorBevelStyle : TiBevelStyle      read FPositionIndicatorBevelStyle write SetPositionIndicatorBevelStyle  default ibsLowered;
    property ShowFocusRect               : Boolean           read FShowFocusRect               write SetShowFocusRect                default True;
    property KeyArrowStepSize            : Integer           read FKeyArrowStepSize            write SetKeyArrowStepSize             default 1;
    property KeyPageStepSize             : Integer           read FKeyPageStepSize             write SetKeyPageStepSize              default 2;
    property BackGroundColor;
    property TabOrder;
    property TabStop                                                                                                                 default True;
    property OnPositionChange            : TNotifyEvent      read FOnPositionChange            write FOnPositionChange;
    property OnPositionChangeFinished    : TNotifyEvent      read FOnPositionChangeFinished    write FOnPositionChangeFinished;
    property OnPositionChangeUser        : TNotifyEvent      read FOnPositionChangeUser        write FOnPositionChangeUser;
  end;

implementation
//*************************************************************************************************************************************
constructor TiSwitchMultiPosition.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPositionLabelMargin         := 5;
  FPositionIndicatorSize       := 3;
  FPositionIndicatorMargin     := 10;
  FPositionIndicatorColor      := clAqua;

  FPositionLabels              := 'Off, On';
  FShowFocusRect               := True;
  FShowPositionLabels          := True;
  FShowPositionIndicators      := True;
  FPositionIndicatorBevelStyle := ibsLowered;

  FKeyArrowStepSize            := 1;
  FKeyPageStepSize             := 2;

  FPositionLabelsList          := TStringList.Create;
  UpdateLabelList;

  FPositionLabelInactiveFont   := TFont.Create; FPositionLabelInactiveFont.OnChange := BackGroundChangeEvent;
  FPositionLabelActiveFont     := TFont.Create; FPositionLabelActiveFont.OnChange   := BackGroundChangeEvent;

  TabStop                      := True;
end;
//*************************************************************************************************************************************
destructor TiSwitchMultiPosition.Destroy;
begin
  FPositionLabelsList.Free;
  FPositionLabelInactiveFont.Free;
  FPositionLabelActiveFont.Free;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.DoPositionChange;
begin
  if not Loading then
    begin
      if                          Assigned(OnChangeProtected)     then OnChangeProtected    (Self, 'Position');
      if                          Assigned(FOnPositionChange)     then FOnPositionChange    (Self);
      if (FUserGenerated) then if Assigned(FOnPositionChangeUser) then FOnPositionChangeUser(Self);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.DoPositionChangeFinished;
begin
  if not Loading then
    begin
      if PositionedChanged then
        begin
          PositionedChanged := False;
          if Assigned(FOnPositionChangeFinished)then FOnPositionChangeFinished(Self);
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.SetPositionLabelMargin    (const Value:Integer);begin if FPositionLabelMargin    <>Value then begin FPositionLabelMargin    :=Value;BackGroundChange;end;end;
procedure TiSwitchMultiPosition.SetShowPositionIndicators (const Value:Boolean);begin if FShowPositionIndicators <>Value then begin FShowPositionIndicators :=Value;BackGroundChange;end;end;
procedure TiSwitchMultiPosition.SetShowPositionLabels     (const Value:Boolean);begin if FShowPositionLabels     <>Value then begin FShowPositionLabels     :=Value;BackGroundChange;end;end;
procedure TiSwitchMultiPosition.SetPositionIndicatorSize  (const Value:Integer);begin if FPositionIndicatorSize  <>Value then begin FPositionIndicatorSize  :=Value;BackGroundChange;end;end;
procedure TiSwitchMultiPosition.SetPositionIndicatorMargin(const Value:Integer);begin if FPositionIndicatorMargin<>Value then begin FPositionIndicatorMargin:=Value;BackGroundChange;end;end;
procedure TiSwitchMultiPosition.SetPositionIndicatorColor (const Value:TColor); begin if FPositionIndicatorColor <>Value then begin FPositionIndicatorColor :=Value;BackGroundChange;end;end;
procedure TiSwitchMultiPosition.SetKeyArrowStepSize       (const Value:Integer);begin if FKeyArrowStepSize       <>Value then begin FKeyArrowStepSize       :=Value;BackGroundChange;end;end;
procedure TiSwitchMultiPosition.SetKeyPageStepSize        (const Value:Integer);begin if FKeyPageStepSize        <>Value then begin FKeyPageStepSize        :=Value;BackGroundChange;end;end;
procedure TiSwitchMultiPosition.SetShowFocusRect          (const Value:Boolean);begin if FShowFocusRect          <>Value then begin FShowFocusRect          :=Value;BackGroundChange;end;end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.SetPositionLabelInactiveFont(const Value:TFont);begin FPositionLabelInactiveFont.Assign(Value); BackGroundChange;end;
procedure TiSwitchMultiPosition.SetPositionLabelActiveFont  (const Value:TFont);begin FPositionLabelActiveFont.Assign(Value);   BackGroundChange;end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.SetPositionNoEvent(const Value: Integer);
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
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.SetPosition(const Value: Integer);
var
  CanEdit : Boolean;
begin
  if FPosition <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Position', CanEdit);
      if CanEdit then
        begin
          FPosition          := Value;
          FPositionedChanged := True;
          if not Loading then
            begin
              if FPosition < 0 then FPosition := 0;
              if FPosition > (FPositionLabelsList.Count-1) then FPosition := FPositionLabelsList.Count-1;
            end;
          BackGroundChange;
          DoPositionChange;
          {$ifdef iVCL}OPCOutputData('Position', FPosition);{$endif}
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.SetPositionIndicatorBevelStyle(const Value: TiBevelStyle);
begin
  if FPositionIndicatorBevelStyle <> Value then
    begin
      FPositionIndicatorBevelStyle := Value;
      BackGroundChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.UpdateLabelList;
var
  TempString  : ShortString;
  BuildString : String;
  x           : Integer;
begin
  FPositionLabelsList.Clear;
  TempString := FPositionLabels;
  BuildString := '';
  for x := 1 to Length(TempString) do
    begin
      if TempString[x] <> ',' then BuildString := BuildString + TempString[x]
        else
          begin
            if Trim(BuildString) = '' then FPositionLabelsList.Add('???') else FPositionLabelsList.Add(Trim(BuildString));
            if FMaximumLabels <> 0 then if FPositionLabelsList.Count = FMaximumLabels then exit;
            BuildString := '';
          end;
    end;

  if Trim(BuildString) <> '' then FPositionLabelsList.Add(Trim(BuildString));

  if FPositionLabelsList.Count = 0 then FPosition := 0
  else if FPosition > (FPositionLabelsList.Count - 1) then FPosition := FPositionLabelsList.Count - 1;
end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.SetPositionLabels(const Value: String);
begin
  if Length(Value) > 255 then raise Exception.Create('Position Label String Must be < 256 Characters');

  if FPositionLabels <> Value then
    begin
      FPositionLabels := Value;
      UpdateLabelList;
      BackGroundChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.iWantSpecialKey(var CharCode: Word; var Result: Longint);
begin
  if CharCode in [VK_LEFT, VK_DOWN, VK_RIGHT, VK_UP] then Result := 1 else Result := 0;
end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  InvalidateChange;
  if FKeyDown then
    begin
      FKeyDown   := False;
      FMouseDown := False;
      if PositionedChanged then
        begin
          PositionedChanged := False;
          if Assigned(OnPositionChangeFinished) then OnPositionChangeFinished(Self)
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  FKeyDown      := True;
  FMouseDown    := False;
  UserGenerated := True;
  try
    //KYLIX TODO
    {$ifndef iCLX}
    if      (CharCode = VK_LEFT) or (CharCode = VK_DOWN) then
      begin
        Position := Position - FKeyArrowStepSize;
        CharCode := 0;
      end
    else if (CharCode = VK_RIGHT) or (CharCode = VK_UP) then
      begin
        Position := Position + FKeyArrowStepSize;
        CharCode := 0;
      end
    else if (CharCode = VK_PRIOR) then //PageUp
      begin
        Position := Position + FKeyPageStepSize;
        CharCode := 0;
      end
    else if (CharCode = VK_NEXT) then //PageDown
      begin
        Position := Position - FKeyPageStepSize;
        CharCode := 0;
      end
    else if (CharCode = VK_HOME) then
      begin
        Position := 0;
        CharCode := 0;
      end
    else if (CharCode = VK_END) then
      begin
        Position := FPositionLabelsList.Count-1;
        CharCode := 0;
      end;
    {$endif}
  finally
    UserGenerated := False;
  end;
  inherited;
end;
//*************************************************************************************************************************************
function TiSwitchMultiPosition.GetPositionLabel(Index: Integer): String;
begin
  if (Index > FPositionLabelsList.Count-1) or (Index < 0) then raise Exception.Create('Index out of Bounds');
  Result := FPositionLabelsList.Strings[Index];
end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.SetPositionLabel(Index: Integer; const Value: String);
begin
  if (Index > FPositionLabelsList.Count-1) or (Index < 0) then raise Exception.Create('Index out of Bounds');
  FPositionLabelsList.Strings[Index] := Value;
  BackGroundChange;
end;
//*************************************************************************************************************************************
function TiSwitchMultiPosition.GetPositionLabelCount: Integer;
begin
  Result := FPositionLabelsList.Count;
end;
//*************************************************************************************************************************************
procedure TiSwitchMultiPosition.iDoKillFocus;
begin
  inherited;
  FMouseDown := False;
  FKeyDown   := False;
end;
//*************************************************************************************************************************************
{$ifdef iVCL}function TiSwitchMultiPosition.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint      ): Boolean;{$endif}
{$ifdef iCLX}function TiSwitchMultiPosition.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; const MousePos: TPoint): Boolean;{$endif}
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);

  if (Now -FLastWheelTime)*24*60*60*1000 < 30 then Exit;
  FLastWheelTime := Now;

  Position := Position + WheelDelta div ABS(WheelDelta);
end;
//****************************************************************************************************************************************************
end.


