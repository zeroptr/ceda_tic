
{                                                                              }
{ IBD_Error                                                                    }
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
  IBD_Error;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls, Messages;

type
  TdlgError = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    OKBtn: TButton;
    pcError: TPageControl;
    tsErrorMsg: TTabSheet;
    meError: TMemo;
    tsSQLMsg: TTabSheet;
    meSQLMsg: TMemo;
    tsSQL: TTabSheet;
    meSQL: TMemo;
    lbCursorPos: TLabel;
    procedure meSQLEnter( Sender: TObject );
    procedure meSQLKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure meSQLMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure meSQLMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure meSQLKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow( Sender: TObject );
    procedure pcErrorChange( Sender: TObject );
    procedure FormCreate( Sender: TObject );
    procedure FormActivate(Sender: TObject);
  private
    Scrolled: boolean;
    { Private declarations }
  public
    procedure UpdateCursorPos;
    { Public declarations }
  end;

var
  dlgError: TdlgError;

implementation

{$R *.DFM}

procedure TdlgError.UpdateCursorPos;
var
  CaretPos: TPoint;
begin
  with CaretPos do begin
    X := LongRec( SendMessage( meSQL.Handle, EM_GETSEL, 0, 0 )).Hi;
    Y := SendMessage( meSQL.Handle, EM_LINEFROMCHAR, X, 0 );
    X := X - SendMessage( meSQL.Handle, EM_LINEINDEX, -1, 0 );
    lbCursorPos.Caption := IntToStr( Y + 1 ) + ': ' + IntToStr( X );
  end;
end;

procedure TdlgError.meSQLEnter( Sender: TObject );
begin
  UpdateCursorPos;
end;

procedure TdlgError.meSQLKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  UpdateCursorPos;
end;

procedure TdlgError.meSQLMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  UpdateCursorPos;
end;

procedure TdlgError.meSQLMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  UpdateCursorPos;
end;

procedure TdlgError.meSQLKeyPress(Sender: TObject; var Key: Char);
begin
  UpdateCursorPos;
end;

procedure TdlgError.FormShow( Sender: TObject );
begin
  UpdateCursorPos;
end;

procedure TdlgError.pcErrorChange( Sender: TObject );
begin
  if not Scrolled then begin
    if pcError.ActivePage = tsSQL then begin
      meSQL.SetFocus;
      SendMessage( meSQL.Handle, EM_SCROLLCARET, 0, 0 );
      SendMessage( meSQL.Handle, EM_SCROLL, SB_LINEDOWN, 0 );
      SendMessage( meSQL.Handle, EM_SCROLL, SB_LINEDOWN, 0 );
    end;
    Scrolled := true;
  end;
end;

procedure TdlgError.FormCreate( Sender: TObject );
begin
  Scrolled := false;
end;

procedure TdlgError.FormActivate(Sender: TObject);
begin
{$IFDEF IBO_VCL30_OR_GREATER}
  HelpFile := 'IBO.HLP';
{$ENDIF}  
end;

end.

