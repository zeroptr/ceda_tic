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

unit dxPSStdGrLnk;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
  Grids, StdCtrls, ExtCtrls, ComCtrls, CheckLst, dxPSRes, dxPSCore, dxPSGrLnks, 
  dxPSGlbl, dxPSBaseGridLnk, cxDrawTextUtils;

type
  TStddxGridReportLink = class(TCustomdxGridReportLink)
  private
    FSaveFont: TFont;
    FCustomDrawFontChanged: Boolean;
    procedure CustomDrawFontChanged(Sender: TObject);    
  protected
    class function IsDrawGridLink: Boolean; virtual;
    class function IsStringGridLink: Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;
  
  TdxCustomDrawTextCellEvent = procedure(Sender: TBasedxReportLink;
    ACol, ARow: Integer; ACanvas: TCanvas; ABoundsRect, AClientRect: TRect;
    var AText: string; AFont: TFont; var AColor: TColor;
    var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY;
    var ADone: Boolean) of object;

  TdxStringGridReportLink = class(TStddxGridReportLink)
  private
    FTextAlignX: TcxTextAlignX;
    FTextAlignY: TcxTextAlignY;
    FOnCustomDrawCell: TdxCustomDrawTextCellEvent;
    function GetStringGrid: TStringGrid;
    procedure SetTextAlignX(Value: TcxTextAlignX);
    procedure SetTextAlignY(Value: TcxTextAlignY);
  protected
    procedure InternalRestoreDefaults; override;
    class function IsStringGridLink: Boolean; override;
          
    function GetCellText(ACol, ARow: Integer): string; override;
    function GetCellTextAlignX(ACol, ARow: Integer): TcxTextAlignX; override;
    function GetCellTextAlignY(ACol, ARow: Integer): TcxTextAlignY; override;
    procedure SetDrawMode(Value: TdxGridDrawMode); override;
    
    procedure CustomDraw(AItem: TAbstractdxReportCellData; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var ADone: Boolean); override;
    procedure DoCustomDrawCell(ACol, ARow: Integer; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var AText: string; AFont: TFont;
      var AColor: TColor; var ATextAlignX: TcxTextAlignX;
      var ATextAlignY: TcxTextAlignY; var ADone: Boolean); virtual;
    function IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
    property StringGrid: TStringGrid read GetStringGrid;
  published
    property AutoWidth;
    property Color;
    property DrawMode;
    property Effects3D;
    property EndEllipsis;
    property EvenColor;
    property EvenFont;
    property FixedColor;
    property FixedFont;
    property FixedTransparent;
    property Font;
    property GridLineColor;
    property HeadersOnEveryPage;
    property IncludeFixed;
    property Multiline;
    property OddColor;
    property OddFont;
    property OnlySelected;
    property Options;
    property RowAutoHeight;
    property ScaleFonts;
    property Soft3D;
    property SupportedCustomDraw;
    property TextAlignX: TcxTextAlignX read FTextAlignX write SetTextAlignX default taLeft;
    property TextAlignY: TcxTextAlignY read FTextAlignY write SetTextAlignY default taCenterY;
    property Transparent;
    property UseCustomPageBreaks;
    property UseHorzDelimiters;
    property UseVertDelimiters;
    
    property OnCustomDrawCell: TdxCustomDrawTextCellEvent read FOnCustomDrawCell write FOnCustomDrawCell;
    property OnGetCustomPageBreaks;
    property OnInitializeItem;
  end;

  TdxCustomDrawCellEvent = procedure(Sender: TBasedxReportLink;
    ACol, ARow: Integer; ACanvas: TCanvas; ABoundsRect, AClientRect: TRect) of object;

  TdxCustomDrawCellExEvent = procedure(Sender: TBasedxReportLink;
    ACol, ARow: Integer; ACanvas: TCanvas; AFont: TFont; ABoundsRect, AClientRect: TRect; 
    var ADone: Boolean) of object;

  TdxDrawGridReportLink = class(TStddxGridReportLink)
  private
    FDefaultDrawing: Boolean;
    FOnCustomDrawCell: TdxCustomDrawCellEvent;
    FOnCustomDrawCellEx: TdxCustomDrawCellExEvent;
    function GetDrawGrid: TDrawGrid;
    procedure SetDefaultDrawing(Value: Boolean);
  protected
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;

    function GetCellText(ACol, ARow: Integer): string; override;
    function GetDataItemClass(ACol: Integer; ARow: Integer = 0): TdxReportCellDataClass; override;
    procedure SetDrawMode(Value: TdxGridDrawMode); override;

    procedure CustomDraw(AItem: TAbstractdxReportCellData; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var ADone: Boolean); override;
    procedure DoCustomDrawCell(ACol, ARow: Integer; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect); virtual;
    procedure DoCustomDrawCellEx(ACol, ARow: Integer; ACanvas: TCanvas;
      AFont: TFont; ABoundsRect, AClientRect: TRect); virtual;
    class function IsDrawGridLink: Boolean; override;
    function IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
    class function Serializable: Boolean; override;

    property DrawGrid: TDrawGrid read GetDrawGrid;
  published
    property AutoWidth;
    property Color;
    property DefaultDrawing: Boolean read FDefaultDrawing write SetDefaultDrawing default True;
    property DrawMode;
    property Effects3D;
    property EvenColor;
    property EvenFont;
    property FixedColor;
    property FixedFont;
    property FixedTransparent;
    property Font;
    property GridLineColor;
    property HeadersOnEveryPage;
    property IncludeFixed;
    property OddColor;
    property OnlySelected;
    property Options;
    property ScaleFonts;
    property Soft3D;
    property SupportedCustomDraw default True;
    property Transparent;
    property UseCustomPageBreaks;
    property UseHorzDelimiters;
    property UseVertDelimiters;

    property OnCustomDrawCell: TdxCustomDrawCellEvent read FOnCustomDrawCell write FOnCustomDrawCell;
    property OnCustomDrawCellEx: TdxCustomDrawCellExEvent read FOnCustomDrawCellEx write FOnCustomDrawCellEx;
    property OnGetCustomPageBreaks;
    property OnInitializeItem;
  end;
  
  TdxGridReportLinkDesignWindow = class(TStandarddxReportLinkDesignWindow)
    PageControl1: TPageControl;
    tshOptions: TTabSheet;
    tshColor: TTabSheet;
    tshFont: TTabSheet;
    pnlOptions: TPanel;
    pnlColor: TPanel;
    pnlFont: TPanel;
    lblGridLinesColor: TLabel;
    btnFont: TButton;
    edFont: TEdit;
    btnFixedFont: TButton;
    edFixedFont: TEdit;
    chbxTransparent: TCheckBox;
    gbxTransparent: TGroupBox;
    lblColor: TLabel;
    chbxFixedTransparent: TCheckBox;
    gbxFixedTransparent: TGroupBox;
    lblFixedColor: TLabel;
    bvlFixedColorHolder: TBevel;
    bvlLineColorHolder: TBevel;
    bvlColorHolder: TBevel;
    pnlPreview: TPanel;
    lblEvenColor: TLabel;
    bvlEvenColorHolder: TBevel;
    btnEvenFont: TButton;
    edEvenFont: TEdit;
    chbxShowVertLines: TCheckBox;
    chbxShowFixedHorzLines: TCheckBox;
    chbxShowFixedVertLines: TCheckBox;
    chbxShowBorders: TCheckBox;
    chbxShowHorzLines: TCheckBox;
    lblShow: TLabel;
    Bevel11: TBevel;
    tshBehaviors: TTabSheet;
    Panel1: TPanel;
    chbxIncludeFixed: TCheckBox;
    chbxOnlySelected: TCheckBox;
    Image3: TImage;
    lblSelection: TLabel;
    Bevel3: TBevel;
    lblLookAndFeel: TLabel;
    Bevel15: TBevel;
    Image8: TImage;
    chbxUse3DEffects: TCheckBox;
    chbxUseSoft3D: TCheckBox;
    imgGrid: TImage;
    lblDrawMode: TLabel;
    cbxDrawMode: TComboBox;
    lblOnEveryPage: TLabel;
    Image1: TImage;
    Bevel10: TBevel;
    chbxFixedRowsOnEveryPage: TCheckBox;
    chbxRowAutoHeight: TCheckBox;
    bvlMiscellaneous: TBevel;
    lblMiscellaneous: TLabel;
    imgMiscellaneous: TImage;
    lblPreview: TStaticText;
    chbxAutoWidth: TCheckBox;
    stTransparent: TStaticText;
    stFixedTransparent: TStaticText;
    procedure ccbxColorChange(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure pbxPreviewPaint(Sender: TObject);
    procedure chbxOnlySelectedClick(Sender: TObject);
    procedure chbxIncludeFixedClick(Sender: TObject);
    procedure chbxTransparentClick(Sender: TObject);
    procedure lblColorClick(Sender: TObject);
    procedure chbxRowAutoHeightClick(Sender: TObject);
    procedure chbxFixedRowsOnEveryPageClick(Sender: TObject);
    procedure chbxShowBordersClick(Sender: TObject);
    procedure cbxDrawModeClick(Sender: TObject);
    procedure chbxUse3DEffectsClick(Sender: TObject);
    procedure chbxUseSoft3DClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure cbxDrawModeDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure chbxAutoWidthClick(Sender: TObject);
    procedure stFixedTransparentClick(Sender: TObject);
    procedure stTransparentClick(Sender: TObject);
  private
    FccbxColor: TCustomComboBox;
    FccbxEvenColor: TCustomComboBox;
    FccbxFixedColor: TCustomComboBox;
    FccbxGridLineColor: TCustomComboBox;
    FPreviewBox: TCustomControl;
    function GetReportLink: TStddxGridReportLink;
    procedure CreateControls;
    procedure CMDialogChar(var message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure DoInitialize; override;
    {$IFDEF DELPHI7}
    function GetPreviewHost: TCustomPanel; override;
    {$ENDIF}    
    procedure LoadStrings; override;
    procedure PaintPreview(ACanvas: TCanvas; R: TRect); override;
    procedure UpdateControlsState; override;
    procedure UpdatePreview; override;   
  public
    constructor Create(AOwner: TComponent); override;   

    property ReportLink: TStddxGridReportLink read GetReportLink;    
  end;

implementation

{$R *.DFM}

uses
  cxClasses, dxExtCtrls, dxPrnDev, dxPSUtl;

{ TStddxGridReportLink }

constructor TStddxGridReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FSaveFont := TFont.Create;
  FSaveFont.OnChange := CustomDrawFontChanged;
end;

destructor TStddxGridReportLink.Destroy;
begin
  FreeAndNil(FSaveFont);
  inherited;
end;

class function TStddxGridReportLink.IsDrawGridLink: Boolean;
begin
  Result := False;
end;

class function TStddxGridReportLink.IsStringGridLink: Boolean;
begin
  Result := False;
end;

procedure TStddxGridReportLink.CustomDrawFontChanged(Sender: TObject);
begin
  FCustomDrawFontChanged := True;
end;

{ TdxStringGridReportLink }

procedure TdxStringGridReportLink.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxStringGridReportLink then
  begin
    TextAlignX := TdxStringGridReportLink(Source).TextAlignX;
    TextAlignY := TdxStringGridReportLink(Source).TextAlignY;
  end;
end;

class function TdxStringGridReportLink.IsStringGridLink: Boolean;
begin
  Result := True;
end;

procedure TdxStringGridReportLink.InternalRestoreDefaults;
begin
  inherited;
  TextAlignX := dxPSCore.dxDefaultTextAlignX; {taLeft}
  TextAlignY := dxPSCore.dxDefaultTextAlignY; {taCenterY}
end;

function TdxStringGridReportLink.GetStringGrid: TStringGrid;
begin
  Result := TStringGrid(Component);
end;

procedure TdxStringGridReportLink.SetTextAlignX(Value: TcxTextAlignX);
begin
  if FTextAlignX <> Value then
  begin
    FTextAlignX := Value;
    LinkModified(True);
  end;
end;

function TdxStringGridReportLink.GetCellText(ACol, ARow: Integer): string;
begin
  Result := StringGrid.Cells[ACol, ARow];
end;

function TdxStringGridReportLink.GetCellTextAlignX(ACol, ARow: Integer): TcxTextAlignX;
begin
  if DrawMode <> gdmBorrowSource then 
    Result := FTextAlignX
  else
    Result := inherited GetCellTextAlignX(ACol, ARow);
end;

function TdxStringGridReportLink.GetCellTextAlignY(ACol, ARow: Integer): TcxTextAlignY;
begin
  if DrawMode <> gdmBorrowSource then 
    Result := FTextAlignY
  else
    Result := inherited GetCellTextAlignY(ACol, ARow);
end;

procedure TdxStringGridReportLink.SetTextAlignY(Value: TcxTextAlignY);
begin
  if FTextAlignY <> Value then
  begin
    FTextAlignY := Value;
    LinkModified(True);
  end;
end;

procedure TdxStringGridReportLink.SetDrawMode(Value: TdxGridDrawMode);
begin
  if Value > gdmChess then Value := gdmChess;
  inherited SetDrawMode(Value);
end;

function TdxStringGridReportLink.IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean;
begin
  Result := inherited IsSupportedCustomDraw(Item) and Assigned(FOnCustomDrawCell);
end;

procedure TdxStringGridReportLink.CustomDraw(AItem: TAbstractdxReportCellData;
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var ADone: Boolean);
var
  AColor: TColor;
  AText: string;
  ACol, ARow: Integer;
  ATextAlignX: TcxTextAlignX;
  ATextAlignY: TcxTextAlignY;
begin
  with TdxReportCellString(AItem) do
  begin
    GetCellColRow(AItem, ACol, ARow);
    AColor := ColorToRGB(Color);
    if Transparent then AColor := clNone;
    FSaveFont.Assign(Font);
    FCustomDrawFontChanged := False;
    AText := Text;
    ATextAlignX := TextAlignX;
    ATextAlignY := TextAlignY;
    DoCustomDrawCell(ACol, ARow, ACanvas, ABoundsRect, AClientRect, AText, 
      FSaveFont, AColor, ATextAlignX, ATextAlignY, ADone);
    if not ADone then
    begin
      if FCustomDrawFontChanged then
      begin
        SelectObject(ACanvas.Handle, FSaveFont.Handle);
        SetTextColor(ACanvas.Handle, ColorToRGB(FSaveFont.Color));
        FontIndex := -1;
      end;
      if AColor <> clNone then
      begin
        AItem.Color := AColor;
        AItem.Transparent := False;
      end;
      Text := AText;
      TextAlignX := ATextAlignX;
      TextAlignY := ATextAlignY;
    end;
  end;
end;

procedure TdxStringGridReportLink.DoCustomDrawCell(ACol, ARow: Integer; ACanvas: TCanvas;
  ABoundsRect, AClientRect: TRect; var AText: string; AFont: TFont; var AColor: TColor;
  var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawCell) then
    FOnCustomDrawCell(Self, ACol, ARow, ACanvas, ABoundsRect, AClientRect, AText,
      AFont, AColor, ATextAlignX, ATextAlignY, ADone);
end;

type  
  TdxReportCustomDrawCellData = class(TAbstractdxReportCellData)
  private
    FDefaultDrawing: Boolean;
  protected
    class function Serializable: Boolean; override;
    function CustomDraw(DC: HDC): Boolean; override;
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure Assign(Source: TPersistent); override;
    property DefaultDrawing: Boolean read FDefaultDrawing write FDefaultDrawing;
  end;

constructor TdxReportCustomDrawCellData.Create(AParent: TdxReportCell);
begin
  inherited;
  DefaultDrawing := True;
end;

procedure TdxReportCustomDrawCellData.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxReportCustomDrawCellData then 
    DefaultDrawing := TdxReportCustomDrawCellData(Source).DefaultDrawing;
end;

class function TdxReportCustomDrawCellData.Serializable: Boolean;
begin
  Result := False;
end;

function TdxReportCustomDrawCellData.CustomDraw(DC: HDC): Boolean;
begin
  if DefaultDrawing then 
  begin
    if IsBackgroundDrawn then DrawBackground(DC);
    if IsBordersDrawn then DrawBorders(DC);    
  end; 
  inherited CustomDraw(DC);
  Result := True;
end;

{ TdxDrawGridReportLink }

procedure TdxDrawGridReportLink.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxDrawGridReportLink then
    DefaultDrawing := TdxDrawGridReportLink(Source).DefaultDrawing;
end;

class function TdxDrawGridReportLink.Serializable: Boolean;
begin
  Result := False;
end;

class function TdxDrawGridReportLink.IsDrawGridLink: Boolean;
begin
  Result := True;
end;

procedure TdxDrawGridReportLink.InternalRestoreDefaults;
begin
  inherited;
  DefaultDrawing := True;
  SupportedCustomDraw := True;
end;

function TdxDrawGridReportLink.GetCellText(ACol, ARow: Integer): string;
begin
  Result := '';
end;

procedure TdxDrawGridReportLink.InternalRestoreFromOriginal;
begin
  inherited;
  if DrawGrid <> nil then
    DefaultDrawing := DrawGrid.DefaultDrawing;
end;

function TdxDrawGridReportLink.GetDrawGrid: TDrawGrid;
begin
  Result := TDrawGrid(Component);
end;

procedure TdxDrawGridReportLink.SetDefaultDrawing(Value: Boolean);
begin
  if DefaultDrawing <> Value then
  begin
    FDefaultDrawing := Value;
    if SupportedCustomDraw then LinkModified(True);
  end;
end;

procedure TdxDrawGridReportLink.SetDrawMode(Value: TdxGridDrawMode);
begin
  if Value > gdmChess then Value := gdmChess;
  inherited SetDrawMode(Value);
end;

function TdxDrawGridReportLink.GetDataItemClass(ACol: Integer; ARow: Integer = 0): TdxReportCellDataClass;
begin
  Result := TdxReportCustomDrawCellData;
end;

procedure TdxDrawGridReportLink.CustomDraw(AItem: TAbstractdxReportCellData;
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var ADone: Boolean);
var
  ACol, ARow: Integer;
begin
  with TdxReportCustomDrawCellData(AItem) do
  begin
    GetCellColRow(AItem, ACol, ARow);
    FSaveFont.Assign(Font);
    DoCustomDrawCellEx(ACol, ARow, ACanvas, FSaveFont, ABoundsRect, AClientRect);
  end;
  ADone := True;
end;

procedure TdxDrawGridReportLink.DoCustomDrawCellEx(ACol, ARow: Integer; 
  ACanvas: TCanvas; AFont: TFont; ABoundsRect, AClientRect: TRect);
var
  ADone: Boolean;  
begin  
  ADone := False;
  if Assigned(FOnCustomDrawCellEx) then 
    FOnCustomDrawCellEx(Self, ACol, ARow, ACanvas, AFont, ABoundsRect, AClientRect, ADone);
  if not ADone then 
    DoCustomDrawCell(ACol, ARow, ACanvas, ABoundsRect, AClientRect);  
end;

procedure TdxDrawGridReportLink.DoCustomDrawCell(ACol, ARow: Integer; ACanvas: TCanvas;
  ABoundsRect, AClientRect: TRect);
begin
  if Assigned(FOnCustomDrawCell) then 
    FOnCustomDrawCell(Self, ACol, ARow, ACanvas, ABoundsRect, AClientRect);
end;

function TdxDrawGridReportLink.IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean;
begin
  Result := inherited IsSupportedCustomDraw(Item) and 
   (Assigned(FOnCustomDrawCellEx) or Assigned(FOnCustomDrawCell));
end;

{ TdxSGrReportLinkDesignWindow }

constructor TdxGridReportLinkDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxPSGlbl.dxhcStringGridReportLinkDesigner;
  inherited;
  CreateControls;
  PageControl1.ActivePage := PageControl1.Pages[0];
end;

function TdxGridReportLinkDesignWindow.GetReportLink: TStddxGridReportLink;
begin
  Result := inherited ReportLink as TStddxGridReportLink;
end;

{$IFDEF DELPHI7}
function TdxGridReportLinkDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}    

procedure TdxGridReportLinkDesignWindow.LoadStrings;
begin
  inherited;
  tshOptions.Caption := cxGetResourceString(@sdxOptions);
  tshFont.Caption := cxGetResourceString(@sdxFonts);
  tshColor.Caption := cxGetResourceString(@sdxColors);
  tshBehaviors.Caption := cxGetResourceString(@sdxBehaviors);
  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));

  lblShow.Caption := cxGetResourceString(@sdxShow);
  chbxShowBorders.Caption := cxGetResourceString(@sdxBorderLines);
  chbxShowHorzLines.Caption := cxGetResourceString(@sdxHorzLines);
  chbxShowVertLines.Caption := cxGetResourceString(@sdxVertLines);
  chbxShowFixedHorzLines.Caption := cxGetResourceString(@sdxFixedHorzLines);
  chbxShowFixedVertLines.Caption := cxGetResourceString(@sdxFixedVertLines);

  lblMiscellaneous.Caption := cxGetResourceString(@sdxMiscellaneous);
  chbxRowAutoHeight.Caption := cxGetResourceString(@sdxRowAutoHeight);
  chbxAutoWidth.Caption := cxGetResourceString(@sdxAutoWidth);
  lblDrawMode.Caption := cxGetResourceString(@sdxDrawMode);
  with cbxDrawMode.Items do 
  begin
    BeginUpdate;
    try
      Clear;
      AddObject(cxGetResourceString(@sdxDrawModeStrict), TObject(gdmStrict));
      AddObject(cxGetResourceString(@sdxDrawModeOddEven), TObject(gdmOddEven));
      AddObject(cxGetResourceString(@sdxDrawModeChess), TObject(gdmChess));
    finally
      EndUpdate;
    end;
  end;
  
  stTransparent.Caption := ' ' + cxGetResourceString(@sdxTransparent) + ' ';
  lblColor.Caption := cxGetResourceString(@sdxColor);
  lblEvenColor.Caption := cxGetResourceString(@sdxEvenColor);
  stFixedTransparent.Caption := ' ' + cxGetResourceString(@sdxFixedTransparent) + ' ';
  lblFixedColor.Caption := cxGetResourceString(@sdxFixedColor);
  lblGridLinesColor.Caption := cxGetResourceString(@sdxGridLinesColor);

  btnFont.Caption := cxGetResourceString(@sdxBtnFont);
  btnEvenFont.Caption := cxGetResourceString(@sdxBtnEvenFont);
  btnFixedFont.Caption := cxGetResourceString(@sdxBtnFixedFont);

  lblOnEveryPage.Caption := cxGetResourceString(@sdxOnEveryPage);
  chbxFixedRowsOnEveryPage.Caption := cxGetResourceString(@sdxFixedRowOnEveryPage);

  lblSelection.Caption := cxGetResourceString(@sdxSelection);
  chbxOnlySelected.Caption := cxGetResourceString(@sdxOnlySelected);
  chbxIncludeFixed.Caption := cxGetResourceString(@sdxIncludeFixed);

  lblLookAndFeel.Caption := cxGetResourceString(@sdxLookAndFeel);
  chbxUse3DEffects.Caption := cxGetResourceString(@sdxUse3DEffects);
  chbxUseSoft3D.Caption := cxGetResourceString(@sdxSoft3D);
