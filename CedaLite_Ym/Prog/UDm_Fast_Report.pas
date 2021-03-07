{$INCLUDE directive.inc}

unit UDm_Fast_Report;

interface

uses

  Windows,Forms,DB, IBODataset,IB_Components,SysUtils, Classes,Dialogs, frxClass, frxDBSet, frxDMPExport, frxExportODF,
  frxExportTXT, frxExportMail, frxExportCSV, frxExportText, frxExportImage,
  frxExportRTF, frxExportXML, frxExportXLS, frxExportHTML, frxExportPDF;

type
  TDm_Fast_Report = class(TDataModule)
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxXLSExport1: TfrxXLSExport;
    frxXMLExport1: TfrxXMLExport;
    frxRTFExport1: TfrxRTFExport;
    frxBMPExport1: TfrxBMPExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxTIFFExport1: TfrxTIFFExport;
    frxGIFExport1: TfrxGIFExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    frxCSVExport1: TfrxCSVExport;
    frxMailExport1: TfrxMailExport;
    frxTXTExport1: TfrxTXTExport;
    frxODSExport1: TfrxODSExport;
    frxODTExport1: TfrxODTExport;
    frxDBqryFatura: TfrxDBDataset;
    frxDBqryDekont: TfrxDBDataset;
    frxDBqryKASAHARMAS: TfrxDBDataset;
    frxDBqryFaturaD: TfrxDBDataset;
    frxDBqryDekont_D: TfrxDBDataset;
    frxDBqryKASAHAR_D: TfrxDBDataset;
    frxDBqryCari: TfrxDBDataset;
    frxDBqrySirket: TfrxDBDataset;
    frxDBqryKASAHAR: TfrxDBDataset;
    frxDBqryToplam: TfrxDBDataset;
    frxDBqryTRANSFER: TfrxDBDataset;
    frxDBqryBCEKODEME: TfrxDBDataset;
    frxDBqryKASACEKSENET: TfrxDBDataset;
    frxDBqryMCEKCIRO: TfrxDBDataset;
    frxDBqryMCEK: TfrxDBDataset;
    frxDBqryBCEKIADE: TfrxDBDataset;
    frxDBqryCek: TfrxDBDataset;
    frxDBqryFaturaD_Tran: TfrxDBDataset;
    frxDBqryKOMISYON: TfrxDBDataset;
    frxDBqrySiparis: TfrxDBDataset;
    frxDBQrySiparisD: TfrxDBDataset;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxFAT_IRS_ACK: TfrxDBDataset;
    procedure qryFaturaCalcFields(DataSet: TDataSet);
    procedure frxDBqryFaturaD_TranCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxReport1EndDoc(Sender: TObject);
    procedure frxDBqryFaturaD_TranNext(Sender: TObject);
    procedure frxReport1AfterPrintReport(Sender: TObject);

  private
         prv_Yazdirma_No:Integer;
         prv_Sep,prv_Id,prv_Sid:Integer;

    { Private declarations }
  public
    function Yeni_Rapor_Varmi(Eski_Rapor_No: Integer): Integer;
    //procedure Kullanici_Rapor_Click(Sender: TObject);
    procedure Rapor_Ac(Id, Eski_Rapor_No: Integer;Belge_Tur:Integer;Belge_Sn:Integer;Islem:Integer;Idd:Integer;Sid:Integer;Sep:Integer;Adres:String);
    procedure Duzenle(Id, Eski_Rapor_No: Integer);
    { Public declarations }
  end;

var
  Dm_Fast_Report: TDm_Fast_Report;

implementation

uses unDataMod,UnYazici,UnFunc, ufrmFAT_IRS,
{$IfDef TRANSPORT}
  ufrmFAT_Tran,
{$EndIf}
{$IfDef SERVIS}
  ufrmFAT_Srv,
{$EndIf}
  ufrmSiparis;

{$R *.dfm}

Function TDm_Fast_Report.Yeni_Rapor_Varmi(Eski_Rapor_No:Integer):Integer;
var
   qryTemp:TIB_Query;
