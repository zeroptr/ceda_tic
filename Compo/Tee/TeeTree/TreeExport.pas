unit TreeExport;

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  {$ENDIF}
  TeeExport, TeeTree, TeCanvas, TeeProcs, Buttons;

type
  TTreeExportForm = class(TTeeExportFormBase)
    CBFullSize: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CBFullSizeClick(Sender: TObject);
  private
    { Private declarations }
  protected
    Function CreateData:TTeeExportData; override;
    Function CreateNativeStream:TStream; override;
    Function ExistData:Boolean; override;
  public
    { Public declarations }
  end;

   TTreeData=class(TTeeExportData)
   private
     FTree : TCustomTree;
   protected
     Procedure WriteNode(ANode:TTreeNodeShape; AStream:TStream); virtual; abstract;
     Procedure WriteText(AStr:String; AStream:TStream);

     Function GetHeader: String; virtual;
     Function GetFooter: String; virtual;
   public
     Constructor Create(ATree:TCustomTree); virtual;

     Procedure SaveToStream(AStream:TStream); override;
     Function AsString:String; override;
     property Tree:TCustomTree read FTree write FTree;
   end;

   TTreeDataText=class(TTreeData)
   private
     FTextDelimiter : {$IFDEF CLX}WideChar{$ELSE}Char{$ENDIF};
   protected
     Procedure WriteNode(ANode:TTreeNodeShape; AStream:TStream); override;
   public
     Constructor Create(ATree:TCustomTree); override;

     property TextDelimiter:{$IFDEF CLX}WideChar{$ELSE}Char{$ENDIF}
            read FTextDelimiter write FTextDelimiter default TeeTabDelimiter;
   end;

   TTreeDataXML=class(TTreeData)
   private
    FCompact: Boolean;
   protected
     Procedure WriteNode(ANode:TTreeNodeShape; AStream:TStream); override;
     Function GetHeader: String; override;
     Function GetFooter: String; override;
   public
     Constructor Create(ATree:TCustomTree); override;

     property Compact: Boolean read FCompact write FCompact default false;
   end;

   TTreeDataHTML=class(TTreeData)
   protected
     Procedure WriteNode(ANode:TTreeNodeShape; AStream:TStream); override;
     Function GetHeader: String; override;
     Function GetFooter: String; override;
   public
     {$IFDEF CLR}
     Constructor Create(ATree:TCustomTree); override;
     {$ENDIF}
   end;

   {$IFNDEF CLR}
   TTreeDataXLS=class(TTreeData)
   private
     Buf : Array[0..4] of Word;
     Row : Integer;
     Col : Integer;
   protected
     Procedure WriteNode(ANode:TTreeNodeShape; AStream:TStream); override;
   public
     {$IFDEF CLR}
     Constructor Create(ATree:TCustomTree); override;
     {$ENDIF}

     Procedure SaveToStream(AStream:TStream); override;
   end;
   {$ENDIF}

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Const TeeTextLineSeparator= #13#10;

Function TTreeExportForm.CreateData:TTeeExportData;

  function Tree: TCustomTree;
  begin
    result:=TCustomTree(ExportPanel);
  end;

begin
  Case RGText.ItemIndex of
    0: begin
         result:=TTreeDataText.Create(Tree);
         TTreeDataText(result).TextDelimiter:=GetSeparator;
       end;
    1: result:=TTreeDataXML.Create(Tree);
    2: result:=TTreeDataHTML.Create(Tree);
  {$IFNDEF CLR}
  else
    result:=TTreeDataXLS.Create(Tree);
  {$ENDIF}
  end;
end;

function TTreeExportForm.ExistData: Boolean;
begin
  result:=(ExportPanel is TCustomTree) and
          (TCustomTree(ExportPanel).Shapes.Count>0);
end;

procedure TTreeExportForm.FormShow(Sender: TObject);
begin
  inherited;
  TabData.TabVisible:=True;
  CBFullSizeClick(Sender);
end;

{ TTreeData }

function TTreeData.AsString: String;
var
  StrStream : TStringStream;

begin
  result:='';
  StrStream := TStringStream.Create('');
  try
    SaveToStream(StrStream);
    result := StrStream.DataString;
  finally
    FreeAndNil(StrStream);
  end;
end;

constructor TTreeData.Create(ATree: TCustomTree);
begin
  {$IFDEF CLR}
  inherited Create;
  {$ENDIF}
  FTree:=ATree;
end;

Function TTreeData.GetHeader: String;
begin
  result:='';
end;

Function TTreeData.GetFooter: String;
begin
  result:='';
