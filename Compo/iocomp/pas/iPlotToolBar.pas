{*******************************************************}
{                                                       }
{       TiPlotToolBar                                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotToolBar;{$endif}
{$ifdef iCLX}unit QiPlotToolBar;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iPlotObjects,  ImgList;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiPlotObjects, QImgList;{$ENDIF}

const
  ButtonTopOffset  = 3;
  ButtonLeftOffset = 3;
  SpacerWidth      = 10;
type
  TiPlotToolBarButtonStyle = (iptbbsButton, iptbbsSpacer);
  TiPlotToolBarButtonType  = (iptbbtResume, iptbbtPause, iptbbtScrollAxesMode, iptbbtZoomAxesMode, iptbbtSelect, iptbbtZoomBox, iptbbtZoomOut,
                              iptbbtZoomIn, iptbbtCursor, iptbbtEdit, iptbbtCopy, iptbbtSave, iptbbtPrint, iptbbtPreview);

  TiPlotToolBar = class;

  TiPlotToolBarButton = class(TiPlotButton)
  private
    FHint       : String;
    FStyle      : TiPlotToolBarButtonStyle;
    FImageList  : TImageList;
    FImageIndex : Integer;
    FImageName  : String;
    FFlat       : Boolean;
    FMouseOver  : Boolean;
    FToolBar    : TiPlotToolBar;
  protected

  public
    procedure DoMouseHint(MouseData: TiPlotMouseData; var HintData: TiHintData); override;
    procedure DoMouseNotOver;                                                    override;

    procedure iMouseMove (var HintData: TiHintData; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; DblClickActive: Boolean); override;

    procedure Draw           (const Canvas: TCanvas; const BackGroundColor: TColor);        override;
    procedure DrawLoweredEdge(const Canvas: TCanvas);
    procedure DrawRaisedEdge (const Canvas: TCanvas);

    property ImageList    : TImageList               read FImageList    write FImageList;
    property ImageIndex   : Integer                  read FImageIndex   write FImageIndex;
    property Hint         : String                   read FHint         write FHint;
    property Style        : TiPlotToolBarButtonStyle read FStyle        write FStyle;

    property ImageName    : String                   read FImageName    write FImageName;
    property ToolBar      : TiPlotToolBar            read FToolBar      write FToolBar;

    property Flat         : Boolean                  read FFlat         write FFlat;
  end;

  TiPlotToolBar = class(TiPlotLayoutObject)
  private
    FButtonList           : TStringList;
    FImageList            : TImageList;

    FResumeButton         : TiPlotToolBarButton;
    FPauseButton          : TiPlotToolBarButton;
    FResumePauseSpacer    : TiPlotToolBarButton;

    FAxesModeScrollButton : TiPlotToolBarButton;
    FAxesModeZoomButton   : TiPlotToolBarButton;
    FAxesModeSpacer       : TiPlotToolBarButton;

    FZoomInButton         : TiPlotToolBarButton;
    FZoomOutButton        : TiPlotToolBarButton;
    FZoomInOutSpacer      : TiPlotToolBarButton;

    FSelectButton         : TiPlotToolBarButton;
    FZoomBoxButton        : TiPlotToolBarButton;
    FCursorButton         : TiPlotToolBarButton;
    FZoomBoxCursorSpacer  : TiPlotToolBarButton;

    FEditButton           : TiPlotToolBarButton;
    FEditSpacer           : TiPlotToolBarButton;

    FCopyButton           : TiPlotToolBarButton;
    FSaveButton           : TiPlotToolBarButton;
    FPrintButton          : TiPlotToolBarButton;
    FPreviewButton        : TiPlotToolBarButton;

    FZoomInOutFactor      : Double;
    FFlatButtons          : Boolean;
    FSmallButtons         : Boolean;
    FFlatBorder           : Boolean;
  protected
    procedure SetShowResumeButton     (const Value: Boolean);
    procedure SetShowPauseButton      (const Value: Boolean);
    procedure SetShowAxesModeButtons  (const Value: Boolean);
    procedure SetShowZoomInOutButtons (const Value: Boolean);
    procedure SetShowSelectButton     (const Value: Boolean);
    procedure SetShowZoomBoxButton    (const Value: Boolean);
    procedure SetShowCursorButton     (const Value: Boolean);
    procedure SetShowEditButton       (const Value: Boolean);
    procedure SetShowCopyButton       (const Value: Boolean);
    procedure SetShowPrintButton      (const Value: Boolean);
    procedure SetShowPreviewButton    (const Value: Boolean);
    procedure SetShowSaveButton       (const Value: Boolean);
    procedure SetFlatButtons          (const Value: Boolean);
    procedure SetSmallButtons         (const Value: Boolean);
    procedure SetFlatBorder           (const Value: Boolean);

    function GetShowResumeButton     : Boolean;
    function GetShowPauseButton      : Boolean;
    function GetShowAxesModeButtons  : Boolean;
    function GetShowZoomInOutButtons : Boolean;
    function GetShowSelectButton     : Boolean;
    function GetShowZoomBoxButton    : Boolean;
    function GetShowCursorButton     : Boolean;
    function GetShowEditButton       : Boolean;
    function GetShowCopyButton       : Boolean;
    function GetShowPrintButton      : Boolean;
    function GetShowPreviewButton    : Boolean;
    function GetShowSaveButton       : Boolean;

    procedure SetZoomInOutFactor(const Value: Double);

    function GetCursorActive  : Boolean;
    function GetZoomBoxActive : Boolean;
    function GetSelectActive  : Boolean;

    procedure ResumeClick        (Sender : TObject);
    procedure PauseClick         (Sender : TObject);
    procedure AxesModeScrollClick(Sender : TObject);
    procedure AxesModeZoomClick  (Sender : TObject);
    procedure ZoomOutClick       (Sender : TObject);
    procedure ZoomInClick        (Sender : TObject);
    procedure SelectClick        (Sender : TObject);
    procedure ZoomBoxClick       (Sender : TObject);
    procedure CursorClick        (Sender : TObject);
    procedure EditClick          (Sender : TObject);
    procedure CopyClick          (Sender : TObject);
    procedure SaveClick          (Sender : TObject);
    procedure PrintClick         (Sender : TObject);
    procedure PreviewClick       (Sender : TObject);

    procedure ZoomBoxDownChange  (Sender : TObject);
    procedure CursorDownChange   (Sender : TObject);
    procedure SelectDownChange   (Sender: TObject);

    procedure GroupClick         (Sender : TObject);

    function CreateButton(OnClick : TNotifyEvent; ImageIndex, GroupIndex : Integer; GlphyName, Hint: String) : TiPlotToolBarButton;
    function CreateSpacer : TiPlotToolBarButton;

    procedure UpdateSpacers;
    procedure UpdateResumePauseButtons;

    procedure ButtonInvalidate(Sender : TObject);

    function GetMouseObject(X, Y: Integer): TiPlotObject;                                              override;

    procedure AddMenuItems(PopupMenu: TPopUpMenu);                                                     override;

    function  GetRequiredWidth(const Canvas : TCanvas) : Integer;                                      override;

    procedure NotificationSetFocus(Sender: TObject);                                                   override;

    procedure Draw(const Canvas: TCanvas; const BackGroundColor: TColor);                              override;

    procedure SetupLargeImages;
    procedure SetupSmallImages;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); override;
    destructor  Destroy;                                                                               override;

    procedure TurnOffCursor;
         
    property  ZoomBoxActive       : Boolean read GetZoomBoxActive;
    property  CursorActive        : Boolean read GetCursorActive;
    property  SelectActive        : Boolean read GetSelectActive;

    procedure DoButtonClickResume;
    procedure DoButtonClickPause;
    procedure DoButtonClickScrollAxesMode;
    procedure DoButtonClickZoomAxesMode;
    procedure DoButtonClickSelect;
    procedure DoButtonClickZoomBox;
    procedure DoButtonClickZoomOut;
    procedure DoButtonClickZoomIn;
    procedure DoButtonClickCursor;
    procedure DoButtonClickEdit;
    procedure DoButtonClickCopy;
    procedure DoButtonClickSave;
    procedure DoButtonClickPrint;
    procedure DoButtonClickPreview;
  published
    property ShowResumeButton      : Boolean read GetShowResumeButton     write SetShowResumeButton     default True;
    property ShowPauseButton       : Boolean read GetShowPauseButton      write SetShowPauseButton      default True;
    property ShowAxesModeButtons   : Boolean read GetShowAxesModeButtons  write SetShowAxesModeButtons  default True;
    property ShowZoomInOutButtons  : Boolean read GetShowZoomInOutButtons write SetShowZoomInOutButtons default True;
    property ShowSelectButton      : Boolean read GetShowSelectButton     write SetShowSelectButton     default False;
    property ShowZoomBoxButton     : Boolean read GetShowZoomBoxButton    write SetShowZoomBoxButton    default True;
    property ShowCursorButton      : Boolean read GetShowCursorButton     write SetShowCursorButton     default True;
    property ShowEditButton        : Boolean read GetShowEditButton       write SetShowEditButton       default True;
    property ShowCopyButton        : Boolean read GetShowCopyButton       write SetShowCopyButton       default True;
    property ShowSaveButton        : Boolean read GetShowSaveButton       write SetShowSaveButton       default True;
    property ShowPrintButton       : Boolean read GetShowPrintButton      write SetShowPrintButton      default True;
    property ShowPreviewButton     : Boolean read GetShowPreviewButton    write SetShowPreviewButton    default False;

    property ZoomInOutFactor       : Double  read FZoomInOutFactor        write SetZoomInOutFactor;
    property FlatBorder            : Boolean read FFlatBorder             write SetFlatBorder           default False;
    property FlatButtons           : Boolean read FFlatButtons            write SetFlatButtons          default False;
    property SmallButtons          : Boolean read FSmallButtons           write SetSmallButtons         default False;
  end;
                           