begin
     Result:=0;
     DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaANA);
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('SELECT ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO FROM KULLANICI_MENU Where ESKI_RAPOR_NO=:ESKI_RAPOR_NO');
     qryTemp.ParamByName('ESKI_RAPOR_NO').AsInteger:=Eski_Rapor_No;
     qryTemp.Active:=True;
     if qryTemp.RecordCount>0 then
     Result:=qryTemp.FieldByName('Id').ASInteger;
     DataMod.ReleaseQuery(qryTemp);
end;

Procedure TDm_Fast_Report.Rapor_Ac(Id:Integer;Eski_Rapor_No:Integer;Belge_Tur:Integer;Belge_Sn:Integer;Islem:Integer;Idd:Integer;Sid:Integer;Sep:Integer;Adres:String);
var
   qryTemp:TIB_Query;
   Eski_Rapor_No_Top:String;
   Yazici_Is:Integer;
begin
     //ShowMessage('sdfg'+Inttostr((Sender as TMenuItem).Tag));
       try
     DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaANA);
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;

     if Eski_Rapor_No=0 then
     qryTemp.SQL.Add('SELECT ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO FROM KULLANICI_MENU Where ID=:ID');

     if Eski_Rapor_No>0 then
     begin
       qryTemp.SQL.Clear;
       qryTemp.SQL.Add('SELECT ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO FROM KULLANICI_MENU Where ID=:ID AND ESKI_RAPOR_NO=:ESKI_RAPOR_NO');
     end;

     if (id=0) and (Eski_Rapor_No>0) then
     begin
       qryTemp.SQL.Clear;
       qryTemp.SQL.Add('SELECT ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO FROM KULLANICI_MENU Where ESKI_RAPOR_NO=:ESKI_RAPOR_NO');
     end;

     if Id>0 then
     qryTemp.ParamByName('ID').AsInteger:=Id;

     if Eski_Rapor_No>0 then
     qryTemp.ParamByName('ESKI_RAPOR_NO').AsInteger:=Eski_Rapor_No;

     qryTemp.Active:=True;

  	 ///frxReport1.Clear;
     ///frxReport1.PrintOptions.Printer:=Yazici.GetBelgePrinter(BELGE_TUR,BELGE_SN);
