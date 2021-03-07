
{                                                                              }
{  IB_StatementBar                                                             }
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

{: This unit contains the TIB_StatementBar component. }
unit
  IB_StatementBar;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Controls, StdCtrls,
  Forms, Graphics, ExtCtrls, Menus, Buttons, Dialogs,

  IB_Constants,
  IB_Components,
  IB_StatementSource;

type
{: These are the different button types available to this button bar.
<br><br>
sbPrepare prepares the current statement in the SQL property.
sbUnprepare unprepares the current statement in the SQL property.
sbExecute performs the action of the prepared statement on the server.}
TIB_StatementBar_ButtonType = ( sbPrepare,
                                sbUnprepare,
                                sbExecute );
{: Set of button types for this button bar.}                                   
TIB_StatementBar_ButtonSet = set of TIB_StatementBar_ButtonType;

TIB_StatementBar_Button = class;

{: Button bar that gives access and control of statements.}
TIB_StatementBar = class (TCustomPanel)
{$I IB_Bars.INT}
private
  FIB_StatementSource: TIB_StatementSource;
  FVisibleButtons: TIB_StatementBar_ButtonSet;
  FExecuteUnprepared: boolean;
  FFocusedButton: TIB_StatementBar_ButtonType;
  FCustomGlyphsSupplied: TIB_StatementBar_ButtonSet;
  function GetStatement: TIB_Statement;
  procedure SetStatement( AValue: TIB_Statement );
  procedure SetCustomGlyphsSupplied( Value: TIB_StatementBar_ButtonSet );
  procedure SetVisibleButtons( Value: TIB_StatementBar_ButtonSet );
protected
  procedure IB_StatementPreparedChanged( Sender: TIB_StatementLink;
                                         Statement: TIB_Statement);
public
{: Storage array for the different buttons on this button bar. }
  Buttons: array[TIB_StatementBar_ButtonType] of TIB_StatementBar_Button;

  procedure BtnClick(Index: TIB_StatementBar_ButtonType);
{: The currently selected button of the button set.
<br><br>
Use this property in the xxxxAction events to know which button was clicked.}
  property FocusedButton: TIB_StatementBar_ButtonType read FFocusedButton;
published
{: Set this property to indicate which glyphs have been supplied in the
CustomGlyphs property.}
  property CustomGlyphsSupplied: TIB_StatementBar_ButtonSet
      read FCustomGlyphsSupplied
     write SetCustomGlyphsSupplied;
{: Makes the button for Executing enabled even thoug the statement is
not prepared.}
  property ExecuteUnprepared: boolean read FExecuteUnprepared
                                      write FExecuteUnprepared
                                      default true;
{: Reference to the statement actions will be taken on.}
  property Statement: TIB_Statement
      read GetStatement
     write SetStatement;
{: Set which button are visible to the user.}
  property VisibleButtons: TIB_StatementBar_ButtonSet
      read FVisibleButtons
     write SetVisibleButtons
   default [sbPrepare, sbUnprepare, sbExecute];
end;

TIB_StatementBar_Button = class(TSpeedButton)
private
  FIndex: TIB_StatementBar_ButtonType;
protected
  procedure Paint; override;
public
  property Index: TIB_StatementBar_ButtonType read FIndex write FIndex;
end;

implementation

{$R IB_StatementBar.RES}

constructor TIB_StatementBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque];
  if not NewStyleControls then ControlStyle := ControlStyle + [csFramed];
  FIB_StatementSource := TIB_StatementSource.Create( Self );
  with FIB_StatementSource do begin
    OnPreparedChanged := IB_StatementPreparedChanged;
  end;
  FVisibleButtons := [sbPrepare, sbUnprepare, sbExecute];
  InitButtons;
  BevelOuter := bvNone;
  BevelInner := bvNone;
  Ctl3D := false;
  ParentCtl3D := false;
  Width := 121;
  Height := 25;
  ButtonWidth := 0;
  FFocusedButton := sbPrepare;
  FExecuteUnprepared := true;
{$IFDEF IBO_VCL30_OR_GREATER}
  Flat := true; // Hit the property.
{$ENDIF}
end;

