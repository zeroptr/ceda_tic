{*******************************************************}
{                                                       }
{       TiOPCBrowserPanel Component                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCBrowserPanel;{$endif}
{$ifdef iCLX}unit QiOPCBrowserPanel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} ShellAPI, ShlObj, Registry, {$ENDIF}

  {$IFDEF iVCL} iTypes,  iGPFunctions,  iEditorBasicComponents,  iOPCDLLLoader,  iOPCItem;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiEditorBasicComponents, QiOPCDLLLoader, QiOPCItem;{$ENDIF}

type
  TiOPCGroupEditStyle = (iopcgesSelectFromList, iopcgesEdit);

type
  TiOPCBrowserPanel = class(TCustomControl)
  private
    FOPCItemList             : TiComponentEditorListBox;
    FAddItemButton           : TiComponentEditorButton;
    FRemoveItemButton        : TiComponentEditorButton;

    FPropertyNameEdit        : TiComponentEditorEdit;
    FGroupNameEdit           : TiComponentEditorEdit;
    FComputerNameEdit        : TiComponentEditorEdit;
    FOPCServerNameEdit       : TiComponentEditorEdit;
    FItemNameEdit            : TiComponentEditorEdit;
    FItem2NameEdit           : TiComponentEditorEdit;
    FScalarEdit              : TiComponentEditorEdit;
    FOffsetEdit              : TiComponentEditorEdit;
    FScalar2Edit             : TiComponentEditorEdit;
    FOffset2Edit             : TiComponentEditorEdit;
    FAutoConnectCheckBox     : TiComponentEditorCheckBox;
    FAutoErrorCheckBox       : TiComponentEditorCheckBox;

    FPropertyNameEditButton  : TiComponentEditorButton;
    FGroupNameEditButton     : TiComponentEditorButton;
    FComputerNameEditButton  : TiComponentEditorButton;
    FOPCServerNameEditButton : TiComponentEditorButton;
    FItemNameEditButton      : TiComponentEditorButton;
    FItem2NameEditButton     : TiComponentEditorButton;

    FUpdateRateEdit          : TiComponentEditorEdit;

    FPropertyLabel           : TLabel;
    FGroupLabel              : TLabel;
    FComputerLabel           : TLabel;
    FOPCServerLabel          : TLabel;
    FItemNameLabel           : TLabel;
    FItem2Label              : TLabel;
    FScalarLabel             : TLabel;
    FOffsetLabel             : TLabel;
    FScalar2Label            : TLabel;
    FOffset2Label            : TLabel;
    FUpdateRateLabel         : TLabel;

    FErrorLabel              : TLabel;
    FEvaluationLabel         : TLabel;

    FOnChange                : TNotifyEvent;
    FPersistent              : TPersistent;

    FSessionHandle           : Integer;
    FShowProperty            : Boolean;
    FShowAutoError           : Boolean;
    FShowAutoConnect         : Boolean;
    FShowGroupName           : Boolean;
    FShowItem                : Boolean;
    FItem2Visible            : Boolean;
    FGroupEditStyle          : TiOPCGroupEditStyle;
  protected
    procedure SetShowProperty    (const Value: Boolean);
    procedure SetShowGroupName   (const Value: Boolean);
    procedure SetShowItem        (const Value: Boolean);
    procedure SetShowAutoError   (const Value: Boolean);
    procedure SetShowAutoConnect (const Value: Boolean);
    procedure SetItem2Caption    (const Value: String);
    procedure SetItem2Visible    (const Value: Boolean);
    procedure SetItemCaption     (const Value: String);
    procedure SetGroupNameCaption(const Value: String);
    procedure SetGroupEditStyle  (const Value: TiOPCGroupEditStyle);

    function GetItem2Caption     : String;
    function GetItemCaption      : String;
    function GetGroupNameCaption : String;

    procedure AddButtonClick    (Sender: TObject);
    procedure RemoveButtonClick (Sender: TObject);

    procedure PropertyNameChange(Sender: TObject);
    procedure GroupNameChange   (Sender: TObject);
    procedure ComputerNameChange(Sender: TObject);
    procedure OPCSeverNameChange(Sender: TObject);
    procedure ItemNameChange    (Sender: TObject);
    procedure ItemName2Change   (Sender: TObject);
    procedure OffsetChange      (Sender: TObject);
    procedure ScalarChange      (Sender: TObject);
    procedure UpdateRateChange  (Sender: TObject);
    procedure AutoConnectChange (Sender: TObject);
    procedure AutoErrorChange   (Sender: TObject);
    procedure ItemMoveEvent     (Sender: TObject);

    procedure OPCItemListClick           (Sender: TObject);
    procedure PropertyNameEditButtonClick(Sender: TObject);
    procedure GroupNameEditButtonClick   (Sender: TObject);
    procedure ComputerNameEditButtonClick(Sender: TObject);
    procedure OPCSeverNameEditButtonClick(Sender: TObject);
    procedure ItemNameEditButtonClick    (Sender: TObject);
    procedure ItemName2EditButtonClick   (Sender: TObject);

    procedure GetDefaults(OPCItem: TiOPCItem);
    procedure SetDefaults(PropertyName, PropertyData: String);

    procedure Resize;  override;

    procedure AdjustLayout;
    procedure Loaded;                       override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    procedure UpdateItemEdit;
    procedure ItemChange;

    function  AddItem   : Integer;
    function  ItemCount : Integer;
    procedure RemoveAllItems;

    function  GetPropertyName(Index: Integer):String;
    function  GetGroupName   (Index: Integer):String;
    function  GetComputerName(Index: Integer):String;
    function  GetServerName  (Index: Integer):String;
    function  GetItemName    (Index: Integer):String;
    function  GetItem2Name   (Index: Integer):String;
    function  GetScalar      (Index: Integer):Double;
    function  GetOffset      (Index: Integer):Double;
    function  GetScalar2     (Index: Integer):Double;
    function  GetOffset2     (Index: Integer):Double;
    function  GetUpdateRate  (Index: Integer):Integer;
    function  GetAutoConnect (Index: Integer):Boolean;
    function  GetAutoError   (Index: Integer):Boolean;

    procedure SetPropertyName(Index: Integer; Value: String);
    procedure SetGroupName   (Index: Integer; Value: String);
    procedure SetComputerName(Index: Integer; Value: String);
    procedure SetServerName  (Index: Integer; Value: String);
    procedure SetItemName    (Index: Integer; Value: String);
    procedure SetItem2Name   (Index: Integer; Value: String);
    procedure SetScalar      (Index: Integer; Value: Double);
    procedure SetOffset      (Index: Integer; Value: Double);
    procedure SetScalar2     (Index: Integer; Value: Double);
    procedure SetOffset2     (Index: Integer; Value: Double);
    procedure SetUpdateRate  (Index: Integer; Value: Integer);
    procedure SetAutoConnect (Index: Integer; Value: Boolean);
    procedure SetAutoError   (Index: Integer; Value: Boolean);

    property APersistent      : TPersistent         read FPersistent         write FPersistent;
  published
    property OnChange         : TNotifyEvent        read FOnChange           write FOnChange;
    property ShowProperty     : Boolean             read FShowProperty       write SetShowProperty    default True;
    property ShowGroupName    : Boolean             read FShowGroupName      write SetShowGroupName   default True;
    property ShowItem         : Boolean             read FShowItem           write SetShowItem        default True;
    property ShowAutoError    : Boolean             read FShowAutoError      write SetShowAutoError   default True;
    property ShowAutoConnect  : Boolean             read FShowAutoConnect    write SetShowAutoConnect default True;

    property GroupNameCaption : String              read GetGroupNameCaption write SetGroupNameCaption;
    property GroupEditStyle   : TiOPCGroupEditStyle read FGroupEditStyle     write SetGroupEditStyle;

    property ItemCaption      : String              read GetItemCaption      write SetItemCaption;
    property Item2Caption     : String              read GetItem2Caption     write SetItem2Caption;
    property Item2Visible     : Boolean             read FItem2Visible       write SetItem2Visible;

    property Align;
  end;

