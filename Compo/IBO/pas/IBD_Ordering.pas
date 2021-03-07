
{                                                                              }
{  IBD_Ordering                                                                }
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
  IBD_Ordering;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls,

  IB_Components;

type
  TdlgOrdering = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    lbOrdering: TListBox;
    Bevel1: TBevel;
    DataSource: TIB_DataSource;
    procedure lbOrderingDblClick(Sender: TObject);
    procedure DataSourceAfterAssignment(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgOrdering: TdlgOrdering;

implementation

{$R *.DFM}

procedure TdlgOrdering.lbOrderingDblClick(Sender: TObject);
begin
  OkBtn.Click;
end;

procedure TdlgOrdering.DataSourceAfterAssignment(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if ADataset <> nil then begin
    ADataset.GetOrderingItemsList( lbOrdering.Items );
    lbOrdering.ItemIndex := Abs( ADataset.OrderingItemNo ) - 1;
  end else begin
    lbOrdering.Items.Clear;
    lbOrdering.ItemIndex := 0;
  end;
end;

procedure TdlgOrdering.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ( ModalResult = mrOk ) and ( DataSource.Dataset <> nil ) then begin
    with DataSource.Dataset do begin
      if GetOrderingSQL( lbOrdering.ItemIndex + 1 ) = '' then begin
        OrderingItemNo := -(lbOrdering.ItemIndex + 1);
      end else begin
        if ( OrderingItemNo = lbOrdering.ItemIndex + 1 ) and
           ( GetOrderingSQL( -(lbOrdering.ItemIndex + 1)) <> '' ) then begin
          OrderingItemNo := -OrderingItemNo;
        end else begin
          OrderingItemNo := lbOrdering.ItemIndex + 1;
        end;
      end;
    end;
  end;
end;

procedure TdlgOrdering.FormActivate(Sender: TObject);
begin
{$IFDEF IBO_VCL30_OR_GREATER}
  HelpFile := 'IBO.HLP';
{$ENDIF}  
end;

end.


 