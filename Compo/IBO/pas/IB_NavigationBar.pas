
{                                                                              }
{  IB_NavigationBar                                                            }
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

{: This unit contains the TIB_NavigationBar component. }
unit
  IB_NavigationBar;

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
<br>
<br>nbFirst goes to the first row in the dataset.
<br>nbJumpBck jumps back a predefined number of rows in the dataset.
<br>nbPrior goes to the previous row in the dataset.
<br>nbNext goes to the next row in the dataset.
<br>nbJumpFwd jumps forward a predefined number of rows in the dataset.
<br>nbLast goes to the end of the dataset.}
TIB_NavigationBar_ButtonType = ( nbFirst,
                                 nbJumpBck,
                                 nbPrior,
                                 nbNext,
                                 nbJumpFwd,
                                 nbLast );

{: Set of button types for this button bar.}
  TIB_NavBar_BtnSet = set of TIB_NavigationBar_ButtonType;

  TIB_NavigationBar_Button = class;

{: Button bar that gives access and control of navigating through a dataset.}
TIB_NavigationBar = class (TCustomPanel)
{$I IB_Bars.INT}
{$I IB_InterfaceDataLink.INT}
private
  FVisibleButtons: TIB_NavBar_BtnSet;
  FCustomGlyphsSupplied: TIB_NavBar_BtnSet;
  FFocusedButton: TIB_NavigationBar_ButtonType;
  FJumpCount: word;
  procedure SetCustomGlyphsSupplied(Value: TIB_NavBar_BtnSet);
  procedure SetVisibleButtons(Value: TIB_NavBar_BtnSet);
public
{: Storage array for the different buttons on this button bar. }
  Buttons: array[TIB_NavigationBar_ButtonType] of TIB_NavigationBar_Button;
{: Method used to pass the click of a single button to the owning parent.}
  procedure BtnClick(Index: TIB_NavigationBar_ButtonType);
{: The currently selected button of the button set.
<br><br>
Use this property in the xxxxAction events to know which button was clicked.}
  property FocusedButton: TIB_NavigationBar_ButtonType read FFocusedButton;
published
{: Number of records jumped forward and backward when the JumpXXX buttons
are clicked.}
  property JumpCount: word read FJumpCount write FJumpCount default 5;
{: Set this property to indicate which glyphs have been supplied in the
CustomGlyphs property.}
  property CustomGlyphsSupplied: TIB_NavBar_BtnSet
      read FCustomGlyphsSupplied
     write SetCustomGlyphsSupplied;
{: Set which buttons are visible to the user.}
  property VisibleButtons: TIB_NavBar_BtnSet read FVisibleButtons
                                             write SetVisibleButtons
                                             default [ nbFirst, nbPrior,
                                                       nbNext,  nbLast ];
end;

TIB_NavigationBar_Button = class(TSpeedButton)
private
  FIndex: TIB_NavigationBar_ButtonType;
  FTimerInterval: word;
  FRepeatTimer: TTimer;
  procedure TimerExpired(Sender: TObject);
protected
  procedure Paint; override;
  procedure MouseDown( Button: TMouseButton;
                       Shift: TShiftState;
                       X, Y: Integer); override;
  procedure MouseUp( Button: TMouseButton;
                     Shift: TShiftState;
                     X, Y: Integer); override;
public
  destructor Destroy; override;
  property Index: TIB_NavigationBar_ButtonType read FIndex write FIndex;
  property TimerInterval: word read FTimerInterval write FTimerInterval;
end;

var
  NB_Images: TStringList;

implementation

{$R IB_NavigationBar.RES}

function StandardBitmap(S:String):tBitmap;
var
  x: integer;
begin
  if NB_Images.Find( S, x ) then
    Result := TBitmap( NB_Images.Objects[x] )
  else
    Result := nil;
end;

procedure FilImages;
var
  i: integer;
  b: TBitmap;
const
  a: array[0..5] of pchar = ( 'NAV_BAR_FIRST',
                              'NAV_BAR_JUMP_BACK',
                              'NAV_BAR_PRIOR',
                              'NAV_BAR_NEXT',
                              'NAV_BAR_JUMP_FRWD',
                              'NAV_BAR_LAST' );
