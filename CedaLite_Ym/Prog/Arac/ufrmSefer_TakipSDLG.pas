unit ufrmSefer_TakipSDLG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCalendar,
  cxButtonEdit, cxCheckBox, cxMRUEdit, cxTextEdit, cxCurrencyEdit, cxLabel,
  cxContainer, cxMaskEdit, cxDropDownEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls, cxGridCustomView,
  cxGrid, IBODataset, StdCtrls, cxButtons, cxLocalization,
  IB_Components;

type
  TfrmSefer_TakipSDLG = class(TForm)
    cxLocalizer1: TcxLocalizer;
    cxButton2: TcxButton;
    cxStyleRepository1: TcxStyleRepository;
    qry_Sefer_Takip: TIBOQuery;
    qry_Sefer_TakipSEFER_TAKIP_ID: TIntegerField;
    qry_Sefer_TakipSEFER_TAKIP_SID: TSmallintField;
    qry_Sefer_TakipGUN_SIRA: TIntegerField;
    qry_Sefer_TakipYUKLEME_TARIHI: TDateField;
    qry_Sefer_TakipGIRIS_TARIHI: TDateField;
    qry_Sefer_TakipCEKICI: TStringField;
    qry_Sefer_TakipDORSE: TStringField;
    qry_Sefer_TakipINDIREN: TStringField;
    qry_Sefer_TakipGIDECEGI_YER: TStringField;
    qry_Sefer_TakipYUKLEYICI_FIRMA: TStringField;
    qry_Sefer_TakipKONT_ALIS_YERI: TStringField;
    qry_Sefer_TakipKONT_TESLIM: TStringField;
    qry_Sefer_TakipKUMPANYA: TStringField;
    qry_Sefer_TakipBOOKING_NO: TStringField;
    qry_Sefer_TakipKONTROL_NO: TStringField;
    qry_Sefer_TakipMUHUR_NO: TStringField;
    qry_Sefer_TakipGONDEREN_FIRMA: TStringField;
    qry_Sefer_TakipGEMI_ADI: TStringField;
    qry_Sefer_TakipTAHLIYE_LIMANI: TStringField;
    qry_Sefer_TakipFATURA_NO: TStringField;
    qry_Sefer_TakipFATURA_TUTAR: TBCDField;
    qry_Sefer_TakipSATICI_FATURA_TUTAR: TBCDField;
    qry_Sefer_TakipSEFER_TAMAMLANDI: TSmallintField;
    qry_Sefer_TakipSATIS_FATURASI_KESILDI: TSmallintField;
    qry_Sefer_TakipALIS_FATURASI_ALINDI: TSmallintField;
    qry_Sefer_TakipPERSONEL_KOD: TStringField;
    qry_Sefer_TakipSEFERLESTI: TSmallintField;
    qry_Sefer_TakipSEFER_ID: TIntegerField;
    qry_Sefer_TakipCEKICI_PLAKA: TStringField;
    qry_Sefer_TakipDORSE_PLAKA: TStringField;
    qry_Sefer_TakipINDIREN_PLAKA: TStringField;
    qry_Sefer_TakipNEVI_ESYA_AD: TStringField;
    qry_Sefer_TakipGONDEREN_FIRMA_ADI: TStringField;
    qry_Sefer_TakipPERSONEL_ADI: TStringField;
    qry_Sefer_TakipNEVI: TIntegerField;
    qry_Sefer_TakipKIRALIK: TStringField;
    qry_Sefer_TakipKIRALIK_FIRMA_ADI: TStringField;
    qry_Sefer_TakipKONT_ALINDI: TSmallintField;
    qry_Sefer_TakipKIRALIK_BILDIRILDI: TSmallintField;
    qry_Sefer_TakipFIRMAYA_BILDIRILDI: TSmallintField;
    qry_Sefer_TakipFIRMA_EKKOD: TStringField;
    qry_Sefer_TakipACIKLAMA: TStringField;
    qry_Sefer_TakipBEKLEME_FAT_VAR: TSmallintField;
    qry_Sefer_TakipBEKLEME_FAT_TUTAR: TBCDField;
    qry_Sefer_TakipBEKLEME_FAT_KESILDI: TSmallintField;
    qry_Sefer_TakipSBEKLEME_FAT_VAR: TSmallintField;
    qry_Sefer_TakipSBEKLEME_FAT_TUTAR: TBCDField;
    qry_Sefer_TakipSBEKLEME_FAT_KESILDI: TSmallintField;
    dtsSefer_Takip: TDataSource;
    cxG1: TcxGrid;
    cxG1DBTV1: TcxGridDBTableView;
    cxG1DBTV1SEFER_TAKIP_ID: TcxGridDBColumn;
    cxG1DBTV1SEFER_TAKIP_SID: TcxGridDBColumn;
    cxG1DBTV1GUN_SIRA: TcxGridDBColumn;
    cxG1DBTV1YUKLEME_TARIHI: TcxGridDBColumn;
    cxG1DBTV1GIRIS_TARIHI: TcxGridDBColumn;
    cxG1DBTV1CEKICI: TcxGridDBColumn;
    cxG1DBTV1CEKICI_PLAKA: TcxGridDBColumn;
    cxG1DBTV1KONT_ALINDI: TcxGridDBColumn;
    cxG1DBTV1DORSE: TcxGridDBColumn;
    cxG1DBTV1DORSE_PLAKA: TcxGridDBColumn;
    cxG1DBTV1INDIREN: TcxGridDBColumn;
    cxG1DBTV1INDIREN_PLAKA: TcxGridDBColumn;
    cxG1DBTV1KIRALIK: TcxGridDBColumn;
    cxG1DBTV1KIRALIK_FIRMA_ADI: TcxGridDBColumn;
    cxG1DBTV1KIRALIK_BILDIRILDI: TcxGridDBColumn;
    cxG1DBTV1GIDECEGI_YER: TcxGridDBColumn;
    cxG1DBTV1YUKLEYICI_FIRMA: TcxGridDBColumn;
    cxG1DBTV1KONT_ALIS_YERI: TcxGridDBColumn;
    cxG1DBTV1KONT_TESLIM: TcxGridDBColumn;
    cxG1DBTV1NEVI: TcxGridDBColumn;
    cxG1DBTV1NEVI_ESYA_AD: TcxGridDBColumn;
    cxG1DBTV1KUMPANYA: TcxGridDBColumn;
    cxG1DBTV1BOOKING_NO: TcxGridDBColumn;
    cxG1DBTV1KONTROL_NO: TcxGridDBColumn;
    cxG1DBTV1FIRMAYA_BILDIRILDI: TcxGridDBColumn;
    cxG1DBTV1MUHUR_NO: TcxGridDBColumn;
    cxG1DBTV1GONDEREN_FIRMA: TcxGridDBColumn;
    cxG1DBTV1GONDEREN_FIRMA_ADI: TcxGridDBColumn;
    cxG1DBTV1FIRMA_EKKOD: TcxGridDBColumn;
    cxG1DBTV1GEMI_ADI: TcxGridDBColumn;
    cxG1DBTV1TAHLIYE_LIMANI: TcxGridDBColumn;
    cxG1DBTV1FATURA_NO: TcxGridDBColumn;
    cxG1DBTV1FATURA_TUTAR: TcxGridDBColumn;
    cxG1DBTV1SATICI_FATURA_TUTAR: TcxGridDBColumn;
    cxG1DBTV1SEFER_TAMAMLANDI: TcxGridDBColumn;
    cxG1DBTV1SATIS_FATURASI_KESILDI: TcxGridDBColumn;
    cxG1DBTV1ALIS_FATURASI_ALINDI: TcxGridDBColumn;
    cxG1DBTV1PERSONEL_KOD: TcxGridDBColumn;
    cxG1DBTV1PERSONEL_ADI: TcxGridDBColumn;
    cxG1DBTV1SEFERLESTI: TcxGridDBColumn;
    cxG1DBTV1SEFER_ID: TcxGridDBColumn;
    cxG1DBTV1ACIKLAMA: TcxGridDBColumn;
    cxG1DBTV1BEKLEME_FAT_VAR: TcxGridDBColumn;
    cxG1DBTV1BEKLEME_FAT_TUTAR: TcxGridDBColumn;
    cxG1DBTV1BEKLEME_FAT_KESILDI: TcxGridDBColumn;
    cxG1DBTV1SBEKLEME_FAT_VAR: TcxGridDBColumn;
    cxG1DBTV1SBEKLEME_FAT_TUTAR: TcxGridDBColumn;
    cxG1DBTV1SBEKLEME_FAT_KESILDI: TcxGridDBColumn;
    cxGL1: TcxGridLevel;
    cxBu_Kayit_Getir: TcxButton;
    cxDateEdit2: TcxDateEdit;
    cxLabel2: TcxLabel;
    cxLabel1: TcxLabel;
    cxDateEdit1: TcxDateEdit;
    cxButton1: TcxButton;
    function Form_Open(Menu:Boolean;var Sefer_Id:Integer;var Sefer_SId:Integer):  Boolean;
    procedure cxBu_Kayit_GetirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
        Gelen_Sefer_Id:Integer;
        Gelen_Sefer_SId:Integer;


     Kontrol:Boolean;
    { Public declarations }
  end;

