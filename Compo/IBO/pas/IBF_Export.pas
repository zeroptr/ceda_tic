
{                                                                              }
{ IBF_Export                                                                   }
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
  IBF_Export;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, StdCtrls, ExtCtrls,

  IBF_Base,

  IB_Constants,
  IB_Header,
  IB_Session,
  IB_Components,
  IB_Export,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_StatementSource,
  IB_DatasetBar,
  IB_Process,
  IB_DataScan;

type
  TfrmExport = class(TfrmBase)
    meSQL: TMemo;
    Panel27: TPanel;
    gbASCII: TGroupBox;
    rbDelimited: TRadioButton;
    rbFixed: TRadioButton;
    Panel29: TPanel;
    sbExport: TSpeedButton;
    sbImport: TSpeedButton;
    dsbExport: TIB_DatasetBar;
    Panel30: TPanel;
    crExport: TIB_Cursor;
    sdExport: TSaveDialog;
    IB_Export1: TIB_Export;
    dsExport: TIB_DataSource;
    ssExport: TIB_StatementSource;
    rbDBF: TRadioButton;
    bgASCIIOpts: TGroupBox;
    lbDateFormat: TLabel;
    cbIncludeHeaders: TCheckBox;
    edDateFormat: TEdit;
    lbDelimiter: TLabel;
    lbSeparator: TLabel;
    edDelimiter: TEdit;
    edSeparator: TEdit;
    cbIncludeCRLF: TCheckBox;
    edTimeFormat: TEdit;
    lbTimeFormat: TLabel;
    procedure meSQLChange(Sender: TObject);
    procedure stlExportAfterPrepare( Sender: TIB_StatementLink;
                                     Statement: TIB_Statement);
    procedure stlExportAfterUnprepare( Sender: TIB_StatementLink;
                                       Statement: TIB_Statement);
    procedure stlExportBeforePrepare( Sender: TIB_StatementLink;
                                      Statement: TIB_Statement);
    procedure IB_ConnectionSourceAfterAssignment(
      Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
    procedure IB_TransactionSourceAfterAssignment(
      Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure sbExportClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbClick(Sender: TObject);
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

procedure TfrmExport.FormShow(Sender: TObject);
begin
  SetDefaultBounds( 0, 0, 440, 330 );
end;

procedure TfrmExport.DoReadSettings;
begin
  with RegDB do
  begin
    sdExport.Filename := ReadString( 'Settings', 'Filename', '*.TXT' );
    edDelimiter.Text  := ReadString( 'Settings', 'Delimiter', '"');
    edSeparator.Text  := ReadString( 'Settings', 'Separator', ',');
    cbIncludeHeaders.Checked := ReadBool( 'Settings', 'Headers', false );
    cbIncludeCRLF.Checked := ReadBool( 'Settings', 'IncludeCRLF', false );
    rbDBF.Checked := ReadBool( 'Settings', 'DBF', false );
    edDateFormat.Text := ReadString( 'Settings', 'DateFormat', shortdateformat);
    edTimeFormat.Text := ReadString( 'Settings', 'TimeFormat', shorttimeformat);
    ReadStrings( 'SQL', meSQL.Lines );
    rbFixed.Checked := ReadBool( 'Settings', 'rbFixed', false );
    rbDelimited.Checked := ReadBool( 'Settings', 'rbDelimited', true );
    rbDBF.Checked := ReadBool( 'Settings', 'rbDBF', false );
  end;
end;

procedure TfrmExport.DoWriteSettings;
begin
  with RegDB do
  begin
    WriteString( 'Settings', 'Filename',  sdExport.Filename );
    WriteString( 'Settings', 'Delimiter', edDelimiter.Text );
    WriteString( 'Settings', 'Separator', edSeparator.Text );
    WriteBool( 'Settings', 'Headers', cbIncludeHeaders.Checked );
    WriteBool( 'Settings', 'IncludeCRLF', cbIncludeCRLF.Checked );
    WriteBool( 'Settings', 'DBF', rbDBF.Checked );
    WriteString( 'Settings', 'DateFormat', edDateFormat.Text );
    WriteString( 'Settings', 'TimeFormat', edTimeFormat.Text );
    WriteStrings( 'SQL', meSQL.Lines );
    WriteBool( 'Settings', 'rbFixed', rbFixed.Checked );
    WriteBool( 'Settings', 'rbDelimited', rbDelimited.Checked );
    WriteBool( 'Settings', 'rbDBF', rbDBF.Checked );
  end;
end;

procedure TfrmExport.IB_ConnectionSourceAfterAssignment(
  Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
begin
  crExport.IB_Connection := AConnection;
end;

procedure TfrmExport.IB_TransactionSourceAfterAssignment(
  Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
begin
  crExport.IB_Transaction := ATransaction;
end;

{------------------------------------------------------------------------------}

procedure TfrmExport.meSQLChange(Sender: TObject);
begin
  crExport.Prepared := false;
  crExport.SQL.Clear;
end;

procedure TfrmExport.stlExportAfterPrepare(
  Sender: TIB_StatementLink; Statement: TIB_Statement);
begin
  sbImport.Enabled := Statement.StatementType = stInsert;
  sbExport.Enabled := Statement.StatementType = stSelect;
end;

procedure TfrmExport.stlExportAfterUnprepare(
  Sender: TIB_StatementLink; Statement: TIB_Statement);
begin
  sbExport.Enabled := false;
  sbImport.Enabled := false;
end;

procedure TfrmExport.stlExportBeforePrepare(
  Sender: TIB_StatementLink; Statement: TIB_Statement);
begin
  with crExport.SQL do
    if Count = 0 then
      AddStrings( meSQL.Lines );
end;

procedure TfrmExport.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if IB_Export1.Executing then
  begin
    CanClose := false;
    MessageBeep( 0 );
    ShowMessage( M_EXPORT_STILL_ACTIVE );
  end;
end;

procedure TfrmExport.sbExportClick(Sender: TObject);
begin
  if CloseQuery then
  begin
    if rbDBF.Checked then
    begin
      IB_Export1.ExportFormat := efDBF;
      sdExport.DefaultExt := 'DBF';
      sdExport.FileName := '*.DBF';
      sdExport.Filter := L_EXPORT_SDEXPORTFILTERDBF;
      IB_Export1.TimeFormat := edTimeFormat.Text;
    end
    else
    if rbFixed.Checked then
    begin
      IB_Export1.ExportFormat := efASCII_Fixed;
      IB_Export1.IncludeCRLF := cbIncludeCRLF.Checked;
      sdExport.DefaultExt := 'TXT';
      sdExport.FileName := '*.TXT';
      sdExport.Filter := L_EXPORT_SDEXPORTFILTERTXT;
      IB_Export1.DateFormat := edDateFormat.Text;
      IB_Export1.TimeFormat := edTimeFormat.Text;
    end
    else
    begin
      IB_Export1.ExportFormat := efASCII;
      sdExport.DefaultExt := 'CSV';
      sdExport.FileName := '*.CSV';
      sdExport.Filter := L_EXPORT_SDEXPORTFILTERCSV;
      if edDelimiter.Text = '#9' then
        IB_Export1.Delimiter := #9
      else
      if edDelimiter.Text = '' then
        IB_Export1.Delimiter := #0
      else
        IB_Export1.Delimiter := edDelimiter.Text[ 1 ];
      if edSeparator.Text = '#9' then
        IB_Export1.Separator := #9
      else
      if edSeparator.Text = '' then
        IB_Export1.Separator := #0
      else
        IB_Export1.Separator := edSeparator.Text[ 1 ];
      IB_Export1.DateFormat := edDateFormat.Text;
      IB_Export1.TimeFormat := edTimeFormat.Text;
    end;
    if sdExport.Execute then
    begin
      IB_Export1.FileName := sdExport.Filename;
      IB_Export1.IncludeHeaders := cbIncludeHeaders.Checked;
      IB_Export1.Execute;
    end;
  end;
end;

procedure TfrmExport.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

procedure TfrmExport.FormCreate(Sender: TObject);
begin
  inherited;
  Caption:=L_EXPORT_FRM;
  gbASCII.Caption:=L_EXPORT_ASCII;
  rbDelimited.Caption:=L_EXPORT_DELIMITED;
  rbFixed.Caption:=L_EXPORT_FIXED;
  rbDBF.Caption:=L_EXPORT_DBF;
  bgASCIIOpts.Caption:=L_EXPORT_ASCIIOPT;
  lbDelimiter.Caption:=L_EXPORT_DELIMITER;
  lbSeparator.Caption:=L_EXPORT_SEPARATOR;
  lbDateFormat.Caption:=L_EXPORT_DATEFORMAT;
  cbIncludeHeaders.Caption:=L_EXPORT_INCLUDEHEADERS;
  cbIncludeCRLF.Caption:=L_EXPORT_INCLUDECRLF;
  sbExport.Hint:=H_BTN_EXPORT_BEGIN;
  sbExport.Caption:=C_BTN_EXPORT_BEGIN;
end;

procedure TfrmExport.rbClick(Sender: TObject);
begin
  edDelimiter.Enabled := rbDelimited.Checked;
  edSeparator.Enabled := rbDelimited.Checked;
  edDateFormat.Enabled := rbDelimited.Checked or rbFixed.Checked;
  edTimeFormat.Enabled := rbDelimited.Checked or rbFixed.Checked or rbDBF.Checked;
  cbIncludeHeaders.Enabled := rbDelimited.Checked;
  cbIncludeCRLF.Enabled := rbFixed.Checked;
end;

end.


