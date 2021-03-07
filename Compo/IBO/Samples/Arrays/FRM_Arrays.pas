
{                                                                              }
{ FRM_Arrays                                                                   }
{                                                                              }

unit
  FRM_Arrays;

{$I IB_Directives.inc}
  
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, ComCtrls,
    
{$ifdef IBO_VCL60_OR_GREATER}
  Variants,
{$endif}

  IB_Header,
  IB_Session,
  IB_Components,
  IB_ArrayGrid,
  IB_DatasetBar,
  IB_UpdateBar,
  IB_Grid,
  IB_Process,
  IB_Script;

type
  TfrmArrays = class(TForm)
    pnArrays: TPanel;
    lbArrays: TIB_LookupList;
    cnArrays: TIB_Connection;
    trArrays: TIB_Transaction;
    qrArrays: TIB_Query;
    dsArrays: TIB_DataSource;
    agArrays: TIB_ArrayGrid;
    dsbArrays: TIB_DatasetBar;
    ubArrays: TIB_UpdateBar;
    Script: TIB_Script;
    cbArrays: TComboBox;
    btPutVarSlice: TButton;
    btGetVarSlice: TButton;
    Memo1: TMemo;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cnArraysBeforeConnect(Sender: TIB_Connection);
    procedure FormCreate(Sender: TObject);
    procedure cbArraysChange(Sender: TObject);
    procedure btPutVarSliceClick(Sender: TObject);
    procedure btGetVarSliceClick(Sender: TObject);
    procedure qrArraysAfterOpen(IB_Dataset: TIB_Dataset);
  private
  public
    procedure GenerateRecords;
  end;

var
  frmArrays: TfrmArrays;

implementation

{$R *.DFM}

procedure TfrmArrays.FormCreate(Sender: TObject);
begin
  cbArrays.ItemIndex := 0;
  cnArrays.Connect;
  qrArrays.Open;
  agArrays.DataSource := dsArrays;
end;

procedure TfrmArrays.cnArraysBeforeConnect(Sender: TIB_Connection);
begin
  with cnArrays do
    if ( Protocol = cpLocal ) and not FileExists( Database ) then
      Script.Execute;
end;

procedure TfrmArrays.qrArraysAfterOpen(IB_Dataset: TIB_Dataset);
begin
  if qrArrays.IsEmpty then
    GenerateRecords;
end;

procedure TfrmArrays.GenerateRecords;
var
  tmpVar: variant;
  tmpVar2: variant;
  ii, jj: integer;
begin
  qrArrays.DisableControls;
  try
    qrArrays.Open;
    qrArrays.Insert;
    qrArrays['CHARARRAY'] := VarArrayOf(['One','Two','Three','Four','Five']);
    tmpVar := VarArrayCreate( [ 1, 5, 1, 2 ], varVariant );
    tmpVar2 := VarArrayCreate( [ 1, 9, 1, 3 ], varVariant );
    for ii := 1 to 5 do for jj := 1 to 2 do
      tmpVar[ ii, jj ] := ii * jj;
    for ii := 1 to 9 do for jj := 1 to 3 do
      tmpVar2[ ii, jj ] := ii * jj + 0.5;
    qrArrays['INTEGERARRAY'] := tmpVar;
    qrArrays['REALARRAY'] := tmpVar2;
    qrArrays.Post;
    trArrays.SavePoint;
    qrArrays.Append;
    qrArrays['CHARARRAY'] := VarArrayOf(['Please','edit','this','record','']);
    for ii := 1 to 5 do for jj := 1 to 2 do
      tmpVar[ ii, jj ] := ii * jj + 10;
    for ii := 1 to 9 do for jj := 1 to 3 do
      tmpVar2[ ii, jj ] := ii * jj + 0.5 + 10;
    qrArrays['INTEGERARRAY'] := tmpVar;
    qrArrays['REALARRAY'] := tmpVar2;
    qrArrays.Post;
    trArrays.CommitRetaining;
    qrArrays.First;
  finally
    qrArrays.EnableControls;
  end;
end;

procedure TfrmArrays.cbArraysChange(Sender: TObject);
begin
  if cbArrays.ItemIndex = 0 then
    agArrays.DataField := 'CHARARRAY'
  else if cbArrays.ItemIndex = 1 then
    agArrays.DataField := 'INTEGERARRAY'
  else
    agArrays.DataField := 'REALARRAY';
end;

procedure TfrmArrays.btPutVarSliceClick(Sender: TObject);
var
  tmp: variant;
begin
  tmp := VarArrayCreate( [ 2, 4 ], varVariant );
  tmp[2] := '**';
  tmp[3] := '***';
  tmp[4] := '****';
  qrArrays.Edit;
  with qrArrays.FieldByName( 'CHARARRAY' ) as TIB_ColumnArray do
    PutVarSlice( tmp );
  qrArrays.Post;
  agArrays.DataField := 'CHARARRAY';
end;

procedure TfrmArrays.btGetVarSliceClick(Sender: TObject);
var
  tmp: variant;
begin
  with qrArrays.FieldByName( 'CHARARRAY' ) as TIB_ColumnArray do begin
    tmp := GetVarSlice( [ 2, 4 ] );
  end;
  ShowMessage( '[2] := ' + tmp[2] + #13#10 +
               '[3] := ' + tmp[3] + #13#10 +
               '[4] := ' + tmp[4] );
end;

procedure TfrmArrays.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := trArrays.EndWithConfirm = mrOk;
end;

end.