implementation

{$IFDEF iVCL} uses  iOPCPropertySelector,  iOPCComputerSelector,  iOPCServerSelector,  iOPCItemSelector,  iOPCGroupSelector;{$ENDIF}
{$IFDEF iCLX} uses QiOPCPropertySelector, QiOPCComputerSelector, QiOPCServerSelector, QiOPCItemSelector, QiOPCGroupSelector;{$ENDIF}
//****************************************************************************************************************************************************
constructor TiOPCBrowserPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FShowProperty    := True;
  FShowAutoError   := True;
  FShowAutoConnect := True;
  FShowGroupName   := True;
  FShowItem        := True;

  {$IFDEF iCLX}
  HandleNeeded;
  {$ENDIF};

  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csReplicatable, csOpaque];

  Width   := 280;
  Height  := 165;

  FOPCItemList := TiComponentEditorListBox.Create(Self);
  with FOPCItemList do
    begin
      Parent     := Self;
      Style      := lbStandard;
      DragMode   := dmAutomatic;
      OnClick    := OPCItemListClick;
      OnItemMove := ItemMoveEvent;
    end;

  FAddItemButton   :=TiComponentEditorButton.Create(Self);with FAddItemButton    do begin Parent:=Self;Caption:='Add';   OnClick:=AddButtonClick;   end;
  FRemoveItemButton:=TiComponentEditorButton.Create(Self);with FRemoveItemButton do begin Parent:=Self;Caption:='Remove';OnClick:=RemoveButtonClick;end;

  FPropertyNameEdit :=TiComponentEditorEdit.Create(Self);with FPropertyNameEdit  do begin Parent:=Self;OnUpdate:=PropertyNameChange;end;
  FGroupNameEdit    :=TiComponentEditorEdit.Create(Self);with FGroupNameEdit     do begin Parent:=Self;OnUpdate:=GroupNameChange;   end;
  FComputerNameEdit :=TiComponentEditorEdit.Create(Self);with FComputerNameEdit  do begin Parent:=Self;OnUpdate:=ComputerNameChange;end;
  FOPCServerNameEdit:=TiComponentEditorEdit.Create(Self);with FOPCServerNameEdit do begin Parent:=Self;OnUpdate:=OPCSeverNameChange;end;
  FItemNameEdit     :=TiComponentEditorEdit.Create(Self);with FItemNameEdit      do begin Parent:=Self;OnUpdate:=ItemNameChange;    end;
  FItem2NameEdit    :=TiComponentEditorEdit.Create(Self);with FItem2NameEdit     do begin Parent:=Self;OnUpdate:=ItemName2Change;   end;
  FScalarEdit       :=TiComponentEditorEdit.Create(Self);with FScalarEdit        do begin Parent:=Self;OnUpdate:=ScalarChange;      end;
  FOffsetEdit       :=TiComponentEditorEdit.Create(Self);with FOffsetEdit        do begin Parent:=Self;OnUpdate:=OffsetChange;      end;
  FScalar2Edit      :=TiComponentEditorEdit.Create(Self);with FScalar2Edit       do begin Parent:=Self;OnUpdate:=ScalarChange;      end;
  FOffset2Edit      :=TiComponentEditorEdit.Create(Self);with FOffset2Edit       do begin Parent:=Self;OnUpdate:=OffsetChange;      end;
  FUpdateRateEdit   :=TiComponentEditorEdit.Create(Self);with FUpdateRateEdit    do begin Parent:=Self;OnUpdate:=UpdateRateChange;  end;

  FAutoConnectCheckBox := TiComponentEditorCheckBox.Create(Self);
  with FAutoConnectCheckBox do
    begin
      Caption    := 'Auto Connect';
      Parent     := Self;
      OnClick    := AutoConnectChange;
    end;

  FAutoErrorCheckBox := TiComponentEditorCheckBox.Create(Self);
  with FAutoErrorCheckBox do
    begin
      Caption    := 'Auto Error';
      Parent     := Self;
      OnClick    := AutoErrorChange;
    end;                                                    

  FPropertyNameEditButton :=TiComponentEditorButton.Create(Self);with FPropertyNameEditButton  do begin Parent:=Self;Caption:='...';OnClick:=PropertyNameEditButtonClick;end;
  FGroupNameEditButton    :=TiComponentEditorButton.Create(Self);with FGroupNameEditButton     do begin Parent:=Self;Caption:='...';OnClick:=GroupNameEditButtonClick;end;
  FComputerNameEditButton :=TiComponentEditorButton.Create(Self);with FComputerNameEditButton  do begin Parent:=Self;Caption:='...';OnClick:=ComputerNameEditButtonClick;end;
  FOPCServerNameEditButton:=TiComponentEditorButton.Create(Self);with FOPCServerNameEditButton do begin Parent:=Self;Caption:='...';OnClick:=OPCSeverNameEditButtonClick;end;
  FItemNameEditButton     :=TiComponentEditorButton.Create(Self);with FItemNameEditButton      do begin Parent:=Self;Caption:='...';OnClick:=ItemNameEditButtonClick;    end;
  FItem2NameEditButton    :=TiComponentEditorButton.Create(Self);with FItem2NameEditButton     do begin Parent:=Self;Caption:='...';OnClick:=ItemName2EditButtonClick;   end;

  FPropertyLabel  :=TLabel.Create(Self);with FPropertyLabel   do begin Parent:=Self;Caption:='Property';   AutoSize:=False;Alignment:=taRightJustify;end;
  FGroupLabel     :=TLabel.Create(Self);with FGroupLabel      do begin Parent:=Self;Caption:='Group';      AutoSize:=False;Alignment:=taRightJustify;end;
  FComputerLabel  :=TLabel.Create(Self);with FComputerLabel   do begin Parent:=Self;Caption:='Computer';   AutoSize:=False;Alignment:=taRightJustify;end;
  FOPCServerLabel :=TLabel.Create(Self);with FOPCServerLabel  do begin Parent:=Self;Caption:='OPC Server'; AutoSize:=False;Alignment:=taRightJustify;end;
  FItemNameLabel  :=TLabel.Create(Self);with FItemNameLabel   do begin Parent:=Self;Caption:='Item';       AutoSize:=False;Alignment:=taRightJustify;end;
  FItem2Label     :=TLabel.Create(Self);with FItem2Label      do begin Parent:=Self;Caption:='Item2';      AutoSize:=False;Alignment:=taRightJustify;end;
  FScalarLabel    :=TLabel.Create(Self);with FScalarLabel     do begin Parent:=Self;Caption:='Scalar';     AutoSize:=False;Alignment:=taRightJustify;end;
  FOffsetLabel    :=TLabel.Create(Self);with FOffsetLabel     do begin Parent:=Self;Caption:='Offset';     AutoSize:=False;Alignment:=taRightJustify;end;
  FScalar2Label   :=TLabel.Create(Self);with FScalar2Label    do begin Parent:=Self;Caption:='Scalar(Y)';  AutoSize:=False;Alignment:=taRightJustify;end;
  FOffset2Label   :=TLabel.Create(Self);with FOffset2Label    do begin Parent:=Self;Caption:='Offset(Y)';  AutoSize:=False;Alignment:=taRightJustify;end;
  FUpdateRateLabel:=TLabel.Create(Self);with FUpdateRateLabel do begin Parent:=Self;Caption:='Update Rate';AutoSize:=False;Alignment:=taRightJustify;end;
  FErrorLabel     :=TLabel.Create(Self);with FErrorLabel      do begin Parent:=Self;Caption:='';           AutoSize:=False;Alignment:=taCenter; Font.Color:=clRed; Font.Style:= [fsbold];end;
  FEvaluationLabel:=TLabel.Create(Self);with FEvaluationLabel do begin Parent:=Self;Caption:='';           AutoSize:=False;Alignment:=taCenter; Font.Color:=clBlue;Font.Style:= [fsbold];end;

  FSessionHandle := OPCDLLEditorSessionStart;
