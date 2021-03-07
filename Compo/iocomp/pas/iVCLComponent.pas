{*******************************************************}
{                                                       }
{       TiVCLComponent                                  }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$IFDEF iVCL} unit  iVCLComponent;{$ENDIF}

interface

uses
  {$I iIncludeUses.inc}
  iTypes, iGPFunctions, iMath, iComponent, iOPCItem, ActiveX, JPeg, iClasses, Registry, PNGImage, iOPCDLLLoader, Menus;

type                                                       
  TiVCLComponent = class(TiComponent)
  private
    FWindowHandle        : HWND;
    FPaintDCTransparent  : Boolean;
    FTransparentBitmap   : TBitmap;
    FDataCriticalSection : TRTLCriticalSection;
    FTransparent         : Boolean;

    FOPCItemManager      : TiOPCItemManager;
    FOPCSpecialList      : TStringList;
    FOPCIncomingActive   : Boolean;

    FTimerID             : Integer;
    FTimerFirstMessage   : Boolean;
    FTimerInterval       : Integer;
    FOnInternalTimer     : TNotifyEvent;
    FOnNewOPCData        : TIndexObjectEvent;

    FThemeCategoryList   : TStringList;
    FOnBeforeNewOPCData  : TBeforeOPCNewDataEvent;

    {$IFDEF NASA_KENNEDY}
    FPopUpMenu           : TPopupMenu;
    FDetailsExePath      : String;
    FDetialOptionsLoaded : Boolean;
    {$ENDIF}
  protected
    {$IFDEF NASA_KENNEDY}
    FDetailsEnabled      : Boolean;
    {$ENDIF}

    FNeedsTransparentCapture  : Boolean;

    procedure WMGetDLGCode      (var Message: TMessage);         message WM_GETDLGCODE;

    procedure CMWantSpecialKey  (var Message: TCMWantSpecialKey);message CM_WANTSPECIALKEY;

    procedure CMSYSColorChange  (var Message: TMessage);         message CM_SYSCOLORCHANGE;
    procedure CMColorChanged    (var Message: TMessage);         message CM_COLORCHANGED;
    procedure CNKeyUp           (var Message: TWMKeyUp);         message CN_KEYUP;
    procedure CNKeyDown         (var Message: TWMKeyDown);       message CN_KEYDOWN;
    procedure WMSYSColorChange  (var Message: TMessage);         message WM_SYSCOLORCHANGE;
    procedure WMEraseBkGnd      (var Message: TMessage);         message WM_ERASEBKGND;
    procedure WMMove            (var Message: TMessage);         message WM_MOVE;
    procedure WMSetFocus        (var Message: TMessage);         message WM_SETFOCUS;
    procedure WMKillFocus       (var Message: TMessage);         message WM_KILLFOCUS;

    procedure WMLButtonDown     (var Message: TWMLButtonDown);   message WM_LBUTTONDOWN;
    procedure WMRButtonDown     (var Message: TWMRButtonDown);   message WM_RBUTTONDOWN;
    procedure WMMButtonDown     (var Message: TWMMButtonDown);   message WM_MBUTTONDOWN;

    procedure WMLButtonUp       (var Message: TWMLButtonUp);     message WM_LBUTTONUP;
    procedure WMRButtonUp       (var Message: TWMRButtonUp);     message WM_RBUTTONUP;
    procedure WMMButtonUp       (var Message: TWMMButtonUp);     message WM_MBUTTONUP;

    procedure WMLButtonDblClk   (var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMRButtonDblClk   (var Message: TWMRButtonDblClk); message WM_RBUTTONDBLCLK;
    procedure WMMButtonDblClk   (var Message: TWMMButtonDblClk); message WM_MBUTTONDBLCLK;

    procedure WndProc(var Message: TMessage); override;

    {$IFDEF NASA_KENNEDY}
    procedure Nasa_KennedyDoubleClick(var Message: TWMLButtonDblClk);
    procedure Nasa_KennedyRightClick(var Message: TWMRButtonDown);
    procedure Nasa_KennedyMenuItemClick(Sender: TObject);
    procedure Nasa_KennedyShowDetials(Value: String);
    procedure Nasa_KennedyGetRegistryOptions();                     virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);         override;
    {$ENDIF}

    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;

    procedure CreateParams(var Params: TCreateParams);           override;

    procedure SetTransparent(const Value: Boolean);              virtual;
    procedure GetTransparentBitmap;
    procedure RequestTransparentCapture;

    procedure DrawBackGround(Canvas: TCanvas; BackGroundColor: TColor); override;

    function  PaletteChanged(Foreground: Boolean): Boolean;             override;

    function  GetOPCItem(Index: Integer): TiOPCItem;
    function  OPCNewDataSpecial(PropertyName: String; NewData: OleVariant): Boolean;   virtual;

    procedure UpdateOPCSpecialList;                              virtual;
    procedure OPCSetProperty(Instance: TPersistent; Path: String; PropertyName: String; PropertyValue: OleVariant);

    procedure OPCNewData(Sender: TObject);
    function OPCOutputData(PropertyName: String; Value: OleVariant): Boolean; override;

    property  OPCSpecialList: TStringList read FOPCSpecialList;

    procedure CreateWnd;                                          override;
    procedure DefineProperties(Filer: TFiler);                    override;
    procedure TimerProc(var Message: TMessage);

    function  GetJPEG(Compression: Integer; Progressive: Boolean): TJPEGImage;

    function  GetTimerRunning : Boolean;                          override;

    procedure TimerStart(InitialDelay, Interval: Integer);        override;
    procedure TimerStop;                                          override;
    property  TimerRunning : Boolean  read GetTimerRunning;

    procedure ClearAllSchemes;
    procedure LoadAllThemes(FileStream: TiXMLMemoryStream; SchemeListClass: TiSchemeListClass);
    procedure GetThemePaths(var IocompPathName, UserPathName: String);
    function  GetThemeCategoryListByName(Name: String): TStringList;
    procedure SeparateNameValue(AText: String; var Name, Value: String);

    property  OnInternalTimer : TNotifyEvent read FOnInternalTimer write FOnInternalTimer;
    property  Transparent     : Boolean      read FTransparent     write SetTransparent        default False;
  public
    constructor Create(AOwner: TComponent);                       override;
    destructor  Destroy;                                          override;

    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    procedure Lock;                                               override;
    procedure Unlock;                                             override;
    procedure RepaintAll;                                         override;

    procedure SaveImageToMetaFile(FileName: String);

    procedure LoadThemes;
    function  GetThemeCategoryCount                                            : Integer;
    function  GetThemeCategoryName        (CategoryIndex: Integer)             : String;
    function  GetThemeCategorySchemeCount (CategoryIndex: Integer)             : Integer;
    function  GetThemeCategorySchemeName  (CategoryIndex, SchemeIndex: Integer): String;
    function  GetThemeCategorySchemeIsUser(CategoryIndex, SchemeIndex: Integer): Boolean;
    procedure ApplyScheme                 (CategoryIndex, SchemeIndex: Integer);

    property  OPCItem[Index: Integer]: TiOPCItem read GetOPCItem;

    function  OPCAddItem   : Integer;
    procedure OPCDeleteItem(Index: Integer);
    function  OPCItemCount : Integer;
    procedure OPCRemoveAllItems;

    procedure OPCItemActivate       (Index:Integer);
    procedure OPCItemDeactivate     (Index:Integer);
    procedure OPCItemUpdateResume   (Index:Integer);
    procedure OPCItemUpdateSuspend  (Index:Integer);
    procedure OPCItemLoaded         (Index:Integer);

    function  GetOPCItemComputerName(Index: Integer):String;
    function  GetOPCItemServerName  (Index: Integer):String;
    function  GetOPCItemItemName    (Index: Integer):String;
    function  GetOPCItemPropertyName(Index: Integer):String;
    function  GetOPCItemAutoConnect (Index: Integer):Boolean;
    function  GetOPCItemUpdateRate  (Index: Integer):Integer;

    function  GetOPCItemData        (Index: Integer):OleVariant;
    function  GetOPCItemQuality     (Index: Integer):Word;
    function  GetOPCItemTimeStamp   (Index: Integer):TDateTime;

    procedure SetOPCItemData        (Index: Integer; Value: OleVariant);

    procedure SetOPCItemComputerName(Index: Integer; Value: String);
    procedure SetOPCItemServerName  (Index: Integer; Value: String);
    procedure SetOPCItemItemName    (Index: Integer; Value: String);
    procedure SetOPCItemPropertyName(Index: Integer; Value: String);
    procedure SetOPCItemAutoConnect (Index: Integer; Value: Boolean);
    procedure SetOPCItemUpdateRate  (Index: Integer; Value: Integer);

    procedure SaveImageToJPEG(FileName: String; Compression: Integer; Progressive: Boolean);
    procedure SaveImageToPNG (FileName: String; Compression: Integer);
    function  GetBytesJPEG   (Compression: Integer; Progressive: Boolean): OleVariant;
    function  GetBytesPNG    (Compression: Integer                      ): OleVariant;

    procedure iPaintToDC(X, Y: Integer; Transparent: Boolean; DC : HDC);
  published
    property  OnNewOPCData       : TIndexObjectEvent      read FOnNewOPCData       write FOnNewOPCData;
    property  OnBeforeNewOPCData : TBeforeOPCNewDataEvent read FOnBeforeNewOPCData write FOnBeforeNewOPCData;
  end;

