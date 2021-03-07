unit CommonQuery_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 27.03.2007 10:31:42 from Type Library described below.

// ************************************************************************  //
// Type Lib: c:\CedaLite\Netsis_Aktarma\CommonQuery.tlb (1)
// LIBID: {6F9EA625-48E0-4355-9838-F7C8DE95FC11}
// LCID: 0
// Helpfile: 
// HelpString: CommonQuery Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Parent TypeLibrary:
//   (0) v3.0 NetOpenX, (c:\CedaLite\Netsis_Aktarma\NetOpenX.dll)
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  CommonQueryMajorVersion = 1;
  CommonQueryMinorVersion = 0;

  LIBID_CommonQuery: TGUID = '{6F9EA625-48E0-4355-9838-F7C8DE95FC11}';

  IID_INetCommonQuery: TGUID = '{54C022BB-E022-443C-888F-155E12C78FDE}';
  CLASS_NetCommonQuery: TGUID = '{E6E86900-D4E4-4B5D-950A-836EEDA80E06}';
  IID_INetField: TGUID = '{1272F0C0-4920-4414-A627-2A5AC9A370BB}';
  IID_INetStrings: TGUID = '{72D68D7B-47F8-4F28-962C-189A92911227}';
  CLASS_NetField: TGUID = '{EF0BBCB1-A4E4-4EB4-8149-11C9BF687D9C}';
  CLASS_NetStrings: TGUID = '{507BF4D7-C725-40C2-8188-D3CFD75FE859}';
  IID_INetFieldDefs: TGUID = '{31FECBB6-33D2-4285-8AE6-C124A9AA0752}';
  IID_INetCommonQueryDispatcher: TGUID = '{476CDBBC-F681-4F3F-BBD3-EA65F6AC5377}';
  CLASS_NetCommonQueryDispatcher: TGUID = '{9762FF6F-0675-48E9-9460-AF79058F9829}';
  IID_INetCommonQueryEvents: TGUID = '{FD24AC06-12F9-4524-B4CD-2B4A2C19C779}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TNetNetsisProgram
type
  TNetNetsisProgram = TOleEnum;
const
  netnpProf = $00000000;
  netnpDemirbas = $00000001;
  netnpPersonel = $00000002;
  netnpIsletme = $00000003;
  netnpReserved1 = $00000004;
  netnpNDI = $00000005;
  netnpYedek2 = $00000006;
  netnpYedek3 = $00000007;
  netnpYedek4 = $00000008;
  netnpNetsis = $00000009;

// Constants for enum TNetDatabaseType
type
  TNetDatabaseType = TOleEnum;
const
  netdtMSSQL = $00000000;
  netdtReserved = $00000001;
  netdtOracle = $00000002;
  netdtAS400 = $00000003;

// Constants for enum TNetAfterDelOpr
type
  TNetAfterDelOpr = TOleEnum;
const
  nadInsert = $00000000;
  nadLast = $00000001;
  nadFirst = $00000002;
  nadNone = $00000003;
  nadNext = $00000004;
  nadPrior = $00000005;

// Constants for enum TNetAfterInsOpr
type
  TNetAfterInsOpr = TOleEnum;
const
  naiInsert = $00000000;
  naiFirst = $00000001;
  naiLast = $00000002;
  naiNone = $00000003;

// Constants for enum TNetAfterUpdOpr
type
  TNetAfterUpdOpr = TOleEnum;
const
  nauNext = $00000000;
  nauFirst = $00000001;
  nauNone = $00000002;
  nauLast = $00000003;
  nauPrior = $00000004;
  nauInsert = $00000005;

// Constants for enum TNetAfterOpenOpr
type
  TNetAfterOpenOpr = TOleEnum;
const
  naoInsert = $00000000;
  naoFirst = $00000001;
  naoLast = $00000002;

// Constants for enum TNetFieldType
type
  TNetFieldType = TOleEnum;
