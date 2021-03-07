unit ufrm_Kantar_Sdlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, Buttons, ExtCtrls, Grids, IB_Grid,
  Mask, IB_Controls, ComCtrls, frxClass, frxIBOSet;

type
  Tfrm_Kantar_Sdlg = class(TForm)
    Panel2: TPanel;
    btnIPTAL: TBitBtn;
    btnTAMAM: TBitBtn;
    btnRapor: TButton;
    DtsKantar: TIB_DataSource;
    qry_Kantar: TIB_Query;
    IB_Grid1: TIB_Grid;
    Panel1: TPanel;
    Label2: TLabel;
    lblMamul_Ad: TLabel;
    Label7: TLabel;
    lblCari_Adi: TLabel;
    btn_Ara: TButton;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    dtpGiris_tar: TDateTimePicker;
    dtpGiris_Tar2: TDateTimePicker;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    crArac_Kilo: TIB_Currency;
    crArac_Kilo2: TIB_Currency;
    txtMamul_Kod: TEdit;
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    dtpCikis_Tar: TDateTimePicker;
    dtpCikis_Tar2: TDateTimePicker;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    dtpGiris_Sat: TDateTimePicker;
    dtpGiris_Sat2: TDateTimePicker;
    txtCari_Kod: TEdit;
    Button2: TButton;
    GroupBox5: TGroupBox;
    Label6: TLabel;
    crFark_Kilo: TIB_Currency;
    crFark_Kilo2: TIB_Currency;
    GroupBox6: TGroupBox;
    Label8: TLabel;
    dtpCikis_Sat: TDateTimePicker;
    dptCikis_Sat2: TDateTimePicker;
    txt_Plaka_No: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    cb_Tipi: TComboBox;
    Button3: TButton;
    lbl_Plaka_Aciklama: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    cb_Geldigi_Yer: TComboBox;
    cb_Gitigi_Yer: TComboBox;
    cb_Aciklama: TComboBox;
    GroupBox7: TGroupBox;
    Label14: TLabel;
    cr_Giris_Kilo1: TIB_Currency;
    cr_Giris_Kilo2: TIB_Currency;
    GroupBox8: TGroupBox;
    Label15: TLabel;
    cr_Cikis_Kilo1: TIB_Currency;
    cr_Cikis_Kilo2: TIB_Currency;
    frxIBOKantar_Fis_Lis: TfrxIBODataset;
    frxReport1: TfrxReport;

    function Form_Open(Gc:Boolean; var KANTAR_NO: Integer; RAPOR: Boolean): Boolean;
    procedure btnIPTALClick(Sender: TObject);
    procedure btnTAMAMClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnRaporClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btn_AraClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtMamul_KodExit(Sender: TObject);
    procedure txtCari_KodExit(Sender: TObject);
    procedure txt_Plaka_NoEnter(Sender: TObject);
    procedure txt_Plaka_NoExit(Sender: TObject);
    procedure txtCari_KodEnter(Sender: TObject);
    procedure txtMamul_KodEnter(Sender: TObject);
    procedure txtMamul_KodKeyPress(Sender: TObject; var Key: Char);
    procedure Label10Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    prv_Kontrol:Boolean;
    Prv_Yazdirildi:Boolean;
    prv_Gc:Boolean;
    my_Active_Comp:TWinControl;    
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Kantar_Sdlg: Tfrm_Kantar_Sdlg;

implementation

uses ufrmRaporCiktisi, unDataMod, ufrmUrunSDLG, ufrmCariSDLG,UnFunc;

{$R *.dfm}


function Tfrm_Kantar_Sdlg.Form_Open(Gc:Boolean;var KANTAR_NO:Integer;RAPOR:Boolean):Boolean;
begin                                                   
  Application.CreateForm(Tfrm_Kantar_Sdlg, frm_Kantar_Sdlg);
  with frm_Kantar_Sdlg do
  begin
    prv_Gc:=Gc;

    if prv_Gc=True then cb_Tipi.ItemIndex:=0;
    if prv_Gc=False then cb_Tipi.ItemIndex:=1;

    dtpGiris_Sat.Checked:=False;
    dtpGiris_Sat2.Checked:=False;

    dtpCikis_Sat.Checked:=False;
    dptCikis_Sat2.Checked:=False;

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
      KANTAR_NO := 0;
      Result := False;
    end
    else
    begin
      KANTAR_NO := qry_Kantar.FieldByName('KANTAR_NO').AsInteger;
      Result := True;
    end;
    qry_Kantar.Close;
    Release;
  end;
