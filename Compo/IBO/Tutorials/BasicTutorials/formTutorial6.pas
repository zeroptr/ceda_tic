unit formTutorial6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  formTutorial5, IB_Components, IB_Grid, Mask, IB_Controls, StdCtrls,
  IB_IncSearch, Grids, ComCtrls, IB_UpdateBar, IB_SearchBar,
  IB_NavigationBar, IB_DataSetBar, IB_ConnectionBar, ExtCtrls, IB_Process,
  IB_Script;

type
  TfrmTutorial6 = class(TfrmTutorial5)
    procedure FormCreate(Sender: TObject);
    procedure srcMainStateChanged(Sender: TIB_DataSource;
      ADataSet: TIB_DataSet);
  private
    procedure InitializeSearchBar;
  end;

var
  frmTutorial6: TfrmTutorial6;

implementation

{$R *.DFM}

{ ################################# Internal ################################ }

procedure TfrmTutorial6.FormCreate(Sender: TObject);
begin
  inherited;
  InitializeSearchBar;
end;

procedure TfrmTutorial6.srcMainStateChanged(Sender: TIB_DataSource;
  ADataSet: TIB_DataSet);
begin
  inherited;
  if srcMain.State = dssSearch then begin
    with qryCategory do if not Active then Active := True;
    pagMain.ActivePage := tabEdit;
  end; { if }
end;

{ ################################# Private ################################# }

procedure TfrmTutorial6.InitializeSearchBar;
begin
  with barSearchBar do begin
    VisibleButtons := [sbOrder, sbSearch, sbSave, sbClear, sbRecall, sbCount];
  end; { with }
end;

end.
