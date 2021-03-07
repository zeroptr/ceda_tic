
{                                                                              }
{  IB_BLR                                                                      }
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
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This is a temporary unit. Once I get BLR stuff working as I'd like in this
new class I'll drop this unit and move it all into the base class.
<br><br>
IOW: Don't release anything production using this unit... make your own copy.  }
unit
  IB_BLR;
  
{$R-}  //  Turn off range checking.
{$A+}  // Need aligned record fields

interface

uses
  SysUtils, Classes, Windows,

  IB_Header,
  IB_Session,
  IB_Components;

type

TIB_BlrDataset = class( TIB_Dataset )
private
  FrqHandle: isc_req_handle;
protected
  function GetPrqHandle: pisc_req_handle;
public
  property PrqHandle: pisc_req_handle read GetPrqHandle;
published
end;

TIB_BlrCursor = class( TIB_BlrDataset )
{$I IBA_Statement.PBL }
{$I IBA_Dataset.PBL   }
end;

implementation
{
  procedure BlrByte( AByte: byte );
  begin
    BlrBuf[ BlrLen ] := AByte;
    inc( BlrLen );
  end;
  procedure BlrItem( AByte, AVal: byte );
  begin
    BlrByte( AByte );
    BlrByte( AVal );
  end;
  procedure BlrMsg( AID: byte; ACnt: word );
  begin
    BlrByte( blr_message );
    BlrByte( AID );
    BlrByte( ACnt mod 256 );
    BlrByte( ACnt div 256 );
  end;
  procedure AddShort( AScale: byte );
  begin
    BlrByte( blr_short );
    BlrByte( AScale );
  end;
  procedure AddLong( AScale: byte );
  begin
    BlrByte( blr_long );
    BlrByte( AScale );
  end;
  procedure BlrShortVal( AVal: short );
  begin
    BlrByte( blr_literal );
    BlrByte( blr_short );
    BlrByte( 0 ); // For scale
    BlrByte( AVal mod 256 );
    BlrByte( AVal div 256 );
  end;
  procedure AddCStr( ALen: word );
  begin
    BlrByte( blr_cstring );
    Inc( ALen ); // Null terminated string.
    BlrByte( ALen mod 256 );
    BlrByte( ALen div 256 );
  end;
  procedure AddText( ALen: word );
  begin
    BlrByte( blr_Text );
    BlrByte( ALen mod 256 );
    BlrByte( ALen div 256 );
  end;
  procedure AddVarying( ALen: word );
  begin
    BlrByte( blr_varying );
    BlrByte( ALen mod 256 );
    BlrByte( ALen div 256 );
  end;
  procedure AddIdent( AStr: string );
  var
    ii: word;
  begin
    AStr := Trim( UpperCase( AStr ));
    BlrByte( Length( AStr ));
    for ii := 1 to Length( AStr ) do begin
      BlrByte( byte( AStr[ ii ] ));
    end;
  end;
  procedure BlrRel( ARel: string; ANo: byte );
  begin
    BlrByte( blr_relation );
    AddIdent( ARel );
    BlrByte( ANo );
  end;
  procedure BlrField( ARelID: byte; AFld: string );
  begin
    BlrByte( blr_field );
    BlrByte( ARelID );
    AddIdent( AFld );
  end;
  procedure BlrParam( AMsgID: byte; APart: word );
  begin
    BlrByte( blr_parameter );
    BlrByte( AMsgID );
    BlrByte( APart mod 256 );
    BlrByte( APart div 256 );
  end;
  procedure BlrBegin;
  begin
    BlrByte( blr_begin );
  end;
  procedure BlrEnd;
  begin
    BlrByte( blr_end );
  end;
  procedure BlrEoc;
  begin
    BlrByte( blr_eoc );
  end;
  procedure BlrSend( AMsgID: byte );
  begin
    BlrByte( blr_send );
    BlrByte( AMsgID );
  end;
  procedure BlrReceive( AMsgID: byte );
  begin
    BlrByte( blr_receive );
    BlrByte( AMsgID );
  end;
  procedure AddMessageparam( ACol: TIB_Column );
  begin
    with ACol do begin
      Inc( BufOutLen, SQLLen );
      if IsNullable then begin
      end;
      case SQLtype of
        SQL_FLOAT,
        SQL_FLOAT_: BlrByte( blr_float );
        SQL_DOUBLE,
        SQL_DOUBLE_: BlrByte( blr_double );
        SQL_SHORT,
        SQL_SHORT_: AddShort( -SQLScale );
        SQL_LONG,
        SQL_LONG_: AddLong( -SQLScale );
        SQL_DATE,
        SQL_DATE_: BlrByte( blr_date );
        SQL_Text,
        SQL_Text_: AddText( SQLLen );
        SQL_VARYING,
        SQL_VARYING_: begin
          AddVarying( SQLLen );
          Inc( BufOutLen, 2 );
        end;
        SQL_BLOB,
        SQL_BLOB_,
        SQL_ARRAY,
        SQL_ARRAY_: BlrByte( blr_quad );
        else raise Exception.Create( 'Unsupported column type' );
      end;
    end;
  end;
}

function TIB_BLRDataset.GetPrqHandle: pisc_req_handle;
begin
  Result := @FrqHandle;
end;

end.

