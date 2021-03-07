{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressVerticalGrid                                          }
{                                                                    }
{       Copyright (c) 1998-2009 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSVERTICALGRID AND ALL           }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}
unit cxVGridViewInfo;

{$I cxVer.inc}

interface

uses
  Classes, Graphics,
  Windows, Controls,
  cxGraphics, cxVGrid, cxVGridUtils, cxEdit, cxInplaceContainer, cxStyles;

type
  { TcxCategoryRowHeaderInfo }

  TcxCategoryRowHeaderInfo = class(TcxCustomRowHeaderInfo)
  private
    function GetRow: TcxCategoryRow;
  protected
    procedure AddBottomHorzLine(const R: TRect); override;
    procedure AddRightVertLine(const R: TRect); override;
    procedure CalcRowCaptionsInfo; override;
    procedure CalcViewParams(AAllowFocus: Boolean); override;
    procedure DoCalcExpandButton; override;
    function GetCaptionViewParams: TcxViewParams; override;
    function GetButtonColor: TColor; override;
    function GetFocusRect: TRect; override;
    function IncreaseBoundsByLastVertLine: Boolean; override;
    function LeftViewPoint: Integer; override;
  public
    property Row: TcxCategoryRow read GetRow;
  end;

  { TcxCategoryRowViewInfo }

  TcxCategoryRowViewInfo = class(TcxCustomRowViewInfo)
  private
    function GetRow: TcxCategoryRow;
  protected
    procedure CalcRowHeaderInfo(ANextRow: TcxCustomRow); override;
    procedure CalcValuesInfo; override;
  public
    property Row: TcxCategoryRow read GetRow;
  end;

  { TcxEditorRowHeaderInfo }

  TcxEditorRowHeaderInfo = class(TcxCustomRowHeaderInfo)
  private
    function GetRow: TcxEditorRow;
  public
    property Row: TcxEditorRow read GetRow;
  end;

  { TcxEditorRowViewInfo }

  TcxEditorRowViewInfo = class(TcxCustomRowViewInfo)
  private
    function GetRow: TcxEditorRow;
  protected
    procedure CalcValuesInfo; override;
    function GetValueHeight(ARecordIndex: Integer; AWidth: Integer;
      AViewInfo: TcxvgCustomViewInfo): Integer; override;
  public
    property Row: TcxEditorRow read GetRow;
  end;

  { TcxMultiEditorRowHeaderInfo }

  TcxMultiEditorRowHeaderInfo = class(TcxCustomRowHeaderInfo)
  private
		FSeparatorRects: TcxRectList;
		FSeparatorInfo: TSeparatorInfo;
    function GetRow: TcxMultiEditorRow;
  protected
    procedure CalcRowCaptionsInfo; override;
    procedure CalcSeparatorRects(AHeaderCells: TcxRectList); virtual;
    procedure CalcSeparatorWidth(ASeparatorWidth: Integer); virtual;
    procedure CalcSeparatorStyle; virtual;
    procedure Clear; override;
  public
    constructor Create(ARow: TcxCustomRow); override;
    destructor Destroy; override;
    property Row: TcxMultiEditorRow read GetRow;
		property SeparatorInfo: TSeparatorInfo read FSeparatorInfo;
    property SeparatorRects: TcxRectList read FSeparatorRects;
  end;

  { TcxMultiEditorRowViewInfo }

  TcxMultiEditorRowViewInfo = class(TcxCustomRowViewInfo)
  private
    FSeparatorRects: TcxRectList;
    function GetHeaderInfo: TcxMultiEditorRowHeaderInfo;
    function GetRow: TcxMultiEditorRow;
    function GetSeparatorRects: TcxRectList;
  protected
    procedure AddSeparatorRects(AHeader: Boolean; ASepRects: TcxRectList;
      ASeparatorKind: TSeparatorKind; AValueCells: TcxRectList;
      const ABounds: TRect);
    procedure CalcValuesInfo; override;
    procedure CheckEmptyValuesInfo; virtual;
    function GetValueHeight(ARecordIndex: Integer; AWidth: Integer;
      AViewInfo: TcxvgCustomViewInfo): Integer; override;
  public
    constructor Create(ARow: TcxCustomRow); override;
    destructor Destroy; override;
    class function GetCellRects(ARow: TcxMultiEditorRow; const R: TRect;
      ASepWidth: Integer): TcxRectList;
    property HeaderInfo: TcxMultiEditorRowHeaderInfo read GetHeaderInfo;
    property Row: TcxMultiEditorRow read GetRow;
    property SeparatorRects: TcxRectList read GetSeparatorRects;
  end;

  { TcxInspectorViewInfo }

  TcxInspectorViewInfo = class(TcxvgCustomViewInfo)
  protected
    procedure AddEmptyRects; override;
    procedure CheckMaxRowHeaderWidth(var Value: Integer; AValueMinWidth: Integer); override;
    function GetViewValueWidth: Integer; override;
    function GetVisibleValueCount: Integer; override;
  end;

  { TcxBandsViewInfo }

  TcxBandsViewInfo = class(TcxvgCustomViewInfo)
  private
    FBandsIndent: Integer;
    FAutoScaleBands: Boolean;
    FLock: Boolean;
    procedure UpdateBandsWidth;
  protected
    procedure AddEmptyRects; override;
    procedure CalcBandRects; override;
    procedure CalcBandWidth; override;
    procedure CalcLayoutGeneral; override;
    function CanAddRowToBand(const ARowRect, ABandRect: TRect; ABandRowIndex: Integer): Boolean; override;
    procedure CreateBand(ABandHeight, ABandWidth: Integer); override;
    function GetBandSizeableRect(const ABandRect: TRect): TRect; override;
    function GetMinViewBandWidth: Integer;
    function GetRowAutoHeight(ARow: TcxCustomRow): Boolean; override;
    function GetViewBandWidth: Integer; override;
    function GetViewValueWidth: Integer; override;
    function GetVisibleValueCount: Integer; override;
    procedure LayoutStyleChanged; override;
    procedure SetDividerPos(APos: Integer); override;
    property BandsIndent: Integer read FBandsIndent;
    property AutoScaleBands: Boolean read FAutoScaleBands;
  end;

  { TcxMultiRecordViewInfo }

  TcxMultiRecordViewInfo = class(TcxvgCustomViewInfo)
  private
		FCommonWidth: Integer;
    FRecordsInterval: Integer;
    FVisibleValueCount: Integer;
    function CalcVisibleValueCount: Integer;
    function GetRecordCount: Integer;
  protected
    procedure AddBandRowsLines(const R: TRect); override;
    procedure AddEmptyRects; override;
    procedure AddRightValueSide(const R: TRect; ALast: Boolean); override;
    procedure CalcBandWidth; override;
    procedure CalcLayoutGeneral; override;
    procedure Clear; override;
    function GetBandSizeableRect(const ABandRect: TRect): TRect; override;
    function GetRowHeight(ARowViewInfo: TcxCustomRowViewInfo; ABandWidth: Integer): Integer; override;
    function GetVisibleValueCount: Integer; override;
    procedure Reset; override;
    procedure SetDividerPos(APos: Integer); override;
    property RecordCount: Integer read GetRecordCount;
  public
    constructor Create(AOwner: TcxEditingControl); override;
    function GetDefaultGridModeBufferCount: Integer; override;
    function GetValueRect(AValueIndex: Integer; ARowViewInfo: TcxCustomRowViewInfo): TRect; override;
    procedure UpdateRecord(ARecordIndex: Integer); override;
    property RecordsInterval: Integer read FRecordsInterval;
  end;

