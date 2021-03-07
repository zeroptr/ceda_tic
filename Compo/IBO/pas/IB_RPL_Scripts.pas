
{                                                                              }
{ IB_RPL_Scripts                                                               }
{                                                                              }

{***************************************************************}
{                                                               }
{          IB Objects Components and Resources Library          }
{                                                               }
{          Copyright (C) 1996-2001 Jason Wharton                }
{          and Computer Programming Solutions, Mesa, AZ         }
{                                                               }
{  This source code unit is released under the terms of the     }
{  CPS Trustware License.                                       }
{  It may be distributed or deployed as source code or in       }
{  compiled form only in compliance with the terms and          }
{  conditions of the CPS Trustware License which may be         )
{  examined at http://www.ibobjects.com/ibo_trustware.html      )
{                                                               }
{***************************************************************}

{******************************************************************************}
{  CONTRIBUTED MODIFICATIONS                                                   }
{  Additions or modifications listed below using format:                       }
{                                                                              }
{  Joe Citizen <joe@joecitizen.com>                                            }
{  mm/dd/yyyy                                                                  }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{            Copyright (C) 2001 Joe Citizen                                    }
{                                                                              }
{------------------------------------------------------------------------------}
{  Place your credits and information in the top of the section                }
{  below with any other descriptions or explanations desired.                  }
{------------------------------------------------------------------------------}
{                                                                              }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_RPL_Scripts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  IB_Header,
  IB_Components,
  IB_Process,
  IB_Script;

type
  TdmRPL_Scripts = class(TDataModule)
    scDSTLoadBase: TIB_Script;
    scDSTDropBase: TIB_Script;
    scSRCLoadMeta: TIB_Script;
    scSRCDropMeta: TIB_Script;
    scDSTLoadMeta: TIB_Script;
    scDSTDropMeta: TIB_Script;
    scDSTLoadProc: TIB_Script;
    scDSTDropProc: TIB_Script;
    scSRCLoadProc: TIB_Script;
    scSRCDropProc: TIB_Script;
    trDST: TIB_Transaction;
    trSRC: TIB_Transaction;
    procedure ScriptError(Sender: TObject; const ERRCODE: Integer;
      ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Integer;
      SQLMessage, SQL: TStringList; var RaiseException: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetConnection( Src, Dst: TIB_Connection );
    procedure SetMacroEvent( AValue: TIB_MacroSubstituteEvent );
  end;

implementation

{$R *.DFM}

procedure TdmRPL_Scripts.SetConnection( Src, Dst: TIB_Connection );
begin
  scSRCLoadMeta.IB_Connection := Src;
  scSRCDropProc.IB_Connection := Src;
  scSRCLoadProc.IB_Connection := Src;
  scSRCDropMeta.IB_Connection := Src;
  scDSTLoadBase.IB_Connection := Dst;
  scDSTDropBase.IB_Connection := Dst;
  scDSTLoadMeta.IB_Connection := Dst;
  scDSTDropMeta.IB_Connection := Dst;
  scDSTLoadProc.IB_Connection := Dst;
  scDSTDropProc.IB_Connection := Dst;
  trDST.IB_Connection := Dst;
  trSRC.IB_Connection := Src;
end;

procedure TdmRPL_Scripts.SetMacroEvent( AValue: TIB_MacroSubstituteEvent );
begin
  scDSTLoadBase.OnMacroSubstitute := AValue;
  scDSTDropBase.OnMacroSubstitute := AValue;
  scSRCLoadMeta.OnMacroSubstitute := AValue;
  scDSTLoadMeta.OnMacroSubstitute := AValue;
  scSRCDropMeta.OnMacroSubstitute := AValue;
  scDSTDropMeta.OnMacroSubstitute := AValue;
  scSRCLoadProc.OnMacroSubstitute := AValue;
  scDSTLoadProc.OnMacroSubstitute := AValue;
  scSRCDropProc.OnMacroSubstitute := AValue;
  scDSTDropProc.OnMacroSubstitute := AValue;
end;

procedure TdmRPL_Scripts.ScriptError(Sender: TObject;
  const ERRCODE: Integer; ErrorMessage, ErrorCodes: TStringList;
  const SQLCODE: Integer; SQLMessage, SQL: TStringList;
  var RaiseException: Boolean);
begin
  if ( ErrCode = isc_no_meta_update ) then
  begin
    if ( Pos( 'NOT FOUND', UpperCase( ErrorMessage.Text )) = 0 ) and
       ( Pos( 'DEFINE GENERATOR failed', ErrorMessage.Text ) = 0 ) then
    RaiseException := true;
  end
  else
  begin
    if ( Pos( 'OBJECT ', UpperCase( ErrorMessage.Text )) <> 0 ) and
       ( Pos( ' IS IN USE', UpperCase( ErrorMessage.Text )) <> 0 ) then
    RaiseException := true;
  end;
end;

{
EMPLOYEE
EMP_NO
PHONE
EMP_NO

EMP_NO     SMALLINT      NOT NULL,
FIRST_NAME VARCHAR( 15 ) NOT NULL,
LAST_NAME  VARCHAR( 20 ) NOT NULL,
PHONE_EXT  VARCHAR( 4 )

( new.emp_no <> old.emp_no ) or
( new.first_name <> old.first_name ) or
( new.last_name <> old.Last_name ) or
( new.phone_ext <> old.phone_ext ) or
(( new.phone_ext is null ) and ( old.phone_ext is not null )) or
(( new.phone_ext is not null ) and ( old.phone_ext is null ))
}

end.


