
{                                                                              }
{ IB_DDL_Formatter                                                             }
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
{  Claudio Valderrama is the original author of this unit.                     }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_DDL_Formatter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms;

type
  TFormatterLineBreak = ( flbCRLF, flbCR, flbLFCR, flbLF );
  TIB_DDL_FormatterType = ( mftText, mftHTML );
  
  TIB_DDL_FormatterText = class
  private
    FLineBreak: TFormatterLineBreak;
    FLineBreakStr: String;
    FLineBreakLength: SmallInt;
    FEncodingDisabled: Boolean;
    FCPtr: TObject;
    FSQLDialect: integer;
    procedure SetLineBreak(ALineBreak: TFormatterLineBreak);
  protected
    function Rev( c: char ): char;
  public
    constructor Create( AController: TObject; ASQLDialect: integer ); virtual;
    function Header(const s: String; level: byte): String; virtual;
    function Bold(const s: String): String; virtual;
    function Italics(const s: String): String; virtual;
    function IBComment(const s: String): String; virtual;
    function IBCommentRaw(const s: String): String;
    function IBIdentifier(const s: string): string; virtual;
    function IBLiteral(const s: String): String; virtual;
    function SetIBTerminator(force: Boolean): String; virtual;
    function ResetIBTerminator(force: Boolean): String; virtual;
    function Color(const s: String; col: TColor): String; virtual;
    function Normal(const s: String): String; virtual;
    function Enclose(const s: String; c: char): String; virtual;
    function DebugOutput(const s: String): String; virtual;
    function DebugOutputRaw(const s: String): String;
    function Indent: String;
    function WritePreamble(const title: String): String; virtual;
    function WriteEpilog: String; virtual;
    function MFormat(const S: String; const Values: array of String): String;
    function NormalizeToLF(const S: String): String;
    function NormalizeToCRLF(const S: String): String;
    function NormalizeToCurrentLineBreak(const S: String): String; virtual;
    procedure DisableEncoding;
    procedure EnableEncoding;
    property LineBreak: TFormatterLineBreak read FLineBreak write SetLineBreak;
    property LineBreakStr: string read FLineBreakStr;
    property EncodingDisabled: Boolean read FEncodingDisabled default False;
  end;

  TIB_DDL_FormatterHTML = class(TIB_DDL_FormatterText)
  private
    FConvertCRLF: Boolean;
    FCharset: String;
  public
    constructor Create( AController: TObject; ASQLDialect: integer ); override;
    function HTTPEncode(const s: String): String;
    function HTMLEncode(const s: String): String;
    function Header(const s: String; level: byte): String; override;
    function Bold(const s: String): String; override;
    function IBComment(const s: String): String; override; 
    function IBIdentifier(const s: string): string; override;
    function IBLiteral(const s: String): String; override;
    function Italics(const s: String): String; override;
    function HTMLComment(const s: String): String;
    function SetIBTerminator(force: Boolean): String; override;
    function ResetIBTerminator(force: Boolean): String; override;
    function Color(const s: String; col: TColor): String; override;
    function Normal(const s: String): String; override;
    function Enclose(const s: String; c: char): String; override;
    //function DebugOutput(const s: String): String; override;
    function WritePreamble(const title: String): String; override;
    function WriteEpilog: String; override;
    function NormalizeToCurrentLineBreak(const S: String): String; override;
    property ConvertCRLF: Boolean read FConvertCRLF write FConvertCRLF
      default True;
    property Charset: String read FCharset write FCharset;
  end;

implementation

uses
  IB_Parse,
  
  IB_DDL_Controller;
  
// ----------------------------------------------------------
// TIB_DDL_FormatterText

constructor TIB_DDL_FormatterText.Create( AController: TObject;
                                      ASQLDialect: integer );
begin
  FCPtr := AController;
  FSQLDialect := ASQLDialect;
  inherited Create;
  SetLineBreak(flbCRLF)
end;

procedure TIB_DDL_FormatterText.SetLineBreak(ALineBreak: TFormatterLineBreak);
begin
  case ALineBreak of
    flbCRLF:
    begin
      FLineBreakLength := 2;
      FLineBreakStr := #13#10
    end;
    flbLFCR:
    begin
      FLineBreakLength := 2;
      FLineBreakStr := #10#13
    end;
    flbCR:
    begin
      FLineBreakLength := 1;
      FLineBreakStr := #13
    end;
    flbLF:
    begin
      FLineBreakLength := 1;
      FLineBreakStr := #10
    end;
  end;
  FLineBreak := ALineBreak;
