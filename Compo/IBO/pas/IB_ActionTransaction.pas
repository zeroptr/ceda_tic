{                                                                              }
{ IB_ActionTransaction                                                         }
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
  IB_ActionTransaction;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, IB_Components, IB_TransactionSource,
  IB_Constants;

type
  TIB_CustomActionTransaction = class(TAction)
  private
    { Private-Deklarationen }
    FIB_TransactionSource: TIB_TransactionSource;
    procedure SetTransaction(AValue: TIB_Transaction);
    function GetTransaction: TIB_Transaction;
  protected
    { Protected-Deklarationen }
    procedure StatusChanged(Sender: TIB_TransactionLink;ATransaction: TIB_Transaction); virtual;
    property IB_Transaction: TIB_Transaction read GetTransaction write SetTransaction;
  public
    { Public-Deklarationen }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HandlesTarget(Target: TObject): Boolean; override;
  published
    { Published-Deklarationen }
  end;

  TIB_ActionStart = class(TIB_CustomActionTransaction)
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
    procedure StatusChanged(Sender: TIB_TransactionLink;ATransaction: TIB_Transaction); override;
  public
    { Public-Deklarationen }
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    { Published-Deklarationen }
    property IB_Transaction;
  end;

  TIB_ActionCommitRetaining = class(TIB_CustomActionTransaction)
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
    procedure StatusChanged(Sender: TIB_TransactionLink;ATransaction: TIB_Transaction); override;
  public
    { Public-Deklarationen }
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    { Published-Deklarationen }
    property IB_Transaction;
  end;

  TIB_ActionRollbackRetaining = class(TIB_CustomActionTransaction)
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
    procedure StatusChanged(Sender: TIB_TransactionLink;ATransaction: TIB_Transaction); override;
  public
    { Public-Deklarationen }
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    { Published-Deklarationen }
    property IB_Transaction;
  end;

  TIB_ActionCommit = class(TIB_CustomActionTransaction)
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
    procedure StatusChanged(Sender: TIB_TransactionLink;ATransaction: TIB_Transaction); override;
  public
    { Public-Deklarationen }
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    { Published-Deklarationen }
    property IB_Transaction;
  end;

  TIB_ActionRollback = class(TIB_CustomActionTransaction)
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
    procedure StatusChanged(Sender: TIB_TransactionLink;ATransaction: TIB_Transaction); override;
  public
    { Public-Deklarationen }
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    { Published-Deklarationen }
    property IB_Transaction;
  end;

implementation

constructor TIB_CustomActionTransaction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIB_TransactionSource := TIB_TransactionSource.Create(Self);
  FIB_TransactionSource.OnStatusChanged := StatusChanged;
end;

destructor TIB_CustomActionTransaction.Destroy;
begin
  FIB_TransactionSource.Free;
  FIB_TransactionSource := nil;
  inherited Destroy;
end;

procedure TIB_CustomActionTransaction.SetTransaction;
begin
  FIB_TransactionSource.IB_Transaction := AValue;
  StatusChanged(nil, AValue);
end;

function TIB_CustomActionTransaction.GetTransaction: TIB_Transaction;
begin
  Result := FIB_TransactionSource.IB_Transaction;
end;

function TIB_CustomActionTransaction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

procedure TIB_CustomActionTransaction.StatusChanged;
begin
  // do nothing
end;

constructor TIB_ActionStart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := H_TB_StartTransaction;
  Hint := H_TB_StartTransaction;
end;

procedure TIB_ActionStart.StatusChanged;
begin
  Enabled := not ATransaction.InTransaction;
end;

procedure TIB_ActionStart.ExecuteTarget(Target: TObject);
begin
  if Assigned(IB_Transaction) then
    with IB_Transaction do
      if not InTransaction then
        StartTransaction;
end;

constructor TIB_ActionCommitRetaining.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := H_TB_PostDatasets;
  Hint := H_TB_CommitRetain;
end;

procedure TIB_ActionCommitRetaining.StatusChanged;
begin
  Enabled := ATransaction.InTransaction or
             ATransaction.TransactionIsActive;
end;

procedure TIB_ActionCommitRetaining.ExecuteTarget(Target: TObject);
begin
  if Assigned(IB_Transaction) then
    with IB_Transaction do
      if InTransaction or TransactionIsActive then CommitRetaining;
end;

constructor TIB_ActionRollbackRetaining.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := H_TB_CancelDatasets;
  Hint := H_TB_RollbackRetain;
end;

procedure TIB_ActionRollbackRetaining.StatusChanged;
begin
  Enabled := ATransaction.InTransaction or
             ATransaction.TransactionIsActive;
end;

procedure TIB_ActionRollbackRetaining.ExecuteTarget(Target: TObject);
begin
  if Assigned(IB_Transaction) then
    with IB_Transaction do
      if InTransaction or TransactionIsActive then RollbackRetaining;
end;

constructor TIB_ActionCommit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := H_TB_PostDatasets;
  Hint := H_TB_Commit;
end;

procedure TIB_ActionCommit.StatusChanged;
begin
  Enabled := ATransaction.InTransaction or
             ATransaction.TransactionIsActive;
end;

procedure TIB_ActionCommit.ExecuteTarget(Target: TObject);
begin
  if Assigned(IB_Transaction) then
    with IB_Transaction do
      if InTransaction or TransactionIsActive then Commit;
end;

constructor TIB_ActionRollback.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := H_TB_CancelDatasets;
  Hint := H_TB_Rollback;
end;

procedure TIB_ActionRollback.StatusChanged;
begin
  Enabled := ATransaction.InTransaction or
             ATransaction.TransactionIsActive;
end;

procedure TIB_ActionRollback.ExecuteTarget(Target: TObject);
begin
  if Assigned(IB_Transaction) then
    with IB_Transaction do
      if InTransaction or TransactionIsActive then Rollback;
end;

end.
