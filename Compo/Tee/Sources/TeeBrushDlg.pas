{******************************************}
{    TeeChart. TBrushDialog                }
{ Copyright (c) 1996-2009 by David Berneda }
{******************************************}
unit TeeBrushDlg;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, Types,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
     {$ENDIF}
     {$IFDEF LCL}
     Buttons,
     {$ENDIF}
     TeCanvas, TeePenDlg;

type
  TBrushDialog = class(TForm)
    LStyle: TListBox;
    PanelOk: TPanel;
    Button2: TButton;
    Button3: TButton;
    Panel1: TPanel;
    ImageMetal: TImage;
    ImageWood: TImage;
    ImageStone: TImage;
    ImageClouds: TImage;
    ImageGrass: TImage;
    ImageFire: TImage;
    ImageSnow: TImage;
    BColor: TButtonColor;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Button1: TButton;
    BBackColor: TButtonColor;
    CBTransp: TCheckBox;
    Splitter1: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LStyleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBTranspClick(Sender: TObject);
    procedure BBackColorClick(Sender: TObject);
    {$IFDEF CLX}
    procedure LStyleDrawItem(Sender: TObject; Index: Integer;
        Rect: TRect;  State: TOwnerDrawState; var Handled: Boolean);
    {$ELSE}
    procedure LStyleDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    {$ENDIF}
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    BackupBrush : TChartBrush;
    Procedure CheckImageButton;
    Function GetInternalBrush(Index:Integer):TBitmap;
    procedure RedrawShape;
  public
    { Public declarations }
    TheBrush : TChartBrush;
  end;

Function EditChartBrush( AOwner:TComponent;
                          ChartBrush:TChartBrush):Boolean;

Function EditTeeFont(AOwner:TComponent; AFont:TFont):Boolean;

Function TeeGetPictureFileName(AOwner:TComponent):String;

procedure TeeLoadClearImage(AOwner:TComponent; AImage:TPicture);

Procedure GetTeeBrush(Index:Integer; ABitmap:TBitmap);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$IFDEF CLR}
{$R 'TeeBrush1.bmp'} // Do not localize
{$R 'TeeBrush2.bmp'} // Do not localize
{$R 'TeeBrush3.bmp'} // Do not localize
{$R 'TeeBrush4.bmp'} // Do not localize
{$R 'TeeBrush5.bmp'} // Do not localize
{$R 'TeeBrush6.bmp'} // Do not localize
{$R 'TeeBrush7.bmp'} // Do not localize
{$R 'TeeBrush8.bmp'} // Do not localize
{$R 'TeeBrush9.bmp'} // Do not localize
{$R 'TeeBrush10.bmp'} // Do not localize
{$R 'TeeBrush11.bmp'} // Do not localize
{$R 'TeeBrush12.bmp'} // Do not localize

{$ELSE}
{$R TeeBrushes.res}
{$ENDIF}

