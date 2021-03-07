unit Form_Employee;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, Mask, ExtCtrls,

  IB_Components,
  IB_Controls;

type
  TfrmEmployee = class(TForm)
    ScrollBox: TScrollBox;
    Label1: TLabel;
    EditEMPNO: TIB_Edit;
    Label2: TLabel;
    EditLASTNAME: TIB_Edit;
    Label3: TLabel;
    EditFIRSTNAME: TIB_Edit;
    Label4: TLabel;
    EditPHONEEXT: TIB_Edit;
    Label5: TLabel;
    EditHIREDATE: TIB_Edit;
    Label6: TLabel;
    EditSALARY: TIB_Edit;
    Panel2: TPanel;
    Cursor: TIB_Cursor;
    DataSource1: TIB_DataSource;
    procedure DataSource1GainFocus(Sender: TIB_DataSource;
      AIB_DataSet: TIB_DataSet);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmEmployee: TfrmEmployee;

implementation

{$R *.DFM}

procedure TfrmEmployee.DataSource1GainFocus(Sender: TIB_DataSource;
  AIB_DataSet: TIB_DataSet);
begin
  with AIB_DataSet do begin
    if not Active then Search;
  end;
end;

end.
