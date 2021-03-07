{*******************************************************}
{                                                       }
{       TiPlotTable                                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotTable;{$endif}
{$ifdef iCLX}unit QiPlotTable;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iPlotObjects,  iPlotChannelCustom;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiPlotObjects, QiPlotChannelCustom;{$ENDIF}

type
  TiPlotTableButton = class(TiPlotButton)
  public
    procedure Draw(const Canvas: TCanvas; const BackGroundColor: TColor); override;
  end;

  TiPlotTableColumn = class(TObject)
  protected
    WidthPixels          : Integer;
  public
    Title                : String;
    Width                : Double;
    Visible              : Boolean;
    TitleAlignment       : TiAlignmentHorizontal;
    TitleAlignmentMargin : Double;
    TitleFontColor       : TColor;
    DataAlignment        : TiAlignmentHorizontal;
    DataAlignmentMargin  : Double;
    DataFontColor        : TColor;
    AutoSize             : Boolean;
  end;

  TiPlotTable = class(TiPlotLayoutObject)
  private
    FUpButton                  : TiPlotTableButton;
    FDownButton                : TiPlotTableButton;
    FRequiredWidth             : Integer;
    FRequiredHeight            : Integer;

    FColumnList                : TStringList;
    FRowDataList               : TStringList;
    FTempStringList            : TStringList;

    FItemViewStartIndex        : Integer;
    FItemViewStopIndex         : Integer;
    FRowHeight                 : Integer;

    FMarginLeft                : Double;
    FMarginRight               : Double;
    FMarginBottom              : Double;
    FMarginTop                 : Double;
    FGridBackGroundTransparent : Boolean;
    FGridBackGroundColor       : TColor;
    FGridLinesShow             : Boolean;
    FGridLinesColor            : TColor;

    FColumnSpacing             : Double;
    FRowSpacing                : Double;
    FRowsMax                   : Integer;
    FDataFont                  : TFont;

    FGridRect                  : TRect;
    FTitleRect                 : TRect;

    FColumnTitlesVisible       : Boolean;
    FColumnTitlesFont          : TFont;
  protected
    procedure SetMarginBottom             (const Value: Double);
    procedure SetMarginLeft               (const Value: Double);
    procedure SetMarginRight              (const Value: Double);
    procedure SetMarginTop                (const Value: Double);
    procedure SetGridBackGroundColor      (const Value: TColor);
    procedure SetGridBackGroundTransparent(const Value: Boolean);
    procedure SetDataFont                 (const Value: TFont);
    procedure SetColumnSpacing            (const Value: Double);
    procedure SetRowSpacing               (const Value: Double);
    procedure SetColumnTitlesFont         (const Value: TFont);
    procedure SetColumnTitlesVisible      (const Value: Boolean);
    procedure SetGridLinesShow            (const Value: Boolean);
    procedure SetGridLinesColor           (const Value: TColor);
    procedure SetRowsMax                  (const Value: Integer);

    procedure CalcRects(Canvas : TCanvas);

    function  GetColumn     (Index: Integer): TiPlotTableColumn;

    function  GetColumnCount: Integer;
    function  GetRowCount   : Integer;

    function  GetData       (Col, Row: Integer): String;
    procedure SetData       (Col, Row: Integer; const Value: String);

    procedure ButtonInvalidate(Sender : TObject);
    procedure UpButtonClick   (Sender : TObject);
    procedure DownButtonClick (Sender : TObject);

    procedure NotificationSetFocus(Sender: TObject);                                                                  override;

    function  GetMouseObject(X, Y: Integer): TiPlotObject;                                                            override;
    function  GetRequiredWidth(const Canvas: TCanvas): Integer;                                                       override;
    procedure AddMenuItems(PopupMenu: TPopUpMenu);                                                                    override;

    procedure DoMouseUp         (MouseData: TiPlotMouseData);                                                         override;

    procedure Draw            (const Canvas: TCanvas; const BackGroundColor: TColor);                                 override;
    procedure DrawGrid        (const Canvas: TCanvas);
    procedure DrawColumnTitles(const Canvas: TCanvas);
    procedure DrawData        (const Canvas: TCanvas);
    procedure DrawDownButton  (const Canvas: TCanvas);
    procedure DrawUpButton    (const Canvas: TCanvas);

  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);              override;
    destructor  Destroy;                                                                                            override;

    function AddColumn(Title: String): Integer;
    function AddRow: Integer;

    procedure RemoveAllColumns;
    procedure RemoveAllRows;

    procedure DeleteColumn(Index: Integer);
    procedure DeleteRow   (Index: Integer);

    property RowCount                   : Integer read GetRowCount;
    property ColumnCount                : Integer read GetColumnCount;

    property Column[Index: Integer]     : TiPlotTableColumn read GetColumn;

    property Data[Col, Row: Integer]    : String  read GetData                    write SetData;
    property RowDisplayStartIndex       : Integer read FItemViewStartIndex        write FItemViewStartIndex;
  published
    property MarginLeft                 : Double  read FMarginLeft                write SetMarginLeft;
    property MarginTop                  : Double  read FMarginTop                 write SetMarginTop;
    property MarginRight                : Double  read FMarginRight               write SetMarginRight;
    property MarginBottom               : Double  read FMarginBottom              write SetMarginBottom;

    property GridBackGroundColor        : TColor  read FGridBackGroundColor       write SetGridBackGroundColor       default clGray;
    property GridBackGroundTransparent  : Boolean read FGridBackGroundTransparent write SetGridBackGroundTransparent default False;
    property GridLinesColor             : TColor  read FGridLinesColor            write SetGridLinesColor;
    property GridLinesShow              : Boolean read FGridLinesShow             write SetGridLinesShow;

    property DataFont                   : TFont   read FDataFont                  write SetDataFont;

    property ColumnSpacing              : Double  read FColumnSpacing             write SetColumnSpacing;
    property RowSpacing                 : Double  read FRowSpacing                write SetRowSpacing;
    property RowsMax                    : Integer read FRowsMax write SetRowsMax;

    property ColumnTitlesVisible        : Boolean read FColumnTitlesVisible       write SetColumnTitlesVisible       default False;
    property ColumnTitlesFont           : TFont   read FColumnTitlesFont          write SetColumnTitlesFont;
  end;

