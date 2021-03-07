{                                                                              }
{ IB_ArrayGrid                                                                 }
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
{    Compile error at end of unit                                              }
{    - Can't constant assigned a value                                         }
{      'iscZero' must declared as var instead of const                         }
{                                                                              }
{ Enhanced Nov/Dec 2000 by Tobias Giesen                                       }
{                                                                              }
{ documented on http://www.somusque.de/ArrayGrid.htm                           }
{                                                                              }
//  6 January 2001     TG    - bug fixed where Delphi could not load and show
//                             forms at design time when the ArrayGrid's Query
//                             had previously been activated at design time
//                             (ColWidths were saved with too many colums)
// 11 December 2000    TG    - improved DATE support
//                             use arrgrd_NoDate constant to specify that an
//                             array member is to be considered NULL (empty cell)
//                           - fixed not being able to write to two-dimensional
//                             array in multi-array-field grids
// 10 December 2000    TG    - support for DATE array fields
//                             (works with fixed IBO)
//                           - some minor bugfixes and
//                             a serious one (column confusion in multi-field //                             grids)
//
//    November 2000    TG    first release of enhanced version
//
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the TIB_ArrayGrid component. }
unit
  IB_ArrayGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids,Math,

{$ifdef IBO_VCL60_OR_GREATER}
  Variants,
{$endif}

  IB_Session,
  IB_Header,
  IB_Parse,
  IB_Components,
  IB_FieldDataLink,
  IB_Constants;

var arrgrd_NoDate:TDateTime;

type

  TIB_GetDisplayTextEvent=procedure (Sender: TObject;const ACol,ARow:LongInt;var AString: string) of object;

{: This component is for displaying and editing array column data.
   It will work on one or two dimensional array columns only.}
TIB_ArrayGrid = class(TStringGrid)
private
  FIB_DataLinks: TList;
  FOnGetDisplayText:TIB_GetDisplayTextEvent;
  FMaxItemsPerLine:Integer;
  FMaxItemsShown:Integer;
  FItemsPerLine:Integer;
  FItemsShown:TList;
  FDataFields:TStringList;
  FDumbLabels:Boolean;
  Dim1Extents,Dim2Extents:TList;
  Dimension:TList;
  StartLines:TList;
  procedure SetDataSource( AValue: TIB_DataSource); virtual;
  function GetDataSource: TIB_DataSource; virtual;
  procedure SetDataSources(arr:Integer;const AValue:TIB_DataSource); virtual;
  function GetDataSources(arr:Integer): TIB_DataSource; virtual;
  function GetFieldDataLink(arr:Integer):TIB_FieldDataLink; virtual;
  function GetDataField: string;
  procedure SetDataField( AValue: string );
  function GetDataFields: TStringList;
  procedure SetDataFields( DF:TStringList);
  procedure CheckDataLinksLength(const needed:Integer);
  procedure IB_PreparedChanged( Sender: TIB_DataLink;
                                DataSource: TIB_DataSource );
  procedure IB_StateChanged( Sender: TIB_DataLink;
                             DataSource: TIB_DataSource );
  procedure IB_DataChange( Sender: TIB_DataLink;
                           DataSource: TIB_DataSource;
                           IB_Field: TIB_Column );
  procedure IB_UpdateData( Sender: TIB_DataLink;
                           DataSource: TIB_DataSource;
                           IB_Field: TIB_Column );
  procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
  procedure SetMaxItemsShown(const Value:Integer);
  procedure SetMaxItemsPerLine(const Value:Integer);
  procedure CreateOneDataLink(const Number:Integer);
  procedure SetItemsShown(Num:Integer;const Amount:Integer);
  function GetItemsShown(Num:Integer):Integer;
protected
  procedure Loaded; override;
  property DataLinks[arr:Integer]: TIB_FieldDataLink read GetFieldDataLink;
public
  procedure SetEditText( ACol, ARow: Longint; const Value: string ); override;
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
  property ItemsPerLine:Integer read FItemsPerLine write FItemsPerLine;
  property ItemsShown[Num:Integer]:Integer read GetItemsShown write SetItemsShown;
  function WhichRow(const ArrayNum,Idx1,Idx2:Integer):Integer;
  function WhichCol(const ArrayNum,Idx1,Idx2:Integer):Integer;
  function WhichArray(const Col,Row:Integer):Integer;
  function WhichIdx1(const Col,Row:Integer):Integer;
  function WhichIdx2(const Col,Row:Integer):Integer;
  property DataSources[arr:Integer]: TIB_DataSource read GetDataSources write SetDataSources;
published
{: Reference to the DataSource for the grid.}
  property DataSource: TIB_DataSource read GetDataSource write SetDataSource;
{: Reference to the array column.}
  property DataField: string read GetDataField write SetDataField;
  property DataFields: TStringList read GetDataFields write SetDataFields;
  property DumbLabels: Boolean read FDumbLabels write FDumbLabels;
{$IFNDEF HELPSCAN}
  property DefaultRowHeight default G_DefaultRowHeight;
  property ColCount stored false;
  property RowCount stored false;
  property FixedCols stored false;
  property FixedRows stored false;
{$ENDIF}
  property OnGetDisplayText: TIB_GetDisplayTextEvent read FOnGetDisplayText write FOnGetDisplayText;
  property MaxItemsPerLine:Integer read FMaxItemsPerLine write SetMaxItemsPerLine;
  property MaxItemsShown:Integer read FMaxItemsShown write SetMaxItemsShown;
end;

implementation

uses
  IB_Utils;
  
var arrgrd_BugDate:TDateTime;

procedure TIB_ArrayGrid.CreateOneDataLink(const Number:Integer);
begin
  FIB_DataLinks.Add(TIB_FieldDataLink.Create(Self));
  with TIB_Datalink(FIB_DataLinks[Number-1]) do begin
    AfterAssignment   := IB_PreparedChanged;
    OnPreparedChanged := IB_PreparedChanged;
    OnStateChanged    := IB_StateChanged;
    OnDataChange      := IB_DataChange;
    OnUpdateData      := IB_UpdateData;
    end;
  end;

procedure TIB_ArrayGrid.CheckDataLinksLength(const needed:Integer);
var i,oldlen:Integer;
begin
  oldlen:=FIB_DataLinks.Count;
  if (oldlen<needed) then begin
     FIB_DataLinks.Capacity:=needed;
     FItemsShown.Capacity:=needed;
     Dim1Extents.Capacity:=needed;
     Dim2Extents.Capacity:=needed;
     Dimension.Capacity:=needed;
     StartLines.Capacity:=needed;
     for i:=oldlen+1 to needed do begin
       CreateOneDataLink(i);
       FItemsShown.Add(Pointer(0));
       Dim1Extents.Add(Pointer(0));
       Dim2Extents.Add(Pointer(0));
       Dimension.Add(Pointer(0));
       StartLines.Add(Pointer(0));
       end;
     end;
  end;


constructor TIB_ArrayGrid.Create( AOwner: TComponent );
begin
  FDataFields:=TStringList.Create;
  FIB_DataLinks:=TList.Create;
  FItemsShown:=TList.Create;
  Dim1Extents:=TList.Create;
  Dim2Extents:=TList.Create;
  Dimension:=TList.Create;
  StartLines:=TList.Create;
  CheckDataLinksLength(1);
  inherited Create( AOwner );
  inherited DefaultRowHeight := G_DefaultRowHeight;
  Options := Options + [goEditing];
  StartLines[0]:=Pointer(1);
end;

destructor TIB_ArrayGrid.Destroy;
var i:Integer;
begin
  DataSource := nil;
  for i:=1 to FDataFields.Count-1 do 
    DataLinks[i].Free;
  FDataFields.Free;
  FItemsShown.Free;
  Dim1Extents.Free;
  Dim2Extents.Free;
  StartLines.Free;
  Dimension.Free;
  inherited Destroy;
end;

procedure TIB_ArrayGrid.Loaded;
var i:Integer;
begin
  inherited Loaded;
  if FDataFields.Count > 0 then
  begin
    CheckDataLinksLength( FDataFields.Count );
    if DataLinks[0].FieldName <> FDataFields.Strings[0] then
      SetDataField(FDataFields.Strings[0]);
    for i := 1 to FDataFields.Count - 1 do
    begin
      DataLinks[ i ].DataSource := DataLinks[ 0 ].DataSource;
      DataLinks[ i ].FieldName  := FDataFields.Strings[ i ];
    end;
  end;
  IB_PreparedChanged( DataLinks[0], DataSource );
end;

{------------------------------------------------------------------------------}

function TIB_ArrayGrid.GetDataSource: TIB_DataSource;
begin
  CheckDataLinksLength(1);
  Result := DataLinks[0].DataSource;
  end;

procedure TIB_ArrayGrid.SetDataSource( AValue: TIB_DataSource );
var i:Integer;
begin
  CheckDataLinksLength(1);
  for i:=0 to FIB_DataLinks.Count-1 do
    DataLinks[i].DataSource := AValue;
  end;

function TIB_ArrayGrid.GetFieldDataLink(arr:Integer):TIB_FieldDataLink; 
begin
  GetFieldDataLink:=TIB_FieldDataLink(FIB_DataLinks[arr]);
  end;

procedure TIB_ArrayGrid.SetDataSources(arr:Integer;const AValue:TIB_DataSource);
begin
  DataLinks[arr-1].DataSource:=AValue;
  end;

function TIB_ArrayGrid.GetDataSources(arr:Integer): TIB_DataSource;
begin
  Result:=DataLinks[arr-1].DataSource;
  end;

function TIB_ArrayGrid.GetDataField: string;
begin
  CheckDataLinksLength(1);
  Result := DataLinks[0].FieldName;
  end;

procedure TIB_ArrayGrid.SetDataField( AValue: string );
begin
  CheckDataLinksLength(1);
  DataLinks[0].FieldName := AValue;
  if (FDataFields.Count<1) then
     FDataFields.Add(AValue)
  else
     FDataFields.Strings[0]:=AValue;
  end;

function TIB_ArrayGrid.GetDataFields: TStringList;
begin
  if (FDataFields.Count<1) then
     FDataFields.Add(DataLinks[0].FieldName)
  else
     if (FDataFields.Strings[0]='') then
        FDataFields.Strings[0]:=DataLinks[0].FieldName;
  Result:=FDataFields;
  end;

procedure TIB_ArrayGrid.SetDataFields( DF:TStringList);
begin
  FDataFields.Assign(DF);
  end;

procedure TIB_ArrayGrid.SetMaxItemsShown(const Value:Integer);
var i:Integer;
    change:Boolean;
begin
  FMaxItemsShown:=Value;
  change:=false;
  for i:=1 to FIB_DataLinks.Count do
    if (Value<Integer(FItemsShown[i-1])) or
       (Value>Integer(FItemsShown[i-1])) and (Integer(FItemsShown[i-1])<Integer(Dim1Extents[i-1])) then begin // recalc grid size
       change:=true;
       break;
       end;
  if change then begin
    IB_PreparedChanged( FIB_DataLinks[i-1], DataSource );
    for i:=1 to FIB_DataLinks.Count do
        IB_DataChange( DataLinks[i-1],
                       DataSource,
                       DataLinks[i-1].Field);
    end;
  end;

procedure TIB_ArrayGrid.SetMaxItemsPerLine(const Value:Integer);
var i:Integer;
begin
  FMaxItemsPerLine:=Value;
  if (Value<>FItemsPerLine) then begin // recalc grid size
     IB_PreparedChanged( FIB_DataLinks[0], DataSource );
     for i:=1 to FIB_DataLinks.Count do
         IB_DataChange( DataLinks[i-1],
                        DataSource,
                        DataLinks[i-1].Field);
     end;
  end;

procedure TIB_ArrayGrid.SetItemsShown(Num:Integer;const Amount:Integer);
begin
  FItemsShown[Num]:=Pointer(Amount);
  end;

function TIB_ArrayGrid.GetItemsShown(Num:Integer):Integer;
begin
  Result:=Integer(FItemsShown[Num]);
  end;

function TIB_ArrayGrid.WhichArray(const Col,Row:Integer):Integer;
var i:Integer;
begin
  Result:=1;
  for i:=1 to StartLines.Count-1 do
    if (Integer(StartLines[i])<=Col) and
       (Integer(StartLines[i])<>0) then
       Result:=i+1
    else
       break;
  end;

function TIB_ArrayGrid.WhichIdx1(const Col,Row:Integer):Integer;
var ArrNum:Integer;
begin
  ArrNum:=WhichArray(Col,Row);
  case Integer(Dimension[ArrNum-1]) Of
    1: Result:=(Col-Integer(StartLines[ArrNum-1]))*ItemsPerLine+Row;
    2: Result:=Row;
    else
       Result:=0;
    end;
  end;

function TIB_ArrayGrid.WhichIdx2(const Col,Row:Integer):Integer;
var ArrNum:Integer;
begin
  ArrNum:=WhichArray(Col,Row);
  case Integer(Dimension[ArrNum-1]) Of
    2: Result:=Col-Integer(StartLines[ArrNum-1])+1;
    else
       Result:=0;
    end;
  end;

procedure TIB_ArrayGrid.SetEditText( ACol, ARow: Longint; const Value: string );
var ArrNum:Integer;
begin
  if Cells[ Acol, ARow ] <> Value then
  begin
    ArrNum:=WhichArray(ACol,ARow);
    if DataLinks[ArrNum-1].Modify then
    begin
      inherited SetEditText( ACol, ARow, Value );
      DataLinks[ArrNum-1].ControlIsModified := true;
    end;
  end
  else
    inherited SetEditText( ACol, ARow, Value );
end;

{$ifndef Min}
function Min(A,B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function Max(A,B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;
{$endif}


{------------------------------------------------------------------------------}

procedure TIB_ArrayGrid.IB_PreparedChanged( Sender: TIB_DataLink;
                                            DataSource: TIB_DataSource );
  procedure ClearArrayGrid;
  begin
    ColCount := 2;
    RowCount := 2;
    Cells[0,0] := '';
    Cells[0,1] := '';
    Cells[1,0] := '';
    if not (csDesigning in ComponentState) then
       if DumbLabels then
          ColWidths[0]:=60
       else
          ColWidths[0]:=30;
  end;
var
  ArrNum:Integer;
  maxVal,CurLine:Integer;
  ii: integer;
  lowRowDiff, lowColDiff: integer;
  ColName,tmpTxt:string;
begin
  if (MaxItemsPerLine<1) then
     MaxItemsPerLine:=MaxLongInt;
  if (MaxItemsShown<1) then
     MaxItemsShown:=MaxLongInt;
  CurLine:=1;
  lowRowDiff:=0; // avoid warning
  lowColDiff:=0; // avoid warning
  ClearArrayGrid;
  for ArrNum:=1 to FIB_DataLinks.Count do
    with DataLinks[ArrNum-1] do begin
      if Prepared and ( Field is TIB_ColumnArray ) then
        with Field as TIB_ColumnArray, ArrayDesc do begin
          if (ArrNum=4) then
             CurLine:=CurLine+ArrNum-4;
          Dim1Extents[ArrNum-1]:=Pointer(array_desc_bounds[0].array_bound_upper-
                                         array_desc_bounds[0].array_bound_lower+1);
          FItemsShown[ArrNum-1]:=Pointer(Min(MaxItemsShown,Integer(Dim1Extents[ArrNum-1])));
          RowCount := Max(RowCount,1+Min(Integer(FItemsShown[ArrNum-1]),MaxItemsPerLine));
          case (array_desc_dimensions) Of
            1:begin
                Dimension[ArrNum-1]:=Pointer(1);
                ColCount := CurLine + (Integer(FItemsShown[ArrNum-1])+RowCount-2) div (RowCount-1);
                lowColDiff := 0;
                end;
            2:begin
                Dimension[ArrNum-1]:=Pointer(2);
                Dim2Extents[ArrNum-1]:=Pointer(array_desc_bounds[1].array_bound_upper-
                                               array_desc_bounds[1].array_bound_lower+1);
                ColCount := CurLine + ( array_desc_bounds[1].array_bound_upper -
                                        array_desc_bounds[1].array_bound_lower + 1 );
                lowColDiff := array_desc_bounds[1].array_bound_lower;
                end
            end;
          StartLines[ArrNum-1]:=Pointer(CurLine);
          CurLine:=ColCount;
          ItemsPerLine:=RowCount-1; // will be different when array is transposed
          lowRowDiff := array_desc_bounds[0].array_bound_lower;
          end;
      end;
  if (CurLine>1) then begin
    for ii := 1 to RowCount -1 do begin
      if (DumbLabels) then
         tmpTxt := C_AG_Row + ' ' + IntToStr( ii + lowRowDiff - 1 )
      else
         tmpTxt := IntToStr( ii + lowRowDiff - 1 );
      if (Assigned(FOnGetDisplayText)) then
         OnGetDisplayText(Sender,0,ii,tmpTxt);
      Cells[0,ii]:=tmpTxt;
      end;
    for ii := 1 to ColCount -1 do begin
      ArrNum:=WhichArray(ii,0)-1;
      if DumbLabels then
         tmpTxt:=C_AG_Column + ' ' + IntToStr( ii + lowColDiff - 1 )
      else
         if (Integer(Dimension[WhichArray(ii,0)-1])=1) then begin
            ColName:=DataLinks[WhichArray(ii,0)-1].Field.DisplayLabel;
//            ColName:=ColName[1]+LowerCase(Copy(ColName,2,100));

            if (ItemsPerLine<Integer(Dim1Extents[ArrNum])) and
               (ItemsPerLine<Integer(ItemsShown[ArrNum])) then begin
               maxVal:=Min((ii-Integer(StartLines[ArrNum])+1)*ItemsPerLine,Integer(ItemsShown[ArrNum]));
               tmpTxt:=IntToStr((ii-Integer(StartLines[ArrNum]))*ItemsPerLine+1)+'-'+IntToStr(maxVal);
               if (FIB_DataLinks.Count>1) then
                  tmpTxt:=tmpTxt+' ('+ColName+')';
               end
            else
               tmpTxt:=ColName
            end
         else
            tmpTxt := C_AG_Column + ' ' + IntToStr( ii + lowColDiff - Integer(StartLines[ArrNum]) );
      if (Assigned(FOnGetDisplayText)) then
         OnGetDisplayText(Sender,ii,0,tmpTxt);
      Cells[ ii, 0 ]:=tmpTxt;
      end;
    end;
  end;

procedure TIB_ArrayGrid.IB_StateChanged( Sender: TIB_DataLink;
                                         DataSource: TIB_DataSource );
begin
  with DataLinks[0] do
    if ColorScheme then
      Self.Color := Color;
  end;

function TIB_ArrayGrid.WhichRow(const ArrayNum,Idx1,Idx2:Integer):Integer;
begin
  Case Integer(Dimension[ArrayNum-1]) of
    1:WhichRow:=(Idx1-1) mod ItemsPerLine+1;
    2:WhichRow:=Idx1;
    else
       WhichRow:=0;
    end;
  end;

function TIB_ArrayGrid.WhichCol(const ArrayNum,Idx1,Idx2:Integer):Integer;
begin
  Case Integer(Dimension[ArrayNum-1]) Of
    1:WhichCol:=(Idx1-1) div ItemsPerLine+Integer(StartLines[ArrayNum-1]);
    2:WhichCol:=Idx2+Integer(StartLines[ArrayNum-1])-1;
    else
       WhichCol:=0;
    end;
  end;

procedure TIB_ArrayGrid.IB_DataChange( Sender: TIB_DataLink;
                                       DataSource: TIB_DataSource;
                                       IB_Field: TIB_Column );
var
  ArrNum:Integer;
  ii, jj: integer;
  AVar: Variant;
  lBnd1, lBnd2: integer;
  tmpStr:string;
  tmpDt:TDateTime;
begin
  for ArrNum:=1 to FIB_DataLinks.Count do
    if (DataLinks[ArrNum-1]=Sender) then
      with DataLinks[ArrNum-1] do begin
       if Prepared and (not Assigned(IB_Field) or (IB_Field=Field)) then begin
         if Assigned(Field) then
            AVar := Field.Value
         else
            AVar := Unassigned;
         if VarIsArray( AVar ) then begin
           lBnd1 := VarArrayLowBound( AVar, 1 );
           if VarArrayDimCount( AVar ) = 2 then
             lBnd2 := VarArrayLowBound( AVar, 2 )
           else
             lBnd2 := 0;
           end
         else begin
           lBnd1 := 0;
           lBnd2 := 0;
           end;
         if VarArrayDimCount( AVar ) = 1 then begin
            for ii := 1 to Integer(FItemsShown[ArrNum-1]) do begin
              if VarIsArray( AVar ) then begin
                if (VarType(AVar[ ii - 1 + lBnd1 ])=varDate) then begin
                   tmpDt :=AVar[ ii - 1 + lBnd1 ];
                   if (tmpDt=arrgrd_BugDate) then
                      raise EIB_Error.Create('This IBO version does not support DATE arrays. Please look for an update!');
                   if (tmpDt=arrgrd_NoDate) then
                      tmpStr:=''
                   else
                      tmpStr := DateTimeToStr(tmpDt);
                   end
                else
                   tmpStr := AVar[ ii - 1 + lBnd1 ];
                if (Assigned(FOnGetDisplayText)) then
                   OnGetDisplayText(Sender,Integer(StartLines[ArrNum-1]),ii,tmpStr);
                Cells[ WhichCol(ArrNum,ii,0), WhichRow(ArrNum,ii,0) ] := tmpStr;
              end else begin
                Cells[ WhichCol(ArrNum,ii,0), WhichRow(ArrNum,ii,0) ] := '';
              end;
            end;
            for ii:=WhichRow(ArrNum,Integer(FItemsShown[ArrNum-1]),0)+1 to RowCount do begin
                Cells[ WhichCol(ArrNum,Integer(FItemsShown[ArrNum-1]),0), ii ] := '';
                end;
            end
         else
           for jj := 1 to ColCount - 1 do
            if (WhichArray(jj,1)=ArrNum) then begin
             for ii := 1 to RowCount - 1 do begin
               if VarIsArray( AVar ) then begin
                 tmpStr := AVar[ ii + lBnd1-1 , jj - Integer(StartLines[ArrNum-1]) + lBnd2 ];
                 if (Assigned(FOnGetDisplayText)) then
                    OnGetDisplayText(Sender,jj+Integer(StartLines[ArrNum-1])-1,ii,tmpStr);
                 Cells[ jj, WhichRow(ArrNum,ii,jj) ] := tmpStr;
               end else begin
                 Cells[ jj, WhichRow(ArrNum,ii,jj) ] := '';
               end;
             end;
         end;
       end;
     end;
  end;

procedure TIB_ArrayGrid.IB_UpdateData( Sender: TIB_DataLink;
                                       DataSource: TIB_DataSource;
                                       IB_Field: TIB_Column );
var
  ArrNum:Integer;
  ii, jj: integer;
  AVar: Variant;
  lBnd1, lBnd2: integer;
begin
  for ArrNum:=1 to FIB_DataLinks.Count do
    if (DataLinks[ArrNum-1]=Sender) then
      with DataLinks[ArrNum-1] do begin
        if Prepared and (not Assigned(IB_Field) or (IB_Field=Field)) then begin
          with Field as TIB_ColumnArray, ArrayDesc do begin
            lBnd1 := array_desc_bounds[ 0 ].array_bound_lower;
            lBnd2 := array_desc_bounds[ 1 ].array_bound_lower;
            end;
          if Integer(Dimension[ArrNum-1])=1 then begin
            AVar := VarArrayCreate( [lBnd1,Integer(Dim1Extents[ArrNum-1])+lBnd1-1], varVariant );
            for ii := 1 to Min(Integer(FItemsShown[ArrNum-1]),Integer(Dim1Extents[ArrNum-1])) do
              AVar[ ii - 1 + lBnd1 ] := Cells[ WhichCol(ArrNum,ii,0), WhichRow(ArrNum,ii,0) ];
          end else begin
            AVar := VarArrayCreate( [ lBnd1, Integer(Dim1Extents[ArrNum-1])+lBnd1-1,
                                      lBnd2, Integer(Dim2Extents[ArrNum-1])+lBnd2-1 ], varVariant );
            for jj := 1 to Integer(Dim2Extents[ArrNum-1]) do begin
              for ii := 1 to Min(Integer(FItemsShown[ArrNum-1]),Integer(Dim1Extents[ArrNum-1])) do begin
                AVar[ ii - 1 + lBnd1, jj - 1 + lBnd2 ] := Cells[ WhichCol(ArrNum,ii,jj), WhichRow(ArrNum,ii,jj) ];
                end;
              end;
            end;
          Field.Value := AVar;
          end;
        end;
  end;

procedure TIB_ArrayGrid.CMEnter( var Message: TCMEnter );
begin
  DataLinks[0].SetFocus;
  inherited;
end;

var
  iscZero:isc_quad=(isc_quad_high:0;isc_quad_low:0);

begin
  arrgrd_NoDate:=isc_decode_TDateTime(@iscZero);
  FillChar(iscZero,SizeOf(iscZero),#32);
  arrgrd_BugDate:=isc_decode_TDateTime(@iscZero);
end.
