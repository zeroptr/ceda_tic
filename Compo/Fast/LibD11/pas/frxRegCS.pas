
{******************************************}
{                                          }
{             FastReport v4.0              }
{            Registration unit             }
{                                          }
{         Copyright (c) 1998-2009          }
{         by Alexander Fediachov,          }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxRegCS;

{$I frx.inc}

interface

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFNDEF Delphi6}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors,
{$ENDIF}
  frxServer, frxServerClient, frxHTTPClient;

{-----------------------------------------------------------------------}
procedure Register;
begin
  RegisterComponents('FastReport 4.0 Client/Server',
    [TfrxReportServer, TfrxServerConnection, TfrxReportClient, 
    TfrxHTTPClient]);
end;

end.
