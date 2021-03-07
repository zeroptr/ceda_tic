{*******************************************************}
{                                                       }
{       TiComponentEditorThemePanel Component           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iComponentEditorThemePanel;{$endif}
{$ifdef iCLX}unit QiComponentEditorThemePanel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF MSWINDOWS}Registry,{$ENDIF}
  {$IFDEF LINUX}    IniFiles,{$ENDIF}
  {$IFDEF iVCL}  iTypes, iGPFunctions,   iClasses,  iEditorBasicComponents;{$ENDIF}
  {$IFDEF iCLX} QiTypes, QiGPFunctions, QiClasses, QiEditorBasicComponents;{$ENDIF}

const
  UserFileSuffix               = 'User.xml';
  IocompFileSuffix             = '.xml';
  DeleteSchemeMessage          = 'Are you sure you want to permanentely delete this scheme entry?';
  XMLFileExceptionMessage      = 'Error Loading Scheme. XML File Malformed';
  UserThemeOpenErrorMessage    = 'Error Reading User-Defined Theme Settings';
  IocompThemeOpenErrorMessage  = 'Error Reading Pre-Defined Theme Settings';
  IocompThemeSaveErrorMessage  = 'Error Saving User-Defined Theme Settings';
  NoNameEnteredErrorMessage    = 'No name was entered. Aborting Save.';
  CleanSchemesMessage          = 'Are you sure you want to clean this scheme of missing/erroneous properties?';
  CleanAllSchemesMessage       = 'Are you sure you want to clean ALL SCHEMES of missing/erroneous properties?';
  AcceptChangesNotAssignedEM   = 'OnAcceptChanges event not assigned.  Scheme clean aborted.';
  
  SchemeComboWidth            = 184;
  ButtonOffset                = 3;
  SchemeOffset                = 39;
  SquareOffset                = 2;
  SquareSize                  = 10;