const
  ftNetUnknown = $00000000;
  ftNetString = $00000001;
  ftNetSmallInt = $00000002;
  ftNetInteger = $00000003;
  ftNetWord = $00000004;
  ftNetBoolean = $00000005;
  ftNetFloat = $00000006;
  ftNetCurrency = $00000007;
  ftNetBCD = $00000008;
  ftNetDate = $00000009;
  ftNetTime = $0000000A;
  ftNetDateTime = $0000000B;
  ftNetBytes = $0000000C;
  ftNetVarBytes = $0000000D;
  ftNetAutoInc = $0000000E;
  ftNetBlob = $0000000F;
  ftNetMemo = $00000010;
  ftNetGraphic = $00000011;
  ftNetFmtMemo = $00000012;
  ftNetParadoxOle = $00000013;
  ftNetDBaseOle = $00000014;
  ftNetTypedBinary = $00000015;
  ftNetCursor = $00000016;
  ftNetFixedChar = $00000017;
  ftNetWideString = $00000018;
  ftNetLargeInt = $00000019;
  ftNetADT = $0000001A;
  ftNetArray = $0000001B;
  ftNetReference = $0000001C;
  ftNetDataSet = $0000001D;
  ftNetOraBlob = $0000001E;
  ftNetOraClob = $0000001F;
  ftNetVariant = $00000020;
  ftNetInterface = $00000021;
  ftNetIDispatch = $00000022;
  ftNetGuid = $00000023;
  ftNetTimeStamp = $00000024;
  ftNetFmtBcd = $00000025;

// Constants for enum TNetDataSetState
type
  TNetDataSetState = TOleEnum;
const
  dsNetInactive = $00000000;
  dsNetBrowse = $00000001;
  dsNetEdit = $00000002;
  dsNetInsert = $00000003;
  dsNetSetKey = $00000004;
  dsNetCalcFields = $00000005;
  dsNetFilter = $00000006;
  dsNetNewValue = $00000007;
  dsNetOldValue = $00000008;
  dsNetCurValue = $00000009;
  dsNetBlockRead = $0000000A;
  dsNetInternalCalc = $0000000B;
  dsNetOpening = $0000000C;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  INetCommonQuery = interface;
  INetCommonQueryDisp = dispinterface;
  INetField = interface;
  INetFieldDisp = dispinterface;
  INetStrings = interface;
  INetStringsDisp = dispinterface;
  INetFieldDefs = interface;
  INetFieldDefsDisp = dispinterface;
  INetCommonQueryDispatcher = interface;
  INetCommonQueryDispatcherDisp = dispinterface;
  INetCommonQueryEvents = interface;
  INetCommonQueryEventsDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  NetCommonQuery = INetCommonQuery;
  NetField = INetField;
  NetStrings = INetStrings;
  NetCommonQueryDispatcher = INetCommonQueryDispatcher;


