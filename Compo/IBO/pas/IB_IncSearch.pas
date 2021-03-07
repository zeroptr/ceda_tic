
{                                                                              }
{ IB_IncSearch                                                                 }
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

{: This unit contains the IB_IncSearch control.}
unit
  IB_IncSearch;

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Forms, Graphics, Menus,
  StdCtrls, ExtCtrls, ComCtrls, Mask, Buttons, Dialogs, Clipbrd,

  IB_Constants,
{$IFDEF IBO4_BETA}
  IB_FieldDataLink,
{$ENDIF}
  IB_Components;

type
{: This control is used in order to provide incremental searching for a
buffered dataset. This means all descendant components of TIB_BDataset. This
includes the TIB_Query component.
<br><br>
Please refer to the documentation of the TIB_BDataset class for more
information about how it is designed to perform incremental searching. It
has additional properties and methods that will have an effect upon how this
control behaves.
<br><br>
It is also useful to know that incremental searching is dependant upon which
OrderingLink, if any, is active. The OrderingItems and OrderingLinks
properties must be defined for searching to be performed.
<br><br>
When there is a valid OrderingLink this control will turn colors to the
session's SearchingColor (cyan by default) or ReadOnlyColor (gray by default)
when there is no active OrderingLink in affect.
<br><br>
This corresponds nicely with the IB_Grid's feature of being able to click on
the column header because this guarantees that the IB_IncSearch will be able
to perform the search since it depends on the OrderingLink being active.
<br><br>
Keep in mind that as you move from one OrderingLink to another any pending
incremental search criteria is not automatically cleared out. Thus, it is
possible to mix criteria from multiple OrderingLink enabled columns.
<br><br>
OrderingItems, OrderingLinks, OrderingLink, etc. are all documented in the
IB_Dataset class. Please refer to it for more help.
<br><br>
This control works for text, numeric and date based columns only. With
non-text columns ENTER must be pressed in order to initiate the
search process. dssSearch mode systax is used to refine with. Pressing
ENTER when there is not any criteria will clear it out and return all records.
<br><br>
With text based columns there are two possible modes. The first is like above
where ENTER must be pressed in order to activate the search. The other allows
searching to become activated for each individual key press. It is possible
to have this KeyByKey searching wait until an nth character is pressed. This
is controlled by the dataset's OrderingRefinePos property.
<br><br>
If the item to be searched for is fewer characters than the
OrderingRefinePos is press ENTER to override this and initiate the search.
<br><br>
This control is case sensitive by default.
<br><br>
This control also responds to the case insensitivity ColumnAttribute when it
is defined for the column that is currently the active OrderingLink. See the
help on the NOCASE attribute of the ColumnAttribute property defined in the
TIB_Statement class.}
TIB_IncSearch = class(TCustomEdit)
{$INCLUDE IB_InterfaceDataLink.INT}
private
  FSearchKeyByKey: boolean;
  FSearchingLevel: integer;
  FSeekNearest: boolean;
  FAllowTimeout: boolean;
  FClearOnExit: boolean;
  FOrderingLink: string;
  function GetIgnoreColorScheme: boolean;
  procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
  procedure CMExit(var Message: TCMExit); message CM_EXIT;
  procedure SetIgnoreColorScheme( AValue: boolean );
  procedure SetOrderingLink( AValue: string );
  procedure SetClearOnExit( AValue: Boolean );
protected
  procedure Loaded; override;
  procedure KeyDown( var Key: Word; Shift: TShiftState ); override;
  procedure KeyUp( var Key: Word; Shift: TShiftState ); override;
  procedure KeyPress(var Key: char); override;
  procedure CheckOrderingLink;
{$IFNDEF HELPSCAN}
public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
{$ENDIF}
published
{: This property determins if the incremental search string will be clear
when exiting of the control and remain clear until reentered again.}
  property ClearOnExit: boolean read FClearOnExit
                                write SetClearOnExit
                                default true;

