unit unFunc;
{Kýsayollar
Alt + 0               -> pencere listesi
Ctrl + O + U          -> seçimi büyük harfe -> küçük harfe çevir
Ctrl + K + E          -> aktif kelimeyi küçük yap
Ctrl + K + F          -> aktif kelimeyi büyük yap
Ctrl + Shift + I      -> seçili satýrý/satýrlarý bir tab ileri
Ctrl + Shift + U      -> seçili satýrý/satýrlarý bir tab geri
Ctrl + Y              -> aktif satýrý sil
Ctrl + Shift + Y      -> aktif satýrý sil ama silinen satýrý boþ býrak
Ctrl + T              -> soldan saða kelime kelime sil
Ctrl+O+O              -> ayarlarý forma yansýt (kaynaðýn üstüne bak)
Ctrl+K+S              -> tümünü kaydet
Ctrl+Shift+g          -> new globally unique identifier
Ctrl+Shift+R          -> makro kaydet
Ctrl+Shift+P          -> makro iþlet
Ctrl+N                -> yeni satýr
Ctrl+Shift+J & Ctrl+J -> hazýr kod iskeletleri
}

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls,DateUtils;
  Function LeftStr(s:String;t:Byte): String;
  Function RightStr(s:String;t:Byte): String;
  Function isDigit(ch: char): Boolean;
  Function isNumeric(s:string): Boolean;
  Function isUpper(ch: char): Boolean;
  Function isLower(ch: char): Boolean;
  Function toUpper(ch: Char): Char;
  Function toLower(ch: Char): Char;
  Function Upper(s: String): String;
  Function Lower(s: string): string;
  Function ParaYazdir(c:String):String;
  Function FindWindowsDir : String;
  Function FindSystemDir : String;
  Function SetPCSystemTime(tDati: TDateTime): Boolean;
  function DiskSeriNo(DriveName: Char): DWord;
  function Str2Curr(const St: string): Currency;
  Function SQL_Para(CurrValue:Currency):String;
  Function SQL_Tarih(Gun:TDate):String;
  Function SQL_Saat(Saat:TDateTime):String;
  Function SQL_Tarihsaat(Deger:TDateTime):String;
  Function SQL_Katar(Deger:String):String;
  procedure LoadEnvironmentStrings(Strings: TStrings);
  procedure ExecNewProcess(ProgramName : String;Wait:Boolean);
  Function GetPlatform:String;
  Function HangiAnahtar (PString : string; PAnahtar : String ; PSperator : string) : string;
  Function HangiKolon (PString : string; PHangiKolon : integer ; PSperator : string) : string;
  function MMtoPixel (PMM : integer;PYatDus : integer):integer;
  function PixeltoMM (PPixel : integer;PYatDus : integer):integer;
  function GetAppPath: string;
  Function ReplaceText(TextStr:String;ToBeReplaced:String;NewText:String):String;
  Function Param(Sayi: Extended): String;
  Function YeniParam(Sayi:Extended):String;
  function KiloYaziIle(Sayi:Extended):String;  
  function GET_OP_SYS_UserName: String;
  function GET_ComputerName: String;
  Procedure FileCopy( Const sourcefilename, targetfilename: String );
  function ay_gun_son(Tarih:TDate):String;
  function ay_gun_ilk(Tarih:TDate):String;

implementation

function ay_gun_son(Tarih:TDate):String;
begin
     Result:= Datetostr(EncodeDateTime(Yearof(Tarih),monthof(Tarih),DaysInMonth(Tarih),0,0,0,0));
end;

function ay_gun_ilk(Tarih:TDate):String;
var
   Temp:TDate;
   a:Integer;
begin
     //a:=DaysInMonth(Tarih);
     Result:=
     Datetostr(EncodeDateTime(Yearof(Tarih),monthof(Tarih),1,0,0,0,0));
     //Inttostr(a)+monthof(Tarih)+Inttostr();
end;

Procedure FileCopy( Const sourcefilename, targetfilename: String );
Var
S, T: TFileStream;
Begin
  S := TFileStream.Create( sourcefilename, fmOpenRead );
  try
    T := TFileStream.Create( targetfilename,
    fmOpenWrite or fmCreate );
      try
        T.CopyFrom(S, S.Size ) ;
      finally
        T.Free;
      end;
  finally
    S.Free;
  end;
end;


Function HangiKolon (PString : string; PHangiKolon : integer ; PSperator : string) : string;
var
    i: integer ;
    TekKarakter : string;
    TKolonNo : integer;
    Donus : string;
