{*******************************************************}
{                                                       }
{       TiLabel Component                               }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLabel;{$endif}
{$ifdef iCLX}unit QiLabel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiLabelBorderStyle = (ilbsNone, ilbsSingle, ilbsLowered, ilbsRaised);

  TiLabel = class(TiCustomComponent)
  private
    FAlignment         : TiAlignmentHorizontal;
    FFont              : TFont;
    FCaption           : String;
    FAutoSize          : Boolean;
    FOnAutoSize        : TNotifyEvent;
    FDoingAutoSize     : Boolean;
    FOuterMarginTop    : Integer;
    FOuterMarginLeft   : Integer;
    FOuterMarginRight  : Integer;
    FOuterMarginBottom : Integer;
    FWordWrap          : Boolean;
    FBorderStyle       : TiLabelBorderStyle;
    FShadowShow        : Boolean;
    FShadowXOffset     : Integer;
    FShadowYOffset     : Integer;
    FShawdowColor      : TColor;
    FFocusControl      : TWinControl;
  protected
    procedure SetAlignment        (const Value: TiAlignmentHorizontal);
    procedure SetFont             (const Value: TFont);
    procedure SetCaption          (const Value: String);
    procedure iSetAutoSize        (const Value: Boolean);
    procedure SetOuterMarginBottom(const Value: Integer);
    procedure SetOuterMarginLeft  (const Value: Integer);
    procedure SetOuterMarginRight (const Value: Integer);
    procedure SetOuterMarginTop   (const Value: Integer);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetBorderStyle      (const Value: TiLabelBorderStyle); reintroduce;
    procedure SetShadowShow       (const Value: Boolean);
    procedure SetShadowXOffset    (const Value: Integer);
    procedure SetShadowYOffset    (const Value: Integer);
    procedure SetShawdowColor     (const Value: TColor);

    procedure SetFocusControl(Value: TWinControl);

    {$ifdef iVCL}procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;{$ENDIF}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function  GetFlags        : TiTextFlags;
    function  GetBorderMargin : Integer;

    property  OnAutoSize       : TNotifyEvent          read FOnAutoSize       write FOnAutoSize;

    procedure DoAutoSize;
    procedure FontChange(Sender : TObject);
    procedure iPaintTo(Canvas: TCanvas);     override;
  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;
  published
    property AutoSize          : Boolean               read FAutoSize          write iSetAutoSize         default True;
    property Alignment         : TiAlignmentHorizontal read FAlignment         write SetAlignment         default iahLeft;
    property BorderStyle       : TiLabelBorderStyle    read FBorderStyle       write SetBorderStyle       default ilbsNone;
    property Caption           : String                read FCaption           write SetCaption;
    property Font              : TFont                 read FFont              write SetFont;
    property OuterMarginLeft   : Integer               read FOuterMarginLeft   write SetOuterMarginLeft   default 0;
    property OuterMarginTop    : Integer               read FOuterMarginTop    write SetOuterMarginTop    default 0;
    property OuterMarginRight  : Integer               read FOuterMarginRight  write SetOuterMarginRight  default 0;
    property OuterMarginBottom : Integer               read FOuterMarginBottom write SetOuterMarginBottom default 0;
    property ShadowShow        : Boolean               read FShadowShow        write SetShadowShow        default False;
    property ShadowXOffset     : Integer               read FShadowXOffset     write SetShadowXOffset     default 1;
    property ShadowYOffset     : Integer               read FShadowYOffset     write SetShadowYOffset     default 1;
    property ShadowColor       : TColor                read FShawdowColor      write SetShawdowColor      default clGray;
    property FocusControl      : TWinControl           read FFocusControl      write SetFocusControl;
    property WordWrap          : Boolean               read FWordWrap          write SetWordWrap;
    property BackGroundColor;
    property Transparent;
    property Width  default 28;
    property Height default 13;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width   := 28;
  Height  := 13;

  BackGroundColor := clBtnFace;
  TabStop         := False;

  FCaption         := 'iLabel';
  FAutoSize        := True;
  FAlignment       := iahLeft;

  FShadowXOffset   := 1;
  FShadowYOffset   := 1;
  FShawdowColor    := clGray;

  FFont            := TFont.Create;
  Font.OnChange    := FontChange;
end;
//****************************************************************************************************************************************************
destructor TiLabel.Destroy;
begin
  FFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetCaption(const Value: String);
var
  CanEdit : Boolean;
begin
  if FCaption <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Caption', CanEdit);
      if CanEdit then
        begin
          FCaption := Value;
          DoAutoSize;
          InvalidateChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetOuterMarginBottom(const Value: Integer);
begin
  if FOuterMarginBottom <> Value then
    begin
      FOuterMarginBottom := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetOuterMarginLeft(const Value: Integer);
begin
  if FOuterMarginLeft <> Value then
    begin
      FOuterMarginLeft := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetOuterMarginRight(const Value: Integer);
begin
  if FOuterMarginRight <> Value then
    begin
      FOuterMarginRight := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetOuterMarginTop(const Value: Integer);
begin
  if FOuterMarginTop <> Value then
    begin
      FOuterMarginTop := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
    begin
      FWordWrap := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetAlignment(const Value: TiAlignmentHorizontal);
begin
  if FAlignment <> Value then
    begin
      FAlignment := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetBorderStyle(const Value: TiLabelBorderStyle);
begin
  if FBorderStyle <> Value then
    begin
      FBorderStyle := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetShadowShow(const Value: Boolean);
