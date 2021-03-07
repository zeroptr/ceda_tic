
{                                                                              }
{ IB_SearchPanel                                                               }
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
{   Zoltan Korponai < rhollay@mail.com >                                       }
{   10/27/2001                                                                 }
{                                                                              }
{   new variables:   dwidth_max, lwidth_max1, lwidth_max2: integer             }
{                                                                              }
{   - a bug concerning the label's positions is fixed;                         }
{   - if the dataset is changed at runtime, the old labels are cleared;        }
{   - if DualColumn = True, then the control's positions are optimized         }
{     on the panel;                                                            }
{   - if EditWidth >= 0 then all the controls on the panel will have this      }
{     EditWidth;                                                               }
{     If EditWidth < 0 then the controls will have their corresponding         }
{     DisplayWidth, set at the dataset level;                                  }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the IB_SearchPanel component.}
unit
  IB_SearchPanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,

  IB_Constants,
  IB_Components,
{$IFDEF IBO4_BETA}
  IB_FieldDataLink,
{$ENDIF}
  IB_Controls;

type
{: This component provides a quick way to present a user with a list of edit
fields that can be used to search, browse, insert or update data.
<br><br>
It will show all fields of the dataset whether the columns are set to be
visible or not unless ShowVisibleFieldsOnly is set to true.
<br><br>
If the BOOLEAN attribute is set for columns it will use a TIB_CheckBox control
for those columns.
<br><br>
If the NOTIME attribute is set for date columns it will use a TIB_Date control
for those columns.}
TIB_SearchPanel = class(TScrollBox)
private
  FIB_DataLink: TIB_ControlDataLink;
  CursorLabelList: TList;
  CursorEditList: TList;
  CursorChkBoxList: TList;
  CursorDateList: TList;
  FieldList: TList;
  FEditWidth: integer;
  FEditLeft: integer;
  FDualColumn: boolean;
  FSpaceWidth: integer;
  FLineHeight: integer;
  FSpaceHeight: integer;
  FTopMargin: integer;
  FLeftMargin: integer;
  FPreventEditing: TIB_StringList;
  FPreventInserting: TIB_StringList;
  FPreventSearching: TIB_StringList;
  FGridLinks: TIB_StringList;
  FShowVisibleFieldsOnly: boolean;
  FMaxCols: integer;
  procedure SetGridLinks( AValue: TIB_StringList );
  procedure SetPreventEdit( AValue: TIB_StringList );
  procedure SetPreventInsert( AValue: TIB_StringList );
  procedure SetPreventSearch( AValue: TIB_StringList );
  procedure SetEditWidth( AValue: integer );
  procedure SetEditLeft( AValue: integer );
  procedure SetDualColumn( AValue: boolean );
  procedure SetSpaceWidth( AValue: integer );
  procedure SetLineHeight( AValue: integer );
  procedure SetSpaceHeight( AValue: integer );
  procedure SetTopMargin( AValue: integer );
  procedure SetLeftMargin( AValue: integer );
  procedure PreparedChanged( Sender: TIB_DataLink;
                             DataSource: TIB_DataSource);
  procedure StateChanged( Sender: TIB_DataLink;
                          DataSource: TIB_DataSource);
  procedure SetDataSource( AValue: TIB_DataSource );
  procedure SetShowVisibleFieldsOnly( AValue: boolean );
  function GetDataSource: TIB_DataSource;
  procedure WMSize(var Message: TWMSize); message WM_SIZE;
  procedure CtrlKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  procedure CtrlKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
  procedure CtrlKeyPress( Sender: TObject; var Key: char );
protected
  procedure StringsChanged( AObject: TObject );
  procedure SysUpdate;
{$IFDEF IBO_VCL30_OR_GREATER}
  procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
{$ELSE}
  procedure GetChildren(Proc: TGetChildProc ); override;
{$ENDIF}
public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
published
{: Reference to the datasource that this control is bound to.}
  property DataSource: TIB_DataSource read GetDataSource write SetDataSource;
{: The width of the edit boxes used for data entry.
<br><br>
If it is set to a negative number then it will align the controls to the
corresponding field's DisplayWidth wich is set at the dataset level. }
  property EditWidth: integer read FEditWidth write SetEditWidth default 300;
  property EditLeft: integer read FEditLeft write SetEditLeft;
  property DualColumn: boolean read FDualColumn write SetDualColumn;
{: An alternative list and order of columns to be included in the grid.}
  property GridLinks: TIB_StringList read FGridLinks write SetGridLinks;
{: This width of the space between the lables and edit boxes.}
  property SpaceWidth: integer read FSpaceWidth write SetSpaceWidth default 6;
{: The height of each line. This means the height of the edit boxes.}
  property LineHeight: integer read FLineHeight
                               write SetLineHeight default 21;
{: This property is used to keep the list of columns from becomming too great.
<br><br>
By default it is 0 to indicate that no limit should be imposed.}
  property MaxCols: integer read FMaxCols write FMaxCols default 0;
{: When not using GridLinks this determins whether or not fields that are
not visible will still appear in the list of controls.
<br><br>
I use this because inconjunctions with a TIB_Grid I may want all columns to
appear in here but not necessarily in the IB_Grid control.}
  property ShowVisibleFieldsOnly: boolean read FShowVisibleFieldsOnly
                                          write SetShowVisibleFieldsOnly
                                          default false;
{: The height of the space between each edit box.}
  property SpaceHeight: integer read FSpaceHeight
                                write SetSpaceHeight default 4;
{: The height of the space from the top of the control to the first edit box.}
  property TopMargin: integer read FTopMargin
                              write SetTopMargin default 6;
{: The width of the space between the left edge and the lables.}
  property LeftMargin: integer read FLeftMargin
                               write SetLeftMargin default 8;
{: Make the controls not allow editing to be performed when in dssEdit state.}
  property PreventEditing: TIB_StringList read FPreventEditing
                                          write SetPreventEdit;
{: Make the controls not allow editing to be performed when in dssInsert state.}
  property PreventInserting: TIB_StringList read FPreventInserting
                                            write SetPreventInsert;
{: Make the controls not allow editing to be performed when in dssSearch state.}
  property PreventSearching: TIB_StringList read FPreventSearching
                                            write SetPreventSearch;
end;

implementation

constructor TIB_SearchPanel.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FIB_DataLink := TIB_ControlDataLink.Create( Self );
  with FIB_DataLink do begin
    Control := Self;
    OnPreparedChanged := PreparedChanged;
    OnStateChanged := StateChanged;
    AfterAssignment := PreparedChanged;
  end;
  FGridLinks := TIB_StringProperty.Create;
  FPreventEditing := TIB_StringProperty.Create;
  FPreventInserting := TIB_StringProperty.Create;
  FPreventSearching := TIB_StringProperty.Create;
  FGridLinks.OnChange := StringsChanged;
  FPreventEditing.OnChange := StringsChanged;
  FPreventInserting.OnChange := StringsChanged;
  FPreventSearching.OnChange := StringsChanged;
  CursorLabelList := TList.Create;
  CursorEditList := TList.Create;
  CursorChkBoxList := TList.Create;
  CursorDateList := TList.Create;
  FieldList := TList.Create;
  FEditWidth := 300;
  FSpaceWidth := 6;
  FLineHeight := 21;
  FSpaceHeight := 4;
  FTopMargin := 6;
  FLeftMargin := 8;
end;

destructor TIB_SearchPanel.Destroy;
begin
  DataSource := nil;
  CursorLabelList.Free;
  CursorEditList.Free;
  CursorChkBoxList.Free;
  CursorDateList.Free;
  FieldList.Free;
  FGridLinks.Free;
  FPreventEditing.Free;
  FPreventInserting.Free;
  FPreventSearching.Free;
  CursorLabelList := nil;
  CursorEditList := nil;
  CursorChkBoxList := nil;
  CursorDateList := nil;
  FieldList := nil;
  FGridLinks := nil;
  FPreventEditing := nil;
  FPreventInserting := nil;
  FPreventSearching := nil;
  inherited Destroy;
end;

procedure TIB_SearchPanel.CtrlKeyDown(     Sender: TObject;
                                       var Key: Word;
                                           Shift: TShiftState );
begin
  if Assigned( OnKeyDown ) then
    OnKeyDown( Sender, Key, Shift );
  if ( FIB_DataLink.State = dssSearch ) and
     (( Key = VK_RETURN ) and ( Shift = [] )) then
  begin
    FIB_DataLink.DataSet.Post;
    Key := 0;
  end;
end;

procedure TIB_SearchPanel.CtrlKeyUp(     Sender: TObject;
                                     var Key: Word;
                                         Shift: TShiftState );
begin
  if Assigned( OnKeyUp ) then
    OnKeyUp( Sender, Key, Shift );
end;

procedure TIB_SearchPanel.CtrlKeyPress( Sender: TObject; var Key: char );
begin
  if Assigned( OnKeyPress ) then
    OnKeyPress( Sender, Key );
end;

function TIB_SearchPanel.GetDataSource: TIB_DataSource;
begin
  Result := FIB_DataLink.DataSource;
end;

procedure TIB_SearchPanel.SetDataSource( AValue: TIB_DataSource );
begin
  FIB_DataLink.DataSource := AValue;
end;

procedure TIB_SearchPanel.StateChanged( Sender: TIB_DataLink;
                                        DataSource: TIB_DataSource);
var
  ii: integer;
  tmpCtl: TWinControl;
  tmpDL: TIB_DataLink;
begin
  for ii := 0 to ControlCount - 1 do
    if Controls[ii] is TWinControl then
    begin
      tmpCtl := TWinControl(Controls[ii]);
      tmpDL := TIB_DataLink( tmpCtl.Perform( CM_GETDATALINK, 0, 0 ));
      tmpCtl.TabStop := Assigned( tmpDL ) and not tmpDL.ReadOnly;
    end;
  SysUpdate;
end;

procedure TIB_SearchPanel.PreparedChanged( Sender: TIB_DataLink;
                                           DataSource: TIB_DataSource);
begin
  SysUpdate;
end;

procedure TIB_SearchPanel.SysUpdate;
var
  ii: integer;
  tmpLabel: TLabel;
  tmpCtl: TWinControl;
  tmpEdit: TIB_Edit;
  cntEdit: integer;
  cntChkBox: integer;
  cntDate: integer;
  tmpChkBox: TIB_CheckBox;
  tmpDate: TIB_CustomEdit;
  LabelWidth: integer;
//  tmpWidth: integer;
  tmpFld: TIB_Column;
  ii_c,
  col_offset,
  col1_offset: integer;
  dwidth_max: integer;
  lwidth_max1: integer;
  lwidth_max2: integer;

  done: boolean;
  tmpDL: TIB_DataLink;
begin
  LabelWidth := 0;
	for ii := 0 to CursorLabelList.Count - 1 do
		TLabel(CursorLabelList.Items[ ii ]).Caption := '';
	CursorLabelList.Clear;
  if FIB_DataLink.Prepared then
  begin
    with FIB_DataLink.Dataset do
    begin
      cntEdit := 0;
      cntDate := 0;
      cntChkBox := 0;
      if GridLinks.Count > 0 then
        GetFieldList( FieldList, GridLinks.CommaText )
      else
      if ShowVisibleFieldsOnly then
      begin
        FieldList.Clear;
        try
          if GridLinks.Count > 0 then
          begin
            for ii := 0 to GridLinks.Count - 1 do
            begin
              tmpFld := FindField( GridLinks[ ii ] );
              if Assigned( tmpFld ) then
                FieldList.Add( tmpFld );
            end;
          end
          else
          for ii := 0 to FieldCount - 1 do
          begin
            tmpFld := Fields[ ii ];
            if tmpFld.Visible then
              FieldList.Add( tmpFld );
          end;
        except
          FieldList.Clear;
          raise;
        end;
      end
      else
        GetFieldList( FieldList, '' );
      if MaxCols > 0 then
        while FieldList.Count > MaxCols do
          FieldList.Delete( FieldList.Count - 1 );
			dwidth_max := 0;
			lwidth_max1 := 0;
			lwidth_max2 := 0;
      for ii := 0 to FieldList.Count - 1 do
      begin
        with TIB_Column( FieldList[ ii ] ) do
        begin
          if ii >= CursorLabelList.Count then
          begin
            tmpLabel := TLabel.Create( Self );
            CursorLabelList.Add( tmpLabel );
            tmpLabel.Visible := false;
            tmpLabel.Parent := Self;
            tmpLabel.AutoSize := true;
          end else
          begin
            tmpLabel := TLabel( CursorLabelList.Items[ ii ] );
          end;
          if IsBoolean then
          begin
            if cntChkBox >= CursorChkBoxList.Count then
            begin
              tmpChkBox := TIB_CheckBox.Create( Self );
              tmpChkBox.DisplayLabelAsCaption := true;
              tmpChkBox.OnKeyDown := CtrlKeyDown;
              tmpChkBox.OnKeyPress := CtrlKeyPress;
              tmpChkBox.OnKeyUp := CtrlKeyUp;
              tmpChkBox.Name := 'cb' + Self.Name + '_' + IntToStr( cntChkBox );
              tmpChkBox.Visible := false;
              tmpChkBox.Parent := Self;
              CursorChkBoxList.Add( tmpChkBox );
            end else
            begin
              tmpChkBox := TIB_CheckBox( CursorChkBoxList.Items[ cntChkBox ] );
            end;
            tmpChkBox.DataField := FieldName;
            tmpChkBox.DataSource := DataSource;
            tmpChkBox.PreventInserting := IsAttributeSet[ IB_NOINSERT ] or
                          ( Self.PreventInserting.LinkIndex[ FieldName ] >= 0 );
            tmpChkBox.PreventEditing   := IsAttributeSet[ IB_NOEDIT ] or
                          ( Self.PreventEditing.LinkIndex[ FieldName ] >= 0 );
            tmpChkBox.PreventSearching := IsAttributeSet[ IB_NOSEARCH ] or
                          ( Self.PreventSearching.LinkIndex[ FieldName ] >= 0 );
            tmpCtl := tmpChkBox;
            Inc( cntChkBox );
          end else if IsDateTime then
          begin
            if cntDate >= CursorDateList.Count then
            begin
              if IsAttributeSet[ IB_NOTIME ] then
              begin
                tmpDate := TIB_Date.Create( Self );
                TIB_Date(tmpDate).OnKeyDown := CtrlKeyDown;
                TIB_Date(tmpDate).OnKeyPress := CtrlKeyPress;
                TIB_Date(tmpDate).OnKeyUp := CtrlKeyUp;
              end else
              begin
                tmpDate := TIB_Edit.Create( Self );
                TIB_Edit(tmpDate).OnKeyDown := CtrlKeyDown;
                TIB_Edit(tmpDate).OnKeyPress := CtrlKeyPress;
                TIB_Edit(tmpDate).OnKeyUp := CtrlKeyUp;
              end;
              tmpDate.Name := 'dt' + Self.Name + '_' + IntToStr( cntDate );
              tmpDate.Visible := false;
              tmpDate.Parent := Self;
              CursorDateList.Add( tmpDate );
            end else
            begin
              tmpDate := TIB_CustomEdit( CursorDateList.Items[ cntDate ] );
            end;
            tmpDate.DataField := FieldName;
            tmpDate.DataSource := DataSource;
            tmpDate.PreventInserting := IsAttributeSet[ IB_NOINSERT ] or
                          ( Self.PreventInserting.LinkIndex[ FieldName ] >= 0 );
            tmpDate.PreventEditing := IsAttributeSet[ IB_NOEDIT ] or
                          ( Self.PreventEditing.LinkIndex[ FieldName ] >= 0 );
            tmpDate.PreventSearching := IsAttributeSet[ IB_NOSEARCH ] or
                          ( Self.PreventSearching.LinkIndex[ FieldName ] >= 0 );
            tmpCtl := tmpDate;
            Inc( cntDate );
          end else
          begin
            if cntEdit >= CursorEditList.Count then
            begin
              tmpEdit := TIB_Edit.Create( Self );
              tmpEdit.Name := 'ed' + Self.Name + '_' + IntToStr( cntEdit );
              tmpEdit.Visible := false;
              tmpEdit.Parent := Self;
              tmpEdit.OnKeyDown := CtrlKeyDown;
              tmpEdit.OnKeyPress := CtrlKeyPress;
              tmpEdit.OnKeyUp := CtrlKeyUp;
              CursorEditList.Add( tmpEdit );
            end else
            begin
              tmpEdit := TIB_Edit( CursorEditList.Items[ cntEdit ] );
            end;
            tmpEdit.DataField := FieldName;
            tmpEdit.DataSource := DataSource;
            tmpEdit.PreventInserting := IsAttributeSet[ IB_NOINSERT ] or
                          ( Self.PreventInserting.LinkIndex[ FieldName ] >= 0 );
            tmpEdit.PreventEditing := IsAttributeSet[ IB_NOEDIT ] or
                          ( Self.PreventEditing.LinkIndex[ FieldName ] >= 0 );
            tmpEdit.PreventSearching := IsAttributeSet[ IB_NOSEARCH ] or
                          ( Self.PreventSearching.LinkIndex[ FieldName ] >= 0 );
            tmpCtl := tmpEdit;
            Inc( cntEdit );
          end;
          tmpDL := TIB_DataLink( tmpCtl.Perform(CM_GETDATALINK,0,0));
          tmpCtl.TabStop := Assigned( tmpDL ) and
                                (( not tmpDL.ReadOnly or
                                 ( tmpDL.State = dssSearch ) and
                                  not tmpDL.PreventSearching ));
          tmpLabel.Caption := DisplayLabel;
          if ( tmpLabel.Width > LabelWidth ) and not IsBoolean then
          begin
            LabelWidth := tmpLabel.Width;
          end;
					if ii <= ((FieldList.Count - 1) div 2) then begin
          	if DisplayWidth > dwidth_max then
              dwidth_max := DisplayWidth;
            if LabelWidth > lwidth_max1 then
              lwidth_max1 := LabelWidth;
					end else
           if LabelWidth > lwidth_max2 then lwidth_max2 := LabelWidth;
        end;
      end;
      cntEdit := 0;
      cntDate := 0;
      cntChkBox := 0;
      col_offset := 0;
      col1_offset := 0;
      done := True;
      ii_c := -1;
      if DualColumn then
      begin
        done := false;
        if EditWidth < 0 then
					col1_offset := dwidth_max + lwidth_max2 + SpaceWidth + LeftMargin
				else
					col1_offset := EditWidth + lwidth_max2 + SpaceWidth + LeftMargin;
      end;
      for ii := 0 to FieldList.Count - 1 do
      begin
        inc( ii_c );
        if not done then if ii_c > (( FieldList.Count - 1 ) div 2 ) then
        begin
          done := true;
          ii_c := 0;
          col_offset := col1_offset;
        end;
        with TIB_Column( FieldList[ ii ] ) do
        begin
          tmpLabel := TLabel( CursorLabelList.Items[ ii ] );
          tmpLabel.Top := ii_c * ( LineHeight + SpaceHeight ) + TopMargin;
          tmpLabel.Left := LeftMargin + col_offset;
          if IsBoolean then
          begin
            tmpCtl := TWinControl( CursorChkBoxList.Items[ cntChkBox ] );
            Inc( cntChkBox );
          end
          else if IsDateTime then
          begin
            tmpCtl := TWinControl( CursorDateList.Items[ cntDate ] );
            Inc( cntDate );
          end
          else
          begin
            tmpCtl := TWinControl( CursorEditList.Items[ cntEdit ] );
            Inc( cntEdit );
          end;
          tmpCtl.Top := ii_c * ( LineHeight + SpaceHeight ) + TopMargin;
          if EditLeft > 0 then
          begin
            tmpCtl.Left := EditLeft + col_offset;
          end
          else
          begin
            if DualColumn then
            begin
              if ii <= (( FieldList.Count - 1 ) div 2 ) then
                tmpCtl.Left := LeftMargin + lwidth_max1 + SpaceWidth + col_offset
              else
                tmpCtl.Left := LeftMargin + lwidth_max2 + SpaceWidth + col_offset
              end
            else
              tmpCtl.Left := LeftMargin + LabelWidth + SpaceWidth + col_offset;
          end;
          if EditWidth < 0 then
            tmpCtl.Width := DisplayWidth
          else
            tmpCtl.Width := EditWidth;
          tmpCtl.Height := LineHeight;
        end;
      end;
      cntEdit := 0;
      cntDate := 0;
      cntChkBox := 0;
      for ii := 0 to FieldList.Count - 1 do begin
        with TIB_Column( FieldList[ ii ] ) do begin
          TWinControl( CursorLabelList.Items[ ii ] ).Visible := not IsBoolean;
          if IsBoolean then begin
            tmpCtl := TWinControl( CursorChkBoxList.Items[ cntChkBox ] );
            inc( cntChkBox );
          end else if IsDateTime then begin
            tmpCtl := TWinControl( CursorDateList.Items[ cntDate ] );
            inc( cntDate );
          end else begin
            tmpCtl := TWinControl( CursorEditList.Items[ cntEdit ] );
            Inc( cntEdit );
          end;
          tmpCtl.Visible := true;
        end;
      end;
      for ii := cntDate to CursorDateList.Count - 1 do begin
        TWinControl( CursorDateList.Items[ ii ] ).Visible := false;
      end;
      for ii := cntChkBox to CursorChkBoxList.Count - 1 do begin
        TWinControl( CursorChkBoxList.Items[ ii ] ).Visible := false;
      end;
      for ii := cntEdit to CursorEditList.Count - 1 do begin
        TWinControl( CursorEditList.Items[ ii ] ).Visible := false;
      end;
    end;
  end else begin
    for ii := CursorLabelList.Count - 1 downto 0 do begin
      TWinControl( CursorLabelList.Items[ ii ] ).Visible := false;
    end;
    for ii := CursorEditList.Count - 1 downto 0 do begin
      TWinControl( CursorEditList.Items[ ii ] ).Visible := false;
    end;
    for ii := CursorDateList.Count - 1 downto 0 do begin
      TWinControl( CursorDateList.Items[ ii ] ).Visible := false;
    end;
    for ii := CursorChkBoxList.Count - 1 downto 0 do begin
      TWinControl( CursorChkBoxList.Items[ ii ] ).Visible := false;
    end;
  end;
end;

{$IFDEF IBO_VCL30_OR_GREATER}
procedure TIB_SearchPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
{$ELSE}
procedure TIB_SearchPanel.GetChildren(Proc: TGetChildProc );
{$ENDIF}
begin
end;

procedure TIB_SearchPanel.SetEditWidth( AValue: integer );
begin
  if EditWidth <> AValue then begin
    FEditWidth := AValue;
    SysUpdate;
  end;
end;
procedure TIB_SearchPanel.SetEditLeft( AValue: integer );
begin
  if EditLeft <> AValue then begin
    FEditLeft := AValue;
    SysUpdate;
  end;
end;
procedure TIB_SearchPanel.SetDualColumn( AValue: boolean );
begin
  if DualColumn <> AValue then begin
    FDualColumn := AValue;
    SysUpdate;
  end;
end;
procedure TIB_SearchPanel.SetSpaceWidth( AValue: integer );
begin
  if SpaceWidth <> AValue then begin
    FSpaceWidth := AValue;
    SysUpdate;
  end;
end;
procedure TIB_SearchPanel.SetLineHeight( AValue: integer );
begin
  if LineHeight <> AValue then begin
    FLineHeight := AValue;
    SysUpdate;
  end;
end;
procedure TIB_SearchPanel.SetSpaceHeight( AValue: integer );
begin
  if SpaceHeight <> AValue then begin
    FSpaceHeight := AValue;
    SysUpdate;
  end;
end;
procedure TIB_SearchPanel.SetTopMargin( AValue: integer );
begin
  if TopMargin <> AValue then begin
    FTopMargin := AValue;
    SysUpdate;
  end;
end;
procedure TIB_SearchPanel.SetLeftMargin( AValue: integer );
begin
  if LeftMargin <> AValue then begin
    FLeftMargin := AValue;
    SysUpdate;
  end;
end;

procedure TIB_SearchPanel.SetGridLinks( AValue: TIB_StringList );
begin
  FGridLinks.Text := AValue.Text;
end;

procedure TIB_SearchPanel.SetPreventEdit( AValue: TIB_StringList );
begin
  FPreventEditing.Text := AValue.Text;
end;

procedure TIB_SearchPanel.SetPreventInsert( AValue: TIB_StringList );
begin
  FPreventInserting.Text := AValue.Text;
end;

procedure TIB_SearchPanel.SetPreventSearch( AValue: TIB_StringList );
begin
  FPreventSearching.Text := AValue.Text;
end;

procedure TIB_SearchPanel.StringsChanged( AObject: TObject );
begin
  SysUpdate;
end;

procedure TIB_SearchPanel.WMSize(var Message: TWMSize);
begin
  inherited;
// do nothing
end;

procedure TIB_SearchPanel.SetShowVisibleFieldsOnly( AValue: boolean );
begin
  if FShowVisibleFieldsOnly <> AValue then begin
    FShowVisibleFieldsOnly := AValue;
    SysUpdate;
  end;
end;

end.

