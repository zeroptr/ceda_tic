unit WideStrings;
{
   © Digital Publishing, 1998,99
   Authors: Arne Schäpers (as), Freddy Ertl (fe), Mike Lischke (ml)
}

{$INCLUDE IB_Directives.inc}

interface

uses
  Windows, Classes, Language;

const
  WideNull       = WideChar(#0);
  WideCR         = WideChar(#13);
  WideLF         = WideChar(#10);
  WideSpace      = WideChar(#32);
  LineBreak      = WideChar($2028);
  ParagraphBreak = WideChar($2029);

  BOM_LSB_FIRST = WideChar($FEFF);
  BOM_MSB_FIRST = WideChar($FFFE);

type
  TUnicodeType = (utUnclear, utANSI, utUniCode, utUnicodeReversed);

type
   TWideStrings = class(TPersistent)
   private
     FUpdateCount: Integer;
     FLanguage: TLanguage;

     function GetCommaText: WideString;
     function GetName(Index: Integer): WideString;
     function GetValue(const Name: WideString): WideString;
     procedure ReadData(Reader: TReader);
     procedure SetCommaText(const Value: WideString);
     procedure SetValue(const Name, Value: WideString);
     procedure WriteData(Writer: TWriter);
   protected
     procedure DefineProperties(Filer: TFiler); override;
     procedure Error(const Msg: String; Data: Integer);
     function Get(Index: Integer): WideString; virtual; abstract;
     function GetCapacity: Integer; virtual;
     function GetCount: Integer; virtual; abstract;
     function GetObject(Index: Integer): TObject; virtual;
     function GetTextStr: WideString; virtual;
     procedure Put(Index: Integer; const S: WideString); virtual;
     procedure PutObject(Index: Integer; AObject: TObject); virtual;
     procedure SetCapacity(NewCapacity: Integer); virtual;
     procedure SetTextStr(const Value: WideString); virtual;
     procedure SetUpdateState(Updating: Boolean); virtual;
     procedure SetLanguage(Value: TLanguage); virtual;
     function GetLanguage: TLanguage; virtual;
   public
     constructor Create;

     function Add(const S: WideString): Integer; virtual;
     function AddObject(const S: WideString; AObject: TObject): Integer; virtual;
     procedure Append(const S: WideString);
     procedure AddStrings(Strings: TWideStrings); virtual;
     procedure Assign(Source: TPersistent); override;
     procedure BeginUpdate;
     procedure Clear; virtual; abstract;
     procedure Delete(Index: Integer); virtual; abstract;
     procedure EndUpdate;
     function Equals(Strings: TWideStrings): Boolean;
     procedure Exchange(Index1, Index2: Integer); virtual;
     function GetText: PWideChar; virtual;
     function IndexOf(const S: WideString): Integer; virtual;
     function IndexOfName(const Name: WideString): Integer;
     function IndexOfObject(AObject: TObject): Integer;
     procedure Insert(Index: Integer; const S: WideString); virtual; abstract;
     procedure InsertObject(Index: Integer; const S: WideString; AObject: TObject);
     procedure LoadFromFile(const FileName: String); virtual;
     procedure LoadFromStream(Stream: TStream); virtual;
     procedure Move(CurIndex, NewIndex: Integer); virtual;
     procedure SaveToFile(const FileName: String); virtual;
     procedure SaveToStream(Stream: TStream); virtual;
     procedure SetText(Text: PWideChar); virtual;

     property Capacity: Integer read GetCapacity write SetCapacity;
     property CommaText: WideString read GetCommaText write SetCommaText;
     property Count: Integer read GetCount;
     property Names[Index: Integer]: WideString read GetName;
     property Objects[Index: Integer]: TObject read GetObject write PutObject;
     property Values[const Name: WideString]: WideString read GetValue write SetValue;
     property Strings[Index: Integer]: WideString read Get write Put; default;
     property Text: WideString read GetTextStr write SetTextStr;
     property Language: TLanguage read GetLanguage write SetLanguage;
   end;

   PWideStringItem = ^TWideStringItem;
   TWideStringItem = record
     FString: WideString;
     FObject: TObject;
   end;

   PWideStringItemList = ^TWideStringItemList;
   TWideStringItemList = array[0..MaxListSize] of TWideStringItem;

   TWideStringList = class(TWideStrings)
   private
     FList: PWideStringItemList;
     FCount: Integer;
     FCapacity: Integer;
     FSorted: Boolean;
     FDuplicates: TDuplicates;
     FOnChange: TNotifyEvent;
     FOnChanging: TNotifyEvent;
     procedure ExchangeItems(Index1, Index2: Integer);
     procedure Grow;
     procedure QuickSort(L, R: Integer);
     procedure InsertItem(Index: Integer; const S: WideString);
     procedure SetSorted(Value: Boolean);
   protected
     procedure Changed; virtual;
     procedure Changing; virtual;
     function Get(Index: Integer): WideString; override;
     function GetCapacity: Integer; override;
     function GetCount: Integer; override;
     function GetObject(Index: Integer): TObject; override;
     procedure Put(Index: Integer; const S: WideString); override;
     procedure PutObject(Index: Integer; AObject: TObject); override;
     procedure SetCapacity(NewCapacity: Integer); override;
     procedure SetUpdateState(Updating: Boolean); override;
     procedure SetLanguage(Value: TLanguage); override;
   public
     destructor Destroy; override;
     function Add(const S: WideString): Integer; override;
     procedure Clear; override;
     procedure Delete(Index: Integer); override;
     procedure Exchange(Index1, Index2: Integer); override;
     function Find(const S: WideString; var Index: Integer): Boolean; virtual;
     function IndexOf(const S: WideString): Integer; override;
     procedure Insert(Index: Integer; const S: WideString); override;
     procedure Sort; virtual;
     property Duplicates: TDuplicates read FDuplicates write FDuplicates;
     property Sorted: Boolean read FSorted write SetSorted;
     property OnChange: TNotifyEvent read FOnChange write FOnChange;
     property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
   end;

function StrLenW(Str: PWideChar): Cardinal; assembler;
function StrEndW(Str: PWideChar): PWideChar; assembler;
function StrMoveW(Dest, Source: PWideChar; Count: Cardinal): PWideChar; assembler;
function StrCopyW(Dest, Source: PWideChar): PWideChar; assembler;
function StrECopyW(Dest, Source: PWideChar): PWideChar; assembler;
function StrLCopyW(Dest, Source: PWideChar; MaxLen: Cardinal): PWideChar; assembler;
function StrPCopyW(Dest: PWideChar; const Source: String): PWideChar;
function StrPLCopyW(Dest: PWideChar; const Source: String; MaxLen: Cardinal): PWideChar; assembler;
function StrCatW(Dest, Source: PWideChar): PWideChar;
function StrLCatW(Dest, Source: PWideChar; MaxLen: Cardinal): PWideChar; assembler;
function StrCompW(Str1, Str2: PWideChar): Integer; assembler;
function StrICompW(Str1, Str2: PWideChar): Integer; assembler;
function StrLCompW(Str1, Str2: PWideChar; MaxLen: Cardinal): Integer; assembler;
function StrLICompW(Str1, Str2: PWideChar; MaxLen: Cardinal): Integer; assembler;
function StrScanW(Str: PWideChar; Chr: WideChar): PWideChar; assembler;
function StrRScanW(Str: PWideChar; Chr: WideChar): PWideChar; assembler;
function StrPosW(Str, SubStr: PWideChar): PWideChar; assembler;
function StrPosW2(Str, SubStr: PWideChar; var HyphenCount: Integer): PWideChar; assembler;
function StrUpperW(Str: PWideChar): PWideChar; assembler;
function StrLowerW(Str: PWideChar): PWideChar; assembler;
function StrAllocW(Size: Cardinal): PWideChar;
function StrBufSizeW(Str: PWideChar): Cardinal;
function StrNewW(Str: PWideChar): PWideChar;
procedure StrDisposeW(Str: PWideChar);
procedure StrSwapByteOrder(Str: PWideChar); assembler;

function AdjustLineBreaksW(const S: WideString): WideString;
function UnicodeType(P: Pointer; Size: Integer): TUnicodeType;
function WideQuotedStr(const S: WideString; Quote: WideChar): WideString;
function WideExtractQuotedStr(var Src: PWideChar; Quote: WideChar): WideString;


implementation

uses
  Consts, DPMisc, SysUtils;

type
  TCompareFunc = function (W1, W2: WideString; Locale: LCID): Integer;

var
  WideCompareText: TCompareFunc;

function StrLenW(Str: PWideChar): Cardinal; assembler;
asm
         MOV     EDX,EDI
         MOV     EDI,EAX
         MOV     ECX,0FFFFFFFFH
         XOR     AX,AX
         REPNE   SCASW
         MOV     EAX,0FFFFFFFEH
         SUB     EAX,ECX
         MOV     EDI,EDX
end;


function StrEndW(Str: PWideChar): PWideChar; assembler;
asm
         MOV     EDX,EDI
         MOV     EDI,EAX
         MOV     ECX,0FFFFFFFFH
         XOR     AX,AX
         REPNE   SCASW
         LEA     EAX,[EDI-2]
         MOV     EDI,EDX
end;

function StrMoveW(Dest, Source: PWideChar; Count: Cardinal): PWideChar; assembler;
asm
         PUSH    ESI
         PUSH    EDI
         MOV     ESI,EDX
         MOV     EDI,EAX
         MOV     EDX,ECX
         CMP     EDI,ESI
         JG      @@1
         JE      @@2
         SHR     ECX,1
         REP     MOVSD
         MOV     ECX,EDX
         AND     ECX,1
         REP     MOVSW
         JMP     @@2

@@1:     LEA     ESI,[ESI+2*ECX-2]
         LEA     EDI,[EDI+2*ECX-2]
         STD
         AND     ECX,1
         REP     MOVSW
         SUB     EDI,2
         SUB     ESI,2
         MOV     ECX,EDX
         SHR     ECX,1
         REP     MOVSD
         CLD
@@2:     POP     EDI
         POP     ESI
end;

function StrCopyW(Dest, Source: PWideChar): PWideChar; assembler;
asm
         PUSH    EDI
         PUSH    ESI
         MOV     ESI,EAX
         MOV     EDI,EDX
         MOV     ECX,0FFFFFFFFH
         XOR     AX,AX
         REPNE   SCASW
         NOT     ECX
         MOV     EDI,ESI
         MOV     ESI,EDX
         MOV     EDX,ECX
         MOV     EAX,EDI
         SHR     ECX,1
         REP     MOVSD
         MOV     ECX,EDX
         AND     ECX,1
         REP     MOVSW
         POP     ESI
         POP     EDI
end;

function StrECopyW(Dest, Source: PWideChar): PWideChar; assembler;
asm
         PUSH    EDI
         PUSH    ESI
         MOV     ESI,EAX
         MOV     EDI,EDX
         MOV     ECX,0FFFFFFFFH
         XOR     AX,AX
         REPNE   SCASW
         NOT     ECX
         MOV     EDI,ESI
         MOV     ESI,EDX
         MOV     EDX,ECX
         SHR     ECX,1
         REP     MOVSD
         MOV     ECX,EDX
         AND     ECX,1
         REP     MOVSW
         LEA     EAX,[EDI-2]
         POP     ESI
         POP     EDI
end;

function StrLCopyW(Dest, Source: PWideChar; MaxLen: Cardinal): PWideChar; assembler;
asm
         PUSH    EDI
         PUSH    ESI
         PUSH    EBX
         MOV     ESI,EAX
         MOV     EDI,EDX
         MOV     EBX,ECX
         XOR     AX,AX
         TEST    ECX,ECX
         JZ      @@1
         REPNE   SCASW
         JNE     @@1
         INC     ECX
@@1:     SUB     EBX,ECX
         MOV     EDI,ESI
         MOV     ESI,EDX
         MOV     EDX,EDI
         MOV     ECX,EBX
         SHR     ECX,1
         REP     MOVSD
         MOV     ECX,EBX
         AND     ECX,1
         REP     MOVSW
         STOSW
         MOV     EAX,EDX
         POP     EBX
         POP     ESI
         POP     EDI
end;

function StrPCopyW(Dest: PWideChar; const Source: String): PWideChar;
begin
  Result:=StrPLCopyW(Dest,Source,Length(Source));
  Result[Length(Source)]:=WideNull;
end;

function StrPLCopyW(Dest: PWideChar; const Source: String; MaxLen: Cardinal): PWideChar; assembler;
asm
       PUSH    EDI
       PUSH    ESI
       MOV     EDI,EAX
       MOV     ESI,EDX
       MOV     EDX,EAX
       XOR     AX,AX
@@1:   LODSB
       STOSW
       LOOP    @@1
       MOV     EAX,EDX
       POP     ESI
       POP     EDI
end;

function StrCatW(Dest, Source: PWideChar): PWideChar;
begin
  StrCopyW(StrEndW(Dest),Source);
  Result:=Dest;
end;

function StrLCatW(Dest, Source: PWideChar; MaxLen: Cardinal): PWideChar; assembler;
asm
         PUSH    EDI
         PUSH    ESI
         PUSH    EBX
         MOV     EDI,Dest
         MOV     ESI,Source
         MOV     EBX,MaxLen
         SHL     EBX,1
         CALL    StrEndW
         MOV     ECX,EDI
         ADD     ECX,EBX
         SUB     ECX,EAX
         JBE     @@1
         MOV     EDX,ESI
         SHR     ECX,1
         CALL    StrLCopyW
@@1:     MOV     EAX,EDI
         POP     EBX
         POP     ESI
         POP     EDI
end;

function StrCompW(Str1, Str2: PWideChar): Integer; assembler;
asm
         PUSH    EDI
         PUSH    ESI
         MOV     EDI,EDX
         MOV     ESI,EAX
         MOV     ECX,0FFFFFFFFH
         XOR     EAX,EAX
         REPNE   SCASW
         NOT     ECX
         MOV     EDI,EDX
         XOR     EDX,EDX
         REPE    CMPSW
         MOV     AX,[ESI-2]
         MOV     DX,[EDI-2]
         SUB     EAX,EDX
         POP     ESI
         POP     EDI
end;

function StrICompW(Str1, Str2: PWideChar): Integer; assembler;
asm
         PUSH    EDI
         PUSH    ESI
         MOV     EDI,EDX
         MOV     ESI,EAX
         MOV     ECX,0FFFFFFFFH
         XOR     EAX,EAX
         REPNE   SCASW
         NOT     ECX
         MOV     EDI,EDX
         XOR     EDX,EDX
@@1:     REPE    CMPSW
         JE      @@4
         MOV     AX,[ESI-2]
         CMP     AX,'a'
         JB      @@2
         CMP     AX,'z'
         JA      @@2
         SUB     AL,20H
@@2:     MOV     DX,[EDI-2]
         CMP     DX,'a'
         JB      @@3
         CMP     DX,'z'
         JA      @@3
         SUB     DX,20H
@@3:     SUB     EAX,EDX
         JE      @@1
@@4:     POP     ESI
         POP     EDI
end;

function StrLCompW(Str1, Str2: PWideChar; MaxLen: Cardinal): Integer; assembler;
asm
         PUSH    EDI
         PUSH    ESI
         PUSH    EBX
         MOV     EDI,EDX
         MOV     ESI,EAX
         MOV     EBX,ECX

         XOR     EAX,EAX
         OR      ECX,ECX
         JE      @@1
         REPNE   SCASW
         SUB     EBX,ECX
         MOV     ECX,EBX
         MOV     EDI,EDX
         XOR     EDX,EDX
         REPE    CMPSW
         MOV     AX,[ESI-2]
         MOV     DX,[EDI-2]
         SUB     EAX,EDX
@@1:     POP     EBX
         POP     ESI
         POP     EDI
end;

function StrLICompW(Str1, Str2: PWideChar; MaxLen: Cardinal): Integer; assembler;
asm
         PUSH    EDI
         PUSH    ESI
         PUSH    EBX
         MOV     EDI,EDX
         MOV     ESI,EAX
         MOV     EBX,ECX
         XOR     EAX,EAX
         OR      ECX,ECX
         JE      @@4
         REPNE   SCASW
         SUB     EBX,ECX
         MOV     ECX,EBX
         MOV     EDI,EDX
         XOR     EDX,EDX
@@1:     REPE    CMPSW
         JE      @@4
         MOV     AX,[ESI-2]
         CMP     AX,'a'
         JB      @@2
         CMP     AX,'z'
         JA      @@2
         SUB     AX,20H
@@2:     MOV     DX,[EDI-2]
         CMP     DX,'a'
         JB      @@3
         CMP     DX,'z'
         JA      @@3
         SUB     DX,20H
@@3:     SUB     EAX,EDX
         JE      @@1
@@4:     POP     EBX
         POP     ESI
         POP     EDI
end;

function StrScanW(Str: PWideChar; Chr: WideChar): PWideChar; assembler;
asm
         PUSH    EDI
         PUSH    EAX
         MOV     EDI,Str
         MOV     ECX,0FFFFFFFFH
         XOR     AX,AX
         REPNE   SCASW
         NOT     ECX
         POP     EDI
         MOV     AX,Chr
         REPNE   SCASW
         MOV     EAX,0
         JNE     @@1
         MOV     EAX,EDI
         SUB     EAX,2
@@1:     POP     EDI
end;

function StrRScanW(Str: PWideChar; Chr: WideChar): PWideChar; assembler;
asm
         PUSH    EDI
         MOV     EDI,Str
         MOV     ECX,0FFFFFFFFH
         XOR     AX,AX
         REPNE   SCASW
         NOT     ECX
         STD
         SUB     EDI,2
         MOV     AX,Chr
         REPNE   SCASW
         MOV     EAX,0
         JNE     @@1
         MOV     EAX,EDI
         ADD     EAX,2
@@1:     CLD
         POP     EDI
end;

function StrPosW(Str, SubStr: PWideChar): PWideChar; assembler;
asm
         PUSH    EDI
         PUSH    ESI
         PUSH    EBX
         OR      EAX,EAX
         JZ      @@2
         OR      EDX,EDX
         JZ      @@2
         MOV     EBX,EAX
         MOV     EDI,EDX
         XOR     AX,AX
         MOV     ECX,0FFFFFFFFH
         REPNE   SCASW
         NOT     ECX
         DEC     ECX
         JZ      @@2
         MOV     ESI,ECX
         MOV     EDI,EBX
         MOV     ECX,0FFFFFFFFH
         REPNE   SCASW
         NOT     ECX
         SUB     ECX,ESI
         JBE     @@2
         MOV     EDI,EBX
         LEA     EBX,[ESI-1]
@@1:     MOV     ESI,EDX
         LODSW
         REPNE   SCASW
         JNE     @@2
         MOV     EAX,ECX
         PUSH    EDI
         MOV     ECX,EBX
         REPE    CMPSW
         POP     EDI
         MOV     ECX,EAX
         JNE     @@1
         LEA     EAX,[EDI-2]
         JMP     @@3
         
@@2:     XOR     EAX,EAX
@@3:     POP     EBX
         POP     ESI
         POP     EDI
end;

function StrPosW2(Str, SubStr: PWideChar; var HyphenCount: Integer): PWideChar; assembler;
var
  PHC: ^Integer;
asm
         PUSH    EDI
         PUSH    ESI
         PUSH    EBX
         OR      EAX,EAX
         JZ      @@2
         OR      EDX,EDX
         JZ      @@2
         MOV     PHC,ECX
         MOV     EBX,EAX
         MOV     EDI,EDX
         XOR     AX,AX
         MOV     ECX,0FFFFFFFFH
         REPNE   SCASW
         NOT     ECX
         DEC     ECX
         JZ      @@2
         MOV     ESI,ECX
         MOV     EDI,EBX
         MOV     ECX,0FFFFFFFFH
         REPNE   SCASW
         NOT     ECX
         SUB     ECX,ESI
         JBE     @@2
         MOV     EDI,EBX
         LEA     EBX,[ESI-1]

@@1:
         PUSH    EDI
         MOV     EDI,[PHC]
         MOV     DWORD PTR [EDI],0
         POP     EDI

         MOV     ESI,EDX
         LODSW
         REPNE   SCASW
         JNE     @@2
         MOV     EAX,ECX
         PUSH    EDI
         MOV     ECX,EBX

@@6:     CMPSW
         JE      @@8
         PUSH    AX
         MOV     AX,$00AC
         CMP     AX,[EDI-2]
         POP     AX
         JNE     @@7
         DEC     ESI
         DEC     ESI

         PUSH    EDI
         MOV     EDI,[PHC]
         INC     DWORD PTR [EDI]
         POP     EDI
         JMP     @@6

@@8:     LOOP    @@6
@@7:     POP     EDI
         MOV     ECX,EAX
         JNE     @@1

         LEA     EAX,[EDI-2]
         JMP     @@3

@@2:     XOR     EAX,EAX
@@3:     POP     EBX
         POP     ESI
         POP     EDI
end;


function StrUpperW(Str: PWideChar): PWideChar; assembler;
asm
         PUSH    ESI
         MOV     ESI,Str
         MOV     EDX,Str
@@1:     LODSW
         OR      AX,AX
         JE      @@2
         CMP     AX,'a'
         JB      @@1
         CMP     AX,'z'
         JA      @@1
         SUB     AX,20H
         MOV     [ESI-2],AX
         JMP     @@1

@@2:     XCHG    EAX,EDX
         POP     ESI
end;

function StrLowerW(Str: PWideChar): PWideChar; assembler;
asm
         PUSH    ESI
         MOV     ESI,Str
         MOV     EDX,Str
@@1:     LODSW
         OR      AX,AX
         JE      @@2
         CMP     AX,'A'
         JB      @@1
         CMP     AX,'Z'
         JA      @@1
         ADD     AX,20H
         MOV     [ESI-2],AX
         JMP     @@1
         
@@2:     XCHG    EAX,EDX
         POP     ESI
end;

function StrAllocW(Size: Cardinal): PWideChar;
begin
  Size:=SizeOf(WideChar)*Size+SizeOf(Cardinal);
  GetMem(Result,Size);
  FillCHar(Result^,Size,0);
  Cardinal(Pointer(Result)^) := Size;
  Inc(Result,SizeOf(Cardinal) div SizeOf(WideChar));
end;

function StrBufSizeW(Str: PWideChar): Cardinal;
begin
  Dec(Str,SizeOf(Cardinal) div SizeOf(WideChar));
  Result:=(Cardinal(Pointer(Str)^)-SizeOf(Cardinal)) div 2;
end;

function StrNewW(Str: PWideChar): PWideChar;
var Size: Cardinal;
begin
  if Str = nil then Result := nil
               else
  begin
    Size:=StrLenW(Str)+1;
    Result:=StrMoveW(StrAllocW(Size),Str,Size);
  end;
end;

procedure StrDisposeW(Str: PWideChar);
begin
  if Str <> nil then
  begin
    Dec(Str,SizeOf(Cardinal) div SizeOf(WideChar));
    FreeMem(Str,Cardinal(Pointer(Str)^));
  end;
end;

procedure StrSwapByteOrder(Str: PWideChar); assembler;
asm
         PUSH    ESI
         PUSH    EDI
         MOV     EDI,EAX
         MOV     ESI,EAX
         MOV     ECX,0FFFFFFFFH
         XOR     AX,AX
         REPNE   SCASW
         OR      ECX,ECX
         JZ      @@2
         NOT     ECX
         MOV     EDI,ESI
@@1:     LODSW
         XCHG    AL,AH
         STOSW
         LOOP    @@1
@@2:     POP     EDI
         POP     ESI
end;

function AdjustLineBreaksW(const S: WideString): WideString;
var Source,
    SourceEnd,
    Dest       : PWideChar;
    Extra      : Integer;
begin
  Source:=Pointer(S);
  SourceEnd:=Source+Length(S);
  Extra:=0;
  while Source < SourceEnd do
  begin
    case Source^ of
      WideLF : Inc(Extra);
      WideCR : if Source[1] = WideLF then Inc(Source)
                                     else Inc(Extra);
    end;
    Inc(Source);
  end;

  Source:=Pointer(S);
  SetString(Result,nil,SourceEnd-Source+Extra);
  Dest:=Pointer(Result);
  while Source < SourceEnd do
    case Source^ of
      WideLF : begin
                 Dest^:=LineBreak;
                 Inc(Dest);
                 Inc(Source);
               end;
      WideCR : begin
                 Dest^:=LineBreak;
                 Inc(Dest);
                 Inc(Source);
                 if Source^ = WideLF then Inc(Source);
               end;
    else
      Dest^:=Source^;
      Inc(Dest);
      Inc(Source);
    end;
end;

function UnicodeType(P: Pointer; Size: Integer): TUnicodeType;
var S       : PWideChar;
    I       : Integer;
    LowRes,
    HighRes : Word;
    Char    : record
                case Boolean of
                  True  : (Char: WideChar);
                  False : (LSB, MSB: Byte);
              end;

begin
  Result:=utUnclear;

  if (Size < 3) or (P = nil) then Exit;

  if Odd(Size) then
  begin
    Result:=utANSI;
    Exit;
  end;
  S:=P;
  if S^ = BOM_LSB_FIRST then Result:=utUnicode
                        else
    if S^ = BOM_MSB_FIRST then Result:=utUnicodeReversed;
  LowRes:=0;
  HighRes:=0;
  for I:=0 to 49 do
  begin
    if 2*I > Size then Break;
    Char.Char:=S[I];
    if Char.LSB = 0 then Inc(LowRes);
    if Char.MSB = 0 then Inc(HighRes);
  end;
  if (Abs(LowRes-HighRes) > 5) and (Result = utANSI) then Result:=utUnicode;
end;


function WideQuotedStr(const S: WideString; Quote: WideChar): WideString;
var P, Src,
    Dest     : PWideChar;
    AddCount : Integer;

begin
  AddCount:=0;
  P:=StrScanW(PWideChar(S),Quote);
  while assigned(P) do
  begin
    Inc(P);
    Inc(AddCount);
    P:=StrScanW(P,Quote);
  end;

  if AddCount = 0 then
  begin
    Result:=Quote+S+Quote
  end
  else
  begin
    SetLength(Result,Length(S)+AddCount+2);
    Dest:=PWideChar(Result);
    Dest^:=Quote;
    Inc(Dest);
    Src:=PWideChar(S);
    P:=StrScanW(Src,Quote);
    repeat
      Inc(P);
      Move(Src^,Dest^,P-Src);
      Inc(Dest,P-Src);
      Dest^:=Quote;
      Inc(Dest);
      Src:=P;
      P:=StrScanW(Src,Quote);
    until P = nil;
    P:=StrEndW(Src);
    Move(Src^,Dest^,P-Src);
    Inc(Dest,P-Src);
    Dest^:=Quote;
  end;  
end;

function WideExtractQuotedStr(var Src: PWideChar; Quote: WideChar): WideString;
var P, Dest: PWideChar;
    DropCount: Integer;
begin
  Result:='';
  if (Src = nil) or (Src^ <> Quote) then Exit;

  Inc(Src);
  DropCount:=1;
  P:=Src;
  Src:=StrScanW(Src,Quote);

  while assigned(Src) do  
  begin
    Inc(Src);
    if Src^ <> Quote then Break;
    Inc(Src);
    Inc(DropCount);
    Src:=StrScanW(Src,Quote);
  end;

  if Src = nil then Src:=StrEndW(P);
  if (Src - P) <= 1 then Exit;
  
  if DropCount = 1 then SetString(Result,P,Src-P-1)
                   else
  begin
    SetLength(Result,Src-P-DropCount);
    Dest:=PWideChar(Result);
    Src:=StrScanW(P,Quote);
    while assigned(Src) do
    begin
      Inc(Src);
      if Src^ <> Quote then Break;
      Move(P^,Dest^,Src-P);
      Inc(Dest,Src-P);
      Inc(Src);
      P:=Src;
      Src:=StrScanW(Src,Quote);
    end;
    if Src = nil then Src:=StrEndW(P);
    Move(P^,Dest^,Src-P-1);
  end;
end;

function CompareTextWin95(W1, W2: WideString; Locale: LCID): Integer;
var
  S1, S2: String;
  CP: Integer;
  L1, L2: Integer;
begin
  L1:= Length(W1);
  L2:= Length(W2);
  SetLength(S1, L1);
  SetLength(S2, L2);
  CP:= CodePageFromLocale(Locale);
  WideCharToMultiByte(CP,0,PWideChar(W1),L1,PChar(S1),L1,nil,nil);
  WideCharToMultiByte(CP,0,PWideChar(W2),L2,PChar(S2),L2,nil,nil);
  Result:=CompareStringA(Locale,NORM_IGNORECASE,PChar(S1),Length(S1),PChar(S2),Length(S2))-2;
end;

function CompareTextWinNT(W1, W2: WideString; Locale: LCID): Integer;
begin
  Result:=CompareStringW(Locale,NORM_IGNORECASE,PWideChar(W1),Length(W1),PWideChar(W2),Length(W2))-2;
end;

constructor TWideStrings.Create;
begin
  inherited;
  FLanguage:= GetUserDefaultLCID;
end;


procedure TWideStrings.SetLanguage(Value: TLanguage);
begin
  FLanguage:= Value;
end;

function TWideStrings.Add(const S: WideString): Integer;
begin
  Result := GetCount;
  Insert(Result, S);
end;

function TWideStrings.AddObject(const S: WideString; AObject: TObject): Integer;
begin
  Result := Add(S);
  PutObject(Result, AObject);
end;

procedure TWideStrings.Append(const S: WideString);

begin
  Add(S);
end;

procedure TWideStrings.AddStrings(Strings: TWideStrings);
var I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Strings.Count-1 do AddObject(Strings[I],Strings.Objects[I]);
  finally
    EndUpdate;
  end;
end;

procedure TWideStrings.Assign(Source: TPersistent);
var I: Integer;
begin
  if Source is TWideStrings then
  begin
    BeginUpdate;
    try
      Clear;
      AddStrings(TWideStrings(Source));
    finally
      EndUpdate;
    end;
    Exit;
  end
  else
    if Source is TStrings then
    begin
      BeginUpdate;
      try
        Clear;
        for I := 0 to TStrings(Source).Count-1 do AddObject(TStrings(Source)[I], TStrings(Source).Objects[I]);
      finally
        EndUpdate;
      end;
    end;
  inherited Assign(Source);
end;

procedure TWideStrings.BeginUpdate;
begin
  if FUpdateCount = 0 then SetUpdateState(True);
  Inc(FUpdateCount);
end;


procedure TWideStrings.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then
    begin
      Result := True;
      if Filer.Ancestor is TWideStrings then Result := not Equals(TWideStrings(Filer.Ancestor))
    end
    else Result := Count > 0;
  end;

begin
  Filer.DefineProperty('WideStrings', ReadData, WriteData, DoWrite);
end;

procedure TWideStrings.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then SetUpdateState(False);
end;

function TWideStrings.Equals(Strings: TWideStrings): Boolean;

var
  I, Count: Integer;
begin
  Result := False;
  Count := GetCount;
  if Count <> Strings.GetCount then Exit;
  for I := 0 to Count - 1 do
    if Get(I) <> Strings.Get(I) then Exit;
  Result := True;
end;

procedure TWideStrings.Error(const Msg: String; Data: Integer);

  function ReturnAddr: Pointer;

  asm
          MOV     EAX,[EBP+4]
  end;

begin
  raise EStringListError.CreateFmt(Msg, [Data]) at ReturnAddr;
end;

procedure TWideStrings.Exchange(Index1, Index2: Integer);

var TempObject: TObject;
    TempString: WideString;

begin
  BeginUpdate;
  try
    TempString := Strings[Index1];
    TempObject := Objects[Index1];
    Strings[Index1] := Strings[Index2];
    Objects[Index1] := Objects[Index2];
    Strings[Index2] := TempString;
    Objects[Index2] := TempObject;
  finally
    EndUpdate;
  end;
end;

function TWideStrings.GetCapacity: Integer;
begin
  Result := Count;
end;

function TWideStrings.GetCommaText: WideString;
var
  S: WideString;
  P: PWideChar;
  I, Count: Integer;
begin
  Count := GetCount;
  if (Count = 1) and (Get(0) = '') then Result := '""'
                                   else
  begin
    Result := '';
    for I := 0 to Count - 1 do
    begin
      S := Get(I);
      P := PWideChar(S);
      while not (P^ in [WideNull..WideSpace,WideChar('"'),WideChar(',')]) do Inc(P);
      if (P^ <> WideNull) then S := WideQuotedStr(S, '"');
      Result := Result + S + ',';
    end;
    System.Delete(Result, Length(Result), 1);
  end;
end;

function TWideStrings.GetName(Index: Integer): WideString;
var P : Integer;
begin
  Result := Get(Index);
  P:=Pos('=',Result);
  if P > 0 then SetLength(Result, P-1)
           else SetLength(Result, 0);
end;

function TWideStrings.GetObject(Index: Integer): TObject;
begin
  Result := nil;
end;

function TWideStrings.GetText: PWideChar;
begin
  Result:=StrNewW(PWideChar(GetTextStr));
end;

function TWideStrings.GetTextStr: WideString;
var I, L,
    Size,
    Count : Integer;
    P     : PWideChar;
    S     : WideString;

begin
  Count := GetCount;
  Size := 0;
  for I := 0 to Count - 1 do Inc(Size, Length(Get(I)) + 2);
  SetString(Result, nil, Size);
  P := Pointer(Result);
  for I := 0 to Count - 1 do
  begin
    S := Get(I);
    L := Length(S);
    if L <> 0 then
    begin
      System.Move(Pointer(S)^, P^, L*2);
      Inc(P, L);
    end;
    P^ := WideCR;
    Inc(P);
    P^:=WideLF;
    Inc(P);
  end;
end;

function TWideStrings.GetValue(const Name: WideString): WideString;
var I: Integer;
begin
  I := IndexOfName(Name);
  if I >= 0 then Result := Copy(Get(I), Length(Name) + 2, MaxInt)
            else Result := '';
end;

function TWideStrings.IndexOf(const S: WideString): Integer;
begin
  for Result := 0 to GetCount - 1 do
    if WideCompareText(Get(Result), S, FLanguage) = 0 then Exit;
  Result := -1;
end;

function TWideStrings.IndexOfName(const Name: WideString): Integer;
var P : Integer;
    S : WideString;
begin
  for Result := 0 to GetCount - 1 do
  begin
    S := Get(Result);
    P := Pos('=',S);
    if (P > 0) and (WideCompareText(Copy(S,1,P-1),Name,FLanguage) = 0) then Exit;
  end;
  Result := -1;
end;

function TWideStrings.IndexOfObject(AObject: TObject): Integer;
begin
  for Result := 0 to GetCount - 1 do
    if GetObject(Result) = AObject then Exit;
  Result := -1;
end;

procedure TWideStrings.InsertObject(Index: Integer; const S: WideString; AObject: TObject);
begin
  Insert(Index, S);
  PutObject(Index, AObject);
end;

procedure TWideStrings.LoadFromFile(const FileName: String);
var Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TWideStrings.LoadFromStream(Stream: TStream);
var Size: Integer;
    S: WideString;
begin
  BeginUpdate;
  try
    Size:=Stream.Size-Stream.Position;
    SetString(S,nil,2);
    Stream.Read(PWideChar(S)^,2);
    if (S[1] = BOM_LSB_FIRST) or (S[1] = BOM_MSB_FIRST) then
    begin
      SetString(S,nil,(Size-2) div 2);
      Stream.Read(PWideChar(S)^,Size-2);
      if S[1] = BOM_MSB_FIRST then StrSwapByteOrder(PWideChar(S));
    end
    else
    begin
      Stream.Seek(-2,soFromCurrent);
      SetString(S,nil,Size div 2);
      Stream.Read(PWideChar(S)^,Size);
    end;
    SetTextStr(S);
  finally
    EndUpdate;
  end;
end;

procedure TWideStrings.Move(CurIndex, NewIndex: Integer);
var TempObject: TObject;
    TempString: WideString;
begin
  if CurIndex <> NewIndex then
  begin
    BeginUpdate;
    try
      TempString := Get(CurIndex);
      TempObject := GetObject(CurIndex);
      Delete(CurIndex);
      InsertObject(NewIndex, TempString, TempObject);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TWideStrings.Put(Index: Integer; const S: WideString);
var TempObject: TObject;
begin
  TempObject := GetObject(Index);
  Delete(Index);
  InsertObject(Index, S, TempObject);
end;

procedure TWideStrings.PutObject(Index: Integer; AObject: TObject);
begin
end;

procedure TWideStrings.ReadData(Reader: TReader);

begin
  Reader.ReadListBegin;
  BeginUpdate;
  try
    Clear;
    while not Reader.EndOfList do
      Add(Reader.ReadWideString);
  finally
    EndUpdate;
  end;
  Reader.ReadListEnd;
end;

procedure TWideStrings.SaveToFile(const FileName: String);
var Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TWideStrings.SaveToStream(Stream: TStream);
var S: WideString;
begin
  S:=BOM_LSB_FIRST;
  Stream.WriteBuffer(PWideChar(S)^,2);
  S := GetTextStr;
  Stream.WriteBuffer(PWideChar(S)^,Length(S)*2);
end;

procedure TWideStrings.SetCapacity(NewCapacity: Integer);
begin
end;

procedure TWideStrings.SetCommaText(const Value: WideString);

var P, P1: PWideChar;
    S: WideString;

begin
  BeginUpdate;
  try
    Clear;
    P := PWideChar(Value);
    while P^ in [WideChar(#1)..WideSpace] do Inc(P);
    while P^ <> WideNull do
    begin
      if P^ = '"' then  S := WideExtractQuotedStr(P, '"')
                  else
      begin
        P1 := P;
        while (P^ > WideSpace) and (P^ <> ',') do Inc(P);
        SetString(S,P1,P-P1);
      end;
      Add(S);

      while P^ in [WideChar(#1)..WideSpace] do Inc(P);
      if P^ = ',' then
        repeat
          Inc(P);
        until not (P^ in [WideChar(#1)..WideSpace]);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TWideStrings.SetText(Text: PWideChar);
begin
  SetTextStr(Text);
end;

procedure TWideStrings.SetTextStr(const Value: WideString);
var P, Start: PWideChar;
    S: WideString;

begin
  BeginUpdate;
  try
    Clear;
    P:=PWideChar(Value);
    if assigned(P) then
      while P^ <> WideNull do
      begin
        Start := P;
        while not (P^ in [WideNull, WideLF, WideCR]) do Inc(P);
        SetString(S,Start,P-Start);
        Add(S);
        if P^ = WideCR then Inc(P);
        if P^ = WideLF then Inc(P);
      end;
  finally
    EndUpdate;
  end;
end;

procedure TWideStrings.SetUpdateState(Updating: Boolean);
begin
end;

procedure TWideStrings.SetValue(const Name, Value: WideString);

var I : Integer;

begin
  I:=IndexOfName(Name);
  if Value <> '' then
  begin
    if I < 0 then I := Add('');
    Put(I,Name+'='+Value);
  end
  else
    if I >= 0 then Delete(I);
end;


procedure TWideStrings.WriteData(Writer: TWriter);
var I: Integer;
begin
  Writer.WriteListBegin;
  for I := 0 to Count-1 do
    Writer.WriteWideString(Get(I));
  Writer.WriteListEnd;
end;

function TWideStrings.GetLanguage: TLanguage;
begin
  Result:=Flanguage;
end;

destructor TWideStringList.Destroy;
begin
  FOnChange := nil;
  FOnChanging := nil;
  inherited Destroy;
  if FCount <> 0 then Finalize(FList^[0], FCount);
  FCount:=0;
  SetCapacity(0);
end;

function TWideStringList.Add(const S: WideString): Integer;
begin
  if not Sorted then Result:=FCount
                else
    if Find(S, Result) then
      case Duplicates of
        dupIgnore: Exit;
        dupError: Error(SDuplicateString, 0);
      end;
  InsertItem(Result, S);
end;

procedure TWideStringList.Changed;
begin
  if (FUpdateCount = 0) and assigned(FOnChange) then FOnChange(Self);
end;

procedure TWideStringList.Changing;
begin
  if (FUpdateCount = 0) and assigned(FOnChanging) then FOnChanging(Self);
end;

procedure TWideStringList.Clear;
begin
  if FCount <> 0 then
  begin
    Changing;
    Finalize(FList^[0], FCount);
    FCount := 0;
    SetCapacity(0);
    Changed;
  end;
end;

procedure TWideStringList.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  Changing;
  Finalize(FList^[Index]);
  Dec(FCount);
  if Index < FCount then System.Move(FList^[Index+1],FList^[Index],(FCount-Index)*SizeOf(TStringItem));
  Changed;
end;

procedure TWideStringList.Exchange(Index1, Index2: Integer);
begin
  if (Index1 < 0) or (Index1 >= FCount) then Error(SListIndexError, Index1);
  if (Index2 < 0) or (Index2 >= FCount) then Error(SListIndexError, Index2);
  Changing;
  ExchangeItems(Index1, Index2);
  Changed;
end;

procedure TWideStringList.ExchangeItems(Index1, Index2: Integer);
var Temp: Integer;
    Item1,
    Item2: PWideStringItem;
begin
  Item1 := @FList^[Index1];
  Item2 := @FList^[Index2];
  Temp := Integer(Item1^.FString);
  Integer(Item1^.FString) := Integer(Item2^.FString);
  Integer(Item2^.FString) := Temp;
  Temp := Integer(Item1^.FObject);
  Integer(Item1^.FObject) := Integer(Item2^.FObject);
  Integer(Item2^.FObject) := Temp;
end;

function TWideStringList.Find(const S: WideString; var Index: Integer): Boolean;
var L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := FCount-1;
  while L <= H do
  begin
    I:=(L+H) shr 1;
    C:=WideCompareText(FList^[I].FString, S, FLanguage);
    if C < 0 then L:=I+1
             else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then L:=I;
      end;
    end;
  end;
  Index:=L;
end;

function TWideStringList.Get(Index: Integer): WideString;
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  Result := FList^[Index].FString;
end;

function TWideStringList.GetCapacity: Integer;
begin
  Result := FCapacity;
end;

function TWideStringList.GetCount: Integer;
begin
  Result := FCount;
end;

function TWideStringList.GetObject(Index: Integer): TObject;
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  Result := FList^[Index].FObject;
end;

procedure TWideStringList.Grow;
var Delta: Integer;
begin
  if FCapacity > 64 then Delta := FCapacity div 4
                    else
    if FCapacity > 8 then Delta := 16
                     else Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

function TWideStringList.IndexOf(const S: WideString): Integer;
begin
  if not Sorted then Result := inherited IndexOf(S)
                else
    if not Find(S, Result) then Result := -1;
end;

procedure TWideStringList.Insert(Index: Integer; const S: WideString);
begin
  if Sorted then Error(SSortedListError, 0);
  if (Index < 0) or (Index > FCount) then Error(SListIndexError, Index);
  InsertItem(Index, S);
end;

procedure TWideStringList.InsertItem(Index: Integer; const S: WideString);
begin
  Changing;
  if FCount = FCapacity then Grow;
  if Index < FCount then
    System.Move(FList^[Index],FList^[Index+1],(FCount-Index)*SizeOf(TStringItem));
  with FList^[Index] do
  begin
    Pointer(FString) := nil;
    FObject := nil;
    FString := S;
  end;
  Inc(FCount);
  Changed;
end;

procedure TWideStringList.Put(Index: Integer; const S: WideString);
begin
  if Sorted then Error(SSortedListError, 0);
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  Changing;
  FList^[Index].FString := S;
  Changed;
end;

procedure TWideStringList.PutObject(Index: Integer; AObject: TObject);
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  Changing;
  FList^[Index].FObject := AObject;
  Changed;
end;

procedure TWideStringList.QuickSort(L, R: Integer);
var
  I, J: Integer;
  P: WideString;
begin
  repeat
    I := L;
    J := R;
    P := FList^[(L + R) shr 1].FString;
    repeat
      while WideCompareText(FList^[I].FString, P, FLanguage) < 0 do Inc(I);
      while WideCompareText(FList^[J].FString, P, FLanguage) > 0 do Dec(J);
      if I <= J then
      begin
        ExchangeItems(I, J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J);
    L := I;
  until I >= R;
end;

procedure TWideStringList.SetCapacity(NewCapacity: Integer);
begin
  ReallocMem(FList, NewCapacity * SizeOf(TStringItem));
  FCapacity := NewCapacity;
end;

procedure TWideStringList.SetSorted(Value: Boolean);
begin
  if FSorted <> Value then
  begin
    if Value then Sort;
    FSorted := Value;
  end;
end;

procedure TWideStringList.SetUpdateState(Updating: Boolean);
begin
  if Updating then Changing
              else Changed;
end;

procedure TWideStringList.Sort;
begin
  if not Sorted and (FCount > 1) then
  begin
    Changing;
    QuickSort(0,FCount-1);
    Changed;
  end;
end;

procedure TWideStringList.SetLanguage(Value: TLanguage);
begin
  inherited;
  if Sorted then Sort;
end;

initialization
  if WindowsNT then
    @WideCompareText:= @CompareTextWinNT
  else
    @WideCompareText:= @CompareTextWin95;
end.