end;

procedure TdxGridReportLinkDesignWindow.DoInitialize;
begin
  inherited;
  chbxShowBorders.Checked := gpoBorder in ReportLink.Options;
  chbxShowHorzLines.Checked := gpoHorzLines in ReportLink.Options;
  chbxShowVertLines.Checked := gpoVertLines in ReportLink.Options;
  chbxShowFixedHorzLines.Checked := gpoFixedHorzLines in ReportLink.Options;
  chbxShowFixedVertLines.Checked := gpoFixedVertLines in ReportLink.Options;

  chbxRowAutoHeight.Visible := ReportLink.IsStringGridLink;
  if chbxRowAutoHeight.Visible then 
    chbxRowAutoHeight.Checked := TdxStringGridReportLink(ReportLink).RowAutoHeight;
  chbxAutoWidth.Checked := ReportLink.AutoWidth;

  with cbxDrawMode do 
    ItemIndex := Items.IndexOfObject(TObject(ReportLink.DrawMode));
  chbxTransparent.Checked := ReportLink.Transparent;
  TdxPSColorCombo(FccbxColor).ColorValue := ColorToRGB(ReportLink.Color);
  TdxPSColorCombo(FccbxEvenColor).ColorValue := ColorToRGB(ReportLink.EvenColor);
  chbxFixedTransparent.Checked := ReportLink.FixedTransparent;
  TdxPSColorCombo(FccbxFixedColor).ColorValue := ColorToRGB(ReportLink.FixedColor);
  TdxPSColorCombo(FccbxGridLineColor).ColorValue := ColorToRGB(ReportLink.GridLineColor);

  FontInfoToText(ReportLink.Font, edFont);
  FontInfoToText(ReportLink.EvenFont, edEvenFont);
  FontInfoToText(ReportLink.FixedFont, edFixedFont);          
  
  chbxFixedRowsOnEveryPage.Checked := ReportLink.HeadersOnEveryPage;
  chbxOnlySelected.Checked := ReportLink.OnlySelected;
  chbxIncludeFixed.Checked := ReportLink.IncludeFixed;

  chbxUse3DEffects.Checked := ReportLink.Effects3D;
  chbxUseSoft3D.Checked := ReportLink.Soft3D;
