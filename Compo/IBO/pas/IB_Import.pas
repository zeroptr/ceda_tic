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
{  Jason Wharton                                                               }
{  06 Jun 2002                                                                 }
{     Made some changes to support Delphi 3                                    }
{                                                                              }
{  Harald Klomann <h.klomann@t-online.de>                                      }
{  08/26/2000                                                                  }
{     added line no to eWrongAsciiFieldCount to easy get error position        }
{                                                                              }
{  Harald Klomann <h.klomann@t-online.de>                                      }
{  08/30/2000                                                                  }
{     Rewritten to support Delphi 2/3/4                                        }
{     fixed a bug in GetFixedRecord                                            }
{                                                                              }
{  Harald Klomann <h.klomann@t-online.de>                                      }
{  02/27/2002                                                                  }
{     added SkipEmptyLines property to deal with empty lines                   }
{                                                                              }
{  Harald Klomann <h.klomann@t-online.de>                                      }
{  05/08/2002                                                                  }
{     removed property ShowDlg and DlgCaption                                  }
{     removed dealing with IBD_Import.pas and IBD_Import.frm dialog window     }
{     added type TImportNotifyEvent so that usere receive data to feed         }
{     their own dialog window with                                             }
{     added CancelImport method                                                }
{                                                                              }
{  Harald Klomann <h.klomann@t-online.de>                                      }
{  09/23/2002                                                                  }
{     fixed a glitch, where a char between fieldseparator and StringSeparator  }
{     was imported. This should normaly only be a white space                  }
{                                                                              }
{  Harald Klomann <h.klomann@t-online.de>                                      }
{                                                                              }
{  11/21/2002                                                                  }
{     added code to support SkipEmptyLines in fixed widht format               }
{                                                                              }
{  12/04/2002                                                                  }
{     removed code that caused problems with StringSeparators                  }
{                                                                              }
{  Magni Viggosson <magni@hugbun.is>                                           }
{  21/03/2003                                                                  }
{     Fixed a problem with importing NULL fields                               }
{     if the field is a blank string ('') then it is assumed to be NULL        }
{

Description :
-------------
Unit to import an ascii file into an interbase table
Author: Harald Klomann

Please forward any comments or suggestions to Harald Klomann at:
email: h.klomann@t-online.de (privat) or klomann@nibler.net

This Software is donated to support Jason Whartons IB-Objects Project



1) Propertys
------------

AsciiFile:
Full path and name of the Ascii file to import

Comments:           A char to indicate commented lines, eg ; A commented
line is ignored

CommitTransaction:
This only effects, if your TIB_Transaction is not AutoCommit
and not ServerAutoCommit. If true, then the transaction is
commited after all records are inserted. (the fasted way)
If set to false, then you have to care about a commit.

DateFormat:         If set to dfWindows, your date format in Ascii file must be
equal to the Windows settings. Other settings may be :
DMY, MDY, YMD

DateSeperat:        Character used to separate the date sections

DecimalSeparat:     Character used to separate the decimal number sections

DestTable:          Interbase table, where to import the data

EndOfRec:           Char to indicate the end of a record (normaly #10)

FieldDelimiter:     Char to indicate the end of a field

FieldList:          Type here the column names of the table, where you want to
be the data inserted. Each column a line. If you dont want
to import all of the existing columns found in the Ascii file,
you type in the <SkipFieldMarker> for the column to skip.

In <FixedWidth> format, syntax is: colname;fieldwidth;decimals
e.g
mycol;10        for a char(10) column
mycol;5;2       for a float or decimal(5,2)

Important for delimited format files :
---------------------------------------
If your Ascii file and your table are of the same structure
(same count and order of columns), you don´t need to make any
entrys here. IB_Import will automatic setup the FieldList
for you !! If you use fixed width format files, you have
to setup the FieldList properly

FieldsFirst:        If set to true, the description of the columns is assumed
to be in the first uncommented line of the Ascii file.
The <FieldList> is then setup automatic from this description.

FixedWidth:         If set to true, Ascii file is assumed to be in fixed width
format. There are no comments allowed, no delimiters and no
string separators. <FieldsFirst> is not allowed here. How to
setup the FieldList see <FieldList>

IB_Connection:      The TIB_connection

IB_Transaction:     The TIB_Transaction. See also <CommitTransaction>

ImportMode:         Set to mAppend will append data. Set to mCopy will
first delete all data in <DestTable> and then insert
the data from <AsciiFile>

IniFile:            The full path and name of a .ini file. All propertys
      (except IB_connection,IB_Transaction,Inifile,Name Tag)
can be setup from a .ini file. So you can have different
setups with only one TIB_Import component used. Just switch
the name of the ini file. All settings found in the ini file
are used, all settings not found are used from the component
settings. Initial component settings are saved and only
temporarily overwritten !

LastFieldDelimited: Set it to true, if your last column in the Ascii file is
followed by a <FieldDelimiter>. Some rdbms, e.g. INFORMIX
do so when exporting data to Ascii.

Name:               The components name

NotifyCount:        This is used to trigger the event <OnNotifyCount> and also
the call to Application.ProcessMessages if <ProcessMessages>
is set to true; A NotifyCount of <=0 will avoid triggering.
This is counted by the records readed (uncommented and commented).

ProcessMessages:    If set to true, a call to Application.ProcessMessages is done
every <NotifyCount>. (See also above)

SkipFieldMarker:    see <FieldList>

StringSeparat:      Character to Separat strings. If the string itself contains
<StringSeparat>, then it must be quoted.

Tag:                Standard

TimeSeparat:        Character used to separate the time sections


2) Events
------------

