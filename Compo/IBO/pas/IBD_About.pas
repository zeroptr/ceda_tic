
{                                                                              }
{  IBD_About                                                                   }
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
  IBD_About;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Buttons,
  ExtCtrls;

type
  TdlgAbout = class(TForm)
    Panel1: TPanel;
    lbProductName: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    Label5: TLabel;
    Label7: TLabel;
    Panel2: TPanel;
    ProgramIcon: TImage;
    Memo1: TMemo;
    Label1: TLabel;
    BitBtnCredits: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure BitBtnCreditsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses
  ShellAPI, IB_Constants, IBD_Credits;

procedure TdlgAbout.FormCreate(Sender: TObject);
begin
  lbProductName.Caption := lbProductName.Caption + ' Version ' +
                           IB_Version_Major + '.' +
                           IB_Version_Minor + '.' +
                           IB_Version_Build +
                           IB_Version_Sub_Release;
end;

procedure TdlgAbout.FormActivate(Sender: TObject);
begin
{$IFDEF IBO_VCL30_OR_GREATER}
  HelpFile := 'IBO.HLP';
{$ENDIF}
end;

procedure TdlgAbout.Label1Click(Sender: TObject);
begin
  ShellExecute( GetDesktopWindow(),
                'open',
                PChar('http://www.ibobjects.com'),
                nil,
                nil,
                SW_SHOWNORMAL );
end;

procedure TdlgAbout.Label7Click(Sender: TObject);
begin
  ShellExecute( GetDesktopWindow(),
                'open',
                PChar('mailto:jwharton@ibobjects.com'),
                nil,
                nil,
                SW_SHOWNORMAL );
end;

procedure TdlgAbout.BitBtnCreditsClick(Sender: TObject);
begin
  with TdlgCredits.Create(Self) do
    try
      ShowModal
    finally
      Free;
    end;
end;

end.
