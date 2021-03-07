unit formTutorial5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  formTutorial4, IB_Components, StdCtrls, IB_IncSearch, Grids,
  IB_Grid, ComCtrls, IB_SearchBar, IB_NavigationBar, IB_DataSetBar,
  IB_ConnectionBar, ExtCtrls, IB_UpdateBar, Mask, IB_Controls, IB_Process,
  IB_Script;

type
  TfrmTutorial5 = class(TfrmTutorial4)
    tabEdit: TTabSheet;
    edtDescription: TIB_Edit;
    edtBarCode: TIB_Edit;
    edtCostPrice: TIB_Edit;
    edtCurrentValue: TIB_Edit;
    lblDescription: TLabel;
    lblBarCode: TLabel;
    lblCostPrice: TLabel;
    lblCurrentValue: TLabel;
    lblCategory: TLabel;
    luCategory: TIB_LookupCombo;
    qryCategory: TIB_Query;
    srcCategory: TIB_DataSource;
    barUpdateBar: TIB_UpdateBar;
    procedure FormCreate(Sender: TObject);
    procedure qryMainActiveChange(Sender: TIB_Statement);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure InitializeQuery;
    procedure InitializeCategoryQuery;
    procedure InitializeGrid;
    procedure InitializeUpdateBar;
    procedure InitializeEdits;
  end;

var
  frmTutorial5: TfrmTutorial5;

implementation

{$R *.DFM}

{ ################################# Internal ################################ }

procedure TfrmTutorial5.FormCreate(Sender: TObject);
begin
  inherited;
  InitializeQuery;
  InitializeCategoryQuery;
  InitializeGrid;
  InitializeUpdateBar;
  InitializeEdits;
end;

procedure TfrmTutorial5.qryMainActiveChange(Sender: TIB_Statement);
begin
  inherited;
  qryCategory.Active := qryMain.Active;
end;

procedure TfrmTutorial5.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryCategory.Unprepare;
end;

{ ################################# Private ################################# }

procedure TfrmTutorial5.InitializeQuery;
begin
  with qryMain do begin
    GeneratorLinks.Values['ITEM.ID'] := 'GEN_ITEM_ID';
    PreventDeleting := False;
    RequestLive := True;
  end; { with }
end;

procedure TfrmTutorial5.InitializeCategoryQuery;
begin
  with qryCategory do begin
    Active := False; 
    ColorScheme := True;
    IB_Connection := cnMain;
    IB_Transaction := tnMain;
    KeySource := srcMain;
    RequestLive := False;
    with SQLSelect do begin
      Clear;
      Add('SELECT CATEGORY.ID, CATEGORY.CODE, CATEGORY.DESCRIPTION');
    end; { with }
    with SQLFrom do begin
      Clear;
      Add('FROM CATEGORY');
    end; { with }
    with KeyLinks do begin
      Clear;
      Add('CATEGORY.ID=ITEM.ID_CATEGORY');
    end; { with }
    with OrderingItems do begin
      Clear;
      Add('Code=CATEGORY.CODE');
      Add('Category=CATEGORY.SHW_DESCRIPTION');
    end; { with }
    with OrderingLinks do begin
      Clear;
      Add('CATEGORY.CODE=1');
      Add('CATEGORY.DESCRIPTION=2');
    end; { with }
    OrderingItemNo := 1;
    with ColumnAttributes do begin
      Clear;
      LinkParamValue['CATEGORY.CODE', 'NOCASE'] := 'CATEGORY.CODE';
      LinkParamValue['CATEGORY.DESCRIPTION', 'NOCASE'] := 'CATEGORY.SHW_DESCRIPTION';
    end; { with }
  end; { with }
  with srcCategory do begin
    AutoEdit := False;
    AutoInsert := False;
    DataSet := qryCategory;
  end; { with }
  with luCategory do begin
    ColLines := True;
    DataSource := srcCategory;
    IndicateOrdering := True;
    IndicateRow := True;
    IndicateSelected := True;
    IndicateTitles := True;
//    ReadOnly := True;
    RowLines := False;
  end; { with }
end;

procedure TfrmTutorial5.InitializeGrid;
begin
  with gridMain do begin
    ReadOnly := False;
    RowSelect := False;
  end; { with }
end;

procedure TfrmTutorial5.InitializeUpdateBar;
begin
  with barUpdateBar do begin
    DataSource := srcMain;
    VisibleButtons := VisibleButtons + [ubRefreshAll];
    Width := 139;
  end; { with }
end;

procedure TfrmTutorial5.InitializeEdits;
begin
  with edtDescription do begin
    DataField := 'DESCRIPTION';
    DataSource := srcMain;
  end; { with }
  with edtBarCode do begin
    DataField := 'BARCODE';
    DataSource := srcMain;
  end; { with }
  with edtCostPrice do begin
    DataField := 'COST_PRICE';
    DataSource := srcMain;
  end; { with }
  with edtCurrentValue do begin
    DataField := 'CURR_VALUE';
    DataSource := srcMain;
  end; { with }
end; { with }

end.
