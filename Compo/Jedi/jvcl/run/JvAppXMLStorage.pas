{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvAppXMLStorage.pas, released on 2003-12-06.

The Initial Developer of the Original Code is Olivier Sannier
Portions created by Olivier Sannier are Copyright (C) 2003 Olivier Sannier
All Rights Reserved.

Contributor(s):
  Marcel Bestebroer

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvAppXMLStorage.pas 11918 2008-09-24 21:02:48Z jfudickar $

unit JvAppXMLStorage;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF MSWINDOWS}
  {$IFDEF HAS_UNIT_LIBC}
  Libc,
  {$ENDIF HAS_UNIT_LIBC}
  Classes,
  {$IFNDEF CLR}
  JclBase,
  {$ENDIF !CLR}
  JvAppStorage, JvPropertyStore, JvSimpleXml, JvTypes;

type
  TJvCustomAppXMLStorage = class;

  TJvAppXMLStorageOptions = class(TJvAppStorageOptions)
  private
    FAutoEncodeEntity: Boolean;
    FAutoEncodeValue: Boolean;
    FAutoIndent: Boolean;
    FInvalidCharReplacement: string;
    FWhiteSpaceReplacement: string;
    FStorage: TJvCustomAppXMLStorage;
    function GetAutoEncodeEntity: Boolean;
    function GetAutoEncodeValue: Boolean;
    procedure SetAutoEncodeEntity(const Value: Boolean);
    procedure SetAutoEncodeValue(const Value: Boolean);
    function GetAutoIndent: Boolean;
    procedure SetAutoIndent(const Value: Boolean);
    procedure SetInvalidCharReplacement(const Value: string);
    procedure SetWhiteSpaceReplacement(const Value: string);
  protected
  public
    constructor Create; override;
    procedure Assign(Source: TPersistent); override;
  published
    //Flag to determine if a stringlist should be stored as single string and not as list of string items
    property StoreStringListAsSingleString;
    property WhiteSpaceReplacement: string read FWhiteSpaceReplacement write SetWhiteSpaceReplacement;
    property AutoEncodeValue: Boolean read GetAutoEncodeValue write
        SetAutoEncodeValue default True;
    property AutoEncodeEntity: Boolean read GetAutoEncodeEntity write
        SetAutoEncodeEntity default True;
    property AutoIndent: Boolean read GetAutoIndent write SetAutoIndent default
        True;
    property InvalidCharReplacement: string read FInvalidCharReplacement write SetInvalidCharReplacement;
  end;

  // This is the base class for an in memory XML file storage
  // There is at the moment only one derived class that simply
  // allows to flush into a disk file.
  // But there may be a new descendent that stores into a
  // database field, if anyone is willing to write such
  // a class (nothing much is involved, use the AsString property).
  TJvCustomAppXMLStorage = class(TJvCustomAppMemoryFileStorage)
  private
    function GetStorageOptions: TJvAppXMLStorageOptions;
    procedure SetStorageOptions(Value: TJvAppXMLStorageOptions);
  protected
    FXml: TJvSimpleXML;

    class function GetStorageOptionsClass: TJvAppStorageOptionsClass; override;

    function GetAsString: string; override;
    procedure SetAsString(const Value: string); override;

    function CheckNodeNameCharacters(const NodeName: string): string;

    function DefaultExtension: string; override;

    function GetOnDecodeValue: TJvSimpleXMLEncodeEvent;
    function GetOnEncodeValue: TJvSimpleXMLEncodeEvent;
    procedure SetOnDecodeValue(const Value: TJvSimpleXMLEncodeEvent);
    procedure SetOnEncodeValue(const Value: TJvSimpleXMLEncodeEvent);

    function GetRootNodeName: string;
    procedure SetRootNodeName(const Value: string);
    // Returns the last node in path, if it exists.
    // Returns nil in all other cases
    // If StartNode is nil, then FXML.Root is used as a
    // starting point for Path
    function GetNodeFromPath(Path: string; StartNode: TJvSimpleXmlElem = nil): TJvSimpleXmlElem;
    // Reads the \ separated Key string and returns the last created node
    function CreateAndSetNode(Key: string): TJvSimpleXmlElem;
    procedure EnumFolders(const Path: string; const Strings: TStrings;
      const ReportListAsValue: Boolean = True); override;
    procedure EnumValues(const Path: string; const Strings: TStrings;
      const ReportListAsValue: Boolean = True); override;
    function IsFolderInt(const Path: string; ListIsValue: Boolean = True): Boolean; override;
    procedure SplitKeyPath(const Path: string; out Key, ValueName: string); override;
    function PathExistsInt(const Path: string): Boolean; override;
    function ValueStoredInt(const Path: string): Boolean; override;
    procedure DeleteValueInt(const Path: string); override;
    procedure DeleteSubTreeInt(const Path: string); override;
    function DoReadBoolean(const Path: string; Default: Boolean): Boolean; override;
    procedure DoWriteBoolean(const Path: string; Value: Boolean); override;
    function DoReadInteger(const Path: string; Default: Integer): Integer; override;
    procedure DoWriteInteger(const Path: string; Value: Integer); override;
    function DoReadFloat(const Path: string; Default: Extended): Extended; override;
    procedure DoWriteFloat(const Path: string; Value: Extended); override;
    function DoReadString(const Path: string; const Default: string): string; override;
    procedure DoWriteString(const Path: string; const Value: string); override;
    function DoReadBinary(const Path: string; Buf: TJvBytes; BufSize: Integer): Integer; override;
    procedure DoWriteBinary(const Path: string; const Buf: TJvBytes; BufSize: Integer); override;
    function GetValueElementFromNode(Node: TJvSimpleXMLElem; ValueName: string):
        TJvSimpleXMLElem;
    { Determines if the specified list is stored (ignores sub stores) }
    function ListStoredInt(const Path: string; const ItemName: string = cItem):
        Boolean; override;
    function ReadListItemCount(const Path: string; const ItemName: string = cItem):
        Integer; override;
    function SplitNodeNameIndex(var sNodeName : String; var sIndex : Integer):
        Boolean;
    procedure WriteListItemCount(const Path: string; const ItemCount: Integer;
        const ItemName: string = cItem); override;

    property Xml: TJvSimpleXML read FXml;
    property RootNodeName: string read GetRootNodeName write SetRootNodeName;
    property OnEncodeValue: TJvSimpleXMLEncodeEvent read GetOnEncodeValue write SetOnEncodeValue;
    property OnDecodeValue: TJvSimpleXMLEncodeEvent read GetOnDecodeValue write SetOnDecodeValue;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property StorageOptions: TJvAppXMLStorageOptions read GetStorageOptions write SetStorageOptions;
  end;

  // This class handles the flushing into a disk file
  // and publishes a few properties for them to be
  // used by the user in the IDE
  TJvAppXMLFileStorage = class(TJvCustomAppXMLStorage)
  private
    procedure FlushInternal;
    procedure ReloadInternal;
  public
    procedure Flush; override;
    procedure Reload; override;
    property Xml;
    property AsString;
  published
    property AutoFlush;
    property AutoReload;
    property FileName;
    property FlushOnDestroy;
    property Location;
    property RootNodeName;
    property SubStorages;
    property OnGetFileName;
    property OnEncodeValue;
    property OnDecodeValue;
    //1 Synchronize the Flush and Reload procedure
    /// Defines if the execution of flush and reload for the current
    /// File should be synchronized via a global mutex
    property SynchronizeFlushReload;
  end;

