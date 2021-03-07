{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System(tm) COMPONENT SUITE                  }
{                                                                   }
{       Copyright (C) 1998-2009 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPSdxFCLnk;

interface

{$I cxVer.inc}

uses
  Classes, Windows, Graphics, Controls, Forms, StdCtrls, ComCtrls, ExtCtrls,
  dxFlChrt, dxPSGraphicLnk, dxPSCore, ImgList;

type
  TdxFlowChartReportLink = class(TCustomdxGraphicReportLink)
  private
    FUseMetafile: Boolean;
    function GetFlowChart: TdxCustomFlowChart;
  protected
    function GetGraphic: TGraphic; override;
    function GetGraphicClass: TGraphicClass; override;
    procedure InitializeGraphicItem(AnItem: TdxReportCellGraphic); override;
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;    
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    property FlowChart: TdxCustomFlowChart read GetFlowChart;
  published
    property BorderColor;
    property Color;
    property DrawBorder;
    property Transparent;
    property TransparentColor;
    property UseMetafile: Boolean read FUseMetafile write FUseMetafile default True;
  end;

  TdxFCReportLinkDesignWindow = class(TStandarddxReportLinkDesignWindow)
    PageControl1: TPageControl;
    tshOptions: TTabSheet;
    pnlOptions: TPanel;
    gbxTransparent: TGroupBox;
    lblColor: TLabel;
    bvlColorHolder: TBevel;
    chbxTransparent: TCheckBox;
    gbxBorder: TGroupBox;
    lblGridLinesColor: TLabel;
    bvlLineColorHolder: TBevel;
    chbxDrawBorder: TCheckBox;
    pnlPreview: TPanel;
    ilFlowChart: TImageList;
    lblPreview: TLabel;
    stTransparent: TStaticText;
    stDrawBorder: TStaticText;
    procedure lblColorClick(Sender: TObject);
    procedure chbxDrawBorderClick(Sender: TObject);
    procedure chbxTransparentClick(Sender: TObject);
    procedure stTransparentClick(Sender: TObject);
    procedure stDrawBorderClick(Sender: TObject);
  private
    procedure ccbxColorChange(Sender: TObject);
    procedure CreateControls;
    function GetReportLink: TdxFlowChartReportLink;
    procedure pbxPreviewPaint(Sender: TObject);
  protected
    procedure DoInitialize; override;
   {$IFDEF DELPHI7}
    function GetPreviewHost: TCustomPanel; override;
   {$ENDIF}
    procedure LoadStrings; override;
    procedure PaintPreview(ACanvas: TCanvas; R: TRect); override;
    procedure UpdatePreview; override;
    procedure UpdateControlsState; override;
  public
    ccbxColor: TCustomComboBox;
    ccbxGridLineColor: TCustomComboBox;
    FPreviewBox: TCustomControl;
    constructor Create(AOwner: TComponent); override;
    property ReportLink: TdxFlowChartReportLink read GetReportLink;
  end;

  PdxFlowChartGetAsGraphicData = ^TdxFlowChartGetAsGraphicData;
  TdxFlowChartGetAsGraphicData = record
    FlowChart: TdxCustomFlowChart;
    GraphicClass: TGraphicClass;
    Transparent: Boolean;
    TransparentColor: TColor;
    Enhanced: Boolean;
  end;
    
function dxGetFlowChartAsGraphic(const AData: PdxFlowChartGetAsGraphicData): TGraphic;
  
implementation

{$R *.DFM}

uses
  SysUtils, cxClasses, dxPSUtl, dxExtCtrls, dxPSRes, dxPSGlbl;

type
  TdxFlowChartAccess = class(TdxCustomFlowChart);
  
function dxGetFlowChartAsGraphic(const AData: PdxFlowChartGetAsGraphicData): TGraphic;

  procedure SaveSelection(AFlowChart: TdxCustomFlowChart; ASelections: TList);
  var
    I: Integer;
    Item: TdxFcItem;
  begin
    for I := 0 to AFlowChart.SelectedObjectCount - 1 do 
    begin
      Item := AFlowChart.SelectedObjects[I];
      ASelections.Add(Item);
      Item.Selected := False;
    end;  
    for I := 0 to AFlowChart.SelectedConnectionCount - 1 do 
    begin
      Item := AFlowChart.SelectedConnections[I];
      ASelections.Add(Item);
      Item.Selected := False;
    end;  
  end;
  
  procedure RestoreSelection(ASelections: TList);
  var
    I: Integer;
  begin
    for I := 0 to ASelections.Count - 1 do
      TdxFCItem(ASelections[I]).Selected := True;
    ASelections.Free;
  end;
  
var
  Graphic: TGraphic;
  Canvas: TCanvas;
  DC: HDC;
  IsBitmap: Boolean;
  IsMetafile: Boolean;
  Selections: TList;
  SaveTopEdge, SaveLeftEdge: Integer;
begin
  Result := nil;
  if (AData = nil) or (AData^.FlowChart = nil) or (AData^.GraphicClass = nil) then Exit;
  IsBitmap := AData^.GraphicClass.InheritsFrom(TBitmap);
  IsMetafile := AData^.GraphicClass.InheritsFrom(TMetafile);
  try
    if IsMetafile then 
      Graphic := TMetafile.Create
    else
      Graphic := TBitmap.Create;
    try
      Graphic.Width := TdxFlowChartAccess(AData^.FlowChart).ChartWidth;
      Graphic.Height := TdxFlowChartAccess(AData^.FlowChart).ChartHeight;
      if IsMetafile then 
      begin
        TMetafile(Graphic).Enhanced := AData^.Enhanced;
        Canvas := TMetafileCanvas.Create(TMetafile(Graphic), 0)
      end  
      else
        Canvas := TBitmap(Graphic).Canvas;
        
      try
        if not IsMetafile and AData^.Transparent then 
        begin
          Canvas.Brush.Color := ColorToRGB(AData^.TransparentColor);
          Canvas.FillRect(Rect(0, 0, Graphic.Width, Graphic.Height));
        end;
        DC := Canvas.Handle;        
        with TdxFlowChartAccess(AData^.FlowChart) do 
        begin
          BeginUpdate;
          try
            ControlState := ControlState + [csPaintCopy];
            SaveTopEdge := TopEdge;
            SaveLeftEdge := LeftEdge;
            Selections := TList.Create;
            try
              SaveSelection(AData^.FlowChart, Selections);
              TopEdge := 0;
              LeftEdge := 0;
              PaintWindow(DC);
            finally
              TopEdge := SaveTopEdge;
              LeftEdge := SaveLeftEdge;
              RestoreSelection(Selections);
            end;
            ControlState := ControlState - [csPaintCopy];
          finally
            CancelUpdate;
          end;  
        end;  
        
        if IsBitmap and AData^.Transparent then 
          TBitmap(Graphic).TransparentColor := AData^.TransparentColor;
          
        if not IsMetafile and not IsBitmap then 
        begin
          Result := dxPSUtl.CreateGraphic(AData^.GraphicClass);
          Result.Assign(Graphic);
        end  
        else
          Result := Graphic;  
      finally
        if IsMetafile then Canvas.Free;
      end;
    finally
      if not IsMetafile and not IsBitmap then Graphic.Free;
    end;  
  except
    if Result <> nil then Result.Free;
    raise;
  end;  
end;

{ TdxFlowChartReportLink }

constructor TdxFlowChartReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FUseMetafile := True;
end;

procedure TdxFlowChartReportLink.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxFlowChartReportLink then
    UseMetafile := TdxFlowChartReportLink(Source).UseMetafile;
end;

function TdxFlowChartReportLink.GetGraphic: TGraphic;
var
  Data: TdxFlowChartGetAsGraphicData;
begin
  Result := nil;
  if (FlowChart = nil) or (FlowChart.ObjectCount = 0) then 
    Exit;
    
  FillChar(Data, SizeOf(TdxFlowChartGetAsGraphicData), 0);
  Data.FlowChart := FlowChart;
  Data.GraphicClass := GetGraphicClass;
  Data.Transparent := Transparent;
  Data.TransparentColor := TransparentColor;
  Data.Enhanced := True;
  Result := dxGetFlowChartAsGraphic(@Data);
end;

function TdxFlowChartReportLink.GetGraphicClass: TGraphicClass;
const
  GraphicClasses: array[Boolean] of TGraphicClass = (TBitmap, TMetafile);
begin
  Result := GraphicClasses[UseMetafile];
end;

procedure TdxFlowChartReportLink.InitializeGraphicItem(
  AnItem: TdxReportCellGraphic);
begin
  inherited InitializeGraphicItem(AnItem);
  AnItem.ImageTransparent := UseMetafile;
  AnItem.Transparent := Transparent;
  AnItem.Color := Color;
end;

procedure TdxFlowChartReportLink.InternalRestoreDefaults;
begin
  inherited;
  UseMetafile := True;
end;

procedure TdxFlowChartReportLink.InternalRestoreFromOriginal;
begin
  inherited;
  if FlowChart <> nil then
    TransparentColor := dxPSUtl.Control_GetColor(FlowChart);  
end;

function TdxFlowChartReportLink.GetFlowChart: TdxCustomFlowChart;
begin
  Result := TdxCustomFlowChart(Component);
end;

{ TdxFCReportLinkDesignWindow }

constructor TdxFCReportLinkDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxhcFlowChartReportLinkDesigner;
  inherited;
  CreateControls;
  PageControl1.ActivePage := PageControl1.Pages[0];
end;
  
procedure TdxFCReportLinkDesignWindow.CreateControls;
var
  R: TRect;
begin
  ccbxColor := TdxPSColorCombo.Create(Self);
  with TdxPSColorCombo(ccbxColor) do
  begin
    BoundsRect := bvlColorHolder.BoundsRect;
    Tag := 0;
    Parent := gbxTransparent;
    ColorTypes := [ctPure];
    ShowColorName := True;
    ShowAutoColor := True;
    AutoColor := dxDefaultColor;
//    DropDownCount := Items.Count;
    OnChange := ccbxColorChange;
  end;
  lblColor.FocusControl := ccbxColor;

  ccbxGridLineColor := TdxPSColorCombo.Create(Self);
  with TdxPSColorCombo(ccbxGridLineColor) do
  begin
    BoundsRect := bvlLineColorHolder.BoundsRect;
    Tag := 1;
    Parent := gbxBorder;
    ColorTypes := [ctPure];
    ShowColorName := True;
    ShowAutoColor := True;
    AutoColor := dxDefaultGridLineColor;
//    DropDownCount := Items.Count;
    OnChange := ccbxColorChange;
  end;
  lblGridLinesColor.FocusControl := ccbxGridLineColor;
  FPreviewBox := TdxPSPaintPanel.Create(Self);
  with TdxPSPaintPanel(FPreviewBox) do
  begin
    Parent := pnlPreview;
    R := pnlPreview.BoundsRect;
    OffsetRect(R, -R.Left, -R.Top);
    InflateRect(R, -4, -4);
    BoundsRect := R;
    EdgeInner := esNone;
    EdgeOuter := esNone;
    OnPaint := pbxPreviewPaint;
  end;
end;

{$IFDEF DELPHI7}
function TdxFCReportLinkDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}

