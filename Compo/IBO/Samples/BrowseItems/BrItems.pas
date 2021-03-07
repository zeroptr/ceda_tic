unit
  BrItems;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, ExtCtrls,

  IB_Constants,
  IB_Session,
  IB_Components,
  IB_Grid,
  IB_Process,
  IB_Script,
  IB_Dialogs;

type
  TfrmBrItems = class(TForm)
    gridList: TIB_Grid;
    qryList: TIB_Query;
    srcList: TIB_DataSource;
    cnBrowseItems: TIB_Connection;
    trBrowseItems: TIB_Transaction;
    scrDB: TIB_Script;
    md: TIB_MonitorDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cnBrowseItemsBeforeConnect(Sender: TIB_Connection);
  private
    procedure DefineDB;
    procedure DefineListSQL;
    procedure RefreshData;
  end;

var
  frmBrItems: TfrmBrItems;

implementation

{$R *.DFM}

procedure TfrmBrItems.FormCreate(Sender: TObject);
begin
  md.Show;
  ActiveControl := gridList;
  KeyPreview := True;
  with gridList do begin
    AlwaysShowEditor := False;
    DataSource := srcList;
    IndicateHighlight := True;
    IndicateOrdering := True;
    IndicateRow := False;
    IndicateSelected := False;
    IndicateTitles := True;
    ColLines := True;
    RowLines := False;
    ReadOnly := True;
    RowSelect := True;
    ThumbTracking := False;
  end;
  DefineDB;
  DefineListSQL;
  RefreshData;
end;

procedure TfrmBrItems.FormDestroy(Sender: TObject);
begin
  qryList.Unprepare;
end;

procedure TfrmBrItems.DefineDB;
begin
  with cnBrowseItems do
  begin
    if Connected then Close; // Close the TIB_Connection before changing any properties.
    with Params do
    begin
      Values[IB_SERVER] := '';
      Values[IB_PATH] := 'BROWSEITEMS.GDB';
      Values[IB_USER_NAME] := 'SYSDBA';
      Values[IB_PASSWORD] := 'masterkey';
      Values[IB_PROTOCOL] := 'LOCAL';
    end;
    CharSet := 'ISO8859_1'; // Define the Connection CharSet.
    Open;
  end;
  with trBrowseItems do
  begin
    AutoCommit := False; // Explicit tn-control. Probably will not used anyway, since ReadOnly!
    IB_Connection := cnBrowseItems; // Set the TIB_Connection that this TIB_Transaction belongs to.
    Isolation := tiCommitted; // We can see the ( committed ) changes made by other users.
    ReadOnly := True; // This connection is only used for reading data.
    RecVersion := True; // We can see an earlier RecVersion in order to avoid deadlocks!
  end;
  with qryList do
  begin
    FetchWholeRows := False;
    IB_Connection := cnBrowseItems;
    IB_Transaction := trBrowseItems;
    ReadOnly := True;
    RefreshAction := raKeepDataPos;
    RefreshOnParamChange := False; // Use explicit Refresh for better control.
    RequestLive := False;
  end;
end;

procedure TfrmBrItems.DefineListSQL;
begin
  with qryList do
  begin
    SQL.Clear;
    with SQLSelect do
    begin
      Clear;
      Add('SELECT DESCRIPTION.C_CODE,');
      Add('       DESCRIPTION.DESCRIPTION,');
      Add('       ITEM.ID,');
      Add('       ITEM.DBID,');
      Add('       ITEM.ASSETNO,');
      Add('       ITEM.C_HOSTSCAN,');
      Add('       ITEM.SCANCODE,');
      Add('       ITEM.SERIALNO');
    end;
    with SQLFrom do
    begin
      Clear;
      Add('FROM ITEM, DESCRIPTION');
    end;
    with SQLWhere do
    begin
      Clear;
      AddSQLWhereClause('ITEM.DBID = ?P_DBID');
      AddSQLWhereClause('ITEM.ASSETNO STARTING ?P_SEARCH');
    end;
    with JoinLinks do
    begin
      Clear;
      Add('DESCRIPTION.ID=ITEM.ID_DESCRIPTION');
    end;
    with KeyLinks do
    begin
      Clear;
      Add('ITEM.ID');
      Add('ITEM.DBID');
    end;
    with OrderingItems do
    begin
      Clear;
      Add('Description=DESCRIPTION.C_DESC');
      Add('SubCategory=DESCRIPTION.C_CODE');
      Add('AssetNo=ITEM.ASSETNO');
      Add('Host=ITEM.C_HOSTSCAN');
      Add('ScanCode=ITEM.SCANCODE');
      Add('SerialNo=ITEM.SERIALNO');
    end;
    with OrderingLinks do
    begin
      Clear;
      Add('DESCRIPTION.C_CODE=ITEM=1;POS=0');
      Add('DESCRIPTION.DESCRIPTION=ITEM=2;POS=0');
      Add('ITEM.ASSETNO=ITEM=3;POS=0');
      Add('ITEM.C_HOSTSCAN=ITEM=4;POS=0');
      Add('ITEM.SCANCODE=ITEM=5;POS=0');
      Add('ITEM.SERIALNO=ITEM=6;POS=0');
    end;
    with FieldsDisplayLabel do
    begin
      Clear;
      Add('DESCRIPTION.DESCRIPTION=Description');
      Add('DESCRIPTION.C_CODE=SubCategory');
      Add('ITEM.ASSETNO=AssetNo');
      Add('ITEM.C_HOSTSCAN=Host');
      Add('ITEM.SCANCODE=ScanCode');
      Add('ITEM.SERIALNO=SerialNo');
    end;
  end;
end;

procedure TfrmBrItems.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F5 then
  begin
    Key := 0;
    RefreshData;
  end;
end;

procedure TfrmBrItems.RefreshData;
begin
  with qryList, IB_Session do
  begin
    BeginBusy(False);
    try
      DisableControls;
      try
        Prepare; // Re-Prepare the Query if the SQL was Invalidated.
        Params.BeginUpdate; // Do not allow Search to happen until we have set all Params.
        try
          ParamByName('P_DBID').AsInteger := 1;
          ParamByName('P_SEARCH').AsString := '';
        finally
          Params.EndUpdate(True); // OK, the Params are all set, so the Search can be done now.
        end;
        if OrderingItemNo = 0 then OrderingItemNo := 1;
        if Active then Refresh else Open; // Display the new data.
      finally
        EnableControls;
      end;
    finally
      EndBusy;
    end;
  end;
end;

procedure TfrmBrItems.cnBrowseItemsBeforeConnect(Sender: TIB_Connection);
begin
// This will automatically create the database on the fly.
  if ( cnBrowseItems.Protocol = cpLocal ) and
     not FileExists( cnBrowseItems.Path ) then
    scrDB.Execute;
end;

end.
