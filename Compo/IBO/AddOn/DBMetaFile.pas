
{                                                                              }
{  DBMetaFile.pas                                                              }
{                                                                              }
{  Author:  Ricardo Casillas                                                   }
{           IS / Eng. Manager                                                  }
{           Lamsco West, Inc.                                                  }
{                                                                              }

unit
  DBMetaFile;

{$R-}

interface

uses
  Windows, Messages, Classes, Controls, Forms, Menus, graphics, StdCtrls,
  ExtCtrls, DB, Mask, Buttons, DbCtrls, SysUtils, math;

  function CallMetaFile( hdc: HDC;
                         pTable: pHandleTable;
                         pEMFR: pEnhMetaRecord;
                         nObj: integer;
                         pData: LPARAM ): integer; stdcall;

type
  TDBMetaFile = class(TCustomControl)
  private
   FDataLink: TFieldDataLink;
   FMetaFile: TMetaFile;
   FBorderStyle: TBorderStyle;
   FAutoDisplay: Boolean;
   FStretch: Boolean;
   FCenter: Boolean;
   FMetaFileLoaded: Boolean;
   FQuickDraw: Boolean;
   FBorderSpace: Byte;
   FStretchRatio: Boolean;
   FWidth: Integer;
   FHeight: Integer;
   procedure DataChange(Sender: TObject);
   function GetDataField: string;
   function GetDataSource: TDataSource;
   function GetField: TField;
   function GetReadOnly: Boolean;
   procedure MetaFileChanged(Sender: TObject);
   procedure SetAutoDisplay(Value: Boolean);
   procedure SetBorderStyle(Value: TBorderStyle);
   procedure SetBorderSpace(Value: Byte);
   procedure SetCenter(Value: Boolean);
   procedure SetDataField(const Value: string);
   procedure SetDataSource(Value: TDataSource);
   procedure SetMetaFile(Value: TMetaFile);
   procedure SetReadOnly(Value: Boolean);
   procedure SetStretch(Value: Boolean);
   procedure SetStretchRatio(Value: Boolean);
   procedure UpdateData(Sender: TObject);
   procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
   procedure CMExit(var Message: TCMExit); message CM_EXIT;
   procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
   procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
   procedure WMCut(var Message: TMessage); message WM_CUT;
   procedure WMCopy(var Message: TMessage); message WM_COPY;
   procedure WMPaste(var Message: TMessage); message WM_PASTE;
   procedure WMSize(var Message: TMessage); message WM_SIZE;
   procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;

  protected
   procedure CreateParams(var Params: TCreateParams); override;
   procedure KeyDown(var Key: Word; Shift: TShiftState); override;
   procedure KeyPress(var Key: Char); override;
   procedure Notification(AComponent: TComponent; Operation: TOperation); override;
   procedure Paint; override;
   procedure ClipMetaFile( mf: TMetaFile );
   procedure StripMetaFile( mf: TMetaFile );
   procedure LoadMetaFile;

   // ======
   // PUBLIC
   // ======
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   //        =========
   //		  CLIPBOARD
   //        =========
   procedure CopyToClipboard;
   procedure CutToClipboard;
   procedure PasteFromClipboard;

   //        ===========
   //        FILE ACCESS
   //        ===========
   procedure LoadFromFile(const FileName: string);
   procedure SaveToFile(const Filename: String);

   //        ==========
   //        PROPERTIES
   //        ==========
   property Field: TField read GetField;
   property MetaFile: TMetaFile read FMetaFile write SetMetaFile;
   property MFWidth: Integer read FWidth;
   property MFHeight: Integer read FHeight;

  published
   property Align;
   property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
   property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
   property BorderSpace : Byte read FBorderSpace write SetBorderSpace default 10;
   property Center: Boolean read FCenter write SetCenter default True;
   property Color;
   property Ctl3D;
   property DataField: string read GetDataField write SetDataField;
   property DataSource: TDataSource read GetDataSource write SetDataSource;
   property DragCursor;
   property DragMode;
   property Enabled;
   property Font;
   property ParentColor default False;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property PopupMenu;
   property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
   property QuickDraw: Boolean read FQuickDraw write FQuickDraw default True;
   property ShowHint;
   property Stretch: Boolean read FStretch write SetStretch default False;
   property StretchRatio: Boolean read FStretchRatio write SetStretchRatio default False;
   property TabOrder;
   property TabStop default True;
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

procedure Register;

implementation

uses
  Clipbrd;

