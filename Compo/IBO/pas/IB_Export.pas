
{                                                                              }
{ IB_Export                                                                    }
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
{  Jason Wharton <jwharton@ibobjects.com>                                      }
{    07/30/2002                                                                }
{    Made it so that when doing a fixed width export and a date/time column    }
{    is null it will fill the space with blanks instead of an arbitrary        }
{    value for 0.                                                              }
{                                                                              }
{    I also added tha ability to suppress the creation of a SCH file with the  }
{    ASCII formats.                                                            }
{                                                                              }
{  modified by Dmitry Yatcenko                                                 }
{    DBF export                                                                }
{    DBF text translation                                                      }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the TIB_Export component.}
unit
  IB_Export;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, StdCtrls, ExtCtrls,

  IB_Header,
  IB_Session,
  IB_Constants,
  IB_Components,
  IB_DataScan;

type

TIB_Export = class;

{: Event type to translate a string.}
TIB_TranslateStringEvent = procedure ( var AString: string ) of object;

{: This is the valid output formats for this component.}
TIB_ExportFormat = ( efASCII, efASCII_Fixed, efDBF, efUser );

{: This event is designed to give access to the internal cursor that is used
in order to perform the actual exporting of the data.}
TIB_AdjustExportCursorEvent = procedure( Sender: TIB_Export;
                                         ACursor: TIB_Cursor ) of object;
{: This component is used to provide a way to dump out data from a dataset
into a delimited text file, a DBF file or a user defined file.
<br><br>
The text file created can be immediatly taken and used with the BDE ASCIDRV
or if headers are included then it is easy to convert it into an Excel
spreadsheet.
<br><br>
Set the Dataset property to any TIB_Dataset component and call the Execute
method to start the export. If you set it to a buffered dataset it will use
the current buffer to extract data from. If you use a TIB_Cursor then it will
clone the cursor into an internal cursor and scan through it to extract the
data. So, be sure to use a TIB_Cursor as the source on large datasets so that
it won't buffer all the records of the dataset in the process.
<br><br>
It is not desirable to do a unidirectional scan of a large dataset and
buffer all of the records that were fetched. Only one record at a time is
needed so by using the internal IB_Cursor memory usage is independant of the
size of the dataset being exported.
<br><br>
It is also possible to perform some alterations to the internal cursor that
is used to perform the export. One example is to exclude columns in the
original dataset from the exported dataset. Additional selection criteria
could be added to reduce the number of records processed, etc.
<br><br>
All of the dssSearch criteria is applied to the IB_Export as well so it is
very simple to design interfaces to export selected records. Simply give your
users the ability to define search criteria and you have an adhoc exporting
tool without writing any complicated lines of code.}
TIB_Export = class(TIB_DataScan)
private
  FFileName: string;
  FDelimiter: char;
  FSeparator: char;
  FDecSeparator : char; //OCW
  FOrigDecSeparator : char; //OCW
  FIncludeHeaders: boolean;
  FCreateSchemaFile: boolean;
  FIncludeCRLF: boolean;
  FDateFormat: string;
  FTimeFormat: string;
  FExportFormat: TIB_ExportFormat;
  FOnTranslateString: TIB_TranslateStringEvent;
  function GetDateTimeFormat: string;
  procedure SetDateTimeFormat( AValue: string );
{ Export Methods }
  procedure CreateSCHFile( ARow: TIB_Row; Fixed: boolean );
  procedure CreateASCIIHeader( ARow: TIB_Row );
  procedure CreateDBFHeader( ARow: TIB_Row );
  procedure ExportDelimitedRow( ARow: TIB_Row );
  procedure ExportFixedRow( ARow: TIB_Row );
  procedure ExportDBFRow( ARow: TIB_Row );
protected
  FStream: TStream;
{ Inherited Methods }
  procedure SysInitialize; override;
  procedure SysFinalize; override;
  procedure DoBeforeFetchFirstRow( ARow: TIB_Row ); override;
  procedure DoAfterFetchRow( ARow: TIB_Row ); override;
  procedure DoAfterFetchEof( ARow: TIB_Row ); override;
{ Properties }
  property Stream: TStream read FStream;
public
  constructor Create( AOwner: TComponent ); override;

{$I IB_Process.PBL}
{$I IB_DataScan.PBL}

published

