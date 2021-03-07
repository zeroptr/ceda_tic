{**********************************************}
{   TVideoPlayerTool component.                }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeeVideoPlayer;
{$I TeeDefs.inc}

interface

// {$MINENUMSIZE 4}
// {$ALIGN ON}

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QExtCtrls, QForms, QDialogs, QStdCtrls, QButtons,
  QComCtrls, Qt,
  {$ELSE}
  Graphics, Controls, ExtCtrls, Forms, Dialogs, StdCtrls, Buttons, ComCtrls,
  {$ENDIF}
  TeeFilters, TeEngine, TeeVideo, TeCanvas;

type
  TVideoPlayerTool=class(TTeeCustomTool)
  private
    FFileName : String;
    FFilters  : TFilterItems;
    FLoop     : Boolean;
    FOnFrame  : TNotifyEvent;
    FPicture  : TPicture;

    IBitmap   : TBitmap;
    ICount    : Integer;
    IPaused   : Boolean;
    IPlaying  : Boolean;
    ITimer    : TTimer;
    IEndFrame : Integer;

    IGetFrame : PGETFRAME;
    IStream   : PAVIStream;
    IFile     : PAVIFile;

    procedure Finish;
    function GetEnd: Integer;
    function GetStart: Integer;
    procedure Open;
    procedure TimerEvent(Sender: TObject);
    function GetDelay: Integer;
    procedure SetDelay(const Value: Integer);
    procedure SetFilters(const Value: TFilterItems);
    procedure SetPicture(const Value: TPicture);
  protected
    class Function GetEditorClass:String; override;

    function GetFrame(FrameNumber: Integer):TBitmap; overload;
    procedure GetFrame(FrameNumber: Integer; var b:TBitmap); overload;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    class Function Description:String; override;
    class Function LongDescription:String; override;

    procedure Pause;
    procedure Play;
    procedure Stop;

    property Paused:Boolean read IPaused;
    property Picture:TPicture read FPicture write SetPicture;
    property Playing:Boolean read IPlaying;
    property Position:Integer read ICount write ICount;

    property StartFrame:Integer read GetStart;
    property EndFrame:Integer read GetEnd;

  published
    property Delay:Integer read GetDelay write SetDelay default 1;
    property FileName:String read FFileName write FFileName;
    property Filters:TFilterItems read FFilters write SetFilters stored False;
    property Loop:Boolean read FLoop write FLoop default False;

    property OnFrame:TNotifyEvent read FOnFrame write FOnFrame;
  end;

  TVideoPlayerEditor = class(TForm)
    Label1: TLabel;
    EName: TEdit;
    SpeedButton1: TSpeedButton;
    BPlay: TButton;
    Button1: TButton;
    CBLoop: TCheckBox;
    Label2: TLabel;
    EDelay: TEdit;
    UDDelay: TUpDown;
    OpenDialog1: TOpenDialog;
    LFrame: TLabel;
    GroupBox1: TGroupBox;
    RBBack: TRadioButton;
    RBOther: TRadioButton;
    CBDisplay: TComboFlat;
    CBItem: TComboFlat;
    procedure BPlayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBLoopClick(Sender: TObject);
    procedure EDelayChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ENameChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RBOtherClick(Sender: TObject);
    procedure RBBackClick(Sender: TObject);
    procedure CBDisplayChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBItemChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    OldOnFrame : TNotifyEvent;
    Player     : TVideoPlayerTool;
    VideoSize  : Integer;

    procedure PlayerFrame(Sender: TObject);
    procedure SetupPlay;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  Chart, TeeConst, TeeProCo, TeeTools, TeeFiltersEditor;

{ TVideoPlayerTool }

Constructor TVideoPlayerTool.Create(AOwner:TComponent);
begin
  inherited;

  InitVideoForWindows;

  FFilters:=TFilterItems.Create(Self,TTeeFilter);

  ITimer:=TTimer.Create(nil);
  ITimer.Interval:=1;
  ITimer.Enabled:=False;
  ITimer.OnTimer:=TimerEvent;
end;

procedure TVideoPlayerTool.TimerEvent(Sender: TObject);
begin
  if not Assigned(IBitmap) then
     IBitmap:=TBitmap.Create;

  // Copy video frame to IBitmap
  GetFrame(ICount,IBitmap);

  if Assigned(FPicture) then
     FPicture.Assign(IBitmap)
  else
  begin
    ParentChart.BackImage.Assign(IBitmap);

    if (not ParentChart.BackImage.Inside) and ParentChart.Gradient.Visible then
       ParentChart.Gradient.Visible:=False;
  end;

  if Assigned(FOnFrame) then
     FOnFrame(Self);

  if ICount=IEndFrame then  // last frame?
  begin
    if Loop then
       ICount:=StartFrame  // start again
    else
       Stop
  end
  else
     Inc(ICount);  // continue to next frame
