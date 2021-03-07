
{                                                                              }
{ IBC_CustomLabel.pas - Enhanced Label component.                              }
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
{  Original Author: Geoff Worboys                                              }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: Based on an earlier TLabelEnh component this source has been donated to the
IBObjects library as a base for the AutoLabel capability.  This particular
unit has been isolated to allow the enhanced capability to be used independant
of IBO (does not include any other IBO units).
<br><br>
By default this unit does not include the published non-IBO-aware variation
TLabelEnh, to avoid conflict with those still using the original unit.
Note that the original TLabelEnh unit was IBO-aware, the equivalent level
of support can now be found in in TIB_Label, defined in IB_Label.pas.
<br><br>
To make the published non-IBO-aware variation available for registration
define USELABELENH in the package project defines.
<br><br>
Trying to instigate support for several variations of label layout with
minimal overhead in terms of properties.
<br><br>
So, given Suffix=':' the following options exist...
<br><br>
if DotLeader and not (AutoSize or WordWrap or Alignment=taCenter) then...
<br><br>
<br>  Justify   SuffixBeforeDots  RESULT
<br>  Left      false             "Label. . . :"
<br>  Left      true              "Label:. . . "
<br>  Right     false             ":. . . Label"
<br>  Right     true              ". . . :Label"
<br>
<br>otherwise...
<br>
<br>  SuffixBeforeDots    RESULT
<br>  false               "Label:"
<br>  true                ":Label"
<br>}
unit
  IBC_CustomLabel;

{$INCLUDE IB_Directives.inc}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
interface

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  StdCtrls;


//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
type

TIB_CharCase = (
    ccNormal,          // no special character case processing
    ccUpperCase,       // all characters to upper case
    ccLowerCase,       // all characters to lower case
    ccProperCase       // words are "Proper Cased"
    );


TIB_GetLabelEvent = procedure( Sender: TObject; var AText: string;
  const AFont: TFont ) of object;

//---------------------------------------------------------------------------
TIB_CustomLabel = class(TCustomLabel)
private
  FDotLeader: boolean;
  FSuffix: string;
  FSuffixBeforeDots: boolean;
  FOnGetLabel: TIB_GetLabelEvent;
  FCharCase: TIB_CharCase;

  procedure SetCharCase( AValue: TIB_CharCase );
  procedure SetDotLeader( AValue: boolean );
  procedure SetSuffix( AValue: string );
  procedure SetSuffixBeforeDots( AValue: boolean );
  function GetFocusControl: TWinControl;
  procedure SetFocusControl( AControl: TWinControl );
  // Property setters to support DoModelPropertyChange calls
  function GetTransparent: Boolean;
  procedure SetTransparent(Value: Boolean);
  function GetAlignment: TAlignment;
  procedure SetAlignment(Value: TAlignment);
  function GetShowAccelChar: Boolean;
  procedure SetShowAccelChar(Value: Boolean);
  function GetLayout: TTextLayout;
  procedure SetLayout(Value: TTextLayout);
  function GetWordWrap: Boolean;
  procedure SetWordWrap(Value: Boolean);
  function GetCaption: string;
  procedure SetCaption(Value: string);
  function GetPopupMenuEx: TPopupMenu; // dont hide dynamic function
  procedure SetPopupMenu(Value: TPopupMenu);

  procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
  procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  procedure CMShowHintChanged(var Message: TMessage); message CM_SHOWHINTCHANGED;
  procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;

protected
  procedure SetAutoSize(Value: Boolean); override;
  {$IFDEF IBO_VCL40_OR_GREATER}
  procedure SetBiDiMode(Value: TBiDiMode); override;
  {$ENDIF}

  procedure DoGetLabel( var AText: string; const AFont: TFont ); virtual;
  procedure DoModelPropertyChange; virtual;
  procedure Click; override;
{$IFDEF IBO_VCL40_OR_GREATER}
  procedure DoDrawText(var Rect: TRect; Flags: longint); override;
{$ELSE}
  procedure DoDrawText(var Rect: TRect; Flags: Word);
  procedure AdjustBounds;   // Warning: hack by Claudio Valderrama for D3
  procedure Paint; override;  // another D3 hack
{$ENDIF}

