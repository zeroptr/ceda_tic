
{                                                                              }
{ IBF_DataDump                                                                 }
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
  IBF_DataDump;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, StdCtrls, ExtCtrls, Grids,

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
  IB_Grid,
  IB_Process,
  IB_DataScan;

type
  TfrmDataDump = class(TfrmBase)
    Panel30: TPanel;
    crExport: TIB_Cursor;
    IB_Export1: TIB_Export;
    dsExport: TIB_DataSource;
    pcDataDump: TPageControl;
    tsData: TTabSheet;
    tsDump: TTabSheet;
    ScrollBox1: TScrollBox;
    sbDataDump: TSpeedButton;
    gbASCII: TGroupBox;
    lbDelimiter: TLabel;
    lbSeparator: TLabel;
    rbDelimited: TRadioButton;
    rbFixed: TRadioButton;
    edDelimiter: TEdit;
    edSeparator: TEdit;
    cbHeaders: TCheckBox;
    pnSizerData: TPanel;
    lbTables: TIB_Grid;
    qrTables: TIB_Query;
    qrFields: TIB_Query;
    dsTables: TIB_DataSource;
    dsFields: TIB_DataSource;
    lbFields: TIB_Grid;
    procedure TablesClick(Sender: TObject);
    procedure IB_ConnectionSourceAfterAssignment(
      Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
    procedure IB_TransactionSourceAfterAssignment(
      Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure sbDataDumpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pnSizerDataMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnSizerDataMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnSizerDataMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure qrTablesAfterOpen(IB_Dataset: TIB_Dataset);
    procedure qrFieldsAfterOpen(IB_Dataset: TIB_Dataset);
    procedure FormActivate(Sender: TObject);
    procedure qrTablesRowSelectedChanged(Sender: TObject; ARow: Integer;
      ABookmark: String; IsSelected: Boolean);
    procedure qrFieldsRowSelectedChanged(Sender: TObject; ARow: Integer;
      ABookmark: String; IsSelected: Boolean);
  private
    { Private declarations }
    slFields: TIB_StringList;
    slTables: TIB_StringList;
    fldSet: boolean;
    tblSet: boolean;
    PanelSizing: boolean;
    Directory: string;
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
  public
    { Public declarations }
    procedure Initialize; override;
    procedure ReadInitialSettings;
  end;

implementation

{$R *.DFM}

uses
  IB_Parse, FileCtrl;

procedure TfrmDataDump.FormCreate(Sender: TObject);
begin
  inherited;
  pcDataDump.ActivePage := tsData;
  slFields := TIB_StringList.Create;
  slTables := TIB_StringList.Create;
end;

procedure TfrmDataDump.FormDestroy(Sender: TObject);
begin
  slFields.Free;
  slFields := nil;
  slTables.Free;
  slTables := nil;
  inherited;
end;

procedure TfrmDataDump.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if IB_Export1.Executing then
  begin
    CanClose := false;
    MessageBeep( 0 );
    ShowMessage( M_EXPORT_STILL_ACTIVE );
  end;
end;

procedure TfrmDataDump.sbDataDumpClick(Sender: TObject);
var
  tmpStr: string;
  tmpDir: string;
begin
  tmpDir := Directory;
  if CloseQuery and
     SelectDirectory( tmpDir, [sdAllowCreate,sdPerformCreate,sdPrompt], 0) then
  begin
    Directory := tmpDir;
    with IB_Export1 do begin
      if edDelimiter.Text = '#9' then begin
        Delimiter := #9;
      end else if edDelimiter.Text = '' then begin
        Delimiter := #0;
      end else begin
        Delimiter := edDelimiter.Text[ 1 ];
      end;
      if edSeparator.Text = '#9' then begin
        Separator := #9;
      end else if edSeparator.Text = '' then begin
        Separator := #0;
      end else begin
        Separator := edSeparator.Text[ 1 ];
      end;
      IncludeHeaders := cbHeaders.Checked;
    end;
    with qrTables, IB_Session do begin
      BeginBusy( true );
      lbTables.Enabled := false;
      lbFields.Enabled := false;
      try
        First;
        while not Eof do begin
          tmpStr := '';
          if not Selected[ RowNum ] then begin
            qrFields.First;
            while not qrFields.Eof do
            begin
              if not qrFields.Selected[ qrFields.RowNum ] then
              begin
                if tmpStr = '' then
                  tmpStr := tmpStr +
                           IB_Connection.mkIdent( qrFields.Fields[0].AsString )
                else
                  tmpStr := tmpStr + ', ' +
                           IB_Connection.mkIdent( qrFields.Fields[0].AsString );
              end;
              qrFields.Next;
            end;
          end;
          if tmpStr <> '' then
          begin
            crExport.SQLSelect.Text := 'SELECT ' + tmpStr;
            crExport.SQLFrom.Text := 'FROM ' +
              crExport.IB_Connection.mkIdent( Fields[0].AsString );
            crExport.Prepare;
            if tmpDir[ Length( tmpDir ) ] <> '\' then tmpDir := tmpDir + '\';
            IB_Export1.FileName := tmpDir +
                                   Trim( Fields[0].AsString ) + '.txt';
            IB_Export1.Execute;
            if IB_Export1.ExecutingAborted then Break;
          end;
          Next;
        end;
      finally
        lbTables.Enabled := true;
        lbFields.Enabled := true;
        EndBusy;
      end;
    end;
  end;
end;

procedure TfrmDataDump.pnSizerDataMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PanelSizing := true;
end;

procedure TfrmDataDump.pnSizerDataMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if PanelSizing then if Sender = pnSizerData then begin
    lbTables.Width := lbTables.Width + X;
  end;
end;

procedure TfrmDataDump.pnSizerDataMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PanelSizing := false;
end;

procedure TfrmDataDump.FormShow(Sender: TObject);
begin
  SetDefaultBounds( 0, 0, 440, 330 );
end;

procedure TfrmDataDump.DoReadSettings;
begin
  with RegDB do begin
    Directory := ReadString( 'Settings', 'Directory', '' );
    lbtables.Width  := ReadInteger( 'Settings', 'lbTables.Width', 130 );
    edDelimiter.Text  := ReadString( 'Settings', 'Delimiter', '"');
    edSeparator.Text  := ReadString( 'Settings', 'Separator', ',');
    cbHeaders.Checked := ReadBool( 'Settings', 'Headers', false );
    ReadStrings( 'Fields', slFields );
    ReadStrings( 'Tables', slTables );
  end;
end;

procedure TfrmDataDump.DoWriteSettings;
begin
  with RegDB do begin
    WriteString( 'Settings', 'Directory', Directory );
    WriteInteger( 'Settings', 'lbTables.Width', lbtables.Width );
    WriteString( 'Settings', 'Delimiter', edDelimiter.Text );
    WriteString( 'Settings', 'Separator', edSeparator.Text );
    WriteBool( 'Settings', 'Headers', cbHeaders.Checked );
    WriteStrings( 'Fields', slFields );
    WriteStrings( 'Tables', slTables );
  end;
end;

procedure TfrmDataDump.IB_ConnectionSourceAfterAssignment(
  Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
begin
  crExport.IB_Connection := AConnection;
  qrTables.IB_Connection := AConnection;
  qrFields.IB_Connection := AConnection;
end;

procedure TfrmDataDump.IB_TransactionSourceAfterAssignment(
  Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
begin
  crExport.IB_Transaction := ATransaction;
  qrTables.IB_Transaction := ATransaction;
  qrFields.IB_Transaction := ATransaction;
end;

procedure TfrmDataDump.Initialize;
begin
  inherited Initialize;
  if ConstructingLevel = 0 then
    ReadInitialSettings;
end;

procedure TfrmDataDump.ReadInitialSettings;
begin
  if BaseConnection <> nil then
    with BaseConnection do
    begin
      BeginBusy( false );
      try
        Connected := true;
        TablesClick( nil );
      finally
        EndBusy;
      end;
    end;
end;

procedure TfrmDataDump.TablesClick(Sender: TObject);
begin
  qrTables.Open;
  qrFields.Open;
end;

procedure TfrmDataDump.qrTablesAfterOpen(IB_Dataset: TIB_Dataset);
begin
  if slTables.Count > 0 then with qrTables do try
    tblSet := true;
    FetchAll;
    BufferRowNum := 1;
    while not BufferEof do begin
      Selected[ BufferRowNum ] :=
        slTables.IndexOfName( Trim( BufferFields[0].AsString )) <> -1 ;
      BufferRowNum := BufferRowNum + 1;
    end;
  finally
    tblSet := false;
  end;
end;

procedure TfrmDataDump.qrFieldsAfterOpen(IB_Dataset: TIB_Dataset);
begin
  if slFields.Count > 0 then with qrFields do try
    fldSet := true;
    FetchAll;
    BufferRowNum := 1;
    while not BufferEof do begin
      Selected[ BufferRowNum ] :=
        slFields.IndexOfName( Trim( qrTables.Fields[0].AsString ) + '.' +
                              Trim( BufferFields[0].AsString )) <> -1;
      BufferRowNum := BufferRowNum + 1;
    end;
  finally
    fldSet := false;
  end;
end;

procedure TfrmDataDump.qrTablesRowSelectedChanged(Sender: TObject;
  ARow: integer; ABookmark: string; IsSelected: Boolean);
begin
  if not tblSet then 
    with qrTables do
    begin
      BufferRowNum := ARow;
      if Selected[ ARow ] then
        slTables.Values[ Trim( BufferFields[0].AsString ) ] := 'F'
      else
        slTables.Values[ Trim( BufferFields[0].AsString ) ] := '';
    end;
end;

procedure TfrmDataDump.qrFieldsRowSelectedChanged(Sender: TObject;
  ARow: integer; ABookmark: string; IsSelected: Boolean);
begin
  if not fldSet then
    with qrFields do
    begin
      BufferRowNum := ARow;
      if Selected[ ARow ] then
        slFields.Values[ Trim( qrTables.Fields[0].AsString ) + '.' +
                         Trim( BufferFields[0].AsString ) ] := 'F'
      else
        slFields.Values[ Trim( qrTables.Fields[0].AsString ) + '.' +
                         Trim( BufferFields[0].AsString ) ] := '';
    end;
end;

procedure TfrmDataDump.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

end.



