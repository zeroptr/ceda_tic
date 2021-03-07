
{                                                                              }
{  FRM_Surveys                                                                 }
{                                                                              }

unit
  FRM_Surveys;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls, ComCtrls, Grids, Buttons,

  IBF_Base,

  IB_Session,
  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_Grid,
  IB_Controls;

type
  TfrmSurveys = class(TfrmBase)
    qrSurveys: TIB_Query;
    dsSurveys: TIB_DataSource;
    qrSurveyQuestions: TIB_Query;
    dsSurveyQuestions: TIB_DataSource;
    qrPresentation: TIB_Query;
    dsPresentation: TIB_DataSource;
    Panel1: TPanel;
    pnSurveys: TPanel;
    grSurveys: TIB_Grid;
    Splitter1: TSplitter;
    reNotes: TIB_RichEdit;
    Splitter2: TSplitter;
    grSurveyQuestions: TIB_Grid;
    splitSurveyQuestions: TSplitter;
    pnChoices: TPanel;
    Panel3: TPanel;
    Bevel1: TBevel;
    lbChoices: TLabel;
    meChoices: TIB_Memo;
    grLanguages: TIB_Grid;
    dsLanguages: TIB_DataSource;
    qrLanguages: TIB_Query;
    lcPresentation: TIB_LookupCombo;
    pmChoices: TPopupMenu;
    ViewChoices1: TMenuItem;
    ViewLanguages1: TMenuItem;
    dsSurveyType: TIB_DataSource;
    qrSurveyType: TIB_Query;
    lcSurveyType: TIB_LookupCombo;
    pmSurveys: TPopupMenu;
    ViewSummary1: TMenuItem;
    procedure csBaseAfterAssignment(Sender: TIB_ConnectionLink;
      AConnection: TIB_Connection);
    procedure tsBaseAfterAssignment(Sender: TIB_TransactionLink;
      ATransaction: TIB_Transaction);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrSurveyQuestionsBeforePost(IB_Dataset: TIB_Dataset);
    procedure grSurveyQuestionsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure grSurveyQuestionsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure grSurveyQuestionsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure grSurveyQuestionsMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure qrSurveyQuestionsAfterPost(IB_Dataset: TIB_Dataset);
    procedure grSurveyQuestionsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure grSurveyQuestionsMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure Splitter2CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure Panel1Resize(Sender: TObject);
    procedure pnChoicesResize(Sender: TObject);
    procedure ViewChoices1Click(Sender: TObject);
    procedure ViewLanguages1Click(Sender: TObject);
    procedure qrSurveyQuestionsDMLCacheReceivedItem(ADataset: TIB_Dataset;
      const ADMLCacheItem: TIB_DMLCacheItem);
    procedure ViewSummary1Click(Sender: TObject);
    procedure qrSurveyTypeAfterScroll(IB_Dataset: TIB_Dataset);
    procedure grSurveyQuestionsGetCellProps(Sender: TObject; ACol,
      ARow: Integer; AState: TGridDrawState; var AColor: TColor;
      AFont: TFont);
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
  private
    { Private declarations }
    BeganDragPos: integer;
  public
    { Public declarations }
    procedure Initialize; override;
    procedure ViewLanguages;
    procedure ViewChoices;
  end;

implementation

{$R *.DFM}

uses
  FRM_Questions;
  
procedure TfrmSurveys.csBaseAfterAssignment(Sender: TIB_ConnectionLink;
  AConnection: TIB_Connection);
begin
// Make sure all data access components on this form use the same connection.
  qrSurveys.IB_Connection := AConnection;
  qrSurveyQuestions.IB_Connection := AConnection;
  qrPresentation.IB_Connection := AConnection;
  qrLanguages.IB_Connection := AConnection;
  qrSurveyType.IB_Connection := AConnection;
end;

procedure TfrmSurveys.tsBaseAfterAssignment( Sender: TIB_TransactionLink;
  ATransaction: TIB_Transaction );
begin
// Make sure all data access components on this form use the same transaction.
  qrSurveys.IB_Transaction := ATransaction;
  qrSurveyQuestions.IB_Transaction := ATransaction;
  qrPresentation.IB_Transaction := ATransaction;
  qrLanguages.IB_Transaction := ATransaction;
  qrSurveyType.IB_Transaction := ATransaction;
end;