end;
//****************************************************************************************************************************************************
destructor TiOPCBrowserPanel.Destroy;
begin
  OPCDLLEditorSessionStop(FSessionHandle);
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.Loaded;
begin
  inherited;
  AdjustLayout;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.AdjustLayout;
var
  LabelMaxWidth : Integer;
  LabelLeftRef  : Integer;
  EditLeftRef   : Integer;
  EditWidth     : Integer;
begin
  FOPCItemList.Top         := 8;
  FOPCItemList.Left        := 8;
  FOPCItemList.Height      := Height - 8 - FAddItemButton.Height - 10;

  FGroupNameEditButton.Width := 0;

  if FShowProperty then
    begin
      FOPCItemList.Width       := Width div 3;

      FAddItemButton.Width     := (FOPCItemList.Width div 11)*5;
      FRemoveItemButton.Width  := FAddItemButton.Width;

      FPropertyNameEdit.Width  := FGroupNameEdit.Height;

      FAddItemButton.Left      := FOPCItemList.Left;
      FRemoveItemButton.Left   := FOPCItemList.Left + FOPCItemList.Width - FRemoveItemButton.Width;

      FAddItemButton.Top       := FOPCItemList.Top + FOPCItemList.Height + 5;
      FRemoveItemButton.Top    := FAddItemButton.Top;
    end
  else
    begin
      FOPCItemList.Width            := 0;
      FAddItemButton.Width          := 0;
      FRemoveItemButton.Width       := 0;

      FPropertyNameEdit.Width       := 0;
      FPropertyLabel.Width          := 0;
      FPropertyNameEditButton.Width := 0;
    end;


  if not FItem2Visible then
    begin
      FItem2Label.Width          := 0;
      FItem2NameEdit.Width       := 0;
      FItem2NameEditButton.Width := 0;

      FScalar2Edit.Width         := 0;
      FScalar2Label.Width        := 0;
      FOffset2Edit.Width         := 0;
      FOffset2Label.Width        := 0;

      FScalarLabel.Caption       := 'Scalar';
      FOffsetLabel.Caption       := 'Offset';
    end
  else
    begin
      FScalarLabel.Caption       := 'Scalar(X)';
      FOffsetLabel.Caption       := 'Offset(X)';
    end;

  if not FShowGroupName then
    begin
      FGroupLabel.Width          := 0;
      FGroupNameEdit.Width       := 0;
      FGroupNameEditButton.Width := 0;
    end;

  if not FShowItem then
    begin
      FItemNameLabel.Width      := 0;
      FItemNameEdit.Width       := 0;
      FItemNameEditButton.Width := 0;
    end;

  LabelMaxWidth := 0;

  if FShowProperty then if Canvas.TextWidth(FPropertyLabel.Caption  ) > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FPropertyLabel.Caption);
                        if Canvas.TextWidth(FGroupLabel.Caption     ) > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FGroupLabel.Caption);
                        if Canvas.TextWidth(FComputerLabel.Caption  ) > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FComputerLabel.Caption);
                        if Canvas.TextWidth(FOPCServerLabel.Caption ) > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FOPCServerLabel.Caption);
  if FShowItem     then if Canvas.TextWidth(FItemNameLabel.Caption  ) > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FItemNameLabel.Caption);
  if FItem2Visible then if Canvas.TextWidth(FItem2Label.Caption     ) > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FItem2Label.Caption);
                        if Canvas.TextWidth(FUpdateRateLabel.Caption) > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FUpdateRateLabel.Caption);

  if FShowProperty then LabelLeftRef := FOPCItemList.Left + FOPCItemList.Width + 10
  else                  LabelLeftRef := 5;

  FPropertyLabel.Left        := LabelLeftRef;
  FGroupLabel.Left           := LabelLeftRef;
  FComputerLabel.Left        := LabelLeftRef;
  FOPCServerLabel.Left       := LabelLeftRef;
  FItemNameLabel.Left        := LabelLeftRef;
  FItem2Label.Left           := LabelLeftRef;
  FUpdateRateLabel.Left      := LabelLeftRef;

  if FShowProperty  then FPropertyLabel.Width   := LabelMaxWidth;
  if FShowGroupName then FGroupLabel.Width      := LabelMaxWidth;
                         FComputerLabel.Width   := LabelMaxWidth;
                         FOPCServerLabel.Width  := LabelMaxWidth;
  if FShowItem      then FItemNameLabel.Width   := LabelMaxWidth;
  if FItem2Visible  then FItem2Label.Width      := LabelMaxWidth;
                         FUpdateRateLabel.Width := LabelMaxWidth;

  EditLeftRef := LabelLeftRef + LabelMaxWidth + 5;

  FPropertyNameEdit.Left     := EditLeftRef;
  FGroupNameEdit.Left        := EditLeftRef;
  FComputerNameEdit.Left     := EditLeftRef;
  FOPCServerNameEdit.Left    := EditLeftRef;
  FItemNameEdit.Left         := EditLeftRef;
  FItem2NameEdit.Left        := EditLeftRef;
  FUpdateRateEdit.Left       := EditLeftRef;
  FAutoConnectCheckBox.Left  := LabelLeftRef + 10;
  FAutoErrorCheckBox.Left    := LabelLeftRef + 10;

  EditWidth                  := Width - EditLeftRef - 10 - FPropertyNameEdit.Height;

  if FShowProperty    then FPropertyNameEdit.Width    := EditWidth;
  if FShowGroupName   then FGroupNameEdit.Width       := EditWidth;
                           FComputerNameEdit.Width    := EditWidth;
                           FOPCServerNameEdit.Width   := EditWidth;
  if FShowItem        then FItemNameEdit.Width        := EditWidth;

  if FItem2Visible    then
    begin
      FItem2NameEdit.Width := EditWidth;
      FScalar2Edit.Width   := 60;
      FOffset2Edit.Width   := 60;
    end;
                           FUpdateRateEdit.Width      := EditWidth;
  if FShowAutoConnect then FAutoConnectCheckBox.Width := 120 else FAutoConnectCheckBox.Width := 0;
  if FShowAutoError   then FAutoErrorCheckBox.Width   := 120 else FAutoErrorCheckBox.Width   := 0;

  if FShowProperty then
    begin
      FPropertyNameEdit.Top      := FOPCItemList.Top;
      FGroupNameEdit.Top         := FPropertyNameEdit.Top    + FPropertyNameEdit.Height + 2;
    end
  else
    begin
      FGroupNameEdit.Top         := FOPCItemList.Top;
    end;

  FComputerNameEdit.Top      := FGroupNameEdit.Top       + FPropertyNameEdit.Height + 1;
  FOPCServerNameEdit.Top     := FComputerNameEdit.Top    + FPropertyNameEdit.Height + 1;
  FUpdateRateEdit.Top        := FOPCServerNameEdit.Top   + FPropertyNameEdit.Height + 1;
  FItemNameEdit.Top          := FUpdateRateEdit.Top      + FPropertyNameEdit.Height + 1;
  FItem2NameEdit.Top         := FItemNameEdit.Top        + FPropertyNameEdit.Height + 1;
  FAutoConnectCheckBox.Top   := FItem2NameEdit.Top       + FPropertyNameEdit.Height + 5;
  FAutoErrorCheckBox.Top     := FAutoConnectCheckBox.Top + FAutoConnectCheckBox.Height + 3;

  FPropertyLabel.Top         := FPropertyNameEdit.Top  + 4;
  FGroupLabel.Top            := FGroupNameEdit.Top     + 4;
  FComputerLabel.Top         := FComputerNameEdit.Top  + 4;
  FOPCServerLabel.Top        := FOPCServerNameEdit.Top + 4;
  FItemNameLabel.Top         := FItemNameEdit.Top      + 4;
  FItem2Label.Top            := FItem2NameEdit.Top     + 4;
  FUpdateRateLabel.Top       := FUpdateRateEdit.Top    + 4;

  if FShowAutoError then
    FErrorLabel.Top          := FAutoErrorCheckBox.Top     + FAutoErrorCheckBox.Height   + 10
  else
    FErrorLabel.Top          := FAutoConnectCheckBox.Top   + FAutoConnectCheckBox.Height + 10;

  FErrorLabel.Width          := FAutoConnectCheckBox.Width + FPropertyLabel.Width;
  FErrorLabel.Left           := FPropertyLabel.Left;

  FEvaluationLabel.Top       := FErrorLabel.Top + FErrorLabel.Height + 5;
  FEvaluationLabel.Width     := FAutoConnectCheckBox.Width + FPropertyLabel.Width;
  FEvaluationLabel.Left      := FPropertyLabel.Left;

  if FShowProperty then
    with FPropertyNameEditButton do
      begin
        Top    := FPropertyNameEdit.Top;
        Height := FPropertyNameEdit.Height;
        Width  := FPropertyNameEdit.Height;
        Left   := FPropertyNameEdit.Left + FPropertyNameEdit.Width;
      end;

  if FShowGroupName and (FGroupEditStyle = iopcgesSelectFromList) then
    with FGroupNameEditButton do
      begin
        Top    := FGroupNameEdit.Top;
        Height := FGroupNameEdit.Height;
        Width  := FGroupNameEdit.Height;
        Left   := FGroupNameEdit.Left + FGroupNameEdit.Width;
      end;

  with FOPCServerNameEditButton do
    begin
      Top    := FOPCServerNameEdit.Top;
      Height := FOPCServerNameEdit.Height;
      Width  := FOPCServerNameEdit.Height;
      Left   := FOPCServerNameEdit.Left + FOPCServerNameEdit.Width;
    end;

  if FShowItem then
    with FItemNameEditButton do
      begin
        Top    := FItemNameEdit.Top;
        Height := FItemNameEdit.Height;
        Width  := FItemNameEdit.Height;
        Left   := FItemNameEdit.Left + FItemNameEdit.Width;
      end;

  if Item2Visible then
    with FItem2NameEditButton do
      begin
        Top    := FItem2NameEdit.Top;
        Height := FItem2NameEdit.Height;
        Width  := FItem2NameEdit.Height;
        Left   := FItem2NameEdit.Left + FItem2NameEdit.Width;
      end;

  with FComputerNameEditButton do
    begin
      Top    := FComputerNameEdit.Top;
      Height := FComputerNameEdit.Height;
      Width  := FComputerNameEdit.Height;
      Left   := FComputerNameEdit.Left + FComputerNameEdit.Width;
    end;

  LabelMaxWidth := 0;

  if not Item2Visible then
    begin
      if Canvas.TextWidth(FScalarLabel.Caption) > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FScalarLabel.Caption);
      if Canvas.TextWidth(FOffsetLabel.Caption) > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FOffsetLabel.Caption);

      FScalarLabel.Width := LabelMaxWidth;
      FOffsetLabel.Width := LabelMaxWidth;

      with FScalarEdit do
        begin
          Top    := FAutoConnectCheckBox.Top -3;
          Width  := 60;
          Left   := FItemNameEdit.Left + FItemNameEdit.Width - FScalarEdit.Width;
        end;
      with FOffsetEdit do
        begin
          Top    := FScalarEdit.Top + FScalarEdit.Height + 2;
          Width  := 60;
          Left   := FScalarEdit.Left;
        end;

      FScalarLabel.Left := FScalarEdit.Left - LabelMaxWidth -5; FScalarLabel.Top := FScalarEdit.Top + 4;
      FOffsetLabel.Left := FScalarLabel.Left;                   FOffsetLabel.Top := FOffsetEdit.Top + 4;
    end
  else
    begin
      if Canvas.TextWidth(FScalarLabel.Caption)  > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FScalarLabel.Caption);
      if Canvas.TextWidth(FOffsetLabel.Caption)  > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FOffsetLabel.Caption);
      if Canvas.TextWidth(FScalar2Label.Caption) > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FScalar2Label.Caption);
      if Canvas.TextWidth(FOffset2Label.Caption) > LabelMaxWidth then LabelMaxWidth := Canvas.TextWidth(FOffset2Label.Caption);

      FScalarLabel.Width  := LabelMaxWidth;
      FOffsetLabel.Width  := LabelMaxWidth;
      FScalar2Label.Width := LabelMaxWidth;
      FOffset2Label.Width := LabelMaxWidth;

      with FScalar2Edit do
        begin
          Top    := FAutoConnectCheckBox.Top -3;
          Left   := FItemNameEdit.Left + FItemNameEdit.Width - FScalar2Edit.Width;
        end;
      with FOffset2Edit do
        begin
          Top    := FScalar2Edit.Top + FScalar2Edit.Height + 2;
          Left   := FScalar2Edit.Left;
        end;

      FScalar2Label.Left := FScalar2Edit.Left - LabelMaxWidth -5; FScalar2Label.Top := FScalar2Edit.Top + 4;
      FOffset2Label.Left := FScalar2Label.Left;                   FOffset2Label.Top := FOffset2Edit.Top + 4;

      with FScalarEdit do
        begin
          Top    := FScalar2Edit.Top;
          Width  := 60;
          Left   := FScalar2Label.Left - 10 - FScalarEdit.Width;
        end;
      with FOffsetEdit do
        begin
          Top    := FOffset2Edit.Top;
          Width  := 60;
          Left   := FScalarEdit.Left;
        end;

      FScalarLabel.Left := FScalarEdit.Left - LabelMaxWidth -5; FScalarLabel.Top := FScalar2Label.Top;
      FOffsetLabel.Left := FScalarLabel.Left;                   FOffsetLabel.Top := FOffset2Label.Top;
    end
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.PropertyNameChange(Sender: TObject);
begin
  ItemChange;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.ComputerNameChange(Sender: TObject);