//     frxReport1.ShowPreparedReport;

       prv_Yazdirma_No:=0;
       Yazici.Yeni_Rapor:=True;
       if Idd>0 then
       begin
            if Eski_Rapor_No=171 then Yazici.DEKONT(IDD, SID, Islem);
            if (Eski_Rapor_No=361) or (Eski_Rapor_No=201) then
            begin
               prv_Yazdirma_No:=1;
               prv_Sep:=Sep;
               prv_Id:=Idd;
               prv_Sid:=Sid;
               Yazici.FATURA(IDD, SID, Islem, SEP, Adres);
            end;
            if Eski_Rapor_No=142 then Yazici.KASAMUHTELIF(IDD, SID, Islem);
            if Eski_Rapor_No=141 then Yazici.KASACARI(IDD, SID,Islem);
            if Eski_Rapor_No=61 then Yazici.MUSTERICEKI(IDD, SID,Islem);
            if Eski_Rapor_No=41 then Yazici.BORCCEKI(IDD, SID, Islem);
            if Eski_Rapor_No=281 then Yazici.BANKADANMUSTERICEKTAHSIL(IDD, SID, Islem);
            if Eski_Rapor_No=331 then Yazici.KASAYACEKTAHSILI(IDD, SID,Islem);
            if Eski_Rapor_No=341 then Yazici.KASADANCEKTEDIYESI(IDD, SID, Islem);
            if Eski_Rapor_No=144 then Yazici.KASATRANSFER(IDD, SID, Islem);
            if Eski_Rapor_No=301 then Yazici.BCEKIADE(IDD, SID, Islem);
            if Eski_Rapor_No=291 then Yazici.BCEKODEME(IDD, SID,Islem);
            if Eski_Rapor_No=111 then Yazici.MCEKIADE(IDD, SID, Islem);
            if Eski_Rapor_No=81 then Yazici.MCEKCIRO(IDD, SID, Islem);
            if Eski_Rapor_No=371 then
            begin
              prv_Yazdirma_No:=2;
              prv_Id:=Id;
              prv_Sid:=Sid;
              Yazici.SIPARIS(IDD, SID, Islem);
            end;
            if Eski_Rapor_No=43 then Yazici.YUKLEME_FISI(IDD, SID, Islem);

       end;

       Yazici.Yeni_Rapor:=False;


       ///frxReport1.LoadFromFile(qryTemp.FieldByName('RAPOR_YERI_ADI').AsString);
       //frxReport1.PrepareReport(True);
       ///frxReport1.PrintOptions.Printer:=Yazici.GetBelgePrinter(BELGE_TUR,BELGE_SN);
       {
        if glb_Yazici_Is_Bildir then
        begin
            Yazici_Is:=Yazici.get_is(frxReport1.PrintOptions.Printer);
            if Yazici_Is>0 then
            begin
                 if Application.MessageBox(Pchar('Yazýcýda '+
                 Inttostr(Yazici_Is)+' Adet Ýþ Beklemektedir. Yazdýrmaya Devam Edilsin mi?'),
                 'Dikkat',MB_YESNO + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDNO then ABORT;
            end;
        end;
			 //frxReport1.PrintOptions.ShowDialog:=True;

       if islem=1 then
       begin
				   	frxReport1.PrintOptions.ShowDialog:=True;
            frxReport1.PrepareReport;
            frxReport1.showReport;
       end;
       if islem=0 then
       begin
            frxReport1.PrintOptions.ShowDialog:=False;
            frxReport1.PrepareReport;
            frxReport1.Print;
       end;
     DataMod.ReleaseQuery(qryTemp);
        }
     except
       Yazici.Yeni_Rapor:=False;
     end;
end;


Procedure TDm_Fast_Report.Duzenle(Id:Integer;Eski_Rapor_No:Integer);
var
   qryTemp:TIB_Query;
begin
//     ShowMessage('sdfg'+Inttostr((Sender as TMenuItem).Tag));
     DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaANA);
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;

     if Eski_Rapor_No=0 then
     qryTemp.SQL.Add('SELECT ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO FROM KULLANICI_MENU Where ID=:ID');
     if Eski_Rapor_No>0 then
     begin
       qryTemp.SQL.Clear;
       qryTemp.SQL.Add('SELECT ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO FROM KULLANICI_MENU Where ID=:ID AND ESKI_RAPOR_NO=:ESKI_RAPOR_NO');
     end;

     if (id=0) and (Eski_Rapor_No>0) then
     begin
       qryTemp.SQL.Clear;
       qryTemp.SQL.Add('SELECT ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO FROM KULLANICI_MENU Where ESKI_RAPOR_NO=:ESKI_RAPOR_NO');
     end;

     if Id>0 then
     qryTemp.ParamByName('ID').AsInteger:=Id;

     if Eski_Rapor_No>0 then
     qryTemp.ParamByName('ESKI_RAPOR_NO').AsInteger:=Eski_Rapor_No;

     qryTemp.Active:=True;
     ///frxReport1.LoadFromFile(qryTemp.FieldByName('RAPOR_YERI_ADI').AsString);
     ///frxReport1.DesignReport;
     DataMod.ReleaseQuery(qryTemp);

end;

procedure TDm_Fast_Report.qryFaturaCalcFields(DataSet: TDataSet);
var
  SONUC : Currency;
  qryCariUrunHar : TIB_Cursor;
