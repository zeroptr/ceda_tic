{**********************************************}
{   TImagePointSeries and TDeltaPointSeries    }
{   Copyright (c) 1997-2009 by David Berneda   }
{**********************************************}
unit ImaPoint;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeEngine, Chart, Series, TeCanvas;

{  This unit contains two Series components:

   TImagePointSeries --  A point Series displaying images
   TDeltaPointSeries --  An ImagePoint Series displaying a different
                         image depending the previous point value.
}

type TCustomImagePointSeries=class;
     TGetImageEvent=Procedure( Sender:TCustomImagePointSeries;
                               ValueIndex:Integer;
                               Picture:TPicture) of object;

     TCustomImagePointSeries=class(TPointSeries)
     private
       FImagePoint  : TTeePicture;
       FImageTransp : Boolean;
       FOnGetImage  : TGetImageEvent;
       procedure SetImagePoint(Const Value:TTeePicture);
       procedure SetImageTransp(Const Value:Boolean);
     protected
       procedure DrawValue(ValueIndex:Integer); override;
       Procedure PrepareForGallery(IsEnabled:Boolean); override;
     public
       Constructor Create(AOwner:TComponent); override;
       Destructor Destroy; override;

       property ImagePoint:TTeePicture read FImagePoint write SetImagePoint;
       property ImageTransparent:Boolean read FImageTransp write SetImageTransp
                                         default False;
       property OnGetImage:TGetImageEvent read FOnGetImage
                                          write FOnGetImage;
     end;

     TImagePointSeries=class(TCustomImagePointSeries)
     private
       procedure SetupFields;
     public
       Constructor Create(AOwner:TComponent); override;

       {$IFNDEF CLR} // Delphi .NET does not accept constructors to call virtual constructors
       Constructor CreatePicture(AOwner:TComponent; Picture:TTeePicture); virtual;
       {$ENDIF}
     published
       property ImagePoint;
       property ImageTransparent default True;
       property OnGetImage;
     end;

     TDeltaImageStyle=(disSmiles, disHands);

     TDeltaPointSeries=class(TCustomImagePointSeries)
     private
       FEqualImage   : TTeePicture;
       FGreaterImage : TTeePicture;
       FImageStyle   : TDeltaImageStyle;
       FLowerImage   : TTeePicture;
       procedure SetEqualImage(Const Value:TTeePicture);
       procedure SetGreaterImage(Const Value:TTeePicture);
       procedure SetImageStyle(Const Value:TDeltaImageStyle);
       procedure SetLowerImage(Const Value:TTeePicture);
     protected
       procedure DrawValue(ValueIndex:Integer); override;
     public
       Constructor Create(AOwner:TComponent); override;
       Destructor Destroy; override;
     published
       property EqualImage:TTeePicture read FEqualImage write SetEqualImage;
       property GreaterImage:TTeePicture read FGreaterImage write SetGreaterImage;
       property ImageStyle:TDeltaImageStyle read FImageStyle write
                                            SetImageStyle default disSmiles;
       property ImageTransparent;
       property LowerImage:TTeePicture read FLowerImage write SetLowerImage;

       { inherited from TCustomImagePointSeries }
       property OnGetImage;
     end;

implementation

uses
  ImageBar, TeeProCo;

{$IFDEF CLR}
{$R 'TeeEqualSmile.bmp'} // Do not localize
{$R 'TeeLowerSmile.bmp'} // Do not localize
{$R 'TeeGreaterSmile.bmp'} // Do not localize
{$R 'TeeDefaultImage.bmp'} // Do not localize
{$R 'TeeEqualHand.bmp'} // Do not localize
{$R 'TeeGreaterHand.bmp'} // Do not localize
{$R 'TeeLowerHand.bmp'} // Do not localize
{$ELSE}
{$R TeeImaPo.res}
{$ENDIF}

{ TCustomImagePointSeries }
Constructor TCustomImagePointSeries.Create(AOwner:TComponent);
begin
  inherited;
  FImagePoint:=TTeePicture.Create;
  FImagePoint.OnChange:=CanvasChanged;
end;

Destructor TCustomImagePointSeries.Destroy;
begin
  FImagePoint.Free;
  inherited;
end;

{ overrided DrawValue to draw an Image for each point }
procedure TCustomImagePointSeries.DrawValue(ValueIndex:Integer);
var R   : TRect;
    tmp : TGraphic;
begin
  if not Assigned(FImagePoint.Graphic) then
     inherited
  else
  With ParentChart,Canvas do
  begin
    { trigger the OnGetImage event if assigned... }
    if Assigned(FOnGetImage) then
       OnGetImage(Self,ValueIndex,FImagePoint);

    { draw the image... }
    With R do
    begin
      Left:=CalcXPos(ValueIndex)-(Pointer.HorizSize div 2);
      Right:=Left+Pointer.HorizSize;
      Top:=CalcYPos(ValueIndex)-(Pointer.VertSize div 2);
      Bottom:=Top+Pointer.VertSize;
    end;

    tmp:=FImagePoint.Filtered;

    tmp.Transparent:=FImageTransp;

    With ParentChart.Canvas do
    begin
      R:=CalcRect3D(R,StartZ);

      if ((R.Right-R.Left)=tmp.Width) and
         ((R.Bottom-R.Top)=tmp.Height) then
         Draw(R.Left,R.Top,tmp)
      else
         StretchDraw(R,tmp);
    end;
  end;
