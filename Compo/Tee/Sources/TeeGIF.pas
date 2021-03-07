{**********************************************}
{   TeeChart GIF Export format                 }
{   Copyright (c) 2000-2009 by David Berneda   }
{**********************************************}
unit TeeGIF;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, QForms, QStdCtrls, QExtCtrls, QControls,
     {$ELSE}
     Graphics, Forms, Controls, StdCtrls, ExtCtrls,
     {$IFDEF D9}
     Types,
     {$ENDIF}
     {$ENDIF}
     {$IFNDEF CLX}

     {$IFNDEF CLR}
     {$IFDEF D105}
     GIFImg,    // <-- New (2007) GIFImage unit, included in Delphi2007 and up.
     {$ELSE}
     GIFImage,  // <-- "old" GIFImage unit 
     {$ENDIF}
     {$ENDIF}

     {$ENDIF}
     TeeProcs, TeeExport, TeCanvas;

type
  {$IFDEF CLX}
  TGIFImage=TBitmap;
  TDitherMode=Integer;
  {$ENDIF}

  TTeeGIFOptions = class(TForm)
    RGCompression: TRadioGroup;
    Label1: TLabel;
    CBDither: TComboFlat;
    Label2: TLabel;
    CBReduction: TComboFlat;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  {$IFDEF CLR}
  TGIFCompression=Integer;
  TDitherMode=Integer;
  TColorReduction=( rmNone,
                    rmWindows20,
                    rmWindows256,
                    rmWindowsGray,
                    rmMonochrome,
                    rmGrayScale,
                    rmNetscape,
                    rmQuantize,
                    rmQuantizeWindows,
                    rmPalette);


  TGIFImage=class(TBitmap)
  private
    FCompression:TGIFCompression;
    FDitherMode:TDitherMode;
    FColorReduction:TColorReduction;
  public
    property Compression:TGIFCompression read FCompression write FCompression;
    property DitherMode:TDitherMode read FDitherMode write FDitherMode;
    property ColorReduction:TColorReduction read FColorReduction write FColorReduction;
  end;
  {$ENDIF}

  TGIFExportFormat=class(TTeeExportFormat)
  private
    Procedure CheckProperties;
  protected
    FProperties : TTeeGIFOptions;
    Procedure DoCopyToClipboard; override;
  public
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    function GraphicClass:TGraphicClass; override;
    Function GIF:TGIFImage;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFDEF CLX}
     QClipbrd,
     {$ELSE}
     Clipbrd,
     {$ENDIF}
     SysUtils, TeeConst;

const
  GIFImageDefaultDitherMode:TDitherMode=TDitherMode(0);

function TGIFExportFormat.Description:String;
begin
  result:=TeeMsg_AsGIF;
end;

function TGIFExportFormat.FileFilter:String;
begin
  result:=TeeMsg_GIFFilter;
end;

function TGIFExportFormat.FileExtension:String;
begin
  result:='gif'; // Do not localize
end;

Function TGIFExportFormat.GIF:TGIFImage;
var tmpBitmap : TBitmap;
begin
  CheckProperties;
  CheckSize;

  result:=TGIFImage.Create;
  with result do
  begin
    {$IFNDEF CLX}

    {$IFNDEF D105}  // Not included in D2007

    // See: http://www.unisys.com/about__unisys/lzw
    Compression:=TGIFCompression(FProperties.RGCompression.ItemIndex); // 7.01

    {$ENDIF}

    DitherMode:=TDitherMode(FProperties.CBDither.ItemIndex);
    ColorReduction:=TColorReduction(FProperties.CBReduction.ItemIndex);
    {$ENDIF}

    tmpBitmap:=Panel.TeeCreateBitmap(Panel.Color,TeeRect(0,0,Self.Width,Self.Height));
    try
      Assign(tmpBitmap); { 5.01 }
    finally
      tmpBitmap.Free;
    end;
  end;
end;

Procedure TGIFExportFormat.CheckProperties;
begin
  if not Assigned(FProperties) then
  begin
    FProperties:=TTeeGIFOptions.Create(nil);
    FProperties.FormShow(Self);
  end;
end;

Function TGIFExportFormat.Options(Check:Boolean=True):TForm;
begin
  if Check then CheckProperties;
  result:=FProperties;
end;

procedure TGIFExportFormat.DoCopyToClipboard;
var tmp : TGIFImage;
begin
  tmp:=GIF;
  try
    Clipboard.Assign(tmp);
  finally
    tmp.Free;
  end;
end;

procedure TGIFExportFormat.SaveToStream(Stream:TStream);
begin
  With GIF do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

procedure TTeeGIFOptions.FormShow(Sender: TObject);
begin
  {$IFDEF CLX}
  CBDither.ItemIndex:=0;
  CBReduction.ItemIndex:=0;
  {$ELSE}
  CBDither.ItemIndex:=Ord(GIFImageDefaultDitherMode);
  CBReduction.ItemIndex:=Ord(rmQuantizeWindows);
  {$ENDIF}

  {$IFNDEF CLX}
  {$IFNDEF CLR}

  {$IFNDEF D105}  // Not included in D2007

  // GIF LZW Unisys Patent expiration dates:
  // http://www.unisys.com/about__unisys/lzw
  RGCompression.ItemIndex:=Ord(GIFImageDefaultCompression);

  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
end;

procedure TTeeGIFOptions.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

function TGIFExportFormat.GraphicClass: TGraphicClass;
begin
  result:=TGIFImage;
end;

initialization
  RegisterTeeExportFormat(TGIFExportFormat);
finalization
  UnRegisterTeeExportFormat(TGIFExportFormat);
end.