begin
  if DataSet.Active then
  begin
    {if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZILE').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('GENEL_TOP').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZILE').AsString := param(Dataset.FieldByName('GENEL_TOP').AsCurrency) + ' TL.';
    end;

    if DataMod.KurluDonustur(DataSet.FieldByName('TARIH').AsDateTime,glb_DEFCUR,1,'YTL',Dataset.FieldByName('GENEL_TOP').AsCurrency,glb_SATISKUR,True,SONUC) then
       DataSet.FieldByName('GTYTLILE').AsString := YeniParam(SONUC);
    }
     ///
     ///
     ///
     {
    DataSet.FieldByName('GTYAZILE').AsString := YeniParam(Dataset.FieldByName('GENEL_TOP').AsCurrency);

    DataMod.CreateCursor(qryCariUrunHar,nil,False,DataMod.dbaMain);
    with qryCariUrunHar do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT DOVIZLI FROM CARI WHERE CARI_KOD = '+SQL_Katar(DataSet.FieldByName('CARI_KOD').AsString));
      Open;
    end;
    if qryCariUrunHar.FieldByName('DOVIZLI').AsSmallint = 1 then
    begin
      with qryCariUrunHar do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT SUM(TUTAR) AS DOVIZ_TOPLAM FROM URUNHAR WHERE FATURA_ID='+DataSet.FieldByName('FAT_IRS_ID').AsString+' AND FATURA_SID='+DataSet.FieldByName('FAT_IRS_SID').AsString);
        Open;
      end;
      DataSet.FieldByName('GTDOVIZ').AsString := '1 '+qryFaturaD.FieldByName('DOVKOD').AsString+' = ' + FormatCurr(glb_DOV_KUR_PF,qryFaturaD.FieldByName('DOVKUR').AsCurrency) + ' = '+ FormatCurr(glb_DOV_FIELD_PF,qryCariUrunHar.FieldByName('DOVIZ_TOPLAM').AsCurrency);
    end;
    DataMod.ReleaseCursor(qryCariUrunHar);
    }
  end;

end;

procedure TDm_Fast_Report.frxDBqryFaturaD_TranCheckEOF(Sender: TObject; var Eof: Boolean);
var
   a:TfrxView;
begin
{  if eof then
  begin
  //ShowMessage(Inttostr(frxReport1.PagesCount));

  a:=(frxReport1.FindObject('DMPMemo7') as TfrxView);
  a.Visible:=False;
  end;
}
end;

procedure TDm_Fast_Report.frxReport1EndDoc(Sender: TObject);
begin
//ShowMessage(Inttostr(frxReport1.PagesCount));
end;

