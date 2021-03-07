
{                                                                              }
{ FRM_Contact                                                                  }
{                                                                              }

unit
  FRM_Contact;

{$I IB_Directives.inc}

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Registry,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, Mask, Grids,

{$IFDEF IBO_VCL60_OR_GREATER}
  Variants,
{$ENDIF}

  IBF_Base,

  IB_Constants,
  IB_Session,
  IB_Components,
  IB_Controls,
  IB_TransactionBar,
  IB_SearchBar,
  IB_UpdateBar,
  IB_NavigationBar,
  IB_DataSetBar,
  IB_Monitor,
  IB_Grid,
  IB_Parse,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_LocateEdit;

type
  TfrmContact = class(TfrmBase)
    MainMenu: TMainMenu;
    FileExitItem: TMenuItem;
    SpeedBar: TPanel;
    btExit: TSpeedButton;
    nbContact: TIB_NavigationBar;
    sbContact: TIB_SearchBar;
    Panel2: TPanel;
    Panel3: TPanel;
    dsContact: TIB_DataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Label32: TLabel;
    EditID: TIB_Edit;
    pcContact: TPageControl;
    tsGeneral: TTabSheet;
    ScrollBox1: TScrollBox;
    Label3: TLabel;
    Label4: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    EditFIRSTNAME: TIB_Edit;
    EditLASTNAME: TIB_Edit;
    EditADDR1: TIB_Edit;
    EditCITY: TIB_Edit;
    EditZIP: TIB_Edit;
    EditPHONE: TIB_Edit;
    TabSheet3: TTabSheet;
    tsBrowse: TTabSheet;
    tsHistory: TTabSheet;
    dsHistory: TIB_DataSource;
    Label43: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    EditBUSNAME: TIB_Edit;
    EditBUSADDR1: TIB_Edit;
    EditBUSCITY: TIB_Edit;
    EditBUSZIP: TIB_Edit;
    EditBUSPHONE: TIB_Edit;
    Label13: TLabel;
    EditBUSSTATE: TIB_Edit;
    Label7: TLabel;
    pnHistorySearch: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    Label35: TLabel;
    miRefresh: TMenuItem;
    miN1: TMenuItem;
    Label2: TLabel;
    edPhone: TIB_Edit;
    Label8: TLabel;
    Label5: TLabel;
    tsPicture: TTabSheet;
    Label6: TLabel;
    rgGender: TIB_RadioGroup;
    EditCOMMENT: TIB_Memo;
    Panel5: TPanel;
    ScrollBox2: TScrollBox;
    imPicture: TIB_Image;
    Panel6: TPanel;
    btLoadPicture: TButton;
    pnHistorySpacer: TPanel;
    MonitorSQL1: TMenuItem;
    odBMP: TOpenDialog;
    dsType: TIB_DataSource;
    IB_DataSetBar1: TIB_DataSetBar;
    grContact: TIB_Grid;
    btU: TButton;
    btD: TButton;
    IB_UpdateBar1: TIB_UpdateBar;
    Export1: TMenuItem;
    IB_Edit3: TIB_Edit;
    lbEMAIL: TLabel;
    lbBDAY: TLabel;
    DateBDAY: TIB_Date;
    cbForGrid: TIB_LookupCombo;
    cgHistoryBrowse: TIB_Grid;
    cbTYPE: TIB_LookupCombo;
    edSTATE: TIB_ComboBox;
    sbTest: TSpeedButton;
    btApplyUpdates: TButton;
    btRevertRecord: TButton;
    EditADDDATE: TIB_Date;
    EditCHGDATE: TIB_Date;
    btCancelUpdates: TButton;
    btLocate: TButton;
    Profiler1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure dsContactStateChanged(Sender: TIB_DataSource;
      AIB_DataSet: TIB_DataSet);
    procedure dsContactDataChanged(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Column: TIB_Column);
    procedure grContactDblClick(Sender: TObject);
    procedure sbContactBeforeAction(Sender: TObject);
    procedure dsHistoryStateChanged(Sender: TIB_DataSource;
      AIB_DataSet: TIB_DataSet);
    procedure miRefreshClick(Sender: TObject);
    procedure btLoadPictureClick(Sender: TObject);
    procedure sbContactRowCount(Sender: TObject; RowCount: Integer);
    procedure MonitorSQL1Click(Sender: TObject);
    procedure pcContactChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btUClick(Sender: TObject);
    procedure Export1Click(Sender: TObject);
    procedure dsContactPrepareSQL(Sender: TIB_StatementLink;
      Statement: TIB_Statement);
    procedure sbTestClick(Sender: TObject);
    procedure btApplyUpdatesClick(Sender: TObject);
    procedure btRevertRecordClick(Sender: TObject);
    procedure btCancelUpdatesClick(Sender: TObject);
    procedure btLocateClick(Sender: TObject);
    procedure Profiler1Click(Sender: TObject);
    procedure grContactGetCellProps(Sender: TObject; ACol, ARow: Integer;
      AState: TGridDrawState; var AColor: TColor; AFont: TFont);
  private
    procedure UpdateCaption;
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
  public
  end;

