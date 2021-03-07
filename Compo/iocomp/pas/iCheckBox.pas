{*******************************************************}
{                                                       }
{       TiCheckBox Component                            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iCheckBox;{$endif}
{$ifdef iCLX}unit QiCheckBox;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent;{$ENDIF}

type
  TiCheckBox = class(TiCustomComponent)
  private
    FMouseDown     : Boolean;
    FKeyDown       : Boolean;
    FUserGenerated : Boolean;
    FDoingAutoSize : Boolean;
    
    FChecked       : Boolean;
    FCaption       : String;
    FAutoSize      : Boolean;
    FOnChange      : TNotifyEvent;
    FOnChangeUser  : TNotifyEvent;
    FFont          : TFont;
    FAlignment     : TLeftRight;
  protected
    procedure SetCaption  (const Value: String);
    procedure SetChecked  (const Value: Boolean);
    procedure SetFont     (const Value: TFont);
    procedure SetAlignment(const Value: TLeftRight);

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure iKeyUp  (var CharCode: Word; Shift: TShiftState);                    override;
    procedure iKeyDown(var CharCode: Word; Shift: TShiftState);                    override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  override;

    procedure iDoSetFocus;                                                         override;
    procedure iDoKillFocus;                                                        override;

    procedure iSetAutoSize   (const Value: Boolean);

    procedure FontChange(Sender: TObject);

    procedure DoChange; virtual;
    procedure DoAutoSize;

    procedure iPaintTo(Canvas: TCanvas); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;
  published
    property Width  default 97;
    property Height default 17;

    property Caption      : String       read FCaption       write SetCaption;
    property Checked      : Boolean      read FChecked       write SetChecked;
    property Alignment    : TLeftRight   read FAlignment     write SetAlignment  default taRightJustify;
    property AutoSize     : Boolean      read FAutoSize      write iSetAutoSize  default True;
    property Font         : TFont        read FFont          write SetFont;

    property OnChange     : TNotifyEvent read FOnChange      write FOnChange;
    property OnChangeUser : TNotifyEvent read FOnChangeUser  write FOnChangeUser;

    property BackGroundColor;
    property TabOrder;
    property TabStop              default True;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  TabStop := True;

  FCaption   := 'Caption';
  FAlignment := taRightJustify;
  FAutoSize  := True;
  Width      := 97;
  Height     := 17;

  FFont := TFont.Create;
  FFont.OnChange := FontChange;
end;
//****************************************************************************************************************************************************
destructor TiCheckBox.Destroy;
begin
  FFont.Free;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiCheckBox.DoChange;
begin
  if not Loading then
    begin
      if                        Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Checked');
      if                        Assigned(FOnChange)         then FOnChange        (Self);
      if FUserGenerated then if Assigned(FOnChangeUser)     then FOnChangeUser    (Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.SetCaption(const Value: String);
begin
  if FCaption <> Value then
    begin
      FCaption := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.SetAlignment(const Value: TLeftRight);
begin
  if FAlignment <> Value then
    begin
      FAlignment := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.SetChecked(const Value: Boolean);
var
  CanEdit     : Boolean;
  TempBoolean : Boolean;
begin
  if ord(Value) = 0 then TempBoolean := False else TempBoolean := True;
  if FChecked <> TempBoolean then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Checked', CanEdit);
      if CanEdit then
        begin
          FChecked := TempBoolean;
          InvalidateChange;
          DoChange;
          {$ifdef iVCL}OPCOutputData('Checked', FChecked);{$endif}
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.iPaintTo(Canvas: TCanvas);
var
  ABoxRect    : TRect;
  ATextRect   : TRect;
  ATextWidth  : Integer;
  ATextHeight : Integer;
  CenterY     : Integer;
begin
  DrawBackGround(Canvas, BackGroundColor);

  CenterY  := (Height) div 2;

  with Canvas do
    begin
      Font.Assign(FFont);
      Brush.Style := bsSolid;

      ATextWidth   := TextWidth (FCaption);
      ATextHeight  := TextHeight(FCaption);

      case FAlignment of
        taLeftJustify  : begin
                           ABoxRect  := Rect(Width -13,  CenterY  - 7,                   Width ,              CenterY + 6);
                           ATextRect := Rect(1, CenterY - ATextHeight div 2 -1, 1 + ATextWidth, CenterY + ATextHeight - ATextHeight div 2 -1);
                         end;
        taRightJustify : begin
                           ABoxRect  := Rect(0,  CenterY  - 7,                   13,              CenterY + 6);
                           ATextRect := Rect(18, CenterY - ATextHeight div 2 -1, 18 + ATextWidth, CenterY + ATextHeight - ATextHeight div 2 -1);
                         end;
      end;

      if FMouseDown or FKeyDown or (not Enabled) then
        Brush.Color := BackGroundColor
      else
        Brush.Color := clWhite;

      FillRect(ABoxRect);
      iDrawEdge(Canvas, ABoxRect, idesSunken);

      Brush.Style := bsClear;

      iDrawText(Canvas, FCaption, ATextRect, [itfHLeft, itfVCenter], Enabled, BackGroundColor);

      if Checked then
        begin
          Pen.Color := clBlack;
          Pen.Style := psSolid;
          Pen.Width := 1;
          PolyLine([Point(ABoxRect.Left + 3, CenterY -0), Point(ABoxRect.Left + 5, CenterY + 2), Point(ABoxRect.Left + 10, CenterY -3)]);
          PolyLine([Point(ABoxRect.Left + 3, CenterY -1), Point(ABoxRect.Left + 5, CenterY + 1), Point(ABoxRect.Left + 10, CenterY -4)]);
          PolyLine([Point(ABoxRect.Left + 3, CenterY -2), Point(ABoxRect.Left + 5, CenterY + 0), Point(ABoxRect.Left + 10, CenterY -5)]);
        end;

      if HasFocus then
        begin
          ATextRect.Left   := ATextRect.Left   - 1;
          ATextRect.Right  := ATextRect.Right  + 1;
          ATextRect.Top    := ATextRect.Top    - 1;
          ATextRect.Bottom := ATextRect.Bottom + 2;

          if ATextRect.Left   < 0          then ATextRect.Left    := 0;
          if ATextRect.Right  > (Width-1)  then ATextRect.Right   := Width-1;
          if ATextRect.Top    < 0          then ATextRect.Top     := 0;
          if ATextRect.Bottom > (Height-1) then ATextRect.Bottom  := Height-1;

          Font.Color  := clWhite;
          Brush.Color := clBlack;
          iDrawFocusRect2(Canvas, ATextRect);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.iDoKillFocus;
begin
  FMouseDown := False;
  FKeyDown   := False;
  InvalidateChange;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    begin
      FMouseDown := False;
      FKeyDown   := True;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    if FKeyDown then
      begin
        InvalidateChange;
        FUserGenerated := True;
        try                           
          Checked := not Checked;
        finally
          FUserGenerated := False;
        end;
      end;
  FKeyDown := False;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      iSetFocus(Self);
      FMouseDown := True;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      InvalidateChange;
      FMouseDown     := False;
      FUserGenerated := True;
      try
        if PtInRect(Rect(0, 0 ,Width, Height), Point(X,Y)) then Checked := not FChecked;
      finally
        FUserGenerated := False;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.iDoSetFocus;
begin
  inherited;
  InvalidateNow;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.DoAutoSize;
var
  {$IFDEF iVCL}
  ABitmap  : TBitmap;
  {$ENDIF}
  NewWidth : Integer;
begin
  if not FAutoSize               then Exit;
  if csLoading in ComponentState then Exit;
  if FDoingAutoSize              then Exit;

  FDoingAutoSize := True;
  try
  {$IFDEF iVCL}
    ABitmap := TBitmap.Create;
    try
      ABitmap.Handle;
      ABitmap.Canvas.Handle;
      ABitmap.Canvas.Font.Assign(FFont);
      NewWidth := 18 + ABitmap.Canvas.TextWidth(FCaption) + 2;
      case FAlignment of
        taRightJustify : Width := NewWidth;
        taLeftJustify  : if Width <> NewWidth then
                           begin
                             Left  := Left - (NewWidth - Width);
                             Width := NewWidth;
                           end;
      end;

      Height := ABitmap.Canvas.TextHeight(FCaption) + 4;
    finally
      ABitmap.Free;
    end;
  {$ENDIF}
  {$IFDEF iCLX}
      NewWidth := 18 + Canvas.TextWidth(FCaption) + 2;
      case FAlignment of
        taRightJustify : Width := NewWidth;
        taLeftJustify  : if Width <> NewWidth then
                           begin
                             Left  := Left - (NewWidth - Width);
                             Width := NewWidth;
                           end;
      end;

      Height := Canvas.TextHeight(FCaption) + 4;
  {$ENDIF}
  finally
    FDoingAutoSize := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.FontChange(Sender: TObject);
begin
  DoAutoSize;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;
//****************************************************************************************************************************************************
procedure TiCheckBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  //TODO Needs to be removed once the Read-Only properties are implemented
begin
  iMouseDown(Button, Shift, X, Y);
  inherited MouseDown(Button, Shift, X, Y);
end;
//****************************************************************************************************************************************************
end.
