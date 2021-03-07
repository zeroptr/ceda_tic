{$INCLUDE directive.inc}

unit ufrmRaporGenelCariListesi;

interface

 uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, ExtCtrls, IB_Components, ComCtrls, 
 Buttons, frxClass, frxIBOSet,cxSSTypes,cxSSHeaders, DB;

type
  TfrmRaporGenelCariListesi = class(TForm)
    qryCari_CariDov: TIB_Cursor;
    qryGrup_GrupUye: TIB_Cursor;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    Label3: TLabel;
    cmbGrup: TComboBox;
    cmb_sirala: TComboBox;
    chkDEVIR: TCheckBox;
    GroupBox1: TGroupBox;
    txtCariKod2: TEdit;
    txtCariKod1: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    cmbTip: TComboBox;
    cmb_yurtdisi: TComboBox;
    GroupBox4: TGroupBox;
    cmbParaBirimi: TComboBox;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    GroupBox5: TGroupBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    txtGrpKod: TEdit;
    btnCariGrpListe: TButton;
    frxReport1: TfrxReport;
    frxIBOCarilis: TfrxIBODataset;
    IB_Query1: TIB_Query;
    Btn_Fast: TButton;
    cbBakiye: TCheckBox;
    Label1: TLabel;
    cmb_Bakiye: TComboBox;
    Cb_Cari_Tipi: TCheckBox;
    cb_Firma_Tipi: TCheckBox;
    chk_Sefer: TCheckBox;
    chk_Mazot: TCheckBox;
    Label4: TLabel;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure gruplama_yapma_baslik_ekle;
    procedure cari_gruba_uye_olmayanlar;
    procedure frmRaporCiktisi_Open(CaristrSQL:String;GrupstrSQL:String);
    procedure yaz();
    procedure Rapora_Gruplulari_Ekle;
    procedure Rapora_Grupsuzlari_Ekle;
    procedure GrupBazindaCariListesi;
