unit IBD_Import;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TDlgImport = class(TForm)
    Button1: TButton;
    lblRecsReaded: TLabel;
    lblRecsInserted: TLabel;
    RecsReaded: TLabel;
    RecsInserted: TLabel;
    lblRecsCommented: TLabel;
    RecsCommented: TLabel;
    Bevel1: TBevel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


implementation

{$R *.DFM}

end.
