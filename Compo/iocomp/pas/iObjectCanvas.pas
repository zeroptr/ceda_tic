{*******************************************************}
{                                                       }
{       TiObjectCanvas Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iObjectCanvas;{$endif}
{$ifdef iCLX}unit QiObjectCanvas;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iMath,  iGPFunctions,  iClasses,  iCustomComponent,  Imglist, CommCtrl;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiMath, QiGPFunctions, QiClasses, QiCustomComponent, QImglist;{$ENDIF}

type
  TiMouseUPDownDisplayEvent = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Double) of object;
  TiMouseMoveDisplayEvent   = procedure(Sender: TObject;                       Shift: TShiftState; X, Y: Double) of object;
  TiClickObjectEvent        = procedure(Sender: TObject; Handle: Integer                                       ) of object;

  TiObjectCanvas = class(TiCustomComponent)
  private
    FMouseDown            : Boolean;
    FMouseDownHandle      : Integer;
    FHandleCounter        : Integer;

    FImageList            : TImageList;
    FImage                : TBitmap;
    FImageRotated         : TBitmap;

    FObjectList           : TStringList;

    FOriginX              : Double;
    FOriginY              : Double;

    FDisplayRangeX        : Double;
    FDisplayRangeY        : Double;

    FDefaultBrushColor    : TColor;
    FDefaultBrushStyle    : TBrushStyle;

    FDefaultPenColor      : TColor;
    FDefaultPenStyle      : TPenStyle;
    FDefaultPenWidth      : Integer;

    FDefaultFontName      : String;
    FDefaultFontSize      : Integer;
    FDefaultFontBold      : Boolean;
    FDefaultFontItalic    : Boolean;
    FDefaultFontUnderLine : Boolean;
    FDefaultFontColor     : TColor;
    FDefaultFontStrikeOut : Boolean;

    FOnMouseDownDisplay   : TiMouseUPDownDisplayEvent;
    FOnMouseMoveDisplay   : TiMouseMoveDisplayEvent;
    FOnMouseUpDisplay     : TiMouseUPDownDisplayEvent;
    FOnClickObject        : TiClickObjectEvent;

    procedure SetOriginX       (const Value: Double);
    procedure SetOriginY       (const Value: Double);
    procedure SetDisplayRangeX (const Value: Double);
    procedure SetDisplayRangeY (const Value: Double);
    procedure SetObjectDefaults(iDrawObject: TiDrawObject);
    function  AddObject        (iDrawObject: TiDrawObject) : Integer;
    function  GetObject        (Handle: Integer) : TiDrawObject;

    function  GetImageListCount: Integer;
    function  GetImageListHeight: Integer;
    function  GetImageListWidth: Integer;
    procedure SetImageListHeight(const Value: Integer);
    procedure SetImageListWidth (const Value: Integer);

    procedure ImageListLoadFromBitmap(ABitmap: TBitmap);
  protected
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    procedure iDoKillFocus;                                                        override;
    procedure iPaintTo(Canvas: TCanvas);                                           override;

    procedure DefineProperties(Filer: TFiler); override;

    procedure ReadImageList (Stream: TStream);
    procedure WriteImageList(Stream: TStream);

    function RotateBitmap(const Bitmap: TBitmap; const Angle: Double): TBitmap;

    procedure NeedsRedraw;
    procedure DrawObjectText(Canvas: TCanvas; iDrawObject: TiDrawObject; CenterPoint: TPoint; ScaleXFactor, ScaleYFactor: Double);

    property ImageList           : TImageList               read FImageList;
  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;

    procedure   BringObjectToFront(Handle: Integer);
    procedure   SendObjectToBack(Handle: Integer);

    procedure   ClearList;
    procedure   RemoveObject(Handle : Integer);

    function    AddEllipse       (X, Y, Width, Height: Double)                        : Integer;
    function    AddRectangle     (X, Y, Width, Height: Double)                        : Integer;
    function    AddArc           (X, Y, Width, Height, StartAngle, StopAngle: Double) : Integer;
    function    AddLabel         (X, Y: Double; Caption: String)                      : Integer;
    function    AddImage         (X, Y: Double; ImageIndex : Integer)                 : Integer;
    function    AddLine          (Left, Top, Right, Bottom: Double)                   : Integer;
    function    AddPolygon                                                            : Integer;

    procedure   ObjectAddPolyPoint   (Handle: Integer; X, Y: Double);
    procedure   ObjectClearPolyPoints(Handle: Integer);

    procedure   SetObjectType         (Handle: Integer; AType: TiDrawObjectType);
    function    GetObjectType         (Handle: Integer) : TiDrawObjectType;

    procedure   SetObjectVisible      (Handle: Integer; Visible: Boolean);
    function    GetObjectVisible      (Handle: Integer) : Boolean;

    procedure   SetImageList(ImageList: TImageList);

    procedure   SetObjectBrush        (Handle: Integer; Color: TColor; Style: TBrushStyle);
    procedure   SetObjectBrushStyle   (Handle: Integer; Style: TBrushStyle);
    procedure   SetObjectBrushColor   (Handle: Integer; Color: TColor);
    function    GetObjectBrushStyle   (Handle: Integer) : TBrushStyle;
    function    GetObjectBrushColor   (Handle: Integer) : TColor;

    procedure   SetObjectPen          (Handle: Integer; Color: TColor; Style: TPenStyle; Width: Integer);
    procedure   SetObjectPenColor     (Handle: Integer; Color: TColor);
    procedure   SetObjectPenStyle     (Handle: Integer; Style: TPenStyle);
    procedure   SetObjectPenWidth     (Handle: Integer; Width: Integer);
    function    GetObjectPenColor     (Handle: Integer) : TColor;
    function    GetObjectPenStyle     (Handle: Integer) : TPenStyle;
    function    GetObjectPenWidth     (Handle: Integer) : Integer;

    procedure   SetObjectPosition     (Handle: Integer; X, Y: Double);
    procedure   SetObjectPositionX    (Handle: Integer; X   : Double);
    procedure   SetObjectPositionY    (Handle: Integer; Y   : Double);
    function    GetObjectPositionX    (Handle: Integer) : Double;
    function    GetObjectPositionY    (Handle: Integer) : Double;

    procedure   SetObjectAngles       (Handle: Integer; Start, Stop: Double);
    procedure   SetObjectStartAngle   (Handle: Integer; Value: Double);
    procedure   SetObjectStopAngle    (Handle: Integer; Value: Double);
    function    GetObjectStartAngle   (Handle: Integer) : Double;
    function    GetObjectStopAngle    (Handle: Integer) : Double;

    procedure   SetObjectSize         (Handle: Integer; Width, Height: Double);
    procedure   SetObjectSizeWidth    (Handle: Integer; Width        : Double);
    procedure   SetObjectSizeHeight   (Handle: Integer; Height       : Double);
    function    GetObjectSizeWidth    (Handle: Integer) : Double;
    function    GetObjectSizeHeight   (Handle: Integer) : Double;

    procedure   SetObjectFont         (Handle: Integer; Name: String; Size: Integer; Color: TColor; Bold, Italic, UnderLine, StrikeOut: Boolean);
    procedure   SetObjectFontName     (Handle: Integer; Name: String);
    procedure   SetObjectFontSize     (Handle: Integer; Size: Integer);
    procedure   SetObjectFontColor    (Handle: Integer; Color: TColor);
    procedure   SetObjectFontBold     (Handle: Integer; Bold: Boolean);
    procedure   SetObjectFontItalic   (Handle: Integer; Italic: Boolean);
    procedure   SetObjectFontUnderLine(Handle: Integer; UnderLine: Boolean);
    procedure   SetObjectFontStrikOut (Handle: Integer; StrikeOut: Boolean);

    function    GetObjectFontName     (Handle: Integer) : String;
    function    GetObjectFontSize     (Handle: Integer) : Integer;
    function    GetObjectFontColor    (Handle: Integer) : TColor;
    function    GetObjectFontBold     (Handle: Integer) : Boolean;
    function    GetObjectFontItalic   (Handle: Integer) : Boolean;
    function    GetObjectFontUnderLine(Handle: Integer) : Boolean;
    function    GetObjectFontStrikOut (Handle: Integer) : Boolean;

    procedure   SetObjectCaption      (Handle: Integer; Caption: String);
    function    GetObjectCaption      (Handle: Integer) : String;

    procedure   SetObjectImageIndex   (Handle: Integer; ImageIndex: Integer);
    function    GetObjectImageIndex   (Handle: Integer) : Integer;

    procedure   SetObjectImageRotation(Handle: Integer; ImageRotation: Double);
    function    GetObjectImageRotation(Handle: Integer) : Double;

    function    GetPixelsXToDisplayX  (Value: Integer): Double;
    function    GetPixelsYToDisplayY  (Value: Integer): Double;

    function    GetDisplayXToPixelsX  (Value: Double): Integer;
    function    GetDisplayYToPixelsY  (Value: Double): Integer;

    procedure   ShiftObject           (Handle: Integer; XDelta, YDelta: Double);
    procedure   ShiftObjectX          (Handle: Integer; XDelta        : Double);
    procedure   ShiftObjectY          (Handle: Integer; YDelta        : Double);

    property    ImageListCount    : Integer                    read GetImageListCount;
    procedure   ImageListRemoveAll;
    procedure   ImageListDelete(Index: Integer);
    procedure   ImageListAdd(Bitmap: TBitmap);
    procedure   ImageListLoadFromResourceID  (Instance: Cardinal; ResID: Integer);
    procedure   ImageListLoadFromResourceName(Instance: Cardinal; ResName: String);

    property    MouseDownHandle   : Integer                    read FMouseDownHandle;
  published
    property OriginX              : Double                     read FOriginX              write SetOriginX;
    property OriginY              : Double                     read FOriginY              write SetOriginY;

    property DisplayRangeX        : Double                     read FDisplayRangeX        write SetDisplayRangeX;
    property DisplayRangeY        : Double                     read FDisplayRangeY        write SetDisplayRangeY;

    property DefaultBrushColor    : TColor                     read FDefaultBrushColor    write FDefaultBrushColor    default clBlack;
    property DefaultBrushStyle    : TBrushStyle                read FDefaultBrushStyle    write FDefaultBrushStyle    default bsSolid;

    property DefaultPenColor      : TColor                     read FDefaultPenColor      write FDefaultPenColor      default clWhite;
    property DefaultPenStyle      : TPenStyle                  read FDefaultPenStyle      write FDefaultPenStyle      default psSolid;
    property DefaultPenWidth      : Integer                    read FDefaultPenWidth      write FDefaultPenWidth      default 1;

    property DefaultFontName      : String                     read FDefaultFontName      write FDefaultFontName;
    property DefaultFontSize      : Integer                    read FDefaultFontSize      write FDefaultFontSize      default 8;
    property DefaultFontColor     : TColor                     read FDefaultFontColor     write FDefaultFontColor     default clWhite;
    property DefaultFontBold      : Boolean                    read FDefaultFontBold      write FDefaultFontBold      default False;
    property DefaultFontItalic    : Boolean                    read FDefaultFontItalic    write FDefaultFontItalic    default False;
    property DefaultFontUnderLine : Boolean                    read FDefaultFontUnderLine write FDefaultFontUnderLine default False;
    property DefaultFontStrikeOut : Boolean                    read FDefaultFontStrikeOut write FDefaultFontStrikeOut default False;

    property ImageListWidth        : Integer                    read GetImageListWidth    write SetImageListWidth;
    property ImageListHeight       : Integer                    read GetImageListHeight   write SetImageListHeight;

    property OnMouseDownDisplay    : TiMouseUPDownDisplayEvent read FOnMouseDownDisplay   write FOnMouseDownDisplay;
    property OnMouseMoveDisplay    : TiMouseMoveDisplayEvent   read FOnMouseMoveDisplay   write FOnMouseMoveDisplay;
    property OnMouseUpDisplay      : TiMouseUPDownDisplayEvent read FOnMouseUpDisplay     write FOnMouseUpDisplay;
    property OnClickObject         : TiClickObjectEvent        read FOnClickObject        write FOnClickObject;

    property BackGroundColor  default clBlack;
    property BackGroundPicture;
    property BorderStyle      default ibsLowered;
    property Transparent;
    property Align;
    property Width            default 200;
    property Height           default 200;
    property OnPaint;
  end;

