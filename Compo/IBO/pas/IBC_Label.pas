
{                                                                              }
{ IBC_Label                                                                    }
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
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  10-Jan-2002                                                                 }
{     Improved autolabel model management when using IIB_GridWinControl        }
{     interface (automatic model label creation when necessary).               }
{     Introduced a new global variable IB_AutoLabel_PreventFlicker             }
{     See notes for online help generation.                                    }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  20-Dec-2001                                                                 }
{     Added ability to use new GetAutoLabel IIB_GridWinControl interface       }
{     method - so any control implementing the interface can be used as a      }
{     as a model for the AutoLabel.                                            }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  10-Aug-2001                                                                 }
{     Changed the GetIBControlColumn function so that it will return the       }
{     foreign key column of the main dataset if it can be determined.          }
{     This allows the processing to determine whether the label may need       }
{     to be made bold if the foreign key is required.                          }
{                                                                              }
{------------------------------------------------------------------------------}

// ***** TIB_Label ******
{ IBO-aware Label component by Tobias Giesen with amendments by Geoff Worboys

Based on an earlier TLabelEnh component this source has been donated to the
IBObjects library as a base for the AutoLabel capability.  Functionality has
now been separated so that the base enhancement functions can be found in
IBC_CustomLabel.pas (without IBO-awareness).  This unit defines a derivation
that is IBO-aware, in that it will display the field display name of a
control attached to the focuscontrol.
}

// ***** TIB_AutoLabel ******
{                                                                              }
{ Written January 2001 by Tobias Giesen (tobias@tgtools.de)                    }
{ With contributions from Geoff Worboys                                        }

(*

This component is used by TIB_Edit, TIB_LookupCombo etc. to implement an
automatic label.

ADDING the AutoLabel to an existing component (the hard way)
---------------------------------------------
1. Add to the classes private section:
  FAutoLabel:TIB_AutoLabel;

2. If not existing yet, add these:
  procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
  procedure StateChanged( Sender: TIB_DataLink;
                                DataSource: TIB_DataSource );
3. If it's a base class, add the following to the public section
  else to the published section
  property AutoLabel: TIB_AutoLabel read FAutoLabel write FAutoLabel;

4. Add this to the published section of the final component
  property AutoLabel;

To provide a maximum of design-time and run-time efficiency, a few lines
have to be added to an existing component as follows:

5. Into the constructor:
  FAutoLabel := TIB_AutoLabel.Create(self);
  // call inherited after AutoLabel create
  DataLink.OnStateChanged:=StateChanged;

6. Into the destructor:
  FAutoLabel.Free;

8. the WMWindowPosChanged routine:
procedure TIB_XXX.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if Assigned(AutoLabel) and
     not (csDestroying in ComponentState) and
     (Assigned(AutoLabel.theLabel) or (csDesigning in ComponentState)) then
     AutoLabel.Make;
  end;

9 the StateChanged routine:
procedure TIB_CustomEdit.StateChanged( Sender: TIB_DataLink;
                                             DataSource: TIB_DataSource );
begin
  if Assigned(AutoLabel) and
     not (csDestroying in ComponentState) and
     (Assigned(AutoLabel.theLabel) or (csDesigning in ComponentState)) then
     AutoLabel.Make;
  end;


ADDING the AutoLabel to an existing component (the easy way)
---------------------------------------------

Create the component using IBO provided includes and then perform
steps 5 & 6 above to construct and destroy the autolabel.
See IBC_Edit.* files in the IBO source for an example of how this is done.


*)
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IBC_Label;

interface

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  StdCtrls,

  IBC_CustomLabel,
  IB_Components,
  IB_FieldDataLink;

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
type

  TIB_AutoLabel = class;

