{*******************************************************}
{                                                       }
{       TiPlotPreview                                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotPreviewSettings;{$endif}
{$ifdef iCLX}unit QiPlotPreviewSettings;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} Printers,  iComponent,  iCustomComponent,  iVCLComponent,  iEditorBasicComponents,  iCheckBox,  iRadioGroup,{$ENDIF}
  {$IFDEF iCLX}QPrinters, QiComponent, QiCustomComponent, QiCLXComponent, QiEditorBasicComponents, QiCheckBox, QiRadioGroup,  {$ENDIF}

  {$IFDEF iVCL} StdCtrls,  Controls,  ComCtrls,  ExtCtrls, Classes,  Menus,  Buttons;{$ENDIF}
  {$IFDEF iCLX}QStdCtrls, QControls, QComCtrls, QExtCtrls, Classes, QMenus, QButtons;{$ENDIF}


type
  TiPlotPreviewSettingsForm = class(TForm)
    PrinterMarginGroupBox: TGroupBox;
    PrintMarginLeftEdit: TiComponentEditorEdit;
    PrintMarginTopEdit: TiComponentEditorEdit;
    PrintMarginBottomEdit: TiComponentEditorEdit;
    PrintMarginRightEdit: TiComponentEditorEdit;
    PrintOrientationRadioGroup: TiComponentEditorRadioGroup;
    Label175: TLabel;
    PrintDocumentNameEdit: TiComponentEditorEdit;
    Label120: TLabel;
    PrintPaperSizeComboBox: TiComponentEditorComboBox;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  iPlotPreviewSettingsForm: TiPlotPreviewSettingsForm;

implementation

{$R *.dfm}

end.