procedure TdxFCReportLinkDesignWindow.LoadStrings;
begin
  inherited;
  tshOptions.Caption := cxGetResourceString(@sdxOptions);
  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));
  
  stDrawBorder.Caption := ' ' + cxGetResourceString(@sdxBorderLines) + ' ';
  stTransparent.Caption := ' ' + cxGetResourceString(@sdxTransparent) + ' ';
  lblColor.Caption := cxGetResourceString(@sdxColor);
  lblGridLinesColor.Caption := cxGetResourceString(@sdxGridLinesColor);
end;

procedure TdxFCReportLinkDesignWindow.DoInitialize;
begin
  inherited;
  chbxDrawBorder.Checked := ReportLink.DrawBorder;
  chbxTransparent.Checked := ReportLink.Transparent;
  TdxPSColorCombo(ccbxColor).ColorValue := ReportLink.Color;
  TdxPSColorCombo(ccbxGridLineColor).ColorValue := ReportLink.BorderColor;
  lblPreview.ParentFont := True;
end;

procedure TdxFCReportLinkDesignWindow.UpdateControlsState;
begin
  inherited;
  ccbxColor.Enabled := not chbxTransparent.Checked;
  lblColor.Enabled := not chbxTransparent.Checked;
  ccbxGridLineColor.Enabled := chbxDrawBorder.Checked;
  lblGridLinesColor.Enabled := chbxDrawBorder.Checked;
