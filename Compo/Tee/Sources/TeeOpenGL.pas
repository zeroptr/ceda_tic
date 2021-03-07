{*********************************************}
{      TeeChart Pro OpenGL Component          }
{   Copyright (c) 1998-2009 by David Berneda  }
{         All Rights Reserved                 }
{*********************************************}
unit TeeOpenGL;
{$I TeeDefs.inc}

interface

uses Classes,
     {$IFDEF CLX}
     QGraphics, QStdCtrls, QExtCtrls,
     {$ELSE}
     Graphics, StdCtrls, ExtCtrls,
     {$ENDIF}
     TeeProcs, TeCanvas, TeeGLCanvas;

type
  TTeeOpenGL=class;

  TGLPosition=class(TFloatXYZ);

  TGLLight=class(TPersistent)
  private
    FColor   : TColor;
    FVisible : Boolean;

    IOwner   : TTeeOpenGL;
  protected
    Procedure SetColor(Value:TColor);
    procedure SetVisible(Value:Boolean);
  public
    Constructor Create(AOwner:TTeeOpenGL);
    Procedure Assign(Source:TPersistent); override;

    // Changed from Function to Procedure due to BCB restriction (v7.08)
    Procedure GLColor(var Value:GLMat);
  published
    property Color:TColor read FColor write SetColor default clSilver;
    property Visible:Boolean read FVisible write SetVisible;
  end;

  TGLLightSource=class(TGLLight)
  private
    FDirection    : TGLPosition;
    FFixedPos     : Boolean;
    FPosition     : TGLPosition;
    FSpotDegrees  : Double;
    FUseDirection : Boolean;
    procedure SetFixed(const Value: Boolean);
    Procedure SetSpotDegrees(const Value:Double);
    Procedure SetUseDirection(const Value:Boolean);
  protected
    Procedure SetDirection(const Value:TGLPosition);
    Procedure SetPosition(const Value:TGLPosition);
  public
    Constructor Create(AOwner:TTeeOpenGL);
    Destructor Destroy; override;
    Procedure Assign(Source:TPersistent); override;
  published
    property Direction:TGLPosition read FDirection write SetDirection; // 7.05
    property FixedPosition:Boolean read FFixedPos write SetFixed default False;
    property Position:TGLPosition read FPosition write SetPosition;
    property SpotDegrees:Double read FSpotDegrees write SetSpotDegrees; // 7.05
    property UseDirection:Boolean read FUseDirection write SetUseDirection default False;
  end;

  TTeeOpenGL = class(TComponent)
  private
    { Private declarations }
    FActive       : Boolean;
    FAmbientLight : Integer;
    FAntialias    : Boolean;
    FFontExtrusion: Integer;
    FFontOutlines : Boolean;
    FLight0       : TGLLightSource;
    FLight1       : TGLLightSource;
    FLight2       : TGLLightSource;
    FShadeQuality : Boolean;
    FShininess    : Double;
    FTeePanel     : TCustomTeePanel;
    FDrawStyle    : TTeeCanvasSurfaceStyle;

    FOnInit       : TNotifyEvent;
    FOnRepaint    : TNotifyEvent;

    Procedure Activate;
    procedure Changed(Sender:TObject);
    Function GetCanvas:TGLCanvas;
    Procedure OnCanvasInit(Sender:TObject);
    Procedure SetActive(Value:Boolean);
    Procedure SetAmbientLight(Value:Integer);
    Procedure SetAntialias(Value:Boolean);
    Procedure SetDoubleProperty(Var Variable:Double; Const Value:Double);
    procedure SetDrawStyle(const Value: TTeeCanvasSurfaceStyle);
    Procedure SetFontExtrusion(Value:Integer);
    Procedure SetFontOutlines(Value:Boolean);
    Procedure SetLightSource0(Value:TGLLightSource);
    Procedure SetLightSource1(Value:TGLLightSource);
    Procedure SetLightSource2(Value:TGLLightSource);
    Procedure SetShadeQuality(Value:Boolean);
    Procedure SetShininess(Const Value:Double);
    Procedure SetTeePanel(Value:TCustomTeePanel);
  protected
    { Protected declarations }
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
    Procedure Repaint;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    property Canvas:TGLCanvas read GetCanvas;
    property Light0:TGLLightSource read FLight0;
  published
    { Published declarations }
    property Active:Boolean read FActive write SetActive default False;
    property AmbientLight:Integer read FAmbientLight write SetAmbientLight;
    property Antialias:Boolean read FAntialias write SetAntialias default False;
    property DrawStyle:TTeeCanvasSurfaceStyle read FDrawStyle
                                              write SetDrawStyle default tcsSolid;
    property FontExtrusion:Integer read FFontExtrusion write SetFontExtrusion default 0;
    property FontOutlines:Boolean read FFontOutlines write SetFontOutlines default False;
    property Light:TGLLightSource read FLight0 write SetLightSource0;
    property Light1:TGLLightSource read FLight1 write SetLightSource1;
    property Light2:TGLLightSource read FLight2 write SetLightSource2;
    property ShadeQuality:Boolean read FShadeQuality write SetShadeQuality default True;
    property Shininess:Double read FShininess write SetShininess;
    property TeePanel:TCustomTeePanel read FTeePanel write SetTeePanel;

    property OnInit:TNotifyEvent read FOnInit write FOnInit;
    property OnRepaint:TNotifyEvent read FOnRepaint write FOnRepaint;
  end;

