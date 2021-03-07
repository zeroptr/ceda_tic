{******************************************************************************}
{                                                                              }
{           ReportBuilder Data Access Developement Environment (DADE)          }
{                                                                              }
{             Copyright (c) 1996-1999 Digital Metaphors Corporation            }
{                                                                              }
{                This unit is a modified version of daODBC98.pas               }
{                                                                              }
{                  Modified by Paul Gallagher   galagher@wi.net                }
{                                                                              }
{******************************************************************************}
{ History:
Feb-13-2000 : Telesis Computing <gworboys@zeta.org.au>
     - Replaced TIB_TransactionSingle with TIB_Transaction declaration to
     support recent changes in IBObjects.

Jan-20-2000 : Telesis Computing <gworboys@zeta.org.au>

     - Made it so that the default transactions will be created for the
     query objects used by DADE when necessary.  The default setup for
     IBObjects will automatically create default transactions where required.
     However it is possible to set IB_SessionProps.AllowDefaultTransaction to
     false, which means that transactions must be explicitly created.  So the
     updates to this unit create a transaction when IB_Session's
     AllowDefaultTransaction is false.  (With AutoCommit = true,
     Isolation = tiCommitted - which is the same as the standard IBO
     default transaction.)

     - Added four global procedures...

     * procedure daAddIBOGlobalDatabase( Database: TIB_Connection );
     * procedure daRemoveIBOGlobalDatabase( Database: TIB_Connection );
     These allow you to add/remove connection references at runtime.  Note
     that the default processing automatically adds connections from the
     current module, however if you have a connection on a separate module
     that you want added (eg. from a MDI main form) then you can use these
     functions.

     * procedure daAddIBOGlobalTransaction( Database: TIB_Connection;
         ATransact: TIB_Transaction );
     * procedure daRemoveIBOGlobalTransaction( Database: TIB_Connection;
         ATransact: TIB_Transaction );
     Gives runtime access to add/remove transactions from the list of
     available transactions.  So if you dont like the defaults that will be
     created, or you would rather use a specific transaction then simply
     add the desired transaction before running or designing the report.
     (Preferably remove the transaction reference again when the report is
     finished - to ensure that the transaction is not used by reports that
     are run later.  Note that the list is a global list, that will be
     used by ALL instances of reports in the application.)

     NB. Transactions added with these functions will NOT be freed.
     Care should be take to remove added transactions from the list BEFORE
     the actual transactions are freed.

     NB2. With Interbase a transaction my correspond to more than one database.
     If this is the case, call the functions for each transaction/connection
     pair required.

     NB3. The developer is responsible for committing or rolling back any
     transactions added to the list using the supplied functions.

     Warning: These functions use the component "Name" property for the
     connection/database identifier.  This may lead to problems if
     you use connections with the same name on different forms.

Jan-07-2000 : Greater than zero
     Added support to select Views (in GetTableNames)

}


unit daIBO;

interface

uses Classes, SysUtils, Forms, ExtCtrls,  DB,  //Contnrs,
     ppClass, ppComm, ppDBPipe, ppDB, ppClasUt, ppTypes,
     daDB, daQuery, daDataVw, daDatPrv,
     IBDataset,
     IB_Components,
     IB_StoredProc;