Begin
         Donus := '';
         TKolonNo:=0;
         For i := 1 To Length(PString) do
         begin
              TekKarakter := copy (PString, i, 1);
              If TekKarakter = PSperator Then Begin
                  TKolonNo := TKolonNo + 1;
                  If TKolonNo = PHangiKolon Then
                  Begin
                     break;
                  end else Donus := '';
              end Else
              Begin
                   Donus := Donus + TekKarakter;
              End;
         end; // For

         Result:= Donus;
end; // HangiKolon

Function HangiAnahtar (PString : string; PAnahtar : String ; PSperator : string) : string;
var
    i,j: integer ;
    TekKarakter : string;
    Donus : string;
    Cik:Boolean;
Begin
         Donus := '';
         For i := 1 To Length(PString) do
         begin
              Cik:=False;
              TekKarakter := copy (PString, i, 1);
              If TekKarakter = PSperator Then
              Begin
                if Upper (PAnahtar) = Donus then
                Begin
                   Donus := '';
                   for j:=i+1 to Length(PString) do
                   Begin
                     TekKarakter := copy (PString, j, 1);
                     If TekKarakter = PSperator Then Begin Cik:=True; Break;end else Donus := Donus + TekKarakter;
                   End;
                End else Donus:='';
             End Else if TekKarakter <> ';' then Donus := Donus + TekKarakter;
             if Cik=True then break;
         end; // For
         Result:= Donus;
end;

Function SQL_Para(CurrValue:Currency):String;
var CurrValueStr:String;
    i:Integer;
begin
  CurrValueStr := CurrToStr(CurrValue);
  Repeat
    i := Pos(DecimalSeparator,CurrValueStr);
    if i > 0 then
    begin
       CurrValueStr[i] := '.'; //IB de '.'
    end
  until i = 0;
  Result := CurrValueStr;
end;

Function SQL_Tarih(Gun:TDate):String;
begin
  Result := chr(39) + FormatDateTime('dd.mm.yyyy',Gun) + chr(39);
end;

Function SQL_Saat(Saat:TDateTime):String;
begin
  Result := chr(39) + FormatDateTime('hh:mm:ss',Saat) + chr(39);
end;

Function SQL_TarihSaat(Deger:TDateTime):String;
begin
  Result := chr(39) + FormatDateTime('dd.mm.yyyy hh:mm:ss',Deger) + chr(39);
end;


Function SQL_Katar(Deger:String):String;
Var i :Integer;
begin
  Result := Trim(Deger);
  i :=  Pos(chr(39),Result);
  while i <> 0 do
  begin
    Result[i] := ' ';
    i := Pos(chr(39),Result);
  end;
  Result := chr(39) + Trim(Result) + chr(39);
end;

function Str2Curr(const St: string): Currency;
// 22.11.2002
// para alanlarýnda "." yý kaldýrýr
// 1.000,75 i 1000,75 deðerine cevirir
var
 i,z: integer;
 S: string;
begin
 S := St;
 for z := 1 to length(st) do
 begin
   if DecimalSeparator <> '.' then
     begin
       i := Pos('.', S);
       if i > 0 then
         begin
           Delete(S, i, 1);
          Insert(DecimalSeparator, S, i);
     // yukarýdaki bu komut istenilen iþareti ekleyebiliyor,burada ',' iþaretini eklemiþ.
    end;
     end;
 end;
 result := StrToCurr(S);
end;

{String ifadenin solundan t sayýsýna kadar olan karakterleri alýr}
Function LeftStr(s:String;t:Byte): String;
begin
 Result := Copy(s,1,t);
end;

Function RightStr(s:String;t:Byte):String;
{String ifadenin saðýndan t sayýsýna kadar olan karakterleri alýr}
begin
 Result := Copy(s,length(s)-t,length(s));
end;

Function isDigit(ch: char): Boolean;
{Girilen karakterin dijit olup olmadýðýný kontrol eder}
begin
  if ch in ['0'..'9'] then
    isDigit := true
  else
    isDigit := false;
  if ch in ['.',',',' ','/','+','-','*'] then isDigit := true;
end;

Function isNumeric(s:string): Boolean;
{String ifadenin Numerik olup olmadýðýný bildirir
 DENENMEDÝ......!}
var i:Integer;
begin
  for i := 1 to length(s) do
    if isDigit(s[i]) then
    Result := True
    else begin
    REsult := False;
    Exit;
    end;
end;

