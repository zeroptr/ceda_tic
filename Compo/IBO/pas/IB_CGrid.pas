
{                                                                              }
{ IB_CGrid                                                                     }
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
{  Marco Menardi <mmenaz@lycosmail.com>                                        }
{  13-feb-2002                                                                 }
{     New record can be inserted hitting tab key from the last control of the  }
{     panel with TabStop=True, not only the last control in TabOrder list.     }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_CGrid;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Forms, Graphics, Menus,

  // dbctrlgrid
  // dbcgrids
  // grids
  // IB_Grid

  IB_Session,
  IB_Constants,
  IB_Controls,
  IB_Components,
  IB_FieldDataLink;

type

{ TIB_CtrlGrid }

TIB_CtrlGrid = class;

TIB_CtrlGridLink = class( TIB_DataLink )
private
  FIB_CtrlGrid: TIB_CtrlGrid;
protected
  procedure SysStateChanged; override;
  procedure SysBindingChanged; override;
  procedure SysDataChange( AColumn: TIB_Column ); override;
  procedure ProcessGridEvent( AEvent: TIB_StatementEventType;
                              Info: longint ); override;
public
  constructor Create( AOwner: TComponent ); override;
  procedure DatasetChanged; override;
end;

TIB_CtrlPanel = class(TWinControl)
private
  FIB_CtrlGrid: TIB_CtrlGrid;
  procedure CMControlListChange(var Message: TCMControlListChange);
                                                 message CM_CONTROLLISTCHANGE;
  procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
  procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
protected
  procedure CreateParams( var Params: TCreateParams ); override;
  procedure PaintWindow( DC: HDC ); override;
public
  constructor CreateLinked(IB_CtrlGrid: TIB_CtrlGrid);
end;

TIB_CtrlGridOrientation = ( goVertical, goHorizontal );

TIB_CtrlGridBorder = ( gbNone, gbRaised );

TIB_CtrlGridKey = ( gkNull, gkEditMode, gkPriorTab, gkNextTab, gkLeft,
                    gkRight, gkUp, gkDown, gkScrollUp, gkScrollDown,
                    gkPageUp, gkPageDown, gkHome, gkEnd, gkInsert, gkAppend,
                    gkDelete, gkCancel );

TIB_PaintPanelEvent = procedure( IB_CtrlGrid: TIB_CtrlGrid;
                                 RowNum: integer ) of object;

TIB_CtrlGrid = class(TWinControl)
private
  FDataLink: TIB_CtrlGridLink;
  FPanel: TIB_CtrlPanel;
  FCanvas: TCanvas;
  FColCount: integer;
  FRowCount: integer;
  FPanelWidth: integer;
  FPanelHeight: integer;
  FPanelIndex: integer; 
  FPanelCount: integer;
  FPanelOffset: integer;
  FPanelHeightFixed: boolean;
  FPanelWidthFixed: boolean;
  FBitmapCount: integer;
  FPanelBitmap: HBitmap;
  FSaveBitmap: HBitmap;
  FPanelDC: HDC;
  FOrientation: TIB_CtrlGridOrientation;
  FPanelBorder: TIB_CtrlGridBorder;
  FAllowInsert: boolean;
  FAllowDelete: boolean;
  FAllowTabToPost: boolean;
  FShowFocus: boolean;
  FPartialRows: boolean;
  FPartialCols: boolean;
  FPartialColMargin: word;
  FPartialRowMargin: word;
  FFocused: boolean;
  FClicking: boolean;
  FSelColorChanged: boolean;
  FScrollBarKind: integer;
  FSelectedColor: TColor;
  FDatasetChanging: boolean;
  FWindowPainting: boolean;
  FOnPaintPanel: TIB_PaintPanelEvent;
  function AcquireFocus: boolean;
  procedure CreatePanelBitmap;
  procedure DestroyPanelBitmap;
  procedure DrawPanel( DC: HDC; Index: integer );
  procedure DrawPanelBackground(       DC: HDC;
                                 const R: TRect;
                                       Erase,
                                       Selected: boolean );
  function FindNext(     StartControl: TWinControl;
                         GoForward: boolean;
                     var WrapFlag: integer ): TWinControl;
  function GetDataSource: TIB_DataSource;
  function GetEditMode: boolean;
  function GetPanelBounds( Index: integer ): TRect;
  function IsColCountStored: boolean;
  function IsRowCountStored: boolean;
  function IsPanelHeightStored: boolean;
  function IsPanelWidthStored: boolean;
  function PointInPanel( const P: TSmallPoint ): boolean;
  procedure Scroll( AInc: integer; ScrollLock: boolean );
  procedure ScrollMessage( var Message: TWMScroll );
  procedure SetColCount( AValue: integer );
  procedure SetDataSource( AValue: TIB_DataSource);
  procedure SetEditMode( AValue: boolean );
  procedure SetOrientation( AValue: TIB_CtrlGridOrientation );
  procedure SetPanelBorder( AValue: TIB_CtrlGridBorder );
  procedure SetPanelBounds( NewColCount,
                            NewRowCount,
                            NewPanelWidth,
                            NewPanelHeight: integer );
  procedure SetPanelHeight( AValue: integer );
  procedure SetPanelIndex( AValue: integer );
  procedure SetPanelOffset( AValue: integer );
  procedure SetPanelWidth( AValue: integer );
  procedure SetRowCount( AValue: integer );
  procedure SetSelectedColor( AValue: TColor);
  procedure SetPanelHeightFixed( AValue: boolean );
  procedure SetPanelWidthFixed( AValue: boolean );
  procedure SetPartialCols( AValue: boolean );
  procedure SetPartialRows( AValue: boolean );
  procedure SetPartialColMargin( AValue: word );
  procedure SetPartialRowMargin( AValue: word );
  procedure WMLButtonDown(var Message: TWMLButtonDown);
                                                       message WM_LBUTTONDOWN;
  procedure WMLButtonDblClk(var Message: TWMLButtonDblClk);
                                                     message WM_LBUTTONDBLCLK;
  procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
  procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
  procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
  procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
  procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  procedure WMSize(var Message: TMessage); message WM_SIZE;
  procedure CMChildKey(var Message: TCMChildKey); message CM_CHILDKEY;
  procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
