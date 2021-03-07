unit frxConnItemEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, frxClass;

type
  TfrxConnectionItemEdit = class(TForm)
    Panel1: TPanel;
    ConnL: TLabel;
    ConnE: TEdit;
    ConnB: TButton;
    OkB: TButton;
    CancelB: TButton;
    NameL: TLabel;
    NameE: TEdit;
    GroupBox1: TGroupBox;
    SystemRB: TRadioButton;
    UserRB: TRadioButton;
    procedure ConnBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Report: TfrxReport;
  end;

var
  frxConnectionItemEdit: TfrxConnectionItemEdit;

implementation

{$R *.dfm}

procedure TfrxConnectionItemEdit.ConnBClick(Sender: TObject);
begin
  if Assigned(Report) and Assigned(Report.OnEditConnection) then
    ConnE.Text := Report.OnEditConnection(ConnE.Text);
end;

end.


//