end;

procedure Tfrm_Kantar_Sdlg.btnIPTALClick(Sender: TObject);
begin
  prv_Kontrol := False;
  Close;
end;

procedure Tfrm_Kantar_Sdlg.btnTAMAMClick(Sender: TObject);
begin
  if not ((qry_Kantar.Eof) and (qry_Kantar.Bof)) Then
  begin
    if qry_Kantar.FieldByName('TIPI').AsString='G' then
    begin
       prv_Kontrol := True;
       Close;
    end;

  end;
end;

procedure Tfrm_Kantar_Sdlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    btnIPTALClick(self);
  end;
  if key = #13 then
  begin
    if ActiveControl = IB_Grid1 then
    begin
      btnTAMAMClick(Self);
      exit;
    end;
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True);
  end;
end;

procedure Tfrm_Kantar_Sdlg.btnRaporClick(Sender: TObject);
var
  row,col : integer;
begin
  if not qry_Kantar.Active then
  begin
    Application.MessageBox('Arama iþlemi yapmadan rapor alamazsýnýz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;

  if qry_Kantar.RecordCount = 0 then
  begin
    Application.MessageBox('Yapmýþ olduðunuz aramada hiçbir kayýda ulaþýlamadý.Lütfen kriterleri kontrol ediniz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  row := 0;
  col := 0;







  Prv_Yazdirildi:=False;
  frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Kantar_Fis_Listesi.fr3');
  frxReport1.showReport;
  Exit;

////////////////////////////////////////////////////////////////////////////////
  with frmRaporCiktisi do
  begin
    form_open();
    grdA.BeginUpdate;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

    SetCellText(row,col,'KANTAR LÝSTESÝ');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    inc(row);
    col:=0;
    SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
{    if chkCARI.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Cari Kod : '+ lbl_CARIKOD.Caption+' - Cari Ad : '+lbl_CARI.Caption);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end;

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
}
    inc(row);
    col := 0;
    SetCellText(row,col,'Plaka No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Makbuz No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Cari Kodu');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Cari Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Ürün Kodu');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Ürün Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Giriþ Tarihi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Giriþ Saati');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Çýkýþ Tarihi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Çýkýþ Saati');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Ücreti');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Geldiði Yer');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Gittiði Yer');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Açýklama');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Kilo');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Giriþ Kilo');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Çýkýþ Kilo');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Net Kilo');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(row);

    qry_Kantar.DisableControls;
    qry_Kantar.First;
    while not qry_Kantar.Eof do
    begin
      col := 0;
      SetCellText(row,col,qry_Kantar.FieldByName('PLAKA_NO').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('MAKBUZ_NO').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('CARI_KOD').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('CARI_AD').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('URUN_KOD').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('GIRIS_TARIHI').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('GIRIS_SAATI').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('CIKIS_TARIHI').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('CIKIS_SAATI').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('UCRETI').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('GELDIGI_YER').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('GITTIGI_YER').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('ACIKLAMA').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('ARAC_KILO').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('GIRIS_KILO').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('CIKIS_KILO').AsString);
      inc(col);
      SetCellText(row,col,qry_Kantar.FieldByName('FARK_KILO').AsString);



      inc(row);
      qry_Kantar.Next;
    end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    inc(row);
    col := 7;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
   // SetCellFormat(4,3,4,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
   // format_ayarla(7,3,7,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
    grdA.EndUpdate;
    WindowState := wsMaximized;
  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  qry_Kantar.First;
  qry_Kantar.EnableControls;



end;

procedure Tfrm_Kantar_Sdlg.Button1Click(Sender: TObject);
var
  Urun_Kod,Urun_Ad:String;
begin
  if frmUrunSDLG.Form_Open(False,Urun_Kod,Urun_AD,True) then
  begin
    txtMamul_Kod.Text:= Urun_Kod;
    lblMamul_Ad.CAption := Urun_Ad;
  end;
end;

procedure Tfrm_Kantar_Sdlg.Button2Click(Sender: TObject);
var
  CARI_KOD,CARI_AD : String;
