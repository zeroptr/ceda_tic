{**********************************************}
{   TeeChart and TeeTree TeeUnicode component  }
{                                              }
{   Copyright (c) 2009 by Steema Software SL   }
{        All Rights Reserved                   }
{**********************************************}
unit TeeUnicode;

{$I TeeDefs.inc}

interface

uses SysUtils,Windows,Classes,Dialogs;

type
  TUnicode=class
  public
    function dec2hex ( textString : Integer ) : String;
    function dec2hexUTFPair ( textString : Integer ) : String;
    function HexToInt(HexNum: string): LongInt;
    procedure Split(const Delimiter: Char;Input: string;const Strings: TStrings);
    procedure SplitFix(Input: string;const Strings: TStrings);
    function StripSpaces(Input: string) : String;
    function ConvertCP2Char ( textString : String ) : WideString;
    function ConvertCPList2Char ( listArray : TStringList ) : WideString;
    function StringToWideString(const s: AnsiString; codePage: Word): WideString;
    function DecodeUTF8String(const s: AnsiString; codePage: Word): WideString; overload;
    function DecodeUTF8String(const s: AnsiString): WideString; overload;
    function CodeUTF8String(const s: WideString; addPrefix : Boolean): AnsiString; overload;
    function CodeUTF8String(const s: WideString): AnsiString; overload;
    function ConvertChar2CP ( textString : WideString ) : TStringList;
    function ConvertCP2UTF8( textString : String ) : String; overload;
    function ConvertCP2UTF8( listArray : TStringList ) : String;  overload;
    function ConvertUTF82CP ( textString : String )  : String;  overload;
    function ConvertUTF82CPList ( textString : String )  : TStringList;
    function BreakOutList(textString: String): TStringList;
    procedure ConvertUTF82CP ( textString : String; const Strings: TStrings); overload;
  end;

function Unicoding:TUnicode;

implementation

//Note - could store as hex format (slightly more efficient spacewise) using ConvertCP2Char and
//ConvertChar2CP only, but chose UTF8 as more widely known format.

var
  IUnicode:TUnicode=nil;

function Unicoding:TUnicode;
begin
  if not Assigned(IUnicode) then
     IUnicode:=TUnicode.Create;

  result:=IUnicode;
end;

function TUnicode.dec2hex ( textString : Integer ) : String;
Begin
 result:=Uppercase(Format('%x',[textString]));
end;

function TUnicode.dec2hexUTFPair(textString: Integer): String;
begin
 result:=Uppercase(Format('%x',[textString]));
 if Length(result)=1 then
   result:='0'+result;
end;

function TUnicode.HexToInt(HexNum: string): LongInt;
begin
   Result:=StrToInt('$' + HexNum) ;
end;

procedure TUnicode.Split
   (const Delimiter: Char;
    Input: string;
    const Strings: TStrings) ;
begin
   Assert(Assigned(Strings)) ;
   Strings.Clear;
   Strings.Delimiter := Delimiter;
   Strings.DelimitedText := Input;
end;

procedure TUnicode.SplitFix
   (Input: string;
    const Strings: TStrings) ;
var tmpstr:String;
begin
   Assert(Assigned(Strings)) ;
   Strings.Clear;
   while Length(Input)>1 do
   Begin
     Strings.Add(Copy(Input,1,2));
     if Length(Input)>2 then
       Input:=Copy(Input,3,Length(Input))
     else
       Input:='';
   end;
end;

function TUnicode.StripSpaces(Input: string): String;
var tmpStr: String;
begin
  while (Pos(' ',Input)<>0) do
  Begin
    tmpStr:=Copy(Input,1,Pos(' ',Input)-1);
    Input:=tmpStr+Copy(Input,Pos(' ',Input)+1,Length(Input));
  end;
  result:=Input;
end;

function TUnicode.ConvertCP2Char ( textString : String ) : WideString;
var outputString,tmpWideStr : WideString;
    listArray : TStringList;
    n,i:Integer;
Begin
  result:='';
  if Pos('@U#',textString)=1 then
    textString:=Copy(textString,4,Length(textString));
  listArray:=TStringList.Create;
  //textString := Copy( textString.replace(/^\s+/, '');
  if (Length(textString) = 0) then
    result:=''
  else
  Begin
  //textString = textString.replace(/\s+/g, ' ');
    if (Pos(' ',textString)=0) then
      SplitFix(textString,listArray)
    else
      Split(' ',textString,listArray);
  end;
  result:= ConvertCPList2Char ( listArray );
end;

function TUnicode.ConvertCPList2Char ( listArray : TStringList ) : WideString;
var outputString,tmpWideStr : WideString;
    n,i:Integer;
