{*******************************************************************}
{                                                                   }
{       Developer Express Cross Platform Component Library          }
{       ExpressQuantumGrid                                          }
{                                                                   }
{       Copyright (c) 2001-2009 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}
unit cxGridImportDialog;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  DesignIntf, Variants,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxConverterFactory, cxGridConverter, cxGrid, TypInfo,
  cxGridStructureNavigator, cxGridLevel, cxGridCustomView, ComCtrls, cxStyles,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls, cxPC, cxContainer,
  cxEdit, cxCheckBox, cxRadioGroup, cxGraphics, cxMaskEdit, cxDropDownEdit,
  cxTextEdit, cxDesignWindows;

type
  TImportDialog = class(TForm)
    Panel1: TPanel;
    btnImport: TcxButton;
    btnClose: TcxButton;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    lbComponentsForImport: TListBox;
    Panel6: TPanel;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    cbDeleteAllSublevels: TcxCheckBox;
    TabSheet2: TcxTabSheet;
    cbImportStyles: TcxCheckBox;
    Panel7: TPanel;
    lblLevelName: TLabel;
    Label1: TLabel;
    pnlStructureControlSite: TPanel;
    Panel3: TPanel;
    Panel8: TPanel;
    rbCreateNewStyleRepository: TcxRadioButton;
    rbUseExistingStyleRepository: TcxRadioButton;
    edNewStyleRepository: TcxTextEdit;
    cbStyleRepositories: TcxComboBox;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure lbComponentsForImportClick(Sender: TObject);
    procedure lbComponentsForImportDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbImportStylesClick(Sender: TObject);
    procedure rbStyleRepositoryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbComponentsForImportMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
  private
    { Private declarations }
    FGrid: TcxCustomGrid;
    FDesigner: IDesigner;
    FGridStructureControl: TcxGridStructureControl;
    FGridStructureHelper: TcxGridStructureHelper;
    FIntermediaryList: TStringList;
    FLevel: TcxGridLevel;
    function GetComponent: TComponent;
    procedure SetGrid(Value: TcxCustomGrid);
    procedure SetLevel(Value: TcxGridLevel);

    function GetConverterClass(ASource: TObject): TcxCustomGridConverterClass;
    procedure LoadComponentForImport(const S: string);
    procedure LoadIntermediary(const S: string);
    procedure LoadStyleRepository(const S: string);
    procedure DoImport;
    procedure DisableStylesOptions;
    procedure EnableStylesOptions;
    function GetIntermediaryComponent: TComponent;
    procedure StructureControlSelectionChanged(Sender: TObject);
    procedure UpdateDesigner(Sender: TObject);
    procedure UpdateStyleRepositoryEdits;
  protected
    property Component: TComponent read GetComponent;
    property Level: TcxGridLevel read FLevel write SetLevel;
  public
    { Public declarations }
    property Grid: TcxCustomGrid read FGrid write SetGrid;
    property Designer: IDesigner read FDesigner write FDesigner;
  end;

  procedure ShowGridImportDialog(ADesigner: IDesigner; AGrid: TcxCustomGrid);

implementation

{$R *.dfm}

uses
  cxLookAndFeels;

procedure ShowGridImportDialog(ADesigner: IDesigner; AGrid: TcxCustomGrid);
var
  ADialog: TImportDialog;
begin
  ADialog := TImportDialog.Create(Application);
  try
    ADialog.Grid := AGrid;
    ADialog.Designer := ADesigner;
    ADialog.ShowModal;
  finally
    ADialog.Free;
  end;
end;

procedure TImportDialog.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TImportDialog.FormShow(Sender: TObject);
begin
  FDesigner.GetComponentNames(GetTypeData(PTypeInfo(TComponent.ClassInfo)),
    LoadComponentForImport);

  UpdateStyleRepositoryEdits;
  EnableStylesOptions;
end;

procedure TImportDialog.btnImportClick(Sender: TObject);
begin
  DoImport;
end;

function TImportDialog.GetComponent: TComponent;
begin
  if lbComponentsForImport.ItemIndex = -1 then
    Result := nil
  else
    Result := lbComponentsForImport.Items.Objects[lbComponentsForImport.ItemIndex] as TComponent;