begin
  if frmCariSDLG.Form_Open(False,CARI_KOD,CARI_AD,1) Then
  begin
    txtCari_Kod.Text := CARI_KOD;
    lblCari_Adi.Caption := CARI_AD;
  end;
end;

procedure Tfrm_Kantar_Sdlg.btn_AraClick(Sender: TObject);


var
  strSQL,SubeID:String;

begin

     strSQL :=
'SELECT KANTAR_SID '+
'     , KANTAR_NO '+
'     , GIRIS_TARIHI '+
'     , GIRIS_SAATI '+
'     , MAKBUZ_NO '+
'     , URUN_KOD '+
'     ,(Select URUN_AD from URUN where URUN.URUN_KOD=KANTAR.URUN_KOD) as URUN_AD '+
'     , CARI_KOD '+
'     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=KANTAR.CARI_KOD) As CARI_AD '+
'     , ACIKLAMA '+
'     , GELDIGI_YER '+
'     , GELDIGI_YER_KOD '+
'     , GITTIGI_YER '+
'     , GITTIGI_YER_KOD '+
'     , CIKIS_TARIHI '+
'     , CIKIS_SAATI '+
'     , ARAC_KILO '+
'     , GIRIS_KILO '+
'     , CIKIS_KILO '+
'     , FARK_KILO '+
'     , UCRETI '+
'     , TIPI '+
'     , PLAKA_NO '+
'FROM KANTAR '+
'WHERE  PLAKA_NO<>''''  ';


//    strSQL := strSQL + ' KANTAR_SID=' + Inttostr(glb_SID);


{
    if prv_Gc=True then
    strSQL := strSQL + ' and TIP=''G''';

    if prv_Gc=False then
    strSQL := strSQL + ' and TIP=''C''';

}


    if  cb_Tipi.ItemIndex=0 then strSQL := strSQL + ' and  TIPI=''G''';
    if  cb_Tipi.ItemIndex=1 then strSQL := strSQL + ' and  TIPI=''C''';

    if  ((dtpGiris_tar.Checked=True) and (dtpGiris_Tar2.Checked=False)) Then
    begin

      strSQL := strSQL + ' And GIRIS_TARIHI=' + SQL_Tarih(dtpGiris_tar.Date);

    end;

    if ((dtpGiris_tar.Checked=False) and (dtpGiris_Tar2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND GIRIS_TARIHI<=' + SQL_Tarih(dtpGiris_Tar2.Date);
    end;

    if ((dtpGiris_tar.Checked=True) and (dtpGiris_Tar2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND GIRIS_TARIHI BETWEEN ' + SQL_Tarih(dtpGiris_tar.Date) + ' AND ' + SQL_Tarih(dtpGiris_Tar2.Date);
    end;





    if  ((dtpCikis_Tar.Checked=True) and (dtpCikis_Tar2.Checked=False)) Then
    begin
      strSQL := strSQL + ' And CIKIS_TARIHI=' + SQL_Tarih(dtpCikis_Tar.Date);
    end;

    if ((dtpCikis_Tar.Checked=False) and (dtpCikis_Tar2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND CIKIS_TARIHI<=' + SQL_Tarih(dtpCikis_Tar2.Date);
    end;

    if ((dtpCikis_Tar.Checked=True) and (dtpCikis_Tar2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND CIKIS_TARIHI BETWEEN ' + SQL_Tarih(dtpCikis_Tar.Date) + ' AND ' + SQL_Tarih(dtpCikis_Tar2.Date);
    end;












    if  ((dtpGiris_Sat.Checked=True) and (dtpGiris_Sat2.Checked=False)) Then
    begin
      strSQL := strSQL + ' And GIRIS_SAATI=' + SQL_Saat(dtpGiris_Sat.Date);
    end;

    if ((dtpGiris_Sat.Checked=False) and (dtpGiris_Sat2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND GIRIS_SAATI<=' + SQL_Saat(dtpGiris_Sat2.Date);
    end;

    if ((dtpGiris_Sat.Checked=True) and (dtpGiris_Sat2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND GIRIS_SAATI BETWEEN ' + SQL_Saat(dtpGiris_Sat.Date) + ' AND ' + SQL_Saat(dtpGiris_Sat2.Date);
    end;





    if  ((dtpCikis_Sat.Checked=True) and (dptCikis_Sat2.Checked=False)) Then
    begin
      strSQL := strSQL + ' And CIKIS_SAATI=' + SQL_Saat(dtpCikis_Sat.Date);
    end;

    if ((dtpCikis_Sat.Checked=False) and (dptCikis_Sat2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND CIKIS_SAATI<=' + SQL_Saat(dptCikis_Sat2.Date);
    end;

    if ((dtpCikis_Sat.Checked=True) and (dptCikis_Sat2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND CIKIS_SAATI BETWEEN ' + SQL_Saat(dtpCikis_Sat.Date) + ' AND ' + SQL_Saat(dptCikis_Sat2.Date);
    end;




  
    if Length(Trim(txt_Plaka_No.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND PLAKA_NO LIKE ' + SQL_Katar(txt_Plaka_No.Text+  '%');
    end;


    if Length(Trim(txtCari_Kod.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND CARI_KOD = ' + SQL_Katar(txtCari_Kod.Text);
    end;


    if Length(Trim(txtMamul_Kod.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND URUN_KOD = ' + SQL_Katar(txtMamul_Kod.Text);
    end;

    
    if Length(Trim(cb_Geldigi_Yer.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND GELDIGI_YER = ' + SQL_Katar(cb_Geldigi_Yer.Text);
    end;

    if Length(Trim(cb_Gitigi_Yer.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND GITIGI_YER = ' + SQL_Katar(cb_Gitigi_Yer.Text);
    end;

    if Length(Trim(cb_Aciklama.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND ACIKLAMA = ' + SQL_Katar(cb_Aciklama.Text);
    end;



    if ((crFark_Kilo.Value<>0) and (crFark_Kilo2.Value = 0)) then
    begin
      strSQL := strSQL + ' AND ARAC_KILO>= '+ SQL_Para(crFark_Kilo.Value);
    end;

    if ((crFark_Kilo.Value=0) and (crFark_Kilo2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND ARAC_KILO<= '+ SQL_Para(crFark_Kilo2.Value);
    end;

    if ((crFark_Kilo.Value<>0) and (crFark_Kilo2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND ARAC_KILO BETWEEN ' + SQL_Para(crFark_Kilo.Value) + ' AND ' + SQL_Para(crFark_Kilo2.Value);
    end;





    if ((crArac_Kilo.Value<>0) and (crArac_Kilo2.Value = 0)) then
    begin
      strSQL := strSQL + ' AND FARK_KILO>= '+ SQL_Para(crArac_Kilo.Value);
    end;

    if ((crArac_Kilo.Value=0) and (crArac_Kilo2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND FARK_KILO<= '+ SQL_Para(crArac_Kilo2.Value);
    end;

    if ((crArac_Kilo.Value<>0) and (crArac_Kilo2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND FARK_KILO BETWEEN ' + SQL_Para(crArac_Kilo.Value) + ' AND ' + SQL_Para(crArac_Kilo2.Value);
    end;



    if ((cr_Giris_Kilo1.Value<>0) and (cr_Giris_Kilo2.Value = 0)) then
    begin
      strSQL := strSQL + ' AND GIRIS_KILO>= '+ SQL_Para(cr_Giris_Kilo1.Value);
    end;

    if ((cr_Giris_Kilo1.Value=0) and (cr_Giris_Kilo2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND GIRIS_KILO<= '+ SQL_Para(cr_Giris_Kilo2.Value);
    end;

    if ((cr_Giris_Kilo1.Value<>0) and (cr_Giris_Kilo2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND GIRIS_KILO BETWEEN ' + SQL_Para(cr_Giris_Kilo1.Value) + ' AND ' + SQL_Para(cr_Giris_Kilo2.Value);
    end;



    if ((cr_Cikis_Kilo1.Value<>0) and (cr_Cikis_Kilo2.Value = 0)) then
    begin
      strSQL := strSQL + ' AND CIKIS_KILO>= '+ SQL_Para(cr_Cikis_Kilo1.Value);
    end;

    if ((cr_Cikis_Kilo1.Value=0) and (cr_Cikis_Kilo2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND CIKIS_KILO<= '+ SQL_Para(cr_Cikis_Kilo2.Value);
    end;

    if ((cr_Cikis_Kilo1.Value<>0) and (cr_Cikis_Kilo2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND CIKIS_KILO BETWEEN ' + SQL_Para(cr_Cikis_Kilo1.Value) + ' AND ' + SQL_Para(cr_Cikis_Kilo2.Value);
    end;







  try
    with qry_Kantar do
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

procedure Tfrm_Kantar_Sdlg.FormActivate(Sender: TObject);
begin
    dtpGiris_Sat.Checked:=False;
    dtpGiris_Sat2.Checked:=False;

    dtpCikis_Sat.Checked:=False;
    dptCikis_Sat2.Checked:=False;

end;

procedure Tfrm_Kantar_Sdlg.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frm_Kantar_Sdlg);
end;

procedure Tfrm_Kantar_Sdlg.txtMamul_KodExit(Sender: TObject);
var
  Kissas,Urun_Ad:String;
begin
  if Length(Trim(txtMamul_Kod.Text))=0 then
  begin
    txtMamul_Kod.Color := clWindow;
    lblMamul_Ad.Caption := '';
    exit;
  end;



  if not DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',txtMamul_Kod.Text,Urun_Ad) then
  begin
    Application.MessageBox('Ürün Kodu Bulunamadý.Lütfen listeden seçiniz','Dikkat',MB_ICONWARNING);
    txtMamul_Kod.Text := '';
    txtMamul_Kod.Clear;
    lblMamul_Ad.Caption:='';
    txtMamul_Kod.SetFocus;
  end
  else
  begin
    lblMamul_Ad.Caption:=Urun_Ad ;
    txtMamul_Kod.Color := clWindow;
    exit;
  end;
end;

procedure Tfrm_Kantar_Sdlg.txtCari_KodExit(Sender: TObject);
var
  Kissas,Urun_Ad:String;
begin
  if Length(Trim(txtCari_Kod.Text))=0 then
  begin
    txtCari_Kod.Color := clWindow;
    lblCari_Adi.Caption := '';
    exit;
  end;



  if not DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCari_Kod.Text,Urun_Ad) then
  begin
    Application.MessageBox('Cari Kodu Bulunamadý.Lütfen listeden seçiniz','Dikkat',MB_ICONWARNING);
    txtCari_Kod.Text := '';
    txtCari_Kod.Clear;
    lblCari_Adi.Caption:='';
    txtCari_Kod.SetFocus;
  end
  else
  begin
    lblCari_Adi.Caption:=Urun_Ad ;
    txtCari_Kod.Color := clWindow;
    exit;
  end;
end;

procedure Tfrm_Kantar_Sdlg.txt_Plaka_NoEnter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;

end;

procedure Tfrm_Kantar_Sdlg.txt_Plaka_NoExit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure Tfrm_Kantar_Sdlg.txtCari_KodEnter(Sender: TObject);
begin
  txtCari_Kod.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar_Sdlg.txtMamul_KodEnter(Sender: TObject);
begin
  txtMamul_Kod.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar_Sdlg.txtMamul_KodKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure Tfrm_Kantar_Sdlg.Label10Click(Sender: TObject);
begin
     cb_Tipi.ItemIndex:=-1;
end;

procedure Tfrm_Kantar_Sdlg.Button3Click(Sender: TObject);
var
  PLAKA_NO,ACIKLAMA,CARI_KOD,CARI_AD:String;
begin

  if datamod.LS_Plaka(PLAKA_NO,ACIKLAMA,CARI_KOD,CARI_AD) then
  begin
     txt_Plaka_No.Text:=PLAKA_NO;
     lbl_Plaka_Aciklama.Caption:=ACIKLAMA;
     txtCari_Kod.Text := CARI_KOD;
     lblCari_Adi.Caption := CARI_AD;
  end;

end;

procedure Tfrm_Kantar_Sdlg.frxReport1BeforePrint(
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
       end;}

       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);
//       c:=(frxReport1.FindComponent('Memo1') as TfrxMemoView);
//       c.memo.Text:=txtMasrafKod.Text;

       {c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);}

{
       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);

}
       Prv_Yazdirildi:=True;
    end;



end;

end.