{: Source dataset for the export.}
  property Dataset;
{: Format used for a timestamp. This is merely a concatenation of the
DateFormat and the TimeFormat properties with a space in the middle.
<br><br>
If you set this property it will look for a space and split the date and time
portions depending on where the first space is. So, if your date format has a
space in it you will need to set each one separately.}
  property DateTimeFormat: string read GetDateTimeFormat
                                  write SetDateTimeFormat;
{: Format used for date values in the ASCII export.}
  property DateFormat: string read FDateFormat write FDateFormat;
{: Format used for time values in the ASCII export.}
  property TimeFormat: string read FTimeFormat write FTimeFormat;
{: Delimiter character to be used in the ASCII output file.}
  property Delimiter: char read FDelimiter write FDelimiter default '"';
{: Filename of the output file for ASCII and DBF.}
  property Filename: string read FFileName write FFileName;
{: Separator character to be used in the ASCII output file.}
  property Separator: char read FSeparator write FSeparator default ',';
{: When using ASCII or ASCII Fixed file formats it is possible to have a BDE
ASCITEXT driver file created so that this file can be imported directly into a
TTable component and accessed. Set this to false if you have no need of the
BDE ASCITEXT import capability.}
  property CreateSchemaFile: boolean read FCreateSchemaFile
                                     write FCreateSchemaFile
                                     default true;   
{: If true then the names of the columns will be included in the first
row in the ASCII data output file.}
  property IncludeHeaders: boolean read FIncludeHeaders
                                   write FIncludeHeaders
                                   default false;
{: When using fixed width ASCII this will optionally include a CRLF.}
  property IncludeCRLF: boolean read FIncludeCRLF
                                write FIncludeCRLF
                                default false;
{: This determins which format will be used for the output.}
  property ExportFormat: TIB_ExportFormat read FExportFormat
                                          write FExportFormat
                                          default efASCII;
{: Event that give you an opportunity to translate the string being exported
when exporting out to DBF.}
  property OnTranslateString: TIB_TranslateStringEvent read FOnTranslateString
                                                       write FOnTranslateString;
end;

implementation

uses
  IB_Utils, IB_Parse;

{                                                                              }
{ ASCII Format                                                                 }
{                                                                              }

const
  EndOfRec: array [ 0..1 ] of char = #13#10;

procedure TIB_Export.CreateSCHFile( ARow: TIB_Row; Fixed: boolean  );
var
  ii: integer;
  FldLen, FldTot: integer;
  FldType: string;
  WriteBuf: string;
  SCHFileName: string;
  FileStub: string;
begin
  if not CreateSchemaFile then Exit;
  if FileExists( FileName ) then
    DeleteFile( Filename );
  FileStub := ExtractFilename( FileName );
  FileStub := Copy( FileStub, 1, Pos( '.', FileStub ) - 1 );
  SCHFileName := ExtractFileDir( Filename );
  if Length( SCHFilename ) > 0 then
    if SCHFilename[ Length( SCHFilename ) ] <> '\' then
      SCHFileName := SCHFileName + '\';
  SCHFileName := SCHFileName + FileStub + '.SCH';
  if FileExists( SCHFileName ) then
    DeleteFile( SCHFilename );
  FileClose( FileCreate( Filename ));
  FileClose( FileCreate( SCHFilename ));
  WriteBuf := '[' + FileStub + ']'#13#10;
  if Fixed then
    WriteBuf := WriteBuf + 'Filetype=FIXED'#13#10
  else
  begin
    WriteBuf := WriteBuf + 'Filetype=VARYING'#13#10;
    if Delimiter <> #0 then
      WriteBuf := WriteBuf + 'Delimiter=' + Delimiter + #13#10
    else
      WriteBuf := WriteBuf + 'Delimiter=' + #13#10;
    if Separator <> #0 then
      WriteBuf := WriteBuf + 'Separator=' + Separator + #13#10
    else
      WriteBuf := WriteBuf + 'Separator=' + #13#10;
  end;
  if Dataset.IB_Connection.CharSet <> '' then
    WriteBuf := WriteBuf + 'CharSet=' + Dataset.IB_Connection.CharSet + #13#10
  else
    WriteBuf := WriteBuf + 'CharSet=ASCII'#13#10;

  FldTot := 0;
  for ii := 0 to ARow.ColumnCount - 1 do
  with ARow[ ii ] do
  begin
    FldType := '';
    FldLen := 0;
    WriteBuf := WriteBuf + 'Field' + IntToStr( ii + 1 ) + '=' +
                FieldName + ',';
    case SQLType of
      SQL_Text,
      SQL_Text_,
      SQL_Varying,
      SQL_Varying_:
      begin
        FldType := 'CHAR';
        FldLen := SQLLen;
      end;
      SQL_FLOAT,
      SQL_FLOAT_,
      SQL_DOUBLE,
      SQL_DOUBLE_:
      begin
        FldType := 'FLOAT';
        FldLen := 15;
      end;
      SQL_SHORT,
      SQL_SHORT_:
      begin
        FldType := 'NUMBER';
        if SQLScale = 0 then
          FldLen := 6
        else
          FldLen := 7;
      end;
      SQL_LONG,
      SQL_LONG_:
      begin
        FldType := 'LONGINT';
        if SQLScale = 0 then
          FldLen := 9
        else
          FldLen := 10;
      end;
      SQL_INT64,
      SQL_INT64_:
      begin
        FldType := 'INT64';
        if SQLScale = 0 then
          FldLen := 18
        else
          FldLen := 19;
      end;
      SQL_TIMESTAMP,
      SQL_TIMESTAMP_:
      begin
        FldType := 'TIMESTAMP';
        // Length of date 13/Oct/2173
        FldLen := Length(FormatDateTime( DateTimeFormat, 99999.9999999999 ));
      end;
      SQL_TYPE_DATE,
      SQL_TYPE_DATE_:
      begin
        FldType := 'DATE';
        // Length of date 13/Oct/2173
        FldLen := Length(FormatDateTime( DateFormat, 99999 ));
      end;
      SQL_TYPE_TIME,
      SQL_TYPE_TIME_:
      begin
        FldType := 'TIME';
        FldLen := Length(FormatDateTime( TimeFormat, 0.9999999999 ));
      end;
      SQL_BLOB,
      SQL_BLOB_:
      begin
        if ( sqlsubtype = 1 ) and not Fixed then
          FldType := 'MEMO';
      end;
{
      SQL_ARRAY,
      SQL_ARRAY_:
      begin
        FldType := 'CHAR';
        FldLen := SQLLen;
      end;
}
    end;
    if FldType = '' then
      raise Exception.Create( 'Unsupported column: ' +
                               FieldName + ' SQLType: ' + IntToStr( SQLType ));

    WriteBuf := WriteBuf + FldType + ',' + IntToStr( FldLen ) + ',' +
                                           IntToStr( -SQLScale ) + ',' +
                                           IntToStr( FldTot ) + #13#10;
    FldTot := FldTot + FldLen;
  end;
  with TIB_StringList.Create do
    try
      Text := WriteBuf;
      SaveToFile( SCHFileName );
    finally
      Free;
    end;
