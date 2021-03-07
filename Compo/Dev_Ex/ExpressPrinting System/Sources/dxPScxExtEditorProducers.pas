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

unit dxPScxExtEditorProducers;

interface

{$I cxVer.inc}

uses
  Classes, Controls, Windows, Graphics, cxFontNameComboBox, cxColorComboBox, 
  cxCheckComboBox, {$IFDEF REGISTERCXSHELLCTRLS} cxShellComboBox, {$ENDIF}
  cxSpinButton, {$IFDEF DXVER500} cxCheckGroup, cxRichEdit, {$ENDIF} 
  cxLookAndFeelPainters, dxPSContainerLnk, dxPScxExtCommon, dxPScxEditorProducers,
  dxPSCore;
  
type
  TdxPScxCustomColorComboBoxProducer = class(TdxPScxCustomTextEditProducer)
  protected
    procedure InitializeItem(AnItem: TdxReportVisualItem); override;
    function ItemClass: TdxReportVisualItemClass; override;
  public
    function Control: TcxCustomColorComboBox; reintroduce; overload;
    class function ControlClass: TControlClass; override;
    function Properties: TcxCustomColorComboBoxProperties; reintroduce; overload;
  end;
  
 {$IFDEF REGISTERCXSHELLCTRLS} 

  TdxPScxCustomShellComboBoxProducer = class(TdxPScxCustomTextEditProducer)
  protected
    procedure GetImageLists(AProc: TdxPSGetImageListProc); override;
    procedure InitializeItem(AnItem: TdxReportVisualItem); override;
    function ItemClass: TdxReportVisualItemClass; override;
  public
    function Control: TcxCustomShellComboBox; reintroduce; overload;
    class function ControlClass: TControlClass; override;
    function Properties: TcxCustomShellComboBoxProperties; reintroduce; overload;
  end;
  
 {$ENDIF}
  
  TdxPScxCustomFontNameComboBoxProducer = class(TdxPScxCustomComboBoxProducer)
  protected
    function GetFontName: string; override;
    procedure GetImageLists(AProc: TdxPSGetImageListProc); override;
    procedure InitializeItem(AnItem: TdxReportVisualItem); override;
    function IsFontSubstitutable: Boolean; override;
    function ItemClass: TdxReportVisualItemClass; override;
  public
    function Control: TcxCustomFontNameComboBox; reintroduce; overload;
    class function ControlClass: TControlClass; override;
    function Properties: TcxCustomFontNameComboBoxProperties; reintroduce; overload;
  end;
  
  TdxPScxCustomCheckComboBoxProducer = class(TdxPScxCustomComboBoxProducer)
  public
    function Control: TcxCustomCheckComboBox; reintroduce; overload;
    class function ControlClass: TControlClass; override;
    function Properties: TcxCustomCheckComboBoxProperties; reintroduce; overload;
  end;
  
  TdxPScxCustomSpinButtonAsMetafileProducer = class(TdxPSWinControlAsMetafileProducer)
  protected
    class function BuddyClass: TdxPSCustomProducerClass; override;
  end;
  
  TdxPScxCustomSpinButtonProducer = class(TdxPScxCustomTextEditProducer)
  public
    function Control: TcxCustomSpinButton; reintroduce; overload;
    class function ControlClass: TControlClass; override;
  end;

 {$IFDEF DXVER500}
      
  TdxPScxCustomCheckGroupProducer = class(TdxPScxCustomButtonGroupProducer)
  protected
    function CanProcessChild(AChildControl: TControl): Boolean; override;
    procedure InitializeButton(AGroup: TdxCustomReportButtonGroup; 
      AButton: TdxCustomReportCellCheck; AnIndex: Integer); override;
    procedure InitializeItem(AnItem: TdxReportVisualItem); override;
    function ItemClass: TdxReportVisualItemClass; override;
  public
    function Control: TcxCustomCheckGroup; reintroduce; overload;
    class function ControlClass: TControlClass; override;
    function Properties: TcxCustomCheckGroupProperties; reintroduce; overload;
  end;

  TdxPScxCustomRichEditProducer = class(TdxPScxContainerProducer)
  protected
    function CreateImage: TGraphic; virtual;
    procedure InitializeItem(AnItem: TdxReportVisualItem); override;
    function ItemClass: TdxReportVisualItemClass; override;
    function ObjectExpandHeight: Boolean; override;
  public
    function Control: TcxCustomRichEdit; reintroduce; overload;
    class function ControlClass: TControlClass; override;

    function ProducingObjectFriendlyName: string; override;
  end;                          
  
 {$ENDIF}
        