type

  { TdaChildIBOQuery }
  TdaChildIBOQuery = class(TIBOQuery)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildIBOQuery}

  { TdaChildIBOTable }
  TdaChildIBOTable = class(TIBOTable)
    public
      function HasParent: Boolean; override;
    end;  {class, TdaChildIBOTable}


  { TdaIBOSession }
  TdaIBOSession = class(TdaSession)
    private
      procedure AddDatabase(aDatabase: TComponent);

    protected

      procedure SetDataOwner(aDataOwner: TComponent); override;

    public

      class function ClassDescription: String; override;
      class function DataSetClass: TdaDataSetClass; override;
      class function DatabaseClass: TComponentClass; override;

      procedure GetDatabaseNames(aList: TStrings); override;
      function  GetDatabaseType(const aDatabaseName: String): TppDatabaseType; override;
      procedure GetTableNames(const aDatabaseName: String; aList: TStrings); override;
      function  ValidDatabaseTypes: TppDatabaseTypes; override;

  end; {class, TdaIBOSession}



  { TdaIBODataSet }
  TdaIBODataSet = class(TdaDataSet)
    private
      FQuery: TIBOQuery;

      function GetQuery: TIBOQuery;

    protected
      procedure BuildFieldList; override;
      function  GetActive: Boolean; override;
      procedure SetActive(Value: Boolean); override;
      procedure SetDatabaseName(const aDatabaseName: String); override;
      procedure SetDataName(const aDataName: String); override;

      property Query: TIBOQuery read GetQuery;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings); override;
      procedure GetFieldsForSQL(aList: TList; aSQL: TStrings); override;

  end; {class, TdaIBODataSet}


  { TdaIBOQueryDataView }
  TdaIBOQueryDataView = class(TdaQueryDataView)
    private
      FDataSource: TppChildDataSource;
      FQuery: TdaChildIBOQuery;

    protected
      procedure Loaded; override;
      procedure UpdateQueryObject;

      procedure SQLChanged; override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function PreviewFormClass: TFormClass; override;
      class function SessionClass: TClass; override;

      procedure Init; override;
      procedure ConnectPipelinesToData; override;

    published
      property DataSource: TppChildDataSource read FDataSource;

  end; {class, TdaIBOQueryDataView}


  {global functions to access default database}
  function daGetDefaultIBODatabase: TIBODatabase;

  {utility routines}
  procedure daGetIBODatabaseNames(aList: TStrings);
  function daGetIBODatabaseForName(aDatabaseName: String): TIB_Connection;
  function daGetIBOTransactionForName(aDatabaseName: String; IBODataset: TIBODataset): TIB_Transaction;

  function daGetIBODatabaseList: TppComponentList;

  procedure daAddIBOGlobalDatabase( Database: TIB_Connection );
  procedure daRemoveIBOGlobalDatabase( Database: TIB_Connection );
  procedure daAddIBOGlobalTransaction( Database: TIB_Connection; ATransact: TIB_Transaction );
  procedure daRemoveIBOGlobalTransaction( Database: TIB_Connection; ATransact: TIB_Transaction );

  {Delphi design time registration}
  procedure Register;


implementation

const
  cDefaultDatabase = 'DefaultIBODatabase';

var
  FIBODatabase: TIBODatabase;
  FIBODatabaseList: TppComponentList;
  FIBOTransactionList: TStringList;
  FIBOGlobalDatabaseList: TList;

{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}

procedure Register;
begin

  {IBO DataAccess Components}
  RegisterNoIcon([TdaChildIBOQuery, TdaChildIBOTable]);

  {IBO DataViews}
  RegisterNoIcon([TdaIBOQueryDataView]);



end;



{******************************************************************************
 *
 ** C H I L D   B D E  D A T A   A C C E S S   C O M P O N  E N T S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaChildIBOQuery.HasParent }

function TdaChildIBOQuery.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TdaChildIBOTable.HasParent }

function TdaChildIBOTable.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{******************************************************************************
 *
 ** I B O   S E S S I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaIBOSession.ClassDescription }

class function TdaIBOSession.ClassDescription: String;
begin
  Result := 'IBOSession';
end; {class function, ClassDescription}


{------------------------------------------------------------------------------}
{ TdaIBOSession.DataSetClass }

class function TdaIBOSession.DataSetClass: TdaDataSetClass;
begin
  Result := TdaIBODataSet;
end; {class function, DataSetClass}

{------------------------------------------------------------------------------}
{ TdaIBOSession.DatabaseClass }

class function TdaIBOSession.DatabaseClass: TComponentClass;
begin
  Result := TIB_Connection;
end;

{------------------------------------------------------------------------------}
{ TdaIBOSession.GetTableNames }

procedure TdaIBOSession.GetTableNames(const aDatabaseName: String; aList: TStrings);
var
  lDatabase: TIB_Connection;

begin
  {get the database}
  lDatabase := daGetIBODatabaseForName(aDatabaseName);

  {connection must be active to get table names}
  if not lDatabase.Connected then
    lDatabase.Connected := True;

  if lDatabase.Connected then begin
    alist.Assign(lDatabase.SchemaCache.TableNames);
    //next line added by greater than zero for views
    alist.AddStrings( lDatabase.SchemaCache.ViewNames );
  end;

