unit formTutorial4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  formTutorial3, IB_Components, StdCtrls, IB_IncSearch, Grids, IB_Grid,
  IB_SearchBar, IB_NavigationBar, IB_DataSetBar, IB_ConnectionBar, ExtCtrls,
  ComCtrls, IB_Process, IB_Script;

type
  TfrmTutorial4 = class(TfrmTutorial3)
    procedure FormCreate(Sender: TObject);
  private
    procedure DefineQuerySQL;
  end;

var
  frmTutorial4: TfrmTutorial4;

implementation

{$R *.DFM}

{ ################################# Internal ################################ }

procedure TfrmTutorial4.FormCreate(Sender: TObject);
begin
  inherited;
  DefineQuerySQL;
end;

{ ################################# Private ################################# }

procedure TfrmTutorial4.DefineQuerySQL;
begin
  with qryMain do
  begin
    SQLSelect.Add(',ITEM.ID_CATEGORY, CATEGORY.CODE');
    SQLFrom.Add(',CATEGORY');
    JoinLinks.Add('ITEM.ID_CATEGORY=CATEGORY.ID');
    FieldsDisplayLabel.Values['CATEGORY.CODE'] := 'Category';
    FieldsVisible.Values['ITEM.ID_CATEGORY'] := 'F';
    OrderingItems.Add('Category=CATEGORY.CODE,ITEM.SHW_DESCRIPTION,ITEM.BARCODE');
    OrderingLinks.Add('CATEGORY.CODE=3');
    ColumnAttributes.LinkParamValue['CATEGORY.CODE','NOCASE']:= 'CATEGORY.CODE';
  end;
end;

end.
