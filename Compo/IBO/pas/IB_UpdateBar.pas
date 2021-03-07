
{                                                                              }
{  IB_UpdateBar                                                                }
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
{  Marco Menardi <mmenaz@lycosmail.com>                                        }
{  14-apr-2002                                                                 }
{     Reduced resouce usage, critical in Win98 but important also in Win2K     }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the TIB_UpdateBar component. }
unit
  IB_UpdateBar;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Controls, StdCtrls,
  Forms, Graphics, ExtCtrls, Menus, Buttons, Dialogs,

  IB_Constants,
{$IFDEF IBO4_BETA}
  IB_FieldDataLink,
{$ENDIF}
  IB_Components;

type
{: These are the different button types available to this button bar.
<br><br>
<br>ubEdit puts the dataset into dssEdit mode.
<br>ubInsert puts the dataset into dssInsert mode.
<br>ubDelete puts the dataset into dssDelete mode unless AutoPostDelete is true.
<br>ubPost saves whatever changes have been made to the dataset.
<br>ubCancel aborts whatever changes have been made to the dataset.
<br>ubRefreshKeys closes the internal cursor and refetches the keys.
<br>ubRefreshRows refetches the rows of the dataset but does not close it.
<br>ubRefreshAll closes the dataset, clears the cache and refreshes.}
TIB_UpdateBar_ButtonType = ( ubEdit,
                             ubInsert,
                             ubDelete,
                             ubPost,
                             ubCancel,
                             ubRefreshAll,
                             ubRefreshKeys,
                             ubRefreshRows,
                             ubRefreshFilteredRows );
{: Set of button types for this button bar.}
TIB_UpdateBar_ButtonSet = set of TIB_UpdateBar_ButtonType;

TIB_UpdateBar_Button = class;

TIB_UpdateBar_ButtonsOrder = array[0..8] of TIB_UpdateBar_ButtonType;

{: Button bar that gives easy access and control of the modifying of data.}
TIB_UpdateBar = class (TCustomPanel)
{$I IB_Bars.INT}
{$I IB_InterfaceDataLink.INT}
private
  FVisibleButtons: TIB_UpdateBar_ButtonSet;
  FCustomGlyphsSupplied: TIB_UpdateBar_ButtonSet;
  FFocusedButton: TIB_UpdateBar_ButtonType;
  FAppendOnInsert: boolean;
  FForceInsert: boolean;
  FForceDelete: boolean;
  FForceEdit: boolean;
  FButtonsOrder: TIB_UpdateBar_ButtonsOrder;
  procedure SetForceInsert( AValue: boolean );
  procedure SetForceDelete( AValue: boolean );
  procedure SetForceEdit( AValue: boolean );
  procedure SetCustomGlyphsSupplied(Value: TIB_UpdateBar_ButtonSet);
  procedure SetVisibleButtons(Value: TIB_UpdateBar_ButtonSet);
  procedure InitButtonsOrder;
  function GetButtonsOrder(Index: Integer): TIB_UpdateBar_ButtonType;
public
{: Storage array for the different buttons on this button bar. }
  Buttons: array[TIB_UpdateBar_ButtonType] of TIB_UpdateBar_Button;
{: Method used to pass the click of a single button to the owning parent.}
  procedure BtnClick(Index: TIB_UpdateBar_ButtonType);
{: The currently selected button of the button set.
<br><br>
Use this property in the xxxxAction events to know which button was clicked.}
  property FocusedButton: TIB_UpdateBar_ButtonType read FFocusedButton;
  property ButtonsOrder[Index: Integer]: TIB_UpdateBar_ButtonType
      read GetButtonsOrder;
