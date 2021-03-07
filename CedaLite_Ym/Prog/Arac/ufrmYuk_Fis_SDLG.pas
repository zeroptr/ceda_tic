unit ufrmYuk_Fis_SDLG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, Mask, IB_Controls, ComCtrls, StdCtrls, Grids,
  IB_Grid, Buttons, ExtCtrls;

type
  TfrmYuk_Fis_SDLG = class(TForm)
    Panel2: TPanel;
    btnIPTAL: TBitBtn;
    btnTAMAM: TBitBtn;
    btnRapor: TButton;
    IB_Grid1: TIB_Grid;
    pnlRAPKOD: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    txtISLEMMERKEZI: TEdit;
    txtKOD1: TEdit;
    txtKOD2: TEdit;
    txtKOD3: TEdit;
    txtKOD4: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    chkRAPKOD: TCheckBox;
    Panel1: TPanel;
    btn_Ara: TButton;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    dtpIslemTar: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Tutar1: TIB_Currency;
    Tutar2: TIB_Currency;
    dts_Komisyon: TIB_DataSource;
    qry_Komisyon: TIB_Query;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    IB_Currency1: TIB_Currency;
    IB_Currency2: TIB_Currency;
    GroupBox4: TGroupBox;
    lbl_CARIKOD: TLabel;
    lbl_CARI: TLabel;
    btnCARI: TButton;
    chkCARI: TCheckBox;
    chkUcret: TCheckBox;
    chkKomisyon: TCheckBox;
    Label20: TLabel;
    txtArac: TEdit;
    Button6: TButton;
    LblPlaka: TLabel;
    Label6: TLabel;
    txtSofor_Kod: TEdit;
    Button7: TButton;
    lblSofor_Adi: TLabel;
    txtGon_Fir: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    txtArac_Plaka: TEdit;
    Label12: TLabel;
    txtSofor_Ad_Soy: TEdit;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    IB_Currency3: TIB_Currency;
    IB_Currency4: TIB_Currency;
    chkMusKomisyon: TCheckBox;
    chkAKl: TCheckBox;
    chkSkl: TCheckBox;
    Label14: TLabel;
    txtKom_Id: TIB_Currency;
    procedure btnRaporClick(Sender: TObject);
    procedure btn_AraClick(Sender: TObject);
    procedure btnTAMAMClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);

    function Form_Open(Menu: Boolean; var ID, SID: Integer): Boolean;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCARIClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure txtAracExit(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure txtSofor_KodExit(Sender: TObject);
    procedure txtAracKeyPress(Sender: TObject; var Key: Char);
    procedure txtGon_FirKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    prv_Kontrol:Boolean;
    prv_Cari_KOD:String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmYuk_Fis_SDLG: TfrmYuk_Fis_SDLG;

implementation

uses ufrmRaporCiktisi, unDataMod, UnFunc, ufrmCariSDLG;

{$R *.dfm}

function TfrmYuk_Fis_SDLG.Form_Open(Menu:Boolean;Var ID:Integer;var SID:Integer):Boolean;
begin
  Application.CreateForm(TfrmYuk_Fis_SDLG, frmYuk_Fis_SDLG);
  DataMod.Rapor_Kod_Visible_Fields('KOMISYON'
                                   ,frmYuk_Fis_SDLG.txtISLEMMERKEZI
                                   ,frmYuk_Fis_SDLG.txtKOD1
                                   ,frmYuk_Fis_SDLG.txtKOD2
                                   ,frmYuk_Fis_SDLG.txtKOD3
                                   ,frmYuk_Fis_SDLG.txtKOD4
                                   ,frmYuk_Fis_SDLG.Button1
                                   ,frmYuk_Fis_SDLG.Button2
                                   ,frmYuk_Fis_SDLG.Button3
                                   ,frmYuk_Fis_SDLG.Button4
                                   ,frmYuk_Fis_SDLG.Button5
                                   ,frmYuk_Fis_SDLG.Label3
                                   ,frmYuk_Fis_SDLG.Label4
                                   ,frmYuk_Fis_SDLG.Label7
                                   ,frmYuk_Fis_SDLG.Label8
                                   ,frmYuk_Fis_SDLG.Label9);
  frmYuk_Fis_SDLG.pnlRAPKOD.Visible := (frmYuk_Fis_SDLG.txtISLEMMERKEZI.Visible OR frmYuk_Fis_SDLG.txtKOD1.Visible OR frmYuk_Fis_SDLG.txtKOD2.Visible OR frmYuk_Fis_SDLG.txtKOD3.Visible OR frmYuk_Fis_SDLG.txtKOD4.Visible );

  frmYuk_Fis_SDLG.dtpIslemTar.DateTime := glb_DONEM_BAS;
  frmYuk_Fis_SDLG.dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
  frmYuk_Fis_SDLG.dtpIslemTar2.Checked := False;



  frmYuk_Fis_SDLG.ShowModal;
  if Not frmYuk_Fis_SDLG.prv_Kontrol Then
  begin
    ID := 0;
    SID := 0;
    Result := False;
  end
  else
  begin
    ID := frmYuk_Fis_SDLG.qry_Komisyon.FieldByName('ID').AsInteger;
    SID := frmYuk_Fis_SDLG.qry_Komisyon.FieldByName('SID').AsInteger;
    Result := True;
  end;
  frmYuk_Fis_SDLG.qry_Komisyon.Close;
  frmYuk_Fis_SDLG.Release;
end;



procedure TfrmYuk_Fis_SDLG.btnRaporClick(Sender: TObject);
var
  row,col : integer;
  res_Cari : TStringList;
begin
  if not qry_Komisyon.Active then
  begin
    Application.MessageBox('Arama iþlemi yapmadan rapor alamazsýnýz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  if qry_Komisyon.RecordCount = 0 then
  begin
    Application.MessageBox('Yapmýþ olduðunuz aramada hiçbir kayýda ulaþýlamadý.Lütfen kriterleri kontrol ediniz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  row := 0;
  col := 0;
////////////////////////////////////////////////////////////////////////////////
  with frmRaporCiktisi do
  begin
    form_open();
    grdA.BeginUpdate;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      SetCellText(row,col,res_Cari[1]);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    inc(row);

    SetCellText(row,col,'YÜKLEME FÝÞÝ LÝSTESÝ ');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    inc(row);
    col:=0;
    SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);

////////////////////////////////////////////////////////////////////////////////
    if ((dtpIslemTar.Checked) and (dtpIslemTar2.Checked)) then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + (DateToStr(dtpIslemTar.Date)+' > - < '+DateToStr(dtpIslemTar2.Date)));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end
    else
    if dtpIslemTar.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + DateToStr(dtpIslemTar.Date));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end
    else
    if dtpIslemTar2.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + DateToStr(dtpIslemTar2.Date));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end;

    inc(row);
    col := 0;
    SetCellText(row,col,'Fiþ No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Tarih');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Belge No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);


    inc(col);
    SetCellText(row,col,'Cari Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Cari Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Sevk Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Gönderen Firma');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Gönderen Firma Adres1');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Gönderen Firma Adres2');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Gönderen Firma Telefon1');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Gönderen Firma Telefon2');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Gideceði Yer');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Yük Cinsi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Ölçü Tipi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Ölçü Birimi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Miktar');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Toplam Ücret');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Kdv Dahil');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Komisyon Ücreti');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Müþteri Komisyonu');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);


    inc(col);
    SetCellText(row,col,'Þöför Kodu');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Þöför Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Þöför Adý Soyadý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Þöför Adresi1');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Þöför Adresi2');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Þöför Telefon1');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Þöför Telefon2');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Þöför Ehliyet No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Þöför Vergi Dairesi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Þöför Vergi Daire No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Araç Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Plaka');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Araç Sahibi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Sahibi Adresi1');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Sahibi Adresi2');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Araç Sahibi Telefon1');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Sahibi Telefon2');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Ruhsat No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Plaka');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);


    inc(col);
    SetCellText(row,col,'Araç Marka');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Araç Model');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);





    inc(col);
    SetCellText(row,col,'Dorse Plaka');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Araç Kara Liste');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Söför Kara Liste');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Kasa Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Kasa Açýklama');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);


    inc(col);
    SetCellText(row,col,'Resim Dosyasý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);



    inc(row);
    qry_Komisyon.DisableControls;
    qry_Komisyon.First;
    while not qry_Komisyon.Eof do
    begin


      col := 0;
      DataMod.Rapor_Satir_Renklendir(Col,Row,35);

      SetCellText(row,col,qry_Komisyon.FieldByName('ID').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('TARIH').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('FIS_NO').AsString);

      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('CARI_KOD').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('CARI_ADI').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SEVK_ADRES_KOD').AsString);

      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('GONDEREN_FIRMA').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('GON_FIR_ADRES1').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('GON_FIR_ADRES2').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('GON_FIR_TEL').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('GON_FIR_TEL1').AsString);

      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('GIDECEGI_YER').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('YUK_CINSI').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('YUK_OLCU_TIP').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('YUK_OLCU_BIR').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('YUK_KILO').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('TOPLAM_UCRET').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('KDV_DAHIL').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('KOMISYON_UCRET').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('MUSTERI_KOM').AsString);

      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SOFOR_KOD').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SOFOR_ADI_CO').AsString);

      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SOFOR_ADI_SOY').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SOFOR_ADRESI').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SOFOR_ADRESI1').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SOFOR_TEL').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SOFOR_TEL1').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SOFOR_EHLIYET_NO').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SOFOR_VERGI_DA').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SOFOR_VERGI_DA_NO').AsString);

      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_KOD').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_PLAKA_CO').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_SAHIBI').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI1').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL1').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_RUHSAT_NO').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_PLAKA').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_MARKA').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_MODEL').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('DORSE_PLAKA').AsString);


      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('ARAC_KL').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('SOFOR_KL').AsString);



      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('KASA_KOD').AsString);
      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('KASA_AD').AsString);

      inc(col);
      SetCellText(row,col,qry_Komisyon.FieldByName('RESIM').AsString);

      inc(row);
      qry_Komisyon.Next;
    end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    inc(row);
