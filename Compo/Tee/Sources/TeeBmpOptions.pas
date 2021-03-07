{*******************************************}
{ TeeChart Pro Bitmap exporting             }
{ Copyright (c) 1995-2009 by David Berneda  }
{         All Rights Reserved               }
{*******************************************}
unit TeeBmpOptions;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, Types, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,
  {$IFDEF D9}
  Types,
  {$ENDIF}
  {$ENDIF}
  TeeProcs, TeeExport, TeCanvas, TeeFilters;

type
  TBMPExportFormat=class;

  TBMPOptions = class(TForm)
    CBMono: TCheckBox;
    Label1: TLabel;
    CBColors: TComboFlat;
    Button1: TButton;
    GroupBox1: TGroupBox;
    ImageFiltered1: TImageFiltered;
    procedure CBMonoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBColorsChange(Sender: TObject);
  private
    { Private declarations }
    procedure Preview;
  protected
    IFormat : TBMPExportFormat;
  public
    { Public declarations }
  end;

  TBMPExportFormat=class(TTeeExportFormat)
  private
    FFilters   : TFilterItems;
    FProperties: TBMPOptions;

    Procedure CheckProperties;
    function InternalGetBitmap:TBitmap;
  protected
    Procedure DoCopyToClipboard; override;
  public
    Constructor Create; override;
    Destructor Destroy; override;

    Function Bitmap:TBitmap;
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    function GraphicClass:TGraphicClass; override;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;

Procedure TeeSaveToBitmap( APanel:TCustomTeePanel;
                           Const FileName: WideString;
                           Const R:TRect);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFDEF CLX}
     QClipbrd,
     {$ELSE}
     Clipbrd,
     {$ENDIF}
     TeeConst, TeeFiltersEditor;

procedure TBMPOptions.CBMonoClick(Sender: TObject);
begin
  CBColors.Enabled:=not CBMono.Checked;
  Preview;
end;

function TBMPExportFormat.Description:String;
begin
  result:=TeeMsg_AsBMP;
end;

function TBMPExportFormat.FileFilter:String;
begin
  result:=TeeMsg_BMPFilter;
end;

function TBMPExportFormat.FileExtension:String;
begin
  result:='bmp'; // Do not localize
end;

Function TBMPExportFormat.Bitmap:TBitmap;
begin
  CheckProperties;
  result:=InternalGetBitmap;
  FFilters.ApplyTo(result);
end;

function TBMPExportFormat.InternalGetBitmap:TBitmap;
var R   : TRect;
    Old : Boolean;
begin
  result:=TBitmap.Create;
  CheckSize;

  TeeSetBitmapSize(result,Width,Height);

  result.Monochrome:=FProperties.CBMono.Checked;

  {$IFNDEF CLX}
  if not FProperties.CBMono.Checked then
     result.PixelFormat:=TPixelFormat(FProperties.CBColors.ItemIndex);
  {$ENDIF}

  if Panel.Canvas.SupportsFullRotation then
     result.PixelFormat:=TeePixelFormat;

  R:=TeeRect(0,0,result.Width,result.Height);

  with result do
  begin
    Canvas.Brush.Color:=Panel.Color;
    Canvas.FillRect(R);
    Old:=Panel.BufferedDisplay;
    Panel.BufferedDisplay:=False;
    Panel.Draw(Canvas,R);
    Panel.BufferedDisplay:=Old;
  end;
end;

Procedure TBMPExportFormat.CheckProperties;
begin
  if not Assigned(FProperties) then
  begin
    FProperties:=TBMPOptions.Create(nil);
    FProperties.IFormat:=Self;
  end;
end;

Function TBMPExportFormat.Options(Check:Boolean=True):TForm;
begin
  if Check then CheckProperties;
  result:=FProperties;
end;

procedure TBMPExportFormat.DoCopyToClipboard;
var tmp : TBitmap;
begin
  tmp:=Bitmap;
  try
    Clipboard.Assign(tmp);
  finally
    tmp.Free;
  end;
end;

procedure TBMPExportFormat.SaveToStream(Stream:TStream);
begin
  with Bitmap do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

function TBMPExportFormat.GraphicClass: TGraphicClass;
begin
  result:=TBitmap;
end;

constructor TBMPExportFormat.Create;
begin
  inherited;
  FFilters:=TFilterItems.Create(nil,TTeeFilter);
end;

destructor TBMPExportFormat.Destroy;
begin
  FFilters.Free;
  inherited;
end;

Procedure TeeSaveToBitmap( APanel:TCustomTeePanel;
                           Const FileName: WideString;
                           Const R:TRect);
begin
  with TBMPExportFormat.Create do
  try
    Panel:=APanel;
    Width:=R.Right-R.Left;
    Height:=R.Bottom-R.Top;
    SaveToFile(FileName);
  finally
    Free;
  end;
end;

procedure TBMPOptions.FormCreate(Sender: TObject);
begin
  CBColors.ItemIndex:=0;
end;

procedure TBMPOptions.FormShow(Sender: TObject);
begin
  CBColors.ItemIndex:=0;
  Preview;
end;

procedure TBMPOptions.Preview;
var tmp : TBitmap;
begin
  if Assigned(IFormat) then
  begin
    tmp:=IFormat.Bitmap;

    try
      ImageFiltered1.Picture.Graphic:=tmp;
    finally
      tmp.Free;
    end;
  end;
end;

procedure TBMPOptions.Button1Click(Sender: TObject);
begin
  if ShowFiltersEditor(Self, IFormat.InternalGetBitmap, IFormat.FFilters) then
     Preview;
end;

procedure TBMPOptions.CBColorsChange(Sender: TObject);
begin
  Preview;
end;

initialization
  RegisterTeeExportFormat(TBMPExportFormat);
finalization
  UnRegisterTeeExportFormat(TBMPExportFormat);
end.