end;

procedure TImportDialog.SetGrid(Value: TcxCustomGrid);
var
  AList: TList;
begin
  if FGrid <> Value then
  begin
    FGrid := Value;
    FGridStructureControl.Grid := FGrid;
    if FGrid <> nil then
    begin
      AList := TList.Create;
      try
        AList.Add(FGrid);
        FGridStructureControl.SyncSelection(AList);
      finally
        AList.Free;
      end;
      Level := nil;
    end;
  end;
end;

procedure TImportDialog.SetLevel(Value: TcxGridLevel);
begin
  FLevel := Value;
  if FLevel = nil then
    lblLevelName.Caption := Grid.Name
  else
    lblLevelName.Caption := FLevel.Name;
end;

function TImportDialog.GetConverterClass(ASource: TObject): TcxCustomGridConverterClass;
var
  AConverterClass: TcxCustomConverterWithStylesClass;
begin
  AConverterClass := ConverterFactory(cxGridGroupConverterName).FindConverter(ASource);
  if (AConverterClass <> nil) and AConverterClass.InheritsFrom(TcxCustomGridConverter) then
    Result := TcxCustomGridConverterClass(AConverterClass)
  else
    Result := nil;
end;

procedure TImportDialog.LoadComponentForImport(const S: string);
var
  AComponent: TComponent;
begin
  AComponent := FDesigner.GetComponent(S);
  if (AComponent <> nil) and (GetConverterClass(AComponent) <> nil) then
    lbComponentsForImport.Items.AddObject(S, AComponent);
end;

procedure TImportDialog.LoadIntermediary(const S: string);
var
  AComponent: TComponent;
  AConverterClass: TcxCustomGridConverterClass;
begin
  AComponent := FDesigner.GetComponent(S);
  if AComponent <> nil then
  begin
    AConverterClass := GetConverterClass(Component);
    if (AConverterClass <> nil) and 
      (AConverterClass.GetIntermediaryClassName = AComponent.ClassName) then
      FIntermediaryList.AddObject(AComponent.ClassName, AComponent);
  end;
end;

procedure TImportDialog.LoadStyleRepository(const S: string);
var
  AComponent: TComponent;
begin                                              
  AComponent := FDesigner.GetComponent(S);
  if (AComponent <> nil) and (AComponent is TcxStyleRepository) then
    cbStyleRepositories.Properties.Items.AddObject(S, AComponent);
end;

procedure TImportDialog.DoImport;
var
  AConverter: TcxCustomGridConverter;
begin
  if Component = nil then Exit;

  btnImport.Enabled := False;

  AConverter := GetConverterClass(Component).Create(FGrid);
  try
    AConverter.Intermediary := GetIntermediaryComponent;
    AConverter.Designer_ := Designer;
    AConverter.DestinationLevel := Level;
    AConverter.DeleteAllSublevels := cbDeleteAllSublevels.Checked;
    AConverter.ConvertWithStyles := cbImportStyles.Checked;
    if cbImportStyles.Checked then
      if rbCreateNewStyleRepository.Checked then
        AConverter.NameOfNewStyleRepository := edNewStyleRepository.Text
      else
        AConverter.StyleRepository := cbStyleRepositories.ItemObject as TcxStyleRepository;
    AConverter.ImportFrom(Component);
  finally
    AConverter.Free;

    if FGridStructureControl <> nil then
      FGridStructureControl.Changed;
    if rbCreateNewStyleRepository.Checked then
      UpdateStyleRepositoryEdits;
    if cbImportStyles.Checked then
      EnableStylesOptions;
      
    btnImport.Enabled := True;

    Designer.Modified;
  end;
end;

procedure EnableEdit(AEdit: TcxCustomEdit; AEnable: Boolean);
begin
  AEdit.Enabled := AEnable;
  if AEnable then
    AEdit.Style.Color := clWindow
  else
    AEdit.Style.Color := clBtnFace;
end;

procedure TImportDialog.DisableStylesOptions;
begin
  rbCreateNewStyleRepository.Enabled := False;
  rbUseExistingStyleRepository.Enabled := False;
  EnableEdit(edNewStyleRepository, False);
  EnableEdit(cbStyleRepositories, False);
