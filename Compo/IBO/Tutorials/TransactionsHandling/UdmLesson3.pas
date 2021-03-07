unit UdmLesson3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components;

type
  TdmLesson3 = class(TDataModule)
    trn: TIB_Transaction;
    qryTrig1: TIB_Query;
    qryTrig2: TIB_Query;
    srcTrig1: TIB_DataSource;
    srcTrig2: TIB_DataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmLesson3: TdmLesson3;

implementation

uses UdmMain;

{$R *.DFM}

end.
