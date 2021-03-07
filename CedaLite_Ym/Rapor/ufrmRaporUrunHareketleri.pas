unit ufrmRaporUrunHareketleri;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, IB_Components,cxSSTypes,cxSSHeaders,
  frxClass, frxIBOSet;

type
  TfrmRaporUrunHareketleri = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chkSirket: TCheckBox;
    Panel1: TPanel;
    btnRapor: TButton;
    btnCikis: TButton;
    GroupBox1: TGroupBox;
    txtUrunKod1: TEdit;
    txtUrunKod2: TEdit;
    btnUrunKod1: TButton;
    btnUrunKod2: TButton;
    GroupBox2: TGroupBox;
    dtpTarih1: TDateTimePicker;
    dtpTarih2: TDateTimePicker;
    qryRapor: TIB_Cursor;
    qryDekontD: TIB_Cursor;
    cmbFaturaTip: TComboBox;
    Label1: TLabel;
    GroupBox3: TGroupBox;
    BtnDep1: TButton;
    BtnDep2: TButton;
    qryFAT_IRS_MUH_CARI: TIB_Query;
    GroupBox4: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    txtCariKod1: TEdit;
    txtCariKod2: TEdit;
    txtDepo_Kod1: TEdit;
    txtDepo_Kod2: TEdit;
    frxIBODts_UrunHarList: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open;
    procedure TekUrunYaz(Sender: TObject);

////////////////////////////////////////////////////////////////////////////////
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtUrunKod1Exit(Sender: TObject);
    procedure txtUrunKod1Enter(Sender: TObject);
    procedure chkSirketEnter(Sender: TObject);
    procedure chkSirketExit(Sender: TObject);
    procedure txtUrunKod1KeyPress(Sender: TObject; var Key: Char);
    procedure txtUrunKod1KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtUrunKod2KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure dtpTarih1Enter(Sender: TObject);
    procedure dtpTarih1Exit(Sender: TObject);
    procedure cmbFaturaTipEnter(Sender: TObject);
    procedure cmbFaturaTipExit(Sender: TObject);
    procedure btnUrunKod1Click(Sender: TObject);
    procedure btnUrunKod2Click(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure BtnDep1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BtnDep2Click(Sender: TObject);
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    { Private declarations }
    row,col:Integer;
    prv_satis,prv_alis : integer;
    res_Cari:TStringList;
    Prv_Yazdirildi:Boolean;

  public
    { Public declarations }
  end;
  const cns_urun_fatura = 7;

var
  frmRaporUrunHareketleri: TfrmRaporUrunHareketleri;

implementation

uses main,unDataMod,ufrmRaporCiktisi,unFunc,ufrmUrunSDLG, ufrmCariSDLG;

{$R *.dfm}

{ TfrmRaporUrunFatura }

procedure TfrmRaporUrunHareketleri.Form_Open;
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_urun_fatura,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporUrunHareketleri') then
    begin
      Application.CreateForm(TfrmRaporUrunHareketleri,frmRaporUrunHareketleri);

    end;
  end;
end;

procedure TfrmRaporUrunHareketleri.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporUrunHareketleri);
  res_Cari:=TStringList.Create;
end;

procedure TfrmRaporUrunHareketleri.FormShow(Sender: TObject);
begin
  dtpTarih1.Date := glb_DONEM_BAS;
  dtpTarih2.Date := DataMod.GET_SERVER_DATE;
end;

procedure TfrmRaporUrunHareketleri.btnCikisClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporUrunHareketleri.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporUrunHareketleri.txtUrunKod1Exit(Sender: TObject);
var
  UrunAd : String;
begin
  if Length(Trim((Sender as TEdit).Text))=0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if not (DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',(Sender as TEdit).Text,UrunAd)) then
  begin
    (Sender as TEdit).SetFocus;
    Application.MessageBox('Ürün Kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
  end;
end;

procedure TfrmRaporUrunHareketleri.txtUrunKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporUrunHareketleri.chkSirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporUrunHareketleri.chkSirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporUrunHareketleri.txtUrunKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporUrunHareketleri.txtUrunKod1KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then
  begin
    btnUrunKod1Click(Self);
  end;
end;

procedure TfrmRaporUrunHareketleri.txtUrunKod2KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then
  begin
    btnUrunKod2Click(Self);
  end;
end;

procedure TfrmRaporUrunHareketleri.dtpTarih1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporUrunHareketleri.dtpTarih1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporUrunHareketleri.cmbFaturaTipEnter(Sender: TObject);
begin
  ( Sender as TComboBox ).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporUrunHareketleri.cmbFaturaTipExit(Sender: TObject);
begin
  ( Sender as TComboBox ).Color := clWindow;
end;

procedure TfrmRaporUrunHareketleri.btnUrunKod1Click(Sender: TObject);
var
  UrunKod,UrunAd:String;
begin
  if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) Then  txtUrunKod1.Text := UrunKod;
end;

procedure TfrmRaporUrunHareketleri.btnUrunKod2Click(Sender: TObject);
var
  UrunKod,UrunAd:String;
begin
  if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) Then  txtUrunKod2.Text := UrunKod;
