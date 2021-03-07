{$INCLUDE directive.inc}

unit ufrmBAKIM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, CheckLst, Buttons, IB_Components, ComCtrls;

type
  TfrmBAKIM = class(TForm)
    Panel1: TPanel;
    txtRAPOR: TMemo;
    btnCikis: TBitBtn;
    prgISLEM: TProgressBar;
    lblKAYIT: TLabel;
    btnRaporKaydet: TButton;
    sDialog: TSaveDialog;
    Panel2: TPanel;
    grpCARI: TGroupBox;
    chkCARI_YETIM_KAY_TARA: TCheckBox;
    GroupBox1: TGroupBox;
    chklistCARI: TCheckListBox;
    chkCARI_BA_DUZELT: TCheckBox;
    rgCARI_BA_DUZ: TRadioGroup;
    chkYET_CARIHAR_SIL: TCheckBox;
    grpENTEGRE: TGroupBox;
    chkENT_YETIM_KAY_TARA: TCheckBox;
    chkENT_BA_TUTMAYAN_BELGE: TCheckBox;
    GroupBox2: TGroupBox;
    chklistENTEGRE: TCheckListBox;
    chkENT_DURUM_1_KAY_SIL: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    procedure Form_Open(Menu:Boolean);
    procedure btnCikisClick(Sender: TObject);
    Function  CARI_BA_DUZELT:Boolean;
    procedure AddLine2Report;
    procedure AddGroupHeader2Report(Header:String);
    procedure Add2Report(Line:String;Level:Byte);
    procedure AddProcessTime2Report;
    procedure ProcessTimeStop;
    procedure ProcessTimeStart;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Function CARI_BA_DUZELT_C_BA_AU:Boolean;



    Function BELGE_TUR2KOD(BELGE_TUR:Integer):String;
    procedure btnRaporKaydetClick(Sender: TObject);
    Function CARIHAR_YETIM_KAY(Transaction:TIB_Transaction):Boolean;
    procedure chkCARI_YETIM_KAY_TARAClick(Sender: TObject);
    procedure chkCARI_BA_DUZELTClick(Sender: TObject);
    Function CARIHAR_SIL(BELGE_TUR,BELGE_ID,BELGE_SID:Integer):Boolean;
    Function BELGE_BUL(BELGE_TUR,BELGE_ID,BELGE_SID:Integer;AddReport:Boolean;Hareket:Byte):Boolean;
    Function HAREKET_BUL(BELGE_ADI,REFERANS_TABLO:String;BELGE_ID,BELGE_SID:Integer;AddReport:Boolean;Hareket:Byte):Boolean;
    Function MUH_FIS_GEC_MOD_HAR:Boolean;
    Function CARIHAR_MOD_HAR:Boolean;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Panel2DblClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
    freq,n1, n2: TLargeInteger;
  public
    { Public declarations }
  end;

var
  frmBAKIM: TfrmBAKIM;

implementation

uses unDataMod,unFunc  {$IfDef TRANSPORT} ,ufrmButunluk_Kotrolu {$EndIf};

{$R *.dfm}

procedure TfrmBAKIM.Form_Open(Menu:Boolean);
begin
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  Application.CreateForm(TfrmBAKIM, frmBAKIM);
  frmBAKIM.ShowModal;
  frmBAKIM.Release;
end;

procedure TfrmBAKIM.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBAKIM.AddLine2Report;
begin
  txtRAPOR.Lines.Add('------------------------------------------------------------------------------------------');
end;

procedure TfrmBAKIM.AddGroupHeader2Report(Header:String);
begin
   AddLine2Report;
   txtRAPOR.Lines.Add('['+ Header +']');
   AddLine2Report;
end;

procedure TfrmBAKIM.Add2Report(Line:String;Level:Byte);
var i:Byte;
begin
   For i:= 0 to Level do
   begin
      Line := '    ' + Line;
   end;
   txtRAPOR.Lines.Add(Line);
end;

procedure TfrmBAKIM.ProcessTimeStart;
begin
  QueryPerformanceCounter(n1);
end;

procedure TfrmBAKIM.ProcessTimeStop;
begin
  QueryPerformanceCounter(n2);
end;

procedure TfrmBAKIM.AddProcessTime2Report;
var Saat,Dakika,saniye:Currency;
begin
   Saniye := Trunc((n2 - n1) / freq);
   Saat := Trunc(((n2 - n1) / freq) / (60 * 60));
   Dakika := Trunc((Saniye - (Saat * (60 * 60))) / 60);
   Saniye := Trunc(Saniye - ((Saat * (60*60))+ (Dakika * 60)));
   txtRAPOR.Lines.Add('Toplam iþlem süresi : ' + CurrToStr(saat) + ' Saat,' + CurrToStr(dakika) + ' dakika,' + CurrToStr(saniye) + ' saniye sürmüþtür ');
end;


Function TfrmBAKIM.CARI_BA_DUZELT:Boolean;
var
  qryCARI,qryCARI_DOV,qryCARIHAR:TIB_Query;
  trnISLEM:TIB_Transaction;
  BORC_TOP,ALACAK_TOP:Currency;
begin
  try
    try
      ProcessTimeStart;
      AddGroupHeader2Report('CARÝ BORÇ ALACAK DÜZENLEMESÝ');
      DataMod.CreateTransaction(trnISLEM , tiCommitted,DataMod.dbaMain);
      trnISLEM.StartTransaction;
      DataMod.CreateQuery(qryCARI,trnISLEM,True,DataMod.dbaMain);
      DataMod.CreateQuery(qryCARI_DOV,trnISLEM,True,DataMod.dbaMain);
      qryCARI.SQL.Add('SELECT * FROM CARI');
      qryCARI.open;
      Add2Report('Ýþlem yapýlacak Cari Kaydý Sayýsý: ' + IntToStr(qryCARI.RecordCount),1);
      DataMod.CreateQuery(qryCARIHAR,trnISLEM,False,DataMod.dbaMain);
      prgISLEM.Max := qryCARI.RecordCount;
      While not qryCARI.Eof do
      begin
        qryCARI.Edit;
        BORC_TOP := 0; ALACAK_TOP := 0;
        qryCARIHAR.Close;
        qryCARIHAR.SQL.Clear;
        qryCARIHAR.SQL.Add('SELECT SUM(TUTAR_VPB) AS TOPLAM_VPB FROM CARIHAR WHERE CARIHAR.TIP = ' + SQL_Katar(BORC)+ ' AND CARI_KOD = '+ SQL_Katar(qryCARI.FieldByName('CARI_KOD').AsString) +
                            ' AND CARIHAR.TARIH >= ' + SQL_Tarih(glb_DONEM_BAS) + ' AND CARIHAR.TARIH <= ' + SQL_Tarih(glb_DONEM_SON));
        qryCARIHAR.Open;
        qryCARI.FieldByName('BORC').AsCurrency := qryCARIHAR.FieldByName('TOPLAM_VPB').AsCurrency;
        qryCARIHAR.Close;
        qryCARIHAR.SQL.Clear;
        qryCARIHAR.SQL.Add('SELECT SUM(TUTAR_VPB) AS TOPLAM_VPB FROM CARIHAR WHERE CARIHAR.TIP = ' + SQL_Katar(ALACAK)+ ' AND CARI_KOD = '+ SQL_Katar(qryCARI.FieldByName('CARI_KOD').AsString) +
                            ' AND CARIHAR.TARIH >= ' + SQL_Tarih(glb_DONEM_BAS) + ' AND CARIHAR.TARIH <= ' + SQL_Tarih(glb_DONEM_SON));
        qryCARIHAR.Open;
        qryCARI.FieldByName('ALACAK').AsCurrency := qryCARIHAR.FieldByName('TOPLAM_VPB').AsCurrency;
        qryCARI.Post;
        qryCARI_DOV.Close;
        {TODO -oBURAK -cfrmBAKIM : CARIHAR_DOV üzerinden toplam}
        prgISLEM.StepIt;
        Application.ProcessMessages;
        qryCARI.Next;
      end;
      trnISLEM.Commit;
      Add2Report('CARÝ BORÇ ALACAK DÜZENLEMESÝ Baþarý ile tamamlandý',1);
      ProcessTimeStop;
      AddProcessTime2Report;
      Result := True;
    except
      Result := False;
      trnISLEM.Rollback;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryCARI);
    DataMod.ReleaseQuery(qryCARIHAR);
    DataMod.ReleaseTransaction(trnISLEM);
    prgISLEM.Position := 0;
  end;
