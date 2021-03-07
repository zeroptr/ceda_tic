
{                                                                              }
{ IB_CodeFormatter                                                             }
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
{  07-Jan-2002                                                                 }
{     Original Author.  Based on code written by Claudio Valderrama for his    }
{     IB_DDL_* units, but this variation written for the replacement           }
{     IB_Metadata unit.                                                        }
{                                                                              }
{------------------------------------------------------------------------------}

{$INCLUDE IB_Directives.inc}

{: This unit contains the TIB_CodeFormatter component and related classes.}
unit IB_CodeFormatter;

interface

uses Classes,
  Sysutils;


const                                   // dont localise
  IBCF_IntTerminatorDefault: string = ';';
  IBCF_TerminatorDefault: string = '^';
  IBCF_StartCommentDefault: string = '/* ';
  IBCF_EndCommentDefault: string = ' */';
  IBCF_LineCommentDefault: string = '// ';
  IBCF_IndentSizeDefault: integer = 2;


type

{: This enumerated type describes the different types of entries in the
TIB_CodeFormatter.  The types named ct* are for internal use only.  The
types named wt* (TIB_CodeWordType) can be used with the TIB_CodeFormatter
AddWords function to add to the list of words in the code formatter.}
  TIB_CodeFormatType = (
    wtNormal,
    wtWhite,
    wtString,
    wtNoSpacing,
    wtComment,
    wtLineComment,
    wtIdentity,
    wtNumber,
    wtReserved,
    wtDelimit,
    wtOperate,
    wtDefine,
    wtEmbedded,                         // assembler etc
    wtUrl,
    wtBold,
    wtItalic,
    wtUnderline,
    ctIncIndent,
    ctDecIndent,
    ctResetIndent,
    ctEndOfLine,
    ctInternalTerm,
    ctTerminator
    );

{: Subrange of TIB_CodeFormatType describing the type identifiers that can
be used with the TIB_CodeFormatter AddWords function.}
  TIB_CodeWordType = wtNormal..wtUnderline;

  TIB_CodeTermType = (
    ttNone,                             // no termination added after input
    ttEndLine,                          // start a new line after input
    ttTerm,                             // add terminator string after input
    ttTermLine, // add terminator and start new line after input
    ttIntTerm,                          // add internal terminator after input
    ttIntTermLine // add internal terminator and start new line after input
    );


{: A generic code formatter utility class.
<br>
Written to support the formatted output of SQL from the TIB_Metadata class.
(See that unit for examples of how this utility class is used.)<br>
<br>
At the moment this function only outputs plain text using the WriteText
or WriteLines methods.  However it was provided so that eventually the
code can be output with some syntax highlighting using HTML and possibly
other formats.  To add these capabilities simply add some new functions
(such as WriteHTML) and view the WriteLines functions as an example of what
is required.}
  TIB_CodeFormatter = class(TObject)
  private
    FEntries: TStrings;
    FIntTerminator: string;
    FTerminator: string;
    FStartComment: string;
    FEndComment: string;
    FLineComment: string;
    FIndentSize: integer;
    FIndentDepth: integer;
    FIncIndentPending: integer;
    FDecIndentPending: integer;
    FNewLine: boolean;
    FWorkStr: string;
    FWorkStrings: TStrings;
    FNextEntry: integer;

  protected
    function GetEntryCode(Idx: integer): TIB_CodeFormatType;
    function GetEntryString(Idx: integer): string;
    function GetEntryCount: integer;
    procedure AddString(AStr: string);
    procedure WriteWorkStr(AStrs: TStrings);
    procedure AddEntry(AType: TIB_CodeFormatType; AWords: string);

{: Access the list of TIB_CodeFormatType indicators currently stored in the
code formatter.  These can be used to control the formatting (syntax
highlighting) of the output text.}
    property Codes[Idx: integer]: TIB_CodeFormatType read GetEntryCode;
{: Access the list of actual strings/words currently stored in the
code formatter.  Each string is of the type indicated by the corresponding
Codes array.}
    property Words[Idx: integer]: string read GetEntryString;

  public
    constructor Create;
    destructor Destroy; override;

{: Add words/string of indicated type.  Also supply a TIB_CodeTermType to
indicate if (or what type) of terminator should follow the words/string.}
    procedure AddWords(AType: TIB_CodeWordType; AWords: string;
      ATerm: TIB_CodeTermType);
{: Increment the indent level (to control output of final text).}
    procedure IncIndent;
{: Decrement the indent level (to control output of final text).}
    procedure DecIndent;
{: Reset indent level to 0 (to control output of final text).}
    procedure ResetIndent;
{: Ensure subsequent text starts on a new line.  (No terminator string added.)}
    procedure StartNewLine;
{: Add a terminator to the current line and ensure subsequent text starts
on a new line.}
    procedure TerminateLine;
{: Clear all codes/words stored in the formatter.}
    procedure Clear;

