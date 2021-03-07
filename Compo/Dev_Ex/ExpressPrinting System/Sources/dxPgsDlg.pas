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

unit dxPgsDlg;

interface
                                               
{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, Buttons, Menus, ToolWin, Registry, ImgList, 
  dxCore, cxClasses, dxPSESys, dxPSForm, dxBkgnd, dxPreVw, dxPSGlbl, dxfmClr,
  dxPrnPg, dxPrnDev, dxExtCtrls;
  
type
  TdxPageSetupDlgButtonKind = (psbHelp, psbStyleOptions, psbPreview, psbPrint);
  TdxPageSetupDlgButtons = set of TdxPageSetupDlgButtonKind;
  TdxPageSetupDlgOption =
    (psoCenterOnPage, psoMargins, psoPageOrder, psoShading, psoStyleCaption,
     psoHFAutoText, psoHFBackground, psoHFFont, psoHFText, psoHFFunctions,
     psoHFMargins, psoHFReverse, psoHFVertAlignment);
  TdxPageSetupDlgOptions = set of TdxPageSetupDlgOption;
  TdxHFMode = (hfmThreeSections, hfmOneSection);

const
  psbAll = [Low(TdxPageSetupDlgButtonKind)..High(TdxPageSetupDlgButtonKind)];
  psbDefault = [psbStyleOptions, psbPreview, psbPrint];
  psoAll = [Low(TdxPageSetupDlgOption)..High(TdxPageSetupDlgOption)];
  psoDefaultOptionsEnabled = psoAll;
  psoDefaultOptionsVisible = psoAll;

type
  TdxPrintStyleManager = class;
  TBasedxPrintStyle = class;
  TdxPrintStyleClass = class of TBasedxPrintStyle;
  TAbstractdxStyleManagerDesigner = class;
  TdxPageSetupDialog = class;

  TdxPrintStylePrinterPageClass = class of TdxPrintStylePrinterPage;
  
  TdxPrintStylePrinterPage = class(TdxPrinterPage)
  private
    FPrintStyle: TBasedxPrintStyle;
  protected
    function GetOwner: TPersistent; override;

    function IsPageFooterTitleStored(Index: Integer): Boolean; override;
    function IsPageHeaderTitleStored(Index: Integer): Boolean; override;
    procedure PageParamsChanged(AUpdateCodes: TdxPrinterPageUpdateCodes); override;
  public
    property PrintStyle: TBasedxPrintStyle read FPrintStyle;
  end;

  TdxPrintStyleState = (pssCopy, pssOptionsDialog);
  TdxPrintStyleStates = set of TdxPrintStyleState;

  TdxPageParamsChangedEvent = procedure(Sender: TdxPrinterPage;
    APrintStyle: TBasedxPrintStyle; AUpdateCodes: TdxPrinterPageUpdateCodes) of object;
  
  TdxFilterPaperEvent = procedure(Sender: TBasedxPrintStyle;
    const APaper: TdxPaperInfo; var AIsSupported: Boolean) of object;

  TBasedxPrintStyle = class(TComponent)
  private
    FAllowChangeHFText: Boolean;
    FAllowChangeMargins: Boolean;
    FAllowChangeOrientation: Boolean;
    FAllowChangePaper: Boolean;
    FAllowChangeScale: Boolean;
    FAllowCustomPaperSizes: Boolean;
    FBuiltIn: Boolean;
    FData: Pointer;
    FDefaultStyleGlyph: TBitmap;
    FDescription: string;
    FImageIndex: Integer;
    FIsDescriptionAssigned: Boolean;
    FIsStyleCaptionAssigned: Boolean;
    FIsStyleGlyphAssigned: Boolean;
    FPrinterPage: TdxPrinterPage;
    FShowPageSetupDlg: Boolean;
    FState: TdxPrintStyleStates;
    FStyleCaption: string;
    FStyleGlyph: TBitmap;
    FStyleManager: TdxPrintStyleManager;
    FOnDestroy: TNotifyEvent;
    FOnFilterPaper: TdxFilterPaperEvent;
    function GetDescription: string;
    function GetIndex: Integer;
    function GetIsCurrentStyle: Boolean;
    function GetStyleCaption: string;
    function GetStyleGlyph: TBitmap;
    function IsDescriptionStored: Boolean;
    function IsStyleCaptionStored: Boolean;
    function IsStyleGlyphStored: Boolean;
    procedure SetBuiltIn(Value: Boolean);
    procedure SetDescription(const Value: string);
    procedure SetImageIndex(Value: Integer);
    procedure SetIndex(Value: Integer);
    procedure SetIsCurrentStyle(Value: Boolean);
    procedure SetPrinterPage(Value: TdxPrinterPage);
    procedure SetStyleCaption(const Value: string);
    procedure SetStyleGlyph(Value: TBitmap);
    procedure SetStyleManager(Value: TdxPrintStyleManager);

    procedure DesignerModified;
    procedure DesignerUpdate(TheAll: Boolean);
    function IsDesigning: Boolean;
    function IsLoading: Boolean;
    
