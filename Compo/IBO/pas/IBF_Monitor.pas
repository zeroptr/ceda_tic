
{                                                                              }
{ IBF_Monitor                                                                  }
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

{: This unit contains the form for the IB_Monitor.}
unit
  IBF_Monitor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Registry, ComCtrls,

  IBF_Base,

  IB_Constants,
  IB_Components,
  IB_Monitor,
  IB_ConnectionSource,
  IB_TransactionSource;

type
  TfrmMonitor = class(TfrmBase)
    IB_Monitor: TIB_Monitor;
    sdMonitor: TSaveDialog;
    btClear: TButton;
    btSave: TButton;
    cbConnection: TCheckBox;
    cbTransaction: TCheckBox;
    cbStatement: TCheckBox;
    cbRow: TCheckBox;
    cbSQL: TCheckBox;
    cbEnabled: TCheckBox;
    Panel15: TPanel;
    Panel23: TPanel;
    meMonitor: TRichEdit;
    cbBlob: TCheckBox;
    cbArray: TCheckBox;
    cbTimeStamp: TCheckBox;
    cbErrorsOnly: TCheckBox;
    cbClientTrace: TCheckBox;
    cbProfile: TCheckBox;
    btProfile: TButton;
    cbStayOnTop: TCheckBox;
    procedure IB_MonitorMonitorOutputItem(Sender: TObject;
      const NewString: string);
    procedure btClearClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure cbEnabledClick(Sender: TObject);
    procedure cbClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbTimeStampClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btProfileClick(Sender: TObject);
    procedure csBaseAfterAssignment(Sender: TIB_ConnectionLink;
      AConnection: TIB_Connection);
    procedure cbStayOnTopClick(Sender: TObject);
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

procedure TfrmMonitor.FormShow(Sender: TObject);
begin
  SetDefaultBounds( 0, 0, 500, 300 );
end;

procedure TfrmMonitor.csBaseAfterAssignment(Sender: TIB_ConnectionLink;
  AConnection: TIB_Connection);
begin
  IB_Monitor.ProfilerConnection := AConnection;
end;

procedure TfrmMonitor.DoReadSettings;
begin
  with RegDB do
  begin
    sdMonitor.Filename    := ReadString( 'Settings', 'Filename',    '*.TXT' );
    cbEnabled.Checked     := ReadBool  ( 'Settings', 'Enabled',     true );
    cbTimeStamp.Checked   := ReadBool  ( 'Settings', 'TimeStamp',   false );
    cbErrorsOnly.Checked  := ReadBool  ( 'Settings', 'ErrorsOnly',  false );
    cbConnection.Checked  := ReadBool  ( 'Settings', 'Connection',  true );
    cbTransaction.Checked := ReadBool  ( 'Settings', 'Transaction', true );
    cbStatement.Checked   := ReadBool  ( 'Settings', 'Statement',   false );
    cbSQL.Checked         := ReadBool  ( 'Settings', 'SQL',         true );
    cbRow.Checked         := ReadBool  ( 'Settings', 'Row',         false );
    cbBlob.Checked        := ReadBool  ( 'Settings', 'Blob',        false );
    cbArray.Checked       := ReadBool  ( 'Settings', 'Array',       false );
    cbClientTrace.Checked := ReadBool  ( 'Settings', 'ClientTrace', false );
    cbProfile.Checked     := ReadBool  ( 'Settings', 'Profile',     false );
    cbStayOnTop.Checked := ReadBool( 'Settings', 'StayOnTop', false );
  end;
end;

procedure TfrmMonitor.DoWriteSettings;
begin
  with RegDB do
  begin
    WriteString( 'Settings', 'Filename',    sdMonitor.Filename );
    WriteBool  ( 'Settings', 'Enabled',     cbEnabled.Checked );
    WriteBool  ( 'Settings', 'TimeStamp',   cbTimeStamp.Checked );
    WriteBool  ( 'Settings', 'ErrorsOnly',  cbErrorsOnly.Checked );
    WriteBool  ( 'Settings', 'Connection',  cbConnection.Checked );
    WriteBool  ( 'Settings', 'Transaction', cbTransaction.Checked );
    WriteBool  ( 'Settings', 'Statement',   cbStatement.Checked );
    WriteBool  ( 'Settings', 'SQL',         cbSQL.Checked );
    WriteBool  ( 'Settings', 'Row',         cbRow.Checked );
    WriteBool  ( 'Settings', 'Blob',        cbBlob.Checked );
    WriteBool  ( 'Settings', 'Array',       cbArray.Checked );
    WriteBool  ( 'Settings', 'ClientTrace', cbClientTrace.Checked );
    WriteBool  ( 'Settings', 'Profile',     cbProfile.Checked );
    WriteBool( 'Settings', 'StayOnTop', cbStayOnTop.Checked );
  end;
end;

{------------------------------------------------------------------------------}

procedure TfrmMonitor.IB_MonitorMonitorOutputItem(Sender: TObject;
  const NewString: string);