////////////////////////////////////////////////////////////////////////////////
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRaporClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure txtCariKod1KeyPress(Sender: TObject; var Key: Char);
    procedure txtCariKod2KeyPress(Sender: TObject; var Key: Char);
    procedure txtCariKod1Exit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtCariKod1Enter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure cmbTipEnter(Sender: TObject);
    procedure cmbTipExit(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure btnCariGrpListeClick(Sender: TObject);
    procedure txtGrpKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtGrpKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtGrpKodExit(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure Btn_FastClick(Sender: TObject);
//***********************************
//***********************************
  private
    { Private declarations }
    row,col:integer;
    grup_adi : string;
    Prv_Yazdirildi:Boolean;
    procedure Yazy;
  public
    { Public declarations }
    Kontrol:Boolean;
  end;

  const cns_genel_cari_listesi = 2;

var
  frmRaporGenelCariListesi: TfrmRaporGenelCariListesi;

implementation

uses unDataMod,ufrmRaporCiktisi,unFunc,ufrmCariSDLG,main;

{$R *.dfm}

procedure TfrmRaporGenelCariListesi.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_genel_cari_listesi,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporGenelCariListesi') then
    begin
      Application.CreateForm(TfrmRaporGenelCariListesi,frmRaporGenelCariListesi);
      with frmRaporGenelCariListesi do
      begin
        PageControl1.ActivePageIndex := 0;
        cmbParaBirimi.Items.Add(glb_DEFCUR);
        cmbParaBirimi.Items.AddStrings(glb_TAK_DOV_LIST);
        cmbParaBirimi.ItemIndex := 0;
      end;

      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporGenelCariListesi.cmbSube.Items);
          with frmRaporGenelCariListesi do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporGenelCariListesi.cmbSube do
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
        frmRaporGenelCariListesi.grpSube.Visible := False;
      end;//end if glb_SUBELI then

    end;//if not MainForm.FindChildFrm
  end;//dll datamod modul hak
end;

procedure TfrmRaporGenelCariListesi.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporGenelCariListesi.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmRaporGenelCariListesi.btnRaporClick(Sender: TObject);
var
  cari_where_ek,cari_sec_sql : Boolean;
  CaristrSQL,CariSQLSelect,CariSQLWhere,CariSQLFrom,CariSQLJoin,CariSQLOrderBy,CariSQLBetween:String;
  GrupstrSQL,GrupSQLSelect,GrupSQLWhere,GrupSQLFrom,GrupSQLJoin,GrupSQLOrderBy:String;
  SubeID : String;
  CHeader : TcxSSHeader;
begin

//eski_kods

  if Length(Trim(txtGrpKod.Text))<> 0 then
  begin
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    GrupBazindaCariListesi;
    CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
    CHeader.Size[1] := 350;
    CHeader.Size[2] := 120;
    frmRaporCiktisi.SetCellFormat(0,3,0,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    frmRaporCiktisi.SetCellAlignment(0,3,0,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haLEFT,vaCenter);
    frmRaporCiktisi.SetCellAlignment(2,2,2,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haRight,vaCenter);
     frmRaporCiktisi.SetCellAlignment(5,5,6,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haRIGHT,vaCenter);
    //frmRaporCiktisi.SetCellAlignment(5,2,6,2,haRight,vaCenter);
    frmRaporCiktisi.Rapor_Ayarlari(2);
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.grdA.ActivePage := 0;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryCari_CariDov.Close;
    qryGrup_GrupUye.Close;
    exit;
  end;

  cari_where_ek := false;
  if (cmbParaBirimi.Text <> glb_DEFCUR) then
  begin
    if chkDEVIR.Checked then
    begin
      if cmbParaBirimi.Text = 'TRL' then
      begin
        CariSQLSelect := 'SELECT CARI.CARI_AD,CARI.CARI_KOD,CARI.ILCE,CARI.SEHIR,((CARI_DOV.BORC)+(CARI.DEVREDEN_BORC*1000000)) AS DOV_BORC ,((CARI_DOV.ALACAK)+(CARI.DEVREDEN_ALACAK*1000000)) AS DOV_ALACAK';
        CariSQLFrom   := ' FROM CARI';
        CariSQLJoin   := ' LEFT OUTER JOIN CARI_DOV ON (CARI.CARI_KOD = CARI_DOV.CARI_KOD)';
      end
      else
      begin
        CariSQLSelect := 'SELECT CARI.CARI_AD,CARI.CARI_KOD,CARI.ILCE,CARI.SEHIR,(CARI_DOV.BORC+CARI_DOV.DEVREDEN_BORC) AS DOV_BORC ,(CARI_DOV.ALACAK+CARI_DOV.DEVREDEN_ALACAK) AS DOV_ALACAK';
        CariSQLFrom   := ' FROM CARI';
        CariSQLJoin   := ' LEFT OUTER JOIN CARI_DOV ON (CARI.CARI_KOD = CARI_DOV.CARI_KOD)';
      end;
    end
    else
    begin
      CariSQLSelect := 'SELECT CARI.CARI_AD,CARI.CARI_KOD,CARI.ILCE,CARI.SEHIR,CARI.BORC,CARI.ALACAK,CARI_DOV.BORC AS DOV_BORC ,CARI_DOV.ALACAK AS DOV_ALACAK';
      CariSQLFrom :=   ' FROM CARI';
      CariSQLJoin :=   ' LEFT OUTER JOIN CARI_DOV ON (CARI.CARI_KOD = CARI_DOV.CARI_KOD)';
    end;
  end
  else
  begin
    if chkDEVIR.Checked then
    begin
      CariSQLSelect := 'SELECT CARI.CARI_AD,CARI.CARI_KOD,CARI.ILCE,CARI.SEHIR,(CARI.BORC+CARI.DEVREDEN_BORC) AS BORC,(CARI.ALACAK+CARI.DEVREDEN_ALACAK) AS ALACAK';
      CariSQLFrom :=   ' FROM CARI';
      CariSQLJoin :=   '';
    end
    else
    begin
      CariSQLSelect := 'SELECT CARI.CARI_AD,CARI.CARI_KOD,CARI.ILCE,CARI.SEHIR,CARI.BORC,CARI.ALACAK';
      CariSQLFrom :=   ' FROM CARI';
      CariSQLJoin :=   '';
    end;
  end;

  cari_sec_sql := true;
  case cmbGrup.ItemIndex of
  0:
    begin
      GrupSQLSelect  := 'SELECT CARI_GRUP.CGADI,CARI_GRUP_UYE.CARI_KOD';
      GrupSQLFrom    := ' FROM CARI_GRUP_UYE';
      GrupSQLJoin    := ' LEFT OUTER JOIN CARI_GRUP ON (CARI_GRUP.CARI_GRUP_KOD=CARI_GRUP_UYE.CARI_GRUP_KOD)';
      GrupSQLWhere   := ' WHERE CARI_GRUP_UYE.VARSAY = 1 ';
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          GrupSQLWhere := GrupSQLWhere + ' AND CARI_GRUP.CARI_GRUP_SID = '+ SubeID;
        end;
      end
      else
      begin
        GrupSQLWhere := GrupSQLWhere + ' AND CARI_GRUP.CARI_GRUP_SID = '+ inttostr(glb_SID);
      end;
      GrupSQLOrderBy := ' ORDER BY CARI_GRUP.CGADI';
      GrupstrSQL     := GrupSQLSelect+GrupSQLFrom+GrupSQLJoin+GrupSQLWhere+GrupSQLOrderBy;
    end;
  1:
    begin
      if chkDEVIR.Checked then
      begin
        CariSQLSelect := 'SELECT CARI.CARI_KOD,CARI.CARI_AD,CARI.ILCE,CARI.SEHIR,(CARI.BORC+CARI.DEVREDEN_BORC) AS BORC,(CARI.ALACAK+CARI.DEVREDEN_ALACAK) AS ALACAK,';
        CariSQLSelect := CariSQLSelect + '(CARI_DOV.BORC+CARI_DOV.DEVREDEN_BORC) AS DOV_BORC,(CARI_DOV.ALACAK+CARI_DOV.DEVREDEN_ALACAK) AS DOV_ALACAK';
        CariSQLFrom   :=   ' FROM CARI ';
        CariSQLJoin   := ' LEFT OUTER JOIN CARI_DOV ON (CARI_DOV.CARI_KOD=CARI.CARI_KOD)';
        CariSQLWhere  :=  ' WHERE NOT EXISTS (SELECT CARI_GRUP_UYE.CARI_GRUP_KOD FROM CARI_GRUP_UYE WHERE (CARI_GRUP_UYE.CARI_KOD=CARI.CARI_KOD))';
        cari_where_ek := true;
      end
      else
      begin
        CariSQLSelect := 'SELECT CARI.CARI_KOD,CARI.CARI_AD,CARI.ILCE,CARI.SEHIR,CARI.BORC,CARI.ALACAK,CARI_DOV.ALACAK AS DOV_ALACAK,CARI_DOV.BORC AS DOV_BORC';
        CariSQLFrom   :=   ' FROM CARI ';
        CariSQLJoin   := ' LEFT OUTER JOIN CARI_DOV ON (CARI_DOV.CARI_KOD=CARI.CARI_KOD)';
        CariSQLWhere  :=  ' WHERE NOT EXISTS (SELECT CARI_GRUP_UYE.CARI_GRUP_KOD FROM CARI_GRUP_UYE WHERE (CARI_GRUP_UYE.CARI_KOD=CARI.CARI_KOD))';
        cari_where_ek := true;
      end;
    end;
  2:
    begin
      GrupSQLSelect  := '';
      GrupSQLFrom    := '';
      GrupSQLWhere   := '';
      GrupSQLJoin    := '';
      GrupSQLOrderBy := '';
      GrupstrSQL     := '';
    end;
  end;
  //******************************************************************************************************
  if glb_SUBELI then
  begin
    if cari_where_ek then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        CariSQLWhere := CariSQLWhere + ' AND CARI.CARI_SID = '+ SubeID;
      end;
    end
    else
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        CariSQLWhere := CariSQLWhere + ' WHERE CARI.CARI_SID = '+ SubeID;
        cari_where_ek := True;
      end;
    end;
  end
  else
  begin
    if cari_where_ek then
    begin
      CariSQLWhere := CariSQLWhere + ' AND CARI.CARI_SID = '+ inttostr(glb_SID);
    end
    else
    begin
      CariSQLWhere := CariSQLWhere + ' WHERE CARI.CARI_SID = '+ inttostr(glb_SID);
      cari_where_ek := True;
    end;
  end;

  if Cb_Cari_Tipi.Checked then
  case cmbtip.ItemIndex of
  0:  //alýcý
    begin
      if cari_where_ek then
      begin
        CariSQLWhere := CariSQLWhere + ' AND CARI.TIP = 1 ';
      end
      else
      begin
        CariSQLWhere := ' WHERE ';
        CariSQLWhere := CariSQLWhere + ' CARI.TIP = 1 ';
        cari_where_ek := true;
      end;
    end;
  1: //satýcý
    begin
      if cari_where_ek then
      begin
        CariSQLWhere := CariSQLWhere + ' AND CARI.TIP = 2 ';
      end
      else
      begin
        CariSQLWhere := ' WHERE ';
        CariSQLWhere := CariSQLWhere + ' CARI.TIP = 2 ';
        cari_where_ek := true;
      end;
    end;
  2://banka
    begin
      if cari_where_ek then
      begin
        CariSQLWhere := CariSQLWhere + ' AND CARI.TIP = 3 ';
      end
      else
      begin
        CariSQLWhere := ' WHERE ';
        CariSQLWhere := CariSQLWhere + ' CARI.TIP = 3 ';
        cari_where_ek := true;
      end;
    end;
  3://diðer
    begin
      if cari_where_ek then
      begin
        CariSQLWhere := CariSQLWhere + ' AND CARI.TIP = 4 ';
      end
      else
      begin
        CariSQLWhere := ' WHERE ';
        CariSQLWhere := CariSQLWhere + ' CARI.TIP = 4 ';
        cari_where_ek := true;
      end;
    end;
  4://diðer
    begin
      if cari_where_ek then
      begin
        CariSQLWhere := CariSQLWhere + ' AND CARI.TIP = 5 ';
      end
      else
      begin
        CariSQLWhere := ' WHERE ';
        CariSQLWhere := CariSQLWhere + ' CARI.TIP = 5 ';
        cari_where_ek := true;
      end;
    end;

  5: //hepsi
    begin
      if cari_where_ek then
      begin
      end
      else
      begin
        CariSQLWhere := '';
        cari_where_ek := false;
      end;
    end;
  end;
//*********************************************************************************************************
  if (cmbParaBirimi.Text <> glb_DEFCUR) then
  begin
    if cmbParaBirimi.Text <> 'TRL' then
    begin
      if cari_where_ek then
      begin
        CariSQLWhere := CariSQLWhere + ' AND CARI_DOV.DOVKOD = '+ SQL_Katar(cmbParaBirimi.Text);
      end
      else
      begin
        CariSQLWhere := ' WHERE ';
        CariSQLWhere := CariSQLWhere + ' CARI_DOV.DOVKOD = '+ SQL_Katar(cmbParaBirimi.Text);
        cari_where_ek := true;
      end;
    end;
  end;
//******************************************************************************
  if cb_Firma_Tipi.Checked then
  case cmb_yurtdisi.ItemIndex of
  0:
    begin
      if cari_where_ek then
      begin
        CariSQLWhere := CariSQLWhere + ' AND CARI.YURTDISI = 0 ';
      end
      else
      begin
        CariSQLWhere := ' WHERE ';
        CariSQLWhere := CariSQLWhere + ' CARI.YURTDISI = 0 ';
        cari_where_ek := true;
      end;
    end;
  1:
    begin
      if cari_where_ek then
      begin
        CariSQLWhere := CariSQLWhere + ' AND CARI.YURTDISI = 1 ';
      end
      else
      begin
        CariSQLWhere := ' WHERE ';
        CariSQLWhere := CariSQLWhere + ' CARI.YURTDISI = 1 ';
        cari_where_ek := true;
      end;
    end;
  2:
    begin
    end;
  end;
//******************************************************************************
  case cmb_sirala.ItemIndex of
  0:
    begin
      CariSQLOrderBy := ' ORDER BY CARI.CARI_KOD ';
    end;
  1:
    begin
      CariSQLOrderBy := ' ORDER BY CARI.CARI_AD ';
    end;
  end;




      if cari_where_ek then
      begin

      end
      else
      begin
        CariSQLWhere := ' WHERE cari.Cari_kod<>'''' ' ;
        cari_where_ek := true;
      end;

     if cmbParaBirimi.Text=glb_DEFCUR then
     begin
          if cbBakiye.checked then
          if chkDEVIR.Checked then
          CariSQLWhere:=CariSQLWhere+
          ' and (cari.borc>0 or cari.devreden_borc>0 or '+
          'cari.Alacak>0 or cari.devreden_Alacak>0) ';

          if cbBakiye.checked then
          if not chkDEVIR.Checked then
          CariSQLWhere:=CariSQLWhere+
          ' and (cari.borc>0 or '+
          'cari.Alacak>0) ';
     end
     else
     begin
          if cbBakiye.checked then
          if chkDEVIR.Checked then
          CariSQLWhere:=CariSQLWhere+
          ' and (cari_dov.bor>0 or cari_dov.devreden_borc>0 or '+
          'cari_dov.Alacak>0 or cari_dov.devreden_Alacak>0) ';

          if cbBakiye.checked then
          if not chkDEVIR.Checked then
          CariSQLWhere:=CariSQLWhere+
          ' and (cari_dov.borc>0 or  '+
          'cari_dov.Alacak>0) ';
     end;




     if (cmb_Bakiye.itemIndex=0) or (cmb_Bakiye.itemIndex=1) then
     if cmbParaBirimi.Text=glb_DEFCUR then
     begin
          if chkDEVIR.Checked then
          begin
              if cmb_Bakiye.itemIndex=0 then
              CariSQLWhere:=CariSQLWhere+ ' and (cari.borc+cari.devreden_borc>cari.Alacak+cari.devreden_Alacak) ';
              if cmb_Bakiye.itemIndex=1 then
              CariSQLWhere:=CariSQLWhere+ ' and (cari.Alacak+cari.devreden_Alacak>cari.borc+cari.devreden_borc) ';

          end
          else
          begin
              if cmb_Bakiye.itemIndex=0 then
              CariSQLWhere:=CariSQLWhere+ ' and (cari.borc>cari.Alacak) ';
              if cmb_Bakiye.itemIndex=1 then
              CariSQLWhere:=CariSQLWhere+ ' and (cari.Alacak>cari.borc) ';

          end;
     end
     else
     begin
          if chkDEVIR.Checked then
          begin
             if cmb_Bakiye.itemIndex=0 then
             CariSQLWhere:=CariSQLWhere+ ' and (cari_dov.borc+cari_dov.devreden_borc>cari_dov.Alacak+cari_dov.devreden_Alacak) ';
             if cmb_Bakiye.itemIndex=1 then
             CariSQLWhere:=CariSQLWhere+ ' and (cari_dov.Alacak+cari_dov.devreden_Alacak>cari_dov.borc+cari_dov.devreden_borc) ';

          end
          else
          begin
             if cmb_Bakiye.itemIndex=0 then
             CariSQLWhere:=CariSQLWhere+ ' and (cari_dov.borc>cari_dov.Alacak) ';
             if cmb_Bakiye.itemIndex=1 then
             CariSQLWhere:=CariSQLWhere+ ' and (cari_dov.Alacak>cari_dov.borc) ';

          end;
     end;


//******************************************************************************
//******************************************************************************
  if  (((Length(trim(txtCariKod1.Text))=0) or (Length(trim(txtCariKod2.Text))=0)) and (cmbGrup.ItemIndex=2)) then
  begin
    if cari_sec_sql then
    begin
      CaristrSQL := CariSQLSelect+CariSQLFrom+CariSQLJoin+CariSQLWhere+CariSQLOrderBy;
      cari_sec_sql := false;
    end;
  end;

  if  (((Length(trim(txtCariKod1.Text))=0) or (Length(trim(txtCariKod2.Text))=0)) and (cmbGrup.ItemIndex<>2)) then
  begin
    if cari_sec_sql then
    begin
      CaristrSQL := CariSQLSelect+CariSQLFrom+CariSQLJoin+CariSQLWhere+CariSQLOrderBy;
      cari_sec_sql := false;
    end;
  end;


  if ( (Length(trim(txtCariKod1.Text))=0) and (Length(trim(txtCariKod2.Text))=0) and (cmbGrup.ItemIndex<>2) ) then
  begin
    if cari_sec_sql then
    begin
      CaristrSQL := CariSQLSelect+CariSQLFrom+CariSQLJoin+CariSQLWhere+CariSQLOrderBy;
      cari_sec_sql := false;
    end;
  end;

  if ( (Length(Trim(txtCariKod1.Text))=0) and (Length(Trim(txtCariKod2.Text))=0) and (cmbGrup.ItemIndex=2) ) then
  begin
    if not cari_where_ek then
    begin
      if cari_sec_sql then
      begin
        CaristrSQL := CariSQLSelect+CariSQLFrom+CariSQLJoin+CariSQLOrderBy;
        cari_sec_sql := false;
      end;
    end
    else
    begin
      if cari_sec_sql then
      begin
        CaristrSQL := CariSQLSelect+CariSQLFrom+CariSQLJoin+CariSQLWhere+CariSQLOrderBy;
        cari_sec_sql := false;
      end;
    end;
  end;

  if ( (Length(Trim(txtCariKod1.Text))<>0) and (Length(Trim(txtCariKod2.Text))<>0) and (cmbGrup.ItemIndex<>2) ) then
  begin
    if cari_where_ek then
    begin
      CariSQLBetween := ' AND CARI.CARI_KOD BETWEEN '+SQL_Katar(txtCariKod1.Text)+' AND '+SQL_Katar(txtCariKod2.Text);
    end
    else
    begin
      CariSQLBetween := ' WHERE CARI.CARI_KOD BETWEEN '+SQL_Katar(txtCariKod1.Text)+' AND '+SQL_Katar(txtCariKod2.Text);
    end;

    if cari_sec_sql then
    begin
      CaristrSQL := CariSQLSelect+CariSQLFrom+CariSQLJoin+CariSQLWhere+CariSQLBetween+CariSQLOrderBy;
      cari_sec_sql := false;
    end;
  end;

  if ( (Length(Trim(txtCariKod1.Text))<>0) and (Length(Trim(txtCariKod2.Text))<>0) and (cmbGrup.ItemIndex=2) )then
  begin
    if cari_where_ek then
    begin
      CariSQLBetween := ' AND CARI.CARI_KOD BETWEEN '+SQL_Katar(txtCariKod1.Text)+ ' AND '+SQL_Katar(txtCariKod2.Text);
    end
    else
    begin
      CariSQLBetween := ' WHERE CARI.CARI_KOD BETWEEN '+SQL_Katar(txtCariKod1.Text)+ ' AND '+SQL_Katar(txtCariKod2.Text);
    end;
    if cari_sec_sql then
    begin
      CaristrSQL := CariSQLSelect+CariSQLFrom+CariSQLJoin+CariSQLWhere+CariSQLBetween+CariSQLOrderBy;
    end;
  end;


     if sender=Btn_Fast then
     begin

     end;










  frmRaporCiktisi_Open(CaristrSQL,GrupstrSQL);
end;

procedure TfrmRaporGenelCariListesi.GrupBazindaCariListesi;
var
  SubeID : String;
  res_Cari : TStringList;
begin
  with qryGrup_GrupUye do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT CARI.CARI_KOD,CARI.CARI_AD,CARI.ILCE,CARI.SEHIR,CARI_GRUP.CGADI');
//****************************************************************************//
    if chkDEVIR.checked then
    begin
      if cmbParaBirimi.Text <> glb_DEFCUR then
      begin
        SQL.Add(',(CARI_DOV.BORC+CARI_DOV.DEVREDEN_BORC) AS BORC ,(CARI_DOV.ALACAK+CARI_DOV.DEVREDEN_ALACAK) AS ALACAK');
      end
      else
      begin
        SQL.Add(',(CARI.BORC+CARI.DEVREDEN_BORC) AS BORC,(CARI.ALACAK+CARI.DEVREDEN_ALACAK) AS ALACAK');
      end;
    end
    else
    begin
      if cmbParaBirimi.Text <> glb_DEFCUR then
      begin
        SQL.Add(',CARI_DOV.BORC,CARI_DOV.ALACAK');
      end
      else
      begin
        SQL.Add(',CARI.BORC,CARI.ALACAK');
      end;
    end;
//****************************************************************************//
    SQL.Add('FROM CARI');
    SQL.Add('LEFT OUTER JOIN CARI_GRUP_UYE ON (CARI_GRUP_UYE.CARI_KOD=CARI.CARI_KOD)');
    SQL.Add('LEFT OUTER JOIN CARI_GRUP ON (CARI_GRUP.CARI_GRUP_KOD=CARI_GRUP_UYE.CARI_GRUP_KOD)');
    if cmbParaBirimi.Text <> glb_DEFCUR then
       SQL.Add('LEFT OUTER JOIN CARI_DOV ON (CARI.CARI_KOD = CARI_DOV.CARI_KOD)');
//****************************************************************************//
    SQL.Add('WHERE CARI_GRUP.CARI_GRUP_KOD = '+SQL_Katar(txtGrpKod.Text));
//****************************************************************************//
    if cmbTip.ItemIndex <> 4 then
       SQL.Add('AND CARI.TIP = '+inttostr(cmbTip.ItemIndex+1));
//****************************************************************************//
    if cmb_yurtdisi.ItemIndex <> 2 then
       SQL.Add('AND CARI.YURTDISI = '+inttostr(cmb_yurtdisi.ItemIndex));
//****************************************************************************//
    if (cmbParaBirimi.Text <> glb_DEFCUR) then
       SQL.Add(' AND CARI_DOV.DOVKOD = '+ SQL_Katar(cmbParaBirimi.Text));
//****************************************************************************//

    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        SQL.Add(' AND CARI_GRUP.CARI_GRUP_SID = '+ SubeID);
      end;
    end
    else
    begin
      SQL.Add(' AND CARI_GRUP.CARI_GRUP_SID = '+ inttostr(glb_SID));
    end;
    Open;
  end;
//****************************************************************************//
  if ((qryGrup_GrupUye.Eof) and (qryGrup_GrupUye.Bof)) then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz','Dikkat',MB_ICONWARNING);
    qryGrup_GrupUye.Active := False;
    exit;
  end;
//****************************************************************************//
  row := 0;
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 0;
  end;
//****************************************************************************//
  frmRaporCiktisi.SetCellText(0,5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(5,0,5,0,[fsBold],8,'MS Sans Serif',0);
//****************************************************************************//
  frmRaporCiktisi.SetCellText(row,col+2,txtGrpKod.Text + ' Gruba Ait Cari Listesi');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);

  inc(row);
  col := 0;

  frmRaporCiktisi.SetCellText(row,col,'Döviz Tipi :');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

  col := 1;

  frmRaporCiktisi.SetCellText(row,col,cmbParaBirimi.Text);
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
  col := 0;

  Rapora_Gruplulari_Ekle;

  qryGrup_GrupUye.First;
  while not qryGrup_GrupUye.Eof do
  begin
    frmRaporCiktisi.SetCellText(row,col,qryGrup_GrupUye.FieldByName('CARI_KOD').AsString);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryGrup_GrupUye.FieldByName('CARI_AD').AsString);
    Inc(col);
    //cari_format_ayarla;
    frmRaporCiktisi.SetCellText(row,col,qryGrup_GrupUye.FieldByName('ILCE').AsString);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryGrup_GrupUye.FieldByName('SEHIR').AsString);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryGrup_GrupUye.FieldByName('BORC').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryGrup_GrupUye.FieldByName('ALACAK').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    Inc(col);
    if qryGrup_GrupUye.FieldByName('ALACAK').AsCurrency > qryGrup_GrupUye.FieldByName('BORC').AsCurrency then
    begin
      frmRaporCiktisi.SetCellText(row,col,'A');
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryGrup_GrupUye.FieldByName('ALACAK').AsCurrency - qryGrup_GrupUye.FieldByName('BORC').AsCurrency));
      frmRaporCiktisi.format_ayarla(col,row,col,row);
    end
    else
    if qryGrup_GrupUye.FieldByName('ALACAK').AsCurrency < qryGrup_GrupUye.FieldByName('BORC').AsCurrency then
    begin
      frmRaporCiktisi.SetCellText(row,col,'B');
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryGrup_GrupUye.FieldByName('BORC').AsCurrency - qryGrup_GrupUye.FieldByName('ALACAK').AsCurrency));
      frmRaporCiktisi.format_ayarla(col,row,col,row);
    end
    else
    begin
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,'0');
      frmRaporCiktisi.format_ayarla(col,row,col,row);
    end;
    Inc(row);
    col := 0;
    qryGrup_GrupUye.Next;
  end;
end;

procedure TfrmRaporGenelCariListesi.frmRaporCiktisi_Open(CaristrSQL:String;GrupstrSQL:String);
var
  CHeader : TcxSSHeader;
begin
  if (GrupstrSQL<>'') then
  begin
    with qryGrup_GrupUye do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(GrupStrSQL);
      Active := True;
    end;
  end;

  with qryCari_CariDov do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(CaristrSQL);
    Active := True;
  end;

  if ((frmRaporGenelCariListesi.qryCari_CariDov.Eof) and (frmRaporGenelCariListesi.qryCari_CariDov.bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz','Dikkat',MB_ICONWARNING);
    qryCari_CariDov.Active := False;
    exit;
  end
  else
  begin
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    yaz;
    CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
    CHeader.Size[1] := 350;
    CHeader.Size[2] := 120;
    frmRaporCiktisi.SetCellFormat(0,3,0,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    frmRaporCiktisi.SetCellAlignment(0,3,0,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haLEFT,vaCenter);
    frmRaporCiktisi.SetCellAlignment(2,2,2,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haRight,vaCenter);
     frmRaporCiktisi.SetCellAlignment(5,5,6,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haRIGHT,vaCENTER);
    //frmRaporCiktisi.SetCellAlignment(5,2,6,2,haRight,vaCenter);
    frmRaporCiktisi.Rapor_Ayarlari(2);
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.grdA.ActivePage := 0;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryCari_CariDov.Close;
    qryGrup_GrupUye.Close;
  end;
end;


procedure TfrmRaporGenelCariListesi.yaz;
var
  res_Cari : TStringList;
begin
  row := 0;
  col := 0;
  grup_adi := '';
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 0;
  end;

  frmRaporCiktisi.SetCellText(0,5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(5,0,5,0,[fsBold],8,'MS Sans Serif',0);

  frmRaporCiktisi.SetCellText(row,col+2,'CARÝ LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);

  inc(row);
  col := 0;

  frmRaporCiktisi.SetCellText(row,col,'Döviz Tipi :');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

  col := 1;

  frmRaporCiktisi.SetCellText(row,col,cmbParaBirimi.Text);
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
  col := 0;


  case cmbGrup.ItemIndex of
  0:
    begin
      qryGrup_GrupUye.First;
      while not (qryGrup_GrupUye.Eof) do
      begin
        col :=  0;
        //**********************************************************************************
        if (grup_adi<>qryGrup_GrupUye.FieldByName('CGADI').AsString) then
        begin
          if (qryGrup_GrupUye.FieldByName('CGADI').AsString='') then
          begin
            if (grup_adi<>'Diðerleri') then
            begin
              Rapora_Grupsuzlari_Ekle;
            end;
          end
          else
          begin
            Rapora_Gruplulari_Ekle;
          end;
        end;

        col := 0;

        qryCari_CariDov.First;
        //********************************************************************
        while not (qryCari_CariDov.Eof) do
        begin

          DataMod.Rapor_Satir_Renklendir(col,row,7);

          if (qryGrup_GrupUye.FieldByName('CARI_KOD').AsString = qryCari_CariDov.FieldByName('CARI_KOD').AsString) then
          begin
            frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('CARI_KOD').AsString);
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('CARI_AD').AsString);
            Inc(col);
            //cari_format_ayarla;
            frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('ILCE').AsString);
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('SEHIR').AsString);
            Inc(col);
            //cari_format_ayarla;

            if cmbParaBirimi.Text = glb_DEFCUR then
            begin
              frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('BORC').AsString);
              frmRaporCiktisi.format_ayarla(col,row,col,row);
              Inc(col);
              frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('ALACAK').AsString);
              frmRaporCiktisi.format_ayarla(col,row,col,row);
              Inc(col);
              if qryCari_CariDov.FieldByName('ALACAK').AsCurrency > qryCari_CariDov.FieldByName('BORC').AsCurrency then
              begin
                frmRaporCiktisi.SetCellText(row,col,'A');
                Inc(col);
                frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('ALACAK').AsCurrency - qryCari_CariDov.FieldByName('BORC').AsCurrency));
                frmRaporCiktisi.format_ayarla(col,row,col,row);
              end
              else
              if qryCari_CariDov.FieldByName('ALACAK').AsCurrency < qryCari_CariDov.FieldByName('BORC').AsCurrency then
              begin
                frmRaporCiktisi.SetCellText(row,col,'B');
                Inc(col);
                frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('BORC').AsCurrency - qryCari_CariDov.FieldByName('ALACAK').AsCurrency));
                frmRaporCiktisi.format_ayarla(col,row,col,row);
              end
              else
              begin
                Inc(col);
                frmRaporCiktisi.SetCellText(row,col,'0');
                frmRaporCiktisi.format_ayarla(col,row,col,row);
              end;
            end
            else
            begin

              frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('DOV_BORC').AsString);
              frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
              Inc(col);
              frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('DOV_ALACAK').AsString);
              frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
              Inc(col);
              if qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency > qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency then
              begin
                frmRaporCiktisi.SetCellText(row,col,'A');
                Inc(col);
                frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency - qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency));
                frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
              end
              else
              if qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency < qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency then
              begin
                frmRaporCiktisi.SetCellText(row,col,'B');
                Inc(col);
                frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency - qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency));
                frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
              end
              else
              begin
                Inc(col);
                frmRaporCiktisi.SetCellText(row,col,'0');
                frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
              end;
            end;
            Inc(row);
            col := 1;
          end;
          qryCari_CariDov.Next;
        end;//end while not (qryCari_CariDov.Eof) do
        qryGrup_GrupUye.Next;
      end;//end while not (Self.qryGrup_GrupUye.Eof) do
    end;//case of 0 end
  1:
    begin
      cari_gruba_uye_olmayanlar;
    end;//case of 1 end
  2:
    begin
      col := 0;
      gruplama_yapma_baslik_ekle;
      qryCari_CariDov.First;
      //********************************************************************
      while not (qryCari_CariDov.Eof) do
      begin

        DataMod.Rapor_Satir_Renklendir(col,row,7);


        frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('CARI_KOD').AsString);
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('CARI_AD').AsString);
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('ILCE').AsString);
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('SEHIR').AsString);
        Inc(col);
        if cmbParaBirimi.Text = glb_DEFCUR then
        begin
          frmRaporCiktisi.SetCellText(row,col,FormatCurr(glb_DOV_FIELD_PF,qryCari_CariDov.FieldByName('BORC').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          Inc(col);
          frmRaporCiktisi.SetCellText(row,col,FormatCurr(glb_DOV_FIELD_PF,qryCari_CariDov.FieldByName('ALACAK').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          Inc(col);
          if qryCari_CariDov.FieldByName('ALACAK').AsCurrency > qryCari_CariDov.FieldByName('BORC').AsCurrency then
          begin
            frmRaporCiktisi.SetCellText(row,col,'A');
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('ALACAK').AsCurrency - qryCari_CariDov.FieldByName('BORC').AsCurrency));
            frmRaporCiktisi.format_ayarla(col,row,col,row);
          end
          else
          if qryCari_CariDov.FieldByName('ALACAK').AsCurrency < qryCari_CariDov.FieldByName('BORC').AsCurrency then
          begin
            frmRaporCiktisi.SetCellText(row,col,'B');
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('BORC').AsCurrency - qryCari_CariDov.FieldByName('ALACAK').AsCurrency));
            frmRaporCiktisi.format_ayarla(col,row,col,row);
          end
          else
          begin
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,'0');
            frmRaporCiktisi.format_ayarla(col,row,col,row);
          end;
        end
        else
        begin
          frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('DOV_BORC').AsString);
          frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          Inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('DOV_ALACAK').AsString);
          frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          Inc(col);
          if qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency > qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency then
          begin
            frmRaporCiktisi.SetCellText(row,col,'A');
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency - qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency));
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end
          else
          if qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency < qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency then
          begin
            frmRaporCiktisi.SetCellText(row,col,'B');
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency - qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency));
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end
          else
          begin
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,'0');
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
        end;
        Inc(row);
        col := 0;
        qryCari_CariDov.Next;
      end;
    end;//end case of 2
  end;//end case
  inc(row);
//  frmRaporCiktisi.SetCellText(row,5,'=SUM(F4:F5)');
//  frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
end;//end procedure


procedure TfrmRaporGenelCariListesi.cari_gruba_uye_olmayanlar;
begin
  Rapora_Grupsuzlari_Ekle;
//***********************************************************
  qryCari_CariDov.First;
  while not (qryCari_CariDov.Eof) do
  begin
    DataMod.Rapor_Satir_Renklendir(col,row,7);

    frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('CARI_KOD').AsString);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('CARI_AD').AsString);
    Inc(col);
    //cari_format_ayarla;
    frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('ILCE').AsString);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('SEHIR').AsString);

    Inc(col);
    if cmbParaBirimi.Text = glb_DEFCUR then
    begin
      //cari_format_ayarla;
      frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('BORC').AsString);
      Inc(col);
      //cari_format_ayarla;
      frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('ALACAK').AsString);
      Inc(col);

      if qryCari_CariDov.FieldByName('ALACAK').AsCurrency > qryCari_CariDov.FieldByName('BORC').AsCurrency then
      begin
        frmRaporCiktisi.SetCellText(row,col,'A');
        Inc(col);
        //cari_format_ayarla;
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('ALACAK').AsCurrency - qryCari_CariDov.FieldByName('BORC').AsCurrency));
      end
      else
      if qryCari_CariDov.FieldByName('ALACAK').AsCurrency < qryCari_CariDov.FieldByName('BORC').AsCurrency then
      begin
        frmRaporCiktisi.SetCellText(row,col,'B');
        Inc(col);
        //cari_format_ayarla;
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('BORC').AsCurrency - qryCari_CariDov.FieldByName('ALACAK').AsCurrency));
      end
      else
      begin
        Inc(col);
        //cari_format_ayarla;
        frmRaporCiktisi.SetCellText(row,col,'0');
      end;
    end
    else
    begin
      //cari_format_ayarla_dov;
      frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('DOV_BORC').AsString);
      Inc(col);
      //cari_format_ayarla_dov;
      frmRaporCiktisi.SetCellText(row,col,qryCari_CariDov.FieldByName('DOV_ALACAK').AsString);
      Inc(col);
      if qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency > qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency then
      begin
        frmRaporCiktisi.SetCellText(row,col,'A');
        Inc(col);
        //cari_format_ayarla_dov;
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency - qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency));
      end
      else
      if qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency < qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency then
      begin
        frmRaporCiktisi.SetCellText(row,col,'B');
        Inc(col);
        //cari_format_ayarla_dov;
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryCari_CariDov.FieldByName('DOV_BORC').AsCurrency - qryCari_CariDov.FieldByName('DOV_ALACAK').AsCurrency));
      end
      else
      begin
        Inc(col);
        //cari_format_ayarla_dov;
        frmRaporCiktisi.SetCellText(row,col,'0');
      end;
    end;
    Inc(row);
    col := 0;
    qryCari_CariDov.Next;
  end;
//***********************************************************
end;


procedure TfrmRaporGenelCariListesi.Rapora_Gruplulari_Ekle;
begin
  Inc(row);
  grup_adi := qryGrup_GrupUye.FieldByName('CGADI').AsString;
  frmRaporCiktisi.SetCellText(row,col,qryGrup_GrupUye.FieldByName('CGADI').AsString);
  frmRaporCiktisi.SetCellText(row+1,col,'Cari Kod');
  frmRaporCiktisi.SetCellText(row+1,col+1,'Cari Ad');
  frmRaporCiktisi.SetCellText(row+1,col+2,'Ýlçe');
  frmRaporCiktisi.SetCellText(row+1,col+3,'Þehir');
  frmRaporCiktisi.SetCellText(row+1,col+4,'Borç');
  frmRaporCiktisi.SetCellText(row+1,col+5,'Alacak');
  frmRaporCiktisi.SetCellText(row+1,col+6,'B/A');
  frmRaporCiktisi.SetCellText(row+1,col+7,'Bakiye');
  frmRaporCiktisi.SetCellFont(col,row+1,col+7,row+1,[fsBold],8,'MS Sans Serif',4);
  Inc(row,2);
end;

procedure TfrmRaporGenelCariListesi.Rapora_Grupsuzlari_Ekle;
begin
  col := 0;
  Inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Diðerleri');
  frmRaporCiktisi.SetCellText(row+1,col,'Cari Kod');
  frmRaporCiktisi.SetCellText(row+1,col+1,'Cari Ad');
  frmRaporCiktisi.SetCellText(row+1,col+2,'Ýlçe');
  frmRaporCiktisi.SetCellText(row+1,col+3,'Þehir');
  frmRaporCiktisi.SetCellText(row+1,col+4,'Borç');
  frmRaporCiktisi.SetCellText(row+1,col+5,'Alacak');
  frmRaporCiktisi.SetCellText(row+1,col+6,'B/A');
  frmRaporCiktisi.SetCellText(row+1,col+7,'Bakiye');
  frmRaporCiktisi.SetCellFont(col,row+1,col+7,row+1,[fsBold],8,'MS Sans Serif',4);
  Inc(row,2);
  grup_adi := 'Diðerleri';
end;

procedure TfrmRaporGenelCariListesi.gruplama_yapma_baslik_ekle;
begin
  frmRaporCiktisi.SetCellText(row+1,col,'Cari Kod');
  frmRaporCiktisi.SetCellText(row+1,col+1,'Cari Ad');
  frmRaporCiktisi.SetCellText(row+1,col+2,'Ýlçe');
  frmRaporCiktisi.SetCellText(row+1,col+3,'Þehir');
  frmRaporCiktisi.SetCellText(row+1,col+4,'Borç');
  frmRaporCiktisi.SetCellText(row+1,col+5,'Alacak');
  frmRaporCiktisi.SetCellText(row+1,col+6,'B/A');
  frmRaporCiktisi.SetCellText(row+1,col+7,'Bakiye');
  frmRaporCiktisi.SetCellFont(col,row+1,col+7,row+1,[fsBold],8,'MS Sans Serif',4);
  Inc(row,2);
end;

procedure TfrmRaporGenelCariListesi.Button1Click(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) then txtCariKod1.Text := CARI_KOD;
end;

procedure TfrmRaporGenelCariListesi.Button2Click(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) then txtCariKod2.Text := CARI_KOD;
end;

procedure TfrmRaporGenelCariListesi.txtCariKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporGenelCariListesi.txtCariKod2KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporGenelCariListesi.txtCariKod1Exit(Sender: TObject);
var
  CARI_AD : String;
begin
  if Trim((Sender as TEdit).Text)='' then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if not (DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',(Sender as TEdit).Text,Cari_Ad)) then
  begin
    Application.MessageBox('Cari Kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    txtCariKod1.Clear;
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
  end;
end;

procedure TfrmRaporGenelCariListesi.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporGenelCariListesi.txtCariKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporGenelCariListesi.FormKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  case Key Of
    VK_F6:PageControl1.SelectNextPage(True);
  end;
end;

procedure TfrmRaporGenelCariListesi.cmbTipEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporGenelCariListesi.cmbTipExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporGenelCariListesi.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporGenelCariListesi.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporGenelCariListesi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporGenelCariListesi);
  {$IfnDef TRANSPORT}
  chk_Sefer.Visible:=False;
  chk_Mazot.Visible:=False;
  Label4.Visible:=False;
  {$EndIf}
end;

procedure TfrmRaporGenelCariListesi.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporGenelCariListesi.btnCariGrpListeClick(Sender: TObject);
var
  CariGroup_KOD,CariGroup_AD : String;
begin
  if DataMod.LS_CariGroup(CariGroup_KOD,CariGroup_AD) then
  begin
    txtGrpKod.Text := CariGroup_KOD;
  end;
end;

procedure TfrmRaporGenelCariListesi.txtGrpKodKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then
  begin
    btnCariGrpListeClick(Self);
  end;
end;

procedure TfrmRaporGenelCariListesi.txtGrpKodKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporGenelCariListesi.txtGrpKodExit(Sender: TObject);
var
  CariGrpAd : String;
begin
  if Length(Trim(txtGrpKod.Text))=0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if not (DataMod.FN_KOD2AD('CARI_GRUP','CARI_GRUP_KOD','CGADI',txtGrpKod.Text,CariGrpAd)) then
  begin
    txtGrpKod.Clear;
    txtGrpKod.SetFocus;
    Application.MessageBox('Girdiðiniz Cari Grup Kodu Bulunamadý.Lütfen Listeden Seçiniz.','Dikkat',MB_ICONWARNING) ;
    btnCariGrpListeClick(Self);
  end
  else
  begin
    txtGrpKod.Color := clWindow;
  end;
end;

procedure TfrmRaporGenelCariListesi.frxReport1BeforePrint(
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
       c.memo.Text:=DateToStr(date);

       {d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
        }
       Prv_Yazdirildi:=True;
    end;

end;

procedure TfrmRaporGenelCariListesi.Btn_FastClick(Sender: TObject);
var
strSQL,CaristrSQL,SubeID,sql_Toplam,sql_Toplamd:String;
begin
  strSQL := '';

  {$IfDef TRANSPORT}
  if (not chk_Sefer.Checked) AND chk_Mazot.Checked then
  strSQL := ' CARIHAR.BELGE_TUR <> ' + Inttostr(BT_SEFER)+' AND ';
  if (not chk_Mazot.Checked) AND chk_Sefer.Checked then
  strSQL := ' CARIHAR.BELGE_TUR <> ' + Inttostr(BT_MAZOT)+' AND ';

  if (not chk_Mazot.Checked) AND (NOT chk_Sefer.Checked) then
  strSQL := ' CARIHAR.BELGE_TUR <> ' + Inttostr(BT_SEFER)+' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_MAZOT)+' AND ';
  {$EndIf}

sql_Toplam:=' CASE WHEN sum(carihar.Tutar_vpb) IS NULL THEN 0 ELSE sum(carihar.Tutar_vpb) END ';
sql_Toplamd:=' CASE WHEN sum(carihar_dov.Tutar) IS NULL THEN 0 ELSE sum(carihar_dov.Tutar) END ';

     IB_Query1.Close;
     IB_Query1.Sql.Clear;

      CaristrSQL:=
      //'Borc,Alacak,Tip,Bakiye';
      'select '+
      '    cari.cari_kod, '+
      '    cari.cari_ad, '+
      '    cari.ilce, '+
      '    cari.sehir, ';

     if cmbParaBirimi.Text=glb_DEFCUR then
     begin
      if not chkDEVIR.Checked then
      begin
      CaristrSQL:=CaristrSQL+
      '(Select '+sql_Toplam+' from carihar where  Tip=''A'' and '+strSQL+' (cari.cari_kod=carihar.cari_kod)) Alacak, '+
      '( Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod)) Borc, '+

      '    (CASE '+
      '    WHEN (Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))>(Select '+sql_Toplam+' from carihar where  Tip=''A'' and (cari.cari_kod=carihar.cari_kod)) THEN '+
      '    ''B'' '+
      '    WHEN (Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))<(Select '+sql_Toplam+' from carihar where  Tip=''A'' and (cari.cari_kod=carihar.cari_kod)) THEN '+
      '    ''A'' '+
      '    ELSE '+
      '    ''-'' '+
      '    END) Tip, '+

      '    (CASE WHEN '+
      ' (( Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))> '+
      ' ( Select '+sql_Toplam+' from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))) THEN '+
      ' (( Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))- '+
      ' ( Select '+sql_Toplam+' from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))) '+
      ' ELSE '+
      ' (( Select '+sql_Toplam+' from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))- '+
      ' ( Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))) '+
      ' END) BAKIYE ';

      end

      else
      begin
      CaristrSQL:=CaristrSQL+
      '((Select '+sql_Toplam+' from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod)) +cari.devreden_Alacak) Alacak, '+
      '((Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod)) +cari.devreden_Borc) Borc, '+

      '    (CASE '+
      '    WHEN (((Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_borc)>((Select '+sql_Toplam+' from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_Alacak)) THEN '+
      '    ''B'' '+
      '    WHEN (((Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_borc)<((Select '+sql_Toplam+' from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_Alacak)) THEN '+      '    ''A'' '+
      '    ELSE '+
      '    ''-'' '+
      '    END) Tip, '+

      '    (CASE WHEN '+
      ' ((( Select CASE WHEN sum(carihar.Tutar_vpb) IS NULL THEN 0 ELSE sum(carihar.Tutar_vpb) END from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_borc)> '+
      ' (( Select CASE WHEN sum(carihar.Tutar_vpb) IS NULL THEN 0 ELSE sum(carihar.Tutar_vpb) END from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_alacak)) THEN '+

      ' ((( Select CASE WHEN sum(carihar.Tutar_vpb) IS NULL THEN 0 ELSE sum(carihar.Tutar_vpb) END from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_borc)- '+
      ' (( Select CASE WHEN sum(carihar.Tutar_vpb) IS NULL THEN 0 ELSE sum(carihar.Tutar_vpb) END from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_alacak)) '+
      ' ELSE '+
      ' ((( Select CASE WHEN sum(carihar.Tutar_vpb) IS NULL THEN 0 ELSE sum(carihar.Tutar_vpb) END from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_alacak)- '+
      ' (( Select CASE WHEN sum(carihar.Tutar_vpb) IS NULL THEN 0 ELSE sum(carihar.Tutar_vpb) END from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_borc)) '+
      ' END) BAKIYE ';
      end;

     end
     else
     begin


      if not chkDEVIR.Checked then
      begin
      CaristrSQL:=CaristrSQL+
      ' (Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) Alacak, '+
      ' (Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) Borc, '+
      '    (CASE '+
      '    WHEN (Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))> '+
      ' (Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) THEN '+
      '    ''B'' '+
      '    WHEN (Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))< '+
      ' (Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) THEN '+
      '    ''A'' '+
      '    ELSE '+
      '    ''-'' '+
      '    END) Tip, '+
      '(CASE WHEN '+
      '(Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) > '+
      '(Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) THEN '+
      '(Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) - '+
      '(Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) '+
      'ELSE '+
      '(Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) - '+
      '(Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) '+
      'END) BAKIYE ';

       end
       else
       begin
        CaristrSQL:=CaristrSQL+
      '((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) +cari_dov.devreden_Alacak) Alacak,'+
      '((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod)) +cari_dov.devreden_Borc) Borc, '+
      '    (CASE '+
      '    WHEN (((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_borc)> '+
      ' ((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_Alacak)) THEN '+
      '    ''B'' '+
      '    WHEN (((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_borc)< '+
      ' ((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_Alacak)) THEN '+
      '    ''A'' '+
      '    ELSE '+
      '    ''-'' '+
      '    END) Tip, '+
      '(CASE WHEN '+
      '(((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_borc) > '+
      '((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_Alacak)) THEN '+
      '(((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_borc) - '+
      '((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_Alacak)) '+
      'ELSE '+
      '(((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_Alacak) - '+
      '((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_borc)) '+
      'END) BAKIYE ';

       end;

       end;


     CaristrSQL:=CaristrSQL+ ' from cari ';

     {CaristrSQL:=CaristrSQL+
     ' left outer join carihar on (cari.cari_kod=carihar.cari_kod)';
     }

    { if cmbParaBirimi.Text<>glb_DEFCUR then
     CaristrSQL:=CaristrSQL+
     ' left outer join carihar_dov on (cari.cari_kod=carihar_dov.cari_kod)';
    }

     if cmbParaBirimi.Text<>glb_DEFCUR then
     CaristrSQL:=CaristrSQL+
     ' left outer join cari_dov on (cari.cari_kod=cari_dov.cari_kod)';



     if cmbGrup.ItemIndex=0 then
     if Trim(txtGrpKod.Text)<>'' then
     begin
     CaristrSQL:=CaristrSQL+
     ' left outer join cari_grup_uye on (cari.cari_kod=cari_grup_uye.cari_kod)';
     end;


     CaristrSQL:=CaristrSQL+
     ' where Cari.cari_kod<>'''' ';

     if cb_Firma_Tipi.Checked then
     begin

         if cmb_yurtdisi.ItemIndex=0 then
         CaristrSQL:=CaristrSQL+
         ' and cari.yurtdisi=0 ';
         if cmb_yurtdisi.ItemIndex=1 then
         CaristrSQL:=CaristrSQL+
         ' and cari.yurtdisi=1 ';

     end;

     if Cb_Cari_Tipi.Checked then
     if cmbTip.Itemindex<>5 then
     CaristrSQL:=CaristrSQL+
     ' and cari.Tip= '+Inttostr(cmbTip.Itemindex+1);


     if (cmb_Bakiye.itemIndex=0) or (cmb_Bakiye.itemIndex=1)  then
     if cmbParaBirimi.Text=glb_DEFCUR then
     begin
          if chkDEVIR.Checked then
          begin
              if cmb_Bakiye.itemIndex=0 then
              CaristrSQL:=CaristrSQL+ ' and (( Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_borc>( Select '+sql_Toplam+' from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_Alacak) ';
              if cmb_Bakiye.itemIndex=1 then
              CaristrSQL:=CaristrSQL+ ' and (( Select '+sql_Toplam+' from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_Alacak>( Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))+cari.devreden_borc) ';

          end
          else
          begin
              if cmb_Bakiye.itemIndex=0 then
              CaristrSQL:=CaristrSQL+ ' and ( Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))>( Select '+sql_Toplam+' from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod)) ';
              if cmb_Bakiye.itemIndex=1 then
              CaristrSQL:=CaristrSQL+ ' and ( Select '+sql_Toplam+' from carihar where  Tip=''A'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod))>( Select '+sql_Toplam+' from carihar where  Tip=''B'' and  '+strSQL+' (cari.cari_kod=carihar.cari_kod)) ';

          end;
     end
     else
     begin
          if chkDEVIR.Checked then
          begin
             if cmb_Bakiye.itemIndex=0 then
             CaristrSQL:=CaristrSQL+ ' and ((Select '+sql_Toplam+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and  '+strSQL+' carihar_dov.dovkod=:Dov_Kod and '+
             ' (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_borc>(Select '+sql_Toplam+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and  '+strSQL+' '+
             ' carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_Alacak) ';
             if cmb_Bakiye.itemIndex=1 then
             CaristrSQL:=CaristrSQL+ ' and ((Select '+sql_Toplam+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and '+strSQL+'  carihar_dov.dovkod=:Dov_Kod and '+
             ' (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_Alacak>(Select '+sql_Toplam+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and  '+strSQL+' '+
             ' carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))+cari_dov.devreden_borc) ';

          end
          else
          begin
             if cmb_Bakiye.itemIndex=0 then
             CaristrSQL:=CaristrSQL+ ' and ((Select '+sql_Toplam+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and  '+strSQL+' carihar_dov.dovkod=:Dov_Kod and '+
             ' (cari.cari_kod=carihar.cari_kod))>(Select '+sql_Toplam+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and  '+strSQL+' carihar_dov.dovkod=:Dov_Kod and '+
             ' (cari.cari_kod=carihar.cari_kod))) ';
             if cmb_Bakiye.itemIndex=1 then
             CaristrSQL:=CaristrSQL+ ' and ((Select '+sql_Toplam+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and  '+strSQL+' carihar_dov.dovkod=:Dov_Kod and '+
             ' (cari.cari_kod=carihar.cari_kod))>(Select '+sql_Toplam+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B''  '+strSQL+' and carihar_dov.dovkod=:Dov_Kod and '+
             ' (cari.cari_kod=carihar.cari_kod))) ';

          end;
     end;


     {
     SubeID := DataMod.SubeAd2ID(cmbSube.Text);
     if (SubeID <> '0') and (Trim(SubeID)<>'') then
     begin
       CaristrSQL:=CaristrSQL+ ' and cari.sid = '+ SubeID;
     end;
    }
     if (Trim(txtCariKod1.Text)<>'') and (Trim(txtCariKod2.Text)<>'') then
       CaristrSQL:=CaristrSQL+ ' and (cari.cari_kod between '+Sql_Katar(txtCariKod1.Text)+ ' and ' +Sql_Katar(txtCariKod2.Text)+') ';


     if cmbGrup.ItemIndex=0 then
     if Trim(txtGrpKod.Text)<>'' then
     CaristrSQL:=CaristrSQL+ ' and cari_grup_uye.Cari_Grup_Kod='+Sql_Katar(txtGrpKod.Text)+' ';

     if cmbGrup.ItemIndex=1 then
       CaristrSQL:=CaristrSQL+ ' and (cari.cari_kod not in (select cari_kod from cari_grup_uye)) ';

     if cmbParaBirimi.Text<>glb_DEFCUR then
       CaristrSQL:=CaristrSQL+ ' and (cari_dov.dovkod= '+Sql_Katar(cmbParaBirimi.Text)+') ';




     if cmbParaBirimi.Text=glb_DEFCUR then
     begin
          if cbBakiye.checked then
          if chkDEVIR.Checked then
          CaristrSQL:=CaristrSQL+
          ' and ((Select '+sql_Toplam+' from carihar where  Tip=''B'' and '+strSQL+' (cari.cari_kod=carihar.cari_kod))>0 or cari.devreden_borc>0 or '+
          '(Select '+sql_Toplam+' from carihar where  Tip=''A'' and '+strSQL+' (cari.cari_kod=carihar.cari_kod))>0 or cari.devreden_Alacak>0) ';

          if cbBakiye.checked then
          if not chkDEVIR.Checked then
          CaristrSQL:=CaristrSQL+
          ' and ((Select '+sql_Toplam+' from carihar where  Tip=''B'' and '+strSQL+' (cari.cari_kod=carihar.cari_kod))>0 or '+
          '(Select '+sql_Toplam+' from carihar where  Tip=''A'' and '+strSQL+' (cari.cari_kod=carihar.cari_kod))>0) ';
     end
     else
     begin
          if cbBakiye.checked then
          if chkDEVIR.Checked then
          CaristrSQL:=CaristrSQL+
          ' and ((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))>0 or cari_dov.devreden_borc>0 or '+
          '(Select sum(carihar_dov.Tutar) from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))>0 or cari_dov.devreden_Alacak>0) ';

          if cbBakiye.checked then
          if not chkDEVIR.Checked then
          CaristrSQL:=CaristrSQL+
          ' and ((Select '+sql_Toplamd+' from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''B'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))>0 or  '+
          '(Select sum(carihar_dov.Tutar) from carihar left outer join carihar_dov on (carihar.carihar_id=carihar_dov.carihar_id) where carihar.Tip=''A'' and carihar_dov.dovkod=:Dov_Kod and (cari.cari_kod=carihar.cari_kod))>0) ';
     end;
     



     if cmb_sirala.ItemIndex=0 then
       CaristrSQL:=CaristrSQL+ ' Order By Cari.Cari_Kod ';
     if cmb_sirala.ItemIndex=1 then
       CaristrSQL:=CaristrSQL+ ' Order By Cari.Cari_Ad ';

     IB_Query1.Sql.Add(CaristrSQL);
     if cmbParaBirimi.Text<>glb_DEFCUR then
     IB_Query1.ParamByName('Dov_Kod').AsString:=cmbParaBirimi.Text;
     IB_Query1.Open;


     if sender=btnRapor then
     begin
          YazY;
          Exit;
     end;

     Prv_Yazdirildi:=False;
     //frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Cari_Listesi.fr3');
     frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Cari_Listesi_iis.fr3');
     //frxReport1.PrepareReport();
     // a:=(frxReport1.FindComponent('Memo_Rapor_Adi') as TfrxMemoView); a.memo.Text:='Cari Hareket Toplamý';
     // if chk_devir.Checked then a.memo.Text:='Devirli Cari Hareket Toplamý';

     frxReport1.showReport;
     Exit;

