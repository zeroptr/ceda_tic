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

unit dxPSChLbxLnk;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, CheckLst, dxPSCore, dxPSGrLnks, dxPSGlbl,
  dxPSBaseGridLnk;

type
  TdxPSCheckGridCellDataMap = class(TdxPSTextGridCellDataMap)
  protected
    class procedure InitializeCellData(ACol, ARow: Integer; ADataItem: TAbstractdxReportCellData; 
      AReportLink: TAbstractdxGridReportLink); override;
    class function DataClass: TdxReportCellDataClass; override;
  end;
  
  TdxCheckListBoxPaintOption = (chlbxpoBorder, chlbxpoHorzLines, chlbxpoFlatCheckMarks);
  TdxCheckListBoxPaintOptions = set of TdxCheckListBoxPaintOption;

  TdxCheckListBoxReportLink = class(TdxCustomListBoxReportLink)
  private
    FOptions: TdxCheckListBoxPaintOptions;
    function GetOptions: TdxCheckListBoxPaintOptions;
    function GetCheckListBox: TCheckListBox;
    procedure SetOptions(Value: TdxCheckListBoxPaintOptions);
    function IsFlatCheckMarks: Boolean;
  protected
    function GetDataItemClass(ACol: Integer; ARow: Integer = 0): TdxReportCellDataClass; override;
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;

    function IsDrawBorder: Boolean; override;
    function IsDrawHorzLines: Boolean; override;
    procedure SetDrawMode(Value: TdxGridDrawMode); override;
  public
    procedure Assign(Source: TPersistent); override;
    property CheckListBox: TCheckListBox read GetCheckListBox;
  published
    property AutoWidth;
    property Color;
    property EndEllipsis;
    property EvenColor;
    property EvenFont;
    property Font;
    property OddColor;
    property OddFont;
    property Options: TdxCheckListBoxPaintOptions read GetOptions write SetOptions
      default [chlbxpoBorder..chlbxpoFlatCheckMarks];
    property Multiline;
    property RowAutoHeight;
    property ScaleFonts;
    property SupportedCustomDraw;
    property Transparent;
    property UseCustomPageBreaks;
    property UseHorzDelimiters;
    property UseVertDelimiters;
    property Width;
    
    property OnCustomDrawItem;
    property OnGetCustomPageBreaks;
    property OnInitializeItem;
  end;

  TdxChlbxReportLinkDesignWindow = class(TStandarddxReportLinkDesignWindow)
    pnlPreview: TPanel;
    PageControl1: TPageControl;
    tshOptions: TTabSheet;
    pnlOptions: TPanel;
    tshColor: TTabSheet;
    pnlColor: TPanel;
    lblGridLinesColor: TLabel;
    chbxTransparent: TCheckBox;
    tshFont: TTabSheet;
    pnlFont: TPanel;
    btnFont: TButton;
    edFont: TEdit;
    gbxTransparent: TGroupBox;
    lblColor: TLabel;
    bvlColorHolder: TBevel;
    bvlLineColorHolder: TBevel;
    chbxShowBorders: TCheckBox;
    chbxShowHorzLines: TCheckBox;
    chbxFlatCheckMarks: TCheckBox;
    lblShow: TLabel;
    Bevel11: TBevel;
    lblMiscellaneous: TLabel;
    Bevel4: TBevel;
    btnEvenFont: TButton;
    edEvenFont: TEdit;
    lblEvenColor: TLabel;
    bvlEvenColorHolder: TBevel;
    chbxRowAutoHeight: TCheckBox;
    Image5: TImage;
    imgGrid: TImage;
    lblDrawMode: TLabel;
    cbxDrawMode: TComboBox;
    lblPreview: TStaticText;
    chbxAutoWidth: TCheckBox;
    stTransparent: TStaticText;
    procedure ccbxColorChange(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure pbxPreviewPaint(Sender: TObject);
    procedure chbxTransparentClick(Sender: TObject);
    procedure lblComboClick(Sender: TObject);
    procedure cbxDrawModeClick(Sender: TObject);
    procedure chbxShowBordersClick(Sender: TObject);
    procedure chbxRowAutoHeightClick(Sender: TObject);
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
    FRectWidth: Integer;
    FRectHeight: Integer;
    procedure CreateControls;
    function GetReportLink: TdxCheckListBoxReportLink;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
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
    property ReportLink: TdxCheckListBoxReportLink read GetReportLink;
  end;

const
  dxDefaultCheckListBoxPaintOptions: TdxCheckListBoxPaintOptions =
    [chlbxpoBorder, chlbxpoHorzLines, chlbxpoFlatCheckMarks];

  DesignerStringCount = 6;  
  dxCheckListBoxStrings: array[0..DesignerStringCount - 1] of string =
    ('Sample Text Row #1', 'Sample Text Row #2', 'Sample Text Row #3', 
     'Sample Text Row #4', 'Sample Text Row #5', 'Sample Text Row #6');

implementation

uses
  cxClasses, dxExtCtrls, dxPSRes, dxPrnDev, dxPSUtl;

{$R *.DFM}

{ TdxPSCheckGridCellDataMap }

class function TdxPSCheckGridCellDataMap.DataClass: TdxReportCellDataClass;
begin
  Result := TdxReportCellCheck;
end;

class procedure TdxPSCheckGridCellDataMap.InitializeCellData(ACol, ARow: Integer; 
  ADataItem: TAbstractdxReportCellData; AReportLink: TAbstractdxGridReportLink);
begin
  inherited;
  with TdxReportCellCheck(ADataItem) do
  begin
    CheckPos := ccpLeft;
    Checked := TdxCheckListBoxReportLink(AReportLink).CheckListBox.State[ARow] > cbUnchecked;
    Enabled := TdxCheckListBoxReportLink(AReportLink).CheckListBox.State[ARow] < cbGrayed;
   {$IFDEF DELPHI5}
    Enabled := Enabled and TdxCheckListBoxReportLink(AReportLink).CheckListBox.ItemEnabled[ARow];
   {$ENDIF}
    FlatBorder := TdxCheckListBoxReportLink(AReportLink).IsFlatCheckMarks;
  end;
end;

{ TdxCheckListBoxReportLink }

procedure TdxCheckListBoxReportLink.Assign(Source: TPersistent);
begin
  if Source is TdxCheckListBoxReportLink then
    Options := TdxCheckListBoxReportLink(Source).Options;
  inherited;  
end;

procedure TdxCheckListBoxReportLink.InternalRestoreDefaults;
begin
  inherited;
  Options := dxDefaultCheckListBoxPaintOptions;
end;

procedure TdxCheckListBoxReportLink.InternalRestoreFromOriginal;
begin
  inherited;
  if CheckListBox.Flat then
    Options := Options + [chlbxpoFlatCheckMarks]
  else
    Options := Options - [chlbxpoFlatCheckMarks];
end;

function TdxCheckListBoxReportLink.IsDrawBorder: Boolean;
begin
  Result := chlbxpoBorder in Options;
end;

function TdxCheckListBoxReportLink.IsDrawHorzLines: Boolean;
begin
  Result := chlbxpoHorzLines in Options;
end;

procedure TdxCheckListBoxReportLink.SetDrawMode(Value: TdxGridDrawMode);
begin
  if Value > gdmOddEven then Value := gdmOddEven;
  inherited SetDrawMode(Value);
end;

function TdxCheckListBoxReportLink.GetCheckListBox: TCheckListBox;
begin
  Result := TCheckListBox(Component);
end;

function TdxCheckListBoxReportLink.GetDataItemClass(ACol: Integer; ARow: Integer = 0): TdxReportCellDataClass;
begin
  Result := TdxReportCellCheck;
end;

function TdxCheckListBoxReportLink.IsFlatCheckMarks: Boolean;
begin
  Result := chlbxpoFlatCheckMarks in Options;
end;

function TdxCheckListBoxReportLink.GetOptions: TdxCheckListBoxPaintOptions;
begin
  Result := FOptions;
end;

procedure TdxCheckListBoxReportLink.SetOptions(Value: TdxCheckListBoxPaintOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    LinkModified(True);
  end;
end;

{ TdxChlbxReportLinkDesignWindow }

constructor TdxChlbxReportLinkDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxhcCheckListBoxReportLinkDesigner;
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

destructor TdxChlbxReportLinkDesignWindow.Destroy;
begin
  FreeAndNil(FPreviewFont);
  inherited;
end;

procedure TdxChlbxReportLinkDesignWindow.CreateControls;
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

function TdxChlbxReportLinkDesignWindow.GetReportLink: TdxCheckListBoxReportLink;
begin
  Result := inherited ReportLink as TdxCheckListBoxReportLink;
end;

procedure TdxChlbxReportLinkDesignWindow.CMDialogChar(var Message: TCMDialogChar);
var
  I: Integer;
begin
  with PageControl1 do
    for I := 0 to PageControl1.PageCount - 1 do
      if IsAccel(Message.CharCode, Pages[I].Caption) then
      begin
        Message.Result := 1;
        ActivePage := Pages[I];
        Exit;
      end;
end;

procedure TdxChlbxReportLinkDesignWindow.LoadStrings;
begin
  inherited;
  tshOptions.Caption := cxGetResourceString(@sdxOptions);
  tshFont.Caption := cxGetResourceString(@sdxFonts);
  tshColor.Caption := cxGetResourceString(@sdxColors);
  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));

  lblShow.Caption := cxGetResourceString(@sdxShow);
  chbxShowBorders.Caption := cxGetResourceString(@sdxBorderLines);
  chbxShowHorzLines.Caption := cxGetResourceString(@sdxHorzLines);
  
  lblMiscellaneous.Caption := cxGetResourceString(@sdxMiscellaneous);
  chbxFlatCheckMarks.Caption := cxGetResourceString(@sdxFlatCheckMarks);
  chbxAutoWidth.Caption := cxGetResourceString(@sdxAutoWidth);
  chbxRowAutoHeight.Caption := cxGetResourceString(@sdxRowAutoHeight);

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
end;