type

  TiThemeComboBox = class(TComboBox)
  protected
    procedure Change; override;
    {$IFDEF COMPILER_6_UP}procedure CloseUp; override;{$ENDIF}
   {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;         {$endif}
  end;

  TiComponentEditorThemePanel = class(TCustomControl)
  private
    FCreationComplete     : Boolean;
    FAcceptPreviewButton  : TiComponentEditorButton;
    FPreviewErrorLabel1   : TLabel;
    FPreviewErrorLabel2   : TLabel;
    FScheme1Combo         : TiThemeComboBox;
    FScheme2Combo         : TiThemeComboBox;
    FScheme3Combo         : TiThemeComboBox;
    FScheme4Combo         : TiThemeComboBox;
    FScheme5Combo         : TiThemeComboBox;
    FScheme1ComboLabel    : TLabel;
    FScheme2ComboLabel    : TLabel;
    FScheme3ComboLabel    : TLabel;
    FScheme4ComboLabel    : TLabel;
    FScheme5ComboLabel    : TLabel;
    FScheme1AddButton     : TiComponentEditorButton;
    FScheme2AddButton     : TiComponentEditorButton;
    FScheme3AddButton     : TiComponentEditorButton;
    FScheme4AddButton     : TiComponentEditorButton;
    FScheme5AddButton     : TiComponentEditorButton;
    FScheme1DeleteButton  : TiComponentEditorButton;
    FScheme2DeleteButton  : TiComponentEditorButton;
    FScheme3DeleteButton  : TiComponentEditorButton;
    FScheme4DeleteButton  : TiComponentEditorButton;
    FScheme5DeleteButton  : TiComponentEditorButton;

    FPreviewGroupBox      : TiComponentEditorGroupBox;
    FPreviewScrollBox     : TScrollBox;

    FSchemeFound          : Boolean;

    FLegendLabel          : TLabel;
    FPreDefinedLabel      : TLabel;
    FUserDefinedLabel     : TLabel;
    FPreDefinedShape      : TShape;
    FUserDefinedShape     : TShape;

    FScheme1PropertyNames : TStringList;
    FScheme2PropertyNames : TStringList;  
    FScheme3PropertyNames : TStringList;  
    FScheme4PropertyNames : TStringList;
    FScheme5PropertyNames : TStringList;

    FScheme1TypeList      : TStringList;
    FScheme2TypeList      : TStringList;
    FScheme3TypeList      : TStringList;
    FScheme4TypeList      : TStringList;
    FScheme5TypeList      : TStringList;

    FiComponentPreview    : TWinControl;

    FScheme1EnableModify  : Boolean;
    FScheme2EnableModify  : Boolean;
    FScheme3EnableModify  : Boolean;
    FScheme4EnableModify  : Boolean;
    FScheme5EnableModify  : Boolean;
    FScheme1IsOverall     : Boolean;
    FScheme2IsOverall     : Boolean;
    FScheme3IsOverall     : Boolean;
    FScheme4IsOverall     : Boolean;
    FScheme5IsOverall     : Boolean;
    FScheme1Show          : Boolean;
    FScheme2Show          : Boolean;
    FScheme3Show          : Boolean;
    FScheme4Show          : Boolean;
    FScheme5Show          : Boolean;
    FScheme1Title         : String;
    FScheme2Title         : String;
    FScheme3Title         : String;
    FScheme4Title         : String;
    FScheme5Title         : String;

    FSchemeCount          : Integer;

    FAutoAcceptPreview        : Boolean;
    FOnAcceptChanges          : TNotifyEvent;
    FAutoCenterLargeComponent : Boolean;

    procedure ClearAllSchemes;
    procedure SetiComponentPreview    (const Value: TWinControl);

    procedure SetScheme1PropertyNames (const Value: TStringList);
    procedure SetScheme2PropertyNames (const Value: TStringList);
    procedure SetScheme3PropertyNames (const Value: TStringList);
    procedure SetScheme4PropertyNames (const Value: TStringList);
    procedure SetScheme5PropertyNames (const Value: TStringList);

    procedure SetScheme1Show          (const Value: Boolean);
    procedure SetScheme2Show          (const Value: Boolean);
    procedure SetScheme3Show          (const Value: Boolean);
    procedure SetScheme4Show          (const Value: Boolean);
    procedure SetScheme5Show          (const Value: Boolean);

    procedure SetScheme1Title         (const Value: String);
    procedure SetScheme2Title         (const Value: String);
    procedure SetScheme3Title         (const Value: String);
    procedure SetScheme4Title         (const Value: String);
    procedure SetScheme5Title         (const Value: String);

    procedure Scheme1ComboChange      (Sender: TObject);
    procedure Scheme2ComboChange      (Sender: TObject);
    procedure Scheme3ComboChange      (Sender: TObject);
    procedure Scheme4ComboChange      (Sender: TObject);
    procedure Scheme5ComboChange      (Sender: TObject);

    procedure Scheme1ComboDropDown    (Sender: TObject);
    procedure Scheme2ComboDropDown    (Sender: TObject);
    procedure Scheme3ComboDropDown    (Sender: TObject);
    procedure Scheme4ComboDropDown    (Sender: TObject);
    procedure Scheme5ComboDropDown    (Sender: TObject);

    procedure SetScheme1EnableModify  (const Value: Boolean);
    procedure SetScheme2EnableModify  (const Value: Boolean);
    procedure SetScheme3EnableModify  (const Value: Boolean);
    procedure SetScheme4EnableModify  (const Value: Boolean);
    procedure SetScheme5EnableModify  (const Value: Boolean);

    procedure Scheme1AddButtonClick (Sender: TObject);
    procedure Scheme2AddButtonClick (Sender: TObject);
    procedure Scheme3AddButtonClick (Sender: TObject);
    procedure Scheme4AddButtonClick (Sender: TObject);
    procedure Scheme5AddButtonClick (Sender: TObject);

    procedure Scheme1DeleteButtonClick(Sender: TObject);
    procedure Scheme2DeleteButtonClick(Sender: TObject);
    procedure Scheme3DeleteButtonClick(Sender: TObject);
    procedure Scheme4DeleteButtonClick(Sender: TObject);
    procedure Scheme5DeleteButtonClick(Sender: TObject);

    procedure AcceptPreviewButtonClick(Sender: TObject);

    procedure LoadFromXMLFile;
    function  SaveToXMLFile: Boolean;
    procedure ClearSelectedSchemes;

    procedure SchemeComboChange          (SchemeCombo: TComboBox; IsOverall: Boolean; SchemeDeleteButton: TiComponentEditorButton);
    procedure SchemeAdd                  (SchemeCombo: TComboBox; SchemeTypeTitle: String; SchemeTypeList, SchemePropertyNames: TStringList);
    procedure CreateNewScheme            (SchemeName: String; SchemeList: TStringList; PropertyNameList: TStringList);
    procedure SeparateNameValue          (AText: String; var Name, Value: String);
    function  CombineNameValue           (Name, Value: String): String;
    function  GetSchemeTypeListByName    (Name: String): TStringList;
    function  UserSchemeNameExist        (Name: String; SchemeTypeList: TStringList): Integer;

    procedure LoadSchemes                (FileStream: TiXMLMemoryStream; SchemeListClass: TiSchemeListClass);
    procedure SaveSchemeType             (Stream: TiXMLMemoryStream; SchemeTypeList: TStringList; SchemeTitle: String);
    procedure GetThemePaths              (var IocompPathName, UserPathName: String);

    procedure TransferSchemeData         (TypeList: TStringList);
    procedure SetProperty                (Instance: TPersistent; PropertyNameString, PropertyValueString: String);
    function  GetProperty                (Instance: TPersistent; PropertyNameString: String): String;
    function  GetPropertyInfo            (var Instance: TPersistent; PropertyNameString: String): PPropInfo;

    {$IFDEF iVCL}procedure ComboBoxDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState                      );{$ENDIF}
    {$IFDEF iCLX}procedure ComboBoxDrawItem(Control: TObject;     Index: Integer; Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);{$ENDIF}

    procedure SetAutoAcceptPreview       (const Value: Boolean);
    procedure OpenMaintenance(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CleanScheme    (SchemeTypeList, SchemePropertyNames: TStringList; NoConfirmation: Boolean);
  protected
    procedure DoResize;
    procedure ScrollBoxResize(Sender: TObject);
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override; {$endif}
    procedure Loaded;                       override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    procedure   ResetThemePanel;
    procedure   ReCenterPreview;
    property    iComponentPreview : TWinControl  read FiComponentPreview    write SetiComponentPreview;
    property    OnAcceptChanges   : TNotifyEvent read FOnAcceptChanges      write FOnAcceptChanges;
    procedure   CleanAllSchemes();
    function    GetSchemeList  (Index: Integer) : TStringList;
    function    GetSchemeName  (Index: Integer) : String;
  published
    property Scheme1EnableModify      : Boolean      read FScheme1EnableModify      write SetScheme1EnableModify;
    property Scheme2EnableModify      : Boolean      read FScheme2EnableModify      write SetScheme2EnableModify;
    property Scheme3EnableModify      : Boolean      read FScheme3EnableModify      write SetScheme3EnableModify;
    property Scheme4EnableModify      : Boolean      read FScheme4EnableModify      write SetScheme4EnableModify;
    property Scheme5EnableModify      : Boolean      read FScheme5EnableModify      write SetScheme5EnableModify;
    property Scheme1IsOverall         : Boolean      read FScheme1IsOverall         write FScheme1IsOverall;
    property Scheme2IsOverall         : Boolean      read FScheme2IsOverall         write FScheme2IsOverall;
    property Scheme3IsOverall         : Boolean      read FScheme3IsOverall         write FScheme3IsOverall;
    property Scheme4IsOverall         : Boolean      read FScheme4IsOverall         write FScheme4IsOverall;
    property Scheme5IsOverall         : Boolean      read FScheme5IsOverall         write FScheme5IsOverall;
    property Scheme1PropertyNames     : TStringList  read FScheme1PropertyNames     write SetScheme1PropertyNames;
    property Scheme2PropertyNames     : TStringList  read FScheme2PropertyNames     write SetScheme2PropertyNames;
    property Scheme3PropertyNames     : TStringList  read FScheme3PropertyNames     write SetScheme3PropertyNames;
    property Scheme4PropertyNames     : TStringList  read FScheme4PropertyNames     write SetScheme4PropertyNames;
    property Scheme5PropertyNames     : TStringList  read FScheme5PropertyNames     write SetScheme5PropertyNames;
    property Scheme1Show              : Boolean      read FScheme1Show              write SetScheme1Show;
    property Scheme2Show              : Boolean      read FScheme2Show              write SetScheme2Show;
    property Scheme3Show              : Boolean      read FScheme3Show              write SetScheme3Show;
    property Scheme4Show              : Boolean      read FScheme4Show              write SetScheme4Show;
    property Scheme5Show              : Boolean      read FScheme5Show              write SetScheme5Show;
    property Scheme1Title             : String       read FScheme1Title             write SetScheme1Title;
    property Scheme2Title             : String       read FScheme2Title             write SetScheme2Title;
    property Scheme3Title             : String       read FScheme3Title             write SetScheme3Title;
    property Scheme4Title             : String       read FScheme4Title             write SetScheme4Title;
    property Scheme5Title             : String       read FScheme5Title             write SetScheme5Title;
    property AutoAcceptPreview        : Boolean      read FAutoAcceptPreview        write SetAutoAcceptPreview;
    property SchemeCount              : Integer      read FSchemeCount              write FSchemeCount;
    property Align default alClient;
  end;

implementation
{$IFDEF iVCL}uses  iComponentEditorThemePanelAddDialog, iComponentEditorThemePanelMaintenance;{$ENDIF}
{$IFDEF iCLX}uses QiComponentEditorThemePanelAddDialog, QiComponentEditorThemePanelMaintenance;{$ENDIF}
//****************************************************************************************************************************************************
constructor TiComponentEditorThemePanel.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csReplicatable, csOpaque];
  FSchemeCount := 5;

  Width      := 500;
  Height     := 250;
  Align      := alClient;
  {$IFDEF iVCL}
  Ctl3D      := True;
  {$ENDIF}


  FScheme1Title := 'Preset Scheme';
  FScheme2Title := 'Color Scheme';
  FScheme3Title := 'Scheme3';
  FScheme4Title := 'Scheme4';
  FScheme5Title := 'Scheme5';

  FScheme1Show := True;
  FScheme2Show := True;
  FScheme3Show := False;
  FScheme4Show := False;
  FScheme5Show := False;

  FScheme1EnableModify := True;
  FScheme2EnableModify := True;
  FScheme3EnableModify := True;
  FScheme4EnableModify := True;
  FScheme5EnableModify := True;

  FScheme1IsOverall := True;
  FScheme2IsOverall := False;
  FScheme3IsOverall := False;
  FScheme4IsOverall := False;
  FScheme5IsOverall := False;

  FAutoAcceptPreview        := False;
  FAutoCenterLargeComponent := False;

  FScheme1PropertyNames := TStringList.Create;
  FScheme2PropertyNames := TStringList.Create;
  FScheme3PropertyNames := TStringList.Create;
  FScheme4PropertyNames := TStringList.Create;
  FScheme5PropertyNames := TStringList.Create;

  FScheme1TypeList := TStringList.Create;
  FScheme2TypeList := TStringList.Create;
  FScheme3TypeList := TStringList.Create;
  FScheme4TypeList := TStringList.Create;
  FScheme5TypeList := TStringList.Create;

  //==============================================
  //Preview
  //==============================================
  FPreviewGroupBox := TiComponentEditorGroupBox.Create(Self);
  with FPreviewGroupBox do
    begin
      Parent  := Self;
      Caption := 'Preview';
      OnMouseUp := OpenMaintenance;
    end;
  FPreviewScrollBox := TScrollBox.Create(Self);
  with FPreviewScrollBox do
    begin
      Parent      := FPreviewGroupBox;
      BorderStyle := bsNone;
      Left        := 5;
      Top         := 5;
      OnResize    := ScrollBoxResize;
    end;

  FPreviewErrorLabel1 := TLabel.Create(Self);
  with FPreviewErrorLabel1 do
    begin
      Parent     := FPreviewScrollBox;
      Caption    := 'Themes Not Installed.';
      Alignment  := taCenter;
      Font.Style := [fsBold];
    end;
  FPreviewErrorLabel2 := TLabel.Create(Self);
  with FPreviewErrorLabel2 do
    begin
      Parent     := FPreviewScrollBox;
      Caption    := 'Themes are Disabled.';
      Alignment  := taCenter;
      Font.Style := [fsBold];
    end;

  //==============================================
  //Legend & Accept Preview Button
  //==============================================
  FLegendLabel := TLabel.Create(Self);
  with FLegendLabel do
    begin
      Parent     := Self;
      AutoSize   := True;
      Caption    := 'Legend';
      Font.Style := [fsUnderline];
    end;
  FPreDefinedShape := TShape.Create(Self);
  With FPreDefinedShape do
    begin
      Parent      := Self;
      Brush.Color := clRed;
      Pen.Color   := clBlack;
    end;
  FUserDefinedShape := TShape.Create(Self);
  With FUserDefinedShape do
    begin
      Parent      := Self;
      Brush.Color := clBlue;
      Pen.Color   := clBlack;
    end;
  FPreDefinedLabel := TLabel.Create(Self);
  with FPreDefinedLabel do
    begin
      Parent   := Self;
      AutoSize := True;
      Caption  := 'Pre-Defined (Fixed)';
    end;
  FUserDefinedLabel := TLabel.Create(Self);
  with FUserDefinedLabel do
    begin
      Parent   := Self;
      AutoSize := True;
      Caption  := 'User Defined';
    end;
  FAcceptPreviewButton := TiComponentEditorButton.Create(Self);
  with FAcceptPreviewButton do
    begin
      Parent  := Self;
      Caption := '&Accept Preview';
      Width   := 99;
      OnClick := AcceptPreviewButtonClick;
      Enabled := False;
    end;

  //==============================================
  //Scheme 1
  //==============================================
  FScheme1Combo := TiThemeComboBox.Create(Self);
  with FScheme1Combo do
    begin
      Parent     := Self;
      Width      := SchemeComboWidth;
      {$ifdef iCLX}Height     := 21;{$endif}
      Style      := csOwnerDrawFixed;
      OnChange   := Scheme1ComboChange;
      OnDropDown := Scheme1ComboDropDown;
      OnDrawItem := ComboBoxDrawItem;
      DropDownCount := 12;
      //Under CLX, ComboBox won't work without adding dummy item
      {$ifdef iCLX}Items.Add('');{$endif}
    end;
  FScheme1ComboLabel := TLabel.Create(Self);
  with FScheme1ComboLabel do
    begin
      Parent   := Self;
      AutoSize := True;
      Caption  := FScheme1Title + ':';
    end;
  FScheme1AddButton := TiComponentEditorButton.Create(Self);
  with FScheme1AddButton do
    begin
      Parent     := Self;
      Caption    := '+';
      Font.Size  := 12;
      Font.Style := [fsBold];
      Height     := 19;
      Width      := 21;
      OnClick    := Scheme1AddButtonClick;
    end;
  FScheme1DeleteButton := TiComponentEditorButton.Create(Self);              
  with FScheme1DeleteButton do
    begin
      Parent     := Self;
      Caption    := '-';
      Font.Size  := 12;
      Font.Style := [fsBold];
      Height     := 19;
      Width      := 21;
      OnClick    := Scheme1DeleteButtonClick;
      Enabled    := False;
    end;

  //==============================================
  //Scheme 2
  //==============================================
  FScheme2Combo := TiThemeComboBox.Create(Self);
  with FScheme2Combo do
    begin
      Parent     := Self;
      Width      := FScheme1Combo.Width;
      {$ifdef iCLX}Height     := 21;{$endif}
      Style      := csOwnerDrawFixed;
      OnChange   := Scheme2ComboChange;
      OnDropDown := Scheme2ComboDropDown;
      OnDrawItem := ComboBoxDrawItem;
      DropDownCount := 12;
      //Under CLX, ComboBox won't work without adding dummy item
      {$ifdef iCLX}Items.Add('');{$endif}
    end;
  FScheme2ComboLabel := TLabel.Create(Self);
  with FScheme2ComboLabel do
    begin
      Parent   := Self;
      AutoSize := True;
      Caption  := FScheme2Title + ':';
    end;
  FScheme2AddButton := TiComponentEditorButton.Create(Self);
  with FScheme2AddButton do
    begin
      Parent     := Self;
      Caption    := '+';
      Font.Size  := 12;
      Font.Style := [fsBold];
      Height     := FScheme1AddButton.Height;
      Width      := FScheme1AddButton.Width;
      OnClick    := Scheme2AddButtonClick;
    end;
  FScheme2DeleteButton := TiComponentEditorButton.Create(Self);
  with FScheme2DeleteButton do
    begin
      Parent     := Self;
      Caption    := '-';
      Font.Size  := 12;
      Font.Style := [fsBold];
      Height     := FScheme1DeleteButton.Height;
      Width      := FScheme1DeleteButton.Width;
      Enabled    := False;
      OnClick    := Scheme2DeleteButtonClick;
    end;

  //==============================================
  //Scheme 3
  //==============================================
  FScheme3Combo := TiThemeComboBox.Create(Self);
  with FScheme3Combo do
    begin
      Parent     := Self;
      Width      := FScheme1Combo.Width;
      {$ifdef iCLX}Height     := 21;{$endif}
      Style      := csOwnerDrawFixed;
      OnChange   := Scheme3ComboChange;
      OnDropDown := Scheme3ComboDropDown;
      OnDrawItem := ComboBoxDrawItem;
      DropDownCount := 12;
      //Under CLX, ComboBox won't work without adding dummy item
      {$ifdef iCLX}Items.Add('');{$endif}
    end;
  FScheme3ComboLabel := TLabel.Create(Self);
  with FScheme3ComboLabel do
    begin
      Parent   := Self;
      AutoSize := True;
      Caption  := FScheme3Title + ':';
    end;
  FScheme3AddButton := TiComponentEditorButton.Create(Self);
  with FScheme3AddButton do
    begin
      Parent     := Self;
      Caption    := '+';
      Font.Size  := 12;
      Font.Style := [fsBold];
      Height     := FScheme1AddButton.Height;
      Width      := FScheme1AddButton.Width;
      OnClick    := Scheme3AddButtonClick;
    end;
  FScheme3DeleteButton := TiComponentEditorButton.Create(Self);
  with FScheme3DeleteButton do
    begin
      Parent     := Self;
      Caption    := '-';
      Font.Size  := 12;
      Font.Style := [fsBold];
      Height     := FScheme1DeleteButton.Height;
      Width      := FScheme1DeleteButton.Width;
      Enabled    := False;
      OnClick    := Scheme3DeleteButtonClick;
    end;

  //==============================================
  //Scheme 4
  //==============================================
  FScheme4Combo := TiThemeComboBox.Create(Self);
  with FScheme4Combo do
    begin
      Parent     := Self;
      Width      := FScheme1Combo.Width;
      {$ifdef iCLX}Height     := 21;{$endif}
      Style      := csOwnerDrawFixed;
      OnChange   := Scheme4ComboChange;
      OnDropDown := Scheme4ComboDropDown;
      OnDrawItem := ComboBoxDrawItem;
      DropDownCount := 12;
      //Under CLX, ComboBox won't work without adding dummy item
      {$ifdef iCLX}Items.Add('');{$endif}
    end;
  FScheme4ComboLabel := TLabel.Create(Self);
  with FScheme4ComboLabel do
    begin
      Parent   := Self;
      AutoSize := True;
      Caption  := FScheme4Title + ':';
    end;
  FScheme4AddButton := TiComponentEditorButton.Create(Self);
  with FScheme4AddButton do
    begin
      Parent     := Self;
      Caption    := '+';
      Font.Size  := 12;
      Font.Style := [fsBold];
      Height     := FScheme1AddButton.Height;
      Width      := FScheme1AddButton.Width;
      OnClick    := Scheme4AddButtonClick;
    end;
  FScheme4DeleteButton := TiComponentEditorButton.Create(Self);
  with FScheme4DeleteButton do
    begin
      Parent     := Self;
      Caption    := '-';
      Font.Size  := 12;
      Font.Style := [fsBold];
      Height     := FScheme1DeleteButton.Height;
      Width      := FScheme1DeleteButton.Width;
      OnClick    := Scheme4DeleteButtonClick;
      Enabled    := False;
    end;

  //==============================================
  //Scheme 5
  //==============================================
  FScheme5Combo := TiThemeComboBox.Create(Self);
  with FScheme5Combo do
    begin
      Parent     := Self;
      Width      := FScheme1Combo.Width;
      {$ifdef iCLX}Height     := 21;{$endif}
      Style      := csOwnerDrawFixed;
      OnChange   := Scheme5ComboChange;
      OnDropDown := Scheme5ComboDropDown;
      OnDrawItem := ComboBoxDrawItem;
      DropDownCount := 12;
      //Under CLX, ComboBox won't work without adding dummy item
      {$ifdef iCLX}Items.Add('');{$endif}
    end;
  FScheme5ComboLabel := TLabel.Create(Self);
  with FScheme5ComboLabel do
    begin
      Parent   := Self;
      AutoSize := True;
      Caption  := FScheme5Title + ':';
    end;
  FScheme5AddButton := TiComponentEditorButton.Create(Self);
  with FScheme5AddButton do
    begin
      Parent     := Self;
      Font.Size  := 12;
      Caption    := '+';
      Font.Style := [fsBold];
      Height     := FScheme1AddButton.Height;
      Width      := FScheme1AddButton.Width;
      OnClick    := Scheme5AddButtonClick;
    end;
  FScheme5DeleteButton := TiComponentEditorButton.Create(Self);
  with FScheme5DeleteButton do
    begin
      Parent     := Self;
      Caption    := '-';
      Font.Size  := 12;
      Font.Style := [fsBold];
      Height     := FScheme1DeleteButton.Height;
      Width      := FScheme1DeleteButton.Width;
      Enabled    := False;
      OnClick    := Scheme5DeleteButtonClick;
    end;
  FCreationComplete := True;

  DoResize;
