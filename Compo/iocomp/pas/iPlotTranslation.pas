{*******************************************************}
{                                                       }
{       iPlotObjects                                    }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotTranslation;{$endif}
{$ifdef iCLX}unit QiPlotTranslation;{$endif}

interface                                                       

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions;{$ENDIF}

type
  TiPlotTranslationObject = class(TPersistent)
  private
    FOnInsert          : TNotifyEvent;
    FOnRemove          : TNotifyEvent;
    FOriginalString    : String;
    FReplacementString : String;
  public
    constructor Create(AOnInsert, AOnRemove: TNotifyEvent); virtual;
    destructor  Destroy; override;
  published
    property OriginalString    : String read FOriginalString    write FOriginalString;
    property ReplacementString : String read FReplacementString write FReplacementString;
  end;

  TiPlotTranslationManager = class(TObject)
  private
    FList     : TStringList;
    FOnInsert : TNotifyEvent;
    FOnRemove : TNotifyEvent;
  protected
    function  GetCount: Integer;
    function  GetItem  (Index: Integer): TiPlotTranslationObject;
  public
    constructor Create(AOnInsert, AOnRemove: TNotifyEvent); virtual;
    destructor  Destroy; override;

    function  DoWriteToStream : Boolean;
    procedure WriteToStream (Writer: TWriter);
    procedure ReadFromStream(Reader: TReader);

    procedure SaveToFile  (FileName: String);
    procedure LoadFromFile(FileName: String);

    procedure NotificationInsert(Sender : TObject);
    procedure NotificationRemove(Sender : TObject);

    procedure Clear;
    procedure Delete(Index: Integer);
    function  CreateObject : TiPlotTranslationObject; 
    function  Add: Integer;
    function  FindReplacement(OriginalString: String): String;

    property  Items[Index: Integer]: TiPlotTranslationObject read GetItem;
    property  Count                : Integer                 read GetCount;
  end;

implementation

type
  TWriterAccess          = class(TWriter    ) end;
  TReaderAccess          = class(TReader    ) end;
  TPersistentAccess      = class(TPersistent) end;
//****************************************************************************************************************************************************
constructor TiPlotTranslationObject.Create(AOnInsert, AOnRemove: TNotifyEvent);
begin
  FOnInsert := AOnInsert;
  FOnRemove := AOnRemove;

  FOriginalString    := 'Unknown';
  FReplacementString := 'Unknown';

  if Assigned(FOnInsert) then FOnInsert(Self);
end;
//****************************************************************************************************************************************************
destructor TiPlotTranslationObject.Destroy;
begin
  if Assigned(FOnRemove) then FOnRemove(Self);
  inherited;
end;
//****************************************************************************************************************************************************
constructor TiPlotTranslationManager.Create(AOnInsert, AOnRemove: TNotifyEvent);
begin
  if not Assigned(AOnInsert)  then raise Exception.Create('OnInsert event handler can not be null');
  if not Assigned(AOnRemove)  then raise Exception.Create('OnRemove event handler can not be null');

  FOnInsert := AOnInsert;
  FOnRemove := AOnRemove;

  FList            := TStringList.Create;
  FList.Sorted     := True;
  FList.Duplicates := dupAccept;

  FOnInsert(Self);
end;
//****************************************************************************************************************************************************
destructor TiPlotTranslationManager.Destroy;
begin
  Clear;
  FList.Free;

  if Assigned(FOnRemove) then FOnRemove(Self);
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotTranslationManager.Clear;
begin
  while FList.Count <> 0 do
    FList.Objects[0].Free;
end;
//****************************************************************************************************************************************************
procedure TiPlotTranslationManager.Delete(Index: Integer);
begin
  FList.Objects[Index].Free;
end;
//****************************************************************************************************************************************************
function TiPlotTranslationManager.CreateObject: TiPlotTranslationObject;
begin
  Result := TiPlotTranslationObject.Create(FOnInsert, FOnRemove);
end;
//****************************************************************************************************************************************************
function TiPlotTranslationManager.Add: Integer;
var
  iTranslationObject : TiPlotTranslationObject;
begin
  iTranslationObject := CreateObject;
  Result := FList.IndexOfObject(iTranslationObject);
