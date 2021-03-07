{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotPackPropertyEditorsReg;{$endif}
{$ifdef iCLX}unit QiPlotPackPropertyEditorsReg;{$endif}

interface

uses
{$I iIncludeUses.inc}
{$IFDEF iVCL}{$IFDEF COMPILER_6_UP}DesignIntf, DesignEditors,{$ELSE}Dsgnintf,{$ENDIF} iComponentEditor,{$ENDIF}
{$IFDEF iCLX}DesignIntf, DesignEditors,                                              QiComponentEditor,{$ENDIF}

{$ifdef iVCL}
  iPlot,
  iXYPlot,
  iScope,
  iPlotComponentEditor,
  iScopeComponentEditor;
{$endif}

{$ifdef iCLX}
  QiPlot,
  QiXYPlot,
  QiScope,
  QiPlotComponentEditor,
  QiScopeComponentEditor;
{$endif}

type
  TiPlotComponentEditor  = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;
  TiScopeComponentEditor = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;

procedure Register;

implementation
//****************************************************************************************************************************************************
procedure TiPlotComponentEditor.ExecuteVerb(Index: Integer);
begin
  DoEdit2(TiPlotComponentEditorForm);
end;
//****************************************************************************************************************************************************
procedure TiScopeComponentEditor.ExecuteVerb(Index: Integer);
begin
  DoEdit2(TiScopeComponentEditorForm);
end;
//****************************************************************************************************************************************************
procedure Register;
begin
  RegisterComponentEditor(TiPlot,   TiPlotComponentEditor);
  RegisterComponentEditor(TiXYPlot, TiPlotComponentEditor);
  RegisterComponentEditor(TiScope,  TiScopeComponentEditor);
end;
//****************************************************************************************************************************************************
end.
