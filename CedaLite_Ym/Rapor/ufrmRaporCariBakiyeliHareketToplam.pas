unit ufrmRaporCariBakiyeliHareketToplam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, IB_Components, frxClass, frxIBOSet, cxSSTypes,cxSSHeaders,
  Grids, IB_Grid;

type
  TfrmRaporCariBakiyeliHareketToplam = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    txtCariKod1: TEdit;
    txtCariKod2: TEdit;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    Button1: TButton;
    Button2: TButton;
    qryCariHareket: TIB_Query;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    GroupBox2: TGroupBox;
    chk_devir: TCheckBox;
    chk_Sirket: TCheckBox;
    GroupBox4: TGroupBox;
    txtGrpKod: TEdit;
    btnCariGrpListe: TButton;
    frxReport1: TfrxReport;
    Btn_Fast: TButton;
    IB_Query1: TIB_Query;
    frxIBOToplam: TfrxIBODataset;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure Alan_isimlerini_ekle;
    procedure yaz;
    procedure topla;
    procedure HareketiOlmayanlariTopla;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure txtCariKod1Exit(Sender: TObject);
    procedure txtCariKod2Exit(Sender: TObject);
    procedure txtCariKod1KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtCariKod2KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtGrpKodKeyDown(Sender: TObject;   var Key: Word;      Shift: TShiftState);
    procedure btnRaporClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtCariKod1Enter(Sender: TObject);
    procedure txtCariKod2Enter(Sender: TObject);
    procedure dtpIslemTar1Enter(Sender: TObject);
    procedure dtpIslemTar1Exit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure chk_devirEnter(Sender: TObject);
    procedure chk_devirExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtGrpKodEnter(Sender: TObject);
    procedure txtGrpKodExit(Sender: TObject);
    procedure txtGrpKodKeyPress(Sender: TObject; var Key: Char);
    procedure btnCariGrpListeClick(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
//    CARI_KOD,CARI_AD:String;
//    strSQL:String;
    row,col:integer;
    Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_cari_bakiyeli_hareket_toplam = 2;
  
var
  frmRaporCariBakiyeliHareketToplam: TfrmRaporCariBakiyeliHareketToplam;

implementation

uses unDataMod, ufrmRaporCiktisi, ufrmCariSDLG,unFunc, DateUtils,main;

{$R *.dfm}


procedure TfrmRaporCariBakiyeliHareketToplam.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_cari_bakiyeli_hareket_toplam,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporCariBakiyeliHareketToplam') then
    begin
      Application.CreateForm(TfrmRaporCariBakiyeliHareketToplam,frmRaporCariBakiyeliHareketToplam);

      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporCariBakiyeliHareketToplam.cmbSube.Items);
          with frmRaporCariBakiyeliHareketToplam do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporCariBakiyeliHareketToplam.cmbSube do
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
        frmRaporCariBakiyeliHareketToplam.grpSube.Visible := False;
      end;//end if glb_SUBELI then

    end;
  end;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.FormShow(Sender: TObject);
begin
  dtpIslemTar1.Date := glb_DONEM_BAS;
  dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.Button1Click(Sender: TObject);
var
  CARI_KOD,CARI_AD : String;
begin
  if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) Then txtCariKod1.Text := CARI_KOD;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.Button2Click(Sender: TObject);
var
  CARI_KOD,CARI_AD : String;
begin
  if frmCariSDLG.Form_Open (True,CARI_KOD,CARI_AD,1) Then txtCariKod2.Text := CARI_KOD;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.txtCariKod1Exit(Sender: TObject);
var
  CARI_AD : String;