implementation

type
  TWinControlAccess = class(TWinControl) end;
//****************************************************************************************************************************************************
constructor TiVCLComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  InitializeCriticalSection(FDataCriticalSection);

  FOPCItemManager                := TiOPCItemManager.Create;
  FOPCItemManager.Owner          := Self;
  FOPCItemManager.OnGetDesigning := DoIsDesigning;
  FOPCItemManager.OnNewData      := OPCNewData;
  FOPCItemManager.OnGetType      := PropertyVarType;

  FOPCSpecialList    := TStringList.Create;
  FThemeCategoryList := TStringList.Create;
  FWindowHandle      := AllocateHWnd(TimerProc);
end;
//****************************************************************************************************************************************************
destructor TiVCLComponent.Destroy;
begin
  DeleteCriticalSection(FDataCriticalSection);
  if Assigned(FTransparentBitmap) then FTransparentBitmap.Free;
                                       FOPCItemManager.Free;
                                       FOPCSpecialList.Free;
                                       FThemeCategoryList.Free;

  if FTimerID  <> 0 then KillTimer(FWindowHandle, 1);

  {$IFDEF NASA_KENNEDY}
  if Assigned(FPopUpMenu) then
    begin
      FPopUpMenu.Free;
      FPopUpMenu := nil;
    end;
  {$ENDIF}

 {$WARNINGS OFF}
  DeallocateHWnd(FWindowHandle);
 {$WARNINGS ON}
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.CreateWnd;
begin
  inherited CreateWnd;
  SetWindowLong(Handle, GWL_ID, 0);
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (ALeft = Left) and (ATop = Top) and (AWidth = Width) and (AHeight = Height) then Exit;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  if Assigned(FTransparentBitmap) and (Width > 0) and (Height > 0) then
    begin
      FTransparentBitmap.Width  := Width;
      FTransparentBitmap.Height := Height;
    end;
  RequestTransparentCapture;

  if Assigned(BackGroundBitmap) and (Width > 0) and (Height > 0) then
    begin
      BackGroundBitmap.Width  := Width;
      BackGroundBitmap.Height := Height;
    end;
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('OPCItems', FOPCItemManager.ReadFromStream, FOPCItemManager.WriteToStream, FOPCItemManager.DoWriteToStream);
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.Lock;
begin
  if not(csDestroying  in ComponentState) then EnterCriticalSection(FDataCriticalSection);
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.Unlock;
begin
  if not(csDestroying  in ComponentState) then LeaveCriticalSection(FDataCriticalSection);
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.WMSYSColorChange(var Message: TMessage);
begin
  inherited;
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.CMSYSColorChange(var Message: TMessage);
begin
  inherited;
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.WMEraseBkGnd(var Message: TMessage);
begin
  Message.Result := 1;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.WMMove(var Message: TMessage);
begin
  inherited;
  RequestTransparentCapture;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.WMGetDLGCode(var Message: TMessage);                  
begin
  Message.Result := Message.Result or DLGC_WANTALLKEYS;
//  inherited; Do not Call Inherited. Lock up problem in Visual C++ on Win2000 
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.CMColorChanged(var Message: TMessage);
begin
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  inherited;
  iWantSpecialKey(Message.CharCode, Message.Result);
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.WMKillFocus(var Message: TMessage);
begin
  UserGenerated := True;
  try
    if Message.WParam <> Longint(Handle) then iDoKillFocus;
  finally
    UserGenerated := False;
  end;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.WMSetFocus (var Message: TMessage);
