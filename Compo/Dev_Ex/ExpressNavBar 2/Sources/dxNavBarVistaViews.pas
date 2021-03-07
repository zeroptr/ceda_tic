{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
{                                                                   }
{       Copyright (c) 2002-2009 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
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

unit dxNavBarVistaViews;

{$I cxVer.inc}

interface

uses
  Windows, Graphics, SysUtils, Types, dxNavBar, dxNavBarStyles, dxNavBarCustomPainters, dxNavBarSkinBasedViews,
  dxNavBarExplorerViews, dxNavBarXPViews, dxNavBarOfficeViews, dxNavBarCollns, dxSkinsCore,
  cxGraphics, cxClasses;

type
  TdxNavBarVistaPainterHelper = class(TdxNavBarSkinBasedPainterHelper)
  public
    function NavBarBackground: TdxSkinElement; override;
    function NavBarDragDropItemTarget: TdxSkinElement; override;
    function NavBarGroupButtonCaption: TdxSkinElement; override;
    function NavBarItem: TdxSkinElement; override;
    function NavBarSeparator: TdxSkinElement; override;
  end;

  TdxNavBarVistaExplorerBarViewInfo = class(TdxNavBarExplorerBarViewInfo)
  protected
    function CanSelectLinkByRect: Boolean; override;
    function GetAbsoluteLinksImageEdges: TRect; override;
    function GetGroupBorderOffsets: TRect; override;
    class function GetGroupCaptionImageIndent: Integer; override;
    function GetGroupCaptionHeightAddon: Integer; override;
    function GetGroupEdges: TPoint; override;
    function GetGroupSeparatorWidth: Integer; override;
  public
    procedure AssignDefaultItemHotTrackedStyle; override;
    procedure AssignDefaultItemPressedStyle; override;
  end;

  TdxNavBarVistaExplorerBarSelectionPainter = class(TdxNavBarCustomSelectionPainter)
  protected
    class procedure GetColors(AState: TdxNavBarObjectStates; ABackColor: TColor; out AFillColor,
      ATopLeftOuterColor, ABottomRightOuterColor, ATopLeftInnerColor, ABottomRightInnerColor: TColor); override;
  end;

  TdxNavBarVistaExplorerBarButtonPainter = class(TdxNavBarCustomButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
      AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
      AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
      AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarVistaExplorerBarPainter = class(TdxNavBarSkinBasedExplorerBarPainter)
  protected
    class function GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass; override;
    class function GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass; override;
    class function GetViewInfoClass: TdxNavBarViewInfoClass; override;
    class function GetSkinPainterHelperClass: TdxNavBarSkinBasedPainterHelperClass; override;

    class function ButtonPainterClass: TdxNavBarCustomButtonPainterClass; override;
    class function SelectionPainterClass: TdxNavBarCustomSelectionPainterClass; override;

    function GetDefaultColorSchemeName: TdxSkinName; override;
  public
    procedure DrawBackground; override;
    procedure DrawGroupControlSplitter(AGroupViewInfo: TdxNavBarExplorerBarGroupViewInfo); override;
    procedure DrawItemSelection(ALinkViewInfo: TdxNavBarLinkViewInfo); override;
  end;

  TdxNavBarVistaExplorerBarLinkViewInfo = class(TdxNavBarSkinBasedExplorerBarLinkViewInfo)
  public
    function Font: TFont; override;
    function FontColor: TColor; override;
  end;

  TdxNavBarVistaExplorerBarGroupViewInfo = class(TdxNavBarExplorerBarGroupViewInfo)
  protected
    function GetSplitterSize: Integer; override;
  public
    function CaptionBackColor: TColor; override;
    function CaptionBackColor2: TColor; override;
    function CaptionFont: TFont; override;
    function CaptionFontColor: TColor; override;
  end;

implementation

{$R *.res}

uses
  cxControls, dxOffice11, cxGeometry, dxUxTheme,
  dxNavBarViewsFact, dxNavBarConsts;

{ TdxNavBarVistaPainterHelper }

function TdxNavBarVistaPainterHelper.NavBarBackground: TdxSkinElement;
begin
  if not IsThemeActive then
    Result := nil
  else
    Result := inherited NavBarBackground;
end;

function TdxNavBarVistaPainterHelper.NavBarDragDropItemTarget: TdxSkinElement;
begin
  Result := nil;
end;

function TdxNavBarVistaPainterHelper.NavBarGroupButtonCaption: TdxSkinElement;
begin
  if not IsThemeActive then
    Result := nil
  else
    Result := inherited NavBarGroupButtonCaption;
end;

function TdxNavBarVistaPainterHelper.NavBarItem: TdxSkinElement;
begin
  if not IsThemeActive then
    Result := nil
  else
    Result := inherited NavBarItem;
end;

function TdxNavBarVistaPainterHelper.NavBarSeparator: TdxSkinElement;
begin
  Result := nil;
end;

{ TdxNavBarVistaExplorerBarViewInfo }

procedure TdxNavBarVistaExplorerBarViewInfo.AssignDefaultItemHotTrackedStyle;
begin
  inherited AssignDefaultItemHotTrackedStyle;
  NavBar.DefaultStyles.ItemHotTracked.Font.Style := NavBar.DefaultStyles.ItemHotTracked.Font.Style - [fsUnderline];
end;

procedure TdxNavBarVistaExplorerBarViewInfo.AssignDefaultItemPressedStyle;
begin
  inherited AssignDefaultItemPressedStyle;
  NavBar.DefaultStyles.ItemPressed.Font.Style := NavBar.DefaultStyles.ItemPressed.Font.Style - [fsUnderline];
end;

function TdxNavBarVistaExplorerBarViewInfo.CanSelectLinkByRect: Boolean;
begin
  Result := True;
end;

function TdxNavBarVistaExplorerBarViewInfo.GetAbsoluteLinksImageEdges: TRect;
begin
  Result := cxRect(7, 4, 9, 4);
end;

function TdxNavBarVistaExplorerBarViewInfo.GetGroupBorderOffsets: TRect;
begin
  Result := cxNullRect;
end;

class function TdxNavBarVistaExplorerBarViewInfo.GetGroupCaptionImageIndent: Integer;
begin
  Result := 2;
end;

function TdxNavBarVistaExplorerBarViewInfo.GetGroupCaptionHeightAddon: Integer;
begin
  Result := 9;
end;

function TdxNavBarVistaExplorerBarViewInfo.GetGroupEdges: TPoint;
begin
  if not IsThemeActive then
    Result := cxNullPoint
  else
    Result := cxPoint(1, 1);
end;

function TdxNavBarVistaExplorerBarViewInfo.GetGroupSeparatorWidth: Integer;
begin
  Result := 0;
end;

{ TdxNavBarVistaExplorerBarSelectionPainter }

class procedure TdxNavBarVistaExplorerBarSelectionPainter.GetColors(AState: TdxNavBarObjectStates; ABackColor: TColor; out AFillColor,
  ATopLeftOuterColor, ABottomRightOuterColor, ATopLeftInnerColor, ABottomRightInnerColor: TColor);
begin
  inherited;
  AFillColor := clActiveCaption;
end;

{ TdxNavBarVistaExplorerBarButtonPainter }

class procedure TdxNavBarVistaExplorerBarButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
  AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
  AState: TdxNavBarObjectStates);
begin
  FillRectByColor(ACanvas.Handle, ARect, AColor1);
end;

{ TdxNavBarVistaExplorerBarPainter }

procedure TdxNavBarVistaExplorerBarPainter.DrawBackground;
begin
  inherited DrawBackground;
  DrawSkinElement(FSkinBasedPainterHelper.NavBarBackground, Canvas, NavBar.ClientRect);
end;

procedure TdxNavBarVistaExplorerBarPainter.DrawGroupControlSplitter(AGroupViewInfo: TdxNavBarExplorerBarGroupViewInfo);
var
  ARect: TRect;
begin
  ARect := cxRectSetBottom(AGroupViewInfo.SplitterRect, AGroupViewInfo.SplitterRect.Top + 1, 1);
  FillRectByColor(Canvas.Handle, ARect, clBtnHighlight);
  ARect := cxRectSetBottom(ARect, ARect.Bottom + 2, 2);
  FillRectByColor(Canvas.Handle, ARect, clBtnFace);
  ARect := cxRectSetBottom(ARect, ARect.Bottom + 1, 1);
  FillRectByColor(Canvas.Handle, ARect, clBtnHighlight);
end;

procedure TdxNavBarVistaExplorerBarPainter.DrawItemSelection(
  ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavBarItem, Canvas, ALinkViewInfo.SelectionRect,
    0, NavBarObjectStateToSkinState(ALinkViewInfo.State)) then
    inherited;
end;

class function TdxNavBarVistaExplorerBarPainter.GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass;
begin
  Result := TdxNavBarVistaExplorerBarGroupViewInfo;
end;

class function TdxNavBarVistaExplorerBarPainter.GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass;
begin
  Result := TdxNavBarVistaExplorerBarLinkViewInfo;
end;

class function TdxNavBarVistaExplorerBarPainter.GetViewInfoClass: TdxNavBarViewInfoClass;
begin
  Result := TdxNavBarVistaExplorerBarViewInfo;
end;

class function TdxNavBarVistaExplorerBarPainter.GetSkinPainterHelperClass: TdxNavBarSkinBasedPainterHelperClass;
begin
  Result := TdxNavBarVistaPainterHelper;
end;

class function TdxNavBarVistaExplorerBarPainter.ButtonPainterClass: TdxNavBarCustomButtonPainterClass;
begin
  Result := TdxNavBarVistaExplorerBarButtonPainter;
end;

class function TdxNavBarVistaExplorerBarPainter.SelectionPainterClass: TdxNavBarCustomSelectionPainterClass;
begin
  Result := TdxNavBarVistaExplorerBarSelectionPainter;
end;

function TdxNavBarVistaExplorerBarPainter.GetDefaultColorSchemeName: TdxSkinName;
begin
  Result := 'Vista';
end;

{ TdxNavBarVistaExplorerBarLinkViewInfo }

function TdxNavBarVistaExplorerBarLinkViewInfo.Font: TFont;
begin
  Result := inherited Font;
  Result.name := 'Segoe UI';
end;

function TdxNavBarVistaExplorerBarLinkViewInfo.FontColor: TColor;
const
  ATextColor: array [Boolean] of TColor = (clWindowText, clHighlightText);
begin
  if not IsThemeActive then
    Result := ATextColor[[sSelected, sPressed, sHotTracked] * State <> []]
  else
    Result := inherited FontColor;
end;

{ TdxNavBarVistaExplorerBarGroupViewInfo }

function TdxNavBarVistaExplorerBarGroupViewInfo.CaptionBackColor: TColor;
begin
  if [sSelected, sPressed, sHotTracked] * State <> [] then
    if sPressed in State then
      Result := clHotLight
    else
      Result := clActiveCaption
  else
    Result := clWindow;
end;

function TdxNavBarVistaExplorerBarGroupViewInfo.CaptionBackColor2: TColor;
begin
  Result := CaptionBackColor;
end;

function TdxNavBarVistaExplorerBarGroupViewInfo.CaptionFont: TFont;
begin
  Result := inherited CaptionFont;
  Result.Style := Result.Style - [fsBold];
  Result.Name := 'Segoe UI';
end;

function TdxNavBarVistaExplorerBarGroupViewInfo.CaptionFontColor: TColor;
const
  ATextColor: array [Boolean] of TColor = (clWindowText, clHighlightText);
var
  AElement: TdxSkinElement;
begin
  if not IsThemeActive then
    Result := ATextColor[[sSelected, sPressed, sHotTracked] * State <> []]
  else
    with TdxNavBarVistaExplorerBarPainter(Painter) do
    begin
      AElement := FSkinBasedPainterHelper.NavBarGroupButtonCaption;
      if AElement <> nil then
        Result := AElement.TextColor
      else
        Result := inherited CaptionFontColor;
    end;
end;

function TdxNavBarVistaExplorerBarGroupViewInfo.GetSplitterSize: Integer;
begin
  Result := 4;
end;

procedure RegisterVistaViews;
begin
  RegisterView(dxNavBarVistaExplorerBarView, 'VistaExplorerBarView', TdxNavBarVistaExplorerBarPainter);
end;

procedure UnRegisterVistaViews;
begin
  UnRegisterView(dxNavBarVistaExplorerBarView);
end;

initialization
  RegisterVistaViews;

finalization
  UnRegisterVistaViews;

end.
