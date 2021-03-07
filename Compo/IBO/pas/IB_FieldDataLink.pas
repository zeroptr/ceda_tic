
{                                                                              }
{   TIB_FieldDataLink                                                          }
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

{: This unit contains the IB_FieldDataLink component.}
unit
  IB_FieldDataLink;

interface

uses
  Classes, SysUtils, Graphics, Windows, Forms,

{$IFDEF IBO4_BETA}
  Controls,
{$ENDIF}

  IB_Header,
  IB_Session,
  IB_Utils,
  IB_Components,
  IB_Parse;

type

{$IFDEF IBO4_BETA}

{: This component is used to make a TWinControl based control data aware.}
TIB_InterfaceDataLink = class(TIB_DataLink)
private
  FControl: TWinControl;
public
  constructor Create( AOwner: TComponent ); override;
{: The control which is the visual interface using this datalink.}
  property Control: TWinControl read FControl write FControl;
end;

{: This component is used to make a TWinControl based control data aware.}
TIB_ControlDataLink = class(TIB_InterfaceDataLink)
private
  FControl: TWinControl;
  FControlIsModified: boolean;
  FControlIsReadOnly: boolean;
  FControlPreventsDeleting: boolean;
  FControlPreventsEditing: boolean;
  FControlPreventsInserting: boolean;
  FControlPreventsSearching: boolean;
protected
{ Inherited methods }
  function GetSearchBuffer: string; override;
  function GetReadOnly: boolean; override;
  function GetPreventDeleting: boolean; override;
  function GetPreventEditing: boolean; override;
  function GetPreventInserting: boolean; override;
  function GetPreventSearching: boolean; override;
  function GetSearchEntryName: string; override;
  function GetInvalidColor: TColor; override;
  procedure SysDataChange( AField: TIB_Column ); override;
  procedure SysUpdateData( AField: TIB_Column ); override;
  procedure SysBindingChanged; override;
{ New methods }
  procedure SetControlIsModified( AValue: boolean ); //~virtual;
  procedure SetControlIsReadOnly( AValue: boolean ); //~virtual;
  procedure SetControlPreventsDeleting( AValue: boolean ); //~virtual;
  procedure SetControlPreventsEditing( AValue: boolean ); //~virtual;
  procedure SetControlPreventsInserting( AValue: boolean ); //~virtual;
  procedure SetControlPreventsSearching( AValue: boolean ); //~virtual;
public
{: The control to which the data is bound.}
  property Control: TWinControl read FControl write FControl;
{: The contents of the control need to be saved to the dataset.}
  property ControlIsModified: boolean read FControlIsModified
                                      write SetControlIsModified;
{: This control is set to prevent all cases of modifications.}
  property ControlIsReadOnly: boolean read FControlIsReadOnly
                                      write SetControlIsReadOnly;
{: The control should prevent the dataset from going into dssDelete state.}
  property ControlPreventsDeleting: boolean read FControlPreventsDeleting
                                            write SetControlPreventsDeleting;
{: The control should prevent modifications when in dssEdit state.}
  property ControlPreventsEditing: boolean read FControlPreventsEditing
                                           write SetControlPreventsEditing;
{: The control should prevent modifications when in dssInsert state.}
  property ControlPreventsInserting: boolean read FControlPreventsInserting
                                             write SetControlPreventsInserting;
{: The control should prevent modifications when in dssSearch state.}
  property ControlPreventsSearching: boolean read FControlPreventsSearching
                                             write SetControlPreventsSearching;
end;
{$ENDIF}

{: This component is used to make a control involving a single column...
data aware.}
TIB_FieldDataLink = class(TIB_ControlDataLink)
private
  FFieldName: string;
  FParamName: string;
  FField: TIB_Column;
  FBlobField: TIB_ColumnBlob;
  FBlobID: isc_quad;
  FSearchWithMask: boolean;
  ////added CW
  FInvalidText: string;
  ////
  procedure SetFieldName( AValue: string );
  procedure SetParamName( AValue: string );
  procedure SetFieldText( AValue: string );
  procedure SetInvalidText( AValue: string );  ////added CW
  procedure SetSearchWithMask( AValue: boolean );
  function GetFieldText: string;
  function GetInvalidText: string;
  function GetFieldAlignment: TAlignment;
  function GetFieldCharCase: TIB_CharCase;
  function GetFieldEditmask: string;
  function GetFieldMaxLength: integer;