implementation

uses
  ImgList, SysUtils, dxPSGlbl, dxPSUtl, dxPScxCheckListBoxLnk, {dxPScxImgLnk,}
 {$IFDEF REGISTERCXSHELLCTRLS} dxPScxExtComCtrlsLnk, {$ENDIF} dxPScxMCListBoxLnk,
 {$IFDEF DXVER500} cxCheckBox, {$ENDIF} dxPSRELnk;
  
type
  TdxCustomReportCellCheckAccess = class(TdxCustomReportCellCheck);
  
  TcxCustomColorComboBoxAccess = class(TcxCustomColorComboBox);
  TcxCustomFontNameComboBoxAccess = class(TcxCustomFontNameComboBox);
 {$IFDEF DXVER500}
  TcxCustomCheckGroupPropertiesAccess = class(TcxCustomCheckGroupProperties);
  TcxCustomRichEditAccess = class(TcxCustomRichEdit);
 {$ENDIF} 
  TcxCustomColorComboBoxPropertiesAccess = class(TcxCustomColorComboBoxProperties);
  TcxCustomFontNameComboBoxPropertiesAccess = class(TcxCustomFontNameComboBoxProperties);
 {$IFDEF REGISTERCXSHELLCTRLS} 
  TcxCustomShellComboBoxPropertiesAccess = class(TcxCustomShellComboBoxProperties);
 {$ENDIF}

{ TdxPScxColorComboBoxProducer }

function TdxPScxCustomColorComboBoxProducer.Control: TcxCustomColorComboBox;
begin
  Result := inherited Control as TcxCustomColorComboBox;
end;

class function TdxPScxCustomColorComboBoxProducer.ControlClass: TControlClass;
begin
  Result := TcxCustomColorComboBox;
end;

function TdxPScxCustomColorComboBoxProducer.Properties: TcxCustomColorComboBoxProperties;
begin
  Result := inherited Properties as TcxCustomColorComboBoxProperties;
end;

procedure TdxPScxCustomColorComboBoxProducer.InitializeItem(AnItem: TdxReportVisualItem);
begin
  inherited;
  with TcxCustomColorComboBoxPropertiesAccess(Properties) do 
  begin
    TdxReportCellColorBox(AnItem).ColorBoxAlignment := ColorBoxAlignmentMap[ColorBoxAlign];
    TdxReportCellColorBox(AnItem).ColorBoxFrameColor := ColorBoxFrameColor;
    TdxReportCellColorBox(AnItem).ColorBoxWidth := ColorBoxWidth;
    TdxReportCellColorBox(AnItem).ColorValue := TcxCustomColorComboBoxAccess(Control).ColorValue;
    TdxReportCellColorBox(AnItem).EndEllipsis := False;
    TdxReportCellColorBox(AnItem).ShowDescription := ShowDescriptions;
  end;  
end;

function TdxPScxCustomColorComboBoxProducer.ItemClass: TdxReportVisualItemClass;
begin
  Result := TdxReportCellColorBox;
end;

{$IFDEF REGISTERCXSHELLCTRLS} 

{ TdxPScxCustomShellComboBoxProducer }

function TdxPScxCustomShellComboBoxProducer.Control: TcxCustomShellComboBox;
begin
  Result := inherited Control as TcxCustomShellComboBox;
