unit ufrmMazotSDLG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, IB_Grid, Mask, IB_Controls, StdCtrls, ExtCtrls, ComCtrls,
  Buttons, IB_Components;

type
  TfrmMazotSDLG = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    dtpTanzimTar1: TDateTimePicker;
    Label5: TLabel;
    dtpTanzimTar2: TDateTimePicker;
    Label1: TLabel;
    btn_Ara: TButton;
    dts_Liste: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    txtFisNo: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    TutarBas: TIB_Currency;
    Label4: TLabel;
    TutarSon: TIB_Currency;
    chkTutar: TCheckBox;
    cmdCancel: TBitBtn;
    btnTamam: TBitBtn;
    pnlRAPKOD: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
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
    cmbSube: TComboBox;
    qryMazot: TIB_Query;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    TutarBas1: TIB_Currency;
    TutarSon1: TIB_Currency;
    ChkLitre: TCheckBox;
    GroupBox3: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    TutarBas3: TIB_Currency;
    TutarSon3: TIB_Currency;
    ChkLitreFiyat: TCheckBox;
    GroupBox4: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    TutarBas2: TIB_Currency;
    TutarSon2: TIB_Currency;
    ChkTutarVpb: TCheckBox;
    txtArac: TEdit;
    Button6: TButton;
    LblPlaka: TLabel;
    txtAlanCari: TEdit;
    Button7: TButton;
    Label17: TLabel;
    txtAlanPers: TEdit;
    Button8: TButton;
    Label18: TLabel;
    TxtMazotcu: TEdit;
    Button9: TButton;
    Label19: TLabel;
    Btn_Rapor: TButton;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    CheckBox1: TCheckBox;
    cb_Tek_Satir: TCheckBox;
    procedure btnTamamClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure btn_AraClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    function  Form_Open(Menu:Boolean;Var MAZOT_FIS_ID:Integer;Var MAZOT_FIS_SID:Integer;RAPOR:Boolean):Boolean;OverLoad;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure txtISLEMMERKEZIExit(Sender: TObject);
    procedure txtKOD1Exit(Sender: TObject);
    procedure txtKOD2Exit(Sender: TObject);
    procedure txtKOD3Exit(Sender: TObject);
    procedure txtKOD4Exit(Sender: TObject);
    procedure IB_Grid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure dtpTanzimTar1Enter(Sender: TObject);
    procedure dtpTanzimTar1Exit(Sender: TObject);
    procedure cboISLEMEnter(Sender: TObject);
    procedure cboISLEMExit(Sender: TObject);
    procedure TutarBasEnter(Sender: TObject);
    procedure TutarBasExit(Sender: TObject);
    procedure txtFisNoExit(Sender: TObject);
    procedure chkRAPKODEnter(Sender: TObject);
    procedure chkRAPKODExit(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure TxtMazotcuExit(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure txtAlanCariExit(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure txtAracExit(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure txtAlanPersExit(Sender: TObject);
    procedure Btn_RaporClick(Sender: TObject);
    procedure IB_Grid1Click(Sender: TObject);
    procedure IB_Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAracKeyPress(Sender: TObject; var Key: Char);
    procedure txtAracKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAlanCariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAlanPersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TxtMazotcuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Grid1DblClick(Sender: TObject);
  private
    Prv_Arama_Fat:Boolean;
    prv_Aktarilan_Idler:String;
    { Private declarations }
  public
     Kontrol:Boolean;


function Form_Open(Menu:Boolean;Var MAZOT_FIS_ID:Integer;Var MAZOT_FIS_SID:Integer;
Alan_Cari:String;
Satan_Cari:String;
Giden_Id:TStringList;
var GidenQry:TIb_Query;
Tipi:Integer;
var Tek_Satir:Boolean

):Boolean;OverLoad;

    { Public declarations }
  end;
var
  frmMazotSDLG: TfrmMazotSDLG;

implementation

uses unDataMod,unFunc, DateUtils, ufrmCekSenSDLG, StdConvs, ufrmCariSDLG,
  ufrmRaporCiktisi;

{$R *.dfm}






function TfrmMazotSDLG.Form_Open(Menu:Boolean;Var MAZOT_FIS_ID:Integer;Var MAZOT_FIS_SID:Integer;
Alan_Cari:String;
Satan_Cari:String;
Giden_Id:TStringList;
var GidenQry:TIb_Query;
Tipi:Integer;
var Tek_Satir:Boolean
):Boolean;

var
say:Integer;
begin
  Application.CreateForm(TfrmMazotSDLG,frmMazotSDLG);


////////////////////////////////////////////////////////////
  with frmMazotSDLG do
  begin
       Prv_Arama_Fat:=True;
       qryMazot.FieldByName('SECIM').Visible:=True;
       TxtMazotcu.Text:=Satan_Cari;
       TxtMazotcu.Enabled:=False;
       Button9.Enabled:=False;

       CheckBox1.Checked:=False;
       CheckBox1.Enabled:=False;

     Panel1.Visible:=False;
     pnlRAPKOD.Visible:=False;
     Btn_Rapor.Visible:=False;


     prv_Aktarilan_Idler:=Giden_Id.CommaText;

  end;
////////////////////////////////////////////////////////////

  with frmMazotSDLG do
  begin
    //qryMazot.FieldByName('SECIM').Visible:=False;
    DataMod.Rapor_Kod_Visible_Fields('MAZOT'
                                     ,txtISLEMMERKEZI
                                     ,txtKOD1
                                     ,txtKOD2
                                     ,txtKOD3
                                     ,txtKOD4
                                     ,Button1
                                     ,Button2
                                     ,Button3
                                     ,Button4
                                     ,Button5
                                     ,Label8
                                     ,Label9
                                     ,Label10
                                     ,Label11
                                     ,Label12);
    dtpTanzimTar1.Date := glb_DONEM_BAS;
    dtpTanzimTar2.Date := DataMod.GET_SERVER_DATE;

    if glb_SUBELI then
    begin
      if glb_SUBE_MUDAHALE then
      begin
        DataMod.FillSubeStr(cmbSube.Items);
        with cmbSube do
        begin
          ItemIndex := 0;
          Visible := True;
        end;
      end
      else
      begin
        with cmbSube do
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
      cmbSube.Visible := False;
    end;

    TutarBas.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas1.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon1.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas2.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon2.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas3.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon3.DisplayFormat := glb_VPB_FIELD_PF;


    btn_AraClick(Self);
    ShowModal;


    if not Kontrol then
    begin
       MAZOT_FIS_ID:=0;
       MAZOT_FIS_SID:=0;

      Result := False;
    end
    else
    begin
       MAZOT_FIS_ID:=qryMazot.FieldByName('MAZOT_FIS_ID').AsInteger;
       MAZOT_FIS_SID:=qryMazot.FieldByName('MAZOT_FIS_SID').AsInteger;
      Result := True
    end;



{
    Qry.Active:=False;
    Qry.Sql.Text:=qryMazot.SQL.Text;
    Qry.Active:=True;
    qryMazot.DisableControls;
    qryMazot.First;

    While not qryMazot.Eof do
    begin
         if qryMazot.FieldByName('SECIM').AsString='1' then
         begin
             qry.Edit;
             qry.FieldByName('SECIM').AsString:='1';
             qry.post;
         end;
         qryMazot.Next;
    end;
    qryMazot.EnableControls;
}


    GidenQry:=qryMazot;
    Tek_Satir:=cb_Tek_Satir.Checked;

    say:=0;
    if Tek_Satir then
    begin
         qryMazot.First;
         While Not qryMazot.Eof Do
         begin
              if qryMazot.FieldByName('SECIM').AsString ='1' then
              Inc(Say);
              qryMazot.Next;
         end;
    end;
    if say<2 then Tek_Satir:=False;

    //qryMazot.CancelUpdates;
    //qryMazot.CommitUpdates;



//    Qry:=qryMazot;
    //qryMazot.Close;
    //Release;
  end;//with

end;


function TfrmMazotSDLG.Form_Open(Menu:Boolean;Var MAZOT_FIS_ID:Integer;Var MAZOT_FIS_SID:Integer;RAPOR:Boolean):Boolean;
begin
  Application.CreateForm(TfrmMazotSDLG,frmMazotSDLG);
  with frmMazotSDLG do
  begin
    cb_Tek_Satir.Visible:=False;
    
    if Rapor then
    begin
      Btn_Rapor.Visible := True;
    end
    else
    begin
      Btn_Rapor.Visible := False;
    end;

    qryMazot.FieldByName('SECIM').Visible:=False;
    DataMod.Rapor_Kod_Visible_Fields('MAZOT'
                                     ,txtISLEMMERKEZI
                                     ,txtKOD1
                                     ,txtKOD2
                                     ,txtKOD3
                                     ,txtKOD4
                                     ,Button1
                                     ,Button2
                                     ,Button3
                                     ,Button4
                                     ,Button5
                                     ,Label8
                                     ,Label9
                                     ,Label10
                                     ,Label11
                                     ,Label12);
    dtpTanzimTar1.Date := glb_DONEM_BAS;
    dtpTanzimTar2.Date := DataMod.GET_SERVER_DATE;

    if glb_SUBELI then
    begin
      if glb_SUBE_MUDAHALE then
      begin
        DataMod.FillSubeStr(cmbSube.Items);
        with cmbSube do
        begin
          ItemIndex := 0;
          Visible := True;
        end;
      end
      else
      begin
        with cmbSube do
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
      cmbSube.Visible := False;
    end;

    TutarBas.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas1.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon1.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas2.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon2.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas3.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon3.DisplayFormat := glb_VPB_FIELD_PF;

    ShowModal;


    if not Kontrol then
    begin
       MAZOT_FIS_ID:=0;
       MAZOT_FIS_SID:=0;

      Result := False;
    end
    else
    begin
       MAZOT_FIS_ID:=qryMazot.FieldByName('MAZOT_FIS_ID').AsInteger;
       MAZOT_FIS_SID:=qryMazot.FieldByName('MAZOT_FIS_SID').AsInteger;
      Result := True
    end;


    qryMazot.Close;
    Release;
  end;//with

end;

procedure TfrmMazotSDLG.btnTamamClick(Sender: TObject);
begin
  if (qryMazot.Active = True) then
  begin
    if not (qryMazot.RecordCount = 0) then
    begin
      Kontrol := True;
      Close;
    end
    else
    begin
      Kontrol := False;
      Close;
    end;
  end
  else
  if Application.MessageBox('Arama yapmadýnýz forma geri dönmek için YES Cýkmak için NO','Dikkat',MB_YESNO) = IDNO then
  begin
    Kontrol := False;
    Close;
  end;
end;

procedure TfrmMazotSDLG.cmdCancelClick(Sender: TObject);
begin
  Kontrol := False;
  Close;
end;

procedure TfrmMazotSDLG.btn_AraClick(Sender: TObject);
var
  WhereEk:Boolean;
  strSQL,SubeID:String;
begin
  {if lblKASA_KOD.Caption = '' then
  begin
    Application.MessageBox('Önce Kasa Seçmeniz Gerekiyor','Dikkat',MB_ICONSTOP);
    exit;
  end;  }
  //////////////////////////////////////////////////////////////////////////////
  WhereEk := False;
  strSQL :=
' SELECT MAZOT_FIS_ID '+#13+
'     , MAZOT_FIS_SID '+#13+
'     , ARAC_KOD '+#13+
'     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=MAZOT_FISI.ARAC_KOD) AS ARAC_PLAKA '+#13+
'     , FIS_NO '+#13+
'     , TARIH '+#13+
'     , SAAT '+#13+
'     , VEREN_PERSONEL_KOD '+#13+
'     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=MAZOT_FISI.VEREN_PERSONEL_KOD) AS VEREN_PERSONEL_ADI '+#13+
'     , ALAN_PERSONEL_KOD '+#13+
'     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=MAZOT_FISI.ALAN_PERSONEL_KOD) AS ALAN_PERSONEL_ADI '+#13+
'     , ALAN_CARI_KOD '+#13+
'     ,(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.ALAN_CARI_KOD=CARI.CARI_KOD) AS ALAN_CARI_ADI '+#13+
'     , MAZOTCU_CARI_KOD '+#13+
'     ,(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.MAZOTCU_CARI_KOD=CARI.CARI_KOD) AS MAZOTCU_CARI_ADI '+#13+
'     , KM '+#13+
'     , LITRE '+#13+
'     , LITRE_FIYAT '+#13+
'     , DOVKOD '+#13+
'     , DOV_BAZ_TAR '+#13+
'     , DOVKUR '+#13+
'     , TUTAR '+#13+
'     , TUTAR_VPB '+#13+
'     , ACIKLAMA '+#13+
'     , MASRAF_MERK '+#13+
'     , KOD1 '+#13+
'     , KOD2 '+#13+
'     , KOD3 '+#13+
'     , KOD4 '+#13+
'     , SEFER_ID '+#13+
'     , ALIS_URUN_HAR_ID '+#13+
'     , SECIM '+#13+
'     , ALIS_FATURASI_ALINDI'+#13+

' FROM MAZOT_FISI K ';
//' WHERE MAZOT_FIS_ID=:PRM_MAZOT_FIS_ID AND MAZOT_FIS_SID=:PRM_MAZOT_FIS_SID '


  if CheckBox1.State<>cbGrayed then
  if CheckBox1.Checked or (not CheckBox1.Checked)  then
  begin
    if WhereEk then
    begin
      if CheckBox1.Checked then
      strSQL := strSQL + ' AND K.ALIS_FATURASI_ALINDI =1 ';
      if not CheckBox1.Checked then
      strSQL := strSQL + ' AND K.ALIS_FATURASI_ALINDI =0 ';

    end
    else
    begin
      if CheckBox1.Checked then
      strSQL := strSQL + ' WHERE K.ALIS_FATURASI_ALINDI =1 ';
      if not CheckBox1.Checked then
      strSQL := strSQL + ' WHERE K.ALIS_FATURASI_ALINDI =0 ';

      WhereEk := True;
    end;//end if WhereEk then
  end;


  if txtFisNo.Text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.FIS_NO = '+ txtFisNo.text;
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.FIS_NO = '+ txtFisNo.text;
      WhereEk := True;
    end;//end if WhereEk then
  end;


    ////////////////////////////////////////////////////////////////////////
    if chkRAPKOD.Checked then
    begin
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD1 = '+ SQL_Katar(txtKOD1.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD1 = '+ SQL_Katar(txtKOD1.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD2 = ' +  SQL_Katar(txtKOD2.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD2 = ' + SQL_Katar(txtKOD2.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD3 = ' + SQL_Katar(txtKOD3.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD3 = '+ SQL_Katar(txtKOD3.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD4 = ' + SQL_Katar(txtKOD4.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD4 = ' + SQL_Katar(txtKOD4.Text);
          WhereEk := True;
        end
      end;
    //////////////////////////////////////////////////////////////////
    end;//end chkRAPKOD.checked
    ////////////////////////////////////////////////////////////////////////

    if chkTutar.Checked then
    begin
      if Trim(TutarBas.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.TUTAR >= '+ SQL_Para(TutarBas.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.TUTAR >= '+ SQL_Para(TutarBas.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.TUTAR <= '+ SQL_Para(TutarSon.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.TUTAR <= '+ SQL_Para(TutarSon.Value);
          WhereEk := True;
        end;
      end;
    end;



    if ChkLitre.Checked then
    begin
      if Trim(TutarBas1.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.LITRE >= '+ SQL_Para(TutarBas1.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.LITRE >= '+ SQL_Para(TutarBas1.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon1.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.LITRE <= '+ SQL_Para(TutarSon1.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.LITRE <= '+ SQL_Para(TutarSon1.Value);
          WhereEk := True;
        end;
      end;
    end;






    if ChkTutarVpb.Checked then
    begin
      if Trim(TutarBas2.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.TUTAR_VPB >= '+ SQL_Para(TutarBas2.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.TUTAR_VPB >= '+ SQL_Para(TutarBas2.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon2.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.TUTAR_VPB <= '+ SQL_Para(TutarSon2.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.TUTAR_VPB <= '+ SQL_Para(TutarSon2.Value);
          WhereEk := True;
        end;
      end;
    end;



    if ChkLitreFiyat.Checked then
    begin
      if Trim(TutarBas3.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.LITRE_FIYAT >= '+ SQL_Para(TutarBas3.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.LITRE_FIYAT >= '+ SQL_Para(TutarBas3.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon3.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.LITRE_FIYAT <= '+ SQL_Para(TutarSon3.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.LITRE_FIYAT <= '+ SQL_Para(TutarSon3.Value);
          WhereEk := True;
        end;
      end;
    end;
    /////////////////////////////////

    //////////////////////////////////////////////////////////////////////
    if ((dtpTanzimTar1.Checked=True) and (dtpTanzimTar2.Checked=False)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.TARIH = '+ SQL_Tarih(dtpTanzimTar1.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.TARIH = '+ SQL_Tarih(dtpTanzimTar1.date);
        WhereEk := True;
      end;
    end;
    //////////////////////////////////////////////////////////////////////
    if ((dtpTanzimTar1.Checked=False) and (dtpTanzimTar2.Checked=True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.TARIH <= '+ SQL_Tarih(dtpTanzimTar2.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.TARIH <= '+ SQL_Tarih(dtpTanzimTar2.date);
        WhereEk := True;
      end;
    end;
    /////////////////////////////////////////////////////////////////////////
    if ((dtpTanzimTar1.Checked=True) and (dtpTanzimTar2.Checked=True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.TARIH BETWEEN ' + SQL_Tarih(dtpTanzimTar1.date) + ' AND ' + SQL_Tarih(dtpTanzimTar2.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.TARIH BETWEEN ' + SQL_Tarih(dtpTanzimTar1.date) + ' AND ' + SQL_Tarih(dtpTanzimTar2.date);
        WhereEk := True;
      end;
    end;
    ////////////////////////////////////////////////////////////////////////////
    if glb_SUBELI then
    begin
      if WhereEk then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND K.MAZOT_FIS_SID = ' + SubeID;
        end;
      end
      else
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
           strSQL := strSQL + ' WHERE K.MAZOT_FIS_SID = ' + SubeID;
           WhereEk := True;
        end;
      end;
    end
    else
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.MAZOT_FIS_SID = ' + inttostr(glb_sid);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.MAZOT_FIS_SID = ' + inttostr(glb_sid);
        WhereEk := True;
      end;
    end;
    ////////////////////////////////////////////////////////////////////////////

      if Trim(txtArac.Text) <> '' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.ARAC_KOD = '+ SQL_Katar(Trim(txtArac.Text));
        end
        else
        begin
          strSQL := strSQL + ' Where K.ARAC_KOD = '+ SQL_Katar(Trim(txtArac.Text));
          WhereEk := True;
        end;


      end;


      if Trim(txtAlanPers.Text) <> '' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.ALAN_PERSONEL_KOD = '+ SQL_Katar(Trim(txtAlanPers.Text));
        end
        else
        begin
          strSQL := strSQL + ' Where K.ALAN_PERSONEL_KOD = '+ SQL_Katar(Trim(txtAlanPers.Text));
          WhereEk := True;
        end;

      end;

      if Trim(txtAlanCari.Text) <> '' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.ALAN_CARI_KOD = '+ SQL_Katar(Trim(txtAlanCari.Text));
        end
        else
        begin
          strSQL := strSQL + ' Where K.ALAN_CARI_KOD = '+ SQL_Katar(Trim(txtAlanCari.Text));
          WhereEk := True;
        end;

      end;


      if Trim(TxtMazotcu.Text) <> '' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.MAZOTCU_CARI_KOD = '+ SQL_Katar(Trim(TxtMazotcu.Text));
        end
        else
        begin
          strSQL := strSQL + ' where K.MAZOTCU_CARI_KOD = '+ SQL_Katar(Trim(TxtMazotcu.Text));
          WhereEk := True;
        end;

      end;


  if Length(Trim(prv_Aktarilan_Idler))>0 then
  begin
        prv_Aktarilan_Idler:='('+prv_Aktarilan_Idler+')';
        if WhereEk then
        begin
          strSQL := strSQL + ' AND NOT K.MAZOT_FIS_ID IN '+ prv_Aktarilan_Idler;
        end
        else
        begin
          strSQL := strSQL + ' Where NOT MAZOT_FIS_ID IN '+ prv_Aktarilan_Idler;
          WhereEk := True;
        end;
  end;

  //end;

strSQL := strSQL + ' ORDER BY MAZOT_FIS_ID ';

  ////////////////////////////////////////////////////////////////////////////
  try
    with qryMazot do
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
  if not Prv_Arama_Fat then
  IB_Grid1.SetFocus;
end;

procedure TfrmMazotSDLG.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then cmdCancelClick(self);
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

procedure TfrmMazotSDLG.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmMazotSDLG.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmMazotSDLG.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmMazotSDLG.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmMazotSDLG.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmMazotSDLG.txtISLEMMERKEZIExit(Sender: TObject);
begin
  if Length(trim(Self.txtISLEMMERKEZI.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtISLEMMERKEZI,0) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtISLEMMERKEZI.SetFocus;
  end;
end;

procedure TfrmMazotSDLG.txtKOD1Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD1.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD1,1) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD1.SetFocus;
  end;
end;

procedure TfrmMazotSDLG.txtKOD2Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD2.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD2,2) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD2.SetFocus;
  end;
end;

procedure TfrmMazotSDLG.txtKOD3Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD3.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD3,3) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD3.SetFocus;
  end;
end;

procedure TfrmMazotSDLG.txtKOD4Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD4.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD4,4) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD4.SetFocus;
  end;
end;

procedure TfrmMazotSDLG.IB_Grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
  begin
    Kontrol :=True;
    Close;
  end;
end;

procedure TfrmMazotSDLG.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmMazotSDLG);
  with frmMazotSDLG.qryMazot do
  begin
    FieldByName('LITRE_FIYAT').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('DOVKUR ').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_DOV_FIELD_PF;
  end;
end;

procedure TfrmMazotSDLG.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazotSDLG.dtpTanzimTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazotSDLG.dtpTanzimTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmMazotSDLG.cboISLEMEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazotSDLG.cboISLEMExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmMazotSDLG.TutarBasEnter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazotSDLG.TutarBasExit(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := clWindow;
end;

procedure TfrmMazotSDLG.txtFisNoExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmMazotSDLG.chkRAPKODEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazotSDLG.chkRAPKODExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmMazotSDLG.Button9Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
//  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,15) Then
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      TxtMazotcu.Text := Cari_KOD;
      Label19.Caption := Cari_AD;
  end;
end;

procedure TfrmMazotSDLG.TxtMazotcuExit(Sender: TObject);
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

procedure TfrmMazotSDLG.Button7Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      txtAlanCari.Text := Cari_KOD;
      Label17.Caption := Cari_AD;
  end;
end;

procedure TfrmMazotSDLG.txtAlanCariExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtAlanCari.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtAlanCari.Text,CARI_AD) then
    begin
      Label17.Caption := CARI_AD;
      if (Sender is TEdit) then
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txtAlanCari.SetFocus;
    end;
  end
  else
  begin
      if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow;
    Label17.Caption := '';
  end;

end;

procedure TfrmMazotSDLG.Button6Click(Sender: TObject);
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

procedure TfrmMazotSDLG.txtAracExit(Sender: TObject);
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

procedure TfrmMazotSDLG.Button8Click(Sender: TObject);
var
  PERSONEL_KOD, PERSONEL_AD :String;
begin
  if DataMod.LS_Personel(PERSONEL_KOD, PERSONEL_AD) then
  begin
    txtAlanPers.Text:=PERSONEL_KOD;
    Label18.Caption:=PERSONEL_AD;
  end;
end;

procedure TfrmMazotSDLG.txtAlanPersExit(Sender: TObject);
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

procedure TfrmMazotSDLG.Btn_RaporClick(Sender: TObject);
var
  row,col : integer;
  res_Cari : TStringList;
begin
  if not qryMazot.Active then
  begin
    Application.MessageBox('Arama iþlemi yapmadan rapor alamazsýnýz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  if qryMazot.RecordCount = 0 then
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
    {res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      SetCellText(row,col,res_Cari[1]);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    }
    inc(row);
{    case prv_Fatura_Tip of
    1:SetCellText(row,col,'MÜÞTERÝ SÝPARÝÞLERÝ LÝSTESÝ - ' + cmbFATURA_TIP.Text);
    2:SetCellText(row,col,'SATICI SÝPARÝÞLERÝ LÝSTESÝ - ' + cmbFATURA_TIP.Text);
    end;
}
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

    SetCellText(row,col,'Sýra No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Plaka');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Fiþ No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Tarih');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Saat');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Veren Personel Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Adý Soyadý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Alan Personel Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Adý Soyadý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Alan Cari Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Cari Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Mazotçu Cari Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Mazotçu Cari Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Kilometre');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Litre');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Litre Fiyatý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Tutar');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Açýklama');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Alýþ Faturasý Alýndý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(row);
    qryMazot.DisableControls;
    qryMazot.First;
    while not qryMazot.Eof do
    begin
      col := 0;

      SetCellText(row,col,qryMazot.FieldByName('MAZOT_FIS_ID').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ARAC_KOD').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ARAC_PLAKA').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('FIS_NO').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('TARIH').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('SAAT').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('VEREN_PERSONEL_KOD').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('VEREN_PERSONEL_ADI').AsString);

      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ALAN_CARI_KOD').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ALAN_CARI_ADI').AsString);

      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('MAZOTCU_CARI_KOD').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('MAZOTCU_CARI_ADI').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('KM').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('LITRE').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('LITRE_FIYAT').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('TUTAR_VPB').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ACIKLAMA').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ALIS_FATURASI_ALINDI').AsString);








      inc(row);
      qryMazot.Next;
    end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    inc(row);
    col := 7;
//    SetCellText(row,col,'=SUM(H4:H'+IntToStr(row-1)+')');
//    SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
   // SetCellFormat(4,3,4,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    format_ayarla(15,3,17,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
    grdA.EndUpdate;
    WindowState := wsMaximized;
  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  qryMazot.First;
  qryMazot.EnableControls;


end;

procedure TfrmMazotSDLG.IB_Grid1Click(Sender: TObject);
begin
//
end;

procedure TfrmMazotSDLG.IB_Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key=VK_Space then
      IB_Grid1DblClick(nil);
end;

procedure TfrmMazotSDLG.txtAracKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmMazotSDLG.txtAracKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then Button6Click(Self);
end;

procedure TfrmMazotSDLG.txtAlanCariKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then Button7Click(Self);
end;

procedure TfrmMazotSDLG.txtAlanPersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then Button8Click(Self);
end;

procedure TfrmMazotSDLG.TxtMazotcuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then Button9Click(Self);
end;

procedure TfrmMazotSDLG.IB_Grid1DblClick(Sender: TObject);
begin


  if qryMazot.FieldByName('MAZOT_FIS_ID').AsInteger>0 then
  begin
    if qryMazot.FieldByName('SECIM').AsInteger=1 then
    qryMazot.FieldByName('SECIM').AsInteger:=0
    else
    qryMazot.FieldByName('SECIM').AsInteger:=1;
    qryMazot.Post;
  end;
  
     if not Prv_Arama_Fat then
     btnTamamClick(Self);

end;

end.