{ TDBMetaFile }

constructor TDBMetaFile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csFramed, csOpaque];
  Width := 105;
  Height := 105;
  TabStop := True;
  ParentColor := False;
  FMetaFile := TMetaFile.Create;
  FMetaFile.OnChange := MetaFileChanged;
  FBorderStyle := bsSingle;
  FAutoDisplay := True;
  FCenter := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FQuickDraw := True;
  FBorderSpace := 10;
  FWidth  := 0;
  FHeight := 0;
end;

destructor TDBMetaFile.Destroy;
begin
  FMetaFile.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

function TDBMetaFile.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBMetaFile.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TDBMetaFile.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TDBMetaFile.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TDBMetaFile.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDBMetaFile.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TDBMetaFile.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TDBMetaFile.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then begin
    FAutoDisplay := Value;
    if Value then LoadMetaFile;
  end;
end;

procedure TDBMetaFile.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then begin
   FBorderStyle := Value;
   RecreateWnd;
  end;
end;

procedure TDBMetaFile.SetBorderSpace(Value: Byte);
const
  min: Byte = 0;
  max: Byte = 50;
begin
  if ( FBorderSpace <> Value ) and
     ( Value >= min ) and
     ( Value <= max ) then begin
    FBorderSpace := Value;
    Invalidate;
  end;
end;

procedure TDBMetaFile.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then begin
    FCenter := Value;
    Invalidate;
  end;
end;

procedure TDBMetaFile.SetMetaFile(Value: TMetaFile);
begin
  FMetaFile.Assign(Value);
end;

procedure TDBMetaFile.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then begin
    FStretch := Value;
    if Stretch then StretchRatio:=False;
    Invalidate;
  end;
end;

procedure TDBMetaFile.SetStretchRatio(Value: Boolean);
begin
  if FStretchRatio <> Value then begin
   FStretchRatio := Value;
   if StretchRatio then begin
     Stretch:=False;
   end;
   Invalidate;
  end;
end;

procedure TDBMetaFile.Paint;
var
  WW, HH, MaxW, MaxH, W, H: Integer;
  RatioW, RatioH : Real;
  R, CanvRect  : TRect;
  S: string;
  Form: TCustomForm;
begin
  with Canvas do begin
  Brush.Style := bsSolid;
  Brush.Color := Color;
  { if we have a MetaFile? Paint it }
  if FMetaFileLoaded then begin
    { StretchRatio Paint}
    if StretchRatio then begin
      WW := MetaFile.width;
      HH := MetaFile.height;
      CanvRect := ClientRect;
      InflateRect( CanvRect , -FBorderSpace,-FBorderSpace);
      MaxW := CanvRect.Right - CanvRect.Left;
      MaxH := CanvRect.Bottom - CanvRect.Top;
      RatioW := MaxW / WW;
      RatioH := MaxH / HH;
      if  RatioW > RatioH then begin
        InflateRect( CanvRect, -((MaxW - Round( WW * RatioH )) div 2), 0 );
      end else begin
        InflateRect( CanvRect, 0, -((MaxH - Round( HH * RatioW )) div 2) );
      end;
      Fillrect(ClientRect);
      StretchDraw(CanvRect,MetaFile);
    end;
    { Stretch Paint}
    if Stretch then begin
      CanvRect := ClientRect;
      InflateRect( CanvRect , -FBorderSpace,-FBorderSpace);
      FillRect(ClientRect);
      StretchDraw(CanvRect,MetaFile);
    end;
    { not Stretch and not StretchRatio }
    if (not Stretch) and (not StretchRatio) then begin
      FillRect(ClientRect);
      SetRect(R, 0, 0, MetaFile.Width, MetaFile.Height);
      if Center then
        OffsetRect(R, (ClientWidth - MetaFile.Width) div 2,(ClientHeight - MetaFile.Height) div 2);
      StretchDraw(R, MetaFile);
    end;
  { There is no MetaFile to paint. }
  end else begin
    Font := Self.Font;
    if FDataLink.Field <> nil then
      S := 'Empty'
    else
      S := Name ;
    W := TextWidth(S);
    H := TextHeight(S);
    R := ClientRect;
    TextRect(R, (R.Right - W) div 2, (R.Bottom - H) div 2, S);
  end;

  { Set Focus Frame }
  Form := GetParentForm(Self);
  if (Form <> nil) and (Form.ActiveControl = Self) and
    not (csDesigning in ComponentState) and
    not (csPaintCopy in ControlState) then begin
    Brush.Color := clWindowFrame;
    FrameRect(ClientRect);
  end;
  end;{end with}