//---------------------------------------------------------------------------
  TIB_Label = class(TIB_CustomLabel)
  private
    FAutoLabel: TIB_AutoLabel;
    FModelRefs: TList;
    FUseIBOLabel: boolean;
    FUseIBOBold: boolean;
    FCaptionInitialised: boolean;

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure Loaded; override;
    procedure SetUseIBOLabel(AVal: boolean);
    procedure SetUseIBOBold(AVal: boolean);
    function CheckCaptionInitialised: boolean;
    procedure DoGetLabel(var AText: string; const AFont: TFont); override;
    procedure DoModelPropertyChange; override;

    procedure AddModelRef(const AutoLabel: TIB_AutoLabel);
    procedure RemoveModelRef(const AutoLabel: TIB_AutoLabel);
    function ModelRefCount: integer;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property UseIBOLabel: boolean read FUseIBOLabel write SetUseIBOLabel default
      true;
    property UseIBOBold: boolean read FUseIBOBold write SetUseIBOBold default
      true;
    {$INCLUDE IBC_CustomLabel.pbl}
  end;                                  // TIB_Label

  TIB_AutoLabelKind = (albNone, albLeft, albTop);
  TIB_AutoLabelOptions = (albAlignToModel, albLowerCase, albOnlyFirstCharUpper,
    albBoldIfRequired, albDotLeader, albSuffixBeforeDots);
  TIB_AutoLabelOptionsSet = set of TIB_AutoLabelOptions;

  TIB_AutoLabel = class(TPersistent)
  private
    FKind: TIB_AutoLabelKind;
    FCaption: string;
    FSuffix: string;
    FRelativePosition: Integer;
    FMargin: Integer;
    FModel: TControl;
    FOptions: TIB_AutoLabelOptionsSet;
    FtheLabel: TIB_Label;
    FOwner: TWinControl;
    function IsKindStored: boolean;
    function IsSuffixStored: boolean;
    function IsPositionStored: boolean;
    function IsMarginStored: boolean;
    function IsOptionsStored: boolean;
  protected
    procedure CreateLabel;
    procedure DestroyLabel;
    procedure MakeLabel( CheckPreventFlag: boolean );
  public
    function GetModelLabel(MakeIt: boolean): TCustomLabel;
    procedure ModelChanged;
    procedure Make;
    constructor Create(AOwner: TWinControl);
    destructor Destroy; override;
    property theLabel: TIB_Label read FtheLabel;
    property Owner: TWinControl read FOwner;
  published
    procedure SetKind(const K: TIB_AutoLabelKind);
    procedure SetSuffix(const S: string);
    procedure SetCaption(const S: string);
    procedure SetRelativePosition(const P: Integer);
    procedure SetMargin(const P: Integer);
    procedure SetModel(const M: TControl);
    procedure SetOptions(const O: TIB_AutoLabelOptionsSet);
    property Kind: TIB_AutoLabelKind read FKind write SetKind
    stored IsKindStored;
    property Suffix: string read FSuffix write SetSuffix
    stored IsSuffixStored;
    property Caption: string read FCaption write SetCaption;
    property RelativePosition: Integer read FRelativePosition
    write SetRelativePosition
      stored IsPositionStored;
    property Margin: Integer read FMargin write SetMargin stored IsMarginStored;
    property Model: TControl read FModel write SetModel;
    property Options: TIB_AutoLabelOptionsSet read FOptions write SetOptions
    stored IsOptionsStored;
  end;

var
  IB_AutoLabel_DefaultKind: TIB_AutoLabelKind;
  IB_AutoLabel_DefaultSuffix: string;
  IB_AutoLabel_DefaultMargin: integer;
  IB_AutoLabel_DefaultPosition: Integer;
  IB_AutoLabel_DefaultOptions: TIB_AutoLabelOptionsSet;
  IB_AutoLabel_IgnoreZeroDefault: boolean;
{: Set true to prevent redraw flicker on autolabels.
<br>
Defaults to false, allowing all label updates to take place.<br>
<br>
In some configurations AutoLabels attached to controls can show some redraw
flicker (particularly when attached to detail datasets of master/detail
arrangements).  This cannot be easily avoided without stopping the labels
from updating when actually needed.  So instead this global variable has been
provided to allow you to take control of the problem within your own
project.<br>
<br>
For most projects you will be able to prevent unnecessary redrawing of the
autolabels simply by including the following line in the OnCreate event of
the main form (you will need IBC_Label in the uses clause):<br>
  IB_AutoLabel_PreventFlicker := true;<br>
<br>
However with the above change, if you make changes to dataset or connection
properties at runtime, then you may discover that the autolabels are not
updating as they should.  In such cases you may have to alter the section of
your code where you alter those properties so that:<br>
<br>
IB_AutoLabel_PreventFlicker := false;<br>
try<br>
 ...your code...<br>
finally<br>
IB_AutoLabel_PreventFlicker := true;<br>
end;<br>
<br>
This will allow all label update requests to take place while your code is
executed, but turn off unnecessary updates when you have finished.<br>
<br>
The above code is not required with direct changes to the AutoLabel itself,
as these will detect such changes and force the label to be updated.}
  IB_AutoLabel_PreventFlicker: boolean;

