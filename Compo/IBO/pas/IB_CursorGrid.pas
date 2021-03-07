
{                                                                              }
{ IB_CursorGrid                                                                }
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
{ Dirk Schiffler <ds@rcs.de>                                                   }
{ 11/11/2001                                                                   }
{    constant G_DefaultRowHeight for property DefaultRowHeight                 }
{    in the class-definitions for grid                                         }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the TIB_CursorGrid component. }
unit
  IB_CursorGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids,

  IB_Header,
  IB_Components,
  IB_Constants;

type
{: This component acts as a buffer of fetched data.}
TIB_CursorGrid = class(TStringGrid)
private
{ Property Storage }
  FIB_DataLink: TIB_DataLink;
  FFrozen: boolean;
  FNullText: string;
  FrameFlags1, FrameFlags2: DWORD;
  FCtl3DShallow: boolean;
{ Property Access Methods }
  procedure SetDataSource( AValue: TIB_DataSource); virtual;
  function GetDataSource: TIB_DataSource; virtual;
  procedure SetFrozen( AValue: boolean ); virtual;
{ IB_CursorLink methods }
  procedure IB_StateChanged( Sender: TIB_DataLink;
                             DataSource: TIB_DataSource );
  procedure IB_CursorRowDataChange( Sender: TIB_DataLink;
                                    DataSource: TIB_DataSource;
                                    IB_Field: TIB_Column );
  procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
  procedure SetCtl3DShallow( AValue: boolean );

protected

{ Inherited Methods }
  procedure ChangeScale( M, D: integer ); override;
  procedure DrawCell( ACol, ARow: Longint;
                      ARect: TRect;
                      AState: TGridDrawState ); override;
  procedure Loaded; override;
  procedure Paint; override;
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  
{ Utility Methods }
  procedure UpdateGrid;

public

  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
{: This property freezes the grid so that it does not respond to changes in 
the underlying dataset.
<br><br>
This can be useful if the user fetches all the rows and then wants
to be able to double-click on any of the fetched rows and have that row
re-fetched for editing without clearing the previously fetched batch of rows.
<br><br>
This could be accomplished by setting Frozen to true just after the last
row is fetched. Frozen could be set to false just prior to another
request to go to the last record in a selected dataset. This way the grid
would always represent a complete sub-set of data. Then, using this sub-set
the user can select and work with one record at a time by double-clicking
on them in the grid.}
  property Frozen: boolean read FFrozen write SetFrozen;

published

{: This controls the depth of the 3D appearance of the fixed cells.}
  property Ctl3DShallow: boolean read FCtl3DShallow
                                 write SetCtl3DShallow
                                 default false;
{: Reference to the DataSource for the grid.
<br><br>
This should only be used with IB_Cursor derived datasets.}
  property DataSource: TIB_DataSource read GetDataSource write SetDataSource;
{$IFNDEF HELPSCAN}
  property DefaultRowHeight;
{$ENDIF}
{: This is the text that will put in columns that are NULL.}
  property NullText: string read FNullText write FNullText;
end;

implementation

uses
  IB_Utils;

constructor TIB_CursorGrid.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  inherited DefaultRowHeight := G_DefaultRowHeight;
  FIB_DataLink := TIB_DataLink.Create( Self );
  with FIB_DataLink do begin
    OnStateChanged := IB_StateChanged;
    OnDataChange := IB_CursorRowDataChange;
  end;
  Options := Options - [goEditing];
  Options := Options - [goColMoving];
  FixedCols := 0;
  FNullText := '<NULL>';
end;

destructor TIB_CursorGrid.Destroy;
begin
  DataSource := nil;
  with FIB_DataLink do
  begin
    OnStateChanged := nil;
    OnDataChange  := nil;
  end;
  inherited Destroy;
end;

procedure TIB_CursorGrid.Loaded;
begin
  inherited Loaded;
  UpdateGrid;
end;

{------------------------------------------------------------------------------}

function TIB_CursorGrid.GetDataSource: TIB_DataSource;
begin
  Result := FIB_DataLink.DataSource;
end;

procedure TIB_CursorGrid.SetDataSource( AValue: TIB_DataSource );
begin
  if FIB_DataLink.DataSource <> AValue then
  begin
    FIB_DataLink.DataSource := AValue;
    UpdateGrid;
  end;
end;

procedure TIB_CursorGrid.SetFrozen( AValue: boolean );
begin
  if Frozen <> AValue then
  begin
    FFrozen := AValue;
    if Frozen = false then
      UpdateGrid;
  end;
end;

{------------------------------------------------------------------------------}

procedure TIB_CursorGrid.IB_StateChanged( Sender: TIB_DataLink;
                                          DataSource: TIB_DataSource );
begin
  UpdateGrid;
end;

procedure TIB_CursorGrid.IB_CursorRowDataChange( Sender: TIB_DataLink;
                                                 DataSource: TIB_DataSource;
                                                 IB_Field: TIB_Column );
var
  ii: integer;