implementation

uses
{$IFNDEF DELPHI5}
  cxClasses,
{$ENDIF}
  SysUtils, cxControls, cxGeometry, cxEditUtils;

type
  TcxCustomEditorRowPropertiesAccess = class(TcxCustomEditorRowProperties);
  TcxCustomRowAccess = class(TcxCustomRow);
  TcxCustomRowViewInfoAccess = class(TcxCustomRowViewInfo);
  TcxCustomVerticalGridAccess = class(TcxCustomVerticalGrid);
  TcxCollectionItemEditorRowPropertiesAccess = class(TcxCollectionItemEditorRowProperties);
  TcxRowValueInfoAccess = class(TcxRowValueInfo);
  TcxVerticalGridRowsAccess = class(TcxVerticalGridRows);

{ TcxCategoryRowHeaderInfo }

procedure TcxCategoryRowHeaderInfo.AddBottomHorzLine(const R: TRect);
begin
  with ViewInfo, R do
    if HorzLineWidth > 0 then
      Self.LinesInfo.Add(Left - VertLineWidth, Bottom,
        Right - Left + 2 * VertLineWidth, HorzLineWidth, HorzLineBrush);
end;

procedure TcxCategoryRowHeaderInfo.AddRightVertLine(const R: TRect);
begin
  with ViewInfo, Row.ViewInfo.RowRect do
    if VertLineWidth > 0 then
      Self.LinesInfo.Add(Right, Top, VertLineWidth,
        Bottom - Top + HorzLineWidth, BandBorderColor);
end;

procedure TcxCategoryRowHeaderInfo.CalcRowCaptionsInfo;
begin
  if ViewInfo.UseCategoryExplorerStyle and not cxRectIsEmpty(ButtonRect) then
    FHeaderCellsRect.Right := FButtonRect.Left;
  inherited CalcRowCaptionsInfo;
end;

procedure TcxCategoryRowHeaderInfo.CalcViewParams(AAllowFocus: Boolean);
begin
  FIndentViewParams := VerticalGrid.Styles.GetCategoryParams(Row);
  ViewParams := IndentViewParams;
end;

procedure TcxCategoryRowHeaderInfo.DoCalcExpandButton;
begin
  if Row.HasVisibleChildren then
    if ViewInfo.UseCategoryExplorerStyle then
      with HeaderRect, ViewInfo.ExplorerButtonSize do
        FButtonRect := cxRectCenter(cxRect(Right - cx - 2, Top, Right, Bottom), cx, cy)
    else
      inherited DoCalcExpandButton;
