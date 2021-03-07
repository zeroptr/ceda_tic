{$INCLUDE directive.inc}

unit ufrmRaporGrupCBakiyeliHar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, IB_Components,  frxClass, frxIBOSet,cxSSTypes,cxSSHeaders;

type
  TfrmRaporGrupCBakiyeliHar = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    GroupBox2: TGroupBox;
    txtGrpKod: TEdit;
    Panel1: TPanel;
    btnRapor: TButton;
    btnCikis: TButton;
    btnCariGrpListe: TButton;
    GroupBox3: TGroupBox;
    cmbParaBirimi: TComboBox;
    qryCariGrup: TIB_Cursor;
    qryRapor: TIB_Cursor;
    qryToplam: TIB_Cursor;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    chk_Sirket: TCheckBox;
    chk_devir: TCheckBox;
    frxReport1: TfrxReport;
    Btn_Fast: TButton;
    IB_Query3: TIB_Query;
    frxIBOmasterg: TfrxIBODataset;
    IB_DataSource2: TIB_DataSource;
    frxIBOdetailg: TfrxIBODataset;
    IB_Query4: TIB_Query;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Form_Open();
    procedure Alan_Isimlerini_Ekle;
    procedure frmRaporCiktisi_Open(strSQL:String;Rapor_Tipi:Byte);
    procedure ToplamBul;
    procedure yaz(Rapor_Tipi:Byte);
    procedure rapor_bitti;
////////////////////////////////////////////////////////////////////////////////
    procedure btnCariGrpListeClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtGrpKodKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure btnCikisClick(Sender: TObject);
    procedure txtGrpKodExit(Sender: TObject);
    procedure txtGrpKodEnter(Sender: TObject);
    procedure txtGrpKodKeyPress(Sender: TObject; var Key: Char);
    procedure dtpIslemTar1Enter(Sender: TObject);
    procedure dtpIslemTar1Exit(Sender: TObject);
    procedure cmbParaBirimiEnter(Sender: TObject);
    procedure cmbParaBirimiExit(Sender: TObject);
    procedure chk_devirEnter(Sender: TObject);
    procedure chk_devirExit(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
  private
    strSQL : String;
    row,col,row_cari : integer;
    genel_alacak,genel_borc:Currency;
    Prv_Yazdirildi:Boolean;    
    procedure Baslik_yaz;

    { Private declarations }
  public
    { Public declarations }
  end;

const cns_rapor_grup_cari_bakiyeli_har = 2;

var
  frmRaporGrupCBakiyeliHar: TfrmRaporGrupCBakiyeliHar;

implementation

uses unDataMod,ufrmRaporCiktisi,unFunc,DateUtils,main;

{$R *.dfm}

procedure TfrmRaporGrupCBakiyeliHar.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_rapor_grup_cari_bakiyeli_har,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporGrupCBakiyeliHar') then
    begin
      Application.CreateForm(TfrmRaporGrupCBakiyeliHar,frmRaporGrupCBakiyeliHar);
      with frmRaporGrupCBakiyeliHar.cmbParaBirimi do
      begin
        Items.Add(glb_DEFCUR);
        Items.AddStrings(glb_TAK_DOV_LIST);
        ItemIndex := 0;
      end;

      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporGrupCBakiyeliHar.cmbSube.Items);
          with frmRaporGrupCBakiyeliHar do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporGrupCBakiyeliHar.cmbSube do
          begin
            Clear;
            Items.Add(DataMod.SubeID2Ad(False,glb_SID));
            ItemIndex := 0;
            Enabled := False;
          end;
        end;
      end
      else
      begin
        frmRaporGrupCBakiyeliHar.grpSube.Visible := False;
      end;//end if glb_SUBELI then

    end;
  end;
end;


procedure TfrmRaporGrupCBakiyeliHar.Alan_Isimlerini_Ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'TARÝH');
  Inc(Col);
  frmRaporCiktisi.SetCellText(row,col,'BELGE TÜRÜ');
  Inc(Col);
  frmRaporCiktisi.SetCellText(row,col,'FÝÞ NUMARASI');
  Inc(Col);
  frmRaporCiktisi.SetCellText(row,col,'AÇIKLAMA');

  {$IfnDef TRANSPORT}
  Inc(Col);
  frmRaporCiktisi.SetCellText(row,col,'PROJE KODU');
  {$EndIf}
  Inc(Col);
  frmRaporCiktisi.SetCellText(row,col,'BORÇ');
  Inc(Col);
  frmRaporCiktisi.SetCellText(row,col,'ALACAK');
  Inc(Col);
  frmRaporCiktisi.SetCellText(row,col,'BORÇ BAKÝYESÝ');
  Inc(Col);
  frmRaporCiktisi.SetCellText(row,col,'ALACAK BAKÝYESÝ');

  frmRaporCiktisi.SetCellFont(0,row,col+8,row,[fsBold],8,'MS Sans Serif',4);
