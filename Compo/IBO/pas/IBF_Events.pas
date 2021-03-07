
{                                                                              }
{ IBF_Events                                                                   }
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
  IBF_Events;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls,

  IBF_Base,

  IB_Components,
  IB_Events,
  IB_ConnectionSource,
  IB_TransactionSource;

type

TfrmEvents = class(TfrmBase)
  meEvents: TMemo;
  Panel25: TPanel;
  btRegEvents: TButton;
  btClearResults: TButton;
  meEventResults: TMemo;
  Panel32: TPanel;
  Panel37: TPanel;
  IB_Events: TIB_Events;
  procedure FormShow(Sender: TObject);
  procedure btRegEventsClick(Sender: TObject);
  procedure meEventsChange(Sender: TObject);
  procedure IB_EventsAfterRegister(Sender: TObject);
  procedure IB_EventsAfterUnregister(Sender: TObject);
  procedure IB_EventsBeforeRegister(Sender: TObject);
  procedure IB_EventsEventAlert( Sender: TObject;
                                 EventName: string;
                                 EventCount: Longint);
  procedure btClearResultsClick(Sender: TObject);
  procedure IB_ConnectionSourceAfterAssignment(
    Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
    procedure FormActivate(Sender: TObject);
private
  { Private declarations }
protected
  procedure DoReadSettings; override;
  procedure DoWriteSettings; override;
public
  { Public declarations }
end;

implementation

{$R *.DFM}

procedure TfrmEvents.FormShow(Sender: TObject);
begin
  SetDefaultBounds( 0, 0, 400, 200 );
end;

procedure TfrmEvents.DoReadSettings;
begin
  ReadStrings( 'Events', meEvents.Lines );
end;

procedure TfrmEvents.DoWriteSettings;
begin
  WriteStrings( 'Events', meEvents.Lines );
end;

procedure TfrmEvents.IB_ConnectionSourceAfterAssignment(
  Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
begin
  IB_Events.IB_Connection := AConnection;
end;

{------------------------------------------------------------------------------}

procedure TfrmEvents.btRegEventsClick(Sender: TObject);
begin
  with IB_Events do Registered := not Registered;
end;

procedure TfrmEvents.meEventsChange(Sender: TObject);
begin
  IB_Events.Registered := false;
end;

procedure TfrmEvents.IB_EventsAfterRegister(Sender: TObject);
begin
  btRegEvents.Caption := 'Unregister';
end;

procedure TfrmEvents.IB_EventsAfterUnregister(Sender: TObject);
begin
  btRegEvents.Caption := 'Register';
end;

procedure TfrmEvents.IB_EventsBeforeRegister(Sender: TObject);
begin
  IB_Events.Events.Text := meEvents.Lines.Text;
end;

procedure TfrmEvents.IB_EventsEventAlert(Sender: TObject;
  EventName: string; EventCount: Longint);
begin
  meEventResults.Lines.Insert( 0, EventName + ': ' +
                                  IntToStr( EventCount ) + '  -  ' +
                                  DateTimeToStr( now ) );
end;

procedure TfrmEvents.btClearResultsClick(Sender: TObject);
begin
  meEventResults.Lines.Clear;
end;

procedure TfrmEvents.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

end.

