
{                                                                              }
{ IB_FormsReg                                                                  }
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
  IB_FormsReg;

{$INCLUDE IB_Directives.inc}

interface

procedure Register;

implementation

uses
  Classes,

  IB_Session,
  IB_Constants,
  IB_Components,
  IB_Dialogs;

procedure Register;
begin
  RegisterComponents( 'iboDialogs', [ TIB_DSQLDialog,
                                      TIB_LookupDialog,
                                      TIB_BrowseDialog,
                                      TIB_ScriptDialog,
                                      TIB_DDL_ExtractDialog,
                                      TIB_MetadataDialog,
                                      TIB_EventsDialog,
                                      TIB_ExportDialog,
                                      TIB_DataDumpDialog,
                                      TIB_DataPumpDialog,
                                      TIB_MonitorDialog,
                                      TIB_ProfilerDialog,
                                      TIB_StatusDialog ] );
end;

end.