procedure StorePropertyStoreToXmlFile(APropertyStore: TJvCustomPropertyStore;
    const AFileName: string; const AAppStoragePath: string = '';
    AStorageOptions: TJvCustomAppStorageOptions = nil);
procedure LoadPropertyStoreFromXmlFile(APropertyStore: TJvCustomPropertyStore;
    const AFileName: string; const AAppStoragePath: string = '';
    AStorageOptions: TJvCustomAppStorageOptions = nil);

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/run/JvAppXMLStorage.pas $';
    Revision: '$Revision: 11918 $';
    Date: '$Date: 2008-09-24 23:02:48 +0200 (mer., 24 sept. 2008) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils, TypInfo,
  JclStrings,
  JvVCL5Utils, JvJCLUtils, JvConsts, JvResources;

const
  cNullDigit = '0';
  cCount = 'Count';
  cEmptyPath = 'EmptyPath';
  AllowedNodeNameChars = ['A'..'Z', 'a'..'z', '0'..'9', '_', '-', '.', ':'];

//=== { TJvAppXMLStorageOptions } ============================================

constructor TJvAppXMLStorageOptions.Create;
begin
  inherited Create;
  FWhiteSpaceReplacement := '';  // to keep the original behaviour
  FInvalidCharReplacement := '_';
  FAutoEncodeEntity := True;
  FAutoEncodeValue := True;
  FAutoIndent := True;
end;

procedure TJvAppXMLStorageOptions.Assign(Source: TPersistent);
begin
  if (Source = Self) then
    Exit;
  if Source is TJvAppXMLStorageOptions then
  begin
    WhiteSpaceReplacement := TJvAppXMLStorageOptions(Source).WhiteSpaceReplacement;
    AutoEncodeValue := TJvAppXMLStorageOptions(Source).AutoEncodeValue;
    AutoEncodeEntity := TJvAppXMLStorageOptions(Source).AutoEncodeEntity;
    AutoIndent := TJvAppXMLStorageOptions(Source).AutoIndent;
    InvalidCharReplacement := TJvAppXMLStorageOptions(Source).InvalidCharReplacement;
  end;
  inherited assign(Source);
end;

function TJvAppXMLStorageOptions.GetAutoEncodeEntity: Boolean;
begin
  if Assigned(FStorage) then
    Result := sxoAutoEncodeEntity in FStorage.Xml.Options
  else
    Result := FAutoEncodeEntity;
end;

function TJvAppXMLStorageOptions.GetAutoEncodeValue: Boolean;
begin
  if Assigned(FStorage) then
    Result := sxoAutoEncodeValue in FStorage.Xml.Options
  else
    Result := FAutoEncodeValue;
