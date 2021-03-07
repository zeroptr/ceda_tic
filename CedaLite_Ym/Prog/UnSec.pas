unit unSec;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     ComCtrls,registry;

  function GET_HDDNUMBER():String;
  function REG_STATUS(Menu:Boolean):SmallInt;
  function SIFRELE(Data:string):String;
  function HexToInt(s: string): Longword;

implementation

uses DateUtils,ufrmLisans, Main;

function SIFRELE(Data:string):String;
var
 strTemp:String;
 i:Integer;
begin
    for i:=1 to Length(Data) do begin
       strTemp := strTemp +  IntToStr((Ord(Data[i])*2)+1000)
    end;
    Result := strTemp;
end;

function HexToInt(s: string): Longword;
var
  b: Byte;
  c: Char;
begin
  Result := 0;
  s := UpperCase(s);
  for b := 1 to Length(s) do
  begin
    Result := Result * 16;
    c := s[b];
    case c of
      '0'..'9': Inc(Result, Ord(c) - Ord('0'));
      'A'..'F': Inc(Result, Ord(c) - Ord('A') + 10);
      else
        raise EConvertError.Create('No Hex-Number');
    end;
  end;
end;


function SIFRE_COZ(Data:string):String;
var
  i:Integer;
  j:Integer;
  strTemp:string;
  int_Value:Integer;
  flo_Value:Double;
  ret_Value:String;
begin
  j:= Length(Data) div 4;
  for i:=0 to j-1 do begin
     strTemp :=  Copy(Data,((i)*4)+1,4);
     flo_Value:= (StrToInt(strTemp)-1000)/2;
     int_Value := Round(flo_Value);
     ret_Value := ret_Value + chr(int_Value);
  end;
  Result := ret_Value;
end;


function GET_HDDNUMBER():String;
var
  VolumeSerialNumber : DWORD;
  MaximumComponentLength : DWORD;
  FileSystemFlags : DWORD;
  SerialNumber : string;
begin
  GetVolumeInformation('C:\',nil,
                             0,
                             @VolumeSerialNumber,
                             MaximumComponentLength,
                             FileSystemFlags,
                             nil,
                      0);

  SerialNumber := IntToHex(HiWord(VolumeSerialNumber), 5) + IntToHex(LoWord(VolumeSerialNumber), 5);
  Result := SerialNumber;
end;

procedure RUN_FIRST(Reg:TRegistry);
begin
     Reg.WriteString('A',SIFRELE(DateToStr(Date))); // ilk tarih
     Reg.WriteString('B',SIFRELE(DateToStr(Date))); // son acýldýðý tarih
     Reg.WriteString('C',SIFRELE(GET_HDDNUMBER)); // cpu id
     Reg.WriteString('D',SIFRELE('123628715')); // þifre
     Reg.WriteString('E',SIFRELE('123456')); ///
end;

function GET_DAY(Reg:TRegistry):Integer;
var
  First_Date,Last_Date:TDateTime;
  int_Day:Integer;
begin
  try
     First_Date:=StrToDate(SIFRE_COZ(Reg.ReadString('A')));
     Last_Date:=StrToDate(SIFRE_COZ(Reg.ReadString('B')));
     if Last_Date>Now then begin
        Result := -2;
        Exit;
     end
     else begin
        int_Day := DaysBetween(Last_Date,First_Date);
        Result := int_Day;
     end;
   except
     Result := -1;
   end;
end;

function PASSWORD_CONTROL(Reg:TRegistry):Boolean;
var
   IHDD_ID:LongWord;
   Sifre:LongWord;
begin
  try
   IHDD_ID := HexToInt(GET_HDDNUMBER);
   IHDD_ID := (IHDD_ID - 5) * 7  ;
   Sifre := HexToInt(SIFRE_COZ(Reg.ReadString('D')));
   if IHDD_ID=Sifre  then begin
     Result := True
   end
   else begin
     Result:=False;
   end;
    Except
        Result := false;
    end;
end;

function OPEN_LISNAS(Reg:TRegistry):Boolean;
begin
  if not frmLisans.Form_Open(Reg) then
  begin
     Application.Terminate;
  end;
end;


function REG_STATUS(Menu:Boolean):SmallInt;
var
 Reg:TRegistry;
 int_Day:Integer;
const
     REGKEY='\Software\Microsoft\ABCXYZ';
begin
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey(REGKEY, true);
    if Menu then begin
      OPEN_LISNAS(Reg) ;
    end;
    if Reg.ReadString('A')='' then begin
      RUN_FIRST(Reg);
    end
    else begin
         if PASSWORD_CONTROL(Reg) then begin
           //Reg.WriteString('B',SIFRELE(DateToStr(Date))); // son acýldýðý tarih
           MainForm.Lisans1.Visible := False;
           Result := 0;
           Exit;
         end;
         if SIFRE_COZ(Reg.ReadString('E')) = Copy(GET_HDDNUMBER,0,4) then begin
            OPEN_LISNAS(Reg);
         end;

         int_Day := GET_DAY(Reg);
         if int_Day=-1 then begin /// error
         end
         else if (int_Day=-2) then begin /// tarih geri alýnmýþ
            Reg.WriteString('E',SIFRELE(Copy(GET_HDDNUMBER,0,4))); // son acýldýðý tarih
            OPEN_LISNAS(Reg);
         end
         else if int_Day>31 then begin /// demo süresi dolmuþ
            OPEN_LISNAS(Reg);
         end
         else begin
            Reg.WriteString('B',SIFRELE(DateToStr(Date))); // son acýldýðý tarih
         end;
    end;
    Reg.CloseKey;

   except
      Application.Terminate;
   end;
end;


end.