{$ifdef iVCL}{$R iPlotPackGlyphs.res} {$endif}
{$ifdef iCLX}{$R QiPlotPackGlyphs.res}{$endif}

implementation

uses
{$ifdef iVCL} iPlotChannelCustom,  iPlotDataView, iPlotAxis,   iPlotComponent;{$endif}
{$ifdef iCLX}QiPlotChannelCustom, QiPlotDataView, QiPlotAxis, QiPlotComponent;{$endif}

type
  TiPlotComponentAccess     = class(TiPlotComponent    )end;
  TiPlotDataViewAccess      = class(TiPlotDataView     )end;
  TiPlotChannelCustomAccess = class(TiPlotChannelCustom)end;
//****************************************************************************************************************************************************
constructor TiPlotToolBar.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited;

  FImageList := TImageList.CreateSize(24, 24);

  Horizontal := True;

  FZoomInOutFactor  := 2;

  FButtonList := TStringList.Create;
  FButtonList.Sorted := False;                    

  FResumeButton          := CreateButton(ResumeClick,          0,  0, 'AUTO',       'Resume All (Tracking)');
  FPauseButton           := CreateButton(PauseClick,           1,  0, 'PAUSE',      'Pause All (Tracking)');
  FResumePauseSpacer     := CreateSpacer;

  FAxesModeScrollButton  := CreateButton(AxesModeScrollClick,  2,  2, 'SCROLL',     'Scroll (Axes)'); FAxesModeScrollButton.Down := True;
  FAxesModeZoomButton    := CreateButton(AxesModeZoomClick,    3,  2, 'ZOOM',       'Zoom (Axes)');
  FAxesModeSpacer        := CreateSpacer;

  FZoomOutButton         := CreateButton(ZoomOutClick,         4,  0, 'ZOOMOUT',    'Zoom Out All Axes');
  FZoomInButton          := CreateButton(ZoomInClick,          5,  0, 'ZOOMIN',     'Zoom In All Axes');
  FZoomInOutSpacer       := CreateSpacer;

  FSelectButton          := CreateButton(SelectClick,          6, -1, 'SELECT',     'Select');
  FZoomBoxButton         := CreateButton(ZoomBoxClick,         7, -1, 'SCROLLBOX',  'Zoom Box');
  FCursorButton          := CreateButton(CursorClick,          8, -2, 'CURSOR',     'Cursor');

  FZoomBoxCursorSpacer   := CreateSpacer;

  FEditButton            := CreateButton(EditClick,            9,  0, 'PROPERTIES', 'Properties');
  FEditSpacer            := CreateSpacer;

  FCopyButton            := CreateButton(CopyClick,           10,  0, 'COPY',       'Copy to Clipboard');
  FSaveButton            := CreateButton(SaveClick,           11,  0, 'SAVE',       'Save to File');
  FPrintButton           := CreateButton(PrintClick,          12,  0, 'PRINTER',    'Print');
  FPreviewButton         := CreateButton(PreviewClick,        13,  0, 'PREVIEW',    'Preview');

  FCursorButton.OnDownChange  := CursorDownChange;
  FZoomBoxButton.OnDownChange := ZoomBoxDownChange;
  FSelectButton.OnDownChange  := SelectDownChange;

  FSelectButton.Visible  := False;
  FPreviewButton.Visible := False;

  SetupLargeImages;
