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

unit dxEditCon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, dxflchrt, ExtCtrls;

type
  TFEditConnection = class(TForm)
    MemoText: TMemo;
    Label1: TLabel;
    sbFont: TSpeedButton;
    FontDialog: TFontDialog;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    cbSArrowStyle: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbDArrowStyle: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    Label8: TLabel;
    pColor: TPanel;
    ColorDialog: TColorDialog;
    seSArrowSize: TEdit;
    seSPoint: TEdit;
    seDArrowSize: TEdit;
    seDPoint: TEdit;
    pBkColor: TPanel;
    Label9: TLabel;
    procedure sbFontClick(Sender: TObject);
    procedure pColorClick(Sender: TObject);
    procedure seSArrowSizeKeyPress(Sender: TObject; var Key: Char);
    procedure seSPointKeyPress(Sender: TObject; var Key: Char);
    procedure MemoTextChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function ConnectEditor(Chart : TdxFlowChart; Con : TdxFcConnection) : Boolean;

var
  FEditConnection: TFEditConnection;

implementation
uses dxFcEdit;

{$R *.DFM}

function ConnectEditor(Chart : TdxFlowChart; Con : TdxFcConnection) : Boolean;
var i, D : integer;
begin
  Result := False;
  with TFEditConnection.Create(nil) do begin
    with Con do begin
      MemoText.Text := Text;
      sbFont.Font.Assign(Font);
      cbSArrowStyle.ItemIndex := Integer(ArrowSource.ArrowType);
      cbDArrowStyle.ItemIndex := Integer(ArrowDest.ArrowType);
      seSArrowSize.Text := IntToStr(ArrowSource.Width);
      seDArrowSize.Text := IntToStr(ArrowDest.Height);
      if PointSource in [0..15] then seSPoint.Text := IntToStr(PointSource + 1) else seSPoint.Text := '1';
      if PointDest in [0..15] then seDPoint.Text := IntToStr(PointDest + 1) else seDPoint.Text := '1';
      pColor.Color := Color;
      pBkColor.Color := ArrowSource.Color;
      for i := 0 to ComponentCount - 1 do
        Components[i].Tag := 0;
    end;
    if ShowModal = mrOK then
      for i := 0 to Chart.SelectedConnectionCount-1 do
        with Chart.SelectedConnections[i] do begin
          if MemoText.Tag = 1 then Text := MemoText.Text;
          if sbFont.Tag = 1 then Font.Assign(sbFont.Font);
          if cbSArrowStyle.Tag = 1 then ArrowSource.ArrowType := TdxFcaType(cbSArrowStyle.ItemIndex);
          if cbDArrowStyle.Tag = 1 then ArrowDest.ArrowType := TdxFcaType(cbDArrowStyle.ItemIndex);
          if seSArrowSize.Tag = 1 then ArrowSource.Width := FChartEditor.IntegerToStr(seSArrowSize.Text);
          if seSArrowSize.Tag = 1 then ArrowSource.Height := FChartEditor.IntegerToStr(seSArrowSize.Text);
          if seDArrowSize.Tag = 1 then ArrowDest.Width := FChartEditor.IntegerToStr(seDArrowSize.Text);
          if seDArrowSize.Tag = 1 then ArrowDest.Height := FChartEditor.IntegerToStr(seDArrowSize.text);
          D := FChartEditor.IntegerToStr(seSPoint.Text) - 1;
          if not (D in [0..15]) then D := 0;
          if seSPoint.Tag = 1 then SetObjectSource(ObjectSource, D);
          D := FChartEditor.IntegerToStr(seDPoint.Text) - 1;
          if not (D in [0..15]) then D := 0;
          if seSPoint.Tag = 1 then SetObjectDest(ObjectDest, D);
          if pColor.Tag = 1 then Color := pColor.Color;
          if pBkColor.Tag = 1 then begin
            ArrowSource.Color := pBkColor.Color;
            ArrowDest.Color := pBkColor.Color;
          end;
          Result := True;
        end;
    Free;
  end;
  PostMessage(Chart.Handle, WM_LBUTTONUP, 0, MakeLParam(0, 0)); // Fix: by Kirill
end;

procedure TFEditConnection.sbFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(sbFont.Font);
  if FontDialog.Execute then begin
    sbFont.Font.Assign(FontDialog.Font);
    TSpeedButton(Sender).Tag := 1;
  end;
end;

procedure TFEditConnection.pColorClick(Sender: TObject);
begin
  ColorDialog.Color := TPanel(Sender).Color;
  if ColorDialog.Execute then begin
    TPanel(Sender).Color := ColorDialog.Color;
    TPanel(Sender).Tag := 1;
  end;
end;

procedure TFEditConnection.seSArrowSizeKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not FChartEditor.CanKeyEnter(TEdit(Sender), Key, 1, 9999999) then Key := #0;
end;

procedure TFEditConnection.seSPointKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not FChartEditor.CanKeyEnter(TEdit(Sender), Key, 1, 16) then Key := #0;
end;

procedure TFEditConnection.MemoTextChange(Sender: TObject);
begin
  TComponent(Sender).Tag := 1;
end;

end.