begin
  SetDefaults('ComputerName', FComputerNameEdit.AsString);
  ItemChange;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.GroupNameChange(Sender: TObject);
begin
  SetDefaults('GroupName', FGroupNameEdit.AsString);

//  if Trim(FGroupNameEdit.AsString) <> '' then  FItemNameEdit.Clear;

  ItemChange;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.OPCSeverNameChange(Sender: TObject);
begin
  SetDefaults('ServerName', FOPCServerNameEdit.AsString);

  ItemChange;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.ItemNameChange(Sender: TObject);
begin
  ItemChange;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.ItemName2Change(Sender: TObject);
begin
  ItemChange;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.ScalarChange(Sender: TObject);
begin
  ItemChange;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.OffsetChange(Sender: TObject);
begin
  ItemChange;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.UpdateRateChange(Sender: TObject);
begin
  SetDefaults('UpdateRate', FUpdateRateEdit.AsString);
  ItemChange;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.AutoConnectChange(Sender: TObject);
begin
  ItemChange;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.AutoErrorChange(Sender: TObject);
begin
  ItemChange;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.Resize;
begin
  inherited Resize;
  if Assigned(FOPCItemList) then AdjustLayout;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.OPCItemListClick(Sender: TObject);
begin
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.PropertyNameEditButtonClick(Sender: TObject);
begin
  if not Assigned(FPersistent) then raise Exception.Create('Class not Defined');

  Screen.Cursor := crHourGlass;
  try
    iOPCPropertySelectorForm := TiOPCPropertySelectorForm.Create(Application);
    try
      iOPCPropertySelectorForm.Setup(FPersistent, '');
      iOPCPropertySelectorForm.AddUnassigned;
      iOPCPropertySelectorForm.PropertyName := FPropertyNameEdit.Text;
      if iOPCPropertySelectorForm.ShowModal = mrOK then
        begin
          FPropertyNameEdit.SetStringWithEvent(iOPCPropertySelectorForm.PropertyName);
          FOPCItemList.Items.Strings[FOPCItemList.ItemIndex] := iOPCPropertySelectorForm.PropertyName;
        end;
    finally
      iOPCPropertySelectorForm.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.GroupNameEditButtonClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    iOPCGroupSelectorForm := TiOPCGroupSelectorForm.Create(Application);
    try
      iOPCGroupSelectorForm.Setup;
      iOPCGroupSelectorForm.GroupName := FGroupNameEdit.AsString;
      if iOPCGroupSelectorForm.ShowModal = mrOK then
        begin
          FGroupNameEdit.SetStringWithEvent(iOPCGroupSelectorForm.GroupName);
        end;
    finally
      iOPCGroupSelectorForm.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.ComputerNameEditButtonClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    iOPCComputerSelectorForm := TiOPCComputerSelectorForm.Create(Application);
    try
      iOPCComputerSelectorForm.SessionHandle := FSessionHandle;
      iOPCComputerSelectorForm.Setup;
      iOPCComputerSelectorForm.ComputerName := FComputerNameEdit.Text;
      if iOPCComputerSelectorForm.ShowModal = mrOK then
        begin
          FComputerNameEdit.SetStringWithEvent(iOPCComputerSelectorForm.ComputerName);
        end;
    finally
      iOPCComputerSelectorForm.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.OPCSeverNameEditButtonClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
  iOPCServerSelectorForm := TiOPCServerSelectorForm.Create(Application);
    try
      iOPCServerSelectorForm.SessionHandle := FSessionHandle;
      iOPCServerSelectorForm.Setup(FComputerNameEdit.Text);
      iOPCServerSelectorForm.ServerName := FOPCServerNameEdit.Text;
      if iOPCServerSelectorForm.ShowModal = mrOK then
        begin
          FOPCServerNameEdit.SetStringWithEvent(iOPCServerSelectorForm.ServerName);
        end;
    finally
      iOPCServerSelectorForm.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.ItemNameEditButtonClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    iOPCItemSelectorForm := TiOPCItemSelectorForm.Create(Application);
    try
      iOPCItemSelectorForm.SessionHandle := FSessionHandle;
      iOPCItemSelectorForm.Setup(FComputerNameEdit.Text, FOPCServerNameEdit.Text);
      iOPCItemSelectorForm.OPCItemName.Caption := FItemNameEdit.Text;
      if iOPCItemSelectorForm.ShowModal = mrOK then
        begin
          FItemNameEdit.SetStringWithEvent(iOPCItemSelectorForm.OPCItemName.Caption);
        end;
    finally
      iOPCItemSelectorForm.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.ItemName2EditButtonClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    iOPCItemSelectorForm := TiOPCItemSelectorForm.Create(Application);
    try
      iOPCItemSelectorForm.SessionHandle := FSessionHandle;
      iOPCItemSelectorForm.Setup(FComputerNameEdit.Text, FOPCServerNameEdit.Text);
      iOPCItemSelectorForm.OPCItemName.Caption := FItem2NameEdit.Text;
      if iOPCItemSelectorForm.ShowModal = mrOK then
        begin
          FItem2NameEdit.SetStringWithEvent(iOPCItemSelectorForm.OPCItemName.Caption);
        end;
    finally
      iOPCItemSelectorForm.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.UpdateItemEdit;