end;

procedure TVideoPlayerTool.Open;
var
  P : PBitmapInfoHeader;
  BitmapInfoHeader : TBitmapInfoHeader;
  StreamInfo       : TAviStreamInfoA;
begin
  AVIFileInit;
  AviCheck(AVIFileOpen(IFile, PChar(FFileName), OF_READ or OF_SHARE_DENY_WRITE, nil));
  AviCheck(AVIFileGetStream(IFile, IStream, streamtypeVIDEO, 0));
  AviCheck(AVIStreamInfo(IStream, StreamInfo, SizeOf(StreamInfo)));

  P:=@BitmapInfoHeader;

  ZeroMemory(P, SizeOf(BitmapInfoHeader));
  With BitmapInfoHeader do
  begin
    biSize:=SizeOf(TBitmapInfoHeader);
    biBitCount:=24;
    biClrImportant:=0;
    biClrUsed:=0;
    biCompression:=BI_RGB;
    biHeight:=streamInfo.rcFrame.Bottom - streamInfo.rcFrame.Top;
    biWidth:=streamInfo.rcFrame.Right - streamInfo.rcFrame.Left;
    biPlanes:=1;
    biXPelsPerMeter:=0;
    biYPelsPerMeter:=0;
    biSizeImage:=(((biWidth * (biBitCount div 8)) + (biBitCount div 8)) And $FFFC) * biHeight;
  end;

  try
    IGetFrame:=AVIStreamGetFrameOpen(IStream, P);
  except
    on Exception do
       IGetFrame:=nil;
  end;

  if not Assigned(IGetFrame) then
     Raise Exception.Create('Error GetFrameOpen AVI file stream');
end;

procedure TVideoPlayerTool.Finish;
begin
  if Assigned(IGetFrame) then
  begin
    AVIStreamGetFrameClose(IGetFrame);
    IGetFrame:=nil;
  end;

  if Assigned(IStream) then
  begin
    AVIStreamRelease(IStream);
    IStream:=nil;
  end;

  if Assigned(IFile) then
  begin
    AVIFileRelease(IFile);
    IFile:=nil;
  end;

  AVIFileExit;
end;

function TVideoPlayerTool.GetFrame(FrameNumber: Integer):TBitmap;
begin
  result:=TBitmap.Create;
  GetFrame(FrameNumber,result);
end;

procedure TVideoPlayerTool.GetFrame(FrameNumber: Integer; var b:TBitmap);
var Info: PBITMAPINFOHEADER;
begin
  Info:=AVIStreamGetFrame(IGetFrame, FrameNumber);

  if Assigned(Info) then
  with b do
  begin
    Height:=Info.biHeight;
    Width:=Info.biWidth;

    SetDIBits( {$IFDEF CLX}QPainter_handle{$ENDIF}(Canvas.Handle),
               {$IFDEF CLX}QPixmap_hbm{$ENDIF}(Handle),
               0,Height,
               Pointer(Integer(Info) + SizeOf(TBITMAPINFOHEADER)),
               PBITMAPINFO(Info)^, DIB_RGB_COLORS);

  end
  else
  begin
    ITimer.Enabled:=False;

    raise Exception.Create('Error GetFrame AVI file stream');
  end;

  Filters.ApplyTo(b);
end;

Destructor TVideoPlayerTool.Destroy;
begin
  FFilters.Free;
  IBitmap.Free;
  ITimer.Free;
  Finish;

  inherited;
end;

function TVideoPlayerTool.GetEnd:Integer;
begin
  result:=GetStart;

  if Assigned(IStream) then
     Inc(result,AVIStreamLength(IStream)-1);
end;

function TVideoPlayerTool.GetStart:Integer;
begin
  if Assigned(IStream) then
     result:=AVIStreamStart(IStream)
  else
     result:=-1;
end;

class function TVideoPlayerTool.Description: String;
begin
  result:=TeeMsg_VideoPlayerTool;
end;

class function TVideoPlayerTool.LongDescription: String;
begin
  result:=TeeMsg_VideoPlayerToolDesc;
end;

procedure TVideoPlayerTool.Pause;
begin
  ITimer.Enabled:=False;
  IPaused:=True;
end;

procedure TVideoPlayerTool.Play;
begin
  if Paused then
     ITimer.Enabled:=True
  else
  if not Playing then
  begin
    Open;
    ICount:=StartFrame;
    IPlaying:=True;
    ITimer.Enabled:=True;
    IEndFrame:=EndFrame;
  end;
