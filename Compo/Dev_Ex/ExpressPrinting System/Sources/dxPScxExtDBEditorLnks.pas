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

unit dxPScxExtDBEditorLnks;

interface

{$I cxVer.inc}

uses
  cxDBCheckListBox, cxDBRichEdit, dxPScxCheckListBoxLnk, dxPScxExtComCtrlsLnk;
  
type
  TcxDBCheckListBoxReportLink = class(TcxCustomCheckListBoxReportLink)
  private
    function GetcxDBCheckListBox: TcxDBCheckListBox;
  public
    property cxDBCheckListBox: TcxDBCheckListBox read GetcxDBCheckListBox;
  published
    property Color;
    property EndEllipsis;
    property EvenColor;
    property EvenFont;
    property Font;
    property Multiline;
    property OddColor;
    property OddFont;
    property Options;
    property RowAutoHeight;
    property ScaleFonts;
    property SupportedCustomDraw;
    property Transparent;
    property UseHorzDelimiters;
    property UseVertDelimiters;
    property Width;
    
    property OnCustomDrawItem;
    property OnInitializeItem;
  end;  

 {$IFDEF DXVER500}
 
  TcxDBRichEditReportLink = class(TcxCustomRichEditReportLink)
  private
    function GetRichEdit: TcxDBRichEdit;
  public
    property RichEdit: TcxDBRichEdit read GetRichEdit;
  end;

 {$ENDIF}
    
implementation

uses
  dxPSCore;

{ TcxDBCheckListBoxReportLink }

function TcxDBCheckListBoxReportLink.GetcxDBCheckListBox: TcxDBCheckListBox;
begin
  Result := inherited Component as TcxDBCheckListBox;
end;

{$IFDEF DXVER500}

{ TcxDBRichEditReportLink }

function TcxDBRichEditReportLink.GetRichEdit: TcxDBRichEdit;
begin
  Result := inherited Component as TcxDBRichEdit;
end;

{$ENDIF} 

initialization
  dxPSRegisterReportLink(TcxDBCheckListBoxReportLink, TcxDBCheckListBox, TcxfmCheckListBoxDesignWindow);
 {$IFDEF DXVER500}
  dxPSRegisterReportLink(TcxDBRichEditReportLink, TcxDBRichEdit, nil);  
 {$ENDIF} 
  
finalization
 {$IFDEF DXVER500}
  dxPSUnregisterReportLink(TcxDBRichEditReportLink, TcxDBRichEdit, nil);  
 {$ENDIF}
  dxPSUnregisterReportLink(TcxDBCheckListBoxReportLink, TcxDBCheckListBox, TcxfmCheckListBoxDesignWindow);

end. 
