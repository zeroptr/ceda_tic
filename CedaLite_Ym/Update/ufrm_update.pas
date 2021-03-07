unit ufrm_update;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Process, IB_Script, IB_Components, StdCtrls;

type
  Tfrm_update = class(TForm)
    dbaMain: TIB_Connection;
    trn_Uretim: TIB_Transaction;
    IB_Query2: TIB_Query;
    IB_Script1: TIB_Script;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Od: TOpenDialog;
    Label4: TLabel;
    Edit4: TEdit;
    Button2: TButton;
    Uygula: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure UygulaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_update: Tfrm_update;

implementation

{$R *.dfm}

procedure Tfrm_update.Button1Click(Sender: TObject);
begin

   if Od.Execute then
   begin
   
       trn_Uretim.Rollback;
       dbaMain.Disconnect;

       dbaMain.Password:=Edit1.Text;
       dbaMain.Username:=Edit2.Text;
       Edit3.Text:=Od.Filename;
       dbaMain.DatabaseName:=Edit3.Text;
       dbaMain.Path:=Edit3.Text;

       dbaMain.Connect;
       trn_Uretim.StartTransaction;

   end;

end;

procedure Tfrm_update.Button2Click(Sender: TObject);
begin
     if Od.Execute then
     begin
          IB_Script1.SQL.LoadFromFile(Od.FileName);
     end;
end;

procedure Tfrm_update.UygulaClick(Sender: TObject);
begin
     //try
     IB_Script1.Execute;
     //except
     //end;
     trn_Uretim.Commit;
     dbaMain.Disconnect;
end;

end.