Function isUpper(ch: char): boolean;
{Karakterin büyük harf olup olmadýðýný kontrol eder.
bu fonksiyonun Türkçe desteði vardýr.
 199	Ç,221	Ý, 208	Ð, 222	Þ, 73	I,220	Ü, 214	Ö}
begin
  if ch in ['A'..'Z'] then
    isUpper := True
  else
    isUpper := False;

  If ORD(CH) in [199,221,208,222,73,220,214] then  isUpper := True;
end;

Function isLower(ch: char): Boolean;
{Karakterin Küçük harf olup olmadýðýný kontrol eder.
 bu fonksiyonun Türkçe desteði vardýr.
 231  ç,105 i,240 ð, 254 þ,253 ý,252 ü,246 ö}
begin
  if ch in ['a'..'z'] then
    isLower := true
  else
    isLower := false;
 If ORD(CH) in [231,105,240,254,253,252,246] then  isLower := True;
end;


Function toUpper(ch: Char): Char;
{Küçük karakteri Büyüðüne çevirir.Bu Fonksiyonun Türkçe desteði Vardýr.}
begin
  Case ch of
  'ð': begin Result := 'Ð'; Exit; end;
  'ü': begin Result := 'Ü'; Exit; end;
  'þ': begin Result := 'Þ'; Exit; end;
  'i': begin Result := 'Ý'; Exit; end;
  'ý': begin Result := 'I'; Exit; end;
  'ö': begin Result := 'Ö'; Exit; end;
  'ç': begin Result := 'Ç'; Exit; end;
  end;
  toUpper := chr(ord(ch) and $DF);
end;

Function toLower(ch: Char): Char;
{Büyük karakteri Küçüðüne çevirir.Bu Fonksiyonun Türkçe desteði Vardýr.}
begin
  Case ch of
  'Ð': begin Result := 'ð'; Exit; end;
  'Ü': begin Result := 'ü'; Exit; end;
  'Þ': begin Result := 'þ'; Exit; end;
  'Ý': begin Result := 'i'; Exit; end;
  'I': begin Result := 'ý'; Exit; end;
  'Ö': begin Result := 'ö'; Exit; end;
  'Ç': begin Result := 'ç'; Exit; end;
  end;
 toLower := chr(ord(ch) or $20);
end;

Function Upper(s: String): String;
{String bir ifade içindeki tüm küçük karakterleri büyüðe çevirir.
 Bu Fonksiyonun Türkçe desteði Vardýr.}
var
  i: integer;
begin
  for i := 1 to length(s) do
    if isLower(s[i]) then s[i] := toUpper(s[i]);
  Upper := s;
end;

Function Lower(s: string): string;
{String bir ifade içindeki tüm büyük karakterleri küçüðe çevirir.
Bu Fonksiyonun Türkçe desteði Vardýr.}
var
  i: integer;
begin
  for i := 1 to length(s) do
    if isUpper(s[i]) then s[i] := toLower(s[i]);
  Lower := s;
end;

Function ParaYazdir(c:String):String;
{Bu fonksiyonun amacý textboxtaki ifadeyi formatlý bir þekilde yazdýrmaktýr}
begin
if not IsNumeric(c) then
  Begin
   Result:=LeftStr(c,length(c)-1);
   Exit;
  end;
end;

Function FindWindowsDir : String;
var
  pWindowsDir : array [0..255] of Char;
  sWindowsDir : string;