protected
  procedure CreateParams(var Params: TCreateParams); override;
  procedure CreateWnd; override;
  procedure Loaded; override;
  function GetChildParent: TComponent; override;
{$IFDEF IBO_VCL30_OR_GREATER}
  procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
{$ELSE}
  procedure GetChildren(Proc: TGetChildProc ); override;
{$ENDIF}
  procedure PaintPanel( Index: integer ); virtual;
  procedure PaintWindow( DC: HDC ); override;
  procedure ReadState(Reader: TReader); override;
  procedure SysDataChange( AColumn: TIB_Column ); virtual;
  procedure UpdateDataLinks( Control: TControl; Inserting: boolean );
  procedure UpdateBufferCount;
  procedure UpdateScrollBar;
  procedure DatasetChanged( Reset: boolean );
  procedure BindDataLinks( Control: TControl; Buffer: boolean );
  procedure RefreshDataLinks( Control: TControl );
  procedure UpdatePanelBounds( Focus: boolean; Reset: boolean );
  property Panel: TIB_CtrlPanel read FPanel;
  property DataLink: TIB_CtrlGridLink read FDataLink;
public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
  procedure DoKey( Key: TIB_CtrlGridKey );
  procedure GetTabOrderList( List: TList ); override;
  procedure KeyDown( var Key: Word; Shift: TShiftState ); override;
  procedure SetBounds( ALeft, ATop, AWidth, AHeight: integer ); override;
  procedure SelectNext( GoForward: boolean );
  property Canvas: TCanvas read FCanvas;
  property EditMode: boolean read GetEditMode write SetEditMode;
  property PanelCount: integer read FPanelCount;
  property PanelIndex: integer read FPanelIndex write SetPanelIndex;
  property PanelOffset: integer read FPanelOffset write SetPanelOffset;
  
published

{$IFDEF IBO_VCL40_OR_GREATER}
  property Anchors;
  property BiDiMode;
  property Constraints;
{$ENDIF}
  property Align;
  property Color;
  property DragCursor;
  property DragMode;
  property Enabled;
  property Font;
  property ParentColor;
  property ParentFont;
  property ParentShowHint;
  property PopupMenu;
  property TabOrder;
  property TabStop default true;

  property AllowDelete: boolean read FAllowDelete
                                write FAllowDelete
                                default true;
  property AllowInsert: boolean read FAllowInsert
                                write FAllowInsert
                                default true;
  property AllowTabToPost: boolean read FAllowTabToPost
                                   write FAllowTabToPost
                                   default true;
  property Orientation: TIB_CtrlGridOrientation read FOrientation
                                                write SetOrientation
                                                default goVertical;
  property ColCount: integer read FColCount
                             write SetColCount
                             stored IsColCountStored;
  property RowCount: integer read FRowCount
                             write SetRowCount
                             stored IsRowCountStored;
  property DataSource: TIB_DataSource read GetDataSource write SetDataSource;
  property PanelBorder: TIB_CtrlGridBorder read FPanelBorder
                                           write SetPanelBorder
                                           default gbRaised;
  property PanelHeightFixed: boolean read FPanelHeightFixed
                                     write SetPanelHeightFixed
                                     default false;
  property PanelHeight: integer read FPanelHeight
                                write SetPanelHeight
                                stored IsPanelHeightStored;
  property PanelWidthFixed: boolean read FPanelWidthFixed
                                    write SetPanelWidthFixed
                                    default false;
  property PanelWidth: integer read FPanelWidth
                               write SetPanelWidth
                               stored IsPanelWidthStored;
  property SelectedColor: TColor read FSelectedColor
                                 write SetSelectedColor
                                 stored FSelColorChanged
                                 default clWindow;
  property ShowFocus: boolean read FShowFocus write FShowFocus default true;
  property PartialRows: boolean read FPartialRows
                                    write SetPartialRows
                                    default false;
  property PartialCols: boolean read FPartialCols
                                    write SetPartialCols
                                    default false;

  property PartialColMargin: word read FPartialColMargin
                                  write SetPartialColMargin
                                  default 10;
  property PartialRowMargin: word read FPartialRowMargin
                                  write SetPartialRowMargin
                                  default 10;
  property ShowHint;
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
  property OnPaintPanel: TIB_PaintPanelEvent read FOnPaintPanel
                                             write FOnPaintPanel;
  property OnStartDrag;
end;

implementation

const
  DefaultPanelHeight = 72;
  DefaultPanelWidth = 200;

{ TIB_CtrlGridLink }

constructor TIB_CtrlGridLink.Create( AOwner: TComponent );
begin
  if AOwner is TIB_CtrlGrid then
  begin
    inherited Create( AOwner );
    FIsGridLink := true;
    FIB_CtrlGrid := AOwner as TIB_CtrlGrid;
  end
  else
    raise EIB_Error.Create( 'Invalid Owner for TIB_CtrlGridLink' );
end;

procedure TIB_CtrlGridLink.SysStateChanged;
begin
  if State <> dssEdit then
    FIB_CtrlGrid.DatasetChanged( false );
end;

procedure TIB_CtrlGridLink.DatasetChanged;
begin
  FIB_CtrlGrid.DatasetChanged( false );
end;

procedure TIB_CtrlGridLink.SysBindingChanged;
begin
  FIB_CtrlGrid.BindDataLinks( FIB_CtrlGrid.FPanel, BoundToBuffer );
end;

procedure TIB_CtrlGridLink.SysDataChange( AColumn: TIB_Column );
begin
  inherited SysDataChange( AColumn );
  FIB_CtrlGrid.SysDataChange( AColumn );
end;

procedure TIB_CtrlGridLink.ProcessGridEvent( AEvent: TIB_StatementEventType;
                                             Info: longint );
begin
  //~inherited ProcessStatementEvent( AEvent, Info );
  if AEvent = setInvalidateRows then
    FIB_CtrlGrid.Repaint;
end;

{ TIB_CtrlPanel }

constructor TIB_CtrlPanel.CreateLinked( IB_CtrlGrid: TIB_CtrlGrid );
begin
  inherited Create( IB_CtrlGrid );
  ControlStyle := [ csAcceptsControls,
                    csCaptureMouse,
                    csClickEvents,
                    csDoubleClicks,
                    csOpaque,
                    csReplicatable ];
  FIB_CtrlGrid := IB_CtrlGrid;
  Parent := IB_CtrlGrid;
end;

procedure TIB_CtrlPanel.CreateParams( var Params: TCreateParams );
begin
  inherited CreateParams( Params );
  with Params.WindowClass do
    Style := Style and not ( CS_HREDRAW or CS_VREDRAW );
end;

procedure TIB_CtrlPanel.PaintWindow( DC: HDC );
var
  R: TRect;
  Selected: boolean;
begin
  with FIB_CtrlGrid do
  begin
    if DataLink.BufferActive then
    begin
      Selected := not DataLink.BoundToBuffer;
      DrawPanelBackground( DC, Self.ClientRect, true, Selected );
      FCanvas.Handle := DC;
      try
        FCanvas.Font := Font;
        FCanvas.Brush.Style := bsSolid;
        FCanvas.Brush.Color := Color;
        PaintPanel( DataLink.BufferRecord );
        if FShowFocus and FFocused and Selected then
        begin
          R := Self.ClientRect;
          if PanelBorder = gbRaised then
            InflateRect( R, -2, -2 );
          FCanvas.Brush.Color := Color;
          FCanvas.DrawFocusRect( R );
        end;
      finally
        FCanvas.Handle := 0;
      end;
    end
    else
      DrawPanelBackground( DC,
                           Self.ClientRect,
                           true,
                           ( csDesigning in ComponentState ) or
                           ( DataLink.State = dssSearch ));
  end;
