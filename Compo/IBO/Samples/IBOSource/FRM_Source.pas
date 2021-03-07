unit FRM_Source;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FileCtrl, Grids, StdCtrls, ExtCtrls, ComCtrls, Registry, 

  IBF_Base,

  IB_Header,
  IB_Session,
  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_Grid,
  IB_Controls,
  IB_StoredProc;

type
  TfrmSource = class(TfrmBase)
    grSource: TIB_Grid;
    dsSource: TIB_DataSource;
    qrSource: TIB_Query;
    Panel1: TPanel;
    reNotes: TIB_RichEdit;
    Panel2: TPanel;
    btDownload: TButton;
    cn: TIB_Connection;
    pbBlob: TProgressBar;
    spSource: TIB_StoredProc;
    lb0: TLabel;
    lbSize: TIB_Text;
    lbBytes: TLabel;
    tr: TIB_Transaction;
    procedure qrSourceCalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
    procedure btDownloadClick(Sender: TObject);
    procedure cnLoginFailure(Sender: TIB_Connection);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure spSourceBlobCallback(AVAR: PXSQLVAR;
      AStatus: TIB_BlobCallbackStatus; ABytes: longint;
      var MaxSegmentSize: longint);
    procedure qrSourceAfterScroll(IB_Dataset: TIB_Dataset);
    procedure grSourceGetCellProps(Sender: TObject; ACol, ARow: Integer;
      AState: TGridDrawState; var AColor: TColor; AFont: TFont);
  private
    { Private declarations }
  protected
    DownloadDir: string;
    TotalSize: longint;
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
  public
    { Public declarations }
  end;

var
  frmSource: TfrmSource;

implementation

{$R *.DFM}

procedure TfrmSource.DoReadSettings;
begin
  with RegDB do begin
    DownloadDir := ReadString( 'Settings', 'DownloadDir', EmptyStr );
  end;
end;
procedure TfrmSource.DoWriteSettings;
begin
  with RegDB do begin
    WriteString( 'Settings', 'DownloadDir', DownloadDir );
  end;
end;

procedure TfrmSource.qrSourceCalculateField(Sender: TIB_Statement;
  ARow: TIB_Row; AField: TIB_Column);
var
  tmpPos: integer;
  tmpFile: integer;
  tmpStr: string;
  tmpBool: boolean;
begin
  if AField.FieldName = 'SC_SIZEKB' then begin
    AField.AsInteger := Round( ARow.ByName('SC_SIZE').AsInteger / 1024 );
  end else if AField.FieldName = 'SC_VERSION' then begin
    tmpStr := ARow.ByName('SC_FILENAME').AsString;
    if CompareText( 'IBO_', Copy( tmpStr, 1, 4 )) = 0 then begin
      System.Delete( tmpStr, 1, 4 );
    end;
    tmpPos := Pos( '.zip', LowerCase( tmpStr ));
    if tmpPos > 0 then begin
      tmpStr := Copy( tmpStr, 1, tmpPos - 1 );
    end;
    AField.AsString := tmpStr;
  end else if AField.FieldName = 'SC_DOWNLOADED' then begin
    tmpBool := false;
    tmpStr := DownloadDir + '\' + ARow.ByName( 'SC_FILENAME' ).AsString;
    tmpFile := FileOpen( tmpStr, fmOpenRead or fmShareDenyNone );
    if tmpFile > 0 then begin
      try
        tmpBool := FileDateToDateTime( FileGetDate( tmpFile )) =
                   ARow.ByName( 'SC_DATE' ).AsDateTime;
      finally
        FileClose( tmpFile );
      end;
    end;
    AField.AsBoolean := tmpBool;
  end;
end;

procedure TfrmSource.btDownloadClick(Sender: TObject);
var
  tmpName: string;
  tmpFile: integer;
  oldDL: string;
begin
  with qrSource do begin
    oldDL := DownloadDir;
    if not DirectoryExists( DownloadDir ) then begin
      DownloadDir := EmptyStr;
    end;
    if SelectDirectory( DownloadDir, [ sdAllowCreate,
                                       sdPerformCreate ], 0 ) then begin
      try
        BeginBusy( false );
        spSource.ParamByName( 'SC_ID' ).Assign( FieldByName( 'SC_ID' ));
        spSource.ExecProc;
        tmpName := DownloadDir + '\' + FieldByName( 'SC_FILENAME' ).AsString;
        spSource.FieldByName( 'SC_DATA' ).SaveToFile( tmpName );
        tmpFile := FileOpen( tmpName, fmOpenWrite or fmShareDenyNone );
        if tmpFile > 0 then begin
          try
            FileSetDate( tmpFile,
                         DateTimeToFileDate(
                         FieldByName( 'SC_DATE' ).AsDateTime ));
            MessageBeep( 0 );
            StatusBar.SimpleText := 'File download complete for: ' + tmpName;
          finally
            FileClose( tmpFile );
          end;
        end;
        if OldDL <> DownloadDir then begin
          InvalidateCalculatedFields
        end else begin
          CalculateFields;
        end;
      finally
        EndBusy;
      end;
    end;
  end;
end;

procedure TfrmSource.cnLoginFailure(Sender: TIB_Connection);
begin
  Application.Terminate;
end;

procedure TfrmSource.FormCreate(Sender: TObject);
begin
{$IFNDEF VER90}
{$IFNDEF VER100}
{$IFNDEF VER110}
  Constraints.MinHeight := 230;
  Constraints.MinWidth := 600;
{$ENDIF}{$ENDIF}{$ENDIF}
end;

procedure TfrmSource.FormActivate(Sender: TObject);
begin
  inherited;
  if not cn.Connected then begin
    cn.Connect;
    if cn.Connected then begin
      qrSource.Open;
      qrSource.FieldByName( 'SC_VERSION' ).FocusControl;
    end;
  end;
end;

procedure TfrmSource.spSourceBlobCallback(AVAR: PXSQLVAR;
  AStatus: TIB_BlobCallbackStatus; ABytes: longint;
  var MaxSegmentSize: longint);
begin
  if AVAR.AliasName = 'SC_DATA' then begin
    case AStatus of
      bcsInitGet: begin
        TotalSize := ABytes;
        pbBlob.Position := 0;
        MaxSegmentSize := 4096;
        lbBytes.Caption := EmptyStr;
      end;
      bcsRefreshGet, bcsFinalGet: begin
        pbBlob.Position := pbBlob.Max -
                           Trunc((TotalSize-ABytes)/TotalSize * pbBlob.Max);
        lbBytes.Caption := FormatFloat( '###,###,###,###', ABytes );
      end;
    end;
    Repaint;
  end;
end;

procedure TfrmSource.qrSourceAfterScroll(IB_Dataset: TIB_Dataset);
begin
  pbBlob.Position := 0;
  lbBytes.Caption := EmptyStr;
  lb0.Caption := '0';
end;

procedure TfrmSource.grSourceGetCellProps(Sender: TObject; ACol,
  ARow: Integer; AState: TGridDrawState; var AColor: TColor; AFont: TFont);
begin
  if ( ACol = 2 ) and dsSource.Active then
    with dsSource.DataSet do
    begin
      BufferRowNum := grSource.DataRow[ ARow ];
      if BufferRowNum > 0 then
        if not BufferFieldByName( 'SC_DOWNLOADED' ).AsBoolean then
          AFont.Style := AFont.Style + [ fsBold ];
    end;
end;

end.

