unit UdmLesson2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components;

type
  TdmLesson2 = class(TDataModule)
    trn: TIB_Transaction;
    qryMaster: TIB_Query;
    qryDetail: TIB_Query;
    srcMaster: TIB_DataSource;
    srcDetail: TIB_DataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmLesson2: TdmLesson2;

implementation

uses UdmMain;

{$R *.DFM}

end.
