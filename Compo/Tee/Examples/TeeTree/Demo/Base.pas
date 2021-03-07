unit Base;

{ TeeTree 2 Demo - Base Form }
{ This form is inherited by most of the example forms in this demo. }

{ It only contains a Tree control, a Memo and a TreeEditor component. }
{ When double-clicking the Memo the TreeEditor is shown. }
 
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, TeeProcs, TeeTree, StdCtrls, TreeEd;

type
  TBaseForm = class(TForm)
    Tree1: TTree;
    Memo1: TMemo;
    Panel1: TPanel;
    TreeEdit1: TTreeEdit;
    procedure Memo1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TBaseForm.Memo1DblClick(Sender: TObject);
begin
  TreeEdit1.Execute
end;

initialization
  RegisterClass(TBaseForm);
end.