end;
//****************************************************************************************************************************************************
destructor TiPlotToolBar.Destroy;
begin
  while FButtonList.Count <> 0 do
    begin
      FButtonList.Objects[0].Free;
      FButtonList.Delete(0);
    end;
  FButtonList.Free;                                     
  FImageList.Free;  
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.SetupLargeImages;
var
  x : Integer;
begin
  FResumeButton.ImageName          := 'AUTO';
  FPauseButton.ImageName           := 'PAUSE';
  FAxesModeScrollButton.ImageName  := 'SCROLL';
  FAxesModeZoomButton.ImageName    := 'ZOOM';
  FZoomOutButton.ImageName         := 'ZOOMOUT';
  FZoomInButton.ImageName          := 'ZOOMIN';
  FSelectButton.ImageName          := 'SELECT';
  FZoomBoxButton.ImageName         := 'SCROLLBOX';
  FCursorButton.ImageName          := 'CURSOR';
  FEditButton.ImageName            := 'PROPERTIES';
  FCopyButton.ImageName            := 'COPY';
  FSaveButton.ImageName            := 'SAVE';
  FPrintButton.ImageName           := 'PRINTER';
  FPreviewButton.ImageName         := 'PREVIEW';

  FImageList.Clear;
  FImageList.Height := 24;
  FImageList.Width  := 24;

  for x := 0 to FButtonList.Count-1 do
    (FButtonList.Objects[x] as TiPlotToolBarButton).ImageIndex := -1;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.SetupSmallImages;
