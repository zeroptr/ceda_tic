
{                                                                              }
{ IB_ParamEdit                                                                 }
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

unit
  IB_ParamEdit;

{$INCLUDE IB_Directives.inc}

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Forms, Graphics, Menus,
  StdCtrls, ExtCtrls, ComCtrls, Mask, Buttons, Dialogs, Clipbrd,

  IB_Components;

type
TIB_CustomParamEdit = class;

TIB_ParamEditLink = class(TIB_StatementLink)
private
  FIB_ParamEdit: TIB_CustomParamEdit;
protected
  procedure ProcessEvent( AEvent: TIB_StatementEventType;
                          Info: longint ); override;
  procedure SysAfterUpdateDescriptors; override;
end;

TIB_CustomParamEdit = class(TCustomMaskEdit)
private
  FIB_ParamEditLink: TIB_ParamEditLink;
  FParamName: string;
  FParam: TIB_Column;
  FIgnoreDataChange: boolean;
  FAutoUpdate: boolean;
  FParamRefinePos: integer;
  procedure CMExit(var Message: TCMExit); message CM_EXIT;
protected
{ Inherited Methods }
  function EditCanModify: Boolean; override;
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  procedure KeyPress(var Key: Char); override;
  procedure Reset; override;
  procedure Loaded; override;
  procedure Change; override;
{ Property access methods }  
  procedure SetStatement( AValue: TIB_Statement ); virtual;
  function GetStatement: TIB_Statement; virtual;
  procedure SetParamName( AValue: string ); virtual;
  procedure SetOnPrepareSQL( AValue: TIB_StmtLinkEvent); virtual;
  function GetOnPrepareSQL: TIB_StmtLinkEvent; virtual;
  procedure SetParamRefinePos( AValue: integer ); virtual;
{ System methods }
  procedure ProcessEvent( AEvent: TIB_StatementEventType;
                          Info: longint ); virtual;
  procedure SysDataChange; virtual;
  procedure SysStateChanged; virtual;
  procedure SysUpdateData; virtual;
{ Protected properties }
  property IB_ParamEditLink: TIB_ParamEditLink read FIB_ParamEditLink;
  property ParamName: string read FParamName write SetParamName;
  property Statement: TIB_Statement read GetStatement write SetStatement;
  property ParamEditLink: TIB_ParamEditLink read FIB_ParamEditLink;
public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
  property Param: TIB_Column read FParam;
published
  property AutoUpdate: boolean read FAutoUpdate
                               write FAutoUpdate
                               default true;
  property ParamRefinePos: integer read FParamRefinePos
                                   write SetParamRefinePos
                                   default 0;
  property OnPrepareSQL: TIB_StmtLinkEvent read GetOnPrepareSQL
                                           write SetOnPrepareSQL;
end;

TIB_ParamEdit = class( TIB_CustomParamEdit )
published
{ Inherited properties }
  property AutoSelect;
  property AutoSize;
  property BorderStyle;
  property CharCase;
  property Color;
  property Ctl3D;
  property DragCursor;
  property DragMode;
  property Enabled;
  property Font;
  property MaxLength;
  property ParentColor;
  property ParentCtl3D;
  property ParentFont;
  property ParentShowHint;
  property PasswordChar;
  property PopupMenu;
  property ShowHint;
  property TabOrder;
  property TabStop;
  property Visible;
{ New Properties }
  property ParamName;
  property Statement;
{ Inherited Events }
  property OnChange;
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
  property OnStartDrag;
end;

implementation

constructor TIB_CustomParamEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIB_ParamEditLink := TIB_ParamEditLink.Create( Self );
  with FIB_ParamEditLink do begin
    FIB_ParamEdit := Self;
  end;
  FAutoUpdate := true;
end;

destructor TIB_CustomParamEdit.Destroy;
begin
  Statement := nil;
  inherited Destroy;
end;

procedure TIB_CustomParamEdit.Loaded;
begin
  inherited Loaded;
  SysStateChanged;
end;

{------------------------------------------------------------------------------}