end;

procedure TdxGridReportLinkDesignWindow.PaintPreview(ACanvas: TCanvas; R: TRect);
begin
  inherited;
  dxPSDrawGridPreview(ACanvas, R, ReportLink);
end;

procedure TdxGridReportLinkDesignWindow.UpdateControlsState;
begin
  inherited;

  FccbxColor.Enabled := not chbxTransparent.Checked;
  lblColor.Enabled := FccbxColor.Enabled;
  FccbxEvenColor.Enabled := 
    not chbxTransparent.Checked and (ReportLink.DrawMode in [gdmOddEven, gdmChess]);
  lblEvenColor.Enabled := FccbxEvenColor.Enabled;
  FccbxFixedColor.Enabled := not chbxFixedTransparent.Checked;
  lblFixedColor.Enabled := FccbxFixedColor.Enabled;

  btnEvenFont.Enabled := ReportLink.DrawMode in [gdmOddEven, gdmChess];
  if ReportLink.DrawMode in [gdmOddEven, gdmChess] then
  begin
    lblColor.Caption := cxGetResourceString(@sdxOddColor);
    btnFont.Caption := cxGetResourceString(@sdxBtnOddFont);
  end
  else
  begin
    lblColor.Caption := cxGetResourceString(@sdxColor);
    btnFont.Caption := cxGetResourceString(@sdxBtnFont);
  end;
  chbxFixedRowsOnEveryPage.Enabled := not ReportLink.IsAggregated;
  chbxIncludeFixed.Enabled := chbxOnlySelected.Enabled and chbxOnlySelected.Checked;
  chbxUseSoft3D.Enabled := chbxUse3DEffects.Checked;