end; {procedure, GetTableNames}


{------------------------------------------------------------------------------}
{ TdaIBOSession.AddDatabase }

procedure TdaIBOSession.AddDatabase(aDatabase: TComponent);
begin

  if daGetIBODatabaseList.IndexOf(aDatabase) < 0 then
    FIBODatabaseList.Add(aDatabase);

end; {procedure, AddDatabase}

{------------------------------------------------------------------------------}
{ TdaIBOSession.GetDatabaseNames }

procedure TdaIBOSession.GetDatabaseNames(aList: TStrings);
var
  liIndex: Integer;

begin
  {call utility routine to get list of database names}
  daGetIBODatabaseNames(aList);

  daGetDatabaseObjectsFromOwner(TdaSessionClass(Self.ClassType), aList, DataOwner);

  for liIndex := 0 to aList.Count-1 do
    if aList.Objects[liIndex] <> nil then
      AddDatabase(TComponent(aList.Objects[liIndex]));

end; {procedure, GetDatabaseNames}

{------------------------------------------------------------------------------}
{ TdaIBOSession.SetDataOwner }

procedure TdaIBOSession.SetDataOwner(aDataOwner: TComponent);
var
  lList: TStringList;
begin

  inherited SetDataOwner(aDataOwner);

  lList := TStringList.Create;

  GetDatabaseNames(lList);

  lList.Free;

end; {procedure, SetDataOwner}

{------------------------------------------------------------------------------}
{ TdaIBOSession.ValidDatabaseTypes }

function TdaIBOSession.ValidDatabaseTypes: TppDatabaseTypes;
begin
  Result := [dtInterBase];
end; {procedure, ValidDatabaseTypes}

{------------------------------------------------------------------------------}
{ TdaIBOSession.GetDatabaseType }

function TdaIBOSession.GetDatabaseType(const aDatabaseName: String): TppDatabaseType;
begin
  Result := dtInterBase;
end; {function, GetDatabaseType}



{******************************************************************************
 *
 ** I B O   D A T A S E T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.Create }

constructor TdaIBODataSet.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FQuery := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.Destroy }

destructor TdaIBODataSet.Destroy;
begin

  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.ClassDescription }

class function TdaIBODataSet.ClassDescription: String;
begin
  Result := 'IBODataSet';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.GetActive }

function TdaIBODataSet.GetActive: Boolean;
begin
  Result := GetQuery.Active;
end; {function, GetActive}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.SetActive }

procedure TdaIBODataSet.SetActive(Value: Boolean);
begin
  GetQuery.Active := Value;
end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.GetQuery }

function TdaIBODataSet.GetQuery: TIBOQuery;
begin

  if (FQuery = nil) then
    FQuery := TIBOQuery.Create(Self);

  Result := FQuery;

end; {procedure, GetQuery}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.SetDatabaseName }

procedure TdaIBODataSet.SetDatabaseName(const aDatabaseName: String);
begin

  inherited SetDatabaseName(aDatabaseName);

  {table cannot be active to set database property}
  if GetQuery.Active then
    FQuery.Active := False;

  {get IB database for name}
  FQuery.IB_Connection := daGetIBODatabaseForName(aDatabaseName);
  FQuery.IB_Transaction := daGetIBOTransactionForName(aDatabaseName,FQuery);

end; {procedure, SetDatabaseName}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.SetDataName }

procedure TdaIBODataSet.SetDataName(const aDataName: String);
begin

  inherited SetDataName(aDataName);

  {dataset cannot be active to set data name}
  if GetQuery.Active then
    FQuery.Active := False;

  {construct an SQL statment that returns an empty result set,
   this is used to get the field information }
  FQuery.SQL.Text := 'SELECT * FROM ' + aDataName +
                     ' WHERE ''c'' <> ''c'' ';

end; {procedure, SetDataName}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.BuildFieldList }

procedure TdaIBODataSet.BuildFieldList;
var
  liIndex: Integer;
  lQueryField: TField;
  lField: TppField;
