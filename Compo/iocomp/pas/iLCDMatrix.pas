{*******************************************************}
{                                                       }
{       TiLCDMatrix Component                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLCDMatrix;{$endif}
{$ifdef iCLX}unit QiLCDMatrix;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent,  iLCDCharacter;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent, QiLCDCharacter;{$ENDIF}

type
  TClickCellEvent = procedure(Sender: TObject; Col, Row: Integer) of object;

  TiLCDElement = class(TObject)
  public
    Color : TColor;
    AChar : Char;
  end;

  TiLCDMatrix = class(TiCustomComponent)
  private
    FClientRect           : TRect;
    FBorderMargin         : Integer;

    FText                 : String;

    FCharacterList        : TStringList;
    FElementList          : TstringList;

    FCellsHorz            : Integer;
    FCellsVert            : Integer;

    FCellsWidth           : Integer;
    FCellsSpacingHorz     : Integer;
    FCellsSpacingVert     : Integer;
    FCellsColorOn         : TColor;
    FCellsColorOff        : TColor;
    FCellsShowOff         : Boolean;

    FCharactersetWidth    : Integer;
    FCharactersetHeight   : Integer;
    FCharactersetName     : String;

    FCharacterSpacingHorz : Integer;
    FCharacterSpacingVert : Integer;

    FCharactersHorz       : Integer;
    FCharactersVert       : Integer;

    FExtraPixelsHorz      : Integer;
    FExtraPixelsVert      : Integer;

    FDrawStartPoint       : TPoint;

    FOuterMarginTop       : Integer;
    FOuterMarginLeft      : Integer;
    FOuterMarginRight     : Integer;
    FOuterMarginBottom    : Integer;

  protected
    procedure SetText                (const Value: String); reintroduce;

    procedure SetCharactersetWidth   (const Value: Integer);
    procedure SetCharactersetHeight  (const Value: Integer);
    procedure SetCharactersetName    (const Value: String);

    procedure SetCharacterSpacingHorz(const Value: Integer);
    procedure SetCharacterSpacingVert(const Value: Integer);

    procedure SetCellsColorOn        (const Value: TColor);
    procedure SetCellsColorOff       (const Value: TColor);
    procedure SetCellsSpacingHorz    (const Value: Integer);
    procedure SetCellsSpacingVert    (const Value: Integer);
    procedure SetCellsWidth          (const Value: Integer);
    procedure SetCellsShowOff        (const Value: Boolean);

    procedure SetOuterMarginBottom   (const Value: Integer);
    procedure SetOuterMarginLeft     (const Value: Integer);
    procedure SetOuterMarginRight    (const Value: Integer);
    procedure SetOuterMarginTop      (const Value: Integer);


    function GetElementColor   (Col, Row: Integer): TColor;
    function GetElementChar    (Col, Row: Integer): Char;
    function GetElementCharCode(Col, Row: Integer): Integer;

    procedure SetElementColor(Col, Row: Integer; const Value: TColor);
    procedure SetElementChar (Col, Row: Integer; const Value: Char);
    procedure SetElementCode (Col, Row: Integer; const Value: Integer);

    procedure AdjustElementList(RequiredElements: Integer);

    procedure DefineProperties(Filer : TFiler ); override;
    procedure ReadFromStream  (Reader: TReader);
    procedure WriteToStream   (Writer: TWriter);

    function GetCharacterObject(Index: Integer): TiLCDCharacter;
    function GetElementObject  (Index: Integer): TiLCDElement;

    procedure iPaintTo(Canvas: TCanvas); override;

    procedure DrawCalc;
    procedure DrawGrid     (Canvas: TCanvas);
    procedure DrawText     (Canvas: TCanvas);
    procedure DrawCell     (Canvas: TCanvas; Col, Row: Integer; Active: Boolean);
    procedure DrawCharacter(Canvas: TCanvas; Col, Row: Integer; CharacterIndex: Integer; Color: TColor);

    property CharacterObject[Index: Integer] : TiLCDCharacter read GetCharacterObject;
    property ElementObject  [Index: Integer] : TiLCDElement   read GetElementObject;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    procedure LoadDefaultCharacterset;
    procedure BlankAllCharacters;
    procedure SetCharactorRowData(CharacterIndex, RowIndex, Value: Integer);

    procedure LoadCharactersetFromFile(FileName: String);
    procedure SaveCharactersetToFile  (FileName: String);

    procedure Clear;
    procedure PlaceText(AText: String; Col, Row: Integer; AColor: TColor);

    property ElementColor   [Col, Row: Integer]: TColor  read GetElementColor    write SetElementColor;
    property ElementChar    [Col, Row: Integer]: Char    read GetElementChar     write SetElementChar;
    property ElementCharCode[Col, Row: Integer]: Integer read GetElementCharCode write SetElementCode;

    property CharactersHorz       : Integer              read FCharactersHorz;
    property CharactersVert       : Integer              read FCharactersVert;
  published
    property Width  default 300;
    property Height default 100;

    property CharactersetWidth    : Integer              read FCharactersetWidth    write SetCharactersetWidth     default 5;
    property CharactersetHeight   : Integer              read FCharactersetHeight   write SetCharactersetHeight    default 7;

    property CharacterSpacingHorz : Integer              read FCharacterSpacingHorz write SetCharacterSpacingHorz  default 1;
    property CharacterSpacingVert : Integer              read FCharacterSpacingVert write SetCharacterSpacingVert  default 1;

    property CellsColorOn         : TColor               read FCellsColorOn         write SetCellsColorOn          default clAqua;
    property CellsColorOff        : TColor               read FCellsColorOff        write SetCellsColorOff         default clTeal;
    property CellsSpacingHorz     : Integer              read FCellsSpacingHorz     write SetCellsSpacingHorz      default 1;
    property CellsSpacingVert     : Integer              read FCellsSpacingVert     write SetCellsSpacingVert      default 1;
    property CellsWidth           : Integer              read FCellsWidth           write SetCellsWidth            default 2;
    property CellsShowOff         : Boolean              read FCellsShowOff         write SetCellsShowOff;

    property Text                 : String               read FText                 write SetText;

    property OuterMarginLeft      : Integer              read FOuterMarginLeft      write SetOuterMarginLeft       default 5;
    property OuterMarginTop       : Integer              read FOuterMarginTop       write SetOuterMarginTop        default 5;
    property OuterMarginRight     : Integer              read FOuterMarginRight     write SetOuterMarginRight      default 5;
    property OuterMarginBottom    : Integer              read FOuterMarginBottom    write SetOuterMarginBottom     default 5;

    property CharactersetName     : String               read FCharactersetName;

    property BackGroundColor                                                                                       default $0093945F;
    property BorderStyle                                                                                           default ibsRaised;
    property Align;
  end;

implementation

type
  TWriterAccess = class(TWriter) end;
  TReaderAccess = class(TReader) end;
//****************************************************************************************************************************************************
constructor TiLCDMatrix.Create(AOwner: TComponent);
var
  x             : Integer;
  iLCDCharacter : TiLCDCharacter;
begin
  inherited Create(AOwner);

  BorderStyle     := ibsRaised;
  BackGroundColor := $0093945F;

  FCharactersetWidth    := 5;
  FCharactersetHeight   := 7;
  FCharactersetName     := '(Default)';

  FCharacterSpacingHorz := 1;
  FCharacterSpacingVert := 1;
  FCharactersHorz       := 10;

  FCellsColorOn         := clAqua;
  FCellsColorOff        := clTeal;
  FCellsSpacingHorz     := 1;
  FCellsSpacingVert     := 1;
  FCellsWidth           := 2;
  FCellsShowOff         := True;

  FOuterMarginLeft      := 2;
  FOuterMarginTop       := 2;
  FOuterMarginRight     := 2;
  FOuterMarginBottom    := 2;

  FCharacterList := TStringList.Create;

  for x := 0 to 255 do
    begin
      iLCDCharacter := TiLCDCharacter.Create;
      iLCDCharacter.RowCount := FCharactersetHeight;

      FCharacterList.AddObject('', iLCDCharacter);
    end;

  LoadDefaultCharacterset;

  FElementList := TStringList.Create;

  Width  := 300;
  Height := 100;
end;
//****************************************************************************************************************************************************
destructor TiLCDMatrix.Destroy;
begin
  while FCharacterList.Count <> 0 do
    begin
      FCharacterList.Objects[0].Free;
      FCharacterList.Delete(0);
    end;
  FCharacterList.Free;

  while FElementList.Count <> 0 do
    begin
      FElementList.Objects[0].Free;
      FElementList.Delete(0);
    end;
  FElementList.Free;

  inherited;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.SetCharactersetName(const Value: String);
begin
  FCharactersetName := Value;
end;
//****************************************************************************************************************************************************
function TiLCDMatrix.GetCharacterObject(Index: Integer): TiLCDCharacter;
begin
  Result := FCharacterList.Objects[Index] as TiLCDCharacter;
end;
//****************************************************************************************************************************************************
function TiLCDMatrix.GetElementObject(Index: Integer): TiLCDElement;
begin
  Result := FElementList.Objects[Index] as TiLCDElement;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.BlankAllCharacters;
var
  x                : Integer;
  Row              : Integer;
  ACharacterObject : TiLCDCharacter;
begin
  for x := 0 to 255 do
    begin
      ACharacterObject := CharacterObject[x];
      for Row := 0 to FCharactersetHeight-1 do
        ACharacterObject.SetRowData(Row, 0);
    end;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.LoadDefaultCharacterset;
var
  x : Integer;
begin
  for x := 0 to 255 do
    CharacterObject[x].LoadDefault(x);

  CharactersetWidth  := 5;
  CharactersetHeight := 7;

  FCharactersetName  := '(Default)';
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.DrawCalc;
var
  ClientWidth           : Integer;
  ClientHeight          : Integer;
  TotalSpacingCellsHorz : Integer;
  TotalSpacingCellsVert : Integer;
begin
  FBorderMargin         := GetBorderMargin;

  FClientRect.Left      := FBorderMargin + FOuterMarginLeft;
  FClientRect.Top       := FBorderMargin + FOuterMarginTop;
  FClientRect.Right     := Width  - 1 - FBorderMargin - FOuterMarginRight;
  FClientRect.Bottom    := Height - 1 - FBorderMargin - FOuterMarginBottom;

  ClientWidth           := FClientRect.Right  - FClientRect.Left + 1;
  ClientHeight          := FClientRect.Bottom - FClientRect.Top  + 1;

  FCellsHorz            := (ClientWidth  + FCellsSpacingHorz) div (FCellsWidth + FCellsSpacingHorz);
  FCellsVert            := (ClientHeight + FCellsSpacingVert) div (FCellsWidth + FCellsSpacingVert);

  FCellsHorz            := (FCellsHorz div (FCharactersetWidth  + FCharacterSpacingHorz)) * (FCharactersetWidth  + FCharacterSpacingHorz);
  FCellsVert            := (FCellsVert div (FCharactersetHeight + FCharacterSpacingVert)) * (FCharactersetHeight + FCharacterSpacingVert);

  TotalSpacingCellsHorz := (FCellsHorz-1)*FCellsSpacingHorz;
  TotalSpacingCellsVert := (FCellsVert-1)*FCellsSpacingVert;

  FCharactersHorz       := (FCellsHorz + FCharacterSpacingHorz) div (FCharactersetWidth  + FCharacterSpacingHorz);
  FCharactersVert       := (FCellsVert + FCharacterSpacingVert) div (FCharactersetHeight + FCharacterSpacingVert);

  FExtraPixelsHorz      := ClientWidth  - (FCellsHorz * FCellsWidth) - TotalSpacingCellsHorz;
  FExtraPixelsVert      := ClientHeight - (FCellsVert * FCellsWidth) - TotalSpacingCellsVert;

  FDrawStartPoint.X     := FClientRect.Left + FExtraPixelsHorz div 2;
  FDrawStartPoint.Y     := FClientRect.Top  + FExtraPixelsVert div 2;

  AdjustElementList(FCharactersHorz * FCharactersVert);
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.DrawGrid(Canvas: TCanvas);
var
  Col, Row : Integer;
begin
  if not FCellsShowOff then Exit;

  Canvas.Brush.Color := FCellsColorOff;
  Canvas.Pen.Color   := FCellsColorOff;

  for Col := 0 to FCellsHorz-1 do
    for Row := 0 to FCellsVert-1 do
      DrawCell(Canvas, Col, Row, False);
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.DrawCell(Canvas: TCanvas; Col, Row: Integer; Active: Boolean);
var
  ARect : TRect;
begin
  ARect.Left   := FDrawStartPoint.X + Col * (FCellsWidth + FCellsSpacingHorz);
  ARect.Top    := FDrawStartPoint.Y + Row * (FCellsWidth + FCellsSpacingVert);
  ARect.Right  := ARect.Left + FCellsWidth;
  ARect.Bottom := ARect.Top  + FCellsWidth;

  Canvas.FillRect(ARect);
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.DrawCharacter(Canvas: TCanvas; Col, Row: Integer; CharacterIndex: Integer; Color: TColor);
var
  CellColStart : Integer;
  CellRowstart : Integer;
  ACharacter   : TiLCDCharacter;

  CellRow      : Integer;
  CellCol      : Integer;
  CellRowData  : Integer;
  CellOn       : Boolean;
begin
  if (Col < 0) or (Col > (FCharactersHorz -1)) then Exit;
  if (Row < 0) or (Row > (FCharactersVert -1)) then Exit;

  CellColStart := Col *(FCharactersetWidth  + FCharacterSpacingHorz);
  CellRowStart := Row *(FCharactersetHeight + FCharacterSpacingVert);

  Canvas.Brush.Color := Color;
  Canvas.Pen.Color   := Color;

  ACharacter := CharacterObject[CharacterIndex];

  for CellRow := 0 to FCharactersetHeight-1 do
    begin
      CellRowData := ACharacter.GetRowData(CellRow);
      for CellCol := 0 to FCharactersetWidth -1 do
        begin
          CellOn := CellRowData and (1 shl (FCharactersetWidth - CellCol -1)) > 0;
          if CellOn then DrawCell(Canvas, CellColStart + CellCol, CellRowstart + CellRow, CellOn);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.DrawText(Canvas: TCanvas);
var
  x        : Integer;
  Row, Col : Integer;
begin
  for x := 0 to FElementList.Count-1 do
    begin
      if ElementObject[x].AChar = #0 then Continue;

      Row := x div FCharactersHorz;
      Col := x mod FCharactersHorz;

      DrawCharacter(Canvas, Col, Row, ord(ElementObject[x].AChar), ElementObject[x].Color);
    end;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.iPaintTo(Canvas: TCanvas);
begin
  DrawBackGround(Canvas, BackGroundColor);

  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Style   := psSolid;

  DrawCalc;
  DrawGrid(Canvas);
  DrawText(Canvas);
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.SetCharacterSpacingHorz(const Value: Integer);begin if Value < 0 then Exit; SetIntegerProperty(Value, FCharacterSpacingHorz, irtInvalidate);end;
procedure TiLCDMatrix.SetCharacterSpacingVert(const Value: Integer);begin if Value < 0 then Exit; SetIntegerProperty(Value, FCharacterSpacingVert, irtInvalidate);end;
procedure TiLCDMatrix.SetCharactersetWidth   (const Value: Integer);begin if Value < 1 then Exit; SetIntegerProperty(Value, FCharactersetWidth,    irtInvalidate);end;
procedure TiLCDMatrix.SetCellsWidth          (const Value: Integer);begin if Value < 1 then Exit; SetIntegerProperty(Value, FCellsWidth,           irtInvalidate);end;
procedure TiLCDMatrix.SetCellsSpacingHorz    (const Value: Integer);begin if Value < 0 then Exit; SetIntegerProperty(Value, FCellsSpacingHorz,     irtInvalidate);end;
procedure TiLCDMatrix.SetCellsSpacingVert    (const Value: Integer);begin if Value < 0 then Exit; SetIntegerProperty(Value, FCellsSpacingVert,     irtInvalidate);end;
procedure TiLCDMatrix.SetCellsColorOff       (const Value: TColor );begin                         SetColorProperty  (Value, FCellsColorOff,        irtInvalidate);end;
procedure TiLCDMatrix.SetCellsShowOff        (const Value: Boolean);begin                         SetBooleanProperty(Value, FCellsShowOff,         irtInvalidate);end;
procedure TiLCDMatrix.SetOuterMarginBottom   (const Value: Integer);begin if Value < 0 then Exit; SetIntegerProperty(Value, FOuterMarginBottom,    irtInvalidate);end;
procedure TiLCDMatrix.SetOuterMarginLeft     (const Value: Integer);begin if Value < 0 then Exit; SetIntegerProperty(Value, FOuterMarginLeft,      irtInvalidate);end;
procedure TiLCDMatrix.SetOuterMarginRight    (const Value: Integer);begin if Value < 0 then Exit; SetIntegerProperty(Value, FOuterMarginRight,     irtInvalidate);end;
procedure TiLCDMatrix.SetOuterMarginTop      (const Value: Integer);begin if Value < 0 then Exit; SetIntegerProperty(Value, FOuterMarginTop,       irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.SetCellsColorOn(const Value: TColor);
var
  x : Integer;
begin
  if FCellsColorOn <> Value then
    begin
      FCellsColorOn := Value;

      for x := 0 to FElementList.Count-1 do
        ElementObject[x].Color := Value;
        
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.SetCharactersetHeight(const Value: Integer);
var
  x : Integer;
begin
  if Value < 1 then Exit;
  if FCharactersetHeight <> Value then
    begin
      FCharactersetHeight := Value;
       for x := 0 to 255 do
         CharacterObject[x].RowCount := Value;
      InvalidateChange;   
    end;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.SetCharactorRowData(CharacterIndex, RowIndex, Value: Integer);
begin
  CharacterObject[CharacterIndex].SetRowData(RowIndex, Value);
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Characters', ReadFromStream, WriteToStream, True);
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.WriteToStream(Writer: TWriter);
var
  x : Integer;
begin
  TWriterAccess(Writer).WriteValue(vaCollection);
  for x := 0 to 255 - 1 do
  begin
    Writer.WriteListBegin;
    WriterWriteProperties(Writer, CharacterObject[x]);
    Writer.WriteListEnd;
  end;
  Writer.WriteListEnd;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.ReadFromStream(Reader: TReader);
var
  CurrentIndex : Integer;
begin
  CurrentIndex := 0;
  if TReaderAccess(Reader).ReadValue <> vaCollection then exit;
  while not Reader.EndOfList do
  begin
    Reader.ReadListBegin;
    while not Reader.EndOfList do TReaderAccess(Reader).ReadProperty(CharacterObject[CurrentIndex]);
    Reader.ReadListEnd;
    Inc(CurrentIndex)
  end;
  Reader.ReadListEnd;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.LoadCharactersetFromFile(FileName: String);
var
  x            : Integer;
  Row          : Integer;
  StringList   : TStringList;
  NewWidth     : Integer;
  NewHeight    : Integer;
  CurrentIndex : Integer;
begin
  StringList := TStringList.Create;
  try
    StringList.LoadFromFile(FileName);

    CurrentIndex := 0;

    NewWidth  := StrToInt(StringList.Strings[CurrentIndex]); Inc(CurrentIndex);
    NewHeight := StrToInt(StringList.Strings[CurrentIndex]); Inc(CurrentIndex);

    if (NewHeight*256 + 2) <> StringList.Count then raise Exception.Create('Invalid Characterset File Format');

    FCharactersetName := ExtractFileName(FileName);

    CharactersetWidth  := NewWidth;
    CharactersetHeight := NewHeight;

    for x := 0 to 255 do
      for Row := 0 to NewHeight-1 do
        begin
          CharacterObject[x].SetRowData(Row, StrToInt(StringList.Strings[CurrentIndex]));
          Inc(CurrentIndex);
        end;

  finally
    StringList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.SaveCharactersetToFile(FileName: String);
var
  x          : Integer;
  Row        : Integer;
  StringList : TStringList;
begin
  StringList := TStringList.Create;
  try
    StringList.Add(IntToStr(CharactersetWidth));
    StringList.Add(IntToStr(CharactersetHeight));

    for x := 0 to 255 do
      for Row := 0 to CharactersetHeight-1 do
        StringList.Add(IntToStr(CharacterObject[x].GetRowData(Row)));

    StringList.SaveToFile(FileName);
    FCharactersetName := ExtractFileName(FileName);
  finally
    StringList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.AdjustElementList(RequiredElements: Integer);
var
  Element : TiLCDElement;
begin
  if FElementList.Count < RequiredElements then
    begin
      while FElementList.Count < RequiredElements do
        begin
          Element := TiLCDElement.Create;
          Element.Color := FCellsColorOn;
          Element.AChar := #0;
          FElementList.AddObject('', Element);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.SetText(const Value: String);
begin
  FText := Value;
  Clear;
  PlaceText(FText, 0, 0, FCellsColorOn);
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.PlaceText(AText: String; Col, Row: Integer; AColor: TColor);
var
  x            : Integer;
  StartIndex   : Integer;
  AShortString : ShortString;
begin
  DrawCalc;
  StartIndex := Row*FCharactersHorz + Col;

  AdjustElementList(StartIndex + Length(AText));

  for x := 0 to Length(AText)-1 do
    begin
      if (x + StartIndex) > FElementList.Count-1 then Break;
      AShortString := Copy(AText, x + 1, 1);
      ElementObject[StartIndex + x].AChar := AShortString[1];
      ElementObject[StartIndex + x].Color := AColor;
    end;

  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.Clear;
var
  x : Integer;
begin
  for x := 0 to FElementList.Count-1 do
    begin
      ElementObject[x].Color := FCellsColorOn;
      ElementObject[x].AChar := #0;
    end;

  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiLCDMatrix.GetElementColor(Col, Row: Integer): TColor;
begin
  DrawCalc;

  Result := clBlack;
  if Col < 0                  then Exit;
  if Row < 0                  then Exit;
  if Col > FCharactersHorz -1 then Exit;
  if Row > FCharactersVert -1 then Exit;

  Result := ElementObject[Row*FCharactersHorz + Col].Color;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.SetElementColor(Col, Row: Integer; const Value: TColor);
begin
  DrawCalc;

  if Col < 0                  then Exit;
  if Row < 0                  then Exit;
  if Col > FCharactersHorz -1 then Exit;
  if Row > FCharactersVert -1 then Exit;

  ElementObject[Row*FCharactersHorz + Col].Color := Value;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiLCDMatrix.GetElementChar(Col, Row: Integer): Char;
begin
  DrawCalc;

  Result := #0;
  if Col < 0                  then Exit;
  if Row < 0                  then Exit;
  if Col > FCharactersHorz -1 then Exit;
  if Row > FCharactersVert -1 then Exit;

  Result := ElementObject[Row*FCharactersHorz + Col].AChar;
end;
//****************************************************************************************************************************************************
function TiLCDMatrix.GetElementCharCode(Col, Row: Integer): Integer;
begin
  DrawCalc;

  Result := 0;
  if Col < 0                  then Exit;
  if Row < 0                  then Exit;
  if Col > FCharactersHorz -1 then Exit;
  if Row > FCharactersVert -1 then Exit;

  Result := ord(ElementObject[Row*FCharactersHorz + Col].AChar);
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.SetElementChar(Col, Row: Integer; const Value: Char);
begin
  DrawCalc;

  if Col < 0                  then Exit;
  if Row < 0                  then Exit;
  if Col > FCharactersHorz -1 then Exit;
  if Row > FCharactersVert -1 then Exit;

  ElementObject[Row*FCharactersHorz + Col].AChar := Value;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrix.SetElementCode(Col, Row: Integer; const Value: Integer);
begin
  DrawCalc;

  if Col < 0                  then Exit;
  if Row < 0                  then Exit;
  if Col > FCharactersHorz -1 then Exit;
  if Row > FCharactersVert -1 then Exit;

  ElementObject[Row*FCharactersHorz + Col].AChar := chr(Value);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
end.
