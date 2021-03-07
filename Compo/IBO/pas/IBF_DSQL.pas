
{                                                                              }
{ IBF_DSQL                                                                     }
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
  IBF_DSQL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Grids,

  IBF_Base,
  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_StatementGrid,
  IB_TransactionBar,
  IB_StatementBar, Buttons;

type
  TfrmDSQL = class(TfrmBase)
    DSQLStatementPanel: TPanel;
    sbStatementBar: TIB_StatementBar;
    tbDSQL: TIB_TransactionBar;
    Panel6: TPanel;
    pcDSQL: TPageControl;
    tsSQL: TTabSheet;
    meDSQL: TMemo;
    tsDSQLInput: TTabSheet;
    IB_StatementGrid1: TIB_StatementGrid;
    tsDSQLOutput: TTabSheet;
    IB_StatementGrid2: TIB_StatementGrid;
    Panel11: TPanel;
    dsqlEdit: TIB_DSQL;
    cbParams: TCheckBox;
    btSQLPrev: TSpeedButton;
    btSQLNext: TSpeedButton;
    btSQLNew: TSpeedButton;
    btSQLRemove: TSpeedButton;
    procedure IB_TransactionSourceAfterAssignment(
      Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
    procedure IB_ConnectionSourceAfterAssignment(
      Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
    procedure dsqlEditBeforePrepare(Sender: TIB_Statement);
    procedure meDSQLChange(Sender: TObject);
    procedure btSQLNextClick(Sender: TObject);
    procedure dsqlEditAfterUnprepare(Sender: TIB_Statement);
    procedure FormShow(Sender: TObject);
    procedure dsqlEditAfterExec(Sender: TIB_Statement);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateDSQLButtons;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses
  IB_Constants;

procedure TfrmDSQL.FormShow(Sender: TObject);
begin
  SetDefaultBounds( 0, 0, 500, 500 );
end;

procedure TfrmDSQL.IB_TransactionSourceAfterAssignment(
  Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
begin
  tbDSQL.IB_Transaction := ATransaction;
  dsqlEdit.IB_Transaction := ATransaction;
end;

procedure TfrmDSQL.IB_ConnectionSourceAfterAssignment(
  Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
begin
  dsqlEdit.IB_Connection := AConnection;
end;

{------------------------------------------------------------------------------}

procedure TfrmDSQL.dsqlEditBeforePrepare(Sender: TIB_Statement);
begin
  dsqlEdit.ParamCheck := cbParams.Checked;
  dsqlEdit.SQL.Text := meDSQL.Lines.Text;
end;

procedure TfrmDSQL.meDSQLChange(Sender: TObject);
begin
  dsqlEdit.Prepared := false;
end;

procedure TfrmDSQL.btSQLNextClick(Sender: TObject);
begin
  with dsqlEdit do
  begin
    if Sender = btSQLNew then
    begin
      AddSQLHistory( meDSQL.Lines, SQLHistoryRef );
      Prepared := false;
      SQLHistoryRef := SQLHistory.Count;
      meDSQL.Lines.Clear;
    end;
    if Sender = btSQLPrev then
    begin
      if ( AddSQLHistory( meDSQL.Lines, SQLHistoryRef )) and
         ( SQLHistoryRef = SQLHistory.Count ) then
        SQLHistoryRef := SQLHistoryRef - 2
      else
        SQLHistoryRef := SQLHistoryRef - 1;
      meDSQL.Lines.Text := SQL.Text;
    end;
    if Sender = btSQLNext then
    begin
      AddSQLHistory( meDSQL.Lines, SQLHistoryRef );
      SQLHistoryRef := SQLHistoryRef + 1;
      meDSQL.Lines.Text := SQL.Text;
    end;
    if Sender = btSQLRemove then
    begin
      dsqlEdit.RemoveSQLHistory( dsqlEdit.SQLHistoryRef );
      meDSQL.Lines.Text := SQL.Text;
    end;
  end;
  pcDSQL.ActivePage := tsSQL;
  meDSQL.SetFocus;
  UpdateDSQLButtons;
end;

procedure TfrmDSQL.dsqlEditAfterUnprepare(Sender: TIB_Statement);
begin
  UpdateDSQLButtons;
end;

procedure TfrmDSQL.UpdateDSQLButtons;
begin
  with dsqlEdit do
  begin
    btSQLPrev.Enabled := ( SQLHistory.Count > 0 ) and ( SQLHistoryRef > 0 );
    btSQLNext.Enabled := ( SQLHistory.Count > SQLHistoryRef + 1 );
    btSQLRemove.Enabled := SQLHistoryRef < SQLHistory.Count;
  end;
end;

procedure TfrmDSQL.dsqlEditAfterExec(Sender: TIB_Statement);
begin
  if Assigned( Sender ) and
     ( Sender.StatementType in [ stUpdate, stDelete, stInsert ] ) then
  begin
    if StatusBar.Visible then
    begin
      Statusbar.SimpleText := M_SQL_RowsAffected +
                              IntToStr( Sender.RowsAffected );
    end else
      ShowMessage( M_SQL_RowsAffected + IntToStr( Sender.RowsAffected ));
  end;
end;

procedure TfrmDSQL.FormCreate(Sender: TObject);
begin
  inherited;
  pcDSQL.ActivePage := tsSQL;
{$IFDEF IBO_VCL40_OR_GREATER}
  btSQLPrev.Flat := true;
  btSQLNext.Flat := true;
  btSQLNew.Flat := true;
  btSQLRemove.Flat := true;
{$ENDIF}
end;

procedure TfrmDSQL.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

end.