implementation

uses
{$ifdef iVCL} iPlotManagers,  iPlotComponent;{$endif}
{$ifdef iCLX}QiPlotManagers, QiPlotComponent;{$endif}

type
  TiPlotComponentAccess = class(TiPlotComponent)end;
//****************************************************************************************************************************************************
constructor TiPlotTable.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited;

  FMarginLeft    := 1;
  FMarginRight   := 1;
  FMarginBottom  := 1;
  FMarginTop     := 1;

  FGridBackGroundColor       := clGray;
  FGridBackGroundTransparent := False;
  FGridLinesColor            := clWhite;
  FGridLinesShow             := True;
  FColumnSpacing             := 2;
  FRowSpacing                := 0.5;
  FColumnTitlesVisible       := True;

  Horizontal                 := False;

  FRowDataList    := TStringList.Create;
  FColumnList     := TStringList.Create;
  FTempStringList := TStringList.Create;

  FDataFont         := TFont.Create; FDataFont.OnChange         := TriggerChange; FDataFont.Color         := clWhite; FDataFont.Style         := [fsBold];
  FColumnTitlesFont := TFont.Create; FColumnTitlesFont.OnChange := TriggerChange; FColumnTitlesFont.Color := clAqua;  FColumnTitlesFont.Style := [fsBold];

  FUpButton   := TiPlotTableButton.Create(Owner, nil, nil, nil, nil);
  with FUpButton do
    begin
      Name         := 'PlotTableUpButton';
      TimerEnabled := True;
      OnClick      := UpButtonClick;
      OnInvalidate := ButtonInvalidate;
    end;

  FDownButton := TiPlotTableButton.Create(Owner, nil, nil, nil, nil);
  with FDownButton do
    begin
      Name         := 'PlotTableDownButton';
      TimerEnabled := True;
      OnClick      := DownButtonClick;
      OnInvalidate := ButtonInvalidate;
    end;
end;
//****************************************************************************************************************************************************
destructor TiPlotTable.Destroy;
begin
  FRowDataList.Free;

  RemoveAllColumns;
  FColumnList.Free;

  FDataFont.Free;
  FColumnTitlesFont.Free;

  FTempStringList.Free;

  FUpButton.Free;
  FDownButton.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.AddMenuItems(PopupMenu: TPopUpMenu);