end;

procedure TfrmRaporUrunHareketleri.btnRaporClick(Sender: TObject);
var
  strSQL:String;
  CHeader : TcxSSHeader;
begin
    TekUrunYaz(Sender);
//****************************************************************************//
end;

procedure TfrmRaporUrunHareketleri.TekUrunYaz(Sender: TObject);
var
  strSQL:String;
  CHeader : TcxSSHeader;
  Eski_Kod:String;
  qryTemp:TIB_Query;
  Cari_Ad,Cari_Kod:String;
begin
  if dtpTarih1.DateTime > dtpTarih2.DateTime then
  begin
    dtpTarih1.SetFocus;
    Application.MessageBox('Birinci iþlem tarihi ikinci tarihten büyük olamaz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;

  {if Trim(txtUrunKod1.Text)='' then
  begin
    txtUrunKod1.SetFocus;
    Application.MessageBox('Lütfen bir ürün kodu seçiniz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end; }



  strSQL := 'SELECT'
           +' URUNHAR.*,'
           +' (SELECT URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD = URUNHAR.URUN_KOD) AS URUN_AD'
           +' FROM URUNHAR WHERE URUNHAR_ID<>0 ';

  if (Trim(txtUrunKod1.Text) <> '') and (Trim(txtUrunKod2.Text)<> '') then
  begin
    strSQL := strSQL + ' AND URUNHAR.URUN_KOD BETWEEN '+SQL_Katar(txtUrunKod1.Text)+' AND '+SQL_Katar(txtUrunKod2.Text);
  end
  else
  if (Trim(txtUrunKod1.Text) <> '') then
  begin
    strSQL := strSQL + ' AND URUNHAR.URUN_KOD = '+SQL_Katar(txtUrunKod1.Text);
  end;


  if (Trim(txtDepo_Kod1.Text) <> '') and (Trim(txtDepo_Kod2.Text)<> '') then
  begin
    strSQL := strSQL + ' AND URUNHAR.DEPO_KOD BETWEEN '+SQL_Katar(txtDepo_Kod1.Text)+' AND '+SQL_Katar(txtDepo_Kod2.Text);
  end
  else
  if (Trim(txtDepo_Kod1.Text) <> '') then
  begin
    strSQL := strSQL + ' AND URUNHAR.DEPO_KOD = '+SQL_Katar(txtDepo_Kod1.Text);
  end;

  strSQL := strSQL + ' AND URUNHAR.TARIH BETWEEN '+SQL_Tarih(dtpTarih1.Date)+' AND '+SQL_Tarih(dtpTarih2.Date);




if cmbFaturaTip.ItemIndex=0 then
  strSQL := strSQL + ' AND (URUNHAR.TIP=''B'') AND not (URUNHAR.BELGE_TUR=39 or URUNHAR.BELGE_TUR=40)';
if cmbFaturaTip.ItemIndex=1 then
  strSQL := strSQL + ' AND (URUNHAR.TIP=''A'')  AND not (URUNHAR.BELGE_TUR=39 or URUNHAR.BELGE_TUR=40)';

if cmbFaturaTip.ItemIndex=2 then
  strSQL := strSQL + ' AND (URUNHAR.BELGE_TUR=39 or URUNHAR.BELGE_TUR=40) ';

{  strSQL := strSQL + ' AND (URUNHAR.BELGE_TUR=1 or URUNHAR.BELGE_TUR=20) ';
  strSQL := strSQL + ' AND (URUNHAR.BELGE_TUR=37 or URUNHAR.BELGE_TUR=38) ';
  strSQL := strSQL + ' AND (URUNHAR.BELGE_TUR=39 or URUNHAR.BELGE_TUR=40) ';
}

  strSQL := strSQL + ' ORDER BY URUNHAR.URUN_KOD,URUNHAR.TARIH,URUNHAR.URUNHAR_ID';


 if Sender=Btn_Fast then
 begin

  strSQL := 'select * from urunhar_view'
           +' WHERE URUNHAR_ID<>0 ';

  if (Trim(txtUrunKod1.Text) <> '') and (Trim(txtUrunKod2.Text)<> '') then
  begin
    strSQL := strSQL + ' AND URUN_KOD BETWEEN '+SQL_Katar(txtUrunKod1.Text)+' AND '+SQL_Katar(txtUrunKod2.Text);
  end
  else
  if (Trim(txtUrunKod1.Text) <> '') then
  begin
    strSQL := strSQL + ' AND URUN_KOD = '+SQL_Katar(txtUrunKod1.Text);
  end;


  if (Trim(txtDepo_Kod1.Text) <> '') and (Trim(txtDepo_Kod2.Text)<> '') then
  begin
    strSQL := strSQL + ' AND DEPO_KOD BETWEEN '+SQL_Katar(txtDepo_Kod1.Text)+' AND '+SQL_Katar(txtDepo_Kod2.Text);
  end
  else
  if (Trim(txtDepo_Kod1.Text) <> '') then
  begin
    strSQL := strSQL + ' AND DEPO_KOD = '+SQL_Katar(txtDepo_Kod1.Text);
  end;

  strSQL := strSQL + ' AND TARIH BETWEEN '+SQL_Tarih(dtpTarih1.Date)+' AND '+SQL_Tarih(dtpTarih2.Date);




  if cmbFaturaTip.ItemIndex=0 then
  strSQL := strSQL + ' AND (TIP=''B'') AND not (BELGE_TUR=39 or BELGE_TUR=40)';
  if cmbFaturaTip.ItemIndex=1 then
  strSQL := strSQL + ' AND (TIP=''A'')  AND not (BELGE_TUR=39 or BELGE_TUR=40)';

  if cmbFaturaTip.ItemIndex=2 then
  strSQL := strSQL + ' AND (BELGE_TUR=39 or BELGE_TUR=40) ';

  {  strSQL := strSQL + ' AND (URUNHAR.BELGE_TUR=1 or URUNHAR.BELGE_TUR=20) ';
  strSQL := strSQL + ' AND (URUNHAR.BELGE_TUR=37 or URUNHAR.BELGE_TUR=38) ';
  strSQL := strSQL + ' AND (URUNHAR.BELGE_TUR=39 or URUNHAR.BELGE_TUR=40) ';
  }

  strSQL := strSQL + ' ORDER BY URUN_KOD,TARIH,URUNHAR_ID';

  with IB_Query1 do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((IB_Query1.Eof) and (IB_Query1.bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý. Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    IB_Query1.Close;
    Exit;
  end;

  Prv_Yazdirildi:=False;
  frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Urun_Har_Listesi.fr3');

  frxReport1.showReport;
  Exit;
 end;



  with qryRapor do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;
//****************************************************************************//
  frmRaporCiktisi.form_open();
  frmRaporCiktisi.grdA.BeginUpdate;
  row := 0;
  col := 0;
  Eski_Kod:='';

  if chkSirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket(res_Cari) then
    begin
     frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
     frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    //res_Cari.Free;
    row := 1;
  end;

      frmRaporCiktisi.SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(dtpTarih1.DateTime)+' - '+ DateToStr(dtpTarih2.DateTime) );
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);

  While not qryRapor.Eof Do
  begin

       if Eski_Kod<>qryRapor.FieldByName('URUN_KOD').AsString then
       begin
            col := 0;
            Inc(Row);
            Inc(Row);
            frmRaporCiktisi.SetCellText(row,col,'Ürün Kodu');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Ürün Adý');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
            inc(col);

            col := 0;

            Inc(Row);
            frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('URUN_KOD').AsString);
            inc(col);
            frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('URUN_AD').AsString);
            Eski_Kod:=qryRapor.FieldByName('URUN_KOD').AsString;


            row := Row+1;
            col := 0;
            frmRaporCiktisi.SetCellText(row,col,'Tarih');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Belge Türü');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Cari Kod');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Cari Ad');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Tip');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Miktar');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Ölçü Birimi');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Birim Fiyatý ');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Birim Fiyatý VBP');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Döviz Kodu ');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Tutar ');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
            inc(col);
            frmRaporCiktisi.SetCellText(row,col,'Tutar VPB');
            frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       end;



       {FATURA_ID
       FATURA_SID
       IRSALIYE_ID
       IRSALIYE_SID}
       Cari_Ad:='';
       Cari_Kod:='';
       if (qryRapor.FieldByName('FATURA_ID').AsInteger>0) or (qryRapor.FieldByName('IRSALIYE_ID').AsInteger>0) then
       begin
            DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaMain);
            qryTemp.Active:=False;
            qryTemp.Sql.Text:='Select Cari_Kod from FAT_IRS WHERE FAT_IRS_SEP=:PRM_FAT_IRS_SEP AND FAT_IRS_ID=:PRM_FAT_IRS_ID AND FAT_IRS_SID=:PRM_FAT_IRS_SID ';

            if qryRapor.FieldByName('FATURA_ID').AsInteger>0 then
            qryTemp.ParamByName('PRM_FAT_IRS_SEP').AsInteger:=1;
            if qryRapor.FieldByName('IRSALIYE_ID').AsInteger>0 then
            qryTemp.ParamByName('PRM_FAT_IRS_SEP').AsInteger:=2;

            if qryTemp.ParamByName('PRM_FAT_IRS_SEP').AsInteger = 1 then
            begin
               qryTemp.ParamByName('PRM_FAT_IRS_ID').AsInteger:=
               qryRapor.FieldByName('FATURA_ID').AsInteger;

               qryTemp.ParamByName('PRM_FAT_IRS_SID').AsInteger:=
               qryRapor.FieldByName('FATURA_SID').AsInteger;
            end;


            if qryTemp.ParamByName('PRM_FAT_IRS_SEP').AsInteger = 2 then
            begin
               qryTemp.ParamByName('PRM_FAT_IRS_ID').AsInteger:=
               qryRapor.FieldByName('IRSALIYE_ID').AsInteger;
               qryTemp.ParamByName('PRM_FAT_IRS_SID').AsInteger:=
               qryRapor.FieldByName('IRSALIYE_SID').AsInteger;
            end;

            qryTemp.Active:=True;
            Cari_Ad:='';

            if Length(Trim(txtCariKod1.Text))>0 then
            if qryTemp.FieldByName('Cari_Kod').AsString>=txtCariKod1.Text then
            else
            begin
                 qryRapor.Next;
                 Continue;
            end;

            if Length(Trim(txtCariKod2.Text))>0 then
            if qryTemp.FieldByName('Cari_Kod').AsString<=txtCariKod2.Text then
            else
            begin
                 qryRapor.Next;
                 Continue;
            end;

           if DataMod.FN_CariKOD2Bilgi(qryTemp.FieldByName('Cari_Kod').AsString,res_Cari) then
           begin

           Cari_Kod:=qryTemp.FieldByName('Cari_Kod').AsString;

           if res_Cari[15]='0' Then
           Cari_Ad:=res_Cari[1];

                 if res_Cari[15]='1' Then
                 begin
                      with qryFAT_IRS_MUH_CARI do
                      begin
                        Active := False;
                        if qryRapor.FieldByName('FATURA_ID').AsInteger>0 then
                        ParamByName('PRM_FAT_IRS_SEP').AsInteger := 1;
                        if qryRapor.FieldByName('IRSALIYE_ID').AsInteger>0 then
                        ParamByName('PRM_FAT_IRS_SEP').AsInteger := 2;

                        if ParamByName('PRM_FAT_IRS_SEP').AsInteger = 1 then
                        begin
                          ParamByName('PRM_FAT_IRS_ID').AsInteger := qryRapor.FieldByName('FATURA_ID').AsInteger;
                          ParamByName('PRM_FAT_IRS_SID').AsInteger := qryRapor.FieldByName('FATURA_SID').AsInteger;
                        end;

                        if ParamByName('PRM_FAT_IRS_SEP').AsInteger = 2 then
                        begin
                          ParamByName('PRM_FAT_IRS_ID').AsInteger := qryRapor.FieldByName('IRSALIYE_ID').AsInteger;
                          ParamByName('PRM_FAT_IRS_SID').AsInteger := qryRapor.FieldByName('IRSALIYE_SID').AsInteger;
                        end;

                        Active := True;
                        Cari_Ad:=FieldByName('CARI_AD').AsString;
                      end;
                 end;
           end;
       end;

       col := 0;
       Inc(Row);

       DataMod.Rapor_Satir_Renklendir(col,row,11);

       frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TARIH').AsString);
       inc(col);
       frmRaporCiktisi.SetCellText(row,col,DataMod.GetBelgeKod(qryRapor.FieldByName('BELGE_TUR').AsInteger));
       inc(col);

       frmRaporCiktisi.SetCellText(row,col,Cari_Kod);
       inc(col);
       frmRaporCiktisi.SetCellText(row,col,Cari_Ad);

       inc(col);
       frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TIP').AsString);
       inc(col);
       frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('MIKTAR').AsString);
       frmRaporCiktisi.format_ayarla(col,row,col,row);
       inc(col);
       frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('OLCUBIRIM').AsString);
       inc(col);
       frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BIRIM_FIY').AsString);
       frmRaporCiktisi.format_ayarla(col,row,col,row);
       inc(col);
       frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BIRIM_FIY_VPB').AsString);
       frmRaporCiktisi.format_ayarla(col,row,col,row);
       inc(col);
       frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKOD').AsString);
       //frmRaporCiktisi.SetCellFormat(col,row,col,row,5);
       inc(col);
       frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR').AsString);
       frmRaporCiktisi.format_ayarla(col,row,col,row);
       inc(col);
       frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_VPB').AsString);
       frmRaporCiktisi.format_ayarla(col,row,col,row);
       qryRapor.Next;

  end;

  CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
  frmRaporCiktisi.grdA.EndUpdate;
  frmRaporCiktisi.WindowState := wsMaximized;
  qryRapor.Close;
