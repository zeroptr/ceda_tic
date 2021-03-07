{*******************************************************}
{                                                       }
{       iComponentEditorThemePanelAddDialog             }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iComponentEditorThemePanelAddDialog;{$endif}
{$ifdef iCLX}unit QiComponentEditorThemePanelAddDialog;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}
  {$IFDEF iVCL}  iTypes,  iGPFunctions,  StdCtrls,  Controls, Classes;{$ENDIF}
  {$IFDEF iCLX} QiTypes, QiGPFunctions, QStdCtrls, QControls, Classes;{$ENDIF}

type
  TiComponentEditorThemePanelAddDialogForm = class(TForm)
    SchemeNameLabel: TLabel;
    SchemeName: TEdit;
    OkButton: TButton;
    CancelButton: TButton;
  public
  end;

var
  iComponentEditorThemePanelAddDialogForm: TiComponentEditorThemePanelAddDialogForm;

implementation

{$R *.dfm}

end.
