
{                                                                              }
{  IB_UtilityBar                                                               }
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
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  07-Jan-02                                                                   }
{      Moved the BtnClick code to an external function ExecuteUtility to make  }
{      it easier to access all the utilities without having to actually        }
{      display the utilitybar.  Not that impressive but convenient if you want }
{      to make the utilities available from a menu or something.               }
{                                                                              }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the TIB_UtilityBar component. }
unit
  IB_UtilityBar;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Controls, StdCtrls,
  Forms, Graphics, ExtCtrls, Menus, Buttons, Dialogs,

  IB_Session,
  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_Constants;
//IB_Dialogs

type
{: Button types included on this button bar.}
TIB_UtilityBar_ButtonType = ( wbBrowse,
                              wbDSQL,
                              wbEvents,
                              wbExport,
                              wbDump,
                              wbPump,
                              wbWho,
                              wbScript,
                              wbExtract,
                              wbMonitor,
                              wbProfiler,
                              wbStatus,
                              wbUsers );
{: Set of button types for this button bar.}
TIB_UtilityBar_ButtonSet = set of TIB_UtilityBar_ButtonType;

TIB_UtilityBar_Button = class;
  
{: This control provides an easy access path to the forms that come with
the IB Objects component editors.

See IB_SQL sample application for an example of its usage.}  
TIB_UtilityBar = class (TCustomPanel)
  private
    FIB_ConnectionSource: TIB_ConnectionSource;
    FIB_TransactionSource: TIB_TransactionSource;
    ButtonWidth: Integer;
    FVisibleButtons: TIB_UtilityBar_ButtonSet;
    MinBtnSize: TPoint;
    FFocusedButton: TIB_UtilityBar_ButtonType;
    FBaseKey: string;
{$IFDEF IBO_VCL30_OR_GREATER}
    FFlat: boolean;
{$ENDIF}
    FCustomGlyphs: TImageList;
    FCustomGlyphsSupplied: TIB_UtilityBar_ButtonSet;
    FShowCaptions: boolean;
    FShowGlyphs: boolean;
    function GetConnection: TIB_Connection;
    procedure SetConnection(AValue: TIB_Connection);
    function GetTransaction: TIB_Transaction;
    procedure SetTransaction(AValue: TIB_Transaction);
    function GetFullKey: string;
{$IFDEF IBO_VCL30_OR_GREATER}
    procedure SetFlat( AValue: boolean );
{$ENDIF}
    procedure InitButtons;
    procedure BtnMouseDown (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetVisible(Value: TIB_UtilityBar_ButtonSet);
    procedure AdjSize (var W: Integer; var H: Integer);
    procedure WMSize(var Message: TWMSize);  message WM_SIZE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure SetCustomGlyphs(Value: TImageList);
    procedure CustomGlyphsChange(Sender: TObject);
    procedure LoadCustomGlyphs;
    procedure SetCustomGlyphsSupplied(Value: TIB_UtilityBar_ButtonSet);
    procedure SetShowCaptions( AValue: boolean );
    procedure SetShowGlyphs( AValue: boolean );
  protected
    procedure ConnectedChanged( CLink: TIB_ConnectionLink;
                                C: TIB_Connection);
    procedure BarClick(Sender: TObject); virtual;
    procedure ActiveChanged;
    procedure Loaded; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
{: Array of buttons for this control.}
    Buttons: array[TIB_UtilityBar_ButtonType] of TIB_UtilityBar_Button;
    constructor Create(AOwner: TComponent); override;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
{: Method used to produce a button click action.}
    procedure BtnClick(Index: TIB_UtilityBar_ButtonType);
{: Tells which button has the current focus.

This is handy for telling which button was clicked in the OnXXXAction events.}
    property FocusedButton: TIB_UtilityBar_ButtonType read FFocusedButton;
{: }
    property FullKey: string read GetFullKey;
  published
{: }
    property CustomGlyphs: TImageList read FCustomGlyphs write SetCustomGlyphs;
{: }
    property CustomGlyphsSupplied: TIB_UtilityBar_ButtonSet
        read FCustomGlyphsSupplied
       write SetCustomGlyphsSupplied;
{$IFDEF IBO_VCL30_OR_GREATER}
{: Makes the buttons use the Flat style.}
    property Flat: boolean read FFlat write SetFlat default true;
{$ENDIF}
{: The registry is used to store preferences between sessions. Use this
property to determine where in the registry these items will be kept.}
    property BaseKey: string read FBaseKey write FBaseKey;
{: Connection for which this control will take action for.}
    property BaseConnection: TIB_Connection
        read GetConnection
       write SetConnection;
{: Transaction for which this control will take action for.}
    property BaseTransaction: TIB_Transaction
        read GetTransaction
       write SetTransaction;
{: Determine the buttons that the user can interact with.}
    property VisibleButtons: TIB_UtilityBar_ButtonSet
        read FVisibleButtons
       write SetVisible;
  property ShowCaptions: boolean read FShowCaptions
                                 write SetShowCaptions
                                 default true;
  property ShowGlyphs: boolean read FShowGlyphs
                               write SetShowGlyphs
                               default false;
  property Align;
  property DragCursor;
  property DragMode;
  property Enabled;
  property Ctl3D;
  property ParentCtl3D;
  property ParentShowHint;
  property PopupMenu;
  property ShowHint;
  property TabOrder;
  property TabStop;
  property Visible;
  property OnClick;
  property OnDblClick;
  property OnDragDrop;
  property OnDragOver;
  property OnEndDrag;
  property OnEnter;
  property OnExit;
  property OnResize;
end;

TIB_UtilityBar_Button = class(TSpeedButton)
  private
    FIndex: TIB_UtilityBar_ButtonType;
  protected
    procedure Paint; override;
  public
    property Index: TIB_UtilityBar_ButtonType read FIndex write FIndex;
end;


{: Provides access to execute all utilities defined by the TIB_UtilityBar
without needing to actually have the utility bar on the form.  For example
you may decide to setup a menu to execute the utilities.}
function ExecuteUtility( Index: TIB_UtilityBar_ButtonType;
  AOwner: TComponent;
  ABaseKey: string;
  AConnection: TIB_Connection;
  ATransaction: TIB_Transaction;
  AModal: boolean
  ): TModalResult;


implementation

{$R IB_UtilityBar.RES}

uses
  IBF_Base,
  IBF_Browse,
  IBF_DSQL,
  IBF_Events,
  IBF_Monitor,
  IBF_Profiler,
  IBF_Status,
  IBF_Users,
  IBF_Export,
  IBF_DataDump,
  IBF_DataPump,
  IBF_Who,
  IBF_Script,
//  IBF_DDL_Extract,
  IBF_Metadata;

function ExecuteUtility( Index: TIB_UtilityBar_ButtonType;
  AOwner: TComponent;
  ABaseKey: string;
  AConnection: TIB_Connection;
  ATransaction: TIB_Transaction;
  AModal: boolean
  ): TModalResult;
var
  ABaseForm: TIB_BaseFormClass;
begin
  Result := mrOk; // have to return something even if we dont show modal
  ABaseForm := nil;
  if Index in [ wbBrowse, wbDSQL, wbEvents, wbExport, wbExtract,
                wbDump, wbPump, wbWho, wbProfiler ] then
  begin
    if Assigned( AConnection ) then
    begin
      if not AConnection.Connected then
        AConnection.Connect;
    end
    else
      raise EIB_Error.Create( 'Connection is not assigned' );
  end;
  case Index of
    wbBrowse: ABaseForm := TfrmBrowse;
    wbDSQL: ABaseForm := TfrmDSQL;
    wbEvents: ABaseForm := TfrmEvents;
    wbExport: ABaseForm := TfrmExport;
    wbDump: ABaseForm := TfrmDataDump;
    wbPump: ABaseForm := TfrmDataPump;
    wbScript: ABaseForm := TfrmScript;
    wbExtract: ABaseForm := TfrmMetadataExtract;//TfrmDDLExtract;
    wbWho: ABaseForm := TfrmWho;
    wbMonitor: ABaseForm := TfrmMonitor;
    wbProfiler: ABaseForm := TfrmProfiler;
    wbStatus: ABaseForm := TfrmStatus;
    wbUsers: with TfrmUsers.Create( AOwner ) do try
      csUsers.IB_Connection := AConnection;
      Result := ShowModal;
    finally
      Free;
    end;
  end;
  if Assigned( ABaseForm ) then
    with ABaseForm.CreateWithContext( AOwner,
                                      ABaseKey + '\' +
                                        Copy( ABaseForm.ClassName, 5, MaxInt ),
                                      AConnection,
                                      ATransaction ) do
    begin
      if ( ABaseForm = TfrmBrowse ) or
         ( ABaseForm = TfrmDataDump ) then
        Initialize;
      if AModal then
        Result := ShowModal
      else
        Show;
    end;
end;

constructor TIB_UtilityBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque];
  if not NewStyleControls then ControlStyle := ControlStyle + [csFramed];
  FIB_ConnectionSource := TIB_ConnectionSource.Create( Self );
  with FIB_ConnectionSource do begin
    AfterAssignment := ConnectedChanged;
    OnConnectedChanged := ConnectedChanged;
  end;
  FIB_TransactionSource := TIB_TransactionSource.Create( Self );
  FVisibleButtons := [ wbBrowse, wbExport, wbWho,
                       wbScript, wbExtract, wbMonitor, wbProfiler ];
  FShowGlyphs := false;
  FShowCaptions := true;
  InitButtons;
  BevelOuter := bvNone;
  BevelInner := bvNone;
  Ctl3D := false;
  ParentCtl3D := false;
  Width := 417;
  Height := 25;
  ButtonWidth := 0;
  FFocusedButton := wbBrowse;
{$IFDEF IBO_VCL30_OR_GREATER}
  Flat := true; // Hit the property.
{$ENDIF}
end;

