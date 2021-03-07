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

unit
  IBF_Lookup;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Grids, ComCtrls, Mask,

  IBF_Base,

  IB_Components,
  IB_UpdateBar,
  IB_NavigationBar,
  IB_DatasetBar,
  IB_SearchBar,
  IB_Grid,
  IB_SearchPanel,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_ParamEdit,
  IB_IncSearch;

type
  TfrmLookup = class(TfrmBase)
    grLookup: TIB_Grid;
    DataSource: TIB_DataSource;
    SpeedBar: TPanel;
    sbSearch: TIB_SearchBar;
    nbCharities: TIB_NavigationBar;
    IB_UpdateBar: TIB_UpdateBar;
    IB_SearchPanel: TIB_SearchPanel;
    pnSearch: TPanel;
    isSearch: TIB_IncSearch;
    IB_DatasetBar1: TIB_DatasetBar;
    procedure DataSourceStateChanged(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure pnSearchResize(Sender: TObject);
    procedure DataSourceDataChange(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
    procedure grLookupDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure sbSearchSaveCriteria(Sender: TObject);
    procedure sbSearchRecallCriteria(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FStateUponOpen: TIB_DatasetState;
    FPostOnClose: boolean;
    FPanelStates: TIB_DatasetStateSet;
    FMaxSearchEditWidth: integer;
    function GetLookupDataset: TIB_Dataset;
    procedure SetLookupDataset( AValue: TIB_Dataset );
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
  public
    { Public declarations }
    property LookupDataset: TIB_Dataset read GetLookupDataset
                                        write SetLookupDataset;
    property PanelStates: TIB_DatasetStateSet read FPanelStates
                                              write FPanelStates;
    property PostOnClose: boolean read FPostOnClose write FPostOnClose;
    property MaxSearchEditWidth: integer read FMaxSearchEditWidth
                                         write FMaxSearchEditWidth;
    property StateUponOpen: TIB_DatasetState read FStateUponOpen
                                             write FStateUponOpen;
  end;

implementation

{$R *.DFM}

procedure TfrmLookup.FormCreate(Sender: TObject);
begin
  grLookup.Align := alClient;
  FPostOnClose := false;
  FPanelStates := [ dssSearch ];
  FMaxSearchEditWidth := 300;
end;

function TfrmLookup.GetLookupDataset: TIB_Dataset;
begin
  Result := DataSource.Dataset;
end;

procedure TfrmLookup.SetLookupDataset(AValue: TIB_Dataset);
begin
  DataSource.Dataset := AValue;
end;

procedure TfrmLookup.DataSourceDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  DataSourceStateChanged( Sender as TIB_DataSource, Statement as TIB_Dataset );
end;

procedure TfrmLookup.DataSourceStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if Assigned( ADataset ) then with ADataset do begin
    if Refreshing then Exit;
    btOK.Enabled := Fields.RowState <> rsNone;
    IB_SearchPanel.Visible := State in PanelStates;
    grLookup.Visible := not IB_SearchPanel.Visible;
    IB_UpdateBar.Visible := not ReadOnly and not grLookup.RowSelect;
  end else begin
    btOK.Enabled := false;
    IB_SearchPanel.Visible := false;
    IB_UpdateBar.Visible := false;
    grLookup.Visible := true;
  end;
end;

procedure TfrmLookup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned( LookupDataset ) then with LookupDataset do begin
    if Assigned( KeyDataset ) then with KeyDataset do begin
      if PostOnClose and NeedToPost then begin
        if ModalResult = mrOk then begin
          Post;
        end else begin
          Cancel;
        end;
      end;
    end;
  end;
  inherited;
end;

procedure TfrmLookup.pnSearchResize(Sender: TObject);
begin
  if pnSearch.ClientWidth - isSearch.Left * 2 > MaxSearchEditWidth then
    isSearch.Width := MaxSearchEditWidth
  else
    isSearch.Width := pnSearch.ClientWidth - isSearch.Left * 2;
end;

procedure TfrmLookup.grLookupDblClick(Sender: TObject);
begin
  if DataSource.Prepared then
    btOk.Click;
end;

procedure TfrmLookup.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Assigned( LookupDataset ) and LookupDataset.Active then
  begin
    try
      LookupDataset.CheckBrowseMode;
    except
      CanClose := false;
      Application.HandleException( Self );
    end;
  end;
end;

procedure TfrmLookup.DoReadSettings;
begin
//  with Reg_INI do begin
// Retrieve persistent settings here.
//  end;
end;

procedure TfrmLookup.DoWriteSettings;
begin
//  with Reg_INI do begin
// Store persistent settings here.
//  end;
end;

procedure TfrmLookup.sbSearchSaveCriteria(Sender: TObject);
var
  tmpStrings: TIB_StringList;
begin
  if LookupDataset = nil then Exit;
  if BaseKey = '' then
  begin
    LookupDataset.SaveSearch;
  end
  else
  begin
    tmpStrings := TIB_StringList.Create;
    try
      LookupDataset.WriteSearch( tmpStrings );
      SubKey := 'Current';
      with RegDB do
      begin
        WriteStrings( 'Saved QBE', tmpStrings );
      end;
    finally
      tmpStrings.Free;
      SubKey := '';
    end;
  end;
end;

procedure TfrmLookup.sbSearchRecallCriteria(Sender: TObject);
var
  tmpStrings: TIB_StringList;
begin
  if LookupDataset = nil then Exit;
  if BaseKey = '' then begin
    LookupDataset.RecallSearch;
  end else begin
    tmpStrings := TIB_StringList.Create;
    try
      SubKey := 'Current';
      with RegDB do begin
        ReadStrings( 'Saved QBE', tmpStrings );
      end;
      LookupDataset.ReadSearch( tmpStrings );
    finally
      tmpStrings.Free;
      SubKey := '';
    end;
  end;
end;

procedure TfrmLookup.btOKClick(Sender: TObject);
begin
  if Assigned( LookupDataset ) then begin
    if LookupDataset.Active then LookupDataset.CheckBrowseMode;
  end;
  inherited;
end;

procedure TfrmLookup.btCancelClick(Sender: TObject);
begin
  if Assigned( LookupDataset ) then
  begin
    if LookupDataset.NeedToPost then
      LookupDataset.Cancel;
    if Assigned( LookupDataset.KeyDataset ) then
      if LookupDataset.KeyDataset.NeedToPost and
         not ( FStateUponOpen in [ dssEdit, dssInsert ] ) then
        LookupDataset.KeyDataset.Cancel;  
  end;
  inherited;
end;

procedure TfrmLookup.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

end.

 
