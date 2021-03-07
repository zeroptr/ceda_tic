{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressFlowChart                                            }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSFLOWCHART AND ALL ACCOMPANYING}
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

unit dxEditObj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, dxflchrt, Buttons;

type
  TFEditObject = class(TForm)
    PageControl: TPageControl;
    tsGeneral: TTabSheet;
    tsImage: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    memoText: TMemo;
    Label2: TLabel;
    cbTextPosition: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    cbShapeStyle: TComboBox;
    lwImage: TListView;
    Panel3: TPanel;
    Label5: TLabel;
    cbImagePosition: TComboBox;
    btnClear: TButton;
    Label6: TLabel;
    Label7: TLabel;
    sbFont: TSpeedButton;
    FontDialog: TFontDialog;
    Label8: TLabel;
    pColor: TPanel;
    Label9: TLabel;
    pBkColor: TPanel;
    ColorDialog: TColorDialog;
    cbTransparent: TCheckBox;
    tsFrame: TTabSheet;
    GroupBox1: TGroupBox;
    cbRaisedOut: TCheckBox;
    cbSunkenOut: TCheckBox;
    cbRaisedIn: TCheckBox;
    cbSunkenIn: TCheckBox;
    GroupBox2: TGroupBox;
    cbLeft: TCheckBox;
    cbTop: TCheckBox;
    cbRight: TCheckBox;
    cbBottom: TCheckBox;
    cbDiag: TCheckBox;
    cbMiddle: TCheckBox;
    cbSoft: TCheckBox;
    cbAdjust: TCheckBox;
    cbMono: TCheckBox;
    cbFlat: TCheckBox;
    seHeight: TEdit;
    seWidth: TEdit;
    seShapeWidth: TEdit;
    procedure btnClearClick(Sender: TObject);
    procedure sbFontClick(Sender: TObject);
    procedure pColorClick(Sender: TObject);
    procedure seHeightKeyPress(Sender: TObject; var Key: Char);
    procedure seHeightChange(Sender: TObject);
  private
    { Private declarations }
    function GetEdgeStyle: Integer;
    procedure SetEdgeStyle(EStyle : Word);
    function GetBorderStyle : Integer;
    procedure SetBorderStyle(BStyle : Integer);
    function ChangeEdgeStyle : Boolean;
    function ChangeBorderStyle : Boolean;
  public
    { Public declarations }
  end;

var
  FEditObject: TFEditObject;

function ObjectEditor(Chart : TdxFlowChart; Obj : TdxFcObject) : Boolean;

implementation

uses dxFcEdit;

{$R *.DFM}

function ObjectEditor(Chart : TdxFlowChart; Obj : TdxFcObject) : Boolean;
var i : integer;
begin
  Result := False;
  with TFEditObject.Create(nil) do begin
    with Obj do begin
      MemoText.Text := Text;
      cbTextPosition.ItemIndex := Integer(VertTextPos) * 3 + Integer(HorzTextPos);
      cbImagePosition.ItemIndex := Integer(VertImagePos) * 3 + Integer(HorzImagePos);
      cbShapeStyle.ItemIndex := Integer(ShapeType);
      seShapeWidth.Text := IntToStr(ShapeWidth);
      seHeight.Text := IntToStr(Height);
      seWidth.Text := IntToStr(Width);
      lwImage.Items.Clear;
      if Chart.Images <> nil then begin
        lwImage.SmallImages := Chart.Images;
        lwImage.LargeImages := Chart.Images;
        for i := 0 to Chart.Images.Count - 1 do begin
          lwImage.Items.Add;
          lwImage.Items[lwImage.Items.Count - 1].ImageIndex := i;
          lwImage.Items[lwImage.Items.Count - 1].Caption := IntToStr(i);
          if ImageIndex = i then lwImage.Selected := lwImage.Items[lwImage.Items.Count - 1];
        end;
      end;
      sbFont.Font.Assign(Font);
      pColor.Color := ShapeColor;
      pBkColor.Color := BkColor;
      cbTransparent.Checked := Transparent;
      SetEdgeStyle(EdgeStyle);
      SetBorderStyle(BorderStyle);
      for i := 0 to ComponentCount - 1 do
        Components[i].Tag := 0;
    end;
    if ShowModal = mrOK then
      for i := 0 to Chart.SelectedObjectCount-1 do
        with Chart.SelectedObjects[i] do begin
          if cbShapeStyle.Tag = 1 then ShapeType := TdxFcShapeType(cbShapeStyle.ItemIndex);
          if seShapeWidth.Tag = 1 then ShapeWidth := FChartEditor.IntegerToStr(seShapeWidth.Text);
          if pColor.Tag = 1 then ShapeColor := pColor.Color;
          if pBkColor.Tag = 1 then BkColor := pBkColor.Color;
          if cbTextPosition.Tag = 1 then HorzTextPos := TdxFcHorzPos(cbTextPosition.ItemIndex mod 3);
          if cbTextPosition.Tag = 1 then VertTextPos := TdxFcVertPos(cbTextPosition.ItemIndex div 3);
          if sbFont.Tag = 1 then Font.Assign(sbFont.Font);
          if MemoText.Tag = 1 then Text := MemoText.Text;
          if seHeight.Tag = 1 then Height := FChartEditor.IntegerToStr(seHeight.Text);
          if seWidth.Tag = 1 then Width := FChartEditor.IntegerToStr(seWidth.Text);
          if (Chart.Images <> nil) and (lwImage.Tag = 1) then
            if lwImage.Selected = nil then ImageIndex := -1 else ImageIndex := lwImage.Selected.ImageIndex;
          if cbImagePosition.Tag = 1 then HorzImagePos := TdxFcHorzPos(cbImagePosition.ItemIndex mod 3);
          if cbImagePosition.Tag = 1 then VertImagePos := TdxFcVertPos(cbImagePosition.ItemIndex div 3);
          if cbTransparent.Tag = 1 then Transparent := cbTransparent.Checked;
          if ChangeEdgeStyle then EdgeStyle := GetEdgeStyle;
          if ChangeBorderStyle then BorderStyle := GetBorderStyle;
          Result := True;
        end;
    Free;
  end;
  PostMessage(Chart.Handle, WM_LBUTTONUP, 0, MakeLParam(0, 0)); // Fix: by Kirill