end;

function TcxCategoryRowHeaderInfo.GetCaptionViewParams: TcxViewParams;
begin
  Result := ViewParams;
end;

function TcxCategoryRowHeaderInfo.GetButtonColor: TColor;
begin
  if PaintStyle = psDotNet then
    Result := ViewParams.Color
  else
    Result := inherited GetButtonColor;
end;

function TcxCategoryRowHeaderInfo.GetFocusRect: TRect;
begin
  Result := ViewInfo.CalcHelper.GetCategoryFocusRect(Self);
end;

function TcxCategoryRowHeaderInfo.IncreaseBoundsByLastVertLine: Boolean;
begin
  Result := True;
end;

function TcxCategoryRowHeaderInfo.LeftViewPoint: Integer;
begin
  if PaintStyle = psDotNet then
    Result := IndentBounds.Right
  else
    Result := inherited LeftViewPoint;
end;

function TcxCategoryRowHeaderInfo.GetRow: TcxCategoryRow;
begin
  Result := TcxCategoryRow(FRow);
end;

{ TcxCategoryRowViewInfo }

procedure TcxCategoryRowViewInfo.CalcRowHeaderInfo(ANextRow: TcxCustomRow);
begin
  HeaderInfo.HeaderRect := RowRect;
  with ValuesRect do
    ValuesRect := cxNullRect;
  inherited CalcRowHeaderInfo(ANextRow);
end;

procedure TcxCategoryRowViewInfo.CalcValuesInfo;
begin
end;

function TcxCategoryRowViewInfo.GetRow: TcxCategoryRow;
begin
  Result := TcxCategoryRow(inherited Row);
end;

{ TcxEditorRowHeaderInfo }

function TcxEditorRowHeaderInfo.GetRow: TcxEditorRow;
begin
  Result := TcxEditorRow(FRow);
end;

{ TcxEditorRowViewInfo }

procedure TcxEditorRowViewInfo.CalcValuesInfo;
var
  ABottomLineNeeded: Boolean;
  ANextRow: TcxCustomRow;
  ARowValueInfo: TcxRowValueInfo;
  I, ACount: Integer;
  R: TRect;
begin
  with ViewInfo do
  begin
    ACount := VisibleValueCount;
    for I := 0 to ACount - 1 do
    begin
      R := GetValueRect(I, Self);
      ANextRow := VerticalGrid.NextVisibleRow(Row);
      ABottomLineNeeded := CalcHelper.IsBottomLineNeeded(ANextRow);
      AddRectValueLines(R, (I = ACount - 1) or (R.Right >= ClipRect.Right), ABottomLineNeeded);
      ARowValueInfo := CalcRowValueInfo(Row.Properties, ViewInfo, FirstVisibleRecordIndex + I, 0);
      CalcEditCell(R, ARowValueInfo);
    end;
  end;
  ValuesInfo.Trunc(ACount);
end;

function TcxEditorRowViewInfo.GetValueHeight(ARecordIndex: Integer;
  AWidth: Integer; AViewInfo: TcxvgCustomViewInfo): Integer;
var
  ARowValueInfo: TcxRowValueInfoAccess;
begin
  with AViewInfo do
  begin
    ARowValueInfo := TcxRowValueInfoAccess(
      CalcRowValueInfo(Row.Properties, AViewInfo, ARecordIndex, 0));
    ARowValueInfo.CellContentRect := cxRectBounds(0, 0, AWidth, 0);
    Result := ARowValueInfo.CalculateEditHeight;
    ValuesInfo.Trunc(VisibleValueCount);
  end;
end;

function TcxEditorRowViewInfo.GetRow: TcxEditorRow;
begin
  Result := TcxEditorRow(inherited Row);
end;

{ TcxMultiEditorRowHeaderInfo }

constructor TcxMultiEditorRowHeaderInfo.Create(ARow: TcxCustomRow);
begin
  inherited Create(ARow);
  FSeparatorRects := TcxRectList.Create;
end;

destructor TcxMultiEditorRowHeaderInfo.Destroy;
begin
  FSeparatorRects.Free;
  inherited Destroy;
end;

procedure TcxMultiEditorRowHeaderInfo.CalcRowCaptionsInfo;
var
  I: Integer;
  R: TRect;
  ARects: TcxRectList;
  ACaptionInfo: TcxRowCaptionInfo;
begin
  CalcSeparatorWidth(ViewInfo.DividerWidth);
  CalcSeparatorStyle;
  ARects := TcxMultiEditorRowViewInfo.GetCellRects(Row, HeaderCellsRect, FSeparatorInfo.Width);
  if ARects <> nil then
  try
    for I := 0 to ARects.Count - 1 do
    begin
      R := ARects[I];
      if R.Left < HeaderCellsRect.Right then
      begin
        ACaptionInfo := CalcCaptionInfo(Row.Properties.Editors[I], R);
        ACaptionInfo.RowCellIndex := I;
        CaptionsInfo.Add(ACaptionInfo);
      end;
    end;
		CalcSeparatorRects(ARects);
  finally
    ARects.Free;
  end;