// *********************************************************************//
// Interface: INetCommonQuery
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {54C022BB-E022-443C-888F-155E12C78FDE}
// *********************************************************************//
  INetCommonQuery = interface(IDispatch)
    ['{54C022BB-E022-443C-888F-155E12C78FDE}']
    procedure First; safecall;
    procedure Next; safecall;
    procedure Last; safecall;
    procedure Prior; safecall;
    procedure Open; safecall;
    procedure Close; safecall;
    function Get_Found: WordBool; safecall;
    function Get_EOF: WordBool; safecall;
    function Get_BOF: WordBool; safecall;
    function Get_Fields(Index: Integer): INetField; safecall;
    function Get_FieldCount: Integer; safecall;
    function Get_IsEmpty: WordBool; safecall;
    function MoveBy(Distance: Integer): Integer; safecall;
    function RecSQL(const SQL: WideString): WordBool; safecall;
    procedure Execute(const SQL: WideString); safecall;
    procedure Cancel; safecall;
    procedure Insert; safecall;
    procedure Delete; safecall;
    function Get_SQL: INetStrings; safecall;
    procedure Set_SQL(const Value: INetStrings); safecall;
    function FieldByName(const Name: WideString): INetField; safecall;
    function Get_Params(Index: Integer): WideString; safecall;
    procedure Set_Params(Index: Integer; const Value: WideString); safecall;
    function Get_Active: WordBool; safecall;
    procedure Set_Active(Value: WordBool); safecall;
    procedure Post; safecall;
    function Get_TableName: WideString; safecall;
    procedure Set_TableName(const Value: WideString); safecall;
    function Get_MasterFields: INetStrings; safecall;
    procedure Set_MasterFields(const Value: INetStrings); safecall;
    procedure Edit; safecall;
    function IsCursonOpen: WordBool; safecall;
    function GetRecord(Buffer: Integer; GetMode: Word; DoCheck: WordBool): Word; safecall;
    function GetRecordSize: Word; safecall;
    function GetFieldData(Field: Integer; Buffer: Integer): WordBool; safecall;
    procedure FreeRecordBuffer(var Buffer: Integer); safecall;
    procedure SetFieldData(Field: Integer; Buffer: Integer); safecall;
    function Get_AfterDeleteOpr: TNetAfterDelOpr; safecall;
    procedure Set_AfterDeleteOpr(Value: TNetAfterDelOpr); safecall;
    function Get_AfterInsertOpr: TNetAfterInsOpr; safecall;
    procedure Set_AfterInsertOpr(Value: TNetAfterInsOpr); safecall;
    function Get_AfterOpenOpr: TNetAfterOpenOpr; safecall;
    procedure Set_AfterOpenOpr(Value: TNetAfterOpenOpr); safecall;
    function Get_AfterUpdateOpr: TNetAfterUpdOpr; safecall;
    procedure Set_AfterUpdateOpr(Value: TNetAfterUpdOpr); safecall;
    function Get_DatabaseName: WideString; safecall;
    procedure Set_DatabaseName(const Value: WideString); safecall;
    function Get_DatabaseType: TNetDatabaseType; safecall;
    procedure Set_DatabaseType(Value: TNetDatabaseType); safecall;
    function Get_DefaultDatabase: WordBool; safecall;
    procedure Set_DefaultDatabase(Value: WordBool); safecall;
    function Get_DeleteWarning: WordBool; safecall;
    procedure Set_DeleteWarning(Value: WordBool); safecall;
    function Get_ExtraFields: WideString; safecall;
    procedure Set_ExtraFields(const Value: WideString); safecall;
    function Get_LockDateFields: WideString; safecall;
    procedure Set_LockDateFields(const Value: WideString); safecall;
    function Get_Log: WordBool; safecall;
    procedure Set_Log(Value: WordBool); safecall;
    function Get_Password: WideString; safecall;
    procedure Set_Password(const Value: WideString); safecall;
    function Get_ReportQuery: WordBool; safecall;
    procedure Set_ReportQuery(Value: WordBool); safecall;
    function Get_RightChecking: WordBool; safecall;
    procedure Set_RightChecking(Value: WordBool); safecall;
    function Get_SuppFieldCount: Integer; safecall;
    procedure Set_SuppFieldCount(Value: Integer); safecall;
    function Get_SuppTableName: WideString; safecall;
    procedure Set_SuppTableName(const Value: WideString); safecall;
    function Get_UserName: WideString; safecall;
    procedure Set_UserName(const Value: WideString); safecall;
    function Get_DBHostName: WideString; safecall;
    procedure Set_DBHostName(const Value: WideString); safecall;
    procedure SwitchMultiLogin(NP: TNetNetsisProgram; DBType: TNetDatabaseType; 
                               const DBHostName: WideString; const DBName: WideString; 
                               const DBUserName: WideString; const DBPassword: WideString); safecall;
    function Get_NetsisProgram: TNetNetsisProgram; safecall;
    procedure Set_NetsisProgram(Value: TNetNetsisProgram); safecall;
    procedure AssignFieldDefs(FieldDefs: Integer); safecall;
    function Get_FieldDefs: INetFieldDefs; safecall;
    function Get_MasterFieldText: WideString; safecall;
    procedure Set_MasterFieldText(const Value: WideString); safecall;
    function Get_RecStatus: TNetDataSetState; safecall;
    procedure NextEOFCheck(CheckEOF: WordBool); safecall;
    procedure PriorBOFCheck(CheckBOF: WordBool); safecall;
    function FindKey(const Fields: INetStrings): WordBool; safecall;
    function Get_IntXqAdr: Integer; safecall;
    function Get_SQLText: WideString; safecall;
    procedure Set_SQLText(const Value: WideString); safecall;
    function Clone: INetCommonQuery; safecall;
    function GetFilter: WideString; safecall;
    function Get_FindValues(Index: Integer): WideString; safecall;
    function Get_WhereValues(Index: Integer): WideString; safecall;
    function Get_FromGrid: WordBool; safecall;
    procedure Set_FromGrid(Value: WordBool); safecall;
    function Get_State: TNetDataSetState; safecall;
    function Get_CQEvents: INetCommonQueryEvents; safecall;
    procedure Set_CQEvents(const Value: INetCommonQueryEvents); safecall;
    function DateTimeToDB(InDate: TDateTime): WideString; safecall;
    function FloatToDB(InFloat: Double): WideString; safecall;
    function Get_IsItWorkplace: WordBool; safecall;
    procedure Set_IsItWorkplace(Value: WordBool); safecall;
    function Get_NetTransac: WordBool; safecall;
    procedure Set_NetTransac(Value: WordBool); safecall;
    procedure DoWorkPlaceAfterPost; safecall;
    procedure DoWorkPlaceBeforePost(const WPAciklama: WideString; WPModulNo: Integer; 
                                    WPProgNo: Integer); safecall;
    procedure AddWorkplacePolicy(const ObjectName: WideString); safecall;
    procedure DropWorkplacePolicy(const ObjectName: WideString); safecall;
    function ConnectionTest: WordBool; safecall;
    property Found: WordBool read Get_Found;
    property EOF: WordBool read Get_EOF;
    property BOF: WordBool read Get_BOF;
    property Fields[Index: Integer]: INetField read Get_Fields;
    property FieldCount: Integer read Get_FieldCount;
    property IsEmpty: WordBool read Get_IsEmpty;
    property SQL: INetStrings read Get_SQL write Set_SQL;
    property Params[Index: Integer]: WideString read Get_Params write Set_Params;
    property Active: WordBool read Get_Active write Set_Active;
    property TableName: WideString read Get_TableName write Set_TableName;
    property MasterFields: INetStrings read Get_MasterFields write Set_MasterFields;
    property AfterDeleteOpr: TNetAfterDelOpr read Get_AfterDeleteOpr write Set_AfterDeleteOpr;
    property AfterInsertOpr: TNetAfterInsOpr read Get_AfterInsertOpr write Set_AfterInsertOpr;
    property AfterOpenOpr: TNetAfterOpenOpr read Get_AfterOpenOpr write Set_AfterOpenOpr;
    property AfterUpdateOpr: TNetAfterUpdOpr read Get_AfterUpdateOpr write Set_AfterUpdateOpr;
    property DatabaseName: WideString read Get_DatabaseName write Set_DatabaseName;
    property DatabaseType: TNetDatabaseType read Get_DatabaseType write Set_DatabaseType;
    property DefaultDatabase: WordBool read Get_DefaultDatabase write Set_DefaultDatabase;
    property DeleteWarning: WordBool read Get_DeleteWarning write Set_DeleteWarning;
    property ExtraFields: WideString read Get_ExtraFields write Set_ExtraFields;
    property LockDateFields: WideString read Get_LockDateFields write Set_LockDateFields;
    property Log: WordBool read Get_Log write Set_Log;
    property Password: WideString read Get_Password write Set_Password;
    property ReportQuery: WordBool read Get_ReportQuery write Set_ReportQuery;
    property RightChecking: WordBool read Get_RightChecking write Set_RightChecking;
    property SuppFieldCount: Integer read Get_SuppFieldCount write Set_SuppFieldCount;
    property SuppTableName: WideString read Get_SuppTableName write Set_SuppTableName;
    property UserName: WideString read Get_UserName write Set_UserName;
    property DBHostName: WideString read Get_DBHostName write Set_DBHostName;
    property NetsisProgram: TNetNetsisProgram read Get_NetsisProgram write Set_NetsisProgram;
    property FieldDefs: INetFieldDefs read Get_FieldDefs;
    property MasterFieldText: WideString read Get_MasterFieldText write Set_MasterFieldText;
    property RecStatus: TNetDataSetState read Get_RecStatus;
    property IntXqAdr: Integer read Get_IntXqAdr;
    property SQLText: WideString read Get_SQLText write Set_SQLText;
    property FindValues[Index: Integer]: WideString read Get_FindValues;
    property WhereValues[Index: Integer]: WideString read Get_WhereValues;
    property FromGrid: WordBool read Get_FromGrid write Set_FromGrid;
    property State: TNetDataSetState read Get_State;
    property CQEvents: INetCommonQueryEvents read Get_CQEvents write Set_CQEvents;
    property IsItWorkplace: WordBool read Get_IsItWorkplace write Set_IsItWorkplace;
    property NetTransac: WordBool read Get_NetTransac write Set_NetTransac;
  end;