//****************************************************************************//
end;


procedure TfrmRaporUrunHareketleri.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    close;
  end;
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmRaporUrunHareketleri.Button1Click(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) then txtCariKod1.Text := CARI_KOD;
end;

procedure TfrmRaporUrunHareketleri.BtnDep1Click(Sender: TObject);
var
  DEPO_KOD,DEPO_AD:String;
begin
  if DataMod.LS_Depo(DEPO_KOD,DEPO_AD) then txtDepo_Kod1.Text := DEPO_KOD;
end;

procedure TfrmRaporUrunHareketleri.Button4Click(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) then txtCariKod2.Text := CARI_KOD;
end;

procedure TfrmRaporUrunHareketleri.BtnDep2Click(Sender: TObject);
var
  DEPO_KOD,DEPO_AD:String;
begin
  if DataMod.LS_Depo(DEPO_KOD,DEPO_AD) then txtDepo_Kod2.Text := DEPO_KOD;
end;

procedure TfrmRaporUrunHareketleri.IB_Query1CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
     if ARow.ByName('belge_tur').AsInteger>0 then
    ARow.ByName('CALC_BELGE_TUR').AsString :=
    DataMod.GetBelgeKod(ARow.ByName('belge_tur').AsInteger)
    else
    ARow.ByName('CALC_BELGE_TUR').AsString :='DEVÝR';
