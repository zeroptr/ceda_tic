unit MyRecord;

interface

uses
  Classes, IB_Components;

type
  TMyRecord = class(TPersistent)
  private
    fConnection : TIB_Connection;
    fTransaction : TIB_Transaction;
    SQLGenerateMyRecordNr, SQLSelectMyRecord, SQLInsertMyRecord, SQLEditMyRecord, SQLDeleteMyRecord : TIB_DSQL;
    procedure CreateSQLProcedures;
    procedure DestroySQLProcedures;
  protected
  public
    MyRecordNr : Integer;
    MyField : String;
    constructor Create(aConnection : TIB_Connection);
    destructor Destroy; override;
    procedure Refresh;
    procedure Append(GenerateKey : Boolean);
    procedure Edit;
    procedure Delete;
  published
  end;

implementation

procedure TMyRecord.CreateSQLProcedures;
begin
  SQLGenerateMyRecordNr := TIB_DSQL.Create(Nil);
  SQLGenerateMyRecordNr.IB_Connection := fConnection;
  SQLGenerateMyRecordNr.IB_Transaction := fTransaction;
  SQLGenerateMyRecordNr.SQL.Clear;
  SQLGenerateMyRecordNr.SQL.Add('EXECUTE PROCEDURE GETMYRECORDNR');
  SQLGenerateMyRecordNr.Prepare;
  SQLSelectMyRecord := TIB_DSQL.Create(Nil);
  SQLSelectMyRecord.IB_Connection := fConnection;
  SQLSelectMyRecord.IB_Transaction := fTransaction;
  SQLSelectMyRecord.SQL.Clear;
  SQLSelectMyRecord.SQL.Add('select * from MyTable where MyRecordnr = :MyRecordnr');
  SQLSelectMyRecord.Prepare;
  SQLInsertMyRecord := TIB_DSQL.Create(Nil);
  SQLInsertMyRecord.IB_Connection := fConnection;
  SQLInsertMyRecord.IB_Transaction := fTransaction;
  SQLInsertMyRecord.SQL.Clear;
  SQLInsertMyRecord.SQL.Add('insert into MyTable(MyRecordnr, MyField) values(:MyRecordnr, :MyField)');
  SQLInsertMyRecord.Prepare;
  SQLEditMyRecord := TIB_DSQL.Create(Nil);
  SQLEditMyRecord.IB_Connection := fConnection;
  SQLEditMyRecord.IB_Transaction := fTransaction;
  SQLEditMyRecord.SQL.Clear;
  SQLEditMyRecord.SQL.Add('update MyTable set MyField=:MyField where MyRecordnr=:MyRecordnr');
  SQLEditMyRecord.Prepare;
  SQLDeleteMyRecord := TIB_DSQL.Create(Nil);
  SQLDeleteMyRecord.IB_Connection := fConnection;
  SQLDeleteMyRecord.IB_Transaction := fTransaction;
  SQLDeleteMyRecord.SQL.Clear;
  SQLDeleteMyRecord.SQL.Add('delete from MyTable where MyRecordnr=:MyRecordnr');
  SQLDeleteMyRecord.Prepare;
end;

procedure TMyRecord.DestroySQLProcedures;
begin
  SQLDeleteMyRecord.Free;
  SQLEditMyRecord.Free;
  SQLInsertMyRecord.Free;
  SQLSelectMyRecord.Free;
  SQLGenerateMyRecordNr.Free;
end;

constructor TMyRecord.Create(aConnection : TIB_Connection);
begin
  inherited Create;
  fConnection := aConnection;
  fTransaction := TIB_Transaction.Create(Nil);
  fTransaction.IB_Connection := fConnection;
  fTransaction.AutoCommit := False;
  fTransaction.Isolation := tiCommitted;
  fTransaction.LockWait := False;
  fTransaction.RecVersion := False;
  fTransaction.ServerAutoCommit := False;
  CreateSQLProcedures;
end;

destructor TMyRecord.Destroy;
begin
  DestroySQLProcedures;
  fTransaction.Free;
  inherited Destroy;
end;

procedure TMyRecord.Refresh;
begin
  fTransaction.Start;
  SQLSelectMyRecord.ParamByName('MyRecordNr').AsInteger := MyRecordNr;
  SQLSelectMyRecord.ExecSQL;
  MyRecordNr := SQLSelectMyRecord.FieldByName('MyRecordnr').AsInteger;
  MyField := SQLSelectMyRecord.FieldByName('MyRecord').AsString;
end;

procedure TMyRecord.Append(GenerateKey : Boolean);
begin
  fTransaction.Start;
  if GenerateKey then
  begin
    SQLGenerateMyRecordNr.ExecSQL;
    MyRecordNr := SQLGenerateMyRecordNr.FieldByName('MyRecordNr').AsInteger;
  end;
  SQLInsertMyRecord.ParamByName('MyRecordNr').AsInteger := MyRecordNr;
  SQLInsertMyRecord.ParamByName('MyField').AsString := MyField;
  SQLInsertMyRecord.ExecSQL;
  fTransaction.Commit;
end;

procedure TMyRecord.Edit;
begin
  fTransaction.Start;
  SQLEditMyRecord.ParamByName('MyRecordNr').AsInteger := MyRecordNr;
  SQLEditMyRecord.ParamByName('MyField').AsString := MyField;
  SQLEditMyRecord.ExecSQL;
  fTransaction.Commit;
end;

procedure TMyRecord.Delete;
begin
  fTransaction.Start;
  SQLDeleteMyRecord.ParamByName('MyRecordNr').AsInteger := MyRecordNr;
  SQLDeleteMyRecord.ExecSQL;
  fTransaction.Commit;
end;

end.
