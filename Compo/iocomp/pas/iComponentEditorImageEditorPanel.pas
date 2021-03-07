{*******************************************************}
{                                                       }
{       TiComponentEditorImageEditorPanel Component     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iComponentEditorImageEditorPanel;{$endif}
{$ifdef iCLX}unit QiComponentEditorImageEditorPanel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF MSWINDOWS}Registry,{$ENDIF}
  {$IFDEF LINUX}    IniFiles,{$ENDIF}
  {$IFDEF iVCL}  iTypes, iGPFunctions,   iClasses,  iEditorBasicComponents,  ImgList, JPeg, PNGImage;{$ENDIF}
  {$IFDEF iCLX} QiTypes, QiGPFunctions, QiClasses, QiEditorBasicComponents, QImgList;{$ENDIF}

type
  TiComponentEditorImageEditorPanel = class(TCustomControl)
  private
    FListView          : TListView;
    FImageList         : TImageList;
    FCreationComplete  : Boolean;
    FAddButton         : TiComponentEditorOpenPicker;
    FRemoveButton      : TiComponentEditorButton;
    FClearButton       : TiComponentEditorButton;
    FWidthEdit         : TiComponentEditorEdit;
    FHeightEdit        : TiComponentEditorEdit;
    FWidthLabel        : TLabel;
    FHeightLabel       : TLabel;
    FNoteLabel         : TLabel;
    FAllowMultiSelect  : Boolean;
    procedure SetAllowMultiSelect(const Value: Boolean);
  protected
    procedure AddImage          (FileName: String);
    procedure OpenImageBitmap   (FileName: String);
    procedure OpenImageJPEG     (FileName: String);
    procedure OpenImagePNG      (FileName: String);

    procedure AddImageBitmap    (ABitmap: TBitmap);

    procedure AddButtonClick    (Sender: TObject);
    procedure RemoveButtonClick (Sender: TObject);
    procedure ClearButtonClick  (Sender: TObject);

    procedure ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);

    procedure UpdateButtons;
    procedure ReloadList;
    procedure DoResize;

    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override; {$endif}
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    procedure UpLoad  (ImageList: TImageList);
    procedure DownLoad(ImageList: TImageList);

  published
    property AllowMultiSelect : Boolean read FAllowMultiSelect write SetAllowMultiSelect;
    property Align default alClient;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiComponentEditorImageEditorPanel.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csReplicatable];

  Width      := 500;
  Height     := 250;
  Align      := alClient;

  FImageList := TImageList.CreateSize(24, 24);
  with FImageList do
    begin

    end;

  FListView := TListView.Create(Self);
  with FListView do
    begin
      Parent       := Self;
      {$IFDEF iVCL}
      SmallImages  := FImageList;
      LargeImages  := FImageList;
      ViewStyle    := vsIcon;
      {$ENDIF}
      {$IFDEF iCLX}                    
      Images       := FImageList;
      ViewStyle    := vsList;
      {$ENDIF}
      OnSelectItem := ListViewSelectItem;
    end;
                                                             
  FAddButton := TiComponentEditorOpenPicker.Create(Self);
  with FAddButton do
    begin
      Parent   := Self;
      Caption  := 'Add';

      {$IFDEF iVCL}
      Filter   := 'All (*.bmp; *.jpg; *.jpeg; *.png)|*.bmp;*.jpg;*.jpeg;*.png|' +
                  'Bitmap (*.bmp)|*.bmp|JPEG File (*.jpg; *.jpeg)|*.jpg;*.jpeg|PNG (*.png)|*.png';
      {$ENDIF}
      {$IFDEF iCLX}
      Filter   := 'All (*.bmp)|*.bmp|' +
                  'Bitmap (*.bmp)|*.bmp';
      {$ENDIF}

      OnChange := AddButtonClick;
    end;

  FRemoveButton := TiComponentEditorButton.Create(Self);
  with FRemoveButton do
    begin
      Parent  := Self;
      Caption := 'Remove';
      OnClick := RemoveButtonClick;
      Enabled := False;
    end;

  FClearButton := TiComponentEditorButton.Create(Self);
  with FClearButton do
    begin
      Parent  := Self;
      Caption := 'Clear';
      OnClick := ClearButtonClick;
    end;

  FWidthEdit := TiComponentEditorEdit.Create(Self);
  with FWidthEdit do
    begin
      Parent := Self;
      Width  := 40;
      Disable;
    end;

  FHeightEdit := TiComponentEditorEdit.Create(Self);
  with FHeightEdit do
    begin
      Parent := Self;
      Width  := 40;
      Disable;
    end;

  FWidthLabel := TLabel.Create(Self);
  with FWidthLabel do
    begin
      Parent  := Self;
      Caption := 'Width';
    end;

  FHeightLabel := TLabel.Create(Self);
  with FHeightLabel do
    begin
      Parent  := Self;
      Caption := 'Height';
    end;

  FNoteLabel := TLabel.Create(Self);
  with FNoteLabel do
    begin
      Parent  := Self;
      Caption := 'Note: Clear and then Load First Image to Set Size';
    end;

  FCreationComplete := True;
  DoResize;