Begin
  for i:=0 to listArray.Count-1 do
  Begin
    if (Pos('@@',listArray[i])<>0) then
      outputString := outputString + ' ' + Copy(listArray[i],3,Length(listArray[i]))
    else
    Begin
      tmpWideStr:='';
      n:= HexToInt(listArray[i]);
      if (n = 13) then
      begin
        outputString := outputString + chr(13);
      end
      else if (n <= HexToInt('FFFF')) then
      begin
        outputString := outputString + WideChar(n);
      end
      else if (n <= HexToInt('10FFFF')) then
      begin
        n := n-HexToInt('10000');
        outputString := outputString+WideChar(HexToInt('D800') or (n SHR 10))
                        + WideChar(HexToInt('DC00') or (n and HexToInt('3FF')));
      end
      else
      begin
        outputString := outputString + '!error ' + dec2hex(n) +'!';
      end;
    end;
  end;
  result:= outputString;
end;

{Converts Ansi string to Unicode string using specified code page.
  @param   s        Ansi string.
  @param   codePage Code page to be used in conversion.
  @returns Converted wide string.
}
function TUnicode.StringToWideString(const s: AnsiString; codePage: Word): WideString;
var
  l: integer;
begin
  if s = '' then
    Result := ''
  else
  begin
    l := MultiByteToWideChar(codePage, MB_PRECOMPOSED, PChar(@s[1]), - 1, nil, 0);
    SetLength(Result, l - 1);
    if l > 1 then
      MultiByteToWideChar(CodePage, MB_PRECOMPOSED, PChar(@s[1]),
        - 1, PWideChar(@Result[1]), l - 1);
  end;
end; { StringToWideString }

function TUnicode.CodeUTF8String(const s: WideString): AnsiString;
begin
{$IFDEF AXUNICODE}
  result:=CodeUTF8String(s,True);
{$ELSE}
  result:=s;
{$ENDIF}
end;

function TUnicode.CodeUTF8String(const s: WideString;
  addPrefix : Boolean): AnsiString;
var prefix : String;
begin
{$IFDEF AXUNICODE}
  if Length(s)=0 then
    result:=s
  else
  if Pos('@U#',s)=1 then
    result:=s
  else
  Begin
    if addPrefix then
      prefix:='@U#'
    else
      prefix := '';
    result:= prefix + StripSpaces(ConvertCP2UTF8(ConvertChar2CP( s )));
  end;
{$ELSE}
  result:=s;
{$ENDIF}
end;

function TUnicode.DecodeUTF8String(const s: AnsiString): WideString;
begin
{$IFDEF AXUNICODE}
  result:=DecodeUTF8String(s,0);
{$ELSE}
  result:=s;
{$ENDIF}
end;

function TUnicode.DecodeUTF8String(const s: AnsiString;
  codePage: Word): WideString;
begin
{$IFDEF AXUNICODE}
  if s = '' then
    Result := ''
  else
  if Pos('@U#',s)= 1 then
  Begin
    result:=ConvertCPList2Char(ConvertUTF82CPList(s));
  end
  else
    result:=StringToWideString(s, codePage);
{$ELSE}
  result:=s;
{$ENDIF}
end;

function TUnicode.ConvertChar2CP ( textString : WideString ) : TStringList;
Var outputString: String;
    outputList : TStringList;
    haut, n, i : Integer;
    b : Integer;
begin
  outputString :='';
  outputList := TStringList.Create;
  haut := 0;
  n := 0;
  for i := 1 to Length(textString) do
  Begin
      b := Ord(textString[i]);  // alert('b:'+dec2hex(b));
      if (b < 0) or (b > HexToInt('FFFF')) then
        outputString := '!error ' + dec2hex(b) + '!';

      if (haut <> 0) then
      begin
        if (HexToInt('DC00') <= b) and (b <= HexToInt('DFFF')) then
        begin
          outputList.Add(dec2hex(HexToInt('10000') + ((haut - HexToInt('D800')) SHL 10) + (b - HexToInt('DC00'))));
          haut := 0;
          continue;
        end
        else
        begin
          outputString := outputString + '!error ' + dec2hex(haut) + '!';
          haut := 0;
        end;
      end;

    if (HexToInt('D800') <= b) and (b <= HexToInt('DBFF')) then
      haut := b
    else
      outputList.Add(dec2hex(b));
  end;

  result:= outputList; //  outputString.replace(/ $/, '') ;
end;

function TUnicode.ConvertCP2UTF8( textString : String ) : String;
var listArray : TStringList;
Begin
  if Pos('@U#',textString)=1 then
    textString:=Copy(textString,4,Length(textString));
  listArray:=TStringList.Create;
  //mm tmp out textString = textString.replace(/^\s+/, '');
  if (Length(textString) = 0) then  result:='';
  //textString := textString.replace(/\s+/g, ' ');
  if (Pos(' ',textString)=0) then
    SplitFix(textString,listArray)
  else
    Split(' ',textString,listArray);
  result:=ConvertCP2UTF8(listArray);
end;

function TUnicode.ConvertCP2UTF8(listArray: TStringList): String;
var outputString : String;
    n,i : Integer;
