
{******************************************}
{                                          }
{             FastReport v3.0              }
{          XXX components RTTI             }
{                                          }

// Copyright
{                                          }
{******************************************}

unit frxXXXRTTI;

interface

{$I frx.inc}

implementation

uses
  Windows, Classes, fs_iinterpreter, frxXXXComponents
{$IFDEF Delphi6}
, Variants
{$ENDIF};


type
  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; Caller: TfsMethodHelper): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;


{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    AddClass(TfrxXXXDatabase, 'TfrxCustomDatabase');
    AddClass(TfrxXXXTable, 'TfrxCustomTable');
    with AddClass(TfrxXXXQuery, 'TfrxCustomQuery') do
      AddMethod('procedure ExecSQL', CallMethod);
  end;
end;

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result := 0;

  if ClassType = TfrxXXXQuery then
  begin
    if MethodName = 'EXECSQL' then
      TfrxXXXQuery(Instance).Query.ExecSQL
  end
end;


initialization
  fsRTTIModules.Add(TFunctions);

end.