end;

function TIB_DDL_FormatterText.Rev(c: char): char;
begin
  if c = #10 then
    Result := #13
  else
  if c = #13 then
    Result := #10
  else
    Result := #32;
end;

function TIB_DDL_FormatterText.Header(const s: String; level: byte): String;
begin
  Result := s;
end;

function TIB_DDL_FormatterText.Bold(const s: String): String;
begin
  Result := s;
end;

function TIB_DDL_FormatterText.Italics(const s: String): String;
begin
  Result := s;
end;

function TIB_DDL_FormatterText.IBComment(const s: String): String;
begin
  Result := IBCommentRaw(s);
end;

function TIB_DDL_FormatterText.IBCommentRaw(const s: String): String;
begin
  Result := '/* ' + s + ' */'
end;

function TIB_DDL_FormatterText.SetIBTerminator(force: Boolean): String;
begin
  if TIB_DDL_Extract( FCPtr ).TerminatorToken = ';' then
    Result := 'SET TERM ^;'
  else
  if force then
    Result := 'SET TERM ' + TIB_DDL_Extract( FCPtr ).TerminatorToken + ';'
  else
    Result := EmptyStr;
end;

function TIB_DDL_FormatterText.ResetIBTerminator(force: Boolean): String;
begin
  if TIB_DDL_Extract( FCPtr ).TerminatorToken = ';' then
    Result := 'SET TERM ;^'
  else
  if force then
    Result := 'SET TERM ;' + TIB_DDL_Extract( FCPtr ).TerminatorToken
  else
    Result := EmptyStr;
end;

function TIB_DDL_FormatterText.Color(const s: String; col: TColor): String;
begin
  Result := s
end;

function TIB_DDL_FormatterText.Normal(const s: String): String;
begin
  Result := s
end;

function TIB_DDL_FormatterText.Enclose(const s: String; c: char): String;
var
  Iter: Integer;
begin
  Result := c + s + c;
  iter := 2;
  while iter < Length(Result) do
  begin
    if Result[iter] = c then
    begin
      Insert(c, Result, iter);
      Inc(iter)
    end;
    Inc(iter);
  end;
end;