end;

procedure TIB_CtrlPanel.CMControlListChange( var Message: TCMControlListChange);
begin
  FIB_CtrlGrid.UpdateDataLinks( Message.Control, Message.Inserting );
end;

procedure TIB_CtrlPanel.WMPaint( var Message: TWMPaint );
var
  DC: HDC;
  PS: TPaintStruct;
begin
  if Message.DC = 0 then
  begin
    FIB_CtrlGrid.CreatePanelBitmap;
    try
      Message.DC := FIB_CtrlGrid.FPanelDC;
      PaintHandler( Message );
      Message.DC := 0;
      DC := BeginPaint( Handle, PS );
      BitBlt( DC, 0, 0, Width, Height, FIB_CtrlGrid.FPanelDC, 0, 0, SRCCOPY );
      EndPaint( Handle, PS );
    finally
      FIB_CtrlGrid.DestroyPanelBitmap;
    end;
  end
  else
    PaintHandler( Message );
end;

procedure TIB_CtrlPanel.WMNCHitTest( var Message: TWMNCHitTest );
begin
  if csDesigning in ComponentState then
    Message.Result := HTCLIENT
  else
    Message.Result := HTTRANSPARENT;
end;

procedure TIB_CtrlPanel.WMEraseBkgnd( var Message: TMessage );
begin
  Message.Result := 1;
end;

{ TIB_CtrlGrid }

constructor TIB_CtrlGrid.Create(AOwner: TComponent);
begin
  FDataLink := TIB_CtrlGridLink.Create( Self );
  inherited Create( AOwner );
  FCanvas := TCanvas.Create;
  FPanel := TIB_CtrlPanel.CreateLinked( Self );
  inherited TabStop := true;
  inherited Width := 410;
  inherited Height := 205;
  ControlStyle := [ csOpaque, csDoubleClicks ];
  FColCount := 1;
  FRowCount := 3;
  FPartialColMargin := 10;
  FPartialRowMargin := 10;
  FPanelHeight := DefaultPanelHeight;
  FPanelWidth := DefaultPanelWidth;
  FPanelBorder := gbRaised;
  FAllowInsert := true;
  FAllowDelete := true;
  FAllowTabToPost := true;
  FShowFocus := true;
  FSelectedColor := Color;
end;

destructor TIB_CtrlGrid.Destroy;
begin
  FCanvas.Free;
  FCanvas := nil;
  inherited Destroy;
end;

procedure TIB_CtrlGrid.Loaded;
begin
  inherited Loaded;
  SetPanelBounds( ColCount, RowCount, PanelWidth, PanelHeight );
end;

procedure TIB_CtrlGrid.CreateParams( var Params: TCreateParams );
begin
  inherited CreateParams( Params );
  with Params do
  begin
    Style := Style or WS_CLIPCHILDREN;
    WindowClass.style := WindowClass.style and not ( CS_HREDRAW or CS_VREDRAW );
  end;
end;

procedure TIB_CtrlGrid.CreateWnd;
begin
  inherited CreateWnd;
  if FOrientation = goVertical then
    FScrollBarKind := SB_VERT
  else
    FScrollBarKind := SB_HORZ;
  if not DataLink.Prepared then
    SetScrollRange( Handle, FScrollBarKind, 0, 4, false );
  UpdateScrollBar;
end;

function TIB_CtrlGrid.AcquireFocus: boolean;
begin
  Result := true;
  if not ( Focused or EditMode ) then
  begin
    SetFocus;
    Result := Focused;
  end;
end;

procedure TIB_CtrlGrid.SysDataChange( AColumn: TIB_Column );
begin
  if DataLink.Disabled then Exit;
  if DataLink.Prepared then
    if DataLink.ActiveRecord <> PanelOffset + PanelIndex then
      DatasetChanged( true );
end;

procedure TIB_CtrlGrid.UpdateBufferCount;
begin
  if DataLink.Prepared then
    with DataLink.Dataset do
      if not BufferHasEof and
         ( PanelOffset + RowCount * ColCount >= BufferRowCount ) then
      begin
        BeginCallbackFreeze;
        try
          BufferRowNum := PanelOffset + RowCount * ColCount - 1;
        finally
          EndCallbackFreeze;
        end;
      end;
end;

procedure TIB_CtrlGrid.DatasetChanged( Reset: boolean );
var
  NewPanelIndex: integer;
  NewPanelCount: integer;
  NewPanelOffset: integer;
begin
  if FDatasetChanging then
//  MessageBeep(0)
  else
  if not ( csDestroying in ComponentState ) then
  try
    FDatasetChanging := true;
    NewPanelOffset := 0;
    NewPanelIndex := 0;
    NewPanelCount := 0;
    if Assigned( DataLink ) then
      with DataLink do
        if BufferActive then
        begin
          UpdateBufferCount;
          if DataLink.Dataset.Bof then
          begin
            NewPanelOffset := 1;
            NewPanelIndex := 0;
            NewPanelCount := DataLink.BufferCount;
          end
          else
          if DataLink.Dataset.Eof then
          begin
            NewPanelCount := DataLink.BufferCount;
            if NewPanelCount > RowCount * ColCount then
              NewPanelCount := RowCount * ColCount;
            NewPanelIndex := NewPanelCount - 1;
            NewPanelOffset := DataLink.ActiveRecord - NewPanelCount - 1;
            if NewPanelOffset < 1 then
              NewPanelOffset := 1;
          end
          else
          begin
            NewPanelOffset := PanelOffset;
            if NewPanelOffset < 1 then
              NewPanelOffset := 1;
            NewPanelIndex := DataLink.ActiveRecord - NewPanelOffset;
            if NewPanelIndex < 0 then
            begin
              NewPanelOffset := DataLink.ActiveRecord;
              NewPanelIndex := 0;
            end
            else
            if NewPanelIndex > RowCount * ColCount - 1 then
            begin
              NewPanelOffset := DataLink.ActiveRecord - RowCount * ColCount + 1;
              NewPanelIndex := RowCount * ColCount - 1;
              if NewPanelOffset < 1 then
              begin
                NewPanelIndex := NewPanelIndex - NewPanelOffset + 1;
                NewPanelOffset := 1;
              end;
            end;
            BufferRecord := NewPanelOffset + RowCount * ColCount;
            NewPanelCount := DataLink.BufferCount - NewPanelOffset + 1;
            if NewPanelCount < 1 then
              NewPanelCount := 1
            else
            if NewPanelCount > RowCount * ColCount then
              NewPanelCount := RowCount * ColCount;
          end;
          if NewPanelCount <= 0 then
            NewPanelCount := 1;
        end
        else
        if ( csDesigning in Self.ComponentState ) or
           ( State in [dssSearch, dssPrepared] ) then
        begin
          NewPanelOffset := 0;
          NewPanelIndex := 0;
          NewPanelCount := 1;
        end;
    FPanelOffset := NewPanelOffset;
    FPanelIndex := NewPanelIndex;
    FPanelCount := NewPanelCount;
    if PanelIndex in [ 0..PanelCount - 1 ] then
    begin
      UpdatePanelBounds( true, Reset );
      FPanel.Visible := true;
    end
    else
      FPanel.Visible := false;
    Invalidate;
    UpdateScrollBar;
  finally
    FDatasetChanging := false;
  end;
