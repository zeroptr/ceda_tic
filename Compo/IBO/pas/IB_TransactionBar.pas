
{                                                                              }
{  IB_TransactionBar                                                           }
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

{: This unit contains the TIB_TransactionBar component. }
unit
  IB_TransactionBar;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Controls, StdCtrls,
  Forms, Graphics, ExtCtrls, Menus, Buttons, Dialogs,

  IB_Constants,
  IB_Components,
  IB_TransactionSource;

type
{: Button types included on this button bar.}
TIB_TransactionBar_ButtonType = ( tbStart,
                                  tbPostAll,
                                  tbCancelAll,
                                  tbSavePoint,
                                  tbCommitRetaining,
                                  tbCommit,
                                  tbRollbackRetaining,
                                  tbRollback,
                                  tbClose );

{: Set of button types for this button bar.}
TIB_TransactionBar_ButtonSet = set of TIB_TransactionBar_ButtonType;

TIB_TransactionBar_Button = class;

{: This control is used to provide an easy way to allow a user to Start,
SavePoint, CommitRetaining, Commit or RollBack a transaction.
<br><br>
See IB_SQL sample application for an example of its usage.}
TIB_TransactionBar = class (TCustomPanel)
{$I IB_Bars.INT}
private
  FIB_TransactionSource: TIB_TransactionSource;
  FVisibleButtons: TIB_TransactionBar_ButtonSet;
  FFocusedButton: TIB_TransactionBar_ButtonType;
  FCustomGlyphsSupplied: TIB_TransactionBar_ButtonSet;
  function GetOnReceiveFocus: TIB_TransactionLinkEvent;
  procedure SetOnReceiveFocus( AValue: TIB_TransactionLinkEvent );
  function GetTransaction: TIB_Transaction;
  procedure SetTransaction(AValue: TIB_Transaction);
  function GetReceiveFocus: boolean;
  procedure SetReceiveFocus(AValue: boolean);
  procedure SetVisible(Value: TIB_TransactionBar_ButtonSet);
  procedure SetCustomGlyphsSupplied(Value: TIB_TransactionBar_ButtonSet);
protected
  procedure IB_TransactionStatusChanged( TLink: TIB_TransactionLink;
                                         Sender: TIB_Transaction);
public
{: Array of buttons for this control.}
  Buttons: array[TIB_TransactionBar_ButtonType] of TIB_TransactionBar_Button;
{: }  
  procedure BtnClick( Index: TIB_TransactionBar_ButtonType );
{: Tells which button has the current focus.
<br><br>
This is handy for telling which button was clicked in the OnXXXAction events.}
  property FocusedButton: TIB_TransactionBar_ButtonType read FFocusedButton;
published
{: }
  property CustomGlyphsSupplied: TIB_TransactionBar_ButtonSet
    read FCustomGlyphsSupplied
   write SetCustomGlyphsSupplied;
{: The IB_Transaction for which this control will take action upon.}
  property IB_Transaction: TIB_Transaction
      read GetTransaction
     write SetTransaction;
{: Determine whether or not notification should be received when a new
transaction receives focus.}
  property ReceiveFocus: boolean read GetReceiveFocus write SetReceiveFocus;
{: Determine the buttons that the user can interact with.}
  property VisibleButtons: TIB_TransactionBar_ButtonSet
      read FVisibleButtons
     write SetVisible
   default [tbCommitRetaining, tbRollbackRetaining];
{: Define a custom action when a new Transaction focus notification is
received.
<br><br>
By default the IB_Transaction property of this control is assigned to the
newly focusing Transaction.}
  property OnReceiveFocus: TIB_TransactionLinkEvent read GetOnReceiveFocus
                                                    write SetOnReceiveFocus;
end;

TIB_TransactionBar_Button = class(TSpeedButton)
  private
    FIndex: TIB_TransactionBar_ButtonType;
  protected
    procedure Paint; override;
  public
    property Index: TIB_TransactionBar_ButtonType read FIndex write FIndex;
end;

implementation

{$R IB_TransactionBar.RES}