implementation

{$IFDEF CLR}
{$R 'TTeeOpenGL.bmp'}
{$ELSE}
{$R TeeGLIcon.res}
{$ENDIF}

Uses {$IFDEF CLX}
     QControls,
     {$ELSE}
     Controls,
     {$ENDIF}

     {$IFDEF LINUX}
     OpenGLLinux,
     {$ELSE}
     Windows,
     OpenGL2,
     {$ENDIF}

     TeeConst;

{ TGLLightSource }
Constructor TGLLightSource.Create(AOwner:TTeeOpenGL);
begin
  inherited;
  FDirection:=TGLPosition.Create;
  With FDirection do
  begin
    X:=0;
    Y:=0;
    Z:=-1;
    OnChange:=AOwner.Changed;
  end;

  FPosition:=TGLPosition.Create;
  With FPosition do
  begin
    X:=-100;
    Y:=-100;
    Z:=-100;
    OnChange:=AOwner.Changed;
  end;

  FSpotDegrees:=180;
end;

Destructor TGLLightSource.Destroy;
begin
  FDirection.Free;
  FPosition.Free;
  inherited;
end;

Procedure TGLLightSource.SetDirection(const Value:TGLPosition);
begin
  FDirection.Assign(Value);
end;

Procedure TGLLightSource.SetPosition(const Value:TGLPosition);
begin
  FPosition.Assign(Value);
end;

Procedure TGLLightSource.Assign(Source:TPersistent);
begin
  if Source is TGLLightSource then
  With TGLLightSource(Source) do
  begin
    Self.Direction:=Direction;
    Self.FFixedPos:=FFixedPos;
    Self.Position:=Position;
    Self.FSpotDegrees:=FSpotDegrees;
    Self.FUseDirection:=FUseDirection;
  end;
  inherited;
end;

Procedure TGLLightSource.SetUseDirection(const Value:Boolean);
begin
  if FUseDirection<>Value then
  begin
    FUseDirection:=Value;
    IOwner.Repaint;
  end;
end;

procedure TGLLightSource.SetFixed(const Value: Boolean);
begin
  if FFixedPos<>Value then
  begin
    FFixedPos:=Value;
    IOwner.Repaint;
  end;
end;

Procedure TGLLightSource.SetSpotDegrees(const Value:Double);
begin
  if FSpotDegrees<>Value then
  begin
    FSpotDegrees:=Value;
    IOwner.Repaint;
  end;