end;

function TJvAppXMLStorageOptions.GetAutoIndent: Boolean;
begin
  if Assigned(FStorage) then
    Result := sxoAutoIndent in FStorage.Xml.Options
  else
    Result := FAutoIndent;
end;

procedure TJvAppXMLStorageOptions.SetAutoEncodeEntity(const Value: Boolean);
begin
  FAutoEncodeEntity := Value;
  if Assigned(FStorage) then
    if Value then
      FStorage.Xml.Options := FStorage.Xml.Options + [sxoAutoEncodeEntity]
    else
      FStorage.Xml.Options := FStorage.Xml.Options - [sxoAutoEncodeEntity];
end;

procedure TJvAppXMLStorageOptions.SetAutoEncodeValue(const Value: Boolean);
begin
  FAutoEncodeValue := Value;
  if Assigned(FStorage) then
    if Value then
      FStorage.Xml.Options := FStorage.Xml.Options + [sxoAutoEncodeValue]
    else
      FStorage.Xml.Options := FStorage.Xml.Options - [sxoAutoEncodeValue];
end;

procedure TJvAppXMLStorageOptions.SetAutoIndent(const Value: Boolean);
begin
  FAutoIndent := Value;
  if Assigned(FStorage) then
    if Value then
      FStorage.Xml.Options := FStorage.Xml.Options + [sxoAutoIndent]
    else
      FStorage.Xml.Options := FStorage.Xml.Options - [sxoAutoIndent];
end;

procedure TJvAppXMLStorageOptions.SetInvalidCharReplacement(const Value: string);
var
  I: Integer;
begin
  if Value <> FInvalidCharReplacement then
  begin
    for I := 1 to Length(Value) do
      if not CharInSet(Value[I], AllowedNodeNameChars) then
        {$IFDEF CLR}
        raise EJVCLException.CreateFmt(RsENotAllowedCharacterForProperty, [Value[I], 'InvalidCharReplacement']);
        {$ELSE}
        raise EJVCLException.CreateResFmt(@RsENotAllowedCharacterForProperty, [Value[I], 'InvalidCharReplacement']);
        {$ENDIF CLR}
    FInvalidCharReplacement := Value;
  end;
end;

procedure TJvAppXMLStorageOptions.SetWhiteSpaceReplacement(const Value: string);
var
  I: Integer;
begin
  if Value <> FWhiteSpaceReplacement then
    if StrContainsChars(Value, CharIsWhiteSpace, True) then
      {$IFDEF CLR}
      raise EJVCLException.Create(RsEWhiteSpaceReplacementCannotContainSpaces)
      {$ELSE}
      raise EJVCLException.CreateRes(@RsEWhiteSpaceReplacementCannotContainSpaces)
      {$ENDIF CLR}
    else
    begin
      for I := 1 to Length(Value) do
        if not CharInSet(Value[I], AllowedNodeNameChars) then
          {$IFDEF CLR}
          raise EJVCLException.CreateFmt(RsENotAllowedCharacterForProperty, [Value[I], 'WhiteSpaceReplacement']);
          {$ELSE}
          raise EJVCLException.CreateResFmt(@RsENotAllowedCharacterForProperty, [Value[I], 'WhiteSpaceReplacement']);
          {$ENDIF CLR}
      FWhiteSpaceReplacement := Value;
    end;
end;

//=== { TJvCustomAppXMLStorage } =============================================

constructor TJvCustomAppXMLStorage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  (StorageOptions as TJvAppXMLStorageOptions).FStorage := Self;
  FXml := TJvSimpleXml.Create(nil);
  TJvAppXMLStorageOptions(StorageOptions).AutoEncodeValue := True;
  TJvAppXMLStorageOptions(StorageOptions).AutoEncodeEntity := True;
  TJvAppXMLStorageOptions(StorageOptions).AutoIndent := True;
  // (rom) should probably be a resourcestring
  RootNodeName := 'Configuration';
end;

destructor TJvCustomAppXMLStorage.Destroy;
begin
  inherited Destroy;
  // delete after the inherited call, see comment in
  // the base class, TJvCustomMemoryFileAppStorage
  FXml.Free;
end;

function TJvCustomAppXMLStorage.GetValueElementFromNode(Node: TJvSimpleXMLElem;
    ValueName: string): TJvSimpleXMLElem;
var
  Index: Integer;
begin
  if Assigned(Node) then
    if SplitNodeNameIndex(ValueName, Index) then
      Result := Node.Items.NamedElems[ValueName].Item[Index]
    else
      Result := Node.Items.ItemNamed[ValueName]
  else
    Result := nil;
end;

class function TJvCustomAppXMLStorage.GetStorageOptionsClass: TJvAppStorageOptionsClass;
begin
  Result := TJvAppXMLStorageOptions;
end;

function TJvCustomAppXMLStorage.CheckNodeNameCharacters(const NodeName: string): string;
var
  J, K: Integer;
  WSRLength: Integer;
  ICRLength: Integer;
  CurLength: Integer;
  InsertIndex: Integer;
  FixedNodeName: string;
  WhiteSpaceReplacement: string;
  InvalidCharReplacement: string;
