unit unStrGrd;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Grids, Mask, ufrmKasa, Menus;

type
  TGridHack = class(TCustomGrid);
  TStringGridHack = class(TStringGrid)
  public

  procedure DeleteRow(ARow: Longint); reintroduce;
  procedure InsertRow(ARow: Longint);
  procedure MoveColumn(FromIndex, ToIndex: Longint);
  procedure MoveRow(FromIndex, ToIndex: Longint);
  end;
  procedure grid_boyama_tek(StringGrid: TStringGrid; Rect : TRect; col:integer; row:integer);
  procedure grid_boyama(StringGrid: TStringGrid; State: TGridDrawState; Rect : TRect; col:integer; row:integer);
  procedure Resize_Column(grid_name:TStringGrid);
  procedure AutoSizeGridColumn(Grid: TStringGrid; column, min, max: Integer);
  procedure ResizeStringGrid(_Grid: TCustomGrid);
  procedure GridDeleteRow(RowNumber: Integer; Grid: TstringGrid);
  procedure Display(StringGrid: TStringGrid; const S: string; Alignment: TAlignment; Sekil:TRect;Font_Name:String; Font_Size:Integer; Font_Style:TFontStyles; Font_Color:TColor;ozellik:boolean);
  procedure WriteText(StringGrid: TStringGrid; ACanvas: TCanvas; const ARect: TRect; const Text: string; Format: Word; Font_Name:String; Font_Size:Integer; Font_Style:TFontStyles; Font_Color:TColor;ozellik:Boolean);

implementation

procedure TStringGridHack.MoveColumn(FromIndex, ToIndex: Integer);
begin
  inherited;
end;

procedure TStringGridHack.MoveRow(FromIndex, ToIndex: Integer);
begin
  inherited;
end;


procedure TStringGridHack.DeleteRow(ARow: Longint);
var
  GemRow: Integer;
begin
  GemRow := Row;
  if RowCount > FixedRows + 1 then
    inherited DeleteRow(ARow)
  else
    Rows[ARow].Clear;
  if GemRow < RowCount then Row := GemRow;
end;

procedure TStringGridHack.InsertRow(ARow: Longint);
var
  GemRow: Integer;
begin
  GemRow := Row;
  while ARow < FixedRows do Inc(ARow);
  RowCount := RowCount + 1;
  MoveRow(RowCount - 1, ARow);
  Row := GemRow;
  Rows[Row].Clear;
end;

procedure GridDeleteRow(RowNumber: Integer; Grid: TstringGrid);
var
  i: Integer;
begin
  Grid.Row := RowNumber;
  if (Grid.Row = Grid.RowCount - 1) then
    { On the last row}
    Grid.RowCount := Grid.RowCount - 1
  else
  begin
    { Not the last row}
    for i := RowNumber to Grid.RowCount - 1 do
      Grid.Rows[i] := Grid.Rows[i + 1];
    Grid.RowCount := Grid.RowCount - 1;
  end;
end;

procedure AutoSizeGridColumn(Grid: TStringGrid; column, min, max: Integer);
    { Set for max and min some minimal/maximial Values}
    { Bei max and min kann eine Minimal- resp. Maximalbreite angegeben werden}
  var
    i: Integer;
    temp: Integer;
    tempmax: Integer;
  begin
    tempmax := 0;
    for i := 0 to (Grid.RowCount - 1) do
    begin
      temp := Grid.Canvas.TextWidth(Grid.cells[column, i]);
      if temp > tempmax then tempmax := temp;
      if tempmax > max then
      begin
        tempmax := max;
        break;
      end;
    end;
    if tempmax < min then tempmax := min;
    Grid.ColWidths[column] := tempmax + Grid.GridLineWidth + 3;
  end;

  //aþaðýdaki prosedür tüm stringgridin size'ýný ayarlar.
procedure ResizeStringGrid(_Grid: TCustomGrid);
var
  Col, Row: integer;
  Grid: TGridHack;
  MaxWidth: integer;
  ColWidth: integer;
  ColText: string;
  MaxRow: integer;
  ColWidths: array of integer;