{: Write all words to plain text (the only formatting is done with newlines
and indentation).}
    procedure WriteText(AStrs: TStrings);
{: Write ACount lines (starting from the position of the last call to
WriteLines - or as controlled via the NextEntry property) in plain text.
(The only formatting is done with newlines and indentation.}
    function WriteLines(ACount: integer; AStrs: TStrings): boolean;

{: The number of words/codes in the code formatter.}
    property EntryCount: integer read GetEntryCount;
{: The entry number from which WriteLines will begin writing.}
    property NextEntry: integer read FNextEntry write FNextEntry;
{: The currently specified indentation level.}
    property IndentDepth: integer read FIndentDepth;
{: Indicates whether the next entry added will start on a new line.}
    property NewLine: boolean read FNewLine;

{: Internal Terminator string.  SQL supports a primary terminator (used to
terminate entire statements) and an internal terminator - used to terminate
lines inside stored procedures and triggers etc.}
    property IntTerminator: string read FIntTerminator write FIntTerminator;
{: The statement terminator (See also IntTerminator).}
    property Terminator: string read FTerminator write FTerminator;
{: How many space characters are used as indentation.}
    property IndentSize: integer read FIndentSize write FIndentSize;
{: The string used to start a (possibly) multi-line comment.}
    property StartComment: string read FStartComment write FStartComment;
{: The string used to end a (possibly) multi-line comment.}
    property EndComment: string read FEndComment write FEndComment;
{: The string used to indicate that the rest of the current line is a comment.}
    property LineComment: string read FLineComment write FLineComment;

  end;


implementation


constructor TIB_CodeFormatter.Create;
begin
  inherited Create;
  FEntries := TStringList.Create;
  FIntTerminator := IBCF_IntTerminatorDefault;
  FTerminator := IBCF_TerminatorDefault;
  FStartComment := IBCF_StartCommentDefault;
  FEndComment := IBCF_EndCommentDefault;
  FLineComment := IBCF_LineCommentDefault;
  FIndentSize := IBCF_IndentSizeDefault;
  FIndentDepth := 0;
  FIncIndentPending := 0;
  FDecIndentPending := 0;
  FNewLine := true;
  FWorkStr := '';
  FWorkStrings := TStringList.Create;
  FNextEntry := 0;
end;

destructor TIB_CodeFormatter.Destroy;
begin
  FEntries.Free;
  FEntries := nil;
  FWorkStrings.Free;
  FWorkStrings := nil;
  inherited Destroy;
end;

function TIB_CodeFormatter.GetEntryCode(Idx: integer): TIB_CodeFormatType;
begin
  Result := TIB_CodeFormatType(FEntries.Objects[Idx])
end;

function TIB_CodeFormatter.GetEntryString(Idx: integer): string;
begin
  Result := FEntries.Strings[Idx];
end;

function TIB_CodeFormatter.GetEntryCount: integer;
begin
  Result := FEntries.Count;
end;

procedure TIB_CodeFormatter.AddString(AStr: string);
begin
  if Length(Trim(FWorkStr)) > 0 then
    FWorkStr := FWorkStr + ' ' + AStr
  else
    FWorkStr := FWorkStr + AStr;
end;

procedure TIB_CodeFormatter.WriteWorkStr(AStrs: TStrings);
var
  j: integer;
begin
  if Pos(#10, FWorkStr) > 0 then
  begin
    FWorkStrings.Clear;
    FWorkStrings.Text := FWorkStr;
    // Delete leading blank lines
    while (FWorkStrings.Count > 0) and
      (Trim(FWorkStrings.Strings[0]) = EmptyStr) do
      FWorkStrings.Delete(0);
    // Delete trailing blank lines
    while (FWorkStrings.Count > 0) and
      (Trim(FWorkStrings.Strings[FWorkStrings.Count - 1]) = EmptyStr) do
      FWorkStrings.Delete(FWorkStrings.Count - 1);
    if FWorkStrings.Count > 0 then
    begin
      if IndentDepth = 0 then
        AStrs.AddStrings(FWorkStrings)
      else
      begin
        for j := 0 to FWorkStrings.Count - 1 do
          AStrs.Add(
            StringOfChar(' ', IndentDepth * IndentSize) +
            FWorkStrings.Strings[j]);
      end;
    end;
  end
  else
  begin
    if IndentDepth = 0 then
      AStrs.Add(FWorkStr)
    else
      AStrs.Add(StringOfChar(' ', IndentDepth * IndentSize) + FWorkStr);
  end;
  FWorkStr := '';
  FWorkStrings.Clear;
end;

procedure TIB_CodeFormatter.AddEntry(AType: TIB_CodeFormatType; AWords: string);
begin
  FEntries.AddObject(AWords, TObject(Ord(AType)));
  if AType = ctEndOfLine then
  begin
    FNewLine := true;
    while FIncIndentPending > 0 do
    begin
      FEntries.AddObject('', TObject(Ord(ctIncIndent)));
      Dec(FIncIndentPending);
    end;
    while FDecIndentPending > 0 do
    begin
      FEntries.AddObject('', TObject(Ord(ctDecIndent)));
      Dec(FDecIndentPending);
    end;
  end
  else
    FNewLine := false;
end;

procedure TIB_CodeFormatter.AddWords(AType: TIB_CodeWordType; AWords: string;
  ATerm: TIB_CodeTermType);
begin
  AddEntry(AType, AWords);
  case ATerm of
    ttNone: ;                           // do nothing
    ttEndLine: AddEntry(ctEndOfLine, '');
    ttTerm: AddEntry(ctTerminator, '');
    ttTermLine: TerminateLine;
    ttIntTerm: AddEntry(ctInternalTerm, '');
    ttIntTermLine:
      begin
        AddEntry(ctInternalTerm, '');
        AddEntry(ctEndOfLine, '');
      end;
  end;
end;

procedure TIB_CodeFormatter.IncIndent;
begin
  if NewLine then
    AddEntry(ctIncIndent, '')
  else
    Inc(FIncIndentPending);
end;

procedure TIB_CodeFormatter.DecIndent;
begin
  if NewLine then
    AddEntry(ctDecIndent, '')
  else
  begin
    if FIncIndentPending > 0 then
      Dec(FIncIndentPending)
    else
      Inc(FDecIndentPending);
  end;
end;

procedure TIB_CodeFormatter.ResetIndent;
begin
  AddEntry(ctResetIndent, '');
end;

procedure TIB_CodeFormatter.StartNewLine;
begin
  AddEntry(ctEndOfLine, '');
end;

procedure TIB_CodeFormatter.TerminateLine;
begin
  if (EntryCount > 0) and (Codes[EntryCount - 1] = ctEndOfLine) then
    FEntries.Delete(EntryCount - 1);
  AddEntry(ctTerminator, '');
  AddEntry(ctEndOfLine, '');
end;

procedure TIB_CodeFormatter.Clear;
begin
  FEntries.Clear;
  FNextEntry := 0;
end;

procedure TIB_CodeFormatter.WriteText(AStrs: TStrings);
begin
  AStrs.BeginUpdate;
  try
    FIndentDepth := 0;
    FNextEntry := 0;
    WriteLines(FEntries.Count, AStrs);
  finally
    FNextEntry := 0;
    AStrs.EndUpdate;
  end;
end;

function TIB_CodeFormatter.WriteLines(ACount: integer; AStrs: TStrings):
  boolean;
var
  i: integer;
  cType: TIB_CodeFormatType;
begin
  Result := true;
  AStrs.BeginUpdate;
  try
    FWorkStr := '';
    i := FNextEntry;
    while ACount > 0 do
    begin
      if i >= FEntries.Count then
      begin
        Result := false;
        break;
      end;
      cType := Codes[i];
      case cType of
        wtNormal: AddString(Words[i]);
        wtWhite: AddString(Words[i]);
        wtString: AddString(QuotedStr(Words[i]));
        wtNoSpacing: FWorkStr := FWorkStr + Words[i]; // no spacing
        wtComment: AddString(StartComment + Words[i] + EndComment);
        wtLineComment:
          begin
            AddString(LineComment + Words[i]);
            WriteWorkStr(AStrs);        // implicit new line after a line comment
          end;
        wtIdentity: AddString(Words[i]);
        wtNumber: AddString(Words[i]);
        wtReserved: AddString(Words[i]);
        wtDelimit: FWorkStr := FWorkStr + Words[i]; // no spacing
        wtOperate: AddString(Words[i]);
        wtDefine: AddString(Words[i]);
        wtEmbedded: AddString(Words[i]);
        wtUrl: AddString(Words[i]);
        wtBold: AddString(Words[i]);
        wtItalic: AddString(Words[i]);
        wtUnderline: AddString(Words[i]);
        ctIncIndent: Inc(FIndentDepth);
        ctDecIndent: Dec(FIndentDepth);
        ctResetIndent: FIndentDepth := 0;
        ctEndOfLine:
          begin
            WriteWorkStr(AStrs);
            Dec(ACount);
          end;
        ctInternalTerm: FWorkStr := FWorkStr + IntTerminator; // no spacing
        ctTerminator: FWorkStr := FWorkStr + Terminator; // no spacing
      end;
      Inc(i);
    end;
    if Length(FWorkStr) > 0 then
      WriteWorkStr(AStrs); // just in case entry not terminated with a newline
    FNextEntry := i;
  finally
    AStrs.EndUpdate;
  end;
end;


end.

