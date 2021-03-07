unit
  formTutorial1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, IB_Session, ExtCtrls, IB_ConnectionBar, ComCtrls, StdCtrls,
  IB_Process, IB_Script;

type
  TfrmTutorial1 = class(TForm)
    tnMain: TIB_Transaction;
    pnlTop: TPanel;
    pnlBottom: TPanel;
    pnlBrowse: TPanel;
    barConnectionBar: TIB_ConnectionBar;
    pagMain: TPageControl;
    tabBrowse: TTabSheet;
    memoTutorial: TMemo;
    cnMain: TIB_Connection;
    scrMain: TIB_Script;
    procedure FormCreate(Sender: TObject);
    procedure cnMainAfterConnect(Sender: TIB_Connection);
    procedure cnMainAfterDisconnect(Sender: TIB_Connection);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cnMainBeforeConnect(Sender: TIB_Connection);
  private
    FDBPath: String;
    FOriginalCaption: String;
    procedure UpdateFormCaption;
  private
    procedure InitializeConnection;
    procedure InitializeTransaction;
    procedure InitializeConnectionBar;
  end;

var
  frmTutorial1: TfrmTutorial1;

implementation

{$R *.DFM}

{ ################################# Internal ################################ }

procedure TfrmTutorial1.FormCreate(Sender: TObject);
begin
  FDBPath := ExtractFilePath(Application.ExeName) + 'TUTORIAL.GDB';
  scrMain.SQL.Insert(0, 'CREATE DATABASE ' + '''' + FDBPath + '''');
  scrMain.SQL.Insert(1, 'USER ' + '''' + 'SYSDBA' + '''');
  scrMain.SQL.Insert(2, 'PASSWORD ' + '''' + 'masterkey' + '''' + ';');
  FOriginalCaption := Caption;
  UpdateFormCaption;
  ShowHint := True;
  with pagMain do ActivePage := FindNextPage(nil, True, True);
  InitializeConnection; // Defines the Connection settings.
  InitializeTransaction; // Defines the Transaction's behaviour.
  InitializeConnectionBar; // Defines the behaviour of the ConnectionBar.
end;

procedure TfrmTutorial1.cnMainAfterConnect(Sender: TIB_Connection);
begin
  UpdateFormCaption;
end;

procedure TfrmTutorial1.cnMainAfterDisconnect(Sender: TIB_Connection);
begin
  UpdateFormCaption;
end;

procedure TfrmTutorial1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cnMain.Connected := False;
end;

{ ################################# Private ################################# }

procedure TfrmTutorial1.UpdateFormCaption;
begin
  if cnMain.Connected then
    Caption := FOriginalCaption + ' - Connected'
  else
    Caption := FOriginalCaption + ' - Disconnected';
end;

procedure TfrmTutorial1.InitializeConnection;
begin
  { IBO speaks to Interbase Server via a TIB_Connection component.
    The IB_Database component is just a TIB_Connection but with a whole lot of
    extra features ( like a built in transaction component ) that together act
    more like the VCL TDatabase. For the best results, it is advised to use
    a TIB_Connection though, as it gives you much more control, functionality
    and power. }
  with cnMain do
  begin
    { Let's make sure that we are not still connected from design-time! }
    Connected := False;

    { Since we're going to set *all* the properties in code, even the
      login parameters, then we do not want IBO to ask for login info. }
    LoginPrompt := False;

    { The login information has to be set via the appropriate properties. }
    Username := 'SYSDBA'; // Remember to set this appropriately!
    Password := 'masterkey'; // Remember to set this appropriately!
    { Set the name of the Server wher you are accessing Interbase Server from.
      If IBServer is on the local machine, then leave this blank. If, for
      example, IBServer is on a WindowsNT machine called 'MAIN_SERVER', then
      set this property to 'MAIN_SERVER'. }
    Server := '';
    { Set the Path and Name of the Database that you want to use. This is the
      actual *fully-qualified* path and filename on the machine where the
      database is sitting; UNC names, share names, etc are not valid.
      [ Note this is an Interbase restriction, not a 'feature' of IB_Objects. ]
      For example, if the server is 'MAIN_SERVER', and your DataBase is
      'MyDatabase.gdb' then:
      The following type of path is *NOT* valid: (e.g.)
      '\\MAIN_SERVER\DATA\MyDatabase.GDB'.
      However, the following type of path *IS* valid: (e.g.)
      'D:\Data\Databases\Apps\MyDatabase.GDB'. }
    Path := FDBPath;

    { Set the Network Protocol that you are accessing the Interbase Server by.
      Generally speaking, if the Interbase Server is running locally ( i.e. on
      the same machine as this tutorial ) then the Protocol is cpLocal.
      If the Interbase Server is on another machine on a Windows95/WindowsNT
      network then you are most likely using cpNETBEUI or cpTCP_IP.
      cpNovell refers to the IPX/SPX protocol, *usually* only found on a Novell
      Netware network.
      Make sure you Include the file IB_Session when you reference the protocol
      directly like this in code. }
    Protocol := cpLocal;
  end; { with }
end;

procedure TfrmTutorial1.InitializeTransaction;
begin
  { The TIB_TransactionXXX components deal with Interbase Transactions. When
    you just need simple transactions, then use a TIB_TransactionSingle, but
    when, e.g., you need to have proper transaction control over 2 or more
    separate Databases, then use a TIB_TransactionDouble or
    TIB_TransactionMultiple repectively. }
  with tnMain do
  begin
    { If we are still in a transaction from design-time, then RollBack. }
    if InTransaction then Rollback;

    { Let's use AutoCommit for now beacuse it is easier. What is does is start
      and stop Transactions for you automatically. Generally, this is not
      considered good programming practice except is very specific
      circumstances, but it will do for us for now. Note that this is an
      IB_Objects feature that just makes it easier to deal with Transactions. }
    AutoCommit := True;

    { This transaction component has to be hooked up to the Database somehow
      else what data is it going to do transactions against? We do this through
      its IB_Connection property, and hook it up to the Connection component
      that we have already defined above. }
    IB_Connection := cnMain;

    { Set the Isolation appropriately. This defines the behaviour of this
      Transaction with respect to other transactions. See the Interbase
      documentation or the IB_Objects Help for more details.
      Let's use tiCommitted. }
    Isolation := tiCommitted;

    { RecVersion actually means 'Can we see an *earlier* Record Version?'. It is
      only meaningful when used with an Isolation (see above) of tiCommitted.
      If you set this property to TRUE, then Interbase does not try and present
      the latest record version to you if it is not available for whatever
      reason. If it is set to FALSE, and another user is busy with the same
      record, then a DeadLock situation could arise. }
    RecVersion := True;

  end; { with }
end;

procedure TfrmTutorial1.InitializeConnectionBar;
begin
  with barConnectionBar do
  begin
    { Set the Connection that this ConnectionBar will act upon. }
    IB_Connection := cnMain;
  end; { with }
end;

procedure TfrmTutorial1.cnMainBeforeConnect(Sender: TIB_Connection);
begin
  with Sender do
  begin
    if ( Protocol = cpLocal ) and not FileExists( FDBPath ) then
    begin
      with scrMain do begin
        IB_Connection := cnMain;
        IB_Transaction := tnMain;
        Execute;
      end; { with }
    end; { if }
  end; { with }
end;

end.