// *********************************************************************//
// DispIntf:  INetCommonQueryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {54C022BB-E022-443C-888F-155E12C78FDE}
// *********************************************************************//
  INetCommonQueryDisp = dispinterface
    ['{54C022BB-E022-443C-888F-155E12C78FDE}']
    procedure First; dispid 201;
    procedure Next; dispid 202;
    procedure Last; dispid 203;
    procedure Prior; dispid 204;
    procedure Open; dispid 205;
    procedure Close; dispid 206;
    property Found: WordBool readonly dispid 207;
    property EOF: WordBool readonly dispid 208;
    property BOF: WordBool readonly dispid 209;
    property Fields[Index: Integer]: INetField readonly dispid 210;
    property FieldCount: Integer readonly dispid 211;
    property IsEmpty: WordBool readonly dispid 212;
    function MoveBy(Distance: Integer): Integer; dispid 213;
    function RecSQL(const SQL: WideString): WordBool; dispid 214;
    procedure Execute(const SQL: WideString); dispid 215;
    procedure Cancel; dispid 216;
    procedure Insert; dispid 217;
    procedure Delete; dispid 218;
    property SQL: INetStrings dispid 219;
    function FieldByName(const Name: WideString): INetField; dispid 220;
    property Params[Index: Integer]: WideString dispid 227;
    property Active: WordBool dispid 228;
    procedure Post; dispid 229;
    property TableName: WideString dispid 230;
    property MasterFields: INetStrings dispid 231;
    procedure Edit; dispid 232;
    function IsCursonOpen: WordBool; dispid 233;
    function GetRecord(Buffer: Integer; GetMode: {??Word}OleVariant; DoCheck: WordBool): {??Word}OleVariant; dispid 234;
    function GetRecordSize: {??Word}OleVariant; dispid 235;
    function GetFieldData(Field: Integer; Buffer: Integer): WordBool; dispid 236;
    procedure FreeRecordBuffer(var Buffer: Integer); dispid 237;
    procedure SetFieldData(Field: Integer; Buffer: Integer); dispid 238;
    property AfterDeleteOpr: TNetAfterDelOpr dispid 240;
    property AfterInsertOpr: TNetAfterInsOpr dispid 241;
    property AfterOpenOpr: TNetAfterOpenOpr dispid 242;
    property AfterUpdateOpr: TNetAfterUpdOpr dispid 243;
    property DatabaseName: WideString dispid 224;
    property DatabaseType: TNetDatabaseType dispid 222;
    property DefaultDatabase: WordBool dispid 244;
    property DeleteWarning: WordBool dispid 245;
    property ExtraFields: WideString dispid 246;
    property LockDateFields: WideString dispid 247;
    property Log: WordBool dispid 248;
    property Password: WideString dispid 226;
    property ReportQuery: WordBool dispid 249;
    property RightChecking: WordBool dispid 250;
    property SuppFieldCount: Integer dispid 251;
    property SuppTableName: WideString dispid 252;
    property UserName: WideString dispid 225;
    property DBHostName: WideString dispid 223;
    procedure SwitchMultiLogin(NP: TNetNetsisProgram; DBType: TNetDatabaseType; 
                               const DBHostName: WideString; const DBName: WideString; 
                               const DBUserName: WideString; const DBPassword: WideString); dispid 253;
    property NetsisProgram: TNetNetsisProgram dispid 221;
    procedure AssignFieldDefs(FieldDefs: Integer); dispid 239;
    property FieldDefs: INetFieldDefs readonly dispid 255;
    property MasterFieldText: WideString dispid 256;
    property RecStatus: TNetDataSetState readonly dispid 254;
    procedure NextEOFCheck(CheckEOF: WordBool); dispid 257;
    procedure PriorBOFCheck(CheckBOF: WordBool); dispid 258;
    function FindKey(const Fields: INetStrings): WordBool; dispid 259;
    property IntXqAdr: Integer readonly dispid 260;
    property SQLText: WideString dispid 261;
    function Clone: INetCommonQuery; dispid 262;
    function GetFilter: WideString; dispid 263;
    property FindValues[Index: Integer]: WideString readonly dispid 264;
    property WhereValues[Index: Integer]: WideString readonly dispid 265;
    property FromGrid: WordBool dispid 266;
    property State: TNetDataSetState readonly dispid 267;
    property CQEvents: INetCommonQueryEvents dispid 268;
    function DateTimeToDB(InDate: TDateTime): WideString; dispid 269;
    function FloatToDB(InFloat: Double): WideString; dispid 270;
    property IsItWorkplace: WordBool dispid 271;
    property NetTransac: WordBool dispid 272;
    procedure DoWorkPlaceAfterPost; dispid 273;
    procedure DoWorkPlaceBeforePost(const WPAciklama: WideString; WPModulNo: Integer; 
                                    WPProgNo: Integer); dispid 274;
    procedure AddWorkplacePolicy(const ObjectName: WideString); dispid 275;
    procedure DropWorkplacePolicy(const ObjectName: WideString); dispid 276;
    function ConnectionTest: WordBool; dispid 277;
  end;