begin

  inherited BuildFieldList;

  {set table to active}
  if not(GetQuery.Active) then
    FQuery.Active := True;

  {create TppField objects for each field in the table}
  for liIndex := 0 to FQuery.FieldCount - 1 do
    begin
      lQueryField := FQuery.Fields[liIndex];

      lField := TppField.Create(nil);

      lField.TableName    := DataName;
      lField.FieldName    := lQueryField.FieldName;
      lField.DataType     := ppConvertFieldType(lQueryField.DataType);

      AddField(lField);
    end;

end; {function, BuildFieldList}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.GetFieldNamesForSQL }

procedure TdaIBODataSet.GetFieldNamesForSQL(aList: TStrings; aSQL: TStrings);
var
  lQuery: TIBOQuery;
begin
  aList.Clear;

  {create a temporary IBO query}
  lQuery := TIBOQuery.Create(Self);

  {set the database and SQL properties}
  lQuery.IB_Connection := daGetIBODatabaseForName(DatabaseName);
  lQuery.IB_Transaction := daGetIBOTransactionForName(DatabaseName,lQuery);
  lQuery.SQL := aSQL;

  {get the field names}
  lQuery.GetFieldNames(aList);

  lQuery.Free;

end; {procedure, GetFieldNamesForSQL}

{------------------------------------------------------------------------------}
{ TdaIBODataSet.GetFieldsForSQL }

procedure TdaIBODataSet.GetFieldsForSQL(aList: TList; aSQL: TStrings);
var
  lQuery: TIBOQuery;
  lQueryField: TField;
  lField: TppField;
  liIndex: Integer;
begin
  aList.Clear;

  {create a temporary IBO query}
  lQuery := TIBOQuery.Create(Self);

  {assign databae and SQL properties}
  lQuery.IB_Connection := daGetIBODatabaseForName(DatabaseName);
  lQuery.IB_Transaction := daGetIBOTransactionForName(DatabaseName,lQuery);
  lQuery.SQL := aSQL;

  {set query to active}
  lQuery.Active := True;

  {create a TppField object for each field in the query}
  for liIndex := 0 to lQuery.FieldCount - 1 do
    begin
      lQueryField := lQuery.Fields[liIndex];

      lField := TppField.Create(nil);

      lField.FieldName    := lQueryField.FieldName;
      lField.DataType     := ppConvertFieldType(lQueryField.DataType);

      aList.Add(lField);
    end;

  lQuery.Free;

end; {procedure, GetFieldsForSQL}




{******************************************************************************
 *
 ** B D E  Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.Create }

constructor TdaIBOQueryDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {notes: 1. must use ChildQuery, ChildDataSource, ChildPipeline etc.
          2. use Self as owner for Query, DataSource etc.
          3. do NOT assign a Name }

  FQuery := TdaChildIBOQuery.Create(Self);

  FDataSource := TppChildDataSource.Create(Self);
  FDataSource.DataSet := FQuery;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.Destroy }

destructor TdaIBOQueryDataView.Destroy;
begin
  FDataSource.Free;
  FQuery.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.SessionClass }

class function TdaIBOQueryDataView.SessionClass: TClass;
begin
  Result := TdaIBOSession;
end; {class function, SessionClass}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.PreviewFormClass }

class function TdaIBOQueryDataView.PreviewFormClass: TFormClass;
begin
  Result := TFormClass(GetClass('TdaPreviewDataDialog'));
end; {class function, PreviewFormClass}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.Loaded }

procedure TdaIBOQueryDataView.Loaded;
begin

  inherited Loaded;

  UpdateQueryObject;

end; {procedure, Loaded}


{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.ConnectPipelinesToData }

procedure TdaIBOQueryDataView.ConnectPipelinesToData;
begin

  if DataPipelineCount = 0 then Exit;

  {need to reconnect here}
  TppDBPipeline(DataPipelines[0]).DataSource := FDataSource;


end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.Init }

procedure TdaIBOQueryDataView.Init;
var
  lDataPipeline: TppChildDBPipeline;