{: This property determins if the incremental search string will time out
after a certain period of time defined by the dataset.}
  property AllowTimeout: boolean read FAllowTimeout
                                 write FAllowTimeout
                                 default false;
{: This property allows you to take explicit control over the coloring of this
control without default interferance.}
  property IgnoreColorScheme: boolean read GetIgnoreColorScheme
                                      write SetIgnoreColorScheme
                                      default false;
{: This property causes the dataset to be ordered by a certain column when
it receives focus.
<br><br>
If left blank then it will operate on whatever OrderingLink is currently
active for the dataset.}
  property OrderingLink: string read FOrderingLink write SetOrderingLink;
{: When searching is being performed against a text based column it is
possible to have the search begin operating a character at a time as they are
pressed.
<br><br>
Using the callback mechanism of IB Objects, each character that is typed can
be received during the searching process. Thus, the searching process can be
refined even while in the middle of a search from previous characters.
<br><br>
Otherwise, ENTER must be pressed in order to initiate the search process.}
  property SearchKeyByKey: boolean read FSearchKeyByKey
                                   write FSearchKeyByKey
                                   default false;
{: Determins if the nearest record should be selected as the current record
or not. Even if this is false the IB_Grid is designed to show the nearest
matching record without actually selecting it.}
  property SeekNearest: boolean read FSeekNearest
                                write FSeekNearest
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

uses
  IB_Parse;

constructor TIB_IncSearch.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  FIB_DataLink := TIB_InterfaceDataLink.Create( Self );
  FIB_DataLink.Control := Self;
  FIB_DataLink.OnStateChanged := IB_DatasetStateChanged;
  FIB_DataLink.AfterAssignment := IB_DatasetStateChanged;
  FClearOnExit := true
end;

destructor TIB_IncSearch.Destroy;
begin
  FIB_DataLink.OnStateChanged := nil;
  FIB_DataLink.AfterAssignment := nil;
  inherited Destroy;
end;

procedure TIB_IncSearch.Loaded;
begin
  inherited Loaded;
  IB_DatasetStateChanged( nil, nil );
end;

procedure TIB_IncSearch.IB_DatasetStateChanged( Sender: TIB_DataLink;
                                                DataSource: TIB_DataSource);
begin
  if DataLink.Prepared and Assigned( DataLink.Dataset.OrderingField ) then
  begin
    if DataLink.ColorScheme then
      Self.Color := DataLink.IB_Session.SearchingColor;
    if ( FSearchingLevel = 0 ) then
    begin
      if ( DataLink.Dataset is TIB_BDataset ) then
      begin
        with DataLink.Dataset as TIB_BDataset do
        begin
          if Focused then
          begin
            Self.Text := OrderingRefineStr;
            Self.SelectAll;
          end;
        end;
      end;
    end;
  end
  else
  begin
    if DataLink.ColorScheme then
      Self.Color := DataLink.IB_Session.ReadOnlyColor;
    Self.Text := '';
  end;
end;

procedure TIB_IncSearch.IB_DatasetDataChange( Sender: TIB_DataLink;
                                              DataSource: TIB_DataSource;
                                              IB_Field: TIB_Column );
begin
// Do nothing here.
end;

function TIB_IncSearch.GetDataSource: TIB_DataSource;
begin
  Result := DataLink.DataSource;
end;

procedure TIB_IncSearch.SetDataSource(AValue: TIB_DataSource);
begin
  DataLink.DataSource := AValue;
end;

procedure TIB_IncSearch.SetClearOnExit( AValue: boolean );
begin
  FClearOnExit := AValue;
  if AValue and not Focused and ( Text <> '' ) then
  begin
    Text := '';
     if Assigned( DataSource ) and
        ( DataSource.Dataset is TIB_BDataset ) then
       ( DataSource.Dataset as TIB_BDataset ).ClearIncSearchString;
  end;
end;

function TIB_IncSearch.GetReceiveFocus: boolean;
begin
  Result := FIB_DataLink.ReceiveFocus;
end;

procedure TIB_IncSearch.SetReceiveFocus( AValue: boolean );
begin
  DataLink.ReceiveFocus := AValue;
end;

function TIB_IncSearch.GetOnReceiveFocus: TIB_DataLinkEvent;
begin
  Result := DataLink.OnReceiveFocus;
end;

procedure TIB_IncSearch.SetOnReceiveFocus( AValue: TIB_DataLinkEvent );
begin
  DataLink.OnReceiveFocus := AValue;
end;

