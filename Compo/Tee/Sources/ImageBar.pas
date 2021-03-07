{******************************************}
{   TeeChart Pro Charting Library          }
{   Custom Series Example: TImageBar       }
{                                          }
{ Copyright (c) 1998-2009 by David Berneda }
{ All Rights Reserved                      }
{******************************************}
unit ImageBar;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$IFDEF D9}
     Types,
     {$ENDIF}
     {$ENDIF}
     Series, Chart, TeCanvas, TeeFilters;

//  This unit implements a custom TeeChart Series.
//  The TImageBarSeries is a normal BarSeries with an optional Image to
//  be displayed on each Bar point, stretched or tiled.

//  Only rectangular Bar style is allowed.

type
  TImageBarSeries=class(TBarSeries)
  private
    FImage       : TTeePicture;
    FImageTiled  : Boolean;
    FImageTransp : Boolean;

    Procedure DrawTiled(const R:TRect; StartFromTop:Boolean);
    Procedure SetImage(const Value:TTeePicture);
    Procedure SetImageTiled(const Value:Boolean);
    Procedure SetImageTransp(const Value:Boolean);
  protected
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    Procedure DrawBar(BarIndex,StartPos,EndPos:Integer); override;
  published
    property Image:TTeePicture read FImage write SetImage;
    property ImageTiled:Boolean read FImageTiled write SetImageTiled default False;
    property ImageTransparent:Boolean read FImageTransp write SetImageTransp default False;
  end;

// Used also at ImaPoint.pas unit
Procedure LoadBitmapFromResourceName(ABitmap:TBitmap; const ResName: string);

implementation

Uses 
  SysUtils, TeeProcs, TeeProCo;

// This resource file contains the default bitmap image
{$IFDEF CLR}
{$R 'TeeMoney.bmp'} // Do not localize
{$R 'TImageBarSeries.bmp'}  // Do not localize
{$ELSE}
{$R TeeImaBa.res}
{$ENDIF}

{ This function loads a bitmap from a resource linked to the executable }
Procedure LoadBitmapFromResourceName(ABitmap:TBitmap; const ResName: string);
begin
  {$IFDEF CLR}
  TeeLoadBitmap(ABitmap,ResName,'');
  {$ELSE}
  ABitmap.LoadFromResourceName(HInstance,ResName);
  {$ENDIF}
end;

{ overrided constructor to create the Image property }
Constructor TImageBarSeries.Create(AOwner:TComponent);
begin
  inherited;
  FImage:=TTeePicture.Create;
  FImage.OnChange:=CanvasChanged;

  // Load default image
  LoadBitmapFromResourceName(FImage.Bitmap,'TeeMoney'); // Do not localize
end;

Destructor TImageBarSeries.Destroy;
begin
  FImage.Free;
  inherited;
end;

Procedure TImageBarSeries.SetImage(const Value:TTeePicture);
begin
  FImage.Assign(Value);
end;

Procedure TImageBarSeries.SetImageTiled(const Value:Boolean);
begin
  SetBooleanProperty(FImageTiled,Value);
end;

Procedure TImageBarSeries.SetImageTransp(const Value:Boolean);
begin
  SetBooleanProperty(FImageTransp,Value);
end;

{ Add two bars only to the gallery }
Procedure TImageBarSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  FillSampleValues(2);
  ParentChart.View3DOptions.Orthogonal:=True;
end;

{ This method draws an image in tiled mode }
Procedure TImageBarSeries.DrawTiled(const R:TRect; StartFromTop:Boolean );
Var tmpX      : Integer;
    tmpY      : Integer;
    tmpWidth  : Integer;
    tmpHeight : Integer;
    RectH     : Integer;
    RectW     : Integer;
    tmpRect   : TRect;
    tmp       : TGraphic;
begin
  tmpWidth :=Image.Width;
  tmpHeight:=Image.Height;

  if (tmpWidth>0) and (tmpHeight>0) then
  Begin
    ParentChart.Canvas.ClipRectangle(R);

    RectSize(R,RectW,RectH);

    tmp:=Image.Filtered;

    tmpY:=0;
    while tmpY<RectH do
    begin

      tmpX:=0;
      while tmpX<RectW do
      begin
        if StartFromTop then
           tmpRect:=TeeRect(R.Left,R.Top+tmpY,R.Right,R.Top+tmpY+tmpHeight)
        else
           tmpRect:=TeeRect(R.Left,R.Bottom-tmpY-tmpHeight,R.Right,R.Bottom-tmpY);

        ParentChart.Canvas.StretchDraw(tmpRect,tmp);
        Inc(tmpX,tmpWidth);
      end;

      Inc(tmpY,tmpHeight);
    end;

    ParentChart.Canvas.UnClipRectangle;
  end;
end;

Procedure TImageBarSeries.DrawBar(BarIndex,StartPos,EndPos:Integer);
Var R     : TRect;
    tmp   : Integer;
    tmp3D : Boolean;
    P     : TFourPoints;
begin
  { first thing to do is to call the inherited DrawBar method of TBarSeries }
  inherited;

  if Assigned(FImage.Graphic) and (FImage.Graphic.Width>0) then { <-- if non empty image... }
  Begin
    FImage.Graphic.Transparent:=FImageTransp;

    { Calculate the exact rectangle, removing borders }
    R:=BarBounds;
    if R.Bottom<R.Top then SwapInteger(R.Top,R.Bottom);

    if BarPen.Visible then
    begin
      tmp:=BarPen.Width;
      if (tmp>1) and ((tmp mod 2)=0) then Dec(tmp);

      Inc(R.Left,tmp);
      Inc(R.Top,tmp);

      if not ParentChart.View3D then
      begin
        Dec(R.Right);
        Dec(R.Bottom);
      end;
    end;

    tmp3D:=ParentChart.View3D and (not ParentChart.View3DOptions.Orthogonal);

    if not tmp3D then
       R:=ParentChart.Canvas.CalcRect3D(R,StartZ)
    else
    begin
      ParentChart.Canvas.FourPointsFromRect(R,StartZ,P);
      if not TeeCull(P) then
         Exit;
    end;

    { Draw the image }
    if FImageTiled then { tiled }
       DrawTiled(R,BarBounds.Bottom<BarBounds.Top)
    else { stretched }
    if tmp3D then
       ParentChart.Canvas.StretchDraw(R,Image.Filtered,StartZ)
    else
       ParentChart.Canvas.StretchDraw(R,Image.Filtered);
  end;
end;

class Function TImageBarSeries.GetEditorClass:String;
begin
  result:='TImageBarSeriesEditor'; // Do not localize
end;

procedure TImageBarSeries.Assign(Source: TPersistent);
begin
  if Source is TImageBarSeries then
  with TImageBarSeries(Source) do
  begin
    Self.Image:=Image;
    Self.FImageTiled:=FImageTiled;
    Self.FImageTransp:=FImageTransp;
  end;

  inherited;
end;

initialization
  RegisterTeeSeries( TImageBarSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_ImageBarSeries,
                                      {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1 );
finalization
  UnRegisterTeeSeries([ TImageBarSeries ]);
end.