begin
  if Length(Trim(txtCariKod1.Text))=0 then
  begin
    txtCariKod1.Color := clWindow;
    exit;
  end;
  if not (DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCariKod1.Text,Cari_Ad)) then
  begin
    Application.MessageBox('Cari Kodu Bulunamadý.Lütfen listeden seçiniz','Dikkat',MB_ICONWARNING);
    txtCariKod1.Clear;
  end
  else
  begin
    txtCariKod1.Color := clWindow;
  end;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.txtCariKod2Exit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Length(Trim(txtCariKod2.Text))=0 then
  begin
    txtCariKod2.Color := clWindow;
    exit;
  end;
  if not DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCariKod2.Text,Cari_Ad) then
  begin
    Application.MessageBox('Cari Kodu Bulunamadý.Lütfen listeden seçiniz','Dikkat',MB_ICONWARNING);
    txtCariKod2.Clear;
  end
  else
  begin
    txtCariKod2.Color := clWindow;
  end;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.txtCariKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key=vk_f4 then
  begin
     Button1Click(Self);
  end;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.txtCariKod2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key=VK_F4 then
  begin
    Button2Click(Self);
  end
end;

procedure TfrmRaporCariBakiyeliHareketToplam.btnRaporClick(Sender: TObject);
var
  CHeader : TcxSSHeader;
  res_Cari : TStringList;
  SubeID,strSQL : String;
  a,b,c:TfrxMemoView;//TfrxComponent;