begin
  WhiteSpaceReplacement := TJvAppXMLStorageOptions(StorageOptions).WhiteSpaceReplacement;
  InvalidCharReplacement := TJvAppXMLStorageOptions(StorageOptions).InvalidCharReplacement;
  FixedNodeName := NodeName;
  WSRLength := Length(WhiteSpaceReplacement);
  ICRLength := Length(InvalidCharReplacement);
  CurLength := Length(NodeName);
  SetLength(FixedNodeName, CurLength);
  InsertIndex := 0;
  for J := 1 to Length(NodeName) do
  begin
    Inc(InsertIndex);
    if CharIsWhiteSpace(NodeName[J]) then
      case WSRLength of
        0:
          {$IFDEF CLR}
          raise EJVCLException.Create(RsENodeNameCannotContainSpaces);
          {$ELSE}
          raise EJVCLException.CreateRes(@RsENodeNameCannotContainSpaces);
          {$ENDIF CLR}
        1:
          FixedNodeName[InsertIndex] := WhiteSpaceReplacement[1];
        else
          for K := 1 to WSRLength do
          begin
            FixedNodeName[InsertIndex] := WhiteSpaceReplacement[K];
            Inc(InsertIndex);
            Inc(CurLength);
            SetLength(FixedNodeName, CurLength);
          end;
      end   // case WSRLength of
    else
    if not CharInSet(NodeName[J], AllowedNodeNameChars) then
      case ICRLength of
        0:
          {$IFDEF CLR}
          raise EJVCLException.CreateFmt(RsENodeNameCannotInvalidChars, [NodeName[J]]);
          {$ELSE}
          raise EJVCLException.CreateResFmt(@RsENodeNameCannotInvalidChars, [NodeName[J]]);
          {$ENDIF CLR}
        1:
          FixedNodeName[InsertIndex] := InvalidCharReplacement[1];
        else
          for K := 1 to ICRLength do
          begin
            FixedNodeName[InsertIndex] := InvalidCharReplacement[K];
            Inc(InsertIndex);
            Inc(CurLength);
            SetLength(FixedNodeName, CurLength);
          end;
      end   // case WSRLength of
    else
      FixedNodeName[InsertIndex] := NodeName[J];
  end;
  Result := FixedNodeName;
end;

procedure TJvCustomAppXMLStorage.SetRootNodeName(const Value: string);
begin
  if Value = '' then
    {$IFDEF CLR}
    raise EPropertyError.Create(RsENodeCannotBeEmpty)
    {$ELSE}
    raise EPropertyError.CreateRes(@RsENodeCannotBeEmpty)
    {$ENDIF CLR}
  else
  begin
    Xml.Root.Name := CheckNodeNameCharacters(Value);
    Root := Value;
  end;
end;

procedure TJvCustomAppXMLStorage.SplitKeyPath(const Path: string; out Key, ValueName: string);
begin
  inherited SplitKeyPath(Path, Key, ValueName);
//  ValueName := CheckNodeNameCharacters(ValueName);
  if Key = '' then
    Key := Path;
end;

function TJvCustomAppXMLStorage.ValueStoredInt(const Path: string): Boolean;
var
  Section: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, Section, ValueName);
  Node := GetNodeFromPath(Section);
  Result := Assigned(GetValueElementFromNode(Node, ValueName));
end;

procedure TJvCustomAppXMLStorage.DeleteValueInt(const Path: string);
var
  Node: TJvSimpleXmlElem;
  Section: string;
  ValueName: string;
  Index: Integer;
begin
  if ValueStored(Path) then
  begin
    ReloadIfNeeded;
    SplitKeyPath(Path, Section, ValueName);
    Node := GetNodeFromPath(Section);

    if Assigned(Node) then
    begin
      if SplitNodeNameIndex(ValueName, Index) then
        Node.Items.NamedElems[ValueName].Delete(Index)
      else
        Node.Items.Delete(ValueName);
    end;
    FlushIfNeeded;
  end;
end;

procedure TJvCustomAppXMLStorage.DeleteSubTreeInt(const Path: string);
var
  TopNode: string;
  Node: TJvSimpleXmlElem;
  Parent: TJvSimpleXmlElem;
  Name: string;
begin
  ReloadIfNeeded;
  TopNode := GetAbsPath(Path);
  if TopNode = '' then
    TopNode := Path;
  Node := GetNodeFromPath(TopNode);
  if Assigned(Node) then
  begin
    Name := Node.Name;
    Parent := Node.Parent;
    if Assigned(Parent) then
      Parent.Items.Delete(Name)
    else
      Node.Clear;
    FlushIfNeeded;
  end;
end;

