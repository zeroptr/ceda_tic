{                                                                              }
{ IB_ActionUpdate                                                              }
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
{  Marco Menardi <mmenaz@lycosmail.com                                         }
{  10/26/2001                                                                  }
{     I've made this Actions "focused dataset" enabled like IB_xxxBars are.    }
{     So there is a ReceiveFocus property and an OnReceiveFocus event added    }
{     Check of Datasource.Dataset being valid in .ExecuteTarget has been       }
{     removed since the Enabled property does enought                          }
{            Copyright (C) 2001 Marco Menardi                                  }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_ActionUpdate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus,

  IB_Constants,
  IB_FieldDataLink,
  IB_Components;

type
  TIB_CustomActionUpdate = class(TAction)
{$I IB_DataLink.INT}
  private
  protected
    procedure SysStateChanged; virtual;
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    function HandlesTarget( Target: TObject ): Boolean; override;
  end;

  TIB_ActionOpen = class( TIB_CustomActionUpdate )
  protected
    procedure SysStateChanged; override;
  public
    constructor Create( AOwner: TComponent ); override;
    procedure ExecuteTarget( Target: TObject ); override;
  end;

  TIB_ActionClose = class( TIB_CustomActionUpdate )
  protected
    procedure SysStateChanged; override;
  public
    constructor Create( AOwner: TComponent ); override;
    procedure ExecuteTarget( Target: TObject ); override;
  end;

  TIB_ActionReadOnly = class( TIB_CustomActionUpdate )
  protected
    procedure SysStateChanged; override;
  public
    constructor Create( AOwner: TComponent ); override;
    procedure ExecuteTarget( Target: TObject ); override;
  end;

  TIB_ActionNew = class( TIB_CustomActionUpdate )
  protected
    procedure SysStateChanged; override;
  public
    constructor Create( AOwner: TComponent ); override;
    procedure ExecuteTarget( Target: TObject ); override;
  end;

  TIB_ActionEdit = class( TIB_CustomActionUpdate )
  protected
    procedure SysStateChanged; override;
  public
    constructor Create( AOwner: TComponent ); override;
    procedure ExecuteTarget( Target: TObject ); override;
  end;

  TIB_ActionPost = class( TIB_CustomActionUpdate )
  protected
    procedure SysStateChanged; override;
  public
    constructor Create( AOwner: TComponent ); override;
    procedure ExecuteTarget( Target: TObject ); override;
  end;

  TIB_ActionCancel = class( TIB_CustomActionUpdate )
  protected
    procedure SysStateChanged; override;
  public
    constructor Create( AOwner: TComponent ); override;
    procedure ExecuteTarget( Target: TObject ); override;
  end;

  TIB_ActionDelete = class( TIB_CustomActionUpdate )
  protected
    procedure SysStateChanged; override;
  public
    constructor Create( AOwner: TComponent ); override;
    procedure ExecuteTarget( Target: TObject ); override;
  end;

  TIB_ActionRefreshKeys = class( TIB_CustomActionUpdate )
  public
    constructor Create( AOwner: TComponent ); override;
    procedure ExecuteTarget( Target: TObject ); override;
  end;

  TIB_ActionRefreshRows = class( TIB_CustomActionUpdate )
  public
    constructor Create( AOwner: TComponent ); override;
    procedure ExecuteTarget( Target: TObject ); override;
  end;

  TIB_ActionRefresh = class( TIB_CustomActionUpdate )
  public
    constructor Create( AOwner: TComponent ); override;
    procedure ExecuteTarget( Target: TObject ); override;
  end;

implementation

constructor TIB_CustomActionUpdate.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );

  FIB_DataLink := TIB_DataLink.Create( Self );

  with DataLink do
  begin
    AfterAssignment := IB_DatasetStateChanged;
    OnPreparedChanged := IB_DatasetStateChanged;
    OnActiveChange := IB_DatasetStateChanged;
    OnStateChanged := IB_DatasetStateChanged;
    OnDataChange := IB_DatasetDataChange;
  end;
end;

destructor TIB_CustomActionUpdate.Destroy;
begin
  with DataLink do
  begin
    AfterAssignment := nil;
    OnPreparedChanged := nil;
    OnActiveChange := nil;
    OnStateChanged := nil;
    OnDataChange := nil;
  end;
  inherited Destroy;
end;

procedure TIB_CustomActionUpdate.SetDataSource;
begin
  if DataLink.DataSource <> AValue then
  begin
    DataLink.DataSource := AValue;
    SysStateChanged;
  end;
end;

function TIB_CustomActionUpdate.GetDataSource: TIB_DataSource;
begin
  Result := DataLink.DataSource;
end;

function TIB_CustomActionUpdate.GetReceiveFocus: boolean;
begin
  Result := DataLink.ReceiveFocus;
end;

procedure TIB_CustomActionUpdate.SetReceiveFocus(AValue: boolean);
begin
  DataLink.ReceiveFocus := AValue;
end;

function TIB_CustomActionUpdate.HandlesTarget( Target: TObject ): Boolean;
begin
  Result := True;
end;

procedure TIB_CustomActionUpdate.SysStateChanged;
begin
  Enabled := Assigned( DataSource ) and Assigned( DataSource.DataSet );
end;

procedure TIB_CustomActionUpdate.IB_DatasetStateChanged( Sender: TIB_DataLink;
                                                   DataSource: TIB_DataSource );
begin
  SysStateChanged;
end;

