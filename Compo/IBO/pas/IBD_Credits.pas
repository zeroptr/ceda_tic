
{                                                                              }
{ IBD_Credits                                                                  }
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
  IBD_Credits;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TdlgCredits = class(TForm)
    StaticText1: TLabel;
    StaticText2: TLabel;
    Image1: TImage;
    Memo1: TMemo;
    Image3: TImage;
    imFirebird: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
    procedure FormClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgCredits: TdlgCredits;

implementation

{$R *.DFM}

procedure TdlgCredits.FormCreate(Sender: TObject);
var
  rg: HRGN;
begin
{$IFDEF IBO_VCL50_OR_GREATER}
  imFirebird.Transparent := true;
{$ENDIF}
  rg := CreateEllipticRgnIndirect( Rect( 0, 0, Width, Height ));
  if rg <> 0 then
    if ( not boolean( SetWindowRgn( Handle, rg, FALSE ))) then
      DeleteObject( rg )
end;

procedure TdlgCredits.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ( Key = chr( VK_ESCAPE )) or ( Key = chr( VK_RETURN )) then
    Close
end;

procedure TdlgCredits.FormPaint(Sender: TObject);
begin
  Canvas.Pen.Width := 2;
  Canvas.Pen.Color := clActiveCaption;
  Canvas.Arc( 1, 1, Width - 2,
                    Height - 2,
                    0,
                    0, 0, 0 );
  Canvas.Pen.Width := 1;
  Canvas.Pen.Color := clBtnShadow; //cl3DDkShadow;
  Canvas.Arc( 5, 5, Width - 6,
                    Height - 6,
                    0, 0, 0, 0 );
//                    Width,
//                    Height div 4,
//                    0,
//                    Height * 3 div 4 );
//  Canvas.Pen.Color := clBtnHighlight; //cl3DLight;
//  Canvas.Arc( 5, 5, Width - 6,
//                    Height - 6,
//                    0, 0, 0, 0 );
//                    Height * 3 div 4,
//                    Width,
//                    Height div 4 );
end;

procedure TdlgCredits.FormClick(Sender: TObject);
begin
  Close;
end;

end.