    procedure ReadData(Reader: TReader);
    procedure ReadIsDescriptionAssigned(Reader: TReader);
    procedure ReadIsStyleCaptionAssigned(Reader: TReader);
    procedure ReadIsStyleGlyphAssigned(Reader: TReader);
    procedure WriteData(Writer: TWriter);
    procedure WriteIsDescriptionAssigned(Writer: TWriter);
    procedure WriteIsStyleCaptionAssigned(Writer: TWriter);
    procedure WriteIsStyleGlyphAssigned(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadState(Reader: TReader); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;

    function GetAllowChangeHFText: Boolean; virtual;
    function GetAllowChangeMargins: Boolean; virtual;
    function GetAllowChangeOrientation: Boolean; virtual;
    function GetAllowChangePaper: Boolean; virtual;
    function GetAllowChangeScale: Boolean; virtual;
    function GetAllowCustomPaperSizes: Boolean; virtual;
    procedure SetAllowChangeHFText(Value: Boolean); virtual;
    procedure SetAllowChangeMargins(Value: Boolean); virtual;
    procedure SetAllowChangeOrientation(Value: Boolean); virtual;
    procedure SetAllowChangePaper(Value: Boolean); virtual;
    procedure SetAllowChangeScale(Value: Boolean); virtual;
    procedure SetAllowCustomPaperSizes(Value: Boolean); virtual;

    function CreatePrinterPage: TdxPrinterPage; virtual;
    function GetPrinterPageClass: TdxPrinterPageClass; virtual;
    procedure InitializePrinterPage(APrinterPage: TdxPrinterPage); virtual;
    
    procedure DoAfterPrinting; dynamic;
    procedure DoBeforePrinting; dynamic;
    procedure DoDestroy; dynamic;
    function IsSupportedPaper(const APaper: TdxPaperInfo): Boolean; dynamic;
    procedure PageParamsChanged(AUpdateCodes: TdxPrinterPageUpdateCodes); dynamic;

    procedure InitializeDefaultStyleGlyph(ABitmap: TBitmap); virtual;
    procedure StyleGlyphChanged(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure Assign(Source: TPersistent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    class function StyleClass: TdxPrintStyleClass;

    function DefaultDescription: string; virtual;
    function DefaultPageFooterText(APart: TdxPageTitlePart): string; virtual;
    function DefaultPageHeaderText(APart: TdxPageTitlePart): string; virtual;
    function DefaultStyleCaption: string; virtual;
    function DefaultStyleGlyph: TBitmap; virtual;

    procedure AfterPrinting;
    procedure BeforePrinting;

    procedure GetFilteredPapers(AStrings: TStrings);
    
    function PageSetup: Boolean; overload;
    function PageSetup(AnActivePageIndex: Integer; AShowPreviewBtn, AShowPrintBtn: Boolean; 
      out APreviewBtnClicked, APrintBtnClicked: Boolean): Boolean; overload;
    function PageSetup(AnActivePageIndex: Integer; 
      APreviewBtnClicked, APrintBtnClicked: PBoolean): Boolean; overload; //{$IFDEF DELPHI6} deprecated; {$ENDIF}
    function PageSetupEx(AnActivePageIndex: Integer;
      APreviewBtnClicked, APrintBtnClicked: PBoolean): Boolean; overload; //{$IFDEF DELPHI6} deprecated; {$ENDIF}
   
    function SetupOptions: Boolean; // obsolete - do nothing !
    
    procedure RestoreDefaultGlyph; virtual;
    procedure RestoreDefaults; virtual;

    property BuiltIn: Boolean read FBuiltIn write SetBuiltIn;
    property Data: Pointer read FData write FData;
    property IsStyleGlyphAssigned: Boolean read FIsStyleGlyphAssigned;
    property State: TdxPrintStyleStates read FState;
    property StyleManager: TdxPrintStyleManager read FStyleManager write SetStyleManager;
  published
    property AllowChangeHFText: Boolean read GetAllowChangeHFText write SetAllowChangeHFText default True;
    property AllowChangeMargins: Boolean read GetAllowChangeMargins write SetAllowChangeMargins default True;
    property AllowChangeOrientation: Boolean read GetAllowChangeOrientation write SetAllowChangeOrientation default True;
    property AllowChangePaper: Boolean read GetAllowChangePaper write SetAllowChangePaper default True;
    property AllowChangeScale: Boolean read GetAllowChangeScale write SetAllowChangeScale default True;
    property AllowCustomPaperSizes: Boolean read GetAllowCustomPaperSizes write SetAllowCustomPaperSizes default True;
    property Description: string read GetDescription write SetDescription stored IsDescriptionStored;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property Index: Integer read GetIndex write SetIndex stored False;
    property IsCurrentStyle: Boolean read GetIsCurrentStyle write SetIsCurrentStyle stored False;
    property PrinterPage: TdxPrinterPage read FPrinterPage write SetPrinterPage;
    property ShowPageSetupDlg: Boolean read FShowPageSetupDlg write FShowPageSetupDlg stored False;
    property StyleCaption: string read GetStyleCaption write SetStyleCaption stored IsStyleCaptionStored;
    property StyleGlyph: TBitmap read GetStyleGlyph write SetStyleGlyph stored IsStyleGlyphStored; {32 x 32}

    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnFilterPaper: TdxFilterPaperEvent read FOnFilterPaper write FOnFilterPaper;
  end;

  TdxPrintStyleManager = class(TComponent)
  private
    FAlreadySaved: Boolean;
    FAutoHFTextEntries: TStrings;
    FAutoSave: Boolean;
    FCloneStyleCaptionPrefix: string;
    FCurrentStyle: TBasedxPrintStyle;
    FDesigner: TAbstractdxStyleManagerDesigner;
    FHelpContext: THelpContext;
    FImages: TImageList;
    FInternalStreaming: Boolean;
    FIsCloneStyleCaptionPrefixAssigned: Boolean;
    FIsTitleAssigned: Boolean;
    FLoadedExistingStyles: TStringList;
    FPageSetupDialog: TdxPageSetupDialog;
    FPreviewBtnClicked: Boolean;
    FPrintBtnClicked: Boolean;
    FStorageName: string;
    FStyles: TList;
    FTitle: string;
    FVersion: Integer;
    FUpdateCount: Integer;
    FWindowHandle: hWnd;
    FOnChangeCurrentStyle: TNotifyEvent;
    FOnStyleListChanged: TNotifyEvent;
    function GetCloneStyleCaptionPrefix: string;
    function GetCount: Integer;
    function GetCurrentStyleIndex: Integer;
    function GetRegistryPath: string;
    function GetStyle(Index: Integer): TBasedxPrintStyle;
    function GetTitle: string;
    function IsAutoHFTextEntriesStored: Boolean;
    function IsCloneStyleCaptionPrefixStored: Boolean;
    function IsTitleStored: Boolean;
    procedure SetAutoHFTextEntries(Value: TStrings);
    procedure SetCloneStyleCaptionPrefix(const Value: string);
    procedure SetCurrentStyle(Value: TBasedxPrintStyle);
    procedure SetCurrentStyleIndex(Value: Integer);
    procedure SetImages(Value: TImageList);
    procedure SetNewStyleCaption(AStyle: TBasedxPrintStyle; AIndex: Integer);
    procedure SetPageSetupDialog(Value: TdxPageSetupDialog);
    procedure SetStyle(Index: Integer; Value: TBasedxPrintStyle);
    procedure SetTitle(const Value: string);

    function AllowAutoSave: Boolean;
    procedure DesignerModified;
    procedure DesignerUpdate(AStyle: TBasedxPrintStyle);
    function IsDesigning: Boolean;
    function IsDestroying: Boolean;
    function IsLoading: Boolean;

    procedure FreeAndNilStyles;
    procedure InsertStyle(Value: TBasedxPrintStyle);
    procedure MoveStyle(ACurIndex, ANewIndex: Integer);
    procedure RemoveStyle(Value: TBasedxPrintStyle);
    procedure ResyncCurrentStyle(AIndex: Integer);

    // AutoHFTextEntries - v2.2
    procedure AutoHFTextEntriesChanged(Sender: TObject);
    procedure OnAutoHFTextEntryClick(Sender: TObject);
    procedure OnEditAutoHFTextEntriesClick(Sender: TObject);

    procedure WndProc(var Message: TMessage);

    procedure SetNameHandler(Reader: TReader; Component: TComponent; var Name: string);

    procedure ReadIsCloneStyleCaptionPrefixAssigned(Reader: TReader);
    procedure ReadIsTitleAssigned(Reader: TReader);
    procedure WriteIsCloneStyleCaptionPrefixAssigned(Writer: TWriter);
    procedure WriteIsTitleAssigned(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ReadState(Reader: TReader); override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetName(const NewName: TComponentName); override;

    function CreateAutoHFTextEntries: TStrings; virtual;
    procedure DoRestoreDefaults; virtual;

    procedure ChangeCurrentStyle; dynamic;
    procedure PageParamsChanged(APrintStyle: TBasedxPrintStyle;
      AUpdateCodes: TdxPrinterPageUpdateCodes); dynamic;
    procedure StyleListChanged; dynamic;

    property RegistryPath: string read GetRegistryPath;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function AddStyle(AStyleClass: TdxPrintStyleClass): TBasedxPrintStyle;
    function AddStyleEx(AStyleClass: TdxPrintStyleClass; AOwner: TComponent): TBasedxPrintStyle;
    procedure AssignStyles(Source: TdxPrintStyleManager);
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure DeleteNonBuiltIns;
    function IndexOfStyle(Value: TBasedxPrintStyle): Integer;
    function NonBuiltInsExists: Boolean;
    function StyleByCaption(const ACaption: string): TBasedxPrintStyle;
    function StyleByName(const AName: string): TBasedxPrintStyle;

    function BeginClone(AIndex: Integer): TBasedxPrintStyle;
    procedure EndClone(AStyle: TBasedxPrintStyle);

    procedure BeginUpdate;
    procedure EndUpdate;

    function DefaultCloneStyleCaptionPrefix: string; virtual;
    function DefaultTitle: string; virtual;

    // AutoHFTextEntries - v2.2
    procedure BuildAutoHFTextEntriesMenu(ARootItem: TComponent; AData: Pointer;
      AIncludeSetupAutoHFTextEntriesItem: Boolean = True);
    procedure RefreshAutoHFTextEntries;
    function ShowAutoHFTextEntriesDlg: Boolean;

    procedure LoadFromRegistry(const APath: string);
    procedure SaveToRegistry(const APath: string);

    procedure DefinePrintStylesDlg(out APreviewBtnClicked, APrintBtnClicked: Boolean); overload;
    procedure DefinePrintStylesDlg(APreviewBtnClicked, APrintBtnClicked: PBoolean); overload; {$IFDEF DELPHI6} deprecated; {$ENDIF}

    procedure RestoreDefaultAutoHFTextEntries;
    procedure RestoreDefaults;
    procedure RestoreDefaultStyles;

    procedure LoadFromFile(const AName: string);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(const AName: string);
    procedure SaveToStream(AStream: TStream);

    property Count: Integer read GetCount;
    property CurrentStyleIndex: Integer read GetCurrentStyleIndex write SetCurrentStyleIndex;
    property Designer: TAbstractdxStyleManagerDesigner read FDesigner; {accessible only in DesignTime}
    property PreviewBtnClicked: Boolean read FPreviewBtnClicked;
    property PrintBtnClicked: Boolean read FPrintBtnClicked;
    property Styles[Index: Integer]: TBasedxPrintStyle read GetStyle write SetStyle; default;
    property UpdateCount: Integer read FUpdateCount;
  published
    property AutoHFTextEntries: TStrings read FAutoHFTextEntries write SetAutoHFTextEntries stored IsAutoHFTextEntriesStored;
    property AutoSave: Boolean read FAutoSave write FAutoSave default False;
    property CloneStyleCaptionPrefix: string read GetCloneStyleCaptionPrefix write SetCloneStyleCaptionPrefix stored IsCloneStyleCaptionPrefixStored;
    property CurrentStyle: TBasedxPrintStyle read FCurrentStyle write SetCurrentStyle;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property Images: TImageList read FImages write SetImages;
    property PageSetupDialog: TdxPageSetupDialog read FPageSetupDialog write SetPageSetupDialog;
    property StorageName: string read FStorageName write FStorageName;
    property Title: string read GetTitle write SetTitle stored IsTitleStored;
    property Version: Integer read FVersion write FVersion;

    property OnChangeCurrentStyle: TNotifyEvent read FOnChangeCurrentStyle write FOnChangeCurrentStyle;
    property OnStyleListChanged: TNotifyEvent read FOnStyleListChanged write FOnStyleListChanged;
  end;

  TAbstractdxStyleManagerDesigner = class
  private
    FStyleManager: TdxPrintStyleManager;
  protected
    procedure Modified; virtual; abstract;
    procedure Update(AItem: TBasedxPrintStyle); virtual; abstract;
  public
    constructor Create(AStyleManager: TdxPrintStyleManager);
    destructor Destroy; override;

    procedure BeginUpdate; virtual; abstract;
    procedure CancelUpdate; virtual; abstract;
    procedure EndUpdate; virtual; abstract;

    property StyleManager: TdxPrintStyleManager read FStyleManager;
  end;

  { TdxPageSetupDialog }

  TdxCustomDrawPreviewEvent = procedure(APrintStyle: TBasedxPrintStyle;
    ACanvas: TCanvas; APageRect, AContentRect, AHeaderRect, AFooterRect: TRect) of object;

  PdxPageSetupDlgEvents = ^TdxPageSetupDlgEvents;
  TdxPageSetupDlgEvents = record
    OnClose: TNotifyEvent;
    OnCustomDrawPreview: TdxCustomDrawPreviewEvent;
    OnShow: TNotifyEvent;
  end;

  PdxPageSetupDlgData = ^TdxPageSetupDlgData;
  TdxPageSetupDlgData = {$IFNDEF DELPHI12} packed {$ENDIF} record
    PrintStyle: TBasedxPrintStyle;
    ActivePageIndex: Integer;
    Title: string;
    HelpContext: THelpContext;
    HFMode: TdxHFMode;
    ButtonsEnabled: TdxPageSetupDlgButtons;
    ButtonsVisible: TdxPageSetupDlgButtons;
    OptionsEnabled: TdxPageSetupDlgOptions;
    OptionsVisible: TdxPageSetupDlgOptions;
    Events: TdxPageSetupDlgEvents;
    PreviewBtnClicked: Boolean;
    PrintBtnClicked: Boolean;
    iReserved: Integer;
  end;

  TdxPageSetupDialog = class(TComponent)
  private
    FActivePageIndex: Integer;
    FButtonsEnabled: TdxPageSetupDlgButtons;
    FButtonsVisible: TdxPageSetupDlgButtons;
    FHFMode: TdxHFMode;
    FHelpContext: THelpContext;
    FIsTitleAssigned: Boolean;
    FOptionsEnabled: TdxPageSetupDlgOptions;
    FOptionsVisible: TdxPageSetupDlgOptions;
    FPreviewBtnClicked: Boolean;
    FPrintBtnClicked: Boolean;
    FPrintStyle: TBasedxPrintStyle;
    FTitle: string;
    FOnClose: TNotifyEvent;
    FOnCustomDrawPreview: TdxCustomDrawPreviewEvent;
    FOnShow: TNotifyEvent;
    function GetTitle: string;
    function IsTitleStored: Boolean;
    procedure SetPrintStyle(Value: TBasedxPrintStyle);
    procedure SetTitle(const Value: string);

    procedure ReadIsTitleAssigned(Reader: TReader);
    procedure WriteIsTitleAssigned(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;

    function DefaultTitle: string; virtual;
    function Execute: Boolean;
    function RealTitle: string;
    procedure RestoreDefaults; virtual;
    
    property PreviewBtnClicked: Boolean read FPreviewBtnClicked;
    property PrintBtnClicked: Boolean read FPrintBtnClicked;
  published
    property ActivePageIndex: Integer read FActivePageIndex write FActivePageIndex default 0;
    property ButtonsEnabled: TdxPageSetupDlgButtons read FButtonsEnabled write FButtonsEnabled
      default [psbStyleOptions, psbPreview, psbPrint];
    property ButtonsVisible: TdxPageSetupDlgButtons read FButtonsVisible write FButtonsVisible
      default [psbStyleOptions, psbPreview, psbPrint];
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property HFMode: TdxHFMode read FHFMode write FHFMode default hfmThreeSections;
    property OptionsEnabled: TdxPageSetupDlgOptions read FOptionsEnabled write FOptionsEnabled
      default [Low(TdxPageSetupDlgOption)..High(TdxPageSetupDlgOption)]; {psoDefaultOptionsEnabled}
    property OptionsVisible: TdxPageSetupDlgOptions read FOptionsVisible write FOptionsVisible 
      default psoDefaultOptionsVisible;
    property PrintStyle: TBasedxPrintStyle read FPrintStyle write SetPrintStyle;
    property Title: string read GetTitle write SetTitle stored IsTitleStored;

    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnCustomDrawPreview: TdxCustomDrawPreviewEvent read FOnCustomDrawPreview write FOnCustomDrawPreview;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  end;

  TdxfmPageSetupDialog = class(TCustomdxPSForm)
    pnlStyleName: TPanel;
    lblStyleName: TLabel;
    edStyleName: TEdit;
    ilPrintOrders: TImageList;
    ilPaperTypes: TImageList;
    btnOptions: TButton;
    pnlButtons: TPanel;
    btnPrintPreview: TButton;
    btnPrint: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    Panel4: TPanel;
    pgctrlMain: TPageControl;
    tshPage: TTabSheet;
    Panel5: TPanel;
    gbxPaper: TGroupBox;
    lblPaperType: TLabel;
    lblPaperDimensions: TLabel;
    lblPaperSource: TLabel;
    lblPaperWidth: TLabel;
    lblPaperHeight: TLabel;
    bvlPaperDimensions: TBevel;
    bvlPaperSource: TBevel;
    bvlPaperType: TBevel;
    bvlPaperWidthHolder: TBevel;
    bvlPaperHeightHolder: TBevel;
    lbxPaperType: TListBox;
    cbxPaperSource: TComboBox;
    Panel1: TPanel;
    tshMargins: TTabSheet;
    pnlInMargins: TPanel;
    lblPreview: TLabel;
    Bevel12: TBevel;
    bvlPreviewHolder: TBevel;
    Panel14: TPanel;
    tshHeaderFooter: TTabSheet;
    Panel7: TPanel;
    pnlBottom: TPanel;
    pnlHFOpt: TPanel;
    pnlHeader: TPanel;
    pnlHeaderMemos: TPanel;
    pnlHeaderFont: TPanel;
    btnHeaderFont: TButton;
    edHeaderFontInfo: TEdit;
    btnHeaderBackground: TBitBtn;
    pnlHeaderTitle: TPanel;
    lblHeader: TLabel;
    bvlHeader: TBevel;
    pnlFooter: TPanel;
    pnlFooterTitle: TPanel;
    lblFooter: TLabel;
    bvlFooter: TBevel;
    pnlFooterFont: TPanel;
    btnFooterFont: TButton;
    edFooterFontInfo: TEdit;
    btnFooterBackGround: TBitBtn;
    pnlFooterMemos: TPanel;
    pnlReverse: TPanel;
    chbxReverseOnEvenPages: TCheckBox;
    tshScaling: TTabSheet;
    Panel2: TPanel;
    bvlAdjustToHolder: TBevel;
    bvlFitToPageHolder: TBevel;
    lblPagesWideBy: TLabel;
    lblPercentOfNormalSize: TLabel;
    bvlFitToPageTallHolder: TBevel;
    lblTall: TLabel;
    rbtnAdjustTo: TRadioButton;
    rbtnFitTo: TRadioButton;
    ilBins: TImageList;
    ilPapers: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel6: TPanel;
    gbxOrientation: TGroupBox;
    bvlOrientationHolder: TBevel;
    rBtnLandscape: TRadioButton;
    rBtnPortrait: TRadioButton;
    gbxPrintOrder: TGroupBox;
    pbxPageOrder: TPaintBox;
    rbtnOverThenDown: TRadioButton;
    rbtnDownThenOver: TRadioButton;
    gbxShading: TGroupBox;
    chbxShading: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel8: TPanel;
    gbxMargins: TGroupBox;
    pnlMargins: TPanel;
    lblMarginTop: TLabel;
    lblMarginBottom: TLabel;
    lblMarginLeft: TLabel;
    lblMarginRight: TLabel;
    bvlMarginTopHolder: TBevel;
    bvlMarginBottomHolder: TBevel;
    bvlMarginLeftHolder: TBevel;
    bvlMarginRightHolder: TBevel;
    pnlHFMargins: TPanel;
    lblMarginHeader: TLabel;
    lblMarginFooter: TLabel;
    bvlMarginHeaderHolder: TBevel;
    bvlMarginFooterHolder: TBevel;
    Panel3: TPanel;
    btnFix: TButton;
    btnRestoreOriginalMargins: TButton;
    pnlCenterOnPage: TPanel;
    lblCenterOnPage: TLabel;
    bvlCenterOnPage: TBevel;
    chbxCenterHorz: TCheckBox;
    chbxCenterVert: TCheckBox;
    bvlMarginsWarningHolder: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    pnlHeaderMemosHost: TPanel;
    memHeaderLeft: TMemo;
    memHeaderCenter: TMemo;
    memHeaderRight: TMemo;
    Label14: TLabel;
    Label15: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    pnlFooterMemosHost: TPanel;
    memFooterLeft: TMemo;
    memFooterCenter: TMemo;
    memFooterRight: TMemo;
    Label18: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Panel9: TPanel;
    pnlVertAlignment: TPanel;
    gbxVertAlignment: TGroupBox;
    tbTAVert: TToolBar;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    gbxFunctions: TGroupBox;
    pnlToolBar: TPanel;
    tbPredefined: TToolBar;
    procedure btnHFFontClick(Sender: TObject);
    procedure SpecialInsertClick(Sender: TObject);
    procedure pgctrlMainChange(Sender: TObject);
    procedure BackgroundClick(Sender: TObject);
    procedure VertTextAlignClick(Sender: TObject);
    procedure memHeaderLeftChange(Sender: TObject);
    procedure chbxReverseOnEvenPagesClick(Sender: TObject);
    procedure btnPrintPreviewClick(Sender: TObject);
    procedure lblMarginTopClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure lblPaperSourceClick(Sender: TObject);
    procedure pbxPageOrderPaint(Sender: TObject);
    procedure PageOrderClick(Sender: TObject);
    procedure pbxPageOrderDblClick(Sender: TObject);
    procedure CenterOnPageClick(Sender: TObject);
    procedure OrientationClick(Sender: TObject);
    procedure cbxPaperSourceChange(Sender: TObject);
    procedure lbxPaperTypeClick(Sender: TObject);
    procedure ScalingClick(Sender: TObject);
    procedure cbxPaperSourceDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lbxPaperTypeDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoChange(Sender: TObject);
    procedure MemoEnter(Sender: TObject);
    procedure MemoExit(Sender: TObject);
    procedure edStyleNameChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edStyleNameExit(Sender: TObject);
    procedure chbxShadingClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pgctrlMainChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure btnRestoreOriginalMarginsClick(Sender: TObject);
    procedure btnFixClick(Sender: TObject);
    procedure OrientationDblClick(Sender: TObject);
  private
    FBmpArrow: TBitmap;
    FControlsUpdating: Boolean;
    FilPredefined: TImageList;
    FFooterBkGndGlyph: TBitmap;
    FHeaderBkGndGlyph: TBitmap;
    FHFFunctionList: TStringList;
    FModified: Boolean;
    FMarginsChanged: Boolean;
    FMarginsChanging: Boolean;
    FMarginsInvalid: Boolean;
    FMarginsOutside: Boolean;
    FOrientationPreview: TdxPreview;
    FPaperSizeLocked: Boolean;
    FPreview: TdxPreview;
    FPreviewBtnClicked: Boolean;
    FPrintBtnClicked: Boolean;
    FPrintStyle: TBasedxPrintStyle;
    FSavePrintStyle: TBasedxPrintStyle;
    FStyleManager: TdxPrintStyleManager;
    FwpMargins: TdxPSWarningPane;
    
    FOnClose: TNotifyEvent;
    FOnCustomDrawPreview: TdxCustomDrawPreviewEvent;
    FOnShow: TNotifyEvent;
    procedure AdjustToExit(Sender: TObject);
    procedure AutoHFTextEntriesClick(Sender: TObject);
    procedure ChangeBkgndGlyph(AGlyph: TBitmap; ABackground: TdxBackground);
    procedure FitToPageChange(Sender: TObject);
    procedure FitToPageExit(Sender: TObject);
    procedure FitToPageTallExit(Sender: TObject);
    procedure MarginButtonClick(Sender: TObject; ButtonType: TdxButtonType;
      Button: TUDBtnType);
    procedure MarginChange(Sender: TObject);
    procedure MarginExit(Sender: TObject);
    procedure OrientationPreviewCalcPageCount(Sender: TObject);
    procedure PaperHeightButtonClick(Sender: TObject; ButtonType: TdxButtonType;
      Button: TUDBtnType);
    procedure PaperWidthButtonClick(Sender: TObject; ButtonType: TdxButtonType;
      Button: TUDBtnType);
    procedure PaperHeightExit(Sender: TObject);
    procedure PaperWidthExit(Sender: TObject);
    procedure PaperWidthChange(Sender: TObject);
    procedure PaperHeightChange(Sender: TObject);
    procedure PreviewCalcPageCount(Sender: TObject);
    procedure PreviewDrawPageContent(Sender: TObject; ACanvas: TCanvas;
      ABounds: TRect; APageIndex: Integer);
    procedure PreviewAfterDragMargin(Sender: TObject; AMargin: TdxPreviewPageMargin);
    procedure ScaleChanged(Sender: TObject);

    procedure CheckModified;
    procedure CreateControls;
    procedure EnabledMemoAttr(AEnabled: Boolean);
    function FindControlPageIndex(AControl: TWinControl): Integer;
    procedure FixupMargins;
    procedure FixupMarginsOutside;
    function GetEditColor(Value: Boolean): TColor;
    function GetCurrentPaperInfo: TdxPaperInfo;
    function GetPage: TdxPrinterPage;
    function GetPaperInfo(Index: Integer): TdxPaperInfo;
    function GetPaperInfoCount: Integer;
    procedure LoadStrings;
    procedure RestoreOriginalMargins;
    procedure SaveMargins;
    procedure SaveStyleCaption;
    procedure SaveUserInput;
    procedure SetMarginsInvalid(Value: Boolean);
    procedure SetMarginsOutside(Value: Boolean);
    procedure SetupDialog(const APageSetupDlgData: TdxPageSetupDlgData);
    procedure StartSetting;
    procedure TrySetActiveControl(AControl: TWinControl);
    procedure UpdateControlsState;
    procedure UpdateMarginsBounds;
    procedure UpdateMarginsEdits;
    procedure UpdatePageInfos;
    procedure UpdatePreviewMargin(const AValue: Extended; AMargin: TdxPreviewPageMargin);
    procedure UpdatePreviewMargins;
    procedure UpdateWarningPane(AValue, APairValue: Boolean; const AHint, APairHint: string);
    function ValidateMargins(out AInvalidMarginControl: TWinControl): Boolean;
    function ValidateMarginsOutside(out AInvalidMarginControl: TWinControl): Boolean;
    function ValidateStyleCaption: Boolean;
    function ValidateUserInput(out AControl: TWinControl): Boolean;

    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;

    property MarginsInvalid: Boolean read FMarginsInvalid write SetMarginsInvalid;
    property MarginsOutside: Boolean read FMarginsOutside write SetMarginsOutside;
  protected
    procedure CreateWnd; override;
    procedure DoHide; override;
    procedure DoShow; override;
  public
    FseAdjustTo: TdxPSSpinEdit;
    FseFitToPage: TdxPSSpinEdit;
    FseFitToPageTall: TdxPSSpinEdit;
    FseMarginBottom: TdxPSSpinEdit;
    FseMarginFooter: TdxPSSpinEdit;
    FseMarginHeader: TdxPSSpinEdit;
    FseMarginLeft: TdxPSSpinEdit;
    FseMarginRight: TdxPSSpinEdit;
    FseMarginTop: TdxPSSpinEdit;
    FsePaperHeight: TdxPSSpinEdit;
    FsePaperWidth: TdxPSSpinEdit;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
    
    procedure SetPrintStyle(Value: TBasedxPrintStyle);

    property CurrentPaperInfo: TdxPaperInfo read GetCurrentPaperInfo;
    property Modified: Boolean read FModified;
    property Page: TdxPrinterPage read GetPage;
    property PaperInfoCount: Integer read GetPaperInfoCount;
    property PaperInfos[Index: Integer]: TdxPaperInfo read GetPaperInfo;
    property PreviewBtnClicked: Boolean read FPreviewBtnClicked;
    property PrintBtnClicked: Boolean read FPrintBtnClicked;
    property PrintStyle: TBasedxPrintStyle read FPrintStyle;
    property OnCustomDrawPreview: TdxCustomDrawPreviewEvent read FOnCustomDrawPreview write FOnCustomDrawPreview;
  end;

  TdxHFFunctionFormatObjectClass = class of TdxHFFunctionFormatObject;
  
  TdxHFFunctionFormatObject = class
  private
    FCurrentPage: Integer;
    FDateFormat: string;
    FDateTime: TDateTime;
    FMachineName: string;
    FPageNumberFormat: TdxPageNumberFormat;
    FStartPageIndex: Integer;
    FTimeFormat: string;
    FTotalPages: Integer;
    FUserName: string;
  protected
    procedure Initialize; virtual;
  public
    constructor Create; virtual;
    property CurrentPage: Integer read FCurrentPage write FCurrentPage;
    property DateFormat: string read FDateFormat write FDateFormat;
    property DateTime: TDateTime read FDateTime write FDateTime;
    property MachineName: string read FMachineName write FMachineName;
    property PageNumberFormat: TdxPageNumberFormat read FPageNumberFormat write FPageNumberFormat;
    property StartPageIndex: Integer read FStartPageIndex write FStartPageIndex;
    property TimeFormat: string read FTimeFormat write FTimeFormat;
    property TotalPages: Integer read FTotalPages write FTotalPages;
    property UserName: string read FUserName write FUserName;
  end;

  { Function Categories }
  
  TdxHFFunctionCustomCategoryClass = class of TdxHFFunctionCustomCategory;
  TdxHFFunctionCustomCategory = class end;
  TdxHFFunctionDateTimeCategory = class(TdxHFFunctionCustomCategory);
  TdxHFFunctionPagesCategory = class(TdxHFFunctionCustomCategory);
  TdxHFFunctionAuthenticationCategory = class(TdxHFFunctionCustomCategory);

  { Function }
  
  TdxHFConvertFunction = function(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string;

  TdxHFCustomFunctionClass = class of TdxHFCustomFunction;
  
  TdxHFCustomFunction = class(TPersistent)
  private
    FGlyph: TBitmap;
    FHint: string;
    FTemplateString: string;
    procedure SetGlyph(Value: Graphics.TBitmap);
    procedure SetTemplateString(const Value: string);
  protected
    function ConvertFunc(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function DoProcess(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string; virtual;
    class function FunctionClass: TdxHFCustomFunctionClass;
    class function GetCategory: TdxHFFunctionCustomCategoryClass; virtual;
    class function GetName: string; virtual;

    property Glyph: TBitmap read FGlyph write SetGlyph;
    property Hint: string read FHint write FHint;
    property TemplateString: string read FTemplateString write SetTemplateString;
  end;

  TdxHFPagesFunctions = class(TdxHFCustomFunction)
  public
    class function GetCategory: TdxHFFunctionCustomCategoryClass; override;
  end;

  TdxHFPageNumberFunction = class(TdxHFPagesFunctions)
  protected
    function ConvertFunc(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string; override;
  public
    constructor Create; override;
    class function GetName: string; override;
  end;

  TdxHFTotalPagesFunction = class(TdxHFPagesFunctions)
  protected
    function ConvertFunc(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string; override;
  public
    constructor Create; override;
    class function GetName: string; override;
  end;

  TdxHFPageOfPagesFunction = class(TdxHFPagesFunctions)
  protected
    function ConvertFunc(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string; override;
  public
    constructor Create; override;
    class function GetName: string; override;
  end;

  TdxHFAuthenticationFunctions = class(TdxHFCustomFunction)
  public
    class function GetCategory: TdxHFFunctionCustomCategoryClass; override;
  end;

  TdxHFMachineNameFunction = class(TdxHFAuthenticationFunctions)
  protected
    function ConvertFunc(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string; override;
  public
    constructor Create; override;
    class function GetName: string; override;
  end;

  TdxHFUserNameFunction = class(TdxHFAuthenticationFunctions)
  protected
    function ConvertFunc(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string; override;
  public
    constructor Create; override;
    class function GetName: string; override;
  end;

  TdxHFDateTimeFunctions = class(TdxHFCustomFunction)
  public
    class function GetCategory: TdxHFFunctionCustomCategoryClass; override;
  end;

  TdxHFDateTimeFunction = class(TdxHFDateTimeFunctions)
  protected
    function ConvertFunc(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string; override;
  public
    constructor Create; override;
    class function GetName: string; override;
  end;

  TdxHFDateFunction = class(TdxHFDateTimeFunctions)
  protected
    function ConvertFunc(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string; override;
  public
    constructor Create; override;
    class function GetName: string; override;
  end;

  TdxHFTimeFunction = class(TdxHFDateTimeFunctions)
  protected
    function ConvertFunc(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string; override;
  public
    constructor Create; override;
    class function GetName: string; override;
  end;

  { TdxHFFunctionLibrary }
  
  TdxHFFunctionLibrary = class;

  TdxHFFunctionEnumProc = procedure(Sender: TdxHFFunctionLibrary; const AHFFunction: TdxHFCustomFunction) of object;

  TdxHFFunctionLibraryClass = class of TdxHFFunctionLibrary;
  
  TdxHFFunctionLibrary = class(TPersistent)
  private
    FItems: TStringList;
    function GetCount: Integer;
    function GetFunction(Index: Integer): TdxHFCustomFunction;
    function GetFunctionByClass(FunctionClass: TdxHFCustomFunctionClass): TdxHFCustomFunction;
    procedure SetFunction(Index: Integer; Value: TdxHFCustomFunction);
    procedure SetFunctionByClass(FunctionClass: TdxHFCustomFunctionClass; Value: TdxHFCustomFunction);
    procedure FreeAndNilItems;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    
    function Add(AFunctionClass: TdxHFCustomFunctionClass): TdxHFCustomFunction;
    procedure Clear;
    procedure Delete(AnIndex: Integer);
    procedure Enumerate(AProc: TdxHFFunctionEnumProc); virtual;
    procedure GetFunctions(AStrings: TStrings);
    procedure GetFunctionsByCategory(ACategory: TdxHFFunctionCustomCategoryClass; AStrings: TStrings);
    function IndexOf(const ATemplateString: string): Integer;
    function IndexOfByName(const AFunctionName: string): Integer;
    function IndexOfByClass(AFunctionClass: TdxHFCustomFunctionClass): Integer;
    function ProcessString(const Source: string; const AFormatObject: TdxHFFunctionFormatObject): string; virtual;

    property Count: Integer read GetCount;
    property Funcs[Index: Integer]: TdxHFCustomFunction read GetFunction write SetFunction; default;
    property FuncsByClass[FunctionClass: TdxHFCustomFunctionClass]: TdxHFCustomFunction read GetFunctionByClass write SetFunctionByClass;
  end;

  TdxStandardHFFunctionLibrary = class(TdxHFFunctionLibrary)
  protected
    procedure AddStandardFunctions; virtual;
  public
    constructor Create; override;
  end;

function dxProcessHFString(const Source: string): string;
procedure dxGetHFFunctionsList(AStrings: TStrings);
procedure dxGetHFFunctionsListByCategory(ACategory: TdxHFFunctionCustomCategoryClass; AStrings: TStrings);

type
  TdxGetDateTimeFormatsProc = procedure(AStrings: TStrings);
  TdxGetAutoHFTextEntriesProc = procedure(AStrings: TStrings);

var
  dxGetDateFormatsProc: TdxGetDateTimeFormatsProc = nil;
  dxGetTimeFormatsProc: TdxGetDateTimeFormatsProc = nil;
  dxGetAutoHFTextEntriesProc: TdxGetAutoHFTextEntriesProc = nil;

function DateFormats: TStrings;
function PageNumberFormats: TStrings;
function TimeFormats: TStrings;
procedure RefreshDateFormats;
procedure RefreshTimeFormats;
function GetFormatedDate(const ADateTime: TDateTime; const AFormat: string): string;
procedure GetFormatedDateStrings(const ADateTime: TDateTime; ADateFormats, AFormatedStrings: TStrings);
function GetFormatedTime(const ADateTime: TDateTime; const AFormat: string): string;
procedure GetFormatedTimeStrings(const ADateTime: TDateTime; ATimeFormats, AFormatedStrings: TStrings);
function DefaultAutoHFTextEntries: TStrings;

{ Registration routines }
procedure dxPSRegisterPrintStyle(AStyleClass: TdxPrintStyleClass; AMakeAsDefault: Boolean = False);
procedure dxPSUnregisterPrintStyle(AStyleClass: TdxPrintStyleClass);
procedure dxPSGetRegisteredPrintStylesList(AStrings: TStrings);

{ Utility routines }
procedure dxPSDrawStyleItem(AStyle: TBasedxPrintStyle; AListBox: TListBox;
  Index: Integer; State: TOwnerDrawState; ABounds: TRect; AMultiline, ABoldedCurrent: Boolean);
procedure dxPSDefaultDrawPagePreview(APrintStyle: TBasedxPrintStyle; ACanvas: TCanvas;
  APageBounds, AContentBounds, AHeaderBounds, AFooterBounds: TRect);
function dxPSPrintStyleUniqueName(AStyleController: TdxPrintStyleManager; AComponent: TComponent): string;
procedure dxPSSplitAutoHFTextEntry(Source: string; var APart1, APart2, APart3: string);

function dxPageSetupDialog(var APageSetupDlgData: TdxPageSetupDlgData): Boolean; 

const
  dxMaxStyleCaption = 31;
  dxFunctionDelimiters: array[Boolean] of Char = ('[', ']');
  dxHFFunctionSeparator = ',';
  dxHFFunctionLibrary: TdxHFFunctionLibrary = nil;
  dxHFFormatObject: TdxHFFunctionFormatObject = nil;
  dxDefaultPrintStyleClass: TdxPrintStyleClass = nil;
  
implementation

{$R *.DFM}

uses
  TypInfo, CommCtrl, Consts, dxPSImgs, dxPSEngn, dxPSEvnt, dxfmMnPg, dxfmDfnStl, 
  dxPSUtl, dxPSRes, dxPSAutoHFTextMnuBld, dxPSfmAutoHFTextFmt, dxPSHFToolBarBld,
  dxBase, cxDrawTextUtils;
  
const
  FDefaultAutoHFTextEntries: TStrings = nil;
  FStyleClassList: TdxPersistentClassList = nil;
  FDateFormats: TStrings = nil;
  FPageNumberFormats: TStrings = nil;
  FTimeFormats: TStrings = nil;
  
  sdxAutoHFTextEntries = '\AutoHFTextEntries';                    // Don't localize
  sdxCantCreateUniqueName = 'Can''t create unique name for %s.';  // Don't localize
  sdxStyleNameTemplate = 'Style%d';                               // Don't localize
  
function dxPageSetupDialog(var APageSetupDlgData: TdxPageSetupDlgData): Boolean;
var
  Dialog: TdxfmPageSetupDialog;
begin
  Result := False;
  if APageSetupDlgData.PrintStyle = nil then Exit;

  Dialog := TdxfmPageSetupDialog.Create(nil);
  try
    Dialog.SetupDialog(APageSetupDlgData);
    Result := Dialog.Execute;
    if Result then
    begin
      if Dialog.Modified then
        APageSetupDlgData.PrintStyle.Assign(Dialog.FPrintStyle);
      if Dialog.PreviewBtnClicked or Dialog.PrintBtnClicked then
        APageSetupDlgData.PrintStyle.IsCurrentStyle := True;
    end;
    APageSetupDlgData.ActivePageIndex := Dialog.pgctrlMain.ActivePage.PageIndex;
    APageSetupDlgData.PreviewBtnClicked := Dialog.PreviewBtnClicked;
    APageSetupDlgData.PrintBtnClicked := Dialog.PrintBtnClicked;
  finally
    Dialog.Free;
  end;
end;

{ PrintStyle Registration Routines }

procedure dxPSRegisterPrintStyle(AStyleClass: TdxPrintStyleClass;
  AMakeAsDefault: Boolean = False);
begin
  if FStyleClassList = nil then 
    FStyleClassList := TdxPersistentClassList.Create;
  FStyleClassList.Register(AStyleClass);
  if AMakeAsDefault then 
    dxDefaultPrintStyleClass := AStyleClass;
end;

procedure dxPSUnregisterPrintStyle(AStyleClass: TdxPrintStyleClass);
begin
  if FStyleClassList <> nil then
    FStyleClassList.Unregister(AStyleClass);
end;

procedure dxPSUnregisterAllPrintStyles;
begin
  FreeAndNil(FStyleClassList);
end;

procedure dxPSGetRegisteredPrintStylesList(AStrings: TStrings);
var
  I: Integer;
  StyleClass: TPersistentClass;
begin
  if FStyleClassList <> nil then 
  begin
    AStrings.BeginUpdate;
    try
      for I := 0 to FStyleClassList.Count - 1 do 
      begin
        StyleClass := FStyleClassList[I];
        AStrings.AddObject(StyleClass.ClassName, TObject(StyleClass));
      end;
    finally
      AStrings.EndUpdate;
    end;
  end;    
end;

{ utility routines }

procedure PlaceBevel(ABevel: TBevel; AControl: TControl);
var
  RightBound: Integer;
begin
  RightBound := ABevel.BoundsRect.Right;
  ABevel.Left := AControl.Left + AControl.Width + 10;
  ABevel.Width := RightBound - ABevel.Left;
end;

function MarginsMessageDlg(const Message: string): TModalResult;
var
  Form: TForm;
  B: TComponent;
begin
  Form := CreateMessageDialog(Message, mtWarning, mbYesNoCancel);
  try
    B := Form.FindComponent('Yes');
    if B is TButton then
      with TButton(B) do
      begin
        Form.Width := Form.Width + 3 * Width div 2;
        Width := 3 * Width div 2;
        Caption := cxGetResourceString(@sdxBtnFix);
      end;
      
    B := Form.FindComponent('No');
    if B is TButton then
      with TButton(B) do
      begin
        Left := Left + Width div 2;
        Width := 3 * Width div 2;
        Caption := cxGetResourceString(@sdxBtnRestoreOriginal);
      end;
      
    B := Form.FindComponent('Cancel');
    if B is TButton then
      with TButton(B) do
      begin
        Left := Left + Width;
        Width := 3 * Width div 2;
        Caption := cxGetResourceString(@sdxBtnClose);
      end;
    Result := Form.ShowModal;
  finally
    Form.Free;
  end;
end;

function MarginsOutsideMessageDlg(const Message: string): TModalResult;
var
  Form: TForm;
  B: TComponent;
begin
  Form := CreateMessageDialog(Message, mtWarning, [mbYes, mbIgnore]);
  try
    B := Form.FindComponent('Yes');
    if B is TButton then
      TButton(B).Caption := cxGetResourceString(@sdxBtnFix);
    Result := Form.ShowModal;
  finally
    Form.Free;
  end;
end;

procedure dxPSDrawStyleItem(AStyle: TBasedxPrintStyle; AListBox: TListBox;
  Index: Integer; State: TOwnerDrawState; ABounds: TRect;
  AMultiline, ABoldedCurrent: Boolean);

  function GetColor: TColor;
  begin
    if odSelected in State then
      Result := clHighlight
    else
      Result := clWindow;
  end;
  
const
  uFormat: array[Boolean] of UINT = (DT_LEFT or DT_WORDBREAK, DT_LEFT or DT_SINGLELINE or DT_VCENTER);
var
  B: TBitmap;
  S: string;
  R: TRect;
  AreImagesDrawn: Boolean;
begin
  with AListBox do
  begin
    AreImagesDrawn := (AStyle.StyleManager <> nil) and
      (AStyle.StyleManager.Images <> nil) and (AStyle.ImageIndex > -1) and
      (AStyle.ImageIndex < AStyle.StyleManager.Images.Count);

    B := nil;
    if AreImagesDrawn then B := TBitmap.Create;
    try
      if AreImagesDrawn then
      begin
        B.Width := AStyle.StyleManager.Images.Width;
        B.Height := AStyle.StyleManager.Images.Height;
        R := MakeRect(0, 0, B.Width, B.Height);
        B.Canvas.FillRect(R);
        AStyle.StyleManager.Images.Draw(B.Canvas, 0, 0, AStyle.ImageIndex);

        OffsetRect(R, ABounds.Left + (dxStyleGlyphSize.X - B.Width) div 2,
                      ABounds.Top + (dxStyleGlyphSize.Y - B.Height) div 2);
      end
      else 
        if not AStyle.StyleGlyph.Empty then
        begin
          R := MakeBounds(ABounds.Left + 1, ABounds.Top + 1, dxStyleGlyphSize.X, dxStyleGlyphSize.Y);
          B := AStyle.StyleGlyph;
        end;
        
      if AreImagesDrawn or not AStyle.StyleGlyph.Empty then
      begin
        B.Transparent := True;
        Canvas.Brush.Color := GetColor;
        Canvas.BrushCopy(R, B, MakeRect(0, 0, B.Width, B.Height), clFuchsia);
        with R do
          ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
      end;
    finally
      if AreImagesDrawn then B.Free;
    end;
    
    Canvas.FillRect(ABounds);
    Inc(ABounds.Left, dxStyleGlyphSize.X + 4);

    Canvas.Brush.Style := bsClear;
    if ABoldedCurrent and AStyle.IsCurrentStyle then
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
 
    S := Items[Index];
    if AMultiline then
    begin
      R := ABounds;
      DrawText(Canvas.Handle, PChar(S), Length(S), ABounds, DT_LEFT or DT_SINGLELINE or DT_CALCRECT);
      DrawText(Canvas.Handle, PChar(S), Length(S), R, uFormat[(ABounds.Right - ABounds.Left) <= (R.Right - R.Left)]);
    end
    else
      DrawText(Canvas.Handle, PChar(S), Length(S), ABounds, uFormat[True]);

    if ABoldedCurrent and AStyle.IsCurrentStyle then
      Canvas.Font.Style := Canvas.Font.Style - [fsBold];
    Canvas.Brush.Style := bsSolid;
  end;
end;

procedure dxPSDefaultDrawPagePreview(APrintStyle: TBasedxPrintStyle; ACanvas: TCanvas;
  APageBounds, AContentBounds, AHeaderBounds, AFooterBounds: TRect);
const
  LineStepX = 15;
  LineStepY = 7;
var
  R, LineBounds: TRect;
  LineCountX, LineCountY, I: Integer;
begin
  R := AContentBounds;
  with R do 
  begin
    LineCountX := (Right - Left - 1) div LineStepX;
    LineCountY := (Bottom - Top - 1) div LineStepY;
    Right := Left + LineCountX * LineStepX;
    Bottom := Top + LineCountY * LineStepY;

    if APrintStyle.PrinterPage.CenterOnPageH then
      OffsetRect(R, ((AContentBounds.Right - AContentBounds.Left) - (Right - Left)) div 2, 0);
    if APrintStyle.PrinterPage.CenterOnPageV then
      OffsetRect(R, 0, ((AContentBounds.Bottom - AContentBounds.Top) - (Bottom - Top)) div 2);
  end;
    
  ACanvas.Brush.Color := clBtnFace;

  {vert lines}
  for I := 0 to LineCountX do
  begin
    LineBounds := MakeRect(R.Left + I * LineStepX, R.Top, R.Left + I * LineStepX + 1, R.Bottom);
    if RectVisible(ACanvas.Handle, LineBounds) then 
      ACanvas.FillRect(LineBounds);
  end;
  
  {horz lines}
  for I := 0 to LineCountY do
  begin
    LineBounds := MakeRect(R.Left, R.Top + I * LineStepY, R.Right + 1, R.Top + I * LineStepY + 1);
    if RectVisible(ACanvas.Handle, LineBounds) then 
      ACanvas.FillRect(LineBounds);
  end;
end;

function dxPSPrintStyleUniqueName(AStyleController: TdxPrintStyleManager; AComponent: TComponent): string;
var
  S: string;
  I, J: Integer;
  NameExists: Boolean;
  Item: TBasedxPrintStyle;
begin
  S := AStyleController.Name + sdxStyleNameTemplate;
  for I := 1 to High(Integer) do
  begin
    Result := Format(S, [I]);
    NameExists := False;
    Item := AStyleController.StyleByName(Result);
    if Item = nil then
    begin
      with AStyleController.Owner do
        for J := 0 to ComponentCount - 1 do
          if dxSameText(Components[J].Name, Result) then
          begin
            NameExists := True;
            Break;
          end;
      if not NameExists then Exit;
    end;
  end;
  if AStyleController.IsDesigning then
    raise EdxException.CreateFmt(sdxCantCreateUniqueName, [AComponent.ClassName])
  else
    Result := '';  
end;

procedure dxPSSplitAutoHFTextEntry(Source: string; var APart1, APart2, APart3: string);
                     
  function DoExtract(var Source: string): string;
  var
    P: Integer;
  begin
    P := Pos(dxHFFunctionSeparator, Source);
    if P = 0 then 
    begin
      Result := Source;
      P := Length(Source);
    end
    else
      Result := Copy(Source, 1, P - 1);
  
    Delete(Source, 1, P);
    Result := Trim(Result);
  end;

begin
  APart1 := '';
  APart2 := '';
  APart3 := '';
  APart1 := DoExtract(Source);
  if Source <> '' then APart2 := DoExtract(Source);
  if Source <> '' then APart3 := DoExtract(Source);
end;
  
{ TdxPageSetupDialog }

constructor TdxPageSetupDialog.Create(AOwner: TComponent);
begin
  inherited;
  FButtonsEnabled := psbDefault;
  FOptionsEnabled := psoDefaultOptionsEnabled;
  FHFMode := hfmThreeSections;
  FButtonsVisible := psbDefault;
  FOptionsVisible := psoDefaultOptionsVisible;
end;

procedure TdxPageSetupDialog.Assign(Source: TPersistent);
begin
  if Source is TdxPageSetupDialog then
    with TdxPageSetupDialog(Source) do 
    begin
      Self.ActivePageIndex := ActivePageIndex;
      Self.ButtonsEnabled := ButtonsEnabled;
      Self.OptionsEnabled := OptionsEnabled;
      Self.HFMode := HFMode;
      Self.Title := Title;
      Self.ButtonsVisible := ButtonsVisible;
      Self.OptionsVisible := OptionsVisible;

      Self.FIsTitleAssigned := FIsTitleAssigned;
    end
  else
    inherited;
end;

function TdxPageSetupDialog.DefaultTitle: string;
begin
  Result := cxGetResourceString(@sdxPageSetupCaption);
end;

procedure TdxPageSetupDialog.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('IsTitleAssigned', ReadIsTitleAssigned, WriteIsTitleAssigned,
    FIsTitleAssigned and (Title = ''));
end;

procedure TdxPageSetupDialog.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = PrintStyle) and (Operation = opRemove) then
    PrintStyle := nil;
end;

function TdxPageSetupDialog.Execute: Boolean;
var
  APageSetupDlgData: TdxPageSetupDlgData;
  APageSetupDlgEvents: TdxPageSetupDlgEvents;
begin
  if PrintStyle = nil then
  begin
    Result := False;
    Exit;
  end;
  FillChar(APageSetupDlgData, SizeOf(TdxPageSetupDlgData), 0);
  FillChar(APageSetupDlgEvents, SizeOf(TdxPageSetupDlgEvents), 0);
  with APageSetupDlgEvents do
  begin
    OnClose := Self.OnClose;
    OnCustomDrawPreview := Self.OnCustomDrawPreview;
    OnShow := Self.OnShow;
  end;
  APageSetupDlgData.Events := APageSetupDlgEvents;
  APageSetupDlgData.PrintStyle := Self.PrintStyle;
  APageSetupDlgData.HelpContext := Self.HelpContext;
  APageSetupDlgData.Title := Self.RealTitle;
  APageSetupDlgData.ActivePageIndex := ActivePageIndex;

{
  if (csDesigning in ComponentState) then
  begin
    APageSetupDlgData.ButtonsEnabled := psbDefault;
    APageSetupDlgData.ButtonsVisible := psbDefault;
    APageSetupDlgData.OptionsEnabled := psoDefaultOptionsEnabled;
    APageSetupDlgData.OptionsVisible := psoDefaultOptionsVisible;
  end
  else
}
  begin
    APageSetupDlgData.ButtonsEnabled := ButtonsEnabled;
    APageSetupDlgData.ButtonsVisible := ButtonsVisible;
    //if not PrintStyle.OptionsDialogExists then
    //  APageSetupDlgData.ButtonsVisible := APageSetupDlgData.ButtonsVisible - [psbStyleOptions];
    APageSetupDlgData.OptionsEnabled := OptionsEnabled;
    APageSetupDlgData.OptionsVisible := OptionsVisible;
  end;
  APageSetupDlgData.HFMode := HFMode;

  Result := dxPageSetupDialog(APageSetupDlgData);
  FPreviewBtnClicked := APageSetupDlgData.PreviewBtnClicked;
  FPrintBtnClicked := APageSetupDlgData.PrintBtnClicked;
end;

function TdxPageSetupDialog.RealTitle: string;
begin
  Result := Title;
  if PrintStyle.StyleManager <> nil then
  begin
    if PrintStyle <> nil then
      Result := Result + ': ' + PrintStyle.StyleCaption;
    if Result[Length(Result) - 1] = ':' then
      Delete(Result, Length(Result) - 1, 1);
  end;
end;

procedure TdxPageSetupDialog.RestoreDefaults;
begin
  FIsTitleAssigned := False;
  ActivePageIndex := 0;
  FButtonsEnabled := psbDefault;
  FOptionsEnabled := psoDefaultOptionsEnabled;
  FHFMode := hfmThreeSections;
  FButtonsVisible := psbDefault;
  FOptionsVisible := psoDefaultOptionsVisible;
end;

function TdxPageSetupDialog.GetTitle: string;
begin
  if FIsTitleAssigned then
    Result := FTitle
  else
    Result := DefaultTitle;
end;

function TdxPageSetupDialog.IsTitleStored: Boolean;
begin
  Result := FisTitleAssigned and (Title <> DefaultTitle);
end;

procedure TdxPageSetupDialog.SetPrintStyle(Value: TBasedxPrintStyle);
begin
  if FPrintStyle <> Value then
  begin
    FPrintStyle := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TdxPageSetupDialog.SetTitle(const Value: string);
begin
  if Title <> Value then
  begin
    FTitle := Value;
    FIsTitleAssigned := True;
  end;
end;

procedure TdxPageSetupDialog.ReadIsTitleAssigned(Reader: TReader);
begin
  FIsTitleAssigned := Reader.ReadBoolean;
end;

procedure TdxPageSetupDialog.WriteIsTitleAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsTitleAssigned);
end;

{  TdxfmPageSetupDialog }

constructor TdxfmPageSetupDialog.Create(AOwner: TComponent);

  function CreateGlyph(AWidth, AHeight: Integer): TBitmap;
  begin
    Result := TBitmap.Create;
    Result.Height := AHeight;
    Result.Width := AWidth;
  end;

const
  cGlyphWidth = 75 + 4 + 16; { TextArea width + Separator width + DownArrow width}
begin
  inherited;
  FBmpArrow := dxPSUtl.CreateArrowBitmap(udgDown);
  FFooterBkGndGlyph := CreateGlyph(cGlyphWidth, btnFooterBackGround.Height - 10);
  FHeaderBkGndGlyph := CreateGlyph(cGlyphWidth, btnHeaderBackGround.Height - 10);

  FHFFunctionList := TStringList.Create;
  dxGetHFFunctionsList(FHFFunctionList);

  HelpContext := dxPSGlbl.dxhcPageSetupDlg;

  FPreviewBtnClicked := False;
  FPrintBtnClicked := False;

  CreateControls;
  LoadStrings;
end;

destructor TdxfmPageSetupDialog.Destroy;
begin
  FreeAndNil(FHFFunctionList);
  FreeAndNil(FFooterBkGndGlyph);
  FreeAndNil(FHeaderBkGndGlyph);
  FreeAndNil(FBmpArrow);
  FreeAndNil(FPrintStyle);
  inherited;
end;

function TdxfmPageSetupDialog.Execute: Boolean;
begin
  Result := False;
  if PrintStyle = nil then Exit;
  StartSetting;
  Result := ShowModal = mrOk;// and FModified;
end;

procedure TdxfmPageSetupDialog.SetPrintStyle(Value: TBasedxPrintStyle);
begin
  if FPrintStyle <> nil then
  begin
    FPrintStyle.Free;
    FPrintStyle := nil;
  end;
  if Value <> nil then
  begin
    FSavePrintStyle := Value;
    FPrintStyle := Value.StyleClass.Create(nil);
    FPrintStyle.Assign(Value);
//    MarginsOutside := not ValidateMarginsOutside(nil);
  end;
end;

procedure TdxfmPageSetupDialog.CreateWnd;
begin
  inherited;
  if Icon.Handle = 0 then
    Icon_LoadFromResourceName(Icon, IDB_DXPSPAGESETUP);
  SendMessage(Handle, WM_SETICON, 1, Icon.Handle);
end;

procedure TdxfmPageSetupDialog.DoHide;
begin
  if Assigned(FOnClose) then FOnClose(Self);
  inherited;
end;

procedure TdxfmPageSetupDialog.DoShow;
begin
  inherited;
  if Assigned(FOnShow) then FOnShow(Self);
end;

function TdxfmPageSetupDialog.GetEditColor(Value: Boolean): TColor;
begin
  if Value then
    Result := clBtnFace
  else
    Result := clWindow;
end;

procedure TdxfmPageSetupDialog.SetupDialog(const APageSetupDlgData: TdxPageSetupDlgData);
var
  I, Denominator: Integer;
  AutoHFTextEntries: TStrings;
  Control: TControl;
  LegendText: string;
begin
  FControlsUpdating := True;

  // it is very important because property TabVisible doesn't work properly without this line
  pgctrlMain.HandleNeeded;

  SetPrintStyle(APageSetupDlgData.PrintStyle);
  FStyleManager := FSavePrintStyle.StyleManager;

  Caption := APageSetupDlgData.Title;
  if APageSetupDlgData.HelpContext <> 0 then 
    HelpContext := APageSetupDlgData.HelpContext;

  FOnShow := APageSetupDlgData.Events.OnShow;
  FOnClose := APageSetupDlgData.Events.OnClose;
  OnCustomDrawPreview := APageSetupDlgData.Events.OnCustomDrawPreview;

  btnOptions.Enabled := psbStyleOptions in APageSetupDlgData.ButtonsEnabled;
  btnPrintPreview.Enabled := psbPreview in APageSetupDlgData.ButtonsEnabled;
  btnPrint.Enabled := psbPrint in APageSetupDlgData.ButtonsEnabled;
  btnOptions.Visible := psbStyleOptions in APageSetupDlgData.ButtonsVisible;
  btnPrintPreview.Visible := psbPreview in APageSetupDlgData.ButtonsVisible;
  btnPrint.Visible := psbPrint in APageSetupDlgData.ButtonsVisible;
  if not btnPrint.Visible and btnPrintPreview.Visible then
    btnPrintPreview.BoundsRect := btnPrint.BoundsRect;

  pnlStyleName.Visible := psoStyleCaption in APageSetupDlgData.OptionsVisible;
  if not pnlStyleName.Visible then
    Self.Height := Self.Height - pnlStyleName.Height;

  rBtnPortrait.Checked := PrintStyle.PrinterPage.Orientation = poPortrait;
  rBtnLandscape.Checked := PrintStyle.PrinterPage.Orientation = poLandscape;

  gbxPrintOrder.Visible := psoPageOrder in APageSetupDlgData.OptionsVisible;
  gbxShading.Visible := psoShading in APageSetupDlgData.OptionsVisible;

  gbxMargins.Visible := psoMargins in APageSetupDlgData.OptionsVisible;
  if psoMargins in APageSetupDlgData.OptionsVisible then
    FPreview.OptionsView := FPreview.OptionsView + [povMargins]
  else
    FPreview.OptionsView := FPreview.OptionsView - [povMargins];

  pnlHFMargins.Visible :=  gbxMargins.Visible and (psoHFMargins in APageSetupDlgData.OptionsVisible);
  if povMargins in FPreview.OptionsView then
  begin
    FPreview.Margins.Header.Visible := pnlHFMargins.Visible;
    FPreview.Margins.Footer.Visible := pnlHFMargins.Visible;
  end;
  if not pnlHFMargins.Visible and gbxMargins.Visible then
    gbxMargins.Height := gbxMargins.Height - pnlHFMargins.Height;

  pnlCenterOnPage.Visible := psoCenterOnPage in APageSetupDlgData.OptionsVisible;
  tshMargins.TabVisible := gbxMargins.Visible or pnlCenterOnPage.Visible;

  btnHeaderFont.Visible := psoHFFont in APageSetupDlgData.OptionsVisible;
  edHeaderFontInfo.Visible := psoHFFont in APageSetupDlgData.OptionsVisible;
  btnHeaderBackground.Visible := psoHFBackground in APageSetupDlgData.OptionsVisible;
  if btnHeaderBackground.Visible and not btnHeaderFont.Visible then
  begin
    btnHeaderBackground.Left := btnHeaderFont.Left;
    btnHeaderBackground.Top := btnHeaderFont.Top;
  end;
  pnlHeaderFont.Visible := btnHeaderFont.Visible or btnHeaderBackGround.Visible;
  pnlHeaderMemos.Visible := (psoHFText in APageSetupDlgData.OptionsVisible);
  if not pnlHeaderMemos.Visible then
    pnlHeader.Height := pnlHeader.Height - pnlHeaderMemos.Height;
  if pnlHeaderMemos.Visible and (APageSetupDlgData.HFMode = hfmOneSection) then
  begin
    memHeaderCenter.Visible := False;
    memHeaderRight.Visible := False;
  end;
  pnlHeader.Visible := pnlHeaderFont.Visible or pnlHeaderMemos.Visible;

  btnFooterFont.Visible := (psoHFFont in APageSetupDlgData.OptionsVisible);
  edFooterFontInfo.Visible := (psoHFFont in APageSetupDlgData.OptionsVisible);
  btnFooterBackground.Visible := (psoHFBackground in APageSetupDlgData.OptionsVisible);
  if btnFooterBackground.Visible and not btnFooterFont.Visible then
  begin
    btnFooterBackground.Left := btnFooterFont.Left;
    btnFooterBackground.Top := btnFooterFont.Top;
  end;

  pnlFooterFont.Visible := btnHeaderFont.Visible or btnHeaderBackGround.Visible;

  pnlFooterMemos.Visible := (psoHFText in APageSetupDlgData.OptionsVisible);
  if not pnlFooterMemos.Visible then
    pnlFooter.Height := pnlFooter.Height - pnlFooterMemos.Height;

  if pnlFooterMemos.Visible and (APageSetupDlgData.HFMode = hfmOneSection) then
  begin
    memFooterCenter.Visible := False;
    memFooterRight.Visible := False;
  end;
  pnlFooter.Visible := pnlFooterFont.Visible or pnlFooterMemos.Visible;

  pnlToolBar.Visible := (psoHFFunctions in APageSetupDlgData.OptionsVisible);
//  pnlAutoText.Visible := (psoHFAutoText in APageSetupDlgData.OptionsVisible);
  gbxFunctions.Visible := pnlToolBar.Visible; // or pnlAutoText.Visible;
  pnlVertAlignment.Visible := (psoHFVertAlignment in APageSetupDlgData.OptionsVisible);
  pnlHFOpt.Visible := gbxFunctions.Visible or pnlVertAlignment.Visible;
  pnlReverse.Visible := (psoHFReverse in APageSetupDlgData.OptionsVisible);

  tshHeaderFooter.TabVisible :=
    pnlHeader.Visible or pnlFooter.Visible or pnlHFOpt.Visible or pnlReverse.Visible;
  tshScaling.TabVisible := PrintStyle.AllowChangeScale;

  if pnlStyleName.Visible then
  begin
    pnlStyleName.Enabled :=
      not FSavePrintStyle.BuiltIn; // or (csDesigning in FSavePrintStyle.ComponentState);
    btnOptions.Enabled := pnlStyleName.Enabled;
    edStyleName.ReadOnly := not pnlStyleName.Enabled;
    edStyleName.TabStop := not edStyleName.ReadOnly;
    edStyleName.Color := GetEditColor(edStyleName.ReadOnly);
    edStyleName.MaxLength := dxMaxStyleCaption;
  end;

  lbxPaperType.Enabled := PrintStyle.AllowChangePaper;
  lbxPaperType.Color := GetEditColor(not lbxPaperType.Enabled);

  rBtnPortrait.Enabled := PrintStyle.AllowChangeOrientation;
  rBtnLandscape.Enabled := PrintStyle.AllowChangeOrientation;

  if gbxPrintOrder.Visible then
  begin
    gbxPrintOrder.Enabled := (psoPageOrder in APageSetupDlgData.OptionsEnabled);
    rbtnDownThenOver.Enabled := gbxPrintOrder.Enabled;
    rbtnOverThenDown.Enabled := gbxPrintOrder.Enabled;
  end;
  if gbxShading.Visible then
  begin
    gbxShading.Enabled := (psoShading in APageSetupDlgData.OptionsEnabled);
    chbxShading.Enabled := gbxShading.Enabled;
  end;

  if gbxMargins.Visible then
  begin
    gbxMargins.Enabled :=
      PrintStyle.AllowChangeMargins and (psoMargins in APageSetupDlgData.OptionsEnabled);

    for I := 0 to pnlMargins.ControlCount - 1 do
    begin
      Control := pnlMargins.Controls[I];

      if Control is TLabel then
        Control.Enabled := gbxMargins.Enabled;

      if Control is TdxPSSpinEdit then
        with TdxPSSpinEdit(Control) do
        begin
          ReadOnly := not gbxMargins.Enabled;
          TabStop := not ReadOnly;
          Color := GetEditColor(ReadOnly);
        end;
     end;     
  end;

  if gbxMargins.Enabled then
    FPreview.OptionsBehavior := FPreview.OptionsBehavior + [pobAllowDragMargins]
  else
    FPreview.OptionsBehavior := FPreview.OptionsBehavior - [pobAllowDragMargins];

  if pnlHFMargins.Visible then
  begin
    pnlHFMargins.Enabled :=
      gbxMargins.Enabled and (psoHFMargins in APageSetupDlgData.OptionsEnabled);

    for I := 0 to pnlHFMargins.ControlCount - 1 do
    begin
      Control := pnlHFMargins.Controls[I];

      if Control is TLabel then
        Control.Enabled := pnlHFMargins.Enabled;
        
      if Control is TdxPSSpinEdit then
        with TdxPSSpinEdit(Control) do
        begin
          ReadOnly := not pnlHFMargins.Enabled;
          TabStop := not ReadOnly;
          Color := GetEditColor(ReadOnly);
        end;
     end;   
  end;
  FPreview.Margins.Header.Enabled := pnlHFMargins.Enabled;
  FPreview.Margins.Footer.Enabled := pnlHFMargins.Enabled;

  if pnlCenterOnPage.Visible then
  begin
    pnlCenterOnPage.Enabled := psoCenterOnPage in APageSetupDlgData.OptionsEnabled;
    for I := 0 to pnlCenterOnPage.ControlCount - 1 do
      pnlCenterOnPage.Controls[I].Enabled := pnlCenterOnPage.Enabled;
  end;

  if btnHeaderFont.Visible then
    btnHeaderFont.Enabled := (psoHFFont in APageSetupDlgData.OptionsEnabled);
  if btnHeaderBackground.Visible then
    btnHeaderBackground.Enabled := (psoHFBackground in APageSetupDlgData.OptionsEnabled);

  if pnlHeaderMemos.Visible then
  begin
    pnlHeaderMemos.Enabled :=
      PrintStyle.AllowChangeHFText and (psoHFText in APageSetupDlgData.OptionsEnabled);
    memHeaderLeft.ReadOnly := not pnlHeaderMemos.Enabled;
    memHeaderLeft.TabStop := not memHeaderLeft.ReadOnly;
    memHeaderLeft.Color := GetEditColor(memHeaderLeft.ReadOnly);
    memHeaderCenter.ReadOnly := not pnlHeaderMemos.Enabled;
    memHeaderCenter.TabStop := not memHeaderCenter.ReadOnly;
    memHeaderCenter.Color := GetEditColor(memHeaderCenter.ReadOnly);
    memHeaderRight.ReadOnly := not pnlHeaderMemos.Enabled;
    memHeaderRight.TabStop := not memHeaderRight.ReadOnly;
    memHeaderRight.Color := GetEditColor(memHeaderRight.ReadOnly);
  end;

  if btnFooterFont.Visible then
    btnFooterFont.Enabled := (psoHFFont in APageSetupDlgData.OptionsEnabled);
  if btnFooterBackground.Visible then
    btnFooterBackground.Enabled := (psoHFBackground in APageSetupDlgData.OptionsEnabled);
  if pnlFooterMemos.Visible then
  begin
    pnlFooterMemos.Enabled := PrintStyle.AllowChangeHFText and (psoHFText in APageSetupDlgData.OptionsEnabled);
    memFooterLeft.ReadOnly := not pnlFooterMemos.Enabled;
    memFooterLeft.TabStop := not memFooterLeft.ReadOnly;
    memFooterLeft.Color := GetEditColor(memFooterLeft.ReadOnly);
    memFooterCenter.ReadOnly := not pnlFooterMemos.Enabled;
    memFooterCenter.TabStop := not memFooterCenter.ReadOnly;
    memFooterCenter.Color := GetEditColor(memFooterCenter.ReadOnly);
    memFooterRight.ReadOnly := not pnlFooterMemos.Enabled;
    memFooterRight.TabStop := not memFooterRight.ReadOnly;
    memFooterRight.Color := GetEditColor(memFooterRight.ReadOnly);
  end;

  if pnlToolBar.Visible then
  begin
    FilPredefined := TImageList.Create(Self);
    FilPredefined.AllocBy := FHFFunctionList.Count;
    pnlToolBar.Enabled := psoHFFunctions in APageSetupDlgData.OptionsEnabled;
    
    if FStyleManager <> nil then 
      AutoHFTextEntries := FStyleManager.AutoHFTextEntries
    else
      AutoHFTextEntries := nil;
      
    TdxPSHFToolBarBuilder.Build(tbPredefined, FilPredefined, 
      (FStyleManager <> nil) and (psoHFAutoText in APageSetupDlgData.OptionsVisible), 
      FHFFunctionList, AutoHFTextEntries, SpecialInsertClick, AutoHFTextEntriesClick, True);
  end;    

  if pnlVertAlignment.Visible then
    pnlVertAlignment.Enabled := psoHFVertAlignment in APageSetupDlgData.OptionsEnabled;

  if pnlReverse.Visible then
    chbxReverseOnEvenPages.Enabled := psoHFReverse in APageSetupDlgData.OptionsEnabled;

  if tshScaling.TabVisible then
  begin
    rbtnAdjustTo.Enabled := tshScaling.Enabled;
    rbtnFitTo.Enabled := tshScaling.Enabled;
    rbtnFitTo.Enabled := tshScaling.Enabled;
    lblPercentOfNormalSize.Enabled := tshScaling.Enabled;
    lblPagesWideBy.Enabled := tshScaling.Enabled;
    lblTall.Enabled := tshScaling.Enabled;
    FseFitToPage.Enabled := tshScaling.Enabled;
    FseAdjustTo.Enabled := tshScaling.Enabled;

    rbtnAdjustTo.Checked := PrintStyle.PrinterPage.ScaleMode = smAdjust;
    rbtnFitTo.Checked := PrintStyle.PrinterPage.ScaleMode = smFit;
    TdxPSSpinEdit(FseAdjustTo).AsInteger := PrintStyle.PrinterPage.ScaleFactor;
    TdxPSSpinEdit(FseFitToPage).AsInteger := PrintStyle.PrinterPage.FitToPagesByWide;
    TdxPSSpinEdit(FseFitToPage).AsInteger := PrintStyle.PrinterPage.FitToPagesByTall;
  end;

  case Page.GetInnerMeasurementUnits of
    muInches:
      begin
        Denominator := 254;
        LegendText := cxGetResourceString(@sdxUnitsInches);
      end;
    muMillimeters:
      begin
        Denominator := 10;
        LegendText := cxGetResourceString(@sdxUnitsMillimeters);
      end;
  else
    Denominator := 10;
  end;

  if Page.Orientation = poPortrait then
  begin
    FsePaperWidth.MinValue := dxPrintDevice.MinExtentX / Denominator;
    FsePaperWidth.MaxValue := dxPrintDevice.MaxExtentX / Denominator;
    FsePaperHeight.MinValue := dxPrintDevice.MinExtentY / Denominator;
    FsePaperHeight.MaxValue := dxPrintDevice.MaxExtentY / Denominator;
  end
  else
  begin
    FsePaperWidth.MinValue := dxPrintDevice.MinExtentY / Denominator;
    FsePaperWidth.MaxValue := dxPrintDevice.MaxExtentY / Denominator;
    FsePaperHeight.MinValue := dxPrintDevice.MinExtentX / Denominator;
    FsePaperHeight.MaxValue := dxPrintDevice.MaxExtentX / Denominator;
  end;

  FsePaperWidth.LegendText := LegendText;
  FsePaperHeight.LegendText := LegendText;
  FseMarginTop.LegendText := LegendText;
  FseMarginLeft.LegendText := LegendText;
  FseMarginRight.LegendText := LegendText;
  FseMarginBottom.LegendText := LegendText;
  FseMarginHeader.LegendText := LegendText;
  FseMarginFooter.LegendText := LegendText;
  
  FsePaperWidth.ReadOnly := not PrintStyle.AllowCustomPaperSizes;
  FsePaperWidth.TabStop := not FsePaperWidth.ReadOnly;
  FsePaperWidth.Color := GetEditColor(FsePaperWidth.ReadOnly);

  FsePaperHeight.ReadOnly := not PrintStyle.AllowCustomPaperSizes;
  FsePaperHeight.TabStop := not FsePaperHeight.ReadOnly;
  FsePaperHeight.Color := GetEditColor(FsePaperHeight.ReadOnly);

  with pgctrlMain do
  begin
    I := APageSetupDlgData.ActivePageIndex;
    if I < 0 then I := 0;
    if I > PageCount - 1 then I := PageCount - 1;
    if not Pages[I].TabVisible then I := 0;
    ActivePage := Pages[I];
  end;

  FControlsUpdating := False;

  if pssCopy in FSavePrintStyle.State then CheckModified;
end;

procedure TdxfmPageSetupDialog.ChangeBkgndGlyph(AGlyph: TBitmap; ABackground: TdxBackground);
var
  DC: HDC;
  PrevFont: HFONT;
  PrevFontColor: COLORREF;
  R: TRect;
  PrevColor: COLORREF;
  S: string;
  Brush: HBRUSH;
begin
  DC := AGlyph.Canvas.Handle;
  PrevFont := SelectObject(DC, Font.Handle);
  PrevFontColor := SetTextColor(DC, ColorToRGB(Font.Color));

  R := MakeRect(0, 0, AGlyph.Width - FBmpArrow.Width - 4, AGlyph.Height);
  FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
  InflateRect(R, -1, -1);
  
  case ABackground.Mode of
    bmNone:
      begin
        S := DropAmpersand(cxGetResourceString(@sdxBtnNoFill));
        S := '[' + S + ']';

        FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
        SetBkMode(DC, Windows.TRANSPARENT);
        SetTextColor(DC, ColorToRGB(clHighlight));
        DrawText(DC, PChar(S), Length(S), R, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
      end;

    bmBrush:
      begin
        FrameRect(DC, R, GetSysColorBrush(COLOR_BTNSHADOW));
        InflateRect(R, -1, -1);
        
        PrevColor := SetBkColor(DC, ColorToRGB(ABackground.BkColor));
        Brush := CreateSolidBrush(ColorToRGB(ABackground.Brush.Color));
        FillRect(DC, R, Brush);
        DeleteObject(Brush);
        SetBkColor(DC, PrevColor);
      end;

    bmBrushBitmap:
      begin
        FrameRect(DC, R, GetSysColorBrush(COLOR_BTNSHADOW));
        InflateRect(R, -1, -1);
        
        Brush := CreatePatternBrush(TBitmap(ABackground.Picture).Handle);
        FillRect(DC, R, Brush);
        DeleteObject(Brush);
      end;

    bmPicture:
      begin
        S := DropAmpersand(cxGetResourceString(@sdxPicture));
        S := '[' + S + ']';
        
        FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
        SetBkMode(DC, Windows.TRANSPARENT);
        SetTextColor(DC, ColorToRGB(clHighlight));
        DrawText(DC, PChar(S), Length(S), R, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
      end;
  end;

  R := MakeBounds(AGlyph.Width - FBmpArrow.Width, 0, FBmpArrow.Width, AGlyph.Height);
  FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
  // Down arrow
  AGlyph.Canvas.Draw(R.Left + 4, R.Top, FBmpArrow);
  // Separator vertical lines
  R.Left := R.Left - 4;
  R.Right := R.Left + 1;
  FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
  OffsetRect(R, 1, 0);
  FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
  OffsetRect(R, 1, 0);
  FillRect(DC, R, GetSysColorBrush(COLOR_BTNSHADOW));
  OffsetRect(R, 1, 0);
  FillRect(DC, R, GetSysColorBrush(COLOR_BTNHIGHLIGHT));

  SetTextColor(DC, PrevFontColor);
  SelectObject(DC, PrevFont);
end;

procedure TdxfmPageSetupDialog.CreateControls;

  function CreateMarginSpin(AHost: TBevel; ATag, ATabOrder: Integer; ALabel: TLabel): TdxPSSpinEdit;
  begin
    Result := TdxPSSpinEdit.Create(Self);
    with Result do
    begin
      Parent := AHost.Parent;
      BoundsRect := AHost.BoundsRect;
      LegendText := FsePaperHeight.LegendText;
      ValueType := svtFloat;
      Decimal := 2;
      Increment := 0.1;
      PageIncrement := 1;
      TabOrder := ATabOrder;
      Tag := MakeTTag(ATag);
      OnButtonClick := MarginButtonClick;
      OnChange := MarginChange;
      OnExit := MarginExit;
    end;  
    lblMarginTop.FocusControl := Result;
  end;
  
begin
  FseAdjustTo := TdxPSSpinEdit.Create(Self);
  with FseAdjustTo do
  begin
    Parent := tshScaling;
    BoundsRect := bvlAdjustToHolder.BoundsRect;
    Increment := 1;
    PageIncrement := 10;
    MinValue := 10;
    MaxValue := 500;
    TabOrder := rbtnAdjustTo.TabOrder + 1;
    OnChange := ScaleChanged;
    OnExit := AdjustToExit;
  end;
  FseFitToPage := TdxPSSpinEdit.Create(Self);
  with FseFitToPage do
  begin
    Parent := tshScaling;
    BoundsRect := bvlFitToPageHolder.BoundsRect;
    Increment := 1;
    PageIncrement := 10;
    MinValue := 1;
    MaxValue := 100;
    TabOrder := rbtnFitTo.TabOrder + 1;
    OnChange := FitToPageChange;
    OnExit := FitToPageExit;
  end;
  lblPagesWideBy.FocusControl := FseFitToPage;
  FseFitToPageTall := TdxPSSpinEdit.Create(Self);
  with FseFitToPageTall do
  begin
    Parent := tshScaling;
    BoundsRect := bvlFitToPageTallHolder.BoundsRect;
    Increment := 1;
    PageIncrement := 10;
    MinValue := 1;
    MaxValue := 100;
    TabOrder := rbtnFitTo.TabOrder + 2;
    OnChange := FitToPageChange;
    OnExit := FitToPageTallExit;
  end;
  lblTall.FocusControl := FseFitToPageTall;

  FsePaperWidth := TdxPSSpinEdit.Create(Self);
  with FsePaperWidth do
  begin
    Parent := gbxPaper;
    BoundsRect := bvlPaperWidthHolder.BoundsRect;
    ValueType := svtFloat;
    Decimal := 2;
    Increment := 0.1;
    PageIncrement := 1.0;
    TabOrder := lbxPaperType.TabOrder + 1;
    OnButtonClick := PaperWidthButtonClick;
    OnChange := PaperWidthChange;
    OnExit := PaperWidthExit;
    lblPaperWidth.FocusControl := FsePaperWidth;
  end;
  FsePaperHeight := TdxPSSpinEdit.Create(Self);
  with FsePaperHeight do
  begin
    Parent := gbxPaper;
    BoundsRect := bvlPaperHeightHolder.BoundsRect;
    LegendText := FsePaperWidth.LegendText;
    ValueType := svtFloat;
    Decimal := 2;
    Increment := 0.1;
    PageIncrement := 1.0;
    TabOrder := lbxPaperType.TabOrder + 2;
    OnButtonClick := PaperHeightButtonClick;
    OnChange := PaperHeightChange;
    OnExit := PaperHeightExit;
    lblPaperHeight.FocusControl := FsePaperHeight;
  end;

  FseMarginTop := CreateMarginSpin(bvlMarginTopHolder, 1, 0, lblMarginTop);
  FseMarginBottom := CreateMarginSpin(bvlMarginBottomHolder, 3, 1, lblMarginBottom);
  FseMarginLeft := CreateMarginSpin(bvlMarginLeftHolder, 0, 2, lblMarginLeft);
  FseMarginRight := CreateMarginSpin(bvlMarginRightHolder, 2, 3, lblMarginRight);
  FseMarginHeader := CreateMarginSpin(bvlMarginHeaderHolder, 5, 4, lblMarginHeader);
  FseMarginFooter := CreateMarginSpin(bvlMarginFooterHolder, 6, 5, lblMarginFooter);

  FOrientationPreview := TdxPreview.Create(Self);
  with FOrientationPreview do
  begin
    Parent := gbxOrientation;
    Enabled := False;
    BoundsRect := bvlOrientationHolder.BoundsRect;
    Color := clBtnFace;
   {$IFDEF DELPHI7} 
    ControlStyle := ControlStyle + [csParentBackground];
   {$ENDIF} 
    ZoomMode := pzmPages;
    PageXCount := 1;
    ScrollBars := ssNone;
    OptionsHint := OptionsHint - [pohShowForMargins, pohShowOnDrag];
    OptionsView := OptionsView - [povPageSelection, povMargins];
    LookAndFeel := plfFlat;
    OptionsZoom := OptionsZoom - [pozZoomOnClick];
    MinHeaderSize := 0;
    MinFooterSize := 0;
    Margins.Footer.Value := 0;
    Margins.Bottom.Value := 0;
    Margins.Left.Value := 0;
    Margins.Header.Value := 0;
    Margins.Top.Value := 0;
    Margins.Right.Value := 0;
    MinUsefulSize := NullPoint;
    BorderStyle := bsNone;
    OnCalcPageCount := OrientationPreviewCalcPageCount;
  end;

  FPreview := TdxPreview.Create(Self);
  with FPreview do
  begin
    Parent := pnlInMargins;
    BoundsRect := bvlPreviewHolder.BoundsRect;
    OptionsZoom := OptionsZoom - [pozZoomOnClick];
    OptionsView := OptionsView - [povPageSelection];
    MinHeaderSize := 0;
    MinFooterSize := 0;
    ScrollBars := ssNone;
    ZoomMode := pzmPages;
    OnCalcPageCount := PreviewCalcPageCount;
    OnDrawPageContent := PreviewDrawPageContent;
    OnAfterDragMargin := PreviewAfterDragMargin;
  end;

  FwpMargins := TdxPSWarningPane.Create(Self);
  FwpMargins.Parent := bvlMarginsWarningHolder.Parent;
  FwpMargins.BoundsRect := bvlMarginsWarningHolder.BoundsRect;
end;

procedure TdxfmPageSetupDialog.LoadStrings;
begin
  btnOK.Caption := cxGetResourceString(@sdxBtnOK);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);
  btnPrint.Caption := cxGetResourceString(@sdxBtnPrint);
  btnPrintPreview.Caption := cxGetResourceString(@sdxBtnPrintPreview);
  btnOptions.Caption := cxGetResourceString(@sdxBtnOptions);

  lblStyleName.Caption := cxGetResourceString(@sdxStyleName);

  tshPage.Caption := cxGetResourceString(@sdxPage);
  tshMargins.Caption := cxGetResourceString(@sdxMargins);
  tshHeaderFooter.Caption := cxGetResourceString(@sdxHeaderFooter);
  tshScaling.Caption := cxGetResourceString(@sdxScaling);

  gbxPaper.Caption := cxGetResourceString(@sdxPaper);
  lblPaperType.Caption := cxGetResourceString(@sdxPaperType);
  PlaceBevel(bvlPaperType, lblPaperType);
  lblPaperDimensions.Caption := cxGetResourceString(@sdxPaperDimension);
  PlaceBevel(bvlPaperDimensions, lblPaperDimensions);
  lblPaperWidth.Caption := cxGetResourceString(@sdxPaperWidth);
  lblPaperHeight.Caption := cxGetResourceString(@sdxPaperHeight);
  lblPaperSource.Caption := cxGetResourceString(@sdxPaperSource);
  PlaceBevel(bvlPaperSource, lblPaperSource);
  
  gbxOrientation.Caption := cxGetResourceString(@sdxOrientation);
  rBtnPortrait.Caption := cxGetResourceString(@sdxPortrait);
  rBtnLandscape.Caption := cxGetResourceString(@sdxLandscape);
  gbxPrintOrder.Caption := cxGetResourceString(@sdxPrintOrder);
  rbtnDownThenOver.Caption := cxGetResourceString(@sdxDownThenOver);
  rbtnOverThenDown.Caption := cxGetResourceString(@sdxOverThenDown);
  gbxShading.Caption := cxGetResourceString(@sdxShading);
  chbxShading.Caption := cxGetResourceString(@sdxPrintUsingGrayShading);

  lblMarginTop.Caption := cxGetResourceString(@sdxTop);
  lblMarginLeft.Caption := cxGetResourceString(@sdxLeft);
  lblMarginRight.Caption := cxGetResourceString(@sdxRight);
  lblMarginBottom.Caption := cxGetResourceString(@sdxBottom);
  lblMarginHeader.Caption := cxGetResourceString(@sdxHeader2);
  lblMarginFooter.Caption := cxGetResourceString(@sdxFooter2);
  btnFix.Caption := cxGetResourceString(@sdxBtnFix);
  btnRestoreOriginalMargins.Caption := cxGetResourceString(@sdxBtnRestoreOriginal);

  lblCenterOnPage.Caption := cxGetResourceString(@sdxCenterOnPage);
  PlaceBevel(bvlCenterOnPage, lblCenterOnPage);
  chbxCenterHorz.Caption := cxGetResourceString(@sdxHorizontally);
  chbxCenterVert.Caption := cxGetResourceString(@sdxVertically);

  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));

  lblHeader.Caption := cxGetResourceString(@sdxHeader);
  PlaceBevel(bvlHeader, lblHeader);
  btnHeaderFont.Caption := cxGetResourceString(@sdxBtnHeaderFont);
  btnHeaderBackground.Caption := cxGetResourceString(@sdxBtnHeaderBackground);
  lblFooter.Caption := cxGetResourceString(@sdxFooter);
  PlaceBevel(bvlFooter, lblFooter);
  btnFooterFont.Caption := cxGetResourceString(@sdxBtnFooterFont);
  btnFooterBackground.Caption := cxGetResourceString(@sdxBtnFooterBackground);

  gbxVertAlignment.Caption := cxGetResourceString(@sdxVertAlignment);
  gbxFunctions.Caption := cxGetResourceString(@sdxPredefinedFunctions);
  chbxReverseOnEvenPages.Caption := cxGetResourceString(@sdxReverseOnEvenPages);

  rbtnAdjustTo.Caption := cxGetResourceString(@sdxAdjustTo);
  rbtnFitTo.Caption := cxGetResourceString(@sdxFitTo);
  lblPercentOfNormalSize.Caption := cxGetResourceString(@sdxPercentOfNormalSize);
  lblPagesWideBy.Caption := cxGetResourceString(@sdxPagesWideBy);
  lblTall.Caption := cxGetResourceString(@sdxTall);
end;

procedure TdxfmPageSetupDialog.PaperWidthExit(Sender: TObject);
begin
  UpdatePageInfos;
end;

procedure TdxfmPageSetupDialog.PaperWidthChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.PaperHeightButtonClick(Sender: TObject;
  ButtonType: TdxButtonType; Button: TUDBtnType);
begin
  UpdatePageInfos;
end;

procedure TdxfmPageSetupDialog.PaperWidthButtonClick(Sender: TObject;
  ButtonType: TdxButtonType; Button: TUDBtnType);
begin
  UpdatePageInfos;
end;

procedure TdxfmPageSetupDialog.PaperHeightExit(Sender: TObject);
begin
  UpdatePageInfos;
end;

procedure TdxfmPageSetupDialog.UpdatePageInfos;
var
  I: Integer;
begin
  Page.RealPageSize := MakePoint(Round(1000 * FsePaperWidth.Value), Round(1000 * FsePaperHeight.Value));
  FPreview.OriginalPageSize.Point := Page.PageSizeLoMetric;
  FOrientationPreview.OriginalPageSize.Point := Page.PageSizeLoMetric;
  UpdateMarginsBounds;
  FPaperSizeLocked := True;
  try
    for I := 0 to PaperInfoCount - 1 do
      if PaperInfos[I].DMPaper = Page.DMPaper then
      begin
        lbxPaperType.ItemIndex := I;
        Break;
      end;
  finally
    FPaperSizeLocked := False;
  end;
end;

procedure TdxfmPageSetupDialog.PaperHeightChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.AdjustToExit(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  rbtnAdjustTo.Checked := True;
  PrintStyle.PrinterPage.ScaleFactor := fseAdjustTo.AsInteger;
end;

procedure TdxfmPageSetupDialog.ScaleChanged(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  rbtnAdjustTo.Checked := True;
  ActiveControl := TWinControl(Sender);
  CheckModified;
end;

procedure TdxfmPageSetupDialog.FitToPageChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  rbtnFitTo.Checked := True;
  ActiveControl := TWinControl(Sender);
  CheckModified;
end;

procedure TdxfmPageSetupDialog.FitToPageExit(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  PrintStyle.PrinterPage.FitToPagesByWide := FseFitToPage.AsInteger;
end;

procedure TdxfmPageSetupDialog.FitToPageTallExit(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  PrintStyle.PrinterPage.FitToPagesByTall := FseFitToPageTall.AsInteger;
end;

procedure TdxfmPageSetupDialog.UpdateControlsState;
begin
  FControlsUpdating := True;
  try
//    btnOK.Enabled := FModified;
    btnPrintPreview.Enabled := True;
    btnPrint.Enabled := True;
    //btnOptions.Enabled := PrintStyle.OptionsDialogExists;
    btnFix.Enabled := MarginsOutside or MarginsInvalid;
    btnRestoreOriginalMargins.Enabled := gbxMargins.Enabled and FMarginsChanged;
  finally
    FControlsUpdating := False;
  end
end;

procedure TdxfmPageSetupDialog.CheckModified;
begin
  if not FModified then FModified := True;
  UpdateControlsState;
end;

function TdxfmPageSetupDialog.GetCurrentPaperInfo: TdxPaperInfo;
begin
  with lbxPaperType do 
    if ItemIndex <> -1 then
      Result := PaperInfos[ItemIndex]
    else
      Result := nil;
end;

function TdxfmPageSetupDialog.GetPage: TdxPrinterPage;
begin
  if PrintStyle <> nil then
    Result := PrintStyle.PrinterPage
  else
    Result := nil
end;

function TdxfmPageSetupDialog.GetPaperInfo(Index: Integer): TdxPaperInfo;
begin
  Result := TdxPaperInfo(lbxPaperType.Items.Objects[Index]);
end;

function TdxfmPageSetupDialog.GetPaperInfoCount: Integer;
begin
  Result := lbxPaperType.Items.Count;
end;

procedure TdxfmPageSetupDialog.StartSetting;

  procedure DeleteCustomPapers;
  var
    I: Integer;
  begin
    // TODO: Check
    for I := lbxPaperType.Items.Count - 1 downto 0 do
      if PaperInfos[I].DMPaper >= DMPAPER_USER then
        lbxPaperType.Items.Delete(I);
  end;
  
  procedure SetupPapers;
  var
    I: Integer;
  begin
    lbxPaperType.Items.BeginUpdate;
    try
      lbxPaperType.Clear;
      PrintStyle.GetFilteredPapers(lbxPaperType.Items);
      if lbxPaperType.Items.Count > 0 then
      begin
        if not PrintStyle.AllowCustomPaperSizes then
          DeleteCustomPapers;

        for I := 0 to PaperInfoCount - 1 do
          if PrintStyle.PrinterPage.DMPaper = PaperInfos[I].DMPaper then // TODO: FindByDMPaper
          begin
            lbxPaperType.ItemIndex := I;
            Break;
          end;

        if lbxPaperType.ItemIndex = -1 then
          if not PrintStyle.AllowCustomPaperSizes then
            lbxPaperType.ItemIndex := 0
          else
          begin
            I := 0;
            //TdxPaperInfo(lbxPaperType.Items.Objects[I]).DMPaper < DMPAPER_USER
            while (I < lbxPaperType.Items.Count) and (Pos('Custom', lbxPaperType.Items[I]) = 0) do
              Inc(I);
            if (I < lbxPaperType.Items.Count) then
              lbxPaperType.ItemIndex := I
            else
              lbxPaperType.ItemIndex := 0;
          end;
      end;
    finally
      lbxPaperType.Items.EndUpdate;
    end;
    if lbxPaperType.Enabled then
      lbxPaperType.Enabled := lbxPaperType.Items.Count > 0;
  end;

  procedure SetupBins;
  var
    I: Integer;
  begin
    with cbxPaperSource do
    begin
      Items.BeginUpdate;
      try
        Items.Clear;
        if dxPrintDevice.Bins <> nil then
          Items := dxPrintDevice.Bins;
        Enabled := Items.Count > 0;
        if Enabled then
        begin
          I := Items.IndexOfObject(TObject(Page.PaperSource));
          if I <> -1 then
            ItemIndex := I
          else
            ItemIndex := 0;
        end;
      finally
        Items.EndUpdate;
      end;
    end;
  end;

begin
  FControlsUpdating := True;
  try
    SetupPapers;
    if lbxPaperType.Items.Count > 0 then lbxPaperTypeClick(lbxPaperType);
    SetupBins;
    ChangeBkgndGlyph(FHeaderBkgndGlyph, Page.PageHeader.Background);
    btnHeaderBackGround.Glyph := FHeaderBkgndGlyph;
    ChangeBkgndGlyph(FFooterBkgndGlyph, Page.PageFooter.Background);
    btnFooterBackGround.Glyph := FFooterBkgndGlyph;
    edStyleName.Text := Copy(FSavePrintStyle.StyleCaption, 1, edStyleName.MaxLength);

    chbxShading.Checked := PrintStyle.PrinterPage.GrayShading;

    EnabledMemoAttr(False);
    UpdateMarginsEdits;
    with Page do
    begin
      FPreview.MeasurementUnits := TdxPreviewMeasurementUnits(MeasurementUnits);
      FPreview.MinUsefulSize := MakePoint(MinPrintableAreaLoMetric, MinPrintableAreaLoMetric);
      FPreview.Orientation := TdxPreviewPaperOrientation(Orientation);
      FPreview.Margins.Header.Value := HeaderLoMetric;
      FPreview.Margins.Footer.Value := FooterLoMetric;
      with MarginsLoMetric do
      begin
        FPreview.Margins.Left.Value := Left;
        FPreview.Margins.Top.Value := Top;
        FPreview.Margins.Right.Value := Right;
        FPreview.Margins.Bottom.Value := Bottom;
      end;
      FOrientationPreview.MeasurementUnits := TdxPreviewMeasurementUnits(MeasurementUnits);
      FOrientationPreview.Orientation := TdxPreviewPaperOrientation(Orientation);

      chbxCenterHorz.Checked := PrintStyle.PrinterPage.CenterOnPageH;
      chbxCenterVert.Checked := PrintStyle.PrinterPage.CenterOnPageV;
      rbtnDownThenOver.Checked := (PrintStyle.PrinterPage.PageOrder = poDownThenOver);
      rbtnOverThenDown.Checked := (PrintStyle.PrinterPage.PageOrder = poOverThenDown);

      memHeaderLeft.Lines := PageHeader.LeftTitle;
      memHeaderCenter.Lines := PageHeader.CenterTitle;
      memHeaderRight.Lines := PageHeader.RightTitle;
      memFooterLeft.Lines := PageFooter.LeftTitle;
      memFooterCenter.Lines := PageFooter.CenterTitle;
      memFooterRight.Lines := PageFooter.RightTitle;
      FontInfoToText(PageHeader.Font, edHeaderFontInfo);
      FontInfoToText(PageFooter.Font, edFooterFontInfo);

      rbtnAdjustTo.Checked := ScaleMode = smAdjust;
      rbtnFitTo.Checked := ScaleMode = smFit;
      TdxPSSpinEdit(FseAdjustTo).AsInteger := ScaleFactor;
      TdxPSSpinEdit(FseFitToPage).AsInteger := FitToPagesByWide;
      TdxPSSpinEdit(FseFitToPageTall).AsInteger := FitToPagesByTall;
      chbxReverseOnEvenPages.Checked := ReverseTitlesOnEvenPages;
    end;
    btnHelp.Visible := (HelpContext <> 0);
    if (HelpContext = 0) then
    begin
      btnOK.BoundsRect := btnCancel.BoundsRect;
      btnCancel.BoundsRect := btnHelp.BoundsRect;
    end;
  finally
    FControlsUpdating := False;
    UpdateControlsState;
  end;

  if (FStyleManager <> nil) and edStyleName.CanFocus then
    ActiveControl := edStyleName
  else
    if pgctrlMain.ActivePage.PageIndex = 0 then
    begin
      if lbxPaperType.CanFocus then ActiveControl := lbxPaperType
    end
    else
      if pgctrlMain.ActivePage.PageIndex = 1 then
        if FseMarginTop.CanFocus and not FseMarginTop.ReadOnly then
          ActiveControl := FseMarginTop;
end;

procedure TdxfmPageSetupDialog.UpdateMarginsBounds;
var
  APrevValue: Boolean;
begin
  APrevValue := FControlsUpdating;
  if not APrevValue then FControlsUpdating := True;
  try
    with Page do
    begin
      FseMarginHeader.MinValue := MinMargins.Top / 1000;
      FseMarginHeader.MaxValue := (RealPageSize.Y - MinPrintableArea - MinMargins.Bottom) / 1000;
      FseMarginFooter.MinValue := MinMargins.Bottom / 1000;
      FseMarginFooter.MaxValue := (RealPageSize.Y - MinPrintableArea - MinMargins.Top) / 1000;
      FseMarginTop.MinValue := MinMargins.Top / 1000;
      FseMarginTop.MaxValue := (RealPageSize.Y - MinPrintableArea - MinMargins.Bottom) / 1000;
      FseMarginBottom.MinValue := MinMargins.Bottom / 1000;
      FseMarginBottom.MaxValue := (RealPageSize.Y - MinPrintableArea - MinMargins.Top) / 1000;
      FseMarginLeft.MinValue := MinMargins.Left / 1000;
      FseMarginLeft.MaxValue := (RealPageSize.X - MinPrintableArea - MinMargins.Right) / 1000;
      FseMarginRight.MinValue := MinMargins.Right / 1000;
      FseMarginRight.MaxValue := (RealPageSize.X - MinPrintableArea - MinMargins.Left) / 1000;
    end;
  finally
    if not APrevValue then FControlsUpdating := False;
  end;
end;

procedure TdxfmPageSetupDialog.SetMarginsInvalid(Value: Boolean);
begin
  if FMarginsInvalid <> Value then
  begin
    FMarginsInvalid := Value;
    UpdateWarningPane(MarginsInvalid, MarginsOutside, 
      cxGetResourceString(@sdxInvalidMargins), cxGetResourceString(@sdxOutsideMargins));
    FPreview.InvalidatePages;
  end;
end;

procedure TdxfmPageSetupDialog.SetMarginsOutside(Value: Boolean);
begin
  if FMarginsOutside <> Value then
  begin
    FMarginsOutside := Value;
    UpdateWarningPane(MarginsOutside, MarginsInvalid, 
      cxGetResourceString(@sdxOutsideMargins), cxGetResourceString(@sdxInvalidMargins));
  end;
end;

procedure TdxfmPageSetupDialog.MarginExit(Sender: TObject);
var
  InvalidMarginControl: TWinControl;
begin
  if FMarginsChanging then Exit;
  FMarginsChanging := True;
  try
    MarginsInvalid := not ValidateMargins(InvalidMarginControl);
    MarginsOutside := not ValidateMarginsOutside(InvalidMarginControl);
    if not MarginsInvalid then UpdatePreviewMargins;
  finally
    FMarginsChanging := False;
  end;
  UpdateControlsState;
end;

procedure TdxfmPageSetupDialog.MarginButtonClick(Sender: TObject;
  ButtonType: TdxButtonType; Button: TUDBtnType);
begin
  MarginExit(Sender);
  CheckModified;
end;

procedure TdxfmPageSetupDialog.MarginChange(Sender: TObject);
begin
  if FControlsUpdating or FMarginsChanging then Exit;
  FMarginsChanged := True;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.btnHFFontClick(Sender: TObject);
var
  PageObject: TCustomdxPageObject;
  Editor: TEdit;
begin
  if TTagToInt(TComponent(Sender).Tag) = 0 then
  begin
    PageObject := Page.PageHeader;
    Editor := edHeaderFontInfo;
  end  
  else
  begin  
    PageObject := Page.PageFooter;
    Editor := edFooterFontInfo;
  end;
    
  dxPSGlbl.FontDialog.Font := PageObject.Font;
  if dxPSGlbl.FontDialog.Execute then
  begin
    PageObject.Font := dxPSGlbl.FontDialog.Font;
    FontInfoToText(PageObject.Font, Editor);
    CheckModified;
  end;
end;

procedure TdxfmPageSetupDialog.AutoHFTextEntriesClick(Sender: TObject);
var
  Part1, Part2, Part3: string;
begin
  dxPSSplitAutoHFTextEntry(FStyleManager.AutoHFTextEntries[TTagToInt(TComponent(Sender).Tag)], Part1, Part2, Part3);
  if (Part2 = '') and (Part3 = '') then 
    TCustomMemo(ActiveControl).SelText := Part1
  else  
    if TTagToInt(TCustomMemo(ActiveControl).Tag) < 4 then   
    begin
      if Part1 <> '' then memHeaderLeft.SelText := Part1;
      if Part2 <> '' then memHeaderCenter.SelText := Part2;
      if Part3 <> '' then memHeaderRight.SelText := Part3;
    end
    else
    begin
      if Part1 <> '' then memFooterLeft.SelText := Part1;
      if Part2 <> '' then memFooterCenter.SelText := Part2;
      if Part3 <> '' then memFooterRight.SelText := Part3;
    end;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.SpecialInsertClick(Sender: TObject);
begin
  if ActiveControl is TCustomMemo then
  begin
    TCustomMemo(ActiveControl).SelText := FHFFunctionList[TTagToInt(TComponent(Sender).Tag)];
    CheckModified;
  end;
end;

const
  PageTitlePartMap: array[0..2] of TdxPageTitlePart = (tpLeft, tpCenter, tpRight);
  
procedure TdxfmPageSetupDialog.MemoExit(Sender: TObject);
var
  T: Integer;
begin
  if not (ActiveControl is TCustomMemo) then
    EnabledMemoAttr(False);

  T := TTagToInt(TCustomMemo(Sender).Tag);
  if T < 3 then
    Page.PageHeader.Titles[PageTitlePartMap[T]].Text := TCustomMemo(Sender).Text
  else
    Page.PageFooter.Titles[PageTitlePartMap[T - 3]].Text := TCustomMemo(Sender).Text;
end;

procedure TdxfmPageSetupDialog.MemoEnter(Sender: TObject);
var
  T, ButtonIndex: Integer;
begin
  EnabledMemoAttr(True);
  T := TTagToInt(TCustomMemo(Sender).Tag);
  if T < 3 then
    ButtonIndex := Integer(Page.PageHeader.TextAlignY[PageTitlePartMap[T]])
  else
    ButtonIndex := Integer(Page.PageFooter.TextAlignY[PageTitlePartMap[T - 3]]);
  tbTAVert.Buttons[ButtonIndex].Down := True;
end;

procedure TdxfmPageSetupDialog.pgctrlMainChange(Sender: TObject);
begin
  EnabledMemoAttr(False);
end;

procedure TdxfmPageSetupDialog.EnabledMemoAttr(AEnabled: Boolean);
var
  I: Integer;
begin
  tbPredefined.Enabled := AEnabled;
  for I := 0 to tbPredefined.ButtonCount - 1 do
   tbPredefined.Buttons[I].Enabled := AEnabled;
     
  tbTAVert.Enabled := AEnabled;
  for I := 0 to tbTAVert.ButtonCount - 1 do
    tbTAVert.Buttons[I].Enabled := AEnabled;
end;

procedure TdxfmPageSetupDialog.BackgroundClick(Sender: TObject);
var
  Pt: TPoint;
  T: Integer;
  ABackground: TdxBackground;
  AParams: TdxBackgroundDlgData;
begin
  Pt := TWinControl(Sender).ClientOrigin;
  Inc(Pt.Y, TWinControl(Sender).Height);
  FillChar(AParams, SizeOf(TdxBackgroundDlgData), 0);
  with AParams do
  begin
    BorderStyle := bsNone;
    NoBtnCaption := cxGetResourceString(@sdxBtnNoFill);
    ShowFillEffects := True;
    ShowMoreColors := True;
  end;
  T := TTagToInt(TComponent(Sender).Tag);
  if T = 0 then
    ABackground := Page.PageHeader.Background
  else
    ABackground := Page.PageFooter.Background;
  if dxChooseBackgroundDlg(ABackground, Pt, AParams) then
  begin
    if T = 0 then
    begin
      ChangeBkgndGlyph(FHeaderBkgndGlyph, ABackground);
      TBitBtn(Sender).Glyph := FHeaderBkgndGlyph;
    end
    else
    begin
      ChangeBkgndGlyph(FFooterBkgndGlyph, ABackground);
      TBitBtn(Sender).Glyph := FFooterBkgndGlyph;
    end;
    CheckModified;
  end;
end;

procedure TdxfmPageSetupDialog.VertTextAlignClick(Sender: TObject);
var
  T: Integer;
begin
  if ActiveControl is TCustomMemo then
  begin
    T := TTagToInt(TCustomMemo(ActiveControl).Tag);
    if T < 3 then
      Page.PageHeader.TextAlignY[PageTitlePartMap[T]] := TcxTextAlignY(TTagToInt(TToolButton(Sender).Tag))
    else
      Page.PageFooter.TextAlignY[PageTitlePartMap[T - 3]] := TcxTextAlignY(TTagToInt(TToolButton(Sender).Tag));
    CheckModified;
  end;
end;

procedure TdxfmPageSetupDialog.memHeaderLeftChange(Sender: TObject);
begin
  CheckModified;
  TWinControl(Sender).Invalidate;
end;

procedure TdxfmPageSetupDialog.chbxReverseOnEvenPagesClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  PrintStyle.PrinterPage.ReverseTitlesOnEvenPages := TCheckBox(Sender).Checked;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.btnPrintPreviewClick(Sender: TObject);
begin
  FModified := True;
  FPreviewBtnClicked := True;
  ModalResult := mrOK
end;

procedure TdxfmPageSetupDialog.btnPrintClick(Sender: TObject);
begin
  FModified := True;
  FPrintBtnClicked := True;
  ModalResult := mrOK;
end;

procedure TdxfmPageSetupDialog.OrientationPreviewCalcPageCount(Sender: TObject);
begin
  TdxPreview(Sender).PageCount := 1;
end;

procedure TdxfmPageSetupDialog.PreviewCalcPageCount(Sender: TObject);
begin
  TdxPreview(Sender).PageCount := 1;
end;

procedure TdxfmPageSetupDialog.PreviewDrawPageContent(Sender: TObject;
  ACanvas: TCanvas; ABounds: TRect; APageIndex: Integer);
var
  ContentBounds, FooterBounds, HeaderBounds: TRect;
  InvalidMarginControl: TWinControl;
begin
  with TdxPreview(Sender) do
  begin
    ContentBounds := MakeRect(ABounds.Left + Margins.Left.VisibleValue,
      ABounds.Top + Margins.Top.VisibleValue,
      ABounds.Right - Margins.Right.VisibleValue,
      ABounds.Bottom - Margins.Bottom.VisibleValue);
    FooterBounds := MakeRect(ABounds.Left + Margins.Left.VisibleValue,
      ABounds.Bottom - Margins.Footer.VisibleValue,
      ABounds.Right - Margins.Right.VisibleValue,
      ABounds.Bottom - Margins.Bottom.VisibleValue);
    HeaderBounds := MakeRect(ABounds.Left + Margins.Left.VisibleValue,
      ABounds.Top + Margins.Header.VisibleValue,
      ABounds.Right - Margins.Right.VisibleValue,
      ABounds.Top + Margins.Top.VisibleValue);

    if ValidateMargins(InvalidMarginControl) then
      OptionsView := OptionsView + [povMargins]
    else
      OptionsView := OptionsView - [povMargins];

    if povMargins in OptionsView then
      if Assigned(FOnCustomDrawPreview) then
        FOnCustomDrawPreview(PrintStyle, ACanvas, ABounds, ContentBounds, HeaderBounds, FooterBounds)
      else
        dxPSDefaultDrawPagePreview(PrintStyle, ACanvas, ABounds, ContentBounds, HeaderBounds, FooterBounds);
  end;
end;

procedure TdxfmPageSetupDialog.PreviewAfterDragMargin(Sender: TObject;
  AMargin: TdxPreviewPageMargin);
var
  V: Extended;
begin
  case Page.GetInnerMeasurementUnits of
    muInches: 
      V := AMargin.Value / 254;
    muMillimeters: 
      V := AMargin.Value / 10;
  else
    V := 0;
  end;
  
  if (AMargin is TdxPreviewPageMarginFooter) or (AMargin is TdxPreviewPageMarginHeader) then
    FMarginsChanging := True;
    
  try
    if AMargin is TdxPreviewPageMarginLeft then
    begin
      FseMarginLeft.Value := V;
      MarginExit(FseMarginLeft);
    end;
    if AMargin is TdxPreviewPageMarginTop then
    begin
      FseMarginTop.Value := V;
      MarginExit(FseMarginTop);
    end;
    if AMargin is TdxPreviewPageMarginRight then
    begin
      FseMarginRight.Value := V;
      MarginExit(FseMarginRight);
    end;
    if AMargin is TdxPreviewPageMarginBottom then
    begin
      FseMarginBottom.Value := V;
      MarginExit(FseMarginBottom);
    end;
    if AMargin is TdxPreviewPageMarginHeader then
    begin
      FseMarginHeader.Value := V;
      if FseMarginTop.Value < FseMarginHeader.Value then
        FseMarginTop.Value := FseMarginHeader.Value;
      FMarginsChanged := True;
    end;
    if AMargin is TdxPreviewPageMarginFooter then
    begin
      FseMarginFooter.Value := V;
      if FseMarginBottom.Value < FseMarginFooter.Value then
        FseMarginBottom.Value := FseMarginFooter.Value;
      FMarginsChanged := True;
    end;
  finally
    if (AMargin is TdxPreviewPageMarginFooter) or (AMargin is TdxPreviewPageMarginHeader) then
    begin
      FMarginsChanging := False;
      if AMargin is TdxPreviewPageMarginHeader then
        MarginExit(FseMarginHeader)
      else
        MarginExit(FseMarginBottom);
    end;
  end;
end;

procedure TdxfmPageSetupDialog.lblMarginTopClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
end;

procedure TdxfmPageSetupDialog.lblPaperSourceClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TComboBox(ActiveControl).DroppedDown := True;
end;

procedure TdxfmPageSetupDialog.pbxPageOrderPaint(Sender: TObject);
const 
  ImageIndexes: array[Boolean] of Integer = (1, 0);
begin
  ilPrintOrders.Draw(TPaintBox(Sender).Canvas, 0, 0, 
    ImageIndexes[rbtnDownThenOver.Checked], gbxPrintOrder.Enabled);
end;

procedure TdxfmPageSetupDialog.PageOrderClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  PrintStyle.PrinterPage.PageOrder := TdxPageOrder(TTagToInt(TRadioButton(Sender).Tag));
  pbxPageOrder.Invalidate;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.pbxPageOrderDblClick(Sender: TObject);
begin
  rbtnDownThenOver.Checked := not rbtnDownThenOver.Checked;
  rbtnOverThenDown.Checked := not rbtnDownThenOver.Checked;
end;

procedure TdxfmPageSetupDialog.chbxShadingClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  PrintStyle.PrinterPage.GrayShading := TCheckBox(Sender).Checked;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.CenterOnPageClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  with TCheckBox(Sender) do
    if TTagToInt(Tag) = 0 then
      PrintStyle.PrinterPage.CenterOnPageH := Checked
    else
      PrintStyle.PrinterPage.CenterOnPageV := Checked;
  CheckModified;
  FPreview.InvalidatePages;
end;

procedure TdxfmPageSetupDialog.OrientationClick(Sender: TObject);
var
  T: Integer;
  V, W, H: Extended;
begin
  if FControlsUpdating then Exit;
  T := TTagToInt(TComponent(Sender).Tag);
  if not Page.AutoSwapMargins then
  begin
    FPreview.OptionsBehavior := FPreview.OptionsBehavior - [pobAutoSwapMargins];
    FOrientationPreview.OptionsBehavior := FOrientationPreview.OptionsBehavior - [pobAutoSwapMargins];
  end;
  FPreview.Orientation := TdxPreviewPaperOrientation(T);
  FOrientationPreview.Orientation := TdxPreviewPaperOrientation(T);
  SaveMargins;
  Page.Orientation := TdxPrinterOrientation(T);

  W := FsePaperWidth.Value;
  H := FsePaperHeight.Value;
  V := FsePaperWidth.MaxValue;
  FsePaperWidth.MaxValue := FsePaperHeight.MaxValue;
  FsePaperHeight.MaxValue := V;
  V := FsePaperWidth.MinValue;
  FsePaperWidth.MinValue := FsePaperHeight.MinValue;
  FsePaperHeight.MinValue := V;
  FsePaperWidth.Value := H;
  FsePaperHeight.Value := W;

  UpdateMarginsEdits;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.OrientationDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TdxfmPageSetupDialog.UpdateMarginsEdits;
begin
  UpdateMarginsBounds;
  with Page do
  begin
    FseMarginHeader.Value := Header / 1000;
    FseMarginFooter.Value := Footer / 1000;
    FseMarginTop.Value := Margins.Top / 1000;
    FseMarginBottom.Value := Margins.Bottom / 1000;
    FseMarginLeft.Value := Margins.Left / 1000;
    FseMarginRight.Value := Margins.Right / 1000;
  end;
  if not FControlsUpdating then
  begin
    MarginExit(FseMarginHeader);
    MarginExit(FseMarginFooter);
    MarginExit(FseMarginTop);
    MarginExit(FseMarginBottom);
    MarginExit(FseMarginLeft);
    MarginExit(FseMarginRight);
  end;
end;

procedure TdxfmPageSetupDialog.cbxPaperSourceChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  with TComboBox(Sender) do
    Page.PaperSource := Integer(Items.Objects[ItemIndex]);
  CheckModified;
end;

procedure TdxfmPageSetupDialog.lbxPaperTypeClick(Sender: TObject);
var
  PaperInfo: TdxPaperInfo;
  Pt: TPoint;
begin
  if FPaperSizeLocked then Exit;

  PaperInfo := CurrentPaperInfo;

  Pt := MakePoint(PaperInfo.Width, PaperInfo.Height);
  FPreview.OriginalPageSize.Point := Pt;
  FOrientationPreview.OriginalPageSize.Point := Pt;

  Page.DMPaper := PaperInfo.DMPaper;
  FsePaperWidth.Value := Page.RealPageSize.X / 1000;
  FsePaperHeight.Value := Page.RealPageSize.Y / 1000;

  UpdateMarginsBounds;
  if not FControlsUpdating then CheckModified;
end;

procedure TdxfmPageSetupDialog.ScalingClick(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  case TTagToInt(TComponent(Sender).Tag) of
    0:
      begin
        PrintStyle.PrinterPage.ScaleMode := smAdjust;
        ActiveControl := FseAdjustTo;
      end;
    1:
      begin
        PrintStyle.PrinterPage.ScaleMode := smFit;
        if FseFitToPage.Enabled then
          ActiveControl := FseFitToPage
        else if FseFitToPageTall.Enabled then
          ActiveControl := FseFitToPageTall;
      end;
  end;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.MemoChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.cbxPaperSourceDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with TComboBox(Control) do
  begin
    Canvas.FillRect(Rect);
    InflateRect(Rect, -2, -1);
    ilBins.Draw(Canvas, Rect.Left, Rect.Top, Integer(dxPrintDevice.IsAutoSelectBin(Index)));
    Inc(Rect.Left, ilPaperTypes.Width + 2);
    Canvas.TextRect(Rect, Rect.Left, 
      Rect.Top + (Rect.Bottom - Rect.Top - Canvas.TextHeight(Items[Index])) div 2, Items[Index]);
  end;
end;

procedure TdxfmPageSetupDialog.lbxPaperTypeDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  ImageIndexes: array[Boolean] of Integer = (0, 1);  
begin
  with TListBox(Control) do
  begin
    Canvas.FillRect(Rect);
    InflateRect(Rect, -2, -1);
    ilPapers.Draw(Canvas, Rect.Left, Rect.Top, ImageIndexes[dxPrintDevice.IsEnvelopePaper(Index)], Enabled);
    Inc(Rect.Left, ilPaperTypes.Width + 2);
    if not Enabled then               
      Canvas.Font.Color := clGrayText;
    Canvas.TextRect(Rect, Rect.Left, 
      Rect.Top + (Rect.Bottom - Rect.Top - Canvas.TextHeight(Items[Index])) div 2, Items[Index]);
    Canvas.Font.Color := clWindowText;  
  end;
end;

procedure TdxfmPageSetupDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and (Shift = []) and (ActiveControl is TCustomMemo) then
    ModalResult := mrCancel;
end;

procedure TdxfmPageSetupDialog.edStyleNameChange(Sender: TObject);
begin
  if FControlsUpdating then Exit;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.edStyleNameExit(Sender: TObject);
var
  StyleManager: TdxPrintStyleManager;
begin
  if edStyleName.Enabled then
  begin
    PrintStyle.StyleCaption := edStyleName.Text;
    StyleManager := FSavePrintStyle.StyleManager;
    if (StyleManager <> nil) and (StyleManager.PageSetupDialog <> nil) then
      Caption := StyleManager.PageSetupDialog.RealTitle
    else
      Caption := cxGetResourceString(@sdxPageSetupCaption) + ': ' + PrintStyle.StyleCaption;
  end;
end;

function TdxfmPageSetupDialog.ValidateStyleCaption: Boolean;
var
  S: string;
  I: Integer;
  AStyle: TBasedxPrintStyle;
begin
  Result := True;
  if (FStyleManager <> nil) and not edStyleName.ReadOnly then
  begin
    S := edStyleName.Text;
    for I := 0 to FStyleManager.Count - 1 do
    begin
      AStyle := FStyleManager[I];
      if (AStyle <> FSavePrintStyle) and dxSameText(AStyle.StyleCaption, S) then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TdxfmPageSetupDialog.ValidateUserInput(out AControl: TWinControl): Boolean;
var
  IsFixupMarginsOutside: Boolean;
  Stub: TWinControl;
begin
  AControl := nil;
  Result := ValidateStyleCaption;
  if not Result then
  begin
    MessageWarning(Format(cxGetResourceString(@sdxInvalideStyleCaption), [edStyleName.Text]));
    AControl := edStyleName;
  end
  else
  begin
    IsFixupMarginsOutside := False;
    if not ValidateMarginsOutside(Stub) then
    begin
      Result := True;
      Beep;
      IsFixupMarginsOutside := MarginsOutsideMessageDlg(cxGetResourceString(@sdxOutsideMarginsMessage2)) = mrYes;
      if IsFixupMarginsOutside then FixupMarginsOutside;
    end;
    if not IsFixupMarginsOutside then
    begin
      Result := ValidateMargins(AControl);
      if not Result then
      begin
        Beep;
        Result := True;
        case MarginsMessageDlg(cxGetResourceString(@sdxInvalidMarginsMessage)) of
          mrYes:
            FixupMargins;
          mrNo:
            RestoreOriginalMargins;
        end;
      end;
    end;
  end;
end;

procedure TdxfmPageSetupDialog.SaveMargins;
begin
  Page.BeginUpdate;
  try
    Page.Header := Round(FseMarginHeader.Value * 1000);
    Page.Footer := Round(FseMarginFooter.Value * 1000);
    Page.Margins.Left := Round(FseMarginLeft.Value * 1000);
    Page.Margins.Top := Round(FseMarginTop.Value * 1000);
    Page.Margins.Right := Round(FseMarginRight.Value * 1000);
    Page.Margins.Bottom := Round(FseMarginBottom.Value * 1000);
  finally
    Page.EndUpdate;
  end;
end;

procedure TdxfmPageSetupDialog.SaveStyleCaption;
begin
  if not edStyleName.ReadOnly then
    PrintStyle.StyleCaption := edStyleName.Text;
end;

procedure TdxfmPageSetupDialog.SaveUserInput;
begin
  SaveStyleCaption;
  SaveMargins;
end;

function TdxfmPageSetupDialog.ValidateMarginsOutside(out AInvalidMarginControl: TWinControl): Boolean;
var
  MinX, MinY: Extended;
begin
  if dxInitPrintDevice(False) then
  begin
    MinX := dxPrintDevice.PhysOffsetX / GetDeviceCaps(dxPrintDevice.Handle, LOGPIXELSX);
    MinY := dxPrintDevice.PhysOffsetY / GetDeviceCaps(dxPrintDevice.Handle, LOGPIXELSX);
    case Page.GetInnerMeasurementUnits of
      muInches: ;
      muMillimeters:
        begin
          MinX := 25.4 * MinX;
          MinY := 25.4 * MinY;
        end;
    end;
  end
  else
  begin
    MinX := 0;
    MinY := 0;
  end;
  Result := FseMarginHeader.Value >= MinY;
  if Result then
    Result := FseMarginFooter.Value >= MinY
  else
  begin
    AInvalidMarginControl := FseMarginHeader;
    Exit;
  end;
  if Result then
    Result := FseMarginLeft.Value >= MinX
  else
  begin
    AInvalidMarginControl := FseMarginFooter;
    Exit;
  end;
  if Result then
    Result := FseMarginRight.Value >= MinX
  else
  begin
    AInvalidMarginControl := FseMarginLeft;
    Exit;
  end;

  if Result then
    AInvalidMarginControl := nil
  else
    AInvalidMarginControl := FseMarginRight;
end;

function TdxfmPageSetupDialog.ValidateMargins(out AInvalidMarginControl: TWinControl): Boolean;

  function EqualOrGreaterThen(const AValue1, AValue2: Extended): Boolean;
  const
    Eps = 0.00001;
  begin
    Result := (AValue1 > AValue2) or (Abs(AValue1 - AValue2) < Eps);
  end;

  function EqualOrLessThen(const AValue1, AValue2: Extended): Boolean;
  const
    Eps = 0.00001;
  begin
    Result := (AValue1 < AValue2) or (Abs(AValue1 - AValue2) < Eps);
  end;
  
var
  Min, Max, APageSizeX, APageSizeY, AMinPrintableArea: Extended;
begin
  with Page do
  begin
    APageSizeX := RealPageSize.X / 1000;
    APageSizeY := RealPageSize.Y / 1000;
    AMinPrintableArea := MinPrintableArea / 1000;
   {header}
    Min := 0;
    Max := APageSizeY - AMinPrintableArea;
    Result := EqualOrGreaterThen(FseMarginHeader.Value, Min) and EqualOrLessThen(FseMarginHeader.Value, Max);
    if Result then
    begin
   {footer}
      Min := 0;
      Max := APageSizeY - AMinPrintableArea - FseMarginHeader.Value;
      Result := EqualOrGreaterThen(FseMarginFooter.Value, Min) and EqualOrLessThen(FseMarginFooter.Value, Max);
    end
    else
    begin
      AInvalidMarginControl := FseMarginHeader;
      Exit;
    end;
   {top}
    if Result then
    begin
      Min := FseMarginHeader.Value;
      Max := APageSizeY - AMinPrintableArea - FseMarginBottom.Value;
      Result := EqualOrGreaterThen(FseMarginTop.Value, Min) and EqualOrLessThen(FseMarginTop.Value, Max);
    end
    else
    begin
      AInvalidMarginControl := FseMarginFooter;
      Exit;
    end;
    if Result then
    begin {bottom}
      Min := FseMarginFooter.Value;
      Max := APageSizeY - AMinPrintableArea - FseMarginTop.Value;
      Result := EqualOrGreaterThen(FseMarginBottom.Value, Min) and EqualOrLessThen(FseMarginBottom.Value, Max);
    end
    else
    begin
      AInvalidMarginControl := FseMarginTop;
      Exit;
    end;
    if Result then
    begin {left}
      Min := 0;
      Max := APageSizeX - AMinPrintableArea;
      Result := EqualOrGreaterThen(FseMarginLeft.Value, Min) and EqualOrLessThen(FseMarginLeft.Value, Max);
    end
    else
    begin
      AInvalidMarginControl := FseMarginBottom;
      Exit;
    end;
    if Result then
    begin {right}
      Min := 0;
      Max := APageSizeX - AMinPrintableArea - FseMarginLeft.Value;
      Result := EqualOrGreaterThen(FseMarginRight.Value, Min) and EqualOrLessThen(FseMarginRight.Value, Max);
    end
    else
    begin
      AInvalidMarginControl := FseMarginLeft;
      Exit;
    end;
  end;  
  if Result then
    AInvalidMarginControl := nil
  else
    AInvalidMarginControl := FseMarginRight;
end;

procedure TdxfmPageSetupDialog.UpdatePreviewMargin(const AValue: Extended;
  AMargin: TdxPreviewPageMargin);
var
  V: Integer;
begin
  V := Round(AValue * 1000);
  case Page.GetInnerMeasurementUnits of
    muInches:
      V := MulDiv(V, 254, 1000);
    muMillimeters:
      V := V div 100;
  end;
  AMargin.Value := V;
end;

procedure TdxfmPageSetupDialog.UpdatePreviewMargins;
begin
  UpdatePreviewMargin(FseMarginHeader.Value, FPreview.Margins.Header);
  UpdatePreviewMargin(FseMarginTop.Value, FPreview.Margins.Top);
  UpdatePreviewMargin(FseMarginFooter.Value, FPreview.Margins.Footer);
  UpdatePreviewMargin(FseMarginBottom.Value, FPreview.Margins.Bottom);
  UpdatePreviewMargin(FseMarginLeft.Value, FPreview.Margins.Left);
  UpdatePreviewMargin(FseMarginRight.Value, FPreview.Margins.Right);
end;

procedure TdxfmPageSetupDialog.UpdateWarningPane(AValue, APairValue: Boolean;
  const AHint, APairHint: string);
begin
  if AValue then 
    FwpMargins.SetStateAndHint(AValue, AHint)
  else
    if APairValue then   
      FwpMargins.SetStateAndHint(APairValue, APairHint)
    else  
      FwpMargins.State := False;
end;

procedure TdxfmPageSetupDialog.FixupMarginsOutside;

  function SetSpinEditValidValue(AEdit: TdxPSSpinEdit;
    var AValue: Integer; const ADenominator: Integer): Boolean;
  begin
    Result := False;
    while AEdit.Value < AValue / ADenominator do
    begin
      Inc(AValue);
      AEdit.Value := AValue / ADenominator;
      Result := True;
    end;
  end;

var
  AMinLeft, AMinRight, AMinTop, AMinBottom: Integer;
begin
  Page.GetRealMinMargins(AMinLeft, AMinRight, AMinTop, AMinBottom);
  FMarginsChanging := True;
  try
    if SetSpinEditValidValue(FseMarginTop, AMinTop, 1000) then
      UpdatePreviewMargin(AMinTop / 1000, FPreview.Margins.Top);
    if SetSpinEditValidValue(FseMarginHeader, AMinTop, 1000) then
      UpdatePreviewMargin(AMinTop / 1000, FPreview.Margins.Header);
    if SetSpinEditValidValue(FseMarginBottom, AMinBottom, 1000) then
      UpdatePreviewMargin(AMinBottom / 1000, FPreview.Margins.Bottom);
    if SetSpinEditValidValue(FseMarginFooter, AMinBottom, 1000) then
      UpdatePreviewMargin(AMinBottom / 1000, FPreview.Margins.Footer);
    if SetSpinEditValidValue(FseMarginLeft, AMinLeft, 1000) then
      UpdatePreviewMargin(AMinLeft / 1000, FPreview.Margins.Left);
    if SetSpinEditValidValue(FseMarginRight, AMinRight, 1000) then
      UpdatePreviewMargin(AMinRight / 1000, FPreview.Margins.Right);
  finally
    FMarginsChanging := False;
  end;
  MarginsOutside := False;
  MarginsInvalid := False;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.FixupMargins;

  function MinMax(const Value, Min, Max: Double): Double;
  begin
    if Value < Min then
      Result := Min
    else if Value > Max then
      Result := Max
    else
      Result := Value;
  end;

var
  V: Double;
  AMinLeft, AMinRight, AMinTop, AMinBottom: Integer;
begin
  Page.GetRealMinMargins(AMinLeft, AMinRight, AMinTop, AMinBottom);
  FMarginsChanging := True;
  try
    V := (Page.RealPageSize.Y - Page.MinPrintableArea - AMinBottom) / 1000;
    FseMarginHeader.Value := MinMax(FseMarginHeader.Value, AMinTop / 1000, V);
    V := (Page.RealPageSize.Y - Page.MinPrintableArea - 1000 * FseMarginHeader.Value) / 1000;
    FseMarginFooter.Value := MinMax(FseMarginFooter.Value, AMinBottom / 1000, V);
    V := (Page.RealPageSize.Y - Page.MinPrintableArea - 1000 * FseMarginFooter.Value) / 1000;
    FseMarginTop.Value := MinMax(FseMarginTop.Value, FseMarginHeader.Value, V);
    V := (Page.RealPageSize.Y - Page.MinPrintableArea - 1000 * FseMarginTop.Value) / 1000;
    FseMarginBottom.Value := MinMax(FseMarginBottom.Value, FseMarginFooter.Value, V);

    V := (Page.RealPageSize.X - Page.MinPrintableArea - AMinRight) / 1000;
    FseMarginLeft.Value := MinMax(FseMarginLeft.Value, AMinLeft / 1000, V);
    V := (Page.RealPageSize.X - Page.MinPrintableArea - 1000 * FseMarginLeft.Value) / 1000;
    FseMarginRight.Value := MinMax(FseMarginRight.Value, AMinRight / 1000, V);

    UpdatePreviewMargin(0, FPreview.Margins.Footer);
    UpdatePreviewMargin(0, FPreview.Margins.Bottom);
    UpdatePreviewMargin(0, FPreview.Margins.Right);
    UpdatePreviewMargin(FseMarginTop.Value, FPreview.Margins.Top);
    UpdatePreviewMargin(FseMarginHeader.Value, FPreview.Margins.Header);
    UpdatePreviewMargin(FseMarginBottom.Value, FPreview.Margins.Bottom);
    UpdatePreviewMargin(FseMarginFooter.Value, FPreview.Margins.Footer);
    UpdatePreviewMargin(FseMarginLeft.Value, FPreview.Margins.Left);
    UpdatePreviewMargin(FseMarginRight.Value, FPreview.Margins.Right);
  finally
    FMarginsChanging := False;
  end;

  MarginsInvalid := False;
  CheckModified;
end;

procedure TdxfmPageSetupDialog.RestoreOriginalMargins;
begin
  FMarginsChanging := True;
  try
    with FSavePrintStyle.PrinterPage do
    begin
      FseMarginHeader.Value := Footer / 1000;
      FPreview.Margins.Header.Value := HeaderLoMetric;
      FseMarginFooter.Value := Footer / 1000;
      FPreview.Margins.Footer.Value := FooterLoMetric;
      FseMarginLeft.Value := Margins.Left / 1000;
      FPreview.Margins.Left.Value := MarginsLoMetric.Left;
      FseMarginTop.Value := Margins.Top / 1000;
      FPreview.Margins.Top.Value := MarginsLoMetric.Top;
      FseMarginRight.Value := Margins.Right / 1000;
      FPreview.Margins.Right.Value := MarginsLoMetric.Right;
      FseMarginBottom.Value := Margins.Bottom / 1000;
      FPreview.Margins.Bottom.Value := MarginsLoMetric.Bottom;
    end;
  finally
    FMarginsChanging := False;
  end;
  MarginsOutside := False;
  MarginsInvalid := False;
  CheckModified;
end;

function TdxfmPageSetupDialog.FindControlPageIndex(AControl: TWinControl): Integer;
begin
  for Result := 0 to pgctrlMain.PageCount - 1 do
    if pgctrlMain.Pages[Result].ContainsControl(AControl) then Exit;
  Result := -1;
end;

procedure TdxfmPageSetupDialog.TrySetActiveControl(AControl: TWinControl);
var
  PageIndex: Integer;
begin
  PageIndex := FindControlPageIndex(AControl);
  if PageIndex = -1 then Exit;
  //if pgctrlMain.Pages[PageIndex].CanFocus then
  begin
    pgctrlMain.ActivePage := pgctrlMain.Pages[PageIndex];
    if AControl.CanFocus then ActiveControl := AControl;
  end;
end;

procedure TdxfmPageSetupDialog.pgctrlMainChanging(Sender: TObject; var AllowChange: Boolean);
var
  InvalidMarginControl: TWinControl;
begin
  if TPageControl(Sender).ActivePage.PageIndex = 1 then
  begin
    AllowChange := ValidateMargins(InvalidMarginControl);
    if not AllowChange then
    begin
      Beep;
      case MarginsMessageDlg(cxGetResourceString(@sdxInvalidMarginsMessage)) of
        mrYes:
          FixupMargins;
        mrNo:
          RestoreOriginalMargins;
      end;
      ActiveControl := InvalidMarginControl;
    end;
  end;
end;

procedure TdxfmPageSetupDialog.btnRestoreOriginalMarginsClick(
  Sender: TObject);
begin
  RestoreOriginalMargins;
end;

procedure TdxfmPageSetupDialog.btnFixClick(Sender: TObject);
begin
  if MarginsOutside then
    FixupMarginsOutside
  else 
    if MarginsInvalid then
      FixupMargins;
end;

procedure TdxfmPageSetupDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  Control: TWinControl;
begin
  if FPreview.DraggingMargin <> nil then
    CanClose := False
  else
    if ModalResult = mrOK then
    begin
      CanClose := ValidateUserInput(Control);
      if not CanClose then
      begin
        FPrintBtnClicked := False;
        FPreviewBtnClicked := False;
        TrySetActiveControl(Control);
      end
      else
        SaveUserInput;
    end;
end;

procedure TdxfmPageSetupDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (ModalResult = mrOK) and (ActiveControl is TdxPSSpinEdit) then
    TdxPSSpinEdit(ActiveControl).Perform(CM_EXIT, 0, 0);
end;

procedure TdxfmPageSetupDialog.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  if pgctrlMain.ActivePage = tshMargins then FPreview.Invalidate;
end;

{ TdxPrintStylePrinterPage }

function TdxPrintStylePrinterPage.GetOwner: TPersistent;
begin
  Result := PrintStyle;
end;

function TdxPrintStylePrinterPage.IsPageFooterTitleStored(Index: Integer): Boolean;
var
  Part: TdxPageTitlePart;
begin
  Part := dxPSPageTitlePartMap[Index];
  Result := PageFooter.Titles[Part].Text <> PrintStyle.DefaultPageFooterText(Part);
end;

function TdxPrintStylePrinterPage.IsPageHeaderTitleStored(Index: Integer): Boolean;
var
  Part: TdxPageTitlePart;
begin
  Part := dxPSPageTitlePartMap[Index];
  Result := PageHeader.Titles[Part].Text <> PrintStyle.DefaultPageHeaderText(Part);
end;

procedure TdxPrintStylePrinterPage.PageParamsChanged(AUpdateCodes: TdxPrinterPageUpdateCodes);
begin
  inherited;
  if (UpdateCount = 0) and PrintStyle.IsCurrentStyle then
    PrintStyle.PageParamsChanged(AUpdateCodes);
end;

{ TBasedxPrintStyle }

constructor TBasedxPrintStyle.Create(AOwner: TComponent);
begin
  inherited;
  FAllowChangeHFText := True;
  FAllowChangeMargins := True;
  FAllowChangeOrientation := True;
  FAllowChangePaper := True;
  FAllowChangeScale := True;
  FAllowCustomPaperSizes := True;
  FImageIndex := -1;
  FBuiltIn := IsDesigning;
  
  FPrinterPage := CreatePrinterPage;

  FStyleGlyph := TBitmap.Create;
  FStyleGlyph.OnChange := StyleGlyphChanged;
end;

destructor TBasedxPrintStyle.Destroy;
begin
  try
    if (StyleManager <> nil) and StyleManager.AllowAutoSave then
    try
      StyleManager.SaveToFile(StyleManager.StorageName);
    finally
      StyleManager.FAlreadySaved := True;
    end;
  finally
   {$IFNDEF DELPHI5}
    Destroying;
   {$ENDIF}
    StyleManager := nil;
    FreeAndNil(FPrinterPage);
    FreeAndNil(FStyleGlyph);
    FreeAndNil(FDefaultStyleGlyph);
    inherited;
  end;
end;

procedure TBasedxPrintStyle.BeforeDestruction;
begin
  DoDestroy;
  inherited;
end;

procedure TBasedxPrintStyle.Assign(Source: TPersistent);
begin
  if Source is TBasedxPrintStyle then
    with TBasedxPrintStyle(Source) do 
    begin
      Self.AllowChangeHFText := AllowChangeHFText;
      Self.AllowChangeMargins := AllowChangeMargins;
      Self.AllowChangeOrientation := AllowChangeOrientation;
      Self.AllowChangePaper := AllowChangePaper;
      Self.AllowChangeScale := AllowChangeScale;
      Self.AllowCustomPaperSizes := AllowCustomPaperSizes;
      Self.Description := Description;
      Self.ImageIndex := ImageIndex;
      Self.PrinterPage := PrinterPage;
      Self.StyleGlyph := StyleGlyph;
      Self.StyleCaption := StyleCaption;

      Self.FIsDescriptionAssigned := FIsDescriptionAssigned;
      Self.FIsStyleCaptionAssigned := FIsStyleCaptionAssigned;
      Self.FIsStyleGlyphAssigned := FIsStyleGlyphAssigned;
    end
  else
    inherited;
end;

function TBasedxPrintStyle.GetParentComponent: TComponent;
begin
  Result := StyleManager;
end;

function TBasedxPrintStyle.HasParent: Boolean;
begin
  Result := StyleManager <> nil;
end;

procedure TBasedxPrintStyle.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('BuiltInStyle', ReadData, WriteData, True);
  Filer.DefineProperty('IsDescriptonAssigned', ReadIsDescriptionAssigned, WriteIsDescriptionAssigned,
    FIsDescriptionAssigned and (Description = ''));
  Filer.DefineProperty('IsStyleCaptionAssigned', ReadIsStyleCaptionAssigned, WriteIsStyleCaptionAssigned, 
    FIsStyleCaptionAssigned and (StyleCaption = ''));
  Filer.DefineProperty('IsStyleGlyphAssigned', ReadIsStyleGlyphAssigned, WriteIsStyleGlyphAssigned, 
    FIsStyleGlyphAssigned and StyleGlyph.Empty);
end;

procedure TBasedxPrintStyle.ReadState(Reader: TReader);
begin
  inherited;
  if Reader.Parent is TdxPrintStyleManager then
    StyleManager := Reader.Parent as TdxPrintStyleManager;
end;

procedure TBasedxPrintStyle.SetName(const NewName: TComponentName);
begin
  inherited;
  DesignerUpdate(False);
end;

procedure TBasedxPrintStyle.SetParentComponent(AParent: TComponent);
begin
  inherited;
  if not IsLoading then
    StyleManager := AParent as TdxPrintStyleManager;
end;

class function TBasedxPrintStyle.StyleClass: TdxPrintStyleClass;
begin
  Result := TdxPrintStyleClass(GetTypeData(ClassInfo)^.ClassType);
end;

function TBasedxPrintStyle.DefaultDescription: string;
begin
  Result := '';
end;

function TBasedxPrintStyle.DefaultPageFooterText(APart: TdxPageTitlePart): string;
begin
  Result := '';
end;

function TBasedxPrintStyle.DefaultPageHeaderText(APart: TdxPageTitlePart): string;
begin
  Result := '';
end;

function TBasedxPrintStyle.DefaultStyleCaption: string;
begin
  Result := cxGetResourceString(@sdxBaseStyle);
end;

function TBasedxPrintStyle.DefaultStyleGlyph: TBitmap;
begin
  if FDefaultStyleGlyph = nil then
  begin
    FDefaultStyleGlyph := TBitmap.Create;
    InitializeDefaultStyleGlyph(FDefaultStyleGlyph);
  end;
  Result := FDefaultStyleGlyph;
end;  

procedure TBasedxPrintStyle.AfterPrinting;
begin
  DoAfterPrinting;
end;

procedure TBasedxPrintStyle.BeforePrinting;
begin
  DoBeforePrinting;
end;

procedure TBasedxPrintStyle.GetFilteredPapers(AStrings: TStrings);
var
  Papers: TStrings;
  I: Integer;
  Paper: TdxPaperInfo;
begin
  if AStrings = nil then Exit;
  
  AStrings.BeginUpdate;
  try
    Papers := dxPrintDevice.Papers;
    if Papers = nil then Exit;
    
    for I := 0 to Papers.Count - 1 do
    begin
      Paper := TdxPaperInfo(Papers.Objects[I]);
      if IsSupportedPaper(Paper) then
        AStrings.AddObject(Paper.Name, Paper);
      if Paper.DMPaper = DMPAPER_USER then
      begin
        Paper.Width := PrinterPage.PageSizeLoMetric.X;
        Paper.Height := PrinterPage.PageSizeLoMetric.Y;
      end;
    end;
  finally
    AStrings.EndUpdate;
  end;
end;

function TBasedxPrintStyle.PageSetup: Boolean;
var
  PreviewBtnClicked, PrintBtnClicked: Boolean;
begin
  Result := PageSetup(0, False, False, PreviewBtnClicked, PrintBtnClicked);
end;

function TBasedxPrintStyle.PageSetup(AnActivePageIndex: Integer; AShowPreviewBtn, AShowPrintBtn: Boolean; 
  out APreviewBtnClicked, APrintBtnClicked: Boolean): Boolean;

  function GetDialog(out ANewCreated: Boolean): TdxPageSetupDialog;
  begin
    if StyleManager <> nil then
      Result := StyleManager.PageSetupDialog
    else
      Result := nil;
    ANewCreated := Result = nil;
    if ANewCreated then
      Result := TdxPageSetupDialog.Create(nil);
  end;
  
var
  Dialog: TdxPageSetupDialog;
  NewCreated: Boolean;
  PrevStyle: TBasedxPrintStyle;
begin
  Dialog := GetDialog(NewCreated);
  try
    PrevStyle := Dialog.PrintStyle;
    Dialog.PrintStyle := Self;
    Dialog.ActivePageIndex := AnActivePageIndex;

    if not AShowPreviewBtn then
      Dialog.ButtonsVisible := Dialog.ButtonsVisible - [psbPreview];

    if not AShowPrintBtn then
      Dialog.ButtonsVisible := Dialog.ButtonsVisible - [psbPrint];

    if StyleManager = nil then
      Dialog.OptionsVisible := Dialog.OptionsVisible - [psoStyleCaption];

    Result := Dialog.Execute;
    Dialog.PrintStyle := PrevStyle;
    
    APreviewBtnClicked := AShowPreviewBtn and Dialog.PreviewBtnClicked;
    APrintBtnClicked := AShowPrintBtn and Dialog.PrintBtnClicked;
  finally
    if NewCreated then Dialog.Free;
  end;
end;

function TBasedxPrintStyle.PageSetup(AnActivePageIndex: Integer;
  APreviewBtnClicked, APrintBtnClicked: PBoolean): Boolean;
var
  ShowPreviewBtn, ShowPrintBtn: Boolean;
  PreviewBtnClicked, PrintBtnClicked: Boolean;
begin
  ShowPreviewBtn := APreviewBtnClicked <> nil;
  ShowPrintBtn := APrintBtnClicked <> nil;
  Result := PageSetup(0, ShowPreviewBtn, ShowPrintBtn, PreviewBtnClicked, PrintBtnClicked);
    
  if ShowPreviewBtn then 
    APreviewBtnClicked^ := PreviewBtnClicked;

  if ShowPrintBtn then 
    APrintBtnClicked^ := PrintBtnClicked;
end;     

function TBasedxPrintStyle.PageSetupEx(AnActivePageIndex: Integer;
  APreviewBtnClicked, APrintBtnClicked: PBoolean): Boolean;
var
  ShowPreviewBtn, ShowPrintBtn: Boolean;
  PreviewBtnClicked, PrintBtnClicked: Boolean;
begin
  ShowPreviewBtn := APreviewBtnClicked <> nil;
  ShowPrintBtn := APrintBtnClicked <> nil;
  Result := PageSetup(0, ShowPreviewBtn, ShowPrintBtn, PreviewBtnClicked, PrintBtnClicked);
    
  if ShowPreviewBtn then 
    APreviewBtnClicked^ := PreviewBtnClicked;

  if ShowPrintBtn then 
    APrintBtnClicked^ := PrintBtnClicked;
end;  

function TBasedxPrintStyle.SetupOptions: Boolean;
begin
  Result := False;
end;

procedure TBasedxPrintStyle.RestoreDefaultGlyph;
begin
  FIsStyleGlyphAssigned := False;
  DesignerModified;
  DesignerUpdate(False);
end;

procedure TBasedxPrintStyle.RestoreDefaults;
begin
  AllowChangeHFText := True;
  AllowChangeMargins := True;
  AllowChangeOrientation := True;
  AllowChangePaper := True;
  AllowChangeScale := True;
  AllowCustomPaperSizes := True;
  PrinterPage.RestoreDefaults;
  
  FIsDescriptionAssigned := False;
  FIsStyleCaptionAssigned := False;
  FIsStyleGlyphAssigned := False;
end;

function TBasedxPrintStyle.GetAllowChangeHFText: Boolean;
begin
  Result := FAllowChangeHFText;
end;

function TBasedxPrintStyle.GetAllowChangeMargins: Boolean;
begin
  Result := FAllowChangeMargins;
end;

function TBasedxPrintStyle.GetAllowChangePaper: Boolean;
begin
  Result := FAllowChangePaper;
end;

function TBasedxPrintStyle.GetAllowChangeScale: Boolean;
begin
  Result := FAllowChangeScale;
end;

procedure TBasedxPrintStyle.SetAllowChangeHFText(Value: Boolean);
begin
  FAllowChangeHFText := Value;
end;

function TBasedxPrintStyle.GetAllowChangeOrientation: Boolean;
begin
  Result := FAllowChangeOrientation;
end;

function TBasedxPrintStyle.GetAllowCustomPaperSizes: Boolean;
begin
  Result := FAllowCustomPaperSizes;
end;

procedure TBasedxPrintStyle.SetAllowChangeMargins(Value: Boolean);
begin
  FAllowChangeMargins := Value;
end;

procedure TBasedxPrintStyle.SetAllowChangeOrientation(Value: Boolean);
begin
  FAllowChangeOrientation := Value;
end;

procedure TBasedxPrintStyle.SetAllowChangePaper(Value: Boolean);
begin
  FAllowChangePaper := Value;
end;

procedure TBasedxPrintStyle.SetAllowChangeScale(Value: Boolean);
begin
  FAllowChangeScale := Value;
end;

procedure TBasedxPrintStyle.SetAllowCustomPaperSizes(Value: Boolean);
begin
  FAllowCustomPaperSizes := Value;
end;

function TBasedxPrintStyle.CreatePrinterPage: TdxPrinterPage;
begin
  Result := GetPrinterPageClass.Create;
  InitializePrinterPage(Result);
end;

function TBasedxPrintStyle.GetPrinterPageClass: TdxPrinterPageClass;
begin
  Result := TdxPrintStylePrinterPage;
end;

procedure TBasedxPrintStyle.InitializePrinterPage(APrinterPage: TdxPrinterPage);
begin
  TdxPrintStylePrinterPage(APrinterPage).FPrintStyle := Self;
end;

procedure TBasedxPrintStyle.DoAfterPrinting;
begin
end;

procedure TBasedxPrintStyle.DoBeforePrinting;
begin
end;

procedure TBasedxPrintStyle.DoDestroy;
begin
  if Assigned(FOnDestroy) then FOnDestroy(Self);
end;

function TBasedxPrintStyle.IsSupportedPaper(const APaper: TdxPaperInfo): Boolean;
begin
  Result := True;
  if Assigned(FOnFilterPaper) then
  begin
    FOnFilterPaper(Self, APaper, Result);
    if not Result and (APaper.DMPaper = PrinterPage.DMPaper) then
      Result := True;
  end;
end;

procedure TBasedxPrintStyle.PageParamsChanged(AUpdateCodes: TdxPrinterPageUpdateCodes);
begin
  if StyleManager <> nil then
    StyleManager.PageParamsChanged(Self, AUpdateCodes);
end;

procedure TBasedxPrintStyle.InitializeDefaultStyleGlyph(ABitmap: TBitmap);
begin
end;

procedure TBasedxPrintStyle.StyleGlyphChanged(Sender: TObject);
begin
  FIsStyleGlyphAssigned := True;
  DesignerUpdate(False);
end;

function TBasedxPrintStyle.GetDescription: string;
begin
  if FIsDescriptionAssigned then
    Result := FDescription
  else
    Result := DefaultDescription;
end;

function TBasedxPrintStyle.GetIndex: Integer;
begin
  if StyleManager <> nil then
    Result := StyleManager.IndexOfStyle(Self)
  else
    Result := -1;
end;

function TBasedxPrintStyle.GetIsCurrentStyle: Boolean;
begin
  Result := (StyleManager <> nil) and (StyleManager.CurrentStyle = Self);
end;

function TBasedxPrintStyle.GetStyleCaption: string;
begin
  if FIsStyleCaptionAssigned then
    Result := FStyleCaption
  else
    Result := DefaultStyleCaption;  
end;

function TBasedxPrintStyle.GetStyleGlyph: TBitmap;
begin
  if FIsStyleGlyphAssigned or (csLoading in ComponentState) then
    Result := FStyleGlyph
  else
    Result := DefaultStyleGlyph;
end;

function TBasedxPrintStyle.IsDescriptionStored: Boolean;
begin
  Result := FIsDescriptionAssigned and (FDescription <> DefaultDescription);
end;

function TBasedxPrintStyle.IsStyleCaptionStored: Boolean;
begin
  Result := FIsStyleCaptionAssigned and (FStyleCaption <> DefaultStyleCaption);
end;

function TBasedxPrintStyle.IsStyleGlyphStored: Boolean;
begin
  Result := FIsStyleGlyphAssigned and not dxPSUtl.dxAreGraphicsEqual(FStyleGlyph, DefaultStyleGlyph);
end;

procedure TBasedxPrintStyle.SetBuiltIn(Value: Boolean);
begin
  FBuiltIn := Value;
end;

procedure TBasedxPrintStyle.SetDescription(const Value: string);
begin
  if Description <> Value then
  begin
    FDescription := Value;
    FIsDescriptionAssigned := True;
  end;
end;

procedure TBasedxPrintStyle.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    if (StyleManager <> nil) and (StyleManager.Images <> nil) then
      DesignerUpdate(False);
  end;
end;

procedure TBasedxPrintStyle.SetIndex(Value: Integer);
var
  CurIndex: Integer;
begin
  if FStyleManager = nil then Exit;
  if Value < 0 then Value := 0;
  if Value > StyleManager.Count - 1 then
    Value := StyleManager.Count - 1;
  CurIndex := GetIndex;
  if CurIndex <> Value then
    StyleManager.MoveStyle(CurIndex, Value);
end;

procedure TBasedxPrintStyle.SetIsCurrentStyle(Value: Boolean);
begin
  if Value then
    if not (csReading in ComponentState) and (StyleManager <> nil) then
      StyleManager.CurrentStyle := Self;
end;

procedure TBasedxPrintStyle.SetPrinterPage(Value: TdxPrinterPage);
begin
  PrinterPage.Assign(Value);
end;

procedure TBasedxPrintStyle.SetStyleCaption(const Value: string);
begin
  if StyleCaption <> Value then
  begin
    FStyleCaption := Value;
    FIsStyleCaptionAssigned := True;
  end;  
end;

procedure TBasedxPrintStyle.SetStyleGlyph(Value: TBitmap);
begin
  FStyleGlyph.Assign(Value);
end;

procedure TBasedxPrintStyle.SetStyleManager(Value: TdxPrintStyleManager);
begin
  if FStyleManager <> Value then
  begin
    if FStyleManager <> nil then
      FStyleManager.RemoveStyle(Self);
    if Value <> nil then
      Value.InsertStyle(Self);
  end;
end;

procedure TBasedxPrintStyle.DesignerModified;
begin
  if StyleManager <> nil then StyleManager.DesignerModified;
end;

procedure TBasedxPrintStyle.DesignerUpdate(TheAll: Boolean);
begin
  if StyleManager <> nil then
    if TheAll then
      StyleManager.DesignerUpdate(nil)
    else
      StyleManager.DesignerUpdate(Self);
end;

function TBasedxPrintStyle.IsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TBasedxPrintStyle.IsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

procedure TBasedxPrintStyle.ReadData(Reader: TReader);
begin
  FBuiltIn := Reader.ReadBoolean;
end;

procedure TBasedxPrintStyle.ReadIsDescriptionAssigned(Reader: TReader);
begin
  FIsDescriptionAssigned := Reader.ReadBoolean;
end;

procedure TBasedxPrintStyle.ReadIsStyleCaptionAssigned(Reader: TReader);
begin
  FIsStyleCaptionAssigned := Reader.ReadBoolean;
end;

procedure TBasedxPrintStyle.ReadIsStyleGlyphAssigned(Reader: TReader);
begin
  FIsStyleGlyphAssigned := Reader.ReadBoolean;
end;

procedure TBasedxPrintStyle.WriteData(Writer: TWriter);
begin
  Writer.WriteBoolean(FBuiltIn);
end;

procedure TBasedxPrintStyle.WriteIsDescriptionAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsDescriptionAssigned);
end;

procedure TBasedxPrintStyle.WriteIsStyleCaptionAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsStyleCaptionAssigned);
end;

procedure TBasedxPrintStyle.WriteIsStyleGlyphAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsStyleGlyphAssigned);
end;

{ TdxPrintStyleManager }

constructor TdxPrintStyleManager.Create(AOwner: TComponent);
begin
  inherited;
  FAutoHFTextEntries := CreateAutoHFTextEntries;
  FStyles := TList.Create;
  FWindowHandle := dxPSUtl.dxAllocatehWnd(WndProc);
end;

destructor TdxPrintStyleManager.Destroy;
begin
  try
    if AllowAutoSave then
    try
      SaveToFile(StorageName);
    finally
      FAlreadySaved := True;
    end;
  finally
   {$IFNDEF DELPHI5}
    Destroying;
   {$ENDIF}
    dxPSUtl.dxDeallocateHWnd(FWindowHandle);

    FreeAndNil(FDesigner);
    FreeAndNilStyles;
    if not IsDesigning and (RegistryPath <> '') then
      SaveToRegistry(RegistryPath);
    FreeAndNil(FAutoHFTextEntries);
    inherited;
  end;
end;

procedure TdxPrintStyleManager.Assign(Source: TPersistent);
begin
  if Source is TdxPrintStyleManager then
    with TdxPrintStyleManager(Source) do 
    begin
      Self.AutoHFTextEntries := AutoHFTextEntries;
      Self.AssignStyles(TdxPrintStyleManager(Source));
    
      Self.FIsCloneStyleCaptionPrefixAssigned := FIsCloneStyleCaptionPrefixAssigned;
      Self.FIsTitleAssigned := FIsTitleAssigned;
    end
  else
    inherited;
end;
    
procedure TdxPrintStyleManager.Loaded;
begin
  inherited;
  if not IsDesigning and (RegistryPath <> '') then
    LoadFromRegistry(RegistryPath);
  
  if not FInternalStreaming and not IsDesigning and AutoSave then
    LoadFromFile(StorageName);
end;

procedure TdxPrintStyleManager.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
    if AComponent = PageSetupDialog then PageSetupDialog := nil;
  end;
end;

procedure TdxPrintStyleManager.ReadState(Reader: TReader);
begin
  if FInternalStreaming then
    Reader.OnSetName := SetNameHandler;
  try
    inherited;
  finally
    if FInternalStreaming then
      Reader.OnSetName := nil;
  end;
end;

procedure TdxPrintStyleManager.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('IsTitleAssigned', ReadIsTitleAssigned, WriteIsTitleAssigned, 
    FIsTitleAssigned and (Title = ''));
  Filer.DefineProperty('IsCloneStyleCaptionPrefixAssigned', 
    ReadIsCloneStyleCaptionPrefixAssigned, WriteIsCloneStyleCaptionPrefixAssigned, 
    FIsCloneStyleCaptionPrefixAssigned and (CloneStyleCaptionPrefix = ''));
end;

procedure TdxPrintStyleManager.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Style: TBasedxPrintStyle;
begin
  for I := 0 to Count - 1 do
  begin
    Style := Styles[I];
    if (Root = Style.Owner) or (FInternalStreaming and (Root = Style.StyleManager)) then
      Proc(Style);
  end;
end;

procedure TdxPrintStyleManager.SetChildOrder(Child: TComponent; Order: Integer);
begin
  inherited;
  if FStyles.IndexOf(Child) > -1 then
    (Child as TBasedxPrintStyle).Index := Order;
end;

procedure TdxPrintStyleManager.AutoHFTextEntriesChanged(Sender: TObject);
var
  Event: TdxEvent;
begin
  Event := TdxHFTextEntriesChangedEvent.Create(Self);
  dxPSProcessEvent(Event);
end;

procedure TdxPrintStyleManager.OnAutoHFTextEntryClick(Sender: TObject);
var
  S: string;
  Event: TdxEvent;
begin
  try
    S := AutoHFTextEntries[dxPSAutoHFTextMenuBuilderFactory.ActiveBuilder.ExtractAutoHFTextEntryIndexFromObj(Sender)];
    Event := TdxHFTextEntryChooseEvent.Create(Self, S);
    dxPSProcessEvent(Event);
  except
    Application.HandleException(Self);
  end;  
end;

procedure TdxPrintStyleManager.OnEditAutoHFTextEntriesClick(Sender: TObject);
begin
  ShowAutoHFTextEntriesDlg;
end;

procedure TdxPrintStyleManager.WndProc(var Message: TMessage);
var
  I: Integer;
begin
  with Message do 
  begin
    case Msg of
      WM_SETTINGCHANGE:
  //        if (PChar(message.lParam) = 'devices') then
        begin
          RereadDefaultPrinterPage;
          for I := 0 to Count - 1 do
            TdxPrintStylePrinterPage(Styles[I].PrinterPage).SynchronizeMeasurementUnits;
          DesignerModified;
        end;

      WMPS_PRINTSTYLELISTCHANGED:
        begin
          StyleListChanged;
          ChangeCurrentStyle;
        end;
    end;
    Result := DefWindowProc(FWindowHandle, Msg, WParam, LParam);
  end;
end;

procedure TdxPrintStyleManager.SetNameHandler(Reader: TReader; Component: TComponent;
  var Name: string);
begin
  if (Component is TBasedxPrintStyle) and (StyleByName(Name) <> nil) then
  begin
    if FLoadedExistingStyles = nil then
      FLoadedExistingStyles := TStringList.Create;
    FLoadedExistingStyles.AddObject(Name, Component);
    Name := '';
  end;
end;

procedure TdxPrintStyleManager.ReadIsCloneStyleCaptionPrefixAssigned(Reader: TReader);
begin
  FIsCloneStyleCaptionPrefixAssigned := Reader.ReadBoolean;
end;

procedure TdxPrintStyleManager.ReadIsTitleAssigned(Reader: TReader);
begin
  FIsTitleAssigned := Reader.ReadBoolean;
end;

procedure TdxPrintStyleManager.WriteIsCloneStyleCaptionPrefixAssigned(Writer: TWriter); 
begin
  Writer.WriteBoolean(FIsCloneStyleCaptionPrefixAssigned);
end;

procedure TdxPrintStyleManager.WriteIsTitleAssigned(Writer: TWriter); 
begin
  Writer.WriteBoolean(FIsTitleAssigned);
end;

function TdxPrintStyleManager.IsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TdxPrintStyleManager.IsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TdxPrintStyleManager.IsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TdxPrintStyleManager.AllowAutoSave: Boolean;
begin
  Result := AutoSave and not IsDesigning and IsDestroying and not FAlreadySaved;
end;

procedure TdxPrintStyleManager.DesignerUpdate(AStyle: TBasedxPrintStyle);
begin
  if IsDesigning and (Designer <> nil) then
    Designer.Update(AStyle);
end;

procedure TdxPrintStyleManager.DesignerModified;
begin
  if IsDesigning and (Designer <> nil) then
    Designer.Modified;
end;

procedure TdxPrintStyleManager.SetName(const NewName: TComponentName);
var
  OldName, ItemName, AName: string;
  P, I: Integer;
begin
  OldName := Name;
  inherited SetName(NewName);
  if IsDesigning and (Count > 0) then
  try
    if Designer <> nil then Designer.BeginUpdate;
    try
      for I := 0 to Count - 1 do
      begin
        ItemName := Styles[I].Name;
        P := Pos(OldName, ItemName);
        if P = 0 then
          AName := Name + ItemName
        else
          AName := Copy(ItemName, 1, P - 1) + Name +
            Copy(ItemName, P + Length(OldName), Length(ItemName) - P - Length(OldName) + 1);
        Styles[I].Name := AName;
      end;
    finally
      if Designer <> nil then Designer.EndUpdate;
    end;
  except
    on EComponentError do ; {Ignore rename errors }
  end;
end;

procedure TdxPrintStyleManager.SetPageSetupDialog(Value: TdxPageSetupDialog);
begin
  if FPageSetupDialog <> Value then
  begin
    FPageSetupDialog := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

function TdxPrintStyleManager.GetStyle(Index: Integer): TBasedxPrintStyle;
begin
  Result := TBasedxPrintStyle(FStyles[Index]);
end;

function TdxPrintStyleManager.GetTitle: string;
begin
  if FIsTitleAssigned then
    Result := FTitle
  else
    Result := DefaultTitle;  
end;
                                               
function TdxPrintStyleManager.IsAutoHFTextEntriesStored: Boolean;
begin
  Result := not AutoHFTextEntries.Equals(DefaultAutoHFTextEntries);
end;
                             
function TdxPrintStyleManager.IsCloneStyleCaptionPrefixStored: Boolean;
begin                                                        
  Result := FIsCloneStyleCaptionPrefixAssigned and (FCloneStyleCaptionPrefix <> DefaultCloneStyleCaptionPrefix);
end;

function TdxPrintStyleManager.IsTitleStored: Boolean;
begin
  Result := FIsTitleAssigned and (FTitle <> DefaultTitle);
end;

procedure TdxPrintStyleManager.SetStyle(Index: Integer; Value: TBasedxPrintStyle);
begin
  Styles[Index].Assign(Value);
end;
                             
procedure TdxPrintStyleManager.SetTitle(const Value: string);
begin
  if Title <> Value then
  begin
    FTitle := Value;
    FIsTitleAssigned := True;
  end;
end;

procedure TdxPrintStyleManager.SetImages(Value: TImageList);
begin
  if FImages <> Value then
  begin
    FImages := Value;
    if FImages <> nil then
      FImages.FreeNotification(Self);
    DesignerUpdate(nil);
  end;
end;

procedure TdxPrintStyleManager.AssignStyles(Source: TdxPrintStyleManager);
var
  I: Integer;
  Style: TBasedxPrintStyle;
begin
  BeginUpdate;
  try
    Clear;
    Images := Source.Images;
    for I := 0 to Source.Count - 1 do
    begin
      Style := Source[I];
      AddStyle(Style.StyleClass).Assign(Style);
    end;
  finally
    EndUpdate;
  end;
end;

function TdxPrintStyleManager.IndexOfStyle(Value: TBasedxPrintStyle): Integer;
begin
  Result := FStyles.IndexOf(Value);
end;

function TdxPrintStyleManager.StyleByCaption(const ACaption: string): TBasedxPrintStyle;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if dxSameText(ACaption, Styles[I].StyleCaption) then
    begin
      Result := Styles[I];
      Exit;
    end;
  Result := nil;
end;

function TdxPrintStyleManager.StyleByName(const AName: string): TBasedxPrintStyle;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Styles[I];
    if CompareText(AName, Result.Name) = 0 then Exit;
  end;
  Result := nil;
end;

procedure TdxPrintStyleManager.Delete(Index: Integer);
var
  Style: TBasedxPrintStyle;
begin
  if (Index > -1) and (Index < Count) then
  begin
    Style := Styles[Index];
    Style.Free;
  end;
end;

procedure TdxPrintStyleManager.Clear;
begin
  BeginUpdate;
  try
    while Count > 0 do Delete(Count - 1);
  finally
    EndUpdate;
  end;
end;

function TdxPrintStyleManager.NonBuiltInsExists: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to Count - 1 do
    if not Styles[I].BuiltIn then Exit;
  Result := False;
end;

procedure TdxPrintStyleManager.DeleteNonBuiltIns;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := Count - 1 downto 0 do
      if not Styles[I].BuiltIn then Delete(I);
  finally
    EndUpdate;
  end;
end;

function TdxPrintStyleManager.BeginClone(AIndex: Integer): TBasedxPrintStyle;
var
  StyleClass: TdxPrintStyleClass;
begin
  Result := nil;
  if (AIndex < -1) or (AIndex > Count - 1) then Exit;
  if AIndex = -1 then
    StyleClass := dxDefaultPrintStyleClass
  else
    StyleClass := Styles[AIndex].StyleClass;
  if StyleClass = nil then Exit;
  BeginUpdate;
  Result := AddStyle(StyleClass);
  Result.Index := AIndex + 1;
  Include(Result.FState, pssCopy);
  if AIndex > -1 then
  begin
    Result.Assign(Styles[AIndex]);
    SetNewStyleCaption(Result, AIndex);
  end;
end;

procedure TdxPrintStyleManager.EndClone(AStyle: TBasedxPrintStyle);
begin
//  CurrentStyle := AStyle;
  if IsDesigning then
    AStyle.Name := dxPSPrintStyleUniqueName(Self, AStyle);
  EndUpdate;
  Exclude(AStyle.FState, pssCopy);
end;

procedure TdxPrintStyleManager.SetNewStyleCaption(AStyle: TBasedxPrintStyle;
  AIndex: Integer);

  function CheckName(const Source: string): Boolean;
  var
    I: Integer;
  begin
    for I := 0 to Count - 1 do
      if Styles[I] <> AStyle then
      begin
        Result := not dxSameStr(Source, Styles[I].StyleCaption);
        if not Result then Exit;
      end;
    Result := True;
  end;

const
  MaskCount = 4;
  Mask: array[0..MaskCount - 1] of string = ('(%d) ', '(%d)', '%d ', '%d');
var
  S, S2: string;
  OkName: Boolean;
  I, K: Integer;
begin
  OkName := False;
  if not OkName then
  begin
    S := CloneStyleCaptionPrefix + Styles[AIndex].StyleCaption;
    for K := 0 to MaskCount - 1 do
    begin
      I := Pos(Mask[K], S);
      if I > 0 then
      begin
        System.Delete(S, I, Length(Mask[K]));
        Break;
      end;
    end;
    if Length(S) > dxMaxStyleCaption then SetLength(S, dxMaxStyleCaption);
    OkName := CheckName(S);
    if not OkName then
    begin
      S2 := CloneStyleCaptionPrefix + Styles[AIndex].StyleCaption;
      if (Length(S2) > dxMaxStyleCaption) then SetLength(S2, dxMaxStyleCaption);
      I := 2;
      while not OkName and (I < MaxInt) do
      begin
        try
          S := Format(S2, [I]);
        except
          S := S2;
        end;
        if Length(S) > dxMaxStyleCaption then 
          SetLength(S, dxMaxStyleCaption);
        if dxSameStr(S, S2) then
        begin
          AStyle.StyleCaption := S;
          Exit;
        end;
        OkName := CheckName(S);
        Inc(I);
      end;
    end;
  end;
  if OkName then AStyle.StyleCaption := S;
end;

function TdxPrintStyleManager.AddStyle(AStyleClass: TdxPrintStyleClass): TBasedxPrintStyle;
begin
  Result := AddStyleEx(AStyleClass, Self.Owner);
end;

function TdxPrintStyleManager.AddStyleEx(AStyleClass: TdxPrintStyleClass;
  AOwner: TComponent): TBasedxPrintStyle;
begin
  Result := nil;
  if AStyleClass = nil then 
    Exit;
  Result := AStyleClass.Create(AOwner);
  Result.StyleManager := Self;
end;

procedure TdxPrintStyleManager.ResyncCurrentStyle(AIndex: Integer);
begin
  if AIndex > Count - 1 then 
    AIndex := Count - 1;
  if AIndex < 0 then
  begin
    FCurrentStyle := nil;
    ChangeCurrentStyle;
  end
  else
    CurrentStyle := Styles[AIndex];
end;
procedure TdxPrintStyleManager.FreeAndNilStyles;
begin
  Clear;
  FreeAndNil(FStyles);
end;

procedure TdxPrintStyleManager.InsertStyle(Value: TBasedxPrintStyle);
begin
  FStyles.Add(Value);
  Value.FStyleManager := Self;
  if Count = 1 then 
    CurrentStyle := Value;
  StyleListChanged;
end;

procedure TdxPrintStyleManager.MoveStyle(ACurIndex, ANewIndex: Integer);
begin
  FStyles.Move(ACurIndex, ANewIndex);
  DesignerUpdate(nil);
end;

procedure TdxPrintStyleManager.RemoveStyle(Value: TBasedxPrintStyle);
var
  Index: Integer;
begin
  if FCurrentStyle = Value then
    Index := Value.Index
  else
    Index := -1;
  FStyles.Remove(Value);
  Value.FStyleManager := nil;
  if Index <> -1 then
    ResyncCurrentStyle(Index);
  StyleListChanged;
end;

function TdxPrintStyleManager.GetCloneStyleCaptionPrefix: string;
begin
  if FIsCloneStyleCaptionPrefixAssigned then
    Result := FCloneStyleCaptionPrefix
  else
    Result := DefaultCloneStyleCaptionPrefix;
end;

function TdxPrintStyleManager.GetCount: Integer;
begin
  Result := FStyles.Count;
end;

procedure TdxPrintStyleManager.RestoreDefaultAutoHFTextEntries; 
begin
  AutoHFTextEntries.Assign(DefaultAutoHFTextEntries);  
end;

procedure TdxPrintStyleManager.RestoreDefaults;
begin
  BeginUpdate;
  try
    DoRestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TdxPrintStyleManager.RestoreDefaultStyles;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Styles[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TdxPrintStyleManager.LoadFromFile(const AName: string);
var
  AStream: TFileStream;
begin
  if (AName <> '') and FileExists(AName) then
  begin
    AStream := TFileStream.Create(AName, fmOpenRead or fmShareDenyWrite);
    try
      LoadFromStream(AStream);
    finally
      AStream.Free;
    end;
  end;
end;

procedure TdxPrintStyleManager.LoadFromStream(AStream: TStream);

  procedure CheckExistingStyles(AExistingStyleCount: Integer);
  var
    I, ALoadedExistingStyleIndex: Integer;
    AStyle: TBasedxPrintStyle;
  begin
    for I := AExistingStyleCount - 1 downto 0 do
    begin
      if FLoadedExistingStyles = nil then
        ALoadedExistingStyleIndex := -1
      else
        ALoadedExistingStyleIndex := FLoadedExistingStyles.IndexOf(Styles[I].Name);
      if ALoadedExistingStyleIndex = -1 then
        Styles[I].Free
      else
      begin
        AStyle := TBasedxPrintStyle(FLoadedExistingStyles.Objects[ALoadedExistingStyleIndex]);
        Styles[I].Assign(AStyle);
        AStyle.Free;
      end;
    end;
    FreeAndNil(FLoadedExistingStyles);
  end;

var
  Version: Integer;
  M: TMemoryStream;
  AExistingStyleCount, I: Integer;
  Style: TBasedxPrintStyle;
  CurrentStyleIndex: Integer;
begin
  AStream.ReadBuffer(Version , SizeOf(Integer));
  if Version <> Self.Version then Exit;
  BeginUpdate;
  try
    M := TMemoryStream.Create;
    try
      AExistingStyleCount := Count;
      FInternalStreaming := True;
      try
        M.WriteComponent(Self);
        try
          try
            AStream.ReadBuffer(CurrentStyleIndex , SizeOf(Integer));
            AStream.ReadComponent(Self);
            Self.CurrentStyleIndex := CurrentStyleIndex;
          finally
            CheckExistingStyles(AExistingStyleCount);
          end;
        except
          Clear;  // links to styles in other components will be lost
          M.Position := 0;
          M.ReadComponent(Self);
          Application.HandleException(Self);
        end;
      finally
        Loaded;
        for I := 0 to Count - 1 do
        begin
          Style := Styles[I];
          if Style.Owner = Self then
          begin
            RemoveComponent(Style);
            Owner.InsertComponent(Style);
          end;
          Style.Loaded;
        end;
        FInternalStreaming := False;
      end;
    finally
      M.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TdxPrintStyleManager.SaveToFile(const AName: string);
var
  AStream: TFileStream;
begin
  if ValidateFileName(AName) then
  begin
    AStream := TFileStream.Create(AName, fmCreate or fmShareDenyWrite);
    try
      SaveToStream(AStream);
    finally
      AStream.Free;
    end;
  end;
end;

procedure TdxPrintStyleManager.SaveToStream(AStream: TStream);
var
  ACurrentStyleIndex: Integer;
begin
  FInternalStreaming := True;
  try
    AStream.WriteBuffer(Version , SizeOf(Integer));
    ACurrentStyleIndex := CurrentStyleIndex;
    AStream.WriteBuffer(ACurrentStyleIndex , SizeOf(Integer));
    AStream.WriteComponent(Self);
  finally
    FInternalStreaming := False;
  end;
end;

function TdxPrintStyleManager.CreateAutoHFTextEntries: TStrings;
begin
  FAutoHFTextEntries := TStringList.Create;
  with TStringList(FAutoHFTextEntries) do 
  begin
    Duplicates := dupIgnore;
    Assign(DefaultAutoHFTextEntries);
    OnChange := AutoHFTextEntriesChanged;
  end;
  Result := FAutoHFTextEntries;
end;

procedure TdxPrintStyleManager.DoRestoreDefaults;
begin
  RestoreDefaultAutoHFTextEntries;
  RestoreDefaultStyles;
  AutoSave := False;
  FIsCloneStyleCaptionPrefixAssigned := False;  
  FIsTitleAssigned := False;  
end;

procedure TdxPrintStyleManager.ChangeCurrentStyle;
begin
  if (FUpdateCount = 0) and not IsLoading and not IsDestroying then
    if Assigned(FOnChangeCurrentStyle) then FOnChangeCurrentStyle(Self);
end;

procedure TdxPrintStyleManager.StyleListChanged;
var
  Event: TdxEvent;
begin
  if (FUpdateCount = 0) and not IsLoading and not IsDestroying then
  begin
    if Assigned(FOnStyleListChanged) then FOnStyleListChanged(Self);
    Event := TdxSMStyleListChangedEvent.Create(Self);
    dxPSProcessEvent(Event);
  end;
end;

procedure TdxPrintStyleManager.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxPrintStyleManager.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
    begin
      StyleListChanged;
      ChangeCurrentStyle;
    end;
  end;
end;

function TdxPrintStyleManager.DefaultCloneStyleCaptionPrefix: string;
begin
  Result := cxGetResourceString(@sdxCloneStyleCaptionPrefix);
end;

function TdxPrintStyleManager.DefaultTitle: string;
begin
  Result := cxGetResourceString(@sdxDefinePrintStylesCaption);
end;

procedure TdxPrintStyleManager.PageParamsChanged(APrintStyle: TBasedxPrintStyle;
  AUpdateCodes: TdxPrinterPageUpdateCodes);
var
  Event: TdxEvent;
begin
  Event := TdxSMPageParamsChangedEvent.Create(Self, APrintStyle, AUpdateCodes);
  dxPSProcessEvent(Event);
end;

procedure TdxPrintStyleManager.SetAutoHFTextEntries(Value: TStrings);
begin
  AutoHFTextEntries.Assign(Value);
end;

procedure TdxPrintStyleManager.SetCloneStyleCaptionPrefix(const Value: string);
begin
  if CloneStyleCaptionPrefix <> Value then
  begin
    FCloneStyleCaptionPrefix := Value;
    FIsCloneStyleCaptionPrefixAssigned := True;
  end;
end;

procedure TdxPrintStyleManager.SetCurrentStyle(Value: TBasedxPrintStyle);
begin
  if (FCurrentStyle <> Value) and (IndexOfStyle(Value) <> -1) then
  begin
    FCurrentStyle := Value;
    PageParamsChanged(Value, ucAll);
    ChangeCurrentStyle;
    DesignerUpdate(Value);//nil);
  end;
end;

function TdxPrintStyleManager.GetCurrentStyleIndex: Integer;
begin
  if CurrentStyle <> nil then
    Result := CurrentStyle.Index
  else
    Result := -1;
end;

function TdxPrintStyleManager.GetRegistryPath: string;
begin
  if dxPSEngine.RealRegistryPath <> '' then
    Result := dxPSEngine.RealRegistryPath + sdxAutoHFTextEntries + '\' + Name
  else
    Result := '';
end;

procedure TdxPrintStyleManager.SetCurrentStyleIndex(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value > Count - 1 then
    Value := Count - 1;
  if Value <> CurrentStyleIndex then
    CurrentStyle := Styles[Value];
end;

procedure TdxPrintStyleManager.BuildAutoHFTextEntriesMenu(ARootItem: TComponent;
  AData: Pointer; AIncludeSetupAutoHFTextEntriesItem: Boolean = True);
var
  MenuBuilder: TAbstractdxPSAutoHFTextMenuBuilder;
begin
  MenuBuilder := dxPSAutoHFTextMenuBuilderFactory.ActiveBuilder.Create;
  try
    try
      MenuBuilder.BuildAutoHFTextEntriesMenu(ARootItem, AData, AIncludeSetupAutoHFTextEntriesItem, 
        AutoHFTextEntries, OnAutoHFTextEntryClick, OnEditAutoHFTextEntriesClick);
    except
      Application.HandleException(Self);
    end;
  finally
    MenuBuilder.Free;
  end;
end;

procedure TdxPrintStyleManager.RefreshAutoHFTextEntries;
begin
  FreeAndNil(FAutoHFTextEntries);
end;

function TdxPrintStyleManager.ShowAutoHFTextEntriesDlg: Boolean;
begin
  Result := dxShowAutoTextDlg(AutoHFTextEntries);
end;

procedure TdxPrintStyleManager.LoadFromRegistry(const APath: string);
begin
  dxLoadStringsFromRegistry(APath, AutoHFTextEntries);
end;

procedure TdxPrintStyleManager.SaveToRegistry(const APath: string); 
begin
  dxSaveStringsToRegistry(APath, AutoHFTextEntries);
end;

procedure TdxPrintStyleManager.DefinePrintStylesDlg(out APreviewBtnClicked, APrintBtnClicked: Boolean);
var
  Data: TdxDefinePrintStylesDlgData;
begin
  FillChar(Data, SizeOf(TdxDefinePrintStylesDlgData), 0);
  Data.StyleManager := Self;
  Data.Title := Title;
  dxDefinePrintStylesDlg(Data);

  APreviewBtnClicked := Data.PreviewBtnClicked;
  APrintBtnClicked := Data.PrintBtnClicked;

  DesignerUpdate(nil);  
  PostMessage(FWindowHandle, WMPS_PRINTSTYLELISTCHANGED, 0, 0);
end;

procedure TdxPrintStyleManager.DefinePrintStylesDlg(APreviewBtnClicked,
  APrintBtnClicked: PBoolean);
var
  PreviewBtnClicked, PrintBtnClicked: Boolean;
begin
  DefinePrintStylesDlg(PreviewBtnClicked, PrintBtnClicked);

  if APreviewBtnClicked <> nil then 
    APreviewBtnClicked^ := PreviewBtnClicked;
   
  if APrintBtnClicked <> nil then 
    APrintBtnClicked^ := PrintBtnClicked;
end;

{ TAbstractdxStyleManagerDesigner }

constructor TAbstractdxStyleManagerDesigner.Create(AStyleManager: TdxPrintStyleManager);
begin
  inherited Create;
  FStyleManager := AStyleManager;
  if FStyleManager <> nil then FStyleManager.FDesigner := Self;
end;

destructor TAbstractdxStyleManagerDesigner.Destroy;
begin
  if FStyleManager <> nil then FStyleManager.FDesigner := nil;
  inherited;
end;

{ Header & footer parser functions }

function dxProcessHFString(const Source: string): string;
begin
  if dxHFFunctionLibrary <> nil then
    Result := dxHFFunctionLibrary.ProcessString(Source, dxHFFormatObject)
  else
    Result := Source;
end;

procedure dxGetHFFunctionsList(AStrings: TStrings);
begin
  if dxHFFunctionLibrary <> nil then
    dxHFFunctionLibrary.GetFunctions(AStrings);
end;

procedure dxGetHFFunctionsListByCategory(ACategory: TdxHFFunctionCustomCategoryClass; AStrings: TStrings);
begin
  if dxHFFunctionLibrary <> nil then
    dxHFFunctionLibrary.GetFunctionsByCategory(ACategory, AStrings);
end;

{ TdxHFFunctionFormatObject }

constructor TdxHFFunctionFormatObject.Create;
begin
  inherited Create;
  Initialize;            
end;

procedure TdxHFFunctionFormatObject.Initialize;
begin
  FDateTime := Now;
  FCurrentPage := 1;
  FDateFormat := LongDateFormat;
  FMachineName := dxPSUtl.GetMachineName;
  FPageNumberFormat := pnfNumeral;
  FTimeFormat := LongTimeFormat;
  FTotalPages := 1;
  FUserName := dxPSUtl.GetUserName;
end;

{ TdxHFCustomFunction }

constructor TdxHFCustomFunction.Create;
begin
  inherited Create;
  FGlyph := TBitmap.Create;
end;

destructor TdxHFCustomFunction.Destroy;
begin
  FreeAndNil(FGlyph);
  inherited;
end;

procedure TdxHFCustomFunction.Assign(Source: TPersistent);
begin
  if Source is TdxHFCustomFunction then
    with TdxHFCustomFunction(Source) do 
    begin
      Self.TemplateString := TemplateString;
      Self.Hint := Hint;
      Self.Glyph := Glyph;
    end
  else
    inherited;
end;

class function TdxHFCustomFunction.FunctionClass: TdxHFCustomFunctionClass;
begin
  Result := TdxHFCustomFunctionClass(GetTypeData(ClassInfo)^.ClassType);
end;

function TdxHFCustomFunction.DoProcess(const Source: string;
  const AFormatObject: TdxHFFunctionFormatObject): string;
begin
  if AFormatObject <> nil then
    Result := ConvertFunc(Source, AFormatObject)
  else
    Result := Source;
end;

procedure TdxHFCustomFunction.SetTemplateString(const Value: string);
begin
  FTemplateString := Value;
  if Length(FTemplateString) > 0 then
  begin
    if FTemplateString[1] <> dxFunctionDelimiters[False] then
      FTemplateString := dxFunctionDelimiters[False] + FTemplateString;
    if FTemplateString[Length(FTemplateString)] <> dxFunctionDelimiters[True] then
      FTemplateString := FTemplateString + dxFunctionDelimiters[True];
  end;
end;

procedure TdxHFCustomFunction.SetGlyph(Value: Graphics.TBitmap);
begin
  Glyph.Assign(Value);
end;

class function TdxHFCustomFunction.GetName: string;
begin
  Result := cxGetResourceString(@sdxHFFunctionNameUnknown);
end;

class function TdxHFCustomFunction.GetCategory: TdxHFFunctionCustomCategoryClass;
begin
  Result := TdxHFFunctionCustomCategory;
end;

function TdxHFCustomFunction.ConvertFunc(const Source: string;
  const AFormatObject: TdxHFFunctionFormatObject): string;
begin
  Result := Source;
end;

{ TdxHFPagesFunctions }

class function TdxHFPagesFunctions.GetCategory: TdxHFFunctionCustomCategoryClass;
begin
  Result := TdxHFFunctionPagesCategory;
end;

{ TdxHFPageNumberFunction }

constructor TdxHFPageNumberFunction.Create;
begin
  inherited;
  Bitmap_LoadFromResourceName(Glyph, IDB_DXPSFUNCTION_PAGENUMBER);
  TemplateString := cxGetResourceString(@sdxHFFunctionTemplatePageNumber);
  Hint := cxGetResourceString(@sdxHFFunctionHintPageNumber);
end;

function TdxHFPageNumberFunction.ConvertFunc(const Source: string;
  const AFormatObject: TdxHFFunctionFormatObject): string;
var
  ACurrentPage: Integer;
begin
  ACurrentPage := AFormatObject.StartPageIndex + AFormatObject.CurrentPage - 1;
    
  case AFormatObject.PageNumberFormat of
    pnfNumeral:
      Result := IntToStr(ACurrentPage);
    pnfChars:
      Result := Int2Chars(ACurrentPage, False);
    pnfUpperChars:
      Result := Int2Chars(ACurrentPage, True);
    pnfRoman:
      Result := Int2Roman(ACurrentPage, False);
  else // pnfUpperRoman
    Result := Int2Roman(ACurrentPage, True);
  end
end;

class function TdxHFPageNumberFunction.GetName: string;
begin
  Result := cxGetResourceString(@sdxHFFunctionNamePageNumber);
end;

{ TdxHFTotalPagesFunction }

constructor TdxHFTotalPagesFunction.Create;
begin
  inherited;
  Bitmap_LoadFromResourceName(Glyph, IDB_DXPSFUNCTION_TOTALPAGES);
  TemplateString := cxGetResourceString(@sdxHFFunctionTemplateTotalPages);
  Hint := cxGetResourceString(@sdxHFFunctionHintTotalPages);
end;

function TdxHFTotalPagesFunction.ConvertFunc(const Source: string;
  const AFormatObject: TdxHFFunctionFormatObject): string;
var
  ATotalPages: Integer;
begin
  ATotalPages := AFormatObject.StartPageIndex + AFormatObject.TotalPages - 1;
    
  case AFormatObject.PageNumberFormat of
    pnfNumeral:
      Result := IntToStr(ATotalPages);
    pnfChars:
      Result := Int2Chars(ATotalPages, False);
    pnfUpperChars:
      Result := Int2Chars(ATotalPages, True);
    pnfRoman:
      Result := Int2Roman(ATotalPages, False);
  else // pnfUpperRoman
    Result := Int2Roman(ATotalPages, True);
  end
end;

class function TdxHFTotalPagesFunction.GetName: string;
begin
  Result := cxGetResourceString(@sdxHFFunctionNameTotalPages);
end;

{ TdxHFPageOfPagesFunction }

constructor TdxHFPageOfPagesFunction.Create;
begin
  inherited;
  Bitmap_LoadFromResourceName(Glyph, IDB_DXPSFUNCTION_PAGENUMBEROFPAGES);
  TemplateString := cxGetResourceString(@sdxHFFunctionTemplatePageOfPages);
  Hint := cxGetResourceString(@sdxHFFunctionHintPageOfPages);
end;

function TdxHFPageOfPagesFunction.ConvertFunc(const Source: string;
  const AFormatObject: TdxHFFunctionFormatObject): string;
var
  CurrentPage, TotalPages: Integer;
begin
  CurrentPage := AFormatObject.CurrentPage + AFormatObject.StartPageIndex - 1;
  TotalPages := AFormatObject.TotalPages + AFormatObject.StartPageIndex - 1;

  case AFormatObject.PageNumberFormat of
    pnfNumeral:
      Result := IntToStr(CurrentPage) + ' ' + cxGetResourceString(@sdxOf) + ' ' + IntToStr(TotalPages);
    pnfChars:
      Result := Int2Chars(CurrentPage, False) + ' ' + cxGetResourceString(@sdxOf) + ' ' + Int2Chars(TotalPages, False);
    pnfUpperChars:
      Result := Int2Chars(CurrentPage, True) + ' ' + cxGetResourceString(@sdxOf) + ' ' + Int2Chars(TotalPages, True);
    pnfRoman:
      Result := Int2Roman(CurrentPage, False) + ' ' + cxGetResourceString(@sdxOf) + ' ' + Int2Roman(TotalPages, False);
  else // pnfUpperRoman
    Result := Int2Roman(CurrentPage, True) + ' ' + cxGetResourceString(@sdxOf) + ' ' + Int2Roman(TotalPages, True);
  end
end;

class function TdxHFPageOfPagesFunction.GetName: string;
begin
  Result := cxGetResourceString(@sdxHFFunctionNamePageOfPages);
end;

{ TdxHFAuthenticationFunctions }

class function TdxHFAuthenticationFunctions.GetCategory: TdxHFFunctionCustomCategoryClass;
begin
  Result := TdxHFFunctionAuthenticationCategory;
end;

{ TdxHFMachineNameFunction }

constructor TdxHFMachineNameFunction.Create;
begin
  inherited;
  Bitmap_LoadFromResourceName(Glyph, IDB_DXPSFUNCTION_MACHINENAME);
  TemplateString := cxGetResourceString(@sdxHFFunctionTemplateMachineName);
  Hint := cxGetResourceString(@sdxHFFunctionHintMachineName);
end;

function TdxHFMachineNameFunction.ConvertFunc(const Source: string;
  const AFormatObject: TdxHFFunctionFormatObject): string;
begin
  Result := AFormatObject.MachineName
end;

class function TdxHFMachineNameFunction.GetName: string;
begin
  Result := cxGetResourceString(@sdxHFFunctionNameMachineName);
end;

{ TdxHFMachineNameFunction }

constructor TdxHFUserNameFunction.Create;
begin
  inherited;
  Bitmap_LoadFromResourceName(Glyph, IDB_DXPSFUNCTION_USERNAME);
  TemplateString := cxGetResourceString(@sdxHFFunctionTemplateUserName);
  Hint := cxGetResourceString(@sdxHFFunctionHintUserName);
end;

function TdxHFUserNameFunction.ConvertFunc(const Source: string;
  const AFormatObject: TdxHFFunctionFormatObject): string;
begin
  Result := AFormatObject.UserName
end;

class function TdxHFUserNameFunction.GetName: string;
begin
  Result := cxGetResourceString(@sdxHFFunctionNameUserName);
end;

{ TdxHFDateTimeFunctions }

class function TdxHFDateTimeFunctions.GetCategory: TdxHFFunctionCustomCategoryClass;
begin
  Result := TdxHFFunctionDateTimeCategory;
end;

{ TdxHFDateTimeFunction }

constructor TdxHFDateTimeFunction.Create;
begin
  inherited;
  Bitmap_LoadFromResourceName(Glyph, IDB_DXPSFUNCTION_DATETIME);
  TemplateString := cxGetResourceString(@sdxHFFunctionTemplateDateTime);
  Hint := cxGetResourceString(@sdxHFFunctionHintDateTime);
end;

function TdxHFDateTimeFunction.ConvertFunc(const Source: string;
  const AFormatObject: TdxHFFunctionFormatObject): string;
begin
  with AFormatObject do
    Result := GetFormatedDate(DateTime, DateFormat) + ' ' +
              GetFormatedTime(DateTime, TimeFormat);
end;

class function TdxHFDateTimeFunction.GetName: string;
begin
  Result := cxGetResourceString(@sdxHFFunctionNameDateTime);
end;

{ TdxHFDateFunction }

constructor TdxHFDateFunction.Create;
begin
  inherited;
  Bitmap_LoadFromResourceName(Glyph, IDB_DXPSFUNCTION_DATE);
  TemplateString := cxGetResourceString(@sdxHFFunctionTemplateDate);
  Hint := cxGetResourceString(@sdxHFFunctionHintDate);
end;

function TdxHFDateFunction.ConvertFunc(const Source: string;
  const AFormatObject: TdxHFFunctionFormatObject): string;
begin
  with AFormatObject do
    Result := GetFormatedDate(DateTime, DateFormat);
end;

class function TdxHFDateFunction.GetName: string;
begin
  Result := cxGetResourceString(@sdxHFFunctionNameDate);
end;

{ TdxHFDateFunction }

constructor TdxHFTimeFunction.Create;
begin
  inherited;
  Bitmap_LoadFromResourceName(Glyph, IDB_DXPSFUNCTION_TIME);
  TemplateString := cxGetResourceString(@sdxHFFunctionTemplateTime);
  Hint := cxGetResourceString(@sdxHFFunctionHintTime);
end;

function TdxHFTimeFunction.ConvertFunc(const Source: string;
  const AFormatObject: TdxHFFunctionFormatObject): string;
begin
  with AFormatObject do
    Result := GetFormatedTime(DateTime, TimeFormat);
end;

class function TdxHFTimeFunction.GetName: string;
begin
  Result := cxGetResourceString(@sdxHFFunctionNameTime);
end;

{ TdxHFFunctionLibrary }

constructor TdxHFFunctionLibrary.Create;
begin
  inherited Create;
  FItems := TStringList.Create;
end;

destructor TdxHFFunctionLibrary.Destroy;
begin
  FreeAndNilItems;
  inherited;
end;

procedure TdxHFFunctionLibrary.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TdxHFFunctionLibrary then
  begin
    Clear;
    with TdxHFFunctionLibrary(Source) do
      for I := 0 to Count - 1 do
        Self.Add(Funcs[I].FunctionClass);
  end
  else
    inherited;
end;

procedure TdxHFFunctionLibrary.GetFunctions(AStrings: TStrings);
var
  I: Integer;
  AFunction: TdxHFCustomFunction;
begin
  AStrings.BeginUpdate;
  try
    for I := 0 to Count - 1 do
    begin
      AFunction := Funcs[I];
      AStrings.AddObject(AFunction.TemplateString, AFunction);
    end;
  finally
    AStrings.EndUpdate;
  end;
end;

procedure TdxHFFunctionLibrary.GetFunctionsByCategory(ACategory: TdxHFFunctionCustomCategoryClass;
  AStrings: TStrings);
var
  I: Integer;
  AFunction: TdxHFCustomFunction;
begin
  AStrings.BeginUpdate;
  try
    for I := 0 to Count - 1 do
    begin
      AFunction := Funcs[I];
      if AFunction.GetCategory = ACategory then
        AStrings.AddObject(AFunction.TemplateString, AFunction);
    end;
  finally
    AStrings.EndUpdate;
  end;
end;

procedure TdxHFFunctionLibrary.Enumerate(AProc: TdxHFFunctionEnumProc);
var
  I: Integer;
begin
  if Assigned(AProc) then
    for I := 0 to Count - 1 do
      AProc(Self, Funcs[I]);
end;

function TdxHFFunctionLibrary.ProcessString(const Source: string;
  const AFormatObject: TdxHFFunctionFormatObject): string;
var
  I, J, Left, Right: Integer;
  S: string;
begin
  Result := Source;
  if Length(Result) = 0 then Exit;
  
  I := 1;
  while I <= Length(Result) do
  begin
    while (I <= Length(Result)) and (Result[I] <> dxFunctionDelimiters[False]) do
      Inc(I);
      
    if I < Length(Result) then
      Left := I
    else
      Left := 0;
    if Left = 0 then Break;
    
    while (I <= Length(Result)) and (Result[I] <> dxFunctionDelimiters[True]) do
      Inc(I);
      
    if I <= Length(Result) then
      Right := I
    else
      Right := 0;
    if Right = 0 then Break;
    
    if Right - Left > 1 then
    begin
      S := Copy(Result, Left {+1}, Right - Left + 1 {-1});
      J := IndexOf(S);
      if J <> -1 then
      begin
        System.Delete(Result, Left, Right - Left + 1);
        S := Funcs[J].DoProcess(S, AFormatObject);
        if S <> '' then
          Insert(' ' + S + ' ', Result, Left);
        I := Left + Length(S) + 2 {left and right spaces};
      end;
    end;
  end;
end;

function TdxHFFunctionLibrary.Add(AFunctionClass: TdxHFCustomFunctionClass): TdxHFCustomFunction;
begin
  Result := AFunctionClass.Create;
  FItems.AddObject(Result.TemplateString, Result);
end;

procedure TdxHFFunctionLibrary.Clear;
begin
  while Count > 0 do Delete(Count - 1);
end;

procedure TdxHFFunctionLibrary.Delete(AnIndex: Integer);
begin
  FItems.Objects[AnIndex].Free;
  FItems.Delete(AnIndex);
end;

function TdxHFFunctionLibrary.IndexOf(const ATemplateString: string): Integer;
begin
  Result := FItems.IndexOf(ATemplateString);
end;

function TdxHFFunctionLibrary.IndexOfByName(const AFunctionName: string): Integer;
begin
  for Result := 0 to Count - 1 do
    if dxSameText(Funcs[Result].GetName, AFunctionName) then Exit;
  Result := -1;
end;

function TdxHFFunctionLibrary.IndexOfByClass(AFunctionClass: TdxHFCustomFunctionClass): Integer;
begin
  for Result := 0 to Count - 1 do
    if Funcs[Result].FunctionClass = AFunctionClass then Exit;
//    if Assigned(AFunctionClass) and AFunctionClass.InheritsFrom(Funcs[Result].FunctionClass) then Exit;
  Result := -1;
end;

function TdxHFFunctionLibrary.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxHFFunctionLibrary.GetFunction(Index: Integer): TdxHFCustomFunction;
begin
  Result := TdxHFCustomFunction(FItems.Objects[Index]);
end;

function TdxHFFunctionLibrary.GetFunctionByClass(FunctionClass: TdxHFCustomFunctionClass): TdxHFCustomFunction;
var
  Index: Integer;
begin
  Index := IndexOfByClass(FunctionClass);
  if Index <> -1 then 
    Result := Funcs[Index]
  else
    Result := nil;
end;

procedure TdxHFFunctionLibrary.SetFunction(Index: Integer; Value: TdxHFCustomFunction);
begin
  Funcs[Index].Assign(Value);
end;

procedure TdxHFFunctionLibrary.SetFunctionByClass(FunctionClass: TdxHFCustomFunctionClass; Value: TdxHFCustomFunction);
var
  Index: Integer;
begin
  Index := IndexOfByClass(FunctionClass);
  if Index <> -1 then 
    Funcs[Index] := Value;
end;

procedure TdxHFFunctionLibrary.FreeAndNilItems;
begin
  Clear;
  FreeAndNil(FItems);
end;

{ TdxStdHFFunctionLibrary }

constructor TdxStandardHFFunctionLibrary.Create;
begin
  inherited;
  AddStandardFunctions;
end;

procedure TdxStandardHFFunctionLibrary.AddStandardFunctions;
begin
  Add(TdxHFPageNumberFunction);
  Add(TdxHFTotalPagesFunction);
  Add(TdxHFPageOfPagesFunction);
  Add(TdxHFDateTimeFunction);
  Add(TdxHFDateFunction);
  Add(TdxHFTimeFunction);
  Add(TdxHFUserNameFunction);
  Add(TdxHFMachineNameFunction);
end;

{ functions }

function DateFormats: TStrings;
begin
  if FDateFormats = nil then
  begin
    FDateFormats := TStringList.Create;
    if Assigned(dxGetDateFormatsProc) then dxGetDateFormatsProc(FDateFormats);
  end;
  Result := FDateFormats;
end;

function TimeFormats: TStrings;
begin
  if FTimeFormats = nil then
  begin
    FTimeFormats := TStringList.Create;
    if Assigned(dxGetTimeFormatsProc) then dxGetTimeFormatsProc(FTimeFormats);
  end;
  Result := FTimeFormats;
end;

procedure RefreshDateFormats;
begin
  FreeAndNil(FDateFormats);
end;

procedure RefreshTimeFormats;
begin
  FreeAndNil(FTimeFormats);
end;

procedure DeleteLeadingGarbage(var Source: string);
begin
  while (Length(Source) > 0) and ((Source[1] = '.') or (Source[1] = ',') or (Source[1] = ' ')) do
    Delete(Source, 1, 1);
end;

function ExtractLongMonthFormat(AnExcludeDelimiters: Boolean): string;
const
  ValidChars: array[Boolean] of string = (' M:\.,/', ' M:\');
var
  I: Integer;
  Ch: char;
begin
  Result := '';
  for I := 1 to Length(LongDateFormat) do
  begin
    Ch := LongDateFormat[I];
    if Pos(Ch, ValidChars[AnExcludeDelimiters]) <> 0 then
      Result := Result + Ch;
  end;
  Result := Trim(Result);
  DeleteLeadingGarbage(Result);
end;

function ReducedLongDayFormat: string;
var
  P: Integer;
begin
  Result := LongDateFormat;
  repeat
    P := Pos('dddd', Result);
    if P <> 0 then Delete(Result, P, 4);
  until P = 0;
  
  Result := Trim(Result);
  DeleteLeadingGarbage(Result);
end;

procedure dxGetDateFormats(AStrings: TStrings);
var
  S: string;
  P: Integer;
begin
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
{1} AStrings.Add(ShortDateFormat);

    S := Trim(LongDateFormat);
    if Pos('dddd', S) = 0 then S := 'dddd, ' + S;
{2} AStrings.Add(S);

{3} AStrings.Add(ReducedLongDayFormat);

    S := ShortDateFormat;
    P := Pos('yyyy', S);
    if P <> 0 then
      Delete(S, P, 2)
    else
    begin
      P := Pos('yy', S);
      if P <> 0 then Insert('yy', S, P);
    end;
{4} AStrings.Add(S);

{5} AStrings.Add('yyyy-MM-dd');
{6} AStrings.Add('d-MMM-yy');

    S := ShortDateFormat;
    if DateSeparator <> '/' then
      S := ReplaceSubStr(S, DateSeparator, '/')
    else
      S := ReplaceSubStr(S, DateSeparator, '.');
{7} AStrings.Add(S);

{8} AStrings.Add(ExtractLongMonthFormat(False) + ' yyyy');
{9} AStrings.Add('d MMMM yyyy');
{10}AStrings.Add(ExtractLongMonthFormat(True) + ' yy');
{11}AStrings.Add('MMM-yy');
  finally
    AStrings.EndUpdate;
  end;  
end;

{$IFDEF DELPHI6}
    {$WARN SYMBOL_PLATFORM OFF}	
{$ENDIF}

procedure dxGetTimeFormats(AStrings: TStrings);
const
  HourFormats: array[Boolean] of string = ('hh', 'h');
var
  HourFormat: string;
begin
  HourFormat := HourFormats[StrToIntDef(GetLocaleChar(GetThreadLocale, LOCALE_ITLZERO, '0'), 0) = 0];
  with AStrings do
  begin
    BeginUpdate;
    try
      Clear;
      Add(HourFormat + ':mm tt');
      Add(HourFormat + ':mm:ss tt');
      Add(UpperCase(HourFormat) + ':mm');
      Add(UpperCase(HourFormat) + ':mm:ss');
    finally
      EndUpdate;
    end;
  end;
end;

{$IFDEF DELPHI6}
    {$WARN SYMBOL_PLATFORM ON}	
{$ENDIF}

function PageNumberFormats: TStrings;
begin
  if FPageNumberFormats = nil then
  begin
    FPageNumberFormats := TStringList.Create;
    FPageNumberFormats.AddObject('1, 2, 3, 4, 5, ...', TObject(Integer(pnfNumeral)));
    FPageNumberFormats.AddObject('a, b, c, d, e, ...', TObject(Integer(pnfChars)));
    FPageNumberFormats.AddObject('A, B, C, D, E, ...', TObject(Integer(pnfUpperChars)));
    FPageNumberFormats.AddObject('i, ii, iii, iv, v, ...', TObject(Integer(pnfRoman)));
    FPageNumberFormats.AddObject('I, II, III, IV, V, ...', TObject(Integer(pnfUpperRoman)));
  end;
  Result := FPageNumberFormats;
end;

function System_GetFormatedDate(const ASystemTime: TSystemTime; const AFormat: string): string;
var
  DefaultLCID: LCID;
  BufferSize: Integer;
  Buffer: array[0..255] of Char;
begin
  if AFormat <> '' then
  begin
    DefaultLCID := GetThreadLocale;
    FillChar(Buffer, SizeOf(Buffer), 0);
    BufferSize := GetDateFormat(DefaultLCID, 0, @ASystemTime, PChar(AFormat), @Buffer, Length(Buffer));
    if BufferSize = 0 then
      Result := ''
    else
      Result := Buffer;
 end
 else
   Result := '';
end;

function System_GetFormatedTime(const ASystemTime: TSystemTime; const AFormat: string): string;
var
  DefaultLCID: LCID;
  BufferSize: Integer;
  Buffer: array[0..255] of Char;
begin
  if AFormat <> '' then
  begin
    DefaultLCID := GetThreadLocale;
    FillChar(Buffer, SizeOf(Buffer), 0);
    BufferSize := GetTimeFormat(DefaultLCID, 0, @ASystemTime, PChar(AFormat), @Buffer, Length(Buffer));
    if BufferSize = 0 then
      Result := ''
    else
      Result := Buffer;
    Result := Buffer;
 end
 else
   Result := '';
end;

function GetFormatedDate(const ADateTime: TDateTime; const AFormat: string): string;
var
  SystemTime: TSystemTime;
begin
  DateTimeToSystemTime(ADateTime, SystemTime);
  Result := System_GetFormatedDate(SystemTime, AFormat);
end;

function GetFormatedTime(const ADateTime: TDateTime; const AFormat: string): string;
var
  SystemTime: TSystemTime;
begin
  DateTimeToSystemTime(ADateTime, SystemTime);
  Result := System_GetFormatedTime(SystemTime, AFormat);
end;

procedure GetFormatedDateStrings(const ADateTime: TDateTime; 
  ADateFormats, AFormatedStrings: TStrings);
var
  I: Integer;
begin
  with AFormatedStrings do
  begin
    BeginUpdate;
    try
      for I := 0 to ADateFormats.Count - 1 do
        Add(GetFormatedDate(ADateTime, ADateFormats[I]));
    finally
      EndUpdate;
    end;
  end;
end;

procedure GetFormatedTimeStrings(const ADateTime: TDateTime; 
  ATimeFormats, AFormatedStrings: TStrings);
var
  I: Integer;
begin
  with AFormatedStrings do
  begin
    BeginUpdate;
    try
      for I := 0 to ATimeFormats.Count - 1 do
        Add(GetFormatedTime(ADateTime, ATimeFormats[I]));
    finally
      EndUpdate;
    end;
  end;
end;

function DefaultAutoHFTextEntries: TStrings;
begin
  if FDefaultAutoHFTextEntries = nil then
  begin
    FDefaultAutoHFTextEntries := TStringList.Create;
    TStringList(FDefaultAutoHFTextEntries).Duplicates := dupIgnore;    
    if Assigned(dxGetAutoHFTextEntriesProc) then
      dxGetAutoHFTextEntriesProc(FDefaultAutoHFTextEntries);
  end;
  Result := FDefaultAutoHFTextEntries;
end;

procedure dxGetAutoHFTextEntries(AStrings: TStrings);
var
  F: TdxHFCustomFunction;
  S: string;
begin
  with AStrings do 
  begin
    //, -Page #-, 
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFPageNumberFunction];
    if F <> nil then 
      Add(dxHFFunctionSeparator + ' ' + '-' + F.TemplateString + '-' + ' ' + dxHFFunctionSeparator);

    // Author, Page #, Date
    S := '';
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFUserNameFunction];
    if F <> nil then 
      S := F.TemplateString;
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFPageNumberFunction];
    if F <> nil then 
      S := S + dxHFFunctionSeparator + ' ' + DropAmpersand(cxGetResourceString(@sdxPage)) + ' ' + F.TemplateString;
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFDateFunction];
    if F <> nil then 
      S := S + dxHFFunctionSeparator + ' ' + F.TemplateString;
    Add(S);

    // Confidential, Page #, Date
    S := cxGetResourceString(@sdxConfidential);
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFPageNumberFunction];
    if F <> nil then 
      S := S + dxHFFunctionSeparator + ' ' + DropAmpersand(cxGetResourceString(@sdxPage)) + ' ' + F.TemplateString;
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFDateFunction];
    if F <> nil then 
      S := S + dxHFFunctionSeparator + ' ' + F.TemplateString;
    Add(S);

    // Created By
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFUserNameFunction];
    if F <> nil then 
      Add(cxGetResourceString(@sdxCreatedBy) + F.TemplateString);  

    // Created On
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFDateTimeFunction];
    if F <> nil then
      Add(cxGetResourceString(@sdxCreatedOn) + F.TemplateString);  

    // Printed By
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFUserNameFunction];
    if F <> nil then 
      Add(cxGetResourceString(@sdxPrintedBy) + F.TemplateString);  

    // Printed On
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFDateTimeFunction];
    if F <> nil then
      Add(cxGetResourceString(@sdxPrintedOn) + F.TemplateString);  

    // Last Printed
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFDateTimeFunction];
    if F <> nil then
      Add(cxGetResourceString(@sdxLastPrinted) + F.TemplateString);  
      
    // Page #
    F := dxHFFunctionLibrary.FuncsByClass[TdxHFPageOfPagesFunction];
    if F <> nil then
      Add(DropAmpersand(cxGetResourceString(@sdxPage)) + ' ' + F.TemplateString);
  end;
end;

var
  FHFFunctionLibrary: TdxHFFunctionLibrary;
  FHFFormatObject: TdxHFFunctionFormatObject;

initialization
  dxGetDateFormatsProc := dxGetDateFormats;
  dxGetTimeFormatsProc := dxGetTimeFormats;
  dxGetAutoHFTextEntriesProc := dxGetAutoHFTextEntries;

  FHFFunctionLibrary := TdxStandardHFFunctionLibrary.Create;
  dxHFFunctionLibrary := FHFFunctionLibrary;

  FHFFormatObject := TdxHFFunctionFormatObject.Create;
  dxHFFormatObject := FHFFormatObject;

  dxPSRegisterPrintStyle(TBasedxPrintStyle, False);
  if dxDefaultPrintStyleClass = nil then dxDefaultPrintStyleClass := TBasedxPrintStyle;

finalization
  dxPSUnregisterAllPrintStyles;

  if dxHFFormatObject = FHFFormatObject then dxHFFormatObject := nil;
  if dxHFFunctionLibrary = FHFFunctionLibrary then dxHFFunctionLibrary := nil;

  FreeAndNil(FDefaultAutoHFTextEntries);
  FreeAndNil(FHFFormatObject);
  FreeAndNil(FHFFunctionLibrary);
  FreeAndNil(FDateFormats);
  FreeAndNil(FPageNumberFormats);
  FreeAndNil(FTimeFormats);

end.
