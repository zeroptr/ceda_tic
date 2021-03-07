{*******************************************************}
{                                                       }
{       TiPanel Component                               }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPanel;{$endif}
{$ifdef iCLX}unit QiPanel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iComponent,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiComponent, QiCustomComponent;{$ENDIF}

type
  TiPanel = class(TiCustomComponent)
  private
    FTitleText            : String;
    FTitleFont            : TFont;
    FTitleMarginLeft      : Integer;
    FTitleMarginTop       : Integer;
    FTitleBevelMarginTop  : Integer;
    FShowTitleBevel       : Boolean;
    FTitleBevelMarginEnds : Integer;
    FTitleAlignment       : TiAlignmentHorizontal;

    procedure SetTitleText           (const Value: String);
    procedure SetTitleMarginLeft     (const Value: Integer);
    procedure SetTitleBevelMarginTop (const Value: Integer);
    procedure SetShowTitleBevel      (const Value: Boolean);
    procedure SetTitleFont           (const Value: TFont);
    procedure SetTitleMarginTop      (const Value: Integer);
    procedure SetTitleBevelMarginEnds(const Value: Integer);
    procedure SetTitleAlignment(const Value: TiAlignmentHorizontal);
  protected
    procedure iPaintTo(Canvas: TCanvas);         override;
    procedure DefineProperties(Filer: TFiler);   override;
    procedure WriteTitleText  (Writer: TWriter);
    procedure ReadTitleText   (Reader: TReader);
  public
    constructor Create(AOwner: TComponent);      override;
    destructor  Destroy;                         override;
  published
    property TitleText            : String                read FTitleText            write SetTitleText;
    property TitleFont            : TFont                 read FTitleFont            write SetTitleFont;
    property TitleAlignment       : TiAlignmentHorizontal read FTitleAlignment       write SetTitleAlignment       default iahLeft;
    property TitleMarginLeft      : Integer               read FTitleMarginLeft      write SetTitleMarginLeft      default 5;
    property TitleMarginTop       : Integer               read FTitleMarginTop       write SetTitleMarginTop       default 5;
    property TitleBevelMarginTop  : Integer               read FTitleBevelMarginTop  write SetTitleBevelMarginTop  default 1;
    property TitleBevelMarginEnds : Integer               read FTitleBevelMarginEnds write SetTitleBevelMarginEnds default 5;
    property ShowTitleBevel       : Boolean               read FShowTitleBevel       write SetShowTitleBevel       default True;
    property BackGroundColor;
    property BorderStyle      default ibsRaised;
    property Width            default 150;
    property Height           default 150;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csOpaque, csReplicatable, csAcceptsControls];

  Width       := 150;
  Height      := 150;
  BorderStyle := ibsRaised;

  FTitleMarginLeft      := 5;
  FTitleMarginTop       := 5;
  FTitleAlignment       := iahLeft;
  FTitleBevelMarginTop  := 1;
  FTitleBevelMarginEnds := 5;

  FShowTitleBevel       := True;
  FTitleText            := 'Title';

  FTitleFont       := TFont.Create; FTitleFont.OnChange := BackGroundChangeEvent;
  FTitleFont.Style := [fsBold];
  FTitleFont.Color := clTeal;
end;
//****************************************************************************************************************************************************
destructor TiPanel.Destroy;
begin
  FTitleFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPanel.SetTitleBevelMarginTop (const Value:Integer);begin SetIntegerProperty(Value,FTitleBevelMarginTop, irtInvalidate);end;
procedure TiPanel.SetTitleBevelMarginEnds(const Value:Integer);begin SetIntegerProperty(Value,FTitleBevelMarginEnds,irtInvalidate);end;
procedure TiPanel.SetTitleMarginLeft     (const Value:Integer);begin SetIntegerProperty(Value,FTitleMarginLeft,     irtInvalidate);end;
procedure TiPanel.SetTitleMarginTop      (const Value:Integer);begin SetIntegerProperty(Value,FTitleMarginTop,      irtInvalidate);end;
procedure TiPanel.SetShowTitleBevel      (const Value:Boolean);begin SetBooleanProperty(Value,FShowTitleBevel,      irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiPanel.SetTitleFont(const Value:TFont);begin FTitleFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiPanel.SetTitleText(const Value: String);
var
  CanEdit : Boolean;
begin
  if FTitleText <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'TitleText', CanEdit);
      if CanEdit then
        begin
          FTitleText := Value;
          InvalidateChange;
          if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'TitleText');
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPanel.SetTitleAlignment(const Value: TiAlignmentHorizontal);
begin
  if FTitleAlignment <> Value then
    begin
      FTitleAlignment := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPanel.iPaintTo(Canvas: TCanvas);
var
  BevelTop   : Integer;
  ARect      : TRect;
  AHeight    : Integer;
  ATextFlags : TiTextFlags;
begin
  with Canvas do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      Font.Assign(FTitleFont);
      Brush.Style := bsClear;

      AHeight := TextHeight('A');

      case FTitleAlignment of
        iahLeft   : ATextFlags := [itfHLeft,   itfVCenter, itfSingleLine];
        iahCenter : ATextFlags := [itfHCenter, itfVCenter, itfSingleLine];
        else        ATextFlags := [itfHRight,  itfVCenter, itfSingleLine];
      end;

      ARect := Rect(FTitleMarginLeft, FTitleMarginTop, Width - FTitleMarginLeft, FTitleMarginTop + AHeight);

      iDrawText(Canvas, Trim(FTitleText), ARect, ATextFlags, True, BackGroundColor);

      BevelTop := ARect.Bottom + FTitleBevelMarginTop;

      if FShowTitleBevel then
        begin
          Pen.Color := clBtnShadow;
          PolyLine([Point(FTitleBevelMarginEnds, BevelTop), Point(Width - FTitleBevelMarginEnds, BevelTop)]);
          Pen.Color := clBtnHighlight;
          PolyLine([Point(FTitleBevelMarginEnds, BevelTop+1), Point(Width - FTitleBevelMarginEnds, BevelTop+1)]);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPanel.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('TitleText_2', ReadTitleText, WriteTitleText, True);
end;
//****************************************************************************************************************************************************
procedure TiPanel.ReadTitleText(Reader: TReader);
begin
    FTitleText := Reader.ReadString;
end;
//****************************************************************************************************************************************************
procedure TiPanel.WriteTitleText(Writer: TWriter);
begin
  Writer.WriteString(FTitleText);
end;
//****************************************************************************************************************************************************
end.