implementation

uses
  IB_ControlInterface,
  IB_Grid,
  IB_Parse,
  IB_Controls;

//---------------------------------------------------------------------------
// copied from IBA_Statement.IMP

function GetColAttrTxt(const ACol: TIB_Column;
  const AColStrings,
  AConStrings: TIB_StringList): string;
begin
  with ACol do
  begin
    Result := AColStrings.LinkValues[FullFieldName];
    if (Length(Result) = 0) and (AConStrings.Count > 0) then
    begin
      Result := AConStrings.LinkValues[FullFieldName];
      if (Length(Result) = 0) and
        (fetDomainName in Statement.IB_Connection.FieldEntryTypes) then
      begin
        Result := AConStrings.LinkValues[DomainName];
      end;
      if (Length(Result) = 0) and
        (fetSQLType in Statement.IB_Connection.FieldEntryTypes) then
      begin
        Result := AConStrings.LinkValues[SQLTypeSource];
      end;
    end;
  end;
end;
//---------------------------------------------------------------------------
// A couple of utility functions.  May want to move these to a more accessible
// location later.

// Locate the appropriate TIB_Column reference for a control
// (or return nil).  Always return most direct column that it can.

function GetIBControlColumn(AControl: TControl; var FldName: string):
  TIB_Column;
var
  DL: TIB_DataLink;
begin
  Result := nil;

  // Most controls should define CM_GETDATALINK...
  DL := TIB_DataLink(AControl.Perform(CM_GETDATALINK, 0, 0));
  if (DL <> nil) and (DL is TIB_FieldDataLink) then
  begin
    Result := TIB_FieldDataLink(DL).Field;
    FldName := TIB_FieldDataLink(DL).FieldName;
  end
  else
  begin
    // I wanted to use TIB_CustomCombo to be generic but I cannot
    // seem to get a hold of its DataSource.
    if AControl is TIB_LookupCombo then
      with AControl as TIB_LookupCombo do
      begin
        FldName := DisplayField;
        if Assigned(DataSource) and Assigned(DataSource.Dataset) then
          with DataSource.Dataset do
          begin
            if (KeyLinks.Count > 0) and Assigned(KeyDataset) then
            begin
              FldName := KeyLinks.IndexValues[KeyLinks.Count - 1];
              Result := KeyDataset.FindField( FldName );
              // Display name best to come from DisplayField if available
              FldName := DisplayField;
              if FldName = '' then
                FldName := OrderingLink;
            end
            else
            begin
              if not Fields.GetByName(DisplayField, Result) then
                Fields.GetByName(OrderingLink, Result);
              if FldName = '' then
                FldName := OrderingLink;
            end;
          end;
      end;
  end;
end;

// Find out if a column should be considered mandatory.
// Will only ever return true for TIB_Dataset columns, and only
// when the dataset is in dssEdit or dssInsert mode.
// Checks Nullable, Readonly and Required column properties and
// then looks to see if a DefaultValue has been assigned.
// Set IgnoreZero to true to ignore a "0" default value, which is
// often set for enumerations for aesthetic reasons.  (Boolean
// columns are exempted from the IgnoreZero processing.)

function IsIBColumnMandatory(ACol: TIB_Column; IgnoreZero: boolean): boolean;
var
  tmpStr: string;
begin
  Result := false;
  if (ACol.Statement is TIB_Dataset) and
    (TIB_Dataset(ACol.Statement).State in [dssEdit, dssInsert]) and
    (ACol.Required and not ACol.Readonly) then
  begin
    tmpStr := GetColAttrTxt(ACol, TIB_Dataset(ACol.Statement).DefaultValues,
      ACol.Statement.IB_Connection.DefaultValues);
    if Length(tmpStr) <= 0 then
      Result := true
    else
      if IgnoreZero and (not ACol.IsBoolean) and (tmpStr = '0') then
        Result := true;
  end;
end;

// Convert a raw "FieldName" property into text appropriate for display
// without any associated relation.

function IBFieldNameToDisplay(AFieldName: string): string;
var
  i: integer;
begin
  i := getLitSafePos('.', AFieldName, 1);
  if i > 0 then
    Result := Copy(AFieldName, i + 1, Length(AFieldName) - i)
  else
    Result := AFieldName;
  if Length(Result) > 0 then
    Result := stLitCriteria(Result);    // Remove dialect 3 quotes
