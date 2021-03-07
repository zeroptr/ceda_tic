{*******************************************************}
{                                                       }
{       TiPlotLabel                                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotLabel;{$endif}
{$ifdef iCLX}unit QiPlotLabel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iPlotObjects,  iPlotChannelCustom;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiPlotObjects, QiPlotChannelCustom;{$ENDIF}

type
  TiPlotLabel = class(TiPlotLayoutObject)
  private
    FRequiredWidth      : Integer;

    FMarginTopPixels    : Integer;
    FMarginBottomPixels : Integer;
    FMarginLeftPixels   : Integer;
    FMarginRightPixels  : Integer;

    FCaption            : String;
    FMarginLeft         : Double;
    FMarginRight        : Double;
    FMarginBottom       : Double;
    FMarginTop          : Double;

    FFont               : TFont;
    FAlignment          : TiAlignmentHorizontal;

    FImage              : TBitmap;
    FImageListIndex     : Integer;
    FImageIndex         : Integer;
  protected
    procedure SetCaption       (const Value: String);
    procedure SetMarginBottom  (const Value: Double);
    procedure SetMarginLeft    (const Value: Double);
    procedure SetMarginRight   (const Value: Double);
    procedure SetMarginTop     (const Value: Double);
    procedure SetFont          (const Value: TFont);
    procedure SetAlignment     (const Value: TiAlignmentHorizontal);
    procedure SetImageListIndex(const Value: Integer);
    procedure SetImageIndex    (const Value: Integer);
    procedure SetImage         (const Value: TBitmap);

    procedure CalcRects                     (Canvas : TCanvas);

    function GetRequiredWidth(const Canvas: TCanvas): Integer;                                     override;

    procedure Draw            (const Canvas: TCanvas; const BackGroundColor: TColor);              override;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); override;
    destructor  Destroy;                                                                           override;

    procedure ImageClear;
    procedure ImageLoadFromFile(FileName: String);

    property Image           : TBitmap               read FImage          write SetImage;
  published
    property MarginLeft      : Double                read FMarginLeft     write SetMarginLeft;
    property MarginTop       : Double                read FMarginTop      write SetMarginTop;
    property MarginRight     : Double                read FMarginRight    write SetMarginRight;
    property MarginBottom    : Double                read FMarginBottom   write SetMarginBottom;

    property Caption         : String                read FCaption        write SetCaption;

    property Alignment       : TiAlignmentHorizontal read FAlignment      write SetAlignment        default iahCenter;

    property Font            : TFont                 read FFont           write SetFont;

    property  ImageListIndex : Integer               read FImageListIndex write SetImageListIndex            default -1;
    property  ImageIndex     : Integer               read FImageIndex     write SetImageIndex                default 0;
  end;

implementation

uses
{$ifdef iVCL} iPlotComponent,  iPlotManagers,  iPlotAxis,  iPlotChannel,  iXYPlotChannel;{$endif}
{$ifdef iCLX}QiPlotComponent, QiPlotManagers, QiPlotAxis, QiPlotChannel, QiXYPlotChannel;{$endif}

type
  TiPlotChannelCustomAccess = class(TiPlotChannelCustom)end;
  TiPlotAxisAccess          = class(TiPlotAxis         )end;
  TiPlotComponentAccess     = class(TiPlotComponent    )end;
//****************************************************************************************************************************************************
constructor TiPlotLabel.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited;

  Horizontal := True;

  FMarginLeft    := 0;
  FMarginRight   := 0;
  FMarginBottom  := 0;
  FMarginTop     := 0;

  FFont          := TFont.Create;
  FFont.Size     := 14;
  FFont.Style    := [fsBold];
  FFont.Color    := clWhite;
  FFont.Name     := 'Arial';
  FFont.OnChange := TriggerChange;

  FImageListIndex := -1;
end;
//****************************************************************************************************************************************************
destructor TiPlotLabel.Destroy;
begin
  FFont.Free;

  if Assigned(FImage) then
    begin
     FImage.Free;
     FImage := nil;
    end;

  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotLabel.SetCaption       (const Value:String  );begin SetStringProperty (Value,FCaption,       TriggerChange);end;