end;

class function TdxPScxCustomShellComboBoxProducer.ControlClass: TControlClass;
begin
  Result := TcxCustomShellComboBox;
end;

function TdxPScxCustomShellComboBoxProducer.Properties: TcxCustomShellComboBoxProperties;
begin
  Result := inherited Properties as TcxCustomShellComboBoxProperties;
end;

procedure TdxPScxCustomShellComboBoxProducer.GetImageLists(AProc: TdxPSGetImageListProc);
begin
  inherited;
  AProc(dxPSUtl.ShellSmallImages);
end;

procedure TdxPScxCustomShellComboBoxProducer.InitializeItem(AnItem: TdxReportVisualItem);
var
  AText: string;
  AnImageIndex, Stub: Integer;
begin
  inherited;
  with TcxCustomShellComboBoxPropertiesAccess(Properties) do
  begin
    GetShellDisplayValue(Control.EditValue, False, AText, AnImageIndex, Stub);
    if not FastSearch then
    begin
      TdxReportCellImage(AnItem).ImageList := dxPSUtl.ShellSmallImages; //cxShellComboBox.cxShellComboBoxImageList;
      TdxReportCellImage(AnItem).ImageIndex := AnImageIndex;
    end;
    TdxReportCellImage(AnItem).EndEllipsis := True;
    TdxReportCellImage(AnItem).Text := AText;
  end;
end;

function TdxPScxCustomShellComboBoxProducer.ItemClass: TdxReportVisualItemClass;
begin
  Result := TdxReportCellImage; 
end;

{$ENDIF}

{ TdxPScxCustomFontNameComboBoxProducer }

function TdxPScxCustomFontNameComboBoxProducer.Control: TcxCustomFontNameComboBox;
begin
  Result := inherited Control as TcxCustomFontNameComboBox;
end;

class function TdxPScxCustomFontNameComboBoxProducer.ControlClass: TControlClass;
begin
  Result := TcxCustomFontNameComboBox;
end;

function TdxPScxCustomFontNameComboBoxProducer.Properties: TcxCustomFontNameComboBoxProperties;
begin
  Result := inherited Properties as TcxCustomFontNameComboBoxProperties;
end;

function TdxPScxCustomFontNameComboBoxProducer.GetFontName: string;
begin
  if not IsFontSubstitutable then
    Result := TcxCustomFontNameComboBoxPropertiesAccess(Properties).Items[TcxCustomFontNameComboBoxAccess(Control).ItemIndex]
  else
    Result := inherited GetFontName;  
end;

procedure TdxPScxCustomFontNameComboBoxProducer.GetImageLists(AProc: TdxPSGetImageListProc);
begin
  inherited;
  AProc(FontImages);
end;

procedure TdxPScxCustomFontNameComboBoxProducer.InitializeItem(AnItem: TdxReportVisualItem);
const
  ImageIndexes: array[Boolean] of Integer = (1, 0);
var
  ItemIndex: Integer;
begin
  inherited;
  with TcxCustomFontNameComboBoxPropertiesAccess(Properties) do
  begin
    ItemIndex := TcxCustomFontNameComboBoxAccess(Control).ItemIndex;
    if ftiShowInCombo in ShowFontTypeIcon then 
    begin
      TdxReportCellImage(AnItem).ImageList := FontImages;
      if ItemIndex > -1 then
        TdxReportCellImage(AnItem).ImageIndex := ImageIndexes[cxftTTF in ItemTypes[ItemIndex]];
    end;
    TdxReportCellImage(AnItem).MakeSpaceForEmptyImage := ftiShowInCombo in ShowFontTypeIcon;
  end;  
end;

function TdxPScxCustomFontNameComboBoxProducer.IsFontSubstitutable: Boolean;
begin
  Result := not (TcxCustomFontNameComboBoxPropertiesAccess(Properties).UseOwnFont and 
    (TcxCustomFontNameComboBoxAccess(Control).ItemIndex <> -1));
