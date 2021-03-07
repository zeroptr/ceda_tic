{*******************************************************}
{                                                       }
{       TiScopeDisplay Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScopeDisplay;{$endif}
{$ifdef iCLX}unit QiScopeDisplay;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions,{$ENDIF}
  {$IFDEF iVCL} iPlot,  iPlotAnnotation,  iScopeChannel,  iScopePanelChannels;{$ENDIF}
  {$IFDEF iCLX}QiPlot, QiPlotAnnotation, QiScopeChannel, QiScopePanelChannels;{$ENDIF}


type
  TiScopeDisplay = class(TPersistent)
  private
    FPlot                 : TiPlot;
    FPanelChannels        : TiScopePanelChannels;
    FTimeBaseAnnotation   : TiPlotAnnotation;
    FHorzScrollAnnotation : TiPlotAnnotation;
  protected
    function GetGridColor      : TColor;
    function GetTextShow       : Boolean;
    function GetHorzScrollShow : Boolean;

    procedure SetGridColor     (const Value: TColor);
    procedure SetTextShow      (const Value: Boolean);
    procedure SetHorzScrollShow(const Value: Boolean);

    property Plot                 : TiPlot               read FPlot                 write FPlot;
    property PanelChannels        : TiScopePanelChannels read FPanelChannels        write FPanelChannels;
    property TimeBaseAnnotation   : TiPlotAnnotation     read FTimeBaseAnnotation   write FTimeBaseAnnotation;
    property HorzScrollAnnotation : TiPlotAnnotation     read FHorzScrollAnnotation write FHorzScrollAnnotation;
  public
    destructor  Destroy; override;
  published
    property GridColor      : TColor  read GetGridColor      write SetGridColor      default $808000;
    property TextShow       : Boolean read GetTextShow       write SetTextShow       default False;
    property HorzScrollShow : Boolean read GetHorzScrollShow write SetHorzScrollShow default False;
  end;

implementation

type
  TiScopeChannelAccess   = class(TiScopeChannel)end;
//****************************************************************************************************************************************************
destructor TiScopeDisplay.Destroy;
begin
  inherited Destroy;
end;
//****************************************************************************************************************************************************
function TiScopeDisplay.GetGridColor: TColor;
begin
  Result := FPlot.DataView[0].GridLineColor;
end;
//****************************************************************************************************************************************************
function TiScopeDisplay.GetTextShow: Boolean;
begin
  Result := FTimeBaseAnnotation.Visible;
end;
//****************************************************************************************************************************************************
function TiScopeDisplay.GetHorzScrollShow: Boolean;
begin
  Result := FHorzScrollAnnotation.Visible;
end;
//****************************************************************************************************************************************************
procedure TiScopeDisplay.SetGridColor(const Value: TColor);
begin
  FPlot.DataView[0].GridLineColor := Value;
  FPlot.XAxis[0].ScaleLinesColor  := Value;
  FPlot.YAxis[0].ScaleLinesColor  := Value;
end;
//****************************************************************************************************************************************************
procedure TiScopeDisplay.SetTextShow(const Value: Boolean);
var
  x : Integer;
begin
  FTimeBaseAnnotation.Visible := Value;
  for x := 0 to FPanelChannels.Count-1 do
    TiScopeChannelAccess(FPanelChannels.ScopeChannel[x]).Annotation.Visible := Value;
end;
//****************************************************************************************************************************************************
procedure TiScopeDisplay.SetHorzScrollShow(const Value: Boolean);
begin
  FHorzScrollAnnotation.Visible := Value;
end;
//****************************************************************************************************************************************************
end.


