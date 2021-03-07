
{                                                                              }
{ FRM_TestScan                                                                 }
{                                                                              }

{ Credit is due to Michael Ax of HREF tools for assisting to providing this    }
{ test application. It is a slightly modified version of his original design.  }

unit
  FRM_TestScan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, BDE,

  IB_Header,
  IB_Session,
  IB_Components,
  IB_BLR;

type
  TfrmTestScan = class(TForm)
    IB_Database1: TIB_Database;
    Database1: TDatabase;
    Query1: TQuery;
    btIBOAPI: TButton;
    btQuery: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edDatabase: TEdit;
    btOk: TButton;
    btTable: TButton;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edTable: TEdit;
    Label8: TLabel;
    Label12: TLabel;
    btStop: TButton;
    Label7: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    btIB_Cursor: TButton;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    btIB_Query: TButton;
    Table1: TTable;
    IB_Cursor1: TIB_Cursor;
    IB_Query1: TIB_Query;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    btBLR: TButton;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    btRaw: TButton;
    Label25: TLabel;
    edPassword: TEdit;
    procedure btIBOAPIClick(Sender: TObject);
    procedure btQueryClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btTableClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure edTableChange(Sender: TObject);
    procedure btIB_CursorClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btIB_QueryClick(Sender: TObject);
    procedure btRawClick(Sender: TObject);
    procedure btBLRClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ok:boolean;
  end;

var
  frmTestScan: TfrmTestScan;

implementation

{$R *.DFM}

function GetNativeHandle(Database: TDatabase): Pointer;
var
  length: word;
begin
// This is how you get a native IB handle out of a TDatabase.
  Result := nil;
  if Assigned( Database ) and
     Database.Connected and
     ( Database.DriverName = 'INTRBASE' ) then
    Check( DBIGetProp( HDBIOBJ( Database.Handle ), dbNATIVEHNDL,
                                                   @Result,
                                                   SizeOf( Pointer ),
                                                   length ));
end;

procedure TfrmTestScan.btOkClick(Sender: TObject);
begin
// Get a connection and share it with IB_Database1.
  with Database1 do begin
    if not Connected or
      ( Params.Values[ 'SERVER NAME' ] <> edDatabase.Text ) then begin
      IB_Database1.dbHandleShared := nil;
      connected := false;
      Params.Values[ 'SERVER NAME' ] := edDatabase.Text;
      Params.Values[ 'PASSWORD' ] := edPassword.Text;
      connected := true;
      IB_Database1.dbHandleShared := GetNativeHandle( Database1 );
    end;
  end;
  with IB_Cursor1 do begin
    SQL.Text := 'SELECT * FROM ' + edTable.Text;
    prepared := true;
    Active := true;
    ok := true;
    // This takes a once through scan to prime the server's buffers so that
    // when each of the buttons are pressed it is more fair.
//    try
//      BeginBusy( true );  // This gives a drastic performance boost!
      while ok and not EOF do begin
        APINext;
        Application.ProcessMessages;
      end;
//    finally
//      EndBusy;
//    end;
    Active := false;
  end;
  with IB_Query1 do begin
    SQL.Text := 'SELECT * FROM ' + edTable.Text;
    prepared := true;
    Active := true;
    Active := false;
  end;
  with query1 do begin
    Active := false;
    SQL.Text := 'SELECT * FROM ' + edTable.Text;
    prepared := true;
    Active := true;
    Active := false;
  end;
  with Table1 do begin
    Active := false;
    TableName := edTable.Text;
    Active := true;
    Active := false;
  end;
  Ok := false;
  btRaw.Enabled := true;
  btBLR.Enabled := true;
  btIBOAPI.Enabled := true;
  btIB_Cursor.Enabled := true;
  btIB_Query.Enabled := true;
  btQuery.Enabled := true;
  btTable.Enabled := true;
end;

procedure TfrmTestScan.btStopClick(Sender: TObject);
begin
  ok := false;
end;

procedure TfrmTestScan.edTableChange(Sender: TObject);
begin
  btRaw.Enabled := false;
  btBLR.Enabled := false;
  btIBOAPI.Enabled := false;
  btIB_Cursor.Enabled := false;
  btIB_Query.Enabled := false;
  btQuery.Enabled := false;
  btTable.Enabled := false;
  IB_DataBase1.dbHandleShared := nil;
  Database1.Close;
