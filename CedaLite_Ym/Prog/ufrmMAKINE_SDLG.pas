unit ufrmMAKINE_SDLG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, IB_Grid, Buttons, ExtCtrls, IB_Components;

type
  TfrmMAKINE_SDLG = class(TForm)
    dstMakine: TIB_DataSource;
    qryMakine: TIB_Query;
    Panel2: TPanel;
    btnIPTAL: TBitBtn;
    btnTAMAM: TBitBtn;
    btnRapor: TButton;
    IB_Grid1: TIB_Grid;
    Panel1: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btn_Ara: TButton;
    procedure btnIPTALClick(Sender: TObject);
    procedure btnTAMAMClick(Sender: TObject);
    procedure btn_AraClick(Sender: TObject);


    function Form_Open(Menu: Boolean; var MAKINE_ID: String; var MAKINE_ADI:String;
      RAPOR: Boolean): Boolean;
    procedure Edit1Enter(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IB_Grid1DblClick(Sender: TObject);
    procedure IB_Grid1KeyPress(Sender: TObject; var Key: Char);

  private
      prv_Kontrol:Boolean;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMAKINE_SDLG: TfrmMAKINE_SDLG;

implementation

uses unDataMod, unFunc;

{$R *.dfm}



function TfrmMAKINE_SDLG.Form_Open(Menu:Boolean;var MAKINE_ID:String; var MAKINE_ADI:String;RAPOR:Boolean):Boolean;
begin
  Application.CreateForm(TfrmMAKINE_SDLG, frmMAKINE_SDLG);
  with frmMAKINE_SDLG do
  begin
    Edit1.Text:='';
    Edit2.Text:='';


    if Rapor then
    begin
      btnRapor.Visible := True;
      btnIPTAL.Visible := False;
      btnTAMAM.Visible := False;
    end
    else
    begin
      btnRapor.Visible := False;
    end;

    ShowModal;
    if not prv_Kontrol Then
    begin
      MAKINE_ID := '';
      MAKINE_ADI := '';
      Result := False;
    end
    else
    begin
      MAKINE_ID := qryMakine.FieldByName('MAK_KOD').AsString;
      MAKINE_ADI := qryMakine.FieldByName('MAK_ADI').AsString;
      Result := True;
    end;
    qryMakine.Close;
    Release;


  end;
end;

procedure TfrmMAKINE_SDLG.btnIPTALClick(Sender: TObject);
begin
  prv_Kontrol := False;
  Close;

end;

procedure TfrmMAKINE_SDLG.btnTAMAMClick(Sender: TObject);
begin
  if not ((qryMakine.Eof) and (qryMakine.Bof)) Then
  begin
    prv_Kontrol := True;
    Close;
  end;

end;

procedure TfrmMAKINE_SDLG.btn_AraClick(Sender: TObject);
var
  strSQL:String;
begin
  strSQL :=
           'SELECT MAK_KOD '+
           ' , MAK_ADI '+
           ' FROM MAKINE '+
           ' WHERE MAK_KOD<>'''' ';

  if Trim(Edit1.Text)<>'' then
   begin
     strSQL := strSQL + ' AND MAKINE.MAK_KOD LIKE '+ SQL_Katar(Edit1.Text+'%');
   end;

  if Trim(Edit2.Text)<>'' then
   begin
     strSQL := strSQL + ' AND MAKINE.MAK_ADI LIKE '+ SQL_Katar(Edit2.Text+'%');
   end;


  try
    with qryMakine do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
    end;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu.','Dikkat',MB_ICONSTOP);
    ShowMessage(strSQL);
  end;



end;

procedure TfrmMAKINE_SDLG.Edit1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmMAKINE_SDLG.Edit2Exit(Sender: TObject);
begin
    (Sender as TEdit).Color := clWindow;
end;

procedure TfrmMAKINE_SDLG.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmMAKINE_SDLG);
end;

procedure TfrmMAKINE_SDLG.IB_Grid1DblClick(Sender: TObject);
begin
  if not ((qryMakine.Eof) and (qryMakine.Bof)) Then
  begin
    prv_Kontrol := True;
    Close;
  end;
end;

procedure TfrmMAKINE_SDLG.IB_Grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
  begin
    prv_Kontrol :=True;
    Close;
  end;
end;

end.
