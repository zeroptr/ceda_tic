{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express OrgChart                                            }
{                                                                   }
{       Copyright (c) 1998-2009 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSORGCHART AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE end USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxorgchr;
{$I cxVer.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ImgList;

const
  OtScrollUnit = 16;

type
  TdxOcNodeAlign = (caLeft, caCenter, caRight);
  TdxOcImageAlign = (iaNone, iaLT, iaLC, iaLB, iaRT, iaRC, iaRB, iaTL, iaTC, iaTR, iaBL, iaBC, iaBR);
  TdxOcIvFlags = (ivWidth, ivHeight, ivBoth);
  TdxOcShape = (shRectangle, shRoundRect, shEllipse, shDiamond);
  TdxOcNodeAttachMode = (naAdd, naAddFirst, naAddChild, naAddChildFirst, naInsert);
  TdxCustomOrgChart = class;
  TdxOcNodeInfo = packed record
    Width: Word;
    Height: Word;
    Color: TColor;
    Align: TdxOcNodeAlign;
    Shape: TdxOcShape;
    Index: Smallint;
    IAlign: TdxOcImageAlign;
  end;

  TdxOcInplaceEdit = class(TCustomEdit)
  private
    FMinW: Integer;
    FMaxW: Integer;
    FMinH: Integer;
    FMaxH: Integer;
    procedure AdjustBounds;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor Create(AOwner: TComponent); override;
    function Tree: TdxCustomOrgChart;
    property MaxLength;
    property OEMConvert;
  end;

  TdxOcNodeData = Pointer;

  TdxOcNode = class(TObject)
  private
    FOwner: TdxCustomOrgChart;
    FParent: TdxOcNode;
    FList: TList;
    FIndex: Integer;
    FData: TdxOcNodeData;
    FWidth: Word;
    FHeight: Word;
    FChildrenWidth: Integer;
    FChildrenHeight: Integer;
    FExpanded: Boolean;
    FDeleting: Boolean;
    FChildAlign: TdxOcNodeAlign;
    FShape: TdxOcShape;
    FColor: TColor;
    FText: string;
    FAnimX: Integer;
    FAnimY: Integer;
    FAnimX0: Integer;
    FAnimY0: Integer;
    FImageIndex: Smallint;
    FImageAlign: TdxOcImageAlign;
    FDraw: Boolean;
    procedure InvalidateSize(Flags: TdxOcIvFlags);
    procedure Enumerate(Value: Integer);
    procedure AdjustSizes(const S: string);
    function FullRect: TRect;
    function Radius: Integer;
    function Is3D: Boolean;
    procedure FullToDisplay(var Rect: TRect);
    procedure DisplayToClient(var Rect: TRect);
    function ClientToText(var Rect: TRect): TPoint;
    function GetAbsoluteCount: Integer;
    function GetAbsoluteItem(Index: Integer): TdxOcNode;
    function GetCount: Integer;
    function GetChildren: Boolean;
    function GetVisible: Boolean;
    function GetItem(Index: Integer): TdxOcNode;
    function GetLevel: Integer;
    function GetParent: TdxOcNode;
    function GetSelected: Boolean;
    function GetWidth: Word;
    function GetHeight: Word;
    function GetColor: TColor;
    procedure SetExpanded(Value: Boolean);
    procedure SetChildren(Value: Boolean);
    procedure SetAlign(Value: TdxOcNodeAlign);
    procedure SetWidth(Value: Word);
    procedure SetHeight(Value: Word);
    procedure SetSelected(Value: Boolean);
    procedure SetColor(Value: TColor);
    procedure SetShape(Value: TdxOcShape);
    procedure SetImageIndex(Value: Smallint);
    procedure SetImageAlign(Value: TdxOcImageAlign);
    procedure InternalSetText(const Value: string);
    procedure SetAnimXY(LeftX, TopY: Integer; const Clip: TRect; First: Boolean);
    function ExtWidth: Word;
    function ExtHeight: Word;
    function ChildOffset: Integer;
    procedure ReadChildren(Stream: TStream);
    procedure WriteChildren(Stream: TStream);
  protected
    procedure SetData(Value: TdxOcNodeData); virtual;
    procedure SetFont(Font: TFont); virtual;
    procedure ReadData(Stream: TStream); virtual;
    procedure WriteData(Stream: TStream); virtual;
    function GetText: string; virtual;
    procedure SetText(const Value: string); virtual;
  public
    constructor Create(AOwner: TdxCustomOrgChart);
    destructor Destroy; override;
    procedure DeleteChildren;
    procedure Collapse(Recurse: Boolean);
    procedure Expand(Recurse: Boolean);
    function GetFirstChild: TdxOcNode;
    function GetLastChild: TdxOcNode;
    function GetNextChild(Value: TdxOcNode): TdxOcNode;
    function GetPrevChild(Value: TdxOcNode): TdxOcNode;
    function GetNext: TdxOcNode;
    function GetPrev: TdxOcNode;
    function GetNextSibling: TdxOcNode;
    function GetPrevSibling: TdxOcNode;
    function GetNextVisible: TdxOcNode;
    function GetPrevVisible: TdxOcNode;
    function HasAsParent(Value: TdxOcNode): Boolean;
    function IndexOf(Value: TdxOcNode): Integer;
    function Focused: Boolean;
    function FullWidth: Integer;
    function FullHeight: Integer;
    function ChildrenWidth: Integer;
    function ChildrenHeight: Integer;
    procedure MakeVisible;
    procedure MoveTo(Dest: TdxOcNode; Mode: TdxOcNodeAttachMode);
    function DisplayRect: TRect;
    function ClientRect: TRect;
    function IsParentRoot: Boolean;
    procedure GetNodeInfo(var AInfo: TdxOcNodeInfo);
    property AbsoluteCount: Integer read GetAbsoluteCount;
    property AbsoluteItems[Index: Integer]: TdxOcNode read GetAbsoluteItem;
    property Count: Integer read GetCount;
    property Data: TdxOcNodeData read FData write SetData;
    property Expanded: Boolean read FExpanded write SetExpanded;
    property HasChildren: Boolean read GetChildren write SetChildren;
    property Index: Integer read FIndex;
    property IsVisible: Boolean read GetVisible;
    property Items[Index: Integer]: TdxOcNode read GetItem; default;
    property Level: Integer read GetLevel;
    property Owner: TdxCustomOrgChart read FOwner;
    property Parent: TdxOcNode read GetParent;
    property Selected: Boolean read GetSelected write SetSelected;
    property ChildAlign: TdxOcNodeAlign read FChildAlign write SetAlign;
    property Width: Word read GetWidth write SetWidth;
    property Height: Word read GetHeight write SetHeight;
    property Deleting: Boolean read FDeleting;
    property Color: TColor read GetColor write SetColor;
    property Shape: TdxOcShape read FShape write SetShape;
    property Text: string read GetText write InternalSetText;
    property ImageIndex: Smallint read FImageIndex write SetImageIndex;
    property ImageAlign: TdxOcImageAlign read FImageAlign write SetImageAlign;
  end;

  TdxOcEvent = procedure(Sender: TObject; Node: TdxOcNode) of object;
  TdxOcAllowEvent = procedure(Sender: TObject; Node: TdxOcNode; var Allow: Boolean) of object;
  TdxOcFontEvent = procedure(Sender: TObject; Node: TdxOcNode; Font: TFont) of object;
  TdxOcDrawEvent = procedure(Sender: TObject; Node: TdxOcNode; ACanvas: TCanvas; Rect: TRect) of object;
  TdxOcGetTextEvent = procedure(Sender: TObject; Node: TdxOcNode; var Text: string) of object;
  TdxOcSetTextEvent = procedure(Sender: TObject; Node: TdxOcNode; const Text: string) of object;
  TdxOcNodeFunc = function(Value: TdxOcNode): TdxOcNode;
  TdxOcEditMode = set of (emLeft, emCenter, emRight, emVCenter,
    emWrap, emUpper, emLower, emGrow);
  TdxOcOptions = set of (ocSelect, ocFocus, ocButtons, ocDblClick, ocEdit,
    ocCanDrag, ocShowDrag, ocInsDel, ocRect3D, ocAnimate);
  TdxOcHitTest = (htNowhere, htOnLeftIndentX, htOnRightIndentX, htOnIndentY,
    htUnder, htOnRect, htOnShape, htOnButton);
  TdxOcHitTests = set of TdxOcHitTest;
  TdxOcNavigate = (ocnLineLeft, ocnLineUp, ocnLineRight, ocnLineDown,
    ocnPageLeft, ocnPageUp, ocnPageRight, ocnPageDown,
    ocnLeft, ocnTop, ocnRight, ocnBottom,
    ocnLeftPosition, ocnTopPosition,
    ocnSelectNextLeft, ocnSelectNextUp, ocnSelectNextRight, ocnSelectNextDown);

  TdxCustomOrgChart = class(TCustomControl)
  private
    FRoot: TdxOcNode;
    FCount: Integer;
    FUpdate: Integer;
    FLeftEdge: Integer;
    FTopEdge: Integer;
    FDefaultNodeWidth: Word;
    FDefaultNodeHeight: Word;
    FIndentX: Word;
    FIndentY: Word;
    FIsUnicode: Boolean;
    FSelected: TdxOcNode;
    FNodeAt: TdxOcNode;
    FCollapsed: TdxOcNode;
    FHitX: Integer;
    FHitY: Integer;
    FZoom: Integer;
    FZoomLo: Integer;
    FZoomHi: Integer;
    FEditor: TdxOcInplaceEdit;
    FEditMode: TdxOcEditMode;
    FHitTests: TdxOcHitTests;
    FLineWidth: Word;
    FLineColor: TColor;
    FSelectedNodeColor: TColor;
    FSelectedNodeTextColor: TColor;
    FDragParent: TdxOcNode;
    FDragX0: Integer;
    FDragY0: Integer;
    FDragX1: Integer;
    FDragY1: Integer;
    FScrollX: Smallint;
    FScrollY: Smallint;
    FTimer: TTimer;
    FImages: TCustomImageList;
    FBitmap: TBitmap;
    FDefaultImageAlign: TdxOcImageAlign;
    FSizeChanged: Boolean;
    FUpdated: Boolean;
    FOptions: TdxOcOptions;
    FOnCreateNode: TdxOcEvent;
    FOnChange: TdxOcEvent;
    FOnChanging: TdxOcAllowEvent;
    FOnCollapsed: TdxOcEvent;
    FOnCollapsing: TdxOcAllowEvent;
    FOnDeletion: TdxOcEvent;
    FOnExpanded: TdxOcEvent;
    FOnExpansion: TdxOcAllowEvent;
    FOnEditing: TdxOcAllowEvent;
    FOnEdited: TdxOcGetTextEvent;
    FOnSetFont: TdxOcFontEvent;
    FOnDrawNode: TdxOcDrawEvent;
    FOnGetText: TdxOcGetTextEvent;
    FOnSetText: TdxOcSetTextEvent;
    FBorderStyle: TBorderStyle;
    FRotated: Boolean;
    FNoScroll: Boolean;
    FDrag: Boolean;
    FNoAnim: Boolean;
    FImagesChangeLink: TChangeLink;
    procedure ImageListChange(Sender: TObject);
    function GetAbsoluteItem(Index: Integer): TdxOcNode;
    function GetItem(Index: Integer): TdxOcNode;
    function GetRootCount: Integer;
    function GetLineWidth: Word;
    function GetIndentX: Word;
    function GetIndentY: Word;
    function GetLeftEdge: Integer;
    function GetTopEdge: Integer;
    function GetZoom: Boolean;
    function GetEditing: Boolean;
    procedure InvalidateSizes(Flags: TdxOcIvFlags);
    function InvalidateNode(Value: TdxOcNode): Boolean;
    function InvalidateSel: Boolean;
    function IsUpdated: Boolean;
    function IsMyNode(Value: TdxOcNode): Boolean;
    function HasButton(Node: TdxOcNode): Boolean;
    function CanSelect(Node: TdxOcNode): Boolean;
    function NextSel(Get: TdxOcNodeFunc): TdxOcNode;
    function MinSizes: TPoint;
    procedure DoAdd(AParent, ANode: TdxOcNode; AIndex: Integer);
    procedure HitTestsAt(X, Y: Integer);
    procedure ChangeSize;
    procedure RecalcSizes;
    procedure UpdateScrollRange;
    procedure SetTimeScroll;
    procedure KillTimeScroll;
    procedure TimeScroll;
    procedure DoTimerScrolling(Sender: TObject);
    function InitAnimate(Node: TdxOcNode): Boolean;
    function DragScroll(X, Y: Integer; St: TDragState): Boolean;
    procedure DragDraw(Source: TdxCustomOrgChart);
    procedure DoDrawText(Handle: HDC; Text: string; var Rect: TRect; Flags: Integer);
    procedure DoDrawImage(ACanvas: TCanvas; FullRect, R: TRect; ABitmap: TBitmap);
    procedure SetLeftEdge(Value: Integer);
    procedure SetTopEdge(Value: Integer);
    procedure SetLineColor(Value: TColor);
    procedure SetLineWidth(Value: Word);
    procedure SetSelectedNodeColor(Value: TColor);
    procedure SetSelectedNodeTextColor(Value: TColor);
    procedure SetNodeWidth(Value: Word);
    procedure SetNodeHeight(Value: Word);
    procedure SetIndentX(Value: Word);
    procedure SetIndentY(Value: Word);
    procedure SetSelected(Value: TdxOcNode);
    procedure SetZoom(Value: Boolean);
    procedure SetZoomRatio;
    procedure SetEditing(Value: Boolean);
    procedure SetEditMode(Value: TdxOcEditMode);
    procedure SetImages(Value: TCustomImageList);
    procedure SetRotated(Value: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetOptions(Value: TdxOcOptions);
    function RotateRect(const Rect: TRect): TRect;
    procedure RotatePoint(var X, Y: Integer);
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMDblClk(var Msg: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure WMErase(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMCtl3DChanged(var Msg: TMessage); message CM_CTL3DCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateHandle; override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure DragCanceled; override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DblClick; override;
    procedure Loaded; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function CreateNode: TdxOcNode; virtual;
    function CreateEditor: TdxOcInplaceEdit; virtual;
    procedure DrawNode(Node: TdxOcNode; ACanvas: TCanvas; Rect: TRect); virtual;
    procedure DoChange(Node: TdxOcNode); virtual;
    procedure DoChanging(Node: TdxOcNode; var Allow: Boolean); virtual;
    procedure DoNavigate(ANavigateCode: TdxOcNavigate; AValue: Integer = 0);
    function InternalAdd(ParentNode: TdxOcNode; Data: TdxOcNodeData; Idx: Integer): TdxOcNode; virtual;
    procedure InternalMoveTo(ParentNode, Node: TdxOcNode; Idx: Integer); virtual;
    procedure NodeChanged(Node: TdxOcNode); virtual;
    procedure SelectNode(ANode: TdxOcNode);

    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property DefaultImageAlign: TdxOcImageAlign read FDefaultImageAlign write FDefaultImageAlign default iaNone;
    property DefaultNodeHeight: Word read FDefaultNodeHeight write SetNodeHeight default 40;
    property DefaultNodeWidth: Word read FDefaultNodeWidth write SetNodeWidth default 64;
    property EditMode: TdxOcEditMode read FEditMode write SetEditMode default [emWrap];
    property Images: TCustomImageList read FImages write SetImages;
    property IndentX: Word read GetIndentX write SetIndentX default 16;
    property IndentY: Word read GetIndentY write SetIndentY default 16;
    property IsUnicode: Boolean read FIsUnicode write FIsUnicode;
    property LineColor: TColor read FLineColor write SetLineColor default clBlack;
    property LineWidth: Word read GetLineWidth write SetLineWidth default 1;
    property Options: TdxOcOptions read FOptions write SetOptions;
    property Rotated: Boolean read FRotated write SetRotated default False;
    property SelectedNodeColor: TColor read FSelectedNodeColor write SetSelectedNodeColor default clHighlight;
    property SelectedNodeTextColor: TColor read FSelectedNodeTextColor write SetSelectedNodeTextColor default clHighlightText;
    property OnCreateNode: TdxOcEvent read FOnCreateNode write FOnCreateNode;
    property OnChange: TdxOcEvent read FOnChange write FOnChange;
    property OnChanging: TdxOcAllowEvent read FOnChanging write FOnChanging;
    property OnCollapsed: TdxOcEvent read FOnCollapsed write FOnCollapsed;
    property OnCollapsing: TdxOcAllowEvent read FOnCollapsing write FOnCollapsing;
    property OnDeletion: TdxOcEvent read FOnDeletion write FOnDeletion;
    property OnExpanded: TdxOcEvent read FOnExpanded write FOnExpanded;
    property OnExpansion: TdxOcAllowEvent read FOnExpansion write FOnExpansion;
    property OnEditing: TdxOcAllowEvent read FOnEditing write FOnEditing;
    property OnEdited: TdxOcGetTextEvent read FOnEdited write FOnEdited;
    property OnSetFont: TdxOcFontEvent read FOnSetFont write FOnSetFont;
    property OnDrawNode: TdxOcDrawEvent read FOnDrawNode write FOnDrawNode;
    property OnGetText: TdxOcGetTextEvent read FOnGetText write FOnGetText;
    property OnSetText: TdxOcSetTextEvent read FOnSetText write FOnSetText;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;
    function Add(Node: TdxOcNode; Data: TdxOcNodeData): TdxOcNode;
    function AddChild(Node: TdxOcNode; Data: TdxOcNodeData): TdxOcNode;
    function AddFirst(Node: TdxOcNode; Data: TdxOcNodeData): TdxOcNode;
    function AddChildFirst(Node: TdxOcNode; Data: TdxOcNodeData): TdxOcNode;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Clear;
    procedure Delete(Node: TdxOcNode); virtual;
    function GetFirstNode: TdxOcNode;
    function Insert(Node: TdxOcNode; Data: TdxOcNodeData): TdxOcNode;
    procedure FullExpand;
    procedure FullCollapse;
    function FullWidth: Integer;
    function FullHeight: Integer;
    function IsZoomed: Boolean;
    function GetNodeAt(X, Y: Integer): TdxOcNode;
    function GetHitTestsAt(X, Y: Integer): TdxOcHitTests;
    function DoZoom(Value: Integer): Integer;
    procedure SetLeftTop(ALeft, ATop: Integer);
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure DefaultDrawNode(Node: TdxOcNode; ACanvas: TCanvas; Rect: TRect);
    procedure AssignData(Source: TdxCustomOrgChart);
    procedure ShowEditor; virtual;
    procedure HideEditor(Save: Boolean);

    procedure SaveToFile(const AFileName: string);
    procedure SaveToStream(AStream: TStream);

    property AbsoluteItems[Index: Integer]: TdxOcNode read GetAbsoluteItem; 
    property Count: Integer read FCount;
    property DragParent: TdxOcNode read FDragParent;
    property RootCount: Integer read GetRootCount;
    property Items[Index: Integer]: TdxOcNode read GetItem; default;
    property LeftEdge: Integer read GetLeftEdge write SetLeftEdge;
    property TopEdge: Integer read GetTopEdge write SetTopEdge;
    property Selected: TdxOcNode read FSelected write SetSelected;
    property Zoom: Boolean read GetZoom write SetZoom default False;
    property Editing: Boolean read GetEditing write SetEditing;
    property RootNode: TdxocNode read FRoot;
  end;

  TdxOrgChart = class(TdxCustomOrgChart)
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure LoadFromFile(const AFileName: string);
    procedure LoadFromStream(AStream: TStream);
  published
    property LineColor;
    property LineWidth;
    property SelectedNodeColor;
    property SelectedNodeTextColor;
    property DefaultNodeWidth;
    property DefaultNodeHeight;
    property IndentX;
    property IndentY;
    property EditMode;
    property Images;
    property DefaultImageAlign;
    property BorderStyle;
    property Rotated;
    property Zoom;
    property Options;
    property OnCreateNode;
    property OnChange;
    property OnChanging;
    property OnCollapsed;
    property OnCollapsing;
    property OnDeletion;
    property OnExpanded;
    property OnExpansion;
    property OnEditing;
    property OnEdited;
    property OnSetFont;
    property OnDrawNode;
    property OnGetText;
    property OnSetText;
    property Align;
    property Ctl3D;
    property Color;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ParentCtl3D;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property PopupMenu;
    property ParentFont default False;
    property ParentShowHint;
    property ShowHint;
  end;

implementation

uses
  Math;

const
  StreamDescriptionANSI: AnsiString = 'VER1.0A';
  StreamDescriptionUNICODE: AnsiString = 'VER1.0U';

function ReadStr(Stream: TStream; AIsUnicode: Boolean): string;
var
  L: Word;
  SA: AnsiString;
  SW: WideString;
begin
  Stream.ReadBuffer(L, SizeOf(Word));
  if AIsUnicode then
  begin
    SetLength(SW, L);
    if L > 0 then Stream.ReadBuffer(SW[1], L * 2);
    Result := SW;
  end
  else
  begin
    SetLength(SA, L);
    if L > 0 then Stream.ReadBuffer(SA[1], L);
  {$IFDEF DELPHI12}
    Result := UTF8ToWideString(SA);
  {$ELSE}
    Result := SA;
  {$ENDIF}
  end;
end;


procedure WriteStr(Stream: TStream; const S: string);
var
  L: Integer;
{$IFDEF STREAMANSIFORMAT}
  SA: AnsiString;
{$ENDIF}
begin
  L := Length(S);
  if L > $FFFF then L := $FFFF;
  Stream.WriteBuffer(L, SizeOf(Word));
  if L > 0 then
  begin
  {$IFDEF STREAMANSIFORMAT}
    {$IFDEF DELPHI12}
      SA := UTF8Encode(S);
    {$ELSE}
      SA := S;
    {$ENDIF}
    Stream.WriteBuffer(SA[1], L);
  {$ELSE}
    Stream.WriteBuffer(S[1], L * SizeOf(Char));
  {$ENDIF}
  end;
end;

function GetNV(Value: TdxOcNode): TdxOcNode;
begin
  Result := Value.GetNextVisible;
end;

function GetPV(Value: TdxOcNode): TdxOcNode;
begin
  Result := Value.GetPrevVisible;
end;

function GetNS(Value: TdxOcNode): TdxOcNode;
begin
  Result := Value.GetNextSibling;
end;

function GetPS(Value: TdxOcNode): TdxOcNode;
begin
  Result := Value.GetPrevSibling;
end;              

{ TdxOcInplaceEdit }

constructor TdxOcInplaceEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Hide;
  TabStop := False;
  AutoSize := False;
  ParentCtl3D := False;
  Ctl3D := False;
  Parent := TWinControl(AOwner);
end;

procedure TdxOcInplaceEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or ES_MULTILINE;
    if emLeft in Tree.EditMode then Style := Style or ES_LEFT;
    if emCenter in Tree.EditMode then Style := Style or ES_CENTER;
    if emRight in Tree.EditMode then Style := Style or ES_RIGHT;
    if emWrap in Tree.EditMode then Style := Style and not ES_AUTOHSCROLL;
    if emUpper in Tree.EditMode then Style := Style or ES_UPPERCASE;
    if emLower in Tree.EditMode then Style := Style or ES_LOWERCASE;
  end;
end;

function TdxOcInplaceEdit.Tree: TdxCustomOrgChart;
begin
  Result := TdxCustomOrgChart(Parent);
end;

procedure TdxOcInplaceEdit.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  Msg.Result := Msg.Result or DLGC_WANTTAB or DLGC_WANTALLKEYS;
end;

procedure TdxOcInplaceEdit.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  Tree.HideEditor(True);
end;

procedure TdxOcInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  Tree.KeyUp(Key, Shift);
end;

procedure TdxOcInplaceEdit.KeyPress(var Key: Char);
begin
  Tree.KeyPress(Key);
  if Key <> #0 then
  begin
    inherited KeyPress(Key);
    AdjustBounds;
  end;
end;

procedure TdxOcInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
  procedure EndEdit;
  begin
    if Key = VK_ESCAPE then Modified := False;
    Key := 0;
    Tree.HideEditor(True);
  end;
begin
  if Shift = [ssAlt] then
    case Key of
      VK_RETURN: EndEdit;
      VK_UP, VK_DOWN, VK_RIGHT, VK_LEFT:
        begin
          Tree.KeyDown(Key, []);
          Key := 0;
        end;
    end;
  if Shift = [] then
    case Key of
      VK_F2, VK_ESCAPE: EndEdit;
    end;
  if Key <> 0 then inherited KeyDown(Key, Shift);
end;

procedure TdxOcInplaceEdit.AdjustBounds;
var
  R: TRect;
  W, H: Integer;
begin
  R := ClientRect;
  Tree.DoDrawText(Tree.Canvas.Handle, Text + 'WW' + #13 + #10 + #13 + #10 + 'WW', R, DT_CALCRECT);
  W := R.Right - R.Left; H := R.Bottom - R.Top;
  if W < FMinW then W := FMinW;
  if W > FMaxW then W := FMaxW;
  if H < FMinH then H := FMinH;
  if H > FMaxH then H := FMaxH;
  W := W - ClientWidth; H := H - ClientHeight;
  if emWrap in Tree.EditMode then W := 0;
  if (W or H) <> 0 then
  begin
    R := BoundsRect;
    Inc(R.Right, W); Inc(R.Bottom, H);
    W := W div 2; H := H div 2;
    Dec(R.Left, W); Dec(R.Top, H);
    Dec(R.Right, W); Dec(R.Bottom, H);
    BoundsRect := R;
  end;
end;

{ TdxOcNode }

constructor TdxOcNode.Create(AOwner: TdxCustomOrgChart);
begin
  inherited Create;
  FOwner := AOwner;
  FChildAlign := caCenter;
  FColor := clNone;
  FImageIndex := -1;
  FImageAlign := AOwner.DefaultImageAlign;
end;

destructor TdxOcNode.Destroy;
begin
  if Deleting then
    inherited Destroy
  else
    Owner.Delete(Self);
end;

function TdxOcNode.GetCount: Integer;
begin
  if FList = nil then
    Result := 0
  else
    Result := FList.Count;
end;

function TdxOcNode.GetAbsoluteCount: Integer;
var
  I: Integer;
begin
  Result := Count;
  if Result > 0 then
    for I := 0 to Count - 1 do
      Inc(Result, Items[I].AbsoluteCount);
end;

function TdxOcNode.GetAbsoluteItem(Index: Integer): TdxOcNode;
var
  I, APassedCount, AChildCount: Integer;
begin
  Result := nil;
  if Count = 0 then exit;
  APassedCount := 0;
  for I := 0 to Count - 1 do
  begin
    if Index - APassedCount = 0 then
    begin
      Result := Items[I];
      break;
    end else Inc(APassedCount);
    AChildCount := Items[I].AbsoluteCount;
    if Index - APassedCount < AChildCount then
    begin
      Result := Items[I].AbsoluteItems[Index - APassedCount];
      break;
    end else Inc(APassedCount, AChildCount);
  end;
end;

procedure TdxOcNode.SetExpanded(Value: Boolean);
begin
  if Value then
    Expand(False)
  else
    Collapse(False);
end;

function TdxOcNode.GetChildren: Boolean;
begin
  Result := FList <> nil;
end;

procedure TdxOcNode.SetChildren(Value: Boolean);
begin
  if Value = HasChildren then Exit;
  if Value then
    FList := TList.Create
  else
  begin
    DeleteChildren;
    FList.Free;
    FList := nil;
  end;
end;

function TdxOcNode.GetParent: TdxOcNode;
begin
  if IsParentRoot then
    Result := nil
  else
    Result := FParent;
end;

function TdxOcNode.GetSelected: Boolean;
begin
  Result := Owner.Selected = Self;
end;

procedure TdxOcNode.SetSelected(Value: Boolean);
begin
  if Value then
    Owner.Selected := Self
  else
    if Selected then Owner.Selected := nil;
end;

function TdxOcNode.Is3D: Boolean;
begin
  Result := (Shape = shRectangle) and (ocRect3D in Owner.Options);
end;

function TdxOcNode.GetWidth: Word;
begin
  Result := FWidth;
  if Result = 0 then Result := Owner.DefaultNodeWidth;
  Result := Owner.DoZoom(Result);
end;

function TdxOcNode.GetHeight: Word;
begin
  Result := FHeight;
  if Result = 0 then Result := Owner.DefaultNodeHeight;
  Result := Owner.DoZoom(Result);
end;

function TdxOcNode.ExtWidth: Word;
begin
  if Owner.Rotated then
    Result := GetHeight
  else
    Result := GetWidth;
  if Is3D then
    Inc(Result, Owner.LineWidth);
end;

function TdxOcNode.ExtHeight: Word;
begin
  if Owner.Rotated then
    Result := GetWidth
  else
    Result := GetHeight;
  if Is3D then
    Inc(Result, Owner.LineWidth);
end;

function TdxOcNode.GetLevel: Integer;
begin
  if Parent = nil then
    Result := 0
  else
    Result := FParent.Level + 1;
end;

function TdxOcNode.GetVisible: Boolean;
begin
  if Parent = nil then
    Result := (FParent <> nil) or (Self = Owner.FRoot)
  else
    Result := FParent.IsVisible and FParent.Expanded;
end;

procedure TdxOcNode.SetAlign(Value: TdxOcNodeAlign);
var
  R: TRect;
begin
  if Value <> FChildAlign then
  begin
    FChildAlign := Value;
    if FParent <> nil then
    begin
      Owner.NodeChanged(Self);
      with FParent do
      begin
        R := FullRect;
        R.Bottom := R.Bottom + Owner.IndentY - 1;
        if FullWidth > ChildrenWidth then R.Bottom := R.Top + FullHeight + Owner.IndentY;
        R := Owner.RotateRect(R);
        InvalidateRect(Owner.Handle, @R, True);
      end;
    end;
    if not IsVisible then Exit;
    with Owner do
    begin
      HideEditor(True);
      if FNodeAt = Self then FHitTests := [];
      if IsUpdated or not HandleAllocated then Exit;
      R := FullRect;
      R.Bottom := R.Bottom + IndentY - 1;
      if Self.FullWidth > ChildrenWidth then R.Bottom := R.Top + Self.FullHeight + IndentY;
      R := RotateRect(R);
      InvalidateRect(Handle, @R, True);
    end;
  end;
end;

procedure TdxOcNode.SetWidth(Value: Word);
var
  P: TPoint;
begin
  P := Owner.MinSizes;
  if (Value <> 0) and (Value < P.X) then Value := P.X;
  if Value <> FWidth then
  begin
    FWidth := Value;
    if FParent = nil then Exit;
    if Owner.Rotated then
      FParent.InvalidateSize(ivHeight)
    else
      FParent.InvalidateSize(ivWidth);
    Owner.NodeChanged(Self);
  end;
end;

procedure TdxOcNode.SetHeight(Value: Word);
var
  P: TPoint;
begin
  P := Owner.MinSizes;
  if (Value <> 0) and (Value < P.Y) then Value := P.Y;
  if Value <> FHeight then
  begin
    FHeight := Value;
    if FParent = nil then Exit;
    if Owner.Rotated then
      FParent.InvalidateSize(ivWidth)
    else
      FParent.InvalidateSize(ivHeight);
    Owner.NodeChanged(Self);
  end;
end;

function TdxOcNode.GetFirstChild: TdxOcNode;
begin
  if Count = 0 then
    Result := nil
  else
    Result := TdxOcNode(FList[0]);
end;

function TdxOcNode.GetLastChild: TdxOcNode;
begin
  if Count = 0 then
    Result := nil
  else
    Result := TdxOcNode(FList[FList.Count - 1]);
end;

function TdxOcNode.GetNextSibling: TdxOcNode;
begin
  if Index >= FParent.Count - 1 then
    Result := nil
  else
    Result := FParent[Index + 1];
end;

function TdxOcNode.GetPrevSibling: TdxOcNode;
begin
  if Index = 0 then
    Result := nil
  else
    Result := FParent[Index - 1];
end;

function TdxOcNode.GetNext: TdxOcNode;
  function NxtSbl(Node: TdxOcNode): TdxOcNode;
  begin
    Result := Node.GetNextSibling;
    if Result <> nil then Exit;
    if Node.Parent <> nil then Result := NxtSbl(Node.FParent);
  end;
begin
  Result := GetFirstChild;
  if Result = nil then Result := NxtSbl(Self);
end;

function TdxOcNode.GetPrev: TdxOcNode;
begin
  Result := GetPrevSibling;
  if Result = nil then
    Result := Parent
  else
    while Result.Count <> 0 do
      Result := Result.GetLastChild;
end;

function TdxOcNode.GetNextChild(Value: TdxOcNode): TdxOcNode;
begin
  if Value.FParent <> Self then
    Result := nil
  else
    Result := Value.GetNextSibling;
end;

function TdxOcNode.GetPrevChild(Value: TdxOcNode): TdxOcNode;
begin
  if Value.FParent <> Self then
    Result := nil
  else
    Result := Value.GetPrevSibling;
end;

function TdxOcNode.GetNextVisible: TdxOcNode;
var
  Node: TdxOcNode;
  Tmp: TList;
begin
  Node := Self;
  while not Node.IsVisible do
    Node := Node.FParent;
  Tmp := Node.FList;
  if not Node.Expanded then Node.FList := nil;
  Result := Node.GetNext;
  Node.FList := Tmp;
end;

function TdxOcNode.GetPrevVisible: TdxOcNode;
begin
  Result := GetPrev;
  if Result = nil then Exit;
  while not Result.IsVisible do
    Result := Result.FParent;
end;

function TdxOcNode.GetItem(Index: Integer): TdxOcNode;
begin
  Result := TdxOcNode(FList[Index])
end;

function TdxOcNode.HasAsParent(Value: TdxOcNode): Boolean;
var
  Node: TdxOcNode;
begin
  Result := True;
  if Value = nil then Exit;
  Node := FParent;
  while Node <> nil do
  begin
    if Node = Value then Exit;
    Node := Node.FParent;
  end;
  Result := False;
end;

function TdxOcNode.IndexOf(Value: TdxOcNode): Integer;
begin
  if Value.FParent <> Self then
    Result := -1
  else
    Result := Value.Index;
end;

procedure TdxOcNode.Enumerate(Value: Integer);
var
  I: Integer;
begin
  for I := Value to Count - 1 do
    TdxOcNode(FList[I]).FIndex := I;
end;

function TdxOcNode.Focused: Boolean;
begin
  Result := Selected and Owner.Focused;
end;

function TdxOcNode.ChildrenWidth: Integer;
var
  I: Integer;
begin
  if not Expanded then
    Result := 0
  else
  begin
    Result := FChildrenWidth;
    if Result = 0 then
    begin
      Inc(Owner.FZoom);
      for I := 0 to Count - 1 do
        Result := Result + Items[I].FullWidth;
      FChildrenWidth := Result;
      Dec(Owner.FZoom);
    end;
    Result := Owner.DoZoom(Result);
  end;
end;

function TdxOcNode.ChildrenHeight: Integer;
var
  I, H: Integer;
begin
  if not Expanded then
    Result := 0
  else
  begin
    Result := FChildrenHeight;
    if Result = 0 then
    begin
      Inc(Owner.FZoom);
      for I := 0 to Count - 1 do
      begin
        H := Items[I].FullHeight;
        if Result < H then Result := H;
      end;
      FChildrenHeight := Result;
      Dec(Owner.FZoom);
    end;
    Result := Owner.DoZoom(Result);
  end;
end;

function TdxOcNode.FullWidth: Integer;
begin
  Inc(Owner.FZoom);
  Result := ExtWidth + Owner.LineWidth + Owner.IndentX;
  if Result < ChildrenWidth then Result := ChildrenWidth;
  Dec(Owner.FZoom);
  Result := Owner.DoZoom(Result);
end;

function TdxOcNode.FullHeight: Integer;
begin
  Inc(Owner.FZoom);
  Result := ExtHeight + Owner.LineWidth + Owner.IndentY + ChildrenHeight;
  Dec(Owner.FZoom);
  Result := Owner.DoZoom(Result);
end;

procedure TdxOcNode.InvalidateSize(Flags: TdxOcIvFlags);
  procedure IvSz(Node: TdxOcNode; Flags: TdxOcIvFlags);
  begin
    if Flags in [ivWidth, ivBoth] then Node.FChildrenWidth := 0;
    if Flags in [ivHeight, ivBoth] then Node.FChildrenHeight := 0;
    if Node.FParent <> nil then IvSz(Node.FParent, Flags);
  end;
begin
  IvSz(Self, Flags);
  if not IsVisible then Exit;
  if Expanded then
    Owner.ChangeSize
  else
    if Count < 2 then Owner.InvalidateNode(Self);
end;

procedure TdxOcNode.Expand(Recurse: Boolean);
var
  I: Integer;
  Allow: Boolean;
begin
  if Count = 0 then Exit;
  if Recurse then
  begin
    for I := 0 to Count - 1 do
      Items[I].Expand(True);
    Expand(False);
  end
  else
  begin
    if Expanded then Exit;
    Allow := True;
    if Assigned(Owner.OnExpansion) then Owner.OnExpansion(Owner, Self, Allow);
    if not Allow then Exit;
    Allow := Owner.InitAnimate(Self);
    FExpanded := True;
    FParent.InvalidateSize(ivBoth);
    if Allow then Owner.Update;
    if Assigned(Owner.OnExpanded) then Owner.OnExpanded(Owner, Self);
  end;
end;

procedure TdxOcNode.Collapse(Recurse: Boolean);
var
  I: Integer;
  Allow: Boolean;
begin
  if Count = 0 then Exit;
  if Recurse then
  begin
    Collapse(False);
    for I := 0 to Count - 1 do
      Items[I].Collapse(True);
  end
  else
  begin
    if (not Expanded) or (FParent = nil) then Exit;
    Allow := True;
    if Assigned(Owner.OnCollapsing) then Owner.OnCollapsing(Owner, Self, Allow);
    if not Allow then Exit;
    Allow := Owner.InitAnimate(Self);
    FExpanded := False;
    FParent.InvalidateSize(ivBoth);
    if Allow then Owner.Update;
    if Assigned(Owner.OnCollapsed) then Owner.OnCollapsed(Owner, Self);
  end;
end;

procedure TdxOcNode.SetData(Value: TdxOcNodeData);
begin
  FData := Value;
end;

procedure TdxOcNode.DeleteChildren;
var
  I: Integer;
begin
  if Count = 0 then Exit;
  if (Owner.Selected <> nil) and Owner.Selected.HasAsParent(Self) then Selected := True;
  FDeleting := True;
  for I := 0 to Count - 1 do
    Owner.Delete(Items[I]);
  FDeleting := False;
  FList.Clear;
  if (FParent = nil) or (not FParent.Deleting) then InvalidateSize(ivBoth);
  if FParent <> nil then FExpanded := False;
end;

function TdxOcNode.FullRect: TRect;
var
  I: Integer;
  ALeft, ABottom: Integer;
begin
  SetRect(Result, 0, 0, 0, 0);
  if not IsVisible then Exit;
  if Parent <> nil then
  begin
    Result := FParent.FullRect;
    Result.Left := Result.Left + FParent.ChildOffset;
  end
  else
  begin
    ALeft :=  -Owner.LeftEdge;
    ABottom := -Owner.TopEdge;
    Owner.RotatePoint(ALeft, ABottom);
    Result.Left := ALeft;
    Result.Bottom := ABottom;
  end;
  Result.Top := Result.Bottom;
  Result.Bottom := Result.Top + ExtHeight + Owner.IndentY + Owner.LineWidth;
  for I := 0 to Index - 1 do
    Result.Left := Result.Left + FParent[I].FullWidth;
  Result.Right := Result.Left + FullWidth;
end;

procedure TdxOcNode.FullToDisplay(var Rect: TRect);
var
  W: Integer;
begin
  W := ExtWidth + Owner.LineWidth;
  with Rect do
  begin
    if ChildAlign = caRight then Left := Right - W;
    if ChildAlign = caCenter then Left := Left + (Right - Left - W) shr 1;
    Right := Left + W;
  end;
end;

procedure TdxOcNode.DisplayToClient(var Rect: TRect);
var
  DX, DY: Integer;
begin
  DX := 0;
  DY := 0;
  case Shape of
    shRectangle:
      begin DX := 0; DY := 0; end;
    shDiamond:
      begin
        DX := Width shr 2;
        DY := Height shr 2;
      end;
    shRoundRect:
      begin
        DX := Radius * 3 div 20;
        DY := DX;
      end;
    shEllipse:
      begin
        DX := Width * 3 div 20;
        DY := Height * 3 div 20;
      end;
  end;
  DX := DX + Owner.LineWidth shr 1 + 1;
  DY := DY + Owner.LineWidth shr 1 + 1;
  with Rect do
  begin
    Left := Left + DX;
    Top := Top + DY;
    Right := Right - DX;
    Bottom := Bottom - DY;
    if Owner.Rotated then
      Left := Left + Owner.IndentY
    else
      Top := Top + Owner.IndentY;
  end;
end;

function TdxOcNode.ClientToText(var Rect: TRect): TPoint;
var
  W, H: Integer;
begin
  Result.X  := -999999;
  Result.Y  := -999999;
  if (Owner.Images = nil) or (ImageAlign = iaNone) or (ImageIndex = -1) then Exit;
  W := Owner.DoZoom(Owner.Images.Width);
  H := Owner.DoZoom(Owner.Images.Height);
  case ImageAlign of
    iaLT, iaLC, iaLB:
      begin
        Result.X := Rect.Left;
        Rect.Left := Rect.Left + W;
      end;
    iaRT, iaRC, iaRB:
      begin
        Rect.Right := Rect.Right - W;
        Result.X := Rect.Right;
      end;
    iaTL, iaTC, iaTR:
      begin
        Result.Y := Rect.Top;
        Rect.Top := Rect.Top + H;
      end;
    iaBL, iaBC, iaBR:
      begin
        Rect.Bottom := Rect.Bottom - H;
        Result.Y := Rect.Bottom;
      end;
  end;
  case ImageAlign of
    iaLT, iaRT: Result.Y := Rect.Top;
    iaLB, iaRB: Result.Y := Rect.Bottom - H;
    iaLC, iaRC: Result.Y := Rect.Top + (Rect.Bottom - Rect.Top - H) shr 1;
    iaTL, iaBL: Result.X := Rect.Left;
    iaTR, iaBR: Result.X := Rect.Right - W;
    iaTC, iaBC: Result.X := Rect.Left + (Rect.Right - Rect.Left - W) shr 1;
  end;
end;

function TdxOcNode.DisplayRect: TRect;
begin
  Result := FullRect;
  if Result.Left = Result.Right then Exit;
  FullToDisplay(Result);
  Result := Owner.RotateRect(Result);
end;

function TdxOcNode.ClientRect: TRect;
begin
  Result := DisplayRect;
  if Result.Left = Result.Right then Exit;
  DisplayToClient(Result);
end;

function TdxOcNode.IsParentRoot: Boolean;
begin
  Result := FParent = Owner.RootNode;
end;

procedure TdxOcNode.MakeVisible;
var
  R: TRect;
  Node: TdxOcNode;
  LeftX, TopY: Integer;
begin
  Owner.FNoAnim := True;
  Node := Parent;
  while Node <> nil do
  begin
    Node.Expand(False);
    Node := Node.Parent;
  end;
  Owner.FNoAnim := False;
  R := DisplayRect;
  if (R.Right - R.Left > Owner.ClientWidth) or (R.Bottom - R.Top > Owner.ClientHeight)
    then DisplayToClient(R);
  LeftX := R.Left; TopY := R.Top;
  if R.Right > Owner.ClientWidth then LeftX := LeftX + Owner.ClientWidth - R.Right;
  if LeftX < 0 then LeftX := 0;
  if R.Bottom > Owner.ClientHeight then TopY := TopY + Owner.ClientHeight - R.Bottom;
  if TopY < 0 then TopY := 0;
  if (LeftX = R.Left) and (TopY = R.Top) then Exit;
  Owner.SetLeftTop(Owner.LeftEdge + R.Left - LeftX, Owner.TopEdge + R.Top - TopY);
end;

procedure TdxOcNode.MoveTo(Dest: TdxOcNode; Mode: TdxOcNodeAttachMode);
var
  ParNode: TdxOcNode;
  ParIdx: Integer;

  procedure SetPar(PN: TdxOcNode; PI: Integer);
  begin
    ParNode := PN;
    ParIdx := PI;
  end;

begin
  if Dest = nil then
    case Mode of
      naInsert: Exit;
      naAdd: Mode := naAddChild;
      naAddFirst: Mode := naAddChildFirst;
    end
  else
    if (Dest = Self) or Dest.HasAsParent(Self) or not Owner.IsMyNode(Dest)
    then Exit;
  case Mode of
    naInsert: SetPar(Dest.Parent, Dest.Index);
    naAdd: SetPar(Dest.Parent, -1);
    naAddFirst: SetPar(Dest.Parent, 0);
    naAddChild: SetPar(Dest, -1);
    naAddChildFirst: SetPar(Dest, 0);
  end;
  if ParNode = Parent then
  begin
    if ParIdx > Index then Dec(ParIdx);
    if (ParIdx = Index) or (ParIdx < 0) and (GetNextSibling = nil) then Exit;
  end;
  Owner.InternalMoveTo(ParNode, Self, ParIdx);
end;

function TdxOcNode.GetColor: TColor;
begin
  if FColor <> clNone then
    Result := FColor
  else
    Result := Owner.Color;
end;

procedure TdxOcNode.SetColor(Value: TColor);
begin
  if Value <> FColor then
  begin
    FColor := Value;
    if FParent = nil then Exit;
    Owner.InvalidateNode(Self);
    Owner.NodeChanged(Self);
  end;
end;

procedure TdxOcNode.SetShape(Value: TdxOcShape);
begin
  if Value <> FShape then
  begin
    FShape := Value;
    if FParent = nil then Exit;
    with Owner do
    begin
      HideEditor(True);
      InvalidateNode(Self);
      if (FNodeAt = Self) and (htOnRect in FHitTests) then FHitTests := [];
      NodeChanged(Self);
    end;
  end;
end;

function TdxOcNode.ChildOffset: Integer;
begin
  if ChildAlign = caLeft then
    Result := 0
  else
  begin
    Result := FullWidth - ChildrenWidth;
    if ChildAlign = caCenter then Result := Result shr 1;
  end;
end;

function TdxOcNode.Radius: Integer;
begin
  Result := Height;
  if Result > Width then Result := Width;
  Result := Result shr 1;
end;

procedure TdxOcNode.SetFont(Font: TFont);
begin
  if Assigned(Owner.OnSetFont) then Owner.OnSetFont(Owner, Self, Font);
end;

procedure TdxOcNode.GetNodeInfo(var AInfo: TdxOcNodeInfo);
begin
  with AInfo do
  begin
    Width := FWidth;
    Height := FHeight;
    Color := FColor;
    Align := FChildAlign;
    Shape := FShape;
    Index := FImageIndex;
    IAlign := FImageAlign;
  end;
end;

procedure TdxOcNode.SetImageIndex(Value: Smallint);
begin
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
    if FParent = nil then Exit;
    if Owner.Images <> nil then Owner.InvalidateNode(Self);
    Owner.NodeChanged(Self);
  end;
end;

procedure TdxOcNode.SetImageAlign(Value: TdxOcImageAlign);
begin
  if Value <> FImageAlign then
  begin
    FImageAlign := Value;
    if FParent = nil then Exit;
    if Owner.Images <> nil then Owner.InvalidateNode(Self);
    Owner.NodeChanged(Self);
  end;
end;

procedure TdxOcNode.AdjustSizes(const S: string);
var
  R: TRect;
  W, H, Handle: Integer;
begin
  Handle := GetDC(0);
  Inc(Owner.FZoom);
  try
    SetRect(R, 0, 0, Width + Owner.LineWidth, Height + Owner.LineWidth);
    if Owner.Rotated then
      Inc(R.Right, Owner.IndentY)
    else
      Inc(R.Bottom, Owner.IndentY);
    DisplayToClient(R);
    ClientToText(R);
    W := R.Right - R.Left;
    H := R.Bottom - R.Top;
    Owner.Canvas.Font := Owner.Font;
    SetFont(Owner.Canvas.Font);
    SelectObject(Handle, Owner.Canvas.Font.Handle);
    Owner.DoDrawText(Handle, S, R, DT_CALCRECT);
    W := (R.Right - R.Left - W) * Width div W;
    if Assigned(Owner.Images) and (ImageIndex > -1)
    and (ImageIndex < Owner.Images.Count) then 
    begin
      W := W + Owner.Images.Width;
      if emCenter in Owner.EditMode then
        W := W + FOwner.Images.Width;
    end;
    H := (R.Bottom - R.Top - H) * Height div H;
    if (W > 0) and not (emWrap in Owner.EditMode) then Width := Width + W;
    if (H > 0) and (emGrow in Owner.EditMode) then Height := Height + H;
  finally
    Dec(Owner.FZoom);
    ReleaseDC(0, Handle);
  end;
end;

procedure TdxOcNode.SetAnimXY(LeftX, TopY: Integer; const Clip: TRect; First: Boolean);
var
  R: TRect;
  I: Integer;
begin
  if First then FDraw := False;
  if FParent = nil then
  begin
    LeftX := -Owner.LeftEdge;
    TopY := -Owner.TopEdge;
    Owner.RotatePoint(LeftX, TopY);
    FDraw := True;
  end;
  if IsVisible then
  begin
    R.Left := LeftX; R.Top := TopY;
    R.Right := LeftX + FullWidth;
    if Self = Owner.FRoot then
      R.Bottom := TopY
    else
      R.Bottom := TopY + ExtHeight + Owner.IndentY + Owner.LineWidth;
    I := 0;
    if Expanded then
      I := 999999
    else
      if Owner.HasButton(Self) then I := 6 - Owner.LineWidth shr 1;
    if I < 0 then I := 0;
    Inc(R.Bottom, I);
    if not ((R.Left > Clip.Right) or (R.Right < Clip.Left) or (R.Top > Clip.Bottom) or (R.Bottom < Clip.Top))
      then FDraw := True;
    Dec(R.Bottom, I);
    LeftX := LeftX + ChildOffset; TopY := R.Bottom;
    FullToDisplay(R);
    FAnimX := R.Left; FAnimY := R.Top;
  end
  else
  begin
    FDraw := FParent.FDraw;
    FAnimX := FParent.FAnimX;
    FAnimY := FParent.FAnimY + Owner.IndentY shr 2;
    if FParent.ChildAlign <> caLeft then
    begin
      I := FParent.ExtWidth - ExtWidth;
      if FParent.ChildAlign = caCenter then I := I div 2;
      Inc(FAnimX, I);
    end;
  end;
  if First then
  begin
    FAnimX0 := FAnimX;
    FAnimY0 := FAnimY;
  end;
  if not (FDraw or First and (Owner.FCollapsed <> nil)) then Exit;
  if Expanded or (Owner.FCollapsed = Self) then
    for I := 0 to Count - 1 do
    begin
      Items[I].SetAnimXY(LeftX, TopY, Clip, First);
      if Expanded then Inc(LeftX, Items[I].FullWidth);
    end;
end;

procedure TdxOcNode.ReadData(Stream: TStream);
var
  Info: TdxOcNodeInfo;
begin
  Stream.ReadBuffer(Info, SizeOf(Info));
  Width := Info.Width;
  Height := Info.Height;
  Color := Info.Color;
  ChildAlign := Info.Align;
  Shape := Info.Shape;
  ImageIndex := Info.Index;
  ImageAlign := Info.IAlign;
end;

procedure TdxOcNode.WriteData(Stream: TStream);
var
  Info: TdxOcNodeInfo;
begin
  GetNodeInfo(Info);
  Stream.WriteBuffer(Info, SizeOf(Info));
end;

procedure TdxOcNode.ReadChildren(Stream: TStream);
var
  Cnt: Word;
  Child, Par: TdxOcNode;
begin
  Text := ReadStr(Stream, Owner.IsUnicode);
  if FParent = nil then
    Par := nil
  else
    Par := Self;
  Stream.ReadBuffer(Cnt, SizeOf(Cnt));
  while Cnt > 0 do
  begin
    Child := Owner.AddChild(Par, nil);
    if Child = nil then Exit;
    Child.ReadData(Stream);
    Child.ReadChildren(Stream);
    Dec(Cnt);
  end;
end;

procedure TdxOcNode.WriteChildren(Stream: TStream);
var
  I: Integer;
begin
  WriteStr(Stream, Text);
  I := Count;
  Stream.WriteBuffer(I, SizeOf(Word));
  for I := 0 to Count - 1 do
  begin
    Items[I].WriteData(Stream);
    Items[I].WriteChildren(Stream);
  end;
end;

function TdxOcNode.GetText: string;
begin
  Result := FText;
  if Assigned(Owner.OnGetText) then
    Owner.OnGetText(Owner, self, FText);
end;

procedure TdxOcNode.SetText(const Value: string);
begin
  FText := Value;
  if Assigned(Owner.OnSetText) then
    Owner.OnSetText(Owner, self, Value);
end;

procedure TdxOcNode.InternalSetText(const Value: string);
begin
  if Text = Value then Exit;
  SetText(Value);
  if Owner.EditMode * [emWrap, emGrow] <> [emWrap] then AdjustSizes(Text);
  if FParent = nil then Exit;
  Owner.InvalidateNode(Self);
  Owner.NodeChanged(Self);
end;

{ TdxCustomOrgChart }

constructor TdxCustomOrgChart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTimer := TTimer.Create(self);
  FTimer.Enabled := False;
  FTimer.Interval := 220;
  FTimer.OnTimer := DoTimerScrolling;
  FRoot := TdxOcNode.Create(Self);
  FRoot.FExpanded := True;
  Width := 320;
  Height := 200;
  ParentColor := False;
  ParentFont := False;
  TabStop := True;
  FDefaultNodeWidth := 64;
  FDefaultNodeHeight := 40;
  FIndentX := 16;
  FIndentY := 16;
  FLineWidth := 1;
  FLineColor := clBlack;
  FBorderStyle := bsSingle;
  FSelectedNodeColor := clHighlight;
  FSelectedNodeTextColor := clHighlightText;
  FSizeChanged := True;
  FOptions := [ocSelect, ocFocus, ocButtons, ocDblClick, ocEdit, ocCanDrag, ocShowDrag];
  FEditMode := [emWrap];
  FZoom := 1;
  FImagesChangeLink := TChangeLink.Create;
  FImagesChangeLink.OnChange := ImageListChange;
end;

destructor TdxCustomOrgChart.Destroy;
begin
  FTimer.Free;
  FTimer := nil;
  HideEditor(False);
  FreeAndNil(FEditor);
  FBitmap.Free;
  Selected := nil;
  Images := nil;
  FImagesChangeLink.Free;
  FRoot.HasChildren := False;
  FRoot.FDeleting := True;
  FRoot.Free;
  inherited Destroy;
end;

procedure TdxCustomOrgChart.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WindowClass.Style := Params.WindowClass.Style and not (CS_HREDRAW or CS_VREDRAW);
  Params.Style := Params.Style or WS_TABSTOP or WS_HSCROLL or WS_VSCROLL;
  if BorderStyle = bsSingle then
    if Ctl3D then
      Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE
    else
      Params.Style := Params.Style or WS_BORDER;
end;

procedure TdxCustomOrgChart.CreateHandle;
begin
  inherited CreateHandle;
  if FZoom = 0 then UpdateScrollRange;
end;

procedure TdxCustomOrgChart.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;

procedure TdxCustomOrgChart.SetBorderStyle(Value: TBorderStyle);
begin
  if Value <> BorderStyle then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

function TdxCustomOrgChart.IsMyNode(Value: TdxOcNode): Boolean;
begin
  if (Value = nil) or (Value = FRoot) then
    Result := True
  else
    Result := Value.HasAsParent(FRoot);
end;

procedure TdxCustomOrgChart.DoAdd(AParent, ANode: TdxOcNode; AIndex: Integer);
begin
  if AParent = nil then AParent := FRoot;
  if AIndex < 0 then AIndex := AParent.Count;
  ANode.FParent := AParent;
  with AParent do
  begin
    HasChildren := True;
    FList.Insert(AIndex, ANode);
    Enumerate(AIndex);
    InvalidateSize(ivBoth);
  end;
end;

function TdxCustomOrgChart.InternalAdd(ParentNode: TdxOcNode; Data: TdxOcNodeData;
  Idx: Integer): TdxOcNode;
begin
  Result := nil;
  if not IsMyNode(ParentNode) then Exit;
  Result := CreateNode;
  if Result = nil then Exit;
  Result.FData := Data;
  if Assigned(OnCreateNode) then OnCreateNode(Self, Result);
  DoAdd(ParentNode, Result, Idx);
  Inc(FCount);
  if Count = 1 then Selected := Result;
end;

procedure TdxCustomOrgChart.InternalMoveTo(ParentNode, Node: TdxOcNode; Idx: Integer);
begin
  with Node.FParent do
  begin
    FList.Delete(Node.Index);
    Enumerate(Node.Index);
    if Node.Parent <> ParentNode then
      InvalidateSize(ivBoth);
    if FList.Count = 0 then
    begin
      HasChildren := False;
      if (FParent <> nil) then
        FExpanded := False;
    end;
  end;
  DoAdd(ParentNode, Node, Idx);
end;

function TdxCustomOrgChart.Insert(Node: TdxOcNode; Data: TdxOcNodeData): TdxOcNode;
begin
  if Node = nil then
    Result := nil
  else
    Result := InternalAdd(Node.Parent, Data, Node.Index);
end;

function TdxCustomOrgChart.Add(Node: TdxOcNode; Data: TdxOcNodeData): TdxOcNode;
begin
  if Node = nil then
    Result := AddChild(nil, Data)
  else
    Result := InternalAdd(Node.Parent, Data, -1);
end;

function TdxCustomOrgChart.AddFirst(Node: TdxOcNode; Data: TdxOcNodeData): TdxOcNode;
begin
  if Node = nil then
    Result := AddChildFirst(nil, Data)
  else
    Result := InternalAdd(Node.Parent, Data, 0);
end;

function TdxCustomOrgChart.AddChild(Node: TdxOcNode; Data: TdxOcNodeData): TdxOcNode;
begin
  Result := InternalAdd(Node, Data, -1);
end;

function TdxCustomOrgChart.AddChildFirst(Node: TdxOcNode; Data: TdxOcNodeData): TdxOcNode;
begin
  Result := InternalAdd(Node, Data, 0);
end;

function TdxCustomOrgChart.GetAbsoluteItem(Index: Integer): TdxOcNode;
begin
  Result := RootNode.AbsoluteItems[Index];
end;

function TdxCustomOrgChart.GetItem(Index: Integer): TdxOcNode;
begin
  Result := FRoot.GetItem(Index);
end;

function TdxCustomOrgChart.GetRootCount: Integer;
begin
  Result := RootNode.Count;
end;

function TdxCustomOrgChart.HasButton(Node: TdxOcNode): Boolean;
begin
  Result := (ocButtons in Options) and (Node.Count > 0) and not (IsZoomed and Node.Expanded);
end;

procedure TdxCustomOrgChart.RotatePoint(var X, Y: LongInt);
var
  Tmp: Integer;
begin
  if Rotated then
  begin
    Tmp := X; X := Y; Y := Tmp;
  end;
end;

function TdxCustomOrgChart.RotateRect(const Rect: TRect): TRect;
var
  Tmp: Integer;
begin
  Result := Rect;
  if Rotated then
    with Result do
    begin
      Tmp := Left; Left := Top; Top := Tmp;
      Tmp := Right; Right := Bottom; Bottom := Tmp;
    end;
end;

procedure TdxCustomOrgChart.Paint;
var
  Upd: TRect;
  Cnv: TCanvas;
  TmpFont: TFont;
  Time:{$IFDEF DELPHI9}DWORD{$ELSE}Integer{$ENDIF};
  Anim: Integer;

  function InRect(const R: TRect): Boolean;
  begin
    Result := not
      ((R.Left > Upd.Right) or (R.Right < Upd.Left) or (R.Top > Upd.Bottom) or (R.Bottom < Upd.Top));
  end;

  procedure SetCanvas;
  begin
    with Cnv do
    begin
      Pen.Mode := pmCopy;
      Pen.Style := psSolid;
      Pen.Color := LineColor;
      Pen.Width := LineWidth;
      Brush.Style := bsSolid;
    end;
  end;

  procedure ExtMoveTo(X, Y: Integer);
  begin
    RotatePoint(X, Y);
    Cnv.MoveTo(X, Y);
  end;

  procedure ExtLineTo(X, Y: Integer);
  begin
    RotatePoint(X, Y);
    Cnv.LineTo(X, Y);
  end;

  procedure Erase;
  begin
    Cnv.Brush.Style := bsSolid;
    Cnv.Brush.Color := Color;
    Cnv.FillRect(RotateRect(Upd));
  end;

  procedure PaintFrame(Node: TdxOcNode; const R: TRect);
  var
    Rad: Integer;
    Pts: array[0..3] of TPoint;
  begin
    case Node.Shape of
      shRectangle:
        begin
          Cnv.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
          if ocRect3D in Options then
            with Cnv do
            begin
              Rad := LineWidth shr 1;
              MoveTo(R.Left + LineWidth, R.Bottom + Rad);
              LineTo(R.Right + Rad, R.Bottom + Rad);
              LineTo(R.Right + Rad, R.Top + LineWidth);
            end;
        end;
      shEllipse: Cnv.Ellipse(R.Left, R.Top, R.Right, R.Bottom);
      shRoundRect:
        begin
          Rad := Node.Radius;
          Cnv.RoundRect(R.Left, R.Top, R.Right, R.Bottom, Rad, Rad);
        end;
      shDiamond:
        begin
          Pts[0].X := R.Left; Pts[0].Y := R.Top + (R.Bottom - R.Top) shr 1;
          Pts[1].X := R.Left + (R.Right - R.Left) shr 1; Pts[1].Y := R.Top;
          Pts[2].X := R.Right - 1; Pts[2].Y := Pts[0].Y;
          Pts[3].X := Pts[1].X; Pts[3].Y := R.Bottom - 1;
          Cnv.Polygon(Pts);
        end;
    end;
    Cnv.TextWidth('');
  end;

  procedure PaintButton(X, Y: Integer; Value: Boolean);
  begin
    if Rotated then
    begin
      RotatePoint(X, Y);
      Inc(Y); Dec(X);
    end;
    with Cnv do
    begin
      Pen.Width := 1; Brush.Color := Color;
      Rectangle(X - 5, Y - 6, X + 6, Y + 5);
      MoveTo(X - 2, Y - 1); LineTo(X + 3, Y - 1);
      if not Value then
      begin
        MoveTo(X, Y - 3);
        LineTo(X, Y + 2);
      end;
    end;
  end;

  function GetAnimRect(Node: TdxOcNode; Coef: Integer): TRect;
  begin
    with Result do
    begin
      Left := Node.FAnimX + (Node.FAnimX0 - Node.FAnimX) * Coef div 16;
      Top := Node.FAnimY + (Node.FAnimY0 - Node.FAnimY) * Coef div 16;
      Right := Left + Node.ExtWidth + LineWidth;
      Bottom := Top + Node.ExtHeight + IndentY + LineWidth;
    end;
  end;

  function PaintNode(Node: TdxOcNode): TPoint;
  var
    Where: TRect;
    Line: TPoint;
    I, LinLeft, LinRight: Integer;
  begin
    Where := GetAnimRect(Node, Anim);
    if Node = FRoot then Where.Bottom := Where.Top;
    with Where do
    begin
      Result.X := Left + (Right - Left) shr 1;
      Result.Y := Top + IndentY shr 1;
    end;
    if not Node.FDraw then Exit;
    if (Where.Bottom < Upd.Bottom) and (Node.Expanded or (FCollapsed = Node)) then
    begin
      LinLeft := 0; LinRight := -1;
      for I := 0 to Node.Count - 1 do
      begin
        Line := PaintNode(Node[I]);
        if (I = 0) or (Line.X < Upd.Left) then LinLeft := Line.X;
        LinRight := Line.X;
        if Line.X >= Upd.Right then Break;
      end;
      SetCanvas;
      if not ((Node = FRoot) and (Node.Count <= 1)) then
      begin
        if (Node = FRoot) and (Node.Count > 1) then Result.X := LinRight;
        if Result.X < LinLeft then LinLeft := Result.X;
        if Result.X > LinRight then LinRight := Result.X;
        ExtMoveTo(LinLeft, Line.Y);
        ExtLineTo(LinRight, Line.Y);
      end;
      if (Node <> FRoot) and (Line.Y > Where.Bottom) then
      begin
        ExtMoveTo(Result.X, Where.Bottom - LineWidth);
        ExtLineTo(Result.X, Line.Y);
      end;
    end;
    I := 0;
    if HasButton(Node) then I := 6 - LineWidth shr 1;
    if I < 0 then I := 0;
    Inc(Where.Bottom, I);
    if (Node <> FRoot) and InRect(Where) then
    begin
      Dec(Where.Bottom, I); I := LineWidth;
      with Where do
      begin
        if Node.Is3D then
        begin
          Dec(Right, I); Dec(Bottom, I);
        end;
        I := I shr 1;
        Inc(Left, I); Inc(Top, I);
        Dec(Right, I); Dec(Bottom, I);
      end;
      SetCanvas;
      with Cnv do
      begin
        Font := TmpFont;
        Brush.Color := Node.Color;
        if (ocSelect in Options) and Node.Focused then
        begin
          Brush.Color := SelectedNodeColor;
          Font.Color := SelectedNodeTextColor; 
        end;
        ExtMoveTo(Result.X, Result.Y);
        Inc(Where.Top, IndentY);
        if (Node.Parent <> nil) or (FRoot.Count > 1) then ExtLineTo(Result.X, Where.Top);
        PaintFrame(Node, RotateRect(Where));
        Dec(Where.Top, IndentY);
      end;
      I := Where.Bottom;
      Where := RotateRect(Where);
      Node.DisplayToClient(Where);
      if InRect(RotateRect(Where)) then
      begin
        Node.SetFont(Cnv.Font);
        DrawNode(Node, Cnv, Where);
        SetCanvas;
        if (ocFocus in Options) and Node.Selected then Cnv.DrawFocusRect(Where);
      end;
      if HasButton(Node) then PaintButton(Result.X, I, Node.Expanded);
    end;
  end;

  procedure PaintAnim;
  begin
    Erase;
    PaintNode(FRoot);
    Canvas.Draw(0, 0, FBitmap);
  end;

var
  ARect: TRect;
begin
  Anim := 0;
  SetRect(ARect, 0, 0, FullWidth, FullHeight);
  if csPaintCopy in ControlState then
    Upd := RotateRect(ARect)
  else
    Upd := RotateRect(Canvas.ClipRect);
  with Upd do
    if (Left >= Right) and (Top > Bottom) then Exit;

  if (FCollapsed = nil) and (FBitmap <> nil) then
  begin
    FBitmap.Free;
    FBitmap := nil;
  end;
  if FBitmap <> nil then
  begin
    if FBitmap.Width <> Self.Width then    // Fix: by Kirill (Hole)
      FBitmap.Width := Self.Width;         // Fix: by Kirill (Hole)
    if FBitmap.Height <> Self.Height then  // Fix: by Kirill (Hole)
      FBitmap.Height := Self.Height;       // Fix: by Kirill (Hole)
  end;
  FRoot.SetAnimXY(0, 0, Upd, FBitmap = nil);
  TmpFont := TFont.Create; TmpFont.Assign(Font);
  TmpFont.Height := DoZoom(Font.Height);
  try
    if FBitmap = nil then
    begin
      Cnv := Canvas;
      Erase;
      PaintNode(FRoot);
    end
    else
    begin
      Cnv := FBitmap.Canvas;
      Time := GetCurrentTime;
      for Anim := 15 downto 1 do
      begin
        Inc(Time, 10);
        PaintAnim;
        while Time > GetCurrentTime do
          ;
      end;
      FCollapsed := nil;
      PaintAnim;
    end;
  finally
    TmpFont.Free;
    FUpdated := False;
  end;
end;

procedure TdxCustomOrgChart.DoDrawText(Handle: HDC; Text: string; var Rect: TRect; Flags: Integer);
var
  ARect: TRect;
  HText: Integer;
begin
  ARect := Rect;
  Flags := Flags or DT_EXPANDTABS;
  if emLeft in EditMode then Flags := Flags or DT_LEFT;
  if emCenter in EditMode then Flags := Flags or DT_CENTER;
  if emRight in EditMode then Flags := Flags or DT_RIGHT;
  if emWrap in EditMode then Flags := Flags or DT_WORDBREAK;
  if emVCenter in EditMode then
  begin
    HText := DrawText(Handle, PChar(Text), -1, ARect, Flags or DT_CALCRECT);
    if (Rect.Bottom - Rect.Top) > HText then
    begin
      inc(Rect.Top, (Rect.Bottom - Rect.Top - HText) div 2);
      Rect.Bottom := Rect.Top + HText;
    end;
  end;
  DrawText(Handle, PChar(Text), -1, Rect, Flags or DT_EDITCONTROL);
end;

procedure TdxCustomOrgChart.DoDrawImage(ACanvas: TCanvas; FullRect, R: TRect; ABitmap: TBitmap);
const
  ROP_DSPDxax = $00E20746;
var
  W, H, BW, BH: Integer;
  DC, MaskDC: HDC;
  B, MaskHandle: HBITMAP;
  crText, crBack: COLORREF;
  ARect: TRect;
begin
  with ACanvas, R do
  begin
    W := Right - Left;
    H := Bottom - Top;
    BW := ABitmap.Width;
    BH := ABitmap.Height;
    OffsetRect(R, -FullRect.Left, -FullRect.Top);

    DC := CreateCompatibleDC(Handle);
    with FullRect do
      B := CreateCompatibleBitmap(Handle, Right - Left, Bottom - Top);
    B := SelectObject(DC, B);
    try
      MaskDC := CreateCompatibleDC(0);
      MaskHandle := ABitmap.MaskHandle;
      MaskHandle := SelectObject(MaskDC, MaskHandle);
      try
        SetRect(ARect, 0, 0, FullRect.Right - FullRect.Left, FullRect.Bottom - FullRect.Top);
        Windows.FillRect(DC, ARect, Brush.Handle);
        StretchBlt(DC, Left, Top, W, H, ABitmap.Canvas.Handle, 0, 0, BW, BH, SRCCOPY);
        crText := SetTextColor(DC, 0);
        crBack := SetBkColor(DC, $FFFFFF);
        SelectObject(DC, Brush.Handle);
        StretchBlt(DC, Left, Top, W, H, MaskDC, 0, 0, BW, BH, ROP_DSPDxax);
        SetTextColor(DC, crText);
        SetBkColor(DC, crBack);
      finally
        SelectObject(MaskDC, MaskHandle);
        DeleteDC(MaskDC);
      end;

      with FullRect do
        BitBlt(Handle, Left, Top, Right - Left, Bottom - Top, DC, 0, 0, SRCCOPY);
    finally
      DeleteObject(SelectObject(DC, B));
      DeleteDC(DC);
    end;
  end;
end;

procedure TdxCustomOrgChart.DrawNode(Node: TdxOcNode; ACanvas: TCanvas; Rect: TRect);
begin
  if Assigned(OnDrawNode) then
    OnDrawNode(Self, Node, ACanvas, Rect)
  else
    DefaultDrawNode(Node, ACanvas, Rect);
end;

procedure TdxCustomOrgChart.DefaultDrawNode(Node: TdxOcNode; ACanvas: TCanvas; Rect: TRect);
var
  P: TPoint;
  Bmp: TBitmap;
  ARect: TRect;
begin
  P := Node.ClientToText(Rect);
  if (P.X + P.Y >= -999999) and (Node.ImageIndex <> -1) then
  begin
    Bmp := TBitmap.Create;
    Images.GetBitmap(Node.ImageIndex, Bmp);
    ARect.Left := P.X;
    ARect.Top := P.Y;
    ARect.Right := ARect.Left + DoZoom(Bmp.Width);
    ARect.Bottom := ARect.Top + DoZoom(Bmp.Height);
    DoDrawImage(ACanvas, ARect, ARect, Bmp);
    Bmp.Free;
  end;
  DoDrawText(ACanvas.Handle, Node.Text, Rect, 0);
end;

function TdxCustomOrgChart.InitAnimate(Node: TdxOcNode): Boolean;
var
  ARect: TRect;
begin
  Result := not FNoAnim and (ocAnimate in Options) and HandleAllocated and Node.IsVisible;
  if Result then
  begin
    FCollapsed := Node;
    SetRect(ARect, 0, 0, ClientWidth, ClientHeight);
    FRoot.SetAnimXY(0, 0, ARect, True);
    if FBitmap = nil then
    begin
      FBitmap := TBitmap.Create;
      with FBitmap do
      begin
        Width := Self.Width;
        Height := Self.Height;
{$IFDEF DELPHI3}TransparentColor := clNone; {$ENDIF}
      end;
    end;
  end;
end;

function TdxCustomOrgChart.MinSizes: TPoint;
begin
  if Images = nil then
  begin
    Result.X := 16;
    Result.Y := 16;
  end else
  begin
    Result.X := Images.Width shl 1;
    Result.Y :=  Images.Height shl 1;
  end;
  if Result.X < 16 then Result.X := 16;
  if Result.Y < 16 then Result.Y := 16;
end;

procedure TdxCustomOrgChart.SetNodeWidth(Value: Word);
var
  P: TPoint;
begin
  P := MinSizes;
  if Value < P.X then Value := P.X;
  if Value = DefaultNodeWidth then Exit;
  FDefaultNodeWidth := Value;
  if Rotated then
    InvalidateSizes(ivHeight)
  else
    InvalidateSizes(ivWidth);
end;

procedure TdxCustomOrgChart.SetNodeHeight(Value: Word);
var
  P: TPoint;
begin
  P := MinSizes;
  if Value < P.Y then Value := P.Y;
  if Value = DefaultNodeHeight then Exit;
  FDefaultNodeHeight := Value;
  if Rotated then
    InvalidateSizes(ivWidth)
  else
    InvalidateSizes(ivHeight);
end;

procedure TdxCustomOrgChart.SetIndentX(Value: Word);
begin
  if Value = FIndentX then Exit;
  FIndentX := Value;
  if Rotated then
    InvalidateSizes(ivHeight)
  else
    InvalidateSizes(ivWidth);
end;

procedure TdxCustomOrgChart.SetIndentY(Value: Word);
begin
  if Value = FIndentY then Exit;
  FIndentY := Value;
  if Rotated then
    InvalidateSizes(ivWidth)
  else
    InvalidateSizes(ivHeight);
end;

function TdxCustomOrgChart.IsUpdated: Boolean;
begin
////  Result := FUpdated or (FUpdate <> 0); // Fix: by Kirill (IsUpdate)
  Result := FUpdated and (FUpdate <> 0); // Fix: by Kirill (IsUpdate)
  if Result = False then FUpdated := False; // Fix: by Kirill (IsUpdate)
end;

procedure TdxCustomOrgChart.Invalidate;
begin
  if not IsUpdated then inherited Invalidate;
  FUpdated := True;
end;

procedure TdxCustomOrgChart.InvalidateSizes(Flags: TdxOcIvFlags);
  procedure IvSz(Node: TdxOcNode; Flags: TdxOcIvFlags);
  var
    I: Integer;
  begin
    if Flags in [ivWidth, ivBoth] then Node.FChildrenWidth := 0;
    if Flags in [ivHeight, ivBoth] then Node.FChildrenHeight := 0;
    for I := 0 to Node.Count - 1 do
      IvSz(Node[I], Flags);
  end;
begin
  IvSz(FRoot, Flags);
  ChangeSize;
end;

procedure TdxCustomOrgChart.SetLineColor(Value: TColor);
begin
  if (Value = clNone) or (Value = clDefault) then Value := clBlack;
  if Value = LineColor then Exit;
  FLineColor := Value;
  if HandleAllocated then
    Invalidate;
end;

procedure TdxCustomOrgChart.SetLineWidth(Value: Word);
begin
  if Value = 0 then Value := 1;
  if Value = FLineWidth then Exit;
  FLineWidth := Value;
  InvalidateSizes(ivBoth);
end;

procedure TdxCustomOrgChart.SetSelectedNodeColor(Value: TColor);
begin
  if (Value = clNone) or (Value = clDefault) then Value := clHighlight;
  if Value = SelectedNodeColor then Exit;
  FSelectedNodeColor := Value;
  if HandleAllocated then
    Invalidate;
end;

procedure TdxCustomOrgChart.SetSelectedNodeTextColor(Value: TColor);
begin
  if (Value = clNone) or (Value = clDefault) then Value := clHighlightText;
  if Value = SelectedNodeTextColor then Exit;
  FSelectedNodeTextColor := Value;
  if HandleAllocated then
    Invalidate;
end;

procedure TdxCustomOrgChart.FullExpand;
begin
  FRoot.Expand(True);
end;

procedure TdxCustomOrgChart.FullCollapse;
begin
  FRoot.Collapse(True);
end;

procedure TdxCustomOrgChart.Delete(Node: TdxOcNode);
begin
  if (Node = nil) or not IsMyNode(Node) then Exit;
  if Node.Selected or ((Selected <> nil) and Selected.HasAsParent(Node)) then
  begin
    Selected := Node.GetNextSibling;
    if Selected = nil then Selected := Node.GetPrevSibling;
    if Selected = nil then Selected := Node.Parent;
  end;
  if Assigned(OnDeletion) then OnDeletion(Self, Node);
  with Node do
  begin
    HasChildren := False;
    FDeleting := True;
    Data := nil;
  end;
  with Node.FParent do
    if not Deleting then
    begin
      FList.Delete(Node.Index);
      Enumerate(Node.Index);
      InvalidateSize(ivBoth);
      if (FList.Count = 0) and (FParent <> nil) then
        FExpanded := False;
      if FList.Count = 0 then
        HasChildren := False;
    end;
  Dec(FCount);
  Node.Free;
end;

function TdxCustomOrgChart.CreateNode: TdxOcNode;
begin
  Result := TdxOcNode.Create(Self);
end;

procedure TdxCustomOrgChart.BeginUpdate;
begin
  if (FUpdate = 0) and HandleAllocated then SendMessage(Handle, WM_SETREDRAW, 0, 0);
  Inc(FUpdate);
end;

procedure TdxCustomOrgChart.EndUpdate;
begin
  if FUpdate = 0 then Exit;
  Dec(FUpdate);
  if (FUpdate = 0) and HandleAllocated then
  begin
    SendMessage(Handle, WM_SETREDRAW, 1, 0);
    FUpdated := False;
    Invalidate;
  end;
end;

procedure TdxCustomOrgChart.ChangeSize;
begin
  if FSizeChanged then Exit;
  HideEditor(True);
  Invalidate;
  FSizeChanged := True;
  FHitTests := [];
end;

procedure TdxCustomOrgChart.RecalcSizes;
begin
  if FSizeChanged then
  begin
    FSizeChanged := False;
    if FZoom = 0 then
      SetZoomRatio
    else
      UpdateScrollRange;
  end;
end;

function TdxCustomOrgChart.FullWidth: Integer;
begin
  if Rotated then
    Result := FRoot.ChildrenHeight + 6
  else
    Result := FRoot.ChildrenWidth;
end;

function TdxCustomOrgChart.FullHeight: Integer;
begin
  if Rotated then
    Result := FRoot.ChildrenWidth
  else
    Result := FRoot.ChildrenHeight + 6;
end;

procedure TdxCustomOrgChart.UpdateScrollRange;
var
  NewX, NewY: Integer;
  Info: TScrollInfo;

  function SetScr(Code, Page, Max: Integer): Integer;
  begin
    with Info do
    begin
      cbSize := SizeOf(Info);
      fMask := SIF_ALL;
      GetScrollInfo(Handle, Code, Info);
      Result := nPos;
      fMask := SIF_PAGE or SIF_RANGE;
      nMin := 0;
      nMax := Max;
      nPage := Page;
    end;
    SetScrollInfo(Handle, Code, Info, True);
  end;

begin
  if not HandleAllocated then Exit;
  NewX := SetScr(SB_HORZ, ClientWidth, FullWidth);
  NewY := SetScr(SB_VERT, ClientHeight, FullHeight);
  SetLeftTop(NewX, NewY);
end;

procedure TdxCustomOrgChart.SetLeftTop(ALeft, ATop: Integer);

  procedure Adjust(AMax: Integer; var Value: Integer);
  begin
    Value := Max(Min(Value, AMax), 0);
  end;

var
  DX, DY: Integer;
begin
  Adjust(FullWidth - ClientWidth, ALeft);
  Adjust(FullHeight - ClientHeight, ATop);
  if (ALeft = LeftEdge) and (ATop = TopEdge) then Exit;
  DX := LeftEdge - ALeft;
  DY := TopEdge - ATop;
  FLeftEdge := ALeft;
  FTopEdge := ATop;
  if not HandleAllocated then Exit;
  ScrollWindow(Handle, DX, DY, nil, nil);
  if DX <> 0 then
    SetScrollPos(Handle, SB_HORZ, ALeft, True);
  if DY <> 0 then
    SetScrollPos(Handle, SB_VERT, ATop, True);
end;

function TdxCustomOrgChart.GetLeftEdge: Integer;
begin
  if FZoom <> 0 then RecalcSizes;
  Result := FLeftEdge;
end;

function TdxCustomOrgChart.GetTopEdge: Integer;
begin
  if FZoom <> 0 then RecalcSizes;
  Result := FTopEdge;
end;

procedure TdxCustomOrgChart.SetLeftEdge(Value: Integer);
begin
  if Value <> LeftEdge then
    SetLeftTop(Value, TopEdge);
end;

procedure TdxCustomOrgChart.SetTopEdge(Value: Integer);
begin
  if Value <> TopEdge then
    SetLeftTop(LeftEdge, Value);
end;

procedure TdxCustomOrgChart.Clear;
begin
  Selected := nil;
  FRoot.DeleteChildren;
end;

function TdxCustomOrgChart.InvalidateNode(Value: TdxOcNode): Boolean;
var
  R: TRect;
  DX, DY: Word;
begin
  Result := False;
  if HandleAllocated and not IsUpdated then
  begin
    R := Value.DisplayRect;
    if R.Left = R.Right then Exit;
    if Rotated then
      Dec(R.Left, 6)
    else
      Dec(R.Top, 6);
    Result := True;
    DX := 0; DY := 0;
    if HasButton(Value) then
      if Rotated then
        DX := 6
      else
        DY := 6;
    if Value.Is3D then
    begin
      if DX < LineWidth then DX := LineWidth;
      if DY < LineWidth then DY := LineWidth;
    end;
    Inc(R.Right, DX); Inc(R.Bottom, DY);
    InflateRect(R, LineWidth, LineWidth);
    InvalidateRect(Handle, @R, True);
  end;
end;

function TdxCustomOrgChart.InvalidateSel: Boolean;
begin
  Result := (Selected <> nil) and InvalidateNode(Selected);
end;

procedure TdxCustomOrgChart.SetSelected(Value: TdxOcNode);
var
  Edit: Boolean;
begin
  if (Value = Selected) or not IsMyNode(Value) then Exit;
  Edit := Editing; HideEditor(True);
  if InvalidateSel then
  begin
    FSelected := nil;
    if (Value <> nil) and Value.IsVisible then Update;
  end;
  FSelected := Value;
  InvalidateSel;
  Editing := Edit;
  DoChange(Value);
end;

function TdxCustomOrgChart.GetFirstNode: TdxOcNode;
begin
  if Count = 0 then
    Result := nil
  else
    Result := FRoot[0];
end;

procedure TdxCustomOrgChart.HitTestsAt(X, Y: Integer);

  procedure InRect(Node: TdxOcNode; LeftX, TopY: Integer);
  var
    R, RN: TRect;
    I: Integer;

    function InFrame(Sh: TdxOcShape): Boolean;
    label
      Ell;
    var
      X0, Y0, X1, Y1, A, B: Integer;
    begin
      Result := False;

      if Sh = shRectangle then
      begin
        Result := True;
        Exit;
      end;

      case Node.ChildAlign of
        caLeft:
          begin
            X0 := 0;
            X1 := -IndentX;
          end;
        caCenter:
          begin
            X0 := IndentX shr 1;
            X1 := -(IndentX shr 1);
          end;
      else
        X0 := IndentX;
        X1 := 0;
      end;

      if Sh = shRoundRect then
      begin
        A := Node.Radius shr 1;
        Inc(X0, (R.Left + A)); Inc(X1, (R.Right - A));
        Y0 := R.Top + A + IndentY; Y1 := R.Bottom - A;
        if ((X >= X0) and (X <= X1)) or ((Y >= Y0) and (Y <= Y1)) then
        begin
          Result := True;
          Exit;
        end;
        if X > X0 then X0 := X1;
        if Y > Y0 then Y0 := Y1;
        X1 := X - X0; Y1 := Y - Y0; goto Ell;
      end;

      A := (R.Right - R.Left - IndentX) shr 1; B := (R.Bottom - R.Top - IndentY) shr 1;
      Inc(X0, (R.Left + A)); Y0 := R.Top + B + IndentY;
      X1 := Abs(X - X0); Y1 := Abs(Y - Y0);
      if Sh = shDiamond then
      begin
        if X1 * B + Y1 * A <= A * B then Result := True;
        Exit;
      end;

      if A >= B then
        Y1 := Y1 * A div B
      else
      begin
        X1 := X1 * B div A;
        A := B;
      end;
      Ell:
    if X1 * X1 + Y1 * Y1 <= A * A then Result := True;
    end;

  begin
    R.Left := LeftX; R.Top := TopY;
    R.Right := R.Left + Node.FullWidth;
    if Node = FRoot then
      R.Bottom := R.Top - 7
    else
      R.Bottom := R.Top + Node.ExtHeight + IndentY + LineWidth;
    if (X < R.Left) or (X >= R.Right) then Exit;
    if (Y >= R.Top) and (Y < R.Bottom + 6) then
    begin
      FHitTests := []; FNodeAt := Node;
      RN := R; Node.FullToDisplay(RN);
      RN.Top := RN.Top + IndentY;
      if Y < RN.Top then Include(FHitTests, htOnIndentY);
      if X < RN.Left then Include(FHitTests, htOnLeftIndentX);
      if X > RN.Right then Include(FHitTests, htOnRightIndentX);
      if FHitTests = [] then
      begin
        if Y < RN.Bottom then
        begin
          FHitTests := [htOnRect];
          if Node.Is3D then Dec(RN.Bottom, LineWidth);
          if InFrame(Node.Shape) then Include(FHitTests, htOnShape);
        end;
        if HasButton(Node) then
        begin
          I := Node.ExtWidth shr 1 - 5;
          if (X >= RN.Left + I) and (X < RN.Left + I + 11) and (Y >= RN.Bottom - 6)
            then Include(FHitTests, htOnButton);
        end;
      end;
      if (Y >= R.Bottom) and not (htOnButton in FHitTests) then FNodeAt := nil;
    end;
    if FNodeAt = nil then
    begin
      if not Node.Expanded then
      begin
        if (Y >= R.Bottom) and (Y <= R.Bottom + Node.ExtHeight) then
        begin
          FNodeAt := Node;
          FHitTests := [htUnder];
        end;
        Exit;
      end;
      R.Left := R.Left + Node.ChildOffset;
      if R.Bottom < R.Top then R.Bottom := R.Top;
      for I := 0 to Node.Count - 1 do
      begin
        InRect(Node[I], R.Left, R.Bottom);
        if FNodeAt <> nil then Exit;
        R.Left := R.Left + Node[I].FullWidth;
      end;
    end;
  end;

begin
  FNodeAt := nil;
  FHitX := X; FHitY := Y;
  RotatePoint(X, Y);
  if Rotated then
    InRect(FRoot, -TopEdge, -LeftEdge)
  else
    InRect(FRoot, -LeftEdge, -TopEdge);
  if FNodeAt = nil then FHitTests := [htNowhere];
end;

function TdxCustomOrgChart.GetNodeAt(X, Y: Integer): TdxOcNode;
begin
  if (FHitTests = []) or (X <> FHitX) or (Y <> FHitY) then HitTestsAt(X, Y);
  Result := FNodeAt;
end;

function TdxCustomOrgChart.GetHitTestsAt(X, Y: Integer): TdxOcHitTests;
begin
  if (FHitTests = []) or (X <> FHitX) or (Y <> FHitY) then HitTestsAt(X, Y);
  Result := FHitTests;
end;

procedure TdxCustomOrgChart.DoChange(Node: TdxOcNode);
begin
  if Assigned(OnChange) then OnChange(Self, Node);
end;

procedure TdxCustomOrgChart.DoChanging(Node: TdxOcNode; var Allow: Boolean);
begin
  Allow := True;
  if Assigned(OnChanging) then OnChanging(Self, Node, Allow);
end;

procedure TdxCustomOrgChart.DoNavigate(ANavigateCode: TdxOcNavigate; AValue: Integer);
var
  ANextNode: TdxOcNode;
begin
  case ANavigateCode of
    ocnLineLeft: LeftEdge := LeftEdge - OtScrollUnit;
    ocnLineUp: TopEdge := TopEdge - OtScrollUnit;
    ocnLineRight: LeftEdge := LeftEdge + OtScrollUnit;
    ocnLineDown: TopEdge := TopEdge + OtScrollUnit;
    ocnPageLeft: LeftEdge := LeftEdge - ClientWidth + OtScrollUnit;
    ocnPageUp: TopEdge := TopEdge - ClientHeight + OtScrollUnit;
    ocnPageRight: LeftEdge := LeftEdge + ClientWidth - OtScrollUnit;
    ocnPageDown: TopEdge := TopEdge + ClientHeight - OtScrollUnit;
    ocnLeft: LeftEdge := 0;
    ocnTop: TopEdge := 0;
    ocnRight: LeftEdge := FullWidth - ClientWidth;
    ocnBottom: TopEdge := FullHeight - ClientHeight;
    ocnLeftPosition: LeftEdge := AValue;
    ocnTopPosition: TopEdge := AValue;
    ocnSelectNextLeft:
      begin
        ANextNode := NextSel(GetPS);
        if ANextNode = nil then
          ANextNode := NextSel(GetPV);
        SelectNode(ANextNode);
      end;
    ocnSelectNextUp: SelectNode(NextSel(GetPV));
    ocnSelectNextRight:
      begin
        ANextNode := NextSel(GetNS);
        if ANextNode = nil then
          ANextNode := NextSel(GetNV);
        SelectNode(ANextNode);
      end;
    ocnSelectNextDown: SelectNode(NextSel(GetNV));
  end;
end;

function TdxCustomOrgChart.CanSelect(Node: TdxOcNode): Boolean;
begin
  DoChanging(Node, Result);
end;

function TdxCustomOrgChart.NextSel(Get: TdxOcNodeFunc): TdxOcNode;
begin
  if Selected = nil then
    Result := nil
  else
    Result := Get(Selected);
  while (Result <> nil) and not CanSelect(Result) do
    Result := Get(Result);
end;

procedure TdxCustomOrgChart.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
  procedure DoSelect;
  begin
    if CanSelect(FNodeAt) then Selected := FNodeAt;
  end;
begin
  if (Button = mbLeft) and not (ssDouble in Shift) then
  begin
    SetFocus;
    FDrag := True;
    GetNodeAt(X, Y);
    if FHitTests * [htOnShape, htOnButton] = [htOnShape] then DoSelect;
    if htOnButton in FHitTests then
    begin
      if (Selected <> nil) and FNodeAt.Expanded and Selected.HasAsParent(FNodeAt)
        then DoSelect;
      with FNodeAt do
        Expanded := not Expanded;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TdxCustomOrgChart.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FDrag and (ocCanDrag in Options) and not Dragging and ((Shift = [ssLeft]) or (Shift = [ssLeft, ssCtrl]))
    and (htOnShape in GetHitTestsAt(X, Y)) and (FNodeAt = Selected)
    then BeginDrag(False);
  if not Dragging then inherited MouseMove(Shift, X, Y);
end;

function TdxCustomOrgChart.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    if Shift = [] then
    begin
      DoNavigate(ocnLineDown);
      DoNavigate(ocnLineDown);
      DoNavigate(ocnLineDown);
    end
    else
      if Shift = [ssCtrl] then
        DoNavigate(ocnPageDown)
      else
        if Shift = [ssShift] then
          DoNavigate(ocnSelectNextDown);
    Result := True;
  end;
end;

function TdxCustomOrgChart.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then
  begin
    if Shift = [] then
    begin
      DoNavigate(ocnLineUp);
      DoNavigate(ocnLineUp);
      DoNavigate(ocnLineUp);
    end
    else
      if Shift = [ssCtrl] then
        DoNavigate(ocnPageUp)
      else
        if Shift = [ssShift] then
          DoNavigate(ocnSelectNextUp);
    Result := True;
  end;
end;

procedure TdxCustomOrgChart.SetTimeScroll;
begin
  if not FTimer.Enabled then FTimer.Enabled := True;
end;

procedure TdxCustomOrgChart.KillTimeScroll;
begin
  FTimer.Enabled := False;
end;

procedure TdxCustomOrgChart.TimeScroll;
var
  OldX, OldY: Integer;
begin
  OldX := LeftEdge; OldY := TopEdge;
  SetLeftTop(OldX + FScrollX, OldY + FScrollY);
  FNoScroll := (LeftEdge = OldX) and (TopEdge = OldY);
  if FNoScroll then
    KillTimeScroll
  else
    Update;
end;

procedure TdxCustomOrgChart.DoTimerScrolling(Sender: TObject);
begin
  if FTimer <> nil then
    TimeScroll;
end;

procedure TdxCustomOrgChart.DragDraw(Source: TdxCustomOrgChart);
label
  Sc;
var
  W, H, X, Y: Integer;
begin
  if FDragParent = nil then Exit;
  W := Source.Selected.Width;
  H := Source.Selected.Height;
  if not Rotated then
  begin
    X := FDragX0 + W shr 1;
    Y := FDragY1 + (FDragY0 - FDragY1) shr 1;
  end
  else
  begin
    X := FDragX1 + (FDragX0 - FDragX1) shr 1;
    Y := FDragY0 + H shr 1;
  end;
  with Canvas do
  begin
    Pen.Mode := pmNotXor;
    Pen.Width := 1;
    Pen.Style := psDot;
    Pen.Color := LineColor;
    Brush.Style := bsClear;
    ShowCursor(False);
    Rectangle(FDragX0, FDragY0, FDragX0 + W, FDragY0 + H);
    if FDragParent = FRoot then goto Sc;
    if not Rotated then
    begin
      MoveTo(X, FDragY0);
      LineTo(X, Y);
      LineTo(FDragX1, Y);
    end
    else
    begin
      MoveTo(FDragX0, Y);
      LineTo(X, Y);
      LineTo(X, FDragY1);
    end;
    LineTo(FDragX1, FDragY1);
    Sc: ShowCursor(True);
  end;
end;

function TdxCustomOrgChart.DragScroll(X, Y: Integer; St: TDragState): Boolean;
var
  NewX, NewY: Smallint;
begin
  Result := St = dsDragMove;
  if Result then
  begin
    NewX := 0; NewY := 0;
    if X <= OtScrollUnit then NewX := -OtScrollUnit;
    if X >= ClientWidth - OtScrollUnit then NewX := OtScrollUnit;
    if Y <= OtScrollUnit then NewY := -OtScrollUnit;
    if Y >= ClientHeight - OtScrollUnit then NewY := OtScrollUnit;
    if FNoScroll and (NewX = FScrollX) and (NewY = FScrollY) then
      Result := False
    else
    begin
      FScrollX := NewX; FScrollY := NewY;
      FNoScroll := False;
      Result := (NewX or NewY) <> 0;
    end;
  end;
  if Result then
    SetTimeScroll
  else
    KillTimeScroll;
end;

procedure TdxCustomOrgChart.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var
  R: TRect;
  N: TdxOcNode;
  Scrolled: Boolean;
begin
  N := nil;
  if Assigned(OnDragDrop) then
    Accept := Source is TdxCustomOrgChart
  else
    Accept := Source = Self;
  DragDraw(TdxCustomOrgChart(Source));
  Scrolled := DragScroll(X, Y, State);
  if Accept then
  begin
    N := GetNodeAt(X, Y);
    Accept := (N <> nil) and not N.HasAsParent(TdxCustomOrgChart(Source).Selected);
  end;
  if not Accept or Scrolled or not (ocShowDrag in Options) or (State <> dsDragMove)
    then
    FDragParent := nil
  else
  begin
    FDragX0 := X; FDragY0 := Y;

    if not (htUnder in FHitTests) or (N = Selected) then N := N.FParent;
    if N <> FDragParent then
    begin
      FDragParent := N;
      if N <> FRoot then
      begin
        R := N.DisplayRect;
        if not Rotated then
        begin
          FDragX1 := R.Left + (R.Right - R.Left) shr 1;
          FDragY1 := R.Bottom;
        end
        else
        begin
          FDragX1 := R.Right;
          FDragY1 := R.Top + (R.Bottom - R.Top) shr 1;
        end;
      end;
    end;
  end;
  DragDraw(TdxCustomOrgChart(Source));
  if Assigned(OnDragOver) then OnDragOver(Self, Source, X, Y, State, Accept);
end;

procedure TdxCustomOrgChart.DragDrop(Source: TObject; X, Y: Integer);
var
  Node: TdxOcNode;
  Mode: TdxOcNodeAttachMode;
begin
  KillTimeScroll;
  if Assigned(OnDragDrop) then
    OnDragDrop(Self, Source, X, Y)
  else
    if (Source = Self) and (Selected <> nil) then
    begin
      Node := GetNodeAt(X, Y);
      if Node = nil then Exit;
      Mode := naInsert;
      if htUnder in FHitTests then Mode := naAddChild;
      if (htOnRightIndentX in FHitTests) or (htOnRect in FHitTests)
        then Node := Node.GetNextSibling;
      if Node = nil then
      begin
        Node := FNodeAt.Parent;
        Mode := naAddChild;
      end;
      Selected.MoveTo(Node, Mode);
      Selected.MakeVisible;
    end;
end;

procedure TdxCustomOrgChart.DragCanceled;
begin
  KillTimeScroll;
  FDrag := False;
end;

procedure TdxCustomOrgChart.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if not Editing and (Selected <> nil) then
    case Key of
      '+': Selected.Expand(False);
      '-': Selected.Collapse(False);
    end;
end;

procedure TdxCustomOrgChart.KeyDown(var Key: Word; Shift: TShiftState);

  function InsertNode(AsChild: Boolean): TdxOcNode;
  begin
    Result := nil;
    if not (ocInsDel in Options) or (Selected = nil) and (Count > 0) then Exit;
    if AsChild or (Selected = nil) then
      Result := AddChild(Selected, nil)
    else
    begin
      Result := Selected.GetNextSibling;
      if Result = nil then
        Result := AddChild(Selected.Parent, nil)
      else
        Result := Insert(Result, nil);
    end;
  end;

begin
  inherited KeyDown(Key, Shift);
  if Shift = [ssCtrl] then
    case Key of
      VK_RIGHT: DoNavigate(ocnPageRight);
      VK_LEFT: DoNavigate(ocnPageLeft);
      VK_PRIOR: DoNavigate(ocnTop);
      VK_NEXT: DoNavigate(ocnBottom);
      VK_HOME: SetLeftTop(0, 0);
      VK_END: SetLeftTop(FullWidth, FullHeight);
      VK_INSERT: SelectNode(InsertNode(True));
    end;
  if Shift = [] then
    case Key of
      VK_NEXT: DoNavigate(ocnPageDown);
      VK_PRIOR: DoNavigate(ocnPageUp);
      VK_HOME: DoNavigate(ocnLeft);
      VK_END: DoNavigate(ocnRight);
      VK_DOWN: DoNavigate(ocnSelectNextDown);
      VK_UP: DoNavigate(ocnSelectNextUp);
      VK_ESCAPE: EndDrag(False);
      VK_INSERT: SelectNode(InsertNode(False));
      VK_DELETE:
        if ocInsDel in Options then
          Delete(Selected);
      VK_RETURN, VK_F2: ShowEditor;
      VK_RIGHT: DoNavigate(ocnSelectNextRight);
      VK_LEFT: DoNavigate(ocnSelectNextLeft);
    end;
end;

procedure TdxCustomOrgChart.SetOptions(Value: TdxOcOptions);
var
  Chgd: TdxOcOptions;
begin
  if Value <> Options then
  begin
    Chgd := (Options + Value) - (Options * Value);
    FOptions := Value;
    if ocRect3D in Chgd then InvalidateSizes(ivBoth);
    if ocButtons in Chgd then Invalidate;
    if ocSelect in Chgd then InvalidateSel;
    if (ocFocus in Chgd) and Focused then InvalidateSel;
  end;
end;

procedure TdxCustomOrgChart.SetRotated(Value: Boolean);
begin
  if Value <> Rotated then
  begin
    FRotated := Value;
    InvalidateSizes(ivBoth);
    SetLeftTop(0, 0);
  end;
end;

procedure TdxCustomOrgChart.DblClick;
begin
  if (ocDblClick in Options) and (FHitTests * [htOnShape, htOnButton] = [htOnShape])
    then
    with FNodeAt do
      Expanded := not Expanded;
  inherited DblClick;
end;

function TdxCustomOrgChart.GetZoom: Boolean;
begin
  Result := FZoom = 0;
end;

function TdxCustomOrgChart.IsZoomed: Boolean;
begin
  if FZoom = 0 then RecalcSizes;
  Result := (FZoom = 0) and (FZoomLo < FZoomHi);
end;

function TdxCustomOrgChart.GetLineWidth: Word;
begin
////  if IsZoomed then Result := 1              // Fix: by Kirill (LineWidth)
  if IsZoomed then
    Result := DoZoom(FLineWidth) // Fix: by Kirill (LineWidth)
  else
    Result := FLineWidth;
end;

function TdxCustomOrgChart.GetIndentX: Word;
begin
  if Rotated then
    Result := DoZoom(FIndentY)
  else
    Result := DoZoom(FIndentX);
end;

function TdxCustomOrgChart.GetIndentY: Word;
begin
  if Rotated then
    Result := DoZoom(FIndentX)
  else
    Result := DoZoom(FIndentY);
end;

function TdxCustomOrgChart.DoZoom(Value: Integer): Integer;
begin
  if not IsZoomed then
    Result := Value
  else
    Result := Value * FZoomLo div FZoomHi;
end;

procedure TdxCustomOrgChart.SetZoom(Value: Boolean);
begin
  if Value <> Zoom then
  begin
    FZoom := Ord(not Value);
    ChangeSize;
    if Value then UpdateScrollRange;
  end;
end;

procedure TdxCustomOrgChart.SetZoomRatio;
begin
  Inc(FZoom);
  if ClientWidth * FullHeight <= ClientHeight * FullWidth then
  begin
    FZoomLo := ClientWidth;
    FZoomHi := FullWidth + 1;
  end
  else
  begin
    FZoomLo := ClientHeight;
    FZoomHi := FullHeight + 1;
  end;
  Dec(FZoom);
end;

procedure TdxCustomOrgChart.ImageListChange(Sender: TObject);
begin
  if HandleAllocated then
  begin
    BeginUpdate;
    EndUpdate;
  end;
end;

procedure TdxCustomOrgChart.SetImages(Value: TCustomImageList);
var
  P: TPoint;
  Node: TdxOcNode;
begin
  if (Value = FImages) or (csDestroying in ComponentState) then exit;
  BeginUpdate;
  if FImages <> nil then
    FImages.UnRegisterChanges(FImagesChangeLink);

  FImages := Value;

  if Value <> nil then
  begin
    FImages.RegisterChanges(FImagesChangeLink);
    if DefaultImageAlign = iaNone then DefaultImageAlign := iaLT;
    P := MinSizes;
    if DefaultNodeWidth < P.X then DefaultNodeWidth := P.X;
    if DefaultNodeHeight < P.Y then DefaultNodeHeight := P.Y;
    Node := GetFirstNode;
    while Node <> nil do
    begin
      if (Node.FWidth <> 0) and (Node.FWidth < P.X) then Node.Width := P.X;
      if (Node.FHeight <> 0) and (Node.FHeight < P.Y) then Node.Height := P.Y;
      Node := Node.GetNext;
    end;
  end;
  EndUpdate;
end;

procedure TdxCustomOrgChart.ReadData(Stream: TStream);
var
  B: array[0..6] of AnsiChar;
begin
  Clear;
  FIsUnicode := False;
  if (Stream.Size - Stream.Position) > SizeOf(B) then
  begin
    Stream.ReadBuffer(B, SizeOf(B));
    FIsUnicode := B = StreamDescriptionUNICODE;
    if not FIsUnicode and (B <> StreamDescriptionANSI) then
      Stream.Position := Stream.Position - SizeOf(B);
  end;
  FRoot.ReadChildren(Stream);
end;

procedure TdxCustomOrgChart.WriteData(Stream: TStream);
begin
{$IFNDEF STREAMANSIFORMAT}
  {$IFDEF DELPHI12}
      Stream.WriteBuffer(StreamDescriptionUNICODE[1], StrLen(PAnsiChar(StreamDescriptionUNICODE)));
  {$ELSE}
      Stream.WriteBuffer(StreamDescriptionANSI[1], Length(StreamDescriptionANSI));
  {$ENDIF}
{$ENDIF}
  FRoot.WriteChildren(Stream);
end;

procedure TdxCustomOrgChart.AssignData(Source: TdxCustomOrgChart);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    Source.WriteData(Stream);
    Stream.Position := 0;
    Clear;
    ReadData(Stream);
    if Count > 0 then Selected := Items[0];
  finally
    Stream.Free;
  end;
end;

procedure TdxCustomOrgChart.Loaded;
begin
  inherited Loaded;
  if csDesigning in ComponentState then FullExpand;
end;

function TdxCustomOrgChart.CreateEditor: TdxOcInplaceEdit;
begin
  Result := TdxOcInplaceEdit.Create(Self);
end;

function TdxCustomOrgChart.GetEditing: Boolean;
begin
  Result := (FEditor <> nil) and FEditor.Visible;
end;

procedure TdxCustomOrgChart.SetEditing(Value: Boolean);
begin
  if Value then
    ShowEditor
  else
    HideEditor(True);
end;

procedure TdxCustomOrgChart.HideEditor(Save: Boolean);
var
  Focus: Boolean;
  TheText: string;
begin
  if not Editing then Exit;
  Focus := FEditor.Focused;
  if Save and FEditor.Modified then
  begin
    TheText := FEditor.Text;
    if Assigned(OnEdited) then OnEdited(Self, Selected, TheText);
    Selected.Text := TheText;
  end;
  FEditor.Hide;
  if Focus then SetFocus;
end;

procedure TdxCustomOrgChart.ShowEditor;
var
  R: TRect;
  Allow: Boolean;
begin
  if not (ocEdit in Options) or Editing or IsZoomed or (Selected = nil) then Exit;
  Allow := True;
  if Assigned(OnEditing) then OnEditing(Self, Selected, Allow);
  if not Allow then Exit;
  Selected.MakeVisible;
  if FEditor = nil then FEditor := CreateEditor;
  R := Selected.ClientRect;
  Selected.ClientToText(R);
  with FEditor do
  begin
    BoundsRect := R;
    ClientWidth := R.Right - R.Left;
    ClientHeight := R.Bottom - R.Top;
    FMinW := Canvas.TextWidth('W'); FMinH := Canvas.TextHeight('W');
    FMaxW := Screen.Width shr 1; FMaxH := Screen.Height shr 1;
    if FMaxW < FMinW then FMaxW := FMinW;
    if FMaxH < FMinH then FMaxH := FMinH;
    Color := Selected.Color;
    Font := Self.Font;
    Selected.SetFont(Font);
    Text := Selected.GetText;
    SelStart := 0; SelLength := 0;
    Modified := False;
    AdjustBounds;
    Show;
    SetFocus;
  end;
end;

procedure TdxCustomOrgChart.SetEditMode(Value: TdxOcEditMode);
begin
  if Value <> EditMode then
  begin
    FEditMode := Value;
    if FEditor <> nil then FEditor.RecreateWnd;
    if Count > 0 then Invalidate;
  end;
end;

procedure TdxCustomOrgChart.NodeChanged(Node: TdxOcNode);
begin
end;

procedure TdxCustomOrgChart.SelectNode(ANode: TdxOcNode);
begin
  if ANode <> nil then
  begin
    Selected := ANode;
    Selected.MakeVisible;
  end;
end;

procedure TdxCustomOrgChart.DefineProperties(Filer: TFiler);
begin
  Inc(FZoom);
  inherited DefineProperties(Filer);
  Dec(FZoom);
end;

procedure TdxCustomOrgChart.WMHScroll(var Msg: TWMHScroll);
const
  ACodeMap: array[0..7] of TdxOcNavigate = (ocnLineLeft, ocnLineRight, ocnPageLeft, ocnPageRight, ocnLeftPosition, ocnLeftPosition, ocnLeft, ocnRight);
var
  AScrollInfo: TScrollInfo;
begin
  if Msg.ScrollCode < 8 then
  begin
    AScrollInfo.cbSize := SizeOf(AScrollInfo);
    AScrollInfo.fMask := SIF_TRACKPOS;
    GetScrollInfo(Handle, SB_HORZ, AScrollInfo);
    DoNavigate(ACodeMap[Msg.ScrollCode], AScrollInfo.nTrackPos);
  end;
end;

procedure TdxCustomOrgChart.WMVScroll(var Msg: TWMVScroll);
const
  ACodeMap: array[0..7] of TdxOcNavigate = (ocnLineUp, ocnLineDown, ocnPageUp, ocnPageDown, ocnTopPosition, ocnTopPosition, ocnTop, ocnBottom);
var
  AScrollInfo: TScrollInfo;
begin
  if Msg.ScrollCode < 8 then
  begin
    AScrollInfo.cbSize := SizeOf(AScrollInfo);
    AScrollInfo.fMask := SIF_TRACKPOS;
    GetScrollInfo(Handle, SB_VERT, AScrollInfo);
    DoNavigate(ACodeMap[Msg.ScrollCode], AScrollInfo.nTrackPos);
  end;
end;

procedure TdxCustomOrgChart.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  InvalidateSel;
end;

procedure TdxCustomOrgChart.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  InvalidateSel;
end;

procedure TdxCustomOrgChart.WMSize(var Msg: TWMSize);
var
  PrevZoom: Boolean;
begin
  if GetEditing then HideEditor(False); // Fix: by Kirill (ModalWindow)
  inherited;
  if (Msg.SizeType = SIZE_MAXIMIZED) or (Msg.SizeType = SIZE_RESTORED) then
  begin
    PrevZoom := IsZoomed;
    FSizeChanged := True;
    RecalcSizes;
    if PrevZoom or IsZoomed then Invalidate;
  end;
end;

procedure TdxCustomOrgChart.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  Msg.Result := Msg.Result or DLGC_WANTARROWS;
end;

procedure TdxCustomOrgChart.WMDblClk(var Msg: TWMMouse);
begin
  if ocDblClick in Options then GetNodeAt(Msg.XPos, Msg.YPos);
  inherited;
end;

procedure TdxCustomOrgChart.WMErase(var Msg: TWMEraseBkgnd);
begin
  RecalcSizes;
  Msg.Result := 1;
end;

procedure TdxCustomOrgChart.CMCtl3DChanged(var Msg: TMessage);
begin
  inherited;
  if BorderStyle = bsSingle then RecreateWnd;
end;

procedure TdxCustomOrgChart.SaveToFile(const AFileName: string);
var
  AStream : TMemoryStream;
begin
  AStream := TMemoryStream.Create;
  SaveToStream(AStream);
  try
    AStream.SaveToFile(AFileName);
  finally
    AStream.Free;
  end;
end;

procedure TdxCustomOrgChart.SaveToStream(AStream: TStream);
begin
  WriteData(AStream);
end;

{ TdxOrgChart }

procedure TdxOrgChart.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Items', ReadData, WriteData, Count > 0);
end;

procedure TdxOrgChart.LoadFromFile(const AFileName: string);
var
  AStream : TMemoryStream;
begin
  AStream := TMemoryStream.Create;
  try
    AStream.LoadFromFile(AFileName);
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxOrgChart.LoadFromStream(AStream: TStream);
begin
  ReadData(AStream);
end;

end.

