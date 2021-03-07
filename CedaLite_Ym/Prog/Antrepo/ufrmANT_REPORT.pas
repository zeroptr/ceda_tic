unit ufrmANT_REPORT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, IB_Components, StdCtrls, ExtCtrls, frxDBSet, DB, IBODataset,
  ComCtrls;

type
  TfrmANT_REPORT = class(TForm)
    frxReport1: TfrxReport;
    qryANT_MAIN: TIBOQuery;
    qryANT_DETAIL: TIBOQuery;
    qrySIRKET: TIBOQuery;
    qryARDIYE: TIBOQuery;
    frxANT_MAIN: TfrxDBDataset;
    frxANT_DETAIL: TfrxDBDataset;
    frxSIRKET: TfrxDBDataset;
    frxARDIYE: TfrxDBDataset;
    qryANT_REPORT: TIBOQuery;
    frxANT_RAPOR: TfrxDBDataset;
    qryBEY_TEKLIKE: TIBOQuery;
    frxBEY_TEKLIKE: TfrxDBDataset;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    chk_Sirket: TCheckBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    Btn_Fast: TButton;
    procedure ANT_GIRIS_FISI(ANT_MAIN_ID,ANT_MAIN_SID:Integer;Islem:Byte);
    procedure ANT_CIKIS_FISI(ANT_MAIN_ID,ANT_MAIN_SID,ANT_DETAIL_ID:Integer;Islem:Byte);
    procedure Sirket_Ac;
    procedure frxReport1ClosePreview(Sender: TObject);
    Procedure Form_Open(TIP:Byte);
    Procedure Ardiye_Open;
    Procedure BeyTehlike_Open;
    procedure Btn_FastClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
  Prv_TIP:Byte;
    { Public declarations }
  end;

var
  frmANT_REPORT: TfrmANT_REPORT;

implementation

uses unDATAMOD,unFUNC, main;

{$R *.dfm}

procedure TfrmANT_REPORT.ANT_GIRIS_FISI(ANT_MAIN_ID,ANT_MAIN_SID:Integer;Islem:Byte);
var
   qryTOPLAMLAR:TIB_Query;
   a,b:TfrxMemoView;//TfrxComponent;
begin
  Application.CreateForm(TfrmANT_REPORT,frmANT_REPORT);


  with frmANT_REPORT do
  begin
    Sirket_Ac;
    with qryANT_MAIN do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT ANT_MAIN_ID ');
      sql.Add('     , ANT_MAIN_SID ');
      sql.Add('     , DEF_SIRA_NO ');
      sql.Add('     , TARIH ');
      sql.Add('     , GIRCIK ');
      sql.Add('     , TASIYAN ');
      sql.Add('     , TASIYAN_ID ');
      sql.Add('     , OZET_BEYAN_NO ');
      sql.Add('     , OZET_BEYAN_TAR ');
      sql.Add('     , KONSIMENTO ');
      sql.Add('     , GIRIS_ANT_DETAIL_ID ');
      sql.Add('     , CIK_KAP ');
      sql.Add('     , CIK_KILO ');
      sql.Add('     , FATURA_ID ');
      sql.Add('     , GUM_VEZ_NO ');
      sql.Add('     , GUM_VEZ_TAR ');
      sql.Add('     , GUM_KOM_KOD ');
      sql.Add('     , KAP_BOL ');
      sql.Add('FROM ANT_MAIN ');
      sql.Add('WHERE ANT_MAIN_ID ='+ IntToStr(ANT_MAIN_ID));
      Open;
    end;

    with qryANT_DETAIL do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT ANT_DETAIL_ID ');
      sql.Add('     , ANT_MAIN_ID ');
      sql.Add('     , ANT_BEYAN_NO ');
      sql.Add('     , ANT_BEYAN_TAR ');
      sql.Add('     , KONSIMENTO ');
      sql.Add('     , CARI_AD ');
      sql.Add('     , CARI_KOD ');
      sql.Add('     , KAP_ADET ');
      sql.Add('     , KILO ');
      sql.Add('     , ESYA ');
      sql.Add('     , YANICI ');
      sql.Add('     , ARDIYE_FIY ');
      sql.Add('     , ARD_DOVKOD ');
      sql.Add('     , HAMMALIYE ');
      sql.Add('     , HAMM_DOVKOD ');
      sql.Add('     , KALAN_KAP ');
      sql.Add('     , KALAN_KILO ');
      sql.Add('FROM ANT_DETAIL ');
      sql.Add('WHERE ANT_DETAIL.ANT_MAIN_ID=' + IntToStr(ANT_MAIN_ID) );
      Open;
    end;
    frxANT_MAIN.FieldAliases.Clear;
    frxANT_DETAIL.FieldAliases.Clear;
    DataMod.CreateQuery(qryTOPLAMLAR,Nil,False,DataMod.dbaMain);
    qryTOPLAMLAR.SQL.Add('SELECT SUM(KAP_ADET) AS TOPLAM_KAP , SUM(KILO) AS TOPLAM_KILO FROM ANT_DETAIL WHERE ANT_MAIN_ID = ' + IntToStr(ANT_MAIN_ID));
    qryTOPLAMLAR.Open;
    frxReport1.LoadFromFile(glb_REPORTS_DIR + '\Antrepo\ANT_GIRIS_LISTE.fr3',True);
    a:=(frxReport1.FindComponent('Memo30') as TfrxMemoView);
    a.memo.Text:= 'Yalnýz, '+  Param(qryTOPLAMLAR.FieldByName('TOPLAM_KAP').asInteger) + ' KAP';

    b:=(frxReport1.FindComponent('Memo51') as TfrxMemoView);
    b.memo.Text:= 'Yalnýz, ' + KiloYaziIle(qryTOPLAMLAR.FieldByName('TOPLAM_KILO').AsCurrency) + ' dir.';
   frxReport1.ShowReport(True);
  end;