procedure TIB_CustomActionUpdate.IB_DatasetDataChange( Sender: TIB_DataLink;
                                                  DataSource: TIB_DataSource;
                                                  IB_Field: TIB_Column );
begin
  SysStateChanged;
end;

function TIB_CustomActionUpdate.GetOnReceiveFocus: TIB_DataLinkEvent;
begin
  Result := DataLink.OnReceiveFocus;
end;

procedure TIB_CustomActionUpdate.SetOnReceiveFocus( AValue: TIB_DataLinkEvent );
begin
  DataLink.OnReceiveFocus := AValue;
end;

constructor TIB_ActionOpen.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  Caption := C_ST_Open;
  Hint := H_DS_Open_Dataset;
end;

procedure TIB_ActionOpen.SysStateChanged;
begin
  inherited;
  Enabled := (Enabled and (not ( DataSource.Dataset.Active )));
end;

procedure TIB_ActionOpen.ExecuteTarget( Target: TObject );
begin
  if Assigned( DataSource ) and
     Assigned( DataSource.Dataset ) then
    with DataSource.Dataset do
    begin
      if not Prepared then Prepare;
      if ( StatementType = stSelect ) or
         ( StatementType = stSelectForUpdate ) then
        Open
      else
        Execute;
    end;
end;

constructor TIB_ActionClose.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  Caption := C_ST_Close;
  Hint := H_DS_Close_Dataset;
end;

procedure TIB_ActionClose.SysStateChanged;
begin
  inherited;
  Enabled := Enabled and ( DataSource.Dataset.Active );
end;

procedure TIB_ActionClose.ExecuteTarget( Target: TObject );
begin
  DataSource.Dataset.Close;
end;

constructor TIB_ActionReadOnly.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  Caption := C_ST_ReadOnly;
  Hint := H_DS_ReadOnly_Dataset;
end;

procedure TIB_ActionReadOnly.SysStateChanged;
begin
  inherited;
  if Enabled then
    Checked := DataSource.Dataset.ReadOnly;
end;

procedure TIB_ActionReadOnly.ExecuteTarget( Target: TObject );
begin
  with DataSource.Dataset do
    ReadOnly := not ReadOnly;
end;

constructor TIB_ActionNew.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  Caption := C_ST_New;
  Hint := H_UB_INSERT;
end;

procedure TIB_ActionNew.SysStateChanged;
begin
  inherited;
  Enabled := Enabled and ( DataSource.Dataset.CanInsert );
end;

procedure TIB_ActionNew.ExecuteTarget( Target: TObject );
begin
  with DataSource.Dataset do
    if CanInsert then
      Insert;
end;

constructor TIB_ActionPost.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  Caption := C_ST_Post;
  Hint := H_UB_POST;
end;

procedure TIB_ActionPost.SysStateChanged;
begin
  inherited;
  Enabled := Enabled and
             (( DataSource.Dataset.NeedToPost ) or
              ( DataSource.Dataset.State = dssSearch ));
end;

procedure TIB_ActionPost.ExecuteTarget( Target: TObject );
begin
  with DataSource.Dataset do
    if NeedToPost or ( State = dssSearch ) then
      Post;
end;

constructor TIB_ActionCancel.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  Caption := C_ST_Cancel;
  Hint := H_UB_CANCEL;
end;

procedure TIB_ActionCancel.SysStateChanged;
begin
  inherited;
  Enabled := Enabled and
             (( DataSource.Dataset.NeedToPost ) or
              ( DataSource.Dataset.State = dssSearch ));
end;

procedure TIB_ActionCancel.ExecuteTarget( Target: TObject );
begin
  with DataSource.Dataset do
  begin
    if NeedToPost then
      Cancel
    else if State = dssSearch then
    begin
      ClearSearch;
      Open;
    end;
  end;
end;

constructor TIB_ActionDelete.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  Caption := C_ST_Delete;
  Hint := H_UB_DELETE;
end;

procedure TIB_ActionDelete.SysStateChanged;
begin
  inherited;
  Enabled := Enabled and ( DataSource.Dataset.CanDelete );
end;

procedure TIB_ActionDelete.ExecuteTarget( Target: TObject );
begin
  with DataSource.Dataset do
    if CanDelete then
      Delete;
end;

constructor TIB_ActionEdit.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  Caption := C_ST_Edit;
  Hint := H_UB_EDIT;
end;

procedure TIB_ActionEdit.ExecuteTarget( Target: TObject );
begin
  with DataSource.Dataset do
    if CanEdit then
      Edit;
end;

procedure TIB_ActionEdit.SysStateChanged;
begin
  inherited;
  Enabled := Enabled and ( DataSource.Dataset.CanEdit );
end;

constructor TIB_ActionRefreshKeys.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  Caption := C_ST_RefreshKeys;
  Hint := H_UB_REFRESHKEYS;
end;

procedure TIB_ActionRefreshKeys.ExecuteTarget( Target: TObject );
begin
  DataSource.Dataset.RefreshKeys;
end;

constructor TIB_ActionRefreshRows.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  Caption := C_ST_RefreshRows;
  Hint := H_UB_REFRESHROWS;
end;

procedure TIB_ActionRefreshRows.ExecuteTarget( Target: TObject );
begin
  DataSource.Dataset.RefreshRows;
end;

constructor TIB_ActionRefresh.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  Caption := C_ST_Refresh;
  Hint := H_UB_REFRESH;
end;

procedure TIB_ActionRefresh.ExecuteTarget( Target: TObject );
begin
  DataSource.Dataset.Refresh;
end;

end.