end;

//---------------------------------------------------------------------------

constructor TIB_Label.Create(AOwner: TComponent);
begin
  FAutoLabel := nil;
  FModelRefs := nil;
  inherited Create(AOwner);
  FUseIBOLabel := true;
  FUseIBOBold := true;
  FCaptionInitialised := false;
end;

destructor TIB_Label.Destroy;
var
  TmpRef: TIB_AutoLabel;
begin
  while (FModelRefs <> nil) and (FModelRefs.Count > 0) do
  begin
    TmpRef := FModelRefs.Items[FModelRefs.Count - 1];
    FModelRefs.Delete(FModelRefs.Count - 1); // to be sure they go
    if TmpRef.GetModelLabel(false) = Self then
      TmpRef.Model := nil;
  end;
  if FModelRefs <> nil then
  begin
    FModelRefs.Free;
    FModelRefs := nil;
  end;
  inherited;
end;

// Implemented specifically to support AutoLabels with a model based on TLabel.
// In those instances the AutoLabel will pass its internal Label as a
// reference to the FreeNotification of the model TLabel.  Hence, we must
// pickup in here that we are part of an AutoLabel and reset the model
// property if the TLabel is removed.

procedure TIB_Label.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (FAutoLabel <> nil) and (Operation = opRemove) and
    (AComponent = FAutoLabel.Model) then
    FAutoLabel.Model := nil;
end;

procedure TIB_Label.Loaded;
begin
  inherited;
  DoModelPropertyChange;
end;
//---------------------------------------------------------------------------

procedure TIB_Label.SetUseIBOLabel(AVal: boolean);
begin
  if AVal <> FUseIBOLabel then
  begin
    FUseIBOLabel := AVal;
    if AutoSize then
      AdjustBounds;
    Invalidate;
    DoModelPropertyChange;
  end;
end;

//---------------------------------------------------------------------------

procedure TIB_Label.SetUseIBOBold(AVal: boolean);
begin
  if AVal <> FUseIBOBold then
  begin
    FUseIBOBold := AVal;
    if AutoSize then
      AdjustBounds;
    Invalidate;
    DoModelPropertyChange;
  end;
end;

// this is called by the autolabel so that the label gets a chance to
// validate when the status of FCaptionInitialised should be changed.
function TIB_Label.CheckCaptionInitialised: boolean;
var
  tmpCol: TIB_Column;
  tmpStr: string;
begin
  if FCaptionInitialised and Assigned(FocusControl) then
  begin
    tmpCol := GetIBControlColumn(FocusControl, tmpStr);
    FCaptionInitialised := Assigned(tmpCol);
  end;
  Result := FCaptionInitialised;
end;

//---------------------------------------------------------------------------

procedure TIB_Label.DoGetLabel(var AText: string; const AFont: TFont);
var
  tmpCol: TIB_Column;
  tmpStr: string;
  tmpIntf: IIB_GridWinControl;
begin
  if (not UseIBOLabel) or (FocusControl = nil) then
  begin
    if Assigned(FocusControl) then
    begin
      tmpCol := GetIBControlColumn(FocusControl, tmpStr);
      if Assigned(tmpCol) then
      begin
        // Get mandatory setting before we check for display column
        if UseIBOBold and
          IsIBColumnMandatory(tmpCol, IB_AutoLabel_IgnoreZeroDefault) then
          AFont.Style := AFont.Style + [fsBold];
      end;
    end;
    inherited;
    // If not UseIBOLabel then the caption is initialised (to whatever
    // is defined in the Caption property).
    FCaptionInitialised := true;
    Exit;
  end;

  tmpCol := GetIBControlColumn(FocusControl, tmpStr);

  if Assigned(tmpCol) then
  begin
    // Get mandatory setting before we check for display column
    if UseIBOBold and
      IsIBColumnMandatory(tmpCol, IB_AutoLabel_IgnoreZeroDefault) then
      AFont.Style := AFont.Style + [fsBold];
    // Controls with IIB_GridWinControl support a display column return
    if (FocusControl.GetInterface(IIB_GridWinControl, tmpIntf)) then
    begin
      if tmpIntf.DisplayColumn is TIB_Column then
        tmpCol := TIB_Column(tmpIntf.DisplayColumn);
    end;
    AText := tmpCol.DisplayLabel;
    // If we were given a valid display name...
    if Length(AText) > 0 then
    begin
      // if this name is too large try the grid name
      if (not AutoSize) and (Canvas.TextWidth(AText) > Width) then
      begin
        tmpStr := tmpCol.GridDisplayName;
        if Length(tmpStr) > 0 then
          AText := tmpStr;
      end;
    end
    // If no valid display name so far, extract fieldname from col
    else
      AText := IBFieldNameToDisplay(tmpCol.FieldName);
    FCaptionInitialised := true;
  end
  // If no column return, we simply process the raw field name returned
  // from the datalink (in the call to GetIBControlColumn above).
  else
  begin
    FCaptionInitialised := false;
    AText := IBFieldNameToDisplay(tmpStr);
  end;

  // This seems like a convenient way of covering the problem of no
  // datasource/datafield connection during design mode.
  if (AText = '') and (csDesigning in ComponentState) then
    AText := '(' + FocusControl.Name + ')';

  inherited;