end;

procedure TcxMultiEditorRowHeaderInfo.CalcSeparatorRects(
  AHeaderCells: TcxRectList);
begin
  TcxMultiEditorRowViewInfo(Row.ViewInfo).AddSeparatorRects(
    True, SeparatorRects, SeparatorInfo.Kind, AHeaderCells, HeaderCellsRect);
end;

procedure TcxMultiEditorRowHeaderInfo.CalcSeparatorWidth(
  ASeparatorWidth: Integer);
begin
  with FSeparatorInfo do
  begin
    Kind := Row.Properties.SeparatorKind;
    Caption := Row.Properties.SeparatorString;
    if Kind = skVertLine then
      Width := ASeparatorWidth
    else
      Width := cxTextWidth(Self.ViewParams.Font, SeparatorInfo.Caption + '0');
  end;
end;

procedure TcxMultiEditorRowHeaderInfo.CalcSeparatorStyle;
begin
  FSeparatorInfo.ViewParams := ViewParams;
  with Row.Properties do
    FSeparatorInfo.TextFlags := GetTextAligmentFlags(taCenter, SeparatorAlignmentVert);
end;

procedure TcxMultiEditorRowHeaderInfo.Clear;
begin
  inherited Clear;
  FSeparatorRects.Clear;
end;

function TcxMultiEditorRowHeaderInfo.GetRow: TcxMultiEditorRow;
begin
  Result := TcxMultiEditorRow(FRow);
end;

{ TcxMultiEditorRowViewInfo }

constructor TcxMultiEditorRowViewInfo.Create(ARow: TcxCustomRow);
begin
  inherited Create(ARow);
  FSeparatorRects := TcxRectList.Create;
end;

destructor TcxMultiEditorRowViewInfo.Destroy;
begin
  FreeAndNil(FSeparatorRects);
  inherited Destroy;
end;

class function TcxMultiEditorRowViewInfo.GetCellRects(ARow: TcxMultiEditorRow;
  const R: TRect; ASepWidth: Integer): TcxRectList;
var
  I, ACount, AMinWidth: Integer;
begin
  Result := nil;
  AMinWidth := ARow.VerticalGrid.OptionsView.RowHeaderMinWidth;
  ACount := ARow.Properties.Editors.Count;
  with TRectScaler.Create do
  try
    for I := 0 to ACount - 1 do
      Add(ARow.Properties.Editors[I].Width, AMinWidth,
        cxSetValue(I = ACount - 1, 0, ASepWidth));
    if ARow.Properties.Fixed then CalcRect(R) else ScaleRect(R);
    if ScaledRects.Count > 0 then
    begin
      Result := TcxRectList.Create;
      Result.Assign(ScaledRects);
    end;
  finally
    Free;
  end;
end;

procedure TcxMultiEditorRowViewInfo.AddSeparatorRects(
  AHeader: Boolean;
  ASepRects: TcxRectList;
  ASeparatorKind: TSeparatorKind;
  AValueCells: TcxRectList;
  const ABounds: TRect);
var
  I: Integer;
  R: TRect;
begin
  for I := 0 to AValueCells.Count - 2 do
    with AValueCells[I] do
      if ASeparatorKind = skString then
      begin
        R := cxRect(Right, Top, AValueCells[I + 1].Left, Bottom);
        if cxRectIntersect(R, R, ABounds) then ASepRects.Add(R)
      end
      else
      begin
        R := cxRect(Right - ViewInfo.DividerWidth, Top, Right, Bottom);
        if cxRectIntersect(R, R, ABounds) then
          if AHeader then
            ViewInfo.CalcHelper.AddDivider(HeaderInfo.LinesInfo, R,
              HeaderInfo.ViewParams.Color, True)
          else
          begin
            if VerticalGrid.NextVisibleRow(Row) = nil then
              Dec(R.Bottom);
            ViewInfo.CalcHelper.AddDivider(ViewInfo.LinesInfo, R,
              HeaderInfo.ViewParams.Color, True);
          end;
      end;
end;

procedure TcxMultiEditorRowViewInfo.CalcValuesInfo;
var
  I, J, ASepWidth, ACount, AValuesCount: Integer;
  ABottomLineNeeded: Boolean;
  ANextRow: TcxCustomRow;
  ARects: TcxRectList;
  ARowValueInfo: TcxRowValueInfo;
  ASepKind: TSeparatorKind;
  AValueRect, R: TRect;