end;

procedure TdxFCReportLinkDesignWindow.pbxPreviewPaint(Sender: TObject);
begin
  with TdxPSPaintPanel(Sender) do
    PaintPreview(Canvas, ClientRect);
end;

procedure TdxFCReportLinkDesignWindow.PaintPreview(ACanvas: TCanvas; R: TRect);

  procedure DrawText(ACanvas: TCanvas; const R: TRect; const S: string);
  const
    uFormat: UINT = DT_CENTER or DT_VCENTER or DT_SINGLELINE;
  begin
    ACanvas.Brush.Style := bsClear; 
    Windows.DrawText(ACanvas.Handle, PChar(S), Length(S), PRect(@R)^, uFormat);
  end;  

var
  R2: TRect;
  W, H: Integer;
begin
  inherited;
  OffsetRect(R, -R.Left, -R.Top);
  InflateRect(R, -4, -4);

  ACanvas.Brush.Style := bsSolid;
  ACanvas.Pen.Color := clWindowText;
  { Border }
  if ReportLink.DrawBorder then
  begin
    InflateRect(R, 1, 1);
    ACanvas.Brush.Color := ReportLink.BorderColor;
    ACanvas.FrameRect(R);
    InflateRect(R, -1, -1);    
  end;  

  { Interior }
  if not ReportLink.Transparent then
  begin
    ACanvas.Brush.Color := ReportLink.Color;
    ACanvas.FillRect(R);
  end;

  { Charts }
  W := R.Right - R.Left;
  H := R.Bottom - R.Top;

  { Plan }
  R2 := Bounds(R.Left + 2, 4, R.Right, 12);
  ACanvas.Font.Style := [fsBold];
  DrawText(ACanvas, R2, cxGetResourceString(@sdxPlan));
  R2 := Rect(R.Left + 30, R2.Bottom + 2, R.Right - 30, R2.Bottom + 3);
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := clWindowText;
  ACanvas.FillRect(R2);

  ACanvas.Brush.Style := bsClear;
  { Swimming-pool }           
  R2 := Bounds(R.Left + 2, 27, R.Left + W div 2 - 22, H div 4);
  ACanvas.RoundRect(R2.Left, R2.Top, R2.Right, R2.Bottom, 10, 10);
  DrawText(ACanvas, R2, cxGetResourceString(@sdxSwimmingPool));

  { Administration }    
  OffsetRect(R2, R2.Right - R2.Left + 30, 0);
  ACanvas.Rectangle(R2.Left, R2.Top, R2.Right, R2.Bottom);
  DrawText(ACanvas, R2, cxGetResourceString(@sdxAdministration));

  { Park }      
  OffsetRect(R2, 0, R2.Bottom - R2.Top + 30);
  Inc(R2.Bottom, R2.Bottom - R2.Top);
  ACanvas.Ellipse(R2.Left, R2.Top, R2.Right, R2.Bottom);
  ilFlowChart.Draw(ACanvas, R2.Left + (R2.Right - R2.Left) div 2 - 1 * ilFlowChart.Width div 2, R2.Top + 10, 0);  
  ilFlowChart.Draw(ACanvas, R2.Left + (R2.Right - R2.Left) div 2 - 2 * ilFlowChart.Width, R2.Top + ilFlowChart.Height + 20, 0);  
  ilFlowChart.Draw(ACanvas, R2.Left + (R2.Right - R2.Left) div 2 + 1 * ilFlowChart.Width, R2.Top + ilFlowChart.Height + 20, 0);  
  DrawText(ACanvas, R2, cxGetResourceString(@sdxPark));

  { Car-parking }
  OffsetRect(R2, -R2.Right + R2.Left - 30, 0);
  ACanvas.Rectangle(R2.Left, R2.Top, R2.Right, R2.Bottom);
  DrawText(ACanvas, R2, cxGetResourceString(@sdxCarParking));

  { Crosses }
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := clBtnShadow;
  R2 := Rect(R.Left + W div 2 - 10, 27, R.Left + W div 2 + 8, R.Bottom - 2);
  ACanvas.FillRect(R2);
  R2 := Rect(R.Left + 2, R.Top + 28 + H div 4, R.Right - 2, R.Top + 27 + H div 4 + 20);
  ACanvas.FillRect(R2);

  ACanvas.Font.Style := [];
