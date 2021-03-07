unit unDEKONT_AUT;

interface

uses
  SysUtils, Classes, IB_Components,windows,forms, Menus;

type
  TDEKONT_AUT = class(TDataModule)
  procedure DekontAUT_Open(Sender: TObject);
  procedure Menu_ayarla;
  function DekontuSablonOlarakKopyala:Boolean;
  function DekontKopyala(ID,SID:String):Boolean;
  function FaturaKopyala(ID,SID:String;FAT_IRS_SEP:Byte):Boolean;
  function IrsaliyeKopyala(ID,SID:String;FAT_IRS_SEP:Byte):Boolean;
  function KasaMuhtelifKopyala(ID,SID:String):Boolean;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DEKONT_AUT: TDEKONT_AUT;

implementation

uses main,unDataMod, ufrmISN_ERRORS, unLogger,  ufrmDEKONTT,unfunc,
     ufrmFAT_IRS,ufrmKASA_MUHTELIF, ufrmIRSALIYE,ufrmDEKONT_AUT;

{$R *.dfm}

procedure TDEKONT_AUT.DekontAUT_Open(Sender: TObject);
var
  qryDekont_AUT,qryDekont_D_AUT : TIB_Cursor;
  DOVKUR : Currency;
  i : SmallInt;
begin
//****************************************************************************//
  if MainForm.FindChildFrm(Application,'frmDEKONTT') then
  begin
    Application.MessageBox ('Dekont Tanýmlama Formu açýk iken bu menüyü kullanamazsýnýz.','Dikkat', MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  for i := 0 to glb_TAK_DOV_LIST.Count -1 do
  begin
    DOVKUR := DataMod.Get_Doviz_Kur(glb_TAK_DOV_LIST[i],DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
    if DOVKUR=0 Then
    begin
      exit;
    end
  end;
//****************************************************************************//
  try
    try
//****************************************************************************//
      DataMod.CreateCursor(qryDekont_AUT,nil,False,DataMod.dbaMain);
      DataMod.CreateCursor(qryDekont_D_AUT,nil,False,DataMod.dbaMain);
//****************************************************************************//
      with qryDekont_AUT do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM DEKONT_AUT WHERE DEKONT_AUT_NAME = '+SQL_Katar((Sender as TMenuItem).Hint));
        Open;
      end;
//****************************************************************************//
      if qryDekont_AUT.RecordCount <> 0 then
      begin
//****************************************************************************//
        with qryDekont_D_AUT do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM DEKONT_D_AUT WHERE DEKONT_ID = '+qryDekont_AUT.FieldByName('DEKONT_ID').AsString + ' AND DEKONT_SID ='+qryDekont_AUT.FieldByName('DEKONT_SID').AsString);
          Open;
        end;
//****************************************************************************//
        frmDEKONTT.Form_Open(True,0,0,0,1,False);
//****************************************************************************//
        frmDEKONTT.qryDekont.DisableControls;
        frmDEKONTT.qryDEKONT_D.DisableControls;
//****************************************************************************//
        with frmDEKONTT.qryDekont do
        begin
          FieldByName('ACIKLAMA').AsString := qryDekont_AUT.FieldByName('ACIKLAMA').AsString;
          FieldByName('MASRAF_MERK').AsString := qryDekont_AUT.FieldByName('MASRAF_MERK').AsString;
          FieldByName('PROJE_KOD').AsString := qryDekont_AUT.FieldByName('PROJE_KOD').AsString;
          frmDEKONTT.IB_Edit2Exit(Self);
        end;
//****************************************************************************//
        frmDEKONTT.pcDEKONT.ActivePage := frmDEKONTT.tabDETAY;
        qryDekont_D_AUT.First;
        while not qryDekont_D_AUT.Eof do
        begin
          with frmDEKONTT.qryDekont_D do
          begin
            Append;
            FieldByName('BA').AsString := qryDekont_D_AUT.FieldByName('BA').AsString;
            FieldByName('MC').AsString := qryDekont_D_AUT.FieldByName('MC').AsString;
            FieldByName('KARSI_KOD').AsString := qryDekont_D_AUT.FieldByName('KARSI_KOD').AsString;
            frmDEKONTT.txtKARSI_KODExit(Self);
            FieldByName('DOVKOD').AsString := qryDekont_D_AUT.FieldByName('DOVKOD').AsString;
            FieldByName('DOVKUR').AsExtended := DataMod.Get_Doviz_Kur(FieldByName('DOVKOD').AsString,DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
            FieldByName('TUTAR').AsCurrency := qryDekont_D_AUT.FieldByName('TUTAR').AsCurrency;
            FieldByName('TUTAR_VPB').AsCurrency := FieldByName('TUTAR').AsCurrency * FieldByName('DOVKUR').AsCurrency;
            FieldByName('ACIKLAMA1').AsString := qryDekont_D_AUT.FieldByName('ACIKLAMA1').AsString;
            FieldByName('ACIKLAMA2').AsString := qryDekont_D_AUT.FieldByName('ACIKLAMA2').AsString;
            FieldByName('OLCUBIRIM').AsString := qryDekont_D_AUT.FieldByName('OLCUBIRIM').AsString;
            FieldByName('MIKTAR').asCurrency := qryDekont_D_AUT.FieldByName('MIKTAR').asCurrency;
            FieldByName('PROJE_KOD').asString := qryDekont_D_AUT.FieldByName('PROJE_KOD').asString;
            frmDEKONTT.txtProjeKodExit(Self);
            frmDEKONTT.btnKAYDETClick(Self);
          end;
          qryDekont_D_AUT.Next;
        end;
//****************************************************************************//
        Application.ProcessMessages;
      end;
    except
      Application.MessageBox('Þablon üzerinden dekont oluþturma iþleminde hata oluþtu.','Dikkat',MB_ICONWARNING);
      raise;
    end;
  finally
//****************************************************************************//
    DataMod.ReleaseCursor(qryDekont_AUT);
    DataMod.ReleaseCursor(qryDekont_D_AUT);
//****************************************************************************//
    frmDEKONTT.qryDekont.EnableControls;
    frmDEKONTT.qryDekont_D.EnableControls;
  end;
end;

procedure TDEKONT_AUT.Menu_ayarla;
var
  qryDekontAUT:TIB_Cursor;
  SubNum,Num : SmallInt;
  MyItem : TMenuItem;
begin
  try
//****************************************************************************//
    if MainForm.MainMenu.Items[1].Items[2].Items[MainForm.MainMenu.Items[1].Items[2].Count-1].Hint = 'Dekont Þablonlarý' then
    begin
      MainForm.MainMenu.Items[1].Items[2].Delete(MainForm.MainMenu.Items[1].Items[2].Count-1);
    end;
//****************************************************************************//
    DataMod.CreateCursor(qryDekontAUT,nil,False,DataMod.dbaMain);
    with qryDekontAUT do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT DEKONT_AUT_NAME FROM DEKONT_AUT ORDER BY DEKONT_ID');
      Open;
    end;
//****************************************************************************//
    Num := 0;
    if qryDekontAUT.RecordCount <> 0 then
    begin
      if num = 0 then
      begin
        Subnum := MainForm.MainMenu.Items[1].Items[2].Count;
        MyItem := TMenuItem.Create(Self);
        MyItem.Caption := 'Dekont Þablonlarý';
        MyItem.Hint := 'Dekont Þablonlarý';
        MainForm.MainMenu.Items[1].Items[2].Add(MyItem);
      end;
      qryDekontAUT.First;
      while not qryDekontAUT.Eof do
      begin
        MyItem := TMenuItem.Create(Self);
        MyItem.Caption := qryDekontAUT.FieldByName('DEKONT_AUT_NAME').AsString;
        MyItem.Hint := qryDekontAUT.FieldByName('DEKONT_AUT_NAME').AsString;
        MainForm.MainMenu.Items[1].Items[2].Items[SubNum].Insert(Num,MyItem);
        MyItem.OnClick :=  DEKONT_AUT.DekontAUT_Open;
        inc(num);
        qryDekontAUT.Next;
      end;
    end;
  finally
    DataMod.ReleaseCursor(qryDekontAUT);
  end;
end;


function TDEKONT_AUT.DekontuSablonOlarakKopyala:Boolean;
var
  i : Byte;
  DOVKUR : Currency;
begin
//****************************************************************************//
  Result := False;
//****************************************************************************//
  for i := 0 to glb_TAK_DOV_LIST.Count -1 do
  begin
    DOVKUR := DataMod.Get_Doviz_Kur(glb_TAK_DOV_LIST[i],DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
    if DOVKUR=0 Then
    begin
      exit;
    end
  end;
//****************************************************************************//
  try
    try
//****************************************************************************//
      frmDEKONT_AUT.Form_Open(True,0,0,0,False);
//****************************************************************************//
      frmDEKONT_AUT.qryDEKONT.DisableControls;
      frmDEKONT_AUT.qryDEKONT_D.DisableControls;
//****************************************************************************//
      frmDEKONTT.qryDEKONT.DisableControls;
      frmDEKONTT.qryDEKONT_D.DisableControls;
//****************************************************************************//
      with frmDEKONT_AUT.qryDEKONT do
      begin
        FieldByName('ACIKLAMA').AsString := frmDEKONTT.qryDekont.FieldByName('ACIKLAMA').AsString;
        FieldByName('MASRAF_MERK').AsString := frmDEKONTT.qryDekont.FieldByName('MASRAF_MERK').AsString;
        FieldByName('KOD2').AsString := frmDEKONTT.qryDekont.FieldByName('KOD2').AsString;
        FieldByName('KOD3').AsString := frmDEKONTT.qryDekont.FieldByName('KOD3').AsString;
        FieldByName('KOD4').AsString := frmDEKONTT.qryDekont.FieldByName('KOD4').AsString;
        FieldByName('PROJE_KOD').AsString :=  frmDEKONTT.qryDekont.FieldByName('PROJE_KOD').AsString;
        frmDEKONT_AUT.IB_Edit2Exit(Self);
      end;
//****************************************************************************//
      frmDEKONT_AUT.pcDEKONT.ActivePage := frmDEKONT_AUT.tabDETAY;
      frmDEKONTT.qryDEKONT_D.First;
//****************************************************************************//
      while not frmDEKONTT.qryDekont_D.Eof do
      begin
        with frmDEKONT_AUT.qryDekont_D do
        begin
          Append;
          FieldByName('BA').AsString := frmDEKONTT.qryDekont_D.FieldByName('BA').AsString;
          FieldByName('MC').AsString := frmDEKONTT.qryDekont_D.FieldByName('MC').AsString;
          FieldByName('KARSI_KOD').AsString := frmDEKONTT.qryDekont_D.FieldByName('KARSI_KOD').AsString;
          frmDEKONT_AUT.txtKARSI_KODExit(Self);
          FieldByName('DOVKOD').AsString := frmDEKONTT.qryDekont_D.FieldByName('DOVKOD').AsString;
          FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(FieldByName('DOVKOD').AsString,DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
          FieldByName('TUTAR').AsCurrency := frmDEKONTT.qryDekont_D.FieldByName('TUTAR').AsCurrency;
          FieldByName('TUTAR_VPB').AsCurrency := FieldByName('TUTAR').AsCurrency * FieldByName('DOVKUR').AsCurrency;
          FieldByName('ACIKLAMA1').AsString := frmDEKONTT.qryDekont_D.FieldByName('ACIKLAMA1').AsString;
          FieldByName('ACIKLAMA2').AsString := frmDEKONTT.qryDekont_D.FieldByName('ACIKLAMA2').AsString;
          FieldByName('OLCUBIRIM').AsString := frmDEKONTT.qryDekont_D.FieldByName('OLCUBIRIM').AsString;
          FieldByName('MIKTAR').asCurrency := frmDEKONTT.qryDekont_D.FieldByName('MIKTAR').asCurrency;
          FieldByName('PROJE_KOD').asString := frmDEKONTT.qryDekont_D.FieldByName('PROJE_KOD').asString;
          frmDEKONT_AUT.txtProjeKodExit(Self);
          frmDEKONT_AUT.btnKAYDETClick(Self);
        end;
        frmDEKONTT.qryDekont_D.Next;
      end;
      Application.ProcessMessages;
      Result := True;
    except
      Result := False;
  //    Application.MessageBox('Þablon üzerinden dekont oluþturma iþleminde hata oluþtu.','Dikkat',MB_ICONWARNING);
      raise;
    end;
  finally
//****************************************************************************//
    frmDEKONT_AUT.qryDekont.EnableControls;
    frmDEKONT_AUT.qryDekont_D.EnableControls;
//****************************************************************************//
    frmDEKONTT.qryDEKONT.EnableControls;
    frmDEKONTT.qryDEKONT_D.EnableControls;
//****************************************************************************//
  end;
end;


function TDEKONT_AUT.DekontKopyala(ID,SID:String): Boolean;
var
  qryDekont,qryDekontD : TIB_Cursor;
  i:Byte;
  DOVKUR:Currency;
begin
  Result := False;
//****************************************************************************//
  for i := 0 to glb_TAK_DOV_LIST.Count -1 do
  begin
    DOVKUR := DataMod.Get_Doviz_Kur(glb_TAK_DOV_LIST[i],DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
    if DOVKUR=0 Then
    begin
      exit;
    end
  end;
//****************************************************************************//
  try
    try
      frmDEKONTT.DataSet_Open(0,0,0,1);
//****************************************************************************//
      DataMod.CreateCursor(qryDekont,nil,False,DataMod.dbaMain);
      DataMod.CreateCursor(qryDekontD,nil,False,DataMod.dbaMain);
//****************************************************************************//
      with qryDekont do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM DEKONT WHERE DEKONT_ID = '+ID+' AND DEKONT_SID ='+SID);
        Open;
      end;
//****************************************************************************//
      if qryDekont.RecordCount = 0 then
      begin
        Application.MessageBox('Kopyalamak istediðiniz kayýt sistemde bulunamadý.','Dikkat',MB_ICONWARNING);
        exit;
      end;
//****************************************************************************//
      with qryDekontD do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM DEKONT_D WHERE DEKONT_ID = '+ID+' AND DEKONT_SID ='+SID+' ORDER BY DEKONT_D_ID');
        Open;
      end;
//****************************************************************************//
      frmDEKONTT.qryDekont.DisableControls;
      frmDEKONTT.qryDekont_D.DisableControls;
//****************************************************************************//
      with frmDEKONTT.qryDekont do
      begin
        FieldByName('ACIKLAMA').AsString := qryDekont.FieldByName('ACIKLAMA').AsString;
        FieldByName('MASRAF_MERK').AsString := qryDekont.FieldByName('MASRAF_MERK').AsString;
        FieldByName('KOD2').AsString := qryDekont.FieldByName('KOD2').AsString;
        FieldByName('KOD3').AsString := qryDekont.FieldByName('KOD3').AsString;
        FieldByName('KOD4').AsString := qryDekont.FieldByName('KOD4').AsString;
        FieldByName('PROJE_KOD').AsString := qryDekont.FieldByName('PROJE_KOD').AsString;
        frmDEKONTT.IB_Edit2Exit(Self);
      end;
//****************************************************************************//
      frmDEKONTT.pcDEKONT.ActivePage := frmDEKONTT.tabDETAY;
      qryDekontD.First;
      while not qryDekontD.Eof do
      begin
        with frmDEKONTT.qryDekont_D do
        begin
          Append;
          FieldByName('BA').AsString := qryDekontD.FieldByName('BA').AsString;
          FieldByName('MC').AsString := qryDekontD.FieldByName('MC').AsString;
          FieldByName('KARSI_KOD').AsString := qryDekontD.FieldByName('KARSI_KOD').AsString;
          frmDEKONTT.txtKARSI_KODExit(Self);
          FieldByName('DOVKOD').AsString := qryDekontD.FieldByName('DOVKOD').AsString;
          FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(FieldByName('DOVKOD').AsString,DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
          FieldByName('TUTAR').AsCurrency := qryDekontD.FieldByName('TUTAR').AsCurrency;
          FieldByName('TUTAR_VPB').AsCurrency := FieldByName('TUTAR').AsCurrency * FieldByName('DOVKUR').AsCurrency;
          FieldByName('ACIKLAMA1').AsString := qryDekontD.FieldByName('ACIKLAMA1').AsString;
          FieldByName('ACIKLAMA2').AsString := qryDekontD.FieldByName('ACIKLAMA2').AsString;
          FieldByName('OLCUBIRIM').AsString := qryDekontD.FieldByName('OLCUBIRIM').AsString;
          FieldByName('MIKTAR').asCurrency := qryDekontD.FieldByName('MIKTAR').asCurrency;
          FieldByName('PROJE_KOD').asString := qryDekontD.FieldByName('PROJE_KOD').asString;
          frmDEKONTT.txtProjeKodExit(Self);
          frmDEKONTT.btnKAYDETClick(Self);
        end;
        qryDekontD.Next;
      end;
//****************************************************************************//
      Result := True;
    except
      Result := False;
    end;
  finally
//****************************************************************************//
    DataMod.ReleaseCursor(qryDekont);
    DataMod.ReleaseCursor(qryDekontD);
//****************************************************************************//
    frmDEKONTT.qryDekont.EnableControls;
    frmDEKONTT.qryDekont_D.EnableControls;
//****************************************************************************//
  end;
end;


function TDEKONT_AUT.FaturaKopyala(ID, SID : String; FAT_IRS_SEP:Byte): Boolean;
var
  qryFATIRS,qryURUNHAR : TIB_Cursor;
  i : Byte;
  DOVKUR : Currency;
begin
  Result := False;
//****************************************************************************//
  for i := 0 to glb_TAK_DOV_LIST.Count -1 do
  begin
    DOVKUR := DataMod.Get_Doviz_Kur(glb_TAK_DOV_LIST[i],DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
    if DOVKUR=0 Then
    begin
      exit;
    end
  end;
//****************************************************************************//
  try
    try
//****************************************************************************//
      frmFAT_IRS.DataSet_Open(0,0,0);
//****************************************************************************//
      DataMod.CreateCursor(qryFATIRS,nil,False,DataMod.dbaMain);
      DataMod.CreateCursor(qryURUNHAR,nil,False,DataMod.dbaMain);
//****************************************************************************//
      with qryFATIRS do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM FAT_IRS WHERE FAT_IRS_ID = '+ID+' AND FAT_IRS_SID ='+SID+' AND FAT_IRS_SEP = '+inttostr(FAT_IRS_SEP));
        Open;
      end;
//****************************************************************************//
      if qryFATIRS.RecordCount = 0 then
      begin
        Application.MessageBox('Kopyalamak istediðiniz kayýt sistemde bulunamadý.','Dikkat',MB_ICONWARNING);
        exit;
      end;
//****************************************************************************//
      with qryURUNHAR do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM URUNHAR WHERE FATURA_ID = '+ID+' AND FATURA_SID ='+SID+' ORDER BY URUNHAR_ID');
        Open;
      end;
//****************************************************************************//
      frmFAT_IRS.qryFAT_IRS.DisableControls;
      frmFAT_IRS.qryURUNHAR.DisableControls;
//****************************************************************************//
      with frmFAT_IRS.qryFAT_IRS do
      begin
        frmFAT_IRS.txtCariKod.Text := qryFATIRS.FieldByName('CARI_KOD').AsString;
        FieldByName('CARI_KOD').AsString := qryFATIRS.FieldByName('CARI_KOD').AsString;
        frmFAT_IRS.txtCariKodExit(Self);
        frmFAT_IRS.txtDepoKod.Text := qryFATIRS.FieldByName('DEPO_KOD').AsString;
        FieldByName('DEPO_KOD').AsString := qryFATIRS.FieldByName('DEPO_KOD').AsString;
        frmFAT_IRS.txtDepoKodExit(Self);
        frmFAT_IRS.txtPlasiyerKod.Text := qryFATIRS.FieldByName('PLASIYER_KOD').AsString;
        FieldByName('PLASIYER_KOD').AsString := qryFATIRS.FieldByName('PLASIYER_KOD').AsString;
        frmFAT_IRS.txtPlasiyerKodExit(Self);
        frmFAT_IRS.txtProjeKod.Text := qryFATIRS.FieldByName('PROJE_KOD').AsString;
        FieldByName('PROJE_KOD').AsString := qryFATIRS.FieldByName('PROJE_KOD').AsString;
        frmFAT_IRS.txtProjeKodExit(Self);
        frmFAT_IRS.txtKasaKod.Text := qryFATIRS.FieldByName('KASA_KOD').AsString;
        FieldByName('KASA_KOD').AsString := qryFATIRS.FieldByName('KASA_KOD').AsString;
        frmFAT_IRS.txtKasaKodExit(Self);
        FieldByName('ACIKLAMA').AsString := qryFATIRS.FieldByName('ACIKLAMA').AsString;
        FieldByName('YEV_ACIKLAMA').AsString := qryFATIRS.FieldByName('YEV_ACIKLAMA').AsString;
        FieldByName('MASRAF_MERK').AsString := qryFATIRS.FieldByName('MASRAF_MERK').AsString;
        FieldByName('KOD2').AsString := qryFATIRS.FieldByName('KOD2').AsString;
        FieldByName('KOD3').AsString := qryFATIRS.FieldByName('KOD3').AsString;
        FieldByName('KOD4').AsString := qryFATIRS.FieldByName('KOD4').AsString;
        FieldByName('ISKONTO_TIP').AsString := qryFATIRS.FieldByName('ISKONTO_TIP').AsString;
        FieldByName('ISKONTO_ORAN').AsString := qryFATIRS.FieldByName('ISKONTO_ORAN').AsString;
        FieldByName('OTV').AsString := qryFATIRS.FieldByName('OTV').AsString;
      end;
//****************************************************************************//
      frmFAT_IRS.pgFAT_IRS.ActivePage := frmFAT_IRS.tabKalem;
      qryURUNHAR.First;
      while not qryURUNHAR.Eof do
      begin
        with frmFAT_IRS.qryURUNHAR do
        begin
          Append;
          frmFAT_IRS.txtUrunKodu.Text := qryURUNHAR.FieldByName('URUN_KOD').AsString;
          FieldByName('URUN_KOD').AsString := qryURUNHAR.FieldByName('URUN_KOD').AsString;
          frmFAT_IRS.txtUrunKoduExit(Self);
          FieldByName('DEPO_KOD').AsString := qryURUNHAR.FieldByName('DEPO_KOD').AsString;
          frmFAT_IRS.txtDepoKodExit(Self);
          FieldByName('TIP').AsString := qryURUNHAR.FieldByName('TIP').AsString;
          FieldByName('MIKTAR').AsCurrency := qryURUNHAR.FieldByName('MIKTAR').AsCurrency;
          FieldByName('OLCUBIRIM').AsString := qryURUNHAR.FieldByName('OLCUBIRIM').AsString;
          FieldByName('BIRIM_FIY').AsCurrency := qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency;
          FieldByName('DOVKOD').AsString := qryURUNHAR.FieldByName('DOVKOD').AsString;
          FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(FieldByName('DOVKOD').AsString,DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
          FieldByName('TUTAR').AsCurrency := qryURUNHAR.FieldByName('TUTAR').AsCurrency;
          FieldByName('TUTAR_VPB').AsCurrency := FieldByName('TUTAR').AsCurrency * FieldByName('DOVKUR').AsCurrency;
          FieldByName('KDV').AsSmallint := qryURUNHAR.FieldByName('KDV').AsSmallint;
          FieldByName('ISKONTO_TIP').AsSmallint := qryURUNHAR.FieldByName('ISKONTO_TIP').AsSmallint;
          FieldByName('ISKONTO_ORAN').AsSmallint := qryURUNHAR.FieldByName('ISKONTO_ORAN').AsSmallint;
          FieldByName('ISKONTO_TUTAR').AsCurrency := qryURUNHAR.FieldByName('ISKONTO_TUTAR').AsCurrency;
          FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := FieldByName('ISKONTO_TUTAR').AsCurrency * FieldByName('DOVKUR').AsCurrency;
          FieldByName('ACIKLAMA').AsString := qryURUNHAR.FieldByName('ACIKLAMA').AsString;
          FieldByName('KDV_TUTAR').AsCurrency := qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency;
//          Application.ProcessMessages;
          frmFAT_IRS.btnKaydetClick(Self);
        end;
        qryURUNHAR.Next;
      end;
      Application.ProcessMessages;
//****************************************************************************//
      Result := True;
    except
      Result := False;
    end;
  finally
//****************************************************************************//
    frmFAT_IRS.qryFAT_IRS.EnableControls;
    frmFAT_IRS.qryURUNHAR.EnableControls;
//****************************************************************************//
    DataMod.ReleaseCursor(qryFATIRS);
    DataMod.ReleaseCursor(qryURUNHAR);
//****************************************************************************//
  end;
end;

function TDEKONT_AUT.IrsaliyeKopyala(ID, SID : String; FAT_IRS_SEP:Byte): Boolean;
var
  qryFATIRS,qryURUNHAR : TIB_Cursor;
  i : Byte;
  DOVKUR : Currency;
begin
  Result := False;
//****************************************************************************//
  for i := 0 to glb_TAK_DOV_LIST.Count -1 do
  begin
    DOVKUR := DataMod.Get_Doviz_Kur(glb_TAK_DOV_LIST[i],DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
    if DOVKUR=0 Then
    begin
      exit;
    end
  end;
//****************************************************************************//
  try
    try
//****************************************************************************//
      frmIRSALIYE.DataSet_Open(0,0,0);
//****************************************************************************//
      DataMod.CreateCursor(qryFATIRS,nil,False,DataMod.dbaMain);
      DataMod.CreateCursor(qryURUNHAR,nil,False,DataMod.dbaMain);
//****************************************************************************//
      with qryFATIRS do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM FAT_IRS WHERE FAT_IRS_ID = '+ID+' AND FAT_IRS_SID ='+SID+' AND FAT_IRS_SEP = '+inttostr(FAT_IRS_SEP));
        Open;
      end;
//****************************************************************************//
      if qryFATIRS.RecordCount = 0 then
      begin
        Application.MessageBox('Kopyalamak istediðiniz kayýt sistemde bulunamadý.','Dikkat',MB_ICONWARNING);
        exit;
      end;
//****************************************************************************//
      with qryURUNHAR do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM URUNHAR WHERE IRSALIYE_ID = '+ID+' AND IRSALIYE_SID ='+SID+' ORDER BY URUNHAR_ID');
        Open;
      end;
//****************************************************************************//
      frmIRSALIYE.qryFAT_IRS.DisableControls;
      frmIRSALIYE.qryURUNHAR.DisableControls;
//****************************************************************************//
      with frmIRSALIYE.qryFAT_IRS do
      begin
        frmIRSALIYE.txtCariKod.Text := qryFATIRS.FieldByName('CARI_KOD').AsString;
        FieldByName('CARI_KOD').AsString := qryFATIRS.FieldByName('CARI_KOD').AsString;
        frmIRSALIYE.txtCariKodExit(Self);
        frmIRSALIYE.txtDepoKod.Text := qryFATIRS.FieldByName('DEPO_KOD').AsString;
        FieldByName('DEPO_KOD').AsString := qryFATIRS.FieldByName('DEPO_KOD').AsString;
        frmIRSALIYE.txtDepoKodExit(Self);
        frmIRSALIYE.txtPlasiyerKod.Text := qryFATIRS.FieldByName('PLASIYER_KOD').AsString;
        FieldByName('PLASIYER_KOD').AsString := qryFATIRS.FieldByName('PLASIYER_KOD').AsString;
        frmIRSALIYE.txtPlasiyerKodExit(Self);
        frmIRSALIYE.txtProjeKod.Text := qryFATIRS.FieldByName('PROJE_KOD').AsString;
        FieldByName('PROJE_KOD').AsString := qryFATIRS.FieldByName('PROJE_KOD').AsString;
        frmIRSALIYE.txtProjeKodExit(Self);
        frmIRSALIYE.txtKasaKod.Text := qryFATIRS.FieldByName('KASA_KOD').AsString;
        FieldByName('KASA_KOD').AsString := qryFATIRS.FieldByName('KASA_KOD').AsString;
        frmIRSALIYE.txtKasaKodExit(Self);
        FieldByName('ACIKLAMA').AsString := qryFATIRS.FieldByName('ACIKLAMA').AsString;
        FieldByName('YEV_ACIKLAMA').AsString := qryFATIRS.FieldByName('YEV_ACIKLAMA').AsString;
        FieldByName('MASRAF_MERK').AsString := qryFATIRS.FieldByName('MASRAF_MERK').AsString;
        FieldByName('KOD2').AsString := qryFATIRS.FieldByName('KOD2').AsString;
        FieldByName('KOD3').AsString := qryFATIRS.FieldByName('KOD3').AsString;
        FieldByName('KOD4').AsString := qryFATIRS.FieldByName('KOD4').AsString;
        FieldByName('ISKONTO_TIP').AsString := qryFATIRS.FieldByName('ISKONTO_TIP').AsString;
        FieldByName('ISKONTO_ORAN').AsString := qryFATIRS.FieldByName('ISKONTO_ORAN').AsString;
        FieldByName('OTV').AsString := qryFATIRS.FieldByName('OTV').AsString;
      end;
//****************************************************************************//
      frmIRSALIYE.pgFAT_IRS.ActivePage := frmIRSALIYE.tabKalem;
      qryURUNHAR.First;
      while not qryURUNHAR.Eof do
      begin
        with frmIRSALIYE.qryURUNHAR do
        begin
          Append;
          frmIRSALIYE.txtUrunKodu.Text := qryURUNHAR.FieldByName('URUN_KOD').AsString;
          FieldByName('URUN_KOD').AsString := qryURUNHAR.FieldByName('URUN_KOD').AsString;
          frmIRSALIYE.txtUrunKoduExit(Self);
          FieldByName('DEPO_KOD').AsString := qryURUNHAR.FieldByName('DEPO_KOD').AsString;
          frmIRSALIYE.txtDepoKodExit(Self);
          FieldByName('TIP').AsString := qryURUNHAR.FieldByName('TIP').AsString;
          FieldByName('MIKTAR').AsCurrency := qryURUNHAR.FieldByName('MIKTAR').AsCurrency;
          FieldByName('OLCUBIRIM').AsString := qryURUNHAR.FieldByName('OLCUBIRIM').AsString;
          FieldByName('BIRIM_FIY').AsCurrency := qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency;
          FieldByName('DOVKOD').AsString := qryURUNHAR.FieldByName('DOVKOD').AsString;
          FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(FieldByName('DOVKOD').AsString,DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
          FieldByName('TUTAR').AsCurrency := qryURUNHAR.FieldByName('TUTAR').AsCurrency;
          FieldByName('TUTAR_VPB').AsCurrency := FieldByName('TUTAR').AsCurrency * FieldByName('DOVKUR').AsCurrency;
          FieldByName('KDV').AsSmallint := qryURUNHAR.FieldByName('KDV').AsSmallint;
          FieldByName('ISKONTO_TIP').AsSmallint := qryURUNHAR.FieldByName('ISKONTO_TIP').AsSmallint;
          FieldByName('ISKONTO_ORAN').AsSmallint := qryURUNHAR.FieldByName('ISKONTO_ORAN').AsSmallint;
          FieldByName('ISKONTO_TUTAR').AsCurrency := qryURUNHAR.FieldByName('ISKONTO_TUTAR').AsCurrency;
          FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := FieldByName('ISKONTO_TUTAR').AsCurrency * FieldByName('DOVKUR').AsCurrency;
          FieldByName('ACIKLAMA').AsString := qryURUNHAR.FieldByName('ACIKLAMA').AsString;
          FieldByName('KDV_TUTAR').AsCurrency := qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency;
//          Application.ProcessMessages;
          frmIRSALIYE.btnKaydetClick(Self);
        end;
        qryURUNHAR.Next;
      end;
      Application.ProcessMessages;
//****************************************************************************//
      Result := True;
    except
      Result := False;
    end;
  finally
//****************************************************************************//
    frmIRSALIYE.qryFAT_IRS.EnableControls;
    frmIRSALIYE.qryURUNHAR.EnableControls;
//****************************************************************************//
    DataMod.ReleaseCursor(qryFATIRS);
    DataMod.ReleaseCursor(qryURUNHAR);
//****************************************************************************//
  end;
end;


function TDEKONT_AUT.KasaMuhtelifKopyala(ID, SID: String): Boolean;
var
  qryKASAHAR_MAS,qryKASAHAR : TIB_Cursor;
  TUTAR_VPB,TUTAR,DOVKUR : Currency;
  i : Byte;
begin
  Result := False;
//****************************************************************************//
  for i := 0 to glb_TAK_DOV_LIST.Count -1 do
  begin
    DOVKUR := DataMod.Get_Doviz_Kur(glb_TAK_DOV_LIST[i],DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
    if DOVKUR=0 Then
    begin
      exit;
    end
  end;
//****************************************************************************//
  try
    try
      frmKASA_MUHTELIF.DataSet_Open(0,0,0);
//****************************************************************************//
      DataMod.CreateCursor(qryKASAHAR_MAS,nil,False,DataMod.dbaMain);
      DataMod.CreateCursor(qryKASAHAR,nil,False,DataMod.dbaMain);
//****************************************************************************//
      with qryKASAHAR_MAS do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM KASAHAR WHERE ISLEM_TIP = 5 AND KASAHAR_ID = '+ID+' AND KASAHAR_SID ='+SID);
        Open;
      end;
//****************************************************************************//
      if qryKASAHAR_MAS.RecordCount = 0 then
      begin
        Application.MessageBox('Kopyalamak istediðiniz kayýt sistemde bulunamadý.','Dikkat',MB_ICONWARNING);
        exit;
      end;
//****************************************************************************//
      with qryKASAHAR do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM KASAHAR WHERE ISLEM_TIP = 5 AND BELGE_ID = '+ID+' AND BELGE_SID ='+SID+' ORDER BY KASAHAR_ID');
        Open;
      end;
//****************************************************************************//
      frmKASA_MUHTELIF.qryKASAHAR_MAS.DisableControls;
      frmKASA_MUHTELIF.qryKASAHAR.DisableControls;
//****************************************************************************//
      with frmKASA_MUHTELIF.qryKASAHAR_MAS do
      begin
        FieldByName('TIP').AsString := qryKASAHAR_MAS.FieldByName('TIP').AsString;
        FieldByName('KASA_KOD').AsString := qryKASAHAR_MAS.FieldByName('KASA_KOD').AsString;
        frmKASA_MUHTELIF.txtKASA_KODExit(Self);
        FieldByName('PROJE_KOD').AsString := qryKASAHAR_MAS.FieldByName('PROJE_KOD').AsString;
        FieldByName('PLASIYER_KOD').AsString := qryKASAHAR_MAS.FieldByName('PLASIYER_KOD').AsString;
        FieldByName('ACIKLAMA').AsString := qryKASAHAR_MAS.FieldByName('ACIKLAMA').AsString;
        FieldByName('YEVMIYE_ACK').AsString := qryKASAHAR_MAS.FieldByName('YEVMIYE_ACK').AsString;
        FieldByName('DOVKOD').AsString := qryKASAHAR_MAS.FieldByName('DOVKOD').AsString;
        FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(FieldByName('DOVKOD').AsString,DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
        FieldByName('MASRAF_MERK').AsString := qryKASAHAR_MAS.FieldByName('MASRAF_MERK').AsString;
        FieldByName('KOD2').AsString := qryKASAHAR_MAS.FieldByName('KOD2').AsString;
        FieldByName('KOD3').AsString := qryKASAHAR_MAS.FieldByName('KOD3').AsString;
        FieldByName('KOD4').AsString := qryKASAHAR_MAS.FieldByName('KOD4').AsString;
      end;
//****************************************************************************//
      frmKASA_MUHTELIF.pcKASAHAR.ActivePage := frmKASA_MUHTELIF.tabDETAY;
      qryKASAHAR.First;
      TUTAR := 0;
      TUTAR_VPB := 0;
      while not qryKASAHAR.Eof do
      begin
        with frmKASA_MUHTELIF.qryKASAHAR do
        begin
          Append;
          FieldByName('MC').AsString := qryKASAHAR.FieldByName('MC').AsString;
          FieldByName('KARSIKOD').AsString := qryKASAHAR.FieldByName('KARSIKOD').AsString;
          frmKASA_MUHTELIF.txtKARSI_KOD.Text := qryKASAHAR.FieldByName('KARSIKOD').AsString;
          frmKASA_MUHTELIF.txtKARSI_KODExit(Self);
          FieldByName('DOVKOD').AsString := qryKASAHAR.FieldByName('DOVKOD').AsString;
          FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(FieldByName('DOVKOD').AsString,DataMod.GET_SERVER_DATE,glb_SATISKUR,0);
          FieldByName('TUTAR').AsCurrency := qryKASAHAR.FieldByName('TUTAR').AsCurrency;
          FieldByName('ACIKLAMA').AsString := qryKASAHAR.FieldByName('ACIKLAMA').AsString;
          FieldByName('YEVMIYE_ACK').AsString := qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString;
          FieldByName('TUTAR_VPB').AsCurrency := FieldByName('TUTAR').AsCurrency * FieldByName('DOVKUR').AsCurrency;
          TUTAR_VPB := TUTAR_VPB + FieldByName('TUTAR_VPB').AsCurrency;
          FieldByName('KASADEGER').AsCurrency := FieldByName('TUTAR_VPB').AsCurrency / qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency;
          TUTAR := TUTAR + FieldByName('KASADEGER').AsCurrency;
          frmKASA_MUHTELIF.btnKAYDETClick(Self);
        end;
        qryKASAHAR.Next;
      end;

      with frmKASA_MUHTELIF.qryKASAHAR_MAS do
      begin
        FieldByName('TUTAR').AsCurrency := TUTAR;
        FieldByName('TUTAR_VPB').AsCurrency := TUTAR_VPB;
      end;

      Application.ProcessMessages;
//****************************************************************************//
      Result := True;
    except
      Result := False;
    end;
  finally
//****************************************************************************//
    DataMod.ReleaseCursor(qryKASAHAR_MAS);
    DataMod.ReleaseCursor(qryKASAHAR);
//****************************************************************************//
    frmKASA_MUHTELIF.qryKASAHAR_MAS.EnableControls;
    frmKASA_MUHTELIF.qryKASAHAR.EnableControls;
//****************************************************************************//
  end;
end;

end.
