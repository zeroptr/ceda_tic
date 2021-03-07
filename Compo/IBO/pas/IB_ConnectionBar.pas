
{                                                                              }
{  IB_ConnectionBar                                                            }
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

{: This unit contains the TIB_ConnectionBar component. }
unit
  IB_ConnectionBar;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Controls, StdCtrls,
  Forms, Graphics, ExtCtrls, Menus, Buttons, Dialogs,

  IB_Constants,
  IB_Components,
  IB_ConnectionSource;

type
{: Button types included on this button bar.}
TIB_ConnectionBar_ButtonType = ( cbCreate,
                                 cbDrop,
                                 cbConnect,
                                 cbDisconnect );
{: Set of button types for this button bar.}
TIB_ConnectionBar_ButtonSet = set of TIB_ConnectionBar_ButtonType;
 
TIB_ConnectionBar_Button = class;
  
{: This control is used to provide an easy way to allow a user to create,
connect, disconnect or drop a database.
<br><br>
See IB_SQL sample application for an example of its usage.}  
TIB_ConnectionBar = class (TCustomPanel)
{$I IB_Bars.INT}
private
  FIB_ConnectionSource: TIB_ConnectionSource;
  FVisibleButtons: TIB_ConnectionBar_ButtonSet;
  FToggleCreate: boolean;
  FToggleConnect: boolean;
  FFocusedButton: TIB_ConnectionBar_ButtonType;
  FCustomGlyphsSupplied: TIB_ConnectionBar_ButtonSet;
  function GetOnReceiveFocus: TIB_ConnectionLinkEvent;
  procedure SetOnReceiveFocus( AValue: TIB_ConnectionLinkEvent );
  function GetConnection: TIB_Connection;
  procedure SetConnection(AValue: TIB_Connection);
  function GetReceiveFocus: boolean;
  procedure SetReceiveFocus(AValue: boolean);
  procedure SetVisible(Value: TIB_ConnectionBar_ButtonSet);
  procedure SetCustomGlyphsSupplied(Value: TIB_ConnectionBar_ButtonSet);
protected
  procedure IB_ConnectionConnectedChanged( CLink: TIB_ConnectionLink;
                                           C: TIB_Connection);
public
{: Array of buttons for this control.}
  Buttons: array[TIB_ConnectionBar_ButtonType] of TIB_ConnectionBar_Button;
{: Method used to produce a button click action.}
  procedure BtnClick(Index: TIB_ConnectionBar_ButtonType);
{: Tells which button has the current focus.
<br><br>
This is handy for telling which button was clicked in the OnXXXAction events.}
  property FocusedButton: TIB_ConnectionBar_ButtonType read FFocusedButton;
published
{: }
  property CustomGlyphsSupplied: TIB_ConnectionBar_ButtonSet
      read FCustomGlyphsSupplied
     write SetCustomGlyphsSupplied;
{: Connection for which this control will take action for.}
  property IB_Connection: TIB_Connection
      read GetConnection
     write SetConnection;
{: Determine whether or not notification should be received when a new
connection receives focus.}
  property ReceiveFocus: boolean read GetReceiveFocus write SetReceiveFocus;
{: When connected the Disconnect button will be shown; otherwise, the
Connect button will show.
<br><br>
Must also have only one of these buttons in the VisibleButtons property.}
  property ToggleConnect: boolean read FToggleConnect
                                  write FToggleConnect
                                  default false;
{: When connected the Drop button will be shown; otherwise, the
Create button will show.
<br><br>
Must also have only one of these buttons in the VisibleButtons property.}
  property ToggleCreate: boolean read FToggleCreate
                                  write FToggleCreate
                                  default false;
{: Determine the buttons that the user can interact with.}
  property VisibleButtons: TIB_ConnectionBar_ButtonSet
      read FVisibleButtons
     write SetVisible
   default [cbConnect, cbDisconnect];
{: Define a custom action when a new connection focus notification is
received.
<br><br>
By default the IB_Connection property of this control is assigned to the
newly focusing connection.}
  property OnReceiveFocus: TIB_ConnectionLinkEvent read GetOnReceiveFocus
                                                   write SetOnReceiveFocus;
