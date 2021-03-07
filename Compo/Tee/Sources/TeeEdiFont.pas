{**********************************************}
{  TTeeFont (or derived) Editor Dialog         }
{  Copyright (c) 1999-2009 by David Berneda    }
{**********************************************}
unit TeeEdiFont;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
     {$ENDIF}
     {$IFDEF LCL}
     Buttons,
     {$ENDIF}
     TeeProcs, TeCanvas, TeePenDlg, TeeEdiGrad, TeeShadowEditor, TeeBackImage;

type
  TTeeFontEditor = class(TForm)
    PanelButtons: TPanel;
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button3: TButton;
    Label1: TLabel;
    ESize: TEdit;
    UDSize: TUpDown;
    GroupBox1: TGroupBox;
    CBItalic: TCheckBox;
    CBBold: TCheckBox;
    CBStrike: TCheckBox;
    CBUnder: TCheckBox;
    BColor: TButtonColor;
    Label2: TLabel;
    EInter: TEdit;
    UDInter: TUpDown;
    BOutline: TButtonPen;
    CBOutGrad: TCheckBox;
    TabShadow: TTabSheet;
    TabGradient: TTabSheet;
    Label3: TLabel;
    CBName: TComboFlat;
    TabPicture: TTabSheet;
    procedure BFontClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EInterChange(Sender: TObject);
    procedure CBOutGradClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ESizeChange(Sender: TObject);
    procedure CBItalicClick(Sender: TObject);
    procedure CBBoldClick(Sender: TObject);
    procedure CBStrikeClick(Sender: TObject);
    procedure CBUnderClick(Sender: TObject);
    procedure CBNameChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
    Backup,
    TheFont : TTeeFont;

    FGradientEditor : TTeeGradientEditor;
    FPicEditor      : TBackImageEditor;
    FShadowEditor   : TTeeShadowEditor;

    procedure CheckStyle(Check:TCheckBox; Value:TFontStyle);
    procedure RefreshBasicProps;
  public
    { Public declarations }
    procedure RefreshControls(AFont:TTeeFont);
  end;

Function InsertTeeFontEditor(ATab:TTabSheet):TTeeFontEditor;
function EditTeeFontEx(AOwner:TComponent; AFont:TTeeFont):Boolean;

type
  TTeeAddFontNames=Procedure(Items:TStrings);

var
  TeeAddFontNames:TTeeAddFontNames=nil;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeeConst, TeeBrushDlg;

Function InsertTeeFontEditor(ATab:TTabSheet):TTeeFontEditor;
begin
  // Speed optimization, pass "nil" as owner.
  result:=TTeeFontEditor.Create(nil {ATab.Owner});
  result.Align:=alClient;
  AddFormTo(result,ATab);
end;

function EditTeeFontEx(AOwner:TComponent; AFont:TTeeFont):Boolean;
begin
  with TTeeFontEditor.Create(AOwner) do
  try
    BorderStyle:=TeeBorderStyle;
    TheFont:=AFont;

    PanelButtons.Visible:=True;
    Height:=Height+PanelButtons.Height;

    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

procedure TTeeFontEditor.BFontClick(Sender: TObject);
begin
  EditTeeFont(Self,TheFont);

  BColor.Repaint;
  RefreshBasicProps;
end;

procedure TTeeFontEditor.RefreshBasicProps;
begin
  With TheFont do
  begin
    UDSize.Position:=Size;
    CBItalic.Checked:=fsItalic in Style;
    CBBold.Checked:=fsBold in Style;
    CBStrike.Checked:=fsStrikeOut in Style;
    CBUnder.Checked:=fsUnderline in Style;
    CBName.ItemIndex:=CBName.Items.IndexOf(Name);
  end;
end;

procedure TTeeFontEditor.RefreshControls(AFont:TTeeFont);
begin
  TheFont:=AFont;

  BColor.LinkProperty(TheFont,'Color'); // Do not localize
  RefreshBasicProps;

  With TheFont do
  begin
    UDInter.Position:=InterCharSize;
    BOutline.LinkPen(OutLine);
    CBOutGrad.Checked:=Gradient.Outline;

    if Assigned(FGradientEditor) then
       FGradientEditor.RefreshGradient(TheFont.Gradient);

    if Assigned(FShadowEditor) then
       FShadowEditor.RefreshControls(TheFont.Shadow);

    if Assigned(FPicEditor) then
       FPicEditor.RefreshControls(TheFont.Picture);
  end;