var
  frmSefer_TakipSDLG: TfrmSefer_TakipSDLG;

implementation

uses unDATAMOD, main,
ufrmCariSDLG,ufrmSefer, unLogger, ufrmISN_ERRORS,unfunc;

{$R *.dfm}


procedure TfrmSefer_TakipSDLG.cxButton1Click(Sender: TObject);

var
   qryDeg1:TIb_Query;
   a:Integer;
begin
     Kontrol:=True;
     Close;
     {
     if (Gelen_Sefer_Id <>0) then
     begin
       try
       DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
       qryDeg1.Active:=False;
       qryDeg1.SQL.Clear;
       qryDeg1.SQL.Text:='Update SEFER SET SEFER_TAKIP_ID='+Inttostr(qry_Sefer_Takip.FieldByName('ID').AsInteger)
       +' WHERE SEFER_ID='+Inttostr(Gelen_Sefer_Id);
       qryDeg1.ExecSQL;


       //Application.MessageBox(Pchar('Fatura No '+qryDeg1.FieldByName('BELGE_NO').AsString),'Dikkat',MB_ICONINFORMATION);
       finally
       DataMod.ReleaseQuery(qryDeg1);
       end;
     end;
     }
end;

procedure TfrmSefer_TakipSDLG.cxButton2Click(Sender: TObject);
begin
     Kontrol:=false;
     Close;

