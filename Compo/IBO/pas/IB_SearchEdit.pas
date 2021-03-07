
{                                                                              }
{ IB_Searchdit                                                                 }
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
{  Christian Gütter <friesenpower@web.de>                                      }
{  09/02/2002                                                                  }
{     Added some code to the KeyDown procedure so that a Search_Edit behaves   }
{     like an Inc_Search when you press one of the following keys:             }
{     VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_HOME, VK_END.                      }
{     Pressing these keys makes the dataset scroll in the appropriate way.     }
{  09/03/2002                                                                  }
{     Added the property IgnoreColorScheme which makes IBO ignore the          }
{     default coloring mechanisms and allows the user explicit control         }
{     over the coloring of the SearchEdit.                                     }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the control for working with the datasets SearchingLinks
feature.}
unit
  IB_SearchEdit;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Forms, Graphics, Menus,
  StdCtrls, ExtCtrls, ComCtrls, Mask, Buttons, Dialogs, Clipbrd,

  IB_Components,
  IB_ParamEdit;

type

{: This control is used in conjunction with the SearchingLinks feature of
IBO datasets. What this does is process data that is used in a user specified
input parameter in order to adjust the records that are fetched from the
server.
<br><br>
Be sure to look into the SearchingLinks property of the dataset.}
TIB_SearchEdit = class(TIB_CustomParamEdit)
private
  FIB_DataLink: TIB_DataLink;
  procedure SetDataSource( AValue: TIB_DataSource );
  function GetDataSource: TIB_DataSource;
  procedure AssignmentChanged( Sender: TIB_DataLink;
                               ADataSource: TIB_DataSource );
  procedure WMSetFocus(var Message: TWMSetFocus); message WM_SetFocus;
protected
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  procedure SysCheckParamName; virtual;
  procedure SysDataChange; override;
  procedure SysUpdateData; override;
  procedure SysStateChanged; override;
  procedure ProcessEvent( AEvent: TIB_StatementEventType;
                          Info: longint ); override;
  procedure Loaded; override;
  property DataLink: TIB_DataLink read FIB_DataLink;
  function GetIgnoreColorScheme: boolean;
  procedure SetIgnoreColorScheme( AValue: boolean );
{$IFNDEF HELPSCAN}
public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
{$ENDIF}
published

{ New Properties }
{: Reference to the dataset for which the searching will be performed.}
  property DataSource: TIB_DataSource read GetDataSource write SetDataSource;
{: This property allows you to take explicit control over the coloring of this
control without default interferance.}
  property IgnoreColorScheme: boolean read GetIgnoreColorScheme
                                      write SetIgnoreColorScheme
                                      default false;
{ Inherited Properties }
{$IFNDEF HELPSCAN}
{$IFDEF IBO_VCL40_OR_GREATER}
  property Anchors;
  property BiDiMode;
{$ENDIF}
  property AutoSelect;
  property AutoSize;
  property BorderStyle;
  property CharCase;
  property Color;
{$IFDEF IBO_VCL40_OR_GREATER}
  property Constraints;
{$ENDIF}
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
{ Inherited Events }
  property OnPrepareSQL;
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
{$ENDIF}  
end;

implementation

constructor TIB_SearchEdit.Create(AOwner: TComponent);
begin
  FIB_DataLink := TIB_DataLink.Create( Self );
  inherited Create(AOwner);
  DataLink.AfterAssignment := AssignmentChanged;
end;

destructor TIB_SearchEdit.Destroy;
begin
  DataSource := nil;
  DataLink.AfterAssignment := nil;
  inherited Destroy;
end;

procedure TIB_SearchEdit.Loaded;
begin
  inherited Loaded;
  SysCheckParamName;
end;

procedure TIB_SearchEdit.AssignmentChanged( Sender: TIB_DataLink;
                                            ADataSource: TIB_DataSource );
begin
  if Assigned( DataSource ) then begin
    Statement := DataSource.Dataset;
  end else begin
    Statement := nil;
  end;
end;

function TIB_SearchEdit.GetDataSource: TIB_DataSource;
begin Result := DataLink.DataSource; end;
procedure TIB_SearchEdit.SetDataSource(AValue: TIB_DataSource);
begin DataLink.DataSource := AValue; end;
procedure TIB_SearchEdit.WMSetFocus(var Message: TWMSetFocus);
begin inherited; DataLink.SetFocus; end;

procedure TIB_SearchEdit.ProcessEvent( AEvent: TIB_StatementEventType;
                                       Info: longint );
begin
  if AEvent = setAfterAssignment then
    SysCheckParamName;
  inherited ProcessEvent( AEvent, Info );
  if AEvent = setSearchingLinkChanged then
    SysCheckParamName;
end;

procedure TIB_SearchEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  with DataLink do
  begin
    if Assigned(Dataset) then
    begin
      if DataLink.Prepared then
      with DataLink, Dataset do
      begin
        if Key in [ VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_HOME, VK_END ] then
        begin
          LockSessionCursor;
          DisableControls;
          try
            if not Fetching then
            begin
              case Key of
                VK_UP:
                begin
                  if not Bof then
                  begin
                    Prior;
                    if Bof then
                      Next;
                  end;
                  Key := 0;
                end;
                VK_DOWN:
                begin
                  if not Eof then
                  begin
                    if BufferHasEof and not Unidirectional then
                    begin
                      if RowNum < BufferRowCount then
                        Next;
                    end
                    else
                      Next;
                    if Eof and not Unidirectional then
                      Prior;
                    Key := 0;
                  end;
                end;
                VK_PRIOR:
                begin
                  if not Bof then
                  begin
                    MoveBy( - PageRows );
                    if Bof and not Unidirectional then
                      First;
                    Key := 0;
                  end;
                end;
                VK_NEXT: begin
                  if not Eof then
                  begin
                    MoveBy( PageRows );
                    if Eof and not Unidirectional then
                      Last;
                    Key := 0;
                  end;
                end;
                VK_HOME: begin
                  First;
                  Key := 0;
                end;
                VK_END: begin
                  if not BufferHasEof then
                    UnlockSessionCursor;
                  Last;
                  Key := 0;
                end;
              end;
            end;
          finally
            EnableControls;
          end;
        end;
      end;
      if ( Key = VK_RETURN ) and ( Shift = [] ) then
        Dataset.Open;
    end;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TIB_SearchEdit.SysCheckParamName;
begin
  with DataLink do
  begin
    if Assigned( Dataset ) then
      ParamName := DataLink.Dataset.SearchingParamName
    else
      ParamName := '';
  end;
end;

procedure TIB_SearchEdit.SysDataChange;
begin
  with DataLink do if Active and not Dataset.Refreshing then
    inherited SysDataChange;
end;

procedure TIB_SearchEdit.SysUpdateData;
begin
  if DataLink.Prepared then
  begin
    DataSource.Dataset.DisableControls;
    try
      inherited SysUpdateData;
      Application.ProcessMessages;
    finally
      DataSource.Dataset.EnableControls;
    end;
  end;
end;

function TIB_SearchEdit.GetIgnoreColorScheme: boolean;
begin
  Result := Datalink.IgnoreColorScheme;
end;

procedure TIB_SearchEdit.SetIgnoreColorScheme( AValue: boolean );
begin
  Datalink.IgnoreColorScheme := AValue;
end;

procedure TIB_SearchEdit.SysStateChanged;
begin
  inherited SysStateChanged;
  if Assigned( Param ) then
  begin
    if IgnoreColorScheme then
     Color := clWindow else
      Color := ParamEditLink.IB_Session.SearchingColor;
  end;
end;



end.