begin
  UserGenerated := True;
  try
    iDoSetFocus;
    inherited;
  finally
    UserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.CNKeyUp(var Message: TWMKeyUp);
begin
  UserGenerated := True;
  try
    try
      inherited;
      iKeyUp(Message.CharCode, []);
    except
      on exception do;
    end;
  finally
    UserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.CNKeyDown(var Message: TWMKeyDown);
begin
  UserGenerated := True;
  try
    try
      inherited;
      {$IFNDEF NASA_KENNEDY}
      iKeyDown(Message.CharCode, []);
      {$ENDIF}
    except
      on exception do;
    end;
  finally
    UserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.WMLButtonUp    (var Message: TWMLButtonUp    );begin try inherited;except on exception do; end;end;
procedure TiVCLComponent.WMMButtonUp    (var Message: TWMMButtonUp    );begin try inherited;except on exception do; end;end;
procedure TiVCLComponent.WMRButtonUp    (var Message: TWMRButtonUp    );begin try inherited;except on exception do; end;end;
procedure TiVCLComponent.WMMButtonDblClk(var Message: TWMMButtonDblClk);begin try inherited;except on exception do; end;end;
procedure TiVCLComponent.WMRButtonDblClk(var Message: TWMRButtonDblClk);begin try inherited;except on exception do; end;end;
procedure TiVCLComponent.WMLButtonDown  (var Message: TWMLButtonDown  );begin try inherited;except on exception do; end;end;
procedure TiVCLComponent.WMMButtonDown  (var Message: TWMMButtonDown  );begin try inherited;except on exception do; end;end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.WMLButtonDblClk(var Message: TWMLButtonDblClk);begin try inherited;{$IFDEF NASA_KENNEDY}Nasa_KennedyDoubleClick(Message);{$ENDIF}except on exception do;end;end;
procedure TiVCLComponent.WMRButtonDown  (var Message: TWMRButtonDown  );begin try inherited;{$IFDEF NASA_KENNEDY}Nasa_KennedyRightClick (Message);{$ENDIF}except on exception do;end;end;
//****************************************************************************************************************************************************
{$IFDEF NASA_KENNEDY}
procedure TiVCLComponent.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);

  Nasa_KennedyGetRegistryOptions;

  if not FDetailsEnabled then Exit;

  if Cursor <> crHandPoint then Cursor := crHandPoint;
end;
{$ENDIF}
//****************************************************************************************************************************************************
{$IFDEF NASA_KENNEDY}
procedure TiVCLComponent.Nasa_KennedyGetRegistryOptions();
var
  Registry : TRegistry;
begin
  if FDetialOptionsLoaded then Exit;

  FDetialOptionsLoaded := True;

  FDetailsEnabled := False;
  FDetailsExePath := '';

  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    if Registry.OpenKeyReadOnly('SOFTWARE\Iocomp\NasaKennedy') then
      begin
        if Registry.ValueExists('DetailsEnabled') then
          begin
            FDetailsEnabled := Registry.ReadBool('DetailsEnabled');

            if FDetailsEnabled then
              begin
                if Registry.ValueExists('DetailsExePath') then
                  FDetailsExePath := Registry.ReadString('DetailsExePath')
                else
                  ShowMessage('Detials Configuration Error : DetailsExePath registry key missing. Contact ELV Telmetry technical support');
              end;
          end
        else ShowMessage('Detials Configuration Error : DetailsEnabled registry key missing. Contact ELV Telmetry technical support');
        Registry.CloseKey;
      end;
  finally
    Registry.Free;
  end;
end;
{$ENDIF}
//****************************************************************************************************************************************************
{$IFDEF NASA_KENNEDY}
procedure TiVCLComponent.Nasa_KennedyDoubleClick(var Message: TWMLButtonDblClk);
var
  i       : Integer;
  AString : String;
begin
  Nasa_KennedyGetRegistryOptions;

  if not FDetailsEnabled then Exit;
  if OPCItemCount = 0    then Exit;

  for i := 0 to OPCItemCount-1 do
    begin
      if i = 0 then AString := OPCItem[i].ItemName
      else          AString := AString + ',' + OPCItem[i].ItemName;
    end;

  Nasa_KennedyShowDetials(AString);
end;
{$ENDIF}
//****************************************************************************************************************************************************
{$IFDEF NASA_KENNEDY}
procedure TiVCLComponent.Nasa_KennedyRightClick(var Message: TWMRButtonDown);
var
  i            : Integer;
  AMenuItem    : TMenuItem;
  AScreenPoint : TPoint;
begin
  Nasa_KennedyGetRegistryOptions;

  if not FDetailsEnabled then Exit;
  if OPCItemCount = 0    then Exit;

  AScreenPoint := ClientToScreen(Point(Message.XPos, Message.YPos));

  if not Assigned(FPopUpMenu) then FPopUpMenu := TPopupMenu.Create(Self);

  FPopUpMenu.Items.Clear;

  if OPCItemCount > 1 then
    begin
      AMenuItem         := TMenuItem.Create(FPopUpMenu);
      AMenuItem.Caption := 'All';
      AMenuItem.OnClick := Nasa_KennedyMenuItemClick;
      FPopUpMenu.Items.Add(AMenuItem);

      AMenuItem         := TMenuItem.Create(FPopUpMenu);
      AMenuItem.Caption := '-';
      FPopUpMenu.Items.Add(AMenuItem);
    end;

  for i := 0 to OPCItemCount-1 do
    begin
      AMenuItem         := TMenuItem.Create(FPopUpMenu);
      AMenuItem.Caption := OPCItem[i].ItemName;
      AMenuItem.OnClick := Nasa_KennedyMenuItemClick;
      FPopUpMenu.Items.Add(AMenuItem);
    end;

  FPopUpMenu.Popup(AScreenPoint.X, AScreenPoint.Y);
end;
{$ENDIF}
//****************************************************************************************************************************************************
{$IFDEF NASA_KENNEDY}
procedure TiVCLComponent.Nasa_KennedyMenuItemClick(Sender: TObject);
var
  i         : Integer;
  AString   : String;
  AMenuItem : TMenuItem;
