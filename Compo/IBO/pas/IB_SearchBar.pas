
{                                                                              }
{  IB_SearchBar                                                                }
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
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the TIB_SearchBar component.}
unit
  IB_SearchBar;

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

sbSearch puts the dataset into dssSearching mode.
sbSave stores all of the QBE Search criteria into a buffer.
sbClear clears out all QBE Search criteria.
sbRecall restores from a buffer the previously saved QBE Search criteria.
sbCount performs a count of all rows matching the current QBE Search criteria.}
TIB_SearchBar_ButtonType = ( sbOrder,
                             sbSearch,
                             sbSave,
                             sbClear,
                             sbRecall,
                             sbCount,
                             sbRestructure );
{: Set of button types for this button bar.}
TIB_SearchBar_ButtonSet = set of TIB_SearchBar_ButtonType;

TIB_SearchBar_Button = class;

TIB_SearchBar_ButtonsOrder = array[0..6] of TIB_SearchBar_ButtonType;

{: Event type used when a count has been retrieved.}
TRowCountEvent = procedure ( Sender: TObject; RowCount: longint ) of object;
{: Event type used when an order change has been rerequested.}
TRowOrderEvent = procedure ( Sender: TObject; NewOrder: longint ) of object;
{: Button bar that gives easy access and control of the Searching and
counting capabilities of InterBase Objects datasets.
<br><br>
The Search criteria handling can be customized such that it remains
persistent between application instances. A list of different Search criteria
templates could be maintained as well.
<br><br>
It also provides a simple dialog or customizable way to change the ordering
of the rows in a dataset.}
TIB_SearchBar = class (TCustomPanel)
{$I IB_Bars.INT}
{$I IB_InterfaceDataLink.INT}
private
  FVisibleButtons: TIB_SearchBar_ButtonSet;
  FCustomGlyphsSupplied: TIB_SearchBar_ButtonSet;
  FFocusedButton: TIB_SearchBar_ButtonType;
  FOnSaveCriteria: TNotifyEvent;
  FOnRecallCriteria: TNotifyEvent;
  FOnRowCount: TRowCountEvent;
  FOnRowOrder: TRowOrderEvent;
  FButtonsOrder: TIB_SearchBar_ButtonsOrder;
  procedure SetVisible(Value: TIB_SearchBar_ButtonSet);
  procedure SetCustomGlyphsSupplied(Value: TIB_SearchBar_ButtonSet);
  procedure InitButtonsOrder;
  function GetButtonsOrder(Index: Integer): TIB_SearchBar_ButtonType;
public
{: Storage array for the different buttons on this button bar. }
  Buttons: array[TIB_SearchBar_ButtonType] of TIB_SearchBar_Button;
{: Method used to pass the click of a single button to the owning parent.}
  procedure BtnClick(Index: TIB_SearchBar_ButtonType);
{: The currently selected button of the button set.
<br><br>
Use this property in the xxxxAction events to know which button was clicked.}
  property FocusedButton: TIB_SearchBar_ButtonType read FFocusedButton;
  property ButtonsOrder[Index: Integer]: TIB_SearchBar_ButtonType
      read GetButtonsOrder;
published
{: Set this property to indicate which glyphs have been supplied in the
CustomGlyphs property.}
  property CustomGlyphsSupplied: TIB_SearchBar_ButtonSet
      read FCustomGlyphsSupplied
     write SetCustomGlyphsSupplied;
{: Set which buttons are visible to the user.}
  property VisibleButtons: TIB_SearchBar_ButtonSet
      read FVisibleButtons
     write SetVisible
   default [ sbSearch, sbSave, sbClear, sbRecall, sbCount, sbOrder ];
{: Event that enables a custom display of a dialog to save the current
Search criteria.
<br><br>
See the TIB_Dataset method WriteSearch() to see how Search criteria
can be made persistant.
<br><br>
This means that you can store and load several different Search criteria
templates that remain between application instances.}
  property OnSaveCriteria: TNotifyEvent read FOnSaveCriteria
                                        write FOnSaveCriteria;
{: Event that enables a custom display of a dialog to save the current
Search criteria.
<br><br>
See the TIB_Dataset method ReadSearch() to see how Search criteria
can be made persistant.
<br><br>
This means that you can store and load several different Search criteria
templates that remain between application instances.}
  property OnRecallCriteria: TNotifyEvent read FOnRecallCriteria
                                          write FOnRecallCriteria;
{: Event that enables a custom display of the row count for the dataset.}
  property OnRowCount: TRowCountEvent read FOnRowCount write FOnRowCount;
{: Event that enables a custom dialog for changing the order of rows in
the dataset.}
  property OnRowOrder: TRowOrderEvent read FOnRowOrder write FOnRowOrder;
