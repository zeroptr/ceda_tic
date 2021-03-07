{********************************************}
{      TeeOpenGL Editor Component            }
{   Copyright (c) 1999-2009 by David Berneda }
{         All Rights Reserved                }
{********************************************}
unit TeeGLEditor;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QComCtrls, QExtCtrls, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ComCtrls, ExtCtrls, StdCtrls,
  {$ENDIF}
  TeeOpenGL, TeCanvas, TeeProcs, TeePenDlg;

type
  TTeeOpenGLBackup=packed record
    Active        : Boolean;
    AmbientLight  : Integer;
    FontOutlines  : Boolean;
    LightColor    : TColor;
    LightVisible  : Boolean;
    LightX        : Double;
    LightY        : Double;
    LightZ        : Double;
    ShadeQuality  : Boolean;
    Shininess     : Double;
    FontExtrusion : Integer;
    DrawStyle     : TTeeCanvasSurfaceStyle;
  end;

  TFormTeeGLEditor = class(TForm)
    CBActive: TCheckBox;
    TabControl1: TTabControl;
    Label7: TLabel;
    CBVisible: TCheckBox;
    TrackBar5: TTrackBar;
    BLightColor: TButtonColor;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    CBOutlines: TCheckBox;
    CBShade: TCheckBox;
    TBAmbient: TTrackBar;
    TBShine: TTrackBar;
    UDDepth: TUpDown;
    Edit1: TEdit;
    Label3: TLabel;
    CBStyle: TComboFlat;
    Panel1: TPanel;
    Panel2: TPanel;
    BOK: TButton;
    BCancel: TButton;
    Label9: TLabel;
    UDSpot: TUpDown;
    Edit2: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TBX: TTrackBar;
    TBY: TTrackBar;
    TBZ: TTrackBar;
    CBFixed: TCheckBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    TBXDirection: TTrackBar;
    TBYDirection: TTrackBar;
    TBZDirection: TTrackBar;
    CBUseDirection: TCheckBox;
    CBDefaultSpot: TCheckBox;
    CBAntialias: TCheckBox;
    procedure BOKClick(Sender: TObject);
    procedure CBShadeClick(Sender: TObject);
    procedure CBOutlinesClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure TBShineChange(Sender: TObject);
    procedure TBAmbientChange(Sender: TObject);
    procedure CBActiveClick(Sender: TObject);
    procedure CBVisibleClick(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TBXChange(Sender: TObject);
    procedure TBYChange(Sender: TObject);
    procedure TBZChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure CBFixedClick(Sender: TObject);
    procedure BLightColorClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure TBXDirectionChange(Sender: TObject);
    procedure TBYDirectionChange(Sender: TObject);
    procedure TBZDirectionChange(Sender: TObject);
    procedure CBUseDirectionClick(Sender: TObject);
    procedure CBDefaultSpotClick(Sender: TObject);
    procedure CBAntialiasClick(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    GL           : TTeeOpenGL;
    GLBackup     : TTeeOpenGLBackup;
    Procedure SetLight(ALight:TGLLightSource);
    function TheLight:TGLLightSource;
  public
    { Public declarations }
  end;

Function EditTeeOpenGL(AOwner:TComponent; ATeeOpenGL:TTeeOpenGL):Boolean;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses
  TeeGLCanvas,
  {$IFDEF CLR}
  Variants,
  {$ENDIF}
  TeeEditCha;

Function EditTeeOpenGL(AOwner:TComponent; ATeeOpenGL:TTeeOpenGL):Boolean;
begin
  With TFormTeeGLEditor.Create(AOwner) do
  try
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(ATeeOpenGL);
    result:=ShowModal=mrOk;
  finally
    Free;
  end
end;

procedure TFormTeeGLEditor.BOKClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TFormTeeGLEditor.CBShadeClick(Sender: TObject);
begin
  if not CreatingForm then GL.ShadeQuality:=CBShade.Checked;
end;

procedure TFormTeeGLEditor.CBOutlinesClick(Sender: TObject);
begin
  if not CreatingForm then GL.FontOutlines:=CBOutlines.Checked;
end;

procedure TFormTeeGLEditor.Edit1Change(Sender: TObject);
begin
  if not CreatingForm then GL.FontExtrusion:=UDDepth.Position;
end;

procedure TFormTeeGLEditor.TBShineChange(Sender: TObject);
begin
  if not CreatingForm then GL.Shininess:=TBShine.Position*0.01;
end;

procedure TFormTeeGLEditor.TBAmbientChange(Sender: TObject);
begin
  if not CreatingForm then GL.AmbientLight:=TBAmbient.Position;
end;

procedure TFormTeeGLEditor.CBActiveClick(Sender: TObject);
begin
  if not CreatingForm then GL.Active:=CBActive.Checked;
end;

function TFormTeeGLEditor.TheLight:TGLLightSource;
begin
  if TabControl1.TabIndex=0 then result:=GL.Light0
  else
  if TabControl1.TabIndex=1 then result:=GL.Light1
  else
    result:=GL.Light2;
end;

procedure TFormTeeGLEditor.CBVisibleClick(Sender: TObject);
begin
  if not CreatingForm then TheLight.Visible:=CBVisible.Checked;
end;

procedure TFormTeeGLEditor.TrackBar5Change(Sender: TObject);
begin
  if not CreatingForm then
  With TheLight,TrackBar5 do
  begin
    Color:=RGB(Position,Position,Position);
    BLightColor.Repaint;
  end;
end;

procedure TFormTeeGLEditor.TBXChange(Sender: TObject);
begin
  if not CreatingForm then TheLight.Position.X:=TBX.Position;
end;

procedure TFormTeeGLEditor.TBYChange(Sender: TObject);
begin
  if not CreatingForm then TheLight.Position.Y:=TBY.Position;
end;

procedure TFormTeeGLEditor.TBZChange(Sender: TObject);
begin
  if not CreatingForm then TheLight.Position.Z:=TBZ.Position;
end;

procedure TFormTeeGLEditor.FormShow(Sender: TObject);
begin
  GL:=TTeeOpenGL(Tag);
  if Assigned(GL) then
  With GL do
  begin
    CBShade.Checked:=ShadeQuality;
    CBOutlines.Checked:=FontOutlines;
    CBStyle.ItemIndex:=Ord(DrawStyle);
    UDDepth.Position:=FontExtrusion;
    TBShine.Position:=Round(Shininess*100.0);
    TBAmbient.Position:=AmbientLight;
    CBActive.Checked:=Active;

    CBAntialias.Checked:=Antialias;

    SetLight(Light0);

    GLBackup.ShadeQuality:=ShadeQuality;
    GLBackup.FontOutlines:=FontOutlines;
    GLBackup.DrawStyle:=DrawStyle;
    GLBackup.FontExtrusion:=FontExtrusion;
    GLBackup.Shininess:=Shininess;
    GLBackup.AmbientLight:=AmbientLight;
    GLBackup.Active:=Active;
  end;

  CreatingForm:=False;
end;

Procedure TFormTeeGLEditor.SetLight(ALight:TGLLightSource);
begin
  CBVisible.Checked:=ALight.Visible;
  CBFixed.Checked:=ALight.FixedPosition;
  CBUseDirection.Checked:=ALight.UseDirection;
  TrackBar5.Position:=GetRValue(ALight.Color);

  with ALight.Position do
  begin
    TBX.Position:=Round(X);
    TBY.Position:=Round(Y);
    TBZ.Position:=Round(Z);
  end;

  with ALight.Direction do
  begin
    TBXDirection.Position:=Round(X);
    TBYDirection.Position:=Round(Y);
    TBZDirection.Position:=Round(Z);
  end;

  BLightColor.LinkProperty(ALight,'Color'); // Do not localize

  GLBackup.LightVisible:=ALight.Visible;
  GLBackup.LightColor:=ALight.Color;

  with ALight.Position do
  begin
    GLBackup.LightX:=X;
    GLBackup.LightY:=Y;
    GLBackup.LightZ:=Z;
  end;

  CBDefaultSpot.Checked:=ALight.SpotDegrees=180;
  if CBDefaultSpot.Checked then
     UDSpot.Position:=0
  else
     UDSpot.Position:=Round(ALight.SpotDegrees);

  EnableControls(not CBDefaultSpot.Checked,[Edit2,UDSpot]);
end;

procedure TFormTeeGLEditor.BCancelClick(Sender: TObject);
begin
  With GL do
  begin
    ShadeQuality:=GLBackup.ShadeQuality;
    FontOutlines:=GLBackup.FontOutlines;
    DrawStyle:=GLBackup.DrawStyle;
    FontExtrusion:=GLBackup.FontExtrusion;

    Shininess     :=GLBackup.Shininess;
    AmbientLight  :=GLBackup.AmbientLight;
    Active        :=GLBackup.Active;

    With TheLight do
    begin
      Visible:=GLBackup.LightVisible;
      Color  :=GLBackup.LightColor;
      with Position do
      begin
        X:=GLBackup.LightX;
        Y:=GLBackup.LightY;
        Z:=GLBackup.LightZ;
      end;
    end;
  end;

  ModalResult:=mrCancel;
end;

procedure TFormTeeGLEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  BorderStyle:=TeeBorderStyle;

  TabControl1.Tabs.Clear;

  TabControl1.Tabs.Add('Light 0'); // <--- dont translate
  TabControl1.Tabs.Add('Light 1'); // <--- dont translate
  TabControl1.Tabs.Add('Light 2'); // <--- dont translate

  TeeTranslateControl(Self);
end;

{$IFNDEF CLR}
type
  TTeePanelAccess=class(TCustomTeePanel);
{$ENDIF}

Procedure TeeOpenGLShowEditor(Editor:TChartEditForm; Tab:TTabSheet);
const
  TeeMsg_OpenGL='OpenGL'; // Do not localize

var tmpForm : TFormTeeGLEditor;
    tmpGL   : TComponent;
begin
  if Assigned(Editor) and Assigned(Editor.Chart) then
  begin
    tmpGL:={$IFNDEF CLR}TTeePanelAccess{$ENDIF}(Editor.Chart).GLComponent;

    if Assigned(tmpGL)
       {$IFDEF TEEOCX}
       and
        ( (not (cetOpenGL in Editor.TheHiddenTabs)) or { 5.02 }
          ( (cetOpenGL in Editor.TheHiddenTabs) and TTeeOpenGL(tmpGL).Active )
        )
        {$ENDIF}
        then
    begin
      if not Assigned(Tab) then
      begin
        Tab:=TTabSheet.Create(Editor);
        Tab.Caption:=TeeMsg_OpenGL;
        Tab.PageControl:=Editor.MainPage;
      end
      else
      if (Tab.ControlCount=0) and (Tab.Caption=TeeMsg_OpenGL) then
      begin
        tmpForm:=TFormTeeGLEditor.Create(Editor);
        tmpForm.Panel1.Visible:=False;

        tmpForm.CBActive.Checked:=TTeeOpenGL(tmpGL).Active; { 5.02 }

        {$IFDEF TEEOCX}
        if (cetOpenGL in Editor.TheHiddenTabs) and TTeeOpenGL(tmpGL).Active then
           tmpForm.CBActive.Visible:=False;
        {$ENDIF}

        AddFormTo(tmpForm,Tab,TTeeOpenGL(tmpGL));
      end;
    end;
  end;
end;

procedure TFormTeeGLEditor.TabControl1Change(Sender: TObject);
begin
  SetLight(TheLight);
end;

procedure TFormTeeGLEditor.CBStyleChange(Sender: TObject);
begin
  if not CreatingForm then
     GL.DrawStyle:=TTeeCanvasSurfaceStyle(CBStyle.ItemIndex);
end;

procedure TFormTeeGLEditor.CBFixedClick(Sender: TObject);
begin
  if not CreatingForm then
     TheLight.FixedPosition:=CBFixed.Checked;
end;

procedure TFormTeeGLEditor.BLightColorClick(Sender: TObject);
begin
  TrackBar5.Position:=GetRValue(TheLight.Color);
end;

procedure TFormTeeGLEditor.Edit2Change(Sender: TObject);
begin
  if not CreatingForm then
     TheLight.SpotDegrees:=UDSpot.Position;
end;

procedure TFormTeeGLEditor.TBXDirectionChange(Sender: TObject);
begin
  if not CreatingForm then TheLight.Direction.X:=TBXDirection.Position;
end;

procedure TFormTeeGLEditor.TBYDirectionChange(Sender: TObject);
begin
  if not CreatingForm then TheLight.Direction.Y:=TBYDirection.Position;
end;

procedure TFormTeeGLEditor.TBZDirectionChange(Sender: TObject);
begin
  if not CreatingForm then TheLight.Direction.Z:=TBZDirection.Position;
end;

procedure TFormTeeGLEditor.CBUseDirectionClick(Sender: TObject);
begin
  if not CreatingForm then
     TheLight.UseDirection:=CBUseDirection.Checked;
end;

procedure TFormTeeGLEditor.CBDefaultSpotClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    EnableControls(not CBDefaultSpot.Checked,[Edit2,UDSpot]);
    if CBDefaultSpot.Checked then
       TheLight.SpotDegrees:=180
    else
       Edit2Change(Self);
  end;
end;

procedure TFormTeeGLEditor.CBAntialiasClick(Sender: TObject);
begin
  if not CreatingForm then GL.Antialias:=CBAntialias.Checked;
end;

{$IFNDEF CLR}
initialization
  TeeOnShowEditor.Add(@TeeOpenGLShowEditor);
finalization
  TeeOnShowEditor.Remove(@TeeOpenGLShowEditor);
{$ENDIF}
end.
