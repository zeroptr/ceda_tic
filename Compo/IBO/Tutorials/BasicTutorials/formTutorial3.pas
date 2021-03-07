unit formTutorial3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  formTutorial2, IB_Components, Grids, IB_Grid, IB_NavigationBar,
  IB_DataSetBar, IB_ConnectionBar, ExtCtrls, IB_UpdateBar, IB_SearchBar,
  StdCtrls, IB_IncSearch, ComCtrls, IB_Process, IB_Script;

type
  TfrmTutorial3 = class(TfrmTutorial2)
    barSearchBar: TIB_SearchBar;
    incSearch: TIB_IncSearch;
    cbKeyByKey: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure gridMainTitleClick(Sender: TObject; ACol, ARow: longint;
      AButton: TMouseButton; AShift: TShiftState);
    procedure xseOrderingRefinePosChange(Sender: TObject);
    procedure qryMainOrderingChange(IB_DataSet: TIB_DataSet);
    procedure qryMainPreparedChanged(Sender: TIB_Statement);
    procedure cbKeyByKeyClick(Sender: TObject);
  private
    procedure InitializeSearchBar;
    procedure InitializeIncSearch;
    procedure DefineQuerySQL;
  end;

var
  frmTutorial3: TfrmTutorial3;

implementation

{$R *.DFM}

{ ################################# Internal ################################ }

procedure TfrmTutorial3.FormCreate(Sender: TObject);
begin
  inherited;
  InitializeSearchBar;
  InitializeIncSearch;
  DefineQuerySQL;
  ActiveControl := incSearch;
end;

procedure TfrmTutorial3.gridMainTitleClick(Sender: TObject; ACol,
  ARow: longint; AButton: TMouseButton; AShift: TShiftState);
begin
  inherited;
  ActiveControl := incSearch;
end;

procedure TfrmTutorial3.xseOrderingRefinePosChange(Sender: TObject);
begin
  inherited;
//  if qryMain.OrderingRefinePos <> xseOrderingRefinePos.Value then
//    qryMain.OrderingRefinePos := xseOrderingRefinePos.Value;
end;

procedure TfrmTutorial3.qryMainOrderingChange(IB_DataSet: TIB_DataSet);
begin
  inherited;
//  xseOrderingRefinePos.Value := qryMain.OrderingRefinePos;
end;

procedure TfrmTutorial3.qryMainPreparedChanged(Sender: TIB_Statement);
begin
  inherited;
//  xseOrderingRefinePos.Value := qryMain.OrderingRefinePos;
end;

procedure TfrmTutorial3.cbKeyByKeyClick(Sender: TObject);
begin
  inherited;
  with incSearch do begin
    SearchKeyByKey := cbKeyByKey.Checked;
    if qryMain.Prepared then SetFocus;
    SelectAll;
  end; { with }
end;

{ ################################# Private ################################# }

procedure TfrmTutorial3.InitializeSearchBar;
begin
  with barSearchBar do begin
    DataSource := srcMain;
    VisibleButtons := [sbOrder, sbCount];
  end; { with }
end;

procedure TfrmTutorial3.InitializeIncSearch;
begin
  with incSearch do begin
    DataSource := srcMain;
    SeekNearest := True;
  end; { with }
  cbKeyByKey.Checked := True;
end;

procedure TfrmTutorial3.DefineQuerySQL;
begin
  with qryMain do begin
    with OrderingItems do begin
      Clear;
      Add('BarCode=ITEM.BARCODE;ITEM.BARCODE DESC');
      Add('Description=ITEM.SHW_DESCRIPTION,ITEM.BARCODE');
    end; { with }
    with OrderingLinks do begin
      Clear;
      Add('ITEM.BARCODE=1');
      Add('ITEM.DESCRIPTION=ITEM=2');
    end; { with }
    OrderingItemNo := 1;    
    with ColumnAttributes do begin
      Clear;
      LinkParamValue['ITEM.DESCRIPTION', 'NOCASE'] := 'ITEM.SHW_DESCRIPTION';
    end; { with }
  end; { with }
end;

end.
 