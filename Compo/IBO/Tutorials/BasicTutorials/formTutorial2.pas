unit
  formTutorial2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  formTutorial1, IB_Components, IB_ConnectionBar, ExtCtrls, Grids, IB_Grid,
  IB_DataSetBar, IB_NavigationBar, ComCtrls, StdCtrls, IB_Process,
  IB_Script;

type
  TfrmTutorial2 = class(TfrmTutorial1)
    gridMain: TIB_Grid;
    barDataSetBar: TIB_DataSetBar;
    barNavigationBar: TIB_NavigationBar;
    pnlSearch: TPanel;
    srcMain: TIB_DataSource;
    qryMain: TIB_Query;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryMainCalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
  private
    procedure InitializeQuery;
    procedure InitializeDataSource;
    procedure InitializeDataSetBar;
    procedure InitializeNavigationBar;
    procedure InitializeGrid;
    procedure DefineQuerySQL;
  end;

var
  frmTutorial2: TfrmTutorial2;

implementation

{$R *.DFM}

{ ################################# Internal ################################ }

procedure TfrmTutorial2.FormCreate(Sender: TObject);
begin
  inherited;
  InitializeQuery; // Defines the Query's settings, [ but not the SQL ].
  InitializeDataSource; // Defines the DataSource's settings.
  InitializeDataSetBar; // Sets the properties for the DataSet bar.
  InitializeNavigationBar; // Defines the Navigation bar's properties.
  InitializeGrid; // Sets the properties for the Grid.
  DefineQuerySQL; // Defines the Query's SQL.
end;

procedure TfrmTutorial2.qryMainCalculateField(Sender: TIB_Statement;
  ARow: TIB_Row; AField: TIB_Column);
var
  lvVal: Double;
begin
  inherited;
  with AField do
  begin
    if FieldName = 'C_LOSS' then
    begin
      with ARow do
      begin
        lvVal := ByName('COST_PRICE').AsDouble;
        if lvVal = 0 then
          lvVal := 0
        else
          lvVal := ( lvVal - ByName('CURR_VALUE').AsDouble ) * 100 / lvVal;
      end; { with }
      AsInteger := Trunc(lvVal);
    end; { if }
  end; { with }
end;

procedure TfrmTutorial2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryMain.Unprepare;
end;

{ ################################# Private ################################# }

procedure TfrmTutorial2.InitializeQuery;
begin
  { The TIB_Query deals with the actual retrieval and manipulation of data, in
    much th same way as the VCL TQuery does. }
  with qryMain do
  begin
    { There is no way that this query is active from design-time since we
      already set the Connection.Active := False, so the following step is
      optional. }
    Active := False; // Default = False

    { Setting this property to TRUE causes the Query to fetch *all* the data as
      soon as you open it. This is not such a good idea if the table is very
      large! }
    AutoFetchAll := False; // Default = False

    { Setting this to TRUE causes the first record to be fetched as soon as the
      query is opened. This is the default behaviour and is normally what you
      would want a query to do. }
    AutoFetchFirst := True; // Default = TRUE

    { If set to TRUE, then any deletes are automatically posted. Be careful with
      this as if you have AutoCommit = TRUE in your IB_Transaction, then you
      will have no way of 'Undeleting' this record as it will be automatically
      Committed too. If set to FALSE, then you will have to post the Delete
      manually, which may not 'make sense' to the end-user. }
    AutoPostDelete := True;  // Default = TRUE

    { This property tells the query whether or not to use the IBO color scheme
    in the data-aware controls. It is useful and informative, so let's use it. }
    ColorScheme := True; // Default = FALSE

    { This property, when set, displays a message-box to the user asking them
      to confirm a delete operation. This allows them to back out of an
      'accidental' delete. If this property is not set, then no confirmation
      is shown. }
    with ConfirmDeletePrompt do
      Text := 'Are you sure you want to Delete this ITEM ?'; // Default = '';

    { FetchWholeRows tells the Query to act more like the VCL queries. However,
      if you set this to TRUE, then you may lose some of the excellent
      Client/Server performance gains that IBO gives you. It also has to be set
      to TRUE in a few other specific circumstances. }
    FetchWholeRows := False; // Default = FALSE

    { This property tells the Query that when a new row is inserted, then it
    must get the default field values from the Database. This is an expensive
    operation though, as the  MetaData has to be queried, so it should generally
    be set to FALSE. }
    GetServerDefaults := False; // Default = FALSE

    { This query needs to get its data from somewhere, as well as its
      transaction control, so set these properties appropriately. }
    IB_Connection := cnMain;
    IB_Transaction := tnMain;

    { With PessimisticLocking set to TRUE, the record is locked whilst being
      edited. This guarantees that no other users try and edit the same record.
      However, if a user does not post a record that they are editing then
      that record may stay locked indefinetely, which will prevent other users
      from editing it. So it should be used carefully. }
    PessimisticLocking := False; // Default = FALSE

    { All the PreventXXX properties do exactly as they say. They prevent a user
      from doing the associated action on the data. For instance, setting
      PreventDeleting := TRUE will not allow users to Delete record from this
      query. Let's set this just to see it work. }
    PreventDeleting := True; // Default = FALSE

    { Is this query ReadOnly or can updates, etc be performed against it? }
    RequestLive := False; // Default = FALSE

  end; { with }
end;

procedure TfrmTutorial2.InitializeDataSource;
begin
  with srcMain do
  begin
    { Set the DataSet where this DataSource will get its Data from. }
    DataSet := qryMain;
  end; { with }
end;

procedure TfrmTutorial2.InitializeDataSetBar;
begin
  with barDataSetBar do
  begin
    { Set the DataSource that this DataSet bar will act upon. }
    DataSource := srcMain;
  end; { with }
end;

procedure TfrmTutorial2.InitializeNavigationBar;
begin
  with barNavigationBar do
  begin
    { Set the DataSource that this Navigation bar will act upon. }
    DataSource := srcMain;
  end; { with }
end;

procedure TfrmTutorial2.InitializeGrid;
begin
  with gridMain do
  begin
    AlwaysShowEditor := False;
    ColLines := True;
    ColMoving := True;
    ColSizing := True;
    { Set the DataSource that this Grid will use. }
    DataSource := srcMain;
    IndicateHighlight := True;
    IndicateOrdering := True;
    IndicateRow := True;
    IndicateSelected := True;
    IndicateTitles := True;
    with OrderingFont do Style := Style + [fsBold];
    ReadOnly := False;
    RowLines := True;
    RowSelect := True;
  end; { with }
end;

procedure TfrmTutorial2.DefineQuerySQL;
begin
  with qryMain do
  begin
    KeyRelation := 'ITEM';
    with SQLSelect do
    begin
      Clear;
      Add('SELECT ITEM.ID, ITEM.DESCRIPTION,');
      Add('ITEM.BARCODE, ITEM.COST_PRICE, ITEM.CURR_VALUE,');
      Add('ITEM.SYS_CHG_USER');
    end; { with }
    with SQLFrom do
    begin
      Clear;
      Add('FROM ITEM');
    end; { with }
    with KeyLinks do
    begin
      Clear;
      Add('ITEM.ID');
    end; { with }
    with FieldsVisible do
    begin
      Clear;
      Values['ITEM.ID'] := 'F';
      Values['ITEM.SYS_CHG_USER'] := 'F';
    end; { with }
    with CalculatedFields do
    begin
      Clear;
      Add('C_LOSS INTEGER');
    end; { with }
    with FieldsDisplayLabel do
    begin
      Clear;
      Values['ITEM.BARCODE'] := 'BarCode';
      Values['ITEM.DESCRIPTION'] := 'Description';
      Values['ITEM.COST_PRICE'] := 'Cost Price';
      Values['ITEM.CURR_VALUE'] := 'Current Value';
      Values['C_LOSS'] := '% Loss';
    end; { with }
  end; { with }
end;

end.


