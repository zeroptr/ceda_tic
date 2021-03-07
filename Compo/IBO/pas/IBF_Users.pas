
{                                                                              }
{ IBF_Users                                                                    }
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
  IBF_Users;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls,

  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_Constants;

type
  TfrmUsers = class(TForm)
    pnAction: TPanel;
    btOk: TButton;
    ScrollBox1: TScrollBox;
    edAccount: TEdit;
    edPassword: TEdit;
    edGroup: TEdit;
    edFirstName: TEdit;
    edMiddleName: TEdit;
    edLastName: TEdit;
    lbAccount: TLabel;
    lbPassword: TLabel;
    lbGroup: TLabel;
    lbFirstName: TLabel;
    lbMiddleName: TLabel;
    lbLastName: TLabel;
    btClear: TButton;
    csUsers: TIB_ConnectionSource;
    rbAdd: TRadioButton;
    rbDelete: TRadioButton;
    rbModify: TRadioButton;
    procedure btOkClick(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure rbAddClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses
  IB_Session;

procedure TfrmUsers.btOkClick(Sender: TObject);
var
  tmpAction: TIB_AlterUserAction;
begin
  if Assigned( csUsers.IB_Connection ) then begin
    with csUsers.IB_Connection do begin
      BeginBusy( false );
      try
       Connected := true;
       if rbAdd.   Checked then tmpAction := uaAddUser else
       if rbDelete.Checked then tmpAction := uaDeleteUser else
                                tmpAction := uaModifyUser;
       AlterUser( tmpAction,
                  Trim( edAccount.Text ),
                  Trim( edPassword.Text ),
                  Trim( edGroup.Text ),
                  Trim( edFirstName.Text ),
                  Trim( edMiddleName.Text ),
                  Trim( edLastName.Text ) );
      finally
        EndBusy;
      end;
      ShowMessage( M_USERS_COMPLETED_OK );
    end;
  end else begin
    MessageBeep( 0 );
    ShowMessage( M_USERS_NO_CONNECTION );
  end;
end;

procedure TfrmUsers.btClearClick(Sender: TObject);
begin
  edAccount.Text := '';
  edPassword.Text := '';
  edGroup.Text := '';
  edFirstName.Text := '';
  edMiddleName.Text := '';
  edLastName.Text := '';
end;

procedure TfrmUsers.rbAddClick(Sender: TObject);
begin
  edPassword.Enabled := not rbDelete.Checked;
  edGroup.Enabled := not rbDelete.Checked;
  edFirstName.Enabled := not rbDelete.Checked;
  edMiddleName.Enabled := not rbDelete.Checked;
  edLastName.Enabled := not rbDelete.Checked;
  if rbDelete.Checked then begin
    edPassword.Color := clInactiveCaption;
    edGroup.Color := clInactiveCaption;
    edFirstName.Color := clInactiveCaption;
    edMiddleName.Color := clInactiveCaption;
    edLastName.Color := clInactiveCaption;
  end else begin
    edPassword.Color := clWindow;
    edGroup.Color := clWindow;
    edFirstName.Color := clWindow;
    edMiddleName.Color := clWindow;
    edLastName.Color := clWindow;
  end;
end;

procedure TfrmUsers.FormActivate(Sender: TObject);
begin
{$IFDEF IBO_VCL30_OR_GREATER}
  HelpFile := 'IBO.HLP';
{$ENDIF}  
end;

procedure TfrmUsers.FormCreate(Sender: TObject);
begin
  Caption:=L_USERS_FRM;
  rbAdd.Caption:=L_USERS_ADD;
  rbDelete.Caption:=L_USERS_DELETE;
  rbModify.Caption:=L_USERS_MODIFIY;
  lbAccount.Caption:=L_USERS_ACCOUNT;
  lbPassword.Caption:=L_USERS_PASSWORD;
  lbGroup.Caption:=L_USERS_GROUP;
  lbFirstname.Caption:=L_USERS_FIRSTNAME;
  lbMiddleName.Caption:=L_USERS_MIDDLENAME;
  lbLastName.Caption:=L_USERS_LASTNAME;
  btClear.Caption:=C_BTN_USERS_CLEAR;
  btOk.Caption:=C_BTN_USERS_OK;
end;

end.