implementation
//*************************************************************************************************************************************
constructor TiObjectCanvas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width           := 200;
  Height          := 200;
  BackGroundColor := clBlack;
  BorderStyle     := ibsLowered;

  FDisplayRangeX := 100;
  FDisplayRangeY := 100;

  FDefaultBrushColor     := clBlack;
  FDefaultBrushStyle     := bsSolid;

  FDefaultPenColor       := clWhite;
  FDefaultPenStyle       := psSolid;
  FDefaultPenWidth       := 1;

  FDefaultFontName       := 'Arial';
  FDefaultFontSize       := 8;
  FDefaultFontColor      := clWhite;
  FDefaultFontBold       := False;
  FDefaultFontItalic     := False;
  FDefaultFontUnderLine  := False;
  FDefaultFontStrikeOut  := False;

  FObjectList             := TStringList.Create;
  FObjectList.Duplicates  := dupError;

  FImageList              := TImageList.Create(Self);
  FImageList.BkColor      := clnone;
  FImageList.Width        := 24;
  FImageList.Height       := 24;
  FImageList.Masked       := True;

  FMouseDownHandle        := -1;

  CreateBackGroundPicture;
end;
//*************************************************************************************************************************************
destructor TiObjectCanvas.Destroy;
begin
  ClearList;
  FObjectList.Free;

  FImageList.Free;

  if Assigned(FImage)        then FImage.Free;
  if Assigned(FImageRotated) then FImageRotated.Free;

  inherited;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.ClearList;
