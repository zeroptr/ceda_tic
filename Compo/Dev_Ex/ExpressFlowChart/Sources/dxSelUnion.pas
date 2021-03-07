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

unit dxSelUnion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, dxflchrt;

type
  TFSelectUnion = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    lbUnions: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSelectUnion: TFSelectUnion;

function SelectUnion(Chart : TdxFlowChart; Obj : TdxFcObject) : TdxFcObject;

implementation
uses dxFcEdit;
{$R *.DFM}

function SelectUnion(Chart : TdxFlowChart; Obj : TdxFcObject) : TdxFcObject;
var FirstObj : TdxFcObject;
    AText : String;
    i, j : integer;
    FFind : Boolean;
begin
  Result := nil;
  with TFSelectUnion.Create(nil) do begin
    lbUnions.Clear;
    if Obj = nil then begin
      FirstObj := nil;
      repeat
        FirstObj := FChartEditor.FindAllUnions(Chart, FirstObj);
        if FirstObj <> nil then begin
           AText := 'Union '+ IntToStr(FChartEditor.GetNumberByUnion(Chart, FirstObj));
           if FirstObj.Text <> '' then AText := AText+' ( '+FirstObj.Text+' )';
           lbUnions.Items.AddObject(AText, FirstObj);
        end;
      until FirstObj = nil;
    end;
    if Obj <> nil then begin
      for i := 0 to Chart.SelectedObjectCount - 1 do
        if FChartEditor.IsChildItemInUnion(Chart, Chart.SelectedObjects[i]) then begin
          FirstObj := nil;
          repeat
            FirstObj := FChartEditor.FindUnions(Chart, FirstObj, Chart.SelectedObjects[i]);
            if FirstObj <> nil then begin
              FFind := False;
              for j := 0 to lbUnions.Items.Count - 1 do
                if lbUnions.Items.Objects[j] = FirstObj then begin
                  FFind := True;
                  break;
                end;
              if not FFind then begin
                AText := 'Union '+ IntToStr(FChartEditor.GetNumberByUnion(Chart, FirstObj));
                if FirstObj.Text <> '' then AText := AText+' ( '+FirstObj.Text+' )';
                lbUnions.Items.AddObject(AText, FirstObj);
              end;
            end;
          until FirstObj = nil
        end;
      lbUnions.Sorted := False;
      lbUnions.Sorted := True;
    end;
    if ShowModal = mrOK then
      if lbUnions.ItemIndex <> -1 then Result := TdxFcObject(lbUnions.Items.Objects[lbUnions.ItemIndex]);
    Free;
  end;
end;

end.
