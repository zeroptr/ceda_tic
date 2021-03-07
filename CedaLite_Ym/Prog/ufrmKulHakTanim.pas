unit ufrmKulHakTanim;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, ComCtrls, Grids, IB_Grid, IB_Components,
  Menus, IB_StoredProc;

type
  Tfrm_Kul_Hak_Tanim = class(TForm)
    IB_Grid1: TIB_Grid;
    Label1: TLabel;
    Panel1: TPanel;
    btnExit: TBitBtn;
    qry_Kullanici: TIB_Query;
    dts_Kullanici: TIB_DataSource;
    IB_Grid2: TIB_Grid;
    qry_Program: TIB_Query;
    dts_Program: TIB_DataSource;
    IB_Grid4: TIB_Grid;
    qry_ModulHak: TIB_Query;
    dts_ModulHak: TIB_DataSource;
    MainMenu1: TMainMenu;
    dERiLEMLER1: TMenuItem;
    KullancModulKontrol1: TMenuItem;
    sp_KULLANICI_MODUL_KONTROL: TIB_StoredProc;
    KullancHakkKopyalama1: TMenuItem;
    Panel2: TPanel;
    IB_Grid3: TIB_Grid;
    Label2: TLabel;
    Button1: TButton;
    qry_Kopyala: TIB_Query;
    dts_Kopyala: TIB_DataSource;
    sp_KULLANICI_HAK_ESLE: TIB_StoredProc;
    Button2: TButton;
    function Form_Open(Menu:Boolean):Integer;
    procedure btn_Hep_SecClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btn_IzlemeClick(Sender: TObject);
    procedure btn_DegisClick(Sender: TObject);
    procedure btn_SilClick(Sender: TObject);
    procedure btn_UygulaClick(Sender: TObject);
    procedure qry_ProgramAfterScroll(IB_Dataset: TIB_Dataset);
    procedure KullancModulKontrol1Click(Sender: TObject);
    procedure KullancHakkKopyalama1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button2Click(Sender: TObject);
  private
    izle,degis,sil:integer;
    strSQL:String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Kul_Hak_Tanim: Tfrm_Kul_Hak_Tanim;

implementation
uses unDataMod,unFunc;
{$R *.DFM}

{ Tfrm_Kul_Hak_Tanim }

function Tfrm_Kul_Hak_Tanim.Form_Open(Menu: Boolean): Integer;
begin
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Application.CreateForm(Tfrm_Kul_Hak_Tanim, frm_Kul_Hak_Tanim);
  with frm_Kul_Hak_Tanim do
  begin
    qry_Kullanici.Active := True;
    qry_Program.Active := True;
    qry_ModulHak.Active := True;
    ShowModal;
    qry_Kullanici.Active := False;
    qry_ModulHak.Active := False;
    qry_Program.Active := False;
    Release;
  end;
end;


procedure Tfrm_Kul_Hak_Tanim.btn_Hep_SecClick(Sender: TObject);
begin
{  if qry_Modul_Hak.State in [dssEdit,dssInsert] then qry_Modul_Hak.Post;
  update.Active := False;

    strSQL := 'UPDATE MODULHAK SET IZLEME=1,DEGISTIRME=1,SILME=1 WHERE KULLANICI_ID='+
            qry_Kullanici.FieldByName('KULLANICI_ID').AsString+' AND '+'KULLANICI_SID='+
            qry_Kullanici.FieldByName('KULLANICI_SID').AsString;

  update.SQL.Clear;
  update.SQL.Add(strSQL);
  update.Active := True;
  qry_Modul_Hak.RefreshAll;}
end;

procedure Tfrm_Kul_Hak_Tanim.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Kul_Hak_Tanim.btn_IzlemeClick(Sender: TObject);
begin



{  if qry_Modul_Hak.State in [dssEdit,dssInsert] then qry_Modul_Hak.Post;
  update.Active := False;
  if izle=0 then
  begin
  strSQL := 'UPDATE MODULHAK SET IZLEME=1 WHERE KULLANICI_ID='+
             qry_Kullanici.FieldByName('KULLANICI_ID').AsString+' AND '+'KULLANICI_SID='+
             qry_Kullanici.FieldByName('KULLANICI_SID').AsString;
  izle:=1;
  end
  else
  begin
     strSQL := 'UPDATE MODULHAK SET IZLEME=0 WHERE KULLANICI_ID='+
             qry_Kullanici.FieldByName('KULLANICI_ID').AsString+' AND '+'KULLANICI_SID='+
             qry_Kullanici.FieldByName('KULLANICI_SID').AsString;
  izle := 0;
  end;

  update.SQL.Clear;
  update.SQL.Add(strSQL);
  update.Active := True;
  qry_Modul_Hak.RefreshAll;}
end;