begin
  while FObjectList.Count > 0 do
    begin
      FObjectList.Objects[0].Free;
      FObjectList.Delete(0);
    end;
  FHandleCounter := 0;
  InvalidateChange;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.BringObjectToFront(Handle: Integer);
var
  ItemIndex : Integer;
begin
  ItemIndex := FObjectList.IndexOf(IntToStr(Handle));
  if ItemIndex = - 1 then raise Exception.Create('Object not Found');
  FObjectList.Move(ItemIndex, FObjectList.Count - 1);
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SendObjectToBack(Handle: Integer);
var
  ItemIndex : Integer;
begin
  ItemIndex := FObjectList.IndexOf(IntToStr(Handle));
  if ItemIndex = - 1 then raise Exception.Create('Object not Found');
  FObjectList.Move(ItemIndex, 0);
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.NeedsRedraw;
begin
  InvalidateChange;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetOriginX(const Value: Double);
begin
  if FOriginX <> Value then
    begin
      FOriginX := Value;
      NeedsRedraw;
    end;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetOriginY(const Value: Double);
begin
  if FOriginY <> Value then
    begin
      FOriginY := Value;
      NeedsRedraw;
    end;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetDisplayRangeX(const Value: Double);
begin
  if FDisplayRangeX <> Value then
    begin
      FDisplayRangeX := Value;
      NeedsRedraw;
    end;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetDisplayRangeY(const Value: Double);
begin
  if FDisplayRangeY <> Value then
    begin
      FDisplayRangeY := Value;
      NeedsRedraw;
    end;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectDefaults(iDrawObject: TiDrawObject);
begin
  iDrawObject.Visible       := True;
  iDrawObject.PenColor      := DefaultPenColor;
  iDrawObject.PenStyle      := DefaultPenStyle;
  iDrawObject.PenWidth      := DefaultPenWidth;

  iDrawObject.BrushColor    := DefaultBrushColor;
  iDrawObject.BrushStyle    := DefaultBrushStyle;

  iDrawObject.FontName      := DefaultFontName;
  iDrawObject.FontSize      := DefaultFontSize;
  iDrawObject.FontColor     := DefaultFontColor;
  iDrawObject.FontBold      := DefaultFontBold;
  iDrawObject.FontItalic    := DefaultFontItalic;
  iDrawObject.FontUnderLine := DefaultFontUnderLine;
  iDrawObject.FontStrikeOut := DefaultFontStrikeOut;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.AddObject(iDrawObject: TiDrawObject): Integer;
begin
  FObjectList.AddObject(IntToStr(FHandleCounter), iDrawObject);
  Result := FHandleCounter;
  FHandleCounter := FHandleCounter + 1;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObject(Handle: Integer): TiDrawObject;
var
  ItemIndex : Integer;
begin
  ItemIndex := FObjectList.IndexOf(IntToStr(Handle));
  if ItemIndex = - 1 then raise Exception.Create('Object not Found');
  Result := FObjectList.Objects[ItemIndex] as TiDrawObject;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.RemoveObject(Handle: Integer);
var
  ItemIndex : Integer;
begin
  ItemIndex := FObjectList.IndexOf(IntToStr(Handle));
  if ItemIndex = - 1 then raise Exception.Create('Object not Found');
  FObjectList.Objects[ItemIndex].Free;
  FObjectList.Delete(ItemIndex);
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.AddEllipse(X, Y, Width, Height: Double): Integer;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject        := TiDrawObject.Create;
  iDrawObject.AType  := tidoEllipse;
  iDrawObject.X      := X;
  iDrawObject.Y      := Y;
  iDrawObject.Width  := Width;
  iDrawObject.Height := Height;
  SetObjectDefaults(iDrawObject);

  Result := AddObject(iDrawObject);
end;
//*************************************************************************************************************************************
function TiObjectCanvas.AddRectangle(X, Y, Width, Height: Double): Integer;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject        := TiDrawObject.Create;
  iDrawObject.AType  := tidoRectangle;
  iDrawObject.X      := X;
  iDrawObject.Y      := Y;
  iDrawObject.Width  := Width;
  iDrawObject.Height := Height;
  SetObjectDefaults(iDrawObject);

  Result := AddObject(iDrawObject);
end;
//*************************************************************************************************************************************
function TiObjectCanvas.AddArc(X, Y, Width, Height, StartAngle, StopAngle: Double): Integer;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject            := TiDrawObject.Create;
  iDrawObject.AType      := tidoArc;
  iDrawObject.X          := X;
  iDrawObject.Y          := Y;
  iDrawObject.Width      := Width;
  iDrawObject.Height     := Height;
  iDrawObject.StartAngle := StartAngle;
  iDrawObject.StopAngle  := StopAngle;
  SetObjectDefaults(iDrawObject);

  Result := AddObject(iDrawObject);
end;
//*************************************************************************************************************************************
function TiObjectCanvas.AddLine(Left, Top, Right, Bottom: Double): Integer;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject        := TiDrawObject.Create;
  iDrawObject.AType  := tidoLine;
  iDrawObject.X      := Left;
  iDrawObject.Y      := Top;
  iDrawObject.Width  := Right;
  iDrawObject.Height := Bottom;
  SetObjectDefaults(iDrawObject);

  Result := AddObject(iDrawObject);
end;
//*************************************************************************************************************************************
function TiObjectCanvas.AddLabel(X, Y: Double; Caption: String): Integer;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject             := TiDrawObject.Create;
  iDrawObject.AType       := tidoText;
  iDrawObject.X           := X;
  iDrawObject.Y           := Y;
  iDrawObject.FontCaption := Caption;
  SetObjectDefaults(iDrawObject);

  Result := AddObject(iDrawObject);