function TIB_IncSearch.GetIgnoreColorScheme: boolean;
begin
  Result := Datalink.IgnoreColorScheme;
end;

procedure TIB_IncSearch.SetIgnoreColorScheme( AValue: boolean );
begin
  Datalink.IgnoreColorScheme := AValue;
end;

procedure TIB_IncSearch.SetOrderingLink( AValue: string );
begin
  if OrderingLink <> AValue then
  begin
    FOrderingLink := AValue;
    if Focused then
      CheckOrderingLink;
  end;
end;

procedure TIB_IncSearch.CheckOrderingLink;
begin
  with DataLink do
  begin
    if ( OrderingLink <> '' ) and Assigned( Dataset ) then
      DataSource.Dataset.OrderingLink := OrderingLink;
  end;
end;

procedure TIB_IncSearch.CMEnter(var Message: TCMEnter);
begin
  DataLink.SetFocus;
  CheckOrderingLink;
  inherited;
end;

procedure TIB_IncSearch.CMExit(var Message: TCMExit);
begin
  inherited;
  if FClearOnExit then
  begin
     Text := '';
     if Assigned( DataSource ) and
        ( DataSource.Dataset is TIB_BDataset ) then
       ( DataSource.Dataset as TIB_BDataset ).ClearIncSearchString;
  end;
end;

procedure TIB_IncSearch.KeyDown( var Key: Word; Shift: TShiftState );
begin

  inherited KeyDown( Key, Shift );

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
end;

procedure TIB_IncSearch.KeyUp( var Key: Word; Shift: TShiftState );
begin
  try
    DataLink.UnlockSessionCursor;
  finally
    inherited KeyUp( Key, Shift );
  end;
end;

procedure TIB_IncSearch.KeyPress(var Key: char);
var
  tmpStr: string;
  tmpLen: integer;
  tmpCmp: integer;
begin
  //inherited KeyPress( Key );  remove
  if Assigned( DataSource ) and
     Assigned( DataSource.Dataset ) and
     ( DataSource.Dataset is TIB_BDataset ) and
     Assigned( DataSource.Dataset.OrderingField ) then
  begin
    with DataSource.Dataset as TIB_BDataset do
    begin
      if Key = #27 then
      begin
        IncSearchKey( Key, SearchKeyByKey, AllowTimeout, SeekNearest );
        Text := '';
        inherited KeyPress( Key ); //add
        Key := #0;
      end
      else
      if Prepared and
         (( Key in [ #8, #13 ] ) or
         OrderingField.IsValidChar( Key )) then
      begin
        if SearchKeyByKey and
           ( OrderingField.IsText or
             ( OrderingField.IsNumeric and
               ( OrderingRefinePos > 0 ))) then
        begin
          Inc( FSearchingLevel );
          try
            IncSearchKey( Key, SearchKeyByKey, AllowTimeout, SeekNearest );
          finally
            Dec( FSearchingLevel );
          end;
          tmpLen := Length( IncSearchKeyString );
          tmpStr := OrderingField.AsString;
          if OrderingField.NoCaseFieldName <> '' then
            tmpCmp := AnsiCompareText( IncSearchKeyString,
                                       Copy( tmpStr, 1, tmpLen ))
          else
            tmpCmp := AnsiCompareStr( IncSearchKeyString,
                                      Copy( tmpStr, 1, tmpLen ));
          if tmpCmp = 0 then
          begin
            Text := tmpStr;
            SelStart := tmpLen;
            SelLength := Length( tmpStr ) - tmpLen + 1;
          end
          else
          begin
            Text := IncSearchKeyString;
            Self.SelectAll;
          end;
          inherited KeyPress( Key );  //add
          Key := #0;
        end
        else
        if Key = #13 then
        begin
          Inc( FSearchingLevel );
          try
            IncSearchString( Text, 1, SeekNearest );
          finally
            Dec( FSearchingLevel );
          end;
          if FSearchingLevel = 0 then
            Self.SelectAll;
          inherited KeyPress( Key ); //add
          Key := #0;
        end;
      end
      else
      begin
        MessageBeep( 0 );
        inherited KeyPress( Key );  //add
        Key := #0;
      end;
    end;
  end
  else
    MessageBeep( 0 );
end;

end.