constructor TIB_TransactionBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque];
  if not NewStyleControls then ControlStyle := ControlStyle + [csFramed];
  FIB_TransactionSource := TIB_TransactionSource.Create( Self );
  with FIB_TransactionSource do begin
    AfterAssignment := IB_TransactionStatusChanged;
    OnStatusChanged := IB_TransactionStatusChanged;
  end;
  FVisibleButtons := [ tbCommitRetaining, tbRollbackRetaining ];
  InitButtons;
  BevelOuter := bvNone;
  BevelInner := bvNone;
  Ctl3D := false;
  ParentCtl3D := false;
  Width := 121;
  Height := 25;
  ButtonWidth := 0;
  FFocusedButton := tbStart;
{$IFDEF IBO_VCL30_OR_GREATER}
  Flat := true; // Hit the property.
{$ENDIF}
end;

destructor TIB_TransactionBar.Destroy;
begin
  if FCustomGlyphs <> nil then begin
    FCustomGlyphs.OnChange := nil;
  end;
  with FIB_TransactionSource do begin
    AfterAssignment := nil;
    OnStatusChanged := nil;
  end;
  inherited Destroy;
end;

procedure TIB_TransactionBar.Notification( AComponent: TComponent;
                                           Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( CustomGlyphs <> nil ) and
     ( AComponent = CustomGlyphs ) then
    CustomGlyphs := nil;
end;

procedure TIB_TransactionBar.IB_TransactionStatusChanged(
                                                     TLink: TIB_TransactionLink;
                                                       Sender: TIB_Transaction);
begin
  SysStateChanged;
end;

function TIB_TransactionBar.GetTransaction: TIB_Transaction;
begin
  if FIB_TransactionSource <> nil then begin
    Result :=  FIB_TransactionSource.IB_Transaction;
  end else begin
    Result := nil;
  end;
end;

{$IFDEF IBO_VCL30_OR_GREATER}
procedure TIB_TransactionBar.SetFlat( AValue: boolean );
begin
  if Flat <> AValue then begin
    FFlat := AValue;
    Buttons[ tbStart             ].Flat := Flat;
    Buttons[ tbCommitRetaining   ].Flat := Flat;
    Buttons[ tbSavePoint         ].Flat := Flat;
    Buttons[ tbPostAll           ].Flat := Flat;
    Buttons[ tbCancelAll         ].Flat := Flat;
    Buttons[ tbCommit            ].Flat := Flat;
    Buttons[ tbRollback          ].Flat := Flat;
    Buttons[ tbRollbackRetaining ].Flat := Flat;
    Buttons[ tbClose             ].Flat := Flat;
  end;
end;
{$ENDIF}

procedure TIB_TransactionBar.SetTransaction(AValue: TIB_Transaction);
begin
  if FIB_TransactionSource <> nil then begin
    if FIB_TransactionSource.IB_Transaction <> AValue then begin
      FIB_TransactionSource.IB_Transaction := AValue;
      SysStateChanged;
    end;
  end;
end;

function TIB_TransactionBar.GetReceiveFocus: boolean;
begin
  if FIB_TransactionSource <> nil then begin
    Result :=  FIB_TransactionSource.ReceiveFocus;
  end else begin
    Result := false;
  end;
end;

procedure TIB_TransactionBar.SetReceiveFocus(AValue: boolean);
begin
  if FIB_TransactionSource <> nil then begin
    FIB_TransactionSource.ReceiveFocus := AValue;
  end;
end;

procedure TIB_TransactionBar.InitButtons;
var
  I: TIB_TransactionBar_ButtonType;
  Btn: TIB_TransactionBar_Button;
  X: Integer;
begin
  MinBtnSize := Point(20, 18);
  X := 0;
  for I := Low(Buttons) to High(Buttons) do begin
    Btn := TIB_TransactionBar_Button.Create( Self );
    Btn.Index := I;
    Btn.Visible := I in FVisibleButtons;
    Btn.Enabled := True;
    Btn.SetBounds( X, 0, MinBtnSize.X, MinBtnSize.Y );
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

procedure TIB_TransactionBar.InitHints;
var
  I: TIB_TransactionBar_ButtonType;
  Btn: TIB_TransactionBar_Button;
begin
  for I := Low(Buttons) to High(Buttons) do begin
    Btn := Buttons[ I ];
    case I of
      tbStart: Btn.Hint := H_TB_StartTransaction;
      tbPostAll: Btn.Hint := H_TB_PostDatasets;
      tbCancelAll: Btn.Hint := H_TB_CancelDatasets;
      tbSavePoint: Btn.Hint := H_TB_SavePoint;
      tbCommitRetaining: Btn.Hint := H_TB_CommitRetain;
      tbCommit: Btn.Hint := H_TB_Commit;
      tbRollback: Btn.Hint := H_TB_Rollback;
      tbRollbackRetaining: Btn.Hint := H_TB_RollbackRetain;
      tbClose: Btn.Hint := H_TB_Close;
    end;
  end;
end;

procedure TIB_TransactionBar.BtnMouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TIB_TransactionBar_ButtonType;
begin
  OldFocus := FocusedButton;
  FFocusedButton := TIB_TransactionBar_Button(Sender).Index;
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

procedure TIB_TransactionBar.SetVisible(Value: TIB_TransactionBar_ButtonSet);
var
  I: TIB_TransactionBar_ButtonType;
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

procedure TIB_TransactionBar.AdjSize (var W: Integer; var H: Integer);
var
  Count: Integer;
  MinW: Integer;
  I: TIB_TransactionBar_ButtonType;
  Space, Temp, Remain: Integer;
  X: Integer;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[tbStart] = nil then Exit;

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

procedure TIB_TransactionBar.WMSize(var Message: TWMSize);
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

procedure TIB_TransactionBar.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_TransactionBar.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_TransactionBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TIB_TransactionBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    SysStateChanged;
end;

procedure TIB_TransactionBar.SysStateChanged;
begin
  if Assigned( IB_Transaction ) and Enabled then begin
    with IB_Transaction do begin
      Buttons[ tbStart             ].Enabled := not InTransaction;
      Buttons[ tbSavePoint         ].Enabled := TransactionState = tsActive;
      Buttons[ tbPostAll           ].Enabled := PostPendingCount > 0;
      Buttons[ tbCancelAll         ].Enabled := PostPendingCount > 0;
      Buttons[ tbCommitRetaining   ].Enabled := TransactionIsActive or
                                                InTransaction and
                           not ( TransactionState in PendingTransactionStates );
      Buttons[ tbRollbackRetaining ].Enabled := TransactionIsActive or
                                                InTransaction and
                           not ( TransactionState in PendingTransactionStates );
      Buttons[ tbCommit            ].Enabled := Started or
                                                TransactionIsActive or
                                                InTransaction;
      Buttons[ tbRollback          ].Enabled := Started or
                                                TransactionIsActive or
                                                InTransaction;
      Buttons[ tbClose             ].Enabled := Started or
                                                TransactionIsActive or
                                                InTransaction;
    end;
  end else begin
    Buttons[ tbStart             ].Enabled := false;
    Buttons[ tbPostAll           ].Enabled := false;
    Buttons[ tbCancelAll         ].Enabled := false;
    Buttons[ tbSavePoint         ].Enabled := false;
    Buttons[ tbCommitRetaining   ].Enabled := false;
    Buttons[ tbCommit            ].Enabled := false;
    Buttons[ tbRollbackRetaining ].Enabled := false;
    Buttons[ tbRollback          ].Enabled := false;
    Buttons[ tbClose             ].Enabled := false;
  end;
  InitHints;
  if not ( csDestroying in ComponentState ) and
    Assigned( FOnButtonsStateChanged ) then begin
    FOnButtonsStateChanged( Self );
  end;
end;

procedure TIB_TransactionBar.Loaded;
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

procedure TIB_TransactionBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TIB_TransactionBar_ButtonType;
  OldFocus: TIB_TransactionBar_ButtonType;
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

procedure TIB_TransactionBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  AdjSize (W, H);
  inherited SetBounds (ALeft, ATop, W, H);
end;

procedure TIB_TransactionBar.BtnClick( Index: TIB_TransactionBar_ButtonType );
begin
  FFocusedButton := Index;
  if not (csDesigning in ComponentState) and
     Assigned( FBeforeAction ) then begin
    FBeforeAction( Self );
  end;
  if (IB_Transaction <> nil) then begin
    with IB_Transaction do begin
      case Index of
      tbStart:             StartTransaction;
      tbSavePoint:         SavePoint;
      tbCommitRetaining:   if CachedUpdatePendingCount > 0 then
                             ApplyUpdates( [nil] )
                           else
                             CommitRetaining;
      tbPostAll:           PostAll;
      tbCancelAll:         CancelAll;
      tbCommit:            if CachedUpdatePendingCount > 0 then
                             ApplyUpdates( [nil] )
                           else
                             Commit;
      tbRollback:          if CachedUpdatePendingCount > 0 then
                             CancelUpdates( [nil] )
                           else
                             Rollback;
      tbRollbackRetaining: if CachedUpdatePendingCount > 0 then
                             CancelUpdates( [nil] )
                           else
                             RollbackRetaining;
      tbClose:             Close;
      end;
    end;
  end;
  if not (csDesigning in ComponentState) and
     Assigned( FAfterAction ) then begin
    FAfterAction( Self );
  end;
end;

procedure TIB_TransactionBar.BarClick( Sender: TObject );
begin
  BtnClick (TIB_TransactionBar_Button(Sender).Index);
end;

procedure TIB_TransactionBar_Button.Paint;
var
  R: TRect;
begin
  inherited Paint;
  if (GetFocus = Parent.Handle) and
     (FIndex = TIB_TransactionBar(Parent).FocusedButton) then
  begin
    R := Bounds(0, 0, Width, Height);
    InflateRect(R, -3, -3);
    if FState = bsDown then
      OffsetRect(R, 1, 1);
    DrawFocusRect(Canvas.Handle, R);
  end;
end;

function TIB_TransactionBar.GetOnReceiveFocus: TIB_TransactionLinkEvent;
begin
  Result := FIB_TransactionSource.OnReceiveFocus;
end;

procedure TIB_TransactionBar.SetOnReceiveFocus( AValue: TIB_TransactionLinkEvent );
begin
  FIB_TransactionSource.OnReceiveFocus := AValue;
end;

procedure TIB_TransactionBar.SetCustomGlyphs(Value: TImageList);
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

procedure TIB_TransactionBar.CustomGlyphsChange(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then LoadCustomGlyphs;
end;

procedure TIB_TransactionBar.SetCustomGlyphsSupplied(Value: TIB_TransactionBar_ButtonSet);
begin
  FCustomGlyphsSupplied := Value;
  LoadCustomGlyphs;
end;

procedure TIB_TransactionBar.LoadCustomGlyphs;
var
  j: Integer;
  i: TIB_TransactionBar_ButtonType;
  Glyph: TBitmap;
begin
  j := 0;
  for i:= low(Buttons) to high(Buttons) do begin
    if Assigned( FCustomGlyphs ) and
       ( i in CustomGlyphsSupplied ) and
       ( j < FCustomGlyphs.Count ) then begin
      Glyph := TBitmap.Create;
      FCustomGlyphs.GetBitmap(j,Glyph);
      Buttons[i].Glyph.Assign(Glyph);
      Buttons[i].NumGlyphs := 1;
      Buttons[i].Caption := '';
      Glyph.Free;
      inc(j);
    end else begin
      Buttons[I].NumGlyphs := 2;
      with Buttons[I].Glyph do case I of
        tbStart:           Handle := LoadBitmap(HInstance,'TRAN_BAR_START'  );
        tbSavePoint:       Handle := LoadBitmap(HInstance,'TRAN_BAR_SAVEPOINT');
        tbCommitRetaining: Handle := LoadBitmap(HInstance,'TRAN_BAR_CMT_RET');
        tbPostAll:         Handle := LoadBitmap(HInstance,'TRAN_BAR_POSTALL' );
        tbCancelAll:       Handle := LoadBitmap(HInstance,'TRAN_BAR_CANCELALL');
        tbCommit:          Handle := LoadBitmap(HInstance,'TRAN_BAR_COMMIT' );
        tbRollback:        Handle := LoadBitmap(HInstance,'TRAN_BAR_ROLLBACK' );
        tbRollbackRetaining:Handle:=LoadBitmap(HInstance,'TRAN_BAR_ROLLBACKR');
        tbClose:           Handle := LoadBitmap(HInstance,'TRAN_BAR_CLOSE' );
      end;
    end;
  end;
end;

end.