end;

procedure TfrmBAKIM.Button1Click(Sender: TObject);
var trnISLEM:TIB_Transaction;
begin
 try
  txtRAPOR.Clear;
  DataMod.CreateTransaction(trnISLEM,tiCommitted,DataMod.dbaMain);
  if chkCARI_BA_DUZELT.Checked then
  begin
    case rgCARI_BA_DUZ.ItemIndex of
    0:CARI_BA_DUZELT;
    1:CARI_BA_DUZELT_C_BA_AU;
    end;
  end;
  if chkCARI_YETIM_KAY_TARA.Checked then
  begin
    if not CARIHAR_YETIM_KAY(trnISLEM) Then Exit;
  end;
  //MUH_FIS_GEC_MOD_HAR;
  CARIHAR_MOD_HAR;
 finally
   DataMod.ReleaseTransaction(trnISLEM);
 end;

end;

procedure TfrmBAKIM.FormCreate(Sender: TObject);
begin
 QueryPerformanceFrequency(frmBAKIM.freq);
  {$IfDef TRANSPORT}
      Button7.Visible:=True;
      Button8.Visible:=True;
  {$EndIf}
end;

Function TfrmBAKIM.CARI_BA_DUZELT_C_BA_AU:Boolean;
var qryCARI,qryCARIHAR:TIB_Query;
    trnISLEM:TIB_Transaction; ISLEM_ID,ISLEM_SID,ISN:Integer;
    LIMIT_ASIMI:Boolean;
begin
  try
    try
      ProcessTimeStart;
      AddGroupHeader2Report('CARÝ BORÇ ALACAK DÜZENLEMESÝ');
      DataMod.CreateTransaction(trnISLEM , tiCommitted,DataMod.dbaMain);
      trnISLEM.StartTransaction;
      DataMod.CreateQuery(qryCARI,trnISLEM,False,DataMod.dbaMain);
      qryCARI.SQL.Add('UPDATE CARI SET BORC = 0 , ALACAK = 0, RISK = 0');
      qryCARI.Execute;
      Add2Report('Carilerin Borç ve Alacaklarý temizlendi',1);
      qryCARI.SQL.Clear;
      qryCARI.SQL.Add('UPDATE CARI_DOV SET BORC = 0 , ALACAK = 0, RISK = 0');
      qryCARI.Execute;
      Add2Report('Carilerin Döviz Cinsinden Borç ve Alacaklarý temizlendi',1);
      DataMod.CreateQuery(qryCARIHAR,trnISLEM,False,DataMod.dbaMain);
      qryCARIHAR.SQL.Add('SELECT * FROM CARIHAR WHERE CARIHAR.TARIH >= ' + SQL_Tarih(glb_DONEM_BAS) + ' AND CARIHAR.TARIH <= ' + SQL_Tarih(glb_DONEM_SON));


      qryCARIHAR.Open;
      Add2Report('Ýþlenecek Cari Hareket Kaydý Sayýsý: ' + IntToStr(qryCARIHAR.RecordCount),1);
      prgISLEM.Max := qryCARIHAR.RecordCount;
      While not qryCARIHAR.Eof do
      begin
        if not DataMod.CARI_BA_UPDATE(trnISLEM,
                                      qryCARIHAR.FieldByName('CARI_KOD').AsString,
                                      qryCARIHAR.FieldByName('DOV_BAZ_TAR').AsDate,
                                      qryCARIHAR.FieldByName('DOVKOD').AsString,
                                      qryCARIHAR.FieldByName('DOVKUR').AsCurrency,
                                      qryCARIHAR.FieldByName('TUTAR').AsCurrency,
                                      qryCARIHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                      qryCARIHAR.FieldByName('TIP').AsString[1],
                                      'TfrmBAKIM.CARI_BA_DUZELT_C_BA_AU:',
                                      LIMIT_ASIMI) then
        begin
          Result:= False;
          trnISLEM.Rollback;
          Add2Report('DataMod.CARI_BA_UPDATE: Prosedüründe hata oluþtuðu için iþlem iptal edildi',1);
          ProcessTimeStop;
          AddProcessTime2Report;
          Exit;
        end;
        prgISLEM.StepIt;
        lblKAYIT.Caption := IntToStr(prgISLEM.Position);
        Application.ProcessMessages;
        qryCARIHAR.Next;
      end;
      trnISLEM.Commit;
      Add2Report('CARÝ BORÇ ALACAK DÜZENLEMESÝ Baþarý ile tamamlandý',1);
      ProcessTimeStop;
      AddProcessTime2Report;
      Result := True;
    except
      Result := False;
      trnISLEM.Rollback;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryCARI);
    DataMod.ReleaseQuery(qryCARIHAR);
    DataMod.ReleaseTransaction(trnISLEM);
    prgISLEM.Position := 0;
  end;
end;


Function TfrmBAKIM.BELGE_TUR2KOD(BELGE_TUR:Integer):String;
begin
  DataMod.FN_KOD2AD('BELGETUR','BELGE_TUR','BELGE_KOD',IntToStr(BELGE_TUR),Result);
end;

procedure TfrmBAKIM.btnRaporKaydetClick(Sender: TObject);
begin
  if sDialog.Execute then txtRAPOR.Lines.SaveToFile(sDialog.FileName);
end;

Function TfrmBAKIM.CARIHAR_YETIM_KAY(Transaction:TIB_Transaction):Boolean;
var qryCARIHAR:TIB_Query;
    Msg:Pchar;
