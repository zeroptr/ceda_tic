{********************************************}
{   TIWChart Component                       }
{   IntraWeb Compatible TeeChart             }
{   Design-Time Registration Unit            }
{                                            }
{   Copyright (c) 2002-2007 by David Berneda }
{   All Rights Reserved                      }
{                                            }
{   Intraweb is Copyright:                   }
{   Copyright © 2001-2007 AToZed Software.   }
{   All rights Reserved.                     }
{********************************************}
{$I TeeDefs.inc}
unit IWComTeeChartReg;

interface

uses {$IFNDEF D6}
     DsgnIntf,
     {$ELSE}
     DesignIntf, DesignEditors,
     {$ENDIF}
     IWCompTeeChart;

Procedure Register;

implementation

uses 
  Classes;

{$R IWCompTeeChart.dcr}

Procedure Register;
begin
  RegisterComponents('IW TeeChart',[TIWChart]);
end;

end.
