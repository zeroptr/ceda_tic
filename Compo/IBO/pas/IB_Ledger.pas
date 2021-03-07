{                                                                              }

{***************************************************************}
{                                                               }
{          IB Objects Components and Resources Library          }
{                                                               }
{          Copyright (C) 1996-2001 Jason Wharton                }
{          and Computer Programming Solutions, Mesa, AZ         }
{                                                               }
{  This source code unit is released under the terms of the     }
{  CPS Trustware License.                                       }
{  It may be distributed or deployed as source code or in       }
{  compiled form only in compliance with the terms and          }
{  conditions of the CPS Trustware License which may be         )
{  examined at http://www.ibobjects.com/ibo_trustware.html      )
{                                                               }
{***************************************************************}

{******************************************************************************}
{  CONTRIBUTED MODIFICATIONS                                                   }
{  Additions or modifications listed below using format:                       }
{                                                                              }
{  Joe Citizen <joe@joecitizen.com>                                            }
{  mm/dd/yyyy                                                                  }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{            Copyright (C) 2001 Joe Citizen                                    }
{                                                                              }
{------------------------------------------------------------------------------}
{  Place your credits and information in the top of the section                }
{  below with any other descriptions or explanations desired.                  }
{------------------------------------------------------------------------------}
{                                                                              }
{  Dirk Schiffler                                                              }
{  11/08/2001                                                                  }
{     Compile error in procedure TIB_Ledger.WMVScroll                          }
{     - can't left side assigned a value                                       }
{       variable 'offset' must declared as var not as const                    }
{                                                                              }
{  TIB_Ledger - Modified and included with permission by Jason Wharton of CPS.

   Original control:

   TDBLedger
   ©Copyright 1997, P&R Software, Inc.

   - Data Aware
   - Split database row into multiple display rows (subrows)
   - Different colors for each subrow
   - Title click event monitoring w/ optional sort direction indicator
   - Cell Auto-Sizing to fill width of ledger
   - Horizontal/Vertical Line drawing switches
   - OnDrawEvent to override drawing of cell

   -----------------------------------------------------------------------------
   -vendor code modification, Daniel Puckett
    all new properties default to False, disabling new code for compatability.
    search for vcm1, vcm2, vcm3 code blocks.
   -----------------------------------------------------------------------------
   vcm1: modified procedure TIB_Ledger.WMVScroll to scroll grid with the
         scrollbar.
   properties:
         dpGridInSyncWithScrollBar: activates code modification.
         dpdpKeepDatasetOnValidRow: prevent scroll past end of data or before
                                    start of data. Also affects vcm2
   -----------------------------------------------------------------------------
   vcm2: modified procedure TIB_Ledger.LinkActive to seek to last row then
         sets to BEFORE first row or FIRSTROW if dpdpKeepDatasetOnValidRow is
         True on query open.
   properties:
         dpReadEntireDatasetOnOpen: activates code modification.
         dpdpKeepDatasetOnValidRow: determines before FIRST or BEFORE FIRST.
                                    Also affects vcm1
   -----------------------------------------------------------------------------
   vcm3: modified procedure TIB_Ledger.UpdateScrollbar to always show an
         active scrollbar.
   property:
         dpAlwaysShowScrollBar: activates code modification.
   -----------------------------------------------------------------------------
   vcm1 & 2 & 3: tested only with:
         Delphi5, WinNT 4(sp5), TIB_Query, TIB_DataSource (version 3.5)
   -----------------------------------------------------------------------------
   Daniel Puckett, Distributel Communications Ltd.
   Toronto, Ontario, Canada
   dpuckett@distributel.ca
   -----------------------------------------------------------------------------
}
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_Ledger;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, IB_Components, StdCtrls, Buttons;

const
  DefaultRowHeight = 15;

type

TIB_LedgerWidthType = ( laFixed, laVariable );  { ledger alignment }
TIB_LedgerDirection = ( diNone, diUp, diDown ); { sort direction }

{ forward declarations }
TIB_Ledger = class;
TIB_LedgerCellDefs = class;
TIB_LedgerRowDefItem = class;
TIB_LedgerRowDefs = class;

{ Cell defintion item }
TIB_LedgerCellDefItem = class(TCollectionItem)
private
  { property values }
  FFieldName: string;
  FWidthType: TIB_LedgerWidthType;
  FWidth: integer;
  FAlignment: TAlignment;
  FTitleAlignment : TAlignment;
  FAllowClickTitle: Boolean;
  FIndicateSort: Boolean;
  { internal work variables }
  FCellRect: TRect;
  FActualWidth: longint;
  FLedger: TIB_Ledger;
  FField: TIB_Column;
  FDispName: string;
  FTitleDown: boolean;
  FSortDirection: TIB_LedgerDirection;
  FVisible: Boolean;
  procedure SetAllowClickTitle( Value: boolean );
  procedure SetIndicateSort( Value: boolean );
  procedure SetWidthType( Value: TIB_LedgerWidthType );
  procedure SetWidth( Value: Integer );
  procedure SetColumnName( Value: String );
  procedure SetDispName( Value: String );
  procedure SetAlignment( Value: TAlignment );
  procedure SetTitleAlignment(Value: TAlignment);
  procedure SetSortDirection( Value: TIB_LedgerDirection );
  procedure SetVisible( Value: boolean );
  function  GetColumn: TIB_Column;
  procedure SetColumn( Value: TIB_Column );
public
  constructor Create( Collection: TCollection ); override;
  destructor Destroy; override;
  procedure Assign( Source: TPersistent ); override;
  function ActualWidth: longint;
  function CellRect: TRect;
  property SortDirection: TIB_LedgerDirection read FSortDirection
                                              write SetSortDirection
                                              default diNone;
  property Field: TIB_Column read GetColumn write SetColumn;
published
  property AllowClickTitle: boolean read FAllowClickTitle
                                    write SetAllowClickTitle
                                    default false;
  property IndicateSort: boolean read FIndicateSort
                                 write SetIndicateSort
                                 default false;
  property WidthType: TIB_LedgerWidthType read FWidthType
                                          write SetWidthType
                                          default laVariable;
  property Width: integer read FWidth write SetWidth;
  property FieldName: string read FFieldName write SetColumnName;
  property DispName: string read FDispName write SetDispName;
  property Alignment: TAlignment read FAlignment
                                 write SetAlignment
                                 default taLeftJustify;
  property TitleAlignment : TAlignment read FTitleAlignment
                                        write SetTitleAlignment
                                        default taLeftJustify;
  property Visible: boolean read FVisible
                            write SetVisible
                            default true;
end;

{ Collection of cells }
TIB_LedgerCellDefs = class(TCollection)
private
  FRowDefItem: TIB_LedgerRowDefItem;
  FLedger: TIB_Ledger;
  function GetCellDefItem(Index: Integer): TIB_LedgerCellDefItem;
  procedure SetCellDefItem(Index: Integer; Value: TIB_LedgerCellDefItem);
public
  constructor Create(RowDefItem: TIB_LedgerRowDefItem);
  destructor Destroy; override;
  function Add: TIB_LedgerCellDefItem;
  procedure Delete(Index: integer);
  procedure Move(CurIndex,NewIndex: integer);
  function GetOwner: TPersistent; override;
  property Items[Index: Integer]: TIB_LedgerCellDefItem read GetCellDefItem
                                                        write SetCellDefItem;
                                                        default;
published
end;

{ Row definition item }
TIB_LedgerRowDefItem = class(TCollectionItem)
private
  FColor: TColor;
  FCellDefs: TIB_LedgerCellDefs;
  FRowName: string;
  FLedger: TIB_Ledger;
protected
  procedure SetCellDefs(Value: TIB_LedgerCellDefs);
  procedure SetColor(Value: TColor);
  procedure SetRowName(Value: String);
public
  constructor Create(Collection: TCollection); override;
  destructor Destroy; override;
  procedure Assign(Source: TPersistent); override;
  property RowName: string read FRowName write SetRowName;
published
  property CellDefs: TIB_LedgerCellDefs read FCellDefs write SetCellDefs;
  property Color: TColor read FColor write SetColor default clWindow;
end;

{ Collection of rows }
TIB_LedgerRowDefs = class(TCollection)
private
  FLedger: TIB_Ledger;
  function GetRowDefItem(Index: Integer): TIB_LedgerRowDefItem;
  procedure SetRowDefItem(Index: Integer; Value: TIB_LedgerRowDefItem);
public
  constructor Create(Ledger: TIB_Ledger);
  destructor Destroy; override;
  function Add: TIB_LedgerRowDefItem;
  procedure Delete(Index: integer);
  procedure Move(CurIndex,NewIndex: integer);
  function GetOwner: TPersistent; override;
  property Items[Index: Integer]: TIB_LedgerRowDefItem read GetRowDefItem
                                                       write SetRowDefItem;
                                                       default;
published
end;

{ Ledger data link }
TIB_LedgerDataLink = class(TIB_DataLink)
private
  FLedger: TIB_Ledger;
  FFieldCount: Integer;
  FModified: Boolean;
  FSparseMap: Boolean;
public
  procedure ActiveChanged; override;
  procedure DataSetChanged; override;
  procedure SysDataChange( AField: TIB_Column ); override;
  procedure EditingChanged; override;
  procedure RecordChanged( Field: TIB_Column ); override;
public
  constructor Create( ALedger: TComponent ); override;
  procedure Modified;
  procedure Reset; override;
  property FieldCount: Integer read FFieldCount;
  property SparseMap: boolean read FSparseMap write FSparseMap;
end;

TLedgerDrawState = set of ( ldSelected, ldFocused, ldFixed );
TIB_LedgerClickTitleEvent = procedure ( Cell: TIB_LedgerCellDefItem ) of object;
TIB_LedgerClickCellEvent = procedure ( Row: Integer;
                                       Cell: TIB_LedgerCellDefItem ) of object;
TDrawLedgerCellEvent = procedure ( Sender: TObject;
                                   RowDefNum, CellDefNum: integer;
                                   Row: Longint;
                                   Rect: TRect;
                                   State: TLedgerDrawState;
                                   var Handled: boolean ) of object;

TIB_Ledger = class(TCustomControl)
private
  FBorderStyle: TBorderStyle;
  FInLayout: boolean;
  FRowHeight: integer;
  FFullRowHeight: integer;
  FVisibleRowCount: integer;
  FDataLink: TIB_LedgerDataLink;
  FRowDefs: TIB_LedgerRowDefs;
  FIndicatorWidth: integer;
  FIndicatorColor: TColor;
  FCurrentRowColor: TColor;
  FOnClickTitle: TIB_LedgerClickTitleEvent;
  FOnClickCell: TIB_LedgerClickCellEvent;
  FHorizontalLines: Boolean;
  FVerticalLines: Boolean;
  ClickingCell: TIB_LedgerCellDefItem;
  ClickingRow: integer;
  FOnDrawCell: TDrawLedgerCellEvent;
  FIndicateTitles: boolean;
  FTopRow: longint;

{-----------------------------------------------------------------------------
  vcm1: vcm2: vcm3: Daniel Puckett 2000 08 15
-----------------------------------------------------------------------------}
  FdpGridInSyncWithScrollBar: boolean;
  FdpKeepDatasetOnValidRow  : boolean;
  FdpReadEntireDatasetOnOpen: boolean;
  FdpAlwaysShowScrollBar    : boolean;
  FTrackWithScrollBar: boolean;
  FScrollTowards_BOF_EOF: boolean;
{-----------------------------------------------------------------------------
  /vcm1: /vcm2: /vcm3: Daniel Puckett 2000 08 15
-----------------------------------------------------------------------------}
{$IFDEF IBO_VCL60_OR_GREATER}
  {UNICODE - Property , conversation from UTF8 do (wide)string}
  FCONVERTFROMUTF8:boolean;
{$ENDIF}
  procedure ClearSortDirection;
  function GetDataSource: TIB_DataSource;
  procedure AdjustLayout;
  procedure InvalidateFocusRect;
  procedure SetHorizontalLines(Value: Boolean);
  procedure SetVerticalLines(Value: Boolean);
  procedure SetBorderStyle(Value: TBorderStyle);
  procedure SetDataSource(Value: TIB_DataSource);
  procedure SetIndicatorWidth(Value: integer);
  procedure SetIndicatorColor(Value: TColor);
  procedure SetCurrentRowColor(Value: TColor);
  procedure SetRowHeight(Value: Integer);
  procedure SetIndicateTitles(Value: Boolean);
  procedure SetTopRow( AValue: longint );
  procedure DataChanged;
  procedure UpdateScrollbar;
  procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
  procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  procedure WMLButtonDblClk(var Message: TWMLButtonDown);
                                                       message WM_LBUTTONDBLCLK;
  procedure WMSize(var Message: TWMSize);  message WM_SIZE;
  procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
  procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
  procedure ScrollRecordPointer( Direction: longint );
  procedure UpdateFields;
  procedure UpdateActive;
  procedure WhichCell(     X,Y: longint;
                       var Cell: TIB_LedgerCellDefItem;
                       var Row: longint );
protected
  CurRow: longint;
  FixedRows: integer;
  procedure ClickCell( Row: Integer; Cell: TIB_LedgerCellDefItem ); dynamic;
  procedure ClickTitle( Cell: TIB_LedgerCellDefItem ); dynamic;
  procedure CreateParams( var Params: TCreateParams ); override;
  procedure CreateWindowHandle( const Params: TCreateParams ); override;
  procedure EditingChanged;
  procedure KeyDown( var Key: Word; Shift: TShiftState ); override;
  procedure LinkActive; virtual;
  procedure MouseDown( Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer ); override;
  procedure MouseUp( Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer ); override;
  procedure Notification( AComponent: TComponent;
                          Operation: TOperation ); override;
  procedure Paint; override;
  procedure RecordChanged( Field: TIB_Column );
  procedure SetRowDefs( Value: TIB_LedgerRowDefs );
{}
  function GetGridRow( ARow: integer ): integer;
{}
public
  property Canvas;
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
  function FindCell(Value: string): TIB_LedgerCellDefItem;
  function FullRowHeight: Integer;
  procedure InvalidateLedger;
  function VisibleRowCount: integer;
  property TopRow: longint read FTopRow write SetTopRow;
published

{-----------------------------------------------------------------------------
  vcm1: vcm2: vcm3: Daniel Puckett 2000 08 15
-----------------------------------------------------------------------------}
  property dpGridInSyncWithScrollBar:boolean read FdpGridInSyncWithScrollBar
                                            write FdpGridInSyncWithScrollBar
                                          default False;
  property dpKeepDatasetOnValidRow  :boolean read FdpKeepDatasetOnValidRow
                                            write FdpKeepDatasetOnValidRow
                                          default False;
  property dpReadEntireDatasetOnOpen:boolean read FdpReadEntireDatasetOnOpen
                                            write FdpReadEntireDatasetOnOpen
                                          default False;
  property dpAlwaysShowScrollBar    :boolean read FdpAlwaysShowScrollBar
                                            write FdpAlwaysShowScrollBar
                                          default False;
{-----------------------------------------------------------------------------
  /vcm1: /vcm2: /vcm3: Daniel Puckett 2000 08 15
-----------------------------------------------------------------------------}
  property TrackWithScrollBar: boolean read FTrackWithScrollBar
                                       write FTrackWithScrollBar
                                       default True;
  property ScrollTowards_BOF_EOF: boolean read FScrollTowards_BOF_EOF
                                          write FScrollTowards_BOF_EOF
                                          default False;
{$IFDEF IBO_VCL60_OR_GREATER}
{UNICODE - Property , conversation from UTF8 do (wide)string}
  property CONVERTFROMUTF8: boolean read FCONVERTFROMUTF8
                                    write FCONVERTFROMUTF8
                                    default False;
{$ENDIF}
  property DataSource: TIB_DataSource read GetDataSource write SetDataSource;
  property HorizontalLines: boolean read FHorizontalLines
                                    write SetHorizontalLines
                                    default true;
  property IndicatorWidth: integer read FIndicatorWidth
                                   write SetIndicatorWidth
                                   default 1;
  property IndicatorColor: TColor read FIndicatorColor
                                  write SetIndicatorColor
                                  default clBlack;
  property CurrentRowColor: TColor read FCurrentRowColor
                                   write SetCurrentRowColor
                                   default clWhite;
  property OnClickTitle: TIB_LedgerClickTitleEvent read FOnClickTitle
                                                   write FOnClickTitle;
  property OnClickCell: TIB_LedgerClickCellEvent read FOnClickCell
                                                 write FOnClickCell;
  property OnDrawCell: TDrawLedgerCellEvent read FOnDrawCell
                                            write FOnDrawCell;
  property RowDefs: TIB_LedgerRowDefs read FRowDefs write SetRowDefs;
  property RowHeight: Integer read FRowHeight write SetRowHeight;
  property VerticalLines: boolean read FVerticalLines
                                  write SetVerticalLines
                                  default true;
  property BorderStyle: TBorderStyle read FBorderStyle
                                     write SetBorderStyle
                                     default bsSingle;
  property IndicateTitles: boolean read FIndicateTitles
                                   write SetIndicateTitles
                                   default true;
  property Align;
{$IFDEF IBO_VCL40_OR_GREATER}
  property Anchors;
{$ENDIF}
  property Color;
  property Ctl3D;
  property DragCursor;
  property DragMode;
  property Enabled;
  property Font;
  property ParentColor default False;
  property ParentCtl3D;
  property ParentFont;
  property ParentShowHint;
  property PopupMenu;
  property ShowHint;
  property TabOrder;
  property TabStop default True;
  property Visible;
{ property OnClick; }
  property OnDblClick;
  property OnDragDrop;
  property OnDragOver;
  property OnEndDrag;
  property OnEnter;
  property OnExit;
  property OnKeyDown;
  property OnKeyPress;
  property OnKeyUp;
{ property OnMouseDown; }
  property OnMouseMove;
{ property OnMouseUp; }
{ property OnStartDrag; }
end;

var
  UpBitmap, DownBitmap, DotBitmap: TBitmap;

implementation

{$R IB_LEDGER.RES}

{ TIB_LedgerCellDefItem }

procedure TIB_LedgerCellDefItem.SetColumn( Value: TIB_Column );
begin
  FField := Value;
end;

function TIB_LedgerCellDefItem.GetColumn: TIB_Column;
begin
  if FField = nil then
    if (FLedger.FDataLink.BufferActive) and (Length(FieldName) > 0) then
      FField := FLedger.FDataLink.DataSet.FindField( FieldName );
  Result := FField;
end;

procedure TIB_LedgerCellDefItem.SetVisible( Value: boolean );
begin
  if FVisible <> Value then begin
    FVisible := Value;
    FLedger.InvalidateLedger;
  end;
end;

procedure TIB_LedgerCellDefItem.SetSortDirection( Value: TIB_LedgerDirection );
{
var
    R: TRect;
}
begin
  FSortDirection := Value;
{
  R := CellRect;
  Inc(R.Left);
  Inc(R.Right);
  Inc(R.Top);
  Inc(R.Bottom);
  FLedger.InvalidateRect(Handle,@R,false);
}
end;

procedure TIB_LedgerCellDefItem.SetAllowClickTitle( Value: boolean );
begin
  FAllowClickTitle := Value;
end;

procedure TIB_LedgerCellDefItem.SetIndicateSort( Value: boolean );
begin
  FIndicateSort := Value;
end;

function TIB_LedgerCellDefItem.ActualWidth: longint;
begin
  Result := FActualWidth;
end;

function TIB_LedgerCellDefItem.CellRect: TRect;
begin
  Result := FCellRect;
end;

procedure TIB_LedgerCellDefItem.SetWidthType( Value: TIB_LedgerWidthType );
begin
  if FWidthType <> Value then
  begin
    FWidthType := Value;
    FLedger.InvalidateLedger;
  end;
end;

procedure TIB_LedgerCellDefItem.SetWidth(Value: integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    FLedger.InvalidateLedger;
  end;
end;

procedure TIB_LedgerCellDefItem.SetColumnName(Value: string);
begin
  if FFieldName <> Value then
  begin
    FFieldName := Value;
    FLedger.InvalidateLedger;
  end;
end;

procedure TIB_LedgerCellDefItem.SetDispName(Value: string);
begin
  if FDispName <> Value then
  begin
    FDispName := Value;
    FLedger.InvalidateLedger;
  end;
end;

procedure TIB_LedgerCellDefItem.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    FLedger.InvalidateLedger;
  end;
end;

procedure TIB_LedgerCellDefItem.SetTitleAlignment(Value: TAlignment);
begin
  if FTitleAlignment <> Value then
  begin
    FTitleAlignment := Value;
    FLedger.InvalidateLedger;
  end;
end;

procedure TIB_LedgerCellDefItem.Assign( Source: TPersistent );
var
  SourceCellDefItem: TIB_LedgerCellDefItem;
begin
  if Source is TIB_LedgerCellDefItem then
  begin
    SourceCellDefItem := TIB_LedgerCellDefItem( Source );
    WidthType := SourceCellDefItem.WidthType;
    Width := SourceCellDefItem.Width;
    Alignment := SourceCellDefItem.Alignment;
    TitleAlignment := SourceCellDefItem.TitleAlignment;
    FieldName := SourceCellDefItem.FieldName;
    DispName := SourceCellDefItem.DispName;
    AllowClickTitle := SourceCellDefItem.AllowClickTitle;
    SortDirection := SourceCellDefItem.SortDirection;
    IndicateSort := SourceCellDefItem.IndicateSort;
    Visible := SourceCellDefItem.Visible;
    FField := nil;
  end
  else
    inherited Assign( Source );
end;

constructor TIB_LedgerCellDefItem.Create( Collection: TCollection );
begin
  inherited Create( Collection );
  FLedger := TIB_LedgerCellDefs( Collection ).FLedger;
  FWidthType := laVariable;         { set the default cell alignment }
  FWidth := 100;                    { set the default width }
  FAlignment := taLeftJustify;      { set the default alignment for the field }
  FTitleAlignment := taLeftJustify; { set the default alignment for the field }
  FField := nil;
  FTitleDown := false;
  FAllowClickTitle := false;
  FIndicateSort := false;
  FSortDirection := diNone;
  FVisible := true;
end;

destructor TIB_LedgerCellDefItem.Destroy;
begin
  inherited Destroy;
end;

{ TIB_LedgerCellDefs }

function TIB_LedgerCellDefs.GetOwner: TPersistent;
begin
  Result := TPersistent( FRowDefItem );
end;

constructor TIB_LedgerCellDefs.Create( RowDefItem: TIB_LedgerRowDefItem );
begin
  inherited Create( TIB_LedgerCellDefItem );
  FLedger := RowDefItem.FLedger;
  FRowDefItem := RowDefItem;  { set the parent }
  Add;                        { there will always be at least one cell }
end;

destructor TIB_LedgerCellDefs.Destroy;
begin
  inherited Destroy;          { call the ancestor destroy }
end;

function TIB_LedgerCellDefs.Add: TIB_LedgerCellDefItem;
begin
  Result := TIB_LedgerCellDefItem( inherited Add );   { Create a new cell def }
end;

function TIB_LedgerCellDefs.GetCellDefItem(
                                        Index: Integer ): TIB_LedgerCellDefItem;
begin
  Result := TIB_LedgerCellDefItem( inherited Items[ Index ] );
end;

procedure TIB_LedgerCellDefs.SetCellDefItem( Index: Integer;
                                             Value: TIB_LedgerCellDefItem );
begin
  TIB_LedgerCellDefItem( inherited Items[ Index ] ).Assign( Value );
end;

procedure TIB_LedgerCellDefs.Delete( Index: integer );
var
  item: TIB_LedgerCellDefItem;
begin
  item := Items[ Index ];
  item.Collection := nil;
  item.Free;
end;

procedure TIB_LedgerCellDefs.Move( CurIndex, NewIndex: integer );
begin
  Items[ CurIndex ].Index := NewIndex;
end;

{ TIB_LedgerRowDefItem }

procedure TIB_LedgerRowDefItem.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FLedger.InvalidateLedger;
  end;
end;

procedure TIB_LedgerRowDefItem.SetRowName(Value: string);
begin
  FRowName := Value;
end;

procedure TIB_LedgerRowDefItem.SetCellDefs(Value: TIB_LedgerCellDefs);
begin
  FCellDefs.Assign( Value );
end;

procedure TIB_LedgerRowDefItem.Assign(Source: TPersistent);
var
  SourceRowDefItem: TIB_LedgerRowDefItem;
begin
  if Source is TIB_LedgerRowDefItem then
  begin
    SourceRowDefItem := TIB_LedgerRowDefItem( Source );
    CellDefs.Assign( SourceRowDefItem.CellDefs );
    Color := SourceRowDefitem.Color;
    RowName := SourceRowDefItem.RowName;
  end
  else inherited Assign( Source );
end;

constructor TIB_LedgerRowDefItem.Create(Collection: TCollection);
begin
  inherited Create( Collection );                { call the ancestor create }
  FLedger := TIB_LedgerRowDefs( Collection ).FLedger;
  FColor := $00D0F8D0;                           { set the default color }
  FCellDefs := TIB_LedgerCellDefs.Create( self );{ create the cell defs object }
  FRowName := 'Row ' + IntToStr( Index );
end;

destructor TIB_LedgerRowDefItem.Destroy;
begin
  FCellDefs.Free; FCellDefs := nil;
  inherited Destroy;
end;

{ TIB_LedgerRowDefs }

function TIB_LedgerRowDefs.GetOwner: TPersistent;
begin
  Result := TPersistent( FLedger );
end;

procedure TIB_LedgerRowDefs.Delete( Index: integer );
var
  item: TIB_LedgerRowDefItem;
begin
  item := Items[ Index ];
  item.Collection := nil;
  item.Free;
end;

procedure TIB_LedgerRowDefs.Move( CurIndex, NewIndex: integer );
begin
  Items[ CurIndex ].Index := NewIndex;
end;

constructor TIB_LedgerRowDefs.Create( Ledger: TIB_Ledger );
begin
  inherited Create( TIB_LedgerRowDefItem );
  FLedger := Ledger;               { set the ledger this is doing the work for }
  Add;                             { there will always be at least one row }
end;

destructor TIB_LedgerRowDefs.Destroy;
begin
  inherited Destroy;
end;

function TIB_LedgerRowDefs.Add: TIB_LedgerRowDefItem;
begin
  Result := TIB_LedgerRowDefItem( inherited Add );{ create row pointing to self}
end;

function TIB_LedgerRowDefs.GetRowDefItem(Index: Integer ): TIB_LedgerRowDefItem;
begin
  Result := TIB_LedgerRowDefItem( inherited Items[Index] );
end;

procedure TIB_LedgerRowDefs.SetRowDefItem( Index: Integer;
                                           Value: TIB_LedgerRowDefItem );
begin
  inherited Items[Index] := Value;
end;

{ TIB_LedgerDataLink }

constructor TIB_LedgerDataLink.Create( ALedger: TComponent );
begin
  inherited Create( ALedger );
  FLedger := TIB_Ledger( ALedger );
end;

procedure TIB_LedgerDataLink.ActiveChanged;
begin
  FLedger.LinkActive;
end;

procedure TIB_LedgerDataLink.DataSetChanged;
begin
  if Assigned( FLedger ) then
    FLedger.DataChanged;
  FModified := false;
end;

procedure TIB_LedgerDataLink.SysDataChange( AField: TIB_Column );
begin
  if Assigned( FLedger ) then
    FLedger.DataChanged;
  FModified := false;
end;

procedure TIB_LedgerDataLink.EditingChanged;
begin
  FLedger.EditingChanged;
end;

procedure TIB_LedgerDataLink.Modified;
begin
  FModified := True;
end;

procedure TIB_LedgerDataLink.RecordChanged( Field: TIB_Column );
begin
  FLedger.RecordChanged( Field );
  FModified := False;
end;

procedure TIB_LedgerDataLink.Reset;
begin
  if FModified then
    RecordChanged( nil )
  else
    Dataset.Cancel;
end;

{ TIB_Ledger }

function TIB_Ledger.FindCell( Value: string ): TIB_LedgerCellDefItem;
var
  i, j: integer;
begin
  Result := nil;
  for i := 0 to RowDefs.Count - 1 do
    for j := 0 to RowDefs[ i ].CellDefs.Count - 1 do
      if CompareText( RowDefs[ i ].CellDefs[ j ].FieldName, Value ) = 0 then
      begin
        Result := RowDefs[ i ].CellDefs[ j ];
        Exit;
      end;
end;

procedure TIB_Ledger.SetHorizontalLines(Value: Boolean);
begin
  if FHorizontalLines <> Value then
  begin
    FHorizontalLines := Value;
    InvalidateLedger;
  end;
end;

procedure TIB_Ledger.SetVerticalLines(Value: Boolean);
begin
  if FVerticalLines <> Value then
  begin
    FVerticalLines := Value;
    InvalidateLedger;
  end;
end;

procedure TIB_Ledger.ClearSortDirection;
var
  i, j: integer;
  Cell: TIB_LedgerCellDefItem;
  R: TRect;
begin
  { Clear Direction Icons }
  for i := 0 to RowDefs.Count-1 do begin
    for j := 0 to RowDefs[ i ].CellDefs.Count - 1 do begin
      Cell := RowDefs[ i ].CellDefs[ j ];
      if Cell.SortDirection <> diNone then begin
        Cell.SortDirection := diNone;
        R := Cell.CellRect;
        Inc( R.Left );
        Inc( R.Right );
        Inc( R.Top );
        Inc( R.Bottom );
        InvalidateRect( Handle, @R, false );
      end;
    end;
  end;
end;

procedure TIB_Ledger.UpdateActive;
var
  NewRow: Integer;
begin
  if ( FDatalink.BufferActive ) and
    not ( csLoading in ComponentState ) then
  begin
    NewRow := FDatalink.ActiveRecord;
    if CurRow <> NewRow then
    begin
      CurRow := NewRow;
      InvalidateLedger;
    end;
  end;
end;

procedure TIB_Ledger.SetRowDefs( Value: TIB_LedgerRowDefs );
begin
  FRowDefs.Assign( Value );
  AdjustLayout;
  UpdateFields;
  FDataLink.LayoutChanged;
end;

procedure TIB_Ledger.SetCurrentRowColor( Value: TColor );
begin
  if FCurrentRowColor <> Value then
  begin
    FCurrentRowColor := Value;
    InvalidateLedger;
  end;
end;

procedure TIB_Ledger.SetIndicatorColor( Value: TColor );
begin
  if FIndicatorColor <> Value then
  begin
    FIndicatorColor := Value;
    InvalidateLedger;
  end;
end;

procedure TIB_Ledger.SetIndicatorWidth( Value: integer );
begin
  if FIndicatorWidth <> Value then
  begin
    FIndicatorWidth := Value;
    InvalidateLedger;
  end;
end;

procedure TIB_Ledger.Notification( AComponent: TComponent;
  Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( FDataLink <> nil ) and
     ( AComponent = DataSource ) then begin
    DataSource := nil;
  end;
end;

function TIB_Ledger.VisibleRowCount: integer;
begin
  Result := FVisibleRowCount;
end;

procedure TIB_Ledger.WMEraseBkgnd( var Message: TWMEraseBkgnd );
begin
{ FillRect(Message.DC, ClientRect, FBrush.Handle); }
  Message.Result := 1
end;

procedure TIB_Ledger.WMGetDlgCode( var Message: TWMGetDlgCode );
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TIB_Ledger.KeyDown( var Key: Word; Shift: TShiftState );
begin
  if FDataLink.BufferActive then
    with FDataLink.DataSet do
      if ssCtrl in Shift then
        case Key of
          VK_UP, VK_LEFT:    SetTopRow( TopRow - 1 );
          VK_DOWN, VK_RIGHT: SetTopRow( TopRow + 1 );
          VK_PRIOR:          SetTopRow( TopRow - VisibleRowCount );
          VK_NEXT:           SetTopRow( TopRow + VisibleRowCount );
          VK_HOME:           SetTopRow( -MaxInt );
          VK_END:            SetTopRow(  MaxInt );
        end
      else
        case Key of
          VK_UP, VK_LEFT:    ScrollRecordPointer( -1 );
          VK_DOWN, VK_RIGHT: ScrollRecordPointer(  1 );
          VK_PRIOR:          ScrollRecordPointer( -VisibleRowCount );
          VK_NEXT:           ScrollRecordPointer(  VisibleRowCount );
          VK_HOME:           ScrollRecordPointer( -MaxInt );
          VK_END:            ScrollRecordPointer(  MaxInt );
        end;
  inherited KeyDown( Key, Shift );
end;

procedure TIB_Ledger.InvalidateLedger;
begin
  if not ( csLoading in ComponentState ) and
     not ( csDestroying in ComponentState ) then
  begin
    AdjustLayout;
    InvalidateRect( Handle, nil, False );
  end;
end;

procedure TIB_Ledger.LinkActive;
begin
  UpdateFields;

  {-----------------------------------------------------------------------------
  vcm2: Daniel Puckett 2000 08 15
  ------------------------------------------------------------------------------
   If FdpReadEntireDatasetOnOpen is True, this section reads to the LAST row of
   the dataset, then back to BEFORE the first row Or FIRST row of the dataset.
   Usefull if you will need a count of the query or if you must always
   have an accurately proportional scrollbar, or just want it so.

   If FdpKeepDatasetOnValidRow is True then sets to FIRST row.
  -----------------------------------------------------------------------------}
  if(FdpReadEntireDatasetOnOpen) then
  begin
    if ((FDataLink.BufferActive)and(FDataLink.ActiveRecord=0)) then
    begin
      FDataLink.Dataset.Last;
      if(FdpKeepDatasetOnValidRow) then FDataLink.Dataset.First
      else FDataLink.Dataset.RowNum:=0;
    end;
  end;
  {-----------------------------------------------------------------------------
  vcm2: Daniel Puckett 2000 08 15
  -----------------------------------------------------------------------------}

  if FDataLink.BufferActive then begin
    DataChanged;
    CurRow := FDataLink.ActiveRecord;
  end;
  if not ( csDestroying in ComponentState ) then begin
    InvalidateLedger;
  end;
end;

function TIB_Ledger.FullRowHeight: integer;
begin
  Result := FFullRowHeight;
end;

constructor TIB_Ledger.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

//FInplaceEdit := TEdit.Create(self);
//FInplaceEdit.Visible := false;
//FInplaceEdit.BorderStyle := bsNone;

  FBorderStyle := bsSingle;
  FRowHeight := DefaultRowHeight;
  FFullRowHeight := DefaultRowHeight;
  Width := 400;
  Height := 150;
  TabStop := true;
  FDataLink := TIB_LedgerDataLink.Create( Self );
  FRowDefs := TIB_LedgerRowDefs.Create( Self );
  FIndicatorWidth := 1;
  FIndicatorColor := clBlack;
  FCurrentRowColor := clWhite;
  FHorizontalLines := true;
  FVerticalLines := true;
  FIndicateTitles := true;
  FixedRows := 1;
  FTopRow := 1;

  FInLayout := false;

end;

destructor TIB_Ledger.Destroy;
begin
  FDataLink.Free; FDataLink := nil;
  FRowDefs.Free; FRowDefs := nil;
  inherited Destroy;
end;

procedure TIB_Ledger.ScrollRecordPointer( Direction: longint );
var
  OldRow: longint;
  NewRow: longint;
  RowsMoved: longint;
begin
  if FDataLink.BufferActive then
  begin
    OldRow := FDataLink.ActiveRecord;
    if Abs( Direction ) = MaxInt then
      NewRow := Direction
    else
      NewRow := OldRow + Direction;
    FDataLink.BufferRecord := NewRow;
    FDataLink.Dataset.ValidateRows( OldRow, NewRow );
    if NewRow < FDataLink.Dataset.BofRowNum + 1 then
      NewRow := FDataLink.Dataset.BofRowNum + 1;
    if NewRow > FDataLink.Dataset.EofRowNum - 1 then
      NewRow := FDataLink.Dataset.EofRowNum - 1;
    if OldRow <> NewRow then
    begin
      RowsMoved := FDataLink.Dataset.MoveBy( NewRow - OldRow );
      if Direction < 0 then
      begin
        if NewRow < TopRow then
          TopRow := NewRow;
      end
      else
      begin
        if NewRow >= ( TopRow + FVisibleRowCount ) then
        begin
            FDataLink.ActiveRecord := OldRow + 5;
            FDataLink.ActiveRecord := OldRow + RowsMoved;
            TopRow := (NewRow-FVisibleRowCount)+FRowDefs.Count;
        end;
      end;
    end;
  end;
end;

procedure TIB_Ledger.SetRowHeight( Value: Integer );
begin
  if ( Value < 10 ) then Value := 10;
  if ( Value > 30 ) then Value := 30;
  if ( FRowHeight <> Value ) then
  begin
    FRowHeight := Value;
    InvalidateLedger;
  end;
end;

procedure TIB_Ledger.AdjustLayout;
var
  RowNo, CellNo: Integer;
  Cell: TIB_LedgerCellDefItem;
  Row: TIB_LedgerRowDefItem;
  ActualFixedWidth,
  ActualFloatWidth,
  ActualFloatCount,
  ActualRowHeight,
  ActualClientHeight,
  AvailableFloatWidth: longint;
  FloatWidth: longint;
  FloatColumnCount: Integer;
  LeftPos: integer;
  CellCount: integer;
  RowCount: Integer;
begin
  if FInLayout then Exit;

  FInLayout := true;
  try

  if FRowDefs.Count > 0 then begin
    RowCount := FRowDefs.Count;
  end else begin
    RowCount := 1;
  end;

  ActualRowHeight := FRowHeight;
  ActualClientHeight := ClientHeight;
  if HorizontalLines then
  begin
    Inc( ActualRowHeight );
    Dec( ActualClientHeight );
  end;
  FFullRowHeight := ActualRowHeight * RowCount;
  FVisibleRowCount := ( ActualClientHeight - 2 ) div FFullRowHeight - FixedRows;

  for RowNo := 0 to RowDefs.Count - 1 do begin
    Row := RowDefs.Items[ RowNo ];

    ActualFixedWidth := 0;
    ActualFloatWidth := 0;
    ActualFloatCount := 0;
    FloatWidth := 0;
    AvailableFloatWidth := 0;

    CellCount := 0;
    for CellNo := 0 to Row.CellDefs.Count - 1 do begin
      Cell := Row.CellDefs[ CellNo ];
      if Cell.Visible then begin
        Inc( CellCount );
        if Cell.WidthType = laFixed then begin
          Inc( ActualFixedWidth, Cell.Width );
        end else if Cell.WidthType = laVariable then begin
          ActualFloatWidth := ActualFloatWidth + Cell.Width;
          Inc( ActualFloatCount );
        end;
      end;
    end;

    if ActualFloatCount > 0 then begin
      AvailableFloatWidth := ClientWidth - ( CellCount + 1 ) - ActualFixedWidth;
      FloatWidth := AvailableFloatWidth;
    end;

    LeftPos := 0;
    FloatColumnCount := 0;
    for CellNo := 0 to Row.CellDefs.Count-1 do begin
      Cell := Row.CellDefs[CellNo];
      if Cell.Visible then begin
        if Cell.WidthType = laFixed then begin
          Cell.FActualWidth := Cell.Width;
        end else if Cell.WidthType = laVariable then begin
          Inc(FloatColumnCount);
          Cell.FActualWidth := (Longint(Cell.Width) *
                                AvailableFloatWidth) div ActualFloatWidth;
          Dec(FloatWidth,Cell.FActualWidth);
          if Cell.FActualWidth < Cell.Width then
            Cell.FActualWidth := Cell.Width;
          if (FloatColumnCount = ActualFloatCount) and (FloatWidth > 0) then
            Inc(Cell.FActualWidth, FloatWidth);
        end;

        Cell.FCellRect.Left := LeftPos;
        Cell.FCellRect.Top := (RowNo) * (RowHeight + 1);
        Cell.FCellRect.Right := LeftPos + Cell.FActualWidth;
        Cell.FCellRect.Bottom := (RowNo+1) * (RowHeight + 1);

        Inc(LeftPos, Cell.FActualWidth + 1);
      end;
    end;
  end;
  UpdateActive;
  UpdateScrollbar;
  finally
    FInLayout := false;
  end;
end;

procedure TIB_Ledger.UpdateFields;
var
  RowNum, CellNum: Integer;
  Row: TIB_LedgerRowDefItem;
  Cell: TIB_LedgerCellDefItem;
begin
  for RowNum := 0 to RowDefs.Count-1 do
  begin
    Row := RowDefs[RowNum];
    for CellNum := 0 to Row.CellDefs.Count-1 do
    begin
      Cell := Row.CellDefs[CellNum];
      Cell.Field := nil;
      if FDataLink.BufferActive and ( Length( Cell.FieldName ) > 0 ) then
        Cell.Field := FDataLink.DataSet.FindBufferField( Cell.FieldName );
    end;
  end;
end;

procedure TIB_Ledger.Paint;
var
  textOffset: integer;
  Handled: boolean;

  procedure DrawCellTitle( RowDefNum, CellDefNum: integer );
  var
    DisplayValue: String;
    TW, TH: Integer;
    TopPosition, LeftPosition: Integer;
    R: TRect;
    X,Y: integer;
    Cell: TIB_LedgerCellDefItem;
  begin
    Cell := RowDefs[RowDefNum].CellDefs[CellDefNum];

    if not Cell.Visible then
      Exit;

    if Cell.DispName <> '' then
      DisplayValue := Cell.DispName
    else if Cell.GetColumn <> nil then
      DisplayValue := Cell.GetColumn.DisplayLabel
    else
      DisplayValue := Cell.FieldName;

    R.Left := 1 + Cell.FCellRect.Left;
    R.Right := 1 + Cell.FCellRect.Right + 1;
    R.Top := 1 + Cell.FCellRect.Top;
    R.Bottom := 1 + Cell.FCellRect.Bottom;

    with Canvas do begin
      TW := TextWidth(DisplayValue);
      TH := TextHeight(DisplayValue);

      TopPosition := R.Top + (RowHeight - TH + 1) div 2;

      if Cell.FTitleDown then begin
        textOffset := 1;
      end else begin
        textOffset := 0;
      end;

{ don't justify the title ...
    case Cell.Alignment of
        taLeftJustify:
          LeftPosition := R.Left + 2;
        taRightJustify:
          LeftPosition := R.Right - TW  - 4;
        taCenter:
          LeftPosition := R.Left + (R.Right - R.Left - TW ) div 2;
      end; }
      LeftPosition := R.Left + 2;

      TextRect( R,
                LeftPosition + textOffset,
                TopPosition + textOffset,
                DisplayValue );

      { draw 3d edge around header cell }
      if Cell.FTitleDown then begin
        DrawEdge( Handle, R, BDR_SUNKENINNER, BF_LEFT or
                                              BF_RIGHT or
                                              BF_TOP or BF_BOTTOM );
      end else begin
        DrawEdge( Handle, R, BDR_RAISEDINNER, BF_LEFT or
                                              BF_RIGHT or
                                              BF_TOP or
                                              BF_BOTTOM );
      end;
      if Cell.IndicateSort then begin
        if Cell.SortDirection = diUp then begin
          X := LeftPosition + TW + 3;
          Y := R.Top + ( R.Bottom-R.Top-UpBitmap.Height ) div 2;
          Draw( X + TextOffset, Y + TextOffset, UpBitmap );
        end else if Cell.FSortDirection = diDown then begin
          X := LeftPosition + TW + 3;
          Y := R.Top + ( R.Bottom-R.Top-UpBitmap.Height ) div 2;
          Draw( X + TextOffset, Y + TextOffset, DownBitmap );
        end else begin
          X := LeftPosition + TW + 3;
          Y := R.Top + ( R.Bottom-R.Top-UpBitmap.Height ) div 2;
          Draw( X + TextOffset, Y + TextOffset, DotBitmap );
        end;
      end;
    end;
  end;

  procedure DrawCell( RowDefNum, CellDefNum: integer; RowNum: longint );
  var
    DisplayValue: String;
    TW, TH: Integer;
    TopPosition, LeftPosition: Integer;
    R: TRect;
    Cell: TIB_LedgerCellDefItem;


      procedure drawIBText(Rect: TRect; X, Y: Integer; const Text: string);
      var
      Options: Longint;
      Texttodraw:Widestring;
      begin
      
      {UNICODE - converts text if  convertfromUTF8=true and use ExtTextOutW function}
{$IFDEF IBO_VCL60_OR_GREATER}
       if convertfromUTF8 then
         Texttodraw := UTF8decode(Text)
       else
{$ENDIF}
         Texttodraw := Text;
         
        with canvas do
        begin
          //RequiredState([csHandleValid, csFontValid, csBrushValid]);
          Options := ETO_CLIPPED or TextFlags;
          if Brush.Style <> bsClear then
            Options := Options or ETO_OPAQUE;
          if ((TextFlags and ETO_RTLREADING) <> 0) and
             (CanvasOrientation = coRightToLeft) then Inc(X, TextWidth(Texttodraw) + 1);
          Windows.ExtTextOutW(Handle, X, Y, Options, @Rect, PWChar(Texttodraw),
            Length(Texttodraw), nil);
          Changed;
        end;
      end;


  begin
    Cell := RowDefs[ RowDefNum ].CellDefs[ CellDefNum ];

    if not Cell.Visible then Exit;
    if Assigned( Cell.Field ) then begin
      DisplayValue := Cell.Field.DisplayText;
    end else begin
      DisplayValue := '';
    end;
    R.Left := 1 + Cell.FCellRect.Left;
    R.Right := 1 + Cell.FCellRect.Right;
    if R.Right < ClientWidth - 1 then begin
      R.Right := R.Right + 1;
    end;
    R.Top := ( 1 + Cell.FCellRect.Top ) +
             ( FixedRows + RowNum ) * ( FFullRowHeight );

    R.Bottom := ( 1 + Cell.FCellRect.Bottom ) +
                ( FixedRows + RowNum ) * ( FFullRowHeight ) + 1;
    with Canvas do begin
      TW := TextWidth( DisplayValue );
      TH := TextHeight( DisplayValue );
      Brush.Color := RowDefs[ RowDefNum ].Color;
      if ( FDataLink.Active ) and
         ( FDatalink.ActiveRecord = RowNum + TopRow ) then
        if FDataLink.Editing then
          Brush.Color := FDataLink.Color
        else
          Brush.Color := CurrentRowColor;
      TopPosition := R.Top + ( R.Bottom - R.Top - TH ) div 2;
      case Cell.Alignment of
        taCenter:
          LeftPosition := R.Left + (R.Right - R.Left - TW ) div 2;
        taRightJustify:
          LeftPosition := R.Right - TW  - 2;
        else { taLeftJustify: }
          LeftPosition := R.Left + 2;
      end;
      Font.Color := ( $00FFFFFF - ColorToRGB( Brush.Color )) and $00FFFFFF;
      FillRect( R );
      { draw cell contents }
      Brush.Style := bsClear;
      if Assigned( OnDrawCell ) and
         ( RowNum < FDataLink.BufferRowCount ) then
      begin
        Handled := false;
        FOnDrawCell( Self, RowDefNum, CellDefNum, RowNum, R, [], Handled );
        if not Handled then
          {UNICODE , replace standard-procedure TextRect (Graphics TCanvas.TextRect) with
          drawIBText}
          //TextRect( R, LeftPosition, TopPosition, DisplayValue );
          drawIBText ( R, LeftPosition, TopPosition, DisplayValue );
      end else begin
        //TextRect( R, LeftPosition, TopPosition, DisplayValue );
        {UNICODE , replace standard-procedure TextRect (Graphics TCanvas.TextRect) with
          drawIBText}
      drawIBText ( R, LeftPosition, TopPosition, DisplayValue );
      end;
      { draw edge around cell }
      Brush.Style := bsSolid;
      Pen.Color := clSilver;
      if VerticalLines and ( Cell.FCellRect.Left <> 0 ) then
      begin
        MoveTo( R.Left - 1, R.Top );
        LineTo( R.Left - 1, R.Bottom );
      end;
      if HorizontalLines and ( Cell.FCellRect.Top <> 0 ) then
      begin
        MoveTo( R.Left, R.Top );
        LineTo( R.Right, R.Top );
      end;
    end;
  end;
var
  R: TRect;
  I: Integer;
  RowNum, CellNum: Integer;
  Y: integer;

begin
  with Canvas do begin
    Pen.Color := clGray;
    Pen.Width := 1;
    Pen.Style := psSolid;
{   R.Left := 1;
    R.Right := ClientWidth - 1;}
    Font := Self.Font;
    Font.Height := RowHeight - 2;
    Brush.Color := clBtnFace;
    Brush.Style := bsSolid;

    { display header/title }
    if IndicateTitles then begin
      for RowNum := 0 to RowDefs.Count - 1 do begin
        for CellNum := 0 to RowDefs[ RowNum ].FCellDefs.Count - 1 do begin
          DrawCellTitle( RowNum, CellNum );
        end;
      end;
    end;

    { Draw bottom area }
    R.Left := 0;
    R.Right := Width;
    R.Top := 1 + ( FVisibleRowCount + FixedRows ) * ( FFullRowHeight );
    R.Bottom := Height;
    Brush.Color := Color;
    FillRect( R );

    { display the rows of data }
    for I := 0 to FVisibleRowCount do begin
      if I < FVisibleRowCount then begin
        FDataLink.BufferRecord := I + TopRow;
        for RowNum := 0 to RowDefs.Count - 1 do begin
          Pen.Width := 1;
          Pen.Color := clSilver;
          for CellNum := 0 to RowDefs[RowNum].CellDefs.Count - 1 do
            DrawCell( RowNum, CellNum, I );
        end;
      end;
      if HorizontalLines then begin
        Pen.Width := 1;
        Pen.Color := clGray;
        Y := 1 + ( I + FixedRows ) * ( FFullRowHeight );
        MoveTo( 0, Y );
        LineTo( ClientWidth, Y );
      end;
    end;

    { draw border around ledger }
    R.Top := 0;
    R.Left := 0;
    R.Right := ClientWidth - 1;
    R.Bottom := ClientHeight - 1;
    if BorderStyle = bsSingle then begin
      if (GetParentForm(Self).ActiveControl = Self)
          and not (csDesigning in ComponentState)
          and not (csPaintCopy in ControlState) then begin
        Pen.Color := clBlack
      end else begin
        Pen.Color := clGray;
      end;
    end else begin
      Pen.Color := Color;
    end;
    PolyLine( [ Point( R.Left, R.Top ),
                Point( R.Right, R.Top ),
                Point( R.Right, R.Bottom ),
                Point( R.Left, R.Bottom ),
                Point( R.Left, R.Top )] );

    { draw selected row highlight box }
    if ( IndicatorWidth > 0 ) and
       not (csDesigning in ComponentState) and
       not (csPaintCopy in ControlState) then begin
      Pen.Width := 1;
      Pen.Color := IndicatorColor;
      R.Left := 0;
      R.Right := ClientWidth - 1;
      R.Top := 1 + ( FDataLink.ActiveRecord - TopRow + FixedRows ) *
                   ( FFullRowHeight );
      R.Bottom := R.Top + FFullRowHeight;
      for I := 1 to IndicatorWidth do begin
        PolyLine( [Point( R.Left, R.Top ),
                   Point( R.Right, R.Top ),
                   Point( R.Right, R.Bottom ),
                   Point( R.Left, R.Bottom ),
                   Point( R.Left, R.Top)] );
        Inc( R.Top );
        Dec( R.Bottom );
        Inc( R.Left );
        Dec( R.Right );
      end;
    end;
  end;
end;

procedure TIB_Ledger.UpdateScrollbar;
var
  SIOld, SINew: TScrollInfo;
begin
  if FDatalink.BufferActive and HandleAllocated then
    with FDatalink.DataSet do begin
      SIOld.cbSize := sizeof( SIOld );
      SIOld.fMask := SIF_ALL or SIF_DISABLENOSCROLL;
      GetScrollInfo( Self.Handle, SB_VERT, SIOld );
      SINew := SIOld;
      SINew.nMin := 1;
      SINew.nPage := Self.VisibleRowCount;

      SINew.nMax := BufferRowCount + longint( SINew.nPage ) - 1;

      {-------------------------------------------------------------------------
      vcm3: Daniel Puckett 2000 08 15
      --------------------------------------------------------------------------
       If FdpAlwaysShowScrollBar is True this section ensures that at least
       visible+1 rows is passed to SetScrollInfo as maximum position to always
       have the scroll bar functionality.
       -note: as nPage is unsigned, abs(SINew.nPage) has no real effect other
              than preventing compiler warning 1427 (signed/unsigned compare)
      -------------------------------------------------------------------------}
      if((FdpAlwaysShowScrollBar)and(SINew.nMax<(abs(SINew.nPage)+1))) then
        SINew.nMax:=(SINew.nPage+1);
      {-------------------------------------------------------------------------
      /vcm3: Daniel Puckett 2000 08 15
      -------------------------------------------------------------------------}

      if State in [ dssInactive, dssBrowse, dssEdit ] then
        SINew.nPos := RecNo;  { else keep old pos }
      if ( SINew.nMin <> SIOld.nMin ) or ( SINew.nMax <> SIOld.nMax ) or
         ( SINew.nPage <> SIOld.nPage ) or ( SINew.nPos <> SIOld.nPos ) then
        SetScrollInfo( Self.Handle, SB_VERT, SINew, True );
    end;
end;

procedure TIB_Ledger.WMVScroll( var Message: TWMVScroll );
var
  SI: TScrollInfo;
{-----------------------------------------------------------------------------
 vcm1: Daniel Puckett 2000 08 15
      variable dsrn is used for dataset.RomNum as it is referenced 6 times
      in the following code `semper speed`.
-----------------------------------------------------------------------------}
  dsrn: integer;
{-----------------------------------------------------------------------------
  /vcm1: Daniel Puckett 2000 08 15
-----------------------------------------------------------------------------}
  procedure ScrollBy( Dir: Integer );
  begin
    if not FTrackWithScrollBar then
    begin
      TopRow := TopRow + Dir ;
      if (CurRow >= TopRow) and
         (CurRow < (TopRow+VisibleRowCount)) and
         (
          not FScrollTowards_BOF_EOF or (
           (TopRow > 1 ) and
           (TopRow+VisibleRowCount < FDataLink.DataSet.BufferRowCount)
         )) then
        exit;
    end;
    FDataLink.DataSet.MoveBy(Dir);
  end;
  var
    Offset: Integer;
begin
  Offset := MaxInt;
  if FDatalink.Active then
    with Message, FDataLink.DataSet do
      case ScrollCode of
        SB_LINEUP: ScrollBy( -1 ); //;MoveBy( -1 );
        SB_LINEDOWN: ScrollBy( 1 ); //;MoveBy( 1 );
        SB_PAGEUP: ScrollBy( - VisibleRowCount );//MoveBy( - VisibleRowCount );
        SB_PAGEDOWN: ScrollBy( VisibleRowCount );//MoveBy( VisibleRowCount );
        SB_THUMBPOSITION:
          if Offset <> MaxInt then
          begin
            if CurRow <TopRow then
              RecNo := TopRow
            else
            if CurRow >= TopRow + VisibleRowCount then
              RecNo := TopRow + VisibleRowCount - 1;
          end;
        SB_BOTTOM: Last;
        SB_TOP: First;
        SB_ENDSCROLL: ;//Offset := MaxInt;
        SB_THUMBTRACK:
          begin
            if Offset = MaxInt then
              Offset := CurRow-TopRow;
            SI.cbSize := sizeof( SI );
            SI.fMask := SIF_ALL;
            GetScrollInfo( Self.Handle, SB_VERT, SI );
            if ( SI.nTrackPos - Offset ) <= 1 then
              TopRow := 1
            else
            if ( SI.nTrackPos - Offset ) >= BufferRowCount then
              TopRow := TopRow - BufferRowCount
            else
              TopRow := SI.nTrackPos - Offset;
              //RecNo := SI.nTrackPos;
          end;
    end;

  {-----------------------------------------------------------------------------
  vcm1: Daniel Puckett 2000 08 15
  ------------------------------------------------------------------------------
   If FdpGridInSyncWithScrollBar is True, this section corrects an omission
   in the object code that did not keep the ledger grid display in sync with
   the current row of the dataset on scroll via scrollbar.

   Optionally, if FdpKeepDatasetOnValidRow is also true, this section prevents
   the dataset from being scrolled before or after the datset, also a code
   ommision as scrolling via the curser keys did not allow it to occur.

   note: although the procedure ScrollRecordPointer exists, I didn't think that
         the scroll behavior was correct.
  -----------------------------------------------------------------------------}
    dsrn:= FDataLink.DataSet.RowNum;
    {if before data and ..keep..valid.. set to first row}
    if (( FdpKeepDatasetOnValidRow ) and ( dsrn = 0 ))then
    begin
      FDataLink.DataSet.First;
      TopRow:=1;
    {else.. if after data and ..keep..valid.. and not fetching set to last row}
    end
    else
    if (( FdpKeepDatasetOnValidRow ) and
        ( not ( FDataLink.DataSet.Fetching )) and
        ( dsrn > FDataLink.DataSet.BufferRowCount ))then
    begin
      FDataLink.DataSet.Last;
      TopRow := FDataLink.DataSet.BufferRowCount - VisibleRowCount + 1;
    {else.. process Scrollcode for action}
    end
    else
    if FdpGridInSyncWithScrollBar then
      case Message.ScrollCode of
        SB_LINEUP,
        SB_LINEDOWN,
        SB_PAGEUP,
        SB_PAGEDOWN,
        SB_TOP,
        SB_BOTTOM,
        SB_THUMBPOSITION:
          begin
            {if data row before visible rows, set as top row}
            if dsrn < TopRow then
              TopRow := dsrn
            {else.. if data row after visible rows, set as last visible row}
            else
            if dsrn > ( TopRow + VisibleRowCount - 1 ) then
              TopRow := dsrn - VisibleRowCount + 1;
          end;
      end;
  {-----------------------------------------------------------------------------
  /vcm1: Daniel Puckett 2000 08 15
  -----------------------------------------------------------------------------}

end;

procedure TIB_Ledger.WMSize( var Message: TWMSize );
begin
  if not FInLayout then
  begin
    inherited;
    AdjustLayout;  { Adjust the layout of the rows and cells }
    Invalidate;
  end;
  Message.Result := 0;
end;

procedure TIB_Ledger.WMLButtonDblClk(var Message: TWMLButtonDown);
var
  Row: Longint;
  Cell: TIB_LedgerCellDefItem;
  NumRowSub : Integer;
begin
  WhichCell( Message.XPos, Message.YPos, Cell, Row );
  if IndicateTitles then NumRowSub := 1 else NumRowSub := 0;
  if ( Cell <> nil ) and
     ( Row >= NumRowSub) and
     ( Row <= FDataLink.BufferRowCount ) and
     ( Message.XPos > 0 ) and
     ( Message.XPos < ClientWidth - 1 ) then
    inherited DblClick
  else
    Message.Result := 1;
end;

procedure TIB_Ledger.WhichCell(     X,Y: longint;
                                var Cell: TIB_LedgerCellDefItem;
                                var Row: longint );
var
  SubRow: longint;
  i: integer;
begin
  Cell := nil;
  Row := ( Y - 1 ) div FFullRowHeight;
  SubRow := (( Y - 1 ) mod FFullRowHeight ) div ( RowHeight + 1 );
  if SubRow > RowDefs.Count - 1 then
    Exit;
  if FDataLink.Active then begin
    if ( X > 0 ) and ( X < ClientWidth - 1 ) then begin
      for i := 0 to RowDefs[SubRow].CellDefs.Count - 1 do begin
        Cell := RowDefs[SubRow].CellDefs[i];
        if ( X >= Cell.FCellRect.Left ) and
           ( X < Cell.FCellRect.Left + Cell.FActualWidth ) then begin
          Break;
        end;
      end;
    end;
  end;
end;

procedure TIB_Ledger.MouseDown( Button: TMouseButton;
                                Shift: TShiftState;
                                X, Y: Integer);
var
{ MyMouseDown: TMouseEvent; }
  Row: longint;
  Cell: TIB_LedgerCellDefItem;
  OldRect: TRect;
  NumRowSub : Integer;
begin
  if CanFocus then
    SetFocus;
{
  if (ssDouble in Shift) and (Button = mbLeft) then
  begin
    DblClick;
    Exit;
  end;
}
  if not Assigned( FDataLink ) then
    Exit;

  if Button <> mbLeft then
    Exit;
  WhichCell( X, Y, Cell, Row );
  if Assigned( Cell ) and FDataLink.Active then begin
    ClickingCell := Cell;
    ClickingRow := Row;
    if IndicateTitles then NumRowSub := 1 else NumRowSub := 0;
    if Row >= NumRowSub then begin
      if Row <= FDataLink.BufferRowCount then begin
        FDataLink.DataSet.MoveBy( Row - FixedRows +
                                  TopRow - FDataLink.ActiveRecord );
      end;
    end else begin
      if Cell.AllowClickTitle then begin
        Cell.FTitleDown := true;
        OldRect.Left := Cell.FCellRect.Left;
        OldRect.Right := Cell.FCellRect.Left + Cell.FActualWidth + 1;
        OldRect.Top := 1 + Cell.FCellRect.Top;
        OldRect.Bottom := 1 + Cell.FCellRect.Top + RowHeight + 1;
        InvalidateRect(Handle, @OldRect, False);
        UpdateWindow(Handle);
      end;
    end;
  end;
{
  if FDataLink.Edit then
   inherited MouseDown(Button, Shift, X, Y)
  else
  begin
     MyMouseDown := OnMouseDown;
     if Assigned(MyMouseDown then MyMouseDown(Self, Button, Shift, X, Y);
   end;
}
end;

procedure TIB_Ledger.MouseUp( Button: TMouseButton; Shift: TShiftState;
                            X, Y: Integer );
var
  Row: longint;
  Cell: TIB_LedgerCellDefItem;
  OldRect: TRect;
begin
  if FDataLink = nil then
    Exit;

  inherited MouseUp(Button, Shift, X, Y);
{
  if (SaveState = gsRowSizing) or (SaveState = gsColSizing) or
    ((InplaceEditor <> nil) and (InplaceEditor.Visible) and
     (PtInRect(InplaceEditor.BoundsRect, Point(X,Y)))) then Exit;
}

  if Button <> mbLeft then
    Exit;

  if Assigned( ClickingCell ) then begin
    Row := ClickingRow;
    Cell := ClickingCell;
    ClickingCell := nil;
    if ( Cell <> nil ) and ( Button = mbLeft ) then begin
      if Row = 0 then begin
        if cell.AllowClickTitle then begin
          if Cell.IndicateSort then begin
            if Cell.SortDirection in [diUp, diNone] then begin
              ClearSortDirection;
              Cell.SetSortDirection( diDown );
            end else if Cell.SortDirection = diDown then begin
              ClearSortDirection;
              Cell.SetSortDirection( diUp );
            end;
          end;
          ClickTitle(Cell);
          Cell.FTitleDown := false;
          OldRect.Left := Cell.FCellRect.Left;
          OldRect.Right := Cell.FCellRect.Left + Cell.FActualWidth + 1;
          OldRect.Top    := 1 + Cell.FCellRect.Top;
          OldRect.Bottom := 1 + Cell.FCellRect.Top + RowHeight + 1;
          InvalidateRect(Handle, @OldRect, False);
          UpdateWindow(Handle);
        end;
      end else begin
        if ( FDataLink.Active ) and
           ( Row <= FDataLink.BufferRowCount ) then begin
          ClickCell( Row, Cell );
        end;
      end;
    end;
  end;
end;

procedure TIB_Ledger.ClickCell( Row: Integer; Cell: TIB_LedgerCellDefItem );
begin
{
  with FInplaceEdit do
  begin
    Left := Cell.FCellRect.Left;
    Top := Cell.FCellRect.Top;
    Width := Cell.FCellRect.Right - Cell.FCellRect.Left;
    Height := Cell.FCellRect.Bottom - Cell.FCellRect.Top;
    Caption := 'XXXX'; //Cell.Field.AsString;
    Visible := true;
  end;
}
  if Assigned( FOnClickCell ) then
    FOnClickCell( Row, Cell );
end;

procedure TIB_Ledger.ClickTitle(Cell: TIB_LedgerCellDefItem);
begin
  if Assigned( FOnClickTitle ) then
    FOnClickTitle( Cell );
end;

(*
procedure TIB_Ledger.Scroll( Distance: Integer );
var
  OldRect, NewRect: TRect;
begin
{
  OldRect.Left := 1;
  OldRect.Right := ClientWidth;
  OldRect.Top    := 1 + (FFullRowHeight);
  OldRect.Bottom := 1 + (VisibleRowCount+1) * (FFullRowHeight);
  ValidateRect(Handle,@oldrect);
}
  OldRect.Left := 0;
  OldRect.Right := ClientWidth;
  OldRect.Top := 1 + ( CurRow + 1 ) * ( FFullRowHeight );
  OldRect.Bottom := 1 + ( CurRow + 2 ) * ( FFullRowHeight ) + 1;

  UpdateActive;

  NewRect.Left := 0;
  NewRect.Right := ClientWidth;
  NewRect.Top := 1 + ( CurRow + 1 ) * ( FFullRowHeight );
  NewRect.Bottom := 1 + ( CurRow + 2 ) * ( FFullRowHeight ) + 1;

  InvalidateRect( Handle, @OldRect, False );
  InvalidateRect( Handle, @NewRect, False );

  if Distance <> 0 then begin
    if Abs(Distance) >= FVisibleRowCount - 1 then begin
      InvalidateRect(Handle, nil, False);
    end else begin
      OldRect.Left := 1;
      OldRect.Right := ClientWidth-1;
      OldRect.Top := 1 + ( FFullRowHeight );
      OldRect.Bottom := OldRect.Top + ( FFullRowHeight ) * FVisibleRowCount;
      ScrollWindowEx( Handle,
                      0, -Distance * ( FFullRowHeight ),
                      @OldRect, @OldRect,
                      0, nil, SW_Invalidate );
    end;
  end;
  UpdateWindow( Handle ); { Force the update NOW ! }
  UpdateScrollbar;
end;
*)

procedure TIB_Ledger.SetDataSource(Value: TIB_DataSource);
begin
  if Value = FDataLink.DataSource then
    Exit;
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
  LinkActive;
  InvalidateRect(Handle, nil, False);
end;

function TIB_Ledger.GetDataSource: TIB_DataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TIB_Ledger.EditingChanged;
begin
  //
end;

procedure TIB_Ledger.RecordChanged(Field: TIB_Column);
begin
  InvalidateLedger;
end;

procedure TIB_Ledger.DataChanged;
begin
  UpdateScrollbar;
  UpdateActive;
  if not ( csDestroying in ComponentState ) then begin
    InvalidateRect( Handle, nil, False );
  end;
end;

procedure TIB_Ledger.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  InvalidateFocusRect;
end;

procedure TIB_Ledger.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  InvalidateFocusRect;
end;

procedure TIB_Ledger.InvalidateFocusRect;
var
  R: TRect;
begin
  R := ClientRect;
  R.Right := R.Left + 1;
  InvalidateRect( Handle, @R, False );
  R := ClientRect;
  R.Left := R.Right - 1;
  InvalidateRect( Handle, @R, False );
  R := ClientRect;
  R.Bottom := R.Top + 1;
  InvalidateRect( Handle, @R, False );
  R := ClientRect;
  R.Top := R.Bottom - 1;
  InvalidateRect( Handle, @R, False );

  { invalidate the focus rectangle }
  R := Rect( 0,           1 + ( CurRow + 1 ) * ( FFullRowHeight ),
             ClientWidth, 1 + ( CurRow + 2 ) * ( FFullRowHeight ) + 1 );
  InvalidateRect( Handle, @R, False );
end;

procedure TIB_Ledger.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle( Params );
end;

procedure TIB_Ledger.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := Style or WS_TABSTOP;
{   if FScrollBars in [ssVertical, ssBoth] then }
      Style := Style or WS_VSCROLL;
    WindowClass.style := CS_DBLCLKS;
(*
    if FBorderStyle = bsSingle then
      if NewStyleControls and Ctl3D then
      begin
        Style := Style and not WS_BORDER;
        ExStyle := ExStyle or WS_EX_CLIENTEDGE;
      end
      else
        Style := Style or WS_BORDER;
*)
  end;
end;

procedure TIB_Ledger.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TIB_Ledger.SetIndicateTitles(Value: Boolean);
begin
  if FIndicateTitles <> Value then begin
    FIndicateTitles := Value;
    if Value then FixedRows := 1 else FixedRows := 0;
    InvalidateLedger;
  end;
end;

function TIB_Ledger.GetGridRow( ARow: integer ): integer;
begin
  Result := ARow + FixedRows - 1;
  if Result < 0 then begin
    Result := 0;
  end;
end;

procedure TIB_Ledger.SetTopRow( AValue: longint );
var
  tmpRow: longint;
begin
  with FDataLink do
  begin
    if Prepared and not BufferHasEof then
    begin
      tmpRow := GetGridRow( AValue ) + FVisibleRowCount;
      Dataset.ValidateRows( tmpRow, tmpRow );
    end;
    if AValue > (BufferRowCount - FVisibleRowCount) + FRowDefs.Count then
      AValue := (BufferRowCount - FVisibleRowCount) + FRowDefs.Count;

    if FdpKeepDatasetOnValidRow then
    begin
      if Dataset.Eof then
          DataSet.MoveBy(-1)
      else
        if Dataset.Bof then
          DataSet.MoveBy(1);
    end;

  end;

  if AValue < 1 then
    AValue := 1;

  FTopRow := AValue;
  InvalidateLedger;
end;

initialization
  // setup sub objects
  UpBitmap := TBitmap.Create;
  DownBitmap := TBitmap.Create;
  DotBitmap := TBitmap.Create;
  UpBitmap.LoadFromResourceName( HInstance, 'UP_ARROW' );
  DownBitmap.LoadFromResourceName( HInstance, 'DOWN_ARROW' );
  DotBitmap.LoadFromResourceName( HInstance, 'DOT' );

finalization
  UpBitmap.Free;
  DownBitmap.Free;
  DotBitmap.Free;

end.