end;
procedure TfrmANT_REPORT.frxReport1ClosePreview(Sender: TObject);
begin
   frmANT_REPORT.Release;
end;

procedure TfrmANT_REPORT.Sirket_Ac;
begin
  with frmANT_REPORT do
  begin
    qrySIRKET.Close;
    qrySIRKET.ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
    qrySIRKET.Open;
  end;
end;

procedure TfrmANT_REPORT.ANT_CIKIS_FISI(ANT_MAIN_ID,ANT_MAIN_SID,ANT_DETAIL_ID:Integer;Islem:Byte);
var a,b:TfrxMemoView;//TfrxComponent;
begin
  Application.CreateForm(TfrmANT_REPORT,frmANT_REPORT);
  with frmANT_REPORT do
  begin
    Sirket_Ac;
    with qryANT_MAIN do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT ANT_MAIN_ID ');
      sql.Add('     , ANT_MAIN_SID ');
      sql.Add('     , DEF_SIRA_NO ');
      sql.Add('     , TARIH ');
      sql.Add('     , GIRCIK ');
      sql.Add('     , TASIYAN ');
      sql.Add('     , TASIYAN_ID ');
      sql.Add('     , OZET_BEYAN_NO ');
      sql.Add('     , OZET_BEYAN_TAR ');
      sql.Add('     , KONSIMENTO ');
      sql.Add('     , GIRIS_ANT_DETAIL_ID ');
      sql.Add('     , CIK_KAP ');
      sql.Add('     , CIK_KILO ');
      sql.Add('     , FATURA_ID ');
      sql.Add('     , GUM_VEZ_NO ');
      sql.Add('     , GUM_VEZ_TAR ');
      sql.Add('     , GUM_KOM_KOD ');
      sql.Add('     , KAP_BOL ');
      sql.Add('FROM ANT_MAIN ');
      sql.Add('WHERE ANT_MAIN_ID ='+ IntToStr(ANT_MAIN_ID));
      Open;
    end;

    with qryANT_DETAIL do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT ANT_DETAIL_ID ');
      sql.Add('     , ANT_DETAIL.ANT_MAIN_ID ');
      sql.Add('     , ANT_BEYAN_NO ');
      sql.Add('     , ANT_BEYAN_TAR ');
      sql.Add('     , ANT_DETAIL.KONSIMENTO ');
      sql.Add('     , ANT_MAIN.OZET_BEYAN_NO ');
      sql.Add('     , ANT_MAIN.OZET_BEYAN_TAR ');
      sql.Add('     , CARI_AD ');
      sql.Add('     , CARI_KOD ');
      sql.Add('     , KAP_ADET ');
      sql.Add('     , KILO ');
      sql.Add('     , ESYA ');
      sql.Add('     , YANICI ');
      sql.Add('     , ARDIYE_FIY ');
      sql.Add('     , ARD_DOVKOD ');
      sql.Add('     , HAMMALIYE ');
      sql.Add('     , HAMM_DOVKOD ');
      sql.Add('     , KALAN_KAP ');
      sql.Add('     , KALAN_KILO ');
      sql.Add('FROM ANT_DETAIL ');
      sql.Add('INNER JOIN ANT_MAIN ON (ANT_DETAIL.ANT_MAIN_ID = ANT_MAIN.ANT_MAIN_ID)');
      sql.Add('WHERE ANT_DETAIL.ANT_DETAIL_ID=' + IntToStr(ANT_DETAIL_ID));
      Open;
    end;
    frxANT_MAIN.FieldAliases.Clear;
    frxANT_DETAIL.FieldAliases.Clear;
    frxReport1.LoadFromFile(glb_REPORTS_DIR + '\Antrepo\ANT_CIKIS_FISI.fr3',True);
    a:=(frxReport1.FindComponent('Memo30') as TfrxMemoView);
    a.memo.Text:= 'Yukarýda yazýlý '+  Param(qryANT_MAIN.FieldByName('CIK_KAP').asInteger) + ' kap eþya ' +
                  qryANT_MAIN.FieldByName('TARIH').AsString + ' tarihinde ambardan çýkmýþtýr.';

    frxReport1.ShowReport(True);
  end;