end;

procedure TVideoPlayerTool.Stop;
begin
  if Playing then
  begin
    ITimer.Enabled:=False;
    Finish;
    IPlaying:=False;
    IPaused:=False;
  end;
end;

function TVideoPlayerTool.GetDelay: Integer;
begin
  result:=ITimer.Interval;
end;

procedure TVideoPlayerTool.SetDelay(const Value: Integer);
begin
  ITimer.Interval:=Value;
end;

procedure TVideoPlayerTool.SetFilters(const Value: TFilterItems);
begin
  Filters.Assign(Value);
end;

class function TVideoPlayerTool.GetEditorClass: String;
begin
  result:='TVideoPlayerEditor';
end;

procedure TVideoPlayerEditor.BPlayClick(Sender: TObject);
begin
  if BPlay.Tag=1 then
  begin
    Player.Stop;
    Player.OnFrame:=OldOnFrame;
    BPlay.Caption:=TeeMsg_Play;
    BPlay.Tag:=0;
    LFrame.Caption:='';
  end
  else
  begin
    Player.Play;
    SetupPlay;
  end;
end;

procedure TVideoPlayerEditor.SetupPlay;
begin
  OldOnFrame:=Player.OnFrame;
  Player.OnFrame:=PlayerFrame;
  VideoSize:=Player.GetEnd-Player.GetStart;
  BPlay.Caption:=TeeMsg_Stop;
  BPlay.Tag:=1;
end;

procedure TVideoPlayerEditor.PlayerFrame(Sender: TObject);
begin
  if Assigned(OldOnFrame) then
     OldOnFrame(Sender);

  LFrame.Caption:=IntToStr(Player.Position)+' / '+IntToStr(VideoSize);
end;

procedure TVideoPlayerEditor.FormShow(Sender: TObject);

  procedure FindPicture(Display,Index:Integer);
  begin
    CBDisplay.ItemIndex:=Display;
    CBDisplayChange(Self);
    CBItem.ItemIndex:=Index;
  end;

  procedure SearchTool;

    function FindTool(Index:Integer; APicture:TTeePicture):Boolean;
    begin
      CBDisplay.ItemIndex:=Index;
      CBDisplayChange(Self);
      CBItem.ItemIndex:=CBItem.Items.IndexOfObject(APicture);
      result:=Player.Picture=APicture;
    end;

  var t : Integer;
  begin
    with Player.ParentChart do
    for t:=0 to Tools.Count-1 do
        if Tools[t] is TAnnotationTool then
        begin
          if FindTool(0,TAnnotationTool(Tools[t]).Shape.Picture) then
             break;
        end
        else
        if Tools[t] is TChartImageTool then
        begin
          if FindTool(1,TChartImageTool(Tools[t]).Picture) then
             break;
        end;
  end;

  procedure CheckToBack;
  begin
    if Player.ParentChart.BackImage.Inside then
    begin
      RBOther.Checked:=True;
      CBDisplay.ItemIndex:=4;
      CBDisplayChange(Self);
      CBItem.ItemIndex:=0;
    end
    else
       RBBack.Checked:=True;
  end;

begin
  Player:=TVideoPlayerTool(Tag);

  if Assigned(Player) then
  with Player do
  begin
    BPlay.Enabled:=FileName<>'';

    if Playing then
       SetupPlay;

    if Assigned(Picture) then
    begin
      if Picture=ParentChart.BackImage then
         CheckToBack
      else
      begin
        RBOther.Checked:=True;

        with ParentChart as TCustomChart do
        begin
          if Legend.Picture=Picture then
             CBDisplay.ItemIndex:=2
          else
          if Walls.Back.Picture=Picture then
             FindPicture(4,0)
          else
          if Walls.Bottom.Picture=Picture then
             FindPicture(4,1)
          else
          if Walls.Left.Picture=Picture then
             FindPicture(4,2)
          else
          if Walls.Right.Picture=Picture then
             FindPicture(4,3)
          else
          if Picture=Title.Picture then
             FindPicture(3,0)
          else
          if Picture=SubTitle.Picture then
             FindPicture(3,1)
          else
          if Picture=Foot.Picture then
             FindPicture(3,2)
          else
          if Picture=SubFoot.Picture then
             FindPicture(3,3)
          else
             SearchTool;
        end;
      end;
    end
    else
      CheckToBack;

    CBDisplay.Enabled:=RBOther.Checked;

    LFrame.Caption:='';
    CBLoop.Checked:=Loop;
    UDDelay.Position:=Delay;
    EName.Text:=FileName;
  end;