var
  frmContact: TfrmContact;

implementation

{$R *.DFM}

uses
  IBF_Monitor, IBF_Profiler, DM_Contact;

procedure TfrmContact.DoReadSettings;
begin
  with RegDB do begin
    odBMP.Filename := ReadString( 'Settings', 'Filename', '*.BMP' );
  end;
  with dmContact.qrContact do begin
    ReadStrings( 'ContactFieldsDisplayWidth', FieldsDisplayWidth );
    ReadStrings( 'ContactFieldsIndex', FieldsIndex );
  end;
end;

procedure TfrmContact.DoWriteSettings;
begin
  with RegDB do begin
    WriteString( 'Settings', 'Filename', odBMP.Filename );
  end;
  with dmContact.qrContact do begin
    WriteStrings( 'ContactFieldsDisplayWidth', FieldsDisplayWidth );
    WriteStrings( 'ContactFieldsIndex', FieldsIndex );
  end;
end;

procedure TfrmContact.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
  SetDefaultBounds( 0, 0, 640, 480 );
  pcContact.ActivePage := tsGeneral;
  with dmContact do begin
    cnContact.Connect;
    qrHistory.Active := true;
    qrType.Active := true;
    qrContact.Search;
  end;
  {$IFDEF VER100}
  // Embedding controls in the grid is not supported in  Delphi 3.
  // Borland didn't implement interfaces correctly until Delphi 4.
  cbForGrid.Parent := nil;
  cbForGrid.Visible := false;
  {$ENDIF}
end;

procedure TfrmContact.ShowHint(Sender: TObject);
begin
  StatusBar.SimpleText := Application.Hint;
end;

procedure TfrmContact.FileExit(Sender: TObject);
begin
  Close;
end;

procedure TfrmContact.dsContactStateChanged(Sender: TIB_DataSource;
  AIB_DataSet: TIB_DataSet);
begin
  UpdateCaption;
end;

procedure TfrmContact.dsContactDataChanged(
  Sender: TIB_StatementLink; Statement: TIB_Statement;
  Column: TIB_Column);
begin
  UpdateCaption;
// This keeps the custom row coloring efficient when CON_TYPE column changes.  
  if Assigned( Column ) and ( Column.FieldName = 'CON_TYPE' ) then
    grContact.InvalidateRow( grContact.GridRow[ dmContact.qrContact.RowNum ],
                             true );
end;

procedure TfrmContact.UpdateCaption;
begin
  Caption := 'Contact';
  btLoadPicture.Enabled := false;
  with dmContact, qrContact, Fields do
  begin
    case State of
      dssInactive: ;
      dssPrepared: ;
      dssEdit:
      begin
        Caption := Caption + ': Updating ' +
                              FieldByName( 'FIRSTNAME' ).AsString + ' ' +
                              FieldByName( 'LASTNAME' ).AsString;
        btLoadPicture.Enabled := true;
      end;
      dssInsert: begin
        btLoadPicture.Enabled := true;
        Caption := Caption + ': Inserting ' + FieldByName( 'ID' ).AsString;
      end;
      dssSearch: begin
        Caption := Caption + ': Searching';
      end else begin
        if FieldByName( 'ID' ) <> nil then begin
          if FieldByName( 'ID' ).AsString <> '' then begin
            btLoadPicture.Enabled := dsContact.AutoEdit;
            Caption := Caption + ': ' + FieldByName( 'FIRSTNAME' ).AsString +
                                 ' '  + FieldByName( 'LASTNAME' ).AsString;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmContact.grContactDblClick(Sender: TObject);
begin
// Move to the data entry fields with selected field hilighted.
  with dmContact.qrContact do begin
    if ( State = dssBrowse ) and not EOF and not BOF then begin
      Edit;
      pcContact.ActivePage := tsGeneral;
      with grContact do begin
        if SelectedField <> nil then begin
          SelectedField.FocusControl;
        end;
      end;
    end;
  end;
end;

procedure TfrmContact.sbContactBeforeAction(Sender: TObject);
begin
// When the user goes into search mode take them to the General tab page .
  if sbContact.FocusedButton = sbSearch then begin
    pcContact.ActivePage := tsGeneral;
  end;
end;

procedure TfrmContact.dsHistoryStateChanged(Sender: TIB_DataSource;
  AIB_DataSet: TIB_DataSet);
begin
// This makes the panel containing the search fields appear only when searching.
  with dmContact.qrHistory do begin
    pnHistorySpacer.Visible := State = dssSearch;
    pnHistorySearch.Visible := State = dssSearch;
  end;
end;

procedure TfrmContact.miRefreshClick(Sender: TObject);
begin
// Save all changes and then establish a new connection and transaction. 
  with dmContact do begin
    if trContact.CloseWithConfirm = mrOk then begin
      cnContact.Connected := false;
      qrType.Active := true;
      qrHistory.Active := true;
      qrContact.Search;
    end;
  end;
end;

procedure TfrmContact.btLoadPictureClick(Sender: TObject);
begin
// Load in a new picture.
  if odBMP.Execute then begin
    imPicture.Picture.LoadFromFile( odBMP.FileName );
  end;
end;