procedure TIB_UtilityBar.ConnectedChanged( CLink: TIB_ConnectionLink;
                                           C: TIB_Connection);
begin
  ActiveChanged;
end;

function TIB_UtilityBar.GetConnection: TIB_Connection;
begin
  Result := FIB_ConnectionSource.IB_Connection;
end;

function TIB_UtilityBar.GetTransaction: TIB_Transaction;
begin
  Result := FIB_TransactionSource.IB_Transaction;
end;

procedure TIB_UtilityBar.SetConnection(AValue: TIB_Connection);
begin
  if BaseConnection <> AValue then begin
    FIB_ConnectionSource.IB_Connection := AValue;
    ActiveChanged;
  end;
end;

procedure TIB_UtilityBar.SetTransaction(AValue: TIB_Transaction);
begin
  FIB_TransactionSource.IB_Transaction := AValue;
end;

{$IFDEF IBO_VCL30_OR_GREATER}
procedure TIB_UtilityBar.SetFlat( AValue: boolean );
begin
  if Flat <> AValue then begin
    FFlat := AValue;
    Buttons[ wbBrowse  ].Flat := Flat;
    Buttons[ wbDSQL    ].Flat := Flat;
    Buttons[ wbEvents  ].Flat := Flat;
    Buttons[ wbExport  ].Flat := Flat;
    Buttons[ wbDump    ].Flat := Flat;
    Buttons[ wbPump    ].Flat := Flat;
    Buttons[ wbWho     ].Flat := Flat;
    Buttons[ wbScript  ].Flat := Flat;
    Buttons[ wbExtract ].Flat := Flat;
    Buttons[ wbMonitor ].Flat := Flat;
    Buttons[ wbProfiler].Flat := Flat;
    Buttons[ wbStatus  ].Flat := Flat;
    Buttons[ wbUsers   ].Flat := Flat;
  end;