begin
  for i := low(a) to high(a) do
  begin
    B := TBitmap.Create;
    B.LoadFromResourceName( hinstance, strPas(a[i] ));
    NB_Images.AddObject( strPas( a[i] ), b );
  end;
end;

constructor TIB_NavigationBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque];
  if not NewStyleControls then ControlStyle := ControlStyle + [csFramed];
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
  FVisibleButtons := [ nbFirst,   nbPrior,  nbNext, nbLast ];
  InitButtons;
  BevelOuter := bvNone;
  BevelInner := bvNone;
  Ctl3D := false;
  ParentCtl3D := false;
  Width := 121;
  Height := 25;
  ButtonWidth := 0;
  FFocusedButton := nbFirst;
  FJumpCount := 5;
{$IFDEF IBO_VCL30_OR_GREATER}
  Flat := true; // Hit the property.
{$ENDIF}
end;

destructor TIB_NavigationBar.Destroy;
begin
  if FCustomGlyphs <> nil then
    FCustomGlyphs.OnChange := nil;
  with DataLink do
  begin
    AfterAssignment := nil;
    OnPreparedChanged := nil;
    OnActiveChange := nil;
    OnStateChanged := nil;
    OnDataChange := nil;
  end;
  inherited Destroy;
end;

procedure TIB_NavigationBar.Notification( AComponent: TComponent;
                                          Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( CustomGlyphs <> nil ) and
     ( AComponent = CustomGlyphs ) then
    CustomGlyphs := nil;
end;

procedure TIB_NavigationBar.IB_DatasetStateChanged( Sender: TIB_DataLink;
                                                   DataSource: TIB_DataSource );
begin
  SysStateChanged;
end;

procedure TIB_NavigationBar.IB_DatasetDataChange( Sender: TIB_DataLink;
                                                  DataSource: TIB_DataSource;
                                                  IB_Field: TIB_Column );
begin
  SysStateChanged;
end;

function TIB_NavigationBar.GetDataSource: TIB_DataSource;
begin
  Result := DataLink.DataSource;
end;

{$IFDEF IBO_VCL30_OR_GREATER}
procedure TIB_NavigationBar.SetFlat( AValue: boolean );
begin
  if Flat <> AValue then
  begin
    FFlat := AValue;
    Buttons[ nbFirst   ].Flat := Flat;
    Buttons[ nbJumpBck ].Flat := Flat;
    Buttons[ nbPrior   ].Flat := Flat;
    Buttons[ nbNext    ].Flat := Flat;
    Buttons[ nbJumpFwd ].Flat := Flat;
    Buttons[ nbLast    ].Flat := Flat;
  end;
end;
{$ENDIF}

procedure TIB_NavigationBar.SetDataSource(AValue: TIB_DataSource);
begin
  if DataLink.DataSource <> AValue then
  begin
    DataLink.DataSource := AValue;
    SysStateChanged;
  end;
end;

function TIB_NavigationBar.GetReceiveFocus: boolean;
begin
  Result := DataLink.ReceiveFocus;
end;

procedure TIB_NavigationBar.SetReceiveFocus(AValue: boolean);
begin
  DataLink.ReceiveFocus := AValue;
end;

procedure TIB_NavigationBar.InitButtons;
var
  I: TIB_NavigationBar_ButtonType;
  Btn: TIB_NavigationBar_Button;
  X: Integer;
begin
  MinBtnSize := Point(20, 18);
  X := 0;
  for I := Low(Buttons) to High(Buttons) do
  begin
    Btn := TIB_NavigationBar_Button.Create (Self);
    Btn.Index := I;
    Btn.Visible := I in FVisibleButtons;
    Btn.Enabled := True;
    Btn.SetBounds (X, 0, MinBtnSize.X, MinBtnSize.Y);
    if I in [ nbJumpBck, nbPrior, nbNext, nbJumpFwd ] then
      Btn.TimerInterval := 85;
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

procedure TIB_NavigationBar.BtnMouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TIB_NavigationBar_ButtonType;
begin
  OldFocus := FocusedButton;
  FFocusedButton := TIB_NavigationBar_Button(Sender).Index;
  if TabStop and (GetFocus <> Handle) and CanFocus then
  begin
    SetFocus;
    if (GetFocus <> Handle) then Exit;
  end
  else
  if TabStop and (GetFocus = Handle) and
                 (OldFocus <> FocusedButton) then
  begin
    Buttons[OldFocus].Invalidate;
    Buttons[FocusedButton].Invalidate;
  end;
end;

procedure TIB_NavigationBar.SetVisibleButtons(Value: TIB_NavBar_BtnSet);
var
  I: TIB_NavigationBar_ButtonType;
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

procedure TIB_NavigationBar.AdjSize (var W: Integer; var H: Integer);
var
  Count: Integer;
  MinW: Integer;
  I: TIB_NavigationBar_ButtonType;
  Space, Temp, Remain: Integer;
  X: Integer;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[nbFirst] = nil then Exit;
  Count := 0;
  for I := Low( Buttons ) to High( Buttons ) do
    if Buttons[I].Visible then
      Inc( Count );
  if Count = 0 then Inc( Count );
  MinW := Count * ( MinBtnSize.X - 1 ) + 1;
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
  for I := Low( Buttons ) to High( Buttons ) do
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
      Buttons[I].SetBounds ( X, 0, ButtonWidth + Space, Height );
      Inc (X, ButtonWidth - 1 + Space);
    end
    else
      Buttons[I].SetBounds ( Width + 1, 0, ButtonWidth, Height );
  end;
end;

procedure TIB_NavigationBar.WMSize(var Message: TWMSize);
var
  W, H: Integer;
begin
  inherited;
  { check for minimum size }
  W := Width;
  H := Height;
  AdjSize ( W, H );
  if ( W <> Width ) or ( H <> Height ) then
    inherited SetBounds( Left, Top, W, H );
  Message.Result := 0;
end;

procedure TIB_NavigationBar.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_NavigationBar.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_NavigationBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TIB_NavigationBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then SysStateChanged;
end;

procedure TIB_NavigationBar.SysStateChanged;
begin
  if Enabled and
     DataLink.Prepared and
     (( DataLink.Dataset.StatementType = stSelect ) or
      ( DataLink.Dataset.StatementType = stSelectForUpdate )) and
     DataLink.Dataset.CanScroll then
  begin
    if DataSource.Dataset is TIB_BDataset then
    begin
      with DataSource.Dataset as TIB_BDataset do
      begin
        if BufferHasBof then
        begin
          Buttons[ nbFirst   ].Enabled := RowNum <> BofRowNum + 1;
          Buttons[ nbJumpBck ].Enabled := RowNum  > BofRowNum + 1;
          Buttons[ nbPrior   ].Enabled := RowNum  > BofRowNum + 1;
        end
        else
        begin
          Buttons[ nbFirst   ].Enabled := true;
          Buttons[ nbJumpBck ].Enabled := true;
          Buttons[ nbPrior   ].Enabled := true;
        end;
        if BufferHasEof then
        begin
          Buttons[ nbNext    ].Enabled := RowNum <  EofRowNum - 1;
          Buttons[ nbJumpFwd ].Enabled := RowNum <  EofRowNum - 1;
          Buttons[ nbLast    ].Enabled := RowNum <> EofRowNum - 1;
        end
        else
        begin
          Buttons[ nbNext    ].Enabled := true;
          Buttons[ nbJumpFwd ].Enabled := true;
          Buttons[ nbLast    ].Enabled := true;
        end;
      end;
    end
    else
    with DataSource.Dataset do
    begin
      Buttons[ nbFirst   ].Enabled := CanScroll or
                                      ( Unidirectional and Prepared );
      Buttons[ nbJumpBck ].Enabled := false;
      Buttons[ nbPrior   ].Enabled := false;
      Buttons[ nbNext    ].Enabled := not Eof;
      Buttons[ nbJumpFwd ].Enabled := not Eof;
      Buttons[ nbLast    ].Enabled := not Eof;
    end;
  end
  else
  begin
    Buttons[ nbFirst   ].Enabled := false;
    Buttons[ nbJumpBck ].Enabled := false;
    Buttons[ nbPrior   ].Enabled := false;
    Buttons[ nbNext    ].Enabled := false;
    Buttons[ nbJumpFwd ].Enabled := false;
    Buttons[ nbLast    ].Enabled := false;
  end;
  InitHints;
  if not ( csDestroying in ComponentState ) and
    Assigned( FOnButtonsStateChanged ) then
    FOnButtonsStateChanged( Self );
end;

procedure TIB_NavigationBar.InitHints;
var
  tmpDataset: TIB_Dataset;
  procedure SetHint( AButton: TIB_NavigationBar_ButtonType;
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
  SetHint( nbFirst,   'FIRST',   H_NB_FIRST   );
  SetHint( nbPrior,   'PRIOR',   H_NB_PRIOR   );
  SetHint( nbNext,    'NEXT',    H_NB_NEXT    );
  SetHint( nbLast,    'LAST',    H_NB_LAST    );
  SetHint( nbJumpBck, 'JUMPBCK', H_NB_JUMPBCK );
  SetHint( nbJumpFwd, 'JUMPFWD', H_NB_JUMPFWD );
end;

procedure TIB_NavigationBar.Loaded;
var
  W, H: Integer;
begin
  inherited Loaded;
  W := Width;
  H := Height;
  AdjSize (W, H);
  if (W <> Width) or (H <> Height) then inherited SetBounds (Left, Top, W, H);
  SysStateChanged;
end;

procedure TIB_NavigationBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TIB_NavigationBar_ButtonType;
  OldFocus: TIB_NavigationBar_ButtonType;
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

procedure TIB_NavigationBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  AdjSize (W, H);
  inherited SetBounds (ALeft, ATop, W, H);
end;

procedure TIB_NavigationBar.BtnClick(Index: TIB_NavigationBar_ButtonType);
var
  OldFetchAll: boolean;
begin
  FFocusedButton := Index;
  if Assigned( BeforeAction ) then
    BeforeAction( Self );
  if DataLink.Prepared then
  with DataLink.Dataset do
  begin
    OldFetchAll := AutoFetchAll;
    try
      if Unidirectional then
        AutoFetchAll := false;
      case Index of
        nbFirst: First;
        nbJumpBck:
        begin
          DisableControls;
          try
            if PageRows <> 0 then
              MoveBy( -PageRows )
            else
              MoveBy( -JumpCount );
            if Bof and ( BufferRowCount > 0 ) then
              Next;
          finally
            EnableControls;
          end;
        end;
        nbPrior:
        begin
          if RowNum = BofRowNum + 1 then
          begin
            if not Unidirectional then ValidateRows( BofRowNum, BofRowNum );
          end;
          if Unidirectional or ( RowNum > BofRowNum + 1 ) then
            Prior
          else
            SysStateChanged;
        end;
        nbNext:
        begin
          if RowNum = EofRowNum - 1 then
          begin
            if not Unidirectional then ValidateRows( EofRowNum, EofRowNum );
          end;
          if Unidirectional or ( RowNum < EofRowNum - 1 ) then
            Next
          else
            SysStateChanged;
        end;
        nbJumpFwd:
        begin
          DisableControls;
          try
            if PageRows <> 0 then MoveBy( PageRows )
                             else MoveBy( JumpCount );
            if Eof and ( BufferRowCount > 0 ) then
              Prior;
          finally
            EnableControls;
          end;
        end;
        nbLast: Last;
      end;
    finally
      AutoFetchAll := OldFetchAll;
    end;
  end;
  if not ( csDestroying in ComponentState ) and Assigned( FAfterAction ) then
    FAfterAction( Self );
end;

procedure TIB_NavigationBar.BarClick( Sender: TObject );
begin
  BtnClick (TIB_NavigationBar_Button(Sender).Index);
end;


function TIB_NavigationBar.GetOnReceiveFocus: TIB_DataLinkEvent;
begin
  Result := DataLink.OnReceiveFocus;
end;

procedure TIB_NavigationBar.SetOnReceiveFocus( AValue: TIB_DataLinkEvent );
begin
  DataLink.OnReceiveFocus := AValue;
end;

procedure TIB_NavigationBar.SetCustomGlyphs(Value: TImageList);
begin
  if Assigned( FCustomGlyphs ) then
    FCustomGlyphs.OnChange := nil;
  FCustomGlyphs := Value;
  if Assigned( FCustomGlyphs ) then
    FCustomGlyphs.OnChange := CustomGlyphsChange;
  LoadCustomGlyphs;
end;

procedure TIB_NavigationBar.CustomGlyphsChange(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then LoadCustomGlyphs;
end;

procedure TIB_NavigationBar.SetCustomGlyphsSupplied(Value: TIB_NavBar_BtnSet);
begin
  FCustomGlyphsSupplied := Value;
  LoadCustomGlyphs;
end;

{------------------------------------------------------------------------------}

destructor TIB_NavigationBar_Button.Destroy;
begin
  if Assigned( FRepeatTimer ) then
  begin
    FRepeatTimer.Free;
    FRepeatTimer := nil;
  end;
  inherited Destroy;
end;

procedure TIB_NavigationBar_Button.Paint;
var
  R: TRect;
begin
  inherited Paint;
  if (GetFocus = Parent.Handle) and
     (FIndex = TIB_NavigationBar(Parent).FocusedButton) then
  begin
    R := Bounds(0, 0, Width, Height);
    InflateRect(R, -3, -3);
    if FState = bsDown then
      OffsetRect(R, 1, 1);
    DrawFocusRect(Canvas.Handle, R);
  end;
end;

procedure TIB_NavigationBar_Button.MouseDown( Button: TMouseButton;
                                              Shift: TShiftState;
                                              X, Y: Integer);
begin
  if TimerInterval > 0 then
  begin
    if FRepeatTimer = nil then
      FRepeatTimer := TTimer.Create(Self);
    FRepeatTimer.OnTimer := TimerExpired;
    FRepeatTimer.Interval := 400;
    FRepeatTimer.Enabled  := True;
    TIB_NavigationBar(Parent).DataLink.LockSessionCursor;
  end;
  inherited MouseDown( Button, Shift, X, Y );
end;

procedure TIB_NavigationBar_Button.MouseUp( Button: TMouseButton;
                                            Shift: TShiftState;
                                            X, Y: Integer);
begin
  inherited MouseUp( Button, Shift, X, Y );
  if Assigned( FRepeatTimer ) then begin
    FRepeatTimer.Enabled := False;
    TIB_NavigationBar(Parent).DataLink.UnlockSessionCursor;
  end;
end;

procedure TIB_NavigationBar_Button.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := TimerInterval;
  if (FState = bsDown) and MouseCapture then
  begin
    try
      Click;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
  end;
end;

procedure TIB_NavigationBar.LoadCustomGlyphs;
var
  j: Integer;
  i: TIB_NavigationBar_ButtonType;
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
      Glyph.Free;
      inc(j);
    end
    else
    begin
      Buttons[i].NumGlyphs := 2;
      with Buttons[i].Glyph do
        case I of
          nbFirst: Assign( StandardBitmap( 'NAV_BAR_FIRST' ));
          nbJumpBck: Assign( StandardBitmap( 'NAV_BAR_JUMP_BACK' ));
          nbPrior: Assign( StandardBitmap( 'NAV_BAR_PRIOR' ));
          nbNext: Assign( StandardBitmap( 'NAV_BAR_NEXT' ));
          nbJumpFwd: Assign( StandardBitmap( 'NAV_BAR_JUMP_FRWD' ));
          nbLast: Assign( StandardBitmap( 'NAV_BAR_LAST' ));
        end;
    end;
  end;
end;

initialization
  NB_Images := TIB_StringList.Create;
  NB_Images.Sorted := true;
  FilImages;

finalization
  while NB_Images.count > 0 do
  begin
    TBitmap( NB_Images.Objects[0] ).Free;
    NB_Images.Delete( 0 );
  end;
  NB_Images.Free;

end.

