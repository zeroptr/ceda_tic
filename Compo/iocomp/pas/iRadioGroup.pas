{*******************************************************}
{                                                       }
{       TiRadioGroup Component                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iRadioGroup;{$endif}
{$ifdef iCLX}unit QiRadioGroup;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent;{$ENDIF}

type
  TiRadioGroup = class(TiCustomComponent)
  private
    FMouseDown       : Boolean;
    FMouseDownIndex  : Integer;
    FKeyDown         : Boolean;
    FUserGenerated   : Boolean;

    FItemsRowStart   : Integer;
    FItemsRowSpacing : Double;
    FItemsColStart   : Integer;
    FItemsColSpacing : Double;
    FMaxRows         : Integer;

    FCaption         : String;
    FOnChange        : TNotifyEvent;
    FOnChangeUser    : TNotifyEvent;
    FFont            : TFont;
    FItems           : TStrings;
    FItemIndex       : Integer;
    FColumns         : Integer;
  protected
    procedure SetCaption  (const Value: String);
    procedure SetFont     (const Value: TFont);
    procedure SetItems    (const Value: TStrings);
    procedure SetItemIndex(const Value: Integer);
    procedure SetColumns  (const Value: Integer);

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    procedure iKeyUp  (var CharCode: Word; Shift: TShiftState);                    override;
    procedure iKeyDown(var CharCode: Word; Shift: TShiftState);                    override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  override;

    procedure iWantSpecialKey(var CharCode: Word; var Result: Integer);            override;

    procedure iDoSetFocus;                                                         override;
    procedure iDoKillFocus;                                                        override;

    procedure SubObjectChange(Sender: TObject);

    function GetMouseItemIndex(X, Y: Integer): Integer;

    procedure DoChange; virtual;

    procedure iPaintTo(Canvas: TCanvas);    override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;
  published
    property Width  default 97;
    property Height default 17;

    property Caption      : String       read FCaption       write SetCaption;
    property Font         : TFont        read FFont          write SetFont;

    property Items        : TStrings     read FItems         write SetItems;
    property ItemIndex    : Integer      read FItemIndex     write SetItemIndex;

    property Columns      : Integer      read FColumns       write SetColumns     default 1;

    property OnChange     : TNotifyEvent read FOnChange      write FOnChange;
    property OnChangeUser : TNotifyEvent read FOnChangeUser  write FOnChangeUser;

    property BackGroundColor;
    property TabOrder;
    property TabStop              default True;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  TabStop := True;

  FCaption   := 'Radio Group';
  Width      := 97;
  Height     := 17;

  FColumns   := 1;

  FFont := TFont.Create;
  FFont.OnChange := SubObjectChange;

  FItems := TStringList.Create;
  (FItems as TStringList).OnChange := SubObjectChange;
end;
//****************************************************************************************************************************************************
destructor TiRadioGroup.Destroy;
begin
  FFont.Free;
  FItems.Free;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiRadioGroup.DoChange;
begin
  if not Loading then
    begin
      if                        Assigned(OnChangeProtected) then OnChangeProtected(Self, 'ItemIndex');
      if                        Assigned(FOnChange)         then FOnChange        (Self);
      if FUserGenerated then if Assigned(FOnChangeUser)     then FOnChangeUser    (Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.SetCaption(const Value: String);
begin
  if FCaption <> Value then
    begin
      FCaption := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.iPaintTo(Canvas: TCanvas);
var
  x           : Integer;
  ABoxRect    : TRect;
  ATextRect   : TRect;
  AText       : String;
  TitleHeight : Integer;
  TitleLeft   : Integer;
  BoxTop      : Integer;
  ItemCenterX : Integer;
  ItemCenterY : Integer;
  ShowFocus   : Boolean;
begin
  DrawBackGround(Canvas, BackGroundColor);

  with Canvas do
    begin
      Font.Assign(FFont);
      Brush.Style := bsSolid;

      TitleLeft    := TextWidth ('A');
      TitleHeight  := TextHeight('ABC');
      BoxTop       := TitleHeight div 2;

      Brush.Color := BackGroundColor;
      FillRect(ABoxRect);

      iDrawEdge(Canvas, ABoxRect, idesSunken);
                                                                            
      Pen.Color := clBtnHighlight;
      PolyLine([Point(1,       BoxTop+1), Point(Width-2, BoxTop+1)]);
      PolyLine([Point(1,       BoxTop+1), Point(1,       Height-1)]);

      Pen.Color := clBtnShadow;
      PolyLine([Point(0, BoxTop), Point(Width-2, BoxTop), Point(Width-2, Height-2), Point(0, Height-2), Point(0, BoxTop)]);

      Pen.Color := clBtnHighlight;
      //PolyLine([Point(1,       BoxTop+1), Point(Width-2, BoxTop+1)]);
      PolyLine([Point(Width-1, BoxTop+1), Point(Width-1, Height-1)]);
      PolyLine([Point(Width-1, Height-1), Point(0,       Height-1)]);

      Brush.Color := BackGroundColor;
      Brush.Style := bsSolid;

      ATextRect := Rect(TitleLeft, 0, TitleLeft + TextWidth(FCaption), TextHeight(FCaption));
      FillRect(ATextRect);
      iDrawText(Canvas, FCaption, ATextRect, [itfHLeft, itfVCenter], Enabled, BackGroundColor);

      if FItems.Count > 0 then
        begin
          FMaxRows          := (FItems.Count div FColumns) + 1*ord((FItems.Count mod FColumns) <> 0);
          FItemsRowSpacing := (Height - TitleHeight - TitleHeight div 4) div FMaxRows;
          FItemsRowStart   :=  Round(TitleHeight + FItemsRowSpacing/2);

          FItemsColStart   := 14;
          FItemsColSpacing := (Width - 14) div FColumns;

          for x := 0 to FItems.Count-1 do
            begin
              ItemCenterY := FItemsRowStart + Round((x mod FMaxRows)*FItemsRowSpacing);
              ItemCenterX := FItemsColStart + Round((x div FMaxRows)*FItemsColSpacing);
              AText       := FItems.Strings[x];

              Brush.Style := bsSolid;
              Pen.Style   := psSolid;

              if (FMouseDown or FKeyDown) and (x = FMouseDownIndex) then
                begin
                  Brush.Color := clBtnFace;
                  Pen.Color   := clBtnFace;
                end
              else
                begin
                  Brush.Color := clWhite;
                  Pen.Color   := clWhite;
                end;

              Rectangle(ItemCenterX - 3, ItemCenterY - 4, ItemCenterX + 5, ItemCenterY + 4);

              Pen.Color := cl3DDkShadow;
              PolyLine([Point(ItemCenterX-4, ItemCenterY-2), Point(ItemCenterX-4, ItemCenterY+2)]);
              PolyLine([Point(ItemCenterX-3, ItemCenterY+2), Point(ItemCenterX-3, ItemCenterY+3)]);
              PolyLine([Point(ItemCenterX-3, ItemCenterY-3), Point(ItemCenterX-3, ItemCenterY-5)]);
              PolyLine([Point(ItemCenterX-3, ItemCenterY-4), Point(ItemCenterX-1, ItemCenterY-4)]);
              PolyLine([Point(ItemCenterX-1, ItemCenterY-5), Point(ItemCenterX+3, ItemCenterY-5)]);
              PolyLine([Point(ItemCenterX+3, ItemCenterY-4), Point(ItemCenterX+5, ItemCenterY-4)]);

              Pen.Color := clBtnShadow;
              PolyLine([Point(ItemCenterX-5, ItemCenterY-2), Point(ItemCenterX-5, ItemCenterY+2)]);
              PolyLine([Point(ItemCenterX-4, ItemCenterY+2), Point(ItemCenterX-4, ItemCenterY+4)]);
              PolyLine([Point(ItemCenterX-4, ItemCenterY-3), Point(ItemCenterX-4, ItemCenterY-5)]);
              PolyLine([Point(ItemCenterX-3, ItemCenterY-5), Point(ItemCenterX-1, ItemCenterY-5)]);
              PolyLine([Point(ItemCenterX-1, ItemCenterY-6), Point(ItemCenterX+3, ItemCenterY-6)]);
              PolyLine([Point(ItemCenterX+3, ItemCenterY-5), Point(ItemCenterX+5, ItemCenterY-5)]);

              Pen.Color := clBtnFace;
              PolyLine([Point(ItemCenterX+6, ItemCenterY-3), Point(ItemCenterX+6, ItemCenterY-5)]);
              PolyLine([Point(ItemCenterX+6, ItemCenterY+2), Point(ItemCenterX+6, ItemCenterY+6)]);
              PolyLine([Point(ItemCenterX+5, ItemCenterY-2), Point(ItemCenterX+5, ItemCenterY+2)]);
              PolyLine([Point(ItemCenterX+4, ItemCenterY-3), Point(ItemCenterX+4, ItemCenterY-2)]);
              PolyLine([Point(ItemCenterX+4, ItemCenterY+2), Point(ItemCenterX+4, ItemCenterY+4)]);
              PolyLine([Point(ItemCenterX+5, ItemCenterY+4), Point(ItemCenterX+5, ItemCenterY+6)]);
              PolyLine([Point(ItemCenterX-5, ItemCenterY+5), Point(ItemCenterX-1, ItemCenterY+5)]);
              PolyLine([Point(ItemCenterX+3, ItemCenterY+5), Point(ItemCenterX+5, ItemCenterY+5)]);
              PolyLine([Point(ItemCenterX-1, ItemCenterY+4), Point(ItemCenterX+3, ItemCenterY+4)]);
              PolyLine([Point(ItemCenterX+3, ItemCenterY+3), Point(ItemCenterX+4, ItemCenterY+3)]);
              PolyLine([Point(ItemCenterX-3, ItemCenterY+3), Point(ItemCenterX-1, ItemCenterY+3)]);

              Pen.Color := clBtnHighlight;
              PolyLine([Point(ItemCenterX+5, ItemCenterY-3), Point(ItemCenterX+5, ItemCenterY-5)]);
              PolyLine([Point(ItemCenterX+6, ItemCenterY-2), Point(ItemCenterX+6, ItemCenterY+2)]);
              PolyLine([Point(ItemCenterX+5, ItemCenterY+2), Point(ItemCenterX+5, ItemCenterY+4)]);
              PolyLine([Point(ItemCenterX+3, ItemCenterY+4), Point(ItemCenterX+5, ItemCenterY+4)]);
              PolyLine([Point(ItemCenterX-1, ItemCenterY+5), Point(ItemCenterX+3, ItemCenterY+5)]);
              PolyLine([Point(ItemCenterX-3, ItemCenterY+4), Point(ItemCenterX-1, ItemCenterY+4)]);

              Brush.Style := bsClear;
              Font.Color := FFont.Color;
              ATextRect := Rect(ItemCenterX + 12,                    ItemCenterY - TextHeight(AText) div 2,
                                ItemCenterX + 12 + TextWidth(AText), ItemCenterY + TextHeight(AText) div 2);
              iDrawText(Canvas, AText, ATextRect, [itfHLeft, itfVCenter, itfNoClip], Enabled, BackGroundColor);

              if (x = FItemIndex) then
                begin
                  Brush.Color := clBlack;
                  Brush.Style := bsSolid;
                  Pen.Color   := clBlack;
                  Pen.Style   := psSolid;

                  Ellipse(ItemCenterX - 1, ItemCenterY-2, ItemCenterX + 3, ItemCenterY+2);
                end;

              if HasFocus then
                begin
                  ShowFocus := False;
                  if (FMouseDown) and (x = FMouseDownIndex) then ShowFocus := True;
                  if (x = FItemIndex) and (not FMouseDown) then ShowFocus := True;
                  if ShowFocus then
                    begin
                      ATextRect.Left   := ATextRect.Left   - 1;
                      ATextRect.Right  := ATextRect.Right  + 1;
                      ATextRect.Top    := ATextRect.Top    - 1;
                      ATextRect.Bottom := ATextRect.Bottom + 3;

                      Font.Color  := clWhite;
                      Brush.Color := clBlack;
                      iDrawFocusRect2(Canvas, ATextRect);
                    end
                end;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiRadioGroup.GetMouseItemIndex(X, Y: Integer): Integer;
var
  Col : Integer;
  Row : Integer;
begin
  if FColumns = 1 then
    begin
      Result := Round((Y - FItemsRowStart)/ FItemsRowSpacing);
    end
  else
    begin
      Col := Trunc((X - FItemsColStart + 6)/ FItemsColSpacing);
      Row := Round((Y - FItemsRowStart)/ FItemsRowSpacing);
      Result := Col*FMaxRows + Row;
    end;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.iDoKillFocus;
begin
  FMouseDown := False;
  FKeyDown   := False;
  InvalidateChange;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiRadioGroup.iWantSpecialKey(var CharCode: Word; var Result: Longint);
begin
  Result := 0;
 if CharCode in [VK_LEFT, VK_DOWN, VK_RIGHT, VK_UP] then Result := 1;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  FKeyDown := True;
  if      CharCode in [VK_DOWN, VK_RIGHT] then
    begin
      CharCode := 0;
      if ItemIndex = Items.Count-1 then ItemIndex := 0
        else                            ItemIndex := ItemIndex +1;
    end
  else if CharCode in [VK_UP, VK_LEFT]    then
    begin
      CharCode := 0;
      if ItemIndex = 0 then ItemIndex := Items.Count-1
        else                ItemIndex := ItemIndex  -1;
    end;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  if CharCode = 32 then
    if FKeyDown then
      begin
        InvalidateChange;
        FUserGenerated := True;
        try                           

        finally
          FUserGenerated := False;
        end;
      end;
  FKeyDown := False;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      iSetFocus(Self);
      FMouseDown := True;
      FMouseDownIndex := GetMouseItemIndex(X, Y);
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.iMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FmouseDown then
    begin
      FMouseDownIndex := GetMouseItemIndex(X, Y);
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      InvalidateChange;
      FMouseDown     := False;
      FUserGenerated := True;
      try
        if (FMouseDownIndex >= 0) and (FMouseDownIndex < FItems.Count) then
          begin
            if FMouseDownIndex = GetMouseItemIndex(X, Y) then ItemIndex := FMouseDownIndex;
          end;
      finally
        FUserGenerated := False;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.iDoSetFocus;
begin
  inherited;
  InvalidateNow;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.SubObjectChange(Sender: TObject);
begin
  if FItemIndex < -1             then FItemIndex := -1;
  if FItemIndex > FItems.Count-1 then FItemIndex := FItems.Count-1;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.SetItemIndex(const Value: Integer);
var
  TempItemIndex : Integer;
begin
  TempItemIndex := Value;
  if TempItemIndex < -1             then TempItemIndex := -1;
  if TempItemIndex > FItems.Count-1 then TempItemIndex := FItems.Count-1;
  if FItemIndex <> TempItemIndex then
    begin
      FItemIndex      := TempItemIndex;
      FMouseDownIndex := FItemIndex;
      InvalidateChange;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.SetColumns(const Value: Integer);
begin
  if Value < 1 then Exit;
  if FColumns <> Value then
    begin
      FColumns := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiRadioGroup.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  //TODO Needs to be removed once the Read-Only properties are implemented
begin
  iMouseDown(Button, Shift, X, Y);
  inherited MouseDown(Button, Shift, X, Y);
end;
//****************************************************************************************************************************************************
end.