begin
  if Length(Trim(txtGrpKod.Text)) <> 0 then
  begin
    strSQL := 'SELECT CARIHAR.CARI_KOD,CARI.CARI_AD,CARIHAR.TIP,SUM(CARIHAR.TUTAR_VPB) AS TUTAR,CARI.DEVREDEN_ALACAK,CARI.DEVREDEN_BORC FROM CARIHAR'
             +' INNER JOIN CARI ON (CARI.CARI_KOD=CARIHAR.CARI_KOD)'
             +' INNER JOIN CARI_GRUP_UYE ON (CARI_GRUP_UYE.CARI_KOD = CARI.CARI_KOD)'
             +' WHERE'
             +' (CARIHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date)+' AND '+SQL_Tarih(dtpIslemTar2.Date)+')'
             +' AND CARI_GRUP_UYE.CARI_GRUP_KOD = '+SQL_Katar(txtGrpKod.Text);
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ SubeID;
      end;
    end
    else
    begin
      strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID);
    end;
    strSQL := strSQL + ' GROUP BY CARIHAR.CARI_KOD,CARI.CARI_AD,CARIHAR.TIP,CARI.DEVREDEN_ALACAK,CARI.DEVREDEN_BORC ORDER BY CARIHAR.CARI_KOD';
  end
  else
  if (Length(trim(txtCariKod1.Text))<>0) and (Length(Trim(txtCariKod2.Text))<>0) then
  begin
    strSQL := 'SELECT CARIHAR.CARI_KOD,CARI.CARI_AD,CARIHAR.TIP,SUM(CARIHAR.TUTAR_VPB) AS TUTAR,CARI.DEVREDEN_ALACAK,CARI.DEVREDEN_BORC FROM CARIHAR'
             +' INNER JOIN CARI ON (CARI.CARI_KOD=CARIHAR.CARI_KOD)'
             +' WHERE'
             +' (CARIHAR.CARI_KOD BETWEEN '+SQL_Katar(txtCariKod1.Text)+' AND '+SQL_Katar(txtCariKod2.Text)+')'
             +' AND'
             +' (CARIHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date)+' AND '+SQL_Tarih(dtpIslemTar2.Date)+')';
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ SubeID;
      end;
    end
    else
    begin
      strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID);
    end;
    strSQL := strSQL + ' GROUP BY CARIHAR.CARI_KOD,CARI.CARI_AD,CARIHAR.TIP,CARI.DEVREDEN_ALACAK,CARI.DEVREDEN_BORC ORDER BY CARIHAR.CARI_KOD';
  end
  else
  begin
    if Length(Trim(txtCariKod1.Text))<>0 then
    begin
      strSQL := 'SELECT CARIHAR.CARI_KOD,CARI.CARI_AD,CARIHAR.TIP,SUM(CARIHAR.TUTAR_VPB) AS TUTAR,CARI.DEVREDEN_ALACAK,CARI.DEVREDEN_BORC FROM CARIHAR'
               +' INNER JOIN CARI ON (CARI.CARI_KOD=CARIHAR.CARI_KOD)'
               +' WHERE'
               +' (CARIHAR.CARI_KOD = '+SQL_Katar(txtCariKod1.Text)+')'
               +' AND'
               +' (CARIHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date)+' AND '+SQL_Tarih(dtpIslemTar2.Date)+')';
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ SubeID;
        end;
      end
      else
      begin
        strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID);
      end;
      strSQL := strSQL + ' GROUP BY CARIHAR.CARI_KOD,CARI.CARI_AD,CARIHAR.TIP,CARI.DEVREDEN_ALACAK,CARI.DEVREDEN_BORC ORDER BY CARIHAR.CARI_KOD';
    end
    else
    begin
      strSQL := 'SELECT CARIHAR.CARI_KOD,CARI.CARI_AD,CARIHAR.TIP,SUM(CARIHAR.TUTAR_VPB) AS TUTAR,CARI.DEVREDEN_ALACAK,CARI.DEVREDEN_BORC FROM CARIHAR'
               +' INNER JOIN CARI ON (CARI.CARI_KOD=CARIHAR.CARI_KOD)'
               +' WHERE'
               +' (CARIHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date)+' AND '+SQL_Tarih(dtpIslemTar2.Date)+')';
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ SubeID;
        end;
      end
      else
      begin
        strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID);
      end;
      strSQL := strSQL + ' GROUP BY CARIHAR.CARI_KOD,CARI.CARI_AD,CARIHAR.TIP,CARI.DEVREDEN_ALACAK,CARI.DEVREDEN_BORC ORDER BY CARIHAR.CARI_KOD';
    end;
  end;

  with qryCariHareket do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((qryCariHareket.Eof) and (qryCariHareket.bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryCariHareket.Active := False;
    exit;
  end;


     if sender=Btn_Fast then
     begin
        strSQL :=
'select '+
'    cari_liste.prm_cari_kod, '+
'    cari_liste.prm_cari_ad, '+
'    sum(cari_liste_har.prm_borc) as har_borc, '+
'    sum(cari_liste_har.prm_alacak) as har_alacak, '+
'    (CASE '+
'    WHEN (sum(cari_liste_har.prm_borc)>sum(cari_liste_har.prm_alacak)) THEN '+
'    sum(cari_liste_har.prm_borc)-sum(cari_liste_har.prm_alacak) '+
'    ELSE 0 '+
'    END) har_bak_borc '+
'    ,(CASE '+
'    WHEN (sum(cari_liste_har.prm_alacak)>sum(cari_liste_har.prm_borc)) THEN '+
'    sum(cari_liste_har.prm_alacak)-sum(cari_liste_har.prm_borc) '+
'    ELSE 0 '+
'    END) har_bak_alacak '+
'from cari_liste(1,:ilk,:son,null,:kullan_tip,null,:grup) '+
'left outer join '+
'cari_liste_har(:devir,null,null,:Tar1,:Tar2,1,:devir,:sid) '+
'on (cari_liste.prm_cari_kod=cari_liste_har.prm_Cari_kod) ';


          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if (SubeID <> '0') and (Trim(SubeID)<>'') then
            begin
               strSQL :=strSQL+ 'Where cari_liste.prm_cari_sid ='+SubeID;
            end;
          end
          else
          begin
               strSQL :=strSQL+ 'Where cari_liste.prm_cari_sid ='+Inttostr(Glb_Sid);
          end;

        strSQL :=strSQL+
' group by '+
'    cari_liste.prm_cari_kod, '+
'    cari_liste.prm_cari_ad ';



          IB_Query1.Close;
          IB_Query1.Sql.Clear;
          IB_Query1.Sql.Add(strSql);
          IB_Query1.Sql.Add(
          'having (not sum(cari_liste_har.prm_borc) is null) '+
          'or (not sum(cari_liste_har.prm_alacak) is null) ');

          IB_Query1.ParamByName('Tar1').AsString:=DateTostr(dtpIslemTar1.Date);
          IB_Query1.ParamByName('Tar2').AsString:=DateTostr(dtpIslemTar2.Date);


          if chk_devir.Checked then
          IB_Query1.ParamByName('Devir').AsInteger:=1
          else
          IB_Query1.ParamByName('Devir').AsInteger:=0;

          IB_Query1.ParamByName('ilk').AsVariant:=null;
          IB_Query1.ParamByName('son').AsVariant:=null;
          IB_Query1.ParamByName('grup').AsVariant:=null;
          IB_Query1.ParamByName('sid').AsVariant:=null;


          if (Trim(txtGrpKod.Text)='') and (Trim(txtCariKod1.Text)='') then
          IB_Query1.ParamByName('kullan_tip').AsInteger:=1;

          if (Trim(txtGrpKod.Text)<>'') then
          begin
          IB_Query1.ParamByName('kullan_tip').AsInteger:=4;
          IB_Query1.ParamByName('grup').AsVariant:=txtGrpKod.Text;
          end;

          if (Trim(txtGrpKod.Text)='') and (Trim(txtCariKod1.Text)<>'') then
          begin
          IB_Query1.ParamByName('kullan_tip').AsInteger:=2;
          IB_Query1.ParamByName('ilk').AsVariant:=txtCariKod1.Text;
          IB_Query1.ParamByName('son').AsVariant:=txtCariKod2.Text;
          end;




          IB_Query1.Open;

          Prv_Yazdirildi:=False;
          frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Cari_Hareket_Toplam.fr3');
          //frxReport1.PrepareReport();
           a:=(frxReport1.FindComponent('Memo_Rapor_Adi') as TfrxMemoView);
           a.memo.Text:='Cari Hareket Toplamý';
           if chk_devir.Checked then
           a.memo.Text:='Devirli Cari Hareket Toplamý';

          frxReport1.showReport;




          IB_Query1.Close;
          IB_Query1.Sql.Clear;
          IB_Query1.Sql.Add(strSql);
          IB_Query1.Sql.Add(
          'having (sum(cari_liste_har.prm_borc) is null) '+
          'or (sum(cari_liste_har.prm_alacak) is null) ');

          IB_Query1.ParamByName('Tar1').AsString:=DateTostr(dtpIslemTar1.Date);
          IB_Query1.ParamByName('Tar2').AsString:=DateTostr(dtpIslemTar2.Date);
          if chk_devir.Checked then
          IB_Query1.ParamByName('Devir').AsInteger:=1
          else
          IB_Query1.ParamByName('Devir').AsInteger:=0;

          IB_Query1.ParamByName('ilk').AsVariant:=null;
          IB_Query1.ParamByName('son').AsVariant:=null;
          IB_Query1.ParamByName('grup').AsVariant:=null;
          IB_Query1.ParamByName('sid').AsVariant:=null;


          if (Trim(txtGrpKod.Text)='') and (Trim(txtCariKod1.Text)='') then
          IB_Query1.ParamByName('kullan_tip').AsInteger:=1;

          if (Trim(txtGrpKod.Text)<>'') then
          begin
          IB_Query1.ParamByName('kullan_tip').AsInteger:=4;
          IB_Query1.ParamByName('grup').AsVariant:=txtGrpKod.Text;
          end;

          if (Trim(txtGrpKod.Text)='') and (Trim(txtCariKod1.Text)<>'') then
          begin
          IB_Query1.ParamByName('kullan_tip').AsInteger:=2;
          IB_Query1.ParamByName('ilk').AsVariant:=txtCariKod1.Text;
          IB_Query1.ParamByName('son').AsVariant:=txtCariKod2.Text;
          end;


          IB_Query1.Open;

          a:=(frxReport1.FindComponent('Memo_Rapor_Adi') as TfrxMemoView);
          a.memo.Text:='Hareket Kaydý Olmayan Cari Hareket Toplamý';

          frxReport1.showReport;


          Exit;


     end;
  frmRaporCiktisi.form_open();
  frmRaporCiktisi.grdA.BeginUpdate;
  row := 0;
  col := 0;
  Alan_isimlerini_ekle;
  if chk_devir.Checked then
  begin
    frmRaporCiktisi.SetCellText(0,0,'Devirli Cari Hareket Toplamý');
    frmRaporCiktisi.SetCellFont(0,0,0,0,[fsBold],8,'MS Sans Serif',2);
    if chk_Sirket.checked then
    begin
      res_Cari := TStringList.Create;
      if DataMod.FN_Sirket (res_Cari) then
      begin
        frmRaporCiktisi.SetCellText(0,1,res_Cari[1]);
        frmRaporCiktisi.SetCellFont(1,0,1,0,[fsBold],8,'MS Sans Serif',2);
      end;
      res_Cari.Free;
    end;
  end
  else
  begin
    frmRaporCiktisi.SetCellText(0,0,'Devirsiz Cari Hareket Toplamý');
    frmRaporCiktisi.SetCellFont(0,0,0,0,[fsBold],8,'MS Sans Serif',2);
    if chk_Sirket.checked then
    begin
      res_Cari := TStringList.Create;
      if DataMod.FN_Sirket (res_Cari) then
      begin
        frmRaporCiktisi.SetCellText(0,1,res_Cari[1]);
        frmRaporCiktisi.SetCellFont(1,0,1,0,[fsBold],8,'MS Sans Serif',2);
      end;
      res_Cari.Free;
    end;
  end;
  yaz;

  if Length(Trim(txtGrpKod.Text)) = 0 then
  begin
    HareketiOlmayanlariTopla;
  end;

  frmRaporCiktisi.SetCellFormat(0,2,0,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
//  frmRaporCiktisi.SetCellFormat(2,2,6,frmRaporCiktisi.grd.ActiveSheet.RowCount,3);
  frmRaporCiktisi.SetCellAlignment(0,1,0,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haright,vaCenter);
  frmRaporCiktisi.SetCellAlignment(2,1,6,1,haright,vaCenter);
  CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
  CHeader.Size[0] := 100;
  CHeader.Size[1] := 300;
  CHeader.Size[2] := 100;
  CHeader.Size[3] := 100;
  CHeader.Size[4] := 100;
  CHeader.Size[5] := 100;
  frmRaporCiktisi.grdA.EndUpdate;
  frmRaporCiktisi.WindowState := wsMaximized;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.yaz;
var
  i : integer;
  tutar : currency;
  satirSayisi : byte;
  CARI_KOD : String;
begin
  satirSayisi := 0;
  CARI_KOD := '';
  qryCariHareket.First;
  while not qryCariHareket.Eof do
  begin
    col :=  0;
    inc(row);


    if CARI_KOD = qryCariHareket.FieldByName('CARI_KOD').AsString then
    begin
      satirSayisi := 2;
      row := row - 1;
      if qryCariHareket.FieldByName('TIP').AsString = 'B' then
      begin
        if chk_devir.Checked then
        begin
          tutar := qryCariHareket.FieldByName('TUTAR').AsCurrency + qryCariHareket.FieldByName('DEVREDEN_BORC').AsCurrency;
          frmRaporCiktisi.SetCellText(row,3,CurrToStr(tutar));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end
        else
        begin
          frmRaporCiktisi.SetCellText(row,3,qryCariHareket.FieldByName('TUTAR').AsString);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;
      end
      else
      begin
        if chk_devir.Checked then
        begin
          tutar := qryCariHareket.FieldByName('TUTAR').AsCurrency + qryCariHareket.FieldByName('DEVREDEN_ALACAK').AsCurrency;
          frmRaporCiktisi.SetCellText(row,4,CurrToStr(tutar));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end
        else
        begin
          frmRaporCiktisi.SetCellText(row,4,qryCariHareket.FieldByName('TUTAR').AsString);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;
      end;
    end
    else
    if CARI_KOD <> qryCariHareket.FieldByName('CARI_KOD').AsString then
    begin
      if chk_devir.Checked then
      begin
        if satirSayisi = 1 then
        begin
          qryCariHareket.Prior;
          row := row - 1;
          if qryCariHareket.FieldByName('TIP').AsString = 'A' then
          begin//tipi borç
            frmRaporCiktisi.SetCellText(row,3,qryCariHareket.FieldByName('DEVREDEN_BORC').AsString);
            frmRaporCiktisi.format_ayarla(col,row,col,row);
          end
          else
          begin//tipi alacak
            frmRaporCiktisi.SetCellText(row,4,qryCariHareket.FieldByName('DEVREDEN_ALACAK').AsString);
            frmRaporCiktisi.format_ayarla(col,row,col,row);
          end;
          inc(row);
          qryCariHareket.Next;
        end;
      end;

      DataMod.Rapor_Satir_Renklendir(col,row,5);

      satirSayisi := 1;
      CARI_KOD := qryCariHareket.FieldByName('CARI_KOD').AsString;
      frmRaporCiktisi.SetCellText(row,col,qryCariHareket.FieldByName('CARI_KOD').AsString);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryCariHareket.FieldByName('CARI_AD').AsString);
      if qryCariHareket.FieldByName('TIP').AsString = 'B' then
      begin
        if chk_devir.Checked then
        begin
          inc(col);
          tutar := qryCariHareket.FieldByName('TUTAR').AsCurrency + qryCariHareket.FieldByName('DEVREDEN_BORC').AsCurrency;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(tutar));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'0');
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end
        else
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryCariHareket.FieldByName('TUTAR').AsString);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'0');
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;
      end
      else
      begin
        if chk_devir.Checked then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'0');
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          inc(col);
          tutar := qryCariHareket.FieldByName('TUTAR').AsCurrency + qryCariHareket.FieldByName('DEVREDEN_ALACAK').AsCurrency;
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(tutar));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end
        else
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'0');
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryCariHareket.FieldByName('TUTAR').AsString);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;
      end;
    end;
    qryCariHareket.Next;
  end;

