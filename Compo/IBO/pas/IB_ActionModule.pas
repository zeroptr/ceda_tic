
{                                                                              }
{ IB_ActionModule                                                              }
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
  IB_ActionModule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_ActionUpdate, IB_ActionNavigate, IB_ActionTransaction, ActnList,
  ImgList;

type
  TIB_StandardDatasets = class(TDataModule)
    ImageList1: TImageList;
    ActionList1: TActionList;
    IB_ActionStart: TIB_ActionStart;
    IB_ActionCommitRetaining: TIB_ActionCommitRetaining;
    IB_ActionRollbackRetaining: TIB_ActionRollbackRetaining;
    IB_ActionCommit: TIB_ActionCommit;
    IB_ActionRollback: TIB_ActionRollback;
    IB_ActionOpen: TIB_ActionOpen;
    IB_ActionClose: TIB_ActionClose;
    IB_ActionFirst: TIB_ActionFirst;
    IB_ActionPrior: TIB_ActionPrior;
    IB_ActionNext: TIB_ActionNext;
    IB_ActionLast: TIB_ActionLast;
    IB_ActionNew: TIB_ActionNew;
    IB_ActionEdit: TIB_ActionEdit;
    IB_ActionDelete: TIB_ActionDelete;
    IB_ActionPost: TIB_ActionPost;
    IB_ActionCancel: TIB_ActionCancel;
    IB_ActionRefresh: TIB_ActionRefresh;
    IB_ActionRefreshKeys: TIB_ActionRefreshKeys;
    IB_ActionRefreshRows: TIB_ActionRefreshRows;
    IB_ActionReadOnly: TIB_ActionReadOnly;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IB_StandardDatasets: TIB_StandardDatasets;

implementation

{$R *.DFM}

end.