end;


procedure TfrmANT_REPORT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmANT_REPORT.FormShow(Sender: TObject);
begin
  dtpIslemTar1.Date := glb_DONEM_BAS;
  dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
end;

Procedure TfrmANT_REPORT.Form_Open(TIP:Byte);
var a,b:TfrxMemoView;//TfrxComponent;
begin
  //Application.CreateForm(TfrmANT_REPORT,frmANT_REPORT);

    if not MainForm.FindChildFrm(Application,'frmANT_REPORT') then
    begin
      Application.CreateForm(TfrmANT_REPORT, frmANT_REPORT);
    end;

  with frmANT_REPORT do
  begin
    prv_TIP:=TIP;
    Sirket_Ac;
{    qryANT_REPORT.Close;
    qryANT_REPORT.SQL.Clear;
    qryANT_REPORT.SQL.Add('SELECT * FROM ANT_RAPOR(' + IntToStr(TIP) + ')');
    frxReport1.LoadFromFile(glb_REPORTS_DIR + '\Antrepo\ANT_RAPOR.fr3',True);
    a:=(frxReport1.FindComponent('txtREPORT_NAME') as TfrxMemoView);
    case TIP of
     1: a.memo.Text := 'Geçici Depolama Giriþ ve Çýkýþ Stok Listesi';
     2: a.memo.Text := 'Antrepo Giriþ ve Çýkýþ Stok Listesi';
     3: a.memo.Text := 'Stok Defteri';
     4: a.memo.Text := 'Tüm Antrepo Hareket Dökümü';
    end;
    frxReport1.ShowReport(True);}

  end;
end;

Procedure TfrmANT_REPORT.Ardiye_Open;
begin
    if not MainForm.FindChildFrm(Application,'frmANT_REPORT') then
    begin
      Application.CreateForm(TfrmANT_REPORT, frmANT_REPORT);
    end;
//  Application.CreateForm(TfrmANT_REPORT,frmANT_REPORT);
 with frmANT_REPORT do
  begin
    prv_TIP:=5;
  end;
{  with frmANT_REPORT do
  begin
    Sirket_Ac;
    qryARDIYE.Close;
    qryARDIYE.SQL.Clear;
    qryARDIYE.SQL.Add('SELECT * FROM ARDIYE(:tar1,:tar2)');
    qryARDIYE.ParamByName('tar1').AsDate:=dtpIslemTar1.Date;
    qryARDIYE.ParamByName('tar2').AsDate:=dtpIslemTar2.Date;

    frxReport1.LoadFromFile(glb_REPORTS_DIR + '\Antrepo\ARDIYE.fr3',True);
    frxReport1.ShowReport(True);
  end;
  }
end;

Procedure TfrmANT_REPORT.BeyTehlike_Open;
begin
    if not MainForm.FindChildFrm(Application,'frmANT_REPORT') then
    begin
      Application.CreateForm(TfrmANT_REPORT, frmANT_REPORT);
    end;

//  Application.CreateForm(TfrmANT_REPORT,frmANT_REPORT);

 with frmANT_REPORT do
  begin
    prv_TIP:=6;
  end;