end;
//****************************************************************************************************************************************************
destructor TiComponentEditorThemePanel.Destroy;
begin
  inherited;

  FScheme1PropertyNames.Free;
  FScheme2PropertyNames.Free;
  FScheme3PropertyNames.Free;
  FScheme4PropertyNames.Free;
  FScheme5PropertyNames.Free;

  ClearAllSchemes;

  FScheme1TypeList.Free;
  FScheme2TypeList.Free;
  FScheme3TypeList.Free;
  FScheme4TypeList.Free;
  FScheme5TypeList.Free;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.Loaded;
begin
  inherited;
  DoResize;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetiComponentPreview(const Value: TWinControl);
begin
  FiComponentPreview       := Value;
  if not Assigned(FiComponentPreview.Parent) then
    begin
      FiComponentPreview.Parent  := FPreviewScrollBox;
    end;
  ResetThemePanel;
  LoadFromXMLFile;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.ResetThemePanel;
begin
  ClearSelectedSchemes;
  FAcceptPreviewButton.Enabled := False;
  ReCenterPreview;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.ScrollBoxResize(Sender: TObject);
begin
  ReCenterPreview;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.ReCenterPreview;
begin
  if Assigned(iComponentPreview) then
    begin
      if FiComponentPreview.Width > FPreviewScrollBox.Width then
        FiComponentPreview.Left := 0
      else
        FiComponentPreview.Left := FPreviewScrollBox.Width  div 2 - FiComponentPreview.Width  div 2;

      if FiComponentPreview.Height > FPreviewScrollBox.Height then
        FiComponentPreview.Top  := 0
      else
        FiComponentPreview.Top  := FPreviewScrollBox.Height div 2 - FiComponentPreview.Height div 2;
     end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.DoResize;
