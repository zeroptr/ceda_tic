{*******************************************************}
{                                                       }
{       TiXYPlot Component                              }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iXYPlot;{$endif}
{$ifdef iCLX}unit QiXYPlot;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iPlotComponent,  iXYPlotChannel;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiPlotComponent, QiXYPlotChannel;{$ENDIF}

type
  TiXYPlot = class(TiPlotComponent)
  private
    function GetChannel(Index: Integer): TiXYPlotChannel;
  protected

  public
    constructor Create(AOwner: TComponent);  override;
    property Channel [Index:Integer] : TiXYPlotChannel   read GetChannel;
  published

  end;

implementation
//****************************************************************************************************************************************************
constructor TiXYPlot.Create(AOwner: TComponent);
var
  Index : Integer;
begin
  inherited Create(AOwner);

  Master.ChannelClass := TiXYPlotChannel;
  
  Master.LayoutManager.Enabled := False;
  try
    ToolBar[AddToolBar].ZOrder := 3;
    Legend [AddLegend ].ZOrder := 2;
    AddXAxis;
    AddYAxis;
    AddChannel;
    AddDataView;
    AddDataCursor;

    Index                      := AddLabel;
    Labels[Index].ZOrder       := 2;
    Labels[Index].Name         := 'Title';
    Labels[Index].Caption      := 'Untitled';
    Labels[Index].MarginBottom := 0;
  finally
    Master.LayoutManager.Enabled := True;
  end;
end;
//****************************************************************************************************************************************************
function TiXYPlot.GetChannel(Index: Integer): TiXYPlotChannel;
begin
  Result := inherited Channel[Index] as TiXYPlotChannel;
end;
//****************************************************************************************************************************************************
end.