//    col := 15;
//    SetCellText(row,col-1,'TOPLAM');


    frmRaporCiktisi.format_ayarla_text(0,0,col,row);

    col := 19;
    SetCellText(row,col,'=SUM(T6:T'+IntToStr(row-1)+')');
    SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    frmRaporCiktisi.format_ayarla(col,0,col,row);

    col := 18;
    SetCellText(row,col,'=SUM(S6:S'+IntToStr(row-1)+')');
    SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    frmRaporCiktisi.format_ayarla(col,0,col,row);

    col := 16;

    SetCellText(row,col,'=SUM(Q6:Q'+IntToStr(row-1)+')');
    SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);

    frmRaporCiktisi.format_ayarla(col,0,col,row);



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    SetCellFormat(4,3,4,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
//    format_ayarla(7,3,7,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
    grdA.EndUpdate;
    WindowState := wsMaximized;
  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  qry_Komisyon.First;
  qry_Komisyon.EnableControls;


end;

procedure TfrmYuk_Fis_SDLG.btn_AraClick(Sender: TObject);
var
   strSQL:AnsiString;
begin
strSQL:=

' SELECT ID '+#13+
'     , SID '+#13+
'     , GONDEREN_FIRMA '+#13+
'     , GON_FIR_ADRES1 '+#13+
'     , GON_FIR_ADRES2 '+#13+
'     , GON_FIR_TEL '+#13+
'     , GIDECEGI_YER '+#13+
'     , YUK_CINSI '+#13+
'     , YUK_KILO '+#13+
'     , YUK_OLCU_BIR '+#13+
'     , TOPLAM_UCRET '+#13+
'     , KOMISYON_UCRET '+#13+
'     , SOFOR_ADI_SOY '+#13+
'     , ARAC_PLAKA '+#13+
'     , SOFOR_ADRESI '+#13+
'     , SOFOR_TEL '+#13+
'     , SOFOR_EHLIYET_NO '+#13+
'     , SOFOR_VERGI_DA '+#13+
'     , SOFOR_VERGI_DA_NO '+#13+
'     , ARAC_SAHIBI '+#13+
'     , ARAC_SAHIBI_ADRESI '+#13+
'     , ARAC_SAHIBI_TEL '+#13+
'     , ARAC_RUHSAT_NO '+#13+
'     , ACIKLAMA '+#13+
'     , TARIH '+#13+
'     , KULLANICI '+#13+
'     , FIS_NO '+#13+
'     , KDV_DAHIL '+#13+
'     , YUK_OLCU_TIP '+#13+
'     , CARI_KOD '+#13+
'     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=KOMISYON.CARI_KOD) AS CARI_ADI '+#13+
'     ,SEVK_ADRES_KOD '+#13+
'     , MASRAF_MERK '+#13+
'     , KOD1 '+#13+
'     , KOD2 '+#13+
'     , KOD3 '+#13+
'     , KOD4 '+#13+
'     , GON_FIR_TEL1 '+#13+
'     , SOFOR_TEL1 '+#13+
'     , ARAC_SAHIBI_TEL1 '+#13+
'     , KASA_KOD '+#13+
'     , (SELECT ACIKLAMA FROM KASA WHERE KOMISYON.KASA_KOD = KASA.KASA_KOD) AS KASA_AD '+#13+
'     , ARAC_KOD '+#13+
'     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=KOMISYON.ARAC_KOD) AS ARAC_PLAKA_CO '+#13+
'     , SOFOR_KOD '+#13+
'     ,(SELECT ADI_SOYADI FROM SOFOR WHERE SOFOR.SOFOR_KOD=KOMISYON.SOFOR_KOD) AS SOFOR_ADI_CO '+#13+
'     , ARAC_MARKA '+#13+
'     , ARAC_MODEL '+#13+
'     , SOFOR_ADRESI1 '+#13+
'     , ARAC_SAHIBI_ADRESI1 '+#13+
'     , RESIM '+#13+
'     , DORSE_PLAKA '+#13+
'     , SOFOR_KL '+#13+
'     , ARAC_KL '+#13+
'     , MUSTERI_KOM '+#13+
' FROM KOMISYON '+#13+
' WHERE ID>0 ';




    if chkCari.Checked then
    begin
      strSQL := strSQL + ' AND CARI_KOD='+ SQL_Katar(prv_Cari_KOD);
    end;


    if chkSkl.Checked then
    begin
      strSQL := strSQL + ' AND SOFOR_KL=1';
    end;
    if chkAKl.Checked then
    begin
      strSQL := strSQL + ' AND ARAC_KL=1';
    end;



    if chkRAPKOD.Checked then
    begin
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND KOMISYON.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND KOMISYON.KOD1 = '+ SQL_Katar(txtKOD1.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND KOMISYON.KOD2 = ' +  SQL_Katar(txtKOD2.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND KOMISYON.KOD3 = ' + SQL_Katar(txtKOD3.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND KOMISYON.KOD4 = ' + SQL_Katar(txtKOD4.Text);
      end;
      ////////////////////////////////////////////////////////////////
    end;//end chkRAPKOD.checked


    if ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=False)) then
    begin
      strSQL := strSQL + ' AND KOMISYON.TARIH >= ' + SQL_Tarih(dtpIslemTar.Date);
    end;
    //////////////////////////////////////////////////////////////////
    if ((dtpIslemTar.Checked=False) and (dtpIslemTar2.Checked=True)) then
    begin
      strSQL := strSQL + ' AND KOMISYON.TARIH <= ' + SQL_Tarih(dtpIslemTar2.Date);
    end;
    //////////////////////////////////////////////////////////////////
    if ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=True)) then
    begin
      strSQL := strSQL + ' AND KOMISYON.TARIH BETWEEN ' + SQL_Tarih(dtpIslemTar.Date) + ' AND '+ SQL_Tarih(dtpIslemTar2.Date);
    end;

   if chkUcret.checked then
   begin
    if (Trim(Tutar1.Text) <> '') and (Trim(Tutar2.Text) <> '') then
    begin
      strSQL := strSQL + ' AND KOMISYON.TOPLAM_UCRET >= ' + SQL_Para(Tutar1.Value)+' AND ';
      strSQL := strSQL + ' KOMISYON.TOPLAM_UCRET <= '+ SQL_Para(Tutar2.Value);
    end
    else
    if (Trim(Tutar1.Text) <> '') then
    begin
      strSQL := strSQL + ' AND KOMISYON.TOPLAM_UCRET >= ' + SQL_Para(Tutar1.Value);
    end
    else
    if (Trim(Tutar2.Text) <> '') then
    begin
      strSQL := strSQL + ' AND KOMISYON.TOPLAM_UCRET <= '+ SQL_Para(Tutar2.Value);
    end;
   end;
   if chkKomisyon.checked then
   begin

    if (Trim(IB_Currency1.Text) <> '') and (Trim(IB_Currency2.Text) <> '') then
    begin
      strSQL := strSQL + ' AND KOMISYON.KOMISYON_UCRET >= ' + SQL_Para(IB_Currency1.Value)+' AND ';
      strSQL := strSQL + ' KOMISYON.KOMISYON_UCRET <= '+ SQL_Para(IB_Currency2.Value);
    end
    else
    if (Trim(IB_Currency1.Text) <> '') then
    begin
      strSQL := strSQL + ' AND KOMISYON.KOMISYON_UCRET >= ' + SQL_Para(IB_Currency1.Value);
    end
    else
    if (Trim(IB_Currency2.Text) <> '') then
    begin
      strSQL := strSQL + ' AND KOMISYON.KOMISYON_UCRET <= '+ SQL_Para(IB_Currency2.Value);
    end;
  end;
   if chkMusKomisyon.checked then
   begin

    if (Trim(IB_Currency3.Text) <> '') and (Trim(IB_Currency4.Text) <> '') then
    begin
      strSQL := strSQL + ' AND KOMISYON.MUSTERI_KOM >= ' + SQL_Para(IB_Currency3.Value)+' AND ';
      strSQL := strSQL + ' KOMISYON.MUSTERI_KOM <= '+ SQL_Para(IB_Currency4.Value);
    end
    else
    if (Trim(IB_Currency3.Text) <> '') then
    begin
      strSQL := strSQL + ' AND KOMISYON.MUSTERI_KOM >= ' + SQL_Para(IB_Currency3.Value);
    end
    else
    if (Trim(IB_Currency4.Text) <> '') then
    begin
      strSQL := strSQL + ' AND KOMISYON.MUSTERI_KOM <= '+ SQL_Para(IB_Currency4.Value);
    end;
  end;







  if txtArac.Text<>'' then
  begin
      strSQL := strSQL + ' AND KOMISYON.ARAC_KOD = '+ SQL_Katar(txtArac.Text);
  end;
  if txtSofor_Kod.Text<>'' then
  begin
      strSQL := strSQL + ' AND KOMISYON.SOFOR_KOD = '+ SQL_Katar(txtSofor_Kod.Text);
  end;




  if txtGon_Fir.Text<>'' then
  begin
      strSQL := strSQL + ' AND KOMISYON.GONDEREN_FIRMA LIKE '+ SQL_Katar(txtGon_Fir.Text + '%');
  end;

  if txtArac_Plaka.Text<>'' then
  begin
      strSQL := strSQL + ' AND KOMISYON.ARAC_PLAKA LIKE '+ SQL_Katar(txtArac_Plaka.Text + '%');
  end;


  if txtSofor_Ad_Soy.Text<>'' then
  begin
      strSQL := strSQL + ' AND KOMISYON.SOFOR_ADI_SOY LIKE '+ SQL_Katar(txtSofor_Ad_Soy.Text + '%');
  end;

  if txtKom_Id.Value>0 then
  begin
    strSQL := strSQL + ' AND KOMISYON.ID = ' + Trim(Floattostr(txtKom_Id.Value));
  end;


  try