end;

procedure TIB_Label.DoModelPropertyChange;
var
  i: integer;
begin
  if (ComponentState * [csLoading, csDestroying]) = [] then
  begin
    if FModelRefs <> nil then
      with FModelRefs do
      begin
        for i := 0 to Count - 1 do
        begin
          TIB_AutoLabel(Items[i]).ModelChanged;
        end;
      end;
  end;
end;

procedure TIB_Label.AddModelRef(const AutoLabel: TIB_AutoLabel);
begin
  if FModelRefs = nil then
    FModelRefs := TList.Create;
  FModelRefs.Add(AutoLabel);
end;

procedure TIB_Label.RemoveModelRef(const AutoLabel: TIB_AutoLabel);
begin
  if FModelRefs <> nil then
  begin
    FModelRefs.Remove(AutoLabel);
    if FModelRefs.Count <= 0 then
    begin
      FModelRefs.Free;
      FModelRefs := nil;
    end;
  end;
end;

function TIB_Label.ModelRefCount: integer;
begin
  if FModelRefs = nil then
    Result := 0
  else
    Result := FModelRefs.Count;
end;

//---------------------------------------------------------------------------


constructor TIB_AutoLabel.Create(AOwner: TWinControl);
begin
  FModel := nil;
  FOwner := AOwner;
  inherited Create;
  FtheLabel := nil;
  FKind := IB_AutoLabel_DefaultKind;
  FSuffix := IB_AutoLabel_DefaultSuffix;
  FMargin := IB_AutoLabel_DefaultMargin;
  FRelativePosition := IB_AutoLabel_DefaultPosition;
  FOptions := IB_AutoLabel_DefaultOptions;
  if FKind <> albNone then
    CreateLabel;
end;

destructor TIB_AutoLabel.Destroy;
begin
  SetModel(nil);
  // Destroy the label directly, dont call DestroyLabel
  if Assigned(theLabel) then
  begin
    theLabel.Parent := nil;
    theLabel.Free;
    FtheLabel := nil;
  end;
  inherited Destroy;
end;

function TIB_AutoLabel.IsKindStored: boolean;
begin
  Result := (Kind <> IB_AutoLabel_DefaultKind);
end;

function TIB_AutoLabel.IsSuffixStored: boolean;
begin
  Result := (Suffix <> IB_AutoLabel_DefaultSuffix);
end;

function TIB_AutoLabel.IsPositionStored: boolean;
begin
  Result := (RelativePosition <> IB_AutoLabel_DefaultPosition);
end;

function TIB_AutoLabel.IsMarginStored: boolean;
begin
  Result := (Margin <> IB_AutoLabel_DefaultMargin);
end;

function TIB_AutoLabel.IsOptionsStored: boolean;
begin
  Result := (Options <> IB_AutoLabel_DefaultOptions);
end;


// Isolated the create/destroy label processes for easy management.
// Note that TIB_AutoLabel.Destroy must destroy the label directly,
// whereas this create/destroy process manages the label according
// to whether the reference is required for other reasons

procedure TIB_AutoLabel.CreateLabel;
begin
  if not Assigned(theLabel) then
  begin
    FtheLabel := TIB_Label.Create(Owner);
    FtheLabel.FAutoLabel := Self;
    if Kind = albNone then
      theLabel.Visible := false;
  end;
end;

procedure TIB_AutoLabel.DestroyLabel;
var
  NeedToKeep: boolean;
  ModelLabel: TCustomLabel;
