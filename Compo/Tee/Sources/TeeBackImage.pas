{**********************************************}
{  TBackImage editor dialog                    }
{  Copyright (c) 2006-2009 by David Berneda    }
{**********************************************}
unit TeeBackImage;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QComCtrls, QStdCtrls, QExtCtrls,
  QButtons,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons,
  {$ENDIF}
  TeeProcs, TeCanvas, TeeFilters;

type
  TBackImageEditor = class(TForm)
    RGBitmap: TRadioGroup;
    BBrowse: TButton;
    CBTransp: TCheckBox;
    Button1: TButton;
    Bevel1: TBevel;
    Image1: TImage;
    GBPosition: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    ELeft: TEdit;
    UDLeft: TUpDown;
    ETop: TEdit;
    UDTop: TUpDown;
    LabelSize: TLabel;
    LabelExt: TLabel;
    PanelButtons: TPanel;
    Button2: TButton;
    Button3: TButton;
    procedure RGBitmapClick(Sender: TObject);
    procedure BBrowseClick(Sender: TObject);
    procedure CBTranspClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ELeftChange(Sender: TObject);
    procedure ETopChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Image : TTeePicture;

    procedure EnableImageControls;
    procedure SetBrowseCaption;
  public
    { Public declarations }
    Procedure RefreshControls(AImage:TTeePicture);
  end;

Function InsertImageEditor(ATab:TTabSheet):TBackImageEditor;

function EditTeePicture(AOwner:TComponent; APicture:TTeePicture):Boolean;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeePenDlg, TeeConst, TeeBrushDlg, TeeFiltersEditor;

Function InsertImageEditor(ATab:TTabSheet):TBackImageEditor;
begin
  // Speed optimization, pass "nil" as owner.
  result:=TBackImageEditor.Create(nil {ATab.Owner});
  AddFormTo(result,ATab);
end;

function EditTeePicture(AOwner:TComponent; APicture:TTeePicture):Boolean;
begin
  with TBackImageEditor.Create(AOwner) do
  try
    PanelButtons.Show;
    RefreshControls(APicture);
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

Procedure TBackImageEditor.RefreshControls(AImage:TTeePicture);
begin
  Image:=AImage;

  if Image is TBackImage then
  begin
    RGBitmap.ItemIndex     :=Ord(TBackImage(Image).Mode);
    UDLeft.Position        :=TBackImage(Image).Left;
    UDTop.Position         :=TBackImage(Image).Top;
  end;

  EnableImageControls;

  CBTransp.Enabled:=Assigned(Image.Graphic);
  CBTransp.Checked:=CBTransp.Enabled and Image.Graphic.Transparent;
end;

procedure TBackImageEditor.RGBitmapClick(Sender: TObject);
begin
  TBackImage(Image).Mode:=TTeeBackImageMode(RGBitmap.ItemIndex);
  EnableImageControls;
end;

procedure TBackImageEditor.EnableImageControls;
begin
  RGBitmap.Enabled:=Assigned(Image.Graphic);

//  CBImageInside.Enabled:=RGBitmap.Enabled;

  if CBTransp.Visible then
  begin
    CBTransp.Enabled:=RGBitmap.Enabled;
    CBTransp.Checked:=CBTransp.Enabled and Image.Graphic.Transparent;
  end;

  if not (Image is TBackImage) then
  begin
    RGBitmap.Hide;
    GBPosition.Hide;
  end
  else
    EnableControls(TBackImage(Image).Mode=pbmCustom, [ELeft,ETop,UDLeft,UDTop]);

  LabelExt.Visible:=RGBitmap.Enabled;
  LabelSize.Visible:=RGBitmap.Enabled;

  if LabelSize.Visible then
  begin
    LabelSize.Caption:=IntToStr(Image.Width)+'x'+IntToStr(Image.Height); // Do not localize
    LabelExt.Caption:=GraphicExtension(TGraphicClass(Image.Graphic.ClassType));
  end;

  SetBrowseCaption;
end;

procedure TBackImageEditor.SetBrowseCaption;
begin
  Image1.Picture.Assign(Image.Filtered);

  if Assigned(Image.Graphic) then
     BBrowse.Caption:=TeeMsg_ClearImage
  else
     BBrowse.Caption:=TeeMsg_BrowseImage;
end;

procedure TBackImageEditor.BBrowseClick(Sender: TObject);
begin
  if Assigned(Image.Graphic) then
     Image.Graphic:=nil
  else
     TeeLoadClearImage(Self,Image);

  SetBrowseCaption;

  EnableImageControls;
end;

procedure TBackImageEditor.CBTranspClick(Sender: TObject);
begin
  if CBTransp.Enabled then
     Image.Graphic.Transparent:=CBTransp.Checked;
end;

procedure TBackImageEditor.Button1Click(Sender: TObject);
begin
  if ShowFiltersEditor(Self,Image) then
  begin
    Image.Repaint;
    SetBrowseCaption;
  end;
end;

procedure TBackImageEditor.ELeftChange(Sender: TObject);
begin
  if Showing then
     TBackImage(Image).Left:=UDLeft.Position;
end;

procedure TBackImageEditor.ETopChange(Sender: TObject);
begin
  if Showing then
     TBackImage(Image).Top:=UDTop.Position;
end;

procedure TBackImageEditor.FormShow(Sender: TObject);
begin
  if Assigned(Image) then
     RefreshControls(Image);

  TeeTranslateControl(Self);
end;

end.