procedure TdxChlbxReportLinkDesignWindow.UpdateControlsState;
begin
  inherited UpdateControlsState;
  FccbxColor.Enabled := not chbxTransparent.Checked;
  lblColor.Enabled := FccbxColor.Enabled;
  FccbxEvenColor.Enabled := not chbxTransparent.Checked and
    (ReportLink.DrawMode in [gdmOddEven, gdmChess]);
  lblEvenColor.Enabled := FccbxEvenColor.Enabled;
  
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
end;

procedure TdxChlbxReportLinkDesignWindow.DoInitialize;
begin
  inherited DoInitialize;

  with cbxDrawMode do 
    ItemIndex := Items.IndexOfObject(TObject(ReportLink.DrawMode));
  chbxShowBorders.Checked := chlbxpoBorder in ReportLink.Options;
  chbxShowHorzLines.Checked := chlbxpoHorzLines in ReportLink.Options;
  chbxFlatCheckMarks.Checked := chlbxpoFlatCheckMarks in ReportLink.Options;
  chbxAutoWidth.Checked := ReportLink.AutoWidth;
  chbxRowAutoHeight.Checked := ReportLink.RowAutoHeight;

  chbxTransparent.Checked := ReportLink.Transparent;
  TdxPSColorCombo(FccbxColor).ColorValue := ReportLink.Color;
  TdxPSColorCombo(FccbxEvenColor).ColorValue := ReportLink.EvenColor;
  TdxPSColorCombo(FccbxGridLineColor).ColorValue := ReportLink.GridLineColor;

  FontInfoToText(ReportLink.Font, edFont);
  FontInfoToText(ReportLink.EvenFont, edEvenFont);
