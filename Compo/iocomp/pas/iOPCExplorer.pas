{*******************************************************}
{                                                       }
{       TiOPCItemSelectorForm                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCExplorer;{$endif}
{$ifdef iCLX}unit QiOPCExplorer;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}
  {$IFDEF iVCL}  iEditorBasicComponents,  StdCtrls,  Controls,  ComCtrls,  ExtCtrls,  ImgList, Classes,{$ENDIF}
  {$IFDEF iCLX}QiEditorBasicComponents,  QStdCtrls, QControls, QComCtrls, QExtCtrls, QImgList, Classes,{$ENDIF}

  {$IFDEF iVCL} iOPCDLLLoader,  iTypes;{$ENDIF}
  {$IFDEF iCLX}QiOPCDLLLoader, QiTypes;{$ENDIF}

type
  TiOPCExplorerForm = class(TForm)
    TreeView: TTreeView;
    ImageList: TImageList;
  private
    FServersTreeNode : TTreeNode;
    FGroupsTreeNode  : TTreeNode;
  public
    procedure Refresh;
  end;

var
  iOPCExplorerForm: TiOPCExplorerForm;

implementation

{$R *.dfm}

{ TiOPCExplorerForm }
//****************************************************************************************************************************************************
procedure TiOPCExplorerForm.Refresh;
var
  x        : Integer;
  TreeNode : TTreeNode;
begin
  TreeView.Items.Clear;

  FServersTreeNode               := TreeView.Items.Add(nil, 'Servers Connections');
  FServersTreeNode.ImageIndex    := 0;
  FServersTreeNode.SelectedIndex := 0;

  FGroupsTreeNode               := TreeView.Items.Add(nil, 'Groups');
  FGroupsTreeNode.ImageIndex    := 1;
  FGroupsTreeNode.SelectedIndex := 1;

  for x := 0 to OPCDLLServerConnectionGetCount-1 do
    begin
      TreeNode               := TreeView.Items.AddChild(FServersTreeNode, OPCDLLServerConnectionGetName(x));
      TreeNode.ImageIndex    := 2;
      TreeNode.SelectedIndex := 2;


    end;
end;
//****************************************************************************************************************************************************
end.
