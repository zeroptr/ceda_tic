
{                                                                              }
{ IBF_Profiler                                                                 }
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

{: This unit contains the form for the IB_Profiler.} 
unit
  IBF_Profiler;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Registry, ComCtrls,

  IBF_Base,

  IB_Constants,
  IB_Components,
  IB_Profiler,
  IB_ConnectionSource,
  IB_TransactionSource;

type
  TfrmProfiler = class(TfrmBase)
    sdProfiler: TSaveDialog;
    btClear: TButton;
    btSave: TButton;
    cbVersionRemoval: TCheckBox;
    cbMemory: TCheckBox;
    Panel15: TPanel;
    Panel23: TPanel;
    meProfiler: TRichEdit;
    cbRead: TCheckBox;
    cbRecord: TCheckBox;
    IB_Profiler: TIB_Profiler;
    cbTimeStamp: TCheckBox;
    btDiffReport: TButton;
    btSessionReport: TButton;
    cbMarkWhenDiffReport: TCheckBox;
    btMark: TButton;
    cbPages: TCheckBox;
    cbStayOnTop: TCheckBox;
    procedure IB_ProfilerProfilerOutputItem(Sender: TObject;
      const NewString: string);
    procedure btClearClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure cbTimeStampClick(Sender: TObject);
    procedure cbClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btSessionReportClick(Sender: TObject);
    procedure btDiffReportClick(Sender: TObject);
    procedure btMarkClick(Sender: TObject);
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

procedure TfrmProfiler.FormShow(Sender: TObject);
var
  S: string;
begin
  SetDefaultBounds( 0, 0, 500, 300 );
  {Automatically mark start when form gets shown (if not already done)...}
  with IB_Profiler do
  begin
    if (not HaveMark) and
        Assigned(IB_Connection) and IB_Connection.Connected then
    try
      Mark;
      if HaveMark then
      begin
        S := '';
        if IncludeTimeStamp then
          S := '[ ' + FormatDateTime( '', now ) + ' ]'#13#10;
        S := S + PROFILE_MARKED_START + #13#10;
        meProfiler.Lines.Add( S );
      end;
    except
      meProfiler.Lines.Add( 'ERROR -- INITIAL MARK ATTEMPT FAILED' );
    end;
  end;
end;

procedure TfrmProfiler.csBaseAfterAssignment(Sender: TIB_ConnectionLink;
  AConnection: TIB_Connection);
begin
  IB_Profiler.IB_Connection := AConnection;
end;

procedure TfrmProfiler.DoReadSettings;
begin
  with RegDB do begin
    sdProfiler.Filename    := ReadString( 'Settings', 'Filename', '*.TXT' );
    cbTimeStamp.Checked      := ReadBool( 'Settings', 'TimeStamp',      false );
    cbMemory.Checked         := ReadBool( 'Settings', 'Memory',         true );
    cbPages.Checked          := ReadBool( 'Settings', 'Pages',          true );
    cbRead.Checked           := ReadBool( 'Settings', 'Read',           true );
    cbRecord.Checked         := ReadBool( 'Settings', 'Record',         true );
    cbVersionRemoval.Checked := ReadBool( 'Settings', 'VersionRemoval', true );
    cbMarkWhenDiffReport.Checked :=
        ReadBool( 'Settings', 'MarkWhenDiffReport',    true );
    cbStayOnTop.Checked:=ReadBool ('Settings','StayOnTop',false);
  end;
end;

procedure TfrmProfiler.DoWriteSettings;
begin
  with RegDB do begin
    WriteString( 'Settings', 'Filename',       sdProfiler.Filename );
    WriteBool  ( 'Settings', 'TimeStamp',      cbTimeStamp.Checked );
    WriteBool  ( 'Settings', 'Memory',         cbMemory.Checked );
    WriteBool  ( 'Settings', 'Pages',          cbPages.Checked );
    WriteBool  ( 'Settings', 'Read',           cbRead.Checked );
    WriteBool  ( 'Settings', 'Record',         cbRecord.Checked );
    WriteBool  ( 'Settings', 'VersionRemoval', cbVersionRemoval.Checked );
    WriteBool  ( 'Settings', 'MarkWhenDiffReport',
        cbMarkWhenDiffReport.Checked );
    WriteBool ('Settings','StayOnTop',cbStayOnTop.Checked);
  end;
