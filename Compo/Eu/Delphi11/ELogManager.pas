{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{       Log Manager Unit - ELogManager           }
{                                                }
{  Copyright (c) 2001 - 2008 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ELogManager;

{$I Exceptions.inc}

interface

uses Windows, SysUtils, Classes;

type
  TLogFile = class
  private
    FFileName: AnsiString;
    FStream: TStream;
    FList: TStrings;
    FPassword: AnsiString;
    function GetItem(Index: Integer): AnsiString;
    function GetCount: Integer;
    function GetItem_Generals(Index: Integer): AnsiString;
    function GetItem_CallStack(Index: Integer): AnsiString;
    function GetItem_Modules(Index: Integer): AnsiString;
    function GetItem_Processes(Index: Integer): AnsiString;
    function GetItem_Assembler(Index: Integer): AnsiString;
    function GetItem_CPU(Index: Integer): AnsiString;
    function GetItem_Reproduce(Index: Integer): AnsiString;
    function GetItem_GeneralsXML(Index: Integer): AnsiString;
    function GetItem_CallStackXML(Index: Integer): AnsiString;
    function GetItem_ModulesXML(Index: Integer): AnsiString;
    function GetItem_ProcessesXML(Index: Integer): AnsiString;
    function GetItem_AssemblerXML(Index: Integer): AnsiString;
    function GetItem_CPUXML(Index: Integer): AnsiString;
    function GetLogVersion(Index: Integer): AnsiString;
    function GetCorruptedLog(Index: Integer): Boolean;
    function GetItem_ReproduceXML(Index: Integer): AnsiString;
    function GetItem_XML(Index: Integer): AnsiString;
    function GetXML: AnsiString;
    function GetText: AnsiString;
  protected
    procedure ParseBuffer(Buffer: PAnsiChar);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    function SectionIndex(const Source: AnsiString; SecNum: Integer; Header: Boolean): Integer;
  public
    constructor Create(const FileName: AnsiString; ReadOnly: Boolean);
    destructor Destroy; override;
    procedure Append(const Log: AnsiString; MaxNum: Integer);
    procedure DeleteItem(ItemNumber: Integer);
    procedure Clear;
    procedure Save;
    procedure SaveXMLCopy(const FileName: AnsiString);
    function FindItem(const IDs, Values: array of AnsiString): Integer;
    function GetItemValue(const ID: AnsiString; ItemNumber: Integer): AnsiString;
    procedure SetItemValue(const ID, Value, Caption: AnsiString; ItemNumber: Integer);

    property Items[Index: Integer]: AnsiString read GetItem; default;
    property Items_Generals[Index: Integer]: AnsiString read GetItem_Generals;
    property Items_GeneralsXML[Index: Integer]: AnsiString read GetItem_GeneralsXML;
    property Items_CallStack[Index: Integer]: AnsiString read GetItem_CallStack;
    property Items_CallStackXML[Index: Integer]: AnsiString read GetItem_CallStackXML;
    property Items_Modules[Index: Integer]: AnsiString read GetItem_Modules;
    property Items_ModulesXML[Index: Integer]: AnsiString read GetItem_ModulesXML;
    property Items_ProcessesXML[Index: Integer]: AnsiString read GetItem_ProcessesXML;
    property Items_Processes[Index: Integer]: AnsiString read GetItem_Processes;
    property Items_Assembler[Index: Integer]: AnsiString read GetItem_Assembler;
    property Items_AssemblerXML[Index: Integer]: AnsiString read GetItem_AssemblerXML;
    property Items_CPU[Index: Integer]: AnsiString read GetItem_CPU;
    property Items_CPUXML[Index: Integer]: AnsiString read GetItem_CPUXML;
    property Items_Reproduce[Index: Integer]: AnsiString read GetItem_Reproduce;
    property Items_ReproduceXML[Index: Integer]: AnsiString read GetItem_ReproduceXML;
    property Items_XML[Index: Integer]: AnsiString read GetItem_XML;
    property XML: AnsiString read GetXML;
    property LogVersion[Index: Integer]: AnsiString read GetLogVersion;
    property IsCoppuptedLog[Index: Integer]: Boolean read GetCorruptedLog;
    property Text: AnsiString read GetText;
    property Count: Integer read GetCount;
    property Password: AnsiString read FPassword write FPassword;
  end;

  TLogItem = class
  private
    FString: AnsiString;
    FHeaderNo, FItemNo, FFirstHeader: Integer;
  protected
    function GetString: AnsiString;
  public
    constructor Create(AFirstHeader: Integer);
    procedure AddHeader(const AHeader: AnsiString);
    procedure AddItem(AItem, AValue: AnsiString; Add: Boolean);
    procedure Clear;
  public
    property Value: AnsiString read GetString;
  end;

implementation

uses ECore, EXMLBuilder, EBase64, EEncrypt;

const
  EOFLine: AnsiString = #13#10#13#10#13#10;

function ConvertNotDosText(const Text: AnsiString): AnsiString;
var
  Buf, PStart: PAnsiChar;
  Idx: Integer;

  function NeedConvertNotDosText(const S: AnsiString): Boolean;
  var
    Buf, PStart: PAnsiChar;
  begin
    Result := False;
    Buf := PAnsiChar(S);
    PStart := Buf;
    while (Buf^ <> #0) do
    begin
      if ((Buf^ = #13) and ((Buf + 1)^ <> #10)) or
        ((Buf^ = #10) and (Buf > PStart) and ((Buf - 1)^ <> #13)) then
      begin
        Result := True;
        Break;
      end;
      Inc(Buf);
    end;
  end;

begin
  if (not NeedConvertNotDosText(Text)) Then
  begin
    Result := Text;
    Exit;
  end;

  Idx := 1;
  Buf := PAnsiChar(Text);
  PStart := Buf;
  SetLength(Result, Length(Text) * 2 + 2);
  while (Buf^ <> #0) do
  begin
    if (Buf^ = #13) and ((Buf + 1)^ <> #10) then
    begin
      Result[Idx] := #13;
      Inc(Idx);
      Result[Idx] := #10;
    end
    else
      if (Buf^ = #10) and (Buf > PStart) and ((Buf - 1)^ <> #13) then
      begin
        Result[Idx] := #13;
        Inc(Idx);
        Result[Idx] := #10;
      end
      else Result[Idx] := Buf^;
    Inc(Idx);
    Inc(Buf);
  end;
  SetLength(Result, Idx - 1);
end;

{ TLogFile }

constructor TLogFile.Create(const FileName: AnsiString; ReadOnly: Boolean);
var
  OpenFlags: Word;
begin
  FPassword := '';
  FFileName := FileName;
  GetWorkingFile(FFileName, True, ReadOnly);

  FList := TStringList.Create;
  if (FileExists(FFileName)) then
  begin
    if (not ReadOnly) then OpenFlags := fmOpenReadWrite
    else OpenFlags := fmOpenRead;
    OpenFlags := (OpenFlags or fmShareDenyNone);
    FStream := TFileStream.Create(FFileName, OpenFlags);
    LoadFromStream(FStream);
  end
  else FStream := nil;
end;

destructor TLogFile.Destroy;
begin
  if (FStream <> nil) then FStream.Free;
  FList.Free;
end;

procedure TLogFile.ParseBuffer(Buffer: PAnsiChar);
var
  First, Last: PAnsiChar;
  Item: AnsiString;

  function SearchNextItem(Start: PAnsiChar): PAnsiChar;
  begin
    Result := nil;
    if (Start = nil) then Exit;
    while (Start^ <> #0) do
    begin
      if (Start^ = #13) then
      begin
        if ((Start + 1)^ = #10) and ((Start + 2)^ = #13) and
          ((Start + 3)^ = #10) and ((Start + 4)^ = #13) and
          ((Start + 5)^ = #10) and ((Start + 6)^ = #13) and
          ((Start + 7)^ = #10) then
        begin
          Result := Start;
          Break;
        end;
      end;
      Inc(Start);
    end;
  end;

begin
  Buffer := PAnsiChar(ConvertNotDosText(AnsiString(Buffer)));

  Last := Buffer;
  repeat
    if (Last <> Buffer) then First := (Last + 8)
    else First := Buffer;
    if (First <> nil) then
      if ((First = Buffer) or (((First - 2)^ = #13) and ((First - 1)^ = #10))) then
      begin
        Last := SearchNextItem(First);
        if (Last = Buffer) then Inc(Last)
        else
          if (Last <> nil) then
          begin
            SetString(Item, First, (Last - First + 6));
            // Check if the Item contains the Call Stack data,
            // otherwise is a wrong item (corrupted)...
            if (Pos('-' + #13#10 + '|', Item) > 0) then FList.Add(Item);
          end;
      end
      else Last := (First + 1);
  until (First = nil) or (Last = nil);
end;

procedure TLogFile.LoadFromStream(Stream: TStream);
var
  Buffer: PAnsiChar;
  Size: Integer;
  LastLine: AnsiString;
begin
  Size := (Stream.Size - Stream.Position);
  GetMem(Buffer, Size + Length(EOFLine));
  try
    Stream.Read(Buffer^, Size);
    if (Size >= Length(EOFLine)) then
    begin
      SetString(LastLine, (Buffer + Size - Length(EOFLine)), Length(EOFLine));

      // Check for the final EOFLine block...
      if (LastLine <> EOFLine) then
      begin
        Move(PAnsiChar(EOFLine)^, (Buffer + Size)^, Length(EOFLine));
        (Buffer + Size + Length(EOFLine))^ := #0;
      end;

      ParseBuffer(Buffer);
    end;
  finally
    FreeMem(Buffer);
  end;
end;

procedure TLogFile.SaveToStream(Stream: TStream);
var
  Txt: AnsiString;
begin
  Txt := FList.Text;
  if (Txt = '') then Exit;
  
  if (Copy(Txt, Length(Txt) - 9, 2) = #13#10) then // Check the CR numbers...
    Stream.Write(Txt[1], Length(Txt) - 2)
  else
    Stream.Write(Txt[1], Length(Txt));
end;

procedure TLogFile.Append(const Log: AnsiString; MaxNum: Integer);
var
  n: Integer;
begin
  if (MaxNum <> -1) then
    for n := MaxNum to FList.Count do FList.Delete(0);
  FList.Add(Log + EOFLine);
end;

procedure TLogFile.DeleteItem(ItemNumber: Integer);
begin
  FList.Delete(ItemNumber);
end;

procedure TLogFile.Clear;
begin
  FList.Clear;
end;

function TLogFile.FindItem(const IDs, Values: array of AnsiString): Integer;
var
  n, i: Integer;

  function SearchItem(const ID, Value, Source: AnsiString): Boolean;
  var
    Idx, First: Integer;
    tmp, Src: AnsiString;

    function ElaborateString(const S: AnsiString; SpacesLen: Integer): AnsiString;
    var
      List: TStringList;
      n: Integer;
      Spaces: AnsiString;
    begin
      Spaces := '';
      for n := 1 to SpacesLen do Spaces := (Spaces + ' ');
      List := TStringList.Create;
      try
        List.Text := QuickStringReplace(S, ': ', ':_');
        for n := 1 to (List.Count - 1) do
        begin
          if (Trim(List[n]) = '') then List[n] := '.';
          List[n] := (Spaces + List[n]);
        end;
        Result := List.Text;
      finally
        List.Free;
      end;
    end;

  begin
    Result := False;
    Idx := Pos(#13#10 + '  ' + ID + ' ', Source);
    if (Idx <> 0) then // Item found.
    begin
      tmp := Copy(Source, Idx + 2, Length(Source));
      First := (Pos(': ', tmp) + 2);
      Src := ElaborateString(Value, (First - 1));
      tmp := Copy(tmp, First, Length(Src));
      Result := (tmp = Src);
    end;
  end;

begin
  Result := -1;
  for n := 0 to FList.Count - 1 do
  begin
    i := 0;
    while (i <= high(IDs)) do
    begin
      if (SearchItem(IDs[i], Values[i], FList[n])) then
      begin
        Result := i;
        Break;
      end;
      Inc(i);
    end;
  end;
end;

procedure TLogFile.Save;
begin
  if (FStream = nil) then
    FStream := TFileStream.Create(FFileName, fmCreate or fmShareDenyNone);
  FStream.Position := 0;
  SaveToStream(FStream);
  FStream.Size := FStream.Position;
end;

procedure TLogFile.SetItemValue(const ID, Value, Caption: AnsiString; ItemNumber: Integer);
var
  Idx, IDIdx, First, Last, n, Spaces: Integer;
  Source, CurrID, NewLine: AnsiString;

  function CompleteStr(const s: AnsiString; len: integer): AnsiString;
  var
    i: Integer;
  begin
    Result := s;
    for i := Length(s) + 1 to len do
      Result := Result + ' ';
  end;

begin
  if (ItemNumber < 0) or (ItemNumber >= FList.Count) then Exit;

  Source := FList[ItemNumber];
  Idx := Pos(#13#10 + '  ' + ID + ' ', Source);
  if (Idx <> 0) then // Item found.
  begin
    First := (PosEx(': ', Source, Idx));
    if (First <> -1) then
    begin
      Inc(First , 2);
      Last := First;
      Idx := First;
      while (Idx <= Length(Source)) do
      begin
        if (Copy(Source, Idx, 4) = #13#10#13#10) then
        begin
          if ((Copy(Source, Idx + 4, 2) = '  ') and
            (Copy(Source, Idx + 6, 1) <> ' ')) or
            (Copy(Source, Idx + 4, 1) <> ' ') then Break;
        end;
        Last := Idx;
        Inc(Idx);
      end;
      Delete(Source, First, Last - First + 1);
      Insert(Value, Source, First);
      if (Copy(Source, Length(Source) - 5, 6) <> #13#10#13#10#13#10) then
        FList[ItemNumber] := (Source + #13#10)
      else
        FList[ItemNumber] := Source;
    end;
  end
  else // Item not found.
  begin
    Spaces := 0;
    IDIdx := Pos('.', ID);
    if (IDIdx > 0) then
    begin
      Last := -1;
      for n := 1 to 19 do
      begin
        CurrID := (Copy(ID, 1, IDIdx) + IntToStr(n));
        Idx := Pos(#13#10 + '  ' + CurrID + ' ', Source);
        if (Idx > 0) then
        begin
          First := (PosEx(': ', Source, Idx));
          Spaces := (First - (Idx + 4));
          Last := Idx;
        end;
      end;
      if (Last <> -1) then
      begin
        Idx := PosEx(#13#10#13#10, Source, Last);
        if (Idx <> 0) then
        begin
          Inc(Idx, 2);
          NewLine := ('  ' + CompleteStr((ID + ' ' + Caption), Spaces) + ': ');
          Insert((NewLine + Value + #13#10), Source, Idx);
          FList[ItemNumber] := Source;
        end;
      end;
    end;
  end;
end;

function TLogFile.GetItemValue(const ID: AnsiString; ItemNumber: Integer): AnsiString;
var
  n, Idx, First, Last: Integer;
  Source: AnsiString;
  Prev, Curr: AnsiChar;
begin
  Result := '';
  if (ItemNumber < 0) or (ItemNumber >= FList.Count) then Exit;

  Source := FList[ItemNumber];
  Idx := Pos(#13#10 + '  ' + ID + ' ', Source);
  if (Idx <> 0) then // Item found.
  begin
    First := (PosEx(': ', Source, Idx + 2) + 2);

    Last := First;
    repeat
      Last := (PosEx(#13#10, Source, Last) + 2);
    until (Copy(Source, Last, 2) = #13#10) or
      ((Copy(Source, Last, 2) = '  ') and (Copy(Source, Last + 3, 1) <> ' '));
    n := First;
    while (n <= Last - 2) do
    begin
      if (Source[n] <> #13) then Result := (Result + Source[n])
      else
        if ((Source[n + 1] = #10) and (n < Last - 2)) then
        begin
          Result := (Result + #13#10);
          Inc(n, 2);
          while (Source[n] = ' ') do Inc(n);
          Continue;
        end;
      Inc(n);
    end;
    for n := 2 to Length(Result) do
    begin
      Prev := Result[n - 1];
      Curr := Result[n];
      if ((Curr = '_') and (Prev = ':')) or
        ((Curr = '.') and (Prev = #10)) then Result[n] := ' '
      else
        if ((Curr = #13) and (Prev = '.')) then Result[n - 1] := ' ';
    end;
    Result := Trim(Result);
  end;
end;

function TLogFile.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TLogFile.GetText: AnsiString;
begin
  Result := FList.Text;
end;

function TLogFile.GetItem(Index: Integer): AnsiString;
begin
  Result := FList[Index];
end;

function TLogFile.SectionIndex(const Source: AnsiString; SecNum: Integer; Header: Boolean): Integer;
var
  n: Integer;
begin
  Result := PosEx('-' + #13#10 + '|', Source, 1); // CallStack start.
  if (Header) then
    for n := 1 to SecNum do
      Result := (PosEx(#13#10#13#10, Source, Result + 4) + 4)
  else
    for n := 1 to SecNum do
      Result := (PosEx(':' + #13#10 + '-', Source, Result) + 3);
end;

function TLogFile.GetItem_Generals(Index: Integer): AnsiString;
var
  sec_end: Integer;
begin
  Result := FList[Index];
  sec_end := PosEx('-' + #13#10 + '|', Result, 1);
  if (sec_end > 0) then
  begin
    // Search the line start.
    while (sec_end > 1) and (Result[sec_end] <> #10) do Dec(sec_end);
    // Two timer (two lines).
    dec(sec_end);
    while (sec_end > 1) and (Result[sec_end] <> #10) do Dec(sec_end);
    // Search the section end.
    while (sec_end > 1) and (Result[sec_end] in [' ', #13, #10]) do Dec(sec_end);
    if (sec_end > 0) then
      Result := Copy(Result, 1, sec_end)
    else
      Result := '';
  end
  else Result := '';
end;

function TLogFile.GetItem_CallStack(Index: Integer): AnsiString;
var
  sec_start, sec_end: Integer;
begin
  Result := FList[Index];
  sec_start := PosEx('-' + #13#10 + '|', Result, 1);
  if (sec_start > 0) then
  begin
    // Search the line start.
    while (sec_start > 1) and (Result[sec_start - 1] <> #10) do
      dec(sec_start);
    sec_end := PosEx('-' + #13#10#13#10, Result, sec_start);
    if (sec_end > 0) then
      Result := Copy(Result, sec_start, (sec_end - sec_start + 1))
    else
      Result := '';
  end
  else
    Result := '';
end;

function TLogFile.GetItem_Modules(Index: Integer): AnsiString;
var
  sec_start, sec_end: Integer;
begin
  Result := FList[Index];
  sec_start := SectionIndex(Result, 1, False);
  if (Copy(Result, PosEx('-'#13#10, Result, sec_start) + 3, 1) = '|') then
  begin
    // Search the line start.
    while (sec_start > 1) and (Result[sec_start - 1] <> #10) do dec(sec_start);
    sec_end := PosEx('-' + #13#10#13#10, Result, sec_start);
    if (sec_end > 0) then
      Result := Copy(Result, sec_start, (sec_end - sec_start + 1))
    else
      Result := '';
  end
  else Result := '';
end;

function TLogFile.GetItem_Processes(Index: Integer): AnsiString;
var
  sec_start, sec_end: Integer;
begin
  Result := '';
  if (LogVersion[Index] < '6.0') then Exit;

  Result := FList[Index];
  sec_start := SectionIndex(Result, 2, False);
  if (Copy(Result, PosEx('-'#13#10, Result, sec_start) + 3, 1) = '|') then
  begin
    // Search the line start.
    while (sec_start > 1) and (Result[sec_start - 1] <> #10) do dec(sec_start);
    sec_end := PosEx('-' + #13#10#13#10, Result, sec_start);
    if (sec_end > 0) then
      Result := Copy(Result, sec_start, (sec_end - sec_start + 1))
    else
      Result := '';
  end
  else Result := '';
end;

function TLogFile.GetItem_Assembler(Index: Integer): AnsiString;
var
  sec_start, sec_end: Integer;
begin
  Result := '';
  if (LogVersion[Index] < '6.0') then Exit;

  Result := FList[Index];
  sec_start := SectionIndex(Result, 3, False);
  sec_start := (PosEx(#13#10, Result, sec_start) + 2);
  sec_end := PosEx(#13#10#13#10, Result, sec_start);
  Result := Copy(Result, sec_start, (sec_end - sec_start));
end;

function TLogFile.GetItem_CPU(Index: Integer): AnsiString;
var
  sec_start, sec_end, n, sec_num: Integer;
begin
  Result := FList[Index];
  sec_num := 2;
  if (LogVersion[Index] >= '6.0') then Inc(sec_num, 2);
  sec_start := SectionIndex(Result, sec_num, True);
  // Search the line start.
  while (sec_start > 1) and (Result[sec_start - 1] <> #10) do dec(sec_start);
  sec_end := sec_start;
  for n := 1 to 2 do
    sec_end := PosEx(#13#10#13#10, Result, sec_end + 1);
  if (sec_end > 0) then
    Result := Copy(Result, sec_start, (sec_end - sec_start - 1))
  else
    Result := '';
  if (PosEx('EAX', Result, 1) = 0) then Result := '';
end;

function TLogFile.GetItem_Reproduce(Index: Integer): AnsiString;
var
  sec_start, sec_end, n: Integer;
begin
  Result := FList[Index];
  sec_start := PosEx('-' + #13#10 + '|', Result, 1);
  // Second section.
  for n := 1 to 2 do
    sec_start := PosEx('-' + #13#10 + '|', Result, sec_start + 1);
  if (sec_start > 0) then
  begin
    for n := 1 to 3 do
      sec_start := PosEx(':' + #13#10 + '-', Result, sec_start + 1);
    if (sec_start > 0) then
    begin
      // Search the line start.
      while (sec_start < length(Result)) and
        (Copy(Result, sec_start - 3, 3) <> '-'#13#10) do
        inc(sec_start);
      sec_end := PosEx(#13#10#13#10, Result, sec_start + 1);
      if (sec_end > 0) then
        Result := Copy(Result, sec_start, (sec_end - sec_start - 1))
      else
        Result := '';
    end
    else
      Result := '';
  end;
end;

function TLogFile.GetItem_GeneralsXML(Index: Integer): AnsiString;
var
  Source: TStrings;
  TmpLine, GroupLabel, GroupName, LineName, LineLabel, LineValue: AnsiString;
  n, Idx, Idx2, Idx3: Integer;
  Group, AddValue: Boolean;
  XMLDoc, GroupItem, LineItem: TXMLItem;

  procedure AddValueField;
  begin
    if (Copy(LineValue, 1, 3) = '.'#13#10) then Delete(LineValue, 1, 1);
    if (Copy(LineValue, Length(LineValue) - 2, 3) = #13#10'.') then
      Delete(LineValue, Length(LineValue), 1);
    LineValue := QuickStringReplace(LineValue, ':_', ': ');
    LineValue := QuickStringReplace(LineValue, #10'.'#13, #10#13);
    LineItem.AddField('Value', LineValue);
  end;

begin
  GroupItem := nil;
  LineItem := nil;
  XMLDoc := TXMLItem.Create('General');
  try
    Group := True;
    AddValue := False;
    Source := TStringList.Create;
    try
      Source.Text := Items_Generals[Index];
      n := 2;
      while (n <= Source.Count - 1) do
      begin
        if (Group) then
        begin
          GroupItem := XMLDoc.AddItem('Group');
          GroupLabel := Source[n];
          Delete(GroupLabel, Length(GroupLabel), 1);
          GroupName := '';
          LineName := '';
          LineLabel := '';
          LineValue := '';
          Group := False;
          Inc(n);
        end
        else
        begin
          TmpLine := Trim(Source[n]);
          Idx := Pos(': ', TmpLine);
          if (Idx = 0) and (Copy(TmpLine, Length(TmpLine), 1) = ':') then Idx := Length(TmpLine);
          if (Idx > 0) then
          begin
            if (AddValue) then AddValueField;
            Idx2 := Pos(' ', TmpLine);
            LineName := Copy(TmpLine, 1, Idx2 - 1);
            Idx3 := Pos('.', LineName);
            if (GroupName = '') then
            begin
              GroupName := Copy(LineName, 1, Idx3 - 1);
              GroupItem.AddField('ID', GroupName);
              GroupItem.AddField('Label', GroupLabel);
            end;
            LineLabel := Trim(Copy(TmpLine, Idx2 + 1, Idx - Idx2 - 1));
            LineValue := Copy(TmpLine, Idx + 2, Length(TmpLine));
            LineItem := GroupItem.AddItem('Line');
            LineItem.AddField('ID', LineName);
            LineItem.AddField('Label', LineLabel);
            AddValue := True;
          end
          else
            if (TmpLine = '') then
            begin
              Group := True;
              AddValueField;
              AddValue := False;
            end
            else LineValue := (LineValue + #13#10 + TmpLine);
        end;
        Inc(n);
        if (n >= Source.Count) then
        begin
          AddValueField;
          AddValue := False;
        end;
      end;
    finally
      Source.Free;
    end;
    Result := XMLDoc.XMLText;
  finally
    XMLDoc.Free;
  end;
end;

function TLogFile.GetItem_CallStackXML(Index: Integer): AnsiString;
var
  Lines, Values: TStringList;
  n, Idx: Integer;
  Offset, Line, Value, TmpLine, Base64, LangType, UnitName, ProcName, ClassName: AnsiString;
  XMLDoc, ThreadItem, LineItem: TXMLItem;
  Master, First: Boolean;

  function ExtractValue(const S: AnsiString): AnsiString;
  begin
    Result := Copy(S, Pos('=', S) + 1, Length(S));
  end;

  function TestDecrypt(const Value: AnsiString): Boolean;
  const
    chars: set of AnsiChar = ['a'..'z', 'A'..'Z', '0'..'9', '_', '.', '@'];
  var
    n: Integer;
  begin
    Result := True;
    for n := 1 to Length(Value) do
      if not (Value[n] in chars) then
      begin
        Result := False;
        Break;
      end;
  end;

begin
  Lines := TStringList.Create;
  Values := TStringList.Create;
  XMLDoc := TXMLItem.Create('CallStack');
  if (LogVersion[Index] < '5.0') then ThreadItem := XMLDoc.AddItem('ExceptionThread')
  else ThreadItem := nil;
  Value := Items_CallStack[Index];
  try
    Master := True;
    First := True;
    Lines.Text := Value;
    for n := 3 to Lines.Count - 2 do
    begin
      Values.Clear;
      ExtractStringsEx(['|'], Lines[n], Values);
      if (Copy(Lines[n], 1, 2) = '|-') then Continue;
      if (Values.Count > 5) then
      begin
        UnitName := Values[2];
        ClassName := Values[3];
        ProcName := Values[4];

        if (Copy(UnitName, 1, 1) = '?') and (FPassword <> '') then // Encrypted...
        begin
          LangType := Copy(UnitName, 2, 1);
          Base64 := (Copy(UnitName, 3, Length(UnitName)));
          UnitName := Base64DecodeString(Base64);
          EEncrypt.Decrypt(UnitName[1], UnitName[1], Length(UnitName));
          if (LowerCase(ExtractFileExt(UnitName)) = '') then
            if (LangType = 'p') then UnitName := (UnitName + '.pas')
            else UnitName := (UnitName + '.cpp');
          Base64 := (Copy(ProcName, 2, Length(ProcName)));
          ProcName := Base64DecodeString(Base64);
          EEncrypt.Decrypt(ProcName[1], ProcName[1], Length(ProcName));
          Idx := Pos('.', ProcName);
          if (Idx > 0) then
          begin
            ClassName := Copy(ProcName, 1, Idx - 1);
            Procname := Copy(ProcName, Idx + 1, Length(ProcName));
          end
          else
            if (ClassName <> '') then
            begin
              Base64 := (Copy(ClassName, 2, Length(ClassName)));
              ClassName := Base64DecodeString(Base64);
              EEncrypt.Decrypt(ClassName[1], ClassName[1], Length(ClassName));
            end;

          if (not TestDecrypt(UnitName)) or (not TestDecrypt(ClassName)) or
            (not TestDecrypt(ProcName)) then
          begin
            UnitName := Values[2];
            ClassName := Values[3];
            ProcName := Values[4];
          end;
        end;
        if (ProcName <> '') and (ProcName[1] = '@') then ProcName[1] := '_';

        LineItem := ThreadItem.AddItem('Line');
        LineItem.AddField('Address', Values[0]);
        LineItem.AddField('Module', Values[1]);
        LineItem.AddField('Unit', UnitName);
        LineItem.AddField('Class', ClassName);
        LineItem.AddField('Procedure', ProcName);

        Idx := Pos('[', Values[5]);
        if (Idx > 0) then
        begin
          Line := Copy(Values[5], 1, Idx - 1);
          Offset := Copy(Values[5], Idx + 1, Length(Values[5]) - Idx - 1);
        end
        else
        begin
          Line := Values[5];
          Offset := '';
        end;
        LineItem.AddField('Number', Line);
        LineItem.AddField('Offset', Offset);
      end
      else
      begin
        if (Values[0] <> '') then
        begin
          Idx := Pos(':', Values[0]);
          TmpLine := Copy(Values[0], Idx + 2, Length(Values[0]));
          ExtractStringsEx([';'], TmpLine, Values);
          if (Master) then
          begin
            if (First) then
            begin
              ThreadItem := XMLDoc.AddItem('ExceptionThread');
              First := False;
            end
            else ThreadItem := XMLDoc.AddItem('RunningThread');
            Master := False;
          end
          else ThreadItem := ThreadItem.AddItem('CallingThread');
          if (Values.Count > 1) then ThreadItem.AddField('ID', ExtractValue(Values[1]));
          if (Values.Count > 2) then ThreadItem.AddField('Priority', ExtractValue(Values[2]));
          if (Values.Count > 3) then ThreadItem.AddField('Class', ExtractValue(Values[3]));
          if (Values.Count > 4) then ThreadItem.AddField('MainThread', 'True')
          else ThreadItem.AddField('MainThread', 'False');
        end
        else Master := True;
      end;
    end;
    Result := XMLDoc.XMLText;
  finally
    XMLDoc.Free;
    Values.Free;
    Lines.Free;
  end;
end;

function TLogFile.GetItem_ModulesXML(Index: Integer): AnsiString;
var
  Lines, Values: TStringList;
  n: Integer;
  Value: AnsiString;
  XMLDoc, LineItem: TXMLItem;
begin
  Lines := TStringList.Create;
  Values := TStringList.Create;
  XMLDoc := TXMLItem.Create('Modules');
  Value := Items_Modules[Index];
  try
    Lines.Text := Value;
    for n := 3 to Lines.Count - 2 do
    begin
      Values.Clear;
      ExtractStringsEx(['|'], Lines[n], Values);
      if (Copy(Lines[n], 1, 2) = '|-') then Continue;
      LineItem := XMLDoc.AddItem('Module');
      LineItem.AddField('Handle', Values[0]);
      LineItem.AddField('Name', Values[1]);
      LineItem.AddField('Description', Values[2]);
      LineItem.AddField('Version', Values[3]);
      LineItem.AddField('Size', Values[4]);
      if (Values.Count > 6) then
      begin
        LineItem.AddField('Modified', Values[5]);
        LineItem.AddField('Path', Values[6]);
      end
      else LineItem.AddField('Path', Values[5]);
    end;
    Result := XMLDoc.XMLText;
  finally
    XMLDoc.Free;
    Values.Free;
    Lines.Free;
  end;
end;

function TLogFile.GetItem_ProcessesXML(Index: Integer): AnsiString;
var
  Lines, Values: TStringList;
  n: Integer;
  Value: AnsiString;
  XMLDoc, LineItem: TXMLItem;
begin
  Lines := TStringList.Create;
  Values := TStringList.Create;
  XMLDoc := TXMLItem.Create('Processes');
  Value := Items_Processes[Index];
  try
    Lines.Text := Value;
    for n := 3 to Lines.Count - 2 do
    begin
      Values.Clear;
      ExtractStringsEx(['|'], Lines[n], Values);
      if (Copy(Lines[n], 1, 2) = '|-') then Continue;
      LineItem := XMLDoc.AddItem('Process');
      LineItem.AddField('ID', Values[0]);
      LineItem.AddField('Name', Values[1]);
      LineItem.AddField('Description', Values[2]);
      LineItem.AddField('Version', Values[3]);
      LineItem.AddField('Memory', Values[4]);
      LineItem.AddField('Priority', Values[5]);
      LineItem.AddField('Threads', Values[6]);
      LineItem.AddField('Path', Values[7]);
    end;
    Result := XMLDoc.XMLText;
  finally
    XMLDoc.Free;
    Values.Free;
    Lines.Free;
  end;
end;

function TLogFile.GetItem_AssemblerXML(Index: Integer): AnsiString;
var
  Lines, Values: TStringList;
  n, Idx: Integer;
  Value, Address, Command, Comment, Line: AnsiString;
  XMLDoc, LineItem: TXMLItem;
begin
  Lines := TStringList.Create;
  Values := TStringList.Create;
  XMLDoc := TXMLItem.Create('Assembler');
  Value := Items_Assembler[Index];
  try
    Lines.Text := Value;
    for n := 0 to Lines.Count - 1 do
    begin
      LineItem := XMLDoc.AddItem('Line');
      Line := Trim(Lines[n]);
      if (Copy(Line, 1, 1) = ';') then
      begin
        Address := '';
        Command := '';
        Comment := Copy(Line, 2, MaxInt);
      end
      else
      begin
        Address := Copy(Line, 1, 8);
        Idx := Pos(';', Line);
        if (Idx = 0) then
        begin
          Command := Copy(Line, 11, MaxInt);
          Comment := '';
        end
        else
        begin
          Command := Copy(Line, 11, Idx - 11);
          Comment := Copy(Line, Idx + 1, MaxInt);
        end;
      end;
      LineItem.AddField('Address', Address);
      LineItem.AddField('Command', Command);
      LineItem.AddField('Comment', Comment);
    end;
    Result := XMLDoc.XMLText;
  finally
    XMLDoc.Free;
    Values.Free;
    Lines.Free;
  end;
end;

function TLogFile.GetItem_CPUXML(Index: Integer): AnsiString;
const
  NoRegValue = '????    ';
var
  Lines: TStringList;
  n: Integer;
  Value, EAX, EBX, ECX, EDX, EDI, ESI, ESP, EIP,
  StackAddr, StackValue, MemAddr, MemBytes, MemStr: AnsiString;
  XMLDoc, GroupItem, LineItem: TXMLItem;
begin
  Lines := TStringList.Create;
  XMLDoc := TXMLItem.Create('CPU');
  Value := Items_CPU[Index];
  try
    if (Trim(Value) <> '') then
    begin
      Lines.Text := Value;
      EAX := Copy(Lines[2], 6, 8);
      EDI := Copy(Lines[2], 22, 8);
      EBX := Copy(Lines[3], 6, 8);
      ESI := Copy(Lines[3], 22, 8);
      ECX := Copy(Lines[4], 6, 8);
      ESP := Copy(Lines[4], 22, 8);
      EDX := Copy(Lines[5], 6, 8);
      EIP := Copy(Lines[5], 22, 8);
      LineItem := XMLDoc.AddItem('Registers');
      if (EAX <> NoRegValue) then LineItem.AddField('EAX', EAX);
      if (EBX <> NoRegValue) then LineItem.AddField('EBX', EBX);
      if (ECX <> NoRegValue) then LineItem.AddField('ECX', ECX);
      if (EDX <> NoRegValue) then LineItem.AddField('EDX', EDX);
      if (EDI <> NoRegValue) then LineItem.AddField('EDI', EDI);
      if (ESI <> NoRegValue) then LineItem.AddField('ESI', ESI);
      if (ESP <> NoRegValue) then LineItem.AddField('ESP', ESP);
      if (EIP <> NoRegValue) then LineItem.AddField('EIP', EIP);
      GroupItem := XMLDoc.AddItem('Stack');
      for n := 9 to Lines.Count - 1 do
      begin
        LineItem := GroupItem.AddItem('Line');
        StackAddr := Copy(Lines[n], 1, 8);
        StackValue := Copy(Lines[n], 11, 8);
        LineItem.AddField('Address', StackAddr);
        LineItem.AddField('Value', StackValue);
      end;
      GroupItem := XMLDoc.AddItem('MemoryDump');
      for n := 9 to Lines.Count - 1 do
      begin
        LineItem := GroupItem.AddItem('Line');
        MemAddr := Copy(Lines[n], 22, 8);
        MemBytes := Copy(Lines[n], 32, 47);
        MemStr := Copy(Lines[n], 81, 16);
        LineItem.AddField('Address', MemAddr);
        LineItem.AddField('Bytes', MemBytes);
        LineItem.AddField('Chars', MemStr);
      end;
    end;
    Result := XMLDoc.XMLText;
  finally
    XMLDoc.Free;
    Lines.Free;
  end;
end;

function TLogFile.GetItem_ReproduceXML(Index: Integer): AnsiString;
var
  XMLDoc: TXMLItem;
begin
  if (LogVersion[Index] < '5.0') then
  begin
    XMLDoc := TXMLItem.Create('HoToReproduce');
    try
      XMLDoc.AddField('Text', Items_Reproduce[Index]);
      Result := XMLDoc.XMLText;
    finally
      XMLDoc.Free;
    end;
  end
  else Result := '';
end;

function TLogFile.GetItem_XML(Index: Integer): AnsiString;
var
  List: TStrings;
  n: Integer;
begin
  List := TStringList.Create;
  try
    List.Text := '<Log Version="' + LogVersion[Index] + '">'#13#10 +
    Items_GeneralsXML[Index] + Items_CallStackXML[Index] +
    Items_ModulesXML[Index] + Items_ProcessesXML[Index] +
    Items_AssemblerXML[Index] + Items_CPUXML[Index] +
    Items_ReproduceXML[Index] + '</Log>';
    for n := 1 to (List.Count - 2) do
      List[n] := ('  ' + List[n]);
    Result := List.Text;
  finally
    List.Free;
  end;
end;

function TLogFile.GetXML: AnsiString;
var
  Total: AnsiString;
  List: TStrings;
  n: Integer;
begin
  Total := '';
  List := TStringList.Create;
  try
    for n := 0 to FList.Count - 1 do
      Total := (Total + Items_XML[n]);
    List.Text := '<Doc>'#13#10 + Total + '</Doc>';
    for n := 1 to (List.Count - 2) do
      List[n] := ('  ' + List[n]);
    Result := List.Text;
  finally
    List.Free;
  end;
end;

function TLogFile.GetLogVersion(Index: Integer): AnsiString;
var
  Lines: TStrings;
begin
  Lines := TStringList.Create;
  try
    Lines.Text := FList[Index];
    Result := Copy(Lines[0], 11, Length(Lines[0]));
  finally
    Lines.Free;
  end;
end;

function TLogFile.GetCorruptedLog(Index: Integer): Boolean;
var
  Lines: TStrings;
begin
  Lines := TStringList.Create;
  try
    Lines.Text := FList[Index];
    Result := not (Copy(Lines[0], 1, 9) = 'EurekaLog');
  finally
    Lines.Free;
  end;
end;

procedure TLogFile.SaveXMLCopy(const FileName: AnsiString);
var
  Tmp: TStrings;
begin
  Tmp := TStringList.Create;
  try
    Tmp.Text := XML;
    Tmp.SaveToFile(FileName {$IFDEF Delphi12Up}, TEncoding.ASCII {$ENDIF});
  finally
    Tmp.Free;
  end;
end;

{ TLogItem }

constructor TLogItem.Create(AFirstHeader: Integer);
begin
  FFirstHeader := AFirstHeader;
  Clear;
end;

procedure TLogItem.Clear;
begin
  FString := '';
  FHeaderNo := FFirstHeader;
  FItemNo := 0;
end;

procedure TLogItem.AddHeader(const AHeader: AnsiString);
begin
  Inc(FHeaderNo);
  FItemNo := 0;
  if (Fstring <> '') then FString := FString + #13#10 + #13#10;
  FString := FString + AHeader + ':' + #13#10 + '-';
end;

procedure TLogItem.AddItem(AItem, AValue: AnsiString; Add: Boolean);
var
  ItemStr, ItemValue: AnsiString;
  n: Integer;
  List: TStringList;
begin
  Inc(FItemNo);
  if (Add) then
  begin
    ItemStr := ('  ' + IntToStr(FHeaderNo) + '.' + IntToStr(FItemNo) + ' ' + AItem + ': ');

    AValue := ConvertNotDosText(AValue);

    if (Pos(#13#10, AValue) = 0) then FString := (FString + #13#10 + ItemStr + AValue)
    else
    begin
      ItemValue := QuickStringReplace(AValue, ': ', ':_');
      List := TStringList.Create;
      try
        List.Text := ItemValue;
        for n := 0 to (List.Count - 1) do
        begin
          if (Trim(List[n]) = '') then List[n] := '.';
          if (n > 0) then List[n] := (' ' + List[n]);
        end;
        ItemValue := List.Text;
        ItemValue := Copy(List.Text, 1, (Length(List.Text) - 2)); // Remove last #13#10 chars.
      finally
        List.Free;
      end;
      FString := (FString + #13#10 + ItemStr + ItemValue)
    end;
  end;
end;

function TLogItem.GetString: AnsiString;
var
  St: TStrings;

  procedure RemoveEmptySections(S: TStrings);
  var
    IsHeader, IsEmpty: Boolean;
    n, m, LastLine, DataLine: Integer;
  begin
    n := 0;
    LastLine := (S.Count - 1);
    while (n <= LastLine) do
    begin
      IsHeader := ((S[n] <> '') and (Pos(':', S[n]) = Length(S[n])));
      if (IsHeader) then
      begin
        DataLine := (n + 2);
        IsEmpty := (DataLine > LastLine) or (S[DataLine] = '');
        if (IsEmpty) then
        begin
          for m := n to DataLine do
          begin
            if (n <= LastLine) then S.Delete(n);
            LastLine := (S.Count - 1);
          end;
        end
        else Inc(n, 3);
      end
      else Inc(n);
    end;
  end;

  procedure NormalizeSpaces(S: TStrings);
  var
    IsHeader: Boolean;
    n, m, LastLine, DataLine, Idx, MaxIdx: Integer;
    Line: AnsiString;

    function Spaces(Count: Integer): AnsiString;
    var
      n: Integer;
    begin
      Result := '';
      for n := 1 to Count do Result := (' ' + Result);
    end;

  begin
    n := 0;
    LastLine := (S.Count - 1);
    while (n <= LastLine) do
    begin
      IsHeader := ((S[n] <> '') and (Pos(':', S[n]) = Length(S[n])));
      if (IsHeader) then
      begin
        DataLine := (n + 2);
        m := DataLine;
        MaxIdx := 0;
        repeat
          Idx := Pos(': ', S[m]);
          if (Idx > MaxIdx) then MaxIdx := Idx;
          Inc(m);
        until ((m > LastLine) or (S[m] = ''));
        m := DataLine;
        repeat
          Idx := Pos(': ', S[m]);
          Line := S[m];
          Insert(Spaces(MaxIdx - Idx), Line, Idx);
          S[m] := Line;
          Inc(m);
        until ((m > LastLine) or (S[m] = ''));
        n := m;
      end
      else Inc(n);
    end;
  end;

  procedure NormalizeLines(S: TStrings);
  var
    IsHeader: Boolean;
    n, m, LastLine, DataLine, MaxLen: Integer;
    Line: AnsiString;

    function Lines(Count: Integer): AnsiString;
    var
      n: Integer;
    begin
      Result := '';
      for n := 1 to Count do Result := ('-' + Result);
    end;

  begin
    n := 0;
    LastLine := (S.Count - 1);
    while (n <= LastLine) do
    begin
      IsHeader := ((S[n] <> '') and (Pos(':', S[n]) = Length(S[n])));
      if (IsHeader) then
      begin
        DataLine := (n + 2);
        m := DataLine;
        MaxLen := 0;
        repeat
          if (Length(S[m]) > MaxLen) then MaxLen := Length(S[m]);
          Inc(m);
        until ((m > LastLine) or (S[m] = ''));
        m := (DataLine - 1);
        Line := S[m];
        Insert(Lines(MaxLen - 1), Line, 1);
        S[m] := Line;
        n := (DataLine + 1);
      end
      else Inc(n);
    end;
  end;

begin
  St := TStringList.Create;
  try
    St.Text := FString;
    RemoveEmptySections(St);
    NormalizeSpaces(St);
    NormalizeLines(St);
    Result := St.Text;
  finally
    St.Free;
  end;
end;

end.