end;

TIB_ConnectionBar_Button = class(TSpeedButton)
  private
    FIndex: TIB_ConnectionBar_ButtonType;
  protected
    procedure Paint; override;
  public
    property Index: TIB_ConnectionBar_ButtonType read FIndex write FIndex;
end;

implementation

{$R IB_ConnectionBar.RES}

constructor TIB_ConnectionBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque];
  if not NewStyleControls then ControlStyle := ControlStyle + [csFramed];
  FIB_ConnectionSource := TIB_ConnectionSource.Create( Self );
  with FIB_ConnectionSource do begin
    AfterAssignment := IB_ConnectionConnectedChanged;
    OnConnectedChanged := IB_ConnectionConnectedChanged;
  end;
  FVisibleButtons := [cbConnect, cbDisconnect];
  InitButtons;
  BevelOuter := bvNone;
  BevelInner := bvNone;
  Ctl3D := false;
  ParentCtl3D := false;
  Width := 121;
  Height := 25;
  ButtonWidth := 0;
  FFocusedButton := cbConnect;
{$IFDEF IBO_VCL30_OR_GREATER}
  Flat := true; // Hit the property.
{$ENDIF}
end;

destructor TIB_ConnectionBar.Destroy;
begin
  if FCustomGlyphs <> nil then begin
    FCustomGlyphs.OnChange := nil;
  end;
  with FIB_ConnectionSource do begin
    AfterAssignment := nil;
    OnConnectedChanged := nil;
  end;
  inherited Destroy;
end;