end;

procedure TIB_CtrlGrid.UpdatePanelBounds( Focus: boolean; Reset: boolean );
var
  FocusedControl: TWinControl;
  R: TRect;
begin
  FocusedControl := nil;
  R := GetPanelBounds( PanelIndex );
  if Reset or not HandleAllocated then
  begin
    FPanel.Visible := false;
    RefreshDatalinks( FPanel );
    FPanel.BoundsRect := R;
    FPanel.Invalidate;
    FPanel.Update;
    FPanel.Visible := true;
  end
  else
  begin
    if Focus then
    begin
      FocusedControl := FindControl( GetFocus );
      if ( FocusedControl <> FPanel ) and
         FPanel.ContainsControl( FocusedControl ) then
        FPanel.SetFocus;
    end;
    SetWindowPos( FPanel.Handle,
                  0,
                  R.Left,
                  R.Top,
                  R.Right - R.Left,
                  R.Bottom - R.Top,
                  SWP_NOZORDER or SWP_NOREDRAW );
    RedrawWindow( FPanel.Handle,
                  nil,
                  0,
                  RDW_INVALIDATE or RDW_ALLCHILDREN );
  end;
  if not FClicking and Assigned( FocusedControl ) and 
     FocusedControl.CanFocus then
    FocusedControl.SetFocus;
end;

procedure TIB_CtrlGrid.Scroll( AInc: integer; ScrollLock: boolean );
begin
  if DataLink.Prepared and (AInc <> 0) then
    with DataLink.Dataset do
    begin
      if State = dssInsert then
      begin
        UpdateRecord;
        if Modified then
          Post
        else
        if ( AInc < 0 ) or not Eof then
          Cancel;
      end
      else
      if State <> dssSearch then
      begin
        CheckBrowseMode;
        DisableControls;
        try
          MoveBy( AInc );
          if Eof then
            Last
          else
          if Bof then
            First;
        finally
          EnableControls;
        end;
      end;
      EditMode := false;
      Invalidate;
    end;
end;

procedure TIB_CtrlGrid.SetBounds( ALeft, ATop, AWidth, AHeight: integer );
begin
  inherited SetBounds( ALeft, ATop, AWidth, AHeight );
  if not FDatasetChanging then
    SetPanelBounds( ColCount, RowCount, PanelWidth, PanelHeight );
end;

procedure TIB_CtrlGrid.SetPanelBounds( NewColCount,
                                       NewRowCount,
                                       NewPanelWidth,
                                       NewPanelHeight: integer );
var
  ScrollWidth: integer;
  ScrollHeight: integer;
begin
  if Orientation = goVertical then
  begin
    ScrollWidth := GetSystemMetrics( SM_CXVSCROLL );
    ScrollHeight := 0;
  end
  else
  begin
    ScrollWidth := 0;
    ScrollHeight := GetSystemMetrics( SM_CYHSCROLL );
  end;
  if NewPanelWidth < 1 then NewPanelWidth := 1;
  if NewPanelHeight < 1 then NewPanelHeight := 1;
  if NewRowCount < 1 then NewRowCount := 1;
  if NewColCount < 1 then NewColCount := 1;
  if PanelHeightFixed then
  begin
    if PartialRows then
      Dec( ScrollHeight, PanelHeight - PartialRowMargin );
    NewRowCount := ( Height - ScrollHeight ) div NewPanelHeight;
  end
  else
    NewPanelHeight := ( Height - ScrollHeight ) div NewRowCount;
  if PanelWidthFixed then
  begin
    if PartialCols then
      Dec( ScrollWidth, PanelWidth - PartialColMargin );
    NewColCount := ( Width - ScrollWidth ) div NewPanelWidth;
  end
  else
    NewPanelWidth := ( Width - ScrollWidth ) div NewColCount;
  if NewPanelWidth < 1 then NewPanelWidth := 1;
  if NewPanelHeight < 1 then NewPanelHeight := 1;
  if (( FPanelWidth < NewPanelWidth ) or
      ( FPanelHeight < NewPanelHeight )) and
     ( PanelBorder = gbRaised ) then
    FPanel.Invalidate;
  if NewRowCount < 1 then NewRowCount := 1;
  if NewColCount < 1 then NewColCount := 1;
  if ( FPanelWidth <> NewPanelWidth ) or
     ( FPanelHeight <> NewPanelHeight ) or
     ( FColCount <> NewColCount ) or
     ( FRowCount <> NewRowCount ) then
  begin
    FPanelWidth := NewPanelWidth;
    FPanelHeight := NewPanelHeight;
    FColCount := NewColCount;
    FRowCount := NewRowCount;
    DatasetChanged( true );
  end
  else
    UpdatePanelBounds( false, true );
end;

procedure TIB_CtrlGrid.CreatePanelBitmap;
var
  DC: HDC;
begin
  if FBitmapCount = 0 then
  begin
    DC := GetDC(0);
    FPanelBitmap := CreateCompatibleBitmap( DC, FPanel.Width, FPanel.Height );
    ReleaseDC(0, DC);
    FPanelDC := CreateCompatibleDC(0);
    FSaveBitmap := SelectObject( FPanelDC, FPanelBitmap );
  end;
  Inc( FBitmapCount );
end;

procedure TIB_CtrlGrid.DestroyPanelBitmap;
begin
  Dec( FBitmapCount );
  if FBitmapCount = 0 then
  begin
    SelectObject( FPanelDC, FSaveBitmap );
    DeleteDC( FPanelDC );
    DeleteObject( FPanelBitmap );
  end;
end;

procedure TIB_CtrlGrid.DoKey( Key: TIB_CtrlGridKey );
var
  HInc, VInc: integer;
  ALink: TIB_DataLink;
{$IFDEF IBO_VCL30_OR_GREATER}
  ParentForm: TCustomForm;
{$ELSE}
  ParentForm: TForm;
{$ENDIF}
  AControl: TWinControl;