begin
{// GetWindowsDirectory(LPTSTR,UINT);
// LPTSTR  lpBuffer,    // address of buffer for Windows directory
// UINT  uSize          // size of directory buffer}
  GetWindowsDirectory (pWindowsDir, 255);
  sWindowsDir := StrPas (pWindowsDir);
  Result := sWindowsDir ;
end;

Function FindSystemDir : String;
var
  pSystemDir : array [0..255] of Char;
  sSystemDir : string;
begin
// UINT GetSystemDirectory(
// LPTSTR lpBuffer,	// address of buffer for system directory
//  UINT uSize 	// size of directory buffer );
  GetSystemDirectory (pSystemDir, 255);
  sSystemDir := StrPas (pSystemDir);
  Result := sSystemDir;
end;

//******************************************************************************
//Public function SetPCSystemTime changes the system date and time.
//Parameter(s): tDati  The new date and time
//Returns:      True if successful
//              False if not
//******************************************************************************
Function SetPCSystemTime(tDati: TDateTime): Boolean;
var
   tSetDati: TDateTime;
   vDatiBias: Variant;
   tTZI: TTimeZoneInformation;
   tST: TSystemTime;
begin
  GetTimeZoneInformation(tTZI);
  vDatiBias := tTZI.Bias / 1440;
  tSetDati := tDati + vDatiBias;
  with tST do
  begin
    wYear := StrToInt(FormatDateTime('yyyy', tSetDati));
    wMonth := StrToInt(FormatDateTime('mm', tSetDati));
    wDay := StrToInt(FormatDateTime('dd', tSetDati));
    wHour := StrToInt(FormatDateTime('hh', tSetDati));
    wMinute := StrToInt(FormatDateTime('nn', tSetDati));
    wSecond := StrToInt(FormatDateTime('ss', tSetDati));
    wMilliseconds := 0;
  end;
  SetPCSystemTime := SetSystemTime(tST);
end;

function DiskSeriNo(DriveName: Char): DWord;
var
  Temp: DWord;
begin
  GetVolumeInformation(PChar(DriveName + ':\' ), Nil, 0,@Result,Temp,Temp,Nil, 0);
end;

procedure LoadEnvironmentStrings(Strings: TStrings);
var
  AllStrings, CurrentString: PChar;
begin
  AllStrings := GetEnvironmentStrings;
  try
    if AllStrings <> nil then
    begin
      CurrentString := AllStrings;
      while True do
      begin
        Strings.Add(StrPas(CurrentString));
        Inc(CurrentString, Succ(StrLen(CurrentString)));
        if CurrentString[0] = #0 then
          Break;
      end;
    end;
  finally
    FreeEnvironmentStrings(AllStrings);
  end;
end;
procedure ExecNewProcess(ProgramName : String;Wait:Boolean);
var
  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  CreateOK   : Boolean;
begin
  { fill with known state }
  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);

  CreateOK := CreateProcess(PChar(ProgramName),nil, nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil, nil, StartInfo, ProcInfo);

  { check to see if successful }
  if CreateOK then
    //may or may not be needed. Usually wait for child processes
  if wait then WaitForSingleObject(ProcInfo.hProcess, INFINITE);
end;

function GetPlatform:String;
var
  verInfo : TOSVERSIONINFO;
begin
{   http://support.microsoft.com/default.aspx?scid=kb;en-us;304289
                Windows 95 Windows 98 Windows Me Windows NT 4.0 Windows 2000 Windows XP Windows Server 2003
 PlatformID              1          1          1              2            2          2                   2
 Major Version           4          4          4              4            5          5                   5
 Minor Version           0          10        90              0            0          1                   2}
  verInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if GetVersionEx(verInfo) then
  begin
    case verInfo.dwPlatformId of
    1:
      case verInfo.dwMinorVersion of
      0..89  : Result := 'WIN9X';
      90..200: Result := 'WINME';
      end;
    2:if verInfo.dwMajorVersion = 4 then
         Result := 'WINNT4'
      else
         Result := 'WIN2KXP';
    end;
  end;
end;


function MMtoPixel (PMM : integer;PYatDus : integer):integer;
var
  PixelD :real;
  YSize : integer;
begin
  if PYatDus = 1 then
  begin
    PixelD:= (Screen.PixelsPerInch / 25.4 );
    Result:= trunc (PMM*PixelD);
  end
  else
  begin
    PixelD:= (Screen.PixelsPerInch / 25.4 );
    YSize := trunc (PMM*PixelD);
    Result:=YSize;
  end;
end;

function  PixeltoMM (PPixel : integer;PYatDus : integer):integer;
begin
  if PYatDus = 1 then
     Result:= trunc (PPixel/(Screen.PixelsPerInch / 25.4 ))
  else
     Result:= trunc ((PPixel/(Screen.PixelsPerInch / 25.4 )));
end;

function GetAppPath: string;
begin
  Result := ExtractFilePath(Application.ExeName);
  if Result[Length(Result)] <> '\' then
   Result := Result + '\';
end;

function ReplaceText(TextStr:String;ToBeReplaced:String;NewText:String):String;
var
  i:Integer;
begin
  // written By Burak Wish to work correct
  Result := TextStr;
  i := 0;
  while Pos(ToBeReplaced,Result) > 0 do
  begin
    if i = 200 then Break; // sonsuz donguye girmeyelim
    if Pos(ToBeReplaced,Result) = 1 then
       Result := NewText + Copy(Result,Length(ToBeReplaced)+1 , Length(Result) - Length(ToBeReplaced))
    else
       Result := LeftStr(Result,Pos(ToBeReplaced,Result)-1)+ NewText+  Copy(Result,Pos(ToBeReplaced,Result) + Length(ToBeReplaced) , Length(Result) -   Length(ToBeReplaced) +1);
    inc(i)
  end;
end;

function Param(Sayi: Extended): String;
const
Yuzler: Array[1..3,0..9] of String=(
        ('','Yüz','ÝkiYüz','ÜçYüz','DörtYüz','BeþYüz','AltýYüz','YediYüz','SekizYüz','DokuzYüz'),
        ('','On','Yirmi','Otuz','Kýrk','Elli','Altmýþ','Yetmiþ','Seksen','Doksan'),
        ('','Bir','Ýki','Üç','Dört','Beþ','Altý','Yedi','Sekiz','Dokuz'));
Binler: Array[1..8] of String=
        ('KatTrilyar','Trilyar','KatTrilyon','Trilyon','Milyar','Milyon','Bin','');
var
        FloR: TFloatRec;
        FloV: TFloatValue;
        i, y, z: Integer;
        Parca : String;
        ASt: String[24];
        EkSt: String[26];
        AraSonuc, Sonuc: String;
        n, hane: Integer;
begin
        Sonuc:='';
        FloV:= fvExtended;
        FloatToDecimal(FloR,Sayi,FloV,18,0);
        ASt:=FloR.Digits;
        n:=length(ASt);
        if FloR.Exponent<>Length(ASt) then
        begin
                EkSt:='';
                FillChar(EkSt,FloR.Exponent-n+1,'0');
                EkSt[0]:=Chr(FloR.Exponent-n);
                ASt:=ASt+EkSt;
        end;
        n:=Length(ASt);
        if n<24 then
        begin
                EkSt:='';
                FillChar(EkSt,24-n+1,'0');
                EkSt[0]:=Chr(24-n);
                ASt:=EkSt+ASt;
        end;
        n:=Length(ASt);
        i:=1;
        hane:=1;
        while i<n do
        begin
                Parca:=Copy(ASt,i,3);
                AraSonuc:='';
                for y:=1 to 3 do
                begin
                        z:=StrToInt(Copy(Parca,y,1));
                        AraSonuc:=AraSonuc+Yuzler[y,z];
                end;
                if AraSonuc<>'' then AraSonuc:=AraSonuc+Binler[hane];
                if AraSonuc='BirBin' then AraSonuc:='Bin';
                i:=i+3;
                Inc(hane);
                Sonuc:=Sonuc+AraSonuc;
        end;
        Param:=Sonuc;
end;

function YeniParam(Sayi:Extended):String;
var
  S,ilk,son: String;
begin
  S := FormatFloat('0.00',Sayi);
  ilk := Param(StrToCurr(Copy(S,0,Pos(DecimalSeparator, S)-1))) + ' TL';
  if StrToCurr(Copy(S,Pos(DecimalSeparator, S)+1,Length(S)-Pos(DecimalSeparator, S))) <> 0 then
     son := Param(StrToCurr(Copy(S,Pos(DecimalSeparator, S)+1,Length(S)-Pos(DecimalSeparator, S))))+ ' KRÞ';
  Result := ilk + ' ' +  son;
end;

function GET_OP_SYS_UserName: String;
const
  cnMaxLen=254;
var
  sUserName     : string;
  dwUserNameLen : DWord;
begin
  dwUserNameLen:=cnMaxLen-1;
  SetLength(sUserName, cnMaxLen);
  GetUserName(Pchar(sUserName), dwUserNameLen);
  SetLength(sUserName, dwUserNameLen);
  Result := sUserName;
end;

function GET_ComputerName: String;
const
  cnMaxLen=254;
var
  sComputerName     : string;
  dwcomputerNameLen : DWord;
begin
  dwComputerNameLen:=cnMaxLen-1;
  SetLength(sComputerName, cnMaxLen);
  GetComputerName(Pchar(sComputerName), dwcomputerNameLen);
  SetLength(sComputerName, dwcomputerNameLen);
  Result :=  sComputerName;
end;

function KiloYaziIle(Sayi:Extended):String;
var
  S,ilk,son: String;
begin
  S := FormatFloat('0.00',Sayi);
  ilk := Param(StrToCurr(Copy(S,0,Pos(DecimalSeparator, S)-1))) + ' KG';
  if StrToCurr(Copy(S,Pos(DecimalSeparator, S)+1,Length(S)-Pos(DecimalSeparator, S))) <> 0 then
     son := Param(StrToCurr(Copy(S,Pos(DecimalSeparator, S)+1,Length(S)-Pos(DecimalSeparator, S))))+ ' GR';
  Result := ilk + ' ' +  son;
end;

end.
