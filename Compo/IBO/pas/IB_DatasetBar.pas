
{                                                                              }
{  IB_DatasetBar                                                               }
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

{: This unit contains the TIB_DatasetBar component. }
unit
  IB_DatasetBar;

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
<br>dbPrepare prepares the current statement in the SQL property.
<br>dbUnprepare unprepares the current statement in the SQL property.
<br>dbOpen Opens a cursor on the server to process the fetches.
<br>dbClose Closes the cursor opened on the server.}
TIB_DatasetBar_ButtonType = ( dbPrepare,
                              dbUnprepare,
                              dbOpen,
                              dbClose );

{: Set of button types for this button bar.}
TIB_DatasetBar_ButtonSet = set of TIB_DatasetBar_ButtonType;

TIB_DatasetBar_Button = class;

{: Button bar that gives access and control of statements and cursors.}
TIB_DatasetBar = class (TCustomPanel)
{$I IB_Bars.INT}
{$I IB_InterfaceDataLink.INT}
private
  FVisibleButtons: TIB_DatasetBar_ButtonSet;
  FFocusedButton: TIB_DatasetBar_ButtonType;
  FTogglePrepare: boolean;
  FToggleOpen: boolean;
  FCustomGlyphsSupplied: TIB_DatasetBar_ButtonSet;
  procedure SetVisibleButtons(Value: TIB_DatasetBar_ButtonSet);
  procedure SetCustomGlyphsSupplied(Value: TIB_DatasetBar_ButtonSet);
public
{: Storage array for the different buttons on this button bar. }
  Buttons: array[TIB_DatasetBar_ButtonType] of TIB_DatasetBar_Button;
{: Method used to pass the click of a single button to the owning parent.}
  procedure BtnClick(Index: TIB_DatasetBar_ButtonType);
{: The currently selected button of the button set.
<br><br>
Use this property in the xxxxAction events to know which button was clicked.}
  property FocusedButton: TIB_DatasetBar_ButtonType read FFocusedButton;
published
{: Set this property to indicate which glyphs have been supplied in the
CustomGlyphs property.}
  property CustomGlyphsSupplied: TIB_DatasetBar_ButtonSet
      read FCustomGlyphsSupplied
     write SetCustomGlyphsSupplied;
{: When Prepared the Unprepare button will be shown. When unprepared the
Prepare button will show.
<br><br>
Must also have only one of these buttons in the VisibleButtons property.}
  property TogglePrepare: boolean read FTogglePrepare
                                  write FTogglePrepare
                                  default false;
{: When Opened the Close button will be shown. When Closed the
Open button will show.
<br><br>
Must also have only one of these buttons in the VisibleButtons property.}
  property ToggleOpen: boolean read FToggleOpen
                               write FToggleOpen
                               default false;
{: Set which button are visible to the user.}
  property VisibleButtons: TIB_DatasetBar_ButtonSet
      read FVisibleButtons
     write SetVisibleButtons
   default [ dbOpen, dbClose ];
end;

TIB_DatasetBar_Button = class(TSpeedButton)
private
  FIndex: TIB_DatasetBar_ButtonType;
protected
  procedure Paint; override;
public
  property Index: TIB_DatasetBar_ButtonType read FIndex write FIndex;
end;

implementation

{$R IB_DatasetBar.RES}

{------------------------------------------------------------------------------}

constructor TIB_DatasetBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque];
  if not NewStyleControls then ControlStyle := ControlStyle + [csFramed];
  FIB_DataLink := TIB_InterfaceDataLink.Create( Self );
  with FIB_DataLink do begin
    Control := Self;
    AfterAssignment := IB_DatasetStateChanged;
    OnStateChanged := IB_DatasetStateChanged;
  end;
  FVisibleButtons := [dbOpen, dbClose];
  InitButtons;
  BevelOuter := bvNone;
  BevelInner := bvNone;
  Ctl3D := false;
  ParentCtl3D := false;
  Width := 121;
  Height := 25;
  ButtonWidth := 0;
  FFocusedButton := dbOpen;
{$IFDEF IBO_VCL30_OR_GREATER}
  Flat := true; // Hit the property.
{$ENDIF}
end;

