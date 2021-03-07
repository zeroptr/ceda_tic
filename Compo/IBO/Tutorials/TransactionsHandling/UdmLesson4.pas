unit UdmLesson4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, IB_StoredProc;

type
  TdmLesson4 = class(TDataModule)
    trn: TIB_Transaction;
    ibsp: TIB_StoredProc;
    qryProc: TIB_Query;
    srcProc: TIB_DataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmLesson4: TdmLesson4;

implementation

uses UdmMain;

{$R *.DFM}

end.