end;

function TdxPScxCustomFontNameComboBoxProducer.ItemClass: TdxReportVisualItemClass;
begin
  Result := TdxReportCellImage; 
end;

{ TdxPScxCustomCheckComboBoxProducer }

function TdxPScxCustomCheckComboBoxProducer.Control: TcxCustomCheckComboBox;
begin
  Result := inherited Control as TcxCustomCheckComboBox;
end;

class function TdxPScxCustomCheckComboBoxProducer.ControlClass: TControlClass;
begin
  Result := TcxCustomCheckComboBox;
end;

function TdxPScxCustomCheckComboBoxProducer.Properties: TcxCustomCheckComboBoxProperties;
begin
  Result := inherited Properties as TcxCustomCheckComboBoxProperties;
end;

{ TdxPScxCustomSpinButtonAsMetafileProducer }

class function TdxPScxCustomSpinButtonAsMetafileProducer.BuddyClass: TdxPSCustomProducerClass;
begin
  Result := TdxPScxCustomSpinButtonProducer;
end;

{ TdxPScxCustomSpinButtonProducer }

function TdxPScxCustomSpinButtonProducer.Control: TcxCustomSpinButton;
begin
  Result := inherited Control as TcxCustomSpinButton;
end;

class function TdxPScxCustomSpinButtonProducer.ControlClass: TControlClass;
begin
  Result := TcxCustomSpinButton;
end;
  
{$IFDEF DXVER500}
      
{ TdxPScxCustomCheckGroupProducer }

function TdxPScxCustomCheckGroupProducer.Control: TcxCustomCheckGroup;
begin
  Result := inherited Control as TcxCustomCheckGroup;
end;

class function TdxPScxCustomCheckGroupProducer.ControlClass: TControlClass;
begin
  Result := TcxCustomCheckGroup;
end;

function TdxPScxCustomCheckGroupProducer.Properties: TcxCustomCheckGroupProperties;
begin
  Result := inherited Properties as TcxCustomCheckGroupProperties;
end;

function TdxPScxCustomCheckGroupProducer.CanProcessChild(AChildControl: TControl): Boolean;
begin
  Result := inherited CanProcessChild(AChildControl) and 
    not (AChildControl is TcxCheckGroupButton);
end;

// TcxCheckBoxState = (cbsUnchecked, cbsChecked, cbsGrayed);
procedure TdxPScxCustomCheckGroupProducer.InitializeButton(AGroup: TdxCustomReportButtonGroup; 
  AButton: TdxCustomReportCellCheck; AnIndex: Integer);
const
  LeftRightMap: array[TLeftRight] of TdxCellCheckPos = (ccpLeft, ccpRight);
begin
  inherited;
  with TdxCustomReportCellCheckAccess(AButton) do 
  begin
    CheckPos := LeftRightMap[TcxCustomCheckGroupPropertiesAccess(Properties).ItemAlignment];
    Checked := Control.States[AnIndex] in [cbsChecked, cbsGrayed];
    Enabled := (Control.States[AnIndex] <> cbsGrayed) and
      TcxCustomCheckGroupPropertiesAccess(Properties).Items[AnIndex].Enabled;
   end;  
end;
  
procedure TdxPScxCustomCheckGroupProducer.InitializeItem(AnItem: TdxReportVisualItem);
begin
  inherited;
  with TdxReportCheckGroup(AnItem) do 
    if not TcxCustomCheckGroupPropertiesAccess(Properties).Glyph.Empty then
    begin
      Glyph := TcxCustomCheckGroupPropertiesAccess(Properties).Glyph;
      GlyphCount := TcxCustomCheckGroupPropertiesAccess(Properties).GlyphCount;
    end;  
end;

function TdxPScxCustomCheckGroupProducer.ItemClass: TdxReportVisualItemClass;
begin
  Result := TdxReportCheckGroup;
end;

{ TdxPScxCustomRichEditProducer }  

