
{                                                                              }
{  IBF_WorkUnit                                                                }
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
  IBF_WorkUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, StdCtrls, ExtCtrls, Controls,
  Dialogs, ComCtrls,

  IBF_Base,

  IB_Components,
  IB_TransactionSource,
  IB_ConnectionSource;

type
  TfrmWorkUnit = class(TfrmBase)
    dsqlWL: TIB_DSQL;
    trWL: TIB_Transaction;
    pnNavButtons: TPanel;
    btBack: TButton;
    btNext: TButton;
    procedure FormCreate(Sender: TObject);
    procedure tsWorkUnitStatusChanged(Sender: TIB_TransactionLink;
      ATransaction: TIB_Transaction);
    procedure tsWorkUnitPostPendingChanged(Sender: TIB_TransactionLink;
      ATransaction: TIB_Transaction);
    procedure csBaseAfterAssignment(Sender: TIB_ConnectionLink;
      AConnection: TIB_Connection);
    procedure btNavClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure AfterCompleteWorkUnit( Commit: boolean ); override;
    procedure DoPostWorkLog( WasCommitted: boolean ); virtual;
    procedure DoNavButtonClick( MoveForward: boolean ); virtual;
  public
    { Public declarations }
    procedure Initialize; override;
  end;

implementation

{$R *.DFM}

procedure TfrmWorkUnit.FormCreate(Sender: TObject);
begin
  inherited;
  AlwaysSaveSettings := true;
end;

procedure TfrmWorkUnit.Initialize;
begin
  inherited Initialize;
  if WorkUnitNumber = 0 then
    SysStartWorkUnit;
end;

procedure TfrmWorkUnit.tsWorkUnitStatusChanged(Sender: TIB_TransactionLink;
  ATransaction: TIB_Transaction);
begin
  RefreshButtons;
end;

procedure TfrmWorkUnit.tsWorkUnitPostPendingChanged(
  Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
begin
  RefreshButtons;
end;

procedure TfrmWorkUnit.csBaseAfterAssignment(Sender: TIB_ConnectionLink;
  AConnection: TIB_Connection);
begin
  inherited;
  trWL.IB_Connection := AConnection;
  dsqlWL.IB_Connection := AConnection;
end;

procedure TfrmWorkUnit.AfterCompleteWorkUnit( Commit: boolean );
begin
  try
    DoPostWorkLog( Commit );
    if trWL.Started or trWL.TransactionIsActive or trWL.InTransaction then
      trWL.Commit;
  except
    Application.HandleException( Self );
  end;
  inherited AfterCompleteWorkUnit( Commit );
end;

procedure TfrmWorkUnit.btNavClick(Sender: TObject);
begin
  inherited;
  DoNavButtonClick( Sender = btNext );
  RefreshButtons;
end;

procedure TfrmWorkUnit.DoPostWorkLog( WasCommitted: boolean );
begin
// Abstract
end;

procedure TfrmWorkUnit.DoNavButtonClick( MoveForward: boolean );
begin
// Abstract
end;

end.
 