protected
  function GetReadOnly: boolean; override;
  function GetColor: TColor; override;
  function GetEditingColor: TColor; override;
  function GetInsertingColor: TColor; override;
  function GetPreventEditing: boolean; override;
  function GetPreventInserting: boolean; override;
  function GetPreventSearching: boolean; override;
  function GetField: TIB_Column; override;
  { not required after into of GetField function in base
  procedure SetSearchBuffer( AValue: string ); override; }
  procedure SysDataChange( AField: TIB_Column ); override;
  procedure SysUpdateData( AField: TIB_Column ); override;
  procedure SysBindingChanged; override;
  procedure SysLayoutChanged; override;
  procedure DoPrepareSQL; override;
  procedure DoAfterAssignment; override;
  { not required after into of SysAssignField function in base
  procedure ProcessStatementEvent( AEvent: TIB_StatementEventType;
                                   Info: longint ); override; }
  procedure ProcessStatementEvent( AEvent: TIB_StatementEventType;
                                   Info: longint ); override;
  procedure SysAssignField; override;
  procedure DoAssignField; //~virtual;
public
{: Event that gives notification when the column to which this link is bound...
is changed to a new column or nil.}
  OnAssignField: TIB_ColumnDataLinkEvent;
{: Force any pending changes in the bound control to the dataset.}
  procedure UpdateData; override;
{: Returns whether or not the character is valid for the bound field.
<br><br>
It also takes dssSearch state into consideration and allows more flexibility.}
  function FieldIsValidChar( AKey: char ): boolean; //~virtual;
{: Calling this method will attempt to bring the focus to the attached control.}
  procedure FocusControl( AField: TIB_ColumnRef ); override;
{: Override of base Modify method.}
  function Modify: boolean; override;
{: This is set to true if you want the control to be bound to an input parameter
value instead of to a field value.}  
  function IsParamEdit: boolean;
{: Name of the field to which this link is bound.}
  property FieldName: string read FFieldName write SetFieldName;
{: Name of the parameter to which this link is bound - overrides FieldName}
  property ParamName: string read FParamName write SetParamName;
{: Direct reference to the TIB_Column object to which this link is bound.}
  property Field: TIB_Column read GetField;
{: Direct reference to the TIB_ColumnBlob object to which this link is bound.}
  property BlobField: TIB_ColumnBlob read FBlobField;
{: Reference to the BLOBID that was last accessed in the DataChange
notification.}
  property BlobID: isc_quad read FBlobID;
{: The appropriate text for display or editing depending on the state and...
status of the field and dataset.
<br><br>
dssSearch state is given special consideration here as well.}
  property FieldText: string read GetFieldText write SetFieldText;
{: The appropriate text alignment for display or editing depending on the...
state and status of the field and dataset.
<br><br>
dssSearch state is given special consideration here as well.}
  property FieldAlignment: TAlignment read GetFieldAlignment;
{: The appropriate text case for display or editing depending on the...
state and status of the field and dataset.
<br><br>
dssSearch state is given special consideration here as well.}
  property FieldCharCase: TIB_CharCase read GetFieldCharCase;
{: The appropriate text editing mask for display or editing depending on the...
state and status of the field and dataset.
<br><br>
dssSearch state is given special consideration here as well.}
  property FieldEditMask: string read GetFieldEditmask;
{: The appropriate text length for display or editing depending on the...
state and status of the field and dataset.
<br><br>
dssSearch state is given special consideration here as well.}
  property FieldMaxLength: integer read GetFieldMaxLength;
{: This makes it so that a control will continue to use the EditMask even when
in search mode.}
  property SearchWithMask: boolean read FSearchWithMask write SetSearchWithMask;
{: Text value displayed when there is no valid value from the datalink.
<br><br>
This property can be useful for making a given control work with
DataSource=nil (i.e. in a non-data-aware manner).  The control
should be set to use IgnoreColorScheme=true for such usage.
<br><br>
Note: when in design mode, this property may return the name
of the control associated with this datalink.
}
  property InvalidText: string read GetInvalidText write SetInvalidText;