end;

procedure TfrmTestScan.FormDestroy(Sender: TObject);
begin
// Clear out the shared connection handle.
  IB_Database1.dbHandleShared := nil;
end;

procedure TfrmTestScan.btIBOAPIClick(Sender: TObject);
var
  i,j,n:integer;
begin
  if ok then begin
    ok := false;
    exit;
    end
  else
    ok := true;
  n := GetTickCount;
  with IB_Cursor1, IB_Session, Fields do
  begin
    first;
    i := GetTickCount;
    Label1.Caption := IntToStr(i-n);
    n := i;
    j := 0;
    Application.ProcessMessages;
    errcode := 0;
    while ok and ( errcode = 0 ) do
    begin
      inc(j);
      errcode := isc_dsql_fetch( @status,
                                 PstHandle,
                                 SQLDA_VERSION1,
                                 PSQLDA );
      Application.ProcessMessages;
    end;
    i := GetTickCount;
    Label2.Caption := IntToStr(i-n);
    Label3.Caption := FloatToStrF( (i-n) / j, ffFixed, 7, 4 );
  end;
  ok := false;
end;

procedure TfrmTestScan.btIB_CursorClick(Sender: TObject);
var
  i,j,n:integer;
begin
  if ok then begin
    ok := false;
    exit;
    end
  else
    ok := true;
  n := GetTickCount;
  with IB_Cursor1, IB_Session, Fields do
  begin
    first;
    i := GetTickCount;
    Label7.Caption := IntToStr(i-n);
    n := i;
    j := 0;
    Application.ProcessMessages;
    errcode  := 0;
    try
      // This gives a drastic performance boost!
      // Is all that is does is keep the screen cursor from flickering each time
      // the method Next is called. Let the cursor change twice instead of two
      // plus how ever many records there are times two!
      BeginBusy( true );
//      Close;Prepare;Open;Close;Unprepare;Prepare;Open;Close;Unprepare;Open;Close;Prepare;Open;
//      Close;Prepare;Open;Close;Unprepare;Prepare;Open;Close;Unprepare;Open;Close;Prepare;Open;
      while ok and not eof do
      begin
        inc(j);
{}
        Next;
        Application.ProcessMessages;
      end;
{}
    finally
      EndBusy;
    end;
    i := GetTickCount;
    Label13.Caption := IntToStr(i-n);
    Label14.Caption := FloatToStrF( (i-n) / j, ffFixed, 7, 4 );
    end;
  ok := false;
end;

procedure TfrmTestScan.btIB_QueryClick(Sender: TObject);
var
  i,j,n:integer;
begin
  if ok then begin
    ok := false;
    exit;
    end
  else
    ok := true;
  with IB_Query1, IB_Session, Fields do
  begin
    Unprepare;
    Prepare;
    n := GetTickCount;
    Open;
    i := GetTickCount;
    Label16.Caption := IntToStr(i-n);
    n := i;
    j := 0;
    Application.ProcessMessages;
    errcode  := 0;
    try
      // This gives a drastic performance boost!
      // Is all that is does is keep the screen cursor from flickering each time
      // the method Next is called. Let the cursor change twice instead of two
      // plus how ever many records there are times two!
      BeginBusy( true );
      DisableControls;
//      Close;Prepare;Open;Close;Unprepare;Prepare;Open;Close;Unprepare;Open;Close;Prepare;Open;
//      Close;Prepare;Open;Close;Unprepare;Prepare;Open;Close;Unprepare;Open;Close;Prepare;Open;
      while ok and not eof do
      begin
        inc(j);
{}
        Next;
        Application.ProcessMessages;
      end;
{}
      Close;
    finally
      EndBusy;
      EnableControls;
    end;
    Application.ProcessMessages;
    i := GetTickCount;
    Label17.Caption := IntToStr(i-n);
    Label18.Caption := FloatToStrF( (i-n) / j, ffFixed, 7, 4 );
    end;
  ok := false;
end;

procedure TfrmTestScan.btQueryClick(Sender: TObject);
var
  i,j,n:integer;
