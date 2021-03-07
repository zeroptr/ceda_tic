
{                                                                              }
{ IB_StatementGrid                                                             }
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

{: This unit contains the TIB_StatementGrid component.}
unit
  IB_StatementGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids,

  IB_Header,
  IB_Constants,
  IB_Components,
  
  IB_StatementSource;

type
{: This component serves as a row viewer and modifier.
<br><br>
It also can display extended attributes of a row's columns.}
TIB_StatementGrid = class( TStringGrid )
private
  FIB_StatementSource: TIB_StatementSource;
  FIB_RowType: TIB_RowType;
  FFieldInfo: boolean;
  FDomainInfo: boolean;
  FTitleInfo: boolean;
  FRowOffset: integer;
  FPosting: boolean;
  FrameFlags1, FrameFlags2: DWORD;
  FCtl3DShallow: boolean;
  procedure SetStatement( AValue: TIB_Statement ); virtual;
  function GetStatement: TIB_Statement; virtual;
  procedure SetIB_RowType( AValue: TIB_RowType ); virtual;
  procedure SetFieldInfo( AValue: boolean ); virtual;
  procedure SetDomainInfo( AValue: boolean ); virtual;
  procedure SetTitleInfo( AValue: boolean ); virtual;
  property RowOffset: integer read FRowOffset;
  procedure SetCtl3DShallow( AValue: boolean );
protected
  procedure ChangeScale( M, D: integer ); override;
  procedure DrawCell( ACol, ARow: Longint;
                      ARect: TRect;
                      AState: TGridDrawState ); override;
  procedure Loaded; override;
  procedure Paint; override;
  procedure IB_StatementUpdate( Sender: TIB_StatementLink;
                                Statement: TIB_Statement );
  procedure IB_FieldChanged( Sender: TIB_StatementLink;
                             Statement: TIB_Statement;
                             Field: TIB_Column );
  procedure IB_ParamChanged( Sender: TIB_StatementLink;
                             Statement: TIB_Statement;
                             Param: TIB_Column );
  procedure IB_FieldUpdate( Sender: TIB_StatementLink;
                            Statement: TIB_Statement;
                            Field: TIB_Column );
  procedure IB_ParamUpdate( Sender: TIB_StatementLink;
                            Statement: TIB_Statement;
                            Param: TIB_Column );
public
  constructor Create( AOwner: TComponent ); override;
  procedure UpdateGrid;
  procedure UpdateTitle;
  procedure CloseGrid;
  procedure PostChanges;
  
published

{: This controls the depth of the 3D appearance of the fixed cells.}
  property Ctl3DShallow: boolean read FCtl3DShallow
                                 write SetCtl3DShallow
                                 default false;
{: If true then Field attributes are included in additional Fields in the grid.}
  property FieldInfo: boolean read FFieldInfo
                              write SetFieldInfo
                              default false;
{: If true this will include the name of the domain along with the Field type.
FieldInfo must also be true for this property to have any effect.}
  property DomainInfo: boolean read FDomainInfo
                               write SetDomainInfo
                               default false;

{: If true this will include column headers. }
  property TitleInfo: boolean read FTitleInfo write SetTitleInfo default false;
{: The statement for which this grid is to display or modify row data.}
  property Statement: TIB_Statement read GetStatement
                                    write SetStatement;
{: Each statement has two rows. One for Param and one for Field.
<br><br>
This property determines which row the grid will display or modify.}
  property IB_RowType: TIB_RowType read FIB_RowType write SetIB_RowType;
{$IFNDEF HELPSCAN}
  property DefaultRowHeight;
{$ENDIF}
  end;

implementation

uses
  IB_Utils;
  
constructor TIB_StatementGrid.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FIB_StatementSource := TIB_StatementSource.Create( Self );
  with FIB_StatementSource as TIB_StatementSource do
  begin
    AfterAssignment := IB_StatementUpdate;
    AfterExecute := IB_StatementUpdate;
    OnPreparedChanged := IB_StatementUpdate;
    OnParamsDataChange := IB_ParamChanged;
    OnParamsUpdateData := IB_ParamUpdate;
    OnFieldsDataChange := IB_FieldChanged;
    OnFieldsUpdateData := IB_FieldUpdate;
  end;
  DefaultRowHeight := 17;
  CloseGrid;
end;

procedure TIB_StatementGrid.Loaded;
begin
  inherited Loaded;
  UpdateGrid;
end;

{------------------------------------------------------------------------------}

procedure TIB_StatementGrid.SetIB_RowType( AValue: TIB_RowType );
begin
  if FIB_RowType <> AValue then
  begin
    FIB_RowType := AValue;
    UpdateGrid;
  end;
end;

procedure TIB_StatementGrid.SetStatement( AValue: TIB_Statement);
begin
  if FIB_StatementSource <> nil then
    if FIB_StatementSource.Statement <> AValue then
    begin
      FIB_StatementSource.Statement := AValue;
      UpdateGrid;
    end;
end;

function TIB_StatementGrid.GetStatement: TIB_Statement;
begin
  Result := FIB_StatementSource.Statement;
end;

procedure TIB_StatementGrid.SetFieldInfo( AValue: boolean );
begin
  if FieldInfo <> AValue then
  begin
    FFieldInfo := AValue;
    UpdateGrid;
  end;
end;

procedure TIB_StatementGrid.SetDomainInfo( AValue: boolean );
begin
  if DomainInfo <> AValue then
  begin
    FDomainInfo := AValue;
    UpdateGrid;
  end;
end;

procedure TIB_StatementGrid.SetTitleInfo( AValue: boolean );
begin
  if TitleInfo <> AValue then
  begin
    FTitleInfo := AValue;
    if TitleInfo then
      Inc( FRowOffset )
    else
      Dec( FRowOffset );
    UpdateGrid;
  end;
end;

{------------------------------------------------------------------------------}

procedure TIB_StatementGrid.IB_StatementUpdate( Sender: TIB_StatementLink;
                                                Statement: TIB_Statement);
begin
  UpdateGrid;
end;

procedure TIB_StatementGrid.IB_FieldChanged( Sender: TIB_StatementLink;
                                             Statement: TIB_Statement;
                                             Field: TIB_Column );
begin
  if IB_RowType = rtField then
    UpdateGrid;
end;

procedure TIB_StatementGrid.IB_ParamChanged( Sender: TIB_StatementLink;
                                             Statement: TIB_Statement;
                                             Param: TIB_Column );
begin
  if IB_RowType = rtParam then
    UpdateGrid;
end;

procedure TIB_StatementGrid.IB_FieldUpdate( Sender: TIB_StatementLink;
                                            Statement: TIB_Statement;
                                            Field: TIB_Column );
begin
  if IB_RowType = rtField then
    PostChanges;
end;

procedure TIB_StatementGrid.IB_ParamUpdate( Sender: TIB_StatementLink;
                                            Statement: TIB_Statement;
                                            Param: TIB_Column );
begin
  if IB_RowType = rtParam then
    PostChanges;
end;

{------------------------------------------------------------------------------}

procedure TIB_StatementGrid.CloseGrid;
var
  ii: integer;
begin
  Options := Options - [goEditing,goAlwaysShowEditor];
  if FieldInfo then
  begin
    ColCount := 4;
    FixedCols := 3;
    ColWidths[ 2 ] := 80;
  end
  else
  begin
    ColCount := 3;
    FixedCols := 2;
  end;
  for ii := RowOffset to RowCount - 1 + RowOffset do
  begin
    Cells[ 0, ii ] := '';
    Cells[ 1, ii ] := '';
    Cells[ 2, ii ] := '';
    if FieldInfo then
      Cells[ 3, ii ] := '';
  end;
  FixedRows := 0;
  RowCount  := RowOffset + 1;
  FixedRows := RowOffset;
end;

procedure TIB_StatementGrid.UpdateTitle;
var
  ss: string;
begin
  if IB_RowType = rtparam then
    ss := C_SG_Parameter
  else
    ss := C_SG_Field;
  if TitleInfo then
  begin
    Cells[ 0, 0 ] := ss + ' ' + C_SG_Name;
    Cells[ 1, 0 ] := ss + ' ' + C_SG_Type;
    if FieldInfo then
    begin
      Cells[ 2, 0 ] := ss + ' ' + C_SG_Info;
      Cells[ 3, 0 ] := ss + ' ' + C_SG_Value;
    end
    else
      Cells[ 2, 0 ] := ss + ' ' + C_SG_Value;
  end;
end;

procedure TIB_StatementGrid.UpdateGrid;
var
  ii: integer;
  tmpRow: TIB_Row;
  tmpCol: TIB_Column;
  ss: string;
begin
  if FPosting then Exit;
  if not ( csLoading in ComponentState ) and
     not ( csDestroying in ComponentState ) then
  begin
    if FIB_StatementSource.Prepared then
    begin
      with Statement do
      begin
        if IB_RowType = rtParam then
        begin
          tmpRow := Params;
          Options := Options + [goEditing,goAlwaysShowEditor];
        end
        else
        begin
          tmpRow := Fields;
          Options := Options - [goEditing,goAlwaysShowEditor];
        end;
        if tmpRow.ColumnCount > 0 then
        begin
          RowCount := tmpRow.ColumnCount + RowOffset;
          FixedRows := RowOffset;
          for ii := RowOffset to tmpRow.ColumnCount - 1 + RowOffset do
          begin
            tmpCol := tmpRow[ ii - RowOffset ];
            with tmpCol do
            begin
              Cells[ 0, ii ] := BestFieldName;
              ss := Copy( tmpRow[ ii - RowOffset ].ClassName, 11, 256 );
              case SQLType of
                SQL_TEXT,
                SQL_TEXT_,
                SQL_VARYING,
                SQL_VARYING_: ss := ss + ' ( ' + IntToStr( SQLLen ) + ' )';
              end;
              if SQLScale <> 0 then case SQLType of
                SQL_INT64,
                SQL_INT64_: ss := ss + ' ( 18, ' + IntToStr(-SQLScale ) + ' )';
                SQL_DOUBLE,
                SQL_DOUBLE_: ss := ss + ' ( 15, ' + IntToStr(-SQLScale ) + ' )';
                SQL_LONG,
                SQL_LONG_: ss := ss + ' ( 9, ' + IntToStr(-SQLScale ) + ' )';
                SQL_SHORT,
                SQL_SHORT_:  ss := ss + ' ( 4, ' + IntToStr(-SQLScale ) + ' )';
              end;
              if ( DomainInfo ) then
                if ( DomainName <> '' ) and
                   ( Copy( DomainName, 1, 4 ) <> 'RDB$' ) then
                  ss := Trim( DomainName ) + ' - ' + ss;
              Cells[ 1, ii ] := ss ;
              if FieldInfo then
              begin
                ss := '';
                if IsPrimary then
                  ss := ss + 'PK ';
                if IsForeign then
                  ss := ss + 'FK ';
                if IsAlternate then
                  ss := ss + 'AK ';
                if not IsPrimary and
                   not IsForeign and
                   not IsAlternate and
                       IsIndexField then
                  ss := ss + 'IN ';
                if IsNullable then
                  ss := ss + 'NULL ';
                if IsDefaulted then
                  ss := ss + 'DF ';
                if Computed then
                  ss := ss + 'COMP ';
                Cells[ 2, ii ] := ss;
              end;
              if tmpRow.RowState = rsNone then
                Cells[ FixedCols, ii ] := ''
              else if tmpCol.IsBlob or tmpCol.IsArray then
                Cells[ FixedCols, ii ] := tmpCol.DisplayText
              else
                Cells[ FixedCols, ii ] := tmpCol.AsString;
            end;
          end;
        end
        else
          CloseGrid;
      end;
    end
    else
      CloseGrid;
  end;
  UpdateTitle;
  Invalidate;
  InvalidateEditor;
end;

procedure TIB_StatementGrid.PostChanges;
var
  ii: integer;
  tmpFld: TIB_Column;
begin
  if Assigned( Statement ) and ( IB_RowType = rtParam ) then
  begin
    if FIB_StatementSource.Prepared and not FPosting then
    begin
      FPosting := true;
      FIB_StatementSource.OnParamsDataChange := nil;
      try
        if Assigned( Statement ) then
        begin
          with Statement do
          begin
            for ii := RowOffset to ParamCount - 1 + RowOffset do
            begin
              tmpFld := Params[ ii - RowOffset ];
              if (( tmpFld.AsString <> Cells[ FixedCols, ii ] ) or
                  ( Row = ii )) and
                 ( Pos( IB_ORDLINK, tmpFld.FieldName ) <> 1 ) and
                 ( Pos( IB_QBE_PARAMETER, tmpFld.FieldName ) <> 1 ) then
                tmpFld.AsString := Cells[ FixedCols, ii ];
            end;
          end;
        end;
      finally
        FPosting := false;
        FIB_StatementSource.OnParamsDataChange := IB_FieldChanged;
      end;
    end;
  end;
end;

procedure TIB_StatementGrid.ChangeScale( M, D: integer );
begin
  if M <> D then
    DefaultRowHeight := MulDiv( DefaultRowHeight, M, D );
  inherited ChangeScale( M, D );
end;

procedure TIB_StatementGrid.DrawCell( ACol, ARow: Longint;
                                      ARect: TRect;
                                      AState: TGridDrawState );
var
  tmpRect: TRect;
begin
  if csLoading in ComponentState then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect( ARect );
  end
  else
  if gdFixed in AState then
  begin
    Canvas.Brush.Color := FixedColor;
    Canvas.FillRect( ARect );
    Canvas.TextRect( ARect, ARect.Left + 2, ARect.Top + 2, Cells[ACol, ARow] );
    tmpRect := ARect;
    if Ctl3D and
       ((FrameFlags1 or FrameFlags2) <> 0) then
    begin
      tmpRect := ARect;
      if (FrameFlags1 and BF_RIGHT) = 0 then
      begin
        Inc( tmpRect.Right, GridLineWidth );
      end
      else
      if (FrameFlags1 and BF_BOTTOM) = 0 then
      begin
        Inc( tmpRect.Bottom, GridLineWidth );
      end;
      if Ctl3D and Ctl3DShallow then
      begin
        DrawShallowEdge( Canvas, tmpRect, Options );
      end
      else
      begin
        DrawEdge( Canvas.Handle, tmpRect, BDR_RAISEDINNER, FrameFlags1 );
        DrawEdge( Canvas.Handle, tmpRect, BDR_RAISEDINNER, FrameFlags2 );
      end;
    end;
  end
  else
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect( ARect );
    Canvas.TextRect( ARect, ARect.Left + 2, ARect.Top + 2, Cells[ACol, ARow] );
  end;
end;

procedure TIB_StatementGrid.Paint;
begin
  FrameFlags1 := 0;
  FrameFlags2 := 0;
  if goFixedVertLine in Options then
  begin
    FrameFlags1 := BF_RIGHT;
    FrameFlags2 := BF_LEFT;
  end;
  if goFixedHorzLine in Options then
  begin
    FrameFlags1 := FrameFlags1 or BF_BOTTOM;
    FrameFlags2 := FrameFlags2 or BF_TOP;
  end;
  inherited Paint;
end;

procedure TIB_StatementGrid.SetCtl3DShallow( AValue: boolean );
begin
  if Ctl3DShallow <> AValue then
  begin
    FCtl3DShallow := AValue;
    if AValue then
    begin
      Ctl3D := true;
      DefaultDrawing := false;
    end;
    Invalidate;
  end;
end;

end.
