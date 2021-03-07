unit unRegistry;
interface
  uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Registry;

  function ReadStringFromRegistry(Key:String;Ident:String):String ;
  function WriteToRegistry(Key:String;Ident:String;Value:Variant):Boolean ;
  Const
     RootKey = HKEY_LOCAL_MACHINE;
     RegSection = 'Ceda';
     PrintSubSection = 'Print';
     UserSubSection = 'User';

implementation

function ReadStringFromRegistry(Key:String;Ident:String):String ;
var
  Regi:TRegistry;
begin
  try
    try
      Regi := TRegistry.Create;
      Regi.OpenKey(Key,True);
      Result := Regi.ReadString(Ident);
    except
      Result := '';
    end;
  finally
    Regi.Free;
  end;
end;

function WriteToRegistry(Key:String;Ident:String;Value:Variant):Boolean ;
var
  Regi:TRegistry;
begin
  try
    try
      Regi := TRegistry.Create;
      regi.OpenKey(Key,True);
      if VarIsNumeric(Value) then Regi.WriteInteger(Ident,StrToInt(Value));
      if VarIsStr(Value) then Regi.WriteString(Ident,value);
      Result := True;
    except
      Result := False;
    end;
  finally
    Regi.Free;
  end;
end;

end.