end;

implementation

{$IFDEF IBO4_BETA}

constructor TIB_InterfaceDataLink.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FIsCtrlLink := true;
end;

procedure TIB_ControlDataLink.SetControlIsModified( AValue: boolean );
begin
  if ControlIsModified <> AValue then
  begin
    FControlIsModified := AValue;
    if ( State = dssSearch ) and ControlIsModified then
      Dataset.InvalidateSQL;
    SysStateChanged;
  end;
end;

procedure TIB_ControlDataLink.SetControlIsReadOnly( AValue: boolean );
begin
  if ControlIsReadOnly <> AValue then
  begin
    FControlIsReadOnly := AValue;
    SysStateChanged;
  end;
end;

procedure TIB_ControlDataLink.SetControlPreventsDeleting( AValue: boolean );
begin
  if ControlPreventsDeleting <> AValue then
  begin
    FControlPreventsDeleting := AValue;
    SysStateChanged;
  end;
end;

procedure TIB_ControlDataLink.SetControlPreventsEditing( AValue: boolean );
begin
  if ControlPreventsEditing <> AValue then
  begin
    FControlPreventsEditing := AValue;
    SysStateChanged;
  end;
end;

procedure TIB_ControlDataLink.SetControlPreventsInserting( AValue: boolean );
begin
  if ControlPreventsInserting <> AValue then
  begin
    FControlPreventsInserting := AValue;
    SysStateChanged;
  end;
end;

procedure TIB_ControlDataLink.SetControlPreventsSearching( AValue: boolean );
begin
  if ControlPreventsSearching <> AValue then
  begin
    FControlPreventsSearching := AValue;
    SysStateChanged;
  end;
end;

{                                                                              }

function TIB_ControlDataLink.GetSearchEntryName: string;
begin
  if not Assigned( Control ) then
    Result := ''
  else if not Assigned( Control.Owner ) then
    Result := 'CTL.' + Control.Name
  else
    Result := 'CTL.' + Control.Owner.Name + '.' + Control.Name;
end;

function TIB_ControlDataLink.GetSearchBuffer: string;
begin
  if ( State = dssSearch ) and ControlIsModified and not UpdatingRecord then
    SysUpdateData( nil );
  Result := inherited GetSearchBuffer;
end;

function TIB_ControlDataLink.GetReadOnly: boolean;
begin
  Result := ControlIsReadOnly or inherited GetReadOnly;
  if not Result and Assigned( Control ) then
    Result := not Control.Enabled;
  if not Result then
  begin
    if SearchAlways or ( State = dssSearch ) then
      Result := ControlPreventsSearching
    else
      if ( State = dssBrowse ) and
         (( ControlPreventsEditing and ( RowState <> rsNone )) or
          ( ControlPreventsInserting and ( RowState = rsNone ))) then
        Result := true;
  end;
end;

function TIB_ControlDataLink.GetPreventDeleting: boolean;
begin
  Result := ControlPreventsDeleting or inherited GetPreventDeleting;
end;

function TIB_ControlDataLink.GetPreventEditing: boolean;
begin
  Result := ControlPreventsEditing or inherited GetPreventEditing;
end;

function TIB_ControlDataLink.GetPreventInserting: boolean;
begin
  Result := inherited GetPreventInserting or ControlPreventsInserting;
end;

function TIB_ControlDataLink.GetPreventSearching: boolean;
begin
  Result := inherited GetPreventSearching or ControlPreventsSearching;
end;

function TIB_ControlDataLink.GetInvalidColor: TColor;
begin
  if Assigned(Control) and ( csDesigning in Control.ComponentState ) then
    Result := clWindow
  else
    Result := inherited GetInvalidColor;
end;

procedure TIB_ControlDataLink.SysDataChange( AField: TIB_Column );
begin
  inherited SysDataChange( AField );
  if ControlIsModified then
    ControlIsModified := false;
end;