end;

procedure TIB_Export.CreateASCIIHeader( ARow: TIB_Row );
var
  ii: integer;
begin
  with Stream do
  begin
    for ii := 0 to ARow.ColumnCount - 1 do with ARow[ ii ] do
    begin
      if ii > 0 then
        if Separator <> #0 then
          Write( Separator, 1 );
      if Delimiter <> #0 then Write( Delimiter, 1 );
      Write( PChar( BestFieldName )^, Length( BestFieldName ));
      if Delimiter <> #0 then Write( Delimiter, 1 );
    end;
    Write( EndOfRec, 2 );
  end;
end;

procedure TIB_Export.ExportDelimitedRow( ARow: TIB_Row );
var
  ii: integer;
  OutBuf: string;
  ExtBuf: extended;
  tmpLen: integer;
  jj: smallint;
  pTime: PISC_TIME;
begin
  with Stream do
  begin
    for ii := 0 to ARow.ColumnCount - 1 do
    with ARow[ii].PSQLVAR^ do
    begin
      if ii > 0 then
        if Separator <> #0 then
          Write( Separator, 1 );
      if {Odd( SQLType ) and} ( SQLInd^ = IB_NULL ) then
      else
      case SQLType of
        SQL_Text,
        SQL_Text_:
        begin
          if Delimiter <> #0 then
          begin
            SetLength( OutBuf, SQLLen );
            Move( SQLData^, OutBuf[1], SQLLen );
            OutBuf := mkLitCriteria( OutBuf, Delimiter );
            Write(Pchar(Outbuf)^, Length( Outbuf ));
          end
          else
            Write( SQLData^, SQLLen );
        end;
        SQL_Varying,
        SQL_Varying_:
        begin
          tmpLen := byte(ptr(longint(SQLData)+1)^) * 256 +
                    byte(ptr(longint(SQLData))^);
          if Delimiter <> #0 then
          begin
            SetLength( OutBuf, tmpLen );
            Move( Pchar(ptr(longint(SQLData)+2))^, OutBuf[1], tmpLen );
            OutBuf := mkLitCriteria( OutBuf, Delimiter );
            Write(Pchar(Outbuf)^, Length( Outbuf ));
          end
          else
            Write(Pchar(ptr(longint(SQLData)+2))^,
                   byte(ptr(longint(SQLData)+1)^) * 256 +
                   byte(ptr(longint(SQLData))^));
        end;
        SQL_FLOAT,
        SQL_FLOAT_:
        begin
          Outbuf := FloatToStr( single( SQLData^ ));
          Write(Pchar(Outbuf)^, Length( Outbuf ));
        end;
        SQL_DOUBLE,
        SQL_DOUBLE_:
        begin
          Outbuf := FloatToStr( double( SQLData^ ));
          Write(Pchar(Outbuf)^, Length( Outbuf ));
        end;
        SQL_SHORT,
        SQL_SHORT_:
        begin
          if SQLScale = 0 then
          begin
            Outbuf := IntToStr( smallint( SQLData^ ));
            Write(Pchar(Outbuf)^, Length( Outbuf ));
          end
          else
          begin
            Extbuf := smallint( SQLData^ );
            jj := 0;
            while jj < -SQLScale do
            begin
              Extbuf := Extbuf / 10;
              Inc( jj );
            end;
            Outbuf := FloatToStr( Extbuf );
            Write(Pchar(Outbuf)^, Length( Outbuf ));
          end;
        end;
        SQL_LONG,
        SQL_LONG_:
        begin
          if SQLScale = 0 then
          begin
            Outbuf := IntToStr( integer( SQLData^ ));
            Write(Pchar(Outbuf)^, Length( Outbuf ));
          end
          else
          begin
            Extbuf := integer( SQLData^ );
            jj := 0;
            while jj < -SQLScale do
            begin
              Extbuf := Extbuf / 10;
              Inc( jj );
            end;
            Outbuf := FloatToStr( Extbuf );
            Write(Pchar(Outbuf)^, Length( Outbuf ));
          end;
        end;
        SQL_INT64,
        SQL_INT64_:
        begin
          if SQLScale = 0 then
          begin
            {$IFDEF IBO_VCL40_OR_GREATER}
            Outbuf := IntToStr(int64(SQLData^));
            {$ELSE}
            //Outbuf := CompToStr(comp(SQLData^));
            raise Exception.Create( 'Unsupported' );
            {$ENDIF}
            Write(Pchar(Outbuf)^, Length( Outbuf ));
          end
          else
          begin
            {$IFDEF IBO_VCL40_OR_GREATER}
            Extbuf := int64(SQLData^);
            {$ELSE}
            Extbuf := comp(SQLData^);
            {$ENDIF}
            jj := 0;
            while jj < -SQLScale do
            begin
              Extbuf := Extbuf / 10;
              Inc( jj );
            end;
            Outbuf := FloatToStr( Extbuf );
            Write(Pchar(Outbuf)^, Length( Outbuf ));
          end;
        end;
        SQL_TIMESTAMP,
        SQL_TIMESTAMP_:
        begin
          Outbuf := FormatDateTime( DateTimeFormat,
                                   isc_decode_TDateTime( pisc_quad( SQLData )));
          Write(Pchar(Outbuf)^, Length( Outbuf ));
        end;
        SQL_TYPE_TIME,
        SQL_TYPE_TIME_:
        begin
          pTime := PISC_TIME( SQLData );
          Outbuf := FormatDateTime( TimeFormat,
                       EncodeTime(( pTime^ div ( 10000 * 60 * 60 )),
                                  ( pTime^ div ( 10000 * 60 )) mod 60,
                                    pTime^ div ( 10000 ) mod 60,
                                  ( pTime^ mod ( 10000 )) div 10 ) );
          Write(Pchar(Outbuf)^, Length( Outbuf ));
        end;
        SQL_TYPE_DATE,
        SQL_TYPE_DATE_:
        begin
          Outbuf := FormatDateTime( DateFormat,
                                   (ISC_DATE( SQLData^ ) - 15018) );
          Write(Pchar(Outbuf)^, Length( Outbuf ));
        end;
        SQL_BLOB,
        SQL_BLOB_:
        begin
          if sqlsubtype = 1 then
          begin
            Outbuf := ARow[ii].AsString;
            if Delimiter <> #0 then Write( Delimiter, 1 );
            Write(Pchar(Outbuf)^, Length( Outbuf ));
            if Delimiter <> #0 then Write( Delimiter, 1 );
          end
          else
          begin
            Outbuf := '(BLOB)';
            if Delimiter <> #0 then Write( Delimiter, 1 );
            Write(Pchar(Outbuf)^, Length( Outbuf ));
            if Delimiter <> #0 then Write( Delimiter, 1 );
          end;
        end;
        SQL_ARRAY,
        SQL_ARRAY_:
        begin
          Outbuf := '(ARRAY)';
          if Delimiter <> #0 then Write( Delimiter, 1 );
          Write(Pchar(Outbuf)^, Length( Outbuf ));
          if Delimiter <> #0 then Write( Delimiter, 1 );
        end;
      end;
    end;
    Write( EndOfRec, 2 );
  end;
