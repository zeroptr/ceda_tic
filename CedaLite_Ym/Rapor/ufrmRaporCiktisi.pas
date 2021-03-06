unit ufrmRaporCiktisi;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  Menus, ImgList,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPSBaseGridLnk,
  dxPScxSSLnk, cxControls, cxSSheet,cxSSTypes,dxPgsDlg, ComCtrls, ToolWin,
  dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,CxDrawTextUtils;

type
  TfrmRaporCiktisi = class(TForm)
    ImageList1: TImageList;
    SaveDialog: TSaveDialog;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton8: TToolButton;
    ToolButton1: TToolButton;
    ToolButton14: TToolButton;
    ToolButton3: TToolButton;
    dxComponentPrinter1: TdxComponentPrinter;
    dxComponentPrinter1Link1: TdxSpreadSheetBookReportLink;
    ToolButton4: TToolButton;
    grdA: TcxSpreadSheetBook;
  procedure FormClose(Sender: TObject; var Action: TCloseAction);
  procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
  procedure ToolButton2Click(Sender: TObject);
  procedure ToolButton3Click(Sender: TObject);
//*******************user defined procedure and functions***********************
//******************************************************************************
//******************************************************************************
  procedure form_open();
  procedure Rapor_Ayarlari(Tip: Integer);  
  function Tarih_Karsilastir(const A, B: TDateTime): Byte;
  Function Date_MoveNDays(DateValue:TDateTime;DateMovement:Integer):TDateTime;
  Function Date_NextDay(DateValue: TDateTime): TDateTime;
  Function Date_PriorDay(DateValue: TDateTime): TDateTime;
  procedure format_ayarla_dov(FCol,FRow,ECol,ERow:Integer);
  procedure format_ayarla(FCol,FRow,ECol,ERow:Integer);
  procedure Formatla(ARow,ACol: Integer);
  function GetCellDeger(ARow, ACol: Integer): Currency;
  procedure SetCellText(ARow, ACol : Integer; AText : String);OverLoad;

  function GetCellText(ARow, ACol : Integer):String;
  procedure SetCellDate(ACol, ARow : Integer; ADate : TDateTime);
  procedure SetCellFont(ALeftCol, ATopRow, ARightCol, ABottomRow : Integer; AStyle : TFontStyles; ASize : Integer;FontName:String;Color:Integer);
  procedure SetCellPattern(ALeftCol, ATopRow, ARightCol, ABottomRow,ABackground, AForeGround : Integer; AFillStyle : TcxSSFillStyle);
  procedure SetCellFormat(ALeftCol, ATopRow, ARightCol, ABottomRow, AFormat : Integer);
  procedure SetCellAlignment(ALeftCol, ATopRow, ARightCol, ABottomRow : Integer; AHorzAlign : TcxHorzTextAlign; AVertAlign : TcxVertTextAlign);
  procedure SetCellBorders(ALeftCol, ATopRow, ARightCol, ABottomRow : Integer; AEdge: integer; AStyle: TcxSSEdgeLineStyle);
  procedure SetCellMerge(Sender :TcxSpreadSheetBook; ALeftCol,ATopRow,ARightCol,ABottomRow:Integer;IsMerge:Boolean);
  procedure format_ayarla_text(FCol, FRow, ECol, ERow: Integer);

  procedure SaveSpreadSheet;
//******************************************************************************
//******************************************************************************
//******************************************************************************
  procedure ToolButton1Click(Sender: TObject);
  procedure ToolButton8Click(Sender: TObject);
  procedure FormKeyPress(Sender: TObject; var Key: Char);
//***********************************************
  private



    { Private declarations }
  public
  procedure SetCellText(ARow, ACol : Integer; AText : String; Size:Integer);Overload;
    { Public declarations }
  end;

var
  frmRaporCiktisi: TfrmRaporCiktisi;
  frm_sayac_cikti : integer;

implementation

uses unDataMod, DateUtils;

{$R *.dfm}

procedure TfrmRaporCiktisi.format_ayarla(FCol,FRow,ECol,ERow:Integer);
begin
  if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
      SetCellFormat(FCol,FRow,ECol,ERow,4)
  else
      SetCellFormat(FCol,FRow,ECol,ERow,3);
end;


procedure TfrmRaporCiktisi.format_ayarla_text(FCol,FRow,ECol,ERow:Integer);
begin
      SetCellFormat(FCol,FRow,ECol,ERow,0);
end;


procedure TfrmRaporCiktisi.format_ayarla_dov(FCol,FRow,ECol,ERow:Integer);
begin
  SetCellFormat(FCol,FRow,ECol,ERow,4);
