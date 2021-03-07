
{                                                                              }
{  FRM_LOB                                                                     }
{                                                                              }

unit
  FRM_Questions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Grids, Buttons,

  IBF_Base,

  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_Grid,
  IB_Controls;

type
  TfrmQuestions = class(TfrmBase)
    qrQuestions: TIB_Query;
    dsQuestions: TIB_DataSource;
    qrPresentation: TIB_Query;
    dsPresentation: TIB_DataSource;
    dsQuestionSurveys: TIB_DataSource;
    qrQuestionSurveys: TIB_Query;
    grQuestions: TIB_Grid;
    lcPresentation: TIB_LookupCombo;
    pnQuestions: TPanel;
    Splitter1: TSplitter;
    meChoices: TIB_Memo;
    grQuestionSurveys: TIB_Grid;
    Splitter2: TSplitter;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Panel2: TPanel;
    btTranslate: TSpeedButton;
    procedure csBaseAfterAssignment(Sender: TIB_ConnectionLink;
      AConnection: TIB_Connection);
    procedure tsBaseAfterAssignment(Sender: TIB_TransactionLink;
      ATransaction: TIB_Transaction);
    procedure grQuestionSurveysCellClick(Sender: TObject; ACol, ARow: Integer;
      AButton: TMouseButton; AShift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grQuestionSurveysMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grQuestionsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grQuestionsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure grQuestionsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grQuestionsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure grQuestionsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure btTranslateClick(Sender: TObject);
    procedure qrQuestionSurveysDMLCacheReceivedItem(ADataset: TIB_Dataset;
      const ADMLCacheItem: TIB_DMLCacheItem);
    procedure grQuestionSurveysGetCellProps(Sender: TObject; ACol,
      ARow: Integer; AState: TGridDrawState; var AColor: TColor;
      AFont: TFont);
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
  private
    { Private declarations }
    frmSurveys: TfrmBase;
    frmLanguage: TfrmBase;
    BeganDragPos: integer;
  public
    { Public declarations }
    procedure Initialize; override;
  end;

implementation

{$R *.DFM}

uses
  FRM_Surveys,
  FRM_Language;

procedure TfrmQuestions.csBaseAfterAssignment(Sender: TIB_ConnectionLink;
  AConnection: TIB_Connection);
begin
// Make sure all data access components on this form use the same connection.
  qrQuestions.IB_Connection := AConnection;
  qrQuestionSurveys.IB_Connection := AConnection;
  qrPresentation.IB_Connection := AConnection;
end;

procedure TfrmQuestions.tsBaseAfterAssignment( Sender: TIB_TransactionLink;
  ATransaction: TIB_Transaction );
begin
// Make sure all data access components on this form use the same transaction.
  qrQuestions.IB_Transaction := ATransaction;
  qrQuestionSurveys.IB_Transaction := ATransaction;
  qrPresentation.IB_Transaction := ATransaction;
end;

procedure TfrmQuestions.DoReadSettings;
begin
  with RegDB do begin
    grQuestionSurveys.Height := ReadInteger( 'Settings',
                                             'grQuestionSurveys.Height', 76 );
    pnQuestions.Width := ReadInteger( 'Settings', 'pnQuestions.Width', 200 );
  end;
end;

procedure TfrmQuestions.DoWriteSettings;
begin
  with RegDB do begin
    WriteInteger( 'Settings',
                  'grQuestionSurveys.Height', grQuestionSurveys.Height );
    WriteInteger( 'Settings', 'pnQuestions.Width', pnQuestions.Width );
  end;
end;

procedure TfrmQuestions.Initialize;
begin
  qrQuestions.Open;
  qrPresentation.Open;
  qrQuestionSurveys.Open;
end;

procedure TfrmQuestions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
// If the form is being used as a lookup window then don't free it.
  if Assigned( qrQuestions.MasterSource ) then begin
    Action := caHide;
    qrQuestions.Close;
  end;
end;

procedure TfrmQuestions.grQuestionSurveysCellClick(Sender: TObject; ACol, ARow: Integer;
  AButton: TMouseButton; AShift: TShiftState);
begin
  if Assigned( qrQuestions.MasterSource ) then Exit;
  if Assigned( qrQuestions.KeySource ) then Exit;
  if qrQuestionSurveys.IsEmpty then Exit;
  with grQuestionSurveys do
  begin
    if ACol = 1 then
    begin
      qrQuestions.BeginBusy( true );
      try
        qrQuestionSurveys.RowNum := DataRow[ ARow ];
        if not Assigned( frmSurveys ) then
        begin
          frmSurveys := TfrmSurveys.CreateWithContext( Self,
                                                       '\Surveys4Question',
                                                       BaseConnection,
                                                       BaseTransaction );
          with frmSurveys as TfrmSurveys do
          begin
            qrSurveys.Unprepare;
            qrSurveys.MasterSource := Self.dsQuestionSurveys;
            qrSurveys.MasterLinks.Text := 'SURVEYID=SURVEYID';
            ViewLanguages;
            Caption := 'Question Survey';
          end;
        end;
        (frmSurveys as TfrmSurveys).qrSurveys.Open;
        frmSurveys.Show;
      finally
        qrQuestions.EndBusy;
      end;
    end;
  end;
end;

procedure TfrmQuestions.grQuestionSurveysGetCellProps(Sender: TObject;
  ACol, ARow: Integer; AState: TGridDrawState; var AColor: TColor;
  AFont: TFont);
begin
  if Assigned( qrQuestions.MasterSource ) then Exit;
  if Assigned( qrQuestions.KeySource ) then Exit;
  if ( ACol = 1 ) and ( ARow >= 1 ) and Assigned( AFont ) then
  begin
    AFont.Color := clBlue;
    AFont.Style := AFont.Style + [ fsUnderline ];
  end;
end;

procedure TfrmQuestions.grQuestionSurveysMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Cell: TGridCoord;
begin
  if Assigned( qrQuestions.MasterSource ) then Exit;
  if Assigned( qrQuestions.KeySource ) then Exit;
  Cell := grQuestionSurveys.MouseCoord( X, Y );
  if ( Cell.X = 1 ) and ( Cell.Y > 0 ) then
  begin
    if Screen.Cursor = crDefault then
      Screen.Cursor := crHandPoint;
  end
  else
    Screen.Cursor := crDefault;
end;

procedure TfrmQuestions.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if qrQuestions.NeedToPost then
  begin
    CanClose := false;
    qrQuestions.CheckBrowseMode;
  end;
  CanClose := true;
end;

procedure TfrmQuestions.grQuestionsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
begin
  Cell := grQuestions.MouseCoord( X, Y );
  if Cell.Y >= grQuestions.FixedRows then begin
    BeganDragPos := Y;
  end;
end;

procedure TfrmQuestions.grQuestionsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
{
  if ( BeganDragPos > 0 ) and ( Abs( BeganDragPos - Y ) > 5 ) then begin
    BeganDragPos := 0;
    grSurveyQuestions.BeginDrag( false, 5 );
  end;
}
  if ( BeganDragPos > 0 ) and ( Abs( BeganDragPos - Y ) > 5 ) then begin
    BeganDragPos := 0;
    if not qrQuestions.NeedToPost then begin
      grQuestions.EditorMode := false;
      grQuestions.BeginDrag( true, 10 );
    end;
  end;
end;

procedure TfrmQuestions.grQuestionsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BeganDragPos := 0;
end;

procedure TfrmQuestions.grQuestionsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source is TIB_Grid then with Source as TIB_Grid do begin
    Accept := ( Name = 'grSurveyQuestions' );
  end;
end;

procedure TfrmQuestions.grQuestionsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  with Source as TIB_Grid do begin
    qrQuestions.Locate( 'QUESTIONID', DataSource.Dataset['QUESTIONID'], [] );
  end;
end;

procedure TfrmQuestions.FormResize(Sender: TObject);
var
  NewHeight: integer;
begin
  NewHeight := Height;
  if NewHeight < 225 then
    NewHeight := 225;
  NewHeight := ( NewHeight div 18 ) * 18 + 13;
  Height := NewHeight;
end;

procedure TfrmQuestions.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  if NewSize < 30 then NewSize := 30;
  NewSize := NewSize + 9;
  NewSize := ( NewSize div 18 ) * 18 + 5;
end;

procedure TfrmQuestions.btTranslateClick(Sender: TObject);
begin
  with grQuestionSurveys do begin
    qrQuestions.BeginBusy( true );
    try
      if not Assigned( frmLanguage ) then begin
        frmLanguage := TfrmLanguage.CreateWithContext( Self,
                                                       '\QuestionLanguage',
                                                       BaseConnection,
                                                       BaseTransaction );
        with frmLanguage as TfrmLanguage do begin
          qrTranslations.MasterSource := Self.dsQuestions;
        end;
      end;
      (frmLanguage as TfrmLanguage).qrTranslations.Open;
      frmLanguage.Show;
    finally
      qrQuestions.EndBusy;
    end;
  end;
end;

procedure TfrmQuestions.qrQuestionSurveysDMLCacheReceivedItem(
  ADataset: TIB_Dataset; const ADMLCacheItem: TIB_DMLCacheItem);
begin
  with ADMLCacheItem do begin
    case DMLCacheItemType of
      ditEdit: ADataset.DefaultDMLCacheReceivedItem( ADMLCacheItem );
      else if ( KeyFieldNames = 'SURVEYID;QUESTIONID' ) then begin
        if qrQuestions['QUESTIONID'] = KeyFieldValues[ 1 ] then begin
          ADataset.RefreshKeys;
        end;
      end;
    end;
  end;
end;

end.



 