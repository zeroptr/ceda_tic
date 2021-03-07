unit
  DM_Threads;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  IB_Components,
  IB_Session;

type
  TdmThreads = class(TDataModule)
    cn: TIB_Connection;
    cr: TIB_Cursor;
    se: TIB_Session;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.