begin
  ACount := 0;
  SeparatorRects.Clear;
  with HeaderInfo.SeparatorInfo do
  begin
    ASepWidth := Width;
    ASepKind := Kind;
  end;
  with ViewInfo do
  begin
    AValuesCount := VisibleValueCount;
    for I := 0 to AValuesCount - 1 do
    begin
      AValueRect := GetValueRect(I, Self);
      ARects := GetCellRects(Row, AValueRect, ASepWidth);
      ANextRow := VerticalGrid.NextVisibleRow(Row);
      ABottomLineNeeded := ANextRow <> nil;
      if ARects <> nil then
      begin
        ACount := Min(ARects.Count, TcxCustomRowAccess(Row).GetEditContainerCount);
        try
          for J := 0 to ACount - 1 do
          begin
            R := ARects[J];
            if not cxRectIsEmpty(R) then
            begin
              ARowValueInfo := CalcRowValueInfo(Row.Properties.Editors[J],
                ViewInfo, FirstVisibleRecordIndex + I, J);
              CalcEditCell(R, ARowValueInfo);
            end;
          end;
          AddSeparatorRects(False, SeparatorRects, ASepKind, ARects, AValueRect);
        finally
          ARects.Free;
        end;
      end;
      AddRectValueLines(AValueRect, I = AValuesCount - 1, ABottomLineNeeded);
    end;
    ValuesInfo.Trunc(AValuesCount * ACount);
  end;
  CheckEmptyValuesInfo;
end;

procedure TcxMultiEditorRowViewInfo.CheckEmptyValuesInfo;
begin
  if (Row.Properties.Editors.Count = 0) and (cxRectWidth(ValuesRect) > 0) then
  begin
    HeaderInfo.LinesInfo.Add(RowRect, HeaderInfo.ViewParams.Color);
    AddRectValueLines(ValuesRect, True, True);
  end;
end;

function TcxMultiEditorRowViewInfo.GetValueHeight(ARecordIndex: Integer;
  AWidth: Integer; AViewInfo: TcxvgCustomViewInfo): Integer;
var
  I, J, ASepWidth, ACount, AValuesCount: Integer;
  AValueRect, R: TRect;
  ARects: TcxRectList;
  ARowValueInfo: TcxRowValueInfoAccess;
begin
  Result := -1;
  ACount := 0;
  ASepWidth := HeaderInfo.SeparatorInfo.Width;
  with AViewInfo do
  begin
    AValuesCount := VisibleValueCount;
    for I := 0 to AValuesCount - 1 do
    begin
      AValueRect := GetValueRect(I, Self);
      ARects := GetCellRects(Row, AValueRect, ASepWidth);
      if ARects <> nil then
      begin
        ACount := Min(ARects.Count, TcxCustomRowAccess(Row).GetEditContainerCount);
        try
          for J := 0 to ACount - 1 do
          begin
            R := ARects[J];
            if not cxRectIsEmpty(R) then
            begin
              ARowValueInfo := TcxRowValueInfoAccess(CalcRowValueInfo(
                Row.Properties.Editors[J], AViewInfo, FirstVisibleRecordIndex + I, J));
              ARowValueInfo.CellContentRect := cxRectBounds(0, 0, R.Right - R.Left, 0);
              Result := Max(Result, ARowValueInfo.CalculateEditHeight);
            end;
          end;
        finally
          ARects.Free;
        end;
      end;
    end;
    ValuesInfo.Trunc(AValuesCount * ACount);
  end;
end;

function TcxMultiEditorRowViewInfo.GetHeaderInfo: TcxMultiEditorRowHeaderInfo;
begin
  Result := TcxMultiEditorRowHeaderInfo(inherited HeaderInfo);
end;

function TcxMultiEditorRowViewInfo.GetRow: TcxMultiEditorRow;
begin
  Result := TcxMultiEditorRow(inherited Row);
end;

function TcxMultiEditorRowViewInfo.GetSeparatorRects: TcxRectList;
begin
  Result := FSeparatorRects;
end;

{ TcxInspectorViewInfo }

procedure TcxInspectorViewInfo.AddEmptyRects;
begin
end;

procedure TcxInspectorViewInfo.CheckMaxRowHeaderWidth(var Value: Integer;
  AValueMinWidth: Integer);
begin
  if ViewBandWidth > 0 then
    Value := Min(Value, ViewBandWidth - Max(AValueMinWidth, 4));
end;

function TcxInspectorViewInfo.GetViewValueWidth: Integer;
begin
  Result := ViewBandWidth - ViewHeaderWidth - DividerWidth - 2 * VertLineWidth;
end;

function TcxInspectorViewInfo.GetVisibleValueCount: Integer;
begin
  Result := 1;
end;

{ TcxBandsViewInfo }

procedure TcxBandsViewInfo.AddEmptyRects;
var
  I, AHeight: Integer;
  ABand: TRect;
begin
  AHeight := ClientRect.Bottom - ClientRect.Top;
  with ABand, ViewRects do
  begin
    if BandsIndent > 0 then
      for I := 0 to BandRects.Count - 2 do
      begin
        ABand := BandRects[I];
        EmptyRects.Add(cxRectBounds(Right, Top, BandsIndent, AHeight));
      end;
    // check last band
    ABand := BandRects[BandRects.Count - 1];
    if Right < ClientRect.Right then
      //suppose non-autoWidth mode
      EmptyRects.Add(cxRectBounds(Right, Top, ClientRect.Right - Right, AHeight));
  end;
end;

procedure TcxBandsViewInfo.CalcBandRects;
var
  I: Integer;