end;

function TdxFCReportLinkDesignWindow.GetReportLink: TdxFlowChartReportLink;
begin
  Result := inherited ReportLink as TdxFlowChartReportLink;
end;

procedure TdxFCReportLinkDesignWindow.ccbxColorChange(Sender: TObject);
var
  Color: TColor;
begin
  if LockControlsUpdate then Exit;
  Color := TdxPSColorCombo(Sender).ColorValue;
  case TdxPSColorCombo(Sender).Tag of
    0: ReportLink.Color := Color;
    1: ReportLink.BorderColor := Color;
  end;
  Modified := True;
  UpdatePreview;
end;

procedure TdxFCReportLinkDesignWindow.UpdatePreview;
begin
  FPreviewBox.Invalidate;
end;
  
procedure TdxFCReportLinkDesignWindow.chbxTransparentClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.Transparent := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TdxFCReportLinkDesignWindow.stTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TdxFCReportLinkDesignWindow.chbxDrawBorderClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.DrawBorder := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TdxFCReportLinkDesignWindow.stDrawBorderClick(Sender: TObject);
begin
  if chbxDrawBorder.CanFocus then ActiveControl := chbxDrawBorder;
  chbxDrawBorder.Checked := not chbxDrawBorder.Checked;
end;

procedure TdxFCReportLinkDesignWindow.lblColorClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TCustomComboBox(ActiveControl).DroppedDown := True;
end;

initialization
  dxPSRegisterReportLink(TdxFlowChartReportLink, TdxCustomFlowChart, TdxFCReportLinkDesignWindow);

finalization
  dxPSUnregisterReportLink(TdxFlowChartReportLink, TdxCustomFlowChart, TdxFCReportLinkDesignWindow);

end.

