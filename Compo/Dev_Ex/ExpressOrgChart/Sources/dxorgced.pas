{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express OrgChart                                            }
{                                                                   }
{       Copyright (c) 1998-2009 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSORGCHART AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE end USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxorgced;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, dxorgchr;

type
  TfrmEChartEditor = class(TForm)
    TreeBox: TGroupBox;
    PropBox: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    WidthEdit: TEdit;
    HeightEdit: TEdit;
    ColorEdit: TComboBox;
    AlignEdit: TComboBox;
    ShapeEdit: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel3: TPanel;
    MultiButton: TSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
    IIEdit: TEdit;
    IAEdit: TComboBox;
    Tree: TdxOrgChart;
    Panel4: TPanel;
    CancelButton: TButton;
    OKButton: TButton;
    Panel5: TPanel;
    InsButton: TSpeedButton;
    CInsButton: TSpeedButton;
    DelButton: TSpeedButton;
    ZoomButton: TSpeedButton;
    RotateButton: TSpeedButton;
    Label8: TLabel;
    TTEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure SetColors(const S: String);
    procedure SetNodeInfo(Node: TdxOcNode);
    procedure Label1Click(Sender: TObject);
    procedure InsButtonClick(Sender: TObject);
    procedure CInsButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure ZoomButtonClick(Sender: TObject);
    procedure TreeChange(Sender: TObject; Node: TdxOcNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WidthEditExit(Sender: TObject);
    procedure HeightEditExit(Sender: TObject);
    procedure ColorEditExit(Sender: TObject);
    procedure AlignEditExit(Sender: TObject);
    procedure ShapeEditExit(Sender: TObject);
    procedure SetButtonClick(Sender: TObject);
    procedure MultiButtonClick(Sender: TObject);
    procedure FixButtonClick(Sender: TObject);
    procedure WidthEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ColorEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure IIEditExit(Sender: TObject);
    procedure IAEditExit(Sender: TObject);
    procedure RotateButtonClick(Sender: TObject);
    procedure ColorEditClick(Sender: TObject);
    procedure AlignEditClick(Sender: TObject);
    procedure ShapeEditClick(Sender: TObject);
    procedure TTEditExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ShowOrgChartEditor(ATree: TdxOrgChart): Boolean;

var
  NodeInfo: TdxOcNodeInfo;

implementation

{$R *.DFM}

function ShowOrgChartEditor(ATree: TdxOrgChart): Boolean;
var
  AForm: TfrmEChartEditor;
  P: TPoint;
  DX,DY: Integer;
begin
  Result := False;
  AForm := TfrmEChartEditor.Create(nil);
  P.X := 0; P.Y := 0;
  P := ATree.ClientToScreen(P);
  P.X := P.X + 32;
  P.Y := P.Y + 40;
  DX := P.X + AForm.Width - Screen.Width;
  DY := P.Y + AForm.Height - Screen.Height;
  if DX > 0 then Dec(P.X,DX);
  if DY > 0 then Dec(P.Y,DY);
  if P.X < 0 then P.X := 0;
  if P.Y < 0 then P.Y := 0;
  AForm.Left := P.X; AForm.Top := P.Y;
  with AForm.Tree do begin
    SetLeftTop(0,0);
    DefaultNodeWidth := ATree.DefaultNodeWidth;
    DefaultNodeHeight := ATree.DefaultNodeHeight;
    DefaultImageAlign := ATree.DefaultImageAlign;
    LineWidth := ATree.LineWidth;
    IndentX := ATree.IndentX;
    IndentY := ATree.IndentY;
    Images := ATree.Images;
    EditMode := ATree.EditMode;
    Font := ATree.Font;
    Options := Options + ATree.Options;
    Rotated := ATree.Rotated;
    Zoom := ATree.Zoom;
    AForm.ZoomButton.Down := Zoom;
    AForm.RotateButton.Down := Rotated;
    AssignData(ATree);
    FullExpand;
  end;
  AForm.TreeChange(AForm.Tree,AForm.Tree.Selected);
  AForm.ShowModal;
  if AForm.ModalResult=mrOK then begin
    ATree.AssignData(AForm.Tree);
    ATree.Zoom := AForm.Tree.Zoom;
    ATree.Rotated := AForm.Tree.Rotated;    
    ATree.FullExpand;
    Result := True;
  end;
  AForm.Free;
end;

procedure TfrmEChartEditor.SetColors(const S: String);
begin
  ColorEdit.Items.Add(S);
end;

procedure TfrmEChartEditor.FormCreate(Sender: TObject);
begin
  GetColorValues(SetColors);
  Caption := 'TdxOrgChart Items Editor';
  TreeBox.Caption := 'Items';
  PropBox.Caption := 'Item Properties';
  CancelButton.Caption := 'Cancel';
  InsButton.Hint := 'Insert new item';
  CInsButton.Hint := 'Insert new subitem';
  DelButton.Hint := 'Delete item';
  ZoomButton.Hint := 'Zoom on/off';
  RotateButton.Hint := '90° rotate on/off';
  MultiButton.Hint := 'Set properties for all children of selected item';
end;

procedure TfrmEChartEditor.Label1Click(Sender: TObject);
begin
  TLabel(Sender).FocusControl.SetFocus;
end;

procedure TfrmEChartEditor.InsButtonClick(Sender: TObject);
var
  N: TdxOcNode;
begin
  N := Tree.Selected;
  if (N=nil) or (N.GetNextSibling=nil) then N := Tree.Add(N,nil)
  else N := Tree.Insert(N.GetNextSibling,nil);
  if N<>nil then begin
    Tree.Selected := N;
    N.MakeVisible;
  end;
end;

procedure TfrmEChartEditor.CInsButtonClick(Sender: TObject);
var
  N: TdxOcNode;
begin
  N := Tree.Selected;
  if N=nil then Exit;
  N := Tree.AddChild(N,nil);
  if N<>nil then begin
    Tree.Selected := N;
    N.MakeVisible;
  end;
end;

procedure TfrmEChartEditor.DelButtonClick(Sender: TObject);
begin
  if Tree.Selected<>nil then Tree.Delete(Tree.Selected);
end;

procedure TfrmEChartEditor.ZoomButtonClick(Sender: TObject);
begin
  Tree.Zoom := ZoomButton.Down;
end;

procedure TfrmEChartEditor.TreeChange(Sender: TObject; Node: TdxOcNode);
begin
  if Node=nil then begin
    PropBox.Enabled := False;
    PropBox.Font.Style := [];
  end
  else begin
    PropBox.Enabled := True;
    TTEdit.Text := Node.Text;
    Node.GetNodeInfo(NodeInfo);
    with NodeInfo do begin
      WidthEdit.Text := IntToStr(Width);
      HeightEdit.Text := IntToStr(Height);
      ColorEdit.Text := ColorToString(Color);
      AlignEdit.ItemIndex := Ord(Align);
      ShapeEdit.ItemIndex := Ord(Shape);
      IIEdit.Text := IntToStr(Index);
      IAEdit.ItemIndex := Ord(IAlign);
    end;
  end;
end;

procedure TfrmEChartEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Tree.OnChange := nil;
end;

procedure TfrmEChartEditor.SetNodeInfo(Node: TdxOcNode);
begin
  if Node=nil then Exit;
  with NodeInfo do begin
    Node.Width := Width;
    Node.Height := Height;
    Node.Color := Color;
    Node.ChildAlign := Align;
    Node.Shape := Shape;
    Node.ImageIndex := Index;
    Node.ImageAlign := IAlign;
  end;
end;

procedure TfrmEChartEditor.WidthEditExit(Sender: TObject);
begin
  NodeInfo.Width := StrToInt(WidthEdit.Text);
  SetNodeInfo(Tree.Selected);
end;

procedure TfrmEChartEditor.HeightEditExit(Sender: TObject);
begin
  NodeInfo.Height := StrToInt(HeightEdit.Text);
  SetNodeInfo(Tree.Selected);
end;

procedure TfrmEChartEditor.ColorEditExit(Sender: TObject);
var
  C: LongInt;
begin
  if not IdentToColor(ColorEdit.Text,C) then C := StrToInt('$'+ColorEdit.Text);
  NodeInfo.Color := TColor(C);
  SetNodeInfo(Tree.Selected);
end;

procedure TfrmEChartEditor.AlignEditExit(Sender: TObject);
begin
  NodeInfo.Align := TdxOcNodeAlign(AlignEdit.ItemIndex);
  SetNodeInfo(Tree.Selected);
end;

procedure TfrmEChartEditor.ShapeEditExit(Sender: TObject);
begin
  NodeInfo.Shape := TdxOcShape(ShapeEdit.ItemIndex);
  SetNodeInfo(Tree.Selected);
end;

procedure TfrmEChartEditor.SetButtonClick(Sender: TObject);
begin
  Tree.SetFocus;
  SetNodeInfo(Tree.Selected);
end;

procedure TfrmEChartEditor.MultiButtonClick(Sender: TObject);
var
  I: Integer;

  procedure SetNodeInfo_(Node: TdxOcNode);
  var
    i : Integer;
  begin
    SetNodeInfo(Node);
    for i:=0 to Node.Count-1 do SetNodeInfo_(Node[i]);
  end;

begin
  Tree.SetFocus;
  for I:=0 to Tree.Selected.Count-1 do SetNodeInfo_(Tree.Selected[I]);
end;

procedure TfrmEChartEditor.FixButtonClick(Sender: TObject);
begin
  TreeChange(Tree,Tree.Selected);
end;

procedure TfrmEChartEditor.WidthEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then begin
    TEdit(Sender).SelectAll;
    TEdit(Sender).OnExit(Sender);
  end;
end;

procedure TfrmEChartEditor.ColorEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (not ColorEdit.DroppedDown) and (Key=VK_RETURN) then begin
    ColorEdit.SelectAll;
    ColorEditExit(Sender);
  end;
end;

procedure TfrmEChartEditor.IIEditExit(Sender: TObject);
begin
  NodeInfo.Index := StrToInt(IIEdit.Text);
  SetNodeInfo(Tree.Selected);
end;

procedure TfrmEChartEditor.IAEditExit(Sender: TObject);
begin
  NodeInfo.IAlign := TdxOcImageAlign(IAEdit.ItemIndex);
  SetNodeInfo(Tree.Selected);
end;

procedure TfrmEChartEditor.RotateButtonClick(Sender: TObject);
begin
  Tree.Rotated := RotateButton.Down;
end;

procedure TfrmEChartEditor.ColorEditClick(Sender: TObject);
begin
  with ColorEdit do if Text=Items[ItemIndex] then ColorEditExit(Self);
end;

procedure TfrmEChartEditor.AlignEditClick(Sender: TObject);
begin
  AlignEditExit(Sender);
end;

procedure TfrmEChartEditor.ShapeEditClick(Sender: TObject);
begin
  ShapeEditExit(Sender);
end;

procedure TfrmEChartEditor.TTEditExit(Sender: TObject);
begin
  if Tree.Selected <> nil then
    Tree.Selected.Text := TTEdit.Text;
end;

end.