procedure TIB_ControlDataLink.SysUpdateData( AField: TIB_Column );
begin
  if ControlIsModified then
  begin
    inherited SysUpdateData( AField );
    if ControlIsModified then
      ControlIsModified := false;
  end;
end;

procedure TIB_ControlDataLink.SysBindingChanged;
begin
  inherited SysBindingChanged;
  if Assigned( Control ) then
    Control.Invalidate;
end;

{$ENDIF}

{------------------------------------------------------------------------------}

function TIB_FieldDataLink.GetField: TIB_Column;
begin
  Result := FField;
end;

function TIB_FieldDataLink.FieldIsValidChar( AKey: char ): boolean;
begin
  Result := ( Field <> nil ) and Prepared and
            ( ( State = dssSearch ) or
              SearchAlways or
              Field.IsValidChar( AKey ));
end;

function TIB_FieldDataLink.Modify: boolean;
begin
  if ( State = dssSearch ) or SearchAlways then
    Result := not PreventSearching
  else
    Result := IsParamEdit or inherited Modify;
end;

function TIB_FieldDataLink.IsParamEdit: boolean;
begin
  Result := (Length(FParamName) > 0);
end;
procedure TIB_FieldDataLink.SetFieldText( AValue: string );
begin
  if IsParamEdit then
    Field.AsString := AValue
  else
  if ( State = dssSearch ) or SearchAlways then
    SearchBuffer := AValue
  else
    case State of
      dssEdit,
      dssInsert: Field.AsString := AValue;
    end;
end;

function TIB_FieldDataLink.GetFieldText: string;
begin
  if not Assigned( Field ) or not Prepared then
    Result := GetInvalidText
  else
  if IsParamEdit then
  begin
    if Assigned( Control ) and
       Control.Focused then
      Result := Field.AsString
    else
      Result := Field.DisplayText;
  end
  else if ( State = dssSearch ) or SearchAlways then
    Result := AdvSearchDisplay
  else
  begin
    case State of
      dssPrepared,
      dssBrowse,
      dssEdit,
      dssInsert,
      dssDelete: if ( Dataset.Fields.RowState <> rsNone ) then
      begin
        with Field do
        begin
          if Assigned( Control ) and
             Control.Focused and
             not ControlsReadOnly and
             not (( State = dssBrowse ) and PreventEditing ) then
          begin
            if IsBlob and ( not IsLoaded or not IsText ) then
              Result := '( ' + DisplayName + ' )'
            else
              Result := AsString;
          end
          else
            Result := DisplayText;
        end;
      end
      else
        Result := '';
    end;
  end;
end;

function TIB_FieldDataLink.GetInvalidText: string;
begin
  if ( csDesigning in ComponentState ) and
     ( State = dssInactive ) and
     Assigned( Control ) then
    Result := Control.Name
  else
    Result := FInvalidText;
end;

procedure TIB_FieldDataLink.SetInvalidText( AValue: string );
begin
  if FInvalidText <> AValue then
  begin
    FInvalidText := AValue;
    if not Assigned( Field ) or not Prepared then
      SysDataChange( nil );
  end;
end;

function TIB_FieldDataLink.GetFieldAlignment: TAlignment;
begin
  if not Assigned( Field ) or
     not Prepared or
     ( State = dssSearch ) or
     SearchAlways then
    Result := taLeftJustify
  else
    Result := Field.Alignment;
end;

function TIB_FieldDataLink.GetFieldCharCase: TIB_CharCase;
begin
  if not Assigned( Field ) or not Prepared then
    Result := ccNormal
  else
    Result := Field.CharCase;
end;

function TIB_FieldDataLink.GetFieldEditMask: string;
begin
  if Assigned( Field ) and
     (( State in [ dssBrowse,
                   dssEdit,
                   dssInsert,
                   dssDelete ] ) or
      ((( State = dssSearch ) or SearchAlways ) and SearchWithMask ) or
        IsParamEdit ) then
    Result := Field.EditMask
  else
    Result := '';
end;

