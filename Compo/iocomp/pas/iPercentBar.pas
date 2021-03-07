{*******************************************************}
{                                                       }
{       TiPercentBar Component                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPercentBar;{$endif}
{$ifdef iCLX}unit QiPercentBar;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iClasses,  iCustomComponent, iOPCItem;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiClasses, QiCustomComponent;          {$ENDIF}

type
  TiPercentBar = class(TiCustomComponent)
  private
    FItemList                 : TStringList;

    FLegendFont               : TFont;
    FLegendMargin             : Integer;
    FOuterMargin              : Integer;
    FTitleMargin              : Integer;
    FTitleText                : String;
    FTitleFont                : TFont;
    FLegendShowValue          : Boolean;
    FLegendShowPercent        : Boolean;
    FLegendValuePrecision     : Integer;
    FLegendPercentPrecision   : Integer;
    FLegendValueMargin        : Integer;
    FLegendPercentMargin      : Integer;
    FBarWidth                 : Integer;
    FTitleHorizontalAlignment : TiTitleHorizontalAlignment;

    procedure SetLegendFont            (const Value: TFont);
    procedure SetLegendMargin          (const Value: Integer);
    procedure SetTitleFont             (const Value: TFont);
    procedure SetTitleMargin           (const Value: Integer);
    procedure SetTitleText             (const Value: String);
    procedure SetLegendPercentPrecision(const Value: Integer);
    procedure SetLegendValuePrecision  (const Value: Integer);
    procedure SetLegendShowPercent     (const Value: Boolean);
    procedure SetLegendShowValue       (const Value: Boolean);

    function GetItemCount                 : Integer;
    function GetItemColor(Index: Integer) : TColor;
    function GetItemTitle(Index: Integer) : String;
    function GetItemValue(Index: Integer) : Double;

    procedure SetItemColor               (Index: Integer; const Value: TColor);
    procedure SetItemTitle               (Index: Integer; const Value: String);
    procedure SetItemValue               (Index: Integer; const Value: Double);
    procedure SetLegendPercentMargin     (const Value: Integer);
    procedure SetLegendValueMargin       (const Value: Integer);
    procedure SetBarWidth                (const Value: Integer);
    procedure SetTitleHorizontalAlignment(const Value: TiTitleHorizontalAlignment);
    procedure SetOuterMargin(const Value: Integer);

  protected
    procedure iPaintTo(Canvas: TCanvas);         override;
    procedure DefineProperties(Filer: TFiler);   override;
    procedure WriteItems      (Writer: TWriter);
    procedure ReadItems       (Reader: TReader);
    function  DoWriteItems : Boolean;

    {$ifdef iVCL}
    procedure UpdateOPCSpecialList;                                                  override;
    function  OPCNewDataSpecial(PropertyName: String; NewData: OleVariant): Boolean; override;
    {$endif}
  public
    constructor Create(AOwner: TComponent);      override;
    destructor  Destroy;                         override;
    procedure   Loaded;                          override;
    procedure   AddItem(Title: String; Color: TColor; Value: Double);
    procedure   RemoveItem(Index : Integer);
    procedure   ClearList;

    property    ItemCount                 : Integer                    read GetItemCount;
    property    ItemTitle[Index: Integer] : String                     read GetItemTitle              write SetItemTitle;
    property    ItemColor[Index: Integer] : TColor                     read GetItemColor              write SetItemColor;
    property    ItemValue[Index: Integer] : Double                     read GetItemValue              write SetItemValue;
  published
    property OuterMargin                  : Integer                    read FOuterMargin              write SetOuterMargin              default 10;

    property BarWidth                     : Integer                    read FBarWidth                 write SetBarWidth                 default 30;

    property LegendFont                   : TFont                      read FLegendFont               write SetLegendFont;
    property LegendMargin                 : Integer                    read FLegendMargin             write SetLegendMargin             default 10;

    property TitleText                    : String                     read FTitleText                write SetTitleText;
    property TitleMargin                  : Integer                    read FTitleMargin              write SetTitleMargin              default 10;
    property TitleHorizontalAlignment     : TiTitleHorizontalAlignment read FTitleHorizontalAlignment write SetTitleHorizontalAlignment default ithaCenterDisplay;
    property TitleFont                    : TFont                      read FTitleFont                write SetTitleFont;

    property LegendShowValue              : Boolean                    read FLegendShowValue          write SetLegendShowValue          default False;
    property LegendShowPercent            : Boolean                    read FLegendShowPercent        write SetLegendShowPercent        default False;
    property LegendValuePrecision         : Integer                    read FLegendValuePrecision     write SetLegendValuePrecision     default 1;
    property LegendValueMargin            : Integer                    read FLegendValueMargin        write SetLegendValueMargin        default 10;
    property LegendPercentPrecision       : Integer                    read FLegendPercentPrecision   write SetLegendPercentPrecision   default 1;
    property LegendPercentMargin          : Integer                    read FLegendPercentMargin      write SetLegendPercentMargin      default 10;

    property BackGroundColor;
    property BorderStyle      default ibsRaised;
    property Transparent;
    property Width            default 200;
    property Height           default 150;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiPercentBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width           := 200;
  Height          := 150;
  BorderStyle     := ibsRaised;

  FOuterMargin            := 10;
  FBarWidth               := 30;
  FLegendMargin           := 10;

  FTitleMargin            := 10;
  FTitleText              := 'Percent Bar 1';

  FLegendValuePrecision   := 1;
  FLegendPercentPrecision := 1;
  FLegendValueMargin      := 10;
  FLegendPercentMargin    := 10;

  FItemList   := TStringList.Create;

  FLegendFont := TFont.Create; FLegendFont.OnChange := BackGroundChangeEvent;
  FTitleFont  := TFont.Create; FTitleFont.OnChange  := BackGroundChangeEvent;

  AddItem('Item 1', clRed,  100);
  AddItem('Item 2', clLime, 100);
  AddItem('Item 3', clBlue, 100);
end;
//****************************************************************************************************************************************************
destructor TiPercentBar.Destroy;
begin
  ClearList;
  FItemList.Free;
  FLegendFont.Free;
  FTitleFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.ClearList;
begin
  while FItemList.Count > 0 do
    begin
      FItemList.Objects[0].Free;
      FItemList.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.Loaded;
begin
  inherited;
  if ItemCount = 0 then
    begin
      AddItem('Item 1', clRed,  100);
      AddItem('Item 2', clLime, 100);
      AddItem('Item 3', clBlue, 100);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.SetLegendMargin          (const Value:Integer);begin SetIntegerProperty(Value,FLegendMargin,          irtInvalidate);end;
procedure TiPercentBar.SetTitleMargin           (const Value:Integer);begin SetIntegerProperty(Value,FTitleMargin,           irtInvalidate);end;
procedure TiPercentBar.SetTitleText             (const Value:String );begin SetStringProperty (Value,FTitleText,             irtInvalidate);end;
procedure TiPercentBar.SetOuterMargin           (const Value:Integer);begin SetIntegerProperty(Value,FOuterMargin,           irtInvalidate);end;
procedure TiPercentBar.SetLegendPercentPrecision(const Value:Integer);begin SetIntegerProperty(Value,FLegendPercentPrecision,irtInvalidate);end;
procedure TiPercentBar.SetLegendValuePrecision  (const Value:Integer);begin SetIntegerProperty(Value,FLegendValuePrecision,  irtInvalidate);end;
procedure TiPercentBar.SetLegendShowPercent     (const Value:Boolean);begin SetBooleanProperty(Value,FLegendShowPercent,     irtInvalidate);end;
procedure TiPercentBar.SetLegendShowValue       (const Value:Boolean);begin SetBooleanProperty(Value,FLegendShowValue,       irtInvalidate);end;
procedure TiPercentBar.SetLegendPercentMargin   (const Value:Integer);begin SetIntegerProperty(Value,FLegendPercentMargin,   irtInvalidate);end;
procedure TiPercentBar.SetLegendValueMargin     (const Value:Integer);begin SetIntegerProperty(Value,FLegendValueMargin,     irtInvalidate);end;
procedure TiPercentBar.SetBarWidth              (const Value:Integer);begin SetIntegerProperty(Value,FBarWidth,              irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiPercentBar.SetLegendFont(const Value:TFont);begin FLegendFont.Assign(Value);end;
procedure TiPercentBar.SetTitleFont (const Value:TFont);begin FTitleFont.Assign (Value);end;
//****************************************************************************************************************************************************
procedure TiPercentBar.AddItem(Title: String; Color: TColor; Value: Double);
var
  iPieChartItemObject : TiPercentItemObject;
begin
  iPieChartItemObject       := TiPercentItemObject.Create;
  iPieChartItemObject.Title := Title;
  iPieChartItemObject.Color := Color;
  iPieChartItemObject.Value := Value;
  FItemList.AddObject('', iPieChartItemObject);

  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiPercentBar.GetItemCount: Integer;
begin
  Result := FItemList.Count;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.RemoveItem(Index: Integer);
begin
  if (Index < 0) or (Index > FItemList.Count) then raise Exception.Create('Item Index out of Bounds');
  FitemList.Objects[Index].Free;
  FitemList.Delete(Index);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiPercentBar.GetItemTitle(Index: Integer): String;
begin
  if (Index < 0) or (Index > FItemList.Count) then raise Exception.Create('Item Index out of Bounds');
  Result := (FitemList.Objects[Index] as TiPercentItemObject).Title;
end;
//****************************************************************************************************************************************************
function TiPercentBar.GetItemColor(Index: Integer): TColor;
begin
  if (Index < 0) or (Index > FItemList.Count) then raise Exception.Create('Item Index out of Bounds');
  Result := (FitemList.Objects[Index] as TiPercentItemObject).Color;
end;
//****************************************************************************************************************************************************
function TiPercentBar.GetItemValue(Index: Integer): Double;
begin
  if (Index < 0) or (Index > FItemList.Count) then raise Exception.Create('Item Index out of Bounds');
  Result := (FitemList.Objects[Index] as TiPercentItemObject).Value;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.SetItemTitle(Index: Integer; const Value: String);
begin
  if (Index < 0) or (Index > FItemList.Count) then raise Exception.Create('Item Index out of Bounds');
  (FitemList.Objects[Index] as TiPercentItemObject).Title := Value;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.SetItemColor(Index: Integer; const Value: TColor);
begin
  if (Index < 0) or (Index > FItemList.Count) then raise Exception.Create('Item Index out of Bounds');
  (FitemList.Objects[Index] as TiPercentItemObject).Color := Value;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.SetItemValue(Index: Integer; const Value: Double);
var
  TempValue : Double;
begin
  if Value < 0 then TempValue := 0 else TempValue := Value;
  if (Index < 0) or (Index > FItemList.Count) then raise Exception.Create('Item Index out of Bounds');
  (FitemList.Objects[Index] as TiPercentItemObject).Value := TempValue;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.SetTitleHorizontalAlignment(const Value: TiTitleHorizontalAlignment);
begin
  if FTitleHorizontalAlignment <> Value then
    begin
      FTitleHorizontalAlignment := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Items', ReadItems, WriteItems, DoWriteItems);
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.ReadItems(Reader: TReader);
var
  iPercentItemObject : TiPercentItemObject;
begin
  ClearList;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    begin
      iPercentItemObject := TiPercentItemObject.Create;
      FItemList.AddObject('', iPercentItemObject);
      iPercentItemObject.Title := Reader.ReadString;

      Reader.ReadListBegin;
      iPercentItemObject.Color := Reader.ReadInteger;
      iPercentItemObject.Value := Reader.ReadFloat;
      Reader.ReadListEnd
    end;
  Reader.ReadListEnd;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.WriteItems(Writer: TWriter);
var
  x                  : Integer;
  iPercentItemObject : TiPercentItemObject;
begin
  Writer.WriteListBegin;
  for x := 0 to FItemList.Count - 1 do
    begin
      iPercentItemObject := FItemList.Objects[x] as TiPercentItemObject;
      Writer.WriteString (iPercentItemObject.Title);
      Writer.WriteListBegin;
      Writer.WriteInteger(iPercentItemObject.Color);
      Writer.WriteFloat(iPercentItemObject.Value);
      Writer.WriteListEnd;
    end;
  Writer.WriteListEnd;
end;
//****************************************************************************************************************************************************
function TiPercentBar.DoWriteItems: Boolean;
begin
  Result := FItemList.Count <> 0;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.iPaintTo(Canvas: TCanvas);
var
  ATextString        : String;
  ATextRect          : TRect;
  AWidth             : Integer;
  YPoint             : Integer;
  x                  : Integer;
  iPercentItemObject : TiPercentItemObject;
  LegendLeft         : Integer;
  LegendRowHeight    : Integer;
  LegendHeight       : Integer;
  LegendWidth        : Integer;
  TotalValue         : Double;
  ItemPercent        : Double;
  PreviousY          : Double;
  BarCenterX         : Integer;
  BarHeight          : Integer;
  BarRect            : TRect;
  TitleHeight        : Integer;
  TitleWidth         : Integer;
  TitleCenterX       : Integer;
  MaxTitleWidth      : Integer;
  MaxValueWidth      : Integer;
  MaxPercentWidth    : Integer;
  ShowTitle          : Boolean;
begin
  with Canvas do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      Font.Assign(FTitleFont);
      Brush.Style := bsSolid;
      Pen.Style   := psSolid;

      ShowTitle := Length(Trim(FTitleText)) > 0;
      if ShowTitle then TitleHeight := TextHeight('ABC') + FTitleMargin else  TitleHeight := 0;

      if FItemList.Count <> 0 then
        begin
          TotalValue      := 0;
          for x := 0 to FItemList.Count - 1 do
            TotalValue := TotalValue + (FItemList.Objects[x] as TiPercentItemObject).Value;

          MaxTitleWidth   := 0;
          MaxValueWidth   := 0;
          MaxPercentWidth := 0;

          Font.Assign(FLegendFont);
          for x := 0 to FItemList.Count - 1 do
            begin
              iPercentItemObject  := FItemList.Objects[x] as TiPercentItemObject;

              AWidth := TextWidth(Trim(iPercentItemObject.Title));
              if AWidth > MaxTitleWidth then MaxTitleWidth := AWidth;

              AWidth := TextWidth(Format('%.' + IntToStr(FLegendValuePrecision) + 'f', [iPercentItemObject.Value]));
              if AWidth > MaxValueWidth then MaxValueWidth := AWidth;

              if TotalValue = 0 then
                AWidth := TextWidth(Format('%.' + IntToStr(FLegendPercentPrecision) + 'f', [1/FItemList.Count*100]) + '%')
              else
                AWidth := TextWidth(Format('%.' + IntToStr(FLegendPercentPrecision) + 'f', [iPercentItemObject.Value/TotalValue*100]) + '%');
              if AWidth > MaxPercentWidth then MaxPercentWidth := AWidth;
            end;

          LegendWidth := 20 + FLegendMargin + MaxTitleWidth;
          if FLegendShowPercent then LegendWidth := LegendWidth + MaxPercentWidth;
          if FLegendShowValue   then LegendWidth := LegendWidth + MaxValueWidth;

          BarCenterX := (Width - LegendWidth) div 2;
          BarHeight  := Height - 2*FOuterMargin - TitleHeight;
          BarRect    := Rect(BarCenterX - FBarWidth div 2, FOuterMargin, BarCenterX + FBarWidth - FBarWidth div 2, FOuterMargin + BarHeight);

          LegendLeft      := BarCenterX + FBarWidth div 2 + FLegendMargin;
          LegendRowHeight := TextHeight('ABC');
          LegendHeight    := (FItemList.Count * LegendRowHeight);
          YPoint          := (BarRect.Top + BarRect.Bottom) div 2 - LegendHeight div 2 + LegendRowHeight div 2;
          Font.Assign(FLegendFont);
          PreviousY := BarRect.Top;

          for x := 0 to FItemList.Count - 1 do
            begin
              iPercentItemObject   := FItemList.Objects[x] as TiPercentItemObject;
              Brush.Color          := iPercentItemObject.Color;
              Brush.Style          := bsSolid;
              Pen.Color            := iPercentItemObject.Color;

              if TotalValue = 0 then ItemPercent := 1/FItemList.Count
              else                   ItemPercent := iPercentItemObject.Value / TotalValue;

              FillRect(Rect(BarRect.Left, Round(PreviousY), BarRect.Right, Round(PreviousY + ItemPercent*BarHeight)));
              PreviousY            := PreviousY + ItemPercent*BarHeight;

              Rectangle(LegendLeft + 5, Round(YPoint - 2), LegendLeft + 15, Round(YPoint + 2)); //Color Line

              Brush.Style := bsClear;

              ATextString := Trim(iPercentItemObject.Title);
              ATextRect   := Rect(LegendLeft  + 20, YPoint - LegendRowHeight div 2, Width - 5, YPoint + LegendRowHeight div 2);
              TextOut(ATextRect.Left, ATextRect.Top, ATextString);

              if FLegendShowValue then
                begin
                  ATextString      := Format('%.' + IntToStr(FLegendValuePrecision) + 'f', [iPercentItemObject.Value]);
                  ATextRect.Left   := ATextRect.Left + MaxTitleWidth + FLegendValueMargin;
                  ATextRect.Right  := ATextRect.Left + MaxValueWidth;
                  TextOut(ATextRect.Right - TextWidth(ATextString), ATextRect.Top, ATextString);
                end
              else
                begin
                  ATextRect.Left   := ATextRect.Left + MaxTitleWidth;
                  ATextRect.Right  := ATextRect.Left;
                end;

              if FLegendShowPercent then
                begin
                  if TotalValue = 0 then
                    ATextString := Format('%.' + IntToStr(FLegendPercentPrecision) + 'f', [1/FItemList.Count*100]) + '%'
                  else
                    ATextString := Format('%.' + IntToStr(FLegendPercentPrecision) + 'f', [iPercentItemObject.Value/TotalValue*100]) + '%';
                    
                  ATextRect.Left   := ATextRect.Right + FLegendPercentMargin;
                  ATextRect.Right  := ATextRect.Left + MaxPercentWidth;
                  TextOut(ATextRect.Right - TextWidth(ATextString), ATextRect.Top, ATextString);
                end;

              YPoint := YPoint + LegendRowHeight;
            end;
        end
      else
        begin
          BarCenterX     := Width  div 2;  //Required if Item Count = 0
          BarRect.Bottom := Height div 2; //Required if Item Count = 0
        end;

      if ShowTitle then
        begin
          Font.Assign(FTitleFont);
          ATextString  := Trim(FTitleText);
          TitleCenterX := BarCenterX;
          TitleWidth   := TextWidth(FTitleText);
          case FTitleHorizontalAlignment of
            ithaCenterDisplay : TitleCenterX := BarCenterX;
            ithaCenterControl : TitleCenterX := Width div 2;
          end;
          Brush.Style := bsClear;
          TextOut(TitleCenterX - TitleWidth div 2, BarRect.Bottom + FTitleMargin, ATextString);
        end;
    end;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
function TiPercentBar.OPCNewDataSpecial(PropertyName: String; NewData: OleVariant): Boolean;
var
  x : Integer;
begin
  Result := inherited OPCNewDataSpecial(PropertyName, NewData);

  for x := 0 to FItemList.Count-1 do
    if UpperCase('Item(' + IntToStr(x) + ').Value') = UpperCase(PropertyName) then
      begin
        Result := True;
        SetItemValue(x, NewData);
      end;
end;
//****************************************************************************************************************************************************
procedure TiPercentBar.UpdateOPCSpecialList;
var
  x : Integer;
begin
  if not Assigned(OPCSpecialList) then Exit;
  OPCSpecialList.Clear;
  for x := 0 to FItemList.Count-1 do
    OPCSpecialList.Add('Item(' + IntToStr(x) + ').Value');
end;
{$endif}
//****************************************************************************************************************************************************
end.
