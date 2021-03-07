{                                                                              }
{ IB_FTS_Scripts                                                               }
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
  IB_FTS_Scripts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, IB_Process, IB_Script;

type
  TdmFTS_Scripts = class(TDataModule)
    scLoadBase: TIB_Script;
    scDropBase: TIB_Script;
    scLoadMeta: TIB_Script;
    scDropMeta: TIB_Script;
    scLoadIndx: TIB_Script;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetConnection( AValue: TIB_Connection );
    procedure SetMacroEvent( AValue: TIB_MacroSubstituteEvent );
  end;

implementation

{$R *.DFM}

procedure TdmFTS_Scripts.SetConnection( AValue: TIB_Connection );
begin
  scLoadBase.IB_Connection := AValue;
  scDropBase.IB_Connection := AValue;
  scLoadMeta.IB_Connection := AValue;
  scDropMeta.IB_Connection := AValue;
  scLoadIndx.IB_Connection := AValue;
end;

procedure TdmFTS_Scripts.SetMacroEvent( AValue: TIB_MacroSubstituteEvent );
begin
  scLoadBase.OnMacroSubstitute := AValue;
  scDropBase.OnMacroSubstitute := AValue;
  scLoadMeta.OnMacroSubstitute := AValue;
  scDropMeta.OnMacroSubstitute := AValue;
  scLoadIndx.OnMacroSubstitute := AValue;
end;

end.
 