begin
  if DataLink.Prepared then
  begin
    if Orientation = goVertical then
    begin
      HInc := 1;
      VInc := ColCount;
    end
    else
    begin
      HInc := RowCount;
      VInc := 1;
    end;
    with DataLink.Dataset do
    begin
      case Key of
      gkEditMode: EditMode := not EditMode;
      gkPriorTab: SelectNext( false );
      gkNextTab: SelectNext( true );
      gkLeft: Scroll( -HInc, false );
      gkRight: if BufferActive and
                  BufferHasEof and ( RowNum = BufferRowCount ) then
        Key := gkAppend
      else
        Scroll( HInc, false );
      gkUp: Scroll( -VInc, false );
      gkDown: if BufferActive and
                 BufferHasEof and ( RowNum = BufferRowCount ) then
        Key := gkAppend
      else
        Scroll( VInc, false );
      gkScrollUp: Scroll( -VInc, true );
      gkScrollDown: Scroll( VInc, true );
      gkPageUp: Scroll( -RowCount * ColCount + 1, true );
      gkPageDown: Scroll( RowCount * ColCount - 1, true );
      gkHome: First;
      gkEnd: Last;
      end;
      case Key of
      gkInsert:
        if AllowInsert and CanModify then
        begin
          Insert;
          EditMode := true;
        end;
      gkAppend:
        if AllowInsert and CanModify then begin
          Append;
          EditMode := true;
        end;
      gkDelete:
        if AllowDelete and CanModify then begin
          Delete;
          EditMode := false;
        end;
      gkCancel:
        begin
          ParentForm := GetParentForm( Self );
          if Assigned( ParentForm ) then
          begin
            AControl := ParentForm.ActiveControl;
            if Assigned( AControl ) then
            begin
              ALink := TIB_DataLink( AControl.Perform( CM_GETDATALINK, 0, 0 ));
              if (ALink is TIB_ControlDataLink) then
                with (ALink as TIB_ControlDataLink) do
                  if ControlIsModified then
                  begin
                    ControlIsModified := false;
                    ALink.DataChange;
                    Exit;
                  end;
              if (ALink is TIB_FieldDataLink) then
                with (ALink as TIB_FieldDataLink) do
                  if Field.IsModified then
                  begin
                    Field.Revert;
                    Exit;
                  end;
            end;
          end;
          if NeedToPost then Cancel;
          EditMode := false;
        end;
      end;
    end;
  end;
end;

function TIB_CtrlGrid.GetChildParent: TComponent;
begin
  Result := FPanel;
end;

{$IFDEF IBO_VCL30_OR_GREATER}
procedure TIB_CtrlGrid.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  FPanel.GetChildren( Proc, Root );
end;
{$ELSE}
procedure TIB_CtrlGrid.GetChildren(Proc: TGetChildProc );
begin
  FPanel.GetChildren( Proc );
end;
{$ENDIF}

function TIB_CtrlGrid.GetDataSource: TIB_DataSource;
begin
  Result := DataLink.DataSource;
end;

function TIB_CtrlGrid.GetEditMode: boolean;
begin
  Result := not Focused and ContainsControl( FindControl( GetFocus ));
end;

function TIB_CtrlGrid.GetPanelBounds( Index: integer ): TRect;
var
  Col, Row: integer;
begin
  if FOrientation = goVertical then begin
    Col := Index mod ColCount;
    Row := Index div ColCount;
  end else begin
    Col := Index div RowCount;
    Row := Index mod RowCount;
  end;
  Result.Left   := PanelWidth  * Col;
  Result.Top    := PanelHeight * Row;
  Result.Right  := Result.Left + PanelWidth;
  Result.Bottom := Result.Top  + PanelHeight;
end;

procedure TIB_CtrlGrid.GetTabOrderList( List: TList );
begin
end;

procedure TIB_CtrlGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
  GridKey: TIB_CtrlGridKey;
begin
  inherited KeyDown(Key, Shift);
  GridKey := gkNull;
  case Key of
    VK_LEFT:  GridKey := gkLeft;
    VK_RIGHT: GridKey := gkRight;
    VK_UP:    GridKey := gkUp;
    VK_DOWN:  GridKey := gkDown;
    VK_PRIOR: GridKey := gkPageUp;
    VK_NEXT:  GridKey := gkPageDown;
    VK_HOME:  GridKey := gkHome;
    VK_END:   GridKey := gkEnd;
    VK_RETURN,
    VK_F2:    GridKey := gkEditMode;
    VK_INSERT:
      if GetKeyState( VK_CONTROL ) >= 0 then begin
        GridKey := gkInsert;
      end else begin
        GridKey := gkAppend;
      end;
    VK_DELETE: if GetKeyState( VK_CONTROL ) < 0 then begin
      GridKey := gkDelete;
    end;
    VK_ESCAPE: GridKey := gkCancel;
  end;
  DoKey( GridKey );
end;

procedure TIB_CtrlGrid.PaintWindow(DC: HDC);
var
  ii: integer;
  Brush: HBrush;
  ARect: TRect;
  ScrollWidth: integer;
  ScrollHeight: integer;
begin
  if FWindowPainting then
  else
  try
    FWindowPainting := true;
    if ( csDesigning in ComponentState ) or
       ( DataLink.State = dssSearch ) then
    begin
      if DataLink.BoundToBuffer <> false then
        DataLink.BoundToBuffer := false;
      FPanel.Update;
      Brush := CreateHatchBrush( HS_BDIAGONAL, ColorToRGB( clBtnShadow ));
      try
        SetBkColor( DC, ColorToRGB( Color ));
        ARect.Top := 0;
        ARect.Left := 0;
        ARect.Bottom := RowCount * PanelHeight;
        ARect.Right := ColCount * PanelWidth;
        FillRect( DC, ARect, Brush );
      finally
        DeleteObject( Brush );
      end;
      for ii := 0 to ColCount * RowCount - 1 do
        DrawPanelBackground( DC, GetPanelBounds( ii ), false, false );
    end
    else
    begin
      CreatePanelBitmap;
      try
        try
          for ii := 0 to RowCount * ColCount - 1 do
            DrawPanel( DC, ii );
        finally
          if DataLink.BoundToBuffer <> false then
            DataLink.BoundToBuffer := false;