function TIB_DDL_FormatterText.IBLiteral(const s: String): String;
begin
  Result := Enclose( s, #39 )
end;

function TIB_DDL_FormatterText.IBIdentifier(const s: String): String;
begin
  with TIB_DDL_Extract( FCPtr ) do
    if SkipDoubleQuotes then
      Result := s
    else
    if Assigned( IB_Connection ) then
      Result := IB_Connection.mkIdent( s ) //Enclose( s, #34 );
    else
      result := s;
end;

function TIB_DDL_FormatterText.DebugOutput(const s: String): String;
begin
  if TIB_DDL_Extract( FCPtr ).ActivateDebug then
    Result := IBComment(s)
  else
    Result := EmptyStr;
end;

function TIB_DDL_FormatterText.DebugOutputRaw(const s: String): String;
begin
  if TIB_DDL_Extract( FCPtr ).ActivateDebug then
    Result := IBCommentRaw(s)
  else
    Result := EmptyStr;
end;

function TIB_DDL_FormatterText.Indent: String;
begin
  Result := Normal( StringOfChar( #32,
                      TIB_DDL_Extract( FCPtr ).IndentationDepth ))
end;

function TIB_DDL_FormatterText.WritePreamble(const title: String): String;
begin
  Result := '/*--- ' + title + ' ---*/'
end;

function TIB_DDL_FormatterText.WriteEpilog: String;
begin
  // Nothing to do at this level
end;

function TIB_DDL_FormatterText.MFormat( const S: String;
                                    const Values: array of String ): String;
var
  SLen, VLen, SPos, VPos: Integer;
  auxlevel: Integer;
  auxcolor: TColor;
begin
  Result := EmptyStr;
  SLen := Length(S);
  SPos := 1;
  VPos := Low(Values);
  VLen := High(Values);
  while SPos <= SLen do
  begin
    if VPos > VLen then break;
    case S[SPos] of
      'H':
        begin
          auxlevel := 1;
          if (SPos < SLen) and (S[Spos + 1] in ['1'..'3']) then
          begin
            Inc(SPos);
            auxlevel := StrToInt(S[SPos])
          end;
          Result := Result + Header(Values[VPos], auxlevel)
        end;
      'B': Result := Result + Bold(Values[VPos]);
      'I': Result := Result + Italics(Values[VPos]);
      '*': Result := Result + IBComment(Values[VPos]);
      'N': Result := Result + Normal(Values[VPos]);
      'S': Result := Result + IBLiteral(Values[VPos]);
      'D': Result := Result + IBIdentifier(Values[VPos]);
      'R': Result := Result + Values[VPos]; // Warning, raw mode.
      '#': Result := Result + DebugOutput(Values[VPos]);
      '!': Result := Result + DebugOutputRaw(Values[VPos]);
      '@': Result := Result + IntToHex(Integer(Addr(Values[VPos])), 4);
      'C':
      begin
        auxcolor := clBlack;
        if (SPos < SLen) and (pos(S[Spos + 1], 'kmgonptesrlybfaw') > 0) then
        begin
          Inc( SPos );
          case S[SPos] of
            'k': auxcolor := clBlack;
            'm': auxcolor := clMaroon;
            'g': auxcolor := clGreen;
            'o': auxcolor := clOlive;
            'n': auxcolor := clNavy;
            'p': auxcolor := clPurple;
            't': auxcolor := clTeal;
            'e': auxcolor := clGray;
            's': auxcolor := clSilver;
            'r': auxcolor := clRed;
            'l': auxcolor := clLime;
            'y': auxcolor := clYellow;
            'b': auxcolor := clBlue;
            'f': auxcolor := clFuchsia;
            'a': auxcolor := clAqua;
            'w': auxcolor := clWhite
          end
        end;
        Result := Result + Color( Values[VPos], auxcolor );
      end // 'C'
      else
      begin
        case S[SPos] of
          ';': Result := Result + Normal(TIB_DDL_Extract( FCPtr ).TerminatorToken);
          '>': Result := Result + Indent;
          else Result := Result + Normal(S[SPos])
        end;
        Dec(VPos) // Compensate for the general Inc below
      end
    end; // if VPos <= VLen / case
    Inc(SPos);
    Inc(VPos)
  end; // for
  if SPos <= SLen then
  begin
    if pos(';', Copy(S, SPos, SLen)) > 0 then
      While SPos <= SLen do
      begin
        if S[SPos] = ';' then
          Result := Result + Normal( TIB_DDL_Extract( FCPtr ).TerminatorToken )
        else
          Result := Result + Normal( S[SPos] );
        Inc(SPos)
      end
    else Result := Result + Normal( Copy( S, SPos, SLen ))
  end;
  while VPos <= VLen do
  begin
    Result := Result + Normal(Values[VPos]);
    Inc(VPos)
  end
end;

function TIB_DDL_FormatterText.NormalizeToLF(const S: String): String;
var
  xpos: Integer;
begin
  Result := S;
  xpos := 1;
  While xpos < Length(Result) - 1 do
  begin
    if Result[xpos] = #13
    then if Result[xpos + 1] = #10
      then Result[xpos] := #$20
      else Result[xpos] := #10;
    Inc(xpos)
  end
end;

function TIB_DDL_FormatterText.NormalizeToCRLF(const S: String): String;
var
  xpos: Integer;
begin
  Result := S;
  xpos := 1;
  while xpos < Length(Result) do
  begin
    if Result[xpos] = #10 then
    begin
      Insert(#13, Result, xpos);
      Inc(xpos, 2)
    end
    else Inc(xpos)
  end
end;

function TIB_DDL_FormatterText.NormalizeToCurrentLineBreak(const S: String): String;
var
  xpos: Integer;
begin
  Result := S;
  xpos := 1;
  while xpos < Length(Result) do
  begin
    if Result[xpos] in [#10, #13] then
    begin
      case FLineBreakLength of
        1:
        if (xpos < Length(Result)) and
            (Result[xpos + 1] = Rev(Result[xpos])) then
        begin
          Result[xpos] := #32;
          Result[xpos + 1] := FLineBreakStr[1];
          Inc(xpos, 2)
        end
        else
        begin
          Result[xpos] := FLineBreakStr[1];
          Inc(xpos)
        end;
        2:
        if (xpos < Length(Result)) and
           (Result[xpos + 1] = Rev(Result[xpos])) then
        begin
          Result[xpos] := FLineBreakStr[1];
          Result[xpos + 1] := FLineBreakStr[2];
          Inc(xpos, 2);
        end
        else
        begin
          Result[xpos] := FLineBreakStr[1];
          Insert(FLineBreakStr[2], Result, xpos + 1);
          Inc(xpos, 2);
        end;
      end
    end
    else Inc(xpos)
  end
end;

procedure TIB_DDL_FormatterText.DisableEncoding;
begin
  FEncodingDisabled := True
end;

procedure TIB_DDL_FormatterText.EnableEncoding;
begin
  FEncodingDisabled := False
end;

// ----------------------------------------------------------
// TIB_DDL_FormatterHTML

constructor TIB_DDL_FormatterHTML.Create( AController: TObject;
                                      ASQLDialect: integer );
begin
  inherited Create( AController, ASQLDialect );
  FConvertCRLF := True;
  FCharset := 'iso-8859-1'
end;

function TIB_DDL_FormatterHTML.HTTPEncode(const s: String): String;
var
  xin, xout: Integer;
  aux: String;
  c: Char;
  skip: Boolean;
  procedure Add(c: char);
  begin
    Result[xout] := c; Inc(xout)
  end;
begin
  if Length(s) = 0
  then begin
    Result := EmptyStr;
    Exit
  end;
  if FConvertCRLF
  then SetLength(Result, Length(s) * 7)
  else SetLength(Result, Length(s) * 3);
  xout := 0;
  skip := false;
  for xin := 1 to Length(s) do
  begin
    if skip then
    begin
      skip := false;
      continue
    end;
    Inc(xout);
    c := s[xin];
    case c of
      #32: Result[xout] := '+';
      'A'..'Z', 'a'..'z',
      '0'..'9',
      '_', '-',
      '*', '@', '.',
      '(', ')', '$', '!',
      #39: Result[xout] := c;
      else
      begin
        if (c in [#10, #13]) and ConvertCRLF then
        begin
          Add('<');
          Add('b');
          Add('r');
          Add('>');
          Result[xout] := c;
          if (c = #13) and (xin < Length(s)) and (s[xin + 1] = #10) then
          begin
            skip := true;
            Inc(xout);
            Result[xout] := #10;
          end;
        end
        else
        begin
          aux := IntToHex(Ord(c), 2);
          if Length(aux) > 2 then
            SetLength(aux, 2);
          Add('%');
          Add(aux[1]);
          Result[xout] := aux[2];
        end;
      end;
    end;
  end; // for
  SetLength(Result, xout)
end;

function TIB_DDL_FormatterHTML.HTMLEncode(const s: String): String;
var
  xin, xout: Integer;
  c: Char;
  skip: Boolean;
  procedure Add(c: char);
  begin
    Result[xout] := c; Inc(xout)
  end;
  procedure AddControl(s: string);
  var
    ctiter: Integer;
  begin
    Add('&');
    for ctiter := 1 to Length(s) do
      Add(s[ctiter]);
    Result[xout] := ';'
  end;
begin
  if FEncodingDisabled or (Length(s) = 0) then
  begin
    Result := S;
    Exit
  end;
  SetLength(Result, Length(s) * 6);
  xout := 0;
  skip := false;
  for xin := 1 to Length(s) do
  begin
    if skip then
    begin
      skip := false;
      continue;
    end;
    Inc(xout);
    c := s[xin];
    case c of
      #32: AddControl('nbsp');
      '<': AddControl('lt');
      '>': AddControl('gt');
      '"': AddControl('quot');
      else
      begin
        if (c in [#10, #13]) and ConvertCRLF then
        begin
          Result[xout] := '<'; Inc(xout);
          Result[xout] := 'b'; Inc(xout);
          Result[xout] := 'r'; Inc(xout);
          Result[xout] := '>'; Inc(xout);
          Result[xout] := c;
          if (xin < Length(s)) and (s[xin + 1] = Rev(c)) then
          begin
            skip := true;
            Inc(xout);
            Result[xout] := s[xin + 1]
          end
        end
        else Result[xout] := c
      end
    end
  end; // for
  SetLength(Result, xout)
end;

function TIB_DDL_FormatterHTML.Header(const s: String; level: byte): String;
var
  b: String;
begin
  b := 'h' + IntToStr(level) + '>';
  Result := '<' + b + HTMLEncode(s) + '</' + b
end;

function TIB_DDL_FormatterHTML.Bold(const s: String): String;
begin
  Result := '<b>' + HTMLEncode(s) + '</b>'
end;

function TIB_DDL_FormatterHTML.Italics(const s: String): String;
begin
  Result := '<i>' + HTMLEncode(s) + '</i>'
end;

function TIB_DDL_FormatterHTML.IBComment(const s: String): String;
begin
  Result := HTMLEncode(inherited IBComment(s))
end;

function TIB_DDL_FormatterHTML.HTMLComment(const s: String): String;
begin
  Result := '<!-- ' + HTMLEncode(s) + ' -->'
end;

function TIB_DDL_FormatterHTML.SetIBTerminator(force: Boolean): String;
begin
  Result := inherited SetIBTerminator(force);
  if Result <> EmptyStr then
    Result := HTMLEncode(Result)
end;

function TIB_DDL_FormatterHTML.ResetIBTerminator(force: Boolean): String;
begin
  Result := inherited ResetIBTerminator(force);
  if Result <> EmptyStr then
    Result := HTMLEncode(Result)
end;

function TIB_DDL_FormatterHTML.Color(const s: String; col: TColor): String;
var
  temp: String;
begin
  temp := IntToHex(ColorToRgb(col), 6);
  if Length(temp) > 6 then
    temp := Copy(temp, Length(temp) - 5, 6);
  // We need to go from RGB to BGR
  temp := Copy(temp, 5, 2) + Copy(temp, 3, 2) + Copy(temp, 1, 2);
  Result := '<font color="#' + temp + '">' + HTMLEncode(s) + '</font>'
end;

function TIB_DDL_FormatterHTML.Normal(const s: String): String;
begin
  Result := HTMLEncode(s)
end;

function TIB_DDL_FormatterHTML.Enclose(const s: String; c: char): String;
begin
  Result := HTMLEncode(inherited Enclose(s, c))
end;

function TIB_DDL_FormatterHTML.IBLiteral(const s: String): String;
begin
  Result := Color( inherited Enclose(s, #39),
                   TIB_DDL_Extract( FCPtr ).ColorForLiteralStrings )
end;

function TIB_DDL_FormatterHTML.IBIdentifier(const s: String): String;
begin
  Result := Color( inherited IBIdentifier( s ),
                   TIB_DDL_Extract( FCPtr ).ColorForIdentifiers )
end;

{ Same as TIB_DDL_FormatterText
function TIB_DDL_FormatterHTML.DebugOutput(const s: String): String;
begin
  if TIB_DDL_Extract( FCPtr ).ActivateDebug
  then Result := IBComment(s)
  else Result := s
end;
}
function TIB_DDL_FormatterHTML.WritePreamble(const title: String): String;
begin
  Result := '<html>' + FLineBreakStr +
    '<head>' + FLineBreakStr +
    '<meta http-equiv="Content-Type" content="text/html; charset=' +
    FCharset + '">' + FLineBreakStr +
    '<meta name="GENERATOR" content="TIB_DDL_FormatterHTML">' + FLineBreakStr +
    '<title>' + HTMLEncode(title) + '</title>' + FLineBreakStr +
    '</head>' + FLineBreakStr +
    '<body>'
end;

function TIB_DDL_FormatterHTML.WriteEpilog: String;
begin
  Result := '</body>' + FLineBreakStr + '</html>'
end;

function TIB_DDL_FormatterHTML.NormalizeToCurrentLineBreak(const S: String): String;
begin
  // In the interest of performance, I thought this method should do nothing.
  // The reason is that counts on HTML is <br> and <p></p> and I handle them
  // automatically in HTMLEncode that's called from any function, unless you
  // call DisableEncoding explicitly or use the R (raw) token of MFormat.
  Result := S
end;

end.