begin
  if ok then
  begin
    ok := false;
    exit;
    end
  else
    ok := true;
  Query1.Close;
  n := GetTickCount;
  with Query1 do
  begin
    Open;
    i := GetTickCount;
    Label4.Caption := IntToStr(i-n);
    n := i;
    j := 0;
    Application.ProcessMessages;
    DisableControls;
//    Close;Prepare;Open;Close;Unprepare;Prepare;Open;Close;Unprepare;Open;Close;Prepare;Open;
//    Close;Prepare;Open;Close;Unprepare;Prepare;Open;Close;Unprepare;Open;Close;Prepare;Open;
    while ok and not eof do
    begin
      inc(j);
{}
      next;
      Application.ProcessMessages;
    end;
{}    
    EnableControls;
    i := GetTickCount;
    Label5.Caption := IntToStr(i-n);
    Label6.Caption := FloatToStrF( (i-n) / j, ffFixed, 7, 4 );
    end;
  ok := false;
end;

procedure TfrmTestScan.btTableClick(Sender: TObject);
var
  i,j,n:integer;
begin
  if ok then begin
    ok := false;
    exit;
    end
  else
    ok := true;
  table1.close;
  n := GetTickCount;
  with Table1 do begin
    open;
    i := GetTickCount;
    Label9.Caption := IntToStr(i-n);
    n := i;
    j := 0;
    Application.ProcessMessages;
    while ok and not eof do begin
      inc(j);
      next;
      Application.ProcessMessages;
      end;
    i := GetTickCount;
    Label10.Caption := IntToStr(i-n);
    Label11.Caption := FloatToStrF( (i-n) / j, ffFixed, 7, 4 );
    end;
  ok := false;
end;

procedure TfrmTestScan.btRawClick(Sender: TObject);
var
  i,j,n:integer;
begin
  if ok then begin
    ok := false;
    exit;
    end
  else
    ok := true;
  n := GetTickCount;
  with IB_Cursor1, IB_Session, Fields do
  begin
    first;
    i := GetTickCount;
    Label22.Caption := IntToStr(i-n);
    n := i;
    Application.ProcessMessages;
    j := IB_Cursor1.RecordCount;
    i := GetTickCount;
    Label23.Caption := IntToStr(i-n);
    Label24.Caption := FloatToStrF( (i-n) / j, ffFixed, 7, 4 );
    end;
  ok := false;
end;

function GetBLR(     ACursor: TIB_Dataset;
                 var BufOutLen: integer ): string;