end;
{$ENDIF}

procedure TIB_UtilityBar.InitButtons;
var
  I: TIB_UtilityBar_ButtonType;
  Btn: TIB_UtilityBar_Button;
  X: Integer;
begin
  MinBtnSize := Point(20, 18);
  X := 0;
  for I := Low(Buttons) to High(Buttons) do
  begin
    Btn := TIB_UtilityBar_Button.Create (Self);
    Btn.Index := I;
    Btn.Visible := I in FVisibleButtons;
    Btn.Enabled := True;
    Btn.SetBounds (X, 0, MinBtnSize.X, MinBtnSize.Y);
    case I of
      wbBrowse: Btn.Hint := C_wbBrowseBtnHint;
      wbDSQL: Btn.Hint := C_wbDSQLBtnHint;
      wbEvents: Btn.Hint := C_wbEventsBtnHint;
      wbExport: Btn.Hint := C_wbExportBtnHint;
      wbDump: Btn.Hint := C_wbDumpBtnHint;
      wbPump: Btn.Hint := C_wbPumpBtnHint;
      wbWho: Btn.Hint := C_wbWhoBtnHint;
      wbScript: Btn.Hint := C_wbScriptBtnHint;
      wbExtract: Btn.Hint := C_wbExtractBtnHint;
      wbMonitor: Btn.Hint := C_wbMonitorBtnHint;
      wbProfiler: Btn.Hint := C_wbProfilerBtnHint;
      wbStatus: Btn.Hint := C_wbStatusBtnHint;
      wbUsers: Btn.Hint := C_wbUsersBtnHint;
    end;
    Btn.Enabled := False;
    Btn.Enabled := True;
    Btn.OnClick := BarClick;
    Btn.OnMouseDown := BtnMouseDown;
    Btn.Parent := Self;
    Buttons[I] := Btn;
    X := X + MinBtnSize.X;
  end;
  LoadCustomGlyphs;
