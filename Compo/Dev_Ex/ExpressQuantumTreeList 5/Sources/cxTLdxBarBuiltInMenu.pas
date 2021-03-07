
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumTreeList                                       }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMTREELIST AND ALL        }
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

unit cxTLdxBarBuiltInMenu;

{$I cxVer.inc}

interface

uses
  Classes, Graphics, cxGraphics, cxControls, cxTL, dxBar, Contnrs;

type
  TcxTreeListdxBarBuiltInMenu = class(TcxTreeListCustomBuiltInMenu)
  private
    FBarManager: TdxBarManager;
    FItems: TObjectList;
    function GetBarPopup: TdxBarPopupMenu;
  protected
    function CreateMenuItem(AOwner: TComponent; const ACaption: string;
      ACommand: Integer; AEnabled: Boolean = True; AItemType: TcxTreeListBuiltInMenuItemType = tlmitDefault;
      AChecked: Boolean = False; AImageIndex: Integer = -1; AWithSeparator: Boolean = False; AInternal: Boolean = True): TComponent; override;
    procedure CreatePopupMenu; override;
    procedure DestroyPopupMenu; override;
    function GetPopupClass: TComponentClass; override;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    property BarPopup: TdxBarPopupMenu read GetBarPopup;
    property BarManager: TdxBarManager read FBarManager;
  end;

implementation

uses SysUtils;

var
  APreviousBuiltInMenuClass: TcxTreeListCustomBuiltInMenuClass;

{ TcxTreeListdxBarBuiltInMenu }

constructor TcxTreeListdxBarBuiltInMenu.Create(
  AOwner: TPersistent);
begin
  inherited;
  FBarManager := GetBarManagerByComponent(TreeList);
  if BarManager = nil then
  begin
    FBarManager := TdxBarManager.Create(TreeList);
    FBarManager.ImageOptions.StretchGlyphs := False;
    FBarManager.Style := bmsUseLookAndFeel;
  end;
  FItems := TObjectList.Create;
end;

destructor TcxTreeListdxBarBuiltInMenu.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TcxTreeListdxBarBuiltInMenu.CreateMenuItem(AOwner: TComponent;
  const ACaption: string; ACommand: Integer; AEnabled: Boolean; AItemType: TcxTreeListBuiltInMenuItemType;
  AChecked: Boolean; AImageIndex: Integer; AWithSeparator: Boolean; AInternal: Boolean): TComponent;
const
  AItemClass: array [Boolean] of TdxBarItemClass = (TdxBarButton, TdxBarSubItem);
var
  ALinksOwner: IdxBarLinksOwner;
  ALink: TdxBarItemLink;
begin
 if Supports(AOwner, IdxBarLinksOwner, ALinksOwner) and (ALinksOwner.GetItemLinks <> nil) then
  begin
    ALink := ALinksOwner.GetItemLinks.AddItem(AItemClass[AItemType = tlmitSubItem]);
    ALink.BeginGroup := AWithSeparator;
    Result := Alink.Item;
    BarDesignController.AddInternalItem(TdxBarItem(Result), FItems);
    with TdxBarItem(Result) do
    begin
      Enabled := AEnabled;
      Caption := ACaption;
      Tag := ACommand;
      OnClick := MenuItemClickHandler;
      ImageIndex := AImageIndex;
      if AInternal then
        GetBitmapFromImageList(GetImages(AInternal), AImageIndex, Glyph);
    end;
    if AItemType <> tlmitSubItem then
      with TdxBarButton(Result) do
      begin
        if AItemType = tlmitChecked then
          ButtonStyle := bsChecked;
        Down := AChecked;
      end;
  end
  else
    Result := nil;
end;

procedure TcxTreeListdxBarBuiltInMenu.CreatePopupMenu;
begin
  inherited CreatePopupMenu;
  BarManager.Images := GetImages(False);
end;

procedure TcxTreeListdxBarBuiltInMenu.DestroyPopupMenu;
begin
  if FItems <> nil then
    FItems.Clear;
  inherited DestroyPopupMenu;
end;

function TcxTreeListdxBarBuiltInMenu.GetPopupClass: TComponentClass;
begin
  Result := TdxBarPopupMenu;
end;

function TcxTreeListdxBarBuiltInMenu.GetBarPopup: TdxBarPopupMenu;
begin
  Result := TdxBarPopupMenu(PopupMenu);
end;

initialization
  APreviousBuiltInMenuClass := cxTreeListBuiltInMenuClass;
  cxTreeListBuiltInMenuClass := TcxTreeListdxBarBuiltInMenu;

finalization
  cxTreeListBuiltInMenuClass := APreviousBuiltInMenuClass;

end.
