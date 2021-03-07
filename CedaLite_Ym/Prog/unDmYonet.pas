unit unDmYonet;

interface

uses
  SysUtils, Classes, IB_Process, IB_Script, IB_Components, Forms, Windows,IB_Session,Dialogs,
  IBODataset ;

type
  TDmYonet = class(TDataModule)
    ScriptExecutive: TIB_Script;
    dbaCreate: TIB_Connection;
    qryHedef1: TIB_Query;
    Trn_Scrt: TIBOTransaction;
//****************************************************************************//
  function CreateTermFile(Server:Boolean;ServerName,DbName,UserName,Password: String): Boolean;
  function ExecuteScript(ScriptFile: String): Boolean;

  function CopyAnlikGelirTabToTerm:Boolean;
  function CopyBelgeTurToTerm:Boolean;
  function CopyBelgeYazToTerm:Boolean;
  function CopyCariGrupToTerm:Boolean;
  function CopyCariGrupUyeToTerm:Boolean;
  function CopyCariToTerm:Boolean;
  function CopyCariDovToTerm:Boolean;
  function CopyDepoToTerm:Boolean;
  function CopyDepoUrunToTerm:Boolean;
  function CopyFatParamsToTerm:Boolean;
  function CopyDovKartToTerm:Boolean;
  function CopyOlcuTipToTerm:Boolean;
  function CopyOlcuBirToTerm:Boolean;
  function CopyUrunToTerm:Boolean;
  function CopyMasrafToTerm:Boolean;
  function CopyKasaToTerm:Boolean;
  function CopyProjeToTerm:Boolean;
  function CopyPlasiyerToTerm:Boolean;
  function CopyParametersToTerm:Boolean;
  function CopyRapKodParamsToTerm:Boolean;
  function CopySayaclarToTerm:Boolean;
  function CopySayaclarNuToTerm: Boolean;
    
  function CopyUrunGrupToTerm:Boolean;
  function CopyUrunGrupUyeToTerm:Boolean;
  function CopyUrunCariFiyToTerm:Boolean;
  function CopyUrunCGrupFiyToTerm:Boolean;
  function CopyRapKodToTerm:Boolean;
  function CopyPaketToTerm: Boolean;
  function CopyPaket_DToTerm: Boolean;
  function CopyCariSevkToTerm: Boolean;
  function CopyUrunTedarikToTerm: Boolean;


  function CopyAracToTerm: Boolean;
  function CopyAracRuhsatToTerm: Boolean;



  function CopyPersonelToTerm: Boolean;
  function CopySoforToTerm: Boolean;
  function CopyBayiToTerm: Boolean;
  function CopyMarkaTipToTerm: Boolean;
  function CopyMarkaToTerm: Boolean;
  function CopySigortaToTerm: Boolean;
  function CopyArizaTipToTerm: Boolean;
  function CopyGelisNedenTipToTerm: Boolean;
  function CopySrvAracToTerm: Boolean;
  function CopyEsyaToTerm: Boolean;

  function Antrep: Boolean;
////////////////////////////////////////////////////////////////////////////////
  function CopyCariDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection):Boolean;

  function CopyCariDovDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection;CnHedef:TIB_Connection):Boolean;
  function CopyDepoUrunDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection):Boolean;
  function CopyMasrafDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection):Boolean;
  function CopyKasaDevToTerm(ScriptObj: TIB_Script; Cn: TIB_Connection): Boolean;

  function CopyProjeDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection):Boolean;
  function CopyPlasiyerDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection):Boolean;
  function CopyUrunDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection):Boolean;

  function CopyAracDevToTerm(ScriptObj: TIB_Script; Cn: TIB_Connection): Boolean;
  function CopyPersonelDevToTerm(ScriptObj: TIB_Script; Cn: TIB_Connection): Boolean;

  function CopyCariMuhfisDevToTerm(ScriptObj: TIB_Script;  Cn: TIB_Connection): Boolean;
////////////////////////////////////////////////////////////////////////////////
///
  function UpdateTablesSetSifir(ScriptObj:TIB_Script;Cari,Urun,Masraf,Kasa,Proje,Plasiyer,Arac,Personel:Boolean): Boolean;
  function PathDegistir(const DosyaAdi:String):String;
    procedure ScriptExecutiveError(Sender: TObject; const ERRCODE: Integer;
      ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Integer; SQLMessage,
      SQL: TStringList; var RaiseException: Boolean);


  function GEN_AYARLA(ScriptObj:TIB_Script;Qry:TIB_Query): Boolean;
  function Sirali_Calistir(ScriptObj: TIB_Script; Cn: TIB_Connection; SQLInsertLst: TStringList): Boolean;

//****************************************************************************//
  private



    { Private declarations }
  public
  Donem_Bas:String;
  Donem_Son:String;

    { Public declarations }
  end;

var
  DmYonet: TDmYonet;

implementation

uses unDataMod,unFunc, Math, ufrmBakiyeDevret;

{$R *.dfm}

function TDmYonet.CreateTermFile(Server:Boolean;ServerName,DbName,UserName,Password: String): Boolean;
begin
  try
    if Server then
       DataMod.AssignConnProps(dbaCreate,True,ServerName,DbName,UserName,Password)
    else
       DataMod.AssignConnProps(dbaCreate,False,ServerName,DbName,UserName,Password);

    dbaCreate.Createdatabase;
  except
    Result := False;
    exit;
  end;
  Result := True;
end;

function TDmYonet.ExecuteScript(ScriptFile: String): Boolean;
var
  DbScript:TStringList;
  ScriptPath : String;
  f: file of Byte;
  size: Longint;
begin
  ScriptPath := glb_SCRIPTS_DIR + ScriptFile;
  if not FileExists(ScriptPath) then
  begin
    Application.MessageBox(PChar('Script dosyasý '+glb_SCRIPTS_DIR+' dizininde bulunamadý.Lütfen '+ScriptFile+' dosyasýnýn yerini kontrol ediniz.'),'Dikkat',MB_ICONWARNING);
    Result := False;
    exit;
  end;
  AssignFile(f, ScriptPath);
//****************************************************************************//
  try
    Reset(f);
  except
    on EInOutError do
    begin
      Application.MessageBox(PChar('Script dosyasý açýlamadý.Dosya bozuk olabilir.Lütfen '+ScriptFile+' dosyasýný kontrol ediniz.'),'Dikkat',MB_ICONWARNING);
      Result := False;
      exit;
    end;
  end;
//****************************************************************************//
  size := FileSize(f);
  if size = 0 then
  begin
    CloseFile(f);
    Application.MessageBox('Script dosyasýnýn içi boþ.','Dikkat',MB_ICONWARNING);
    Result := False;
    exit;
  end
  else
  begin
    CloseFile(f);
    DBScript := TStringList.Create;
    DBScript.LoadFromFile(ScriptPath);
    if Length(Trim(DBScript.Text)) = 0 then
    begin
      Application.MessageBox('Script dosyasýnýn içi boþ.','Dikkat',MB_ICONWARNING);
      Result := False;
      exit;
    end;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(DbScript);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(DbScript);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Scriptin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;


