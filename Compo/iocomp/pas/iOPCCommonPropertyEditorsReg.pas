{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCCommonPropertyEditorsReg;{$endif}
{$ifdef iCLX}unit QiOPCCommonPropertyEditorsReg;{$endif}

interface

uses
{$I iIncludeUses.inc}
{$IFDEF iVCL}{$IFDEF COMPILER_6_UP}DesignIntf, DesignEditors,{$ELSE}Dsgnintf,{$ENDIF} iComponentEditor,{$ENDIF}
{$IFDEF iCLX}DesignIntf, DesignEditors,                                              QiComponentEditor,{$ENDIF}

{$ifdef iVCL}
  iOPCManager,
  iOPCManagerComponentEditor;
{$endif}

{$ifdef iCLX}
  QiOPCManager,
  QiOPCManagerComponentEditor;
{$endif}

type
  TiOPCManagerComponentEditor  = class(TiComponentEditor) procedure ExecuteVerb(Index : Integer); override; end;

procedure Register;

implementation
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditor.ExecuteVerb(Index: Integer);
begin
  DoEdit2(TiOPCManagerComponentEditorForm);
end;
//****************************************************************************************************************************************************
procedure Register;
begin
  RegisterComponentEditor(TiOPCManager,   TiOPCManagerComponentEditor);
end;
//****************************************************************************************************************************************************
end.