end;

procedure TIB_UtilityBar.BtnMouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TIB_UtilityBar_ButtonType;
begin
  OldFocus := FocusedButton;
  FFocusedButton := TIB_UtilityBar_Button(Sender).Index;
  if TabStop and (GetFocus <> Handle) and CanFocus then
  begin
    SetFocus;
    if (GetFocus <> Handle) then
      Exit;
  end
  else if TabStop and (GetFocus = Handle) and (OldFocus <> FocusedButton) then
  begin
    Buttons[OldFocus].Invalidate;
    Buttons[FocusedButton].Invalidate;
  end;
end;

procedure TIB_UtilityBar.SetVisible(Value: TIB_UtilityBar_ButtonSet);
var
  I: TIB_UtilityBar_ButtonType;
  W, H: Integer;
begin
  W := Width;
  H := Height;
  FVisibleButtons := Value;
  for I := Low(Buttons) to High(Buttons) do
    Buttons[I].Visible := I in FVisibleButtons;
  AdjSize( W, H );
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  Invalidate;
end;

procedure TIB_UtilityBar.AdjSize (var W: Integer; var H: Integer);
var
  Count: Integer;
  MinW: Integer;
  I: TIB_UtilityBar_ButtonType;
  Space, Temp, Remain: Integer;
  X: Integer;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[wbBrowse] = nil then Exit;
  Count := 0;
  for I := Low(Buttons) to High(Buttons) do
  begin
    if Buttons[I].Visible then
    begin
      Inc(Count);
    end;
  end;
  if Count = 0 then Inc(Count);
  MinW := Count * (MinBtnSize.X - 1) + 1;
  if W < MinW then
    W := MinW;
  if H < MinBtnSize.Y then
    H := MinBtnSize.Y;
  ButtonWidth := ((W - 1) div Count) + 1;
  Temp := Count * (ButtonWidth - 1) + 1;
  if Align = alNone then
    W := Temp;
  X := 0;
  Remain := W - Temp;
  Temp := Count div 2;
  for I := Low(Buttons) to High(Buttons) do
  begin
    if Buttons[I].Visible then
    begin
      Space := 0;
      if Remain <> 0 then
      begin
        Dec (Temp, Remain);
        if Temp < 0 then
        begin
          Inc (Temp, Count);
          Space := 1;
        end;
      end;
      Buttons[I].SetBounds (X, 0, ButtonWidth + Space, Height);
      Inc (X, ButtonWidth - 1 + Space);
    end
    else
      Buttons[I].SetBounds (Width + 1, 0, ButtonWidth, Height);
  end;
end;

procedure TIB_UtilityBar.WMSize(var Message: TWMSize);
var
  W, H: Integer;