end;
//*************************************************************************************************************************************
function TiObjectCanvas.AddImage(X, Y: Double; ImageIndex: Integer): Integer;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject             := TiDrawObject.Create;
  iDrawObject.AType       := tidoImage;
  iDrawObject.X           := X;
  iDrawObject.Y           := Y;
  iDrawObject.ImageIndex  := ImageIndex;
  SetObjectDefaults(iDrawObject);

  Result := AddObject(iDrawObject);
end;
//*************************************************************************************************************************************
function TiObjectCanvas.AddPolygon: Integer;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject             := TiDrawObject.Create;
  iDrawObject.AType       := tidoPolygon;
  SetObjectDefaults(iDrawObject);

  Result := AddObject(iDrawObject);
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectType(Handle: Integer; AType: TiDrawObjectType);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject       := GetObject(Handle);
  iDrawObject.AType := AType;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectType(Handle: Integer): TiDrawObjectType;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.AType;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectVisible(Handle: Integer): Boolean;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.Visible;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectVisible(Handle: Integer; Visible: Boolean);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject         := GetObject(Handle);
  iDrawObject.Visible := Visible;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectBrush(Handle: Integer; Color: TColor; Style: TBrushStyle);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject            := GetObject(Handle);
  iDrawObject.BrushColor := Color;
  iDrawObject.BrushStyle := Style;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectBrushColor(Handle: Integer; Color: TColor);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  iDrawObject.BrushColor := Color;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectBrushStyle(Handle: Integer; Style: TBrushStyle);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  iDrawObject.BrushStyle := Style;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectBrushColor(Handle: Integer): TColor;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.BrushColor;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectBrushStyle(Handle: Integer): TBrushStyle;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.BrushStyle;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectCaption(Handle: Integer; Caption: String);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject             := GetObject(Handle);
  iDrawObject.FontCaption := Caption;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectCaption(Handle: Integer): String;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.FontCaption;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectImageIndex(Handle, ImageIndex: Integer);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject             := GetObject(Handle);
  iDrawObject.ImageIndex  := ImageIndex;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectImageIndex(Handle: Integer): Integer;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.ImageIndex;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectImageRotation(Handle: Integer; ImageRotation: Double);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject               := GetObject(Handle);
  iDrawObject.ImageRotation := ImageRotation;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectImageRotation(Handle: Integer): Double;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.ImageRotation;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectFont(Handle : Integer; Name : String; Size : Integer; Color : TColor; Bold, Italic, UnderLine, StrikeOut : Boolean);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject               := GetObject(Handle);
  iDrawObject.FontName      := Name;
  iDrawObject.FontSize      := Size;
  iDrawObject.FontColor     := Color;
  iDrawObject.FontBold      := Bold;
  iDrawObject.FontItalic    := Italic;
  iDrawObject.FontUnderLine := UnderLine;
  iDrawObject.FontStrikeOut := StrikeOut;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectFontBold(Handle: Integer; Bold: Boolean);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject               := GetObject(Handle);
  iDrawObject.FontBold      := Bold;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectFontColor(Handle: Integer; Color: TColor);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject               := GetObject(Handle);
  iDrawObject.FontColor     := Color;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectFontItalic(Handle: Integer; Italic: Boolean);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject               := GetObject(Handle);
  iDrawObject.FontItalic    := Italic;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectFontName(Handle: Integer; Name: String);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject               := GetObject(Handle);
  iDrawObject.FontName      := Name;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectFontSize(Handle, Size: Integer);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject               := GetObject(Handle);
  iDrawObject.FontSize      := Size;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectFontStrikOut(Handle: Integer; StrikeOut: Boolean);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject               := GetObject(Handle);
  iDrawObject.FontStrikeOut := StrikeOut;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectFontUnderLine(Handle: Integer; UnderLine: Boolean);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject               := GetObject(Handle);
  iDrawObject.FontUnderLine := UnderLine;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectFontBold(Handle: Integer): Boolean;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.FontBold;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectFontColor(Handle: Integer): TColor;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.FontColor;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectFontItalic(Handle: Integer): Boolean;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.FontItalic;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectFontName(Handle: Integer): String;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.FontName;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectFontSize(Handle: Integer): Integer;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.FontSize;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectFontStrikOut(Handle: Integer): Boolean;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.FontStrikeOut;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectFontUnderLine(Handle: Integer): Boolean;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.FontUnderLine;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectPen(Handle: Integer; Color: TColor; Style: TPenStyle; Width: Integer);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject          := GetObject(Handle);
  iDrawObject.PenColor := Color;
  iDrawObject.PenStyle := Style;
  iDrawObject.PenWidth := Width;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectPenColor(Handle: Integer; Color: TColor);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject          := GetObject(Handle);
  iDrawObject.PenColor := Color;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectPenStyle(Handle: Integer; Style: TPenStyle);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject          := GetObject(Handle);
  iDrawObject.PenStyle := Style;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectPenWidth(Handle, Width: Integer);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject          := GetObject(Handle);
  iDrawObject.PenWidth := Width;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectPenColor(Handle: Integer): TColor;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.PenColor;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectPenStyle(Handle: Integer): TPenStyle;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.PenStyle;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectPenWidth(Handle: Integer): Integer;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.PenWidth;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectPosition(Handle: Integer; X, Y: Double);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject   := GetObject(Handle);
  iDrawObject.X := X;
  iDrawObject.Y := Y;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectPositionX(Handle: Integer; X: Double);
var
  iDrawObject : TiDrawObject;
  i           : Integer;
  ACenter     : Double;
  ADelta      : Double;
  APoint      : TPointDouble;
begin
  iDrawObject   := GetObject(Handle);
  if (iDrawObject.AType = tidoPolygon) then
    begin
      ACenter := GetObjectPositionX(Handle);
      ADelta  := X - ACenter;

      for i := 0 to iDrawObject.PolyPointCount-1 do
        begin
          APoint   := iDrawObject.PolyPoint[i];
          APoint.x := APoint.x + ADelta;
          iDrawObject.PolyPoint[i] := APoint;
        end;
    end
  else iDrawObject.X := X;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectPositionY(Handle: Integer; Y: Double);
var
  iDrawObject : TiDrawObject;
  i           : Integer;
  ACenter     : Double;
  ADelta      : Double;
  APoint      : TPointDouble;