end;

TIB_SearchBar_Button = class(TSpeedButton)
private
  FIndex: TIB_SearchBar_ButtonType;
protected
  procedure Paint; override;
public
  property Index: TIB_SearchBar_ButtonType read FIndex write FIndex;
end;

var
  SB_Images: TStringList;
  IB_SearchBar_ButtonsOrder: TIB_SearchBar_ButtonsOrder;

implementation

{$R IB_SearchBar.RES}

uses
{$IFDEF IBO_VCL40_OR_GREATER}
  IBD_Restructure,
{$ENDIF}
  IBD_Ordering;

function StandardBitmap( S: String ):tBitmap;
var
  x: integer;
begin
  if SB_Images.Find( S, x ) then
    Result := TBitmap( SB_Images.Objects[ x ] )
  else
    Result := nil;
end;

procedure FillImages;
var
  i: integer;
  b: TBitmap;
const
  a: array[0..7] of pchar = ( 'SRCH_BAR_COUNT', 'SRCH_BAR_SEARCH',
                              'SRCH_BAR_ORDER', 'SRCH_BAR_SAVE',
                              'SRCH_BAR_CLEAR', 'SRCH_BAR_RECALL',
                              'SRCH_BAR_LAST' , 'SRCH_BAR_RESTR' );
begin
  for i := low(a) to high(a) do
  begin
    B := TBitmap.Create;
    B.LoadFromResourceName( hinstance, strPas(a[i] ));
    SB_Images.AddObject( strPas( a[i] ), B );
  end;
end;

constructor TIB_SearchBar.Create(AOwner: TComponent);
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
  FVisibleButtons := [ sbSearch, sbSave, sbClear, sbRecall, sbCount, sbOrder ];
  InitButtons;
  BevelOuter := bvNone;
  BevelInner := bvNone;
  Ctl3D := false;
  ParentCtl3D := false;
  Width := 121;
  Height := 25;
  ButtonWidth := 0;
  FFocusedButton := sbSearch;
{$IFDEF IBO_VCL30_OR_GREATER}
  Flat := true; // Hit the property.
{$ENDIF}
end;

destructor TIB_SearchBar.Destroy;
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