begin
  AMenuItem := Sender as TMenuItem;

  if AMenuItem.Caption = '&All' then
    begin
      for i := 0 to OPCItemCount-1 do
        begin
          if i = 0 then AString := OPCItem[i].ItemName
          else          AString := AString + ',' + OPCItem[i].ItemName;
        end;

      Nasa_KennedyShowDetials(AString);
    end
  else
    begin
      AString := AMenuItem.Caption;
      AString := StringReplace(AString, '&', '', [rfReplaceAll, rfIgnoreCase]);
      Nasa_KennedyShowDetials(AString);
    end;
end;
{$ENDIF}
//****************************************************************************************************************************************************
{$IFDEF NASA_KENNEDY}
procedure TiVCLComponent.Nasa_KennedyShowDetials(Value: String);
var
  AString : String;
begin
  AString := FDetailsExePath + ' ' + Value;
  WinExec(PChar(AString), 1);
end;
{$ENDIF}
//****************************************************************************************************************************************************
function TiVCLComponent.PaletteChanged(Foreground: Boolean): Boolean;
begin
  Result := inherited PaletteChanged(Foreground);
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.SaveImageToMetaFile(FileName: String);
var
  MetaFile       : TMetaFile;
  MetaFileCanvas : TMetaFileCanvas;
begin
  MetaFile := TMetaFile.Create;
  try
    MetaFile.Width    := Width;
    MetaFile.Height   := Height;
    MetaFile.Enhanced := True;

    MetaFileCanvas := TMetafileCanvas.CreateWithComment(MetaFile, 0, 'Iocomp', '');
    try
      iPaintTo(MetaFileCanvas);
    finally
      MetaFileCanvas.Free;
    end;
    MetaFile.SaveToFile(FileName);
  finally
    MetaFile.Free;
  end;                             
end;
//****************************************************************************************************************************************************
function  TiVCLComponent.OPCAddItem: Integer;                  begin Result := FOPCItemManager.Add;end;
function  TiVCLComponent.OPCItemCount: Integer;                begin Result := FOPCItemManager.Count;end;

procedure TiVCLComponent.OPCRemoveAllItems;                    begin           FOPCItemManager.Clear;end;

procedure TiVCLComponent.OPCDeleteItem       (Index: Integer); begin           FOPCItemManager.Delete(Index);end;

procedure TiVCLComponent.OPCItemActivate     (Index: Integer); begin           FOPCItemManager.Items[Index].Activate;end;
procedure TiVCLComponent.OPCItemDeactivate   (Index: Integer); begin           FOPCItemManager.Items[Index].Deactivate;end;
procedure TiVCLComponent.OPCItemUpdateResume (Index: Integer); begin           FOPCItemManager.Items[Index].UpdateResume;end;
procedure TiVCLComponent.OPCItemUpdateSuspend(Index: Integer); begin           FOPCItemManager.Items[Index].UpdateSuspend;end;
procedure TiVCLComponent.OPCItemLoaded       (Index: Integer); begin           FOPCItemManager.Items[Index].Loaded;end;

function  TiVCLComponent.GetOPCItem(Index: Integer): TiOPCItem;begin Result := FOPCItemManager.Items[Index];end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.SetOPCItemData        (Index: Integer; Value: OleVariant);begin FOPCItemManager.Items[Index].Data        := Value;end;
procedure TiVCLComponent.SetOPCItemComputerName(Index: Integer; Value: String    );begin FOPCItemManager.Items[Index].ComputerName:= Value;end;
procedure TiVCLComponent.SetOPCItemServerName  (Index: Integer; Value: String    );begin FOPCItemManager.Items[Index].ServerName  := Value;end;
procedure TiVCLComponent.SetOPCItemItemName    (Index: Integer; Value: String    );begin FOPCItemManager.Items[Index].ItemName    := Value;end;
procedure TiVCLComponent.SetOPCItemPropertyName(Index: Integer; Value: String    );begin FOPCItemManager.Items[Index].PropertyName:= Value;end;
procedure TiVCLComponent.SetOPCItemAutoConnect (Index: Integer; Value: Boolean   );begin FOPCItemManager.Items[Index].AutoConnect := Value;end;
procedure TiVCLComponent.SetOPCItemUpdateRate  (Index: Integer; Value: Integer   );begin FOPCItemManager.Items[Index].UpdateRate  := Value;end;
//****************************************************************************************************************************************************
function TiVCLComponent.GetOPCItemComputerName(Index: Integer): String;    begin Result := FOPCItemManager.Items[Index].ComputerName;end;
function TiVCLComponent.GetOPCItemServerName  (Index: Integer): String;    begin Result := FOPCItemManager.Items[Index].ServerName;  end;
function TiVCLComponent.GetOPCItemItemName    (Index: Integer): String;    begin Result := FOPCItemManager.Items[Index].ItemName;    end;
function TiVCLComponent.GetOPCItemPropertyName(Index: Integer): String;    begin Result := FOPCItemManager.Items[Index].PropertyName;end;
function TiVCLComponent.GetOPCItemAutoConnect (Index: Integer): Boolean;   begin Result := FOPCItemManager.Items[Index].AutoConnect; end;
function TiVCLComponent.GetOPCItemUpdateRate  (Index: Integer): Integer;   begin Result := FOPCItemManager.Items[Index].UpdateRate;  end;
function TiVCLComponent.GetOPCItemData        (Index: Integer): OleVariant;begin Result := FOPCItemManager.Items[Index].Data;        end;
function TiVCLComponent.GetOPCItemQuality     (Index: Integer): Word;      begin Result := FOPCItemManager.Items[Index].Quality;     end;
function TiVCLComponent.GetOPCItemTimeStamp   (Index: Integer): TDateTime; begin Result := FOPCItemManager.Items[Index].TimeStamp;   end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.OPCSetProperty(Instance: TPersistent; Path: String; PropertyName: String; PropertyValue: OleVariant);
var
  i         : Integer;
  Count     : Integer;                            
  PropName  : String;
  PropInfo  : PPropInfo;
  PropList  : PPropList;
  TypeData  : PTypeData;
  SubClass  : TObject;
  AValue    : String;
  Found     : Boolean;