{
  with frmANT_REPORT do
  begin
    Sirket_Ac;
    qryBEY_TEKLIKE.Close;
    qryBEY_TEKLIKE.SQL.Clear;
    qryBEY_TEKLIKE.SQL.Text:=
'SELECT ANT_MAIN.ANT_MAIN_ID '+
'      , ANT_DETAIL.ANT_DETAIL_ID '+
'      , ANT_MAIN.DEF_SIRA_NO '+
'      , ANT_MAIN.TARIH '+
'      , ANT_MAIN.TASIYAN_ID '+
'      , ANT_MAIN.OZET_BEYAN_NO '+
'      , ANT_MAIN.OZET_BEYAN_TAR '+
'      , ANT_DETAIL.KONSIMENTO '+
'      , ANT_DETAIL.CARI_KOD '+
'      , ANT_DETAIL.CARI_AD '+
'      , ANT_DETAIL.KAP_ADET '+
'      , ANT_DETAIL.KILO '+
'      , ANT_DETAIL.ESYA '+
'FROM ANT_DETAIL '+
'INNER JOIN ANT_MAIN ON (ANT_DETAIL.ANT_MAIN_ID = ANT_MAIN.ANT_MAIN_ID) '+
'WHERE (LTRIM(RTRIM(ANT_DETAIL.ANT_BEYAN_NO)) = '') AND (ANT_DETAIL.KALAN_KAP <> 0) AND '+
'((ANT_MAIN.TASIYAN = 1 AND (CURRENT_DATE >= (ANT_MAIN.TARIH + 15))) or '+
'(ANT_MAIN.TASIYAN = 2 AND (CURRENT_DATE >= (ANT_MAIN.TARIH + 40)))  ) '+
'ORDER BY ANT_MAIN.DEVIR DESCENDING, ANT_MAIN.DEF_SIRA_NO, ANT_DETAIL.ANT_DETAIL_ID ';
    qryBEY_TEKLIKE.ParamByName('tar1').AsDate:=dtpIslemTar1.Date;
    qryBEY_TEKLIKE.ParamByName('tar2').AsDate:=dtpIslemTar2.Date;
    qryBEY_TEKLIKE.Open;    

    frxReport1.LoadFromFile(glb_REPORTS_DIR + '\Antrepo\BEYAN_TEHLIKE.fr3',True);
    frxReport1.ShowReport(True);
  end;
  }
end;

procedure TfrmANT_REPORT.Btn_FastClick(Sender: TObject);
var a,b:TfrxMemoView;//TfrxComponent;
begin
     if prv_TIP in [1,2,3,4] then
     begin
          qryANT_REPORT.Close;
          qryANT_REPORT.SQL.Clear;
          //qryANT_REPORT.SQL.Add('SELECT * FROM ANT_RAPOR(' + IntToStr(prv_TIP) + ',:tar1,:tar2'+')');
          //qryANT_REPORT.SQL.Add('SELECT * FROM ANT_RAPOR(' + IntToStr(prv_TIP) + ') WHERE (OUT_G_TARIH BETWEEN :TAR1 and :TAR2)');
          qryANT_REPORT.SQL.Add('SELECT * FROM ANT_RAPOR(' + IntToStr(prv_TIP) + ') WHERE (OUT_G_TARIH BETWEEN :TAR1 and :TAR2) AND ((OUT_C_TARIH BETWEEN :TAR1 and :TAR2) or (OUT_C_TARIH IS NULL))');
          //qryANT_REPORT.SQL.Add('SELECT * FROM ANT_RAPOR(' + IntToStr(prv_TIP) + ',NULL,NULL) WHERE (OUT_G_TARIH BETWEEN :TAR1 and :TAR2)');
          qryANT_REPORT.ParamByName('tar1').AsDate:=dtpIslemTar1.Date;
          qryANT_REPORT.ParamByName('tar2').AsDate:=dtpIslemTar2.Date;
          frxReport1.LoadFromFile(glb_REPORTS_DIR + '\Antrepo\ANT_RAPOR.fr3',True);
          a:=(frxReport1.FindComponent('txtREPORT_NAME') as TfrxMemoView);


          case prv_TIP of
           1: a.memo.Text := 'Geçici Depolama Giriþ ve Çýkýþ Stok Listesi';
           2: a.memo.Text := 'Antrepo Giriþ ve Çýkýþ Stok Listesi';
           3: a.memo.Text := 'Stok Defteri';
           4: a.memo.Text := 'Tüm Antrepo Hareket Dökümü';
          end;

          a:=(frxReport1.FindComponent('Memo_Batar') as TfrxMemoView);
          a.memo.Text:= DateToStr(dtpIslemTar1.Date);
          a:=(frxReport1.FindComponent('Memo_Bitar') as TfrxMemoView);
          a.memo.Text:= DateToStr(dtpIslemTar2.Date);


          frxReport1.ShowReport(True);
     end;


     if prv_TIP =5 then
     begin
         with frmANT_REPORT do
          begin
            Sirket_Ac;
            qryARDIYE.Close;
            qryARDIYE.SQL.Clear;
            //qryARDIYE.SQL.Add('SELECT * FROM ARDIYE(:tar1,:tar2)');