///////////////////////////////////****************************************///////////////////////////////////****************************************

     {
     IB_Query1.Close;
     IB_Query1.Sql.Clear;

      CaristrSQL:=
      'select '+
      '    cari.cari_kod, '+
      '    cari.cari_ad, '+
      '    cari.ilce, '+
      '    cari.sehir, ';
     if cmbParaBirimi.Text=glb_DEFCUR then
     begin
          if chkDEVIR.Checked then
          CaristrSQL:=CaristrSQL+
          '    cari.borc+cari.devreden_borc as borc, '+
          '    cari.Alacak+cari.devreden_Alacak as alacak, '+
          '    (CASE '+
          '    WHEN (cari.borc+cari.devreden_borc>cari.Alacak+cari.devreden_Alacak) THEN '+
          '    ''B'' '+
          '    WHEN (cari.borc+cari.devreden_borc<cari.Alacak+cari.devreden_Alacak) THEN '+
          '    ''A'' '+
          '    ELSE '+
          '    ''-'' '+
          '    END) Tip, '+
          '    (CASE '+
          '    WHEN (cari.borc+cari.devreden_borc>cari.Alacak+cari.devreden_Alacak) THEN '+
          '    (cari.borc+cari.devreden_borc)-(cari.Alacak+cari.devreden_Alacak) '+
          '    else '+
          '    (cari.Alacak+cari.devreden_Alacak)-(cari.borc+cari.devreden_borc) '+
          '    END) Bakiye '
          else
          CaristrSQL:=CaristrSQL+
          '    cari.borc as borc, '+
          '    cari.Alacak as alacak, '+
          '    (CASE '+
          '    WHEN (cari.borc>cari.Alacak) THEN '+
          '    ''B'' '+
          '    WHEN (cari.borc<cari.Alacak) THEN '+
          '    ''A'' '+
          '    ELSE '+
          '    ''-'' '+
          '    END) Tip, '+
          '    (CASE '+
          '    WHEN (cari.borc>cari.Alacak) THEN '+
          '    (cari.borc)-(cari.Alacak) '+
          '    else '+
          '    (cari.Alacak)-(cari.borc) '+
          '    END) Bakiye ';
     end
     else
     begin
          if chkDEVIR.Checked then
          CaristrSQL:=CaristrSQL+
          '    cari_dov.borc+cari_dov.devreden_borc as borc, '+
          '    cari_dov.Alacak+cari_dov.devreden_Alacak as alacak, '+
          '    (CASE '+
          '    WHEN (cari_dov.borc+cari_dov.devreden_borc>cari_dov.Alacak+cari_dov.devreden_Alacak) THEN '+
          '    ''B'' '+
          '    WHEN (cari_dov.borc+cari_dov.devreden_borc<cari_dov.Alacak+cari_dov.devreden_Alacak) THEN '+
          '    ''A'' '+
          '    ELSE '+
          '    ''-'' '+
          '    END) Tip, '+
          '    (CASE '+
          '    WHEN (cari_dov.borc+cari_dov.devreden_borc>cari_dov.Alacak+cari_dov.devreden_Alacak) THEN '+
          '    (cari_dov.borc+cari_dov.devreden_borc)-(cari_dov.Alacak+cari_dov.devreden_Alacak) '+
          '    else '+
          '    (cari_dov.Alacak+cari_dov.devreden_Alacak)-(cari_dov.borc+cari_dov.devreden_borc) '+
          '    END) Bakiye '
          else
          CaristrSQL:=CaristrSQL+
          '    cari_dov.borc as borc, '+
          '    cari_dov.Alacak as alacak, '+
          '    (CASE '+
          '    WHEN (cari_dov.borc>cari_dov.Alacak) THEN '+
          '    ''B'' '+
          '    WHEN (cari_dov.borc<cari_dov.Alacak) THEN '+
          '    ''A'' '+
          '    ELSE '+
          '    ''-'' '+
          '    END) Tip, '+
          '    (CASE '+
          '    WHEN (cari_dov.borc>cari_dov.Alacak) THEN '+
          '    (cari_dov.borc)-(cari_dov.Alacak) '+
          '    else '+
          '    (cari_dov.Alacak)-(cari_dov.borc) '+
          '    END) Bakiye ';
     end;


     CaristrSQL:=CaristrSQL+ ' from cari ';

     if cmbParaBirimi.Text<>glb_DEFCUR then
     CaristrSQL:=CaristrSQL+
     ' left outer join cari_dov on (cari.cari_kod=cari_dov.cari_kod)';



     if cmbGrup.ItemIndex=0 then
     if Trim(txtGrpKod.Text)<>'' then
     CaristrSQL:=CaristrSQL+
     ' left outer join cari_grup_uye on (cari.cari_kod=cari_grup_uye.cari_kod)';


     CaristrSQL:=CaristrSQL+
     ' where Cari.cari_kod<>'''' ';

     if cb_Firma_Tipi.Checked then
     begin

         if cmb_yurtdisi.ItemIndex=0 then
         CaristrSQL:=CaristrSQL+
         ' and cari.yurtdisi=0 ';
         if cmb_yurtdisi.ItemIndex=1 then
         CaristrSQL:=CaristrSQL+
         ' and cari.yurtdisi=1 ';

     end;

     if Cb_Cari_Tipi.Checked then
     if cmbTip.Itemindex<>5 then
     CaristrSQL:=CaristrSQL+
     ' and cari.Tip= '+Inttostr(cmbTip.Itemindex+1);

     //if cmb_Bakiye.itemIndex=0 then CaristrSQL:=CaristrSQL+ ' and Tip=''B''';
     //if cmb_Bakiye.itemIndex=1 then CaristrSQL:=CaristrSQL+ ' and Tip=''A''';

     if (cmb_Bakiye.itemIndex=0) or (cmb_Bakiye.itemIndex=1)  then
     if cmbParaBirimi.Text=glb_DEFCUR then
     begin
          if chkDEVIR.Checked then
          begin
              if cmb_Bakiye.itemIndex=0 then
              CaristrSQL:=CaristrSQL+ ' and (cari.borc+cari.devreden_borc>cari.Alacak+cari.devreden_Alacak) ';
              if cmb_Bakiye.itemIndex=1 then
              CaristrSQL:=CaristrSQL+ ' and (cari.Alacak+cari.devreden_Alacak>cari.borc+cari.devreden_borc) ';

          end
          else
          begin
              if cmb_Bakiye.itemIndex=0 then
              CaristrSQL:=CaristrSQL+ ' and (cari.borc>cari.Alacak) ';
              if cmb_Bakiye.itemIndex=1 then
              CaristrSQL:=CaristrSQL+ ' and (cari.Alacak>cari.borc) ';

          end;
     end
     else
     begin
          if chkDEVIR.Checked then
          begin
             if cmb_Bakiye.itemIndex=0 then
             CaristrSQL:=CaristrSQL+ ' and (cari_dov.borc+cari_dov.devreden_borc>cari_dov.Alacak+cari_dov.devreden_Alacak) ';
             if cmb_Bakiye.itemIndex=1 then
             CaristrSQL:=CaristrSQL+ ' and (cari_dov.Alacak+cari_dov.devreden_Alacak>cari_dov.borc+cari_dov.devreden_borc) ';

          end
          else
          begin
             if cmb_Bakiye.itemIndex=0 then
             CaristrSQL:=CaristrSQL+ ' and (cari_dov.borc>cari_dov.Alacak) ';
             if cmb_Bakiye.itemIndex=1 then
             CaristrSQL:=CaristrSQL+ ' and (cari_dov.Alacak>cari_dov.borc) ';

          end;
     end;

     SubeID := DataMod.SubeAd2ID(cmbSube.Text);
     if (SubeID <> '0') and (Trim(SubeID)<>'') then
     begin
       CaristrSQL:=CaristrSQL+ ' and cari.sid = '+ SubeID;
     end;

     if (Trim(txtCariKod1.Text)<>'') and (Trim(txtCariKod2.Text)<>'') then
       CaristrSQL:=CaristrSQL+ ' and (cari.cari_kod between '+Sql_Katar(txtCariKod1.Text)+ ' and ' +Sql_Katar(txtCariKod2.Text)+')';


     if cmbGrup.ItemIndex=0 then
     CaristrSQL:=CaristrSQL+ ' and cari_grup_uye.Cari_Grup_Kod='+Sql_Katar(txtGrpKod.Text);

     if cmbGrup.ItemIndex=1 then
       CaristrSQL:=CaristrSQL+ ' and (cari.cari_kod not in (select cari_kod from cari_grup_uye)) ';

     if cmbParaBirimi.Text<>glb_DEFCUR then
       CaristrSQL:=CaristrSQL+ ' and (cari_dov.dovkod= '+Sql_Katar(cmbParaBirimi.Text)+')';

     if cmbParaBirimi.Text=glb_DEFCUR then
     begin
          if cbBakiye.checked then
          if chkDEVIR.Checked then
          CaristrSQL:=CaristrSQL+
          ' and (cari.borc>0 or cari.devreden_borc>0 or '+
          'cari.Alacak>0 or cari.devreden_Alacak>0) ';

          if cbBakiye.checked then
          if not chkDEVIR.Checked then
          CaristrSQL:=CaristrSQL+
          ' and (cari.borc>0 or '+
          'cari.Alacak>0) ';
     end
     else
     begin
          if cbBakiye.checked then
          if chkDEVIR.Checked then
          CaristrSQL:=CaristrSQL+
          ' and (cari_dov.bor>0 or cari_dov.devreden_borc>0 or '+
          'cari_dov.Alacak>0 or cari_dov.devreden_Alacak>0) ';

          if cbBakiye.checked then
          if not chkDEVIR.Checked then
          CaristrSQL:=CaristrSQL+
          ' and (cari_dov.borc>0 or  '+
          'cari_dov.Alacak>0) ';
     end;


     if cmb_sirala.ItemIndex=0 then
       CaristrSQL:=CaristrSQL+ ' Order By Cari.Cari_Kod ';
     if cmb_sirala.ItemIndex=1 then
       CaristrSQL:=CaristrSQL+ ' Order By Cari.Cari_Ad ';

     IB_Query1.Sql.Add(CaristrSQL);
     IB_Query1.Open;

     Prv_Yazdirildi:=False;
     //frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Cari_Listesi.fr3');
     frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Cari_Listesi_iis.fr3');
     //frxReport1.PrepareReport();
     // a:=(frxReport1.FindComponent('Memo_Rapor_Adi') as TfrxMemoView); a.memo.Text:='Cari Hareket Toplamý';
     // if chk_devir.Checked then a.memo.Text:='Devirli Cari Hareket Toplamý';

     frxReport1.showReport;
     Exit;
     }



