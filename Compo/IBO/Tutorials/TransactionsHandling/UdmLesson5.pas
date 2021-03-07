unit UdmLesson5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components;

type
  TdmLesson5 = class(TDataModule)
    trn2: TIB_Transaction;
    trn1: TIB_Transaction;
    qryMaster1: TIB_Query;
    qryMaster2: TIB_Query;
    srcMaster1: TIB_DataSource;
    srcMaster2: TIB_DataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmLesson5: TdmLesson5;

implementation

uses UdmMain;

{$R *.DFM}

end.