function TdxPScxCustomRichEditProducer.Control: TcxCustomRichEdit;
begin
  Result := inherited Control as TcxCustomRichEdit;
end;

class function TdxPScxCustomRichEditProducer.ControlClass: TControlClass;
begin
  Result := TcxCustomRichEdit;
end;

function TdxPScxCustomRichEditProducer.ProducingObjectFriendlyName: string; 
begin
  Result := '';
  if not IsDesigning and (TcxCustomRichEditAccess(Control).Text <> '') then 
    Result := dxPSContainerLnk.dxPSMakeFriendlyNameFromStrings(TcxCustomRichEditAccess(Control).Lines);
  if Result = '' then 
    Result := inherited ProducingObjectFriendlyName;
end;

function TdxPScxCustomRichEditProducer.CreateImage: TGraphic;

  function GetMargins: TRect;
  begin
    Result := Rect(dxTextSpace, dxTextSpace, dxTextSpace, dxTextSpace);
  end;
  
  function GetMaxHeight: Integer;
  begin
    if Definition.OptionsPlace.ExpandHeight then
      Result := -1
    else
      Result := Control.Height;  
  end;
  
begin
  Result := GetRichEditAsGraphic(TcxCustomRichEditAccess(Control).InnerRich.Handle, ContentColor, 
    GetMargins, TMetafile, Control.Width, -1, GetMaxHeight, DC)
end;  

procedure TdxPScxCustomRichEditProducer.InitializeItem(AnItem: TdxReportVisualItem);
var
  Graphic: TGraphic;
begin
  inherited;
  with TdxReportCellGraphic(AnItem) do 
  begin
    BorderClass := Self.BorderClass;
    BorderColor := Self.BorderColor;
    CellSides := cxBordersMap(Style.Edges);
    Color := TcxCustomRichEditAccess(Control).Color;
    ShowShadow := Style.Shadow;

    Graphic := Self.CreateImage;
    try
      Image := Graphic;
    finally
      Graphic.Free;
    end;
    Transparent := False;  
  end;  
end;

function TdxPScxCustomRichEditProducer.ItemClass: TdxReportVisualItemClass;
begin
  Result := TdxReportCellGraphic;
end;

function TdxPScxCustomRichEditProducer.ObjectExpandHeight: Boolean;
begin
  Result := False;
end;

{$ENDIF}
   
procedure RegisterAssistants;
begin
  TdxPScxCustomColorComboBoxProducer.Register;
 {$IFDEF REGISTERCXSHELLCTRLS} 
  TdxPScxCustomShellComboBoxProducer.Register;
 {$ENDIF} 
  TdxPScxCustomFontNameComboBoxProducer.Register;
  TdxPScxCustomCheckComboBoxProducer.Register;
  TdxPScxCustomSpinButtonProducer.Register;
  TdxPScxCustomSpinButtonAsMetafileProducer.Register;
 {$IFDEF DXVER500}
  TdxPScxCustomCheckGroupProducer.Register;
  TdxPScxCustomRichEditProducer.Register;
 {$ENDIF} 
end;

procedure UnregisterAssistants;
begin
 {$IFDEF DXVER500}
  TdxPScxCustomRichEditProducer.Unregister;
  TdxPScxCustomCheckGroupProducer.Unregister;
 {$ENDIF} 
  TdxPScxCustomSpinButtonAsMetafileProducer.Unregister;
  TdxPScxCustomSpinButtonProducer.Unregister;
  TdxPScxCustomCheckComboBoxProducer.Unregister;
  TdxPScxCustomFontNameComboBoxProducer.Unregister;
 {$IFDEF REGISTERCXSHELLCTRLS} 
  TdxPScxCustomShellComboBoxProducer.Unregister;
 {$ENDIF} 
  TdxPScxCustomColorComboBoxProducer.Unregister;
end;

initialization
  RegisterAssistants;
  
finalization
  UnregisterAssistants;
  
end.
