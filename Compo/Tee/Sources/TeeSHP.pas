{**********************************************}
{   TeeMaps                                    }
{   Copyright (c) 2003-2009 by David Berneda   }
{**********************************************}
unit TeeSHP;
{$I TeeDefs.inc}

interface

uses
  TeeMapSeries, TeCanvas, Classes, DB;

type
  TSHPHeader=packed record
    FileCode : Integer;
    Unused1  : Integer;
    Unused2  : Integer;
    Unused3  : Integer;
    Unused4  : Integer;
    Unused5  : Integer;
    FileLength : Integer;
    Version    : Integer;  // 1000
    ShapeType  : Integer;
    XMin       : Double;
    YMin       : Double;
    XMax       : Double;
    YMax       : Double;
    ZMin       : Double;
    ZMax       : Double;
    MMin       : Double;  // Measured
    MMax       : Double;
  end;

  TSHPRecordHeader=packed record
    RecordNumber : Integer;
    RecordLength : Integer;
  end;

const
  SHP_NULL       = 0;
  SHP_POINT      = 1;
  SHP_POLYLINE   = 3;
  SHP_POLYGON    = 5;
  SHP_MULTIPOINT = 8;
  SHP_POINTZ     = 11;
  SHP_POLYLINEZ  = 13;
  SHP_POLYGONZ   = 15;
  SHP_MULTIPOINTZ = 18;
  SHP_POINTM     = 21;
  SHP_POLYLINEM  = 23;
  SHP_POLYGONM   = 25;
  SHP_MULTIPOINTM = 28;
  SHP_MULTIPATCH = 31;

procedure LoadMap( Series:TMapSeries; const FileName:String;
                   Table:TDataSet=nil; const FieldName:String='';
                   const FieldValue:String='';
                   ClearSeries:Boolean=True); overload;

procedure LoadMap( Series:TMapSeries; ShpStream,ShxStream:TStream;
                   Table:TDataSet=nil; const FieldName:String='';
                   const FieldValue:String='';
                   ClearSeries:Boolean=True); overload;

Const TeeSHPMaxRandom=1000000;

implementation

uses 
  {$IFDEF CLR}
  Variants,
  System.IO,
  {$ENDIF}

  SysUtils;

type
  {$IFDEF CLR}
  IntegerBytes=Array[0..3] of Byte;
  {$ELSE}
  TIntegerBytes=Array[0..3] of Byte;
  {$ENDIF}

{$IFDEF CLR}
function TIntegerBytes(Value:Integer):IntegerBytes;
begin
  result[0]:=Byte(Value);
  result[1]:=Byte(Value shr 8);
  result[2]:=Byte(Value shr 16);
  result[3]:=Byte(Value shr 24);
(*
  result[0]:=Value mod 255;
  result[1]:=(Value div 256) mod 255;
  result[2]:=(Value div 65536) mod 255;
  result[3]:=(Value div (256*65536)) mod 255;
  *)
end;

procedure ReadSHPHeader(f:TStream; var Header:TSHPHeader);
begin
  with Header do
  begin
    f.ReadBuffer(FileCode);
    f.ReadBuffer(Unused1);
    f.ReadBuffer(Unused2);
    f.ReadBuffer(Unused3);
    f.ReadBuffer(Unused4);
    f.ReadBuffer(Unused5);
    f.ReadBuffer(FileLength);
    f.ReadBuffer(Version);  // 1000
    f.ReadBuffer(ShapeType);
    f.ReadBuffer(XMin);
    f.ReadBuffer(YMin);
    f.ReadBuffer(XMax);
    f.ReadBuffer(YMax);
    f.ReadBuffer(ZMin);
    f.ReadBuffer(ZMax);
    f.ReadBuffer(MMin);  // Measured
    f.ReadBuffer(MMax);
  end;
end;
{$ENDIF}