end;

procedure TdxGridReportLinkDesignWindow.UpdatePreview;
begin
  FPreviewBox.Invalidate;
end;
  
procedure TdxGridReportLinkDesignWindow.CreateControls;

  function CreateColorCombo(AParent: TWinControl; AHost: TControl;
    ATag: Integer; AAutoColor: TColor; ALabel: TLabel): TdxPSColorCombo;
  begin
    Result := TdxPSColorCombo.Create(Self);
    with TdxPSColorCombo(Result) do
    begin
      BoundsRect := AHost.BoundsRect;
      Tag := MakeTTag(ATag);
      Parent := AParent;
      ColorTypes := [ctPure];
      ShowColorName := True;
      ShowAutoColor := True;
      AutoColor := AAutoColor;
      OnChange := ccbxColorChange;
    end;
    ALabel.FocusControl := Result;
    AHost.Visible := False;
  end;

  procedure CreatePreviewBox;
  var
    R: TRect;
  begin
    FPreviewBox := TdxPSPaintPanel.Create(Self);
    with TdxPSPaintPanel(FPreviewBox) do
    begin
      Parent := pnlPreview;
      R := pnlPreview.BoundsRect;
      OffsetRect(R, -R.Left, -R.Top);
      InflateRect(R, -1, -1);
      BoundsRect := R;
      EdgeInner := esNone;
      EdgeOuter := esNone;
      OnPaint := pbxPreviewPaint;
    end;
  end;
  
