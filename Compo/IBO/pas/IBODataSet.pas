
{                                                                              }
{  IBODataset                                                                  }
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
{  10-May-2002                                                                 }
{     When removing the TIBOBCDField sub-class I needed to alter the code in   }
{     the Get/SetFieldData routines so that the calculated fields would use    }
{     the proper datasize. By the time the call is made to the internal        }
{     get/set field data routines all BCD fields should be working with a      }
{     currency data type as the buffer and not a TBCD type. Thus, even though  }
{     the TBCDField.DataSize is 34 it should be ignored in my internal         }
{     routines.                                                                }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  25-Jan-02                                                                   }
{      Further adjustments to the Integer and Currency conversion methods that }
{      I added earlier (whoops forgot to document that).  Attempting to make   }
{      it so that assignments use statistical/bankers rounding for assignment. }
{                                                                              }
{  Jason Wharton <jwharton@ibobjects.com>                                      }
{  11/24/2001                                                                  }
{     I fixed a problem with an access violation being raised if AutoFetchAll  }
{     was set to true along with an OnFilterRecord event assigned. What        }
{     happened was it required the TempBuffer to be valid at the time the      }
{     InternalOpen method was called. But, at that time the buffer memory has  }
{     not been declared yet. So, it crashed when trying to access bad memory.  }
{     I fixed it by deferring the actual opening of the internal dataset until }
{     the DoAfterOpen method was called. At this time the buffers were ready.  }
{     I also had to add a flag to the InternalDataset and modify the           }
{     IsCursorOpen virtual override so that it thought it was open. If this    }
{     wasn't done the buffers would never be allocated. This was a "Which came }
{     first, the chicken or the egg?" problem.                                 }
{                                                                              }
{  Jason Wharton <jwharton@ibobjects.com>                                      }
{  11/23/2001                                                                  }
{     I fixed a problem with an access violation being raised if a bookmark    }
{     was accessed after the internal dataset was refreshed and the TDataset   }
{     buffers had not been resynced yet. There was one combination of actions  }
{     which made this happen involving the Filtered property. I have now       }
{     resolved it so that it will not access the TDataset.GetBookmark routine  }
{     unless there is a valid buffer to draw information from.                 }
{     Thanks are due to Rohit Gupta for his patience and persistance in        }
{     helping me isolate and resolve this problem.                             }
{                                                                              }
{  Jason Wharton <jwharton@ibobjects.com>                                      }
{  08/09/2001                                                                  }
{     I didn't quite get it just right. I had to set the Index for the TField  }
{     references in a separate loop so that they kept the right order in the   }
{     loop. As it was, I was corrupting the loop by changing the index order   }
{     of fields in it while I was looping through them.                        }
{                                                                              }
{  Lorenzo Mengoni <lorenzo@mengoni.com>                                       }
{  10/16/2001                                                                  }
{     line 1632,1657 search for Lorenzo                                        }
{     I make a control of case in TableName property setting to prevent the    }
{     error in all upper case error table names in dialect 3                   }
{                                                                              }
{  Jason Wharton <jwharton@ibobjects.com>                                      }
{  08/08/2001                                                                  }
{     I improved the integration between the internal dataset and the TDataset }
{     component so that it would respect the FieldsIndex setting. This is due  }
{     to the AssignSQLWithSearch() method will inject various settings into    }
{     this component. I also had to change some things so that it uses the SQL }
{     order of the fields in the lists rather than the fields index order.     }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the components based on the TDataset class
provided with Delphi version 3 and later.}
unit
  IBODataset;

interface

uses
  SysUtils, Windows, Classes, Forms, Dialogs, Messages,

{$IFDEF IBO_VCL60_OR_GREATER}
  Variants,
{$ENDIF}  

  DB,
//DBTables
  IB_Header,
  IB_Constants,
  IB_Components,
  IB_Session;
//IBODataset.PBL
//IBOWeb

type

{: Exception class that contains all the information gathered about the
exception.}
EIBO_ISCError = class(EDatabaseError)
private
  FSender: TObject;
  FERRCODE: isc_long;
  FErrorMessage: TStringList;
  FErrorCodes: TStringList;
  FSQLCODE: isc_long;
  FSQLMessage: TStringList;
  FSQL: TStringList;
public
  constructor CreateISC( Sender: TObject;
                         MessageText: string;
                         AERRCODE: isc_long;
                         AErrorMessage: TStringList;
                         AErrorCodes: TStringList;
                         ASQLCODE: isc_long;
                         ASQLMessage: TStringList;
                         ASQL: TStringList ); virtual;
  destructor Destroy; override;
  procedure ShowDialog;
  property Sender: TObject read FSender;
  property ERRCODE: isc_long read FERRCODE;
  property ErrorMessage: TStringList read FErrorMessage;
  property ErrorCodes: TStringList read FErrorCodes;
  property SQLCODE: isc_long read FSQLCODE;
  property SQLMessage: TStringList read FSQLMessage;
  property SQL: TStringList read FSQL;
end;

TIBOKeyIndex = ( kiIBOLookup,
                 kiIBORangeStart,
                 kiIBORangeEnd,
                 kiIBOCurRangeStart,
                 kiIBOCurRangeEnd,
                 kiSave );

PIBOKeyBuffer = ^TIBOKeyBuffer;
TIBOKeyBuffer = record
  Modified: boolean;
  Exclusive: boolean;
  FieldCount: integer;
end;

PIBORecInfo = ^TIBORecInfo;
TIBORecInfo = record
  RecRowNum: integer;
  RecRowNode: PIB_Node;
  BookmarkFlag: TBookmarkFlag;
end;

TIBODatasetFetchCallback = procedure(     ADataset: TDataset;
                                          Status: TIB_CallbackStatus;
                                          CursorRowNum: longint;
                                      var Abort: boolean ) of object;

TIBOBCDField = class( TBCDField );
TIBOFloatField = class( TFloatField )
protected
  procedure SetText( const AValue: string ); override;
end;

TIBOFieldOption = (foDisplayFromIBO, foAutoAppendAllFields);

TIBOFieldOptions = set of TIBOFieldOption;

{$IFNDEF HELPSCAN}
TIBODataset = class;

TIBOInternalDataset = class(TIB_BDataset)
private
  FIsCursorOpen: boolean;
{$IFDEF IBO_VCL40_OR_GREATER}
  FUpdatingParams: boolean;
{$ENDIF}
  function GetDataset: TIBODataset;
protected
  procedure DoUpdateRecord(     UpdateKind: TIB_UpdateKind;
                            var UpdateAction: TIB_UpdateAction ); override;
{$IFDEF IBO_VCL40_OR_GREATER}
  procedure SysAfterExecuteForOutput; override;
  procedure SysAfterParamsDataChange( Sender: TIB_Row;
                                      AField: TIB_Column ); override;
  function IsUsingManualDML( UpdateKind: TIB_UpdateKind ): boolean; override;
  procedure GetColumnIsReadOnly(     AColumn: TIB_Column;
                                 var AReadOnly: boolean ); override;
{$ENDIF}
  procedure SysBeforePrepare; override;
  procedure SysBeforeExecute; override;
  procedure SysAfterPrepare; override;
  procedure SysAfterUnprepare; override;
  procedure SysPrepareSQL; override;
  procedure SysPrepareFailed; override;
  procedure SysCancel; override;
  procedure SysPost( CancelUnmodified, IsRetaining: boolean ); override;
  procedure SysClose; override;
  procedure SysSQLChange( Sender: TObject; var Unprepare: boolean ); override;
  function SysRefresh( Rows, Keys: boolean ): boolean; override;
  procedure SysUpdateOperation(     Operation: TIB_DataOperation;
                                    UpdateKind: TIB_UpdateKind;
                                var UpdateAction: TIB_UpdateAction ); override;
  property IBODataset: TIBODataset read GetDataset;
  procedure DoHandleError(       Sender: TObject;
                           const errcode: isc_long;
                                 ErrorMessage,
                                 ErrorCodes: TStringList;
                           const SQLCODE: isc_long;
                                 SQLMessage,
                                 SQL: TStringList;
                             var RaiseException: boolean ); override;
  procedure ProcessTransactionEvent( ATransactionLink: TIB_TransactionLink;
                                     AEvent: TIB_TransactionEventType ); override;
  function SysNeedToRefineSQL: boolean; override;
public
  constructor Create( AOwner: TComponent ); override;
  procedure ApplyUpdates; override;
  procedure CancelUpdates; override;
  procedure CommitUpdates; override;
end;
{$ENDIF}

{: This class is used to emulate the behavior of the TDatabase component.
<br><br>
Using this component forces all statements and datasets that attach to it to
use a single transaction held internally (just like the BDE would do).
<br><br>
It is intended for ease of migration from the BDE to IBO but it is encouraged
that you eventaully replace it with a TIB_Connection component as soon as you
are ready to take full control of all transactions for the connection.}
TIBODatabase = class(TIB_Database)
private
  FDriverName: string;
  FSessionName: string;
public
  constructor Create( AOwner: TComponent ); override;
{: This method is used in order to apply updates for selected datasets in a
specified order.
<br><br>
To have all datasets for the transaction handled pass in an empty set.}
  procedure ApplyUpdates( const ADatasets: array of TIBODataset );
{: This method is used in order to cancel updates for selected datasets in a
specified order.
<br><br>
To have all datasets for the transaction handled pass in an empty set.}
  procedure CancelUpdates( const ADatasets: array of TIBODataset );
published
  property DriverName: string read FDriverName write FDriverName;
  property SessionName: string read FSessionName write FSessionName;
  property PasswordStorage default psNotSecure;
end;

{: This class is used to provide extended transaction capabilities to the
TDataset based components. It has exactly the same behavior as its ancestor
except that the cached updates handling has been adjusted to deal with the
TDataset based datasets.}
TIBOTransaction = class(TIB_Transaction)
public
{: This method is used in order to apply updates for selected datasets in a
specified order.
<br><br>
To have all datasets for the transaction handled pass in an empty set.}
  procedure ApplyUpdates( const ADatasets: array of TIBODataset );
{: This method is used in order to cancel updates for selected datasets in a
specified order.
<br><br>
To have all datasets for the transaction handled pass in an empty set.}
  procedure CancelUpdates( const ADatasets: array of TIBODataset );
end;

{$IFDEF IBO_VCL40_OR_GREATER}
TIBOUpdateSQL = class;
{$ENDIF}

{ TIBODataset }

{: This is the base class of IBO's implementation of the TDataset class. This
is essentially a wrapper around a specialized TIB_Query component used to
provide the TDataset with all needful functionality.
<br><br>
The properties, methods and events of this class are either VCL compatible or
they reflect the behavior of the underlying native IBO dataset. As a result,
most all the informative help will be found associated to these other sources.} 
TIBODataset = class(TDataset)
private
  FDataLink: TDataLink;
{$IFDEF IBO_VCL40_OR_GREATER}
  FParams: TParams;
  FIndexDefs: TIndexDefs;
  FStoreDefs: boolean;
{$ENDIF}
  FRecAppended: boolean;
  FRecBufSize: integer;
  FRecInfoOfs: word;
  FRecordSize: word;
  FCurRowNum: integer;
  FFilterBuffer: pointer;
  FFieldOptions: TIBOFieldOptions;
  FIB_Query: TIBOInternalDataset;
  FIsPosting: boolean;
  FIsCanceling: boolean;
  FIsClosing: boolean;
  FReadOnly: boolean;
  FKeyBuffers: array[ TIBOKeyIndex ] of PIBOKeyBuffer;
  FKeyBuffer: PIBOKeyBuffer;
  FSettingCursorRange: boolean;
  FRefreshingParams: integer;
  FBoolList: boolean;
  FBoolTVals: TIB_StringList;
  FBoolFVals: TIB_StringList;
  FIncludeOutputParams: boolean;
  FInternalRefreshing: boolean;
  FRecordCountAccurate: boolean;
  FSessionName: string;
{$IFDEF IBO_VCL40_OR_GREATER}
  FUpdateObject: TIBOUpdateSQL;
{$ENDIF}
  FOnCallback: TIBODatasetFetchCallback;
  FOnError: TIB_ErrorEvent;
  FOnPrepareSQL: TNotifyEvent;
  FBeforePrepare: TNotifyEvent;
  FAfterPrepare: TNotifyEvent;
  function GetAutoFetchAll: boolean;
  function GetBoolTVals: TIB_StringList;
  function GetBoolFVals: TIB_StringList;
  function GetBufferSynchroFlags: TIB_BufferSynchroFlagsSet;
  function GetCachedUpdates: boolean;
  function GetCallbackCaption: string;
  function GetCallbackInc: integer;
  function GetCallbackInitInt: DWORD;
  function GetCallbackInitTick: DWORD;
  function GetCallbackRefreshInt: DWORD;
  function GetCallbackRefreshTick: DWORD;
  function GetCheckRequired: boolean;
  function GetColumnAttributes: TIB_StringList;
  function GetCommitAction: TIB_CommitAction;
  function GetConnection: TIB_Connection;
  function GetDefaultValues: TIB_StringList;
  function GetFetchWholeRows: boolean;
  function GetFieldsAlignment: TIB_StringList;
  function GetFieldsDisplayLabel: TIB_StringList;
  function GetFieldsDisplayFormat: TIB_StringList;
  function GetFieldsReadOnly: TIB_StringList;
  function GetFieldsEditMask: TIB_StringList;
  function GetFieldsVisible: TIB_StringList;
  function GetParamCount: integer;
  function GetGeneratorLinks: TIB_StringList;
  function GetJoinLinks: TIB_StringList;
  function GetKeyFields: TIB_Row;
  function GetKeyLinks: TIB_StringList;
  function GetKeyLinksAutoDefine: boolean;
  function GetKeyRelation: string;
  function GetMaxRows: integer;
  function GetIB_Session: TIB_Session;
  function GetIsSelectSQL: boolean;
  function GetOrderingItemNo: integer;
  function GetOrderingItems: TIB_StringList;
  function GetOrderingLinks: TIB_StringList;
  function GetParamCheck: boolean;
{$IFDEF IBO_VCL50_OR_GREATER}
  function GetOnUpdateError: TUpdateErrorEvent;
  function GetOnUpdateRecord: TUpdateRecordEvent;
{$ELSE}
  function GetOnUpdateError: TIB_UpdateErrorEvent;
  function GetOnUpdateRecord: TIB_UpdateRecordEvent;
{$ENDIF}
  function GetUpdatesPending: boolean;
{$IFDEF IBO_VCL40_OR_GREATER}
  function GetParams: TParams;
{$ELSE}
  function GetParams: TIB_Row;
{$ENDIF}
  function GetPessimisticLocking: boolean;
  function GetPlan: string;
  function GetPrepared: boolean;
  function GetReadOnly: boolean;
  function GetRequestLive: boolean;
  function GetRowsAffected: integer;
  function GetServerSQL: string;
  function GetSQL: TStrings;
  function GetSQLForUpdate: TStrings;
  function GetSQLOrder: TStrings;
  function GetSQLWhere: TStrings;
  function GetSQLWhereItems: TStrings;
  function GetStatementType: TIB_StatementType;
  function GetTransaction: TIB_Transaction;
{$IFDEF IBO_VCL40_OR_GREATER}
  function IsFieldDefsStored: boolean;
  function IsIndexDefsStored: boolean;
{$ENDIF}
  function IsKeyLinksStored: boolean;
  function IsPreparedStored: boolean;
  function IsTransactionStored: boolean;
  function IsConnectionStored: boolean;
  procedure SetAutoFetchAll( AValue: boolean );
  procedure SetBufferSynchroFlags( AValue: TIB_BufferSynchroFlagsSet );
  procedure SetCachedUpdates( AValue: boolean );
  procedure SetCallbackCaption( AValue: string );
  procedure SetCallbackInc( AValue: integer );
  procedure SetCallbackInitInt( AValue: DWORD );
  procedure SetCallbackRefreshInt( AValue: DWORD );
  procedure SetCallbackRefreshTick( AValue: DWORD );
  procedure SetCheckRequired( AValue: boolean );
  procedure SetColumnAttributes( AValue: TIB_StringList );
  procedure SetCommitAction( AValue: TIB_CommitAction );
  procedure SetConnection( Value: TIB_Connection );
  procedure SetDefaultValues( AValue: TIB_StringList );
  procedure SetFetchWholeRows( AValue: boolean );
  procedure SetFieldsAlignment( AValue: TIB_StringList );
  procedure SetFieldsDisplayLabel( AValue: TIB_StringList );
  procedure SetFieldsDisplayFormat( AValue: TIB_StringList );
  procedure SetFieldsReadOnly( AValue: TIB_StringList );
  procedure SetFieldsEditMask( AValue: TIB_StringList );
  procedure SetFieldsVisible( AValue: TIB_StringList );
  procedure SetGeneratorLinks( AValue: TIB_StringList );
  procedure SetJoinLinks( AValue: TIB_StringList );
  procedure SetKeyLinks( AValue: TIB_StringList );
  procedure SetKeyLinksAutoDefine( AValue: boolean );
  procedure SetKeyRelation( AValue: string );
  procedure SetMaxRows( AValue: integer );
  procedure SetParamCheck( AValue: boolean );
  procedure SetOrderingItemNo( Value: integer );
  procedure SetOrderingItems( Value: TIB_StringList );
  procedure SetOrderingLinks( Value: TIB_StringList );
{$IFDEF IBO_VCL50_OR_GREATER}
  procedure SetOnUpdateError( AValue: TUpdateErrorEvent );
  procedure SetOnUpdateRecord( AValue: TUpdateRecordEvent );
{$ELSE}
  procedure SetOnUpdateError( AValue: TIB_UpdateErrorEvent );
  procedure SetOnUpdateRecord( AValue: TIB_UpdateRecordEvent );
{$ENDIF}
{$IFDEF IBO_VCL40_OR_GREATER}
  procedure SetIndexDefs( AValue: TIndexDefs );
  procedure SetParams( AParams: TParams );
{$ELSE}
  procedure SetParams( AParams: TIB_Row );
{$ENDIF}
  procedure SetPessimisticLocking( AValue: boolean );
  procedure SetPrepared( AValue: boolean );
  procedure SetReadOnly( AValue: boolean );
  procedure SetRecordCountAccurate( AValue: boolean );
  procedure SetRequestLive( AValue: boolean );
  procedure SetSQL( Value: TStrings);
  procedure SetSQLForUpdate(Value: TStrings);
  procedure SetSQLOrder(Value: TStrings);
  procedure SetSQLWhere(Value: TStrings);
  procedure SetTransaction( Value: TIB_Transaction);
  function GetDeleteSQL: TIB_StringList;
  function GetEditSQL: TIB_StringList;
  function GetLockSQL: TIB_StringList;
  function GetInsertSQL: TIB_StringList;
  procedure SetDeleteSQL( AValue: TIB_StringList );
  procedure SetEditSQL( AValue: TIB_StringList );
  procedure SetLockSQL( AValue: TIB_StringList );
  procedure SetInsertSQL( AValue: TIB_StringList );
protected
{ Flags }
  FStreamedPrepared: boolean;
{ Methods }
  procedure DoUpdateRecord(     UpdateKind: TIB_UpdateKind;
                            var UpdateAction: TIB_UpdateAction ); //~virtual;
  procedure DoBeforePrepare; virtual;
  procedure DoAfterPrepare; virtual;
  procedure DoHandleError(       Sender: TObject;
                           const errcode: isc_long;
                                 ErrorMessage,
                                 ErrorCodes: TStringList;
                           const SQLCODE: isc_long;
                                 SQLMessage,
                                 SQL: TStringList;
                             var RaiseException: boolean); //~virtual;
  procedure FetchCallback(     IB_Dataset: TIB_Dataset;
                               Status: TIB_CallbackStatus;
                               CursorRowNum: longint;
                           var Abort: boolean );
  function GetActiveRecBuf( var ARecBuf: pointer;
                            var ACalcBuf: pointer;
                            var ARowNode: PIB_Node ): boolean; //~virtual;
  function GetDatabaseName: string;
  function GetUnidirectional: boolean;
  procedure SetUnidirectional( AValue: boolean );
  procedure GetValuesFromMaster; virtual;
  procedure InitFields;
  function IsConstraintsStored: Boolean; virtual;
  function LocateRecord( const AKeyFields: string;
                         const AKeyValues: Variant;
                               AOptions: TLocateOptions;
                               SyncCursor: boolean;
                               LocateNearest: boolean ): boolean; //~virtual;
  procedure RecordFilter( ARow: TIB_Row; var Accept: boolean );
  procedure RefreshParams( WantRefresh: boolean ); 
  procedure RefreshParam( const AParam: TIB_Column;
                          const ADataset: TDataset ); virtual;
  procedure SetDatabaseName( AValue: string ); //~virtual;
  procedure SysPrepareSQL; virtual;
  procedure SysPrepareFailed; virtual;
  procedure SysSQLChange( Sender: TObject; var Unprepare: boolean ); virtual;
  procedure SysResync( Mode: TResyncMode );
  procedure AllocKeyBuffers;
  procedure CheckSetKeyMode;
  procedure FreeKeyBuffers;
  procedure AppendOtherFields;
  function GetIndexField( Index: integer ): TField;
  function GetIndexFieldCount: integer;
  procedure GetIndexNames( List: TStrings );
  function GetKeyBuffer( KeyIndex: TIBOKeyIndex ): PIBOKeyBuffer;
  function GetKeyExclusive: Boolean;
  function GetKeyFieldCount: Integer;
  function GotoRecord( LocateNearest: boolean ): boolean;
  function InitKeyBuffer( Buffer: PIBOKeyBuffer ): PIBOKeyBuffer;
  procedure PostKeyBuffer( Commit: Boolean );
  function ResetCursorRange: boolean;
  function SetCursorRange: boolean;
  procedure SetIndexField( Index: integer; Value: TField );
  procedure SetKeyBuffer( KeyIndex: TIBOKeyIndex; Clear: Boolean );
  procedure SetKeyExclusive( Value: Boolean );
  procedure SetKeyFieldCount( Value: Integer );
  procedure SetKeyFields(       KeyIndex: TIBOKeyIndex;
                          const Values: array of const );
  procedure CloseCursor; override;
  procedure Loaded; override;
{$IFDEF IBO_DELPHI_4} // Cover up a Delphi 4 oddity.
  procedure SetBlockReadSize(Value: Integer); override;
{$ENDIF}
{ Overriden abstract methods (required) }
  function AllocRecordBuffer: PChar; override;
{$IFDEF IBO_VCL50_OR_GREATER}
  procedure CheckFieldCompatibility( Field: TField;
                                     FieldDef: TFieldDef ); override;
{$ENDIF}
  procedure ClearCalcFields(Buffer: PChar); override;
  procedure DoBeforeInsert; override;
  procedure DoOnNewRecord; override;
  function FindRecord( Restart, GoForward: boolean ): boolean; override;
  procedure FreeRecordBuffer(var Buffer: PChar); override;
  function GetFieldClass(FieldType: TFieldType): TFieldClass; override;
  procedure GetBookmarkData( Buffer: PChar; Data: Pointer ); override;
  function GetBookmarkFlag( Buffer: PChar ): TBookmarkFlag; override;
  function GetDataSource: TDataSource; override;
  function GetIsIndexField(Field: TField): Boolean; override;
  function GetRecord( Buffer: PChar;
                      GetMode: TGetMode;
                      DoCheck: boolean ): TGetResult; override;
  function GetRecordSize: word; override;
  function GetRecordCount: integer; override;
  function GetRecNo: Integer; override;
  function GetCanModify: boolean; override;
{$IFNDEF IBO_VCL50_OR_GREATER}
  function BCDToCurr( BCD: Pointer; var Curr: Currency ): Boolean; override;
  function CurrToBCD( const Curr: Currency;
                            BCD: Pointer;
                            Precision,
                            Decimals: Integer ): Boolean; override;
{$ENDIF}
  procedure InternalAddRecord( Buffer: Pointer; Append: boolean ); override;
  procedure InternalClose; override;
  procedure InternalDelete; override;
  procedure InternalFirst; override;
  procedure InternalGotoBookmark( ABookmark: Pointer ); override;
  procedure InternalHandleException; override;
  procedure InternalInitFieldDefs; override;
  procedure InternalInitRecord(Buffer: PChar); override;
  procedure InternalLast; override;
  procedure InternalOpen; override;
  procedure InternalEdit; override;
{$IFDEF IBO_VCL40_OR_GREATER}
  procedure InternalInsert; override;
  procedure InternalInitParamDefs; //~virtual;
{$ELSE}
  procedure InitRecord(Buffer: PChar); override;
  procedure DoBeforeCancel; override;
{$ENDIF}
  procedure InternalPost; override;
  procedure InternalCancel; override;
  procedure InternalRefresh; override;
  procedure InternalSetToRecord(Buffer: PChar); override;
  function IsCursorOpen: boolean; override;
  procedure DoBeforeOpen; override;
  procedure SetBookmarkData( Buffer: PChar; Data: Pointer ); override;
  procedure SetBookmarkFlag( Buffer: PChar; Value: TBookmarkFlag ); override;
  procedure SetDataSource( AValue: TDataSource ); //~virtual;
  procedure SetFilterText(const Value: string); override;
  procedure SetFiltered( AValue: boolean ); override;
  procedure SetFilterOptions( AValue: TFilterOptions ); override;
  procedure SetOnFilterRecord( const Value: TFilterRecordEvent ); override;
  procedure SetRecNo( Value: Integer ); override;
{$IFDEF IBO_VCL40_OR_GREATER}
  procedure SetUpdateObject( AValue: TIBOUpdateSQL );
  procedure Notification( AComponent: TComponent;
                          Operation: TOperation); override;
{$ENDIF}
protected
{$IFDEF IBO_VCL40_OR_GREATER}
  procedure AssignParamsValues( AParams: TParams );
  procedure AssignParamValueToCol( AParam: TParam; ACol: TIB_Column );
  procedure SysUpdateParams;
  procedure UpdateIndexDefs; override;
{$ENDIF}
  procedure AssignFieldValueToCol( AField: TField; ACol: TIB_Column );
{$IFDEF IBO_VCL50_OR_GREATER}
  { IProviderSupport }
  procedure PSEndTransaction(Commit: Boolean); override;
  procedure PSExecute; override;
  function PSExecuteStatement( const ASQL: string;
                                     AParams: TParams;
                                     ResultSet: Pointer = nil ): Integer;
                                                                       override;
  procedure PSGetAttributes(List: TList); override;
  function PSGetDefaultOrder: TIndexDef; override;
  function PSGetKeyFields: string; override;
  function PSGetParams: TParams; override;
  function PSGetQuoteChar: string; override;
  function PSGetTableName: string; override;
  function PSGetIndexDefs( IndexTypes: TIndexOptions ): TIndexDefs; override;
  function PSGetUpdateException( E: Exception;
                                 Prev: EUpdateError ): EUpdateError; override;
  function PSInTransaction: Boolean; override;
  function PSIsSQLBased: Boolean; override;
  function PSIsSQLSupported: Boolean; override;
  procedure PSReset; override;
  procedure PSSetParams( AParams: TParams ); override;
  procedure PSSetCommandText( const CommandText: string ); override;
  procedure PSStartTransaction; override;
  function PSUpdateRecord( UpdateKind: TUpdateKind;
                           Delta: TDataSet ): Boolean; override;
{$ENDIF}
public
{$IFNDEF HELPSCAN}
{ Overrides }
  constructor Create( AOwner: TComponent ); Override;
  destructor Destroy; override;
{$IFDEF IBO_VCL50_OR_GREATER}
  procedure GetDetailLinkFields( MasterFields, DetailFields: TList ); override;
{$ENDIF}
  procedure ApplyUpdates;
  procedure CancelUpdates;
{: CommitUpdates is for cached updates only. It tells the buffers that the
updates have been committed and so that they now can be moved from the new
buffer to the current buffer slot.}
  procedure CommitUpdates;
  procedure RevertRecord;
  procedure AbortFetching;
  procedure AssignSQLWithSearch( ADataset: TIB_Dataset );
  procedure BeginBusy( Yield: boolean );
  procedure EndBusy;
  procedure BeginCallbackFreeze;
  function BookmarkValid( ABookmark: TBookmark ): Boolean; override;
  function BookmarkAvailable: Boolean; {override}
  function GetBookmark: TBookmark; override;
  function GetBookmarkStr: TBookmarkStr; override;
  function CreateBlobStream( Field: TField;
                             Mode: TBlobStreamMode ): TStream; override;
  function CompareBookmarks( ABookmark1,
                             ABookmark2: TBookmark ): Integer; override;
  procedure EndCallbackFreeze;
  procedure ExecuteImmediate( Statement: string; AParam: PXSQLDA );
  procedure FreeServerResources;
  function FindKey( const KeyValues: array of const ): boolean;
  procedure FindNearest( const KeyValues: array of const );
{$IFDEF IBO_VCL40_OR_GREATER}
  function FindParam( AParamName: string ): TParam;
{$ELSE}
  function FindParam( AParamName: string ): TIB_Column;
{$ENDIF}
  procedure GotoCurrent( ADataset: TDataset );
  function GotoKey: boolean;
  procedure GotoNearest;
  procedure SetKey;
  procedure EditKey;
  procedure ApplyRange;
  procedure CancelRange;
  procedure SetRange(const StartValues, EndValues: array of const);
  procedure SetRangeEnd;
  procedure SetRangeStart;
  procedure EditRangeEnd;
  procedure EditRangeStart;
  function IsSequenced: boolean; override;
{: This method will return a Generator value with a specified increment.}
  function GeneratorValue( AGenerator: string; Increment: integer ): ISC_INT64;
  function GetCurrentRecord( Buffer: PChar ): Boolean; override;
{$IFDEF IBO_VCL50_OR_GREATER}
  function GetFieldData( Field: TField;
                         Buffer: Pointer;
                         NativeFormat: Boolean ): Boolean; override;
  procedure SetFieldData( Field: TField;
                          Buffer: Pointer;
                          NativeFormat: Boolean ); override;
{$ENDIF}
  function GetFieldData( Field: TField; Buffer: Pointer ): boolean; override;
  procedure SetFieldData( Field: TField; Buffer: Pointer ); override;
  function InternalGetFieldData( Field: TField;
                                 Buffer: Pointer ): boolean;
  procedure InternalSetFieldData( Field: TField; Buffer: Pointer ); 
  procedure InvalidateBookmark( ABookmark: TBookmarkStr );
  procedure InvalidateRowNum( ARowNum: longint );
  procedure InvalidateRows;
  procedure RefreshRows;
  procedure RefreshKeys;
  procedure RefreshFilteredRows;
  procedure InvalidateSQL;
  function Locate( const KeyFields: string;
                   const KeyValues: Variant;
                         Options: TLocateOptions ): Boolean; override;
  function Lookup( const KeyFields: string;
                   const KeyValues: Variant;
                   const ResultFields: string ): Variant; override;
{: This function returns the exact record count of the dataset by performing it
on the server using a query if it has to. If all of the records are in the
buffer then it will simply return the number there without making the call to
the server.
<br><br>
If the transaction isolation is tiConcurrency it will cache the record count
value but under tiCommitted it won't since it is possible for the other users
to impact the result at any given time.
<br><br>
Cached updates and filtered records are taken into full consideration as well.}
  function RecordCountAll: longint;
{: Redefinition of the inherited Resync() method to adjust internal flags.}  
  procedure Resync( Mode: TResyncMode ); override;
{ Methods }
  procedure ExecSQL;
  procedure FetchAll;
  procedure Prepare;
  procedure Unprepare;
  function ParamByName( AParam: string ): TIB_Column;
  procedure Post; override;
  procedure Cancel; override;
{ Properties }
  property CallbackInitTick: DWORD read GetCallbackInitTick;
  property CallbackRefreshTick: DWORD read GetCallbackRefreshTick
                                      write SetCallbackRefreshTick;
  property CheckRequired: boolean read GetCheckRequired
                                  write SetCheckRequired
                                  default true;
  property ColumnAttributes: TIB_StringList read GetColumnAttributes
                                            write SetColumnAttributes;
  property DatabaseName: string read GetDatabaseName write SetDatabaseName;
  property DataSource read GetDataSource write SetDataSource;
  property IB_Session: TIB_Session read GetIB_Session;
{$IFDEF IBO_VCL40_OR_GREATER}
  property FieldDefs stored IsFieldDefsStored;
  property IndexDefs: TIndexDefs read FIndexDefs
                                 write SetIndexDefs
                                 stored IsIndexDefsStored;
  property StoreDefs: boolean read FStoreDefs write FStoreDefs default false;
{$ENDIF}
  property IsPosting: boolean read FIsPosting;
  property IsClosing: boolean read FIsClosing;
  property IsSelectSQL: boolean read GetIsSelectSQL;
  property JoinLinks: TIB_StringList read GetJoinLinks write SetJoinLinks;
  property KeyFields: TIB_Row read GetKeyFields;
  property KeyLinks: TIB_StringList read GetKeyLinks
                                    write SetKeyLinks
                                    stored IsKeyLinksStored;
  property KeyLinksAutoDefine: boolean read GetKeyLinksAutoDefine
                                       write SetKeyLinksAutoDefine
                                       default true;
  property KeyRelation: string read GetKeyRelation write SetKeyRelation;
  property OrderingItemNo: integer read GetOrderingItemNo
                                   write SetOrderingItemNo
                                   default 0;
  property OrderingItems: TIB_StringList read GetOrderingItems
                                         write SetOrderingItems;
  property OrderingLinks: TIB_StringList read GetOrderingLinks
                                         write SetOrderingLinks;
  property RowsAffected: longint read GetRowsAffected;
  Property ServerSQL: string read GetServerSQL;
{$IFDEF IBO_VCL40_OR_GREATER}
  property Params: TParams read GetParams write SetParams;
{$ELSE}
  property Params: TIB_Row read GetParams write SetParams;
{$ENDIF}
  property Plan: string read GetPlan;
  property StatementType: TIB_StatementType read GetStatementType;
  property IndexFieldCount: integer read GetIndexFieldCount;
  property IndexFields[Index: integer]: TField read GetIndexField
                                               write SetIndexField;
  property InternalDataset: TIBOInternalDataset read FIB_Query;
  property KeyExclusive: boolean read GetKeyExclusive write SetKeyExclusive;
  property KeyFieldCount: integer read GetKeyFieldCount write SetKeyFieldCount;
{ Publishable Properties }
  property AutoFetchAll: boolean read GetAutoFetchAll
                                 write SetAutoFetchAll
                                 default false;
  property BufferSynchroFlags: TIB_BufferSynchroFlagsSet
      read GetBufferSynchroFlags
     write SetBufferSynchroFlags
    default [];
  property CachedUpdates: boolean read GetCachedUpdates
                                  write SetCachedUpdates
                                  default false;
  property CallbackCaption: string read GetCallbackCaption
                                   write SetCallbackCaption;
  property CallbackInc: Integer read GetCallbackInc
                                write SetCallbackInc default -1;
  property CallbackInitInt: DWORD read GetCallbackInitInt
                                  write SetCallbackInitInt
                                  default 3000;
  property CallbackRefreshInt: DWORD read GetCallbackRefreshInt
                                     write SetCallbackRefreshInt
                                     default 250;
  property CommitAction: TIB_CommitAction read GetCommitAction
                                          write SetCommitAction
                                          default caInvalidateCursor;
  property DefaultValues: TIB_StringList read GetDefaultValues
                                         write SetDefaultValues;
  property DeleteSQL: TIB_StringList read GetDeleteSQL write SetDeleteSQL;
  property EditSQL: TIB_StringList read GetEditSQL write SetEditSQL;
  property FetchWholeRows: boolean read GetFetchWholeRows
                                   write SetFetchWholeRows
                                   default true;
  property FieldsAlignment: TIB_StringList read GetFieldsAlignment
                                           write SetFieldsAlignment;
  property FieldsDisplayLabel: TIB_StringList read GetFieldsDisplayLabel
                                              write SetFieldsDisplayLabel;
  property FieldsDisplayFormat: TIB_StringList read GetFieldsDisplayFormat
                                               write SetFieldsDisplayFormat;
  property FieldsReadOnly: TIB_StringList read GetFieldsReadOnly
                                          write SetFieldsReadOnly;
  property FieldsEditMask: TIB_StringList read GetFieldsEditMask
                                          write SetFieldsEditMask;
  property FieldsVisible: TIB_StringList read GetFieldsVisible
                                         write SetFieldsVisible;
  property FieldOptions: TIBOFieldOptions read FFieldOptions write FFieldOptions;
  property ParamCount: integer read GetParamCount;
  property GeneratorLinks: TIB_StringList read GetGeneratorLinks
                                          write SetGeneratorLinks;
  property IB_Transaction: TIB_Transaction read GetTransaction
                                           write SetTransaction
                                           stored IsTransactionStored;
  property IB_Connection: TIB_Connection read GetConnection
                                         write SetConnection
                                         stored IsConnectionStored;
  property InsertSQL: TIB_StringList read GetInsertSQL write SetInsertSQL;
  property LockSQL: TIB_StringList read GetLockSQL write SetLockSQL;
  property MaxRows: integer read GetMaxRows write SetMaxRows default 0;
  property ParamCheck: boolean read GetParamCheck
                               write SetParamCheck
                               default true;
  property PessimisticLocking: boolean read GetPessimisticLocking
                                       write SetPessimisticLocking
                                       default false;
  property Prepared: boolean read GetPrepared
                             write SetPrepared
                             stored IsPreparedStored;
  property ReadOnly: boolean read GetReadOnly write SetReadOnly default false;
{: This property governs the behavior of the RecordCount property as well as
the virtual IsSequenced function's return value.
<br><br>
Setting this to true makes it so that the DBGrid control will avoid using the
RecordCount property when configuring the vertical scrollbar. The reason is
because with InterBase determining an accurate record count can be a very
expensive process. If the dataset is small and you want accurate scrolling with
the DBGrid set the AutoFetchAll property to true. This way the RecordCount
property will be accurate either way.}
  property RecordCountAccurate: boolean read FRecordCountAccurate
                                        write SetRecordCountAccurate;
  property RequestLive: boolean read GetRequestLive
                                write SetRequestLive
                                default false;
  property SQL: TStrings read GetSQL write SetSQL;
  property SQLForUpdate: TStrings read GetSQLForUpdate write SetSQLForUpdate;
  property SQLOrder: TStrings read GetSQLOrder write SetSQLOrder;
  property SQLWhere: TStrings read GetSQLWhere write SetSQLWhere;
  property SQLWhereItems: TStrings read GetSQLWhereItems;
  property Unidirectional: boolean read GetUnidirectional
                                   write SetUnidirectional
                                   default false;
  property UpdatesPending: boolean read GetUpdatesPending;
{$IFDEF IBO_VCL40_OR_GREATER}
  property UpdateObject: TIBOUpdateSQL read FUpdateObject
                                       write SetUpdateObject;
{$ENDIF}
{ Publishable Events }
  property AfterPrepare: TNotifyEvent read FAfterPrepare write FAfterPrepare;
  property BeforePrepare: TNotifyEvent read FBeforePrepare write FBeforePrepare;
  property OnCallback: TIBODatasetFetchCallback read FOnCallback
                                                write FOnCallback;
  property OnError: TIB_ErrorEvent read FOnError write FOnError;
  property OnPrepareSQL: TNotifyEvent read FOnPrepareSQL write FOnPrepareSQL;
{$IFDEF IBO_VCL50_OR_GREATER}
  property OnUpdateError: TUpdateErrorEvent read GetOnUpdateError
                                            write SetOnUpdateError;
  property OnUpdateRecord: TUpdateRecordEvent read GetOnUpdateRecord
                                              write SetOnUpdateRecord;
{$ELSE}
  property OnUpdateError: TIB_UpdateErrorEvent read GetOnUpdateError
                                               write SetOnUpdateError;
  property OnUpdateRecord: TIB_UpdateRecordEvent read GetOnUpdateRecord
                                                 write SetOnUpdateRecord;
{$ENDIF}
{$ENDIF}
{$IFDEF IBO_VCL40_OR_GREATER}
private
  procedure ReadParamData( Reader: TReader );
protected
  procedure DefineProperties( Filer: TFiler ); override;
  function GetParamsCount: word;
public
  property ParamsCount: word read GetParamsCount;
{$ENDIF}
published
{: This is just here for compatibility with BDE stuff.}
  property SessionName: string read FSessionName write FSessionName;
end;

{: This is a custom base class for those who would like to make their own
TQuery-like derivitave of the IBO TQuery derivitave.}
TIBOBaseQuery = class( TIBODataset )
published
  property OrderingItemNo;
  property OrderingItems;
  property OrderingLinks;
  property Params;
end;

{: This is a custom base class for those who would like to make their own
TTable-like derivitave of the IBO TTable derivitave.}
TIBOBaseTable = class( TIBODataset )
private
  FIndexFieldNames: string;
  FIndexName: string;
  FMasterFieldsList: TIB_StringList;
  FAllowHorizontalRefinement: boolean;
  procedure GetExclusive( AReader: TReader );
protected
  procedure DefineProperties( AFiler: TFiler ); override;
{ Property Access Methods }
  function GetExists: boolean;
  function GetMasterFields: string; //~virtual;
  function GetMasterSource: TDataSource; //~virtual;
  function GetTableName: string; //~virtual;
  procedure SetIndexFieldNames( AValue: string ); //~virtual;
  procedure SetIndexName( AValue: string ); //~virtual;
  procedure SetMasterFields( const AValue: string ); //~virtual;
  procedure SetMasterSource( const AValue: TDataSource ); //~virtual;
  procedure SetTableName( AValue: string ); //~virtual;
{ System Methods }
  procedure GetValuesFromMaster; override;
  procedure SysPrepareSQL; override;
  procedure SysSQLChange( Sender: TObject; var Unprepare: boolean ); override;
{$IFDEF IBO_VCL50_OR_GREATER}
  function PSGetDefaultOrder: TIndexDef; override;
{$ENDIF}
  procedure RefreshParam( const AParam: TIB_Column;
                          const ADataset: TDataset ); override;
public
{$IFNDEF HELPSCAN}
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
{$ENDIF}
  procedure AddIndex( const Name, Fields: string;
                            Options: TIndexOptions;
                      const DescFields: string
{$IFDEF IBO_VCL40_OR_GREATER}
  = ''
{$ENDIF}
                       );
{: This method is still work in progress.}
  procedure CreateTable;
{: Call this method to drop an index from the database.}
  procedure DeleteIndex( const Name: string );
{: Call this method to drop a table from the database.
<br><br>
You need to make sure that all dependancies are removed prior to attempting
this or else and exception will be raised.}
  procedure DeleteTable;
{: This method will delete all the records in the table.}
  procedure EmptyTable;
{: This property tells whether or not the specified table exists in the
database.}
  property Exists: boolean read GetExists;

{$IFNDEF HELPSCAN}
  property DataSource stored false;
  property RequestLive default true;
{$ENDIF}
{: This property is used to specify which columns will be used in the ORDER BY
clause of the select statement that is sent to the server for this table.}
  property IndexFieldNames: string read FIndexFieldNames
                                   write SetIndexFieldNames;
{: This property is currently unsupported. Please use IndexFieldNames instead.}
  property IndexName: string read FIndexName write SetIndexName;
{: This property is used to tell which columns are used to form a master-detail
relationship between two datasets.}
  property MasterFields: string read GetMasterFields write SetMasterFields;
{: This is a reference to another dataset that is to be used in a master-detail
relationship.}
  property MasterSource: TDataSource read GetMasterSource
                                     write SetMasterSource;
{: This property makes it so that IBO will not use the specialized dataset
refinement mode which virtualizes huge tables into small windows of data.}
  property AllowHorizontalRefinement: boolean read FAllowHorizontalRefinement
                                              write FAllowHorizontalRefinement
                                              default true;
{: The name of the table that is to be used by this component.}
  property TableName: string read GetTableName write SetTableName;
end;

{: This component is designed to emulate the complete behavior of the BDE's
TQuery component.
<br><br>
It is important to note that Delphi 3 does not make use of TParams for its input
parameters but instead uses the native TIB_Row class. It emulates the TParams
class quite a bit however so there should be few problems when converting.
Otherwise, I use the TParams for input parameters and IBO still automatically
generates them for you. Once prepared the data type is filled in for each one
as well.}
TIBOQuery = class(TIBOBaseQuery)
{$IFNDEF HELPSCAN}
{$I IBODataset.PBL}
published
{ Properties }
  property Constraints stored IsConstraintsStored;
  property DataSource;
  property JoinLinks;
  property KeyRelation;
  property ParamCheck;
  property Params;
  property RequestLive;
  property SQL;
  property FieldOptions;
{$ENDIF}
end;

{: This is IBO's TTable equivalent component. 100% of TTable's
functionality is now supported. Please refer to the VCL or the native IBO
dataset help for how to use the properties, etc. of this class.}
TIBOTable = class(TIBOBaseTable)
{$IFNDEF HELPSCAN}
{$I IBODataset.PBL}
published
{ Properties }
  property AllowHorizontalRefinement;
  property IndexFieldNames;
  property IndexName;
  property MasterFields;
  property MasterSource;
  property SQLForUpdate;
  property SQLWhere;
  property TableName;
  property FieldOptions;
{$IFDEF IBO_VCL40_OR_GREATER}
  property FieldDefs;
  property IndexDefs;
  property StoreDefs;
{$ENDIF}
{$ENDIF}
end;

{$IFDEF IBO_VCL40_OR_GREATER}

{: This is the equivalent of the TStoredProc component specialized for
using it with InterBase<br><br>
For the time being it does not support select procedures. Use a TIBOQuery
for now.}
TIBOStoredProc = class(TIBODataset)
private
  FStoredProcName: string;
  function GetStoredProcHasDML: boolean;
  procedure SetStoredProcHasDML( AValue: boolean );
protected
{$IFDEF IBO_VCL50_OR_GREATER}
  { IProviderSupport }
  procedure PSExecute; override;
  function PSGetTableName: string; override;
  function PSGetParams: TParams; override;
  procedure PSSetCommandText( const CommandText: string ); override;
{$ENDIF}  
protected
  function GetParamsCount: word;
  procedure SetStoredProcName( const Value: string );
  procedure SysPrepareSQL; override;
public
  constructor Create( AOwner: TComponent ); override;
  procedure CopyParams( Value: TParams );
  procedure ExecProc;
  function ParamByName( const Value: string ): TParam;
  property AutoFetchAll default true;
published
  property Params;
  property StoredProcHasDML: boolean read GetStoredProcHasDML
                                     write SetStoredProcHasDML;
  property StoredProcName: string read FStoredProcName
                                  write SetStoredProcName;

{ Inherited properties and events}
  property Active;
//  property AutoCalcFields;
//  property AutoFetchAll;
//  property CachedUpdates;
  property ColumnAttributes;
  property DatabaseName;
//  property DefaultValues;
//  property DeleteSQL;
//  property EditSQL;
//  property Filter;
//  property Filtered;
//  property FilterOptions;
//  property GeneratorLinks;
  property IB_Connection;
  property IB_Transaction;
//  property InsertSQL;
//  property MaxRows;
//  property ReadOnly;
  property Prepared;
//  property UpdateObject;

{ Events from IBO }
  property OnError;

{ Events from the VCL }
  property BeforeCancel;
  property AfterCancel;
  property BeforeClose;
  property AfterClose;
  property BeforeEdit;
  property AfterEdit;
  property BeforeDelete;
  property AfterDelete;
  property BeforeInsert;
  property AfterInsert;
  property BeforeOpen;
  property AfterOpen;
  property BeforeScroll;
  property AfterScroll;
  property BeforePost;
  property AfterPost;
  property AfterPrepare;
  property BeforePrepare;
  property OnCalcFields;
  property OnFilterRecord;
  property OnNewRecord;
  property OnUpdateError;
  property OnUpdateRecord;
{$IFDEF IBO_VCL40_OR_GREATER}
  property OnPostError;
  property OnDeleteError;
  property OnEditError;
{$IFDEF IBO_VCL50_OR_GREATER}
  property BeforeRefresh;
  property AfterRefresh;
{$ENDIF}
{$ENDIF}
end;
{$ENDIF}

{$IFDEF IBO_VCL40_OR_GREATER}

{ TIBOUpdateSQL }

TIBOUpdateSQL = class(TIB_Component)
private
  FDataSet: TIBODataset;
  FQueries: array[TUpdateKind] of TIBODataset;
  FSQLText: array[TUpdateKind] of TStrings;
  function GetQuery( UpdateKind: TUpdateKind ): TIBODataset;
  function GetSQLIndex( Index: Integer ): TStrings;
  procedure SetSQL( UpdateKind: TUpdateKind; Value: TStrings );
  procedure SetSQLIndex( Index: Integer; Value: TStrings );
protected
  procedure Notification( AComponent: TComponent;
                          Operation: TOperation ); override;
  function GetSQL( UpdateKind: TUpdateKind ): TStrings;
  procedure SQLChanged( Sender: TObject );
public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
  procedure Apply( UpdateKind: TUpdateKind );
  procedure ExecSQL( UpdateKind: TUpdateKind );
  procedure SetParams( UpdateKind: TUpdateKind );
  procedure Unprepare;
  property DataSet: TIBODataset read FDataSet;
  property Query[UpdateKind: TUpdateKind]: TIBODataset read GetQuery;
  property SQL[UpdateKind: TUpdateKind]: TStrings read GetSQL write SetSQL;
published
  property ModifySQL: TStrings index 0 read GetSQLIndex
                                       write SetSQLIndex;
  property InsertSQL: TStrings index 1 read GetSQLIndex
                                       write SetSQLIndex;
  property DeleteSQL: TStrings index 2 read GetSQLIndex
                                       write SetSQLIndex;
end;

{$ENDIF}

implementation

uses
  DBConsts,
{$IFDEF IBO_VCL60_OR_GREATER}
  FmtBcd,
{$ENDIF}
  IB_Utils, IB_Parse, IB_Schema, IBD_Error,
  IB_NodeList;

{------------------------------------------------------------------------------}

constructor TIBODatabase.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  inherited PasswordStorage := psNotSecure;
end;

procedure TIBODatabase.ApplyUpdates( const ADatasets: array of TIBODataset );
var
  ii: integer;
  tmpDataset: TIB_BDataset;
begin
  if TransactionState = tsActive then
    raise EIB_TransactionError.Create( E_Transaction_Is_Active );
  try
    BeginBusy( true );
    StartTransaction;
    try
      if ( High( ADatasets ) < 0 ) or ( ADatasets[0] = nil ) then
        for ii := 0 to DatasetCount - 1 do
        begin
          if (Datasets[ ii ] is TIB_BDataset) then
            (Datasets[ ii ] as TIB_BDataset).ApplyUpdates;
        end
      else
        for ii := 0 to High( ADatasets ) do
        begin
          tmpDataset := ADatasets[ii].InternalDataset;
          if tmpDataset.IB_Transaction <> Self.IB_Transaction then
            raise EIB_TransactionError.Create( Format( E_UpdateWrongTrn,
                                                       [tmpDataset.Name, Name]));
          ADatasets[ii].ApplyUpdates;
        end;
      Commit;
    except
      Rollback;
      raise;
    end;
      if ( High( ADatasets ) < 0 ) or
         ( ADatasets[0] = nil ) then for ii := 0 to DatasetCount - 1 do
    begin
      if Datasets[ ii ] is TIB_BDataset then
        (Datasets[ ii ] as TIB_BDataset).CommitUpdates;
    end
    else
    for ii := 0 to High( ADatasets ) do
      ADatasets[ii].CommitUpdates;
  finally
    EndBusy;
  end;
end;

procedure TIBODatabase.CancelUpdates( const ADatasets: array of TIBODataset );
var
  ii: Integer;
  tmpDataset: TIB_BDataset;
begin
  if ( High( ADatasets ) < 0 ) or
     ( ADatasets[0] = nil ) then for ii := 0 to DatasetCount - 1 do
  begin
    if Datasets[ ii ] is TIB_BDataset then
      (Datasets[ ii ] as TIB_BDataset).CancelUpdates;
  end
  else
  for ii := 0 to High( ADatasets ) do
  begin
    tmpDataset := ADatasets[ii].InternalDataset;
    if tmpDataset.IB_Transaction <> Self.IB_Transaction then
      raise EIB_TransactionError.Create( Format( E_UpdateWrongTrn,
                                                 [ tmpDataset.Name, Name ]));
    ADatasets[ii].CancelUpdates;
  end;
end;

procedure TIBOTransaction.ApplyUpdates( const ADatasets: array of TIBODataset );
var
  ii: integer;
  tmpDataset: TIB_BDataset;
begin
  if TransactionState = tsActive then
    raise EIB_TransactionError.Create( E_Transaction_Is_Active );
  try
    BeginBusy( true );
    StartTransaction;
    try
      if ( High( ADatasets ) < 0 ) or ( ADatasets[0] = nil ) then
        for ii := 0 to DatasetCount - 1 do
        begin
          if (Datasets[ ii ] is TIB_BDataset) then
            (Datasets[ ii ] as TIB_BDataset).ApplyUpdates;
        end
      else
        for ii := 0 to High( ADatasets ) do
        begin
          tmpDataset := ADatasets[ii].InternalDataset;
          if tmpDataset.IB_Transaction <> Self then
            raise EIB_TransactionError.Create( Format( E_UpdateWrongTrn,
                                                      [tmpDataset.Name, Name]));
          ADatasets[ii].ApplyUpdates;
        end;
      Commit;
    except
      Rollback;
      raise;
    end;
      if ( High( ADatasets ) < 0 ) or
         ( ADatasets[0] = nil ) then for ii := 0 to DatasetCount - 1 do
    begin
      if Datasets[ ii ] is TIB_BDataset then
        (Datasets[ ii ] as TIB_BDataset).CommitUpdates;
    end
    else
    for ii := 0 to High( ADatasets ) do
      ADatasets[ii].CommitUpdates;
  finally
    EndBusy;
  end;
end;

procedure TIBOTransaction.CancelUpdates(const ADatasets: array of TIBODataset);
var
  ii: Integer;
  tmpDataset: TIB_BDataset;
begin
  if ( High( ADatasets ) < 0 ) or
     ( ADatasets[0] = nil ) then for ii := 0 to DatasetCount - 1 do
  begin
    if Datasets[ ii ] is TIB_BDataset then
      (Datasets[ ii ] as TIB_BDataset).CancelUpdates;
  end
  else
  for ii := 0 to High( ADatasets ) do
  begin
    tmpDataset := ADatasets[ii].InternalDataset;
    if tmpDataset.IB_Transaction <> Self then
      raise EIB_TransactionError.Create( Format( E_UpdateWrongTrn,
                                                 [ tmpDataset.Name, Name ]));
    ADatasets[ii].CancelUpdates;
  end;
end;

constructor TIBOBaseTable.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  inherited RequestLive := true;
  FMasterFieldsList := TIB_StringList.Create;
  FAllowHorizontalRefinement := true;
end;

destructor TIBOBaseTable.Destroy;
begin
  inherited Destroy;
  FMasterFieldsList.Free;
  FMasterFieldsList := nil;
end;

procedure TIBOBaseTable.AddIndex( const Name, Fields: string;
                                        Options: TIndexOptions;
                                  const DescFields: string );
var
  FldList: string;
  IndName, TblName: string;
  CISQL: string;
begin
  if not Assigned( IB_Connection ) then
    raise Exception.Create( 'IB_Connection must be assigned' );
  FldList := IB_Connection.mkFldLst( Fields );
  IndName := Name;
  TblName := TableName;
  if ixPrimary in Options then begin
    CISQL := 'ALTER TABLE ' + TblName + #13#10 +
             '  ADD CONSTRAINT ' + IndName + #13#10 +
             '  PRIMARY KEY ( ' + FldList + ' )';
  end else begin
    if [ ixUnique, ixDescending ] * Options = [ ixUnique,
                                                ixDescending ] then begin
      CISQL := 'CREATE UNIQUE DESCENDING INDEX ' + IndName;
    end else if ixUnique in Options then begin
      CISQL := 'CREATE UNIQUE INDEX ' + IndName;
    end else if ixDescending in Options then begin
      CISQL := 'CREATE DESCENDING INDEX ' + IndName;
    end else begin
      CISQL := 'CREATE INDEX ' + IndName;
    end;
    CISQL := CISQL + #13#10 + '  ON ' + TblName + ' ( ' + FldList + ' )';
  end;
  InternalDataset.ExecuteDDL( CISQL );
{$IFDEF IBO_VCL40_OR_GREATER}
  IndexDefs.Updated := false;
{$ENDIF}
end;

procedure TIBOBaseTable.CreateTable;
var
  ii: integer;
  Dialect: integer;
  Ident: string;
  SZ: string;
  PR: string;
  CTSQL: string;
  tmpStr: string;
begin
  if not Assigned( IB_Connection ) then
    raise Exception.Create( 'IB_Connection must be assigned' );
  Dialect := IB_Connection.SQLDialect;
  CTSQL := EmptyStr;
  CheckInactive;
  BeginBusy( false );
  try
{$IFDEF IBO_VCL40_OR_GREATER}
    if FieldCount > 0 then
      InitFieldDefsFromFields;
{$ENDIF}
    for ii := 0 to FieldDefs.Count - 1 do
    begin
      if ( ii = 0 ) then
        CTSQL := 'CREATE TABLE ' + TableName + ' ('#13#10'    '
      else
        CTSQL := CTSQL + #13#10'  , ';
      with FieldDefs[ii] do
      begin
        SZ := IntToStr( Size );
        PR := IntToStr( Precision );
        Ident := IB_Connection.mkIdent( Name );
        tmpStr := EmptyStr;
        case DataType of
          ftString: tmpStr := 'VARCHAR( ' + SZ + ' )';
{$IFDEF IBO_VCL40_OR_GREATER}
          ftFixedChar: tmpStr := 'CHAR( ' + SZ + ' )';
{$ENDIF}
          ftBoolean, ftSmallint, ftWord: tmpStr := 'SMALLINT';
          ftAutoInc: tmpStr := 'AUTOINC';
          ftInteger: tmpStr := 'INTEGER';
          ftFloat, ftCurrency: tmpStr := 'DOUBLE PRECISION';
          ftBCD:
          begin
            if Dialect = 1 then
            begin
              if Precision > 9 then
                raise Exception.Create( 'Unsupported field type' );
              if Precision <= 4 then
                Precision := 9;
            end;
            if Precision <= 4 then
              tmpStr := 'DECIMAL( 18, 4 )'
            else
              tmpStr := 'DECIMAL( ' + PR + ', 4 )';
          end;
          ftDate: tmpStr := 'DATE';
          ftTime: tmpStr := 'TIME';
          ftDateTime: if Dialect = 1 then
            tmpStr := 'DATE'
          else
            tmpStr := 'TIMESTAMP';
{$IFDEF IBO_VCL40_OR_GREATER}
          ftLargeInt: if Dialect = 1 then
            raise Exception.Create( 'Unsupported field type' )
          else
            tmpStr := 'DECIMAL( 18, 0 )';
{$ENDIF}
          ftBlob, ftMemo: tmpStr := 'BLOB SUB_TYPE TEXT'; //Get other inf
          ftBytes, ftVarBytes,
          ftGraphic..ftTypedBinary: tmpStr := 'BLOB SUB_TYPE 0'; //Get other inf
          else
            raise Exception.Create( 'Unsupported field type' );
        end;
        CTSQL := CTSQL + IB_Connection.mkIdent( Name ) + ' ' + tmpStr;
{$IFDEF IBO_VCL40_OR_GREATER}
        if faRequired in Attributes then
          CTSQL := CTSQL + ' NOT NULL';
{$ENDIF}
      end;
    end;
    if CTSQL = EmptyStr then
      raise Exception.Create( 'No field definitions to create a table with' )
    else
    begin
{$IFDEF IBO_VCL40_OR_GREATER}
      for ii := 0 to IndexDefs.Count - 1 do
        with IndexDefs[ii] do
          if ixPrimary in Options then
          begin
            Ident := IB_Connection.mkIdent( Name );
            CTSQL := CTSQL + #13#10'  , CONSTRAINT ' +
              Ident +
              ' PRIMARY KEY ( ' + IB_Connection.mkFldLst( Fields ) + ' )';
          end;
{$ENDIF}
      CTSQL := CTSQL + #13#10')';
      InternalDataset.ExecuteDDL( CTSQL );
{$IFDEF IBO_VCL40_OR_GREATER}
      for ii := 0 to IndexDefs.Count - 1 do
        with IndexDefs[ii] do
          if not (ixPrimary in Options) then
            AddIndex( Name, Fields, Options, EmptyStr );
{$ENDIF}
    end;
{$IFDEF IBO_VCL40_OR_GREATER}
    IndexDefs.Updated := false;
{$ENDIF}
  finally
    EndBusy;
  end;
end;

{$IFDEF IBO_VCL40_OR_GREATER}
procedure TIBODataset.UpdateIndexDefs;
var
  Opts: TIndexOptions;
  ii, jj: integer;
  tmpStr: string;
  sl: TIB_StringList;
begin
  if csReading in ComponentState then Exit;
  if not InternalDataset.CheckConnection( false ) then
    raise Exception.Create( 'IB_Connection must be assigned' );
  FieldDefs.Update;
  BeginBusy( false );
  try
    IndexDefs.Clear;
    with IB_Connection.SchemaCache.IndexDefs do
    begin
      for ii := 0 to Count - 1 do
      begin
        if AnsiCompareText( InternalDataset.SysKeyRelation,
                            IndexParamValue[ ii, 'REL' ] ) = 0 then
        begin
          with IndexDefs.AddIndexDef do
          begin
            Name := IndexNames[ ii ];
            Opts := [];
            if IndexParamIsSet[ ii, 'PK' ] then
            begin
              Include( Opts, ixPrimary );
              Include( Opts, ixUnique );
            end
            else
            if IndexParamIsSet[ ii, 'UN' ] then
              Include( Opts, ixUnique );
            if IndexParamIsSet[ ii, 'DESC' ] then
              Include( Opts, ixDescending );
            Options := Opts;
            tmpStr := IndexParamValue[ ii, 'SEGS' ];
            sl := TIB_StringList.Create;
            try
            // I don't seem to have a choice but strip off the quotes here.
            // The way the VCL handles FieldName contents prevents the full
            // usage of InterBase delimited identifiers which may include
            // some of these delimiter characters in the identifier name.
              jj := getLitSafePos( ',', tmpStr, 1 );
              while jj > 0 do
              begin
                sl.Add( stLitCriteria( Copy( tmpStr, 1, jj - 1 )));
                System.Delete( tmpStr, 1, jj );
                jj := getLitSafePos( ',', tmpStr, 1 );
              end;
              if ( tmpStr <> '' ) then
                sl.Add( stLitCriteria( tmpStr ));
              tmpStr := '';
              for jj := 0 to sl.Count - 1 do
              begin
                if jj > 0 then
                  tmpStr := tmpStr + ';';
                tmpStr := tmpStr + sl[jj];
              end;
              Fields := tmpStr;
              if ixDescending in Opts then
                DescFields := tmpStr;
            finally
              sl.Free;
            end;
          end;
        end;
      end;
    end;
{$IFDEF IBO_VCL40_OR_GREATER}
    IndexDefs.Updated := true;
{$ENDIF}
  finally
    EndBusy;
  end;
end;
{$ENDIF}

procedure TIBOBaseTable.DeleteIndex( const Name: string );
begin
  BeginBusy( false );
  try
    with InternalDataset do
      if CheckConnection( true ) then
        ExecuteDDL( 'DROP INDEX ' + Name );
{$IFDEF IBO_VCL40_OR_GREATER}
    IndexDefs.Updated := false;
{$ENDIF}
  finally
    EndBusy;
  end;
end;

procedure TIBOBaseTable.DeleteTable;
begin
  BeginBusy( false );
  try
    Unprepare;
    with InternalDataset do
      if CheckConnection( true ) then
        ExecuteDDL( 'DROP TABLE ' + TableName );
{$IFDEF IBO_VCL40_OR_GREATER}
    IndexDefs.Updated := false;
{$ENDIF}
  finally
    EndBusy;
  end;
end;

procedure TIBOBaseTable.EmptyTable;
begin
  BeginBusy( false );
  try
    if Active then
      CheckBrowseMode;
    with InternalDataset do
      if CheckConnection( true ) then
        ExecuteImmediate( 'DELETE FROM ' + TableName, nil );
    if Active then
    begin
      InternalRefresh;
      First;
    end;
  finally
    EndBusy;
  end;
end;

function TIBOBaseTable.GetExists: boolean;
var
  PIn_DA,
  PCount_DA: PXSQLDA;
  CountSQL: string;
  nullind: smallint;
  ACnt: integer;
begin
  Result := Active;
  if not Result and ( TableName <> '' ) then
  begin
    InternalDataset.CheckConnection( true );
    CountSQL := 'SELECT cast( COUNT(*) as integer )'#13#10 +
                'FROM RDB$RELATIONS'#13#10 +
                'WHERE RDB$RELATION_NAME = ''' +
                stLitCriteria( TableName ) + '''';
    nullind := 0;
    PIn_DA := nil;
    PCount_DA := AllocMem( XSQLDA_LENGTH( 1 ));
    try
      with PCount_DA^ do
      begin
        version := SQLDA_VERSION1;
        sqln := 1;
        sqld := 1;
        with sqlvar[ 0 ] do
        begin
          sqltype  := SQL_LONG;
          sqlscale := 0;
          sqllen   := 4;
          sqldata  := @ACnt;
          sqlind   := @nullind;
        end;
      end;
      InternalDataset.ExecImmed2( CountSQL, PIn_DA, PCount_DA );
      Result := ACnt = 1;
    finally
      FreeMem( PCount_DA );
    end;
  end;
end;

procedure TIBOBaseTable.RefreshParam( const AParam: TIB_Column;
                                      const ADataset: TDataset );
var
  tmpS: string;
  tmpFld: TField;
begin
  tmpFld := nil;
  if Assigned( ADataset ) then
  begin
    tmpS := FMasterFieldsList.LinkValues[ AParam.FieldName ];
    if ( tmpS <> '' ) then
    begin
      tmpFld := ADataset.FindField( tmpS );
      if Assigned( tmpFld ) then
        AssignFieldValueToCol( tmpFld, AParam );
    end;
  end;
  if not Assigned( tmpFld ) then
    inherited RefreshParam( AParam, ADataset );
end;

{$IFDEF IBO_VCL40_OR_GREATER}
function TIBODataset.IsFieldDefsStored: Boolean;
begin
  Result := StoreDefs and ( FieldDefs.Count > 0 );
end;

function TIBODataset.IsIndexDefsStored: Boolean;
begin
  Result := StoreDefs and ( IndexDefs.Count > 0 );
end;
{$ENDIF}

function TIBOBaseTable.GetTableName: string;
begin
  Result := InternalDataset.KeyRelation;
end;

function CheckTableNameDialectCase( const AValue: string;
                                          SQLDialect: smallint ): string;
var Quoted:boolean;
    tmpStr:String;
begin
  Result := AValue;
  if ( AValue <> '' ) and ( SQLDialect = 3 ) then
  begin
    Quoted := (AValue[1]='"') and (AValue[Length(AValue)]='"');
    if Quoted then
    begin
      tmpStr := AValue;
      System.delete(tmpStr,1,1);
      System.delete(tmpStr,Length(tmpStr),1);
      if tmpStr = UpperCase(tmpStr) then
        Result := tmpStr;
    end;
  end;
end;

procedure TIBOBaseTable.SetTableName( AValue: string );
begin
  CheckInactive;
  Unprepare;
  InternalDataset.CheckConnection( false );
  AValue := CheckTableNameDialectCase( AValue, InternalDataset.SQLDialect );
  InternalDataset.SQLSelect.Text := 'SELECT ALL ' + AValue + '.*';
  InternalDataset.SQLFrom.Text := 'FROM ' + AValue;
  KeyRelation := AValue;
{$IFDEF IBO_VCL40_OR_GREATER}
  IndexDefs.Updated := false;
{$ENDIF}
end;

procedure TIBOBaseTable.SysSQLChange( Sender: TObject; var Unprepare: boolean );
var
  tmpStr: string;
begin
  inherited SysSQLChange( Sender, Unprepare ); 
  if ( Sender = InternalDataset.SQL ) or
     ( Sender = InternalDataset.SQLFrom ) then
  begin
    tmpStr := Trim( InternalDataset.SQLFrom.Text );
    InternalDataset.KeyRelation := Trim( Copy( tmpStr, 6, MaxInt ));
{$IFDEF IBO_VCL40_OR_GREATER}
    IndexDefs.Updated := false;
{$ENDIF}
  end;
end;

procedure TIBOBaseTable.SysPrepareSQL;
var
  ii: integer;
  tmpStr1, tmpStr2, tmpStr3: string;
  FIndexFields: TIB_StringProperty;
  dscPos: integer;
  dscFlg: boolean;
  ascfnd, dscfnd: boolean;
begin
  FIndexFields := TIB_StringProperty.Create;
  try
    InternalDataset.KeyRelation := TableName;
    if IndexFieldNames <> '' then
      ExtractFieldsIntoList( IndexFieldNames, FIndexFields )
    else
    if IndexName <> '' then
    begin
      with IB_Connection.SchemaCache.IndexDefs do
      begin
        ii := LinkIndex[ IndexName ];
        if ii >= 0 then
        begin
          if AnsiCompareText( InternalDataset.KeyRelation,
                              IndexParamValue[ ii, 'REL' ] ) = 0 then
            ExtractFieldsIntoList( IndexParamValue[ ii, 'SEGS' ], FIndexFields )
          else
            raise EIB_Error.Create( 'Index: ' + IndexName +
                                    ' is on the wrong table' );
        end
        else
          raise EIB_Error.Create( 'Index: ' + IndexName + ' not found' );
      end;
    end
    else
      IB_Connection.SchemaCache.GetTableKeys( TableName, FIndexFields );
    if FIndexFields.Count = 0 then
    begin
      InternalDataset.OrderingItemNo := 0;
      InternalDataset.OrderingItems.Clear;
      InternalDataset.OrderingLinks.Clear;
    end
    else
    if FIndexFields.Count > 0 then
    begin
      tmpStr1 := 'TABLE ORDER=';
      tmpStr2 := ';';
      dscFlg := false;
      for ii := 0 to FIndexFields.Count - 1 do
      begin
        tmpStr3 := Trim( FIndexFields[ ii ] );
        dscPos := getLitSafeStrPos( ' DESC', tmpStr3, 1 );
        if dscPos > 0 then
          tmpStr3 := Copy( tmpStr3, 1, dscPos - 1 );
        if ii > 0 then
        begin
          tmpStr1 := tmpStr1 + ', ';
          tmpStr2 := tmpStr2 + ', ';
        end
        else
          dscFlg := dscPos > 0;
        if ( dscPos > 0 ) and not dscFlg then
        begin
          tmpStr1 := tmpStr2 + tmpStr3 + ' DESC';
          tmpStr2 := tmpStr1 + tmpStr3;
        end
        else
        begin
          tmpStr1 := tmpStr1 + tmpStr3;
          tmpStr2 := tmpStr2 + tmpStr3 + ' DESC';
        end;
      end;
      InternalDataset.OrderingItems.Text := tmpStr1 + tmpStr2;
      tmpStr1 := '=ITEM=1';
      tmpStr3 := Trim( FIndexFields[0] );
      if not InternalDataset.KeyLinksExist or
         not AllowHorizontalRefinement or
         AutoFetchAll or
         Assigned( MasterSource ) then
      else
      begin
        ascfnd := false;
        dscfnd := false;
        with IB_Connection.SchemaCache.IndexDefs do
          for ii := 0 to Count - 1 do
          begin
            tmpStr2 := IndexParamValue[ ii, 'REL' ];
            if InternalDataset.SysKeyRelation = tmpStr2 then
            begin
              tmpStr2 := IndexParamValue[ ii, 'SEGS' ];
              if ( Pos( tmpStr3, tmpStr2 ) = 1 ) and
                 (( Length( tmpStr3 ) = Length( tmpStr2 )) or
                  ( CharIsDelimiter( tmpStr2[ Length( tmpStr3 ) + 1 ] ))) then
              begin
                if IndexParamIsSet[ ii, 'DESC' ] then
                begin
                  dscfnd := true;
                  if ascfnd then
                    Break;
                end
                else
                begin
                  ascfnd := true;
                  if dscfnd then
                    Break;
                end;
              end;
            end;
          end;
        if ascfnd and dscfnd then
          tmpStr1 := tmpStr1 + ';POS=0';
      end;
      dscPos := getLitSafeStrPos( ' DESC', tmpStr3, 1 );
      if dscPos > 0 then
        tmpStr3 := Copy( tmpStr3, 1, dscPos - 1 );
      InternalDataset.OrderingLinks.Text := tmpStr3 + tmpStr1;
      with IB_Connection.SchemaCache.IndexDefs do
      begin
        ii := LinkIndex[ IndexName ];
        if dscFlg or (( ii >= 0 ) and ( IndexParamIsSet[ ii, 'DESC' ] )) then
          InternalDataset.OrderingItemNo := -1
        else
          InternalDataset.OrderingItemNo := 1;
      end;
    end
    else
    begin
      InternalDataset.OrderingItems.Text := '';
      InternalDataset.OrderingLinks.Text := '';
      InternalDataset.OrderingItemNo := 0;
    end;
    if Assigned( MasterSource ) then
    begin
      for ii := 0 to FMasterFieldsList.Count - 1 do
      begin
        if getLitSafePos( '=', FMasterFieldsList[ii], 1 ) > 0 then
          InternalDataset.SQLWhereItems.Add(
            FMasterFieldsList.IndexNames[ii] + ' = ?' +
            FMasterFieldsList.IndexValues[ii] )
        else
        if FIndexFields.Count > ii then
        begin
          tmpStr3 := Trim( FIndexFields[ ii ] );
          dscPos := getLitSafeStrPos( ' DESC', tmpStr3, 1 );
          if dscPos > 0 then
            tmpStr3 := Copy( tmpStr3, 1, dscPos - 1 );
          InternalDataset.SQLWhereItems.Add( tmpStr3 + ' = ?' +
                                             FMasterFieldsList[ii] );
        end
        else
          InternalDataset.SQLWhereItems.Add( FMasterFieldsList[ii] + ' = ?' +
                                             FMasterFieldsList[ii] );
      end;
    end;
    inherited SysPrepareSQL;
  finally
    FIndexFields.Free;
  end;
end;

function TIBOBaseTable.GetMasterSource: TDataSource;
begin
  Result := DataSource;
end;
function TIBOBaseTable.GetMasterFields: string;
var
  ii: integer;
begin
  Result := '';
  if FMasterFieldsList.Count > 0 then
  begin
    for ii := 0 to FMasterFieldsList.Count - 1 do
      Result := Result + FMasterFieldsList[ii] + ';';
    SetLength( Result, Length( Result ) - 1 );
  end;
end;

procedure TIBOBaseTable.SetIndexFieldNames( AValue: string );
var
  ii: integer;
  tmpList: TIB_StringList;
  oldIndexName: string;
  oldIndexFieldNames: string;
begin
  tmpList := TIB_StringList.Create;
  try
    ExtractFieldsIntoList( AValue, tmpList );
    AValue := '';
    with tmpList do
    begin
      for ii := 0 to Count - 1 do
      begin
        if ii > 0 then
          AValue := AValue + ';';
        AValue := AValue + Trim( Strings[ ii ] );
      end;
    end;
  finally
    tmpList.Free;
  end;
  if IndexFieldNames <> AValue then
  begin
    oldIndexName := IndexName;
    oldIndexFieldNames := IndexFieldNames;
    FIndexName := '';
    FIndexFieldNames := AValue;
    try
      if Prepared then
      begin
        InvalidateSQL;
        if Active then
        begin
          CheckBrowseMode;
          UpdateCursorPos;
          InternalRefresh;
          Resync( [] );
        end
        else
          Prepare;
      end;
    except
      FIndexName := oldIndexName;
      FIndexFieldNames := oldIndexFieldNames;
      raise;
    end;
  end;
end;

procedure TIBOBaseTable.SetIndexName( AValue: string );
var
  oldIndexName: string;
  oldIndexFieldNames: string;
begin
  if IndexName <> AValue then
  begin
    oldIndexName := IndexName;
    oldIndexFieldNames := IndexFieldNames;
    FIndexName := AValue;
    FIndexFieldNames := '';
    try
      if Prepared then
      begin
        InvalidateSQL;
        if Active then
        begin
          CheckBrowseMode;
          UpdateCursorPos;
          InternalRefresh;
          Resync( [] );
        end
        else
          Prepare;
      end;
    except
      FIndexName := oldIndexName;
      FIndexFieldNames := oldIndexFieldNames;
      raise;
    end;
  end;
end;

procedure TIBOBaseTable.SetMasterFields( const AValue: string );
var
  tmpList: TIB_StringList;
begin
  if Trim( MasterFields ) <> Trim( AValue ) then
  begin
    if Assigned( MasterSource ) then CheckInactive;
    tmpList := TIB_StringList.Create;
    try
      ExtractFieldsIntoList( AValue, tmpList );
      FMasterFieldsList.Assign( tmpList );
    finally
      tmpList.Free;
    end;
    FMasterFieldsList.RemoveBlankEntries;
    InvalidateSQL;
  end;
end;

procedure TIBOBaseTable.SetMasterSource( const AValue: TDataSource );
var
  IsActive: Boolean;
begin
  IsActive := Active;
  if DataSource <> AValue then
  begin
    Close;
    DataSource := AValue;
    InvalidateSQL;
    Active := IsActive;
  end;
end;

procedure TIBOBaseTable.GetExclusive( AReader: TReader );
begin
  AReader.ReadBoolean;
end;

procedure TIBOBaseTable.DefineProperties( AFiler: TFiler );
begin
  inherited DefineProperties( AFiler );
  AFiler.DefineProperty( 'Exclusive', GetExclusive, nil, false );
end;

type

TIBOBlobStream = class(TStream)
private
  FDataset: TIBODataset;
  FIB_BlobStream: TIB_BlobStream;
  FField: TBlobField;
  FMode: TBlobStreamMode;
  FModified: boolean;
  FPosition: longint;
  FXSQLVar: XSQLVAR;
  FColumnData: pointer;
  function GetDataLength: integer;
  procedure SetDataLength( AValue: integer );
public
  constructor Create( Field: TBlobField; Mode: TBlobStreamMode );
  destructor Destroy; override;
  function Read( var Buffer; Count: longint ): longint; override;
  function Write( const Buffer; Count: longint ): longint; override;
  function Seek( Offset: longint; Origin: Word ): longint; override;
  property DataLength: integer read GetDataLength write SetDataLength;
end;

{ TIBOBlobStream }

constructor TIBOBlobStream.Create( Field: TBlobField; Mode: TBlobStreamMode );
var
  tmpInt: integer;
  tmpBNode: PIB_BlobNode;
  FBuffer: pointer;
  FCalcBuffer: pointer;
  FNode: PIB_Node;
begin
  FPosition := 0;
  FMode := Mode;
  FField := Field;
  FDataset := FField.Dataset as TIBODataset;
  FIB_BlobStream := nil;
  FColumnData := nil;
  with FDataset do
  if GetActiveRecBuf( FBuffer, FCalcBuffer, FNode ) then
  begin
    tmpBNode := InternalDataset.Fields.GetBlobNode( Field.FieldNo - 1 );
    if Mode <> bmRead then
    begin
      if not (State in dsWriteModes) then
        DatabaseError(SNotEditing);
    end
    else
    if ( State in [ dsOldValue, dsSetKey ] ) or
       ( Assigned( tmpBNode ) and not tmpBNode.BlobChanged ) then
      tmpBNode := nil;
    FXSQLVar := InternalDataset.Fields.PSQLDA.SQLVar[Field.FieldNo - 1];
    tmpInt := longint(FXSQLVar.SQLInd) -
              longint(InternalDataset.Fields.RowBuffer);
    FXSQLVar.SQLInd := pointer( longint(FBuffer) + tmpInt );
    FXSQLVar.SQLData := pointer( longint(FXSQLVar.SQLInd) + SizeOf(smallint) );
    inherited Create;
    case FXSQLVar.SQLType of
      SQL_Blob,
      SQL_Blob_: begin
        if Assigned( FNode ) then
          FIB_BlobStream := TIB_BlobStream.Create( InternalDataset.Fields,
                                                   FXSQLVar,
                                                   Field.FieldNo - 1,
                                                   tmpBNode,
                                                   @FNode.BlobHead,
                                                   TIB_BlobStreamMode( Mode ))
        else
          FIB_BlobStream := TIB_BlobStream.Create( InternalDataset.Fields,
                                                   FXSQLVar,
                                                   Field.FieldNo - 1,
                                                   tmpBNode,
                                                   nil,
                                                   TIB_BlobStreamMode( Mode ));
      end
      else
      begin
        FColumnData := FXSQLVar.SQLData;
        case FXSQLVar.SQLType of
          SQL_Varying,
          SQL_Varying_: Inc( longint(FColumnData), SizeOf( smallint ));
        end;
        if Mode = bmWrite then
        begin
          FXSQLVar.SQLInd^ := IB_Null;
          case FXSQLVar.SQLType of
            SQL_Varying,
            SQL_Varying_: SetDataLength( 0 );
          end;
          FillChar( FColumnData^, FXSQLVar.SQLLen, #0 );
          FModified := true;
          DataLength := 0;
        end;
      end;
    end;
  end;
end;

destructor TIBOBlobStream.Destroy;
begin
  if Assigned( FIB_BlobStream ) then
  begin
    FModified := FIB_BlobStream.Modified;
    FIB_BlobStream.Free;
    FIB_BlobStream := nil;
  end;
  if FModified then
  begin
    FField.Modified := true;
    with FDataset do
    try
      if not (State in [dsCalcFields, dsFilter, dsNewValue]) then
      begin
        SetModified( true );
        DataEvent( deFieldChange, longint(FField));
      end;
    except
      Application.HandleException( Self );
    end;
  end;
  inherited Destroy;
end;

function TIBOBlobStream.Read( var Buffer; Count: longint ): longint;
begin
  if Assigned( FIB_BlobStream ) then
    Result := FIB_BlobStream.Read( Buffer, Count )
  else
  if Assigned( FColumnData ) then
  begin
    if Count > DataLength - FPosition then
      Result := DataLength - FPosition
    else
      Result := Count;
    if Result > 0 then
    begin
      Move( pointer(longint(FColumnData) + FPosition)^ , Buffer, Result );
      Inc( FPosition, Result );
    end
    else
      Result := 0;
  end
  else
    Result := 0;
end;

function TIBOBlobStream.Seek( Offset: longint; Origin: Word ): longint;
begin
  if Assigned( FIB_BlobStream ) then
    Result := FIB_BlobStream.Seek( Offset, Origin )
  else
  if Assigned( FColumnData ) then
  begin
    case Origin of
      0: FPosition := Offset;
      1: Inc( FPosition, Offset );
      2: FPosition := DataLength + Offset;
    end;
    if FPosition < 0 then
      FPosition := 0
    else
    if FPosition > DataLength then
      FPosition := DataLength;
    Result := FPosition;
  end
  else
    Result := 0;
end;

function TIBOBlobStream.Write( const Buffer; Count: longint ): longint;
begin
  Result := 0;
  if Assigned( FIB_BlobStream ) then
    Result := FIB_BlobStream.Write( Buffer, Count )
  else
  if ( FMode <> bmRead ) and Assigned( FColumnData ) then
  begin
    if FPosition + Count > FXSQLVar.SQLLen then
      Count := FXSQLVar.SQLLen - FPosition;
    Move( Buffer, pointer(longint(FColumnData) + FPosition)^, Count );
    Inc( FPosition, Count );
    Result := Count;
    if FPosition > DataLength then
      DataLength := FPosition;
    FModified := True;
    FXSQLVar.SQLInd^ := IB_NotNull;
  end;
end;

function TIBOBlobStream.GetDataLength: integer;
begin
  case FXSQLVar.SQLType of
    SQL_Varying,
    SQL_Varying_: if FXSQLVar.SQLInd^ = IB_Null then
      Result := 0
    else
    with PSQL_VARCHAR( FXSQLVar.SQLData )^ do
      Result := vary_len_low + vary_len_high * 256
    else
      Result := FXSQLVar.SQLLen;
  end;
end;

procedure TIBOBlobStream.SetDataLength( AValue: integer );
begin
  case FXSQLVar.SQLType of
    SQL_Varying,
    SQL_Varying_:
    begin
      if AValue > FXSQLVar.SQLLen then
        AValue := FXSQLVar.SQLLen;
      with PSQL_VARCHAR( FXSQLVar.SQLData )^ do
      begin
        vary_len_high := AValue div 256;
        vary_len_low := AValue mod 256;
      end;
    end;
  end;
end;

{ TIBOQueryDataLink }

type
{$IFDEF IBO_VCL40_OR_GREATER}
  TIBOQueryDataLink = class( TDetailDataLink )
{$ELSE}
  TIBOQueryDataLink = class( TDataLink )
{$ENDIF}
  private
    FIBDataset: TIBODataset;
  protected
    procedure ActiveChanged; override;
    procedure RecordChanged(Field: TField); override;
{$IFDEF IBO_VCL40_OR_GREATER}
    function GetDetailDataSet: TDataSet; override;
{$ENDIF}
    procedure CheckBrowseMode; override;
  public
    constructor Create(AQuery: TIBODataset);
  end;

constructor TIBOQueryDataLink.Create(AQuery: TIBODataset);
begin
  inherited Create;
  FIBDataset := AQuery;
end;

procedure TIBOQueryDataLink.ActiveChanged;
begin
  FIBDataset.RefreshParams( true );
end;

procedure TIBOQueryDataLink.RecordChanged(Field: TField);
begin
  if ( Field = nil ) or Assigned( FIBDataset.FindParam( Field.FieldName )) then
    FIBDataset.RefreshParams( true );
end;

{$IFDEF IBO_VCL40_OR_GREATER}
function TIBOQueryDataLink.GetDetailDataSet: TDataSet;
begin
  Result := FIBDataset;
end;
{$ENDIF}

procedure TIBOQueryDataLink.CheckBrowseMode;
begin
  if Dataset.State <> dsInsert then
    if FIBDataset.Active then
      FIBDataset.CheckBrowseMode;
end;

{------------------------------------------------------------------------------}

procedure GetDataTypeAndSize(     ACol: TIB_Column;
                              var NewDataType: TFieldType;
                              var NewDataSize: integer;
                              var BoolList: boolean );
begin
  NewDataType := ftUnknown;
  NewDataSize := 0;
  if Assigned( ACol ) then
  with ACol do
  begin
    if ( SQLtype = SQL_BOOLEAN ) or
       ( SQLtype = SQL_BOOLEAN_ ) then
      NewDataType := ftBoolean
    else
    if IsBoolean and
       (((( SQLtype = SQL_SHORT ) or
          ( SQLtype = SQL_SHORT_ ) or
          ( SQLtype = SQL_LONG ) or
          ( SQLtype = SQL_LONG_ ) or
          ( SQLtype = SQL_QUAD ) or
          ( SQLtype = SQL_QUAD_ ) or
          ( SQLtype = SQL_INT64 ) or
          ( SQLtype = SQL_INT64_ ) or
          ( SQLtype = SQL_FLOAT ) or
          ( SQLtype = SQL_FLOAT_ ) or
          ( SQLtype = SQL_DOUBLE ) or
          ( SQLtype = SQL_DOUBLE_ )) and ( BooleanTrue = BoolTrueNbr ) and
                                         ( BooleanFalse = BoolFalseNbr ) and
                                         ( SQLScale = 0 )) or
        ( SQLtype = SQL_TEXT ) or
        ( SQLtype = SQL_TEXT_ ) or
        ( SQLtype = SQL_VARYING ) or
        ( SQLtype = SQL_VARYING_ )) then
    begin
      NewDataType := ftBoolean;
      BoolList := BoolList or
                  ( ACol.BooleanTrue <> BoolTrueChr ) or
                  ( ACol.BooleanFalse <> BoolFalseChr ) or
                  ( SQLLen <> 1 );
    end
    else
    if SQLScale <> 0 then
    begin
      NewDataType := ftFloat;
      case SQLType of
        SQL_FLOAT,
        SQL_FLOAT_,
        SQL_DOUBLE,
        SQL_DOUBLE_: ;
        else
        if IsCurrencyDataType then
        begin
          NewDataType := ftBCD;
          NewDataSize := -SQLScale;
        end;
      end;
    end
    else
    case SQLtype of
      SQL_FLOAT,
      SQL_FLOAT_,
      SQL_DOUBLE,
      SQL_DOUBLE_: NewDataType := ftFloat;
      SQL_SHORT,
      SQL_SHORT_: NewDataType := ftSmallint;
      SQL_LONG,
      SQL_LONG_: NewDataType := ftInteger;
      SQL_QUAD,
      SQL_QUAD_,
      SQL_INT64,
      SQL_INT64_: begin
{$IFDEF IBO_VCL40_OR_GREATER}
        NewDataType := ftLargeInt;
{$ELSE}
        NewDataType := ftFloat;
{$ENDIF}
      end;
      SQL_TIMESTAMP,
      SQL_TIMESTAMP_: NewDataType := ftDateTime;
      SQL_TYPE_TIME,
      SQL_TYPE_TIME_: NewDataType := ftTime;
      SQL_TYPE_DATE,
      SQL_TYPE_DATE_: NewDataType := ftDate;
      SQL_TEXT,
      SQL_TEXT_,
      SQL_VARYING,
      SQL_VARYING_: if ( SQLName = IB_DB_KEY ) or
                       ( SQLName = IB_RDB + IB_DB_KEY ) then
      begin
        NewDataType := ftBytes;
        NewDataSize := SQLLen;
      end
      else
      //Hans if SQLLen >= 256 then
      if SQLLen > MaximumStringSize then
        NewDataType := ftMemo
      else
      begin
        NewDataType := ftString;
        NewDataSize := SQLLen;
        // The vcl complains about zero length strings...
        if NewDataSize = 0 then
          NewDataSize := 1;
      end;
      SQL_BLOB,
      SQL_BLOB_: begin
        NewDataSize := 8;
        if sqlsubtype = 1 then
          NewDataType := ftMemo
        else
          NewDataType := ftBlob;
      end;
      SQL_ARRAY,
      SQL_ARRAY_: begin
        NewDataSize := 8;
        NewDataType := ftBytes;
      end;
    end;
    if ( NewDataType = ftFloat ) and IsAttributeSet[ 'BCD' ] then
    begin
      NewDataType := ftBCD;
      NewDataSize := -SQLScale;
    end;
  end;
end;

procedure TIBODataset.InternalInitFieldDefs;
var
  ii, jj: integer;
  tmpCol: TIB_Column;
  NewType: TFieldType;
  NewSize: integer;
{$IFDEF IBO_VCL40_OR_GREATER}
  IsHidden: boolean;
{$ENDIF}
{$IFDEF IBO_VCL35_OR_GREATER}
  NewFieldDef: TFieldDef;
{$ENDIF}
begin
  if not Prepared then
  begin
    InternalDataset.Prepare;
    if not Prepared then
      DatabaseError( 'Unable to prepare statement' );
  end;
  if ( not InternalDataset.IsSelectSQL ) and
     ( not ( InternalDataset.StatementType = stExecProcedure )) then
    DatabaseError( 'Error Creating cursor handle' );
{$IFDEF IBO_VCL35_OR_GREATER}
  FieldDefs.BeginUpdate;
  try
{$ENDIF}
    FieldDefs.Clear;
    for ii := 0 to InternalDataset.FieldCount - 1 do
    begin
      if ii >= InternalDataset.Fields.PSQLDA.sqld then
        jj := - ii + InternalDataset.Fields.PSQLDA.sqld - 1
      else
        jj := ii;
      tmpCol := InternalDataset.Fields.BySQLNo( jj );
      GetDataTypeAndSize( tmpCol,
                          NewType,
                          NewSize,
                          FBoolList );
      with tmpCol do
      begin
{$IFDEF IBO_VCL40_OR_GREATER}
        IsHidden :=  (( SQLtype = SQL_TEXT ) or
                      ( SQLtype = SQL_TEXT_ ) or
                      ( SQLtype = SQL_VARYING ) or
                      ( SQLtype = SQL_VARYING_ )) and
                     (( SQLName = IB_DB_KEY ) or
                      ( SQLName = IB_RDB + IB_DB_KEY )) and
                     ( InternalDataset.KeyLinksAutoDefined and
                       InternalDataset.KeyLinksAreDBKEY );
{$ENDIF}
{$IFDEF IBO_VCL35}
        NewFieldDef := TFieldDef.Create( FieldDefs );
        NewFieldDef.Name := BDEFieldName;
        NewFieldDef.DataType := NewType;
        NewFieldDef.Size := NewSize;
        NewFieldDef.Required := Required and not IsDefaulted;
        NewFieldDef.FieldNo := FieldNo + 1;
{$ELSE}
  {$IFDEF IBO_VCL40_OR_GREATER}
        NewFieldDef :=
  {$ENDIF}
          TFieldDef.Create( FieldDefs,
                            BDEFieldName,
                            NewType,
                            NewSize,
                            Required and not IsDefaulted,
                            FieldNo + 1 );
{$ENDIF}
{$IFDEF IBO_VCL40_OR_GREATER}
        if IsHidden then
          NewFieldDef.Attributes := NewFieldDef.Attributes + [ faHiddenCol ];
        if ( Required or not IsNullable ) and not IsDefaulted then
          NewFieldDef.Attributes := NewFieldDef.Attributes + [ faRequired ];
        if IsCalculated or Computed then
          NewFieldDef.Attributes := NewFieldDef.Attributes + [ faReadOnly ];
{$ENDIF}
      end;
    end;
{$IFDEF IBO_VCL35_OR_GREATER}
  finally
    FieldDefs.EndUpdate;
  end;
{$ENDIF}
end;

{$IFDEF IBO_VCL40_OR_GREATER}
procedure TIBODataset.InternalInitParamDefs;
var
  ii: integer;
  tmpPrm: TIB_Column;
  tmpFld: TIB_Column;
  tmpBool: boolean;
  PrmType: TFieldType;
  FldType: TFieldType;
  PrmSize: integer;
  FldSize: integer;
  OldVal: variant;
  inCnt: integer;
  tmpParam: TParam;
begin
  Params.BeginUpdate;
  try
    inCnt := 0;
    for ii := 0 to Params.Count - 1 do
    begin
      if Params[ii].ParamType in [ ptUnknown,
                                   ptInput,
                                   ptInputOutput ] then
      begin
        tmpPrm := InternalDataset.FindParam( Params[ii].Name );
        GetDataTypeAndSize( tmpPrm, PrmType, PrmSize, tmpBool );
        tmpFld := InternalDataset.FindField( Params[ii].Name );
        GetDataTypeAndSize( tmpFld, FldType, FldSize, tmpBool );
        try
          if Assigned( tmpPrm ) and
             Assigned( tmpFld ) and
             ( InternalDataset.StatementType = stExecProcedure ) then
          begin
            Inc( inCnt );
            Params[ii].ParamType := ptInputOutput;
          end
          else
          if Assigned( tmpPrm ) then
          begin
            Inc( inCnt );
            Params[ii].ParamType := ptInput;
          end
          else
          if Assigned( tmpFld ) then
            Params[ii].ParamType := ptOutput
          else
            Params[ii].ParamType := ptUnknown;
          if Assigned( tmpPrm ) then
          begin
            if ( PrmType = ftUnknown ) and
               ( Params[ii].ParamType = ptInputOutput ) then
              PrmType := FldType;
            if PrmType = ftUnknown then
              Params[ii].ParamType := ptUnknown
            else
            begin
              try
                OldVal := Params[ii].Value;
                Params[ii].DataType := PrmType;
                Params[ii].Value := OldVal;
              except
              end;
            end;
          end;
        except
          Application.HandleException( Self );
        end;
      end;
    end;
    if InternalDataset.ParamCount <> inCnt then
    begin
      ii := Params.Count - 1;
      while ii > 0 do
      begin
        tmpParam := FindParam( Params[ ii ].Name );
        if tmpParam <> Params[ ii ] then
          Params.RemoveParam( Params[ii] );
        Dec( ii );
      end;
    end;
  finally
    Params.EndUpdate;
  end;
end;
{$ENDIF}

procedure TIBODataset.InitFields;
var
  ii, jj: integer;
  tmpCol: TIB_Column;
  tmpField: TField;
begin
  for ii := 0 to FieldCount - 1 do
  begin
    tmpField := Fields[ii];
    if tmpField.FieldKind = fkData then
    begin
      jj := tmpField.FieldNo - 1;
      if jj >= InternalDataset.Fields.PSQLDA.sqld then
        jj := InternalDataset.Fields.PSQLDA.sqld - tmpField.FieldNo;
      tmpCol := InternalDataset.Fields.BySQLNo( jj );
      if tmpField.FieldName = tmpCol.BDEFieldName then
      begin
        tmpField.Alignment := tmpCol.Alignment;
        tmpField.Required := tmpCol.Required and not tmpCol.IsDefaulted;
        tmpField.DisplayLabel := tmpCol.DisplayLabel;
        if tmpField is TDateTimeField then
          (tmpField as TDateTimeField).DisplayFormat := tmpCol.DisplayFormat
        else
        if tmpField is TNumericField then
        begin
          (tmpField as TNumericField).DisplayFormat := tmpCol.DisplayFormat;
  {$IFDEF VCL130}
        end
        else
        if tmpField is TAggregateField then
        begin
          (tmpField as TAggregateField).DisplayFormat := tmpCol.DisplayFormat;
  {$ENDIF}
        end;
        tmpField.ReadOnly := tmpCol.ReadOnly;
     // These two properties are not compatible because one is characters
     // and the other one is pixels.
     // tmpField.DisplayWidth := tmpCol.DisplayWidth;
        tmpField.EditMask := tmpCol.EditMask;
        tmpField.Visible := tmpCol.Visible;
{$IFDEF IBO_VCL50_OR_GREATER}
        if ( tmpCol.RelName <> '' ) and
           ( tmpCol.SQLName <> '' ) then
          tmpField.Origin := tmpCol.RelName + '.' + tmpCol.SQLName;
{$ENDIF}
      end
      else
        Assert( false, 'IBDatasetFields.InitFields has a problem' );
    end;
  end;
  if InternalDataset.FieldsIndex.Count > 0 then
    for ii := 0 to InternalDataset.Fields.ColumnCount - 1 do
    begin
      tmpCol := InternalDataset.Fields[ii];
      tmpField := FindField( tmpCol.BDEFieldName );
      if Assigned( tmpField ) then
        tmpField.Index := ii;
    end;
end;

{$IFDEF IBO_VCL50_OR_GREATER}
function TIBODataset.GetFieldData( Field: TField;
                                   Buffer: Pointer;
                                   NativeFormat: Boolean ): Boolean;
begin
  if ( Field.DataType = ftBCD ) and not NativeFormat then
    Result := InternalGetFieldData( Field, Buffer )
  else
    Result := inherited GetFieldData( Field, Buffer, NativeFormat );
end;
{$ENDIF}

function TIBODataset.GetFieldData( Field: TField; Buffer: Pointer ): Boolean;
var
  lTempCurr : System.Currency;
begin
  if ( Field.DataType = ftBCD ) and ( Buffer <> nil ) then
  begin
    Result := InternalGetFieldData( Field, @lTempCurr );
    if Result then
{$IFDEF IBO_VCL50_OR_GREATER}
      CurrToBCD( lTempCurr, TBCD(Buffer^));
{$ELSE}
      CurrToBCD( lTempCurr, Buffer, 32, 4 );
{$ENDIF}
  end
  else
    Result := InternalGetFieldData( Field, Buffer );
end;

function TIBODataset.InternalGetFieldData( Field: TField;
                                           Buffer: Pointer ): boolean;
var
  ARecBuf: pointer;
  ACalcBuf: pointer;
  ANode: PIB_Node;
  tmpData: pointer;
  tmpInt: integer;
  NewTimeStamp: TTimeStamp;
  tmpInd: ^smallint;
  ii: integer;
begin
  Result := False;
  if not GetActiveRecBuf( ARecBuf, ACalcBuf, ANode ) then Exit;
  if Field.FieldNo > 0 then
  begin
    with InternalDataset.Fields.PSQLDA^.SQLVAR[ Field.FieldNo - 1 ] do
    begin
      tmpData := pointer( longint( ARecBuf ) +
                          longint( SQLData ) -
                          longint( InternalDataset.Fields.RowBuffer ));
      tmpInd := pointer( longint( tmpData ) - SizeOf( smallint ));
      Result := true;
      if Buffer = nil then
        Result := tmpInd^ <> IB_Null
      else
      if ( Field.DataType = ftBoolean ) and
         ( SQLScale <> 0 ) then
        EIB_Error.Create( E_Unsupp_Col_Conversion )
      else
      if tmpInd^ = IB_Null then
        Result := false
      else
      case SQLtype of
        SQL_SHORT,
        SQL_SHORT_: if SQLScale <> 0 then
        begin
          case Field.DataType of
            ftBCD: pcurrency(Buffer)^ :=
                     IntegerToCurrency(smallint(tmpData^), SQLScale);
            ftCurrency,
            ftFloat: pdouble(Buffer)^ :=
                       ScaleExtended(smallint(tmpData^), SQLScale);
            ftAutoInc,
            ftInteger: pinteger(Buffer)^ :=
                         Trunc( ScaleExtended(smallint(tmpData^), SQLScale) );
            else
              raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          end;
        end
        else
        begin
          case Field.DataType of
            ftBCD: pcurrency(Buffer)^ := smallint(tmpData^);
            ftCurrency,
            ftFloat: pdouble(Buffer)^ := smallint(tmpData^);
            ftSmallint: psmallint(Buffer)^ := smallint(tmpData^);
            ftAutoInc,
            ftInteger: pinteger(Buffer)^ := smallint(tmpData^);
            ftBoolean,
            ftWord: pword(Buffer)^ := smallint(tmpData^);
            else
              raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          end;
        end;
        SQL_LONG,
        SQL_LONG_: if SQLScale <> 0 then
        begin
          case Field.DataType of
            ftBCD: pcurrency(Buffer)^ :=
                     IntegerToCurrency(integer(tmpData^), SQLScale);
            ftCurrency,
            ftFloat: pdouble(Buffer)^ :=
                       ScaleExtended(integer(tmpData^), SQLScale);
            ftAutoInc,
            ftInteger: pinteger(Buffer)^ :=
                         Trunc( ScaleExtended(integer(tmpData^), SQLScale) );
            else
              raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          end;
        end
        else
        begin
          case Field.DataType of
            ftBCD: pcurrency(Buffer)^ := integer(tmpData^);
            ftCurrency,
            ftFloat: pdouble(Buffer)^ := integer(tmpData^);
            ftSmallint: psmallint(Buffer)^ := integer(tmpData^);
            ftAutoInc,
            ftInteger: pinteger(Buffer)^ := integer(tmpData^);
            ftBoolean,
            ftWord: pword(Buffer)^ := integer(tmpData^);
            ftDate: TDateTimeRec(Buffer^).Date := integer(tmpData^);
            ftTime: TDateTimeRec(Buffer^).Time := integer(tmpData^);
            else
              raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          end;
        end;
        SQL_QUAD,
        SQL_QUAD_,
        SQL_INT64,
        SQL_INT64_: if SQLScale <> 0 then
        begin
          case Field.DataType of
{$IFDEF IBO_VCL40_OR_GREATER}
            ftBCD: pcurrency(Buffer)^ :=
                     Int64ToCurrency(largeint(tmpData^), SQLScale);
            ftCurrency,
            ftFloat:
              pdouble(Buffer)^ := ScaleExtended(largeint(tmpData^), SQLScale);
            ftAutoInc,
            ftInteger: pinteger(Buffer)^ :=
                           Trunc( ScaleExtended(largeint(tmpData^), SQLScale ));
            ftLargeInt: largeint(Buffer^) :=
                           Trunc( ScaleExtended(largeint(tmpData^), SQLScale ));
{$ELSE}
            ftBCD: pcurrency(Buffer)^ :=
                                    Int64ToCurrency( comp(tmpData^), SQLScale );
            ftCurrency,
            ftFloat:
                  pdouble(Buffer)^ := ScaleExtended( comp(tmpData^), SQLScale );
            ftAutoInc,
            ftInteger: pinteger(Buffer)^ :=
                              Trunc( ScaleExtended( comp(tmpData^), SQLScale ));
{$ENDIF}
            else
              raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          end;
        end
        else
        begin
          case Field.DataType of
{$IFDEF IBO_VCL40_OR_GREATER}
            ftBCD: pcurrency(Buffer)^ := largeint(tmpData^);
            ftCurrency,
            ftFloat: pdouble(Buffer)^ := largeint(tmpData^);
            ftSmallint: psmallint(Buffer)^ := largeint(tmpData^);
            ftAutoInc,
            ftInteger: pinteger(Buffer)^ := largeint(tmpData^);
            ftLargeInt: largeint(Buffer^) := largeint(tmpData^);
            ftBoolean,
            ftWord: pword(Buffer)^ := largeint(tmpData^);
            ftDate: TDateTimeRec(Buffer^).Date := largeint(tmpData^);
            ftTime: TDateTimeRec(Buffer^).Time := largeint(tmpData^);
{$ELSE}
            ftBCD: pcurrency(Buffer)^ := comp(tmpData^);
            ftCurrency,
            ftFloat: pdouble(Buffer)^ := comp(tmpData^);
            ftSmallint: psmallint(Buffer)^ := Trunc(comp(tmpData^));
            ftAutoInc,
            ftInteger: pinteger(Buffer)^ := Trunc(comp(tmpData^));
            ftBoolean,
            ftWord: pword(Buffer)^ := Trunc(comp(tmpData^));
            ftDate: TDateTimeRec(Buffer^).Date := Trunc(comp(tmpData^));
            ftTime: TDateTimeRec(Buffer^).Time := Trunc(comp(tmpData^));
{$ENDIF}
            else
              raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          end;
        end;
        SQL_FLOAT,
        SQL_FLOAT_: begin
          case Field.DataType of
            ftBCD: pcurrency(Buffer)^ := single(tmpData^);
            ftCurrency,
            ftFloat: pdouble(Buffer)^ := single(tmpData^);
            ftSmallint: psmallint(Buffer)^ := Trunc(single(tmpData^));
            ftAutoInc,
            ftInteger: pinteger(Buffer)^ := Trunc(single(tmpData^));
{$IFDEF IBO_VCL40_OR_GREATER}
            ftLargeInt: largeint(Buffer^) := Trunc(single(tmpData^));
{$ENDIF}
            ftBoolean,
            ftWord: pword(Buffer)^ := Trunc(single(tmpData^));
            else
              raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          end;
        end;
        SQL_DOUBLE,
        SQL_DOUBLE_: begin
          case Field.DataType of
            ftBCD: pcurrency(Buffer)^ := double(tmpData^);
            ftCurrency,
            ftFloat: pdouble(Buffer)^ := double(tmpData^);
            ftSmallint: psmallint(Buffer)^ := Trunc(double(tmpData^));
            ftAutoInc,
            ftInteger: pinteger(Buffer)^ := Trunc(double(tmpData^));
{$IFDEF IBO_VCL40_OR_GREATER}
            ftLargeInt: largeint(Buffer^) := Trunc(double(tmpData^));
{$ENDIF}
            ftBoolean,
            ftWord: pword(Buffer)^ := Trunc(double(tmpData^));
            ftDate: TDateTimeRec(Buffer^).Date := Trunc(double(tmpData^));
            ftTime: TDateTimeRec(Buffer^).Time := Trunc(double(tmpData^));
            ftDateTime: TDateTimeRec(Buffer^).DateTime := double(tmpData^);
            else
              raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          end;
        end;
        SQL_BOOLEAN,
        SQL_BOOLEAN_: begin
          case Field.DataType of
            ftBoolean:
              if pshort(tmpData)^ = ISC_TRUE then
                word(Buffer^) := word(true)
              else
              if pshort(tmpData)^ = ISC_FALSE then
                word(Buffer^) := word(false) 
              else
                raise Exception.Create( 'Invalid buffer value' );
            else
              raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          end;
        end;
        SQL_TEXT,
        SQL_TEXT_: begin
          case Field.DataType of
            ftBytes: Move( tmpData^, Buffer^, SQLLen );
            ftString:
            begin
              Move( tmpData^, Buffer^, SQLLen );
              Pchar(Buffer)[ SQLLen ] := #0;
              if Assigned( IB_Connection ) and
                 ( not IB_Connection.DefaultNoTrimming ) then
                for ii := SQLLen - 1 downto 0 do
                begin
                  if Pchar(Buffer)[ ii ] = #32 then
                    Pchar(Buffer)[ ii ] := #0
                  else
                    Break;
                end
            end;
            ftBoolean:
            if FBoolList then
            begin
              if pchar( tmpData )^ = GetBoolTVals[Field.FieldNo - 1] then
                pword(Buffer)^ := word(true)
              else
              if pchar( tmpData )^ = GetBoolFVals[Field.FieldNo - 1] then
                pword(Buffer)^ := word(false)
              else
                Result := false;
            end
            else
            begin
              if pchar( tmpData )^ = BoolTrueChr then
                pword(Buffer)^ := word(true)
              else
              if pchar( tmpData )^ = BoolFalseChr then
                pword(Buffer)^ := word(false)
              else
                Result := false;
            end
            else
              raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          end;
        end;
        SQL_VARYING,
        SQL_VARYING_: begin
          case Field.DataType of
            ftVarBytes: Move( tmpData^, Buffer^, SQLLen + SizeOf( smallint ));
            ftString:
            begin
              with PSQL_VARCHAR( tmpData )^  do
              begin
                tmpInt := vary_len_low + vary_len_high * 256;
                FillChar( Buffer^, tmpInt + 1, #0 );
                Move( vary_string, Buffer^, tmpInt );
              end;
            end;
            ftBoolean: with PSQL_VARCHAR( tmpData )^ do
            if FBoolList then
            begin
              if vary_string = GetBoolTVals[Field.FieldNo - 1] then
                pword(Buffer)^ := word(true)
              else
              if vary_string = GetBoolFVals[Field.FieldNo - 1] then
                pword(Buffer)^ := word(false)
              else
                Result := false;
            end
            else
            begin
              if vary_string = BoolTrueChr then
                pword(Buffer)^ := word(true)
              else
              if vary_string = BoolFalseChr then
                pword(Buffer)^ := word(false)
              else
                Result := false;
            end
            else
              raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          end;
        end;
        SQL_TIMESTAMP,
        SQL_TIMESTAMP_: with pisc_quad(tmpData)^ do
        begin
          with TDateTimeRec(Buffer^) do
            case Field.DataType of
              ftDate: Date := isc_quad_high + 678576;
              ftTime: Time := isc_quad_low div 10;
              ftDateTime:
              begin
                NewTimeStamp.Date := isc_quad_high + 678576;
                NewTimeStamp.Time := isc_quad_low div 10;
                DateTime := TimeStampToMSecs( NewTimeStamp );
              end
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
        end;
        SQL_TYPE_TIME,
        SQL_TYPE_TIME_: begin
          NewTimeStamp.Date := 0;
          NewTimeStamp.Time := pisc_time(tmpData)^ div 10;
          if not ( Field.DataType in [ ftTime, ftDateTime ] ) then
            raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          with TDateTimeRec(Buffer^) do
            case Field.DataType of
              ftTime: Time := NewTimeStamp.Time;
              ftDateTime: DateTime := TimeStampToMSecs( NewTimeStamp );
            end;
        end;
        SQL_TYPE_DATE,
        SQL_TYPE_DATE_:
        begin
          NewTimeStamp.Date := pisc_date(tmpData)^ + 678576;
          NewTimeStamp.Time := 0;
          if not ( Field.DataType in [ ftDate, ftDateTime ] ) then
            raise EIB_Error.Create( E_Unsupp_Col_Conversion );
          with TDateTimeRec(Buffer^) do
            case Field.DataType of
              ftDate: Date := NewTimeStamp.Date;
              ftDateTime: DateTime := TimeStampToMSecs( NewTimeStamp );
            end;
        end;
        SQL_BLOB,
        SQL_BLOB_,
        SQL_ARRAY,
        SQL_ARRAY_: Move( tmpData^, Buffer^, SizeOf( isc_quad ));
        else
          raise EIB_Error.Create( E_Unsupp_Col_Conversion );
      end;
    end;
  end
  else
  begin
    if State in [dsBrowse, dsEdit, dsInsert, dsCalcFields
                 {$IFDEF IBO_VCL40_OR_GREATER}, dsBlockRead {$ENDIF} ] then
    begin
      if Assigned( ACalcBuf ) then
      begin
        Inc( longint( ACalcBuf ), FRecordSize + Field.Offset );
        Result := boolean( pchar(ACalcBuf)[0] );
        if Result and Assigned( Buffer ) then
          case Field.DataType of
            ftBCD:
              Move( pchar( ACalcBuf )[1], Buffer^, SizeOf( currency ));
            else
              Move( pchar( ACalcBuf )[1], Buffer^, Field.DataSize );
          end;
      end
      else
        Result := false;
    end;
  end;
end;

{$IFDEF IBO_VCL50_OR_GREATER}
procedure TIBODataset.SetFieldData( Field: TField;
                                    Buffer: Pointer;
                                    NativeFormat: Boolean );
begin
  if ( Field.DataType = ftBCD ) and not NativeFormat then
    InternalSetFieldData( Field, Buffer )
  else
    inherited SetFieldData( Field, Buffer, NativeFormat );
end;
{$ENDIF}

procedure TIBODataset.SetFieldData( Field: TField; Buffer: Pointer );
var
  lTempCurr : System.Currency;
begin
  if ( Field.DataType = ftBCD ) and ( Buffer <> nil ) then
  begin
{$IFDEF IBO_VCL50_OR_GREATER}
    BCDToCurr( TBCD(Buffer^), lTempCurr );
{$ELSE}
    BCDToCurr( Buffer, lTempCurr );
{$ENDIF}
    InternalSetFieldData( Field, @lTempCurr );
  end
  else
    InternalSetFieldData( Field, Buffer );
end;

procedure TIBODataset.InternalSetFieldData( Field: TField; Buffer: Pointer );
var
  ARecBuf: pointer;
  ACalcBuf: pointer;
  ANode: PIB_Node;
  tmpData: pointer;
  tmpInd: ^smallint;
  tmpLen: integer;
  NewTimeStamp: TTimeStamp;
  tmpStr: string;
begin
  if not (State in dsWriteModes) then DatabaseError(SNotEditing);
  if (State = dsSetKey) then
    if ((Field.FieldNo < 0) or (IndexFieldCount > 0) and
       not Field.IsIndexField) then
      DatabaseErrorFmt( SNotIndexField, [Field.DisplayName]);
  if not GetActiveRecBuf( ARecBuf, ACalcBuf, ANode ) then Exit;
  if Field.FieldNo > 0 then
  begin
    if State = dsCalcFields then
      DatabaseError(SNotEditing);
    if ReadOnly and not (State in [dsSetKey, dsFilter]) then
      DatabaseErrorFmt(SFieldReadOnly, [Field.DisplayName]);
    Field.Validate(Buffer);
    with InternalDataset.Fields.PSQLDA^.SQLVAR[ Field.FieldNo - 1 ] do
    begin
      tmpData := pointer( longint( ARecBuf ) +
                          longint( SQLData ) -
                          longint( InternalDataset.Fields.RowBuffer ));
      tmpInd := pointer( longint( tmpData ) - SizeOf( smallint ));
      if Buffer = nil then
        tmpInd^ := IB_Null
      else
      begin
        tmpInd^ := IB_NotNull;
        if ( Field.DataType = ftBoolean ) and
           ( SQLScale <> 0 ) then
          EIB_Error.Create( E_Unsupp_Col_Conversion )
        else
        case SQLtype of
          SQL_SHORT,
          SQL_SHORT_: if SQLScale <> 0 then
          begin
            case Field.DataType of
              ftBCD: smallint(tmpData^) :=
                       CurrencyToSmallint(pcurrency(Buffer)^,-SQLScale);
              ftCurrency,
              ftFloat: if SQLScale >= -4 then
                  smallint(tmpData^) :=
                               CurrencyToSmallInt( pdouble(Buffer)^, -SQLScale )
                else
                  smallint(tmpData^) :=
                              ExtendedToSmallint( pdouble(Buffer)^, -SQLScale );
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
          end
          else
          begin
            case Field.DataType of
              ftBCD: psmallint(tmpData)^ := Trunc(currency(Buffer^));
              ftCurrency,
              ftFloat: psmallint(tmpData)^ := Trunc( double(Buffer^));
              ftSmallint: psmallint(tmpData)^ := smallint(Buffer^);
              ftAutoInc,
              ftInteger: psmallint(tmpData)^ := integer(Buffer^);
{$IFDEF IBO_VCL40_OR_GREATER}
              ftLargeInt: psmallint(tmpData)^ := largeint(Buffer^);
{$ENDIF}
              ftBoolean,
              ftWord: psmallint(tmpData)^ := word(Buffer^);
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
          end;
          SQL_LONG,
          SQL_LONG_: if SQLScale <> 0 then
          begin
            case Field.DataType of
              ftBCD: integer(tmpData^) :=
                                CurrencyToInteger(pcurrency(Buffer)^,-SQLScale);
              ftCurrency,
              ftFloat: if SQLScale >= -4 then
                  integer(tmpData^) :=
                                CurrencyToInteger( pdouble(Buffer)^, -SQLScale )
                else
                  integer(tmpData^) :=
                               ExtendedToInteger( pdouble(Buffer)^, -SQLScale );
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
          end
          else
          begin
            case Field.DataType of
              ftBCD: pinteger(tmpData)^ := Trunc(currency(Buffer^));
              ftCurrency,
              ftFloat: integer(tmpData^) :=
                               CurrencyToInteger( pdouble(Buffer)^, -SQLScale );
              ftSmallint: pinteger(tmpData)^ := smallint(Buffer^);
              ftAutoInc,
              ftInteger: pinteger(tmpData)^ := integer(Buffer^);
{$IFDEF IBO_VCL40_OR_GREATER}
              ftLargeInt: pinteger(tmpData)^ := largeint(Buffer^);
{$ENDIF}
              ftBoolean,
              ftWord: pinteger(tmpData)^ := word(Buffer^);
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
          end;
          SQL_QUAD,
          SQL_QUAD_,
          SQL_INT64,
          SQL_INT64_: if SQLScale <> 0 then
          begin
            case Field.DataType of
{$IFDEF IBO_VCL40_OR_GREATER}
              ftBCD: largeint(tmpData^) :=
                       CurrencyToInt64( pcurrency(Buffer)^,-SQLScale );
{$ELSE}
              ftBCD: comp(tmpData^) :=
                       CurrencyToInt64( pcurrency(Buffer)^,-SQLScale );
{$ENDIF}
              ftCurrency,
              ftFloat: if SQLScale >= -4 then
{$IFDEF IBO_VCL40_OR_GREATER}
                  largeint(tmpData^) :=
                                  CurrencyToInt64( pdouble(Buffer)^, -SQLScale )
{$ELSE}
                  comp(tmpData^) :=
                                  CurrencyToInt64( pdouble(Buffer)^, -SQLScale )
{$ENDIF}
                else
{$IFDEF IBO_VCL40_OR_GREATER}
                  largeint(tmpData^) :=
                           Round( ScaleExtended( pdouble(Buffer)^, -SQLScale ));
{$ELSE}
                  comp(tmpData^) :=
                           Round( ScaleExtended( pdouble(Buffer)^, -SQLScale ));
{$ENDIF}
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
          end
          else
          begin
            case Field.DataType of
{$IFDEF IBO_VCL40_OR_GREATER}
              ftBCD: largeint(tmpData^) := Trunc( currency(Buffer^) );
              ftCurrency,
              ftFloat: largeint(tmpData^) := Trunc( double(Buffer^) );
              ftSmallint: largeint(tmpData^) := smallint(Buffer^);
              ftAutoInc,
              ftInteger: largeint(tmpData^) := integer(Buffer^);
              ftLargeInt: largeint(tmpData^) := largeint(Buffer^);
              ftBoolean,
              ftWord: largeint(tmpData^) := word(Buffer^);
{$ELSE}
              ftBCD: comp(tmpData^) := Trunc( currency(Buffer^) );
              ftCurrency,
              ftFloat: comp(tmpData^) := Trunc( double(Buffer^) );
              ftSmallint: comp(tmpData^) := smallint(Buffer^);
              ftAutoInc,
              ftInteger: comp(tmpData^) := integer(Buffer^);
              ftBoolean,
              ftWord: comp(tmpData^) := word(Buffer^);
{$ENDIF}
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
          end;
          SQL_FLOAT,
          SQL_FLOAT_: begin
            case Field.DataType of
              ftBCD: psingle(tmpData)^ := currency(Buffer^);
              ftCurrency,
              ftFloat: psingle(tmpData)^ := double(Buffer^);
              ftSmallint: psingle(tmpData)^ := smallint(Buffer^);
              ftAutoInc,
              ftInteger: psingle(tmpData)^ := integer(Buffer^);
{$IFDEF IBO_VCL40_OR_GREATER}
              ftLargeInt: psingle(tmpData)^ := largeint(Buffer^);
{$ENDIF}
              ftBoolean,
              ftWord: psingle(tmpData)^ := word(Buffer^);
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
          end;
          SQL_DOUBLE,
          SQL_DOUBLE_: begin
            case Field.DataType of
              ftBCD: pdouble(tmpData)^ := currency(Buffer^);
              ftCurrency,
              ftFloat: pdouble(tmpData)^ := double(Buffer^);
              ftSmallint: pdouble(tmpData)^ := smallint(Buffer^);
              ftAutoInc,
              ftInteger: pdouble(tmpData)^ := integer(Buffer^);
{$IFDEF IBO_VCL40_OR_GREATER}
              ftLargeInt: pdouble(tmpData)^ := largeint(Buffer^);
{$ENDIF}
              ftBoolean,
              ftWord: pdouble(tmpData)^ := word(Buffer^);
              ftDate: pdouble(tmpData)^ := TDateTimeRec(Buffer^).Date;
              ftTime: pdouble(tmpData)^ := TDateTimeRec(Buffer^).Time;
              ftDateTime: pdouble(tmpData)^ := TDateTimeRec(Buffer^).DateTime;
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
          end;
          SQL_BOOLEAN,
          SQL_BOOLEAN_: begin
            case Field.DataType of
              ftBoolean:
                if word(Buffer^) = word(true) then
                  pshort(tmpData)^ := ISC_TRUE
                else
                if word(Buffer^) = word(false) then
                  pshort(tmpData)^ := ISC_FALSE
                else
                  raise Exception.Create( 'Invalid buffer value' );
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
          end;
          SQL_TEXT,
          SQL_TEXT_: begin
            case Field.DataType of
{ TODO : Need to add support for the OCTETS character set which pads with #0. }
              ftBytes: Move( Buffer^, tmpData^, SQLLen );
              ftString:
              begin
                tmpLen := Length( PChar( Buffer ));
                if tmpLen > SQLLen then
                  tmpLen := SQLLen;
                FillChar( tmpData^, SQLLen, #32 );
                Move( Buffer^, tmpData^, tmpLen );
              end;
              ftBoolean: if FBoolList then
              begin
                if boolean( buffer^ ) then
                  tmpStr := GetBoolTVals[Field.FieldNo - 1]
                else
                  tmpStr := GetBoolFVals[Field.FieldNo - 1];
                FillChar( tmpData^, SQLLen, #32 );
                Move( tmpstr[1], tmpData^, Length( tmpStr ));
              end
              else
              if SQLLen = 1 then
              begin
                if boolean( buffer^ ) then
                  Move( BoolTrueChr, tmpData^, 1 )
                else
                  Move( BoolFalseChr, tmpData^, 1 );
              end
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
          end;
          SQL_VARYING,
          SQL_VARYING_:
          begin
            case Field.DataType of
              ftVarBytes: 
                Move( Buffer^, tmpData^, SQLLen + SizeOf( smallint ));
              ftString:
              begin
                tmpLen := Length( Pchar( Buffer ));
                if tmpLen > SQLLen then
                  tmpLen := SQLLen;
                with PSQL_VARCHAR( tmpData )^ do
                begin
                  FillChar( vary_string, SQLLen, #0 );
                  Move( Buffer^, vary_string, tmpLen );
                  vary_len_low := tmpLen mod 256;
                  vary_len_high := tmpLen div 256;
                end;
              end;
              ftBoolean: with PSQL_VARCHAR(tmpData)^ do
              if FBoolList then
              begin
                if boolean( buffer^ ) then
                  tmpStr := GetBoolTVals[Field.FieldNo - 1]
                else
                  tmpStr := GetBoolFVals[Field.FieldNo - 1];
                Move( tmpstr[1], vary_string, Length( tmpStr ));
                vary_len_low := Length( tmpStr ) mod 256;
                vary_len_high := Length( tmpStr ) div 256;
              end
              else
              if SQLLen = 1 then
              begin
                if boolean( buffer^ ) then
                  Move( BoolTrueChr, vary_string, 1 )
                else
                  Move( BoolFalseChr, vary_string, 1 );
              end
              else 
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
              else
                raise EIB_Error.Create( E_Unsupp_Col_Conversion );
            end;
          end;
          SQL_TIMESTAMP,
          SQL_TIMESTAMP_:
          begin
            with TDateTimeRec(Buffer^), pisc_quad(tmpData)^ do
            begin
              case Field.DataType of
                ftDate:
                begin
                  isc_quad_high := Date - 678576;
                  isc_quad_low := 0;
                end;
                ftTime:
                begin
                  isc_quad_high := - 678576;
                  isc_quad_low := Time * 10;
                end;
                ftDateTime:
                begin
                  NewTimeStamp := MSecsToTimeStamp( DateTime );
                  isc_quad_high := NewTimeStamp.Date - 678576;
                  isc_quad_low := NewTimeStamp.Time * 10;
                end
                else
                  raise EIB_Error.Create( E_Unsupp_Col_Conversion );
              end;
            end;
          end;
          SQL_TYPE_TIME,
          SQL_TYPE_TIME_:
          begin
            with TDateTimeRec(Buffer^) do
            begin
              case Field.DataType of
                ftTime: pisc_time(tmpData)^ := Time * 10;
                ftDateTime:
                begin
                  NewTimeStamp := MSecsToTimeStamp( DateTime );
                  pisc_time(tmpData)^ := NewTimeStamp.Time * 10;
                end
                else
                  raise EIB_Error.Create( E_Unsupp_Col_Conversion );
              end;
            end;
          end;
          SQL_TYPE_DATE,
          SQL_TYPE_DATE_: begin
            with TDateTimeRec(Buffer^) do
            begin
              case Field.DataType of
                ftDate: pisc_date(tmpData)^ := Date - 678576;
                ftDateTime:
                begin
                  NewTimeStamp := MSecsToTimeStamp( DateTime );
                  pisc_date(tmpData)^ := NewTimeStamp.Date - 678576;
                end
                else
                  raise EIB_Error.Create( E_Unsupp_Col_Conversion );
              end;
            end;
          end;
          SQL_BLOB,
          SQL_BLOB_,
          SQL_ARRAY,
          SQL_ARRAY_: Move( Buffer^, tmpData^, SizeOf( isc_quad ));
        end;
      end;
    end;
    SetModified( true );
  end
  else
  begin {fkCalculated, fkLookup}
    if Assigned( ACalcBuf ) then
    begin
      Inc( longint(ACalcBuf), FRecordSize + Field.Offset );
      boolean( pchar(ACalcBuf)[0] ) := LongBool( Buffer );
      if boolean( pchar(ACalcBuf)[0] ) then
        case Field.DataType of
          ftBCD:
            Move( Buffer^, pchar(ACalcBuf)[1], SizeOf( currency ));
          else
            Move( Buffer^, pchar(ACalcBuf)[1], Field.DataSize );
        end;
    end;
  end;
  if not (State in [dsCalcFields, dsFilter, dsNewValue]) then
    DataEvent( deFieldChange, longint(Field));
end;

{$IFNDEF IBO_VCL50_OR_GREATER}
type
// The only way I could get this to work is to use logic from BDE stuff.
  _FMTBcd = packed record
    iPrecision: BYTE;
    iSignSpecialPlaces: BYTE;
    iFraction: packed array[ 0..31 ] of BYTE;
  end;
  
function _FMTBCDToCurr(const BCD: _FMTBcd; var Curr: Currency): Boolean;
const
  FConst10: Single = 10;
  CWNear: Word = $133F;
var
  CtrlWord: Word;
  Temp: Integer;
  Digits: array[0..63] of Byte;
asm
        PUSH    EBX
        PUSH    ESI
        MOV     EBX,EAX
        MOV     ESI,EDX
        MOV     AL,0
        MOVZX   EDX,[EBX]._FMTBcd.iPrecision
        OR      EDX,EDX
        JE      @@8
        LEA     ECX,[EDX+1]
        SHR     ECX,1
@@1:    MOV     AL,[EBX]._FMTBcd.iFraction.Byte[ECX-1]
        MOV     AH,AL
        SHR     AL,4
        AND     AH,0FH
        MOV     Digits.Word[ECX*2-2],AX
        DEC     ECX
        JNE     @@1
        XOR     EAX,EAX
@@2:    MOV     AL,Digits.Byte[ECX]
        OR      AL,AL
        JNE     @@3
        INC     ECX
        CMP     ECX,EDX
        JNE     @@2
        FLDZ
        JMP     @@7
@@3:    MOV     Temp,EAX
        FILD    Temp
@@4:    INC     ECX
        CMP     ECX,EDX
        JE      @@5
        FMUL    FConst10
        MOV     AL,Digits.Byte[ECX]
        MOV     Temp,EAX
        FIADD   Temp
        JMP     @@4
@@5:    MOV     AL,[EBX]._FMTBcd.iSignSpecialPlaces
        OR      AL,AL
        JNS     @@6
        FCHS
@@6:    AND     EAX,3FH
        SUB     EAX,4
        NEG     EAX
        CALL    FPower10
@@7:    FSTCW   CtrlWord
        FLDCW   CWNear
        FISTP   [ESI].Currency
        FSTSW   AX
        NOT     AL
        AND     AL,1
        FCLEX
        FLDCW   CtrlWord
        FWAIT
@@8:    POP     ESI
        POP     EBX
end;

function _CurrToFMTBCD( Curr: Currency; var BCD: _FMTBcd; Precision,
  Decimals: Integer): Boolean;
const
  Power10: array[0..3] of Single = (10000, 1000, 100, 10);
var
  Digits: array[0..63] of Byte;
asm
        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        MOV     ESI,EAX
        XCHG    ECX,EDX
        MOV     [ESI]._FMTBcd.iPrecision,CL
        MOV     [ESI]._FMTBcd.iSignSpecialPlaces,DL
@@1:    SUB     EDX,4
        JE      @@3
        JA      @@2
        FILD    Curr
        FDIV    Power10.Single[EDX*4+16]
        FISTP   Curr
        JMP     @@3
@@2:    DEC     ECX
        MOV     Digits.Byte[ECX],0
        DEC     EDX
        JNE     @@2
@@3:    MOV     EAX,Curr.Integer[0]
        MOV     EBX,Curr.Integer[4]
        OR      EBX,EBX
        JNS     @@4
        NEG     EBX
        NEG     EAX
        SBB     EBX,0
        OR      [ESI]._FMTBcd.iSignSpecialPlaces,80H
@@4:    MOV     EDI,10
@@5:    MOV     EDX,EAX
        OR      EDX,EBX
        JE      @@7
        XOR     EDX,EDX
        OR      EBX,EBX
        JE      @@6
        XCHG    EAX,EBX
        DIV     EDI
        XCHG    EAX,EBX
@@6:    DIV     EDI
@@7:    MOV     Digits.Byte[ECX-1],DL
        DEC     ECX
        JNE     @@5
        OR      EAX,EBX
        MOV     AL,0
        JNE     @@9
        MOV     CL,[ESI]._FMTBcd.iPrecision
        INC     ECX
        SHR     ECX,1
@@8:    MOV     AX,Digits.Word[ECX*2-2]
        SHL     AL,4
        OR      AL,AH
        MOV     [ESI]._FMTBcd.iFraction.Byte[ECX-1],AL
        DEC     ECX
        JNE     @@8
        MOV     AL,1
@@9:    POP     EDI
        POP     ESI
        POP     EBX
end;

function TIBODataset.BCDToCurr( BCD: Pointer; var Curr: Currency ): Boolean;
begin
  Result := _FMTBCDToCurr( _FMTBCD( BCD^ ), Curr );
end;

function TIBODataset.CurrToBCD(  const Curr: Currency;
                                       BCD: Pointer;
                                       Precision,
                                       Decimals: Integer ): Boolean;
begin
  Result := _CurrToFMTBCD( Curr, _FMTBCD(BCD^), 32, 4 );
end;
{$ENDIF}

{------------------------------------------------------------------------------}

procedure TIBODataset.Resync( Mode: TResyncMode );
begin
  if Active then
  begin
  // It is important to prevent the Resync() process from being interrupted
  // by a callback. Rows should already be in the buffer but perhaps not.
    InternalDataset.BeginCallbackFreeze;
    try
      inherited Resync( Mode );
    finally
      InternalDataset.EndCallbackFreeze;
    end;
  end;
end;

procedure TIBODataset.SysResync( Mode: TResyncMode );
begin
  FCurRowNum := InternalDataset.RowNum;
  CursorPosChanged;
  if InternalDataset.IsEmpty and not ( rmExact in Mode ) then
    ClearBuffers;
  Resync( Mode );
end;

procedure TIBODataset.SysSQLChange( Sender: TObject; var Unprepare: boolean );
{$IFDEF IBO_VCL40_OR_GREATER}
var
  tmpSQL1: string;
  tmpSQL2: string;
  tmpLen: integer;
{$ENDIF}
begin
{$IFDEF IBO_VCL40_OR_GREATER}
  if not InternalDataset.PreparingSQL then
    if ( csReading in ComponentState ) then
    begin
      MakeServerSQL( InternalDataset.ClientSQL,
                     nil,
                     nil,
                     nil,
                     tmpSQL1,
                     ':',
                     false,
                     tmpLen );
      MakeClientSQL( tmpSQL1, tmpSQL2, ':' );
      FParams.ParseSQL( tmpSQL2, false );
// Still need to remove dups and the params used for range and master-detail?
    end
    else
      SysUpdateParams;
{$ENDIF}
end;

{$IFDEF IBO_VCL40}
procedure TIBODataset.SysUpdateParams;
var
  List: TParams;
  tmpSQL: string;
  ii: integer;
  tmpPrm: TParam;
  tmpSQL1: string;
  tmpSQL2: string;
  tmpLen: integer;
begin
  if ParamCheck or ( csDesigning in ComponentState ) then
  begin
    List := TParams.Create( Self );
    try
    // There is some weird by reference stuff tweaking this SQL string here.
    // Watch out! I use the Trim() in order to break the by reference flaw.
    // It is necessary to wipe out comments here so that they don't get added.
      MakeServerSQL( InternalDataset.ClientSQL,
                     nil,
                     nil,
                     nil,
                     tmpSQL1,
                     ':',
                     false,
                     tmpLen );
      MakeClientSQL( tmpSQL1, tmpSQL2, ':' );
      tmpSQL := Trim( tmpSQL2 );
      List.ParseSQL( tmpSQL, true );
      List.AssignValues( FParams );
      tmpSQL := Trim( tmpSQL2 );
      FParams.ParseSQL( tmpSQL, true );
// Remove parameters that are actually handled by the master-detail
// and SetRange capabilities.
      for ii := FParams.Count - 1 downto 0 do
      begin
        if FParams.Count <> InternalDataset.ParamCount then
        begin
          tmpPrm := FParams.ParamByName( FParams[ii].Name );
          if tmpPrm <> FParams[ii] then
          begin
            FParams[ii].Free;
            List[ii].Free;
            Continue;
          end;
        end;
        if ( Pos( IB_RNGBEG,  FParams[ii].Name ) = 1 ) or
           ( Pos( IB_RNGEND,  FParams[ii].Name ) = 1 ) or
           ( Pos( IB_ORDLINK, FParams[ii].Name ) = 1 ) then
          FParams[ii].Free
        else
        if Assigned( DataSource ) and
           Assigned( DataSource.Dataset ) then
          if Assigned( DataSource.Dataset.FindField( FParams[ii].Name )) then
          begin
            FParams[ii].Free;
            List[ii].Free;
          end;
      end;
      if FIncludeOutputParams or
         ( InternalDataset.StatementType = stExecProcedure ) then
      begin
        for ii := 0 to InternalDataset.FieldCount - 1 do
        begin
          tmpPrm := FindParam( InternalDataset.Fields[ii].FieldName );
          if Assigned( tmpPrm ) then
          begin
            if tmpPrm.ParamType = ptInput then
              tmpPrm.ParamType := ptInputOutput;
          end
          else
          begin
            tmpPrm := TParam.Create( FParams, ptOutput );
            tmpPrm.Name := InternalDataset.Fields[ii].FieldName;
            tmpPrm.ParamType := ptOutput;
          end;
        end;
      end;
      FParams.AssignValues( List );
    finally
      List.Free;
    end;
  end;
  DataEvent( dePropertyChange, 0 );
end;
{$ENDIF}
{$IFDEF IBO_VCL50_OR_GREATER}
procedure TIBODataset.SysUpdateParams;
var
  List: TParams;
  tmpSQL: string;
  ii: integer;
  tmpPrm: TParam;
  tmpSQL1: string;
  tmpSQL2: string;
  tmpLen: integer;
begin
  if ParamCheck or ( csDesigning in ComponentState ) then
  begin
    List := TParams.Create( Self );
    try
    // There is some weird by reference stuff tweaking this SQL string here.
    // Watch out! I use the UniqueString() in order to break the by reference
    // flaw.
    // It is necessary to wipe out comments here so that they don't get added.
      MakeServerSQL( InternalDataset.ClientSQL,
                     nil,
                     nil,
                     nil,
                     tmpSQL1,
                     ':',
                     false,
                     tmpLen );
      MakeClientSQL( tmpSQL1, tmpSQL2, ':' );
      tmpSQL := tmpSQL2;
      UniqueString(tmpSQL);
      List.BeginUpdate;
      List.ParseSQL( tmpSQL, true );
      List.EndUpdate;
      List.AssignValues( FParams );
      tmpSQL := tmpSQL2;
      UniqueString(tmpSQL);
      FParams.BeginUpdate;
      FParams.ParseSQL( tmpSQL, true );
      FParams.EndUpdate;
// Remove system parameters that are handled by the SetRange capabilities.
      for ii := FParams.Count - 1 downto 0 do
      begin
        if FParams.Count <> InternalDataset.ParamCount then
        begin
          if TCollection(FParams).Items[ii] <> FParams[ii] then
          begin
            FParams.Delete(ii);
            List.Delete(ii);
            Continue;
          end;
        end;
        if ( Pos( IB_RNGBEG, FParams[ii].Name ) = 1 ) or
           ( Pos( IB_RNGBEG, FParams[ii].Name ) = 1 ) or
           ( Pos( IB_ORDLINK, FParams[ii].Name ) = 1 ) then
          FParams.Delete(ii);
// These params are valid to be here even if they are getting their values
// from the linked dataset.          
//        else
//        if Assigned( DataSource ) and
//           Assigned( DataSource.Dataset ) then
//          if Assigned( DataSource.Dataset.FindField( FParams[ii].Name )) then
//          begin
//            FParams.Delete(ii);
//            List.Delete(ii);
//          end;
      end;
      if FIncludeOutputParams or
         ( InternalDataset.StatementType = stExecProcedure ) then
      begin
        for ii := 0 to InternalDataset.FieldCount - 1 do
        begin
          tmpPrm := FindParam( InternalDataset.Fields[ii].FieldName );
          if Assigned( tmpPrm ) then
          begin
            if tmpPrm.ParamType = ptInput then
              tmpPrm.ParamType := ptInputOutput;
          end
          else
          begin
            tmpPrm := TParam.Create( FParams, ptOutput );
            tmpPrm.Name := InternalDataset.Fields[ii].FieldName;
            tmpPrm.ParamType := ptOutput;
          end;
        end;
      end;
      FParams.AssignValues( List );
    finally
      List.Free;
    end;
  end;
  DataEvent( dePropertyChange, 0 );
end;
{$ENDIF}

procedure TIBODataset.SetKeyRelation( AValue: string );
begin InternalDataset.KeyRelation := AValue; end;
function TIBODataset.GetKeyRelation: string;
begin Result := InternalDataset.KeyRelation; end;

procedure TIBODataset.RefreshParams( WantRefresh: boolean );
var
  tmpDataset: TDataset;
  ii: integer;
  waschanged: boolean;
  ctrlsdsbld: boolean;
begin
  if ( FRefreshingParams = 0 ) and Prepared then
  begin
    Inc( FRefreshingParams );
    try
      tmpDataset := FDatalink.Dataset;
      if Assigned( tmpDataset ) and
         ( not tmpDataset.Active or ( tmpDataset.State = dsSetKey )) then
        tmpDataset := nil;
      ctrlsdsbld := false;
      try
        with InternalDataset.Params do
        begin
          Inc( FStrictModifyOnlyLevel );
          BeginUpdate;
          try
{$IFDEF IBO_VCL40_OR_GREATER}
            if FParams.Count <> 0 then
              AssignParamsValues( FParams );
{$ENDIF}
            for ii := 0 to ColumnCount - 1 do
              RefreshParam( Columns[ ii ], tmpDataset );
            WasChanged := WantRefresh and ( RowState = rsModified );
            if Active and WasChanged then
            begin
              DisableControls;
              ctrlsdsbld := true;
            end
            else
              WasChanged := false;
          finally
            Dec( FStrictModifyOnlyLevel );
            EndUpdate( true );
          end;
        end;
        if WantRefresh and WasChanged then
        begin
          DoBeforeScroll;
          InternalDataset.Close;
          InternalDataset.Open;
          InternalDataset.First;
          CursorPosChanged;  
          SysResync( [] );
          DoAfterScroll;
        end;
      finally
        if ctrlsdsbld then
          EnableControls;
      end;
    finally
      Dec( FRefreshingParams );
    end;
  end;
end;

procedure TIBODataset.RefreshParam( const AParam: TIB_Column;
                                    const ADataset: TDataset );
var
  tmpField: TField;
  tmpCol: TIB_Column;
  tmpName: string;
  SaveState: TDataSetState;
begin
  with AParam do
  begin
    if Assigned( ADataset ) then
    begin
      tmpField := ADataset.FindField( FieldName );
      if not Assigned( tmpField ) and
         ( InternalDataset.SQLDialect >= 3 ) then
        tmpField := ADataset.FindField( stLitCriteria( FieldName ));
      if Assigned( tmpField ) then
      begin
        if ADataset.IsEmpty then
        begin
          if not IsNull then
            Clear;
        end
        else
          AssignFieldValueToCol( tmpField, AParam );
        Exit;
      end;
    end
    else
    if FDataLink.Dataset is TIBODataset then
    begin
      tmpCol := TIBODataset(FDataLink.Dataset).
                InternalDataset.FindField( FieldName );
      if not Assigned( tmpCol ) and
         ( InternalDataset.SQLDialect >= 3 ) then
        tmpCol := TIBODataset(FDataLink.Dataset).
                  InternalDataset.
                  FindField( stLitCriteria( FieldName ));
      if Assigned( tmpCol ) then
        Clear;
    end;
    if Pos( IB_RNGBEG, FieldName ) = 1 then
    begin
      tmpName := Copy( FieldName, Length( IB_RNGBEG ) + 1, maxint );
      tmpField := Self.FindField( tmpName );
      if Assigned( tmpField ) then
      begin
        FKeyBuffer := FKeyBuffers[ kiIBOCurRangeStart ];
        SaveState := SetTempState( dsSetKey );
        try
          if AsString <> tmpField.AsString then
            AsString := tmpField.AsString;
        finally
          RestoreState( SaveState );
        end;
      end;
    end;
    if Pos( IB_RNGEND, FieldName ) = 1 then
    begin
      tmpName := Copy( FieldName, Length( IB_RNGEND ) + 1, maxint );
      tmpField := Self.FindField( tmpName );
      if Assigned( tmpField ) then
      begin
        FKeyBuffer := FKeyBuffers[ kiIBOCurRangeEnd ];
        SaveState := SetTempState( dsSetKey );
        try
          if AsString <> tmpField.AsString then
            AsString := tmpField.AsString;
        finally
          RestoreState( SaveState );
        end;
      end;
    end;
  end;
end;

{ TIBDataset }

constructor TIBODataset.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
{$IFDEF IBO_VCL40_OR_GREATER}
  FIndexDefs := TIndexDefs.Create( Self );
  FParams := TParams.Create( Self );
{$ENDIF}
  FIB_Query := TIBOInternalDataset.Create( Self );
  FIB_Query.OnCallback := FetchCallback;
  FIB_Query.OnError := DoHandleError;
  FDataLink := TIBOQueryDataLink.Create( Self );
  FRecordCountAccurate := true;
end;

procedure TIBODataset.Loaded;
begin
  inherited Loaded;
  FIB_Query.Name := 'IBOqr' + Name;
end;

destructor TIBODataset.Destroy;
begin
  Close;
  Unprepare;
  DataSource := nil;
{$IFDEF IBO_VCL40_OR_GREATER}
  UpdateObject := nil;
{$ENDIF}
  FreeKeyBuffers;
  inherited Destroy;
  FDataLink.Free;
  FDataLink := nil;
{$IFDEF IBO_VCL40_OR_GREATER}
  FParams.Free;
  FParams := nil;
  FIndexDefs.Free;
  FIndexDefs := nil;
{$ENDIF}
end;

procedure TIBODataset.AllocKeyBuffers;
var
  KeyIndex: TIBOKeyIndex;
begin
  try
    for KeyIndex := Low( TIBOKeyIndex ) to High( TIBOKeyIndex ) do
      FKeyBuffers[ KeyIndex ] := InitKeyBuffer(
        AllocMem( SizeOf( TIBOKeyBuffer ) + FRecordSize ));
  except
    FreeKeyBuffers;
    raise;
  end;
end;

procedure TIBODataset.CheckSetKeyMode;
begin
  if State <> dsSetKey then 
    DatabaseError( SNotEditing ); //, Self );
end;

procedure TIBODataset.FreeKeyBuffers;
var
  KeyIndex: TIBOKeyIndex;
begin
  for KeyIndex := Low( TIBOKeyIndex ) to High( TIBOKeyIndex ) do
    if Assigned( FKeyBuffers[KeyIndex] ) then
    begin
      FreeMem( FKeyBuffers[KeyIndex] );
      FKeyBuffers[KeyIndex] := nil;
    end;
end;

procedure TIBODataset.AppendOtherFields;
var
  ii: integer;
begin
  for ii := 0 to FieldDefs.Count - 1 do
    begin
      if not Assigned( FindField( FieldDefs[ii].Name )) then
        FieldDefs[ii].CreateField( Self );
    end;
end;

procedure TIBODataset.FreeServerResources;
begin
  InternalDataset.FreeServerResources;
end;

function TIBODataset.GetIndexField( Index: integer ): TField;
var
  tmpStr: string;
  tmpCol: TIB_Column;
begin
  if ( Index < 0 ) or ( Index >= IndexFieldCount ) then
    DatabaseError( SFieldIndexError ); //, Self );
  tmpStr := InternalDataset.SQLOrderLinks.IndexNames[ Index ];
  Result := FindField( tmpStr );
  if not Assigned( Result ) then
  begin
    tmpCol := InternalDataset.FindField( tmpStr );
    if Assigned( tmpCol ) then
      Result := FindField( tmpCol.FieldName );
  end;
  if not Assigned( Result ) then
  begin
    DatabaseErrorFmt( SIndexFieldMissing, [ tmpStr ] ); //, Self );
  end;
end;

function TIBODataset.GetIndexFieldCount: integer;
begin
  Result := InternalDataset.SQLOrderLinks.Count;
end;

procedure TIBODataset.GetIndexNames( List: TStrings );
begin
{$IFDEF IBO_VCL40_OR_GREATER}
  IndexDefs.Update;
  IndexDefs.GetItemNames( List );
{$ELSE}
  if Prepared and ( KeyRelation <> '' ) then
    IB_Schema.SchemaIndexInfo( InternalDataset.IB_Connection,
                               InternalDataset.IB_Transaction,
                               false,
                               List,
                               KeyRelation )
  else
    List.Clear;
{$ENDIF}
end;

{$IFDEF IBO_VCL40_OR_GREATER}
procedure TIBODataset.SetIndexDefs( AValue: TIndexDefs );
begin
  IndexDefs.Assign( AValue );
end;
{$ENDIF}

function TIBODataset.GetKeyBuffer( KeyIndex: TIBOKeyIndex ): PIBOKeyBuffer;
begin
  Result := FKeyBuffers[ KeyIndex ];
end;

function TIBODataset.GetKeyExclusive: Boolean;
begin
  CheckSetKeyMode;
  Result := FKeyBuffer.Exclusive;
end;

function TIBODataset.GetKeyFieldCount: Integer;
begin
  CheckSetKeyMode;
  Result := FKeyBuffer.FieldCount;
end;

function TIBODataset.InitKeyBuffer( Buffer: PIBOKeyBuffer ): PIBOKeyBuffer;
begin
  FillChar( Buffer^, SizeOf(TIBOKeyBuffer) + FRecordSize, 0 );
  Result := Buffer;
end;

procedure TIBODataset.PostKeyBuffer( Commit: boolean );
begin
  DataEvent( deCheckBrowseMode, 0 );
  if Commit then
    FKeyBuffer.Modified := Modified
  else
    Move( FKeyBuffers[ kiSave ]^,
          FKeyBuffer^,
          SizeOf( TIBOKeyBuffer ) + FRecordSize );
  SetState( dsBrowse );
  DataEvent( deDataSetChange, 0 );
end;

procedure TIBODataset.SetIndexField( Index: Integer; Value: TField );
begin
  GetIndexField( Index ).Assign( Value );
end;

procedure TIBODataset.SetKeyBuffer( KeyIndex: TIBOKeyIndex; Clear: Boolean );
begin
  CheckBrowseMode;
  FKeyBuffer := FKeyBuffers[ KeyIndex ];
  Move( FKeyBuffer^,
        FKeyBuffers[ kiSave ]^,
        SizeOf( TIBOKeyBuffer ) + FRecordSize );
  if Clear then
    InitKeyBuffer( FKeyBuffer );
  SetState( dsSetKey );
  FKeyBuffer.FieldCount := IndexFieldCount;
  SetModified( FKeyBuffer.Modified );
  DataEvent( deDataSetChange, 0 );
end;

procedure TIBODataset.SetKeyExclusive( Value: Boolean );
begin
  CheckSetKeyMode;
  FKeyBuffer.Exclusive := Value;
end;

procedure TIBODataset.SetKeyFieldCount( Value: Integer );
begin
  CheckSetKeyMode;
  FKeyBuffer.FieldCount := Value;
end;

procedure TIBODataset.SetKeyFields(       KeyIndex: TIBOKeyIndex;
                                    const Values: array of const );
var
  ii: integer;
  SaveState: TDataSetState;
begin
  if IndexFieldCount = 0 then
    DatabaseError( SNoFieldIndexes );
  SaveState := SetTempState( dsSetKey );
  try
    FKeyBuffer := InitKeyBuffer( FKeyBuffers[KeyIndex] );
    for ii := 0 to High( Values ) do
      GetIndexField( ii ).AssignValue( Values[ii] );
    FKeyBuffer.FieldCount := High( Values ) + 1;
    FKeyBuffer.Modified := Modified;
  finally
    RestoreState( SaveState );
  end;
end;

{---}

function TIBODataset.FindKey( const KeyValues: array of const ): boolean;
begin
  CheckBrowseMode;
  SetKeyFields( kiIBOLookup, KeyValues );
  Result := GotoKey;
end;

procedure TIBODataset.FindNearest( const KeyValues: array of const );
begin
  CheckBrowseMode;
  SetKeyFields( kiIBOLookup, KeyValues );
  GotoNearest;
end;

{$IFDEF IBO_VCL40_OR_GREATER}
function TIBODataset.FindParam( AParamName: string ): TParam;
{$ELSE}
function TIBODataset.FindParam( AParamName: string ): TIB_Column;
{$ENDIF}
begin
{$IFDEF IBO_VCL40_OR_GREATER}
  Result := FParams.FindParam( AParamName );
{$ELSE}
  Result := InternalDataset.FindParam( AParamName );
{$ENDIF}
end;

function TIBODataset.GotoKey: Boolean;
begin
  Result := GotoRecord( false );
end;

procedure TIBODataset.GotoNearest;
begin
  GotoRecord( true );
end;

function TIBODataset.GotoRecord( LocateNearest: boolean ): boolean;
var
  ii: integer;
  cols: string;
  vals: variant;
  tmpFld: TField;
  SaveState: TDataSetState;
  fldCnt: integer;
begin
  CheckBrowseMode;
  DoBeforeScroll;
  CursorPosChanged;
  SaveState := SetTempState( dsSetKey );
  try
    FKeyBuffer := FKeyBuffers[ kiIBOLookup ];
    cols := '';
    fldCnt := KeyFieldCount;
    if fldCnt = 0 then
      fldCnt := IndexFieldCount;
    vals := VarArrayCreate( [ 0, FldCnt - 1 ], varVariant );
    for ii := 0 to FldCnt - 1 do
    begin
      tmpFld := GetIndexField( ii );
      if ii > 0 then
        cols := cols + ', ';
      cols := cols + tmpFld.FieldName;
{$IFDEF IBO_VCL40_OR_GREATER}
      if TmpFld.DataType = ftLargeInt then
        vals [ii] := TmpFld.AsString
      else
{$ENDIF}
        vals[ ii ] := tmpFld.AsVariant;
    end;
  finally
    RestoreState( SaveState );
  end;
  Result := LocateRecord( cols, vals, [], true, LocateNearest );
  if Result then
    DoAfterScroll;
end;

procedure TIBODataset.GotoCurrent( ADataset: TDataset );
begin
  Bookmark := ADataset.Bookmark;
end;

procedure TIBODataset.ApplyRange;
begin
  CheckBrowseMode;
  UpdateCursorPos;
  if SetCursorRange then
    Resync( [] );
end;

procedure TIBODataset.CancelRange;
begin
  CheckBrowseMode;
  UpdateCursorPos;
  if ResetCursorRange then
    Resync( [] );
end;

procedure TIBODataset.SetRange( const StartValues, EndValues: array of const );
begin
  CheckBrowseMode;
  SetKeyFields( kiIBORangeStart, StartValues );
  SetKeyFields( kiIBORangeEnd, EndValues );
  ApplyRange;
end;

procedure TIBODataset.SetKey;
begin SetKeyBuffer( kiIBOLookup, true ); end;
procedure TIBODataset.EditKey;
begin SetKeyBuffer( kiIBOLookup, false ); end;
procedure TIBODataset.SetRangeEnd;
begin SetKeyBuffer( kiIBORangeEnd, true ); end;
procedure TIBODataset.SetRangeStart;
begin SetKeyBuffer( kiIBORangeStart, true ); end;
procedure TIBODataset.EditRangeEnd;
begin SetKeyBuffer( kiIBORangeEnd, false ); end;
procedure TIBODataset.EditRangeStart;
begin SetKeyBuffer( kiIBORangeStart, false ); end;

function TIBODataset.SetCursorRange: boolean;
begin
  Result := False;
  if not (
     BuffersEqual( FKeyBuffers[ kiIBORangeStart ],
                   FKeyBuffers[ kiIBOCurRangeStart ],
                   SizeOf( TIBOKeyBuffer ) + FRecordSize ) and
     BuffersEqual( FKeyBuffers[ kiIBORangeEnd ],
                   FKeyBuffers[ kiIBOCurRangeEnd ],
                   SizeOf( TIBOKeyBuffer ) + FRecordSize )) then
  begin
    FSettingCursorRange := true;
    try
      if ( FKeyBuffers[ kiIBOCurRangeStart ].Modified <>
           FKeyBuffers[ kiIBORangeStart    ].Modified ) or
         ( FKeyBuffers[ kiIBOCurRangeStart ].Exclusive <>
           FKeyBuffers[ kiIBORangeStart    ].Exclusive ) or
         ( FKeyBuffers[ kiIBOCurRangeStart ].FieldCount <>
           FKeyBuffers[ kiIBORangeStart    ].FieldCount ) or
         ( FKeyBuffers[ kiIBOCurRangeEnd ].Modified <>
           FKeyBuffers[ kiIBORangeEnd    ].Modified ) or
         ( FKeyBuffers[ kiIBOCurRangeEnd ].Exclusive <>
           FKeyBuffers[ kiIBORangeEnd    ].Exclusive ) or
         ( FKeyBuffers[ kiIBOCurRangeEnd ].FieldCount <>
           FKeyBuffers[ kiIBORangeEnd    ].FieldCount ) then
        InvalidateSQL;
      Move( FKeyBuffers[ kiIBORangeStart ]^,
            FKeyBuffers[ kiIBOCurRangeStart ]^,
            SizeOf(TIBOKeyBuffer) + FRecordSize );
      Move( FKeyBuffers[ kiIBORangeEnd ]^,
            FKeyBuffers[ kiIBOCurRangeEnd ]^,
            SizeOf(TIBOKeyBuffer) + FRecordSize );
      InternalRefresh;
    finally
      FSettingCursorRange := false;
    end;
    Result := true;
  end;
end;

function TIBODataset.ResetCursorRange: boolean;
begin
  Result := false;
  if Assigned( FKeyBuffers[ kiIBOCurRangeStart ] ) then
  begin
    if FKeyBuffers[ kiIBOCurRangeStart ].Modified or
       FKeyBuffers[ kiIBOCurRangeEnd ].Modified then
    begin
      InitKeyBuffer( FKeyBuffers[ kiIBOCurRangeStart ] );
      InitKeyBuffer( FKeyBuffers[ kiIBOCurRangeEnd ] );
      FKeyBuffers[ kiIBOCurRangeStart ].Modified := false;
      FKeyBuffers[ kiIBOCurRangeEnd ].Modified := false;
      InvalidateSQL;
      if not IsClosing then
        InternalRefresh;
      Result := true;
    end;
  end;
end;

procedure TIBODataset.SysPrepareSQL;
var
  ii: integer;
  StartBuf, EndBuf: PIBOKeyBuffer;
  tmpFld: TField;
  tmpCol: TIB_Column;
  tmpName: string;
  tmpOp: string;
begin
  if Prepared and Assigned( FKeyBuffers[ kiIBORangeStart ] ) then
  begin
    if FSettingCursorRange then
    begin
      StartBuf := FKeyBuffers[ kiIBORangeStart ];
      EndBuf := FKeyBuffers[ kiIBORangeEnd ];
    end
    else
    begin
      StartBuf := FKeyBuffers[ kiIBOCurRangeStart ];
      EndBuf := FKeyBuffers[ kiIBOCurRangeEnd ];
    end;
    if StartBuf.Modified then
      for ii := 0 to StartBuf.FieldCount - 1 do
      begin
        tmpFld := GetIndexField( ii );
        tmpCol := InternalDataset.FieldByName( tmpFld.FieldName );
        if tmpCol.SQLName = '' then
          tmpName := tmpCol.FieldName
        else
          tmpName := tmpCol.SQLName;
        if StartBuf.Exclusive then
          tmpOp := ' > '
        else
          tmpOp := ' >= ';
        InternalDataset.SQLWhereItems.Add( tmpName +
                                           tmpOp + '?' + IB_RNGBEG +
                                           tmpFld.FieldName );
      end;
    if EndBuf.Modified then
      for ii := 0 to EndBuf.FieldCount - 1 do
      begin
        tmpFld := GetIndexField( ii );
        tmpCol := InternalDataset.FieldByName( tmpFld.FieldName );
        if tmpCol.SQLName = '' then
          tmpName := tmpCol.FieldName
        else
          tmpName := tmpCol.SQLName;
        if StartBuf.Exclusive then
          tmpOp := ' < '
        else
          tmpOp := ' <= ';
        InternalDataset.SQLWhereItems.Add( tmpName +
                                           tmpOp + '?' + IB_RNGEND +
                                           tmpFld.FieldName );
      end;
  end;
end;

procedure TIBODataset.DoAfterPrepare;
begin
  if Assigned( AfterPrepare ) then
    AfterPrepare( Self );
end;

procedure TIBODataset.DoBeforePrepare;
begin
  if Assigned( BeforePrepare ) then
    BeforePrepare( Self );
end;

procedure TIBODataset.SysPrepareFailed;
begin
end;

{------------------------------------------------------------------------------}

procedure TIBODataset.BeginCallbackFreeze;
begin InternalDataset.BeginCallbackFreeze; end;
procedure TIBODataset.EndCallbackFreeze;
begin InternalDataset.EndCallbackFreeze; end;
procedure TIBODataset.ExecuteImmediate( Statement: string; AParam: PXSQLDA );
begin
  InternalDataset.ExecuteImmediate( Statement, AParam );
end;
procedure TIBODataset.FetchCallback(     IB_Dataset: TIB_Dataset;
                                         Status: TIB_CallbackStatus;
                                         CursorRowNum: longint;
                                     var Abort: boolean );
begin
  if Assigned( FOnCallback ) then
    FOnCallback( Self, Status, CursorRowNum, Abort )
  else
    InternalDataset.DefaultProcessCallback( Status );
end;
function TIBODataset.GetParamCount: integer;
begin Result := InternalDataset.ParamCount; end;
function TIBODataset.GetAutoFetchAll: boolean;
begin Result := InternalDataset.AutoFetchAll; end;
procedure TIBODataset.SetAutoFetchAll( AValue: boolean );
begin InternalDataset.AutoFetchAll := AValue; end;
procedure TIBODataset.SetBufferSynchroFlags( AValue: TIB_BufferSynchroFlagsSet );
begin InternalDataset.BufferSynchroFlags := AValue; end;
function TIBODataset.GetBufferSynchroFlags: TIB_BufferSynchroFlagsSet;
begin Result := InternalDataset.BufferSynchroFlags; end;
function TIBODataset.GetCachedUpdates: boolean;
begin Result := InternalDataset.CachedUpdates; end;
procedure TIBODataset.SetCachedUpdates( AValue: boolean );
begin InternalDataset.CachedUpdates := AValue; end;
function TIBODataset.GetCallbackCaption: string;
begin Result := InternalDataset.CallbackCaption; end;
function TIBODataset.GetCallbackInc: integer;
begin Result := InternalDataset.CallbackInc; end;
function TIBODataset.GetCallbackInitInt: DWORD;
begin Result := InternalDataset.CallbackInitInt; end;
function TIBODataset.GetCallbackInitTick: DWORD;
begin Result := InternalDataset.CallbackInitTick; end;
function TIBODataset.GetCallbackRefreshInt: DWORD;
begin Result := InternalDataset.CallbackRefreshInt; end;
function TIBODataset.GetCallbackRefreshTick: DWORD;
begin Result := InternalDataset.CallbackRefreshTick end;
procedure TIBODataset.SetCallbackCaption( AValue: string );
begin InternalDataset.CallbackCaption := AValue; end;
procedure TIBODataset.SetCallbackInc( AValue: integer );
begin InternalDataset.CallbackInc := AValue; end;
procedure TIBODataset.SetCallbackInitInt( AValue: DWORD );
begin InternalDataset.CallbackInitInt := AValue; end;
procedure TIBODataset.SetCallbackRefreshInt( AValue: DWORD );
begin InternalDataset.CallbackRefreshInt := AValue; end;
procedure TIBODataset.SetCallbackRefreshTick( AValue: DWORD );
begin InternalDataset.CallbackRefreshTick := AValue; end;
function TIBODataset.GetCheckRequired: boolean;
begin Result := InternalDataset.CheckRequired; end;
procedure TIBODataset.SetCheckRequired( AValue: boolean );
begin InternalDataset.CheckRequired := AValue; end;
function TIBODataset.GetDefaultValues: TIB_StringList;
begin Result := InternalDataset.DefaultValues; end;
procedure TIBODataset.SetDefaultValues( AValue: TIB_StringList );
begin InternalDataset.DefaultValues := AValue; end;
function TIBODataset.GetFetchWholeRows: boolean;
begin Result := InternalDataset.FetchWholeRows; end;
procedure TIBODataset.SetFetchWholeRows( AValue: boolean );
begin InternalDataset.FetchWholeRows := AValue; end;
function TIBODataset.GetFieldsAlignment: TIB_StringList;
begin Result := InternalDataset.FieldsAlignment; end;
function TIBODataset.GetFieldsDisplayLabel: TIB_StringList;
begin Result := InternalDataset.FieldsDisplayLabel; end;
function TIBODataset.GetFieldsDisplayFormat: TIB_StringList;
begin Result := InternalDataset.FieldsDisplayFormat; end;
function TIBODataset.GetFieldsReadOnly: TIB_StringList;
begin Result := InternalDataset.FieldsReadOnly; end;
function TIBODataset.GetFieldsEditMask: TIB_StringList;
begin Result := InternalDataset.FieldsEditMask; end;
function TIBODataset.GetFieldsVisible: TIB_StringList;
begin Result := InternalDataset.FieldsVisible; end;
procedure TIBODataset.SetFieldsAlignment( AValue: TIB_StringList );
begin InternalDataset.FieldsAlignment := AValue; end;
procedure TIBODataset.SetFieldsDisplayLabel( AValue: TIB_StringList );
begin InternalDataset.FieldsDisplayLabel := AValue; end;
procedure TIBODataset.SetFieldsDisplayFormat( AValue: TIB_StringList );
begin InternalDataset.FieldsDisplayFormat := AValue; end;
procedure TIBODataset.SetFieldsReadOnly( AValue: TIB_StringList );
begin InternalDataset.FieldsReadOnly := AValue; end;
procedure TIBODataset.SetFieldsEditMask( AValue: TIB_StringList );
begin InternalDataset.FieldsEditMask := AValue; end;
procedure TIBODataset.SetFieldsVisible( AValue: TIB_StringList );
begin InternalDataset.FieldsVisible := AValue; end;
function TIBODataset.GetMaxRows: integer;
begin Result := InternalDataset.MaxRows; end;
procedure TIBODataset.SetMaxRows( AValue: integer );
begin InternalDataset.MaxRows := AValue; end;
function TIBODataset.GetDatabaseName: string;
begin Result := InternalDataset.DatabaseName; end;
procedure TIBODataset.SetDatabaseName( AValue: string );
begin InternalDataset.DatabaseName := AValue; end;
procedure TIBODataset.SetColumnAttributes( AValue: TIB_StringList);
begin InternalDataset.ColumnAttributes.Assign( AValue ); end;
function TIBODataset.GetColumnAttributes: TIB_StringList;
begin Result := InternalDataset.ColumnAttributes; end;
procedure TIBODataset.SetSQL( Value: TStrings);
begin InternalDataset.SQL.Text := Value.Text; end;
function TIBODataset.GetSQL: TStrings;
begin Result := InternalDataset.SQL; end;
procedure TIBODataset.SetSQLForUpdate( Value: TStrings);
begin InternalDataset.SQLForUpdate.Assign( Value ); end;
procedure TIBODataset.SetSQLOrder( Value: TStrings);
begin InternalDataset.SQLOrder.Assign( Value ); end;
procedure TIBODataset.SetSQLWhere( Value: TStrings);
begin InternalDataset.SQLWhere.Assign( Value ); end;
function TIBODataset.GetSQLForUpdate: TStrings;
begin Result := InternalDataset.SQLForUpdate; end;
function TIBODataset.GetSQLOrder: TStrings;
begin Result := InternalDataset.SQLOrder; end;
function TIBODataset.GetSQLWhere: TStrings;
begin Result := InternalDataset.SQLWhere; end;
function TIBODataset.GetSQLWhereItems: TStrings;
begin Result := InternalDataset.SQLWhereItems; end;
function TIBODataset.GetJoinLinks: TIB_StringList;
begin Result := InternalDataset.JoinLinks; end;
procedure TIBODataset.SetJoinLinks( AValue: TIB_StringList );
begin InternalDataset.JoinLinks.Assign( AValue ); end;
function TIBODataset.GetKeyFields: TIB_Row;
begin Result := InternalDataset.KeyFields; end;
function TIBODataset.GetKeyLinks: TIB_StringList;
begin Result := InternalDataset.KeyLinks; end;
function TIBODataset.IsKeyLinksStored: boolean;
begin Result := InternalDataset.IsKeyLinksStored; end;
procedure TIBODataset.SetKeyLinks( AValue: TIB_StringList );
begin InternalDataset.KeyLinks.Assign( AValue ); end;
function TIBODataset.GetKeyLinksAutoDefine: boolean;
begin Result := InternalDataset.KeyLinksAutoDefine; end;
procedure TIBODataset.SetKeyLinksAutoDefine( AValue: boolean );
begin InternalDataset.KeyLinksAutoDefine := AValue; end;
function TIBODataset.GetPlan: string;
begin Result := InternalDataset.StatementPlan; end;
function TIBODataset.RecordCountAll: longint;
begin Result := InternalDataset.RecordCount; end;
function TIBODataset.GetRowsAffected: longint;
begin Result := InternalDataset.RowsAffected; end;
procedure TIBODataset.SetRecordCountAccurate( AValue: boolean );
begin
  if FRecordCountAccurate <> AValue then
  begin
    FRecordCountAccurate := AValue;
    DataEvent( deLayoutChange, 0 );
  end;
end;
function TIBODataSet.IsSequenced: Boolean;
begin
  Result := false;
  if not Assigned( InternalDataset.OrderingParam ) then
    Result := not FRecordCountAccurate or AutoFetchAll;
end;
function TIBODataset.GetCommitAction: TIB_CommitAction;
begin Result := InternalDataset.CommitAction; end;
procedure TIBODataset.SetCommitAction( AValue: TIB_CommitAction );
begin InternalDataset.CommitAction := AValue; end;
function TIBODataset.GetRequestLive: boolean;
begin Result := InternalDataset.RequestLive; end;
procedure TIBODataset.SetRequestLive( AValue: boolean );
begin InternalDataset.RequestLive := AValue; end;
function TIBODataset.GetServerSQL: string;
begin Result := InternalDataset.ServerSQL; end;
procedure TIBODataset.SetConnection( Value: TIB_Connection);
begin InternalDataset.IB_Connection := Value; end;
procedure TIBODataset.SetTransaction( Value: TIB_Transaction);
begin InternalDataset.IB_Transaction := Value; end;
function TIBODataset.GetConnection: TIB_Connection;
begin Result := InternalDataset.IB_Connection; end;
function TIBODataset.IsTransactionStored: boolean;
begin Result := InternalDataset.IsTransactionStored; end;
function TIBODataset.IsConnectionStored: boolean;
begin Result := InternalDataset.IsConnectionStored; end;
function TIBODataset.IsPreparedStored: boolean;
begin Result := IB_Session.StoreActive and Prepared and not Active; end;
function TIBODataset.GetTransaction: TIB_Transaction;
begin Result := InternalDataset.IB_Transaction; end;
function TIBODataset.GetStatementType: TIB_StatementType;
begin Result := InternalDataset.StatementType; end;
function TIBODataset.GetCanModify: boolean;
begin
  if Assigned( IB_Transaction ) and IB_Transaction.ReadOnly then
    Result := false
  else
  begin
    Result := InternalDataset.NeedToPost;
    if not Result then
      Result := not FReadOnly;
  end;
{!!!
  begin
    CursorPosChanged;
    UpdateCursorPos;
    InternalDataset.RowNum := InternalDataset.BufferRowNum;
    Result := InternalDataset.CanModify;
  end;
}
end;
function TIBODataset.GetIB_Session: TIB_Session;
begin Result := InternalDataset.IB_Session; end;
function TIBODataset.GetReadOnly: boolean;
begin Result := FReadOnly; end;
procedure TIBODataset.SetReadOnly( AValue: boolean );
begin FReadOnly := AValue; InternalDataset.ReadOnly := AValue; end;
function TIBODataset.GetPessimisticLocking: boolean;
begin Result := InternalDataset.PessimisticLocking; end;
procedure TIBODataset.SetPessimisticLocking( AValue: boolean );
begin InternalDataset.PessimisticLocking := AValue; end;
function TIBODataset.GetPrepared: boolean;
begin Result := InternalDataset.Prepared; end;
procedure TIBODataset.SetPrepared( AValue: boolean );
begin
  if (csReading in ComponentState) then
  begin
    if AValue then
      FStreamedPrepared := True;
  end
  else
  begin
    if AValue then
      Prepare
    else
      Unprepare;
    FStreamedPrepared := false;
  end;
end;
procedure TIBODataset.Prepare;
begin InternalDataset.Prepare; end;
procedure TIBODataset.Unprepare;
begin
  if Active then Close;
  InternalDataset.Unprepare;
end;
function TIBODataset.GetIsSelectSQL: boolean;
begin Result := InternalDataset.IsSelectSQL; end;

function TIBODataset.GetOrderingItemNo: integer;
begin
  Result := InternalDataset.OrderingItemNo;
end;
function TIBODataset.GetOrderingItems: TIB_StringList;
begin
  Result := InternalDataset.OrderingItems;
end;
function TIBODataset.GetOrderingLinks: TIB_StringList;
begin
  Result := InternalDataset.OrderingLinks;
end;
procedure TIBODataset.SetOrderingItemNo( Value: integer );
begin
  InternalDataset.OrderingItemNo := Value;
end;
procedure TIBODataset.SetOrderingItems( Value: TIB_StringList );
begin
  InternalDataset.OrderingItems.Assign( Value );
end;
procedure TIBODataset.SetOrderingLinks( Value: TIB_StringList );
begin
  InternalDataset.OrderingLinks.Assign( Value );
end;

{$IFDEF IBO_VCL40_OR_GREATER}
function TIBODataset.GetParams: TParams;
{$ELSE}
function TIBODataset.GetParams: TIB_Row;
{$ENDIF}
begin
{$IFDEF IBO_VCL40_OR_GREATER}
  Result := FParams;
{$ELSE}
  Result := InternalDataset.Params;
{$ENDIF}
end;
{$IFDEF IBO_VCL40_OR_GREATER}
procedure TIBODataset.SetParams( AParams: TParams );
{$ELSE}
procedure TIBODataset.SetParams( AParams: TIB_Row );
{$ENDIF}
begin
{$IFDEF IBO_VCL40_OR_GREATER}
  if ( csReading in ComponentState ) then
    FParams.Assign( AParams )
  else
    FParams.AssignValues( AParams );
{$ELSE}
  if InternalDataset.Params <> AParams then
    InternalDataset.Params.RowData := AParams.RowData;
{$ENDIF}
end;
procedure TIBODataset.SetGeneratorLinks( AValue: TIB_StringList );
begin InternalDataset.GeneratorLinks := AValue; end;
function TIBODataset.GetGeneratorLinks: TIB_StringList;
begin Result := InternalDataset.GeneratorLinks; end;
function TIBODataset.GetParamCheck: boolean;
begin Result := InternalDataset.ParamCheck; end;
procedure TIBODataset.SetParamCheck( AValue: boolean );
begin InternalDataset.ParamCheck := AValue; end;
function TIBODataset.GetUpdatesPending: boolean;
begin Result := InternalDataset.UpdatesPending; end;
{$IFDEF IBO_VCL50_OR_GREATER}
function TIBODataset.GetOnUpdateError: TUpdateErrorEvent;
begin Result := TUpdateErrorEvent(InternalDataset.OnUpdateError); end;
function TIBODataset.GetOnUpdateRecord: TUpdateRecordEvent;
begin Result := TUpdateRecordEvent(InternalDataset.OnUpdateRecord); end;
procedure TIBODataset.SetOnUpdateError( AValue: TUpdateErrorEvent );
begin InternalDataset.OnUpdateError := TIB_UpdateErrorEvent(AValue); end;
procedure TIBODataset.SetOnUpdateRecord( AValue: TUpdateRecordEvent );
begin InternalDataset.OnUpdateRecord := TIB_UpdateRecordEvent(AValue); end;
{$ELSE}
function TIBODataset.GetOnUpdateError: TIB_UpdateErrorEvent;
begin Result := InternalDataset.OnUpdateError; end;
function TIBODataset.GetOnUpdateRecord: TIB_UpdateRecordEvent;
begin Result := InternalDataset.OnUpdateRecord; end;
procedure TIBODataset.SetOnUpdateError( AValue: TIB_UpdateErrorEvent );
begin InternalDataset.OnUpdateError := AValue; end;
procedure TIBODataset.SetOnUpdateRecord( AValue: TIB_UpdateRecordEvent );
begin InternalDataset.OnUpdateRecord := AValue; end;
{$ENDIF}
procedure TIBODataset.Post;
begin
  if not FIsPosting then
    try
      FIsPosting := true;
      inherited Post;
      if State = dsSetKey then
        PostKeyBuffer( true );
    finally
      FIsPosting := false;
    end;
end;
procedure TIBODataset.Cancel;
begin
  if not FIsCanceling then
    try
      FIsCanceling := true;
      inherited Cancel;
      if State = dsSetKey then
        PostKeyBuffer( false );
    finally
      FIsCanceling := false;
    end;
end;

function TIBODataset.GeneratorValue( AGenerator: string;
                                     Increment: integer ): ISC_INT64;
begin
  Result := InternalDataset.GeneratorValue( AGenerator, Increment );
end;

function TIBODataset.CompareBookmarks( ABookmark1,
                                       ABookmark2: TBookmark ): Integer;
var
  B1, B2: integer;
  BS1, BS2: string;
  oldBK: string;
begin
  B1 := 0;
  B2 := 0;
  if Assigned( ABookmark1 ) and Assigned( ABookmark2 ) then
  begin
    SetLength( BS1, BookmarkSize );
    SetLength( BS2, BookmarkSize );
    Move( ABookmark1^, pointer( BS1 )^, BookmarkSize );
    Move( ABookmark2^, pointer( BS2 )^, BookmarkSize );
    oldBK := InternalDataset.BufferBookmark;
    try
      InternalDataset.BufferBookmark := BS1;
      B1 := InternalDataset.BufferRowNum;
      if B1 < InternalDataset.BofRowNum then
        B1 := InternalDataset.BofRowNum;
      InternalDataset.BufferBookmark := BS2;
      B2 := InternalDataset.BufferRowNum;
      if B2 < InternalDataset.BofRowNum then
        B2 := InternalDataset.BofRowNum;
    finally
      InternalDataset.BufferBookmark := oldBK;
    end;
  end;
  if B1 = B2 then
    Result := 0
  else
  if B1 > B2 then
    Result := 1
  else
    Result := -1;
end;

procedure TIBODataset.GetBookmarkData( Buffer: PChar; Data: Pointer );
var
  B: string;
  RecInfo: PIBORecInfo;
begin
  if not IsEmpty then
  begin
    RecInfo := PIBORecInfo(Buffer + FRecInfoOfs);
    B := BinaryToHexText( RecInfo.RecRowNode.KeyData, BookmarkSize div 2 );
    Move( pointer( B )^, Data^, BookmarkSize );
  end;
end;

procedure TIBODataset.SetBookmarkData( Buffer: PChar; Data: Pointer );
var
  RecInfo: PIBORecInfo;
begin
  RecInfo := PIBORecInfo(Buffer + FRecInfoOfs);
  if Assigned( RecInfo.RecRowNode ) then
    HexTextToBinary( PChar( Data ),
                     RecInfo.RecRowNode.KeyData,
                     BookmarkSize div 2 );
end;
function TIBODataset.GetDeleteSQL: TIB_StringList;
begin Result := InternalDataset.DeleteSQL; end;
function TIBODataset.GetEditSQL: TIB_StringList;
begin Result := InternalDataset.EditSQL; end;
function TIBODataset.GetLockSQL: TIB_StringList;
begin Result := InternalDataset.LockSQL; end;
function TIBODataset.GetInsertSQL: TIB_StringList;
begin Result := InternalDataset.InsertSQL; end;
procedure TIBODataset.SetDeleteSQL( AValue: TIB_StringList );
begin InternalDataset.DeleteSQL.Assign( AValue ); end;
procedure TIBODataset.SetEditSQL( AValue: TIB_StringList );
begin InternalDataset.EditSQL.Assign( AValue ); end;
procedure TIBODataset.SetLockSQL( AValue: TIB_StringList );
begin InternalDataset.LockSQL.Assign( AValue ); end;
procedure TIBODataset.SetInsertSQL( AValue: TIB_StringList );
begin InternalDataset.InsertSQL.Assign( AValue ); end;
function TIBODataset.GetIsIndexField(Field: TField): Boolean;
begin
  Result := InternalDataset.SQLOrderLinks.LinkIndex[ Field.FieldName ] >= 0;
end;

{------------------------------------------------------------------------------}

procedure TIBODataset.SetFilterText( const Value: string );
var
  tmpBookmark: string;
begin
  if Filter <> Value then
    if Active and Filtered then
    begin
      CheckBrowseMode;
      UpdateCursorPos;
      tmpBookmark := InternalDataset.BufferBookmark;
      DoBeforeScroll;
      InternalDataset.RowNum := InternalDataset.BufferRowNum;
      InternalDataset.Filter := Value;
      inherited SetFilterText( Value );
      SysResync( [ rmCenter ] );
      if InternalDataset.Bookmark <> tmpBookmark then
        DoAfterScroll;
    end
    else
    begin
      InternalDataset.Filter := Value;
      inherited SetFilterText( Value );
    end;
end;

procedure TIBODataset.SetFiltered( AValue: boolean );
var
  tmpBookmark: string;
begin
  if Filtered <> AValue then
    if Active then
    begin
      CheckBrowseMode;
      UpdateCursorPos;
      tmpBookmark := InternalDataset.BufferBookmark;
      DoBeforeScroll;
      InternalDataset.RowNum := InternalDataset.BufferRowNum;
      InternalDataset.Filtered := AValue;
      inherited SetFiltered( AValue );
      SysResync( [ rmCenter ] );
      if InternalDataset.Bookmark <> tmpBookmark then
        DoAfterScroll;
    end
    else
    begin
      InternalDataset.Filtered := AValue;
      inherited SetFiltered( AValue );
    end;
end;

procedure TIBODataset.SetOnFilterRecord( const Value: TFilterRecordEvent );
begin
  inherited SetOnFilterRecord( Value );
  if Assigned( Value ) then
    InternalDataset.OnFilterRecord := RecordFilter
  else
    InternalDataset.OnFilterRecord := nil;
  if Active then
  begin
    CheckBrowseMode;
    RefreshFilteredRows;
  end;
end;

procedure TIBODataset.SetFilterOptions( AValue: TFilterOptions );
var
  tmpBookmark: string;
begin
  if FilterOptions <> AValue then
    if Active and Filtered then
    begin
      CheckBrowseMode;
      UpdateCursorPos;
      tmpBookmark := InternalDataset.BufferBookmark;
      DoBeforeScroll;
      InternalDataset.RowNum := InternalDataset.BufferRowNum;
      InternalDataset.FilterOptions := TIB_FilterOptions( AValue );
      inherited SetFilterOptions( AValue );
      SysResync( [ rmCenter ] );
      if InternalDataset.Bookmark <> tmpBookmark then
        DoAfterScroll;
    end
    else
    begin
      InternalDataset.FilterOptions := TIB_FilterOptions( AValue );
      inherited SetFilterOptions( AValue );
    end;
end;

{------------------------------------------------------------------------------}

procedure TIBODataset.ExecSQL;
begin
  CheckInactive;
  FIncludeOutputParams := true;
  try
{$IFDEF IBO_VCL40_OR_GREATER}
    if not Prepared then
      Prepare
    else
      SysUpdateParams;
    if not InternalDataset.SQLIsValid then
{$ENDIF}
      Prepare;
    if IsSelectSQL then
      Open
    else
      InternalDataset.ExecSQL;
  except
    FIncludeOutputParams := false;
    raise;
  end;
end;

procedure TIBODataset.FetchAll;
begin
  Prepare;
  Open;
  InternalDataset.FetchAll;
end;

function TIBODataset.ParamByName( AParam: string ): TIB_Column;
begin
  Result := InternalDataset.ParamByName( AParam );
end;

{------------------------------------------------------------------------------}

procedure TIBODataset.ApplyUpdates;
begin
  InternalDataset.ApplyUpdates;
end;

procedure TIBODataset.CancelUpdates;
begin
  InternalDataset.CancelUpdates;
end;

procedure TIBODataset.CommitUpdates;
begin
  InternalDataset.CommitUpdates;
end;

procedure TIBODataset.RevertRecord;
begin
  UpdateCursorPos;
  InternalDataset.RowNum := InternalDataset.BufferRowNum;
  InternalDataset.RevertRecord;
  Resync( [rmExact] );
end;

procedure TIBODataset.AbortFetching;
begin
  InternalDataset.AbortFetching;
end;

procedure TIBODataset.AssignSQLWithSearch( ADataset: TIB_Dataset );
begin
  with InternalDataset.SQL as TIB_SQLStrings do
    AssignWithSearch( ADataset.SQL as TIB_SQLStrings );
end;

procedure TIBODataset.BeginBusy( Yield: boolean );
begin
  InternalDataset.BeginBusy( Yield );
end;

procedure TIBODataset.EndBusy;
begin
  InternalDataset.EndBusy;
end;

procedure TIBODataset.ClearCalcFields( Buffer: PChar );
begin
  FillChar( Buffer[RecordSize], CalcFieldsSize, 0 );
end;
                             
function TIBODataset.BookmarkValid( ABookmark: TBookmark ): Boolean;
var
  BS: string;
  NR: TIB_NodeRef;
begin
  Result := Assigned( ABookmark );
  if Result then
    with InternalDataset.NodeList do
      if ( FilterDel and ( BofRef.DelCnt + EofRef.DelCnt > 0 )) or
         ( Filtered  and ( BofRef.FilCnt + EofRef.FilCnt > 0 )) then
      begin
        SetLength( BS, BookmarkSize );
        Move( ABookmark^, BS[1], BookmarkSize );
        InternalDataset.KeyFields.RowData := BS;
        if LookupNode( KeyFields.RowBuffer, true, NR ) then
          Result := not (( rfDeleted  in NR.Node.RowFlags ) and FilterDel ) and
                    not (( rfFiltered in NR.Node.RowFlags ) and Filtered  );
      end;
end;

function TIBODataSet.BookmarkAvailable: Boolean;
begin
  Result := (State in [dsBrowse, dsEdit, dsInsert]) and not IsEmpty and
            (GetBookmarkFlag(ActiveBuffer) in [ bfCurrent, bfInserted ]);
  if Result and InternalDataset.NeedToPost then
    InternalDataset.SysUpdateKeyData( false );
end;

function TIBODataSet.GetBookmark: TBookmark;
var
  B: string;
begin
  B := GetBookmarkStr;
  Result := nil;
  if B <> '' then
  begin
    GetMem( Result, BookmarkSize );
    Move( pointer( B )^, Result^, BookmarkSize );
  end;
end;

function TIBODataSet.GetBookmarkStr: TBookmarkStr;
var
  ARecBuf: pointer;
  ACalcBuf: pointer;
  ARowNode: PIB_Node;
begin
  Result := '';
  if BookmarkAvailable then
  begin
    if GetActiveRecBuf( ARecBuf, ACalcBuf, ARowNode ) then
    begin
      Result := BinaryToHexText( ARowNode.KeyData, BookmarkSize div 2 );
    end;
  end;
end;

function TIBODataset.CreateBlobStream( Field: TField;
                                       Mode: TBlobStreamMode ): TStream;
begin
  Result := TIBOBlobStream.Create( Field as TBlobField, Mode );
end;

function TIBODataset.FindRecord( Restart, GoForward: boolean ): boolean;
begin
  CheckBrowseMode;
  DoBeforeScroll;
  SetFound(False);
  UpdateCursorPos;
  InternalDataset.RowNum := InternalDataset.BufferRowNum;
  Result := InternalDataset.FindRecord( Restart, GoForward );
  if Result then
  begin
    SysResync( [ rmExact, rmCenter ] );
    SetFound(True);
    DoAfterScroll;
  end;
end;

procedure TIBODataset.RecordFilter( ARow: TIB_Row; var Accept: boolean );
var
  SaveState: TDatasetState;
begin
  SaveState := SetTempState( dsCalcFields );
  try
    Move( ARow.RowBuffer^, TempBuffer^, RecordSize );
    CalculateFields( TempBuffer );
  except
    Application.HandleException( Self );
  end;
  RestoreState( SaveState );
  SaveState := SetTempState( dsFilter );
  try
    Accept := true;
    FFilterBuffer := TempBuffer;
    OnFilterRecord( Self, Accept );
  except
    Application.HandleException( Self );
  end;
  RestoreState( SaveState );
end;

procedure TIBODataset.InvalidateBookmark( ABookmark: TBookmarkStr );
begin
  CheckActive;
  InternalDataset.InvalidateBookmark( ABookmark );
  UpdateCursorPos;
  Resync( [] );
end;

procedure TIBODataset.InvalidateRowNum( ARowNum: longint );
begin
  CheckActive;
  UpdateCursorPos;
  InternalDataset.InvalidateRowNum( ARowNum );
  Resync( [] );
  UpdateCursorPos;
  Resync( [] );
end;

procedure TIBODataset.RefreshRows;
begin
  CheckActive;
  InvalidateRows;
end;

procedure TIBODataset.RefreshKeys;
begin
  CheckActive;
  UpdateCursorPos;
  InternalDataset.RefreshKeys;
  Resync( [] );
end;

procedure TIBODataset.RefreshFilteredRows;
var
  tmpBookmark: string;
begin
  CheckBrowseMode;
  UpdateCursorPos;
  tmpBookmark := InternalDataset.BufferBookmark;
  DoBeforeScroll;
  InternalDataset.RowNum := InternalDataset.BufferRowNum;
  InternalDataset.RefreshFilteredRows;
  SysResync( [ rmCenter ] );
  if InternalDataset.Bookmark <> tmpBookmark then
    DoAfterScroll;
end;

procedure TIBODataset.InvalidateRows;
begin
  UpdateCursorPos;
  InternalDataset.InvalidateRows;
  if Active then
    Resync( [] );
end;

procedure TIBODataset.InvalidateSQL;
begin
  InternalDataset.InvalidateSQL;
end;

function TIBODataset.Lookup( const KeyFields: string;
                             const KeyValues: Variant;
                             const ResultFields: string ): Variant;
begin
  Result := Null;
  if LocateRecord( KeyFields, KeyValues, [], false, false ) then
  begin
    SetTempState( dsCalcFields );
    try
      CalculateFields( TempBuffer );
      Result := FieldValues[ ResultFields ];
    finally
      RestoreState( dsBrowse );
    end;
  end;
end;

function TIBODataset.Locate( const KeyFields: string;
                             const KeyValues: Variant;
                             Options: TLocateOptions ): Boolean;
begin
  Result := LocateRecord( KeyFields, KeyValues, Options, true, false );
  if Result then 
    DoAfterScroll;
end;

function TIBODataset.LocateRecord( const AKeyFields: string;
                                   const AKeyValues: Variant;
                                         AOptions: TLocateOptions;
                                         SyncCursor: boolean;
                                         LocateNearest: boolean ): boolean;
begin
  CheckActive;
  Result := InternalDataset.LocateRecord( AKeyFields,
                                          AKeyValues,
                                          TIB_LocateOptions( AOptions ),
                                          SyncCursor,
                                          LocateNearest );
  if Result then
  begin
    if SyncCursor then
    begin
      DoBeforeScroll;
      if LocateNearest then
        SysResync( [ rmCenter ] )
      else
        SysResync( [ rmExact, rmCenter ] );
    end
    else
    begin
      Move( InternalDataset.BufferFields.RowBuffer^, TempBuffer^, RecordSize );
      with PIBORecInfo(TempBuffer + FRecInfoOfs)^ do
      begin
        RecRowNum := InternalDataset.BufferRowNum;
        RecRowNode := InternalDataset.BufferFields.RowNode;
        BookmarkFlag := bfCurrent;
      end;
      GetCalcFields( TempBuffer );
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TIBODataset.SetDataSource( AValue: TDataSource );
begin
  if IsLinkedTo( AValue ) then
    DatabaseError( SCircularDataLink );
  FDataLink.DataSource := AValue;
end;

function TIBODataset.GetDataSource: TDataSource;
begin Result := FDataLink.DataSource; end;

function TIBODataset.IsCursorOpen: boolean;
begin
  Result := Assigned( InternalDataset ) and InternalDataset.FIsCursorOpen;
end;

procedure TIBODataset.InternalHandleException;
begin Application.HandleException( Self ); end;
procedure TIBODataset.InternalFirst;
var
  FA: integer;
begin
  FA := InternalDataset.FetchingAbortedGen;
  if not InternalDataset.NeedToPost then
    InternalDataset.GotoBOF;
  if ( not InternalDataset.BufferHasBof ) and
     ( FA = InternalDataset.FetchingAbortedGen ) then
    InternalDataset.FetchAll; // !!! Try to figure something else out here...
  FCurRowNum := InternalDataset.BofRowNum;
end;
procedure TIBODataset.InternalLast;
var
  FA: integer;
begin
  FA := InternalDataset.FetchingAbortedGen;
  if not InternalDataset.NeedToPost then
    InternalDataset.GotoEOF;
  if ( not InternalDataset.BufferHasEof ) and
     ( FA = InternalDataset.FetchingAbortedGen ) then
    InternalDataset.FetchAll; // !!! Try to figure something else out here...
  FCurRowNum := InternalDataset.EofRowNum;
  if FRecAppended then
    Dec( FCurRowNum );
end;
function TIBODataset.GetRecordSize: Word;
begin Result := FRecordSize; end;
function TIBODataset.AllocRecordBuffer: PChar;
begin Result := AllocMem( FRecBufSize ); end;
procedure TIBODataset.FreeRecordBuffer(var Buffer: PChar);
begin FreeMem( Buffer ); end;
procedure TIBODataset.InternalInitRecord( Buffer: PChar );
begin FillChar( Buffer^, FRecBufSize, #0 ); end;
function TIBODataset.GetBookmarkFlag( Buffer: PChar ): TBookmarkFlag;
begin
  Result := PIBORecInfo(Buffer + FRecInfoOfs).BookmarkFlag;
end;
procedure TIBODataset.SetBookmarkFlag( Buffer: PChar; Value: TBookmarkFlag );
begin
  PIBORecInfo(Buffer + FRecInfoOfs).BookmarkFlag := Value;
end;

procedure TIBODataset.InternalGotoBookmark( ABookmark: Pointer );
var
  BS: string;
  function LookAround( Forwards: boolean; WindowSize: integer ): boolean;
  begin
    if Forwards then
    begin
      if not InternalDataset.BufferHasEof then
        InternalDataset.ValidateRows( InternalDataset.EofRowNum,
                                      InternalDataset.EofRowNum + WindowSize );
    end
    else
    begin
      if not InternalDataset.BufferHasBof then
        InternalDataset.ValidateRows( InternalDataset.BofRowNum,
                                      InternalDataset.BofRowNum - WindowSize );
    end;
    InternalDataset.BufferBookmark := BS;
    Result := ( InternalDataset.BufferRowNum <> InvalidNodePos ) and
              ( InternalDataset.BufferRowNum <> StoredNodePos );
  end;
begin
  if Assigned( ABookmark ) then
  begin
    SetLength( BS, BookmarkSize );
    Move( ABookmark^, BS[1], BookmarkSize );
    if ( InternalDataset.BufferBookmark <> BS ) or
       (( InternalDataset.BufferRowNum = InvalidNodePos ) or
        ( InternalDataset.BufferRowNum = StoredNodePos )) then
    begin
      InternalDataset.BufferBookmark := BS;
      if (( InternalDataset.BufferRowNum = InvalidNodePos ) or
          ( InternalDataset.BufferRowNum = StoredNodePos )) and
         not LookAround( true, 20 ) and
         not LookAround( false, 20 ) then
      begin
        if State = dsBrowse then
        begin
          InternalDataset.Bookmark := BS;
          InternalDataset.BufferBookmark := BS;
        end;
        if InternalDataset.BufferRowNum = StoredNodePos then
          while not InternalDataset.BufferHasEof do
            if LookAround( true, 200 ) then
              Break;
        if InternalDataset.BufferRowNum = StoredNodePos then
          while not InternalDataset.BufferHasBof do
            if LookAround( false, 200 ) then
              Break;
        if (( InternalDataset.BufferRowNum = InvalidNodePos ) or
            ( InternalDataset.BufferRowNum = StoredNodePos )) then
          InternalDataset.BufferGotoNull;
      end;
    end;
  end
  else
    InternalDataset.BufferGotoNull;
  if FCurRowNum <> InternalDataset.BufferRowNum then
  begin
    FCurRowNum := InternalDataset.BufferRowNum;
    CursorPosChanged;
  end;
end;

procedure TIBODataset.InternalSetToRecord( Buffer: PChar );
var
  RecInfo: PIBORecInfo;
  Buf: TBookmark;
begin
  RecInfo := PIBORecInfo( Buffer + FRecInfoOfs );
  InternalDataset.BufferRowNum := RecInfo.RecRowNum;
  if ( Assigned( InternalDataset.BufferFields.RowNode )) and
     ( InternalDataset.BufferFields.RowNode = RecInfo.RecRowNode ) and
     ( BuffersEqual( InternalDataset.BufferFields.RowNode.KeyData,
                     RecInfo.RecRowNode.KeyData,
                     InternalDataset.NodeList.KeyDataLength ) ) then
    FCurRowNum := InternalDataset.BufferRowNum
  else
  begin
    Buf := StrAlloc( Self.BookmarkSize );
    try
      GetBookmarkData( Buffer, Buf );
      InternalGotoBookmark( Buf );
    finally
      StrDispose( Buf );
    end;
  end;
end;

function TIBODataset.GetCurrentRecord( Buffer: PChar ): Boolean;
var
  tmpBuffer: pointer;
begin
  Result := False;
  tmpBuffer := ActiveBuffer;
  if Assigned( Buffer ) and Assigned( tmpBuffer ) then
  begin
    Move( tmpBuffer^, Buffer^, RecordSize );
    Result := true;
  end;
end;

function TIBODataset.GetRecord( Buffer: PChar;
                                GetMode: TGetMode;
                                DoCheck: boolean ): TGetResult;
begin
  Result := grOK;
  case GetMode of
    gmNext:
    begin
      InternalDataset.BufferRowNum := FCurRowNum + 1;
      if ( InternalDataset.BufferEof ) or
         ( FRecAppended and ( InternalDataset.BufferRowNum =
                              InternalDataset.EofRowNum - 1 )) then
      begin
        InternalDataset.BufferRowNum := FCurRowNum;
        Result := grEof;
      end
      else
      begin
        Inc( FCurRowNum );
      end;
    end;
    gmPrior:
    begin
    // For some reason it is necessary to feel ahead.
    // Otherwise a double record appears at the top of the buffer.
    // This will only apply when using dataset refinement.
      if not InternalDataset.BufferHasBof then
        InternalDataset.ValidateRows( FCurRowNum - 2, FCurRowNum - 1 );
      InternalDataset.BufferRowNum := FCurRowNum - 1;
      if InternalDataset.BufferBof then
      begin
        InternalDataset.BufferRowNum := FCurRowNum;
        Result := grBof;
      end
      else
      begin
        Dec( FCurRowNum );
      end;
    end;
    gmCurrent:
    begin
      InternalDataset.BufferRowNum := FCurRowNum;
      if InternalDataset.BufferBof or
         InternalDataset.BufferEof then
        Result := grError;
    end;
  end;
  case Result of
    grOk: begin
      Move( InternalDataset.BufferFields.RowBuffer^, Buffer^, RecordSize );
      with PIBORecInfo(Buffer + FRecInfoOfs)^ do
      begin
        RecRowNum := InternalDataset.BufferRowNum;
        RecRowNode := InternalDataset.BufferFields.RowNode;
        BookmarkFlag := bfCurrent;
      end;
      GetCalcFields( Buffer );
    end;
    grBOF: PIBORecInfo(Buffer + FRecInfoOfs).BookmarkFlag := bfBOF;
    grEOF: PIBORecInfo(Buffer + FRecInfoOfs).BookmarkFlag := bfEOF;
  end;
end;

procedure TIBODataset.InternalOpen;
begin
  InternalDataset.Prepare;
  FIncludeOutputParams := false;
  if ( InternalDataset.FieldCount > 0 ) and
     ( FieldDefs.Count = 0 ) then
    InternalInitFieldDefs;
  if DefaultFields then
    CreateFields;
  if foAutoAppendAllFields in FFieldOptions then
    AppendOtherFields;
  BindFields( True );
  if DefaultFields or (foDisplayFromIBO in FFieldOptions) then
    InitFields;
  FRecInfoOfs := FRecordSize + CalcFieldsSize;
  FRecBufSize := FRecInfoOfs + SizeOf( TIBORecInfo );
  InternalDataset.FIsCursorOpen := true;
end;

procedure TIBODataset.DoBeforeOpen;
begin
  inherited DoBeforeOpen;
  InternalDataset.SysOpen;
  FCurRowNum := InternalDataset.BofRowNum;
  InternalDataset.BufferRowNum := FCurRowNum;
end;

procedure TIBODataset.CloseCursor;
begin
  if not IsClosing then
  begin
    FIsClosing := true;
    try
      inherited CloseCursor;
    finally
      FIsClosing := false;
    end;
  end;
end;

procedure TIBODataset.InternalClose;
begin
  if InternalDataset.Fetching then
    InternalDataset.AbortFetching;
  ResetCursorRange;
  InternalDataset.Close;
  InternalDataset.FIsCursorOpen := false;
  FCurRowNum := InternalDataset.BofRowNum;
  BindFields( false );
  if DefaultFields then
    DestroyFields;
end;

procedure TIBODataset.InternalRefresh;
begin
  if not FInternalRefreshing then
    try
      FInternalRefreshing := true;
      InternalDataset.RowNum := InternalDataset.BufferRowNum;
      InternalDataset.Refresh;
      FCurRowNum := InternalDataset.RowNum;
      CursorPosChanged;
    finally
      FInternalRefreshing := false;
    end;
end;

procedure TIBODataset.InternalDelete;
begin
  InternalDataset.RowNum := InternalDataset.BufferRowNum;
  InternalDataset.ValidateRows( InternalDataset.RowNum + 1,
                                InternalDataset.RowNum + 1 );
  InternalDataset.Delete;
  if FCurRowNum <> InternalDataset.RowNum then
  begin
    FCurRowNum := InternalDataset.RowNum;
    CursorPosChanged;
  end;
end;

procedure TIBODataset.InternalEdit;
begin
  InternalDataset.RowNum := InternalDataset.BufferRowNum;
  InternalDataset.Edit;
  if FCurRowNum <> InternalDataset.RowNum then
  begin
    FCurRowNum := InternalDataset.RowNum;
    CursorPosChanged;
  end;
end;

procedure TIBODataset.DoBeforeInsert;
begin
  UpdateCursorPos;
  InternalDataset.RowNum := InternalDataset.BufferRowNum;
  if not InternalDataset.CanInsert then
    InternalDataset.Insert; // Allow it to raise the expected exception now.
  inherited DoBeforeInsert;
  UpdateCursorPos;
  InternalDataset.RowNum := InternalDataset.BufferRowNum;
end;

{$IFNDEF IBO_VCL40_OR_GREATER}
procedure TIBODataset.DoBeforeCancel;
begin
  inherited DoBeforeCancel;
  if State = dsInsert then
    InternalCancel;
end;
{$ENDIF}

{$IFNDEF IBO_VCL40_OR_GREATER}
procedure TIBODataset.InitRecord( Buffer: PChar );
var
  RecInf: PIBORecInfo;
  tmpStr: string;
begin
  RecInf := PIBORecInfo(Buffer + FRecInfoOfs);
  if Eof or IsEmpty then
  begin
{$ELSE}
procedure TIBODataset.InternalInsert;
var
  RecInf: PIBORecInfo;
  tmpStr: string;
begin
  RecInf := PIBORecInfo(ActiveBuffer + FRecInfoOfs);
  if RecInf.BookmarkFlag <> bfInserted then
  begin
{$ENDIF}
    InternalDataset.Append;
    FRecAppended := true;
  end
  else
    InternalDataset.Insert;
  RecInf.RecRowNum := InternalDataset.RowNum;
  RecInf.RecRowNode := InternalDataset.Fields.RowNode;
  tmpStr := InternalDataset.Bookmark;
  SetBookmarkData( ActiveBuffer, Pointer( PChar( tmpStr )));
end;

function TIBODataset.GetUnidirectional: boolean;
begin
  Result := InternalDataset.Unidirectional;
end;

procedure TIBODataset.SetUnidirectional( AValue: boolean );
begin
  if Unidirectional <> AValue then
  begin
    Unprepare;
    InternalDataset.Unidirectional := AValue;
  end;
end;

procedure TIBODataset.GetValuesFromMaster;
var
  ii: integer;
  tmpField: TField;
  NewField: TField;
  tmpDataset: TDataset;
  tmpCol: TIB_Column;
begin
  if Assigned( FDataLink.DataSource ) then
  begin
    tmpDataset := FDataLink.DataSource.Dataset;
    if Assigned( tmpDataset ) then
      if tmpDataset.Active and ( tmpDataset.State <> dsSetKey ) then
      begin
        with InternalDataset.Params do
          for ii := 0 to InternalDataset.Params.ColumnCount - 1 do
          begin
            tmpCol := InternalDataset.Params.Columns[ ii ];
            tmpField := tmpDataset.FindField( tmpCol.FieldName );
            if Assigned( tmpField ) then
            begin
              NewField := Self.FindField( tmpCol.FieldName );
              if Assigned( NewField ) and NewField.IsNull then
              begin
{$IFDEF IBO_VCL40_OR_GREATER}
                if NewField.DataType = ftLargeInt then
                  NewField.AsString := tmpField.AsString
                else
{$ENDIF}
                  NewField.Assign( tmpField );
              end;
            end;
          end;
      end;
  end;
end;

procedure TIBOBaseTable.GetValuesFromMaster;
var
  ii: integer;
  tmpField: TField;
  NewField: TField;
  tmpDataset: TDataset;
  tmpS: string;
  tmpPos: integer;
begin
  if Assigned( FDataLink.DataSource ) then
  begin
    tmpDataset := FDataLink.DataSource.Dataset;
    if Assigned( tmpDataset ) then
      if tmpDataset.Active and ( tmpDataset.State <> dsSetKey ) then
      begin
        tmpS := '';
        for ii := 0 to FMasterFieldsList.Count - 1 do
        begin
          tmpS := FMasterFieldsList.IndexValues[ii];
          if tmpS = '' then
            tmpS := FMasterFieldsList[ii];
          tmpField := tmpDataset.FindField( tmpS );
          if not Assigned( tmpField ) then
          begin
            tmpPos := GetLitSafePos( '.', tmpS, 1 );
            if tmpPos > 0 then
            begin
              System.Delete( tmpS, 1, tmpPos ); 
              tmpField := tmpDataset.FindField( tmpS );
            end;
          end;
          if Assigned( tmpField ) then
          begin
            tmpS := FMasterFieldsList.IndexNames[ii];
            NewField := Self.FindField( tmpS );
            if not Assigned( NewField ) then
            begin
              tmpPos := GetLitSafePos( '.', tmpS, 1 );
              if tmpPos > 0 then
              begin
                System.Delete( tmpS, 1, tmpPos );
                NewField := Self.FindField( tmpS );
              end;
            end;
            if Assigned( NewField ) and NewField.IsNull then
              NewField.Assign( tmpField );
          end;
        end;
      end;
  end;
end;

procedure TIBODataset.DoOnNewRecord;
begin
  GetValuesFromMaster;
  try
    inherited DoOnNewRecord;
  except
    FRecAppended := false;
    InternalDataset.Cancel;
    raise;
  end;
end;

procedure TIBODataset.InternalCancel;
begin
  if InternalDataset.NeedToPost then
    InternalDataset.Cancel;
  if FCurRowNum <> InternalDataset.RowNum then
  begin
    FCurRowNum := InternalDataset.RowNum;
    CursorPosChanged;
  end;
  FRecAppended := false;
end;

procedure TIBODataset.InternalPost;
begin
  InternalDataset.Post;
  if FCurRowNum <> InternalDataset.RowNum then
  begin
    FCurRowNum := InternalDataset.RowNum;
    CursorPosChanged;
  end;
  FRecAppended := false;
end;

procedure TIBODataset.InternalAddRecord( Buffer: Pointer; Append: boolean );
var
  ABuffer: PChar absolute Buffer;
begin
  try
    if Append then
      InternalDataset.Append
    else
      InternalDataset.Insert;
    Move( Buffer^, InternalDataset.Fields.RowBuffer^, RecordSize );
    InternalDataset.Post;
    Move( InternalDataset.Fields.RowBuffer^, Buffer^, RecordSize );
    with PIBORecInfo( ABuffer + FRecInfoOfs )^ do
    begin
      RecRowNum := InternalDataset.RowNum;
      RecRowNode := InternalDataset.Fields.RowNode;
      BookmarkFlag := bfCurrent;
    end;
  finally
    CursorPosChanged;
  end;
end;

function TIBODataset.GetRecordCount: longint;
begin
  Result := 0;
  if Active then
  begin
    if IsSequenced then
    begin
      if not InternalDataset.BufferHasEof and
         ( InternalDataset.BufferRowCount < 2 ) then
        InternalDataset.ValidateRows( 1, 2 );
      Result := InternalDataset.BufferRowCount;
      if not InternalDataset.BufferHasBof or
         not InternalDataset.BufferHasEof then
        Inc( Result, BufferCount div 2 + 1 );
    end
    else
      Result := RecordCountAll;
  end;
end;

function TIBODataset.GetRecNo: Integer;
var
  BufPtr: pointer;
begin
  if Active then
  begin
    if State = dsCalcFields then
      BufPtr := CalcBuffer
    else
      BufPtr := ActiveBuffer;
    Result := PIBORecInfo(longint(BufPtr) + longint(FRecInfoOfs)).RecRowNum;
  end
  else
    Result := 0;
end;

procedure TIBODataset.SetRecNo( Value: Integer );
begin
  if RecNo <> Value then
  begin
    CheckBrowseMode;
    DoBeforeScroll;
    InternalDataset.BufferRowNum := Value;
    FCurRowNum := InternalDataset.BufferRowNum;
    Resync([rmCenter]);
    DoAfterScroll;
  end;
end;

function TIBODataset.GetActiveRecBuf( var ARecBuf: pointer;
                                      var ACalcBuf: pointer;
                                      var ARowNode: PIB_Node ): boolean;
  function GetRecBuf( Buf: pointer ): pointer;
  var
    PRecInf: PIBORecInfo;
  begin
    ACalcBuf := Buf;
    Result := Buf;
    if Assigned( Result ) then
    begin
      PRecInf := PIBORecInfo(longint(Result) + FRecInfoOfs);
      ARowNode := PRecInf.RecRowNode;
      if Assigned( ARowNode ) then
      begin
        if InternalDataset.ProcessingUpdates then
        begin
          Result := InternalDataset.Fields.RowBuffer;
          ARowNode := InternalDataset.Fields.RowNode;
          ACalcBuf := TempBuffer;
        end
        else
        if ( ARowNode = InternalDataset.Fields.RowNode ) and
           ( PRecInf.RecRowNum = InternalDataset.RowNum ) then
          Result := InternalDataset.Fields.RowBuffer;
      end;
    end
    else
      ARowNode := nil;
  end;
var
  tmpRecInf: PIBORecInfo;
begin
  ARecBuf := nil;
  ACalcBuf := nil;
  ARowNode := nil;
  case State of
    dsBrowse: if not IsEmpty then
      ARecBuf := GetRecBuf( ActiveBuffer );
    dsEdit: ARecBuf := GetRecBuf( ActiveBuffer );
    dsInsert: if CurrentRecord = ActiveRecord then
    begin
      ARecBuf := GetRecBuf( ActiveBuffer );
      ARowNode := InternalDataset.Fields.RowNode;
 //     ACalcBuf := TempBuffer;
    end
    else
      ARecBuf := GetRecBuf( ActiveBuffer );
    dsSetKey: ARecBuf := ptr(longint(FKeyBuffer) + SizeOf(TIBOKeyBuffer));
    dsCalcFields: ARecBuf := GetRecBuf( CalcBuffer );
    dsFilter: ARecBuf := FFilterBuffer;
    dsNewValue,
    dsOldValue:
    begin
      if not InternalDataset.ProcessingUpdates then
      begin
        tmpRecInf := PIBORecInfo(longint(ActiveBuffer) + FRecInfoOfs);
        if InternalDataset.Fields.RowNode <> tmpRecInf.RecRowNode then
          InternalDataset.RowNum := tmpRecInf.RecRowNum;
      end;
      if State = dsOldValue then
        ARecBuf := InternalDataset.Fields.OldBuffer
      else
        ARecBuf := InternalDataset.Fields.RowBuffer;
      ARowNode := InternalDataset.Fields.RowNode;
    end;
{$IFDEF IBO_VCL40_OR_GREATER}
    dsBlockRead: ARecBuf := GetRecBuf( ActiveBuffer );
{$ENDIF}
  end;
  Result := Assigned( ARecBuf );
end;

function TIBODataset.GetBoolTVals: TIB_StringList;
var
  ii: integer;
  tmpCol: TIB_Column;
begin
  if not Assigned( FBoolTVals ) or ( FBoolTVals.Count = 0 ) then
  begin
    FBoolTVals := TIB_StringList.Create;
    try
      with InternalDataset.Fields do
        for ii := 0 to ColumnCount - 1 do
        begin
          tmpCol := BySQLNo( ii );
          FBoolTVals.Add( tmpCol.BooleanTrue );
        end;
    except
      FBoolTVals.Free;
      FBoolTVals := nil;
      raise;
    end;
  end;
  Result := FBoolTVals;
end;

function TIBODataset.GetBoolFVals: TIB_StringList;
var
  ii: integer;
  tmpCol: TIB_Column;
begin
  if not Assigned( FBoolFVals ) then
  begin
    FBoolFVals := TIB_StringList.Create;
    try
      with InternalDataset.Fields do
        for ii := 0 to ColumnCount - 1 do
        begin
          tmpCol := BySQLNo( ii );
          FBoolFVals.Add( tmpCol.BooleanFalse );
        end;
    except
      FBoolFVals.Free;
      FBoolFVals := nil;
      raise;
    end;
  end;
  Result := FBoolFVals;
end;

procedure TIBODataset.DoHandleError(       Sender: TObject;
                                     const errcode: isc_long;
                                           ErrorMessage,
                                           ErrorCodes: TStringList;
                                     const SQLCODE: isc_long;
                                           SQLMessage,
                                           SQL: TStringList;
                                       var RaiseException: boolean);
begin
  if Assigned( FOnError ) then
    FOnError( Self,
              errcode,
              ErrorMessage,
              ErrorCodes,
              SQLCODE,
              SQLMessage,
              SQL,
              RaiseException );
end;

{$IFDEF IBO_DELPHI_4}
procedure TIBODataset.SetBlockReadSize(Value: Integer);
var
  DoNext: Boolean;
begin
  if Value <> BlockReadSize then
  begin
    if (Value > 0) or (Value < -1) then
    begin
      inherited;
      BlockReadNext;
    end
    else
    begin
      DoNext := Value = -1;
      Value := 0;
      inherited SetBlockReadSize( Value );
      if DoNext then
        Next
      else
      begin
        CursorPosChanged;
        Resync( [] );
      end;
    end;
  end;
end;
{$ENDIF}

{$IFDEF IBO_VCL50_OR_GREATER}

{ IProviderSupport implementation }

procedure TIBODataSet.PSEndTransaction(Commit: Boolean);
begin
  if Assigned( IB_Transaction ) then
  begin
    if Commit then
      IB_Transaction.Commit
    else
      IB_Transaction.Rollback;
  end;
end;

procedure TIBODataSet.PSExecute;
begin
  ExecSQL;
end;

function TIBODataSet.PSExecuteStatement( const ASQL: string;
                                         AParams: TParams;
                                         ResultSet: pointer = nil ): integer;
var
  FQuery: TIBOQuery;
begin
// Potential Multi-threading problem!!!
  FQuery := TIBOQuery.Create( IB_Session );
  try
    FQuery.IB_Connection := IB_Connection;
    FQuery.IB_Transaction := IB_Transaction;
    FQuery.SQL.Text := ASQL;
    FQuery.Prepare;
    FQuery.FParams.Assign( AParams );
    if Assigned( ResultSet ) then 
      FQuery.Open
    else
      FQuery.ExecSQL;
    Result := FQuery.RowsAffected;
  finally
    if Assigned( ResultSet ) then
      TDataSet( ResultSet^ ) := FQuery
    else
      FQuery.Free;
  end;
end;

procedure TIBODataSet.PSGetAttributes(List: TList);
begin
end;

function TIBODataSet.PSGetDefaultOrder: TIndexDef;
begin
  Result := inherited PSGetDefaultOrder;
{
  if not Assigned(Result) then
    Result := GetIndexForOrderBy(SQL.Text, Self);
}
end;

function TIBOBaseTable.PSGetDefaultOrder: TIndexDef;
var
  DefIdx: TIndexDef;

  function GetIdx(IdxType: TIndexOption): TIndexDef;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to IndexDefs.Count - 1 do
      if IdxType in IndexDefs[i].Options then
      try
        Result := IndexDefs[i];
        GetFieldList(nil, Result.Fields);
        break;
      except
        Result := nil;
      end;
  end;

begin
  DefIdx := nil;
  IndexDefs.Update;
  try
    if IndexName <> '' then
      DefIdx := IndexDefs.Find( IndexName )
    else
    if IndexFieldNames <> '' then
      DefIdx := IndexDefs.FindIndexForFields( IndexFieldNames );
    if Assigned(DefIdx) then
      GetFieldList(nil, DefIdx.Fields);
  except
    DefIdx := nil;
  end;
  if not Assigned(DefIdx) then
    DefIdx := GetIdx(ixPrimary);
  if not Assigned(DefIdx) then
    DefIdx := GetIdx(ixUnique);
  if Assigned(DefIdx) then
  begin
    Result := TIndexDef.Create(nil);
    Result.Assign(DefIdx);
  end
  else
    Result := nil;
end;

function TIBODataSet.PSGetKeyFields: string;
var
  ii: integer;
begin
  for ii := 0 to Fields.Count - 1 do
    if pfInKey in Fields[ii].ProviderFlags then
    begin
      if Result <> '' then
        Result := Result + ';';
      Result := Result + Fields[ii].FieldName;
    end;
end;

function TIBODataSet.PSGetParams: TParams;
begin
  Result := FParams;
end;

function TIBODataSet.PSGetQuoteChar: string;
begin
  Result := '''';
end;

function TIBODataSet.PSGetTableName: string;
begin
  Result := InternalDataset.SysKeyRelation;
end;

function TIBODataSet.PSGetIndexDefs( IndexTypes: TIndexOptions ): TIndexDefs;
begin
  Result := GetIndexDefs( IndexDefs, IndexTypes );
end;

function TIBODataSet.PSGetUpdateException( E: Exception;
                                           Prev: EUpdateError ): EUpdateError;
var
  PrevErr: Integer;
begin
  if Prev <> nil then
    PrevErr := Prev.ErrorCode
  else
    PrevErr := 0;
  if E is EIB_ISCError then
    with EIB_ISCError(E) do
      Result := EUpdateError.Create( E.Message, '', SQLCode, PrevErr, E )
  else
    Result := inherited PSGetUpdateException( E, Prev );
end;

function TIBODataSet.PSInTransaction: Boolean;
begin
  Result := Assigned( IB_Transaction ) and IB_Transaction.InTransaction;
end;

function TIBODataSet.PSIsSQLBased: Boolean;
begin
  Result := true;
end;

function TIBODataSet.PSIsSQLSupported: Boolean;
begin
  Result := true;
end;

procedure TIBODataSet.PSReset;
begin
  inherited PSReset;
  if Active then
  begin
    Close;
    Open;
  end;
end;
procedure TIBODataSet.PSSetCommandText( const CommandText: string );
begin
  if CommandText <> '' then
    SQL.Text := CommandText;
end;

procedure TIBODataSet.PSSetParams( AParams: TParams );
begin
  Prepare;
  if Assigned( AParams ) and ( AParams.Count > 0 ) then
    with InternalDataset.Params do
    begin
      BeginUpdate;
      try
        if FParams.Count <> 0 then
          AssignParamsValues( AParams );
      finally
        EndUpdate( true );
      end;
    end;
end;

procedure TIBODataSet.PSStartTransaction;
begin
  if Assigned( IB_Transaction ) then
    IB_Transaction.StartTransaction;
end;

function TIBODataSet.PSUpdateRecord( UpdateKind: TUpdateKind;
                                     Delta: TDataSet ): Boolean;
  procedure AssignParams( DataSet: TDataSet; Params: TParams );
  var
    I: Integer;
    Old: Boolean;
    Param: TParam;
    PName: string;
    Field: TField;
    Value: Variant;
    tmpPos: integer;
    ucName: string;
    procedure ResolveParam;
    begin
      Field := DataSet.FindField( PName );
      if Assigned( Field ) then
        Old := false
      else
      begin
        ucName := UpperCase( PName );
        Old := ( CompareText( Copy( ucName, 1, 4 ), 'OLD_' ) = 0 ) or
               ( CompareText( Copy( ucName, 1, 4 ), 'OLD.' ) = 0 );
        if Old then
        begin
          System.Delete( PName, 1, 4 );
          Field := DataSet.FindField( PName );
          if not Assigned( Field ) then
            Field := DataSet.FindField( stLitCriteria( PName ));
        end
        else
        begin
          Old := ( CompareText( Copy( ucName, 1, 5 ), '"OLD_' ) = 0 ) or
                 ( CompareText( Copy( ucName, 1, 5 ), '"OLD.' ) = 0 );
          if Old then
          begin
            System.Delete( PName, 2, 4 );
            Field := DataSet.FindField( PName );
            if not Assigned( Field ) then
              Field := DataSet.FindField( stLitCriteria( PName ));
          end
        end;
      end;
    end;
  begin
    for I := 0 to Params.Count - 1 do
    begin
      Param := Params[I];
      PName := Param.Name;
      ResolveParam;
      if not Assigned( Field ) then
      begin
        PName := Param.Name;
        tmpPos := getLitSafePos( '.', PName, 1 );
        if tmpPos > 0 then
        begin
          PName := Copy( PName, tmpPos + 1, MaxInt );
          ResolveParam;
        end;
      end;
      if Assigned( Field ) then
      begin
        if Old then
          Param.AssignFieldValue( Field, Field.OldValue )
        else
        begin
          Value := Field.NewValue;
          if VarIsEmpty( Value ) then
            Value := Field.OldValue;
          Param.AssignFieldValue( Field, Value );
        end;
      end;
    end;
  end;
var
  tmpSQL: string;
  Params: TParams;
begin
  Result := False;
  Prepare;
  with InternalDataset.FUpdateSQL do
    case UpdateKind of
      ukModify: tmpSQL := EditDSQL.ClientSQL;
      ukInsert: tmpSQL := InsertDSQL.ClientSQL;
      ukDelete: tmpSQL := DeleteDSQL.ClientSQL;
    end;
  if tmpSQL <> '' then
  begin
    Params := TParams.Create;
    try
      Params.ParseSQL( tmpSQL, true );
      AssignParams( Delta, Params );
// For now this seems necessary because the SQL gets tweaked such that there
// aren't any ParamChar/ParamNames left. They all get stripped out.
      with InternalDataset.FUpdateSQL do
        case UpdateKind of
          ukModify: tmpSQL := EditDSQL.ClientSQL;
          ukInsert: tmpSQL := InsertDSQL.ClientSQL;
          ukDelete: tmpSQL := DeleteDSQL.ClientSQL;
        end;
      if PSExecuteStatement( tmpSQL, Params ) = 0 then
        DatabaseError( SRecordChanged );
      Result := True;
    finally
      Params.Free;
    end;
  end;
end;
{$ENDIF}

function TIBODataSet.IsConstraintsStored: Boolean;
begin
  Result := Constraints.Count > 0;
end;

procedure TIBODataSet.AssignFieldValueToCol( AField: TField; ACol: TIB_Column );
begin
  if AField.IsNull then
  begin
    if not ACol.IsNull then
      ACol.IsNull := true;
  end
  else
  begin
    if ACol.IsNull then 
      ACol.IsNull := false;
    case AField.DataType of
      ftString:
        if ACol.AsString <> AField.AsString then
          ACol.AsString := AField.AsString;
      ftBoolean, ftSmallint, ftWord:
        if ACol.AsSmallint <> AField.AsInteger then
          ACol.AsSmallint := AField.AsInteger;
      ftAutoInc,
      ftInteger:
        if ACol.AsInteger <> AField.AsInteger then
          ACol.AsInteger := AField.AsInteger;
{$IFDEF IBO_VCL40_OR_GREATER}
      ftLargeInt:
        if ACol.AsString <> AField.AsString then
          ACol.AsString := AField.AsString;
{$ENDIF}
      ftFloat, ftCurrency:
       if ACol.AsDouble <> AField.AsFloat then
         ACol.AsDouble := AField.AsFloat;
      ftBCD:
        if ACol.AsCurrency <> AField.AsCurrency then
          ACol.AsCurrency := AField.AsCurrency;
      ftDate:
        if ACol.AsDate <> Trunc( AField.AsDateTime ) then
          ACol.AsDate := AField.AsDateTime;
      ftTime, ftDateTime:
        if ACol.AsDateTime <> AField.AsDateTime then
          ACol.AsDateTime := AField.AsDateTime;
      ftBlob, ftMemo:
        if ACol.AsString <> AField.AsString then
          ACol.AsString := AField.AsString;
      else
        if ACol.Value <> AField.Value then
          ACol.Value := AField.Value;
    end;
  end;
end;

{$IFDEF IBO_VCL40_OR_GREATER}
procedure TIBODataSet.AssignParamValueToCol( AParam: TParam; ACol: TIB_Column );
begin
  if AParam.IsNull then
  begin
    if not ACol.IsNull then
      ACol.IsNull := true;
  end
  else
  begin
   case AParam.DataType of
      ftString:
        if ACol.IsNull or ( ACol.AsString <> AParam.AsString ) then
          ACol.AsString := AParam.AsString;
      ftBoolean, ftSmallint, ftWord:
        if ACol.IsNull or ( ACol.AsSmallint <> AParam.AsSmallInt ) then
          ACol.AsSmallint := AParam.AsSmallInt;
      ftAutoInc,
      ftInteger:
        if ACol.IsNull or ( ACol.AsInteger <> AParam.AsInteger ) then
          ACol.AsInteger := AParam.AsInteger;
      ftLargeInt:
        if ACol.IsNull or ( ACol.AsString <> AParam.AsString ) then
          ACol.AsString := AParam.AsString;
      ftFloat, ftCurrency:
       if ACol.IsNull or ( ACol.AsDouble <> AParam.AsFloat ) then
         ACol.AsDouble := AParam.AsFloat;
      ftBCD:
        if ACol.IsNull or ( ACol.AsCurrency <> AParam.AsCurrency ) then
          ACol.AsCurrency := AParam.AsCurrency;
      ftDate:
        if ACol.IsNull or ( ACol.AsDate <> AParam.AsDateTime ) then
          ACol.AsDate := AParam.AsDateTime;
      ftTime, ftDateTime:
        if ACol.IsNull or ( ACol.AsDateTime <> AParam.AsDateTime ) then
          ACol.AsDateTime := AParam.AsDateTime;
      ftBlob, ftMemo:
        if ACol.IsNull or ( ACol.AsString <> AParam.AsString ) then
          ACol.AsString := AParam.AsString;
      else
        if ACol.IsNull or ( ACol.Value <> AParam.Value ) then
          ACol.Value := AParam.Value;
    end;
  end;
end;

procedure TIBODataSet.AssignParamsValues( AParams: TParams );
var
  ii: Integer;
  tmpCol: TIB_Column;
  tmpParam: TParam;
begin
  if not InternalDataset.FUpdatingParams then
    try
      InternalDataset.FUpdatingParams := true;
      Prepare;
      for ii := 0 to AParams.Count - 1 do
      begin
        if ( AParams[ii].Name <> '' ) and
           ( AParams[ii].ParamType <> ptOutput ) then
        begin
          tmpCol := InternalDataset.FindParam( AParams[ii].Name );
          if not Assigned( tmpCol ) and Assigned( IB_Connection ) then
            tmpCol := InternalDataset.FindParam(
              IB_Connection.mkVarIdent( AParams[ii].Name ));
          if Assigned( tmpCol ) and ( tmpCol.Row.RowType = rtParam ) then
          begin

if Assigned( Self.DataSource ) and Assigned( Self.DataSource.Dataset ) then
  if Assigned( Self.DataSource.Dataset.FindField( tmpCol.FullFieldName )) then
    Continue;
            AssignParamValueToCol( AParams[ii], tmpCol );
            tmpParam := FindParam( tmpCol.FullFieldName );
            if Assigned( tmpParam ) then
              tmpParam.Value := AParams[ii].Value;
          end;
        end;
      end;
    finally
      InternalDataset.FUpdatingParams := false;
    end;
end;

function TIBODataset.GetParamsCount: Word;
begin
  Result := Params.Count;
end;

procedure TIBODataset.DefineProperties( Filer: TFiler );
  function WriteData: Boolean;
  begin
    if Filer.Ancestor <> nil then
      Result := not FParams.IsEqual( TIBOBaseQuery( Filer.Ancestor ).FParams )
    else
      Result := FParams.Count > 0;
  end;
begin
  inherited DefineProperties( Filer );
  Filer.DefineProperty( 'ParamData', ReadParamData, nil, false ); 
end;

procedure TIBODataset.ReadParamData( Reader: TReader );
begin
  Reader.ReadValue;
  Reader.ReadCollection( FParams );
end;
{$ENDIF}

function TIBODataSet.GetFieldClass( FieldType: TFieldType ): TFieldClass;
begin
  if FieldType = ftFloat then
    Result := TIBOFloatField
  else
    Result := inherited GetFieldClass( FieldType );
end;

procedure TIBOFloatField.SetText( const AValue: string );
begin
  inherited SetText( strip_char( AValue, ThousandSeparator ) );
end;

{$IFDEF IBO_VCL50_OR_GREATER}
procedure TIBODataSet.CheckFieldCompatibility( Field: TField;
                                               FieldDef: TFieldDef );
begin
  if Field.DataType = ftBCD then Field.Size := 8;
  if Field.DataType = ftFloat then Field.Size := 0;
  if FieldDef.DataType = ftBCD then FieldDef.Size := 8;
  if FieldDef.DataType = ftFloat then FieldDef.Size := 0;
  if (( Field.DataType = ftBCD ) and ( FieldDef.DataType = ftInteger )) or
     (( Field.DataType = ftBCD ) and ( FieldDef.DataType = ftFloat )) or
     (( Field.DataType = ftFloat ) and ( FieldDef.DataType = ftInteger )) or
     (( Field.DataType = ftFloat ) and ( FieldDef.DataType = ftBCD )) then
  //Allow this type conversion to pass.
  else
  if ( Field.DataType = ftString ) and ( FieldDef.DataType = ftMemo ) then
  //Allow this type conversion to pass.
  begin
    // Make sure it is really a string though.
    if Field.DataSize >= MaxWord then
      DatabaseErrorFmt( SFieldSizeMismatch,
                        [Field.DisplayName, Field.Size, FieldDef.Size],
                        Self );
  end
  else
    inherited CheckFieldCompatibility( Field, FieldDef );
end;

procedure TIBODataset.GetDetailLinkFields( MasterFields, DetailFields: TList );

  function AddFieldToList( const FieldName: string;
                                 DataSet: TDataSet;
                                 List: TList ): Boolean;
  var
    Field: TField;
  begin
    Field := DataSet.FindField( FieldName );
    if ( Field <> nil ) then
      List.Add( Field );
    Result := Field <> nil;
  end;

var
  i: Integer;
begin
  MasterFields.Clear;
  DetailFields.Clear;
  if ( DataSource <> nil ) and ( DataSource.DataSet <> nil ) then
    for i := 0 to Params.Count - 1 do
      if AddFieldToList( Params[i].Name, DataSource.DataSet, MasterFields ) then
        AddFieldToList( Params[i].Name, Self, DetailFields );
end;
{$ENDIF}

constructor EIBO_ISCError.CreateISC( Sender: TObject;
                                     MessageText: string;
                                     AERRCODE: longint;
                                     AErrorMessage: TStringList;
                                     AErrorCodes: TStringList;
                                     ASQLCODE: longint;
                                     ASQLMessage: TStringList;
                                     ASQL: TStringList );
var
  tmpTxt: string;
begin
  tmpTxt := MessageText;
  if Length( tmpTxt ) > 255 then
    SetLength( tmpTxt, 255 );
  inherited Create( tmpTxt );
  FSender := Sender;
  FERRCODE := AERRCODE;
  FErrorMessage := TStringList.Create;
  FErrorCodes := TStringList.Create;
  FSQLCODE := ASQLCODE;
  FSQLMessage := TStringList.Create;
  FSQL := TStringList.Create;
  FErrorMessage.Assign( AErrorMessage );
  FErrorCodes.Assign( AErrorCodes );
  FsqlMessage.Assign( AsqlMessage );
  Fsql.Assign( Asql );
end;

destructor EIBO_ISCError.Destroy;
begin
  FErrorMessage.Free;
  FErrorMessage := nil;
  FErrorCodes.Free;
  FErrorCodes := nil;
  FSQLMessage.Free;
  FSQLMessage := nil;
  FSQL.Free;
  FSQL := nil;
  inherited Destroy;
end;

procedure EIBO_ISCError.ShowDialog;
var
  tmpStr: string;
  tmpPos: integer;
  tmpLine, tmpChar: integer;
begin
  with TdlgError.Create( nil ) do
    try
      meError.Lines.Text := Trim( AdjustLineBreaks( ErrorMessage.Text ));
      meSQLMsg.Lines.Text := Trim( AdjustLineBreaks( SQLMessage.Text ));
      meSQL.Lines.Text := Trim( AdjustLineBreaks( SQL.Text ));
      if meSQLMsg.Lines.Count = 0 then
        tsSQLMsg.TabVisible := false;
      if meSQL.Lines.Count = 0 then
        tsSQL.TabVisible := false;
      pcError.ActivePage := tsErrorMsg;
      tmpLine := 0;
      tmpChar := 0;
      if meError.Lines.Count > 5 then
      begin
        tmpStr := meError.Lines[ 5 ];
        tmpPos := Pos( 'line', tmpStr );
        if tmpPos > 0 then
        begin
          tmpStr := Copy( tmpStr, tmpPos + 4, MaxInt );
          tmpPos := Pos( ',', tmpStr );
          if tmpPos > 0 then
          begin
            tmpLine := StrToInt( Trim( Copy( tmpStr, 1, tmpPos - 1 )));
            tmpStr := Copy( tmpStr, tmpPos + 6, MaxInt );
            tmpChar := StrToInt( Trim( tmpStr ));
          end;
        end;
      end;
      if ( tmpLine > 0 ) and ( tmpChar > 0 ) then
      begin
        tmpLine := SendMessage( meSQL.Handle, EM_LINEINDEX, tmpLine - 1, 0 );
        if tmpLine >= 0 then
        begin
          meSQL.SelStart := tmpLine + tmpChar;
          SendMessage( meSQL.Handle, EM_SCROLLCARET, 0, 0 );
        end;
      end;
      ShowModal;
    finally
      Free;
    end;
end;

{$IFDEF IBO_VCL40_OR_GREATER}

{ TIBOStoredProc }

constructor TIBOStoredProc.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  AutoFetchAll := true;
  StoredProcHasDML := true;
  KeyLinksAutoDefine := false;
end;

function TIBOStoredProc.GetStoredProcHasDML: boolean;
begin
  Result := InternalDataset.StoredProcHasDML;
end;

procedure TIBOStoredProc.SetStoredProcHasDML( AValue: boolean );
begin
  InternalDataset.StoredProcHasDML := AValue;
end;

procedure TIBOStoredProc.ExecProc;
begin
  CheckInActive;
  ExecSQL;
end;

procedure TIBOStoredProc.SetStoredProcName( const Value: string );
begin
  if not ( csReading in ComponentState ) then
  begin
    if Value <> FStoredProcName then
    begin
      CheckInactive;
      UnPrepare;
      FStoredProcName := Value;
      Params.Clear;
    end;
  end
  else
    FStoredProcName := Value;
end;

procedure TIBOStoredProc.SysPrepareSQL;
var
  ii: integer;
  ParamNames: TIB_StringList;
  FieldNames: TIB_StringList;
  tmpIdent: string;
begin
  with InternalDataset do
  begin
    tmpIdent := Trim( StoredProcName );
    if tmpIdent = '' then
      SQL.Clear
    else
    begin
      ParamNames := TIB_StringList.Create;
      FieldNames := TIB_StringList.Create;
      try
        if not ( csReading in ComponentState ) then
          CheckConnection( PreparingSQL );
        if Assigned( IB_Connection ) and IB_Connection.Connected then
          with IB_Connection.SchemaCache do
          begin
            GetProcedureParamNames( tmpIdent, true, ParamNames );
            GetProcedureParamNames( tmpIdent, false, FieldNames );
          end;
        with SQL do
        begin
          BeginUpdate;
          try
            Clear;
            Add( 'EXECUTE PROCEDURE ' + tmpIdent );
            for ii := 0 to ParamNames.Count - 1 do
            begin
              if ii = ParamNames.Count - 1 then
                Add( '  :' + Trim( ParamNames[ ii ] ))
              else
                Add( '  :' + Trim( ParamNames[ ii ] ) + ',' );
            end;
          finally
            EndUpdate;
          end;
        end;
      finally
        ParamNames.Free;
        FieldNames.Free;
      end;
    end;
  end;
end;

function TIBOStoredProc.GetParamsCount: Word;
begin
  Result := Params.Count;
end;

procedure TIBOStoredProc.CopyParams( Value: TParams );
begin
  if not Prepared and ( Params.Count = 0 ) then
    try
      Prepare;
      Value.Assign( Params );
    finally
      UnPrepare;
    end
  else
    Value.Assign( Params );
end;

function TIBOStoredProc.ParamByName( const Value: string ): TParam;
begin
  Result := Params.ParamByName( Value );
end;

{$IFDEF IBO_VCL50_OR_GREATER}

{ TIBOStoredProc.IProviderSupport }

function TIBOStoredProc.PSGetParams: TParams;
begin
  Result := Params;
end;

function TIBOStoredProc.PSGetTableName: string;
begin
  Result := inherited PSGetTableName;
end;

procedure TIBOStoredProc.PSExecute;
begin
  ExecProc;
end;

procedure TIBOStoredProc.PSSetCommandText(const CommandText: string);
begin
  if CommandText <> '' then
    StoredProcName := CommandText;
end;
{$ENDIF}
{$ENDIF}

{ TIBOUpdateSQL }

{$IFDEF IBO_VCL40_OR_GREATER}
constructor TIBOUpdateSQL.Create(AOwner: TComponent);
var
  UpdateKind: TUpdateKind;
begin
  inherited Create(AOwner);
  for UpdateKind := Low(TUpdateKind) to High(TUpdateKind) do
  begin
    FSQLText[UpdateKind] := TStringList.Create;
    TStringList(FSQLText[UpdateKind]).OnChange := SQLChanged;
  end;
end;

destructor TIBOUpdateSQL.Destroy;
var
  UpdateKind: TUpdateKind;
  tmpDataset: TIBODataset;
begin
  for UpdateKind := Low(TUpdateKind) to High(TUpdateKind) do
  begin
    tmpDataset := FQueries[UpdateKind];
    if Assigned( tmpDataset ) and tmpDataset.Prepared then
      tmpDataset.Unprepare;
  end;
  if Assigned( FDataset ) and ( FDataset.UpdateObject = Self ) then
  begin
    tmpDataset := FDataset;
    FDataset := nil;
    tmpDataset.UpdateObject := nil;
  end;
  for UpdateKind := Low(TUpdateKind) to High(TUpdateKind) do
  begin
    tmpDataset := FQueries[UpdateKind];
    FQueries[UpdateKind] := nil;
    if Assigned( tmpDataset ) then
      tmpDataset.Free;
  end;
  inherited Destroy;
  for UpdateKind := Low(TUpdateKind) to High(TUpdateKind) do
    FSQLText[UpdateKind].Free;
end;

procedure TIBOUpdateSQL.Unprepare;
var
  UpdateKind: TUpdateKind;
  tmpDataset: TIBODataset;
begin
  for UpdateKind := Low(TUpdateKind) to High(TUpdateKind) do
  begin
    tmpDataset := FQueries[UpdateKind];
    if Assigned( tmpDataset ) and tmpDataset.Prepared then
      tmpDataset.Unprepare;
  end;
end;

procedure TIBOUpdateSQL.Notification( AComponent: TComponent;
                                      Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( AComponent = FDataset ) then
    FDataset := nil;
end;

procedure TIBOUpdateSQL.ExecSQL( UpdateKind: TUpdateKind );
var
  tmpInt: integer;
begin
  with Query[UpdateKind] do
  begin
    Prepare;
    ExecSQL;
    if ( StatementType <> stExecProcedure ) then
    begin
      tmpInt := RowsAffected;
      if tmpInt = 0 then
        case StatementType of
          stUpdate: DatabaseError( E_Record_Not_Located_For_Update );
          stDelete: DatabaseError( E_Record_Not_Located_For_Delete );
          stInsert: DatabaseError( E_Record_Not_Inserted );
        end;
      if tmpInt > 1 then
        case StatementType of
          stUpdate: DatabaseError( E_Multiple_Records_Updated );
          stDelete: DatabaseError( E_Multiple_Records_Deleted );
          stInsert: DatabaseError( E_Multiple_Records_Inserted );
        end;
    end;
  end;
end;

function TIBOUpdateSQL.GetQuery(UpdateKind: TUpdateKind): TIBODataset;
begin
  if not Assigned( FQueries[UpdateKind] ) then
  begin
    FQueries[UpdateKind] := TIBODataset.Create( Self );
    FQueries[UpdateKind].SQL.Assign(FSQLText[ UpdateKind ]);
  end;
  if Assigned( FDataSet ) and Assigned( FQueries[UpdateKind] ) then
  begin
    FQueries[UpdateKind].IB_Connection := FDataSet.IB_Connection;
    FQueries[UpdateKind].IB_Transaction := FDataSet.IB_Transaction;
  end;
  Result := FQueries[UpdateKind];
end;

function TIBOUpdateSQL.GetSQL(UpdateKind: TUpdateKind): TStrings;
begin
  Result := FSQLText[UpdateKind];
end;

function TIBOUpdateSQL.GetSQLIndex(Index: Integer): TStrings;
begin
  Result := FSQLText[TUpdateKind(Index)];
end;

procedure TIBOUpdateSQL.SetSQL(UpdateKind: TUpdateKind; Value: TStrings);
begin
  FSQLText[UpdateKind].Assign(Value);
end;

procedure TIBOUpdateSQL.SetSQLIndex(Index: Integer; Value: TStrings);
begin
  SetSQL(TUpdateKind(Index), Value);
end;

procedure TIBOUpdateSQL.SQLChanged(Sender: TObject);
var
  UpdateKind: TUpdateKind;
begin
  for UpdateKind := Low(TUpdateKind) to High(TUpdateKind) do
    if Sender = FSQLText[UpdateKind] then
    begin
      if Assigned(FQueries[UpdateKind]) then
      begin
        FQueries[UpdateKind].Params.Clear;
        FQueries[UpdateKind].SQL.Assign(FSQLText[UpdateKind]);
      end;
      Break;
    end;
end;

procedure TIBOUpdateSQL.SetParams(UpdateKind: TUpdateKind);
var
  I: Integer;
  Old: Boolean;
  Param: TParam;
  PName: string;
  Field: TField;
  Value: Variant;
begin
  if not Assigned( FDataSet ) then
    Exit;
  with Query[ UpdateKind ] do
  begin
    Prepare;
    for I := 0 to Params.Count - 1 do
    begin
      Param := Params[I];
      PName := Param.Name;
      Old := CompareText( Copy(PName, 1, 4 ), 'OLD_' ) = 0;
      if Old then
        System.Delete( PName, 1, 4 );
      Field := FDataSet.FindField( PName );
      if not Assigned( Field ) then
        Continue;
      if Old then
        Param.AssignFieldValue( Field, Field.OldValue )
      else
      begin
        Value := Field.NewValue;
        if VarIsEmpty( Value ) then
          Value := Field.OldValue;
        Param.AssignFieldValue( Field, Value );
      end;
    end;
  end;
end;

procedure TIBOUpdateSQL.Apply( UpdateKind: TUpdateKind );
begin
  SetParams( UpdateKind );
  ExecSQL( UpdateKind );
end;

procedure TIBODataset.SetUpdateObject( AValue: TIBOUpdateSQL );
begin
  if AValue <> FUpdateObject then
  begin
    if Assigned( FUpdateObject ) and ( FUpdateObject.FDataSet = Self ) then
    begin
      FUpdateObject.Unprepare;
      FUpdateObject.FDataSet := nil;
    end;
    FUpdateObject := AValue;
    if Assigned( FUpdateObject ) then
    begin
      if Assigned( FUpdateObject.DataSet ) and
         ( FUpdateObject.DataSet <> Self ) then
        FUpdateObject.DataSet.UpdateObject := nil;
      FUpdateObject.FDataSet := Self;
    end;
    if Assigned( AValue ) then
      AValue.FreeNotification( Self );
  end;
  InternalDataset.CheckRequired := not Assigned( FUpdateObject );
end;

procedure TIBODataset.Notification( AComponent: TComponent;
                                    Operation: TOperation);
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( AComponent = FUpdateObject ) then
    FUpdateObject := nil;
end;

{$ENDIF}

{ TIBOInternalDataset }

constructor TIBOInternalDataset.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FIBODataset := Owner;
  AutoFetchFirst := false;
  CallbackInc := -1;
  FetchWholeRows := true;
  RefreshAction := raKeepDataPos;
  RefreshOnParamChange := false;
  PreparedEdits := true;
  PreparedInserts := false;
  BufferSynchroFlags := [];
  CommitAction := caInvalidateCursor;
end;

{$IFDEF IBO_VCL40_OR_GREATER}
procedure TIBOInternalDataset.SysAfterParamsDataChange( Sender: TIB_Row;
                                                        AField: TIB_Column );
var
  tmpParam: TParam;
begin
  inherited SysAfterParamsDataChange( Sender, AField );
  if Assigned( AField ) and not FUpdatingParams then
  begin
    tmpParam := IBODataset.FindParam( AField.FieldName );
    if Assigned( tmpParam ) then
      tmpParam.Value := AField.Value;
  end;
end;

procedure TIBOInternalDataset.SysAfterExecuteForOutput;
var
  ii: integer;
begin
  inherited SysAfterExecuteForOutput;
  if IBODataset.FIncludeOutputParams  or
     ( StatementType = stExecProcedure ) then
    for ii := 0 to IBODataset.Params.Count - 1 do
      with IBODataset.Params[ ii ] do
        if ParamType in [ ptOutput, ptInputOutput ] then
          Value := Self.FieldByName( Name ).Value;
end;
{$ENDIF}

function TIBOInternalDataset.GetDataset: TIBODataset;
begin
  Result := TIBODataset( FIBODataset );
end;

procedure TIBOInternalDataset.SysSQLChange(     Sender: TObject;
                                            var Unprepare: boolean );
begin
  inherited SysSQLChange( Sender, Unprepare );
  IBODataset.SysSQLChange( Sender, Unprepare );
end;

procedure TIBOInternalDataset.SysAfterPrepare;
begin
  inherited SysAfterPrepare;
  if not RepreparingSQL then
  begin
    IBODataset.BookmarkSize := KeyFields.BufferLength * 2;
    IBODataset.FRecordSize := Fields.BufferLength;
    IBODataset.FreeKeyBuffers;
    if FieldCount > 0 then
    begin
      IBODataset.InternalInitFieldDefs;
      IBODataset.AllocKeyBuffers;
    end;
  end;
{$IFDEF IBO_VCL40_OR_GREATER}
  IBODataset.SysUpdateParams;
  IBODataset.InternalInitParamDefs;
{$ENDIF}
  IBODataset.DoAfterPrepare;
end;

procedure TIBOInternalDataset.SysBeforePrepare;
begin
  inherited SysBeforePrepare;
  IBODataset.DoBeforePrepare;
end;

procedure TIBOInternalDataset.SysAfterUnprepare;
begin
  if not RepreparingSQL then
  begin
    with IBODataset do
    begin
      if Assigned( FBoolTVals ) then
      begin
        FBoolTVals.Free;
        FBoolTVals := nil;
      end;
      if Assigned( FBoolFVals ) then
      begin
        FBoolFVals.Free;
        FBoolFVals := nil;
      end;
      FBoolList := false;
    end;
  end;
  inherited SysAfterUnprepare;
  if not RepreparingSQL then
  begin
    IBODataset.FreeKeyBuffers;
    IBODataset.FIncludeOutputParams := false;
{$IFDEF IBO_VCL40_OR_GREATER}
    IBODataset.IndexDefs.Updated := false;
{$ENDIF}
  end;
end;

procedure TIBOInternalDataset.SysBeforeExecute;
begin
  inherited SysBeforeExecute;
  if not PreparingSQL then
    IBODataset.RefreshParams( false );
end;

procedure TIBOInternalDataset.SysPrepareSQL;
begin
  if not RepreparingSQL then
    IBODataset.FBoolList := false;
  if Assigned( IBODataset.FOnPrepareSQL ) then
    IBODataset.FOnPrepareSQL( IBODataset );
  IBODataset.SysPrepareSQL;
  inherited SysPrepareSQL;
end;

procedure TIBOInternalDataset.SysPrepareFailed;
begin
  inherited SysPrepareFailed;
end;

procedure TIBOInternalDataset.SysPost( CancelUnmodified, IsRetaining: boolean );
begin
  if NeedToPost then
    if ( State in [ dssEdit, dssInsert ] ) and not IsRetaining then
      if IBODataset.FIsPosting then
        inherited SysPost( CancelUnmodified, IsRetaining )
      else if IBODataset.Active then
        IBODataset.Post
      else
        inherited SysCancel
    else
      inherited SysPost( CancelUnmodified, IsRetaining );
end;

procedure TIBOInternalDataset.SysCancel;
begin
  if NeedToPost then
  begin
    if State in [ dssEdit, dssInsert ] then
    begin
      if not IBODataset.FIsCanceling then
      begin
        if IBODataset.Active then
          IBODataset.Cancel
        else
          inherited SysCancel;
      end
      else
        inherited SysCancel;
    end
    else
      inherited SysCancel;
  end;
end;

procedure TIBOInternalDataset.SysClose;
begin
  if Refreshing or
     ( RefiningIncSearch > 0 ) or
     not IBODataset.Active or
     ( IBODataset.FRefreshingParams > 0 ) or
     IBODataset.IsClosing then
    inherited SysClose
  else
    IBODataset.Close;
end;

procedure TIBODataset.DoUpdateRecord(     UpdateKind: TIB_UpdateKind;
                                      var UpdateAction: TIB_UpdateAction );
begin
  if CachedUpdates and ( CalcFieldsSize > 0 ) then
    CalculateFields( TempBuffer );
end;

procedure TIBOInternalDataset.DoUpdateRecord(  UpdateKind: TIB_UpdateKind;
                                           var UpdateAction: TIB_UpdateAction );
begin
  IBODataset.DoUpdateRecord( UpdateKind, UpdateAction );
  OnUpdateRecord( IBODataset, UpdateKind, UpdateAction );
end;

procedure TIBOInternalDataset.ApplyUpdates;
begin
  if CachedUpdates then
  begin
    if Active then
      IBODataset.CheckBrowseMode;
    if UpdatesPending then
    begin
      IBODataset.UpdateCursorPos;
      if ( BufferRowNum > BofRowNum ) and ( BufferRowNum <> RowNum ) then
        RowNum := BufferRowNum;
      inherited ApplyUpdates;
      IBODataset.SysResync( [] );
    end;
  end;
end;

procedure TIBOInternalDataset.CancelUpdates;
begin
  if CachedUpdates then
  begin
    IBODataset.Cancel;
    if UpdatesPending then
    begin
      if Active then
      begin
        IBODataset.UpdateCursorPos;
        if ( BufferRowNum > BofRowNum ) and ( BufferRowNum <> RowNum ) then
          RowNum := BufferRowNum;
      end;
      inherited CancelUpdates;
      if Active then
        IBODataset.SysResync( [] );
    end;
  end;
end;

procedure TIBOInternalDataset.CommitUpdates;
begin
  if CachedUpdates then
  begin
    if Active then
    begin
      IBODataset.UpdateCursorPos;
      if ( BufferRowNum > BofRowNum ) and ( BufferRowNum <> RowNum ) then
        RowNum := BufferRowNum;
    end;
    inherited CommitUpdates;
    if Active then
      IBODataset.SysResync( [] );
  end;
end;

function TIBOInternalDataset.SysRefresh( Rows, Keys: boolean ): boolean;
begin
  if not IBODataset.FInternalRefreshing and ( KeyLookupCurLevel = 0 ) then
  begin
    IBODataset.UpdateCursorPos;
    RowNum := BufferRowNum;
  end;
  Result := inherited SysRefresh( Rows, Keys );
  if not IBODataset.FInternalRefreshing and ( KeyLookupCurLevel = 0 ) then
    IBODataset.SysResync( [] );
end;

procedure TIBOInternalDataset.DoHandleError(       Sender: TObject;
                                             const errcode: isc_long;
                                                   ErrorMessage,
                                                   ErrorCodes: TStringList;
                                             const SQLCODE: isc_long;
                                                   SQLMessage,
                                                   SQL: TStringList;
                                               var RaiseException: boolean );
var
  tmpText: string;
begin
  inherited DoHandleError( Sender,
                           errcode,
                           ErrorMessage,
                           ErrorCodes,
                           SQLCODE,
                           SQLMessage,
                           SQL,
                           RaiseException );
  if RaiseException then
  begin
    if ( SQLCODE = -836 ) and ( ErrorMessage.Count > 2 ) then
      tmpText := ErrorMessage[ 4 ]
    else
      tmpText := ErrorMessage.Text;
    raise EIBO_ISCError.CreateISC( Sender,
                                   tmpText,
                                   errcode,
                                   ErrorMessage,
                                   ErrorCodes,
                                   SQLCODE,
                                   SQLMessage,
                                   SQL );
  end;
end;

procedure TIBOInternalDataset.ProcessTransactionEvent(
  ATransactionLink: TIB_TransactionLink;
  AEvent: TIB_TransactionEventType );
begin
  inherited ProcessTransactionEvent( ATransactionLink, AEvent );
end;

function TIBOInternalDataset.SysNeedToRefineSQL: boolean;
begin
  Result := inherited SysNeedToRefineSQL;
  if not Result and ( IBODataset is TIBOBaseTable ) then
    Result := true;
end;

procedure TIBOInternalDataset.SysUpdateOperation(
      Operation: TIB_DataOperation;
      UpdateKind: TIB_UpdateKind;
  var UpdateAction: TIB_UpdateAction );
begin
{$IFDEF IBO_VCL40_OR_GREATER}
  if Assigned( IBODataset ) and
     Assigned( IBODataset.UpdateObject ) then
    case UpdateKind of
      ukiModify: if IBODataset.UpdateObject.ModifySQL.Count > 0 then
        IBODataset.UpdateObject.Apply( ukModify )
      else
        inherited SysUpdateOperation( Operation, UpdateKind, UpdateAction );
      ukiInsert: if IBODataset.UpdateObject.InsertSQL.Count > 0 then
        IBODataset.UpdateObject.Apply( ukInsert )
      else
        inherited SysUpdateOperation( Operation, UpdateKind, UpdateAction );
      ukiDelete: if IBODataset.UpdateObject.DeleteSQL.Count > 0 then
        IBODataset.UpdateObject.Apply( ukDelete )
      else
        inherited SysUpdateOperation( Operation, UpdateKind, UpdateAction );
    end
  else
{$ENDIF}
    inherited SysUpdateOperation( Operation, UpdateKind, UpdateAction );
end;

{$IFDEF IBO_VCL40_OR_GREATER}
function TIBOInternalDataset.IsUsingManualDML(
  UpdateKind: TIB_UpdateKind ): boolean;
begin
  Result := inherited IsUsingManualDML( UpdateKind );
  if not Result then
    if Assigned( IBODataset ) and
       Assigned( IBODataset.UpdateObject ) then
      case UpdateKind of
        ukiModify: Result := IBODataset.UpdateObject.ModifySQL.Count > 0;
        ukiInsert: Result := IBODataset.UpdateObject.InsertSQL.Count > 0;
        ukiDelete: Result := IBODataset.UpdateObject.DeleteSQL.Count > 0;
      end;
end;

procedure TIBOInternalDataset.GetColumnIsReadOnly(     AColumn: TIB_Column;
                                                   var AReadOnly: boolean );
var
  tmpCol: TParam;
  tmpState: TIB_DatasetState;
begin
  if not AReadOnly and
     Assigned( IBODataset ) and
     Assigned( IBODataset.FUpdateObject ) then
  begin
    tmpState := State;
    if ( tmpState = dssBrowse ) and
       ( AColumn.Row.RowState = rsNone ) then
      tmpState := dssPrepared;
    with IBODataset.FUpdateObject do
      case tmpState of
        dssBrowse,
        dssEdit: if ModifySQL.Count > 0 then
        begin
          tmpCol := Query[ukModify].FindParam( AColumn.FieldName );
          AReadOnly := not Assigned( tmpCol );
        end
        else
          inherited GetColumnIsReadOnly( AColumn, AReadOnly );
        dssPrepared,
        dssInsert: if InsertSQL.Count > 0 then
        begin
          tmpCol := Query[ ukInsert ].FindParam( AColumn.FieldName );
          AReadOnly := not Assigned( tmpCol );
        end
        else
          inherited GetColumnIsReadOnly( AColumn, AReadOnly );
        else
          AReadOnly := true;
      end;
  end
  else
    inherited GetColumnIsReadOnly( AColumn, AReadOnly );
end;
{$ENDIF}

end.

