{**********************************************}
{  TCustomChart (or derived) Editor Dialog     }
{  Copyright (c) 1996-2009 by David Berneda    }
{**********************************************}
unit TeeEdiPane;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     {$ENDIF}
     TeeProcs, TeeEdiGrad, TeCanvas, TeePenDlg;

type
  TFormTeePanel = class(TForm)
    PageControl1: TPageControl;
    TabBack: TTabSheet;
    TabBorders: TTabSheet;
    TabGradient: TTabSheet;
    L19: TLabel;
    L2: TLabel;
    SEPanelBor: TEdit;
    SEPanelWi: TEdit;
    UDPanelWi: TUpDown;
    UDPanelBor: TUpDown;
    BPanelColor: TButtonColor;
    TabShadow: TTabSheet;
    CBColorDef: TCheckBox;
    Label1: TLabel;
    ERound: TEdit;
    UDRound: TUpDown;
    CBInner: TComboFlat;
    Label2: TLabel;
    Label3: TLabel;
    CBOuter: TComboFlat;
    BBorder: TButtonPen;
    TabImage: TTabSheet;
    CBImageInside: TCheckBox;
    TabSheet1: TTabSheet;
    GBMargins: TGroupBox;
    Label5: TLabel;
    SETopMa: TEdit;
    SELeftMa: TEdit;
    SEBotMa: TEdit;
    SERightMa: TEdit;
    UDTopMa: TUpDown;
    UDRightMa: TUpDown;
    UDLeftMa: TUpDown;
    UDBotMa: TUpDown;
    CBMarUnits: TComboFlat;
    procedure SEPanelWiChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBImageInsideClick(Sender: TObject);
    procedure SEPanelBorChange(Sender: TObject);
    procedure BPanelColorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBColorDefClick(Sender: TObject);
    procedure ERoundChange(Sender: TObject);
    procedure CBInnerChange(Sender: TObject);
    procedure CBOuterChange(Sender: TObject);
    procedure CBMarUnitsChange(Sender: TObject);
    procedure SERightMaChange(Sender: TObject);
    procedure SETopMaChange(Sender: TObject);
    procedure SEBotMaChange(Sender: TObject);
    procedure SELeftMaChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
    Changing : Boolean;
    FGradientEditor : TTeeGradientEditor;

    procedure AdjustMarginMinMax;
    Function ChangeMargin(UpDown:TUpDown; APos,OtherSide:Integer):Integer;
    Procedure CheckColorDef;
  public
    { Public declarations }
    ThePanel : TCustomTeePanelExtended;

    Constructor CreatePanel(Owner:TComponent; APanel:TCustomTeePanelExtended);
    class function InsertAt(AOwner:TComponent; AParent:TWinControl;
                            APanel:TCustomTeePanelExtended):TFormTeePanel;
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses
  TeeBrushDlg, TeeShadowEditor, TeeConst, TeeFiltersEditor, TeeBackImage;

class function TFormTeePanel.InsertAt(AOwner:TComponent; AParent:TWinControl;
                                      APanel:TCustomTeePanelExtended):TFormTeePanel;
begin
  result:=TFormTeePanel.CreatePanel(AOwner,APanel);
  result.Align:=alClient;
  TeeTranslateControl(result);
  AddFormTo(result,AParent);
end;

{ TFormTeePanel }
Constructor TFormTeePanel.CreatePanel(Owner:TComponent; APanel:TCustomTeePanelExtended);
begin
  inherited Create(Owner);
  ThePanel:=APanel;
  Changing:=False;
  PageControl1.ActivePage:=TabBack;
end;

procedure TFormTeePanel.SEPanelWiChange(Sender: TObject);
begin
  if Showing then
  With ThePanel do
  if BevelWidth<>UDPanelWi.Position then
     BevelWidth:=UDPanelWi.Position;
end;

procedure TFormTeePanel.FormShow(Sender: TObject);
begin
  if Assigned(ThePanel) then
  begin
    With ThePanel do
    begin
      CBInner.ItemIndex      :=Ord(BevelInner);
      CBOuter.ItemIndex      :=Ord(BevelOuter);
      BBorder.LinkPen(Border);
      UDRound.Position       :=BorderRound;
      UDPanelWi.Position     :=BevelWidth;
      UDPanelBor.Position    :=BorderWidth;
      CBImageInside.Checked  :=BackImage.Inside;

      UDTopMa.Position       :=MarginTop;
      UDLeftMa.Position      :=MarginLeft;
      UDBotMa.Position       :=MarginBottom;
      UDRightMa.Position     :=MarginRight;
      CBMarUnits.ItemIndex   :=Ord(MarginUnits);

      AdjustMarginMinMax;

      CheckColorDef;
    end;

    BPanelColor.LinkProperty(ThePanel,'Color'); // Do not localize

    if Assigned(FGradientEditor) then
       FGradientEditor.Visible:=True;

    PageControl1.ActivePage:=TabBack;
  end;