end;
//****************************************************************************************************************************************************
function TiPlotTranslationManager.GetCount: Integer;
begin
  Result := FList.Count;
end;
//****************************************************************************************************************************************************
function TiPlotTranslationManager.GetItem(Index: Integer): TiPlotTranslationObject;
begin
  Result := FList.Objects[Index] as TiPlotTranslationObject;
end;
//****************************************************************************************************************************************************
function TiPlotTranslationManager.DoWriteToStream: Boolean;
begin
  Result := FList.Count <> 0;
end;
//****************************************************************************************************************************************************
procedure TiPlotTranslationManager.WriteToStream(Writer: TWriter);
var
  x : Integer;
begin
  TWriterAccess(Writer).WriteValue(vaCollection);
  for x := 0 to Count - 1 do
  begin
    Writer.WriteListBegin;
    WriterWriteProperties(Writer, GetItem(x));
    Writer.WriteListEnd;
  end;
  Writer.WriteListEnd;
end;
//****************************************************************************************************************************************************
procedure TiPlotTranslationManager.ReadFromStream(Reader: TReader);
var
  Item : TiPlotTranslationObject;
begin
  Clear;
  if not Reader.EndOfList then Clear;
  if TReaderAccess(Reader).ReadValue <> vaCollection then exit;
  while not Reader.EndOfList do
  begin
    Item := CreateObject;
    Reader.ReadListBegin;
    while not Reader.EndOfList do TReaderAccess(Reader).ReadProperty(Item);
    Reader.ReadListEnd;
  end;
  Reader.ReadListEnd; 
end;
//****************************************************************************************************************************************************
function TiPlotTranslationManager.FindReplacement(OriginalString: String): String;
var
  X : Integer;
begin
  Result := OriginalString;
  for x := 0 to Count-1 do
    if (FList.Objects[x] as TiPlotTranslationObject).OriginalString = OriginalString then
      begin
        Result := (FList.Objects[x] as TiPlotTranslationObject).ReplacementString;
        Break;
      end;
end;
//****************************************************************************************************************************************************
procedure TiPlotTranslationManager.SaveToFile(FileName: String);
var
  x     : Integer;
  AList : TStringList;
begin
  try
    AList := TStringList.Create;
    try
      for x := 0 to Count-1 do
        AList.Add(Items[x].OriginalString + chr(9) + Items[x].ReplacementString);
      AList.SaveToFile(FileName);
    finally
      AList.Free;
    end;
  except
    on e: Exception do raise Exception.Create('Error Saving Translation Data - ' + e.message);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotTranslationManager.LoadFromFile(FileName: String);
var
  iTranslationObject : TiPlotTranslationObject;
  x                  : Integer;
  AList              : TStringList;
  TabPos             : Integer;
  AString            : String;
  OriginalString     : String;
  ReplacementString  : String;
begin
  try
    AList := TStringList.Create;
    try
      AList.LoadFromFile(FileName);
      Clear;
      for x := 0 to AList.Count-1 do
        begin
          AString := AList.Strings[x];
          TabPos := Pos(Chr(9), AString);

          if TabPos = 0 then raise Exception.Create('Invalid Format - Tab Deliminator Missing');

          OriginalString := Copy(Astring, 1, TabPos-1);
          ReplacementString := Copy(AString, TabPos+1, Length(AString) - TabPos);

          iTranslationObject := CreateObject;
          iTranslationObject.OriginalString    := OriginalString;
          iTranslationObject.ReplacementString := ReplacementString;
        end;

    finally
      AList.Free;
    end;
  except
    on e: Exception do raise Exception.Create('Error Loading Data - ' + e.message);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotTranslationManager.NotificationInsert(Sender: TObject);
begin
  if Sender is TiPlotTranslationObject then if FList.IndexOfObject(Sender) = -1 then FList.AddObject('', Sender)
end;
//****************************************************************************************************************************************************
procedure TiPlotTranslationManager.NotificationRemove(Sender: TObject);
var
  x : Integer;
begin
  for x := 0 to Count-1 do
    if (FList.Objects[x] = Sender) then
      begin
        FList.Delete(x);
        Break;
      end;
end;
//****************************************************************************************************************************************************
end.
