unit whIBOds;
//----------------------------------------------------------------------
// WebHub TWebDatasource for Interbase Objects' TIBDataSets
//  written by Michael Ax, http://href.com
//  tested and initiated by Peter Hyde, http://spis.co.nz
//  Interbase Objects by Jason Wharton, http://ibobjects.com
//----------------------------------------------------------------------
// Copyright (c) 1999 HREF Tools Corp.  All Rights Reserved.
//----------------------------------------------------------------------

// Limitations as compared to TWebDatasource:

// - you must use cloned datasets, e.g. you need MaxOpenDatasets >1
//   without cloning we would need the ability to grab the key-fields
//   and return to them. this got taken out and will go back in.

// - does not support switching IndexOrders
//   currently this requires re-running/preparing the query from scratch

// - does not support :www... parameters
//   looking into that next, needs an 'IsQuery' function to *override*!


// these procs relate to indexorders and they have been gutted, nah,
// they are currenly shells of their former selves and need updating
// for the indexorder switching angle to work.. to enable non-cloned
// access to a single shared ibQuery.
//    procedure SelectPrimaryIndex; override;
//    function  GetKeyFields:String; override;
//    function  FindKeysInTable(const Value:String):Boolean; override;
//    procedure AdjustIndexOrder; override;

// Use with TIBOTable and TIBOQuery in Delphi 5. See the InterBase palette tab in Delphi.

interface

uses
  Classes,
  db,            //field types
  WdbSorce,      //ancestor class
  IB_Components, //TIB_Transaction
  IBDataSet;     //TIBDataSet

type
  TIBOWebDataSource = class(TWebDataSource)
  private
    fCloneTransactions: Boolean;
    function GetIBDataSet: TIBODataSet;
    procedure SetIBDataSet(Value: TIBODataSet);
    function GetIB_Transaction: TIB_Transaction;
    procedure SetIB_Transaction(Value: TIB_Transaction);
  protected
    function  IsDBase(DataSet:TDataSet): boolean; override;
    function  IsQuery(DataSet:TDataSet): boolean; //override; not yet in ancestor! 
//    procedure SelectPrimaryIndex; override;
//    function  GetKeyFields:String; override;
//    function  FindKeysInTable(const Value:String):Boolean; override;
    procedure Clone(const NewName:string); override;
    function GetRecordCount:Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
//    procedure AdjustIndexOrder; override;
  published
    //the active dataset and its transaction
    property IBDataSet: TIBODataSet read GetIBDataSet write SetIBDataSet;
    property IB_Transaction: TIB_Transaction read GetIB_Transaction write SetIB_Transaction;
    //allows you to clone transactions as well as datasources!
    //primarily for writing and, well, leveraging transactions in your webapp.
    property CloneTransactions: Boolean read fCloneTransactions write fCloneTransactions default false;
    end;

procedure Register;

implementation

uses
  Sysutils, WhConst,
  ucString, ucClone, ucClonDB;

//----------------------------------------------------------------------
//clones a component in its entirety  //ucClonDB, ucClone
//procedure CloneComponent(Owner, T1: TComponent; var T2: TComponent;const NewName:String);
//procedure CloneDataSet(Root,Owner:TComponent;T1:TDataSet;var T2:TDataSet;const NewName:String);

procedure TIBOWebDataSource.Clone(const NewName:string);
var
  IBDataSet: TIBODataSet;
  IBTransaction: TIB_Transaction;
begin // dont call inherited.
  //close the dataset as IBO currently makes it impossible to clone
  //active fields! that's a _bad problem and one I need to look into
  //deeper to just specify the exact nature of _why that is.
  fDataSetOrg.Close;
  //clone the virtual datasource
  CloneDeep(Owner,Self,fDataSetOrg,tComponent(fDataSet),NewName);
{ // v2xxx
  //clone the virtual datasource
  CloneDeep(Owner,Self,fDataSetOrg,tComponent(fDataSet),NewName);
  //clone the underlying ib component
  //(note, CloneDataSet clones 'sub' components, aka fields, while CloneComponent does not.)
  CloneDeep(Owner,fDataSet,TIBODataSet(fDataSetOrg).Dataset,tComponent(IBDataSet),'');
  //connect the clones: set the 'actual' dataset in the virtual dataset.
  TIBODataSet(fDataSet).Dataset:=IBDataSet; {}
  //
  if CloneTransactions then begin
    IBDataSet:= TIBODataSet(fDataSet {which is a TDataset});
    //clone the transaction the dataset is connected to, make the clone
    //owned the the dataset and connect the dataset to the clone transaction.
    CloneDeep(Owner,IBDataSet,IBDataSet.IB_Transaction,tComponent(IBTransaction),'');
    //connect the clones: set the 'actual' dataset in the virtual dataset.
    IBDataSet.IB_Transaction:=IBTransaction;
    end;
  //
  if assigned(fOnClonedDataSet) then
    fOnClonedDataSet(Self);
end;

//----------------------------------------------------------------------

constructor TIBOWebDataSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //ibo tables are not really tables and so there can not be any indexes
  //available for them. far be it from ibo to do anything by means of
  //sql indicies either, so to allow transparent use of single field-names
  //to control ordering of rows, we default the property to true here.
  UsingIndexFieldNames:= True;
  //at present there's no support of db_key and the component requires
  //use of cloned datatsets.
  MaxOpenDataSets:= cMaxOpenDataSets;
end;

//----------------------------------------------------------------------

function TIBOWebDataSource.GeTIBDataSet: TIBODataSet;
begin
  if DataSource<>nil then
    Result:= TIBODataSet(DataSource.DataSet)
  else
    Result:= nil;
end;

procedure TIBOWebDataSource.SeTIBDataSet(Value: TIBODataSet);
begin
  if DataSource<>nil then
    DataSource.DataSet:= Value;
end;

//------------------------------------------------------------------------------

function TIBOWebDataSource.GetIB_Transaction: TIB_Transaction;
begin
  if IBDataSet<>nil then
    Result:= IBDataSet.IB_Transaction
  else
    Result:= nil;
end;

procedure TIBOWebDataSource.SetIB_Transaction(Value: TIB_Transaction);
begin
  if IBDataSet<>nil then
    IBDataSet.IB_Transaction:= Value;
end;

//----------------------------------------------------------------------

function TIBOWebDataSource.IsDBase(DataSet:TDataSet): Boolean;
begin
  Result:= False; //true for 'advantage database server', false elsewhere.
end;

function TIBOWebDataSource.IsQuery(DataSet:TDataSet): Boolean;
begin
  Result:= True; //true if wrapping a sql api into tables
end;

//------------------------------------------------------------------------------

function TIBOWebDataSource.GetRecordCount:Integer;
begin //leverage IBO to get the record count!
//  Result:= DataSet.RecordCount;
  Result:= TIBODataSet(DataSet).RecordCount;
end;

//------------------------------------------------------------------------------
(*
procedure TIBOWebDataSource.SelectPrimaryIndex;
begin
end;

function TIBOWebDataSource.GetKeyFields:String;
begin
  Result:=KeyFieldNames;
end;

function TIBOWebDataSource.FindKeysInTable(const Value:String):Boolean;
begin
  Result:={not}True {actually, this has been gutted for the time};
end;

procedure TIBOWebDataSource.AdjustIndexOrder;
begin
end;
*)
//----------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('WebHub', [TIBOWebDataSource]);
end;

//----------------------------------------------------------------------
end.