end;
//****************************************************************************************************************************************************
destructor TiComponentEditorImageEditorPanel.Destroy;
begin
  FImageList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorImageEditorPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}
end;
{$ENDIF}
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (ALeft = Left) and (ATop = Top) and (AWidth = Width) and (AHeight = Height) then Exit;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  DoResize;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.DoResize;
begin
  if not FCreationComplete then Exit;

  FWidthEdit.Left  := FWidthLabel.Left + FWidthLabel.Width + 3;
  FWidthEdit.Top   := Height - 5 - FWidthEdit.Height;

  FWidthLabel.Left := 5;
  FWidthLabel.Top  := FWidthEdit.Top + FWidthEdit.Height div 2 - FWidthLabel.Height div 2;

  FHeightEdit.Left  := FWidthEdit.Left + FWidthEdit.Width + 5 + FHeightLabel.Width + 3;
  FHeightEdit.Top   := FWidthEdit.Top;

  FHeightLabel.Left := FWidthEdit.Left + FWidthEdit.Width + 5;
  FHeightLabel.Top  := FWidthLabel.Top;

  FNoteLabel.Left := FHeightEdit.Left + FHeightEdit.Width + 10;
  FNoteLabel.Top  := FWidthLabel.Top;
  //------------------------------------------------------------------------------

  FListView.Left := 5;
  FListView.Top  := 5;

  FListView.Height := FWidthEdit.Top - 10;
  FListView.Width  := Width - 10 - 5 - FAddButton.Width;

  FAddButton.Left := FListView.Left + FListView.Width + 5;
  FAddButton.Top  := FListView.Top;

  FRemoveButton.Left := FAddButton.Left;
  FRemoveButton.Top  := FAddButton.Top + FAddButton.Height + 5;

  FClearButton.Left := FAddButton.Left;
  FClearButton.Top  := FRemoveButton.Top + FRemoveButton.Height + 5;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.DownLoad(ImageList: TImageList);
begin
  ImageList.Assign(FImageList);
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.UpLoad(ImageList: TImageList);
begin
  FImageList.Assign(ImageList);

  ReloadList;
  UpdateButtons;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.ReloadList;
var
  x        : Integer;
  ListItem : TListItem;