//          FPanel.Update;
//          DrawPanel( DC, -1 );
        end;
      finally
        DestroyPanelBitmap;
      end;
    end;
    if Orientation = goVertical then
    begin
      ScrollWidth := GetSystemMetrics( SM_CXVSCROLL );
      ScrollHeight := 0;
    end
    else
    begin
      ScrollWidth := 0;
      ScrollHeight := GetSystemMetrics( SM_CYHSCROLL );
    end;
    if HandleAllocated then
    begin
      if ( Height - ScrollHeight > FPanel.Height * RowCount ) then
      begin
        Brush := CreateSolidBrush( ColorToRGB( Color ));
        FillRect( DC, Rect( 0,
                            PanelHeight * RowCount,
                            Width,
                            Height - ScrollHeight ), Brush );
        DeleteObject( Brush );
      end;
      if ( Width - ScrollWidth > FPanel.Width * ColCount ) then
      begin
        Brush := CreateSolidBrush( ColorToRGB( Color ));
        FillRect( DC, Rect( PanelWidth * ColCount,
                            0,
                            Width - ScrollWidth,
                            Height ), Brush );
        DeleteObject( Brush );
      end;
    end;
  finally
    FWindowPainting := false;
  end;
end;

{
procedure TDBCtrlGrid.DrawPanel(DC: HDC; Index: Integer);
var
  SaveActive: Integer;
  R: TRect;
begin
  R := GetPanelBounds(Index);
  if Index < FPanelCount then
  begin
    SaveActive := FDataLink.ActiveRecord;
    FDataLink.ActiveRecord := Index;
    FPanel.PaintTo(FPanelDC, 0, 0);
    FDataLink.ActiveRecord := SaveActive;
  end else
    DrawPanelBackground(FPanelDC, FPanel.ClientRect, True, False);
  BitBlt(DC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
    FPanelDC, 0, 0, SRCCOPY);
end;
}
procedure TIB_CtrlGrid.DrawPanel( DC: HDC; Index: integer );
var
  R: TRect;
begin
{
  if Index = -1 then
  begin
    DataLink.BufferRecord := DataLink.ActiveRecord;
    PaintPanel( DataLink.ActiveRecord );
    Exit;
  end;
}
  if ( Index < PanelCount ) and DataLink.BufferActive then
    DataLink.BufferRecord := PanelOffset + Index;
  if DataLink.BufferActive and
     ( DataLink.ActiveRecord = PanelOffset + Index ) then
    Exit
  else
  if Index < PanelCount then
  begin
    if DataLink.BoundToBuffer <> true then
      DataLink.BoundToBuffer := true;
    RefreshDataLinks( FPanel );
    FPanel.PaintTo( FPanelDC, 0, 0 );
  end
  else
    DrawPanelBackground( FPanelDC, FPanel.ClientRect, true, false );
  R := GetPanelBounds( Index );
  BitBlt( DC,
          R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
          FPanelDC, 0, 0, SRCCOPY );
end;

procedure TIB_CtrlGrid.DrawPanelBackground(       DC: HDC;
                                            const R: TRect;
                                                  Erase,
                                                  Selected: boolean );
var
  Brush: HBrush;
begin
  if Erase then begin
    if Selected then begin
      FPanel.Color := FSelectedColor;
    end else begin
      FPanel.Color := Color;
    end;
    Brush := CreateSolidBrush( ColorToRGB( FPanel.Color ));
    FillRect( DC, R, Brush );
    DeleteObject( Brush );
  end;
  if FPanelBorder = gbRaised then begin
    DrawEdge( DC, PRect(@R)^, BDR_RAISEDINNER, BF_RECT );
  end;
end;

procedure TIB_CtrlGrid.PaintPanel( Index: integer );
begin
  if Assigned( FOnPaintPanel ) then begin
    FOnPaintPanel( Self, Index );
  end;
end;

function TIB_CtrlGrid.PointInPanel( const P: TSmallPoint ): boolean;
begin
  Result := ( FPanelCount > 0 ) and
            PtInRect( GetPanelBounds( FPanelIndex ),
            SmallPointToPoint( P ));
end;

procedure TIB_CtrlGrid.ReadState( Reader: TReader );
begin
  inherited ReadState( Reader );
  FPanel.FixupTabList;
end;

procedure TIB_CtrlGrid.ScrollMessage(var Message: TWMScroll);
var
  Key: TIB_CtrlGridKey;
  SI: TScrollInfo;
begin
  if AcquireFocus then begin
    Key := gkNull;
    case Message.ScrollCode of
      SB_LINEUP: Key := gkScrollUp;
      SB_LINEDOWN: Key := gkScrollDown;
      SB_PAGEUP: Key := gkPageUp;
      SB_PAGEDOWN: Key := gkPageDown;
      SB_TOP: Key := gkHome;
      SB_BOTTOM: Key := gkEnd;
      SB_THUMBPOSITION:
        if DataLink.BufferActive then begin
          SI.cbSize := sizeof(SI);
          SI.fMask := SIF_ALL;
          GetScrollInfo( Self.Handle, FScrollBarKind, SI );
          if SI.nTrackPos <= 1 then
            Key := gkHome
          else if SI.nTrackPos >= DataLink.BufferCount then
            Key := gkEnd
          else begin
            DataLink.ActiveRecord := SI.nTrackPos;
            Exit;
          end;
        end else begin
          Key := gkHome;
        end;
    end;
    DoKey( Key );
  end;
end;

function TIB_CtrlGrid.FindNext(     StartControl: TWinControl;
                                    GoForward: boolean;
                                var WrapFlag: integer ): TWinControl;
var
  I, StartIndex, LastTabStopIndex: integer;
  List: TList;
begin
  List := TList.Create;
  try
    StartIndex := 0;
    I := 0;
    Result := StartControl;
    FPanel.GetTabOrderList(List);
    if List.Count > 0 then
    begin
      LastTabStopIndex := List.Count - 1;
      while (LastTabStopIndex >= 0) and (not TWinControl(List[LastTabStopIndex]).TabStop) do
        dec(LastTabStopIndex);

      StartIndex := List.IndexOf( StartControl );
      if StartIndex = -1 then
        if GoForward then
          StartIndex := List.Count - 1 else
          StartIndex := 0;
      I := StartIndex;
      repeat
        if GoForward then begin
          Inc(I);
          if (I = List.Count) or ((I > LastTabStopIndex) and (StartIndex <= LastTabStopIndex)) then begin
            I := 0;
          end;
        end else begin
          if I = 0 then begin
            I := List.Count;
          end;
          Dec(I);
        end;
        Result := List[I];
      until ( Result.CanFocus and Result.TabStop ) or ( I = StartIndex );
    end;
    WrapFlag := 0;
    if GoForward then begin
      if I <= StartIndex then WrapFlag := 1;
    end else begin
      if I >= StartIndex then WrapFlag := -1;
    end;
  finally
    List.Free;
  end;
end;

procedure TIB_CtrlGrid.SelectNext( GoForward: boolean );
var
  WrapFlag: integer;
{$IFDEF IBO_VCL30_OR_GREATER}
  ParentForm: TCustomForm;
{$ELSE}
  ParentForm: TForm;
{$ENDIF}
  ActiveControl, Control: TWinControl;
  ADataset: TIB_BDataset;