end;

procedure TfrmRaporGrupCBakiyeliHar.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporGrupCBakiyeliHar.btnCariGrpListeClick(Sender: TObject);
var
  CariGroup_KOD,CariGroup_AD : String;
begin
  if DataMod.LS_CariGroup(CariGroup_KOD,CariGroup_AD) then
  begin
    txtGrpKod.Text := CariGroup_KOD;
  end;
end;

procedure TfrmRaporGrupCBakiyeliHar.FormKeyPress(Sender: TObject;  var Key: Char);
begin
////////////////////////////////////////////////////////////////////////////////
  if key = #27 then
  begin
    close;
  end;
////////////////////////////////////////////////////////////////////////////////
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
////////////////////////////////////////////////////////////////////////////////
end;

procedure TfrmRaporGrupCBakiyeliHar.txtGrpKodKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if key = VK_F4 then
  begin
    btnCariGrpListeClick(Self);
  end;
end;

procedure TfrmRaporGrupCBakiyeliHar.btnCikisClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporGrupCBakiyeliHar.txtGrpKodExit(Sender: TObject);
var
  CariGrpAd : String;
begin
  if Length(Trim(txtGrpKod.Text))=0 then
  begin
    txtGrpKod.Color := clWindow;
    exit;
  end;
  if not (DataMod.FN_KOD2AD('CARI_GRUP','CARI_GRUP_KOD','CGADI',txtGrpKod.Text,CariGrpAd)) then
  begin
    Application.MessageBox('Girdiðiniz Cari Grup Kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    txtGrpKod.Clear;
    txtGrpKod.SetFocus;
  end
  else
  begin
    txtGrpKod.Color := clWindow;
  end;
end;

procedure TfrmRaporGrupCBakiyeliHar.txtGrpKodEnter(Sender: TObject);
begin
  txtGrpKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporGrupCBakiyeliHar.txtGrpKodKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporGrupCBakiyeliHar.dtpIslemTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporGrupCBakiyeliHar.dtpIslemTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporGrupCBakiyeliHar.cmbParaBirimiEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporGrupCBakiyeliHar.cmbParaBirimiExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporGrupCBakiyeliHar.chk_devirEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporGrupCBakiyeliHar.chk_devirExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporGrupCBakiyeliHar.btnRaporClick(Sender: TObject);
var
  CHeader : TcxSSHeader;
  res_Cari : TStringList;
  SubeID : String;
  strSQL1,strSQL:String;
begin
  genel_alacak := 0;
  genel_borc := 0;
  row := 0;
  col := 0;
  if Trim(txtGrpKod.Text) = '' then
  begin
    Application.MessageBox('Lütfen bir cari grup seçiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  case frmRaporCiktisi.Tarih_Karsilastir(dtpIslemTar1.Date,dtpIslemTar2.Date) of
  2:
    begin
      Application.MessageBox('Ýkinci iþlem tarihi birinci tarihten küçük olamaz.Lütfen iþlem tarihlerini kontrol ediniz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
  end;


     if sender=Btn_Fast then
     begin
          IB_Query3.Close;
          IB_Query3.Sql.Clear;
          IB_Query4.Close;
          IB_Query4.Sql.Clear;
strSQL:=
'select '+
'    prm_cari_kod, '+
'    prm_cari_ad, '+
'    prm_cari_borc, '+
'    prm_cari_alacak, '+
'    prm_cari_dev_borc, '+
'    prm_cari_dev_alacak, '+
'    prm_cari_borc_bakiye, '+
'    prm_cari_alacak_bakiye '+
' from cari_liste(:devir,:ilk,:son,:inkod,:kullan_tip,:dovkod,:Grup) ';
{
kod araligi in para birimi
kullan_tip=1 tumu
2 aralýk
3 inkod
4 grup
}
strSQL1:=
'select '+
'    prm_cari_kod, '+
'    prm_tarih, '+
'    prm_belge_tur, '+
'    prm_fis_no, '+
'    prm_aciklama, '+
'    prm_tip, '+
'    prm_borc, '+
'    prm_alacak, '+
'    prm_cari_borc_bakiye, '+
'    prm_cari_alacak_bakiye, '+
'    prm_cari_dev_borc_bakiye, '+
'    prm_cari_dev_alacak_bakiye '+
' from cari_liste_har(:devir,null,:dovkod,:tar1,:tar2,:sefer_mazot,:devir,null) ';


    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if (SubeID <> '0') and (Trim(SubeID)<>'')  then
      begin
         strSQL:=strSQL+ ' Where prm_cari_sid='+Trim(SubeID);
      end;
    end
    else
    begin
         strSQL:=strSQL+ ' Where prm_cari_sid='+Inttostr(glb_SID);
    end;



          IB_Query3.Sql.Text:=strSQL;
          IB_Query4.Sql.Text:=strSQL1;

          IB_Query3.ParamByName('devir').AsVariant:=null;
          IB_Query3.ParamByName('ilk').AsVariant:=null;
          IB_Query3.ParamByName('son').AsVariant:=null;
          IB_Query3.ParamByName('inkod').AsVariant:=null;
          IB_Query3.ParamByName('kullan_tip').AsVariant:=4;
          IB_Query3.ParamByName('dovkod').AsVariant:=null;


          IB_Query3.ParamByName('grup').AsVariant:=null;
          IB_Query4.ParamByName('devir').AsVariant:=null;
          IB_Query4.ParamByName('tar1').AsVariant:=null;
          IB_Query4.ParamByName('tar2').AsVariant:=null;
          IB_Query4.ParamByName('sefer_mazot').AsVariant:=0;
          IB_Query4.ParamByName('devir').AsVariant:=null;
          IB_Query4.ParamByName('dovkod').AsVariant:=null;
          
          if chk_devir.Checked then
          begin
          IB_Query3.ParamByName('devir').AsInteger:=1;
          IB_Query4.ParamByName('devir').AsInteger:=1;
          end
          else
          begin
          IB_Query3.ParamByName('devir').AsInteger:=0;
          IB_Query4.ParamByName('devir').AsInteger:=0;
          end;



          {if cb_Kod_Araligi.Checked then
          begin
               IB_Query3.ParamByName('ilk').AsString:=Trim(txt_ilk_Cari.Text);
               IB_Query3.ParamByName('son').AsVariant:=Trim(txt_son_Cari.Text);
               IB_Query3.ParamByName('kullan_tip').AsInteger:=2;
          end
          else
          begin
               CariLst:='';
               for i := 0 to lstCariKod.Count - 1 do
               begin
                 CariLst := CariLst + SQL_Katar(lstCariKod.Items[i]) + ','
               end;
               CariLst := copy(CariLst,1,Length(CariLst)-1);

               IB_Query3.ParamByName('inkod').AsString:=CariLst;
               IB_Query3.ParamByName('kullan_tip').AsInteger:=3;
          end;
          }

         if (cmbParaBirimi.Text <> glb_DEFCUR) then
         begin
         IB_Query3.ParamByName('dovkod').AsString:=cmbParaBirimi.Text;
         IB_Query4.ParamByName('dovkod').AsString:=cmbParaBirimi.Text;
         end;

         IB_Query3.ParamByName('grup').AsString:=Trim(txtGrpKod.Text);

         IB_Query4.ParamByName('tar1').AsString:=DateTostr(dtpIslemTar1.Date);
         IB_Query4.ParamByName('tar2').AsString:=DateTostr(dtpIslemTar2.Date);
         {
         if chk_Sefer.Checked then
         IB_Query4.ParamByName('sefer_mazot').AsInteger:=0
         else
         IB_Query4.ParamByName('sefer_mazot').AsInteger:=1;
         }

         IB_Query3.Open;
         IB_Query4.Open;


          Prv_Yazdirildi:=False;
          frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Cari_Hareket_grup.fr3');
          //frxReport1.PrepareReport();
          { a:=(frxReport1.FindComponent('Memo_Rapor_Adi') as TfrxMemoView);
           a.memo.Text:='Cari Hareket Toplamý';
           if chk_devir.Checked then
           a.memo.Text:='Devirli Cari Hareket Toplamý';
           }
          frxReport1.showReport;


          Exit;


     end;




  with qryCariGrup do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add('SELECT CARI_GRUP_UYE.CARI_KOD,CARI.CARI_AD FROM CARI_GRUP_UYE');
    SQL.Add('LEFT OUTER JOIN CARI_GRUP ON (CARI_GRUP.CARI_GRUP_KOD = CARI_GRUP_UYE.CARI_GRUP_KOD)');
    SQL.Add('LEFT OUTER JOIN CARI ON (CARI.CARI_KOD = CARI_GRUP_UYE.CARI_KOD)');
    SQL.Add('WHERE CARI_GRUP.CARI_GRUP_KOD =' + SQL_Katar(txtGrpKod.Text));
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        SQL.Add(' AND CARI_GRUP.CARI_GRUP_SID = ' + SubeID);
      end;
    end
    else
    begin
      SQL.Add(' AND CARI_GRUP.CARI_GRUP_SID = '+IntToStr(glb_SID));
    end;
//    SQL.Add(' ORDER BY CARI.CARI_AD');
    SQL.Add(' ORDER BY CARI.CARI_KOD');
    Active := True;
  end;
  if qryCariGrup.Bof and qryCariGrup.Eof then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.','Dikkat',MB_ICONWARNING);
    qryCariGrup.Active := False;
    exit;
  end;




  frmRaporCiktisi.form_open();
  frmRaporCiktisi.grdA.BeginUpdate;

  frmRaporCiktisi.SetCellText(0,0,'Cari Grup Kodu :');
  frmRaporCiktisi.SetCellFont(0,0,0,0,[fsBold],8,'MS Sans Serif',0);
  frmRaporCiktisi.SetCellText(0,1,txtGrpKod.Text);
  frmRaporCiktisi.SetCellFont(1,0,1,0,[fsBold],8,'MS Sans Serif',2);
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket(res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(0,2,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(2,0,2,0,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    inc(row);
    col := 0;
  end;

  qryCariGrup.First;
  while not qryCariGrup.Eof do
  begin
    strSQL := '';
    if (cmbParaBirimi.Text = glb_DEFCUR) then
    begin
      strSQL := 'SELECT CARI.CARI_AD'
              + '      ,CARIHAR.BELGE_ID'
              + '      ,CARIHAR.TIP'
              + '      ,CARIHAR.TUTAR_VPB AS TOPLAM'
              + '      ,CARIHAR.TARIH'
              + '      ,CARIHAR.ACIKLAMA'
              + '      ,CARIHAR.BELGE_TUR'
              + '      ,CARIHAR.PROJE_KOD FROM CARIHAR'
              + ' LEFT OUTER JOIN CARI ON (CARIHAR.CARI_KOD = CARI.CARI_KOD)'
              + ' WHERE CARIHAR.TARIH BETWEEN '+ SQL_Tarih(dtpIslemTar1.Date) + ' AND ' + SQL_Tarih(dtpIslemTar2.Date)
              + ' AND CARIHAR.CARI_KOD = ' + SQL_Katar(qryCariGrup.FieldByName('CARI_KOD').AsString);
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = ' + SubeID;
        end;
      end
      else
      begin
        strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID);
      end;
      strSQL := strSQL + ' ORDER BY CARIHAR.TARIH,CARIHAR.CARIHAR_ID ASC';
      frmRaporCiktisi_Open(strSQL,1);
    end
    else
    begin
      strSQL := 'SELECT CARI.CARI_AD,'
              + '       CARIHAR.BELGE_ID,'
              + '       CARIHAR.TIP,'
              + '       CARIHAR_DOV.TUTAR TOPLAM,'
              + '       CARIHAR.TARIH,'
              + '       CARIHAR.ACIKLAMA,'
              + '       CARIHAR.BELGE_TUR,'
              + '       CARIHAR.PROJE_KOD'
              + ' FROM CARIHAR'
              + ' LEFT OUTER JOIN CARI ON (CARIHAR.CARI_KOD = CARI.CARI_KOD)'
              + ' LEFT OUTER JOIN CARIHAR_DOV ON (CARIHAR.CARIHAR_ID = CARIHAR_DOV.CARIHAR_ID) AND (CARIHAR.CARIHAR_SID = CARIHAR_DOV.CARIHAR_SID)'
              + ' WHERE ( (CARIHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date)+' AND '+SQL_Tarih(dtpIslemTar2.Date)+') AND ('+' CARIHAR.CARI_KOD = '+SQL_Katar(qryCariGrup.FieldByName('CARI_KOD').AsString)+') AND ( CARIHAR_DOV.DOVKOD ='+SQL_Katar(cmbParaBirimi.Text)+')';
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND (CARIHAR.CARIHAR_SID = '+ SubeID+')';
        end;
      end
      else
      begin
        strSQL := strSQL + ' AND (CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID)+')';
      end;
      strSQL := strSQL + ') ORDER BY CARIHAR.TARIH,CARIHAR.CARIHAR_ID ASC';
      frmRaporCiktisi_Open(strSQL,2);
    end;
    qryCariGrup.Next;
  end;






  frmRaporCiktisi.SetCellAlignment(0,2,0,2,haright,vaCenter);
  frmRaporCiktisi.SetCellAlignment(2,2,2,2,haright,vaCenter);
  frmRaporCiktisi.SetCellAlignment(5,2,8,2,haright,vaCenter);

  CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
  CHeader.Size[3] := 250;
  CHeader.Size[2] := 100;
  CHeader.Size[1] := 100;
  CHeader.Size[4] := 125;
  CHeader.Size[5] := 125;
  CHeader.Size[6] := 125;

  frmRaporCiktisi.Rapor_Ayarlari(2);  
  frmRaporCiktisi.grdA.EndUpdate;
  frmRaporCiktisi.WindowState := wsMaximized;
  qryCariGrup.Active := False;
end;


procedure TfrmRaporGrupCBakiyeliHar.frmRaporCiktisi_Open(strSQL:String;Rapor_Tipi:Byte);
//rapor tipi 1 ise glb_defcur seçilidir.
//rapor tipi 2 ise takipli kurlardan birisi seçilidir.
begin




  with qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;


  if ((qryRapor.Eof) and (qryRapor.bof))then
  begin
  Baslik_Yaz;
  end;


  if ((qryRapor.Eof) and (qryRapor.bof))then
  begin
    exit;
  end;


  if chk_devir.Checked then
  begin
    ToplamBul;
  end;
  inc(row,2);
  yaz(Rapor_Tipi);


  qryRapor.Close;
  qryToplam.Close;


end;

procedure TfrmRaporGrupCBakiyeliHar.ToplamBul;
var
  SQLToplam,SubeID : String;
begin
  if frmRaporCiktisi.Tarih_Karsilastir(dtpIslemTar1.Date,glb_DONEM_BAS)=2 then
  begin
    with qryToplam do
    begin
      Active := false;
      SQL.Clear;
      if (cmbParaBirimi.Text = glb_DEFCUR) then
      begin
        SQLToplam := ' SELECT CARIHAR.TIP,SUM(CARIHAR.TUTAR_VPB) AS TOPLAM FROM CARIHAR'
                   + ' WHERE CARIHAR.TARIH BETWEEN '+ SQL_Tarih(glb_DONEM_BAS)  + ' AND ' + SQL_Tarih(frmRaporCiktisi.Date_PriorDay(dtpIslemTar1.Date)) + ' AND'+  ' CARIHAR.CARI_KOD = ' + SQL_Katar(qryCariGrup.FieldByName('CARI_KOD').AsString);
        if glb_SUBELI then
        begin
          SubeID := DataMod.SubeAd2ID(cmbSube.Text);
          if SubeID <> '0' then
          begin
            SQLToplam := SQLToplam + ' AND CARIHAR.CARIHAR_SID = '+ SubeID;
          end;
        end
        else
        begin
          SQLToplam := SQLToplam + ' AND CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID);
        end;
        SQLToplam := SQLToplam + ' GROUP BY CARIHAR.TIP ';
      end
      else
      begin
        SQLToplam := 'SELECT CARIHAR.TIP,SUM(CARIHAR_DOV.TUTAR) AS TOPLAM FROM CARIHAR_DOV'
                   + ' LEFT OUTER JOIN CARIHAR ON (CARIHAR.CARIHAR_ID = CARIHAR_DOV.CARIHAR_ID AND CARIHAR.CARIHAR_SID = CARIHAR_DOV.CARIHAR_DOV_SID)'
                   + ' LEFT OUTER JOIN CARI ON (CARI.CARI_KOD = CARIHAR.CARI_KOD)'
                   + ' WHERE CARIHAR.TARIH BETWEEN '+ SQL_Tarih(glb_DONEM_BAS)+  ' AND '+ SQL_Tarih(frmRaporCiktisi.Date_PriorDay(dtpIslemTar1.Date)) + ' AND'+  ' CARIHAR_DOV.DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text) + ' AND' + ' CARIHAR.CARI_KOD = ' + SQL_Katar(qryCariGrup.FieldByName('CARI_KOD').AsString);
        if glb_SUBELI then
        begin
          SubeID := DataMod.SubeAd2ID(cmbSube.Text);
          if SubeID <> '0' then
          begin
            SQLToplam := SQLToplam + ' AND CARIHAR.CARIHAR_SID = '+ SubeID;
          end;
        end
        else
        begin
          SQLToplam := SQLToplam + ' AND CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID);
        end;
        SQLToplam := SQLToplam + ' GROUP BY CARIHAR.TIP ';
      end;
      SQL.Add(SQLToplam);
      Active := True;
    end;
///*************************************
    qryToplam.First;
    while not qryToplam.Eof do
    begin
      if qryToplam.FieldByName('TIP').AsString = 'A' then
      begin
        genel_alacak := qryToplam.FieldByName('TOPLAM').AsCurrency;
      end;
      if qryToplam.FieldByName('TIP').AsString = 'B' then
      begin
        genel_borc := qryToplam.FieldByName('TOPLAM').AsCurrency;
      end;
      qryToplam.Next;
    end;
////////////////////////////////////////////////////////////////////////////////
    with qryToplam do
    begin
      if Active then Active := false;
      SQL.Clear;
      if cmbParaBirimi.Text = glb_DEFCUR then
      begin
        SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI WHERE CARI_KOD = ' + SQL_Katar(qryCariGrup.FieldByName('CARI_KOD').AsString));
      end
      else
      begin
        SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI_DOV WHERE CARI_KOD = ' + SQL_Katar(qryCariGrup.FieldByName('CARI_KOD').AsString) + ' AND DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text));
      end;
      Active := True;
      genel_alacak := genel_alacak + FieldByName('DEVREDEN_ALACAK').AsCurrency;
      genel_borc :=  genel_borc + FieldByName('DEVREDEN_BORC').AsCurrency;
      Active := False;
    end;
////////////////////////////////////////////////////////////////////////////////
  end
  else
  begin
    with qryToplam do
    begin
      if Active then Active := false;
      SQL.Clear;
      if cmbParaBirimi.Text = glb_DEFCUR then
      begin
        SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI WHERE CARI_KOD = ' + SQL_Katar(qryCariGrup.FieldByName('CARI_KOD').AsString));
      end
      else
      begin
        SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI_DOV WHERE CARI_KOD = ' + SQL_Katar(qryCariGrup.FieldByName('CARI_KOD').AsString) + ' AND DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text));
      end;
      Active := True;
      genel_alacak := FieldByName('DEVREDEN_ALACAK').AsCurrency;
      genel_borc := FieldByName('DEVREDEN_BORC').AsCurrency;
      Active := False;
    end;
  end;
