{*******************************************************}
{                                                       }
{       TiImageDisplay Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iImageDisplay;{$endif}
{$ifdef iCLX}unit QiImageDisplay;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent,  ImgList, CommCtrl;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent, QImgList;{$ENDIF}

type
  TiImageDisplay = class(TiCustomComponent)
  private
    FImageList        : TImageList;
    FOnAutoSize       : TNotifyEvent;
    FAutoSize         : Boolean;
    FImageIndex       : Integer;
    FTimerEnabled     : Boolean;
    FTimerAutoRepeat  : Boolean;
    FTimerInterval    : Integer;
    FDoingAutoSize    : Boolean;
    FBorderMargin     : Integer;
    FTimerIncrementUp : Boolean;
    FStretched        : Boolean;
  protected
    procedure DoAutoSize;
    procedure iSetAutoSize  (const Value: Boolean);
    procedure SetBorderStyle(const Value: TiBevelStyle); override;

    procedure SetImageIndex      (const Value: Integer);
    procedure SetTimerEnabled    (const Value: Boolean);
    procedure SetTimerInterval   (const Value: Integer);
    procedure SetTimerAutoRepeat (const Value: Boolean);
    procedure SetBorderMargin    (const Value: Integer);
    procedure SetTimerIncrementUp(const Value: Boolean);
    procedure SetStretched       (const Value: Boolean);

    procedure ReadImageList (Stream: TStream);
    procedure WriteImageList(Stream: TStream);
    procedure DefineProperties(Filer: TFiler); override;

    procedure iPaintTo(Canvas: TCanvas);                          override;

    procedure TimerEvent     (Sender: TObject);
    procedure ImageListChange(Sender: TObject);

    procedure ImageListLoadFromBitmap(ABitmap: TBitmap);

    property ImageList  : TImageList   read FImageList;
    property OnAutoSize : TNotifyEvent read FOnAutoSize    write FOnAutoSize;
  public
    constructor Create(AOwner: TComponent);                       override;
    destructor  Destroy;                                          override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;


    procedure ImageListClear;
    procedure ImageListAdd                 (ABitmap: TBitmap);
    procedure ImageListLoadFromResourceID  (Instance: Cardinal; ResID: Integer);
    procedure ImageListLoadFromResourceName(Instance: Cardinal; ResName: String);

    procedure GotoFirstImage;
    procedure GotoLastImage;
  published
    property ImageIndex       : Integer read FImageIndex       write SetImageIndex       default 0;
    property TimerInterval    : Integer read FTimerInterval    write SetTimerInterval    default 1000;
    property TimerEnabled     : Boolean read FTimerEnabled     write SetTimerEnabled     default False;
    property TimerAutoRepeat  : Boolean read FTimerAutoRepeat  write SetTimerAutoRepeat  default True;
    property TimerIncrementUp : Boolean read FTimerIncrementUp write SetTimerIncrementUp default True;

    property AutoSize         : Boolean read FAutoSize         write iSetAutoSize        default False;
    property BorderMargin     : Integer read FBorderMargin     write SetBorderMargin;

    property Stretched        : Boolean read FStretched        write SetStretched        default False;

    property BorderStyle;
    property BackGroundColor;
    property Transparent;
    property Width            default 100;
    property Height           default 100;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiImageDisplay.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 100;
  Height := 100;

  FAutoSize         := False;
  FTimerInterval    := 1000;
  FTimerAutoRepeat  := True;
  FTimerIncrementUp := True;

  FImageList          := TImageList.CreateSize(24, 24);
  FImageList.OnChange := ImageListChange;

  OnInternalTimer := TimerEvent;
end;
//****************************************************************************************************************************************************
destructor TiImageDisplay.Destroy;
begin
  FImageList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if HandleAllocated then
    begin
      if FAutoSize then
        begin
          if BorderStyle = ibsNone then
            inherited SetBounds(ALeft, ATop, FImageList.Width, FImageList.Height)
          else
            inherited SetBounds(ALeft, ATop, FImageList.Width + 2, FImageList.Height + 2);
        end;
    end;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.SetTimerAutoRepeat (const Value:Boolean);begin SetBooleanProperty(Value, FTimerAutoRepeat,  irtInvalidate);end;
procedure TiImageDisplay.SetTimerIncrementUp(const Value:Boolean);begin SetBooleanProperty(Value, FTimerIncrementUp, irtInvalidate);end;
procedure TiImageDisplay.SetStretched       (const Value:Boolean);begin SetBooleanProperty(Value, FStretched,        irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.SetTimerInterval(const Value:Integer);
begin
  if Value < 0 then Exit;
  if FTimerInterval <> Value then
    begin
      FTimerInterval := Value;

      if TimerRunning then
        begin
          TimerStop;
          TimerStart(FTimerInterval, FTimerInterval);
        end;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.SetBorderMargin(const Value:Integer);
begin
  if FBorderMargin <> Value then
    begin
      FBorderMargin := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.SetTimerEnabled(const Value: Boolean);
begin
  if FTimerEnabled <> Value then
    begin
      FTimerEnabled := Value;
      if FTimerEnabled then
        begin
          if not GetIsDesigning then TimerStart(FTimerInterval, FTimerInterval);
        end
      else
        begin
          if TimerRunning then TimerStop;
        end;

    end;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.SetImageIndex(const Value: Integer);
begin
  if FImageIndex < 0 then Exit;
  if FImageIndex <> Value then
    begin
      FImageIndex := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.DoAutoSize;
begin
  if not FAutoSize               then Exit;
  if csLoading in ComponentState then Exit;
  if FDoingAutoSize              then Exit;

  FDoingAutoSize := True;
  try
    if BorderStyle = ibsNone then
      SetBounds(Left, Top, FImageList.Width + 2*FBorderMargin, FImageList.Height + 2*FBorderMargin)
    else
      SetBounds(Left, Top, FImageList.Width + 2*FBorderMargin + 2, FImageList.Height + 2*FBorderMargin + 2);

    if Assigned(FOnAutoSize) then FOnAutoSize(Self);
  finally
    FDoingAutoSize := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      BackGroundChange;
      DoAutoSize;
    end;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('ImageList', ReadImageList, WriteImageList, FImageList.Count <> 0);
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.ReadImageList(Stream: TStream);
{$IFDEF iVCL}
var
  SA: TStreamAdapter;
{$ENDIF}
begin
 {$IFDEF iVCL}
  FImageList.Clear;
  SA := TStreamAdapter.Create(Stream);
  try
    FImageList.Handle := ImageList_Read(SA);
    if FImageList.Handle = 0 then raise EReadError.Create('Failed to read ImageList data from stream');
  finally
    SA.Free;
  end;
 {$ENDIF}
 {$IFDEF iCLX}
 FImageList.ReadData(Stream);
 {$ENDIF}

 if not GetIsDesigning then if FTimerEnabled then TimerStart(FTimerInterval, FTimerInterval);
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.WriteImageList(Stream: TStream);
{$IFDEF iVCL}
var
  SA: TStreamAdapter;
{$ENDIF}
begin
 {$IFDEF iVCL}
  SA := TStreamAdapter.Create(Stream);
  try
    if not ImageList_Write(FImageList.Handle, SA) then raise EWriteError.Create('Failed to write ImageList data to stream');
  finally
    SA.Free;
  end;
 {$ENDIF}
 {$IFDEF iCLX}
 FImageList.WriteData(Stream);
 {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.ImageListClear;
begin
  FImageList.Clear;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.ImageListLoadFromBitmap(ABitmap: TBitmap);
var
  BBitmap    : TBitmap;
  OffsetX    : Integer;
  OffsetY    : Integer;
begin
  if FImageList.Count = 0 then
    begin
      FImageList.Width  := ABitmap.Width;
      FImageList.Height := ABitmap.Height;
    end
  else if (ABitmap.Width < FImageList.Width) and (ABitmap.Height < FImageList.Height) then
    begin
      BBitmap := TBitmap.Create;
      try
        BBitmap.Width  := FImageList.Width;
        BBitmap.Height := FImageList.Height;

        BBitmap.Canvas.Brush.Style := bsSolid;
        BBitmap.Canvas.Brush.Color := ABitmap.TransparentColor;
        BBitmap.Canvas.FillRect(Rect(0, 0, BBitmap.Width, BBitmap.Height));

        OffsetX := BBitmap.Width  div 2 - ABitmap.Width  div 2;
        OffsetY := BBitmap.Height div 2 - ABitmap.Height div 2;

        BBitmap.Canvas.Draw(OffsetX, OffsetY, ABitmap);

        ABitmap.Assign(BBitmap);
      finally
        BBitmap.Free;
      end;
    end
  else if (ABitmap.Width > FImageList.Width) and (ABitmap.Height > FImageList.Height) then
    begin

    end
  else if (ABitmap.Width <> FImageList.Width) and (ABitmap.Height <> FImageList.Height) then
    raise Exception.Create('Image Width and Height must be the same as other images, or both smaller, or both larger');

  FImageList.InsertMasked(FImageList.Count, ABitmap, ABitmap.TransparentColor);

  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.ImageListLoadFromResourceID(Instance: Cardinal; ResID: Integer);
var
  ABitmap : TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    ABitmap.LoadFromResourceID(Instance, ResID);
    ImageListLoadFromBitmap(ABitmap);
  finally
    ABitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.ImageListLoadFromResourceName(Instance: Cardinal; ResName: String);
var
  ABitmap : TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    ABitmap.LoadFromResourceName(Instance, ResName);

    ImageListLoadFromBitmap(ABitmap);
  finally
    ABitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.ImageListAdd(ABitmap: TBitmap);
begin
  ImageListLoadFromBitmap(ABitmap);
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.iPaintTo(Canvas: TCanvas);
var
  AX     : Integer;
  AY     : Integer;
  Bitmap : TBitmap;
begin
  DrawBackGround(Canvas, BackGroundColor);

  if (FImageList.Count <> 0) and (FImageIndex < FImageList.Count) then
    begin
      AX := Width  div 2 - FImageList.Width  div 2;
      AY := Height div 2 - FImageList.Height div 2;

      if not FStretched then
        begin
          {$ifdef iVCL}FImageList.Draw(Canvas, AX, AY, FImageIndex,          True);{$endif}
          {$ifdef iCLX}FImageList.Draw(Canvas, AX, AY, FImageIndex, itImage, True);{$endif}
        end
      else
        begin
          Bitmap := TBitmap.Create;
          try
            DrawBackGround(Bitmap.Canvas, BackGroundColor);
            Bitmap.Width  := FImageList.Width;
            Bitmap.Height := FImageList.Height;

            {$ifdef iVCL}FImageList.Draw(Bitmap.Canvas, 0, 0, FImageIndex,          True);{$endif}
            {$ifdef iCLX}FImageList.Draw(Bitmap.Canvas, 0, 0, FImageIndex, itImage, True);{$endif}

            Canvas.StretchDraw(ClientRect, Bitmap);
          finally
            Bitmap.Free;
          end;
        end;
    end;

  DrawBorder(Canvas);
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.TimerEvent(Sender: TObject);
begin
  if FTimerIncrementUp then
    begin
      Inc(FImageIndex);
      if FTimerAutoRepeat then
        begin
          if FImageIndex > (FImageList.Count-1) then FImageIndex := 0;
        end
      else
        begin
          if FImageIndex > (FImageList.Count-1) then
            begin
              TimerStop;
              FImageIndex := FImageList.Count-1;
            end;
        end;
    end
  else
    begin
      Dec(FImageIndex);
      if FTimerAutoRepeat then
        begin
          if FImageIndex < 0 then FImageIndex := (FImageList.Count-1);
        end
      else
        begin
          if FImageIndex < 0 then
            begin
              TimerStop;
              FImageIndex := 0;
            end;
        end;
    end;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.GotoFirstImage;
begin
  FImageIndex := 0;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.GotoLastImage;
begin
  FImageIndex := FImageList.Count-1;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.ImageListChange(Sender: TObject);
begin
  InvalidateChange;
  DoAutoSize;
end;
//****************************************************************************************************************************************************
procedure TiImageDisplay.SetBorderStyle(const Value: TiBevelStyle);
begin
  inherited;
  DoAutoSize;
end;
//****************************************************************************************************************************************************
end.