{
  for i := 2 to (row) do
  begin                          //  borc > alacak
    if frmRaporCiktisi.GetCellDeger(i,3) > frmRaporCiktisi.GetCellDeger(i,4) then
    begin
                                 //row,col
      frmRaporCiktisi.SetCellText(i,5,CurrToStr(frmRaporCiktisi.GetCellDeger(i,3)-frmRaporCiktisi.GetCellDeger(i,4)));
      frmRaporCiktisi.format_ayarla(5,i,5,i);
      frmRaporCiktisi.SetCellText(i,6,'0');
      frmRaporCiktisi.format_ayarla(6,i,6,i);
    end
    else                         //  borc < alacak
    if frmRaporCiktisi.GetCellDeger(i,3) < frmRaporCiktisi.GetCellDeger(i,4) then
    begin
      frmRaporCiktisi.SetCellText(i,5,'0');
      frmRaporCiktisi.format_ayarla(5,i,5,i);
      frmRaporCiktisi.SetCellText(i,6,CurrToStr(frmRaporCiktisi.GetCellDeger(i,4)-frmRaporCiktisi.GetCellDeger(i,3)));
      frmRaporCiktisi.format_ayarla(6,i,6,i);
    end
    else
    begin                        //  borc = alacak
      frmRaporCiktisi.SetCellText(i,5,'0');
      frmRaporCiktisi.format_ayarla(5,i,5,i);
      frmRaporCiktisi.SetCellText(i,6,'0');
      frmRaporCiktisi.format_ayarla(6,i,6,i);
    end;
  end;
}
  topla;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.HareketiOlmayanlariTopla;