end;

{$IFDEF DELPHI7}
function TdxChlbxReportLinkDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}

procedure TdxChlbxReportLinkDesignWindow.PaintPreview(ACanvas: TCanvas; R: TRect);
const
  CheckBorderMap: array[Boolean] of UINT = (0, DFCS_FLAT);
  ControlStateMap: array[TCheckBoxState] of UINT = 
    (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED, DFCS_BUTTON3STATE or DFCS_CHECKED);
  CheckStateMap: array[0..DesignerStringCount - 1] of TCheckBoxState = 
    (cbUnchecked, cbChecked, cbGrayed, cbUnchecked, cbChecked, cbChecked);
var
  DC: HDC;
  Brush: HBRUSH;
  I, dY: Integer;
  R2: TRect;
  PrevBkMode: Integer;
  PrevFont: HFONT;
  PrevFontColor: COLORREF;
  uState: UINT;
  S: string;
begin
  inherited;
  DC := ACanvas.Handle;
  //FillRect(DC, R, HBRUSH(COLOR_WINDOW + 1));
  InflateRect(R, -4, -4);
  R2 := R;
  dY := (R.Bottom - R.Top) div DesignerStringCount;

  with ReportLink do
  begin
    Brush := SelectObject(DC, CreateSolidBrush(ColorToRGB(GridLineColor)));
    for I := 0 to DesignerStringCount do
      if (((I = 0) or (I = DesignerStringCount)) and IsDrawBorder) or 
        ((I > 0) and (I < DesignerStringCount) and IsDrawHorzLines) then
      begin
        R := MakeRect(R2.Left + 1, R2.Top + I * dY, R2.Right - 1, R2.Top + I * dY + 1);
        PatBlt(DC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, PATCOPY);
      end;

    if IsDrawBorder then
    begin
      R := MakeRect(R2.Left, R2.Top, R2.Left + 1, R2.Top + dY * DesignerStringCount + 1);
      PatBlt(DC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, PATCOPY);
      R := MakeRect(R2.Right - 1, R2.Top, R2.Right, R2.Top + dY * DesignerStringCount + 1);
      PatBlt(DC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, PATCOPY);
    end;
    DeleteObject(SelectObject(DC, Brush));

    PrevBkMode := SetBkMode(DC, Windows.TRANSPARENT);
    PrevFont := GetCurrentObject(DC, OBJ_FONT);
    PrevFontColor := GetTextColor(DC);
    for I := 0 to DesignerStringCount - 1 do
    begin
      R := MakeRect(R2.Left + 1, R2.Top + I * dY + 1, R2.Right - 1, R2.Top + (I + 1) * dY +
        Byte(not IsDrawHorzLines and (I < DesignerStringCount - 1)));
      if not Transparent then
      begin
        Brush := CreateSolidBrush(ColorToRGB(ReportLink.GetCellColor(0, I)));
        FillRect(DC, R, Brush);
        DeleteObject(Brush);
      end;  
      InflateRect(R, -2, -2);
      Inc(R.Left, CheckWidth + 2);

      FPreviewFont.Assign(ReportLink.GetCellFont(0, I));
      FPreviewFont.Size := 8;
      SelectObject(DC, FPreviewFont.Handle);
      SetTextColor(DC, ColorToRGB(FPreviewFont.Color));
      S := dxCheckListBoxStrings[I];
      Windows.DrawText(DC, PChar(S), Length(S), R, DT_NOPREFIX or DT_SINGLELINE or 
        dxDrawTextTextAlignX[TextAlignX] or dxDrawTextTextAlignY[TextAlignY]);

      R := MakeBounds(R2.Left + 2, R2.Top + I * dY + 1 + (dY - CheckHeight) div 2, CheckWidth, CheckHeight);
      uState := DFCS_TRANSPARENT or ControlStateMap[CheckStateMap[I]] or CheckBorderMap[IsFlatCheckMarks];
      DrawFrameControl(DC, R, DFC_BUTTON, uState);
    end;
    SetTextColor(DC, PrevFontColor);
    SelectObject(DC, PrevFont);
    SetBkMode(DC, PrevBkMode);
  end;
