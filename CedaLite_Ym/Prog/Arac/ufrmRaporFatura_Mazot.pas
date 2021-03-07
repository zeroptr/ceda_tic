unit ufrmRaporFatura_Mazot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, Grids, IB_Grid, StdCtrls, ExtCtrls;

type
  TfrmRaporFatura_Mazot = class(TForm)
    Label36: TLabel;
    TxtMazotcu: TEdit;
    Button7: TButton;
    Label19: TLabel;
    Btn_Bul: TButton;
    IB_Grid1: TIB_Grid;
    IB_DataSource1: TIB_DataSource;
    Button1: TButton;
    Button2: TButton;
    qrySefer: TIB_Query;
    Button3: TButton;
    procedure Button7Click(Sender: TObject);
    procedure TxtMazotcuExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Btn_BulClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TxtMazotcuEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRaporFatura_Mazot: TfrmRaporFatura_Mazot;

implementation

uses unDataMod, ufrmCariSDLG, UnFunc, ufrmFAT_IRS, ufrmMazot, ufrmFAT_Tran;

{$R *.dfm}

procedure TfrmRaporFatura_Mazot.Button7Click(Sender: TObject);

var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,15) Then
  begin
      TxtMazotcu.Text := Cari_KOD;
      Label19.Caption := Cari_AD;
  end;

end;

procedure TfrmRaporFatura_Mazot.TxtMazotcuExit(Sender: TObject);
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

procedure TfrmRaporFatura_Mazot.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporFatura_Mazot.Button1Click(Sender: TObject);
begin
     Close;
end;

procedure TfrmRaporFatura_Mazot.Btn_BulClick(Sender: TObject);
var
   ilk_sql:AnsiString;
   ilk_sql_w:AnsiString;

begin
   ilk_sql:=
   ' SELECT '+
   '  S.MAZOT_FIS_ID '+
   ', S.MAZOT_FIS_SID '+
   ', S.ARAC_KOD '+
   ', (SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=MAZOT_FISI.ARAC_KOD) AS ARAC_PLAKA '+
   ', S.FIS_NO '+
   ', S.TARIH '+
   ', S.SAAT '+
   ', S.VEREN_PERSONEL_KOD '+
   ',(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=MAZOT_FISI.VEREN_PERSONEL_KOD) AS VEREN_PERSONEL_ADI '+
   ', S.ALAN_PERSONEL_KOD '+
   ',(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=MAZOT_FISI.ALAN_PERSONEL_KOD) AS ALAN_PERSONEL_ADI '+
   ', S.ALAN_CARI_KOD '+
   ',(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.ALAN_CARI_KOD=CARI.CARI_KOD) AS ALAN_CARI_ADI '+
   ', S.MAZOTCU_CARI_KOD '+
   ',(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.MAZOTCU_CARI_KOD=CARI.CARI_KOD) AS MAZOTCU_CARI_ADI '+
   ', S.KM '+
   ', S.LITRE '+
   ', S.LITRE_FIYAT '+
   ', S.DOVKOD '+
   ', S.DOV_BAZ_TAR '+
   ', S.DOVKUR '+
   ', S.TUTAR '+
   ', S.TUTAR_VPB '+
   ', S.ACIKLAMA '+
   ', S.MASRAF_MERK '+
   ', S.KOD1 '+
   ', S.KOD2 '+
   ', S.KOD3 '+
   ', S.KOD4 '+
   ', S.SEFER_ID '+
   ', S.ALIS_URUN_HAR_ID '+
   ', S.SECIM '+
   ', S.ALIS_FATURASI_ALINDI '+

   ' ,FAT_IRS.FAT_IRS_SERI '+
   ' ,FAT_IRS.BELGE_NO '+
   ' ,FAT_IRS.FAT_IRS_ID '+
   ' ,FAT_IRS.GENEL_TOP '+
   ' ,FAT_IRS.FAT_IRS_TIP '+
   ' ,FAT_IRS.FAT_IRS_SID '+
   ' ,FAT_IRS.FAT_IRS_SEP '+
   ' FROM MAZOT_FISI S ';

   if Trim(TxtMazotcu.Text)<>'' then
   begin
       ilk_sql_w:=
       ' WHERE FAT_IRS.CARI_KOD='+Sql_Katar(Trim(TxtMazotcu.Text))+' ';

   end;


   qrySefer.Active:=False;
   qrySefer.Sql.Clear;
   qrySefer.Sql.Text:=ilk_sql;

   qrySefer.Sql.Add(' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=MAZOT_FISI.ALIS_URUN_HAR_ID) ');
   qrySefer.Sql.Add(' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) ');
   qrySefer.Sql.Add(ilk_sql_w);


   qrySefer.Active:=True;

   if qrySefer.RecordCount>0 then
   begin
     Button2.Enabled:=True;
     Button3.Enabled:=True;
   end;
   
end;

procedure TfrmRaporFatura_Mazot.Button2Click(Sender: TObject);
begin
  {if qrySefer.FieldByName('FAT_IRS_ID').AsInteger>0 then
  frmFAT_IRS.Form_Open(True,
  qrySefer.FieldByName('FAT_IRS_SEP').AsInteger,
  qrySefer.FieldByName('FAT_IRS_ID').AsInteger,
  qrySefer.FieldByName('FAT_IRS_SID').AsInteger,
  1,
  qrySefer.FieldByName('FAT_IRS_TIP').AsInteger);
  }

  if qrySefer.FieldByName('FAT_IRS_ID').AsInteger>0 then
  frmFAT_Tran.Form_Open(True,
  qrySefer.FieldByName('FAT_IRS_SEP').AsInteger,
  qrySefer.FieldByName('FAT_IRS_ID').AsInteger,
  qrySefer.FieldByName('FAT_IRS_SID').AsInteger,
  1,
  qrySefer.FieldByName('FAT_IRS_TIP').AsInteger);

end;

procedure TfrmRaporFatura_Mazot.Button3Click(Sender: TObject);
begin
  if qrySefer.FieldByName('MAZOT_FIS_ID').AsInteger>0 then
  frmMazot.Form_Open(True,qrySefer.FieldByName('MAZOT_FIS_ID').AsInteger,qrySefer.FieldByName('MAZOT_FIS_SID').AsInteger,1);
end;

procedure TfrmRaporFatura_Mazot.TxtMazotcuEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

end.