function TJvCustomAppXMLStorage.DoReadInteger(const Path: string; Default: Integer): Integer;
var
  ParentPath: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
  ValueElem: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);

  Node := GetNodeFromPath(ParentPath);

  ValueElem := GetValueElementFromNode(Node, ValueName);
  if Assigned(ValueElem) then
  begin
    try
      Result := ValueElem.IntValue;
    except
      if StorageOptions.DefaultIfReadConvertError then
        Result := Default
      else
        raise;
    end;
  end
  else
    if StorageOptions.DefaultIfValueNotExists then
      Result := Default
    else
      {$IFDEF CLR}
      raise EJVCLException.CreateFmt(RsEPathDoesntExists, [Path]);
      {$ELSE}
      raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [Path]);
      {$ENDIF CLR}
end;

procedure TJvCustomAppXMLStorage.DoWriteInteger(const Path: string; Value: Integer);
var
  ParentPath: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
  ValueElem: TJvSimpleXMLElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);
  Node := CreateAndSetNode(ParentPath);
  Xml.Options := Xml.Options + [sxoAutoCreate];
  ValueElem := GetValueElementFromNode(Node, ValueName);
  if Assigned(ValueElem) then
    ValueElem.IntValue := Value;
  Xml.Options := Xml.Options - [sxoAutoCreate];
  FlushIfNeeded;
end;

function TJvCustomAppXMLStorage.DoReadFloat(const Path: string; Default: Extended): Extended;
var
  ParentPath: string;
  ValueName: string;
  StrValue: string;
  Node: TJvSimpleXmlElem;
  ValueElem: TJvSimpleXMLElem;
  {$IFDEF CLR}
  Buf: array [0..10 - 1] of Byte;
  {$ENDIF CLR}
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);

  Node := GetNodeFromPath(ParentPath);

  ValueElem := GetValueElementFromNode(Node, ValueName);
  if Assigned(ValueElem) then
  begin
    try
      StrValue := ValueElem.Value;
      // Result := StrToFloat(StrValue);
      {$IFDEF CLR}
      if BinStrToBuf(StrValue, Buf, Length(Buf)) = Length(Buf) then
        Result := ExtendedAsBytesToDouble(Buf)
      else
      {$ELSE}
      if BinStrToBuf(StrValue, @Result, SizeOf(Result)) <> SizeOf(Result) then
      {$ENDIF CLR}
        Result := Default;
    except
      if StorageOptions.DefaultIfReadConvertError then
        Result := Default
      else
        raise;
    end;
  end
  else
  if StorageOptions.DefaultIfValueNotExists then
    Result := Default
  else
    {$IFDEF CLR}
    raise EJVCLException.CreateFmt(RsEPathDoesntExists, [Path]);
    {$ELSE}
    raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [Path]);
    {$ENDIF CLR}
end;

procedure TJvCustomAppXMLStorage.DoWriteFloat(const Path: string; Value: Extended);
var
  ParentPath: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
  ValueElem: TJvSimpleXMLElem;
  {$IFDEF CLR}
  Buf: array [0..10 - 1] of Byte;
  {$ENDIF CLR}
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);
  Node := CreateAndSetNode(ParentPath);
  Xml.Options := Xml.Options + [sxoAutoCreate];
  ValueElem := GetValueElementFromNode(Node, ValueName);
  if Assigned(ValueElem) then
    ValueElem.Value :=
    {$IFDEF CLR}
    BufToBinStr(DoubleToExtendedAsBytes(Value), 10);
    {$ELSE}
    BufToBinStr(@Value, SizeOf(Value));
    {$ENDIF CLR}
  Xml.Options := Xml.Options - [sxoAutoCreate];
  FlushIfNeeded;
end;

function TJvCustomAppXMLStorage.DoReadString(const Path: string; const Default: string): string;
var
  ParentPath: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
  ValueElem: TJvSimpleXMLElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);

  Node := GetNodeFromPath(ParentPath);

  ValueElem := GetValueElementFromNode(Node, ValueName);
  if Assigned(ValueElem) then
    try
      Result := ValueElem.Value;
    except
      if StorageOptions.DefaultIfReadConvertError then
        Result := Default
      else
        raise;
    end
  else
  if StorageOptions.DefaultIfValueNotExists then
    Result := Default
  else
    {$IFDEF CLR}
    raise EJVCLException.CreateFmt(RsEPathDoesntExists, [Path]);
    {$ELSE}
    raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [Path]);
    {$ENDIF CLR}
end;

procedure TJvCustomAppXMLStorage.DoWriteString(const Path: string; const Value: string);
var
  ParentPath: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
  ValueElem: TJvSimpleXMLElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);
  Node := CreateAndSetNode(ParentPath);
  Xml.Options := Xml.Options + [sxoAutoCreate];
  ValueElem := GetValueElementFromNode(Node, ValueName);
  if Assigned(ValueElem) then
    ValueElem.Value := Value;
  Xml.Options := Xml.Options - [sxoAutoCreate];
  FlushIfNeeded;
end;

function TJvCustomAppXMLStorage.DoReadBinary(const Path: string; Buf: TJvBytes; BufSize: Integer): Integer;
var
  Value: string;
begin
  ReloadIfNeeded;
  Value := DoReadString(Path, '');
  Result := BinStrToBuf(Value, Buf, BufSize);
end;