end;


procedure TfrmRaporGrupCBakiyeliHar.rapor_bitti;
begin
  inc(row);
  col := 3;
  frmRaporCiktisi.SetCellText(row,col,'TOPLAM');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  inc(col);
  if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
  else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

  {$IfnDef TRANSPORT}
  if chk_devir.Checked then
  begin
    frmRaporCiktisi.SetCellText(row,col,'=SUM(F'+inttostr(row_cari)+':F'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    inc(col);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,'=SUM(G'+inttostr(row_cari)+':G'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  end
  else
  begin
    frmRaporCiktisi.SetCellText(row,col,'=SUM(F'+inttostr(row_cari)+':F'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    inc(col);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,'=SUM(G'+inttostr(row_cari)+':G'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  end;
  {$EndIf}



  {$IfDef TRANSPORT}
  if chk_devir.Checked then
  begin
    frmRaporCiktisi.SetCellText(row,col,'=SUM(E'+inttostr(row_cari)+':E'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    inc(col);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,'=SUM(F'+inttostr(row_cari)+':F'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  end
  else
  begin
    frmRaporCiktisi.SetCellText(row,col,'=SUM(E'+inttostr(row_cari)+':E'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    inc(col);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,'=SUM(F'+inttostr(row_cari)+':F'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  end;
  {$EndIf}





  inc(col);
  if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
  else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
  frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
  frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  inc(col);
  if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
  else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
  frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
  frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);

  genel_borc := 0;
  genel_alacak := 0;
end;



procedure TfrmRaporGrupCBakiyeliHar.Baslik_yaz;
begin
//    if not baslik_yazildi then
//    begin
  row := row + 2;
  col := 0;
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_AD').AsString);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      frmRaporCiktisi.SetCellText(row,col,qryCariGrup.FieldByName('CARI_AD').AsString);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);


      frmRaporCiktisi.SetCellText(1,0,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
      frmRaporCiktisi.SetCellFont(0,1,0,1,[fsBold],8,'MS Sans Serif',0);
      inc(row);
//      baslik_yazildi := true;
      Alan_isimlerini_ekle;
//      row_cari := row + 2;

      if chk_devir.Checked then
      begin
        col :=  0;
        inc(row);
        inc(col,3);
        frmRaporCiktisi.SetCellText(row,col,'DEVÝR');
        frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
        inc(col);
        if cmbParaBirimi.Text = glb_DEFCUR then
        begin
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end
        else
        begin
          frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        end;

        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
        inc(col);
        if cmbParaBirimi.Text = glb_DEFCUR then
        begin
          frmRaporCiktisi.format_ayarla(col,row,col,row)
        end
        else
        begin
          frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        end;
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));

        if (genel_alacak > genel_borc) then
        begin
          genel_alacak := genel_alacak - genel_borc;
          genel_borc := 0;
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        end;

        if (genel_alacak < genel_borc) then
        begin
          genel_borc := genel_borc - genel_alacak;
          genel_alacak := 0;
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        end;
        if (genel_alacak = genel_borc) then
        begin
          genel_alacak := 0;
          genel_borc := 0;
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        end;

      end;//end chk_devir.checked
//    end;//end if not baslik_yazildi then
           //stop


end;


procedure TfrmRaporGrupCBakiyeliHar.yaz(Rapor_Tipi:Byte);
var
  baslik_yazildi : Boolean;
  SubeID : String;
begin
  baslik_yazildi := false;
  col := 0;
  qryRapor.First;
  while not (qryRapor.Eof) do
  begin
    if not baslik_yazildi then
    begin
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_AD').AsString);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      frmRaporCiktisi.SetCellText(row,col,qryCariGrup.FieldByName('CARI_AD').AsString);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);


      frmRaporCiktisi.SetCellText(1,0,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
      frmRaporCiktisi.SetCellFont(0,1,0,1,[fsBold],8,'MS Sans Serif',0);
      inc(row);
      baslik_yazildi := true;
      Alan_isimlerini_ekle;
      row_cari := row + 2;

      if chk_devir.Checked then
      begin
        col :=  0;
        inc(row);
        inc(col,3);
        frmRaporCiktisi.SetCellText(row,col,'DEVÝR');
        frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
        inc(col);
        if cmbParaBirimi.Text = glb_DEFCUR then
        begin
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end
        else
        begin
          frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        end;

        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
        inc(col);
        if cmbParaBirimi.Text = glb_DEFCUR then
        begin
          frmRaporCiktisi.format_ayarla(col,row,col,row)
        end
        else
        begin
          frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        end;
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));

        if (genel_alacak > genel_borc) then
        begin
          genel_alacak := genel_alacak - genel_borc;
          genel_borc := 0;
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        end;

        if (genel_alacak < genel_borc) then
        begin
          genel_borc := genel_borc - genel_alacak;
          genel_alacak := 0;
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        end;
        if (genel_alacak = genel_borc) then
        begin
          genel_alacak := 0;
          genel_borc := 0;
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
          inc(col);
          if cmbParaBirimi.Text = glb_DEFCUR then
          begin
            frmRaporCiktisi.format_ayarla(col,row,col,row)
          end
          else
          begin
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        end;

      end;//end chk_devir.checked
    end;//end if not baslik_yazildi then
           //stop



    col :=  0;
    inc(row);


    DataMod.Rapor_Satir_Renklendir(col,row,8);


    //////////////////////////////////////////////////////////////////////////////
    frmRaporCiktisi.SetCellDate(col,row,qryRapor.FieldByName('TARIH').AsDate);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,DataMod.GetBelgeKod(qryRapor.FieldByName('BELGE_TUR').AsInteger));
    case qryRapor.FieldByName('BELGE_TUR').AsInteger of
    14:
      begin
        with qryToplam do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT ISLEM_TIP,BELGE_ID FROM KASAHAR WHERE KASAHAR_ID = '+qryRapor.FieldByName('BELGE_ID').AsString);
          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if SubeID <> '0' then
            begin
              SQL.Add(' AND KASAHAR_SID = '+ SubeID);
            end;
          end
          else
          begin
            SQL.Add(' AND KASAHAR_SID = '+ inttostr(glb_SID));
          end;
          Active := True;
        end;
        if qryToplam.FieldByName('ISLEM_TIP').AsInteger = 5 then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('BELGE_ID').AsString);
          qryToplam.Active := False;
        end
        else
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
          qryToplam.Active := False;
        end;
      end;
    17:
      begin
        with qryToplam do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT DEKONT_ID FROM DEKONT_D WHERE DEKONT_D.DEKONT_D_ID ='+qryRapor.FieldByName('BELGE_ID').AsString);
          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if SubeID <> '0' then
            begin
              SQL.Add(' AND DEKONT_D.DEKONT_SID = '+ SubeID);
            end;
          end
          else
          begin
            SQL.Add(' AND DEKONT_D.DEKONT_SID = '+ inttostr(glb_SID));
          end;
          Active := True;
        end;
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('DEKONT_ID').AsString);
        qryToplam.Active := False;
      end;
    else
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
      end;
    end;//end case
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);

  {$IfnDef TRANSPORT}
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_KOD').AsString);
  {$EndIf}

    inc(col);

    if qryRapor.FieldByName('TIP').AsString = 'B' then
    begin
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TOPLAM').AsString);
      inc(col);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,'0');
      genel_borc := genel_borc + qryRapor.FieldByName('TOPLAM').AsCurrency;
    end;

    if qryRapor.FieldByName('TIP').AsString = 'A' then
    begin
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,'0');
      inc(col);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TOPLAM').AsString);
      genel_alacak := genel_alacak + qryRapor.FieldByName('TOPLAM').AsCurrency;
    end;

    if (genel_alacak > genel_borc) then
    begin
      genel_alacak := genel_alacak - genel_borc;
      genel_borc := 0;
      inc(col);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
      inc(col);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
    end;

    if (genel_alacak < genel_borc) then
    begin
      genel_borc := genel_borc - genel_alacak;
      genel_alacak := 0;
      inc(col);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
      inc(col);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
    end;

    if (genel_alacak = genel_borc) then
    begin
      genel_alacak := 0;
      genel_borc := 0;
      inc(col);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
      inc(col);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
    end;

    qryRapor.Next;


  end;


  rapor_bitti;
