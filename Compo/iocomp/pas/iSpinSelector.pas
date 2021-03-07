{*******************************************************}
{                                                       }
{       TiSpinSelector Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSpinSelector;{$endif}
{$ifdef iCLX}unit QiSpinSelector;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions, iComponent,   iCustomComponent,  iComboBoxDisplay,  iEditorBasicComponents;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiComponent, QiCustomComponent, QiComboBoxDisplay, QiEditorBasicComponents;{$ENDIF}

type
  TiSpinItem = class(TObject)
  public
    Caption : String;
    Value   : Double;
  end;

  TiSpinSelector = class(TiCustomComponent)
  private
    FOldValue           : Double;
    FItemList           : TStringList;
    FItemIndex          : Integer;
    FOldItemIndex       : Integer;
    FFont               : TFont;
    FDoingAutoSize      : Boolean;
    FUserGenerated      : Boolean;

    FTimer              : TTimer;
    FFirstTimerMessage  : Boolean;

    FAutoSize           : Boolean;
    FColor              : TColor;

    FButtonRectUp       : TRect;
    FButtonRectDown     : TRect;
    FButtonrectDefault  : TRect;
    FMouseDownUp        : Boolean;
    FMouseDownDown      : Boolean;
    FMouseDownDefault   : Boolean;

    FMouseDownTime      : Double;
    FFastIncrement      : Integer;
    FFastSecondsDelay   : Double;

    FOnChange           : TNotifyEvent;
    FOnChangeUser       : TNotifyEvent;
    FOnBeforeUserChange : TOnBeforeChangeDouble;
    FOnBeforeChange     : TOnBeforeChangeDouble;
    FOnAutoSize         : TNotifyEvent;
    FRepeatInitialDelay : Integer;
    FRepeatInterval     : Integer;
    FDefaultValue       : Double;
  protected
    procedure SetFont     (const Value: TFont);
    procedure iSetAutoSize(const Value: Boolean);
    procedure SetColor    (const Value: TColor);
    procedure SetItemIndex(const Value: Integer);
    procedure SetValue    (const Value: Double);

    function GetValue     : Double;
    function GetItemCount : Integer;
    function GetItemIndex : Integer;
    function GetText      : String; reintroduce;

    procedure DefineProperties(Filer: TFiler); override;
    procedure WriteItems      (Writer: TWriter);
    procedure ReadItems       (Reader: TReader);
    function  DoWriteItems : Boolean;

    procedure iMouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp   (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure iDoSetFocus;                                                          override;
    procedure iDoKillFocus;                                                         override;

    procedure TimerEvent(Sender: TObject);

    procedure iPaintTo(Canvas: TCanvas);                                            override;
    procedure DrawButton       (const Canvas: TCanvas; ARect: TRect; MouseDown, ArrowUp: Boolean);
    procedure DrawDefaultButton(const Canvas: TCanvas);

    procedure iKeyDown   (var CharCode: Word; Shift: TShiftState);                  override;

    {$ifdef iVCL}
    procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;
    {$endif}

    procedure FontChange(Sender : TObject);

    procedure DoChange; virtual;
    procedure DoAutoSize;

    property OnAutoSize    : TNotifyEvent  read FOnAutoSize  write FOnAutoSize;

    procedure DoButtonUpClick;
    procedure DoButtonDownClick;
    procedure DoButtonDefaultClick;

    {$ifdef iVCL}procedure SetEnabled(      Value: Boolean); override;{$endif}
    {$ifdef iCLX}procedure SetEnabled(const Value: Boolean); override;{$endif}

    procedure SetItemIndexByValue  (Value: Double);
  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;

    procedure AddItem(Caption: String; Value : Double); reintroduce;
    procedure RemoveAllItems;

    function GetItemCaption       (Index: Integer): String;
    function GetItemValue         (Index: Integer): Double;
    function GetItemCaptionByValue(Value: Double): String;

    procedure SetItemCaption(Index: Integer; Value: String);
    procedure SetItemValue  (Index: Integer; Value: Double);

    procedure SetItemIndexByCaption(Value: String);

    function GetMaxItemsWidth(Canvas: TCanvas): Integer;

    procedure AssignItems(SpinSelector: TiSpinSelector);

    property ItemCount          : Integer               read GetItemCount;
    property Text               : String                read GetText;
  published
    property ItemIndex          : Integer               read GetItemIndex        write SetItemIndex;
    property Value              : Double                read GetValue            write SetValue;
    property AutoSize           : Boolean               read FAutoSize           write iSetAutoSize       default True;
    property Font               : TFont                 read FFont               write SetFont;

    property RepeatInitialDelay : Integer               read FRepeatInitialDelay write FRepeatInitialDelay default 500;
    property RepeatInterval     : Integer               read FRepeatInterval     write FRepeatInterval     default 50;

    property FastIncrement      : Integer               read FFastIncrement      write FFastIncrement;
    property FastSecondsDelay   : Double                read FFastSecondsDelay   write FFastSecondsDelay;

    property DefaultValue       : Double                read FDefaultValue       write FDefaultValue;

    property OnChange           : TNotifyEvent          read FOnChange           write FOnChange;
    property OnChangeUser       : TNotifyEvent          read FOnChangeUser       write FOnChangeUser;
    property OnBeforeChange     : TOnBeforeChangeDouble read FOnBeforeChange     write FOnBeforeChange;
    property OnBeforeUserChange : TOnBeforeChangeDouble read FOnBeforeUserChange write FOnBeforeUserChange;

    property Width        default 145;
    property Height       default 21;
    property TabStop      default True;
    property TabOrder;

    property BackGroundColor;

    property ErrorActive;
    property ErrorText;
    property ErrorFont;
    property ErrorBackGroundColor;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiSpinSelector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width           := 145;
  Height          := 21;
  TabStop         := True;
  BorderStyle     := ibsLowered;
  BackGroundColor := clBlack;

  FColor              := clWindow;
  FOldValue           := -1;
  FAutoSize           := True;
  FItemIndex          := -1;

  FFastIncrement      := 0;
  FFastSecondsDelay   := 2;

  FItemList           := TStringList.Create;
  FFont               := TFont.Create;
  Font.Color          := clLime;
  FFont.Style         := [fsBold];
  Font.OnChange       := FontChange;

  FRepeatInitialDelay := 500;
  FRepeatInterval     := 50;

  FTimer              := TTimer.Create(Self);
  FTimer.Enabled      := False;
  FTimer.OnTimer      := TimerEvent;
end;
//****************************************************************************************************************************************************
destructor TiSpinSelector.Destroy;
begin
  RemoveAllItems;
  FItemList.Free;
  FFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.DoChange;
var
  NewValue  : Double;
  CanChange : Boolean;
begin
  if csLoading in ComponentState then Exit;

  NewValue := GetValue;
  CanChange := True;

  if                       Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Value',             CanChange);
  if UserGenerated then if Assigned(FOnBeforeUserChange)    then FOnBeforeUserChange   (Self, FOldValue, NewValue, CanChange);
                        if Assigned(FOnBeforeChange)        then FOnBeforeChange       (Self, FOldValue, NewValue, CanChange);

  if not CanChange then
    begin
      FItemIndex := FOldItemIndex;
      InvalidateChange;
      Exit;
    end;

  {$ifdef iVCL}
  if OPCOutputData('Value', NewValue) then
    begin
      FItemIndex := FOldItemIndex;
      InvalidateChange;
      Exit;
    end;
  {$ENDIF}

  FOldValue := NewValue;

  if not(csLoading in ComponentState) then
    begin
      if                        Assigned(OnChangeProtected)   then OnChangeProtected (Self, 'Value');
      if                        Assigned(FOnChange)           then FOnChange         (Self);
      if UserGenerated then  if Assigned(FOnChangeUser)       then FOnChangeUser     (Self);
      if UserGenerated then  if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;

    end;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.FontChange(Sender : TObject);
begin
  DoAutoSize;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.SetColor(const Value: TColor);begin SetColorProperty(Value, FColor, irtInvalidate);end;
procedure TiSpinSelector.SetFont (const Value: TFont );begin FFont.Assign(Value);                           end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.DrawDefaultButton(const Canvas: TCanvas);
const
  Size = 4;
var
  APoint : TPoint;
begin
  with Canvas, FButtonrectDefault do
    begin
      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;

      FillRect(FButtonrectDefault);

      if FMouseDownDefault then                                                
        iDrawEdge(Canvas, FButtonrectDefault, idesSunken)
      else
        iDrawEdge(Canvas, FButtonrectDefault, idesRaised);

      Pen.Style   := psClear;           
      Brush.Color := clBlack;
      Brush.Style := bsSolid;

      APoint := GetRectCenterPoint(FButtonrectDefault);

      Ellipse(APoint.X -Size, APoint.Y - Size, APoint.X + Size, APoint.Y + Size);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.DrawButton(const Canvas: TCanvas; ARect: TRect; MouseDown, ArrowUp: Boolean);
const
  Length = 2;
var
  CenterPoint : TPoint;
begin
  with Canvas, ARect do
    begin
      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;

      FillRect(ARect);

      if MouseDown then
        iDrawEdge(Canvas, ARect, idesSunken)
      else
        iDrawEdge(Canvas, ARect, idesRaised);

      Pen.Color   := clBlack;
      Pen.Style   := psSolid;
      Brush.Color := clBlack;
      Brush.Style := bsSolid;

      CenterPoint := GetRectCenterPoint(ARect);

      if ArrowUp then
        begin
          Canvas.Polygon([Point(CenterPoint.X - 3, CenterPoint.Y + 1),
                          Point(CenterPoint.X + 3, CenterPoint.Y + 1),
                          Point(CenterPoint.X    , CenterPoint.Y - 2)]);
        end
      else
        begin
          Canvas.Polygon([Point(CenterPoint.X - 3, CenterPoint.Y - 2),
                          Point(CenterPoint.X + 3, CenterPoint.Y - 2),
                          Point(CenterPoint.X    , CenterPoint.Y + 1)]);
        end
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.iPaintTo(Canvas: TCanvas);
var
  AText         : String;
  ATextRect     : TRect;
  ATextFlags    : TiTextFlags;
  BorderMargin  : Integer;
begin
  with Canvas do
    begin
      FButtonrectDefault.Top    := 2;
      FButtonrectDefault.Bottom := Height - 2;
      FButtonrectDefault.Right  := Width - 2;
      FButtonrectDefault.Left   := FButtonrectDefault.Right - 14;

      FButtonRectUp.Top         := 2;
      FButtonRectUp.Bottom      := Height div 2;
      FButtonRectUp.Right       := FButtonrectDefault.Left;
      FButtonRectUp.Left        := FButtonRectUp.Right - 15;

      FButtonRectDown.Top       := Height div 2;
      FButtonRectDown.Bottom    := Height -2;
      FButtonRectDown.Right     := FButtonRectUp.Right;
      FButtonRectDown.Left      := FButtonRectUp.Left;

      if ErrorActive then
           DrawBackGround(Canvas, ErrorBackGroundColor)
      else DrawBackGround(Canvas, BackGroundColor);

      DrawBorder    (Canvas);
      BorderMargin := GetBorderMargin;

      ATextRect.Top        :=                      (2 + BorderMargin);
      ATextRect.Bottom     := Height -             (2 + BorderMargin);

      ATextRect.Left       :=                      (2 + BorderMargin);
      ATextRect.Right      := FButtonRectUp.Left - (2);

      ATextFlags := [itfHRight, itfVCenter, itfSingleLine];

      OffsetRect(ATextRect, -3, 0);

      if Enabled then
        begin
          if ErrorActive then
            begin
              Font.Assign(ErrorFont);
              AText := ErrorText;
              iDrawText(Canvas, AText, ATextRect, ATextFlags, True, clBtnFace);
            end
          else
            begin
              Font.Assign(FFont);
              if (ItemIndex >= 0) and (ItemIndex < FItemList.Count) then AText := (FItemList.Objects[ItemIndex] as TiSpinItem).Caption else AText := '';

              iDrawText(Canvas, AText, ATextRect, ATextFlags, True, clBtnFace);
            end;
        end;

      DrawButton(Canvas, FButtonRectUp,   FMouseDownUp,   True);
      DrawButton(Canvas, FButtonRectDown, FMouseDownDown, False);
      DrawDefaultButton(Canvas);




      if HasFocus then
        begin
          Font.Color := (not BackGroundColor) and $FFFFFF;
          iDrawFocusRect(Canvas, Rect(4, 4, FButtonRectUp.Left - 2, Height - 4), BackGroundColor);
        end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not Enabled then Exit;
  if ErrorActive then Exit;
  iSetFocus(Self);

  if      PtInRect(FButtonRectUp,      Point(X,Y)) then FMouseDownUp      := True
  else if PtInRect(FButtonRectDown,    Point(X,Y)) then FMouseDownDown    := True
  else if PtInRect(FButtonrectDefault, Point(X,Y)) then FMouseDownDefault := True;

  if FMouseDownUp or FMouseDownDown then
    begin
      FTimer.Interval    := FRepeatInitialDelay;
      FTimer.Enabled     := True;
      FFirstTimerMessage := True;
      FMouseDownTime     := Now;
    end;

  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDownUp      and PtInRect(FButtonRectUp,      Point(X, Y)) then DoButtonUpClick;
  if FMouseDownDown    and PtInRect(FButtonRectDown,    Point(X, Y)) then DoButtonDownClick;
  if FMouseDownDefault and PtInRect(FButtonrectDefault, Point(X, Y)) then DoButtonDefaultClick;

  FMouseDownUp      := False;
  FMouseDownDown    := False;
  FMouseDownDefault := False;
  FTimer.Enabled    := False;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiSpinSelector.WMGetDLGCode(var Message: TMessage);
begin
  inherited;
  Message.Result := Message.Result + DLGC_WANTARROWS;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiSpinSelector.iDoSetFocus;
begin
  inherited iDoSetFocus;
  if ErrorActive then Exit;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.iDoKillFocus;
begin
  inherited iDoKillFocus;
  FMouseDownUp      := False;
  FMouseDownDown    := False;
  FMouseDownDefault := False;
  FTimer.Enabled    := False;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if ErrorActive then Exit;

  case CharCode of
    VK_LEFT,
    VK_UP     : DoButtonUpClick;
    VK_RIGHT,
    VK_DOWN   : DoButtonDownClick;
    VK_HOME   : ItemIndex := 0;
    VK_END    : ItemIndex := FItemList.Count-1;
  end;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.DoAutoSize;
begin
  if FDoingAutoSize                                                   then Exit;
  if csLoading in ComponentState                                      then Exit;
  if not Assigned(Parent) {$ifdef iVCL}and (ParentWindow = 0){$endif} then Exit;

  if FAutoSize then
    begin
      FDoingAutoSize := True;
      try
        with Canvas do
          begin
            Font.Assign(FFont);
            Height := 2*GetBorderMargin + 6 + TextHeight('ABC');
          end;
        if Assigned(FOnAutoSize) then FOnAutoSize(Self);
      finally
        FDoingAutoSize := False;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.SetItemIndex(const Value: Integer);
var
  TempValue : Integer;
begin
  TempValue := Value;
  if TempValue > (FItemList.Count - 1) then TempValue := (FItemList.Count - 1);
  if TempValue < -1 then TempValue := -1;

  if TempValue <> FItemIndex then
    begin
      if FItemIndex <> - 1 then FOldValue := Integer(FItemList.Objects[FItemIndex]) else FOldValue := -1;
      FOldItemIndex := FItemIndex;
      FItemIndex    := TempValue;
      DoChange;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
function TiSpinSelector.GetValue: Double;
begin
  if ItemIndex <> - 1 then
    begin
      Result := (FItemList.Objects[ItemIndex] as TiSpinItem).Value
    end
  else Result := -1;
end;
//****************************************************************************************************************************************************
function TiSpinSelector.GetText: String;
begin
  if ItemIndex <> - 1 then
    begin
      Result := (FItemList.Objects[ItemIndex] as TiSpinItem).Caption
    end
  else Result := 'N/A';
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.SetValue(const Value: Double);
begin
  if Value <> GetValue then
    begin
      SetItemIndexByValue(Value);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.AddItem(Caption: String; Value: Double);
var
  SpinItem : TiSpinItem;
begin
  SpinItem         := TiSpinItem.Create;
  SpinItem.Caption := Caption;
  SpinItem.Value   := Value;

  FItemList.AddObject('', SpinItem);

  if ItemIndex = - 1 then ItemIndex := 0;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.RemoveAllItems;
begin
  while FItemList.Count <> 0 do
    begin
      FItemList.Objects[0].Free;
      FItemList.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
function TiSpinSelector.GetItemCaption(Index: Integer): String;
begin
  Result := (FItemList.Objects[Index] as TiSpinItem).Caption;
end;
//****************************************************************************************************************************************************
function TiSpinSelector.GetItemValue(Index: Integer): Double;
begin
  Result := (FItemList.Objects[Index] as TiSpinItem).Value;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.SetItemCaption(Index: Integer; Value: String);
begin
  (FItemList.Objects[Index] as TiSpinItem).Caption := Value;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.SetItemValue(Index: Integer; Value: Double);
begin
  (FItemList.Objects[Index] as TiSpinItem).Value := Value;
end;
//****************************************************************************************************************************************************
function TiSpinSelector.GetItemCount: Integer;
begin
  Result := FItemList.Count;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('Items', ReadItems, WriteItems, DoWriteItems);
  inherited;
end;
//****************************************************************************************************************************************************
function TiSpinSelector.DoWriteItems: Boolean;
begin
  Result := FItemList.Count <> 0;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.WriteItems(Writer: TWriter);
var
  x : Integer;
begin
  Writer.WriteListBegin;
  for x := 0 to FItemList.Count - 1 do
    begin
      Writer.WriteString (FItemList.Strings[x]);
      Writer.WriteInteger(Integer(FItemList.Objects[x]));
    end;
  Writer.WriteListEnd;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.ReadItems(Reader: TReader);
var
  Caption : String;
  Value   : Integer;
begin
  FItemList.Clear;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    begin                                                                   
      Caption := Reader.ReadString;
      Value   := Reader.ReadInteger;

      FItemList.AddObject(Caption, TObject(Value));
    end;
  Reader.ReadListEnd;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.DoButtonUpClick;
var
  NewIndex : Integer;
begin
  if FItemList.Count = 0 then Exit;

  if (FFastIncrement <> 0) and ((Now - FMouseDownTime)*(24*60*60) > FFastSecondsDelay) then
    begin
      NewIndex := (ItemIndex div FFastIncrement)*FFastIncrement + FFastIncrement;
    end
  else
    begin
      NewIndex := ItemIndex + 1;
    end;

  if NewIndex > (ItemCount - 1) then NewIndex := (ItemCount - 1);

  ItemIndex := NewIndex;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.DoButtonDownClick;
var
  NewIndex : Integer;
begin
  if FItemList.Count = 0 then Exit;

  if (FFastIncrement <> 0) and ((Now - FMouseDownTime)*(24*60*60) > FFastSecondsDelay) then
    begin
      NewIndex := (ItemIndex div FFastIncrement)*FFastIncrement - FFastIncrement;
    end
  else
    begin
      NewIndex := ItemIndex - 1;
    end;

  if NewIndex < 0 then NewIndex := 0;

  ItemIndex := NewIndex;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.DoButtonDefaultClick;
begin
  if FItemList.Count = 0 then Exit;
  Value := FDefaultValue;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.TimerEvent(Sender: TObject);
begin
  if FFirstTimerMessage then
    begin
      FTimer.Interval := FRepeatInterval;
      FFirstTimerMessage := False;
    end;

  FUserGenerated := True;
  try
    if FMouseDownUp then DoButtonUpClick else DoButtonDownClick;
  finally
    FUserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.SetItemIndexByValue(Value: Double);
var
  x : Integer;
begin
  for x := 0 to ItemCount-1 do
    if GetItemValue(x) = Value then
      begin
        ItemIndex := x;
        Break;
      end;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.SetItemIndexByCaption(Value: String);
var
  x : Integer;
begin
  for x := 0 to ItemCount-1 do
    if GetItemCaption(x) = Value then
      begin
        ItemIndex := x;
        Break;
      end;
end;
//****************************************************************************************************************************************************
function TiSpinSelector.GetItemCaptionByValue(Value: Double): String;
var
  x     : Integer;
  Index : Integer;
begin
  Index := -1;
  for x := 0 to ItemCount-1 do
    if GetItemValue(x) = Value then
      begin
        Index := x;
        Break;
      end;

  if Index <> - 1 then
    Result := GetItemCaption(Index)
  else Result := 'Error';
end;
//****************************************************************************************************************************************************
function TiSpinSelector.GetMaxItemsWidth(Canvas: TCanvas): Integer;
var
  x      : Integer;
  AText  : String;
  AWidth : Integer;
begin
  Result := 0;
  with Canvas do
    for x := 0 to ItemCount-1 do
      begin
        AText := GetItemCaption(x);
        AWidth := TextWidth(AText);
        if AWidth > Result then Result := AWidth;
      end;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}procedure TiSpinSelector.SetEnabled(      Value: Boolean);{$endif}
{$ifdef iCLX}procedure TiSpinSelector.SetEnabled(const Value: Boolean);{$endif}
begin
  inherited SetEnabled(Value);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiSpinSelector.GetItemIndex: Integer;
begin
  if FItemList.Count = 0 then FItemIndex := -1;
  if FitemIndex > (ItemCount - 1) then FItemIndex := ItemCount -1;
  Result := FItemIndex;
end;
//****************************************************************************************************************************************************
procedure TiSpinSelector.AssignItems(SpinSelector: TiSpinSelector);
var
  x : Integer;
begin
   RemoveAllItems;
   for x := 0 to SpinSelector.ItemCount-1 do
     AddItem(SpinSelector.GetItemCaption(x), SpinSelector.GetItemValue(x));
end;
//****************************************************************************************************************************************************
end.