OnNotifyCount:      See <NotifyCount>

OnParse:            After an Ascii record is parsed, you may modify the parsed
column data in Ascii format. Data is stored as TStrings.
Note : you only get uncommented records here !!

OnPrePost:          Before inserting data, you may make modifications here.
      Data are stored in a TIB_Row. Setting OkToPost will avoid,
to insert the current row.

3) Variables

busy:             TIB_Import component is busy

UserAbort:        If set to true , data
processing will be aborted. If TIB_Transaction is not
AutoCommit nor ServerAutoCommit, IB_Import will not commit
the Transaction even  if <CommitTransaction> is set to true.


4) Ini file
-----------
      Here´s a sample .ini file.

Known Sections : [Setup] and [FieldList]
Note the section [FieldList]
----------------------------------------------------------
      Because of the IniFile Syntax, columns must be declared
in format identifier=columname. Identifier is never used
by TIB_Import and so can be any name or number, but must be
unique within the identifiers
----------------------------------------------------------

;Sample Ini file

[Setup]
AsciiFile=c:\temp\mytable.txt
Comments=;
CommitTransaction=1
DateFormat=dfMDY
DateSeperat=/
DecimalSeparat=.
DestTable=mytable
EndOfRec=#10
FieldDelimiter=,
FieldsFirst=0
FixedWidth=0
LastFieldDelimited=0
SkipEmptyLines=1
NotifyCount=100
ProcessMessages=1
SkipFieldMarker=SKIP
StringSeparat="
TimeSeparat=.

[FieldList]
f1=SKIP
f2=col1
f3=col2
f4=coln
f5=SKIP

;; for fixedWidth formats
[FieldList]
f1=SKIP;5
f2=col1;15;2
f3=col2;4
f4=coln;30
f5=SKIP;7;2

}