published
{: This property determins whether a click on the Insert button will perform
an Insert or an Append operation on the dataset.}
  property AppendOnInsert: boolean read FAppendOnInsert
                                   write FAppendOnInsert
                                   default false;
{: Set this property to indicate which glyphs have been supplied in the
CustomGlyphs property.}
  property CustomGlyphsSupplied: TIB_UpdateBar_ButtonSet
      read FCustomGlyphsSupplied
     write SetCustomGlyphsSupplied;
{: This property is to make the Insert button always enabled even if the
dataset's CanInsert property returns false.}
  property ForceInsert: boolean read FForceInsert
                                write SetForceInsert
                                default false;
{: This property is to make the Delete button always enabled even if the
dataset's CanDelete property returns false.}
  property ForceDelete: boolean read FForceDelete
                                write SetForceDelete
                                default false;
{: This property is to make the Edit button always enabled even if the
dataset's CanEdit property returns false.}
  property ForceEdit: boolean read FForceEdit
                              write SetForceEdit
                              default false;
{: Set which button are visible to the user.}
  property VisibleButtons: TIB_UpdateBar_ButtonSet
      read FVisibleButtons
     write SetVisibleButtons
   default [ ubEdit, ubInsert, ubDelete, ubPost, ubCancel ];
end;

TIB_UpdateBar_Button = class(TSpeedButton)
private
  FIndex: TIB_UpdateBar_ButtonType;
protected
  procedure Paint; override;
public
  property Index: TIB_UpdateBar_ButtonType read FIndex write FIndex;
end;

var
  UB_Images: TStringList;
  IB_UpdateBar_ButtonsOrder: TIB_UpdateBar_ButtonsOrder;

implementation

{$R IB_UpdateBar.RES}

function StandardBitmap(S:String):tBitmap;
var
  x: integer;
begin
  Result := nil;
  if Assigned( UB_Images ) and UB_Images.Find( S, x ) then
    Result := TBitmap( UB_Images.Objects[ x ] );
end;

procedure FillImages;
var
  i: integer;
  b: TBitmap;
const
  a: array[0..16] of pchar = ('UPD_BAR_UPDATE','UPD_BAR_INSERT',
                              'UPD_BAR_DELETE', 'UPD_BAR_POST',
                              'UPD_BAR_CANCEL', 'UPD_BAR_INVALIDATE',
                              'UPD_BAR_REFRESH', 'UPD_BAR_REFRESHALL',
                              'UPD_BAR_POST_SEARCH', 'UPD_BAR_POST_UPDATE',
                              'UPD_BAR_POST_INSERT', 'UPD_BAR_POST_DELETE',
                              'UPD_BAR_CANCEL_SEARCH', 'UPD_BAR_CANCEL_UPDATE',
                              'UPD_BAR_CANCEL_INSERT', 'UPD_BAR_CANCEL_DELETE',
                              'UPD_BAR_RFRSH_FILT');
begin
  for i := low(a) to high(a) do
  begin
    B := TBitmap.Create;
    B.LoadFromResourceName( hinstance, strPas(a[i] ));
    B.Dormant;
    B.FreeImage;
    UB_Images.AddObject( strPas( a[i] ), B );
  end;
end;

constructor TIB_UpdateBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque];
  if not NewStyleControls then
    ControlStyle := ControlStyle + [csFramed];
  FIB_DataLink := TIB_InterfaceDataLink.Create( Self );
  with DataLink do
  begin
    Control := Self;
    AfterAssignment := IB_DatasetStateChanged;
    OnPreparedChanged := IB_DatasetStateChanged;
    OnActiveChange := IB_DatasetStateChanged;
    OnStateChanged := IB_DatasetStateChanged;
    OnDataChange := IB_DatasetDataChange;
  end;
  InitButtonsOrder;
  FVisibleButtons := [ ubEdit, ubInsert, ubDelete, ubPost, ubCancel ];
  InitButtons;
  BevelOuter := bvNone;
  BevelInner := bvNone;
  Ctl3D := false;
  ParentCtl3D := false;
  Width := 121;
  Height := 25;
  ButtonWidth := 0;
  FFocusedButton := ubEdit;
{$IFDEF IBO_VCL30_OR_GREATER}
  Flat := true; // Hit the property.
{$ENDIF}
end;

destructor TIB_UpdateBar.Destroy;
begin
  if Assigned( FCustomGlyphs ) then
  begin
    FCustomGlyphs.OnChange := nil;
  end;
  with DataLink do
  begin
    AfterAssignment := nil;
    AfterAssignment := nil;
    OnPreparedChanged := nil;
    OnActiveChange := nil;
    OnStateChanged := nil;
    OnDataChange := nil;
  end;
  inherited Destroy;
end;

procedure TIB_UpdateBar.Notification( AComponent: TComponent;
                                      Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( CustomGlyphs <> nil ) and
     ( AComponent = CustomGlyphs ) then
    CustomGlyphs := nil;
end;

procedure TIB_UpdateBar.IB_DatasetStateChanged( Sender: TIB_DataLink;
                                                DataSource: TIB_DataSource );
begin
  SysStateChanged;
end;

procedure TIB_UpdateBar.IB_DatasetDataChange( Sender: TIB_DataLink;
                                              DataSource: TIB_DataSource;
                                              IB_Field: TIB_Column );
begin
  ; // must be defined, so it's empty since we don't use it
//  SysStateChanged;
end;

function TIB_UpdateBar.GetDataSource: TIB_DataSource;
begin
  if FIB_DataLink <> nil then begin
    Result := FIB_DataLink.DataSource;
  end else begin
    Result := nil;
  end;
end;

{$IFDEF IBO_VCL30_OR_GREATER}
procedure TIB_UpdateBar.SetFlat( AValue: boolean );
begin
  if Flat <> AValue then begin
    FFlat := AValue;
    Buttons[ ubEdit ].Flat := Flat;
    Buttons[ ubInsert ].Flat := Flat;
    Buttons[ ubDelete ].Flat := Flat;
    Buttons[ ubPost ].Flat := Flat;
    Buttons[ ubCancel].Flat := Flat;
    Buttons[ ubRefreshAll ].Flat := Flat;
    Buttons[ ubRefreshKeys ].Flat := Flat;
    Buttons[ ubRefreshRows ].Flat := Flat;
    Buttons[ ubRefreshFilteredRows ].Flat := Flat;
  end;
end;
{$ENDIF}

procedure TIB_UpdateBar.SetDataSource(AValue: TIB_DataSource);
begin
  if DataLink.DataSource <> AValue then begin
    DataLink.DataSource := AValue;
    SysStateChanged;
  end;
end;

function TIB_UpdateBar.GetReceiveFocus: boolean;
begin
  Result := DataLink.ReceiveFocus;
end;

procedure TIB_UpdateBar.SetReceiveFocus( AValue: boolean );
begin
  DataLink.ReceiveFocus := AValue;
end;

procedure TIB_UpdateBar.SetForceInsert( AValue: boolean );
begin
  FForceInsert := AValue;
  SysStateChanged;
end;

procedure TIB_UpdateBar.SetForceDelete( AValue: boolean );
begin
  FForceDelete := AValue;
  SysStateChanged;
end;

procedure TIB_UpdateBar.SetForceEdit( AValue: boolean );
begin
  FForceEdit := AValue;
  SysStateChanged;
end;

procedure TIB_UpdateBar.InitButtons;
var
  I: Integer; //TIB_UpdateBar_ButtonType;
  Btn: TIB_UpdateBar_Button;
  X: Integer;
begin
  MinBtnSize := Point(20, 18);
  X := 0;
  for I := 0 to High(TIB_UpdateBar_ButtonsOrder) do begin
    Btn := TIB_UpdateBar_Button.Create (Self);
    Btn.Index := FButtonsOrder[I];
    Btn.Visible := Btn.Index in FVisibleButtons;
    Btn.Enabled := True;
    Btn.SetBounds ( X, 0, MinBtnSize.X, MinBtnSize.Y );
    Btn.Enabled := False;
    Btn.Enabled := True;
    Btn.OnClick := BarClick;
    Btn.OnMouseDown := BtnMouseDown;
    Btn.Parent := Self;
    Buttons[Btn.Index] := Btn;
    X := X + MinBtnSize.X;
  end;
  LoadCustomGlyphs;
end;

procedure TIB_UpdateBar.InitHints;
var
  tmpDataset: TIB_Dataset;
  procedure SetHint( AButton: TIB_UpdateBar_ButtonType;
                     AItem, DefaultHint: string );
  var
    tmpStr: string;
  begin
    tmpStr := '';
    if Assigned( tmpDataset ) then tmpStr := tmpDataset.Hints.Values[ AItem ];
    if tmpStr = '' then tmpStr := DefaultHint;
    Buttons[ AButton ].Hint := tmpStr;
  end;
begin
  tmpDataset := Datalink.Dataset;
  SetHint( ubEdit, 'EDIT', H_UB_EDIT );
  SetHint( ubInsert, 'INSERT', H_UB_INSERT );
  SetHint( ubDelete, 'DELETE', H_UB_DELETE );
  SetHint( ubRefreshAll, 'REFRESH', H_UB_REFRESH );
  SetHint( ubRefreshKeys, 'REFRESHKEYS', H_UB_REFRESHKEYS );
  SetHint( ubRefreshRows, 'REFRESHROWS', H_UB_REFRESHROWS );
  SetHint( ubRefreshFilteredRows, 'REFRESHFILTROWS', H_UB_REFRESHFILTROWS );
  case Datalink.State of
    dssSearch: begin
      SetHint( ubPost, 'POSTSEARCH', H_UB_POSTSEARCH );
      SetHint( ubCancel, 'CANCELSEARCH', H_UB_CANCELSEARCH );
    end;
    dssEdit: begin
      SetHint( ubPost, 'POSTEDIT', H_UB_POSTEDIT );
      SetHint( ubCancel, 'CANCELEDIT', H_UB_CANCELEDIT );
    end;
    dssInsert: begin
      SetHint( ubPost, 'POSTINSERT', H_UB_POSTINSERT );
      SetHint( ubCancel, 'CANCELINSERT', H_UB_CANCELINSERT );
    end;
    dssDelete: begin
      SetHint( ubPost, 'POSTDELETE', H_UB_POSTDELETE );
      SetHint( ubCancel, 'CANCELDELETE', H_UB_CANCELDELETE );
    end else begin
      SetHint( ubPost, 'POST', H_UB_POST );
      SetHint( ubCancel, 'CANCEL', H_UB_CANCEL );
    end;
  end;
end;

procedure TIB_UpdateBar.BtnMouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TIB_UpdateBar_ButtonType;
begin
  OldFocus := FocusedButton;
  FFocusedButton := TIB_UpdateBar_Button(Sender).Index;
  if TabStop and ( GetFocus <> Handle ) and CanFocus then begin
    SetFocus;
    if (GetFocus <> Handle) then Exit;
  end else if TabStop and (GetFocus = Handle) and
                          (OldFocus <> FocusedButton) then begin
    Buttons[OldFocus].Invalidate;
    Buttons[FocusedButton].Invalidate;
  end;
end;

procedure TIB_UpdateBar.SetVisibleButtons(Value: TIB_UpdateBar_ButtonSet);
var
  I: TIB_UpdateBar_ButtonType;
  W, H: Integer;
begin
  W := Width;
  H := Height;
  FVisibleButtons := Value;
  for I := Low(Buttons) to High(Buttons) do
    Buttons[I].Visible := I in FVisibleButtons;
  AdjSize (W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  Invalidate;
end;

procedure TIB_UpdateBar.AdjSize (var W: Integer; var H: Integer);
var
  Count: Integer;
  MinW: Integer;
  I: Integer;
  Space, Temp, Remain: Integer;
  X: Integer;

  function CountVisible : Integer;
  var
    I: TIB_UpdateBar_ButtonType;
    Count : Integer;
  begin
     Count := 0;
     for I := Low(Buttons) to High(Buttons) do
     begin
       if Buttons[I].Visible then
       begin
         Inc(Count);
       end;
     end;
     if Count = 0 then Inc(Count);
     Result := Count;
  end;

begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[ubEdit] = nil then Exit;

  Count := CountVisible;

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

  for I := 0 to High(TIB_UpdateBar_ButtonsOrder) do begin
    if Buttons[FButtonsOrder[I]].Visible then begin
      Space := 0;
      if Remain <> 0 then begin
        Dec (Temp, Remain);
        if Temp < 0 then begin
          Inc (Temp, Count);
          Space := 1;
        end;
      end;
      Buttons[FButtonsOrder[I]].SetBounds (X, 0, ButtonWidth + Space, Height);
      Inc (X, ButtonWidth - 1 + Space);
    end else
      Buttons[FButtonsOrder[I]].SetBounds (Width + 1, 0, ButtonWidth, Height);
  end;
end;

procedure TIB_UpdateBar.WMSize(var Message: TWMSize);
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

procedure TIB_UpdateBar.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_UpdateBar.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_UpdateBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TIB_UpdateBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    SysStateChanged;
end;

procedure TIB_UpdateBar.SysStateChanged;
begin
  if Enabled and DataLink.Prepared and
     not ( csDestroying in DataSource.Dataset.ComponentState ) then
  with DataSource.Dataset do begin
    if not Assigned( CustomGlyphs ) or
       not ( ubPost in CustomGlyphsSupplied ) then
    with Buttons[ ubPost ].Glyph do begin
      case State of
        dssSearch: Assign( StandardBitmap( 'UPD_BAR_POST_SEARCH' ));
        dssEdit:   Assign( StandardBitmap( 'UPD_BAR_POST_UPDATE' ));
        dssInsert: Assign( StandardBitmap( 'UPD_BAR_POST_INSERT' ));
        dssDelete: Assign( StandardBitmap( 'UPD_BAR_POST_DELETE' ));
        else       Assign( StandardBitmap( 'UPD_BAR_POST' ));
      end;
      Dormant;          // EH - Resource Fix
      FreeImage;        // EH - Resource Fix
    end;
    if (CustomGlyphs = nil) or not (ubCancel in CustomGlyphsSupplied) then
    with Buttons[ ubCancel ].Glyph do begin
      case State of
        dssSearch: Assign( StandardBitmap( 'UPD_BAR_CANCEL_SEARCH' ));
        dssEdit:   Assign( StandardBitmap( 'UPD_BAR_CANCEL_UPDATE' ));
        dssInsert: Assign( StandardBitmap( 'UPD_BAR_CANCEL_INSERT' ));
        dssDelete: Assign( StandardBitmap( 'UPD_BAR_CANCEL_DELETE' ));
        else       Assign( StandardBitmap( 'UPD_BAR_CANCEL' ));
      end;
      Dormant;          // EH - Resource Fix
      FreeImage;        // EH - Resource Fix
    end;
    Buttons[ ubEdit ].Enabled := ForceEdit or CanEdit;
    Buttons[ ubInsert ].Enabled := ForceInsert or CanInsert;
    Buttons[ ubDelete ].Enabled := ForceDelete or CanDelete;
    Buttons[ ubPost ].Enabled := NeedToPost or ( State = dssSearch );
    Buttons[ ubCancel ].Enabled := NeedToPost or ( State = dssSearch );
    Buttons[ ubRefreshKeys ].Enabled := BufferActive and not Unidirectional;
    Buttons[ ubRefreshRows ].Enabled := BufferActive and not Unidirectional;
    Buttons[ ubRefreshFilteredRows ].Enabled := BufferActive and
                                                not Unidirectional;
    Buttons[ ubRefreshAll ].Enabled := BufferActive and not Unidirectional;
  end
  else
  begin
    if (CustomGlyphs = nil) or not (ubPost in CustomGlyphsSupplied) then begin
      Buttons[ ubPost ].Glyph.Assign( StandardBitmap( 'UPD_BAR_POST' ));
      Buttons[ ubPost ].Glyph.Dormant;      // EH - Resource Fix
      Buttons[ ubPost ].Glyph.FreeImage;    // EH - Resource Fix
    end;
    if (CustomGlyphs = nil) or not (ubCancel in CustomGlyphsSupplied) then begin
      Buttons[ ubCancel ].Glyph.Assign( StandardBitmap( 'UPD_BAR_CANCEL' ));
      Buttons[ ubCancel ].Glyph.Dormant;    // EH - Resource Fix
      Buttons[ ubCancel ].Glyph.FreeImage;  // EH - Resource Fix
    end;
    Buttons[ ubEdit ].Enabled := false;
    Buttons[ ubInsert ].Enabled := false;
    Buttons[ ubDelete ].Enabled := false;
    Buttons[ ubPost ].Enabled := false;
    Buttons[ ubCancel ].Enabled := false;
    Buttons[ ubRefreshKeys ].Enabled := false;
    Buttons[ ubRefreshRows ].Enabled := false;
    Buttons[ ubRefreshAll ].Enabled := false;
    Buttons[ ubRefreshFilteredRows ].Enabled := false;
  end;
  InitHints;
  if not ( csDestroying in ComponentState ) and
    Assigned( FOnButtonsStateChanged ) then begin
    FOnButtonsStateChanged( Self );
  end;
end;

procedure TIB_UpdateBar.Loaded;
var
  W, H: Integer;
begin
  inherited Loaded;
  W := Width;
  H := Height;
  AdjSize (W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  SysStateChanged;
end;

procedure TIB_UpdateBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TIB_UpdateBar_ButtonType;
  OldFocus: TIB_UpdateBar_ButtonType;
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

procedure TIB_UpdateBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  AdjSize (W, H);
  inherited SetBounds(ALeft, ATop, W, H);
end;

procedure TIB_UpdateBar.BtnClick(Index: TIB_UpdateBar_ButtonType);
begin
  FFocusedButton := Index;
  if not (csDesigning in ComponentState) and
     Assigned( FBeforeAction ) then
    FBeforeAction( Self );
  with DataLink do
  begin
    if Dataset <> nil then
      with Dataset do
      begin
        case Index of
          ubEdit: Edit;
          ubInsert: if AppendOnInsert then Append else Insert;
          ubDelete: Delete;
          ubPost: Post;
          ubCancel: if State = dssSearch then begin
            ClearSearch;
            Open;
          end else begin
            Cancel;
          end;
          ubRefreshKeys: RefreshKeys;
          ubRefreshRows: RefreshRows;
          ubRefreshFilteredRows:
            if Dataset is TIB_BDataset then
              (Dataset as TIB_BDataset).RefreshFilteredRows;
          ubRefreshAll: RefreshAll;
        end;
      end;
  end;
  if not (csDesigning in ComponentState) and
     Assigned( FAfterAction ) then begin
    FAfterAction( Self );
  end;
end;

procedure TIB_UpdateBar.BarClick( Sender: TObject );
begin
  BtnClick( TIB_UpdateBar_Button(Sender).Index );
end;

procedure TIB_UpdateBar_Button.Paint;
var
  R: TRect;
begin
  inherited Paint;
  if ( GetFocus = Parent.Handle ) and
     ( FIndex = TIB_UpdateBar(Parent).FocusedButton ) then
  begin
    R := Bounds( 0, 0, Width, Height );
    InflateRect( R, -3, -3 );
    if FState = bsDown then
      OffsetRect( R, 1, 1 );
    DrawFocusRect( Canvas.Handle, R );
  end;
end;

function TIB_UpdateBar.GetOnReceiveFocus: TIB_DataLinkEvent;
begin
  Result := DataLink.OnReceiveFocus;
end;

procedure TIB_UpdateBar.SetOnReceiveFocus( AValue: TIB_DataLinkEvent );
begin
  DataLink.OnReceiveFocus := AValue;
end;

procedure TIB_UpdateBar.SetCustomGlyphs(Value: TImageList);
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

procedure TIB_UpdateBar.CustomGlyphsChange(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then LoadCustomGlyphs;
end;

procedure TIB_UpdateBar.SetCustomGlyphsSupplied(Value: TIB_UpdateBar_ButtonSet);
begin
  if FCustomGlyphsSupplied <> Value then begin
  FCustomGlyphsSupplied := Value;
  LoadCustomGlyphs;
  end;
end;

procedure TIB_UpdateBar.LoadCustomGlyphs;
var
  j: Integer;
  i: TIB_UpdateBar_ButtonType;
  tmpGlyph: TBitmap;
begin
  j := 0;
  for i:= low(Buttons) to high(Buttons) do
  begin
    if Assigned( FCustomGlyphs ) and
       ( i in CustomGlyphsSupplied ) and
       ( j < FCustomGlyphs.Count ) then
    begin
      tmpGlyph := TBitmap.Create;
      try
        FCustomGlyphs.GetBitmap( j, tmpGlyph );
        Buttons[i].Glyph.Assign( tmpGlyph );
        Buttons[i].Glyph.Dormant;
        Buttons[i].Glyph.FreeImage;
      finally
        tmpGlyph.Free;
      end;
      Buttons[i].NumGlyphs := 1;
      inc(j);
    end
    else
    begin
      Buttons[i].NumGlyphs := 2;
      with Buttons[i].Glyph do
      begin
        case I of
          ubEdit: Assign( StandardBitmap( 'UPD_BAR_UPDATE' ));
          ubInsert: Assign( StandardBitmap( 'UPD_BAR_INSERT' ));
          ubDelete: Assign( StandardBitmap( 'UPD_BAR_DELETE' ));
          ubPost: Assign( StandardBitmap( 'UPD_BAR_POST' ));
          ubCancel: Assign( StandardBitmap( 'UPD_BAR_CANCEL' ));
          ubRefreshKeys: Assign( StandardBitmap( 'UPD_BAR_REFRESH' ));
          ubRefreshRows: Assign( StandardBitmap( 'UPD_BAR_INVALIDATE' ));
          ubRefreshFilteredRows: Assign( StandardBitmap(
                                                       'UPD_BAR_RFRSH_FILT' ));
          ubRefreshAll: Assign( StandardBitmap( 'UPD_BAR_REFRESHALL' ));
        end;
        Dormant;       // EH - Resource Fix
        FreeImage;     // EH - Resource Fix
      end;
    end;
  end;
end;


procedure TIB_UpdateBar.InitButtonsOrder;

  function GlobalOrderAssigned : boolean;
  var
    Flags : Array [TIB_UpdateBar_ButtonType] of boolean;
    i : TIB_UpdateBar_ButtonType;
    ii : byte;
  begin
    Result := False;
    for i := Low(TIB_UpdateBar_ButtonType) to High(TIB_UpdateBar_ButtonType)
    do Flags[i] := False;
    for ii := 0 to 7 do begin
      if not Flags[IB_UpdateBar_ButtonsOrder[ii]]
      then Flags[IB_UpdateBar_ButtonsOrder[ii]] := True
      else Exit; // the flag can't be updated twice
    end;
    // All items must be true
    for i := Low(TIB_UpdateBar_ButtonType) to High(TIB_UpdateBar_ButtonType)
    do if not Flags[i] then Exit;
    Result := True;
  end;

begin
  if GlobalOrderAssigned
  then FButtonsOrder := IB_UpdateBar_ButtonsOrder
  else begin
    FButtonsOrder[0] := ubEdit;
    FButtonsOrder[1] := ubInsert;
    FButtonsOrder[2] := ubDelete;
    FButtonsOrder[3] := ubPost;
    FButtonsOrder[4] := ubCancel;
    FButtonsOrder[5] := ubRefreshAll;
    FButtonsOrder[6] := ubRefreshKeys;
    FButtonsOrder[7] := ubRefreshRows;
    FButtonsOrder[8] := ubRefreshFilteredRows;
  end;
end;

function TIB_UpdateBar.GetButtonsOrder( Index: Integer ):
                                                       TIB_UpdateBar_ButtonType;
begin
  Result := FButtonsOrder[Index];
end;

initialization
  UB_Images := TIB_StringList.Create;
  UB_Images.Sorted := true;
  FillImages;

finalization
  while UB_Images.count > 0 do
  begin
    TBitmap( UB_Images.Objects[0] ).Free;
    UB_Images.Delete( 0 );
  end;
  UB_Images.Free;
  UB_Images := nil;

end.

