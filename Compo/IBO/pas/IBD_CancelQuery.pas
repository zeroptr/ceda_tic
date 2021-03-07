
{                                                                              }
{ IBD_CancelQuery                                                              }
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
{$D-}
{$L-}

unit
  IBD_CancelQuery;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Dialogs;

type
  TdlgCancelQuery = class(TForm)
    CancelBtn: TButton;
    Bevel1: TBevel;
    lbFetchingMessage: TLabel;
    lbRowNum: TLabel;
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DatasetToAbort: pointer;
  end;

implementation

{$R *.DFM}

uses
  IB_Constants, IB_Components;

procedure TdlgCancelQuery.CancelBtnClick(Sender: TObject);
begin
  if Assigned( DatasetToAbort ) then
  begin
    Visible := false;
    if MessageDlg( M_Abort_Fetching,
                   mtConfirmation,
                   mbOkCancel,
                   0 ) = mrOK then
      TIB_Dataset(DatasetToAbort).AbortFetching;
  end;
end;

procedure TdlgCancelQuery.FormCreate(Sender: TObject);
begin
  lbFetchingMessage.Caption := M_Fetching_Query_Results;
  CancelBtn.Caption := M_Abort_Fetching_Btn;
end;

procedure TdlgCancelQuery.FormActivate(Sender: TObject);
begin
{$IFDEF IBO_VCL30_OR_GREATER}
  HelpFile := 'IBO.HLP';
{$ENDIF}  
end;

end.