//ibo            qryARDIYE.SQL.Add('SELECT * FROM ARDIYE WHERE (OUT_G_TARIH BETWEEN :TAR1 and :TAR2)');
            //qryARDIYE.SQL.Add('SELECT * FROM ARDIYE(NULL,NULL) WHERE (OUT_G_TARIH BETWEEN :TAR1 and :TAR2) ');
//            qryARDIYE.SQL.Add('SELECT * FROM ARDIYE(:TAR1,:TAR2) WHERE (OUT_G_TARIH BETWEEN :TAR1 and :TAR2)');
                        qryARDIYE.SQL.Add('SELECT * FROM ARDIYE(:TAR1,:TAR2) WHERE (OUT_G_TARIH <=:TAR2)');

            qryARDIYE.ParamByName('tar1').AsDate:=dtpIslemTar1.Date;
            qryARDIYE.ParamByName('tar2').AsDate:=dtpIslemTar2.Date;

            frxReport1.LoadFromFile(glb_REPORTS_DIR + '\Antrepo\ARDIYE.fr3',True);

            a:=(frxReport1.FindComponent('Memo_Batar') as TfrxMemoView);
            a.memo.Text:= DateToStr(dtpIslemTar1.Date);
            a:=(frxReport1.FindComponent('Memo_Bitar') as TfrxMemoView);
            a.memo.Text:= DateToStr(dtpIslemTar2.Date);

            frxReport1.ShowReport(True);
          end;
     end;

     if prv_TIP =6 then
     begin
          with frmANT_REPORT do
          begin
            Sirket_Ac;
            qryBEY_TEKLIKE.Close;
      {      qryBEY_TEKLIKE.SQL.Clear;
            qryBEY_TEKLIKE.SQL.Text:=
        'SELECT ANT_MAIN.ANT_MAIN_ID '+
        '      , ANT_DETAIL.ANT_DETAIL_ID '+
        '      , ANT_MAIN.DEF_SIRA_NO '+
        '      , ANT_MAIN.TARIH '+
        '      , ANT_MAIN.TASIYAN_ID '+
        '      , ANT_MAIN.OZET_BEYAN_NO '+
        '      , ANT_MAIN.OZET_BEYAN_TAR '+
        '      , ANT_DETAIL.KONSIMENTO '+
        '      , ANT_DETAIL.CARI_KOD '+
        '      , ANT_DETAIL.CARI_AD '+
        '      , ANT_DETAIL.KAP_ADET '+
        '      , ANT_DETAIL.KILO '+
        '      , ANT_DETAIL.ESYA '+
        'FROM ANT_DETAIL '+
        'INNER JOIN ANT_MAIN ON (ANT_DETAIL.ANT_MAIN_ID = ANT_MAIN.ANT_MAIN_ID) '+
        'WHERE (LTRIM(RTRIM(ANT_DETAIL.ANT_BEYAN_NO)) = '') AND (ANT_DETAIL.KALAN_KAP <> 0) AND '+
        '((ANT_MAIN.TASIYAN = 1 AND (CURRENT_DATE >= (ANT_MAIN.TARIH + 15))) or '+
        '(ANT_MAIN.TASIYAN = 2 AND (CURRENT_DATE >= (ANT_MAIN.TARIH + 40)))  ) '+
        ' AND (ANT_MAIN.TARIH BETWEEN :TAR1 and :TAR2)'+
        'ORDER BY ANT_MAIN.DEVIR DESCENDING, ANT_MAIN.DEF_SIRA_NO, ANT_DETAIL.ANT_DETAIL_ID ';
        }
            qryBEY_TEKLIKE.ParamByName('TAR1').AsDate:=dtpIslemTar1.Date;
            qryBEY_TEKLIKE.ParamByName('TAR2').AsDate:=dtpIslemTar2.Date;
            qryBEY_TEKLIKE.Open;

            frxReport1.LoadFromFile(glb_REPORTS_DIR + '\Antrepo\BEYAN_TEHLIKE.fr3',True);
            a:=(frxReport1.FindComponent('Memo_Batar') as TfrxMemoView);
            a.memo.Text:= DateToStr(dtpIslemTar1.Date);
            a:=(frxReport1.FindComponent('Memo_Bitar') as TfrxMemoView);
            a.memo.Text:= DateToStr(dtpIslemTar2.Date);

            frxReport1.ShowReport(True);
          end;


     end;

end;

procedure TfrmANT_REPORT.Button3Click(Sender: TObject);
begin
Close;
end;

end.