procedure LoadMap( Series:TMapSeries; ShpStream,ShxStream:TStream;
                   Table:TDataSet=nil; const FieldName:String='';
                   const FieldValue:String='';
                   ClearSeries:Boolean=True); overload;

  Function BytesToStr(Value:Integer):String;
  var B : {$IFNDEF CLR}TIntegerBytes{$ELSE}IntegerBytes{$ENDIF};
  begin
    B:=TIntegerBytes(Value);
    result:=IntToStr(B[0])+' '+IntToStr(B[1])+' '+IntToStr(B[2])+' '+IntToStr(B[3]);
  end;

  procedure VerifySignature(Value:Integer);
  var B : {$IFNDEF CLR}TIntegerBytes{$ELSE}IntegerBytes{$ENDIF};
  begin
    B:=TIntegerBytes(Value);
    if (B[0]<>0) or (B[1]<>0) or (B[2]<>$27) or
       ( (B[3]<>$0A) and (B[3]<>$0D) ) then
          raise Exception.Create('Invalid shape file signature.');
  end;

  Function ShowHeader(const SHPHeader:TSHPHeader):Integer;
  var B : {$IFNDEF CLR}TIntegerBytes{$ELSE}IntegerBytes{$ENDIF};
  begin
    B:=TIntegerBytes(SHPHeader.FileLength);
    result:=B[3] + (B[2] * 256) + (B[1]*256*256) + (B[0]* 256 * 256 * 256);
    result:=(result*2 - 100) div 8;
  end;

  Function Reverse(Value:Integer):Integer;
  var B : {$IFNDEF CLR}TIntegerBytes{$ELSE}IntegerBytes{$ENDIF};
  begin
    B:=TIntegerBytes(Value);
    result:=(B[0]*256*256*256)+(B[1]*256*256)+(B[2]*256)+B[3];
  end;

  procedure ReadRecordHeader(s:TStream; var Header:TSHPRecordHeader);
  begin
    {$IFDEF CLR}
    s.ReadBuffer(Header.RecordNumber);
    s.ReadBuffer(Header.RecordLength);
    {$ELSE}
    s.ReadBuffer(Header,SizeOf(TSHPRecordHeader));
    {$ENDIF}
    Header.RecordNumber:=Reverse(Header.RecordNumber);
    Header.RecordLength:=Reverse(Header.RecordLength);
  end;

var
  ShapeType : Integer;
  tmpPoints : Array of TFloatPoint;
  tmpNameField : TField;
  tmpValueField : TField;

  procedure LoadShape;
  var tmpShape : TTeePolygon;
      po       : Integer;

    procedure ReadPoints(UpTo:Integer);
    var {$IFDEF CLR}
        tmpPoint : TFloatPoint;
        {$ELSE}
        t         : Integer;
        {$ENDIF}
    begin
      tmpShape.Points.BeginUpdate;
      try
        {$IFNDEF CLR}

        SetLength(tmpPoints,UpTo-po);
        ShpStream.Read(tmpPoints[0],(UpTo-po)*SizeOf(TFloatPoint));
        for t:=0 to UpTo-po-1 do
            tmpShape.Points.AddXY(tmpPoints[t].X,tmpPoints[t].Y);
        po:=UpTo;

        {$ELSE}

        repeat
           ShpStream.Read(tmpPoint.X);
           ShpStream.Read(tmpPoint.Y);
           tmpShape.AddXY(tmpPoint);
           Inc(po);
        until po=UpTo;

        {$ENDIF}
      finally
        tmpShape.Points.EndUpdate;
      end;
    end;

    procedure GetTableFields(var Text:String; var Z:Double);
    begin
      if Assigned(tmpNameField) then
         Text:=tmpNameField.AsString
      else
         Text:='';

      if Assigned(tmpValueField) then
         Z:=tmpValueField.AsFloat
      else
         Z:=Random(TeeSHPMaxRandom);

      if Assigned(Table) and Table.Active then
         Table.Next;
    end;

  const
       MaxNumParts = 10000;

  var Box : Array[0..3] of Double;
      NumParts,
      NumPoints: Integer;
      Parts : Array[0..MaxNumParts-1] of Integer;
      p : Integer;
      tmpIndex : Integer;
      tmpText:String;
      tmpZ : Double;
  begin
    case ShapeType of
      SHP_POINT:
         begin
           GetTableFields(tmpText,tmpZ);

           tmpShape:=Series.Shapes.Add;
           tmpShape.Closed:=True;

           tmpIndex:=Series.Count-1;
           Series.ZValues.Value[tmpIndex]:=tmpZ;
           Series.Labels[tmpIndex]:=tmpText;

           po:=0;
           ReadPoints(1);
         end;

      SHP_POLYLINE,
      SHP_POLYGON:
       begin
         {$IFDEF CLR}
         ShpStream.ReadBuffer(Box[0]);
         ShpStream.ReadBuffer(Box[1]);
         ShpStream.ReadBuffer(Box[2]);
         ShpStream.ReadBuffer(Box[3]);
         ShpStream.ReadBuffer(NumParts);
         ShpStream.ReadBuffer(NumPoints);
         {$ELSE}
         ShpStream.ReadBuffer(Box,SizeOf(Box));
         ShpStream.ReadBuffer(NumParts,SizeOf(NumParts));
         ShpStream.ReadBuffer(NumPoints,SizeOf(NumPoints));
         {$ENDIF}

         if NumParts>MaxNumParts then
            raise Exception.Create('Maximum number of parts exceeded: '+IntToStr(NumParts));

         {$IFDEF CLR}
         for p:=0 to NumParts-1 do
             ShpStream.ReadBuffer(Parts[p]);
         {$ELSE}
         ShpStream.ReadBuffer(Parts,SizeOf(Integer)*NumParts);
         {$ENDIF}

         GetTableFields(tmpText,tmpZ);

         po:=0;

         for p:=1 to NumParts do
         begin
           tmpShape:=Series.Shapes.Add;
           tmpShape.Closed:=ShapeType=SHP_POLYGON;

           tmpIndex:=Series.Count-1;
           Series.ZValues.Value[tmpIndex]:=tmpZ;
           Series.Labels[tmpIndex]:=tmpText;

           if p=NumParts then
              ReadPoints(NumPoints)
           else
              ReadPoints(Parts[p]);
         end;
       end;
    else
        raise Exception.Create('Invalid ShapeType '+IntToStr(ShapeType));
    end;
  end;