begin
  if FShadowShow <> Value then
    begin
      FShadowShow := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetShadowXOffset(const Value: Integer);
begin
  if FShadowXOffset <> Value then
    begin
      FShadowXOffset := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetShadowYOffset(const Value: Integer);
begin
  if FShadowYOffset <> Value then
    begin
      FShadowYOffset := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetShawdowColor(const Value: TColor);
begin
  if FShawdowColor <> Value then
    begin
      FShawdowColor := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
function TiLabel.GetBorderMargin: Integer;
begin
  case FBorderStyle of
    ilbsSingle  : Result := 1;
    ilbsLowered : Result := 2;
    ilbsRaised  : Result := 2;
    else          Result := 0;
  end;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if (FFocusControl <> nil) and Enabled and IsAccel(Message.CharCode, Caption) then
    with FFocusControl do
      if CanFocus then
      begin
        SetFocus;
        Message.Result := 1;
      end;
end;
{$ENDIF}
//****************************************************************************************************************************************************
procedure TiLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then FFocusControl := nil;
end;
//****************************************************************************************************************************************************
procedure TiLabel.SetFocusControl(Value: TWinControl);
begin
  FFocusControl := Value;
  if Value <> nil then Value.FreeNotification(Self);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiLabel.GetFlags: TiTextFlags;
begin
  case FAlignment of
    iahCenter : Result := [itfHCenter, itfVCenter, itfSingleLine];
    iahLeft   : Result := [itfHLeft,   itfVCenter, itfSingleLine];
    else        Result := [itfHRight,  itfVCenter, itfSingleLine];
  end;

  if FWordWrap then Result := Result + [itfWordBreak] - [itfSingleLine];

  if Assigned(FFocusControl) then Result := Result + [itfShowPrefix];
end;
//****************************************************************************************************************************************************
procedure TiLabel.DoAutoSize;
var
  AShowXOffset    : Integer;
  AShowYOffset    : Integer;
  ARequiredWidth  : Integer;
  ARequiredHeight : Integer;
  ATextFlags      : TiTextFlags;
  ATextHeight     : Integer;
  ATextRect       : TRect;
begin
  if FDoingAutoSize              then Exit;
  if csLoading in ComponentState then Exit;

  if FAutoSize then
    begin
      FDoingAutoSize := True;
      try
        with Canvas do
          begin
            Font.Assign(FFont);

            if FShadowShow then
              begin
                AShowXOffset := ABS(FShadowXOffset);
                AShowYOffset := ABS(FShadowYOffset);
              end
            else
              begin
                AShowXOffset := 0;
                AShowYOffset := 0;
              end;

            if FWordWrap then
              begin
                ARequiredWidth := Width;

                ATextFlags      := GetFlags;
                ATextRect.Left  := Left;
                ATextRect.Right := Left + Width;

                ATextHeight := iDrawText(Canvas, FCaption, ATextRect, ATextFlags + [itfCalcRect], True, BackGroundColor);
                ARequiredHeight := 2*GetBorderMargin + FOuterMarginTop  + FOuterMarginBottom + ATextHeight + AShowYOffset;
              end
            else
              begin
                ARequiredWidth  := 2*GetBorderMargin + FOuterMarginLeft + FOuterMarginRight  + TextWidth (FCaption) + AShowXOffset;
                ARequiredHeight := 2*GetBorderMargin + FOuterMarginTop  + FOuterMarginBottom + TextHeight(FCaption) + AShowYOffset;
              end;

            Width  := ARequiredWidth;
            Height := ARequiredHeight;
          end;
        if Assigned(FOnAutoSize) then FOnAutoSize(Self);
      finally
        FDoingAutoSize := False;
      end;
    end;
end;                               
//****************************************************************************************************************************************************
procedure TiLabel.FontChange(Sender : TObject);
begin
  DoAutoSize;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiLabel.iPaintTo(Canvas: TCanvas);
var
  AText      : String;
  ARect      : TRect;
  ATextFlags : TiTextFlags;
begin
  with Canvas, ARect do
    begin
      DrawBackGround(Canvas, BackGroundColor);
      Font.Assign(FFont);

      Font.Size := FFont.Size;
      Brush.Style := bsClear;

      ARect  := Rect(FOuterMarginLeft + GetBorderMargin,
                     FOuterMarginTop  + GetBorderMargin,
                     Width            - GetBorderMargin - FOuterMarginRight,
                     Height           - GetBorderMargin - FOuterMarginBottom);


      ATextFlags := GetFlags;
      AText      := FCaption;

      if FShadowShow then
        begin
          Font.Color := FShawdowColor;

          if FShadowXOffset >= 0 then OffsetRect(ARect, FShadowXOffset, FShadowYOffset);
          iDrawText(Canvas, AText, ARect, ATextFlags, True, BackGroundColor);

          Font.Color := FFont.Color;

          OffsetRect(ARect, -FShadowXOffset, -FShadowYOffset);

          iDrawText(Canvas, AText, ARect, ATextFlags, True, BackGroundColor);
        end
      else iDrawText(Canvas, AText, ARect, ATextFlags, True, BackGroundColor);

      Pen.Color := clWindowFrame;

      ARect := Rect(0, 0, Width, Height);
      case FBorderStyle of
        ilbsSingle  : Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
        ilbsLowered : iDrawEdge(Canvas, ARect, idesSunken);
        ilbsRaised  : iDrawEdge(Canvas, ARect, idesRaised);
      end;
    end;
end;
//****************************************************************************************************************************************************
end.