var
  iOPCItem    : TiOPCItem;
  GroupHandle : Integer;
begin
  FErrorLabel.Caption      := '';
  FEvaluationLabel.Caption := '';

  if      OPCDLLNotLoaded    then FErrorLabel.Caption      := 'Iocomp OPC DLL Missing'
  else if OPCDLLIsEvaluation then FEvaluationLabel.Caption := 'Iocomp OPC Evaluation';
  
  if (FOPCItemList.ItemIndex = - 1) or (FOPCItemList.Items.Count = 0) then //0 Check required for Delphi4
    begin
      FOPCItemList.Enabled      := False;
      FRemoveItemButton.Enabled := False;

      FPropertyNameEdit.Disable;
      FGroupNameEdit.Disable;
      FComputerNameEdit.Disable;
      FOPCServerNameEdit.Disable;
      FItemNameEdit.Disable;
      FScalarEdit.Disable;
      FOffsetEdit.Disable;
      FItem2NameEdit.Disable;
      FScalar2Edit.Disable;
      FOffset2Edit.Disable;
      FAutoConnectCheckBox.Disable;
      FAutoErrorCheckBox.Disable;
      FUpdateRateEdit.Disable;

      FPropertyNameEditButton.Enabled  := False;
      FComputerNameEditButton.Enabled  := False;
      FOPCServerNameEditButton.Enabled := False;
      FItemNameEditButton.Enabled      := False;
      FItem2NameEditButton.Enabled     := False;
      FGroupNameEditButton.Enabled     := False;
    end
  else
    begin
      FOPCItemList.Enabled      := True;
      FRemoveItemButton.Enabled := True;

      FPropertyNameEdit.Disable;
      FGroupNameEdit.Disable;
      FComputerNameEdit.Enable;
      FOPCServerNameEdit.Enable;
      FItemNameEdit.Enable;
      FScalarEdit.Enable;
      FOffsetEdit.Enable;
      FItem2NameEdit.Enable;
      FScalar2Edit.Enable;
      FOffset2Edit.Enable;
      FAutoConnectCheckBox.Enable;
      FAutoErrorCheckBox.Enable;
      FUpdateRateEdit.Enable;

      FPropertyNameEditButton.Enabled  := True;
      FComputerNameEditButton.Enabled  := True;
      FOPCServerNameEditButton.Enabled := True;
      FItemNameEditButton.Enabled      := True;
      FItem2NameEditButton.Enabled     := True;
      FGroupNameEditButton.Enabled     := True;

      iOPCItem := FOPCItemList.Items.Objects[FOPCItemList.ItemIndex] as TiOPCItem;

      FPropertyNameEdit.AsString     := iOPCItem.PropertyName;
      FGroupNameEdit.AsString        := iOPCItem.GroupName;
      FComputerNameEdit.AsString     := iOPCItem.ComputerName;
      FOPCServerNameEdit.AsString    := iOPCItem.ServerName;
      FItemNameEdit.AsString         := iOPCItem.ItemName;
      FUpdateRateEdit.AsInteger      := iOPCItem.UpdateRate;
      FScalarEdit.AsFloat            := iOPCItem.Scalar;
      FOffsetEdit.AsFloat            := iOPCItem.Offset;
      FAutoConnectCheckBox.AsBoolean := iOPCItem.AutoConnect;
      FAutoErrorCheckBox.AsBoolean   := iOPCItem.AutoError;

      if FGroupEditStyle = iopcgesEdit then
        begin
          FComputerNameEdit.Enable;      FComputerNameEditButton.Enabled  := True;
          FOPCServerNameEdit.Enable;     FOPCServerNameEditButton.Enabled := True;
          FUpdateRateEdit.Enabled;
          FGroupNameEdit.Enable;
        end
      else
        begin
          if Trim(FGroupNameEdit.AsString) = '' then
            begin
              FComputerNameEdit.Enable;      FComputerNameEditButton.Enabled  := True;
              FOPCServerNameEdit.Enable;     FOPCServerNameEditButton.Enabled := True;
              FUpdateRateEdit.Enabled;
              FGroupNameEdit.DisableNoClear;
            end
          else
            begin
              FComputerNameEdit.Disable;     FComputerNameEditButton.Enabled  := False;
              FOPCServerNameEdit.Disable;    FOPCServerNameEditButton.Enabled := False;
              FUpdateRateEdit.Disable;
              FGroupNameEdit.DisableNoClear;

              if not OPCDLLNotLoaded then
                begin
                  GroupHandle := OPCDLLGroupGetHandleByName(PChar(FGroupNameEdit.AsString));
                  if GroupHandle <> 0 then
                    begin
                      FErrorLabel.Caption         := '';
                      FComputerNameEdit.AsString  := OPCDLLGroupGetComputerName(GroupHandle);
                      FOPCServerNameEdit.AsString := OPCDLLGroupGetOPCServerName(GroupHandle);
                      FUpdateRateEdit.AsInteger   := OPCDLLGroupGetUpdateRate(GroupHandle);
                    end
                  else FErrorLabel.Caption := 'Group Not Found';
                end;
            end;
        end;

      if FOPCServerNameEdit.AsString = '' then
        begin
          FItemNameEdit.DisableNoClear;
          FItem2NameEdit.DisableNoClear;
          FItemNameEditButton.Enabled  := False;
          FItem2NameEditButton.Enabled := False;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.ItemChange;