var
  x : Integer;
begin
  FResumeButton.ImageName          := 'SMALLAUTO';
  FPauseButton.ImageName           := 'SMALLPAUSE';
  FAxesModeScrollButton.ImageName  := 'SMALLSCROLL';
  FAxesModeZoomButton.ImageName    := 'SMALLZOOM';
  FZoomOutButton.ImageName         := 'SMALLZOOMOUT';
  FZoomInButton.ImageName          := 'SMALLZOOMIN';
  FSelectButton.ImageName          := 'SMALLSELECT';
  FZoomBoxButton.ImageName         := 'SMALLSCROLLBOX';
  FCursorButton.ImageName          := 'SMALLCURSOR';
  FEditButton.ImageName            := 'SMALLPROPERTIES';
  FCopyButton.ImageName            := 'SMALLCOPY';
  FSaveButton.ImageName            := 'SMALLSAVE';
  FPrintButton.ImageName           := 'SMALLPRINTER';
  FPreviewButton.ImageName         := 'SMALLPREVIEW';

  FImageList.Clear;
  FImageList.Height := 16;
  FImageList.Width  := 16;

  for x := 0 to FButtonList.Count-1 do
    (FButtonList.Objects[x] as TiPlotToolBarButton).ImageIndex := -1;
end;
//****************************************************************************************************************************************************
function TiPlotToolBar.CreateButton(OnClick : TNotifyEvent; ImageIndex, GroupIndex : Integer; GlphyName, Hint: String) : TiPlotToolBarButton;
begin
  Result := TiPlotToolBarButton.Create(Owner, nil, nil, nil, nil);
  Result.ToolBar := Self;

  Result.OnInvalidate := ButtonInvalidate;
  Result.OnClick      := OnClick;
  Result.OnGroupClick := GroupClick;
  Result.OnChange     := OnChange;

  Result.Hint       := Hint;
  Result.Style      := iptbbsButton;
  Result.GroupIndex := GroupIndex;
  Result.Visible    := True;

  Result.ImageList  := FImageList;
  Result.ImageIndex := -1;

  Result.ImageName  := GlphyName;

  FButtonList.AddObject('', Result);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.SetZoomInOutFactor(const Value: Double);
var
  TempValue : Double;
begin
  TempValue := Value;
  if TempValue < 1 then TempValue := 1;
  if FZoomInOutFactor <> TempValue then
    begin
      FZoomInOutFactor := TempValue;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.AddMenuItems(PopupMenu: TPopUpMenu);
begin
  inherited AddMenuItems(PopupMenu);
  AddEditMenuItems(PopupMenu);
end;
//****************************************************************************************************************************************************
function TiPlotToolBar.GetMouseObject(X, Y: Integer): TiPlotObject;
var
  iButton : TiPlotToolBarButton;
  i       : Integer;
begin
  Result := inherited GetMouseObject(X, Y);

  for i := 0 to FButtonList.Count-1 do
    begin
      iButton := FButtonList.Objects[i] as TiPlotToolBarButton;
      if not iButton.Visible then Continue;
      if PtInRect(iButton.DrawRect, Point(X, Y)) then
        begin
          Result := iButton;
          Break;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.SetShowCopyButton      (const Value:Boolean);begin FCopyButton.Visible          :=Value;                                   end;
