{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System(tm) COMPONENT SUITE                  }
{                                                                   }
{       Copyright (C) 1998-2009 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPrnDlg;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, ExtCtrls, StdCtrls, Menus, Buttons, ImgList, dxPSForm, dxPSESys, 
  dxPSGlbl, dxPgsDlg, dxPrnDev, dxExtCtrls, dxCore;
             
type
  TdxPageNumbers = (pnAll, pnEven, pnOdd);
  TdxPageRanges = (prAll, prCurrent, prRange, prSelection);
  TdxPrintDlgButtonKind = (pdbPrinterProperties, pdbNetwork, pdbPreview, 
    pdbPageSetup, pdbDefineStyles, pdbStyleOptions, pdbHelp);
  TdxPrintDlgButtons = set of TdxPrintDlgButtonKind;
  TdxPrintDlgOption = (pdoPrintToFile, pdoAllPages, pdoCurrentPage, pdoSelection, 
    pdoPageRange, pdoPrintStyles);
  TdxPrintDlgOptions = set of TdxPrintDlgOption;

const
  pdbAll = [Low(TdxPrintDlgButtonKind)..High(TdxPrintDlgButtonKind)];
  pdbDefault = [pdbPrinterProperties, pdbNetwork, pdbPreview, pdbPageSetup, pdbDefineStyles, pdbStyleOptions];

  pdoAll = [Low(TdxPrintDlgOption)..High(TdxPrintDlgOption)];
  pdoDefaultOptionsEnabled = [pdoPrintToFile, pdoAllPages, pdoPageRange];
  pdoDefaultOptionsVisible = [pdoPrintToFile, pdoAllPages, pdoCurrentPage, pdoPageRange];

type
  TdxPageSetupEvent = procedure(Sender: TObject; var ADone: Boolean;
    APreviewBtnClicked, APrintBtnClicked: PBoolean) of object;

  PdxPrintDlgEvents = ^TdxPrintDlgEvents;
  TdxPrintDlgEvents = record
    OnClose: TNotifyEvent; {called on the OnHide event}
    OnPageSetup: TdxPageSetupEvent;
    OnShow: TNotifyEvent;
  end;

  PdxPrintDialogData = ^TdxPrintDialogData;
  TdxPrintDialogData = record
    Copies: Integer;
    Collate: Boolean;
    FileList: TStrings;
    FileName: string;
    MaxRange: Integer;
    MinRange: Integer;
    PageCount: Integer;
    PageNums: TdxPageNumbers;
    PageRanges: TdxPageRanges;
    Pages: string;
    PrintToFile: Boolean;
    StyleManager: TdxPrintStyleManager;
  end;

  PdxPrintDlgData = ^TdxPrintDlgData;
  TdxPrintDlgData = record
    DialogData: TdxPrintDialogData;
    Title: string;
    HelpContext: THelpContext;
    ButtonsEnabled: TdxPrintDlgButtons;
    ButtonsVisible: TdxPrintDlgButtons;
    OptionsEnabled: TdxPrintDlgOptions;
    OptionsVisible: TdxPrintDlgOptions;
    Events: TdxPrintDlgEvents;
    IsCheckUserInput: Boolean;
    PreviewBtnClicked: Boolean;
  end;

  TdxPrintDialog = class(TComponent)
  private
    FButtonsEnabled: TdxPrintDlgButtons;
    FButtonsVisible: TdxPrintDlgButtons;
    FDialogData: TdxPrintDialogData;
    FHelpContext: THelpContext;
    FIsTitleAssigned: Boolean;
    FOptionsEnabled: TdxPrintDlgOptions;    
    FOptionsVisible: TdxPrintDlgOptions;    
    FPreviewBtnClicked: Boolean;
    FPrintBtnClicked: Boolean;
    FTitle: string;
    FUseFileList: Boolean;
    FOnClose: TNotifyEvent;
    FOnPageSetup: TdxPageSetupEvent;
    FOnShow: TNotifyEvent;
    function GetCollate: Boolean;
    function GetCopies: Integer;
    function GetFileList: TStrings;
    function GetFileName: string;
    function GetMaxRange: Integer;
    function GetMinRange: Integer;
    function GetPageCount: Integer;
    function GetPageNums: TdxPageNumbers;
    function GetPageRanges: TdxPageRanges;
    function GetPages: string;
    function GetPrintToFile: Boolean;
    function GetStyleManager: TdxPrintStyleManager;
    function GetTitle: string;
    function IsTitleStored: Boolean;
    procedure SetCollate(Value: Boolean);
    procedure SetCopies(Value: Integer);
    procedure SetFileList(Value: TStrings);
    procedure SetFileName(const Value: string);
    procedure SetMaxRange(Value: Integer);
    procedure SetMinRange(Value: Integer);
    procedure SetPageCount(Value: Integer);
    procedure SetPageNums(Value: TdxPageNumbers);
    procedure SetPageRanges(Value: TdxPageRanges);
    procedure SetPages(const Value: string);
    procedure SetPrintToFile(Value: Boolean);
    procedure SetStyleManager(Value: TdxPrintStyleManager);
    procedure SetTitle(const Value: string);
    
    procedure ReadIsTitleAssigned(Reader: TReader);
    procedure WriteIsTitleAssigned(Writer: TWriter);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    function DefaultTitle: string; virtual;
    function Execute: Boolean;
    procedure RestoreDefaults; virtual;
    procedure SetMinMaxRanges(AMinRange, AMaxRange: Integer);
    
    property DialogData: TdxPrintDialogData read FDialogData;
    property FileList: TStrings read GetFileList write SetFileList;
    property PageCount: Integer read GetPageCount write SetPageCount;
    property PreviewBtnClicked: Boolean read FPreviewBtnClicked;
    property PrintBtnClicked: Boolean read FPrintBtnClicked;
  published
    property ButtonsEnabled: TdxPrintDlgButtons read FButtonsEnabled write FButtonsEnabled 
      default [pdbPrinterProperties, pdbNetwork, pdbPreview, pdbPageSetup, pdbDefineStyles, pdbStyleOptions];
    property ButtonsVisible: TdxPrintDlgButtons read FButtonsVisible write FButtonsVisible 
      default [pdbPrinterProperties, pdbNetwork, pdbPreview, pdbPageSetup, pdbDefineStyles, pdbStyleOptions];
    property Collate: Boolean read GetCollate write SetCollate default False;
    property Copies: Integer read GetCopies write SetCopies default 1;
    property FileName: string read GetFileName write SetFileName;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property MaxRange: Integer read GetMaxRange write SetMaxRange default 1;
    property MinRange: Integer read GetMinRange write SetMinRange default 1;
    property OptionsEnabled: TdxPrintDlgOptions read FOptionsEnabled write FOptionsEnabled 
      default [pdoPrintToFile, pdoAllPages, pdoPageRange];
    property OptionsVisible: TdxPrintDlgOptions read FOptionsVisible write FOptionsVisible 
      default [pdoPrintToFile, pdoAllPages, pdoCurrentPage, pdoPageRange];
    property PageNums: TdxPageNumbers read GetPageNums write SetPageNums default pnAll;
    property PageRanges: TdxPageRanges read GetPageRanges write SetPageRanges default prAll;
    property Pages: string read GetPages write SetPages;
    property PrintToFile: Boolean read GetPrintToFile write SetPrintToFile default False;
    property StyleManager: TdxPrintStyleManager read GetStyleManager write SetStyleManager;
    property Title: string read GetTitle write SetTitle stored IsTitleStored;
    property UseFileList: Boolean read FUseFileList write FUseFileList default False;

    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnPageSetup: TdxPageSetupEvent read FOnPageSetup write FOnPageSetup;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  end;

  TdxfmPrintDialog = class(TCustomdxPSForm)
    ilPrinters: TImageList;
    Panel1: TPanel;
    btnPreview: TBitBtn;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    pnlPrintStyles: TPanel;
    gbxPrintStyles: TGroupBox;
    lbxPrintStyles: TListBox;
    btnPageSetup2: TButton;
    btnDefineStyles: TButton;
    pmPrintStyles: TPopupMenu;
    miPageSetup: TMenuItem;
    miDefineStyles: TMenuItem;
    miLine1: TMenuItem;
    pnlMiddle: TPanel;
    gbxPageRange: TGroupBox;
    lblDescription: TLabel;
    rbtnAllPages: TRadioButton;
    rbtnCurrentPage: TRadioButton;
    rbtnPageRanges: TRadioButton;
    edPageRanges: TEdit;
    rbtnSelection: TRadioButton;
    gbxCopies: TGroupBox;
    chbxCollate: TCheckBox;
    pnlTop: TPanel;
    gbxPrinter: TGroupBox;
    lblName: TLabel;
    lblStatus: TLabel;
    lblType: TLabel;
    lblWhere: TLabel;
    lblComment: TLabel;
    lStatus: TLabel;
    lType: TLabel;
    lWhere: TLabel;
    lComment: TLabel;
    cbxPrinters: TComboBox;
    btnPrinterProperties: TButton;
    btnNetwork: TButton;
    pnlPrintToFile: TPanel;
    chbxPrintToFile: TCheckBox;
    cbxFileName: TComboBox;
    btnBrowse: TButton;
    btnPageSetup: TBitBtn;
    lblNumberOfCopies: TLabel;
    bvlCopiesHolder: TBevel;
    lblNumberOfPages: TLabel;
    cbxNumberOfPages: TComboBox;
    bvlPRWarningHolder: TBevel;
    pbxCollate: TPaintBox;
    procedure chbxCollateClick(Sender: TObject);
    procedure btnPrinterPropertiesClick(Sender: TObject);
    procedure cbxPrintersChange(Sender: TObject);
    procedure chbxPrintToFileClick(Sender: TObject);
    procedure edPageRangesChange(Sender: TObject);
    procedure cbxNumberOfPagesChange(Sender: TObject);
    procedure rbtnPagesClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edPageRangesExit(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPageSetupClick(Sender: TObject);
    procedure edPageRangesKeyPress(Sender: TObject; var KEY: Char);
    procedure lblNumberOfPagesClick(Sender: TObject);
    procedure lblNumberOfCopiesClick(Sender: TObject);
    procedure lblNameClick(Sender: TObject);
    procedure btnNetworkClick(Sender: TObject);
    procedure cbxPrintersDrawItem(Control: TWinControl; index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure seCopiesChange(Sender: TObject);
    procedure seCopiesExit(Sender: TObject);
    procedure PageSetup2Click(Sender: TObject);
    procedure lbxPrintStylesDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lbxPrintStylesClick(Sender: TObject);
    procedure DefineStylesClick(Sender: TObject);    
    procedure pmPrintStylesPopup(Sender: TObject);
    procedure cbxFileNameExit(Sender: TObject);
    procedure pbxCollatePaint(Sender: TObject);
    procedure pbxCollateDblClick(Sender: TObject);
  private
    FControlsUpdating: Boolean;
    FDialogData: TdxPrintDialogData;
    FGlyphs: array[Boolean] of TBitmap;
    FIsCheckUserInput: Boolean;
    FModified: Boolean;
    FSubscriber: TdxEventSubscriber;
    FPreviewBtnClicked: Boolean;
    FPrintBtnClicked: Boolean;
    FSaveDialogData: TdxPrintDialogData;
    FseCopies: TdxPSSpinEdit;
    FPrintStylesVisibled: Boolean;
    FwpPageRanges: TdxPSWarningPane;
    FOnClose: TNotifyEvent;
    FOnPageSetup: TdxPageSetupEvent;
    FOnShow: TNotifyEvent;
    function CheckFileName(const FileName: string): Boolean;
    procedure CheckModified;
    function CheckPageRanges: Boolean;
    function CheckUserInput: Boolean;
    procedure ConnectToPrinterDlg;
    procedure CreateControls;
    procedure DocumentPropertiesDlg;
    procedure DrawCollatedPages(DC: HDC; const ADrawRect: TRect; ACollate: Boolean);    
    function GetFileName(const S: string): string;
    procedure LoadStrings;    
    procedure RefreshPrinterList;
    procedure RefreshStyleList;
    procedure SavePrintDialogData;
    procedure SetActiveControl;
    procedure SetupDialog(const APrintDlgData: TdxPrintDlgData);
    procedure StartSettings;
    procedure StyleListChanged(Sender: TObject);    
    procedure UpdateControlsState;
    procedure UpdatePrinterInfos;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure CreateWnd; override;
    procedure DoHide; override;
    procedure DoShow; override;

    procedure DoPageSetup; dynamic;
    procedure UpdatePrinters;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadFromRegistry(const APath: string); override;
    procedure SaveToRegistry(const APath: string); override;
    
    function Execute: Boolean;
    procedure ShowPrintStyles(AShow: Boolean);

    property PreviewBtnClicked: Boolean read FPreviewBtnClicked;
    property OnPageSetup: TdxPageSetupEvent read FOnPageSetup write FOnPageSetup;
  end;

function dxPrintDialog(var AData: TdxPrintDlgData): Boolean; overload;

implementation

{$R *.DFM}

uses
 {$IFDEF DELPHI6} 
  Variants,
 {$ENDIF} 
  WinSpool, Math, cxClasses, dxPSPopupMan, dxPSRes, dxPSEngn, dxPSEvnt, dxPSUtl, 
  dxPSImgs; 

const 
  sdxMaximized = 'Maximized'; // Don't Localize

function dxPrintDialog(var AData: TdxPrintDlgData): Boolean;
var
  Dialog: TdxfmPrintDialog;
begin
  Dialog := TdxfmPrintDialog.Create(nil);
  try
    Dialog.SetupDialog(AData);
    Result := Dialog.Execute;    
    if Result then
      AData.DialogData := Dialog.FDialogData
    else
      AData.DialogData := Dialog.FSaveDialogData;
    AData.PreviewBtnClicked := Dialog.PreviewBtnClicked;
  finally
    Dialog.Free;
  end;
end;

{ Memory Management Routines }

function dxAllocMem(ASize: Integer): Pointer;
begin
  Result := AllocMem(ASize);
end;

procedure dxFreeMem(var P: Pointer; ASize: Integer);
begin
  FreeMem(P, ASize);
  P := nil;
end;

{ TdxPrintDialog }

constructor TdxPrintDialog.Create(AOwner: TComponent);
begin
  inherited;
  FillChar(FDialogData, SizeOf(TdxPrintDialogData), 0);
  FDialogData.Copies := 1;
  FDialogData.Collate := False;
  FDialogData.FileList := TStringList.Create;
  FDialogData.FileName := '';
  FDialogData.MaxRange := 1;
  FDialogData.MinRange := 1;
  FDialogData.PageCount := 0;
  FDialogData.PageNums := pnAll;
  FDialogData.PageRanges := prAll;
  FDialogData.Pages := '';
  FDialogData.PrintToFile := False;
  FDialogData.StyleManager := nil;

  FButtonsEnabled := pdbDefault;
  FOptionsEnabled := pdoDefaultOptionsEnabled;

  FButtonsVisible := pdbDefault;
  FOptionsVisible := pdoDefaultOptionsVisible;
end;

destructor TdxPrintDialog.Destroy;
begin
  FreeAndNil(FDialogData.FileList);
  inherited;
end;

function TdxPrintDialog.DefaultTitle: string;
begin
  Result := cxGetResourceString(@sdxPrintDialogCaption);
end;

function TdxPrintDialog.Execute: Boolean;
var
  APrintDlgData: TdxPrintDlgData;
  AEvents: TdxPrintDlgEvents;
  ADialogData: TdxPrintDialogData;
  ASaveStrings: TStrings;
begin
  if dxPrintDevice.Printers.Count = 0 then
  begin
    MessageWarning(cxGetResourceString(@sdxPrintDialogNoPrinters));
    Result := False;
    Exit;
  end;

  FillChar(APrintDlgData, SizeOf(TdxPrintDlgData), 0);
  FillChar(AEvents, SizeOf(TdxPrintDlgEvents), 0);
  FillChar(ADialogData, SizeOf(TdxPrintDialogData), 0);
  try
    ADialogData.Copies := Copies;
    ADialogData.Collate := Collate;
    if UseFileList then
    begin
      ADialogData.FileList := TStringList.Create;
      ADialogData.FileList.Assign(FileList);
    end;
    ADialogData.FileName := FileName;
    ADialogData.MaxRange := MaxRange;
    ADialogData.MinRange := MinRange;
    ADialogData.PageCount := PageCount;
    ADialogData.PageNums := PageNums;
    ADialogData.PageRanges := PageRanges;
    ADialogData.Pages := Pages;
    ADialogData.PrintToFile := PrintToFile;
    ADialogData.StyleManager := StyleManager;

    APrintDlgData.DialogData := ADialogData;
    if APrintDlgData.HelpContext <> 0 then
      APrintDlgData.HelpContext := HelpContext;
    APrintDlgData.Title := Title;
    APrintDlgData.IsCheckUserInput := not (csDesigning in ComponentState);
    APrintDlgData.OptionsEnabled := OptionsEnabled;
    APrintDlgData.OptionsVisible := OptionsVisible;
    APrintDlgData.ButtonsEnabled := ButtonsEnabled;
    APrintDlgData.ButtonsVisible := ButtonsVisible;

    AEvents.OnClose := OnClose;
    AEvents.OnPageSetup := OnPageSetup;
    AEvents.OnShow := OnShow;

    APrintDlgData.Events := AEvents;

    Result := dxPrintDialog(APrintDlgData);
    if Result then
    begin
      ASaveStrings := FileList;
      if UseFileList then
        FileList := APrintDlgData.DialogData.FileList;
      FDialogData := APrintDlgData.DialogData;
      FDialogData.FileList := ASaveStrings;
    end;
    FPreviewBtnClicked := APrintDlgData.PreviewBtnClicked;
  finally
    if ADialogData.FileList <> nil then ADialogData.FileList.Free;
  end;
end;

procedure TdxPrintDialog.RestoreDefaults;
begin
  ButtonsEnabled := pdbDefault;
  ButtonsVisible := pdbDefault;
  Collate := False;
  Copies := 1;
  MaxRange := 1;
  MinRange := 1;
  OptionsEnabled := pdoDefaultOptionsEnabled;
  OptionsVisible := pdoDefaultOptionsVisible;
  PageNums := pnAll;
  PageRanges := prAll;
  PrintToFile := False;
  UseFileList := False;
  FIsTitleAssigned := False;
end;

procedure TdxPrintDialog.SetMinMaxRanges(AMinRange, AMaxRange: Integer);
begin
  if AMinRange < 1 then AMinRange := 1;
  if AMaxRange <> -1 then 
    if AMaxRange < AMinRange then AMaxRange := AMinRange;
  FDialogData.MinRange := AMinRange;
  FDialogData.MaxRange := AMaxRange;
end;

procedure TdxPrintDialog.AssignTo(Dest: TPersistent);

  procedure XorOption(var AOptions: TPrintDialogOptions; AItem: TPrintDialogOption; AValue: Boolean);
  begin
    if AValue then 
      AOptions := AOptions + [AItem]
    else  
      AOptions := AOptions - [AItem];
  end;
  
var
  PageIndexes: TIntegers;
  SrcOptions: TPrintDialogOptions;
begin
  if Dest is Dialogs.TPrintDialog then
    with Dialogs.TPrintDialog(Dest) do
    begin
      Collate := Self.Collate;
      Copies := Self.Copies;
      MinPage := Self.MinRange;
      MaxPage := Self.MaxRange;
      if MakePageIndexes(Self.Pages, PageIndexes) then
        try
          FromPage := MinIntValue(PageIndexes);
          ToPage := MaxIntValue(PageIndexes);
        finally
          SetLength(PageIndexes, 0);
        end  
      else
      begin
        FromPage := 1;
        ToPage := 1;
      end;  

      SrcOptions := Options;
      XorOption(SrcOptions, poPrintToFile, pdoPrintToFile in Self.OptionsVisible);
      XorOption(SrcOptions, poDisablePrintToFile, pdoPrintToFile in Self.OptionsEnabled);
      XorOption(SrcOptions, poPageNums, 
        (pdoPageRange in Self.OptionsVisible) and (pdoPageRange in Self.OptionsEnabled));
      XorOption(SrcOptions, poSelection, 
        (pdoSelection in Self.OptionsVisible) and (pdoSelection in Self.OptionsEnabled));
      XorOption(SrcOptions, poHelp, 
        (pdbHelp in Self.ButtonsVisible) and (pdbHelp in Self.ButtonsEnabled));
      Options := SrcOptions;

      PrintToFile := Self.PrintToFile;

      if Self.PageRanges = prSelection then
        PrintRange := Dialogs.prAllPages
      else
        PrintRange := TPrintRange(PageRanges);
    end;
end;

procedure TdxPrintDialog.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('IsTitleAssigned', ReadIsTitleAssigned, WriteIsTitleAssigned, 
    FIsTitleAssigned and (Title = ''));
end;

procedure TdxPrintDialog.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = StyleManager) and (Operation = opRemove) then
    StyleManager := nil;
end;

function TdxPrintDialog.GetPageCount: Integer;
begin
  Result := FDialogData.PageCount;
end;

function TdxPrintDialog.GetCollate: Boolean;
begin
  Result := FDialogData.Collate;
end;

function TdxPrintDialog.GetCopies: Integer;
begin
  Result := FDialogData.Copies;
end;

function TdxPrintDialog.GetFileList: TStrings;
begin
  Result := FDialogData.FileList;
end;

function TdxPrintDialog.GetFileName: string;
begin
  Result := FDialogData.FileName;
end;

function TdxPrintDialog.GetMaxRange: Integer;
begin
  Result := FDialogData.MaxRange;
end;

function TdxPrintDialog.GetMinRange: Integer;
begin
  Result := FDialogData.MinRange;
end;

function TdxPrintDialog.GetPageNums: TdxPageNumbers;
begin
  Result := FDialogData.PageNums;
end;

function TdxPrintDialog.GetPageRanges: TdxPageRanges;
begin
  Result := FDialogData.PageRanges;
end;

function TdxPrintDialog.GetPages: string;
begin
  Result := FDialogData.Pages;
end;

function TdxPrintDialog.GetPrintToFile: Boolean;
begin
  Result := FDialogData.PrintToFile;
end;

function TdxPrintDialog.GetStyleManager: TdxPrintStyleManager;
begin
  Result := FDialogData.StyleManager;
end;

function TdxPrintDialog.GetTitle: string;
begin
  if FIsTitleAssigned then
    Result := FTitle
  else
    Result := DefaultTitle;
end;

function TdxPrintDialog.IsTitleStored: Boolean;
begin
  Result := FIsTitleAssigned and (Title <> DefaultTitle);
end;

procedure TdxPrintDialog.SetCollate(Value: Boolean);
begin
  FDialogData.Collate := Value;
end;

procedure TdxPrintDialog.SetCopies(Value: Integer);
begin
  FDialogData.Copies := Value;
end;

procedure TdxPrintDialog.SetFileList(Value: TStrings);
begin
  FDialogData.FileList.Assign(Value);
end;

procedure TdxPrintDialog.SetFileName(const Value: string);
begin
  FDialogData.FileName := Value;
end;

procedure TdxPrintDialog.SetMaxRange(Value: Integer);
begin
  SetMinMaxRanges(MinRange, Value);
end;

procedure TdxPrintDialog.SetMinRange(Value: Integer);
begin
  SetMinMaxRanges(Value, MaxRange);
end;

procedure TdxPrintDialog.SetPageCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  FDialogData.PageCount := Value;
end;

procedure TdxPrintDialog.SetPageNums(Value: TdxPageNumbers);
begin
  FDialogData.PageNums := Value;
end;

procedure TdxPrintDialog.SetPageRanges(Value: TdxPageRanges);
begin
  if FDialogData.PageRanges <> Value then
  begin
    case Value of
      prAll:
        begin
          OptionsVisible := OptionsVisible + [pdoAllPages];
          OptionsEnabled := OptionsEnabled + [pdoAllPages];
        end;
      prCurrent:
        begin
          OptionsVisible := OptionsVisible + [pdoCurrentPage];
          OptionsEnabled := OptionsEnabled + [pdoCurrentPage];
        end;
      prRange:
        begin
          OptionsVisible := OptionsVisible + [pdoPageRange];
          OptionsEnabled := OptionsEnabled + [pdoPageRange];
        end;
      prSelection:
        begin
          OptionsVisible := OptionsVisible + [pdoSelection];
          OptionsEnabled := OptionsEnabled + [pdoSelection];
        end;
    end;
    FDialogData.PageRanges := Value;
  end;
end;

procedure TdxPrintDialog.SetPages(const Value: string);
begin
  FDialogData.Pages := Value;
end;

procedure TdxPrintDialog.SetPrintToFile(Value: Boolean);
begin
  FDialogData.PrintToFile := Value;
end;

procedure TdxPrintDialog.SetStyleManager(Value: TdxPrintStyleManager);
begin
  if FDialogData.StyleManager <> Value then
  begin
    FDialogData.StyleManager := Value;
    if StyleManager <> nil then     
      StyleManager.FreeNotification(Self);
  end;
end;

procedure TdxPrintDialog.SetTitle(const Value: string);
begin
  if Title <> Value then
  begin
    FTitle := Value;
    FIsTitleAssigned := True;
  end;
end;

procedure TdxPrintDialog.ReadIsTitleAssigned(Reader: TReader);
begin
  FIsTitleAssigned := Reader.ReadBoolean;
end;

procedure TdxPrintDialog.WriteIsTitleAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsTitleAssigned);
end;

{ utilities }

function GetStatusString(Status: DWORD): string;
begin
  case Status of
    0:
      Result := cxGetResourceString(@sdxPrintDialogPSReady);
    PRINTER_STATUS_PAUSED:
      Result := cxGetResourceString(@sdxPrintDialogPSPaused);
    PRINTER_STATUS_PENDING_DELETION:
      Result := cxGetResourceString(@sdxPrintDialogPSPendingDeletion);
    PRINTER_STATUS_BUSY:
      Result := cxGetResourceString(@sdxPrintDialogPSBusy);
    PRINTER_STATUS_DOOR_OPEN:
      Result := cxGetResourceString(@sdxPrintDialogPSDoorOpen);
    PRINTER_STATUS_ERROR:
      Result := cxGetResourceString(@sdxPrintDialogPSError);
    PRINTER_STATUS_INITIALIZING:
      Result := cxGetResourceString(@sdxPrintDialogPSInitializing);
    PRINTER_STATUS_IO_ACTIVE:
      Result := cxGetResourceString(@sdxPrintDialogPSIOActive);
    PRINTER_STATUS_MANUAL_FEED:
      Result := cxGetResourceString(@sdxPrintDialogPSManualFeed);
    PRINTER_STATUS_NO_TONER:
      Result := cxGetResourceString(@sdxPrintDialogPSNoToner);
    PRINTER_STATUS_NOT_AVAILABLE:
      Result := cxGetResourceString(@sdxPrintDialogPSNotAvailable);
    PRINTER_STATUS_OFFLINE:
      Result := cxGetResourceString(@sdxPrintDialogPSOFFLine);
    PRINTER_STATUS_OUT_OF_MEMORY:
      Result := cxGetResourceString(@sdxPrintDialogPSOutOfMemory);
    PRINTER_STATUS_OUTPUT_BIN_FULL:
      Result := cxGetResourceString(@sdxPrintDialogPSOutBinFull);
    PRINTER_STATUS_PAGE_PUNT:
      Result := cxGetResourceString(@sdxPrintDialogPSPagePunt);
    PRINTER_STATUS_PAPER_JAM:
      Result := cxGetResourceString(@sdxPrintDialogPSPaperJam);
    PRINTER_STATUS_PAPER_OUT:
      Result := cxGetResourceString(@sdxPrintDialogPSPaperOut);
    PRINTER_STATUS_PAPER_PROBLEM:
      Result := cxGetResourceString(@sdxPrintDialogPSPaperProblem);
    PRINTER_STATUS_PRINTING:
      Result := cxGetResourceString(@sdxPrintDialogPSPrinting);
    PRINTER_STATUS_PROCESSING:
      Result := cxGetResourceString(@sdxPrintDialogPSProcessing);
    PRINTER_STATUS_TONER_LOW:
      Result := cxGetResourceString(@sdxPrintDialogPSTonerLow);
    PRINTER_STATUS_USER_INTERVENTION:
      Result := cxGetResourceString(@sdxPrintDialogPSUserIntervention);
    PRINTER_STATUS_WAITING:
      Result := cxGetResourceString(@sdxPrintDialogPSWaiting);
    PRINTER_STATUS_WARMING_UP:
      Result := cxGetResourceString(@sdxPrintDialogPSWarningUp);
  else
    Result := '';
  end;
end;

{ TfmdxPrintDialog }

constructor TdxfmPrintDialog.Create(AOwner: TComponent);
begin
  inherited;
  HelpContext := dxPSGlbl.dxhcPrintDlg;
  FillChar(FDialogData, SizeOf(TdxPrintDialogData), 0);
  FillChar(FSaveDialogData, SizeOf(TdxPrintDialogData), 0);
  CreateControls;
  FGlyphs[False] := CreateDoubleArrowBitmap(udgUp, 8);
  FGlyphs[True] := CreateDoubleArrowBitmap(udgDown, 8);

  pmPrintStyles.Images := ilPrinters;
  miPageSetup.ImageIndex := 4;
  miDefineStyles.ImageIndex := 5;

  FSubscriber := TdxStyleListChangedSubscriber.Create([TdxSMStyleListChangedEvent]);
  TdxStyleListChangedSubscriber(FSubscriber).OnStyleListChanged := StyleListChanged;
  dxPSPopupMenuController.RegisterControl(lbxPrintStyles);
end;

destructor TdxfmPrintDialog.Destroy;
begin
  dxPSPopupMenuController.UnregisterControl(lbxPrintStyles);
  FreeAndNil(FSubscriber);
  FreeAndNil(FGlyphs[True]);
  FreeAndNil(FGlyphs[False]);
  inherited;
end;

function TdxfmPrintDialog.Execute: Boolean;
begin
  if dxPrintDevice.Printers.Count = 0 then
  begin
    MessageWarning(cxGetResourceString(@sdxPrintDialogNoPrinters));
    Result := False;                     
    Exit;
  end;

  StartSettings;
  ShowPrintStyles(FPrintStylesVisibled and (FDialogData.StyleManager <> nil));
  if FDialogData.StyleManager <> nil then
    TdxStyleListChangedSubscriber(FSubscriber).StyleListChanged(FDialogData.StyleManager);
  SetActiveControl;

  Result := ShowModal = mrOk;
end;

procedure TdxfmPrintDialog.CreateWnd;
begin
  inherited;
  if Icon.Handle = 0 then
    Icon_LoadFromResourceName(Icon, IDB_DXPSPRINT);
  SendMessage(Handle, WM_SETICON, 1, Icon.Handle);
end;

procedure TdxfmPrintDialog.DoHide;
begin
  if Assigned(FOnClose) then FOnClose(Self);
  inherited;
end;

procedure TdxfmPrintDialog.DoShow;
begin
  inherited;
  if Assigned(FOnShow) then FOnShow(Self);
end;

procedure TdxfmPrintDialog.DoPageSetup;
var
  Done: Boolean;
begin
  if Assigned(FOnPageSetup) then
  begin
    Done := True;
    try
      FOnPageSetup(Self, Done, @FPreviewBtnClicked, nil);//@FPrintBtnClicked);
    except
      Application.HandleException(Self);
    end;
    if Done then
    begin
      UpdatePrinterInfos;
      CheckModified;
      btnCancel.Caption := cxGetResourceString(@sdxBtnClose);
    end;
    if FPreviewBtnClicked then ModalResult := mrOK;
  end;
end;

procedure TdxfmPrintDialog.UpdatePrinters;
begin
  RefreshPrinterList;
  UpdatePrinterInfos;
  if dxPrintDevice.Printers.Count > 0 then
    dxPrintDevice.PrinterIndex := -1
  else
    cbxPrinters.Enabled := False;
  Invalidate;
end;

procedure TdxfmPrintDialog.cbxPrintersDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with TComboBox(Control), TdxPrintDeviceInfo(Items.Objects[Index]) do
    dxDrawPrinter(Canvas, Rect, Items[Index], ilPrinters, Ord(IsNetwork) + 2 * Ord(IsDefault));
end;

procedure TdxfmPrintDialog.chbxCollateClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  FDialogData.Collate := TCheckBox(Sender).Checked;
  pbxCollate.Invalidate;
  CheckModified;
end;

procedure TdxfmPrintDialog.btnPrinterPropertiesClick(Sender: TObject);
begin
  if dxPrintDevice.Printing then
    MessageWarning(cxGetResourceString(@sdxPrintDialogInPrintingState))
  else
    DocumentPropertiesDlg;
end;

procedure TdxfmPrintDialog.cbxPrintersChange(Sender: TObject);
var
  PrevCursor: TCursor;
begin
  if FControlsUpdating then Exit;
  PrevCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    dxPrintDevice.PrinterIndex := TComboBox(Sender).ItemIndex;
  finally
    Screen.Cursor := PrevCursor;
  end;  
  btnCancel.Caption := cxGetResourceString(@sdxBtnClose);
  UpdatePrinterInfos;
  CheckModified;
end;

procedure TdxfmPrintDialog.chbxPrintToFileClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  FDialogData.PrintToFile := TCheckBox(Sender).Checked;
  if TCheckBox(Sender).Checked and (cbxFileName.Items.Count > 0) then 
    cbxFileName.ItemIndex := 0;
  CheckModified;
  if TCheckBox(Sender).Checked then ActiveControl := btnBrowse;
end;

procedure TdxfmPrintDialog.edPageRangesChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  if ActiveControl = Sender then rBtnPageRanges.Checked := True;
  CheckModified;
end;

procedure TdxfmPrintDialog.cbxNumberOfPagesChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  FDialogData.PageNums := TdxPageNumbers(TComboBox(Sender).ItemIndex);
  CheckModified;
end;

procedure TdxfmPrintDialog.seCopiesChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  CheckModified;
end;

procedure TdxfmPrintDialog.seCopiesExit(Sender: TObject);
begin
  FDialogData.Copies := TdxPSSpinEdit(Sender).AsInteger;
end;

procedure TdxfmPrintDialog.rbtnPagesClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  FDialogData.PageRanges := TdxPageRanges(TTagToInt(TRadioButton(Sender).Tag));
  CheckModified;
  if Sender = rbtnPageRanges then
  begin
    if ActiveControl <> edPageRanges then
    begin
      ActiveControl := edPageRanges;
      edPageRanges.SelectAll;
    end;
  end
  else
  begin
    edPageRanges.Text := '';
    FwpPageRanges.State := False;
  end;  
end;

procedure TdxfmPrintDialog.btnBrowseClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    with OpenDialog do 
    begin
      Title := cxGetResourceString(@sdxPrintDialogOpenDlgTitle);
      Filter := Format('%s (*.*)|*.*|%s (*.prn)|*.PRN', 
        [cxGetResourceString(@sdxPrintDialogOpenDlgAllFiles), 
         cxGetResourceString(@sdxPrintDialogOpenDlgPrinterFiles)]);
      FilterIndex := 2;
      DefaultExt := 'prn';
      FileName := cbxFileName.Text;
      if Execute then
        cbxFileName.Text := FileName;
    end;    
  finally
    OpenDialog.Free;
  end;
end;

procedure TdxfmPrintDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrOk then
  begin
    if FIsCheckUserInput then CanClose := CheckUserInput;
    if CanClose then SavePrintDialogData;
  end;
end;
               
procedure TdxfmPrintDialog.cbxFileNameExit(Sender: TObject);
var
  S: string;
begin
  S := StringReplace(TComboBox(Sender).Text, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  FDialogData.FileName := GetFileName(S);
end;

procedure TdxfmPrintDialog.edPageRangesExit(Sender: TObject);
var
  b: Boolean;
begin
  with TEdit(Sender) do 
    Text := StringReplace(Text, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  FDialogData.Pages := TEdit(Sender).Text;
  if rbtnAllPages.Checked or rbtnCurrentPage.Checked or rbtnSelection.Checked or 
    (rbtnAllPages = ActiveControl) or (rbtnCurrentPage = ActiveControl) or 
    (rbtnSelection = ActiveControl) then 
    FwpPageRanges.State := False 
  else
  begin
    try
      // order is very important because there is a possibility of rising exception in CheckPageRanges
      b := CheckPageRanges or (FDialogData.MaxRange = -1);
      if not b then 
        FwpPageRanges.Hint := Format(cxGetResourceString(@sdxPrintDialogPageNumbersOutOfRange), 
          [FDialogData.MinRange, FDialogData.MaxRange]);
    except
      b := False;
      FwpPageRanges.Hint := Format(cxGetResourceString(@sdxPrintDialogInvalidPageRanges), [edPageRanges.Text]);
    end;  
    if not b and not FwpPageRanges.State and (ActiveControl <> btnOK) and (ActiveControl <> btnCancel) then 
      Beep;
    FwpPageRanges.State := not b;
  end;  
end;

procedure TdxfmPrintDialog.edPageRangesKeyPress(Sender: TObject; var Key: Char);

  function IsValidKey(AKey: Char): Boolean;
  begin      
    Result := dxCharInSet(AKey, ['0'..'9']);
    if not Result and (Text <> '') then
      Result := (AKey = cPageSeparator) or (AKey = cPageRangeSeparator) or (AKey = Char(VK_BACK));
  end;
  
begin
  if not IsValidKey(Key) then
  begin
    MessageBeep(MB_ICONHAND);
    Key := #0;
  end;
end;

procedure TdxfmPrintDialog.btnPreviewClick(Sender: TObject);
begin
  FPreviewBtnClicked := True;
  ModalResult := mrCancel; // mrOK ???
end;

procedure TdxfmPrintDialog.ShowPrintStyles(AShow: Boolean);
begin
  if pnlPrintStyles.Visible <> AShow then
  begin
    pnlPrintStyles.Visible := AShow;
    btnPageSetup.Glyph := FGlyphs[not pnlPrintStyles.Visible];
    Height := Height + (-1 + 2 * Byte(pnlPrintStyles.Visible)) * pnlPrintStyles.Height;
  end;
end;

procedure TdxfmPrintDialog.btnPageSetupClick(Sender: TObject);
begin
  if FDialogData.StyleManager <> nil then
    ShowPrintStyles(not pnlPrintStyles.Visible)
  else
    DoPageSetup;
end;

procedure TdxfmPrintDialog.lblNumberOfPagesClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TComboBox(ActiveControl).DroppedDown := True;
end;

procedure TdxfmPrintDialog.lblNumberOfCopiesClick(Sender: TObject);
begin
  TLabel(Sender).FocusControl.SetFocus;
end;

procedure TdxfmPrintDialog.lblNameClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TComboBox(ActiveControl).DroppedDown := True;
end;

procedure TdxfmPrintDialog.btnNetworkClick(Sender: TObject);
begin
  Self.ConnectToPrinterDlg;
  UpdateControlsState;
end;

procedure TdxfmPrintDialog.lbxPrintStylesDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with TListBox(Control) do
    dxPSDrawStyleItem(TBasedxPrintStyle(Items.Objects[Index]), TListBox(Control),
      Index, State, Rect, True, False);
end;

procedure TdxfmPrintDialog.lbxPrintStylesClick(Sender: TObject);
begin
  with lbxPrintStyles do
    FDialogData.StyleManager.CurrentStyle := TBasedxPrintStyle(Items.Objects[ItemIndex]);
  btnCancel.Caption := cxGetResourceString(@sdxBtnClose);
end;

procedure TdxfmPrintDialog.DefineStylesClick(Sender: TObject);
var
  PrintBtnClicked: Boolean;
begin
  FDialogData.StyleManager.DefinePrintStylesDlg(FPreviewBtnClicked, PrintBtnClicked);
  btnCancel.Caption := cxGetResourceString(@sdxBtnClose);
  if FPreviewBtnClicked then ModalResult := mrOK;
end;

procedure TdxfmPrintDialog.PageSetup2Click(Sender: TObject);
var
  Index: Integer;
  Style: TBasedxPrintStyle;  
begin
  Index := lbxPrintStyles.ItemIndex;
  if Index <> -1 then 
  begin
    Style := TBasedxPrintStyle(lbxPrintStyles.Items.Objects[Index]);
    if Style.PageSetup(0, True, True, FPreviewBtnClicked, FPrintBtnClicked) then
      btnCancel.Caption := cxGetResourceString(@sdxBtnClose);
    if FPreviewBtnClicked then ModalResult := mrOK;
  end;  
end;

procedure TdxfmPrintDialog.pmPrintStylesPopup(Sender: TObject);
begin
  miPageSetup.Enabled := btnPageSetup2.Enabled;
end;

procedure TdxfmPrintDialog.SaveToRegistry(const APath: string);
begin
  inherited;
  if FDialogData.StyleManager <> nil then
    with TRegistry.Create do
    try
      if OpenKey(APath, True) then
      try
        WriteBool(sdxMaximized, pnlPrintStyles.Visible);
      except
        on ERegistryException do 
          { ignore }
        else
          raise;
      end;  
    finally
      Free;
    end;  
end;

procedure TdxfmPrintDialog.LoadFromRegistry(const APath: string);
begin
  inherited;
  with TRegistry.Create do
  try
    if OpenKey(APath, False) and ValueExists(sdxMaximized) then
    try
      FPrintStylesVisibled := ReadBool(sdxMaximized);
    except
      on ERegistryException do 
        { ignore }
      else
        raise;
    end;  
  finally
    Free;
  end;  
end;

procedure TdxfmPrintDialog.pbxCollateDblClick(Sender: TObject);
begin
  chbxCollate.Checked := not chbxCollate.Checked;
end;
 
procedure TdxfmPrintDialog.pbxCollatePaint(Sender: TObject);
var
  DC: HDC;
  R: TRect;
begin
  with TPaintBox(Sender) do 
  begin
    DC := Canvas.Handle;
    SelectObject(DC, Font.Handle);
    SetTextColor(DC, GetSysColor(COLOR_WINDOWTEXT));
    R := ClientRect;
  end;
  SetBkMode(DC, TRANSPARENT);
  DrawCollatedPages(DC, R, FDialogData.Collate);  
  SelectClipRgn(DC, 0);
end;

function TdxfmPrintDialog.CheckFileName(const FileName: string): Boolean;
begin
  Result := ValidateFileName(FileName) 
end;

procedure TdxfmPrintDialog.CheckModified;
begin
  if not FModified then FModified := True;
  UpdateControlsState;
end;

function TdxfmPrintDialog.CheckPageRanges: Boolean;
var  
  PageIndexes: TIntegers;
begin
  Result := MakePageIndexes(edPageRanges.Text, PageIndexes) and
     (MinIntValue(PageIndexes) >= FDialogData.MinRange) and 
     (MaxIntValue(PageIndexes) <= FDialogData.MaxRange);
end;

function TdxfmPrintDialog.CheckUserInput: Boolean;
var
  FileName: string;
  RealFileName: string;
begin
  Result := True;
  if chbxPrintToFile.Checked then
  begin
    FileName := cbxFileName.Text;
    Result := Length(Filename) > 0;
    if Result then
    begin
      if (Length(FileName) > 2) and (FileName[1] = '"') and (FileName[Length(FileName)] = '"') then
        FileName := Copy(FileName, 2, Length(FileName) - 2);
      Result := CheckFileName(Filename);
      if Result then
      begin
        RealFileName := GetFileName(cbxFileName.Text);
        Result := not FileExists(RealFileName);
        if not Result then
          Result := MessageQuestion(Format(cxGetResourceString(@sdxConfirmOverWrite), [RealFileName]))
      end
      else
        MessageWarning(Format(cxGetResourceString(@sdxInvalidFileName), [FileName]));
    end
    else
      MessageWarning(cxGetResourceString(@sdxRequiredFileName));
    if not Result then ActiveControl := cbxFileName;
    Exit;
  end;
  if rBtnPageRanges.Checked then
  begin
    Result := Length(edPageRanges.Text) > 0;
    if Result then
    try
      // Because there is possibility of exception raising in CheckPageRanges that order is very important 
      Result := CheckPageRanges or (FDialogData.MaxRange = -1);
      if not Result then
        MessageWarning(Format(cxGetResourceString(@sdxPrintDialogPageNumbersOutOfRange), 
          [FDialogData.MinRange, FDialogData.MaxRange]));
    except
      MessageWarning(Format(cxGetResourceString(@sdxPrintDialogInvalidPageRanges), [edPageRanges.Text]));
      Result := False;
    end
    else
      MessageWarning(cxGetResourceString(@sdxPrintDialogRequiredPageNumbers));
    if not Result then ActiveControl := edPageRanges;
  end;
end;

procedure TdxfmPrintDialog.ConnectToPrinterDlg;
begin
  if dxConnectToNetPrinter(Self.Handle) then
  begin
    RefreshPrinterList;
    cbxPrintersChange(cbxPrinters);
    btnCancel.Caption := cxGetResourceString(@sdxBtnClose);
  end;
end;

procedure TdxfmPrintDialog.CreateControls;
begin
  FseCopies := TdxPSSpinEdit.Create(Self);
  with FseCopies do
  begin
    Parent := gbxCopies;
    BoundsRect := bvlCopiesHolder.BoundsRect;
    MinValue := 0;
    MaxValue := MaxInt;
    OnChange := seCopiesChange;
    OnExit := seCopiesExit;
    Flat := False;
    TabOrder := cbxNumberOfPages.TabOrder + 1;
  end;
  lblNumberOfCopies.FocusControl := FseCopies;

  FwpPageRanges := TdxPSWarningPane.Create(Self);
  FwpPageRanges.Parent := gbxPageRange;
  FwpPageRanges.BoundsRect := bvlPRWarningHolder.BoundsRect;
end;

procedure TdxfmPrintDialog.DocumentPropertiesDlg;
begin
  dxPrintDevice.Copies := FseCopies.AsInteger;
  dxPrintDevice.Collate := chbxCollate.Checked;
  if dxDocumentProperties(Handle) then
  begin
    FseCopies.AsInteger := dxPrintDevice.Copies;
    chbxCollate.Checked := dxPrintDevice.Collate;
    UpdatePrinterInfos;
    CheckModified;
    btnCancel.Caption := cxGetResourceString(@sdxBtnClose);
  end;
end;

procedure TdxfmPrintDialog.DrawCollatedPages(DC: HDC; const ADrawRect: TRect; ACollate: Boolean);

  procedure DrawPages(const APageRect: TRect; const AOffsets: TPoint; 
    ADistance: Integer; ACollate: Boolean);

    procedure DrawPage(var R: TRect; const S: string);
    var
      Size: TSize;
    begin
      DrawEdge(DC, R, BDR_RAISEDOUTER, BF_LEFT or BF_TOP or BF_FLAT);
      DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RIGHT or BF_BOTTOM);
      InflateRect(R, -1, -1);      
      
      DrawEdge(DC, R, BDR_SUNKENINNER, BF_RIGHT or BF_BOTTOM);      
      Dec(R.Right);
      Dec(R.Bottom);
      FillRect(DC, R, GetSysColorBrush(COLOR_WINDOW));

      Inc(R.Right);
      Inc(R.Bottom);
      InflateRect(R, 1, 1);
      GetTextExtentPoint32(DC, PChar(S), Length(S), Size);
      TextOut(DC, R.Right - Size.cX - 2, R.Bottom - Size.cY - 1, PChar(S), Length(S));
      with R do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
    end;

    procedure DrawPageColumn(var R: TRect; Index, Count: Integer);
    var
      I: Integer;
      S: string;
    begin
      if not ACollate then 
        S := IntToStr(Index + 1);
      for I := 0 to Count - 1 do 
      begin
        if ACollate then 
          S := IntToStr(I + 1);
        DrawPage(R, S);
        OffsetRect(R, AOffsets.X, -AOffsets.Y);
      end;  
    end;
  
  var
    I, C: Integer;
    R: TRect; 
  begin
    C := 2 + Byte(ACollate);
    for I := 0 to 2 - Byte(ACollate) do 
    begin
      R := APageRect;
      OffsetRect(R, I * ADistance, 0);
      DrawPageColumn(R, I, C);
    end;
  end;

const 
  PageWidth = 19;  
  PageHeight = 24;
  Offsets: TPoint = (X: 10; Y: 8);
var
  R: TRect;
  W, H, Distance, ShiftX, ShiftY: Integer;
begin
  R := Rect(0, 0, PageWidth, PageHeight);
  W := ADrawRect.Right - ADrawRect.Left;
  H := ADrawRect.Bottom - ADrawRect.Top;
  ShiftX := ((W div (3 - Byte(ACollate))) - (PageWidth + Offsets.X * (1 + Byte(ACollate)))) div 2;
  ShiftY := ((H - PageHeight + Offsets.Y * (1 + Byte(ACollate))) div 2);
  OffsetRect(R, ShiftX, ShiftY);
  Distance := W div (3 - Byte(ACollate));
  DrawPages(R, Offsets, Distance, ACollate);
end;

function TdxfmPrintDialog.GetFileName(const S: string): string;
begin
  if S <> '' then
    if (S[1] = '"') and (S[Length(S)] = '"') then
      Result := Copy(S, 2, Length(S) - 2)
    else
      Result := ChangeFileExt(S, '.prn')
  else
    Result := '';
end;

procedure TdxfmPrintDialog.LoadStrings;

  procedure AdjustControls;

    function CalculateLeftBound: Integer;
    begin
      Result := lblName.Width;
      if Result < lblStatus.Width then
        Result := lblStatus.Width;
      if Result < lblType.Width then
        Result := lblType.Width;
      if Result < lblWhere.Width then
        Result := lblWhere.Width;
      if Result < lblComment.Width then
        Result := lblComment.Width;
        
      Inc(Result, lblStatus.Left + 10);
    end;
    
  var  
    LeftBound, RightBound: Integer;
  begin
    LeftBound := CalculateLeftBound;

    RightBound := cbxPrinters.Left + cbxPrinters.Width;
    cbxPrinters.Left := LeftBound;
    cbxPrinters.Width := RightBound - LeftBound;
    
    lStatus.Left := LeftBound;
    lType.Left := LeftBound;
    lWhere.Left := LeftBound;
    lComment.Left := LeftBound;
  end;
  
var
  Index: Integer;
begin
  Caption := cxGetResourceString(@sdxPrintDialogCaption);
  gbxPrinter.Caption := cxGetResourceString(@sdxPrintDialogPrinter);

  lblName.Caption :=  cxGetResourceString(@sdxPrintDialogName);
  lblStatus.Caption := cxGetResourceString(@sdxPrintDialogStatus);
  lblType.Caption := cxGetResourceString(@sdxPrintDialogType);
  lblWhere.Caption := cxGetResourceString(@sdxPrintDialogWhere);
  lblComment.Caption := cxGetResourceString(@sdxPrintDialogComment);
  AdjustControls;
  chbxPrintToFile.Caption := cxGetResourceString(@sdxPrintDialogPrintToFile);

  gbxPageRange.Caption := cxGetResourceString(@sdxPrintDialogPageRange);
  rbtnAllPages.Caption := cxGetResourceString(@sdxPrintDialogAll);
  rbtnCurrentPage.Caption := cxGetResourceString(@sdxPrintDialogCurrentPage);
  rbtnSelection.Caption := cxGetResourceString(@sdxPrintDialogSelection);
  rBtnPageRanges.Caption := cxGetResourceString(@sdxPrintDialogPages);
  lblDescription.Caption := cxGetResourceString(@sdxPrintDialogRangeLegend);
  gbxCopies.Caption := cxGetResourceString(@sdxPrintDialogCopies);
  
  lblNumberOfPages.Caption := cxGetResourceString(@sdxPrintDialogNumberOfPages);
  Index := cbxNumberOfPages.ItemIndex;
  with cbxNumberOfPages.Items do
  begin
    BeginUpdate;
    try
      Clear;
      Add(cxGetResourceString(@sdxPrintDialogAllPages));
      Add(cxGetResourceString(@sdxPrintDialogEvenPages));
      Add(cxGetResourceString(@sdxPrintDialogOddPages));
    finally
      EndUpdate;
    end;
  end;
  cbxNumberOfPages.ItemIndex := Index;

  lblNumberOfCopies.Caption := cxGetResourceString(@sdxPrintDialogNumberOfCopies);
  chbxCollate.Caption := cxGetResourceString(@sdxPrintDialogCollateCopies);

  btnPrinterProperties.Caption := cxGetResourceString(@sdxBtnProperties);
  btnNetwork.Caption := cxGetResourceString(@sdxBtnNetwork);
  btnBrowse.Caption := cxGetResourceString(@sdxBtnBrowse);
  btnPageSetup.Caption := cxGetResourceString(@sdxBtnPageSetup);
  btnPreview.Caption := cxGetResourceString(@sdxBtnPreview);
  btnOK.Caption := DropEndEllipsis(cxGetResourceString(@sdxBtnPrint));
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);
                         
  gbxPrintStyles.Caption := cxGetResourceString(@sdxPrintDialogPrintStyles);
  btnPageSetup2.Caption := cxGetResourceString(@sdxBtnPageSetup);
  btnDefineStyles.Caption := cxGetResourceString(@sdxBtnDefinePrintStyles);
  miPageSetup.Caption := cxGetResourceString(@sdxBtnPageSetup);
  miDefineStyles.Caption := cxGetResourceString(@sdxBtnDefinePrintStyles);
end;

procedure TdxfmPrintDialog.RefreshPrinterList;
begin
  with cbxPrinters do
  begin
    dxGetPrinterList(Items);
    if Items.Count > 0 then 
      ItemIndex := dxPrintDevice.PrinterIndex;
  end;  
end;

procedure TdxfmPrintDialog.RefreshStyleList;
var
  I: Integer;
  AStyle: TBasedxPrintStyle;
begin
  with lbxPrintStyles do
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
      for I := 0 to FDialogData.StyleManager.Count - 1 do
      begin
        AStyle := FDialogData.StyleManager[I];
        Items.AddObject(AStyle.StyleCaption, AStyle);
      end;
      ItemIndex := Items.IndexOfObject(FDialogData.StyleManager.CurrentStyle);
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TdxfmPrintDialog.SavePrintDialogData;
var
  Index: Integer;
begin
  with FDialogData do
  begin
    Pages := StringReplace(edPageRanges.Text, ' ', '',  [rfReplaceAll, rfIgnoreCase]);
    FileName := GetFileName(Trim(cbxFileName.Text));
    if FileList <> nil then
    begin
      Index := FileList.IndexOf(FileName);
      if Index = -1 then
        FileList.Insert(0, FDialogData.FileName)
      else
        FileList.Exchange(0, Index);
    end;
  end;  
end;

procedure TdxfmPrintDialog.SetActiveControl;
begin
  if FseCopies.CanFocus then
    ActiveControl := FseCopies
  else 
    if cbxNumberOfPages.CanFocus then 
      ActiveControl := cbxNumberOfPages
    else
      if btnOK.CanFocus then 
        ActiveControl := btnOK;  
end;

procedure TdxfmPrintDialog.SetupDialog(const APrintDlgData: TdxPrintDlgData);
begin
//  FModified := False;
  FControlsUpdating := True;
  try
    FSaveDialogData := APrintDlgData.DialogData;
    FDialogData := FSaveDialogData;

    FIsCheckUserInput := APrintDlgData.IsCheckUserInput;

    with APrintDlgData do
    begin
      { visible }
      btnPrinterProperties.Visible := pdbPrinterProperties in ButtonsVisible;
      btnNetwork.Visible := (pdbNetwork in ButtonsVisible) and not IsWin9X;
      chbxPrintToFile.Visible := pdoPrintToFile in OptionsVisible;
      cbxFileName.Visible := pdoPrintToFile in OptionsVisible;
      btnBrowse.Visible := pdoPrintToFile in OptionsVisible;

      rbtnAllPages.Visible := pdoAllPages in OptionsVisible;
      rbtnCurrentPage.Visible := pdoCurrentPage in OptionsVisible;
      rbtnSelection.Visible := pdoSelection in OptionsVisible;
      rbtnPageRanges.Visible := pdoPageRange in OptionsVisible;
      lblDescription.Visible := rBtnPageRanges.Visible;
      edPageRanges.Visible := pdoPageRange in OptionsVisible;
      gbxPageRange.Visible := rbtnAllPages.Visible or rbtnCurrentPage.Visible or
        rbtnSelection.Visible or rbtnPageRanges.Visible;

      btnPageSetup2.Visible := pdbPageSetup in ButtonsVisible;
      btnDefineStyles.Visible := pdbDefineStyles in ButtonsVisible;

      btnPageSetup.Visible := pdbPageSetup in ButtonsVisible;
      btnPreview.Visible := pdbPreview in ButtonsVisible;
      btnHelp.Visible := pdbHelp in ButtonsVisible;
      if btnPreview.Visible and not btnPageSetup.Visible then
        btnPreview.BoundsRect := btnPageSetup.BoundsRect;

      if not (pdoPrintToFile in OptionsVisible) then
      begin
        pnlPrintToFile.Visible := False;
        pnlTop.Height := pnlTop.Height - pnlPrintToFile.Height;
        Height := Height - pnlPrintToFile.Height;
      end;
      if (DialogData.StyleManager = nil) or not (pdoPrintStyles in OptionsVisible) then
      begin
        pnlPrintStyles.Visible := False;
        Height := Height - pnlPrintStyles.Height;
      end;

      {enable}
      if btnPrinterProperties.Visible then
        btnPrinterProperties.Enabled := pdbPrinterProperties in ButtonsEnabled;
      if btnNetwork.Visible then
        btnNetwork.Enabled := dxPSUtl.IsNetworkPresent and (pdbNetwork in ButtonsEnabled);
      if chbxPrintToFile.Visible then
        chbxPrintToFile.Enabled := pdoPrintToFile in OptionsEnabled;
      if cbxFileName.Visible then
      begin
        cbxFileName.Enabled := pdoPrintToFile in OptionsEnabled;
        if DialogData.FileList <> nil then 
          cbxFileName.Items := DialogData.FileList;
        cbxFileName.ItemIndex := 0;
//        cbxFileName.Text := DialogData.FileName;
      end;
      if btnBrowse.Visible then
        btnBrowse.Enabled := pdoPrintToFile in OptionsEnabled;
      if rbtnAllPages.Visible then
        rbtnAllPages.Enabled := pdoAllPages in OptionsEnabled;
      if rbtnCurrentPage.Visible then
        rbtnCurrentPage.Enabled := pdoCurrentPage in OptionsEnabled;
      if rbtnSelection.Visible then
        rbtnSelection.Enabled := pdoSelection in OptionsEnabled;
      if rBtnPageRanges.Visible then
        rBtnPageRanges.Enabled := pdoPageRange in OptionsEnabled;
      if edPageRanges.Visible then
        edPageRanges.Enabled := pdoPageRange in OptionsEnabled;
      if lblDescription.Visible then
        lblDescription.Enabled := rBtnPageRanges.Enabled;
      if edPageRanges.Enabled and edPageRanges.Visible then
        edPageRanges.Text := DialogData.Pages;

      if btnPageSetup.Visible then
        btnPageSetup.Enabled := pdbPageSetup in ButtonsEnabled;
      if btnPreview.Visible then
        btnPreview.Enabled := pdbPreview in ButtonsEnabled;
      if btnHelp.Visible then
        btnHelp.Enabled := pdbHelp in ButtonsEnabled;

      Caption := Title;

      FOnClose := Events.OnClose;
      FOnShow := Events.OnShow;
      FOnPageSetup := Events.OnPageSetup;
    end;
  finally
    UpdateControlsState;
    FControlsUpdating := False;
  end;
end;

procedure TdxfmPrintDialog.StartSettings;
begin
  FModified := False;
  FControlsUpdating := True;
  try
    LoadStrings;
    RefreshPrinterList;
    
    chbxPrintToFile.Checked := FDialogData.PrintToFile;
    rbtnAllPages.Checked := FDialogData.PageRanges = prAll;
    rbtnCurrentPage.Checked := FDialogData.PageRanges = prCurrent;
    rbtnPageRanges.Checked := FDialogData.PageRanges = prRange;
    rbtnSelection.Checked := FDialogData.PageRanges = prSelection;
    edPageRanges.Text := FDialogData.Pages;
    cbxNumberOfPages.ItemIndex := Integer(FDialogData.PageNums);
    FseCopies.AsInteger := FDialogData.Copies;
    chbxCollate.Checked := FDialogData.Collate;
    if FDialogData.StyleManager <> nil then
    begin
      btnPageSetup.Caption := cxGetResourceString(@sdxBtnPrintStyles);
      btnPageSetup.Glyph := FGlyphs[not pnlPrintStyles.Visible];
    end
    else 
      if Assigned(FOnPageSetup) then
      begin
        btnPageSetup.Caption := cxGetResourceString(@sdxBtnPageSetup);
        btnPageSetup.Glyph := nil;
      end;
    cbxPrinters.Enabled := cbxPrinters.Items.Count > 0;
//    if cbxPrinters.Enabled then cbxPrinters.ItemIndex := 0;
    if btnPrinterProperties.Visible and btnPrinterProperties.Enabled then
      btnPrinterProperties.Enabled := cbxPrinters.Items.Count > 0;

    btnHelp.Visible := HelpContext <> 0;
    if HelpContext = 0 then
    begin
      btnOK.BoundsRect := btnCancel.BoundsRect;
      btnCancel.BoundsRect := btnHelp.BoundsRect;
    end;
  finally
    UpdatePrinterInfos;
    UpdateControlsState;
    FControlsUpdating := False;
  end;
end;

procedure TdxfmPrintDialog.StyleListChanged(Sender: TObject);
begin
  if Sender = FDialogData.StyleManager then 
  begin
    RefreshStyleList;
    UpdateControlsState;
  end;  
end;

procedure TdxfmPrintDialog.UpdateControlsState;
begin
  cbxFileName.Enabled := chbxPrintToFile.Enabled and chbxPrintToFile.Visible and chbxPrintToFile.Checked;
  if chbxPrintToFile.Checked then 
    cbxFileName.Color := clWindow
  else
    cbxFileName.Color := clBtnFace;
  btnBrowse.Enabled := cbxFileName.Enabled;
  btnPageSetup2.Enabled := lbxPrintStyles.ItemIndex <> -1;
  cbxPrinters.Enabled := dxPrintDevice.Printers.Count > 0; // 2.2
  if cbxPrinters.Items.Count > 0 then                      // 2.2
    cbxPrinters.ItemIndex := dxPrintDevice.PrinterIndex;   // 2.2
  btnOK.Enabled := (dxPrintDevice.Printers.Count > 0) or chbxPrintToFile.Checked;
end;

procedure TdxfmPrintDialog.UpdatePrinterInfos;
const  
  SizeReserved = 1000;
var
  PBuffer: Pointer; {PPrinterInfo2}
  PrinterInfo2: TPrinterInfo2;
  Size: DWORD;
  PrinterHandle: THandle;
begin
  try                         
    if WinSpool.OpenPrinter(dxPrintDevice.CurrentDevice, PrinterHandle, nil) then
    try
      WinSpool.GetPrinter(PrinterHandle, 2, nil, 0, @Size);
      if Size > 0 then
      begin
        Inc(Size, SizeReserved);
        PBuffer := dxAllocMem(Size);
        if PBuffer <> nil then
        try
          if WinSpool.GetPrinter(PrinterHandle, 2, PBuffer, Size, @Size) then
          begin
            PrinterInfo2 := PPrinterInfo2(PBuffer)^;

            if PrinterInfo2.cJobs > 0 then 
              lStatus.Caption := Format(cxGetResourceString(@sdxPrintDialogPSPrintingAndWaiting), [PrinterInfo2.cJobs])
            else
              lStatus.Caption := GetStatusString(PrinterInfo2.Status);

            if (dxPrintDevice.DeviceMode <> nil) and (PrinterInfo2.pDevMode <> nil) then 
              PrinterInfo2.pDevMode^ := dxPrintDevice.DeviceMode^;
	      
            if PrinterInfo2.Status = 0 then 
              lStatus.Font.Color := Font.Color
            else   
              lStatus.Font.Color := clHighlight;
              
            lType.Caption := StrPas(PrinterInfo2.pDriverName);
            lWhere.Caption := StrPas(PrinterInfo2.pPortName);
            lWhere.AutoSize := lWhere.Left + lWhere.Width < gbxPrinter.ClientWidth;
            if not lWhere.AutoSize then
              lWhere.Width := gbxPrinter.ClientWidth - lWhere.Left - 4;

            lComment.Caption := StrPas(PrinterInfo2.pComment);
          end;
        finally
          dxFreeMem(PBuffer, Size);
        end;
      end;
    finally
      ClosePrinter(PrinterHandle);
    end;
    FseCopies.MaxValue := dxPrintDevice.MaxCopies;
    FseCopies.MinValue := 1;
  except
    Application.HandleException(Self);
  end;
end;

procedure TdxfmPrintDialog.CMDialogChar(var Message: TCMDialogChar);
begin
  inherited;
  if IsAccel(Message.CharCode, gbxPrintStyles.Caption) then
  begin
    ActiveControl := lbxPrintStyles;
    Message.Result := 1;
  end;  
end;

end.
