unit ufrmCARHAR_AKT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IB_Components;

type
  TfrmCARHAR_AKT = class(TForm)
    dtILKTAR: TDateTimePicker;
    dtSONTAR: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    txtSrcCari: TEdit;
    btnSrcSec: TButton;
    txtTgtCari: TEdit;
    btnTgtSec: TButton;
    btnAKTAR: TButton;
    Label3: TLabel;
    lblSrcCARIAD: TLabel;
    lblTgtCARIAD: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    chkMUHASEBE: TCheckBox;
    Function Form_Open(Menu:boolean):Boolean;
    procedure btnSrcSecClick(Sender: TObject);
    procedure btnTgtSecClick(Sender: TObject);
    procedure btnAKTARClick(Sender: TObject);
  private
    { Private declarations }
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
  end;
  const cns_carhar_aktar = 2;
var
  frmCARHAR_AKT: TfrmCARHAR_AKT;

implementation

uses ufrmCariSDLG, main,unDataMod,DateUtils, ufrmISN_ERRORS,unFunc,
  unLogger;

{$R *.dfm}
function TfrmCARHAR_AKT.Form_Open(Menu:Boolean):Boolean;
var
  local_can_update,local_can_delete : Boolean;
begin
  if not DataMod.Modul_Hak(cns_carhar_aktar,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application, 'frmCARHAR_AKT') then Application.CreateForm(TfrmCARHAR_AKT, frmCARHAR_AKT);
    with frmCARHAR_AKT do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      dtILKTAR.Date := glb_DONEM_BAS;
      dtSONTAR.Date := DataMod.GET_SERVER_DATE;
      ShowModal;
      Release;
    end;
    Result := True;
  end;
end;

procedure TfrmCARHAR_AKT.btnSrcSecClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) then
  begin
    txtSrcCari.Text := Cari_KOD;
    lblSrcCARIAD.Caption := Cari_AD;
  end;
end;

procedure TfrmCARHAR_AKT.btnTgtSecClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) then
  begin
    txtTgtCari.Text := Cari_KOD;
    lblTgtCARIAD.Caption := Cari_AD;
  end;
end;

procedure TfrmCARHAR_AKT.btnAKTARClick(Sender: TObject);
var
  qryCARI,qryHAR:TIB_Query;
  trnAKTARIM:TIB_Transaction;
  BELGE_ID,BELGE_SID : Integer;
  PRV_ISN:Integer;
  APPMsg:PChar;
  SRC_MUHAS_KOD,TGT_MUHAS_KOD:String;
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Aktarým iþlemini yapacak yetkiye sahip deðilsiniz.','Dikkat',MB_ICONSTOP);
    exit;
  end;

  if Application.MessageBox('Aktarým yapýlacak, Emin misiniz ?','Dikkat',MB_YESNO + MB_ICONQUESTION) = ID_NO then Exit;

  if Trim(txtSrcCari.Text) = '' then
  begin
    Application.MessageBox('Kaynak cari boþ olamaz.','Dikkat',MB_ICONHAND);
    txtSrcCari.SetFocus;
    Exit;
  end;

  if Trim(txtTgtCari.Text) = '' then
  begin
    Application.MessageBox('Hedef cari boþ olamaz.','Dikkat',MB_ICONHAND);
    txtTgtCari.SetFocus;
    Exit;
  end;

  if Trim(txtSrcCari.Text) = Trim(txtTgtCari.Text) then
  begin
    Application.MessageBox('Ýki Cari Ayný Olamaz.','Dikkat',MB_ICONHAND);
    txtSrcCari.SetFocus;
    Exit;
  end;


  try
    try
      DataMod.CreateTransaction(trnAKTARIM,tiCommitted,DataMod.dbaMain);
      DataMod.CreateQuery(qryHar,trnAKTARIM,False,DataMod.dbaMain);
      DataMod.CreateQuery(qryCari,trnAKTARIM,True,DataMod.dbaMain);
      with qryCARI do
      begin
        sql.Add('SELECT * FROM CARI WHERE CARI_KOD ='+ SQL_Katar(txtSrcCari.Text) );
        Active := True;
      end;
      //KAYNAK CARI SET EDILIYOR
      if qryCARI.RecordCount = 0 then
      begin
        Application.MessageBox('Belirtilen Kaynak Koduna ait CARI kaydý yok','Aktarým Baþarýsýz',MB_ICONHAND);
        qryCARI.Close;
        Exit;
      end;