var
  iOPCItem : TiOPCItem;
begin
  if (FOPCItemList.ItemIndex <> -1) and (FOPCItemList.Items.Count <> 0) then //0 check required for Delphi4
    begin
      iOPCItem := FOPCItemList.Items.Objects[FOPCItemList.ItemIndex] as TiOPCItem;

      iOPCItem.PropertyName := FPropertyNameEdit.AsString;
      iOPCItem.GroupName    := FGroupNameEdit.AsString;
      iOPCItem.ComputerName := FComputerNameEdit.AsString;
      iOPCItem.ServerName   := FOPCServerNameEdit.AsString;
      iOPCItem.ItemName     := FItemNameEdit.AsString;
      iOPCItem.Scalar       := FScalarEdit.AsFloat;
      iOPCItem.Offset       := FOffsetEdit.AsFloat;
      iOPCItem.UpdateRate   := FUpdateRateEdit.AsInteger;
      iOPCItem.AutoConnect  := FAutoConnectCheckBox.AsBoolean;
      iOPCItem.AutoError    := FAutoErrorCheckBox.AsBoolean;
    end;

  if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
  if Assigned(FOnChange) then FOnChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetPropertyName(Index:Integer;Value:String );begin(FOPCItemList.Items.Objects[Index]as TiOPCItem).PropertyName:=Value;FOPCItemList.Items.Strings[Index]:=Value;end;