begin
  if not FCreationComplete then Exit;

  FScheme1Combo.Top := FScheme1ComboLabel.Height + 3;
  FScheme2Combo.Top := FScheme1Combo.Top + FScheme1Combo.Height + FScheme1ComboLabel.Height + 1;
  FScheme3Combo.Top := FScheme2Combo.Top + FScheme2Combo.Height + FScheme1ComboLabel.Height + 1;
  FScheme4Combo.Top := FScheme3Combo.Top + FScheme3Combo.Height + FScheme1ComboLabel.Height + 1;
  FScheme5Combo.Top := FScheme4Combo.Top + FScheme4Combo.Height + FScheme1ComboLabel.Height + 1;

  FScheme1AddButton.Top := FScheme1Combo.Top + (FScheme1Combo.Height div 2) - (FScheme1AddButton.Height div 2);
  FScheme2AddButton.Top := FScheme2Combo.Top + (FScheme2Combo.Height div 2) - (FScheme2AddButton.Height div 2);
  FScheme3AddButton.Top := FScheme3Combo.Top + (FScheme3Combo.Height div 2) - (FScheme3AddButton.Height div 2);
  FScheme4AddButton.Top := FScheme4Combo.Top + (FScheme4Combo.Height div 2) - (FScheme4AddButton.Height div 2);
  FScheme5AddButton.Top := FScheme5Combo.Top + (FScheme5Combo.Height div 2) - (FScheme5AddButton.Height div 2);

  FScheme1DeleteButton.Top := FScheme1AddButton.Top;
  FScheme2DeleteButton.Top := FScheme2AddButton.Top;
  FScheme3DeleteButton.Top := FScheme3AddButton.Top;
  FScheme4DeleteButton.Top := FScheme4AddButton.Top;
  FScheme5DeleteButton.Top := FScheme5AddButton.Top;

  FScheme1ComboLabel.Top := FScheme1Combo.Top - FScheme1ComboLabel.Height;
  FScheme2ComboLabel.Top := FScheme2Combo.Top - FScheme1ComboLabel.Height;
  FScheme3ComboLabel.Top := FScheme3Combo.Top - FScheme1ComboLabel.Height;
  FScheme4ComboLabel.Top := FScheme4Combo.Top - FScheme1ComboLabel.Height;
  FScheme5ComboLabel.Top := FScheme5Combo.Top - FScheme1ComboLabel.Height;
  //-------------------------------------------------------------------------------------------------------------
  FScheme1DeleteButton.Left := Width - ButtonOffset - FScheme1DeleteButton.Width;
  FScheme1AddButton.Left    := FScheme1DeleteButton.Left - FScheme1AddButton.Width;
  FScheme1Combo.Left        := FScheme1AddButton.Left - ButtonOffset - FScheme1Combo.Width;

  FScheme2Combo.Left        := FScheme1Combo.Left;
  FScheme3Combo.Left        := FScheme1Combo.Left;
  FScheme4Combo.Left        := FScheme1Combo.Left;
  FScheme5Combo.Left        := FScheme1Combo.Left;

  FScheme2AddButton.Left    := FScheme1AddButton.Left;
  FScheme3AddButton.Left    := FScheme1AddButton.Left;
  FScheme4AddButton.Left    := FScheme1AddButton.Left;
  FScheme5AddButton.Left    := FScheme1AddButton.Left;

  FScheme2DeleteButton.Left := FScheme1DeleteButton.Left;
  FScheme3DeleteButton.Left := FScheme1DeleteButton.Left;
  FScheme4DeleteButton.Left := FScheme1DeleteButton.Left;
  FScheme5DeleteButton.Left := FScheme1DeleteButton.Left;

  FScheme1ComboLabel.Left   := FScheme1Combo.Left;
  FScheme2ComboLabel.Left   := FScheme1Combo.Left;
  FScheme3ComboLabel.Left   := FScheme1Combo.Left;
  FScheme4ComboLabel.Left   := FScheme1Combo.Left;
  FScheme5ComboLabel.Left   := FScheme1Combo.Left;

  FPreviewGroupBox.Width    := FScheme1Combo.Left - 10;
  FPreviewGroupBox.Height   := Height;

  FPreviewScrollBox.Left    := 3;
  FPreviewScrollBox.Top     := 20;
  FPreviewScrollBox.Width   := FPreviewGroupBox.Width  - 6;
  FPreviewScrollBox.Height  := FPreviewGroupBox.Height - 23;

  FPreviewErrorLabel1.Width := FPreviewScrollBox.Width - 5;
  FPreviewErrorLabel2.Width := FPreviewScrollBox.Width - 5;

  FPreviewErrorLabel1.Top   := FPreviewScrollBox.Height div 2 - 3*FPreviewErrorLabel1.Height;
  FPreviewErrorLabel2.Top   := FPreviewScrollBox.Height div 2;

  FAcceptPreviewButton.Left := Width  - FAcceptPreviewButton.Width  - ButtonOffset;
  FAcceptPreviewButton.Top  := Height - FAcceptPreviewButton.Height - 5;
  //-------------------------------------------------------------------------------------------------------------
  FUserDefinedShape.Width   := FUserDefinedLabel.Height;
  FUserDefinedShape.Height  := FUserDefinedShape.Width;
  FPreDefinedShape.Width    := FUserDefinedShape.Width;
  FPreDefinedShape.Height   := FUserDefinedShape.Width;

  FUserDefinedShape.Left    := FScheme1Combo.Left;
  FPreDefinedShape.Left     := FScheme1Combo.Left;
  FLegendLabel.Left         := FScheme1Combo.Left;

  FUserDefinedLabel.Left    := FUserDefinedShape.Left + FUserDefinedShape.Width + 3;
  FPreDefinedLabel.Left     := FPreDefinedShape.Left  + FPreDefinedShape.Width  + 3;

  FUserDefinedShape.Top     := Height - FUserDefinedShape.Height - 5;
  FUserDefinedLabel.Top     := FUserDefinedShape.Top;

  FPreDefinedShape.Top      := FUserDefinedShape.Top - 2 - FPreDefinedShape.Height;
  FPreDefinedLabel.Top      := FPreDefinedShape.Top;

  FLegendLabel.Top          := FPreDefinedShape.Top - FLegendLabel.Height - 5;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.AcceptPreviewButtonClick(Sender: TObject);
begin
  if Assigned(FOnAcceptChanges) then FOnAcceptChanges(Self);
  FAcceptPreviewButton.Enabled := False;
  FScheme1Combo.SetFocus;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.ClearAllSchemes;
begin
  while FScheme1TypeList.Count <> 0 do begin FScheme1TypeList.Objects[0].Free; FScheme1TypeList.Delete(0); end;
  while FScheme2TypeList.Count <> 0 do begin FScheme2TypeList.Objects[0].Free; FScheme2TypeList.Delete(0); end;
  while FScheme3TypeList.Count <> 0 do begin FScheme3TypeList.Objects[0].Free; FScheme3TypeList.Delete(0); end;
  while FScheme4TypeList.Count <> 0 do begin FScheme4TypeList.Objects[0].Free; FScheme4TypeList.Delete(0); end;
  while FScheme5TypeList.Count <> 0 do begin FScheme5TypeList.Objects[0].Free; FScheme5TypeList.Delete(0); end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme1PropertyNames(const Value: TStringList);begin FScheme1PropertyNames.Assign(Value);end;
procedure TiComponentEditorThemePanel.SetScheme2PropertyNames(const Value: TStringList);begin FScheme2PropertyNames.Assign(Value);end;
procedure TiComponentEditorThemePanel.SetScheme3PropertyNames(const Value: TStringList);begin FScheme3PropertyNames.Assign(Value);end;
procedure TiComponentEditorThemePanel.SetScheme4PropertyNames(const Value: TStringList);begin FScheme4PropertyNames.Assign(Value);end;
procedure TiComponentEditorThemePanel.SetScheme5PropertyNames(const Value: TStringList);begin FScheme5PropertyNames.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme1Show(const Value: Boolean);
begin
  FScheme1Show                 := Value;
  FScheme1Combo.Visible        := Value;
  FScheme1ComboLabel.Visible   := Value;
  FScheme1AddButton.Visible    := Value;
  FScheme1DeleteButton.Visible := Value;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme2Show(const Value: Boolean);