begin
  Count := GetTypeData(Instance.ClassInfo)^.PropCount;
  if Count > 0 then
  begin
    GetMem(PropList, Count * SizeOf(Pointer));
    try
      GetPropInfos(Instance.ClassInfo, PropList);
      for i := 0 to Count - 1 do
      begin
        PropInfo := PropList^[i];
        if PropInfo <> nil then
          begin
            if Assigned(PropInfo^.SetProc) then
              begin
                if Trim(Path) <> '' then PropName  := Path + '.' + PropInfo.Name
                  else PropName  := PropInfo.Name;

                Found := True;
                if PropInfo^.PropType^.Kind <> tkClass then Found := UpperCase(PropertyName) = UpperCase(PropName);

                if not Found then Continue;

                case PropInfo^.PropType^.Kind of
                  tkEnumeration            : begin
                                               AValue := PropertyValue;
                                               if Uppercase(AValue) = UpperCase('True')  then AValue := '1';
                                               if Uppercase(AValue) = UpperCase('False') then AValue := '0';

                                               TypeData := GetTypeData(PropInfo^.PropType^);
                                               if (TypeData.MinValue = 0) and (TypeData.MaxValue = 1) then
                                                 begin
                                                   if AValue <> '0' then AValue := '1';
                                                 end;
                                               SetOrdProp  (Instance, GetPropInfo(PTypeInfo(Instance.ClassInfo), PropInfo.Name), StrToInt(AValue));
                                             end;
                  tkInteger, tkSet, tkChar : begin
                                               AValue := PropertyValue;
                                               SetOrdProp  (Instance, GetPropInfo(PTypeInfo(Instance.ClassInfo), PropInfo.Name), StrToInt(AValue));
                                             end;
                  tkFloat                  : begin
                                               AValue := PropertyValue;
                                               SetFloatProp(Instance, GetPropInfo(PTypeInfo(Instance.ClassInfo), PropInfo.Name), StrToFloat(AValue));
                                             end;
                  tkString, tkLString, tkWString : begin
                                                     AValue := PropertyValue;
                                                     //SetLength
                                                     SetStrProp  (Instance, GetPropInfo(PTypeInfo(Instance.ClassInfo), PropInfo.Name), AValue);
                                                   end;
                  tkClass                        : begin
                                                     SubClass := GetObjectProperty(Instance, PropInfo.Name);
                                                     if SubClass is TPersistent then
                                                       OPCSetProperty(SubClass as TPersistent, PropName, PropertyName, PropertyValue);
                                                   end;
                end;
              end;
          end
        else Break;
      end;
    finally
      FreeMem(PropList, Count * SizeOf(Pointer));
    end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.OPCNewData(Sender: TObject);
var
  OPCItem  : TiOPCItem;
  Index    : Integer;
  TempData : OleVariant;
begin
  OPCItem := Sender as TiOPCItem;

  if OPCItem.PropertyName = '' then Exit;

  Index := FOPCItemManager.FindIndex(OPCItem);

  TempData := OPCItem.Data;
  if Assigned(FOnBeforeNewOPCdata) then FOnBeforeNewOPCData(Index, TempData);

  FOPCIncomingActive := True;
  try
    if OPCItem.QualityGood then
      begin
        if not OPCNewDataSpecial(OPCItem.PropertyName, TempData) then
          OPCSetProperty(Self, '', OPCItem.PropertyName, TempData);
      end;

    if Assigned(FOnNewOPCData) then FOnNewOPCData(Index);
  finally
    FOPCIncomingActive := False;
  end;
end;
//****************************************************************************************************************************************************
function TiVCLComponent.OPCOutputData(PropertyName: String; Value: OleVariant): Boolean;
var
  OPCItem : TiOPCItem;
  x       : Integer;
begin
  Result := False;
  if FOPCIncomingActive then
    begin
      FOPCIncomingActive := False;
      Exit;
    end;

  for x := 0 to FOPCItemManager.Count-1 do
    begin
      OPCItem := FOPCItemManager.Items[x] as TiOPCItem;
      if not OPCItem.Active then Continue;
      if UpperCase(OPCItem.PropertyName) = UpperCase(PropertyName) then
        begin
          OPCItem.Data := Value;
          Result := True;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiVCLComponent.OPCNewDataSpecial(PropertyName: String; NewData: OleVariant): Boolean;
begin
  Result := False;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.UpdateOPCSpecialList;
begin

end;
//****************************************************************************************************************************************************
function TiVCLComponent.GetTimerRunning: Boolean;
begin
  Result := FTimerID <> 0;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.TimerStart(InitialDelay, Interval: Integer);
begin
  if FTimerID = 0 then
    begin
      FTimerInterval := Interval;
      if InitialDelay <> 0 then
        begin
          FTimerID           := SetTimer(FWindowHandle, 1, InitialDelay, nil);
          FTimerFirstMessage := True;
        end
      else if Interval <> 0 then
        begin
          FTimerID           := SetTimer(FWindowHandle, 1, FTimerInterval, nil);
          FTimerFirstMessage := False;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.TimerStop;
begin
  if FTimerID <> 0 then
    begin
      KillTimer(FWindowHandle, FTimerID);
      FTimerID := 0;
    end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.TimerProc(var Message: TMessage);
begin
  if (Message.Msg = WM_TIMER) and (Message.WParam = 1) then
    begin
      if FTimerFirstMessage then
        begin
          FTimerFirstMessage := False;
          SetTimer(FWindowHandle, FTimerID, FTimerInterval, nil);
        end;
      if Assigned(FOnInternalTimer) then FOnInternalTimer(Self);
    end
  else if Message.Msg = WM_ENDSESSION then
    begin
      Message.Result := 0;
      Message.WParam := 1;
    end
  else
    Message.Result := DefWindowProc(FWindowHandle, Message.Msg, Message.wParam, Message.lParam);
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.GetTransparentBitmap;
var
  AllVisible : Boolean;
begin
  if FNeedsTransparentCapture then
    begin
      AllVisible := True;
      if not PtVisible(Canvas.Handle, 5,              5) then AllVisible := False;
      if not PtVisible(Canvas.Handle, Width-5,        5) then AllVisible := False;
      if not PtVisible(Canvas.Handle, 5,       Height-5) then AllVisible := False;
      if not PtVisible(Canvas.Handle, Width-5, Height-5) then AllVisible := False;

      if not AllVisible then
      begin
        with FTransparentBitmap.Canvas do
          begin
            Brush.Style := bsSolid;
            Brush.Color := BackGroundColor;
            FillRect(Rect(0, 0 ,Width, Height));
          end;
        Exit;
      end;

      FTransparentBitmap.Canvas.CopyRect(Rect(0, 0, Width, Height), Canvas, Rect(0, 0, Width, Height));
      FNeedsTransparentCapture := False;
    end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.RequestTransparentCapture;
