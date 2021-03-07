unit ufrmIrsaliye_Fatura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Grids, IB_Grid, IB_Components;

type
  TfrmIrsaliye_Fatura = class(TForm)
    Label1: TLabel;
    lblCariAD: TLabel;
    Label2: TLabel;
    IB_Grid1: TIB_Grid;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    btnCikis: TBitBtn;
    trnFAT_IRS: TIB_Transaction;
    qry: TIB_Query;
    qryFAT_IRS1: TIB_Query;
    dtsFAT_IRS: TIB_DataSource;
    qryURUNHAR1: TIB_Query;
    dtsURUNHAR: TIB_DataSource;
    IB_Grid2: TIB_Grid;
    IB_Query1: TIB_Query;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure qryFAT_IRS1AfterScroll(IB_Dataset: TIB_Dataset);
    procedure IB_Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Grid1DblClick(Sender: TObject);
    procedure IB_Grid2DblClick(Sender: TObject);
    procedure IB_Grid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Grid2Exit(Sender: TObject);
    procedure IB_Grid1Exit(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

    prv_FAT_IRS_SEP:Integer;
    prv_CARI_KOD:String;
    prv_TIP:Integer;
    prv_Kontrol :Boolean;
    function Aktar: Boolean;
    //procedure Aktar(var Kaynak: TIB_Query);

    { Private declarations }
  public
        res_Cari:TStringList;
        function Form_Open(FAT_IRS_SEP: Byte; CARI_KOD, Cari_Adi: String; Tip: Integer):Boolean;

    { Public declarations }
  end;

var
  frmIrsaliye_Fatura: TfrmIrsaliye_Fatura;

implementation

uses unDataMod, ufrmFAT_IRS;


{$R *.dfm}


function TfrmIrsaliye_Fatura.Form_Open(FAT_IRS_SEP:Byte;CARI_KOD:String;Cari_Adi:String;Tip:Integer):Boolean;
begin
  Application.CreateForm (TfrmIrsaliye_Fatura,frmIrsaliye_Fatura);
  frmIrsaliye_Fatura.prv_Kontrol := False;
  frmIrsaliye_Fatura.prv_FAT_IRS_SEP:=FAT_IRS_SEP;
  frmIrsaliye_Fatura.prv_CARI_KOD:=CARI_KOD;
  //frmIrsaliye_Fatura.lblCariAD.Caption:=Cari_Adi;
  frmIrsaliye_Fatura.prv_tip:=TIP;


     with frmIrsaliye_Fatura.qry do
     begin
       Active := False;
       SQL.Clear;
       SQL.Text:=
       //'UPDATE FAT_IRS SET SECIM=0';
       'UPDATE FAT_IRS SET SECIM=0 WHERE FAT_IRS_ID IN (SELECT FAT_IRS_ID FROM FAT_IRS WHERE FAT_IRS.CARI_KOD=:PRM_CARI_KOD AND FAT_IRS.FAT_IRS_SEP=2 AND FAT_IRS.TIP=:TIP)';
       ParamByName('PRM_CARI_KOD').AsString:=frmIrsaliye_Fatura.prv_CARI_KOD;
       ParamByName('TIP').AsInteger:=frmIrsaliye_Fatura.prv_TIP;
       ExecSql;
     end;

  frmIrsaliye_Fatura.trnFAT_IRS.CommitRetaining;
  frmIrsaliye_Fatura.trnFAT_IRS.StartTransaction;
  frmIrsaliye_Fatura.res_Cari:=TStringList.Create;


  frmIrsaliye_Fatura.ShowModal;

  if not frmIrsaliye_Fatura.prv_Kontrol Then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
  frmIrsaliye_Fatura.Close;
  frmIrsaliye_Fatura.Release;
end;

procedure TfrmIrsaliye_Fatura.SpeedButton1Click(Sender: TObject);
begin
  if qryFAT_IRS1.State in [dssInsert,dssEdit] then
  qryFAT_IRS1.Post;

{  if qryURUNHAR1.State in [dssInsert,dssEdit] then
  qryURUNHAR1.Post;

  trnFAT_IRS.CommitRetaining;
  Aktar(frmFAT_IRS.qryURUNHAR);
}

  trnFAT_IRS.Commit;
  prv_Kontrol := True;
  Close;
end;


function TfrmIrsaliye_Fatura.Aktar:Boolean;
var
   a:Integer;
begin
     {qry.Active := False;
     qry.SQL.Clear;
     qry.SQL.Text:=
     'DELETE FROM URUNHAR_YDK WHERE  IRSALIYE_ID=:IRSALIYE_ID AND IRSALIYE_SID=:IRSALIYE_SID'+
     qry.ParamByName('IRSALIYE_ID').AsInteger:=prv_FAT_IRS_SEP;
     qry.ParamByName('IRSALIYE_SID').AsInteger:=prv_FAT_IRS_SEP;
     qry.ExecSQL; }


  {
    begin
      trnFAT_IRS.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Exit;
    end;



//****************************************************************************//
    if not ((qryURUNHAR.Eof) and (qryURUNHAR.Bof)) then
    begin
      qryURUNHAR.First;
      while not qryURUNHAR.Eof do
      begin
        qryURUNHAR.Delete;
        qryURUNHAR.First;        
      end;
    end;
//****************************************************************************//

   }

//   urun har silindigi vakit þipariþ baglarýn da silnemesi gerekiyor o zaman irsaliye sipariþ arasý bag kopacak
  {
     qryFAT_IRS1.first;
     While not qryFAT_IRS1.Eof do
     begin
     qryURUNHAR1.First;
     if qryFAT_IRS1.FieldByName('Secim').AsInteger=1 then
     begin
          While not qryURUNHAR1.eof do
          begin
               if qryURUNHAR1.FieldByName('Secim').AsInteger=1 then
               begin
                    IB_Query1.Insert;
                    for a:=0 qryURUNHAR1.FieldCount-1 do
                    begin
                         IB_Query1.Fields[a].AsVariant:=qryURUNHAR1.Fields[a].AsVariant;
                    end;
                    IB_Query1.Post;
               end;
               qryURUNHAR1.Next;
          end;
     end;
     qryFAT_IRS1.Next;
     end;





CREATE TABLE URUNHAR_YDK (
    URUNHAR_ID            D_IDFIELD NOT NULL,
    URUNHAR_SID           D_SID NOT NULL,
    URUN_KOD              D_URUN_KOD NOT NULL,
    TIP                   D_BORCALACAK NOT NULL,
    BELGE_TUR             D_IDFIELD NOT NULL,
    BELGE_ID              D_IDFIELD NOT NULL,
    BELGE_SID             D_SID NOT NULL,
    BELGE_SIRA_NO         D_INTEGER,
    TARIH                 D_TARTIP NOT NULL,
    FIILI_TAR             D_TARTIP,
    DOV_BAZ_TAR           D_TARTIP,
    OLCUBIRIM             D_KOD NOT NULL,
    MIKTAR                D_MONEY NOT NULL,
    DOVKOD                D_DKOD NOT NULL,
    DOVKUR                D_MONEY NOT NULL,
    TUTAR                 D_MONEY NOT NULL,
    TUTAR_VPB             D_MONEY NOT NULL,
    URUN_DOVKOD           D_DKOD NOT NULL,
    TUTAR_URUN_DOVKOD     D_MONEY,
    BIRIM_FIY             D_MONEY NOT NULL,
    BIRIM_FIY_VPB         D_MONEY NOT NULL,
    BIRIM_FIY_URN_DOVKOD  D_MONEY NOT NULL,
    ISKONTO_TUTAR         D_MONEY NOT NULL,
    ISKONTO_TUTAR_VPB     D_MONEY NOT NULL,
    OLCUBIRIM_URN_OB      D_KOD NOT NULL,
    MIKTAR_URN_OB         D_MONEY NOT NULL,
    DEPO_KOD              D_KOD,
    MASRAF_MERK           D_KOD,
    KOD1                  D_KOD,
    KOD2                  D_KOD,
    KOD3                  D_KOD,
    KOD4                  D_KOD,
    ACIKLAMA              D_ACK50 NOT NULL COLLATE PXW_TURK,
    ISKONTO_TIP           D_SMALLINT,
    ISKONTO_ORAN          D_SMALLINT,
    FATURA_ID             D_IDFIELD NOT NULL,
    FATURA_SID            D_SID NOT NULL,
    IRSALIYE_ID           D_IDFIELD NOT NULL,
    IRSALIYE_SID          D_SID NOT NULL,
    KDV                   D_SMALLINT,
    KDV_TUTAR             D_MONEY NOT NULL,
    SECIM                 D_CHR1
);



ALTER TABLE URUNHAR_YDK ADD CONSTRAINT PK_URUNHAR_YDK PRIMARY KEY (URUNHAR_ID, URUNHAR_SID);



ALTER TABLE URUNHAR_YDK ADD CONSTRAINT FK_URUNHAR_YDK_ON_OLCUBIRIM FOREIGN KEY (OLCUBIRIM) REFERENCES OLCUBIR (OLCUBIRIM) ON UPDATE CASCADE;
ALTER TABLE URUNHAR_YDK ADD CONSTRAINT FK_URUNHAR_YDK_ON_URUN FOREIGN KEY (URUN_KOD) REFERENCES URUN (URUN_KOD) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE INDEX DEPO_IDX_URUNHAR_YDK ON URUNHAR_YDK (DEPO_KOD);
CREATE INDEX FATURA_IDX_ON_URUNHAR_YDK ON URUNHAR_YDK (FATURA_ID, FATURA_SID);
CREATE INDEX ISRSALIYE_IDX_URUNHAR_YDK ON URUNHAR_YDK (IRSALIYE_ID, IRSALIYE_SID);
CREATE INDEX TARIH_IDX_ON_URUNHAR_YDK ON URUNHAR_YDK (TARIH);
CREATE INDEX URUN_KOD_IDX_ON_URUNHAR_YDK ON URUNHAR_YDK (URUN_KOD);






INSERT INTO TABLE_DEP (TABLENAME, F_TABLE, ON_SART, SART_FIELD, SART_FIELD_VALUE, F_FIELD) VALUES ('DEPO', 'URUNHAR_YDK', 0, NULL, NULL, 'DEPO_KOD');
INSERT INTO TABLE_DEP (TABLENAME, F_TABLE, ON_SART, SART_FIELD, SART_FIELD_VALUE, F_FIELD) VALUES ('DOVKART', 'URUNHAR_YDK', 0, NULL, NULL, 'DOVKOD');
INSERT INTO TABLE_DEP (TABLENAME, F_TABLE, ON_SART, SART_FIELD, SART_FIELD_VALUE, F_FIELD) VALUES ('DOVKART', 'URUNHAR_YDK', 0, NULL, NULL, 'URUN_DOVKOD');
INSERT INTO TABLE_DEP (TABLENAME, F_TABLE, ON_SART, SART_FIELD, SART_FIELD_VALUE, F_FIELD) VALUES ('OLCUBIR', 'URUNHAR_YDK', 0, NULL, NULL, 'OLCUBIRIM');
INSERT INTO TABLE_DEP (TABLENAME, F_TABLE, ON_SART, SART_FIELD, SART_FIELD_VALUE, F_FIELD) VALUES ('OLCUBIR', 'URUNHAR_YDK', 0, NULL, NULL, 'OLCUBIRIM_URN_OB');
INSERT INTO TABLE_DEP (TABLENAME, F_TABLE, ON_SART, SART_FIELD, SART_FIELD_VALUE, F_FIELD) VALUES ('RAP_KOD_PARAMS', 'URUNHAR_YDK', 0, NULL, NULL, 'KOD1');
INSERT INTO TABLE_DEP (TABLENAME, F_TABLE, ON_SART, SART_FIELD, SART_FIELD_VALUE, F_FIELD) VALUES ('RAP_KOD_PARAMS', 'URUNHAR_YDK', 0, NULL, NULL, 'KOD2');
INSERT INTO TABLE_DEP (TABLENAME, F_TABLE, ON_SART, SART_FIELD, SART_FIELD_VALUE, F_FIELD) VALUES ('RAP_KOD_PARAMS', 'URUNHAR_YDK', 0, NULL, NULL, 'KOD3');
INSERT INTO TABLE_DEP (TABLENAME, F_TABLE, ON_SART, SART_FIELD, SART_FIELD_VALUE, F_FIELD) VALUES ('RAP_KOD_PARAMS', 'URUNHAR_YDK', 0, NULL, NULL, 'KOD4');
INSERT INTO TABLE_DEP (TABLENAME, F_TABLE, ON_SART, SART_FIELD, SART_FIELD_VALUE, F_FIELD) VALUES ('RAP_KOD_PARAMS', 'URUNHAR_YDK', 0, NULL, NULL, 'MASRAF_MERK');
INSERT INTO TABLE_DEP (TABLENAME, F_TABLE, ON_SART, SART_FIELD, SART_FIELD_VALUE, F_FIELD) VALUES ('URUN', 'URUNHAR_YDK', 0, NULL, NULL, 'URUN_KOD');

COMMIT WORK;
     }

end;


procedure TfrmIrsaliye_Fatura.FormActivate(Sender: TObject);
begin
  frmIrsaliye_Fatura.qryFAT_IRS1.Active:=False;
  frmIrsaliye_Fatura.qryFAT_IRS1.ParamByName('PRM_FAT_IRS_SEP').AsInteger:=Prv_FAT_IRS_SEP;
  frmIrsaliye_Fatura.qryFAT_IRS1.ParamByName('PRM_CARI_KOD').AsString:=prv_CARI_KOD;
  frmIrsaliye_Fatura.qryFAT_IRS1.ParamByName('TIP').AsInteger:=prv_TIP;
  frmIrsaliye_Fatura.qryFAT_IRS1.Active:=True;
  if DataMod.FN_CariKOD2Bilgi(prv_Cari_KOD,frmIrsaliye_Fatura.Res_Cari) then
  lblCariAD.Caption:=frmIrsaliye_Fatura.Res_Cari[1];
  lblCariAD.Caption:=Res_Cari[1];
end;

procedure TfrmIrsaliye_Fatura.qryFAT_IRS1AfterScroll(IB_Dataset: TIB_Dataset);
begin
  if qryFAT_IRS1.FieldByName('FAT_IRS_ID').AsInteger>0 then
  begin
    qryURUNHAR1.Active:=False;
    qryURUNHAR1.ParamByName('PRM_IRSALIYE_SID').AsInteger:=qryFAT_IRS1.FieldByName('FAT_IRS_SID').AsInteger;
    qryURUNHAR1.ParamByName('PRM_IRSALIYE_ID').AsInteger:=qryFAT_IRS1.FieldByName('FAT_IRS_ID').AsInteger;
    qryURUNHAR1.Active:=True;
  end;
end;

procedure TfrmIrsaliye_Fatura.IB_Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key=VK_Space then
      IB_Grid1.OnDblClick(nil);
end;

procedure TfrmIrsaliye_Fatura.IB_Grid1DblClick(Sender: TObject);
begin
  if qryFAT_IRS1.FieldByName('FAT_IRS_ID').AsInteger>0 then
  begin
    if qryFAT_IRS1.FieldByName('SECIM').AsInteger=1 then
    qryFAT_IRS1.FieldByName('SECIM').AsInteger:=0
    else
    qryFAT_IRS1.FieldByName('SECIM').AsInteger:=1;
    qryFAT_IRS1.Post;
  end;
end;

procedure TfrmIrsaliye_Fatura.IB_Grid2DblClick(Sender: TObject);
begin
{  if qryURUNHAR1.FieldByName('SECIM').AsInteger=1 then
  qryURUNHAR1.FieldByName('SECIM').AsInteger:=0
  else
  qryURUNHAR1.FieldByName('SECIM').AsInteger:=1;
  qryURUNHAR1.Post; }
end;

procedure TfrmIrsaliye_Fatura.IB_Grid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
{    if Key=VK_Space then
      IB_Grid2.OnDblClick(nil); }
end;

procedure TfrmIrsaliye_Fatura.IB_Grid2Exit(Sender: TObject);
begin
{  if qryURUNHAR1.State in [dssInsert,dssEdit] then
  qryURUNHAR1.Post; }
end;

procedure TfrmIrsaliye_Fatura.IB_Grid1Exit(Sender: TObject);
begin
  if qryFAT_IRS1.State in [dssInsert,dssEdit] then
  qryFAT_IRS1.Post;
end;

procedure TfrmIrsaliye_Fatura.btnCikisClick(Sender: TObject);
begin
  prv_Kontrol := False;
  Close;
end;

procedure TfrmIrsaliye_Fatura.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmIrsaliye_Fatura);
end;