begin
  CreatePreviewBox;
  
  FccbxColor := 
    CreateColorCombo(gbxTransparent, bvlColorHolder, 0, dxDefaultColor, lblColor);
  FccbxEvenColor := 
    CreateColorCombo(gbxTransparent, bvlEvenColorHolder, 1, dxDefaultColor, lblEvenColor);
  FccbxFixedColor := 
    CreateColorCombo(gbxFixedTransparent, bvlFixedColorHolder, 2, dxDefaultFixedColor, lblFixedColor);
  FccbxGridLineColor := 
    CreateColorCombo(pnlColor, bvlLineColorHolder, 3, dxDefaultGridLineColor, lblGridLinesColor);
end;

procedure TdxGridReportLinkDesignWindow.CMDialogChar(var message: TCMDialogChar);
var
  I: Integer;
begin
  inherited;
  with PageControl1 do
    for I := 0 to PageCount - 1 do
      if IsAccel(message.CharCode, Pages[I].Caption) then
      begin
        message.Result := 1;
        ActivePage := Pages[I];
        Exit;
      end;
end;

procedure TdxGridReportLinkDesignWindow.pbxPreviewPaint(Sender: TObject);
begin
  with TdxPSPaintPanel(Sender) do
    PaintPreview(Canvas, ClientRect);
