{*******************************************************}
{                                                       }
{       TiPlot Component                                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlot;{$endif}
{$ifdef iCLX}unit QiPlot;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iPlotComponent,  iPlotChannel;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiPlotComponent, QiPlotChannel;{$ENDIF}

type
  TiPlot = class(TiPlotComponent)
  private
    function GetChannel(Index: Integer): TiPlotChannel;
  protected

  public
    constructor Create(AOwner: TComponent);  override;

    property Channel [Index:Integer] : TiPlotChannel read GetChannel;
  published

  end;

implementation
//****************************************************************************************************************************************************
constructor TiPlot.Create(AOwner: TComponent);
var
  Index : Integer;
begin
  inherited Create(AOwner);

  BeginUpdate;
  try
    Master.ChannelClass := TiPlotChannel;

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
  finally
    EndUpdate;
  end; 
end;
//****************************************************************************************************************************************************
function TiPlot.GetChannel(Index: Integer): TiPlotChannel;
begin
  Result := inherited Channel[Index] as TiPlotChannel;
end;
//****************************************************************************************************************************************************
end.

