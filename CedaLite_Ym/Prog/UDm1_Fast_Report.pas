unit UDm1_Fast_Report;

interface

uses
  SysUtils, Classes, fs_ichartrtti, fs_iibxrtti, fs_idbctrlsrtti,
  fs_idbrtti, fs_ibdertti, fs_iadortti, fs_idialogsrtti, fs_iextctrlsrtti,
  fs_iformsrtti, fs_igraphicsrtti, fs_iclassesrtti, fs_ibasic, fs_ijs,
  fs_icpp, fs_ipascal, fs_iinterpreter, frxExportODF, frxExportTXT,
  frxExportMail, frxExportCSV, frxExportText, frxExportImage, frxExportRTF,
  frxExportXML, frxExportXLS, frxExportHTML, frxExportPDF, frxChart,
  frxIBXComponents,  frxClass, frxDBSet, frxBDEComponents,
  frxADOComponents, frxCrypt, frxGZip, frxDCtrl, frxDMPExport, frxGradient,
  frxChBox, frxCross, frxRich, frxOLE, frxBarcode, frxDesgn;

type
  TDm1_Fast_Report = class(TDataModule)
    frxUserDataSet1: TfrxUserDataSet;
    frxDesigner1: TfrxDesigner;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxOLEObject1: TfrxOLEObject;
    frxRichObject1: TfrxRichObject;
    frxCrossObject1: TfrxCrossObject;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    frxGradientObject1: TfrxGradientObject;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxDialogControls1: TfrxDialogControls;
    frxGZipCompressor1: TfrxGZipCompressor;
    frxCrypt1: TfrxCrypt;
    frxADOComponents1: TfrxADOComponents;
    frxBDEComponents1: TfrxBDEComponents;
    frxDBDataset1: TfrxDBDataset;
    frxIBXComponents1: TfrxIBXComponents;
    frxChartObject1: TfrxChartObject;
    fsScript1: TfsScript;
    fsPascal1: TfsPascal;
    fsCPP1: TfsCPP;
    fsJScript1: TfsJScript;
    fsBasic1: TfsBasic;
    fsClassesRTTI1: TfsClassesRTTI;
    fsGraphicsRTTI1: TfsGraphicsRTTI;
    fsFormsRTTI1: TfsFormsRTTI;
    fsExtCtrlsRTTI1: TfsExtCtrlsRTTI;
    fsDialogsRTTI1: TfsDialogsRTTI;
    fsADORTTI1: TfsADORTTI;
    fsBDERTTI1: TfsBDERTTI;
    fsDBRTTI1: TfsDBRTTI;
    fsDBCtrlsRTTI1: TfsDBCtrlsRTTI;
    fsIBXRTTI1: TfsIBXRTTI;
    fsChartRTTI1: TfsChartRTTI;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm1_Fast_Report: TDm1_Fast_Report;

implementation

{$R *.dfm}

end.