procedure TiOPCBrowserPanel.SetGroupName   (Index:Integer;Value:String );begin(FOPCItemList.Items.Objects[Index]as TiOPCItem).GroupName   :=Value;end;
procedure TiOPCBrowserPanel.SetComputerName(Index:Integer;Value:String );begin(FOPCItemList.Items.Objects[Index]as TiOPCItem).ComputerName:=Value;end;
procedure TiOPCBrowserPanel.SetServerName  (Index:Integer;Value:String );begin(FOPCItemList.Items.Objects[Index]as TiOPCItem).ServerName  :=Value;end;
procedure TiOPCBrowserPanel.SetItemName    (Index:Integer;Value:String );begin(FOPCItemList.Items.Objects[Index]as TiOPCItem).ItemName    :=Value;end;
procedure TiOPCBrowserPanel.SetItem2Name   (Index:Integer;Value:String );begin FItem2NameEdit.Text                                        :=Value;end;
procedure TiOPCBrowserPanel.SetScalar      (Index:Integer;Value:Double );begin(FOPCItemList.Items.Objects[Index]as TiOPCItem).Scalar      :=Value;end;
procedure TiOPCBrowserPanel.SetOffset      (Index:Integer;Value:Double );begin(FOPCItemList.Items.Objects[Index]as TiOPCItem).Offset      :=Value;end;
procedure TiOPCBrowserPanel.SetScalar2     (Index:Integer;Value:Double );begin FScalar2Edit.AsFloat                                       :=Value;end;
procedure TiOPCBrowserPanel.SetOffset2     (Index:Integer;Value:Double );begin FOffset2Edit.AsFloat                                       :=Value;end;
procedure TiOPCBrowserPanel.SetUpdateRate  (Index:Integer;Value:Integer);begin(FOPCItemList.Items.Objects[Index]as TiOPCItem).UpdateRate  :=Value;end;
procedure TiOPCBrowserPanel.SetAutoConnect (Index:Integer;Value:Boolean);begin(FOPCItemList.Items.Objects[Index]as TiOPCItem).AutoConnect :=Value;end;
procedure TiOPCBrowserPanel.SetAutoError   (Index:Integer;Value:Boolean);begin(FOPCItemList.Items.Objects[Index]as TiOPCItem).AutoError   :=Value;end;
//****************************************************************************************************************************************************
function TiOPCBrowserPanel.GetPropertyName(Index:Integer):String; begin Result:=(FOPCItemList.Items.Objects[Index]as TiOPCItem).PropertyName;end;
function TiOPCBrowserPanel.GetGroupName   (Index:Integer):String; begin Result:=(FOPCItemList.Items.Objects[Index]as TiOPCItem).GroupName;   end;
function TiOPCBrowserPanel.GetComputerName(Index:Integer):String; begin Result:=(FOPCItemList.Items.Objects[Index]as TiOPCItem).ComputerName;end;
function TiOPCBrowserPanel.GetServerName  (Index:Integer):String; begin Result:=(FOPCItemList.Items.Objects[Index]as TiOPCItem).ServerName;  end;
function TiOPCBrowserPanel.GetUpdateRate  (Index:Integer):Integer;begin Result:=(FOPCItemList.Items.Objects[Index]as TiOPCItem).UpdateRate;  end;
function TiOPCBrowserPanel.GetItemName    (Index:Integer):String; begin Result:=(FOPCItemList.Items.Objects[Index]as TiOPCItem).ItemName;    end;
function TiOPCBrowserPanel.GetItem2Name   (Index:Integer):String; begin Result:=FItem2NameEdit.Text;                                         end;
function TiOPCBrowserPanel.GetScalar      (Index:Integer):Double; begin Result:=(FOPCItemList.Items.Objects[Index]as TiOPCItem).Scalar;      end;
function TiOPCBrowserPanel.GetOffset      (Index:Integer):Double; begin Result:=(FOPCItemList.Items.Objects[Index]as TiOPCItem).Offset;      end;
function TiOPCBrowserPanel.GetScalar2     (Index:Integer):Double; begin Result:=FScalar2Edit.AsFloat;                                        end;
function TiOPCBrowserPanel.GetOffset2     (Index:Integer):Double; begin Result:=FOffset2Edit.AsFloat;                                        end;
function TiOPCBrowserPanel.GetAutoConnect (Index:Integer):Boolean;begin Result:=(FOPCItemList.Items.Objects[Index]as TiOPCItem).AutoConnect; end;
function TiOPCBrowserPanel.GetAutoError   (Index:Integer):Boolean;begin Result:=(FOPCItemList.Items.Objects[Index]as TiOPCItem).AutoError;   end;
//****************************************************************************************************************************************************
function TiOPCBrowserPanel.AddItem: Integer;
var
  OPCItem : TiOPCItem;