end;

procedure TdxGridReportLinkDesignWindow.ccbxColorChange(Sender: TObject);
var
  AColor: TColor;
begin
  if LockControlsUpdate then Exit;
  AColor := TdxPSColorCombo(Sender).ColorValue;
  case TTagToInt(TdxPSColorCombo(Sender).Tag) of
    0: ReportLink.Color := AColor;
    1: ReportLink.EvenColor := AColor;
    2: ReportLink.FixedColor := AColor;
    3: ReportLink.GridLineColor := AColor;
  end;
  Modified := True;
  UpdatePreview;
end;

procedure TdxGridReportLinkDesignWindow.btnFontClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;

  with dxPSGlbl.FontDialog do 
  begin
    case TTagToInt(TButton(Sender).Tag) of
      0: Font := ReportLink.Font;
      1: Font := ReportLink.EvenFont;
      2: Font := ReportLink.FixedFont;
    end;

    if Execute then
    begin
      case TTagToInt(TButton(Sender).Tag) of
        0:
          begin
            ReportLink.Font := Font;
            FontInfoToText(ReportLink.Font, edFont);
          end;
        1:
          begin
            ReportLink.EvenFont := Font;
            FontInfoToText(ReportLink.EvenFont, edEvenFont);
          end;
        2:
          begin
            ReportLink.FixedFont := Font;
            FontInfoToText(ReportLink.FixedFont, edFixedFont);
          end;
      end;
      Modified := True;
      UpdatePreview;
    end;
  end;  