begin
  with Scroller do
    for I := LeftVisibleBand to BandsInfo.Count - 1 do
      CreateBand(BandsInfo[I].BandHeight, 40);
  UpdateBandsWidth;
end;

procedure TcxBandsViewInfo.CalcBandWidth;
var
  ABandIndentWidth, ASaveWidth, ABandCount: Integer;
  APos: Double;
begin
  ViewHeaderWidth := GetViewHeaderWidth;
  if not AutoScaleBands then
  begin
    ViewValueWidth := GetViewValueWidth;
    ViewBandWidth := GetViewBandWidth;
  end
  else
  begin
    if LockDividerPos then Exit;
    ASaveWidth := GetViewBandWidth;
    if ShowHeaders and (ASaveWidth > 0) then
      APos := Max(GetViewBandWidth, VerticalGrid.OptionsView.ValueMinWidth ) / Max(ViewHeaderWidth, 1)
    else
      APos := 1;
    ABandCount := Scroller.BandsInfo.Count;
    ABandIndentWidth := cxSetValue(ABandCount > 1, (ABandCount - 1) * BandsIndent, 0);
    ViewBandWidth := Max(GetMinViewBandWidth,
      (cxRectWidth(ClientRect) - ABandIndentWidth) div Max(ABandCount, 1));
    if ViewBandWidth < BandMinWidth then
      ViewBandWidth := BandMinWidth;
    if ShowHeaders and not FLock and (ASaveWidth > ViewHeaderWidth) and
      (ASaveWidth <> ViewBandWidth) then
        SetDividerPos(Round(ViewBandWidth / APos));
    ViewHeaderWidth := GetViewHeaderWidth;
  end;
end;

procedure TcxBandsViewInfo.CalcLayoutGeneral;
begin
  FAutoScaleBands := VerticalGrid.OptionsView.AutoScaleBands;
  inherited CalcLayoutGeneral;
  FBandsIndent := VerticalGrid.OptionsView.BandsInterval;
end;

function TcxBandsViewInfo.CanAddRowToBand(const ARowRect, ABandRect: TRect;
  ABandRowIndex: Integer): Boolean;
begin
  Result := (ARowRect.Bottom <= ABandRect.Bottom) or (ABandRowIndex = 0);
end;

procedure TcxBandsViewInfo.CreateBand(ABandHeight, ABandWidth: Integer);
var
  ABandIndex, ALeft: Integer;
  R: TRect;
begin
  ABandIndex := ViewRects.BandRects.Count;
  if ABandIndex = 0 then
    ALeft := ClientRect.Left
  else
    ALeft := ViewRects.BandRects[ABandIndex - 1].Right;
  R := cxRectBounds(ALeft, ClientRect.Top, ABandWidth,
    Min(ABandHeight, cxRectHeight(ClientRect)));
  ViewRects.BandRects.Add(R);
  if R.Bottom < ClientRect.Bottom then
    ViewRects.EmptyRects.Add(cxRectBounds(R.Left, R.Bottom, ABandIndex,
      cxRectHeight(ClientRect) - cxRectHeight(R)));
end;

function TcxBandsViewInfo.GetBandSizeableRect(const ABandRect: TRect): TRect;
begin
  if VerticalGrid.OptionsView.AutoScaleBands then
    Result := cxNullRect
  else
    Result := inherited GetBandSizeableRect(ABandRect);
end;

function TcxBandsViewInfo.GetMinViewBandWidth: Integer;
begin
  Result := GetViewMinHeaderWidth + VerticalGrid.OptionsView.ValueMinWidth
end;

function TcxBandsViewInfo.GetRowAutoHeight(ARow: TcxCustomRow): Boolean;
begin
  with VerticalGrid.OptionsView do
    Result := CellAutoHeight and not FAutoScaleBands and
      ARow.Options.CanAutoHeight;
end;

function TcxBandsViewInfo.GetViewBandWidth: Integer;
begin
  if not AutoScaleBands then
    Result := ViewHeaderWidth + DividerWidth + ViewValueWidth + 2
  else
    Result := Max(ViewBandWidth, GetMinViewBandWidth);
end;

function TcxBandsViewInfo.GetViewValueWidth: Integer;
begin
  Result := VerticalGrid.OptionsView.ValueWidth
end;

function TcxBandsViewInfo.GetVisibleValueCount: Integer;
begin
  Result := 1;
end;

procedure TcxBandsViewInfo.LayoutStyleChanged;
begin
  if AutoScaleBands then
  begin
    ViewHeaderWidth := Max(VerticalGrid.OptionsView.RowHeaderWidth, GetViewMinHeaderWidth);
    SetDividerPos(ViewHeaderWidth);
    ViewBandWidth := GetMinViewBandWidth;
  end;
  inherited LayoutStyleChanged;
end;

procedure TcxBandsViewInfo.SetDividerPos(APos: Integer);
begin
  FLock := True;
  try
    if AutoScaleBands then
      inherited SetDividerPos(APos)
    else
    begin
      if APos > ClipRect.Right - 4 then APos := ClipRect.Right - 4;
      VerticalGrid.OptionsView.RowHeaderWidth := APos;
    end;
  finally
    FLock := False;
  end;
