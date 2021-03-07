{**********************************************}
{   TeeChart Excel Series data importing       }
{   Copyright (c) 2001-2009 by David Berneda   }
{   All Rights Reserved.                       }
{**********************************************}
unit TeeExcelSource;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLR}
  Variants,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QButtons, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,
  {$ENDIF}
  TeeURL, TeEngine, TeeSourceEdit, TeCanvas;

type
  TTeeExcelSource=class(TTeeSeriesSourceFile)
  private
    FExcel     : Variant;
    FLabelsFrom: String;
    FLabelsTo  : String;
    FRangeFrom : String;
    FRangeTo   : String;
    FWorkSheet : String;

    FRunning   : Boolean;
    WorkBook   : OleVariant;
    Procedure OpenWorkBook;
    procedure SetLabelsFrom(const Value: String);
    procedure SetLabelsTo(const Value: String);
    procedure SetRangeFrom(const Value: String);
    procedure SetRangeTo(const Value: String);
    procedure SetWorkSheet(const Value: String);
  public
    Procedure Close; override;

    class Function Description:String; override;
    class Function Editor:TComponentClass; override;

    Procedure Load; override;
  published
    property Active;
    property FileName;
    property LabelsFrom:String read FLabelsFrom write SetLabelsFrom;
    property LabelsTo:String read FLabelsTo write SetLabelsTo;
    property RangeFrom:String read FRangeFrom write SetRangeFrom;
    property RangeTo:String read FRangeTo write SetRangeTo;
    property Series;
    property WorkSheet:String read FWorkSheet write SetWorkSheet;
  end;

  TExcelSourceForm = class(TBaseSourceEditor)
    LabelFile: TLabel;
    EFileName: TEdit;
    LabelSheet: TLabel;
    CBWorkSheet: TComboFlat;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    EValFrom: TEdit;
    Label4: TLabel;
    EValTo: TEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    ELabFrom: TEdit;
    ELabTo: TEdit;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    procedure CBWorkSheetChange(Sender: TObject);
    procedure EFileNameChange(Sender: TObject);
    procedure EValFromChange(Sender: TObject);
    procedure BApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    Procedure CheckControls;
    Procedure FillWorkSheets;
  public
    { Public declarations }
    DataSource : TTeeExcelSource;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses {$IFNDEF LINUX}
     ActiveX,
     {$ENDIF}

     {$IFNDEF CLR}
     {$IFDEF D6}
     Variants,
     {$ENDIF}
     {$ENDIF}

     TeeProcs, TeeConst, TeeProCo, TeeEdiSeri, ComObj;

Procedure TExcelSourceForm.FillWorkSheets;
var t : Integer;
begin
  CBWorkSheet.Clear;

  Screen.Cursor:=crHourGlass;

  With TTeeExcelSource.Create(nil) do
  try
    FileName:=EFileName.Text;
    OpenWorkBook;

    for t:=1 to WorkBook.Worksheets.Count do
        CBWorkSheet.Items.Add(WorkBook.Worksheets.Item[t].Name);
  finally
    Screen.Cursor:=crDefault;
    
    Free;

    CBWorkSheet.Enabled:=CBWorkSheet.Items.Count>0;
  end;
end;

Procedure TExcelSourceForm.CheckControls;
begin
  CBWorkSheet.Enabled:=(EFileName.Text<>'') and FileExists(EFileName.Text);
end;

procedure TExcelSourceForm.CBWorkSheetChange(Sender: TObject);
begin
  EnableControls(True,[ELabFrom,ELabTo,EValFrom,EValTo]);
  BApply.Enabled:=True;
end;