end;

procedure TImportDialog.EnableStylesOptions;
begin
  rbCreateNewStyleRepository.Enabled := True;
  rbUseExistingStyleRepository.Enabled := cbStyleRepositories.Properties.Items.Count <> 0;
  if not rbUseExistingStyleRepository.Enabled then
    rbCreateNewStyleRepository.Checked := True;
  EnableEdit(edNewStyleRepository, rbCreateNewStyleRepository.Checked);
  EnableEdit(cbStyleRepositories, rbUseExistingStyleRepository.Checked);
end;

function TImportDialog.GetIntermediaryComponent: TComponent;
begin
  Result := nil;
  FIntermediaryList := TStringList.Create;
  try
    FDesigner.GetComponentNames(GetTypeData(PTypeInfo(TComponent.ClassInfo)), LoadIntermediary);
    if FIntermediaryList.Count <> 0 then
      Result := FIntermediaryList.Objects[0] as TComponent;
  finally
    FIntermediaryList.Free;
  end;
end;

procedure TImportDialog.StructureControlSelectionChanged(Sender: TObject);
var
  AList: TList;
  AObject: TObject;
begin
  AList := TList.Create;
  try
    FGridStructureControl.GetSelection(AList);
    if AList.Count = 0 then Exit;
    AObject := TObject(AList[0]);
    if AObject is TcxGridLevel then
      Level := TcxGridLevel(AObject)
    else
      if AObject is TcxCustomGrid then
        Level := nil
      else
        if AObject is TcxCustomGridView then
          Level := TcxGridLevel(TcxCustomGridView(AObject).Level);
  finally
    AList.Free;
  end;
end;

procedure TImportDialog.UpdateDesigner(Sender: TObject);
begin
  Designer.Modified;
end;

procedure TImportDialog.UpdateStyleRepositoryEdits;
var
  AIndex: Integer;
begin
  edNewStyleRepository.Text := FDesigner.UniqueName(TcxStyleRepository.ClassName);

  if cbStyleRepositories.Properties.Items.Count <> 0 then
    AIndex := cbStyleRepositories.ItemIndex
  else
    AIndex := 0;
  cbStyleRepositories.Clear;
  FDesigner.GetComponentNames(GetTypeData(PTypeInfo(TComponent.ClassInfo)), LoadStyleRepository);
  if cbStyleRepositories.Properties.Items.Count <> 0 then
    cbStyleRepositories.ItemIndex := AIndex;
end;

procedure TImportDialog.lbComponentsForImportClick(Sender: TObject);
begin
  btnImport.Enabled := Component <> nil;
end;

procedure TImportDialog.lbComponentsForImportDblClick(Sender: TObject);
begin
  DoImport;
end;

procedure TImportDialog.lbComponentsForImportMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  Height := lbComponentsForImport.Canvas.TextHeight('Qq') + 2 * 2;
end;

procedure TImportDialog.FormCreate(Sender: TObject);
begin
  with lblLevelName.Font do
  begin
    Color := clNavy;
    Style := [fsBold];
  end;
  FGridStructureControl := TcxGridStructureControl.Create(Self);
  with FGridStructureControl do
  begin
    Align := alClient;
    MayFocused := True;
    OnSelectionChanged := StructureControlSelectionChanged;
    Parent := pnlStructureControlSite;
  end;
  FGridStructureHelper := TcxGridStructureHelper.Create(FGridStructureControl);
  FGridStructureHelper.OnUpdateDesigner := UpdateDesigner;
  SetControlLookAndFeel(Self, lfUltraFlat, False);
{$IFDEF DELPHI10}  // should be DELPHI105
  MakeColoredControlsOpaque(Self);
{$ENDIF}
end;

procedure TImportDialog.FormDestroy(Sender: TObject);
begin
  FGridStructureHelper.Free;
  FGridStructureControl.Free;
end;

procedure TImportDialog.cbImportStylesClick(Sender: TObject);
begin
  if cbImportStyles.Checked then
    EnableStylesOptions
  else
    DisableStylesOptions;
end;

procedure TImportDialog.rbStyleRepositoryClick(Sender: TObject);
begin
  EnableStylesOptions;
end;

end.