var SHPHeader : TSHPHeader;
    SHPRecordHeader : TSHPRecordHeader;
    t, NumRecords : Integer;
    Old : Boolean;
begin
  ShpStream.Position:=0;
  {$IFDEF CLR}
  ReadSHPHeader(ShpStream,SHPHeader);
  {$ELSE}
  ShpStream.ReadBuffer(SHPHeader,SizeOf(TSHPHeader));
  {$ENDIF}

  VerifySignature(SHPHeader.FileCode);

  ShowHeader(SHPHeader);

  {$IFDEF CLR}
  ReadSHPHeader(ShxStream,SHPHeader);
  {$ELSE}
  ShxStream.ReadBuffer(SHPHeader,SizeOf(TSHPHeader));
  {$ENDIF}

  VerifySignature(SHPHeader.FileCode);

  NumRecords:=ShowHeader(SHPHeader);

  if ClearSeries then
     Series.Clear;

  Series.BeginUpdate;

  if Assigned(Series.ParentChart) then
  begin
    Old:=Series.ParentChart.AutoRepaint;
    Series.ParentChart.AutoRepaint:=False;
  end
  else
    Old:=True;

  tmpNameField:=nil;
  tmpValueField:=nil;

  if Assigned(Table) and Table.Active then
  begin
    if FieldName<>'' then
       tmpNameField:=Table.FieldByName(FieldName);

    if FieldValue<>'' then
       tmpValueField:=Table.FieldByName(FieldValue);
  end;

  for t:=1 to NumRecords do
  begin
    ReadRecordHeader(ShxStream,SHPRecordHeader);

    ShpStream.Position:=2*SHPRecordHeader.RecordNumber;
    ReadRecordHeader(ShpStream,SHPRecordHeader);

    {$IFDEF CLR}
    ShpStream.Read(ShapeType);
    {$ELSE}
    ShpStream.Read(ShapeType,SizeOf(ShapeType));
    {$ENDIF}

    try
      LoadShape;
    finally
      tmpPoints:=nil;
    end;
  end;

  Series.EndUpdate;

  if Assigned(Series.ParentChart) then
     Series.ParentChart.AutoRepaint:=Old;
end;

procedure LoadMap(Series:TMapSeries; const FileName:String;
                  Table:TDataSet=nil; const FieldName:String='';
                  const FieldValue:String='';
                  ClearSeries:Boolean=True);
var fx: TFileStream;
    f : TFileStream;
    tmpName : String;
begin
  tmpName:=FileName;
  if ExtractFileExt(tmpName)='' then
     tmpName:=tmpName+'.shp';

  f:=TFileStream.Create(tmpName,fmOpenRead);
  try
    tmpName:=ChangeFileExt(FileName,'.shx');

    fx:=TFileStream.Create(tmpName,fmOpenRead);
    try
      LoadMap(Series,f,fx,Table,FieldName,FieldValue,ClearSeries);
    finally
      fx.Free;
    end;
  finally
    f.Free;
  end;
end;

end.