procedure TJvCustomAppXMLStorage.DoWriteBinary(const Path: string; const Buf: TJvBytes; BufSize: Integer);
begin
  ReloadIfNeeded;
  DoWriteString(Path, BufToBinStr(Buf, BufSize));
  FlushIfNeeded;
end;

procedure TJvCustomAppXMLStorage.EnumFolders(const Path: string;
  const Strings: TStrings; const ReportListAsValue: Boolean);
var
  RefPath: string;
  I: Integer;
  Node: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  RefPath := GetAbsPath(Path);
  if RefPath = '' then
    RefPath := cEmptyPath;

  Node := GetNodeFromPath(RefPath);

  if Node <> nil then
  begin
    Strings.BeginUpdate;
    try
      Strings.Clear;
      for I := 0 to Node.Items.Count - 1 do
        if Node.Items[i].Items.Count > 0 then
          Strings.Add(Node.Items[I].Name);
    finally
      Strings.EndUpdate;
    end;
  end
//  else
//    {$IFDEF CLR}
//    raise EJVCLException.CreateFmt(RsEPathDoesntExists, [RefPath]);
//    {$ELSE}
//    raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [RefPath]);
//    {$ENDIF CLR}
end;

procedure TJvCustomAppXMLStorage.EnumValues(const Path: string;
  const Strings: TStrings; const ReportListAsValue: Boolean);
var
  PathIsList: Boolean;
  RefPath: string;
  I: Integer;
  Node: TJvSimpleXmlElem;
  Name: string;
begin
  ReloadIfNeeded;
  PathIsList := ReportListAsValue and ListStored(Path);
  RefPath := GetAbsPath(Path);
  if RefPath = '' then
    RefPath := cEmptyPath;

  Node := GetNodeFromPath(RefPath);

  if Node <> nil then
  begin
    Strings.BeginUpdate;
    try
      Strings.Clear;
      for I := 0 to Node.Items.Count - 1 do
      begin
        Name := Node.Items[I].Name;
        if (not PathIsList or (not AnsiSameText(cCount, Name) and
          not NameIsListItem(Name)))  //and not IsFolder(FullName)
          then
          Strings.Add(Name);
      end;
      i := Strings.Count-1;
      while i >= 0 do
      begin
        if ListStored(ConcatPaths([Path, Strings[i]])) or IsFolder(ConcatPaths([Path, Strings[i]])) then
          Strings.Delete(i);
        Dec(i);
      end;
    finally
      Strings.EndUpdate;
    end;
  end
//  else
//    {$IFDEF CLR}
//    raise EJVCLException.CreateFmt(RsEPathDoesntExists, [RefPath]);
//    {$ELSE}
//    raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [RefPath]);
//    {$ENDIF CLR}
end;

function TJvCustomAppXMLStorage.IsFolderInt(const Path: string;
  ListIsValue: Boolean): Boolean;
var
  RefPath: string;
  ValueNames: TStrings;
  I: Integer;
  Node: TJvSimpleXmlElem;
  Name: string;
begin
  ReloadIfNeeded;
  RefPath := GetAbsPath(Path);
  if RefPath = '' then
    RefPath := cEmptyPath;

  Node := GetNodeFromPath(RefPath);
  if Assigned(Node) then
    if ListIsValue and Assigned(Node.Items.ItemNamed[cCount]) then
    begin
      ValueNames := TStringList.Create;
      try
        I := 0;
        repeat
          Name := Node.Items[I].Name;
          Result := not AnsiSameText(cCount, Name) and not NameIsListItem(Name);
          Inc(I);
        until (I = Node.Items.Count) or Result;
      finally
        ValueNames.Free;
      end;
    end
    else
      Result := Node.Items.Count>0
  else
    Result := False;
end;


function TJvCustomAppXMLStorage.GetRootNodeName: string;
begin
  Result := Xml.Root.Name;
end;

function TJvCustomAppXMLStorage.CreateAndSetNode(Key: string): TJvSimpleXmlElem;
begin
  Xml.Options := Xml.Options + [sxoAutoCreate];
  Result := GetNodeFromPath(Key);
  Xml.Options := Xml.Options - [sxoAutoCreate];
end;

function TJvCustomAppXMLStorage.GetNodeFromPath(Path: string; StartNode: TJvSimpleXmlElem = nil): TJvSimpleXmlElem;
var
  NodeList: TStringList;
  I: Integer;
  Node: TJvSimpleXmlElem;
  NodeName: string;
  Index : Integer;