end;

procedure TIB_Export.ExportFixedRow( ARow: TIB_Row );
var
  ii: integer;
  OutBuf: string;
  tmpLen: integer;
  ExtBuf: extended;
  jj: smallint;
  kk: integer;
  pTime: PISC_TIME;
begin
  with Stream do
  begin
    for ii := 0 to ARow.ColumnCount - 1 do
    with ARow[ii], PSQLVAR^ do
    begin
      case SQLType of
        SQL_Text,
        SQL_Text_:
          if IsNull then
          begin
            SetLength( OutBuf, sqlLen );
            FillChar( OutBuf[1], sqllen, PadChar );
            Write( Outbuf[1], Length( Outbuf ));
          end
          else
            Write( SQLData^, SQLLen );
        SQL_Varying,
        SQL_Varying_:
          if IsNull then
          begin
            SetLength( OutBuf, sqlLen );
            FillChar( OutBuf[1], sqllen, PadChar );
            Write( Outbuf[1], Length( Outbuf ));
          end
          else
          begin
            SetLength( OutBuf, sqlLen );
            FillChar( OutBuf[1], sqllen, PadChar );
            with SQL_VARCHAR( SQLData ^ ) do
            begin
            tmpLen := vary_len_high * 256 + vary_len_low;
            Move( vary_string, Outbuf[1], tmpLen );
            end;
            Write( Outbuf[1], Length( Outbuf ));
          end;
        SQL_FLOAT,
        SQL_FLOAT_:
        begin
          //raise Exception.Create( 'Not ready yet' );
          Outbuf := PadLeft( FloatToStr( single( SQLData^ )), '0', 7, true );
          Write( Outbuf[1], Length( Outbuf ));
        end;
        SQL_DOUBLE,
        SQL_DOUBLE_:
        begin
          //raise Exception.Create( 'Not ready yet' );
          Outbuf := PadLeft( FloatToStr( double( SQLData^ )), '0', 15, true );
          Write( Outbuf[1], Length( Outbuf ));
        end;
        SQL_SHORT,
        SQL_SHORT_:
        begin
          if IsNull then
          begin
            Outbuf := replicate_char( ' ', 6 );
            Write( Outbuf[1], Length( Outbuf ));
          end
          else
          if SQLScale = 0 then
          begin
            Outbuf := PadLeft( IntToStr( smallint( SQLData^ )), '0', 6, true );
            Write( Outbuf[1], Length( Outbuf ));
          end
          else
          begin
            //raise Exception.Create( 'Not ready yet' );
            Extbuf := smallint( SQLData^ );
            jj := 0;
            while jj < -SQLScale do
            begin
              Extbuf := Extbuf / 10;
              Inc( jj );
            end;
            Outbuf := PadLeft( FloatToStr( Extbuf ), '0', 9, true );;
            Write( Outbuf[1], Length( Outbuf ));
          end;
        end;
        SQL_LONG,
        SQL_LONG_:
        begin
          if IsNull then
          begin
            Outbuf := replicate_char( ' ', 9 );
            Write( Outbuf[1], Length( Outbuf ));
          end
          else
          if SQLScale = 0 then
          begin
            Outbuf := PadLeft( IntToStr( integer( SQLData^ )), '0', 9, true );
            Write( Outbuf[1], Length( Outbuf ));
          end
          else
          begin
            //raise Exception.Create( 'Not ready yet' );
            Extbuf := integer( SQLData^ );
            jj := 0;
            while jj < -SQLScale do
            begin
              Extbuf := Extbuf / 10;
              Inc( jj );
            end;
            Outbuf := PadLeft( FloatToStr( Extbuf ), '0', 9, true );
            Write( Outbuf[1], Length( Outbuf ));
          end;
        end;
        SQL_INT64,
        SQL_INT64_:
        begin
          if IsNull then
          begin
            Outbuf := replicate_char( ' ', 18 );
            Write( Outbuf[1], Length( Outbuf ));
          end
          else
          if SQLScale = 0 then
          begin
            {$IFDEF IBO_VCL40_OR_GREATER}
            Outbuf := PadLeft( IntToStr(int64(SQLData^)), '0', 18, true );
            {$ELSE}