procedure TiPlotToolBar.SetShowPrintButton     (const Value:Boolean);begin FPrintButton.Visible         :=Value;                                   end;
procedure TiPlotToolBar.SetShowPreviewButton   (const Value:Boolean);begin FPreviewButton.Visible       :=Value;                                   end;
procedure TiPlotToolBar.SetShowSaveButton      (const Value:Boolean);begin FSaveButton.Visible          :=Value;                                   end;
procedure TiPlotToolBar.SetShowEditButton      (const Value:Boolean);begin FEditButton.Visible          :=Value;                                   end;
procedure TiPlotToolBar.SetShowAxesModeButtons (const Value:Boolean);begin FAxesModeScrollButton.Visible:=Value;FAxesModeZoomButton.Visible:=Value;end;
procedure TiPlotToolBar.SetShowZoomInOutButtons(const Value:Boolean);begin FZoomInButton.Visible        :=Value;FZoomOutButton.Visible     :=Value;end;
procedure TiPlotToolBar.SetShowZoomBoxButton   (const Value:Boolean);begin FZoomBoxButton.Visible       :=Value;                                   end;
procedure TiPlotToolBar.SetShowCursorButton    (const Value:Boolean);begin FCursorButton.Visible        :=Value;                                   end;
procedure TiPlotToolBar.SetShowPauseButton     (const Value:Boolean);begin FPauseButton.Visible         :=Value;                                   end;
procedure TiPlotToolBar.SetShowResumeButton    (const Value:Boolean);begin FResumeButton.Visible        :=Value;                                   end;
procedure TiPlotToolBar.SetShowSelectButton    (const Value:Boolean);begin FSelectButton.Visible        :=Value;                                   end;
//****************************************************************************************************************************************************
function TiPlotToolBar.GetShowCopyButton       : Boolean;begin Result := FCopyButton.Visible;          end;
function TiPlotToolBar.GetShowPrintButton      : Boolean;begin Result := FPrintButton.Visible;         end;
function TiPlotToolBar.GetShowPreviewButton    : Boolean;begin Result := FPreviewButton.Visible;       end;
function TiPlotToolBar.GetShowSaveButton       : Boolean;begin Result := FSaveButton.Visible;          end;
function TiPlotToolBar.GetShowEditButton       : Boolean;begin Result := FEditButton.Visible;          end;
function TiPlotToolBar.GetShowAxesModeButtons  : Boolean;begin Result := FAxesModeScrollButton.Visible;end;
function TiPlotToolBar.GetShowCursorButton     : Boolean;begin Result := FCursorButton.Visible;        end;
function TiPlotToolBar.GetShowPauseButton      : Boolean;begin Result := FPauseButton.Visible;         end;
function TiPlotToolBar.GetShowResumeButton     : Boolean;begin Result := FResumeButton.Visible;        end;
function TiPlotToolBar.GetShowZoomBoxButton    : Boolean;begin Result := FZoomBoxButton.Visible;       end;
function TiPlotToolBar.GetShowZoomInOutButtons : Boolean;begin Result := FZoomInButton.Visible;        end;
function TiPlotToolBar.GetShowSelectButton     : Boolean;begin Result := FSelectButton.Visible;        end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.SetFlatBorder(const Value: Boolean);begin SetBooleanProperty(Value, FFlatBorder, TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.SetFlatButtons(const Value: Boolean);                    
var
  x : Integer;
begin
  if FFlatButtons <> Value then
    begin
      FFlatButtons := Value;
      for x := 0 to FButtonList.Count-1 do
        (FButtonList.Objects[x] as TiPlotToolBarButton).Flat := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.ResumeClick(Sender: TObject);
var
  x       : Integer;
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtResume, ACancel);
  if ACancel then Exit;

  with TiPlotComponentAccess(Owner) do
    begin
      if CursorActive then DoButtonClickCursor;
      if SelectActive then DoButtonClickSelect;

      for x := 0 to ObjectManager.Count-1 do
        ObjectManager.Items[x].UserSelected := False;

      EnableAllTracking;

    end;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtResume);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.PauseClick(Sender: TObject);
var
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtPause, ACancel);
  if ACancel then Exit;

  TiPlotComponentAccess(Owner).DisableAllTracking;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtPause);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.ZoomInClick(Sender: TObject);
var
  x       : Integer;
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtZoomIn, ACancel);
  if ACancel then Exit;

  DoButtonClickPause;
  with TiPlotComponentAccess(Owner) do
    begin
      for x := 0 to XAxisCount-1 do
        case XAxis[x].ScaleType of
          ipstLinear : XAxis[x].Zoom(1/ZoomInOutFactor);
          ipstLog10  : XAxis[x].Zoom(-1);
        end;
      for x := 0 to YAxisCount-1 do
        case YAxis[x].ScaleType of
          ipstLinear : YAxis[x].Zoom(1/ZoomInOutFactor);
          ipstLog10  : YAxis[x].Zoom(-1);
        end;
    end;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtZoomIn);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.ZoomOutClick(Sender: TObject);
var
  x       : Integer;
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtZoomOut, ACancel);
  if ACancel then Exit;

  DoButtonClickPause;
  with TiPlotComponentAccess(Owner) do
    begin
      for x := 0 to XAxisCount-1 do
        case XAxis[x].ScaleType of
          ipstLinear : XAxis[x].Zoom(ZoomInOutFactor);
          ipstLog10  : XAxis[x].Zoom(1);
        end;
      for x := 0 to YAxisCount-1 do
        case YAxis[x].ScaleType of
          ipstLinear : YAxis[x].Zoom(ZoomInOutFactor);
          ipstLog10  : YAxis[x].Zoom(1);
        end;
    end;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtZoomOut);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.EditClick(Sender: TObject);