begin
  if FTransparent and not FNeedsTransparentCapture then
    begin
      FNeedsTransparentCapture := True;
      BackGroundChange;
      SetWindowLong(Handle, GWL_HWNDPARENT, GetParent(Handle));
    end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> Value then
    begin
      FTransparent := Value;
      if FTransparent then
        begin
          SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TRANSPARENT);
          if not Assigned(FTransparentBitmap) then
            begin
              FTransparentBitmap        := TBitmap.Create;
              FTransparentBitmap.Width  := Width;
              FTransparentBitmap.Height := Height;
              RequestTransparentCapture;
            end;
          RequestTransparentCapture;
        end
      else
        begin
          SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) and (not WS_EX_TRANSPARENT));
          if Assigned(FTransparentBitmap) then
            begin
              FTransparentBitmap.Free;
              FTransparentBitmap := nil;
            end;
        end;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.DrawBackGround(Canvas: TCanvas; BackGroundColor: TColor);
begin
  if FPaintDCTransparent then Exit;
  if FTransparent then
    begin
      FTransparentBitmap.Handle;
      if FNeedsTransparentCapture then GetTransparentBitmap;
      Canvas.Draw(0, 0, FTransparentBitmap);
    end
  else
    inherited DrawBackGround(Canvas, BackGroundColor);
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.RepaintAll;
begin
  inherited;
  RequestTransparentCapture;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.WndProc(var Message: TMessage);
begin
//  Lock;
  try
    inherited WndProc(Message);
  finally
//    Unlock;
  end;
end;
//****************************************************************************************************************************************************
function TiVCLComponent.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  Result := iMouseWheel(WheelDelta, Shift, MousePos);
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);    
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}                                                                   
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.iPaintToDC(X, Y: Integer; Transparent: Boolean; DC: HDC);
var
  OldCachedDrawing : Boolean;
  SaveIndex        : Integer;
  ARegion          : HRGN;        
begin
  SaveIndex := SaveDC(DC);
  try
    SetViewportOrgEx(DC, 0, 0, nil);
    SetWindowOrgEx  (DC, -X, -Y, nil);
    SetMapMode      (DC, MM_TEXT);

    ARegion := CreateRectRgn(X, Y, X + Width, Y + Height);
    try
      SelectClipRgn(DC, ARegion);

      FPaintDCTransparent := Transparent;
      try
      try
        Lock;
        try
          Canvas.Handle := DC;
          Canvas.Refresh;
          OldCachedDrawing := CachedDrawing;
          CachedDrawing := False;
          try
            iPaintTo(Canvas);
          finally
            CachedDrawing := OldCachedDrawing;
          end;
        finally
          Unlock;
        end;
      except
        on exception do;
      end;
      finally
        FPaintDCTransparent := False;
      end;
      SelectClipRgn(DC, 0);
    finally
      DeleteObject(ARegion);
    end;
  finally
    RestoreDC(DC, SaveIndex);
  end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.SaveImageToJPEG(FileName: String; Compression: Integer; Progressive: Boolean);
var
  JPEGImage : TJPEGImage;
  Bitmap    : TBitmap;
begin
  if (Compression < 1) or (Compression > 100) then raise Exception.Create('Compression must be in the range of 1-100');
  Bitmap := TBitmap.Create;
  Bitmap.Canvas.Lock;
  try
    Bitmap.Width  := Width;
    Bitmap.Height := Height;
    iPaintTo(Bitmap.Canvas);

    {$IFDEF EVAL}
    with Bitmap.Canvas do
      begin
        Brush.Color := clBlack;
        Font.Color  := clYellow;
        Font.Style  := [fsBold];
        TextOut(0,0, 'Iocomp Evaluation');
      end;
    {$ENDIF}

    if not Licensed then
      begin
        with Bitmap.Canvas do
          begin
            Brush.Color := clBlack;
            Font.Color  := clYellow;
            Font.Style  := [fsBold];
            Font.Size   := 10;
            TextOut(0,0, 'Iocomp Evaluation');
          end;
      end;

    JPEGImage := TJPEGImage.Create;
    try
      JPEGImage.Assign(Bitmap);
      JPEGImage.CompressionQuality  := Compression;
      JPEGImage.Performance         := jpBestQuality;
      JPEGImage.PixelFormat         := jf24Bit;
      JPEGImage.ProgressiveEncoding := Progressive;
      JPEGImage.JPEGNeeded;
      JPEGImage.Compress;
      JPEGImage.SaveToFile(FileName);
    finally
      JPEGImage.Free;
    end;
    Bitmap.Canvas.UnLock;
    TControlCanvas(Canvas).FreeHandle;
  finally
    Bitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.SaveImageToPNG(FileName: String; Compression: Integer);
var
  PNGObject : TPNGObject;
  Bitmap    : TBitmap;
begin
  if (Compression < 0) or (Compression > 9) then raise Exception.Create('Compression must be in the range of 0-9');
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width  := Width;
    Bitmap.Height := Height;
    iPaintTo(Bitmap.Canvas);

    {$IFDEF EVAL}
    with Bitmap.Canvas do
      begin
        Brush.Color := clBlack;
        Font.Color  := clYellow;
        Font.Style  := [fsBold];
        TextOut(0,0, 'Iocomp Evaluation');
      end;
    {$ENDIF}


    if not Licensed then
      begin
        with Bitmap.Canvas do
          begin
            Brush.Color := clBlack;
            Font.Color  := clYellow;
            Font.Style  := [fsBold];
            Font.Size   := 10;
            TextOut(0,0, 'Iocomp Evaluation');
          end;
      end;

    PNGObject := TPNGObject.Create;
    try
      PNGObject.Assign(Bitmap);
      PNGObject.CompressionLevel := Compression;
      PNGObject.SaveToFile(FileName);
    finally
      PNGObject.Free;
    end;
  finally
    Bitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
function TiVCLComponent.GetBytesJPEG(Compression: Integer; Progressive: Boolean): OleVariant;
var
  JPEGImage     : TJPEGImage;
  Bitmap        : TBitmap;
  MemoryStream  : TMemoryStream;
  P             : Pointer;
  AVariant      : OleVariant;