end;

procedure TTeeFontEditor.FormShow(Sender: TObject);
var tmpFirstTime : Boolean;
begin
  tmpFirstTime:=not Assigned(Backup);

  if tmpFirstTime then
     TeeTranslateControl(Self);

  if CBName.Items.Count=0 then
  begin
    CBName.Items:=Screen.Fonts;

    if Assigned(TeeAddFontNames) then  // used by TeeNumericGauge unit
       TeeAddFontNames(CBName.Items);
  end;

  if Assigned(TheFont) then
  begin
    RefreshControls(TheFont);

    if PanelButtons.Visible then
    begin
      if tmpFirstTime then
         Backup:=TTeeFont.Create(nil);

      Backup.Assign(TheFont);
    end;
  end;

  {$IFDEF CLX}
  EnableControls(False,[Label2,EInter,UDInter,BOutline]);
  {$ENDIF}
end;

procedure TTeeFontEditor.EInterChange(Sender: TObject);
begin
  if Showing and Assigned(TheFont) then
     TheFont.InterCharSize:=UDInter.Position;
end;

procedure TTeeFontEditor.CBOutGradClick(Sender: TObject);
begin
  TheFont.Gradient.Outline:=CBOutGrad.Checked;
end;

procedure TTeeFontEditor.FormCreate(Sender: TObject);
begin
  PanelButtons.Hide;
  Height:=Height-PanelButtons.Height;
end;

procedure TTeeFontEditor.Button2Click(Sender: TObject);
begin
  if Assigned(Backup) then
     TheFont.Assign(Backup);
end;

procedure TTeeFontEditor.FormDestroy(Sender: TObject);
begin
  Backup.Free;
end;

procedure TTeeFontEditor.ESizeChange(Sender: TObject);
begin
  if Showing then
     TheFont.Size:=UDSize.Position;
end;

procedure TTeeFontEditor.CheckStyle(Check:TCheckBox; Value:TFontStyle);
begin
  if Check.Checked then
     TheFont.Style:=TheFont.Style+[Value]
  else
     TheFont.Style:=TheFont.Style-[Value];
end;

procedure TTeeFontEditor.CBItalicClick(Sender: TObject);
begin
  CheckStyle(CBItalic,fsItalic);
end;

procedure TTeeFontEditor.CBBoldClick(Sender: TObject);
begin
  CheckStyle(CBBold,fsBold);
end;

procedure TTeeFontEditor.CBStrikeClick(Sender: TObject);
begin
  CheckStyle(CBStrike,fsStrikeOut);
end;

procedure TTeeFontEditor.CBUnderClick(Sender: TObject);
begin
  CheckStyle(CBUnder,fsUnderline);
end;

procedure TTeeFontEditor.CBNameChange(Sender: TObject);
begin
  TheFont.Name:=CBName.CurrentItem;
end;

procedure TTeeFontEditor.PageControl1Change(Sender: TObject);
begin
  if (PageControl1.ActivePage=TabShadow) and (not Assigned(FShadowEditor)) then
  begin
    FShadowEditor:=InsertTeeShadowEditor(TabShadow);

    if Assigned(TheFont) then
       FShadowEditor.RefreshControls(TheFont.Shadow);
  end
  else
  if (PageControl1.ActivePage=TabGradient) and (not Assigned(FGradientEditor)) then
  begin
    if Assigned(TheFont) then
    begin
      FGradientEditor:=TTeeGradientEditor.CreateCustom(Self,TheFont.Gradient);
      AddFormTo(FGradientEditor,TabGradient);
    end;
  end
  else
  if (PageControl1.ActivePage=TabPicture) and (not Assigned(FPicEditor)) then
  begin
    FPicEditor:=InsertImageEditor(TabPicture);
    FPicEditor.RGBitmap.Hide;
    FPicEditor.GBPosition.Hide;

    if Assigned(TheFont) then
       FPicEditor.RefreshControls(TheFont.Picture);
  end;
end;

end.
