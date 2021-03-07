{**********************************************}
{   TTree Component Library.                   }
{   Page Navigator Component.                  }
{   Copyright (c) 1998-2009 by David Berneda   }
{**********************************************}
{$I TeeDefs.inc}
unit TreeNavigator;

interface

Uses {$IFDEF CLX}
     TeePreviewPanel,
     {$ELSE}
     Dialogs,
     {$ENDIF}
     Classes, TeeTree, TeeProcs, TeeNavigator;

type
  TTreePageNavigator=class(TCustomTeeNavigator)
  private
    function GetTree: TCustomTree;
    procedure SetTree(const Value: TCustomTree);
  protected
    procedure BtnClick(Index: TTeeNavigateBtn); override;
    procedure DoTeeEvent(Event: TTeeEvent); override;
  public
    procedure EnableButtons; override;
    procedure Print; override;
    procedure PrintPages(FromPage, ToPage: Integer);
  published
    property Tree:TCustomTree read GetTree write SetTree;
    property OnButtonClicked;
  end;

// Show and return a Print dialog. Supports multiple pages and copies.
Function TreePrintDialog(Tree:TCustomTree):TPrintDialog;

implementation

uses {$IFDEF CLX}
     QPrinters,
     {$ELSE}
     Printers,
     {$ENDIF}
     SysUtils;

{ TTreePageNavigator }

procedure TTreePageNavigator.BtnClick(Index: TTeeNavigateBtn);
var tmp : TCustomTree;
begin
  tmp:=Tree;
  if Assigned(tmp) then
  with tmp.Page do
  case Index of
    nbPrior : if Page>1 then Page:=Page-1;
    nbNext  : if Page<Count then Page:=Page+1;
    nbFirst : if Page>1 then Page:=1;
    nbLast  : if Page<Count then Page:=Count;
  end;
  EnableButtons;
  inherited;
end;

procedure TTreePageNavigator.DoTeeEvent(Event: TTeeEvent);
begin
  if Event is TTreeAfterDrawEvent then
     EnableButtons;
end;

procedure TTreePageNavigator.EnableButtons;
var tmp : TCustomTree;
begin
  inherited;
  tmp:=Tree;
  if Assigned(tmp) then
  begin
    Enabled:=tmp.Page.Count>0;
    Buttons[nbFirst].Enabled:=tmp.Page.Page>1;
    Buttons[nbPrior].Enabled:=Buttons[nbFirst].Enabled;
    Buttons[nbNext].Enabled:=tmp.Page.Page<tmp.Page.Count;
    Buttons[nbLast].Enabled:=Buttons[nbNext].Enabled;
  end
  else Enabled:=False;
end;

function TTreePageNavigator.GetTree: TCustomTree;
begin
  result:=TCustomTree(Panel);
end;

Function TreePrintDialog(Tree:TCustomTree):TPrintDialog;
begin
  result:=TPrintDialog.Create(nil);
  with result do
  begin
    if Tree.Page.Count>1 then
    begin
      {$IFNDEF CLX}
      Options:=[poPageNums];
      PrintRange:=prPageNums;
      {$ENDIF}
    end;
    MinPage:=1;
    MaxPage:=Tree.Page.Count;
    FromPage:=MinPage;
    ToPage:=MaxPage;
  end;
end;

procedure TTreePageNavigator.Print;
var t : Integer;
begin
//  if Tree.Page.Count>1 then
  if Tree.Page.Count>0 then //tom:09/09/2002 don't know if this is correct,
                            // but it solves the problem when only 1 page exists
     with TreePrintDialog(Tree) do
     try
       if Execute then
          for t:=1 to Copies do
              PrintPages(FromPage,ToPage);
     finally
       Free;
     end;
end;

procedure TTreePageNavigator.SetTree(const Value: TCustomTree);
begin
  Panel:=Value;
end;

procedure TTreePageNavigator.PrintPages(FromPage, ToPage: Integer);
var tmpOld : Integer;
    t      : Integer;
begin
  if Name<>'' then Printer.Title:=Name; { 5.01 }
  Printer.BeginDoc;
  try
    if ToPage=0 then ToPage:=Tree.Page.Count;
    if FromPage=0 then FromPage:=1;
    tmpOld:=Tree.Page.Page;
    try
      for t:=FromPage to ToPage do
      begin
        Tree.Page.Page:=t;
        //Print
        Tree.PrintPartial(Tree.ChartPrintRect); //tom: 09/09/2002
        if t<ToPage then Printer.NewPage;
      end;
    finally
      Tree.Page.Page:=tmpOld;
    end;
    Printer.EndDoc;
  except
    on Exception do
    begin
      Printer.Abort;
      if Printer.Printing then Printer.EndDoc;
      Raise;
    end;
  end;
end;

end.