procedure TIB_ConnectionBar.Notification( AComponent: TComponent;
                                          Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( CustomGlyphs <> nil ) and
     ( AComponent = CustomGlyphs ) then
    CustomGlyphs := nil;
end;

procedure TIB_ConnectionBar.IB_ConnectionConnectedChanged(
                                                      CLink: TIB_ConnectionLink;
                                                      C: TIB_Connection);
begin
  SysStateChanged;
end;

function TIB_ConnectionBar.GetConnection: TIB_Connection;
begin
  if FIB_ConnectionSource <> nil then begin
    Result := FIB_ConnectionSource.IB_Connection;
  end else begin
    Result := nil;
  end;
end;

{$IFDEF IBO_VCL30_OR_GREATER}
procedure TIB_ConnectionBar.SetFlat( AValue: boolean );
begin
  if Flat <> AValue then begin
    FFlat := AValue;
    Buttons[ cbCreate     ].Flat := Flat;
    Buttons[ cbConnect    ].Flat := Flat;
    Buttons[ cbDisconnect ].Flat := Flat;
    Buttons[ cbDrop       ].Flat := Flat;
  end;
end;
{$ENDIF}

procedure TIB_ConnectionBar.SetConnection(AValue: TIB_Connection);
begin
  if FIB_ConnectionSource <> nil then begin
    if FIB_ConnectionSource.IB_Connection <> AValue then begin
      FIB_ConnectionSource.IB_Connection := AValue;
      SysStateChanged;
    end;
  end;
end;

function TIB_ConnectionBar.GetReceiveFocus: boolean;
begin
  if FIB_ConnectionSource <> nil then begin
    Result :=  FIB_ConnectionSource.ReceiveFocus;
  end else begin
    Result := false;
  end;
end;

procedure TIB_ConnectionBar.SetReceiveFocus(AValue: boolean);
begin
  if FIB_ConnectionSource <> nil then begin
    FIB_ConnectionSource.ReceiveFocus := AValue;
  end;
end;

procedure TIB_ConnectionBar.InitButtons;
var
  I: TIB_ConnectionBar_ButtonType;
  Btn: TIB_ConnectionBar_Button;
  X: Integer;
begin
  MinBtnSize := Point(20, 18);
  X := 0;
  for I := Low(Buttons) to High(Buttons) do begin
    Btn := TIB_ConnectionBar_Button.Create (Self);
    Btn.Index := I;
    Btn.Visible := I in FVisibleButtons;
    Btn.Enabled := True;
    Btn.SetBounds (X, 0, MinBtnSize.X, MinBtnSize.Y);
    case I of
      cbCreate: begin
        Btn.Hint := H_CB_Create_Database;
      end;
      cbConnect: begin
        Btn.Hint := H_CB_Connect_Database;
      end;
      cbDisconnect: begin
        Btn.Hint := H_CB_Disconnect_Database;
      end;
      cbDrop: begin
        Btn.Hint := H_CB_Drop_Database;
      end;
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

procedure TIB_ConnectionBar.InitHints;
var
  I: TIB_ConnectionBar_ButtonType;
  Btn: TIB_ConnectionBar_Button;
begin
  for I := Low(Buttons) to High(Buttons) do begin
    Btn := Buttons[ I ];
    case I of
      cbCreate: begin
        Btn.Hint := H_CB_Create_Database;
      end;
      cbConnect: begin
        Btn.Hint := H_CB_Connect_Database;
      end;
      cbDisconnect: begin
        Btn.Hint := H_CB_Disconnect_Database;
      end;
      cbDrop: begin
        Btn.Hint := H_CB_Drop_Database;
      end;
    end;
  end;
end;

procedure TIB_ConnectionBar.BtnMouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TIB_ConnectionBar_ButtonType;
begin
  OldFocus := FocusedButton;
  FFocusedButton := TIB_ConnectionBar_Button(Sender).Index;
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

procedure TIB_ConnectionBar.SetVisible(Value: TIB_ConnectionBar_ButtonSet);
var
  I: TIB_ConnectionBar_ButtonType;
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


procedure TIB_ConnectionBar.AdjSize (var W: Integer; var H: Integer);
var
  Count: Integer;
  MinW: Integer;
  I: TIB_ConnectionBar_ButtonType;
  Space, Temp, Remain: Integer;
  X: Integer;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[cbCreate] = nil then Exit;

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

procedure TIB_ConnectionBar.WMSize(var Message: TWMSize);
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

procedure TIB_ConnectionBar.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_ConnectionBar.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_ConnectionBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TIB_ConnectionBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    SysStateChanged;
end;

procedure TIB_ConnectionBar.SysStateChanged;
var
  NewVisibleButtons: TIB_ConnectionBar_ButtonSet;
begin
  if Assigned(IB_Connection) then with IB_Connection do begin
    NewVisibleButtons := VisibleButtons;
    if ToggleConnect then begin
      if Connected then begin
        if     ( cbConnect in VisibleButtons ) and
           not ( cbDisconnect in VisibleButtons ) then begin
          NewVisibleButtons := NewVisibleButtons + [ cbDisconnect ] -
                                                   [ cbConnect    ];
        end;
      end else begin
        if not ( cbConnect in VisibleButtons ) and
               ( cbDisconnect in VisibleButtons ) then begin
          NewVisibleButtons := NewVisibleButtons + [ cbConnect    ] -
                                                   [ cbDisconnect ];
        end;
      end;
    end;
    if ToggleCreate then begin
      if Connected then begin
        if     ( cbCreate in VisibleButtons ) and
           not ( cbDrop in VisibleButtons ) then begin
          NewVisibleButtons := NewVisibleButtons + [ cbDrop   ] -
                                                   [ cbCreate ];
        end;
      end else begin
        if not ( cbCreate in VisibleButtons ) and
               ( cbDrop in VisibleButtons ) then begin
          NewVisibleButtons := NewVisibleButtons + [ cbCreate ] -
                                                   [ cbDrop   ];
        end;
      end;
    end;
    VisibleButtons := NewVisibleButtons;
  end;
  if (IB_Connection <> nil) and (Enabled) then begin
    Buttons[ cbCreate     ].Enabled := not IB_Connection.Connected;
    Buttons[ cbConnect    ].Enabled := not IB_Connection.Connected;
    Buttons[ cbDisconnect ].Enabled :=     IB_Connection.Connected;
    Buttons[ cbDrop       ].Enabled :=     IB_Connection.Connected;
  end else begin
    Buttons[ cbCreate     ].Enabled := false;
    Buttons[ cbConnect    ].Enabled := false;
    Buttons[ cbDisconnect ].Enabled := false;
    Buttons[ cbDrop       ].Enabled := false;
  end;
  InitHints;
  {added by Jaroslaw Gilewski}
  if not ( csDestroying in ComponentState ) and
    Assigned( FOnButtonsStateChanged ) then begin
    FOnButtonsStateChanged( Self );
  end;
end;

procedure TIB_ConnectionBar.Loaded;
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

procedure TIB_ConnectionBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TIB_ConnectionBar_ButtonType;
  OldFocus: TIB_ConnectionBar_ButtonType;
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

procedure TIB_ConnectionBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  AdjSize (W, H);
  inherited SetBounds (ALeft, ATop, W, H);
end;

procedure TIB_ConnectionBar.BtnClick(Index: TIB_ConnectionBar_ButtonType);
begin
  FFocusedButton := Index;
  if Assigned( FBeforeAction ) then begin
    FBeforeAction( Self );
  end;
  if (IB_Connection <> nil) then begin
    with IB_Connection do begin
      case Index of
      cbCreate:     CreateDatabase;
      cbConnect:    Connect;
      cbDisconnect: Disconnect;
      cbDrop:       DropDatabase;
      end;
    end;
  end;
  if Assigned( FAfterAction ) then begin
    FAfterAction( Self );
  end;
end;

procedure TIB_ConnectionBar.BarClick( Sender: TObject );
begin
  BtnClick(TIB_ConnectionBar_Button(Sender).Index);
end;

procedure TIB_ConnectionBar_Button.Paint;
var
  R: TRect;
begin
  inherited Paint;
  if (GetFocus = Parent.Handle) and
     (FIndex = TIB_ConnectionBar(Parent).FocusedButton) then
  begin
    R := Bounds(0, 0, Width, Height);
    InflateRect(R, -3, -3);
    if FState = bsDown then
      OffsetRect(R, 1, 1);
    DrawFocusRect(Canvas.Handle, R);
  end;
end;

function TIB_ConnectionBar.GetOnReceiveFocus: TIB_ConnectionLinkEvent;
begin
  Result := FIB_ConnectionSource.OnReceiveFocus;
end;

procedure TIB_ConnectionBar.SetOnReceiveFocus( AValue: TIB_ConnectionLinkEvent );
begin
  FIB_ConnectionSource.OnReceiveFocus := AValue;
end;


procedure TIB_ConnectionBar.SetCustomGlyphs(Value: TImageList);
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

procedure TIB_ConnectionBar.CustomGlyphsChange(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then LoadCustomGlyphs;
end;

procedure TIB_ConnectionBar.SetCustomGlyphsSupplied(Value: TIB_ConnectionBar_ButtonSet);
begin
  FCustomGlyphsSupplied := Value;
  LoadCustomGlyphs;
end;

procedure TIB_ConnectionBar.LoadCustomGlyphs;
var
  j: Integer;
  i: TIB_ConnectionBar_ButtonType;
  Glyph: TBitmap;
begin
  j := 0;
  for i:= low( Buttons ) to high( Buttons ) do begin
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
      Buttons[i].NumGlyphs := 2;
      with Buttons[i].Glyph do case I of
        cbCreate: Handle := LoadBitmap( HInstance, 'CON_BAR_CREATE' );
        cbDrop: Handle := LoadBitmap( HInstance, 'CON_BAR_DROP' );
        cbConnect: Handle := LoadBitmap( HInstance, 'CON_BAR_CONNECT' );
        cbDisconnect: Handle := LoadBitmap( HInstance, 'CON_BAR_DISCONNECT' );
      end;
    end;
  end;
end;

end.