begin
  ParentForm := GetParentForm(Self);
  if Assigned( ParentForm ) then begin
    ActiveControl := ParentForm.ActiveControl;
    if ContainsControl( ActiveControl ) then begin
      Control := FindNext( ActiveControl, GoForward, WrapFlag );
      if not FDataLink.Dataset.NeedToPost then begin
        FPanel.SetFocus;
      end;
      ADataset := nil;
      if Datalink.Dataset is TIB_BDataset then begin
        ADataset := Datalink.Dataset as TIB_BDataset;
      end;
      if Assigned( ADataset ) and ( ADataset.State <> dssSearch ) then try
        if ( WrapFlag = 1 ) and
           AllowInsert and
           DataSource.AutoInsert and
           ADataset.CanInsert and
           ADataset.BufferHasEOF and
           ( ADataset.RowNum = ADataset.BufferRowCount ) then begin
          if not ADataset.NeedToPost or ADataset.Modified then begin
            DataLink.Append;
          end;
        end else if WrapFlag <> 0 then begin
          if AllowTabToPost or not FDataLink.Dataset.NeedToPost then begin
            Scroll( WrapFlag, false );
          end;
        end;
      except
        if Assigned( ActiveControl ) then ActiveControl.SetFocus;
        raise;
      end;
      if not Control.CanFocus then begin
        Control := FindNext( Control, GoForward, WrapFlag );
      end;
      Control.SetFocus;
    end;
  end;
end;

procedure TIB_CtrlGrid.SetDataSource( AValue: TIB_DataSource);
begin
  FDataLink.DataSource := AValue;
  UpdateDataLinks( FPanel, true );
end;

procedure TIB_CtrlGrid.SetEditMode( AValue: boolean);
var
  Control: TWinControl;
begin
  if GetEditMode <> AValue then
  begin
    if AValue then
    begin
      Control := FPanel.FindNextControl( nil, true, true, false );
      if Control <> nil then
        Control.SetFocus;
    end
    else
      SetFocus;
  end;
end;

procedure TIB_CtrlGrid.SetPanelOffset( AValue: integer );
begin
end;

procedure TIB_CtrlGrid.SetPanelIndex( AValue: integer );
begin
  if DataLink.BufferActive then
    DataLink.ActiveRecord := AValue + PanelOffset;
end;

procedure TIB_CtrlGrid.SetOrientation( AValue: TIB_CtrlGridOrientation);
begin
  if FOrientation <> AValue then
  begin
    FOrientation := AValue;
    RecreateWnd;
    SetPanelBounds( ColCount, RowCount, PanelWidth, PanelHeight );
  end;
end;

procedure TIB_CtrlGrid.SetPanelBorder( AValue: TIB_CtrlGridBorder);
begin
  if FPanelBorder <> AValue then
  begin
    FPanelBorder := AValue;
    Invalidate;
    FPanel.Invalidate;
  end;
end;

function TIB_CtrlGrid.IsPanelHeightStored: boolean;
begin
  Result := PanelHeightFixed and ( PanelHeight <> DefaultPanelHeight );
end;

function TIB_CtrlGrid.IsPanelWidthStored: boolean;
begin
  Result := PanelWidthFixed and ( PanelWidth <> DefaultPanelWidth );
end;

procedure TIB_CtrlGrid.SetPanelHeightFixed( AValue: boolean );
begin
  if PanelHeightFixed <> AValue then
  begin
    FPanelHeightFixed := AValue;
    SetPanelBounds( ColCount, RowCount, PanelWidth, PanelHeight );
  end;
end;

procedure TIB_CtrlGrid.SetPanelWidthFixed( AValue: boolean );
begin
  if PanelWidthFixed <> AValue then
  begin
    FPanelWidthFixed := AValue;
    SetPanelBounds( ColCount, RowCount, PanelWidth, PanelHeight );
  end;
end;

procedure TIB_CtrlGrid.SetPanelHeight( AValue: integer );
begin
  if AValue < 1 then AValue := 1;
  if AValue > MaxWord then AValue := MaxWord;
  if FPanelHeight <> AValue then
    SetPanelBounds( ColCount, RowCount, PanelWidth, AValue );
end;

procedure TIB_CtrlGrid.SetPanelWidth( AValue: integer );
begin
  if AValue < 1 then AValue := 1;
  if AValue > MaxWord then AValue := MaxWord;
  if FPanelWidth <> AValue then
    SetPanelBounds( ColCount, RowCount, AValue, PanelHeight );
end;

procedure TIB_CtrlGrid.SetPartialCols( AValue: boolean );
begin
  if PartialCols <> AValue then
  begin
    FPartialCols := AValue;
    SetPanelBounds( ColCount, RowCount, PanelWidth, PanelHeight );
  end;
end;

procedure TIB_CtrlGrid.SetPartialRows( AValue: boolean );
begin
  if PartialRows <> AValue then
  begin
    FPartialRows := AValue;
    SetPanelBounds( ColCount, RowCount, PanelWidth, PanelHeight );
  end;
end;

procedure TIB_CtrlGrid.SetPartialColMargin( AValue: word );
begin
  if PartialColMargin <> AValue then
  begin
    FPartialColMargin := AValue;
    SetPanelBounds( ColCount, RowCount, PanelWidth, PanelHeight );
  end;
end;

procedure TIB_CtrlGrid.SetPartialRowMargin( AValue: word );
begin
  if PartialRowMargin <> AValue then
  begin
    FPartialRowMargin := AValue;
    SetPanelBounds( ColCount, RowCount, PanelWidth, PanelHeight );
  end;
end;

function TIB_CtrlGrid.IsColCountStored: boolean;
begin
  Result := ( ColCount <> 1 ) and not PanelWidthFixed;
end;

function TIB_CtrlGrid.IsRowCountStored: boolean;
begin
  Result := ( RowCount <> 3 ) and not PanelHeightFixed;
end;

procedure TIB_CtrlGrid.SetColCount( AValue: integer );
begin
  if AValue < 1 then AValue := 1;
  if AValue > 100 then AValue := 100;
  if FColCount <> AValue then
    SetPanelBounds( AValue, RowCount, PanelWidth, PanelHeight );
end;

procedure TIB_CtrlGrid.SetRowCount( AValue: integer );
begin
  if AValue < 1 then AValue := 1;
  if AValue > 100 then AValue := 100;
  if FRowCount <> AValue then
    SetPanelBounds( ColCount, AValue, PanelWidth, PanelHeight );
end;

procedure TIB_CtrlGrid.SetSelectedColor( AValue: TColor);
begin
  if AValue <> FSelectedColor then
  begin
    FSelectedColor := AValue;
    FSelColorChanged := AValue <> Color;
    Invalidate;
    FPanel.Invalidate;
  end;