function TIB_FieldDataLink.GetFieldMaxLength: integer;
begin
  if not Assigned( Field ) or
     not Prepared or
     ( State = dssSearch ) or
     SearchAlways then
    Result := 0
  else
  if ( Field.SQLType = SQL_Varying  ) or
     ( Field.SQLType = SQL_Varying_ ) or
     ( Field.SQLType = SQL_Text     ) or
     ( Field.SQLType = SQL_Text_    ) then
    Result := Field.SQLLen
  else
    Result := 0;
end;

function TIB_FieldDataLink.GetReadOnly: boolean;
begin
  if IsParamEdit then
    Result := false
  else
    Result := not Assigned( Field ) or
            ( Field.ControlsReadOnly and
              ( State <> dssSearch ) and
              not SearchAlways ) or
            inherited GetReadOnly;
  if not Result then case State of
    dssEdit: Result := Field.IsAttributeSet[ 'NOEDIT' ];
    dssInsert: Result := Field.IsAttributeSet[ 'NOINSERT' ];
    dssSearch: Result := Field.IsAttributeSet[ 'NOSEARCH' ];
  end;
end;

function TIB_FieldDataLink.GetColor: TColor;
begin
  if not Prepared or not Assigned( Field ) then
    Result := GetInvalidColor
  else
  if ( State = dssSearch ) or SearchAlways or IsParamEdit then
    Result := GetSearchingColor
  else
    Result := inherited GetColor;
end;

function TIB_FieldDataLink.GetEditingColor: TColor;
begin
  if Field.IsNull then
    Result := inherited GetEditingColor // or clSilver;
  else
    Result := inherited GetEditingColor;
end;

function TIB_FieldDataLink.GetInsertingColor: TColor;
begin
  if Field.IsNull then begin
    Result := inherited GetInsertingColor; // or clSilver;
  end else begin
    Result := inherited GetInsertingColor;
  end;
end;

function TIB_FieldDataLink.GetPreventEditing: boolean;
begin
  Result := inherited GetPreventEditing or not Assigned( Field ) or
            Field.PreventEditing;
end;

function TIB_FieldDataLink.GetPreventInserting: boolean;
begin
  Result := inherited GetPreventInserting or not Assigned( Field ) or
            Field.PreventInserting;
end;

function TIB_FieldDataLink.GetPreventSearching: boolean;
begin
  Result := inherited GetPreventSearching or not Assigned( Field ) or
            Field.PreventSearching;
end;

{ not required after intro of GetField function in base
procedure TIB_FieldDataLink.SetSearchBuffer( AValue: string );
begin
  if SearchBuffer <> AValue then begin
    FSearchBuffer := AValue;
    if Dataset <> nil then begin
      Dataset.InvalidateSQL;
    end;
    if State = dssSearch then begin
      SysDataChange( Field );
    end;
  end;
end; }

procedure TIB_FieldDataLink.SetSearchWithMask( AValue: boolean );
begin
  if SearchWithMask <> AValue then begin
    FSearchWithMask := AValue;
    if ( State = dssSearch ) then begin
      SysStateChanged;
    end;
  end;
end;

procedure TIB_FieldDataLink.SysBindingChanged;
begin
  SysAssignField;
  inherited SysBindingChanged;
end;

{------------------------------------------------------------------------------}

procedure TIB_FieldDataLink.DoAfterAssignment;
begin
  SysAssignField;
  inherited DoAfterAssignment;
end;

procedure TIB_FieldDataLink.SetFieldName( AValue: string );
begin
  FFieldName := AValue;
  SysAssignField;
end;

procedure TIB_FieldDataLink.SetParamName( AValue: string );
begin
  FParamName := AValue;
  SysAssignField;
end;

procedure TIB_FieldDataLink.SysDataChange( AField: TIB_Column );
begin
  if not Assigned( AField ) or ( AField = Field ) then
  begin
    if Assigned( BlobField ) then
    begin
      if BoundToBuffer or
         ControlIsModified or
         ( BlobField.IsNull ) or
         ( BlobField.BlobID.isc_quad_high = 0 ) or
         ( BlobID.isc_quad_high = 0 ) or
         ( not isc_quad_equal( BlobID, BlobField.BlobID )) then
      begin
        if BlobField.IsNull then
          FBlobID := BlankQuad
        else
          FBlobID := BlobField.BlobID;
        inherited SysDataChange( Field );
      end;
    end
    else
      inherited SysDataChange( Field );
  end;