var
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtEdit, ACancel);
  if ACancel then Exit;

  TiPlotComponentAccess(Owner).Master.EditProperties;
  //TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtEdit);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.CopyClick(Sender: TObject);
var
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtCopy, ACancel);
  if ACancel then Exit;

  TiPlotComponentAccess(Owner).CopyToClipBoard;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtCopy);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.SaveClick(Sender: TObject);
var
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtSave, ACancel);
  if ACancel then Exit;

  TiPlotComponentAccess(Owner).Save;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtSave);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.PrintClick(Sender: TObject);
var
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtPrint, ACancel);
  if ACancel then Exit;

  TiPlotComponentAccess(Owner).PrintChart;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtPrint);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.PreviewClick(Sender: TObject);
var
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtPreview, ACancel);
  if ACancel then Exit;

  TiPlotComponentAccess(Owner).PreviewChart;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtPreview);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.AxesModeScrollClick(Sender: TObject);
var
  x       : Integer;
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtScrollAxesMode, ACancel);
  if ACancel then Exit;

  FAxesModeScrollButton.Down := True;
  FAxesModeZoomButton.Down   := False;

  with TiPlotComponentAccess(Owner) do
    begin
      for x := 0 to XAxisCount-1 do
        XAxis[x].Mode := ipamScroll;
      for x := 0 to YAxisCount-1 do
        YAxis[x].Mode := ipamScroll;
    end;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtScrollAxesMode);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.AxesModeZoomClick(Sender: TObject);
var
  x       : Integer;
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtZoomAxesMode, ACancel);
  if ACancel then Exit;

  FAxesModeZoomButton.Down   := True;
  FAxesModeScrollButton.Down := False;

  with TiPlotComponentAccess(Owner) do
    begin
      for x := 0 to XAxisCount-1 do
        XAxis[x].Mode := ipamZoom;
      for x := 0 to YAxisCount-1 do
        YAxis[x].Mode := ipamZoom;
    end;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtZoomAxesMode);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.SelectClick(Sender: TObject);
var
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtSelect, ACancel);
  if ACancel then Exit;

  FSelectButton.Down  := not FSelectButton.Down;
  FZoomBoxButton.Down := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtSelect);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.CursorClick(Sender: TObject);
var
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtCursor, ACancel);
  if ACancel then Exit;

  FCursorButton.Down := not FCursorButton.Down;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtCursor);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.ZoomBoxClick(Sender: TObject);
var
  ACancel : Boolean;
begin
  ACancel := False;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonBeforeClick(Self, iptbbtZoomBox, ACancel);
  if ACancel then Exit;

  FSelectButton.Down  := False;
  FZoomBoxButton.Down := not FZoomBoxButton.Down;
  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarButtonClick(Self, iptbbtZoomBox);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.ZoomBoxDownChange(Sender: TObject);
//var
//  DataViewMode : TiPlotDataViewMode;
//  x            : Integer;
begin
  with TiPlotComponentAccess(Owner) do
    begin
//      if ZoomBoxActive then DataViewMode := ipdvmZoomBox else DataViewMode := ipdvmNone;
//      Tri
//      for x := 0 to DataViewCount-1 do
//        TiPlotDataViewAccess(DataView[x]).Mode := DataViewMode;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.CursorDownChange(Sender: TObject);
var
  x : Integer;
begin
  with TiPlotComponentAccess(Owner) do
    begin
      if CursorActive then
          begin
            for x := 0 to DataCursorCount-1 do
              DataCursor[x].Visible := True;

            DisableAllTracking;
            if DataCursorCount > 0 then DataCursor[0].UserSelected := True;
          end
      else
        begin
          for x := 0 to DataCursorCount-1 do
            DataCursor[x].Visible := False;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.SelectDownChange(Sender: TObject);
begin
  with TiPlotComponentAccess(Owner) do
    begin
      if SelectActive then
          begin
            DisableAllTracking;
            SelectModeActive := True;
          end
      else
        begin
          SelectModeActive := False;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.DoButtonClickResume;         begin ResumeClick        (Self);end;
