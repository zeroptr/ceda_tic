unit
  FRM_Company;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids,

  IB_Session,
  IB_Components,
  IB_Grid,
  IB_Process,
  IB_Script,
  IB_SessionProps;

type
  TfrmCompany = class(TForm)
    cnCompany: TIB_Connection;
    qrCompany: TIB_Query;
    dsCompany: TIB_DataSource;
    CompanyLabel: TLabel;
    scCompany: TIB_Script;
    spCpmpany: TIB_SessionProps;
    grCompany: TIB_Grid;
    tr: TIB_Transaction;
    procedure FormCreate(Sender: TObject);
    procedure cnCompanyBeforeConnect(Sender: TIB_Connection);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
  public
  end;

var
  frmCompany: TfrmCompany;

implementation

{$R *.DFM}

uses
  FRM_Employee;

procedure TfrmCompany.FormCreate(Sender: TObject);
begin
  qrCompany.Open;
  TfrmEmployee.Create( Self );
end;

procedure TfrmCompany.cnCompanyBeforeConnect(Sender: TIB_Connection);
begin
  with Sender do begin
    if ( Protocol = cpLocal ) and not FileExists( Database ) then begin
      scCompany.Execute;
    end;
  end;
end;

procedure TfrmCompany.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
//  CanClose := trCompany.CloseWithConfirm = mrOk;
end;

end.