end;

procedure TcxBandsViewInfo.UpdateBandsWidth;
var
  I, ACurLeft: Integer;
  R, B: TRect;
begin
  ACurLeft := ClientRect.Left;
  with ViewRects do
  begin
    for I := 0 to BandRects.Count - 1 do
    begin
      R := BandRects[I];
      R.Left := ACurLeft;
      R.Right := R.Left + ViewBandWidth;
      Inc(ACurLeft, ViewBandWidth + BandsIndent);
      if AutoScaleBands then
      begin
        if I = BandRects.Count - 1 then
        begin
          Dec(ACurLeft, BandsIndent);
          Inc(R.Right, ClientRect.Right - ACurLeft);
        end;
      end;
      BandRects[I] := R;
    end;
    for I := 0 to EmptyRects.Count - 1 do
    begin
      R := EmptyRects[I];
      B := BandRects[R.Right - R.Left];
      R.Left := B.Left;
      R.Right := B.Right;
      EmptyRects[I] := R;
    end;
  end;
end;

{ TcxMultiRecordViewInfo }

constructor TcxMultiRecordViewInfo.Create(AOwner: TcxEditingControl);
begin
  inherited Create(AOwner);
  FVisibleValueCount := -1;
end;

function TcxMultiRecordViewInfo.GetDefaultGridModeBufferCount: Integer;
var
  W: Integer;
begin
  W := cxRectWidth(ClientRect) - ViewHeaderWidth - DividerWidth - VertLineWidth;
  if W <= 0 then
  begin
    Result := 1;
    Exit;
  end;
  Result := W div (ViewValueWidth + RecordsInterval);
  if Result * (ViewValueWidth + RecordsInterval) < W then Inc(Result);
end;

function TcxMultiRecordViewInfo.GetValueRect(AValueIndex: Integer;
  ARowViewInfo: TcxCustomRowViewInfo): TRect;
var
  ALeft: Integer;
begin
  with ARowViewInfo.RowRect do
  begin
    ALeft := Left + ViewHeaderWidth + DividerWidth +
      AValueIndex * (ViewValueWidth + cxSetValue(RecordsInterval = 0, VertLineWidth,
      RecordsInterval + 2 * VertLineWidth));
    Result := cxRectBounds(ALeft, Top, ViewValueWidth, Bottom - Top);
  end;
end;

procedure TcxMultiRecordViewInfo.UpdateRecord(ARecordIndex: Integer);
var
  I: Integer;
begin
  if ARecordIndex < 0 then Exit;
  for I := 0 to RowsViewInfo.Count - 1 do
    RowsViewInfo[I].UpdateRecord(ARecordIndex);
end;

procedure TcxMultiRecordViewInfo.AddBandRowsLines(const R: TRect);
var
  ASize: TSize;
  ABandRect: TRect;
  I, ALeft, ATop, AHeight: Integer;
  ARowInfo: TcxCustomRowViewInfo;

  procedure AddRecordInterval(ALast: Boolean);
  var
    I: Integer;
    R: TRect;
  begin
    if AHeight > 0 then
      for I := 0 to VisibleValueCount - 2 do
      begin
        if (HorzLineWidth > 0) and not ALast then
          LinesInfo.Add(ALeft, ATop + AHeight, RecordsInterval, HorzLineWidth,
            BandBorderColor);
        R := cxRectBounds(ALeft, ATop, RecordsInterval, AHeight);
        if ALast then Inc(R.Bottom, HorzLineWidth);
        ViewRects.EmptyRects.Add(R);
        if VertLineWidth > 0 then
          LinesInfo.Add(R.Right, R.Top, VertLineWidth, AHeight + HorzLineWidth,
            BandBorderColor);
        Inc(ALeft, ViewValueWidth + RecordsInterval + 2 * VertLineWidth);
      end;
  end;

begin
  if RecordsInterval = 0 then
  begin
    inherited AddBandRowsLines(R);
    Exit;
  end;
  ABandRect := R;
  if RecordsInterval > 0 then
  begin
    ALeft := ABandRect.Left + FCommonWidth;
    ATop := ClientRect.Top;
    AHeight := 0;
    for I := 0 to RowsViewInfo.Count - 1 do
    begin
      ARowInfo := RowsViewInfo[I];
      if not (ARowInfo is TcxCategoryRowViewInfo) then
        Inc(AHeight, cxRectHeight(ARowInfo.RowRect) + HorzLineWidth)
      else
      begin
        AddRecordInterval(False);
        AHeight := 0;
        ATop := ARowInfo.RowRect.Bottom;
        ALeft := ABandRect.Left + 2 * VertLineWidth + DividerWidth +
          ViewHeaderWidth + ViewValueWidth;
      end;
    end;
    AddRecordInterval(True);
  end;
  if (VertLineWidth > 0) then
    with R do
      LinesInfo.Add(Left, Top - HorzLineWidth, VertLineWidth, Bottom - Top,
        BandBorderColor);
  ALeft := R.Left;
  ATop  := R.Top;
  ASize := cxSize(FCommonWidth, R.Bottom - R.Top);
  while ALeft < R.Right do
  begin
    if ALeft + ASize.cx > R.Right then ASize.cx := R.Right - ALeft;
    with cxRectBounds(ALeft, ATop, ASize.cx, ASize.cy) do
    begin
      if HorzLineWidth > 0 then
      begin
        LinesInfo.Add(Left, Top, Right - Left, HorzLineWidth, BandBorderColor);
        LinesInfo.Add(Left, Bottom - HorzLineWidth, Right - Left, HorzLineWidth, BandBorderColor);
      end;
    end;
    Inc(ALeft, RecordsInterval + ASize.cx);
    ASize.cx := 2 * VertLineWidth + ViewValueWidth;
  end;