var
  SubeID,strSQL : String;
begin
  if (Length(trim(txtCariKod1.Text))<>0) and (Length(Trim(txtCariKod2.Text))<>0) then
  begin
    strSQL := 'SELECT CARI_KOD,CARI_AD,DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI'
            + ' WHERE'
            + ' CARI.CARI_KOD NOT IN (SELECT DISTINCT CARIHAR.CARI_KOD FROM CARIHAR)'
            + ' AND CARI.CARI_KOD BETWEEN ' + SQL_Katar(txtCariKod1.Text) + ' AND ' + SQL_Katar(txtCariKod2.Text);
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        strSQL := strSQL + ' AND CARI.CARI_SID = '+ SubeID;
      end;
    end
    else
    begin
      strSQL := strSQL + ' AND CARI.CARI_SID = '+ inttostr(glb_SID);
    end;
    strSQL := strSQL + ' ORDER BY CARI.CARI_KOD';
  end
  else
  begin
    if Length(Trim(txtCariKod1.Text))<>0 then
    begin
      strSQL := 'SELECT CARI_KOD,CARI_AD,DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI'
              + ' WHERE'
              + ' CARI.CARI_KOD NOT IN (SELECT DISTINCT CARIHAR.CARI_KOD FROM CARIHAR)'
              + ' AND CARI.CARI_KOD = ' + SQL_Katar(txtCariKod1.Text);
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND CARI.CARI_SID = '+ SubeID;
        end;
      end
      else
      begin
        strSQL := strSQL + ' AND CARI.CARI_SID = '+ inttostr(glb_SID);
      end;
      strSQL := strSQL + ' ORDER BY CARI.CARI_KOD';
    end
    else
    begin
      strSQL := 'SELECT CARI_KOD,CARI_AD,DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI'
               +' WHERE'
               +' CARI.CARI_KOD NOT IN (SELECT DISTINCT CARIHAR.CARI_KOD FROM CARIHAR)';
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND CARI.CARI_SID = '+ SubeID;
        end;
      end
      else
      begin
        strSQL := strSQL + ' AND CARI.CARI_SID = '+ inttostr(glb_SID);
      end;
      strSQL := strSQL + ' ORDER BY CARI.CARI_KOD';
    end;
  end;

  with qryCariHareket do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((qryCariHareket.Eof) and (qryCariHareket.Bof))then
  begin
    qryCariHareket.Active := False;
    exit;
  end;

  inc(row,3);
  col := 1;

  frmRaporCiktisi.SetCellText(row,col,'Hareket kaydý bulunmayan fakat devir bakiyesi bulunan cariler');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);

  inc(row);
  col := 0;

  frmRaporCiktisi.SetCellText(row,col,'Cari Kod');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

  frmRaporCiktisi.SetCellText(row,col+1,'Cari Ad');
  frmRaporCiktisi.SetCellFont(col+1,row,col+1,row,[fsBold],8,'MS Sans Serif',4);

  frmRaporCiktisi.SetCellText(row,col+2,'Devreden Borç');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',4);

  frmRaporCiktisi.SetCellText(row,col+3,'Devreden Alacak');
  frmRaporCiktisi.SetCellFont(col+3,row,col+3,row,[fsBold],8,'MS Sans Serif',4);

  inc(row);

  qryCariHareket.First;
  while not qryCariHareket.Eof do
  begin
    inc(row);
    col :=  0;


    DataMod.Rapor_Satir_Renklendir(col,row,5);

    frmRaporCiktisi.SetCellText(row,col,qryCariHareket.FieldByName('CARI_KOD').AsString);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryCariHareket.FieldByName('CARI_AD').AsString);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryCariHareket.FieldByName('DEVREDEN_BORC').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryCariHareket.FieldByName('DEVREDEN_ALACAK').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);

    qryCariHareket.Next;
  end;//end while not qryCariHareket.Eof do