procedure TiPlotToolBar.DoButtonClickPause;          begin PauseClick         (Self);end;
procedure TiPlotToolBar.DoButtonClickScrollAxesMode; begin AxesModeScrollClick(Self);end;
procedure TiPlotToolBar.DoButtonClickZoomAxesMode;   begin AxesModeZoomClick  (Self);end;
procedure TiPlotToolBar.DoButtonClickZoomIn;         begin ZoomInClick        (Self);end;
procedure TiPlotToolBar.DoButtonClickZoomOut;        begin ZoomOutClick       (Self);end;
procedure TiPlotToolBar.DoButtonClickSelect;         begin SelectClick        (Self);end;
procedure TiPlotToolBar.DoButtonClickZoomBox;        begin ZoomBoxClick       (Self) end;
procedure TiPlotToolBar.DoButtonClickCursor;         begin CursorClick        (Self);end;
procedure TiPlotToolBar.DoButtonClickEdit;           begin EditClick          (Self);end;
procedure TiPlotToolBar.DoButtonClickCopy;           begin CopyClick          (Self);end;
procedure TiPlotToolBar.DoButtonClickSave;           begin SaveClick          (Self);end;
procedure TiPlotToolBar.DoButtonClickPrint;          begin PrintClick         (Self);end;
procedure TiPlotToolBar.DoButtonClickPreview;        begin PreviewClick       (Self);end;
//****************************************************************************************************************************************************
function TiPlotToolBar.CreateSpacer : TiPlotToolBarButton;
begin
  Result         := TiPlotToolBarButton.Create(Owner, nil, nil, nil, nil);
  Result.Style   := iptbbsSpacer;
  Result.Visible := True;
  FButtonList.AddObject('', Result);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.ButtonInvalidate(Sender: TObject);
