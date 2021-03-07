unit dxPScxCommonReg;

interface

{$I cxVer.inc}

procedure Register;

implementation

uses
   {$IFDEF DELPHI6} 
    DesignIntf, DesignEditors, 
   {$ELSE} 
    DsgnIntf, 
   {$ENDIF} 
  SysUtils, TypInfo, Classes, cxClasses, cxLookAndFeels, dxPScxCommon;

type
  TdxReportLinkLookAndFeelKindPropertyEditor = class(TEnumProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;
  
  TdxReportLinkOptionsPropertyEditor = class(TClassProperty)
  private
    function GetOptions: TdxCustomReportLinkOptions;
    function GetReportLink: TdxCustomcxControlReportLink;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    property Options: TdxCustomReportLinkOptions read GetOptions;
    property ReportLink: TdxCustomcxControlReportLink read GetReportLink;
  end;

  TdxReportLinkStylesPropertyEditor = class(TClassProperty)
  private
    function GetReportLink: TdxCustomcxControlReportLink;
    function GetStyles: TdxCustomReportLinkStyles;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    property Styles: TdxCustomReportLinkStyles read GetStyles;
    property ReportLink: TdxCustomcxControlReportLink read GetReportLink;
  end;
  
{ TdxReportLinkLookAndFeelKindPropertyEditor }
    
procedure TdxReportLinkLookAndFeelKindPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := Integer(lfFlat) to Integer(lfUltraFlat) do 
    Proc(GetEnumName(GetPropType, I));
end;
    
{ TdxReportLinkOptionsPropertyEditor }
    
procedure TdxReportLinkOptionsPropertyEditor.Edit;
var
  DesignerSupport: IdxReportLinkOptionsDesignerSupport;
begin
  if Supports(TObject(Options), IdxReportLinkOptionsDesignerSupport, DesignerSupport) then
  begin
    DesignerSupport.DesignerInitialize;
    try
      ReportLink.DesignReport;
    finally
      DesignerSupport.DesignerFinalize;
    end;
  end;  
end;
  
function TdxReportLinkOptionsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog]; // TODO: ReportLink.CanDesign
end;

function TdxReportLinkOptionsPropertyEditor.GetOptions: TdxCustomReportLinkOptions;
begin
  Result := TdxCustomReportLinkOptions(GetOrdValue);
end;

function TdxReportLinkOptionsPropertyEditor.GetReportLink: TdxCustomcxControlReportLink;
begin
  Result := TdxCustomcxControlReportLink(GetComponent(0));
end;
    
{ TdxReportLinkStylesPropertyEditor }
    
procedure TdxReportLinkStylesPropertyEditor.Edit;
var
  DesignerSupport: IdxReportLinkOptionsDesignerSupport;
begin
  if Supports(TObject(Styles), IdxReportLinkOptionsDesignerSupport, DesignerSupport) then
  begin
    DesignerSupport.DesignerInitialize;
    try
      ReportLink.DesignReport;
    finally
      DesignerSupport.DesignerFinalize;
    end;
  end;  
end;

function TdxReportLinkStylesPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog]; // TODO: ReportLink.CanDesign
end;

function TdxReportLinkStylesPropertyEditor.GetReportLink: TdxCustomcxControlReportLink;
begin
  Result := TdxCustomcxControlReportLink(GetComponent(0));
end;

function TdxReportLinkStylesPropertyEditor.GetStyles: TdxCustomReportLinkStyles;
begin
  Result := TdxCustomReportLinkStyles(GetOrdValue);
end;
        
procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}  

  RegisterPropertyEditor(TypeInfo(TcxLookAndFeelKind), TdxCustomReportLinkOptionsFormatting, 
    'LookAndFeelKind', TdxReportLinkLookAndFeelKindPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxCustomReportLinkOptions), 
    TdxCustomcxControlReportLink, '', TdxReportLinkOptionsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TdxCustomReportLinkStyles), 
    TdxCustomcxControlReportLink, '', TdxReportLinkStylesPropertyEditor);
end;

end.
