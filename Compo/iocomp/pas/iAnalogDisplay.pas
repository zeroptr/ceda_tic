{*******************************************************}
{                                                       }
{       TiAnalogDisplay Component                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iAnalogDisplay;{$endif}
{$ifdef iCLX}unit QiAnalogDisplay;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiAnalogDisplay = class(TiCustomComponent)
  private
    FAlignment       : TiAlignmentHorizontal;
    FAlignmentMargin : Integer;
    FFont            : TFont;
    FPrecision       : Integer;
    FUnitsText       : String;
    FValue           : Double;
    FOnChange        : TNotifyEvent;
    procedure SetAlignment      (const Value: TiAlignmentHorizontal);
    procedure SetAlignmentMargin(const Value: Integer);
    procedure SetFont           (const Value: TFont);
    procedure SetPrecision      (const Value: Integer);
    procedure SetValue          (const Value: Double);
    procedure SetUnitsText      (const Value: String);
  protected
    procedure iPaintTo(Canvas: TCanvas);     override;
    procedure DoChange;
  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;
    procedure   SetValueNoEvent(const Value: Double);

  published
    property Alignment       : TiAlignmentHorizontal read FAlignment       write SetAlignment       default iahCenter;
    property AlignmentMargin : Integer               read FAlignmentMargin write SetAlignmentMargin default 5;
    property Precision       : Integer               read FPrecision       write SetPrecision       default 1;
    property Font            : TFont                 read FFont            write SetFont;
    property Value           : Double                read FValue           write SetValue;
    property UnitsText       : String                read FUnitsText       write SetUnitsText;
    property OnChange        : TNotifyEvent          read FOnChange        write FOnChange;
    property BackGroundColor                                                                        default clBlack;
    property BorderStyle                                                                            default ibsLowered;
    property Width                                                                                  default 80;
    property Height                                                                                 default 21;


    property ErrorActive;
    property ErrorText;
    property ErrorFont;
    property ErrorBackGroundColor;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiAnalogDisplay.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width           := 80;
  Height          := 21;
  BorderStyle     := ibsLowered;
  BackGroundColor := clBlack;

  FAlignmentMargin := 5;
  FPrecision       := 1;

  FFont            := TFont.Create;
  FFont.Style      := [fsBold];
  FFont.Color      := clAqua;
  Font.OnChange    := BackGroundChangeEvent;
end;
//****************************************************************************************************************************************************
destructor TiAnalogDisplay.Destroy;
begin
  FFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiAnalogDisplay.DoChange;
begin
  if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Value');
  if Assigned(FOnChange)         then FOnChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiAnalogDisplay.SetPrecision      (const Value: Integer);begin SetIntegerProperty(Value,FPrecision,      irtInvalidate);end;
procedure TiAnalogDisplay.SetAlignmentMargin(const Value: Integer);begin SetIntegerProperty(Value,FAlignmentMargin,irtInvalidate);end;
procedure TiAnalogDisplay.SetUnitsText      (const Value: String );begin SetStringProperty (Value,FUnitsText,      irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiAnalogDisplay.SetFont(const Value: TFont);begin FFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiAnalogDisplay.SetAlignment(const Value: TiAlignmentHorizontal);
begin
  if FAlignment <> Value then
    begin
      FAlignment := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAnalogDisplay.SetValueNoEvent(const Value: Double);
var
  TempOnValueChange : TNotifyEvent;
begin
  TempOnValueChange := FOnChange;
  FOnChange:= nil;
  try
    SetValue(Value);
  finally
    FOnChange := TempOnValueChange;
  end;
end;
//****************************************************************************************************************************************************
procedure TiAnalogDisplay.SetValue(const Value: Double);
var
  CanEdit : Boolean;
begin
  if FValue <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Value', CanEdit);
      if CanEdit then
        begin
          FValue := Value;
          InvalidateChange;
          DoChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiAnalogDisplay.iPaintTo(Canvas: TCanvas);
var
  AText      : String;
  ATextRect  : TRect;
  ATextFlags : TiTextFlags;
begin
  with Canvas, ATextRect do
    begin
      if not ErrorActive then
        begin
          if FPrecision >= 0 then
            AText := Trim(Format('%.' + IntToStr(FPrecision) + 'f', [FValue])) + FUnitsText
          else
            AText := Trim(Format('%g', [FValue])) + FUnitsText;

          Font.Assign(FFont);
          DrawBackGround(Canvas, BackGroundColor);
        end
      else
        begin
          AText := ErrorText;
          Font.Assign(ErrorFont);
          DrawBackGround(Canvas, ErrorBackGroundColor);
        end;

      case BorderStyle of
        ibsNone    : begin
                      ATextRect.Top    := 2;
                      ATextRect.Bottom := Height - 2;
                     end;
        ibsRaised  : begin
                      ATextRect.Top    := 2;
                      ATextRect.Bottom := Height - 2;
                     end;
        ibsLowered : begin
                      ATextRect.Top    := 2;
                      ATextRect.Bottom := Height - 4;
                     end;
      end;

      case FAlignment of
        iahCenter : begin
                      ATextFlags := [itfHCenter, itfVCenter, itfSingleLine];
                      ATextRect.Left  := 2;
                      ATextRect.Right := Width - 2;
                    end;
        iahLeft   : begin
                      ATextFlags := [itfHLeft, itfVCenter, itfSingleLine];
                      ATextRect.Left  := 2 + FAlignmentMargin;
                      ATextRect.Right := Width - 2;
                    end;
        else        begin
                      ATextFlags := [itfHRight, itfVCenter, itfSingleLine];
                      ATextRect.Left  := 2;
                      ATextRect.Right := Width - 2 - FAlignmentMargin;
                    end;
      end;

      Brush.Style := bsClear;
      iDrawText(Canvas, AText, ATextRect, ATextFlags, True, BackGroundColor);
    end;
end;
//****************************************************************************************************************************************************
end.