begin
  iDrawObject   := GetObject(Handle);
  if (iDrawObject.AType = tidoPolygon) then
    begin
      ACenter := GetObjectPositionY(Handle);
      ADelta  := Y - ACenter;

      for i := 0 to iDrawObject.PolyPointCount-1 do
        begin
          APoint   := iDrawObject.PolyPoint[i];
          APoint.y := APoint.y + ADelta;
          iDrawObject.PolyPoint[i] := APoint;
        end;
    end
  else iDrawObject.Y := Y;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectPositionX(Handle: Integer): Double;
var
  iDrawObject : TiDrawObject;
  i           : Integer;
  AValue      : Double;
  AMax        : Double;
  AMin        : Double;
begin
  iDrawObject := GetObject(Handle);
  if (iDrawObject.AType = tidoPolygon) then
    begin
      AMax := -1E+300;
      AMin :=  1E+300;

      for i := 0 to iDrawObject.PolyPointCount-1 do
        begin
          AValue := iDrawObject.PolyPoint[i].x;
          if (AValue > AMax) then AMax := AValue;
          if (AValue < AMin) then AMin := AValue;
        end;

      Result := (AMax + AMin)/2;
    end
  else Result := iDrawObject.X;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectPositionY(Handle: Integer): Double;
var
  iDrawObject : TiDrawObject;
  i           : Integer;
  AValue      : Double;
  AMax        : Double;
  AMin        : Double;
begin
  iDrawObject := GetObject(Handle);
  if (iDrawObject.AType = tidoPolygon) then
    begin
      AMax := -1E+300;
      AMin :=  1E+300;

      for i := 0 to iDrawObject.PolyPointCount-1 do
        begin
          AValue := iDrawObject.PolyPoint[i].y;
          if (AValue > AMax) then AMax := AValue;
          if (AValue < AMin) then AMin := AValue;
        end;

      Result := (AMax + AMin)/2;
    end
  else Result := iDrawObject.Y;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectAngles(Handle: Integer; Start, Stop: Double);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject   := GetObject(Handle);
  iDrawObject.StartAngle := Start;
  iDrawObject.StopAngle  := Stop;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectStartAngle(Handle: Integer; Value: Double);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject   := GetObject(Handle);
  iDrawObject.StartAngle := Value;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectStopAngle(Handle: Integer; Value: Double);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject   := GetObject(Handle);
  iDrawObject.StopAngle := Value;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectStartAngle(Handle: Integer): Double;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject   := GetObject(Handle);
  Result := iDrawObject.StartAngle;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectStopAngle(Handle: Integer): Double;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject   := GetObject(Handle);
  Result := iDrawObject.StopAngle;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectSize(Handle: Integer; Width, Height: Double);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject        := GetObject(Handle);
  iDrawObject.Width  := Width;
  iDrawObject.Height := Height;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectSizeHeight(Handle: Integer; Height: Double);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject        := GetObject(Handle);
  iDrawObject.Height := Height;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetObjectSizeWidth(Handle: Integer; Width: Double);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject        := GetObject(Handle);
  iDrawObject.Width  := Width;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectSizeHeight(Handle: Integer): Double;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.Height;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetObjectSizeWidth(Handle: Integer): Double;
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);
  Result := iDrawObject.Width;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.ObjectAddPolyPoint(Handle: Integer; X, Y: Double);
var
  iDrawObject : TiDrawObject;
  PointDouble : TPointDouble;
begin
  iDrawObject := GetObject(Handle);
  PointDouble.x := X;
  PointDouble.y := Y;
  iDrawObject.AddPolyPoint(PointDouble);
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.ObjectClearPolyPoints(Handle: Integer);
begin
  GetObject(Handle).ClearPolyPoints;
  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.ShiftObject(Handle: Integer; XDelta, YDelta: Double);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);

  iDrawObject.X := iDrawObject.X + XDelta;
  iDrawObject.Y := iDrawObject.Y + YDelta;

  if iDrawObject.AType = tidoLine then
    begin
      iDrawObject.Width  := iDrawObject.Width  + XDelta;
      iDrawObject.Height := iDrawObject.Height + YDelta;
    end;

  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.ShiftObjectX(Handle: Integer; XDelta: Double);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);

  SetObjectPositionX(Handle, GetObjectPositionX(Handle) + XDelta);

  if iDrawObject.AType = tidoLine then
    begin
      iDrawObject.Width  := iDrawObject.Width  + XDelta;
    end;

  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.ShiftObjectY(Handle: Integer; YDelta: Double);
var
  iDrawObject : TiDrawObject;
begin
  iDrawObject := GetObject(Handle);

  SetObjectPositionY(Handle, GetObjectPositionY(Handle) + YDelta);

  if iDrawObject.AType = tidoLine then
    begin
      iDrawObject.Height := iDrawObject.Height + YDelta;
    end;

  NeedsRedraw;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.iPaintTo(Canvas: TCanvas);
var
  i, Index        : Integer;
  iDrawObject     : TiDrawObject;
  CenterPoint     : TPoint;
  APoint          : TPoint;
  ScaleXFactor    : Double;
  ScaleYFactor    : Double;
  StartEndPoint   : TPoint;
  StopEndPoint    : TPoint;
  PointArray      : PointDynamicArray;