procedure TfrmSurveys.DoReadSettings;
begin
  with RegDB do begin
    pnSurveys.Height := ReadInteger( 'Settings', 'pnSurveys.Height', 94 );
    reNotes.Width    := ReadInteger( 'Settings', 'reNotes.Width',    225 );
    meChoices.Width  := ReadInteger( 'Settings', 'meChoices.Width',  200 );
    if ReadBool( 'Settings', 'ViewChoices',  true ) then begin
      ViewChoices;
    end else begin
      ViewLanguages;
    end;
    ReadStrings( 'qrSurveys.Index', qrSurveys.FieldsIndex );
    ReadStrings( 'qrSurveys.DisplayWidth', qrSurveys.FieldsDisplayWidth );
  end;
end;

procedure TfrmSurveys.DoWriteSettings;
begin
  with RegDB do begin
    WriteInteger( 'Settings', 'pnSurveys.Height', pnSurveys.Height );
    WriteInteger( 'Settings', 'reNotes.Width',    reNotes.Width );
    WriteInteger( 'Settings', 'meChoices.Width',  meChoices.Width );
    WriteBool( 'Settings', 'ViewChoices',  pnChoices.Visible );
    WriteStrings( 'qrSurveys.Index', qrSurveys.FieldsIndex );
    WriteStrings( 'qrSurveys.DisplayWidth', qrSurveys.FieldsDisplayWidth );
  end;
end;

procedure TfrmSurveys.Initialize;
begin
  qrSurveys.Open;
  qrSurveyQuestions.Open;
  qrPresentation.Open;
  qrLanguages.Open;
  qrSurveyType.Open;
end;

procedure TfrmSurveys.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned( qrSurveys.MasterSource ) then
  begin
    Action := caHide;
    qrSurveys.Close;
  end;
end;

procedure TfrmSurveys.qrSurveyQuestionsBeforePost(IB_Dataset: TIB_Dataset);
begin
  with qrSurveyQuestions do
    if State = dssInsert then
      FieldByName( 'SURVEYID' ).Assign( qrSurveys.FieldByName( 'SURVEYID' ));
end;

procedure TfrmSurveys.grSurveyQuestionsGetCellProps(Sender: TObject; ACol,
  ARow: Integer; AState: TGridDrawState; var AColor: TColor; AFont: TFont);
begin
  with qrSurveyQuestions, grSurveyQuestions do
  begin
    if ( ACol = 2 ) and ( ARow >= FixedRows ) and Assigned( AFont ) then
    begin
      BufferRowNum := DataRow[ ARow ];
      if BufferFieldByName( 'PRESENTATION' ).AsString <>
         BufferFieldByName( 'QPRESENTATION' ).AsString then
        AFont.Color := clRed;
    end;
  end;
end;

procedure TfrmSurveys.grSurveyQuestionsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source is TIB_Grid then
    with TIB_Grid( Source ) do
      Accept := ( Name = 'grQuestions' ) or ( Name = 'grSurveyQuestions' );
end;

procedure TfrmSurveys.grSurveyQuestionsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Cell: TGridCoord;
begin
  Cell := grSurveyQuestions.MouseCoord( X, Y );
  with qrSurveyQuestions, Source as TIB_Grid do
  begin
    if Cell.Y = -1 then
    begin
    // Drop was done below any valid records.
      Cell.Y := qrSurveyQuestions.BufferRowCount + grSurveyQuestions.FixedRows;
      if Name <> 'grQuestions' then
      begin
      // Move up since source is same and no insert is being done.
        Dec( Cell.Y );
      end;
    end;
    if Cell.Y < grSurveyQuestions.FixedRows then
    begin
    // Be sure to keep the first SEQ_NUM at 1.
      Cell.Y := grSurveyQuestions.FixedRows;
    end;
    DataSource.Dataset.CheckBrowseMode;
    DisableControls;
    try
      if Name = 'grQuestions' then
      begin
        Insert;
        FieldByName( 'QUESTIONID' ).Assign(
          DataSource.Dataset.FieldByName( 'QUESTIONID' ));
        FieldByName( 'PRESENTATION' ).Assign(
          DataSource.Dataset.FieldByName( 'PRESENTATION' ));
      end;
      if ( qrSurveyQuestions.Fields.RowState <> rsNone ) and
         ( qrSurveyQuestions.FieldByName( 'SEQ_NUM' ).AsInteger <>
           grSurveyQuestions.DataRow[ Cell.Y ] ) and
         ( grSurveyQuestions.DataRow[ Cell.Y ] <> 0 ) then
      begin
        qrSurveyQuestions.FieldByName( 'SEQ_NUM' ).AsInteger :=
          grSurveyQuestions.DataRow[ Cell.Y ];
      end;
      try
        CheckBrowseMode;
      except
      // In Delphi 4+ it is possible to add EIB_ISCError to the excpetions to
      // ignore while running in the IDE. This is very handy when
      // programatically responding to and handling anticipated excpetions.
        on E: EIB_ISCError do
          with E do
          begin
            if SQLCODE = -803 then
            begin
              Cancel;
              if qrSurveyQuestions.Locate( 'QUESTIONID',
                 DataSource.Dataset['QUESTIONID'], [] ) then
              begin
                qrSurveyQuestions.FieldByName( 'SEQ_NUM' ).AsInteger :=
                  grSurveyQuestions.DataRow[ Cell.Y ];
                CheckBrowseMode;
              end;
            end
            else
            begin
              Cancel;
              raise;
            end;
          end
        else
          raise;
      end;
    finally
      EnableControls;
      grSurveyQuestions.EditorMode := false;
    end;
  end;