begin
  try
    try
      ProcessTimeStart;
      prgISLEM.Position := 0;
      AddGroupHeader2Report('Yetim Cari Hareket Kayýtlarý Taramasý');
      DataMod.CreateQuery(qryCARIHAR,Transaction,False,DataMod.dbaMain);
      qryCARIHAR.SQL.Add('SELECT CARIHAR.BELGE_TUR,CARIHAR.BELGE_ID,CARIHAR.BELGE_SID FROM CARIHAR GROUP BY CARIHAR.BELGE_TUR,CARIHAR.BELGE_ID,CARIHAR.BELGE_SID');
      qryCARIHAR.Active := True;
      Add2Report('Taranacak Cari Hareket Kaydý Sayýsý: ' + IntToStr(qryCARIHAR.RecordCount),1);
      prgISLEM.Max := qryCARIHAR.RecordCount;
      while not qryCARIHAR.Eof do
      begin
        if not BELGE_BUL(qryCARIHAR.FieldByName('BELGE_TUR').AsInteger,qryCARIHAR.FieldByName('BELGE_ID').AsInteger,qryCARIHAR.FieldByName('BELGE_SID').AsInteger,True,1) then
        begin
           if chkYET_CARIHAR_SIL.Checked then
           begin
             if CARIHAR_SIL(qryCARIHAR.fieldbyname('BELGE_TUR').AsInteger,qryCARIHAR.fieldbyname('BELGE_ID').AsInteger,qryCARIHAR.fieldbyname('BELGE_SID').AsInteger) then
             begin
                Add2Report('Yetim Kayýt Silindi',1)
             end else
             begin
                Add2Report('Yetim Kayýt Silme iþlemi baþarýsýz !',1);
             end;
           end;
        end;
        qryCARIHAR.Next;
        prgISLEM.StepIt;
        lblKAYIT.Caption := IntToStr(prgISLEM.Position);
        Application.ProcessMessages;
      end; // while end
      Add2Report('Yetim Kayýt Taramasý bitti',1);
      ProcessTimeStop;
      AddProcessTime2Report;
      Result := True;
    except
      Result := False;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryCARIHAR);
    prgISLEM.Position := 0;
  end;
end;

Function TfrmBAKIM.CARIHAR_SIL(BELGE_TUR,BELGE_ID,BELGE_SID:Integer):Boolean;
var qryCHAR:TIB_Query;
    trnCARIHAR_SIL:TIB_Transaction;
    CARIHAR_ID,CARIHAR_SID:Integer;
begin
  try
     DataMod.CreateTransaction(trnCARIHAR_SIL,tiCommitted,DataMod.dbaMain);
     trnCARIHAR_SIL.StartTransaction;
     DataMod.CreateQuery(qryCHAR,trnCARIHAR_SIL,False,DataMod.dbaMain);
     qryCHAR.SQL.Add('SELECT * FROM CARIHAR WHERE BELGE_TUR = ' + IntToStr(BELGE_TUR) + ' AND BELGE_ID = '+ IntToStr(BELGE_ID) + ' AND BELGE_SID = ' + IntToStr(BELGE_SID));
     qryCHAR.Open;
     while not qryCHAR.Eof do
     begin
       if not DataMod.CARIHAR_AUD(trnCARIHAR_SIL,
                               qryCHAR.FieldByName('BELGE_TUR').AsInteger,
                               qryCHAR.FieldByName('BELGE_ID').AsInteger,
                               qryCHAR.FieldByName('BELGE_SID').AsInteger,
                               qryCHAR.FieldByName('SIRA_NO').AsInteger,
                               qryCHAR.FieldByName('CARI_KOD').AsString,
                               qryCHAR.FieldByName('TIP').AsString,
                               qryCHAR.FieldByName('TARIH').AsDate,
                               qryCHAR.FieldByName('FIILI_TAR').AsDate,
                               qryCHAR.FieldByName('DOV_BAZ_TAR').AsDate,
                               qryCHAR.FieldByName('TUTAR').AsCurrency,
                               qryCHAR.FieldByName('DOVKOD').AsString,
                               qryCHAR.FieldByName('DOVKUR').AsCurrency,
                               qryCHAR.FieldByName('TUTAR_VPB').AsCurrency,
                               qryCHAR.FieldByName('VADETAR').AsDate,
                               qryCHAR.FieldByName('ACIKLAMA').AsString,
                               1,0,qryCHAR.FieldByName('MASRAF_MERK').AsString,
                               qryCHAR.FieldByName('KOD1').AsString,
                               qryCHAR.FieldByName('KOD2').AsString,
                               qryCHAR.FieldByName('KOD3').AsString,
                               qryCHAR.FieldByName('KOD4').AsString,
                               qryCHAR.FieldByName('PLASIYER_KOD').AsString,
                               qryCHAR.FieldByName('PROJE_KOD').AsString,
                               CARIHAR_ID,
                               CARIHAR_SID) then
       begin
         Result:= False;
         trnCARIHAR_SIL.Rollback;
         Exit;
       end;
       qryCHAR.Next;
     end;
     trnCARIHAR_SIL.Commit;
     Result := True;
  except
    trnCARIHAR_SIL.Rollback;
    Result:= False;
    Raise;
  end;
end;

procedure TfrmBAKIM.chkCARI_YETIM_KAY_TARAClick(Sender: TObject);
begin
   if chkCARI_YETIM_KAY_TARA.Checked then
   begin
      chkYET_CARIHAR_SIL.Enabled := True;
   end else
   begin
      chkYET_CARIHAR_SIL.Enabled := False;
      chkYET_CARIHAR_SIL.Checked := False;
   end;
end;

procedure TfrmBAKIM.chkCARI_BA_DUZELTClick(Sender: TObject);
begin
   if chkCARI_BA_DUZELT.Checked then
   begin
      rgCARI_BA_DUZ.Enabled := True;
   end else
   begin
      rgCARI_BA_DUZ.Enabled := False;
   end;
end;

Function TfrmBAKIM.BELGE_BUL(BELGE_TUR,BELGE_ID,BELGE_SID:Integer;AddReport:Boolean;Hareket:Byte):Boolean;
var qryBELGE:TIB_Query;
    msg:PChar;