var
  BlrBuf: array [0..1024] of byte;
  BlrLen: integer;
  procedure BlrByte( AByte: byte );
  begin
    BlrBuf[ BlrLen ] := AByte;
    inc( BlrLen );
  end;
  procedure BlrItem( AByte, AVal: byte );
  begin
    BlrByte( AByte );
    BlrByte( AVal );
  end;
  procedure BlrMsg( AID: byte; ACnt: word );
  begin
    BlrByte( blr_message );
    BlrByte( AID );
    BlrByte( ACnt mod 256 );
    BlrByte( ACnt div 256 );
  end;
  procedure AddShort( AScale: byte );
  begin
    BlrByte( blr_short );
    BlrByte( AScale );
  end;
  procedure AddLong( AScale: byte );
  begin
    BlrByte( blr_long );
    BlrByte( AScale );
  end;
  procedure BlrShortVal( AVal: short );
  begin
    BlrByte( blr_literal );
    BlrByte( blr_short );
    BlrByte( 0 ); // For scale
    BlrByte( AVal mod 256 );
    BlrByte( AVal div 256 );
  end;
  procedure AddCStr( ALen: word );
  begin
    BlrByte( blr_cstring );
    Inc( ALen ); // Null terminated string.
    BlrByte( ALen mod 256 );
    BlrByte( ALen div 256 );
  end;
  procedure AddText( ALen: word );
  begin
    BlrByte( blr_Text );
    BlrByte( ALen mod 256 );
    BlrByte( ALen div 256 );
  end;
  procedure AddVarying( ALen: word );
  begin
    BlrByte( blr_varying );
    BlrByte( ALen mod 256 );
    BlrByte( ALen div 256 );
  end;
  procedure AddIdent( AStr: string );
  var
    ii: word;
  begin
    AStr := Trim( UpperCase( AStr ));
    BlrByte( Length( AStr ));
    for ii := 1 to Length( AStr ) do begin
      BlrByte( byte( AStr[ ii ] ));
    end;
  end;
  procedure BlrRel( ARel: string; ANo: byte );
  begin
    BlrByte( blr_relation );
    AddIdent( ARel );
    BlrByte( ANo );
  end;
  procedure BlrField( ARelID: byte; AFld: string );
  begin
    BlrByte( blr_field );
    BlrByte( ARelID );
    AddIdent( AFld );
  end;
  procedure BlrParam( AMsgID: byte; APart: word );
  begin
    BlrByte( blr_parameter );
    BlrByte( AMsgID );
    BlrByte( APart mod 256 );
    BlrByte( APart div 256 );
  end;
  procedure BlrBegin;
  begin
    BlrByte( blr_begin );
  end;
  procedure BlrEnd;
  begin
    BlrByte( blr_end );
  end;
  procedure BlrEoc;
  begin
    BlrByte( blr_eoc );
  end;
  procedure BlrSend( AMsgID: byte );
  begin
    BlrByte( blr_send );
    BlrByte( AMsgID );
  end;
  procedure BlrReceive( AMsgID: byte );
  begin
    BlrByte( blr_receive );
    BlrByte( AMsgID );
  end;
  procedure AddMessageparam( ACol: TIB_Column );
  begin
    with ACol do begin
      Inc( BufOutLen, SQLLen );
      if IsNullable then begin
      end;
      case SQLtype of
        SQL_FLOAT,
        SQL_FLOAT_: BlrByte( blr_float );
        SQL_DOUBLE,
        SQL_DOUBLE_: BlrByte( blr_double );
        SQL_SHORT,
        SQL_SHORT_: AddShort( -SQLScale );
        SQL_LONG,
        SQL_LONG_: AddLong( -SQLScale );
        SQL_DATE,
        SQL_DATE_: BlrByte( blr_date );
        SQL_Text,
        SQL_Text_: AddText( SQLLen );
        SQL_VARYING,
        SQL_VARYING_: begin
          AddVarying( SQLLen );
          Inc( BufOutLen, 2 );
        end;
        SQL_BLOB,
        SQL_BLOB_,
        SQL_ARRAY,
        SQL_ARRAY_: BlrByte( blr_quad );
        else raise Exception.Create( 'Unsupported column type' );
      end;
    end;
  end;
var
  ii, jj: integer;
  Msg0: byte;
  Rel0: byte;
begin
  Msg0 := 0;
  Rel0 := 0;
  BlrLen := 0;
  BufOutLen := 0;
  with ACursor, IB_Session, Fields do begin
    Prepare;
    BlrByte( blr_version4 );
      BlrBegin;
        BlrMsg( Msg0, ColumnCount );