begin
  if Assigned(theLabel) then
  begin
    // For clarity in the code I am using this NeedToKeep flag
    NeedToKeep := false;
    ModelLabel := GetModelLabel(false);
    // If kind is not albNone we still need the label
    if Kind <> albNone then
      NeedToKeep := true
    // If the model label is not TIB_Label then we need to keep the internal
    // label to support FreeNotification.  Only TIB_Label has its own specific
    // notification processing to tell AutoLabels when the model is deleted.
    else
      if (ModelLabel <> nil) and not (ModelLabel is TIB_Label) then
        NeedToKeep := true
      // If the label is being used as a model then it must remain.
      else
        if theLabel.ModelRefCount > 0 then
          NeedToKeep := true;
    // If need to keep it just hide it
    if NeedToKeep then
    begin
      theLabel.Visible := false;
    end
    // otherwise destroy it properly
    else
    begin
      theLabel.Free;
      FtheLabel := nil;
    end;
  end;
end;

// Isolated this function to make it easy to re-use
// If we add support for additional controls as models we only have to
// add them to this function.  Normally called with MakeIt set to false
// but SetModel procedures calls with MakeIt=true if the model should
// have a label created ready for use as a reference.

function TIB_AutoLabel.GetModelLabel(MakeIt: boolean): TCustomLabel;
var
  tmpIntf: IIB_GridWinControl;
begin
  Result := nil;
  if Assigned(Model) then
  begin
    if Model is TLabel then
      Result := TCustomLabel(Model)
    else
      if Model is TIB_CustomLabel then
        Result := TCustomLabel(Model)
      else
        if Model is TIB_Edit then
        begin
          Result := TIB_Edit(Model).AutoLabel.theLabel;
          if (Result = nil) and MakeIt then
          begin
            TIB_Edit(Model).AutoLabel.CreateLabel;
            Result := TIB_Edit(Model).AutoLabel.theLabel;
          end;
        end
        else
          // Controls with IIB_GridWinControl support an AutoLabel definition
          if (Model.GetInterface(IIB_GridWinControl, tmpIntf)) then
          begin
            if tmpIntf.GetAutoLabel is TIB_AutoLabel then
              with TIB_AutoLabel(tmpIntf.GetAutoLabel) do
              begin
                Result := theLabel;
                if (Result = nil) and MakeIt then
                begin
                  CreateLabel;
                  Result := theLabel;
                end;
              end;
          end;
  end;
end;

procedure TIB_AutoLabel.MakeLabel( CheckPreventFlag: boolean );
var
  ModelLabel: TCustomLabel;
  //??AutoWidth : Integer;