//****************************************************************************//
    with qry_Komisyon do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
    end;
//****************************************************************************//
    qry_Komisyon.FieldByName('TOPLAM_UCRET').DisplayFormat := glb_VPB_FIELD_PF;
    qry_Komisyon.FieldByName('KOMISYON_UCRET').DisplayFormat := glb_VPB_FIELD_PF;

  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu','Dikkat',MB_ICONSTOP);
    ShowMessage(strSQL);
  end;


end;

procedure TfrmYuk_Fis_SDLG.btnTAMAMClick(Sender: TObject);
begin
  prv_Kontrol := True;
  Close;

end;

procedure TfrmYuk_Fis_SDLG.btnIPTALClick(Sender: TObject);
begin
  prv_Kontrol := False;
  Close;

end;

procedure TfrmYuk_Fis_SDLG.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmYuk_Fis_SDLG);
end;

procedure TfrmYuk_Fis_SDLG.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    btnIPTALClick(Self);
  end;
  if key = #13 then
  begin
    if ActiveControl = IB_Grid1 then
    begin
      btnTAMAMClick(Self);
      exit;
    end;
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmYuk_Fis_SDLG.btnCARIClick(Sender: TObject);
var
  CARI_KOD,CARI_AD : String;
begin
  if frmCariSDLG.Form_Open(False,CARI_KOD,CARI_AD,1) Then
  begin
    chkCARI.Checked := True;
    lbl_CARIKOD.Caption := CARI_KOD;
    lbl_CARI.Caption := CARI_AD;
    prv_Cari_KOD := CARI_KOD;
  end;