procedure TIB_SearchBar.Notification( AComponent: TComponent;
                                      Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( CustomGlyphs <> nil ) and
     ( AComponent = CustomGlyphs ) then
    CustomGlyphs := nil;
end;

procedure TIB_SearchBar.IB_DatasetStateChanged( Sender: TIB_DataLink;
                                                DataSource: TIB_DataSource );
begin
  SysStateChanged;
end;

procedure TIB_SearchBar.IB_DatasetDataChange( Sender: TIB_DataLink;
                                              DataSource: TIB_DataSource;
                                              IB_Field: TIB_Column );
begin
  SysStateChanged;
end;

function TIB_SearchBar.GetDataSource: TIB_DataSource;
begin
  if FIB_DataLink <> nil then begin
    Result := FIB_DataLink.DataSource;
  end else begin
    Result := nil;
  end;
end;

{$IFDEF IBO_VCL30_OR_GREATER}
procedure TIB_SearchBar.SetFlat( AValue: boolean );
begin
  if Flat <> AValue then begin
    FFlat := AValue;
    Buttons[ sbOrder       ].Flat := Flat;
    Buttons[ sbSearch      ].Flat := Flat;
    Buttons[ sbSave        ].Flat := Flat;
    Buttons[ sbClear       ].Flat := Flat;
    Buttons[ sbRecall      ].Flat := Flat;
    Buttons[ sbCount       ].Flat := Flat;
    Buttons[ sbRestructure ].Flat := Flat;
  end;
end;
{$ENDIF}

procedure TIB_SearchBar.SetDataSource(AValue: TIB_DataSource);
begin
  if FIB_DataLink <> nil then begin
    FIB_DataLink.DataSource := AValue;
  end;
end;

function TIB_SearchBar.GetReceiveFocus: boolean;
begin
  if FIB_DataLink <> nil then begin
    Result := FIB_DataLink.ReceiveFocus;
  end else begin
    Result := false;
  end;
end;

procedure TIB_SearchBar.SetReceiveFocus( AValue: boolean );
begin
  if FIB_DataLink <> nil then begin
    FIB_DataLink.ReceiveFocus := AValue;
  end;
end;

procedure TIB_SearchBar.InitButtons;
var
  I: Integer; //TIB_SearchBar_ButtonType;
  Btn: TIB_SearchBar_Button;
  X: Integer;
begin
  MinBtnSize := Point(20, 18);
  X := 0;
  for I := 0 to High(TIB_SearchBar_ButtonsOrder) do begin
    Btn := TIB_SearchBar_Button.Create (Self);
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

procedure TIB_SearchBar.InitHints;
var
  tmpDataset: TIB_Dataset;
  procedure SetHint( AButton: TIB_SearchBar_ButtonType;
                     AItem, DefaultHint: string );
  var
    tmpStr: string;
  begin
    tmpStr := '';
    if Assigned( tmpDataset ) then begin
      tmpStr := tmpDataset.Hints.Values[ AItem ];
    end;
    if tmpStr = '' then tmpStr := DefaultHint;
    Buttons[ AButton ].Hint := tmpStr;
  end;
begin
  tmpDataset := Datalink.Dataset;
  SetHint( sbOrder, 'ORDER', H_SB_ORDER );
  if Datalink.State = dssSearch then begin
    SetHint( sbSearch, 'LAST_CRITERIA', H_SB_LAST_CRITERIA );
  end else begin
    SetHint( sbSearch, 'Search', H_SB_Search );
  end;
  SetHint( sbSave, 'SAVE_CRITERIA', H_SB_SAVE_CRITERIA );
  SetHint( sbClear, 'CLEAR_CRITERIA', H_SB_CLEAR_CRITERIA );
  SetHint( sbRecall, 'RECALL_CRITERIA', H_SB_RECALL_CRITERIA );
  Buttons[sbRestructure].Hint:=H_SB_RESTRUCTURE;
  if Datalink.State = dssSearch then begin
    SetHint( sbCount, 'COUNT', H_SB_SearchCOUNT );
  end else begin
    SetHint( sbCount, 'COUNT', H_SB_COUNT );
  end;
end;

procedure TIB_SearchBar.BtnMouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TIB_SearchBar_ButtonType;
begin
  OldFocus := FocusedButton;
  FFocusedButton := TIB_SearchBar_Button(Sender).Index;
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

procedure TIB_SearchBar.SetVisible(Value: TIB_SearchBar_ButtonSet);
var
  I: TIB_SearchBar_ButtonType;
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

procedure TIB_SearchBar.AdjSize (var W: Integer; var H: Integer);
var
  Count: Integer;
  MinW: Integer;
  I: Integer;
  Space, Temp, Remain: Integer;
  X: Integer;

  function CountVisible : Integer;
  var
    I: TIB_SearchBar_ButtonType;
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
  if Buttons[ sbSearch ] = nil then Exit;

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

  for I := 0 to High(TIB_SearchBar_ButtonsOrder) do begin
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

procedure TIB_SearchBar.WMSize(var Message: TWMSize);
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

procedure TIB_SearchBar.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_SearchBar.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_SearchBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TIB_SearchBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    SysStateChanged;
end;

procedure TIB_SearchBar.SysStateChanged;
begin
  if FIB_DataLink = nil then
    Exit;
  if ( FIB_DataLink.Dataset <> nil ) and
     ( Enabled ) then
  with DataSource.Dataset do
  begin
    if not Prepared or
       ( StatementType = stSelect ) or
       ( StatementType = stSelectForUpdate ) then
    begin
      Buttons[ sbOrder  ].Enabled := true;
      Buttons[ sbSearch ].Enabled := true;
      if State = dssSearch then
      begin
        if (CustomGlyphs = nil) or not (sbSearch in CustomGlyphsSupplied) then
          Buttons[ sbSearch ].Glyph.Assign( StandardBitmap( 'SRCH_BAR_LAST' ));
      end
      else
      begin
        if (CustomGlyphs = nil) or not (sbSearch in CustomGlyphsSupplied) then
          Buttons[ sbSearch ].Glyph.Assign( StandardBitmap( 'SRCH_BAR_SEARCH'));
      end;
      Buttons[ sbSave   ].Enabled := State = dssSearch;
      Buttons[ sbClear  ].Enabled := State = dssSearch;
      Buttons[ sbRecall ].Enabled := State = dssSearch;
      Buttons[ sbCount  ].Enabled := Prepared;
      Buttons[ sbRestructure].Enabled := Prepared;
    end
    else
    begin
      Buttons[ sbOrder  ].Enabled := false;
      Buttons[ sbSearch ].Enabled := false;
      Buttons[ sbSave   ].Enabled := false;
      Buttons[ sbClear  ].Enabled := false;
      Buttons[ sbRecall ].Enabled := false;
      Buttons[ sbCount  ].Enabled := false;
      Buttons[ sbRestructure].Enabled := False;
    end;
  end
  else
  begin
    Buttons[ sbOrder  ].Enabled := false;
    Buttons[ sbSearch ].Enabled := false;
    Buttons[ sbSave   ].Enabled := false;
    Buttons[ sbClear  ].Enabled := false;
    Buttons[ sbRecall ].Enabled := false;
    Buttons[ sbCount  ].Enabled := false;
    Buttons[ sbRestructure].Enabled := False;
  end;
  InitHints;
  if not ( csDestroying in ComponentState ) and
    Assigned( FOnButtonsStateChanged ) then
    FOnButtonsStateChanged( Self );
end;

procedure TIB_SearchBar.Loaded;
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

procedure TIB_SearchBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TIB_SearchBar_ButtonType;
  OldFocus: TIB_SearchBar_ButtonType;
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

procedure TIB_SearchBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  AdjSize (W, H);
  inherited SetBounds(ALeft, ATop, W, H);
end;

procedure TIB_SearchBar.BtnClick(Index: TIB_SearchBar_ButtonType);
begin
  FFocusedButton := Index;
  if Assigned( BeforeAction ) then
    BeforeAction( Self );
  if Assigned( DataSource ) then
  begin
    with DataSource do
    begin
      if Dataset <> nil then
      with Dataset do
      begin
        case Index of
          sbOrder: begin
            if Assigned( OnRowOrder ) then
              OnRowOrder( Self, OrderingItemNo )
            else
            begin
              with TdlgOrdering.Create( Self ) do
              try
                DataSource.Dataset := Self.DataSource.Dataset;
                Caption := C_FRM_Ordering;
                OKBtn.Caption := C_BF_OK;
                CancelBtn.Caption := C_BF_CANCEL;
                ShowModal;
              finally
                Free;
              end;
            end;
          end;
          sbSearch: if State = dssSearch then
            RecallLastSearch
          else
            Search;
          sbSave: if State = dssSearch then
          begin
            if Assigned( OnSaveCriteria ) then
              OnSaveCriteria( Self )
            else
              SaveSearch;
          end;
          sbClear:
            if State = dssSearch then
              ClearSearch;
          sbRecall: if State = dssSearch then
          begin
            if Assigned( OnRecallCriteria ) then
              OnRecallCriteria( Self )
            else
              RecallSearch;
          end;
          sbCount:
          begin
            if Assigned( OnRowCount ) then
              OnRowCount( Self, RecordCount )
            else
              ShowMessage( Format( M_SB_REC_CNT, [ RecordCount ] ));
          end;
          sbRestructure:
{$IFDEF IBO_VCL40_OR_GREATER}
            with  TdlgRestructure.Create( Self ) do
             try
               DataSource.Dataset := Self.DataSource.Dataset;
               Caption := C_FRM_RESTRUCTURE;
               OKBtn.Caption := C_BF_OK;
               CancelBtn.Caption := C_BF_CANCEL;
               ShowHint:=Self.ShowHint;
               ShowModal;
             finally
               Free;
             end;
{$ELSE}
            raise Exception.Create( 'Unsupported feature' );
{$ENDIF}
        end;
      end;
    end;
  end;
  if Assigned( AfterAction ) then
    AfterAction( Self );
end;

procedure TIB_SearchBar.BarClick( Sender: TObject );
begin
  BtnClick( TIB_SearchBar_Button(Sender).Index );
end;

procedure TIB_SearchBar_Button.Paint;
var
  R: TRect;
begin
  inherited Paint;
  if ( GetFocus = Parent.Handle ) and
     ( FIndex = TIB_SearchBar(Parent).FocusedButton ) then
  begin
    R := Bounds( 0, 0, Width, Height );
    InflateRect( R, -3, -3 );
    if FState = bsDown then
      OffsetRect( R, 1, 1 );
    DrawFocusRect( Canvas.Handle, R );
  end;
end;

function TIB_SearchBar.GetOnReceiveFocus: TIB_DataLinkEvent;
begin
  Result := DataLink.OnReceiveFocus;
end;

procedure TIB_SearchBar.SetOnReceiveFocus( AValue: TIB_DataLinkEvent );
begin
  DataLink.OnReceiveFocus := AValue;
end;

{ Sample code from a form that is an IBF_Base descendant. See IBF_Base.PAS
  for help on SubKey and RegDB. They encapsulate the storage of data in the
  system registry database.

  This makes the saved Search criteria remain persistent between application
  instances.

procedure TfrmApp.sbWriteClick(Sender: TObject);
var
  tmpStrings: TIB_StringList;
begin
  tmpStrings := TIB_StringList.Create;
  try
    dmApp.qrApp.WriteSearch( tmpStrings );
    SubKey := 'Current';
    with RegDB do begin
      WriteStrings( 'Saved QBE', tmpStrings );
    end;
  finally
    tmpStrings.Free;
    SubKey := '';
  end;
end;

procedure TfrmApp.sbReadClick(Sender: TObject);
var
  tmpStrings: TIB_StringList;
begin
  tmpStrings := TIB_StringList.Create;
  try
    SubKey := 'Current';
    with RegDB do begin
      ReadStrings( 'Saved QBE', tmpStrings );
    end;
    dmApp.qrApp.ReadSearch( tmpStrings );
  finally
    tmpStrings.Free;
    SubKey := '';
  end;
end;
}

procedure TIB_SearchBar.SetCustomGlyphs(Value: TImageList);
begin
  if Assigned( FCustomGlyphs ) then
  begin
    FCustomGlyphs.OnChange := nil;
  end;
  FCustomGlyphs := Value;
  if Assigned( FCustomGlyphs ) then
  begin
    FCustomGlyphs.OnChange := CustomGlyphsChange;
  end;
  LoadCustomGlyphs;
end;

procedure TIB_SearchBar.CustomGlyphsChange(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then LoadCustomGlyphs;
end;

procedure TIB_SearchBar.SetCustomGlyphsSupplied(Value: TIB_SearchBar_ButtonSet);
begin
  if FCustomGlyphsSupplied <> Value then
  begin
    FCustomGlyphsSupplied := Value;
    LoadCustomGlyphs;
  end;
end;

procedure TIB_SearchBar.LoadCustomGlyphs;
var
  j: Integer;
  i: TIB_SearchBar_ButtonType;
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
        case I of
          sbOrder:  Assign( StandardBitmap( 'SRCH_BAR_ORDER' ));
          sbSearch: if DataLink.State = dssSearch then
            Assign( StandardBitmap( 'SRCH_BAR_LAST' ))
          else
            Assign( StandardBitmap( 'SRCH_BAR_SEARCH' ));
          sbSave:   Assign( StandardBitmap( 'SRCH_BAR_SAVE' ));
          sbClear:  Assign( StandardBitmap( 'SRCH_BAR_CLEAR' ));
          sbRecall: Assign( StandardBitmap( 'SRCH_BAR_RECALL' ));
          sbCount:  Assign( StandardBitmap( 'SRCH_BAR_COUNT' ));
          sbRestructure: Assign ( StandardBitmap ( 'SRCH_BAR_RESTR' ));
        end;
    end;
  end;
end;

procedure TIB_SearchBar.InitButtonsOrder;

  function GlobalOrderAssigned : boolean;
  var
    Flags : Array [TIB_SearchBar_ButtonType] of boolean;
    i : TIB_SearchBar_ButtonType;
    ii : byte;
  begin
    Result := False;
    for i := Low(TIB_SearchBar_ButtonType) to High(TIB_SearchBar_ButtonType) do
      Flags[i] := False;
    for ii := 0 to 7 do
    begin
      if not Flags[IB_SearchBar_ButtonsOrder[ii]] then
        Flags[IB_SearchBar_ButtonsOrder[ii]] := True
      else
        Exit; // the flag can't be Searchd twice
    end;
    // All items must be true
    for i := Low(TIB_SearchBar_ButtonType) to High(TIB_SearchBar_ButtonType)
    do
      if not Flags[i] then
        Exit;
    Result := True;
  end;

begin
  if GlobalOrderAssigned then
    FButtonsOrder := IB_SearchBar_ButtonsOrder
  else
  begin
    FButtonsOrder[0] := sbOrder;
    FButtonsOrder[1] := sbSearch;
    FButtonsOrder[2] := sbSave;
    FButtonsOrder[3] := sbClear;
    FButtonsOrder[4] := sbRecall;
    FButtonsOrder[5] := sbCount;
    FButtonsOrder[6] := sbRestructure;
  end;
end;

function TIB_SearchBar.GetButtonsOrder( Index: Integer ):
                                                       TIB_SearchBar_ButtonType;
begin
  Result := FButtonsOrder[Index];
end;

initialization
  SB_Images := TIB_StringList.Create;
  SB_Images.Sorted := true;
  FillImages;

finalization
  while SB_Images.Count > 0 do
  begin
    TBitmap( SB_Images.Objects[0] ).Free;
    SB_Images.Delete( 0 );
  end;
  SB_Images.Free;

end.