begin
  if Kind = albNone then
  begin
    DestroyLabel;
    Exit;
  end;

  if not Assigned(theLabel) then
    CreateLabel;
  if (csLoading in Owner.ComponentState) and
    not (csDesigning in Owner.ComponentState) then
    Exit;

  if CheckPreventFlag and
    IB_AutoLabel_PreventFlicker and
    theLabel.CheckCaptionInitialised then
    Exit;

  theLabel.AutoSize := true;
  theLabel.Parent := Owner.Parent;
  theLabel.Layout := tlTop;
  theLabel.Transparent := true;
  theLabel.Suffix := FSuffix;

  if Caption = '' then
    theLabel.UseIBOLabel := true
  else
  begin
    theLabel.UseIBOLabel := false;
    theLabel.Caption := Caption;
  end;

  if albOnlyFirstCharUpper in Options then
    theLabel.CharCase := ccProperCase
  else
    if albLowerCase in Options then
      theLabel.CharCase := ccLowerCase
    else
      theLabel.CharCase := IBC_CustomLabel.ccNormal;

  if albDotLeader in Options then
  begin
    theLabel.DotLeader := true;
    theLabel.SuffixBeforeDots := albSuffixBeforeDots in Options;
  end
  else
  begin
    theLabel.DotLeader := false;
    theLabel.SuffixBeforeDots := false;
  end;

  theLabel.UseIBOBold := albBoldIfRequired in Options;

  // We set ModelLabel to the TCustomLabel derivation related
  // to the supplied model - if available.
  ModelLabel := GetModelLabel(false);

  if (ModelLabel <> nil) and (ModelLabel is TIB_CustomLabel) then
  begin
    with ModelLabel as TIB_CustomLabel do
    begin
      if (Kind = albTop) then
      begin
        theLabel.Height := Height;
        theLabel.Layout := Layout;
      end;
      if ModelLabel is TIB_Label then
        with ModelLabel as TIB_Label do
        begin
          theLabel.UseIBOBold := UseIBOBold;
          theLabel.UseIBOLabel := UseIBOLabel;
        end;
      theLabel.Font := Font;
      theLabel.ShowAccelChar := ShowAccelChar;
      theLabel.WordWrap := WordWrap;
      theLabel.DotLeader := DotLeader;
      theLabel.SuffixBeforeDots := SuffixBeforeDots;
      theLabel.CharCase := CharCase;
      theLabel.Suffix := Suffix;
    end;
  end
  // otherwise only support TLabel
  else
    if (ModelLabel <> nil) and (ModelLabel is TLabel) then
    begin
      with ModelLabel as TLabel do
      begin
        if (Kind = albTop) then
        begin
          theLabel.Height := Height;
          theLabel.Layout := Layout;
        end;
        theLabel.Font := Font;
        theLabel.ShowAccelChar := ShowAccelChar;
        theLabel.WordWrap := WordWrap;
      end
    end;

  //??AutoWidth:=theLabel.Width;

  if (Kind = albLeft) then
  begin
    if (RelativePosition <> 0) then
    begin
      theLabel.Left := Owner.Left + RelativePosition;
      if (RelativePosition < 0) then
        theLabel.Width := -RelativePosition;
      theLabel.Alignment := taLeftJustify;
    end
    else
    begin
      theLabel.Alignment := taRightJustify;
      theLabel.Left := Owner.Left - theLabel.Width - 3;
    end;
    theLabel.Top := Owner.Top + Margin;
    theLabel.Height := Owner.Height - Margin;
  end
  else
  begin
    if (RelativePosition <> 0) then
      theLabel.Top := Owner.Top + RelativePosition
    else
      theLabel.Top := Owner.Top - theLabel.Height;
    theLabel.Left := Owner.Left + Margin;
    theLabel.Alignment := taLeftJustify;
  end;

  theLabel.FocusControl := Owner;
  theLabel.Enabled := Owner.Enabled;
  theLabel.Visible := Owner.Visible;
  theLabel.AutoSize := false;           // prevent further resizing

  // If we have a TIB_CustomLabel based model...
  if (ModelLabel <> nil) and (ModelLabel is TIB_CustomLabel) then
  begin
    with ModelLabel as TIB_CustomLabel do
    begin
      theLabel.Alignment := Alignment;
      {$IFDEF IBO_VCL40_OR_GREATER}
      theLabel.BiDiMode := BiDiMode;
      {$ENDIF}
      theLabel.Color := Color;
      if (albAlignToModel in Options) and
        (theLabel.Parent = Parent) then
        if (abs(theLabel.Top - Top) > Height) and
          (Left < self.Owner.Left) and
          (Kind = albLeft) then
        begin
          theLabel.Left := Left;
          theLabel.Width := self.Owner.left - Left;
        end
        else
          if (abs(theLabel.Left - Left) > Width) and
            (Kind = albTop) and
            Assigned(FocusControl) and
            (theLabel.FocusControl.Top = FocusControl.Top) then
            theLabel.Top := Top;
      theLabel.PopupMenu := PopupMenu;
      theLabel.ShowHint := ShowHint;
      theLabel.Transparent := Transparent;
    end;
  end
  // otherwise only support TLabel
  else
    if (ModelLabel <> nil) and (ModelLabel is TLabel) then
    begin
      with ModelLabel as TLabel do
      begin
        theLabel.Alignment := Alignment;
        {$IFDEF IBO_VCL40_OR_GREATER}
        theLabel.BiDiMode := BiDiMode;
        {$ENDIF}
        theLabel.Color := Color;
        if (albAlignToModel in Options) and
          (theLabel.Parent = Parent) then
          if (abs(theLabel.Top - Top) > Height) and
            (Left < self.Owner.Left) and
            (Kind = albLeft) then
          begin
            theLabel.Left := Left;
            theLabel.Width := Self.Owner.left - Left;
          end
          else
            if (abs(theLabel.Left - Left) > Width) and
              (Kind = albTop) and
              Assigned(FocusControl) and
              (theLabel.FocusControl.Top = FocusControl.Top) then
              theLabel.Top := Top;
        theLabel.PopupMenu := PopupMenu;
        theLabel.ShowHint := ShowHint;
        theLabel.Transparent := Transparent;
      end
    end;
  //??if (theLabel.Width<=AutoWidth) then begin
  //??   theLabel.DotLeader:=false;
  //??   theLabel.SuffixBeforeDots:=false;
  //??   end;