end;

procedure TIB_CtrlGrid.UpdateDataLinks( Control: TControl; Inserting: boolean );
var
  ii: integer;
  DataLink: TIB_DataLink;
begin
  if Inserting and not ( csReplicatable in Control.ControlStyle ) then 
    raise EIB_Error.Create( 'Control cannot be replicated' );
  DataLink := TIB_DataLink( Control.Perform( CM_GETDATALINK, 0, 0 ));
  if Assigned( DataLink ) and Inserting then
    DataLink.DataSource := DataSource;
  if Control is TWinControl then
    with TWinControl( Control ) do
      for ii := 0 to ControlCount - 1 do
        UpdateDataLinks( Controls[ii], Inserting );
end;

procedure TIB_CtrlGrid.BindDataLinks( Control: TControl; Buffer: boolean );
var
  ii: integer;
  DataLink: TIB_DataLink;
begin
  DataLink := TIB_DataLink( Control.Perform( CM_GETDATALINK, 0, 0 ));
  if Assigned( DataLink ) then
  begin
    DataLink.BoundToBuffer := Buffer;
    DataLink.DataChange;
  end;
  if Control is TWinControl then
    with TWinControl( Control ) do
      for ii := 0 to ControlCount - 1 do
        BindDataLinks( Controls[ii], Buffer );
end;

procedure TIB_CtrlGrid.RefreshDataLinks( Control: TControl );
var
  ii: integer;
  DataLink: TIB_DataLink;
begin
  DataLink := TIB_DataLink( Control.Perform( CM_GETDATALINK, 0, 0 ));
  if Assigned( DataLink ) then 
    DataLink.DataChange;
  if Control is TWinControl then
    with TWinControl( Control ) do
      for ii := 0 to ControlCount - 1 do
        RefreshDataLinks( Controls[ii] );
end;

procedure TIB_CtrlGrid.UpdateScrollBar;
var
  SIOld, SINew: TScrollInfo;
begin
  if FDatalink.Prepared and HandleAllocated then
  begin
    with FDatalink, Dataset do
    begin
      SIOld.cbSize := sizeof(SIOld);
      SIOld.fMask := SIF_ALL;
      GetScrollInfo(Self.Handle, FScrollBarKind, SIOld);
      SINew := SIOld;
      SINew.nMin := 1;
      SINew.nPage := Self.RowCount * Self.ColCount;
      SINew.nMax := SINew.nPage;
      if not BufferHasEof then 
        Inc( SINew.nMax, SINew.nPage );
      Inc( SINew.nMax, BufferRowCount - 1 );
      if State in [ dssInactive, dssBrowse, dssEdit ] then
        SINew.nPos := ActiveRecord;
      if longint(SINew.nMax) <= longint(SINew.nPage) then
        SINew.nMax := SINew.nPage + 1;
      if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
         (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) then
        SetScrollInfo(Self.Handle, FScrollBarKind, SINew, true);
    end;
  end;
end;

procedure TIB_CtrlGrid.WMLButtonDown( var Message: TWMLButtonDown );
var
  ii: integer;
  P: TPoint;
  Window: HWnd;
begin
  if FDataLink.Prepared then
  begin
    P := SmallPointToPoint( Message.Pos );
    for ii := 0 to FPanelCount - 1 do
    begin
      if ( ii <> FPanelIndex ) and PtInRect( GetPanelBounds( ii ), P ) then
      begin
        FClicking := true;
        try
          SetPanelIndex( ii );
        finally
          FClicking := false;
        end;
        P := ClientToScreen(P);
        Window := WindowFromPoint(P);
        if IsChild( FPanel.Handle, Window ) then
        begin
          Windows.ScreenToClient( Window, P );
          Message.Pos := PointToSmallPoint( P );
          with TMessage( Message ) do
            SendMessage( Window, Msg, WParam, LParam );
          Exit;
        end;
        Break;
      end;
    end;
  end;
  if AcquireFocus then
  begin
    if PointInPanel( Message.Pos ) then
    begin
      EditMode := false;
      Click;
    end;
    inherited;
  end;
end;

procedure TIB_CtrlGrid.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if PointInPanel( Message.Pos ) then
    DblClick;
  inherited;
end;

procedure TIB_CtrlGrid.WMHScroll(var Message: TWMHScroll);
begin
  ScrollMessage( Message );
end;

procedure TIB_CtrlGrid.WMVScroll(var Message: TWMVScroll);
begin
  ScrollMessage( Message );
end;

procedure TIB_CtrlGrid.WMEraseBkgnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

procedure TIB_CtrlGrid.WMPaint(var Message: TWMPaint);
begin
  PaintHandler( Message );
end;

procedure TIB_CtrlGrid.WMSetFocus(var Message: TWMSetFocus);
begin
  FFocused := true;
  FPanel.Repaint;
end;

procedure TIB_CtrlGrid.WMKillFocus(var Message: TWMKillFocus);
begin
  FFocused := false;
  FPanel.Repaint;
end;

procedure TIB_CtrlGrid.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

procedure TIB_CtrlGrid.WMSize(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

function GetShiftState: TShiftState;
begin
  Result := [];
  if GetKeyState( VK_SHIFT   ) < 0 then Include( Result, ssShift );
  if GetKeyState( VK_CONTROL ) < 0 then Include( Result, ssCtrl  );
  if GetKeyState( VK_MENU    ) < 0 then Include( Result, ssAlt   );
end;

procedure TIB_CtrlGrid.CMChildKey(var Message: TCMChildKey);
var
  ShiftState: TShiftState;
  GridKey: TIB_CtrlGridKey;
begin
  with Message do
    if Sender <> Self then
    begin
      ShiftState := GetShiftState;
      if Assigned(OnKeyDown) then OnKeyDown(Sender, CharCode, ShiftState);
      GridKey := gkNull;
      case CharCode of
        VK_TAB:
          if not (ssCtrl in ShiftState) and
            (Sender.Perform(WM_GETDLGCODE, 0, 0) and DLGC_WANTTAB = 0) then
            if ssShift in ShiftState then
              GridKey := gkPriorTab else
              GridKey := gkNextTab;
        VK_RETURN:
          if ( Sender.Perform(WM_GETDLGCODE, 0, 0 ) and
             DLGC_WANTALLKEYS = 0 ) then
            GridKey := gkEditMode;
        VK_F2: GridKey := gkEditMode;
        VK_ESCAPE: GridKey := gkCancel;
      end;
      if GridKey <> gkNull then
      begin
        DoKey( GridKey );
        Result := 1;
        Exit;
      end;
    end;
  inherited;
end;

procedure TIB_CtrlGrid.CMColorChanged( var Message: TMessage );
begin
  inherited;
  if not FSelColorChanged then
    FSelectedColor := Color;
end;

end.
