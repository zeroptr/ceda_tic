{********************************************}
{   PrintPreview Form                        }
{   Copyright (c) 1996-2009 by David Berneda }
{********************************************}
unit TeePrevi;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     {$IFDEF LCL}
     LCLIntf,
     {$ELSE}
     Windows, Messages,
     {$ENDIF}
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QComCtrls,
     QPrinters, TeePenDlg,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls, Printers,
     Buttons,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     TeeProcs, TeCanvas, TeePreviewPanel, TeeNavigator, TeEngine, Chart;

type
  {$IFDEF LCL}
  TPrinterSetupDialog=class(TComponent)
  public
    procedure Execute;
  end;
  {$ENDIF}

  TChartPreview = class(TForm)
    Panel1: TPanel;
    CBPrinters: TComboFlat;
    Label1: TLabel;
    Panel2: TPanel;
    Orientation: TRadioGroup;
    GBMargins: TGroupBox;
    SETopMa: TEdit;
    SELeftMa: TEdit;
    SEBotMa: TEdit;
    SERightMa: TEdit;
    ChangeDetailGroup: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    UDLeftMa: TUpDown;
    UDTopMa: TUpDown;
    UDRightMa: TUpDown;
    UDBotMa: TUpDown;
    TeePreviewPanel1: TTeePreviewPanel;
    Resolution: TTrackBar;
    PanelMargins: TPanel;
    BReset: TButton;
    ShowMargins: TCheckBox;
    PanelOptions: TPanel;
    CBProp: TCheckBox;
    CBBitmap: TCheckBox;
    PanelClose: TPanel;
    BClose: TButton;
    Panel3: TPanel;
    BSetupPrinter: TButton;
    BPrint: TButton;
    procedure FormShow(Sender: TObject);
    procedure BSetupPrinterClick(Sender: TObject);
    procedure CBPrintersChange(Sender: TObject);
    procedure OrientationClick(Sender: TObject);
    procedure SETopMaChange(Sender: TObject);
    procedure SERightMaChange(Sender: TObject);
    procedure SEBotMaChange(Sender: TObject);
    procedure SELeftMaChange(Sender: TObject);
    procedure ShowMarginsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BResetClick(Sender: TObject);
    procedure BPrintClick(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure CBPropClick(Sender: TObject);
    procedure TeePreviewPanel1ChangeMargins(Sender: TObject;
      DisableProportional: Boolean; const NewMargins: TRect);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBBitmapClick(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
  private
    { Private declarations }
    ChangingMargins : Boolean;
    ChangingProp    : Boolean;
    OldMargins      : TRect;
    PageNavigator1  : TCustomTeeNavigator;

    procedure Navigator1ButtonClicked(Index: TTeeNavigateBtn);
    Procedure ResetMargins;
    Procedure CheckOrientation;
    procedure ChangeMargin(UpDown:TUpDown; Var APos:Integer; OtherSide:Integer);
  public
    PageNavigatorClass    : TTeePageNavigatorClass;
    
    PrinterSetupDialog1   : TPrinterSetupDialog;

    {$IFDEF CLR}
    Constructor Create(AOwner:TComponent); override;
    {$ENDIF}

    procedure HideCloseButton;
    Function PreviewPanel : TTeePreviewPanel;
  end;

Var TeeChangePaperOrientation:Boolean=True;

Procedure TeePreview(AOwner:TComponent; APanel:TCustomTeePanel);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Procedure TeePreview(AOwner:TComponent; APanel:TCustomTeePanel);
begin
  with TChartPreview.Create(AOwner) do
  try
    TeePreviewPanel1.Panel:=APanel;
    ShowModal;
  finally
    Free;
    APanel.Repaint;
  end;
end;

{$IFDEF LCL}
procedure TPrinterSetupDialog.Execute;
begin
  raise Exception.Create('Printer setup dialog is not implemented.');
end;
{$ENDIF}

{ TChartPreview }
{$IFDEF CLR}
Constructor TChartPreview.Create(AOwner:TComponent);
begin
  inherited;
  TeePreviewPanel1:=TTeePreviewPanel.Create(Self);
  Left:= 256;
  Top:= 190;

  {$IFNDEF CLR}  // Vcl.Forms bug
  ActiveControl := TeePreviewPanel1;
  {$ENDIF}

  AutoScroll:= False;
  Caption := 'TeeChart Print Preview';
  ClientHeight := 379;
  ClientWidth := 543;
  Color := clBtnFace;
  ParentFont := True;
  KeyPreview := True;
  Position := poScreenCenter;
  OnCreate := FormCreate;
  OnDestroy := FormDestroy;
  OnShow := FormShow;
  PixelsPerInch := 96;

  with TeePreviewPanel1 do
  begin
    Parent:=Self;
    Left:= 112;
    Top := 38;
    Width := 431;
    Height := 341;
    HelpContext := 1197;
    Shadow.Color := clGray;
    Shadow.HorizSize := 4;
    Shadow.VertSize := 4;
    OnChangeMargins := TeePreviewPanel1ChangeMargins;
    Gradient.Direction := gdFromTopLeft;
    Gradient.EndColor := clGray;
    Gradient.Visible := True;
    Align := alClient;
    TabOrder := 2;
  end;
end;
{$ENDIF}

Procedure TChartPreview.ResetMargins;
begin
  With TeePreviewPanel1 do
  if Assigned(Panel) then
  begin
    if Panel.PrintProportional and (Printer.Printers.Count>0) then
       Panel.PrintMargins:=Panel.CalcProportionalMargins;

    TeePreviewPanel1ChangeMargins(Self,False,Panel.PrintMargins);
    Invalidate;
  end;
end;

procedure TChartPreview.FormShow(Sender: TObject);
var tmpClass: TTeePageNavigatorClass;
begin
  tmpClass:=PageNavigatorClass;
  if Assigned(tmpClass) then
  begin
    PageNavigator1:=tmpClass.Create(Self);
    PageNavigator1.Parent:=Panel2;
    PageNavigator1.Align:=alBottom;
    PageNavigator1.HelpContext:=1488;
    PageNavigator1.OnButtonClicked:=Navigator1ButtonClicked;
  end;

  Screen.Cursor:=crDefault;

  if Tag<>{$IFDEF CLR}nil{$ELSE}0{$ENDIF} then
     TeePreviewPanel1.Panel:=TCustomTeePanel({$IFDEF CLR}TObject{$ENDIF}(Tag));

  CBPrinters.Items:=Printer.Printers;
  if Printer.Printers.Count>0 then
  begin
    {$IFDEF CLX}
    CBPrinters.ItemIndex:=0;
    {$ELSE}
    CBPrinters.ItemIndex:=Printer.PrinterIndex;
    {$ENDIF}

    {$IFNDEF TEEOCX}
    if TeeChangePaperOrientation then
       Printer.Orientation:=poLandscape;
    {$ENDIF}

    CheckOrientation;
  end
  else
  begin
    EnableControls(False,[BPrint,BSetupPrinter,Orientation]);
  end;

  With TeePreviewPanel1 do
  if Assigned(Panel) then
  begin
    CBProp.Checked:=Panel.PrintProportional;
    Resolution.Position:=Panel.PrintResolution+100;
    OldMargins:=Panel.PrintMargins;
    ResetMargins;

    if Assigned(PageNavigator1) then
       PageNavigator1.Panel:=Panel;  { 5.03 }
  end
  else
  begin
    CBProp.Enabled:=False;
    Resolution.Enabled:=False;
    GBMargins.Enabled:=False;
    BPrint.Enabled:=False;
  end;

  BReset.Enabled:=false;
  CBBitmap.Checked:=TeePreviewPanel1.AsBitmap;
  
  TeeTranslateControl(Self);
end;

procedure TChartPreview.BSetupPrinterClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
  CBPrinters.Items:=Printer.Printers;
  {$IFNDEF CLX}
  CBPrinters.ItemIndex:=Printer.PrinterIndex;
  {$ENDIF}
  CheckOrientation;
  TeePreviewPanel1.Invalidate;
end;

procedure TChartPreview.CBPrintersChange(Sender: TObject);
begin
  {$IFNDEF CLX}
  Printer.PrinterIndex:=CBPrinters.ItemIndex;
  {$ENDIF}
  CheckOrientation;
  OrientationClick(Self);
end;

procedure TChartPreview.OrientationClick(Sender: TObject);
begin
  Printer.Orientation:=TPrinterOrientation(Orientation.ItemIndex);
  ResetMargins;
  TeePreviewPanel1.Invalidate;
end;

procedure TChartPreview.ChangeMargin(UpDown:TUpDown; Var APos:Integer; OtherSide:Integer);
var tmpR : TRect;
begin
  if Showing then
  begin
    if UpDown.Position+OtherSide<100 then
    begin
      APos:=UpDown.Position;
      
      if not ChangingMargins then
      With TeePreviewPanel1 do
      Begin
        Invalidate;

        tmpR:=Panel.PrintMargins;
        CBProp.Checked:=False;
      end;
      BReset.Enabled:=not EqualRect(tmpR,OldMargins);
    end
    else UpDown.Position:=APos;
  end;
end;

procedure TChartPreview.SETopMaChange(Sender: TObject);
var R: TRect;
begin
  if Showing then
  begin
    R:=TeePreviewPanel1.Panel.PrintMargins;
    ChangeMargin(UDTopMa,R.Top,R.Bottom);
    TeePreviewPanel1.Panel.PrintMargins:=R;
  end;
end;

procedure TChartPreview.SERightMaChange(Sender: TObject);
var R: TRect;
begin
  if Showing then
  begin
    R:=TeePreviewPanel1.Panel.PrintMargins;
    ChangeMargin(UDRightMa,R.Right,R.Left);
    TeePreviewPanel1.Panel.PrintMargins:=R;
  end;
end;

procedure TChartPreview.SEBotMaChange(Sender: TObject);
var R: TRect;
begin
  if Showing then
  begin
    R:=TeePreviewPanel1.Panel.PrintMargins;
    ChangeMargin(UDBotMa,R.Bottom,R.Top);
    TeePreviewPanel1.Panel.PrintMargins:=R;
  end;
end;

procedure TChartPreview.SELeftMaChange(Sender: TObject);
var R: TRect;
begin
  if Showing then
  begin
    R:=TeePreviewPanel1.Panel.PrintMargins;
    ChangeMargin(UDLeftMa,R.Left,R.Right);
    TeePreviewPanel1.Panel.PrintMargins:=R;
  end;
end;

procedure TChartPreview.ShowMarginsClick(Sender: TObject);
begin
  TeePreviewPanel1.Margins.Visible:=ShowMargins.Checked;
end;

procedure TChartPreview.FormCreate(Sender: TObject);
begin
  ChangingMargins:=True;
  ChangingProp:=False;
  PrinterSetupDialog1:=TPrinterSetupDialog.Create(Self);
end;

procedure TChartPreview.BResetClick(Sender: TObject);
begin
  With TeePreviewPanel1 do
  Begin
    Panel.PrintMargins:=OldMargins;
    TeePreviewPanel1ChangeMargins(Self,False,Panel.PrintMargins);
    Invalidate;
  end;
  
  BReset.Enabled:=False;
end;

Procedure TChartPreview.CheckOrientation;
Begin
  Orientation.ItemIndex:=Ord(Printer.Orientation);
End;

procedure TChartPreview.BPrintClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    if Assigned(PageNavigator1) and (PageNavigator1.PageCount>1) then
       PageNavigator1.Print
    else
       TeePreviewPanel1.Print;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TChartPreview.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TChartPreview.CBPropClick(Sender: TObject);
begin
  if not ChangingProp then
  begin
    TeePreviewPanel1.Panel.PrintProportional:=CBProp.Checked;
    ResetMargins;
    BReset.Enabled:=not CBProp.Checked;
  end;
end;

procedure TChartPreview.TeePreviewPanel1ChangeMargins(Sender: TObject;
  DisableProportional: Boolean; const NewMargins: TRect);
begin
  ChangingMargins:=True;
  try
    UDLeftMa.Position :=NewMargins.Left;
    UDRightMa.Position:=NewMargins.Right;
    UDTopMa.Position  :=NewMargins.Top;
    UDBotMa.Position  :=NewMargins.Bottom;
    if DisableProportional then
    begin
      TeePreviewPanel1.Panel.PrintProportional:=False;
      ChangingProp:=True;
      CBProp.Checked:=False;
      ChangingProp:=False;
    end;
  finally
    ChangingMargins:=False;
  end;
end;

procedure TChartPreview.Navigator1ButtonClicked(Index: TTeeNavigateBtn);
begin
  TeePreviewPanel1.Invalidate;
end;

procedure TChartPreview.TrackBar1Change(Sender: TObject);
begin
  With TeePreviewPanel1 do
  Begin
    Panel.PrintResolution:=Resolution.Position-100;
    Invalidate;
  end;
end;

function TChartPreview.PreviewPanel: TTeePreviewPanel;
begin
  result:=TeePreviewPanel1;
end;

procedure TChartPreview.FormDestroy(Sender: TObject);
begin
  PrinterSetupDialog1.Free;
  PageNavigator1.Free; { 5.02 }
end;

procedure TChartPreview.CBBitmapClick(Sender: TObject);
begin
  TeePreviewPanel1.AsBitmap:=CBBitmap.Checked;
end;

procedure TChartPreview.HideCloseButton;
begin
  PanelClose.Hide;
end;

procedure TChartPreview.Panel1Resize(Sender: TObject);
begin
  CBPrinters.Width:=Panel3.Left-CBPrinters.Left;
end;

end.
