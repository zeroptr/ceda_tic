
{                                                                              }
{ TIB_JPEGImage                                                                }
{                                                                              }

{: This unit contains an effort to make a data aware JPEG image component.

It is still a pre-BETA control. All input and debugging tips would be
appreciated.

It is based on the JPGIMG.PAS class written by:

TJPEGImage component version 1.2       Luciano Bajo Eloy - Sep 9, 1997
                                       Madrid, Spain
                                       E-mail: lbe20@tid.es

                                       Andreas Hoerstemeier - Oct 19, 1997
                                       Aachen, Germany
                                       E-Mail: andy@hoerstemeier.de
                                       WWW: http://www.westend.de/~hoerstemeier
}
unit
  IB_JPEGImage;

{$define TWO_FILE_COMMANDLINE}
{$define BMP_SUPPORTED}

//{ $ I jconfig.inc}

{$INCLUDE IB_Directives.inc}

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Forms, Graphics, Menus,
  StdCtrls, ExtCtrls, ComCtrls, Mask, Buttons, Dialogs, Clipbrd, JpgImg,

  IB_Header,
  IB_Session,
  IB_Components,
  IB_FieldDataLink,

  jmorecfg,
  jpeglib,
  jerror,
  jdeferr,
  jdapimin, jdapistd, jdatasrc, wrbmp,
  cdjpeg;               { Common decls for cjpeg/djpeg applications }

type
{: This control has been designed to display JPEG images from a BLOB column.

It is possible to change the image by assigning a new image to the Picture
property of the control. The clipboard has also been enabled to transfer
images in and out of the control.}
TIB_JPEGImage = class( TCustomControl )
private
  FNumOfColors: TNumOfColors;
  FDCTMethod: TDCTMethod;
  FDither: TDither;
  FFastProcessing, FGrayScale, FNoSmooth, FOnePass: Boolean;
  FProgressStep: TDelta;
  FOnProgress: TNotifyEvent;
  OutStream: TMemoryStream;
  {Procs for properties}
  procedure SetNumOfColors(Value: TNumOfColors);
  procedure SetDCTMethod(Value: TDCTMethod);
  procedure SetDither(Value: TDither);
  procedure SetBoolValue(Index: Integer; Value: Boolean);
private
  FIB_FieldDataLink: TIB_FieldDataLink;
  FPicture: TPicture;
  FBorderStyle: TBorderStyle;
  FAutoDisplay: boolean;
  FPictureLoaded: boolean;
  FIsUpdating: boolean;
  FIgnorePictureChange: boolean;
  procedure IB_StateChanged( Sender: TIB_DataLink;
                             DataSource: TIB_DataSource );
  procedure IB_DataChange( Sender: TIB_DataLink;
                           DataSource: TIB_DataSource;
                           Field: TIB_Column );
  procedure IB_UpdateData( Sender: TIB_DataLink;
                           DataSource: TIB_DataSource;
                           Field: TIB_Column );
  function GetSearchBuffer: string;
  procedure SetSearchBuffer( AValue: string );
  procedure SetDataField( const AValue: string );
  procedure SetDataSource( AValue: TIB_DataSource );
  function GetReadOnly: Boolean;
  function GetPreventEditing: Boolean;
  function GetPreventInserting: Boolean;
  procedure SetReadOnly(Value: Boolean);
  procedure SetPreventEditing( Value: Boolean );
  procedure SetPreventInserting( Value: Boolean );
  function GetDataField: string;
  function GetDataSource: TIB_DataSource;
  function GetField: TIB_Column;
  procedure PictureChanged(Sender: TObject);
  procedure SetAutoDisplay(Value: Boolean);
  procedure SetBorderStyle(Value: TBorderStyle);
  procedure SetPicture(Value: TPicture);
  procedure SetOnPrepareSQL( AValue: TIB_DataLinkEvent); virtual;
  function GetOnPrepareSQL: TIB_DataLinkEvent; virtual;
  procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
  procedure CMExit(var Message: TCMExit); message CM_EXIT;
  procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
  procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
  procedure WMCut(var Message: TMessage); message WM_CUT;
  procedure WMCopy(var Message: TMessage); message WM_COPY;
  procedure WMPaste(var Message: TMessage); message WM_PASTE;
  procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
