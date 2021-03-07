unit unCEKSENHAR;

interface

uses
  SysUtils, Classes,IB_Components,Windows,Forms,Controls, IB_StoredProc,GenTypes;

type
  TdmCEKSENHAR = class(TDataModule)
    function SPP_CEKSENHAR_AUD(Transaction:TIB_Transaction;
                               var tblCEKSENHAR:TBL_CEKSENHAR;
                               PRM_SIL,PRM_DURUM_KOD,PRM_YERKOD:TD_SMALLINT):Boolean;
    function CEKSEN_AUD(Transaction:TIB_Transaction;
                        BELGE:Byte;
                        qryCEK_SEN:TIB_Query;
                        ISLEM:Byte):Boolean;
    function CEKSENHAR_AUD(Transaction:TIB_Transaction;
                           var tblCEKSENHAR:TBL_CEKSENHAR;
                           PRM_BELGE_TUR:Integer;
                           PRM_KASA_DOV_KOD:String;
                           PRM_SIL:Byte):Boolean;
    function GET_CEKSEN(var tblCEKSEN:TBL_CEKSEN):Boolean;
    function GET_CEKSENHAR(var tblCEKSENHAR:TBL_CEKSENHAR;FromCeksen:Boolean):Boolean;
    procedure DataModuleCreate(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
    
  end;

var
  dmCEKSENHAR: TdmCEKSENHAR;

const
   CEK          = 1;
   SENET        = 2;

   drmBEKLEMEDE = 1;
   drmODENMIS   = 2;
   drmPROTESTO  = 3;
   drmIPTAL     = 4;

   yerPORTFOYDE = 1;
   yerCIRO      = 2;
   yerTAHSIL    = 3;
   yerTEMINAT   = 4;

implementation

uses unDataMod, ufrmISN_ERRORS, unFUNC, ConvUtils;

{$R *.dfm}

function TdmCEKSENHAR.SPP_CEKSENHAR_AUD(Transaction:TIB_Transaction; Var tblCEKSENHAR:TBL_CEKSENHAR; PRM_SIL,PRM_DURUM_KOD,PRM_YERKOD:TD_SMALLINT):Boolean;
var
  qryCEKSENHAR:TIB_Query;
begin
  try
    try
      DataMod.CreateQuery(qryCEKSENHAR,Transaction,False,DataMod.dbaMain);
      with qryCEKSENHAR do
      begin
        if PRM_SIL = 1 then
        begin
//****************************************************************************//
          sql.Add('DELETE FROM CEKSENHAR WHERE CEKSEN = '+ IntToStr(tblCEKSENHAR.CEKSEN) + ' AND BELGE_ID = '+ IntToStr(tblCEKSENHAR.CEKSEN_ID) + ' AND BELGE_SID = '+ IntToStr(tblCEKSENHAR.CEKSEN_SID) +' AND ISLEM = '+ IntToStr(tblCEKSENHAR.ISLEM));
          Execute;
//****************************************************************************//
        end
        else
        begin
//****************************************************************************//
          RequestLive := True;
          ReadOnly := False;
          sql.Add('SELECT * FROM CEKSENHAR  WHERE CEKSEN = '+ IntToStr(tblCEKSENHAR.CEKSEN) + ' AND BELGE_ID = '+ IntToStr(tblCEKSENHAR.CEKSEN_ID) + ' AND BELGE_SID = '+ IntToStr(tblCEKSENHAR.CEKSEN_SID) +' AND ISLEM = '+ IntToStr(tblCEKSENHAR.ISLEM));
          Active := True;
          if RecordCount = 0 then
          begin
            Insert;
            FieldByName('CEKSENHAR_ID').AsInteger := DataMod.qryGENEL.Gen_ID('GEN_CEKSENHAR', 1);
            FieldByName('CEKSENHAR_SID').AsInteger := glb_SID;
          end
          else
          begin
            Edit;
          end;
          FieldByName('ISLEM_TAR').AsDate := tblCEKSENHAR.ISLEM_TAR;
          FieldByName('DOV_BAZ_TAR').AsDate := tblCEKSENHAR.DOV_BAZ_TAR;
          FieldByName('CEKSEN').AsInteger := tblCEKSENHAR.CEKSEN;
          FieldByName('BELGE_ID').AsInteger := tblCEKSENHAR.CEKSEN_ID;
          FieldByName('BELGE_SID').AsInteger := tblCEKSENHAR.CEKSEN_SID;
          FieldByName('ISLEM').AsInteger := tblCEKSENHAR.ISLEM;
          FieldByName('DOVKUR').AsCurrency := tblCEKSENHAR.DOVKUR;
          FieldByName('TUTAR_VPB').AsCurrency := tblCEKSENHAR.TUTAR_VPB;
          FieldByName('KUR_FARKI').AsCurrency := tblCEKSENHAR.KUR_FARKI;
          FieldByName('CARI_KOD').AsString := tblCEKSENHAR.CARI_KOD;
          FieldByName('PLASIYER_KOD').AsString := tblCEKSENHAR.PLASIYER_KOD;
          FieldByName('PROJE_KOD').AsString := tblCEKSENHAR.PROJE_KOD;
          FieldByName('CARIHAR_ACK').AsString := tblCEKSENHAR.CARIHAR_ACK;
          FieldByName('YEVMIYE_ACK').AsString := tblCEKSENHAR.YEVMIYE_ACK;
          FieldByName('PROTESTO_MASRAF').AsCurrency := tblCEKSENHAR.PROTESTO_MASRAF;
          FieldByName('GENEL_GIDER').AsCurrency := tblCEKSENHAR.GENEL_GIDER;
          FieldByName('GENEL_GIDER_MUH_KOD').AsString := tblCEKSENHAR.GENEL_GIDER_MUH_KOD;;
          FieldByName('BORCALHESAP').AsString := tblCEKSENHAR.BORCALHESAP;
          FieldByName('MASRAF_MERK').AsString := tblCEKSENHAR.MASRAF_MERK;
          FieldByName('KOD1').AsString := tblCEKSENHAR.KOD1;
          FieldByName('KOD2').AsString := tblCEKSENHAR.KOD2;
          FieldByName('KOD3').AsString := tblCEKSENHAR.KOD3;
          FieldByName('KOD4').AsString := tblCEKSENHAR.KOD4;
          FieldByName('KASA_KOD').AsString := tblCEKSENHAR.KASA_KOD;
          Post;
          tblCEKSENHAR.CEKSENHAR_ID := FieldByName('CEKSENHAR_ID').AsInteger;
          tblCEKSENHAR.CEKSENHAR_SID := FieldByName('CEKSENHAR_SID').AsInteger;
          Active := False;
//****************************************************************************//
        end;//end if PRM_SIL = 1 then
//****************************************************************************//
        SQL.Clear;
//****************************************************************************//
        if PRM_DURUM_KOD <> 254 then
        begin
          if tblCEKSENHAR.CEKSEN = CEK then
          begin
            if PRM_DURUM_KOD = drmODENMIS then
            begin
              sql.Add('UPDATE CEK SET CEK.DURUM = '+ IntToStr(PRM_DURUM_KOD) + ',ODEME_TAR = ' + SQL_Tarih(tblCEKSENHAR.ISLEM_TAR) + ' WHERE CEK.CEK_ID = '+ IntToStr(tblCEKSENHAR.CEKSEN_ID)+ ' AND CEK.CEK_SID = '+ IntToStr(tblCEKSENHAR.CEKSEN_SID));
            end
            else
            begin
              sql.Add('UPDATE CEK SET CEK.DURUM = '+ IntToStr(PRM_DURUM_KOD) + ' WHERE CEK.CEK_ID = '+ IntToStr(tblCEKSENHAR.CEKSEN_ID)+ ' AND CEK.CEK_SID = '+ IntToStr(tblCEKSENHAR.CEKSEN_SID));
            end;
          end
          else
          begin
            if PRM_DURUM_KOD = drmODENMIS then
            begin
              sql.Add('UPDATE SENET SET  SENET.DURUM = '+ IntToStr(PRM_DURUM_KOD) + ',ODEME_TAR = ' + SQL_Tarih(tblCEKSENHAR.ISLEM_TAR) + ' WHERE SENET.SENET_ID = '+ IntToStr(tblCEKSENHAR.CEKSEN_ID)+ ' AND SENET.SENET_SID = '+ IntToStr(tblCEKSENHAR.CEKSEN_SID));
            end else
            begin
              sql.Add('UPDATE SENET SET  SENET.DURUM = '+ IntToStr(PRM_DURUM_KOD) + ' WHERE SENET.SENET_ID = '+ IntToStr(tblCEKSENHAR.CEKSEN_ID)+ ' AND SENET.SENET_SID = '+ IntToStr(tblCEKSENHAR.CEKSEN_SID));
            end;
          end;
          Execute;
        end;
//****************************************************************************//
        SQL.Clear;
        if PRM_YERKOD <> 254 then
        begin
          if tblCEKSENHAR.CEKSEN = CEK then
          begin
            sql.Add('UPDATE CEK SET CEK.YER_KOD = '+ IntToStr(PRM_YERKOD) + ' WHERE CEK.CEK_ID = '+ IntToStr(tblCEKSENHAR.CEKSEN_ID)+ ' AND CEK.CEK_SID = '+ IntToStr(tblCEKSENHAR.CEKSEN_SID));
          end
          else
          begin
            sql.Add('UPDATE SENET SET SENET.YER_KOD = '+ IntToStr(PRM_YERKOD) + ' WHERE SENET.SENET_ID = '+ IntToStr(tblCEKSENHAR.CEKSEN_ID)+ ' AND SENET.SENET_SID = '+ IntToStr(tblCEKSENHAR.CEKSEN_SID));
          end;
          Execute;
        end;
//****************************************************************************//
      end;//with end
      Result := True;
    except
      Result := False;
      raise;
    end;
  finally
    DataMod.ReleaseQuery(qryCEKSENHAR);
  end;
end;

function TdmCEKSENHAR.CEKSEN_AUD(Transaction:TIB_Transaction;BELGE:Byte;qryCEK_SEN:TIB_Query;ISLEM:Byte):Boolean;
var
  CARI_YON:Char;
  BELGE_ID,BELGE_SID,BELGE_TUR,PRV_ISN,CEKSEN_ID,CEKSEN_SID:INTEGER;
  PROJE_SIL:Byte;
  tblCEKSENHAR:TBL_CEKSENHAR;
begin
  CEKSEN_ID := 0;
  CEKSEN_SID := 0;
  BELGE_TUR := 0;
//****************************************************************************//
  case BELGE of
  CEK:
    begin
      case qryCEK_SEN.FieldByName('TIP').AsInteger of
      1:
        begin //Müþteri çeki
          CARI_YON := ALACAK;
          BELGE_TUR := BT_MCEK_ALINDI;
        end;
      2:begin //Borc çeki
          CARI_YON := BORC;
          BELGE_TUR := BT_BORC_CEK;
        end;
      end; //case end
      CEKSEN_ID := qryCEK_SEN.FieldByName('CEK_ID').AsInteger;
      CEKSEN_SID := qryCEK_SEN.FieldByName('CEK_SID').AsInteger;
    end;
  SENET:
    begin
      case qryCEK_SEN.FieldByName('TIP').AsInteger of
      1:
        begin //Müþteri Senedi
          CARI_YON := ALACAK;
          BELGE_TUR := BT_MSEN_ALINDI;
        end;
      2:begin //Borc senedi
          CARI_YON := BORC;
          BELGE_TUR := BT_BORC_SEN;
        end;
      end; //case end
      CEKSEN_ID := qryCEK_SEN.FieldByName('SENET_ID').AsInteger;
      CEKSEN_SID := qryCEK_SEN.FieldByName('SENET_SID').AsInteger;
    end;
  end; // Case Belge End
//****************************************************************************//
  PRV_ISN := DataMod.Get_Isn_Num;
//****************************************************************************//
  if not DataMod.CARIHAR_AUD(Transaction,
                             BELGE_TUR,
                             CEKSEN_ID,
                             CEKSEN_SID,
                             1,
                             qryCEK_SEN.FieldByName('CARI_KOD').AsString,
                             CARI_YON,
                             qryCEK_SEN.FieldByName('ISLEMTAR').AsDate,
                             qryCEK_SEN.FieldByName('FIILI_TAR').AsDate,
                             qryCEK_SEN.FieldByName('DOV_BAZ_TAR').AsDate,
                             qryCEK_SEN.FieldByName('TUTAR').AsCurrency,
                             qryCEK_SEN.FieldByName('DOVKOD').AsString,
                             qryCEK_SEN.FieldByName('DOVKUR').AsCurrency,
                             qryCEK_SEN.FieldByName('TUTAR_VPB').AsCurrency,
                             qryCEK_SEN.FieldByName('VADETAR').AsDate,
                             qryCEK_SEN.FieldByName('ACIKLAMA').AsString,
                             ISLEM,
                             PRV_ISN,
                             qryCEK_SEN.FieldByName('MASRAF_MERK').AsString,
                             qryCEK_SEN.FieldByName('KOD1').AsString,
                             qryCEK_SEN.FieldByName('KOD2').AsString,
                             qryCEK_SEN.FieldByName('KOD3').AsString,
                             qryCEK_SEN.FieldByName('KOD4').AsString,
                             qryCEK_SEN.FieldByName('PLASIYER_KOD').AsString,
                             qryCEK_SEN.FieldByName('PROJE_KOD').AsString,
                             BELGE_ID,
                             BELGE_SID) then
  begin
    Result := False;
    Exit;
  end;
//****************************************************************************//
  if ISLEM = 0 then
  begin
    if Trim(qryCEK_SEN.FieldByName('PROJE_KOD').AsString) = '' then
    begin
      PROJE_SIL := 1;
    end
    else
    begin
      PROJE_SIL := 0;
    end;
  end
  else
  begin
    PROJE_SIL:=1;
  end;
//****************************************************************************//
  if not DataMod.PROJEHAR_AUD(Transaction,
                              BELGE_TUR,
                              CEKSEN_ID,
                              CEKSEN_SID,
                              1,
                              qryCEK_SEN.FieldByName('PROJE_KOD').AsString,
                              qryCEK_SEN.FieldByName('ISLEMTAR').AsDate,
                              qryCEK_SEN.FieldByName('FIILI_TAR').AsDate,
                              qryCEK_SEN.FieldByName('DOV_BAZ_TAR').AsDate,
                              qryCEK_SEN.FieldByName('VADETAR').AsDate,
                              CARI_YON,
                              qryCEK_SEN.FieldByName('DOVKOD').AsString,
                              qryCEK_SEN.FieldByName('DOVKUR').AsCurrency,
                              qryCEK_SEN.FieldByName('TUTAR').AsCurrency,
                              qryCEK_SEN.FieldByName('TUTAR_VPB').AsCurrency,
                              Proje_Sil,
                              qryCEK_SEN.FieldByName('ACIKLAMA').AsString,
                              PRV_ISN ,
                              qryCEK_SEN.FieldByName('MASRAF_MERK').AsString,
                              qryCEK_SEN.FieldByName('KOD1').AsString,
                              qryCEK_SEN.FieldByName('KOD2').AsString,
                              qryCEK_SEN.FieldByName('KOD3').AsString,
                              qryCEK_SEN.FieldByName('KOD4').AsString,
                              BELGE_ID,
                              BELGE_SID) then
  begin
    Result := False;
    Exit;
  end;
//****************************************************************************//
  tblCEKSENHAR.ISLEM_TAR := qryCEK_SEN.FieldbyName('ISLEMTAR').AsDate;
  tblCEKSENHAR.DOV_BAZ_TAR := qryCEK_SEN.FieldbyName('DOV_BAZ_TAR').AsDate;
  tblCEKSENHAR.CEKSEN := BELGE;
  tblCEKSENHAR.CEKSEN_ID := CEKSEN_ID;
  tblCEKSENHAR.CEKSEN_SID := CEKSEN_SID;
//****************************************************************************//
  if qryCEK_SEN.FieldByName('TIP').AsInteger = 1 then
  begin
    tblCEKSENHAR.ISLEM := 1
  end
  else
  begin
    tblCEKSENHAR.ISLEM := 15;
  end;
//****************************************************************************//
  tblCEKSENHAR.DOVKUR := qryCEK_SEN.FieldbyName('DOVKUR').AsCurrency;
  tblCEKSENHAR.TUTAR_VPB := qryCEK_SEN.FieldbyName('TUTAR_VPB').AsCurrency;
  tblCEKSENHAR.KUR_FARKI := 0;
  tblCEKSENHAR.CARI_KOD := qryCEK_SEN.FieldbyName('CARI_KOD').AsString;
  tblCEKSENHAR.PLASIYER_KOD := qryCEK_SEN.FieldbyName('PLASIYER_KOD').AsString;
  tblCEKSENHAR.PROJE_KOD := qryCEK_SEN.FieldbyName('PROJE_KOD').AsString;
  tblCEKSENHAR.CARIHAR_ACK := qryCEK_SEN.FieldbyName('ACIKLAMA').AsString;
  tblCEKSENHAR.YEVMIYE_ACK := qryCEK_SEN.FieldbyName('ACIKLAMA').AsString;
  tblCEKSENHAR.PROTESTO_MASRAF := 0;
  tblCEKSENHAR.GENEL_GIDER := 0;
  tblCEKSENHAR.GENEL_GIDER_MUH_KOD := '';
  tblCEKSENHAR.BORCALHESAP := '';
  tblCEKSENHAR.MASRAF_MERK := qryCEK_SEN.FieldByName('MASRAF_MERK').AsString;
  tblCEKSENHAR.KOD1 := qryCEK_SEN.FieldByName('KOD1').AsString;
  tblCEKSENHAR.KOD2 := qryCEK_SEN.FieldByName('KOD2').AsString;
  tblCEKSENHAR.KOD3 := qryCEK_SEN.FieldByName('KOD3').AsString;
  tblCEKSENHAR.KOD4 := qryCEK_SEN.FieldByName('KOD4').AsString;
//****************************************************************************//
  if not dmCEKSENHAR.SPP_CEKSENHAR_AUD(Transaction,tblCEKSENHAR,ISLEM,254,254) then
  begin
    Application.MessageBox('SPP_CEKSENHAR_AUD da hata oluþtu','Dikkat',MB_ICONWARNING);
    Result := False;
    Exit;
  end;
//****************************************************************************//
  if not glb_MUH_ENT then
  begin
    Result := True;
    Exit;
  end;
//****************************************************************************//
  case BELGE of
  CEK:
//****************************************************************************//
    case qryCEK_SEN.FieldByName('TIP').AsInteger of
    1:
      begin //Müþteri çeki
        {//lite
        if ENTEGRE.GET_MUH_ENT_PARAM('MUS_CEK_ENT') = 0 Then
        begin
          Result := True;
          Exit;
        end;
        }
      end;
    2:
      begin //Borc çeki
        {//lite
        if ENTEGRE.GET_MUH_ENT_PARAM('BORC_CEK_ENT') = 0 Then
        begin
          Result := True;
          Exit;
        end;
        }
      end;
    end; //case end
//****************************************************************************//
  SENET:
    case qryCEK_SEN.FieldByName('TIP').AsInteger of
    1:
      begin //Müþteri çeki
        {//lite
        if ENTEGRE.GET_MUH_ENT_PARAM('MUS_SEN_ENT') = 0 Then
        begin
          Result := True;
          Exit;
        end;}
      end;
    2:
      begin //Borc çeki
        {//lite
        if ENTEGRE.GET_MUH_ENT_PARAM('BORC_SEN_ENT') = 0 Then
        begin
          Result := True;
          Exit;
         end;
         }
      end;
    end; //case end
//****************************************************************************//
  end;
//****************************************************************************//
  if ISLEM = 1 then
  begin
    {//lite
    if not ENTEGRE.SPP_MUH_GEC_BELGE_SIL(Transaction,
                                         BELGE_TUR,
                                         CEKSEN_ID,
                                         CEKSEN_SID,
                                         1,
                                         PRV_ISN) then
    begin
      Result := False;
      Exit;
    end;
    }
  end
  else
//****************************************************************************//
  begin
    case qryCEK_SEN.FieldByName('TIP').AsInteger of
    1://Müsteri CEKSEN
      begin
        {//lite
        if not ENTEGRE.MUS_CEKSEN_ALIMI(Transaction,
                                        BELGE,
                                        qryCEK_SEN.FieldByName('CARI_KOD').AsString,
                                        qryCEK_SEN.FieldByName('ISLEMTAR').AsDate,
                                        qryCEK_SEN.FieldByName('DOV_BAZ_TAR').AsDate,
                                        qryCEK_SEN.FieldByName('DOVKOD').AsString,
                                        qryCEK_SEN.FieldByName('DOVKUR').AsCurrency,
                                        qryCEK_SEN.FieldByName('TUTAR').AsCurrency,
                                        qryCEK_SEN.FieldByName('TUTAR_VPB').AsCurrency,
                                        BELGE_TUR,
                                        CEKSEN_ID,
                                        CEKSEN_SID,
                                        qryCEK_SEN.FieldByName('PROJE_KOD').AsString,
                                        qryCEK_SEN.FieldByName('ACIKLAMA').AsString,
                                        qryCEK_SEN.FieldByName('MASRAF_MERK').AsString,
                                        qryCEK_SEN.FieldByName('KOD1').AsString,
                                        qryCEK_SEN.FieldByName('KOD2').AsString,
                                        qryCEK_SEN.FieldByName('KOD3').AsString,
                                        qryCEK_SEN.FieldByName('KOD4').AsString,
                                        PRV_ISN) then
        begin
          Result := False;
          Exit;
        end;
        }
      end;
    2://Borç CEKSEN
      begin
        {//lite
        if not ENTEGRE.BORC_CEKSEN(Transaction,
                                   BELGE,
                                   qryCEK_SEN.FieldByName('CARI_KOD').AsString,
                                   qryCEK_SEN.FieldByName('ISLEMTAR').AsDate,
                                   qryCEK_SEN.FieldByName('DOV_BAZ_TAR').AsDate,
                                   qryCEK_SEN.FieldByName('DOVKOD').AsString,
                                   qryCEK_SEN.FieldByName('DOVKUR').AsCurrency,
                                   qryCEK_SEN.FieldByName('TUTAR').AsCurrency,
                                   qryCEK_SEN.FieldByName('TUTAR_VPB').AsCurrency,
                                   BELGE_TUR,
                                   CEKSEN_ID,
                                   CEKSEN_SID,
                                   qryCEK_SEN.FieldByName('PROJE_KOD').AsString,
                                   qryCEK_SEN.FieldByName('ACIKLAMA').AsString,
                                   qryCEK_SEN.FieldByName('MASRAF_MERK').AsString,
                                   qryCEK_SEN.FieldByName('KOD1').AsString,
                                   qryCEK_SEN.FieldByName('KOD2').AsString,
                                   qryCEK_SEN.FieldByName('KOD3').AsString,
                                   qryCEK_SEN.FieldByName('KOD4').AsString,
                                   PRV_ISN) then
        begin
          Result := False;
          Exit;
        end;
        }
      end;
    end; //Case END
  end; //if ISLEM <> 1 then
  Result := True;
end;

procedure TdmCEKSENHAR.DataModuleCreate(Sender: TObject);
begin

end;

{
Müþteri Çek ve Senetleri

1- Alým
2- Tahsile Verme
3- Cirolama
4- Tahsilden Gelen “Tahsil” Dekontu
5- Tahsilden Gelen “Karþýlýksýz” Dekontu
6- Satýcýdan  Gelen “Karþýlýksýz”  Dekontu
7- Portfoyde  “Karþýlýksýz” Dekontu
8- Portfoyde “Iade” Dekontu
9- Kasaya Tahsil

Borç Çek ve Senetleri
15- Verim
16- Ýade dekontu
17- Bankadan Borç Çeki Ödeme Dekontu
18- Kasadan Çek Senet Ödeme
}

Function TdmCEKSENHAR.CEKSENHAR_AUD(Transaction:TIB_Transaction;
                                    var tblCEKSENHAR:TBL_CEKSENHAR;
                                    PRM_BELGE_TUR:Integer;
                                    PRM_KASA_DOV_KOD:String;
                                    PRM_SIL:Byte):Boolean;
var
  tblCEKSEN:TBL_CEKSEN;
  CARI_HAR,KASA_HAR:Boolean;
  CARI_YON,KASA_YON,KASA_MC:Char;
  YER_KOD,DURUM_KOD,PROJE_SIL: Byte;
  sppBELGE_ID,sppBELGE_SID,PRV_ISN:Integer;
  KASA_ISLEM_TIP:Byte;
  KASA_KARSIKOD:String;
begin
  YER_KOD := 0;
  DURUM_KOD := 0;
  CARI_HAR := False;
  KASA_HAR := False;
  try
    tblCEKSEN.CEKSEN := tblCEKSENHAR.CEKSEN;
    tblCEKSEN.CEKSEN_ID := tblCEKSENHAR.CEKSEN_ID;
    tblCEKSEN.CEKSEN_SID := tblCEKSENHAR.CEKSEN_SID;
    GET_CEKSEN(tblCEKSEN);
    PRV_ISN := DataMod.Get_Isn_Num;
//****************************************************************************//
    case tblCEKSENHAR.ISLEM of
//****************************************************************************//
    2://Tahsile Verme
      begin
        if PRM_SIL = 0 then
        begin
          YER_KOD := yerTAHSIL;
          DURUM_KOD := drmBEKLEMEDE;
        end
        else
        begin
          YER_KOD := yerPORTFOYDE;
          DURUM_KOD := drmBEKLEMEDE;
        end;
        CARI_HAR := False;
        KASA_HAR := False;
      end;
//****************************************************************************//
    3:// Cirolama
      begin
        if PRM_SIL = 0 then
        begin
          YER_KOD := yerCIRO;
          DURUM_KOD := drmBEKLEMEDE;
        end
        else
        begin
          YER_KOD := yerPORTFOYDE;
          DURUM_KOD := drmBEKLEMEDE;
        end;
        CARI_HAR := True;
        CARI_YON := BORC;
        KASA_HAR := False;
      end;
//****************************************************************************//
    4://Tahsilden Gelen “Tahsil” Dekontu
      begin
        if PRM_SIL = 0 then
        begin
          YER_KOD := yerTAHSIL;
          DURUM_KOD := drmODENMIS;
        end
        else
        begin
          YER_KOD := yerTAHSIL;
          DURUM_KOD := drmBEKLEMEDE;
        end;
        CARI_HAR := True;
        CARI_YON := BORC;
        KASA_HAR := False;
      end;
//****************************************************************************//
    5://Tahsilden Gelen “Karþýlýksýz” Dekontu
      begin
        if PRM_SIL = 0 then
        begin
          YER_KOD := yerTAHSIL;
          DURUM_KOD := drmPROTESTO;
        end
        else
        begin
          YER_KOD := yerTAHSIL;
          DURUM_KOD := drmBEKLEMEDE;
        end;
        CARI_HAR := False;
        KASA_HAR := False;
      end;
//****************************************************************************//
    6://Satýcýdan  Gelen “Karþýlýksýz”  Dekontu
      begin
        if PRM_SIL = 0 then
        begin
          YER_KOD := yerPORTFOYDE;
          DURUM_KOD := drmPROTESTO;
        end
        else
        begin
          YER_KOD := yerCIRO;
          DURUM_KOD := drmBEKLEMEDE;
        end;
        CARI_HAR := True;
        CARI_YON := ALACAK;
        KASA_HAR := False;
      end;
//****************************************************************************//
    7://Portfoyde  “Karþýlýksýz” Dekontu
      begin
        if PRM_SIL = 0 then
        begin
          YER_KOD := yerPORTFOYDE;
          DURUM_KOD := drmPROTESTO;
        end
        else
        begin
          YER_KOD := yerPORTFOYDE;
          DURUM_KOD := drmBEKLEMEDE;
        end;
        CARI_HAR := False;
        KASA_HAR := False;
      end;
//****************************************************************************//
    8://8- Portfoyde “Iade” Dekontu
      begin
        if PRM_SIL = 0 then
        begin
          YER_KOD := yerPORTFOYDE;
          DURUM_KOD := drmIPTAL;
        end
        else
        begin
          YER_KOD := yerPORTFOYDE;
          DURUM_KOD := drmBEKLEMEDE;
        end;
        CARI_HAR := True;
        KASA_HAR := False;
        CARI_YON := BORC;
      end;
//****************************************************************************//
    9://Kasaya Tahsil
      begin
        if PRM_SIL = 0 then
        begin
          YER_KOD := yerPORTFOYDE;
          DURUM_KOD := drmODENMIS;
        end
        else
        begin
          YER_KOD := yerPORTFOYDE;
          DURUM_KOD := drmBEKLEMEDE;
        end;

        CARI_HAR := False;
        KASA_HAR := True;
        KASA_YON := GIRIS;
        KASA_MC  := 'M';

      end;












//****************************************************************************//
    16://Iade Alýmý
      begin
        if PRM_SIL = 0 then
        begin
          YER_KOD := yerPORTFOYDE;
          DURUM_KOD := drmIPTAL;
        end
        else
        begin
          YER_KOD := yerCIRO;
          DURUM_KOD := drmBEKLEMEDE;
        end;
        CARI_HAR := True;
        CARI_YON := ALACAK;
        KASA_HAR := False;
      end;
//****************************************************************************//
    17://Bankadan Borç Çeki Ödeme Dekontu
      begin
        if PRM_SIL = 0 then
        begin
          YER_KOD := yerCIRO;
          DURUM_KOD := drmODENMIS;
        end
        else
        begin
          YER_KOD := yerCIRO;
          DURUM_KOD := drmBEKLEMEDE;
        end;
        CARI_HAR := True;
        CARI_YON := ALACAK;
        KASA_HAR := False;
      end;
//****************************************************************************//
    18: //Kasadan Çek Senet Ödeme
      begin
        if PRM_SIL = 0 then
        begin
          YER_KOD := yerCIRO;
          DURUM_KOD := drmODENMIS;
        end
        else
        begin
          YER_KOD := yerCIRO;
          DURUM_KOD := drmBEKLEMEDE;
        end;
        CARI_HAR := False;
        KASA_HAR := True;
        KASA_YON := CIKIS;
        KASA_MC  := 'M';
      end;
//****************************************************************************//
    end;
//****************************************************************************//
    if not SPP_CEKSENHAR_AUD(Transaction,tblCEKSENHAR,PRM_SIL,DURUM_KOD,YER_KOD) then
    begin
      Application.MessageBox('SPP_CEKSENHAR_AUD Fonksiyonunda hata oluþru','Dikkat',MB_ICONHAND);
      Result := False;
      Exit;
    end;
//****************************************************************************//
    if CARI_HAR then
    begin
      if not DataMod.CARIHAR_AUD(Transaction,
                                 PRM_BELGE_TUR,
                                 tblCEKSENHAR.CEKSENHAR_ID,
                                 tblCEKSENHAR.CEKSENHAR_SID,
                                 1,
                                 Trim(tblCEKSENHAR.CARI_KOD),
                                 CARI_YON,
                                 tblCEKSENHAR.ISLEM_TAR,
                                 tblCEKSENHAR.ISLEM_TAR,
                                 tblCEKSENHAR.DOV_BAZ_TAR,
                                 tblCEKSEN.TUTAR,
                                 tblCEKSEN.DOVKOD,
                                 tblCEKSENHAR.DOVKUR,
                                 tblCEKSENHAR.TUTAR_VPB,
                                 tblCEKSEN.VADETAR,
                                 tblCEKSENHAR.CARIHAR_ACK,
                                 PRM_SIL,
                                 PRV_ISN,
                                 Trim(tblCEKSENHAR.MASRAF_MERK),
                                 Trim(tblCEKSENHAR.KOD1),
                                 Trim(tblCEKSENHAR.KOD2),
                                 Trim(tblCEKSENHAR.KOD3),
                                 Trim(tblCEKSENHAR.KOD4),
                                 Trim(tblCEKSENHAR.PLASIYER_KOD),
                                 Trim(tblCEKSENHAR.PROJE_KOD),
                                 sppBELGE_ID,
                                 sppBELGE_SID) then
      begin
        Result := False;
        Exit;
      end;

      if PRM_SIL = 1 then
         PROJE_SIL := 1
      else
      if Trim(tblCEKSENHAR.PROJE_KOD)='' then
         PROJE_SIL := 1
      else
         PROJE_SIL := 0;

      if not DataMod.PROJEHAR_AUD(Transaction,
                                  PRM_BELGE_TUR,
                                  tblCEKSENHAR.CEKSENHAR_ID,
                                  tblCEKSENHAR.CEKSENHAR_SID,
                                  1,
                                  Trim(tblCEKSENHAR.PROJE_KOD),
                                  tblCEKSENHAR.ISLEM_TAR,
                                  tblCEKSENHAR.ISLEM_TAR,
                                  tblCEKSENHAR.DOV_BAZ_TAR,
                                  tblCEKSENHAR.ISLEM_TAR,
                                  CARI_YON,
                                  tblCEKSEN.DOVKOD,
                                  tblCEKSENHAR.DOVKUR,
                                  tblCEKSEN.TUTAR,
                                  tblCEKSENHAR.TUTAR_VPB,
                                  PROJE_SIL,
                                  tblCEKSENHAR.CARIHAR_ACK,
                                  PRV_ISN ,
                                  tblCEKSENHAR.MASRAF_MERK,
                                  tblCEKSENHAR.KOD1,
                                  tblCEKSENHAR.KOD2,
                                  tblCEKSENHAR.KOD3,
                                  tblCEKSENHAR.KOD4,
                                  sppBELGE_ID,
                                  sppBELGE_SID) then
      begin
        Result := False;
        Exit;
      end;
    end;//end if CARI_HAR then
//****************************************************************************//
    if KASA_HAR then
    begin
      if tblCEKSENHAR.CEKSEN = CEK then
         KASA_ISLEM_TIP := 4
      else
         KASA_ISLEM_TIP := 3;

      if not DataMod.KASAHAR_AUD(Transaction,
                                 Trim(tblCEKSENHAR.KASA_KOD),
                                 tblCEKSENHAR.ISLEM_TAR,
                                 tblCEKSENHAR.DOV_BAZ_TAR,
                                 PRM_BELGE_TUR,
                                 tblCEKSENHAR.CEKSENHAR_ID,
                                 tblCEKSENHAR.CEKSENHAR_SID,
                                 KASA_YON,
                                 tblCEKSENHAR.CARIHAR_ACK,
                                 PRM_KASA_DOV_KOD,
                                 KASA_ISLEM_TIP,
                                 tblCEKSENHAR.PROJE_KOD,
                                 tblCEKSENHAR.PLASIYER_KOD,
                                 KASA_MC,
                                 KASA_KARSIKOD,
                                 1,
                                 tblCEKSEN.DOVKOD,
                                 tblCEKSENHAR.DOVKUR,
                                 tblCEKSEN.TUTAR,
                                 tblCEKSENHAR.TUTAR_VPB,
                                 '',
                                 0,
                                 tblCEKSENHAR.MASRAF_MERK,
                                 tblCEKSENHAR.KOD1,
                                 tblCEKSENHAR.KOD2,
                                 tblCEKSENHAR.KOD3,
                                 tblCEKSENHAR.KOD4,
                                 tblCEKSENHAR.YEVMIYE_ACK,
                                 PRM_SIL,
                                 PRV_ISN,
                                 sppBELGE_ID,
                                 sppBELGE_SID) then
      begin
         Application.MessageBox('SPP_KASAHAR_AUD çalýþtýrýlýrken hata oluþtu','Dikkat',MB_ICONHAND);
         Result := False;
         Exit;
      end;
    end;//end if KASA_HAR then
//****************************************************************************//
      Result := True;
  except
    Result := False;
    Exit;
  end;
end;

Function TdmCEKSENHAR.GET_CEKSEN(Var tblCEKSEN:TBL_CEKSEN):Boolean;
// TBL_CEKSEN tanýmlandýktan sonra CEKSEN, CEKSEN_ID,CEKSEN_SID alanlarý doldurularak çaðrýlýr
var
  qryBELGE:TIB_Query;
begin
  try
    try
      DataMod.CreateQuery(qryBELGE,nil,False,DataMod.dbaMain);
      with qryBELGE do
      begin
        if tblCEKSEN.CEKSEN = CEK then
           SQL.Add('SELECT * FROM CEK WHERE CEK_ID =' + IntToStr(tblCEKSEN.CEKSEN_ID) + ' AND CEK_SID = '+ IntToStr(tblCEKSEN.CEKSEN_SID))
        else
           SQL.Add('SELECT * FROM SENET WHERE SENET_ID =' + IntToStr(tblCEKSEN.CEKSEN_ID) + ' AND SENET_SID = '+ IntToStr(tblCEKSEN.CEKSEN_SID));
        Active := True;
        if Recordcount = 0 then
        begin
          if tblCEKSEN.CEKSEN = CEK then
             Application.MessageBox('TdmCEKSENHAR.GET_CEKSEN: Tanýmlama numaralarý gönderilen ÇEK ile ilgili kayýt bulunamadý','Dikkat',MB_ICONWARNING)
          else
             Application.MessageBox('TdmCEKSENHAR.GET_CEKSEN: Tanýmlama numaralarý gönderilen SENET ile ilgili kayýt bulunamadý','Dikkat',MB_ICONWARNING);
          Result := False;
          Exit;
        end;
        tblCEKSEN.CARI_KOD := FieldByName('CARI_KOD').AsString;
        tblCEKSEN.ISLEMTAR := FieldByName('ISLEMTAR').AsDate;
        tblCEKSEN.FIILI_TAR := FieldByName('FIILI_TAR').AsDate;
        tblCEKSEN.DOV_BAZ_TAR := FieldByName('DOV_BAZ_TAR').AsDate;
        tblCEKSEN.TANZIMTAR := FieldByName('TANZIMTAR').AsDate;
        tblCEKSEN.VADETAR := FieldByName('VADETAR').AsDate;
        tblCEKSEN.ODEME_TAR := FieldByName('ODEME_TAR').AsDate;
        if tblCEKSEN.CEKSEN = CEK then
        begin
          tblCEKSEN.BANKA_KOD := FieldByName('BANKA_KOD').AsString;
          tblCEKSEN.BELGE_SAHIBI := FieldByName('CEK_SAHIBI').AsString;
          tblCEKSEN.BANKA_AD := FieldByName('BANKA_AD').AsString;
          tblCEKSEN.HESAP_NO := FieldByName('HESAP_NO').AsString;
          tblCEKSEN.CEK_NUM := FieldByName('CEK_NUM').AsString;
        end
        else
        begin
          tblCEKSEN.BELGE_SAHIBI := FieldByName('SENET_SAHIBI').AsString;
        end;
        tblCEKSEN.TUTAR := FieldByName('TUTAR').AsCurrency;
        tblCEKSEN.DOVKUR := FieldByName('DOVKUR').AsCurrency;
        tblCEKSEN.DOVKOD := FieldByName('DOVKOD').AsString;
        tblCEKSEN.DURUM := FieldByName('DURUM').AsInteger;
        tblCEKSEN.YER_KOD := FieldByName('YER_KOD').AsInteger;
        tblCEKSEN.TIP := FieldByName('TIP').AsInteger;
        tblCEKSEN.ACIKLAMA := FieldByName('ACIKLAMA').AsString;
        tblCEKSEN.ASIL := FieldByName('ASIL').AsInteger;
        tblCEKSEN.TUTAR_VPB := FieldByName('TUTAR_VPB').AsCurrency;
        tblCEKSEN.PROJE_KOD := FieldByName('PROJE_KOD').AsString;
        tblCEKSEN.PLASIYER_KOD := FieldByName('PLASIYER_KOD').AsString;
        tblCEKSEN.MASRAF_MERK := FieldByName('MASRAF_MERK').AsString;
        tblCEKSEN.KOD1 := FieldByName('KOD1').AsString;
        tblCEKSEN.KOD2 := FieldByName('KOD2').AsString;
        tblCEKSEN.KOD3 := FieldByName('KOD3').AsString;
        tblCEKSEN.KOD4 := FieldByName('KOD4').AsString;
        if tblCEKSEN.CEKSEN = SENET then
        begin
          tblCEKSEN.TANZIM_YER := FieldByName('TANZIM_YER').AsString;
          tblCEKSEN.KEFIL_1 := FieldByName('KEFIL_1').AsString;
          tblCEKSEN.KEFIL_2 := FieldByName('KEFIL_2').AsString;
        end;
        Active := False;
      end;// with end
      Result := True;
    except
      Result := False;
      raise;
    end;//end try--except
  finally
    DataMod.ReleaseQuery(qryBELGE);
  end;//end try--finally
end;

function TdmCEKSENHAR.GET_CEKSENHAR(Var tblCEKSENHAR:TBL_CEKSENHAR;FromCeksen:Boolean):Boolean;
// if From Ceksen
// TBL_CEKSENHAR tanýmlandýktan sonra CEKSEN, CEKSEN_ID,CEKSEN_SID,ISLEM alanlarý doldurularak çaðrýlýr
// else
// CEKSENHAR_ID,CEKSENHAR_SID
var
  qryCEKSENHAR:TIB_Query;
begin
  try
    try
      DataMod.CreateQuery(qryCEKSENHAR,nil,False,DataMod.dbaMain);
      with qryCEKSENHAR do
      begin
        if FromCeksen then
        begin
          SQL.Add('SELECT * FROM CEKSENHAR WHERE CEKSEN = '+InttoStr(tblCEKSENHAR.CEKSEN)+ ' AND BELGE_ID ='+IntToStr(tblCEKSENHAR.CEKSEN_ID) + ' AND BELGE_SID = '+IntToStr(tblCEKSENHAR.CEKSEN_SID) + ' AND ISLEM = '+IntToStr(tblCEKSENHAR.ISLEM))
        end
        else
        begin
          SQL.Add('SELECT * FROM CEKSENHAR WHERE CEKSENHAR_ID ='+IntToStr(tblCEKSENHAR.CEKSENHAR_ID)+' AND CEKSENHAR_SID = '+IntToStr(tblCEKSENHAR.CEKSENHAR_SID));
        end;
        Active := True;
        if Recordcount = 0 then
        begin
          if FromCeksen then
          begin
            if tblCEKSENHAR.CEKSEN = CEK then
               Application.MessageBox('TdmCEKSENHAR.GET_CEKSENHAR: Tanýmlama numaralarý gönderilen ÇEK hareketi ile ilgili kayýt bulunamadý.','Dikkat',MB_ICONWARNING)
            else
               Application.MessageBox('TdmCEKSENHAR.GET_CEKSENHAR: Tanýmlama numaralarý gönderilen SENET hareketi ile ilgili kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
          end
          else
          begin
            Application.MessageBox('TdmCEKSENHAR.GET_CEKSENHAR: Tanýmlama numaralarý gönderilen ÇEK veya SENET Hareketi ile ilgili kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
          end;
          Result := False;
          Exit;
        end;
        tblCEKSENHAR.CEKSENHAR_ID := FieldByName('CEKSENHAR_ID').AsInteger;
        tblCEKSENHAR.CEKSENHAR_SID := FieldByName('CEKSENHAR_SID').AsInteger;
        tblCEKSENHAR.ISLEM_TAR := FieldByName('ISLEM_TAR').AsDate;
        tblCEKSENHAR.DOV_BAZ_TAR := FieldByName('DOV_BAZ_TAR').AsDate;
        tblCEKSENHAR.CEKSEN := FieldByName('CEKSEN').AsInteger;
        tblCEKSENHAR.CEKSEN_ID := FieldByName('BELGE_ID').AsInteger;
        tblCEKSENHAR.CEKSEN_SID := FieldByName('BELGE_SID').AsInteger;
        tblCEKSENHAR.ISLEM := FieldByName('ISLEM').AsInteger;
        tblCEKSENHAR.DOVKUR := FieldByName('DOVKUR').AsCurrency;
        tblCEKSENHAR.TUTAR_VPB := FieldByName('TUTAR_VPB').AsCurrency;
        tblCEKSENHAR.KUR_FARKI := FieldByName('KUR_FARKI').AsCurrency;
        tblCEKSENHAR.CARI_KOD := FieldByName('CARI_KOD').AsString;
        tblCEKSENHAR.PLASIYER_KOD := FieldByName('PLASIYER_KOD').AsString;
        tblCEKSENHAR.PROJE_KOD := FieldByName('PROJE_KOD').AsString;
        tblCEKSENHAR.CARIHAR_ACK := FieldByName('CARIHAR_ACK').AsString;
        tblCEKSENHAR.YEVMIYE_ACK := FieldByName('YEVMIYE_ACK').AsString;
        tblCEKSENHAR.PROTESTO_MASRAF := FieldByName('PROTESTO_MASRAF').AsCurrency;
        tblCEKSENHAR.GENEL_GIDER := FieldByName('GENEL_GIDER').AsCurrency;
        tblCEKSENHAR.GENEL_GIDER_MUH_KOD := FieldByName('GENEL_GIDER_MUH_KOD').AsString;
        tblCEKSENHAR.BORCALHESAP := FieldByName('BORCALHESAP').AsString;
        tblCEKSENHAR.MASRAF_MERK := FieldByName('MASRAF_MERK').AsString;
        tblCEKSENHAR.KOD1 := FieldByName('KOD1').AsString;
        tblCEKSENHAR.KOD2 := FieldByName('KOD2').AsString;
        tblCEKSENHAR.KOD3 := FieldByName('KOD3').AsString;
        tblCEKSENHAR.KOD4 := FieldByName('KOD4').AsString;
        tblCEKSENHAR.KASA_KOD := FieldByName('KASA_KOD').AsString;
        Active := False;
      end;// with end
      Result := True;
    except
      Result := False;
      raise;
    end;// try except end;
  finally
    DataMod.ReleaseQuery(qryCEKSENHAR);
  end;// try finally end
end;

end.