begin
  Lock;
  try
    if (Compression < 1) or (Compression > 100) then raise Exception.Create('Compression must be in the range of 1-100');
    Bitmap := TBitmap.Create;
    try
      Bitmap.Canvas.Lock;
      Bitmap.Canvas.Handle := CreateCompatibleDC(0);
      Bitmap.PixelFormat := pf24bit;
      Bitmap.Width  := Width;
      Bitmap.Height := Height;
      Bitmap.HandleType := bmDIB;
      iPaintTo(Bitmap.Canvas);

      {$IFDEF EVAL}
      with Bitmap.Canvas do
        begin
          Brush.Color := clBlack;
          Font.Color  := clYellow;
          Font.Style  := [fsBold];
          Font.Size   := 10;
          TextOut(0,0, 'Iocomp Evaluation');
        end;
      {$ENDIF}

      if not Licensed then
        begin
          with Bitmap.Canvas do
            begin
              Brush.Color := clBlack;
              Font.Color  := clYellow;
              Font.Style  := [fsBold];
              Font.Size   := 10;
              TextOut(0,0, 'Iocomp Evaluation');
            end;
        end;

      JPEGImage := TJPEGImage.Create;
      try
        JPEGImage.CompressionQuality  := Compression;
        JPEGImage.Performance         := jpBestSpeed;
        JPEGImage.PixelFormat         := jf24Bit;
        JPEGImage.ProgressiveEncoding := Progressive;
        JPEGImage.Assign(Bitmap);

        MemoryStream := TMemoryStream.Create;
        try
          JPEGImage.SaveToStream(MemoryStream);

          MemoryStream.Position := 0;

          AVariant := VarArrayCreate([0, MemoryStream.Size-1], varByte);
          P := VarArrayLock(AVariant);

          MemoryStream.ReadBuffer(P^, MemoryStream.Size);
          VarArrayUnlock(AVariant);
          Result := AVariant;
        finally
          MemoryStream.Free;
        end;
      finally
        JPEGImage.Free;
      end;
      Bitmap.Canvas.Unlock;
    finally
      Bitmap.Free;
    end;
  finally
    UnLock;
  end;
end;
//****************************************************************************************************************************************************
function TiVCLComponent.GetBytesPNG(Compression: Integer): OleVariant;
var
  PNGObject     : TPNGObject;
  Bitmap        : TBitmap;
  MemoryStream  : TMemoryStream;
  P             : Pointer;
  AVariant      : OleVariant;
begin
  Lock;
  try
    if (Compression < 0) or (Compression > 9) then raise Exception.Create('Compression must be in the range of 0-9');
    Bitmap := TBitmap.Create;
    try
      Bitmap.Canvas.Lock;
      Bitmap.Canvas.Handle := CreateCompatibleDC(0);
      Bitmap.PixelFormat   := pf24bit;
      Bitmap.Width         := Width;
      Bitmap.Height        := Height;
      Bitmap.HandleType    := bmDIB;
      iPaintTo(Bitmap.Canvas);

      {$IFDEF EVAL}
      with Bitmap.Canvas do
        begin
          Brush.Color := clBlack;
          Font.Color  := clYellow;
          Font.Style  := [fsBold];
          Font.Size   := 10;
          TextOut(0,0, 'Iocomp Evaluation');
        end;
      {$ENDIF}

      if not Licensed then
        begin
          with Bitmap.Canvas do
            begin
              Brush.Color := clBlack;
              Font.Color  := clYellow;
              Font.Style  := [fsBold];
              Font.Size   := 10;
              TextOut(0,0, 'Iocomp Evaluation');
            end;
        end;

      PNGObject := TPNGObject.Create;
      try
        PNGObject.Assign(Bitmap);
        PNGObject.CompressionLevel := Compression;

        MemoryStream := TMemoryStream.Create;
        try
          PNGObject.SaveToStream(MemoryStream);

          MemoryStream.Position := 0;

          AVariant := VarArrayCreate([0, MemoryStream.Size-1], varByte);
          P := VarArrayLock(AVariant);

          MemoryStream.ReadBuffer(P^, MemoryStream.Size);
          VarArrayUnlock(AVariant);
          Result := AVariant;
        finally
          MemoryStream.Free;
        end;
      finally
        PNGObject.Free;
      end;
      Bitmap.Canvas.Unlock;
    finally
      Bitmap.Free;
    end;
  finally
    UnLock;
  end;
end;
//****************************************************************************************************************************************************
function TiVCLComponent.GetJPEG(Compression: Integer; Progressive: Boolean): TJPEGImage;
var
  JPEGImage     : TJPEGImage;
  Bitmap        : TBitmap;
begin
  if (Compression < 1) or (Compression > 100) then raise Exception.Create('Compression must be in the range of 1-100');
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width  := Width;
    Bitmap.Height := Height;
    iPaintTo(Bitmap.Canvas);

    {$IFDEF EVAL}
    with Bitmap.Canvas do
      begin
        Brush.Color := clBlack;
        Font.Color  := clYellow;
        Font.Style  := [fsBold];
        TextOut(0,0, 'Iocomp Evaluation');
      end;
    {$ENDIF}

    if not Licensed then
      begin
        with Bitmap.Canvas do
          begin
            Brush.Color := clBlack;
            Font.Color  := clYellow;
            Font.Style  := [fsBold];
            Font.Size   := 10;
            TextOut(0,0, 'Iocomp Evaluation');
          end;
      end;

    JPEGImage := TJPEGImage.Create;

    JPEGImage.CompressionQuality  := Compression;
    JPEGImage.Performance         := jpBestQuality;
    JPEGImage.PixelFormat         := jf24Bit;
    JPEGImage.ProgressiveEncoding := Progressive;
    JPEGImage.Assign(Bitmap);
    JPEGImage.Compress;
    Result := JPEGImage;
  finally
    Bitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.GetThemePaths(var IocompPathName, UserPathName: String);
var
  Registry : TRegistry;
  AString  : String;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    Registry.OpenKey('SOFTWARE\Iocomp\Themes',False);
    IocompPathName := Trim(Registry.ReadString('Iocomp Defined Theme Path'));
    UserPathName   := Trim(Registry.ReadString('User Defined Theme Path'  ));

    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.OpenKey('SOFTWARE\Iocomp\Themes',False);

    AString := '';
    AString := Trim(Registry.ReadString('Iocomp Defined Theme Path'));
    if AString <> '' then IocompPathName := AString;

    AString := '';
    AString := Trim(Registry.ReadString('User Defined Theme Path'));
    if AString <> '' then UserPathName   := AString;

    if Length(IocompPathName) <> 0 then if Copy(IocompPathName, Length(IocompPathName), 1) <> '\' then IocompPathName := IocompPathName + '\';
    if Length(UserPathName  ) <> 0 then if Copy(UserPathName,   Length(UserPathName),   1) <> '\' then UserPathName   := UserPathName   + '\';
  finally
    Registry.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.ClearAllSchemes;