end;

procedure TdxChlbxReportLinkDesignWindow.chbxShowBordersClick(Sender: TObject);
var
  Option: TdxCheckListBoxPaintOption;
begin
  if LockControlsUpdate then Exit;

  Option := TdxCheckListBoxPaintOption(TTagToInt(TCheckBox(Sender).Tag));
  with ReportLink do
    if TCheckBox(Sender).Checked then 
      Options := Options + [Option]
    else  
      Options := Options - [Option];

  Modified := True;
  UpdatePreview;
end;

procedure TdxChlbxReportLinkDesignWindow.chbxAutoWidthClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.AutoWidth := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxChlbxReportLinkDesignWindow.chbxRowAutoHeightClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.RowAutoHeight := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TdxChlbxReportLinkDesignWindow.cbxDrawModeClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with TComboBox(Sender) do
    ReportLink.DrawMode := TdxGridDrawMode(Items.Objects[ItemIndex]);
  Modified := True;
  UpdatePreview;
end;

procedure TdxChlbxReportLinkDesignWindow.cbxDrawModeDrawItem(Control: TWinControl; 
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  dxPSBaseGridLnk.dxPSDrawComboDrawModeItem(Control, Index, Rect, State);
end;

procedure TdxChlbxReportLinkDesignWindow.chbxTransparentClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.Transparent := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview;
end;

procedure TdxChlbxReportLinkDesignWindow.stTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TdxChlbxReportLinkDesignWindow.UpdatePreview;
begin
  FPreviewBox.Invalidate;
end;

procedure TdxChlbxReportLinkDesignWindow.ccbxColorChange(Sender: TObject);
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

procedure TdxChlbxReportLinkDesignWindow.btnFontClick(Sender: TObject);
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

procedure TdxChlbxReportLinkDesignWindow.pbxPreviewPaint(Sender: TObject);
begin
  with TdxPSPaintPanel(Sender) do
    PaintPreview(Canvas, ClientRect);
end;

procedure TdxChlbxReportLinkDesignWindow.lblComboClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TCustomComboBox(ActiveControl).DroppedDown := True;
end;

procedure TdxChlbxReportLinkDesignWindow.PageControl1Change(Sender: TObject);
begin
  lblPreview.Parent := TPageControl(Sender).ActivePage;
end;

procedure RegisterAssistants;
begin
  TdxPSCheckGridCellDataMap.Register;
end;

procedure UnregisterAssistants;
begin
  TdxPSCheckGridCellDataMap.Unregister;
end;

initialization
  RegisterAssistants;
  dxPSRegisterReportLink(TdxCheckListBoxReportLink, TCheckListBox, TdxChlbxReportLinkDesignWindow);

finalization
  dxPSUnregisterReportLink(TdxCheckListBoxReportLink, TCheckListBox, TdxChlbxReportLinkDesignWindow);
  UnregisterAssistants;  

end.