end;

procedure TdxGridReportLinkDesignWindow.chbxRowAutoHeightClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  if ReportLink.IsStringGridLink then 
    TdxStringGridReportLink(ReportLink).RowAutoHeight := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxGridReportLinkDesignWindow.chbxAutoWidthClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.AutoWidth := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxGridReportLinkDesignWindow.cbxDrawModeClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with TComboBox(Sender) do 
    ReportLink.DrawMode := TdxGridDrawMode(Items.Objects[ItemIndex]);
  Modified := True;
  UpdatePreview;  
end;

procedure TdxGridReportLinkDesignWindow.cbxDrawModeDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  dxPSBaseGridLnk.dxPSDrawComboDrawModeItem(Control, Index, Rect, State);
end;

procedure TdxGridReportLinkDesignWindow.chbxOnlySelectedClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.OnlySelected := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxGridReportLinkDesignWindow.chbxIncludeFixedClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.IncludeFixed := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxGridReportLinkDesignWindow.chbxUse3DEffectsClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.Effects3D := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TdxGridReportLinkDesignWindow.chbxUseSoft3DClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.Soft3D := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TdxGridReportLinkDesignWindow.chbxShowBordersClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with TCheckBox(Sender) do
    if Checked then
      ReportLink.Options := ReportLink.Options + [TdxGridPaintOption(TTagToInt(Tag))]
    else
      ReportLink.Options := ReportLink.Options - [TdxGridPaintOption(TTagToInt(Tag))];
  Modified := True;
  UpdatePreview;
