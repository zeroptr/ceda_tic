{*******************************************************}
{                                                       }
{       iLCDCharacter Object                            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLCDCharacter;{$endif}
{$ifdef iCLX}unit QiLCDCharacter;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions;{$ENDIF}

type
  TiLCDCharacter = class(TPersistent)
  private
    FDataList : TList;

    procedure AddRow   (Value: Integer);
    procedure SetRowCount(const Value: Integer);

    function GetData: String;
    procedure SetData(const Value: String);

    procedure AddRowsData(const Args: array of Integer);
    function  GetRowCount               : Integer;
  protected

  public
    constructor Create;
    destructor  Destroy; override;

    procedure Assign(Source: TPersistent); override;

    procedure DeleteRow(Index: Integer);
    procedure RemoveAllRows;
    procedure LoadDefault(Value: Integer);

    function  GetRowData(Index: Integer): Integer;
    procedure SetRowData(Index: Integer; Value: Integer);

    property RowCount : Integer read GetRowCount write SetRowCount;
  published
    property Data : String read GetData write SetData;
  end;


implementation
//****************************************************************************************************************************************************
constructor TiLCDCharacter.Create;
begin
  FDataList := TList.Create;        
end;
//****************************************************************************************************************************************************
destructor TiLCDCharacter.Destroy;
begin
  FDataList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiLCDCharacter.AddRow(Value: Integer);
begin
  FDataList.Add(Pointer(Value));
end;
//****************************************************************************************************************************************************
procedure TiLCDCharacter.RemoveAllRows;
begin
  FDataList.Clear;
end;
//****************************************************************************************************************************************************
procedure TiLCDCharacter.DeleteRow(Index: Integer);
begin
  FDataList.Delete(Index);
end;
//****************************************************************************************************************************************************
function TiLCDCharacter.GetRowCount: Integer;
begin
  Result := FDataList.Count;
end;
//****************************************************************************************************************************************************
procedure TiLCDCharacter.SetRowCount(const Value: Integer);
begin
  if Value = RowCount then Exit;
  
  while RowCount > Value do
    DeleteRow(RowCount-1);

  while RowCount < Value do
    AddRow(0);
end;
//****************************************************************************************************************************************************
function TiLCDCharacter.GetRowData(Index: Integer): Integer;
begin
  Result := Integer(FDataList.Items[Index]);
end;
//****************************************************************************************************************************************************
procedure TiLCDCharacter.SetRowData(Index, Value: Integer);
begin
  FDataList.Items[Index] := Pointer(Value);
end;
//****************************************************************************************************************************************************
function TiLCDCharacter.GetData: String;
var
  x : Integer;
begin
  Result := '';
  for x := 0 to FDataList.Count-1 do
    if x <> FDataList.Count-1 then
      Result := Result + IntToStr(GetRowData(x)) + ','
    else
      Result := Result + IntToStr(GetRowData(x));
end;
//****************************************************************************************************************************************************
procedure TiLCDCharacter.SetData(const Value: String);
var
  x           : Integer;
  StringList  : TStringList;
  BuildString : String;
begin
  StringList := TStringList.Create;
  try
    BuildString := '';

    for x := 0 to Length(Value)-1 do
      begin
        if Copy(Value, x+1, 1) = ',' then
          begin
            StringList.Add(BuildString);
            BuildString := '';
          end
        else BuildString := BuildString + Copy(Value, x+1, 1);
      end;
    StringList.Add(BuildString);

    for x := 0 to FDataList.Count-1 do
      begin
        if x > (StringList.Count -1) then Break;
        SetRowData(x, StrToInt(StringList.Strings[x]));
      end;
  finally
    StringList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiLCDCharacter.AddRowsData(const Args: array of Integer);
var
  x : Integer;
begin
   for x := 0 to High(Args) do
     AddRow(Args[x]);
end;
//****************************************************************************************************************************************************
procedure TiLCDCharacter.LoadDefault(Value: Integer);
begin
  RemoveAllRows;

  case Value of
    0..32    : AddRowsData([00,00,00,00,00,00,00]);
    33       : AddRowsData([04,04,04,04,04,00,04]);
    34       : AddRowsData([10,10,00,00,00,00,00]);
    35       : AddRowsData([00,10,31,10,31,10,00]);
    36       : AddRowsData([04,15,20,14,05,30,04]);
    37       : AddRowsData([25,26,02,04,08,11,19]);
    38       : AddRowsData([12,18,20,08,21,18,13]);
    39       : AddRowsData([04,04,00,00,00,00,00]);
    40       : AddRowsData([02,04,08,08,08,04,02]);
    41       : AddRowsData([08,04,02,02,02,04,08]);
    42       : AddRowsData([00,04,21,14,21,04,00]);
    43       : AddRowsData([00,04,04,31,04,04,00]);
    44       : AddRowsData([00,00,00,00,12,12,16]);
    45       : AddRowsData([00,00,00,31,00,00,00]);
    46       : AddRowsData([00,00,00,00,12,12,00]);
    47       : AddRowsData([01,01,02,04,08,16,16]);
    48       : AddRowsData([14,17,19,21,25,17,14]);
    49       : AddRowsData([04,12,04,04,04,04,14]);
    50       : AddRowsData([14,17,01,02,04,08,31]);
    51       : AddRowsData([14,17,01,06,01,17,14]);
    52       : AddRowsData([02,06,10,18,31,02,02]);
    53       : AddRowsData([31,16,30,01,01,17,14]);
    54       : AddRowsData([14,17,16,30,17,17,14]);
    55       : AddRowsData([31,01,01,02,04,04,04]);
    56       : AddRowsData([14,17,17,14,17,17,14]);
    57       : AddRowsData([14,17,17,15,01,17,14]);
    58       : AddRowsData([00,12,12,00,12,12,00]);
    59       : AddRowsData([00,12,12,00,12,12,16]);
    60       : AddRowsData([02,04,08,16,08,04,02]);
    61       : AddRowsData([00,00,31,00,31,00,00]);
    62       : AddRowsData([08,04,02,01,02,04,08]);
    63       : AddRowsData([14,17,01,02,04,00,04]);
    64       : AddRowsData([14,17,19,21,23,16,15]);
    65       : AddRowsData([14,17,17,31,17,17,17]);
    66       : AddRowsData([30,17,17,30,17,17,30]);
    67       : AddRowsData([14,17,16,16,16,17,14]);
    68       : AddRowsData([30,17,17,17,17,17,30]);
    69       : AddRowsData([31,16,16,30,16,16,31]);
    70       : AddRowsData([31,16,16,30,16,16,16]);
    71       : AddRowsData([14,17,16,19,17,17,14]);
    72       : AddRowsData([17,17,17,31,17,17,17]);
    73       : AddRowsData([14,04,04,04,04,04,14]);
    74       : AddRowsData([01,01,01,01,17,17,14]);
    75       : AddRowsData([17,18,20,24,20,18,17]);
    76       : AddRowsData([16,16,16,16,16,16,31]);
    77       : AddRowsData([17,27,21,21,17,17,17]);
    78       : AddRowsData([17,25,21,19,17,17,17]);
    79       : AddRowsData([14,17,17,17,17,17,14]);
    80       : AddRowsData([30,17,17,30,16,16,16]);
    81       : AddRowsData([14,17,17,17,17,14,01]);
    82       : AddRowsData([30,17,17,30,17,17,17]);
    83       : AddRowsData([14,17,16,14,01,17,14]);
    84       : AddRowsData([31,04,04,04,04,04,04]);
    85       : AddRowsData([17,17,17,17,17,17,14]);
    86       : AddRowsData([17,17,17,17,17,10,04]);
    87       : AddRowsData([17,17,17,17,21,27,17]);
    88       : AddRowsData([17,10,04,04,04,10,17]);
    89       : AddRowsData([17,17,17,10,04,04,04]);
    90       : AddRowsData([31,01,02,04,08,16,31]);
    91       : AddRowsData([12,08,08,08,08,08,12]);
    92       : AddRowsData([00,16,08,04,02,01,00]);
    93       : AddRowsData([06,02,02,02,02,02,06]);
    94       : AddRowsData([04,10,17,00,00,00,00]);
    95       : AddRowsData([00,00,00,00,00,00,31]);
    96       : AddRowsData([06,04,02,00,00,00,00]);
    97       : AddRowsData([00,00,14,01,15,17,15]);
    98       : AddRowsData([16,16,30,17,17,17,30]);
    99       : AddRowsData([00,00,15,16,16,16,15]);
    100      : AddRowsData([01,01,15,17,17,17,15]);
    101      : AddRowsData([00,00,14,17,31,16,14]);
    102      : AddRowsData([03,04,31,04,04,04,04]);
    103      : AddRowsData([00,00,15,17,15,01,14]);
    104      : AddRowsData([16,16,22,25,17,17,17]);
    105      : AddRowsData([04,00,12,04,04,04,14]);
    106      : AddRowsData([02,00,06,02,02,18,12]);
    107      : AddRowsData([16,16,18,20,24,20,18]);
    108      : AddRowsData([12,04,04,04,04,04,14]);
    109      : AddRowsData([00,00,26,21,21,21,21]);
    110      : AddRowsData([00,00,22,25,17,17,17]);
    111      : AddRowsData([00,00,14,17,17,17,14]);
    112      : AddRowsData([00,00,30,17,30,16,16]);
    113      : AddRowsData([00,00,15,17,15,01,01]);
    114      : AddRowsData([00,00,11,12,08,08,08]);
    115      : AddRowsData([00,00,14,16,14,01,30]);
    116      : AddRowsData([04,04,31,04,04,04,03]);
    117      : AddRowsData([00,00,17,17,17,19,13]);
    118      : AddRowsData([00,00,17,17,17,10,04]);
    119      : AddRowsData([00,00,17,17,21,21,10]);
    120      : AddRowsData([00,00,17,10,04,10,17]);
    121      : AddRowsData([00,00,17,17,15,01,14]);
    122      : AddRowsData([00,00,31,02,04,08,31]);
    123      : AddRowsData([03,04,04,08,04,04,03]);
    124      : AddRowsData([04,04,04,04,04,04,04]);
    125      : AddRowsData([24,04,04,02,04,04,24]);
    126      : AddRowsData([08,21,02,00,00,00,00]);
    127      : AddRowsData([00,00,00,00,00,00,00]);
    128      : AddRowsData([06,09,28,08,28,09,06]);
    129..160 : AddRowsData([00,00,00,00,00,00,00]);
    161      : AddRowsData([04,00,04,04,04,04,04]);
    162      : AddRowsData([04,15,20,20,20,15,04]);
    163      : AddRowsData([06,09,08,30,08,08,31]);
    164      : AddRowsData([00,17,14,17,14,17,00]);
    165      : AddRowsData([17,10,31,04,31,04,04]);
    166      : AddRowsData([04,04,04,00,04,04,04]);
    167      : AddRowsData([14,17,12,19,14,01,30]);
    168      : AddRowsData([10,00,00,00,00,00,00]);
    169      : AddRowsData([14,17,23,25,23,17,14]);
    170      : AddRowsData([04,02,14,10,06,00,14]);
    171      : AddRowsData([00,00,09,18,09,00,00]);
    172      : AddRowsData([00,00,00,14,02,00,00]);
    173      : AddRowsData([00,00,00,14,00,00,00]);
    174      : AddRowsData([14,17,29,27,29,27,14]);
    175      : AddRowsData([31,00,00,00,00,00,00]);
    176      : AddRowsData([06,09,06,00,00,00,00]);
    177      : AddRowsData([00,04,14,04,00,14,00]);
    178      : AddRowsData([12,02,04,08,14,00,00]);
    179      : AddRowsData([12,02,04,02,12,00,00]);
    180      : AddRowsData([07,06,08,00,00,00,00]);
    181      : AddRowsData([00,17,17,17,25,22,16]);
    182      : AddRowsData([15,29,29,13,05,05,05]);
    183      : AddRowsData([00,00,00,04,00,00,00]);
    184      : AddRowsData([00,00,00,00,04,02,12]);
    185      : AddRowsData([04,12,04,04,04,00,00]);
    186      : AddRowsData([14,10,14,00,14,00,00]);
    187      : AddRowsData([00,00,18,09,18,00,00]);
    188      : AddRowsData([09,10,04,11,21,07,01]);
    189      : AddRowsData([17,18,04,14,17,02,07]);
    190      : AddRowsData([24,09,26,05,11,23,01]);
    191      : AddRowsData([04,00,04,08,16,17,14]);
    192      : AddRowsData([08,04,14,17,31,17,17]);
    193      : AddRowsData([02,04,14,17,31,17,17]);
    194      : AddRowsData([04,10,14,17,31,17,17]);
    195      : AddRowsData([13,18,14,17,31,17,17]);
    196      : AddRowsData([10,00,14,17,31,17,17]);
    197      : AddRowsData([04,00,14,17,31,17,17]);
    198      : AddRowsData([11,20,20,22,28,20,23]);
    199      : AddRowsData([15,16,16,16,15,02,14]);
    200      : AddRowsData([08,04,31,16,30,16,31]);
    201      : AddRowsData([02,04,31,16,30,16,31]);
    202      : AddRowsData([04,10,31,16,30,16,31]);
    203      : AddRowsData([10,00,31,16,30,16,31]);
    204      : AddRowsData([08,04,14,04,04,04,14]);
    205      : AddRowsData([02,04,14,04,04,04,14]);
    206      : AddRowsData([04,10,14,04,04,04,14]);
    207      : AddRowsData([10,00,14,04,04,04,14]);
    208      : AddRowsData([14,09,09,29,09,09,14]);
    209      : AddRowsData([13,18,17,25,21,19,17]);
    210      : AddRowsData([08,04,14,17,17,17,14]);
    211      : AddRowsData([02,04,14,17,17,17,14]);
    212      : AddRowsData([04,10,14,17,17,17,14]);
    213      : AddRowsData([13,22,14,17,17,17,14]);
    214      : AddRowsData([10,00,14,17,17,17,14]);
    215      : AddRowsData([00,00,00,10,04,10,00]);
    216      : AddRowsData([01,14,19,21,25,14,16]);
    217      : AddRowsData([08,04,17,17,17,17,14]);
    218      : AddRowsData([02,04,17,17,17,17,14]);
    219      : AddRowsData([04,10,17,17,17,17,14]);
    220      : AddRowsData([10,00,17,17,17,17,14]);
    221      : AddRowsData([02,04,17,17,10,04,04]);
    222      : AddRowsData([28,08,14,09,14,08,28]);
    223      : AddRowsData([14,17,30,18,17,25,22]);
    224      : AddRowsData([08,04,14,01,15,17,15]);
    225      : AddRowsData([02,04,14,01,15,17,15]);
    226      : AddRowsData([04,10,14,01,15,17,15]);
    227      : AddRowsData([13,18,14,01,15,17,15]);
    228      : AddRowsData([10,00,14,01,15,17,15]);
    229      : AddRowsData([04,00,14,01,15,17,15]);
    230      : AddRowsData([00,00,26,05,15,20,15]);
    231      : AddRowsData([00,15,16,16,15,02,14]);
    232      : AddRowsData([08,04,14,17,31,16,15]);
    233      : AddRowsData([02,04,14,17,31,16,15]);
    234      : AddRowsData([04,10,14,17,31,16,15]);
    235      : AddRowsData([10,00,14,17,31,16,15]);
    236      : AddRowsData([08,04,00,04,04,04,04]);
    237      : AddRowsData([02,04,00,04,04,04,04]);
    238      : AddRowsData([04,10,00,04,04,04,04]);
    239      : AddRowsData([00,10,00,04,04,04,04]);
    240      : AddRowsData([19,12,18,14,17,17,14]);
    241      : AddRowsData([13,18,00,22,25,17,17]);
    242      : AddRowsData([08,04,00,14,17,17,14]);
    243      : AddRowsData([02,04,00,14,17,17,14]);
    244      : AddRowsData([04,10,00,14,17,17,14]);
    245      : AddRowsData([13,22,00,14,17,17,14]);
    246      : AddRowsData([10,00,00,14,17,17,14]);
    247      : AddRowsData([00,04,00,31,00,04,00]);
    248      : AddRowsData([01,14,17,17,17,14,16]);
    249      : AddRowsData([08,04,00,17,17,19,13]);
    250      : AddRowsData([02,04,00,17,17,19,13]);
    251      : AddRowsData([04,10,00,17,17,19,13]);
    252      : AddRowsData([10,00,00,17,17,19,13]);
    253      : AddRowsData([02,04,17,17,15,01,06]);
    254      : AddRowsData([16,28,18,18,28,16,16]);
    255      : AddRowsData([10,00,17,17,15,01,14]);
    end;                                         
end;
//****************************************************************************************************************************************************
procedure TiLCDCharacter.Assign(Source: TPersistent);
var
  x : Integer;
begin
  if Source is TiLCDCharacter then
    begin
      RowCount := (Source as TiLCDCharacter).RowCount;
      for x := 0 to RowCount-1 do
      SetRowData(x, (Source as TiLCDCharacter).GetRowData(x));
    end
  else inherited;
end;
//****************************************************************************************************************************************************
end.