end;

procedure TfrmRaporCariBakiyeliHareketToplam.Alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Cari Kod');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

  frmRaporCiktisi.SetCellText(row,col+1,'Cari Ad');
  frmRaporCiktisi.SetCellFont(col+1,row,col+1,row,[fsBold],8,'MS Sans Serif',4);

  frmRaporCiktisi.SetCellText(row,col+2,'Borç');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',4);

  frmRaporCiktisi.SetCellText(row,col+3,'Alacak');
  frmRaporCiktisi.SetCellFont(col+3,row,col+3,row,[fsBold],8,'MS Sans Serif',4);

  frmRaporCiktisi.SetCellText(row,col+4,'Borç Bakiyesi');
  frmRaporCiktisi.SetCellFont(col+4,row,col+4,row,[fsBold],8,'MS Sans Serif',4);

  frmRaporCiktisi.SetCellText(row,col+5,'Alacak Bakiyesi');
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',4);
end;


procedure TfrmRaporCariBakiyeliHareketToplam.topla;
begin
  inc(row);

  col := 2;

  frmRaporCiktisi.SetCellText(row+1,col,'=SUM(D3:D'+IntToStr(row)+')');
  frmRaporCiktisi.SetCellFont(col,row+1,col,row+1,[],8,'MS Sans Serif',2);
  frmRaporCiktisi.format_ayarla(col,row+1,col,row+1);
  inc(col);

  frmRaporCiktisi.SetCellText(row+1,col,'=SUM(E3:E'+IntToStr(row)+')');
  frmRaporCiktisi.SetCellFont(col,row+1,col,row+1,[],8,'MS Sans Serif',2);
  frmRaporCiktisi.format_ayarla(col,row+1,col,row+1);
  inc(col);

  frmRaporCiktisi.SetCellText(row+1,col,'=SUM(F3:F'+IntToStr(row)+')');
  frmRaporCiktisi.SetCellFont(col,row+1,col,row+1,[],8,'MS Sans Serif',2);
  frmRaporCiktisi.format_ayarla(col,row+1,col,row+1);
  inc(col);

  frmRaporCiktisi.SetCellText(row+1,col,'=SUM(G3:G'+IntToStr(row)+')');
  frmRaporCiktisi.SetCellFont(col,row+1,col,row+1,[],8,'MS Sans Serif',2);
  frmRaporCiktisi.format_ayarla(col,row+1,col,row+1);
