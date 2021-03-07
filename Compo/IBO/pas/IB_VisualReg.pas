
{                                                                              }
{ IB_VisualReg                                                                 }
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
  IB_VisualReg;

interface

procedure Register;

implementation

uses
  Classes,

{$IFDEF IBO_VCL40_OR_GREATER}
  ActnList,
{$ENDIF}

  IB_Components,
  IB_Controls,
  IB_StatementGrid,
  IB_CursorGrid,
  IB_ArrayGrid,
  IB_Grid,
  IB_CGrid,
  IB_ParamEdit,
  IB_LocateEdit,
  IB_SearchEdit,
  IB_SearchPanel,
  IB_ConnectionBar,
  IB_DatasetBar,
  IB_NavigationBar,
  IB_SearchBar,
  IB_StatementBar,
  IB_TransactionBar,
  IB_UpdateBar,
  IB_UtilityBar,
  IB_IncSearch,
{$IFDEF IBO_VCL30_OR_GREATER}
  IB_Ledger,
{$IFDEF IBO_VCL40_OR_GREATER}
  IB_ActionNavigate,
  IB_ActionTransaction,
  IB_ActionUpdate,
  IB_ActionModule,
{$ENDIF}
{$ENDIF}
{$IFNDEF VER90}
{$IFDEF USELABELENH}
  IBC_CustomLabel,
{$ENDIF}
  IBC_Label,
{$ENDIF}
  DatePick,
  XSpin;

procedure Register;
begin
  RegisterComponents( 'iboControls', [ TIB_Text,
         {$IFDEF IBO_VCL30_OR_GREATER} TIB_Label,
                                       TIB_Edit,
                                       TIB_DateTimePicker, {$ENDIF}
                                       TIB_Date,
                                       TIB_Currency,
                                       TIB_Memo,
                                       TIB_RichEdit,
                                       TIB_Image,
                                       TIB_ListBox,
                                       TIB_ComboBox,
                                       TIB_CheckBox,
                                       TIB_RadioGroup,
                                       TIB_LookupList,
                                       TIB_LookupCombo ] );

  RegisterComponents( 'iboSearch', [ TIB_SearchPanel,
                                     TIB_SearchEdit,
                                     TIB_IncSearch,
                                     TIB_ParamEdit,
                                     TIB_LocateEdit ] );

  RegisterComponents( 'iboGrids', [ TIB_Grid,
                                    TIB_CtrlGrid,
      {$IFDEF IBO_VCL30_OR_GREATER} TIB_Ledger, {$ENDIF}
                                    TIB_ArrayGrid,
                                    TIB_CursorGrid,
                                    TIB_StatementGrid ] );

  RegisterComponents( 'iboBars', [ TIB_ConnectionBar,
                                   TIB_TransactionBar,
                                   TIB_StatementBar,
                                   TIB_DatasetBar,
                                   TIB_SearchBar,
                                   TIB_NavigationBar,
                                   TIB_UpdateBar,
                                   TIB_UtilityBar ] );

  RegisterComponents( 'iboMisc', [ TDatePick,
              {$IFDEF USELABELENH} TLabelEnh, {$ENDIF}
                                   TXSpinEdit ] );

{$IFDEF IBO_VCL40_OR_GREATER}
  RegisterActions( 'IB Navigate',
                   [ TIB_ActionFirst,
                     TIB_ActionPrior,
                     TIB_ActionNext,
                     TIB_ActionLast ],
                   TIB_StandardDatasets );
  RegisterActions( 'IB Update',
                   [ TIB_ActionOpen,
                     TIB_ActionClose,
                     TIB_ActionEdit,
                     TIB_ActionReadOnly,
                     TIB_ActionNew,
                     TIB_ActionPost,
                     TIB_ActionCancel,
                     TIB_ActionDelete,
                     TIB_ActionRefresh,
                     TIB_ActionRefreshKeys,
                     TIB_ActionRefreshRows ],
                   TIB_StandardDatasets );
  RegisterActions( 'IB Transaction',
                   [ TIB_ActionStart,
                     TIB_ActionCommitRetaining,
                     TIB_ActionRollbackRetaining,
                     TIB_ActionCommit,
                     TIB_ActionRollback ],
                   TIB_StandardDatasets );
{$ENDIF}

end;

end.
