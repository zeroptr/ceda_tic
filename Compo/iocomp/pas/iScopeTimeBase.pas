{*******************************************************}
{                                                       }
{       TiScopeTimeBase Object                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScopeTimeBase;{$endif}
{$ifdef iCLX}unit QiScopeTimeBase;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iScopePanelTimeBase;{$ENDIF}
  {$IFDEF iCLX}QiScopePanelTimeBase;{$ENDIF}

type
  TiScopeTimeBase = class(TPersistent)
  private
    FPanelTimeBase : TiScopePanelTimeBase;
  protected
    procedure SetPosition   (const Value: Double);
    procedure SetPostCapture(const Value: Double);
    procedure SetPreCapture (const Value: Double);
    procedure SetSecPerDiv  (const Value: Double);

    function GetPosition   : Double;
    function GetPostCapture: Double;
    function GetPreCapture : Double;
    function GetSecPerDiv  : Double;
  public
    constructor Create(PanelTimeBase: TiScopePanelTimeBase);  virtual;
    destructor  Destroy; override;

    procedure AddSecPerDiv(Text: String; Value: double);
    procedure RemoveAllSecPerDiv;
  published
    property SecPerDiv   : Double read GetSecPerDiv   write SetSecPerDiv;
    property Position    : Double read GetPosition    write SetPosition;

    property PreCapture  : Double read GetPreCapture  write SetPreCapture;
    property PostCapture : Double read GetPostCapture write SetPostCapture;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiScopeTimeBase.Create(PanelTimeBase: TiScopePanelTimeBase);
begin
  FPanelTimeBase := PanelTimeBase;
end;
//****************************************************************************************************************************************************
destructor TiScopeTimeBase.Destroy;
begin
  inherited Destroy;
end;
//****************************************************************************************************************************************************
function TiScopeTimeBase.GetPosition   : Double;begin Result := FPanelTimeBase.Position;   end;
function TiScopeTimeBase.GetPostCapture: Double;begin Result := FPanelTimeBase.PostCapture;end;
function TiScopeTimeBase.GetPreCapture : Double;begin Result := FPanelTimeBase.PreCapture; end;
function TiScopeTimeBase.GetSecPerDiv  : Double;begin Result := FPanelTimeBase.SecPerDiv;  end;
//****************************************************************************************************************************************************
procedure TiScopeTimeBase.SetPosition   (const Value: Double);begin FPanelTimeBase.Position    := Value;end;
procedure TiScopeTimeBase.SetPostCapture(const Value: Double);begin FPanelTimeBase.PostCapture := Value;end;
procedure TiScopeTimeBase.SetPreCapture (const Value: Double);begin FPanelTimeBase.PreCapture  := Value;end;
procedure TiScopeTimeBase.SetSecPerDiv  (const Value: Double);begin FPanelTimeBase.SecPerDiv   := Value;end;
//****************************************************************************************************************************************************
procedure TiScopeTimeBase.AddSecPerDiv(Text: String; Value: double);
begin
  FPanelTimeBase.SecPerDivSelector.AddItem(Text, Value);
end;
//****************************************************************************************************************************************************
procedure TiScopeTimeBase.RemoveAllSecPerDiv;
begin
  FPanelTimeBase.SecPerDivSelector.RemoveAllItems;
end;
//****************************************************************************************************************************************************
end.