end;

procedure TfrmRaporCariBakiyeliHareketToplam.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporCariBakiyeliHareketToplam);
end;

procedure TfrmRaporCariBakiyeliHareketToplam.txtCariKod1Enter(Sender: TObject);
begin
  txtCariKod1.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.txtCariKod2Enter(Sender: TObject);
begin
  txtCariKod2.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.dtpIslemTar1Enter(Sender: TObject);
begin
  (sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.dtpIslemTar1Exit(Sender: TObject);
begin
  (sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.chk_devirEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.chk_devirExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmRaporCariBakiyeliHareketToplam.txtGrpKodEnter(
  Sender: TObject);
begin
  txtGrpKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.txtGrpKodExit(Sender: TObject);
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
    Application.MessageBox('Girdiðiniz cari grup kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    txtGrpKod.Clear;
    txtGrpKod.SetFocus;
  end
  else
  begin
    txtGrpKod.Color := clWindow;
  end;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.txtGrpKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then
  begin
    btnCariGrpListeClick(Self);
  end;
end;

procedure TfrmRaporCariBakiyeliHareketToplam.txtGrpKodKeyPress(
  Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporCariBakiyeliHareketToplam.btnCariGrpListeClick(
  Sender: TObject);
var
  KOD,AD : String;
begin
  if DataMod.LS_CariGroup(KOD,AD) then
  begin
    txtGrpKod.Text := KOD;
  end;
end;



procedure TfrmRaporCariBakiyeliHareketToplam.frxReport1BeforePrint(
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

end.