end;

{ TGLLight }
Constructor TGLLight.Create(AOwner:TTeeOpenGL);
begin
  inherited Create;
  IOwner:=AOwner;
  FColor:=clGray;
end;

Procedure TGLLight.SetColor(Value:TColor);
begin
  if FColor<>Value then
  begin
    FColor:=Value;
    IOwner.Repaint;
  end;
end;

procedure TGLLight.SetVisible(Value:Boolean);
begin
  if FVisible<>Value then
  begin
    FVisible:=Value;
    IOwner.Repaint;
  end;
end;

// Changed from Function to Procedure due to BCB restriction (v7.08)
Procedure TGLLight.GLColor(var Value:GLMat);
const tmpInv=1/255.0;
var AColor : TColor;
begin
  AColor:=ColorToRGB(FColor);

  Value[0]:=GetRValue(AColor)*tmpInv;
  Value[1]:=GetGValue(AColor)*tmpInv;
  Value[2]:=GetBValue(AColor)*tmpInv;
  Value[3]:=1;
end;

Procedure TGLLight.Assign(Source:TPersistent);
begin
  if Source is TGLLight then
  With TGLLight(Source) do
  begin
    Self.FColor:=Color;
    Self.FVisible:=Visible;
  end
  else inherited;
end;

{ TTeeOpenGL }
Constructor TTeeOpenGL.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FLight0:=TGLLightSource.Create(Self);
  FLight0.Visible:=True;
  FLight1:=TGLLightSource.Create(Self);
  FLight2:=TGLLightSource.Create(Self);
  FAmbientLight:=8; {%}
  FShininess:=0.5;
  FShadeQuality:=True;
end;

{$IFNDEF CLR}
type
  TTeePanelAccess=class(TCustomTeePanel);
{$ENDIF}

Destructor TTeeOpenGL.Destroy;
begin
  FLight2.Free;
  FLight1.Free;
  FLight0.Free;

  if Assigned(FTeePanel) then
  begin
    {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FTeePanel).GLComponent:=nil;
    if FActive then
       FTeePanel.Canvas:=TTeeCanvas3D.Create;
  end;

  inherited;
end;

Function TTeeOpenGL.GetCanvas:TGLCanvas;
begin
  if Assigned(FTeePanel) and (FTeePanel.Canvas is TGLCanvas) then
     result:=TGLCanvas(FTeePanel.Canvas)
  else
     result:=nil;
end;

type
  TPrivateGLCanvas=class(TGLCanvas);

Procedure TTeeOpenGL.OnCanvasInit(Sender:TObject);

  Procedure SetLight(ALight:TGLLightSource; Num:Integer);
  var tmpColor : GLMat;
  begin
    With ALight do
    if Visible then
    begin
      if FixedPosition then Canvas.DisableRotation;

      GLColor(tmpColor);

      TPrivateGLCanvas(Canvas).InitLight(Num,tmpColor,Position.Point,Direction.Point,
                                         UseDirection,SpotDegrees);

      if FixedPosition then Canvas.EnableRotation;
    end
    else
       glDisable(Num);
  end;

begin
  TPrivateGLCanvas(Canvas).InitAmbientLight(FAmbientLight);

  SetLight(FLight0,GL_LIGHT0);
  SetLight(FLight1,GL_LIGHT1);
  SetLight(FLight2,GL_LIGHT2);

  TPrivateGLCanvas(Canvas).SetShininess(FShininess);

  TPrivateGLCanvas(Canvas).SetAntiAlias(FAntiAlias);

  if Assigned(FOnInit) then
     FOnInit(Self);
end;

Procedure TTeeOpenGL.SetShininess(Const Value:Double);
begin
  SetDoubleProperty(FShininess,Value);
  if Assigned(FTeePanel) then FTeePanel.Repaint;
end;

