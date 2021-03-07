
{                                                                              }
{ IBF_DDL                                                                      }
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
  IBF_DDL_Extract;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls,
  
  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_Process,

  IBF_Base,

  IB_DDL_Controller;

type
  TfrmDDLExtract = class(TfrmBase)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    Memo2: TMemo;
    Panel1: TPanel;
    btRun: TButton;
    cbAdjustCharsetAlways: TCheckBox;
    cbExtractGenValues: TCheckBox;
    cbShowSysdbaRights: TCheckBox;
    cbFixFirstExceptionNumber: TCheckBox;
    cbDatabase: TCheckBox;
    cbException: TCheckBox;
    cbUDF: TCheckBox;
    cbGenerator: TCheckBox;
    cbDomain: TCheckBox;
    cbIndex: TCheckBox;
    cbTrigger: TCheckBox;
    cbTable: TCheckBox;
    cbView: TCheckBox;
    cbProcedure: TCheckBox;
    cbRole: TCheckBox;
    cbPermission: TCheckBox;
    ddlExtract: TIB_DDL_Extract;
    procedure btRunClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDDLExtract: TfrmDDLExtract;

implementation

{$R *.DFM}

procedure TfrmDDLExtract.btRunClick(Sender: TObject);
begin
  with ddlExtract do
  begin
    IB_Connection := BaseConnection;
    //FormatterType := mcfHTML;
    TerminatorToken := '^';
    ActivateDebug := True;
    if cbFixFirstExceptionNumber.Checked then
      Options := Options + [mcoFixFirstExceptionNumber]
    else
      Options := Options - [mcoFixFirstExceptionNumber];
    if cbAdjustCharsetAlways.Checked then
      Options := Options + [mcoAdjustCharsetAlways]
    else
      Options := Options - [mcoAdjustCharsetAlways];
    if cbExtractGenValues.Checked then
      Options := Options + [mcoExtractGenValues]
    else
      Options := Options - [mcoExtractGenValues];
    if cbShowSysdbaRights.Checked then
      Options := Options + [mcoShowSysdbaRights]
    else
      Options := Options - [mcoShowSysdbaRights];
    // Try these if you want.
    //ColorForIdentifiers := clNavy;
    //ColorForLiteralStrings := clTeal;
    //SkipDoubleQuotes := True;
    //IndentationDepth := 0;
    DDL_Sections := [];
    if cbDatabase.Checked then DDL_Sections := DDL_Sections + [ ddlDatabase ];
    if cbException.Checked then DDL_Sections := DDL_Sections + [ ddlException ];
    if cbUDF.Checked then DDL_Sections := DDL_Sections + [ ddlUDF ];
    if cbGenerator.Checked then DDL_Sections := DDL_Sections + [ ddlGenerator ];
    if cbDomain.Checked then DDL_Sections := DDL_Sections + [ ddlDomain ];
    if cbIndex.Checked then DDL_Sections := DDL_Sections + [ ddlIndex ];
    if cbTrigger.Checked then DDL_Sections := DDL_Sections + [ ddlTrigger ];
    if cbTable.Checked then DDL_Sections := DDL_Sections + [ ddlTable ];
    if cbView.Checked then DDL_Sections := DDL_Sections + [ ddlView ];
    if cbProcedure.Checked then DDL_Sections := DDL_Sections + [ ddlProcedure ];
    if cbRole.Checked then DDL_Sections := DDL_Sections + [ ddlRole ];
    if cbPermission.Checked then DDL_Sections := DDL_Sections + [ddlPermission];
    ExecuteStrings( Memo1.Lines, Memo2.Lines );
  end;
end;

end.
