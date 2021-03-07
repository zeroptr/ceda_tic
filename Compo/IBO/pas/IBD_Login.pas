
{                                                                              }
{ IBD_Login                                                                    }
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
  IBD_Login;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TdlgLogin = class(TForm)
    lbPassword: TLabel;
    edPassword: TEdit;
    Image1: TImage;
    lbDatabase: TLabel;
    lbUser: TLabel;
    edDatabase: TEdit;
    edUserName: TEdit;
    Bevel1: TBevel;
    lbSQLRole: TLabel;
    cbSQLRole: TComboBox;
    HelpBtn: TBitBtn;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FDatabaseReadOnly: boolean;
    procedure SetDatabaseReadOnly( AValue: boolean );
  public
    { Public declarations  }
    property DatabaseReadOnly: boolean read FDatabaseReadOnly
                                       write SetDatabaseReadOnly;
  end;

var
  dlgLogin: TdlgLogin;

implementation

{$R *.DFM}

uses
  IB_Constants;

procedure TdlgLogin.SetDatabaseReadOnly( AValue: boolean );
begin
  if AValue <> FDatabaseReadOnly then begin
    FDatabaseReadOnly := AValue;
    edDatabase.ReadOnly := DatabaseReadOnly;
    if DatabaseReadOnly then begin
      edDatabase.Color := clSilver;
    end else begin
      edDatabase.Color := clWindow;
    end;
  end;
end;

procedure TdlgLogin.FormCreate(Sender: TObject);
begin
  lbDatabase.Caption := M_Login_Database;
  lbUser.Caption := M_Login_User;
  lbPassword.Caption := M_Login_Password;
  OKBtn.Caption := M_Login_OK_Btn;
  CancelBtn.Caption := M_Login_Cancel_Btn;
  HelpBtn.Caption := M_Login_Help_Btn;
  Caption := Trim( Application.Title ) + ' ' + M_Login_Dialog_Caption;
end;

procedure TdlgLogin.FormShow(Sender: TObject);
begin
  if edUserName.Text = EmptyStr then begin
    edUserName.SetFocus;
  end;
end;

end.


 
