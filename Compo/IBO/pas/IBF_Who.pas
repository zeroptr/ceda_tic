
{                                                                              }
{ IBF_Who                                                                      }
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
  IBF_Who;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, StdCtrls, ExtCtrls,

  IBF_Base,

  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_Constants;

type
TfrmWho = class(TfrmBase)
  meWho: TMemo;
  procedure FormShow(Sender: TObject);
  procedure btApplyClick(Sender: TObject);
  procedure btOKClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
private
  { Private declarations }
public
  { Public declarations }
end;

implementation

{$R *.DFM}

procedure TfrmWho.FormShow(Sender: TObject);
begin
  SetDefaultBounds( 0, 0, 200, 275 );
  btApply.Click;
end;

procedure TfrmWho.btApplyClick(Sender: TObject);
begin
  meWho.Lines.Clear;
  if Assigned( BaseConnection ) then begin
    meWho.Lines.Assign( BaseConnection.Users );
  end;
end;

procedure TfrmWho.btOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmWho.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

procedure TfrmWho.FormCreate(Sender: TObject);
begin
  inherited;
  Caption:=C_WHO_FRM;
  btApply.Caption:=C_WHO_BTNAPPLY;
end;

end.