var
  AStringList : TStringList;
begin
  while FThemeCategoryList.Count <>  0 do
    begin
      AStringList := FThemeCategoryList.Objects[0] as TStringList;
      while AStringList.Count <> 0 do
        begin
          AStringList.Objects[0].Free;
          AStringList.Delete(0);
        end;
      FThemeCategoryList.Objects[0].Free;
      FThemeCategoryList.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
function TiVCLComponent.GetThemeCategoryListByName(Name: String): TStringList;
var
  Index : Integer;
begin
  Index := FThemeCategoryList.IndexOf(Name);
  if Index <> -1 then
    begin
      Result := FThemeCategoryList.Objects[Index] as TStringList;
    end
  else
    begin
      Result := TStringList.Create;
      FThemeCategoryList.AddObject(Name, Result);
    end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.LoadAllThemes(FileStream: TiXMLMemoryStream; SchemeListClass: TiSchemeListClass);
var
  AString        : String;
  SchemeTypeList : TStringList;
  SchemeList     : TStringList;
  ElementName    : String;
  ElementValue   : String;
begin
  with FileStream do
    begin
      GotoElementStart('SchemeTypes');
      while PeekNextPiece = 'SchemeType' do
        begin
          GotoElementStart('SchemeType');
          AString := GetElement('Name');
          SchemeTypeList := GetThemeCategoryListByName(AString);

          while PeekNextPiece = 'Scheme' do
            begin
              GotoElementStart('Scheme');
              AString := GetElement('Name');

              SchemeList := SchemeListClass.Create;
              SchemeTypeList.AddObject(AString, SchemeList);

              GotoElementStart('Properties');
              while PeekNextPiece <> '/Properties' do
                begin
                  ElementName  := '';
                  ElementValue := '';
                  ElementName  := PeekNextPiece;
                  ElementValue := GetElement(ElementName);
                  if ElementName <> '' then SchemeList.Add(ElementName + ' = ' + ElementValue);
                end;
              if GetNextPiece <> '/Properties' then raise Exception.Create('Error Loading Scheme. XML File Malformed');
              if GetNextPiece <> '/Scheme'     then raise Exception.Create('Error Loading Scheme. XML File Malformed');
            end;

          if GetNextPiece <> '/SchemeType'     then raise Exception.Create('Error Loading Scheme. XML File Malformed');
        end;
      if GetNextPiece <> '/SchemeTypes'        then raise Exception.Create('Error Loading Scheme. XML File Malformed');
    end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.LoadThemes;
var
  FileStream     : TiXMLMemoryStream;
  IocompPathName : String;
  UserPathName   : String;
  FileName       : String;
begin
  ClearAllSchemes;
  GetThemePaths(IocompPathName, UserPathName);

  FileName := IocompPathName + ClassName + '.xml';
  if FileExists(FileName) then
    begin
      FileStream := TiXMLMemoryStream.Create;
      FileStream.LoadFromFile(FileName);
      try
        LoadAllThemes(FileStream, TiIocompSchemeList);
      finally
        FileStream.Free;
      end;
    end;

  FileName := UserPathName + ClassName + 'User.xml';
  if FileExists(FileName) then
    begin
      FileStream := TiXMLMemoryStream.Create;
      FileStream.LoadFromFile(FileName);
      try
        LoadAllThemes(FileStream, TiUserSchemeList);
      finally
        FileStream.Free;
      end;
    end;
end;
//****************************************************************************************************************************************************
function TiVCLComponent.GetThemeCategoryCount: Integer;
begin
  Result := FThemeCategoryList.Count;
end;
//****************************************************************************************************************************************************
function TiVCLComponent.GetThemeCategoryName(CategoryIndex: Integer): String;
begin
  Result := FThemeCategoryList.Strings[CategoryIndex];
end;
//****************************************************************************************************************************************************
function TiVCLComponent.GetThemeCategorySchemeCount(CategoryIndex: Integer): Integer;
begin
  Result := (FThemeCategoryList.Objects[CategoryIndex] as TStringList).Count;
end;
//****************************************************************************************************************************************************
function TiVCLComponent.GetThemeCategorySchemeName(CategoryIndex, SchemeIndex: Integer): String;
begin
  Result := (FThemeCategoryList.Objects[CategoryIndex] as TStringList).Strings[SchemeIndex];
end;
//****************************************************************************************************************************************************
function TiVCLComponent.GetThemeCategorySchemeIsUser(CategoryIndex, SchemeIndex: Integer): Boolean;
begin
  Result := (FThemeCategoryList.Objects[CategoryIndex] as TStringList).Objects[SchemeIndex] is TiUserSchemeList;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.SeparateNameValue(AText: String; var Name: String; var Value: String);
var
  EqualPosition: Integer;
begin
  EqualPosition := AnsiPos('=', AText);
  if (EqualPosition <> 0) then
    begin
      Name  := Trim(Copy(AText, 1, EqualPosition - 1));
      Value := Copy(AText, EqualPosition + 2, Length(AText) - EqualPosition);
    end
  else
    begin
      Name  := '';
      Value := '';
    end;
end;
//****************************************************************************************************************************************************
procedure TiVCLComponent.ApplyScheme(CategoryIndex, SchemeIndex: Integer);
var
  x                   : Integer;
  AString             : String;
  AScheme             : TStringList;
  PropertyNameString  : String;
  PropertyValueString : String;
begin
  AScheme := (FThemeCategoryList.Objects[CategoryIndex] as TStringList).Objects[SchemeIndex] as TStringList;
  for x := 0 to AScheme.Count - 1 do
    begin
      AString := AScheme.Strings[x];
      SeparateNameValue(AString, PropertyNameString, PropertyValueString);
      if (PropertyNameString <> '') then OPCSetProperty(Self, '', PropertyNameString, PropertyValueString);
    end;
end;
//****************************************************************************************************************************************************
end.