end;

procedure TVideoPlayerEditor.CBLoopClick(Sender: TObject);
begin
  Player.Loop:=CBLoop.Checked;
end;

procedure TVideoPlayerEditor.EDelayChange(Sender: TObject);
begin
  if Showing then
     Player.Delay:=UDDelay.Position;
end;

procedure TVideoPlayerEditor.Button1Click(Sender: TObject);
begin
  ShowFiltersEditor(Self,Player.IBitmap,Player.Filters);
end;

procedure TVideoPlayerEditor.ENameChange(Sender: TObject);
begin
  Player.FileName:=EName.Text;
  BPlay.Enabled:=Player.FileName<>'';
end;

procedure TVideoPlayerEditor.SpeedButton1Click(Sender: TObject);
begin
  OpenDialog1.FileName:=EName.Text;

  if OpenDialog1.Execute then
     EName.Text:=OpenDialog1.FileName;
end;

procedure TVideoPlayerEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Player.OnFrame:=OldOnFrame;
end;

procedure TVideoPlayerEditor.RBOtherClick(Sender: TObject);
begin
  RBBack.Checked:=False;
  CBDisplay.Enabled:=True;
  CBDisplay.ItemIndex:=-1;
  CBItem.Clear;
end;

procedure TVideoPlayerEditor.RBBackClick(Sender: TObject);
begin
  RBOther.Checked:=False;
  CBDisplay.Enabled:=False;
  CBItem.Enabled:=False;
  Player.Picture:=Player.ParentChart.BackImage;
  Player.ParentChart.BackImage.Inside:=False;
end;

procedure TVideoPlayerEditor.CBDisplayChange(Sender: TObject);

  procedure AddTools(AToolClass:TTeeCustomToolClass; Annotation:Boolean);
  var t   : Integer;
      tmp : TTeePicture;
  begin
    with Player.ParentChart.Tools do
    for t:=0 to Count-1 do
        if Items[t] is AToolClass then
        begin
          if Annotation then
             tmp:=(Items[t] as TAnnotationTool).Shape.Picture
          else
             tmp:=(Items[t] as TChartImageTool).Picture;

          CBItem.Items.AddObject(Items[t].Name,tmp);
        end;
  end;

begin
  Player.Picture:=nil;

  CBItem.Enabled:=True;
  CBItem.Clear;

  case CBDisplay.ItemIndex of
    0: AddTools(TAnnotationTool,True);
    1: AddTools(TChartImageTool,False);
    2: begin
         Player.Picture:=(Player.ParentChart as TCustomChart).Legend.Picture;
         CBItem.Enabled:=False;
       end;
    3: with (Player.ParentChart as TCustomChart) do
       begin
         CBItem.Items.AddObject(TeeMsg_Title,Title.Picture);
         CBItem.Items.AddObject(TeeMsg_SubTitle,SubTitle.Picture);
         CBItem.Items.AddObject(TeeMsg_Foot,Foot.Picture);
         CBItem.Items.AddObject(TeeMsg_SubFoot,SubFoot.Picture);
       end;
    4: with (Player.ParentChart as TCustomChart) do
       begin
         CBItem.Items.AddObject('Back',Walls.Back.Picture);
         CBItem.Items.AddObject('Bottom',Walls.Bottom.Picture);
         CBItem.Items.AddObject('Left',Walls.Left.Picture);
         CBItem.Items.AddObject('Right',Walls.Right.Picture);
       end;
  end;
end;

procedure TVideoPlayerEditor.FormDestroy(Sender: TObject);
begin
  if Assigned(Player) then
     Player.OnFrame:=OldOnFrame;
end;

procedure TVideoPlayerEditor.CBItemChange(Sender: TObject);
begin
  Player.Picture:=CBItem.SelectedObject as TTeePicture;
end;

procedure TVideoPlayerTool.SetPicture(const Value: TPicture);
begin
  if FPicture<>Value then
  begin
    if Assigned(FPicture) then
    begin
      FPicture.Assign(nil);
      FPicture.Bitmap.FreeImage;
    end;

    FPicture:=Value;
  end;
end;

procedure TVideoPlayerEditor.FormCreate(Sender: TObject);
begin
  OpenDialog1.Filter:=TeeMsg_AVIFile+'|*.avi|'+TeeMsg_MPEGFile+'|*.mpg';
end;

initialization
  RegisterTeeTools([TVideoPlayerTool]);
  RegisterClass(TVideoPlayerEditor);
finalization
  UnRegisterTeeTools([TVideoPlayerTool]);
end.