// *********************************************************************//
// Interface: INetField
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1272F0C0-4920-4414-A627-2A5AC9A370BB}
// *********************************************************************//
  INetField = interface(IDispatch)
    ['{1272F0C0-4920-4414-A627-2A5AC9A370BB}']
    function Get_FieldName: WideString; safecall;
    function Get_DataType: Integer; safecall;
    function Get_AsString: WideString; safecall;
    procedure Set_AsString(const Value: WideString); safecall;
    function Get_AsInteger: Integer; safecall;
    procedure Set_AsInteger(Value: Integer); safecall;
    function Get_AsDateTime: TDateTime; safecall;
    procedure Set_AsDateTime(Value: TDateTime); safecall;
    function Get_AsVariant: OleVariant; safecall;
    procedure Set_AsVariant(Value: OleVariant); safecall;
    function Get_AsFloat: Double; safecall;
    procedure Set_AsFloat(Value: Double); safecall;
    function Get_DisplayText: WideString; safecall;
    property FieldName: WideString read Get_FieldName;
    property DataType: Integer read Get_DataType;
    property AsString: WideString read Get_AsString write Set_AsString;
    property AsInteger: Integer read Get_AsInteger write Set_AsInteger;
    property AsDateTime: TDateTime read Get_AsDateTime write Set_AsDateTime;
    property AsVariant: OleVariant read Get_AsVariant write Set_AsVariant;
    property AsFloat: Double read Get_AsFloat write Set_AsFloat;
    property DisplayText: WideString read Get_DisplayText;
  end;

