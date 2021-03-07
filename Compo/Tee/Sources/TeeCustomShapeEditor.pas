{**********************************************}
{  TChartObject (or derived) Editor Dialog     }
{  Copyright (c) 1999-2009 by David Berneda    }
{**********************************************}
unit TeeCustomShapeEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls,
     {$ENDIF}
     {$IFDEF LCL}
     Buttons,
     {$ENDIF}
     TeeProcs, TeeEdiGrad, TeeEdiFont, TeCanvas, TeePenDlg, TeeShadowEditor,
     TeeBackImage;

type
  TFormTeeShape = class(TForm)
    PC1: TPageControl;
    TabFormat: TTabSheet;
    BBackColor: TButtonColor;
    Button6: TButton;
    CBTransparent: TCheckBox;
    TabGradient: TTabSheet;
    TabText: TTabSheet;
    TabShadow: TTabSheet;
    Label4: TLabel;
    EShadowTransp: TEdit;
    UDShadowTransp: TUpDown;
    TabImage: TTabSheet;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    CBBevel: TComboFlat;
    EBevWidth: TEdit;
    UDBevW: TUpDown;
    GroupBox1: TGroupBox;
    CBRound: TCheckBox;
    Label1: TLabel;
    ERoundSize: TEdit;
    UDRoundSize: TUpDown;
    Button4: TButtonPen;
    procedure BColorClick(Sender: TObject);
    procedure CBRoundClick(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBTransparentClick(Sender: TObject);
    procedure CBBevelChange(Sender: TObject);
    procedure EBevWidthChange(Sender: TObject);
    procedure EShadowTranspChange(Sender: TObject);
    procedure CBVisibleChecked(Sender: TObject);
    procedure ERoundSizeChange(Sender: TObject);
    procedure PC1Change(Sender: TObject);
  private
    { Private declarations }
    CreatingForm    : Boolean;

    FFontEditor     : TTeeFontEditor;
    FGradientEditor : TTeeGradientEditor;
    FImageEditor    : TBackImageEditor;
    FShadowEditor   : TTeeShadowEditor;

    Procedure EnableBevel;
  public
    { Public declarations }
    TheShape : TTeeCustomShape;

    Constructor Create(AOwner:TComponent); override;
    class Function CreateForm(AOwner:TComponent;
                              AShape:TTeeCustomShape;
                              AParent:TWinControl=nil):TFormTeeShape;

    procedure RefreshControls(AShape:TTeeCustomShape);
  end;

Function InsertTeeObjectForm(APageControl:TPageControl; AShape:TTeeCustomShape):TFormTeeShape;

Procedure EditTeeCustomShape(AOwner:TComponent; AShape:TTeeCustomShape; HideText:Boolean=False);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses
  {$IFDEF LCL}
  GraphType,
  {$ENDIF}
  TeeConst, TeeBrushDlg, TeeFiltersEditor;

class Function TFormTeeShape.CreateForm( AOwner:TComponent;
                                         AShape:TTeeCustomShape;
                                         AParent:TWinControl=nil):TFormTeeShape;
begin
  result:=TFormTeeShape.Create(AOwner);
  result.TheShape:=AShape;

  if Assigned(AParent) then
  with result do
  begin
    BorderStyle:=TeeFormBorderStyle;
    Parent:=AParent;
    TeeTranslateControl(result);

    Align:=alClient;

    {$IFDEF CLX}
    TeeFixParentedForm(result);
    {$ENDIF}

    Show;
  end;
end;

Function InsertTeeObjectForm(APageControl:TPageControl; AShape:TTeeCustomShape):TFormTeeShape;
var tmp : TTabSheet;
begin
  // Speed optimization, pass "nil" as owner. (VCL bottleneck)
  result:=TFormTeeShape.CreateForm(nil {APageControl.Owner} ,AShape);

  with result do
  begin
    BorderStyle:=TeeFormBorderStyle;
    Parent:=APageControl;
    Align:=alClient;

    TeeScaleForm(result);

    While PC1.PageCount>0 do
    begin
      tmp:=PC1.Pages[0];
      tmp.PageControl:=APageControl;
      {$IFDEF CLX}
      tmp.Show;
      {$ENDIF}
    end;

    APageControl.ActivePage:=APageControl.Pages[0];

    TeeTranslateControl(result);
  end;
end;

Procedure EditTeeCustomShape(AOwner:TComponent; AShape:TTeeCustomShape;
                             HideText:Boolean=False);
var tmp : TFormTeeShape;
    tmpPanel : TPanel;
begin
  tmp:=TFormTeeShape.CreateForm(AOwner,AShape);
  with tmp do
  try
    BorderStyle:=TeeBorderStyle;
    Height:=Height+30;

    tmpPanel:=TPanel.Create(tmp);
    with tmpPanel do
    begin
      Height:=34;
      BevelOuter:=bvNone;
      Align:=alBottom;
      Parent:=tmp;
    end;

    with TButton.Create(tmp) do
    begin
      Left:=tmp.Width-98;
      Top:=4;
      Caption:='OK'; // Do not localize
      ModalResult:=mrOk;
      Parent:=tmpPanel;
    end;

    if HideText then
    begin
      TabText.Visible:=False;
      TabShadow.Visible:=False;
    end;

    ShowModal;
  finally
    Free;
  end;
end;

// Constructor, for CLX compatib.
Constructor TFormTeeShape.Create(AOwner:TComponent);
begin
  CreatingForm:=True;
  inherited;
end;

procedure TFormTeeShape.BColorClick(Sender: TObject);
begin
  CBTransparent.Checked:=False;
end;

procedure TFormTeeShape.CBRoundClick(Sender: TObject);
begin
  if CBRound.Checked then TheShape.ShapeStyle:=fosRoundRectangle
                     else TheShape.ShapeStyle:=fosRectangle;

  UDRoundSize.Enabled:=CBRound.Checked;
  ERoundSize.Enabled:=UDRoundSize.Enabled;
end;

procedure TFormTeeShape.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,TheShape.Brush);
end;