end;

Procedure TTreeData.SaveToStream(AStream:TStream);
var t: integer;

begin
  WriteText(GetHeader, AStream);
  for t:=0 to Tree.Roots.Count-1 do
  begin
    WriteNode(Tree.Roots[t], AStream);
  end;
  WriteText(GetFooter, AStream);
end;

procedure TTreeData.WriteText(AStr: String; AStream:TStream);
{$IFDEF CLR}
var
  Bytes : TBytes;
{$ENDIF}
begin
  {$IFDEF CLR}
   Bytes := BytesOf(AStr);
   AStream.Write(Bytes, Length(Bytes));
  {$ELSE}
   AStream.Write(Pointer(AStr)^,Length(AStr)*SizeOf(char));
  {$ENDIF}
end;

{ TTreeDataText }

constructor TTreeDataText.Create(ATree: TCustomTree);
begin
  inherited;
  FTextDelimiter:=TeeTabDelimiter;
end;

procedure TTreeDataText.WriteNode(ANode: TTreeNodeShape; AStream: TStream);
var
  t: integer;
  tmpText: String;
begin
  if (ANode <> ANode.Tree.Roots[0]) then
    WriteText(TeeTextLineSeparator, AStream);
  tmpText:='';
  for t:=1 to ANode.Level do
    tmpText:=tmpText+FTextDelimiter;
  tmpText:=tmpText+ANode.SimpleText;
  for t:=1 to ANode.Text.Count-1 do
    tmpText:=tmpText+' '+ANode.Text[t];

  WriteText(tmpText, AStream);

  for t:=0 to ANode.Children.Count-1 do
  begin
    WriteNode(ANode.Children[t], AStream);
  end;
end;

{ TTreeDataXML }

Constructor TTreeDataXML.Create(ATree:TCustomTree);
begin
  inherited Create(ATree);
  FCompact := False;
end;

Function TTreeDataXML.GetHeader: String;
begin
  result:='<?xml version="1.0"';
  if SizeOf(Char)=2 then
    result := result + ' encoding="UTF-16"';
  result := result + '?>';
  if not FCompact then result := result+TeeTextLineSeparator;
  result:=result+'<tree>';
  if not FCompact then result := result+TeeTextLineSeparator;
end;

Function TTreeDataXML.GetFooter: String;
begin
  result:='</tree>';
end;

procedure TTreeDataXML.WriteNode(ANode: TTreeNodeShape; AStream:TStream);
var
  t : Integer;
  tmpTab: String;
begin
  if not FCompact then
  begin
    tmpTab := '';
    for t:=1 to ANode.Level do
      tmpTab:=tmpTab+TeeTabDelimiter;
    WriteText(tmpTab, AStream);
  end;
  WriteText(
    '<node name="'+ANode.Name+'" class="'+ ANode.ClassName+'">'+Trim(ANode.Text.Text)
    , AStream
  );
  if ANode.HasChildren then
  begin
     if not FCompact then
       WriteText(TeeTextLineSeparator, AStream);
     for t:=0 to ANode.Children.Count-1 do
       WriteNode(ANode.Children[t], AStream);
    if not FCompact then
       WriteText(tmpTab, AStream);
  end;
  WriteText('</node>', AStream);
  if not FCompact then WriteText(TeeTextLineSeparator, AStream);
end;

{ TTreeDataHTML }

{$IFDEF CLR}
Constructor TTreeDataHTML.Create(ATree:TCustomTree);
begin
  inherited Create(ATree);
end;
{$ENDIF}

Function TTreeDataHTML.GetHeader: String;
begin
  result:='<table border="1">'+TeeTextLineSeparator;
end;

Function TTreeDataHTML.GetFooter: String;
begin
  result := TeeTextLineSeparator+'</table>';
end;

procedure TTreeDataHTML.WriteNode(ANode: TTreeNodeShape; AStream: TStream);
var
  t : Integer;
  tmpText: String;
begin
  if (ANode <> ANode.Tree.Roots[0]) then
    WriteText(TeeTextLineSeparator, AStream);
  tmpText:='<tr>';
  for t:=1 to ANode.Level do
    tmpText:=tmpText+'<td></td>';
  tmpText:=tmpText+'<td>'+ANode.SimpleText;
  for t:=1 to ANode.Text.Count-1 do
    tmpText:=tmpText+' '+ANode.Text[t];
  tmpText:=tmpText+'</td></tr>';

  WriteText(tmpText, AStream);

  for t:=0 to ANode.Children.Count-1 do
  begin
    WriteNode(ANode.Children[t], AStream);
  end;