end;







procedure TfrmRaporGenelCariListesi.Yazy();
var
  CHeader : TcxSSHeader;
  res_Cari : TStringList;

begin

    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
    CHeader.Size[1] := 350;
    CHeader.Size[2] := 120;
    frmRaporCiktisi.SetCellFormat(0,3,0,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    frmRaporCiktisi.SetCellAlignment(0,3,0,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haLEFT,vaCenter);
    frmRaporCiktisi.SetCellAlignment(2,2,2,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haRight,vaCenter);
     frmRaporCiktisi.SetCellAlignment(5,5,6,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haRIGHT,vaCenter);
    //frmRaporCiktisi.SetCellAlignment(5,2,6,2,haRight,vaCenter);
    frmRaporCiktisi.Rapor_Ayarlari(2);
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.grdA.ActivePage := 0;
    frmRaporCiktisi.WindowState := wsMaximized;




  row := 0;
  col := 0;
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 0;
  end;

  frmRaporCiktisi.SetCellText(0,5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(5,0,5,0,[fsBold],8,'MS Sans Serif',0);

  frmRaporCiktisi.SetCellText(row,col+2,'CARÝ LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);

  inc(row);
  col := 0;

  frmRaporCiktisi.SetCellText(row,col,'Döviz Tipi :');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

  col := 1;

  frmRaporCiktisi.SetCellText(row,col,cmbParaBirimi.Text);
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
  col := 0;


  frmRaporCiktisi.SetCellText(row,col,'Cari Listesi ');
  
  if cmbGrup.ItemIndex=0 then
  frmRaporCiktisi.SetCellText(row,col,'Cari Listesi '+txtGrpKod.Text+ ' ');
  //frmRaporCiktisi.SetCellText(row,col,'Cari Listesi '+txtGrpKod.Text+ ' '+qryGrup_GrupUye.FieldByName('CGADI').AsString);

  frmRaporCiktisi.SetCellText(row+1,col,'Cari Kod');
  frmRaporCiktisi.SetCellText(row+1,col+1,'Cari Ad');
//  frmRaporCiktisi.SetCellText(row+1,col+2,'Ýlçe');
//  frmRaporCiktisi.SetCellText(row+1,col+3,'Þehir');
  frmRaporCiktisi.SetCellText(row+1,col+2,'Borç');
  frmRaporCiktisi.SetCellText(row+1,col+3,'Alacak');
  frmRaporCiktisi.SetCellText(row+1,col+4,'B/A');
  frmRaporCiktisi.SetCellText(row+1,col+5,'Bakiye');
  frmRaporCiktisi.SetCellFont(col,row+1,col+5,row+1,[fsBold],8,'MS Sans Serif',4);
  Inc(row,2);

      IB_Query1.First;
      while not (IB_Query1.Eof) do
      begin

        DataMod.Rapor_Satir_Renklendir(col,row,7);


        frmRaporCiktisi.SetCellText(row,col,IB_Query1.FieldByName('CARI_KOD').AsString);
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,IB_Query1.FieldByName('CARI_AD').AsString);
        //Inc(col);
        //frmRaporCiktisi.SetCellText(row,col,IB_Query1.FieldByName('ILCE').AsString);
        //Inc(col);
        //frmRaporCiktisi.SetCellText(row,col,IB_Query1.FieldByName('SEHIR').AsString);
        Inc(col);
        if cmbParaBirimi.Text = glb_DEFCUR then
        begin
          frmRaporCiktisi.SetCellText(row,col,FormatCurr(glb_DOV_FIELD_PF,IB_Query1.FieldByName('BORC').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          Inc(col);
          frmRaporCiktisi.SetCellText(row,col,FormatCurr(glb_DOV_FIELD_PF,IB_Query1.FieldByName('ALACAK').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          Inc(col);
          if IB_Query1.FieldByName('ALACAK').AsCurrency > IB_Query1.FieldByName('BORC').AsCurrency then
          begin
            frmRaporCiktisi.SetCellText(row,col,'A');
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,CurrToStr(IB_Query1.FieldByName('ALACAK').AsCurrency - IB_Query1.FieldByName('BORC').AsCurrency));
            frmRaporCiktisi.format_ayarla(col,row,col,row);
          end
          else
          if IB_Query1.FieldByName('ALACAK').AsCurrency < IB_Query1.FieldByName('BORC').AsCurrency then
          begin
            frmRaporCiktisi.SetCellText(row,col,'B');
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,CurrToStr(IB_Query1.FieldByName('BORC').AsCurrency - IB_Query1.FieldByName('ALACAK').AsCurrency));
            frmRaporCiktisi.format_ayarla(col,row,col,row);
          end
          else
          begin
            frmRaporCiktisi.SetCellText(row,col,'-');
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,'0');
            frmRaporCiktisi.format_ayarla(col,row,col,row);
          end;
        end
        else
        begin
          frmRaporCiktisi.SetCellText(row,col,IB_Query1.FieldByName('BORC').AsString);
          frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          Inc(col);
          frmRaporCiktisi.SetCellText(row,col,IB_Query1.FieldByName('ALACAK').AsString);
          frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          Inc(col);
          if IB_Query1.FieldByName('ALACAK').AsCurrency > IB_Query1.FieldByName('BORC').AsCurrency then
          begin
            frmRaporCiktisi.SetCellText(row,col,'A');
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,CurrToStr(IB_Query1.FieldByName('ALACAK').AsCurrency - IB_Query1.FieldByName('BORC').AsCurrency));
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end
          else
          if IB_Query1.FieldByName('ALACAK').AsCurrency < IB_Query1.FieldByName('BORC').AsCurrency then
          begin
            frmRaporCiktisi.SetCellText(row,col,'B');
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,CurrToStr(IB_Query1.FieldByName('BORC').AsCurrency - IB_Query1.FieldByName('ALACAK').AsCurrency));
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end
          else
          begin
            frmRaporCiktisi.SetCellText(row,col,'-');
            Inc(col);
            frmRaporCiktisi.SetCellText(row,col,'0');
            frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
          end;
        end;
        Inc(row);
        col := 0;
        IB_Query1.Next;
      end;
  inc(row);
end;

end.