begin
  CenterPoint := GetCenterPoint(Canvas);
  ScaleXFactor := Width /FDisplayRangeX;
  ScaleYFactor := Height/FDisplayRangeY;

  with Canvas, iDrawObject do
    begin
      DrawBackGround(Canvas, BackGroundColor);
      for i := 0 to FObjectList.Count - 1 do
        begin
          iDrawObject := FObjectList.Objects[i] as TiDrawObject;
          if not iDrawObject.Visible then Continue;
          case iDrawObject.AType of
            tidoEllipse   : begin
                              Brush.Color := iDrawObject.BrushColor;
                              Brush.Style := iDrawObject.BrushStyle;

                              Pen.Color := iDrawObject.PenColor;
                              Pen.Style := iDrawObject.PenStyle;
                              Pen.Width := iDrawObject.PenWidth;

                              DrawRect := Rect(TruncHalf( (iDrawObject.X  - FOriginX - iDrawObject.Width /2)*ScaleXFactor) + CenterPoint.X,
                                               TruncHalf(-(iDrawObject.Y  - FOriginY + iDrawObject.Height/2)*ScaleYFactor) + CenterPoint.Y,
                                               TruncHalf( (iDrawObject.X  - FOriginX + iDrawObject.Width /2)*ScaleXFactor) + CenterPoint.X,
                                               TruncHalf(-(iDrawObject.Y  - FOriginY - iDrawObject.Height/2)*ScaleYFactor) + CenterPoint.Y);

                                if ABS(DrawRect.Left - DrawRect.Right) < 2 then
                                  begin
                                    DrawRect.Right := DrawRect.Left + 2;
                                  end;

                                if ABS(DrawRect.Top - DrawRect.Bottom) < 2 then   
                                  begin
                                    DrawRect.Bottom := DrawRect.Top + 2;
                                  end;

                              Ellipse(DrawRect.Left, DrawRect.Top, DrawRect.Right, DrawRect.Bottom);

                              if Trim(iDrawObject.FontCaption) <> '' then DrawObjectText(Canvas, iDrawObject, CenterPoint, ScaleXFactor, ScaleYFactor);
                            end;
            tidoRectangle : begin
                              Brush.Color := iDrawObject.BrushColor;
                              Brush.Style := iDrawObject.BrushStyle;

                              Pen.Color := iDrawObject.PenColor;
                              Pen.Style := iDrawObject.PenStyle;
                              Pen.Width := iDrawObject.PenWidth;

                              DrawRect := Rect(TruncHalf( (iDrawObject.X  - FOriginX - iDrawObject.Width /2)*ScaleXFactor) + CenterPoint.X,
                                               TruncHalf(-(iDrawObject.Y  - FOriginY + iDrawObject.Height/2)*ScaleYFactor) + CenterPoint.Y,
                                               TruncHalf( (iDrawObject.X  - FOriginX + iDrawObject.Width /2)*ScaleXFactor) + CenterPoint.X,
                                               TruncHalf(-(iDrawObject.Y  - FOriginY - iDrawObject.Height/2)*ScaleYFactor) + CenterPoint.Y);

                                if ABS(DrawRect.Left - DrawRect.Right) < 2 then
                                  begin
                                    DrawRect.Right := DrawRect.Left + 2;
                                  end;

                                if ABS(DrawRect.Top - DrawRect.Bottom) < 2 then
                                  begin
                                    DrawRect.Bottom := DrawRect.Top + 2;
                                  end;

                              Rectangle(DrawRect.Left, DrawRect.Top, DrawRect.Right, DrawRect.Bottom);

                              if Trim(iDrawObject.FontCaption) <> '' then DrawObjectText(Canvas, iDrawObject, CenterPoint, ScaleXFactor, ScaleYFactor);
                            end;  
            tidoArc       : begin
                              Brush.Color := iDrawObject.BrushColor;
                              Brush.Style := iDrawObject.BrushStyle;

                              Pen.Color := iDrawObject.PenColor;
                              Pen.Style := iDrawObject.PenStyle;
                              Pen.Width := iDrawObject.PenWidth;

                              DrawRect := Rect(TruncHalf( (iDrawObject.X  - FOriginX - iDrawObject.Width /2)*ScaleXFactor) + CenterPoint.X,
                                               TruncHalf(-(iDrawObject.Y  - FOriginY + iDrawObject.Height/2)*ScaleYFactor) + CenterPoint.Y,
                                               TruncHalf( (iDrawObject.X  - FOriginX + iDrawObject.Width /2)*ScaleXFactor) + CenterPoint.X,
                                               TruncHalf(-(iDrawObject.Y  - FOriginY - iDrawObject.Height/2)*ScaleYFactor) + CenterPoint.Y);

                                if ABS(DrawRect.Left - DrawRect.Right) < 2 then
                                  begin
                                    DrawRect.Right := DrawRect.Left + 2;
                                  end;

                                if ABS(DrawRect.Top - DrawRect.Bottom) < 2 then
                                  begin
                                    DrawRect.Bottom := DrawRect.Top + 2;
                                  end;

                              APoint        := Point((DrawRect.Right + DrawRect.Left) div 2, (DrawRect.Bottom + DrawRect.Top) div 2);
                              StartEndPoint := GetXYRadPoint(iDrawObject.StartAngle, Width, APoint);
                              StopEndPoint  := GetXYRadPoint(iDrawObject.StopAngle,  Width, APoint);

                              Arc(DrawRect.Left, DrawRect.Top, DrawRect.Right, DrawRect.Bottom, StartEndPoint.X, StartEndPoint.Y, StopEndPoint.X, StopEndPoint.Y);
                            end;
            tidoLine      : begin
                              Brush.Color := iDrawObject.BrushColor;

                              Pen.Color   := iDrawObject.PenColor;
                              Pen.Style   := iDrawObject.PenStyle;
                              Pen.Width   := iDrawObject.PenWidth;

                              DrawRect := Rect(TruncHalf( (iDrawObject.X      - FOriginX)*ScaleXFactor) + CenterPoint.X,
                                               TruncHalf(-(iDrawObject.Y      - FOriginY)*ScaleYFactor) + CenterPoint.Y,
                                               TruncHalf( (iDrawObject.Width  - FOriginX)*ScaleXFactor) + CenterPoint.X,
                                               TruncHalf(-(iDrawObject.Height - FOriginY)*ScaleYFactor) + CenterPoint.Y);

                              Polyline([Point(DrawRect.Left, DrawRect.Top), Point(DrawRect.Right, DrawRect.Bottom)]);
                            end;
            tidoText      : DrawObjectText(Canvas, iDrawObject, CenterPoint, ScaleXFactor, ScaleYFactor);
            tidoImage     : begin
                              Brush.Style := bsSolid;
                              Brush.Color := BackGroundColor;

                              DrawRect := Rect(TruncHalf( (iDrawObject.X - FOriginX)*ScaleXFactor) + CenterPoint.X - FImageList.Width   div 2,
                                               TruncHalf(-(iDrawObject.Y - FOriginY)*ScaleYFactor) + CenterPoint.Y - FImageList.Height  div 2,
                                               TruncHalf( (iDrawObject.X - FOriginX)*ScaleXFactor) + CenterPoint.X + FImageList.Width   div 2,
                                               TruncHalf(-(iDrawObject.Y - FOriginY)*ScaleYFactor) + CenterPoint.Y + FImageList.Height  div 2);

                              {$ifdef iVCL}
                              if (iDrawObject.ImageRotation = 0) then
                                begin
                                  FImageList.Draw(Canvas,
                                                  TruncHalf( (iDrawObject.X      - FOriginX)*ScaleXFactor) + CenterPoint.X - FImageList.Width  div 2,
                                                  TruncHalf(-(iDrawObject.Y      - FOriginY)*ScaleYFactor) + CenterPoint.Y - FImageList.Height div 2,
                                                  iDrawObject.ImageIndex,
                                                  True);
                                end
                              else
                                begin
                                  if not Assigned(FImage) then FImage := TBitmap.Create;

                                  FImageList.GetBitmap(iDrawObject.ImageIndex, FImage);

                                  if Assigned(FImageRotated) then
                                    begin
                                      FImageRotated.Free;
                                      FImageRotated := nil;
                                    end;

                                  FImageRotated := RotateBitmap(FImage, iDrawObject.ImageRotation);
                                  
                                  Canvas.Draw(TruncHalf( (iDrawObject.X      - FOriginX)*ScaleXFactor) + CenterPoint.X - FImageRotated.Width  div 2,
                                              TruncHalf(-(iDrawObject.Y      - FOriginY)*ScaleYFactor) + CenterPoint.Y - FImageRotated.Height div 2,
                                              FImageRotated);
                                end;

                              {$endif}
                              {$ifdef iCLX}
                              FImageList.Draw(Canvas,
                                              TruncHalf( (iDrawObject.X      - FOriginX)*ScaleXFactor) + CenterPoint.X - FImageList.Width  div 2,
                                              TruncHalf(-(iDrawObject.Y      - FOriginY)*ScaleYFactor) + CenterPoint.Y - FImageList.Height div 2,
                                              iDrawObject.ImageIndex,
                                              itImage);
                              {$endif}
                            end;
            tidoPolygon   : begin
                              SetLength(PointArray,  iDrawObject.PolyPointCount);
                              try
                                Brush.Color := iDrawObject.BrushColor;
                                Brush.Style := iDrawObject.BrushStyle;

                                Pen.Color := iDrawObject.PenColor;
                                Pen.Style := iDrawObject.PenStyle;
                                Pen.Width := iDrawObject.PenWidth;

                                for Index := 0 to iDrawObject.PolyPointCount-1 do
                                  begin
                                    PointArray[Index].X := TruncHalf( (iDrawObject.PolyPoint[Index].x - FOriginX)*ScaleXFactor) + CenterPoint.X;
                                    PointArray[Index].Y := TruncHalf(-(iDrawObject.PolyPoint[Index].y - FOriginY)*ScaleYFactor) + CenterPoint.Y;
                                  end;

                                Polygon(PointArray);

                              finally
                                PointArray := nil;
                              end;
                            end;
          end;
        end;
    end;
    
  {$ifdef iVCL}if not TransParent then DrawBorder(Canvas);{$endif}
  {$ifdef iCLX}                        DrawBorder(Canvas);{$endif}
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.DrawObjectText(Canvas: TCanvas; iDrawObject: TiDrawObject; CenterPoint: TPoint; ScaleXFactor, ScaleYFactor: Double);
var
  FontStyle       : TFontStyles;
  ATextWidth      : Integer;
  ATextHeight     : Integer;
  TextCenterPoint : TPoint;
