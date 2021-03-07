
{                                                                              }
{  IB_Utils                                                                    }
{                                                                              }

{***************************************************************}
{                                                               }
{          IB Objects Components and Resources Library          }
{                                                               }
{          Copyright (C) 1996-2001 Jason Wharton                }
{          and Computer Programming Solutions, Mesa, AZ         }
{                                                               }
{  This source code unit is released under the terms of the     }
{  CPS Trustware License.                                       }
{  It may be distributed or deployed as source code or in       }
{  compiled form only in compliance with the terms and          }
{  conditions of the CPS Trustware License which may be         )
{  examined at http://www.ibobjects.com/ibo_trustware.html      )
{                                                               }
{***************************************************************}

{******************************************************************************}
{  CONTRIBUTED MODIFICATIONS                                                   }
{  Additions or modifications listed below using format:                       }
{                                                                              }
{  Joe Citizen <joe@joecitizen.com>                                            }
{  mm/dd/yyyy                                                                  }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{            Copyright (C) 2001 Joe Citizen                                    }
{                                                                              }
{------------------------------------------------------------------------------}
{  Place your credits and information in the top of the section                }
{  below with any other descriptions or explanations desired.                  }
{------------------------------------------------------------------------------}
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  25-Jan-02                                                                   }
{      Further adjustments to the Integer and Currency conversion methods that }
{      I added earlier (whoops forgot to document that).  Attempting to make   }
{      it so that assignments use statistical/bankers rounding for assignment. }
{                                                                              }
{ Dirk Schiffler <ds@rcs.de>                                                   }
{ 11/11/2001                                                                   }
{    date and time format strings and constants are move to IB_Constants       }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_Utils;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Grids,

  IB_Header,
  IB_Constants;

function BuffersEqual(Buf1, Buf2: Pointer; Size: Cardinal): Boolean; assembler;
function YearFromDateTime( ADateTime: TDateTime ): word;
function DateTimeToEncodeString( ADateTime: TDateTime ): string;
function EncodeStringToDateTime( AValue: string ): TDateTime;
function GetEnvVariable( const AName: string ): string;
function GetLineEndPos( const AStr: string;
                          var ALen: integer ): integer;

{$IFNDEF IBO_VCL30_OR_GREATER}
function AnsiLastChar(const S: string): PChar;
function LastDelimiter(const Delimiters, S: string): Integer;
function AnsiStrComp(S1, S2: PChar): Integer;
function AnsiStrIComp(S1, S2: PChar): Integer;

const
  FILE_ATTRIBUTE_COMPRESSED = $00000800;
{$ENDIF}


{ File: match.pas
  Author: Kevin Boylan

  This code is meant to allow wildcard pattern matches.
  It is VERY useful for matching filename wildcard patterns.
  It allows unix grep-like pattern comparisons, for instance:

    ?           Matches any single characer
    *           Matches any contiguous characters
    [abc]      Matches a or b or c at that position
    [^abc]    Matches anything but a or b or c at that position
    [!abc]    Ditto
    [a-e]      Matches a through e at that position

    'ma?ch.*'    -Would match match.exe, mavch.dat, march.on, etc
    'this [e-n]s a [!zy]est' - Would match 'this is a test',
                               but would not match 'this as a yest'

  This is a Delphi VCL translation from C code that was downloaded from CIS.
  C code was written by J. Kerceval and released to public domain 02/20/1991.
  This code is of course also public domain. I would appreciate it if you would
  let me know if you find any bugs.  I would also appreciate any notes sent my
  way letting me know if you find it useful.  My email address is

    CIS:            75221,1057
    Internet:    75221.1057@compuserve.com}

const
  { match defines }
  MATCH_PATTERN = 6;
  MATCH_LITERAL = 5;
  MATCH_RANGE   = 4;
  MATCH_ABORT   = 3;
  MATCH_END     = 2;
  MATCH_VALID   = 1;
  { pattern defines }
  PATTERN_VALID = 0;
  PATTERN_ESC   = -1;
  PATTERN_RANGE = -2;
  PATTERN_CLOSE = -3;
  PATTERN_EMPTY = -4;
  { character defines }
  MATCH_CHAR_SINGLE    = '?';
  MATCH_CHAR_KLEENE_CLOSURE = '*';
  MATCH_CHAR_RANGE_OPEN    = '[';
  MATCH_CHAR_RANGE = '-';
  MATCH_CHAR_RANGE_CLOSE = ']';
  MATCH_CHAR_CARAT_NEGATE = '^';
  MATCH_CHAR_EXCLAMATION_NEGATE    = '!';

  function IsMatch( pattern, text: String ): Boolean;
  function matche( pattern, text: String ): Integer;
  function match_after_star( pattern, text: String ): Integer;

{: SoundEx algorithm - supplied by Telesis Computing.
<br><br>
The TC_SoundEx and TC_SoundExMax are extensions to the SoundEx concept -
creating values which can be used to allow string values that "sound" alike
to be sorted together.  This is a Pascal implementation of the C++ code which
I use in my own C++Builder application and Interbase UDF.  (Obviously the
code used by your application MUST match the code used by the server!)
<br><br>
I have supplied this code for convenience.  You can use it or not as you like.
<br><br>
For those who would rather a more standard SoundEx implementation, you may
like to look at the FreeUDF library written by Gregory Deatz which provides
(in Pascal) code which can be used in both a UDF and your application.
<br><br>
Besides the FreeUDF library there is also some information on the Interbase
web-site which goes into how and why the SoundEx algorithm works.  I won't
try and repeat that here.
<br><br>
My extensions to the SoundEx algorithm have two main purposes...
<br><br>
    1. By implementing a full 32bit value I can use 8 or 9 significant
    characters from the source string making the result much more specific
    for longer strings.  (Less duplication in the indexes.)
<br><br>
    2. By implementing the SoundEx and SoundExMax algorithms correctly it
    is possible to perform a select on a string that "sounds" like it "starts"
    with a particular text.  Essentially this is a partial key style match
    but using the "fuzzy" matching of SoundEx.
<br><br>
These implementations return integer (32bit) values.  If you are going to use
these in conjunction with the TIB_Connection.OnSoundExParse and
TIB_Connection.OnSoundExMaxParse then you will need to include the following
code in the resulting event handler...
<br><br>
    ResultStr := IntToStr( TC_SoundEx( SourceStr ) );
<br><br>
Implementation made at the bottom of this module.
}
function TC_SoundEx( SourceStr: string ): longint;
function TC_SoundExMax( SourceStr: string ): longint;
// End TC_SoundEx Interface stuff

function metaph( a: string; lg: integer ): string;

procedure DrawShallowEdge( ACanvas: TCanvas;
                           ARect: TRect;
                           Options: TGridOptions );

function EncryptIBPass( Password: string ): string;

function BinaryToHexText( ABuffer: pointer;
                          ALength: integer ): string;
procedure HexTextToBinary( AHexText: string;
                           ABuffer: pointer;
                           ALength: integer );
function HexTextToString( AHexText: string;
                          ALength: integer ): string;

const
{: See JumbleString function description for details.}
    JumblePrefix_v01: string = '.JuMbLe.01.';
{: See JumbleString function description for details.}
    JumblePreference: integer = 1;
{: See GetJumbleKey function description for details.}
    JumbleDefaultSecLevel: integer = 2;

