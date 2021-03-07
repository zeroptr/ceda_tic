
{                                                                              }
{ FRM_BLR                                                                      }
{                                                                              }

unit
  FRM_BLR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,

  IB_Header,
  IB_Session,
  IB_Constants,
  IB_Components;

type
  TDeptNoIn = packed record
    DeptNo: array [0..3] of char;
  end;
  TPhoneOut = packed record
    ValidData: short;
    PhoneNumber: array [0..20] of char;
  end;

  TForm1 = class(TForm)
    btLookupPhone: TButton;
    lbPhoneNumber: TLabel;
    cn: TIB_Connection;
    tr: TIB_Transaction;
    edDept: TEdit;
    Label1: TLabel;
    odGDB: TOpenDialog;
    procedure cnBeforeDisconnect(Sender: TIB_Connection);
    procedure btLookupPhoneClick(Sender: TObject);
    procedure cnOnConnect(Sender: TIB_Connection);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Msg0: byte;
    Msg1: byte;
    PhoneOut: TPhoneOut;
    DeptNoIn: TDeptNoIn;
    rqHandle: isc_req_handle;
  public
    { Public declarations }
    procedure CompileRequest;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  Registry;

procedure TForm1.CompileRequest;
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
    BlrByte( ALen mod 256 );
    BlrByte( ALen div 256 );
  end;
  procedure AddIdent( AStr: string );
  var
    ii: word;
  begin
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
var
  Rel0: byte;  
begin
  Msg0 := 0; // Message block for input parameters.
  Msg1 := 1; // Message block for output fields.
  Rel0 := 0; // Indication of the relation referenced.
  BlrLen := 0;
{ SELECT phone_no FROM department WHERE dept_no = :dept }
  BlrByte( blr_version4 );
  BlrBegin;
    BlrMsg( Msg1, 2 ); // Output message with two items.
      AddShort( 0 ); // Zero scale
      AddCStr( 21 ); // Additional byte for the null termination.
    BlrMsg( Msg0, 1 ); // Input message with one item.
      AddCStr( 4 ); // Additional byte for the null termination.
    BlrReceive( Msg0 ); // Get parameter value via start_and_send call.
    BlrBegin; // Begin action to take after input message is received.
      BlrItem( blr_for, blr_singular ); // Select records in a singleton way.
        BlrItem( blr_rse, 1 ); // This is the record selection expression block.
          BlrRel( 'DEPARTMENT', Rel0 ); // Select from the DEPARTMENT table.
          BlrByte( blr_boolean ); // Select the record with the matching deptno.
            BlrByte( blr_eql );
              BlrField( Rel0, 'DEPT_NO' );
              BlrParam( Msg0, 0 );
        BlrEnd; // End the blr_rse block.
        BlrSend( Msg1 ); // Send field values via receive call.
        BlrBegin;
          BlrByte( blr_assignment );
            BlrShortVal( 1 ); // Tells that valid data exists.
            BlrParam( Msg1, 0 );
          BlrByte( blr_assignment );
            BlrField( Rel0, 'PHONE_NO' ); // Put phone no value in out message.
            BlrParam( Msg1, 1 );
        BlrEnd;
      BlrSend( Msg1 ); // Send field value via receive call to terminate loop.
        BlrByte( blr_assignment );
          BlrShortVal( 0 ); // Tells that there is no valid data.
          BlrParam( Msg1, 0 );
    BlrEnd;
  BlrEnd;
  BlrEoc;
  with cn.IB_Session do
  begin
    errcode := dll_compile_request( @status,
                                    cn.PdbHandle,
                                    @RqHandle,
                                    BlrLen,
                                    @BlrBuf );
    if errcode <> 0 then HandleException( Self );
  end;
  
{ For more examples of BLR it is possible to create a stored procedure with the
desired statements in it and then go into IB_SQL and go to the form where it
is possible to browse the source and BLR contents of stored procedures.}

end;

procedure TForm1.btLookupPhoneClick(Sender: TObject);
begin
  if not cn.Connected then
    cn.Connect;
  if not Assigned( RqHandle ) then
    CompileRequest;
  StrPCopy( DeptNoIn.DeptNo, Copy( edDept.Text, 1, 3 ));
  tr.Started := true;
  with tr.IB_Session do try
    errcode := dll_start_and_send ( @status,
                                    @RqHandle,
                                    tr.PtrHandle,
                                    Msg0,
                                    SizeOf( DeptNoIn ),
                                    @DeptNoIn,
                                    0 );
    if errcode <> 0 then HandleException( Self );
    repeat
      errcode := dll_receive( @status,
                              @RqHandle,
                              Msg1,
                              SizeOf( PhoneOut ),
                              @PhoneOut,
                              0 );
      if errcode = isc_req_sync then Break;
      if errcode <> 0 then HandleException( Self );
      if PhoneOut.ValidData = 1 then
        lbPhoneNumber.Caption := PhoneOut.PhoneNumber;
    until PhoneOut.ValidData <> 1;
  except
    on E: EIB_ISCError do
    begin
      E.ShowDialog;
      raise;
    end
    else
      raise;
  end;
end;

procedure TForm1.cnBeforeDisconnect(Sender: TIB_Connection);
begin
  with cn.IB_Session do
    if Assigned( rqhandle ) then
    begin
      dll_release_request( @status, @rqhandle );
      if errcode <> 0 then begin
        HandleException( Self );
      end;
    end;
end;

procedure TForm1.cnOnConnect(Sender: TIB_Connection);
var
  MyReg: TRegINIFile;
begin
  MyReg := TRegIniFile.Create( IB_BASEKEY + '\Samples\Connections' );
  with Sender, odGDB do
  try
    if ConnectionStatus = csConnectPending then
    begin
      Database := MyReg.ReadString( 'Connections', 'Employee', Database );
// Allow a quick change of path if the file about to be opened is not found.
// Do not try and supply a GDB file over a mapped drive! If you do be sure to
// change it's path so that the server process can resolve the file's location.
      if ( Protocol = cpLocal ) and not FileExists( Database ) then
      begin
        FileName := Database;
        if Execute then
          Database := FileName
        else
          SysUtils.Abort;
      end;
    end
    else
    if ConnectionStatus = csConnected then
      MyReg.WriteString( 'Connections', 'Employee', Database );
  finally
    MyReg.Free;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cn.Disconnect;
end;

end.