end;

procedure TfrmRaporUrunHareketleri.frxReport1BeforePrint(
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
       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpTarih1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpTarih2.Date);
       Prv_Yazdirildi:=True;
    end;
end;

end.


{SELECT
URUNHAR.*,
(SELECT URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD = URUNHAR.URUN_KOD) AS URUN_AD

,(case when (FATURA_ID>0)
then
(Select Cari_Kod from FAT_IRS WHERE FAT_IRS.FAT_IRS_SEP=1 AND FAT_IRS.FAT_IRS_ID=URUNHAR.FATURA_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.FATURA_SID)
end) as Cari_Kod

,(case when (FATURA_ID>0)
then
(Select Cari_Ad from CARI WHERE CARI.CARI_KOD=(Select Cari_Kod from FAT_IRS WHERE FAT_IRS.FAT_IRS_SEP=1 AND FAT_IRS.FAT_IRS_ID=URUNHAR.FATURA_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.FATURA_SID))
end) as Cari_Ad

FROM URUNHAR WHERE URUNHAR_ID<>0 and FATURA_ID>0

union

SELECT
URUNHAR.*,
(SELECT URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD = URUNHAR.URUN_KOD) AS URUN_AD

,(case when (IRSALIYE_ID>0)
then
(Select Cari_Kod from FAT_IRS WHERE FAT_IRS.FAT_IRS_SEP=2 AND FAT_IRS.FAT_IRS_ID=URUNHAR.IRSALIYE_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.IRSALIYE_SID)
end) as Cari_Kod

,(case when (IRSALIYE_ID>0)
then
(Select Cari_Ad from CARI WHERE CARI.CARI_KOD=(Select Cari_Kod from FAT_IRS WHERE FAT_IRS.FAT_IRS_SEP=2 AND FAT_IRS.FAT_IRS_ID=URUNHAR.IRSALIYE_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.IRSALIYE_SID))
end) as Cari_Ad


FROM URUNHAR WHERE URUNHAR_ID<>0
and IRSALIYE_ID>0

}