begin
  OPCItem := TiOPCItem.Create;
  Result := FOPCItemList.Items.AddObject('', OPCItem);
  FOPCItemList.ItemIndex := Result;
end;
//****************************************************************************************************************************************************
function TiOPCBrowserPanel.ItemCount: Integer;
begin
  Result := FOPCItemList.Items.Count;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.RemoveAllItems;
begin
  while FOPCItemList.Items.Count <> 0 do
    begin
      FOPCItemList.Items.Objects[0].Free;
      FOPCItemList.Items.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.AddButtonClick(Sender: TObject);
var
  OPCItem : TiOPCItem;
  Index   : Integer;
begin
  if not Assigned(FPersistent) then raise Exception.Create('Class not Defined');

  Screen.Cursor := crHourGlass;
  try
    iOPCPropertySelectorForm := TiOPCPropertySelectorForm.Create(Application);
    try
      iOPCPropertySelectorForm.Setup(FPersistent, '');
      iOPCPropertySelectorForm.AddUnassigned;
      iOPCPropertySelectorForm.PropertyName := FPropertyNameEdit.Text;
      if iOPCPropertySelectorForm.ShowModal = mrOK then
        begin
          OPCItem := TiOPCItem.Create;
          GetDefaults(OPCItem);
          Index := FOPCItemList.Items.AddObject('', OPCItem);
          SetPropertyName(Index, iOPCPropertySelectorForm.PropertyName);
          FOPCItemList.ItemIndex := Index;
        end;
    finally
      iOPCPropertySelectorForm.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
  UpdateItemEdit;
  ItemChange;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.RemoveButtonClick(Sender: TObject);
var
  AOldIndex : Integer;
begin
  if FOPCItemList.ItemIndex <> - 1 then
    begin
      AOldIndex := FOPCItemList.ItemIndex;
      FOPCItemList.DeleteSelectedObject;
      if AOldIndex > FOPCItemList.Items.Count -1 then FOPCItemList.ItemIndex := FOPCItemList.Items.Count-1
      else                                            FOPCItemList.ItemIndex := AOldIndex;
      UpdateItemEdit;
      ItemChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.GetDefaults(OPCItem: TiOPCItem);
{$ifdef iVCL}
var
  Registry : TRegistry;
  AString  : String;
{$endif}
begin
{$ifdef iVCL}
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKey('SOFTWARE\Iocomp\OPC',False) then
      begin
        OPCItem.ComputerName := Registry.ReadString('ComputerName');
        OPCItem.ServerName   := Registry.ReadString('ServerName');

        AString := Registry.ReadString('UpdateRate');
        if AString <> '' then OPCItem.UpdateRate := StrToInt(AString);
      end;
  finally
    Registry.Free;
  end;
{$endif}
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetDefaults(PropertyName, PropertyData: String);
{$ifdef iVCL}
var
  Registry : TRegistry;
{$endif}
begin
{$ifdef iVCL}
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKey('SOFTWARE\Iocomp\OPC',True) then
      begin
        Registry.WriteString(PropertyName, PropertyData);
      end;
  finally
    Registry.Free;
  end;
{$endif}
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.ItemMoveEvent(Sender: TObject);
begin
  if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetShowProperty(const Value: Boolean);
begin
  if FShowProperty <> Value then
    begin
      FShowProperty := Value;
      AdjustLayout;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetShowGroupName(const Value: Boolean);
begin
  if FShowGroupName <> Value then
    begin
      FShowGroupName := Value;
      AdjustLayout;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetShowItem(const Value: Boolean);
begin
  if FShowItem <> Value then
    begin
      FShowItem := Value;
      AdjustLayout;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetShowAutoError(const Value: Boolean);
begin
  if FShowAutoError <> Value then
    begin
      FShowAutoError := Value;
      AdjustLayout;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetShowAutoConnect(const Value: Boolean);
begin
  if FShowAutoConnect <> Value then
    begin
      FShowAutoConnect := Value;
      AdjustLayout;
    end;
end;
//****************************************************************************************************************************************************
function TiOPCBrowserPanel.GetItem2Caption: String;
begin
  Result := FItem2Label.Caption;
end;
//****************************************************************************************************************************************************
function TiOPCBrowserPanel.GetItemCaption: String;
begin
  Result := FItemNameLabel.Caption;
end;
//****************************************************************************************************************************************************
function TiOPCBrowserPanel.GetGroupNameCaption: String;
begin
  Result := FGroupLabel.Caption;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetItem2Caption(const Value: String);
begin
  FItem2Label.Caption := Value;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetItem2Visible(const Value: Boolean);
begin
  FItem2Visible := Value;
  AdjustLayout;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetItemCaption(const Value: String);
begin
  FItemNameLabel.Caption := Value;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetGroupNameCaption(const Value: String);
begin
  FGroupLabel.Caption := Value;
end;
//****************************************************************************************************************************************************
procedure TiOPCBrowserPanel.SetGroupEditStyle(const Value: TiOPCGroupEditStyle);
begin
  if FGroupEditStyle <> Value then
    begin
      FGroupEditStyle := Value;
      AdjustLayout;
    end;
end;
//****************************************************************************************************************************************************
end.