protected
  procedure parse_switches( cinfo :j_decompress_ptr;
                            last_file_arg_seen: int;
                            for_real: boolean );
  procedure UpdateIMG;
protected
  procedure CreateParams(var Params: TCreateParams); override;
  function GetPalette: HPALETTE; override;
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  procedure KeyPress(var Key: Char); override;
  procedure Paint; override;
  procedure Loaded; override;
  procedure SysDataChange;
  property DataLink: TIB_FieldDataLink read FIB_FieldDataLink;
  procedure SetName( const AValue: TComponentName ); override;

public
  procedure LoadFromStream(value:TStream);

public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
{: Place a copy the contents of the image onto the clipboard.}
  procedure CopyToClipboard;
{: Move the contents of the image onto the clipboard.}
  procedure CutToClipboard;
{: Make sure that the image is loaded from the BLOB column.

This should not need to be called if AutoDisplay is true. }
  procedure LoadPicture;
{: Copy the image data from the clipboard into the control.}
  procedure PasteFromClipboard;
{: Access to the column to which this control is bound.}
  property Field: TIB_Column read GetField;
{: This property gives access to the image data for runtime manipulation.}
  property Picture: TPicture read FPicture write SetPicture;
{: Gives run-time access to the search buffer of this control's datalink.}
  property SearchBuffer: string read GetSearchBuffer write SetSearchBuffer;

published
  property NumOfColors: TNumOfColors read FNumOfColors write SetNumOfColors;
  property DCTMethod: TDCTMethod read FDCTMethod write SetDCTMethod;
  property Dither: TDither read FDither write SetDither;
  property FastProcessing: Boolean index 0 read FFastProcessing write SetBoolValue;
  property GrayScale: Boolean index 1 read FGrayScale write SetBoolValue;
  property NoSmooth: Boolean index 2 read FNoSmooth write SetBoolValue;
  property OnePass: Boolean index 3 read FOnePass write SetBoolValue;
  property ProgressStep: TDelta read FProgressStep write FProgressStep;
  property OnProgress: TNotifyEvent read FOnProgress write FOnProgress;

published

{: This property allows the BLOB contents to automatically be loaded in or
to remain unloaded until the user double-clicks on it or presses ENTER.}
  property AutoDisplay: Boolean read FAutoDisplay
                                write SetAutoDisplay
                                default True;
{: Name of the column to which this control is bound.}
  property DataField: string read GetDataField write SetDataField;
{: Reference to the dataset to which this control is bound.}
  property DataSource: TIB_DataSource read GetDataSource write SetDataSource;
{: Determines if any editing changes can be made through this control.}
  property PreventEditing: boolean read GetPreventEditing
                                   write SetPreventEditing
                                   default false;
{: Determines if any inserting changes can be made through this control.}
  property PreventInserting: boolean read GetPreventInserting
                                     write SetPreventInserting
                                     default false;
{: Prevent any modifications to the image data in the control.}
  property ReadOnly: boolean read GetReadOnly write SetReadOnly default false;
{: This event allows for custom alterations to be made to the SELECT
statement's WHERE clause at prepare time.}
  property OnPrepareSQL: TIB_DataLinkEvent read GetOnPrepareSQL
                                           write SetOnPrepareSQL;

published

  property Align;
  property BorderStyle: TBorderStyle read FBorderStyle
                                            write SetBorderStyle
                                            default bsSingle;
  property Color;
  property Ctl3D;
  property DragCursor;
  property DragMode;
  property Enabled;
  property Font;
  property ParentColor default false;
  property ParentCtl3D;
  property ParentFont;
  property ParentShowHint;
  property PopupMenu;
  property ShowHint;
  property TabOrder;
  property TabStop default true;
  property Visible;

  property OnClick;
  property OnDblClick;
  property OnDragDrop;
  property OnDragOver;
  property OnEndDrag;
  property OnEnter;
  property OnExit;
  property OnKeyDown;
  property OnKeyPress;
  property OnKeyUp;
  property OnMouseDown;
  property OnMouseMove;
  property OnMouseUp;
  property OnStartDrag;

end;

implementation

constructor TIB_JPEGImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NumOfColors := _256;
  DCTMethod := Integ;
  Dither := FS;
  GrayScale := False;
  NoSmooth := False;
  OnePass := False;
  FProgressStep := 10;
  ControlStyle := ControlStyle + [csFramed, csOpaque];
  Width := 105;
  Height := 105;
  TabStop := true;
  ParentColor := false;
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  FBorderStyle := bsSingle;
  FAutoDisplay := true;
  FIB_FieldDataLink := TIB_FieldDataLink.Create( Self );
  with FIB_FieldDataLink do begin
    Control := Self;
    OnStateChanged := IB_StateChanged;
    OnDataChange := IB_DataChange;
    OnUpdateData := IB_UpdateData;
  end;
end;

destructor TIB_JPEGImage.Destroy;
begin
  DataSource := nil;
  with DataLink do begin
    Control := nil;
    OnStateChanged := nil;
    OnDataChange := nil;
    OnUpdateData := nil;
  end;
  Destroying;
  FPicture.Free;
  FPicture := nil;
  inherited Destroy;
end;

procedure TIB_JPEGImage.Loaded;
begin
  inherited Loaded;
  SysDataChange;
end;

procedure TIB_JPEGImage.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(DataLink);
end;

procedure TIB_JPEGImage.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  IB_StateChanged( DataLink, DataLink.DataSource );
end;

{------------------------------------------------------------------------------}

procedure TIB_JPEGImage.IB_StateChanged( Sender: TIB_DataLink;
                                     DataSource: TIB_DataSource );
begin
  with DataLink do begin
    if ColorScheme then begin
      inherited Color := Color;
    end;
  end;
end;

procedure TIB_JPEGImage.IB_DataChange( Sender: TIB_DataLink;
                                   DataSource: TIB_DataSource;
                                   Field: TIB_Column );
begin
  if not FIsUpdating and not FIgnorePictureChange then begin
    SysDataChange;
  end;
end;

procedure TIB_JPEGImage.IB_UpdateData( Sender: TIB_DataLink;
                                   DataSource: TIB_DataSource;
                                   Field: TIB_Column );
begin
  with DataLink do begin
    if ControlIsModified then begin
      if Assigned( Field ) and Field.IsBlob and not FIsUpdating then begin
        with Field as TIB_ColumnBlob do begin
          FIsUpdating := true;
          try
            if Assigned( Picture.Graphic ) and
               ( not Picture.Graphic.Empty ) then begin
              Assign( Picture.Graphic );
            end else begin
              Clear;
            end;
          finally
            FPictureLoaded := true;
            FIsUpdating := false;
          end;
        end;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TIB_JPEGImage.SysDataChange;
begin
  if Assigned( Field ) and Field.IsBlob then begin
    with Field as TIB_ColumnBlob do begin

        FIgnorePictureChange := true;
        try
          Picture.Graphic := nil;
        finally
          FIgnorePictureChange := false;
        end;
        FPictureLoaded := false;
        if AutoDisplay then begin
          LoadPicture;
        end;

    end;
  end;
end;

procedure TIB_JPEGImage.LoadPicture;
begin
  if not FPictureLoaded and not FIgnorePictureChange then begin
    FIgnorePictureChange := true;
    try
      FPictureLoaded := true;
      if Assigned( Field ) and not Field.IsNull and Field.IsBlob then begin
        UpdateIMG;
      end else begin
        Picture.Graphic := nil;
      end;
    finally
      FIgnorePictureChange := false;
      FPictureLoaded := false;
    end;
  end;
end;

procedure TIB_JPEGImage.PictureChanged(Sender: TObject);
begin
  if AutoSize and ( Align <> alClient ) then begin
    if (Picture.Width > 0) and (Picture.Height > 0) then begin
      SetBounds(Left, Top, Picture.Width, Picture.Height);
    end else begin
      SetBounds(Left, Top, 100, 100);
    end;
  end;
  if not FIgnorePictureChange then begin
    with DataLink do begin
      if Modify then begin
        ControlIsModified := true;
        FPictureLoaded := true;
        if not Focused then begin
          UpdateRecord;
        end;
      end;
    end;
  end;
  Invalidate;
end;

{------------------------------------------------------------------------------}
function TIB_JPEGImage.GetOnPrepareSQL: TIB_DataLinkEvent;
begin Result := DataLink.OnPrepareSQL; end;
procedure TIB_JPEGImage.SetOnPrepareSQL( AValue: TIB_DataLinkEvent);
begin DataLink.OnPrepareSQL := AValue; end;
function TIB_JPEGImage.GetDataSource: TIB_DataSource;
begin Result := DataLink.DataSource; end;
function TIB_JPEGImage.GetField: TIB_Column;
begin Result := DataLink.Field; end;
function TIB_JPEGImage.GetDataField: string;
begin Result := DataLink.FieldName; end;
function TIB_JPEGImage.GetReadOnly: Boolean;
begin Result := DataLink.ControlIsReadOnly; end;
function TIB_JPEGImage.GetPreventEditing: Boolean;
begin Result := DataLink.ControlPreventsEditing; end;
function TIB_JPEGImage.GetPreventInserting: Boolean;
begin Result := DataLink.ControlPreventsInserting; end;
procedure TIB_JPEGImage.SetReadOnly( Value: Boolean );
begin DataLink.ControlIsReadOnly := Value; end;
procedure TIB_JPEGImage.SetPreventEditing( Value: Boolean );
begin DataLink.ControlPreventsEditing := Value; end;
procedure TIB_JPEGImage.SetPreventInserting( Value: Boolean );
begin DataLink.ControlPreventsInserting := Value; end;
function TIB_JPEGImage.GetSearchBuffer: string;
begin Result := DataLink.SearchBuffer; end;
procedure TIB_JPEGImage.SetSearchBuffer( AValue: string );
begin DataLink.SearchBuffer := AValue; end;
procedure TIB_JPEGImage.SetDataSource( AValue: TIB_DataSource );
begin DataLink.DataSource := AValue; end;
procedure TIB_JPEGImage.SetDataField( const AValue: string );
begin DataLink.FieldName := AValue; end;
{------------------------------------------------------------------------------}

function TIB_JPEGImage.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic is TBitmap then
    Result := TBitmap(FPicture.Graphic).Palette;
end;

procedure TIB_JPEGImage.SetAutoDisplay( Value: Boolean );
begin
  if AutoDisplay <> Value then begin
    FAutoDisplay := Value;
    if Value then LoadPicture;
  end;
end;

procedure TIB_JPEGImage.SetBorderStyle( Value: TBorderStyle );
begin
  if FBorderStyle <> Value then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

{
procedure TIB_JPEGImage.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then begin
    FCenter := Value;
    Invalidate;
  end;
end;
}

procedure TIB_JPEGImage.SetPicture(Value: TPicture);
begin
  FPicture.Assign( Value );
end;

{
procedure TIB_JPEGImage.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then begin
    FStretch := Value;
    Invalidate;
  end;
end;

procedure TIB_JPEGImage.SetKeepScale(Value: Boolean);
begin
  if FKeepScale <> Value then begin
    FKeepScale := Value;
    Invalidate;
  end;
end;

procedure TIB_JPEGImage.SetAutoSize(Value: Boolean);
begin
  if AutoSize <> Value then begin
    FAutoSize := Value;
    if AutoSize then Align := alNone;
    FIgnorePictureChange := true;
    try
      PictureChanged( Picture );
    finally
      FIgnorePictureChange := false;
    end;
  end;
end;
}

{------------------------------------------------------------------------------}

procedure TIB_JPEGImage.CopyToClipboard;
begin
  if Picture.Graphic <> nil then begin
    Clipboard.Assign(Picture);
  end;
end;

procedure TIB_JPEGImage.CutToClipboard;
begin
  if Picture.Graphic <> nil then begin
    if DataLink.Modify then begin
      CopyToClipboard;
      Picture.Graphic := nil;
    end;
  end;
end;

procedure TIB_JPEGImage.PasteFromClipboard;
begin
  if ( Clipboard.HasFormat( CF_BITMAP )) and
     ( DataLink.Modify ) then begin
    Picture.Bitmap.Assign( Clipboard );
  end;
end;

procedure TIB_JPEGImage.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if FBorderStyle = bsSingle then
    Params.Style := Params.Style or WS_BORDER;
end;

procedure TIB_JPEGImage.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  case Key of
  VK_INSERT:
    if ssShift in Shift then PasteFromClipBoard else
      if ssCtrl in Shift then CopyToClipBoard;
  VK_DELETE:
    if ssShift in Shift then begin
      CutToClipBoard;
    end else begin
      Picture.Graphic := nil;
    end;
  end;
end;

procedure TIB_JPEGImage.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    ^X: CutToClipBoard;
    ^C: CopyToClipBoard;
    ^V: PasteFromClipBoard;
    #13: if not FPictureLoaded then LoadPicture
                               else DataLink.UpdateRecord;
    #27: SysDataChange;
  end;
end;

procedure TIB_JPEGImage.CMEnter(var Message: TCMEnter);
begin
  Invalidate; { Draw the focus marker }
  DataLink.SetFocus;
  inherited;
end;

procedure TIB_JPEGImage.CMExit(var Message: TCMExit);
begin
  DataLink.UpdateRecord;
  Invalidate; { Erase the focus marker }
  inherited;
end;

procedure TIB_JPEGImage.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if not FPictureLoaded then Invalidate;
end;

procedure TIB_JPEGImage.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if TabStop and CanFocus then SetFocus;
  inherited;
end;

procedure TIB_JPEGImage.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  LoadPicture;
  inherited;
end;

procedure TIB_JPEGImage.WMCut(var Message: TMessage);
begin
  CutToClipboard;
end;

procedure TIB_JPEGImage.WMCopy(var Message: TMessage);
begin
  CopyToClipboard;
end;

procedure TIB_JPEGImage.WMPaste(var Message: TMessage);
begin
  PasteFromClipboard;
end;

procedure TIB_JPEGImage.Paint;
var
  R: TRect;
  S: string;
  DrawPict: TPicture;
  Pal: HPalette;
{$IFDEF IBO_VCL30_OR_GREATER}
  Form: TCustomForm;
{$ELSE}
  Form: TForm;
{$ENDIF}
begin
  with Canvas do begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    if Assigned( Field ) and
       ( FPictureLoaded or (csPaintCopy in ControlState)) then begin
      DrawPict := TPicture.Create;
      Pal := 0;
      try
        if (csPaintCopy in ControlState) and
           Assigned(Field) and Field.IsBlob then begin
          Field.AssignTo( DrawPict );
//          if DrawPict.Graphic is TBitmap then begin
//            DrawPict.Bitmap.IgnorePalette := QuickDraw;
//          end;
        end else begin
          DrawPict.Assign( Picture );
          if Focused and ( DrawPict.Graphic is TBitmap ) and
            ( DrawPict.Bitmap.Palette <> 0 ) then begin
          { Control has focus, so realize the bitmap palette in foreground }
            Pal := SelectPalette(Handle, DrawPict.Bitmap.Palette, False);
            RealizePalette(Handle);
          end;
        end;
        SetRect( R, 0, 0, DrawPict.Width, DrawPict.Height );
//        if Stretch and KeepScale then begin
//          FillRect(ClientRect);
//          if ( DrawPict.Graphic <> nil ) and
//             not DrawPict.Graphic.Empty then begin
// WIP!!!
//            tmpInt := ( R.Bottom - R.Top ) - DrawPict.Graphic.Height;
//            if tmpInt > ( R.Right - R.Left ) - DrawPict.Width then begin
//            end;
//            InflateRect( R, R.
//            StretchDraw( R, DrawPict.Graphic );
//          end;
//{        end else}
{
        if Stretch or AutoSize then begin
          if ( DrawPict.Graphic = nil ) or DrawPict.Graphic.Empty then begin
            FillRect(ClientRect);
          end else begin
            StretchDraw( ClientRect, DrawPict.Graphic );
          end;
        end else begin
          if Center then OffsetRect( R,
                                    (ClientWidth  - DrawPict.Width ) div 2,
                                    (ClientHeight - DrawPict.Height) div 2);
}
          StretchDraw( R, DrawPict.Graphic );
          ExcludeClipRect(Handle, R.Left, R.Top, R.Right, R.Bottom);
          FillRect(ClientRect);
          SelectClipRgn(Handle, 0);
//        end;
      finally
        if Pal <> 0 then SelectPalette(Handle, Pal, True);
        DrawPict.Free;
      end;
    end else begin
      Font := Self.Font;
      S := DataLink.FieldText;
      R := ClientRect;
      FillRect( R );
      TextRect( R, (R.Right  - TextWidth (S)) div 2,
                   (R.Bottom - TextHeight(S)) div 2, S );
    end;
    Form := GetParentForm(Self);
    if (Form <> nil) and (Form.ActiveControl = Self) and
      not (csDesigning in ComponentState) and
      not (csPaintCopy in ControlState) then begin
      Brush.Color := clWindowFrame;
      FrameRect(ClientRect);
    end;
  end;
end;

procedure TIB_JPEGImage.SetName( const AValue: TComponentName );
begin
  inherited SetName( AValue );
  if csDesigning in ComponentState then begin
    Invalidate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TIB_JPEGImage.parse_switches (cinfo : j_decompress_ptr;
                                    last_file_arg_seen : int;
                                    for_real : boolean);
const
  printed_version : boolean = FALSE;
begin
  { Set up default JPEG parameters. }
  requested_fmt := DEFAULT_FMT; { set default output file format }
  cinfo^.err^.trace_level := 0;
  { BMP output format. }
  requested_fmt := FMT_BMP;
  { Num of colors }
  if FNumOfColors <> TrueColor then
  begin
    case FNumOfColors of
          _16: cinfo^.desired_number_of_colors := 16;
         _256: cinfo^.desired_number_of_colors := 256;
    end;
    cinfo^.quantize_colors := TRUE;
  end;
  { DCT Method }
  case DCTMethod of
            Integ: cinfo^.dct_method := JDCT_ISLOW;
        FastInteg: cinfo^.dct_method := JDCT_IFAST;
    FloatingPoint: cinfo^.dct_method := JDCT_FLOAT;
  end;
  { Dither }
  case Dither of
       None: cinfo^.dither_mode := JDITHER_NONE;
         FS: cinfo^.dither_mode := JDITHER_FS;
    Ordered: cinfo^.dither_mode := JDITHER_ORDERED;
  end;
  { Fast Processing }
  if FFastProcessing then
  begin
    { Select recommended processing options for quick-and-dirty output. }
    cinfo^.two_pass_quantize := FALSE;
    cinfo^.dither_mode := JDITHER_ORDERED;
    if (not cinfo^.quantize_colors) then { don't override an earlier -colors }
      cinfo^.desired_number_of_colors := 216;
    cinfo^.dct_method := JDCT_FASTEST;
    cinfo^.do_fancy_upsampling := FALSE;
  end;
  { Grayscale }
  if FGrayScale then
    { Force monochrome output. }
    cinfo^.out_color_space := JCS_GRAYSCALE;
  if FNoSmooth then
    { Suppress fancy upsampling }
    cinfo^.do_fancy_upsampling := FALSE;
  if FOnePass then
    { Use fast one-pass quantization. }
    cinfo^.two_pass_quantize := FALSE;
end;

function jpeg_getc (cinfo : j_decompress_ptr) : char;
{ Read next byte }
var
  datasrc : jpeg_source_mgr_ptr;
begin
  datasrc := cinfo^.src;

  if (datasrc^.bytes_in_buffer = 0) then
  begin
    if (not datasrc^.fill_input_buffer (cinfo)) then
      ERREXIT(j_common_ptr(cinfo), JERR_CANT_SUSPEND);
  end;
  Dec(datasrc^.bytes_in_buffer);
  jpeg_getc := char(GETJOCTET(datasrc^.next_input_byte^));
  Inc(datasrc^.next_input_byte);
end;

{METHODDEF}
function COM_handler (cinfo : j_decompress_ptr) : boolean; {far;}
const
  LF = #10;
  CR = #13;
var
  length : INT32;
//?  ch : char;
//?  lastch : char;
begin
//?  lastch := #0;

  length := byte(jpeg_getc(cinfo)) shl 8;
  Inc(length, byte(jpeg_getc(cinfo)));
  Dec(length, 2);                       { discount the length word itself }

  while (length > 0) do begin
    Dec(length);
//?    ch := jpeg_getc(cinfo);
  end;
  COM_handler := TRUE;
end;

procedure TIB_JPEGImage.SetNumOfColors(Value: TNumOfColors);
begin
  FNumOfColors := Value;
  UpdateIMG;
end;

procedure TIB_JPEGImage.SetDCTMethod(Value: TDCTMethod);
begin
  FDCTMethod := Value;
  UpdateIMG;
end;

procedure TIB_JPEGImage.SetDither(Value: TDither);
begin
  FDither := Value;
  UpdateIMG;
end;

procedure TIB_JPEGImage.SetBoolValue(Index: Integer; Value: Boolean);
begin
  case Index of
    0: FFastProcessing := Value;
    1: FGrayScale := Value;
    2: FNoSmooth := Value;
    3: FOnePass := Value;
  end;
  UpdateIMG;
end;

procedure TIB_JPEGImage.UpdateIMG;
var
  cinfo : jpeg_decompress_struct;
  jerr : jpeg_error_mgr;
  dest_mgr : djpeg_dest_ptr;
  num_scanlines : JDIMENSION;
  OldProgress, NewProgress: Integer;
  f_Stream: TStream;
begin
  if (csReading in ComponentState) or not DataLink.Prepared or
                                      not Assigned( Field ) then Exit;
  f_stream := DataLink.Dataset.CreateBlobStream( Field, bsmRead );
  try
  if f_stream.size > 0 then begin
  dest_mgr := NIL;
  { Initialize the JPEG decompression object with default error handling. }
  cinfo.err := jpeg_std_error(jerr);
  jpeg_create_decompress(@cinfo);
  { Add some application-specific error messages (from cderror.h) }
  {jerr.addon_message_table := cdjpeg_message_table;}
  jerr.first_addon_message := JMSG_FIRSTADDONCODE;
  jerr.last_addon_message := JMSG_LASTADDONCODE;
  { Insert custom COM marker processor. }
  jpeg_set_marker_processor(@cinfo, JPEG_COM, COM_handler);

  { Now safe to enable signal catcher. }
{$ifdef NEED_SIGNAL_CATCHER}
  enable_signal_catcher(j_common_ptr (@cinfo));
{$endif}

  { Scan command line to find file names. }
  { It is convenient to use just one switch-parsing routine, but the switch
    values read here are ignored; we will rescan the switches after opening
    the input file.
    (Exception: tracing level set here controls verbosity for COM markers
    found during jpeg_read_header) }

  parse_switches(@cinfo, 0, FALSE);

  { Open the output stream. }
  try
    OutStream := TMemoryStream.Create;

  { Specify data source for decompression }
  jpeg_stdio_src(@cinfo, f_stream);

    { Read file header, set default decompression parameters }
    {void} jpeg_read_header(@cinfo, TRUE);

    { Adjust default decompression parameters by re-parsing the options }
    parse_switches(@cinfo, 0, TRUE);

    { Initialize the output module now to let it override any crucial
      option settings (for instance, GIF wants to force color quantization). }

    case (requested_fmt) of
  {$ifdef BMP_SUPPORTED}
    FMT_BMP:
      dest_mgr := jinit_write_bmp(@cinfo, FALSE);
  {$endif}
    else
      ERREXIT(j_common_ptr(@cinfo), JERR_UNSUPPORTED_FORMAT);
    end;
    {dest_mgr^.output_file := @output_file;}
     dest_mgr^.output_file := @OutStream;

    { Start decompressor }
    {void} jpeg_start_decompress(@cinfo);

    { Write output file header }
    dest_mgr^.start_output (@cinfo, dest_mgr);

    OldProgress := 0;
    { Process data }
    while (cinfo.output_scanline < cinfo.output_height) do
    begin
      num_scanlines := jpeg_read_scanlines(@cinfo, dest_mgr^.buffer,
                                          dest_mgr^.buffer_height);
      dest_mgr^.put_pixel_rows (@cinfo, dest_mgr, num_scanlines);
      NewProgress := (cinfo.output_scanline * 100 div cinfo.output_height);
      if (NewProgress <> OldProgress) and (NewProgress mod FProgressStep = 0) then
      begin
        OldProgress := NewProgress;
        if Assigned(FOnProgress) then
          FOnProgress(Self);
      end;
    end;

    { Finish decompression and release memory.
      I must do it in this order because output module has allocated memory
      of lifespan JPOOL_IMAGE; it needs to finish before releasing memory. }

    dest_mgr^.finish_output (@cinfo, dest_mgr);
    {void} jpeg_finish_decompress(@cinfo);
    jpeg_destroy_decompress(@cinfo);

    { All done. }
    if jerr.num_warnings <> 0 then
    begin
      OutStream.Free;
      raise EJPEGException.Create('There are warnings');
    end
    else
    begin
      OutStream.Position := 0;
      (Picture.Bitmap as TGraphic).LoadFromStream(outstream);
      {I do not know why, but the next line avoids colors to be corrupted on
       256 colors mode}
      Picture.Bitmap.Palette := Picture.Bitmap.Palette;
      OutStream.Free;
    end;
  finally
    { Close files, if we opened them }
{     system.close(input_file); }
  end;
  end;
  finally
    f_stream.Free;
  end;
end;

procedure TIB_JPEGImage.LoadFromStream(value: TStream);
var
  f_Stream: TStream;
begin
  if (csReading in ComponentState) or not DataLink.Prepared or
                                      not Assigned( Field ) then Exit;
  f_stream := DataLink.Dataset.CreateBlobStream( Field, bsmWrite );
  try
    if Assigned( value ) then begin
      f_stream.CopyFrom( Value, 0 );
    end;
  finally
    f_stream.Free;
  end;
end;

end.