// *********************************************************************//
// DispIntf:  INetFieldDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1272F0C0-4920-4414-A627-2A5AC9A370BB}
// *********************************************************************//
  INetFieldDisp = dispinterface
    ['{1272F0C0-4920-4414-A627-2A5AC9A370BB}']
    property FieldName: WideString readonly dispid 201;
    property DataType: Integer readonly dispid 202;
    property AsString: WideString dispid 203;
    property AsInteger: Integer dispid 204;
    property AsDateTime: TDateTime dispid 205;
    property AsVariant: OleVariant dispid 206;
    property AsFloat: Double dispid 207;
    property DisplayText: WideString readonly dispid 208;
  end;

// *********************************************************************//
// Interface: INetStrings
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {72D68D7B-47F8-4F28-962C-189A92911227}
// *********************************************************************//
  INetStrings = interface(IDispatch)
    ['{72D68D7B-47F8-4F28-962C-189A92911227}']
    function Get_Text: WideString; safecall;
    procedure Set_Text(const Value: WideString); safecall;
    procedure Add(const Text: WideString); safecall;
    procedure Append(const Text: WideString); safecall;
    function Get_Items(Index: Integer): WideString; safecall;
    function Get_Count: Integer; safecall;
    procedure Delete(Index: Integer); safecall;
    procedure Clear; safecall;
    function Get_Objects(Index: Integer): OleVariant; safecall;
    procedure Set_Objects(Index: Integer; Value: OleVariant); safecall;
    function Get_Strings(Index: Integer): WideString; safecall;
    procedure Set_Strings(Index: Integer; const Value: WideString); safecall;
    property Text: WideString read Get_Text write Set_Text;
    property Items[Index: Integer]: WideString read Get_Items;
    property Count: Integer read Get_Count;
    property Objects[Index: Integer]: OleVariant read Get_Objects write Set_Objects;
    property Strings[Index: Integer]: WideString read Get_Strings write Set_Strings;
  end;