end;

procedure TDBMetaFile.MetaFileChanged(Sender: TObject);
begin
  //if FMetaFileLoaded then
  FDataLink.Modified;
  FMetaFileLoaded := True;
  Invalidate;
end;

procedure TDBMetaFile.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;

end;

procedure TDBMetaFile.LoadMetaFile;
var
  Stream : TMemoryStream;
  mf: tmetafile;
begin
  if (not FMetaFileLoaded) and (FDataLink.Field Is TBlobField) then begin
    Stream := TMemoryStream.Create;
    mf := tmetafile.create;
    try
      // Read from field.
      TBlobField(FDataLink.Field).SaveToStream(Stream);
      Stream.Seek(0,0);

      // write to MetaFile
      if Stream.Size > 1 then begin
        mf.LoadFromStream(stream);
        // Remove the outside border
        // or two points as done by
        // the older copy from autocad,
        // eventually this wont be
        // needed.
        Stripmetafile(mf);
        // this converts the metafile so
        // that the size is exactly the
        // outside bounding frame, the is
        // needed for painting.
        ClipMetaFile(mf);
        MetaFile.assign(mf);
      end;
    finally
      Stream.Free;
      mf.free;
    end;
  end;
end;

  //=====================================================
  // DataChange
  //
  // Event: TDataLink.OnDataChange
  // Once a control has a data link and properties
  // to specify the data source and data field, it
  // needs to respond to changes in the data field,
  // either because of a move to a different record
  // or because of a change made to that field. This
  // causes a Read from the Database Field. (LoadMetaFile)
procedure TDBMetaFile.DataChange( Sender: TObject );
begin
  MetaFile := nil;
  FMetaFileLoaded := False;
  FWidth := 0;
  FHeight:= 0;
  if FAutoDisplay then begin
    LoadMetaFile;
  end;
end;

  //==============================================
  // UpdateData
  //
  // Event: TDataLink.OnUpdateData
  // Saves the changed Metafile from the data-aware
  // control to the field data link.
procedure TDBMetaFile.UpdateData(Sender: TObject);
var
  Stream : TMemoryStream;
begin
  if (FDataLink.Field is TBlobField) then begin
    Stream := TMemoryStream.Create;
    try
      MetaFile.SaveToStream(Stream);
      Stream.Seek(0,0);
      TBlobField(FDataLink.Field).LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  end else
    TBlobField(FDataLink.Field).Clear;
end;

procedure TDBMetaFile.CopyToClipboard;
var
  Stream: TMemoryStream;
  mf: tmetafile;
begin
  Stream := TMemoryStream.Create;
  try
    mf := tmetafile.create;
    try
      TBlobField(FDataLink.Field).SaveToStream(Stream);
      Stream.Seek(0,0);
      if Stream.Size > 1 then begin
        mf.LoadFromStream(stream);
      end;
      Clipboard.Assign(MF);
    finally
      mf.free;
    end;
  finally
    Stream.Free;
  end;
end;

procedure TDBMetaFile.CutToClipboard;
begin
  if MetaFile <> nil then begin
    if FDataLink.Edit then begin
      CopyToClipboard;
      MetaFile := nil;
    end;
  end;
end;

procedure TDBMetaFile.PasteFromClipboard;
var
  mf: tmetafile;
  stream: TMemoryStream;
  stream2: TMemoryStream;
begin
  if Clipboard.HasFormat(CF_METAFILEPICT) and FDataLink.Edit then begin
    mf := tmetafile.create;
    try
      mf.assign(clipboard);
      stream := TMemoryStream.Create;
      stream2 := TMemoryStream.Create;
      try
        // when pasting from the clipboard
        // we need to test the metafile, if
        // its native wmf or emf. By setting
        // the enhanced value to false and then
        // saving to stream we force the metafile
        // to convert. Here is what happens: if
        // the metafile is wmf format then we
        // should get a small file ( straight 16 bit )
        // if the file is emf then setting it to false
        // will actually increase the metafile size
        // wich is what we are trying to avoid.
        mf.SaveToStream(stream);
        mf.Enhanced := false;
        mf.SaveToStream(stream2);
        // here we just want the smalles metafile stream.
        if stream.size < stream2.size then
          TBlobField(FDataLink.Field).LoadFromStream(stream)
        else
          TBlobField(FDataLink.Field).LoadFromStream(stream2);
      finally
        stream.free;
        stream2.free;
      end;
    finally
      mf.free;
    end;
  end;