public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;

  // We make a few properties public so that it is easier to use
  // instances of this class as a generic base...
  property CharCase: TIB_CharCase read FCharCase write SetCharCase default ccNormal;
  property DotLeader: boolean read FDotLeader write SetDotLeader default false;
  property Suffix: string read FSuffix write SetSuffix;
  property SuffixBeforeDots: boolean read FSuffixBeforeDots write SetSuffixBeforeDots default false;
  property OnGetLabel: TIB_GetLabelEvent read FOnGetLabel write FOnGetLabel;

  // Property overrides to support DoModelPropertyChange
  // From TLabel
  property AutoSize;
  property Alignment: TAlignment read GetAlignment write SetAlignment;
  property FocusControl: TWinControl read GetFocusControl write SetFocusControl;
  property ShowAccelChar: Boolean read GetShowAccelChar write SetShowAccelChar;
  property Transparent: Boolean read GetTransparent write SetTransparent;
  property Layout: TTextLayout read GetLayout write SetLayout;
  property WordWrap: Boolean read GetWordWrap write SetWordWrap;

  // From TControl
  property Caption: string read GetCaption write SetCaption;
  property Color;    // update caught via CM_COLORCHANGED
  property Font;     // update caught via CM_FONTCHANGED
  property PopupMenu: TPopupMenu read GetPopupMenuEx write SetPopupMenu;
  property ShowHint; // update caught via CM_SHOWHINTCHANGED

  {$IFDEF IBO_VCL40_OR_GREATER}
  property BiDiMode;
  {$ENDIF}

end; // TIB_CustomLabel

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
{$IFDEF USELABELENH}
TLabelEnh = class(TIB_CustomLabel)
{$INCLUDE IBC_CustomLabel.pbl}
end; // TLabelEnh
{$ENDIF}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
implementation

uses
  IB_Utils;
  
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
constructor TIB_CustomLabel.Create( AOwner: TComponent );
begin
inherited Create(AOwner);
FDotLeader := false;
FSuffix := '';
FSuffixBeforeDots := false;
FCharCase := ccNormal;
FOnGetLabel := nil;
end;
//---------------------------------------------------------------------------
destructor TIB_CustomLabel.Destroy;
begin
inherited Destroy;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetCharCase( AValue: TIB_CharCase );
begin
if AValue <> FCharCase then begin
  FCharCase := AValue;
  if AutoSize then
    AdjustBounds;
  Invalidate;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetDotLeader( AValue: boolean );
begin
if AValue <> FDotLeader then begin
  FDotLeader := AValue;
  if AutoSize then
    AdjustBounds;
  Invalidate;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetSuffix( AValue: string );
begin
if AValue <> FSuffix then begin
  FSuffix := AValue;
  if AutoSize then
    AdjustBounds;
  Invalidate;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetSuffixBeforeDots( AValue: boolean );
begin
if AValue <> FSuffixBeforeDots then begin
  FSuffixBeforeDots := AValue;
  if AutoSize then
    AdjustBounds;
  Invalidate;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
function TIB_CustomLabel.GetFocusControl: TWinControl;
begin
Result := inherited FocusControl;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetFocusControl( AControl: TWinControl );
begin
if AControl <> inherited FocusControl then begin
  inherited FocusControl := AControl;
  if AutoSize then
    AdjustBounds;
  Invalidate;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
function TIB_CustomLabel.GetTransparent: Boolean;
begin
Result := inherited Transparent;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetTransparent(Value: Boolean);
begin
if Value <> inherited Transparent then begin
  inherited Transparent := Value;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
function TIB_CustomLabel.GetAlignment: TAlignment;
begin
Result := inherited Alignment;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetAlignment(Value: TAlignment);
begin
if Value <> inherited Alignment then begin
  inherited Alignment := Value;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
function TIB_CustomLabel.GetShowAccelChar: Boolean;
begin
Result := inherited ShowAccelChar;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetShowAccelChar(Value: Boolean);
begin
if Value <> inherited ShowAccelChar then begin
  inherited ShowAccelChar := Value;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