begin
  FScheme2Show                 := Value;
  FScheme2Combo.Visible        := Value;
  FScheme2ComboLabel.Visible   := Value;
  FScheme2AddButton.Visible    := Value;
  FScheme2DeleteButton.Visible := Value;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme3Show(const Value: Boolean);
begin
  FScheme3Show                 := Value;
  FScheme3Combo.Visible        := Value;
  FScheme3ComboLabel.Visible   := Value;
  FScheme3AddButton.Visible    := Value;
  FScheme3DeleteButton.Visible := Value;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme4Show(const Value: Boolean);
begin
  FScheme4Show                 := Value;
  FScheme4Combo.Visible        := Value;
  FScheme4ComboLabel.Visible   := Value;
  FScheme4AddButton.Visible    := Value;
  FScheme4DeleteButton.Visible := Value;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme5Show(const Value: Boolean);
begin
  FScheme5Show                 := Value;
  FScheme5Combo.Visible        := Value;
  FScheme5ComboLabel.Visible   := Value;
  FScheme5AddButton.Visible    := Value;
  FScheme5DeleteButton.Visible := Value;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme1EnableModify(const Value: Boolean);
begin
  FScheme1EnableModify         := Value;
  FScheme1AddButton.Enabled    := Value;
  FScheme1DeleteButton.Enabled := Value;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme2EnableModify(const Value: Boolean);
begin
  FScheme2EnableModify         := Value;
  FScheme2AddButton.Enabled    := Value;
  FScheme2DeleteButton.Enabled := Value;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme3EnableModify(const Value: Boolean);
begin
  FScheme3EnableModify         := Value;
  FScheme3AddButton.Enabled    := Value;
  FScheme3DeleteButton.Enabled := Value;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme4EnableModify(const Value: Boolean);
begin
  FScheme4EnableModify         := Value;
  FScheme4AddButton.Enabled    := Value;
  FScheme4DeleteButton.Enabled := Value;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme5EnableModify(const Value: Boolean);
begin
  FScheme5EnableModify         := Value;
  FScheme5AddButton.Enabled    := Value;
  FScheme5DeleteButton.Enabled := Value;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.Scheme1ComboChange(Sender:TObject);begin SchemeComboChange(FScheme1Combo, FScheme1IsOverall, FScheme1DeleteButton); end;
procedure TiComponentEditorThemePanel.Scheme2ComboChange(Sender:TObject);begin SchemeComboChange(FScheme2Combo, FScheme2IsOverall, FScheme2DeleteButton); end;
procedure TiComponentEditorThemePanel.Scheme3ComboChange(Sender:TObject);begin SchemeComboChange(FScheme3Combo, FScheme3IsOverall, FScheme3DeleteButton); end;
procedure TiComponentEditorThemePanel.Scheme4ComboChange(Sender:TObject);begin SchemeComboChange(FScheme4Combo, FScheme4IsOverall, FScheme4DeleteButton); end;
procedure TiComponentEditorThemePanel.Scheme5ComboChange(Sender:TObject);begin SchemeComboChange(FScheme5Combo, FScheme5IsOverall, FScheme5DeleteButton); end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.Scheme1AddButtonClick(Sender:TObject);begin SchemeAdd(FScheme1Combo,FScheme1Title,FScheme1TypeList,FScheme1PropertyNames);end;
procedure TiComponentEditorThemePanel.Scheme2AddButtonClick(Sender:TObject);begin SchemeAdd(FScheme2Combo,FScheme2Title,FScheme2TypeList,FScheme2PropertyNames);end;
procedure TiComponentEditorThemePanel.Scheme3AddButtonClick(Sender:TObject);begin SchemeAdd(FScheme3Combo,FScheme3Title,FScheme3TypeList,FScheme3PropertyNames);end;
procedure TiComponentEditorThemePanel.Scheme4AddButtonClick(Sender:TObject);begin SchemeAdd(FScheme4Combo,FScheme4Title,FScheme4TypeList,FScheme4PropertyNames);end;
procedure TiComponentEditorThemePanel.Scheme5AddButtonClick(Sender:TObject);begin SchemeAdd(FScheme5Combo,FScheme5Title,FScheme5TypeList,FScheme5PropertyNames);end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetScheme1Title(const Value:String);begin if Value<>FScheme1Title then begin FScheme1Title:=Value;FScheme1ComboLabel.Caption:=FScheme1Title+':';end;end;
procedure TiComponentEditorThemePanel.SetScheme2Title(const Value:String);begin if Value<>FScheme2Title then begin FScheme2Title:=Value;FScheme2ComboLabel.Caption:=FScheme2Title+':';end;end;
procedure TiComponentEditorThemePanel.SetScheme3Title(const Value:String);begin if Value<>FScheme3Title then begin FScheme3Title:=Value;FScheme3ComboLabel.Caption:=FScheme3Title+':';end;end;
procedure TiComponentEditorThemePanel.SetScheme4Title(const Value:String);begin if Value<>FScheme4Title then begin FScheme4Title:=Value;FScheme4ComboLabel.Caption:=FScheme4Title+':';end;end;
procedure TiComponentEditorThemePanel.SetScheme5Title(const Value:String);begin if Value<>FScheme5Title then begin FScheme5Title:=Value;FScheme5ComboLabel.Caption:=FScheme5Title+':';end;end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.Scheme1ComboDropDown(Sender: TObject);begin FScheme1DeleteButton.Enabled := False;FScheme1Combo.Items.Assign(FScheme1TypeList);end;
procedure TiComponentEditorThemePanel.Scheme2ComboDropDown(Sender: TObject);begin FScheme2DeleteButton.Enabled := False;FScheme2Combo.Items.Assign(FScheme2TypeList);end;
procedure TiComponentEditorThemePanel.Scheme3ComboDropDown(Sender: TObject);begin FScheme3DeleteButton.Enabled := False;FScheme3Combo.Items.Assign(FScheme3TypeList);end;
procedure TiComponentEditorThemePanel.Scheme4ComboDropDown(Sender: TObject);begin FScheme4DeleteButton.Enabled := False;FScheme4Combo.Items.Assign(FScheme4TypeList);end;
procedure TiComponentEditorThemePanel.Scheme5ComboDropDown(Sender: TObject);begin FScheme5DeleteButton.Enabled := False;FScheme5Combo.Items.Assign(FScheme5TypeList);end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SchemeComboChange(SchemeCombo: TComboBox; IsOverall: Boolean; SchemeDeleteButton: TiComponentEditorButton);
var
  StringList           : TStringList;
  SchemeComboItemIndex : Integer;
begin
  SchemeComboItemIndex := SchemeCombo.ItemIndex;
  if SchemeComboItemIndex < 0 then exit;
  if IsOverall = True then
    begin
      ClearSelectedSchemes;
      SchemeCombo.ItemIndex := SchemeComboItemIndex;
    end;
  StringList := SchemeCombo.Items.Objects[SchemeComboItemIndex] as TStringList;
  TransferSchemeData(StringList);
  SchemeDeleteButton.Enabled := (StringList is TiUserSchemeList);
  if FAutoAcceptPreview = True then
    FOnAcceptChanges(Self);
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SchemeAdd(SchemeCombo: TComboBox; SchemeTypeTitle: String; SchemeTypeList, SchemePropertyNames: TStringList);
var
  NewSchemeName        : String;
  ItemIndex            : Integer;
  AcceptPreviewEnabled : Boolean;