begin
Result := True;
 try
   try
      DataMod.CreateQuery(qryBELGE,Nil,False,DataMod.dbaMain);
        case BELGE_TUR of
          BT_ALIS_FAT,BT_SATIS_FAT://FATURA
            begin
              with qryBELGE do
              begin
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT * FROM FAT_IRS WHERE FAT_IRS_ID = '+IntToStr(BELGE_ID) + ' AND FAT_IRS_SID = '+IntToStr(BELGE_SID));
                Active := True;
              end;
              if qryBELGE.RecordCount = 0 then
              begin
                Result := False;
                if AddReport then Add2Report('BELGE : FATURA : BELGE_ID = '+IntToStr(BELGE_ID)+' BELGE_SID = '+IntToStr(BELGE_SID),1);
              end;
            end;

          BT_MCEK_CIRO,
          BT_MSEN_CIRO,
          BT_MCEK_TAHSIL_VER,
          BT_MSEN_TAHSIL_VER,
          BT_BANK_MCEK_TAH,
          BT_BANK_MSEN_TAH,
          BT_PORT_CEK_KARS,
          BT_PORT_SEN_KARS,
          BT_SATICI_KARS_CEK,
          BT_SATICI_PROT_SEN,
          BT_BANK_KARS_CEK,
          BT_BANK_PROT_SEN,
          BT_BORC_CEK_ODE,
          BT_MCEK_IADE,
          BT_MSEN_IADE,
          BT_BORC_CEK_IADE,
          BT_BORC_SEN_IADE,
          BT_KASA_CEKSEN_TAH,
          BT_KASA_CEKSEN_TED:// CEKSENHAR
            begin
              with qryBELGE do
              begin
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT * FROM CEKSENHAR WHERE CEKSENHAR_ID = '+IntToStr(BELGE_ID)+ ' AND CEKSENHAR_SID = '+IntToStr(BELGE_SID));
                Active := true;
              end;
              if qryBELGE.RecordCount = 0 then
              begin
                Result := False;
                if AddReport then Add2Report('BELGE : CEKSENHAR : BELGE_ID = '+IntToStr(BELGE_ID)+' BELGE_SID = '+IntToStr(BELGE_SID),1);
              end;
            end;

          BT_BORC_CEK,BT_MCEK_ALINDI://CEK
            begin
              with qryBELGE do
              begin
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT * FROM CEK WHERE CEK_ID = '+IntToStr(BELGE_ID) + ' AND CEK_SID = '+IntToStr(BELGE_SID));
                Active := true;
              end;
              if qryBELGE.RecordCount = 0 then
              begin
                Result := False;
                if AddReport then Add2Report('BELGE : CEK :  BELGE_ID = '+IntToStr(BELGE_ID)+' BELGE_SID = '+IntToStr(BELGE_SID),1);
              end;
            end;

          BT_BORC_SEN,BT_MSEN_ALINDI://SENET
            begin
              with qryBELGE do
              begin
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT * FROM SENET WHERE SENET_ID = '+IntToStr(BELGE_ID)+ ' AND SENET_SID = '+IntToStr(BELGE_SID));
                Active := true;
              end;
              if qryBELGE.RecordCount = 0 then
              begin
                Result := False;
                if AddReport then Add2Report('BELGE : SENET BELGE_ID = '+IntToStr(BELGE_ID)+' BELGE_SID = '+IntToStr(BELGE_SID),1);
              end;
            end;

          BT_KASA://KASAHAR
             begin
                with qryBELGE do
                begin
                  Active := False;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM KASAHAR WHERE KASAHAR_ID = '+IntToStr(BELGE_ID)+ ' AND KASAHAR_SID = '+IntToStr(BELGE_SID));
                  Active := true;
                end;
                if qryBELGE.RecordCount = 0 then
                begin
                Result := False;
                if AddReport then Add2Report('BELGE : KASAHAR BELGE_ID = '+IntToStr(BELGE_ID)+' BELGE_SID = '+IntToStr(BELGE_SID),1);
                end;
             end;
          BT_S_DEKONT://DEKONT
             begin
              with qryBELGE do
              begin
                Active := False;
                SQL.Clear;
                case Hareket of
                 1: begin//Cari  hareket
                      SQL.Add('SELECT * FROM DEKONT_D WHERE DEKONT_D_ID = '+IntToStr(BELGE_ID)+ ' AND DEKONT_D_SID = '+IntToStr(BELGE_SID));
                    end;
                 2: begin // MUH_FIS_GEC
                      SQL.Add('SELECT * FROM DEKONT WHERE DEKONT_ID = '+IntToStr(BELGE_ID)+ ' AND DEKONT_SID = '+IntToStr(BELGE_SID));
                    end;
                end;
                Active := true;
              end;
              if qryBELGE.RecordCount = 0 then
              begin
                Result := False;
                if AddReport then Add2Report('BELGE : DEKONT : BELGE_ID = '+IntToStr(BELGE_ID)+' BELGE_SID = '+IntToStr(BELGE_SID),1);
              end;
             end;
          BT_SEFER://SEFER
             begin
                with qryBELGE do
                begin
                  Active := False;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM SEFER WHERE SEFER_ID = '+IntToStr(BELGE_ID)+ ' AND SEFER_SID = '+IntToStr(BELGE_SID));
                  Active := true;
                end;
                if qryBELGE.RecordCount = 0 then
                begin
                Result := False;
                if AddReport then Add2Report('BELGE : SEFER BELGE_ID = '+IntToStr(BELGE_ID)+' BELGE_SID = '+IntToStr(BELGE_SID),1);
                end;
             end;
          BT_MAZOT://MAzot
             begin
                with qryBELGE do
                begin
                  Active := False;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM MAZOT_FISI WHERE MAZOT_FIS_ID = '+IntToStr(BELGE_ID)+ ' AND MAZOT_FIS_SID = '+IntToStr(BELGE_SID));
                  Active := true;
                end;
                if qryBELGE.RecordCount = 0 then
                begin
                Result := False;
                if AddReport then Add2Report('BELGE : MAZOT_FISI BELGE_ID = '+IntToStr(BELGE_ID)+' BELGE_SID = '+IntToStr(BELGE_SID),1);
                end;
             end;


          BT_MAZOT_CARI://MAzot
             begin
                with qryBELGE do
                begin
                  Active := False;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM MAZOT_FISI WHERE MAZOT_FIS_ID = '+IntToStr(BELGE_ID)+ ' AND MAZOT_FIS_SID = '+IntToStr(BELGE_SID));
                  Active := true;
                end;
                if qryBELGE.RecordCount = 0 then
                begin
                Result := False;
                if AddReport then Add2Report('BELGE : MAZOT_FISI_CARI BELGE_ID = '+IntToStr(BELGE_ID)+' BELGE_SID = '+IntToStr(BELGE_SID),1);
                end;
             end;



          BT_ONARIM_FISI:// servis onarým fiþi
             begin
                with qryBELGE do
                begin
                  Active := False;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM SRV_ARAC_ONARIM WHERE ONARIM_ID = '+IntToStr(BELGE_ID)+ ' AND ONARIM_SID = '+IntToStr(BELGE_SID));
                  Active := true;
                end;
                if qryBELGE.RecordCount = 0 then
                begin
                Result := False;
                if AddReport then Add2Report('BELGE : ONARIM_FISI BELGE_ID = '+IntToStr(BELGE_ID)+' BELGE_SID = '+IntToStr(BELGE_SID),1);
                end;
             end;


          else
             begin
               msg := Pchar(IntToStr(BELGE_TUR) + ' No lu belge tipi ile ilgili tarama rutini geliþtirilmemiþ lütfen yazýlým firmasýna bildiriniz');
               Application.MessageBox(msg,'Dikkat',MB_ICONSTOP);
                Result := False;
                if AddReport then Add2Report( IntToStr(BELGE_TUR) + ' No lu belge tipi ile ilgili tarama rutini geliþtirilmemiþ lütfen yazýlým firmasýna bildiriniz',1);
             end;
      end;//end case
   except
      Result := False;
      Raise;
   end;
 finally
   Datamod.ReleaseQuery(qryBELGE);
 end;
end;

Function TfrmBAKIM.HAREKET_BUL(BELGE_ADI,REFERANS_TABLO:String;BELGE_ID,BELGE_SID:Integer;AddReport:Boolean;Hareket:Byte):Boolean;
var qryHAREKET:TIB_Query;
    msg:PChar;
begin
  Result := True;
  try
    try
      DataMod.CreateQuery(qryHAREKET,Nil,False,DataMod.dbaMain);
      case Hareket of
      1: begin //Cari  hareket
           qryHAREKET.SQL.Add('SELECT BELGE_ID FROM CARIHAR WHERE BELGE_TUR IN  (' + DataMod.GetBelgeTurFromRefTable(REFERANS_TABLO)  + ') AND BELGE_ID = ' + IntToStr(BELGE_ID) + ' AND BELGE_SID = ' + IntToStr(BELGE_SID));
         end;
      end; //end case
      qryHAREKET.Open;
      if qryHAREKET.RecordCount = 0 then
      begin
        Result := False;
        if AddReport then Add2Report('BELGE : ' + BELGE_ADI + ' BELGE_ID = '+IntToStr(BELGE_ID)+' BELGE_SID = '+IntToStr(BELGE_SID),1);
      end;
    except
      Result := False;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryHAREKET);
  end;