begin
  inherited;
  { check for minimum size }
  W := Width;
  H := Height;
  AdjSize (W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds(Left, Top, W, H);
  Message.Result := 0;
end;

procedure TIB_UtilityBar.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_UtilityBar.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_UtilityBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TIB_UtilityBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    ActiveChanged;
end;

procedure TIB_UtilityBar.ActiveChanged;
begin
  Buttons[ wbBrowse   ].Enabled := Enabled;
  Buttons[ wbDSQL     ].Enabled := Enabled;
  Buttons[ wbEvents   ].Enabled := Enabled;
  Buttons[ wbExport   ].Enabled := Enabled;
  Buttons[ wbDump     ].Enabled := Enabled;
  Buttons[ wbPump     ].Enabled := Enabled;
  Buttons[ wbWho      ].Enabled := Enabled;
  Buttons[ wbScript   ].Enabled := Enabled;
  Buttons[ wbExtract  ].Enabled := Enabled;
  Buttons[ wbMonitor  ].Enabled := Enabled;
  Buttons[ wbProfiler ].Enabled := Enabled;
  Buttons[ wbStatus   ].Enabled := Enabled;
  Buttons[ wbUsers    ].Enabled := Enabled;
end;

procedure TIB_UtilityBar.Loaded;
var
  W, H: Integer;
begin
  inherited Loaded;
  W := Width;
  H := Height;
  AdjSize (W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  ActiveChanged;
end;

procedure TIB_UtilityBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TIB_UtilityBar_ButtonType;
  OldFocus: TIB_UtilityBar_ButtonType;
begin
  OldFocus := FocusedButton;
  case Key of
    VK_RIGHT:
      begin
        NewFocus := FocusedButton;
        repeat
          if NewFocus < High(Buttons) then
            NewFocus := Succ(NewFocus);
        until (NewFocus = High(Buttons)) or (Buttons[NewFocus].Visible);
        if NewFocus <> FocusedButton then
        begin
          FFocusedButton := NewFocus;
          Buttons[OldFocus].Invalidate;
          Buttons[FocusedButton].Invalidate;
        end;
      end;
    VK_LEFT:
      begin
        NewFocus := FocusedButton;
        repeat
          if NewFocus > Low(Buttons) then
            NewFocus := Pred(NewFocus);
        until (NewFocus = Low(Buttons)) or (Buttons[NewFocus].Visible);
        if NewFocus <> FocusedButton then
        begin
          FFocusedButton := NewFocus;
          Buttons[OldFocus].Invalidate;
          Buttons[FocusedButton].Invalidate;
        end;
      end;
    VK_SPACE:
      begin
        if Buttons[FocusedButton].Enabled then
          Buttons[FocusedButton].Click;
      end;
  end;
end;

procedure TIB_UtilityBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  AdjSize (W, H);
  inherited SetBounds (ALeft, ATop, W, H);
end;

function TIB_UtilityBar.GetFullKey: string;
begin
  Result := BaseKey;
  if Result = '' then
  begin
    if Owner is TfrmBase then
      Result := (Owner as TfrmBase).FullKey
    else
      Result := 'Software\CPS\IBO\UtilityBar\' + Owner.Name + '.' + Name;
  end;
end;  

procedure TIB_UtilityBar.BtnClick(Index: TIB_UtilityBar_ButtonType);
begin
  FFocusedButton := Index;
  ExecuteUtility( Index,
                  Owner,
                  FullKey,
                  BaseConnection,
                  BaseTransaction,
                  false );
end;

procedure TIB_UtilityBar.BarClick( Sender: TObject );
begin
  BtnClick(TIB_UtilityBar_Button(Sender).Index);
end;

procedure TIB_UtilityBar_Button.Paint;
var
  R: TRect;
begin
  inherited Paint;
  if (GetFocus = Parent.Handle) and
     (FIndex = TIB_UtilityBar(Parent).FocusedButton) then
  begin
    R := Bounds(0, 0, Width, Height);
    InflateRect(R, -3, -3);
    if FState = bsDown then
      OffsetRect(R, 1, 1);
    DrawFocusRect(Canvas.Handle, R);
  end;
end;

procedure TIB_UtilityBar.SetCustomGlyphs(Value: TImageList);
begin
  if Assigned( FCustomGlyphs ) then begin
    FCustomGlyphs.OnChange := nil;
  end;
  FCustomGlyphs := Value;
  if Assigned( FCustomGlyphs ) then begin
    FCustomGlyphs.OnChange := CustomGlyphsChange;
  end;
  LoadCustomGlyphs;
end;

procedure TIB_UtilityBar.CustomGlyphsChange(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then LoadCustomGlyphs;
end;

procedure TIB_UtilityBar.SetShowCaptions( AValue: boolean );
begin
  if FShowCaptions <> AValue then
  begin
    FShowCaptions := AValue;
    if not ShowCaptions and not ShowGlyphs then
      FShowGlyphs := true;
    LoadCustomGlyphs;
  end;
end;

procedure TIB_UtilityBar.SetShowGlyphs( AValue: boolean );
begin
  if FShowGlyphs <> AValue then
  begin
    FShowGlyphs := AValue;
    if not ShowCaptions and not ShowGlyphs then
      FShowCaptions := true;
    LoadCustomGlyphs;
  end;
end;

procedure TIB_UtilityBar.SetCustomGlyphsSupplied(
  Value: TIB_UtilityBar_ButtonSet );
begin
  FCustomGlyphsSupplied := Value;
  LoadCustomGlyphs;
end;

procedure TIB_UtilityBar.LoadCustomGlyphs;
var
  j: Integer;
  i: TIB_UtilityBar_ButtonType;
  Glyph: TBitmap;
begin
  j := 0;
  for i:= low(Buttons) to high(Buttons) do
  begin
    if Assigned( FCustomGlyphs ) and
       ( i in CustomGlyphsSupplied ) and
       ( j < FCustomGlyphs.Count ) then
    begin
      Glyph := TBitmap.Create;
      FCustomGlyphs.GetBitmap(j,Glyph);
      Buttons[i].Glyph.Assign(Glyph);
      Buttons[i].NumGlyphs := 1;
      Buttons[i].Caption := '';
      Glyph.Free;
      inc(j);
    end
    else
    with Buttons[I] do
    begin
      if ShowGlyphs then
      begin
        NumGlyphs := 2;
        case I of
          wbBrowse: Glyph.Handle := LoadBitmap( HInstance,
                                                'IBO_UTIL_BAR_BROWSE' );
          wbDSQL: Glyph.Handle := LoadBitmap( HInstance,
                                              'IBO_UTIL_BAR_DSQL' );
          wbEvents: Glyph.Handle := LoadBitmap( HInstance,
                                                'IBO_UTIL_BAR_EVENTS' );
          wbExport: Glyph.Handle := LoadBitmap( HInstance,
                                                'IBO_UTIL_BAR_EXPORT' );
          wbDump: Glyph.Handle := LoadBitmap( HInstance,
                                              'IBO_UTIL_BAR_DATADUMP' );
          wbPump: Glyph.Handle := LoadBitmap( HInstance,
                                              'IBO_UTIL_BAR_DATAPUMP' );
          wbWho: Glyph.Handle := LoadBitmap( HInstance,
                                             'IBO_UTIL_BAR_WHO' );
          wbScript: Glyph.Handle := LoadBitmap( HInstance,
                                                'IBO_UTIL_BAR_SCRIPT' );
          wbExtract: Glyph.Handle := LoadBitmap( HInstance,
                                                 'IBO_UTIL_BAR_EXTRACT' );
          wbMonitor: Glyph.Handle := LoadBitmap( HInstance,
                                                 'IBO_UTIL_BAR_MONITOR' );
          wbProfiler: Glyph.Handle := LoadBitmap( HInstance,
                                                  'IBO_UTIL_BAR_PROFILER' );
          wbStatus: Glyph.Handle := LoadBitmap( HInstance,
                                                'IBO_UTIL_BAR_STATUS' );
          wbUsers: Glyph.Handle := LoadBitmap( HInstance,
                                               'IBO_UTIL_BAR_USERS' );
        end;
      end
      else
        Glyph := nil;
      if ShowCaptions then
      begin
        case I of
          wbBrowse: Caption := C_wbBrowseBtnCaption;
          wbDSQL: Caption := C_wbDSQLBtnCaption;
          wbEvents: Caption := C_wbEventsBtnCaption;
          wbExport: Caption := C_wbExportBtnCaption;
          wbDump: Caption := C_wbDumpBtnCaption;
          wbPump: Caption := C_wbPumpBtnCaption;
          wbWho: Caption := C_wbWhoBtnCaption;
          wbScript: Caption := C_wbScriptBtnCaption;
          wbExtract: Caption := C_wbExtractBtnCaption;
          wbMonitor: Caption := C_wbMonitorBtnCaption;
          wbProfiler: Caption := C_wbProfilerBtnCaption;
          wbStatus: Caption := C_wbStatusBtnCaption;
          wbUsers: Caption := C_wbUsersBtnCaption;
        end;
      end
      else
        Caption := '';
    end;
  end;
end;

end.