begin
  iComponentEditorThemePanelAddDialogForm := TiComponentEditorThemePanelAddDialogForm.Create(Owner);

  iComponentEditorThemePanelAddDialogForm.Caption := 'Add Scheme to ' + SchemeTypeTitle;
  iComponentEditorThemePanelAddDialogForm.SchemeName.Text := SchemeCombo.Text;
  try
    if iComponentEditorThemePanelAddDialogForm.ShowModal = mrOk then
      begin
        NewSchemeName := Trim(iComponentEditorThemePanelAddDialogForm.SchemeName.Text);
        if NewSchemeName = '' then
          begin
            MessageDlg(NoNameEnteredErrorMessage, mtError, [mbOK], 0);
            exit;
          end;
        ItemIndex := UserSchemeNameExist(NewSchemeName, SchemeTypeList);
        if ItemIndex <> -1 then
          begin
            if MessageDlg('Do you want to overwrite ' + NewSchemeName + '?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
            SchemeTypeList.Objects[ItemIndex].Free;
            SchemeTypeList.Delete(ItemIndex);
          end;
        CreateNewScheme(NewSchemeName, SchemeTypeList, SchemePropertyNames);
        SchemeCombo.OnDropDown(Self);
        SchemeCombo.ItemIndex := SchemeCombo.Items.IndexOf(NewSchemeName);
        AcceptPreviewEnabled := FAcceptPreviewButton.Enabled;
        SchemeCombo.OnChange(Self);
        FAcceptPreviewButton.Enabled := AcceptPreviewEnabled;
      end;
  finally
    iComponentEditorThemePanelAddDialogForm.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.CleanScheme(SchemeTypeList, SchemePropertyNames: TStringList; NoConfirmation: Boolean);
var
  x                  : Integer;
  NewSchemeName      : String;
  NumberSchemes      : Integer;
  StringList         : TStringList;
  TempSchemeTypeList : TStringList;
begin

  if NoConfirmation = False then
    begin
      if MessageDlg(CleanSchemesMessage, mtWarning, [mbYes, mbNo], 0) = mrNo then exit;
    end;
  if Assigned(FOnAcceptChanges) then
    begin
      //Loop through Schemes
      TempSchemeTypeList := TStringList.Create;
      NumberSchemes := SchemeTypeList.Count;
      for x := 0 to NumberSchemes - 1 do
        begin
          //Apply Schemes to Component Preview
          StringList := SchemeTypeList.Objects[x] as TStringList;
          TransferSchemeData(StringList);
          FOnAcceptChanges(Self);
          //Add New Scheme
          NewSchemeName := SchemeTypeList.Strings[x];
          CreateNewScheme(NewSchemeName, TempSchemeTypeList, SchemePropertyNames);
        end;
      for x := 0 to NumberSchemes - 1 do
        begin
          //Remove old Schemes
          SchemeTypeList.Objects[0].Free;
          SchemeTypeList.Delete(0);
        end;
      //Assign TempSchemeTypeList to SchemeTypeList
      SchemeTypeList.Assign(TempSchemeTypeList);
      //Save changes to XML File
      SaveToXMLFile;
      FAcceptPreviewButton.Enabled := True;
    end
  else
    begin
        MessageDlg(AcceptChangesNotAssignedEM , mtError, [mbOK], 0);
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.TransferSchemeData(TypeList: TStringList);
var
  x                   : Integer;
  AString             : String;
  PropertyNameString  : String;
  PropertyValueString : String;
begin
  for x := 0 to TypeList.Count - 1 do
    begin
      AString := TypeList.Strings[x];
      SeparateNameValue(AString, PropertyNameString, PropertyValueString);
      if (PropertyNameString <> '') {and (PropertyValueString <> '')} then
        SetProperty(iComponentPreview, PropertyNameString, PropertyValueString);
    end;
    ReCenterPreview;
    FAcceptPreviewButton.Enabled := True;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.CreateNewScheme(SchemeName: String; SchemeList: TStringList; PropertyNameList: TStringList);
var
  x           : Integer;
  NameString  : String;
  ValueString : String;
  BuildString : String;
  StringList  : TiUserSchemeList;
begin
  StringList := TiUserSchemeList.Create;
  try
    for x := 0 to PropertyNameList.Count - 1 do
      begin
        NameString  := PropertyNameList.Strings[x];
        ValueString := GetProperty(FiComponentPreview, NameString);
        BuildString := CombineNameValue(NameString, ValueString);
        StringList.Add(BuildString);
      end;
    SchemeList.AddObject(SchemeName, StringList);
    SchemeList.Add(SchemeName);
    SaveToXMLFile;
    ResetThemePanel;
    LoadFromXMLFile;
  except
    StringList.Free;
  end;
end;
//****************************************************************************************************************************************************
function TiComponentEditorThemePanel.GetProperty(Instance : TPersistent; PropertyNameString : String): String;
var
  PropInfo : PPropInfo;
begin
  PropInfo := GetPropertyInfo(Instance, PropertyNameString);
  if PropInfo <> nil then
    begin
      case PropInfo^.PropType^.Kind of
        tkInteger, tkEnumeration, tkSet, tkChar : Result := IntToStr  (GetOrdProp  (Instance, PropInfo));
        tkFloat                                 : Result := FloatToStr(GetFloatProp(Instance, PropInfo));
        tkString, tkLString, tkWString          : Result :=            GetStrProp  (Instance, PropInfo);
      end;
    end;
end;
//****************************************************************************************************************************************************
function TiComponentEditorThemePanel.GetPropertyInfo(var Instance : TPersistent; PropertyNameString : String): PPropInfo;
var
  I, J, L   : Integer;
  PropInfo  : PPropInfo;
  PropValue : TObject;
  PropName  : String;
begin
  Result := nil;
  I := 1;
  L := Length(PropertyNameString);     
  while True do
    begin
      J := I;
      while (I <= L) and (PropertyNameString[I] <> '.') do Inc(I);
      PropName := Trim(Copy(PropertyNameString, J, I - J));
      if I > L then Break;
      PropInfo := GetPropInfo(Instance.ClassInfo, PropName);
      if PropInfo = nil then Exit;
      PropValue := nil;
      if PropInfo^.PropType^.Kind = tkClass then
        PropValue := TObject(GetOrdProp(Instance, PropInfo));
      if not (PropValue is TPersistent) then Exit;
      Instance := TPersistent(PropValue);
      Inc(I);
    end;
  Result := GetPropInfo(Instance.ClassInfo, PropName);
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetProperty(Instance : TPersistent; PropertyNameString, PropertyValueString : String);
var
  PropInfo   : PPropInfo;
  {$ifdef iCLX}
  ColorValue : Integer;
  NewColor   : Integer;
  {$endif}
begin
  PropInfo := GetPropertyInfo(Instance, PropertyNameString);
  if PropInfo <> nil then
    begin
      case PropInfo^.PropType^.Kind of
        tkInteger, tkEnumeration, tkSet, tkChar, tkFloat : if Trim(PropertyValueString) = '' then exit;
      end;
      case PropInfo^.PropType^.Kind of
        {$ifdef iVCL}
        tkInteger, tkEnumeration, tkSet, tkChar : SetOrdProp  (Instance, PropInfo, StrToInt  (PropertyValueString));
        {$endif}
        {$ifdef iCLX}
        tkInteger : begin
                      //Colors under LINUX do not support "Windows" system colors
                      //Need to convert to VCL Colors from the stored Integers
                      //Windows Colors have negative Values
                      if Pos('COLOR', UpperCase(PropertyNameString)) > 0 then
                        begin
                          ColorValue := StrToInt(PropertyValueString);
                          if ColorValue < 0 then
                            begin
                              ColorValue := (ColorValue and $000000FF);
                              case ColorValue of
                                 0: NewColor := clScrollBar;
                                 1: NewColor := clBackground;
                                 2: NewColor := clActiveCaption;
                                 3: NewColor := clInactiveCaption;
                                 4: NewColor := clMenu;
                                 5: NewColor := clWindow;
                                 6: NewColor := clWindowFrame;
                                 7: NewColor := clMenuText;
                                 8: NewColor := clWindowText;
                                 9: NewColor := clCaptionText;
                                10: NewColor := clActiveBorder;
                                11: NewColor := clInactiveBorder;
                                12: NewColor := clAppWorkSpace;
                                13: NewColor := clHighlight;
                                14: NewColor := clHighlightText;
                                15: NewColor := clBtnFace;
                                16: NewColor := clBtnShadow;
                                17: NewColor := clGrayText;
                                18: NewColor := clBtnText;
                                19: NewColor := clInactiveCaptionText;
                                20: NewColor := clBtnHighlight;
                                21: NewColor := cl3DDkShadow;
                                22: NewColor := cl3DLight;
                                23: NewColor := clInfoText;
                                24: NewColor := clInfoBk;
                                //26: NewColor := clHotLight;
                                //27: NewColor := clGradientActiveCaption;
                                //28: NewColor := clGradientInactiveCaption;
                                //29: NewColor := clMenuHighlight;
                                //30: NewColor := clMenuBar;
                                else NewColor := clBtnFace;
                              end;
                            PropertyValueString := IntToStr(NewColor);
                          end;
                        end;
                      SetOrdProp  (Instance, PropInfo, StrToInt  (PropertyValueString));
                    end;
        tkEnumeration, tkSet, tkChar : SetOrdProp  (Instance, PropInfo, StrToInt  (PropertyValueString));
        {$endif}
        tkFloat                                 : SetFloatProp(Instance, PropInfo, StrToFloat(PropertyValueString));
        tkString, tkLString, tkWString          : if PropertyValueString = '' then
                                                      SetStrProp  (Instance, PropInfo, ' ')
                                                    else
                                                      SetStrProp  (Instance, PropInfo, PropertyValueString);
      end;
    end;
end;
//****************************************************************************************************************************************************
function TiComponentEditorThemePanel.SaveToXMLFile: Boolean;
var
  UserFileStream : TiXMLMemoryStream;
  UserPathName   : String;
  UserFileName   : String;
  IocompPathName : String;
begin

  SaveToXMLFile := True;
  GetThemePaths(IocompPathName, UserPathName);

  UserFileName := iComponentPreview.ClassName + UserFileSuffix;
  UserFileStream := TiXMLMemoryStream.Create;
  try
    UserFileStream.StartElement('SchemeTypes');
      if FScheme1Show then SaveSchemeType(UserFileStream, FScheme1TypeList, FScheme1Title);
      if FScheme2Show then SaveSchemeType(UserFileStream, FScheme2TypeList, FScheme2Title);
      if FScheme3Show then SaveSchemeType(UserFileStream, FScheme3TypeList, FScheme3Title);
      if FScheme4Show then SaveSchemeType(UserFileStream, FScheme4TypeList, FScheme4Title);
      if FScheme5Show then SaveSchemeType(UserFileStream, FScheme5TypeList, FScheme5Title);
    UserFileStream.EndElement('SchemeTypes');
  finally
    try
      UserFileStream.SaveToFile(UserPathName + UserFileName);
    except
      on E : Exception do
        begin
          MessageDlg(IocompThemeSaveErrorMessage + ' - ' + E.Message, mtError, [mbOK], 0);
          SaveToXMLFile := False;
        end;
    end;
    UserFileStream.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SaveSchemeType(Stream: TiXMLMemoryStream; SchemeTypeList: TStringList; SchemeTitle: String);
var
  SchemeList     : TStringList;
  TypeListIndex  : Integer;
  DataItemIndex  : Integer;
  PropertyName   : String;
  PropertyValue  : String;
begin
  with Stream do
    begin
      StartElement('SchemeType');
        WriteElement('Name', SchemeTitle);
        for TypeListIndex := 0 to SchemeTypeList.Count-1 do
          begin
            SchemeList := SchemeTypeList.Objects[TypeListIndex] as TStringList;
            if SchemeList is TiUserSchemeList then
              begin
                StartElement('Scheme');
                  WriteElement('Name', SchemeTypeList.Strings[TypeListIndex]);
                  StartElement('Properties');
                    for DataItemIndex := 0 to SchemeList.Count-1 do
                      begin
                        PropertyName  := '';
                        PropertyValue := ''; //If property doesn't exist, this needs to be preset/reset to blank
                                            //to prevent using the previuos property's value.
                        SeparateNameValue(SchemeList.Strings[DataItemIndex], PropertyName, PropertyValue);
                        if PropertyName <> '' then
                          WriteElement(PropertyName, PropertyValue);
                      end;
                  EndElement('Properties');
                EndElement('Scheme');
              end;
          end;
      EndElement('SchemeType');
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SeparateNameValue(AText: String; var Name: String; var Value: String);
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
function TiComponentEditorThemePanel.CombineNameValue(Name, Value: String): String;
begin
  Result := Name + ' = ' + Value;
end;
//****************************************************************************************************************************************************
function TiComponentEditorThemePanel.GetSchemeTypeListByName(Name: String): TStringList;
begin
  if Name = FScheme1Title      then result := FScheme1TypeList
   else if Name = FScheme2Title then result := FScheme2TypeList
    else if Name = FScheme3Title then result := FScheme3TypeList
     else if Name = FScheme4Title then result := FScheme4TypeList
      else if Name = FScheme5Title then result := FScheme5TypeList
       else Result := nil;//else raise exception.create('Scheme Type ' + Name + ' Not Found');
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.GetThemePaths(var IocompPathName, UserPathName: String);
var
{$ifdef MSWINDOWS}
  Registry : TRegistry;
  //INIFile  : TIniFile;
  AString  : String;
{$endif}
{$ifdef LINUX}
  INIFile      : TMemIniFile;
  HOMEDIRECTORY: String;
  INIFILENAME  : String;
  TempString   : String;
{$endif}
begin
  {$ifdef MSWINDOWS}
  //==================================================================
  //Windows Specific Code
  //==================================================================
  Registry := TRegistry.Create;
  try
    //First look in Local Machine
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    Registry.OpenKeyReadOnly('SOFTWARE\Iocomp\Themes');
    IocompPathName := Trim(Registry.ReadString('Iocomp Defined Theme Path'));
    UserPathName   := Trim(Registry.ReadString('User Defined Theme Path'));

    //Let Current User override Local Machine settings
    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.OpenKeyReadOnly('SOFTWARE\Iocomp\Themes');

    AString := '';
    AString := Trim(Registry.ReadString('Iocomp Defined Theme Path'));
    if AString <> '' then IocompPathName := AString;

    AString := '';
    AString := Trim(Registry.ReadString('User Defined Theme Path'));
    if AString <> '' then UserPathName   := AString;

    FSchemeFound := False;

    if (IocompPathName <> '') then FSchemeFound := True;
    if (UserPathName   <> '') then FSchemeFound := True;

    if Length(IocompPathName) <> 0 then
      begin
        if Copy(IocompPathName, Length(IocompPathName), 1) <> '\' then IocompPathName := IocompPathName + '\';
      end;

    if Length(UserPathName) <> 0 then
      begin
        if Copy(UserPathName,   Length(UserPathName),   1) <> '\' then UserPathName   := UserPathName   + '\';
      end;

    {if (IocompPathName <> '') then
      begin
        if LastDelimiter('\',IocompPathName) <> Length(IocompPathName) then
          IocompPathName := IocompPathName + '\';
      end;

    if (UserPathName <> '') then
      begin
        if LastDelimiter('\',UserPathName) <> Length(UserPathName) then
          UserPathName := UserPathName + '\';
      end;            }
  finally
    Registry.Free;
  end;
  {$endif}
  {$ifdef LINUX}
  //==================================================================
  //Linux Specific Code
  //==================================================================
  HOMEDIRECTORY := GetEnvironmentVariable('HOME');
  INIFILENAME   := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(HOMEDIRECTORY) + '.iocomp') + 'registry.ini';
  //Create "Iocomp Registry" under INIFileName Directory
  if DirectoryExists(ExtractFilePath(INIFILENAME)) then
    begin
      FSchemeFound := False;
      TempString   := '';
      //Get Default Installation Directory from "Registry"
      INIFile := TMemIniFile.Create(INIFILENAME);
      try
        TempString     := INIFile.ReadString('Themes', 'Iocomp Defined Theme Path', '');
        if TempString <> '' then
          begin
            IocompPathName := IncludeTrailingPathDelimiter(TempString);
            FSchemeFound := True;
          end;
        TempString     := INIFile.ReadString('Themes', 'User Defined Theme Path',   '');
        if TempString <> '' then
          begin
            UserPathName   := IncludeTrailingPathDelimiter(TempString);
            FSchemeFound := True;
          end;
      finally
        INIFile.Free;
      end;
    end;
  {$endif}
  //==================================================================
  //Common Code
  //==================================================================
  if not FSchemeFound then
    begin
      FPreviewErrorLabel1.Visible   := True;
      FPreviewErrorLabel2.Visible   := True;
      FScheme1Combo.Enabled        := False;
      FScheme1ComboLabel.Enabled   := False;
      FScheme1AddButton.Enabled    := False;
      FScheme1DeleteButton.Enabled := False;
      FScheme2Combo.Enabled        := False;
      FScheme2ComboLabel.Enabled   := False;
      FScheme2AddButton.Enabled    := False;
      FScheme2DeleteButton.Enabled := False;
      FScheme3Combo.Enabled        := False;
      FScheme3ComboLabel.Enabled   := False;
      FScheme3AddButton.Enabled    := False;
      FScheme3DeleteButton.Enabled := False;
      FScheme4Combo.Enabled        := False;
      FScheme4ComboLabel.Enabled   := False;
      FScheme4AddButton.Enabled    := False;
      FScheme4DeleteButton.Enabled := False;
      FScheme5Combo.Enabled        := False;
      FScheme5ComboLabel.Enabled   := False;
      FScheme5AddButton.Enabled    := False;
      FScheme5DeleteButton.Enabled := False;
      if Assigned(FiComponentPreview) then
        begin
          FiComponentPreview.Width  := 0;
          FiComponentPreview.Height := 0;
        end;
    end
  else
    begin
      FPreviewErrorLabel1.Visible   := False;
      FPreviewErrorLabel2.Visible   := False;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.LoadFromXMLFile;
var
  IocompFileStream : TiXMLMemoryStream;
  UserFileStream   : TiXMLMemoryStream;
  IocompFileName   : String;
  UserFileName     : String;
  IocompPathName   : String;
  UserPathName     : String;
begin
  if csDesigning in ComponentState then exit;
  ClearAllSchemes;
  GetThemePaths(IocompPathName, UserPathName);

  IocompFileName := iComponentPreview.ClassName + IocompFileSuffix;
    begin
      if FileExists(IocompPathName + IocompFileName) then
        begin
           try
            try
              IocompFileStream := TiXMLMemoryStream.Create;
              IocompFileStream.LoadFromFile(IocompPathName + IocompFileName);
              try
                LoadSchemes(IocompFileStream, TiIocompSchemeList);
              finally
                IocompFileStream.Free;
              end;
            except
              on EFOpenError do ;
            end;
          except
            on E : Exception do
              begin
                MessageDlg(IocompThemeOpenErrorMessage + ' - ' + E.Message, mtInformation, [mbOK], 0);
              end;
          end;
        end;

      UserFileName := iComponentPreview.ClassName + UserFileSuffix;
      if FileExists(UserPathName + UserFileName) then
        begin
          try
            try
              UserFileStream := TiXMLMemoryStream.Create;
              UserFileStream.LoadFromFile(UserPathName + UserFileName);
              try
                LoadSchemes(UserFileStream, TiUserSchemeList);
              finally
                UserFileStream.Free;
              end;
            except
              on EFOpenError do ;
            end;
          except
            on E : Exception do
              begin
                MessageDlg(UserThemeOpenErrorMessage + ' - ' + E.Message, mtInformation, [mbOK], 0);
              end;
          end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.LoadSchemes(FileStream: TiXMLMemoryStream; SchemeListClass: TiSchemeListClass);
var
  AString          : String;
  SchemeTypeList   : TStringList;
  SchemeList       : TStringList;
  ElementName      : String;
  ElementValue     : String;
begin
  with FileStream do
    begin
      GotoElementStart('SchemeTypes');
      while PeekNextPiece = 'SchemeType' do
        begin
          GotoElementStart('SchemeType');
          AString := GetElement('Name');
          SchemeTypeList := GetSchemeTypeListByName(AString);
          while PeekNextPiece = 'Scheme' do
            begin
              GotoElementStart('Scheme');
              AString := GetElement('Name');
              if Assigned(SchemeTypeList) then
                begin
                  SchemeList := SchemeListClass.Create;
                  SchemeTypeList.AddObject(AString, SchemeList);
                end
              else SchemeList := nil;
              GotoElementStart('Properties');
              while PeekNextPiece <> '/Properties' do
                begin
                  ElementName  := '';
                  ElementValue := '';
                  ElementName  := PeekNextPiece;
                  ElementValue := GetElement(ElementName);
                  if Assigned(SchemeList) then
                    begin
                      if ElementName <> '' then
                        SchemeList.Add(CombineNameValue(ElementName, ElementValue));
                    end;
                end;
              if GetNextPiece <> '/Properties' then raise Exception.Create(XMLFileExceptionMessage); //GotoElementStart('/Properties');
              if GetNextPiece <> '/Scheme' then raise Exception.Create(XMLFileExceptionMessage); //GotoElementStart('/Scheme');
            end;
          if GetNextPiece <> '/SchemeType' then raise Exception.Create(XMLFileExceptionMessage); //GetNextPiece;GotoElementStart('/SchemeType');
        end;
      if GetNextPiece <> '/SchemeTypes' then raise Exception.Create(XMLFileExceptionMessage); //GotoElementStart('/SchemeTypes');
    end;
end;
//****************************************************************************************************************************************************
function TiComponentEditorThemePanel.UserSchemeNameExist(Name: String; SchemeTypeList: TStringList): Integer;
var
  x : Integer;
begin
  Result := -1;
  for x := 0 to SchemeTypeList.Count-1 do
    begin
      if SchemeTypeList.Objects[x] is TiUserSchemeList then
        if SchemeTypeList.Strings[x] = Name then Result := x;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.Scheme1DeleteButtonClick(Sender: TObject);
begin
  if MessageDlg(DeleteSchemeMessage, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if SaveToXMLFile = True then
        begin
          FScheme1TypeList.Delete(FScheme1Combo.ItemIndex);
          FScheme1Combo.ItemIndex      := -1;
          FScheme1DeleteButton.Enabled := False;
          SaveToXMLFile;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.Scheme2DeleteButtonClick(Sender: TObject);
begin
  if MessageDlg(DeleteSchemeMessage, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if SaveToXMLFile = True then
        begin
          FScheme2TypeList.Delete(FScheme2Combo.ItemIndex);
          FScheme2Combo.ItemIndex      := -1;
          FScheme2DeleteButton.Enabled := False;
          SaveToXMLFile;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.Scheme3DeleteButtonClick(Sender: TObject);
begin
  if MessageDlg(DeleteSchemeMessage, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if SaveToXMLFile = True then
        begin
          FScheme3TypeList.Delete(FScheme3Combo.ItemIndex);
          FScheme3Combo.ItemIndex      := -1;
          FScheme3DeleteButton.Enabled := False;
          SaveToXMLFile;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.Scheme4DeleteButtonClick(Sender: TObject);
begin
  if MessageDlg(DeleteSchemeMessage, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if SaveToXMLFile = True then
        begin
          FScheme4TypeList.Delete(FScheme4Combo.ItemIndex);
          FScheme4Combo.ItemIndex      := -1;
          FScheme4DeleteButton.Enabled := False;
          SaveToXMLFile;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.Scheme5DeleteButtonClick(Sender: TObject);
begin
  if MessageDlg(DeleteSchemeMessage, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if SaveToXMLFile = True then
        begin
          FScheme5TypeList.Delete(FScheme5Combo.ItemIndex);
          FScheme5Combo.ItemIndex      := -1;
          FScheme5DeleteButton.Enabled := False;
          SaveToXMLFile;
        end;
    end;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}procedure TiComponentEditorThemePanel.ComboBoxDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState                      );{$ENDIF}
{$IFDEF iCLX}procedure TiComponentEditorThemePanel.ComboBoxDrawItem(Control: TObject;     Index: Integer; Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);{$ENDIF}
var
  AText : String;
begin
  with (Control as TComboBox).Canvas, Rect do
    begin
      if odSelected in State then
        begin
          Brush.Color := clTeal;
          Font.Color  := clWhite;
        end
      else
        begin
          Brush.Color := clWindow;
          Font.Color  := clBlack;
        end;

      FillRect(Rect);
      AText := (Control as TComboBox).Items[Index];
      TextOut(Left + 16, Top, AText);

      if (Control as TComboBox).Items.Objects[Index] is TiUserSchemeList then
        Brush.Color := clBlue
      else
        Brush.Color := clRed;
      Pen.Color := clBlack;

      Rectangle(Left + SquareOffset, Top + SquareOffset, Left + SquareSize + SquareOffset, Top + SquareSize + SquareOffset);
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.ClearSelectedSchemes;
begin
  FScheme1Combo.ItemIndex := -1;
  FScheme2Combo.ItemIndex := -1;
  FScheme3Combo.ItemIndex := -1;
  FScheme4Combo.ItemIndex := -1;
  FScheme5Combo.ItemIndex := -1;
  FScheme1DeleteButton.Enabled := False;
  FScheme2DeleteButton.Enabled := False;
  FScheme3DeleteButton.Enabled := False;
  FScheme4DeleteButton.Enabled := False;
  FScheme5DeleteButton.Enabled := False;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.SetAutoAcceptPreview(const Value: Boolean);
begin
  if Value <> FAutoAcceptPreview then
    begin
      FAutoAcceptPreview           := Value;
      FAcceptPreviewButton.Visible := Value;
    end;
end;
//****************************************************************************************************************************************************
{ TiThemeComboBox }
procedure TiThemeComboBox.Change;
begin
  if Assigned(OnChange) then OnChange(Self);
end;
//****************************************************************************************************************************************************
{$IFDEF COMPILER_6_UP}
procedure TiThemeComboBox.CloseUp;
begin
  inherited;
  //SetParentsToTopMost(Owner As TWinControl);
end;
{$ENDIF}
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiThemeComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}
end;
{$ENDIF}
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorThemePanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}
end;
{$ENDIF}
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.OpenMaintenance(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  MaintenanceForm      : TiComponentEditorThemePanelMaintenanceForm;
begin
  if (ssShift in Shift) and (ssCtrl in Shift) and (ssAlt in Shift) then
    begin
      MaintenanceForm := TiComponentEditorThemePanelMaintenanceForm.Create(Owner);
      try
        MaintenanceForm.ThemePanel := Self;
        if MaintenanceForm.ShowModal = mrOk then
          begin
            SaveToXMLFile;
          end;
        ResetThemePanel;
        LoadFromXMLFile;
      finally
        MaintenanceForm.Free;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorThemePanel.CleanAllSchemes();
var
  x : Integer;
begin
  for x := 0 to FSchemeCount - 1 do
    begin
      case x of
        0: CleanScheme(FScheme1TypeList, FScheme1PropertyNames, True);
        1: CleanScheme(FScheme2TypeList, FScheme2PropertyNames, True);
        2: CleanScheme(FScheme3TypeList, FScheme3PropertyNames, True);
        3: CleanScheme(FScheme4TypeList, FScheme4PropertyNames, True);
        4: CleanScheme(FScheme5TypeList, FScheme5PropertyNames, True);
      end;
    end;
    //Programatically select first item in first scheme
    //FScheme1DeleteButton.Enabled := False;
    //FScheme1Combo.Items.Assign(FScheme1TypeList);
    //FScheme1Combo.ItemIndex := 0;
    //SchemeComboChange(FScheme1Combo, FScheme1IsOverall, FScheme1DeleteButton);
end;
//****************************************************************************************************************************************************
function TiComponentEditorThemePanel.GetSchemeList(Index: Integer) : TStringList;
begin
  Result := nil;
  case Index of
    0: Result := FScheme1TypeList;
    1: Result := FScheme2TypeList;
    2: Result := FScheme3TypeList;
    3: Result := FScheme4TypeList;
    4: Result := FScheme5TypeList;
  end;
end;
//****************************************************************************************************************************************************
function TiComponentEditorThemePanel.GetSchemeName(Index: Integer) : String;
begin
  case Index of
    0: Result := FScheme1Title;
    1: Result := FScheme2Title;
    2: Result := FScheme3Title;
    3: Result := FScheme4Title;
    4: Result := FScheme5Title;
  end;
end;
//****************************************************************************************************************************************************
end.