end;

Function TfrmBAKIM.MUH_FIS_GEC_MOD_HAR:Boolean;
var qryBELGE:TIB_Query;
begin
 try
   try
     Result := True;
     DataMod.CreateQuery(qryBELGE,Nil,False,DataMod.dbaMain);
     if chklistENTEGRE.Checked[0] then // Fatura
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('FATURA Entegrasyon Kaydý Taramasý');
       qryBELGE.SQL.Add('SELECT FAT_IRS_ID, FAT_IRS_SID FROM FAT_IRS');
       qryBELGE.Open;
       Add2Report('Taranacak Fatura Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('FATURA','FAT_IRS',qryBELGE.FieldByName('FAT_IRS_ID').AsInteger,qryBELGE.FieldByName('FAT_IRS_SID').AsInteger,True,2);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;
     if chklistENTEGRE.Checked[1] then // ÇEK
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('Çek Entegrasyon Kaydý Taramasý');
       qryBELGE.Close;
       qryBELGE.SQL.Clear;
       qryBELGE.SQL.Add('SELECT CEK_ID, CEK_SID FROM CEK WHERE CEK.TANZIMTAR >= ' + SQL_Tarih(glb_DONEM_BAS));
       qryBELGE.Open;
       Add2Report('Taranacak CEK Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('Çek','CEK',qryBELGE.FieldByName('CEK_ID').AsInteger,qryBELGE.FieldByName('CEK_SID').AsInteger,True,2);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;

     if chklistENTEGRE.Checked[2] then // SENET
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('Senet Entegrasyon Kaydý Taramasý');
       qryBELGE.Close;
       qryBELGE.SQL.Clear;
       qryBELGE.SQL.Add('SELECT SENET_ID, SENET_SID FROM SENET WHERE SENET.TANZIMTAR >= ' + SQL_Tarih(glb_DONEM_BAS));
       qryBELGE.Open;
       Add2Report('Taranacak SENET Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('SENET','SENET',qryBELGE.FieldByName('SENET_ID').AsInteger,qryBELGE.FieldByName('SENET_SID').AsInteger,True,2);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;

     if chklistENTEGRE.Checked[3] then // CEKSENHAR
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('Çek Senet Hareketleri Entegrasyon Kaydý Taramasý');
       qryBELGE.Close;
       qryBELGE.SQL.Clear;
       qryBELGE.SQL.Add('SELECT CEKSENHAR_ID, CEKSENHAR_SID FROM CEKSENHAR WHERE CEKSENHAR.ISLEM_TAR >= ' + SQL_Tarih(glb_DONEM_BAS) + ' AND ISLEM NOT IN (1,15) ORDER BY CEKSENHAR_ID' );
       qryBELGE.Open;
       Add2Report('Taranacak CEKSENHAR Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('CEKSENHAR','CEKSENHAR',qryBELGE.FieldByName('CEKSENHAR_ID').AsInteger,qryBELGE.FieldByName('CEKSENHAR_SID').AsInteger,True,2);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;

     if chklistENTEGRE.Checked[4] then // Dekont
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('Dekont Hareketleri Entegrasyon Kaydý Taramasý');
       qryBELGE.Close;
       qryBELGE.SQL.Clear;
       qryBELGE.SQL.Add('SELECT DEKONT_ID, DEKONT_SID FROM DEKONT WHERE DEKONT.ISLEM_TAR >= ' + SQL_Tarih(glb_DONEM_BAS) + ' ORDER BY DEKONT_ID' );
       qryBELGE.Open;
       Add2Report('Taranacak DEKONT Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('DEKONT','DEKONT',qryBELGE.FieldByName('DEKONT_ID').AsInteger,qryBELGE.FieldByName('DEKONT_SID').AsInteger,True,2);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;

     if chklistENTEGRE.Checked[5] then // KASAHAR
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('Kasa Hareketleri Entegrasyon Kaydý Taramasý');
       qryBELGE.Close;
       qryBELGE.SQL.Clear;
       qryBELGE.SQL.Add('SELECT KASAHAR_ID, KASAHAR_SID FROM KASAHAR WHERE KASAHAR.TARIH >= ' + SQL_Tarih(glb_DONEM_BAS) + ' AND KASAHAR.SIRA_NO <> 0 AND KASAHAR.ISLEM_TIP NOT IN (3,4) AND NOT (KASAHAR.ISLEM_TIP= 6 AND KASAHAR.SIRA_NO = 2) ORDER BY KASAHAR_ID' );
       qryBELGE.Open;
       Add2Report('Taranacak KASA HAREKET Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('KASAHAR','KASAHAR',qryBELGE.FieldByName('KASAHAR_ID').AsInteger,qryBELGE.FieldByName('KASAHAR_SID').AsInteger,True,2);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;

   except
      Result := False;
   end;
 finally
   DataMod.ReleaseQuery(qryBELGE);
 end;
end;

Function TfrmBAKIM.CARIHAR_MOD_HAR:Boolean;
var qryBELGE:TIB_Query;
begin
 try
   try
     Result := True;
     DataMod.CreateQuery(qryBELGE,Nil,False,DataMod.dbaMain);
     if chklistCARI.Checked[0] then // Fatura
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('FATURA Cari Hareket Kaydý Taramasý');
       qryBELGE.SQL.Add('SELECT FAT_IRS_ID, FAT_IRS_SID FROM FAT_IRS');
       qryBELGE.Open;
       Add2Report('Taranacak Fatura Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('FATURA','FAT_IRS',qryBELGE.FieldByName('FAT_IRS_ID').AsInteger,qryBELGE.FieldByName('FAT_IRS_SID').AsInteger,True,1);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;

     if chklistCARI.Checked[1] then // ÇEK
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('Çek Cari Hareket kaydý Taramasý');
       qryBELGE.Close;
       qryBELGE.SQL.Clear;
       qryBELGE.SQL.Add('SELECT CEK_ID, CEK_SID FROM CEK WHERE CEK.TANZIMTAR >= ' + SQL_Tarih(glb_DONEM_BAS));
       qryBELGE.Open;
       Add2Report('Taranacak CEK Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('Çek','CEK',qryBELGE.FieldByName('CEK_ID').AsInteger,qryBELGE.FieldByName('CEK_SID').AsInteger,True,1);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;

     if chklistCARI.Checked[2] then // SENET
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('Senet Cari Hareket Kaydý Taramasý');
       qryBELGE.Close;
       qryBELGE.SQL.Clear;
       qryBELGE.SQL.Add('SELECT SENET_ID, SENET_SID FROM SENET WHERE SENET.TANZIMTAR >= ' + SQL_Tarih(glb_DONEM_BAS));
       qryBELGE.Open;
       Add2Report('Taranacak SENET Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('SENET','SENET',qryBELGE.FieldByName('SENET_ID').AsInteger,qryBELGE.FieldByName('SENET_SID').AsInteger,True,1);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;

     if chklistCARI.Checked[3] then // CEKSENHAR
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('Çek Senet Hareketleri Cari Hareket Kaydý Taramasý');
       qryBELGE.Close;
       qryBELGE.SQL.Clear;
       qryBELGE.SQL.Add('SELECT CEKSENHAR_ID, CEKSENHAR_SID FROM CEKSENHAR WHERE CEKSENHAR.ISLEM_TAR >= ' + SQL_Tarih(glb_DONEM_BAS) + ' AND ISLEM IN (3,4,6,8,16,17) ORDER BY CEKSENHAR_ID' );
       qryBELGE.Open;
       Add2Report('Taranacak CEKSENHAR Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('CEKSENHAR','CEKSENHAR',qryBELGE.FieldByName('CEKSENHAR_ID').AsInteger,qryBELGE.FieldByName('CEKSENHAR_SID').AsInteger,True,1);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;

     if chklistCARI.Checked[4] then // Dekont
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('Dekont Hareketleri Cari Hareket Kaydý Taramasý');
       qryBELGE.Close;
       qryBELGE.SQL.Clear;
       qryBELGE.SQL.Add('SELECT DEKONT_D_ID, DEKONT_D_SID FROM DEKONT_D WHERE DEKONT_D.MC = ' + SQL_Katar('C') + ' ORDER BY DEKONT_ID' );
       qryBELGE.Open;
       Add2Report('Taranacak DEKONT_D Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('DEKONT_D','DEKONTHAR',qryBELGE.FieldByName('DEKONT_D_ID').AsInteger,qryBELGE.FieldByName('DEKONT_D_SID').AsInteger,True,1);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;

     if chklistCARI.Checked[5] then // KASAHAR
     begin
       ProcessTimeStart;
       prgISLEM.Position := 0;
       AddGroupHeader2Report('Kasa Hareketleri Cari Hareket Kaydý Taramasý');
       qryBELGE.Close;
       qryBELGE.SQL.Clear;
       qryBELGE.SQL.Add('SELECT KASAHAR_ID, KASAHAR_SID FROM KASAHAR WHERE KASAHAR.MC = ' + SQL_Katar('C') + ' ORDER BY KASAHAR_ID' );
       qryBELGE.Open;
       Add2Report('Taranacak KASA HAREKET Kaydý Sayýsý: ' + IntToStr(qryBELGE.RecordCount),1);
       prgISLEM.Max := qryBELGE.RecordCount;
       while not  qryBELGE.Eof do
       begin
         HAREKET_BUL('KASAHAR','KASAHAR',qryBELGE.FieldByName('KASAHAR_ID').AsInteger,qryBELGE.FieldByName('KASAHAR_SID').AsInteger,True,1);
         qryBELGE.Next;
         prgISLEM.StepIt;
         lblKAYIT.Caption := IntToStr(prgISLEM.Position);
         Application.ProcessMessages;
       end;
       ProcessTimeStop;
       AddProcessTime2Report;
     end;

   except
      Result := False;
   end;
 finally
   DataMod.ReleaseQuery(qryBELGE);
 end;
end;


procedure TfrmBAKIM.Button2Click(Sender: TObject);
var qryExecuter,qryURUNHAR:TIB_Query;
    HAREKET_TIP:Char;
    trnURUNHAR:TIB_Transaction;
    i:Integer;
begin
   try
     Datamod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
     DataMod.CreateQuery(qryURUNHAR,Nil,False,Datamod.dbaMain);
     DataMod.CreateTransaction(trnURUNHAR,tiCommitted,DataMod.dbaMain);

     qryExecuter.SQL.Add('UPDATE URUN SET BORC=0,ALACAK = 0,BORC_VPB=0,ALACAK_VPB = 0,BORC=0,ALACAK = 0,MIKTAR_BORC=0,MIKTAR_ALACAK = 0');
     qryExecuter.Execute;
     with qryURUNHAR do
     begin
       SQL.Add('SELECT * FROM URUNHAR');
       Open;
       First;
       if qryURUNHAR.Eof then Exit;
       trnURUNHAR.StartTransaction;
       i := 0;
       repeat
          inc(i);
          if (qryURUNHAR.FieldByName('URUN_KOD').AsString <> '') Then
          begin
            if not DataMod.URUN_HAR_AUD(trnURUNHAR,
                                        FieldByName('URUN_KOD').AsString,
                                        FieldByName('DEPO_KOD').AsString,
                                        FieldByName('TIP').AsString[1],
                                        FieldByName('TUTAR_URUN_DOVKOD').AsCurrency,
                                        FieldByName('TUTAR_VPB').AsCurrency,
                                        FieldByName('MIKTAR_URN_OB').AsCurrency) then
            begin
              Exit;
            end;
          end;
          qryURUNHAR.Next;
          if i = 100 then
          begin
            trnURUNHAR.Commit;
            trnURUNHAR.StartTransaction;
            i:= 0;
          end;
       until Eof;
     end;
     if trnURUNHAR.InTransaction then trnURUNHAR.Commit;
   finally
     DataMod.ReleaseQuery(qryExecuter);
     DataMod.ReleaseQuery(qryURUNHAR);
     DataMod.ReleaseTransaction(trnURUNHAR);
   end;
end;

procedure TfrmBAKIM.Button3Click(Sender: TObject);
var qryExecuter,qryCARIHAR:TIB_Query;
    HAREKET_TIP:Char;
    trnURUNHAR:TIB_Transaction;
    i:Integer;
    Donen_Deger:Boolean;
    LIMIT_ASIMI:Boolean;
begin
   try
     Datamod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
     DataMod.CreateQuery(qryCARIHAR,Nil,False,Datamod.dbaMain);
     DataMod.CreateTransaction(trnURUNHAR,tiCommitted,DataMod.dbaMain);

     qryExecuter.SQL.Clear;
     qryExecuter.SQL.Add('UPDATE CARI SET BORC = 0, ALACAK = 0, RISK = 0');
     qryExecuter.Execute;

     qryExecuter.SQL.Clear;
     qryExecuter.SQL.Add('DELETE FROM CARIHAR_DOV');
     qryExecuter.Execute;

     qryExecuter.SQL.Clear;
     qryExecuter.SQL.Add('DELETE FROM CARI_AY');
     qryExecuter.Execute;

     qryExecuter.SQL.Clear;
     qryExecuter.SQL.Add('DELETE FROM CARI_DOV');
     qryExecuter.Execute;



     with qryCARIHAR do
     begin
       SQL.Add('SELECT * FROM CARIHAR');
       Open;
       First;
       if qryCARIHAR.Eof then Exit;
       trnURUNHAR.StartTransaction;
       i := 0;
       repeat
          inc(i);

        Donen_Deger := DataMod.CARI_BA_UPDATE(trnURUNHAR,

                                 qryCARIHAR.FieldByName('CARI_KOD').AsString,
                                 qryCARIHAR.FieldByName('DOV_BAZ_TAR').AsDate,
                                 qryCARIHAR.FieldByName('DOVKOD').AsString,
                                 qryCARIHAR.FieldByName('DOVKUR').AsCurrency,
                                 qryCARIHAR.FieldByName('TUTAR').AsCurrency,
                                 qryCARIHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                 qryCARIHAR.FieldByName('TIP').AsString[1],
                                 'TDataMod.SPP_CARIHAR_AUD:',
                                 LIMIT_ASIMI);
        if not Donen_Deger then
        begin
        if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
        Application.MessageBox('Hatalý Ýþlem Ýþlemden Vazgeçildi','Dikkat',MB_ICONHAND);
        Abort;
        end;

        Donen_Deger :=  DataMod.CARI_AY_ADDUPDATE(trnURUNHAR,
                                     qryCARIHAR.FieldByName('CARI_KOD').AsString,
                                     qryCARIHAR.FieldByName('TARIH').AsDate,
                                     qryCARIHAR.FieldByName('DOV_BAZ_TAR').AsDate,
                                     qryCARIHAR.FieldByName('TIP').AsString[1],
                                     qryCARIHAR.FieldByName('DOVKOD').AsString,
                                     qryCARIHAR.FieldByName('DOVKUR').AsCurrency,
                                     qryCARIHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                     qryCARIHAR.FieldByName('TUTAR').AsCurrency,
                                     'TDataMod.SPP_CARIHAR_AUD:');
        if not Donen_Deger then
        begin
        if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
        Application.MessageBox('Hatalý Ýþlem Ýþlemden Vazgeçildi','Dikkat',MB_ICONHAND);
        Abort;
        end;



        Donen_Deger := DataMod.CARIHAR_DOV_ADDUPDATE(trnURUNHAR,
                                     qryCARIHAR.FieldByName('CARIHAR_ID').AsInteger,
                                     qryCARIHAR.FieldByName('CARIHAR_SID').AsInteger,
                                     qryCARIHAR.FieldByName('DOVKOD').AsString,
                                     qryCARIHAR.FieldByName('TUTAR').AsFloat,
                                     qryCARIHAR.FieldByName('DOVKUR').AsFloat,
                                     qryCARIHAR.FieldByName('DOV_BAZ_TAR').AsDateTime,
                                     'TDataMod.SPP_CARIHAR_AUD:');

        if not Donen_Deger then
        begin
        if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
        Application.MessageBox('Hatalý Ýþlem Ýþlemden Vazgeçildi','Dikkat',MB_ICONHAND);

        Abort;
        end;





          qryCARIHAR.Next;

       {   if i = 100 then
          begin
            trnURUNHAR.Commit;
            trnURUNHAR.StartTransaction;
            i:= 0;
          end;
       }
       until Eof;
     end;


    except
     if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
    end;

     if trnURUNHAR.InTransaction then trnURUNHAR.Commit;
     DataMod.ReleaseQuery(qryExecuter);
     DataMod.ReleaseQuery(qryCARIHAR);
     DataMod.ReleaseTransaction(trnURUNHAR);



end;

procedure TfrmBAKIM.Button4Click(Sender: TObject);
var qryExecuter,qryPROJEHAR:TIB_Query;
    trnURUNHAR:TIB_Transaction;
    Donen_Deger:Boolean;
begin
   try
     Datamod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
     DataMod.CreateQuery(qryPROJEHAR,Nil,False,Datamod.dbaMain);
     DataMod.CreateTransaction(trnURUNHAR,tiCommitted,DataMod.dbaMain);

     qryExecuter.SQL.Clear;
     qryExecuter.SQL.Add('UPDATE PROJE SET BORC = 0, ALACAK = 0, BORC_VPB = 0, ALACAK_VPB = 0');
     qryExecuter.Execute;

     with qryPROJEHAR do
     begin
       SQL.Add('SELECT * FROM PROJEHAR');
       Open;
       First;
       if qryPROJEHAR.Eof then Exit;
       trnURUNHAR.StartTransaction;
       repeat

          if Trim(qryPROJEHAR.FieldByName('TIP').AsString) = BORC then
          begin
            qryExecuter.SQL.Clear;
            qryExecuter.SQL.Add('UPDATE PROJE SET BORC = BORC + '+SQL_Para(qryPROJEHAR.FieldByName('TUTAR_PROJE_DOVKOD').AsCurrency)
                          +  ' , BORC_VPB = BORC_VPB + '+ SQL_Para(qryPROJEHAR.FieldByName('TUTAR_VPB').AsCurrency)
                          +  ' WHERE PROJE_KOD = ' + SQL_Katar(qryPROJEHAR.FieldByName('PROJE_KOD').AsString));
            qryExecuter.Execute;
          end
          else
          begin
            qryExecuter.SQL.Clear;
            qryExecuter.SQL.Add('UPDATE PROJE SET ALACAK = ALACAK + '+SQL_Para(qryPROJEHAR.FieldByName('TUTAR_PROJE_DOVKOD').AsCurrency)
                          +  ' , ALACAK_VPB = ALACAK_VPB + '+ SQL_Para(qryPROJEHAR.FieldByName('TUTAR_VPB').AsCurrency)
                          +  ' WHERE PROJE_KOD = ' + SQL_Katar(qryPROJEHAR.FieldByName('PROJE_KOD').AsString));
            qryExecuter.Execute;
          end;
          Next;
       until Eof;
     end;


    except
     if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
    end;

     if trnURUNHAR.InTransaction then trnURUNHAR.Commit;
     DataMod.ReleaseQuery(qryExecuter);
     DataMod.ReleaseQuery(qryPROJEHAR);
     DataMod.ReleaseTransaction(trnURUNHAR);

end;

procedure TfrmBAKIM.Button5Click(Sender: TObject);
var qryExecuter,qryPROJEHAR:TIB_Query;
    trnURUNHAR:TIB_Transaction;
    Donen_Deger:Boolean;
begin
   try
     Datamod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
     DataMod.CreateQuery(qryPROJEHAR,Nil,True,Datamod.dbaMain);
     DataMod.CreateTransaction(trnURUNHAR,tiCommitted,DataMod.dbaMain);

     qryExecuter.SQL.Clear;
     qryExecuter.SQL.Add('UPDATE KASA SET BORC = 0, ALACAK = 0, BORC_VPB = 0, ALACAK_VPB = 0');
     qryExecuter.Execute;


     qryExecuter.SQL.Clear;
     qryExecuter.SQL.Add('DELETE FROM KASA_AY');
     qryExecuter.Execute;


     with qryPROJEHAR do
     begin
       SQL.Add('SELECT * FROM KASAHAR');
       Open;
       First;
       if qryPROJEHAR.Eof then Exit;
       trnURUNHAR.StartTransaction;
       repeat
             //Edit;
             //Post;

            //      SELECT PRM_OLDU FROM KASA_BAUPDATE(NEW.KASA_KOD, NEW.KASADEGER,NEW.TUTAR_VPB,NEW.TIP,0) INTO :VAR_OLDU;
            //      SELECT PRM_OLDU FROM KASA_AY_ADDUPDATE(NEW.KASA_KOD,NEW.TARIH,NEW.TIP,NEW.KASADEGER, NEW.TUTAR_VPB,0) INTO :VAR_OLDU;

           qryExecuter.SQL.Clear;
           qryExecuter.SQL.Add('EXECUTE PROCEDURE KASA_BAUPDATE(:KASA_KOD, :KASADEGER,:TUTAR_VPB,:TIP,0)');
           qryExecuter.ParamByName('KASA_KOD').asString:=qryPROJEHAR.FieldByName('KASA_KOD').asString;
           qryExecuter.ParamByName('KASADEGER').asFloat:=qryPROJEHAR.FieldByName('KASADEGER').asFloat;
           qryExecuter.ParamByName('TUTAR_VPB').asFloat:=qryPROJEHAR.FieldByName('TUTAR_VPB').asFloat;
           qryExecuter.ParamByName('TIP').asString:=qryPROJEHAR.FieldByName('TIP').asString;
           qryExecuter.Execute;


           qryExecuter.SQL.Clear;
           qryExecuter.SQL.Add('EXECUTE PROCEDURE KASA_AY_ADDUPDATE(:KASA_KOD,:TARIH,:TIP,:KASADEGER, :TUTAR_VPB,0)');
           qryExecuter.ParamByName('TARIH').asString:=qryPROJEHAR.FieldByName('TARIH').asString;
           qryExecuter.ParamByName('KASA_KOD').asString:=qryPROJEHAR.FieldByName('KASA_KOD').asString;
           qryExecuter.ParamByName('KASADEGER').asFloat:=qryPROJEHAR.FieldByName('KASADEGER').asFloat;
           qryExecuter.ParamByName('TUTAR_VPB').asFloat:=qryPROJEHAR.FieldByName('TUTAR_VPB').asFloat;
           qryExecuter.ParamByName('TIP').asString:=qryPROJEHAR.FieldByName('TIP').asString;
           qryExecuter.Execute;

             Next;
       until Eof;
     end;


    except
     if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
    end;

     if trnURUNHAR.InTransaction then trnURUNHAR.Commit;
     DataMod.ReleaseQuery(qryExecuter);
     DataMod.ReleaseQuery(qryPROJEHAR);
     DataMod.ReleaseTransaction(trnURUNHAR);
end;






procedure TfrmBAKIM.Button6Click(Sender: TObject);
var qryExecuter,qryMASRAFHAR:TIB_Query;
    trnURUNHAR:TIB_Transaction;
    Donen_Deger:Boolean;
begin
   try
     Datamod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
     DataMod.CreateQuery(qryMASRAFHAR,Nil,False,Datamod.dbaMain);
     DataMod.CreateTransaction(trnURUNHAR,tiCommitted,DataMod.dbaMain);

     qryExecuter.SQL.Clear;
     qryExecuter.SQL.Add('UPDATE MASRAF SET BORC = 0, ALACAK = 0');
     qryExecuter.Execute;

     with qryMASRAFHAR do
     begin
       SQL.Add('SELECT * FROM MASRAFHAR');
       Open;
       First;
       if qryMASRAFHAR.Eof then Exit;
       trnURUNHAR.StartTransaction;
       repeat
            Donen_Deger := DataMod.MASRAF_BA_UPDATE(trnURUNHAR,
                                       qryMASRAFHAR.FieldByName('MASRAF_KOD').AsString,
                                       qryMASRAFHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                       qryMASRAFHAR.FieldByName('BA').AsString[1]);
            if not Donen_Deger then
            begin
            if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
            Application.MessageBox('Hatalý Ýþlem Ýþlemden Vazgeçildi','Dikkat',MB_ICONHAND);

            Abort;
            end;


            Next;
       until Eof;
     end;


    except
     if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
    end;

     if trnURUNHAR.InTransaction then trnURUNHAR.Commit;
     DataMod.ReleaseQuery(qryExecuter);
     DataMod.ReleaseQuery(qryMASRAFHAR);
     DataMod.ReleaseTransaction(trnURUNHAR);
end;

procedure TfrmBAKIM.Panel2DblClick(Sender: TObject);
begin
   {$IfDef TRANSPORT}
     Application.CreateForm(TfrmButunluk_Kotrolu,frmButunluk_Kotrolu);
   {$EndIf}
end;

procedure TfrmBAKIM.Button7Click(Sender: TObject);
var qryExecuter,qryMASRAFHAR:TIB_Query;
    trnURUNHAR:TIB_Transaction;
    Donen_Deger:Boolean;
begin
   try
     Datamod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
     DataMod.CreateQuery(qryMASRAFHAR,Nil,False,Datamod.dbaMain);
     DataMod.CreateTransaction(trnURUNHAR,tiCommitted,DataMod.dbaMain);

     qryExecuter.SQL.Clear;
     qryExecuter.SQL.Add('UPDATE ARAC SET BORC = 0, ALACAK = 0');
     qryExecuter.Execute;

     with qryMASRAFHAR do
     begin
       SQL.Add('SELECT * FROM ARACHAR');
       Open;
       First;
       if qryMASRAFHAR.Eof then Exit;
       trnURUNHAR.StartTransaction;
       repeat
            Donen_Deger := DataMod.ARAC_BA_UPDATE(trnURUNHAR,
                                       qryMASRAFHAR.FieldByName('ARAC_KOD').AsString,
                                       qryMASRAFHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                       qryMASRAFHAR.FieldByName('BA').AsString[1]);
            if not Donen_Deger then
            begin
            if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
            Application.MessageBox('Hatalý Ýþlem Ýþlemden Vazgeçildi','Dikkat',MB_ICONHAND);

            Abort;
            end;


            Next;
       until Eof;
     end;


    except
     if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
    end;

     if trnURUNHAR.InTransaction then trnURUNHAR.Commit;
     DataMod.ReleaseQuery(qryExecuter);
     DataMod.ReleaseQuery(qryMASRAFHAR);
     DataMod.ReleaseTransaction(trnURUNHAR);





end;

procedure TfrmBAKIM.Button8Click(Sender: TObject);
var qryExecuter,qryMASRAFHAR:TIB_Query;
    trnURUNHAR:TIB_Transaction;
    Donen_Deger:Boolean;
begin
   try
     Datamod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
     DataMod.CreateQuery(qryMASRAFHAR,Nil,False,Datamod.dbaMain);
     DataMod.CreateTransaction(trnURUNHAR,tiCommitted,DataMod.dbaMain);

     qryExecuter.SQL.Clear;
     qryExecuter.SQL.Add('UPDATE PERSONEL SET BORC = 0, ALACAK = 0');
     qryExecuter.Execute;

     with qryMASRAFHAR do
     begin
       SQL.Add('SELECT * FROM PERSONEL_HAR');
       Open;
       First;
       if qryMASRAFHAR.Eof then Exit;
       trnURUNHAR.StartTransaction;
       repeat
            Donen_Deger := DataMod.PERSONEL_BA_UPDATE(trnURUNHAR,
                                       qryMASRAFHAR.FieldByName('PERSONEL_KOD').AsString,
                                       qryMASRAFHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                       qryMASRAFHAR.FieldByName('BA').AsString[1]);
            if not Donen_Deger then
            begin
            if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
            Application.MessageBox('Hatalý Ýþlem Ýþlemden Vazgeçildi','Dikkat',MB_ICONHAND);

            Abort;
            end;


            Next;
       until Eof;
     end;


    except
     if trnURUNHAR.InTransaction then trnURUNHAR.Rollback;
    end;

     if trnURUNHAR.InTransaction then trnURUNHAR.Commit;
     DataMod.ReleaseQuery(qryExecuter);
     DataMod.ReleaseQuery(qryMASRAFHAR);
     DataMod.ReleaseTransaction(trnURUNHAR);




end;

end.