end;

// Thought it was safer to keep the response to model changes separate
// in case special processing is required.

procedure TIB_AutoLabel.ModelChanged;
begin
  MakeLabel( false );
end;

procedure TIB_AutoLabel.Make;
begin
  MakeLabel( true );
end;

procedure TIB_AutoLabel.SetKind(const K: TIB_AutoLabelKind);
begin
  if (FKind <> K) then
  begin
    FKind := K;
    MakeLabel( false );
  end;
end;

procedure TIB_AutoLabel.SetSuffix(const S: string);
begin
  if (S <> FSuffix) then
  begin
    FSuffix := S;
    if Assigned(theLabel) or (csDesigning in Owner.ComponentState) then
      MakeLabel( false );
  end;
end;

procedure TIB_AutoLabel.SetCaption(const S: string);
begin
  if (S <> FCaption) then
  begin
    FCaption := S;
    if Assigned(theLabel) or (csDesigning in Owner.ComponentState) then
      MakeLabel( false );
  end;
end;

procedure TIB_AutoLabel.SetRelativePosition(const P: Integer);
begin
  if (P <> FRelativePosition) then
  begin
    FRelativePosition := P;
    if Assigned(theLabel) or (csDesigning in Owner.ComponentState) then
      MakeLabel( false );
  end;
end;

procedure TIB_AutoLabel.SetMargin(const P: Integer);
begin
  if (P <> FMargin) then
  begin
    FMargin := P;
    if Assigned(theLabel) or (csDesigning in Owner.ComponentState) then
      MakeLabel( false );
  end;
end;

procedure TIB_AutoLabel.SetModel(const M: TControl);
var
  TmpLbl: TCustomLabel;
begin
  if (M <> nil) then
  begin
    // Prevent assignment of a model, if this instance is being
    // used as a model - prevents circular references.
    if (theLabel <> nil) and (theLabel is TIB_Label) and
      (TIB_Label(theLabel).FModelRefs <> nil) and
      (TIB_Label(theLabel).FModelRefs.Count > 0) then
      Exit;
    // Prevent assignment of self as the model
    if (M = theLabel) or (M = FOwner) then
      Exit;
  end;
  if (M <> FModel) then
  begin
    TmpLbl := GetModelLabel(false);
    if TmpLbl <> nil then
    begin
       // if RemoveFreeNotification is available (D5/BCB5 onwards)
       // then we use it, for the sake of completeness in the code.
      {$IFDEF IBO_VCL50_OR_GREATER}
      if TmpLbl is TIB_Label then
        TIB_Label(TmpLbl).RemoveModelRef(Self)
      else
        if Assigned(theLabel) then
          FModel.RemoveFreeNotification(theLabel);
      {$ELSE}
      if TmpLbl is TIB_Label then
        TIB_Label(TmpLbl).RemoveModelRef(Self);
      {$ENDIF}
    end;
    FModel := M;
    TmpLbl := GetModelLabel(true);
    if TmpLbl <> nil then
    begin
      if TmpLbl is TIB_Label then
        TIB_Label(TmpLbl).AddModelRef(Self)
      else
      begin
        CreateLabel; // Must have a reference for FreeNotification
        FModel.FreeNotification(theLabel);
      end;
    end;
    if Assigned(theLabel) or (csDesigning in Owner.ComponentState) then
      MakeLabel( false );
  end;
end;

procedure TIB_AutoLabel.SetOptions(const O: TIB_AutoLabelOptionsSet);
begin
  if (O <> FOptions) then
  begin
    FOptions := O;
    if Assigned(theLabel) or (csDesigning in Owner.ComponentState) then
      MakeLabel( false );
  end;
end;

initialization
  IB_AutoLabel_DefaultKind := albNone;
  IB_AutoLabel_DefaultSuffix := '';
  IB_AutoLabel_DefaultMargin := 3;
  IB_AutoLabel_DefaultPosition := 0;
  IB_AutoLabel_DefaultOptions := [];
  IB_AutoLabel_IgnoreZeroDefault := true;
  IB_AutoLabel_PreventFlicker := false;

end.