end;

procedure TDBMetaFile.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if FBorderStyle = bsSingle then
    Params.Style := Params.Style or WS_BORDER;
end;

procedure TDBMetaFile.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  case Key of
   VK_INSERT:
      if ssShift in Shift then PasteFromClipBoard else
      if ssCtrl in Shift then CopyToClipBoard;
    VK_DELETE:
      if ssShift in Shift then CutToClipBoard;
  end;
end;

procedure TDBMetaFile.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    ^X: CutToClipBoard;
    ^C: CopyToClipBoard;
    ^V: PasteFromClipBoard;
   #13: LoadMetaFile;
   #27: FDataLink.Reset;
  end;
end;

procedure TDBMetaFile.CMEnter(var Message: TCMEnter);
begin
  Invalidate; { Draw the focus marker }
  inherited;
end;

procedure TDBMetaFile.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  Invalidate; { Erase the focus marker }
  inherited;
end;

procedure TDBMetaFile.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if not FMetaFileLoaded then Invalidate;
end;

procedure TDBMetaFile.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if TabStop and CanFocus then SetFocus;
  inherited;
end;

procedure TDBMetaFile.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  LoadMetaFile;
  inherited;
end;

procedure TDBMetaFile.WMCut(var Message: TMessage);
begin
  CutToClipboard;
end;

procedure TDBMetaFile.WMCopy(var Message: TMessage);
begin
  CopyToClipboard;
end;

procedure TDBMetaFile.WMPaste(var Message: TMessage);
begin
  PasteFromClipboard;
end;

procedure TDBMetaFile.WMSize(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TDBMetaFile.LoadFromFile(const FileName: string);
var
  FileStream: TFileStream;
begin
  if FDataLink.Edit then begin
    FileStream := TFileStream.create(FileName,fmOpenRead);
    try
      TBlobField(FDataLink.Field).LoadFromStream(FileStream);
    finally
      FileStream.Free;
    end;
  end;
end;

procedure TDBMetaFile.SaveToFile(const FileName: String);
var
  FileStream: TFileStream;
begin
  if MetaFile <> nil then begin
     FileStream := TFileStream.Create(FileName,fmCreate or fmOpenWrite);
    try
      TBlobField(FDataLink.Field).SaveToStream(FileStream);
    finally
      FileStream.Free;
    end;
  end;
end;

procedure TDBMetaFile.ClipMetaFile( mf: TMetaFile );
var
  nmf: TMetaFile;
  mfc: TMetaFileCanvas;
  EnhHeader: TEnhMetaHeader;
begin
  GetEnhMetaFileHeader( mf.handle, sizeof(EnhHeader), @EnhHeader );
  with EnhHeader.rclBounds do begin
    nmf := TMetaFile.Create;
    try
      nmf.Width := right - left;
      nmf.height := bottom - top;
      mfc := TMetaFileCanvas.create(nmf,0);
      try
        mfc.Draw( -left,-top, mf );
      finally
        mfc.free;
      end;
      mf.Assign(nmf);
    finally
      nmf.free;
    end;
  end;
end;

function CallMetaFile( hdc: HDC;
                       pTable: pHandleTable;
                       pEMFR: pEnhMetaRecord;
                       nObj: integer;
                       pData: LPARAM ): integer; stdcall;
begin
  Result := 1;
  case pEmfr^.iType of
    EMR_RECTANGLE: exit;
    EMR_SETPIXELV: exit;
  else
    PlayEnhMetaFileRecord( hdc, pTable^, pEMFR^, nObj );
  end;
end;

procedure TDBMetaFile.StripMetaFile( mf: TMetaFile );
var
  r: Trect;
  nmf: TMetaFile;
  mfc: TMetaFileCanvas;
begin
  r.Left := 0;
  r.Top := 0;
  r.Right := mf.width;
  r.Bottom := mf.height;
  nmf := TMetaFile.Create;
  try
    mfc := TMetaFileCanvas.create(nmf,0);
    try
      EnumEnhMetaFile( mfc.handle,
                       HENHMETAFILE(mf.handle),
                       TFNEnhMFEnumProc( @CallMetaFile ), nil, r );
    finally
      mfc.free;
    end;
    mf.Assign( nmf );
  finally
    nmf.Free;
  end;
end;

procedure Register;
begin
  RegisterComponents( 'Lamsco', [TDBMetaFile] );
end;

end.