end;

procedure TFEditObject.btnClearClick(Sender: TObject);
begin
  lwImage.Selected := nil;
  lwImage.Tag := 1;
end;

procedure TFEditObject.sbFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(sbFont.Font);
  if FontDialog.Execute then begin
    sbFont.Font.Assign(FontDialog.Font);
    sbFont.Tag := 1;
  end;
end;

procedure TFEditObject.pColorClick(Sender: TObject);
begin
  ColorDialog.Color := TPanel(Sender).Color;
  if ColorDialog.Execute then begin
    TPanel(Sender).Color := ColorDialog.Color;
    TPanel(Sender).Tag := 1;
  end;
end;

function TFEditObject.GetEdgeStyle: Integer;
begin
  Result := 0;
  if cbRaisedOut.Checked then Result := Result or BDR_RAISEDOUTER;
  if cbSunkenOut.Checked then Result := Result or BDR_SUNKENOUTER;
  if cbRaisedIn.Checked then Result := Result or BDR_RAISEDINNER;
  if cbSunkenIn.Checked then Result := Result or BDR_SUNKENINNER;
end;

procedure TFEditObject.SetEdgeStyle(EStyle : Word);
begin
  cbRaisedOut.Checked := (EStyle and  BDR_RAISEDOUTER) <> 0;
  cbSunkenOut.Checked := (EStyle and BDR_SUNKENOUTER) <> 0;
  cbRaisedIn.Checked := (EStyle and BDR_RAISEDINNER) <> 0;
  cbSunkenIn.Checked := (EStyle and BDR_SUNKENINNER) <> 0;
end;

function TFEditObject.GetBorderStyle : Integer;
begin
  Result := 0;
  if  cbLeft.Checked then Result := Result or BF_LEFT;
  if  cbTop.Checked then Result := Result or BF_TOP;
  if  cbRight.Checked then Result := Result or BF_RIGHT;
  if  cbBottom.Checked then Result := Result or BF_BOTTOM;
  if  cbDiag.Checked then Result := Result or BF_DIAGONAL;
  if  cbMiddle.Checked then Result := Result or BF_MIDDLE;
  if  cbSoft.Checked then Result := Result or BF_SOFT;
  if  cbAdjust.Checked then Result := Result or BF_ADJUST;
  if  cbFlat.Checked then Result := Result or BF_FLAT;
  if  cbMono.Checked then Result := Result or BF_MONO;
end;

procedure TFEditObject.SetBorderStyle(BStyle : Integer);
begin
  cbLeft.Checked := (BStyle and BF_LEFT) <> 0;
  cbTop.Checked := (BStyle and BF_TOP) <> 0;
  cbRight.Checked := (BStyle and BF_RIGHT) <> 0;
  cbBottom.Checked := (BStyle and BF_BOTTOM) <> 0;
  cbDiag.Checked := (BStyle and BF_DIAGONAL) <> 0;
  cbMiddle.Checked := (BStyle and BF_MIDDLE) <> 0;
  cbSoft.Checked := (BStyle and BF_SOFT) <> 0;
  cbAdjust.Checked := (BStyle and BF_ADJUST) <> 0;
  cbFlat.Checked := (BStyle and BF_FLAT) <> 0;
  cbMono.Checked := (BStyle and BF_MONO) <> 0;
end;

function TFEditObject.ChangeEdgeStyle : Boolean;
begin
  Result := (cbRaisedOut.Tag = 1) or
            (cbSunkenOut.Tag = 1) or
            (cbRaisedIn.Tag = 1) or
            (cbSunkenIn.Tag = 1);
end;

function TFEditObject.ChangeBorderStyle : Boolean;
begin
  Result := (cbLeft.Tag = 1) or
            (cbTop.Tag = 1) or
            (cbRight.Tag = 1) or
            (cbBottom.Tag = 1) or
            (cbDiag.Tag = 1) or
            (cbMiddle.Tag = 1) or
            (cbSoft.Tag = 1) or
            (cbAdjust.Tag = 1) or
            (cbFlat.Tag = 1) or
            (cbMono.Tag = 1);
end;

procedure TFEditObject.seHeightKeyPress(Sender: TObject; var Key: Char);
begin
 if not FChartEditor.CanKeyEnter(TEdit(Sender), Key, 1, 9999999) then Key := #0;
end;

procedure TFEditObject.seHeightChange(Sender: TObject);
begin
  TComponent(Sender).Tag := 1;
end;

end.