begin
  if Frozen or ( DataSource = nil ) then Exit;

  with DataSource do begin
    if Dataset <> nil then with Dataset do begin
      if Prepared then begin
        if RowNum = 0 then begin
          Self.RowCount := 1 + FixedRows;
        end else begin
          Self.RowCount := RowNum + FixedRows;
        end;
        for ii := 0 to FieldCount - 1 do begin
          if Bof or Eof then begin
          end else if Fields[ ii ].IsBlob then begin
            if Fields[ ii ].IsNull then begin
              Cells[ ii, RowNum + FixedRows - 1] := '(blob)';
            end else begin
              Cells[ ii, RowNum + FixedRows - 1] := '(BLOB)';
            end;
          end else if Fields[ ii ].IsArray then begin
            if Fields[ ii ].IsNull then begin
              Cells[ ii, RowNum + FixedRows - 1] := '(array)';
            end else begin
              Cells[ ii, RowNum + FixedRows - 1] := '(ARRAY)';
            end;
          end else if Fields[ ii ].IsNull then begin
            Cells[ ii, RowNum + FixedRows - 1] := NullText;
          end else begin
            Cells[ ii, RowNum + FixedRows - 1] := Fields[ ii ].DisplayText;
          end;
        end;
      end;
    end;
  end;
end;

procedure TIB_CursorGrid.UpdateGrid;
  procedure InitGrid;
  var
    ii: integer;
  begin
    FixedRows := 0;
    RowCount  := 2;
    FixedRows := 1;
    for ii := 0 to RowCount - 1 do begin
      Rows[ ii ].Clear;
    end;
  end;
var
  ii: integer;
begin
  if Frozen or ( DataSource = nil ) then Exit;
  if not ( csLoading    in ComponentState ) and
     not ( csDestroying in ComponentState ) then begin
    if FIB_DataLink.Prepared then begin
      with FIB_DataLink.Dataset do begin
        if DataSource.State = dssPrepared then begin
          InitGrid;
        end;
        ColCount := FieldCount;
        for ii := 0 to FieldCount - 1 do with Fields[ ii ] do begin
          ColWidths[ ii ] := DisplayWidth;
          Cells[ ii, 0 ] := Fields[ ii ].DisplayLabel;
        end;
      end;
    end else begin
      InitGrid;
      ColCount := 1;
    end;
  end;
end;

procedure TIB_CursorGrid.CMEnter( var Message: TCMEnter );
begin
  FIB_DataLink.SetFocus;
  inherited;
end;

procedure TIB_CursorGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if FIB_DataLink.Prepared then with DataSource.Dataset do begin
    case Key of
      VK_DOWN: begin
        if not Eof and (( RowNum = Row ) or Bof ) then Next;
      end;
    end;
  end;
  inherited KeyDown( Key, Shift );
  if FIB_DataLink.Prepared then with DataSource.Dataset do begin
    if ssCtrl in Shift then case Key of
      VK_HOME: begin
        if not Active or Bof then First;
        Row := FixedRows;
        Key := 0;
      end;
      VK_END: begin
        if not Eof then Last;
        Row := RowCount - FixedRows;
        Key := 0;
      end;
    end;
  end;
end;

procedure TIB_CursorGrid.ChangeScale( M, D: integer );
begin
  if M <> D then
    DefaultRowHeight := MulDiv( DefaultRowHeight, M, D );
  inherited ChangeScale( M, D );
end;

procedure TIB_CursorGrid.DrawCell( ACol, ARow: Longint;
                                   ARect: TRect;
                                   AState: TGridDrawState );
var
  tmpRect: TRect;
begin
  if csLoading in ComponentState then begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect( ARect );
  end else if gdFixed in AState then begin
    Canvas.Brush.Color := FixedColor;
    Canvas.FillRect( ARect );
    Canvas.TextRect( ARect, ARect.Left + 2, ARect.Top + 2, Cells[ACol, ARow] );
    tmpRect := ARect;
    if Ctl3D and
       ((FrameFlags1 or FrameFlags2) <> 0) then begin
      tmpRect := ARect;
      if (FrameFlags1 and BF_RIGHT) = 0 then begin
        Inc( tmpRect.Right, GridLineWidth );
      end else if (FrameFlags1 and BF_BOTTOM) = 0 then begin
        Inc( tmpRect.Bottom, GridLineWidth );
      end;
      if Ctl3D and Ctl3DShallow then begin
        DrawShallowEdge( Canvas, tmpRect, Options );
      end else begin
        DrawEdge( Canvas.Handle, tmpRect, BDR_RAISEDINNER, FrameFlags1 );
        DrawEdge( Canvas.Handle, tmpRect, BDR_RAISEDINNER, FrameFlags2 );
      end;
    end;
  end else begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect( ARect );
    Canvas.TextRect( ARect, ARect.Left + 2, ARect.Top + 2, Cells[ACol, ARow] );
  end;
end;

procedure TIB_CursorGrid.Paint;
begin
  FrameFlags1 := 0;
  FrameFlags2 := 0;
  if goFixedVertLine in Options then begin
    FrameFlags1 := BF_RIGHT;
    FrameFlags2 := BF_LEFT;
  end;
  if goFixedHorzLine in Options then begin
    FrameFlags1 := FrameFlags1 or BF_BOTTOM;
    FrameFlags2 := FrameFlags2 or BF_TOP;
  end;
  inherited Paint;
end;

procedure TIB_CursorGrid.SetCtl3DShallow( AValue: boolean );
begin
  if Ctl3DShallow <> AValue then begin
    FCtl3DShallow := AValue;
    if AValue then begin
      Ctl3D := true;
      DefaultDrawing := false;
    end;
    Invalidate;
  end;
end;

end.