type
  TShapeAccess=class(TTeeCustomShape);

procedure TFormTeeShape.RefreshControls(AShape:TTeeCustomShape);
begin
  CreatingForm:=True;
  TheShape:=AShape;

  With {$IFNDEF CLR}TShapeAccess{$ENDIF}(TheShape) do
  begin
    CBRound.Checked        :=ShapeStyle=fosRoundRectangle;
    UDRoundSize.Position   :=RoundSize;
    CBTransparent.Checked  :=Transparent;
    CBBevel.ItemIndex      :=Ord(Bevel);
    UDBevW.Position        :=BevelWidth;
    UDShadowTransp.Position:={$IFDEF CLR}TShapeAccess(TheShape).{$ENDIF}Transparency;

    if Assigned(FGradientEditor) then
       FGradientEditor.RefreshGradient(Gradient);

    if Assigned(FFontEditor) then
       FFontEditor.RefreshControls(Font);

    if Assigned(FShadowEditor) then
       FShadowEditor.RefreshControls(Shadow);

    Button4.LinkPen(Frame);

    if Assigned(FImageEditor) then
       FImageEditor.RefreshControls(Picture);
  end;

  BBackColor.LinkProperty(TheShape,'Color'); // Do not localize

  EnableBevel;
  CreatingForm:=False;
end;

Procedure TFormTeeShape.EnableBevel;
begin
  EnableControls(TheShape.Bevel<>bvNone,[EBevWidth,UDBevW]);
end;

procedure TFormTeeShape.FormShow(Sender: TObject);
begin
  PC1.ActivePage:=TabFormat;

  if Assigned(TheShape) then
     RefreshControls(TheShape);

  TeeTranslateControl(Self);
end;

procedure TFormTeeShape.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  PositionToCenter(Self);
end;

procedure TFormTeeShape.CBTransparentClick(Sender: TObject);
begin
  TheShape.Transparent:=CBTransparent.Checked;
end;

procedure TFormTeeShape.CBBevelChange(Sender: TObject);
begin
  TheShape.Bevel:=TPanelBevel(CBBevel.ItemIndex);
  EnableBevel;
end;

procedure TFormTeeShape.EBevWidthChange(Sender: TObject);
begin
  if not CreatingForm then TheShape.BevelWidth:=UDBevW.Position
end;

procedure TFormTeeShape.EShadowTranspChange(Sender: TObject);
begin
  if not CreatingForm then
     TShapeAccess(TheShape).Transparency:=UDShadowTransp.Position;
end;

procedure TFormTeeShape.CBVisibleChecked(Sender: TObject);
begin
  TheShape.Visible:=(Sender as TCheckBox).Checked;
end;

procedure TFormTeeShape.ERoundSizeChange(Sender: TObject);
begin
  if not CreatingForm then
     TheShape.RoundSize:=UDRoundSize.Position;
end;

procedure TFormTeeShape.PC1Change(Sender: TObject);
begin
  with TPageControl(Sender) do
  if ActivePage.ControlCount=0 then
     if ActivePage=TabText then
     begin
       FFontEditor:=InsertTeeFontEditor(TabText);

       if Assigned(TheShape) then
          FFontEditor.RefreshControls(TheShape.Font);
     end
     else
     if ActivePage=TabGradient then
     begin
       if Assigned(TheShape) then
       begin
         FGradientEditor:=TTeeGradientEditor.CreateCustom(nil,TheShape.Gradient);
         AddFormTo(FGradientEditor,TabGradient);
       end;
     end
     else
     if ActivePage=TabShadow then
     begin
       FShadowEditor:=InsertTeeShadowEditor(TabShadow);

       if Assigned(TheShape) then
          FShadowEditor.RefreshControls(TheShape.Shadow);
     end
     else
     if ActivePage=TabImage then
     begin
       FImageEditor:=InsertImageEditor(TabImage);

       if Assigned(TheShape) then
          FImageEditor.RefreshControls(TheShape.Picture);
     end;
end;

end.