end;

procedure TdxGridReportLinkDesignWindow.chbxFixedRowsOnEveryPageClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.HeadersOnEveryPage := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxGridReportLinkDesignWindow.chbxTransparentClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  case TTagToInt(TCheckBox(Sender).Tag) of
    0: ReportLink.Transparent := TCheckBox(Sender).Checked;
    1: ReportLink.FixedTransparent := TCheckBox(Sender).Checked;
  end;
  Modified := True;
  UpdatePreview;
end;

procedure TdxGridReportLinkDesignWindow.stFixedTransparentClick(Sender: TObject);
begin
  if chbxFixedTransparent.CanFocus then ActiveControl := chbxFixedTransparent;
  chbxFixedTransparent.Checked := not chbxFixedTransparent.Checked;
end;

procedure TdxGridReportLinkDesignWindow.stTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TdxGridReportLinkDesignWindow.lblColorClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TCustomComboBox(ActiveControl).DroppedDown := True;
end;

procedure TdxGridReportLinkDesignWindow.PageControl1Change(Sender: TObject);
begin
  lblPreview.Parent := TPageControl(Sender).ActivePage;
end;

initialization
  dxPSRegisterReportLink(TdxStringGridReportLink, TStringGrid, TdxGridReportLinkDesignWindow);
  dxPSRegisterReportLink(TdxDrawGridReportLink, TDrawGrid, TdxGridReportLinkDesignWindow);  

finalization
  dxPSUnregisterReportLink(TdxDrawGridReportLink, TDrawGrid, TdxGridReportLinkDesignWindow);  
  dxPSUnregisterReportLink(TdxStringGridReportLink, TStringGrid, TdxGridReportLinkDesignWindow);

end.