destructor TIB_DatasetBar.Destroy;
begin
  if FCustomGlyphs <> nil then begin
    FCustomGlyphs.OnChange := nil;
  end;
  with FIB_DataLink do begin
    AfterAssignment := nil;
    OnStateChanged := nil;
  end;
  inherited Destroy;
end;

procedure TIB_DatasetBar.Notification( AComponent: TComponent;
                                       Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( CustomGlyphs <> nil ) and
     ( AComponent = CustomGlyphs ) then
    CustomGlyphs := nil;
end;

procedure TIB_DatasetBar.IB_DatasetStateChanged( Sender: TIB_DataLink;
                                                 DataSource: TIB_DataSource );
begin
  SysStateChanged;
end;

procedure TIB_DatasetBar.IB_DatasetDataChange( Sender: TIB_DataLink;
                                               DataSource: TIB_DataSource;
                                               IB_Field: TIB_Column );
begin
  SysStateChanged;
end;

function TIB_DatasetBar.GetDataSource: TIB_DataSource;
begin
  if FIB_DataLink <> nil then begin
    Result := FIB_DataLink.DataSource;
  end else begin
    Result := nil;
  end;
end;

{$IFDEF IBO_VCL30_OR_GREATER}
procedure TIB_DatasetBar.SetFlat( AValue: boolean );
begin
  if Flat <> AValue then begin
    FFlat := AValue;
    Buttons[ dbPrepare   ].Flat := Flat;
    Buttons[ dbUnprepare ].Flat := Flat;
    Buttons[ dbOpen      ].Flat := Flat;
    Buttons[ dbClose     ].Flat := Flat;
    Buttons[ dbOpen      ].Flat := Flat;
  end;
end;
{$ENDIF}

procedure TIB_DatasetBar.SetDataSource(AValue: TIB_DataSource);
begin
  if FIB_DataLink <> nil then begin
    if FIB_DataLink.DataSource <> AValue then begin
      FIB_DataLink.DataSource := AValue;
      SysStateChanged;
    end;
  end;
end;

function TIB_DatasetBar.GetReceiveFocus: boolean;
begin
  if FIB_DataLink <> nil then begin
    Result := FIB_DataLink.ReceiveFocus;
  end else begin
    Result := false;
  end;
end;

procedure TIB_DatasetBar.SetReceiveFocus(AValue: boolean);
begin
  if FIB_DataLink <> nil then begin
    FIB_DataLink.ReceiveFocus := AValue;
  end;
end;

procedure TIB_DatasetBar.InitHints;
var
  I: TIB_DatasetBar_ButtonType;
  Btn: TIB_DatasetBar_Button;
begin
  for I := Low(Buttons) to High(Buttons) do begin
    Btn := Buttons[ I ];
    case I of
      dbPrepare: Btn.Hint := H_DS_Prepare_Dataset;
      dbUnprepare: Btn.Hint := H_DS_Unprepare_Dataset;
      dbOpen: Btn.Hint := H_DS_Open_Dataset;
      dbClose: Btn.Hint := H_DS_Close_Dataset;
    end;
  end;
end;

procedure TIB_DatasetBar.InitButtons;
var
  I: TIB_DatasetBar_ButtonType;
  Btn: TIB_DatasetBar_Button;
  X: Integer;
begin
  MinBtnSize := Point(20, 18);
  X := 0;
  for I := Low(Buttons) to High(Buttons) do begin
    Btn := TIB_DatasetBar_Button.Create (Self);
    Btn.Index := I;
    Btn.Visible := I in FVisibleButtons;
    Btn.Enabled := True;
    Btn.SetBounds (X, 0, MinBtnSize.X, MinBtnSize.Y);
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

procedure TIB_DatasetBar.BtnMouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TIB_DatasetBar_ButtonType;
begin
  OldFocus := FocusedButton;
  FFocusedButton := TIB_DatasetBar_Button(Sender).Index;
  if TabStop and (GetFocus <> Handle) and CanFocus then begin
    SetFocus;
    if (GetFocus <> Handle) then
      Exit;
  end else if TabStop and
              (GetFocus = Handle) and
              (OldFocus <> FocusedButton) then begin
    Buttons[OldFocus].Invalidate;
    Buttons[FocusedButton].Invalidate;
  end;
end;

procedure TIB_DatasetBar.SetVisibleButtons(Value: TIB_DatasetBar_ButtonSet);
var
  I: TIB_DatasetBar_ButtonType;
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

procedure TIB_DatasetBar.AdjSize (var W: Integer; var H: Integer);
var
  Count: Integer;
  MinW: Integer;
  I: TIB_DatasetBar_ButtonType;
  Space, Temp, Remain: Integer;
  X: Integer;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[dbOpen] = nil then Exit;

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

procedure TIB_DatasetBar.WMSize(var Message: TWMSize);
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

procedure TIB_DatasetBar.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_DatasetBar.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_DatasetBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TIB_DatasetBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not ( csLoading in ComponentState ) then begin
    SysStateChanged;
  end;
end;

procedure TIB_DatasetBar.SysStateChanged;
var
  NewVisibleButtons: TIB_DatasetBar_ButtonSet;
begin
  with FIB_DataLink do begin
    NewVisibleButtons := VisibleButtons;
    if TogglePrepare then begin
      if Prepared then begin
        if     ( dbPrepare in VisibleButtons ) and
           not ( dbUnprepare in VisibleButtons ) then begin
          NewVisibleButtons := NewVisibleButtons + [ dbUnPrepare ] -
                                                   [ dbPrepare   ];
        end;
      end else begin
        if not ( dbPrepare in VisibleButtons ) and
               ( dbUnprepare in VisibleButtons ) then begin
          NewVisibleButtons := NewVisibleButtons + [ dbPrepare   ] -
                                                   [ dbUnprepare ];
        end;
      end;
    end;
    if ToggleOpen then begin
      if Active then begin
        if     ( dbOpen in VisibleButtons ) and
           not ( dbClose in VisibleButtons ) then begin
          NewVisibleButtons := NewVisibleButtons + [ dbClose ] -
                                                   [ dbOpen  ];
        end;
      end else begin
        if not ( dbOpen in VisibleButtons ) and
               ( dbClose in VisibleButtons ) then begin
          NewVisibleButtons := NewVisibleButtons + [ dbOpen  ] -
                                                   [ dbClose ];
        end;
      end;
    end;
    VisibleButtons := NewVisibleButtons;
    if Assigned( Dataset ) and Enabled then with DataSource.Dataset do begin
      Buttons[ dbPrepare   ].Enabled := not Prepared;
      Buttons[ dbUnprepare ].Enabled :=     Prepared;
      Buttons[ dbOpen      ].Enabled := not Active;
      Buttons[ dbClose     ].Enabled :=     Active;
      if not Prepared or
         ( StatementType = stSelect ) or
         ( StatementType = stSelectForUpdate ) then begin
        if (CustomGlyphs = nil) or not (dbOpen in CustomGlyphsSupplied) then
           Buttons[dbOpen].Glyph.Handle :=
                                        LoadBitmap(HInstance, 'DSET_BAR_OPEN' );
    end else begin
        if (CustomGlyphs = nil) or not (dbOpen in CustomGlyphsSupplied) then
          Buttons[dbOpen].Glyph.Handle :=
                                       LoadBitmap(HInstance,'DSET_BAR_EXECUTE');
        Buttons[dbClose].Enabled := false;
      end;
    end else begin
      Buttons[ dbPrepare   ].Enabled := false;
      Buttons[ dbUnprepare ].Enabled := false;
      Buttons[ dbOpen      ].Enabled := false;
      Buttons[ dbClose     ].Enabled := false;
      if (CustomGlyphs = nil) or not (dbOpen in CustomGlyphsSupplied) then
        Buttons[ dbOpen ].Glyph.Handle :=
                                        LoadBitmap(HInstance, 'DSET_BAR_OPEN' );
    end;
  end;
  InitHints;
  {added by Jaroslaw Gilewski}
  if not ( csDestroying in ComponentState ) and
    Assigned( FOnButtonsStateChanged ) then begin
    FOnButtonsStateChanged( Self );
  end;
end;

procedure TIB_DatasetBar.Loaded;
var
  W, H: Integer;
begin
  inherited Loaded;
  W := Width;
  H := Height;
  AdjSize (W, H);
  if (W <> Width) or (H <> Height) then begin
    inherited SetBounds (Left, Top, W, H);
  end;
  SysStateChanged;
end;

procedure TIB_DatasetBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TIB_DatasetBar_ButtonType;
  OldFocus: TIB_DatasetBar_ButtonType;
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

procedure TIB_DatasetBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  AdjSize (W, H);
  inherited SetBounds (ALeft, ATop, W, H);
end;

procedure TIB_DatasetBar.BtnClick(Index: TIB_DatasetBar_ButtonType);
begin
  FFocusedButton := Index;
  if Assigned( FBeforeAction ) then begin
    FBeforeAction( Self );
  end;
  if (DataSource <> nil) then begin
    with DataSource do begin
      if Dataset <> nil then with Dataset do begin
        case Index of
        dbPrepare: Prepare;
        dbUnprepare: Unprepare;
        dbOpen: begin
          if not Prepared then Prepare;
          if ( StatementType = stSelect ) or
             ( StatementType = stSelectForUpdate ) then begin
            Open;
          end else begin
            Execute;
          end;
        end;
        dbClose: Close;
        end;
      end;
    end;
  end;
  if Assigned( FAfterAction ) then begin
    FAfterAction( Self );
  end;
end;

procedure TIB_DatasetBar.BarClick( Sender: TObject );
begin
  BtnClick (TIB_DatasetBar_Button(Sender).Index);
end;

procedure TIB_DatasetBar_Button.Paint;
var
  R: TRect;
begin
  inherited Paint;
  if (GetFocus = Parent.Handle) and
     (FIndex = TIB_DatasetBar(Parent).FocusedButton) then begin
    R := Bounds(0, 0, Width, Height);
    InflateRect(R, -3, -3);
    if FState = bsDown then begin
      OffsetRect(R, 1, 1);
    end;
    DrawFocusRect(Canvas.Handle, R);
  end;
end;

function TIB_DatasetBar.GetOnReceiveFocus: TIB_DataLinkEvent;
begin
  Result := FIB_DataLink.OnReceiveFocus;
end;

procedure TIB_DatasetBar.SetOnReceiveFocus( AValue: TIB_DataLinkEvent );
begin
  FIB_DataLink.OnReceiveFocus := AValue;
end;

procedure TIB_DatasetBar.SetCustomGlyphs(Value: TImageList);
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

procedure TIB_DatasetBar.CustomGlyphsChange(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then LoadCustomGlyphs;
end;

procedure TIB_DatasetBar.SetCustomGlyphsSupplied(
                                               Value: TIB_DatasetBar_ButtonSet);
begin
  FCustomGlyphsSupplied := Value;
  LoadCustomGlyphs;
end;

procedure TIB_DatasetBar.LoadCustomGlyphs;
var
  j: Integer;
  i: TIB_DatasetBar_ButtonType;
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
      Buttons[i].NumGlyphs := 2;
      with Buttons[i].Glyph do case I of
        dbPrepare:   Handle := LoadBitmap( HInstance, 'DSET_BAR_PREPARE' );
        dbUnprepare: Handle := LoadBitmap( HInstance, 'DSET_BAR_UNPREPARE' );
        dbOpen:      Handle := LoadBitmap( HInstance, 'DSET_BAR_OPEN' );
        dbClose:     Handle := LoadBitmap( HInstance, 'DSET_BAR_CLOSE' );
      end;
    end;
  end;
end;

end.
