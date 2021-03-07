{**********************************************}
{  TTeeShadow Editor Dialog                    }
{  Copyright (c) 2002-2009 by David Berneda    }
{**********************************************}
unit TeeShadowEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     {$IFDEF LCL}
     Buttons,
     {$ENDIF}
     TeCanvas;

type
  TTeeShadowEditor = class(TForm)
    LTransp: TLabel;
    BShadowColor: TButtonColor;
    EShadowTransp: TEdit;
    UDShadowTransp: TUpDown;
    BOK: TButton;
    CBSmooth: TCheckBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    UDShadowSize: TUpDown;
    EVertSize: TEdit;
    UDShaVert: TUpDown;
    CBVisible: TCheckBox;
    Label2: TLabel;
    TBBlur: TTrackBar;
    TBColor: TTrackBar;
    CBClip: TCheckBox;
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EShadowTranspChange(Sender: TObject);
    procedure EVertSizeChange(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure CBSmoothClick(Sender: TObject);
    procedure CBVisibleClick(Sender: TObject);
    procedure TBBlurChange(Sender: TObject);
    procedure TBColorChange(Sender: TObject);
    procedure BShadowColorClick(Sender: TObject);
    procedure CBClipClick(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    Shadow       : TTeeShadow;
    H,L,S        : Word;
    
    Function CanChange:Boolean;
  public
    { Public declarations }

    {$IFDEF LINUX}
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    {$ENDIF}

    Procedure RefreshControls(AShadow:TTeeShadow);
  end;

Function EditTeeShadow(AOwner:TComponent; AShadow:TTeeShadow):Boolean;

Function InsertTeeShadowEditor(ATab:TTabSheet):TTeeShadowEditor;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeeProcs, TeePenDlg, TeeFilters;

Function EditTeeShadow(AOwner:TComponent;
                       AShadow:TTeeShadow):Boolean;
begin
  with TeeCreateForm(TTeeShadowEditor,AOwner) as TTeeShadowEditor do
  try
    Shadow:=AShadow;
    BOK.Visible:=True;
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

Function InsertTeeShadowEditor(ATab:TTabSheet):TTeeShadowEditor;
begin
  // Speed optimization, pass "nil" as owner.
  result:=TTeeShadowEditor.Create(nil {ATab.Owner});
  result.BOK.Visible:=False;
  AddFormTo(result,ATab);
end;

// TTeeShadowEditor

{$IFDEF LINUX}
Constructor TTeeShadowEditor.Create(AOwner:TComponent);
begin
  inherited;
end;

Destructor TTeeShadowEditor.Destroy;
begin
  inherited;
end;
{$ENDIF}

Procedure TTeeShadowEditor.RefreshControls(AShadow:TTeeShadow);
begin
  Shadow:=AShadow;

  with Shadow do
  begin
    UDShadowSize.Position:=HorizSize;
    UDShaVert.Position:=VertSize;
    UDShadowTransp.Position:=Transparency;
    CBSmooth.Checked:=Smooth;
    CBVisible.Checked:=Visible;
    Edit1.Enabled:=CBVisible.Checked;
    EVertSize.Enabled:=CBVisible.Checked;

    TBBlur.Position:=SmoothBlur;
    TBBlur.Enabled:=Smooth;

    ColorToHLS(Color,H,L,S);
    TBColor.Position:=L;

    CBClip.Checked:=Clip;
    CBClip.Enabled:=Smooth;
  end;

  BShadowColor.LinkProperty(Shadow,'Color');
end;

Function TTeeShadowEditor.CanChange:Boolean;
begin
  result:=(not CreatingForm) and Assigned(Shadow);
end;

procedure TTeeShadowEditor.Edit1Change(Sender: TObject);
begin
  if CanChange then
     Shadow.HorizSize:=UDShadowSize.Position;
end;

procedure TTeeShadowEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
end;

procedure TTeeShadowEditor.FormShow(Sender: TObject);
begin
  if Tag<>{$IFDEF CLR}nil{$ELSE}0{$ENDIF} then
     Shadow:=TTeeShadow(Tag);

  if Assigned(Shadow) then
     RefreshControls(Shadow);

  TeeTranslateControl(Self);
  CreatingForm:=False;
end;

procedure TTeeShadowEditor.EShadowTranspChange(Sender: TObject);
begin
  if CanChange then
     Shadow.Transparency:=UDShadowTransp.Position;
end;

procedure TTeeShadowEditor.EVertSizeChange(Sender: TObject);
begin
  if CanChange then
     Shadow.VertSize:=UDShaVert.Position;
end;

procedure TTeeShadowEditor.BOKClick(Sender: TObject);
begin
  Close;
end;

procedure TTeeShadowEditor.CBSmoothClick(Sender: TObject);
begin
  Shadow.Smooth:=CBSmooth.Checked;
  TBBlur.Enabled:=Shadow.Smooth;
  CBClip.Enabled:=Shadow.Smooth;
end;

procedure TTeeShadowEditor.CBVisibleClick(Sender: TObject);
begin
  Shadow.Visible:=CBVisible.Checked;
  Edit1.Enabled:=CBVisible.Checked;
  EVertSize.Enabled:=CBVisible.Checked;
end;

procedure TTeeShadowEditor.TBBlurChange(Sender: TObject);
begin
  if CanChange then
     Shadow.SmoothBlur:=TBBlur.Position;
end;

procedure TTeeShadowEditor.TBColorChange(Sender: TObject);
begin
  if CanChange then
  begin
    Shadow.Color:=HLSToColor(H,TBColor.Position,S);
    BShadowColor.Invalidate;
  end;
end;

procedure TTeeShadowEditor.BShadowColorClick(Sender: TObject);
begin
  ColorToHLS(Shadow.Color,H,L,S);
end;

procedure TTeeShadowEditor.CBClipClick(Sender: TObject);
begin
  Shadow.Clip:=CBClip.Checked;
end;

end.