// *********************************************************************//
// DispIntf:  INetStringsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {72D68D7B-47F8-4F28-962C-189A92911227}
// *********************************************************************//
  INetStringsDisp = dispinterface
    ['{72D68D7B-47F8-4F28-962C-189A92911227}']
    property Text: WideString dispid 201;
    procedure Add(const Text: WideString); dispid 202;
    procedure Append(const Text: WideString); dispid 203;
    property Items[Index: Integer]: WideString readonly dispid 204;
    property Count: Integer readonly dispid 205;
    procedure Delete(Index: Integer); dispid 206;
    procedure Clear; dispid 207;
    property Objects[Index: Integer]: OleVariant dispid 208;
    property Strings[Index: Integer]: WideString dispid 209;
  end;

// *********************************************************************//
// Interface: INetFieldDefs
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {31FECBB6-33D2-4285-8AE6-C124A9AA0752}
// *********************************************************************//
  INetFieldDefs = interface(IDispatch)
    ['{31FECBB6-33D2-4285-8AE6-C124A9AA0752}']
    function Get_FieldNo(Index: Integer): Integer; safecall;
    function Get_InternalCalcField(Index: Integer): WordBool; safecall;
    function Get_Required(Index: Integer): WordBool; safecall;
    function Get_DataType(Index: Integer): TNetFieldType; safecall;
    function Get_Precision(Index: Integer): Integer; safecall;
    function Get_Size(Index: Integer): Integer; safecall;
    function Get_Name(Index: Integer): WideString; safecall;
    function Get_Count: Integer; safecall;
    property FieldNo[Index: Integer]: Integer read Get_FieldNo;
    property InternalCalcField[Index: Integer]: WordBool read Get_InternalCalcField;
    property Required[Index: Integer]: WordBool read Get_Required;
    property DataType[Index: Integer]: TNetFieldType read Get_DataType;
    property Precision[Index: Integer]: Integer read Get_Precision;
    property Size[Index: Integer]: Integer read Get_Size;
    property Name[Index: Integer]: WideString read Get_Name;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  INetFieldDefsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {31FECBB6-33D2-4285-8AE6-C124A9AA0752}
// *********************************************************************//
  INetFieldDefsDisp = dispinterface
    ['{31FECBB6-33D2-4285-8AE6-C124A9AA0752}']
    property FieldNo[Index: Integer]: Integer readonly dispid 201;
    property InternalCalcField[Index: Integer]: WordBool readonly dispid 202;
    property Required[Index: Integer]: WordBool readonly dispid 203;
    property DataType[Index: Integer]: TNetFieldType readonly dispid 204;
    property Precision[Index: Integer]: Integer readonly dispid 205;
    property Size[Index: Integer]: Integer readonly dispid 206;
    property Name[Index: Integer]: WideString readonly dispid 207;
    property Count: Integer readonly dispid 208;
  end;

// *********************************************************************//
// Interface: INetCommonQueryDispatcher
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {476CDBBC-F681-4F3F-BBD3-EA65F6AC5377}
// *********************************************************************//
  INetCommonQueryDispatcher = interface(IDispatch)
    ['{476CDBBC-F681-4F3F-BBD3-EA65F6AC5377}']
    function Get_NetsisPaketNo: Integer; safecall;
    function GetNewNetCommonQuery: INetCommonQuery; safecall;
    function Get_WorkplaceSupport: WordBool; safecall;
    property NetsisPaketNo: Integer read Get_NetsisPaketNo;
    property WorkplaceSupport: WordBool read Get_WorkplaceSupport;
  end;