procedure TIB_CustomParamEdit.SysStateChanged;
begin
  if IB_ParamEditLink.Prepared then with IB_ParamEditLink.Statement do begin
    FParam := FindParam( ParamName );
  end else begin
    FParam := nil;
  end;
  if Assigned( Param ) then begin
    Color := ParamEditLink.IB_Session.SearchingColor;
  end else if csDesigning in ComponentState then begin
    Color := clWindow;
  end else begin
    Color := ParamEditLink.IB_Session.InvalidColor;
  end;
  SysDataChange;
end;

procedure TIB_CustomParamEdit.SysDataChange;
begin
  if not FIgnoreDataChange then begin
    if Param <> nil then begin
      if Text <> Param.AsString then Text := Param.AsString;
    end else begin
      Text := '';
    end;
  end;
  Modified := false;
end;

procedure TIB_CustomParamEdit.SysUpdateData;
begin
  if Assigned( Param ) then begin
    if Modified then begin
      FIgnoreDataChange := true;
      try
        ValidateEdit;
        Param.AsString := Text;
        Modified := false;
      finally
        FIgnoreDataChange := false;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

function TIB_CustomParamEdit.GetOnPrepareSQL: TIB_StmtLinkEvent;
begin Result := FIB_ParamEditLink.OnPrepareSQL; end;
procedure TIB_CustomParamEdit.SetOnPrepareSQL( AValue: TIB_StmtLinkEvent);
begin FIB_ParamEditLink.OnPrepareSQL := AValue; end;
function TIB_CustomParamEdit.GetStatement: TIB_Statement;
begin Result := FIB_ParamEditLink.Statement; end;
procedure TIB_CustomParamEdit.SetStatement(AValue: TIB_Statement);
begin FIB_ParamEditLink.Statement := AValue; end;
procedure TIB_CustomParamEdit.SetParamRefinePos( AValue: integer );
begin FParamRefinePos := AValue; end;

{------------------------------------------------------------------------------}

procedure TIB_CustomParamEdit.SetParamName( AValue: string );
begin
  if ParamName <> AValue then begin
    FParamName := AValue;
    SysStateChanged; 
  end;
end;

function TIB_CustomParamEdit.EditCanModify: Boolean;
begin
  Result := FIB_ParamEditLink.Prepared and ( Param <> nil );
end;

procedure TIB_CustomParamEdit.Reset;
begin
  SysDataChange;
  SelectAll;
end;

procedure TIB_CustomParamEdit.Change;
begin
  inherited Change;
  if AutoUpdate and (( ParamRefinePos = 0 ) or
                     ( Length( Text ) >= ParamRefinePos )) then begin
    SysUpdateData;
  end;
end;

procedure TIB_CustomParamEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
end;

procedure TIB_CustomParamEdit.KeyPress(var Key: Char);
begin
  case Key of
    #27: begin
      Reset;
      inherited KeyPress(Key);
      Key := #0;
    end;
    #13: begin
      SysUpdateData;
      inherited KeyPress(Key);
      Key := #0;
    end;
  end;
  if Key <> #0 then begin
    inherited KeyPress(Key);
    if (Key in [#32..#255]) and
       (Param <> nil) and
       not Param.IsValidChar(Key) then begin
      MessageBeep(0);
      Key := #0;
    end;
  end;
end;

procedure TIB_CustomParamEdit.CMExit(var Message: TCMExit);
begin
  try
    SysUpdateData;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  CheckCursor;
  DoExit;
end;

procedure TIB_CustomParamEdit.ProcessEvent( AEvent: TIB_StatementEventType;
                                            Info: longint );
begin
  case AEvent of
    setLayoutChanged,
    setAfterAssignment: SysStateChanged;
    setParamsUpdateData: if ( Info = 0 ) or
                            ( FParam = TIB_Column( Info )) then begin
      SysUpdateData;
    end;
    setParamsDataChange: if ( Info = 0 ) or
                            ( FParam = TIB_Column( Info )) then begin
      SysDataChange;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TIB_ParamEditLink.ProcessEvent( AEvent: TIB_StatementEventType;
                                          Info: longint );
begin
  inherited ProcessEvent( AEvent, Info );
  FIB_ParamEdit.ProcessEvent( AEvent, Info );
end;

procedure TIB_ParamEditLink.SysAfterUpdateDescriptors;
begin
  FIB_ParamEdit.SysStateChanged;
end;

end.