//            Outbuf := PadLeft( CompToStr(comp(SQLData^)), '0', 18, true );
            raise Exception.Create( 'Unsupported' );
            {$ENDIF}
            Write(Outbuf[1], Length( Outbuf ));
          end
          else
          begin
            //raise Exception.Create( 'Not ready yet' );
            {$IFDEF IBO_VCL40_OR_GREATER}
            Extbuf := int64(SQLData^);
            {$ELSE}
            Extbuf := comp(SQLData^);
            {$ENDIF}
            jj := 0;
            while jj < -SQLScale do
            begin
              Extbuf := Extbuf / 10;
              Inc( jj );
            end;
            Outbuf := PadLeft( FloatToStr( Extbuf ), '0', 18, true );
            Write(Outbuf[1], Length( Outbuf ));
          end;
        end;
        SQL_TIMESTAMP,
        SQL_TIMESTAMP_:
        begin
          Outbuf := FormatDateTime( DateTimeFormat, AsDateTime );
          if IsNull then
            for kk := 1 to Length( Outbuf ) do
              OutBuf[kk] := ' ';
          Write( Outbuf[1], Length( Outbuf ));
        end;
        SQL_TYPE_TIME,
        SQL_TYPE_TIME_:
        begin
          pTime := PISC_TIME( SQLData );
          Outbuf := FormatDateTime( TimeFormat,
                       EncodeTime(( pTime^ div ( 10000 * 60 * 60 )),
                                  ( pTime^ div ( 10000 * 60 )) mod 60,
                                    pTime^ div ( 10000 ) mod 60,
                                  ( pTime^ mod ( 10000 )) div 10 ) );
          if IsNull then
            for kk := 1 to Length( Outbuf ) do
              OutBuf[kk] := ' ';
          Write(Outbuf[1], Length( Outbuf ));
        end;
        SQL_TYPE_DATE,
        SQL_TYPE_DATE_:
        begin
          Outbuf := FormatDateTime( DateFormat,
                                   (ISC_DATE( SQLData^ ) - 15018) );
          if IsNull then
            for kk := 1 to Length( Outbuf ) do
              OutBuf[kk] := ' ';
          Write(Outbuf[1], Length( Outbuf ));
        end;
        SQL_BLOB,
        SQL_BLOB_:
        begin

          raise Exception.Create( 'Not ready yet' );

          if sqlsubtype = 1 then
          begin
            Outbuf := '(MEMO)';
            if Delimiter <> #0 then Write( Delimiter, 1 );
            Write( Outbuf[1], Length( Outbuf ));
            if Delimiter <> #0 then Write( Delimiter, 1 );
          end
          else
          begin
            Outbuf := '(BLOB)';
            if Delimiter <> #0 then Write( Delimiter, 1 );
            Write( Outbuf[1], Length( Outbuf ));
            if Delimiter <> #0 then Write( Delimiter, 1 );
          end;
        end;
        SQL_ARRAY,
        SQL_ARRAY_:
        begin

          raise Exception.Create( 'Not ready yet' );

          Outbuf := '(ARRAY)';
          if Delimiter <> #0 then Write( Delimiter, 1 );
          Write( Outbuf[1], Length( Outbuf ));
          if Delimiter <> #0 then Write( Delimiter, 1 );
        end;
      end;
    end;
    if IncludeCRLF then
      Write( EndOfRec, 2 );
  end;