procedure TiPlotLabel.SetMarginBottom  (const Value:Double  );begin SetDoubleProperty (Value,FMarginBottom,  TriggerChange);end;
procedure TiPlotLabel.SetMarginLeft    (const Value:Double  );begin SetDoubleProperty (Value,FMarginLeft,    TriggerChange);end;
procedure TiPlotLabel.SetMarginRight   (const Value:Double  );begin SetDoubleProperty (Value,FMarginRight,   TriggerChange);end;
procedure TiPlotLabel.SetMarginTop     (const Value:Double  );begin SetDoubleProperty (Value,FMarginTop,     TriggerChange);end;
procedure TiPlotLabel.SetImageIndex    (const Value: Integer);begin SetIntegerProperty(Value,FImageIndex,    TriggerChange);end;
procedure TiPlotLabel.SetImageListIndex(const Value: Integer);begin SetIntegerProperty(Value,FImageListIndex,TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotLabel.SetFont(const Value:TFont);begin FFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiPlotLabel.SetAlignment(const Value: TiAlignmentHorizontal);
begin
  if FAlignment <> Value then
    begin
      FAlignment := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLabel.SetImage(const Value: TBitmap);
begin
  if Assigned(Value) then
    begin
      if not Assigned(Image) then FImage := TBitmap.Create;
      FImage.Assign(Value);
    end
  else
    begin
      FImage.Free;
      FImage := nil;
    end;

  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotLabel.ImageClear;
begin
  if Assigned(FImage) then
    begin
     FImage.Free;
     FImage := nil;
     TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLabel.ImageLoadFromFile(FileName: String);
var
  ABitmap : TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    ABitmap.LoadFromFile(FileName);
    Image := ABitmap;
  finally
    ABitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotLabel.GetRequiredWidth(const Canvas: TCanvas): Integer;
begin
  CalcRects(Canvas);
  Result := FRequiredWidth;
end;
//****************************************************************************************************************************************************
procedure TiPlotLabel.CalcRects(Canvas: TCanvas);
var
  ACharWidth  : Integer;
  ACharHeight : Integer;
begin
  with Canvas, DrawRect do
    begin
      Font.Assign(FFont);

      ACharWidth   := iTextWidth (Canvas, '0');
      ACharHeight  := iTextHeight(Canvas, '0');

      FMarginTopPixels    := Round(FMarginTop   *ACharHeight);
      FMarginBottomPixels := Round(FMarginBottom*ACharHeight);
      FMarginLeftPixels   := Round(FMarginLeft  *ACharWidth);
      FMarginRightPixels  := Round(FMarginRight *ACharWidth);

      FRequiredWidth := iTextHeight(Canvas, FCaption) + FMarginTopPixels + FMarginBottomPixels;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLabel.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  ARect      : TRect;
  ATextFlags : TiTextFlags;
  ATextWidth : Integer;
  AImageList : TImageList;
begin
  if not Visible then exit;
  CalcRects(Canvas);

  case FImageListIndex of
    0    : AImageList := TiPlotComponentAccess(Owner).ImageList0;
    1    : AImageList := TiPlotComponentAccess(Owner).ImageList1;
    2    : AImageList := TiPlotComponentAccess(Owner).ImageList2;
    else   AImageList := nil;
  end;


  if Assigned(FImage) then
    begin
      FImage.Transparent      := True;
      FImage.TransparentColor := FImage.Canvas.Pixels[0, FImage.Height-1];
      FImage.TransparentMode  := tmAuto;

      case FAlignment of
        iahLeft   : Canvas.Draw(DrawRect.Left   + FMarginLeftPixels,                         DrawRect.Top + FMarginTopPixels, FImage);
        iahRight  : Canvas.Draw(DrawRect.Right  - FMarginRightPixels   - FImage.Width,       DrawRect.Top + FMarginTopPixels, FImage);
        iahCenter : Canvas.Draw((DrawRect.Right + DrawRect.Left) div 2 - FImage.Width div 2, DrawRect.Top + FMarginTopPixels, FImage);
      end;
    end
  else if Assigned(AImageList) and (ImageIndex >= 0) and (ImageIndex < AImageList.Count) then
    begin
      case FAlignment of
        iahLeft   : AImageList.Draw(Canvas, DrawRect.Left   + FMarginLeftPixels,                             DrawRect.Top + FMarginTopPixels, FImageIndex, Enabled);
        iahRight  : AImageList.Draw(Canvas, DrawRect.Right  - FMarginRightPixels   - AImageList.Width,       DrawRect.Top + FMarginTopPixels, FImageIndex, Enabled);
        iahCenter : AImageList.Draw(Canvas, (DrawRect.Right + DrawRect.Left) div 2 - AImageList.Width div 2, DrawRect.Top + FMarginTopPixels, FImageIndex, Enabled);
      end;
    end
  else
    begin
      Font.Assign(FFont);

      ATextWidth  := iTextWidth(Canvas, Caption);

      with Canvas, DrawRect do
        begin
          Brush.Style := bsClear;

          case FAlignment of
            iahCenter : ATextFlags := [itfHCenter, itfVCenter];
            iahLeft   : ATextFlags := [itfHLeft,   itfVCenter];
            iahRight  : ATextFlags := [itfHRight,  itfVCenter];
          end;

          case Horizontal of
            True : begin
                     ARect := Rect(Left + FMarginLeftPixels, Top + FMarginTopPixels, Right - FMarginRightPixels, Bottom - FMarginBottomPixels);
                     iDrawText(Canvas, Caption, ARect, ATextFlags, True, clBtnFace);
                    end;
            else    begin
                      ARect.Left  := Left  + FMarginTopPixels;
                      ARect.Right := Right - FMarginBottomPixels;
                      case FAlignment of
                        iahLeft   : begin
                                      ARect.Top    := Bottom - ATextWidth div 2 - FMarginLeftPixels;
                                      ARect.Bottom := Bottom - ATextWidth div 2 - FMarginLeftPixels;
                                    end;
                        iahRight  : begin
                                      ARect.Top    := Top + ATextWidth div 2 + FMarginRightPixels;
                                      ARect.Bottom := Top + ATextWidth div 2 + FMarginRightPixels;
                                    end;
                        else        begin
                                      ARect.Top    := (Bottom + Top) div 2 - ATextWidth div 2;
                                      ARect.Bottom := (Bottom + Top) div 2 + ATextWidth div 2;
                                    end;
                      end;
                      iDrawRotatedText(Canvas, Caption, ARect, ira090, iahCenter, True, clBtnFace);
                    end;
          end;
        end;
    end;
end;
//****************************************************************************************************************************************************
end.
