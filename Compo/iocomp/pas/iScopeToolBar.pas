{*******************************************************}
{                                                       }
{       TiScopeToolBar Object                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScopeToolBar;{$endif}
{$ifdef iCLX}unit QiScopeToolBar;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iScopePanelToolBar;{$ENDIF}
  {$IFDEF iCLX}QiScopePanelToolBar;{$ENDIF}

type
  TiScopeToolBar = class(TPersistent)
  private
    FPanelToolBar    : TiScopePanelToolBar;

    function GetCursorActive: Boolean;
  protected

  public
    constructor Create(PanelToolBar: TiScopePanelToolBar);  virtual;
    destructor  Destroy; override;

    property  CursorActive : Boolean read GetCursorActive;

    procedure DoButtonClickCursor;
    procedure DoButtonClickEdit;
    procedure DoButtonClickCopy;
    procedure DoButtonClickSave;
    procedure DoButtonClickPrint;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiScopeToolBar.Create(PanelToolBar: TiScopePanelToolBar);
begin
  FPanelToolBar := PanelToolBar;
end;
//****************************************************************************************************************************************************
destructor TiScopeToolBar.Destroy;
begin
  inherited Destroy;
end;
//****************************************************************************************************************************************************
procedure TiScopeToolBar.DoButtonClickCopy;
begin
  FPanelToolBar.DoButtonClickCopy;
end;
//****************************************************************************************************************************************************
procedure TiScopeToolBar.DoButtonClickCursor;
begin
  FPanelToolBar.DoButtonClickCursor;
end;
//****************************************************************************************************************************************************
procedure TiScopeToolBar.DoButtonClickEdit;
begin
  FPanelToolBar.DoButtonClickEdit;
end;
//****************************************************************************************************************************************************
procedure TiScopeToolBar.DoButtonClickPrint;
begin
  FPanelToolBar.DoButtonClickPrint;
end;
//****************************************************************************************************************************************************
procedure TiScopeToolBar.DoButtonClickSave;
begin
  FPanelToolBar.DoButtonClickSave;
end;
//****************************************************************************************************************************************************
function TiScopeToolBar.GetCursorActive: Boolean;
begin
  Result := FPanelToolBar.CursorActive;
end;
//****************************************************************************************************************************************************
end.