end;

procedure TcxMultiRecordViewInfo.AddEmptyRects;
var
  ABandRect: TRect;
begin
  ABandRect := ViewRects.BandRects[0];
//  Inc(ABandRect.Bottom, HorzLineWidth * 2); ?
  if ABandRect.Right < ClientRect.Right then
    ViewRects.EmptyRects.Add(cxRect(ABandRect.Right, ABandRect.Top,
      ClientRect.Right, ClientRect.Bottom));
end;

procedure TcxMultiRecordViewInfo.AddRightValueSide(const R: TRect;
  ALast: Boolean);
begin
  inherited AddRightValueSide(R, ALast or (FRecordsInterval > 0));
end;

procedure TcxMultiRecordViewInfo.CalcBandWidth;
var
  AWidth: Integer;     
begin
  ViewHeaderWidth := GetViewHeaderWidth;
  ViewValueWidth := VerticalGrid.OptionsView.ValueWidth;
  AWidth := ViewHeaderWidth + 2 * VertLineWidth + DividerWidth + ViewValueWidth;
  FCommonWidth := AWidth;
  if RecordCount > 1 then
    Inc(AWidth, (RecordCount - Scroller.LeftVisibleRecord - 1) *
      (ViewValueWidth + cxSetValue(RecordsInterval = 0, VertLineWidth,
       RecordsInterval + 2 * VertLineWidth)));
  ViewBandWidth := Min(AWidth, cxRectWidth(ClientRect));
end;

procedure TcxMultiRecordViewInfo.CalcLayoutGeneral;
begin
  FRecordsInterval :=
    TcxvgMultiRecordsOptionsView(VerticalGrid.OptionsView).RecordsInterval;
  inherited CalcLayoutGeneral;
end;

procedure TcxMultiRecordViewInfo.Clear;
begin
  inherited Clear;
  FVisibleValueCount := -1;
  FCommonWidth := 0
end;

function TcxMultiRecordViewInfo.GetBandSizeableRect(
  const ABandRect: TRect): TRect;
var
  ALeft: Integer;
begin
  if TcxVirtualVerticalGrid(VerticalGrid).LayoutStyle <> lsMultiRecordView then
    Result := inherited GetBandSizeableRect(ABandRect)
  else
    with ClientRect do
    begin
      ALeft := ABandRect.Left + ViewHeaderWidth + DividerWidth + ViewValueWidth + VertLineWidth;
      Result := cxRect(ALeft - 1, Top, ALeft + 2, Bottom);
    end;
end;

function TcxMultiRecordViewInfo.GetRowHeight(
  ARowViewInfo: TcxCustomRowViewInfo; ABandWidth: Integer): Integer;
var
  I, ACount: Integer;
begin
  Result := TcxCustomRowAccess(ARowViewInfo.Row).GetRealHeight;
  if GetRowAutoHeight(ARowViewInfo.Row) and (ARowViewInfo.Row.Height < 0) then
  begin
    ACount := VisibleValueCount;
    for I := 0 to ACount - 1 do
      Result := Max(TcxCustomRowViewInfoAccess(ARowViewInfo).GetValueHeight(
        FirstVisibleRecordIndex + I, ViewValueWidth, Self), Result);
  end;
end;

function TcxMultiRecordViewInfo.GetVisibleValueCount: Integer;
begin
  if FVisibleValueCount = -1 then
    FVisibleValueCount := CalcVisibleValueCount;
  Result := FVisibleValueCount;
end;

procedure TcxMultiRecordViewInfo.Reset;
begin
  inherited Reset;
  FVisibleValueCount := -1;
end;

procedure TcxMultiRecordViewInfo.SetDividerPos(APos: Integer);
begin
  if APos > ClipRect.Right - 4 then APos := ClipRect.Right - 4;
  VerticalGrid.OptionsView.RowHeaderWidth := APos;
end;

function TcxMultiRecordViewInfo.CalcVisibleValueCount: Integer;
begin
  Result := 0;
  if cxRectIsEmpty(ClientRect) then Exit;
  Result := Max(1, Min(GetDefaultGridModeBufferCount,
    RecordCount - Scroller.LeftVisibleRecord));
end;

function TcxMultiRecordViewInfo.GetRecordCount: Integer;
begin
  Result := TcxCustomVerticalGridAccess(VerticalGrid).RecordCount;
end;

end.