Procedure TTeeOpenGL.SetShadeQuality(Value:Boolean);
begin
  if FShadeQuality<>Value then
  begin
    FShadeQuality:=Value;
    if FActive and Assigned(FTeePanel) then
    With Canvas do
    begin
      ShadeQuality:=Value;
      Repaint;
    end;
  end;
end;

procedure TTeeOpenGL.Notification( AComponent: TComponent;
                                   Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(FTeePanel) and (AComponent=FTeePanel) then
     TeePanel:=nil;
end;

Procedure TTeeOpenGL.Activate;
var tmpCanvas : TGLCanvas;
begin
  if Assigned(FTeePanel) then
    if FActive then
    begin
      tmpCanvas:=TGLCanvas.Create;

      With tmpCanvas do
      begin
        if FFontOutlines then
           FontStyle:=fsOutline
        else
           FontStyle:=fsNormal;

        DrawStyle:=Self.DrawStyle;
        ShadeQuality:=Self.FShadeQuality;
        OnInit:=OnCanvasInit;
        UseBuffer:=FTeePanel.Canvas.UseBuffer;
      end;

      FTeePanel.Canvas:=tmpCanvas;
    end
    else FTeePanel.Canvas:=TTeeCanvas3D.Create;
end;

Procedure TTeeOpenGL.SetAmbientLight(Value:Integer);
begin
  if FAmbientLight<>Value then
  begin
    FAmbientLight:=Value;
    Repaint;
  end;
end;

Procedure TTeeOpenGL.SetAntialias(Value:Boolean);
begin
  if FAntialias<>Value then
  begin
    FAntialias:=Value;
    Repaint;
  end;
end;

Procedure TTeeOpenGL.SetFontExtrusion(Value:Integer);
begin
  FFontExtrusion:=Value;

  if FActive and Assigned(FTeePanel) then
  With Canvas do
  begin
    DeleteFont;
    FontExtrusion:=Value;
    Repaint;
  end;
end;

Procedure TTeeOpenGL.SetFontOutlines(Value:Boolean);
begin
  FFontOutlines:=Value;

  if FActive and Assigned(FTeePanel) then
  With Canvas do
  begin
    DeleteFont;

    if FFontOutlines then
       FontStyle:=fsOutline
    else
       FontStyle:=fsNormal;

    Repaint;
  end;
end;

Procedure TTeeOpenGL.SetLightSource0(Value:TGLLightSource);
begin
  FLight0.Assign(Value);
end;

Procedure TTeeOpenGL.SetLightSource1(Value:TGLLightSource);
begin
  FLight1.Assign(Value);
end;

Procedure TTeeOpenGL.SetLightSource2(Value:TGLLightSource);
begin
  FLight2.Assign(Value);
end;

Procedure TTeeOpenGL.SetActive(Value:Boolean);
begin
  if FActive<>Value then
  begin
    FActive:=Value;
    Activate;
  end;
end;

procedure TTeeOpenGL.Changed(Sender:TObject);
begin
  Repaint;
end;

Procedure TTeeOpenGL.Repaint;
begin
  if Assigned(FTeePanel) then
     FTeePanel.Repaint;

  if Assigned(FOnRepaint) then
     FOnRepaint(Self);
end;

Procedure TTeeOpenGL.SetTeePanel(Value:TCustomTeePanel);
begin
  FTeePanel:=Value;
  if Assigned(FTeePanel) then
  begin
    {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FTeePanel).GLComponent:=Self;
    FTeePanel.FreeNotification(Self);
    Activate;
  end
  else FActive:=False;
end;

Procedure TTeeOpenGL.SetDoubleProperty(Var Variable:Double; Const Value:Double);
begin
  if Variable<>Value then
  begin
    Variable:=Value;
    Repaint;
  end;
end;

procedure TTeeOpenGL.SetDrawStyle(const Value: TTeeCanvasSurfaceStyle);
begin
  FDrawStyle:=Value;
  if FActive and Assigned(FTeePanel) then
  begin
    Canvas.DrawStyle:=FDrawStyle;
    Repaint;
  end;
end;

end.