begin
  with Canvas do
    begin
      Brush.Color := iDrawObject.BrushColor;
      Brush.Style := iDrawObject.BrushStyle;

      FontStyle := [];
      if iDrawObject.FontBold      then Include(FontStyle, fsBold);
      if iDrawObject.FontItalic    then Include(FontStyle, fsItalic);
      if iDrawObject.FontUnderLine then Include(FontStyle, fsUnderline);
      if iDrawObject.FontStrikeOut then Include(FontStyle, fsStrikeOut);

      Font.Name   := iDrawObject.FontName;
      Font.Color  := iDrawObject.FontColor;
      Font.Size   := iDrawObject.FontSize;
      Font.Style  := FontStyle;

      TextCenterPoint := Point(TruncHalf( (iDrawObject.X  - FOriginX)*ScaleXFactor) + CenterPoint.X,
                               TruncHalf(-(iDrawObject.Y  - FOriginY)*ScaleYFactor) + CenterPoint.Y);

      ATextWidth  := TextWidth (iDrawObject.FontCaption);
      ATextHeight := TextHeight(iDrawObject.FontCaption);
      TextOut(TextCenterPoint.X - ATextWidth div 2,TextCenterPoint.Y - ATextHeight div 2, iDrawObject.FontCaption);
      iDrawObject.DrawRect := Rect(TextCenterPoint.X - ATextWidth div 2, TextCenterPoint.Y - ATextHeight div 2,
                                   TextCenterPoint.X + ATextWidth div 2, TextCenterPoint.Y + ATextHeight div 2); 
    end;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i           : Integer;
  ARect       : TRect;
  iDrawObject : TiDrawObject;
begin
  FMouseDown       := True;
  FMouseDownHandle := -1;

  for i := FObjectList.Count - 1 downto 0 do
    begin
      iDrawObject := FObjectList.Objects[i] as TiDrawObject;
      ARect := iDrawObject.DrawRect;
      if PtInRect(ARect, Point(X,Y)) then
        begin
          FMouseDownHandle := StrToInt(FObjectList.Strings[i]);
          Break;
        end;
    end;

  if Assigned(FOnMouseDownDisplay) then FOnMouseDownDisplay(Self, Button, Shift, GetPixelsXToDisplayX(X), GetPixelsYToDisplayY(Y));
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.iMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseMoveDisplay) then FOnMouseMoveDisplay(Self, Shift, GetPixelsXToDisplayX(X), GetPixelsYToDisplayY(Y));
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  iDrawObject : TiDrawObject;
begin
  FMouseDown := False;

  if Assigned(FOnMouseUpDisplay) then FOnMouseUpDisplay(Self, Button, Shift, GetPixelsXToDisplayX(X), GetPixelsYToDisplayY(Y));

  if FMouseDownHandle <> - 1 then
    begin
      iDrawObject := GetObject(FMouseDownHandle);
      if PtInRect(iDrawObject.DrawRect, Point(X,Y)) then
        begin
          if Assigned(FOnClickObject) then FOnClickObject(Self, FMouseDownHandle);
        end;
    end;
  FMouseDownHandle := -1;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.iDoKillFocus;
begin
  inherited;
  FMouseDown       := False;
  FMouseDownHandle := -1;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetPixelsXToDisplayX(Value: Integer): Double;
begin
  Result := FDisplayRangeX * (Value/Width) + FOriginX - FDisplayRangeX/2;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetPixelsYToDisplayY(Value: Integer): Double;
begin
  Result := FDisplayRangeY * (1 - Value/Height) + FOriginY - FDisplayRangeY/2;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetDisplayXToPixelsX(Value: Double): Integer;