procedure Tfrm_Kul_Hak_Tanim.btn_DegisClick(Sender: TObject);
begin
{  if qry_Modul_Hak.State in [dssEdit,DssInsert] then qry_Modul_Hak.Post;
  update.Active := False;
  if degis = 0 then
  begin
  strSQL := 'UPDATE MODULHAK SET DEGISTIRME=1 WHERE KULLANICI_ID='+
            qry_Kullanici.FieldByName('KULLANICI_ID').AsString+' AND '+'KULLANICI_SID='+
            qry_Kullanici.FieldByName('KULLANICI_SID').AsString;
            degis := 1;
  end
  else
  begin
  strSQL := 'UPDATE MODULHAK SET DEGISTIRME=0 WHERE KULLANICI_ID='+
            qry_Kullanici.FieldByName('KULLANICI_ID').AsString+' AND '+'KULLANICI_SID='+
            qry_Kullanici.FieldByName('KULLANICI_SID').AsString;
            degis := 0;
  end;
  update.SQL.Clear;
  update.SQL.Add(strSQL);
  update.Active := True;
  qry_Modul_Hak.RefreshAll;}
end;


procedure Tfrm_Kul_Hak_Tanim.btn_SilClick(Sender: TObject);
begin
{  if qry_Modul_Hak.State in [dssEdit,DssInsert] then qry_Modul_Hak.Post;
  update.Active := False;
  if sil = 0 then
  begin
     strSQL := 'UPDATE MODULHAK SET SILME=1 WHERE KULLANICI_ID='+
               qry_Kullanici.FieldByName('KULLANICI_ID').AsString+' AND '+'KULLANICI_SID='+
               qry_Kullanici.FieldByName('KULLANICI_SID').AsString;
               sil := 1;
  end
  else
  begin
     strSQL := 'UPDATE MODULHAK SET SILME=0 WHERE KULLANICI_ID='+
               qry_Kullanici.FieldByName('KULLANICI_ID').AsString+' AND '+'KULLANICI_SID='+
               qry_Kullanici.FieldByName('KULLANICI_SID').AsString;
               sil := 0;
  end;
  update.SQL.Clear;
  update.SQL.Add(strSQL);
  update.Active := True;
  qry_Modul_Hak.RefreshAll;}
end;

procedure Tfrm_Kul_Hak_Tanim.btn_UygulaClick(Sender: TObject);
begin
{  if izle=0 then
  begin
  strSQL := 'UPDATE MODULHAK SET IZLEME=1 WHERE KULLANICI_ID='+
             qry_Kullanici.FieldByName('KULLANICI_ID').AsString+' AND '+'KULLANICI_SID='+
             qry_Kullanici.FieldByName('KULLANICI_SID').AsString;

  izle:=1;
  end
  else
  begin
     strSQL := 'UPDATE MODULHAK SET IZLEME=0 WHERE KULLANICI_ID='+
             qry_Kullanici.FieldByName('KULLANICI_ID').AsString+' AND '+'KULLANICI_SID='+
             qry_Kullanici.FieldByName('KULLANICI_SID').AsString;


  izle := 0;
  end;
  showmessage(strSQL);}
end;

procedure Tfrm_Kul_Hak_Tanim.qry_ProgramAfterScroll(IB_Dataset: TIB_Dataset);
begin
//burak ozler tarafýndan düzeltildi.
//23.10.2002
  with qry_ModulHak do
  begin
    Active := False;
    ParamByName('PRM_PROGRAM_ID').AsInteger := qry_Program.FieldByName('PROGRAM_ID').AsInteger;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_SID').AsInteger;
    Active := True;
  end;
end;

procedure Tfrm_Kul_Hak_Tanim.KullancModulKontrol1Click(Sender: TObject);
begin
  case Application.MessageBox('Kullanýcý modül kontrolu yapýlmasýný istiyor musunuz?','Dikkat',MB_YESNO) of
  6:
    begin
      sp_KULLANICI_MODUL_KONTROL.Execute;
    end;
  end;
end;

procedure Tfrm_Kul_Hak_Tanim.KullancHakkKopyalama1Click(Sender: TObject);
begin
  qry_Kopyala.Active := True;
  panel2.Visible := True;
end;

procedure Tfrm_Kul_Hak_Tanim.Button1Click(Sender: TObject);
begin
  case Application.MessageBox('Kopyalama iþlemi yapmak istiyor musunuz?','Dikkat',MB_YESNO) of
  6:
    begin
      with sp_KULLANICI_HAK_ESLE do
      begin
        ParamByName('PRM_S_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
        ParamByName('PRM_S_KULLANICI_SID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_SID').AsInteger;
        ParamByName('PRM_T_KULLANICI_ID').AsInteger := qry_Kopyala.FieldByName('KULLANICI_ID').AsInteger;
        ParamByName('PRM_T_KULLANICI_SID').AsInteger := qry_Kopyala.FieldByName('KULLANICI_SID').AsInteger;
        Execute;
      end;
      qry_Kopyala.Active := False;
      panel2.Visible := False;
      qry_ModulHak.RefreshAll;
    end;
  end;
end;

procedure Tfrm_Kul_Hak_Tanim.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  qry_Kopyala.Active := False;
end;

procedure Tfrm_Kul_Hak_Tanim.Button2Click(Sender: TObject);
begin
  qry_Kopyala.Active := false;
  panel2.Visible := false;
end;

end.