//lite      else SRC_MUHAS_KOD := Trim(qryCARI.FieldByName('MUHASKOD').AsString);
      //HEDEF CARI SET EDILIYOR
      with qryCARI do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT * FROM CARI WHERE CARI_KOD ='+ SQL_Katar(txtTgtCari.Text));
        Active := True;
      end;

      if qryCARI.RecordCount = 0 then
      begin
        Application.MessageBox('Belirtilen Hedef Koduna ait CARI kaydý yok','Aktarým Baþarýsýz',MB_ICONHAND);
        qryCARI.Close;
        Exit;
      end;
//lite      else TGT_MUHAS_KOD := Trim(qryCARI.FieldByName('MUHASKOD').AsString);
      // TRANSACTION BASLADI HAYIRLI OLSUN
      qryCARI.Close;
      if trnAKTARIM.InTransaction then trnAKTARIM.Rollback;
      trnAKTARIM.StartTransaction;
      PRV_ISN := DataMod.Get_Isn_Num;

      with qryHAR do
      begin
        Close;
        SQL.Add('SELECT * FROM CARIHAR WHERE CARIHAR.CARI_KOD = '+ SQL_Katar(txtSrcCari.Text) + ' AND TARIH >= '+  SQL_Tarih(dtILKTAR.date) + ' AND TARIH <= '+ SQL_Tarih(dtSONTAR.date));
        Active := True;
      end;

      if qryHAR.RecordCount = 0 then
      begin
        APPMsg := PChar(txtSrcCari.Text + ' cari koduna ait hiçbir hareket kaydý bulunamadý iþlem sonlandýrýlýyor.');
        Application.MessageBox(AppMsg,'Dikkat',MB_ICONWARNING);
        exit;
      end;

      APPMsg := PChar(IntToStr(qryHAR.RecordCount) + ' Adet belge ve kayýtlarý güncellenecektir');
      Application.MessageBox(APPMsg,'Dikkat',MB_ICONINFORMATION);
      qryHAR.First;
      while not qryHAR.Eof do
      begin
        if not DataMod.CARIHAR_AUD(trnAKTARIM,
                                 qryHAR.FieldByName('BELGE_TUR').AsInteger,
                                 qryHAR.FieldByName('BELGE_ID').AsInteger,
                                 qryHAR.FieldByName('BELGE_SID').AsInteger,
                                 qryHAR.FieldByName('SIRA_NO').AsInteger,
                                 Trim(txtTgtCari.Text),
                                 qryHAR.FieldByName('TIP').AsString[1],
                                 qryHAR.FieldByName('TARIH').AsDate,
                                 qryHAR.FieldByName('FIILI_TAR').AsDate,
                                 qryHAR.FieldbyName('DOV_BAZ_TAR').AsDate,
                                 qryHAR.FieldbyName('TUTAR').AsCurrency,
                                 qryHAR.FieldbyName('DOVKOD').AsString,
                                 qryHAR.FieldbyName('DOVKUR').AsCurrency,
                                 qryHAR.FieldbyName('TUTAR_VPB').AsCurrency,
                                 qryHAR.FieldbyName('VADETAR').AsDate,
                                 ReplaceText(qryHAR.FieldbyName('ACIKLAMA').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text)),
                                 0,
                                 PRV_ISN,
                                 qryHAR.FieldbyName('MASRAF_MERK').AsString,
                                 qryHAR.FieldbyName('KOD1').AsString,
                                 qryHAR.FieldbyName('KOD2').AsString,
                                 qryHAR.FieldbyName('KOD3').AsString,
                                 qryHAR.FieldbyName('KOD4').AsString,
                                 qryHAR.FieldbyName('PLASIYER_KOD').AsString,
                                 qryHAR.FieldbyName('PROJE_KOD').AsString,
                                 BELGE_ID,
                                 BELGE_SID) then
        begin
          Application.MessageBox('Aktarým iþlemi yapýlamadý','Aktarým Baþarýsýz',MB_ICONHAND);
          trnAKTARIM.Rollback;
          exit;
        end;

        case qryHAR.FieldByName('BELGE_TUR').AsInteger of
        BT_ALIS_FAT,BT_SATIS_FAT,
        BT_SATIS_IRS,BT_ALIS_IRS:
        begin //FATURA
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.Add('SELECT * FROM FAT_IRS WHERE FAT_IRS_ID = ' + qryHAR.FieldByName('BELGE_ID').AsString + ' AND FAT_IRS_SID = '+ qryHAR.FieldByName('BELGE_SID').AsString);
            Open;
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            FieldByName('ACIKLAMA').AsString := ReplaceText(qryCARI.FieldByName('ACIKLAMA').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            Post;
          end;
        end;

        BT_MUSTERI_SIPARISI,BT_SATICI_SIPARISI:
        begin //FATURA
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.Add('SELECT * FROM SIPARIS WHERE FAT_IRS_ID = ' + qryHAR.FieldByName('BELGE_ID').AsString + ' AND FAT_IRS_SID = '+ qryHAR.FieldByName('BELGE_SID').AsString);
            Open;
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            FieldByName('ACIKLAMA').AsString := ReplaceText(qryCARI.FieldByName('ACIKLAMA').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            Post;
          end;
        end;


        BT_BORC_CEK,BT_MCEK_ALINDI:
        begin //CEK
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM CEK WHERE CEK_ID = ' + qryHAR.FieldByName('BELGE_ID').AsString + ' AND CEK_SID = '+ qryHAR.FieldByName('BELGE_SID').AsString);
            Open;
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            FieldByName('ACIKLAMA').AsString := ReplaceText(qryCARI.FieldByName('ACIKLAMA').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            Post;
          end;
        end;
        BT_BORC_SEN,BT_MSEN_ALINDI:
        begin //SENET
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM SENET WHERE SENET_ID = ' + qryHAR.FieldByName('BELGE_ID').AsString + ' AND SENET_SID = '+ qryHAR.FieldByName('BELGE_SID').AsString);
            Open;
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            FieldByName('ACIKLAMA').AsString := ReplaceText(qryCARI.FieldByName('ACIKLAMA').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            Post;
          end;
        end;
        BT_MCEK_CIRO,
        BT_MSEN_CIRO,
        BT_MCEK_IADE,
        BT_MSEN_IADE,
        BT_PORT_CEK_KARS,
        BT_PORT_SEN_KARS,
        BT_MCEK_TAHSIL_VER,
        BT_MSEN_TAHSIL_VER,
        BT_BANK_KARS_CEK,
        BT_BANK_PROT_SEN,
        BT_BANK_MCEK_TAH,
        BT_BANK_MSEN_TAH,
        BT_BORC_CEK_ODE,
        BT_BORC_CEK_IADE,
        BT_BORC_SEN_IADE,
        BT_SATICI_KARS_CEK,
        BT_SATICI_PROT_SEN:
        begin //CEKSENHAR
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM CEKSENHAR WHERE CEKSENHAR_ID = ' + qryHAR.FieldByName('BELGE_ID').AsString + ' AND CEKSENHAR_SID = '+ qryHAR.FieldByName('BELGE_SID').AsString);
            Open;
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            FieldByName('CARIHAR_ACK').AsString := ReplaceText(qryCARI.FieldByName('CARIHAR_ACK').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            FieldByName('YEVMIYE_ACK').AsString := ReplaceText(qryCARI.FieldByName('YEVMIYE_ACK').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            Post;
          end;
        end;
        BT_KASA:
        begin // KASA
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM KASAHAR WHERE KASAHAR_ID = ' + qryHAR.FieldByName('BELGE_ID').AsString + ' AND KASAHAR_SID = '+ qryHAR.FieldByName('BELGE_SID').AsString);
            Open;
            Edit;
            FieldByName('KARSIKOD').AsString := Trim(txtTgtCari.Text);
            FieldByName('ACIKLAMA').AsString := ReplaceText(qryCARI.FieldByName('ACIKLAMA').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            Post;
          end;
        end;
        BT_S_DEKONT:
        begin // DEKONT
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM DEKONT_D WHERE DEKONT_D_ID = ' + qryHAR.FieldByName('BELGE_ID').AsString + ' AND DEKONT_D_SID = '+ qryHAR.FieldByName('BELGE_SID').AsString);
            Open;
            Edit;
            FieldByName('KARSI_KOD').AsString := Trim(txtTgtCari.Text);
            FieldByName('ACIKLAMA1').AsString := ReplaceText(qryCARI.FieldByName('ACIKLAMA1').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            Post;
          end;
        end;

          {$IfDef TRANSPORT}
        BT_MAZOT,BT_MAZOT_CARI:
        begin //FATURA
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.Add('SELECT * FROM MAZOT_FISI WHERE MAZOT_FIS_ID = ' + qryHAR.FieldByName('BELGE_ID').AsString + ' AND MAZOT_FIS_SID = '+ qryHAR.FieldByName('BELGE_SID').AsString);
            Open;
            Edit;
            if FieldByName('ALAN_CARI_KOD').AsString = Trim(txtSrcCari.Text) then
            FieldByName('ALAN_CARI_KOD').AsString := Trim(txtTgtCari.Text);

            if FieldByName('MAZOTCU_CARI_KOD').AsString = Trim(txtSrcCari.Text) then
            FieldByName('MAZOTCU_CARI_KOD').AsString := Trim(txtTgtCari.Text);

            //FieldByName('ACIKLAMA').AsString := ReplaceText(qryCARI.FieldByName('ACIKLAMA').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            Post;
          end;
        end;

        BT_KOMISYON_FISI:
        begin //FATURA
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.Add('SELECT * FROM KOMISYON WHERE ID = ' + qryHAR.FieldByName('BELGE_ID').AsString + ' AND SID = '+ qryHAR.FieldByName('BELGE_SID').AsString);
            Open;
            Edit;
            if FieldByName('CARI_KOD').AsString = Trim(txtSrcCari.Text) then
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);

            //FieldByName('ACIKLAMA').AsString := ReplaceText(qryCARI.FieldByName('ACIKLAMA').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            Post;
          end;
        end;

        BT_SEFER:
        begin //FATURA
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.Add('SELECT * FROM SEFER WHERE SEFER_ID = ' + qryHAR.FieldByName('BELGE_ID').AsString + ' AND SEFER_SID = '+ qryHAR.FieldByName('BELGE_SID').AsString);
            Open;
            Edit;
            if FieldByName('ALICI_KOD').AsString = Trim(txtSrcCari.Text) then
            FieldByName('ALICI_KOD').AsString := Trim(txtTgtCari.Text);

            if FieldByName('SATICI_KOD').AsString = Trim(txtSrcCari.Text) then
            FieldByName('SATICI_KOD').AsString := Trim(txtTgtCari.Text);

            //FieldByName('ACIKLAMA').AsString := ReplaceText(qryCARI.FieldByName('ACIKLAMA').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            Post;
          end;
        end;


          {$EndIf}


          {$IfDef SERVIS}
        BT_ONARIM_FISI:
        begin //
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.Add('SELECT * FROM SRV_ARAC_ONARIM WHERE ID = ' + qryHAR.FieldByName('BELGE_ID').AsString + ' AND SID = '+ qryHAR.FieldByName('BELGE_SID').AsString);
            Open;
            Edit;
            if FieldByName('CARI_KOD').AsString = Trim(txtSrcCari.Text) then
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);

            //FieldByName('ACIKLAMA').AsString := ReplaceText(qryCARI.FieldByName('ACIKLAMA').AsString,Trim(txtSrcCari.Text),Trim(txtTgtCari.Text));
            Post;
          end;
        end;

          {$EndIf}



        else
        begin
          //SICTIK
          APPMsg := PChar('Tanýmlanamayan Belge Türü = '+ qryHAR.FieldByName('BELGE_TUR').AsString + ' . Lütfen Yazýlým yetkilinizle görüþünüz. Aktarým Baþarýsýz.');
          Application.MessageBox(APPMsg,'Aktarým Baþarýsýz',MB_ICONHAND);
          trnAKTARIM.Rollback;
          Exit;
        end;


        end; // CASE END





        qryHAR.Next;
      end;  // While Not qryHAR.Eof Then

      //***************************diðerleri**************************************

          {$IfDef TRANSPORT}
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM ARAC WHERE CARI_KOD='+SQL_Katar(txtSrcCari.Text));
            Open;
            if Recordcount>0 then
            begin
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            Post;
            end;
          end;
          {$EndIf}


          {$IfDef SERVIS}
          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM SRV_ARAC WHERE CARI_KOD='+SQL_Katar(txtSrcCari.Text));
            Open;
            if Recordcount>0 then
            begin
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            Post;
            end;
          end;
          {$EndIf}

          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM CARI_GRUP_UYE WHERE CARI_KOD='+SQL_Katar(txtSrcCari.Text));
            Open;
            if Recordcount>0 then
            begin
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            Post;
            end;
          end;


          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM DEKONT_D_AUT WHERE MC=''C'' AND KARSI_KOD='+SQL_Katar(txtSrcCari.Text));
            Open;
            if Recordcount>0 then
            begin
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            Post;
            end;
          end;


         { with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM SIPARIS WHERE CARI_KOD='+SQL_Katar(txtSrcCari.Text));
            Open;
            if Recordcount>0 then
            begin
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            Post;
            end;
          end;}


          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM URUN_CARI_FIY WHERE CARI_KOD='+SQL_Katar(txtSrcCari.Text));
            Open;
            if Recordcount>0 then
            begin
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            Post;
            end;
          end;


          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM URUN_TEDARIK WHERE CARI_KOD='+SQL_Katar(txtSrcCari.Text));
            Open;
            if Recordcount>0 then
            begin
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            Post;
            end;
          end;


          with qryCARI do
          begin
            Close;
            SQL.clear;
            SQL.ADD('SELECT * FROM CARI_SEVKAD WHERE CARI_KOD='+SQL_Katar(txtSrcCari.Text));
            Open;
            if Recordcount>0 then
            begin
            Edit;
            FieldByName('CARI_KOD').AsString := Trim(txtTgtCari.Text);
            Post;
            end;
          end;





      //***************************diðerleri son **************************************






      {Lite
      if chkMUHASEBE.Checked then
      begin
        if (SRC_MUHAS_KOD <> '') AND (TGT_MUHAS_KOD <> '') Then
        begin
          if SRC_MUHAS_KOD  <> TGT_MUHAS_KOD Then
          begin
            with qryCARI do
            begin
              Close;
              SQL.Clear;
              SQL.ADD('UPDATE MUH_FIS_GEC SET HESAP_KOD = ' +  SQL_Katar(TGT_MUHAS_KOD)  + ' WHERE HESAP_KOD = '+ SQL_Katar(SRC_MUHAS_KOD) + ' AND ISLEM_TAR  >= '+ SQL_Tarih(dtILKTAR.date) + ' AND ISLEM_TAR <= '+ SQL_Tarih(dtSONTAR.date));
              Execute;
              Close;
              SQL.Clear;
              SQL.ADD('UPDATE MUH_FIS SET HESAP_KOD = ' + SQL_Katar(TGT_MUHAS_KOD) + ' WHERE HESAP_KOD = '+ SQL_Katar(SRC_MUHAS_KOD) + ' AND ISLEM_TAR  >= '+ SQL_Tarih(dtILKTAR.date) + ' AND ISLEM_TAR <= '+ SQL_Tarih(dtSONTAR.date));
              Execute;
            end;
          end;
        end;
      end;
      }
      trnAKTARIM.Commit;
      dmLOGGER.Write2Log(0,0,0,0,1,'Kaynak : '+txtSrcCari.Text+' Hedef : '+txtTgtCari.Text+' Ýlk Tarih : '+SQL_Tarih(dtILKTAR.Date)+' Son Tarih : '+SQL_Tarih(dtSONTAR.Date),'CARI HAREKET AKTARIMI');
      Application.MessageBox('Aktarým baþarý ile tamamlanmýþtýr.','Baþarý',MB_ICONINFORMATION);
    except
      Application.MessageBox('Aktarým iþlemi yapýlamadý','Aktarým Baþarýsýz',MB_ICONHAND);
      trnAKTARIM.Rollback;
      raise;
    end;
  finally
    DataMod.ReleaseQuery(qryCARI);
    DataMod.ReleaseQuery(qryHar);
    DataMod.ReleaseTransaction(trnAKTARIM);
  end;
end;

end.
