{***************************************************************
 *
 * Unit Name: IBD_Restructure
 * Purpose  :  Provide a Dialog for end-users to conveniently
               change the visible fields and the order the fiels
               are shown
               This code is licensed under the CPS Trustwarte
               License and is part of OBObjects and donated to
               the IBO-Community.
               Many thanks to Jason Wharton for creating such
               a tremendous Data-Access Framework

 * Author   :  Nick 'Kaputnik' Josipovic nick@kaputnik.com
 * History  :  29.12.2001 Unit created, tested and used privately
               24.02.2002 Unit revised, bug-fixed and passed on to
               Jason for review and inclusion
 *
 ****************************************************************}

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

unit IBD_Restructure;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ActnList,
  Buttons,
  ExtCtrls,
  StdCtrls,
  IB_Components,
  IB_Constants,
  ImgList;

type
  TdlgRestructure = class(TForm)
    DataSource: TIB_DataSource;
    Splitter1: TSplitter;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    ActionList1: TActionList;
    Panel2: TPanel;
    Panel3: TPanel;
    lbHidden: TListBox;
    Panel4: TPanel;
    Panel5: TPanel;
    lbVisible: TListBox;
    Panel6: TPanel;
    Panel7: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    actHide: TAction;
    ImageList1: TImageList;
    actHideAll: TAction;
    actVisible: TAction;
    actVisibleAll: TAction;
    actUp: TAction;
    actTop: TAction;
    actDown: TAction;
    actBottom: TAction;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSourceAfterAssignment(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    procedure actHideExecute(Sender: TObject);
    procedure lbVisibleDblClick(Sender: TObject);
    procedure actHideAllExecute(Sender: TObject);
    procedure actVisibleExecute(Sender: TObject);
    procedure actVisibleAllExecute(Sender: TObject);
    procedure lbHiddenDblClick(Sender: TObject);
    procedure actUpExecute(Sender: TObject);
    procedure actDownExecute(Sender: TObject);
    procedure actTopExecute(Sender: TObject);
    procedure actBottomExecute(Sender: TObject);
    procedure lbVisibleDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbVisibleDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbHiddenDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbHiddenDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
    procedure updateBoxes;
  public
    { Public declarations }
    FieldList: TStringList;
    VisibleList: TStringList;
    IndexList: TStringList;
    oldIndexList: TStringList;
    lbVisibleShadow: TStringList;
    lbHiddenShadow: TStringList;
  end;

implementation

{$R *.DFM}

procedure TdlgRestructure.FormCreate(Sender: TObject);
begin
  FieldList := TStringList.Create;
  VisibleList := TStringList.Create;
  IndexList := TStringList.Create;
  oldIndexList := TStringList.Create;
  lbVisibleShadow := TStringList.Create;
  lbHiddenShadow := TStringList.Create;
  actHide.Hint := H_RD_actHide;
  actHideAll.Hint := H_RD_actHideAll;
  actVisible.Hint := H_RD_actVisible;
  actVisibleAll.Hint := H_RD_actVisibleAll;
  actUp.Hint := H_RD_actUp;
  actTop.Hint := H_RD_actTop;
  actDown.Hint := H_RD_actDown;
  actBottom.Hint := H_RD_actBottom;
end;

procedure TdlgRestructure.FormClose(Sender: TObject; var Action:
  TCloseAction);
var
  I                 : Integer;
begin
  if Self.ModalResult <> mrOK then
  begin
    if DataSource.Dataset <> nil then
    begin
      for I := 0 to oldIndexList.Count - 1 do { Iterate }
      begin
        DataSource.Dataset.FieldByName(oldIndexList[i]).Index := i;
      end;                              { for }
      DataSource.Dataset.FieldsVisible.Assign(VisibleList);
    end;
  end;
  FieldList.Free;
  VisibleList.Free;
  IndexList.Free;
  oldIndexList.Free;
  lbVisibleShadow.Free;
  lbHiddenShadow.Free;
end;

procedure TdlgRestructure.DataSourceAfterAssignment(Sender:
  TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  ADataset.GetFieldNamesList(FieldList);
  VisibleList.Assign(ADataset.FieldsVisible);
  IndexList.Assign(ADataset.FieldsIndex);
  if IndexList.Count < FieldList.count then
  begin
    IndexList.Clear;
    IndexList.Assign(FieldList);
  end;
  oldIndexList.Assign(IndexList);
  updateBoxes;
end;

procedure TdlgRestructure.actHideExecute(Sender: TObject);
var
  I                 : Integer;
begin
  if lbVisible.SelCount > 0 then
  begin
    for I := 0 to lbVisible.Items.Count - 1 do { Iterate }
    begin
      DataSource.Dataset.FieldByName(lbVisibleShadow[I]).Visible := not
        lbVisible.Selected[I];
    end;
  end;
  updateBoxes;
end;

procedure TdlgRestructure.updateBoxes;
var
  s                 : string;
  I                 : Integer;
begin
  lbVisible.Items.BeginUpdate;
  lbHidden.Items.BeginUpdate;
  lbVisible.Clear;
  lbHidden.Clear;
  lbVisibleShadow.Clear;
  lbHiddenShadow.Clear;
  IndexList.Assign(DataSource.Dataset.FieldsIndex);
  if IndexList.Count < FieldList.count then
  begin
    IndexList.Clear;
    IndexList.Assign(FieldList);
  end;
  for I := 0 to IndexList.Count - 1 do  { Iterate }
  begin
    s := IndexList[i];
    if DataSource.Dataset.FieldByName(s).Visible then
    begin
      lbVisibleShadow.Add(s);
      if DataSource.Dataset.FieldByName(s).DisplayLabel <> '' then
        lbVisible.Items.Add(DataSource.Dataset.FieldByName(s).DisplayLabel)
      else
        lbVisible.Items.Add(s);
    end
    else
    begin
      lbHiddenShadow.Add(s);
      if DataSource.Dataset.FieldByName(s).DisplayLabel <> '' then
        lbHidden.Items.Add(DataSource.Dataset.FieldByName(s).DisplayLabel)
      else
        lbHidden.Items.Add(s);
    end;
  end;                                  { for }
  lbVisible.Items.EndUpdate;
  lbHidden.Items.EndUpdate;
end;

procedure TdlgRestructure.lbVisibleDblClick(Sender: TObject);
begin
  actHide.Execute;
end;

procedure TdlgRestructure.actHideAllExecute(Sender: TObject);
var
  I                 : Integer;
begin
  for I := 0 to lbVisibleShadow.Count - 1 do { Iterate }
  begin
    DataSource.Dataset.FieldByName(lbVisibleShadow[I]).Visible := False;
  end;
  updateBoxes;
end;

procedure TdlgRestructure.actVisibleExecute(Sender: TObject);
var
  I                 : Integer;
begin
  if lbHidden.SelCount > 0 then
  begin
    for I := 0 to lbHidden.Items.Count - 1 do { Iterate }
    begin
      DataSource.Dataset.FieldByName(lbHiddenShadow[I]).Visible :=
        lbHidden.Selected[I];
    end;
  end;
  updateBoxes;
end;

procedure TdlgRestructure.actVisibleAllExecute(Sender: TObject);
var
  I                 : Integer;
begin
  for I := 0 to lbHiddenShadow.Count - 1 do { Iterate }
  begin
    DataSource.Dataset.FieldByName(lbHiddenShadow[i]).Visible := True;
  end;
  updateBoxes;
end;

procedure TdlgRestructure.lbHiddenDblClick(Sender: TObject);
begin
  actVisible.Execute;
end;

{***************************************************************
 *
 * Procedure   : TfrmDatasetRestructure.actUpExecute
 * Purpose     : Move one or more items up in the index
 * Description : Not very elegant implementation, but it works
                 pretty well.
                 First, we'll pass all select item's indices into
                 a dynamic array. After that, we'll directly
                 alter the index-property of the selected columns
                 by one up while we loop though all entries in the
                 dynamic array. As we move from up to down in the
                 listbox, we can guarantee that movin the col's
                 won't affect the later col's
 *
 ****************************************************************}

procedure TdlgRestructure.actUpExecute(Sender: TObject);
var
  I, J              : Integer;
  selItems          : array of string;
begin
  if lbVisible.SelCount > 0 then
  begin
    if lbVisible.Selected[0] then
      SetLength(selItems, lbVisible.SelCount - 1)
    else
      SetLength(selItems, lbVisible.SelCount);
    J := 0;
    for I := 1 to lbVisible.Items.Count - 1 do { Iterate }
    begin
      if lbVisible.Selected[I] then
      begin
        selItems[J] := lbVisibleShadow[I];
        Inc(J);
      end;
    end;
    for I := 0 to High(selItems) do     { Iterate }
    begin
      DataSource.Dataset.FieldByName(selItems[I]).Index :=
        DataSource.Dataset.FieldByName(selItems[I]).Index - 1;
    end;
  end;
  updateBoxes;
  for I := 0 to High(selItems) do       { Iterate }
  begin
    lbVisible.Selected[lbVisibleShadow.IndexOf(selItems[I])] := True;
  end;                                  { for }
end;

{***************************************************************
 *
 * Procedure   : TfrmDatasetRestructure.actDownExecute
 * Purpose     : Move one or more columns down in the index
 * Description : Same trick as in the actUpExecute method.
                 By looping the columns now from last to firs
                 we can again guarantee that everything is o.k
 *
 ****************************************************************}

procedure TdlgRestructure.actDownExecute(Sender: TObject);
var
  I, J              : Integer;
  selItems          : array of string;
begin
  if lbVisible.SelCount > 0 then
  begin
    if lbVisible.Selected[lbVisible.Items.Count - 1] then
      SetLength(selItems, lbVisible.SelCount - 1)
    else
      SetLength(selItems, lbVisible.SelCount);
    J := 0;
    for I := lbVisible.Items.Count - 2 downto 0 do { Iterate }
    begin
      if lbVisible.Selected[I] then
      begin
        selItems[J] := lbVisibleShadow[I];
        Inc(J);
      end;
    end;
    for I := 0 to High(selItems) do     { Iterate }
    begin
      DataSource.Dataset.FieldByName(selItems[I]).Index :=
        DataSource.Dataset.FieldByName(selItems[I]).Index + 1;
    end;
  end;
  updateBoxes;
  for I := 0 to High(selItems) do       { Iterate }
  begin
    lbVisible.Selected[lbVisibleShadow.IndexOf(selItems[I])] := True;
  end;                                  { for }
end;

procedure TdlgRestructure.actTopExecute(Sender: TObject);
var
  I                 : Integer;
begin
  if lbVisible.SelCount > 0 then
  begin
    for I := lbVisible.Items.Count - 1 downto 1 do { Iterate }
    begin
      if lbVisible.Selected[I] then
        DataSource.Dataset.FieldByName(lbVisibleShadow[I]).Index := 0;
    end;
  end;
  updateBoxes;
end;

procedure TdlgRestructure.actBottomExecute(Sender: TObject);
var
  I                 : Integer;
begin
  if lbVisible.SelCount > 0 then
  begin
    for I := 0 to lbVisible.Items.Count - 2 do { Iterate }
    begin
      if lbVisible.Selected[I] then
        DataSource.Dataset.FieldByName(lbVisibleShadow[I]).Index :=
          IndexList.Count - 1;
    end;
  end;
  updateBoxes;
end;

procedure TdlgRestructure.lbVisibleDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False;
  if (Source is TListBox) then
  begin
    if TListBox(Source).Name = 'lbHidden' then
      Accept := True;
  end;
end;

procedure TdlgRestructure.lbVisibleDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  actVisible.Execute;
end;

procedure TdlgRestructure.lbHiddenDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False;
  if (Source is TListBox) then
  begin
    if TListBox(Source).Name = 'lbVisible' then
      Accept := True;
  end;
end;

procedure TdlgRestructure.lbHiddenDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  actHide.Execute;
end;

end.