end.
























{
procedure TfrmIrsaliye_Fatura.Aktar(var Kaynak:TIB_Query);
var
  Birden_Fazla_Urun,Uygula:Boolean;
  Aktarilmis_Urun:TStringList;
  qryDeg:TIb_Query;
begin
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  Aktarilmis_Urun:= TStringList.Create;

  qryFAT_IRS1.DisableControls;
  qryURUNHAR1.DisableControls;
  trnFAT_IRS.CommitRetaining;

try
  qryFAT_IRS1.First;
  qryURUNHAR1.First;
  While Not qryFAT_IRS1.Eof Do
  begin

    if qryFAT_IRS1.FieldByName('Secim').AsInteger=1 then
    While Not qryURUNHAR1.Eof Do
    begin

      //if qryURUNHAR1.FieldByName('Secim').AsInteger=1 then
      //begin

        Birden_Fazla_Urun:=False;
        Uygula:=True;

        qryDeg.Active := False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:=

        'SELECT count(*) KAC_ADET, sum(MIKTAR) MIKTAR,URUNHAR.BIRIM_FIY, URUNHAR.URUN_KOD FROM FAT_IRS '+
        ' INNER JOIN URUNHAR ON (FAT_IRS.FAT_IRS_SID=URUNHAR.FATURA_SID AND FAT_IRS.FAT_IRS_ID=URUNHAR.FATURA_ID)'+
        ' WHERE  FAT_IRS_SEP=:FAT_IRS_SEP AND URUNHAR.URUN_KOD=:URUN_KOD  and URUNHAR.BIRIM_FIY=:BIRIM_FIY'+
        ' AND FAT_IRS.SECIM=1 AND FAT_IRS.CARI_KOD=:CARI_KOD'+
//        ' AND FAT_IRS.SECIM=1 AND URUNHAR.SECIM=1 AND FAT_IRS.CARI_KOD=:CARI_KOD'+
        ' GROUP BY URUNHAR.BIRIM_FIY,URUNHAR.URUN_KOD';

        qryDeg.ParamByName('URUN_KOD').AsString:=qryURUNHAR1.FieldByName('URUN_KOD').AsString;
        qryDeg.ParamByName('BIRIM_FIY').AsFloat:=qryURUNHAR1.FieldByName('BIRIM_FIY').AsFloat;
        qryDeg.ParamByName('CARI_KOD').AsString:=qryFAT_IRS1.FieldByName('CARI_KOD').AsString;
        qryDeg.ParamByName('FAT_IRS_SEP').AsInteger:=prv_FAT_IRS_SEP;
        qryDeg.Active := True;
        if qryDeg.FieldByName('KAC_ADET').AsInteger>=1 then
        Birden_Fazla_Urun:=True;


        //ayný urunden birden fazla ise biri akratýlmýþsa aktarma
        if Birden_Fazla_Urun then
        begin
          if Aktarilmis_Urun.IndexOf(qryURUNHAR1.FieldByName('URUNHAR_ID').AsString)>-1 then
          begin
            Birden_Fazla_Urun:=False;
            Uygula:=False;
          end;
        end;

        if Uygula then
        begin
          Kaynak.Append;
          Kaynak.FieldByName('URUN_KOD').AsString:=qryURUNHAR1.FieldByName('URUN_KOD').AsString;
          Kaynak.FieldByName('TIP').AsString:=qryURUNHAR1.FieldByName('TIP').AsString;
          Kaynak.FieldByName('BELGE_TUR').AsInteger:=qryURUNHAR1.FieldByName('BELGE_TUR').AsInteger;
          Kaynak.FieldByName('BELGE_ID').AsInteger:=qryURUNHAR1.FieldByName('BELGE_ID').AsInteger;
          Kaynak.FieldByName('BELGE_SID').AsInteger:=qryURUNHAR1.FieldByName('BELGE_SID').AsInteger;
          Kaynak.FieldByName('BELGE_SIRA_NO').AsInteger:=qryURUNHAR1.FieldByName('BELGE_SIRA_NO').AsInteger;
          Kaynak.FieldByName('TARIH').AsDateTime:=qryURUNHAR1.FieldByName('TARIH').AsDateTime;
          Kaynak.FieldByName('FIILI_TAR').AsDateTime:=qryURUNHAR1.FieldByName('FIILI_TAR').AsDateTime;
          Kaynak.FieldByName('DOV_BAZ_TAR').AsDateTime:=qryURUNHAR1.FieldByName('DOV_BAZ_TAR').AsDateTime;
          Kaynak.FieldByName('OLCUBIRIM').AsString:=qryURUNHAR1.FieldByName('OLCUBIRIM').AsString;

          Kaynak.FieldByName('MIKTAR').AsFloat:=qryURUNHAR1.FieldByName('MIKTAR').AsFloat;

          if Birden_Fazla_Urun then
          Kaynak.FieldByName('MIKTAR').AsFloat:=qryDeg.FieldByName('MIKTAR').AsInteger;

          Kaynak.FieldByName('DOVKOD').AsString:=qryURUNHAR1.FieldByName('DOVKOD').AsString;
          Kaynak.FieldByName('DOVKUR').AsFloat:=qryURUNHAR1.FieldByName('DOVKUR').AsFloat;
          Kaynak.FieldByName('TUTAR').AsFloat:=qryURUNHAR1.FieldByName('TUTAR').AsFloat;
          Kaynak.FieldByName('TUTAR_VPB').AsFloat:=qryURUNHAR1.FieldByName('TUTAR_VPB').AsFloat;
          Kaynak.FieldByName('URUN_DOVKOD').AsString:=qryURUNHAR1.FieldByName('URUN_DOVKOD').AsString;
          Kaynak.FieldByName('TUTAR_URUN_DOVKOD').AsFloat:=qryURUNHAR1.FieldByName('TUTAR_URUN_DOVKOD').AsFloat;
          Kaynak.FieldByName('BIRIM_FIY').AsFloat:=qryURUNHAR1.FieldByName('BIRIM_FIY').AsFloat;
          Kaynak.FieldByName('BIRIM_FIY_VPB').AsFloat:=qryURUNHAR1.FieldByName('BIRIM_FIY_VPB').AsFloat;
          Kaynak.FieldByName('BIRIM_FIY_URN_DOVKOD').AsFloat:=qryURUNHAR1.FieldByName('BIRIM_FIY_URN_DOVKOD').AsFloat;
          Kaynak.FieldByName('ISKONTO_TUTAR').AsFloat:=qryURUNHAR1.FieldByName('ISKONTO_TUTAR').AsFloat;
          Kaynak.FieldByName('ISKONTO_TUTAR_VPB').AsFloat:=qryURUNHAR1.FieldByName('ISKONTO_TUTAR_VPB').AsFloat;
          Kaynak.FieldByName('OLCUBIRIM_URN_OB').AsString:=qryURUNHAR1.FieldByName('OLCUBIRIM_URN_OB').AsString;
          Kaynak.FieldByName('MIKTAR_URN_OB').AsFloat:=qryURUNHAR1.FieldByName('MIKTAR_URN_OB').AsFloat;
          Kaynak.FieldByName('DEPO_KOD').AsString:=qryURUNHAR1.FieldByName('DEPO_KOD').AsString;
          Kaynak.FieldByName('KOD1').AsString:=qryURUNHAR1.FieldByName('KOD1').AsString;
          Kaynak.FieldByName('KOD2').AsString:=qryURUNHAR1.FieldByName('KOD2').AsString;
          Kaynak.FieldByName('KOD3').AsString:=qryURUNHAR1.FieldByName('KOD3').AsString;
          Kaynak.FieldByName('KOD4').AsString:=qryURUNHAR1.FieldByName('KOD4').AsString;
          Kaynak.FieldByName('ACIKLAMA').AsString:=qryURUNHAR1.FieldByName('ACIKLAMA').AsString;
          Kaynak.FieldByName('ISKONTO_TIP').AsInteger:=qryURUNHAR1.FieldByName('ISKONTO_TIP').AsInteger;
          Kaynak.FieldByName('ISKONTO_ORAN').AsInteger:=qryURUNHAR1.FieldByName('ISKONTO_ORAN').AsInteger;
          Kaynak.FieldByName('KDV').AsInteger:=qryURUNHAR1.FieldByName('KDV').AsInteger;
          Kaynak.FieldByName('KDV_TUTAR').AsFloat:=qryURUNHAR1.FieldByName('KDV_TUTAR').AsFloat;

          Kaynak.FieldByName('IRSALIYE_ID').AsInteger:=qryFAT_IRS1.FieldByName('FATURA_ID').AsInteger;
          Kaynak.FieldByName('IRSALIYE_SID').AsInteger:=qryFAT_IRS1.FieldByName('FATURA_SID').AsInteger;


          Kaynak.Post;
          frmFAT_IRS.Irsaliye_Aktarma:=True;
          frmFAT_IRS.Disaridan_Fatura:=True;
         end;


      //end;//secim
      qryURUNHAR1.Next;
    end;
    qryFAT_IRS1.Next;
  end;

except
  frmFAT_IRS.trnFAT_IRS.RollbackRetaining;
  frmFAT_IRS.Irsaliye_Aktarma:=False;
  frmFAT_IRS.Disaridan_Fatura:=False;
  Application.MessageBox('Aktarma yapýlamadý.','Dikkat',MB_ICONWARNING);
end;


qryFAT_IRS1.CancelUpdates;
qryURUNHAR1.CancelUpdates;
end;
}