function TIB_CustomLabel.GetLayout: TTextLayout;
begin
Result := inherited Layout;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetLayout(Value: TTextLayout);
begin
if Value <> inherited Layout then begin
  inherited Layout := Value;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
function TIB_CustomLabel.GetWordWrap: Boolean;
begin
Result := inherited WordWrap;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetWordWrap(Value: Boolean);
begin
if Value <> inherited WordWrap then begin
  inherited WordWrap := Value;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
function TIB_CustomLabel.GetCaption: string;
begin
Result := inherited Caption;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetCaption(Value: string);
begin
if Value <> inherited Caption then begin
  inherited Caption := Value;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
function TIB_CustomLabel.GetPopupMenuEx: TPopupMenu;
begin
Result := inherited PopupMenu;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetPopupMenu(Value: TPopupMenu);
begin
if Value <> inherited PopupMenu then begin
  inherited PopupMenu := Value;
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.CMColorChanged(var Message: TMessage);
begin
inherited;
DoModelPropertyChange;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.CMFontChanged(var Message: TMessage);
begin
inherited;
DoModelPropertyChange;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.CMShowHintChanged(var Message: TMessage);
begin
inherited;
DoModelPropertyChange;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
inherited;
DoModelPropertyChange;
end;
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.SetAutoSize(Value: Boolean);
begin
if Value <> inherited AutoSize then begin
  inherited SetAutoSize( Value );
  DoModelPropertyChange;
  end;
end;
//---------------------------------------------------------------------------
{$IFDEF IBO_VCL40_OR_GREATER}
procedure TIB_CustomLabel.SetBiDiMode(Value: TBiDiMode);
begin
if Value <> inherited BiDiMode then begin
  inherited SetBiDiMode( Value );
  DoModelPropertyChange;
  end;
end;
{$ENDIF}
//---------------------------------------------------------------------------
procedure TIB_CustomLabel.DoGetLabel( var AText: string; const AFont: TFont );
begin
if Assigned( FOnGetLabel ) then
  OnGetLabel( Self, AText, AFont );
end;
//---------------------------------------------------------------------------
// Provided primarily for TIB_Label support - which can be used as a "Model"
// for the AutoLabel feature in IBO controls.  The setter function for each
// property that can be used as part of the model should call this procedure.
procedure TIB_CustomLabel.DoModelPropertyChange;
begin
// Do nothing - will be overridden in TIB_Label.
end;
//---------------------------------------------------------------------------
// More often than not I do not bother with label accellerator keys,
// but since I am using FocusControl I will use the click event to set
// focus to the associated control.
procedure TIB_CustomLabel.Click;
begin
if assigned( OnClick ) then
  inherited
else begin
  if (FocusControl <> nil) and FocusControl.CanFocus then begin
    FocusControl.SetFocus;
    end;
  end;
end;
//---------------------------------------------------------------------------
{$IFDEF IBO_VCL40_OR_GREATER}
procedure TIB_CustomLabel.DoDrawText(var Rect: TRect; Flags: longint);
{$ELSE}
procedure TIB_CustomLabel.DoDrawText(var Rect: TRect; Flags: Word);
{$ENDIF}
var
  Text, tmpStr, tmpStr2: string;
  tmpFlags: longint;
  i, j: integer;
begin
Text := GetLabelText;
Canvas.Font := Font;
DoGetLabel( Text, Canvas.Font );
case CharCase of
  ccUpperCase:  Text := AnsiUpperCase( Text );
  ccLowerCase:  Text := AnsiLowerCase( Text );
  ccProperCase:
  begin
    tmpStr := AnsiLowerCase( Text );
    if Length( tmpStr ) > 0 then
    begin
      Text := AnsiUpperCase(tmpStr[1]);
      for i := 2 to Length( tmpStr ) do
        Text := Text + ConvCharCase( tmpStr[i-1],
                                     tmpStr[i],
                                     Ord( CharCase ));
      end;
    end;
  end;
