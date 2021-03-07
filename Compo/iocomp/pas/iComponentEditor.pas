{*******************************************************}
{                                                       }
{       TiComponentEditor Component                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iComponentEditor;{$endif}
{$ifdef iCLX}unit QiComponentEditor;{$endif}

interface

uses
{$I iIncludeUses.inc}
{$IFDEF iVCL}{$IFDEF COMPILER_6_UP}DesignIntf, DesignEditors,{$ELSE}Dsgnintf,{$ENDIF} iComponentEditorForm;{$ENDIF}
{$IFDEF iCLX}DesignIntf, DesignEditors,                                       QiComponentEditorForm;{$ENDIF}

type
  TiComponentEditorFormClass = class of TiComponentEditorForm;
  
  TiComponentEditor = class(TComponentEditor)
  public

    function  GetVerbCount             : Integer; override;
    function  GetVerb(Index : Integer) : String;  override;
    procedure DoEdit (iComponentEditorForm      : TiComponentEditorForm);
    procedure DoEdit2(iComponentEditorFormClass : TiComponentEditorFormClass);
  published

  end;

implementation
//***********************************************************************************************************************************
function TiComponentEditor.GetVerb(Index: Integer): String;
begin
  Result := 'Edit...';
end;
//***********************************************************************************************************************************
function TiComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;
//***********************************************************************************************************************************
procedure TiComponentEditor.DoEdit(iComponentEditorForm : TiComponentEditorForm);
begin
  iComponentEditorForm.SetupEditor;
  if not Assigned(Designer) then iComponentEditorForm.ReadOnly := True;
  iComponentEditorForm.ShowModal;
  if iComponentEditorForm.ChangesApplied then if Assigned(Designer) then Designer.Modified;
end;
//***********************************************************************************************************************************
procedure TiComponentEditor.DoEdit2(iComponentEditorFormClass: TiComponentEditorFormClass);
var
  AForm : TiComponentEditorForm;
begin
  AForm := iComponentEditorFormClass.Create(Application);
  try
    AForm.iComponent := Component as TWinControl;
    DoEdit(AForm);
  finally
    AForm.Free;
  end;
end;
//***********************************************************************************************************************************
end.
