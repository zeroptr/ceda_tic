{******************************************}
{    TeeHouse 0.99                         }
{ Copyright (c) 2002-2003 by David Berneda }
{       All Rights Reserved                }
{******************************************}
unit UnitTeeHouse;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QCheckLst, QExtCtrls,
  QMenus, QButtons,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, CheckLst, ExtCtrls,
  Menus, Buttons,
  {$ENDIF}

  {$IFDEF CLR}
  Variants, Types,
  System.IO,  // <-- ExtractFileExt and ExtractFileName inline
  {$ELSE}
  {$IFDEF D10}
  Types,  // <-- TeePoint, TeeRect inline
  {$ENDIF}
  {$ENDIF}

  IniFiles, Math,

  TeeProcs, TeEngine, Chart, TeCanvas, TeePenDlg, TeeJPEG, TeeGIF, TeePNG,
  TeeComma, TeeOpenGL, TeeGLEditor, TeeAbout, TeeGLCanvas, TeeEdit, TeeEdiGrad,
  TeeEdiFont, TeeBrushDlg;

type
  TBlocks=class;

  TBlockShape=( bsCube, bsCylinder, bsSphere,
                bsTriangleRect, bsPyramid, bsArrow,
                bsEllipse, bsText, bsImage );

  TBlock=class(TCollectionItem)
  private
    FGroup: Integer;
    FLayer: Integer;
    FTexture: Integer;
    FShape: TBlockShape;
    FTransparency: TTeeTransparency;
    FTileX: Integer;
    FTileY: Integer;
    FTileZ: Integer;

    FLinkItems : TBlocks;

    function GetBlocks: TBlocks;
    procedure SetGroup(const Value: Integer);
    procedure SetLayer(const Value: Integer);
    procedure SetTexture(const Value: Integer);
    procedure SetShape(const Value: TBlockShape);
    procedure SetTransparency(const Value: TTeeTransparency);
    procedure SetTileX(const Value: Integer);
    procedure SetTileY(const Value: Integer);
    procedure SetTileZ(const Value: Integer);
    procedure SetLink(const Value: String);
    procedure SetFont(const Value: TTeeFont);
    function GetFont: TTeeFont;
    function GetPicture: TPicture;
    procedure SetPicture(const Value: TPicture);
  private
    FDark: Boolean;
    FX: Integer;
    FY: Integer;
    FZ: Integer;
    FHeight: Integer;
    FElevation: Integer;
    FWidth: Integer;
    FTilt: Integer;
    FRotation: Integer;
    FDepth: Integer;
    FBorder: TChartPen;
    FColor: TColor;
    FVisible: Boolean;

    FLink,
    FTitle: String;

    FPicture: TPicture;
    FFont: TTeeFont;

    procedure CanvasChanged(Sender:TObject);
    Function InGroup:Boolean;
    Function InLayer:Boolean;
    procedure SetBorder(const Value: TChartPen);
    procedure SetColor(const Value: TColor);
    procedure SetDark(const Value: Boolean);
    procedure SetDepth(const Value: Integer);
    procedure SetElevation(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure SetRotation(const Value: Integer);
    procedure SetTilt(const Value: Integer);
    procedure SetTitle(const Value: String);
    procedure SetWidth(const Value: Integer);
    procedure SetX(const Value: Integer);
    procedure SetY(const Value: Integer);
    procedure SetZ(const Value: Integer);
    procedure SetVisible(const Value: Boolean);

    property Blocks:TBlocks read GetBlocks;
  public
    constructor Create(Collection: TCollection); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    procedure Draw(Canvas:TCanvas3D);
    procedure Repaint;
  published
    property Border:TChartPen read FBorder write SetBorder;
    property Color:TColor read FColor write SetColor default clWhite;
    property DarkSides:Boolean read FDark write SetDark default True;
    property Elevation:Integer read FElevation write SetElevation default 0;
    property Rotation:Integer read FRotation write SetRotation default 0;
    property Tilt:Integer read FTilt write SetTilt default 0;
    property X:Integer read FX write SetX default 0;
    property Y:Integer read FY write SetY default 0;
    property Z:Integer read FZ write SetZ default 0;
    property Width:Integer read FWidth write SetWidth default 0;
    property Height:Integer read FHeight write SetHeight default 0;
    property Depth:Integer read FDepth write SetDepth default 0;
    property Visible:Boolean read FVisible write SetVisible default True;
    property Title:String read FTitle write SetTitle;
    property Group:Integer read FGroup write SetGroup default 0;
    property Layer:Integer read FLayer write SetLayer default 0;
    property Texture:Integer read FTexture write SetTexture default 0;
    property TileX:Integer read FTileX write SetTileX default 1;
    property TileY:Integer read FTileY write SetTileY default 1;
    property TileZ:Integer read FTileZ write SetTileZ default 1;
    property Shape:TBlockShape read FShape write SetShape default bsCube;
    property Transparency:TTeeTransparency read FTransparency write SetTransparency default 0;
    property LinkFile:String read FLink write SetLink;
    property Font:TTeeFont read GetFont write SetFont;
    property Picture:TPicture read GetPicture write SetPicture;
  end;

  TBlockGroups=class(TStringList)
  public
    NotShowAll : Boolean;
  end;

  TBlocks=class(TCollection)
  private
    FLayers: TBlockGroups;
    FGroups: TBlockGroups;

    FCurrentDir : String;
    FDrawBlocks : TBlocks;

    Function Get(Index:Integer):TBlock;
    procedure SetGroups(const Value: TBlockGroups);
    procedure SetLayers(const Value: TBlockGroups);
  public
    TeePanel : TCustomTeePanel;
    Offset   : TPoint3D;
    Rotation : TPoint3D;
    GroupsList : TCheckListBox;
    LayersList : TCheckListBox;
    Textures   : Array of TBitmap;
    ShowBorders,
    ShowTextures : Boolean;

    procedure BoundingBox(var Min,Max:TPoint3D);
    function Center:TPoint3DFloat;
    procedure Draw(ACanvas: TCanvas3D);
    Procedure LoadFromFile(const FileName:String);
    Procedure SaveToFile(const FileName:String);
    Procedure SaveToStream(Stream:TStream; Sign:Boolean=False);

    property Item[Index:Integer]:TBlock read Get; default;

  //published
    property Groups:TBlockGroups read FGroups write SetGroups;
    property Layers:TBlockGroups read FLayers write SetLayers;
  end;

  TForm1 = class(TForm)
    TeeCommander1: TTeeCommander;
    Chart1: TChart;
    SaveDialog1: TSaveDialog;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Groups: TCheckListBox;
    Panel1: TPanel;
    CheckListBox1: TCheckListBox;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label4: TLabel;
    BlockBorder: TButtonPen;
    BlockColor: TButtonColor;
    BlockTitle: TEdit;
    TabSheet2: TTabSheet;
    LRotation: TLabel;
    LElevation: TLabel;
    LTilt: TLabel;
    BlockRotation: TScrollBar;
    BlockElevation: TScrollBar;
    BlockTilt: TScrollBar;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    BlockX: TUpDown;
    Edit2: TEdit;
    BlockY: TUpDown;
    Edit3: TEdit;
    BlockZ: TUpDown;
    Edit4: TEdit;
    BlockWidth: TUpDown;
    Edit5: TEdit;
    BlockHeight: TUpDown;
    Edit6: TEdit;
    BlockDepth: TUpDown;
    Panel3: TPanel;
    BAdd: TButton;
    BDelete: TButton;
    BDupli: TButton;
    Layers: TCheckListBox;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    Orderbyname1: TMenuItem;
    NoOrder1: TMenuItem;
    TabSheet6: TTabSheet;
    Splitter2: TSplitter;
    BlockID: TLabel;
    TabSheet7: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    BlockTexture: TComboBox;
    Label7: TLabel;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    Label8: TLabel;
    BlockShape: TComboBox;
    ScrollBar3: TScrollBar;
    GroupNames: TMemo;
    LayerNames: TMemo;
    BlockGroup: TComboBox;
    BlockLayer: TComboBox;
    Label9: TLabel;
    CBFilter: TComboBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit7: TMenuItem;
    View1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Saveas1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Resetview1: TMenuItem;
    N2: TMenuItem;
    Borders1: TMenuItem;
    extures1: TMenuItem;
    Lightfocus1: TMenuItem;
    N3: TMenuItem;
    Smooth1: TMenuItem;
    CBSpinBy: TCheckBox;
    PopupMenu2: TPopupMenu;
    UnCheckAll1: TMenuItem;
    CheckAll1: TMenuItem;
    PopupMenu3: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    N4: TMenuItem;
    View3DAxes: TMenuItem;
    Panel4: TPanel;
    ScrollBar4: TScrollBar;
    SpeedButton1: TSpeedButton;
    StatusBar1: TStatusBar;
    ChartPreviewer1: TChartPreviewer;
    BlockTransp: TScrollBar;
    Label10: TLabel;
    N5: TMenuItem;
    Movetobottom1: TMenuItem;
    Movetotop1: TMenuItem;
    N6: TMenuItem;
    Duplicate1: TMenuItem;
    Moveup1: TMenuItem;
    Movedown1: TMenuItem;
    Insert1: TMenuItem;
    Delete1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Duplicate2: TMenuItem;
    ESpinBy: TEdit;
    UDSpinBy: TUpDown;
    N7: TMenuItem;
    Savetoexternal1: TMenuItem;
    Label13: TLabel;
    BlockLink: TLabel;
    Button1: TButton;
    BClearLink: TButton;
    Delete2: TMenuItem;
    Boundingbox1: TMenuItem;
    TabSheet8: TTabSheet;
    Label11: TLabel;
    BlockTileX: TScrollBar;
    Label12: TLabel;
    BlockTileY: TScrollBar;
    Label14: TLabel;
    BlockTileZ: TScrollBar;
    BFont: TButton;
    Locallight1: TMenuItem;
    AntiAlias1: TMenuItem;
    BImage: TButton;
    Label15: TLabel;
    procedure Chart1AfterDraw(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BAddClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure BlockRotationChange(Sender: TObject);
    procedure BlockElevationChange(Sender: TObject);
    procedure BlockTiltChange(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure CheckListBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BlockTitleChange(Sender: TObject);
    procedure BDupliClick(Sender: TObject);
    procedure GroupsClickCheck(Sender: TObject);
    procedure LayersClickCheck(Sender: TObject);
    procedure Orderbyname1Click(Sender: TObject);
    procedure NoOrder1Click(Sender: TObject);
    procedure BlockTextureChange(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure BlockShapeChange(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure BlockGroupChange(Sender: TObject);
    procedure BlockLayerChange(Sender: TObject);
    procedure CBFilterChange(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Resetview1Click(Sender: TObject);
    procedure Borders1Click(Sender: TObject);
    procedure extures1Click(Sender: TObject);
    procedure Lightfocus1Click(Sender: TObject);
    procedure Smooth1Click(Sender: TObject);
    procedure CBSpinByClick(Sender: TObject);
    procedure UnCheckAll1Click(Sender: TObject);
    procedure CheckAll1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure View3DAxesClick(Sender: TObject);
    procedure ScrollBar4Change(Sender: TObject);
    procedure BlockBorderClick(Sender: TObject);
    procedure BlockColorClick(Sender: TObject);
    procedure ChartPreviewer1Show(Sender: TObject);
    procedure BlockTranspChange(Sender: TObject);
    procedure Movetobottom1Click(Sender: TObject);
    procedure Movetotop1Click(Sender: TObject);
    procedure Duplicate1Click(Sender: TObject);
    procedure CheckListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure CheckListBox1EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure Moveup1Click(Sender: TObject);
    procedure Movedown1Click(Sender: TObject);
    procedure Insert1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure BlockTileXChange(Sender: TObject);
    procedure BlockTileYChange(Sender: TObject);
    procedure Duplicate2Click(Sender: TObject);
    procedure Savetoexternal1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BClearLinkClick(Sender: TObject);
    procedure Delete2Click(Sender: TObject);
    procedure Edit7Click(Sender: TObject);
    procedure UDSpinByClick(Sender: TObject; Button: TUDBtnType);
    procedure Boundingbox1Click(Sender: TObject);
    procedure BlockTileZChange(Sender: TObject);
    procedure BFontClick(Sender: TObject);
    procedure Locallight1Click(Sender: TObject);
    procedure AntiAlias1Click(Sender: TObject);
    procedure BImageClick(Sender: TObject);
    procedure PageControl2Resize(Sender: TObject);
  private
    { Private declarations }
    FileName : String;
    Blocks : TBlocks;
    TeeOpenGL1 : TTeeOpenGL;
    Dirty      : Boolean;
    Selected   : TBlocks;

    procedure AddBlock(ABlock:TBlock);
    procedure AddGroups;
    procedure AddLayers;
    function Block(Index: Integer):TBlock;
    procedure CheckAll(List:TCheckListBox; Value:Boolean=True);
    procedure CopySelectedBlocks(Collection:TBlocks);
    Function Current:TBlock;
    Procedure DoLoad(const AFile:String);
    Function DoSave:Boolean;
    Function DoSaveDialog:Boolean;
    procedure FillBlockList;
    procedure FinishAdd;
    procedure FinishLoad;
    procedure LoadTextures;
    procedure MarkDirty;
    procedure MoveBlock(Block:TBlock; Position:Integer);
    function NewBlocks:TBlocks;
    procedure SetMainCaption(Text:String);
    procedure TryLoadingNames(const APath:String);
    procedure UnmarkDirty;

    {$IFDEF D5}
    procedure CheckListBox1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    {$ENDIF}
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  {$IFDEF LINUX}
  OpenGLLinux
  {$ELSE}
  OpenGL2
  {$ENDIF}
  ;

const
  HousesPath = 'Houses';
  InitialFile = '\Office.hou';

procedure TBlocks.Draw(ACanvas: TCanvas3D);
var t,
    tmpX,
    tmpY,
    tmpZ,
    OldX,
    OldY,
    OldZ : Integer;
begin
  for t:=0 to Count-1 do
      with Item[t] do
      if Visible then
      if (TileX>1) or (TileY>1) or (TileZ>1) then
      begin
        OldX:=X;
        OldY:=Y;
        OldZ:=Z;

        for tmpZ:=1 to TileZ do
          for tmpX:=1 to TileX do
            for tmpY:=1 to TileY do
            begin
              X:=OldX+(tmpX-1)*Width;
              Y:=OldY+(tmpY-1)*Height;
              Z:=OldZ+(tmpZ-1)*Depth;
              Draw(ACanvas);
            end;

        X:=OldX;
        Y:=OldY;
        Z:=OldZ;
      end
      else
        Draw(ACanvas);
end;

procedure TForm1.Chart1AfterDraw(Sender: TObject);
var xx, yy, zz : Integer;
    Min, Max   : TPoint3D;
begin
  if View3DAxes.Checked then
  with Chart1.Canvas do
  begin
    Pen.Style:=psSolid;
    Pen.Color:=clNavy;

    with RotationCenter do
    begin
      xx:=Round(x)+Chart1.View3DOptions.HorizOffset;
      yy:=Round(y)+Chart1.View3DOptions.VertOffset;
      zz:=-Round(z);

      HorizLine3D(-1000+xx,1000+xx,yy,zz);
      VertLine3D(xx,-1000+yy,1000+yy,zz);
      MoveTo3D(xx,yy,-1000+zz);
      LineTo3D(xx,yy,1000+zz);
    end;
  end;

  if Boundingbox1.Checked then
  with Chart1.Canvas do
  begin
    Pen.Style:=psSolid;
    Pen.Color:=clRed;
    Brush.Style:=bsClear;
    Blocks.BoundingBox(Min,Max);

    with Blocks.Offset do
         Cube(Min.X+X,Max.X+X,-(Min.Z+Z),-(Max.Z+Z),Min.Y+Y,Max.Y+Y);
  end;

  Blocks.Draw(Chart1.Canvas);

  // Light (sun)
  if Lightfocus1.Checked then
  with Chart1.Canvas do
  begin
    Brush.Style:=bsSolid;
    Brush.Color:=clYellow;
    Pen.Style:=psSolid;

    with TeeOpenGL1.Light.Position do
         Sphere(Round(X),Round(Y),Round(Z),30);
  end;

end;

procedure TForm1.UnmarkDirty;
begin
  Dirty:=False;
  SpeedButton1.Visible:=False;
end;

{$IFNDEF CLR}
type
  TCommAccess=class(TTeeCommander);
{$ENDIF}

function WhereIsFile(const FileName:String):String;
begin
  if FileExists(FileName) then
     result:=FileName
  else
  if FileExists(HousesPath+'\'+FileName) then
     result:=HousesPath+'\'+FileName
  else
  if FileExists('..\'+HousesPath+'\'+FileName) then
     result:='..\'+HousesPath+'\'+FileName
  else
     result:='';
end;

procedure TForm1.LoadTextures;

  function GetBitmapResource(Const Name:String):TBitmap;
  var tmp : String;
  begin
    result:=TBitmap.Create;
    tmp:=WhereIsFile(Name+'.bmp');
    if tmp<>'' then
       result.LoadFromFile(tmp);
  end;

var s : TStringList;
    t,l : Integer;
begin
  s:=TStringList.Create;
  try
    s.LoadFromFile(WhereIsFile('Textures.txt'));

    for t:=0 to s.Count-1 do
    if (s[t]<>'') and (Copy(s[t],1,1)<>'#') then
    begin
      l:=Length(Blocks.Textures);
      SetLength(Blocks.Textures,l+1);
      Blocks.Textures[l]:=GetBitmapResource(s[t]);

      if BlockTexture.Items.IndexOf(s[t])=-1 then
         BlockTexture.Items.Add(s[t]);
    end;

  finally
    s.Free;
  end;
end;

function TForm1.NewBlocks:TBlocks;
begin
  result:=TBlocks.Create(TBlock);
  result.FDrawBlocks:=result;
end;

const
  ViewKey='View';

procedure TForm1.FormCreate(Sender: TObject);
var tmp : TFormTeeGLEditor;
{$IFDEF CLR}
    tmpPoint : TPoint3DFloat;
{$ENDIF}
begin
  Dirty:=True;

  TeeOpenGL1:=TTeeOpenGL.Create(Self);
  TeeOpenGL1.TeePanel:=Chart1;
  TeeOpenGL1.AntiAlias:=True;

  OpenDialog1.InitialDir:=GetCurrentDir;

  Blocks:=NewBlocks;
  Blocks.ShowBorders:=True;
  Blocks.ShowTextures:=True;
  Blocks.TeePanel:=Chart1;
  Blocks.FGroups:=TBlockGroups.Create;
  Blocks.FLayers:=TBlockGroups.Create;
  Blocks.GroupsList:=Groups;
  Blocks.LayersList:=Layers;

  LoadTextures;

  // trick
  Blocks.Offset.X:=-950+270;

  Resetview1Click(Self);

  TeeCommander1.ButtonRotate.Down:=True;
  TeeCommander1.ButtonSave.OnClick:=Save1Click;
  TeeCommander1.ButtonDepth.Visible:=False;
  TeeCommander1.Button3D.Visible:=False;
  {$IFNDEF CLR}TCommAccess{$ENDIF}(TeeCommander1).RepositionControls;

  //TeeFullLightModel:=GL_TRUE;
  with TeeOpenGL1.Light.Position do
  begin
    X:=1400;
    Y:=-1400;
    Z:=-100;
  end;

  TeeOpenGL1.Light.Color:=clDkGray;
  TeeOpenGL1.Active:=True;

  tmp:=TFormTeeGLEditor.Create(Self);
  tmp.CBActive.Hide;
  tmp.BOk.Hide;
  tmp.BCancel.Hide;
  tmp.TabControl1.Left:=4;

  tmp.GroupBox1.Left:=4;
  tmp.GroupBox1.Top:=3;
  tmp.GroupBox1.Height:=212;

  tmp.TabControl1.Top:=tmp.GroupBox1.Top+tmp.GroupBox1.Height+10;

  tmp.Height:=530;

  AddFormTo(tmp,TabSheet6,{$IFNDEF CLR}Integer{$ENDIF}(TeeOpenGL1));

  PageControl2Resize(Self);

  tmp.TBX.Max:=5000;
  tmp.TBX.Min:=-5000;
  tmp.TBY.Max:=5000;
  tmp.TBY.Min:=-5000;
  tmp.TBZ.Max:=5000;
  tmp.TBZ.Min:=-5000;

  with TIniFile.Create('.\TeeHouse.ini') do
  try
    if ReadBool('Main','Maximized',False) then
    begin
      Position:=poDesigned;
      WindowState:=wsMaximized;
    end;

    with Chart1.View3DOptions do
    begin
      Zoom:=ReadInteger(ViewKey,'Zoom',Zoom);
      Rotation:=ReadInteger(ViewKey,'Rotation',Rotation);
      Elevation:=ReadInteger(ViewKey,'Elevation',Elevation);
      Tilt:=ReadInteger(ViewKey,'Tilt',Tilt);
      HorizOffset:=ReadInteger(ViewKey,'HorizOffset',HorizOffset);
      VertOffset:=ReadInteger(ViewKey,'VertOffset',VertOffset);
      Perspective:=ReadInteger(ViewKey,'Perspective',Perspective);

      {$IFDEF CLR}
      with Chart1.Canvas.RotationCenter do
      begin
        tmpPoint.X:=ReadFloat(ViewKey,'CenterX',X);
        tmpPoint.Y:=ReadFloat(ViewKey,'CenterY',Y);
        tmpPoint.Z:=ReadFloat(ViewKey,'CenterZ',Z);
      end;

      Chart1.Canvas.RotationCenter:=tmpPoint;

      {$ELSE}

      with Chart1.Canvas.RotationCenter do
      begin
        X:=ReadFloat(ViewKey,'CenterX',X);
        Y:=ReadFloat(ViewKey,'CenterY',Y);
        Z:=ReadFloat(ViewKey,'CenterZ',Z);
      end;
      {$ENDIF}

      Chart1.Gradient.Visible:=ReadBool('Panel','GradientVisible',True);
      Chart1.Color:=ReadInteger('Panel','Color',Chart1.Color);
    end;
  finally
    Free;
  end;

  Selected:=NewBlocks;

  {$IFDEF D6}
  {$IFNDEF CLX}
  CheckListBox1.MultiSelect:=True;
  {$ENDIF}
  {$ENDIF}

  {$IFDEF D5}
  CheckListBox1.OnContextPopup:=CheckListBox1ContextPopup;
  {$ENDIF}
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Selected.Free;

  Blocks.Groups.Free;
  Blocks.Layers.Free;
  Blocks.Free;

  with TIniFile.Create('.\TeeHouse.ini') do
  try
    WriteBool('Main','Maximized',WindowState=wsMaximized);

    with Chart1.View3DOptions do
    begin
      WriteInteger(ViewKey,'Zoom',Zoom);
      WriteInteger(ViewKey,'Rotation',Rotation);
      WriteInteger(ViewKey,'Elevation',Elevation);
      WriteInteger(ViewKey,'Tilt',Tilt);
      WriteInteger(ViewKey,'HorizOffset',HorizOffset);
      WriteInteger(ViewKey,'VertOffset',VertOffset);
      WriteInteger(ViewKey,'Perspective',Perspective);

      with Chart1.Canvas.RotationCenter do
      begin
        WriteFloat(ViewKey,'CenterX',X);
        WriteFloat(ViewKey,'CenterY',Y);
        WriteFloat(ViewKey,'CenterZ',Z);
      end;

      WriteBool('Panel','GradientVisible',Chart1.Gradient.Visible);
      WriteInteger('Panel','Color',Chart1.Color);
    end;
  finally
    Free;
  end;
end;

{ TBlocks }

function TBlocks.Get(Index: Integer): TBlock;
begin
  result:=TBlock(inherited Items[Index]);
end;

procedure TBlocks.LoadFromFile(const FileName: String);
var FileStream : TFileStream;
    Reader: TReader;
    v:TValueType;
    tmp : String;
    Old : Boolean;
begin
  tmp:=FileName;
  if ExtractFileExt(tmp)='' then tmp:=tmp+'.hou';

  if Assigned(TeePanel) then
  begin
    Old:=TeePanel.AutoRepaint;
    TeePanel.AutoRepaint:=False;
  end
  else
    Old:=False;

  FCurrentDir:='';

  try
    FileStream:=TFileStream.Create(tmp,fmOpenRead);
    try
      Reader := TReader.Create(FileStream, 1024);
      try
        v:=Reader.ReadValue;
        if v=vaCollection then
           Reader.ReadCollection(Self)
        else
           Raise Exception.Create('Invalid TeeHouse file: '+tmp);

        FCurrentDir:=ExtractFilePath(ExpandFileName(FileName));
      finally
        Reader.Free;
      end;
    finally
      FileStream.Free;
    end;

  finally
    if Assigned(TeePanel) then
       TeePanel.AutoRepaint:=Old;
  end;
end;

Procedure TBlocks.SaveToStream(Stream:TStream; Sign:Boolean=False);
var Writer: TWriter;
begin
  Writer := TWriter.Create(Stream, 1024);
  try
    if Sign then
    begin
      Writer.WriteSignature;
      Writer.WriteStr('TBlocks');
      Writer.WriteStr('Blocks');
      Writer.WriteStr('Items');
    end;

    Writer.WriteCollection(Self);

    if Sign then
    begin
      Writer.WriteListEnd;
      Writer.WriteListEnd;
      Writer.WriteListEnd;
    end;

  finally
    Writer.Free;
  end;
end;

procedure TBlocks.SaveToFile(const FileName: String);
var FileStream : TFileStream;
    Input      : TMemoryStream;
begin
  FileStream:=TFileStream.Create(FileName,fmCreate);
  try
    if UpperCase(ExtractFileExt(FileName))='.TXT' then
    begin
      Input:=TMemoryStream.Create;
      try
        SaveToStream(Input,True);
        Input.Position:=0;
        ObjectBinaryToText(Input,FileStream);
      finally
        Input.Free;
      end;
    end
    else SaveToStream(FileStream);
  finally
    FileStream.Free;
  end;
end;

procedure TBlocks.SetGroups(const Value: TBlockGroups);
begin
  FGroups.Assign(Value);
end;

procedure TBlocks.SetLayers(const Value: TBlockGroups);
begin
  FLayers.Assign(Value);
end;

function TBlocks.Center: TPoint3DFloat;
var Min, Max : TPoint3D;
begin
  BoundingBox(Min,Max);
  result.X:=(Min.x+Max.x)*0.5;
  result.Y:=(Min.y+Max.y)*0.5;
  result.Z:=(Min.z+Max.z)*0.5;
end;

{ TBlock }

constructor TBlock.Create(Collection: TCollection);
begin
  inherited;
  FDark:=True;
  FBorder:=TChartPen.Create(CanvasChanged);
  FVisible:=True;
  FColor:=clWhite;
  FTitle:=IntToStr(Collection.Count-1);
  FTileX:=1;
  FTileY:=1;
  FTileZ:=1;
end;

destructor TBlock.Destroy;
begin
  FLinkItems.Free;
  FFont.Free;
  FPicture.Free;
  inherited;
end;

procedure TBlock.CanvasChanged(Sender:TObject);
begin
  Repaint;
end;

type
  TTeeCanvas3DAccess=class(TTeeCanvas3D);

procedure TBlock.Draw(Canvas: TCanvas3D);

  procedure LoadLink;
  var tmp : String;
  begin
    FLinkItems:=TBlocks.Create(TBlock);
    FLinkItems.FDrawBlocks:=Blocks;

    if FileExists(LinkFile) then
       FLinkItems.LoadFromFile(LinkFile)
    else
    begin
      tmp:=Blocks.FCurrentDir+'\'+ExtractFileName(LinkFile);

      if FileExists(tmp) then
      begin
        FLinkItems.LoadFromFile(tmp);
        LinkFile:=tmp;
      end
      else
      begin
        tmp:=WhereIsFile(ExtractFileName(LinkFile));
        if tmp<>'' then
        begin
          FLinkItems.LoadFromFile(tmp);
          LinkFile:=tmp;
        end;
      end;
    end;

    // TODO: Reset loaded blocks origin to 0,0,0 ?
  end;

var OldRotation,
    OldElevation,
    OldTilt,
    tmpX,
    tmpY,
    tmpZ  : Integer;
    Center : TPoint3DFloat;
    tmpBlend  : TTeeBlend;
begin
  if not (InGroup and InLayer) then exit;

  if LinkFile<>'' then
  begin
    if not Assigned(FLinkItems) then
       LoadLink;

    FLinkItems.Offset.X:=X;
    FLinkItems.Offset.Y:=Y;
    FLinkItems.Offset.Z:=Z;

    FLinkItems.Rotation.X:=Rotation;
    FLinkItems.Rotation.Y:=Elevation;
    FLinkItems.Rotation.Z:=Tilt;

    FLinkItems.Draw(Canvas);
    exit;
  end;

  if Blocks.FDrawBlocks.ShowBorders then
     Canvas.AssignVisiblePen(FBorder)
  else
     Canvas.Pen.Style:=psClear;

  Canvas.Brush.Style:=bsSolid;
  Canvas.Brush.Color:=Color;

  if (Texture>0) and Blocks.FDrawBlocks.ShowTextures then
     Canvas.Brush.Bitmap:=Blocks.FDrawBlocks.Textures[Texture-1]
  else
     glDisable(GL_TEXTURE_2D);

  OldRotation:=Canvas.View3DOptions.Rotation;
  OldElevation:=Canvas.View3DOptions.Elevation;
  OldTilt:=Canvas.View3DOptions.Tilt;

  tmpX:=X+Blocks.Offset.X;
  tmpY:=Y+Blocks.Offset.Y;
  tmpZ:=Z+Blocks.Offset.Z;

  if Blocks.Rotation.X<>0 {Blocks.FDrawBlocks} then
  begin
    Center:=Blocks.Center;
    Center.X:=Center.X+Blocks.Offset.X;
    Center.Y:=Center.Y+Blocks.Offset.Y;
    Center.Z:=Center.Z+Blocks.Offset.Z;
  end
  else
  begin
    Center.X:=tmpX+(Width div 2);
    Center.Y:=tmpY+(Height div 2);
    Center.Z:=tmpZ+(Depth div 2);
  end;

  if Canvas is TGLCanvas then
  begin
    glPushMatrix;

    // TODO: Allow parent rotation (to linked items)

    if (Elevation+Blocks.Rotation.Y)<>0 then
    begin
      glTranslatef(0,Center.Z,-Center.Y);
      glRotatef(-(Elevation+Blocks.Rotation.Y), 1, 0, 0);
      glTranslatef(0,-Center.Z,Center.Y);
    end;

    if (Rotation+Blocks.Rotation.X)<>0 then
    begin
      glTranslatef(Center.X,0,-Center.Y);
      glRotatef(Rotation+Blocks.Rotation.X, 0, 1, 0);
      glTranslatef(-Center.X,0,Center.Y);
    end;

    if (Tilt+Blocks.Rotation.Z)<>0 then
    begin
      glTranslatef(Center.X,Center.Z,0);
      glRotatef(Tilt+Blocks.Rotation.Z, 0, 0, 1);
      glTranslatef(-Center.X,-Center.Z,0);
    end;
  end
  else
  begin
    Canvas.View3DOptions.Rotation:=OldRotation+Rotation+Blocks.Rotation.X;
    Canvas.View3DOptions.Elevation:=OldElevation+Elevation+Blocks.Rotation.Y;
    Canvas.View3DOptions.Tilt:=OldTilt+Tilt+Blocks.Rotation.Z;

    TTeeCanvas3DAccess(Canvas).CalcTrigValues;
  end;

  if Transparency>0 then
     tmpBlend:=Canvas.BeginBlending(TeeRect(tmpX,-tmpZ,tmpX+Width,-tmpZ-Depth),Transparency)
  else
     tmpBlend:=nil;

  case FShape of
    bsCube: Canvas.Cube(tmpX,tmpX+Width,-tmpZ,-tmpZ-Depth,tmpY,tmpY+Height, DarkSides);
    bsCylinder:
      Canvas.Cylinder(True,tmpX,-tmpZ,tmpX+Width,-tmpZ-Depth,tmpY,tmpY+Height, DarkSides);
    bsSphere: Canvas.Sphere(Round(Center.X),Round(-Center.Z),Round(Center.Y),Width*0.5);
    bsTriangleRect: begin
                      Canvas.TriangleWithZ(TeePoint(tmpX,-tmpZ),
                         TeePoint(tmpX,-tmpZ-Depth),
                         TeePoint(tmpX+Width,-tmpZ-Depth),tmpY);
                    end;
    bsPyramid: Canvas.Pyramid( True,tmpX,-tmpZ-Depth,
               tmpX+Width,-tmpZ,tmpY,tmpY+Height,DarkSides);
    bsArrow:   Canvas.Arrow( Transparency<>100,
                             TeePoint(tmpX,tmpY),
                             TeePoint(tmpX+Width,tmpY+Height),
                             Depth,Depth,-tmpZ);
    bsEllipse: Canvas.EllipseWithZ(tmpX,-tmpZ,tmpX+Width,-tmpZ-Height,tmpY);
    bsText:
      begin
        if Assigned(FFont) then
           Canvas.AssignFont(FFont);

        Canvas.TextOut3D(tmpX,-tmpZ,tmpY,FTitle);
      end;
    bsImage: if Assigned(FPicture) and Assigned(FPicture.Graphic) then
             begin
               try
                 Canvas.Draw(tmpX,-tmpZ,FPicture.Graphic);
               except
                 on EInvalidGraphicOperation do
                    Picture:=nil;
               end;
             end;
  end;

  if Transparency>0 then
     Canvas.EndBlending(tmpBlend);

  if Canvas is TGLCanvas then
  begin
    glPopMatrix;
  end
  else
  begin
    Canvas.View3DOptions.Rotation:=OldRotation;
    Canvas.View3DOptions.Elevation:=OldElevation;
    Canvas.View3DOptions.Tilt:=OldTilt;

    TTeeCanvas3DAccess(Canvas).CalcTrigValues;
  end;
end;

procedure TBlock.Repaint;
begin
  with TBlocks(Collection) do
  if Assigned(TeePanel) then
     TeePanel.Invalidate;
end;

procedure TBlock.SetBorder(const Value: TChartPen);
begin
  FBorder.Assign(Value);
end;

procedure TBlock.SetTitle(const Value: String);
begin
  if FTitle<>Value then
  begin
    FTitle:=Value;
    Repaint;
  end;
end;

procedure TBlock.SetColor(const Value: TColor);
begin
  FColor:= Value;
  Repaint;
end;

procedure TBlock.SetDark(const Value: Boolean);
begin
  FDark := Value;
  Repaint;
end;

procedure TBlock.SetDepth(const Value: Integer);
begin
  FDepth := Value;
  Repaint;
end;

procedure TBlock.SetElevation(const Value: Integer);
begin
  FElevation := Value;
  Repaint;
end;

procedure TBlock.SetHeight(const Value: Integer);
begin
  FHeight := Value;
  Repaint;
end;

procedure TBlock.SetRotation(const Value: Integer);
begin
  FRotation := Value;
  Repaint;
end;

procedure TBlock.SetTilt(const Value: Integer);
begin
  FTilt := Value;
  Repaint;
end;

procedure TBlock.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
  Repaint;
end;

procedure TBlock.SetWidth(const Value: Integer);
begin
  FWidth := Value;
  Repaint;
end;

procedure TBlock.SetX(const Value: Integer);
begin
  FX := Value;
  Repaint;
end;

procedure TBlock.SetY(const Value: Integer);
begin
  FY := Value;
  Repaint;
end;

procedure TBlock.SetZ(const Value: Integer);
begin
  FZ := Value;
  Repaint;
end;

procedure TForm1.AddBlock(ABlock:TBlock);
var tmp : Integer;
    t   : Integer;
begin
  with CheckListBox1 do
  begin
    if Sorted then
    begin
      tmp:=0;
      for t:=0 to Items.Count-1 do
      begin
        tmp:=t;
        if Items[t]>ABlock.Title then
        begin
          break;
        end;
      end;

      Items.InsertObject(tmp,ABlock.Title,ABlock);
    end
    else tmp:=Items.AddObject(ABlock.Title,ABlock);

    Checked[tmp]:=ABlock.Visible;
  end;
end;

procedure TForm1.FinishAdd;
begin
  with CheckListBox1 do
       ItemIndex:=Items.IndexOfObject(Blocks[Blocks.Count-1]);

  BDelete.Enabled:=True;
  BDupli.Enabled:=True;
  PageControl1.Enabled:=True;
  CheckListBox1Click(Self);
  MarkDirty;
end;

procedure TForm1.BAddClick(Sender: TObject);
begin
  AddBlock(TBlock(Blocks.Add));
  FinishAdd;
end;

procedure TForm1.MarkDirty;
begin
  Dirty:=True;
  SpeedButton1.Visible:=True;
  Chart1.Invalidate;
end;

procedure TForm1.BDeleteClick(Sender: TObject);
var tmp:Integer;
begin
  if TeeYesNo('Sure to delete: '+Current.Title+'?') then
  begin
    tmp:=CheckListBox1.Items.IndexOfObject(Current);
    Current.Free;
    MarkDirty;

    with CheckListBox1 do
    begin
      Items.Delete(tmp);
      if tmp>0 then ItemIndex:=tmp-1
               else
      if Items.Count>0 then ItemIndex:=0;
    end;
  end;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if Showing then Current.X:=BlockX.Position;
  MarkDirty;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  if Showing then Current.Y:=BlockY.Position;
  MarkDirty;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
  if Showing then Current.Z:=BlockZ.Position;
  MarkDirty;
end;

procedure TForm1.Edit4Change(Sender: TObject);
begin
  if Showing then Current.Width:=BlockWidth.Position;
  MarkDirty;
end;

procedure TForm1.Edit5Change(Sender: TObject);
begin
  if Showing then Current.Height:=BlockHeight.Position;
  MarkDirty;
end;

procedure TForm1.Edit6Change(Sender: TObject);
begin
  if Showing then Current.Depth:=BlockDepth.Position;
  MarkDirty;
end;

procedure TForm1.BlockRotationChange(Sender: TObject);
begin
  Current.Rotation:=BlockRotation.Position;
  LRotation.Caption:=IntToStr(BlockRotation.Position);
  MarkDirty;
end;

procedure TForm1.BlockElevationChange(Sender: TObject);
begin
  Current.Elevation:=BlockElevation.Position;
  LElevation.Caption:=IntToStr(BlockElevation.Position);
  MarkDirty;
end;

procedure TForm1.BlockTiltChange(Sender: TObject);
begin
  Current.Tilt:=BlockTilt.Position;
  LTilt.Caption:=IntToStr(BlockTilt.Position);
  MarkDirty;
end;

function TForm1.Current: TBlock;
begin
  if CheckListBox1.ItemIndex=-1 then
     result:=nil
  else
     result:=Block(CheckListBox1.ItemIndex);
end;

function TForm1.Block(Index: Integer):TBlock;
begin
  result:=TBlock(CheckListBox1.Items.Objects[Index]);
end;

procedure TForm1.CheckListBox1ClickCheck(Sender: TObject);
begin
  Current.Visible:=CheckListBox1.Checked[CheckListBox1.ItemIndex];
  MarkDirty;
end;

procedure TForm1.CheckListBox1Click(Sender: TObject);
var tmp : Boolean;
begin
  if (Current<>nil) then
  with Current do
  begin
    tmp:=Dirty;

    BlockX.Position:=X;
    BlockY.Position:=Y;
    BlockZ.Position:=Z;
    BlockWidth.Position:=Width;
    BlockHeight.Position:=Height;
    BlockDepth.Position:=Depth;
    BlockTitle.Text:=Title;
    BlockBorder.LinkPen(Border);
    BlockColor.LinkProperty(Current,'Color');
    BlockRotation.Position:=Rotation;
    BlockElevation.Position:=Elevation;
    BlockTilt.Position:=Tilt;
    BlockGroup.ItemIndex:=Group;
    BlockLayer.ItemIndex:=Layer;
    BlockID.Caption:=Format('ID:%d',[Index]);
    BlockTexture.ItemIndex:=Texture;
    BlockShape.ItemIndex:=Ord(Shape);
    BlockTransp.Position:=Transparency;
    BlockTileX.Position:=TileX;
    BlockTileY.Position:=TileY;
    BlockTileZ.Position:=TileZ;

    if LinkFile='' then
       BlockLink.Caption:='(none)'
    else
       BlockLink.Caption:=ExtractFileName(LinkFile);

    BClearLink.Enabled:=LinkFile<>'';

    BFont.Enabled:=Shape=bsText;
    BImage.Enabled:=Shape=bsImage;

    if Dirty and (not tmp) then
       UnmarkDirty;
  end;
end;

procedure TForm1.FillBlockList;

  Function GroupInFilter(AGroup:Integer):Boolean;
  begin
    result:=(CBFilter.ItemIndex=0) or
            (AGroup=CBFilter.ItemIndex-1);
  end;

var t: Integer;
begin
  with CheckListBox1 do
  begin
    Items.BeginUpdate;
    try
      Clear;

      for t:=0 to Blocks.Count-1 do
          if GroupInFilter(Blocks[t].Group) then
             AddBlock(Blocks[t]);

      if Items.Count>0 then ItemIndex:=0
                       else ItemIndex:=-1;
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TForm1.SetMainCaption(Text:String);
begin
  if Text='' then Text:='(untitled)';
  Caption:='TeeHouse '+Text;
end;

const FileGroups='TeeHouseGroups.txt';
      FileLayers='TeeHouseLayers.txt';

procedure TForm1.FormShow(Sender: TObject);
var tmpPath : String;
    tmp     : String;
begin
  FileName:='';
  SetMainCaption('');

  if ParamCount>0 then
     tmpPath:=ExtractFilePath(ParamStr(1))+'\';

  GroupNames.Clear;
  LayerNames.Clear;

  TryLoadingNames(tmpPath);

  if ParamCount>0 then
     DoLoad(ParamStr(1))
  else
  begin
    tmp:=WhereIsFile(InitialFile);
    if tmp<>'' then
       DoLoad(tmp);
  end;

  PageControl2.ActivePage:=TabSheet4;
  PageControl1.ActivePage:=TabSheet1;
end;

procedure TForm1.TryLoadingNames(const APath:String);
var tmp : String;
begin
  if FileExists(FileGroups) then
     GroupNames.Lines.LoadFromFile(FileGroups)
  else
  if FileExists(APath+FileGroups) then
     GroupNames.Lines.LoadFromFile(APath+FileGroups)
  else
  begin
    tmp:=WhereIsFile(FileGroups);
    if tmp<>'' then
       GroupNames.Lines.LoadFromFile(tmp);
  end;

  BlockGroup.Items.Assign(GroupNames.Lines);

  if FileExists(FileLayers) then
     LayerNames.Lines.LoadFromFile(FileLayers)
  else
  if FileExists(APath+FileLayers) then
     LayerNames.Lines.LoadFromFile(APath+FileLayers)
  else
  begin
    tmp:=WhereIsFile(FileLayers);
    if tmp<>'' then
       LayerNames.Lines.LoadFromFile(tmp);
  end;

  BlockLayer.Items.Assign(LayerNames.Lines);

  CBFilter.Clear;
  CBFilter.Items.Assign(GroupNames.Lines);
  CBFilter.Items.Insert(0,'(all)');
  CBFilter.ItemIndex:=0;
end;

procedure TForm1.FinishLoad;
begin
  SetMainCaption(FileName);
  FillBlockList;

  AddGroups;
  AddLayers;

  BDelete.Enabled:=Blocks.Count>0;
  BDupli.Enabled:=Blocks.Count>0;
  PageControl1.Enabled:=Blocks.Count>0;

  CheckListBox1Click(Self);

  UnmarkDirty;
end;

Procedure TForm1.DoLoad(const AFile:String);
begin
  Blocks.Clear;
  Blocks.LoadFromFile(AFile);

  if GroupNames.Lines.Count=0 then
     TryLoadingNames(ExtractFilePath(AFile));

  FileName:=ExpandFileName(AFile);

  FinishLoad;
end;

Function TeeYesNoCancel(Const Message:String; Owner:TControl=nil):Integer;
var x : Integer;
    y : Integer;
Begin
  Screen.Cursor:=crDefault;
  if Assigned(Owner) then
  begin
    x:=Owner.Width div 2;
    y:=Owner.Height div 2;
    result:=MessageDlgPos(Message,mtConfirmation,[mbYes,mbNo,mbCancel],0,x,y);
  end
  else result:=MessageDlg(Message,mtConfirmation,[mbYes,mbNo,mbCancel],0);
End;

Function TForm1.DoSaveDialog:Boolean;
begin
  result:=SaveDialog1.Execute;
  if result then
  begin
    FileName:=SaveDialog1.FileName;

    // TODO: Check all blocks LinkFile property for path change...
    
    Blocks.SaveToFile(FileName);
  end;
end;

Function TForm1.DoSave:Boolean;
begin
  result:=False;

  if FileName='' then
  begin
    if Blocks.Count>0 then
    Case TeeYesNoCancel('Save to file?') of
      mrYes: result:=DoSaveDialog;
      mrNo: result:=True;
    end
    else result:=True;
  end
  else
  begin
    if Dirty then
    begin
      Case TeeYesNoCancel('Save changes?') of
        mrYes: begin
                 Blocks.SaveToFile(FileName);
                 UnmarkDirty;
                 result:=True;
               end;
        mrNo: begin
                result:=True;
                UnmarkDirty;
              end;
      end;
    end
    else result:=True;
  end;
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
  if Dirty and (FileName<>'') then
  begin
    Blocks.SaveToFile(FileName);
    UnmarkDirty;
  end
  else DoSave;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=DoSave;
end;

procedure TForm1.BlockTitleChange(Sender: TObject);
begin
  if Showing then
  begin
    Current.Title:=BlockTitle.Text;
    with CheckListBox1 do
         Items[Items.IndexOfObject(Current)]:=Current.Title;
    MarkDirty;
  end;
end;

function TBlock.GetBlocks: TBlocks;
begin
  result:=TBlocks(Collection)
end;

procedure TForm1.BDupliClick(Sender: TObject);
var tmp : TBlock;
begin
  tmp:=Current;

  if Assigned(tmp) then
  begin
    BAddClick(Self);
    Blocks[Blocks.Count-1].Assign(tmp);
    CheckListBox1Click(Self);
    MarkDirty;
  end;
end;

procedure TBlock.Assign(Source: TPersistent);
begin
  if Source is TBlock then
  with TBlock(Source) do
  begin
    Self.FDark:=DarkSides;
    Self.FX:=X;
    Self.FY:=Y;
    Self.FZ:=Z;
    Self.FHeight:=Height;
    Self.FElevation:=Elevation;
    Self.FWidth:=Width;
    Self.FTilt:=Tilt;
    Self.FRotation:=Rotation;
    Self.FDepth:=Depth;
    Self.Border:=Border;
    Self.FColor:=Color;
    Self.FVisible:=Visible;
    Self.FTitle:=Title;
    Self.FGroup:=Group;
    Self.FLayer:=Layer;
    Self.FTexture:=Texture;
    Self.FTileX:=TileX;
    Self.FTileY:=TileY;
    Self.FTileZ:=TileZ;
    Self.FShape:=Shape;
    Self.FTransparency:=Transparency;
    Self.FLink:=FLink;
    FreeAndNil(Self.FLinkItems);
    Self.Font:=FFont;
    Self.Picture:=FPicture;
  end
  else inherited;
end;

procedure TBlock.SetGroup(const Value: Integer);
begin
  FGroup := Value;
  Repaint;
end;

procedure TBlock.SetLayer(const Value: Integer);
begin
  FLayer := Value;
  Repaint;
end;

procedure TForm1.AddGroups;
var t:Integer;
    s:String;
    tmp:Integer;
begin
  with Groups do
  begin
    Clear;

    for t:=0 to Blocks.Count-1 do
    begin
      s:=IntToStr(Blocks[t].Group);
      if GroupNames.Lines.Count>Blocks[t].Group then
         s:=s+' '+GroupNames.Lines[Blocks[t].Group];

      if Items.IndexOf(s)=-1 then
      begin
        tmp:=Items.AddObject(s,TObject(Blocks[t].Group));
        Checked[tmp]:=True;
      end;
    end;

    for t:=0 to GroupNames.Lines.Count-1 do
    begin
      s:=IntToStr(t)+' '+GroupNames.Lines[t];
      if Items.IndexOf(s)=-1 then
      begin
        tmp:=Items.AddObject(s,TObject(t));
        Checked[tmp]:=True;
      end;
    end;

    Blocks.Groups.Assign(Items);
    Blocks.Groups.NotShowAll:=False;
  end;
end;

function AllChecked(List:TCheckListBox):Boolean;
var t : Integer;
begin
  result:=True;

  for t:=0 to List.Items.Count-1 do
  if not List.Checked[t] then
  begin
    result:=False;
    exit;
  end;
end;

procedure TForm1.GroupsClickCheck(Sender: TObject);
begin
  Blocks.Groups.NotShowAll:=not AllChecked(Blocks.GroupsList);
  Chart1.Invalidate;
end;

procedure TForm1.LayersClickCheck(Sender: TObject);
begin
  Blocks.Layers.NotShowAll:=not AllChecked(Blocks.LayersList);
  Chart1.Invalidate;
end;

function TBlock.InGroup: Boolean;
var t:Integer;
    tmp:TObject;
begin
  result:=True;

  if Assigned(Blocks.Groups) and Blocks.Groups.NotShowAll then
  begin
    tmp:=TObject(Group);

    for t:=0 to Blocks.Groups.Count-1 do
    if Blocks.Groups.Objects[t]=tmp then
    begin
      if not Blocks.GroupsList.Checked[t] then
         result:=False;
      break;
    end;
  end;
end;

function TBlock.InLayer: Boolean;
var t:Integer;
    tmp:TObject;
begin
  result:=True;

  if Assigned(Blocks.Layers) and Blocks.Layers.NotShowAll then
  begin
    tmp:=TObject(Layer);
    for t:=0 to Blocks.Layers.Count-1 do
    if Blocks.Layers.Objects[t]=tmp then
    begin
      if not Blocks.LayersList.Checked[t] then
         result:=False;
      break;
    end;
  end;
end;

procedure TForm1.AddLayers;
var t:Integer;
    s:String;
    tmp:Integer;
begin
  with Layers do
  begin
    Clear;
    for t:=0 to Blocks.Count-1 do
    begin
      s:=IntToStr(Blocks[t].Layer);
      if LayerNames.Lines.Count>Blocks[t].Layer then
         s:=s+' '+LayerNames.Lines[Blocks[t].Layer];

      if Items.IndexOf(s)=-1 then
      begin
        tmp:=Items.AddObject(s,TObject(Blocks[t].Layer));
        Checked[tmp]:=True;
      end;
    end;

    for t:=0 to LayerNames.Lines.Count-1 do
    begin
      s:=IntToStr(t)+' '+LayerNames.Lines[t];
      if Items.IndexOf(s)=-1 then
      begin
        tmp:=Items.AddObject(s,TObject(t));
        Checked[tmp]:=True;
      end;
    end;

    Blocks.Layers.Assign(Items);
    Blocks.Layers.NotShowAll:=False;
  end;
end;

procedure TForm1.Orderbyname1Click(Sender: TObject);
begin
  CheckListBox1.Sorted:=True;
  FillBlockList;
end;

procedure TForm1.NoOrder1Click(Sender: TObject);
begin
  CheckListBox1.Sorted:=False;
  FillBlockList;
end;

procedure TBlock.SetTexture(const Value: Integer);
begin
  FTexture := Value;
  Repaint;
end;

procedure TForm1.BlockTextureChange(Sender: TObject);
begin
  Current.Texture:=BlockTexture.ItemIndex;
  MarkDirty;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
{$IFDEF CLR}
var tmp : TPoint3DFloat;
{$ENDIF}
begin
  {$IFDEF CLR}
  tmp:=Chart1.Canvas.RotationCenter;
  tmp.X:=ScrollBar1.Position;
  Chart1.Canvas.RotationCenter:=tmp;
  {$ELSE}
  Chart1.Canvas.RotationCenter.X:=ScrollBar1.Position;
  {$ENDIF}

  Chart1.Invalidate;
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
{$IFDEF CLR}
var tmp : TPoint3DFloat;
{$ENDIF}
begin
  {$IFDEF CLR}
  tmp:=Chart1.Canvas.RotationCenter;
  tmp.Z:=ScrollBar2.Position;
  Chart1.Canvas.RotationCenter:=tmp;
  {$ELSE}
  Chart1.Canvas.RotationCenter.Z:=ScrollBar2.Position;
  {$ENDIF}

  Chart1.Invalidate;
end;

procedure TForm1.ScrollBar3Change(Sender: TObject);
{$IFDEF CLR}
var tmp : TPoint3DFloat;
{$ENDIF}
begin
  {$IFDEF CLR}
  tmp:=Chart1.Canvas.RotationCenter;
  tmp.Y:=ScrollBar3.Position;
  Chart1.Canvas.RotationCenter:=tmp;
  {$ELSE}
  Chart1.Canvas.RotationCenter.Y:=ScrollBar3.Position;
  {$ENDIF}

  Chart1.Invalidate;
end;

procedure TBlock.SetShape(const Value: TBlockShape);
begin
  FShape := Value;
  Repaint;
end;

procedure TForm1.BlockShapeChange(Sender: TObject);
begin
  Current.Shape:=TBlockShape(BlockShape.ItemIndex);
  BlockTexture.Enabled:=Current.Shape<>bsPyramid;

  BFont.Enabled:=Current.Shape=bsText;
  BImage.Enabled:=Current.Shape=bsImage;

  MarkDirty;
end;

procedure TForm1.BlockGroupChange(Sender: TObject);
begin
  if Showing then
     Current.Group:=BlockGroup.ItemIndex;
  MarkDirty;
end;

procedure TForm1.BlockLayerChange(Sender: TObject);
begin
  if Showing then
     Current.Layer:=BlockLayer.ItemIndex;
  MarkDirty;
end;

procedure TForm1.CBFilterChange(Sender: TObject);
begin
  FillBlockList;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  TeeShowAboutBox('TeeHouse','TeeHouse v1.0');
end;

procedure TForm1.Saveas1Click(Sender: TObject);
var Old:String;
begin
  Old:=FileName;

  FileName:='';

  if not DoSaveDialog then FileName:=Old;
end;

procedure TForm1.New1Click(Sender: TObject);
begin
  if CloseQuery then
  begin
    FileName:='';

    Blocks.Clear;
    FinishLoad;
    Chart1.Invalidate;
  end;
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
     DoLoad(OpenDialog1.FileName);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Resetview1Click(Sender: TObject);
begin
  with Chart1.View3DOptions do
  begin
    Orthogonal:=False;
    Rotation:=4;
    Elevation:=352;
    Tilt:=0;
    HorizOffset:=554;
    VertOffset:=542;
    Zoom:=64;
  end;
end;

procedure TForm1.Borders1Click(Sender: TObject);
begin
  with Borders1 do Checked:=not Checked;
  Blocks.ShowBorders:=Borders1.Checked;
  Chart1.Invalidate;
end;

procedure TForm1.extures1Click(Sender: TObject);
begin
  with extures1 do Checked:=not Checked;
  Blocks.ShowTextures:=extures1.Checked;
  Chart1.Invalidate;
end;

procedure TForm1.Lightfocus1Click(Sender: TObject);
begin
  with Lightfocus1 do Checked:=not Checked;
  Chart1.Invalidate;
end;

procedure TForm1.Smooth1Click(Sender: TObject);
begin
  with Smooth1 do Checked:=not Checked;
  
  TeeOpenGL1.ShadeQuality:=Smooth1.Checked;
end;

procedure TForm1.CBSpinByClick(Sender: TObject);
var tmp : Integer;
begin
  if CBSpinBy.Checked then
     tmp:=UDSpinBy.Position
  else
     tmp:=1;

  BlockX.Increment:=tmp;
  BlockY.Increment:=tmp;
  BlockZ.Increment:=tmp;
  BlockWidth.Increment:=tmp;
  BlockHeight.Increment:=tmp;
  BlockDepth.Increment:=tmp;
end;

procedure TForm1.CheckAll(List:TCheckListBox; Value:Boolean=True);
var t : Integer;
begin
  for t:=0 to List.Items.Count-1 do
      List.Checked[t]:=Value;
  Chart1.Invalidate;
end;

procedure TForm1.UnCheckAll1Click(Sender: TObject);
begin
  CheckAll(Groups,False);
end;

procedure TForm1.CheckAll1Click(Sender: TObject);
begin
  CheckAll(Groups);
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  CheckAll(Layers,False);
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  CheckAll(Layers);
end;

procedure TForm1.View3DAxesClick(Sender: TObject);
begin
  with View3DAxes do Checked:=not Checked;
  Chart1.Invalidate;
end;

procedure TForm1.ScrollBar4Change(Sender: TObject);
begin
  Chart1.View3DOptions.Tilt:=ScrollBar4.Position;
end;

procedure TForm1.BlockBorderClick(Sender: TObject);
begin
  MarkDirty;
end;

procedure TForm1.BlockColorClick(Sender: TObject);
begin
  MarkDirty;
end;

procedure TForm1.ChartPreviewer1Show(Sender: TObject);
begin
//  ChartPreviewer1.PreviewPanel.AsBitmap:=True;  AV with OpenGL
  ChartPreviewer1.PreviewPanel.SmoothBitmap:=True;
end;

procedure TForm1.BlockTranspChange(Sender: TObject);
begin
  Current.Transparency:=BlockTransp.Position;
  MarkDirty;
end;

procedure TBlock.SetTransparency(const Value: TTeeTransparency);
begin
  FTransparency := Value;
  Repaint;
end;

// Moves a block to Position inside Blocks list
procedure TForm1.MoveBlock(Block:TBlock; Position:Integer);
begin
  Block.Index:=Position;
  FillBlockList;
  CheckListBox1.ItemIndex:=CheckListBox1.Items.IndexOfObject(Block);
  Chart1.Invalidate;
end;

// Move current selected block to last (bottom) of list
procedure TForm1.Movetobottom1Click(Sender: TObject);
begin
  MoveBlock(Current,Blocks.Count-1);
end;

// Move current selected block to first (top) of list
procedure TForm1.Movetotop1Click(Sender: TObject);
begin
  MoveBlock(Current,0);
end;

procedure TForm1.Duplicate1Click(Sender: TObject);
begin
  BDupliClick(Self);
end;

procedure TForm1.CheckListBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=Sender=Source;
end;

procedure TForm1.CheckListBox1EndDrag(Sender, Target: TObject; X,
  Y: Integer);
//var tmp : Integer;
//    P : TPoint;
begin
//  P:=Point(x,y);
//  P:=CheckListBox1.ScreenToClient(P);
//  tmp:=CheckListBox1.ItemAtPos(P,True);
//  if (tmp<>-1) and (tmp<>Current.Index) then
//     MoveBlock(Current,tmp);
end;

procedure TForm1.Moveup1Click(Sender: TObject);
begin
  MoveBlock(Current,Current.Index-1);
end;

procedure TForm1.Movedown1Click(Sender: TObject);
begin
  MoveBlock(Current,Current.Index+1);
end;

{$IFDEF D5}
procedure TForm1.CheckListBox1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var tmp : TBlock;
begin
  tmp:=Current;
  MoveToBottom1.Enabled:=Assigned(tmp) and (tmp.Index<Blocks.Count-1);
  MoveToTop1.Enabled:=Assigned(tmp) and (tmp.Index>0);
  Moveup1.Enabled:=MovetoTop1.Enabled;
  Movedown1.Enabled:=Movetobottom1.Enabled;
  Delete1.Enabled:=Assigned(tmp);
end;
{$ENDIF}

procedure TForm1.Insert1Click(Sender: TObject);
var tmp : TBlock;
begin
  tmp:=Current;
  BAddClick(Self);

  if Assigned(tmp) and (tmp.Index>0) then
     MoveBlock(Current,tmp.Index-1)
  else
     MoveBlock(Current,0);
end;

procedure TForm1.Delete1Click(Sender: TObject);
begin
  BDeleteClick(Self);
end;

procedure TBlock.SetTileX(const Value: Integer);
begin
  FTileX := Value;
  Repaint;
end;

procedure TBlock.SetTileY(const Value: Integer);
begin
  FTileY := Value;
  Repaint;
end;

procedure TForm1.BlockTileXChange(Sender: TObject);
begin
  Current.TileX:=BlockTileX.Position;
  MarkDirty;
end;

procedure TForm1.BlockTileYChange(Sender: TObject);
begin
  Current.TileY:=BlockTileY.Position;
  MarkDirty;
end;

procedure TForm1.Duplicate2Click(Sender: TObject);
begin
  Duplicate1Click(Self);
end;

procedure TForm1.CopySelectedBlocks(Collection:TBlocks);
var t : Integer;
begin
  for t:=0 to CheckListBox1.Items.Count-1 do
  if CheckListBox1.Selected[t] then
     (Collection.Add as TBlock).Assign(Block(t));
end;

procedure TBlocks.BoundingBox(var Min,Max:TPoint3D);
var t : Integer;
begin
  if Count=0 then
  begin
    Min.X:=0;
    Min.Y:=0;
    Min.Z:=0;
    Max.X:=0;
    Max.Y:=0;
    Max.Z:=0;
  end
  else
  begin
    Min.X:=Item[0].X;
    Min.Y:=Item[0].Y;
    Min.Z:=Item[0].Z;
    Max:=Min;

    for t:=1 to Count-1 do
    with Item[t] do
    begin
      Min.X:=Math.Min(Min.X,X);
      Min.Y:=Math.Min(Min.Y,Y);
      Min.Z:=Math.Min(Min.Z,Z);
      Max.X:=Math.Max(Max.X,X);
      Max.Y:=Math.Max(Max.Y,Y);
      Max.Z:=Math.Max(Max.Z,Z);
    end;
  end;
end;

procedure TForm1.Savetoexternal1Click(Sender: TObject);
var tmp : TBlocks;
    t   : Integer;
    Min,
    Max : TPoint3D;
    tmpNew : TBlock;
begin
  if CheckListBox1.SelCount>0 then
  if SaveDialog1.Execute then
  begin
    tmp:=NewBlocks;
    try
      CopySelectedBlocks(tmp);

      tmp.BoundingBox(Min,Max);

      for t:=0 to tmp.Count-1 do
      with tmp[t] do
      begin
        Dec(FX,Min.X);
        Dec(FY,Min.Y);
        Dec(FZ,Min.Z);
      end;

      tmp.SaveToFile(SaveDialog1.FileName);

      // Create new block pointing to external just-saved file
      tmpNew:=TBlock(Blocks.Add);
      tmpNew.X:=Min.X;
      tmpNew.Y:=Min.Y;
      tmpNew.Z:=Min.Z;
      tmpNew.LinkFile:=SaveDialog1.FileName;

      AddBlock(tmpNew);
      FinishAdd;
    finally
      tmp.Free;
    end;
  end;
end;

procedure TForm1.Copy1Click(Sender: TObject);
begin
  Selected.Clear;
  CopySelectedBlocks(Selected);
end;

procedure TForm1.Paste1Click(Sender: TObject);
var t   : Integer;
    tmp : TBlock;
begin
  for t:=0 to Selected.Count-1 do
  begin
    tmp:=TBlock(Blocks.Add);
    tmp.Assign(Selected[t]);
    AddBlock(tmp);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var tmp : String;
begin
  if OpenDialog1.Execute then
  begin
    tmp:=OpenDialog1.FileName;
    if UpperCase(ExtractFilePath(tmp))=UpperCase(ExtractFilePath(FileName)) then
       tmp:=ExtractFileName(tmp);

    Current.LinkFile:=tmp;

    BlockLink.Caption:=ExtractFileName(Current.LinkFile);
    MarkDirty;
  end;
end;

procedure TForm1.BClearLinkClick(Sender: TObject);
begin
  Current.LinkFile:='';
  BlockLink.Caption:='(none)';
  MarkDirty;
end;

procedure TBlock.SetLink(const Value: String);
begin
  FLink := Value;
  if FLink='' then
     FreeAndNil(FLinkItems);
end;

procedure TForm1.Delete2Click(Sender: TObject);
begin
  Delete1Click(Self);
end;

procedure TForm1.Edit7Click(Sender: TObject);
var tmp : Boolean;
begin
  tmp:=CheckListBox1.ItemIndex<>-1;
  Copy1.Enabled:=tmp;
  Duplicate2.Enabled:=tmp;
  Delete2.Enabled:=tmp;
  Paste1.Enabled:=Selected.Count>0;
end;

procedure TForm1.UDSpinByClick(Sender: TObject; Button: TUDBtnType);
begin
  CBSpinByClick(Self);
end;

procedure TForm1.Boundingbox1Click(Sender: TObject);
begin
  with Boundingbox1 do Checked:=not Checked;
  Chart1.Invalidate;
end;

procedure TForm1.BlockTileZChange(Sender: TObject);
begin
  Current.TileZ:=BlockTileZ.Position;
  MarkDirty;
end;

procedure TBlock.SetTileZ(const Value: Integer);
begin
  FTileZ := Value;
  Repaint;
end;

procedure TForm1.BFontClick(Sender: TObject);
begin
  EditTeeFontEx(Self,Current.Font);
end;

procedure TBlock.SetFont(const Value: TTeeFont);
begin
  if Assigned(Value) then
     Font.Assign(Value)
  else
     FreeAndNil(FFont);
end;

procedure TForm1.Locallight1Click(Sender: TObject);
begin
  Locallight1.Checked:=not Locallight1.Checked;

  if Locallight1.Checked then TeeFullLightModel:=GL_TRUE
                         else TeeFullLightModel:=GL_FALSE;

  Chart1.Canvas.UseBuffer:=True;
  Chart1.Invalidate;
end;

procedure TForm1.AntiAlias1Click(Sender: TObject);
begin
  AntiAlias1.Checked:=not AntiAlias1.Checked;

  if AntiAlias1.Checked then
     TeeSmoothQuality:=GL_NICEST
  else
     TeeSmoothQuality:=GL_FASTEST;

  TeeOpenGL1.AntiAlias:=AntiAlias1.Checked;

  Chart1.Canvas.UseBuffer:=True;
  Chart1.Invalidate;
end;

function TBlock.GetFont: TTeeFont;
begin
  if not Assigned(FFont) then
     FFont:=TTeeFont.Create(CanvasChanged);
  result:=FFont;
end;

function TBlock.GetPicture: TPicture;
begin
  if not Assigned(FPicture) then
     FPicture:=TPicture.Create;
  result:=FPicture;
end;

procedure TBlock.SetPicture(const Value: TPicture);
begin
  if Assigned(Value) then
     Picture.Assign(Value)
  else
     FreeAndNil(FPicture);
end;

procedure TForm1.BImageClick(Sender: TObject);
begin
  Current.Picture:=nil;
  TeeLoadClearImage(Self,Current.Picture);
  //(Chart1.Canvas as TGLCanvas).DeleteTexture(Current.Picture);
  Chart1.Invalidate;
  MarkDirty;
end;

procedure TForm1.PageControl2Resize(Sender: TObject);
begin
  with TabSheet6.Controls[1] as TFormTeeGLEditor do
  begin
    TabControl1.Width:=Self.TabSheet6.Width-10;
    GroupBox1.Width:=Self.TabSheet6.Width-10;
  end;
end;

end.
