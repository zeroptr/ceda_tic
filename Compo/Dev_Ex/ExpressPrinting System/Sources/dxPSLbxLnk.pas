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

unit dxPSLbxLnk;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, checklst, ImgList, dxPSGlbl, dxPSCore, 
  dxPSBaseGridLnk, dxPSGrLnks;

type
  TdxListBoxPaintOption = (lbxpoBorder, lbxpoHorzLines);
  TdxListBoxPaintOptions = set of TdxListBoxPaintOption;

  TCustomdxListBoxReportLinkControl = class(TdxCustomListBoxReportLink)
  private
    FOptions: TdxListBoxPaintOptions;
    FPaintItemsGraphics: Boolean;
    FTransparentGraphics: Boolean;
    function GetOptions: TdxListBoxPaintOptions;
    procedure SetOptions(Value: TdxListBoxPaintOptions);
    procedure SetPaintItemsGraphics(Value: Boolean);
    procedure SetTransparentGraphics(Value: Boolean);
  protected
    procedure AssignData(ACol, ARow: Integer; ADataItem: TAbstractdxReportCellData); override;
    function GetDataItemClass(ACol: Integer; ARow: Integer = 0): TdxReportCellDataClass; override;
    procedure InternalRestoreDefaults; override;
    function IsDrawBorder: Boolean; override;
    function IsDrawHorzLines: Boolean; override;
    procedure SetDrawMode(Value: TdxGridDrawMode); override;

    function GetCellHasImage(ACol, ARow: Integer): Boolean; override;
    function GetCellImage(ACol, ARow: Integer): TGraphic; override;
    function GetCellImageTransparent(ACol, ARow: Integer): Boolean; override;
  public
    procedure Assign(Source: TPersistent); override;

    property Options: TdxListBoxPaintOptions read GetOptions write SetOptions default [lbxpoBorder..lbxpoHorzLines];
    property PaintItemsGraphics: Boolean read FPaintItemsGraphics write SetPaintItemsGraphics default False;
    property TransparentGraphics: Boolean read FTransparentGraphics write SetTransparentGraphics default False;
  end;

  TdxListBoxReportLink = class(TCustomdxListBoxReportLinkControl)
  private
    function GetListBox: TListBox;
  public  
    property ListBox: TListBox read GetListBox;
  published
    property AutoWidth;
    property Color;
    property EndEllipsis;
    property EvenColor;
    property EvenFont;
    property Font;
    property OddColor;
    property OddFont;
    property Options;
    property Multiline;
    property PaintItemsGraphics;
    property RowAutoHeight;
    property ScaleFonts;
    property SupportedCustomDraw;
    property Transparent;
    property TransparentGraphics;
    property UseCustomPageBreaks;
    property UseHorzDelimiters;
    property UseVertDelimiters;
    property Width;
    
    property OnCustomDrawItem;
    property OnGetCustomPageBreaks;
    property OnInitializeItem;
  end;

  TdxLBxReportLinkDesignWindow = class(TStandarddxReportLinkDesignWindow)
    pnlPreview: TPanel;
    PageControl1: TPageControl;
    tshOptions: TTabSheet;
    pnlOptions: TPanel;
    tshColor: TTabSheet;
    pnlColor: TPanel;
    tshFont: TTabSheet;
    pnlFont: TPanel;
    btnFont: TButton;
    edFont: TEdit;
    lblGridLinesColor: TLabel;
    gbxTransparent: TGroupBox;
    lblColor: TLabel;
    chbxTransparent: TCheckBox;
    ilPreview: TImageList;
    bvlColorHolder: TBevel;
    bvlLineColorHolder: TBevel;
    tshBehaviors: TTabSheet;
    Panel1: TPanel;
    Image3: TImage;
    lblSelection: TLabel;
    Bevel3: TBevel;
    chbxOnlySelected: TCheckBox;
    lblEvenColor: TLabel;
    bvlEvenColorHolder: TBevel;
    btnEvenFont: TButton;
    edEvenFont: TEdit;
    chbxPaintItemGraphics: TCheckBox;
    lblShow: TLabel;
    Bevel11: TBevel;
    chbxShowBorders: TCheckBox;
    chbxShowHorzLines: TCheckBox;
    Bevel4: TBevel;
    chbxTransparentGraphics: TCheckBox;
    imgGrid: TImage;
    lblDrawMode: TLabel;
    cbxDrawMode: TComboBox;
    lblPreview: TStaticText;
    chbxRowAutoHeight: TCheckBox;
    lblMiscellaneous: TLabel;
    imgMiscellaneous: TImage;
    Bevel1: TBevel;
    chbxAutoWidth: TCheckBox;
    stTransparent: TStaticText;
    procedure chbxOnlySelectedClick(Sender: TObject);
    procedure ccbxColorChange(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure pbxPreviewPaint(Sender: TObject);
    procedure chbxPaintItemGraphicsClick(Sender: TObject);
    procedure chbxTransparentClick(Sender: TObject);
    procedure lblComboClick(Sender: TObject);
    procedure chbxShowBordersClick(Sender: TObject);
    procedure cbxDrawModeClick(Sender: TObject);
    procedure chbxRowAutoHeightClick(Sender: TObject);
    procedure chbxTransparentGraphicsClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure cbxDrawModeDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure chbxAutoWidthClick(Sender: TObject);
    procedure stTransparentClick(Sender: TObject);
  private
    FccbxColor: TCustomComboBox;
    FccbxEvenColor: TCustomComboBox;
    FccbxGridLineColor: TCustomComboBox;
    FItemCount: Integer;
    FPaintWidth: Integer;
    FPaintHeight: Integer;
    FPreviewBox: TCustomPanel;
    FPreviewFont: TFont;
    FRectHeight: Integer;
    FRectWidth: Integer;
    procedure CreateControls;
    function GetReportLink: TCustomdxListBoxReportLinkControl;
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
    destructor Destroy; override;

    property ReportLink: TCustomdxListBoxReportLinkControl read GetReportLink;
  end;

const
  dxDefaultListBoxPaintOptions: TdxListBoxPaintOptions = 
    [Low(TdxListBoxPaintOption)..High(TdxListBoxPaintOption)];

  dxListBoxStrings: array[0..5] of string =
    ('Sample Text Row #1', 'Sample Text Row #2', 'Sample Text Row #3', 
     'Sample Text Row #4', 'Sample Text Row #5', 'Sample Text Row #6');

implementation

{$R *.DFM}

uses
  CommCtrl, cxClasses, dxExtCtrls, dxPSRes, dxPrnDev, dxPSUtl;

{$IFNDEF DELPHI6}
type
  TCustomListBoxAccess = class(TCustomListBox);
{$ENDIF}

{ CustomListBox Helpers } 

function ListBoxGetMultiSelect(ACustomListBox: TCustomListBox): Boolean;
begin
 {$IFDEF DELPHI6}
  Result := ACustomListBox.MultiSelect;
 {$ELSE}
  Result := TCustomListBoxAccess(ACustomListBox).MultiSelect;
 {$ENDIF}
end;

 { TCustomdxListBoxReportLinkControl }

procedure TCustomdxListBoxReportLinkControl.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TCustomdxListBoxReportLinkControl then
  begin
    Options := TCustomdxListBoxReportLinkControl(Source).Options;
    PaintItemsGraphics := TCustomdxListBoxReportLinkControl(Source).PaintItemsGraphics;
  end;
end;

procedure TCustomdxListBoxReportLinkControl.AssignData(ACol, ARow: Integer; 
  ADataItem: TAbstractdxReportCellData);
var
  Obj: TObject;
begin
  inherited;
  if ADataItem is TdxReportCellImage then
    with TdxReportCellImage(ADataItem) do 
    begin
      ImageTransparent := TransparentGraphics;
      MakeSpaceForEmptyImage := True;
      Obj := CustomListBox.Items.Objects[ARow];
      if Obj is TGraphic then
        Image := TGraphic(Obj);
    end;
end;

function TCustomdxListBoxReportLinkControl.GetDataItemClass(ACol: Integer; 
  ARow: Integer = 0): TdxReportCellDataClass;
begin
  if PaintItemsGraphics then
    Result := TdxReportCellImage
  else
    Result := inherited GetDataItemClass(ACol, ARow);
end;

procedure TCustomdxListBoxReportLinkControl.InternalRestoreDefaults;
begin
  inherited;
  Options := dxDefaultListBoxPaintOptions; {[Low(TdxListBoxPaintOptions)..High(TdxListBoxPaintOptions)]}
  PaintItemsGraphics := False;
  TransparentGraphics := False;
end;

function TCustomdxListBoxReportLinkControl.IsDrawBorder: Boolean;
begin
  Result := lbxpoBorder in Options;
end;

function TCustomdxListBoxReportLinkControl.IsDrawHorzLines: Boolean;
begin
  Result := lbxpoHorzLines in Options;
end;

procedure TCustomdxListBoxReportLinkControl.SetDrawMode(Value: TdxGridDrawMode);
begin
  if Value > gdmOddEven then Value := gdmOddEven;
  inherited SetDrawMode(Value);
end;

function TCustomdxListBoxReportLinkControl.GetCellHasImage(ACol, ARow: Integer): Boolean;
begin
  if PaintItemsGraphics then
    try
      Result := CustomListBox.Items.Objects[ARow] is TGraphic;
    except
      Result := False;
    end
  else
    Result := False;
end;

function TCustomdxListBoxReportLinkControl.GetCellImage(ACol, ARow: Integer): TGraphic;
begin
  Result := TGraphic(CustomListBox.Items.Objects[ARow]);
end;

function TCustomdxListBoxReportLinkControl.GetCellImageTransparent(ACol, ARow: Integer): Boolean;
begin
  Result := TransparentGraphics;;
end;

function TCustomdxListBoxReportLinkControl.GetOptions: TdxListBoxPaintOptions;
begin
  Result := FOptions;
end;

procedure TCustomdxListBoxReportLinkControl.SetOptions(Value: TdxListBoxPaintOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxListBoxReportLinkControl.SetPaintItemsGraphics(Value: Boolean);
begin
  if FPaintItemsGraphics <> Value then
  begin
    FPaintItemsGraphics := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxListBoxReportLinkControl.SetTransparentGraphics(Value: Boolean);
begin
  if FTransparentGraphics <> Value then
  begin
    FTransparentGraphics := Value;
    LinkModified(True);
  end;
end;

{ TdxListBoxReportLink }

function TdxListBoxReportLink.GetListBox: TListBox;
begin
  Result := inherited Component as TListBox;
end;

{ TdxLBxReportLinkDesignWindow }

constructor TdxLBxReportLinkDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxhcListBoxReportLinkDesigner;
  inherited;
  CreateControls;
  FItemCount := 5;
  FRectWidth := FPreviewBox.Width - 15;
  FRectHeight := (FPreviewBox.Height - 15) div FItemCount;
  FPaintWidth := FRectWidth + 1;
  FPaintHeight := FItemCount * (FRectHeight + 1);
  PageControl1.ActivePage := PageControl1.Pages[0];
  FPreviewFont := TFont.Create;
end;

destructor TdxLBxReportLinkDesignWindow.Destroy;
begin
  FreeAndNil(FPreviewFont);
  inherited;
end;

procedure TdxLBxReportLinkDesignWindow.CreateControls;
var
  R: TRect;
begin
  FccbxColor := TdxPSColorCombo.Create(Self);
  with TdxPSColorCombo(FccbxColor) do
  begin
    BoundsRect := bvlColorHolder.BoundsRect;
    Tag := MakeTTag(0);
    Parent := gbxTransparent;
    ColorTypes := [ctPure];
    ShowColorName := True;
    ShowAutoColor := True;
    AutoColor := dxDefaultColor;
//    DropDownCount := Items.Count;
    OnChange := ccbxColorChange;
  end;
  lblColor.FocusControl := FccbxColor;

  FccbxEvenColor := TdxPSColorCombo.Create(Self);
  with TdxPSColorCombo(FccbxEvenColor) do
  begin
    BoundsRect := bvlEvenColorHolder.BoundsRect;
    Tag := MakeTTag(1);
    Parent := gbxTransparent;
    ColorTypes := [ctPure];
    ShowColorName := True;
    ShowAutoColor := True;
    AutoColor := dxDefaultColor;
//    DropDownCount := Items.Count;
    OnChange := ccbxColorChange;
  end;
  lblEvenColor.FocusControl := FccbxEvenColor;
  
  FccbxGridLineColor := TdxPSColorCombo.Create(Self);
  with TdxPSColorCombo(FccbxGridLineColor) do
  begin
    BoundsRect := bvlLineColorHolder.BoundsRect;
    Tag := MakeTTag(2);
    Parent := pnlColor;
    ColorTypes := [ctPure];
    ShowColorName := True;
    ShowAutoColor := True;
    AutoColor := dxDefaultGridLineColor;
//   DropDownCount := Items.Count;
    OnChange := ccbxColorChange;
  end;
  
  lblGridLinesColor.FocusControl := FccbxGridLineColor;
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

{$IFDEF DELPHI7}
function TdxLBxReportLinkDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}    

procedure TdxLBxReportLinkDesignWindow.LoadStrings;
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
  chbxPaintItemGraphics.Caption := cxGetResourceString(@sdxPaintItemsGraphics);
  chbxTransparentGraphics.Caption := cxGetResourceString(@sdxTransparentGraphics);
  
  lblDrawMode.Caption := cxGetResourceString(@sdxDrawMode);
  with cbxDrawMode.Items do 
  begin
    BeginUpdate;
    try
      Clear;
      AddObject(cxGetResourceString(@sdxDrawModeStrict), TObject(gdmStrict));
      AddObject(cxGetResourceString(@sdxDrawModeOddEven), TObject(gdmOddEven));
    finally
      EndUpdate;
    end;  
  end;  
 
  stTransparent.Caption := ' ' + cxGetResourceString(@sdxTransparent) + ' ';
  lblColor.Caption := cxGetResourceString(@sdxColor);
  lblEvenColor.Caption := cxGetResourceString(@sdxEvenColor);
  lblGridLinesColor.Caption := cxGetResourceString(@sdxGridLinesColor);

  btnFont.Caption := cxGetResourceString(@sdxBtnFont);
  btnEvenFont.Caption := cxGetResourceString(@sdxBtnEvenFont);
  
  lblSelection.Caption := cxGetResourceString(@sdxSelection);
  chbxOnlySelected.Caption := cxGetResourceString(@sdxOnlySelected);
  lblMiscellaneous.Caption := cxGetResourceString(@sdxMiscellaneous);
  chbxAutoWidth.Caption := cxGetResourceString(@sdxAutoWidth);
  chbxRowAutoHeight.Caption := cxGetResourceString(@sdxRowAutoHeight);
end;

function TdxLBxReportLinkDesignWindow.GetReportLink: TCustomdxListBoxReportLinkControl;
begin
  Result := inherited ReportLink as TCustomdxListBoxReportLinkControl;
end;

procedure TdxLBxReportLinkDesignWindow.CMDialogChar(var message: TCMDialogChar);
var
  I: Integer;
begin
  inherited;
  with PageControl1 do
    for I := 0 to PageControl1.PageCount - 1 do
      if IsAccel(message.CharCode, Pages[I].Caption) then
      begin
        message.Result := 1;
        ActivePage := Pages[I];
        Exit;
      end;
end;

procedure TdxLBxReportLinkDesignWindow.UpdateControlsState;

  function IsPaintItemsGraphics: Boolean;
  var
    I: Integer;
    Obj: TObject;
  begin
    Result := True;
    with ReportLink.CustomListBox do
      for I := 0 to Items.Count - 1 do
      begin
        Obj := Items.Objects[I];
        try
          if Obj is TGraphic then Exit;
        except
        end;
      end;
    Result := False;
  end;
  
begin
  inherited;   
  
  FccbxColor.Enabled := not chbxTransparent.Checked;
  lblColor.Enabled := FccbxColor.Enabled;
  FccbxEvenColor.Enabled := not chbxTransparent.Checked and
    (ReportLink.DrawMode in [gdmOddEven, gdmChess]);
  lblEvenColor.Enabled := FccbxEvenColor.Enabled;
  
  chbxOnlySelected.Enabled := 
    (ReportLink.CustomListBox = nil) or ListBoxGetMultiSelect(ReportLink.CustomListBox);
  chbxPaintItemGraphics.Enabled := 
    (ReportLink.CustomListBox = nil) or IsPaintItemsGraphics;
  chbxTransparentGraphics.Enabled := chbxPaintItemGraphics.Checked;
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
  btnEvenFont.Enabled := ReportLink.DrawMode in [gdmOddEven, gdmChess];
//    (ReportLink.ListBox.Style in [lbOwnerDrawVariable, lbOwnerDrawFixed]);
end;

procedure TdxLBxReportLinkDesignWindow.DoInitialize;
begin
  inherited;
  with cbxDrawMode do 
    ItemIndex := Items.IndexOfObject(TObject(ReportLink.DrawMode));

  chbxShowBorders.Checked := lbxpoBorder in ReportLink.Options;
  chbxShowHorzLines.Checked := lbxpoHorzLines in ReportLink.Options;
  chbxPaintItemGraphics.Checked := ReportLink.PaintItemsGraphics;
  chbxTransparentGraphics.Checked := ReportLink.TransparentGraphics;  
  
  chbxTransparent.Checked := ReportLink.Transparent;
  TdxPSColorCombo(FccbxColor).ColorValue := ReportLink.Color;
  TdxPSColorCombo(FccbxEvenColor).ColorValue := ReportLink.EvenColor;  
  TdxPSColorCombo(FccbxGridLineColor).ColorValue := ReportLink.GridLineColor;
  
  FontInfoToText(ReportLink.Font, edFont);          
  FontInfoToText(ReportLink.EvenFont, edEvenFont);
  
  chbxOnlySelected.Checked := ReportLink.OnlySelected;
  chbxAutoWidth.Checked := ReportLink.AutoWidth;
  chbxRowAutoHeight.Checked := ReportLink.RowAutoHeight;
end;

procedure TdxLBxReportLinkDesignWindow.PaintPreview(ACanvas: TCanvas; R: TRect);
const
  C = 6;
var
  DC: hDC;
  Brush: HBRUSH;
  I, dY, Offset: Integer;
  R2: TRect;
  PrevBkMode: Integer;
  PrevFont: HFONT;
  PrevFontColor: COLORREF;
  S: string;
begin
  inherited;
  DC := ACanvas.Handle;
  //FillRect(DC, R, HBRUSH(COLOR_WINDOW + 1));
  InflateRect(R, -4, -4);
  R2 := R;
  dY := (R.Bottom - R.Top) div C;
  with ReportLink do
  begin
    Brush := SelectObject(DC, CreateSolidBrush(ColorToRGB(GridLineColor)));
    for I := 0 to C do
      if (((I = 0) or (I = C)) and IsDrawBorder) or ((I > 0) and (I < C) and IsDrawHorzLines) then
      begin
        R := MakeRect(R2.Left + 1, R2.Top + I * dY, R2.Right - 1, R2.Top + I * dY + 1);
        PatBlt(DC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, PATCOPY);
      end;
    if IsDrawBorder then
    begin
      R := MakeRect(R2.Left, R2.Top, R2.Left + 1, R2.Top + dY * C + 1);
      PatBlt(DC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, PATCOPY);
      R := MakeRect(R2.Right - 1, R2.Top, R2.Right, R2.Top + dY * C + 1);
      PatBlt(DC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, PATCOPY);
    end;
    DeleteObject(SelectObject(DC, Brush));
    PrevBkMode := SetBkMode(DC, Windows.TRANSPARENT);
    PrevFont := GetCurrentObject(DC, OBJ_FONT);
    PrevFontColor := GetTextColor(DC);
    for I := 0 to C - 1 do
    begin
      R := MakeRect(R2.Left + 1, R2.Top + I * dY + 1, R2.Right - 1, R2.Top + (I + 1) * dY + 
        Ord(not IsDrawHorzLines and (I < C - 1)));
      if not Transparent then
      begin
        Brush := CreateSolidBrush(ColorToRGB(ReportLink.GetCellColor(0, I)));
        FillRect(DC, R, Brush);
        DeleteObject(Brush);
      end;  
      Offset := 1;
      if PaintItemsGraphics then
      begin
        Inc(R.Left);
        ImageList_DrawEx(ilPreview.Handle, 0, DC, R.Left, R.Top + (dY - ilPreview.Height) div 2, 
          0, 0, CLR_NONE, CLR_NONE, ILD_NORMAL);
        Inc(Offset, ilPreview.Width + 1);
      end;
      Inc(R.Left, Offset);
      InflateRect(R, -2, -2);
      FPreviewFont.Assign(ReportLink.GetCellFont(0, I));
      FPreviewFont.Size := 8;
      SelectObject(DC, FPreviewFont.Handle);
      SetTextColor(DC, ColorToRGB(FPreviewFont.Color));
      S := dxListBoxStrings[I];
      Windows.DrawText(DC, PChar(S), Length(S), R, 
        DT_NOPREFIX or DT_SINGLELINE or dxDrawTextTextAlignX[TextAlignX] or dxDrawTextTextAlignY[TextAlignY]);  
    end;
    SetTextColor(DC, PrevFontColor);    
    SelectObject(DC, PrevFont);
    SetBkMode(DC, PrevBkMode);
  end;
end;

procedure TdxLBxReportLinkDesignWindow.chbxOnlySelectedClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.OnlySelected := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxLBxReportLinkDesignWindow.chbxPaintItemGraphicsClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PaintItemsGraphics := TCheckBox(Sender).Checked;
  Modified := True;
  FPreviewBox.Invalidate;
end;

procedure TdxLBxReportLinkDesignWindow.chbxTransparentGraphicsClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.TransparentGraphics := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxLBxReportLinkDesignWindow.chbxAutoWidthClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.AutoWidth := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxLBxReportLinkDesignWindow.chbxRowAutoHeightClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.RowAutoHeight := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxLBxReportLinkDesignWindow.cbxDrawModeClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with TComboBox(Sender) do 
    ReportLink.DrawMode := TdxGridDrawMode(Items.Objects[ItemIndex]);
  Modified := True;
  UpdatePreview;
end;

procedure TdxLBxReportLinkDesignWindow.cbxDrawModeDrawItem(Control: TWinControl; 
  Index: Integer; Rect: TRect;  State: TOwnerDrawState);
begin
  dxPSBaseGridLnk.dxPSDrawComboDrawModeItem(Control, Index, Rect, State);
end;

procedure TdxLBxReportLinkDesignWindow.chbxShowBordersClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with TCheckBox(Sender) do
    if Checked then 
      ReportLink.Options := ReportLink.Options + [TdxListBoxPaintOption(TTagToInt(Tag))]
    else  
      ReportLink.Options := ReportLink.Options - [TdxListBoxPaintOption(TTagToInt(Tag))];
  Modified := True;
  UpdatePreview;
end;

procedure TdxLBxReportLinkDesignWindow.chbxTransparentClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.Transparent := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TdxLBxReportLinkDesignWindow.stTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TdxLBxReportLinkDesignWindow.UpdatePreview;
begin
  FPreviewBox.Invalidate;
end;
  
procedure TdxLBxReportLinkDesignWindow.ccbxColorChange(Sender: TObject);
var
  AColor: TColor;
begin
  if LockControlsUpdate then Exit;
  AColor := TdxPSColorCombo(Sender).ColorValue;
  case TTagToInt(TdxPSColorCombo(Sender).Tag) of
    0: ReportLink.Color := AColor;
    1: ReportLink.EvenColor := AColor;
    2: ReportLink.GridLineColor := AColor;
  end;
  Modified := True;
  UpdatePreview;
end;

procedure TdxLBxReportLinkDesignWindow.btnFontClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;

  with dxPSGlbl.FontDialog do 
  begin
    case TTagToInt(TComponent(Sender).Tag) of
      0: Font := ReportLink.Font;
      1: Font := ReportLink.EvenFont;
    end;

    if Execute then
    begin
      case TTagToInt(TComponent(Sender).Tag) of
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
      end;
      Modified := True;
      UpdatePreview;
    end;
  end;  
end;

procedure TdxLBxReportLinkDesignWindow.pbxPreviewPaint(Sender: TObject);
begin
  with TdxPSPaintPanel(Sender) do
    PaintPreview(Canvas, ClientRect);
end;

procedure TdxLBxReportLinkDesignWindow.lblComboClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TCustomComboBox(ActiveControl).DroppedDown := True;
end;

procedure TdxLBxReportLinkDesignWindow.PageControl1Change(Sender: TObject);
begin
  lblPreview.Parent := TPageControl(Sender).ActivePage;
end;
 
initialization
  dxPSRegisterReportLink(TdxListBoxReportLink, TListBox, TdxLBxReportLinkDesignWindow);

finalization
  dxPSUnregisterReportLink(TdxListBoxReportLink, TListBox, TdxLBxReportLinkDesignWindow);

end.