// Special processing for AccelChar
if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
  (Text[1] = '&') and (Text[2] = #0)) then
  Text := Text + ' ';
if not ShowAccelChar then
  Flags := Flags or DT_NOPREFIX;
{$IFDEF IBO_VCL40_OR_GREATER}
Flags := DrawTextBiDiModeFlags(Flags);
{$ENDIF}
// DotLeader is not possible with AutoSize or WordWrap or taCenter
if DotLeader and not(AutoSize or Wordwrap or (Alignment = taCenter)) then begin
  // If suffixbeforedots, then append suffix directly to text
  if SuffixBeforeDots then begin
    if Alignment = taRightJustify then
      Text := Suffix + Text
    else Text := Text + Suffix;
    tmpStr := '';
    end
  // others suffix gets incorporated into dot printing
  else tmpStr := Suffix;
  tmpFlags := Flags;
  // Calculate available width beyond given text
  i := (Rect.Right - Rect.Left) - Canvas.TextWidth( Text );
  if i > 0 then begin
    if Length(tmpStr) > 0 then
      i := i - Canvas.TextWidth( tmpStr );
    if Alignment = taLeftJustify then begin
      tmpStr2 := '. ';
      j := Canvas.TextWidth( tmpStr2 );
      while (i - j) > 0 do begin
        i := i - j;
        tmpStr := tmpStr2 + tmpStr;
        end;
      tmpFlags := tmpFlags and not DT_LEFT;
      tmpFlags := tmpFlags or DT_RIGHT;
      end
    else if Alignment = taRightJustify then begin
      tmpStr2 := ' .';
      j := Canvas.TextWidth( tmpStr2 );
      while (i - j) > 0 do begin
        i := i - j;
        tmpStr := tmpStr + tmpStr2;
        end;
      tmpFlags := tmpFlags and not DT_RIGHT;
      tmpFlags := tmpFlags or DT_LEFT;
      end;
    if not Enabled then begin
      OffsetRect(Rect, 1, 1);
      Canvas.Font.Color := clBtnHighlight;
      DrawText(Canvas.Handle, PChar(tmpStr), Length(tmpStr), Rect, tmpFlags);
      OffsetRect(Rect, -1, -1);
      Canvas.Font.Color := clBtnShadow;
      DrawText(Canvas.Handle, PChar(tmpStr), Length(tmpStr), Rect, tmpFlags);
      end
    else begin
      DrawText(Canvas.Handle, PChar(tmpStr), Length(tmpStr), Rect, tmpFlags);
      end;
    end;
  end
else begin
  // If no DotLeader then use SuffixBeforeDots as Reverse placement indicator
  if SuffixBeforeDots then
    Text := Suffix + Text
  else Text := Text + Suffix;
  end;
if (csDesigning in ComponentState) and
  (Text = '') and (not DotLeader) then begin
  Text := Name;
  if Text = '' then
    Text := '(Label)';
  end;
//inherited;
if not Enabled then begin
  OffsetRect(Rect, 1, 1);
  Canvas.Font.Color := clBtnHighlight;
  DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  OffsetRect(Rect, -1, -1);
  Canvas.Font.Color := clBtnShadow;
  DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  end
else begin
  DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  end;
end;
//---------------------------------------------------------------------------
{$IFNDEF IBO_VCL40_OR_GREATER}
procedure TIB_CustomLabel.AdjustBounds;
// Warning: hack by Claudio Valderrama for D3
begin
    Self.Perform(CM_TEXTCHANGED, 0, 0)
end;

procedure TIB_CustomLabel.Paint;
// Another D3 hack to call our new DoDrawText function
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Rect, CalcRect: TRect;
  DrawStyle: Integer;
begin
  with Canvas do
  begin
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(ClientRect);
    end;
    Brush.Style := bsClear;
    Rect := ClientRect;
    DrawStyle := DT_EXPANDTABS or WordWraps[WordWrap] or Alignments[Alignment];
    { Calculate vertical layout }
    if Layout <> tlTop then
    begin
      CalcRect := Rect;
      DoDrawText(CalcRect, DrawStyle or DT_CALCRECT);
      if Layout = tlBottom then OffsetRect(Rect, 0, Height - CalcRect.Bottom)
      else OffsetRect(Rect, 0, (Height - CalcRect.Bottom) div 2);
    end;
    DoDrawText(Rect, DrawStyle);
  end;
end;
{$ENDIF}
//---------------------------------------------------------------------------
end.