end;

procedure TFormTeePanel.CBImageInsideClick(Sender: TObject);
begin
  ThePanel.BackImage.Inside:=CBImageInside.Checked;
end;

procedure TFormTeePanel.SEPanelBorChange(Sender: TObject);
begin
  if Showing then
  With ThePanel do
  if BorderWidth<>UDPanelBor.Position then BorderWidth:=UDPanelBor.Position;
end;

procedure TFormTeePanel.BPanelColorClick(Sender: TObject);
begin
  ThePanel.Repaint;
  CheckColorDef;
end;

procedure TFormTeePanel.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

Procedure TFormTeePanel.CheckColorDef;
begin
  Changing:=True;
  CBColorDef.Checked:=ThePanel.Color=clBtnFace;
  Changing:=False;
  CBColorDef.Enabled:=not CBColorDef.Checked;
end;

procedure TFormTeePanel.CBColorDefClick(Sender: TObject);
begin
  if not Changing then
  begin
    ThePanel.Color:=clBtnFace;
    CheckColorDef;
    BPanelColor.Invalidate;
  end;
end;

procedure TFormTeePanel.ERoundChange(Sender: TObject);
begin
  if Showing then
     ThePanel.BorderRound:=UDRound.Position;
end;

procedure TFormTeePanel.CBInnerChange(Sender: TObject);
begin
  if ThePanel.BevelInner<>TPanelBevel(CBInner.ItemIndex) then
     ThePanel.BevelInner:=TPanelBevel(CBInner.ItemIndex);
end;

procedure TFormTeePanel.CBOuterChange(Sender: TObject);
begin
  if ThePanel.BevelOuter<>TPanelBevel(CBOuter.ItemIndex) then
     ThePanel.BevelOuter:=TPanelBevel(CBOuter.ItemIndex);
end;

procedure TFormTeePanel.AdjustMarginMinMax;

  Procedure SetMinMax(Up:TUpDown);
  begin
    if ThePanel.MarginUnits=muPixels then
    begin
      Up.Min:=-2000;
      Up.Max:=2000;
    end
    else
    begin
      Up.Min:=0;
      Up.Max:=100;
    end;
  end;

begin
  SetMinMax(UDTopMa);
  SetMinMax(UDLeftMa);
  SetMinMax(UDRightMa);
  SetMinMax(UDBotMa);
end;

procedure TFormTeePanel.CBMarUnitsChange(Sender: TObject);
begin
  ThePanel.MarginUnits:=TTeeUnits(CBMarUnits.ItemIndex);
  AdjustMarginMinMax;
end;

procedure TFormTeePanel.SERightMaChange(Sender: TObject);
begin
  if Showing then
  with ThePanel do
       MarginRight:=ChangeMargin(UDRightMa,MarginRight,MarginLeft);
end;

Function TFormTeePanel.ChangeMargin(UpDown:TUpDown; APos,OtherSide:Integer):Integer;
begin
  result:=APos;

  if Showing then
  with UpDown do
  if (ThePanel.MarginUnits=muPixels) or (Position+OtherSide<100) then
     result:=Position
  else
     Position:=APos;
end;

procedure TFormTeePanel.SETopMaChange(Sender: TObject);
begin
  if Showing then
  with ThePanel do
       MarginTop:=ChangeMargin(UDTopMa,MarginTop,MarginBottom);
end;

procedure TFormTeePanel.SEBotMaChange(Sender: TObject);
begin
  if Showing then
  with ThePanel do
       MarginBottom:=ChangeMargin(UDBotMa,MarginBottom,MarginTop);
end;

procedure TFormTeePanel.SELeftMaChange(Sender: TObject);
begin
  if Showing then
  with ThePanel do
       MarginLeft:=ChangeMargin(UDLeftMa,MarginLeft,MarginRight);
end;

procedure TFormTeePanel.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage.ControlCount=0 then
     if PageControl1.ActivePage=TabGradient then
     begin
       FGradientEditor:=TTeeGradientEditor.CreateCustom(nil,ThePanel.Gradient);
       AddFormTo(FGradientEditor,TabGradient,ThePanel.Gradient);
     end
     else
     if PageControl1.ActivePage=TabShadow then
        InsertTeeShadowEditor(TabShadow).RefreshControls(ThePanel.Shadow)
     else
     if PageControl1.ActivePage=TabImage then
        InsertImageEditor(TabImage).RefreshControls(ThePanel.BackImage);
end;

end.