Uses {$IFNDEF CLX}
     ExtDlgs,
     {$ENDIF}
     {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeeConst, TeeProcs;

Function EditTeeFont(AOwner:TComponent; AFont:TFont):Boolean;
Begin
  result:=False;
  With TFontDialog.Create(AOwner) do
  try
    Font.Assign(AFont);
    if Execute then
    begin
      AFont.Assign(Font);
      result:=True;
    end;
  finally
    Free;
  end;
end;

Function EditChartBrush( AOwner:TComponent;
                         ChartBrush:TChartBrush):Boolean;
var tmp : TBrushDialog;
Begin
  tmp:=TeeCreateForm(TBrushDialog,AOwner) as TBrushDialog;
  with tmp do
  try
    TheBrush:=ChartBrush;
    TeeTranslateControl(tmp);
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

Function TeeGetPictureFileName(AOwner:TComponent):String;
begin
  result:='';

  With {$IFDEF CLX}TOpenDialog{$ELSE}TOpenPictureDialog{$ENDIF}.Create(AOwner) do
  try
    {$IFDEF CLX}
    DefaultExt:='bmp';  // Do not localize

    Filter:='All (*.bmp; *.ico; *.png; *.xpm)|Bitmaps (*.bmp)|Icons (*.ico)|'+
            'Portable Network Graphics (*.png)|X Pixmaps (*.xpm)';

    Options:=[ofAllowMultiSelect];

    Title:='Add Images';
    {$ENDIF}
    if Execute then result:=FileName;
  finally
    Free;
  end;
end;

procedure TeeLoadClearImage(AOwner:TComponent; AImage:TPicture);
var tmp : String;
begin
  if Assigned(AImage.Graphic) then AImage.Assign(nil)
  else
  begin
    tmp:=TeeGetPictureFileName(AOwner);

    if tmp<>'' then
       AImage.LoadFromFile(tmp);
  end;
end;

{ TBrushDialog }
procedure TBrushDialog.RedrawShape;
begin
  BColor.Enabled:=TheBrush.Style<>bsClear;
  BBackColor.Enabled:=BColor.Enabled;

  CBTransp.Checked:=TheBrush.BackColor=clNone;
  CBTransp.Enabled:=not CBTransp.Checked;
end;

procedure TBrushDialog.FormShow(Sender: TObject);
begin
  if not Assigned(BackupBrush) then
     BackupBrush:=TChartBrush.Create(nil);

  if Assigned(TheBrush) then
  begin
    BackupBrush.Assign(TheBrush);

    if Assigned(TheBrush.Image.Graphic) then
       LStyle.ItemIndex:=-1
    else
       LStyle.ItemIndex:=Ord(TheBrush.Style);

    BColor.LinkProperty(TheBrush,'Color'); // Do not localize
    BBackColor.LinkProperty(TheBrush,'BackColor'); // Do not localize

    CheckImageButton;
    RedrawShape;
  end;
end;

procedure TBrushDialog.Button3Click(Sender: TObject);
begin
  if Assigned(TheBrush) then
     TheBrush.Assign(BackupBrush);

  ModalResult:=mrCancel;
end;

procedure TBrushDialog.Button1Click(Sender: TObject);
var tmp       : String;
    tmpBitmap : TBitmap;
begin
  LStyle.ItemIndex:=Ord(TheBrush.Style);

  if Button1.Tag=1 then
  begin
    TheBrush.Image.Assign(nil);
    TheBrush.Bitmap.Free;
    TheBrush.Bitmap:=nil;
  end
  else
  begin
    tmp:=TeeGetPictureFileName(Self);

    if tmp<>'' then
    begin
      TheBrush.Image.LoadFromFile(tmp);

      if not (TheBrush.Image.Graphic is TBitmap) then
      begin
        tmpBitmap:=TBitmap.Create;
        TeeSetBitmapSize(tmpBitmap,TheBrush.Image.Width,TheBrush.Image.Height);

        tmpBitmap.Canvas.Draw(0,0,TheBrush.Image.Graphic);

        TheBrush.Image.Bitmap:=tmpBitmap; // 5.03
      end;
    end;
  end;

  CheckImageButton;
end;

Procedure TBrushDialog.CheckImageButton;

  procedure SetImage(Source:TPersistent);
  begin
    Button1.Tag:=1;
    Button1.Caption:=TeeMsg_ClearImage;
    Image1.Picture.Assign(Source);
  end;

begin
  if Assigned(TheBrush.Image.Graphic) then
     SetImage(TheBrush.Image)
  else
  if Assigned(TheBrush.Bitmap) then
     SetImage(TheBrush.Bitmap)
  else
  begin
    Button1.Tag:=0;
    Button1.Caption:=TeeMsg_BrowseImage;
    Image1.Picture:=nil;
  end;
end;

procedure TBrushDialog.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

{$IFDEF CLX}
procedure TBrushDialog.LStyleDrawItem(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
{$ELSE}
procedure TBrushDialog.LStyleDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ENDIF}
Var Old : TColor;
    tmp : TBitmap;
begin
  With TControlCanvas(LStyle.Canvas) do
  begin
    FillRect(Rect);

    if Index<>1 then
    begin
      if Index<=7 then
      begin
        Brush.Style:=TBrushStyle(Index);
        Brush.Color:=clBlack;
      end;

      {$IFDEF CLX}
      Old:=Font.Color;
      Font.Color:=clBlack;
      {$ELSE}
      SetBkColor(Handle,clWhite);
      SetBkMode(Handle,Transparent);
      Old:=GetTextColor(Handle);
      SetTextColor(Handle,clBlack);
      {$ENDIF}

      with Rect do Rect:=TeeRect(Left+2,Top+2,Left+16,Bottom-2);

      if Index>7 then
      begin
        tmp:=GetInternalBrush(Index-8);
        try
          StretchDraw(Rect,tmp);
        finally
          tmp.Free;
        end;
      end
      else
         FillRect(Rect);

      {$IFDEF CLX}
      Font.Color:=Old;
      {$ELSE}
      Brush.Bitmap.Free;
      SetTextColor(Handle,Old);
      {$ENDIF}
    end;

    Brush.Style:=bsClear;

    {$IFDEF CLX}
    Font.Color:=clBlack;
    {$ELSE}
    {$IFDEF LCL}
    Font.Color:=clBlack;
    {$ELSE}
    UpdateTextFlags;
    {$ENDIF}
    {$ENDIF}

    TextOut(Rect.Left+20,Rect.Top,LStyle.Items[Index]);
  end;
end;

procedure TBrushDialog.CBTranspClick(Sender: TObject);
begin
  if CBTransp.Checked then
  begin
    TheBrush.BackColor:=clNone;
    BBackColor.Invalidate;
  end;

  CBTransp.Enabled:=not CBTransp.Checked;
end;

procedure TBrushDialog.BBackColorClick(Sender: TObject);
begin
  CBTransp.Checked:=False;
  CBTransp.Enabled:=True;
end;

procedure TBrushDialog.LStyleClick(Sender: TObject);
var tmpBitmap : TBitmap;
begin
  if LStyle.ItemIndex>7 then
  begin
    tmpBitmap:=GetInternalBrush(LStyle.ItemIndex-8);
    try
      TheBrush.Image.Graphic:=tmpBitmap;
    finally
      tmpBitmap.Free;
    end;
  end
  else
  begin
    TheBrush.Style:=TBrushStyle(LStyle.ItemIndex);
    TheBrush.Image:=nil;
  end;

  CheckImageButton;
  RedrawShape;
end;

Function TBrushDialog.GetInternalBrush(Index:Integer):TBitmap;
begin
  result:=TBitmap.Create;

  case Index of
    12: result.Assign(ImageMetal.Picture);
    13: result.Assign(ImageWood.Picture);
    14: result.Assign(ImageStone.Picture);
    15: result.Assign(ImageClouds.Picture);
    16: result.Assign(ImageGrass.Picture);
    17: result.Assign(ImageFire.Picture);
    18: result.Assign(ImageSnow.Picture);
  else
    GetTeeBrush(Index,result);
  end;
end;

Procedure GetTeeBrush(Index:Integer; ABitmap:TBitmap);

  function BrushFileName:String;
  begin
    result:='TeeBrush'+TeeStr(1+Index); // Do not localize
  end;

begin
  {$IFDEF CLR}
  TeeLoadBitmap(ABitmap,BrushFileName,'');
  {$ELSE}
  with ABitmap do
  begin
    LoadFromResourceName(HInstance,BrushFileName);
    TransparentMode:=tmFixed;
    TransparentColor:=clWhite;
  end;
  {$ENDIF}
end;

procedure TBrushDialog.FormDestroy(Sender: TObject);
begin
  BackupBrush.Free;
end;

end.