end;

procedure TfrmRaporGrupCBakiyeliHar.FormShow(Sender: TObject);
begin
  dtpIslemTar1.Date := glb_DONEM_BAS;
  dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
end;

procedure TfrmRaporGrupCBakiyeliHar.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporGrupCBakiyeliHar);
end;

procedure TfrmRaporGrupCBakiyeliHar.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
  //a,b,c:TfrxComponent;
  res_Cari : TStringList;
begin
    if not Prv_Yazdirildi then
    begin
       if chk_Sirket.Checked then
       begin
         res_Cari := TStringList.Create;
         if DataMod.FN_Sirket (res_Cari) then
         begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:=res_Cari[1];
         end;
         res_Cari.Free;
       end
       else
       begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:='';
       end;


       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(dtpIslemTar2.Date);
       
       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);

       Prv_Yazdirildi:=True;
    end;



end;

procedure TfrmRaporGrupCBakiyeliHar.IB_Query1CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
     if ARow.ByName('prm_belge_tur').AsInteger>0 then
    ARow.ByName('CALC_BELGE_TUR').AsString :=
    DataMod.GetBelgeKod(ARow.ByName('prm_belge_tur').AsInteger)
    else
    ARow.ByName('CALC_BELGE_TUR').AsString :='DEVÝR';
end;

end.