begin
  if FDisplayRangeX <> 0 then
    Result := Trunc((2*Width*Value - 2*Width*FOriginX + FDisplayRangeX*Width)/(2*FDisplayRangeX))
  else
    Result := 0;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetDisplayYToPixelsY(Value: Double): Integer;
begin
  if FDisplayRangeY <> 0 then
    Result := Trunc((2*Height*FDisplayRangeY + 2*Height*FOriginY - Height*FDisplayRangeY - 2*Height*Value)/(2*FDisplayRangeY))
  else
    Result := 0;
end;
//*************************************************************************************************************************************
function TiObjectCanvas.GetImageListCount : Integer;begin Result := FImageList.Count; end;
function TiObjectCanvas.GetImageListHeight: Integer;begin Result := FImageList.Height;end;
function TiObjectCanvas.GetImageListWidth : Integer;begin Result := FImageList.Width; end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetImageListHeight(const Value: Integer);begin FImageList.Height := Value;end;
procedure TiObjectCanvas.SetImageListWidth (const Value: Integer);begin FImageList.Width  := Value;end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.ImageListDelete(Index: Integer);
begin
  FImageList.Delete(Index);
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.ImageListRemoveAll;
begin
  while FImageList.Count > 0 do
    FImageList.Delete(0);
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.ImageListAdd(Bitmap: TBitmap);
begin
  FImageList.InsertMasked(FImageList.Count, Bitmap, Bitmap.TransparentColor);
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.SetImageList(ImageList: TImageList);
begin
  if Assigned(ImageList) then
    begin
      if Assigned(FImageList) then FImageList.Free;
      FImageList := ImageList;
    end;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.DefineProperties(Filer: TFiler);
begin
  Filer.DefineBinaryProperty('ImageList', ReadImageList, WriteImageList, FImageList.Count <> 0);
  inherited;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.ImageListLoadFromBitmap(ABitmap: TBitmap);
var
  BBitmap    : TBitmap;
  OffsetX    : Integer;
  OffsetY    : Integer;
  AImageList : TImageList;
begin
  AImageList := FImageList;

  if AImageList.Count = 0 then
    begin
      AImageList.Width  := ABitmap.Width;
      AImageList.Height := ABitmap.Height;
    end
  else if (ABitmap.Width < AImageList.Width) and (ABitmap.Height < AImageList.Height) then
    begin
      BBitmap := TBitmap.Create;
      try
        BBitmap.Width  := AImageList.Width;
        BBitmap.Height := AImageList.Height;

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
  else if (ABitmap.Width > AImageList.Width) and (ABitmap.Height > AImageList.Height) then
    begin

    end
  else if (ABitmap.Width <> AImageList.Width) and (ABitmap.Height <> AImageList.Height) then
    raise Exception.Create('Image Width and Height must be the same as other images, or both smaller, or both larger');

  AImageList.InsertMasked(AImageList.Count, ABitmap, ABitmap.TransparentColor);

  InvalidateChange;
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.ImageListLoadFromResourceID(Instance: Cardinal; ResID: Integer);
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
//*************************************************************************************************************************************
procedure TiObjectCanvas.ImageListLoadFromResourceName(Instance: Cardinal; ResName: String);
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
//*************************************************************************************************************************************
procedure TiObjectCanvas.ReadImageList(Stream: TStream);
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
end;
//*************************************************************************************************************************************
procedure TiObjectCanvas.WriteImageList(Stream: TStream);
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
function TiObjectCanvas.RotateBitmap(const Bitmap : TBitmap; const Angle : Double): TBitmap;
var
  SinAngle        : Extended;
  CosAngle        : Extended;
  x               : Integer;
  y               : Integer;
  OriginalX       : Integer;
  OriginalY       : Integer;
  NewX            : Integer;
  NewY            : Integer;
  //KYLIX TODO
  {$ifndef iCLX}
  RowOriginal     : pRGBTripleArray;
  RowRotated      : pRGBTRipleArray;
  {$endif}
  CenterPoint     : TPoint;
  NewYSinAngle    : Double;
  NewYCosAngle    : Double;
  ANewSize        : Integer;
  ABitmap         : TBitmap;
begin
  Bitmap.Transparent := True;
  ANewSize           := Round(Sqrt(Sqr(Bitmap.Width) + Sqr(Bitmap.Height)));
  ABitmap            := TBitmap.Create;
  try
    ABitmap.Width      := ANewSize;
    ABitmap.Height     := ANewSize;

    ABitmap.Canvas.Brush.Color := BackGroundColor;
    ABitmap.Canvas.FillRect(Rect(0, 0, ABitmap.Width, ABitmap.Height));
    ABitmap.Canvas.Draw(ABitmap.Width  div 2 - Bitmap.Width  div 2,
                        ABitmap.Height div 2 - Bitmap.Height div 2,
                        Bitmap);

    //KYLIX TODO
    {$ifndef iCLX}
    ABitmap.PixelFormat := pf24bit;
    {$endif}
    Result             := TBitmap.Create;
    Result.Width       := ABitmap.Width;
    Result.Height      := ABitmap.Height;
    //KYLIX TODO
    {$ifndef iCLX}
    Result.PixelFormat := pf24bit;
    {$endif}

    Result.Canvas.Brush.Color := BackGroundColor;
    Result.Canvas.FillRect(Rect(0,0,Result.Width, Result.Height));

    CenterPoint := Point(ABitmap.Width div 2, ABitmap.Height div 2);

    SinCos(Angle/360 * 2*Pi, SinAngle, CosAngle);

    for y := Result.Height-1 downto 0 do
      begin
        //KYLIX TODO
        {$ifndef iCLX}
        RowRotated := Result.Scanline[y];
        {$endif}
        NewY       := y - CenterPoint.Y;

        NewYSinAngle := NewY * SinAngle;
        NewYCosAngle := NewY * CosAngle;

        for x := Result.Width-1 downto 0 do
        begin
          NewX := x - CenterPoint.X;
          OriginalX := CenterPoint.X + Round(NewX * CosAngle - NewYSinAngle);
          OriginalY := CenterPoint.Y + Round(NewX * SinAngle + NewYCosAngle);

          if (OriginalX >= 0) and (OriginalX <= (Result.Width -1)) and (OriginalY >= 0) and (OriginalY <= (Result.Height-1)) then
            begin
              //KYLIX TODO
              {$ifndef iCLX}
              RowOriginal   := ABitmap.Scanline[OriginalY];
              RowRotated[x] := RowOriginal[OriginalX]
              {$endif}
            end;
        end;
      end;
  finally
    ABitmap.Free;
  end;
end;
//*************************************************************************************************************************************
end.