end;


function TfrmRaporCiktisi.Tarih_Karsilastir(const A, B: TDateTime): Byte;
begin
  if Trunc(A) = Trunc(B) then
  begin
    Result := 0//e?itse
  end
  else
  if A < B then
  begin
    Result := 1//ikinci tarih birinciden b?y?kse
  end
  else
  begin
    Result := 2;//birinci tarih ikinciden b?y?kse
  end;
end;

Function TfrmRaporCiktisi.Date_MoveNDays(
  DateValue    : TDateTime;
  DateMovement : Integer): TDateTime;
Begin
  Result := DateValue + DateMovement;
End;

Function TfrmRaporCiktisi.Date_NextDay(DateValue: TDateTime): TDateTime;
Begin
  Result := Date_MoveNDays(DateValue,1);
End;

Function TfrmRaporCiktisi.Date_PriorDay(DateValue: TDateTime): TDateTime;
Begin
  Result := Date_MoveNDays(DateValue,-1);
End;

procedure TfrmRaporCiktisi.SaveSpreadSheet;
var
  AFileName: string;
begin
  if self.SaveDialog.Execute then
  begin
    AFileName := ChangeFileExt(self.SaveDialog.FileName, '.xls');

    self.grdA.SaveToFile(AFileName );
  end;
end;


procedure TfrmRaporCiktisi.SetCellText(ARow, ACol : Integer; AText : String);
begin
  with frmRaporCiktisi.grdA.ActiveSheet.GetCellObject(ACol,ARow) do
  begin
    try
      Text := AText;
    finally
      Free;
    end;
  end;
end;

procedure TfrmRaporCiktisi.SetCellText(ARow, ACol : Integer; AText : String; Size:Integer);
begin
  frmRaporCiktisi.grda.ActiveSheet.Cols.Size[ACol]:=Size;
  with frmRaporCiktisi.grdA.ActiveSheet.GetCellObject(ACol,ARow) do
  begin
    try
      Text := AText;

    finally
      Free;
    end;
  end;
end;


procedure TfrmRaporCiktisi.SetCellDate(ACol, ARow : Integer; ADate : TDateTime);
begin
  with frmRaporCiktisi.grdA.ActiveSheet.GetCellObject(ACol,ARow) do
  begin
    try
      DateTime := ADate;
    finally
      Free;
    end;
  end;
end;

procedure TfrmRaporCiktisi.SetCellFont(ALeftCol, ATopRow, ARightCol, ABottomRow : Integer; AStyle : TFontStyles; ASize : Integer; FontName:String; Color:Integer);
var
  I, J : Integer;
begin
  with frmRaporCiktisi.grdA.ActiveSheet do
  begin
    for I := ALeftCol to ARightCol do
    begin
      for J := ATopRow to ABottomRow do
      begin
        with GetCellObject(I,J) do
        begin
          try
            Style.Font.Name := FontName;
            Style.Font.Style := AStyle;
            Style.Font.Size := ASize;
            //0: Siyah
            //1: Beyaz
            //2: K?rm?z?
            //3: Ye?il
            //4: Mavi
            //5: Sar?
            Style.Font.FontColor := Color;
          finally
            Free;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmRaporCiktisi.SetCellPattern(ALeftCol, ATopRow, ARightCol, ABottomRow, ABackground, AForeGround : Integer; AFillStyle : TcxSSFillStyle);
var
  I, J : Integer;
begin
  with frmRaporCiktisi.grdA.ActiveSheet do
  begin
    for I := ALeftCol to ARightCol do
    begin
      for J := ATopRow to ABottomRow do
      begin
        with GetCellObject(I,J) do
        begin
          try
            Style.Brush.BackgroundColor := ABackground;
            Style.Brush.ForegroundColor := AForeground;
            Style.Brush.Style := AFillStyle;
          finally
            Free;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmRaporCiktisi.SetCellFormat(ALeftCol, ATopRow, ARightCol, ABottomRow, AFormat : Integer);
var
  I, J : Integer;
begin
  with frmRaporCiktisi.grdA.ActiveSheet do
  begin
    for I := ALeftCol to ARightCol do
    begin
      for J := ATopRow to ABottomRow do
      begin
        with GetCellObject(I,J) do
        begin
          try
            Style.Format := AFormat;
          finally
            Free;
          end;
        end;
      end;
    end;
  end;
end;