end;

procedure TfrmSurveys.qrSurveyQuestionsAfterPost(IB_Dataset: TIB_Dataset);
begin
  qrSurveyQuestions.Refresh;
end;

procedure TfrmSurveys.grSurveyQuestionsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
begin
  Cell := grSurveyQuestions.MouseCoord( X, Y );
  if Cell.Y >= grSurveyQuestions.FixedRows then
    BeganDragPos := Y;
end;

procedure TfrmSurveys.grSurveyQuestionsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ( BeganDragPos > 0 ) and ( Abs( BeganDragPos - Y ) > 5 ) then
  begin
    BeganDragPos := 0;
    grSurveyQuestions.BeginDrag( false, 5 );
  end;
end;

procedure TfrmSurveys.grSurveyQuestionsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BeganDragPos := 0;
end;

procedure TfrmSurveys.grSurveyQuestionsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  grSurveyQuestions.EditorMode := false;
end;

procedure TfrmSurveys.FormResize(Sender: TObject);
var
  NewHeight: integer;
begin
  NewHeight := Height;
  if NewHeight < 225 then
    NewHeight := 225;
  NewHeight := ( NewHeight div 18 ) * 18 + 6;
  Height := NewHeight;
end;

procedure TfrmSurveys.Splitter2CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  if NewSize < 30 then NewSize := 30;
  NewSize := NewSize + 9;
  NewSize := ( NewSize div 18 ) * 18 + 5;
end;

procedure TfrmSurveys.Panel1Resize(Sender: TObject);
begin
  pnChoices.Width := grLanguages.Width;
end;

procedure TfrmSurveys.pnChoicesResize(Sender: TObject);
begin
  grLanguages.Width := pnChoices.Width;
end;

procedure TfrmSurveys.ViewLanguages;
begin
  pnChoices.Visible := false;
  grLanguages.Visible := true;
  splitSurveyQuestions.Left := grLanguages.Left - 1;
end;

procedure TfrmSurveys.ViewChoices;
begin
  grLanguages.Visible := false;
  pnChoices.Visible := true;
  splitSurveyQuestions.Left := pnChoices.Left - 1;
end;

procedure TfrmSurveys.ViewChoices1Click(Sender: TObject);
begin
  ViewChoices;
end;

procedure TfrmSurveys.ViewLanguages1Click(Sender: TObject);
begin
  ViewLanguages;
end;

procedure TfrmSurveys.qrSurveyQuestionsDMLCacheReceivedItem(
  ADataset: TIB_Dataset; const ADMLCacheItem: TIB_DMLCacheItem);
begin
  with ADMLCacheItem do
  begin
    if KeyFieldNames = 'QUESTIONID' then
    begin
      case DMLCacheItemType of
        ditEdit:
        begin
          ADataset.KeyFields.Values[ KeyFieldNames ] := KeyFieldValues;
          ADataset.InvalidateBookmark( ADataset.KeyFields.RowData );
        end
        else
          ADataset.RefreshKeys;
      end;
    end
    else
    if ( KeyFieldNames = 'SURVEYID;QUESTIONID' ) then
      if ADataset['SURVEYID'] = KeyFieldValues[ 0 ] then
        ADataset.RefreshKeys;
  end;
end;

procedure TfrmSurveys.ViewSummary1Click(Sender: TObject);
begin
{Show the results of the responses per survey and question.}
  ShowMessage( 'Not finished yet' );
end;

procedure TfrmSurveys.qrSurveyTypeAfterScroll(IB_Dataset: TIB_Dataset);
begin
  inherited;
//messagebeep(0);
end;

end.



   