var
{: Registry key used by GetJumbleKey for storing/retrieving
the key value used to obscure saved passwords.  Note that this has been
setup as a variable so that applications can initialise the value at
startup to some alternative value if desired.}
    JumbleRegKey: HKEY = HKEY_CURRENT_USER;
{: Registry base path used by GetJumbleKey for storing/retrieving
the key value used to obscure saved passwords. Note that this has been
setup as a variable so that applications can initialise the value at
startup to some alternative value if desired.}
    JumbleRegPath: string = '\Software\CPS\IBO\Security';

{: GetJumbleKey is used to retrieve an encryption/decryption key for
the JumbleString and UnJumbleString functions.
<br><br>
TIB_Connection uses this when PasswordRemembered=true.  This allows
TIB_Connection to obscure the password when it is stored in the DFM (and
resulting executable).
<br><br>
Before this capability was introduced the password was stored in plain text
and unless you remembered to clear the password it was possible to distribute
the executable which stored the password to your database.
<br><br>
It is IMPORTANT to realise that this protection is not entirely secure.  In
particular the key value which is used to obscure the password is stored in
the registry.  So if you intend to set PasswordRemembered=true then you
need to be aware that anyone that can access your registry can find the key
which will reveal the obscured password!
<br><br>
The default registry location used by this function is defined in the
JumbleRegKey and JumbleRegPath vars.  Within that path it creates
two entries: Level and JumbleKey.
<br><br>
Level defines the level of security used.  It has three possible values...
<br>
0 = disabled.  Saved passwords will be stored in plain text.
<br>
1 = use default key.  The encrypt/decrypt processes will use an internal
default key value - the same for all IBO users.  This may be useful if
you regularly share projects and want the password to be distributed.
<br>
2 = use the 'JumbleKey' value as the key.  This is the default, this
will make it more difficult (but not impossible) for someone to extract
your password distributed in DFM or executable files.
<br><br>
JumbleKey is the key value used to encrypt and decrypt passwords obscured by
TIB_Connection when Level is set to '2'.  When first used this value is a
randomly generated string, so all users should have a different value.
If you intend to distribute applications with the password stored in the
executable, you must either change the Level to 0 or 1 (the same on all
installations), or you must update the JumbleKey value to be the same in
all installations, or supply the password yourself from a different
property or resource.
<br>
<br>
If Level is set to a value < 0 then the registry entries will be reset to
their defaults (and the JumbleKey regenerated as a new random entry).  If
JumbleKey is deleted or set to a blank value, and Level = 2, then the value
will be regenerated to a new random string.  In either case any previously
saved passwords will no longer be able to be read, unless you update
JumbleKey to it previous value.
}
function GetJumbleKey: string;

{: JumbleString algorithm - supplied by Telesis Computing.
<br><br>
JumbleString / UnJumbleString is a very basic encryption algorithm.
I repeat VERY BASIC!  It is not secure and definitely vulnerable to a fairly
simple brute force attack.  For this reason I call the procedures "Jumble"
and "UnJumble" rather than encrypt/decrypt so that no-one gets the wrong idea.
<br><br>
The intended use of these algorithms is simply to obscure data so that
it is not directly human readable.  Someone will have to actually put
some work into retrieving the true value.
<br><br>
This has been implemented for the "PasswordRemembered" property of
TIB_Connection so that passwords are not human readable when stored in DFM
(and therefore executable) files.
<br><br>
The functions use a prefix to the jumbled value.  This allows
the UnJumble function to identify values which have not been jumbled,
and so return the original value.  (Which allows this to be used in
instances where previous data may not have been jumbled.)
<br><br>
Prefix = '.JuMbLe.01.' = version 01 jumble
<br>
The additional idea behind the prefix is that extensions to the function
can be added to upgrade its capability later.  So in the future a prefix
of '.JuMbLe.02.' may appear which provides more sophisticated encryption.
The global constant 'JumblePreference' will be used to choose which
algorithm will be implemented by the JumbleString function by default.
While UnJumbleString will simply read the prefix value to determine how
a particular string should be unjumbled.
<br><br>
So a string line 'abcdef' will be returned from UnJumbleString directly
whereas a value like '.JuMbLe.01.abcdef' will have the value 'abcdef'
unjumbled.
<br><br>
Note:  ANY time the prefix value is passed to the UnJumble function as the
beginning of a string it will try to unjumble it.  So it will not be possible
to see an unjumbled password that begins with this value.  This should be
highly unlikely - and should only be a problem when converting passwords from
previously unjumbled state to the new jumbled state.  Since Interbase passwords
are only significant to 8 characters anyway, it should be even less likely
that we will see a problem with the prefix.
<br><br>
Note 2:  JumbleString will detect an already jumbled value and will not
try to jumble it a second time.
<br>
<br>
If a blank string is provided as the KeyPhrase then no jumble or unjumble
takes place.  The Value parameter is simply returned as it is.
<br><br><br><br>
Note to anyone wishing to update these functions.  May I suggest that, if
you intend to implement a more sophisticated encrytion algorithm, you
use the KeyPhrase supplied to the function as the source for a Hash function
that will feed the necessary number of bits into the actual encryption
algorithm.  Such an approach keeps the interface simple and consistent,
minimising the need to change other areas of the source.
}
function JumbleString( Value, KeyPhrase: string ): string;

{: Like JumbleString but provides a parameter to express which
jumble algorithm to use.  The only acceptable value at this stage
is 1. }
function JumbleStringEx( Value, KeyPhrase: string; Alg: integer ): string;

{: See description of JumbleString function for details. }
function UnJumbleString( Value, KeyPhrase: string ): string;

{: A version of the FileOpen() function that will create the file if it does
not already exist. This saves routines having to use the FileExists() function
and end up always hitting the FILE System two times for read/write operations.}

{: This is the function used to check/convert input characters to particular
case.  PrevChar is the character preceeding the NewChar in the destination
string.  ChChase specifies the case to which you want NewChar converted. }
function ConvCharCase( PrevChar, NewChar: char; ChCase: integer ): char;

procedure IB_ReallocMem( var Ptr: pointer; OldSize, NewSize: longint );
function isc_decode_TDateTime( const Src: pisc_quad ): TDateTime;
procedure isc_encode_TDateTime( const Src: TDateTime; const Dst: pisc_quad );
function isc_quad_equal( const Q1, Q2: isc_quad ): boolean;
function isc_quad_is_zero( const Q1: isc_quad ): boolean;
function isc_quad_string( const AQuad: isc_quad ): string;

function ScaleExtended( const AVal: extended; AScale: smallint ): extended;
function IntegerToCurrency( const AVal: integer; AScale: smallint ): currency;
function Int64ToCurrency( AVal: ISC_INT64; AScale: smallint ): currency;
function ExtendedToInt64( AVal: extended; AScale: smallint ): ISC_INT64;
function ExtendedToInteger( AVal: extended; AScale: smallint ): integer;
function ExtendedToSmallint( AVal: extended; AScale: smallint ): smallint;
function CurrencyToInteger( AVal: currency; AScale: smallint ): integer;
function CurrencyToSmallint( AVal: currency; AScale: smallint ): smallint;
function CurrencyToInt64( AVal: currency; AScale: smallint ): ISC_INT64;
{$IFDEF IBO_VCL40_OR_GREATER}
function StrToInt64Scaled( const AValue: string; AScale: integer ): int64;
function Int64ScaledToStr( const AValue: int64; AScale: integer ): string;
{$ENDIF}

implementation