Begin
  outputString := '';
  for i := 0 to listArray.Count-1 do
  Begin
    n:= HexToInt(listArray[i]);
    if (i > 0) then outputString := outputString + ' ';

    if (n <= HexToInt('7F')) then outputString := outputString + dec2hexUTFPair(n)
    else if (n <= HexToInt('7FF')) then
      outputString := outputString + dec2hex(HexToInt('C0') or ((n SHR 6) and HexToInt('1F')))
                      + ' ' + dec2hexUTFPair(HexToInt('80') or (n and HexToInt('3F')))
    else if (n <= HexToInt('FFFF')) then
      outputString := outputString + dec2hexUTFPair(HexToInt('E0') or ((n SHR 12) and HexToInt('F')))
                      + ' ' + dec2hexUTFPair(HexToInt('80') or ((n SHR 6) and HexToInt('3F'))) + ' '
                      + dec2hexUTFPair(HexToInt('80') or (n and HexToInt('3F')))
    else if (n <= HexToInt('10FFFF')) then
      outputString := outputString + dec2hexUTFPair(HexToInt('F0') or ((n SHR 18) and HexToInt('07')))
                      + ' ' + dec2hexUTFPair(HexToInt('80') or ((n SHR 12) and HexToInt('3F'))) + ' '
                      + dec2hexUTFPair(HexToInt('80') or ((n SHR 6) and HexToInt('3F'))) + ' '
                      + dec2hexUTFPair(HexToInt('80') or (n and HexToInt('3F')))
    else
      outputString := outputString + 'error ' + dec2hexUTFPair(n) +'!';
  end;
  result:=outputString;
end;

function TUnicode.ConvertUTF82CP ( textString : String )  : String;
Var i : Integer;
    listArray : TStringList;
Begin
  result:='';
  listArray := TStringList.Create;
  ConvertUTF82CP ( textString, listArray);
  For i:=0 to listArray.Count-1 do
  Begin
    result:=result+' ' +listArray[i];
  end;
end;

function TUnicode.ConvertUTF82CPList ( textString : String )  : TStringList;
Var i : Integer;
    listArray, inputs : TStringList;
Begin
  listArray := TStringList.Create;
  inputs:=BreakOutList(textString);
  for i := 0 to inputs.Count-1 do
    if Pos('@U#',inputs[i])<>1 then
    Begin
      inputs[i]:='@@'+inputs[i];
    end
    else
    Begin
      ConvertUTF82CP ( inputs[i], listArray);
    end;
  for i := 0 to inputs.Count-1 do
    if Pos('@@',inputs[i])=1 then
      listArray.Add(inputs[i]);

  result:=listArray;
end;

function TUnicode.BreakOutList(textString: String): TStringList;
var listArray : TStringList;
begin
  listArray := TStringList.Create;
  Split(' ',textString,listArray);
  result:=listArray;
end;

procedure TUnicode.ConvertUTF82CP ( textString : String; const Strings: TStrings);
  var outputString : String;
  counter,n,i,b : Integer;
  listArray : TStringList;
Begin
  if Pos('@U#',textString)=1 then
    textString:=Copy(textString,4,Length(textString));
  outputString := '';
  counter := 0;
  n := 0;
  listArray:=TStringList.Create;
//  textString := textString.replace(/^\s+/, '');
  if (Length(textString) = 0) then exit
  else
  Begin
//  textString := textString.replace(/\s+/g, ' ');
    if (Pos(' ',textString)=0) then
      SplitFix(textString,listArray)
    else
      Split(' ',textString,listArray);
  for i := 0 to listArray.Count-1 do
  Begin
      b := HexToInt((listArray[i]));
      case (counter) of
        0:Begin
            if (0 <= b) and (b <= HexToInt('7F')) then
            Begin  // 0xxxxxxx
                      Strings.Add(dec2hex(b));
            end
            else if (HexToInt('C0') <= b) and (b <= HexToInt('DF')) then
            Begin  // 110xxxxx
                      counter := 1;
                      n := b and HexToInt('1F');
            end
            else if (HexToInt('E0') <= b) and (b <= HexToInt('EF')) then
            Begin  // 1110xxxx
                      counter := 2;
                      n := b and HexToInt('F');
            end
            else if (HexToInt('F0') <= b) and (b <= HexToInt('F7')) then
            Begin  // 11110xxx
                      counter := 3;
                      n := b and HexToInt('7');
            end
            else
            Begin
                      Strings.Add('!error ' + dec2hex(b) + '! ');
            end;
          end;
        1:Begin
            if (b < HexToInt('80')) or (b > HexToInt('BF')) then
            Begin
              Strings.Add('!error ' + dec2hex(b) + '! ');
            end;
              counter:=counter-1;
              Strings.Add(dec2hex((n SHL 6) or (b-HexToInt('80'))));
              n := 0;
          end;
        2..3:
          Begin
            if (b < HexToInt('80')) or (b > HexToInt('BF')) then
            Begin
              Strings.Add('!error ' + dec2hex(b) + '! ');
            end;
            n := (n SHL 6) or (b-HexToInt('80'));
            counter:=counter-1;
          end;
    end;
  end;
  end;
end;

initialization
finalization
  FreeAndNil(IUnicode);
end.
