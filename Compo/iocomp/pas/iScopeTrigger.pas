{*******************************************************}
{                                                       }
{       TiScopeTrigger Object                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScopeTrigger;{$endif}
{$ifdef iCLX}unit QiScopeTrigger;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iScopePanelTrigger;{$ENDIF}
  {$IFDEF iCLX}QiScopePanelTrigger;{$ENDIF}

type
  TiScopeTrigger = class(TPersistent)
  private
    FScopePanelTrigger : TiScopePanelTrigger;
  protected
    function GetAuto         : Boolean;
    function GetLevel        : Double;
    function GetPositiveSlope: Boolean;
    function GetSourceIndex  : Integer;

    procedure SetAuto         (const Value: Boolean);
    procedure SetLevel        (const Value: Double);
    procedure SetPositiveSlope(const Value: Boolean);
    procedure SetSourceIndex  (const Value: Integer);
  public
    constructor Create(ScopePanelTrigger: TiScopePanelTrigger);  virtual;
    destructor  Destroy; override;

    procedure ManualTrigger;
  published
    property Level           : Double  read GetLevel         write SetLevel;
    property PositiveSlope   : Boolean read GetPositiveSlope write SetPositiveSlope;
    property SourceIndex     : Integer read GetSourceIndex   write SetSourceIndex;
    property Auto            : Boolean read GetAuto          write SetAuto;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiScopeTrigger.Create(ScopePanelTrigger: TiScopePanelTrigger);
begin
  FScopePanelTrigger := ScopePanelTrigger;
end;
//****************************************************************************************************************************************************
destructor TiScopeTrigger.Destroy;
begin
  inherited Destroy;
end;
//****************************************************************************************************************************************************
function TiScopeTrigger.GetAuto         : Boolean;begin Result := FScopePanelTrigger.Auto;         end;
function TiScopeTrigger.GetLevel        : Double; begin Result := FScopePanelTrigger.Level;        end;
function TiScopeTrigger.GetPositiveSlope: Boolean;begin Result := FScopePanelTrigger.PositiveSlope;end;
function TiScopeTrigger.GetSourceIndex  : Integer;begin Result := FScopePanelTrigger.SourceIndex;  end;
//****************************************************************************************************************************************************
procedure TiScopeTrigger.SetLevel        (const Value: Double );begin FScopePanelTrigger.Level         := Value;end;
procedure TiScopeTrigger.SetPositiveSlope(const Value: Boolean);begin FScopePanelTrigger.PositiveSlope := Value;end;
procedure TiScopeTrigger.SetSourceIndex  (const Value: Integer);begin FScopePanelTrigger.SourceIndex   := Value;end;
procedure TiScopeTrigger.SetAuto         (const Value: Boolean);begin FScopePanelTrigger.Auto          := Value;end;
procedure TiScopeTrigger.ManualTrigger;                         begin FScopePanelTrigger.ManualTrigger;         end;
//****************************************************************************************************************************************************

end.