function TDmYonet.CopyAnlikGelirTabToTerm:Boolean;
var
  qryCopyBelgeYaz : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyBelgeYaz,nil,False,DataMod.dbaMain);
  with qryCopyBelgeYaz do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT HESAP_KOD,KARSI_HESAP_KOD,ORAN FROM ANLIK_GELIR_TAB ORDER BY HESAP_KOD');
    Open;
  end;
  if (qryCopyBelgeYaz.Eof and qryCopyBelgeYaz.Bof) then
  begin
    Result := True;
    Application.MessageBox('ANLIK_GELIR_TAB tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyBelgeYaz.First;
  while not qryCopyBelgeYaz.Eof do
  begin
    SQLInsert := 'INSERT INTO ANLIK_GELIR_TAB (HESAP_KOD,KARSI_HESAP_KOD,ORAN) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeYaz.FieldByName('HESAP_KOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeYaz.FieldByName('KARSI_HESAP_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyBelgeYaz.FieldByName('ORAN').AsString+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyBelgeYaz.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  try
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Anlýk Gelir Tab scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyBelgeTurToTerm:Boolean;
var
  qryCopyBelgeTur : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyBelgeTur,nil,False,DataMod.dbaMain);
  with qryCopyBelgeTur do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT BELGE_TUR,ADI,BELGE_KOD,REFERANS_TABLO FROM BELGETUR ORDER BY BELGE_TUR');
    Open;
  end;
  if (qryCopyBelgeTur.Eof and qryCopyBelgeTur.Bof) then
  begin
    Result := True;
    Application.MessageBox('BELGETUR tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyBelgeTur.First;
  while not qryCopyBelgeTur.Eof do
  begin
    SQLInsert := 'INSERT INTO BELGETUR (BELGE_TUR,ADI,BELGE_KOD,REFERANS_TABLO) VALUES (';
    SQLInsert := SQLInsert + qryCopyBelgeTur.FieldByName('BELGE_TUR').AsString+',';
//****************************************************************************//
    if qryCopyBelgeTur.FieldByName('ADI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeTur.FieldByName('ADI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyBelgeTur.FieldByName('BELGE_KOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeTur.FieldByName('BELGE_KOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyBelgeTur.FieldByName('REFERANS_TABLO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeTur.FieldByName('REFERANS_TABLO').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyBelgeTur.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('BELGETUR scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.PathDegistir(const DosyaAdi:String):String;
var
  OrgFileName,CopyFileName,b,FileName: string;
  a : integer;
begin
  Result := '';
  OrgFileName := DosyaAdi;
  CopyFileName := OrgFileName;
  while Pos('\', CopyFileName) > 0 do
  begin
    a := Pos('\', CopyFileName);
    CopyFileName[Pos('\', CopyFileName)] := '0';
  end;
  b := copy(OrgFileName,1,a);
  FileName := copy(OrgFileName,a+1,length(OrgFileName)-a);
  Result := b+'2007\'+FileName;
end;

procedure TDmYonet.ScriptExecutiveError(Sender: TObject; const ERRCODE: Integer;
  ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Integer; SQLMessage,
  SQL: TStringList; var RaiseException: Boolean);
begin
//     RaiseException:=True;  //hata varsa çýkartýr iþlemi keser
//     RaiseException:=False; //hata varsa görmezden gelir
end;

function TDmYonet.CopyBelgeYazToTerm:Boolean;
var
  qryCopyBelgeYaz : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyBelgeYaz,nil,False,DataMod.dbaMain);
  with qryCopyBelgeYaz do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT BELGE_TUR,SIRA_NO,SUBE_ID,DOSYA_PATH,ACIKLAMA FROM BELGE_YAZ ORDER BY BELGE_TUR,SIRA_NO');
    Open;
  end;
  if (qryCopyBelgeYaz.Eof and qryCopyBelgeYaz.Bof) then
  begin
    Result := True;
    Application.MessageBox('BELGE_YAZ tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyBelgeYaz.First;
  while not qryCopyBelgeYaz.Eof do
  begin
    SQLInsert := 'INSERT INTO BELGE_YAZ (BELGE_TUR,SIRA_NO,SUBE_ID,DOSYA_PATH,ACIKLAMA) VALUES (';
    SQLInsert := SQLInsert + qryCopyBelgeYaz.FieldByName('BELGE_TUR').AsString+',';
    SQLInsert := SQLInsert + qryCopyBelgeYaz.FieldByName('SIRA_NO').AsString+',';
    SQLInsert := SQLInsert + qryCopyBelgeYaz.FieldByName('SUBE_ID').AsString+',';
//****************************************************************************//
    if qryCopyBelgeYaz.FieldByName('DOSYA_PATH').IsNotNull then
//       SQLInsert := SQLInsert + SQL_Katar(PathDegistir(qryCopyBelgeYaz.FieldByName('DOSYA_PATH').AsString))+','
       SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeYaz.FieldByName('DOSYA_PATH').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyBelgeYaz.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeYaz.FieldByName('ACIKLAMA').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyBelgeYaz.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('BelgeYaz scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyCariGrupToTerm: Boolean;
var
  qryCopyCariGrup : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyCariGrup,nil,False,DataMod.dbaMain);
  with qryCopyCariGrup do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT CARI_GRUP_KOD,CARI_GRUP_SID,CGADI,CGACK,TIP FROM CARI_GRUP ORDER BY CARI_GRUP_KOD');
    Open;
  end;
  if (qryCopyCariGrup.Eof and qryCopyCariGrup.Bof) then
  begin
    Result := False;
    Application.MessageBox('CARI_GRUP tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyCariGrup.First;
  while not qryCopyCariGrup.Eof do
  begin
    SQLInsert := 'INSERT INTO CARI_GRUP (CARI_GRUP_KOD,CARI_GRUP_SID,CGADI,CGACK,TIP'
                +') VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyCariGrup.FieldByName('CARI_GRUP_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyCariGrup.FieldByName('CARI_GRUP_SID').AsString+',';
//****************************************************************************//
    if qryCopyCariGrup.FieldByName('CGADI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCariGrup.FieldByName('CGADI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCariGrup.FieldByName('CGACK').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCariGrup.FieldByName('CGACK').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    SQLInsert := SQLInsert + qryCopyCariGrup.FieldByName('TIP').AsString+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyCariGrup.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Cari grup scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;








function TDmYonet.CopyCariSevkToTerm: Boolean;
var
  qryCopySevk : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopySevk,nil,False,DataMod.dbaMain);
  with qryCopySevk do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT CARI_SEVK_KOD,CARI_KOD,CARI_SID,ADRES_1,ADRES_2 FROM CARI_SEVKAD ORDER BY CARI_SEVK_KOD');
    Open;
  end;
  if (qryCopySevk.Eof and qryCopySevk.Bof) then
  begin
    Result := True;
    Application.MessageBox('CARI_SEVKAD tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopySevk.First;
  while not qryCopySevk.Eof do
  begin
    SQLInsert := 'INSERT INTO CARI_SEVKAD (CARI_SEVK_KOD,CARI_KOD,CARI_SID,ADRES_1,ADRES_2'
                +') VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopySevk.FieldByName('CARI_SEVK_KOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopySevk.FieldByName('CARI_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopySevk.FieldByName('CARI_SID').AsString+',';
//****************************************************************************//
    if qryCopySevk.FieldByName('ADRES_1').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopySevk.FieldByName('ADRES_1').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopySevk.FieldByName('ADRES_2').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopySevk.FieldByName('ADRES_2').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopySevk.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('CARI_SEVKAD scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;






function TDmYonet.CopyCariGrupUyeToTerm: Boolean;
var
  qryCopyCariGrupUye : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyCariGrupUye,nil,False,DataMod.dbaMain);
  with qryCopyCariGrupUye do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT CARI_GRUP_KOD,CARI_KOD,VARSAY FROM CARI_GRUP_UYE ORDER BY CARI_GRUP_KOD,CARI_KOD');
    Open;
  end;
  if (qryCopyCariGrupUye.Eof and qryCopyCariGrupUye.Bof) then
  begin
    Result := False;
    Application.MessageBox('CARI_GRUP_UYE tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyCariGrupUye.First;
  while not qryCopyCariGrupUye.Eof do
  begin
    SQLInsert := 'INSERT INTO CARI_GRUP_UYE (CARI_GRUP_KOD,CARI_KOD,VARSAY'
                +') VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyCariGrupUye.FieldByName('CARI_GRUP_KOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyCariGrupUye.FieldByName('CARI_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyCariGrupUye.FieldByName('VARSAY').AsString+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyCariGrupUye.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Cari grup uye scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyCariToTerm: Boolean;
var
  qryCopyCari : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyCari,nil,False,DataMod.dbaMain);
  with qryCopyCari do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT');
    //null fields
    SQL.Add('CARI_AD,YETKISI,VERDAIRE,VERNO,ADRES_1,ADRES_2,ILCE,SEHIR,POSTA_KOD,TEL_NO_1,TEL_NO_2,FAX,E_MAIL,WEB_ADDR,NOTES,ULKE,');
    //not null fields
    SQL.Add('CARI_KOD,CARI_SID,TIP,YURTDISI,ISLEMTIP,MUHTELIF');
    SQL.Add('FROM CARI');
    SQL.Add('ORDER BY CARI_KOD');
    Open;
  end;
  if (qryCopyCari.Eof and qryCopyCari.Bof) then
  begin
    Result := True;
    Application.MessageBox('CARI tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyCari.First;
  while not qryCopyCari.Eof do
  begin
    SQLInsert := 'INSERT INTO CARI (CARI_KOD,CARI_SID,CARI_AD,'
                +'YETKISI,VERDAIRE,VERNO,ADRES_1,ADRES_2,ILCE,SEHIR,'
                +'POSTA_KOD,TIP,TEL_NO_1,TEL_NO_2,FAX,E_MAIL,WEB_ADDR,'
                +'NOTES,ULKE,YURTDISI,ISLEMTIP,MUHTELIF) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('CARI_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyCari.FieldByName('CARI_SID').AsString+',';
//****************************************************************************//
    {lite
    if qryCopyCari.FieldByName('MUHASKOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('MUHASKOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
       }
//****************************************************************************//
    if qryCopyCari.FieldByName('CARI_AD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('CARI_AD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('YETKISI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('YETKISI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('VERDAIRE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('VERDAIRE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('VERNO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('VERNO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('ADRES_1').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('ADRES_1').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('ADRES_2').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('ADRES_2').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('ILCE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('ILCE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('SEHIR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('SEHIR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('POSTA_KOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('POSTA_KOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    SQLInsert := SQLInsert + qryCopyCari.FieldByName('TIP').AsString+',';
//****************************************************************************//
    if qryCopyCari.FieldByName('TEL_NO_1').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('TEL_NO_1').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('TEL_NO_2').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('TEL_NO_2').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('FAX').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('FAX').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('E_MAIL').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('E_MAIL').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('WEB_ADDR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('WEB_ADDR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('NOTES').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('NOTES').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyCari.FieldByName('ULKE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyCari.FieldByName('ULKE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    SQLInsert := SQLInsert + qryCopyCari.FieldByName('YURTDISI').AsString+',';
    SQLInsert := SQLInsert + qryCopyCari.FieldByName('ISLEMTIP').AsString+',';
    SQLInsert := SQLInsert + qryCopyCari.FieldByName('MUHTELIF').AsString+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyCari.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Cari scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyDepoToTerm: Boolean;
var
  qryCopyDepo : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyDepo,nil,False,DataMod.dbaMain);
  with qryCopyDepo do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT DEPO_KOD,DEPO_SID,ADI,ADRESI_1,ADRESI_2,SEHIR,ILCE,POSTAKOD,TEL_1,TEL_2,FAX FROM DEPO ORDER BY DEPO_KOD');
    Open;
  end;
  if (qryCopyDepo.Eof and qryCopyDepo.Bof) then
  begin
    Result := True;
    Application.MessageBox('DEPO tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyDepo.First;
  while not qryCopyDepo.Eof do
  begin
    SQLInsert := 'INSERT INTO DEPO (DEPO_KOD,DEPO_SID,ADI,ADRESI_1,ADRESI_2,SEHIR,ILCE,POSTAKOD,TEL_1,TEL_2,FAX) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyDepo.FieldByName('DEPO_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyDepo.FieldByName('DEPO_SID').AsString+',';
//****************************************************************************//
    if qryCopyDepo.FieldByName('ADI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyDepo.FieldByName('ADI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyDepo.FieldByName('ADRESI_1').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyDepo.FieldByName('ADRESI_1').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyDepo.FieldByName('ADRESI_2').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyDepo.FieldByName('ADRESI_2').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyDepo.FieldByName('SEHIR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyDepo.FieldByName('SEHIR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyDepo.FieldByName('ILCE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyDepo.FieldByName('ILCE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyDepo.FieldByName('POSTAKOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyDepo.FieldByName('POSTAKOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyDepo.FieldByName('TEL_1').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyDepo.FieldByName('TEL_1').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyDepo.FieldByName('TEL_2').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyDepo.FieldByName('TEL_2').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyDepo.FieldByName('FAX').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyDepo.FieldByName('FAX').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';

//****************************************************************************//


    SQLInsertLst.Add(SQLInsert);
    qryCopyDepo.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;

  except

    Result := False;
    Application.MessageBox('Depo scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyDepoUrunToTerm:Boolean;
var
  qryCopyBelgeYaz : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyBelgeYaz,nil,False,DataMod.dbaMain);
  with qryCopyBelgeYaz do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT DEPO_KOD,URUN_KOD FROM DEPOURUN ORDER BY DEPO_KOD,URUN_KOD');
    Open;
  end;
  if (qryCopyBelgeYaz.Eof and qryCopyBelgeYaz.Bof) then
  begin
    Result := True;
    Application.MessageBox('DEPOURUN tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyBelgeYaz.First;
  while not qryCopyBelgeYaz.Eof do
  begin
    SQLInsert := 'INSERT INTO DEPOURUN (DEPO_KOD,URUN_KOD) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeYaz.FieldByName('DEPO_KOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeYaz.FieldByName('URUN_KOD').AsString)+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyBelgeYaz.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('DepoUrun scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;


function TDmYonet.CopyDepoUrunDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection):Boolean;
var
  qryCopyBelgeYaz : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  dvr_total,SONUC : Currency;
begin
  DataMod.CreateCursor(qryCopyBelgeYaz,nil,False,Cn);
  with qryCopyBelgeYaz do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT DEPO_KOD,URUN_KOD,BORC,ALACAK,BORC_VPB,ALACAK_VPB,MIKTAR_BORC,MIKTAR_ALACAK');
    SQL.Add('DEV_BORC,DEV_ALACAK,DEV_BORC_VPB,DEV_ALACAK_VPB,DEV_MIKTAR_BORC,DEV_MIKTAR_ALACAK');
    SQL.Add('FROM DEPOURUN ORDER BY DEPO_KOD,URUN_KOD');
    Open;
  end;
  if (qryCopyBelgeYaz.Eof and qryCopyBelgeYaz.Bof) then
  begin
    Result := True;
    Application.MessageBox('DEPOURUN tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyBelgeYaz.First;
  while not qryCopyBelgeYaz.Eof do
  begin
    SQLInsert := 'UPDATE DEPOURUN SET ';
//****************************************************************************//
    if (qryCopyBelgeYaz.FieldByName('BORC').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_BORC').AsCurrency)
    > (qryCopyBelgeYaz.FieldByName('ALACAK').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyBelgeYaz.FieldByName('BORC').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_BORC').AsCurrency)
                 - (qryCopyBelgeYaz.FieldByName('ALACAK').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_ALACAK').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEV_BORC=0,';
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEV_BORC='+SQL_Para(SONUC)+',';
      end;
      SQLInsert := SQLInsert+'DEV_ALACAK=0,';
    end
    else
    if (qryCopyBelgeYaz.FieldByName('BORC').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_BORC').AsCurrency)
    < (qryCopyBelgeYaz.FieldByName('ALACAK').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyBelgeYaz.FieldByName('ALACAK').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_ALACAK').AsCurrency)
                 - (qryCopyBelgeYaz.FieldByName('BORC').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_BORC').AsCurrency);
      SQLInsert := SQLInsert+'DEV_BORC=0,';
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEV_ALACAK=0,';
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEV_ALACAK='+SQL_Para(SONUC)+',';
      end;
    end
    else
    if (qryCopyBelgeYaz.FieldByName('BORC').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_BORC').AsCurrency)
    = (qryCopyBelgeYaz.FieldByName('ALACAK').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_ALACAK').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEV_BORC=0,';
      SQLInsert := SQLInsert+'DEV_ALACAK=0,';
    end;
//****************************************************************************//
    if (qryCopyBelgeYaz.FieldByName('BORC_VPB').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_BORC_VPB').AsCurrency)
    >  (qryCopyBelgeYaz.FieldByName('ALACAK_VPB').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyBelgeYaz.FieldByName('BORC_VPB').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_BORC_VPB').AsCurrency)
                 - (qryCopyBelgeYaz.FieldByName('ALACAK_VPB').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_ALACAK_VPB').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEV_BORC_VPB=0,';
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEV_BORC_VPB='+SQL_Para(SONUC)+',';
      end;
      SQLInsert := SQLInsert+'DEV_ALACAK_VPB=0,';
    end
    else

    if (qryCopyBelgeYaz.FieldByName('BORC_VPB').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_BORC_VPB').AsCurrency)
    < (qryCopyBelgeYaz.FieldByName('ALACAK_VPB').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyBelgeYaz.FieldByName('ALACAK_VPB').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_ALACAK_VPB').AsCurrency)
                 - (qryCopyBelgeYaz.FieldByName('BORC_VPB').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_BORC_VPB').AsCurrency);
      SQLInsert := SQLInsert+'BORC_VPB=0,';
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'ALACAK_VPB=0,';
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'ALACAK_VPB='+SQL_Para(SONUC)+',';
      end;
    end
    else
    if (qryCopyBelgeYaz.FieldByName('BORC_VPB').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_BORC_VPB').AsCurrency)
    = (qryCopyBelgeYaz.FieldByName('ALACAK_VPB').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_ALACAK_VPB').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEV_BORC_VPB=0,';
      SQLInsert := SQLInsert+'DEV_ALACAK_VPB=0,';
    end;
//****************************************************************************//
    if (qryCopyBelgeYaz.FieldByName('MIKTAR_BORC').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_MIKTAR_BORC').AsCurrency)
    > (qryCopyBelgeYaz.FieldByName('MIKTAR_ALACAK').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_MIKTAR_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyBelgeYaz.FieldByName('MIKTAR_BORC').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_MIKTAR_BORC').AsCurrency)
                 - (qryCopyBelgeYaz.FieldByName('MIKTAR_ALACAK').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_MIKTAR_ALACAK').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEV_MIKTAR_BORC=0,';
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEV_MIKTAR_BORC='+SQL_Para(SONUC)+',';
      end;
      SQLInsert := SQLInsert+'DEV_MIKTAR_ALACAK=0';
    end
    else
    if (qryCopyBelgeYaz.FieldByName('MIKTAR_BORC').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_MIKTAR_BORC').AsCurrency)
    < (qryCopyBelgeYaz.FieldByName('MIKTAR_ALACAK').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_MIKTAR_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyBelgeYaz.FieldByName('MIKTAR_ALACAK').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_MIKTAR_ALACAK').AsCurrency)
                 - (qryCopyBelgeYaz.FieldByName('MIKTAR_BORC').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_MIKTAR_BORC').AsCurrency);
      SQLInsert := SQLInsert+'DEV_MIKTAR_BORC=0,';
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEV_MIKTAR_ALACAK=0';
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEV_MIKTAR_ALACAK='+SQL_Para(SONUC);
      end;
    end
    else
    if (qryCopyBelgeYaz.FieldByName('MIKTAR_BORC').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_MIKTAR_BORC').AsCurrency)
    = (qryCopyBelgeYaz.FieldByName('MIKTAR_ALACAK').AsCurrency+qryCopyBelgeYaz.FieldByName('DEV_MIKTAR_ALACAK').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEV_MIKTAR_BORC=0,';
      SQLInsert := SQLInsert+'DEV_MIKTAR_ALACAK=0';
    end;
//****************************************************************************//
    SQLInsert := SQLInsert + ' WHERE DEPO_KOD='+SQL_Katar(qryCopyBelgeYaz.FieldByName('DEPO_KOD').AsString);
    SQLInsert := SQLInsert + ' AND URUN_KOD='+SQL_Katar(qryCopyBelgeYaz.FieldByName('URUN_KOD').AsString)+';';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyBelgeYaz.Next;
  end;
//****************************************************************************//
  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('DepoUrunDev scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyFatParamsToTerm: Boolean;
var
  qryFatParams : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryFatParams,nil,False,DataMod.dbaMain);
  with qryFatParams do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT FAT_PARAMS_ID,EK_ACK_KUL,');
    SQL.Add('ACK_30K_1_KUL,ACK_30K_2_KUL,ACK_30K_3_KUL,');
    SQL.Add('ACK_50K_1_KUL,ACK_50K_2_KUL,ACK_50K_3_KUL,ACK_50K_4_KUL,ACK_50K_5_KUL,');
    SQL.Add('ACK_100K_1_KUL,ACK_100K_2_KUL,ACK_100K_3_KUL,ACK_100K_4_KUL,ACK_100K_5_KUL,');
    SQL.Add('KAL_BAZ_ISK,');
    SQL.Add('ACK_30K_1_CAP,ACK_30K_2_CAP,ACK_30K_3_CAP,');
    SQL.Add('ACK_50K_1_CAP,ACK_50K_2_CAP,ACK_50K_3_CAP,ACK_50K_4_CAP,ACK_50K_5_CAP');
    SQL.Add('ACK_100K_1_CAP,ACK_100K_2_CAP,ACK_100K_3_CAP,ACK_100K_4_CAP,ACK_100K_5_CAP');
    SQL.Add('FROM FAT_PARAMS');
    SQL.Add('ORDER BY FAT_PARAMS_ID');
    Open;
  end;
  if (qryFatParams.Eof and qryFatParams.Bof) then
  begin
    Result := True;
    Application.MessageBox('FAT_PARAMS tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryFatParams.First;
  while not qryFatParams.Eof do
  begin
    SQLInsert := 'INSERT INTO FAT_PARAMS (FAT_PARAMS_ID,EK_ACK_KUL,'
                +'ACK_30K_1_KUL,ACK_30K_2_KUL,ACK_30K_3_KUL,'
                +'ACK_50K_1_KUL,ACK_50K_2_KUL,ACK_50K_3_KUL,ACK_50K_4_KUL,ACK_50K_5_KUL,'
                +'ACK_100K_1_KUL,ACK_100K_2_KUL,ACK_100K_3_KUL,ACK_100K_4_KUL,ACK_100K_5_KUL,'
                +'KAL_BAZ_ISK,'
                +'ACK_30K_1_CAP,ACK_30K_2_CAP,ACK_30K_3_CAP,'
                +'ACK_50K_1_CAP,ACK_50K_2_CAP,ACK_50K_3_CAP,ACK_50K_4_CAP,ACK_50K_5_CAP,'
                +'ACK_100K_1_CAP,ACK_100K_2_CAP,ACK_100K_3_CAP,ACK_100K_4_CAP,ACK_100K_5_CAP'
                +') VALUES (';
//****************************************************************************//
    SQLInsert := SQLInsert + qryFatParams.FieldByName('FAT_PARAMS_ID').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('EK_ACK_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_30K_1_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_30K_2_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_30K_3_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_50K_1_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_50K_2_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_50K_3_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_50K_4_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_50K_5_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_100K_1_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_100K_2_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_100K_3_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_100K_4_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('ACK_100K_5_KUL').AsString+',';
    SQLInsert := SQLInsert + qryFatParams.FieldByName('KAL_BAZ_ISK').AsString+',';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_30K_1_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_30K_1_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_30K_2_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_30K_2_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_30K_3_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_30K_3_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_50K_1_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_50K_1_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_50K_2_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_50K_2_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_50K_3_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_50K_3_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_50K_4_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_50K_4_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_50K_5_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_50K_5_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_100K_1_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_100K_1_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_100K_2_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_100K_2_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_100K_3_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_100K_3_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_100K_4_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_100K_4_CAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryFatParams.FieldByName('ACK_100K_5_CAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryFatParams.FieldByName('ACK_100K_5_CAP').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryFatParams.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Fat Params scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyDovKartToTerm: Boolean;
var
  qryCopyDovKart : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyDovKart,nil,False,DataMod.dbaMain);
  with qryCopyDovKart do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT');
    //null fields
    SQL.Add('PARITE_DEGER,');
    //not null fields
    SQL.Add('DOVKOD,ADI,TAKIP,VPB,PARITE');
    SQL.Add('FROM DOVKART');
    SQL.Add('ORDER BY DOVKOD');
    Open;
  end;
  if (qryCopyDovKart.Eof and qryCopyDovKart.Bof) then
  begin
    Result := False;
    Application.MessageBox('DOVKART tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyDovKart.First;
  while not qryCopyDovKart.Eof do
  begin
    SQLInsert := 'INSERT INTO DOVKART (DOVKOD,ADI,TAKIP,VPB,PARITE,PARITE_DEGER) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyDovKart.FieldByName('DOVKOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyDovKart.FieldByName('ADI').AsString)+',';
//****************************************************************************//
    if qryCopyDovKart.FieldByName('DOVKOD').AsString = glb_DEFCUR then
      SQLInsert := SQLInsert + '1,'
    else
      SQLInsert := SQLInsert + qryCopyDovKart.FieldByName('TAKIP').AsString+',';
//****************************************************************************//
    if qryCopyDovKart.FieldByName('DOVKOD').AsString = 'YTL' then
       SQLInsert := SQLInsert + '1,'
    else
       SQLInsert := SQLInsert + '0,';
//****************************************************************************//
    SQLInsert := SQLInsert + qryCopyDovKart.FieldByName('PARITE').AsString+',';
//****************************************************************************//
    if qryCopyDovKart.FieldByName('PARITE_DEGER').IsNotNull then
       SQLInsert := SQLInsert + FloatToStr(qryCopyDovKart.FieldByName('PARITE_DEGER').AsExtended)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
    SQLInsertLst.Add(SQLInsert);
    qryCopyDovKart.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Dovkart scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyOlcuTipToTerm: Boolean;
var
  qryCopyOlcuTip : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyOlcuTip,nil,False,DataMod.dbaMain);
  with qryCopyOlcuTip do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT OLCU_TIP,ACK FROM OLCUTIP ORDER BY OLCU_TIP');
    Open;
  end;
  if (qryCopyOlcuTip.Eof and qryCopyOlcuTip.Bof) then
  begin
    Result := False;
    Application.MessageBox('OLCUTIP tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyOlcuTip.First;
  while not qryCopyOlcuTip.Eof do
  begin
    SQLInsert := 'INSERT INTO OLCUTIP (OLCU_TIP,ACK) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyOlcuTip.FieldByName('OLCU_TIP').AsString)+',';
    if qryCopyOlcutip.FieldByName('ACK').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyOlcuTip.FieldByName('ACK').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyOlcuTip.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Ölçütip scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;


function TDmYonet.CopyOlcuBirToTerm: Boolean;
var
  qryCopyOlcuBir : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyOlcuBir,nil,False,DataMod.dbaMain);
  with qryCopyOlcuBir do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT OLCUBIRIM,OLCU_TIP,DEGERTODOM,DOMINANT FROM OLCUBIR ORDER BY OLCUBIRIM');
    Open;
  end;
  if (qryCopyOlcuBir.Eof and qryCopyOlcuBir.Bof) then
  begin
    Result := False;
    Application.MessageBox('OLCUBIR tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyOlcuBir.First;
  while not qryCopyOlcuBir.Eof do
  begin
    SQLInsert := 'INSERT INTO OLCUBIR (OLCUBIRIM,OLCU_TIP,DEGERTODOM,DOMINANT) VALUES (';
    //SQLInsert := 'INSERT INTO OLCUBIR (OLCUBIRIM,OLCU_TIP,DEGERTODOM,DOMINANT) VALUES (:OLCUBIRIM,:OLCU_TIP,:DEGERTODOM,:DOMINANT);';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyOlcuBir.FieldByName('OLCUBIRIM').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyOlcuBir.FieldByName('OLCU_TIP').AsString)+',';
    SQLInsert := SQLInsert + StringReplace(qryCopyOlcuBir.FieldByName('DEGERTODOM').AsString,',','.',[rfReplaceAll])+',';
    SQLInsert := SQLInsert + qryCopyOlcuBir.FieldByName('DOMINANT').AsString+');';

    //ParamByName('OLCUBIRIM').AsString:=
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyOlcuBir.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
   frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('OlcuBir scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyUrunToTerm: Boolean;
var
  qryCopyUrun : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  SONUC : Currency;
begin
  DataMod.CreateCursor(qryCopyUrun,nil,False,DataMod.dbaMain);
//****************************************************************************//
  with qryCopyUrun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT');
    //null fields
    SQL.Add('URUN_AD_YD,DEPOSURE,D_BARCODE,UBARCODE,ACIKLAMALAR,KDV,GTIPNO,KARMARJ,');

    //not null fields
    SQL.Add('URUN_KOD,URUN_SID,URUN_AD,TIP,OLCU_TIP,OLCUBIRIM,DEPO_KOD,DOVKOD,KDV_DAHIL,ASGARIMIK,');
    SQL.Add('AZAMIMIK,SIPMIKTAR,KOMPLEX,HIZMET,BIRIMFIY,SATISFIY,URUN_TIP');
    SQL.Add('FROM URUN');
    SQL.Add('ORDER BY URUN_KOD');
    Open;
  end;
//****************************************************************************//
  if (qryCopyUrun.Eof and qryCopyUrun.Bof) then
  begin
    Result := True;
    Application.MessageBox('URUN tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  SQLInsertLst := TStringList.Create;
  qryCopyUrun.First;
  while not qryCopyUrun.Eof do
  begin
    SQLInsert := 'INSERT INTO URUN (URUN_AD_YD,DEPOSURE,D_BARCODE,UBARCODE,ACIKLAMALAR,KDV,GTIPNO,'
                +'KARMARJ,URUN_KOD,URUN_SID,URUN_AD,TIP,OLCU_TIP,OLCUBIRIM,DEPO_KOD,DOVKOD,'
                +'KDV_DAHIL,ASGARIMIK,AZAMIMIK,SIPMIKTAR,KOMPLEX,HIZMET,BIRIMFIY,SATISFIY,URUN_TIP) VALUES (';
//****************************************************************************//
    if qryCopyUrun.FieldByName('URUN_AD_YD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('URUN_AD_YD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyUrun.FieldByName('DEPOSURE').IsNotNull then
       SQLInsert := SQLInsert + qryCopyUrun.FieldByName('DEPOSURE').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyUrun.FieldByName('D_BARCODE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('D_BARCODE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyUrun.FieldByName('UBARCODE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('UBARCODE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyUrun.FieldByName('ACIKLAMALAR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('ACIKLAMALAR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyUrun.FieldByName('KDV').IsNotNull then
       SQLInsert := SQLInsert + qryCopyUrun.FieldByName('KDV').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyUrun.FieldByName('GTIPNO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('GTIPNO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyUrun.FieldByName('KARMARJ').IsNotNull then
       SQLInsert := SQLInsert + qryCopyUrun.FieldByName('KARMARJ').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
//****************************************************************************//
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('URUN_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyUrun.FieldByName('URUN_SID').AsString+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('URUN_AD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyUrun.FieldByName('TIP').AsString+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('OLCU_TIP').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('OLCUBIRIM').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('DEPO_KOD').AsString)+',';
//****************************************************************************//
    if qryCopyUrun.FieldByName('DOVKOD').AsString = glb_DEFCUR then
       SQLInsert := SQLInsert+SQL_Katar('YTL')+','
    else
       SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('DOVKOD').AsString)+',';
//****************************************************************************//
    SQLInsert := SQLInsert + qryCopyUrun.FieldByName('KDV_DAHIL').AsString+',';
//****************************************************************************//
    SQLInsert := SQLInsert + SQL_Para(qryCopyUrun.FieldByName('ASGARIMIK').AsCurrency)+',';
    SQLInsert := SQLInsert + SQL_Para(qryCopyUrun.FieldByName('AZAMIMIK').AsCurrency)+',';
    SQLInsert := SQLInsert + SQL_Para(qryCopyUrun.FieldByName('SIPMIKTAR').AsCurrency)+',';
//****************************************************************************//
    SQLInsert := SQLInsert + qryCopyUrun.FieldByName('KOMPLEX').AsString+',';
    SQLInsert := SQLInsert + qryCopyUrun.FieldByName('HIZMET').AsString+',';
//****************************************************************************//
    if qryCopyUrun.FieldByName('DOVKOD').AsString = glb_DEFCUR then
    begin
      if qryCopyUrun.FieldByName('BIRIMFIY').AsCurrency = 0 then
      begin
        SQLInsert := SQLInsert + '0,';
      end
      else
      begin
        if DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',qryCopyUrun.FieldByName('BIRIMFIY').AsCurrency,2,True,SONUC) then
        begin
          SQLInsert := SQLInsert + SQL_Para(SONUC)+',';
        end;
      end
    end
    else
       SQLInsert := SQLInsert + SQL_Para(qryCopyUrun.FieldByName('BIRIMFIY').AsCurrency)+',';
//****************************************************************************//
    if qryCopyUrun.FieldByName('DOVKOD').AsString = glb_DEFCUR then
    begin
      if qryCopyUrun.FieldByName('SATISFIY').AsCurrency = 0 then
      begin
        SQLInsert := SQLInsert + '0,';
      end
      else
      begin
        if DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',qryCopyUrun.FieldByName('SATISFIY').AsCurrency,2,True,SONUC) then
        begin
          SQLInsert := SQLInsert + SQL_Para(SONUC)+',';
        end;
      end;
    end
    else
      SQLInsert := SQLInsert + SQL_Para(qryCopyUrun.FieldByName('SATISFIY').AsCurrency)+',';

      SQLInsert := SQLInsert + SQL_Katar(qryCopyUrun.FieldByName('URUN_TIP').AsString)+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyUrun.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Urun scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyMasrafToTerm: Boolean;
var
  qryCopyMasraf : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyMasraf,nil,False,DataMod.dbaMain);
  with qryCopyMasraf do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT MASRAF_KOD,MASRAF_SID,ADI,ACIKLAMA,DEVIR FROM MASRAF ORDER BY MASRAF_KOD');
    Open;
  end;
  if (qryCopyMasraf.Eof and qryCopyMasraf.Bof) then
  begin
    Result := True;
    Application.MessageBox('MASRAF tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyMasraf.First;
  while not qryCopyMasraf.Eof do
  begin
    SQLInsert := 'INSERT INTO MASRAF (MASRAF_KOD,MASRAF_SID,ADI,ACIKLAMA,DEVIR) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyMasraf.FieldByName('MASRAF_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyMasraf.FieldByName('MASRAF_SID').AsString+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyMasraf.FieldByName('ADI').AsString)+',';
//****************************************************************************//
{    if qryCopyMasraf.FieldByName('MUHASKOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyMasraf.FieldByName('MUHASKOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
}
//****************************************************************************//
    if qryCopyMasraf.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyMasraf.FieldByName('ACIKLAMA').AsString)+','
    else

       SQLInsert := SQLInsert + 'NULL,';

       SQLInsert := SQLInsert + qryCopyMasraf.FieldByName('DEVIR').AsString+');';

//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyMasraf.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Masraf scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;


function TDmYonet.CopyKasaToTerm: Boolean;
var
  qryCopyKasa : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyKasa,nil,False,DataMod.dbaMain);
  with qryCopyKasa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT KASA_KOD,KASA_SID,ACIKLAMA,DOVKOD,VARSAYILAN FROM KASA ORDER BY KASA_KOD');
    Open;
  end;
  if (qryCopyKasa.Eof and qryCopyKasa.Bof) then
  begin
    Result := True;
    Application.MessageBox('KASA tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyKasa.First;
  while not qryCopyKasa.Eof do
  begin
    SQLInsert := 'INSERT INTO KASA (KASA_KOD,KASA_SID,ACIKLAMA,DOVKOD,VARSAYILAN) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyKasa.FieldByName('KASA_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyKAsa.FieldByName('KASA_SID').AsString+',';
//****************************************************************************//
    if qryCopyKasa.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyKasa.FieldByName('ACIKLAMA').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyKasa.FieldByName('DOVKOD').AsString = glb_DEFCUR then
    begin
      SQLInsert := SQLInsert + SQL_Katar('YTL')+',';
    end
    else
    begin
      SQLInsert := SQLInsert + SQL_Katar(qryCopyKasa.FieldByName('DOVKOD').AsString)+',';
    end;
//****************************************************************************//
  {Lite  if qryCopyKasa.FieldByName('MUHASKOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyKasa.FieldByName('MUHASKOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
}
//****************************************************************************//
    SQLInsert := SQLInsert + qryCopyKasa.FieldByName('VARSAYILAN').AsString+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyKasa.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Kasa scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyParametersToTerm: Boolean;
var
  qryCopyParameters : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyParameters,nil,False,DataMod.dbaMain);
  with qryCopyParameters do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SUBE_ID,MODUL_ID,PARAM_NAME,DEGER,PARAM_ACK,KODLAMA FROM PARAMETERS ORDER BY MODUL_ID,PARAM_NAME');
    Open;
  end;
  if (qryCopyParameters.Eof and qryCopyParameters.Bof) then
  begin
    Result := True;
    Application.MessageBox('PARAMETERS tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyParameters.First;
  while not qryCopyParameters.Eof do
  begin
    SQLInsert := 'INSERT INTO PARAMETERS (SUBE_ID,MODUL_ID,PARAM_NAME,KODLAMA,DEGER,PARAM_ACK) VALUES (';
    SQLInsert := SQLInsert + qryCopyParameters.FieldByName('SUBE_ID').AsString+',';
    SQLInsert := SQLInsert + qryCopyParameters.FieldByName('MODUL_ID').AsString+',';
//****************************************************************************//
    SQLInsert := SQLInsert + SQL_Katar(qryCopyParameters.FieldByName('PARAM_NAME').AsString)+',';
    SQLInsert := SQLInsert + qryCopyParameters.FieldByName('KODLAMA').AsString+',';
//****************************************************************************//
    if qryCopyParameters.FieldByName('DEGER').IsNotNull then
    begin
      if qryCopyParameters.FieldByName('PARAM_NAME').AsString = 'CALISMA_YIL' then
        SQLInsert := SQLInsert + SQL_Katar('2007')+','
      else
      if qryCopyParameters.FieldByName('PARAM_NAME').AsString = 'EN_GER_KAY_TAR' then
        SQLInsert := SQLInsert + SQL_Katar('20071231')+','
      else
      if qryCopyParameters.FieldByName('PARAM_NAME').AsString = 'YEV_NUM_SON_TAR' then
        SQLInsert := SQLInsert + SQL_Katar('20071231')+','
      else
      if qryCopyParameters.FieldByName('PARAM_NAME').AsString = 'YEV_STAR_KILIT' then
        SQLInsert := SQLInsert + SQL_Katar('1')+','
      else
      if qryCopyParameters.FieldByName('PARAM_NAME').AsString = 'LOG_ENABLE' then
        SQLInsert := SQLInsert + SQL_Katar('1')+','
      else
      if qryCopyParameters.FieldByName('PARAM_NAME').AsString = 'VPB_FIELD_PF' then
        SQLInsert := SQLInsert + SQL_Katar('#,##.00')+','
      else
      if qryCopyParameters.FieldByName('PARAM_NAME').AsString = 'DOV_KUR_PF' then
        SQLInsert := SQLInsert + SQL_Katar('#,##.0000')+','
      else
        SQLInsert := SQLInsert + SQL_Katar(qryCopyParameters.FieldByName('DEGER').AsString)+','
    end
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyParameters.FieldByName('PARAM_ACK').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyParameters.FieldByName('PARAM_ACK').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyParameters.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Parameters scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyProjeToTerm: Boolean;
var
  qryCopyProje : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyProje,nil,False,DataMod.dbaMain);
  with qryCopyProje do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PROJE_KOD,PROJE_SID,PROJE_AD,ACIKLAMA,DOVKOD,KAPANDI FROM PROJE WHERE KAPANDI = 0 ORDER BY PROJE_KOD');
    Open;
  end;
  if (qryCopyProje.Eof and qryCopyProje.Bof) then
  begin
    Result := True;
    Application.MessageBox('PROJE tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyProje.First;
  while not qryCopyProje.Eof do
  begin
    SQLInsert := 'INSERT INTO PROJE (PROJE_KOD,PROJE_SID,PROJE_AD,ACIKLAMA,DOVKOD,KAPANDI) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyProje.FieldByName('PROJE_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyProje.FieldByName('PROJE_SID').AsString+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyProje.FieldByName('PROJE_AD').AsString)+',';
//****************************************************************************//
    if qryCopyProje.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyProje.FieldByName('ACIKLAMA').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyProje.FieldByName('DOVKOD').AsString = glb_DEFCUR then
      SQLInsert := SQLInsert + SQL_Katar('YTL')+','
    else
      SQLInsert := SQLInsert + SQL_Katar(qryCopyProje.FieldByName('DOVKOD').AsString)+',';
//****************************************************************************//
    SQLInsert := SQLInsert + qryCopyProje.FieldByName('KAPANDI').AsString+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyProje.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Proje scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;







function TDmYonet.CopyPaketToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PAKET_KOD,PAKET_SID,PAKET_ADI,BARKOD,ACIKLAMA FROM PAKET ORDER BY PAKET_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('PAKET tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO PAKET (PAKET_KOD,PAKET_SID,PAKET_ADI,BARKOD,ACIKLAMA) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('PAKET_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('PAKET_SID').AsString+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('PAKET_ADI').AsString)+',';
//****************************************************************************//
    if qryCopyPaket.FieldByName('BARKOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('BARKOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
//****************************************************************************//
    if qryCopyPaket.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ACIKLAMA').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Paket scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;



function TDmYonet.CopyPaket_DToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PAKET_KOD,PAKET_D_ID,PAKET_D_SID,URUN_KOD,OLCU_BIRIM,MIKTAR FROM PAKET_D ORDER BY PAKET_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('PAKET_D tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO PAKET_D (PAKET_KOD,PAKET_D_ID,PAKET_D_SID,URUN_KOD,OLCU_BIRIM,MIKTAR) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('PAKET_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('PAKET_D_ID').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('PAKET_D_SID').AsString+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('URUN_KOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('OLCU_BIRIM').AsString)+',';
    SQLInsert := SQLInsert + SQL_Para(qryCopyPaket.FieldByName('MIKTAR').AsFloat)+');';

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Paket_D scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;








function TDmYonet.CopyPlasiyerToTerm: Boolean;
var
  qryCopyPlasiyer : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPlasiyer,nil,False,DataMod.dbaMain);
  with qryCopyPlasiyer do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PLASIYER_KOD,PLASIYER_SID,ADISOY,FIRMA_ID,TELNO_1,TELNO_2,FAX,ADRES_1,ADRES_2,');
    SQL.Add('ILCE,SEHIR,POSTAKOD,EMAIL,WEBADDR,DOVKOD,PASIF FROM PLASIYER WHERE PASIF = 0 ORDER BY PLASIYER_KOD');
    Open;
  end;
  if (qryCopyPlasiyer.Eof and qryCopyPlasiyer.Bof) then
  begin
    Result := True;
    Application.MessageBox('PLASIYER tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPlasiyer.First;
  while not qryCopyPlasiyer.Eof do
  begin
    SQLInsert := 'INSERT INTO PLASIYER (PLASIYER_KOD,PLASIYER_SID,ADISOY,FIRMA_ID,'
                +'DOVKOD,PASIF,TELNO_1,TELNO_2,FAX,ADRES_1,ADRES_2,ILCE,SEHIR,POSTAKOD,EMAIL,WEBADDR) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('PLASIYER_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPlasiyer.FieldByName('PLASIYER_SID').AsString+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('ADISOY').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPlasiyer.FieldByName('FIRMA_ID').AsString+',';
//****************************************************************************//
    if qryCopyPlasiyer.FieldByName('DOVKOD').AsString = glb_DEFCUR then
      SQLInsert := SQLInsert + SQL_Katar('YTL')+','
    else
      SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('DOVKOD').AsString)+',';
//****************************************************************************//
    SQLInsert := SQLInsert + qryCopyPlasiyer.FieldByName('PASIF').AsString+',';
//****************************************************************************//
    if qryCopyPlasiyer.FieldByName('TELNO_1').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('TELNO_1').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyPlasiyer.FieldByName('TELNO_2').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('TELNO_2').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyPlasiyer.FieldByName('FAX').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('FAX').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyPlasiyer.FieldByName('ADRES_1').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('ADRES_1').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyPlasiyer.FieldByName('ADRES_2').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('ADRES_2').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyPlasiyer.FieldByName('ILCE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('ILCE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyPlasiyer.FieldByName('SEHIR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('SEHIR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyPlasiyer.FieldByName('POSTAKOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('POSTAKOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyPlasiyer.FieldByName('EMAIL').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('EMAIL').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyPlasiyer.FieldByName('WEBADDR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPlasiyer.FieldByName('WEBADDR').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyPlasiyer.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Plasiyer scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyRapKodParamsToTerm: Boolean;
var
  qryCopyRapKodParams : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyRapKodParams,nil,False,DataMod.dbaMain);
  with qryCopyRapKodParams do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT BELGE,MASRAF_MERK,KOD1,KOD2,KOD3,KOD4,ACIKLAMA FROM RAP_KOD_PARAMS ORDER BY BELGE');
    Open;
  end;
  if (qryCopyRapKodParams.Eof and qryCopyRapKodParams.Bof) then
  begin
    Result := True;
    Application.MessageBox('RAP_KOD_PARAMS tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyRapKodParams.First;
  while not qryCopyRapKodParams.Eof do
  begin
    SQLInsert := 'INSERT INTO RAP_KOD_PARAMS (BELGE,MASRAF_MERK,KOD1,KOD2,KOD3,KOD4,ACIKLAMA) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyRapKodParams.FieldByName('BELGE').AsString)+',';
    SQLInsert := SQLInsert + qryCopyRapKodParams.FieldByName('MASRAF_MERK').AsString+',';
    SQLInsert := SQLInsert + qryCopyRapKodParams.FieldByName('KOD1').AsString+',';
    SQLInsert := SQLInsert + qryCopyRapKodParams.FieldByName('KOD2').AsString+',';
    SQLInsert := SQLInsert + qryCopyRapKodParams.FieldByName('KOD3').AsString+',';
    SQLInsert := SQLInsert + qryCopyRapKodParams.FieldByName('KOD4').AsString+',';
//****************************************************************************//
    if qryCopyRapKodParams.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyRapKodParams.FieldByName('ACIKLAMA').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyRapKodParams.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Rapor kod parametreleri scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopySayaclarToTerm: Boolean;
var
  qryCopySayaclar : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopySayaclar,nil,False,DataMod.dbaMain);
  with qryCopySayaclar do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SAYAC_ADI,SUBE_ID,DEGER FROM SAYACLAR ORDER BY SAYAC_ADI');
    Open;
  end;
  if (qryCopySayaclar.Eof and qryCopySayaclar.Bof) then
  begin
    Result := True;
    Application.MessageBox('SAYACLAR tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopySayaclar.First;
  while not qryCopySayaclar.Eof do
  begin
    SQLInsert := 'INSERT INTO SAYACLAR (SAYAC_ADI,SUBE_ID,DEGER) VALUES (';

    SQLInsert := SQLInsert + SQL_Katar(qryCopySayaclar.FieldByName('SAYAC_ADI').AsString)+',';

    SQLInsert := SQLInsert + SQL_Katar(qryCopySayaclar.FieldByName('SUBE_ID').AsString)+',';

    if ((qryCopySayaclar.FieldByName('SAYAC_ADI').AsString = 'ENT_HISTORY') or (qryCopySayaclar.FieldByName('SAYAC_ADI').AsString = 'SATIS_FATURA')) then
      SQLInsert := SQLInsert+'0'+');'
    else
      SQLInsert := SQLInsert + qryCopySayaclar.FieldByName('DEGER').AsString+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopySayaclar.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Sayaçlar scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;



function TDmYonet.CopySayaclarNuToTerm: Boolean;
var
  qryCopySayaclar : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopySayaclar,nil,False,DataMod.dbaMain);
  with qryCopySayaclar do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SAYAC_ADI,SUBE_ID,DEGER FROM SAYACLAR_NU ORDER BY SAYAC_ADI');
    Open;
  end;
  if (qryCopySayaclar.Eof and qryCopySayaclar.Bof) then
  begin
    Result := True;
    Application.MessageBox('SAYACLAR_NU tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopySayaclar.First;
  while not qryCopySayaclar.Eof do
  begin
    SQLInsert := 'INSERT INTO SAYACLAR_NU (SAYAC_ADI,SUBE_ID,DEGER) VALUES (';

    SQLInsert := SQLInsert + SQL_Katar(qryCopySayaclar.FieldByName('SAYAC_ADI').AsString)+',';

    SQLInsert := SQLInsert + SQL_Katar(qryCopySayaclar.FieldByName('SUBE_ID').AsString)+',';

    if ((qryCopySayaclar.FieldByName('SAYAC_ADI').AsString = 'ENT_HISTORY') or (qryCopySayaclar.FieldByName('SAYAC_ADI').AsString = 'SATIS_FATURA')) then
      SQLInsert := SQLInsert+'0'+');'
    else
      SQLInsert := SQLInsert + qryCopySayaclar.FieldByName('DEGER').AsString+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopySayaclar.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Sayaçlar _NU scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;




function TDmYonet.CopyUrunTedarikToTerm:Boolean;
var
  qryCopyBelgeYaz : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyBelgeYaz,nil,False,DataMod.dbaMain);
  with qryCopyBelgeYaz do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT URUN_KOD, CARI_KOD, TEDARIK_SURESI, FIYAT, ACIKLAMA FROM URUN_TEDARIK ORDER BY URUN_KOD, CARI_KOD');
    Open;
  end;
  if (qryCopyBelgeYaz.Eof and qryCopyBelgeYaz.Bof) then
  begin
    Result := True;
    Application.MessageBox('URUN_TEDARIK tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyBelgeYaz.First;
  while not qryCopyBelgeYaz.Eof do
  begin
    SQLInsert := 'INSERT INTO URUN_TEDARIK (URUN_KOD, CARI_KOD, TEDARIK_SURESI, FIYAT, ACIKLAMA) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeYaz.FieldByName('URUN_KOD').AsString)+',';


    if qryCopyBelgeYaz.FieldByName('CARI_KOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeYaz.FieldByName('CARI_KOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyBelgeYaz.FieldByName('TEDARIK_SURESI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyBelgeYaz.FieldByName('TEDARIK_SURESI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyBelgeYaz.FieldByName('FIYAT').IsNotNull then
       SQLInsert := SQLInsert + SQL_Para(qryCopyBelgeYaz.FieldByName('FIYAT').AsFloat)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyBelgeYaz.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyBelgeYaz.FieldByName('ACIKLAMA').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';




//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyBelgeYaz.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Ürün Tadarik scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;


function TDmYonet.CopyUrunGrupToTerm: Boolean;
var
  qryCopyUrunGroup : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyUrunGroup,nil,False,DataMod.dbaMain);
  with qryCopyUrunGroup do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT URUN_GRUP_KOD,URUN_GRUP_SID,UGADI,UGACK,BIRIMORAN,DOVKOD FROM URUN_GRUP ORDER BY URUN_GRUP_KOD');
    Open;
  end;
  if (qryCopyUrunGroup.Eof and qryCopyUrunGroup.Bof) then
  begin
    Result := True;
    Application.MessageBox('URUN_GRUP tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyUrunGroup.First;
  while not qryCopyUrunGroup.Eof do
  begin
    SQLInsert := 'INSERT INTO URUN_GRUP (URUN_GRUP_KOD,URUN_GRUP_SID,DOVKOD,UGADI,UGACK,BIRIMORAN) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunGroup.FieldByName('URUN_GRUP_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyUrunGroup.FieldByName('URUN_GRUP_SID').AsString+',';
    if qryCopyUrunGroup.FieldByName('DOVKOD').AsString = glb_DEFCUR then
       SQLInsert := SQLInsert + SQL_Katar('YTL')+','
    else
      SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunGroup.FieldByName('DOVKOD').AsString)+',';
//****************************************************************************//
    if qryCopyUrunGroup.FieldByName('UGADI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunGroup.FieldByName('UGADI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyUrunGroup.FieldByName('UGACK').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunGroup.FieldByName('UGACK').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
//****************************************************************************//
    if qryCopyUrunGroup.FieldByName('BIRIMORAN').IsNotNull then
       SQLInsert := SQLInsert + qryCopyUrunGroup.FieldByName('BIRIMORAN').AsString+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyUrunGroup.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Urun grup scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyUrunGrupUyeToTerm: Boolean;
var
  qryCopyUrunGroupUye : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyUrunGroupUye,nil,False,DataMod.dbaMain);
  with qryCopyUrunGroupUye do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT URUN_GRUP_KOD,URUN_KOD,VARSAY FROM URUN_GRUP_UYE ORDER BY URUN_GRUP_KOD,URUN_KOD');
    Open;
  end;
  if (qryCopyUrunGroupUye.Eof and qryCopyUrunGroupUye.Bof) then
  begin
    Result := True;
    Application.MessageBox('URUN_GRUP_UYE tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyUrunGroupUye.First;
  while not qryCopyUrunGroupUye.Eof do
  begin
    SQLInsert := 'INSERT INTO URUN_GRUP_UYE (URUN_GRUP_KOD,URUN_KOD,VARSAY) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunGroupUye.FieldByName('URUN_GRUP_KOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunGroupUye.FieldByName('URUN_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyUrunGroupUye.FieldByName('VARSAY').AsString+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyUrunGroupUye.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Urun grup uye scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyUrunCariFiyToTerm: Boolean;
var
  qryCopyUrunCariFiy : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyUrunCariFiy,nil,False,DataMod.dbaMain);
  with qryCopyUrunCariFiy do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT URUN_KOD,CARI_KOD,SATISFIY,SATISDOVKOD,BIRIMORAN,FIY_TIP FROM URUN_CARI_FIY ORDER BY URUN_KOD,CARI_KOD');
    Open;
  end;
  if (qryCopyUrunCariFiy.Eof and qryCopyUrunCariFiy.Bof) then
  begin
    Result := True;
    Application.MessageBox('URUN_CARI_FIY tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyUrunCariFiy.First;
  while not qryCopyUrunCariFiy.Eof do
  begin
    SQLInsert := 'INSERT INTO URUN_CARI_FIY (URUN_KOD,CARI_KOD,SATISFIY,SATISDOVKOD,BIRIMORAN,FIY_TIP) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunCariFiy.FieldByName('URUN_KOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunCariFiy.FieldByName('CARI_KOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Para(qryCopyUrunCariFiy.FieldByName('SATISFIY').AsCurrency)+',';
//****************************************************************************//
    if qryCopyUrunCariFiy.FieldByName('SATISDOVKOD').AsString = glb_DEFCUR then
      SQLInsert := SQLInsert + SQL_Katar('YTL')+','
    else
       SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunCariFiy.FieldByName('SATISDOVKOD').AsString)+',';
//****************************************************************************//
    SQLInsert := SQLInsert + qryCopyUrunCariFiy.FieldByName('BIRIMORAN').AsString+',';
    SQLInsert := SQLInsert + qryCopyUrunCariFiy.FieldByName('FIY_TIP').AsString+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyUrunCariFiy.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Urun cari fiy scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyUrunCGrupFiyToTerm: Boolean;
var
  qryCopyUrunCGrupFiy : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyUrunCGrupFiy,nil,False,DataMod.dbaMain);
  with qryCopyUrunCGrupFiy do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT URUN_KOD,CARI_GRUP_KOD,SATISFIY,SATISDOVKOD,BIRIMORAN,FIY_TIP FROM URUN_CGRUP_FIY ORDER BY URUN_KOD,CARI_GRUP_KOD');
    Open;
  end;
  if (qryCopyUrunCGrupFiy.Eof and qryCopyUrunCGrupFiy.Bof) then
  begin
    Result := True;
    Application.MessageBox('URUN_CGRUP_FIY tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyUrunCGrupFiy.First;
  while not qryCopyUrunCGrupFiy.Eof do
  begin
    SQLInsert := 'INSERT INTO URUN_CGRUP_FIY (URUN_KOD,CARI_GRUP_KOD,SATISFIY,SATISDOVKOD,BIRIMORAN,FIY_TIP) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunCGrupFiy.FieldByName('URUN_KOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunCGrupFiy.FieldByName('CARI_GRUP_KOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Para(qryCopyUrunCGrupFiy.FieldByName('SATISFIY').AsCurrency)+',';
//****************************************************************************//
    if qryCopyUrunCGrupFiy.FieldByName('SATISDOVKOD').AsString = glb_DEFCUR then
       SQLInsert := SQLInsert + SQL_Katar('YTL')+','
    else
      SQLInsert := SQLInsert + SQL_Katar(qryCopyUrunCGrupFiy.FieldByName('SATISDOVKOD').AsString)+',';
//****************************************************************************//
    SQLInsert := SQLInsert + qryCopyUrunCGrupFiy.FieldByName('BIRIMORAN').AsString+',';
    SQLInsert := SQLInsert + qryCopyUrunCGrupFiy.FieldByName('FIY_TIP').AsString+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyUrunCGrupFiy.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Urun cgrup fiy scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyRapKodToTerm: Boolean;
var
  qryCopyRapKod : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyRapKod,nil,False,DataMod.dbaMain);
  with qryCopyRapKod do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT RAP_KOD_TIP,KOD,ACIKLAMA FROM RAP_KOD ORDER BY RAP_KOD_TIP,KOD');
    Open;
  end;
  if (qryCopyRapKod.Eof and qryCopyRapKod.Bof) then
  begin
    Result := True;
    Application.MessageBox('RAP_KOD tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyRapKod.First;
  while not qryCopyRapKod.Eof do
  begin
    SQLInsert := 'INSERT INTO RAP_KOD (RAP_KOD_TIP,KOD,ACIKLAMA) VALUES (';
    SQLInsert := SQLInsert + qryCopyRapKod.FieldByName('RAP_KOD_TIP').AsString+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyRapKod.FieldByName('KOD').AsString)+',';
//****************************************************************************//
    if qryCopyRapKod.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyRapKod.FieldByName('ACIKLAMA').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyRapKod.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//

  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Rapor kodlarý scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyCariDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection): Boolean;
var
  qryCariListe : TIB_Cursor;
  qryCopyCari : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  dvr_total,SONUC : Currency;
begin
  DataMod.CreateCursor(qryCariListe,nil,False,Cn);
  with qryCariListe do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT');
    SQL.Add('CARI_KOD,KREDILMT,RISK');
    SQL.Add('FROM CARI');
    SQL.Add('ORDER BY CARI_KOD');
    Open;
  end;

  if (qryCariListe.Eof and qryCariListe.Bof) then
  begin
    Result := False;
    Application.MessageBox('CARI tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.CreateCursor(qryCopyCari,nil,False,Cn);
  SQLInsertLst := TStringList.Create;
  qryCariListe.First;
  while not qryCariListe.Eof do
  begin
    SQLInsert := 'UPDATE CARI SET ';
//****************************************************************************//
    if qryCariListe.FieldByName('KREDILMT').AsCurrency = 0 then
    begin
      SQLInsert := SQLInsert + 'KREDILMT=0,';
    end
    else
    begin
      DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',qryCariListe.FieldByName('KREDILMT').AsCurrency,2,True,SONUC);
      SQLInsert := SQLInsert + 'KREDILMT='+ SQL_Para(SONUC)+',';
    end;
//****************************************************************************//
    if qryCariListe.FieldByName('RISK').AsCurrency = 0 then
    begin
      SQLInsert := SQLInsert + 'RISK=0,';
    end
    else
    begin
      DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',qryCariListe.FieldByName('RISK').AsCurrency,2,True,SONUC);
      SQLInsert := SQLInsert + 'RISK=' + SQL_Para(SONUC)+',';
    end;
//****************************************************************************//
    with qryCopyCari do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CARI.DEVREDEN_BORC,CARI.DEVREDEN_ALACAK,(SELECT SUM(TUTAR_VPB) FROM CARIHAR WHERE CARIHAR.TIP ='+SQL_Katar(BORC));
      SQL.Add(' AND CARIHAR.CARI_KOD ='+SQL_Katar(qryCariListe.FieldByName('CARI_KOD').AsString));
//      SQL.Add(' AND CARIHAR.TARIH >='+chr(39)+Donem_Bas+chr(39)+' AND CARIHAR.TARIH <= '+chr(39)+Donem_Son+chr(39)+') as BORC');
      SQL.Add(' ) as BORC');
      SQL.Add(',');
      SQL.Add('(SELECT SUM(TUTAR_VPB) FROM CARIHAR WHERE CARIHAR.TIP ='+SQL_Katar(ALACAK ));
      SQL.Add('AND CARIHAR.CARI_KOD ='+SQL_Katar(qryCariListe.FieldByName('CARI_KOD').AsString));
//      SQL.Add('AND CARIHAR.TARIH >='+chr(39)+Donem_Bas+chr(39)+' AND CARIHAR.TARIH <= '+chr(39)+Donem_Son+chr(39)+') as ALACAK');
      SQL.Add(' ) as ALACAK');
      SQL.Add('FROM CARI WHERE CARI.CARI_KOD = '+SQL_Katar(qryCariListe.FieldByName('CARI_KOD').AsString));
      Open;
    end;
//****************************************************************************//
    if (qryCopyCari.FieldByName('DEVREDEN_BORC').AsCurrency + qryCopyCari.FieldByName('BORC').AsCurrency)
    > (qryCopyCari.FieldByName('DEVREDEN_ALACAK').AsCurrency + qryCopyCari.FieldByName('ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyCari.FieldByName('BORC').AsCurrency + qryCopyCari.FieldByName('DEVREDEN_BORC').AsCurrency)
                 - (qryCopyCari.FieldByName('ALACAK').AsCurrency + qryCopyCari.FieldByName('DEVREDEN_ALACAK').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      end
      else
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC='+SQL_Para(dvr_total)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end
    else
    if (qryCopyCari.FieldByName('BORC').AsCurrency + qryCopyCari.FieldByName('DEVREDEN_BORC').AsCurrency)
    < (qryCopyCari.FieldByName('ALACAK').AsCurrency  + qryCopyCari.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyCari.FieldByName('ALACAK').AsCurrency + qryCopyCari.FieldByName('DEVREDEN_ALACAK').AsCurrency)
                 - (qryCopyCari.FieldByName('BORC').AsCurrency + qryCopyCari.FieldByName('DEVREDEN_BORC').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
//****************************************************************************//
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
      end
      else
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK='+ SQL_Para(dvr_total);//devreden alacak
      end;
//****************************************************************************//
    end
    else
    if (qryCopyCari.FieldByName('BORC').AsCurrency + qryCopyCari.FieldByName('DEVREDEN_BORC').AsCurrency)
    = (qryCopyCari.FieldByName('ALACAK').AsCurrency + qryCopyCari.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end;
//****************************************************************************//
    SQLInsert := SQLInsert + ' WHERE CARI_KOD = '+SQL_Katar(qryCariListe.FieldByName('CARI_KOD').AsString)+';';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCariListe.Next;
  end;
//****************************************************************************//
  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('CariDev scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;




function TDmYonet.CopyMasrafDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection):Boolean;
var
  qryMasrafListe : TIB_Cursor;
  qryCopyMasraf : TIB_Cursor;
  SQLInsert,strSQL : String;
  SQLInsertLst : TStringList;
  dvr_total,SONUC : Currency;
begin
  DataMod.CreateCursor(qryMasrafListe,nil,False,Cn);

  with qryMasrafListe do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT MASRAF_KOD FROM MASRAF WHERE DEVIR = 1 ORDER BY MASRAF_KOD');
    Open;
  end;

  if (qryMasrafListe.Eof and qryMasrafliste.Bof) then
  begin
    Result := True;
    Application.MessageBox('MASRAF tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  DataMod.CreateCursor(qryCopyMasraf,nil,False,Cn);
  qryMasrafListe.First;
  while not qryMasrafListe.Eof do
  begin
    strSQL := 'SELECT'
            + ' MASRAF.DEVREDEN_BORC,MASRAF.DEVREDEN_ALACAK,'
//            + '(SELECT SUM(MASRAFHAR.TUTAR_VPB) FROM MASRAFHAR WHERE MASRAFHAR.BA ='+SQL_Katar(BORC)+' AND MASRAFHAR.MASRAF_KOD ='+SQL_Katar(qryMasrafListe.FieldByName('MASRAF_KOD').AsString)+' AND MASRAFHAR.TARIH >='+chr(39)+Donem_Bas+chr(39)+' AND MASRAFHAR.TARIH <= '+chr(39)+Donem_Son+chr(39)+') as BORC'
            + '(SELECT SUM(MASRAFHAR.TUTAR_VPB) FROM MASRAFHAR WHERE MASRAFHAR.BA ='+SQL_Katar(BORC)+' AND MASRAFHAR.MASRAF_KOD ='+SQL_Katar(qryMasrafListe.FieldByName('MASRAF_KOD').AsString)+') as BORC'
            + ','
//            + '(SELECT SUM(MASRAFHAR.TUTAR_VPB) FROM MASRAFHAR WHERE MASRAFHAR.BA ='+SQL_Katar(ALACAK)+' AND MASRAFHAR.MASRAF_KOD ='+SQL_Katar(qryMasrafListe.FieldByName('MASRAF_KOD').AsString)+' AND MASRAFHAR.TARIH >='+chr(39)+Donem_Bas+chr(39)+' AND MASRAFHAR.TARIH <= '+chr(39)+Donem_Son+chr(39)+') as ALACAK'
            + '(SELECT SUM(MASRAFHAR.TUTAR_VPB) FROM MASRAFHAR WHERE MASRAFHAR.BA ='+SQL_Katar(ALACAK)+' AND MASRAFHAR.MASRAF_KOD ='+SQL_Katar(qryMasrafListe.FieldByName('MASRAF_KOD').AsString)+') as ALACAK'
            + ' FROM MASRAF WHERE MASRAF.MASRAF_KOD = '+SQL_Katar(qryMasrafListe.FieldByName('MASRAF_KOD').AsString);
    with qryCopyMasraf do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
    end;
//****************************************************************************//
    SQLInsert := 'UPDATE MASRAF SET ';
//****************************************************************************//
    if (qryCopyMasraf.FieldByName('BORC').AsCurrency + qryCopyMasraf.FieldByName('DEVREDEN_BORC').AsCurrency)
    >  (qryCopyMasraf.FieldByName('ALACAK').AsCurrency + qryCopyMasraf.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyMasraf.FieldByName('BORC').AsCurrency + qryCopyMasraf.FieldByName('DEVREDEN_BORC').AsCurrency)
                 - (qryCopyMasraf.FieldByName('ALACAK').AsCurrency + qryCopyMasraf.FieldByName('DEVREDEN_ALACAK').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      end
      else
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC='+SQL_Para(dvr_total)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end
    else

    if (qryCopyMasraf.FieldByName('BORC').AsCurrency + qryCopyMasraf.FieldByName('DEVREDEN_BORC').AsCurrency)
    <  (qryCopyMasraf.FieldByName('ALACAK').AsCurrency + qryCopyMasraf.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyMasraf.FieldByName('ALACAK').AsCurrency + qryCopyMasraf.FieldByName('DEVREDEN_ALACAK').AsCurrency)
                 - (qryCopyMasraf.FieldByName('DEVREDEN_BORC').AsCurrency + qryCopyMasraf.FieldByName('BORC').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
      end
      else
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK='+SQL_Para(dvr_total);//devreden alacak
      end;
    end
    else
    if (qryCopyMasraf.FieldByName('BORC').AsCurrency + qryCopyMasraf.FieldByName('DEVREDEN_BORC').AsCurrency)
    =  (qryCopyMasraf.FieldByName('ALACAK').AsCurrency + qryCopyMasraf.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak

    end;


//****************************************************************************//
    SQLInsert := SQLInsert + ' WHERE MASRAF_KOD = '+SQL_Katar(qryMasrafListe.FieldByName('MASRAF_KOD').AsString)+';';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryMasrafListe.Next;
  end;
//****************************************************************************//
  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('MasrafDev scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyPlasiyerDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection): Boolean;
var
  qryCopyPlasiyer : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  dvr_total,SONUC : Currency;
begin
  DataMod.CreateCursor(qryCopyPlasiyer,nil,False,Cn);
  with qryCopyPlasiyer do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PLASIYER_KOD,');
    SQL.Add('BORC,ALACAK,BORC_VPB,ALACAK_VPB,DEVREDEN_BORC,DEVREDEN_ALACAK,DEVREDEN_BORC_VPB,DEVREDEN_ALACAK_VPB');
    SQL.Add('FROM PLASIYER WHERE PASIF = 0 ORDER BY PLASIYER_KOD');
    Open;
  end;
  if (qryCopyPlasiyer.Eof and qryCopyPlasiyer.Bof) then
  begin
    Result := True;
    Application.MessageBox('PLASIYER tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPlasiyer.First;
  while not qryCopyPlasiyer.Eof do
  begin
    SQLInsert := 'UPDATE PLASIYER SET ';
//****************************************************************************//
    if (qryCopyPlasiyer.FieldByName('BORC').AsCurrency   + qryCopyPlasiyer.FieldByName('DEVREDEN_BORC').AsCurrency)
    >  (qryCopyPlasiyer.FieldByName('ALACAK').AsCurrency + qryCopyPlasiyer.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyPlasiyer.FieldByName('BORC').AsCurrency   + qryCopyPlasiyer.FieldByName('DEVREDEN_BORC').AsCurrency) -
                   (qryCopyPlasiyer.FieldByName('ALACAK').AsCurrency + qryCopyPlasiyer.FieldByName('DEVREDEN_ALACAK').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC='+SQL_Para(SONUC)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0,';//devreden alacak
    end
    else
    if (qryCopyPlasiyer.FieldByName('BORC').AsCurrency   + qryCopyPlasiyer.FieldByName('DEVREDEN_BORC').AsCurrency)
    <  (qryCopyPlasiyer.FieldByName('ALACAK').AsCurrency + qryCopyPlasiyer.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyPlasiyer.FieldByName('ALACAK').AsCurrency + qryCopyPlasiyer.FieldByName('DEVREDEN_ALACAK').AsCurrency) -
                   (qryCopyPlasiyer.FieldByName('BORC').AsCurrency   + qryCopyPlasiyer.FieldByName('DEVREDEN_BORC').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0,';//devreden alacak
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK='+SQL_Para(SONUC)+',';//devreden alacak
      end;
    end
    else
    if (qryCopyPlasiyer.FieldByName('BORC').AsCurrency   + qryCopyPlasiyer.FieldByName('DEVREDEN_BORC').AsCurrency)
    =  (qryCopyPlasiyer.FieldByName('ALACAK').AsCurrency + qryCopyPlasiyer.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0,';//devreden alacak
    end;
//****************************************************************************//
    if (qryCopyPlasiyer.FieldByName('BORC_VPB').AsCurrency   + qryCopyPlasiyer.FieldByName('DEVREDEN_BORC_VPB').AsCurrency)
    >  (qryCopyPlasiyer.FieldByName('ALACAK_VPB').AsCurrency + qryCopyPlasiyer.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyPlasiyer.FieldByName('BORC_VPB').AsCurrency   + qryCopyPlasiyer.FieldByName('DEVREDEN_BORC_VPB').AsCurrency) -
                   (qryCopyPlasiyer.FieldByName('ALACAK_VPB').AsCurrency + qryCopyPlasiyer.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB='+SQL_Para(SONUC)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
    end
    else
    if (qryCopyPlasiyer.FieldByName('BORC_VPB').AsCurrency   + qryCopyPlasiyer.FieldByName('DEVREDEN_BORC_VPB').AsCurrency)
    <  (qryCopyPlasiyer.FieldByName('ALACAK_VPB').AsCurrency + qryCopyPlasiyer.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyPlasiyer.FieldByName('ALACAK_VPB').AsCurrency + qryCopyPlasiyer.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) -
                   (qryCopyPlasiyer.FieldByName('BORC_VPB').AsCurrency   + qryCopyPlasiyer.FieldByName('DEVREDEN_BORC_VPB').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB='+SQL_Para(SONUC);//devreden alacak
      end;
    end
    else
    if (qryCopyPlasiyer.FieldByName('BORC_VPB').AsCurrency   + qryCopyPlasiyer.FieldByName('DEVREDEN_BORC_VPB').AsCurrency)
    =  (qryCopyPlasiyer.FieldByName('ALACAK_VPB').AsCurrency + qryCopyPlasiyer.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
    end;
//****************************************************************************//
    SQLInsert := SQLInsert + ' WHERE PLASIYER_KOD='+SQL_Katar(qryCopyPlasiyer.FieldByName('PLASIYER_KOD').AsString)+';';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyPlasiyer.Next;
  end;
//****************************************************************************//
  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('PlasiyerDev scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyProjeDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection): Boolean;
var
  qryCopyProje : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  dvr_total,SONUC : Currency;
begin
  DataMod.CreateCursor(qryCopyProje,nil,False,Cn);
  with qryCopyProje do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PROJE_KOD,BORC,ALACAK,BORC_VPB,ALACAK_VPB,DEVREDEN_BORC,');
    SQL.Add('DEVREDEN_ALACAK,DEVREDEN_BORC_VPB,DEVREDEN_ALACAK_VPB FROM PROJE WHERE KAPANDI = 0 ORDER BY PROJE_KOD');
    Open;
  end;
  if (qryCopyProje.Eof and qryCopyProje.Bof) then
  begin
    Result := True;
    Application.MessageBox('PROJE tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyProje.First;
  while not qryCopyProje.Eof do
  begin
    SQLInsert := 'UPDATE PROJE SET ';
//****************************************************************************//
    if (qryCopyProje.FieldByName('BORC').AsCurrency   + qryCopyProje.FieldByName('DEVREDEN_BORC').AsCurrency)
    >  (qryCopyProje.FieldByName('ALACAK').AsCurrency + qryCopyProje.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyProje.FieldByName('BORC').AsCurrency   + qryCopyProje.FieldByName('DEVREDEN_BORC').AsCurrency) -
                   (qryCopyProje.FieldByName('ALACAK').AsCurrency + qryCopyProje.FieldByName('DEVREDEN_ALACAK').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC='+SQL_Para(SONUC)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0,';//devreden alacak
    end
    else
    if (qryCopyProje.FieldByName('BORC').AsCurrency   + qryCopyProje.FieldByName('DEVREDEN_BORC').AsCurrency)
    <  (qryCopyProje.FieldByName('ALACAK').AsCurrency + qryCopyProje.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyProje.FieldByName('ALACAK').AsCurrency + qryCopyProje.FieldByName('DEVREDEN_ALACAK').AsCurrency) -
                   (qryCopyProje.FieldByName('BORC').AsCurrency   + qryCopyProje.FieldByName('DEVREDEN_BORC').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0,';//devreden alacak
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK='+SQL_Para(SONUC)+',';//devreden alacak
      end;
    end
    else
    if (qryCopyProje.FieldByName('BORC').AsCurrency   + qryCopyProje.FieldByName('DEVREDEN_BORC').AsCurrency) =
       (qryCopyProje.FieldByName('ALACAK').AsCurrency + qryCopyProje.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0,';//devreden alacak
    end;
//****************************************************************************//
    if (qryCopyProje.FieldByName('BORC_VPB').AsCurrency   + qryCopyProje.FieldByName('DEVREDEN_BORC_VPB').AsCurrency)
    >  (qryCopyProje.FieldByName('ALACAK_VPB').AsCurrency + qryCopyProje.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyProje.FieldByName('BORC_VPB').AsCurrency   + qryCopyProje.FieldByName('DEVREDEN_BORC_VPB').AsCurrency) -
                   (qryCopyProje.FieldByName('ALACAK_VPB').AsCurrency + qryCopyProje.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB='+SQL_Para(SONUC)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
    end
    else
    if (qryCopyProje.FieldByName('BORC_VPB').AsCurrency   + qryCopyProje.FieldByName('DEVREDEN_BORC_VPB').AsCurrency)
    <  (qryCopyProje.FieldByName('ALACAK_VPB').AsCurrency + qryCopyProje.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyProje.FieldByName('ALACAK_VPB').AsCurrency + qryCopyProje.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) -
                   (qryCopyProje.FieldByName('BORC_VPB').AsCurrency   + qryCopyProje.FieldByName('DEVREDEN_BORC_VPB').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB='+SQL_Para(SONUC);//devreden alacak
      end;
    end
    else
    if (qryCopyProje.FieldByName('BORC_VPB').AsCurrency   + qryCopyProje.FieldByName('DEVREDEN_BORC_VPB').AsCurrency) =
       (qryCopyProje.FieldByName('ALACAK_VPB').AsCurrency + qryCopyProje.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
    end;
//****************************************************************************//
    SQLInsert := SQLInsert + ' WHERE PROJE_KOD = '+SQL_Katar(qryCopyProje.FieldByName('PROJE_KOD').AsString)+';';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyProje.Next;
  end;
//****************************************************************************//
  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('ProjeDev scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;






function TDmYonet.Sirali_Calistir(ScriptObj:TIB_Script;Cn:TIB_Connection;SQLInsertLst:TStringList): Boolean;
var
a:Integer;
begin

      for a:=0 to SQLInsertLst.Count-1 do
      begin
           qryHedef1.Close;
           qryHedef1.Sql.Text:=SQLInsertLst.Strings[a];
           try
           qryHedef1.ExecSQL;
           finally
             if frmBakiyeDevret<>Nil then
             frmBakiyeDevret.MemoCikti.Lines.Add('Satýr Hata'+#13+qryHedef1.Sql.Text);

           end;
      end;

end;

function TDmYonet.CopyAracDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection): Boolean;
var
  qryCopyArac : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  dvr_total,SONUC : Currency;
begin
  DataMod.CreateCursor(qryCopyArac,nil,False,Cn);
  with qryCopyArac do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ARAC_KOD,BORC,ALACAK,DEVREDEN_BORC,');
    SQL.Add('DEVREDEN_ALACAK FROM ARAC WHERE AKTIF_DEGIL = 0 ORDER BY ARAC_KOD');
    Open;
  end;
  if (qryCopyArac.Eof and qryCopyArac.Bof) then
  begin
    Result := True;
    Application.MessageBox('ARAC tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyArac.First;
  while not qryCopyArac.Eof do
  begin
    SQLInsert := 'UPDATE ARAC SET ';
//****************************************************************************//
    if (qryCopyArac.FieldByName('BORC').AsCurrency   + qryCopyArac.FieldByName('DEVREDEN_BORC').AsCurrency)
    >  (qryCopyArac.FieldByName('ALACAK').AsCurrency + qryCopyArac.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyArac.FieldByName('BORC').AsCurrency   + qryCopyArac.FieldByName('DEVREDEN_BORC').AsCurrency) -
                   (qryCopyArac.FieldByName('ALACAK').AsCurrency + qryCopyArac.FieldByName('DEVREDEN_ALACAK').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC='+SQL_Para(SONUC)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end
    else
    if (qryCopyArac.FieldByName('BORC').AsCurrency   + qryCopyArac.FieldByName('DEVREDEN_BORC').AsCurrency)
    <  (qryCopyArac.FieldByName('ALACAK').AsCurrency + qryCopyArac.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyArac.FieldByName('ALACAK').AsCurrency + qryCopyArac.FieldByName('DEVREDEN_ALACAK').AsCurrency) -
                   (qryCopyArac.FieldByName('BORC').AsCurrency   + qryCopyArac.FieldByName('DEVREDEN_BORC').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK='+SQL_Para(SONUC)+'';//devreden alacak
      end;
    end
    else
    if (qryCopyArac.FieldByName('BORC').AsCurrency   + qryCopyArac.FieldByName('DEVREDEN_BORC').AsCurrency) =
       (qryCopyArac.FieldByName('ALACAK').AsCurrency + qryCopyArac.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end;
//****************************************************************************//
{    if (qryCopyArac.FieldByName('BORC_VPB').AsCurrency   + qryCopyArac.FieldByName('DEVREDEN_BORC_VPB').AsCurrency)
    >  (qryCopyArac.FieldByName('ALACAK_VPB').AsCurrency + qryCopyArac.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyArac.FieldByName('BORC_VPB').AsCurrency   + qryCopyArac.FieldByName('DEVREDEN_BORC_VPB').AsCurrency) -
                   (qryCopyArac.FieldByName('ALACAK_VPB').AsCurrency + qryCopyArac.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB='+SQL_Para(SONUC)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
    end
    else
    if (qryCopyArac.FieldByName('BORC_VPB').AsCurrency   + qryCopyArac.FieldByName('DEVREDEN_BORC_VPB').AsCurrency)
    <  (qryCopyArac.FieldByName('ALACAK_VPB').AsCurrency + qryCopyArac.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyArac.FieldByName('ALACAK_VPB').AsCurrency + qryCopyArac.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) -
                   (qryCopyArac.FieldByName('BORC_VPB').AsCurrency   + qryCopyArac.FieldByName('DEVREDEN_BORC_VPB').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB='+SQL_Para(SONUC);//devreden alacak
      end;
    end
    else
    if (qryCopyArac.FieldByName('BORC_VPB').AsCurrency   + qryCopyArac.FieldByName('DEVREDEN_BORC_VPB').AsCurrency) =
       (qryCopyArac.FieldByName('ALACAK_VPB').AsCurrency + qryCopyArac.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
    end;

    }
//****************************************************************************//
    SQLInsert := SQLInsert + ' WHERE ARAC_KOD = '+SQL_Katar(qryCopyArac.FieldByName('ARAC_KOD').AsString)+';';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyArac.Next;
  end;
//****************************************************************************//
  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('AracDev scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;



function TDmYonet.CopyPersonelDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection): Boolean;
var
  qryCopyPersonel : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  dvr_total,SONUC : Currency;
begin
  DataMod.CreateCursor(qryCopyPersonel,nil,False,Cn);
  with qryCopyPersonel do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PERSONEL_KOD,BORC,ALACAK,DEVREDEN_BORC,');
    SQL.Add('DEVREDEN_ALACAK FROM PERSONEL WHERE LISTEDEN_CIKAR = 0 ORDER BY PERSONEL_KOD');
    Open;
  end;
  if (qryCopyPersonel.Eof and qryCopyPersonel.Bof) then
  begin
    Result := True;
    Application.MessageBox('PERSONEL tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPersonel.First;
  while not qryCopyPersonel.Eof do
  begin
    SQLInsert := 'UPDATE PERSONEL SET ';
//****************************************************************************//
    if (qryCopyPersonel.FieldByName('BORC').AsCurrency   + qryCopyPersonel.FieldByName('DEVREDEN_BORC').AsCurrency)
    >  (qryCopyPersonel.FieldByName('ALACAK').AsCurrency + qryCopyPersonel.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyPersonel.FieldByName('BORC').AsCurrency   + qryCopyPersonel.FieldByName('DEVREDEN_BORC').AsCurrency) -
                   (qryCopyPersonel.FieldByName('ALACAK').AsCurrency + qryCopyPersonel.FieldByName('DEVREDEN_ALACAK').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC='+SQL_Para(SONUC)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end
    else
    if (qryCopyPersonel.FieldByName('BORC').AsCurrency   + qryCopyPersonel.FieldByName('DEVREDEN_BORC').AsCurrency)
    <  (qryCopyPersonel.FieldByName('ALACAK').AsCurrency + qryCopyPersonel.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyPersonel.FieldByName('ALACAK').AsCurrency + qryCopyPersonel.FieldByName('DEVREDEN_ALACAK').AsCurrency) -
                   (qryCopyPersonel.FieldByName('BORC').AsCurrency   + qryCopyPersonel.FieldByName('DEVREDEN_BORC').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK='+SQL_Para(SONUC)+'';//devreden alacak
      end;
    end
    else
    if (qryCopyPersonel.FieldByName('BORC').AsCurrency   + qryCopyPersonel.FieldByName('DEVREDEN_BORC').AsCurrency) =
       (qryCopyPersonel.FieldByName('ALACAK').AsCurrency + qryCopyPersonel.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end;
//****************************************************************************//
{    if (qryCopyPersonel.FieldByName('BORC_VPB').AsCurrency   + qryCopyPersonel.FieldByName('DEVREDEN_BORC_VPB').AsCurrency)
    >  (qryCopyPersonel.FieldByName('ALACAK_VPB').AsCurrency + qryCopyPersonel.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyPersonel.FieldByName('BORC_VPB').AsCurrency   + qryCopyPersonel.FieldByName('DEVREDEN_BORC_VPB').AsCurrency) -
                   (qryCopyPersonel.FieldByName('ALACAK_VPB').AsCurrency + qryCopyPersonel.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB='+SQL_Para(SONUC)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
    end
    else
    if (qryCopyPersonel.FieldByName('BORC_VPB').AsCurrency   + qryCopyPersonel.FieldByName('DEVREDEN_BORC_VPB').AsCurrency)
    <  (qryCopyPersonel.FieldByName('ALACAK_VPB').AsCurrency + qryCopyPersonel.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyPersonel.FieldByName('ALACAK_VPB').AsCurrency + qryCopyPersonel.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) -
                   (qryCopyPersonel.FieldByName('BORC_VPB').AsCurrency   + qryCopyPersonel.FieldByName('DEVREDEN_BORC_VPB').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB='+SQL_Para(SONUC);//devreden alacak
      end;
    end
    else
    if (qryCopyPersonel.FieldByName('BORC_VPB').AsCurrency   + qryCopyPersonel.FieldByName('DEVREDEN_BORC_VPB').AsCurrency) =
       (qryCopyPersonel.FieldByName('ALACAK_VPB').AsCurrency + qryCopyPersonel.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
    end;

    }
//****************************************************************************//
    SQLInsert := SQLInsert + ' WHERE PERSONEL_KOD = '+SQL_Katar(qryCopyPersonel.FieldByName('PERSONEL_KOD').AsString)+';';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyPersonel.Next;
  end;
//****************************************************************************//
  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('PersonelDev scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;



function TDmYonet.CopyUrunDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection): Boolean;
var
  qryUrunListe : TIB_Cursor;
  qryCopyUrun : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  dvr_total,SONUC : Currency;
  strSQL : String;
begin
  DataMod.CreateCursor(qryUrunListe,nil,False,Cn);
//****************************************************************************//
  with qryUrunListe do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT URUN_KOD FROM URUN WHERE HIZMET = 0 ORDER BY URUN_KOD');
    //SQL.Add('BORC,ALACAK,BORC_VPB,ALACAK_VPB,MIKTAR_BORC,MIKTAR_ALACAK,');
    //SQL.Add('DEV_BORC,DEV_ALACAK,DEV_BORC_VPB,DEV_ALACAK_VPB,DEV_MIK_BORC,DEV_MIK_ALACAK');
    Open;
  end;
//****************************************************************************//
  if (qryUrunListe.Eof and qryUrunListe.Bof) then
  begin
    Result := True;
    Application.MessageBox('URUN tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  DataMod.CreateCursor(qryCopyUrun,nil,False,Cn);
  SQLInsertLst := TStringList.Create;
  qryUrunListe.First;
  while not qryUrunListe.Eof do
  begin
    strSQL := 'SELECT URUN.DEV_BORC_VPB,URUN.DEV_ALACAK_VPB,URUN.DEV_MIK_BORC,URUN.DEV_MIK_ALACAK,'
{
            + ' (URUN.DEV_BORC + (SELECT SUM(URUNHAR.TUTAR_URUN_DOVKOD) FROM URUNHAR'
            + ' INNER JOIN FAT_IRS ON (FAT_IRS.FAT_IRS_ID=URUNHAR.FATURA_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.FATURA_SID)'
            + ' WHERE URUNHAR.TARIH BETWEEN '+chr(39)+'01.01.2004'+chr(39)+' AND '+chr(39)+'31.12.2004'+chr(39)
            + ' AND URUNHAR.URUN_KOD = '+SQL_Katar(qryUrunListe.FieldByName('URUN_KOD').AsString)
            + ' AND FAT_IRS.TIP = 2)) AS ALIS_DOVKOD'
            + ','
            + ' (URUN.DEV_ALACAK + (SELECT SUM(URUNHAR.TUTAR_URUN_DOVKOD) FROM URUNHAR'
            + ' INNER JOIN FAT_IRS ON (FAT_IRS.FAT_IRS_ID=URUNHAR.FATURA_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.FATURA_SID)'
            + ' WHERE URUNHAR.TARIH BETWEEN '+chr(39)+'01.01.2004'+chr(39)+' AND '+chr(39)+'31.12.2004'+chr(39)
            + ' AND URUNHAR.URUN_KOD = '+SQL_Katar(qryUrunListe.FieldByName('URUN_KOD').AsString)
            + ' AND FAT_IRS.TIP = 1)) AS SATIS_DOVKOD'
            + ','
}
            + ' (SELECT SUM(URUNHAR.TUTAR_VPB) FROM URUNHAR'
            + ' INNER JOIN FAT_IRS ON (FAT_IRS.FAT_IRS_ID=URUNHAR.FATURA_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.FATURA_SID)'
//            + ' WHERE URUNHAR.TARIH BETWEEN '+chr(39)+'01.01.2004'+chr(39)+' AND '+chr(39)+'31.12.2004'+chr(39)
            + ' WHERE URUNHAR.TARIH IS NOT NULL '
            + ' AND URUNHAR.URUN_KOD = '+SQL_Katar(qryUrunListe.FieldByName('URUN_KOD').AsString)
            + ' AND FAT_IRS.TIP = 2) AS ALIS'
            + ','
            + ' (SELECT SUM(URUNHAR.TUTAR_VPB) FROM URUNHAR'
            + ' INNER JOIN FAT_IRS ON (FAT_IRS.FAT_IRS_ID=URUNHAR.FATURA_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.FATURA_SID)'
//            + ' WHERE URUNHAR.TARIH BETWEEN '+chr(39)+'01.01.2004'+chr(39)+' AND '+chr(39)+'31.12.2004'+chr(39)
            + ' WHERE URUNHAR.TARIH IS NOT NULL '
            + ' AND URUNHAR.URUN_KOD = '+SQL_Katar(qryUrunListe.FieldByName('URUN_KOD').AsString)
            + ' AND FAT_IRS.TIP = 1) AS SATIS'
            + ','
            + ' (SELECT SUM(URUNHAR.MIKTAR) FROM URUNHAR'
            + ' INNER JOIN FAT_IRS ON (FAT_IRS.FAT_IRS_ID=URUNHAR.FATURA_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.FATURA_SID)'
//            + ' WHERE URUNHAR.TARIH BETWEEN '+chr(39)+'01.01.2004'+chr(39)+' AND '+chr(39)+'31.12.2004'+chr(39)
            + ' WHERE URUNHAR.TARIH IS NOT NULL '
            + ' AND URUNHAR.URUN_KOD = '+SQL_Katar(qryUrunListe.FieldByName('URUN_KOD').AsString)
            + ' AND FAT_IRS.TIP = 2) AS ALIS_MIKTAR'
            + ','
            + ' (SELECT SUM(URUNHAR.MIKTAR) FROM URUNHAR'
            + ' INNER JOIN FAT_IRS ON (FAT_IRS.FAT_IRS_ID=URUNHAR.FATURA_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.FATURA_SID)'
//            + ' WHERE URUNHAR.TARIH BETWEEN '+chr(39)+'01.01.2004'+chr(39)+' AND '+chr(39)+'31.12.2004'+chr(39)
            + ' WHERE URUNHAR.TARIH IS NOT NULL '
            + ' AND URUNHAR.URUN_KOD = '+SQL_Katar(qryUrunListe.FieldByName('URUN_KOD').AsString)
            + ' AND FAT_IRS.TIP = 1) AS SATIS_MIKTAR'
            + ' FROM URUN'
            + ' WHERE URUN.URUN_KOD = '+SQL_Katar(qryUrunListe.FieldByName('URUN_KOD').AsString);
    with qryCopyUrun do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
    end;
//****************************************************************************//
    SQLInsert := 'UPDATE URUN SET ';
//****************************************************************************//
{
    if qryCopyUrun.FieldByName('ALIS_DOVKOD').AsCurrency > qryCopyUrun.FieldByName('SATIS_DOVKOD').AsCurrency then
    begin
      dvr_total := qryCopyUrun.FieldByName('ALIS_DOVKOD').AsCurrency - qryCopyUrun.FieldByName('SATIS_DOVKOD').AsCurrency;
      if qryUrunListe.FieldByName('DOVKOD').AsString = glb_DEFCUR then
      begin
        if dvr_total = 0 then
        begin
          SQLInsert := SQLInsert+'DEV_BORC=0,';//devreden borç
        end
        else
        begin
          DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
          SQLInsert := SQLInsert+'DEV_BORC='+SQL_Para(SONUC)+',';//devreden borç
        end;
        SQLInsert := SQLInsert+'DEV_ALACAK=0,';//devreden alacak
      end
      else
      begin
        SQLInsert := SQLInsert+'DEV_BORC='+SQL_Para(dvr_total)+',';//devreden borç
        SQLInsert := SQLInsert+'DEV_ALACAK=0,';//devreden alacak
      end;
//****************************************************************************//
    end
    else
    if qryCopyUrun.FieldByName('ALIS_DOVKOD').AsCurrency < qryCopyUrun.FieldByName('SATIS_DOVKOD').AsCurrency then
    begin
      dvr_total := qryCopyUrun.FieldByName('SATIS_DOVKOD').AsCurrency - qryCopyUrun.FieldByName('ALIS_DOVKOD').AsCurrency;
      if qryUrunListe.FieldByName('DOVKOD').AsString = glb_DEFCUR then
      begin
        SQLInsert := SQLInsert+'DEV_BORC=0,';//devreden borç
        if dvr_total = 0 then
        begin
          SQLInsert := SQLInsert+'DEV_ALACAK=0,';//devreden borç
        end
        else
        begin
          DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
          SQLInsert := SQLInsert+'DEV_ALACAK='+SQL_Para(SONUC)+',';//devreden borç
        end;
      end
      else
      begin
        SQLInsert := SQLInsert+'DEV_BORC=0,';//devreden borç
        SQLInsert := SQLInsert+'DEV_ALACAK='+SQL_Para(dvr_total)+',';//devreden alacak
      end;
//****************************************************************************//
    end
    else
    if qryCopyUrun.FieldByName('ALIS_DOVKOD').AsCurrency = qryCopyUrun.FieldByName('SATIS_DOVKOD').AsCurrency then
    begin
      SQLInsert := SQLInsert+'DEV_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEV_ALACAK=0,';//devreden alacak
    end;
}
//****************************************************************************//
    if (qryCopyUrun.FieldByName('ALIS').AsCurrency + qryCopyUrun.FieldByName('DEV_BORC_VPB').AsCurrency)
    >  (qryCopyUrun.FieldByName('SATIS').AsCurrency + qryCopyUrun.FieldByName('DEV_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyUrun.FieldByName('ALIS').AsCurrency + qryCopyUrun.FieldByName('DEV_BORC_VPB').AsCurrency)
                 - (qryCopyUrun.FieldByName('SATIS').AsCurrency + qryCopyUrun.FieldByName('DEV_ALACAK_VPB').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEV_BORC_VPB=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEV_BORC_VPB='+SQL_Para(SONUC)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEV_ALACAK_VPB=0,';//devreden alacak
//****************************************************************************//
    end
    else
    if (qryCopyUrun.FieldByName('ALIS').AsCurrency + qryCopyUrun.FieldByName('DEV_BORC_VPB').AsCurrency)
    <  (qryCopyUrun.FieldByName('SATIS').AsCurrency + qryCopyUrun.FieldByName('DEV_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyUrun.FieldByName('SATIS').AsCurrency + qryCopyUrun.FieldByName('DEV_ALACAK_VPB').AsCurrency)
                 - (qryCopyUrun.FieldByName('ALIS').AsCurrency + qryCopyUrun.FieldByName('DEV_BORC_VPB').AsCurrency);
      SQLInsert := SQLInsert+'DEV_BORC_VPB=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEV_ALACAK_VPB=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEV_ALACAK_VPB='+SQL_Para(SONUC)+',';//devreden borç
      end;
//****************************************************************************//
    end
    else
    if (qryCopyUrun.FieldByName('ALIS').AsCurrency + qryCopyUrun.FieldByName('DEV_BORC_VPB').AsCurrency)
    =  (qryCopyUrun.FieldByName('SATIS').AsCurrency + qryCopyUrun.FieldByName('DEV_ALACAK_VPB').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEV_BORC_VPB=0,';//devreden borç
      SQLInsert := SQLInsert+'DEV_ALACAK_VPB=0,';//devreden alacak
    end;
//****************************************************************************//
    if (qryCopyUrun.FieldByName('DEV_MIK_BORC').AsCurrency + qryCopyUrun.FieldByName('ALIS_MIKTAR').AsCurrency)
    >  (qryCopyUrun.FieldByName('DEV_MIK_ALACAK').AsCurrency + qryCopyUrun.FieldByName('SATIS_MIKTAR').AsCurrency) then
    begin
      dvr_total := (qryCopyUrun.FieldByName('DEV_MIK_BORC').AsCurrency + qryCopyUrun.FieldByName('ALIS_MIKTAR').AsCurrency)
                 - (qryCopyUrun.FieldByName('DEV_MIK_ALACAK').AsCurrency + qryCopyUrun.FieldByName('SATIS_MIKTAR').AsCurrency);
      SQLInsert := SQLInsert+'DEV_MIK_BORC='+SQL_Para(dvr_total)+',';//devreden borç
      SQLInsert := SQLInsert+'DEV_MIK_ALACAK=0';//devreden alacak
    end
    else
    if (qryCopyUrun.FieldByName('DEV_MIK_BORC').AsCurrency + qryCopyUrun.FieldByName('ALIS_MIKTAR').AsCurrency)
    <  (qryCopyUrun.FieldByName('DEV_MIK_ALACAK').AsCurrency + qryCopyUrun.FieldByName('SATIS_MIKTAR').AsCurrency) then
    begin
      dvr_total := (qryCopyUrun.FieldByName('DEV_MIK_ALACAK').AsCurrency + qryCopyUrun.FieldByName('SATIS_MIKTAR').AsCurrency)
                 - (qryCopyUrun.FieldByName('DEV_MIK_BORC').AsCurrency + qryCopyUrun.FieldByName('ALIS_MIKTAR').AsCurrency);
      SQLInsert := SQLInsert+'DEV_MIK_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEV_MIK_ALACAK='+SQL_Para(dvr_total);//devreden alacak
    end
    else
    if (qryCopyUrun.FieldByName('DEV_MIK_BORC').AsCurrency + qryCopyUrun.FieldByName('ALIS_MIKTAR').AsCurrency)
    =  (qryCopyUrun.FieldByName('DEV_MIK_ALACAK').AsCurrency + qryCopyUrun.FieldByName('SATIS_MIKTAR').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEV_MIK_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEV_MIK_ALACAK=0';//devreden alacak
    end;
//****************************************************************************//
    SQLInsert := SQLInsert + ' WHERE URUN_KOD = '+SQL_Katar(qryUrunListe.FieldByName('URUN_KOD').AsString)+';';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryUrunListe.Next;
  end;
//****************************************************************************//
  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('UrunDev scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyCariDovToTerm: Boolean;
var
  qryCopyCariDov : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyCariDov,nil,False,DataMod.dbaMain);
  with qryCopyCariDov do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT');
    SQL.Add('CARI_KOD,DOVKOD');
    SQL.Add('FROM CARI_DOV');
    SQL.Add('ORDER BY CARI_KOD,DOVKOD');
    Open;
  end;
  if (qryCopyCariDov.Eof and qryCopyCariDov.Bof) then
  begin
    Result := False;
    Application.MessageBox('CARI_DOV tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyCariDov.First;
  while not qryCopyCariDov.Eof do
  begin
    SQLInsert := 'INSERT INTO CARI_DOV (CARI_KOD,DOVKOD) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyCariDov.FieldByName('CARI_KOD').AsString)+',';
//****************************************************************************//
    if qryCopyCariDov.FieldByName('DOVKOD').AsString = glb_DEFCUR then
       SQLInsert := SQLInsert + SQL_Katar('YTL')+');'
    else
      SQLInsert := SQLInsert + SQL_Katar(qryCopyCariDov.FieldByName('DOVKOD').AsString)+');';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyCariDov.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('CARI_DOV scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.UpdateTablesSetSifir(ScriptObj:TIB_Script;Cari,Urun,Masraf,Kasa,Proje,Plasiyer,Arac,Personel:Boolean): Boolean;
var
  SQLUpdateLst : TStringList;
begin
  SQLUpdateLst := TStringList.Create;
//****************************************************************************//
  if Cari then
  begin
    SQLUpdateLst.Add('UPDATE CARI SET DEVREDEN_BORC=0,DEVREDEN_ALACAK=0;');
  end;
//****************************************************************************//
  if Urun then
  begin
    SQLUpdateLst.Add('UPDATE URUN SET DEV_BORC=0,DEV_ALACAK=0,DEV_BORC_VPB=0,DEV_ALACAK_VPB=0,DEV_MIK_BORC=0,DEV_MIK_ALACAK=0;');
    SQLUpdateLst.Add('UPDATE DEPOURUN SET DEV_BORC=0,DEV_ALACAK=0,DEV_BORC_VPB=0,DEV_ALACAK_VPB=0,DEV_MIKTAR_BORC=0,DEV_MIKTAR_ALACAK=0;');
  end;
//****************************************************************************//
  if Masraf then
  begin
    SQLUpdateLst.Add('UPDATE MASRAF SET DEVREDEN_BORC=0,DEVREDEN_ALACAK=0;');
  end;
//****************************************************************************//
  if Kasa then
  begin
    SQLUpdateLst.Add('UPDATE KASA SET DEVREDEN_BORC=0,DEVREDEN_ALACAK=0,DEVREDEN_BORC_VPB=0,DEVREDEN_ALACAK_VPB=0;');
  end;
//****************************************************************************//
//  SQLUpdateLst.Add('UPDATE CARI_DOV SET DEVREDEN_BORC=0,DEVREDEN_ALACAK=0;');
  if Proje then
  begin
  SQLUpdateLst.Add('UPDATE PROJE SET DEVREDEN_BORC=0,DEVREDEN_ALACAK=0,DEVREDEN_BORC_VPB=0,DEVREDEN_ALACAK_VPB=0;');
  end;

  if Plasiyer then
  begin
  SQLUpdateLst.Add('UPDATE PLASIYER SET DEVREDEN_BORC=0,DEVREDEN_ALACAK=0,DEVREDEN_BORC_VPB=0,DEVREDEN_ALACAK_VPB=0;');
  end;

  if Arac then
  begin
  SQLUpdateLst.Add('UPDATE ARAC SET DEVREDEN_BORC=0,DEVREDEN_ALACAK=0;');
  end;

  if Personel then
  begin
  SQLUpdateLst.Add('UPDATE PERSONEL SET DEVREDEN_BORC=0,DEVREDEN_ALACAK=0;');
  end;

  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLUpdateLst);
  end;
//****************************************************************************//
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('UpdateTablesSetSifir scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLUpdateLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;



function TDmYonet.GEN_AYARLA(ScriptObj:TIB_Script;Qry:TIB_Query): Boolean;
var
  SQLUpdateLst : TStringList;
  Say:Integer;
begin
  SQLUpdateLst := TStringList.Create;
//****************************************************************************//
{
SET GENERATOR GEN_ANT_DETAIL TO 0;
SET GENERATOR GEN_ANT_MAIN TO 0;
SET GENERATOR GEN_ARACHAR TO 0;
SET GENERATOR GEN_CARIHAR TO 0;
SET GENERATOR GEN_CARIHAR_DOV TO 0;
SET GENERATOR GEN_CARI_SEVKID TO 0;
SET GENERATOR GEN_CEK TO 0;
SET GENERATOR GEN_CEKSENHAR TO 0;
SET GENERATOR GEN_CS_BORDRO TO 0;
SET GENERATOR GEN_DEKONT TO 0;
SET GENERATOR GEN_DEKONT_AUT TO 0;
SET GENERATOR GEN_DEKONT_D TO 0;
SET GENERATOR GEN_DEKONT_D_AUT TO 0;
SET GENERATOR GEN_FAT_IRS TO 0;
SET GENERATOR GEN_ISN TO 0;
SET GENERATOR GEN_KASAHAR TO 0;
SET GENERATOR GEN_KONT TO 0;
SET GENERATOR GEN_MASRAFHAR TO 0;
SET GENERATOR GEN_MAZOT TO 0;
SET GENERATOR GEN_PAKET TO 0;
SET GENERATOR GEN_PAKET_D TO 0;
SET GENERATOR GEN_PERSONELHAR TO 0;
SET GENERATOR GEN_PLASIYERHAR TO 0;
SET GENERATOR GEN_PROJEHAR TO 0;
SET GENERATOR GEN_SEFER TO 0;
SET GENERATOR GEN_SENET TO 0;
SET GENERATOR GEN_SIPARIS TO 0;
SET GENERATOR GEN_SIPARIS_D TO 0;
SET GENERATOR GEN_SIPARIS_D_FAT TO 0;
SET GENERATOR GEN_URUNHAR TO 0;
}

Qry.Close;
Qry.SQL.Text:='SELECT MAX(ANT_DETAIL_ID) AS GELEN FROM ANT_DETAIL';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;

    SQLUpdateLst.Add('SET GENERATOR GEN_ANT_DETAIL TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(ANT_MAIN_ID) AS GELEN FROM ANT_MAIN';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;

    SQLUpdateLst.Add('SET GENERATOR GEN_ANT_MAIN TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(ARACHAR_ID) AS GELEN FROM ARACHAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_ARACHAR TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(CARIHAR_ID) AS GELEN FROM CARIHAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_CARIHAR TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(CARIHAR_DOV_ID) AS GELEN FROM CARIHAR_DOV';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_CARIHAR_DOV TO '+Inttostr(Say)+';');

{Qry.Close;
Qry.SQL.Text:='SELECT MAX(CARIHAR_DOV_ID) AS GELEN FROM CARI_SEVKAD';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_CARI_SEVKID TO '+Inttostr(Say)+';'); }

Qry.Close;
Qry.SQL.Text:='SELECT MAX(CEK_ID) AS GELEN FROM CEK';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_CEK TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(CEKSENHAR_ID) AS GELEN FROM CEKSENHAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_CEKSENHAR TO '+Inttostr(Say)+';');

{Qry.Close;
Qry.SQL.Text:='SELECT MAX(CEKSENHAR_ID) AS GELEN FROM CEKSENHAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_CS_BORDRO TO '+Inttostr(Say)+';');  }

Qry.Close;
Qry.SQL.Text:='SELECT MAX(DEKONT_ID) AS GELEN FROM DEKONT';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_DEKONT TO '+Inttostr(Say)+';');

{Qry.Close;
Qry.SQL.Text:='SELECT MAX(DEKONT_ID) AS GELEN FROM DEKONT';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_DEKONT_AUT TO '+Inttostr(Say)+';');
}
Qry.Close;
Qry.SQL.Text:='SELECT MAX(DEKONT_D_ID) AS GELEN FROM DEKONT_D';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_DEKONT_D TO '+Inttostr(Say)+';');

{Qry.Close;
Qry.SQL.Text:='SELECT MAX(DEKONT_ID) AS GELEN FROM DEKONT';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_DEKONT_D_AUT TO '+Inttostr(Say)+';');
}

Qry.Close;
Qry.SQL.Text:='SELECT MAX(ISN) AS GELEN FROM ISN_ERRORS';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_ISN TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(KASAHAR_ID) AS GELEN FROM KASAHAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_KASAHAR TO '+Inttostr(Say)+';');

{Qry.Close;
Qry.SQL.Text:='SELECT MAX(KASAHAR_ID) AS GELEN FROM KASAHAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_KONT TO '+Inttostr(Say)+';');
    }

Qry.Close;
Qry.SQL.Text:='SELECT MAX(MASRAFHAR_ID) AS GELEN FROM MASRAFHAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_MASRAFHAR TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(MAZOT_FIS_ID) AS GELEN FROM MAZOT_FISI';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_MAZOT TO '+Inttostr(Say)+';');

{Qry.Close;
Qry.SQL.Text:='SELECT MAX(PAKET_D_ID) AS GELEN FROM PAKET_D';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_PAKET TO '+Inttostr(Say)+';');
}
Qry.Close;
Qry.SQL.Text:='SELECT MAX(PAKET_D_ID) AS GELEN FROM PAKET_D';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_PAKET_D TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(PERSONELHAR_ID) AS GELEN FROM PERSONEL_HAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_PERSONELHAR TO '+Inttostr(Say)+';');
{Qry.Close;
Qry.SQL.Text:='SELECT MAX(PERSONELHAR_ID) AS GELEN FROM PERSONEL_HAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_PLASIYERHAR TO '+Inttostr(Say)+';');
    }
Qry.Close;
Qry.SQL.Text:='SELECT MAX(PROJEHAR_ID) AS GELEN FROM PROJEHAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_PROJEHAR TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(SEFER_ID) AS GELEN FROM SEFER';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_SEFER TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(SENET_ID) AS GELEN FROM SENET';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_SENET TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(FAT_IRS_ID) AS GELEN FROM SIPARIS';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_SIPARIS TO '+Inttostr(Say)+';');

Qry.Close;
Qry.SQL.Text:='SELECT MAX(URUNHAR_ID) AS GELEN FROM URUNHAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_SIPARIS_D TO '+Inttostr(Say)+';');


Qry.Close;
Qry.SQL.Text:='SELECT MAX(SIPARIS_D_FAT_ID) AS GELEN FROM SIPARIS_D_FAT';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_SIPARIS_D_FAT TO '+Inttostr(Say)+';');



Qry.Close;
Qry.SQL.Text:='SELECT MAX(URUNHAR_ID) AS GELEN FROM URUNHAR';
Qry.Open;
Say:=Qry.FieldByName('GELEN').AsInteger;
    SQLUpdateLst.Add('SET GENERATOR GEN_URUNHAR TO '+Inttostr(Say)+';');





  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLUpdateLst);
  end;
//****************************************************************************//
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('Gen Ayarlama scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLUpdateLst);
    exit;
  end;
  
//****************************************************************************//
  Result := True;
end;



function TDmYonet.CopyCariDovDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection;CnHedef:TIB_Connection): Boolean;
var
  qryCopyCariDov : TIB_Cursor;
  qryUpdateCariDov : TIB_Query;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  dvr_total,SONUC : Currency;
begin
  DataMod.CreateCursor(qryCopyCariDov,nil,False,Cn);
  with qryCopyCariDov do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT');
    SQL.Add('CARI_DOV.CARI_KOD,CARI_DOV.DOVKOD,CARI_DOV.KREDILMT,CARI_DOV.RISK,CARI_DOV.BORC,CARI_DOV.ALACAK,CARI_DOV.DEVREDEN_BORC,CARI_DOV.DEVREDEN_ALACAK');
    SQL.Add('FROM CARI_DOV');
    SQL.Add('INNER JOIN CARI ON (CARI.CARI_KOD=CARI_DOV.CARI_KOD)');
    SQL.Add('WHERE CARI.TIP = 3');
    SQL.Add('ORDER BY CARI_DOV.CARI_KOD,CARI_DOV.DOVKOD');
    Open;
  end;
  if (qryCopyCariDov.Eof and qryCopyCariDov.Bof) then
  begin
    Result := True;
    Application.MessageBox('CARI_DOV tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.CreateQuery(qryUpdateCariDov,nil,False,CnHedef);
  SQLInsertLst := TStringList.Create;
  qryCopyCariDov.First;
  while not qryCopyCariDov.Eof do
  begin
    with qryUpdateCariDov do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE CARI_DOV SET DEVREDEN_BORC=0,DEVREDEN_ALACAK=0 WHERE CARI_KOD = '+SQL_Katar(qryCopyCariDov.FieldByName('CARI_KOD').AsString));
      SQL.Add('AND DOVKOD='+SQL_Katar(qryCopyCariDov.FieldByName('DOVKOD').AsString));
      Execute;
    end;
//****************************************************************************//
    SQLInsert := 'UPDATE CARI_DOV SET ';
//****************************************************************************//
    if qryCopyCariDov.FieldByName('KREDILMT').AsCurrency = 0 then
    begin
      SQLInsert := SQLInsert+'KREDILMT=0,';
    end
    else
    begin
      //DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',qryCopyCariDov.FieldByName('KREDILMT').AsCurrency,2,True,SONUC);
      SQLInsert := SQLInsert+'KREDILMT='+ SQL_Para(qryCopyCariDov.FieldByName('KREDILMT').AsCurrency)+',';;
    end;
//****************************************************************************//
    if qryCopyCariDov.FieldByName('RISK').AsCurrency = 0 then
    begin
      SQLInsert := SQLInsert+'RISK=0,';
    end
    else
    begin
//      DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',qryCopyCariDov.FieldByName('RISK').AsCurrency,2,True,SONUC);
      SQLInsert := SQLInsert+'RISK='+SQL_Para(qryCopyCariDov.FieldByName('RISK').AsCurrency)+',';
    end;
//****************************************************************************//
    if (qryCopyCariDov.FieldByName('BORC').AsCurrency   + qryCopyCariDov.FieldByName('DEVREDEN_BORC').AsCurrency)
    >  (qryCopyCariDov.FieldByName('ALACAK').AsCurrency + qryCopyCariDov.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyCariDov.FieldByName('BORC').AsCurrency   + qryCopyCariDov.FieldByName('DEVREDEN_BORC').AsCurrency) -
                   (qryCopyCariDov.FieldByName('ALACAK').AsCurrency + qryCopyCariDov.FieldByName('DEVREDEN_ALACAK').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      end
      else
      begin
//        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC='+SQL_Para(dvr_total)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end
    else
    if (qryCopyCariDov.FieldByName('BORC').AsCurrency   + qryCopyCariDov.FieldByName('DEVREDEN_BORC').AsCurrency)
    <  (qryCopyCariDov.FieldByName('ALACAK').AsCurrency + qryCopyCariDov.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyCariDov.FieldByName('ALACAK').AsCurrency + qryCopyCariDov.FieldByName('DEVREDEN_ALACAK').AsCurrency) -
                   (qryCopyCariDov.FieldByName('BORC').AsCurrency   + qryCopyCariDov.FieldByName('DEVREDEN_BORC').AsCurrency);
//****************************************************************************//
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
//****************************************************************************//
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
      end
      else
      begin
//        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK='+SQL_Para(dvr_total);//devreden alacak
      end;
//****************************************************************************//
    end
    else
    if (qryCopyCariDov.FieldByName('BORC').AsCurrency   + qryCopyCariDov.FieldByName('DEVREDEN_BORC').AsCurrency)
    =  (qryCopyCariDov.FieldByName('ALACAK').AsCurrency + qryCopyCariDov.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end;
//****************************************************************************//
    SQLInsert := SQLInsert + ' WHERE CARI_KOD='+SQL_Katar(qryCopyCariDov.FieldByName('CARI_KOD').AsString);
    SQLInsert := SQLInsert + ' AND DOVKOD='+SQL_Katar(qryCopyCariDov.FieldByName('DOVKOD').AsString)+';';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyCariDov.Next;
  end;
//****************************************************************************//
  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('CARI_DOVDEV scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;



function TDmYonet.CopyKasaDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection): Boolean;
var
  qryCopyKasa,qryKasaMuhFis : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  dvr_total,SONUC : Currency;
  genel_alacak,genel_borc : Currency;
begin
  DataMod.CreateCursor(qryCopyKasa,nil,False,Cn);
  DataMod.CreateCursor(qryKasaMuhFis,nil,False,Cn);
  with qryCopyKasa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT KASA_KOD,DOVKOD,BORC,ALACAK,BORC_VPB,ALACAK_VPB,DEVREDEN_BORC,DEVREDEN_ALACAK,DEVREDEN_BORC_VPB,DEVREDEN_ALACAK_VPB FROM KASA ORDER BY KASA_KOD');
    Open;
  end;
  if (qryCopyKasa.Eof and qryCopyKasa.Bof) then
  begin
    Result := True;
    Application.MessageBox('KASA tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyKasa.First;
  while not qryCopyKasa.Eof do
  begin
    SQLInsert := 'UPDATE KASA SET ';
//****************************************************************************//
    if (qryCopyKasa.FieldByName('BORC').AsCurrency   + qryCopyKasa.FieldByName('DEVREDEN_BORC').AsCurrency)
    >  (qryCopyKasa.FieldByName('ALACAK').AsCurrency + qryCopyKasa.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyKasa.FieldByName('BORC').AsCurrency   + qryCopyKasa.FieldByName('DEVREDEN_BORC').AsCurrency) -
                   (qryCopyKasa.FieldByName('ALACAK').AsCurrency + qryCopyKasa.FieldByName('DEVREDEN_ALACAK').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      end
      else
      begin
        if qryCopyKasa.FieldByName('DOVKOD').AsString = glb_DEFCUR then
        begin
          DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
          SQLInsert := SQLInsert+'DEVREDEN_BORC='+SQL_Para(SONUC)+',';//devreden borç
        end
        else
        begin
          SQLInsert := SQLInsert+'DEVREDEN_BORC='+SQL_Para(dvr_total)+',';
        end;
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end
    else
    if (qryCopyKasa.FieldByName('BORC').AsCurrency   + qryCopyKasa.FieldByName('DEVREDEN_BORC').AsCurrency)
    <  (qryCopyKasa.FieldByName('ALACAK').AsCurrency + qryCopyKasa.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      dvr_total := (qryCopyKasa.FieldByName('ALACAK').AsCurrency + qryCopyKasa.FieldByName('DEVREDEN_ALACAK').AsCurrency) -
                   (qryCopyKasa.FieldByName('BORC').AsCurrency   + qryCopyKasa.FieldByName('DEVREDEN_BORC').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
      end
      else
      begin
        if qryCopyKasa.FieldByName('DOVKOD').AsString = glb_DEFCUR then
        begin
          DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
          SQLInsert := SQLInsert+'DEVREDEN_ALACAK='+SQL_Para(SONUC)+'';//devreden alacak
        end
        else
        begin
          SQLInsert := SQLInsert+'DEVREDEN_ALACAK='+SQL_Para(dvr_total)+'';//devreden alacak
        end;
      end;
    end
    else
    if (qryCopyKasa.FieldByName('BORC').AsCurrency   + qryCopyKasa.FieldByName('DEVREDEN_BORC').AsCurrency)
    =  (qryCopyKasa.FieldByName('ALACAK').AsCurrency + qryCopyKasa.FieldByName('DEVREDEN_ALACAK').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end;
//****************************************************************************//
   {
    with qryKasaMuhFis do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT BA,SUM(TUTAR_VPB) AS TOPLAM FROM MUH_FIS');
      SQL.Add('WHERE ISLEM_TAR BETWEEN '+SQL_Tarih(glb_DONEM_BAS)+' AND '+SQL_Tarih(glb_DONEM_SON));
      SQL.Add('AND HESAP_KOD = '+SQL_Katar(qryCopyKasa.FieldByName('MUHASKOD').AsString));
      SQL.Add('GROUP BY BA');
      Open;
    end;

    if not (qryKasaMuhFis.eof and qryKasaMuhFis.bof) then
    begin
      qryKasaMuhFis.First;
      repeat
        if qryKasaMuhFis.FieldByName('BA').AsString = 'A' then
        begin
          genel_alacak := qryKasaMuhFis.FieldByName('TOPLAM').AsCurrency;
        end;

        if qryKasaMuhFis.FieldByName('BA').AsString = 'B' then
        begin
          genel_borc := qryKasaMuhFis.FieldByName('TOPLAM').AsCurrency;
        end;
        qryKasaMuhFis.Next;
      until qryKasaMuhFis.Eof;

      if genel_borc > genel_alacak then
      begin
        dvr_total := genel_borc - genel_alacak;
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB='+SQL_Para(SONUC)+',';
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';
      end
      else
      if genel_alacak > genel_borc then
      begin
        dvr_total := genel_alacak - genel_borc;
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB='+SQL_Para(SONUC);
      end
      else
      if genel_borc = genel_alacak then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
      end;
    end
    else
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
    end;
    }
    {
    if (qryCopyKasa.FieldByName('BORC_VPB').AsCurrency   + qryCopyKasa.FieldByName('DEVREDEN_BORC_VPB').AsCurrency)
    >  (qryCopyKasa.FieldByName('ALACAK_VPB').AsCurrency + qryCopyKasa.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyKasa.FieldByName('BORC_VPB').AsCurrency   + qryCopyKasa.FieldByName('DEVREDEN_BORC_VPB').AsCurrency) -
                   (qryCopyKasa.FieldByName('ALACAK_VPB').AsCurrency + qryCopyKasa.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency);
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB='+SQL_Para(SONUC)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
    end
    else
    if (qryCopyKasa.FieldByName('BORC_VPB').AsCurrency   + qryCopyKasa.FieldByName('DEVREDEN_BORC_VPB').AsCurrency)
    <  (qryCopyKasa.FieldByName('ALACAK_VPB').AsCurrency + qryCopyKasa.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      dvr_total := (qryCopyKasa.FieldByName('ALACAK_VPB').AsCurrency + qryCopyKasa.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) -
                   (qryCopyKasa.FieldByName('BORC_VPB').AsCurrency   + qryCopyKasa.FieldByName('DEVREDEN_BORC_VPB').AsCurrency);
      SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB='+SQL_Para(SONUC);//devreden alacak
      end;
    end
    else
    if (qryCopyKasa.FieldByName('BORC_VPB').AsCurrency   + qryCopyKasa.FieldByName('DEVREDEN_BORC_VPB').AsCurrency) =
       (qryCopyKasa.FieldByName('ALACAK_VPB').AsCurrency + qryCopyKasa.FieldByName('DEVREDEN_ALACAK_VPB').AsCurrency) then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC_VPB=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK_VPB=0';//devreden alacak
    end;
    }
//****************************************************************************//
    SQLInsert := SQLInsert + ' WHERE KASA_KOD='+SQL_Katar(qryCopyKasa.FieldByName('KASA_KOD').AsString)+';';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
    qryCopyKasa.Next;
  end;
//****************************************************************************//
  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('KasaDev scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;



function TDmYonet.CopyCariMuhfisDevToTerm(ScriptObj:TIB_Script;Cn:TIB_Connection): Boolean;
var
  qryCariListe : TIB_Cursor;
  qryCopyCari : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  dvr_total,SONUC : Currency;
  alacak,borc : Currency;
begin
  try
  DataMod.CreateCursor(qryCariListe,nil,False,Cn);
  with qryCariListe do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT');
    SQL.Add('CARI_KOD,KREDILMT,RISK,BORC,ALACAK,DEVREDEN_BORC,DEVREDEN_ALACAK');
    SQL.Add('FROM CARI');
    SQL.Add('ORDER BY CARI_KOD');
    Open;
  end;

  if (qryCariListe.Eof and qryCariListe.Bof) then
  begin
    Result := True;
    Application.MessageBox('CARI tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
   //Application.MessageBox('Cari sorgulama bitti.','Dikkat',MB_ICONERROR);
//  DataMod.CreateCursor(qryCopyCari,nil,False,Cn);
  SQLInsertLst := TStringList.Create;
  qryCariListe.First;
  while not qryCariListe.Eof do
  begin
         //Application.MessageBox('Cari döngübas.','Dikkat',MB_ICONERROR);
    SQLInsert := 'UPDATE CARI SET ';
//****************************************************************************//
    if qryCariListe.FieldByName('KREDILMT').AsCurrency = 0 then
    begin
      SQLInsert := SQLInsert + 'KREDILMT=0,';
    end
    else
    begin
      DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',qryCariListe.FieldByName('KREDILMT').AsCurrency,2,True,SONUC);
      SQLInsert := SQLInsert + 'KREDILMT='+ SQL_Para(SONUC)+',';
    end;
//****************************************************************************//
    if qryCariListe.FieldByName('RISK').AsCurrency = 0 then
    begin
      SQLInsert := SQLInsert + 'RISK=0,';
    end
    else
    begin
      DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',qryCariListe.FieldByName('RISK').AsCurrency,2,True,SONUC);
      SQLInsert := SQLInsert + 'RISK=' + SQL_Para(SONUC)+',';
    end;
//****************************************************************************//
  {  with qryCopyCari do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT BA,SUM(TUTAR_VPB) AS TOPLAM FROM MUH_FIS');
//      SQL.Add('WHERE ISLEM_TAR >='+SQL_Katar('01.01.2004')+' AND ISLEM_TAR <= '+SQL_Katar('31.12.2004'));
//      SQL.Add('AND HESAP_KOD = '+SQL_Katar(qryCariListe.FieldByName('MUHASKOD').AsString));
      SQL.Add('GROUP BY BA');
      Open;
    end;
    }
//****************************************************************************//
    alacak := 0;
    borc := 0;
{      if qryCopyCari.FieldByName('BA').AsString = 'A' then
      begin
        alacak := qryCopyCari.FieldByName('TOPLAM').AsCurrency;
      end
      else
      if qryCopyCari.FieldByName('BA').AsString = 'B' then
      begin
        borc := qryCopyCari.FieldByName('TOPLAM').AsCurrency;
      end;
      qryCopyCari.Next;
    end;
}

    borc := qryCariListe.FieldByName('DEVREDEN_BORC').AsCurrency + qryCariListe.FieldByName('BORC').AsCurrency;
    alacak := qryCariListe.FieldByName('DEVREDEN_ALACAK').AsCurrency + qryCariListe.FieldByName('ALACAK').AsCurrency;


    if borc > alacak then
    begin
      dvr_total := borc - alacak;
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_BORC='+SQL_Para(SONUC)+',';//devreden borç
      end;
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end
    else
    if alacak > borc then
    begin
      dvr_total := alacak - borc;
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      if dvr_total = 0 then
      begin
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0,';//devreden alacak
      end
      else
      begin
        DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',dvr_total,2,True,SONUC);
        SQLInsert := SQLInsert+'DEVREDEN_ALACAK='+SQL_Para(SONUC);//devreden alacak
      end;
    end
    else
    if borc = alacak then
    begin
      SQLInsert := SQLInsert+'DEVREDEN_BORC=0,';//devreden borç
      SQLInsert := SQLInsert+'DEVREDEN_ALACAK=0';//devreden alacak
    end;
//****************************************************************************//
    SQLInsert := SQLInsert + ' WHERE CARI_KOD = '+SQL_Katar(qryCariListe.FieldByName('CARI_KOD').AsString)+';';
//****************************************************************************//
    SQLInsertLst.Add(SQLInsert);
       //Application.MessageBox('Cari 1 kayýt.','Dikkat',MB_ICONERROR);
    qryCariListe.Next;
  end;
//****************************************************************************//
  with ScriptObj do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptObj.Execute;
  except
    Result := False;
    Application.MessageBox('CopyCariMuhfisDevToTerm scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    Sirali_Calistir(Nil,Nil,SQLInsertLst);
    exit;
  end;
  except
Application.MessageBox('CopyCariMuhfisDevToTerm scriptinin1 çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
  end;
//****************************************************************************//
  Result := True;
end;





















function TDmYonet.CopyAracToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '   ARAC_KOD '+
    ' , ARAC_SID '+
    ' , PLAKA '+
    ' , ARAC_TIP '+
    ' , OZ_MAL '+
    ' , AKTIF_DEGIL '+
    ' , BORC '+
    ' , ALACAK '+
    ' , DEVREDEN_BORC '+
    ' , DEVREDEN_ALACAK '+
    ' , CARI_KOD '+
    ' , ACIKLAMA '+
    ' , YAKIT_LITRE '+
    ' , TRF_SIG_GEC_TAR '+
    ' , KASKO_SIG_GEC_TAR '+
    ' , PERSONEL_KOD '+
    ' , DORSE_KOD '+
    ' , AS_ADISOYADI '+
    ' , AS_DOGUM_YERI '+
    ' , AS_NUFUS_IL '+
    ' , AS_NUFUS_ILCE '+
    ' , AS_DOGUM_TARIHI '+
    ' , AS_IKA_ADRES '+
    ' , AS_SERI_NO '+
    ' , AS_MUYANE_GECERLILIK_SUR '+
    ' , RESIM '+
    ' , AS_IKA_ADRES1 '+
    ' , AS_TEL1 '+
    ' , AS_TEL2 '+
    ' , KARA_LISTE '+

    ' FROM ARAC ORDER BY ARAC_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('ARAC tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO ARAC ( '+

    '   ARAC_KOD '+
    ' , ARAC_SID '+
    ' , PLAKA '+
    ' , ARAC_TIP '+
    ' , OZ_MAL '+
    ' , AKTIF_DEGIL '+
   { ' , BORC '+
    ' , ALACAK '+
    ' , DEVREDEN_BORC '+
    ' , DEVREDEN_ALACAK '+
   } ' , CARI_KOD '+
    ' , ACIKLAMA '+
    ' , YAKIT_LITRE '+
    ' , TRF_SIG_GEC_TAR '+
    ' , KASKO_SIG_GEC_TAR '+
    ' , PERSONEL_KOD '+
    ' , DORSE_KOD '+
    ' , AS_ADISOYADI '+
    ' , AS_DOGUM_YERI '+
    ' , AS_NUFUS_IL '+
    ' , AS_NUFUS_ILCE '+
    ' , AS_DOGUM_TARIHI '+
    ' , AS_IKA_ADRES '+
    ' , AS_SERI_NO '+
    ' , AS_MUYANE_GECERLILIK_SUR '+
    ' , RESIM '+
    ' , AS_IKA_ADRES1 '+
    ' , AS_TEL1 '+
    ' , AS_TEL2 '+
    ' , KARA_LISTE '+

    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ARAC_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ARAC_SID').AsString+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('PLAKA').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ARAC_TIP').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('OZ_MAL').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('AKTIF_DEGIL').AsString+',';
  {  SQLInsert := SQLInsert + qryCopyPaket.FieldByName('BORC').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ALACAK').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('DEVREDEN_BORC').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('DEVREDEN_ALACAK').AsString+',';
    }
//****************************************************************************//
    if qryCopyPaket.FieldByName('CARI_KOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('CARI_KOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ACIKLAMA').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('YAKIT_LITRE').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('YAKIT_LITRE').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TRF_SIG_GEC_TAR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TRF_SIG_GEC_TAR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('KASKO_SIG_GEC_TAR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('KASKO_SIG_GEC_TAR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('PERSONEL_KOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('PERSONEL_KOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('DORSE_KOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('DORSE_KOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_ADISOYADI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_ADISOYADI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_DOGUM_YERI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_DOGUM_YERI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_NUFUS_IL').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_NUFUS_IL').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_NUFUS_ILCE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_NUFUS_ILCE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_DOGUM_TARIHI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_DOGUM_TARIHI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_IKA_ADRES').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_IKA_ADRES').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_SERI_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_SERI_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_MUYANE_GECERLILIK_SUR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_MUYANE_GECERLILIK_SUR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('RESIM').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('RESIM').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_IKA_ADRES1').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_IKA_ADRES1').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_TEL1').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_TEL1').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_TEL2').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_TEL2').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('KARA_LISTE').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('KARA_LISTE').AsString+');'
    else
       SQLInsert := SQLInsert + 'NULL);';

//****************************************************************************//

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
  //SQLInsertLst.SaveToFile('c:\aracscr.txt');
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Arac scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;







function TDmYonet.CopyAracRuhsatToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '  ARAC_KOD '+
    ' , ARAC_SID '+
    ' , ARAZI '+
    ' , IMALATCI_YERLI '+
    ' , YUK_TASIMA '+
    ' , ROMORK_TAKMA '+
    ' , TAKSIMETRE '+
    ' , TAKOMETRE '+
    ' , NET_AGIRLIK '+
    ' , IL '+
    ' , ILCE '+
    ' , TESCIL_SIRA_NO '+
    ' , TESCIL_TARIHI '+
    ' , PLAKA_NO '+
    ' , MARKASI '+
    ' , MODELI '+
    ' , CINSI '+
    ' , TIPI '+
    ' , RENGI '+
    ' , MOTOR_NO '+
    ' , SASI_NO '+
    ' , RUHSAT_BILGILERI '+
    ' , SILINDIR_HACMI '+
    ' , MOTOR_GUCU '+
    ' , ISTIAP_HADDI '+
    ' , KISI '+
    ' , KULLANIM_TIPI '+
    ' , YAKIT_TIPI '+
    ' , KATAR_AGIRLIGI '+
    ' , ROMORK_ISTIAPHAD '+
    ' , MUYANE_GECERLILIK_SUR '+
    ' , ONAYLAYAN_SICIL '+
    ' , SERI_G_NO '+

         ' FROM ARAC_RUHSAT ORDER BY ARAC_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('Arac Ruhsat tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO ARAC_RUHSAT ( '+

    '  ARAC_KOD '+
    ' , ARAC_SID '+
    ' , ARAZI '+
    ' , IMALATCI_YERLI '+
    ' , YUK_TASIMA '+
    ' , ROMORK_TAKMA '+
    ' , TAKSIMETRE '+
    ' , TAKOMETRE '+
    ' , NET_AGIRLIK '+
    ' , IL '+
    ' , ILCE '+
    ' , TESCIL_SIRA_NO '+
    ' , TESCIL_TARIHI '+
    ' , PLAKA_NO '+
    ' , MARKASI '+
    ' , MODELI '+
    ' , CINSI '+
    ' , TIPI '+
    ' , RENGI '+
    ' , MOTOR_NO '+
    ' , SASI_NO '+
    ' , RUHSAT_BILGILERI '+
    ' , SILINDIR_HACMI '+
    ' , MOTOR_GUCU '+
    ' , ISTIAP_HADDI '+
    ' , KISI '+
    ' , KULLANIM_TIPI '+
    ' , YAKIT_TIPI '+
    ' , KATAR_AGIRLIGI '+
    ' , ROMORK_ISTIAPHAD '+
    ' , MUYANE_GECERLILIK_SUR '+
    ' , ONAYLAYAN_SICIL '+
    ' , SERI_G_NO '+

    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ARAC_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ARAC_SID').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ARAZI').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('IMALATCI_YERLI').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('YUK_TASIMA').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ROMORK_TAKMA').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('TAKSIMETRE').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('TAKOMETRE').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('NET_AGIRLIK').AsString+',';

//****************************************************************************//
    if qryCopyPaket.FieldByName('IL').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('IL').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ILCE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ILCE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TESCIL_SIRA_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TESCIL_SIRA_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TESCIL_TARIHI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TESCIL_TARIHI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('PLAKA_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('PLAKA_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('MARKASI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('MARKASI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('MODELI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('MODELI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('CINSI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('CINSI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TIPI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TIPI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('RENGI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('RENGI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('MOTOR_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('MOTOR_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('SASI_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('SASI_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('RUHSAT_BILGILERI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('RUHSAT_BILGILERI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('SILINDIR_HACMI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('SILINDIR_HACMI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('MOTOR_GUCU').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('MOTOR_GUCU').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ISTIAP_HADDI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ISTIAP_HADDI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('KISI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('KISI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('KULLANIM_TIPI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('KULLANIM_TIPI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('YAKIT_TIPI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('YAKIT_TIPI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('KATAR_AGIRLIGI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('KATAR_AGIRLIGI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
       
    if qryCopyPaket.FieldByName('ROMORK_ISTIAPHAD').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ROMORK_ISTIAPHAD').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('MUYANE_GECERLILIK_SUR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('MUYANE_GECERLILIK_SUR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ONAYLAYAN_SICIL').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ONAYLAYAN_SICIL').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';


    if qryCopyPaket.FieldByName('SERI_G_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('SERI_G_NO').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';

//****************************************************************************//

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    //SQLInsertLst.SaveToFile('c:\aracrhs.txt');
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Arac Ruhsat scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopyPersonelToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '   PERSONEL_KOD '+
    ' , PERSONEL_SID '+
    ' , LISTEDEN_CIKAR '+
    ' , BORC '+
    ' , ALACAK '+
    ' , DEVREDEN_BORC '+
    ' , DEVREDEN_ALACAK '+
    ' , ADI_SOYADI '+
    ' , SICIL_NO '+
    ' , SSK_NO '+
    ' , GIRIS_TARIH '+
    ' , CIKIC_TARIH '+
    ' , DOGUM_TARIH '+
    ' , DOGUM_YER '+
    ' , CINSIYET '+
    ' , TAHSIL '+
    ' , EVLI '+
    ' , GOREVI '+
    ' , VERGI_NO '+
    ' , VERGI_DAIRE '+
    ' , VERGI_KARNE_TARIH '+
    ' , TEL_NO '+
         ' FROM PERSONEL ORDER BY PERSONEL_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('Personel tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO PERSONEL ( '+
    '   PERSONEL_KOD '+
    ' , PERSONEL_SID '+
    ' , LISTEDEN_CIKAR '+
   { ' , BORC '+
    ' , ALACAK '+
    ' , DEVREDEN_BORC '+
    ' , DEVREDEN_ALACAK '+
   }
    ' , ADI_SOYADI '+
    ' , SICIL_NO '+
    ' , SSK_NO '+
    ' , GIRIS_TARIH '+
    ' , CIKIC_TARIH '+
    ' , DOGUM_TARIH '+
    ' , DOGUM_YER '+
    ' , CINSIYET '+
    ' , TAHSIL '+
    ' , EVLI '+
    ' , GOREVI '+
    ' , VERGI_NO '+
    ' , VERGI_DAIRE '+
    ' , VERGI_KARNE_TARIH '+
    ' , TEL_NO '+

    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('PERSONEL_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('PERSONEL_SID').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('LISTEDEN_CIKAR').AsString+',';
{    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('BORC').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ALACAK').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('DEVREDEN_BORC').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('DEVREDEN_ALACAK').AsString+',';
}
//****************************************************************************//
    if qryCopyPaket.FieldByName('ADI_SOYADI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ADI_SOYADI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('SICIL_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('SICIL_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('SSK_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('SSK_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('GIRIS_TARIH').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GIRIS_TARIH').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('CIKIC_TARIH').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('CIKIC_TARIH').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('DOGUM_TARIH').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('DOGUM_TARIH').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('DOGUM_YER').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('DOGUM_YER').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('CINSIYET').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('CINSIYET').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TAHSIL').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TAHSIL').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('EVLI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('EVLI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('GOREVI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GOREVI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('VERGI_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('VERGI_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('VERGI_DAIRE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('VERGI_DAIRE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('VERGI_KARNE_TARIH').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('VERGI_KARNE_TARIH').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TEL_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TEL_NO').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';

//****************************************************************************//

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
   // SQLInsertLst.SaveToFile('c:\persscr.txt');
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Personel scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;




function TDmYonet.CopySoforToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '   SOFOR_KOD '+
    ' , SOFOR_SID '+
    ' , LISTEDEN_CIKAR '+
    ' , BORC '+
    ' , ALACAK '+
    ' , DEVREDEN_BORC '+
    ' , DEVREDEN_ALACAK '+
    ' , ADI_SOYADI '+
    ' , ADRESI1 '+
    ' , ADRESI2 '+
    ' , TEL_NO1 '+
    ' , TEL_NO2 '+
    ' , EHLIYET_NO '+
    ' , VERGI_DAIRE '+
    ' , VERGI_NO '+
    ' , ACIKLAMA '+
    ' , RESIM '+
    ' , KARA_LISTE '+
    ' FROM SOFOR ORDER BY SOFOR_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('Þoför tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO SOFOR ( '+
    '   SOFOR_KOD '+
    ' , SOFOR_SID '+
    ' , LISTEDEN_CIKAR '+
  {  ' , BORC '+
    ' , ALACAK '+
    ' , DEVREDEN_BORC '+
    ' , DEVREDEN_ALACAK '+
   } ' , ADI_SOYADI '+
    ' , ADRESI1 '+
    ' , ADRESI2 '+
    ' , TEL_NO1 '+
    ' , TEL_NO2 '+
    ' , EHLIYET_NO '+
    ' , VERGI_DAIRE '+
    ' , VERGI_NO '+
    ' , ACIKLAMA '+
    ' , RESIM '+
    ' , KARA_LISTE '+

    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('SOFOR_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('SOFOR_SID').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('LISTEDEN_CIKAR').AsString+',';
 {   SQLInsert := SQLInsert + qryCopyPaket.FieldByName('BORC').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ALACAK').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('DEVREDEN_BORC').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('DEVREDEN_ALACAK').AsString+',';
   }
//****************************************************************************//
    if qryCopyPaket.FieldByName('ADI_SOYADI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ADI_SOYADI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ADRESI1').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ADRESI1').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ADRESI2').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ADRESI2').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TEL_NO1').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TEL_NO1').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TEL_NO2').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TEL_NO2').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('EHLIYET_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('EHLIYET_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('VERGI_DAIRE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('VERGI_DAIRE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('VERGI_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('VERGI_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ACIKLAMA').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('RESIM').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('RESIM').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('KARA_LISTE').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('KARA_LISTE').AsString+');'
    else
       SQLInsert := SQLInsert + 'NULL);';

//****************************************************************************//

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Þöför scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;






function TDmYonet.CopyBayiToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '  BAYI_KOD '+
    ' , BAYI_SID '+
    ' , BAYI_ADI '+

    ' FROM SRV_ARAC_BAYI ORDER BY BAYI_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('Bayi tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO SRV_ARAC_BAYI ( '+

    '  BAYI_KOD '+
    ' , BAYI_SID '+
    ' , BAYI_ADI '+
    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('BAYI_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('BAYI_SID').AsString+',';
//****************************************************************************//
    if qryCopyPaket.FieldByName('BAYI_ADI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('BAYI_ADI').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';


//****************************************************************************//

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Bayi scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;


function TDmYonet.CopyMarkaToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '  MARKA_KOD '+
    ' , MARKA_SID '+
    ' FROM SRV_ARAC_MARKA ORDER BY MARKA_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('Araç Marka tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO SRV_ARAC_MARKA ( '+
    '  MARKA_KOD '+
    ' , MARKA_SID '+
    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('MARKA_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('MARKA_SID').AsString+');';

//****************************************************************************//

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Araç Marka scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;




function TDmYonet.CopyMarkaTipToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '  MARKA_TIP_KOD '+
    ' , MARKA_TIP_SID '+
    ' , MARKA_KOD '+
    ' , ACIKLAMA '+
    ' FROM SRV_ARAC_MARKA_TIP ORDER BY MARKA_KOD,MARKA_TIP_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('Marka Tipi tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO SRV_ARAC_MARKA_TIP ( '+
    '  MARKA_TIP_KOD '+
    ' , MARKA_TIP_SID '+
    ' , MARKA_KOD '+
    ' , ACIKLAMA '+
    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('MARKA_TIP_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('MARKA_TIP_SID').AsString+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('MARKA_KOD').AsString)+',';
//****************************************************************************//
    if qryCopyPaket.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ACIKLAMA').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';


//****************************************************************************//

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Marka Tipi scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;

function TDmYonet.CopySigortaToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '  SIGORTA_KOD '+
    ' , SIGORTA_SID '+
    ' , ADI '+
    ' , TEL '+
    ' , ILGILI_KISI '+
    ' FROM SRV_ARAC_SIGORTA  ORDER BY SIGORTA_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('Sigorta Þirketi tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO SRV_ARAC_SIGORTA ( '+
    '  SIGORTA_KOD '+
    ' , SIGORTA_SID '+
    ' , ADI '+
    ' , TEL '+
    ' , ILGILI_KISI '+
    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('SIGORTA_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('SIGORTA_SID').AsString+',';

//****************************************************************************//
    if qryCopyPaket.FieldByName('ADI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ADI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TEL').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TEL').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ILGILI_KISI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ILGILI_KISI').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';


//****************************************************************************//

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Sigorta Þirketi scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;



function TDmYonet.CopyArizaTipToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '  ARIZA_KOD '+
    ' , ARIZA_SID '+
    ' , ACIKLAMA '+
    ' FROM SRV_ARIZA_TIP ORDER BY ARIZA_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('Arýza Tipi tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO SRV_ARIZA_TIP ( '+
    '  ARIZA_KOD '+
    ' , ARIZA_SID '+
    ' , ACIKLAMA '+
    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ARIZA_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ARIZA_SID').AsString+',';
//****************************************************************************//
    if qryCopyPaket.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ACIKLAMA').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';


//****************************************************************************//

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Arýza Tipi scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;




function TDmYonet.CopyGelisNedenTipToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '  NEDEN_KOD '+
    ' , NEDEN_SID '+
    ' , ACIKLAMA '+
    ' FROM SRV_GELIS_NEDENI ORDER BY NEDEN_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('Geliþ Nedeni tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO SRV_GELIS_NEDENI ( '+
    '  NEDEN_KOD '+
    ' , NEDEN_SID '+
    ' , ACIKLAMA '+
    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('NEDEN_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('NEDEN_SID').AsString+',';
//****************************************************************************//
    if qryCopyPaket.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ACIKLAMA').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';


//****************************************************************************//

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Geliþ Nedeni scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;





function TDmYonet.CopyEsyaToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '  ESYA_ID '+
    ' , ESYA_AD '+
    ' FROM ESYA ORDER BY ESYA_ID');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('Esya tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO ESYA ( '+
    '  ESYA_ID '+
    ' , ESYA_AD '+
    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ESYA_ID').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ESYA_AD').AsString)+');';


    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Esya scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;




function TDmYonet.Antrep: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  qryrun : TIB_Query;
  SQLInsert : String;
  SQLInsertLst : TStringList;
  idk:Integer;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
//  DataMod.CreateQuery(qryrun,Trn_Scrt,False,dbaCreate);
  DataMod.CreateQuery(qryrun,nil,False,dbaCreate);
  try
 qryrun.Close;
 qryrun.SQL.Text:='alter trigger ant_main_ai0 inactive;';
 qryrun.Execute;

 qryrun.Close;
 qryrun.SQL.Text:='alter trigger ant_main_au0 inactive;';
 qryrun.Execute;

 qryrun.Close;
 qryrun.SQL.Text:='alter trigger ant_main_ad0 inactive;';
 qryrun.Execute;

//Trn_Scrt.CommitRetaining;





  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add(
'SELECT ' +
    'ANT_MAIN.ANT_MAIN_ID as ANT_MAIN_IDA, '+
    'ANT_MAIN_SID, '+
    'DEVIR, '+
    'DEF_SIRA_NO, '+
    'TARIH, '+
    'GIRCIK, '+
    'TASIYAN, '+
    'TASIYAN_ID, '+
    'OZET_BEYAN_NO, '+
    'OZET_BEYAN_TAR, '+
    'ANT_MAIN.KONSIMENTO as KONSIMENTOA, '+
    'GIRIS_ANT_DETAIL_ID, '+
    'CIK_KAP, '+
    'CIK_KILO, '+
    'FATURA_ID, '+
    'GUM_VEZ_NO, '+
    'GUM_VEZ_TAR, '+
    'KAP_BOL, '+
    'GUM_KOM_KOD, '+


    'ANT_DETAIL_ID, '+
    'ANT_DETAIL.ANT_MAIN_ID as ANT_MAIN_IDD, '+
    'ANT_BEYAN_NO, '+
    'ANT_BEYAN_TAR, '+
    'ANT_DETAIL.KONSIMENTO as KONSIMENTOD, '+
    'CARI_AD, '+
    'CARI_KOD, '+
    'KAP_ADET, '+
    'KILO, '+
    'ESYA, '+
    'YANICI, '+
    'ARDIYE_FIY, '+
    'ARD_DOVKOD, '+
    'HAMMALIYE, '+
    'HAMM_DOVKOD, '+
    'KALAN_KAP, '+
    'KALAN_KILO '+

'FROM ANT_DETAIL '+
'INNER JOIN ANT_MAIN ON (ANT_DETAIL.ANT_MAIN_ID = ANT_MAIN.ANT_MAIN_ID) '+
'WHERE ant_detail.kalan_kap > 0');


    Open;
  end;


  
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('AntRep tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;

  idk:=0;
  while not qryCopyPaket.Eof do
  begin

      SQLInsert := 'INSERT INTO ANT_MAIN ( '+
    'ANT_MAIN_ID, '+
    'ANT_MAIN_SID, '+
    'DEVIR, '+
    'DEF_SIRA_NO, '+
    'TARIH, '+
    'GIRCIK, '+
    'TASIYAN, '+
    'TASIYAN_ID, '+
    'OZET_BEYAN_NO, '+
    'OZET_BEYAN_TAR, '+
    'KONSIMENTO, '+
    'GIRIS_ANT_DETAIL_ID, '+
    'CIK_KAP, '+
    'CIK_KILO, '+
    'FATURA_ID, '+
    'GUM_VEZ_NO, '+
    'GUM_VEZ_TAR, '+
    'KAP_BOL, '+
    'GUM_KOM_KOD '+
    ' ) VALUES (';


{    if qryCopyPaket.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ACIKLAMA').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';
 }

    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ANT_MAIN_IDA').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ANT_MAIN_SID').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('DEVIR').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('DEF_SIRA_NO').AsString)+',';

    if qryCopyPaket.FieldByName('TARIH').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TARIH').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';


    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GIRCIK').AsString)+',';

    if qryCopyPaket.FieldByName('TASIYAN').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TASIYAN').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TASIYAN_ID').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TASIYAN_ID').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('OZET_BEYAN_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('OZET_BEYAN_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('OZET_BEYAN_TAR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('OZET_BEYAN_TAR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('KONSIMENTOA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('KONSIMENTOA').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';




    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GIRIS_ANT_DETAIL_ID').AsString)+',';

    if qryCopyPaket.FieldByName('CIK_KAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('CIK_KAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';



    SQLInsert := SQLInsert + SQL_Para(qryCopyPaket.FieldByName('CIK_KILO').AsCurrency)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('FATURA_ID').AsString)+',';

    if qryCopyPaket.FieldByName('GUM_VEZ_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GUM_VEZ_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('GUM_VEZ_TAR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GUM_VEZ_TAR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';


    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('KAP_BOL').AsString)+',';

    if qryCopyPaket.FieldByName('GUM_KOM_KOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GUM_KOM_KOD').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';

   // SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GUM_KOM_KOD').AsString)+');';


    if idk<> qryCopyPaket.FieldByName('ANT_MAIN_IDA').AsInteger then

    SQLInsertLst.Add(SQLInsert);

   idk:=qryCopyPaket.FieldByName('ANT_MAIN_IDA').AsInteger;




      SQLInsert := 'INSERT INTO ANT_DETAIL ( '+
    'ANT_DETAIL_ID, '+
    'ANT_MAIN_ID, '+
    'ANT_BEYAN_NO, '+
    'ANT_BEYAN_TAR, '+
    'KONSIMENTO, '+
    'CARI_AD, '+
    'CARI_KOD, '+
    'KAP_ADET, '+
    'KILO, '+
    'ESYA, '+
    'YANICI, '+
    'ARDIYE_FIY, '+
    'ARD_DOVKOD, '+
    'HAMMALIYE, '+
    'HAMM_DOVKOD, '+
    'KALAN_KAP, '+
    'KALAN_KILO '+

    ' ) VALUES (';

    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ANT_DETAIL_ID').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ANT_MAIN_IDD').AsString)+',';

    if qryCopyPaket.FieldByName('ANT_BEYAN_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ANT_BEYAN_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ANT_BEYAN_TAR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ANT_BEYAN_TAR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';


    if qryCopyPaket.FieldByName('KONSIMENTOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('KONSIMENTOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';


    if qryCopyPaket.FieldByName('CARI_AD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('CARI_AD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('CARI_KOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('CARI_KOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('KAP_ADET').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('KAP_ADET').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';



    SQLInsert := SQLInsert + SQL_Para(qryCopyPaket.FieldByName('KILO').AsCurrency)+',';

    if qryCopyPaket.FieldByName('ESYA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ESYA').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';


    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('YANICI').AsString)+',';
    SQLInsert := SQLInsert + SQL_Para(qryCopyPaket.FieldByName('ARDIYE_FIY').AsCurrency)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ARD_DOVKOD').AsString)+',';
    SQLInsert := SQLInsert + SQL_Para(qryCopyPaket.FieldByName('HAMMALIYE').AsCurrency)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('HAMM_DOVKOD').AsString)+',';


    if qryCopyPaket.FieldByName('KALAN_KAP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('KALAN_KAP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

//    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('KALAN_KAP').AsString)+',';
    SQLInsert := SQLInsert + SQL_Para(qryCopyPaket.FieldByName('KALAN_KILO').AsCurrency)+');';

    SQLInsertLst.Add(SQLInsert);


    qryCopyPaket.Next;
  end;
//****************************************************************************//


  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add(

'SELECT ANT_MAIN.* '+
'FROM ANT_MAIN '+
'INNER JOIN ANT_DETAIL ON (ANT_MAIN.GIRIS_ANT_DETAIL_ID = ANT_DETAIL.ANT_DETAIL_ID) '+
'WHERE ANT_MAIN.GIRIS_ANT_DETAIL_ID in (SELECT ANT_DETAIL.ANT_DETAIL_ID '+
'FROM ANT_DETAIL '+
'INNER JOIN ANT_MAIN ON (ANT_DETAIL.ANT_MAIN_ID = ANT_MAIN.ANT_MAIN_ID) '+
'WHERE ant_detail.kalan_kap > 0)'
);


    Open;
  end;



  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin

      SQLInsert := 'INSERT INTO ANT_MAIN ( '+
    'ANT_MAIN_ID, '+
    'ANT_MAIN_SID, '+
    'DEVIR, '+
    'DEF_SIRA_NO, '+
    'TARIH, '+
    'GIRCIK, '+
    'TASIYAN, '+
    'TASIYAN_ID, '+
    'OZET_BEYAN_NO, '+
    'OZET_BEYAN_TAR, '+
    'KONSIMENTO, '+
    'GIRIS_ANT_DETAIL_ID, '+
    'CIK_KAP, '+
    'CIK_KILO, '+
    'FATURA_ID, '+
    'GUM_VEZ_NO, '+
    'GUM_VEZ_TAR, '+
    'KAP_BOL, '+
    'GUM_KOM_KOD '+
    ' ) VALUES (';


    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ANT_MAIN_ID').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ANT_MAIN_SID').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('DEVIR').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('DEF_SIRA_NO').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TARIH').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GIRCIK').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TASIYAN').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TASIYAN_ID').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('OZET_BEYAN_NO').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('OZET_BEYAN_TAR').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('KONSIMENTO').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GIRIS_ANT_DETAIL_ID').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('CIK_KAP').AsString)+',';
    SQLInsert := SQLInsert + SQL_Para(qryCopyPaket.FieldByName('CIK_KILO').AsCurrency)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('FATURA_ID').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GUM_VEZ_NO').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GUM_VEZ_TAR').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('KAP_BOL').AsString)+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('GUM_KOM_KOD').AsString)+');';
    SQLInsertLst.Add(SQLInsert);

    qryCopyPaket.Next;

  end;



SQLInsert := 'DELETE FROM SAYACLAR WHERE SAYAC_ADI='+SQL_Katar('ANT_GIR_CIK_SN')+';';
    SQLInsertLst.Add(SQLInsert);
SQLInsert :=  'DELETE FROM SAYACLAR WHERE SAYAC_ADI='+SQL_Katar('ANT_GIR_DEF_SN')+';';
    SQLInsertLst.Add(SQLInsert);

    
SQLInsert := 'DELETE FROM SAYACLAR_NU WHERE SAYAC_ADI='+SQL_Katar('ANT_GIR_CIK_SN')+';';
    SQLInsertLst.Add(SQLInsert);
SQLInsert :=  'DELETE FROM SAYACLAR_NU WHERE SAYAC_ADI='+SQL_Katar('ANT_GIR_DEF_SN')+';';
    SQLInsertLst.Add(SQLInsert);

SQLInsert :=  'UPDATE ANT_MAIN SET ANT_MAIN.DEVIR = 1;';
    SQLInsertLst.Add(SQLInsert);

 //  SQLInsertLst.SaveToFile('antsc.Txt');

  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  if frmBakiyeDevret<>Nil then
  frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
  try
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('AntRep scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  finally

 qryrun.Close;
 qryrun.SQL.Text:='alter trigger ant_main_ai0 active;';
 qryrun.ExecSQL;

 qryrun.Close;
 qryrun.SQL.Text:='alter trigger ant_main_au0 active;';
 qryrun.ExecSQL;

 qryrun.Close;
 qryrun.SQL.Text:='alter trigger ant_main_ad0 active;';
 qryrun.ExecSQL;

// Trn_Scrt.CommitRetaining;


  end;//****************************************************************************//
  Result := True;
end;





function TDmYonet.CopySrvAracToTerm: Boolean;
var
  qryCopyPaket : TIB_Cursor;
  SQLInsert : String;
  SQLInsertLst : TStringList;
begin
  DataMod.CreateCursor(qryCopyPaket,nil,False,DataMod.dbaMain);
  with qryCopyPaket do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT '+
    '   ARAC_KOD '+
    ' , ARAC_SID '+
    ' , PLAKA '+
    ' , CARI_KOD '+
    ' , ACIKLAMA '+
    ' , AKTIF_DEGIL '+
    ' , TRF_SIG_GEC_TAR '+
    ' , KASKO_SIG_GEC_TAR '+
    ' , AS_ADISOYADI '+
    ' , AS_DOGUM_YERI '+
    ' , AS_NUFUS_IL '+
    ' , AS_NUFUS_ILCE '+
    ' , AS_DOGUM_TARIHI '+
    ' , AS_IKA_ADRES '+
    ' , AS_SERI_NO '+
    ' , AS_MUYANE_GECERLILIK_SUR '+
    ' , ARAC_MARKA '+
    ' , ARAC_MARKA_TIP '+
    ' , TRAFIK_CIKIS_TAR '+
    ' , MODEL_YILI '+
    ' , SON_ONARIM_KM '+
    ' , RADYO_TEYP '+
    ' , ALARM '+
    ' , SIGORTA_KOD '+
    ' , BAYI_KOD '+
    ' , RADYO_KOD_NUM '+
    ' , LASTIK_EBADI '+
    ' , ANAHTAR_NUMARASI '+
    ' , NOTLAR '+
    ' , IL '+
    ' , ILCE '+
    ' , TESCIL_SIRA_NO '+
    ' , TESCIL_TARIHI '+
    ' , PLAKA_NO '+
    ' , MARKASI '+
    ' , MODELI '+
    ' , CINSI '+
    ' , ARAZI '+
    ' , TIPI '+
    ' , RENGI '+
    ' , MOTOR_NO '+
    ' , SASI_NO '+
    ' , RUHSAT_BILGILERI '+
    ' , SILINDIR_HACMI '+
    ' , MOTOR_GUCU '+
    ' , ISTIAP_HADDI '+
    ' , KISI '+
    ' , IMALATCI_YERLI '+
    ' , KULLANIM_TIPI '+
    ' , YAKIT_TIPI '+
    ' , YUK_TASIMA '+
    ' , ROMORK_TAKMA '+
    ' , TAKSIMETRE '+
    ' , TAKOMETRE '+
    ' , NET_AGIRLIK '+
    ' , KATAR_AGIRLIGI '+
    ' , ROMORK_ISTIAPHAD '+
    ' , MUYANE_GECERLILIK_SUR '+
    ' , ONAYLAYAN_SICIL '+
    ' , SERI_G_NO '+
    ' , BORC '+
    ' , ALACAK '+
    ' , DEVREDEN_BORC '+
    ' , DEVREDEN_ALACAK '+
    ' , RESIM '+
    ' ,SON_ONARIM_TARIHI '+

         ' FROM SRV_ARAC ORDER BY ARAC_KOD');
    Open;
  end;
  if (qryCopyPaket.Eof and qryCopyPaket.Bof) then
  begin
    Result := True;
    Application.MessageBox('Servis Araç tablosunda kayýt bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLInsertLst := TStringList.Create;
  qryCopyPaket.First;
  while not qryCopyPaket.Eof do
  begin
    SQLInsert := 'INSERT INTO SRV_ARAC ( '+
    '   ARAC_KOD '+
    ' , ARAC_SID '+
    ' , PLAKA '+
    ' , AKTIF_DEGIL '+
    ' , ARAZI '+
    ' , IMALATCI_YERLI '+
    ' , YUK_TASIMA '+
    ' , ROMORK_TAKMA '+
    ' , TAKSIMETRE '+
    ' , TAKOMETRE '+
    ' , NET_AGIRLIK '+
    ' , BORC '+
    ' , ALACAK '+
    ' , DEVREDEN_BORC '+
    ' , DEVREDEN_ALACAK '+

    ' , CARI_KOD '+
    ' , ACIKLAMA '+
    ' , TRF_SIG_GEC_TAR '+
    ' , KASKO_SIG_GEC_TAR '+
    ' , AS_ADISOYADI '+
    ' , AS_DOGUM_YERI '+
    ' , AS_NUFUS_IL '+
    ' , AS_NUFUS_ILCE '+
    ' , AS_DOGUM_TARIHI '+
    ' , AS_IKA_ADRES '+
    ' , AS_SERI_NO '+
    ' , AS_MUYANE_GECERLILIK_SUR '+
    ' , ARAC_MARKA '+
    ' , ARAC_MARKA_TIP '+
    ' , TRAFIK_CIKIS_TAR '+
    ' , MODEL_YILI '+
    ' , SON_ONARIM_KM '+
    ' , RADYO_TEYP '+
    ' , ALARM '+
    ' , SIGORTA_KOD '+
    ' , BAYI_KOD '+
    ' , RADYO_KOD_NUM '+
    ' , LASTIK_EBADI '+
    ' , ANAHTAR_NUMARASI '+
    ' , NOTLAR '+
    ' , IL '+
    ' , ILCE '+
    ' , TESCIL_SIRA_NO '+
    ' , TESCIL_TARIHI '+
    ' , PLAKA_NO '+
    ' , MARKASI '+
    ' , MODELI '+
    ' , CINSI '+
    ' , TIPI '+
    ' , RENGI '+
    ' , MOTOR_NO '+
    ' , SASI_NO '+
    ' , RUHSAT_BILGILERI '+
    ' , SILINDIR_HACMI '+
    ' , MOTOR_GUCU '+
    ' , ISTIAP_HADDI '+
    ' , KISI '+
    ' , KULLANIM_TIPI '+
    ' , YAKIT_TIPI '+
    ' , KATAR_AGIRLIGI '+
    ' , ROMORK_ISTIAPHAD '+
    ' , MUYANE_GECERLILIK_SUR '+
    ' , ONAYLAYAN_SICIL '+
    ' , SERI_G_NO '+
    ' , RESIM '+
    ' ,SON_ONARIM_TARIHI '+
    ' ) VALUES (';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ARAC_KOD').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ARAC_SID').AsString+',';
    SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('PLAKA').AsString)+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('AKTIF_DEGIL').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ARAZI').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('IMALATCI_YERLI').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('YUK_TASIMA').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ROMORK_TAKMA').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('TAKSIMETRE').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('TAKOMETRE').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('NET_AGIRLIK').AsString+',';

    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('BORC').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ALACAK').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('DEVREDEN_BORC').AsString+',';
    SQLInsert := SQLInsert + qryCopyPaket.FieldByName('DEVREDEN_ALACAK').AsString+',';

//****************************************************************************//
    if qryCopyPaket.FieldByName('CARI_KOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('CARI_KOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ACIKLAMA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ACIKLAMA').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TRF_SIG_GEC_TAR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TRF_SIG_GEC_TAR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('KASKO_SIG_GEC_TAR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('KASKO_SIG_GEC_TAR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_ADISOYADI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_ADISOYADI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_DOGUM_YERI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_DOGUM_YERI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_NUFUS_IL').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_NUFUS_IL').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_NUFUS_ILCE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_NUFUS_ILCE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_DOGUM_TARIHI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_DOGUM_TARIHI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_IKA_ADRES').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_IKA_ADRES').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_SERI_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_SERI_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('AS_MUYANE_GECERLILIK_SUR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('AS_MUYANE_GECERLILIK_SUR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ARAC_MARKA').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ARAC_MARKA').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('ARAC_MARKA_TIP').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ARAC_MARKA_TIP').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';

    if qryCopyPaket.FieldByName('TRAFIK_CIKIS_TAR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TRAFIK_CIKIS_TAR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('MODEL_YILI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('MODEL_YILI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('SON_ONARIM_KM').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('SON_ONARIM_KM').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('RADYO_TEYP').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('RADYO_TEYP').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('ALARM').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ALARM').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('SIGORTA_KOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('SIGORTA_KOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('BAYI_KOD').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('BAYI_KOD').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('RADYO_KOD_NUM').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('RADYO_KOD_NUM').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('LASTIK_EBADI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('LASTIK_EBADI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('ANAHTAR_NUMARASI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ANAHTAR_NUMARASI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('NOTLAR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('NOTLAR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('IL').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('IL').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('ILCE').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ILCE').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('TESCIL_SIRA_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TESCIL_SIRA_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('TESCIL_TARIHI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TESCIL_TARIHI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('PLAKA_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('PLAKA_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('MARKASI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('MARKASI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('MODELI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('MODELI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('CINSI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('CINSI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('TIPI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('TIPI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('RENGI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('RENGI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('MOTOR_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('MOTOR_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('SASI_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('SASI_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('RUHSAT_BILGILERI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('RUHSAT_BILGILERI').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('SILINDIR_HACMI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('SILINDIR_HACMI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('MOTOR_GUCU').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('MOTOR_GUCU').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('ISTIAP_HADDI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ISTIAP_HADDI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('KISI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('KISI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('KULLANIM_TIPI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('KULLANIM_TIPI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('YAKIT_TIPI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('YAKIT_TIPI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('KATAR_AGIRLIGI').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('KATAR_AGIRLIGI').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('ROMORK_ISTIAPHAD').IsNotNull then
       SQLInsert := SQLInsert + qryCopyPaket.FieldByName('ROMORK_ISTIAPHAD').AsString+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('MUYANE_GECERLILIK_SUR').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('MUYANE_GECERLILIK_SUR').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('ONAYLAYAN_SICIL').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('ONAYLAYAN_SICIL').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('SERI_G_NO').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('SERI_G_NO').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';
    if qryCopyPaket.FieldByName('RESIM').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('RESIM').AsString)+','
    else
       SQLInsert := SQLInsert + 'NULL,';


    if qryCopyPaket.FieldByName('SON_ONARIM_TARIHI').IsNotNull then
       SQLInsert := SQLInsert + SQL_Katar(qryCopyPaket.FieldByName('SON_ONARIM_TARIHI').AsString)+');'
    else
       SQLInsert := SQLInsert + 'NULL);';

//****************************************************************************//

    SQLInsertLst.Add(SQLInsert);
    qryCopyPaket.Next;
  end;
//****************************************************************************//
  with ScriptExecutive do
  begin
    SQL.Clear;
    SQL.AddStrings(SQLInsertLst);
  end;
//****************************************************************************//
  try
    if frmBakiyeDevret<>Nil then
    frmBakiyeDevret.MemoCikti.Lines.AddStrings(SQLInsertLst);
    ScriptExecutive.Execute;
  except
    Result := False;
    Application.MessageBox('Servis Araç scriptinin çalýþmasý sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  Result := True;
end;


//str int ayr sry isimleri

end.
