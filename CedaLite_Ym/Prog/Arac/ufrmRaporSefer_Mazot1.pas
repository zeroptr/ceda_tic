unit ufrmRaporSefer_Mazot1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, Grids, IB_Grid, StdCtrls, ExtCtrls;

type
  TfrmRaporSefer_Mazot1 = class(TForm)
    Label36: TLabel;
    TxtMazotcu: TEdit;
    Button7: TButton;
    Label19: TLabel;
    qrySefer: TIB_Query;
    Btn_Bul: TButton;
    IB_Grid1: TIB_Grid;
    IB_DataSource1: TIB_DataSource;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label22: TLabel;
    txtAlanPers: TEdit;
    Button8: TButton;
    Label18: TLabel;
    Label20: TLabel;
    txtArac: TEdit;
    Button6: TButton;
    LblPlaka: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    Button4: TButton;
    Label2: TLabel;
    procedure Button7Click(Sender: TObject);
    procedure TxtMazotcuExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Btn_BulClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure txtAracExit(Sender: TObject);
    procedure txtAlanPersExit(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure txtAracKeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure txtAracEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRaporSefer_Mazot1: TfrmRaporSefer_Mazot1;

implementation

uses unDataMod, ufrmCariSDLG, UnFunc, ufrmFAT_IRS, ufrmSefer, ufrmMazot;

{$R *.dfm}

procedure TfrmRaporSefer_Mazot1.Button7Click(Sender: TObject);

var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      TxtMazotcu.Text := Cari_KOD;
      Label19.Caption := Cari_AD;
  end;

end;

procedure TfrmRaporSefer_Mazot1.TxtMazotcuExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(TxtMazotcu.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',TxtMazotcu.Text,CARI_AD) then
    begin
      Label19.Caption := CARI_AD;
      if (Sender is TEdit) then
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      TxtMazotcu.SetFocus;
    end;
  end
  else
  begin
      if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow;
    Label19.Caption := '';
  end;
end;

procedure TfrmRaporSefer_Mazot1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporSefer_Mazot1.Button1Click(Sender: TObject);
begin
     Close;
end;

procedure TfrmRaporSefer_Mazot1.Btn_BulClick(Sender: TObject);
var
   ilk_sql:AnsiString;
   ilk_sql_w:AnsiString;
   Ek_Var:Boolean;

begin
   ilk_sql:=

   ' SELECT '+

   '  S.SEFER_ID '+
   ' , S.SEFER_SID '+
   ' , S.ARAC_KOD '+
   ' , (SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD) AS ARAC_PLAKA '+
   ' , S.DORSE_KOD '+
   ' , (SELECT PLAKA FROM ARAC AR WHERE AR.ARAC_KOD=SEFER.DORSE_KOD) AS DARAC_PLAKA '+
   ' , S.ALICI_KOD '+
   ' , (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD) AS ALICI_ADI '+
   ' , S.SATICI_KOD '+
   ' , (SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI_KOD) AS SATICI_ADI '+
   ' , S.PERSONEL_KOD '+
   ' , (SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI '+
   ' , S.ALICI_BORC_VPB '+
   ' , S.SATICI_ALACAK_VPB '+
   ' , S.BEKLEME_FAT_VPB '+

   ', M.MAZOT_FIS_ID '+
   ', M.MAZOT_FIS_SID '+
   ', M.FIS_NO '+
   ', M.TARIH '+
   ', M.TUTAR_VPB '+
   ', M.ARAC_KOD '+
   ', (SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=MAZOT_FISI.ARAC_KOD) AS MARAC_PLAKA '+
   ', M.VEREN_PERSONEL_KOD '+
   ', (SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=MAZOT_FISI.VEREN_PERSONEL_KOD) AS MVEREN_PERSONEL_ADI '+
   ', M.ALAN_PERSONEL_KOD '+
   ', (SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=MAZOT_FISI.ALAN_PERSONEL_KOD) AS MALAN_PERSONEL_ADI '+
   ', M.ALAN_CARI_KOD '+
   ', (SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.ALAN_CARI_KOD=CARI.CARI_KOD) AS MALAN_CARI_ADI '+
   ', M.MAZOTCU_CARI_KOD '+
   ',(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.MAZOTCU_CARI_KOD=CARI.CARI_KOD) AS MAZOTCU_CARI_ADI '+



   ' FROM SEFER S '+
   ' INNER JOIN MAZOT_FISI M ON (MAZOT_FISI.ALIS_URUN_HAR_ID=SEFER.SEFER_ID) '+
   ' WHERE MAZOT_FIS_ID<>0 ';

   Ek_Var:=False;
   ilk_sql_w:='';
   if Trim(TxtMazotcu.Text)<>'' then
   begin
       ilk_sql_w:=ilk_sql_w+
       ' AND SEFER.SATICI_KOD='+Sql_Katar(Trim(TxtMazotcu.Text))+' ';
       Ek_Var:=True;
   end;
   if Trim(txtAlanPers.Text)<>'' then
   begin
       //if Ek_Var then ilk_sql_w:=ilk_sql_w+ ' AND ';
       ilk_sql_w:=ilk_sql_w+
       ' AND SEFER.PERSONEL_KOD='+Sql_Katar(Trim(txtAlanPers.Text))+' ';
       Ek_Var:=True;
   end;
   if Trim(txtArac.Text)<>'' then
   begin
       //if Ek_Var then ilk_sql_w:=ilk_sql_w+ ' AND ';
       ilk_sql_w:=ilk_sql_w+
       ' AND SEFER.ARAC_KOD='+Sql_Katar(Trim(txtArac.Text))+' ';
       Ek_Var:=True;
   end;

   if Trim(txtArac.Text)<>'' then
   begin
       //if Ek_Var then ilk_sql_w:=ilk_sql_w+ ' AND ';
       ilk_sql_w:=ilk_sql_w+
       ' AND SEFER.ALICI_KOD='+Sql_Katar(Trim(Edit1.Text))+' ';
       Ek_Var:=True;
   end;

   qrySefer.Active:=False;
   qrySefer.Sql.Clear;
   qrySefer.Sql.Text:=ilk_sql+ilk_sql_w;
   qrySefer.Active:=True;

   if qrySefer.RecordCount>0 then
   begin
     Button2.Enabled:=True;
     Button3.Enabled:=True;
   end;
end;

procedure TfrmRaporSefer_Mazot1.Button2Click(Sender: TObject);
begin
  if qrySefer.FieldByName('SEFER_ID').AsInteger>0 then
  frmSefer.Form_Open(True,qrySefer.FieldByName('SEFER_ID').AsInteger,qrySefer.FieldByName('SEFER_SID').AsInteger,1);
end;

procedure TfrmRaporSefer_Mazot1.Button6Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      txtArac.Text := ARAC_KOD;
      LblPlaka.Caption:=PLAKA;
  end;
end;

procedure TfrmRaporSefer_Mazot1.txtAracExit(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 SATICI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:String;
begin
  if Trim(txtArac.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','PLAKA',txtArac.Text,PLAKA) then
    begin
      LblPlaka.Caption := PLAKA;
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txtArac.SetFocus;
    end;
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
    LblPlaka.Caption := '';
  end;
end;

procedure TfrmRaporSefer_Mazot1.txtAlanPersExit(Sender: TObject);
var
  PERSONEL_AD:String;
begin
  txtAlanPers.Color := clWindow;
  if Trim(txtAlanPers.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PERSONEL','PERSONEL_KOD','ADI_SOYADI',txtAlanPers.Text,PERSONEL_AD) then
    begin
      Label18.Caption := PERSONEL_AD
    end
    else
    begin
      txtAlanPers.SetFocus;
    end
  end
  else
  begin
    Label18.Caption := '';
  end;
end;

procedure TfrmRaporSefer_Mazot1.Button8Click(Sender: TObject);
var
  PERSONEL_KOD, PERSONEL_AD :String;
begin
  if DataMod.LS_Personel(PERSONEL_KOD, PERSONEL_AD) then
  begin
    txtAlanPers.Text:=PERSONEL_KOD;
    Label18.Caption:=PERSONEL_AD;
  end;
end;

procedure TfrmRaporSefer_Mazot1.txtAracKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporSefer_Mazot1.Button3Click(Sender: TObject);
begin
  if qrySefer.FieldByName('MAZOT_FIS_ID').AsInteger>0 then
  frmMazot.Form_Open(True,qrySefer.FieldByName('MAZOT_FIS_ID').AsInteger,qrySefer.FieldByName('MAZOT_FIS_SID').AsInteger,1);
end;

procedure TfrmRaporSefer_Mazot1.Edit1Exit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(Edit1.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',Edit1.Text,CARI_AD) then
    begin
      Label2.Caption := CARI_AD;
      if (Sender is TEdit) then
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      Edit1.SetFocus;
    end;
  end
  else
  begin
      if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow;
    Label2.Caption := '';
  end;
end;

procedure TfrmRaporSefer_Mazot1.Button4Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      Edit1.Text := Cari_KOD;
      Label2.Caption := Cari_AD;
  end;
end;

procedure TfrmRaporSefer_Mazot1.txtAracEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

end.