end;

{ TTreeDataXLS }
{$IFNDEF CLR}

{$IFDEF CLR}
Constructor TTreeDataXLS.Create(ATree:TCustomTree);
begin
  inherited Create(ATree);
end;
{$ENDIF}

procedure TTreeDataXLS.WriteNode(ANode:TTreeNodeShape; AStream:TStream);
Const Attr:Array[0..2] of Byte=(0,0,0);

  Procedure WriteBuf(Value,Size:Word);
  begin
    Buf[0]:=Value;
    Buf[1]:=Size;
    AStream.Write(Buf,2*SizeOf(Word));
  end;

  Procedure WriteParams(Value,Size:Word);
  begin
    WriteBuf(Value,Size+2*SizeOf(Word)+SizeOf(Attr));
    WriteBuf(Row,Col);
    AStream.Write(Attr,SizeOf(Attr));
  end;

  procedure WriteDouble(Const Value:Double);
  begin
    WriteParams(3,SizeOf(Double));
    AStream.WriteBuffer(Value,SizeOf(Double));
  end;

  procedure WriteText(Const Value:ShortString);
  begin
    WriteParams(4,Length(Value)+1);
    AStream.Write(Value,Length(Value)+1)
  end;

  procedure WriteNull;
  begin
    WriteParams(1,0);
  end;

var t : Integer;
    s : String;
begin
  for t:=0 to ANode.Level-1 do
  begin
    Col:=t;
    WriteNull;
  end;

  Col:=ANode.Level;

  s:=ANode.SimpleText;
  for t:=1 to ANode.Text.Count-1 do
      s:=s+' '+ANode.Text[t];

  WriteText(s);
  Inc(Row);

  for t:=0 to ANode.Children.Count-1 do
      WriteNode(ANode.Children[t],AStream);
end;

procedure TTreeDataXLS.SaveToStream(AStream: TStream);

  Function MaxLevel:Integer;
  var t   : Integer;
      tmp : Integer;
  begin
    result:=0;
    for t:=0 to Tree.Shapes.Count-1 do
    begin
      tmp:=Tree.Shapes[t].Level;
      if tmp>result then result:=tmp;
    end;
  end;

  Procedure WriteBuf(Value,Size:Word);
  begin
    Buf[0]:=Value;
    Buf[1]:=Size;
    AStream.Write(Buf,2*SizeOf(Word));
  end;

const
  BeginExcel : Array[0..5] of Word=($809,8,0,$10,0,0);
  EndExcel   : Array[0..1] of Word=($A,0);

var t : Integer;
begin
  AStream.WriteBuffer(BeginExcel,SizeOf(BeginExcel)); { begin and BIF v5 }

  WriteBuf($0200,5*SizeOf(Word));  { row x col }

  Buf[0]:=0;
  Buf[2]:=0;
  Buf[3]:=MaxLevel+1; { columns }
  Buf[4]:=0;

  Buf[1]:=Tree.Shapes.Count; { rows }

  AStream.Write(Buf,5*SizeOf(Word));

  Row:=0;
  for t:=0 to Tree.Roots.Count-1 do
      WriteNode(Tree.Roots[t],AStream);

  AStream.WriteBuffer(EndExcel,SizeOf(EndExcel)); { end }
end;
{$ENDIF}

procedure TTreeExportForm.CBFullSizeClick(Sender: TObject);
begin
  if Assigned(ExportPanel) then
  begin
    UDHeight.Position:=ExportPanel.GetRectangle.Bottom;
    UDWidth.Position:=ExportPanel.GetRectangle.Right;
  end;

  UDHeight.Enabled := not CBFullSize.Checked; //tom:26/11/2002; Allow full size
  UDWidth.Enabled := not CBFullSize.Checked; //tom:26/11/2002; Allow full size
  EHeight.Enabled := not CBFullSize.Checked; //tom:26/11/2002; Allow full size
  EWidth.Enabled := not CBFullSize.Checked; //tom:26/11/2002; Allow full size
  inherited;
end;

Function TTreeExportForm.CreateNativeStream:TStream;
var tmp : TStream;
begin
  result:=inherited CreateNativeStream;

  if NativeAsText then
  begin
    tmp:=result;
    try
      tmp.Position:=0;
      result:=TMemoryStream.Create;
      ObjectBinaryToText(tmp,result);

      if CBNativeFormat.ItemIndex=2 then
      begin
        result.Position:=0;
        ConvertTextToXML(result);
      end;
    finally
      tmp.Free;
    end;
  end
end;

end.