end;

procedure TfrmSefer_TakipSDLG.cxBu_Kayit_GetirClick(Sender: TObject);
begin
      qry_Sefer_Takip.Close;
      qry_Sefer_Takip.ParamByName('TAR1').AsDate:=cxDateEdit1.Date;
      qry_Sefer_Takip.ParamByName('TAR2').AsDate:=cxDateEdit2.Date;
      qry_Sefer_Takip.Open;
end;

procedure TfrmSefer_TakipSDLG.FormCreate(Sender: TObject);
begin
try
     cxLocalizer1.FileName:=GetAppPath+'Turkce.ini';

finally

end;


     cxLocalizer1.Active:=True;
     cxLocalizer1.Locale:= 1055;



  with frmSefer_TakipSDLG.qry_Sefer_Takip do
  begin
    cxDateEdit1.Date:=Date;
    cxDateEdit2.Date:=Date;
    try
    cxG1DBTV1.RestoreFromIniFile('Sefer_Takip',False,False,[],'');
    finally

    end;
  end;
end;

Function TfrmSefer_TakipSDLG.Form_Open(Menu:Boolean; var Sefer_Id:Integer;var Sefer_SId:Integer):  Boolean;
begin

  Application.CreateForm(TfrmSefer_TakipSDLG,frmSefer_TakipSDLG);
///////////////////////////////////////////////////////////
  with frmSefer_TakipSDLG do
  begin
       //Gelen_Sefer_Id:=Sefer_Id;
       //Gelen_Sefer_SId:=Sefer_SId;
       ShowModal;

    if not Kontrol then
    begin
       SEFER_ID:=0;
       SEFER_SID:=0;

       Result := False;
    end
    else
    begin
       Sefer_Id:=qry_Sefer_Takip.FieldByName('SEFER_TAKIP_ID').AsInteger;
       Sefer_SId:=qry_Sefer_Takip.FieldByName('SEFER_TAKIP_SID').AsInteger;
      Result := True
    end;
    end;
end;

end.