begin
  inherited AddMenuItems(PopupMenu);
  AddEditMenuItems(PopupMenu);
end;
//****************************************************************************************************************************************************
function TiPlotTable.GetMouseObject(X, Y: Integer): TiPlotObject;
begin
  Result := inherited GetMouseObject(X, Y);

  if      PtInRect(FUpButton.DrawRect,   Point(X, Y)) then Result := FUpButton
  else if PtInRect(FDownButton.DrawRect, Point(X, Y)) then Result := FDownButton
  else
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.SetMarginBottom             (const Value:Double );begin SetDoubleProperty (Value,FMarginBottom,             TriggerChange);end;
procedure TiPlotTable.SetMarginLeft               (const Value:Double );begin SetDoubleProperty (Value,FMarginLeft,               TriggerChange);end;
procedure TiPlotTable.SetMarginRight              (const Value:Double );begin SetDoubleProperty (Value,FMarginRight,              TriggerChange);end;
procedure TiPlotTable.SetMarginTop                (const Value:Double );begin SetDoubleProperty (Value,FMarginTop,                TriggerChange);end;
procedure TiPlotTable.SetGridBackGroundColor      (const Value:TColor );begin SetColorProperty  (Value,FGridBackGroundColor,      TriggerChange);end;
procedure TiPlotTable.SetGridBackGroundTransparent(const Value:Boolean);begin SetBooleanProperty(Value,FGridBackGroundTransparent,TriggerChange);end;
procedure TiPlotTable.SetColumnSpacing            (const Value:Double );begin SetDoubleProperty (Value,FColumnSpacing,            TriggerChange);end;
procedure TiPlotTable.SetRowSpacing               (const Value:Double );begin SetDoubleProperty (Value,FRowSpacing,               TriggerChange);end;
procedure TiPlotTable.SetColumnTitlesVisible      (const Value:Boolean);begin SetBooleanProperty(Value,FColumnTitlesVisible,      TriggerChange);end;
procedure TiPlotTable.SetGridLinesShow            (const Value:Boolean);begin SetBooleanProperty(Value,FGridLinesShow,            TriggerChange);end;
procedure TiPlotTable.SetGridLinesColor           (const Value:TColor );begin SetColorProperty  (Value,FGridLinesColor,           TriggerChange);end;
procedure TiPlotTable.SetRowsMax                  (const Value:Integer);begin SetIntegerProperty(Value,FRowsMax,                  TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotTable.SetDataFont        (const Value:TFont);begin FDataFont.Assign(Value);        end;
procedure TiPlotTable.SetColumnTitlesFont(const Value:TFont);begin FColumnTitlesFont.Assign(Value);end;
//****************************************************************************************************************************************************
function TiPlotTable.GetColumn(Index: Integer): TiPlotTableColumn;
begin
  Result := FColumnList.Objects[Index] as TiPlotTableColumn;
end;
//****************************************************************************************************************************************************
function TiPlotTable.GetColumnCount: Integer;
begin
  Result := FColumnList.Count;
end;
//****************************************************************************************************************************************************
function TiPlotTable.AddColumn(Title: String): Integer;
var
  iPlotTableColumnObject : TiPlotTableColumn;
begin
  iPlotTableColumnObject                      := TiPlotTableColumn.Create;
  iPlotTableColumnObject.Visible              := True;
  iPlotTableColumnObject.AutoSize             := True;
  iPlotTableColumnObject.Title                := Title;
  iPlotTableColumnObject.TitleAlignment       := iahCenter;
  iPlotTableColumnObject.TitleAlignmentMargin := 1;
  iPlotTableColumnObject.TitleFontColor       := ColumnTitlesFont.Color;
  iPlotTableColumnObject.DataAlignment        := iahCenter;
  iPlotTableColumnObject.DataAlignmentMargin  := 1;
  iPlotTableColumnObject.DataFontColor        := DataFont.Color;
  iPlotTableColumnObject.Width                := 10;
  Result := FColumnList.AddObject('', iPlotTableColumnObject);
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.DeleteColumn(Index: Integer);
begin
  FColumnList.Objects[Index].Free;
  FColumnList.Delete(Index);
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.RemoveAllColumns;
begin
  while FColumnList.Count <> 0 do
    DeleteColumn(0);
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.CalcRects(Canvas: TCanvas);
var
  Col                : Integer;
  Row                : Integer;
  ACharWidth         : Integer;
  ACharHeight        : Integer;
  MarginTopPixels    : Integer;
  MarginBottomPixels : Integer;
  MarginLeftPixels   : Integer;
  MarginRightPixels  : Integer;
  NewMax             : Integer;
  AText              : String;
  ColSpacingPixels   : Integer;
  RowSpacingPixels   : Integer;
  FirstRowCenterY    : Integer;
  LastRowCenterY     : Integer;
  ActualRows         : Integer;
begin
  if (RowCount = 0) or (ColumnCount = 0) then
    begin
      FRequiredHeight := 0;
      FRequiredWidth  := 0;
      Exit;
    end;

  with Canvas, DrawRect do
    begin
      Font.Assign(FColumnTitlesFont);

      ACharWidth         := TextWidth ('0');
      ACharHeight        := TextHeight('0');

      MarginTopPixels    := Round(FMarginTop   *ACharHeight);
      MarginBottomPixels := Round(FMarginBottom*ACharHeight);
      MarginLeftPixels   := Round(FMarginLeft  *ACharWidth);
      MarginRightPixels  := Round(FMarginRight *ACharWidth);

      FGridRect.Left   := Left  + MarginLeftPixels;
      FGridRect.Right  := Right - MarginRightPixels;
      FGridRect.Top    := Top   + MarginTopPixels;
      FGridRect.Bottom := Bottom - MarginBottomPixels;

      if FColumnTitlesVisible then FTitleRect := Rect(FGridRect.Left, FGridRect.Top, FGridRect.Right, FGridRect.Top + ACharHeight)
      else                         FTitleRect := Rect(FGridRect.Left, FGridRect.Top, FGridRect.Right, FGridRect.Top);

      Font.Assign(FDataFont);
      ACharWidth  := TextWidth ('0');
      ACharHeight := TextHeight('0');

      RowSpacingPixels := Round(ACharHeight*FRowSpacing);
      FRowHeight       := RowSpacingPixels + ACharHeight;

      FRequiredHeight := MarginTopPixels  + MarginBottomPixels + FTitleRect.Bottom - FTitleRect.Top;

      if (FRowsMax <> 0) and (RowCount > FRowsMax) then
        begin
          ActualRows := FRowsMax;
          FGridRect.Bottom := FTitleRect.Bottom + (RowsMax)*FRowHeight;
          FRequiredHeight  := FRequiredHeight + (RowsMax)*FRowHeight;
        end
      else
        begin
          ActualRows := RowCount;
          FGridRect.Bottom := FTitleRect.Bottom + (RowCount)*FRowHeight;
          FRequiredHeight  := FRequiredHeight + (RowCount)*FRowHeight;
        end;

      FRequiredWidth  := MarginLeftPixels + MarginRightPixels;

      for Col := 0 to ColumnCount-1 do
        begin
          if not Column[Col].Visible then Continue;
          if Column[Col].AutoSize then
            begin
              NewMax := 0;
              Font.Assign(FColumnTitlesFont);
              ACharWidth  := TextWidth ('0');
              ColSpacingPixels := Round(ACharWidth*FColumnSpacing);
              if (TextWidth(Column[Col].Title) + ColSpacingPixels + ACharWidth) > NewMax then NewMax := TextWidth(Column[Col].Title) + ColSpacingPixels + ACharWidth;

              Font.Assign(FDataFont);
              ACharWidth  := TextWidth ('0');
              ColSpacingPixels := Round(ACharWidth*FColumnSpacing);
              for Row := 0 to FRowDataList.Count-1 do
                begin
                  AText := Data[Col, Row];
                  if (TextWidth(AText) + ColSpacingPixels + ACharWidth) > NewMax then NewMax := TextWidth(AText) + ColSpacingPixels + ACharWidth;
                end;
              Column[Col].WidthPixels := NewMax;
              Column[Col].Width       := NewMax div ACharWidth;
            end
          else
            begin
              Column[Col].WidthPixels := Round(ACharWidth * Column[Col].Width);
            end;

          FRequiredWidth := FRequiredWidth + Column[Col].WidthPixels;
        end;

      FGridRect.Right := FGridRect.Left + FRequiredWidth - MarginRightPixels - MarginLeftPixels;
      
      if FGridRect.Bottom > (Bottom - MarginBottomPixels) then
        begin
          ActualRows       := (Bottom - MarginBottomPixels - FTitleRect.Bottom) div FRowHeight;
          FGridRect.Bottom := FTitleRect.Bottom + ActualRows * FRowHeight;
        end;

      if RowCount > ActualRows then
        begin
          FirstRowCenterY := FTitleRect.Bottom + FRowHeight div 2;
          LastRowCenterY  := FTitleRect.Bottom + ActualRows * FRowHeight - FRowHeight div 2;

          if Enabled then
            begin
              FUpButton.DrawRect   := Rect(FGridRect.Right + 5, FirstRowCenterY - 8, FGridRect.Right + 5 + 17, FirstRowCenterY + 9);
              FDownButton.DrawRect := Rect(FGridRect.Right + 5, LastRowCenterY  - 8, FGridRect.Right + 5 + 17, LastRowCenterY  + 9);

              FUpButton.Visible   := True;
              FDownButton.Visible := True;

              FRequiredWidth      := FRequiredWidth + FUpButton.Width + 5;
            end
          else
            begin
              FUpButton.Visible   := True;
              FDownButton.Visible := True;
            end;

          FItemViewStopIndex := FItemViewStartIndex + ActualRows -1;

          if FItemViewStopIndex > (RowCount-1) then
            begin
              FItemViewStopIndex  := RowCount-1;
              FItemViewStartIndex := FItemViewStopIndex - (ActualRows-1);
            end;

          if FItemViewStartIndex < 0 then
            begin
              FItemViewStartIndex := 0;
              FItemViewStopIndex  := ActualRows-1;
            end;
        end
      else
        begin
          FUpButton.Visible   := False;
          FDownButton.Visible := False;

          FItemViewStartIndex := 0;
          FItemViewStopIndex  := ActualRows-1;
        end;


      FUpButton.Enabled   := FItemViewStartIndex <> 0;
      FDownButton.Enabled := FItemViewStopIndex <> (RowCount -1);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
begin
  if not Visible                         then Exit;
  if (RowCount = 0) or (ColumnCount = 0) then Exit;

  CalcRects(Canvas);

  with Canvas, DrawRect do
    begin
      Brush.Style := bsSolid;
      Pen.Style   := psSolid;

      if not FGridBackGroundTransparent then
        begin
          Brush.Color := FGridBackGroundColor;
          FillRect(FGridRect);
        end;

      DrawGrid        (Canvas);
      DrawColumnTitles(Canvas);
      DrawData        (Canvas);

      Font.Color := $FFEEDD; //Borland Bug Hack.
      Font.Assign(FDataFont);
      Brush.Style := bsClear;
    end;

  DrawUpButton  (Canvas);
  DrawDownButton(Canvas);

  if UserSelected then
    begin
      Canvas.Brush.Style := bsClear;
      Canvas.Font.Color := clWhite;
      if Horizontal then iDrawFocusRect2(Canvas, Rect(DrawRect.Left,   DrawRect.Top+2, DrawRect.Right,   DrawRect.Bottom-2))
        else             iDrawFocusRect2(Canvas, Rect(DrawRect.Left, DrawRect.Top,   DrawRect.Right, DrawRect.Bottom  ))
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.DrawGrid(const Canvas: TCanvas);
var
  x          : Integer;
  CurrentPos : Integer;
begin
  if not FGridLinesShow then Exit;

  with Canvas do
    begin
      Pen.Style := psSolid;
      Pen.Width := 1;
      Pen.Color := FGridLinesColor;

      //Vertical Lines
      CurrentPos := FGridRect.Left;
      for x := 0 to ColumnCount-1 do
        begin
          if not Column[x].Visible then Continue;
          Polyline([Point(CurrentPos, FGridRect.Top), Point(CurrentPos, FGridRect.Bottom)]);
          CurrentPos := CurrentPos + Column[x].WidthPixels;
        end;

      Polyline([Point(CurrentPos, FGridRect.Top), Point(CurrentPos, FGridRect.Bottom)]);

      //Horizontal Lines
      CurrentPos := FGridRect.Top;
      Polyline([Point(FGridRect.Left, CurrentPos), Point(FGridRect.Right+1, CurrentPos)]);

      CurrentPos := FTitleRect.Bottom;
      for x := FItemViewStartIndex to FItemViewStopIndex do
        begin
          Polyline([Point(FGridRect.Left, CurrentPos), Point(FGridRect.Right+1, CurrentPos)]);
          CurrentPos := CurrentPos + FRowHeight;
        end;

      Polyline([Point(FGridRect.Left, CurrentPos), Point(FGridRect.Right+1, CurrentPos)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.DrawColumnTitles(const Canvas: TCanvas);
var
  x           : Integer;
  CurrentLeft : Integer;
  ARect       : TRect;
  ACharWidth  : Integer;
begin
  if not FColumnTitlesVisible then Exit;

  with Canvas do
    begin
      Font.Assign(FColumnTitlesFont);
      Brush.Style := bsClear;

      ACharWidth  := TextWidth ('0');

      CurrentLeft := FGridRect.Left;

      for x := 0 to ColumnCount-1 do
        begin
          if not Column[x].Visible then Continue;

          Font.Color := Column[x].TitleFontColor;

          ARect := Rect(CurrentLeft, FTitleRect.Top, CurrentLeft + Column[x].WidthPixels, FTitleRect.Bottom);

          case Column[x].TitleAlignment of
            iahCenter : iDrawText(Canvas, Column[x].Title, ARect, [itfHCenter, itfVCenter, itfSingleLine], True, GridBackGroundColor);
            iahLeft   : begin
                          ARect.Left := ARect.Left + Round(Column[x].TitleAlignmentMargin * ACharWidth);
                          iDrawText(Canvas, Column[x].Title, ARect, [itfHLeft, itfVCenter, itfSingleLine], True, GridBackGroundColor);
                        end;
            iahRight  : begin
                          ARect.Right := ARect.Right - Round(Column[x].TitleAlignmentMargin * ACharWidth);
                          iDrawText(Canvas, Column[x].Title, ARect, [itfHRight, itfVCenter, itfSingleLine], True, GridBackGroundColor);
                        end;
          end;

          CurrentLeft := CurrentLeft + Column[x].WidthPixels;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.DrawData(const Canvas: TCanvas);
var
  Row, Col    : Integer;
  CurrentLeft : Integer;
  CurrentTop  : Integer;
  ARect       : TRect;
  ACharWidth  : Integer;
begin
  with Canvas do
    begin
      Font.Assign(FDataFont);
      Brush.Style := bsClear;

      ACharWidth  := TextWidth ('0');

      CurrentTop := FTitleRect.Bottom;

      for Row := FItemViewStartIndex to FItemViewStopIndex do
        begin
          CurrentLeft := FGridRect.Left;

          for Col := 0 to ColumnCount-1 do
            begin
              if not Column[Col].Visible then Continue;
              Font.Color := Column[Col].DataFontColor;

              ARect := Rect(CurrentLeft, CurrentTop, CurrentLeft + Column[Col].WidthPixels, CurrentTop + FRowHeight);

              case Column[Col].DataAlignment of
                iahCenter : iDrawText(Canvas, Data[Col, Row], ARect, [itfHCenter, itfVCenter, itfSingleLine], True, GridBackGroundColor);
                iahLeft   : begin
                              ARect.Left := ARect.Left + Round(Column[Col].DataAlignmentMargin * ACharWidth);
                              iDrawText(Canvas, Data[Col, Row], ARect, [itfHLeft, itfVCenter, itfSingleLine], True, GridBackGroundColor);
                            end;
                iahRight  : begin
                              ARect.Right := ARect.Right - Round(Column[Col].DataAlignmentMargin * ACharWidth);
                              iDrawText(Canvas, Data[Col, Row], ARect, [itfHRight, itfVCenter, itfSingleLine], True, GridBackGroundColor);
                            end;
              end;

              CurrentLeft := CurrentLeft + Column[Col].WidthPixels;
            end;
          CurrentTop := CurrentTop + FRowHeight;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.DrawUpButton(const Canvas: TCanvas);
var
  CenterPoint : TPoint;
begin
  if not FUpButton.Visible then Exit;
  with Canvas do
    begin
      FUpButton.Draw(Canvas, GridBackGroundColor);

      if FUpButton.Enabled then
        begin
          Pen.Color   := clBlack;
          Brush.Color := clBlack;
        end
      else
        begin
          Pen.Color   := clGray;
          Brush.Color := clGray;
        end;

      CenterPoint.X := (FUpButton.Left   + FUpButton.Right) div 2;
      CenterPoint.Y := (FUpButton.Bottom + FUpButton.Top  ) div 2;

      Polygon([Point(CenterPoint.x - 4, CenterPoint.y + 2),
               Point(CenterPoint.x + 4, CenterPoint.y + 2),
               Point(CenterPoint.x,     CenterPoint.y - 2)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.DrawDownButton(const Canvas: TCanvas);
var
  CenterPoint : TPoint;
begin
  if not FDownButton.Visible then Exit;
  with Canvas do
    begin
      FDownButton.Draw(Canvas, GridBackGroundColor);

      if FDownButton.Enabled then
        begin
          Pen.Color   := clBlack;
          Brush.Color := clBlack;
        end
      else
        begin
          Pen.Color   := clGray;
          Brush.Color := clGray;
        end;

      CenterPoint.X := (FDownButton.Left   + FDownButton.Right) div 2;
      CenterPoint.Y := (FDownButton.Bottom + FDownButton.Top  ) div 2;

      Polygon([Point(CenterPoint.x - 4, CenterPoint.y - 2),
               Point(CenterPoint.x + 4, CenterPoint.y - 2),
               Point(CenterPoint.x,     CenterPoint.y + 2)]);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotTable.GetRequiredWidth(const Canvas: TCanvas) : Integer;
begin
  CalcRects(Canvas);
  if Horizontal then Result := FRequiredHeight else Result := FRequiredWidth;
end;
//****************************************************************************************************************************************************
{ TiPlotTableButton }
//****************************************************************************************************************************************************
procedure TiPlotTableButton.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  ARect : TRect;
begin
  if not Visible then exit;
  with Canvas do
    begin
      ARect       := DrawRect;
      Brush.Color := clBtnFace;
      FillRect(ARect);

      if MouseDown then
        iDrawEdge(Canvas, ARect, idesSunken)
      else
        iDrawEdge(Canvas, ARect, idesRaised);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.ButtonInvalidate(Sender: TObject);
begin
  TriggerInvalidateNow(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.DownButtonClick(Sender: TObject);
begin
  if FItemViewStartIndex < FRowDataList.Count-1 then FItemViewStartIndex := FItemViewStartIndex + 1;
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.UpButtonClick(Sender: TObject);
begin
  if FItemViewStartIndex > 0 then FItemViewStartIndex := FItemViewStartIndex - 1;
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.NotificationSetFocus(Sender: TObject);
begin
  if Sender = Self                              then Exit;
  if not (Sender as TiPlotObject).UserSelected  then Exit;

  SetUserSelected(False);
end;
//***************************************************************************************************************************************************
procedure TiPlotTable.DoMouseUp(MouseData: TiPlotMouseData);
begin
  if not MouseDown then Exit;

  if PtInRect(DrawRect, Point(MouseData.X, MouseData.Y)) then TiPlotComponentAccess(Owner).DoObjectClick(Self);
end;
//****************************************************************************************************************************************************
function TiPlotTable.AddRow: Integer;
begin
  Result := FRowDataList.Add('');
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.DeleteRow(Index: Integer);
begin
  FRowDataList.Delete(Index);
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
function TiPlotTable.GetRowCount: Integer;
begin
  Result := FRowDataList.Count;
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.RemoveAllRows;
begin
  FRowDataList.Clear;
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
function TiPlotTable.GetData(Col, Row: Integer): String;
var
  RowString : String;
begin
  RowString := FRowDataList.Strings[Row];

  FTempStringList.Text := RowString;
  while FTempStringList.Count < ColumnCount do
    FTempStringList.Add('');

  Result := FTempStringList.Strings[Col];
end;
//****************************************************************************************************************************************************
procedure TiPlotTable.SetData(Col, Row: Integer; const Value: String);
var
  RowString : String;
begin
  RowString := FRowDataList.Strings[Row];

  FTempStringList.Text := RowString;
  while FTempStringList.Count < ColumnCount do
    FTempStringList.Add('');

  FTempStringList.Strings[Col] := Value;

  FRowDataList.Strings[Row] := FTempStringList.Text;
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
end.