begin
  TriggerInvalidateNow(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.UpdateSpacers;
begin
  FResumePauseSpacer.Visible   := FResumeButton.Visible         or FPauseButton.Visible;
  FAxesModeSpacer.Visible      := FAxesModeScrollButton.Visible or FAxesModeZoomButton.Visible;
  FZoomInOutSpacer.Visible     := FZoomInButton.Visible         or FZoomOutButton.Visible;
  FZoomBoxCursorSpacer.Visible := FZoomBoxButton.Visible        or FCursorButton.Visible;
  FEditSpacer.Visible          := FEditButton.Visible;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.UpdateResumePauseButtons;
var
  x                   : Integer;
  AnyTrackingDisabled : Boolean;
  AllTrackingDisabled : Boolean;
begin
  AnyTrackingDisabled := False;
  AllTrackingDisabled := True;

  with TiPlotComponentAccess(Owner) do
    begin
      for x := 0 to XAxisCount - 1 do
        begin
          if not XAxis[x].TrackingEnabled then AnyTrackingDisabled := True;
          if     XAxis[x].TrackingEnabled then AllTrackingDisabled := False;
        end;

      for x := 0 to YAxisCount - 1 do
        begin
          if not YAxis[x].TrackingEnabled then AnyTrackingDisabled := True;
          if     YAxis[x].TrackingEnabled then AllTrackingDisabled := False;
        end;

      FResumeButton.Enabled := AnyTrackingDisabled;

      FPauseButton.Enabled  := not AllTrackingDisabled;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotToolBar.GetCursorActive : Boolean;begin Result := FCursorButton.Down; end;
function TiPlotToolBar.GetZoomBoxActive: Boolean;begin Result := FZoomBoxButton.Down;end;
function TiPlotToolBar.GetSelectActive : Boolean;begin Result := FSelectButton.Down; end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.TurnOffCursor;
begin
  FCursorButton.Down := False;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  ARect      : TRect;
  x          : Integer;
  iButton    : TiPlotToolBarButton;
  ALeft      : Integer;
  AWidth     : Integer;
  ButtonSize : Integer;
begin
  inherited Draw(Canvas, BackGroundColor);
  if not Visible then Exit;

  if FSmallButtons then ButtonSize := 22 else ButtonSize := 30;

  UpdateSpacers;
  UpdateResumePauseButtons;

  with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := clBtnFace;
      Pen.Width   := 1;
      ARect       := DrawRect;
      ARect.Right := ARect.Right + 1;
      FillRect(ARect);
      if not FFlatBorder then iDrawEdge(Canvas, DrawRect, idesRaised);

    ALeft := Left + ButtonLeftOffset;
    for x := 0 to FButtonList.Count-1 do
      begin
        iButton        := FButtonList.Objects[x] as TiPlotToolBarButton;

        if not iButton.Visible then Continue;

        if iButton.Style = iptbbsButton then AWidth := ButtonSize else AWidth := SpacerWidth;

        iButton.Left   := ALeft;
        iButton.Right  := iButton.Left + AWidth;
        iButton.Top    := Top + ButtonTopOffset;
        iButton.Bottom := iButton.Top + ButtonSize;
        iButton.Draw(Canvas, BackGroundColor);

        ALeft := ALeft + AWidth;
      end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotToolBar.GetRequiredWidth(const Canvas : TCanvas) : Integer;
begin
  with Canvas do
    begin
      if FSmallButtons then Result := 28 else Result := 36;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.GroupClick(Sender: TObject);
var
  x      : Integer;
  Button : TiPlotToolBarButton;
begin
  for x := 0 to FButtonList.Count-1 do
    begin
      Button := FButtonList.Objects[x] as TiPlotToolBarButton;
      if (Button <> Sender) and (Button.GroupIndex = (Sender as TiPlotToolBarButton).GroupIndex) then
        Button.Down := False;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.NotificationSetFocus(Sender: TObject);
begin
  if Sender = Self                                                      then Exit;
  if not (Sender as TiPlotObject).UserSelected                          then Exit;

  SetUserSelected(False);
end;
//****************************************************************************************************************************************************
{ TiPlotToolBarButton }
//****************************************************************************************************************************************************
procedure TiPlotToolBarButton.DoMouseHint(MouseData: TiPlotMouseData; var HintData: TiHintData);
begin
  HintData.Text := GetTranslation(Hint);
  HintData.Top  := Bottom + 3;
  HintData.Left := Left;

  TiPlotComponentAccess(Owner as TiPlotComponent).DoToolBarCustomizeHint(ToolBar, HintData.Text);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBarButton.iMouseMove(var HintData: TiHintData; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; DblClickActive: Boolean);
begin
  inherited;
  FMouseOver := True;
  if FFlat then TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBarButton.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  ARect   : TRect;
  OffSetX : Integer;
  OffSetY : Integer;
  Bitmap  : TBitmap;
begin
  if FStyle = iptbbsSpacer then Exit;

  if (FImageIndex = -1) and (FImageName <> '') then
    begin
      Bitmap := TBitmap.Create;
      try
        Bitmap.LoadFromResourceName(HInstance, FImageName);
        FImageIndex := FImageList.AddMasked(Bitmap, clTeal);
      finally
        Bitmap.Free;
      end;
    end;

  with Canvas, DrawRect do
    begin
      ARect := DrawRect;

      OffSetX  := Left + Self.Width  div 2 - FImageList.Width  div 2;
      OffSetY  := Top  + Self.Height div 2 - FImageList.Height div 2;

      if not FFlat then
        begin
          if MouseDown or Down then
            begin
              Brush.Color :=  ColorToRGB(clWhite) and $FFFFFF - $101010;
              FillRect(ARect);
              iDrawEdge(Canvas, ARect, idesSunken);
              OffSetX := OffSetX + 1;
              OffSetY := OffSetY + 1;
            end
          else iDrawEdge(Canvas, ARect, idesRaised)
        end
      else
        begin
          if (MouseDown or Down) and not FMouseOver then
            begin
              Brush.Color :=  ColorToRGB(clWhite) and $FFFFFF - $101010;
              FillRect(ARect);
            end;

          if Enabled then
            begin
              if MouseDown or Down then
                begin
                  OffSetX := OffSetX + 1;
                  OffSetY := OffSetY + 1;
                  DrawLoweredEdge(Canvas);
                end
              else if FMouseOver then DrawRaisedEdge (Canvas);
            end;

        end;

      {$ifdef iVCL}FImageList.Draw(Canvas, OffSetX, OffSetY, FImageIndex, Enabled);         {$endif}
      {$ifdef iCLX}FImageList.Draw(Canvas, OffSetX, OffSetY, FImageIndex, itImage, Enabled);{$endif}
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBarButton.DrawLoweredEdge(const Canvas: TCanvas);
var
  ARect : TRect;
begin
  ARect := Rect(DrawRect.Left, DrawRect.Top, DrawRect.Right-1, DrawRect.Bottom-1);
  with Canvas, ARect do
    begin
      Pen.Color := clBtnShadow;
      Polyline([Point(Left, Bottom), Point(Left, Top), Point(Right, Top)]);

      Pen.Color := clBtnHighlight;
      Polyline([Point(Right, Top), Point(Right, Bottom), Point(Left, Bottom)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBarButton.DrawRaisedEdge(const Canvas: TCanvas);
var
  ARect : TRect;
begin
  ARect := Rect(DrawRect.Left, DrawRect.Top, DrawRect.Right-1, DrawRect.Bottom-1);
  with Canvas, ARect do
    begin
      Pen.Color := clBtnHighlight;
      Polyline([Point(Left, Bottom), Point(Left, Top), Point(Right, Top)]);

      Pen.Color := clBtnShadow;
      Polyline([Point(Right, Top), Point(Right, Bottom), Point(Left, Bottom)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBarButton.DoMouseNotOver;
begin
  inherited;
  FMouseOver := False;
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotToolBar.SetSmallButtons(const Value: Boolean);
begin
  if FSmallButtons <> Value then
    begin
      FSmallButtons := Value;
      if FSmallButtons then SetupSmallImages else SetupLargeImages;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
end.