begin
  FListView.Items.Clear;
  for x := 0 to FImageList.Count-1 do
    begin
      ListItem            := FListView.Items.Add;
      ListItem.ImageIndex := x;
      ListItem.Caption    := IntToStr(x);
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.AddImage(FileName: String);
begin
  {$IFDEF iVCL}
  if      UpperCase(ExtractFileExt(FileName)) = UpperCase('.bmp' ) then OpenImageBitmap(FileName)
  else if UpperCase(ExtractFileExt(FileName)) = UpperCase('.jpg' ) then OpenImageJPEG  (FileName)
  else if UpperCase(ExtractFileExt(FileName)) = UpperCase('.jpeg') then OpenImageJPEG  (FileName)
  else if UpperCase(ExtractFileExt(FileName)) = UpperCase('.png' ) then OpenImagePNG   (FileName);
  {$ENDIF}
  {$IFDEF iCLX}
   OpenImageBitmap(FileName);
  {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.OpenImageBitmap(FileName: String);
var
  ABitmap : TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    ABitmap.LoadFromFile(FileName);
    AddImageBitmap(ABitmap);
  finally
    ABitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.OpenImageJPEG(FileName: String);
{$IFDEF iVCL}
var
  AJPEG   : TJPEGImage;
  ABitmap : TBitmap;
{$ENDIF}
begin
  {$IFDEF iVCL}
  AJPEG := TJPEGImage.Create;
  try
    AJPEG.LoadFromFile(FileName);

    ABitmap := TBitmap.Create;
    try
      ABitmap.Assign(AJPEG);
      AddImageBitmap(ABitmap);
    finally
      ABitmap.Free;
    end;
  finally
    AJPEG.Free;
  end;
  {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.OpenImagePNG(FileName: String);
{$IFDEF iVCL}
var
  APNG    : TPNGObject;
  ABitmap : TBitmap;
{$ENDIF}
begin
  {$IFDEF iVCL}
  APNG := TPNGObject.Create;
  try
    APNG.LoadFromFile(FileName);

    ABitmap := TBitmap.Create;
    try
      ABitmap.Assign(APNG);
      AddImageBitmap(ABitmap);
    finally
      ABitmap.Free;
    end;
  finally
    APNG.Free;
  end;
  {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.AddImageBitmap(ABitmap: TBitmap);
var
  BBitmap          : TBitmap;
  OffsetX          : Integer;
  OffsetY          : Integer;
  TransparentColor : TColor;
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
        TransparentColor := ABitmap.TransparentColor;
        BBitmap.Canvas.Brush.Color := TransparentColor;
        BBitmap.Canvas.FillRect(Rect(0, 0, BBitmap.Width, BBitmap.Height));

        OffsetX := BBitmap.Width  div 2 - ABitmap.Width  div 2;
        OffsetY := BBitmap.Height div 2 - ABitmap.Height div 2;

        BBitmap.Canvas.Draw(OffsetX, OffsetY, ABitmap);

        ABitmap.Assign(BBitmap);
        ABitmap.TransparentColor := TransparentColor;
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

  if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
  ReloadList;
  UpdateButtons;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.AddButtonClick(Sender: TObject);
var
  x : Integer;
begin
  if FAddButton.Files is TStringList then (FAddButton.Files as TStringList).Sort;
  for x :=0 to FAddButton.Files.Count-1  do
    AddImage(FAddButton.Files.Strings[x]);
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.ClearButtonClick(Sender: TObject);
begin
  FImageList.Clear;
  if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
  ReloadList;
  UpdateButtons;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.RemoveButtonClick(Sender: TObject);
var
  ImageIndex : Integer;
begin
  ImageIndex := StrToInt(FListView.Selected.Caption);
  FImageList.Delete(ImageIndex);
  FRemoveButton.Enabled := False;
  if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
  ReloadList;
  UpdateButtons;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.UpdateButtons;
begin
  if FImageList.Count = 0 then
    begin
      FClearButton.Enabled := False;
    end
  else
    begin
      FClearButton.Enabled := True;
    end;
  if Assigned(FListView.Selected) then
    FRemoveButton.Enabled := True
  else FRemoveButton.Enabled := False;

  FWidthEdit.AsInteger  := FImageList.Width;
  FHeightEdit.AsInteger := FImageList.Height;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  UpdateButtons;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorImageEditorPanel.SetAllowMultiSelect(const Value: Boolean);
begin
  FAllowMultiSelect := Value;
  FAddButton.AllowMultiSelect := Value;
end;
//****************************************************************************************************************************************************
end.