procedure TExcelSourceForm.EFileNameChange(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TExcelSourceForm.EValFromChange(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TExcelSourceForm.BApplyClick(Sender: TObject);
var tmpSheet : String;
begin
  tmpSheet:=CBWorkSheet.CurrentItem;

  if EFileName.Text='' then
  begin
    EFileName.SetFocus;
    Raise Exception.Create(TeeMsg_ExcelEmptyFile);
  end;

  if tmpSheet='' then
     Raise Exception.Create(TeeMsg_ExcelSheetEmpty);

  if (EValFrom.Text='') or (EValTo.Text='') then
     Raise Exception.Create(TeeMsg_ExcelRangeMissing);

  Screen.Cursor:=crHourGlass;

  with DataSource do
  try
    Close;
    FileName:=EFileName.Text;
    WorkSheet:=tmpSheet;
    RangeFrom:=EValFrom.Text;
    RangeTo:=EValTo.Text;
    LabelsFrom:=ELabFrom.Text;
    LabelsTo:=ELabTo.Text;

    CheckReplaceSource(DataSource);

    Open;

    BApply.Enabled:=False;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TExcelSourceForm.FormShow(Sender: TObject);
begin
  inherited;

  if Assigned(TheSeries) then
  begin
    if Assigned(TheSeries.DataSource) and
       (TheSeries.DataSource is TTeeExcelSource) then
          DataSource:=TTeeExcelSource(TheSeries.DataSource);
  end;

  if not Assigned(DataSource) then
     DataSource:=TTeeExcelSource.Create(TheSeries);

  With DataSource do
  begin
    EFileName.Text:=FileName;
    EValFrom.Text:=RangeFrom;
    EValTo.Text:=RangeTo;
    ELabFrom.Text:=LabelsFrom;
    ELabTo.Text:=LabelsTo;

    if FileName<>'' then
    begin
      FillWorkSheets;

      if WorkSheet<>'' then
      begin
        CBWorkSheet.ItemIndex:=CBWorkSheet.Items.IndexOf(WorkSheet);
        CBWorkSheetChange(Self);
      end;
    end;
  end;

  BApply.Enabled:=Assigned(TheSeries) and (TheSeries.DataSource<>DataSource);
end;

{ TTeeExcelSource }
Procedure TTeeExcelSource.OpenWorkBook;
Const
  ExcelClass='Excel.Application'; // Do not localize

  Function IsExcelRunning:Boolean;
  var ClassID: TCLSID;
      Unknown: IUnknown;
  begin
    ClassID := ProgIDToClassID(ExcelClass);
    result:=Succeeded(GetActiveObject(ClassID, nil, Unknown));
  end;

begin
  FRunning:=IsExcelRunning;

  if FRunning then FExcel:=GetActiveOleObject(ExcelClass)
              else FExcel:=CreateOleObject(ExcelClass);

  WorkBook:=FExcel.WorkBooks.Open(FileName  {,ReadOnly:=True});
end;

Procedure TTeeExcelSource.Load;

  Procedure GetRangeFromList(List:TChartValueList; Var FromPart,ToPart:String);
  var s : String;
      i : Integer;
  begin
    FromPart:='';
    ToPart:='';

    if List.ValueSource<>'' then
    begin
      s:=List.ValueSource;
      i:=Pos(':',s); // Do not localize

      if i>0 then
      begin
        FromPart:=Copy(s,1,i-1);
        ToPart:=Copy(s,i+1,Length(s));
      end;
    end;
  end;

var WS       : OleVariant;
    tmp      : Variant;
    List,
    t,
    n,
    tmpLow,
    tmpHigh  : Integer;
    tmpRangeFrom,
    tmpRangeTo : String;
begin
  if FileName='' then
     Raise Exception.Create(TeeMsg_ExcelEmptyFile);

  OpenWorkBook;

  WS:=WorkBook.Worksheets.Item[WorkSheet];
  WS.Activate;

  if RangeFrom='' then
     GetRangeFromList(Series.MandatoryValueList,FRangeFrom,FRangeTo);

  tmp:=WS.Range[RangeFrom, RangeTo].Value;
  if VarIsArray(tmp) then
  begin
    Series.Clear;

    n:=VarArrayDimCount(tmp);
    tmpLow:=VarArrayLowBound(tmp,n);
    tmpHigh:=VarArrayHighBound(tmp,n);
    Dec(n);

    if (tmpHigh-tmpLow)=0 then
    begin
      tmpLow:=VarArrayLowBound(tmp,n);
      tmpHigh:=VarArrayHighBound(tmp,n);
      if tmpHigh>=tmpLow then
      for t:=tmpLow to tmpHigh do
          Series.Add(tmp[t,n]);
    end
    else
      for t:=tmpLow to tmpHigh do
          Series.Add(tmp[n,t]);

    tmp:=UnAssigned;

    // Import additional Value Lists (ie: XYZ in Surface)
    for List:=0 to Series.ValuesList.Count-1 do
    if Series.ValuesList[List]<>Series.MandatoryValueList then
    begin
      GetRangeFromList(Series.ValuesList[List],tmpRangeFrom,tmpRangeTo);

      if (tmpRangeFrom<>'') and (tmpRangeTo<>'') then
      begin
        tmp:=WS.Range[tmpRangeFrom, tmpRangeTo].Value;

        if VarIsArray(tmp) then
        begin
          n:=VarArrayDimCount(tmp);
          tmpLow:=VarArrayLowBound(tmp,n);
          tmpHigh:=VarArrayHighBound(tmp,n);
          Dec(n);

          if (tmpHigh-tmpLow)=0 then
          begin
            tmpLow:=VarArrayLowBound(tmp,n);
            tmpHigh:=VarArrayHighBound(tmp,n);
            if tmpHigh>=tmpLow then
            for t:=tmpLow to tmpHigh do
                Series.ValuesList[List].Value[t-tmpLow]:=tmp[t,n];
          end
          else
            for t:=tmpLow to tmpHigh do
                Series.ValuesList[List].Value[t-tmpLow]:=tmp[n,t];
        end;
      end;
    end;

    { load label text }
    if (LabelsFrom<>'') and (LabelsTo<>'') then
    begin
      tmp:=WS.Range[LabelsFrom, LabelsTo].Value;

      if VarIsArray(tmp) then
      begin
        tmpLow:=VarArrayLowBound(tmp,1);
        tmpHigh:=VarArrayHighBound(tmp,1);

        if tmpHigh>=tmpLow then
        for t:=tmpLow to tmpHigh do
            Series.Labels[t-1]:=tmp[t,1];
      end;
    end;
  end;
end;

Procedure TTeeExcelSource.Close;
begin
  if Active then
    if not VarIsEmpty(FExcel) then
    begin
      if not FRunning then FExcel.Quit;
      FExcel:=UnAssigned;
      FRunning:=False;
    end;

  inherited;
end;

procedure TTeeExcelSource.SetRangeFrom(const Value: String);
begin
  if FRangeFrom<>Value then
  begin
    FRangeFrom:=Value;
    Close;
  end;
end;

procedure TTeeExcelSource.SetRangeTo(const Value: String);
begin
  if FRangeTo<>Value then
  begin
    FRangeTo:=Value;
    Close;
  end;
end;

procedure TTeeExcelSource.SetWorkSheet(const Value: String);
begin
  if FWorkSheet<>Value then
  begin
    FWorkSheet:=Value;
    Close;
  end;
end;

procedure TTeeExcelSource.SetLabelsFrom(const Value: String);
begin
  if FLabelsFrom<>Value then
  begin
    FLabelsFrom:=Value;
    Close;
  end;
end;

procedure TTeeExcelSource.SetLabelsTo(const Value: String);
begin
  if FLabelsTo<>Value then
  begin
    FLabelsTo:=Value;
    Close;
  end;
end;

class function TTeeExcelSource.Description: String;
begin
  result:=TeeMsg_ExcelFile;
end;

class function TTeeExcelSource.Editor: TComponentClass;
begin
  result:=TExcelSourceForm;
end;

procedure TExcelSourceForm.FormCreate(Sender: TObject);
begin
  inherited;
  LLabel.Visible:=False;
  CBSources.Visible:=False;
end;

procedure TExcelSourceForm.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    EFileName.Text:=OpenDialog1.FileName;
    FillWorkSheets;
    CheckControls;
  end;
end;

initialization
  RegisterClass(TTeeExcelSource);
  TeeSources.Add(TTeeExcelSource);
finalization
  TeeSources.Remove(TTeeExcelSource);
end.