procedure TDm_Fast_Report.frxDBqryFaturaD_TranNext(Sender: TObject);
var
a,b,c,d,e:TfrxComponent;
//a,b,c,d,e:TfrxMemoView;
begin
  //frxReport1.FindComponent()
  {$IfnDef EFENDEL}
       if not(Yazici.qryFaturaD_Tran.Eof) then
       begin
           a:=(Yazici.rptYazdir.FindComponent('DMPMemokdv') as TfrxComponent);
           a.Visible:=False;
           b:=(Yazici.rptYazdir.FindComponent('DMPMemonet') as TfrxComponent);
           b.Visible:=False;
           c:=(Yazici.rptYazdir.FindComponent('DMPMemognltop') as TfrxComponent);
           c.Visible:=False;
           d:=(Yazici.rptYazdir.FindComponent('DMPMemoyazi') as TfrxComponent);
           d.Visible:=False;

           a:=(Yazici.rptYazdir.FindComponent('DMPMemoBT') as TfrxComponent);
           a.Visible:=False;
           b:=(Yazici.rptYazdir.FindComponent('DMPMemoYKDV') as TfrxComponent);
           b.Visible:=False;
           c:=(Yazici.rptYazdir.FindComponent('DMPMemoKDVOR') as TfrxComponent);
           c.Visible:=False;
           d:=(Yazici.rptYazdir.FindComponent('DMPMemoYTOP') as TfrxComponent);
           d.Visible:=False;

           {a:=(frxReport1.FindObject('DMPMemo7') as TfrxMemoView);
           a.Visible:=False;
           b:=(frxReport1.FindObject('DMPMemo5') as TfrxMemoView);
           b.Visible:=False;
           c:=(frxReport1.FindObject('DMPMemo8') as TfrxMemoView);
           c.Visible:=False;
           d:=(frxReport1.FindObject('DMPMemo12') as TfrxMemoView);
           d.Visible:=False;
           }
       end
       else
       begin
           a:=(Yazici.rptYazdir.FindObject('DMPMemokdv') as TfrxComponent);
           a.Visible:=True;
           b:=(Yazici.rptYazdir.FindObject('DMPMemonet') as TfrxComponent);
           b.Visible:=True;
           c:=(Yazici.rptYazdir.FindObject('DMPMemognltop') as TfrxComponent);
           c.Visible:=True;
           d:=(Yazici.rptYazdir.FindObject('DMPMemoyazi') as TfrxComponent);
           d.Visible:=True;
           e:=(Yazici.rptYazdir.FindObject('DMPMemosyftop') as TfrxComponent);
           e.Visible:=False;

           a:=(Yazici.rptYazdir.FindComponent('DMPMemoBT') as TfrxComponent);
           a.Visible:=True;
           b:=(Yazici.rptYazdir.FindComponent('DMPMemoYKDV') as TfrxComponent);
           b.Visible:=True;
           c:=(Yazici.rptYazdir.FindComponent('DMPMemoKDVOR') as TfrxComponent);
           c.Visible:=True;
           d:=(Yazici.rptYazdir.FindComponent('DMPMemoYTOP') as TfrxComponent);
           d.Visible:=True;

         {
           a:=(frxReport1.FindObject('DMPMemo7') as TfrxMemoView);
           a.Visible:=True;
           b:=(frxReport1.FindObject('DMPMemo5') as TfrxMemoView);
           b.Visible:=True;
           c:=(frxReport1.FindObject('DMPMemo8') as TfrxMemoView);
           c.Visible:=True;
           d:=(frxReport1.FindObject('DMPMemo12') as TfrxMemoView);
           d.Visible:=True;
           e:=(frxReport1.FindObject('DMPMemo11') as TfrxMemoView);
           e.Visible:=False;
         }

       end;
  {$EndIf}

  {$IfDef EFENDEL}
       if not(Yazici.qryFaturaD_Tran.Eof) then
       begin
           a:=(Yazici.rptYazdir.FindComponent('DMPMemokdv') as TfrxComponent);
           a.Visible:=False;
           b:=(Yazici.rptYazdir.FindComponent('DMPMemonet') as TfrxComponent);
           b.Visible:=False;
           c:=(Yazici.rptYazdir.FindComponent('DMPMemognltop') as TfrxComponent);
           c.Visible:=False;
           d:=(Yazici.rptYazdir.FindComponent('DMPMemoyazi') as TfrxComponent);
           d.Visible:=False;
       end
       else
       begin
           a:=(Yazici.rptYazdir.FindObject('DMPMemokdv') as TfrxComponent);
           a.Visible:=True;
           b:=(Yazici.rptYazdir.FindObject('DMPMemonet') as TfrxComponent);
           b.Visible:=True;
           c:=(Yazici.rptYazdir.FindObject('DMPMemognltop') as TfrxComponent);
           c.Visible:=True;
           d:=(Yazici.rptYazdir.FindObject('DMPMemoyazi') as TfrxComponent);
           d.Visible:=True;
           e:=(Yazici.rptYazdir.FindObject('DMPMemosyftop') as TfrxComponent);
           e.Visible:=False;
       end;
  {$EndIf}
end;

procedure TDm_Fast_Report.frxReport1AfterPrintReport(Sender: TObject);
var
   qryDeg:TIb_Query;
begin

     //ShowMessage('Print Complate');
     if prv_Yazdirma_No=1 then
     begin
          { DataMod.CreateQuery(qryDeg,Nil,True,DataMod.dbaMain);
           qryDeg.Active:=False;
           qryDeg.SQL.Clear;
           qryDeg.SQL.Add('SELECT * FROM FAT_IRS WHERE FAT_IRS_SEP = '+inttostr(prv_Sep)+' AND FAT_IRS_ID='+inttostr(Prv_ID)+' AND FAT_IRS_SID='+inttostr(prv_SID));
           qryDeg.Open;
           qryDeg.Edit;
           qryDeg.FieldByName('YAZILDI').AsInteger:=1;
           qryDeg.Post;
           qryDeg.Active:=False;
           }

          {$IfnDef TRANSPORT}
          {$IfnDef SERVIS}
           frmFAT_Irs.Yazdirildi(prv_Sep,Prv_ID,prv_SID);
          {$EndIf}
          {$EndIf}

           {$IfDef TRANSPORT}
           frmFAT_Tran.Yazdirildi(prv_Sep,Prv_ID,prv_SID);
           {$EndIf}

          {$IfDef SERVIS}
           frmFAT_Srv.Yazdirildi(prv_Sep,Prv_ID,prv_SID);
          {$EndIf}
     end;

     if prv_Yazdirma_No=2 then
     begin
          {$IfnDef TRANSPORT}
          {$IfnDef SERVIS}
           frmSiparis.Yazdirildi(prv_Sep,Prv_ID,prv_SID);
          {$EndIf}
          {$EndIf}
     end;
     prv_Yazdirma_No:=0;