end;

procedure TfrmYuk_Fis_SDLG.Button6Click(Sender: TObject);
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
      LblPlaka.Caption:= PLAKA;
      {if OZ_MAL=1 then
      begin
        txtAlanPersonel.Visible:=True;
        IB_Text3.Visible:=True;
        txtAliciKod.Visible:=False;
        IB_Text2.Visible:=False;
        qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := PERSONEL_KOD;
        txtAlanPersonel.Text:= PERSONEL_KOD;
        qryMazot.FieldByName('ALAN_CARI_KOD').AsString := '';
        qryMazot.FieldByName('ALAN_CARI_ADI').AsString := '';
        txtAlanPersonelExit(Self);
      end
      else
      begin
        txtAlanPersonel.Visible:=False;
        IB_Text3.Visible:=False;
        txtAliciKod.Visible:=True;
        IB_Text2.Visible:=True;
        qryMazot.FieldByName('ALAN_CARI_KOD').AsString := CARI_KOD;
        txtAliciKod.Text:= CARI_KOD;
        qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := '';
        qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString := '';
        txtAliciKodExit(Self);
      end;
      }

  end;


end;

procedure TfrmYuk_Fis_SDLG.txtAracExit(Sender: TObject);
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
      if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','OZ_MAL',txtArac.Text,OZ_MAL) then
      begin
        {
         if OZ_MAL='1' then
         begin
            txtAlanPersonel.Visible:=True;
            IB_Text3.Visible:=True;
            txtAliciKod.Visible:=False;
            IB_Text2.Visible:=False;

            DataMod.FN_KOD2AD('ARAC','ARAC_KOD','PERSONEL_KOD',txtArac_Kod.Text,PERSONEL_KOD);
            qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := PERSONEL_KOD;
            txtAlanPersonel.Text:= PERSONEL_KOD;
            qryMazot.FieldByName('ALAN_CARI_KOD').AsString := '';
            qryMazot.FieldByName('ALAN_CARI_ADI').AsString := '';
            txtAlanPersonelExit(Self);

         end
         else
         begin
            txtAlanPersonel.Visible:=False;
            IB_Text3.Visible:=False;
            txtAliciKod.Visible:=True;
            IB_Text2.Visible:=True;
            DataMod.FN_KOD2AD('ARAC','ARAC_KOD','CARI_KOD',txtArac_Kod.Text,SATICI_KOD);
            qryMazot.FieldByName('ALAN_CARI_KOD').AsString := SATICI_KOD;
            txtAliciKod.Text:= SATICI_KOD;
            qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := '';
            qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString := '';
            txtAliciKodExit(Self);
         end;
          }
      end;

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

procedure TfrmYuk_Fis_SDLG.Button7Click(Sender: TObject);
var
  SOFOR_KOD, SOFOR_AD :String;
begin
  if DataMod.LS_Sofor(SOFOR_KOD, SOFOR_AD) then
  begin
      txtSofor_Kod.Text := SOFOR_KOD;
      lblSofor_Adi.Caption := SOFOR_AD;
  end;
end;

procedure TfrmYuk_Fis_SDLG.txtSofor_KodExit(Sender: TObject);
var
  SOFOR_AD:String;
begin
  if Trim(txtSofor_Kod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('SOFOR','SOFOR_KOD','ADI_SOYADI',txtSofor_Kod.Text,SOFOR_AD) then
    begin
      lblSofor_Adi.Caption :=SOFOR_AD;

      if (Sender is TEdit) then
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txtSofor_Kod.SetFocus;
    end;
  end
  else
  begin
      if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow;
    lblSofor_Adi.Caption := '';
  end;

end;

procedure TfrmYuk_Fis_SDLG.txtAracKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);

end;

procedure TfrmYuk_Fis_SDLG.txtGon_FirKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     btn_AraClick(btn_Ara);
end;

end.
