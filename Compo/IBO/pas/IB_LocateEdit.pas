
{                                                                              }
{  IB_LocateEdit                                                               }
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

{: This unit contains the control that makes it easy to have a user enter in a
value and then have it located in the dataset via the Locate() method.}
unit
  IB_LocateEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, ExtCtrls, Mask, 

  IB_Components,
  IB_Controls;

type
{: This control makes it easy to have a user enter in a
value and then have it located in the dataset via the Locate() method.}
TIB_LocateEdit = class(TIB_Edit)
private
  FLocateOptions: TIB_LocateOptions;
  FDisableEditing: boolean;

protected
  procedure SetDisableEditing( AVal: boolean );
  function EditCanModify: Boolean; override;
  procedure EditingChanged( Sender: TIB_DataLink;
                            IB_DataSource: TIB_DataSource ); override;
  function DoLocate:Boolean; virtual;
  procedure KeyPress( var Key: Char ); override;
  procedure DoEditButtonClick; override;
  procedure SysStateChanged; override;
  procedure UpdateMask( UnboundMask: string ); override; 

public
{: This is the text of the value that is sent to the Locate() method.}
  property Text;
{: Method to programatically invoke the call to the dataset's Locate() method
using the values entered into the control.}
  procedure Locate;

published
{: These are the options used when the internal call to Locate() is made.}
  property LocateOptions: TIB_LocateOptions read FLocateOptions
                                            write FLocateOptions
                                            default [];
  property DisableEditing: boolean read FDisableEditing write SetDisableEditing default false;
end;

implementation

uses
{$IFDEF IBO_VCL60_OR_GREATER}
  Variants,
{$ENDIF}
  IB_Parse;
  
procedure TIB_LocateEdit.SetDisableEditing( AVal: boolean );
begin
if AVal <> FDisableEditing then begin
  FDisableEditing := AVal;
  SysStateChanged;
  end;
end;

function TIB_LocateEdit.EditCanModify: Boolean;
begin
  if DataLink.State in [dssInsert,dssEdit,dssSearch] then
  begin
    if DisableEditing then
      Result := false
    else
      Result := inherited EditCanModify;
  end
  else
    Result := DataLink.Active;
end;

procedure TIB_LocateEdit.SysStateChanged;
begin
  with DataLink do
  begin
    if (State in [dssInsert,dssEdit,dssSearch]) and (not DisableEditing) then
    begin
      inherited SysStateChanged;
    end else begin
      if ColorScheme then begin
        if (State in [dssInsert,dssEdit,dssSearch]) and DisableEditing then
          inherited Color := IB_Session.ReadOnlyColor
        else
          inherited Color := IB_Session.SearchingColor;
      end;
      case FieldCharCase of
        ccUpper: CharCase := ecUpperCase;
        ccLower: CharCase := ecLowerCase;
        else     CharCase := ecNormal;
      end;
      MaxLength := FieldMaxLength;
    end;
  end;
end;

procedure TIB_LocateEdit.EditingChanged( Sender: TIB_DataLink;
                                         IB_DataSource: TIB_DataSource );
begin
  if (DataLink.State in [dssInsert,dssEdit,dssSearch]) then begin
    if DisableEditing then
      inherited ReadOnly := true
    else  inherited EditingChanged( Sender, IB_DataSource );
  end;
end;

procedure TIB_LocateEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress( Key );
  if (Key = #13) and not(DataLink.State in [dssInsert,dssEdit,dssSearch]) then
  begin
    DoLocate;
    Key := #0;
  end;
end;

procedure TIB_LocateEdit.DoEditButtonClick;
begin
  if Assigned( OnButtonClick ) then
    inherited DoEditButtonClick
  else if not(DataLink.State in [dssInsert,dssEdit,dssSearch]) then
    DoLocate;
end;

function TIB_LocateEdit.DoLocate: Boolean;
var
  ii: integer;
  tmpInt: integer;
  tmpFld: string;
  tmpCol: TIB_Column;
  tmpStr: string;
  tmpStrings: TIB_StringList;
  tmpVals: variant;
begin
  Result := false;
  with DataLink do
    if Active and ( Dataset is TIB_BDataset ) then
      with Dataset as TIB_BDataset do
      begin
        tmpStrings := TIB_StringList.Create;
        try
          tmpFld := DataField;
          if tmpFld = '' then
            tmpFld := OrderingLink;
          ExtractFieldsIntoList( tmpFld, tmpStrings );
          tmpStr := Text;
          with tmpStrings do
          begin
            for ii := 0 to Count - 1 do
            begin
              if Count > 1 then
              begin
                tmpInt := getLitSafePos( ',', tmpStr, 1 );
                if tmpInt > 0 then
                begin
                  IndexValues[ ii ] := stLitCriteria( Copy( tmpStr,
                                                            1,
                                                            tmpInt - 1 ));
                  tmpStr := Copy( tmpStr, tmpInt + 1, MaxInt );
                end
                else
                begin
                  IndexValues[ ii ] := stLitCriteria( tmpStr );
                  tmpStr := '';
                end;
              end
              else
                IndexValues[ ii ] := tmpStr;
            end;
            ii := 0;
            while ii < Count do
            begin
              tmpCol := FindField( IndexNames[ ii ] );
              tmpStr := IndexValues[ ii ];
              if Assigned( tmpCol ) and ( tmpStr <> '' ) then
              begin
                if tmpCol.NoCaseFieldName <> '' then
                begin
                  tmpStr := AnsiUpperCase( tmpStr );
                  IndexValues[ ii ] := tmpStr;
                end;
                Inc( ii );
              end
              else
                Delete( ii );
            end;
            tmpFld := '';
            tmpVals := VarArrayCreate([0, Count - 1], varVariant);
            for ii := 0 to Count - 1 do
            begin
              if ii > 0 then
                tmpFld := tmpFld + ';';
              tmpFld := tmpFld + Indexnames[ ii ];
              tmpVals[ ii ] := IndexValues[ ii ];
            end;
          end;
          if tmpFld = '' then
            MessageBeep( 0 )
          else
            Result := Locate( tmpFld, tmpVals, LocateOptions );
        finally
          tmpStrings.Free;
        end;
    end
    else
      MessageBeep( 0 );
end;

procedure TIB_LocateEdit.UpdateMask( UnboundMask: string );
begin
  if (DataLink.State in [dssInsert,dssEdit,dssSearch]) and
    (not DisableEditing) then
    inherited UpdateMask( UnboundMask );
// Prevent mask from being applied - in locate mode
end;

procedure TIB_LocateEdit.Locate;
begin
 DoLocate;
end;

end.