procedure TfrmRaporCiktisi.SetCellAlignment(ALeftCol, ATopRow, ARightCol, ABottomRow : Integer;
                                  AHorzAlign : TcxHorzTextAlign; AVertAlign : TcxVertTextAlign);
var
  I, J : Integer;
begin
  with frmRaporCiktisi.grdA.ActiveSheet do
  begin
    for I := ALeftCol to ARightCol do
    begin
      for J := ATopRow to ABottomRow do
      begin
        with GetCellObject(I,J) do
        begin
          try
            Style.HorzTextAlign := AHorzAlign;
            Style.VertTextAlign := AVertAlign;
          finally
            Free;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmRaporCiktisi.SetCellBorders(ALeftCol, ATopRow, ARightCol, ABottomRow : Integer;
                                AEdge: Integer; AStyle: TcxSSEdgeLineStyle);
var
  I, J : Integer;
begin
  with frmRaporCiktisi.grdA.ActiveSheet do
  for I := ALeftCol to ARightCol do
  begin
    for J := ATopRow to ABottomRow do
    begin
      with GetCellObject(I,J) do
      begin
        try
          case AEdge of
          0: Style.Borders.Left.Style   := AStyle;
          1: Style.Borders.Top.Style    := AStyle;
          2: Style.Borders.Right.Style  := AStyle;
          3: Style.Borders.Bottom.Style := AStyle;
          end;
        finally
          Free;
        end;
      end;
    end;
  end;
end;




procedure TfrmRaporCiktisi.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporCiktisi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift =  [ssCtrl] then
  begin
    case Key of
    75 : ToolButton2Click(Self);
    107 : ToolButton2Click(Self);
    99 : ToolButton3Click(Self);
    end;
  end;
end;

procedure TfrmRaporCiktisi.ToolButton2Click(Sender: TObject);
begin
  SaveSpreadSheet;
end;

procedure TfrmRaporCiktisi.ToolButton3Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmRaporCiktisi.form_open();
begin
  Application.CreateForm(TfrmRaporCiktisi,frmRaporCiktisi);
  frmRaporCiktisi.dxComponentPrinter1.CurrentLink.PrinterPage.PageFooter.CenterTextAlignY := taCenterY;
  frmRaporCiktisi.dxComponentPrinter1.CurrentLink.PrinterPage.PageFooter.CenterTitle.Add('[Page # of Pages #]');
end;

procedure TfrmRaporCiktisi.Rapor_Ayarlari(Tip:Integer);
begin
  if Tip=1 then //sayfaya s?gd?rma
  frmRaporCiktisi.dxComponentPrinter1.CurrentLink.PrinterPage.ScaleMode := smAdjust;

  if Tip=2 then //yatay kag?t
  frmRaporCiktisi.dxComponentPrinter1.CurrentLink.PrinterPage.Orientation:=poLandscape

end;

procedure TfrmRaporCiktisi.ToolButton1Click(Sender: TObject);
begin
  Self.dxComponentPrinter1.Preview(True,nil);
end;

procedure TfrmRaporCiktisi.ToolButton8Click(Sender: TObject);
begin
  Self.dxComponentPrinter1.ReportLink[0].Print(True, nil);
end;

function TfrmRaporCiktisi.GetCellText(ARow, ACol: Integer): String;
begin
  with frmRaporCiktisi.grdA.ActiveSheet.GetCellObject(ACol,ARow) do
  begin
    try
      Result := Text;
    finally
      Free;
    end;
  end;
end;

function TfrmRaporCiktisi.GetCellDeger(ARow, ACol: Integer): Currency;
begin
  with frmRaporCiktisi.grdA.ActiveSheet.GetCellObject(ACol,ARow) do
  begin
    try
      Result := StrToCurr(Text);
    finally
      Free;
    end;
  end;
end;


procedure TfrmRaporCiktisi.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    close;
  end;
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl,True,True);
  end;
end;


procedure TfrmRaporCiktisi.Formatla(ARow, ACol: Integer);
begin
  with frmRaporCiktisi.grdA.ActiveSheet.GetCellObject(ACol,ARow) do
  begin
    try
      //Text := AText;
      //Style.Format := $19;
      Style.Format := StrToInt('$4');
    finally
      Free;
    end;
  end;
end;


procedure TfrmRaporCiktisi.SetCellMerge(Sender :TcxSpreadSheetBook; ALeftCol,ATopRow,ARightCol,ABottomRow:Integer;IsMerge:Boolean);
begin
  (Sender as TcxSpreadSheetBook).ActiveSheet.SetMergedState(Rect(ALeftCol,ATopRow,ARightCol,ABottomRow),IsMerge);
end;

end.