uses
  Unixpass, Registry;

function EncryptIBPass( Password: string ): string;
begin
  Result := CreateInterbasePassword( Password );
end;

{$IFNDEF IBO_VCL30_OR_GREATER}
function AnsiStrIComp(S1, S2: PChar): Integer;
begin
  Result := CompareString( LOCALE_USER_DEFAULT,
                           NORM_IGNORECASE,
                           S1, -1,
                           S2, -1 ) - 2;
end;
function AnsiStrComp(S1, S2: PChar): Integer;
begin
  Result := CompareString(LOCALE_USER_DEFAULT, 0, S1, -1, S2, -1) - 2;
end;
function AnsiLastChar(const S: string): PChar;
var
  LastByte: Integer;
begin
  LastByte := Length(S);
  if LastByte <> 0 then
  begin
    Result := @S[LastByte];
//    if ByteType(S, LastByte) = mbTrailByte then Dec(Result);
  end
  else
    Result := nil;
end;

function LastDelimiter(const Delimiters, S: string): Integer;
var
  P: PChar;
begin
  Result := Length(S);
  P := PChar(Delimiters);
  while ( Result > 0 ) and
        not ((S[Result] <> #0) and
            (StrScan(P, S[Result]) <> nil)) do begin
    Dec(Result);
  end;
end;
{$ENDIF}

function GetLineEndPos( const AStr: string;
                          var ALen: integer ): integer;
var
  AType: string;
  LFPos: integer;
begin
  AType := '';
  ALen := 0;
  Result := Pos( #13#10, AStr );
  if Result > 0 then
    ALen := 1
  else
    Result := Pos( #13, AStr );
  LFPos := Pos( #10, AStr );
  if ( LFPos > 0 ) and (( LFPos < Result ) or ( Result = 0 )) then
  begin
    Result := LFPos;
    ALen := 0;
  end;
end;

function BuffersEqual(Buf1, Buf2: Pointer; Size: Cardinal): Boolean; assembler;
asm
        PUSH    EDI
        PUSH    ESI
        MOV     ESI,Buf1
        MOV     EDI,Buf2
        XOR     EAX,EAX
        JECXZ   @@1
        CLD
        REPE    CMPSB
        JNE     @@1
        INC     EAX
@@1:    POP     ESI
        POP     EDI
end;

function YearFromDateTime( ADateTime: TDateTime ): word;
var
  Day, Month: word;
begin
  DecodeDate( ADateTime, Result, Month, Day );
end;

function DateTimeToEncodeString( ADateTime: TDateTime ): string;
var
  Day, Month, Year, Hour, Minute, Second, MSec: word;
begin
  Result := '';
  if ADateTime > 0 then begin
    DecodeDate( ADateTime, Year, Month, Day );
    DecodeTime( ADateTime, Hour, Minute, Second, MSec );
    Result := Format( DTEncode_DecodeFormat,
        [Year,Month,Day,Hour,Minute,Second,MSec] );
  end else begin
    // DecodeDate does not support values <= 0, so we must find
    // another way.
    Result := FormatDateTime( DTEncode_DateTimeFormat, ADateTime );
    // Note that FormatDateTime does not support resolution greater
    // than single seconds, so the additional points of seconds required
    // for the standard EncodeString value are added as .0000
    // Since this is only for values <= 1899/12/31 I am assuming that
    // the additional resolution will not be essential.
  end;
end;

// Possibly this function should use the delimiters to identify the
// specific sections of the date/time string.  (Especially since I have
// so specifically defined these as constant values, not locale specific.
// However this should not be necessary (although it may be more reliable).
// The main reason for defining the delimiters so explicitly is in case
// some external use is made of the values created by these functions.
function EncodeStringToDateTime( AValue: string ): TDateTime;
var
  Day, Month, Year, Hour, Minute, Second, MSec: word;
  tmpStr: string;
begin
  if AValue = '12/30/1899 00:00' then
    Result := 0
  else
    try
      Year := StrToInt( Copy(AValue,1,4) );
      Month := StrToInt( Copy(AValue,6,2) );
      Day := StrToInt( Copy(AValue,9,2) );
      Hour := StrToInt( Copy(AValue,12,2) );
      Minute := StrToInt( Copy(AValue,15,2) );
      Second := StrToInt( Copy(AValue,18,2) );
      // Ensuring that we cope if some accidently sends us a value with
      // less than the require number of digits...
      tmpStr := Trim(Copy(AValue,21,4)) + '0000';
      // Read only 3 digits to get "milli" seconds, not the full 4 digits
      // which are available from the string to give 10000ths of a second
      // (This is a truncate rather than a round, but it should be adequate)
      MSec := StrToInt( Copy(tmpStr,1,3) );
      Result := EncodeDate( Year, Month, Day );
      if Result >= 0 then
        Result := Result + EncodeTime( Hour, Minute, Second, MSec )
      else
        Result := Result - EncodeTime( Hour, Minute, Second, MSec );
    except
      Result := StrToDateTime( AValue );
    end;
end;

function IsMatch( pattern, text: String ): Boolean;
begin
  Result := matche( pattern, text ) = 1;
end;

function matche( pattern, text: String ): Integer;
var
  range_start,
  range_end,
  p,
  t,
  plen,
  tlen: Integer;
  invert,
  member_match,
  loop: Boolean;
begin
    p := 1;
    t := 1;
    pattern := AnsiLowerCase(pattern);
    text := AnsiLowerCase(Text);
    plen := Length( pattern );
    tlen := Length( text );
    Result := 0;
    While ( (Result = 0) and (p <= plen) ) do begin
        if (t > tlen) then begin
            if (pattern[p] = MATCH_CHAR_KLEENE_CLOSURE) and
                 (p+1 > plen) then
                Result := MATCH_VALID
            else
                Result := MATCH_ABORT;
            exit;
        end else Case (pattern[p]) of
                MATCH_CHAR_KLEENE_CLOSURE:
                    Result := match_after_star(Copy(pattern,p,plen),Copy(text,t,tlen));
                MATCH_CHAR_RANGE_OPEN:
                    begin
                        Inc(p);
                        invert := False;
                        if (pattern[p] = MATCH_CHAR_EXCLAMATION_NEGATE) or
                            (pattern[p] = MATCH_CHAR_CARAT_NEGATE) then begin
                            invert := True;
                            Inc(p);
                        end;
                        if (pattern[p] = MATCH_CHAR_RANGE_CLOSE) then begin
                            Result := MATCH_PATTERN;
                            exit;
                        end;
                        member_match := False;
                        loop := True;
                        While ((loop) and (pattern[p] <> MATCH_CHAR_RANGE_CLOSE)) do begin
                            range_start := p;
                            range_end := p;
                            Inc(p);
                            if (p > plen) then begin
                                Result := MATCH_PATTERN;
                                exit;
                            end;
                            if (pattern[p] = MATCH_CHAR_RANGE) then begin
                                Inc(p);
                                range_end := p;
                                if (p > plen) or (pattern[range_end] = MATCH_CHAR_RANGE_CLOSE) then begin
                                    Result := MATCH_PATTERN;
                                    exit;
                                end;
                                Inc(p);
                            end;
                            if (p > plen) then begin
                                Result := MATCH_PATTERN;
                                exit;
                            end;
                            if (range_start < range_end) then begin
                                if (text[t] >= pattern[range_start]) and
                                   (text[t] <= pattern[range_end]) then
                                begin
                                    member_match := True;
                                    loop := False;
                                end;
                            end else begin
                              if (text[t] >= pattern[range_end]) and
                                  (text[t] <= pattern[range_start]) then
                                  begin
                                    member_match := True;
                                    loop := False;
                                  end;
                            end; { if (range_start < range_end) }
                        end; { while (loop) }

                        if (invert and member_match) or (not(invert or member_match)) then begin
                            Result := MATCH_RANGE;
                            exit;
                        end;
                        if (member_match) then while ((p <= plen) and (pattern[p] <> MATCH_CHAR_RANGE_CLOSE)) do Inc(p);
                        if (p > plen) then begin
                            Result := MATCH_PATTERN;
                            exit;
                        end;
                    end; { MATCH_CHAR_RANGE_OPEN: }
                Else
                    if (pattern[p] <> MATCH_CHAR_SINGLE) then
                        if (pattern[p] <> text[t]) then Result := MATCH_LITERAL;
            end; { Case pattern[p] }
        Inc(p);
        Inc(t);
    end; { While ( (Result = 0) and (p < plen) ) }
    if (Result = 0) then
        if (t <= tlen) then    Result := MATCH_END
                       else    Result := MATCH_VALID;
end;

function match_after_star( pattern, text: String ): Integer;
var
    p,
    t,
    plen,
    tlen        : Integer;
begin
    Result := 0;
    p := 1;
    t := 1;
    plen := Length(pattern);
    tlen := Length(text);
    While (( t <= tlen ) and (p < plen)) and
            (pattern[p] = MATCH_CHAR_SINGLE) or
            (pattern[p] = MATCH_CHAR_KLEENE_CLOSURE) do begin
        If (pattern[p] = MATCH_CHAR_SINGLE) then Inc(t);
        Inc(p);
    end;
    If (t > tlen) then begin
        Result := MATCH_ABORT;
        exit;
    end;
    If (p > plen) then begin
        Result := MATCH_VALID;
        exit;
    end;
  repeat
        If (pattern[p] = text[t]) or (pattern[p] = MATCH_CHAR_RANGE_OPEN) then
        begin
            pattern := Copy(pattern,p,plen);
            text := Copy(text,t,tlen);
            plen := Length(pattern);
            tlen := Length(text);
            p := 1;
            t := 1;
            Result := matche( pattern , text );
        end;
        if (t > tlen) then begin
            Result := MATCH_ABORT;
            exit;
        end;
        Inc(t);
  until ( Result <> 0 );
end;

// Start TC_SoundEx implementation stuff
{------------------------------------------------------------------------------}
// This table gives the SoundEX SCORE for all characters Upper and Lower Case
// hence no need to convert. This is faster than doing an UpCase on the whole
// input string.
const SoundExTable: array [char] of smallint = (
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, // 0..29
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, // 30..59
  0,0,0,0,0,                                                   // 60..64
//A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [ / ] ^ _ '
  0,1,2,3,0,1,2,0,0,2,2,4,5,5,0,1,2,6,2,3,0,1,0,2,0,2,0,0,0,0,0,0,
//a b c d e f g h i j k l m n o p q r s t u v w x y z
  0,1,2,3,0,1,2,0,0,2,2,4,5,5,0,1,2,6,2,3,0,1,0,2,0,2,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,         // 123..149
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,   // 150..179
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,   // 180..209
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,   // 210..239
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 );                             // 240..255

// In order to keep consistency of values, the multiplication starts large
// and reduces for each subsequent index character - allowing me to use
// range selection later if required.  I multiply out for 8 characters worth
// - which is 24 bit shifts to the right (or 16777216).
const SoundExMultiplier: longint = 24;

// While the individual index characters are weighted as 0..6, I use a value
// of 8 for the index multiplier (to create a total numeric value).  This
// allows me to use power of 2 multiplication (bit shifting) which is faster
// than normal multiplication.
// This will be reduced by 3 units for each index character retrieved
// (after the first).
function TC_SoundEx( SourceStr: string ): longint;
var
  Multiplier,
  LastScore,
  ThisScore: longint;
  i,
  slen: integer;
  InitCh: char;
begin
  Result := 0;
  Multiplier := SoundExMultiplier;
  LastScore := 0;
  i := 1;
  slen := Length( SourceStr );
  if( slen > 0 ) then begin
    InitCh := SourceStr[i];
    // Single character uppercase conversion...
    if( InitCh in ['a'..'z'] ) then begin
      InitCh := Chr( Ord( InitCh ) - Ord( 'a' ) + Ord( 'A' ));
    end;
    Result := (longint(Ord(InitCh)) shl Multiplier);
    Inc( i );
    Dec( Multiplier, 3 );
    while( i <= slen ) do begin
      ThisScore := SoundExTable[SourceStr[i]];
      if( ThisScore <> LastScore ) then begin
          Result := Result + (ThisScore shl Multiplier);
          Dec( Multiplier, 3 );
          if( Multiplier < 0 ) then break;
          end;
      LastScore := ThisScore;
      Inc( i );
    end;
  end;
end;

// Same as TC_SoundEx except that it fills any unused character positions of
// the index with their maximum value...
function TC_SoundExMax( SourceStr: string ): longint;
var
  Multiplier,
  LastScore,
  ThisScore: longint;
  i,
  slen: integer;
  InitCh: char;
begin
  Result := 0;
  Multiplier := SoundExMultiplier;
  LastScore := 0;
  i := 1;
  slen := Length( SourceStr );
  if( slen > 0 ) then begin
    InitCh := SourceStr[i];
    // Single character uppercase conversion...
    if( InitCh in ['a'..'z'] ) then begin
      InitCh := Chr( Ord( InitCh ) - Ord( 'a' ) + Ord( 'A' ));
    end;
    Result := (longint(Ord(InitCh)) shl Multiplier);
    Inc( i );
    Dec( Multiplier, 3 );
    while( i <= slen ) do begin
      ThisScore := SoundExTable[SourceStr[i]];
      if( ThisScore <> LastScore ) then begin
        Result := Result + (ThisScore shl Multiplier);
        Dec( Multiplier, 3 );
        if( Multiplier < 0 ) then break;
      end;
      LastScore := ThisScore;
      Inc( i );
    end;
    while( Multiplier >= 0 ) do begin
      if( Multiplier > 0 ) then
          Result := Result +  ( 7 shl Multiplier )
      else Result := Result + 7;
      Dec( Multiplier, 3 );
    end;
  end;
end;

// Metaphone algorithm translated by Tom White <wcs@intellex.com>
// Original C version by Michael Kuhn <rhlab!mkuhn@uunet.uu.net>

// a:  pointer to input string
// lg: max length of return string
function metaph( a: string; lg: integer ): string;
const
  vowels='AEIOU';
  frontv='EIY';
  varson='CSPTG';
  dbl='.';  {Lets us allow certain letters to be doubled}
  excppair='AGKPWP'; //added PS 6/2/98 for Dave Green
  nxtltr  ='ENNNRS';
  alphachr='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  b, c : string;
  inp, outp : string;
  t, ii, slength : integer;
  curltr, prevltr, nextltr, nextltr2, nextltr3 : char;
  vowelafter, vowelbefore, frontvafter, silent, hard : boolean;
begin
  Result := '';
  if lg = 0 then Exit;

  {Remove non-alpha characters}
  inp := uppercase(a);
  outp := '';
  for t := 1 to Length( inp ) do begin
    if pos(inp[t],alphachr)>0 then begin
      outp := outp + inp[t];
    end;
  end;
  inp := outp;
  outp := '';
  {Check rules at beginning of word}
  slength := length(inp);
  if slength > 1 then begin  //completely changed 6/2/98, old method was *bad*
    b := inp[1];
    c := inp[2];
    for t :=  1 to length(excppair) do begin
      if (b=excppair[t]) and (c=nxtltr[t]) then begin
        System.Delete( inp, 1, 1 );
        dec(slength);
        break;
      end;
    end;
  end else if slength = 0 then begin
    Exit;
  end;
  if inp[1]='X' then begin
    inp[1] := 'S';
  end;
  if (slength>2) and (copy(inp,1,2)='WH') then begin
    System.Delete( inp, 2, 1 );
    dec(slength);
  end;
  if (slength>1) and (inp[slength]='S') then begin
    System.Delete( inp, slength, 1 );
    dec(slength);
  end;
  ii := 0;
  repeat
    Inc( ii );
    {Main Loop!}
    hard := false;
    curltr := inp[ii];
    vowelbefore := false;
    prevltr := ' ';
    if ii>1 then begin
      prevltr := inp[ii-1];
      if pos(prevltr,vowels)>0 then
        vowelbefore := true;
    end;
    if ((ii=1) and (pos(curltr,vowels)>0)) then begin
      outp := outp+curltr;
      continue;
    end;
    vowelafter := false;
    frontvafter := false;
    nextltr := ' ';
    if ii < slength then begin
      nextltr := inp[ii+1];
      if pos(nextltr,vowels)>0 then vowelafter := true;
      if pos(nextltr,frontv)>0 then frontvafter := true;
    end;
    {Skip double letters EXCEPT ones in variable double}
    if pos(curltr,dbl)=0 then
      if curltr=nextltr then
        continue;
    nextltr2 := ' ';
    if (slength-ii)>1 then
      nextltr2 := inp[ii+2];
    nextltr3 := ' ';
    if (slength-ii)>2 then
      nextltr3 := inp[ii+3];
    case curltr of
      'B' : begin
              silent := false;
              if (ii=slength) and (prevltr='M') then
                silent := true;
              if not silent then outp := outp+curltr;
            end;
      'C' : begin
              if not ((ii>2) and (prevltr='S') and frontvafter) then
                if ((ii>1) and (nextltr='I') and (nextltr2='A')) then
                  outp := outp+'X'
                else
                  if frontvafter then begin
                    outp := outp+'S';
                  end else begin
                    if ((ii>2) and (prevltr='S') and (nextltr='H')) then begin
                      outp := outp+'K';
                    end else begin
                      if nextltr='H' then begin
                        if ((ii=1) and (pos(nextltr2,vowels)=0)) then
                          outp := outp+'K'
                        else
                          outp := outp+'X';
                      end else begin
                        if prevltr='C' then
                          outp := outp+'C'
                        else
                          outp := outp+'K';
                      end;
                    end;
                  end;
              end;
      'D' : begin
              if ((nextltr='G') and (pos(nextltr2,frontv)>0)) then
                outp := outp+'J'
              else
                outp := outp+'T';
            end;
      'G' : begin
              silent := false;
              if ((ii<slength) and (nextltr='H') and (pos(nextltr2,vowels)=0)) then
                silent := true;
              if ((ii=slength-4) and (nextltr='N') and (nextltr2='E') and
                (nextltr3='D')) then silent := true
              else if ((ii=slength-2) and (nextltr='N')) then silent := true;
              if (prevltr='D') and frontvafter then silent := true;
              if prevltr='G' then
                hard := true;
              if not silent then begin
                if frontvafter and (not hard) then
                  outp := outp+'J'
                else
                  outp := outp+'K';
              end;
            end;
      'H' : begin
              silent := false;
              if pos(prevltr,varson)>0 then silent := true;
              if vowelbefore and (not vowelafter) then silent := true;
              if not silent then outp := outp+curltr;
            end;
      'F', 'J', 'L', 'M', 'N', 'R' : outp := outp+curltr;
      'K' : if prevltr<>'C' then outp := outp+curltr;
      'P' : if nextltr='H' then outp := outp+'F' else outp := outp+'P';
      'Q' : outp := outp+'K';
      'S' : begin
              if ((ii>2) and (nextltr='I') and ((nextltr2='O') or (nextltr2='A'))) then
                outp := outp+'X';
              if (nextltr='H') then
                outp := outp+'X'
              else
                outp := outp+'S';
            end;
      'T' : begin
              if ((ii>0) and (nextltr='I') and ((nextltr2='O') or (nextltr2='A'))) then
                outp := outp+'X';
              if nextltr='H' then begin
                if ((ii>1) or (pos(nextltr2,vowels)>0)) then
                  outp := outp+'0'
                else
                  outp := outp+'T';
              end else
                if not ((ii<slength-3) and (nextltr='C') and (nextltr2='H')) then
                  outp := outp+'T';
            end;
      'V' : outp := outp+'F';
      'W', 'Y' : if (ii<slength-1) and vowelafter then outp := outp+curltr;
      'X' : outp := outp+'KS';
      'Z' : outp := outp+'S';
    end;
  until (length(outp)>=lg) or (ii>=slength); //added slength 6/2/98
  Result := outp;
end;

procedure DrawShallowEdge( ACanvas: TCanvas;
                           ARect: TRect;
                           Options: TGridOptions );
begin
  with ACanvas do begin
    Pen.Style := psSolid;
    Pen.Width := 1;
    Pen.Color := clBtnShadow;
    if goFixedVertLine in Options then begin
      MoveTo( ARect.Right, ARect.Bottom );
      LineTo( ARect.Right, ARect.Top );
    end;
    if goFixedHorzLine in Options then begin
      MoveTo( ARect.Left, ARect.Bottom );
      LineTo( ARect.Right + 1, ARect.Bottom );
    end;
    Pen.Color := clBtnHighlight;
    if goFixedVertLine in Options then begin
      MoveTo( ARect.Left, ARect.Top );
      LineTo( ARect.Left, ARect.Bottom );
    end;
    if goFixedHorzLine in Options then begin
      MoveTo( ARect.Left, ARect.Top );
      LineTo( ARect.Right + 1, ARect.Top );
    end;
  end;
end;

function GetEnvVariable( const AName: string ): string;
{$IFNDEF IBO_VCL60_OR_GREATER}
var
  tmpInt: integer;
begin
  SetLength( Result, 256 );
  tmpInt := Windows.GetEnvironmentVariable( PChar( AName ),
                                            PChar( Result ),
                                            256 );
  if tmpInt < 256 then
    SetLength( Result, tmpInt )
  else
  begin
    Setlength( Result, tmpInt );
    tmpInt := Windows.GetEnvironmentVariable( PChar( AName ),
                                              PChar( Result ),
                                              tmpInt );
    SetLength( Result, tmpInt );
  end;
{$ELSE}
begin
  Result := GetEnvironmentVariable( AName );
{$ENDIF}
end;


{------------------------------------------------------------------------------}

function BinaryToHexText( ABuffer: pointer;
                          ALength: integer ): string;
var
  ii, jj: integer;
  tmpBuf: ^byte;
begin
  if not Assigned( ABuffer ) then
    Result := ''
  else
  begin
    tmpBuf := ABuffer;
    SetLength( Result, ALength * 2 );
    for ii := 0 to ALength - 1 do begin
      jj := ii * 2 + 1;
      if tmpBuf^ div 16 < 10 then begin
        Result[ jj ] := Chr( Ord( '0' ) + tmpBuf^ div 16 );
      end else begin
        Result[ jj ] := Chr( Ord( 'A' ) + tmpBuf^ div 16 - 10 );
      end;
      Inc( jj );
      if tmpBuf^ mod 16 < 10 then begin
        Result[ jj ] := Chr( Ord( '0' ) + tmpBuf^ mod 16 );
      end else begin
        Result[ jj ] := Chr( Ord( 'A' ) + tmpBuf^ mod 16 - 10 );
      end;
      Inc( tmpBuf );
    end;
  end;
end;

procedure HexTextToBinary( AHexText: string;
                           ABuffer: pointer;
                           ALength: integer );
var
  ii: integer;
  tmpBuf: ^byte;
  Bits: char;
begin
  tmpBuf := ABuffer;
  if Length( AHexText ) < ALength * 2 then
    raise Exception.Create( 'Invalid text in HexTextToBinary' );
  for ii := 0 to ALength - 1 do begin
    Bits := AHexText[ ii * 2 + 1 ];
    case Bits of
      '0'..'9': tmpBuf^ := 16 * ( Ord( Bits ) - Ord( '0' ));
      'A'..'F': tmpBuf^ := 16 * ( Ord( Bits ) - Ord( 'A' ) + 10 );
    end;
    Bits := AHexText[ ii * 2 + 2 ];
    case Bits of
      '0'..'9': tmpBuf^ := tmpBuf^ + Ord( Bits ) - Ord( '0' );
      'A'..'F': tmpBuf^ := tmpBuf^ + Ord( Bits ) - Ord( 'A' ) + 10;
    end;
    Inc( tmpBuf );
  end;
end;

function HexTextToString( AHexText: string; ALength: integer ): string;
var
  ii: Integer;
  tmpBuf: ^Byte;
  Bits: Char;
begin
  Result := '';
  if ( Length( AHexText ) < ALength * 2 ) then
    Exit;
  SetLength( Result, ALength );
  tmpBuf := @Result[1];
  for ii := 0 to ( ALength - 1 ) do
  begin
    Bits := AHexText[ ii * 2 + 1 ];
    case Bits of
      '0'..'9': tmpBuf^ := 16 * ( Ord( Bits ) - Ord( '0' ));
      'A'..'F': tmpBuf^ := 16 * ( Ord( Bits ) - Ord( 'A' ) + 10 );
    end;
    Bits := AHexText[ ii * 2 + 2 ];
    case Bits of
      '0'..'9': tmpBuf^ := tmpBuf^ + Ord( Bits ) - Ord( '0' );
      'A'..'F': tmpBuf^ := tmpBuf^ + Ord( Bits ) - Ord( 'A' ) + 10;
    end;
    Inc( tmpBuf );
  end;
end;

function GetJumbleKey: string;
var
  Reg: TRegistry;
  SecLvl: integer;
  tmpStr: string;

  // Generate a string of 16 random characters - the default
  // jumble key installed if no key already supplied in the
  // registry.
  function GetRandomString: string;
  var
    i: integer;
  begin
    Result := '';
    Randomize;
    for i := 1 to 16 do begin
      // Avoid null character.
      Result := Result + char( Random(254) + 1 );
    end;
  end;

begin
  Result := '';
  Reg := TRegistry.Create;
  try
    Reg.RootKey := JumbleRegKey;
    // To minimise security issues we try to open with just read access
{$IFDEF IBO_VCL50_OR_GREATER}
    Reg.Access := KEY_READ;
{$ENDIF}
    SecLvl := -1;
    tmpStr := '';
    if Reg.KeyExists( JumbleRegPath ) then
    begin
{$IFDEF IBO_VCL50_OR_GREATER}
      if Reg.OpenKey( JumbleRegPath, false ) then
{$ELSE}
{$IFDEF IBO_VCL40_OR_GREATER}
      if Reg.OpenKeyReadOnly( JumbleRegPath ) then
{$ELSE}
      if Reg.OpenKey( JumbleRegPath, false ) then
{$ENDIF}
{$ENDIF}
      begin
        if Reg.ValueExists( 'Level' ) then
          SecLvl := StrToInt(Reg.ReadString( 'Level' ));
        tmpStr := Reg.ReadString( 'JumbleKey' );
        Reg.CloseKey;
      end;
    end;
    // Only if values do not exist (or Level indicates reset) do we
    // actually open the registry for writing/all access.
    if SecLvl <= -1 then
    begin
{$IFDEF IBO_VCL50_OR_GREATER}
      Reg.Access := KEY_ALL_ACCESS;
{$ENDIF}
      if Reg.OpenKey( JumbleRegPath, true ) then
      begin
        SecLvl := JumbleDefaultSecLevel;
        tmpStr := GetRandomString;
        Reg.WriteString( 'Level', IntToStr(SecLvl) );
        Reg.WriteString( 'JumbleKey', tmpStr );
        Reg.CloseKey;
      end;
    end;
  finally
    Reg.Free;
  end;
  // When we get to here SecLvl indicates the required security level
  // and tmpStr is set to the required key is SecLvl = 2
  // If Level = 0 then return blank jumble key.  It is upto the
  // caller to detect this and avoid calling the actual Jumble
  // functions (which will provide their own jumble key by default).
  if SecLvl = 0 then
    Result := ''
  // If Level = 1 then return a standard/default key value
  // (just the JumblePrefix_v01 string itself.  As good a default as any.
  else
    if SecLvl = 1 then
      Result := JumblePrefix_v01
    // If Level >= 2 then return the string stored in JumbleKey registry entry
    else
      if SecLvl >= 2 then
        Result := tmpStr;
end;


function JumbleString( Value, KeyPhrase: string ): string;
begin
  Result := JumbleStringEx( Value, KeyPhrase, JumblePreference );
end;

function JumbleStringEx( Value, KeyPhrase: string; Alg: integer ): string;
var
  tmpStr: string;
  ii, jj: integer;
begin
  // No key, no jumble
  if KeyPhrase = '' then begin
    Result := Value;

  end else begin
    // If already jumbled then return string asis, to not re-jumble.
    tmpStr := Copy( Value, 1, Length( JumblePrefix_v01 ) );
    if tmpStr = JumblePrefix_v01 then begin
      Result := Value;

    // implement the jumble and add prefix
    end else begin
      // Implement the desired algorithm
      // at this tage only one implementation is defined
      if Alg = 1 then begin
        tmpStr := '';
        jj := 1;
        for ii := 1 to Length( Value ) do begin
          tmpStr := tmpStr + char( Ord(Value[ii]) XOR Ord(KeyPhrase[jj]) );
          Inc( jj );
          if jj > Length( KeyPhrase ) then
            jj := 1;
        end;
        // Convert the result to a string of hex for safer storage and useage
        tmpStr := BinaryToHexText( PChar(tmpStr), Length(tmpStr) );
        Result := JumblePrefix_v01 + tmpStr;
      end  // Alg = 1

      // If no algorithm specified, no jumble done
      else begin
        Result := Value;
      end;
    end;
  end;
end;

function UnJumbleString( Value, KeyPhrase: string ): string;
var
  tmpStr: string;
  ii, jj: integer;
begin
  // No key, no unjumble
  if KeyPhrase = '' then begin
    Result := Value;

  end else begin
    // Only unjumble if we recognise as a jumbled string.
    tmpStr := Copy( Value, 1, Length( JumblePrefix_v01 ) );

    // if prefix indicates was jumbled with v01 (Alg = 1)...
    if tmpStr = JumblePrefix_v01 then begin
      // extract out the actual jumbled text
      Result := Copy( Value, Length( JumblePrefix_v01 ) + 1, MAXINT );
      if Length( Result ) > 0 then begin
        tmpStr := StringOfChar( 'A', Length(Result) div 2 );
        HexTextToBinary( Result, PChar(tmpStr), Length( tmpStr ) );
        Result := '';
        jj := 1;
        for ii := 1 to Length( tmpStr ) do begin
          Result := Result + char( Ord(tmpStr[ii]) XOR Ord(KeyPhrase[jj]) );
          Inc( jj );
          if jj > Length( KeyPhrase ) then
            jj := 1;
        end;
      end;

    // If not jumbled then return given value asis
    end else begin
      Result := Value;
    end;
  end;
end;

function ConvCharCase( PrevChar, NewChar: char; ChCase: integer ): char;
begin
case ChCase of
    1{ecUpperCase}: Result := char(CharUpper(PChar(NewChar)));
    2{ecLowerCase}: Result := char(CharLower(PChar(NewChar)));
    3{ecProperCase}: begin
        if (PrevChar = #0) or
            (Pos( PrevChar, ' -,.;/()!@#$%^&*+="''') <> 0) then
            Result := char(CharUpper(PChar(NewChar)))
        else Result := NewChar;
        end;
else
    Result := NewChar;
    end;
end;

procedure IB_ReallocMem( var Ptr: pointer; OldSize, NewSize: longint );
var
  tmpMem: pointer;
  tmpLen: longint;
begin
  if OldSize = NewSize then
    Exit;
  if NewSize > 0 then
    tmpMem := AllocMem( NewSize )
  else
    tmpMem := nil;
  if OldSize > NewSize then
    tmpLen := NewSize
  else
    tmpLen := OldSize;
  if tmpLen > 0 then
    Move( Ptr^, tmpMem^, tmpLen );
  if OldSize > 0 then
    FreeMem( Ptr );
  Ptr := tmpMem;
end;

function isc_decode_TDateTime( const Src: pisc_quad ): TDateTime;
begin
  Result := Src^.isc_quad_high - 15018;
  try
    Result := Result + EncodeTime((Src^.isc_quad_low div (36000000)),
                                  (Src^.isc_quad_low div (  600000)) mod 60,
                                  (Src^.isc_quad_low div (   10000)) mod 60,
                                  (Src^.isc_quad_low mod (   10000)) div 10 );
  except
    Result := Result + 0;
  end;
end;

procedure isc_encode_TDateTime( const Src: TDateTime; const Dst: pisc_quad );
var
  Hour, Min, Sec, MSec: word;
begin
  DecodeTime( Src, Hour, Min, Sec, MSec );
  with Dst^ do begin
    isc_quad_high := Trunc( Src ) + 15018;
    isc_quad_low  := Hour * 10000 * 60 * 60 +
                     Min  * 10000 * 60      +
                     Sec  * 10000           +
                     MSec *    10;
  end;
end;

function isc_quad_equal( const Q1, Q2: isc_quad ): boolean;
begin
  Result := ( Q1.isc_quad_high = Q2.isc_quad_high ) and
            ( Q1.isc_quad_low  = Q2.isc_quad_low  );
end;

function isc_quad_is_zero( const Q1: isc_quad ): boolean;
begin
  Result := ( Q1.isc_quad_high = 0 ) and
            ( Q1.isc_quad_low  = 0 );
end;

function isc_quad_string( const AQuad: isc_quad ): string;
begin
  Result := '( ' + IntToStr( AQuad.isc_quad_high ) + ', ' +
                   IntToStr( AQuad.isc_quad_low ) + ' )';
end;

function ScaleExtended( const AVal: extended; AScale: smallint ): extended;
var
  i: smallint;
  AFactor: extended;
begin
  // Do not apply rounding - used for reading data as stored in database.
  Result := AVal;
  if (AScale <> 0) and (Result <> 0) then
  begin
    AFactor := 1;
    for i := 1 to abs(AScale) do
      AFactor := AFactor * 10;
    if AScale > 0 then // increasing scale
      Result := AVal * AFactor
    else // decreasing scale
      Result := AVal / AFactor;
  end;
end;

function IntegerToCurrency( const AVal: integer; AScale: smallint ): currency;
var
  i: smallint;
  AFactor: currency;
begin
  // Do not apply rounding - used for reading data as stored in database.
  // There is some hazard with the following code, because it does the
  // multiply/divide using currency values - and AFAICT these result in the
  // use of the extended data type internally.  The best way to do this would
  // have been to use the Int64ToCurrency function (see notes below), but that
  // would mean dropping support for BCB3.  Given the relative significance
  // of integer vs currency I am not expecting this code to give problems, but
  // it will need to be tested.
  Result := AVal;
  if (AScale <> 0) and (Result <> 0) then
  begin
    AFactor := 1;
    for i := 1 to abs(AScale) do
      AFactor := AFactor * 10;
    if AScale > 0 then // scale result up to meet integer scale
      Result := Result * AFactor
    else // scale result down to meet integer scale
      Result := Result / AFactor;
  end;
end;

function Int64ToCurrency( AVal: ISC_INT64; AScale: smallint ): currency;
var
  i: smallint;
  AFactor: ISC_INT64;
begin
  // Do not apply rounding - used for reading data as stored in database.
  // Originally I was starting by casting AVal to Result and then scaling
  // the currency Result variable.  This resulted in rounding problems.  It
  // seems that some Delphi maths functions involving currency use extended
  // for interim values with subsequent problems at the limits of the range.
  // So now I manipulate the int64 value first, and then assign the final
  // value directly to Result.  This direct cast produces an implicit scale
  // of 4 (the fixed integer scale of the currency data type), and so the
  // actual scaling value must be adjusted as follows.  This adjustment
  // avoids overflowing the currency value when scaling adjustment will make
  // the integer value fit.  There is still a limit (14 integer digits), but
  // this should ensure we accept all possible values within the limit.
  AScale := AScale + 4;
  if (AScale <> 0) and (AVal <> 0) then
  begin
    AFactor := 1;
    for i := 1 to abs(AScale) do
      AFactor := AFactor * 10;
    if AScale > 0 then // increasing scale
    begin
{$IFDEF IBO_VCL40_OR_GREATER}
      if (AVal > (High(ISC_INT64) div AFactor)) or
         (AVal < (Low (ISC_INT64) div AFactor)) then
        raise Exception.Create( E_Int64Overflow );
{$ENDIF}
      AVal := AVal * AFactor;
    end
    else // decreasing scale
    begin
{$IFDEF IBO_VCL40_OR_GREATER}
      AVal := AVal div AFactor;
{$ELSE}
      AVal := AVal / AFactor;
{$ENDIF}
    end;
  end;
  Result := currency((@AVal)^);
end;

function ExtendedToInt64( AVal: extended; AScale: smallint ): ISC_INT64;
var
  i: smallint;
  AFactor: extended;
begin
  if (AScale <> 0) and (AVal <> 0) then
  begin
    AFactor := 1;
    for i := 1 to abs(AScale) do
      AFactor := AFactor * 10;
    if AScale > 0 then // increasing scale
      AVal := AVal * AFactor
    else // decreasing scale
      AVal := AVal / AFactor;
  end;
  // statistical rounding applied for consistency
  Result := Round( AVal );
end;

function ExtendedToInteger( AVal: extended; AScale: smallint ): integer;
var
  i: smallint;
  AFactor: extended;
begin
  if (AScale <> 0) and (AVal <> 0) then
  begin
    AFactor := 1;
    for i := 1 to abs(AScale) do
      AFactor := AFactor * 10;
    if AScale > 0 then // increasing scale
      AVal := AVal * AFactor
    else // decreasing scale
      AVal := AVal / AFactor;
  end;
  if ( AVal > High(integer) ) or ( AVal < Low(integer) ) then
    raise Exception.Create( E_IntegerOverflow );
  // statistical rounding applied for consistency
  Result := Round( AVal );
end;

function ExtendedToSmallint( AVal: extended; AScale: smallint ): smallint;
var
  i: smallint;
  AFactor: extended;
begin
  if (AScale <> 0) and (AVal <> 0) then
  begin
    AFactor := 1;
    for i := 1 to abs(AScale) do
      AFactor := AFactor * 10;
    if AScale > 0 then // increasing scale
      AVal := AVal * AFactor
    else // decreasing scale
      AVal := AVal / AFactor;
  end;
  if (AVal > High(Smallint)) or (AVal < Low(Smallint)) then
    raise Exception.Create( E_SmallintOverflow );
  // statistical rounding applied for consistency
  Result := Round( AVal );
end;

function CurrencyToInteger( AVal: currency; AScale: smallint ): integer;
var
  i: smallint;
  AFactor: currency;
begin
  // See notes for IntegerToCurrency about accuracy of currency manipulations
  if (AScale <> 0) and (AVal <> 0) then
  begin
    AFactor := 1;
    for i := 1 to abs(AScale) do
      AFactor := AFactor * 10;
    if AScale > 0 then // increasing scale
      AVal := AVal * AFactor
    else // decreasing scale
      AVal := AVal / AFactor;
  end;
  if (AVal > High(integer)) or (AVal < Low(integer)) then
    raise Exception.Create( E_IntegerOverflow );
  // This is not ideal, since it converts to extended and then back
  // to integer - with theoretical difficulties.  However given the resolution
  // of extended versus integer this should not cause a problem.
  // statistical rounding applied for consistency
  Result := Round( AVal );
end;

function CurrencyToSmallint( AVal: currency; AScale: smallint ): smallint;
var
  i: smallint;
  AFactor: extended;
begin
  // See notes for IntegerToCurrency about accuracy of currency manipulations
  if (AScale <> 0) and (AVal <> 0) then
  begin
    AFactor := 1;
    for i := 1 to abs(AScale) do
      AFactor := AFactor * 10;
    if AScale > 0 then // increasing scale
      AVal := AVal * AFactor
    else // decreasing scale
      AVal := AVal / AFactor;
  end;
  if (AVal > High(Smallint)) or (AVal < Low(Smallint)) then
    raise Exception.Create( E_SmallintOverflow );
  // This is not ideal, since it converts to extended and then back
  // to integer - with theoretical difficulties.  However given the resolution
  // of extended versus smallint this should not cause a problem.
  // statistical rounding applied for consistency
  Result := Round( AVal );
end;

function CurrencyToInt64( AVal: currency; AScale: smallint ): ISC_INT64;
var
  i: smallint;
  AFactor: ISC_INT64;
{$IFDEF IBO_VCL40_OR_GREATER}
  tmpMod,
  tmpHalf: ISC_INT64;
{$ENDIF}
begin
  // See notes for Int64ToCurrency for explanation of this code.
  Result := ISC_INT64((@AVal)^);
  AScale := AScale - 4;
  if (AScale <> 0) and (Result <> 0) then
  begin
    AFactor := 1;
    for i := 1 to abs(AScale) do
      AFactor := AFactor * 10;
    if AScale > 0 then // increasing scale
    begin
{$IFDEF IBO_VCL40_OR_GREATER}
      if (Result > (High(ISC_INT64) div AFactor)) or
        (Result < (Low(ISC_INT64) div AFactor)) then
        raise Exception.Create( E_Int64Overflow );
{$ENDIF}
      Result := Result * AFactor;
    end
    else // decreasing scale
    begin
{$IFDEF IBO_VCL40_OR_GREATER}
      // Need to calculate the rounding adjustments required for statistical
      // rounding.  Probably should setup asm stuff for this but lets see how
      // we go without for the moment.
      tmpMod := Result mod AFactor;
      tmpHalf := (AFactor div 2);
      Result := Result div AFactor;
      // more than half remainder goes up (down if negative)
      // exactly half remainder goes up (down if negative) only when
      // the result is odd (even results dont need adjustment)
      if (abs(tmpMod) > tmpHalf) or
        ((abs(tmpMod) = tmpHalf) and ((Result mod 2) = 1)) then
      begin
        if Result < 0 then
          Dec(Result,1)
        else
          Inc(Result,1);
      end;
{$ELSE}
      // Sorry Delphi3 people but I will not write
      // rounding for a system that I cannot check.
      Result := Result / AFactor;
{$ENDIF}
    end;
  end;
end;

{$IFDEF IBO_VCL40_OR_GREATER}
function StrToInt64Scaled( const AValue: string; AScale: integer ): int64;
var
  tmpVal: string;
  tmpLen,
  tmpPos,
  x: integer;
begin
  tmpVal := Trim( AValue );
  tmpPos := Pos( '-', tmpVal );
  if not ( tmpPos in [ 0..1 ]) then
    raise Exception.Create( 'Invalid numeric format: ' + tmpVal );
  tmpLen := Length( tmpVal );
  tmpPos := Pos( DecimalSeparator, tmpVal );
  if tmpPos = 0 then
  begin
    tmpPos := tmpLen + 1;
    tmpLen := tmpPos;
  end
  else
    System.Delete( tmpVal, tmpPos, 1 );
  Result := StrToInt64( tmpVal );
  tmpLen := tmpLen - tmpPos - AScale;
  if tmpLen > 0 then
  begin
    tmpPos := 10;
    for x := 1 to tmpLen - 1 do
      tmpPos := tmpPos * 10;
    Result := Result div tmpPos;
  end
  else
  if tmpLen < 0 then
  begin
    tmpPos := 10;
    for x := -1 downto tmpLen + 1 do
      tmpPos := tmpPos * 10;
    Result := Result * tmpPos;
  end;
end;

function Int64ScaledToStr( const AValue: int64; AScale: integer ): string;
var
  IsNeg: boolean;
  CurLen: integer;
  tmpZ: string;
begin
  Result := IntToStr( AValue );
  if AScale > 0 then
  begin
    IsNeg := Result[1] = '-';
    if IsNeg then
      System.Delete( Result, 1, 1 );
    CurLen := Length( Result );
    if CurLen <= AScale then
    begin
      SetLength( tmpZ, AScale - CurLen + 1 );
      FillChar( tmpZ[1], AScale - CurLen + 1, '0' );
      Result := tmpZ + Result;
    end;
    System.Insert( DecimalSeparator, Result, Length( Result ) - AScale + 1 );
    if IsNeg then
      System.Insert( '-', Result, 1 );
  end;
end;        
{$ENDIF}

end.
