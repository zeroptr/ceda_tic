{$INCLUDE directive.inc}

unit ufrmRaporCariAylikBA;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IB_Components, Buttons, cxSSHeaders,
  ComCtrls, StdCtrls, frxClass, frxIBOSet, DateUtils;

type
  TfrmRaporCariAylikBA = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    grb1: TGroupBox;
    txtCariKod1: TEdit;
    txtCariKod2: TEdit;
    btnCariListe1: TButton;
    btnCariListe2: TButton;
    grb2: TGroupBox;
    txtCariKod3: TEdit;
    btnCariListe3: TButton;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    cmbGrup: TComboBox;
    qryRapor: TIB_Cursor;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    GroupBox4: TGroupBox;
    cmbParaBirimi: TComboBox;
    cmbAy: TComboBox;
    cb_Devir: TCheckBox;
    qryRapora: TIB_Cursor;
    chk_Sefer: TCheckBox;
    frxIBODts_Cari_Ay: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure kod_cikis(kod : TEdit);
    function kod_kontrol(kontrol_sayisi:byte):Boolean;
    procedure frmRaporCiktisi_Open(strSQL:String);
    procedure alan_isimlerini_ekle;
    procedure yaz;
    procedure Data_Aktar;
////////////////////////////////////////////////////////////////////////////////
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbGrupChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCariListe1Click(Sender: TObject);
    procedure txtCariKod1Exit(Sender: TObject);
    procedure txtCariKod1KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtCariKod1KeyPress(Sender: TObject; var Key: Char);
    procedure btnCariListe2Click(Sender: TObject);
    procedure btnCariListe3Click(Sender: TObject);
    procedure txtCariKod2KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtCariKod3KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtCariKod2Exit(Sender: TObject);
    procedure txtCariKod3Exit(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtCariKod1Enter(Sender: TObject);
    procedure cmbParaBirimiEnter(Sender: TObject);
    procedure cmbParaBirimiExit(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    row,col : integer;
    Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    strSQL:String;
    strSQL1,strsql_we:String;
    { Public declarations }
  end;

  const cns_cariaylikborcalacak = 2;
  
var
  frmRaporCariAylikBA: TfrmRaporCariAylikBA;

implementation

uses unDataMod,ufrmRaporCiktisi,ufrmCariSDLG,unFunc,Math,main;

{$R *.dfm}

procedure TfrmRaporCariAylikBA.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if DataMod.Modul_Hak(cns_cariaylikborcalacak,local_CanUpdate,local_CanDelete) = False then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporCariAylikBA') then
    begin
      Application.CreateForm(TfrmRaporCariAylikBA,frmRaporCariAylikBA);
      with frmRaporCariAylikBA do
      begin
        cmbParaBirimi.Items.Add(glb_DEFCUR);
        cmbParaBirimi.Items.AddStrings(glb_TAK_DOV_LIST);
        cmbParaBirimi.ItemIndex := 0;
      end;
    end;
  end;
end;


procedure TfrmRaporCariAylikBA.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporCariAylikBA.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmRaporCariAylikBA.cmbGrupChange(Sender: TObject);
begin
  case cmbGrup.ItemIndex of
  0:
    begin
      grb1.Enabled := True;
      grb2.Enabled := false;
      txtCariKod3.Clear;
    end;
  1:
    begin
      grb1.Enabled := false;
      grb2.Enabled := true;
      txtCariKod1.Clear;
      txtCariKod2.Clear;
    end;
  end;
end;

procedure TfrmRaporCariAylikBA.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TfrmRaporCariAylikBA.btnCariListe1Click(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if frmCariSDLG.Form_Open (True,CARI_KOD,CARI_AD,1) Then txtCariKod1.Text := CARI_KOD;
end;

procedure TfrmRaporCariAylikBA.txtCariKod1Exit(Sender: TObject);
begin
  kod_cikis(txtCariKod1);
end;

procedure TfrmRaporCariAylikBA.kod_cikis(kod : TEdit);
var
  Cari_Ad:String;
begin
  if Length(Trim(kod.Text))=0 then
  begin
    kod.Color := clWindow;
    exit;
  end;

  if not DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',kod.Text,Cari_Ad) then
  begin
    Application.MessageBox('Cari Kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    kod.Clear;
    kod.SetFocus;
  end
  else
  begin
    kod.Color := clWindow;
  end;
end;


procedure TfrmRaporCariAylikBA.txtCariKod1KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
var
  CARI_KOD,CARI_AD:String;
begin
  if Key=VK_F4 Then
  begin
    if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) Then txtCariKod1.Text := CARI_KOD;
  end;
end;


procedure TfrmRaporCariAylikBA.txtCariKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporCariAylikBA.btnCariListe2Click(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) Then txtCariKod2.Text := CARI_KOD;
end;

procedure TfrmRaporCariAylikBA.btnCariListe3Click(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if frmCariSDLG.Form_Open (True,CARI_KOD,CARI_AD,1) Then txtCariKod3.Text := CARI_KOD;
end;

procedure TfrmRaporCariAylikBA.txtCariKod2KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
var
  CARI_KOD,CARI_AD:String;
begin
  if Key=VK_F4 Then
  begin
    if frmCariSDLG.Form_Open (True,CARI_KOD,CARI_AD,1) Then txtCariKod2.Text := CARI_KOD;
  end;
end;

procedure TfrmRaporCariAylikBA.txtCariKod3KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
var
  CARI_KOD,CARI_AD:String;
begin
  if Key=VK_F4 Then
  begin
    if frmCariSDLG.Form_Open (True,CARI_KOD,CARI_AD,1) Then txtCariKod3.Text := CARI_KOD;
  end;
end;

procedure TfrmRaporCariAylikBA.txtCariKod2Exit(Sender: TObject);
begin
  kod_cikis(txtCariKod2);
end;

procedure TfrmRaporCariAylikBA.txtCariKod3Exit(Sender: TObject);
begin
  kod_cikis(txtCariKod3);
end;

procedure TfrmRaporCariAylikBA.btnRaporClick(Sender: TObject);
var
   bas_Tar,Bit_Tar:String;

begin


     if sender=Btn_Fast then
     begin

IB_Query1.Close;
IB_Query1.Sql.Text:=
'select * from CARI_AY_LISTE( '+
':PRM_YIL, '+
':PRM_AY, '+
':PRM_DOVKOD, '+
':PRM_DEVIR, '+
':PRM_SEFER_MAZOT, '+
':PRM_BAS_TAR, '+
':PRM_BIT_TAR) ';



          if cmbGrup.ItemIndex=1 then
          begin

               if (txtCariKod3.Text<>'') then
               begin
                  IB_Query1.Sql.Text:=IB_Query1.Sql.Text+#13+
                  ' Where Cari_kod ='+Sql_Katar(txtCariKod3.Text);

               end;
          end;


          if cmbGrup.ItemIndex=0 then
          begin
           {if  not kod_kontrol(2) then
           begin
             Application.MessageBox('Lütfen cari kod aralýðý seçiniz.','Dikkat',MB_ICONWARNING);
             exit;
           end;}

               if (txtCariKod1.Text<>'') and (txtCariKod2.Text<>'') then
               begin
                  IB_Query1.Sql.Text:=IB_Query1.Sql.Text+#13+
                  ' Where Cari_kod between '+Sql_Katar(txtCariKod1.Text)+' and '+Sql_Katar(txtCariKod2.Text);

               end;
          end;

       IB_Query1.Sql.Text:=IB_Query1.Sql.Text+#13+ ' Order by Cari_Kod '; 

          IB_Query1.ParamByName('PRM_YIL').AsVariant:=null;
          IB_Query1.ParamByName('PRM_AY').AsVariant:=null;
          IB_Query1.ParamByName('PRM_DOVKOD').AsVariant:=null;
          IB_Query1.ParamByName('PRM_DEVIR').AsVariant:=null;
          IB_Query1.ParamByName('PRM_SEFER_MAZOT').AsVariant:=null;
          IB_Query1.ParamByName('PRM_BAS_TAR').AsVariant:=null;
          IB_Query1.ParamByName('PRM_BIT_TAR').AsVariant:=null;

          if cb_Devir.Checked then
          IB_Query1.ParamByName('PRM_DEVIR').AsVariant:=1;
          if chk_Sefer.Checked then
          IB_Query1.ParamByName('PRM_SEFER_MAZOT').AsVariant:=1;


          bas_tar:=DateTostr(EncodeDateTime(glb_CALISMA_YIL,1,1,0,0,0,0));
          bit_tar:=ay_gun_son(EncodeDateTime(glb_CALISMA_YIL,cmbAy.ItemIndex+1,1,0,0,0,0));
          IB_Query1.ParamByName('PRM_BAS_TAR').AsVariant:=bas_tar;
          IB_Query1.ParamByName('PRM_BIT_TAR').AsVariant:=bit_tar;


          IB_Query1.ParamByName('PRM_YIL').AsVariant:=glb_CALISMA_YIL;
          IB_Query1.ParamByName('PRM_AY').AsVariant:=cmbAy.ItemIndex+1;
          IB_Query1.ParamByName('PRM_DOVKOD').AsVariant:=cmbParaBirimi.Text;


         IB_Query1.Open;


          Prv_Yazdirildi:=False;
          frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Cari_Ay.fr3');
          {if chk_Sayfalar.Checked then
          begin
          a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
          a.StartNewPage:=True;
          end;
          }
          //frxReport1.PrepareReport();
          frxReport1.showReport;
          Exit;
     end;


  strSQL := ' SELECT CARI_AY.CARI_KOD,CARI.CARI_AD,CARI_AY.AY,CARI_AY.BORC,CARI_AY.ALACAK FROM CARI_AY '+
  ' LEFT OUTER JOIN CARI ON(CARI.CARI_KOD=CARI_AY.CARI_KOD) ';

  if cmbParaBirimi.Text = glb_DEFCUR then
  strSQL1 := ' SELECT CARI.CARI_KOD,CARI.CARI_AD,CARI.DEVREDEN_BORC,CARI.DEVREDEN_ALACAK FROM CARI ';
  //glb dov kurda

  if cmbParaBirimi.Text <> glb_DEFCUR then
  strSQL1 := '  SELECT CARI.CARI_KOD,CARI.CARI_AD,CARI_dov.DEVREDEN_BORC,CARI_dov.DEVREDEN_ALACAK FROM CARI '+
             '  left outer join cari_dov on (cari_dov.cari_kod=cari.cari_kod) ';
  //dov kurda



  strsql_we :='';
  case cmbGrup.ItemIndex of
  0:
    begin
      if  kod_kontrol(2) then
      begin
      strSQL := strSQL + ' WHERE CARI_AY.AY = ' + inttostr(cmbAy.ItemIndex+1);
      strSQL := strSQL + ' AND CARI_AY.DOVKOD = '+SQL_Katar(cmbParaBirimi.Text);
      //if kod_kontrol(2) then strSQL := strSQL + ' AND CARI_AY.CARI_KOD BETWEEN '+SQL_Katar(txtCariKod1.Text)+' AND '+SQL_Katar(txtCariKod2.Text);
      strSQL := strSQL + ' AND CARI_AY.CARI_KOD =:CARI_KOD ';
      strSQL := strSQL + ' ORDER BY CARI_AY.CARI_KOD';

//

      if cmbParaBirimi.Text <> glb_DEFCUR then
      strsql_we := strsql_we + ' WHERE CARI_DOV.DOVKOD = '+SQL_Katar(cmbParaBirimi.Text)
      else
      strsql_we := ' WHERE  CARI.CARI_KOD<>''''';

      //if kod_kontrol(2) then
      strsql_we := strsql_we + ' and (CARI.CARI_KOD BETWEEN '+SQL_Katar(txtCariKod1.Text)+' AND '+SQL_Katar(txtCariKod2.Text)+') ';

      strsql_we := strsql_we + ' ORDER BY CARI.CARI_KOD';
//

      frmRaporCiktisi_Open(strSQL);
      end
      else
      begin
        Application.MessageBox('Lütfen cari kod aralýðý seçiniz.','Dikkat',MB_ICONWARNING);
        exit;
      end;
    end;
  1:
    begin
      if kod_kontrol(1) then
      begin
//        strSQL := strSQL + ' WHERE CARI_AY.CARI_KOD = '+SQL_Katar(txtCariKod3.Text);
        strSQL := strSQL + ' WHERE CARI_AY.CARI_KOD =:CARI_KOD ';
        strSQL := strSQL + ' AND CARI_AY.DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text);
        strSQL := strSQL + ' ORDER BY CARI_AY.CARI_KOD';
//
        strsql_we := strsql_we + ' WHERE CARI.CARI_KOD = '+SQL_Katar(txtCariKod3.Text);
        if cmbParaBirimi.Text <> glb_DEFCUR then
        strsql_we := strsql_we + ' AND CARI_DOV.DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text);
        strsql_we := strsql_we + ' ORDER BY CARI.CARI_KOD';
//

      end
      else
      begin
        Application.MessageBox('Lütfen bir cari seçiniz.','Dikkat',MB_ICONWARNING);
        exit;
      end;
      frmRaporCiktisi_Open(strSQL);
    end;
  end;
end;


procedure TfrmRaporCariAylikBA.frmRaporCiktisi_Open(strSQL:String);
begin
////////////////////////////////////////////////////////////////////////////////
  with qryRapor do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;
  with qryRapora do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(strSQL1+strSQL_we);
    Active := True;
  end;

////////////////////////////////////////////////////////////////////////////////
//  if ((qryRapor.Eof) and (qryRapor.Bof))then
  if ((qryRapora.Eof) and (qryRapora.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnanadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Active := False;
    Exit;
  end
  else
  begin
    frmRaporCiktisi.form_open();
    yaz;
    frmRaporCiktisi.WindowState := wsMaximized;
  end;
////////////////////////////////////////////////////////////////////////////////
end;


procedure TfrmRaporCariAylikBA.yaz;
var
  res_Cari : TStringList;
  CHeader : TcxSSHeader;

begin
  row := 0;
  col := 0;
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      DataMod.Rapor_Satir_Renklendir(col,row,14);

      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 1;
  end;
  frmRaporCiktisi.SetCellText(1,5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(5,1,5,1,[fsBold],8,'MS Sans Serif',0);
  frmRaporCiktisi.SetCellText(row,col+2,'Ay Bazýnda Cari Borç Alacak Raporu');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);

  CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
  CHeader.Size[1] := 225;

  frmRaporCiktisi.grdA.BeginUpdate;
  alan_isimlerini_ekle;
  Data_Aktar;
  frmRaporCiktisi.grdA.EndUpdate;
  qryRapor.Close;
end;




procedure TfrmRaporCariAylikBA.Data_Aktar;
var
   Borc,Alacak,Borc1,Alacak1:Double;
   Temp:TIb_Query;
   strSql2:String;
   bas_tar,bit_tar:TDate;


  procedure sefer_devir;
  begin
       if cmbParaBirimi.Text <> glb_DEFCUR then
       strSQL2 := 'SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI_DOV'+
       ' WHERE DOVKOD='+Sql_Katar(cmbParaBirimi.Text) +' and CARI_KOD='+Sql_Katar(qryRapora.FieldByName('CARI_KOD').AsString);

       if cmbParaBirimi.Text = glb_DEFCUR then
       strSQL2 := 'SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI'+
       ' WHERE  CARI_KOD='+Sql_Katar(qryRapora.FieldByName('CARI_KOD').AsString);

       DataMod.CreateQuery(Temp,nil,False,DataMod.dbaMain);

       with Temp do
       begin
            Active := False;
            SQL.Clear;
            SQL.Add(strSQL2);
            Active := True;
            Borc:=FieldByName('DEVREDEN_BORC').AsFloat;
            Alacak:=FieldByName('DEVREDEN_ALACAK').AsFloat;
       end;


       if chk_Sefer.Checked then
       begin
           with Temp do
           begin
               Active := False;
               SQL.Clear;
               if cmbParaBirimi.Text = glb_DEFCUR then
               strSQL2 :=
               'select SUM((CASE '+
               'WHEN TIP=''B'' THEN  TUTAR_VPB '+
               'ELSE 0 '+
               'END)) BORC '+
               ',SUM((CASE '+
               'WHEN TIP=''A'' THEN  TUTAR_VPB '+
               'ELSE 0 '+
               'END)) ALACAK '+
               'from carihar '+
               ' WHERE (belge_tur=41 or belge_tur=42) and CARI_KOD='+Sql_Katar(qryRapora.FieldByName('CARI_KOD').AsString)+
               ' and (carihar.tarih between '+Sql_Tarih(Bas_Tar)+' and '+Sql_Tarih(Bit_Tar)+')'

               ELSE
                   strSQL2 :=
               'select  '+
               'SUM((CASE '+
               'WHEN CARIHAR.TIP=''B'' THEN  CARIHAR_DOV.TUTAR '+
               'ELSE 0 '+
               'END)) BORC '+
               ',SUM((CASE '+
               'WHEN CARIHAR.TIP=''A'' THEN  CARIHAR_DOV.TUTAR '+
               'ELSE 0 '+
               'END)) ALACAK '+
               'from CARIHAR '+
               'LEFT OUTER JOIN CARIHAR_DOV ON (CARIHAR.CARIHAR_ID=CARIHAR_DOV.CARIHAR_ID AND CARIHAR.CARIHAR_SID=CARIHAR_DOV.CARIHAR_SID) '+
               'WHERE (CARIHAR.belge_tur=41 or CARIHAR.belge_tur=42) and CARIHAR_DOV.dovkod='+Sql_Katar(cmbParaBirimi.Text)+ ' AND  CARI_KOD='+Sql_Katar(qryRapora.FieldByName('CARI_KOD').AsString)+
               ' and (carihar.tarih between '+Sql_Tarih(Bas_Tar)+' and '+Sql_Tarih(Bit_Tar)+')';

                SQL.Add(strSQL2);
                Active := True;
                Borc1:=FieldByName('BORC').AsFloat;
                Alacak1:=FieldByName('ALACAK').AsFloat;
           end;
       end;
  end;

begin
  if cmbGrup.ItemIndex=1 then
  inc(row);
  col := 0;
  qryRapora.First;

  //while not qryRapor.Eof do
  while not qryRapora.Eof do
  begin
            with qryRapor do
            begin
              Active := False;
              SQL.Clear;
              SQL.Add(strSQL);
              ParamByName('CARI_KOD').AsString:=qryRapora.FieldByName('CARI_KOD').AsString;
              Active := True;
            end;



            bas_tar:=EncodeDateTime(glb_CALISMA_YIL,cmbAy.ItemIndex+1,1,0,0,0,0);
            bit_tar:=strtodate(ay_gun_son(EncodeDateTime(glb_CALISMA_YIL,cmbAy.ItemIndex+1,1,0,0,0,0)));


            Borc:=0;
            Alacak:=0;
            Borc1:=0;
            Alacak1:=0;

            //  if cb_Devir.Checked then
            //  begin

            sefer_devir;

            if cb_Devir.Checked then
            if (borc>0) or (alacak>0)
            or (borc1>0) or (alacak1>0)
            or (qryRapor.FieldByName('BORC').Asfloat>0)
            or (qryRapor.FieldByName('ALACAK').Asfloat>0) then
            begin
                if cmbGrup.ItemIndex=0 then inc(row);
            end
            else
            begin
              qryRapora.Next;
              Continue;
            end;

            if not cb_Devir.Checked then
            if(borc1>0) or (alacak1>0)
            or(qryRapor.FieldByName('BORC').Asfloat>0)
            or (qryRapor.FieldByName('ALACAK').Asfloat>0) then
            begin
               if cmbGrup.ItemIndex=0 then inc(row);
            end
            else
            begin
              qryRapora.Next;
              Continue;
            end;

            case cmbGrup.ItemIndex of
            0:begin
                frmRaporCiktisi.SetCellText(row,col,qryRapora.FieldByName('CARI_KOD').AsString);
                inc(col);
                frmRaporCiktisi.SetCellText(row,col,qryRapora.FieldByName('CARI_AD').AsString);
                inc(col);

                frmRaporCiktisi.SetCellText(row,col,Floattostr(qryRapor.FieldByName('BORC').AsFloat+Borc1));
                if cb_Devir.Checked then
                frmRaporCiktisi.SetCellText(row,col,Floattostr(qryRapor.FieldByName('BORC').AsFloat+Borc+Borc1));

                if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
                inc(col);

                frmRaporCiktisi.SetCellText(row,col,Floattostr(qryRapor.FieldByName('ALACAK').Asfloat+Alacak1));
                if cb_Devir.Checked then
                frmRaporCiktisi.SetCellText(row,col,Floattostr(qryRapor.FieldByName('ALACAK').AsFloat+Alacak+Alacak1));

                if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

                if cb_Devir.Checked then
                begin
                   if qryRapor.FieldByName('ALACAK').AsFloat+Alacak+Alacak1>qryRapor.FieldByName('BORC').AsFloat+Borc+Borc1 then
                   begin
                    inc(col);
                    frmRaporCiktisi.SetCellText(row,col,Floattostr((qryRapor.FieldByName('ALACAK').AsFloat+Alacak+Alacak1)-(qryRapor.FieldByName('BORC').AsFloat+Borc+Borc1)));
                    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
                    inc(col);
                    frmRaporCiktisi.SetCellText(row,col,'Alacak');
                   end;
                   if qryRapor.FieldByName('BORC').AsFloat+Borc+Borc1>qryRapor.FieldByName('ALACAK').AsFloat+Alacak+Alacak1 then
                   begin
                    inc(col);
                    frmRaporCiktisi.SetCellText(row,col,Floattostr((qryRapor.FieldByName('BORC').AsFloat+Borc+Borc1)-(qryRapor.FieldByName('ALACAK').AsFloat+Alacak+Alacak1)));
                    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
                    inc(col);
                    frmRaporCiktisi.SetCellText(row,col,'Borc');
                   end;
                end
                else
                begin

                     if qryRapor.FieldByName('ALACAK').AsFloat+Alacak1>qryRapor.FieldByName('BORC').AsFloat+Borc1 then
                     begin
                         inc(col);
                         frmRaporCiktisi.SetCellText(row,col,Floattostr((qryRapor.FieldByName('ALACAK').AsFloat+Alacak1)-(qryRapor.FieldByName('BORC').AsFloat-Borc1)));
                         if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                         else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
                         inc(col);
                         frmRaporCiktisi.SetCellText(row,col,'Alacak');
                     end;

                     if qryRapor.FieldByName('BORC').AsFloat+Borc1>qryRapor.FieldByName('ALACAK').AsFloat+Alacak1 then
                     begin
                         inc(col);
                         frmRaporCiktisi.SetCellText(row,col,Floattostr((qryRapor.FieldByName('BORC').AsFloat+Borc1)-(qryRapor.FieldByName('ALACAK').AsFloat+Alacak1)));
                         if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                         else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
                         inc(col);
                         frmRaporCiktisi.SetCellText(row,col,'Borc');
                     end;
                end;
            end;


            1:begin
               qryRapor.First;
               while not qryRapor.Eof do
               begin
                    Borc:=0;
                    Alacak:=0;
                    Borc1:=0;
                    Alacak1:=0;


                    bas_tar:=EncodeDateTime(glb_CALISMA_YIL,qryRapor.FieldByName('AY').AsInteger,1,0,0,0,0);
                    bit_tar:=strtodate(ay_gun_son(EncodeDateTime(glb_CALISMA_YIL,qryRapor.FieldByName('AY').AsInteger,1,0,0,0,0)));

                    sefer_devir;

                    case qryRapor.FieldByName('AY').AsInteger of
                    1:frmRaporCiktisi.SetCellText(row,col,'Ocak');
                    2:frmRaporCiktisi.SetCellText(row,col,'Þubat');
                    3:frmRaporCiktisi.SetCellText(row,col,'Mart');
                    4:frmRaporCiktisi.SetCellText(row,col,'Nisan');
                    5:frmRaporCiktisi.SetCellText(row,col,'Mayýs');
                    6:frmRaporCiktisi.SetCellText(row,col,'Haziran');
                    7:frmRaporCiktisi.SetCellText(row,col,'Temmuz');
                    8:frmRaporCiktisi.SetCellText(row,col,'Aðustos');
                    9:frmRaporCiktisi.SetCellText(row,col,'Eylül');
                    10:frmRaporCiktisi.SetCellText(row,col,'Ekim');
                    11:frmRaporCiktisi.SetCellText(row,col,'Kasým');
                    12:frmRaporCiktisi.SetCellText(row,col,'Aralýk');
                    end;

                    if qryRapor.FieldByName('AY').AsInteger>1 then
                    begin
                      Borc:=0;
                      Alacak:=0;
                    end;

                    inc(col);
                    frmRaporCiktisi.SetCellText(row,col,Floattostr(qryRapor.FieldByName('BORC').AsFloat+Borc1));
                    if cb_Devir.Checked then
                    frmRaporCiktisi.SetCellText(row,col,Floattostr(qryRapor.FieldByName('BORC').AsFloat+Borc+Borc1));

                    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

                    inc(col);
                    frmRaporCiktisi.SetCellText(row,col,Floattostr(qryRapor.FieldByName('ALACAK').AsFloat+Alacak1));
                    if cb_Devir.Checked then
                    frmRaporCiktisi.SetCellText(row,col,Floattostr(qryRapor.FieldByName('ALACAK').AsFloat+Alacak+Alacak1));

                    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);


                    if cb_Devir.Checked then
                    begin
                       if qryRapor.FieldByName('ALACAK').AsFloat+Alacak+Alacak1>qryRapor.FieldByName('BORC').AsFloat+Borc+Borc1 then
                       begin
                            inc(col);
                            frmRaporCiktisi.SetCellText(row,col,Floattostr((qryRapor.FieldByName('ALACAK').AsFloat+Alacak+Alacak1)-(qryRapor.FieldByName('BORC').AsFloat+Borc+Borc1)));
                            if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                            else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
                            inc(col);
                            frmRaporCiktisi.SetCellText(row,col,'Alacak');
                       end;
                       if qryRapor.FieldByName('BORC').AsFloat+Borc+Borc1>qryRapor.FieldByName('ALACAK').AsFloat+Alacak+Alacak1 then
                       begin
                            inc(col);
                            frmRaporCiktisi.SetCellText(row,col,Floattostr((qryRapor.FieldByName('BORC').AsFloat+Borc+Borc1)-(qryRapor.FieldByName('ALACAK').AsFloat+Alacak+Alacak1)));
                            if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                            else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
                            inc(col);
                            frmRaporCiktisi.SetCellText(row,col,'Borc');
                       end;
                    end
                    else
                    begin
                         if qryRapor.FieldByName('ALACAK').AsFloat+Alacak1>qryRapor.FieldByName('BORC').AsFloat+Borc1 then
                         begin
                             inc(col);
                             frmRaporCiktisi.SetCellText(row,col,Floattostr((qryRapor.FieldByName('ALACAK').AsFloat+Alacak1)-(qryRapor.FieldByName('BORC').AsFloat+Borc1)));
                             if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                             else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
                             inc(col);
                             frmRaporCiktisi.SetCellText(row,col,'Alacak');
                         end;

                         if qryRapor.FieldByName('BORC').AsFloat+Borc1>qryRapor.FieldByName('ALACAK').AsFloat+Alacak1 then
                         begin
                             inc(col);
                             frmRaporCiktisi.SetCellText(row,col,Floattostr((qryRapor.FieldByName('BORC').AsFloat+Borc1)-(qryRapor.FieldByName('ALACAK').AsFloat+Alacak1)));
                             if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
                             else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
                             inc(col);
                             frmRaporCiktisi.SetCellText(row,col,'Borc');
                         end;
                    end;
                    inc(row);
                    col := 0;
                    qryRapor.Next;
               end;//rapor
            end; //case
            end; //case son
            col := 0;
            qryRapora.Next;
  end;
end;



procedure TfrmRaporCariAylikBA.alan_isimlerini_ekle;
begin
  inc(row);
  col := 0;
  case cmbGrup.ItemIndex of
  0:
    begin
      frmRaporCiktisi.SetCellText(row,col,'Ay');
      frmRaporCiktisi.SetCellText(row,col+1,cmbAy.Text);
      frmRaporCiktisi.SetCellText(row,col+2,'Para Birimi :');
      frmRaporCiktisi.SetCellText(row,col+3,cmbParaBirimi.Text);
      frmRaporCiktisi.SetCellFont(col,row,col+3,row,[fsBold],8,'MS Sans Serif',2);
      inc(row);
      frmRaporCiktisi.SetCellText(row,col,'Cari Kod :');
      frmRaporCiktisi.SetCellText(row,col+1,'Cari Ad  :');
      frmRaporCiktisi.SetCellText(row,col+2,'Borç');
      frmRaporCiktisi.SetCellText(row,col+3,'Alacak');
      frmRaporCiktisi.SetCellText(row,col+4,'Bakiye');
      frmRaporCiktisi.SetCellText(row,col+5,'Borc/Alacak');
      frmRaporCiktisi.SetCellFont(col,row,col+5,row,[fsBold],8,'MS Sans Serif',2);
    end;
  1:
    begin
      frmRaporCiktisi.SetCellText(row,col,'Cari Kod :');
      frmRaporCiktisi.SetCellText(row,col+1,txtCariKod3.Text+' '+qryRapor.FieldByName('CARI_AD').AsString);

      frmRaporCiktisi.SetCellText(row,col+2,'Para Birimi :');
      frmRaporCiktisi.SetCellText(row,col+3,cmbParaBirimi.Text);
      frmRaporCiktisi.SetCellFont(col,row,col+3,row,[fsBold],8,'MS Sans Serif',2);
      inc(row);
      frmRaporCiktisi.SetCellText(row,col,'Ay');
      frmRaporCiktisi.SetCellText(row,col+1,'Borç');
      frmRaporCiktisi.SetCellText(row,col+2,'Alacak');
      frmRaporCiktisi.SetCellText(row,col+3,'Bakiye');
      frmRaporCiktisi.SetCellText(row,col+4,'Borc/Alacak');
      frmRaporCiktisi.SetCellFont(col,row,col+4,row,[fsBold],8,'MS Sans Serif',2);
    end;
  end;//end case
end;

function TfrmRaporCariAylikBA.kod_kontrol(kontrol_sayisi:byte):Boolean;
begin
  result := false;
  case kontrol_sayisi of
  1:
    begin
      if (Length(Trim(txtCariKod3.text)) <> 0 ) then result := True else result := False;
    end;
  2:
    begin
      if ((Length(Trim(txtCariKod1.text)) <> 0 ) and (Length(Trim(txtCariKod2.text)) <> 0 ) )then result := True else result := False;
    end;
  end;
end;



procedure TfrmRaporCariAylikBA.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmRaporCariAylikBA.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key Of
    VK_F6:PageControl1.SelectNextPage(True);
  end;
end;

procedure TfrmRaporCariAylikBA.txtCariKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariAylikBA.cmbParaBirimiEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariAylikBA.cmbParaBirimiExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporCariAylikBA.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariAylikBA.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporCariAylikBA.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporCariAylikBA);
  {$IfnDef TRANSPORT}
  chk_Sefer.Visible:=False;
  {$EndIf}
end;

procedure TfrmRaporCariAylikBA.frxReport1BeforePrint(
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

       d:=(frxReport1.FindComponent('Memo_Ay') as TfrxMemoView);
       d.memo.Text:=cmbAy.Text;


       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);
      {

       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
      }

       Prv_Yazdirildi:=True;
    end;





end;

end.