procedure TfrmContact.sbContactRowCount(Sender: TObject; RowCount: Integer);
begin
// Customize the display of the record count.
  StatusBar.SimpleText := IntToStr( RowCount ) + ' Rows Counted';
end;

procedure TfrmContact.MonitorSQL1Click(Sender: TObject);
begin
// Display the trace monitor so that the SQL and API calls can be viewed.
  with TfrmMonitor.Create( Application ) do begin
    BaseKey := Self.FullKey + '\Monitor SQL';
    IB_Monitor.ProfilerConnection := dmContact.cnContact;
    Show;
  end;
end;

procedure TfrmContact.Profiler1Click(Sender: TObject);
begin
// Display profiler to profile database activity.
  with TfrmProfiler.Create( Application ) do begin
    BaseKey := Self.FullKey + '\Profiler';
    IB_Profiler.IB_Connection := dmContact.cnContact;
    Show;
  end;
end;

procedure TfrmContact.pcContactChange(Sender: TObject);
begin
// If in Search mode is all you need to do is click on the Browse tab and the
// matching records are displayed.
  if pcContact.Activepage = tsBrowse then begin
    with dmContact.qrContact do begin
      if not BufferActive then Open;
    end;
  end;
  if pcContact.Activepage = tsHistory then begin
    dmContact.qrHistory.Open;
  end else begin
    dmContact.qrHistory.Close;
  end;
end;

procedure TfrmContact.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
// Make sure the user saves their changes before exiting the application.
  CanClose := dmContact.trContact.CloseWithConfirm = mrOk;
end;

procedure TfrmContact.grContactGetCellProps(Sender: TObject; ACol,
  ARow: Integer; AState: TGridDrawState; var AColor: TColor; AFont: TFont);
var
  dat: string;
  tmpFld: TIB_Column;
begin
// This provides an example of how colors and fonts can be customized on an
// individual basis.

// It also shows how any row of data can be peeked at without having to worry
// about messing up the display of data.
  if dsContact.Active then
  begin
    with dsContact.DataSet do
    begin
      BufferRowNum := grContact.DataRow[ ARow ];
      if BufferRowNum > 0 then
      begin

// This provides an example of how colors can be customized on an
// individual cell basis.
        tmpFld := grContact.GridFields[ grContact.DataCol[ ACol ]];
        if Assigned( tmpFld ) and ( tmpFld.FieldName = 'LASTNAME' ) then
        begin
          dat := BufferFieldByName('CON_TYPE').AsString;
          if dat = 'FAMILY' then
          begin
            if AColor = grContact.Color then
              AColor := clLime;
          end;
        end;
        if AFont.Color <> clHighlightText then
        begin
          dat := BufferFieldByName('CON_TYPE').AsString;
          if dat = 'FRIEND' then
            AFont.Color := clBlue
          else
          if dat = 'FAMILY' then
            AFont.Color := clRed
          else
            AFont.Color := clWindowText;
        end;
      end;
    end;
  end;
end;

procedure TfrmContact.btUClick(Sender: TObject);
begin
  if not dmContact.qrContact.FindRecord( false, Sender = btD ) then
    ShowMessage( 'Record was not found' );
end;

procedure TfrmContact.Export1Click(Sender: TObject);
begin
  dmContact.exContact.Execute;
end;

procedure TfrmContact.sbTestClick(Sender: TObject);
begin
// Toggle between showing males only and all records.
  dmContact.qrContact.InvalidateSQL;
  dmContact.qrContact.Refresh;
end;

procedure TfrmContact.dsContactPrepareSQL(Sender: TIB_StatementLink;
  Statement: TIB_Statement);
begin
// Adjust the SQL based on the sbTest setting.
  if sbTest.Down then
    dmContact.qrContact.SQLWhereItems.Add( 'GENDER = ''M''' );
//  else
//    dmContact.qrContact.SQLWhereItems.Add( 'GENDER = ''F''' );
end;

procedure TfrmContact.btApplyUpdatesClick(Sender: TObject);
begin
  dmContact.trContact.ApplyUpdates( [ dmContact.qrContact ] );
end;

procedure TfrmContact.btRevertRecordClick(Sender: TObject);
begin
  dmContact.qrContact.RevertRecord;
end;

procedure TfrmContact.btCancelUpdatesClick(Sender: TObject);
begin
  dmContact.qrContact.CancelUpdates;
end;

//  dmContact.qrContact.ToggleSelected;
{
  with dmContact do begin
    qrContact['CITY'] := qrContact['CITY'] + 'A';
    qrContact.Post;
    qrContact.Refresh;
  end;
}

procedure TfrmContact.btLocateClick(Sender: TObject);
begin
  with dmContact.qrContact do
    Locate( 'LASTNAME;FIRSTNAME',
            VarArrayOf( [ 'Wage', 'Ben' ] ),
            [ lopPartialKey ] );
{
    Locate( 'LASTNAME',
            VarArrayOf( [ 'Wage' ] ),
            [ lopPartialKey ] );
    Locate( 'STYLE', '1005', [ ] );
    Locate( 'ADDDATE', '4-15-2000', [ ] );
}
end;

end.