// *********************************************************************//
// DispIntf:  INetCommonQueryDispatcherDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {476CDBBC-F681-4F3F-BBD3-EA65F6AC5377}
// *********************************************************************//
  INetCommonQueryDispatcherDisp = dispinterface
    ['{476CDBBC-F681-4F3F-BBD3-EA65F6AC5377}']
    property NetsisPaketNo: Integer readonly dispid 201;
    function GetNewNetCommonQuery: INetCommonQuery; dispid 202;
    property WorkplaceSupport: WordBool readonly dispid 203;
  end;

// *********************************************************************//
// Interface: INetCommonQueryEvents
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FD24AC06-12F9-4524-B4CD-2B4A2C19C779}
// *********************************************************************//
  INetCommonQueryEvents = interface(IDispatch)
    ['{FD24AC06-12F9-4524-B4CD-2B4A2C19C779}']
    procedure OnRetrieveData(FetchOperation: Integer; FindKeyState: WordBool); safecall;
  end;

// *********************************************************************//
// DispIntf:  INetCommonQueryEventsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FD24AC06-12F9-4524-B4CD-2B4A2C19C779}
// *********************************************************************//
  INetCommonQueryEventsDisp = dispinterface
    ['{FD24AC06-12F9-4524-B4CD-2B4A2C19C779}']
    procedure OnRetrieveData(FetchOperation: Integer; FindKeyState: WordBool); dispid 201;
  end;

// *********************************************************************//
// The Class CoNetCommonQuery provides a Create and CreateRemote method to          
// create instances of the default interface INetCommonQuery exposed by              
// the CoClass NetCommonQuery. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNetCommonQuery = class
    class function Create: INetCommonQuery;
    class function CreateRemote(const MachineName: string): INetCommonQuery;
  end;

// *********************************************************************//
// The Class CoNetField provides a Create and CreateRemote method to          
// create instances of the default interface INetField exposed by              
// the CoClass NetField. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNetField = class
    class function Create: INetField;
    class function CreateRemote(const MachineName: string): INetField;
  end;

// *********************************************************************//
// The Class CoNetStrings provides a Create and CreateRemote method to          
// create instances of the default interface INetStrings exposed by              
// the CoClass NetStrings. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNetStrings = class
    class function Create: INetStrings;
    class function CreateRemote(const MachineName: string): INetStrings;
  end;

// *********************************************************************//
// The Class CoNetCommonQueryDispatcher provides a Create and CreateRemote method to          
// create instances of the default interface INetCommonQueryDispatcher exposed by              
// the CoClass NetCommonQueryDispatcher. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNetCommonQueryDispatcher = class
    class function Create: INetCommonQueryDispatcher;
    class function CreateRemote(const MachineName: string): INetCommonQueryDispatcher;
  end;

implementation

uses ComObj;

class function CoNetCommonQuery.Create: INetCommonQuery;
begin
  Result := CreateComObject(CLASS_NetCommonQuery) as INetCommonQuery;
end;

class function CoNetCommonQuery.CreateRemote(const MachineName: string): INetCommonQuery;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NetCommonQuery) as INetCommonQuery;
end;

class function CoNetField.Create: INetField;
begin
  Result := CreateComObject(CLASS_NetField) as INetField;
end;

class function CoNetField.CreateRemote(const MachineName: string): INetField;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NetField) as INetField;
end;

class function CoNetStrings.Create: INetStrings;
begin
  Result := CreateComObject(CLASS_NetStrings) as INetStrings;
end;

class function CoNetStrings.CreateRemote(const MachineName: string): INetStrings;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NetStrings) as INetStrings;
end;

class function CoNetCommonQueryDispatcher.Create: INetCommonQueryDispatcher;
begin
  Result := CreateComObject(CLASS_NetCommonQueryDispatcher) as INetCommonQueryDispatcher;
end;

class function CoNetCommonQueryDispatcher.CreateRemote(const MachineName: string): INetCommonQueryDispatcher;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NetCommonQueryDispatcher) as INetCommonQueryDispatcher;
end;

end.