begin
  if( not cbErrorsOnly.Checked ) or
    (( IB_Monitor.ErrCode <>   0 ) and
     ( IB_Monitor.ErrCode <> 100 )) then
    meMonitor.Lines.Add( NewString );
end;

procedure TfrmMonitor.btClearClick(Sender: TObject);
begin
  meMonitor.Lines.Clear;
end;

procedure TfrmMonitor.btSaveClick(Sender: TObject);
var
  tmpStrings: TIB_StringList;
begin
  with sdMonitor do
  begin
    if Execute then
    begin
      tmpStrings := TIB_StringList.Create;
      try
        tmpStrings.AddStrings( meMonitor.Lines );
        tmpStrings.SaveToFile( FileName );
      finally
        tmpStrings.Free;
      end;
    end;
  end;
end;

procedure TfrmMonitor.cbEnabledClick(Sender: TObject);
begin
  IB_Monitor.Enabled := cbEnabled.Checked;
  if cbEnabled.Checked then
  begin
    meMonitor.Color := clWindow;
    meMonitor.Lines.Add( '/*--------  ENABLED  --------*/' );
  end
  else
  begin
    meMonitor.Lines.Add( '/*--------  DISABLED --------*/' );
    meMonitor.Color := clSilver;
  end;
end;

procedure TfrmMonitor.cbTimeStampClick(Sender: TObject);
begin
  IB_Monitor.IncludeTimeStamp := cbTimeStamp.Checked;
end;

procedure TfrmMonitor.cbClick(Sender: TObject);
begin
  with Sender as TCheckBox, IB_Monitor do
  begin
    if Sender = cbConnection then
    begin
      if Checked then
      begin
        MonitorGroups := MonitorGroups + [ mgConnection ];
      end else begin
        MonitorGroups := MonitorGroups - [ mgConnection ];
      end;
    end else if Sender = cbTransaction then begin
      if Checked then begin
        MonitorGroups := MonitorGroups + [ mgTransaction ];
      end else begin
        MonitorGroups := MonitorGroups - [ mgTransaction ];
      end;
    end else if ( Sender = cbStatement ) or
                ( Sender = cbSQL ) then begin
      if cbSQL.Checked or cbStatement.Checked then begin
        MonitorGroups := MonitorGroups + [ mgStatement ];
      end else begin
        MonitorGroups := MonitorGroups - [ mgStatement ];
      end;
      if cbStatement.Checked then begin
        StatementGroups := StatementGroups + [ sgAllocate      ];
        StatementGroups := StatementGroups + [ sgStatementInfo ];
        StatementGroups := StatementGroups + [ sgServerCursor  ];
      end else begin
        StatementGroups := StatementGroups - [ sgAllocate      ];
        StatementGroups := StatementGroups - [ sgStatementInfo ];
        StatementGroups := StatementGroups - [ sgServerCursor  ];
      end;
      if cbSQL.Checked then begin
        StatementGroups := StatementGroups + [ sgPrepare          ];
        StatementGroups := StatementGroups + [ sgDescribe         ];
        StatementGroups := StatementGroups + [ sgExecuteImmediate ];
        StatementGroups := StatementGroups + [ sgExecute          ];
      end else begin
        StatementGroups := StatementGroups - [ sgPrepare          ];
        StatementGroups := StatementGroups - [ sgDescribe         ];
        StatementGroups := StatementGroups - [ sgExecuteImmediate ];
        StatementGroups := StatementGroups - [ sgExecute          ];
      end;
    end else if Sender = cbRow then begin
      if Checked then begin
        MonitorGroups := MonitorGroups + [ mgRow ];
      end else begin
        MonitorGroups := MonitorGroups - [ mgRow ];
      end;
    end else if Sender = cbBlob then begin
      if Checked then begin
        MonitorGroups := MonitorGroups + [ mgBlob ];
      end else begin
        MonitorGroups := MonitorGroups - [ mgBlob ];
      end;
    end else if Sender = cbArray then begin
      if Checked then begin
        MonitorGroups := MonitorGroups + [ mgArray ];
      end else begin
        MonitorGroups := MonitorGroups - [ mgArray ];
      end;
    end else if Sender = cbClientTrace then begin
      if Checked then begin
        MonitorGroups := MonitorGroups + [ mgClientTrace ];
      end else begin
        MonitorGroups := MonitorGroups - [ mgClientTrace ];
      end;
    end else if Sender = cbProfile then begin
      if Checked then begin
        MonitorGroups := MonitorGroups + [ mgProfile ];
      end else begin
        MonitorGroups := MonitorGroups - [ mgProfile ];
      end;
    end;
  end;
end;

procedure TfrmMonitor.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

procedure TfrmMonitor.btProfileClick(Sender: TObject);
begin
  IB_Monitor.IB_Session.ProfileToMonitor( 'Profile Now button click' );
end;

procedure TfrmMonitor.cbStayOnTopClick(Sender: TObject);
begin
  if cbStayOnTop.Checked then
    Self.FormStyle := fsStayOnTop
  else
    Self.FormStyle := fsNormal;
end;

end.