end;

end.



{INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (1, 'fthfhfff', 0, 1, 'C:\CedaLite\report\asl\fatura_nokta5_kasali2.fr3', 1, 201, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (2, 'fgjhfgh', 0, 1, 'C:\CedaLite\report\deneme1.fr3', 0, 0, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (4, NULL, 0, 1, 'C:\CedaLite\report\asl\Dekont.fr3', 0, 171, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (3, 'alt', 1, 1, 'C:\Documents and Settings\ceda1\Belgelerim\Alýnan Dosyalarým\fatura_nokta5_kasali2(1).fr3', 0, 0, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (5, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Muhtelif.fr3', 0, 142, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (6, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Cari.fr3', 0, 141, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (7, NULL, 0, 1, 'C:\CedaLite\report\asl\Borc_Ceki.fr3', 0, 41, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (8, NULL, 0, 1, 'C:\CedaLite\report\asl\Musteri_Ceki.fr3', 0, 61, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (9, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Cek_Senet.fr3', 0, 281, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (10, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Cek_Senet.fr3', 0, 331, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (11, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Cek_Senet_Tediye.fr3', 0, 341, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (12, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Transfer.fr3', 0, 144, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (13, NULL, 0, 1, 'C:\CedaLite\report\asl\Borc_Ceki_Iade.fr3', 0, 301, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (14, NULL, 0, 1, 'C:\CedaLite\report\asl\Borc_Cek_Ode.fr3', 0, 291, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (15, NULL, 0, 1, 'C:\CedaLite\report\asl\Musteri_Ceki_Iade.fr3', 0, 111, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (16, NULL, 0, 1, 'C:\CedaLite\report\asl\Musteri_Ceki_Ciro.fr3', 0, 81, 0);

COMMIT WORK;


INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (4, 1, 1, '\\EKINCI\Transport\Files\borcceki.prt', 'BORÇ ÇEKÝ');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (6, 1, 1, '\\EKINCI\Transport\Files\mustericeki.prt', 'MÜÞTERÝ ÇEKÝ');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (8, 1, 1, '\\EKINCI\Transport\Files\mustericekiciro.prt', 'KASADAN ÇEK SENET HAREKETLERÝ');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (11, 1, 1, '\\EKINCI\Transport\Files\mustericekiade.prt', 'MÜÞTERÝ ÇEKÝ ÝADE   ETME');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (14, 1, 1, '\\EKINCI\Transport\Files\kasacari.prt', 'KASA CARI');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (14, 2, 1, '\\EKINCI\Transport\Files\kasamuhtelif.prt', 'KASA MUHTELIF');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (14, 4, 1, '\\EKINCI\Transport\Files\kasatransfer.prt', 'KASALAR ARASI   TRANSFER');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (17, 1, 1, '\\EKINCI\Transport\Files\dekont.prt', 'DEKONT');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (20, 1, 1, '\\EKINCI\Transport\Files\Transport_Fatura.prt', 'FATURA');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (28, 1, 1, '\\EKINCI\Transport\Files\kasaceksenet.prt', 'KASADAN ÇEK SENET HAREKETLERÝ');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (29, 1, 1, '\\EKINCI\Transport\Files\borccekode.prt', 'BORÇ ÇEKÝ ÖDEME DEKONTU');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (30, 1, 1, '\\EKINCI\Transport\Files\borccekiadeyeni.prt', 'BORÇ ÇEKÝ ÝADE ALMA   DEKONTU');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (33, 1, 1, '\\EKINCI\Transport\Files\kasaceksenet.prt', NULL);
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (34, 1, 1, '\\EKINCI\Transport\Files\kasaceksenettediye.prt', NULL);
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (37, 1, 1, '\\EKINCI\Transport\Files\bilgisayar_siparis.prt', NULL);
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (36, 1, 1, '\\EKINCI\Transport\Files\bilgisayar_irsaliye.prt', NULL);

COMMIT WORK;



INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (1, 'fthfhfff', 0, 1, 'C:\CedaLite\report\asl\fatura_nokta5_kasali2.fr3', 1, 201, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (2, 'fgjhfgh', 0, 1, 'C:\CedaLite\report\deneme1.fr3', 0, 0, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (4, NULL, 0, 1, 'C:\CedaLite\report\asl\Dekont.fr3', 0, 171, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (3, 'alt', 1, 1, 'C:\Documents and Settings\ceda1\Belgelerim\Alýnan Dosyalarým\fatura_nokta5_kasali2(1).fr3', 0, 0, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (5, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Muhtelif.fr3', 0, 142, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (6, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Cari.fr3', 0, 141, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (7, NULL, 0, 1, 'C:\CedaLite\report\asl\Borc_Ceki.fr3', 0, 41, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (8, NULL, 0, 1, 'C:\CedaLite\report\asl\Musteri_Ceki.fr3', 0, 61, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (9, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Cek_Senet.fr3', 0, 281, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (10, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Cek_Senet.fr3', 0, 331, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (11, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Cek_Senet_Tediye.fr3', 0, 341, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (12, NULL, 0, 1, 'C:\CedaLite\report\asl\Kasa_Transfer.fr3', 0, 144, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (13, NULL, 0, 1, 'C:\CedaLite\report\asl\Borc_Ceki_Iade.fr3', 0, 301, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (14, NULL, 0, 1, 'C:\CedaLite\report\asl\Borc_Cek_Ode.fr3', 0, 291, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (15, NULL, 0, 1, 'C:\CedaLite\report\asl\Musteri_Ceki_Iade.fr3', 0, 111, 0);
INSERT INTO KULLANICI_MENU (ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO, GOSTER) VALUES (16, NULL, 0, 1, 'C:\CedaLite\report\asl\Musteri_Ceki_Ciro.fr3', 0, 81, 0);

COMMIT WORK;



INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (4, 1, 1, 'C:\Cedali\Files\Borc_Ceki.fr3', 'BORÇ ÇEKÝ');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (6, 1, 1, 'C:\Cedali\Files\Musteri_Ceki.fr3', 'MÜÞTERÝ ÇEKÝ');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (8, 1, 1, 'C:\Cedali\Files\Musteri_Ceki_Ciro.fr3', 'KASADAN ÇEK SENET HAREKETLERÝ');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (11, 1, 1, 'C:\Cedali\Files\Musteri_Ceki_Iade.fr3', 'MÜÞTERÝ ÇEKÝ ÝADE   ETME');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (14, 1, 1, 'C:\Cedali\Files\Kasa_Cari.fr3', 'KASA CARI');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (14, 2, 1, 'C:\Cedali\Files\Kasa_Muhtelif.fr3', 'KASA MUHTELIF');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (14, 4, 1, 'C:\Cedali\Files\Kasa_Transfer.fr3', 'KASALAR ARASI   TRANSFER');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (17, 1, 1, 'C:\Cedali\Files\Dekont.fr3', 'DEKONT');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (20, 1, 1, 'C:\Cedali\Files\fatura_nokta5_kasali2.fr3', 'FATURA');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (28, 1, 1, 'C:\Cedali\Files\Kasa_Cek_Senet.fr3', 'KASADAN ÇEK SENET HAREKETLERÝ');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (29, 1, 1, 'C:\Cedali\Files\Borc_Cek_Ode.fr3', 'BORÇ ÇEKÝ ÖDEME DEKONTU');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (30, 1, 1, 'C:\Cedali\Files\Borc_Ceki_Iade.fr3', 'BORÇ ÇEKÝ ÝADE ALMA   DEKONTU');
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (33, 1, 1, 'C:\Cedali\Files\Kasa_Cek_Senet.fr3', NULL);
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (34, 1, 1, 'C:\Cedali\Files\Kasa_Cek_Senet_Tediye.fr3', NULL);
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (37, 1, 1, 'C:\Cedali\Files\fatura_nokta5_kasali2.fr3', NULL);
INSERT INTO BELGE_YAZ (BELGE_TUR, SIRA_NO, SUBE_ID, DOSYA_PATH, ACIKLAMA) VALUES (36, 1, 1, 'C:\Cedali\Files\fatura_nokta5_kasali2.fr3', NULL);

COMMIT WORK;


}