begin
  Result := nil;

  ReloadIfNeeded;
  NodeList := TStringList.Create;
  if StartNode <> nil then
    Node := StartNode
  else
    Node := Xml.Root;

  try
    try
      StrToStrings(Path, '\', NodeList, False);
      for I := 0 to NodeList.Count - 1 do
      begin
        // Node names cannot have spaces in them so we replace
        // those spaces by the replacement string. If there is
        // no such string, we trigger an exception as the XML
        // standard doesn't allow spaces in node names

        NodeName := NodeList[I];

        SplitNodeNameIndex(NodeName, Index);

        // If the name is the same as the root AND the first in
        if not ((I = 0) and (NodeName = Xml.Root.Name)) then
          if Index >= 0 then
            if Assigned(Node.Items.NamedElems[NodeName].Item[Index]) then
              Node := Node.Items.NamedElems[NodeName].Item[Index]
            else
              Exit
          else
            if Assigned(Node.Items.ItemNamed[NodeName]) then
              Node := Node.Items.ItemNamed[NodeName]
            else
              Exit;
      end;
    finally
      NodeList.Free;
    end;
  except
    Node := nil;
  end;
  Result := Node;
end;

function TJvCustomAppXMLStorage.PathExistsInt(const Path: string): Boolean;
var
  SubKey: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
begin
  Result := False;
  SplitKeyPath(Path, SubKey, ValueName);
  Node := GetNodeFromPath(SubKey);
  if Assigned(Node) then
    Result := Assigned(Node.Items.ItemNamed[ValueName]);
end;

function TJvCustomAppXMLStorage.DoReadBoolean(const Path: string;
  Default: Boolean): Boolean;
var
  ParentPath: string;
  ValueName: string;
  Node: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);

  Node := GetNodeFromPath(ParentPath);

  if Assigned(Node) and Assigned(Node.Items.ItemNamed[ValueName]) then
    try
      Result := Node.Items.ItemNamed[ValueName].BoolValue;
    except
      if StorageOptions.DefaultIfReadConvertError then
        Result := Default
      else
        raise;
    end
  else
  if StorageOptions.DefaultIfValueNotExists then
    Result := Default
  else
    {$IFDEF CLR}
    raise EJVCLException.CreateFmt(RsEPathDoesntExists, [Path]);
    {$ELSE}
    raise EJVCLException.CreateResFmt(@RsEPathDoesntExists, [Path]);
    {$ENDIF IF}
end;

procedure TJvCustomAppXMLStorage.DoWriteBoolean(const Path: string;
  Value: Boolean);
var
  ParentPath: string;
  ValueName: string;
  ANode: TJvSimpleXmlElem;
begin
  ReloadIfNeeded;
  SplitKeyPath(Path, ParentPath, ValueName);
  ANode := CreateAndSetNode(ParentPath);
  Xml.Options := Xml.Options + [sxoAutoCreate];
  ANode.Items.ItemNamed[ValueName].BoolValue := Value;
  Xml.Options := Xml.Options - [sxoAutoCreate];
  FlushIfNeeded;
end;

function TJvCustomAppXMLStorage.GetAsString: string;
begin
  Result := Xml.SaveToString;
end;

procedure TJvCustomAppXMLStorage.SetAsString(const Value: string);
begin
  Xml.LoadFromString(Value);
end;

function TJvCustomAppXMLStorage.DefaultExtension: string;
begin
  Result := 'xml';
end;

function TJvCustomAppXMLStorage.GetOnDecodeValue: TJvSimpleXMLEncodeEvent;
begin
  Result := FXml.OnDecodeValue;
end;

function TJvCustomAppXMLStorage.GetOnEncodeValue: TJvSimpleXMLEncodeEvent;
begin
  Result := FXml.OnEncodeValue;
end;

procedure TJvCustomAppXMLStorage.SetOnDecodeValue(const Value: TJvSimpleXMLEncodeEvent);
begin
  FXml.OnDecodeValue := Value;
end;

procedure TJvCustomAppXMLStorage.SetOnEncodeValue(const Value: TJvSimpleXMLEncodeEvent);
begin
  FXml.OnEncodeValue := Value;
end;

function TJvCustomAppXMLStorage.GetStorageOptions: TJvAppXMLStorageOptions;
begin
  Result := TJvAppXMLStorageOptions(inherited StorageOptions);
end;

function TJvCustomAppXMLStorage.ListStoredInt(const Path: string; const
    ItemName: string = cItem): Boolean;
begin
  if StorageOptions.UseOldItemNameFormat then
    Result := Inherited ListStoredInt(Path, ItemName)
  else
    Result := ReadListItemCount (Path, ItemName) > 0;
end;

function TJvCustomAppXMLStorage.ReadListItemCount(const Path: string; const
    ItemName: string = cItem): Integer;
var
  Node: TJvSimpleXmlElem;
begin
  if StorageOptions.UseOldItemNameFormat then
    Result := Inherited ReadListItemCount(Path, ItemName)
  else
  begin
    Node := GetNodeFromPath(Path);
    if Assigned(Node) then
      Result := Node.Items.NamedElems[CheckNodeNameCharacters(Trim(ItemName))].Count
    else
      Result := 0;
  end;
end;

procedure TJvCustomAppXMLStorage.SetStorageOptions(Value: TJvAppXMLStorageOptions);
begin
  (Inherited StorageOptions).Assign(Value);
end;

function TJvCustomAppXMLStorage.SplitNodeNameIndex(var sNodeName : String; var
    sIndex : Integer): Boolean;
var sh : string;
  p: Integer;