{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_Import;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Inifiles,

  IB_Constants,
  IB_Components,
  IB_Header;

type

// Internal structure for field infos - to be bound on FFieldList.Objects
TImportFields = Class(TObject)
FieldName     :string;
FieldWidth    :integer;
FieldDecimals :byte;
Skip          :boolean;
end;


// Exception Class
EIB_Import = class(Exception);

// Date structures
TDateFormat = (dfWindows, dfMDY, dfDMY, dfYMD);

// Import Modes
TImportMode = (mAppend,mCopy);

// Event after a row has been parsed
TParseEvent = procedure(     Sender: TObject;
                         var AsciiFields: TStrings;
                             NumberOfFields: integer ) of object;

// Event before we insert the data
TPrePostEvent = procedure( Sender: TObject; var ARow: TIB_Row;
                                            var OkToPost: boolean ) of object;



TImportNotifyEvent = procedure( Sender: TObject;RecsRead,RecsCommented,RecsInserted:longint;
                                            var UserAbort: boolean ) of object;

TIB_Import = class( TComponent )
private
  { Private-Deklarationen }

  // IBO Stuff
  FIB_Connection :TIB_Connection;
  FIB_Transaction :TIB_Transaction;

  // Settings belong to ASCII converting
  FIniFile : string;
  FAsciiFile :string;
  FComments :char;
  FFieldsFirst :boolean;
  FFixedWidth  :boolean;
  FFieldDelimiter :char;
  FLastFieldDelimited :boolean;
  FEndOfRecord :char;
  FDateFormat :TDateFormat;
  FDateSeparat :char;
  FTimeSeparat :char;
  FDecimalSeparat :char;
  FStringSeparat :char;
  FSkipFieldMarker :string;
  FSkipEmptyLines:boolean;
  FCommitTransaction:boolean;
  FProcessMessages:boolean;
  FDestTable :String;
  FFieldList :TStrings;
  FNotifyCount: LongInt;
  FImportMode: TImportMode;

  // Variables to save Data
  OldAsciiFile :string;
  OldComments :char;
  OldFieldsFirst :boolean;
  OldFixedWidth :boolean;
  OldFieldDelimiter :char;
  OldLastFieldDelimited :boolean;
  OldEndOfRecord :char;
  OldDateFormat :TDateFormat;
  OldDateSeparat :char;
  OldTimeSeparat :char;
  OldDecimalSeparat :char;
  OldStringSeparat :char;
  OldSkipFieldMarker :string;
  OldSkipEmptyLines :boolean;
  OldDestTable :string;
  OldFieldList :TStrings;
  OldNotifyCount: LongInt;
  OldCommitTransaction:boolean;
  OldProcessMessages:boolean;
  OldImportMode :TImportMode;

  // Events
  FOnParse: TParseEvent;
  FOnPrePost: TPrePostEvent;
  FOnNotifyCount: TImportNotifyEvent;

  // Private Routines
  procedure SetFieldList(value: TStrings);
  procedure SetAsciiFile(const Value: String);
  procedure SetDestTable(const Value: String);
  procedure SetIniFile(const Value: string);
  procedure SetSkipFieldMarker(const Value: string);
  procedure SetSkipEmptyLines(const Value: boolean);

protected
  { Protected-Deklarationen }
  procedure Notification( AComponent: TComponent;
                          Operation: TOperation); override;
public
  { Public-Deklarationen }

  busy,
  UserAbort :boolean;

  RecsUnCommented,
  RecsCommented,
  RecsInserted :longint;

  constructor Create(Aowner: Tcomponent); override;
  destructor Destroy; override;
  procedure CancelImport;
  procedure Execute;

published
  { Published-Deklarationen }

  // IBO Stuff
  property IB_Connection :TIB_Connection read FIB_Connection write FIB_Connection;
  property IB_Transaction :TIB_Transaction read FIB_Transaction write FIB_Transaction;

  // Settings belong to ASCII converting
  property IniFile :string read FIniFile write SetIniFile;
  property AsciiFile :string read FAsciiFile write SetAsciiFile;
  property Comments :char read FComments write FComments default ';';
  property FieldsFirst :boolean read FFieldsFirst write FFieldsFirst default false;
  property FixedWidth :boolean read FFixedWidth write FFixedWidth default false;
  property FieldDelimiter :char read FFieldDelimiter write FFieldDelimiter default ',';
  property LastFieldDelimited :boolean read FLastFieldDelimited write FLastFieldDelimited default false;
  property EndOfRecord :char read FEndOfRecord write FEndOfRecord default #10;
  property DateFormat :TDateFormat read FDateFormat write FDateFormat default dfWindows;
  property DateSeparat :char read FDateSeparat write FDateSeparat default '/';
  property TimeSeparat :char read FTimeSeparat write FTimeSeparat default ':';
  property DecimalSeparat :char read FDecimalSeparat write FDecimalSeparat default ',';
  property StringSeparat :char read FStringSeparat write FStringSeparat default '"';
  property SkipFieldMarker :string read FSkipFieldMarker write SetSkipFieldMarker;
  property SkipEmptyLines :boolean read FSkipEmptyLines write SetSkipEmptyLines default true;
  property CommitTransaction :boolean read FCommitTransaction write FCommitTransaction default true;
  property ProcessMessages :boolean read FProcessMessages write FProcessMessages default false;
  property ImportMode :TImportMode read FImportMode write FImportMode;

  // Destination Table
  property DestTable :String read FDestTable write SetDestTable;
  property FieldList :TStrings read FFieldList write SetFieldList;

  // Notifier
  property NotifyCount: LongInt read FNotifyCount write FNotifyCount default 100;

  // Events
  property OnParse: TParseEvent read FOnParse write FOnParse;
  property OnPrePost: TPrePostEvent read FOnPrePost write FOnPrePost;
  property OnNotifyCount: TImportNotifyEvent read FOnNotifyCount write FOnNotifyCount;

end;

implementation

//------------------------------------------------------------------------------
// TIB_Import.SetFIniFile
//------------------------------------------------------------------------------
procedure TIB_Import.SetIniFile( const Value: string );
begin
  FIniFile := Trim(Value)
end;

//------------------------------------------------------------------------------
// TIB_Import.SetFAsciiFile
//------------------------------------------------------------------------------
procedure TIB_Import.SetAsciiFile( const Value: String );
begin
  FAsciiFile := Trim( Value );
end;

//------------------------------------------------------------------------------
// TIB_Import.SetSkipFieldMarker
//------------------------------------------------------------------------------
procedure TIB_Import.SetSkipFieldMarker(const Value: string);
begin
  FSkipFieldMarker := Trim(UpperCase(Value));
end;

//------------------------------------------------------------------------------
// TIB_Import.SetSkipEmptyLines
//------------------------------------------------------------------------------
procedure TIB_Import.SetSkipEmptyLines(const Value: boolean);
begin
  FSkipEmptyLines:= Value;
end;

//------------------------------------------------------------------------------
// TIB_Import.SetFFieldList
//------------------------------------------------------------------------------
procedure TIB_Import.SetFieldList(value: TStrings);
begin
FFieldList.Assign(Value);
end;

//------------------------------------------------------------------------------
// TIB_Import.SetFDestTable
//------------------------------------------------------------------------------
procedure TIB_Import.SetDestTable(const Value: String);
begin
FDestTable := Trim(Value);
end;


//------------------------------------------------------------------------------
// TIB_Import.Notification
//------------------------------------------------------------------------------
procedure TIB_Import.Notification(AComponent: TComponent; Operation: TOperation);
begin
inherited Notification(AComponent,Operation);
if Operation = opRemove then begin
if AComponent = FIB_Connection then FIB_Connection := nil;
if AComponent = FIB_Transaction then FIB_Transaction := nil;
end;
end;


//------------------------------------------------------------------------------
// TIB_Import.Create
//------------------------------------------------------------------------------
constructor TIB_Import.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  busy := false;

  // Create things we need
  FFieldList := TStringList.create;

  // Set our Defaults
  FIB_Connection := nil;
  FIB_Transaction := nil;

  FIniFile := '';
  FAsciiFile := '';
  FComments := ';';
  FFieldsFirst := false;
  FFixedWidth := false;
  FFieldDelimiter := ',';
  FLastFieldDelimited := false;
  FEndOfRecord := #10;
  FDateFormat := dfWindows;
  FDateSeparat := '/';
  FTimeSeparat := ':';
  FDecimalSeparat := ',';
  FStringSeparat := '"';
  FSkipFieldMarker := 'SKIP';
  FSkipEmptyLines := true;
  FCommitTransaction := true;
  FProcessMessages := false;
  FImportMode := mAppend;

  FDestTable := '';
  FFieldList.Clear;

  FNotifyCount := 100;

end; {of create}

destructor TIB_Import.Destroy;
begin
  FFieldList.Free;
  inherited Destroy;
end;

procedure TIB_Import.CancelImport;
begin
  UserAbort := true;
end;


procedure TIB_Import.Execute;

var
  InputFile         : file;
  ParamFile         : TIniFile;
  DSql		    : TIB_DSQL;

  AsciiFields       : TStrings;
  NumberOfDefFields : integer;
  SkipFieldCount    : byte;

  // Ascii-File Converting
  Buf        :PChar;
  BufSize,
  FileIdx,
  BufIdx,
  FieldIdx,
  LineNo,
  NumberOfFields :integer;
  EndOfFile,
  InComment :boolean;

  // Sys-Settings
  SysDecimalSeparator,
  SysDateSeparator,
  SysTimeSeparator :char;
  SysShortDateFormat:string;

  // for user pre-post event
  ARow :TIB_Row;
  OkToPost: boolean;


procedure StartUp;
begin

  // we are in progress
  busy := true;

  // Save original Settings
  // if we have a .ini file, we overwrite Component settings
  OldAsciiFile := FAsciiFile;
  OldComments := FComments;
  OldFieldsFirst := FFieldsFirst;
  OldFixedWidth := FFixedWidth;
  OldFieldDelimiter := FFieldDelimiter;
  OldLastFieldDelimited := FLastFieldDelimited;
  OldEndOfRecord := FEndOfRecord;
  OldDateFormat := FDateFormat;
  OldDateSeparat := FDateSeparat;
  OldTimeSeparat := FTimeSeparat;
  OldDecimalSeparat := FDecimalSeparat;
  OldStringSeparat := FStringSeparat;
  OldSkipFieldMarker := FSkipFieldMarker;
  OldSkipEmptyLines := FSkipEmptyLines;
  OldDestTable := FDestTable;
  OldFieldList := TStringList.create;
  OldFieldList.Assign(FFieldList);
  OldNotifyCount := FNotifyCount;
  OldCommitTransaction := FCommitTransaction;
  OldProcessMessages := FProcessMessages;
  OldImportMode := FImportMode;

  // .ini File
  ParamFile := nil;

  // Dsql Setup
  DSql := TIB_DSQL.Create(Self);
  DSql.IB_Connection  := FIB_Connection;
  DSql.IB_Transaction := FIB_Transaction;

  // Ascii-Fields
  AsciiFields := TStringList.Create;

  // NumberOfFields found in Ascii-file
  NumberOfFields := 0;
  FileIdx := 0;
  BufIdx := 0;
  RecsUnCommented := 0;
  RecsInserted := 0;
  RecsCommented := 0;
  LineNo := 0;
  EndOfFile := false;

  // Number Of Fields defined in FieldList
  NumberOfDefFields := 0;
  // Count of Fields to skip
  SkipFieldCount := 0;

  // Save Sys-Settings
  SysDecimalSeparator := DecimalSeparator;
  SysDateSeparator    := DateSeparator;
  SysTimeSeparator    := TimeSeparator;
  SysShortDateFormat  := ShortDateFormat;

  // for user pre-post event
  ARow := DSql.Params;
  OkToPost := true;

  // User Abort
  UserAbort := false;

end; {StartUp}

procedure CleanUp;
var
  i,
  IO_Result :integer;
      
begin

  // Free bound Objects
  for i := 0 to FFieldList.Count -1 do
    FFieldList.Objects[i].Free;

  // restore original Component settings
  FAsciiFile := OldAsciiFile;
  FComments := OldComments;
  FFieldsFirst := OldFieldsFirst;
  FFixedWidth  := OldFixedWidth;
  FFieldDelimiter := OldFieldDelimiter;
  FLastFieldDelimited := OldLastFieldDelimited;
  FEndOfRecord := OldEndOfRecord;
  FDateFormat := OldDateFormat;
  FDateSeparat := OldDateSeparat;
  FTimeSeparat := OldTimeSeparat;
  FDecimalSeparat := OldDecimalSeparat;
  FStringSeparat := OldStringSeparat;
  FSkipFieldMarker := OldSkipFieldMarker;
  FSkipEmptyLines := OldSkipEmptyLines;
  FDestTable := OldDestTable;
  FFieldList.Assign(OldFieldList);
  OldFieldList.Free;
  FNotifyCount := OldNotifyCount;
  FCommitTransaction := OldCommitTransaction;
  FProcessMessages := OldProcessMessages;
  FImportMode := OldImportMode;

  // dslq
  DSql.free;

  // Ascii Fields
  AsciiFields.Free;
  Buf := nil;

  {$I-}
  Close(InPutFile);
  IO_Result := IoResult;
  if IO_Result <> 0 then ;
  {$I+}

  if Buf <> nil then
  FreeMem(Buf);

  // Restore Sys-Settings
  DecimalSeparator := SysDecimalSeparator;
  DateSeparator    := SysDateSeparator;
  TimeSeparator    := SysTimeSeparator;
  ShortDateFormat  := SysShortDateFormat;

  // work is done
  busy := false;

end; {CleanUp}

procedure SetupFromIniFile;
var
  tmpStr  :string;
  tmpInt  :integer;
  tmpList :TStrings;
  i       :integer;
begin

  tmpList := nil;

  try

  ParamFile := TIniFile.Create(FIniFile);

  with ParamFile do
  begin

  // Ascii File
  tmpStr := ReadString('SETUP','AsciiFile','');
  if tmpStr <> '' then FAsciiFile := tmpStr;

  // DestTable
  tmpStr := ReadString('SETUP','DestTable','');
  if tmpStr <> '' then FDestTable:= tmpStr;

  // SkipFieldMarker
  tmpStr := ReadString('SETUP','SkipFieldMarker','');
  if tmpStr <> '' then FSkipFieldMarker:= tmpStr;

  // SkipEmptyLines
  FSkipEmptyLines := ReadBool('SETUP','SkipEmptyLines',true);

  // DateFormat
  tmpStr := ReadString('SETUP','DateFormat','');
  if tmpStr <> '' then begin
  tmpStr := UpperCase(tmpStr);
  if tmpStr = 'DFWINDOWS' then  FDateFormat := dfWindows
  else if tmpStr = 'DFMDY' then FDateFormat := dfMDY
  else if tmpStr = 'DFDMY' then FDateFormat := dfDMY
  else if tmpStr = 'DFYMD' then FDateFormat := dfYMD;
  end;

  // Comments
  tmpStr := ReadString('SETUP','Comments','');
  if tmpStr <> '' then FComments := tmpStr[1];

  // FieldDelimiter
  tmpStr := ReadString('SETUP','FieldDelimiter','');
  if tmpStr <> '' then FFieldDelimiter := tmpStr[1];

  // StringSeparat
  tmpStr := ReadString('SETUP','StringSeparat','');
  if tmpStr <> '' then FStringSeparat:= tmpStr[1];

  // DateSeparat
  tmpStr := ReadString('SETUP','DateSeparat','');
  if tmpStr <> '' then FDateSeparat := tmpStr[1];

  // TimeSeparat
  tmpStr := ReadString('SETUP','TimeSeparat','');
  if tmpStr <> '' then FTimeSeparat := tmpStr[1];

  // DecimalSeparat
  tmpStr := ReadString('SETUP','DecimalSeparat','');
  if tmpStr <> '' then FDecimalSeparat := tmpStr[1];

  // ImportMode
  tmpStr := ReadString('SETUP','ImportMode','');
  if tmpStr <> '' then begin
  tmpStr := UpperCase(tmpStr);
  if tmpStr = 'MAPPEND' then  FImportMode := mAppend
  else if tmpStr = 'MCOPY' then FImportMode := mCopy;
  end;

  tmpInt := ReadInteger('SETUP','EndOfRecord',-1);
  if tmpInt <> -1 then FEndOfRecord := Chr(tmpInt);
  tmpInt := ReadInteger('SETUP','NotifyCount',-1);
  if tmpInt <> -1 then FNotifyCount := tmpInt;
  FFieldsFirst := ReadBool('SETUP','FieldsFirst',false);
  FLastFieldDelimited := ReadBool('SETUP','LastFieldDelimited',false);
  FFixedWidth := ReadBool('SETUP','FixedWidth',false);
  FCommitTransaction := ReadBool('SETUP','CommitTransaction',true);
  FProcessMessages := ReadBool('SETUP','ProcessMessages',false);

  // FieldList
{$IFDEF IBO_VCL40_OR_GREATER}
  if SectionExists('FIELDLIST') then
{$ENDIF}
  begin
    try
     tmpList := TStringList.Create;
     ReadSectionValues( 'FieldList', tmpList );
     FFieldList.Clear;
     for i := 0 to tmpList.Count -1 do begin
       FFieldList.Add( tmpList.Values[tmpList.Names[i]] );
     end;
    finally
    tmpList.Free;
    end;
  end;

  end; {with ParamFile}

  finally
    ParamFile.free;
  end
end; {SetupFromIniFile}


procedure CheckPropertys;
begin
  // Check existence of ASCII File
  if (FAsciiFile <> '') then begin
  if not FileExists(FAsciiFile) then raise EIB_Import.CreateFmt(EAsciiFileNotFound,[FAsciiFile]);
  end
  else raise EIB_Import.Create(ENoAsciiFileEnty);

  // Dest Table
  if FDestTable = '' then begin
  raise EIB_Import.Create(ENoDestTableEntry);
  end;

  // Hier weitere checken ????????????

end; {CheckPropertys}


// Get Data from Ascii File
function GetData:boolean;
var
  ReadCount :integer;
begin
  BufIdx := 0;
  fillchar(Buf^,BufSize,#26);
  FileIdx := FilePos(InputFile);
  BlockRead(InputFile,Buf^,BufSize,ReadCount);
  result := ReadCount < BufSize;
end;


// Parse the Ascii Data - delimited format
function GetDelimitedRecord:boolean;
var
  BeginOfRec,
  EndOfRec,
  InSeperator :boolean;
  CountRead   :integer;

begin

  result := true;

  BeginOfRec  := true;
  EndOfRec    := false;
  InComment   := false;
  InSeperator := false;
  FieldIdx    := 1;

  // Set Length for 1 FieldElement
  AsciiFields.Clear;
  AsciiFields.Append('');

  while (not EndOfRec) do begin

  // read Data, set EOF if encountered
  if (not EndOfFile) and ((BufIdx = 0) or (BufIdx >= BufSize)) then begin
  EndOfFile := GetData;
  end;

  // is Line is commented ?
  InComment := InComment or ((BeginOfRec) and ((Buf+BufIdx)^ = FComments));

  repeat

  // Test for EOF char
  if ((Buf+BufIdx)^ = #26) and (not InSeperator) then begin
  EndOfRec := true;
  if BeginOfRec then result := false;
  break;
  end;

  if BeginOfRec then BeginOfRec := false;

  if((Buf+BufIdx)^ = FEndOfRecord) and (not InSeperator) then begin
  inc(BufIdx);
  EndOfRec := true;
  break;
  end;

  // Ignore trailing #13 if EndOfRec = #10
  if (((Buf+BufIdx)^ = #13) and (not InSeperator)) and (FEndOfRecord = #10) then begin
  inc(BufIdx);
  continue;
  end;

  if InComment then begin
  // just look for EndOfRec
  inc(BufIdx);
  continue;
  end;

  // is Field separated ?
  if ((Buf+BufIdx)^ = FStringSeparat) then begin

  if not InSeperator then begin
  InSeperator := true;
  inc(BufIdx);
  continue;
  end
  else begin

  // We are at the end of a separated Field, examine following Char
  // Must be minimum 1 Chars left to check next
  if BufIdx < (BufSize-1) then begin

  if (Buf+BufIdx+1)^ = FStringSeparat then begin
  // Quoted here
  // Ignore this char, but let fall down to the poit where we
  // catch the next one
  inc(BufIdx);
  end
  else begin

  // Here we found the end of a separated field
  // Next char must be one of these
  if (Buf+BufIdx+1)^ in [FFieldDelimiter,FEndOfRecord] then begin
  InSeperator := false;
  inc(BufIdx);
  continue;
  end;

  if ((Buf+BufIdx+1)^ = #13) and (FEndOfRecord = #10) then begin
  InSeperator := false;
  inc(BufIdx);
  continue;
  end;

  // anything else is an error
  raise EIB_Import.Create(EInvalidCharFound);
  end;
  end
  else
  begin
  // we are at the end of a separated Field and at the end of Buf,
  // read some bytes, but dont increment BufIdx
  if not EndOfFile then
  begin
  // Increment BufSize for 1 Byte
  // seek Position of (Buf+BufIdx)^ in file
  // go to there and read again from here
  FreeMem(Buf);
  BufSize := BufSize + 1;
  try
  GetMem(Buf,BufSize);
  fillchar(Buf^,BufSize,#26);
  except
  raise EIB_Import.Create(EOutOfMemory);
  end;

  seek(InputFile,FileIdx);
  BlockRead(InputFile,Buf^,BufSize,CountRead);
  EndOfFile := CountRead < BufSize;
  break;

  end
  else
  begin
  // we are at the end of a separated Field and at the end of Buf,
  // and the end of the File
  EndOfRec := true;
  break;
  end;
  end;
  end;

  end; {if FStringSeparat}

  // FieldDelimiter found ?
  if ((Buf+BufIdx)^ = FFieldDelimiter) and (not InSeperator) then begin
  inc(FieldIdx);
  AsciiFields.Append('');
  inc(BufIdx);
  continue;
  end;

  // CR (#13) found ?
  if ((Buf+BufIdx)^ = #13) and (not InSeperator) then begin
  inc(BufIdx);
  continue;
  end;


//  here we found a char that should not appear here - maybe white space ?
//  !! removed - caused problems when FStringSeparat is used for strings
//  integers and others are not beeing imported
//  if (FStringSeparat <> #0) and (not InSeperator) then begin
//  inc(BufIdx);
//  continue;
//  end;

  // here we get the Fields Value
  AsciiFields[FieldIdx-1] := AsciiFields[FieldIdx-1] + (Buf+BufIdx)^;

  inc(BufIdx);

  until BufIdx > (BufSize-1);

  end; {while}

  end; {GetDelimitedRecord}


  // Parse the Ascii Data - fixed format
  function GetFixedRecord:boolean;
  var
  BeginOfRec,
  EndOfRec,
  EmptyLine :boolean;
  WidthIdx    :word;
  tmpStr      :string;

  begin

  result      := true;
  BeginOfRec  := true;
  EndOfRec    := false;
  FieldIdx    := 0;
  WidthIdx    := 0;

  // Set Length for 1 FieldElement
  AsciiFields.Clear;
  AsciiFields.Append('');

  while (not EndOfRec) do begin

  // read Data, set EOF if encountered
  if (not EndOfFile) and ((BufIdx = 0) or (BufIdx >= BufSize)) then begin
  EndOfFile := GetData;
  end;

  repeat

  // empty Line encounterd ?
  EmptyLine := BeginOfRec and
  (
  ((FEndOfRecord = #10) and ((Buf+BufIdx)^ = #13) and ((Buf+BufIdx+1)^ = #10)) or // Dos, CR/LF
  ((FEndOfRecord = #10) and ((Buf+BufIdx)^ = #10)) // Unix nur LF
  );

  if EmptyLine and FSkipEmptyLines then begin
  if (Buf+BufIdx)^ = #13 then
  BufIdx:=BufIdx+2   //CR+LF
  else
  BufIdx:=BufIdx+1; // LF
  result := true;
  exit;
  end;

  EndOfRec := (FieldIdx >= NumberOfDefFields+SkipFieldCount);
  // Test for EOF char
  if (BeginOfRec or EndOfRec) and ((Buf+BufIdx)^ = #26) then begin
  EndOfRec := true;
  if BeginOfRec then result := false;
  break;
  end;

  if BeginOfRec then BeginOfRec := false;

  if EndOfRec and ((Buf+BufIdx)^ = FEndOfRecord) then begin
  inc(BufIdx);
  break;
  end;

  // Ignore trailing #13 if EndOfRec = #10
  if EndOfRec and (FEndOfRecord = #10) and ((Buf+BufIdx)^ = #13) then begin
  inc(BufIdx);
  if BufIdx > (BufSize-1) then EndOfRec := false;
  continue;
  end;

  // here we got a wrong field width
  if EndOfRec then
  raise EIB_Import.Create(eWrongFieldWidth);

  AsciiFields[FieldIdx] := AsciiFields[FieldIdx] + (Buf+BufIdx)^;
  inc(BufIdx);
  inc(WidthIdx);

  with TImportFields(FFieldList.Objects[FieldIdx]) do begin
  // got all data for field(n)
  if WidthIdx = FieldWidth then begin
  if FieldDecimals >0 then begin
  tmpStr := AsciiFields[FieldIdx];
  insert(DecimalSeparator,tmpStr,FieldWidth-FieldDecimals+1);
  AsciiFields[FieldIdx] := tmpStr;
  end;
  inc(FieldIdx);
  WidthIdx := 0;
  if FieldIdx < NumberOfDefFields+SkipFieldCount then begin
  AsciiFields.Append('');
  end
  end;
  end; {with}


  until BufIdx > (BufSize-1);

  end; {while}


end; {GetFixedRecord}



procedure ImportData;
var
  GotData :boolean;
  i,p     :integer;
begin

  DSql.BeginBusy(true);

  repeat

  if not FFixedWidth then
  GotData := GetDelimitedRecord
  else begin
  InComment := false;
  GotData := GetFixedRecord;
  end;

  inc(LineNo); 

  if not GotData then break;

  if InComment then inc(RecsCommented);

  if not InComment then begin

  // Parameter Index
  p := 0;

  NumberOfFields := AsciiFields.Count;

  if FLastFieldDelimited then begin
  dec(NumberOfFields);
  end;

  if (NumberOfFields - SkipFieldCount) = NumberOfDefFields  then begin

  inc(RecsUnCommented);

  // give user a chance to modify Data
  if assigned(FOnParse) then FOnParse(Self, AsciiFields,NumberOfFields);

  for i := 0 to (NumberOfFields -1) do begin
  try
  if not TImportFields(FFieldList.Objects[i]).Skip then begin
  if AsciiFields[i] = '' then begin
    DSql.Params[p].Clear;
  end else begin
    DSql.Params[p].AsString := AsciiFields[i];
  end;
  inc(p);
  end;
  except
  raise;
  end;
  end;

  // call OnPrePost for user
  if assigned(FOnPrePost) then FOnPrePost(Self,ARow,OKtoPost);

  try
  if OKtoPost then begin
  DSql.Execute;
  inc(RecsInserted);
  end;
  except
  raise;
  end;
  end
  else begin
    if ((NumberOfFields - SkipFieldCount) = 1) and (AsciiFields[0]='') and FSkipEmptyLines then begin
    if GotData then continue
    else break;
    end
    else raise EIB_Import.CreateFmt(eWrongAsciiFieldCount,[LineNo]);
    end;
  end; { if not in Comment }

  // call user update and give some time to other apps
  if FNotifyCount > 0 then begin
  if (RecsUnCommented+RecsCommented) mod FNotifyCount = 0 then begin
  if FProcessMessages then Application.ProcessMessages;
  if assigned(FOnNotifyCount) then
    FOnNotifyCount(Self,RecsUnCommented+RecsCommented,RecsCommented,RecsInserted,UserAbort);
  end;
  end; {of FNotifyCount...}

  until (not GotData) or UserAbort;

  DSql.EndBusy;
  if FCommitTransaction and (not UserAbort) then IB_Transaction.Commit;

end; {ImportData}


procedure SetFieldsFromAsciiFile;
var
  i: integer;
begin
  FFieldList.Clear;
  repeat
  GetDelimitedRecord;
  if InComment then continue;
  // Setup FieldList
  for i := 0 to AsciiFields.Count - 1 do begin
  FFieldList.Add(AsciiFields[i]);
  end;
  until not InComment;
end;

procedure MakeInsertStatement;
var
  i   :integer;
  Sql :string;

procedure FieldListParser;
var
  i :integer;
  s :string;

  function getDescr(var s:string) :string;
  var
  idx :integer;
  tmp :string;
  begin
  idx := pos(';',s);
  if idx >0 then begin
  tmp := copy(s,0,idx-1);
  delete(s,1,idx);
  end
  else begin
  tmp := s;
  s := '';
  end;
  result := tmp;
  end;

begin {FieldListParser}

  {remove any blanks from list}
  if FFieldList.Count > 0 then begin
  for i := FFieldList.Count - 1 downto 0 do begin
  if Length(Trim(FFieldList[i])) = 0 then FFieldList.Delete(i);
  end;
  end;

  for i := 0 to FFieldList.Count -1 do begin

  s := FFieldList[i];
  FFieldList.Objects[i] := TImportFields.Create;

  with TImportFields(FFieldList.Objects[i]) do begin

  Skip := false;
  FieldName := trim(getDescr(s));
  if UpperCase(FieldName) = SkipFieldMarker then begin
  FieldName := UpperCase(FieldName);
  Skip := true;
  inc(SkipFieldCount);
  end;

  if length(s) >0 then try
  FieldWidth := StrToInt(trim(getDescr(s)));
  except
  raise EIB_Import.Create(EFieldDescriptionError);
  end;

  if length(s) >0 then try
  FieldDecimals := StrToInt(trim(getDescr(s)));
  except
  raise EIB_Import.Create(EFieldDescriptionError);
  end;

  if FFixedWidth and (FieldWidth <= FieldDecimals) then
  raise EIB_Import.CreateFmt(EWrongDecimalCount,[FieldName]);

  end; {with}

  end; {for}
end; {FieldListParser}

begin {MakeInsertStatement;}

  FieldListParser;

  Dsql.Sql.Clear;

  // no Fields are specified, assume ASCII-File has same Structure as DestTable
  if FFieldList.Count = 0 then
  begin
  DSql.SQL.Add('select * from ' + FDestTable + ' where rdb$db_key = -1');
  try
    DSql.Prepare;
    DSql.GetFieldNamesList(FFieldList);
    DSql.Unprepare;
    DSql.Sql.Clear;
  except
    raise
  end;

  // FieldList are defined now
  FieldListParser;

  end;

  NumberOfDefFields := FFieldList.Count - SkipFieldCount;

  if NumberOfDefFields <= 0 then begin
  raise EIB_Import.Create(EFieldDescriptionError);
  end;

  // Now build the Input Statement
  Sql := ('insert into ' + FDestTable + ' (');
  for i := 0 to FFieldList.Count -1 do
  begin
    with TImportFields(FFieldList.Objects[i]) do
    begin
      if FieldName = FSkipFieldMarker then
        continue;
      Sql := sql + FieldName;
      if FieldName <> FSkipFieldMarker then
        Sql := SQL +(',');
    end;
  end;

  delete(Sql,length(Sql),1);
  Sql := Sql +(')'#10);
  Sql := Sql + ('values (');

  for i := 0 to FFieldList.Count -1 do
  begin
    with TImportFields(FFieldList.Objects[i]) do
    begin
      if FieldName = FSkipFieldMarker then
        continue;
      Sql := Sql + (':' + FieldName);
      if FieldName <> FSkipFieldMarker then
        Sql := SQL +(',');
    end;
  end;
  delete(Sql,length(Sql),1);
  Sql := Sql + ')';

  try
    DSql.Sql.Add(Sql);
    DSql.Prepare;
  except
    raise;
  end;

end; {MakeInsertStatement}


begin {TIB_Import.Execute}

  if busy then exit;

  try

  // make some initial Settings
  StartUp;

  // if .Ini file exists, setup the component propertys frome there
  if (FIniFile <> '') then
  begin
    if FileExists(FIniFile) then
      SetupFromIniFile
    else
      raise EIB_Import.CreateFmt(EIniFileNotFound,[FIniFile]);
  end;

  // Set Separators
  if FDecimalSeparat <> #0 then DecimalSeparator := FDecimalSeparat;
  if FDateSeparat    <> #0 then DateSeparator    := FDateSeparat;
  if FTimeSeparat    <> #0 then TimeSeparator    := FTimeSeparat;

  // Date Format
  case FDateFormat of
    dfDMY: ShortDateFormat:= 'dd'+DateSeparator+'mm'+DateSeparator+'yyyy';
    dfMDY: ShortDateFormat:= 'mm'+DateSeparator+'dd'+DateSeparator+'yyyy';
    dfYMD: ShortDateFormat:= 'yyyy'+DateSeparator+'mm'+DateSeparator+'dd';
  end;

  // Check Settings of Propertys
  CheckPropertys;


  // Delete all Data if ImportMode is mCopy
  if FImportMode = mCopy then
  begin
    try
      DSql.Sql.Clear;
      Dsql.Sql.Add('delete from ' + FDestTable);
      DSql.ExecSQL;
    except
      raise;
    end
  end;

  // Open Ascii File
  try
    BufSize := 4096;
    AssignFile(InputFile,FAsciiFile);
    Reset(InputFile,1);
    Buf := nil;
    try
    GetMem(Buf,BufSize);
    except
      raise EIB_Import.Create(EOutOfMemory);
    end;
  except
    on EInOutError do
      raise EIB_Import.CreateFmt(eNoAsciiFileAccess,[FAsciiFile]);
  end;

  if FFieldsFirst then
    SetFieldsFromAsciiFile;

  // Setup InputFields and make Insert Statement
  MakeInsertStatement;

  // Begin with Import
  ImportData;

  finally
  // clean up Variables etc.
  CleanUp;
  end;

end; {TIB_Import.Execute}


end.