begin

  inherited Init;

  if DataPipelineCount > 0 then Exit;

  {note: DataView's owner must own the DataPipeline }
  lDataPipeline := TppChildDBPipeline(ppComponentCreate(Self, TppChildDBPipeline));
  lDataPipeline.DataSource := FDataSource;

  lDataPipeline.AutoCreateFields := False;

  {add DataPipeline to the dataview }
  lDataPipeline.DataView := Self;

end; {procedure, Init}


{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.SQLChanged }

procedure TdaIBOQueryDataView.SQLChanged;
begin

  UpdateQueryObject;

  inherited SQLChanged;

end; {procedure, WizardCompleted}

{------------------------------------------------------------------------------}
{ TdaIBOQueryDataView.UpdateQueryObject }

procedure TdaIBOQueryDataView.UpdateQueryObject;
begin

  if FQuery.Active then
    FQuery.Close;

  FQuery.IB_Connection := daGetIBODatabaseForName(SQL.DatabaseName);
  FQuery.IB_Transaction := daGetIBOTransactionForName(SQL.DatabaseName,FQuery);
  FQuery.SQL := SQL.SQLText;

end; {procedure, UpdateQueryObject}



{******************************************************************************
 *
 ** P R O C E D U R E S   A N D   F U N C T I O N S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ daGetDefaultIBODatabase }

function daGetDefaultIBODatabase: TIBODatabase;
begin

  {create the default IBO database, if needed}
  if (FIBODatabase = nil) then
    begin
      {create default IBO database}
      FIBODatabase := TIBODatabase.Create(nil);
      FIBODatabase.Name := cDefaultDatabase;
    end;

  Result := FIBODatabase

end; {function, daGetDefaultIBODatabase}



{------------------------------------------------------------------------------}
{ daGetIBODatabaseNames }

procedure daGetIBODatabaseNames(aList: TStrings);
var
    i: integer;
begin

  {could add hard-coded connection strings here, or could
   read from an .ini file }
  // Add databases from the global list...
  if FIBOGlobalDatabaseList <> nil then begin
    for i := 0 to FIBOGlobalDatabaseList.Count - 1 do begin
      aList.AddObject(
        TIB_Connection(FIBOGlobalDatabaseList.Items[i]).Name,
        FIBOGlobalDatabaseList.Items[i] );
    end;
  end;

end; {procedure, daGetIBODatabaseNames}

{------------------------------------------------------------------------------}
{ daGetIBODatabaseForName }

function daGetIBODatabaseForName(aDatabaseName: String): TIB_Connection;
var
  liIndex: Integer;

begin
  Result := nil;

  liIndex := 0;

 {check for a database object with this name}
  while (Result = nil) and (liIndex < daGetIBODatabaseList.Count) do
    begin
      if (AnsiCompareStr(FIBODatabaseList[liIndex].Name, aDatabaseName) = 0) or
         (AnsiCompareStr(TIBODatabase(FIBODatabaseList[liIndex]).DatabaseName, aDatabaseName) = 0) then
        Result :=  TIBODatabase(FIBODatabaseList[liIndex]);
      Inc(liIndex);
    end;

  if (Result <> nil) then Exit;


  {use the default database object}
  Result := daGetDefaultIBODatabase;

  {set DatabaseName property, if needed}
  if (Result.DatabaseName <> aDatabaseName) then
    begin
      if Result.Connected then
        Result.Connected := False;

      Result.DatabaseName := aDatabaseName;

    end;

end; {function, daGetIBODatabaseForName}

{------------------------------------------------------------------------------}
{ daGetIBOTransactionForName }
function daGetIBOTransactionForName(aDatabaseName: String;
    IBODataset: TIBODataset): TIB_Transaction;
var
    i: integer;
    Tran: TIB_Transaction;
begin
  // If IB_Session permits default transactions then let IBO create the
  // default when/where it is required...
  if IBODataset.IB_Session.AllowDefaultTransaction then begin
    Result := IBODataset.IB_Transaction; // no change from IBO default
  end else begin
    // otherwise see if a transaction has been defined in the global list
    // that may be appropriate for use...
    i := -1;
    if FIBOTransactionList <> nil then
        i := FIBOTransactionList.IndexOf( aDatabaseName );
    if i >= 0 then begin
      Result := TIB_Transaction(FIBOTransactionList.Objects[i]);
    end else begin
      // if no transaction found then create a default transaction
      Tran := TIB_TransactionDefault.Create( IBODataset );
      Tran.Name := 'pptr' + aDatabaseName;
      Tran.IB_Connection := IBODataset.IB_Connection;
      Tran.AutoCommit := true;
      Tran.Isolation := tiCommitted;
      Result := Tran;
    end;
  end;
end; {function, daGetIBOTransactionForName}

{------------------------------------------------------------------------------}
{ daGetIBODatabaseList }

function daGetIBODatabaseList: TppComponentList;
begin
  if (FIBODatabaseList = nil) then
    FIBODatabaseList := TppComponentList.Create(nil);

  Result := FIBODatabaseList;

end; {function, daGetIBODatabaseList}


{------------------------------------------------------------------------------}
// Allow runtime addition of databases to a global list - will be in
// addition to any automatically included from the current module.
procedure daAddIBOGlobalDatabase( Database: TIB_Connection );
begin
  if FIBOGlobalDatabaseList = nil then
    FIBOGlobalDatabaseList := TList.Create;
  if FIBOGlobalDatabaseList.IndexOf( Database ) < 0 then
    FIBOGlobalDatabaseList.Add( Database );
end;

{------------------------------------------------------------------------------}
// allow reversal of daAddIBOGlobalDatabase
procedure daRemoveIBOGlobalDatabase( Database: TIB_Connection );
begin
  if FIBOGlobalDatabaseList <> nil then begin
    FIBOGlobalDatabaseList.Remove( Database );
  end;
end;

{------------------------------------------------------------------------------}
// Adds a reference to the transaction for a particular database
// nb. One transaction may relate to more than one connection.
procedure daAddIBOGlobalTransaction( Database: TIB_Connection;
    ATransact: TIB_Transaction );
var
  i: integer;
  found: boolean;
begin
    if FIBOTransactionList = nil then begin
      FIBOTransactionList := TStringList.Create;
    end;
    found := false;
    i := FIBOTransactionList.Count - 1;
    while i >= 0 do begin
      if (Database.Name = FIBOTransactionList.Strings[i]) and
        (FIBOTransactionList.Objects[i] = ATransact) then begin
        found := true;
        break;
      end;
      Dec( i );
    end;
    if not found then
      FIBOTransactionList.AddObject( Database.Name, ATransact );
end;

{------------------------------------------------------------------------------}
// Removes a reference to the transaction for a particular database
// nb. One transaction may relate to more than one connection.
procedure daRemoveIBOGlobalTransaction( Database: TIB_Connection;
    ATransact: TIB_Transaction );
var
    i: integer;
begin
    if FIBOTransactionList <> nil then begin
      i := FIBOTransactionList.Count - 1;
      while i >= 0 do begin
        if (Database.Name = FIBOTransactionList.Strings[i]) and
          (FIBOTransactionList.Objects[i] = ATransact) then
          FIBOTransactionList.Delete( i );
        Dec( i );
      end;
    end;
end;


initialization

  {register the IBO descendant classes}
  RegisterClasses([TdaChildIBOQuery, TdaChildIBOTable]);

  {register DADE descendant session, dataset, dataview}
  daRegisterSession(TdaIBOSession);
  daRegisterDataSet(TdaIBODataSet);
  daRegisterDataView(TdaIBOQueryDataView);

  {initialize internal reference variables}
  FIBODatabase := nil;
  FIBODatabaseList := nil;
  FIBOTransactionList := nil;
  FIBOGlobalDatabaseList := nil;

finalization
  {Free any default transactions...}
  if FIBOTransactionList <> nil then
    FIBOTransactionList.Free;

  {free the default database object}
  if FIBODatabase <> nil then
    FIBODatabase.Free;
  if FIBODatabaseList <> nil then
    FIBODatabaseList.Free;
  if FIBOGlobalDatabaseList <> nil then
    FIBOGlobalDatabaseList := nil;

  {unregister the IBO descendant classes}
  UnRegisterClasses([TdaChildIBOQuery, TdaChildIBOTable]);

  {unregister DADE descendant the session, dataset, dataview}
  daUnRegisterSession(TdaIBOSession);
  daUnRegisterDataSet(TdaIBODataSet);
  daUnRegisterDataView(TdaIBOQueryDataView);

end.