end;

procedure TIB_FieldDataLink.SysUpdateData( AField: TIB_Column );
begin
  if ( ControlIsModified or ( State = dssSearch ) or SearchAlways ) and
     (( AField = nil ) or ( AField = Field )) then
    inherited SysUpdateData( Field );
end;

procedure TIB_FieldDataLink.SysLayoutChanged;
begin
  inherited SysLayoutChanged;
  SysStateChanged;
  SysDataChange( nil );
end;

procedure TIB_FieldDataLink.SysAssignField;
var
  OldField: TIB_Column;
  NewField: TIB_Column;
begin
  OldField := Field;
  if Dataset <> nil then
  begin
    if IsParamEdit then
      Dataset.Params.GetByName( ParamName, NewField )
    else
    begin
      if BoundToBuffer then
        Dataset.BufferFields.GetByName( FieldName, NewField )
      else
        Dataset.Fields.GetByName( FieldName, NewField );
    end;
  end
  else
    NewField := nil;
  if OldField <> NewField then
  begin
    if Assigned( NewField ) and ControlIsModified then
      SysUpdateData( Field );
    DoBeforeAssignment;
    FField := NewField;
    if FField is TIB_ColumnBlob then
      FBlobField := FField as TIB_ColumnBlob
    else
      FBlobField := nil;
    FBlobID := BlankQuad;
    inherited // Avoid infinite loop when columns are named the same.
    DoAfterAssignment;
    DoAssignField;
  end;
end;

procedure TIB_FieldDataLink.DoAssignField;
begin
  if not ( csLoading in ComponentState ) and
     not ( csDestroying in ComponentState ) then
  begin
    if Assigned( OnAssignField ) then
      OnAssignField( Self, DataSource, Field )
    else
    begin
      SysStateChanged;
      SysDataChange( Field );
    end;
  end;
end;

procedure TIB_FieldDataLink.DoPrepareSQL;
var
  tmpS: string;
begin
  if Assigned( OnPrepareSQL ) then
    inherited DoPrepareSQL
  else
  if Assigned( Dataset ) then
    with Dataset do
      if ( SearchBuffer <> '' ) and Assigned( Field ) then
      begin
        tmpS := SearchBuffer;
        if SearchWithMask then
          tmpS := mkLitCriteria( tmpS, '''' );
        ExtractWhereClause( Field,
                            tmpS,
                            SQLWhereItems,
                            ParamValueLinks,
                            nil {MacroValueLinks} );
      end;
end;

procedure TIB_FieldDataLink.UpdateData;
begin
  if Assigned( Field ) then
    inherited SysUpdateData( Field );
end;

procedure TIB_FieldDataLink.FocusControl( AField: TIB_ColumnRef );
begin
  if Assigned( AField^ ) and (AField^ = Field) and
     Assigned( Control ) and Control.CanFocus then
    try
      Control.SetFocus;
      AField^ := nil;
    except
      on E: Exception do
        Application.HandleException( E );
    end;
end;

procedure TIB_FieldDataLink.ProcessStatementEvent
  ( AEvent: TIB_StatementEventType; Info: longint );
begin
  if IsParamEdit then
  begin
    case AEvent of
      setParamsRefsChanged, setParamsStateChanged:
      begin
        if (Info = 0) or (Field = TIB_Column(Info)) then
        begin
          SysAssignField;
          SysStateChanged;
        end;
      end;
      setParamsUpdateData:
      begin
        if (Info = 0) or (Field = TIB_Column(Info)) then
          SysUpdateData( TIB_Column(Info) );
      end;
      setParamsDataChange:
      begin
        if (Info = 0) or (Field = TIB_Column(Info)) then
          SysDataChange( TIB_Column(Info) );
      end;
    else
      if not (AEvent in [setFieldsDataChange, //setFieldsStateChanged, 
        setFieldsUpdateData //, setFieldsRefsChanged
        ]) then
        inherited;
    end;
  end
  else
    inherited;
end;

end.

