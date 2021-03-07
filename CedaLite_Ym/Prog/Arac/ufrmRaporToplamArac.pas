unit ufrmRaporToplamArac;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, IB_Components, frxClass, frxIBOSet;

type
  TfrmRaporToplamArac = class(TForm)
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    txtArac: TEdit;
    Button6: TButton;
    Label20: TLabel;
    LblPlaka: TLabel;
    Btn_Hesapla: TButton;
    BtnRapor: TButton;
    Qry_Temp: TIB_Query;
    lbl_Toplam_Litre: TLabel;
    lbl_Toplam_Km: TLabel;
    lbl_LtKm_Yuzdesi: TLabel;
    lbl_Toplam_Odenen: TLabel;
    lb_Fark_Yuzdesi: TLabel;
    lbl_Fark: TLabel;
    Button1: TButton;
    Label9: TLabel;
    AracLtKm: TLabel;
    frxIBODts_MazotLitre: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    Button2: TButton;
    cb_Ozmal: TCheckBox;
    cb_LtKm: TCheckBox;
    procedure txtAracExit(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Btn_HesaplaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
  private
  Prv_Yazdirildi:Boolean;
    { Private declarations }
  public

   ilk_Tarih,son_Tarih:TDateTime;
   Arac_Kodu:String;
   Toplam_Lt, Toplam_Km,Yuzde,Toplam_Odenen,Arac_Yuzde:Double;
   Fark_Yuzdesi,Fark:Double;

    { Public declarations }
  end;

var
  frmRaporToplamArac: TfrmRaporToplamArac;

implementation

uses unDataMod,unfunc;

{$R *.dfm}

procedure TfrmRaporToplamArac.txtAracExit(Sender: TObject);
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

procedure TfrmRaporToplamArac.Button6Click(Sender: TObject);
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
      txtArac.Text :=ARAC_KOD ;
      LblPlaka.Caption:=PLAKA ;
  end;
end;

procedure TfrmRaporToplamArac.Btn_HesaplaClick(Sender: TObject);
begin
     ilk_Tarih:=dtpIslemTar1.Date;
     son_Tarih:=dtpIslemTar2.Date;
     Arac_Kodu:=txtArac.Text;
     Fark_Yuzdesi:=0;
     Fark:=0;
     Toplam_Lt:=0;
     Toplam_Km:=0;
     Yuzde:=0;
     Toplam_Odenen:=0;
     Arac_Yuzde:=0;


     Qry_Temp.Active:=False;
     Qry_Temp.Sql.Text:=
     'Select YAKIT_LITRE from ARAC Where ARAC_KOD='+ sql_Katar(Arac_Kodu);
     Qry_Temp.Active:=True;
     Arac_Yuzde:=Qry_Temp.FieldByName('YAKIT_LITRE').AsInteger;

     AracLtKm.Caption:=FloattoStr(Arac_Yuzde);

     Qry_Temp.Active:=False;
     Qry_Temp.Sql.Text:=
     'Select KM from MAZOT_FISI Where ARAC_KOD='+ sql_Katar(Arac_Kodu)+
     ' and (TARIH Between '+Sql_Tarih(ilk_Tarih)+' and ' + Sql_Tarih(son_Tarih) +') Order By MAZOT_FIS_ID ';
     Qry_Temp.Active:=True;
     Qry_Temp.Last;
     Toplam_Km:=Qry_Temp.FieldByName('Km').AsInteger;
     Qry_Temp.First;
     Toplam_Km:=Toplam_Km-Qry_Temp.FieldByName('Km').AsInteger;

     lbl_Toplam_Km.Caption:=Floattostr(Toplam_Km);


     Qry_Temp.Active:=False;
     Qry_Temp.Sql.Text:=
     'Select Sum(LITRE) Litre from MAZOT_FISI Where ARAC_KOD='+ sql_Katar(Arac_Kodu)+
     ' and (TARIH Between '+Sql_Tarih(ilk_Tarih)+' and ' + Sql_Tarih(son_Tarih) +') ';
     Qry_Temp.Active:=True;
     Toplam_Lt:=Qry_Temp.FieldByName('Litre').AsInteger;

     lbl_Toplam_Litre.Caption:=Floattostr(Toplam_Lt);
     if Toplam_Km>0 then
     Yuzde:= (Toplam_Lt/Toplam_Km)*100;

     lbl_LtKm_Yuzdesi.Caption:=FormatFloat('#.#,##',Yuzde);

     Qry_Temp.Active:=False;
     Qry_Temp.Sql.Text:=
     'Select Sum(LITRE*LITRE_FIYAT) Odenen from MAZOT_FISI Where ARAC_KOD='+ sql_Katar(Arac_Kodu)+
     ' and (TARIH Between '+Sql_Tarih(ilk_Tarih)+' and ' + Sql_Tarih(son_Tarih) +') ';
     Qry_Temp.Active:=True;

     Toplam_Odenen:=Qry_Temp.FieldByName('Odenen').AsFloat;

     lbl_Toplam_Odenen.Caption:=FormatFloat('#.#,##',Toplam_Odenen);

lb_Fark_Yuzdesi.Caption:='0';
lbl_Fark.Caption:='0';


     if Yuzde>Arac_Yuzde then
     begin
        Fark_Yuzdesi:=Yuzde-Arac_Yuzde;
        lb_Fark_Yuzdesi.Caption:=FormatFloat('#.#,##',Yuzde-Arac_Yuzde);
        Fark:=Toplam_Odenen*((Yuzde-Arac_Yuzde)/100);
        lbl_Fark.Caption:=FormatFloat('#.#,##',Toplam_Odenen*((Yuzde-Arac_Yuzde)/100));
     end;

end;


procedure TfrmRaporToplamArac.IB_Query1CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
     txtArac.Text:= ARow.ByName('ARAC_KOD').AsString;

     Btn_HesaplaClick(Btn_Hesapla);

    // if ARow.ByName('TOPLAM_LITRE').AsInteger>0 then
    ARow.ByName('TOPLAM_LITRE').AsFloat:=Toplam_Lt;
    ARow.ByName('TOPLAM_KM').AsFloat:=Toplam_Km;
    ARow.ByName('YUZDE').AsFloat:=Yuzde;
    ARow.ByName('FARK').AsFloat:=Fark;
    ARow.ByName('TOPLAM_ODENEN').AsFloat:=Toplam_Odenen;
    ARow.ByName('FARK_YUZDESI').AsFloat:=Fark_Yuzdesi;

end;


procedure TfrmRaporToplamArac.FormShow(Sender: TObject);
begin
      dtpIslemTar1.Date := glb_DONEM_BAS;
      dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
end;

procedure TfrmRaporToplamArac.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporToplamArac.Button1Click(Sender: TObject);
begin
     Close;
end;

procedure TfrmRaporToplamArac.Button2Click(Sender: TObject);
begin
  with IB_Query1 do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(
'   SELECT ARAC_KOD '+
'     , ARAC_SID '+
'     , PLAKA '+
'     , ARAC_TIP '+
'     , OZ_MAL '+
'     , CARI_KOD '+
'     ,(SELECT CARI_AD FROM CARI WHERE ARAC.CARI_KOD=CARI.CARI_KOD) AS CARI_ADI '+
'     , PERSONEL_KOD '+
'     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=ARAC.PERSONEL_KOD) AS PERSONEL_ADI '+
'     , AKTIF_DEGIL '+
'     , YAKIT_LITRE '+
'FROM ARAC ');

   SQL.Add('where ARAC_KOD<>''''');
   if cb_Ozmal.Checked then
   SQL.Add(' and OZ_MAL=1 ');
   if cb_LtKm.Checked then
   SQL.Add(' and YAKIT_LITRE>0 ');

    Active := True;
  end;

       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\MazotLitreKm.fr3');
       frxReport1.showReport;
       Exit;
end;

procedure TfrmRaporToplamArac.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
  //a,b,c:TfrxComponent;
  res_Cari : TStringList;
begin
    if not Prv_Yazdirildi then
    begin

         res_Cari := TStringList.Create;
         if DataMod.FN_Sirket (res_Cari) then
         begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:=res_Cari[1];
         end;
         res_Cari.Free;
       {end;
       else
       begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:='';
       end;
        }


       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);



       {c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);
       }


       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);


       Prv_Yazdirildi:=True;
    end;

end;


end.