end;

procedure TCustomImagePointSeries.SetImagePoint(Const Value:TTeePicture);
begin
  FImagePoint.Assign(Value);   { <-- set new property values }

  if Assigned(Value) then
  begin
    if Value.Width>0 then Pointer.HorizSize:=Value.Width;
    if Value.Height>0 then Pointer.VertSize:=Value.Height;
  end;
end;

procedure TCustomImagePointSeries.SetImageTransp(Const Value:Boolean);
begin
  SetBooleanProperty(FImageTransp,Value);
end;

Procedure TCustomImagePointSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  ParentChart.View3DOptions.Orthogonal:=True;
end;

type
  TPointerAccess=class(TSeriesPointer);

{ TImagePointSeries }
Constructor TImagePointSeries.Create(AOwner:TComponent);
begin
  inherited;
  SetupFields;
end;

{$IFNDEF CLR} // Delphi .NET does not accept constructors to call virtual constructors
Constructor TImagePointSeries.CreatePicture(AOwner:TComponent; Picture:TTeePicture);
begin
  Create(AOwner);
  ImagePoint:=Picture;
end;
{$ENDIF}

procedure TImagePointSeries.SetupFields;
begin
  LoadBitmapFromResourceName(FImagePoint.Bitmap,'TeeDefaultImage'); // Do not localize

  FImageTransp:=True;

  TPointerAccess(Pointer).ChangeHorizSize(FImagePoint.Width);
  TPointerAccess(Pointer).ChangeVertSize(FImagePoint.Height);
end;

{ TDeltaPointSeries }
Constructor TDeltaPointSeries.Create(AOwner:TComponent);
begin
  inherited;
  FEqualImage:=TTeePicture.Create;
  FEqualImage.OnChange:=CanvasChanged;
  FGreaterImage:=TTeePicture.Create;
  FGreaterImage.OnChange:=CanvasChanged;
  FLowerImage:=TTeePicture.Create;
  FLowerImage.OnChange:=CanvasChanged;
  ImageStyle:=disSmiles;
end;

Destructor TDeltaPointSeries.Destroy;
begin
  FEqualImage.Free;
  FLowerImage.Free;
  FGreaterImage.Free;
  inherited;
end;

{ overrided DrawValue to draw an Image for each point }
procedure TDeltaPointSeries.DrawValue(ValueIndex:Integer);
var tmp         : TChartValue;
    tmpPrevious : TChartValue;
begin
  if ValueIndex=0 then FImagePoint.Assign(FEqualImage)
  else
  begin
    tmpPrevious:=MandatoryValueList.Value[ValueIndex-1];
    tmp:=MandatoryValueList.Value[ValueIndex];

    if tmp>tmpPrevious then FImagePoint.Assign(FGreaterImage) else
    if tmp<tmpPrevious then FImagePoint.Assign(FLowerImage) else
                            FImagePoint.Assign(FEqualImage);
  end;

  if FImagePoint.Width>0 then
     TPointerAccess(Pointer).ChangeHorizSize(FImagePoint.Width);

  if FImagePoint.Height>0 then
     TPointerAccess(Pointer).ChangeVertSize(FImagePoint.Height);

  inherited;
end;

procedure TDeltaPointSeries.SetEqualImage(Const Value:TTeePicture);
begin
  FEqualImage.Assign(Value);
end;

procedure TDeltaPointSeries.SetGreaterImage(Const Value:TTeePicture);
begin
  FGreaterImage.Assign(Value);
end;

procedure TDeltaPointSeries.SetLowerImage(Const Value:TTeePicture);
begin
  FLowerImage.Assign(Value);
end;

procedure TDeltaPointSeries.SetImageStyle(Const Value:TDeltaImageStyle);
begin
  FImageStyle:=Value;

  if Value=disHands then
  begin
    LoadBitmapFromResourceName(FEqualImage.Bitmap,'TeeEqualHand'); // Do not localize
    LoadBitmapFromResourceName(FGreaterImage.Bitmap,'TeeGreaterHand'); // Do not localize
    LoadBitmapFromResourceName(FLowerImage.Bitmap,'TeeLowerHand'); // Do not localize
  end
  else
  begin
    LoadBitmapFromResourceName(FEqualImage.Bitmap,'TeeEqualSmile'); // Do not localize
    LoadBitmapFromResourceName(FGreaterImage.Bitmap,'TeeGreaterSmile'); // Do not localize
    LoadBitmapFromResourceName(FLowerImage.Bitmap,'TeeLowerSmile'); // Do not localize
  end;
end;

initialization
  RegisterTeeSeries( TImagePointSeries,
           {$IFNDEF CLR}@{$ENDIF}TeeMsg_ImagePointSeries,
           {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1 );
  RegisterTeeSeries( TDeltaPointSeries,
           {$IFNDEF CLR}@{$ENDIF}TeeMsg_DeltaPointSeries,
           {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1 );
finalization
  UnRegisterTeeSeries([ TImagePointSeries,TDeltaPointSeries ]);
end.