// There seems to be some strange alignment features where IB likes the
// longer columns first in the buffer.
        for ii := 0 to ColumnCount - 1 do with Columns[ ii ] do begin
          if ( SQLLen > 8 ) then begin
            AddMessageParam( Columns[ ii ] );
          end;
        end;
        for ii := 0 to ColumnCount - 1 do with Columns[ ii ] do begin
          if ( SQLLen = 8 ) then begin
            AddMessageParam( Columns[ ii ] );
          end;
        end;
        for ii := 0 to ColumnCount - 1 do with Columns[ ii ] do begin
          if ( SQLLen > 4 ) and ( SQLLen < 8 ) then begin
            AddMessageParam( Columns[ ii ] );
          end;
        end;
        for ii := 0 to ColumnCount - 1 do with Columns[ ii ] do begin
          if ( SQLLen = 4 ) then begin
            AddMessageParam( Columns[ ii ] );
          end;
        end;
        for ii := 0 to ColumnCount - 1 do with Columns[ ii ] do begin
          if ( SQLLen < 4 ) then begin
            AddMessageParam( Columns[ ii ] );
          end;
        end;
        BlrBegin;
        BlrByte( blr_stall );
        BlrByte( blr_for );
          BlrItem( blr_rse, 1 );
            BlrRel( RelationNames[0], Rel0 );
          BlrEnd;
          BlrSend( Msg0 );
            BlrBegin;
            jj := 0;
            for ii := 0 to ColumnCount - 1 do with Columns[ ii ] do begin
              if ( SQLLen > 8 ) then begin
                  BlrByte( blr_assignment );
                    BlrField( Rel0, SQLName );
                    BlrParam( Msg0, jj );
                  Inc( jj );
              end;
            end;
            for ii := 0 to ColumnCount - 1 do with Columns[ ii ] do begin
              if ( SQLLen = 8 ) then begin
                  BlrByte( blr_assignment );
                    BlrField( Rel0, SQLName );
                    BlrParam( Msg0, jj );
                  Inc( jj );
              end;
            end;
            for ii := 0 to ColumnCount - 1 do with Columns[ ii ] do begin
              if ( SQLLen > 4 ) and ( SQLLen < 8 ) then begin
                  BlrByte( blr_assignment );
                    BlrField( Rel0, SQLName );
                    BlrParam( Msg0, jj );
                  Inc( jj );
              end;
            end;
            for ii := 0 to ColumnCount - 1 do with Columns[ ii ] do begin
              if ( SQLLen = 4 ) then begin
                  BlrByte( blr_assignment );
                    BlrField( Rel0, SQLName );
                    BlrParam( Msg0, jj );
                  Inc( jj );
              end;
            end;
            for ii := 0 to ColumnCount - 1 do with Columns[ ii ] do begin
              if ( SQLLen < 4 ) then begin
                  BlrByte( blr_assignment );
                    BlrField( Rel0, SQLName );
                    BlrParam( Msg0, jj );
                  Inc( jj );
              end;
            end;
            BlrEnd;
        BlrEnd;
      BlrEnd;
    BlrEoc;
    SetLength( Result, BlrLen );
    Move( BlrBuf[0], Result[1], BlrLen );
  end;

// NOTE: It may be necessary to adjust this amount here for now because I
// don't know just how it aligns the message parameters in the messages yet.
// For some reason it seems to add fill bytes here and there so I can't assume
// a fixed amount of bytes just from the exact sum of the column's data sizes.
// This is safe and just fine because I'm not actually trying to interprete
// any values from the output buffer at this point.

//  Inc( BufOutLen, 4 );
  
end;

procedure TfrmTestScan.btBLRClick(Sender: TObject);
var
  i,j,n:integer;
  rqHandle: isc_req_handle;
  BlrStmt: string;
  BufOutLen: integer;
  BufOut: pointer;
begin

  if ok then
  begin
    ok := false;
    exit;
  end
  else
    ok := true;

  BlrStmt := GetBlr( IB_Cursor1, BufOutLen );
  rqHandle := nil;
  with IB_Cursor1.IB_Session do
  begin
    n := GetTickCount;
    errcode := dll_compile_request( @status,
                                    IB_Database1.PdbHandle,
                                    @rqHandle,
                                    Length( BlrStmt ),
                                    @BlrStmt[1] );
    if errcode <> 0 then HandleException( Self );
    IB_Cursor1.IB_Transaction.Started := true;
    errcode := dll_start_request ( @status,
                                   @rqHandle,
                                   IB_Cursor1.IB_Transaction.PtrHandle,
                                   0 );
    if errcode <> 0 then HandleException( Self );
    i := GetTickCount;
    Label19.Caption := IntToStr(i-n);

    n := i;
    j := 0;
    Application.ProcessMessages;

    BufOut := AllocMem( BufOutLen );
    try
//      IB_Cursor1.BeginBusy( true );
      while ok and ( errcode = 0 ) do begin
        inc(j);
        errcode := dll_receive( @status,
                                @rqHandle,
                                0,
                                BufOutLen,
                                BufOut,
                                0 );
        if errcode = isc_req_sync then Break;
        if errcode <> 0 then begin
          HandleException( Self );
        end;
        Application.ProcessMessages;
      end;
      i := GetTickCount;
      Label20.Caption := IntToStr(i-n);
      Label21.Caption := FloatToStrF( (i-n) / j, ffFixed, 7, 4 );
    finally
      FreeMem( BufOut );
      ok := false;
      dll_release_request( @status, @rqHandle );
//      IB_Cursor1.EndBusy;
    end;
  end;
end;

end.



 
