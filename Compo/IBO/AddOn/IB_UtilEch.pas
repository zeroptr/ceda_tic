{****************************************************}
{*            Unit IB_UtilEch v1.0                  *}
{*   (c) 2001 by Dmitry Beloshistov [-=BDS=-]       *}
{*         e-mail: torin@scm.com.ua                 *}
{****************************************************}
unit IB_UtilEch;

interface
Uses IB_Components;

Function TableExists(IBConnection:TIB_Connection; TableName:String):boolean;
Function TriggerExists(IBConnection:TIB_Connection; TriggerName:String):boolean;
Function ProcedureExists(IBConnection:TIB_Connection; ProcName:String):boolean;
Function ViewExists(IBConnection:TIB_Connection; ViewName:String):boolean;
Function GeneratorExists(IBConnection:TIB_Connection; GenName:String):boolean;
Function DomainExists(IBConnection:TIB_Connection; DomainName:String):boolean;
Function UDFExists(IBConnection:TIB_Connection; UDFName:String):boolean;
Function ExceptionExists(IBConnection:TIB_Connection; ExceptName:String):boolean;
Function RoleExists(IBConnection:TIB_Connection; RoleName:String):boolean;

implementation
Uses SysUtils;

function TableExists(IBConnection:TIB_Connection; TableName:String):boolean;
var Q:TIB_Query;
begin
 Result:=False;
 if not Assigned(IBConnection) then raise Exception.Create('IB connection are not assigned!');
 Q:=TIB_Query.Create(nil);
 try
  Q.IB_Connection:=IBConnection;
  with Q do
   begin
    close; sql.clear;
    sql.add('select * from RDB$RELATIONS where RDB$RELATION_NAME=?TableName');
    Prepare;
    ParamValues['TableName']:=TableName;
    Open;
    Result:=not IsEmpty;
    close;
   end;
 finally
   Q.Free;
 end;
end;

Function TriggerExists(IBConnection:TIB_Connection; TriggerName:String):boolean;
var Q:TIB_Query;
begin
 Result:=False;
 if not Assigned(IBConnection) then raise Exception.Create('IB connection are not assigned!');
 Q:=TIB_Query.Create(nil);
 try
  Q.IB_Connection:=IBConnection;
  with Q do
   begin
    close; sql.clear;
    sql.add('select * from RDB$TRIGGERS where RDB$TRIGGER_NAME=?TriggerName');
    Prepare;
    ParamValues['TriggerName']:=TriggerName;
    Open;
    Result:=(not IsEmpty);
    close;
   end;
 finally
   Q.Free;
 end;
end;

function ProcedureExists(IBConnection:TIB_Connection; ProcName:String):boolean;
var Q:TIB_Query;
begin
 Result:=False;
 if not Assigned(IBConnection) then raise Exception.Create('IB connection are not assigned!');
 Q:=TIB_Query.Create(nil);
 try
  Q.IB_Connection:=IBConnection;
  with Q do
   begin
    close; sql.clear;
    sql.add('select * from RDB$PROCEDURES where RDB$PROCEDURE_NAME=?ProcName');
    Prepare;
    ParamValues['ProcName']:=ProcName;
    Open;
    Result:=(not IsEmpty);
    close;
   end;
 finally
   Q.Free;
 end;
end;

function ViewExists(IBConnection:TIB_Connection; ViewName:String):boolean;
var Q:TIB_Query;
begin
 Result:=False;
 if not Assigned(IBConnection) then raise Exception.Create('IB connection are not assigned!');
 Q:=TIB_Query.Create(nil);
 try
  Q.IB_Connection:=IBConnection;
  with Q do
   begin
    close; sql.clear;
    sql.add('select * from RDB$RELATIONS where RDB$RELATION_NAME=?ViewName');
    sql.add('and not(RDB$VIEW_SOURCE is NULL)');
    Prepare;
    ParamValues['ViewName']:=ViewName;
    Open;
    Result:=(not IsEmpty) and (Trim(FieldByName('RDB$VIEW_SOURCE').AsString)<>'');
    close;
   end;
 finally
   Q.Free;
 end;
end;

function GeneratorExists(IBConnection:TIB_Connection; GenName:String):boolean;
var Q:TIB_Query;
begin
 Result:=False;
 if not Assigned(IBConnection) then raise Exception.Create('IB connection are not assigned!');
 Q:=TIB_Query.Create(nil);
 try
  Q.IB_Connection:=IBConnection;
  with Q do
   begin
    close; sql.clear;
    sql.add('select * from RDB$GENERATORS where RDB$GENERATOR_NAME=?GenName');
    Prepare;
    ParamValues['GenName']:=GenName;
    Open;
    Result:=(not IsEmpty);
    close;
   end;
 finally
   Q.Free;
 end;
end;

function DomainExists(IBConnection:TIB_Connection; DomainName:String):boolean;
var Q:TIB_Query;
begin
 Result:=False;
 if not Assigned(IBConnection) then raise Exception.Create('IB connection are not assigned!');
 Q:=TIB_Query.Create(nil);
 try
  Q.IB_Connection:=IBConnection;
 with Q do
  begin
   close; sql.clear;
   sql.add('select * from RDB$FIELDS where RDB$FIELD_NAME=?DOMAINNAME');
   Prepare;
   ParamValues['DOMAINNAME']:=DomainName;
   Open;
   Result:=not IsEmpty;
   Close;
  end;
 finally
   Q.Free;
 end;
end;

Function UDFExists(IBConnection:TIB_Connection; UDFName:String):boolean;
var Q:TIB_Query;
begin
 Result:=False;
 if not Assigned(IBConnection) then raise Exception.Create('IB connection are not assigned!');
 Q:=TIB_Query.Create(nil);
 try
  Q.IB_Connection:=IBConnection;
 with Q do
  begin
   close;
   sql.clear;
   sql.add('select * from RDB$FUNCTIONS where RDB$FUNCTION_NAME=?UDFNAME');
   Prepare;
   ParamValues['UDFNAME']:=UDFName;
   Open;
   Result:=not IsEmpty;
   Close;
  end;
 finally
  Q.Free;
 end;
end;

Function ExceptionExists(IBConnection:TIB_Connection; ExceptName:String):boolean;
var Q:TIB_Query;
begin
 Result:=False;
 if not Assigned(IBConnection) then raise Exception.Create('IB connection are not assigned!');
 Q:=TIB_Query.Create(nil);
 try
 Q.IB_Connection:=IBConnection;
 with Q do
  begin
   close;
   sql.clear;
   sql.add('select * from RDB$EXCEPTIONS');
   sql.add('where RDB$EXCEPTION_NAME=?EXNAME');
   Prepare;
   ParamValues['EXNAME']:=ExceptName;
   Open;
   Result:=not isEmpty;
   Close;
  end;
 finally
  Q.Free;
 end;
end;


Function RoleExists(IBConnection:TIB_Connection; RoleName:String):boolean;
var Q:TIB_Query;
begin
 Result:=False;
 if not Assigned(IBConnection) then raise Exception.Create('IB connection are not assigned!');
 Q:=TIB_Query.Create(nil);
 try
 Q.IB_Connection:=IBConnection;
 if TableExists(IBConnection,'RDB$ROLES') then
  begin
   with Q do
    begin
     close;
     sql.clear;
     sql.add('select * from RDB$ROLES');
     sql.add('where RDB$ROLE_NAME=?ROLENAME');
     Prepare;
     ParamValues['ROLENAME']:=RoleName;
     Open;
     Result:=not isEmpty;
     Close;
    end;
  end
 else Result:=False;
 finally
  Q.Free;
 end;
end;

end.
