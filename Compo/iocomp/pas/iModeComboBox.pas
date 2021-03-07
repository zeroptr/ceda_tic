{*******************************************************}
{                                                       }
{       TiModeComboBox Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iModeComboBox;{$endif}
{$ifdef iCLX}unit QiModeComboBox;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions, iComponent,   iCustomComponent,  iComboBoxDisplay;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiComponent, QiCustomComponent, QiComboBoxDisplay;{$ENDIF}

type
  TiModeComboBoxBeforeOpenEvent = procedure(Sender: TObject; var Cancel: Boolean) of object;

  TiModeComboBox = class(TiCustomComponent)
  private
    FOldValue           : Integer;
    FItemList           : TStringList;
    FItemIndex          : Integer;
    FOldItemIndex       : Integer;
    FFont               : TFont;
    FDoingAutoSize      : Boolean;

    FDisplay            : TiModeComboBoxDisplay;

    FMouseDown          : Boolean;
    FAutoSize           : Boolean;
    FColor              : TColor;
    FButtonRect         : TRect;

    FOnChange           : TNotifyEvent;
    FOnChangeUser       : TNotifyEvent;
    FOnBeforeUserChange : TOnBeforeChangeInteger;
    FOnBeforeChange     : TOnBeforeChangeInteger;
    FOnAutoSize         : TNotifyEvent;
    FOnBeforeOpen       : TiModeComboBoxBeforeOpenEvent;
  protected
    procedure SetFont         (const Value: TFont);
    procedure iSetAutoSize    (const Value: Boolean);
    procedure SetColor        (const Value: TColor);
    procedure SetDropDownColor(const Value: TColor);
    procedure SetItemIndex    (const Value: Integer);
    procedure SetValue        (const Value: Integer);

    function GetValue     : Integer;
    function GetItemCount : Integer;

    function GetDropDownColor: TColor;

    procedure DefineProperties(Filer: TFiler); override;
    procedure WriteItems      (Writer: TWriter);
    procedure ReadItems       (Reader: TReader);
    function  DoWriteItems : Boolean;

    procedure iMouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp   (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove (                      Shift: TShiftState; X, Y: Integer); override;

    procedure iDoSetFocus;                                                          override;
    procedure iDoKillFocus;                                                         override;

    procedure iPaintTo(Canvas: TCanvas);                                            override;
    procedure DrawButton(const Canvas: TCanvas);

    procedure iKeyDown   (var CharCode: Word; Shift: TShiftState);                  override;

    {$ifdef iVCL}
    procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;
    {$endif}

    procedure FontChange(Sender : TObject);

    procedure DoChange; virtual;
    procedure DoAutoSize;

    property OnAutoSize    : TNotifyEvent  read FOnAutoSize  write FOnAutoSize;

    procedure DisplayDestroy    (Sender: TObject);
    procedure DisplaySelectIndex(Sender: TObject);

  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;

    {$ifdef iVCL}
    procedure OPCItemActivateSend(Index:Integer);
    {$endif}

    procedure AddItem(Caption: String; Value : Integer); reintroduce;
    procedure RemoveAllItems;

    procedure SetValueNoEvent(const Value : Integer);

    function GetItemCaption(Index: Integer): String;
    function GetItemValue  (Index: Integer): Integer;

    procedure SetItemCaption(Index: Integer; Value: String);
    procedure SetItemValue  (Index: Integer; Value: Integer);

    property ItemCount          : Integer                       read GetItemCount;
  published
    property ItemIndex          : Integer                       read FItemIndex          write SetItemIndex;
    property Value              : Integer                       read GetValue            write SetValue;
    property AutoSize           : Boolean                       read FAutoSize           write iSetAutoSize       default True;
    property Color              : TColor                        read FColor              write SetColor           default clWindow;
    property Font               : TFont                         read FFont               write SetFont;
    property DropDownColor      : TColor                        read GetDropDownColor    write SetDropDownColor   default clwindow;

    property OnChange           : TNotifyEvent                  read FOnChange           write FOnChange;
    property OnChangeUser       : TNotifyEvent                  read FOnChangeUser       write FOnChangeUser;
    property OnBeforeChange     : TOnBeforeChangeInteger        read FOnBeforeChange     write FOnBeforeChange;
    property OnBeforeUserChange : TOnBeforeChangeInteger        read FOnBeforeUserChange write FOnBeforeUserChange;
    property OnBeforeOpen       : TiModeComboBoxBeforeOpenEvent read FOnBeforeOpen       write FOnBeforeOpen;

    property Width        default 145;
    property Height       default 21;
    property TabStop      default True;
    property TabOrder;

    property ErrorActive;
    property ErrorText;
    property ErrorFont;
    property ErrorBackGroundColor;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiModeComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width       := 145;
  Height      := 21;
  TabStop     := True;
  BorderStyle := ibsLowered;

  FColor         := clWindow;
  FOldValue      := -1;
  FAutoSize      := True;
  FItemIndex     := -1;

  FItemList      := TStringList.Create;
  FFont          := TFont.Create;
  FFont.Style    := [fsBold];
  Font.OnChange  := FontChange;

  FDisplay  := TiModeComboBoxDisplay.Create(Self);
  with FDisplay do
    begin
      Width        := 0;
      Height       := 0;
      OnDestroy    := DisplayDestroy;
      OnSelectItem := DisplaySelectIndex;
      Master       := Self;
      Color        := clWindow;
    end;
end;
//****************************************************************************************************************************************************
destructor TiModeComboBox.Destroy;
begin
  FItemList.Free;
  FFont.Free;
  FDisplay.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.DoChange;
var
  NewValue  : Integer;
  CanChange : Boolean;
  NewIndex  : Integer;
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

  NewIndex := FItemList.IndexOfObject(TObject(NewValue));
  if NewIndex = -1 then Exit;

  {$ifdef iVCL}
  if OPCOutputData('Value', NewValue) then
    begin
      FItemIndex := FOldItemIndex;
      InvalidateChange;
      Exit;
    end;
  {$ENDIF}

  FItemIndex := NewIndex;

  if not(csLoading in ComponentState) then
    begin
      if                        Assigned(OnChangeProtected)  then OnChangeProtected (Self, 'Value');
      if                        Assigned(FOnChange)          then FOnChange         (Self);
      if UserGenerated then  if Assigned(FOnChangeUser)      then FOnChangeUser     (Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.FontChange(Sender : TObject);
begin
  DoAutoSize;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.SetColor        (const Value: TColor);begin SetColorProperty(Value, FColor,         irtInvalidate);end;
procedure TiModeComboBox.SetFont         (const Value: TFont );begin FFont.Assign(Value);                                   end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.DrawButton(const Canvas: TCanvas);
const
  Length = 2;
var
  CenterPoint : TPoint;
begin
  with Canvas, FButtonRect do
    begin
      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;

      FillRect(FButtonRect);

      if FMouseDown then
        begin
          Brush.Style := bsClear;
          Pen.Color   := clBtnShadow;
          Rectangle(Left, Top, Right, Bottom);
        end
      else
        begin
          iDrawEdge(Canvas, FButtonRect, idesRaised);
        end;

      Pen.Color   := clBlack;
      Pen.Style   := psSolid;
      Brush.Color := clBlack;
      Brush.Style := bsSolid;

      CenterPoint := Point((Right + Left) div 2 - 1, (Bottom + Top) div 2);

      Canvas.Polygon([Point(CenterPoint.X - 3, CenterPoint.Y - 2),
                      Point(CenterPoint.X + 3, CenterPoint.Y - 2),
                      Point(CenterPoint.X    , CenterPoint.Y + 1)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.iPaintTo(Canvas: TCanvas);
var
  AText         : String;
  ATextRect     : TRect;
  ATextFlags    : TiTextFlags;
  BorderMargin  : Integer;
  HighLightRect : TRect;
begin
  with Canvas do
    begin
      FButtonRect.Top    :=          2;
      FButtonRect.Bottom := Height - 2;
      FButtonRect.Right  := Width  - 2;
      FButtonRect.Left   := FButtonRect.Right - 16;

      if ErrorActive then
           DrawBackGround(Canvas, ErrorBackGroundColor)
      else DrawBackGround(Canvas, Self.Color);

      DrawBorder    (Canvas);
      BorderMargin := GetBorderMargin;

      ATextRect.Top        :=                     (2 + BorderMargin);
      ATextRect.Bottom     := Height -            (2 + BorderMargin);

      ATextRect.Left       :=                     (2 + BorderMargin);
      ATextRect.Right      := FButtonRect.Left  - (2);

      HighLightRect.Top    :=                     (1 + BorderMargin);
      HighLightRect.Bottom := Height -            (1 + BorderMargin);

      HighLightRect.Left   :=                     (1 + BorderMargin);
      HighLightRect.Right  := FButtonRect.Left  - (1);

      ATextFlags := [itfHLeft, itfVTop, itfSingleLine];

      if ErrorActive then
        begin
          Font.Assign(ErrorFont);
          AText := ErrorText;
          iDrawText(Canvas, AText, ATextRect, ATextFlags, True, BackGroundColor);
        end
      else
        begin
          Font.Assign(FFont);
          if (ItemIndex >= 0) and (ItemIndex < FItemList.Count) then AText := FItemList.Strings[ItemIndex] else AText := '';

          if HasFocus and not FDisplay.IsShowing and not FMouseDown then
            begin
              Brush.Color := clHighlight;
              Brush.Style := bsSolid;
              Font.Color  := clHighlightText;
              FillRect(HighLightRect);
              iDrawFocusRect(Canvas, HighLightRect, clHighlight);
            end;
          iDrawText(Canvas, AText, ATextRect, ATextFlags, True, BackGroundColor);
        end;

      DrawButton(Canvas);
  end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i                 : Integer;
  DisplayWasShowing : Boolean;
  ScreenPoint       : TPoint;
  ACancle           : Boolean;
begin
  SetFocus;

  if Button <> mbLeft then Exit;

  ACancle := False;
  if Assigned(FOnBeforeOpen) then FOnBeforeOpen(Self, ACancle);
  if ACancle then exit;

  DisplayWasShowing := FDisplay.IsShowing;

  if ErrorActive then Exit;

  if not DisplayWasShowing then
    begin
      FMouseDown        := True;

      FDisplay.Font.Assign(FFont);

      FDisplay.MinWidth := Width;
      {$IFDEF iVCL}ShowWindow(FDisplay.Handle, SW_SHOW);{$ENDIF}

      FDisplay.Items.Clear;

      for i := 0 to FItemList.Count-1 do
        FDisplay.Items.Add(FItemList.Strings[i]);

      FDisplay.SetUp;

      ScreenPoint := ClientToScreen(Point(0, 0));

      if ScreenPoint.Y + Height + FDisplay.NeededHeight > Screen.Height then
        begin
          FDisplay.Top    := ScreenPoint.Y - FDisplay.NeededHeight;
          FDisplay.Height := FDisplay.NeededHeight
        end
      else
        begin
          FDisplay.Top    := ScreenPoint.Y + Height;
          FDisplay.Height := FDisplay.NeededHeight
        end;

      if ScreenPoint.X + FDisplay.NeededWidth > Screen.Width then
        begin
          FDisplay.Left  := ScreenPoint.X + Width - FDisplay.NeededWidth;
          FDisplay.Width := FDisplay.NeededWidth
        end
      else
        begin
          FDisplay.Left  := ScreenPoint.X;
          FDisplay.Width := FDisplay.NeededWidth;
        end;
  end;

  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseDown := False;
  if FDisplay.IsShowing then FDisplay.Execute;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.iMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if not FMouseDown then Exit;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiModeComboBox.WMGetDLGCode(var Message: TMessage);
begin
  inherited;
  Message.Result := Message.Result + DLGC_WANTARROWS;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiModeComboBox.iDoSetFocus;
begin
  inherited iDoSetFocus;
  if ErrorActive then Exit;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.iDoKillFocus;
begin
  inherited iDoKillFocus;                      
  FMouseDown := False;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if ErrorActive then Exit;

  case CharCode of
    VK_LEFT,
    VK_UP     : if ItemIndex > 0                 then ItemIndex := ItemIndex - 1;
    VK_RIGHT,
    VK_DOWN   : if ItemIndex < FItemList.Count-1 then ItemIndex := ItemIndex + 1;
    VK_HOME   : ItemIndex := 0;
    VK_END    : ItemIndex := FItemList.Count-1;
  end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.DoAutoSize;
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
            Height := 2*GetBorderMargin + 4 + TextHeight('ABC');
          end;
        if Assigned(FOnAutoSize) then FOnAutoSize(Self);
      finally
        FDoingAutoSize := False;
      end;                                          
    end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.DisplayDestroy(Sender: TObject);
begin
  FDisplay := nil;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.DisplaySelectIndex(Sender: TObject);
begin
  UserGenerated := True;
  try
    ItemIndex := FDisplay.SelectIndex;
  finally
    UserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.SetItemIndex(const Value: Integer);
var
  TempValue : Integer;
begin
  if (csLoading in ComponentState) then
    begin
      FItemIndex := Value;
      Exit;
    end;

  TempValue := Value;
  if TempValue > (FItemList.Count - 1) then TempValue := (FItemList.Count - 1);
  if TempValue < -1 then TempValue := -1;

  if TempValue <> FItemIndex then
    begin
      if (TempValue <> - 1) and (FItemList.Count <> 0) then
        begin
          if FItemIndex <> - 1 then FOldValue := Integer(FItemList.Objects[FItemIndex]) else FOldValue := -1;
          FOldItemIndex := FItemIndex;
        end
      else FOldValue := -1;
      FItemIndex    := TempValue;
      FDisplay.SelectIndex := ItemIndex;
      DoChange;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
function TiModeComboBox.GetValue: Integer;
begin
  if (ItemIndex <> - 1) and (FItemList.Count <> 0) then
    begin
      Result := Integer(FItemList.Objects[ItemIndex]);
    end
  else Result := -1;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.SetValue(const Value: Integer);
begin
  if (csLoading in ComponentState) then Exit;

  if Value <> GetValue then
    begin
      ItemIndex := FItemList.IndexOfObject(TObject(Value));
    end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.AddItem(Caption: String; Value: Integer);
begin
  FItemList.AddObject(Caption, TObject(Value));
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.RemoveAllItems;
begin
  ItemIndex := -1;
  FItemList.Clear;
end;
//****************************************************************************************************************************************************
function TiModeComboBox.GetItemCaption(Index: Integer): String;
begin
  Result := FItemList.Strings[Index];
end;
//****************************************************************************************************************************************************
function TiModeComboBox.GetItemValue(Index: Integer): Integer;
begin
  Result := Integer(FItemList.Objects[Index]);
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.SetItemCaption(Index: Integer; Value: String);
begin
  FItemList.Strings[Index] := Value;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.SetItemValue(Index, Value: Integer);
begin
  FItemList.Objects[Index] := TObject(Value);
end;
//****************************************************************************************************************************************************
function TiModeComboBox.GetItemCount: Integer;
begin
  Result := FItemList.Count;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.SetValueNoEvent(const Value: Integer);
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
procedure TiModeComboBox.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('Items', ReadItems, WriteItems, DoWriteItems);
  inherited;
end;
//****************************************************************************************************************************************************
function TiModeComboBox.DoWriteItems: Boolean;
begin
  Result := FItemList.Count <> 0;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBox.WriteItems(Writer: TWriter);
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
procedure TiModeComboBox.ReadItems(Reader: TReader);
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
{$ifdef iVCL}
procedure TiModeComboBox.OPCItemActivateSend(Index: Integer);
var
  OldValue : Double;
begin
  OldValue := Value;
  OPCItemActivate(Index);
  OPCItem[Index].Data := OldValue;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiModeComboBox.SetDropDownColor(const Value: TColor);
begin
  FDisplay.Color := Value;
end;
//****************************************************************************************************************************************************
function TiModeComboBox.GetDropDownColor: TColor;
begin
  Result := FDisplay.Color;
end;
//****************************************************************************************************************************************************
end.


