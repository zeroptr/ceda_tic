unit UdmLesson1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components;

type
  TdmLesson1 = class(TDataModule)
    trn: TIB_Transaction;
    qryMaster: TIB_Query;
    srcMaster: TIB_DataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmLesson1: TdmLesson1;

implementation

uses UdmMain;

{$R *.DFM}

end.