begin
  sIndex := -1;
  Result := False;
  if StorageOptions.UseOldItemNameFormat then
  begin
    sNodeName := CheckNodeNameCharacters(sNodeName);
    Exit;
  end;
  sh := trim(sNodeName);
  p := Pos(']', sh);
  if  p <> Length(sh) then
  begin
    sNodeName := CheckNodeNameCharacters(sNodeName);
    Exit;
  end;
  p := CharLastPos(sh, '[');
  if p > 0 then
  begin
    try
      sIndex := StrToInt(Copy(sh, p+1, Length(sh)-p-1));
      sNodeName := CheckNodeNameCharacters(trim(Copy(sNodeName, 1, p-1)));
    except
      on e:exception do
    end;
  end;
  Result := sIndex >= 0;
end;

procedure TJvCustomAppXMLStorage.WriteListItemCount(const Path: string; const
    ItemCount: Integer; const ItemName: string = cItem);
begin
  if StorageOptions.UseOldItemNameFormat then
    Inherited WriteListItemCount(Path, ItemCount, ItemName)
  else
  // No Write necessary
end;

//=== { TJvAppXMLFileStorage } ===============================================

procedure TJvAppXMLFileStorage.Flush;
var
  Path: string;
begin
  if (FullFileName <> '') and not ReadOnly and not (csDesigning in ComponentState) then
  begin
    try
      Path := ExtractFilePath(FullFileName);
      if Path <> '' then
        ForceDirectories(Path);
      if SynchronizeFlushReload then
        Synchronize(FlushInternal, FullFileName)
      else
        FlushInternal;
    except
      on E: Exception do
        DoError(E.Message);
    end;
  end;
end;

procedure TJvAppXMLFileStorage.FlushInternal;
begin
  Xml.SaveToFile(FullFileName);
end;

procedure TJvAppXMLFileStorage.Reload;
begin
  if not IsUpdating and not (csDesigning in ComponentState) then
  begin
    inherited Reload;
    if FileExists(FullFileName) then
      if SynchronizeFlushReload then
        Synchronize(ReloadInternal, FullFileName)
      else
        ReloadInternal
    else // file may have disappeared. If so, clear the root element
      Xml.Root.Clear;
  end;
end;

procedure TJvAppXMLFileStorage.ReloadInternal;
begin
  Xml.LoadFromFile(FullFileName);
end;

//=== { Common procedures } ==================================================

procedure StorePropertyStoreToXmlFile(APropertyStore: TJvCustomPropertyStore;
    const AFileName: string; const AAppStoragePath: string = '';
    AStorageOptions: TJvCustomAppStorageOptions = nil);
var
  AppStorage: TJvAppXMLFileStorage;
  SaveAppStorage: TJvCustomAppStorage;
  SaveAppStoragePath: string;
begin
  if not Assigned(APropertyStore) then
    Exit;
  AppStorage := TJvAppXMLFileStorage.Create(nil);
  try
    AppStorage.StorageOptions.WhiteSpaceReplacement := '_';
    AppStorage.StorageOptions.UseOldItemNameFormat := False;
    if Assigned(AStorageOptions) then
      AppStorage.StorageOptions.Assign(AStorageOptions);
    AppStorage.Location := flCustom;
    AppStorage.FileName := AFileName;
    SaveAppStorage := APropertyStore.AppStorage;
    SaveAppStoragePath := APropertyStore.AppStoragePath;
    try
      APropertyStore.AppStoragePath := AAppStoragePath;
      APropertyStore.AppStorage := AppStorage;
      APropertyStore.StoreProperties;
    finally
      APropertyStore.AppStoragePath := SaveAppStoragePath;
      APropertyStore.AppStorage := SaveAppStorage;
    end;
  finally
    AppStorage.Free;
  end;
end;

procedure LoadPropertyStoreFromXmlFile(APropertyStore: TJvCustomPropertyStore;
    const AFileName: string; const AAppStoragePath: string = '';
    AStorageOptions: TJvCustomAppStorageOptions = nil);
var
  AppStorage: TJvAppXMLFileStorage;
  SaveAppStorage: TJvCustomAppStorage;
  SaveAppStoragePath: string;
begin
  if not Assigned(APropertyStore) then
    Exit;
  AppStorage := TJvAppXMLFileStorage.Create(nil);
  try
    AppStorage.StorageOptions.WhiteSpaceReplacement := '_';
    AppStorage.StorageOptions.UseOldItemNameFormat := False;
    if Assigned(AStorageOptions) then
      AppStorage.StorageOptions.Assign(AStorageOptions);
    AppStorage.Location := flCustom;
    AppStorage.FileName := AFileName;
    SaveAppStorage := APropertyStore.AppStorage;
    SaveAppStoragePath := APropertyStore.AppStoragePath;
    try
      APropertyStore.AppStoragePath := AAppStoragePath;
      APropertyStore.AppStorage := AppStorage;
      APropertyStore.LoadProperties;
    finally
      APropertyStore.AppStoragePath := SaveAppStoragePath;
      APropertyStore.AppStorage := SaveAppStorage;
    end;
  finally
    AppStorage.Free;
  end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