begin
  Grid := TGridHack(_Grid);
  SetLength(ColWidths, Grid.ColCount);
  MaxRow := 13;
  if MaxRow > Grid.RowCount then
    MaxRow := Grid.RowCount;
  for Col := 0 to Grid.ColCount - 1 do
  begin
    MaxWidth := 0;
    for Row := 0 to MaxRow - 1 do
    begin
      ColText  := Grid.GetEditText(Col, Row);
      ColWidth := Grid.Canvas.TextWidth(ColText);
      if ColWidth > MaxWidth then
        MaxWidth := ColWidth;
    end;
    if goVertLine in Grid.Options then
      Inc(MaxWidth, Grid.GridLineWidth);
    ColWidths[Col]      := MaxWidth + 4;
    Grid.ColWidths[Col] := ColWidths[Col];
  end;
end;




//bu prosedür üzerine týklanýlan aktif kolonu resize eder.
procedure Resize_Column(grid_name:TStringGrid);
var
   P: TPoint;
   iColumn, iRow: Longint;
begin
    GetCursorPos(P);
    with grid_name do
    begin
      P := ScreenToClient(P);
      MouseToCell(P.X, P.Y, iColumn, iRow);
      if P.Y < DefaultRowHeight then
        //eskisi
        //AutoSizeGridColumn(grid_name, iColumn, 40, 100);
        AutoSizeGridColumn(grid_name, iColumn, 10, 250);
    end;
end;


procedure Display(StringGrid: TStringGrid; const S: string; Alignment: TAlignment; Sekil:TRect;Font_Name:String; Font_Size:Integer; Font_Style:TFontStyles; Font_Color:TColor;ozellik:Boolean);
const
  Formats: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
begin
//  WriteText(StringGrid, StringGrid.Canvas, Sekil, S, Formats[Alignment],'Tahoma',8,[fsBold],clBlue);
  WriteText(StringGrid, StringGrid.Canvas, Sekil, S, Formats[Alignment],Font_Name,Font_Size,Font_Style,Font_Color,ozellik);
end;


procedure WriteText(StringGrid: TStringGrid; ACanvas: TCanvas; const ARect: TRect; const Text: string; Format: Word; Font_Name:String; Font_Size:Integer; Font_Style:TFontStyles; Font_Color:TColor;ozellik:Boolean);
const
  DX = 2;
  DY = 2;
var
  S: array[0..255] of Char;
//  B, R: TRect;
begin
  ACanvas.Font.Name := Font_Name;
  ACanvas.Font.Size := Font_Size;
  if ozellik then ACanvas.Font.Style := Font_Style;
  ACanvas.Font.Color := Font_Color;
  with Stringgrid, ACanvas, ARect do
  begin
    case Format of
      DT_LEFT:
              begin
                ExtTextOut(Handle, Left + DX, Top + DY,
                ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
              end;
      DT_RIGHT:
               begin
                 ExtTextOut(Handle, Right - TextWidth(Text) - 3, Top + DY,
                 ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text),
                 Length(Text), nil);
               end;

      DT_CENTER:
                begin
                  ExtTextOut(Handle, Left + (Right - Left - TextWidth(Text)) div 2,
                  Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect,
                  StrPCopy(S, Text), Length(Text), nil);
                end;
    end;
  end;
end;

procedure grid_boyama(StringGrid: TStringGrid; State: TGridDrawState; Rect : TRect; col:integer; row:integer);
const
 LM = 3; {each indiviual cell's left margin}
 TM = 2; {each indiviual cell's top margin}
begin
 if gdFixed in State then {draw fixed columns , fixed}
    StringGrid.Canvas.Brush.Color := clYellow;
 if (gdSelected in State) then {draw selected cell , normal}
   begin
     StringGrid.Canvas.Brush.Color := clBlack;
     StringGrid.Canvas.Font.Color := clRed;
   end;
 {finally, do the actual cell drawing}
 StringGrid.Canvas.TextRect(Rect, Rect.Left + LM, Rect.Top + TM, StringGrid.Cells[col,row]);
end;

procedure grid_boyama_tek(StringGrid: TStringGrid; Rect : TRect; col:integer; row:integer);
const
 LM = 3; {each indiviual cell's left margin}
 TM = 2; {each indiviual cell's top margin}
begin
 //if gdFixed in State then {draw fixed columns , fixed}
 //   StringGrid.Canvas.Brush.Color := clYellow;
 //if (gdSelected in State) then {draw selected cell , normal}
 //  begin
     StringGrid.Canvas.Brush.Color := clBlack;
     StringGrid.Canvas.Font.Color := clRed;
  // end;
 {finally, do the actual cell drawing}
 StringGrid.Canvas.TextRect(Rect, Rect.Left + LM, Rect.Top + TM, StringGrid.Cells[col,row]);
end;



end.