end;

{                                                                              }
{ DBF Format                                                                   }
{                                                                              }

var
  DBFHdr: record
    verinfo: integer;
    fldcount: integer;
    headersize: smallint;
    fieldsize: smallint;
    reserv: array[ 0..19 ] of byte;
  end;

  DBFFld: array[ 0..255 ] of record
    fieldname: array[ 0..10 ] of char;
    rectype: char;
    adress: integer;
    length: byte;
    decimal: byte;
    reserv: array[ 0..13 ] of byte;
  end;
  DBFCnt: integer;

procedure TIB_Export.CreateDBFHeader( ARow: TIB_Row );
  procedure AddFld( AFldName: string );
  begin
    StrPCopy( DBFFld[DBFCnt].fieldname, AFldName );
    DBFFld[DBFCnt].adress := DBFFld[ DBFCnt - 1 ].adress +
                             DBFFld[ DBFCnt - 1 ].length;
    FillChar( DBFFld[DBFCnt].reserv, 14, #0 );
    Inc( DBFHdr.fieldsize, DBFFld[DBFCnt].length );
    Inc( DBFCnt )
  end;
var
  ii: integer;
  ch: char;
  bool: boolean;
  tmpStr: string;
begin
  DBFCnt := 1;
  DBFHdr.fldcount := 0;
  DBFHdr.headersize := 33;
  DBFHdr.fieldsize := 1;
  DBFHdr.verinfo := $0d056303;
  FillChar( DBFHdr.reserv, 20, #0 );
  FillChar( DBFFld[0].reserv, 14, #0 );
  DBFFld[0].length := 0;
  DBFFld[0].decimal := 0;
  DBFFld[0].adress := 1;
  for ii := 1 to ARow.ColumnCount do
  begin
    bool := true;
    case ARow[ii-1].sqltype of
      SQL_VARYING,
      SQL_VARYING_,
      SQL_TEXT,
      SQL_TEXT_:
      begin
        DBFFld[DBFCnt].rectype := 'C';
        DBFFld[DBFCnt].length := ARow[ii-1].SQLLen;
        DBFFld[DBFCnt].decimal := 0;
      end;
      SQL_INT64,
      SQL_INT64_:
      begin
        DBFFld[DBFCnt].rectype := 'N';
        DBFFld[DBFCnt].length := 18;
        DBFFld[DBFCnt].decimal := - ARow[ii-1].SQLScale;
      end;
      SQL_FLOAT,
      SQL_FLOAT_:
      begin
        DBFFld[DBFCnt].rectype := 'N';
        DBFFld[DBFCnt].length := 7;
        DBFFld[DBFCnt].decimal := - ARow[ii-1].SQLScale;
      end;
      SQL_DOUBLE,
      SQL_DOUBLE_:
      begin
        DBFFld[DBFCnt].rectype := 'N';
        DBFFld[DBFCnt].length := 15;
        DBFFld[DBFCnt].decimal := - ARow[ii-1].SQLScale;
      end;
      SQL_LONG,
      SQL_LONG_:
      begin
        DBFFld[DBFCnt].rectype := 'N';
        DBFFld[DBFCnt].length := 9;
        DBFFld[DBFCnt].decimal := - ARow[ii-1].SQLScale;
      end;
      SQL_SHORT,
      SQL_SHORT_:
      begin
        DBFFld[DBFCnt].rectype := 'N';
        DBFFld[DBFCnt].length := 6;
        DBFFld[DBFCnt].decimal := - ARow[ii-1].SQLScale;
      end;
      SQL_TIMESTAMP,
      SQL_TIMESTAMP_:
      begin
        if not ARow[ii-1].IsDateOnly then
        begin
          // workout how long the time format is at 23:59:59.999
          tmpStr := FormatDateTime( TimeFormat, 0.9999999999 );
          DBFFld[DBFCnt].rectype := 'C';
          DBFFld[DBFCnt].length := Length(tmpStr);
          DBFFld[DBFCnt].decimal := 0;
          AddFld( 'TIME_' + IntToStr( DBFCnt ));
        end;
        DBFFld[DBFCnt].rectype := 'D';
        DBFFld[DBFCnt].length := 8;
        DBFFld[DBFCnt].decimal := 0;
      end;
      SQL_TYPE_TIME,
      SQL_TYPE_TIME_:
      begin
        DBFFld[DBFCnt].rectype := 'C';
        DBFFld[DBFCnt].length := 8;
        DBFFld[DBFCnt].decimal := 0;
      end;
      SQL_TYPE_DATE,
      SQL_TYPE_DATE_:
      begin
        DBFFld[DBFCnt].rectype := 'D';
        DBFFld[DBFCnt].length := 8;
        DBFFld[DBFCnt].decimal := 0;
      end;
      else
        bool := false;
    end;
    if bool then
      AddFld( ARow[ii-1].DBFFieldName );
  end;
{
SQL_BLOB    SQL_BLOB_
SQL_D_FLOAT SQL_D_FLOAT_
SQL_ARRAY   SQL_ARRAY_
}
  DBFHdr.headersize := 33 + ( 32 * ( DBFCnt - 1 ));
  Stream.Seek( 0, soFromBeginning );
  Stream.WriteBuffer( DBFHdr,  32 );
  for ii := 1 to DBFCnt - 1 do
    Stream.WriteBuffer( DBFFld[ii], 32 );
  ch := #13;
  Stream.WriteBuffer(ch,1);
{
 ch:=#26;
 Stream.WriteBuffer(ch,1);
}
end;

procedure TIB_Export.ExportDBFRow( ARow: TIB_Row );
Var
  ii: integer;
  jj: integer;
  s: string;
  f: string;
  ch: char;
  yr, mn, dy: word;
  procedure OutputNumeric;
  var
    tmpExt: extended;
  begin
    Inc( jj );
    if ARow[ ii-1 ].IsNull then
      s := replicate_char( ' ', DBFFld[ jj ].Length )
    else
    begin
      tmpExt := ARow[ ii-1 ].AsExtended;
      f := replicate_char( '0', DBFFld[ jj ].Length -
                                DBFFld[ jj ].Decimal - 2 ) +
           '.' +
           replicate_char( '0', DBFFld[ jj ].Decimal );
      if tmpExt >= 0 then
        f := '0' + f;
      s := FormatFloat( f , tmpExt );
    end;
    Stream.WriteBuffer( s[1], DBFFld[ jj ].length );
  end;
  procedure OutputDate;
  begin
    Inc( jj );
    if ARow[ ii-1 ].IsNull then
      s := replicate_char( ' ', DBFFld[ jj ].Length )
    else
    begin
      DecodeDate( ARow[ ii-1 ].AsDateTime, yr, mn, dy );
      s := IntToStr( yr );
      if mn < 10 then
        s := s + '0';
      s := s + IntToStr( mn );
      if dy < 10 then
        s := s + '0';
      s := s + IntToStr( dy );
    end;
    Stream.WriteBuffer( s[1], DBFFld[ jj ].length );
  end;
  procedure OutputTime;
  var
    tmpDT: TDateTime;
    pTime: PISC_TIME;
  begin
    Inc( jj );
    if ARow[ ii-1 ].IsNull then
      s := replicate_char( ' ', DBFFld[ jj ].Length )
    else
    begin
      case ARow[ ii-1 ].sqltype of
        SQL_TIMESTAMP,
        SQL_TIMESTAMP_:
          tmpDT := isc_decode_TDateTime( ARow[ ii-1 ].PSQLVAR.SQLData );
        SQL_TYPE_TIME,
        SQL_TYPE_TIME_:
          begin
          pTime := PISC_TIME( ARow[ ii-1 ].PSQLVAR.SQLData );
          tmpDT := EncodeTime(( pTime^ div ( 10000 * 60 * 60 )),
                               ( pTime^ div ( 10000 * 60 )) mod 60,
                                 pTime^ div ( 10000 ) mod 60,
                               ( pTime^ mod ( 10000 )) div 10 );
          end;
      else
        tmpDT := 0;
      end;
      case ARow[ ii-1 ].sqltype of
        SQL_TIMESTAMP,
        SQL_TIMESTAMP_:
          s := FormatDateTime( DateTimeFormat, tmpDT );
        SQL_TYPE_TIME,
        SQL_TYPE_TIME_:
          s := FormatDateTime( TimeFormat, tmpDT );
      else
        s := FormatDateTime( TimeFormat, tmpDT );
      end;
      while Length( s ) < DBFFld[ jj ].length do s := s + #32;
    end;
    Stream.WriteBuffer( s[1], DBFFld[ jj ].length );
  end;
  procedure OutputText;
  begin
    Inc( jj );
    s := ARow[ ii-1 ].AsString;
    if Assigned( FOnTranslateString ) then
      FOnTranslateString( s );
    while Length( s ) < DBFFld[ jj ].length do s := s + #32;
    Stream.WriteBuffer( s[1], DBFFld[ jj ].length );
  end;

begin
  Inc( DBFHdr.fldcount );
  jj := 0;
  ch := #32;
  Stream.WriteBuffer( ch, 1 );
  for ii := 1 to ARow.ColumnCount do
  begin
    case ARow[ ii-1 ].sqltype of
      SQL_VARYING,
      SQL_VARYING_,
      SQL_TEXT,
      SQL_TEXT_: OutputText;
      SQL_INT64,
      SQL_INT64_,
      SQL_QUAD,
      SQL_QUAD_,
      SQL_FLOAT,
      SQL_FLOAT_,
      SQL_DOUBLE,
      SQL_DOUBLE_,
      SQL_LONG,
      SQL_LONG_,
      SQL_SHORT,
      SQL_SHORT_: OutputNumeric;
      SQL_TYPE_TIME,
      SQL_TYPE_TIME_: OutputTime;
      SQL_TIMESTAMP,
      SQL_TIMESTAMP_:
      begin
        if not ARow[ii-1].IsDateOnly then
          OutputTime;
        OutputDate;
      end;
      SQL_TYPE_DATE,
      SQL_TYPE_DATE_: OutputDate;
    end;
  end;
end;

{                                                                              }

constructor TIB_Export.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FDateFormat := ShortDateFormat;
  FTimeFormat := ShortTimeFormat;
  FCreateSchemaFile := true;
  FDelimiter := '"';
  FSeparator := ',';
end;

function TIB_Export.GetDateTimeFormat: string;
begin
  Result := FDateFormat + ' ' + FTimeFormat;
end;

procedure TIB_Export.SetDateTimeFormat( AValue: string );
var
  tmpPos: integer;
begin
  if AValue <> '' then
  begin
    tmpPos := Pos( ' ', AValue );
    if tmpPos = 0 then
    begin
      FDateFormat := AValue;
      FTimeFormat := ShortTimeFormat;
    end
    else
    begin
      FDateFormat := Copy( AValue, 1, tmpPos - 1 );
      FTimeFormat := Copy( AValue, tmpPos + 1, MaxInt );
    end;
  end;
end;

procedure TIB_Export.DoBeforeFetchFirstRow( ARow: TIB_Row );
begin
  inherited DoBeforeFetchFirstRow( ARow );
  case ExportFormat of
    efASCII:
    begin
      CreateSCHFile( ARow, false );
      if IncludeHeaders then
        CreateASCIIHeader( ARow );
    end;
    efASCII_Fixed: CreateSCHFile( ARow, true );
    efDBF: CreateDBFHeader( ARow );
  end;
end;

procedure TIB_Export.DoAfterFetchRow( ARow: TIB_Row );
begin
  inherited DoAfterFetchRow( ARow );
  case ExportFormat of
    efASCII:
      ExportDelimitedRow( ARow );
    efASCII_Fixed:
      ExportFixedRow( ARow );
    efDBF:
      ExportDBFRow( ARow );
  end;
end;

procedure TIB_Export.DoAfterFetchEof( ARow: TIB_Row );
begin
  if ExportFormat = efDBF then
  begin
    Stream.Seek( 0, soFromBeginning );
    Stream.WriteBuffer( DBFHdr, 32 );
  end;
  inherited DoAfterFetchEof( ARow );
end;

procedure TIB_Export.SysInitialize;
begin
  inherited SysInitialize;
  if ( FileName = '' ) and ( ExportFormat in [ efASCII,
                                               efASCII_Fixed,
                                               efDBF ] ) then
    raise EIB_Error.Create( E_FileName_Required );
  if ( FileName <> '' ) and not Assigned( FStream ) then
    FStream := TFileStream.Create( FileName, fmCreate );
  FOrigDecSeparator := DecimalSeparator;
  DecimalSeparator := FDecSeparator; //OCW
end;

procedure TIB_Export.SysFinalize;
begin
  inherited SysFinalize;
  if Assigned( FStream ) then
  begin
    FStream.Free;
    FStream := nil;
  end;
  DecimalSeparator := FOrigDecSeparator; //OCW
end;

end.