end;

{------------------------------------------------------------------------------}

procedure TfrmProfiler.IB_ProfilerProfilerOutputItem(Sender: TObject;
  const NewString: string);
begin
  meProfiler.Lines.Add( NewString );
end;

procedure TfrmProfiler.btClearClick(Sender: TObject);
begin
  meProfiler.Lines.Clear;
end;

procedure TfrmProfiler.btSaveClick(Sender: TObject);
var
  tmpStrings: TIB_StringList;
begin
  with sdProfiler do begin
    if Execute then begin
      tmpStrings := TIB_StringList.Create;
      try
        tmpStrings.AddStrings( meProfiler.Lines );
        tmpStrings.SaveToFile( FileName );
      finally
        tmpStrings.Free;
      end;
    end;
  end;
end;

procedure TfrmProfiler.cbTimeStampClick(Sender: TObject);
begin
  IB_Profiler.IncludeTimeStamp := cbTimeStamp.Checked;
end;

procedure TfrmProfiler.cbClick(Sender: TObject);
begin
  with Sender as TCheckBox, IB_Profiler do begin
    if Sender = cbMemory  then begin
      if Checked then begin
        ProfilerGroups := ProfilerGroups + [ pgMemory ];
      end else begin
        ProfilerGroups := ProfilerGroups - [ pgMemory ];
      end;
    end else if Sender = cbPages  then begin
      if Checked then begin
        ProfilerGroups := ProfilerGroups + [ pgPages ];
      end else begin
        ProfilerGroups := ProfilerGroups - [ pgPages ];
      end;
    end else if Sender = cbRead then begin
      if Checked then begin
        ProfilerGroups := ProfilerGroups + [ pgRead ];
      end else begin
        ProfilerGroups := ProfilerGroups - [ pgRead ];
      end;
    end else if Sender = cbRecord then begin
      if Checked then begin
        ProfilerGroups := ProfilerGroups + [ pgRecord ];
      end else begin
        ProfilerGroups := ProfilerGroups - [ pgRecord ];
      end;
    end else if Sender = cbVersionRemoval then begin
      if Checked then begin
        ProfilerGroups := ProfilerGroups + [ pgVersionRemoval ];
      end else begin
        ProfilerGroups := ProfilerGroups - [ pgVersionRemoval ];
      end;
    end;
  end;
end;

procedure TfrmProfiler.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

procedure TfrmProfiler.btSessionReportClick(Sender: TObject);
begin
  meProfiler.Lines.Add(
      IB_Profiler.ReportEntireSession( '', false ));
end;

procedure TfrmProfiler.btDiffReportClick(Sender: TObject);
begin
  meProfiler.Lines.Add(
      IB_Profiler.Report( '', cbMarkWhenDiffReport.Checked ));
end;

procedure TfrmProfiler.btMarkClick(Sender: TObject);
var
  S: string;
begin
  with IB_Profiler do
  begin
    Mark;
    if HaveMark then
    begin
      S := '';
      if IncludeTimeStamp then
        S := '[ ' + FormatDateTime( '', now ) + ' ]'#13#10;
      S := S + PROFILE_MARKED_START + #13#10;
      meProfiler.Lines.Add( S );
    end;
  end;
end;

procedure TfrmProfiler.cbStayOnTopClick(Sender: TObject);
begin
  if cbStayOnTop.Checked then
    Self.FormStyle := fsStayOnTop
  else
    Self.FormStyle := fsNormal;
end;

end.