destructor TIB_StatementBar.Destroy;
begin
  if FCustomGlyphs <> nil then begin
    FCustomGlyphs.OnChange := nil;
  end;
  with FIB_StatementSource do begin
    OnPreparedChanged := nil;
  end;
  inherited Destroy;
end;

procedure TIB_StatementBar.Notification( AComponent: TComponent;
                                         Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( CustomGlyphs <> nil ) and
     ( AComponent = CustomGlyphs ) then
    CustomGlyphs := nil;
end;

procedure TIB_StatementBar.IB_StatementPreparedChanged(
                                                      Sender: TIB_StatementLink;
                                                     Statement: TIB_Statement );
begin
  SysStateChanged;
end;

function TIB_StatementBar.GetStatement: TIB_Statement;
begin
  if FIB_StatementSource <> nil then begin
    Result := FIB_StatementSource.Statement;
  end else begin
    Result := nil;
  end;
end;

{$IFDEF IBO_VCL30_OR_GREATER}
procedure TIB_StatementBar.SetFlat( AValue: boolean );
begin
  if Flat <> AValue then begin
    FFlat := AValue;
    Buttons[ sbPrepare    ].Flat := Flat;
    Buttons[ sbUnprepare  ].Flat := Flat;
    Buttons[ sbExecute    ].Flat := Flat;
  end;
end;
{$ENDIF}

procedure TIB_StatementBar.SetStatement(AValue: TIB_Statement);
begin
  if FIB_StatementSource <> nil then begin
    if FIB_StatementSource.Statement <> AValue then begin
      FIB_StatementSource.Statement := AValue;
      SysStateChanged;
    end;  
  end;
end;

procedure TIB_StatementBar.InitButtons;
var
  I: TIB_StatementBar_ButtonType;
  Btn: TIB_StatementBar_Button;
  X: Integer;
begin
  MinBtnSize := Point(20, 18);
  X := 0;
  for I := Low(Buttons) to High(Buttons) do
  begin
    Btn := TIB_StatementBar_Button.Create (Self);
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
  InitHints;
  LoadCustomGlyphs;
end;

procedure TIB_StatementBar.InitHints;
var
  I: TIB_StatementBar_ButtonType;
  Btn: TIB_StatementBar_Button;
begin
  for I := Low(Buttons) to High(Buttons) do
  begin
    Btn := Buttons[ I ];
    case I of
      sbPrepare: Btn.Hint := H_ST_Prepare_Statement;
      sbUnprepare: Btn.Hint := H_ST_Unprepare_Statement;
      sbExecute: Btn.Hint := H_ST_Execute_Statement;
    end;
  end;
end;

procedure TIB_StatementBar.BtnMouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TIB_StatementBar_ButtonType;
begin
  OldFocus := FocusedButton;
  FFocusedButton := TIB_StatementBar_Button(Sender).Index;
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

procedure TIB_StatementBar.SetVisibleButtons(Value: TIB_StatementBar_ButtonSet);
var
  I: TIB_StatementBar_ButtonType;
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


procedure TIB_StatementBar.AdjSize (var W: Integer; var H: Integer);
var
  Count: Integer;
  MinW: Integer;
  I: TIB_StatementBar_ButtonType;
  Space, Temp, Remain: Integer;
  X: Integer;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[sbPrepare] = nil then Exit;

  Count := 0;
  for I := Low(Buttons) to High(Buttons) do begin
    if Buttons[I].Visible then begin
      Inc(Count);
    end;
  end;
  if Count = 0 then Inc(Count);

  MinW := Count * (MinBtnSize.X - 1) + 1;
  if W < MinW then W := MinW;
  if H < MinBtnSize.Y then H := MinBtnSize.Y;

  ButtonWidth := ((W - 1) div Count) + 1;
  Temp := Count * (ButtonWidth - 1) + 1;
  if Align = alNone then W := Temp;

  X := 0;
  Remain := W - Temp;
  Temp := Count div 2;
  for I := Low(Buttons) to High(Buttons) do begin
    if Buttons[I].Visible then begin
      Space := 0;
      if Remain <> 0 then begin
        Dec (Temp, Remain);
        if Temp < 0 then begin
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

procedure TIB_StatementBar.WMSize(var Message: TWMSize);
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

procedure TIB_StatementBar.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_StatementBar.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TIB_StatementBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TIB_StatementBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    SysStateChanged;
end;

procedure TIB_StatementBar.SysStateChanged;
begin
  if Assigned( Statement ) and Enabled then begin
    Buttons[ sbPrepare    ].Enabled := not Statement.Prepared;
    Buttons[ sbUnprepare  ].Enabled :=     Statement.Prepared;
    Buttons[ sbExecute    ].Enabled :=     Statement.Prepared or
                                           ExecuteUnprepared;
  end else begin
    Buttons[ sbPrepare    ].Enabled := false;
    Buttons[ sbUnprepare  ].Enabled := false;
    Buttons[ sbExecute    ].Enabled := false;
  end;
  InitHints;
  {added by Jaroslaw Gilewski}
  if not ( csDestroying in ComponentState ) and
    Assigned( FOnButtonsStateChanged ) then begin
    FOnButtonsStateChanged( Self );
  end;
end;

procedure TIB_StatementBar.Loaded;
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

procedure TIB_StatementBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TIB_StatementBar_ButtonType;
  OldFocus: TIB_StatementBar_ButtonType;
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
        if NewFocus <> FocusedButton then begin
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
        if NewFocus <> FocusedButton then begin
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

procedure TIB_StatementBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  AdjSize (W, H);
  inherited SetBounds (ALeft, ATop, W, H);
end;

procedure TIB_StatementBar.BtnClick(Index: TIB_StatementBar_ButtonType);
begin
  FFocusedButton := Index;
  if not (csDesigning in ComponentState) and
     Assigned( FBeforeAction ) then begin
    FBeforeAction( Self );
  end;

  if Statement <> nil then
  begin
    with Statement do begin
      case Index of
      sbPrepare:    Prepare;
      sbUnprepare:  Unprepare;
      sbExecute:    Execute;
      end;
    end;
  end;

  if not (csDesigning in ComponentState) and
     Assigned( FAfterAction ) then begin
    FAfterAction( Self );
  end;
end;

procedure TIB_StatementBar.BarClick( Sender: TObject );
begin
  BtnClick (TIB_StatementBar_Button(Sender).Index);
end;

procedure TIB_StatementBar_Button.Paint;
var
  R: TRect;
begin
  inherited Paint;
  if (GetFocus = Parent.Handle) and
     (FIndex = TIB_StatementBar(Parent).FocusedButton) then begin
    R := Bounds(0, 0, Width, Height);
    InflateRect(R, -3, -3);
    if FState = bsDown then
      OffsetRect(R, 1, 1);
    DrawFocusRect(Canvas.Handle, R);
  end;
end;

procedure TIB_StatementBar.SetCustomGlyphs(Value: TImageList);
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

procedure TIB_StatementBar.CustomGlyphsChange(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then LoadCustomGlyphs;
end;

procedure TIB_StatementBar.SetCustomGlyphsSupplied(Value: TIB_StatementBar_ButtonSet);
begin
  FCustomGlyphsSupplied := Value;
  LoadCustomGlyphs;
end;

procedure TIB_StatementBar.LoadCustomGlyphs;
var
  j: Integer;
  i: TIB_StatementBar_ButtonType;
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
      with Buttons[i] do case I of
        sbPrepare:   Glyph.Handle := LoadBitmap(HInstance, 'ST_BAR_PREPARE' );
        sbUnprepare: Glyph.Handle := LoadBitmap(HInstance, 'ST_BAR_UNPREPARE' );
        sbExecute:   Glyph.Handle := LoadBitmap(HInstance, 'ST_BAR_EXECUTE' );
      end;
    end;
  end;
end;

end.
