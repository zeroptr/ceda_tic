
{                                                                              }
{  IB_Grid                                                                     }
{                                                                              }

{***************************************************************}
{                                                               }
{          IB Objects Components and Resources Library          }
{                                                               }
{          Copyright (C) 1996-2001 Jason Wharton                }
{          and Computer Programming Solutions, Mesa, AZ         }
{                                                               }
{  This source code unit is released under the terms of the     }
{  CPS Trustware License.                                       }
{  It may be distributed or deployed as source code or in       }
{  compiled form only in compliance with the terms and          }
{  conditions of the CPS Trustware License which may be         )
{  examined at http://www.ibobjects.com/ibo_trustware.html      )
{                                                               }
{***************************************************************}

{******************************************************************************}
{  CONTRIBUTED MODIFICATIONS                                                   }
{  Additions or modifications listed below using format:                       }
{                                                                              }
{  Joe Citizen <joe@joecitizen.com>                                            }
{  mm/dd/yyyy                                                                  }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{            Copyright (C) 2001 Joe Citizen                                    }
{                                                                              }
{------------------------------------------------------------------------------}
{  Place your credits and information in the top of the section                }
{  below with any other descriptions or explanations desired.                  }
{------------------------------------------------------------------------------}
{                                                                              }
{  Meir Kriheli <meir@mksoft@co.il>                                            }
{  27-May-2003                                                                 }
{     Fixed BiDi functionality for proper drawing of indicators and titles in  }
{     TIB_CustomGrid.DrawCell when using bdRightToLeft mode. Added another     }
{     TRect var (tmpRect2) to that procedure - needed as a holder for tmpRect  }
{     before using drawEdge (can't modify ARect - needed down the road)        }
{                                                                              }
{  Wassim Haddad <lobolo2000@hotmail.com>                                      }
{  06-Jan-2003                                                                 }
{     Added support for an interface extension that supports owner             }
{     draw controls.                                                           }
{                                                                              }
{  Jason Wharton <jwharton@ibobjects.com>                                      }
{  10-May-2002                                                                 }
{     I changed the button glyph handle so that it just used one of my         }
{     resources directly instead of a system resource. This way I could have   }
{     better control over the handle allocation and avoid problems.            }
{                                                                              }
{  Luiz Alves <cprmlao@infolink.com.br>                                        }
{  01-out-2002                                                                 }
{     -Fix to tib_lookupcombo showing incorrect width during dropdown          }
{     -Fix to tib_lookupcombo doesn't paint bottom line of external rectangle  }
{       during dropdown                                                        }

{  Guido Klapperich <guido.klapperich@t-online.de>                             }
{  05-may-2002                                                                 }
{     I added the protected property DatePick: TDatePick, that references      }
{     to Inplace-Editor for date fields. Now you can change the properties     }
{     of the Inplace-Editor in your derived class.                             }
{                                                                              }
{  Dirk Schiffler <ds@rcs.de>                                                  }
{  24-apr-2002                                                                 }
{     In TIB_CustomCombo.Destroy fixed the release of glyph-handle.            }
{     FButton.Glyph.Handle := 0  set to FButton.Glyph.ReleaseHandle            }
{                                                                              }
{  Marco Menardi <mmenaz@lycosmail.com>                                        }
{  20-mar-2002                                                                 }
{     Fixed Shift-Tab with TabStop and TabOut set to true                      }
{                                                                              }
{  Meir Kriheli <meir@mksoft@co.il>                                            }
{  10-mar-2002                                                                 }
{     Added BiDi functionality for proper drawing in bdRightToLeft mode.       }
{     1. Added changeGridOrientation function to TIB_CustomGrid. This function }
{        is set to private in TCustomGrid so it is reintroduced here.          }
{     2. fixed DefaultDrawFocusedCell (in BiDi mode right and left exchanged). }
{     3. Removed comment braces in writeLongText for correct text layout       }
{        (DT_RTLREADING).                                                      }
{     4. In writeLongText added code for correct placment of text on the grid. }
{     5. In DefaultDrawTitle, added code for proper drawing of sort indicator. }
{                                                                              }
{  Paul Hope <paulhope@allcomm.co.uk>                                          }
{  28-jan-2002                                                                 }
{     Changed TitleAlignment option to gtaRightJustify, gtaLeftJustify,        }
{     gtaCenter, gtaColumns.  When gtaColums is selected the title alignments  }
{     follow the column alignment - if one cant be found defaults to           }
{     LeftJustify                                                              }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  13-Feb-2002                                                                 }
{     Altered the grid Paint routine to reset FEditorMode according to the     }
{     visibility/availability of the inplace editor (rather than directly      }
{     resetting to its old value).  This ensures FEditorMode remains in        }
{     sync with the inplace editor as expected by the base class.              }
{                                                                              }
{  Marco Menardi <mmenaz@lycosmail.com>                                        }
{  27-jan-2002                                                                 }
{     If an field EditMask was set, CharCase attribute was ignored.            }
{                                                                              }
{  Marco Menardi <mmenaz@lycosmail.com>                                        }
{  14-jan-2002                                                                 }
{     Fix TIB_CustomCombo.CMExit problem when ClearSelectionOnExit is true     }
{     since unhandled EAbort exception produced a wrong try to focus to a      }
{     unfucusable control                                                      }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  08-Jan-2002                                                                 }
{     Altered the InplaceEditor.UpdateContents method so that it is possible   }
{     to override the display of the default date editor.  The change means    }
{     that if you put in MYDATEFIELD=EDIT in the EditLinks and attach your     }
{     own code to OnEditButton the default editor will not appear.             }
{                                                                              }
{  Marco Menardi <mmenaz@lycosmail.com>                                        }
{  07-jan-2002                                                                 }
{     Fix boolean fields not setting ControlIsModified if IndicateBooleans     }
{     is true (default)                                                        }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  20-Dec-2001                                                                 }
{     Added GetAutoLabel interface routine to support change to                }
{     IIB_GridWinControl                                                       }
{                                                                              }
{ Dirk Schiffler <ds@rcs.de>                                                   }
{ 11-Nov-2001                                                                   }
{    - constant G_DefaultRowHeight for property DefaultRowHeight               }
{      in the class-definitions for grid                                       }
{    - new property 'NoVertScrollBar' in unit IB_Grid                          }
{      it's use in procedure 'UpdateScrollBars' to avoid a vertical scrollbar  }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  11-Oct-2001                                                                 }
{     Fix to stop grid losing focus when using NavigateOptions and dropped     }
{     controls.  Also related to the earilier InvalidateRow change.            }
{     Added a check prior to SetFocus to account for a Delphi5 bug.            }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  18-Sep-2001                                                                 }
{     Prevent designtime error when dropping controls onto grid.  Also fix     }
{     focus problem introduced by my earlier InvalidateRow change.             }
{                                                                              }
{  Jason Wharton <jwharton@ibobjects.com>                                      }
{  11-Sep-2001                                                                 }
{     Disappearing grid fix.                                                   }
{                                                                              }
{  Jason Wharton <jwharton@ibobjects.com>                                      }
{  09-Sep-2001                                                                 }
{     Fixed the TIB_LookupList so that it had the right property declarations. }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  27-Aug-2001                                                                 }
{     Make it so that InvalidateRow also invalidates any dropped control.      }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  10-Aug-2001                                                                 }
{     Added calls to RemakeAutoLabel to the TIB_CustomCombo definition.        }
{     Required because this control does not get the standard control          }
{     inclusions from IB_Control.*                                             }
{                                                                              }
{  Wassim Haddad                                                               }
{  08/08/2001                                                                  }
{     Added ESCAPE key handling for revert of changes.                         }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the IB_Grid control and its inplace editor.
It also contains the lookup combo and lookup list controls.}
unit
  IB_Grid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, Buttons, ExtCtrls, DatePick, Menus, ShellApi,

{$ifdef IBO_VCL60_OR_GREATER}
  MaskUtils,
{$endif}

  IB_Header,
  IB_Session,
  IB_Constants,
  IB_Components,
  IB_FieldDataLink,
{$IFNDEF VER90}
  IBC_Label,
{$ENDIF}
  IB_ControlInterface;
//IB_CGrid
//DBGrids

type

{: Event to handle a IncSearch matches.}
TIB_OnIncSearch = procedure( Sender: TObject;
                             Text: String;
                             Match: boolean) of object;

{: Event to handle a click in the grid.}
TIB_CustomGridCellClickEvent = procedure( Sender: TObject;
                                          ACol, ARow: longint;
                                          AButton: TMouseButton;
                                          AShift: TShiftState ) of object;
{: Event for general cell operations.}
TIB_CustomGridCellEvent = procedure( Sender: TObject;
                                     ACol, ARow: longint ) of object;
{: Event to provide a custom font and color on a per cell basis.}
TIB_GetCellPropsEvent = procedure(       Sender: TObject;
                                         ACol, ARow: longint;
                                         AState: TGridDrawState;
                                     var AColor: TColor;
                                         AFont: TFont ) of object;

{: Event to customize the text that is displayed on a per cell basis.}
TIB_GetDisplayTextEvent = procedure(     Sender: TObject;
                                         ACol, ARow: longint;
                                     var AString: string ) of object;

{: Event to customize or validate the text that is assigned to the column.}
TIB_SetColumnTextEvent = procedure(     Sender: TObject;
                                    var AString: string ) of object;

{: Event to customize the valid characters on a per cell basis.}
TIB_IsValidCharEvent = procedure (     Sender: TObject;
                                   var Key:char;
                                   var IsValid:Boolean ) of object;

{: Event to customize action taken when a file is dropped onto the grid.}
TIB_DropFilesEvent = procedure( Sender: TObject;
                                AFilenames: TStrings ) of object;

{: This type is used to keep track of changes in scaling of a form.}
TIB_ScalingFlags = set of ( sfCurrentRowFont,
                            sfFixedFont,
                            sfOrderingFont,
                            sfDefaultRowHeight,
                            sfBorderRowHeights );

{: TScrollFixQueuedMessage - really just a record but declared as a class
for TList support.  Stores queued message info for TScrollFixTimer. }
TScrollFixQueuedMessage = class(TObject)
public
  Handle: THandle;
  Msg: Cardinal;
  WParam: longint;
  LParam: longint;
end;

{: TScrollFixTimer.  Due to some shortcomings with MS's scrolling processes
it is possible that any scroll that results in message processing (eg. an event
or callback that calls "Application.ProcessMessages") may lead to the loss
of the WM_LBUTTONUP message that signals the end of scrolling.  This can result
in various problems, including never-ending scrolling.
<br>
<br>Because scrolling an IB_Grid is likely to result in this situation we
setup a global timer function to which we can queue WM_LBUTTONUP messages back
to the message queue.
<br>
<br>Note: The messages must be queued by timer and not by PostMessage, in
order to avoid an infinite loop of ProcessMessages calls.
<br>
<br>Note 2: This timer is not specifically tied to the IB_Grid component so
it can be used by any control that experiences this problem.  A single global
instance of this timer is instantiated in this unit called MessageRequeueTimer.
To use this timer simply call "MessageRequeueTimer.QueueMessage( Handle, Msg )"
with the window handle and message that you want requeued (usually the control
window handle and WM_LBUTTONUP message for scroll problems).  The object will
take a copy of the message to be queued back to the application next time
the timer is initiated.  (The class itself takes care to enable/disable the
the timer according to whether any messages are queued.)
<br>
<br>Refer to Microsoft Knowledgebase item Q102552 for more detail on
the scroll problem this was built to circumvent.}
TScrollFixTimer = class(TTimer)
private
  FMessageQueue: TList;
protected
  procedure DoTimer( Sender: TObject );
public
  constructor Create( Owner: TComponent ); override;
  destructor Destroy; override;
  procedure QueueMessage( WHandle: THandle; const Msg: TMessage );
end;

{ Forward Declarations }
TIB_CustomGrid = class;
TIB_CustomCombo = class;

{$Define IBG_CustomGrid}

{: Specialized data link for the IB_CustomGrid class.}
TIB_CustomGridLink = class( TIB_ControlDataLink )
private
  FIB_Grid: TIB_CustomGrid;
  function GetBDataset: TIB_BDataset;
protected
  procedure ProcessGridEvent( AEvent: TIB_StatementEventType;
                              Info: longint ); override;
  procedure SysStateChanged; override;
public
  constructor Create( AOwner: TComponent ); override;
  property BDataset: TIB_BDataset read GetBDataset;
end;

TIB_EditStyle = ( esNormal, esEdit, esDate );

{: In place editor for the TIB_Grid control.}
TIB_GridInplaceEdit = class( TInplaceEdit )
private
  FButtonWidth: Integer;
  FEditStyle: TIB_EditStyle;
  FTracking: Boolean;
  FPressed: Boolean;
  procedure SetEditStyle(Value: TIB_EditStyle);
  procedure StopTracking;
  procedure TrackButton(X,Y: Integer);
  procedure WMCancelMode(var Message: TMessage); message WM_CancelMode;
  procedure WMLButtonDblClk(var Message: TWMLButtonDblClk);
                                                       message wm_LButtonDblClk;
  procedure WMPaint(var Message: TWMPaint); message wm_Paint;
  procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
  procedure CMEnter( var Message: TCMEnter ); message CM_ENTER;
  procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
protected
  procedure WndProc(var Message: TMessage); override;
  procedure BoundsChanged; override;
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  procedure KeyPress(var Key: Char); override;
  procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer); override;
  procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer); override;
  procedure PaintWindow(DC: HDC); override;
  procedure UpdateContents; override;
  property  EditStyle: TIB_EditStyle read FEditStyle write SetEditStyle;
public
  constructor Create(Owner: TComponent); override;
  property Color;
  property CharCase;
  property EditMask;
end;

TGTAlignment = (gtaLeftJustify,
                gtaRightJustify,
                gtaCenter,
                gtaColumns);

TIB_Grid_GlyphType = ( ggUpSortable,
                       ggDownSortable,
                       ggBiSortable,
                       ggNaturalSortable,
                       ggUp,
                       ggDown,
                       ggBiUp,
                       ggBiDown,
                       ggNatural );

TIB_Grid_GlyphSet = set of TIB_Grid_GlyphType;

TIB_Grid_NavOptionType = ( gnF2Edits,
                           gnF2Posts,
                           gnF2ToggleEditor,
                           gnBrowseAlwaysNavigate,
                           gnCtrlNavigate,
                           //gnF2EditClick, - see notes in KeyDown for VK_F2
                           gnOnEditDoEditClick,
                           gnMemoEditTabExits );

TIB_Grid_NavOptions = set of TIB_Grid_NavOptionType;

TIB_Grid_DrawTextType = ( gdtEllipsis,
                          gdtShowTextBlob,
                          gdtVertCenter,
                          gdtVertBottom,
                          gdtWordWrap );

{ Options for controlling DrawText functions in TIB_Grid.<br>
<br>
gdtEllipsis = draw ellipsis ("...") to represent text that will not fit
in cell.<br>
<br>
gdtShowTextBlob = show contents of text blob columns (instead of "BLOB"
indicator).  Obviously this is only applicable to non-title cells.<br>
<br>
gdtVertCenter = draw text in vertical center of the cell.  (Causes gdtWordWrap
and gdtVertBottom to be ingored.)<br>
<br>
gdtVertBottom = draw text at the bottom of the cell. (Causes gdtWordWrap to be
ignored.  Will be ignored if gdtVertCenter is true.)<br>
<br>
gdtWordWrap = draws text that will not fit across the width of the cell
as wordwrapped text (multiple lines).  (Will be ignored if gdtVertCenter or
gdtVertBottom are true.) }
TIB_Grid_DrawTextOptions = set of TIB_Grid_DrawTextType;

{: This is the absract base class for the IB_Grid.
<br><br>
It has been desinged to work with buffered datasets only. This could be the
IB_Query component or any other TIB_BDataset descendant.
<br><br>
This class has the properties, methods and events with their descriptions.}
TIB_CustomGrid = class(TCustomGrid)
{$I IB_WinControl.INT}
private
  FrameFlags1, FrameFlags2: DWORD;
  FSizingGrid: boolean;
  FUpdatingColAttr: boolean;
  FUpdatingEditing: boolean;
  FUpdatingColCount: boolean;
  FUpdatingRowCount: boolean;
  FUpdatingRowPos: boolean;
  FUpdatingTopRowNum: boolean;
  FCreatingWnd: boolean;
  FHideRowSelection: boolean;
  FEditText: string;
  FEditMask: string;
  FWasDblClick: boolean;
  FMouseIsDown: boolean;
  FMouseWasMoved: boolean;
  FMouseDownPoint: TPoint;
  FGridFields: TList;
  FBuffFields: TList;
  FTrackGridRow: boolean;
  FIndicateBooleans: boolean;
  FIndicateOrdering: boolean;
  FIndicateRow: boolean;
  FIndicateTitles: boolean;
  FIndicateSelected: boolean;
  FIndicateHighLight: boolean;
  FIndicateNearest: boolean;
  FDrawCellTextOptions: TIB_Grid_DrawTextOptions;
  FDrawTitleTextOptions: TIB_Grid_DrawTextOptions;
  FSelRow: integer;
  FCurrentRowColor: TColor;
  FCurrentRowFont: TFont;
  FOrderingColor: TColor;
  FOrderingFont: TFont;
  FFixedFont: TFont;
  FIB_ScalingFlags: TIB_ScalingFlags;
  FGridLinks: TIB_StringList;
  FEditLinks: TIB_StringList;
  FEditLinksAuto: boolean;
  FEditLinkAutoClicked: boolean;
  FTabStopLinks: TIB_StringList;
  FListBoxStyle: boolean;
  FNoVertScrollBar: boolean;
  FBorderRows: integer;
  FBorderCols: integer;
  FFixedDataCols: integer;
  FTitleAlignment: TGTAlignment;
  FFocusedCell: TGridCoord;
  FFirstTabCol: integer;
  FLastTabCol: integer;
  FParentCombo: TIB_CustomCombo;
  FOldParent: TWinControl;
  FOldVisible: boolean;
  FStretchColumn: string;
  FStretchColRef: TIB_Column;
  FStretchColNum: integer;
  FNavigateOptions: TIB_Grid_NavOptions;
  FTabMovesOut: boolean;
  FDatePick: TDatePick;
  FIncSearchText: string;
  FIncSearchLevel: integer;
  FIncSearchKeyByKey: boolean;
  FSeekNearest: boolean;
  FAllowTimeout: boolean;
  FAllowIncSearch: boolean;
  FAllowDropFiles: boolean;
  FToggleOnDblClick: boolean;
  FIncSearchState: boolean;
  FIncSearchHotKey: TShortCut;
  FInColExit: boolean;
  FRowIndicatorColWidth: integer;
  FCtl3DShallow: boolean;
  FScrollInProgress: integer;
  FEscKeyControl: TWinControl;
  FFocusEligable: boolean;
  FPaintingLevel: integer;
  FFieldsToGridLinks: TList;
{ Event storage fields }
  FOnIncSearch: TIB_OnIncSearch;
  FInGridLayoutLevel: integer;
  FUpdatingData: boolean;
  FEditorBorderStyle: TBorderStyle;
  FOnEditButtonClick: TNotifyEvent;
  FOnDrawCell: TDrawCellEvent;
  FOnDrawFocusedCell: TDrawCellEvent;
  FOnDrawTitle: TDrawCellEvent;
  FOnDrawBorder: TDrawCellEvent;
  FOnDropFiles: TIB_DropFilesEvent;
  FOnGetCellProps: TIB_GetCellPropsEvent;
  FOnGetDisplayText: TIB_GetDisplayTextEvent;
  FOnGetEditMask: TGetEditEvent;
  FOnGetEditText: TGetEditEvent;
  FOnIsValidChar: TIB_IsValidCharEvent;
  FOnSetEditText: TSetEditEvent;
  FOnTopLeftChanged: TNotifyEvent;
  FOnCellClick: TIB_CustomGridCellClickEvent;
  FOnCellDblClick: TIB_CustomGridCellClickEvent;
  FOnBorderClick: TIB_CustomGridCellClickEvent;
  FOnTitleClick: TIB_CustomGridCellClickEvent;
  FOnCellGainFocus: TIB_CustomGridCellEvent;
  FOnCellLoseFocus: TIB_CustomGridCellEvent;
  FOnColEnter: TNotifyEvent;
  FOnColExit: TNotifyEvent;
  FOnSetColumnText: TIB_SetColumnTextEvent;
  FCustomGlyphs: TImageList;
  FCustomGlyphsSupplied: TIB_Grid_GlyphSet;
  FAllowLockSession: boolean;
  FCurrentRowFontHeight: integer;
  FFixedFontHeight: integer;
  FOrderingFontHeight: integer;
  FTopRowNum: longint;
  FDataRowCount: integer;
  FPartialRowHeight: integer;
  // CVC 2001: Allows to stop default drawing before custom events.
  FDefDrawBefore: Boolean;
  { Property access methods }
  function GetAlwaysShowEditor: boolean;
  function GetRowSelect: boolean;
  function GetOptions: TGridOptions;
  function GetBorderRowsHeight: integer;
  procedure SetAllowDropFiles( AValue: boolean );
  procedure SetToggleOnDblClick( AValue: boolean );
  procedure SetTopRowNum( AValue: longint );
  procedure SetRowIndicatorColWidth( AValue: integer );
  function IsGridFontStored: boolean;
  procedure GridFontChanged( Sender: TObject );
{ Datalink event handlers }
  procedure IB_AfterAssignment( Sender: TIB_DataLink;
                                IB_DataSource: TIB_DataSource );
  procedure LayoutChange( Sender: TIB_DataLink;
                          IB_DataSource: TIB_DataSource );
{ Messages }
  procedure CMParentFontChanged(var Message: TMessage);
                                                   message CM_PARENTFONTCHANGED;
{$IFNDEF VER90}
  procedure CMSysFontChanged(var Message: TMessage); message CM_SYSFONTCHANGED;
{$ENDIF}
  procedure WMSize(var Message: TWMSize); message WM_SIZE;
  procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
  procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
  procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
  procedure WMDropFiles(var Msg: TMessage); message WM_DropFiles;
  procedure CMControlListChange(var Message: TCMControlListChange);
                                                   message CM_ControlListChange;
  procedure CMChildKey(var Msg: TCMChildKey); message CM_CHILDKEY;
  procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;

  procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
{CNKeyDown is handle for CN_KEYDOWN message. It's a message send to control
   notifing that WM_KEYDOWN message is coming}

  procedure CNChar(var Message: TWMChar); message CN_CHAR;
{CNChar is handle for CN_Char message. It's a message send to control
   notifing that WM_CHAR message is coming}

  procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
{the WM_GETSLGCODE message is internal VCL message to find out how the control
   is going to serve the WM_CHAR message (this is the procedure to get around
   the hot key problem during IncSearch}
  procedure SetCustomGlyphs(Value: TImageList);
  procedure SetCustomGlyphsSupplied(Value: TIB_Grid_GlyphSet);
  procedure CustomGlyphsChange(Sender: TObject);
{ Methods based on DBGrid}
  function HasFocus: boolean;
  function AcquireFocus: boolean;
{$IFDEF IBO_VCL40_OR_GREATER}
  procedure ChangeGridOrientation( RightToLeftOrientation: Boolean );
{$ENDIF}
protected
  FAcquireFocus: boolean;
  FIgnoreFocus: boolean;
  procedure ChangeScale( M, D: integer ); override;
  procedure RowHeightsChanged; override;
  procedure ColEnter; dynamic;
  procedure ColExit; dynamic;
  procedure Notification( AComponent: TComponent;
                          Operation: TOperation); override;
  procedure CheckPreventModifications; virtual;
  function CreateEditor: TInplaceEdit; override;
  procedure DatePickChange(Sender: TDatePick; Value: TDatePickResult); virtual;
  procedure EditButtonClick; dynamic;
  function GetFixedCols: integer;
  function GetFixedRows: integer;
  procedure SetFixedRows( AValue: integer );
  function GetInGridLayout: boolean;
  function GetLookupText(     ACol: TIB_Column;
                          var DispText: string ): boolean;
  procedure SetCurrentRowColor( AValue: TColor ); virtual;
  procedure SetCurrentRowFont( AValue: TFont ); virtual;
  procedure SetOrderingColor( AValue: TColor ); virtual;
  procedure SetOrderingFont( AValue: TFont ); virtual;
  procedure SetFixedFont( AValue: TFont ); virtual;
  procedure SetGridLinks( AValue: TIB_StringList ); virtual;
  procedure SetEditLinks( AValue: TIB_StringList ); virtual;
  procedure SetTabStopLinks( AValue: TIB_StringList ); virtual;
  procedure SetFixedDataCols( AValue: integer ); virtual;
  procedure SetFocusedCell( AValue: TGridCoord ); virtual;
  function GetIsModifying( ACol, ARow: Longint;
                           AState: TGridDrawState ): boolean; virtual;
  function GetIsHighlighted( ACol, ARow: Longint;
                             AState: TGridDrawState ): boolean; virtual;
  function GetIsSelected( ACol, ARow: Longint;
                          AState: TGridDrawState ): boolean; virtual;
  function GetIsOrdering( ACol, ARow: Longint;
                          AState: TGridDrawState ): boolean; virtual;
  procedure GridLinksChange( Sender: TObject );
  procedure SetListBoxStyle( AValue: boolean );
  procedure SetAllowIncSearch( AValue: boolean );
  procedure SetTrackGridRow( AValue: boolean );
  procedure SetTitleAlignment( AValue: TGTAlignment );
  procedure SetParentCombo( AValue: TIB_CustomCombo );
  property ParentCombo: TIB_CustomCombo read FParentCombo
                                        write SetParentCombo;
  function IsColLookup( ACol: TIB_Column ): boolean;
  function PositionControl( ACol, ARow: longint;
                            ARect: TRect ): boolean; virtual;
  function ToggleCheckBox( ACol, ARow: integer ): boolean; virtual;
  procedure DoIncSearchKeyPress( var Key: char ); virtual;
  procedure DoDropFiles( AFilenames: TStrings ); virtual;
{ Inherited Methods }
  procedure Loaded; override;
  procedure KeyDown( var Key: Word; Shift: TShiftState ); override;
  procedure KeyUp( var Key: Word; Shift: TShiftState ); override;
  procedure KeyPress( var Key: Char ); override;
  procedure MouseDown( Button: TMouseButton;
                       Shift: TShiftState;
                       X, Y: Integer ); override;
  procedure MouseMove( Shift: TShiftState;
                        X, Y: Integer ); override;
  procedure MouseUp( Button: TMouseButton;
                     Shift: TShiftState;
                     X, Y: Integer ); override;
  procedure CreateWnd; override;
  procedure CreateParams(var Params: TCreateParams); override;
  procedure SizeChanged( OldColCount, OldRowCount: Longint ); override;
  procedure ColWidthsChanged; override;
  procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
  function CanGridAcceptKey(Key: Word; Shift: TShiftState): Boolean; override;
  {$ifdef IBO_VCL40_OR_GREATER}
  function DoMouseWheelDown( Shift: TShiftState;
                             MousePos: TPoint ): boolean; override;
  function DoMouseWheelUp( Shift: TShiftState;
                           MousePos: TPoint ): Boolean; override;
  {$endif}
{ Inherited Methods For Event Dispatch }
  procedure Paint; override;
  procedure DrawCell( ACol, ARow: Longint;
                      ARect: TRect;
                      AState: TGridDrawState ); override;
  function CanEditAcceptKey(Key: Char): Boolean; override;
  function CanEditModify: boolean; override;
  function CanEditShow: boolean; override;
  function GetEditText( ACol, ARow: Longint ): string; override;
  procedure SetEditText( ACol, ARow: Longint; const Value: string ); override;
  function GetEditMask( ACol, ARow: Longint ): string; override;
  function GetEditLimit: Integer; override;
  function SelectCell( ACol, ARow: Longint ): Boolean; override;
  procedure TimedScroll( Direction: TGridScrollDirection ); override;
  procedure TopLeftChanged; override;
{ Utility Methods }
  procedure DefineFieldMap; virtual;
  procedure Scroll(Distance: Integer); virtual;
  procedure Slide(Distance: Integer); virtual;
  procedure ProcessStatementEvent( AEvent: TIB_StatementEventType;
                                   Info: longint ); virtual;
  procedure DoCellGainFocus( AGridCoord: TGridCoord ); virtual;
  procedure DoCellLoseFocus( AGridCoord: TGridCoord ); virtual;
  procedure DoDrawFocusedCell( ACol, ARow: longint;
                               ARect: TRect;
                               AColor: TColor;
                               AFont: TFont ); virtual;
{ System Methods }
  procedure UpdateColumnAttributes; virtual; // Keep virtual
  function UpdateRowPos( ResetRowPos: boolean ): boolean;
  procedure UpdateRowCount;
  procedure UpdateScrollBar;
  procedure UpdateOrdering( ACol, ARow: integer );
  procedure SysUpdateEditing;
  procedure SysUpdateEditor;
{ Event dispatch Methods }
  procedure BorderClick( ACol, ARow: integer;
                         AButton: TMouseButton;
                         AShift: TShiftState ); dynamic;
  procedure CellClick( ACol, ARow: integer;
                       AButton: TMouseButton;
                       AShift: TShiftState ); dynamic;
  procedure CellDblClick( ACol, ARow: integer;
                       AButton: TMouseButton;
                       AShift: TShiftState ); dynamic;
  procedure TitleClick( ACol, ARow: integer;
                        AButton: TMouseButton;
                        AShift: TShiftState ); dynamic;
  function GetGridFields( Index: integer ): TIB_Column;
  function GetBuffFields( Index: integer ): TIB_Column;
  function GetSelectedField: TIB_Column;
  function GetGridFieldCount: integer;
  function GetColMoving: boolean;
  function GetColSizing: boolean;
  procedure SetColMoving( AValue: boolean );
  procedure SetColSizing( AValue: boolean );
  function GetDataRow( ARow: integer ): integer;
  function GetGridRow( ARowNum: integer ): integer;
  function GetDataCol( ACol: integer ): integer;
  function GetGridCol( ACol: integer ): integer;
  procedure SetRowLines( AValue: boolean );
  procedure SetColLines( AValue: boolean );
  procedure SetFixedRowLines( AValue: boolean );
  procedure SetFixedColLines( AValue: boolean );
  function GetRowLines: boolean;
  function GetColLines: boolean;
  function GetFixedRowLines: boolean;
  function GetFixedColLines: boolean;
  procedure SetIndicateBooleans( AValue: boolean );
  procedure SetIndicateTitles( AValue: boolean );
  procedure SetIndicateRow( AValue: boolean );
  procedure SetIndicateOrdering( AValue: boolean );
  procedure SetIndicateSelected( AValue: boolean );
  procedure SetIndicateHighLight( AValue: boolean );
  function GetIndicateLongTitle: boolean;
  procedure SetIndicateLongTitle( AValue: boolean );
  function GetIndicateLongCellText: boolean;
  procedure SetIndicateLongCellText( AValue: boolean );
  procedure SetDrawCellTextOptions( AValue: TIB_Grid_DrawTextOptions );
  procedure SetDrawTitleTextOptions( AValue: TIB_Grid_DrawTextOptions );
  procedure SetAlwaysShowEditor( AValue: boolean );
  procedure SetRowSelect( AValue: boolean );
  function GetDrawFocusSelected: boolean;
  procedure SetDrawFocusSelected( AValue: boolean );
  function GetThumbTracking: boolean;
  procedure SetThumbTracking( AValue: boolean );
  procedure SetBorderRows( AValue: integer );
  procedure SetBorderCols( AValue: integer );
  function GetBorderRowHeight( Index: integer ): integer;
  procedure SetBorderRowHeight( Index: integer; AValue: integer );
  function GetBorderColWidth( Index: integer ): integer;
  procedure SetBorderColWidth( Index: integer; AValue: integer );
  procedure SetDefaultColWidth(Value: Integer);
  procedure SetCtl3DShallow( AValue: boolean );
  property DefaultColWidth write SetDefaultColWidth;
  property DefaultRowHeight default G_DefaultRowHeight;
  property BorderRowsHeight: integer read GetBorderRowsHeight;

  property DatePick: TDatePick read FDatePick write FDatePick; // GK 05/05/2002
{$IFDEF HELPSCAN}
published
{$ELSE}
public
{$ENDIF}

{: This is a count of how many full rows are in view in the grid.}
  property DataRowCount: integer read FDataRowCount;
{: This is the height of the partial row at the bottom of the grid.}
  property PartialRowHeight: integer read FPartialRowHeight;

{: This property determines a custom list of fields that should be displayed
in the grid.
<br><br>
It orders the fields and thus overrides the TIB_Query.FieldsIndex property.
<br>
<br>It allows the following syntax:
<br>[< tablename >.]< columnname >
<br>This is the simplest specification. The field will be visible in the grid
if the dataset provides it. Properties are taken from the TIB_Column.
<br>[< tablename >.]< columnname >=WIDTH=< width_in_pixels >
<br>When WIDTH is specified, only the current grid is affected. The underlying
TIB_Column will remain unaffected, hence other grids won't be impacted.
<br>[< tablename >.]< columnname >=ALIGN=< Left|Center|Right >
<br>When ALIGN is specified, only the current grid is affected. The underlying
TIB_Column will remain unaffected, hence other grids won't be impacted. Only
the first letter is significative to specify the field alignment.
<br>Of course, you can mix the two specifications, for example:
<br>myfield=WIDTH=45;ALIGN=C
<br>
<br>Beware the functionality has changed. In previous version, a field named
in this property that didn't exist in the dataset would cause an incorrect
exchange of fields when done visually on the grid with the mouse. Now, the
grid takes into account the GridLinks entries not found in the dataset for
all operations. So, you can switch at run-time between datasources and the grid
will adjust to the fields that only exists in the new TIB_Query.}
  property GridLinks: TIB_StringList read FGridLinks write SetGridLinks;
{: This property allows columns to be flagged so that they will make a
little button appear when the cell gets focused so that the user can click on
this button and have a dialog appear or some other defined action.
<br>
<br>You make an entry in this property as follows:
<br>
<br>[< tablename >.]< columnname >
<br>
<br>See the OnEditButtonClick event for more information.}
  property EditLinks: TIB_StringList read FEditLinks write SetEditLinks;
{: When EditLinksAuto is true then edit link buttons will appear automatically
for all text blob columns.<br>
<br>
ALSO, if you do NOT define an OnEditButtonClick event then the default IBO memo
edit dialog will be presented when the user clicks on the edit button of
a cell - this is true for both text blob columns AND and any other text
column defined in the EditLinks.  This is useful to allow large VARCHAR
fields to be edited in the memo dialog, however this approach is NOT
recommended for fields which must consist of a single-line of text, since the
memo editor will obviously permit the insertion of multiple lines.
(So the solution is to NOT add single line fields to the EditLinks unless
you are going to define your own OnEditButtonClick handler.)<br>
<br>
IMPORTANT: If you define your own OnEditButtonClick event then your code will
override the presentation of the IBO memo edit dialog, in which case you
must take over the function of presenting an edit interface for the user.
You can call the public ShowMemoEditor of the grid from your own handler
if/when appropriate.}
  property EditLinksAuto: boolean read FEditLinksAuto write FEditLinksAuto
                                  default false;
{: This property allows columns to be flagged so that they will be included in
the TabStops[] array even though they are calculated or readonly.
<br>
<br>You make an entry in this property as follows:
<br>
<br>[< tablename >.]< columnname >}
  property TabStopLinks: TIB_StringList read FTabStopLinks
                                        write SetTabStopLinks;
{: This property determins if the grid should behave like a list box.
<br><br>
What this means is that the rightmost column is stretched out so that there is
no wasted space outsode of columns. This is more visually appealing when using
a grid as a listbox.}
  property ListBoxStyle: boolean read FListBoxStyle
                                 write SetListBoxStyle
                                 default false;
{: This property determines if the grid has a vertical scrollbar or not.}
  property NoVertScrollBar: boolean read FNoVertScrollBar
                                    write FNoVertScrollBar
                                    default false;
{ Properties }
{: This property makes the necessary API calls to enable one to drag files from
the explorer/desktop/etc. into an IB_Grid. See the event associated to this
that captured the dropped files and allows you to take action upon them.}
  property AllowDropFiles: boolean read FAllowDropFiles
                                   write SetAllowDropFiles
                                   default false;
{: If this property is true then a Double Click changes the state of a embedded
checkbox.}
 property ToggleOnDblClick: boolean read FToggleOnDblClick
                                   write SetToggleOnDblClick
                                   default false;
{: If this property is true and there are OrderingLinks for the dataset defined
then it is possible to have the grid automatically incremental search for
records by pressing keys.}
  property AllowIncSearch: boolean read FAllowIncSearch
                                   write SetAllowIncSearch
                                   default false;
{: Used in conjunction with built-in incremental searching. This property allows
the search string to automatically timeout and go back to a blank string so that
if the user is starting a new search they don't have to hit ESC first.}
  property AllowTimeout: boolean read FAllowTimeout
                                 write FAllowTimeout
                                 default false;
{: When incremental searching is activated this will cause it to respond to each
individual key press. Otherwise, the user would have to type in the work and
press ENTER for the search string to be searched for.}
  property SearchKeyByKey: boolean read FIncSearchKeyByKey
                                   write FIncSearchKeyByKey
                                   default false;
{: When incremental searching it is possible to tell it to only locate those
records that produce an exact match. If the nearest record is ok, then set this
property to true.}
  property SeekNearest: boolean read FSeekNearest
                                write FSeekNearest
                                default false;
{: This makes it so that a special key to put the grid into incremental search
mode can be configured. This is because it is often a challenge to allow both
editing of data and incremental searching in the same grid without having
conflicts with the keys pressed.}
  property IncSearchHotKey: TShortCut read FIncSearchHotKey
                                      write FIncSearchHotKey
                                      default 0;

{: This makes the editor appear even when editing is not being performed.}
  property AlwaysShowEditor: boolean read GetAlwaysShowEditor
                                     write SetAlwaysShowEditor
                                     default false;
{: The property controls the border style assigned to all editor components
that are dropped on the grid (it has no effect on the
default/InplaceEditor).  If this is not assigned to bsNone then you may
have to alter the RowHeight to give the controls sufficient height to
display the border and the contents. }
  property EditorBorderStyle: TBorderStyle read FEditorBorderStyle
                               write FEditorBorderStyle
                               default bsNone;
{: This property indicated how many extra border rows of cells that should
be placed in the title section of the grid.}
  property BorderRows: integer read FBorderRows
                               write SetBorderRows
                               default 0;
{: This property indicated how many extra border columnss of cells that
should be placed in the title section of the grid.}
  property BorderCols: integer read FBorderCols
                               write SetBorderCols
                               default 0;
{: This property makes the whole selected row appear highlighted or not.}
  property RowSelect: boolean read GetRowSelect
                              write SetRowSelect
                              default false;
{: This property makes the focused cell be painted as though it were also
a selected cell. Normally it would appear as a normal unselected cell.}
  property DrawFocusSelected: boolean read GetDrawFocusSelected
                                      write SetDrawFocusSelected
                                      default false;
{: This property will cause data columns to be included in the Fixed portion
of the grid's cells. Thus, they will always be visible even when the grid is
scrolled back and fourth to show other columns that do not fit in the client
width of the grid.}
  property FixedDataCols: integer read FFixedDataCols write SetFixedDataCols
                                                      default 0;
{: The property allows you to change some of the key-stroke and navigation
behaviour for the grid.  The options can be used individually or together to
achieve the desired grid behaviour.
<br>
<br>    gnF2Edits - when true, F2 will not only make the current cell
editable (EditorMode := true), it will also set the grid datasource to
dssEdit state.
<br>
<br>    gnF2Posts - when true and the grid datasource is in an editing state
then pressing F2 will attempt to Post the current row and turn the cell
EditorMode to false.
<br>
<br>    gnF2ToggleEditor - when true, F2 will toggle the state of
AlwaysShowEditor, changing the EditorMode for all cells instead of just the
current cell.  If gnF2Edits or gnF2Posts are also set to true, then the
AlwaysShowEditor state will following the Editing status of the DataLink.
<br>
<br>    gnBrowseAlwaysNavigate - when true and the grid datasource is not in
and editing state the standard navigation keys (left/right/up/down etc) will
be used to navigate the grid, even when a grid edit control has focus (such
as TIB_ComboBox or the inplace editor if AlwaysShowEditor is true).
Without this, the only to navigate over these controls when they are focused
is with the Tab/Shift-Tab keys - which may have problems if TabMovesOut is
true.
<br>
<br>    gnCtrlNavigate - this is similar to gnBrowseAlwaysNavigate except that
this option causes the grid to intercept Ctrl+[navigate] (left/right/up/down
etc) keys going to a grid edit control, passing these navigate key strokes
to the grid to permit navigation around the grid regardless of the datasource
or grid state.  Note: The ssCtrl flag is removed from before passing to the
grid (so that it will navigate instead of just slide the grid).  If ssShift
is also provided then the ssCtrl flag will be passed to the grid.
<br>
<br>    gnOnEditDoEditClick - If this option is enabled then when the user
activates an InplaceEditor that would normally display an edit button, then the
grid will simulate a click of the edit button.
<br>
<br>This means that, if you have AlwaysShowEditor=true, then when you tab
through the grid the edit buttons will be automatically clicked (presumably
displaying a dialog such as the default memo editor).  For this reason you
may want to combine the selection of this option with gnMemoEditTabExits.
<br>
<br>    gnMemoEditTabExits - This option alters the default grid memo editor.
When set to true, if a user hits Tab in the memo editor it will return a
modal result of mrYes (instead of mrOk).  The grid uses this as an indication
that it should tab to the next cell.  If a user hits Shift+Tab then the
memo editor will return mrNo, in which case the grid will tab to the previous
cell.  If this option is not enabled then the user must exit the dialog
by clicking the OK button (or pressing Enter) which returns mrOk, or by
pressing Escape which returns mrCancel.
<br>
<br>
<br>Notes:
<br>
<br>You will probably NOT want to use gnF2Posts if any column uses the
standard grid InplaceEdit control (ie. only this use when all columns have
a special dropped in edit control).  This is because you will need the F2 key
to enable edit of the InplaceEdit even when AlwaysShowEditor is true.
}
  property NavigateOptions: TIB_Grid_NavOptions read FNavigateOptions
                                                write FNavigateOptions
                                                default [];
{: Reference to the grid's Col that is to be resized in order to maintain
the ListBoxStyle of keeping the column widths just inside the ClientWidth of
the grid.}
  property StretchColNum: integer read FStretchColNum;
{: Reference to the column that is to be resized in order to maintain the
ListBoxStyle of keeping the column widths just inside the ClientWidth of
the grid.}
  property StretchColRef: TIB_Column read FStretchColRef;
{: When using ListBoxStyle it is possible to declare a custom column to be
resized instead of the last one in the list.}
  property StretchColumn: string read FStretchColumn write FStretchColumn;
{: The property makes TAB presses move focus through and out of the grid in a
single row without requiring that all rows be scrolled through first.}
  property TabMovesOut: boolean read FTabMovesOut
                                write FTabMovesOut
                                default false;
{: While the trackbar on the right side is slid up and down the current
record pointer can follow it or wait until the trackbar handle is released.
<br><br>
If this is true then it will follow it.}
  property ThumbTracking: boolean read GetThumbTracking
                                  write SetThumbTracking
                                  default false;
{: Determine the alignment of the grid column title headers. }
  property TitleAlignment: TGTAlignment read FTitleAlignment
                                      write SetTitleAlignment
                                      default gtaLeftJustify;
{: If this property is true then you can scroll up and down through the
dataset without actually moving the record pointer. This works great for
list boxes.}
  property TrackGridRow: boolean read FTrackGridRow
                                 write SetTrackGridRow
                                 default false;
{: This property determins whether or not column can be changed in their
order one to another.}
  property ColMoving: boolean read GetColMoving
                              write SetColMoving
                              default true;
{: This property determins if individual columns can be resized or not.}
  property ColSizing: boolean read GetColSizing
                              write SetColSizing
                              default true;
{: This property makes thin lines appear between each column.}
  property ColLines: boolean read GetColLines
                             write SetColLines
                             default true;
{: This property makes thin lines appear between each row.}
  property RowLines: boolean read GetRowLines
                             write SetRowLines
                             default true;
{: This property makes thin lines appear between each column header.}
  property FixedColLines: boolean read GetFixedColLines
                                  write SetFixedColLines
                                  default true;
{: This property makes thin lines appear between each row header..}
  property FixedRowLines: boolean read GetFixedRowLines
                                  write SetFixedRowLines
                                  default true;
{: This property tells which cell currently has the focus in the grid.}
  property FocusedCell: TGridCoord read FFocusedCell;
{: This property will enable or disable the usage of checkbox glyphs to
interact with a column that has been declared as a BOOLEAN in the
ColumnAttributes property of the dataset.}
  property IndicateBooleans: boolean read FIndicateBooleans
                                     write SetIndicateBooleans
                                     default true;
{: This property is used to determine if the column header will display a
glyph to indicate if the dataset is sorted according to that column. It also
determins whether or not the column that is sorted should be displayed in
the OrderingColor and OrderingFont styles.}
  property IndicateOrdering: boolean read FIndicateOrdering
                                     write SetIndicateOrdering
                                     default true;
{: This property determins whether or not there should be a small column at
the left side of the grid to show what row is the current row. It also
indicates whether the dataset is in dssEdit or dssInsert state.}
  property IndicateRow: boolean read FIndicateRow
                                write SetIndicateRow
                                default true;
{: This property determines the width of the column used to display the row
indicator.}
  property RowIndicatorColWidth: integer read FRowIndicatorColWidth
                                         write SetRowIndicatorColWidth
                                         default 11;
{: This allows the grid to display and participate in the selecting of rows.}
  property IndicateSelected: boolean read FIndicateSelected
                                     write SetIndicateSelected
                                     default true;
{: This allows the grid to display the highlighting of rows.}
  property IndicateHighlight: boolean read FIndicateHighlight
                                      write SetIndicateHighlight
                                      default true;
{: This property determins whether or not the nearest matching record of
an incremental search is shown in the grid without having it become selected.}
  property IndicateNearest: boolean read FIndicateNearest
                                    write FIndicateNearest
                                    default true;
{: This property determins whether or not the column headers should appear
or not.}
  property IndicateTitles: boolean read FIndicateTitles
                                   write SetIndicateTitles
                                   default true;
{: Being phased-out.  Use DrawTitleTextOptions.}
  property IndicateLongTitle: boolean read GetIndicateLongTitle
                                      write SetIndicateLongTitle
                                      default false;
{: Being phased-out.  Use DrawCellTextOptions.}
  property IndicateLongCellText: boolean read GetIndicateLongCellText
                                         write SetIndicateLongCellText
                                         default false;
{: Control how the default drawing of Cell text is performed.}
  property DrawCellTextOptions: TIB_Grid_DrawTextOptions
                                         read FDrawCellTextOptions
                                         write SetDrawCellTextOptions
                                         default [];
{: Control how the default drawing of Title text is performed.}
  property DrawTitleTextOptions: TIB_Grid_DrawTextOptions
                                         read FDrawTitleTextOptions
                                         write SetDrawTitleTextOptions
                                         default [];
{: Color of the current row.}
  property CurrentRowColor: TColor read FCurrentRowColor
                                   write SetCurrentRowColor
                                   default clWindow;
{: Font of the current row.}
  property CurrentRowFont: TFont read FCurrentRowFont
                                 write SetCurrentRowFont
                                 stored IsGridFontStored;
{: This property determins the color the column should be if it is the
current column that the dataset is ordered by.
<br><br>
IndicateOrdering must be true for this to have any effect.}
  property OrderingColor: TColor read FOrderingColor
                                 write SetOrderingColor
                                 default clWindow;
{: This property determins the font of the text for the column that the
dataset is currently ordered by.
<br><br>
IndicateOrdering must be true for this to have any effect.}
  property OrderingFont: TFont read FOrderingFont
                               write SetOrderingFont
                               stored IsGridFontStored;
{: Font of the text in the title and border of the grid.}
  property FixedFont: TFont read FFixedFont
                            write SetFixedFont
                            stored IsGridFontStored;
{: This controls the depth of the 3D appearance of the fixed and border cells.}
  property Ctl3DShallow: boolean read FCtl3DShallow
                                 write SetCtl3DShallow
                                 default false;
{ Events }

{: This event is triggered as soon as a new cell is to gain the focus.
<br><br>
However, the exact position it will be bainted in is not known at this time.
<br><br>
Use the OnDrawFocusedCell in order to overlay a control on top of the focused
cell of the grid.}
  property OnCellGainFocus: TIB_CustomGridCellEvent read FOnCellGainFocus
                                                    write FOnCellGainFocus;
{: This event is triggered as soon as a new cell is about to become focused.}
  property OnCellLoseFocus: TIB_CustomGridCellEvent read FOnCellLoseFocus
                                                    write FOnCellLoseFocus;
{:
This method allows you to override the color of a cell.
<br><br>
It will also be applied to the inplace editor.
<br><br>
Please be sure to check if the associated dataset is prepared or not before
trying to access fields information. I purposely do not prevent the generation
of this event even if the dataset is unprepared because I want the developer
to have full control over the color of the grid.
<br><br>
<br><br>
This method allows you to override the font of a cell.
<br><br>
It will also be applied to the inplace editor.
<br><br>
Please be sure to check if the associated dataset is prepared or not before
trying to access fields information. I purposely do not prevent the generation
of this event even if the dataset is unprepared because I want the developer
to have full control over the fonts of the grid.}
  property OnGetCellProps: TIB_GetCellPropsEvent read FOnGetCellProps
                                                 write FOnGetCellProps;
{: This property is used to customize the text that is displayed in the cell.
<br><br>
Please be sure to check if the associated dataset is prepared or not before
trying to access fields information. I purposely do not prevent the generation
of this event even if the dataset is unprepared because I want the developer
to have full control over the text of the grid.}
  property OnGetDisplayText: TIB_GetDisplayTextEvent read FOnGetDisplayText
                                                     write FOnGetDisplayText;
{: Event to allow customization of key press processing.}
  property OnIsValidChar: TIB_IsValidCharEvent read FOnIsValidChar
                                               write FOnIsValidChar;
{: If EditingLinks has been set up properly then there should be a small
button appear in the cell of a corresponding column. If this button is
clicked on then this event gets triggered. So, in the code for this event you
may handle what ever action you want performed for the button click.
<br><br>
If a dialog is brought forward it would be a good idea to have it modal.}
  property OnEditButtonClick: TNotifyEvent read FOnEditButtonClick
                                           write FOnEditButtonClick;
{: This event is used to provide custom incsearch handling.}
  property OnIncSearch: TIB_OnIncSearch read FOnIncSearch
                                           write FOnIncSearch;
{: This event allows you to provide a custom painting method to paint the
grid cell that is currently needing to be repainted.}
  property OnDrawCell: TDrawCellEvent read FOnDrawCell
                                      write FOnDrawCell;
{: This event allows you to provide a custom painting method to paint the
grid cell that is currently focused.
<br><br>
This can also be used to place controls above the grid for customized editors.}
  property OnDrawFocusedCell: TDrawCellEvent read FOnDrawFocusedCell
                                             write FOnDrawFocusedCell;
{: This event allows you to provide a custom painting method to paint the
title cell that is currently needing to be repainted.}
  property OnDrawTitle: TDrawCellEvent read FOnDrawTitle
                                       write FOnDrawTitle;
{: This event allows you to provide a custom painting method to paint the
border cell that is currently needing to be repainted.}
  property OnDrawBorder: TDrawCellEvent read FOnDrawBorder
                                        write FOnDrawBorder;
{: This event is used to give the name of the files dropped.}
  property OnDropFiles: TIB_DropFilesEvent read FOnDropFiles write FOnDropFiles;
{: Gets the edit mask that should be used by the inplace editor.}
  property OnGetEditMask: TGetEditEvent read FOnGetEditMask
                                        write FOnGetEditMask;
{: Gets the text that should be used for editing by the inplace editor.}
  property OnGetEditText: TGetEditEvent read FOnGetEditText
                                        write FOnGetEditText;
{: Sets the text that was used by the inplace editor before it is assigned
back to the field.}
  property OnSetEditText: TSetEditEvent read FOnSetEditText
                                        write FOnSetEditText;
{: Event that is triggered when the top left corner of the grid is changed.}
  property OnTopLeftChanged: TNotifyEvent read FOnTopLeftChanged
                                          write FOnTopLeftChanged;
{: When any grid data cell is clicked on this event will be triggered.}
  property OnCellClick: TIB_CustomGridCellClickEvent read FOnCellClick
                                                     write FOnCellClick;
{: When any grid data cell is doubleclicked on this event will be triggered.}
  property OnCellDblClick: TIB_CustomGridCellClickEvent read FOnCellDblClick
                                                     write FOnCellDblClick;

{: When the title row is clicked on this event will be triggered.}
  property OnTitleClick: TIB_CustomGridCellClickEvent read FOnTitleClick
                                                      write FOnTitleClick;
{: When the Border row is clicked on this event will be triggered.}
  property OnBorderClick: TIB_CustomGridCellClickEvent read FOnBorderClick
                                                       write FOnBorderClick;
{: Event to customize or validate the text being assigned to the
SelectedField for the current row and col.}
  property OnSetColumnText: TIB_SetColumnTextEvent read FOnSetColumnText
                                                   write FOnSetColumnText;

public

  FMarkSelStart: longint;
  FMarkSelEnd: longint;
  FIgnoreKeypress: boolean;

{$IFNDEF HELPSCAN}
  FDrawingCustomGlyph: Boolean;
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
{$ENDIF}

{ Methods }

{ start changes by helmut}
  procedure MarkSelectionEnd;
  procedure UnMarkSelection; virtual;
{ end changes by helmut}

{: This method can be used to get the default text when painting a cell.}
  function GetCellDisplayText( ACol, ARow: Longint ): string; virtual;
{: This method can be used to get the default color and font when painting a
cell.
<br><br>
Do NOT call this from OnGetCellProps since an infinite loop would result.}
  procedure GetCellProps(       ACol, ARow: Longint;
                                AState: TGridDrawState;
                            var AColor: TColor;
                                AFont: TFont ); virtual;
  function GetTitleAlignment( ACol,ARow: Longint): TAlignment; virtual;
{: This method can be used to get the default text alignment when painting
a cell.}
  function GetCellAlignment( ACol, ARow: Longint): TAlignment; virtual;
{: Default method to handle the drawing of the data cells.
<br><br>
This can be called from the OnDrawCell event to handle cells that need no
specific painting performed.}
  procedure DefaultDrawCell( ACol, ARow: Longint;
                             ARect: TRect;
                             AState: TGridDrawState;
                             CellDisplayText: string;
                             CellAlignment: TAlignment ); virtual;
{: Default method to handle the drawing of the focused cell.}
  procedure DefaultDrawFocusedCell( ACol, ARow: Longint;
                                    ARect: TRect;
                                    AState: TGridDrawState;
                                    CellDisplayText: string;
                                    CellAlignment: TAlignment ); virtual;
{: Default method to handle the drawing of the title row cells.
<br><br>
This can be called from the OnDrawTitle event to handle cells that need no
specific painting performed.}
  procedure DefaultDrawTitle( ACol, ARow: Longint;
                              ARect: TRect;
                              AState: TGridDrawState;
                              CellDisplayText: string;
                              CellAlignment: TAlignment ); virtual;
{: Returns the height necessary in order to have a certain number of rows.}
  function HeightForGridRows( ItemCount: integer;
                              HorizScrollBar: boolean ): integer;
{: }
  procedure Invalidate; override;
{: }
  procedure InvalidateRow( ARow: longint; IsCurrRow: boolean );
{: }
  procedure InvalidateCol( ACol: longint; IsCurrRow: boolean );
{: Adjust which column has the focus.}
  procedure MoveCol( RawCol, Direction: integer );
{: Returns the width necessary in order to display all columns.}
  function WidthForAllCols: integer;
{: Returns the number of visible GridRows.}
  function VisibleGridRows: longint;
{: This procedure adjusts the columns widths so that they all will fit within
the current width of the grid.}
  procedure StretchGridColumns;
{: You can use this procedure to call the memo editor (dialog with TIB_Memo)
for the currently selected field.  Note that this procedure does not check
whether it makes sense to use the memo editor, this is upto the developer.
The general attributes of the memo control (datasource, selected field,
color and readonly details) are set from the grid.  See also EditLinksAuto.}
  procedure ShowMemoEditor; virtual;
{: Getting directly the desired GridLinks item's width.}
  function GetGridLinksWidth( ii: Integer ): string;
{: Setting directly the desired GridLinks item's width.
The item should exist previously.}
  procedure SetGridLinksWidth( ii: Integer; v: string );
{: Getting directly the desired GridLinks item's alignment.}
  function GetGridLinksAlign( ii: Integer ): string;
{: Setting directly the desired GridLinks item's alignment.
The item should exist previously.}
  procedure SetGridLinksAlign( ii: Integer; v: string );

{ Properties }

{: By default IB_Grid does not permit the session to flicker the cursor when
doing simple record navigations. But, if the dataset is a master dataset then
it is possible for even the simplest operation to have a performance impact.
So, at run-time set this property to false so that the screen cursor will always
get triggered for all dataset navigation operations.
<br><br>
I plan to make it automatically detect that it is a master dataset and avoid
having to tweak this property.}
  property AllowLockSession: boolean read FAllowLockSession
                                     write FAllowLockSession;
{: First column that can be tabbed to or -1 if none.}
  property FirstTabCol: integer read FFirstTabCol;
{: last column that can be tabbed to or -1.}
  property LastTabCol: integer read FLastTabCol;
{: WIP}
  property IncSearchState: boolean read FIncSearchState;
{: WIP}
  property IncSearchText: string read FIncSearchText;
{: Check the state of this read-only flag in the OnEditButtonClick event
to see if the event was caused by automatic processing due to having
enabled the gnOnEditDoEditClick (in NavigateOptions).  If the flag
is false then the event was generated by the normal user action of clicking
on the displayed edit button, or pressing Alt+Down (or Ctrl+Enter) while the
inplace editor was already active.<br>
<br>
You may use this when most of your editlinks are for memos that you
want automatically enabled (so you set gnOnEditDoEditClick=true), but perhaps
you have one column which would normally be edited directly by the
inplace editor that also has an optional edit button.  In the instance
of that column you could use the EditLinkAutoClicked flag to prevent
the simulated click of the edit button.}
  property EditLinkAutoClicked: boolean read FEditLinkAutoClicked;
{: Index to the TIB_Column objects for each column in the grid.}
  property BuffFields[ Index: integer ]: TIB_Column read GetBuffFields;
{: Index to the TIB_Column objects for each column in the grid.}
  property GridFields[ Index: integer ]: TIB_Column read GetGridFields;
{: Number of data columns in the grid.}
  property GridFieldCount: integer read GetGridFieldCount;
{: Number of fixed columns before the data columns.}
  property FixedCols: integer read GetFixedCols;
{: Number of Fixed rows before the data rows.}
  property FixedRows: integer read GetFixedRows;
{: The currently selected TIB_Column for the grid cell.}
  property SelectedField: TIB_Column read GetSelectedField;
{: Tells if the grid is currently busy adjusting various internal layouts.}
  property InGridLayout: boolean read GetInGridLayout;
{: Pass in as input the Row of the grid and the RowNum of the dataset will
be returned.}
  property DataRow[ Index: integer ]: integer read GetDataRow;
{: Pass in as input the RowNum of the dataset and the Row of the grid will
be returned.}
  property GridRow[ Index: integer ]: integer read GetGridRow;
{: Get the column index of the dataset from the column of the grid.}
  property DataCol[ Index: integer ]: integer read GetDataCol;
{: Get the column of the grid from the column index of the dataset.}
  property GridCol[ Index: integer ]: integer read GetGridCol;
{: Tells where the mouse went down in pixels.}
  property MouseDownPoint: TPoint read FMouseDownPoint;
{: Gives control over the height of the border cells.}
  property BorderRowHeight[ Index: integer ]: integer
      read GetBorderRowHeight
      write SetBorderRowHeight;
{: Gives control over the width of the border cells.}
  property BorderColWidth[ Index: integer ]: integer
      read GetBorderColWidth
     write SetBorderColWidth;
{: First grid row to appear below the fixed rows.}
  property TopRowNum: longint read FTopRowNum write SetTopRowNum;
{: Read-only access to the Options property from the inherited TCustomGrid
class.}
  property Options: TGridOptions read GetOptions;
  property OnColEnter: TNotifyEvent read FOnColEnter write FOnColEnter;
  property OnColExit: TNotifyEvent read FOnColExit write FOnColExit;
published
  property CustomGlyphs: TImageList read FCustomGlyphs write SetCustomGlyphs;
  property CustomGlyphsSupplied: TIB_Grid_GlyphSet read FCustomGlyphsSupplied
                                                  write SetCustomGlyphsSupplied;
{: This property will avoid the default methods for drawing a cell
and a focused cell to be called before the respective custom events.
<br>Use with care or you will see empty cells! Turn it False only if you are
sure you provided at least a handler for OnDrawCell. Only the in-place editor
will be drawn automatically if necessary.}
  property DefDrawBefore: Boolean read FDefDrawBefore
                                  write FDefDrawBefore
                                  default True;
end;

{: This grid has been designed to work with the IB_Query dataset only.
<br><br>
Please see its ancestor's listing of properties, methods and events for more
detailed information on how to use this component. This class is
TIB_CustomGrid.}
TIB_Grid = class(TIB_CustomGrid)
{$IFNDEF HELPSCAN}
{$I IB_Grid.PBL}
{$ENDIF}
end;

{$Define IBG_LookupCombo}

{                                                                              }
{ TIB_LookupCombo                                                              }
{                                                                              }

TIB_PopupAlignment = ( puAuto, puLeft, puRight, puCentered,
                       puParentLeft, puParentRight, puParentCentered );

TIB_DropDownAlign = ( daaLeft, daaCentered, daaRight );

TIB_LookupComboLink = class( TIB_ControlDataLink )
public
  procedure FocusControl( AField: TIB_ColumnRef ); override;
end;

{: This control is used to provide an easy way for users to define cross
dataset relationships. All of the handling of the key values is done in the
dataset behind the scenes.
<br><br>
This control takes a significantly different approach than other lookup
controls. This is because most of the dataset to dataset relationship
handling is built in to the dataset class itself.
<br><br>
The relationship is defined using the KeyLinks and KeySource properties.
Please refer to these for more assistance.
<br><br>
As long as the DisplayField property is the same as the OrderingLink of the
lookup dataset it will be possible to use incremental searching.
<br><br>
It is case sensitive by default but if the column the lookup dataset is
currently ordered by has a NOCASE entry in the column attributes then the
incremental searching will be made case insensitive for you automatically.
<br><br>
It is also
possible to leave the DisplayField property blank and have it automatically
display the OrderingLink value. Thus, if there are multiple columns defined
in the OrderingLinks property of the lookup dataset and the popup list allows
the OrderingItemNo to be changed by clicking on the title of the popup list
the control will then display the value from newly ordered column.
<br><br>
Thus, by leaving the DisplayField property blank and only allowing the
ordering of the lookup dataset to be done with a valid OrderingLink a very
flexible and functional control is realized.
<br><br>
Keep in mind that this control will work even with very large datasets. In
order to do this though it is necessary to tune the OrderingLinks property
for the lookup dataset. I have used it on a query against a table of 100K
rows+ over a modem at 28K with acceptable performance.
<br><br>
There is a sample application for this control as well as defining KeyLinks.}

TIB_CustomCombo = class(TCustomEdit, IIB_GridWinControl)
{$DEFINE IB_AutoLabel}
{$I IB_WinControl.INT}
{$UNDEF IB_AutoLabel}
private
  FDisplayField: string;
  FCanvas: TControlCanvas;
  FClearSelectionOnExit:Boolean;
  FDropDownCount: integer;
  FDropDownWidth: integer;
  FCanDropDown: boolean;
  FDefaultPopupList: TIB_CustomGrid;
  FCustomPopup: TIB_CustomGrid;
  FButton: TSpeedButton;
  FBtnControl: TWinControl;
  FSearchText: string;
  FSearchLevel: integer;
  FSearchKeyByKey: boolean;
  FSeekNearest: boolean;
  FAllowTimeout: boolean;
  FAutoDropDown: boolean;
  FOnSelectionCleared: TNotifyEvent;
  FOnCloseUp: TNotifyEvent;
  FOnGetDisplayText:TIB_GetDisplayTextEvent;
  FOnDropDown: TNotifyEvent;
  FOnNotInList: TNotifyEvent;
  FPopupAlignment: TIB_PopupAlignment;
  FPopupColor: TColor;
  FPopupFixedColor: TColor;
  function GetDropDownAlign: TIB_DropDownAlign;
  procedure SetDropDownAlign( AValue: TIB_DropDownAlign );
  function GetIndicateOrdering: boolean;
  procedure SetIndicateOrdering( AValue: boolean );
  function GetIndicateTitles: boolean;
  procedure SetIndicateTitles( AValue: boolean );
  function GetIndicateSelected: boolean;
  procedure SetIndicateSelected( AValue: boolean );
  function GetIndicateRow: boolean;
  procedure SetIndicateRow( AValue: boolean );
  function GetIsDroppedDown: boolean;
  function GetColLines: boolean;
  procedure SetColLines( AValue: boolean );
  function GetRowLines: boolean;
  procedure SetRowLines( AValue: boolean );
  function GetFixedColLines: boolean;
  procedure SetFixedColLines( AValue: boolean );
  function GetFixedRowLines: boolean;
  procedure SetFixedRowLines( AValue: boolean );
  function GetDefaultRowHeight: integer;
  procedure SetDefaultRowHeight( AValue: integer );
  procedure SetDisplayField(const Value: string);
  function GetGridLinks: TIB_StringList;
  procedure SetGridLinks( AValue: TIB_StringList );
  procedure SetOnGetDisplayText( AValue: TIB_GetDisplayTextEvent);
  procedure NonEditMouseDown(var Message: TWMLButtonDown; IsDblClick: boolean );
  procedure SetEditRect;
  procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
  procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
  procedure WMSize(var Message: TWMSize); message WM_SIZE;
  procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
  procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
  procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
  procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
  procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GetDlgCode;
  procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
  procedure SetShowButton( AValue: boolean );
  function GetShowButton: boolean;
protected
  procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  procedure KeyPress(var Key: Char); override;
  procedure CreateParams(var Params: TCreateParams); override;
  procedure CreateWnd; override;
  procedure Loaded; override;
  function GetPopupList: TIB_CustomGrid; virtual;
  procedure SetCustomPopup( AValue: TIB_CustomGrid ); virtual;
  procedure DoDropDown; virtual;
  procedure DoNotInList; virtual;
  procedure DoIncSearchKeyPress( var Key: char ); virtual;

  // Implemented for IIB_GridWinControl - but generically for consistency
  // with other controls.
  procedure BoundsChanged;
  property ShowButton: boolean read getShowButton write setShowButton;
  // Implementation of IIB_GridWinControl interface requirements
  // These are already defined
  //   procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
  //   procedure BoundsChanged;
  //   function CanFocus: boolean;
  //   procedure SetFocus;
  //   procedure Invalidate;
  // These functions need to be defined - which I will do via
  // functions named IBG_* and redirect...
  function IIB_GridWinControl.DisplayColumn = IBG_DisplayColumn;
  function IIB_GridWinControl.GetText = IBG_GetText;
  function IIB_GridWinControl.TranslateText = IBG_TranslateText;
  function IIB_GridWinControl.HasActiveChild = IBG_HasActiveChild;
  procedure IIB_GridWinControl.SetBorderStyle = IBG_SetBorderStyle;
  function IIB_GridWinControl.GetFont = IBG_GetFont;
  procedure IIB_GridWinControl.SetFont = IBG_SetFont;
  procedure IIB_GridWinControl.SetColor = IBG_SetColor;
  procedure IIB_GridWinControl.SetVisible = IBG_SetVisible;
  function IIB_GridWinControl.GetAutoLabel = IBG_GetAutoLabel;
  function IBG_DisplayColumn: TObject;
  function IBG_GetText: string;
  function IBG_TranslateText(AVal: string): string;
  function IBG_HasActiveChild: boolean;
  procedure IBG_SetBorderStyle( AVal: TBorderStyle );
  function IBG_GetFont: TFont;
  procedure IBG_SetFont( const AFont: TFont );
  procedure IBG_SetColor( AColor: TColor );
  procedure IBG_SetVisible( AVal: boolean );
  function IBG_GetAutoLabel: TObject;
public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
{: Method to cause the popup list to drop down.}
  procedure DropDown; dynamic;
{: Method to cause the popup list to close up.}
  procedure CloseUp; dynamic;
{: Method to make the LookupCombo display empty in the same way as if the
user pressed the DEL key with the control focused.}
  procedure ClearSelection( SetNull: boolean ); dynamic;
{: Property to tell if the popup listbox is visible or not.}
  property IsDroppedDown: boolean read GetIsDroppedDown;
{: Direct reference to the popup list being used. This is either the default
list or the custom popup list if one is provided.
<br><br>
This can be used to manipulate the settings and appearance of the default
popup list by writing code to alter it.}
  property PopupList: TIB_CustomGrid read GetPopupList;
{: The text that has been typed in for performing incremental searching on.}
  property SearchText: string read FSearchText;
{: Property which gives additional control over whether or not the popup list
drops down.}
  property CanDropDown: boolean read FCanDropDown write FCanDropDown;
{: Colorwhich gets applied to the default popup list that is used internally.}
  property PopupColor: TColor read FPopupColor
                              write FPopupColor
                              default clWindow;
{: Property to preset the color of the fixed fields in the default PopupList}
  property PopupFixedColor: TColor read FPopupFixedColor
                                   write FPopupFixedColor
                                   default clBtnFace;
{: Property to align the PopupList
<UL>
<LI>puAuto      : = puLeft if enough place to display completely
                         else = puParentRight
<LI>puLeft      : PopupList always left aligned to the Combobox
<LI>puRight     : PopupList always right aligned to the Combobox
<LI>puCentered  : PopupList always vertically centered to the Combobox
<LI>puParentLeft : PopupList always left aligned to Parent.Combobox
<LI>puParentRight : PopupList always right aligned to Parent.Combobox
<LI>puParentCentered : PopupList always vertically centered to Parent.Combobox
</UL>}
  property PopupAlignment: TIB_PopupAlignment read FPopupAlignment
                                              write FPopupAlignment
                                              default puAuto;
public

{: This property determins if the incremental search string will time out
after a certain period of time defined by the dataset.}
  property AllowTimeout: boolean read FAllowTimeout
                                 write FAllowTimeout
                                 default true;
{: This property causes the grid to automatically drop down when search
criteria is being entered.}
  property AutoDropDown: boolean read FAutoDropDown
                                 write FAutoDropDown
                                 default false;

{: Property access to the popuplist.
<br><br>
See help for IB_CustomGrid for more information.}
  property ColLines: boolean read GetColLines write SetColLines default false;

{: This property allows a separate TIB_LookupList component to be used
instead of the default popup list.
<br><br>
All of the properties and events from the
alternate popup list will remain in effect. It will simply become the
popup list when the combo box is dropped down.
<br><br>
Thus, you can take complete control over how this popup list is displayed and
interacted with.
<br><br>
NOTE: A TIB_CustomGrid can only be used by one IB_LookupCombo at a time. So,
you will need to have a separate TIB_Custom grid derivitave for each lookup
combo box that you want a custom popup list for.}
  property CustomPopup: TIB_CustomGrid read FCustomPopup
                                       write SetCustomPopup;
{: Clear the selection on field exit.
<br><br>
When you type into the LookupCombo, the then exit.  Then return,
<br><br>
False=the cursor will position to the place you left unless it has timed out.
<br><br>
True=the cursor will position to start of LookupCombo.
<br><br>
You may want to Set AllowTimeout=False when setting ClearSelectionOnExit=True.}
  property ClearSelectionOnExit: Boolean read FClearSelectionOnExit
                                  write FClearSelectionOnExit
                                  default False;
{: Property access to the popuplist.
<br><br>
See help for IB_CustomGrid for more information.}
  property DefaultRowHeight: integer read GetDefaultRowHeight
                                     write SetDefaultRowHeight
                                     default G_DefaultRowHeight;
{: The field that is to be displayed in the edit portion of the control.
<br><br>
If this is left blank then the OrderingLink column will be used instead.}
  property DisplayField: string read FDisplayField write SetDisplayField;

{: Number of rows in the popup list when dropped down.
<br><br>
IF there are fewer records then only those records will be shown in the list.}
  property DropDownCount: Integer read FDropDownCount
                                  write FDropDownCount
                                  default 7;
{: Width in pixels of the popup list when dropped down.}
  property DropDownWidth: Integer read FDropDownWidth
                                  write FDropDownWidth
                                  default 0;
{: This property is obsolete. Please refer to the PopupAlignment property.}
  property DropDownAlign: TIB_DropDownAlign read GetDropDownAlign
                                            write SetDropDownAlign
                                            stored false;
{: Property access to the popuplist.
<br><br>
See help for IB_CustomGrid for more information.}
  property FixedColLines: boolean read GetFixedColLines
                                  write SetFixedColLines
                                  default true;
{: Property access to the popuplist.
<br><br>
See help for IB_CustomGrid for more information.}
  property FixedRowLines: boolean read GetFixedRowLines
                                  write SetFixedRowLines
                                  default true;

{: This allows a custom list of columns to appear in the default popup list.}
  property GridLinks: TIB_StringList read GetGridLinks write SetGridLinks;

{: Property access to the popuplist.
<br><br>
See help for IB_CustomGrid for more information.}
  property IndicateOrdering: boolean read GetIndicateOrdering
                                     write SetIndicateOrdering
                                     default true;
{: Property access to the popuplist.
<br><br>
See help for IB_CustomGrid for more information.}
  property IndicateRow: boolean read GetIndicateRow
                                write SetIndicateRow
                                default false;
{: Property access to the popuplist.
<br><br>
See help for IB_CustomGrid for more information.}
  property IndicateSelected: boolean read GetIndicateSelected
                                     write SetIndicateSelected
                                     default false;
{: Property access to the popuplist.
<br><br>
See help for IB_CustomGrid for more information.}
  property IndicateTitles: boolean read GetIndicateTitles
                                   write SetIndicateTitles
                                   default false;
{: Property access to the popuplist.
<br><br>
See help for IB_CustomGrid for more information.}
  property RowLines: boolean read GetRowLines write SetRowLines default false;
{: When searching is being performed against a text based column it is
possible to have the search begin operating a character at a time as they are
pressed.
<br><br>
Using the callback mechanism of IB Objects, each character that is typed can
be received during the searching process. Thus, the searching process can be
refined even while in the middle of a search from previous characters.
<br><br>
Otherwise, ENTER must be pressed in order to initiate the search process.}
  property SearchKeyByKey: boolean read FSearchKeyByKey
                                   write FSearchKeyByKey
                                   default true;
{: Determines if the nearest record should be selected as the current record
or not. Even if this is false the IB_Grid is designed to show the nearest
matching record without actually selecting it.}
  property SeekNearest: boolean read FSeekNearest
                                write FSeekNearest
                                default false;
{: This event is triggered after the LookupCombo's value is cleared,
which occurs when the user presses the DEL key or when the developer
calls the ClearSelection method.}
  property OnSelectionCleared: TNotifyEvent read FOnSelectionCleared
                                            write FOnSelectionCleared;
{: This event is triggered whenever the popuplist is being closed up.}
  property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
{: This event allows a custom action to be taken prior to the dropping down
of the popuplist.
<br><br>
It is possible to take an entirely different action like bring up a modal
dialog and then when done call the silent exception. In this way you can
make additional customizations to the behavior of this control.}
  property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
{: This property is used to take action on an item that was not found in the
lookup dataset. It will be triggered if ENTER is pressed and no matching
record exists for the current search criteria.}
  property OnNotInList: TNotifyEvent read FOnNotInList write FOnNotInList;

{: Same as in TIB_Grid }
  property OnGetDisplayText: TIB_GetDisplayTextEvent read FOnGetDisplayText
                                                     write SetOnGetDisplayText;

end;

{ TIB_ComboButton }

TIB_ComboButton = class(TSpeedButton)
protected
  procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer); override;
end;

{: Published class of the underlying custom class.}
TIB_LookupCombo = class(TIB_CustomCombo)
{$DEFINE IB_AutoLabel}
{$I IB_WinControl.PBL}
{$UNDEF IB_AutoLabel}
published
{$IFNDEF HELPSCAN}
property AllowTimeout;
property AutoDropDown;
property AutoSelect;
property ColLines;
property CustomPopup;
property ClearSelectionOnExit;
property DefaultRowHeight;
property DisplayField;
property DropDownCount;
property DropDownWidth;
property DropDownAlign;
property FixedColLines;
property FixedRowLines;
property GridLinks;
property IndicateOrdering;
property IndicateRow;
property IndicateSelected;
property IndicateTitles;
property RowLines;
property SearchKeyByKey;
property SeekNearest;
property OnChange;
property OnCloseUp;
property OnDropDown;
property OnNotInList;
property OnSelectionCleared;
property PopupAlignment;
property PopupColor;
property PopupFixedColor;
property OnGetDisplayText;
property ShowButton;
{$ENDIF}
end;

{$UnDef IBG_LookupCombo}

{$Define IBG_LookupList}

{: This control is really nothing more than a TIB_Grid except that some of
the defaults for the properties have been set to what would be more typical
of a lookup list control.
<br><br>
As explained in the TIB_LookupCombo description, the lookup relationship is
defined at the dataset level using the KeyLinks and KeySource properties.
<br><br>
Please refer to these two descriptions for furthur information.
<br><br>
Please refer to the class TIB_CustomGrid for descriptions of all the
properties, methods and event of this control.
<br><br>
Here is a list of the default property values that are different:
<br><br>
<br>  property DefaultRowHeight default G_DefaultRowHeight;
<br>  property ScrollBars default ssVertical;
<br>  property RowSelect default true;
<br>  property TrackGridRow default true;
<br>  property ListBoxStyle default true;
<br>  property RowLines default false;
<br>  property ColLines default false;
<br>  property IndicateRow default false;
<br>  property IndicateSelected default false;
<br>  property IndicateTitles default false;}
TIB_LookupList = class(TIB_CustomGrid)
private
  procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
public
  constructor Create(AOwner: TComponent); override;
{$IFNDEF HELPSCAN}
{$I IB_Grid.PBL}
{$ENDIF}
end;

{$UnDef IBG_LookupList}

{$IFNDEF HELPSCAN}
var
  FBooleanIndicators: TImageList;
  FRowIndicators: TImageList;
  FOrderingIndicators: TImageList;
  MessageRequeueTimer: TScrollFixTimer;
{$ENDIF}

implementation

{$R IB_Grid.RES}

uses
  IB_Parse, IB_Utils, Mask, IBD_IBMemoEdit;

var
  DrawBitmap: TBitmap;
  UserCount: Integer;

procedure UsesBitmap;
begin
  if UserCount = 0 then
    DrawBitmap := TBitmap.Create;
  Inc(UserCount);
end;

procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then
  begin
    DrawBitmap.Free;
    DrawBitmap := nil;
  end;
end;

function Max(X, Y: Integer): Integer;
begin
  Result := Y;
  if X > Y then Result := X;
end;

procedure WriteText(       ACanvas: TCanvas;
                           ARect: TRect;
                           DX, DY: Integer;
                     const Text: string;
                           Alignment: TAlignment);
const
  AlignFlags : array [TAlignment] of Integer =
 ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX or DT_SINGLELINE,
   DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX or DT_SINGLELINE,
   DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX or DT_SINGLELINE );
    AdjRect : array[TAlignment] of Integer = (1, 3, 1);
var
  B, R: TRect;
  I: longint;
  Left: Integer;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if longint(GetNearestColor(ACanvas.Handle, I)) = longint(I) then
  begin
  { Use ExtTextOut for solid colors }
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - AdjRect[Alignment];
    else { taCenter }
      Left := ARect.Left + ( ARect.Right - ARect.Left ) shr 1 -
                             ACanvas.TextWidth( Text ) shr 1;
    end;
    ExtTextOut( ACanvas.Handle,
                Left,
                ARect.Top + DY,
                ETO_OPAQUE or ETO_CLIPPED,
                @ARect,
                PChar(Text),
                Length(Text),
                nil );
  end
  else
  begin
  { Use FillRect and Drawtext for dithered colors }
  { Use offscreen bitmap to eliminate flicker and }
  { brush origin tics in painting / scrolling.    }
    with DrawBitmap, ARect do
    begin
      Width := Max( Width, Right - Left );
      Height := Max( Height, Bottom - Top );
      R := Rect( DX, DY, Right - Left - AdjRect[Alignment], Bottom - Top - 1 );
      B := Rect( 0, 0, Right - Left, Bottom - Top );
    end;
    with DrawBitmap.Canvas do
    begin
      Font := ACanvas.Font;
      Font.Color := ACanvas.Font.Color;
      Brush := ACanvas.Brush;
      Brush.Style := bsSolid;
      FillRect(B);
      SetBkMode(Handle, TRANSPARENT);
      DrawText( Handle, PChar(Text), Length(Text), R, AlignFlags[Alignment] );
    end;
    ACanvas.CopyRect( ARect, DrawBitmap.Canvas, B );
  end;
end;

procedure FilImages;
var
  B: TBitmap;
begin
  B := TBitmap.Create;
  try
    B.LoadFromResourceName( HInstance, 'IB_GRID_CHECKED' );
    FBooleanIndicators := TImageList.CreateSize( B.Width, B.Height );
    with FBooleanIndicators do
    begin
      AddMasked( B, clYellow );
      B.LoadFromResourceName( HInstance, 'IB_GRID_UNCHECKED' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_GRAYED' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_RO_CHECKED' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_RO_UNCHECKED' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_RO_NULL' );
      AddMasked( B, clYellow);
  //  AddMasked( IB_GRID_RO_GRAYED'), clYellow);
    end;
    B.LoadFromResourceName( HInstance, 'IB_GRID_ARROW');
    FRowIndicators := TImageList.CreateSize( B.Width,  B.Height );
    with FRowIndicators do begin
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_EDIT' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_INSERT' );
      AddMasked( B, clYellow);
    end;
    B.LoadFromResourceName( HInstance, 'IB_GRID_UP_SORTABLE' );
    FOrderingIndicators := TImageList.CreateSize( B.Width, B.Height );
    with FOrderingIndicators do begin
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_DOWN_SORTABLE' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_BI_SORTABLE' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_NATURAL_SORTABLE' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_UP' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_DOWN' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_BI_UP' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_BI_DOWN' );
      AddMasked( B, clYellow);
      B.LoadFromResourceName( HInstance, 'IB_GRID_NATURAL' );
      AddMasked( B, clYellow);
    end;
  finally
    B.Free;
  end;
end;

constructor TIB_CustomGridLink.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FIsGridLink := true;
end;

procedure TIB_CustomGridLink.ProcessGridEvent( AEvent: TIB_StatementEventType;
                                               Info: longint );
begin
  if FIB_Grid <> nil then
    FIB_Grid.ProcessStatementEvent( AEvent, Info );
end;

procedure TIB_CustomGridLink.SysStateChanged;
begin
  inherited SysStateChanged;
  if FIB_Grid <> nil then
    if Assigned( FIB_Grid.ParentCombo ) and Assigned( Dataset ) then
      FIB_Grid.ParentCombo.DataLink.DataSource := Dataset.KeySource;
end;

function TIB_CustomGridLink.GetBDataset: TIB_BDataset;
begin
  if Dataset is TIB_BDataset then
    Result := Dataset as TIB_BDataset
  else
    Result := nil;
end;

constructor TIB_GridInplaceEdit.Create( Owner: TComponent );
begin
  inherited Create( Owner );
  FButtonWidth := GetSystemMetrics( SM_CXVSCROLL );
  FEditStyle := esNormal;
end;

// I am using the WM_USER msg to send a command through to
// this control so tell it to click the edit button.  Should be safe
// enough as the message is always directed specifically to the
// handle for the control.  The message parameters define the grid
// col/row at the time the message was sent.  This is used to
// verify that the same cell is still selected when we get to process
// the message (since it was "Posted" other actions may have taken
// place which have changed the selected cell).
procedure TIB_GridInplaceEdit.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_USER:
    begin
      if Focused then
        with Owner as TIB_CustomGrid do
        begin
          if (Col = Message.WParam) and (Row = Message.LParam) and
             (not FEditLinkAutoClicked) and
             (gnOnEditDoEditClick in NavigateOptions) and
             (EditStyle = esEdit) then
          begin
            try
              FEditLinkAutoClicked := true;
              EditButtonClick;
              HideEditor;
            finally
              FEditLinkAutoClicked := false;
            end;
          end;
        end;
      Exit;
    end;
  end;
  inherited WndProc( Message );
end;

procedure TIB_GridInplaceEdit.BoundsChanged;
var
  R: TRect;
begin
  SetRect( R, 1, 1, Width - 2, Height );
  if FEditStyle <> esNormal then
    Dec( R.Right, FButtonWidth );
  Inc( R.Left, 1 ); // Adjust text in editor by one pixel.
  SendMessage( Handle, EM_SETRECTNP, 0, LongInt( @R ));
  SendMessage( Handle, EM_SCROLLCARET, 0, 0 );
end;

procedure TIB_GridInplaceEdit.KeyDown( var Key: Word; Shift: TShiftState );
var
  Msg: TMsg;
begin
  if ( EditStyle <> esNormal ) and
     ((( Key = VK_RETURN ) and ( Shift = [ssCtrl] )) or
      (( Key = VK_DOWN ) and ( Shift = [ssAlt] ))) then
  begin
    PeekMessage( Msg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE );
    TIB_CustomGrid( Grid ).EditButtonClick;
  end
  else
  if ( Key = VK_DELETE ) and ( Shift = [ssCtrl] ) then
    TIB_CustomGrid(Grid).KeyDown( Key, [] )
  else
    inherited KeyDown(Key, Shift);
end;

procedure TIB_GridInplaceEdit.KeyPress( var Key: Char );
var
  IsValid: boolean;
begin
  { The following lines translates keyboard layout conventions to locale conventions for
    numeric decimal separator and time hours from minutes separator (i.e. Italy).
    Since IBO now does not have a true Time type (AsTime or IsTime property for TIB_Column)
    the check is done only against DateTime type with SelectedField.IsDateTime
    this translation must be done before the inherited KeyPress(Key); that check for Key validity and
    sets it to #0 if invalid (TIB_Column.IsValidChar).}
  with TIB_CustomGrid(Grid) do
    if Assigned( SelectedField ) then
    begin
      if (SelectedField.IsNumeric) and (Key = '.') then
        Key := DecimalSeparator
      else if (SelectedField.IsDateTime) and (Key = ':') and (DateSeparator <> Key) then
        Key := TimeSeparator;
    end;
  // inherited KeyPress(Key); Moved to the bottom of the procedure so CharCase works even if EditMask set
  with TIB_CustomGrid(Grid) do
    if Assigned( SelectedField ) then
      with SelectedField do
      begin
        if ( Key in [#32..#255] ) then
        begin
          IsValid := IsValidChar(Key);
          if Assigned( TIB_CustomGrid( Grid ).OnIsValidChar ) then
             TIB_CustomGrid( Grid ).OnIsValidChar( Grid, Key, IsValid );
          if not IsValid then
          begin
            MessageBeep(0);
            Key := #0;
          end;
        end;
        case Key of
        #27:
          begin
            Reset;
            SelectAll;
            Key := #0;
          end;
        else
          if ( CharCase = ccUpper ) or
             (( CharCase = ccProper ) and
              (( Length( FEditText ) = 0 ) or
               ( Length( FEditText ) = Length( SelText )))) then
            Key := (PChar(AnsiUpperCase( Key )))^
          else
          if CharCase = ccLower then
            Key := (PChar(AnsiLowerCase( Key )))^;
        end;
      end;
  inherited KeyPress(Key);
end;

procedure TIB_GridInplaceEdit.MouseDown( Button: TMouseButton;
                                         Shift: TShiftState;
                                         X, Y: Integer );
begin
  if ( Button = mbLeft ) and
     ( FEditStyle <> esNormal ) and
     PtInRect( Rect( Width - FButtonWidth,
                     0,
                     Width,
                     Height ), Point( X, Y )) then
  begin
    MouseCapture := true;
    FTracking := true;
    TrackButton( X, Y );
  end;
  inherited MouseDown( Button, Shift, X, Y );
end;

procedure TIB_GridInplaceEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FTracking then
    TrackButton( X, Y );
  inherited MouseMove( Shift, X, Y );
end;

procedure TIB_GridInplaceEdit.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := FPressed;
  StopTracking;
  try
    if ( Button = mbLeft ) and
       ( FEditStyle <> esNormal ) and
       ( WasPressed ) then
      if Grid is TIB_CustomGrid then
        with Grid as TIB_CustomGrid do
          EditButtonClick;
  finally
    inherited MouseUp( Button, Shift, X, Y );
  end;
end;

procedure TIB_GridInplaceEdit.PaintWindow(DC: HDC);
var
  R: TRect;
  Flags: Integer;
  W: Integer;
begin
  if FEditStyle <> esNormal then
  begin
    SetRect(R, Width - FButtonWidth, 0, Width, Height);
    Flags := 0;
    if FPressed then
      Flags := BF_FLAT;
    DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
    Flags := ((R.Right - R.Left) shr 1) - 1 + Ord(FPressed);
    W := FButtonWidth shr 3;
    if W = 0 then W := 1;
    PatBlt(DC, R.Left + Flags, R.Top + Flags, W, W, BLACKNESS);
    PatBlt(DC, R.Left + Flags - (W * 2), R.Top + Flags, W, W, BLACKNESS);
    PatBlt(DC, R.Left + Flags + (W * 2), R.Top + Flags, W, W, BLACKNESS);
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited PaintWindow(DC);
end;

procedure TIB_GridInplaceEdit.SetEditStyle(Value: TIB_EditStyle);
var
  tmpRepaintRequired: boolean;
  tmpNewReadOnly: boolean;
begin
  tmpRepaintRequired := false;
  if Value <> FEditStyle then
  begin
    FEditStyle := Value;
    tmpRepaintRequired := true;
  end;
  tmpNewReadOnly := TIB_CustomGrid(Grid).SelectedField.ControlsReadOnly;
  if tmpNewReadOnly <> ReadOnly then
  begin
    ReadOnly := tmpNewReadOnly;
    tmpRepaintRequired := true;
  end;
  if tmpRepaintRequired then
    Repaint;
end;

procedure TIB_GridInplaceEdit.StopTracking;
begin
  if FTracking then
  begin
    TrackButton( -1, -1 );
    FTracking := false;
    MouseCapture := false;
  end;
end;

procedure TIB_GridInplaceEdit.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  SetRect( R, ClientWidth - FButtonWidth, 0, ClientWidth, ClientHeight );
  NewState := PtInRect( R, Point( X, Y ));
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    InvalidateRect( Handle, @R, False );
  end;
end;

procedure TIB_GridInplaceEdit.UpdateContents;
var
  NewColor: TColor;
  tmpIdx: integer;
  tmpStr: string;
begin
  if Modified then
    if not TIB_CustomGrid(Grid).FIB_DataLink.DataChanging then
      TIB_CustomGrid(Grid).SysUpdateData( nil );
  with TIB_CustomGrid(Grid) do
  begin
    NewColor := Color;
    Self.Font := Font;
    GetCellProps( Col, Row, [gdFocused], NewColor, Self.Font );
    Self.Color := NewColor;
    tmpIdx := EditLinks.LinkIndex[ SelectedField.BestFieldName ];
    if tmpIdx <> -1 then
    begin
      tmpStr := Trim( AnsiUpperCase( EditLinks.IndexValues[ tmpIdx ] ));
      if ( Length( tmpStr ) > 0 ) and ( tmpStr[1] = 'D' ) then
        EditStyle := esDate
      else
        EditStyle := esEdit;
    end
    else
    begin
      if SelectedField.IsDateTime and
         not SelectedField.ControlsReadOnly and
         SelectedField.IsDateOnly then
        EditStyle := esDate
      else
      begin
        if SelectedField.IsBlob or ( SelectedField.IsText and
                                     (SelectedField.DataSize >= 1024 )) then
        begin
          // if we want to edit links for text blobs...
          if EditLinksAuto and SelectedField.IsText then
            EditStyle := esEdit
          else
            EditStyle := esNormal;
          Self.ReadOnly := true; // prevent blob from being edited on grid
        end
        else
          EditStyle := esNormal;
      end;
    end;
    PostMessage( Self.Handle, WM_USER, Col, Row );
  end;
  inherited UpdateContents;
end;

procedure TIB_GridInplaceEdit.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TIB_GridInplaceEdit.WMLButtonDblClk( var Message: TWMLButtonDblClk );
begin
  with Message do
  begin
    if ( FEditStyle <> esNormal ) and
      PtInRect( Rect( Width - FButtonWidth,
                      0,
                      Width,
                      Height ),
                Point( XPos, YPos )) then
    begin
      Exit;
    end;
  end;
  inherited;
end;

procedure TIB_GridInplaceEdit.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TIB_GridInplaceEdit.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  if (FEditStyle <> esNormal) and
      PtInRect( Rect(Width - FButtonWidth,
                0,
                Width,
                Height),
                ScreenToClient(P)) then
    Windows.SetCursor( LoadCursor( 0, idc_Arrow ))
  else
    inherited;
end;

procedure TIB_GridInplaceEdit.CMEnter( var Message: TCMEnter );
var
  AGridCoord: TGridCoord;
begin
  with Owner as TIB_CustomGrid do
  begin
    DataLink.SetFocus;
    inherited;
    AGridCoord.X := Col;
    AGridCoord.Y := Row;
    SetFocusedCell( AGridCoord );
  end;
end;

procedure TIB_GridInplaceEdit.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  with Owner as TIB_CustomGrid do
    DataLink.SetFocus;
end;

{$I IB_WinControl.IMP}

constructor TIB_CustomGrid.Create( AOwner: TComponent );
begin
  FIB_DataLink := TIB_CustomGridLink.Create( Self );
  inherited Create( AOwner );
  ControlStyle := ControlStyle + [ csAcceptsControls ];
  VirtualView := true;
  DefaultDrawing := false;
  DataLink.FIB_Grid := Self;
  DataLink.Control := Self;
  DataLink.OnStateChanged := StateChanged;
  DataLink.OnLayoutChanged := LayoutChange;
  DataLink.OnDataChange := DataChange;
  DataLink.OnUpdateData := UpdateData;
  DataLink.AfterAssignment := IB_AfterAssignment;
  FBuffFields := TList.Create;
  FGridFields := TList.Create;
  FSelRow := -1;
  FFixedDataCols := 0;
  FTopRowNum := 1;
  inherited ScrollBars := ssHorizontal;
  inherited DefaultRowHeight := G_DefaultRowHeight;
  inherited ColCount := 2;
  inherited RowCount := 2;
  inherited FixedCols := 1;
  inherited FixedRows := 1;
  inherited Options := [ goFixedHorzLine, goFixedVertLine,
                         goHorzLine, goVertLine,
                         goColSizing, goColMoving,
                         goTabs ];
  FNavigateOptions := [];
  FSaveCellExtents := false;
  FIndicateBooleans := true;
  FIndicateNearest := true;
  FIndicateTitles := true;
  FIndicateSelected := true;
  FIndicateHighlight := true;
  FIndicateRow := true;
  FIndicateOrdering := true;
  FDrawCellTextOptions := [];
  FDrawTitleTextOptions := [];
  FCurrentRowColor := inherited Color;
  FCurrentRowFont := TFont.Create;
  FCurrentRowFont.Assign( inherited Font );
  FCurrentRowFont.OnChange := GridFontChanged;
  FOrderingColor := inherited Color;
  FOrderingFont := TFont.Create;
  FOrderingFont.Assign( inherited Font );
  FOrderingFont.OnChange := GridFontChanged;
  FFixedFont := TFont.Create;
  FIgnoreFocus := false;
  FixedFont.Assign( inherited Font );
  FFixedFont.OnChange := GridFontChanged;
  FGridLinks := TIB_StringProperty.Create;
  FGridLinks.OnChange := GridLinksChange;
  FEditLinks := TIB_StringList.Create;
  FEditLinksAuto := false;
  FTabStopLinks := TIB_StringList.Create;
  FFocusedCell.X := -1;
  FFocusedCell.Y := -1;
  FAcquireFocus := true;
  FRowIndicatorColWidth := 11;
  FEscKeyControl := nil;
  FEditorBorderStyle := bsNone;
  FScrollInProgress := 0;
  FAllowLockSession := true;
  UsesBitmap;
  FMarkSelStart := 0;
  FMarkSelEnd := 0;
  FFieldsToGridLinks := TList.Create;
  FDefDrawBefore := True;
  FIgnoreKeypress := False;
end;

destructor TIB_CustomGrid.Destroy;
begin
  RowSelect := false; // Avoids a strange "feature" in TCustomGrid.
  DataSource := nil;
  DataLink.OnStateChanged := nil;
  DataLink.OnLayoutChanged := nil;
  DataLink.OnDataChange := nil;
  DataLink.OnUpdateData := nil;
  DataLink.AfterAssignment := nil;
  if Assigned( FParentCombo ) then
    FParentCombo.CustomPopup := nil;
  FBuffFields.Free;
  FBuffFields := nil;
  FGridFields.Free;
  FGridFields := nil;
  FOrderingFont.Free;
  FOrderingFont := nil;
  FFixedFont.Free;
  FFixedFont := nil;
  FCurrentRowFont.Free;
  FCurrentRowFont := nil;
  FGridLinks.Free;
  FGridLinks := nil;
  FEditLinks.Free;
  FEditLinks := nil;
  FTabStopLinks.Free;
  FTabStopLinks := nil;
  ReleaseBitmap;
  FFieldsToGridLinks.Free;
  FFieldsToGridLinks := nil;
  inherited Destroy;
end;

procedure TIB_CustomGrid.Loaded;
begin
  inherited Loaded;
  DefineFieldMap;
  SysStateChanged;
end;

procedure TIB_CustomGrid.Notification( AComponent: TComponent;
                                       Operation: TOperation);
begin
  inherited Notification( AComponent,Operation );
  if ( Operation = opRemove ) and ( AComponent = FOldParent ) then
  begin
    FOldParent := nil;
    FOldVisible := false;
  end;
end;

procedure TIB_CustomGrid.CreateWnd;
begin
  try
    FCreatingWnd := true;
    inherited CreateWnd;
  finally
    FCreatingWnd := false;
  end;
  if not (csDesigning in ComponentState) and Assigned( FParentCombo ) then
  begin
    if not (csDesigning in ComponentState) then
      Windows.SetParent( Handle, 0 );
    CallWindowProc( DefWndProc, Handle, WM_SETFOCUS, 0, 0 );
    FParentCombo.SysDataChange( nil );
  end;
  if AllowDropFiles then
    DragAcceptFiles( Handle, True )
  else
    DragAcceptFiles( Handle, False );
  UpdateRowCount;
  UpdateScrollBar;
end;

{$HINTS OFF}
type
{$IFNDEF IBO_SUPPORTED_COMPILER}
// There is the risk that the VCL could change this structure which would
// cause bugs! Please verify the version of the VCL with all versions of the
// compiler. Hopefully the VCL will remain the same per each version of the
// compiler too. Otherwise, I'll have to figure some other way to do this right.
 // THackCustomGrid = class( TClassThatDoesNotExistToForceCompilerError )
 // end;
{$ENDIF}

{ This is used to suppress scrollbar flicker while scrolling.                  }
{                                                                              }
{ It is also used to force the DrawCell method to get called for the focused   }
{ cell since there is some assumptions made that we don't like.                }
  THackCustomGrid = class( TCustomControl )
  private
    FAnchor: TGridCoord;
    FBorderStyle: TBorderStyle;
    FCanEditModify: Boolean;
    FColCount: Longint;
    FColWidths: Pointer;
    FTabStops: Pointer;
    FCurrent: TGridCoord;
    FDefaultColWidth: Integer;
    FDefaultRowHeight: Integer;
    FFixedCols: Integer;
    FFixedRows: Integer;
    FFixedColor: TColor;
    FGridLineWidth: Integer;
    FOptions: TGridOptions;
    FRowCount: Longint;
    FRowHeights: Pointer;
    FScrollBars: TScrollStyle;
    FTopLeft: TGridCoord;
    FSizingIndex: Longint;
    FSizingPos, FSizingOfs: Integer;
    FMoveIndex, FMovePos: Longint;
    FHitTest: TPoint;
    FInplaceEdit: TInplaceEdit;
    FInplaceCol, FInplaceRow: Longint;
    FColOffset: Integer;
    FDefaultDrawing: Boolean;
    FEditorMode: Boolean;
  end;
{$HINTS ON}

procedure TIB_CustomGrid.ChangeScale( M, D: integer );
var
  Flags: TIB_ScalingFlags;
  ii: integer;
begin
  if M <> D then
  begin
    if csLoading in ComponentState then
      Flags := FIB_ScalingFlags
    else
      Flags := [ sfCurrentRowFont,
                 sfFixedFont,
                 sfOrderingFont,
                 sfDefaultRowHeight,
                 sfBorderRowHeights ];
    if not ParentFont and (sfCurrentRowFont in Flags) then
      CurrentRowFont.Size := MulDiv( CurrentRowFont.Size, M, D );
    if not ParentFont and (sfFixedFont in Flags) then
      FixedFont.Size := MulDiv( FixedFont.Size, M, D );
    if not ParentFont and (sfOrderingFont in Flags) then
      OrderingFont.Size := MulDiv( OrderingFont.Size, M, D );
    if (sfDefaultRowHeight in Flags) then
      DefaultRowHeight := MulDiv( DefaultRowHeight, M, D );
    if (sfBorderRowHeights in Flags) then
      for ii := 0 to BorderRows - 1 do
        if BorderRowHeight[ii] <> MulDiv( BorderRowHeight[ii], M, D ) then
          BorderRowHeight[ii] := MulDiv( BorderRowHeight[ii], M, D );
  end;
  inherited ChangeScale( M, D );
end;

procedure TIB_CustomGrid.RowHeightsChanged;
begin
  if not Assigned( THackCustomGrid( Self ).FRowHeights ) then
    Include( FIB_ScalingFlags, sfDefaultRowHeight )
  else
    Include( FIB_ScalingFlags, sfBorderRowHeights );
  inherited RowHeightsChanged;
end;

function TIB_CustomGrid.IsGridFontStored: boolean;
begin
  Result := not ParentFont {$IFNDEF VER90} and not DesktopFont {$ENDIF};
end;

procedure TIB_CustomGrid.GridFontChanged( Sender: TObject );
begin
  ParentFont := false;
{$IFNDEF VER90}
  DesktopFont := false;
{$ENDIF}
  if ( Sender = FCurrentRowFont ) then
  begin
    if CurrentRowFont.Height <> FCurrentRowFontHeight then
    begin
      Include( FIB_ScalingFlags, sfCurrentRowFont );
      FCurrentRowFontHeight := CurrentRowFont.Height;
    end;
  end
  else
  if ( Sender = FFixedFont ) then
  begin
    if FixedFont.Height <> FFixedFontHeight then
    begin
      Include( FIB_ScalingFlags, sfFixedFont );
      FFixedFontHeight := FixedFont.Height;
    end;
  end;
  if ( Sender = FOrderingFont ) then
  begin
    if OrderingFont.Height <> FOrderingFontHeight then
    begin
      Include( FIB_ScalingFlags, sfOrderingFont );
      FOrderingFontHeight := OrderingFont.Height;
    end;
  end;
  Perform( CM_FONTCHANGED, 0, 0 );
end;

type
  THackFontFromWinControl = class ( TWinControl )
  end;

procedure TIB_CustomGrid.CMParentFontChanged(var Message: TMessage);
begin
  inherited;
  if ParentFont then
  begin
    FCurrentRowFont.OnChange := nil;
    FFixedFont.OnChange := nil;
    FOrderingFont.OnChange := nil;
    try
      if Message.wParam <> 0 then
      begin
        SetCurrentRowFont( TFont( Message.lParam ));
        SetFixedFont( TFont( Message.lParam ));
        SetOrderingFont( TFont( Message.lParam ));
      end
      else
      begin
        SetCurrentRowFont( THackFontFromWinControl( Parent ).Font );
        SetFixedFont( THackFontFromWinControl( Parent ).Font );
        SetOrderingFont( THackFontFromWinControl( Parent ).Font );
      end;
    finally
      FCurrentRowFont.OnChange := GridFontChanged;
      FFixedFont.OnChange := GridFontChanged;
      FOrderingFont.OnChange := GridFontChanged;
    end;
  end;
end;

{$IFNDEF VER90}
procedure TIB_CustomGrid.CMSysFontChanged(var Message: TMessage);
begin
  inherited;
  if DesktopFont then
  begin
    FCurrentRowFont.OnChange := nil;
    FFixedFont.OnChange := nil;
    FOrderingFont.OnChange := nil;
    try
      SetCurrentRowFont( Screen.IconFont );
      SetFixedFont( Screen.IconFont );
      SetOrderingFont( Screen.IconFont );
    finally
      FCurrentRowFont.OnChange := GridFontChanged;
      FFixedFont.OnChange := GridFontChanged;
      FOrderingFont.OnChange := GridFontChanged;
    end;
  end;
end;
{$ENDIF}

function TIB_CustomGrid.CreateEditor: TInplaceEdit;
begin
  Result := TIB_GridInplaceEdit.Create(Self);
end;

procedure TIB_CustomGrid.ShowMemoEditor;
var
    MResult: TModalResult;
    tmpKey: Word;
begin
  with TdlgIBMemoEdit.Create( Self ) do
  begin
    Caption := SelectedField.DisplayLabel;
    meMemo.DataSource := Self.DataSource;
    meMemo.DataField := SelectedField.BestFieldName;
    meMemo.IgnoreColorScheme := Self.IgnoreColorScheme;
    meMemo.ReadOnly := Self.ReadOnly;
    TabExits := (gnMemoEditTabExits in NavigateOptions);
    MResult := ShowModal;
    if MResult = mrYes then
    begin
      tmpKey := VK_TAB;
      KeyDown( tmpKey, [] );
    end
    else
    if MResult = mrNo then
    begin
      tmpKey := VK_TAB;
      KeyDown( tmpKey, [ssShift] );
    end
    else
    begin
      // if we are using AlwaysShowEditor and gnOnEditDoEditClick then we
      // will need to tab backward or forward to avoid a user loop
      // (otherwise if the user presses enter or escape the dialog will
      // just show itself again).
      if AlwaysShowEditor and
        (gnOnEditDoEditClick in NavigateOptions) then
      begin
        if MResult = mrOk then
        begin
          tmpKey := VK_TAB;
          KeyDown( tmpKey, [] );
        end
        else
        if MResult = mrCancel then
        begin
          tmpKey := VK_TAB;
          KeyDown( tmpKey, [ssShift] );
        end;
      end;
    end;
    // TdlgIBMemoEdit is setup to free itself on close!
  end;
end;

procedure TIB_CustomGrid.EditButtonClick;
begin
  if Assigned( InPlaceEditor ) and InPlaceEditor.Modified then
    SysUpdateData( nil );
  if Assigned( InPlaceEditor ) and
     (( InPlaceEditor as TIB_GridInplaceEdit).EditStyle = esDate ) then
  begin
    if not Assigned( FDatePick ) then
    begin
      FDatePick := TDatePick.Create( Self );
      FDatePick.Hidden := True;
      FDatePick.OnChange := DatePickChange;
      FDatePick.Parent := Self;
    end;
    if not FDatePick.IsActive then
    begin
      DataLink.UpdateData;
      try
        if SelectedField.IsNull then
          FDatePick.Date := SysUtils.Date
        else
          FDatePick.Date := SelectedField.AsDate;
      except
        FDatePick.Date := SysUtils.Date;
      end;
      if Assigned( InPlaceEditor ) then
      begin
        FDatePick.ShowCalendar(
          ClientToScreen( Point( InPlaceEditor.Left,
                                 InPlaceEditor.Top +
                                 InPlaceEditor.Height )));
      end;
    end
    else
      FDatePick.HideCalendar;
  end
  else if Assigned( FOnEditButtonClick ) then
    FOnEditButtonClick( Self )
  else
  if ( FEditLinksAuto and SelectedField.IsText ) then
    ShowMemoEditor;
end;

procedure TIB_CustomGrid.DatePickChange( Sender: TDatePick;
  Value: TDatePickResult );
begin
  FDatePick.HideCalendar;
  if DataLink.CanModify and not SelectedField.ControlsReadOnly then
  begin
    case Value of
      dpClear: SelectedField.AsString := EmptyStr;
      dpOk: SelectedField.AsDate := FDatePick.Date;
    end;
    SysDataChange( SelectedField );
  end;
  HideEditor;
  if AlwaysShowEditor then
    ShowEditor;
end;

procedure TIB_CustomGrid.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if not (csDesigning in ComponentState) and Assigned( FParentCombo ) then
    with Params do
    begin
      Style := Style or WS_BORDER;
      ExStyle := WS_EX_TOOLWINDOW;
      WindowClass.Style := CS_SAVEBITS or CS_DBLCLKS;
    end;
end;

{------------------------------------------------------------------------------}

function TIB_CustomGrid.GetBuffFields( Index: integer ): TIB_Column;
begin
  if ( Index >= 0 ) and ( Index < FBuffFields.Count ) then
    Result := FBuffFields.Items[ Index ]
  else
    Result := nil;
end;

function TIB_CustomGrid.GetGridFields( Index: integer ): TIB_Column;
begin
  if ( Index >= 0 ) and ( Index < GridFieldCount ) then
    Result := FGridFields.Items[ Index ]
  else
    Result := nil;
end;

function TIB_CustomGrid.GetSelectedField: TIB_Column;
begin
  Result := GridFields[ DataCol[ Col ]];
end;

function TIB_CustomGrid.GetGridFieldCount: integer;
begin
  if Assigned( FGridFields ) then
    Result := FGridFields.Count
  else
    Result := 0;
end;

function TIB_CustomGrid.GetDataCol( ACol: integer ): integer;
begin
  Result := ACol - FixedCols + FixedDataCols;
end;

function TIB_CustomGrid.GetGridCol( ACol: integer ): integer;
begin
  Result := ACol + FixedCols - FixedDataCols;
end;

function TIB_CustomGrid.GetDataRow( ARow: integer ): integer;
begin
  Result := ARow - TopRow + TopRowNum;
end;

function TIB_CustomGrid.GetGridRow( ARowNum: integer ): integer;
begin
  Result := ARowNum + TopRow - TopRowNum;
end;

procedure TIB_CustomGrid.SetRowIndicatorColWidth( AValue: integer );
begin
  if AValue < 11 then
    AValue := 11;
  if FRowIndicatorColWidth <> AValue then
  begin
    FRowIndicatorColWidth := AValue;
    UpdateColumnAttributes;
  end;
end;

{------------------------------------------------------------------------------}

procedure TIB_CustomGrid.IB_AfterAssignment( Sender: TIB_DataLink;
                                             IB_DataSource: TIB_DataSource );
begin
  if Assigned( ParentCombo ) then
    if ParentCombo.DataSource <> IB_DataSource then
      ParentCombo.DataSource := IB_DataSource;
end;

procedure TIB_CustomGrid.LayoutChange( Sender: TIB_DataLink;
                                       IB_DataSource: TIB_DataSource );
begin
  DefineFieldMap;
  with DataLink do
  begin
    if not Prepared or ( not Dataset.RepreparingSQL and
                         not Dataset.Refreshing ) then
    begin
      UpdateColumnAttributes;
      Invalidate;
      SysUpdateEditor;
    end;
  end;
end;

procedure TIB_CustomGrid.SysDataChange( IB_Field: TIB_Column );
var
  tmpInd: integer;
begin
  if DataLink.Disabled then Exit;
  if DataLink.Prepared then
  begin
    with Datalink.BDataset do
    begin
      UpdateRowCount;
      if not UpdateRowPos( true ) then
      begin
        if not Assigned( IB_Field ) then
          InvalidateRow( GridRow[ RowNum ], true )
        else
        if Assigned( FGridFields ) then
        begin
          tmpInd := FGridFields.IndexOf( IB_Field );
          if tmpInd >= 0 then
            InvalidateCell( GridCol[ tmpInd ], GridRow[ RowNum ] );
        end;
      end;
    end;
    InvalidateEditor;
    if Assigned( InPlaceEditor ) then
      InPlaceEditor.Modified := false;
    UpdateScrollBar;
  end;
end;

function TIB_CustomGrid.UpdateRowPos( ResetRowPos: boolean ): boolean;
var
  OldTopRowNum: longint;
  NewTopRowNum: longint;
  NewRow: longint;
  visRows: integer;
begin
  Result := false;
  if DataLink.Prepared and not FUpdatingRowPos then
    with DataLink.BDataset do
      try
        FUpdatingRowPos := true;
        visRows := VisibleGridRows;
        NewRow := GridRow[ RowNum ];
        if not FUpdatingTopRowNum then
        begin
          if ( IncSearchLevel > 0 ) and ( TopRowNum < 1 ) then
            TopRowNum := 1
          else
          if Refreshing then
            TopRowNum := TopRowNum + NewRow - Row;
          NewRow := GridRow[ RowNum ];
        end;
        if Bof or
           (( RowNum = BofRowNum ) and ( IncSearchLevel > 0 )) then
          Inc( NewRow );
        if Eof then
          Dec( NewRow );
        if not FUpdatingTopRowNum then
        begin
          OldTopRowNum := TopRowNum;
          NewTopRowNum := TopRowNum;
          if ResetRowPos then
          begin
            if NewRow < FixedRows then
              NewTopRowNum := TopRowNum + NewRow - FixedRows;
            if NewRow > FixedRows + visRows - 1 then
              NewTopRowNum := TopRowNum + NewRow - FixedRows - visRows + 1;
          end;
          if BufferHasEof then
            if NewTopRowNum + visRows > EofRowNum then
              NewTopRowNum := EofRowNum - visRows;
          if BufferHasBof then
            if NewTopRowNum <= BofRowNum then
              NewTopRowNum := BofRowNum + 1;
          if TopRowNum <> NewTopRowNum then
            TopRowNum := NewTopRowNum;
          if OldTopRowNum <> TopRowNum then
            Inc( NewRow, OldTopRowNum - TopRowNum );
        end;
        if ( NewRow < FixedRows ) or
           ( NewRow >= RowCount ) then
        begin
          FHideRowSelection := true;
          MoveColRow( Col, FixedRows, false, false );
        end
        else
        begin
          FHideRowSelection := Fields.RowState = rsNone;
          if Row <> NewRow then
          begin
            Row := NewRow;
            Result := true;
          end;
        end;
      finally
        FUpdatingRowPos := false;
      end;
end;

procedure TIB_CustomGrid.SysStateChanged;
var
  AGridCoord: TGridCoord;
begin
  if not ( csDestroying in ComponentState ) then
  begin
    if not DataLink.Disabled then
    begin
      if FIncSearchState and ( DataLink.State <> dssBrowse ) then
      begin
        FIncSearchText := EmptyStr;
        FIncSearchState := false;
        if Assigned( FOnIncSearch ) then
          FOnIncSearch( Self, FIncSearchText, false );
      end;
      UpdateRowCount;
      UpdateRowPos( true ); // ??? false );  False no good if data exists already
      UpdateScrollBar;
      UpdateColumnAttributes;
      SysUpdateEditing;
      Invalidate;
      if DataLink.Prepared then
      begin
        AGridCoord.X := Col;
        AGridCoord.Y := Row;
      end
      else
      begin
        AGridCoord.X := -1;
        AGridCoord.Y := -1;
      end;
      SetFocusedCell( AGridCoord );
      SysUpdateEditor;
      if Assigned( FParentCombo ) then
        FParentCombo.SysStateChanged;
      if IndicateRow then
        InvalidateCell( FixedCols - 1 - FixedDataCols, FSelRow );
    end;
    // if F2ToggleEditor is set with F2Edits or F2Posts then the
    // toggle state follows the current state of the datalink...
    if (( gnF2Edits in FNavigateOptions ) or
        ( gnF2Posts in FNavigateOptions )) and
        ( gnF2ToggleEditor in FNavigateOptions ) then
    begin
      AlwaysShowEditor := DataLink.Editing;
      EditorMode := AlwaysShowEditor;
    end;
  end;
end;

procedure TIB_CustomGrid.SysUpdateData( IB_Field: TIB_Column );
var
  v1, v2: string;
begin
  if not FUpdatingData then
  begin
    FUpdatingData := true;
    try
      if Assigned( InPlaceEditor ) and InPlaceEditor.Modified then
      begin
        if DataLink.Prepared and not Datalink.BDataset.IsCancelling then
        begin
          if Assigned( SelectedField ) and (not SelectedField.IsBlob) and
             not SelectedField.ControlsReadOnly then
          begin
            if ( FEditMask <> '' ) then
            begin
              InPlaceEditor.ValidateEdit;
              if MaskGetMaskSave( FEditMask ) then
              begin
                v1 := FormatMaskText( FEditMask, '' );
                v2 := FormatMaskText( FEditMask, FEditText );
                if v2 = v1 then
                  v2 := EmptyStr;
              end
              else
                v2 := FEditText;
            end
            else
              v2 := FEditText;
            if Assigned( FOnSetColumnText ) then
              FOnSetColumnText( Self, v2 );
            if SelectedField.AsString <> v2 then
              try
                SelectedField.AsString := v2;
              except
                if FPaintingLevel = 0 then
                  raise;
              end;
          end
          else
            HideEditor;
        end;
        InPlaceEditor.Modified := false;
      end;
    finally
      FUpdatingData := false;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TIB_CustomGrid.SysUpdateEditor;
var
  AColor: TColor;
  AFont: TFont;
begin
  if not DataLink.Prepared then
    HideEditor;
  if InPlaceEditor = nil then
    InvalidateEditor;
  if Assigned( InPlaceEditor ) then
  begin
    AColor := Color;
    (InPlaceEditor as TIB_GridInplaceEdit).Font.Assign( Self.Font );
    AFont := (InPlaceEditor as TIB_GridInplaceEdit).Font;
    GetCellProps( Col, Row, [gdFocused], AColor, AFont );
    (InPlaceEditor as TIB_GridInplaceEdit).Color := AColor;
    (InPlaceEditor as TIB_GridInplaceEdit).BoundsChanged;
  end;
end;

function TIB_CustomGrid.GetBorderRowsHeight: integer;
var
  ii: integer;
begin
  Result := 0;
  for ii := 0 to BorderRows - 1 do
    Inc( Result, BorderRowHeight[ ii ] );
end;

function TIB_CustomGrid.VisibleGridRows: longint;
var
  ii: integer;
  AGridHeight: longint;
  tmpHeight: longint;
begin
  Result := 0;
  AGridHeight := 0;
  for ii := 0 to FixedRows - 1 do
    Inc( AGridHeight, RowHeights[ ii ] );
  if RowLines or FixedRowLines then
    Inc( AGridHeight, GridLineWidth * ( FixedRows + 1 ));
  if HandleAllocated then
    tmpHeight := ClientHeight
  else
    tmpHeight := Height;
  while AGridHeight < tmpHeight do
  begin
    Inc( Result );
    Inc( AGridHeight, DefaultRowHeight );
    if RowLines or FixedRowLines then
      Inc( AGridHeight, GridLineWidth );
  end;
  FDataRowCount := Result;
  FPartialRowHeight := AGridHeight - tmpHeight;
  if (FPartialRowHeight > 0) and (Result > 1) then
    Dec( Result );
end;

procedure TIB_CustomGrid.StretchGridColumns;
var
  ii: integer;
  sum: integer;
  ClientSize: integer;
  ColumnsWidth: integer;
  factor: double;
begin
  if DataLink.Dataset is TIB_BDataset then
  begin
    with DataLink.Dataset as TIB_BDataset do
    begin
      ClientSize := Width;
      if not NoVertScrollBar then
        ClientSize := ClientSize - GetSystemMetrics( SM_CXVSCROLL );
      if BorderStyle = bsNone then
        ClientSize := ClientSize - 2
      else
        ClientSize := ClientSize - 4;
      if Ctl3D then
        ClientSize := ClientSize - 1;
      if IndicateRow then
        ClientSize := ClientSize - RowIndicatorColWidth - GridLineWidth;
      for ii := 0 to BorderCols - 1 do
        ClientSize := ClientSize - GetBorderColWidth( ii ) - GridLineWidth;
      ColumnsWidth := 0;
      for ii := 0 to GridFieldCount - 1 do
      begin
        ColumnsWidth := ColumnsWidth + GridFields[ ii ].DefaultWidth;
        ClientSize := ClientSize - GridLineWidth;
      end;
      if ColumnsWidth = 0 then
        exit;
      factor := ClientSize / ColumnsWidth;
      Fields.BeginUpdate;
      try
        sum := 0;
        for ii := 0 to GridFieldCount - 2 do
        begin
          GridFields[ ii ].DisplayWidth :=
            Round( factor * GridFields[ ii ].DefaultWidth );
          sum := sum + GridFields[ ii ].DisplayWidth;
        end;
        GridFields[ GridFieldCount - 1 ].DisplayWidth := ClientSize - sum;
      finally
        Fields.EndUpdate( true );
      end;
    end;
  end;
end;

function TIB_CustomGrid.HeightForGridRows( ItemCount: integer;
                                           HorizScrollBar: boolean ): integer;
var
  ii: integer;
begin
  Result := 0;
  for ii := 0 to FixedRows - 1 do
    Inc( Result, RowHeights[ ii ] );
  if RowLines or FixedRowLines then
    Inc( Result, GridLineWidth * ( FixedRows + ItemCount + 1 ));
  Inc( Result, DefaultRowHeight * ItemCount );
  if HandleAllocated and not ListBoxStyle and HorizScrollBar then
    Inc( Result, Height - ClientHeight )
  else
    Inc( Result, GetSystemMetrics(SM_CYBORDER) * 2 );
end;

function TIB_CustomGrid.WidthForAllCols: integer;
var
  ii: integer;
begin
  Result := 0;
  for ii := 0 to ColCount - 1 do
    Inc( Result, ColWidths[ ii ] );
  if ColLines or FixedColLines then
    Inc( Result, GridLineWidth * ( ColCount + 1 ));
  Inc( Result, Width - ClientWidth );
end;

procedure TIB_CustomGrid.SetTitleAlignment( AValue: TGTAlignment );
begin
  if TitleAlignment <> AValue then
  begin
    FTitleAlignment := AValue;
    if IndicateTitles then
      InvalidateRow( FixedRows - 1, false );
  end;
end;

procedure TIB_CustomGrid.SetTopRowNum( AValue: longint );
var
  oldBufferRowCount: longint;
  visRows: longint;
begin
  if not FUpdatingTopRowNum and DataLink.Prepared then
    try
      FUpdatingTopRowNum := true;
      DataLink.Dataset.BeginCallbackFreeze;
      oldBufferRowCount := 0;
      if DataLink.Prepared then
        with DataLink.BDataset do
        begin
          visRows := VisibleGridRows;
          if not BufferHasBof or not BufferHasEof then
          begin
            oldBufferRowCount := BufferRowCount;
            if Unidirectional then
              ValidateRows( AValue, AValue )
            else
              ValidateRows( AValue, AValue + visRows - 1 );
            if oldBufferRowCount <> BufferRowCount then
            begin
              UpdateRowCount;
              oldBufferRowCount := -1;
            end;
          end;
          if AValue >= EofRowNum - visRows then AValue := EofRowNum - visRows;
          if AValue <= BofRowNum           then AValue := BofRowNum + 1;
        end;
      if FTopRowNum <> AValue then
      begin
        FTopRowNum := AValue;
        if not FUpdatingRowPos then
          UpdateRowPos( false );
        if TrackGridRow then
          oldBufferRowCount := -1;
        Repaint;
      end;
      if oldBufferRowCount = -1 then
        UpdateScrollBar;
    finally
      FUpdatingTopRowNum := false;
      DataLink.Dataset.EndCallbackFreeze;
    end;
end;

procedure TIB_CustomGrid.UpdateRowCount;
var
  newCnt: integer;
  tmpInt: longint;
  visRows: integer;
begin
  if not FUpdatingRowCount and DataLink.Prepared then
    try
      FUpdatingRowCount := true;
      DataLink.Dataset.BeginCallbackFreeze;
      visRows := VisibleGridRows;
      newCnt := FixedRows + 1;
      if DataLink.Prepared then
      begin
        DataLink.BDataset.PageRows := visRows;
        if not FUpdatingTopRowNum then
          if ( DataLink.BDataset.IncSearchLevel > 0 ) and ( TopRowNum < 1 ) then
            TopRowNum := 1;
        tmpInt := TopRowNum;
        if DataLink.Dataset.Unidirectional then
          DataLink.BDataset.ValidateRows( tmpInt, tmpInt )
        else
        begin
          DataLink.BDataset.ValidateRows( tmpInt, tmpInt + DataRowCount - 1 );
          if ( DataLink.BufferHasEof ) and
             ( tmpInt > DataLink.BDataset.EofRowNum - DataRowCount ) then
          begin
            tmpInt := DataLink.BDataset.EofRowNum - DataRowCount;
            DataLink.BDataset.ValidateRows( tmpInt, tmpInt + DataRowCount - 1 );
          end;
          if ( DataLink.BufferHasBof ) and
             ( tmpInt <= DataLink.BDataset.BofRowNum ) then
          begin
            tmpInt := DataLink.BDataset.BofRowNum + 1;
            DataLink.BDataset.ValidateRows( tmpInt, tmpInt + DataRowCount - 1 );
          end;
        end;
        if visRows > DataLink.BufferRowCount then
          newCnt := FixedRows + DataLink.BufferRowCount
        else
          newCnt := FixedRows + visRows;
        if newCnt <= FixedRows then
          newCnt := FixedRows + 1;
      end;
      if RowCount <> newCnt then
        RowCount := newCnt;
    finally
      FUpdatingRowCount := false;
      DataLink.Dataset.EndCallbackFreeze;
    end;
end;

procedure TIB_CustomGrid.UpdateScrollBar;
var
  SIOld, SINew: TScrollInfo;
  tmpInt: integer;
begin
  if DataLink.Disabled then Exit;
  if NoVertScrollBar then Exit;
  if HandleAllocated then
  begin
    SIOld.cbSize := sizEof( SIOld );
    SIOld.fMask := SIF_ALL;
    GetScrollInfo( Self.Handle, SB_VERT, SIOld );
    SINew := SIOld;
    if Datalink.Prepared then
    begin
      with Datalink.BDataset do
      begin
        SINew.nPage := VisibleGridRows;
        SINew.nMin  := BofRowNum + 1;
        SINew.nMax  := EofRowNum - 1;
        if TrackGridRow then
          SINew.nPos := TopRowNum
        else
        begin
          if SINew.nPage>0 then
            Inc( SINew.nMax, SINew.nPage - 1 );
          SINew.nPos := RowNum;
        end;
        if CursorRecordCountValid then
        begin
          tmpInt := RecordCount - ( SINew.nMax - SINew.nMin );
          if not BufferHasBof and not BufferHasEof then
          begin
            Dec( SINew.nMin, tmpInt div 2 );
            tmpInt := tmpInt - tmpInt div 2;
            Inc( SINew.nMax, tmpInt );
          end
          else
          if not BufferHasBof then
            Dec( SINew.nMin, tmpInt )
          else
          if not BufferHasEof then
            Inc( SINew.nMax, tmpInt );
        end
        else
        begin
          if not BufferHasBof then Dec( SINew.nMin, SINew.nPage div 2 + 1 );
          if not BufferHasEof then Inc( SINew.nMax, SINew.nPage div 2 + 1 );
        end;
      end;
    end
    else
    begin
      SINew.nPage := 0;
      SINew.nMin  := 0;
      SINew.nMax  := 0;
      SINew.nPos  := 0;
    end;
    if ( SINew.nMin  <> SIOld.nMin  ) or
       ( SINew.nMax  <> SIOld.nMax  ) or
       ( SINew.nPage <> SIOld.nPage ) or
       ( SINew.nPos  <> SIOld.nPos  ) then
      SetScrollInfo( Handle, SB_VERT, SINew, True );
  end;
end;

procedure TIB_CustomGrid.WMVScroll(var Msg: TWMVScroll);
var
  SI: TScrollInfo;
begin
  if FScrollInProgress <> 0 then Exit;
  if not AcquireFocus then Exit;
  if DataLink.Disabled then Exit;
  if ( Msg.ScrollCode = SB_THUMBTRACK ) and not ThumbTracking then Exit;
  if Datalink.Prepared then
  begin
    Inc( FScrollInProgress );
    try
      with Msg, DataLink.BDataset do
      begin
        if AllowLockSession then
          Datalink.LockSessionCursor;
        if ScrollCode in [ SB_THUMBTRACK, SB_THUMBPOSITION ] then
        begin
          SI.cbSize := SizEof( SI );
          SI.fMask := SIF_ALL;
          GetScrollInfo( Self.Handle, SB_VERT, SI );
          if not BufferHasEof and
             ( SI.nTrackPos + longint(SI.nPage) - 1 >= SI.nMax ) then
            ScrollCode := SB_BOTTOM
          else
          if not BufferHasBof and
             ( SI.nTrackPos <= SI.nMin ) then
            ScrollCode := SB_TOP;
        end;
        if NeedToPost or TrackGridRow then
        begin
          case ScrollCode of
            SB_LINEUP: Slide( - 1 );
            SB_LINEDOWN: Slide( 1 );
            SB_PAGEUP: Slide( - VisibleGridRows + 1 );
            SB_PAGEDOWN: Slide( VisibleGridRows - 1 );
            SB_THUMBTRACK,
            SB_THUMBPOSITION: TopRowNum := SI.nTrackPos;
            SB_BOTTOM:
            begin
              if not BufferHasEof then
              begin
                Datalink.UnlockSessionCursor;
                FetchAll; // !?how to get refinement regions involved here?!!!
              end;
              TopRowNum := EofRowNum - 1;
            end;
            SB_TOP:
            begin
              if not BufferHasBof then
              begin
                Datalink.UnlockSessionCursor;
                FetchAll; // !?how to get refinement regions involved here?!!!
              end;
              TopRowNum := BofRowNum + 1;
            end;
            SB_ENDSCROLL: Datalink.UnlockSessionCursor;
          end;
        end
        else
        if CanScroll then
        begin
          CheckPreventModifications;
          case ScrollCode of
            SB_LINEUP:
            begin
              if not Unidirectional then
              begin
                ValidateRows( RowNum - 1, RowNum - 1 );
                if RowNum > BofRowNum + 1 then
                  Prior;
              end;
            end;
            SB_LINEDOWN:
            begin
              if not Unidirectional then
                ValidateRows( RowNum + 1, RowNum + 1 );
              if RowNum < EofRowNum - 1 then
                Next;
            end;
            SB_PAGEUP: Scroll( - VisibleGridRows + 1 );
{
            if not Bof then
            begin
              BeginCallbackFreeze;
              try
                MoveBy( - VisibleGridRows + 1 );
                if Bof then First;
              finally
                EndCallbackFreeze;
              end;
            end;
}
            SB_PAGEDOWN: Scroll( VisibleGridRows - 1 );
{
            if not Eof then
            begin
              BeginCallbackFreeze;
              try
                MoveBy( VisibleGridRows - 1 );
                if Eof then Prior;
              finally
                EndCallbackFreeze;
              end;
            end;
}
            SB_THUMBTRACK,
            SB_THUMBPOSITION:
            begin
              if DataLink.ControlIsModified then UpdateData;
              RowNum := SI.nTrackPos;
              TopRowNum := RowNum - VisibleGridRows div 2;
            end;
            SB_BOTTOM:
            begin
              if not BufferHasEof then Datalink.UnlockSessionCursor;
              Last;
            end;
            SB_TOP:
            begin
              if not BufferHasBof then Datalink.UnlockSessionCursor;
              First;
            end;
          end;
        end;
      end;
    finally
      DataLink.UnlockSessionCursor;
      Dec( FScrollInProgress );
    end;
  end;
end;

procedure TIB_CustomGrid.WMHScroll(var Msg: TWMHScroll);
begin
  inherited;
  Invalidate;
//  InvalidateRow( FocusedCell.Y ); // Don't seem to do the job!
end;

procedure TIB_CustomGrid.WMLButtonUp( var Msg: TWMLButtonUp );
begin
  if FScrollInProgress <> 0 then
    MessageRequeueTimer.QueueMessage( Handle, TMessage(Msg) )
  else
    inherited;
end;

procedure TIB_CustomGrid.CheckPreventModifications;
var
  KDS: TIB_DataSource;
  PC: TIB_CustomCombo;
begin
  if Assigned( Datalink.BDataset ) then
  begin
    PC := ParentCombo;
    KDS := Datalink.BDataset.KeySource;
    if Assigned( PC ) and Assigned( KDS ) then
    begin
      if not KDS.CanModify then SysUtils.Abort;
      if PC.ReadOnly then SysUtils.Abort;
      if PC.PreventSearching then
        if KDS.State = dssSearch then
          SysUtils.Abort;
      if PC.PreventEditing then
        if ( KDS.RowState <> rsNone ) and
           ( KDS.State <> dssSearch ) and
           ( KDS.State <> dssInsert ) then
          SysUtils.Abort;
      if PC.PreventInserting then
        if ( KDS.RowState = rsNone ) then
          begin
            if ( KDS.State <> dssSearch ) then
              SysUtils.Abort;
          end
          else
            if ( KDS.State = dssInsert ) then
              SysUtils.Abort;
    end;
  end;
end;

procedure TIB_CustomGrid.Scroll( Distance: integer );
var
  NewRowNum: longint;
begin
  CheckPreventModifications;
  if DataLink.Prepared and
     ( DataLink.State <> dssSearch ) and
     ( Distance <> 0 ) then
//    with DataLink.BDataset do
    try
      DataLink.Dataset.BeginCallbackFreeze;
      NewRowNum := DataLink.BDataset.RowNum + Distance;
//      DataLink.BDataset.BeginCallbackFreeze;
//      try
        DataLink.BDataset.BufferRowNum := NewRowNum;
//      finally
//      end;
      if NewRowNum > DataLink.BDataset.EofRowNum then
        NewRowNum := DataLink.BDataset.EofRowNum;
      if NewRowNum < DataLink.BDataset.BofRowNum then
        NewRowNum := DataLink.BDataset.BofRowNum;
      if NewRowNum <> DataLink.BDataset.RowNum then
      begin
        if NewRowNum >= DataLink.BDataset.EofRowNum then
          NewRowNum := DataLink.BDataset.EofRowNum - 1;
        if NewRowNum <= DataLink.BDataset.BofRowNum then
          NewRowNum := DataLink.BDataset.BofRowNum + 1;
        DataLink.BDataset.RowNum := NewRowNum;
      end
      else
      if Assigned( ParentCombo ) and
         ( DataLink.BDataset.BufferRowCount > 0 ) then
      begin
        if DataLink.BDataset.Bof and ( Distance > 0 ) then
          DataLink.BDataset.Next;
        if DataLink.BDataset.Eof and ( Distance < 0 ) then
          DataLink.BDataset.Prior;
      end;
    finally
      DataLink.Dataset.EndCallbackFreeze;
    end;
end;

procedure TIB_CustomGrid.Slide( Distance: Integer );
begin
  if DataLink.Disabled then Exit;
  if DataLink.State = dssSearch then Exit;
  if Datalink.Prepared then
    TopRowNum := TopRowNum + Distance;
end;

procedure TIB_CustomGrid.SysUpdateEditing;
begin
  if not FUpdatingEditing then
    try
      FUpdatingEditing := true;
      with DataLink do
        if not Self.ReadOnly and (( State in [ dssEdit, dssInsert ] ) or
           (( DataSource <> nil ) and
             DataSource.AutoEdit and
             not RowSelect )) then
          inherited Options := inherited Options + [ goEditing ]
        else
          inherited Options := inherited Options - [ goEditing ];
    finally
      FUpdatingEditing := false;
    end;
end;

{------------------------------------------------------------------------------}
{   Grid handling procedures                                                   }
{------------------------------------------------------------------------------}

procedure TIB_CustomGrid.SizeChanged( OldColCount, OldRowCount: Longint );
begin
  inherited SizeChanged( OldColCount, OldRowCount );
  UpdateScrollBar;
end;

function TIB_CustomGrid.HasFocus: boolean;
var
  ii: integer;
begin
  Result := Focused or (( InplaceEditor <> nil ) and InplaceEditor.Focused );
  if not Result then
    for ii := 0 to ControlCount - 1 do
      if Controls[ii] is TWinControl then
        if (( Controls[ii] as TWinControl ).Focused ) or
            ( Assigned( Screen.ActiveForm ) and
            ( Controls[ii] = Screen.ActiveForm.ActiveControl )) then
        begin
          Result := true;
          Break;
        end;
end;

function TIB_CustomGrid.AcquireFocus: Boolean;
begin
  Result := true;
  if FAcquireFocus and
     not FIgnoreFocus and
     CanFocus and
     not (csDesigning in ComponentState) and
     not HasFocus then
  begin
    SetFocus;
    Result := Focused;
  end;
end;

procedure TIB_CustomGrid.MoveCol( RawCol, Direction: Integer );
var
  OldCol: Integer;
begin
  Datalink.UpdateData;
  if RawCol >= ColCount then RawCol := ColCount - 1;
  if RawCol < FixedCols then RawCol := FixedCols;
  if Direction <> 0 then
  begin
    while (RawCol < ColCount) and
          (RawCol >= FixedCols) and
          (ColWidths[RawCol] <= 0) do
      Inc( RawCol, Direction );
    if (RawCol >= ColCount) or (RawCol < FixedCols) then
      Exit;
  end;
  OldCol := Col;
  if RawCol <> OldCol then
  begin
    if not FInColExit then
    begin
      FInColExit := True;
      try
        ColExit;
      finally
        FInColExit := False;
      end;
      if Col <> OldCol then Exit;
    end;
    if not AlwaysShowEditor then HideEditor;
    Col := RawCol;
    ColEnter;
  end;
end;

(*

  if (DragKind = dkDock) and (Cell.X < FIndicatorOffset) and
    (Cell.Y < FTitleOffset) and (not (csDesigning in ComponentState)) then
  begin
    BeginDrag(false);
    Exit;
  end;

  if PtInExpandButton(X,Y, MasterCol) then
  begin
    MasterCol.Expanded := not MasterCol.Expanded;
    ReleaseCapture;
    UpdateDesigner;
    Exit;
  end;

  if ((csDesigning in ComponentState) or (dgColumnResize in Options)) and
    (Cell.Y < FTitleOffset) then
  begin
    FDataLink.UpdateData;
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;

*)

procedure TIB_CustomGrid.MouseDown( Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer );
var
  Cell: TGridCoord;
  OldCol, OldRow: Integer;
begin
  if DataLink.Disabled then Exit;
  if not AcquireFocus then Exit;
  FWasDblClick := ( ssDouble in Shift ) and ( Button = mbLeft );
  if FWasDblClick then
  begin
    DblClick;
    Exit;
  end;
  Cell := MouseCoord( X, Y );
  if ( Cell.X < 0 ) and ( Cell.Y < 0 ) then
  begin
    inherited MouseDown( Button, Shift, X, Y );
    Exit;
  end;
  if AllowLockSession then
    DataLink.LockSessionCursor;
  if Assigned( DataLink.Dataset ) then try
    DataLink.Dataset.BeginCallbackFreeze;
    FMouseWasMoved := false;
    FMouseIsDown := true;
    FMouseDownPoint.X := X;
    FMouseDownPoint.Y := Y;
    if Sizing( X, Y ) or
       ( ColMoving and (( Button  = mbLeft ) and
                        ( Cell.X >= FixedCols ) and
                        ( Cell.Y >= 0 ) and
                        ( Cell.Y < FixedRows ))) then
      SysUpdateData( nil )
    else
    begin
      if ( csDesigning in ComponentState ) and
         ( Cell.Y < FixedRows ) then
      begin
        DataLink.UpdateData;
      end
      else
      if Datalink.Prepared then with DataLink do
      begin
        UpdateData;
        with Datalink.BDataset do
        begin
          if ( Cell.Y >= FixedRows ) and
             ( Cell.X >= FixedCols - FixedDataCols ) then
          begin
            if IndicateSelected then
              with BDataset do
              begin
                if ssShift in Shift then
                begin
                  if ssCtrl in Shift then
                    SelectAll( Button = mbLeft )
                  else
                    SelectRange( RowNum,
                                 DataRow[ Cell.Y ],
                                 true,
                                 not ( ssCtrl in Shift ));
                  Click;
                  FMouseIsDown := false;
                  Exit;
                end
                else
                if ssCtrl in Shift then
                begin
                  Selected[ DataRow[Cell.Y]] := not Selected[ DataRow[Cell.Y]];
                  Click;
                  FMouseIsDown := false;
                  Exit;
                end;
              end;
            HideEditor;
            OldCol := Col;
            OldRow := Row;
            if ( Cell.Y <> Row ) or FHideRowSelection then
            begin
              if Dataset.Fetching then
                Dataset.AbortFetching;
              CheckPreventModifications;
              if DataLink.BufferRowCount > 0 then
                RowNum := DataRow[ Cell.Y ];
            end;
            MoveCol( Cell.X, 0 );
            if (Button = mbLeft) and
               (((Cell.X = OldCol) and
                 ((Cell.Y = OldRow) or
                  (DataLink.Bof and (Cell.Y = OldRow + 1))) or
                    AlwaysShowEditor )) then
              ShowEditor        { put grid in edit mode }
            else
              InvalidateEditor;  { draw editor, if needed }
            FFocusEligable := true;
            try
              PositionControl( Col, Row, CellRect( Col, Row ));
            finally
              FFocusEligable := false;
            end;
            if Assigned( OnMouseDown ) then
              OnMouseDown( Self, Button, Shift, X, Y );
            Exit;
          end;
        end;
      end;
    end;
    inherited MouseDown( Button, Shift, X, Y );
  finally
    DataLink.Dataset.EndCallbackFreeze;
    DataLink.UnlockSessionCursor;
  end;
end;

procedure TIB_CustomGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  M1, M2: TGridCoord;
begin
  if DataLink.Disabled then Exit;
  M1 := MouseCoord( X, Y );
  M2 := MouseCoord( FMouseDownPoint.X, FMouseDownPoint.Y );
  inherited MouseMove( Shift, X, Y );
  if FMouseIsDown then
    FMouseWasMoved := (( goColMoving in Options ) and (
                       ( Abs(FMouseDownPoint.X - X ) > 5 ) or
                       ( Abs(FMouseDownPoint.Y - Y ) > 5 ))) or
                       ( M1.X <> M2.X ) or
                       ( M1.Y <> M2.Y );
end;

procedure TIB_CustomGrid.MouseUp( Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer );
var
  Cell: TGridCoord;
  SaveState: TGridState;
  SaveShift: TShiftState;
begin
  if AllowLockSession then
    DataLink.UnlockSessionCursor;
  FMouseDownPoint.X := 0;
  FMouseDownPoint.Y := 0;
  SaveState := FGridState;
  SaveShift := Shift;
  try
    inherited MouseUp( Button, Shift, X, Y );
  finally
    FMouseIsDown := false; // Keep below inherited.
  end;
  if Dragging or (SaveState = gsRowSizing) or
     (SaveState = gsColSizing) or
     ((InplaceEditor <> nil) and
      (InplaceEditor.Visible) and
      (PtInRect(InplaceEditor.BoundsRect, Point(X,Y)))) then Exit;
  if not DataLink.Disabled then
  begin
    Cell := MouseCoord( X, Y );
    if ( Cell.X >= FixedCols - FixedDataCols ) and
       ( Cell.Y >= FixedRows ) and FWasDblClick then
       CellDblClick( Cell.X, Cell.Y, Button, Shift )
    else
    if ( Cell.X >= FixedCols - FixedDataCols ) and
       ( Cell.Y >= FixedRows ) and not FWasDblClick then
      CellClick( Cell.X, Cell.Y, Button, Shift )
    else
    if IndicateTitles and
       ( Cell.X >= FixedCols - FixedDataCols ) and
       ( Cell.Y = FixedRows - 1 ) then
    begin
      if not FMouseWasMoved and IndicateOrdering and
         ( Cell.Y = FixedRows - 1 ) and
         ( Button = mbLeft ) then
        UpdateOrdering( Cell.X, Cell.Y );
      TitleClick( Cell.X, Cell.Y, Button, Shift );
    end
    else
      BorderClick( Cell.X, Cell.Y, Button, Shift );
  end;
end;

procedure TIB_CustomGrid.UpdateOrdering( ACol, ARow: integer );
var
  tmpNo: integer;
  tmpCol: TIB_Column;
begin
  if DataLink.Disabled then
    Exit;
  if DataLink.Prepared then
  begin
    tmpCol := GridFields[ DataCol[ ACol ]];
    if Assigned( tmpCol ) then
      with DataLink.Dataset, tmpCol do
      begin
        tmpNo := OrderingLinkItemNo;
        if tmpNo >= 0 then
        begin
          if tmpNo <> 0 then
          begin
            if Abs( OrderingItemNo ) = tmpNo then
            begin
              if GetOrderingSQL( -OrderingItemNo ) <> EmptyStr then
                tmpNo := -OrderingItemNo
              else
                tmpNo := OrderingItemNo; // Just in case...
            end
            else
            if GetOrderingSQL( tmpNo ) = EmptyStr then
            begin
              tmpNo := -tmpNo;
              if GetOrderingSQL( tmpNo ) = EmptyStr then
                tmpNo := OrderingItemNo; // Just in case...
            end;
          end;
          if tmpNo <> OrderingItemNo then
          begin
            if Active then
            begin
              CheckBrowseMode;
              if FIncSearchState then
              begin
                FIncSearchText := EmptyStr;
                FIncSearchState := false;
                if Assigned( FOnIncSearch ) then
                  FOnIncSearch( Self, FIncSearchText, false );
              end;
            end;
            OrderingItemNo := tmpNo;
            if not Active and IndicateOrdering then
              Invalidate;
          end;
        end;
      end;
  end;
end;

procedure TIB_CustomGrid.CellClick( ACol, ARow: integer;
                                    AButton: TMouseButton;
                                    AShift: TShiftState );
begin
  if Assigned( FOnCellClick ) then
    FOnCellClick( Self, ACol, ARow, AButton, AShift );
  if not ( ssCtrl in AShift ) or not IndicateSelected then
  begin
    if Assigned( FParentCombo ) then
    begin
      FParentCombo.CloseUp;
      FParentCombo.Visible := true;
      FParentCombo.FButton.Visible := true;
      if FParentCombo.CanFocus then
        FParentCombo.SetFocus;
    end;
  end;
  if not ReadOnly and ( AButton = mbLeft ) and (not ToggleOnDblClick) then
    ToggleCheckBox( ACol, ARow );
end;

procedure TIB_CustomGrid.CellDblClick( ACol, ARow: integer;
                                       AButton: TMouseButton;
                                       AShift: TShiftState );
begin
  if Assigned( FOnCellDblClick ) then
    FOnCellDblClick( Self, ACol, ARow, AButton, AShift );
  if not ( ssCtrl in AShift ) or not IndicateSelected then
  begin
    if Assigned( FParentCombo ) then
    begin
      FParentCombo.CloseUp;
      FParentCombo.Visible := true;
      FParentCombo.FButton.Visible := true;
      if FParentCombo.CanFocus then
        FParentCombo.SetFocus;
    end;
  end;
  if not ReadOnly and ( AButton = mbLeft ) and (ToggleOnDblClick) then
    ToggleCheckBox( ACol, ARow );
end;

function TIB_CustomGrid.ToggleCheckBox( ACol, ARow: integer ): boolean;
var
  AColumn: TIB_Column;
begin
  Result := false;
  if IndicateBooleans and
     (( DataLink.ActiveRecord = DataRow[ ARow ] ) or
      ( DataLink.BufferRowCount = 0 )) then
  begin
    AColumn := GridFields[ DataCol[ ACol ]];
    if Assigned( AColumn ) and
       AColumn.IsBoolean and
       not AColumn.ControlsReadOnly and
       DataLink.CanModify then
    begin
      if AColumn.AsBoolean then
      begin
        AColumn.AsBoolean := false;
        Result := true;
      end
      else
      if not AColumn.IsNull and
         ( not AColumn.Required and AColumn.IsNullable ) then
      begin
        AColumn.Clear;
        Result := true;
      end
      else
      begin
        AColumn.AsBoolean := true;
        Result := true;
      end;
      if ( FocusedCell.X = ACol ) and ( FocusedCell.Y = ARow ) then
      begin
        FEditText := AColumn.AsString;
        FEditMask := EmptyStr;
      end;
      DataLink.ControlIsModified := true;
    end;
  end;
end;

procedure TIB_CustomGrid.DoIncSearchKeyPress( var Key: char );
var
  Match: boolean;
begin
  Match := false;
  if ( DataLink.Dataset is TIB_BDataset ) and
     Assigned( DataLink.Dataset.OrderingField ) then
  begin
    with DataLink.Dataset as TIB_BDataset do
    begin
      if FGridFields.IndexOf( OrderingField ) >= 0 then
        Self.Col := GridCol[ FGridFields.IndexOf( OrderingField ) ];
      case Key of
        #08: if Length(FIncSearchText) > 0 then
          System.Delete(FIncSearchText, Length(FIncSearchText), 1);
        #32..#255: if OrderingField.IsValidChar( Key ) then
          FIncSearchText := FIncSearchText + Key;
      end;
      if Key = #27 then
      begin
        if FIncSearchText <> EmptyStr then
        begin
          Match := IncSearchKey( Key, SearchKeyByKey, AllowTimeout,
                                                      SeekNearest );
          FIncSearchText := IncSearchKeyString;
          //Key := #0;
        end;
        FIncSearchState := false;
      end
      else
      if Prepared and
         (( Key in [ #08, #13 ] ) or
         OrderingField.IsValidChar( Key )) then
      begin
        if SearchKeyByKey and
           ( OrderingField.IsText or
            ( OrderingField.IsNumeric and
             ( OrderingRefinePos > 0 ))) then
        begin
          Inc( FIncSearchLevel );
          try
            Match := IncSearchKey( Key,
                                   SearchKeyByKey,
                                   AllowTimeout,
                                   SeekNearest );
          finally
            Dec( FIncSearchLevel );
          end;
          FIncSearchText := IncSearchKeyString;
          if Key = #13 then
            FIncSearchState := false;
          //Key := #0;
        end
        else
        if Key = #13 then
        begin
          Inc( FIncSearchLevel );
          try
            Match := IncSearchString( FIncSearchText, 1, SeekNearest );
          finally
            Dec( FIncSearchLevel );
          end;
          //Key := #0;
          FIncSearchState := false;
        end;
      end
      else
      begin
        MessageBeep( 0 );
        //Key := #0;
      end;
    end;
  end
  else
    MessageBeep( 0 );
  Key := #0;
  if FIncSearchText = '' then
    Match := false;
  if Assigned( FOnIncSearch ) then
    FOnIncSearch( Self, FIncSearchText, Match );
  if not FIncSearchState then
    FIncSearchText := EmptyStr;
end;

procedure TIB_CustomGrid.TitleClick( ACol, ARow: integer;
                                     AButton: TMouseButton;
                                     AShift: TShiftState );
begin
  if Assigned( FOnTitleClick ) then
    FOnTitleClick( Self, ACol, ARow, AButton, AShift );
end;

procedure TIB_CustomGrid.BorderClick( ACol, ARow: integer;
                                      AButton: TMouseButton;
                                      AShift: TShiftState );
begin
  if Assigned( FOnBorderClick ) then
    FOnBorderClick( Self, ACol, ARow, AButton, AShift );
end;

procedure TIB_CustomGrid.ColEnter;
begin
//  UpdateIme;
  if Assigned( FOnColEnter ) then
    FOnColEnter( Self );
end;

procedure TIB_CustomGrid.ColExit;
begin
  if Assigned( FOnColExit ) then
    FOnColExit( Self );
end;

procedure TIB_CustomGrid.DefineFieldMap;
var
  ii: integer;
  tmpFld: TIB_Column;
begin
  Inc( FInGridLayoutLevel );
  try
    FBuffFields.Clear;
    FGridFields.Clear;
    // CVC 2001: Cleaning helper list.
    FFieldsToGridLinks.Clear;
    if DataLink.Prepared then
    try
      with DataSource.Dataset do
      begin
        if GridLinks.Count > 0 then
        begin
          for ii := 0 to GridLinks.Count - 1 do
          begin
            // CVC 2001 => IndexNames instead of Strings
            tmpFld := FindField( GridLinks.IndexNames[ ii ] );
            if Assigned( tmpFld ) then
            begin
              FGridFields.Add( tmpFld );
              FBuffFields.Add( BufferFields.ByName( tmpFld.BestFieldName ));
              // CVC 2001: If GridLinks is not found in Dataset, here's the cure.
              FFieldsToGridLinks.Add(Pointer(ii))
            end;
          end;
        end
        else
        for ii := 0 to FieldCount - 1 do
        begin
          tmpFld := Fields[ ii ];
          if tmpFld.Visible then
          begin
            FGridFields.Add( tmpFld );
            FBuffFields.Add( BufferFields.ByName( tmpFld.BestFieldName ));
          end;
        end;
      end;
    except
      FBuffFields.Clear;
      FGridFields.Clear;
      raise;
    end;
  finally
    Dec(FInGridLayoutLevel);
  end;
end;

procedure TIB_CustomGrid.SetListBoxStyle( AValue: boolean );
begin
  if ListBoxStyle <> AValue then
  begin
    FListBoxStyle := AValue;
    UpdateColumnAttributes;
  end;
end;

procedure TIB_CustomGrid.SetAllowDropFiles( AValue: boolean );
begin
  if AllowDropFiles <> AValue then
  begin
    FAllowDropFiles := AValue;
    if HandleAllocated then
    begin
      if AllowDropFiles then
        DragAcceptFiles( Handle, True )
      else
        DragAcceptFiles( Handle, False );
    end;
  end;
end;

procedure TIB_CustomGrid.SetToggleOnDblClick( AValue: boolean );
begin
  if ToggleOnDblClick <> AValue then
    FToggleOnDblClick := AValue;
end;

procedure TIB_CustomGrid.SetAllowIncSearch( AValue: boolean );
begin
  if AllowIncSearch <> AValue then
  begin
    FAllowIncSearch := AValue;
    if FIncSearchState and not FAllowIncSearch then
    begin
      FIncSearchText := EmptyStr;
      FIncSearchState := false;
      if Assigned(FOnIncSearch) then
        FOnIncSearch(Self, FIncSearchText, false);
    end;
  end;
end;

function TIB_CustomGrid.IsColLookup( ACol: TIB_Column ): boolean;
var
  ii: integer;
  tmpIntf: IIB_GridWinControl;
begin
  Result := false;
  for ii := 0 to ControlCount - 1 do
  begin
    if Controls[ ii ].GetInterface(IIB_GridWinControl,tmpIntf) and
      Assigned( ACol ) and ( ACol = tmpIntf.DisplayColumn ) then
    begin
      Result := true;
      Break;
    end;
  end;
end;

// Function used to return the text currently displayed by the
// matching lookup/control for the given column.  If no match is
// found then returns false, otherwise the text value for the
// control is returned in DispText and function returns true.
// NOTE: This may be necessary on modified rows for lookup columns, because
// the source field in the grid dataset may not be updated until the
// row is posted/refreshed (such as with embedded selects).  Note that
// in such circumstances you must also have BufferSynchroFlags set to
// include bsAfterEdit and bsAfterInsert.
function TIB_CustomGrid.GetLookupText(     ACol: TIB_Column;
                                       var DispText: string ): boolean;
var
  ii: integer;
  tmpIntf: IIB_GridWinControl;
begin
  Result := false;
  for ii := 0 to ControlCount - 1 do
  begin
    if Controls[ ii ].GetInterface(IIB_GridWinControl,tmpIntf) and
      Assigned( ACol ) and ( ACol = tmpIntf.DisplayColumn ) then
      begin
        DispText := tmpIntf.GetText;
        Result := true;
        Break;
      end;
  end;
end;

// CVC 2001: Easier way to read and write those properties.
function TIB_CustomGrid.GetGridLinksWidth(ii: Integer): String;
begin
  Result := FGridLinks.IndexParamValue[Integer(FFieldsToGridLinks[ii]), 'WIDTH']
end;

procedure TIB_CustomGrid.SetGridLinksWidth(ii: Integer; v: String);
begin
  FGridLinks.IndexParamValue[Integer(FFieldsToGridLinks[ii]), 'WIDTH'] := v
end;

function TIB_CustomGrid.GetGridLinksAlign(ii: Integer): String;
begin
  Result := FGridLinks.IndexParamValue[Integer(FFieldsToGridLinks[ii]), 'ALIGN']
end;

procedure TIB_CustomGrid.SetGridLinksAlign(ii: Integer; v: String);
begin
  FGridLinks.IndexParamValue[Integer(FFieldsToGridLinks[ii]), 'ALIGN'] := v
end;

procedure TIB_CustomGrid.UpdateColumnAttributes;
var
  TotWidth: integer;
  BdrWidth: integer;
  NewWidth: integer;
  ii: integer;
  NewColCount: integer;
  tmpCol: TIB_Column;
  tmpInd: integer;
  dw: integer;
begin
  if not HandleAllocated then
    Exit;
  if FUpdatingColCount then
    Exit;
  if FUpdatingColAttr then
    Exit;
  FUpdatingColAttr := true;
  try
    NewColCount := FixedCols - FixedDataCols + GridFieldCount;
    if NewColCount <= FixedCols then
      NewColCount := FixedCols + 1;
    if ColCount <> NewColCount then
      ColCount := NewColCount;
    if DataLink.Prepared then
      FStretchColRef := Datalink.BDataset.FindField( StretchColumn )
    else
      FStretchColRef := nil;
    FStretchColNum := ColCount - 1;
    FLastTabCol := -1;
    FFirstTabCol := -1;
    if IndicateRow then
      ColWidths[ FixedCols - FixedDataCols - 1 ] := RowIndicatorColWidth;
    if GridFieldCount > 0 then
    begin
      for ii := 0 to GridFieldCount - 1 do
      begin
        tmpCol := GridFields[ ii ];
        tmpInd := ii + FixedCols - FixedDataCols;
        if Assigned( tmpCol ) then
        begin
          with tmpCol do
          begin
            if tmpCol = StretchColRef then
              FStretchColNum := GridCol[ ii ];
            if TabStopLinks.Count > 0 then
            begin
              if TabStopLinks.LinkIndex[ tmpCol.BestFieldName ] <> -1 then
              begin
                TabStops[ tmpInd ] := true;
                FLastTabCol := tmpInd;
                if ( FirstTabCol = -1 ) and
                   ( ii >= FixedDataCols ) then
                  FFirstTabCol := tmpInd;
              end
              else
                TabStops [ tmpInd ] := false;
            end
            else
            if DataLink.Prepared and
               ( not ControlsReadOnly or
                 ( EditLinks.LinkIndex[ tmpCol.BestFieldName ] <> -1 )) or
                 ( FEditLinksAuto and tmpCol.IsText and tmpCol.IsBlob ) or
                 IsColLookup( tmpCol ) then
            begin
              TabStops[ tmpInd ] := true;
              FLastTabCol := tmpInd;
              if ( FirstTabCol = -1 ) and
                 ( ii >= FixedDataCols ) then
                FFirstTabCol := tmpInd;
            end
            else
              TabStops[ tmpInd ] := false;
            dw := DisplayWidth;
            if GridLinks.Count > 0 then
              dw := StrToIntDef( GetGridLinksWidth(ii), dw );
            if ( ColWidths[ tmpInd ] <> dw ) then
              if ((( StretchColNum <> tmpInd ) or
                   ( Assigned( ParentCombo ))) or
                   ( not ListBoxStyle )) then
                ColWidths[ tmpInd ] := dw
              else
              if not ListBoxStyle and
                 ( StretchColNum = tmpInd ) and
                 ( ColWidths[ tmpInd ] < ( DefaultWidth * 2 div 3 )) then
                ColWidths[ tmpInd ] := DefaultWidth * 2 div 3;
          end;
        end
        else
        begin
          TabStops[ tmpInd ] := false;
          if ( ColWidths[ tmpInd ] <> DefaultColWidth ) and
             (( StretchColNum <> tmpInd ) or not ListBoxStyle ) then
            ColWidths[ ii + FixedCols - FixedDataCols ] := DefaultColWidth;
        end;
      end;
      if ListBoxStyle then
      begin
        if ColLines or FixedColLines then
          BdrWidth := GridLineWidth
        else
          BdrWidth := 0;
        TotWidth := BdrWidth;
        for ii := 0 to ColCount - 1 do
          if StretchColNum <> ii then
            TotWidth := TotWidth + ColWidths[ ii ] + BdrWidth;
        if ( ColCount = 1 ) or
           ( TotWidth < ( ClientWidth - BdrWidth )) then
        begin
          NewWidth := ClientWidth - TotWidth - BdrWidth;
          dw := DefaultColWidth;
          if Assigned( GridFields[ StretchColNum ] ) then
            dw := GridFields[ StretchColNum ].DefaultWidth;
          if ( Assigned( ParentCombo )) and
             ( ParentCombo.DropDownWidth = 0 ) and
             ( NewWidth < dw ) then
            NewWidth := dw
          else
          if NewWidth < dw * 2 div 3 then
            NewWidth := dw * 2 div 3;
          ColWidths[ StretchColNum ] := NewWidth;
        end;
      end;
    end
    else
    begin
      TabStops [ FixedCols - FixedDataCols ] := false;
      ColWidths[ FixedCols - FixedDataCols ] := DefaultColWidth;
    end;
  finally
    FUpdatingColAttr := false;
  end;
end;

procedure TIB_CustomGrid.UnMarkSelection;
begin
  if DataLink.Prepared then
  begin
    with Datalink.BDataset as TIB_BDataset do
      SelectRange( 0, 0, true, true );
    FMarkSelStart := 0;
    FMarkSelEnd := 0;
  end;
end;

procedure TIB_CustomGrid.MarkSelectionEnd;
begin
  if FMarkSelStart <> 0 then
  begin
    FMarkSelEnd := Row;
    if DataLink.Prepared then
    begin
      with Datalink.BDataset as TIB_BDataset do
        SelectRange( DataRow[ FMarkSelStart ],
                     DataRow[ FMarkSelEnd ],
                     true,
                     false );
      FMarkSelStart := 0;
      FMarkSelStart := 0;
    end;
  end;
end;

procedure TIB_CustomGrid.KeyDown( var Key: Word; Shift: TShiftState );

  procedure NextRow( Select: boolean );
  begin
    if DataLink.State <> dssSearch then
      with Datalink.BDataset do
      begin
        if (State = dssInsert) and
           not Modified and
           not Datalink.ControlIsModified then
        begin
          if DataLink.EOF then
            Exit
          else
            Cancel;
        end;
        if DataLink.EOF and CanInsert and not Self.ReadOnly and
                                          not Self.PreventInserting then
        begin
          if DataSource.AutoInsert then
          begin
            CheckPreventModifications;
            Append;
          end;
        end;
      end;
  end;

  procedure PriorRow( Select: boolean );
  begin
    if DataLink.State <> dssSearch then
      with Datalink.BDataset do
        if ( State = dssInsert ) and not Modified and DataLink.EOF and
           not Datalink.ControlIsModified then
        begin
          Cancel;
        end;
  end;

var
  NewCurrent: TGridCoord;
  tmpCol: integer;
  tmpKey: word;
begin
  tmpKey := Key;  //Save Key value

{$IFDEF IBO_VCL40_OR_GREATER}
  // In key of BidiMode, Right and Left keys should be exchanged
  // for proper navigation (Left should move to next row and right should move
  // to previous row
  if BiDIMode = bdRightToLeft then
  begin
    if Key = VK_LEFT then Key := VK_RIGHT
    else if Key = VK_RIGHT then Key := VK_LEFT;
  end;
{$ENDIF}

  FIgnoreKeypress := false;
  if DataLink.Disabled or (csDestroying in ComponentState) then
    Exit;
{ start changes by helmut}
  if DataLink.Prepared and IndicateSelected then
  begin
    if Shift = [ssShift] then
      case Key of
        VK_ADD:
        begin
          FIgnoreKeypress := true;
          MarkSelectionEnd;
          Scroll( 1 );
        end;
        VK_SUBTRACT:
        begin
          FIgnoreKeypress := true;
          UnMarkSelection;
        end;
      end;
    if Shift = [ssCtrl] then
      case key of
        VK_SPACE:
        begin
          FIgnoreKeypress := true;
          with DataLink.BDataset do
          begin
            Selected[ DataRow[ Row ]] := not Selected[ DataRow[ Row ]];
            if Selected [ DataRow[ Row ]] then
              FMarkSelStart := Row
            else
              FMarkSelStart := 0;
          end;
        end;
        VK_ADD:
        begin
          FIgnoreKeypress := true;
          FMarkSelStart := Row;
          with DataLink.BDataset do
            if not Selected[ DataRow[ Row ]] then
              Selected[ DataRow[ Row ]] := true;
          Scroll( 1 );
        end;
        VK_SUBTRACT:
        begin
          FIgnoreKeypress := true;
          FMarkSelStart := 0;
          with DataLink.BDataset do
            if Selected[ DataRow[ Row ]] then
              Selected[ DataRow[ Row ]] := false;
          Scroll( 1 );
        end;
        VK_MULTIPLY:
        begin
          FIgnoreKeypress := true;
{       filtermaske;}  { here I call a form, where the user can select from all
                       visible fields of the dataset and then insert a string,
                       which is used as a filter. If you want I can implement it
                       and you can look if you like it. It works realy well}
        end;
      end;
    end;
{ end changes by helmut}

  if DataLink.Prepared then with DataLink, BDataset do
  begin
    try
      if AllowLockSession then
        LockSessionCursor;
      if ( ssCtrl in Shift ) and ( Key <> VK_HOME ) and ( Key <> VK_END ) then
      begin
        case Key of
          VK_DOWN: begin Slide( 1 ); Key := 0; end;
          VK_UP: begin Slide( - 1 ); Key := 0; end;
          VK_NEXT: begin Slide( VisibleGridRows - 1 ); Key := 0; end;
          VK_PRIOR: begin Slide( - VisibleGridRows + 1 ); Key := 0; end;
          VK_LEFT: begin MoveCol( FixedCols, 1 ); Key := 0; end;
          VK_RIGHT: begin MoveCol( ColCount - 1, -1 ); Key := 0; end;
          VK_TAB:
          begin
            Key := 0;
            if ssShift in Shift then
              PostMessage( GetParentForm(Self).Handle, WM_NEXTDLGCTL, 1, 0 )
            else
              PostMessage( GetParentForm(Self).Handle, WM_NEXTDLGCTL, 0, 0 );
          end;
        end;
      end
      else
      if ( Key = VK_DOWN ) and ( State = dssDelete ) then
      begin
        if CanScroll then
        begin
          Key := 0;
          CheckBrowseMode;
        end;
      end
      else
      case Key of
        VK_LEFT:
        begin
          Key := 0;
          if RowSelect then
            PriorRow( False )
          else
            MoveCol( Col - 1, -1 );
        end;
        VK_RIGHT:
        begin
          Key := 0;
          if RowSelect then
            NextRow( False )
          else
            MoveCol( Col + 1, 1 );
        end;
        VK_HOME: if RowSelect or ( ssCtrl in Shift ) then
        begin
          Key := 0;
          if not BufferHasBof then
            UnlockSessionCursor;
          if DataLink.State <> dssSearch then
          begin
            CheckPreventModifications;
            First;
          end;
        end;
        VK_END: if RowSelect or ( ssCtrl in Shift ) then
        begin
          Key := 0;
          if not BufferHasEof then
            UnlockSessionCursor;
          if DataLink.State <> dssSearch then
          begin
            CheckPreventModifications;
            Last;
          end;
        end;
        VK_TAB:
        begin
          if TabMovesOut and
             not (ssShift in Shift) and
             (( Col >= LastTabCol ) or RowSelect) then
          begin
            Key := 0;
            PostMessage( GetParentForm(Self).Handle, WM_NEXTDLGCTL, 0, 0 );
          end
          else
          if TabMovesOut and
             (ssShift in Shift) and
             ((Col <= FirstTabCol) or (FirstTabCol = -1) or RowSelect) then
          begin
            Key := 0;
            // If a child control has focus we will need to Shift-Tabs to
            // get away from the grid (first goes to grid itself).
            if not Focused then
              PostMessage( GetParentForm(Self).Handle, WM_NEXTDLGCTL, 1, 0 );
            PostMessage( GetParentForm(Self).Handle, WM_NEXTDLGCTL, 1, 0 );
          end
          else
          if ( RowNum >= EofRowNum - 1 ) and BufferHasEof and
             ( Col >= LastTabCol ) and
             not ( ssShift in Shift ) and
             not Assigned( ParentCombo ) then
          begin
            if DataLink.NeedToPost then
              DataLink.UpdateData;
            if ( DataLink.State in [ dssEdit, dssInsert ] ) and
               ( not Datalink.BDataset.Modified ) then
            begin
              if FirstTabCol <> - 1 then
                MoveCol( FirstTabCol, 0 )
              else
                MoveCol( FixedCols, 0 );
              Key := 0;
            end
            else
            if DataSource.AutoInsert then
            begin
              if CanScroll and not Self.ReadOnly and
                 not RowSelect and
                 not Self.PreventInserting then
              begin
                tmpCol := Col;
                CheckPreventModifications;
                DataLink.Append;
                if ( FirstTabCol <> - 1 ) and ( Col = tmpCol ) then
                  MoveCol( FirstTabCol, 0 );
                Key := 0;
              end;
            end;
          end;
          if ( Key <> 0 ) and not (ssAlt in Shift) then
          begin
            NewCurrent.X := Col;
            NewCurrent.Y := Row;
            repeat
              if ssShift in Shift then
              begin
                Dec(NewCurrent.X);
                if NewCurrent.X < FixedCols then
                begin
                  NewCurrent.X := ColCount - 1;
                  Dec(NewCurrent.Y);
                  if NewCurrent.Y < FixedRows then
                  begin
                  //!!!
                    //Last; {### Removed}
                    CheckBrowseMode; {### Added}
                    Break;
                  //!!!
                  end;
                end;
              end
              else
              begin
                Inc( NewCurrent.X );
                if NewCurrent.X >= ColCount then
                begin
                  NewCurrent.X := FixedCols;
                  Inc( NewCurrent.Y );
                  if NewCurrent.Y >= RowCount then
                  begin
                  //!!!
                    //First; {### Removed}
                    CheckBrowseMode; {### Added}
                    Break;
                  //!!!
                  end;
                end;
              end;
            until TabStops[NewCurrent.X] or (NewCurrent.X = Col);
            if (NewCurrent.X <> Col) or (NewCurrent.Y <> Row) then
            begin
              MoveCol( NewCurrent.X, 0 );
              Scroll( NewCurrent.Y - Row );
              RowHeightsChanged; //UpdateEdit;
              Click;
            end;
            Key := 0;
          end;
        end;
        VK_DOWN:
        begin
          Key := 0;
          if not Unidirectional then
            ValidateRows( RowNum + 1, RowNum + 1 );
          if not Assigned( ParentCombo ) and
             BufferHasEof and ( RowNum >= EofRowNum - 1 ) then
          begin
            if NeedToPost then
              UpdateRecord;
            if ( State = dssInsert ) and not Modified then
            else
            if not Self.ReadOnly and
               not Self.PreventInserting and
               not Self.RowSelect and
               DataSource.AutoInsert and
               CanInsert and
               CanScroll then
            begin
              CheckPreventModifications;
              DataLink.Append;
            end;
          end
          else
          if Bof and BufferActive then
          begin
            CheckPreventModifications;
            First;
          end
          else
            Scroll( 1 );
        end;
        VK_UP: begin Key := 0; Scroll( - 1 ); end;
        VK_NEXT: begin Key := 0; Scroll( VisibleGridRows - 1 ); end;
        VK_PRIOR: begin Key := 0; Scroll( - VisibleGridRows + 1 ); end;
        VK_DELETE:
        begin
          Key := 0;
          if not Self.ReadOnly and
             (goEditing in Options) and
             CanDelete and not DataLink.PreventDeleting then
          begin
            CheckPreventModifications;
            Delete;
          end;
        end;
        VK_INSERT:
        begin
          Key := 0;
          if DataLink.State = dssInsert then
            Datalink.BDataset.Post;
          if not Self.ReadOnly and
             not Self.PreventInserting and
             (goEditing in Options) and
             CanInsert then
          begin
            CheckPreventModifications;
            DataLink.Insert;
          end;
        end;
        VK_F2:
        begin
          Key := 0;
          if [ gnF2Edits, gnF2Posts ] * FNavigateOptions <> [] then
          begin
            if DataLink.NeedToPost then
            begin
              if gnF2Posts in FNavigateOptions then
              begin
                Post;
                EditorMode := DataLink.Editing;
              end;
            end
            else
            begin
              if gnF2Edits in FNavigateOptions then
                EditorMode := DataLink.Edit;
            end;
            EditorMode := DataLink.Editing;
          end
          else
          begin
            if gnF2ToggleEditor in FNavigateOptions then
            begin
              AlwaysShowEditor := not AlwaysShowEditor;
              EditorMode := AlwaysShowEditor;
            end
            else
              EditorMode := true;
          end;
          //?? I was going to have a gnF2EditClick to have F2 automatically
          //?? call EditButtonClick.  However the gnOnEditDoEditClick option
          //?? makes this redundant, since as soon as the inplace editor
          //?? is focused it will call EditButtonClick anyway.  I am leaving
          //?? the code here temporarily to see if the chosen mechanism works
          //?? to most peoples satisfaction.
          //?? if (gnF2EditClick in FNavigateOptions) and
          //??   (EditorMode) and Assigned( InPlaceEditor ) and
          //??   ((InPlaceEditor as TIB_GridInplaceEdit).EditStyle = esEdit) then begin
          //??   try
          //??     FEditLinkAutoClicked := true;
          //??     EditButtonClick;
          //??   finally
          //??     FEditLinkAutoClicked := false;
          //??   end;
          //?? end;
        end;
        VK_F5:
        begin
          BeginCallbackFreeze;
          try
            Refresh;
          finally
            EndCallbackFreeze;
          end;
        end;
        VK_F8: if NeedToPost then
          Datalink.BDataset.Post;
      end;
      if Key = VK_ESCAPE then
      begin
        if Assigned( SelectedField ) and
           ( SelectedField.IsModified or
             DataLink.ControlIsModified ) then
        begin
          Key := 0;
          SelectedField.Revert;
          DataLink.ControlIsModified := false;
          if Assigned( InplaceEditor ) then
            InplaceEditor.Modified := false;
        end
        else
        with Datalink do
        begin
          if (State = dssInsert) or
             (State = dssDelete) or
             (State = dssEdit) then
          begin
            Key := 0;
            Dataset.Cancel;
          end
          else
            Reset;
        end;
        if not AlwaysShowEditor then
          HideEditor;
      end;
{}
            FFocusEligable := true;
            try
              PositionControl( Col, Row, CellRect( Col, Row ));
            finally
              FFocusEligable := false;
            end;
{}
      if (Key = 0) and Assigned(OnKeyDown) then  //call OnKeyDown myself, because if Key = 0
         OnKeyDown(Self, TmpKey, Shift);         //inherited KeyDown won't do this
      if Key <> 0 then
        inherited KeyDown( Key, Shift );
    finally
      UnlockSessionCursor;
    end;
  end;
end;

procedure TIB_CustomGrid.KeyUp( var Key: Word; Shift: TShiftState );
begin
  inherited KeyUp( Key, Shift );
  if IndicateBooleans and
     ( Key = VK_SPACE ) and
     ( Shift * [ ssShift, ssCtrl, ssAlt ] = [] ) and
     ToggleCheckBox( Col, Row ) then
    Key := 0;
end;

procedure TIB_CustomGrid.WMSize(var Message: TWMSize);
begin
  if not FSizingGrid and not FMouseIsDown then
  begin
    FSizingGrid := true;
    try
      UpdateRowCount;
      UpdateRowPos( Row > FixedRows );
      UpdateScrollBar;
      UpdateColumnAttributes;
    finally
      FSizingGrid := false;
    end;
  end;
  inherited; // JLW - Keep below to avoid horiz scrollbar flicker when sizing.
end;

procedure TIB_CustomGrid.CMEnter( var Message: TCMEnter );
var
  AGridCoord: TGridCoord;
begin
  inherited;
  // It seems a pity to call this on every entry, its only needed
  // on the first time after the lookup dataset has been prepared.
  // Without this the tabstop may not have been initialised properly.
  UpdateColumnAttributes;

  AGridCoord.X := Col;
  AGridCoord.Y := Row;
  SetFocusedCell( AGridCoord );
end;

procedure TIB_CustomGrid.CMExit( var Message: TCMExit );
var
  AGridCoord: TGridCoord;
begin
  if FIncSearchState then
  begin
    FIncSearchText := EmptyStr;
    FIncSearchState := false;
    if Assigned(FOnIncSearch) then
      FOnIncSearch(Self, FIncSearchText, false);
  end;
  if not DataLink.Disabled then
    try
      SysUpdateData( nil );
    except
      SetFocus;
      raise;
    end;
  inherited;
  AGridCoord.X := -1;
  AGridCoord.Y := -1;
  SetFocusedCell( AGridCoord );
end;

function TIB_CustomGrid.PositionControl( ACol, ARow: longint;
                                         ARect: TRect ): boolean;
var
  ii: integer;
  cellCol: TIB_Column;
  tmpColor: TColor;
  tmpFont: TFont;
  tmpIntf: IIB_GridWinControl;
  tmpForm: TCustomForm;
begin
  Result := false;
  if not HasFocus then
    Exit;
  if DataLink.Prepared and not RowSelect then
  begin
    cellCol := GridFields[ DataCol[ ACol ]];
    for ii := 0 to ControlCount - 1 do
    begin
      if Controls[ ii ].GetInterface(IIB_GridWinControl,tmpIntf) then
      begin
        if Assigned( CellCol ) and ( CellCol = tmpIntf.DisplayColumn ) then
        begin
          with ARect do
            tmpIntf.SetBounds( Left, Top, Right - Left, Bottom - Top );
          tmpIntf.SetBorderStyle( FEditorBorderStyle );//bsNone;
          // Much of this is copied from SysUpdateEditor
          // I actually believe this sort of processing probably appropriate
          // for all dropped controls, but for the moment I will do this
          // only for my TCustomEditEnh derivatives.  Without this the color
          // of the edit controls tend to follow the "highlight" color
          // at inappropriate moments.
          // Regretably this is a duplication of processing, since the
          // GetCellColor and GetCellFont functions have already been called
          // prior to this function - giving use the passed parameters -
          // however this is also the case in SysUpdateEditor so it is not
          // really anything new.
          tmpColor := Self.Color;
          tmpFont := tmpIntf.GetFont;
          if Assigned( tmpFont ) then
            GetCellProps( Col, Row, [gdFocused], tmpColor, tmpFont );
          tmpIntf.SetColor( tmpColor );
          tmpIntf.SetVisible( true );
          // TControl.CanFocus does not check if the form can be focused
          // (at least in Delphi5).  IMO opinion this is a VCL bug but perhaps
          // they had some reason for this.  Whatever we need to check
          // if the form can be focused as well as the particular control.
          // Could have dont this in the individual interfaces but central
          // seems neater.
          tmpForm := GetParentForm( Controls[ ii ] );
          if tmpIntf.CanFocus and
            (tmpForm <> nil) and tmpForm.Visible and tmpForm.Enabled then
            tmpIntf.SetFocus;
          // Have to FORCE a BoundsChanged calculation due to some
          // weird processing with WM_CTL* messages.
          // (even though, more often than not, no change has occurred)
          tmpIntf.BoundsChanged;
          Result := true;
          Break;
        end
        else
          tmpIntf.SetVisible( false );
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

function TIB_CustomGrid.CanEditShow: boolean;
begin
  Result := inherited CanEditShow and
            DataLink.Prepared and not RowSelect and
            ((AlwaysShowEditor or (goEditing in Options))) and
            ( Assigned( SelectedField ) and
              not ( SelectedField.IsArray or
                  ( SelectedField.IsBoolean and IndicateBooleans )) and
              not IsColLookup( SelectedField ));
end;

function TIB_CustomGrid.CanEditModify: Boolean;
begin
  Result := inherited CanEditModify and
            Assigned( SelectedField ) and
            not SelectedField.ControlsReadOnly and
            ( DataLink.State <> dssSearch ) and
            DataLink.CanModify and
            DataLink.Modify;
end;

function TIB_CustomGrid.CanEditAcceptKey(Key: Char): Boolean;
begin
  if not Assigned( SelectedField ) then
     Result:=false
  else begin
     Result:=( SelectedField.IsBoolean and IndicateBooleans and ( Key = #13 )) or
             ( SelectedField.IsValidChar( Key ));
     if Assigned(OnIsValidChar) then
        OnIsValidChar(self,Key,Result);
     end;
end;

{$ifdef IBO_VCL40_OR_GREATER}
function TIB_CustomGrid.DoMouseWheelDown( Shift: TShiftState;
                                          MousePos: TPoint ): boolean;
begin
  if Shift = [ ssCtrl ] then Slide( 1 ) else
  if Shift = [        ] then Scroll( 1 );
  Result := True;
end;

function TIB_CustomGrid.DoMouseWheelUp( Shift: TShiftState;
                                        MousePos: TPoint ): Boolean;
begin
  if Shift = [ ssCtrl ] then Slide( -1 ) else
  if Shift = [        ] then Scroll( -1 );
  Result := True;
end;
{$endif}

function TIB_CustomGrid.GetEditMask( ACol, ARow: Longint ): string;
var
  tmpCol: TIB_Column;
begin
  tmpCol := GridFields[ DataCol[ ACol ]];
  if Assigned( tmpCol ) then begin
    Result := tmpCol.EditMask;
  end else begin
    Result := EmptyStr;
  end;
  if Assigned( FOnGetEditMask ) then begin
    FOnGetEditMask( Self, ACol, ARow, Result );
  end;
end;

function TIB_CustomGrid.GetEditLimit: Integer;
begin
  if ( SelectedField <> nil ) and (
     ( SelectedField.SQLType = SQL_Varying  ) or
     ( SelectedField.SQLType = SQL_Varying_ ) or
     ( SelectedField.SQLType = SQL_Text     ) or
     ( SelectedField.SQLType = SQL_Text_    )) then
  // Watch out for masks here.
    Result := SelectedField.SQLLen
  else
    Result := 0;
end;

function TIB_CustomGrid.CanGridAcceptKey( Key: Word;
                                          Shift: TShiftState ): boolean;
begin
  Result := DataLink.Prepared;
end;

{------------------------------------------------------------------------------}

function TIB_CustomGrid.GetEditText( ACol, ARow: Longint ): string;
var
  AColumn: TIB_Column;
begin
  AColumn := GridFields[ DataCol[ ACol ]];
  if Assigned( AColumn )then
  begin
    with AColumn do
      if IsNull then
        Result := EmptyStr
      else
      if ( gdtShowTextBlob in FDrawCellTextOptions ) and IsBlob and IsText then
        Result := AsString
      else
      if IsBlob or IsArray then
        Result := DisplayText
      else
        Result := AsString;
  end
  else
    Result := EmptyStr;
  FEditText := Result;
  FEditMask := EmptyStr;
  if Assigned( FOnGetEditText ) then
    FOnGetEditText( Self, ACol, ARow, Result );
end;

procedure TIB_CustomGrid.SetEditText(       ACol, ARow: Longint;
                                      const Value: string );
var
  ss: string;
  v1: string;
  tmpMask: string;
begin
  if Assigned( FOnSetEditText ) then
    FOnSetEditText( Self, ACol, ARow, Value );
  if Assigned( InPlaceEditor ) and
     ( TIB_GridInPlaceEdit(InPlaceEditor).EditMask <> EmptyStr ) then
    tmpMask := TIB_GridInPlaceEdit(InPlaceEditor).EditMask
  else
    tmpMask := EmptyStr;
  if tmpMask <> EmptyStr then
  begin
    v1 := FormatMaskText( tmpMask, Value );
    ss := FormatMaskText( tmpMask, FEditText );
  end
  else
  begin
    v1 := Value;
    ss := FEditText;
  end;
  if ( ss <> v1 ) and ( DataLink.Modify ) then
  begin
    FEditText := Value;
    FEditMask := tmpMask;
    DataLink.ControlIsModified := true;
  end;
end;

{------------------------------------------------------------------------------}

function TIB_CustomGrid.GetIsModifying( ACol, ARow: Longint;
                                        AState: TGridDrawState ): boolean;
begin
  with DataLink do
    Result := not FHideRowSelection and Prepared and
              ColorScheme and
              NeedToPost and
              not RowSelect and ( ARow = GridRow[ ActiveRecord ] );
end;

function TIB_CustomGrid.GetIsHighlighted( ACol, ARow: Longint;
                                          AState: TGridDrawState ): boolean;
var
  tmpRow: longint;
begin
  Result := false;
  if not FHideRowSelection and DataLink.Prepared and
     ( DataLink.Dataset.Fields.RowState <> rsNone ) then
  begin
    tmpRow := GridRow[ DataLink.ActiveRecord ];
    Result :=  (( RowSelect and ( ARow = tmpRow )) or
                ( IndicateHighlight and
                  not GetIsModifying( ACol, ARow, AState ) and
                  (( gdSelected in AState ) and
                   ( not (gdFocused in AState) or
                   ( [ goDrawFocusSelected, goRowSelect ] * Options <> [] )))));
  end;
end;

function TIB_CustomGrid.GetIsSelected( ACol, ARow: Longint;
                                       AState: TGridDrawState ): boolean;
begin
  with DataLink do
    Result := Prepared and
              IndicateSelected and
              not GetIsModifying( ACol, ARow, AState ) and
              Assigned( BDataset ) and
              BDataset.Selected[ DataRow[ ARow ]];
end;

function TIB_CustomGrid.GetIsOrdering( ACol, ARow: Longint;
                                       AState: TGridDrawState ): boolean;
var
  tmpFld: TIB_Column;
  tmpCol: TIB_Column;
begin
  Result := false;
  with DataLink do
  begin
    if IndicateOrdering and Prepared then
    begin
      tmpFld := Dataset.OrderingField;
      tmpCol := GridFields[ DataCol[ ACol ]];
      Result := ( State <> dssSearch ) and
                Assigned( tmpFld ) and
                Assigned( tmpCol ) and
                (( ARow <> GridRow[ Dataset.RowNum ] ) or not NeedToPost ) and
                (( tmpCol = tmpFld ) or
                 (( tmpCol.OrderingLinkItemNo = tmpFld.OrderingLinkItemNo ) and
                  ( tmpCol.OrderingLinkItemNo >= 0 )));
    end;
  end;
end;

procedure TIB_CustomGrid.GetCellProps(     ACol, ARow: Longint;
                                           AState: TGridDrawState;
                                       var AColor: TColor;
                                           AFont: TFont );
var
  clr1, clr2: integer;
begin
  if DataLink.Prepared and not DataLink.Disabled and Assigned( AFont ) then
    with DataLink.BDataset do
      if Selected[ DataRow[ ARow ]] and ( DataRow[ ARow ] = RowNum ) then
        AFont.Style := AFont.Style + [ fsBold ];

  with DataLink do
  begin
    if Disabled then
      Exit
    else
    if gdFixed in AState then
    begin
      AColor := FixedColor;
      if Assigned( AFont ) then
        AFont.Assign( FixedFont )
    end
    else
    if GetIsHighlighted( ACol, ARow, AState ) then
    begin
      AColor := clHighlight;
      if Assigned( AFont ) then
        AFont.Color := clHighlightText;
    end
    else
    if GetIsSelected( ACol, ARow, AState ) then
    begin
      AColor := IB_Session.SelectedColor;
      if Assigned( AFont ) then
        AFont.Color := clHighlightText;
    end
    else
    if Prepared then
    begin
      if Assigned( AFont ) then
        AFont.Assign( Self.Font );
      if ColorScheme then
      begin
        if State = dssSearch then
          AColor := Color
        else
        if ARow >= FixedRows then
          if Assigned( GridFields[ DataCol[ ACol ]] ) then
            if {not FHideRowSelection and}
               ( ARow = GridRow[ ActiveRecord ] ) then
            begin
              with BDataset do
                if not NeedToPost then
                begin
                  if rfEdited in BDataset.RowFlags then
                    AColor := IB_Session.EditingColor
                  else
                  if rfInserted in BDataset.RowFlags then
                    AColor := IB_Session.InsertingColor
                  else
                  if rfDeleted in RowFlags then
                    AColor := IB_Session.DeletingColor
                  else
                    AColor := CurrentRowColor;
                  if Assigned( AFont ) then
                    AFont.Assign( CurrentRowFont );
                end
                else
                begin
                  if State = dssDelete then
                    AColor := IB_Session.DeletingColor
                  else
                  begin
                    AColor := Color;
                    if Self.ReadOnly or
                     ( GridFields[ DataCol[ ACol ]].ControlsReadOnly and
                       not IsColLookup( GridFields[ DataCol[ ACol ] ] )) then
                      AColor := IB_Session.ReadOnlyColor;
                  end;
                end;
            end
            else
            if Prepared then
            begin
              BufferRecord := DataRow[ ARow ];
              if rfDeleted in BDataset.BufferRowFlags then
                AColor := IB_Session.DeletingColor;
              if ( rfEdited in BDataset.BufferRowFlags ) then
                AColor := IB_Session.EditingColor;
              if ( rfInserted in BDataset.BufferRowFlags ) then
                AColor := IB_Session.InsertingColor;
            end;
      end
      else
      if Assigned( GridFields[ DataCol[ ACol ]] ) then
        if not FHideRowSelection and ( ARow = GridRow[ ActiveRecord ] ) then
        begin
          AColor := CurrentRowColor;
          if Assigned( AFont ) then
            AFont.Assign( CurrentRowFont );
        end;
      if ( FHideRowSelection or ( ARow <> GridRow[ ActiveRecord ] )) and
         GetIsOrdering( ACol, ARow, AState ) then
      begin
        AColor := OrderingColor;
        if Assigned( AFont ) then
          AFont.Assign( OrderingFont );
      end;
    end;
    if Assigned( OnGetCellProps ) then
      OnGetCellProps( Self, ACol, ARow, AState, AColor, AFont );
    if Assigned( AFont ) then
    begin
      clr1 := ColorToRGB( AColor );
      clr2 := ColorToRGB( AFont.Color );
      if GetNearestColor( Canvas.Handle, clr1 ) =
         GetNearestColor( Canvas.Handle, clr2 ) then
      begin
        if AColor = clBlack then
          AFont.Color := clWhite
        else
          AFont.Color := clBlack;
      end;
    end;
  end;
end;

function TIB_CustomGrid.GetCellAlignment( ACol, ARow: Longint ): TAlignment;
var
  dcol: Integer;
begin
  if ( ARow >= FixedRows ) then
  begin
    dcol := DataCol[ ACol ];
    if ( GridFields[ dcol ] <> nil ) then
      // CVC 2001: Take into account possible Width in GridLinks.
      if GridLinks.Count > 0 then
        case UpCase((GetGridLinksAlign( dcol ) + '*')[1]) of
          'L': Result := taLeftJustify;
          'C': Result := taCenter;
          'R': Result := taRightJustify;
          else Result := GridFields[ dcol ].Alignment
        end
      else
        Result := GridFields[ dcol ].Alignment
    else
      Result := GetTitleAlignment(ACol, ARow);
  end
  else
    Result := GetTitleAlignment(ACol, ARow);
end;

function TIB_CustomGrid.GetTitleAlignment( ACol, ARow: Integer ): TAlignment;
begin
  Result := taLeftJustify;
  case TitleAlignment of
    gtaRightJustify: Result := taRightJustify;
    gtaCenter: Result := taCenter;
    gtaColumns: if ( RowCount > FixedRows ) and ( ARow < FixedRows ) then
      Result := GetCellAlignment( ACol, FixedRows );
  end;
end;

function TIB_CustomGrid.GetCellDisplayText( ACol, ARow: Longint ): string;
var
  ii : integer;
  AColumn: TIB_Column;
  tmpIntf: IIB_GridWinControl;
begin
  if DataLink.Prepared then
  with Datalink.BDataset do
  begin
    AColumn := GridFields[ DataCol[ ACol ]];
    if DataLink.Disabled then
      Result := ''
    else
    if ARow < FixedRows then
    begin
      if ( ARow = FixedRows - 1 ) and
         ( AColumn <> nil ) then
        Result := AColumn.GridDisplayLabel
      else
        Result := EmptyStr;
    end
    else
    if ACol < FixedCols - FixedDataCols then
      Result := ''
    else
    begin
      if BufferRowNum <> DataRow[ ARow ] then
        BufferRowNum := DataRow[ ARow ];
      Result := '';
      if ( RowNum = DataRow[ ARow ] ) and not FHideRowSelection then
      begin
        if ( Fields.RowState <> rsNone ) and
           ( AColumn <> nil ) then
          if Fields.RowState = rsModified then
          begin
            if not GetLookupText( AColumn, Result ) then
              with AColumn do
                if ( gdtShowTextBlob in FDrawCellTextOptions ) and
                   IsBlob and IsText then
                  Result := AsString
                else
                  Result := DisplayText;
          end
          else
          with AColumn do
            if ( gdtShowTextBlob in FDrawCellTextOptions ) and
               IsBlob and IsText then
                Result := AsString
            else
              Result := DisplayText;
      end
      else
      if ( BufferRowNum = DataRow[ ARow ] ) and
         ( BuffFields[ DataCol[ ACol ]] <> nil ) then
      with BuffFields[ DataCol[ ACol ]] do
      begin
        if ( gdtShowTextBlob in FDrawCellTextOptions ) and
           IsBlob and IsText then
            Result := AsString
        else
          Result := DisplayText;
      end;
    end;
    if Prepared then
    begin
      if ARow >= FixedRows then
      begin
        for ii := 0 to ControlCount - 1 do
          if Controls[ ii ].GetInterface(IIB_GridWinControl,tmpIntf) and
            Assigned(AColumn) and (AColumn = tmpIntf.DisplayColumn)  then
            Result := tmpIntf.TranslateText(Result);
      end;
      if Assigned( OnGetDisplayText ) then
        OnGetDisplayText( Self, ACol, ARow, Result );
    end;
  end;
end;

procedure TIB_CustomGrid.DrawCell( ACol, ARow: Longint;
                                   ARect: TRect;
                                   AState: TGridDrawState );
var
  Indicator: integer;
  FrameOffs: byte;
  tmpRect, tmpRect2: TRect;
  tmpColor: TColor;
  tmpFont: TFont;
// *************** Changes by Wassim Haddad 6 January 2003 ****************** //
  ii : integer;
  AColumn: TIB_Column;
  tmpIntf: IIB_GridWinControl;
  tmpIntfEx: IIB_GridWinControlEx;
// ************************************************************************** //
begin
  if csLoading in ComponentState then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ARect);
    Exit;
  end;
  if FHideRowSelection and ( AState * [ gdSelected, gdFocused ] <> [] ) then
    AState := AState - [ gdSelected, gdFocused ];
  tmpColor := Color;
  Canvas.Font.Assign( Font );
  tmpFont := Canvas.Font;
  GetCellProps( ACol, ARow, AState, tmpColor, tmpFont );
  Canvas.Brush.Color := tmpColor;
  if gdFixed in AState then
  begin
{$IFDEF IBO_VCL40_OR_GREATER}
    // normal FillRect here messes up the title headers in bidiMode
    // so we need to make sure it won't happen
    if BiDiMode = bdRightToLeft then
    begin
      ChangeGridOrientation(False);
      tmpRect := ARect;
      ARect.Left := ClientWidth - tmpRect.Right;
      ARect.Right := ClientWidth - tmpRect.Left;
      Canvas.FillRect( ARect );

      // restore everthing to prevent changes in subsequent operations
      ChangeGridOrientation(True);
      ARect := tmpRect;
    end
    else
{$ENDIF}
      Canvas.FillRect( ARect );
    tmpRect := ARect;
    if FixedColLines or FixedRowLines then
    begin
      InflateRect( tmpRect, -GridLineWidth, -GridLineWidth );
      FrameOffs := 1;
    end
    else
      FrameOffs := 2;
    if IndicateRow and ( ACol = FixedCols - FixedDataCols - 1 ) and
       Assigned( DataLink ) and
       DataLink.Prepared and
       ( Datalink.BDataset.Fields.RowState <> rsNone ) and
       ( ARow >= FixedRows ) and
       ( DataRow[ ARow ] = Datalink.BDataset.RowNum ) then
    begin
      Indicator := 0;
      if Datalink.BDataset <> nil then
      begin
        case Datalink.BDataset.State of
          dssEdit: Indicator := 1;
          dssInsert: Indicator := 2;
        end;
      end;
      with FRowIndicators do
      begin
        BkColor := Canvas.Brush.Color;
        Draw( Canvas,
              tmpRect.Right - Width - FrameOffs,
              ( tmpRect.Top + tmpRect.Bottom - Height ) shr 1,
              Indicator );
      end;
    end
    else
    if ( ACol < BorderCols ) or
       ( ARow < BorderRows ) then
    begin
      if Assigned( FOnDrawBorder ) then
        FOnDrawBorder( Self, ACol, ARow, ARect, AState );
    end
    else
    if Assigned( FOnDrawTitle ) then
      FOnDrawTitle( Self, ACol, ARow, ARect, AState )
    else
      DefaultDrawTitle( ACol, ARow,
                        ARect,
                        AState,
                        GetCellDisplayText( ACol, ARow ),
                        GetCellAlignment( ACol, ARow ));
    if not inherited DefaultDrawing and Ctl3D and
       ((FrameFlags1 or FrameFlags2) <> 0) then
    begin
      tmpRect := ARect;
      if (FrameFlags1 and BF_RIGHT) = 0 then
        Inc( tmpRect.Right, GridLineWidth )
      else
      if (FrameFlags1 and BF_BOTTOM) = 0 then
        Inc( tmpRect.Bottom, GridLineWidth );
{$IFDEF IBO_VCL40_OR_GREATER}
        // normal FillRect here messes up the title headers in bidiMode
        // so we need to make sure it won't happen
        if BiDiMode = bdRightToLeft then
        begin
          ChangeGridOrientation(False);
          tmpRect2 := tmpRect;
          tmpRect.Left := ClientWidth - tmpRect2.Right;
          tmpRect.Right := ClientWidth - tmpRect2.Left;
        end;
{$ENDIF}
      if Ctl3DShallow then
        DrawShallowEdge( Canvas, tmpRect, Options )
      else
      begin
        DrawEdge( Canvas.Handle, tmpRect, BDR_RAISEDINNER, FrameFlags1 );
        DrawEdge( Canvas.Handle, tmpRect, BDR_RAISEDINNER, FrameFlags2 );
      end;
{$IFDEF IBO_VCL40_OR_GREATER}
      // restore everthing to prevent changes in subsequent operations
      if BiDiMode = bdRightToLeft then
      begin
        ChangeGridOrientation(True);
        tmpRect := tmpRect2;
      end;
{$ENDIF}
    end;
  end
  else
  with FocusedCell do
  begin
    if ( ACol = X ) and
       ( ARow = Y ) and DataLink.Prepared and not FHideRowSelection then
    begin
      if ( not HasFocus ) or
         ( not PositionControl( ACol, ARow, ARect )) then
      begin
        if AlwaysShowEditor and HasFocus then
          ShowEditor;
        if FDefDrawBefore then
          DefaultDrawCell( ACol, ARow,
                           ARect,
                           AState,
                           GetCellDisplayText( ACol, ARow ),
                           GetCellAlignment( ACol, ARow ));
        if gdFocused in AState then
        begin
          if FDefDrawBefore then
            DefaultDrawFocusedCell( ACol, ARow,
                                    ARect,
                                    AState,
                                    GetCellDisplayText( ACol, ARow ),
                                    GetCellAlignment( ACol, ARow ));
        end;
      end;
      DoDrawFocusedCell( ACol, ARow, ARect, Canvas.Brush.Color, Canvas.Font );
    end
    else
    begin
      if FDefDrawBefore then
// *************** Changes by Wassim Haddad 6 January 2003 ****************** //
      begin
        if DataLink.Prepared and Datalink.BDataset.Prepared then
        begin
          AColumn := GridFields[ DataCol[ ACol ]];
          if ARow >= FixedRows then
          begin
            tmpIntfEx := nil;
            for ii := 0 to ControlCount - 1 do
              if Controls[ ii ].GetInterface(IIB_GridWinControlEx,tmpIntfEx) and
                Controls[ ii ].GetInterface(IIB_GridWinControl,tmpIntf) and
                Assigned(AColumn) and (AColumn = tmpIntf.DisplayColumn)  then
                  Break
              else tmpIntfEx := nil;
            if Assigned(tmpIntfEx) and tmpIntfEx.OwnersDraw then
            begin
              tmpIntfEx.OwnersDrawCell( ACol, ARow,
                                      ARect,
                                      AState,
                                      GetCellDisplayText( ACol, ARow ), //AColumn,
                                      GetCellAlignment( ACol, ARow ));
            end else begin
              DefaultDrawCell( ACol, ARow,
                               ARect,
                               AState,
                               GetCellDisplayText( ACol, ARow ),
                               GetCellAlignment( ACol, ARow ));
            end;
          end;
        end else begin
// ************************************************************************** //
          DefaultDrawCell( ACol, ARow,
                           ARect,
                           AState,
                           GetCellDisplayText( ACol, ARow ),
                           GetCellAlignment( ACol, ARow ));
// *************** Changes by Wassim Haddad 6 January 2003 ****************** //
        end;
// ************************************************************************** //
      end;
      if Assigned( OnDrawCell ) then
        OnDrawCell( Self, ACol, ARow, ARect, AState );
    end;
  end;
end;

procedure TIB_CustomGrid.DoDrawFocusedCell( ACol, ARow: longint;
                                            ARect: TRect;
                                            AColor: TColor;
                                            AFont: TFont );
begin
  if DataLink.Prepared then
  begin
    if Assigned( OnDrawFocusedCell ) then
      OnDrawFocusedCell( Self, ACol, ARow, ARect, [gdFocused] )
    else
    if Assigned( OnDrawCell ) then
      OnDrawCell( Self, ACol, ARow, ARect, [gdFocused] );
  end;
end;

procedure TIB_CustomGrid.DefaultDrawCell( ACol, ARow: longint;
                                          ARect: TRect;
                                          AState: TGridDrawState;
                                          CellDisplayText: string;
                                          CellAlignment: TAlignment );
var
  AColumn: TIB_Column;
  Indicator: integer;
  tmpInt: integer;

  procedure WriteLongText( Opts: TIB_Grid_DrawTextOptions );
  var
    tmpRect: TRect;
    tmpFlags: integer;
  begin
    // dont process '&' prefix chars
    tmpFlags := DT_NOPREFIX;
    // Support non-left-right modes...

{$IFDEF IBO_VCL40_OR_GREATER}
    if BiDiMode <> bdLeftToRight then
      tmpFlags := tmpFlags or DT_RTLREADING;
{$ENDIF}

    // add ellipsis if required
    if gdtEllipsis in Opts then
      tmpFlags := tmpFlags or DT_END_ELLIPSIS;
    // add alignment flags
    if CellAlignment = taLeftJustify then
      tmpFlags := tmpFlags or DT_LEFT
    else if CellAlignment = taRightJustify then
      tmpFlags := tmpFlags or DT_RIGHT
    else if CellAlignment = taCenter then
      tmpFlags := tmpFlags or DT_CENTER;
    // If vertical centering given, then we must draw as single line
    if (gdtVertCenter in Opts) or
      (gdtVertBottom in Opts) then
    begin
      tmpFlags := tmpFlags or DT_SINGLELINE;
      if gdtVertCenter in Opts then
        tmpFlags := tmpFlags or DT_VCENTER
      else tmpFlags := tmpFlags or DT_BOTTOM;
    end
    else
    begin
      // add wordwrap flag
      if gdtWordWrap in Opts then
        tmpFlags := tmpFlags or DT_WORDBREAK;
    end;
{$IFDEF IBO_VCL40_OR_GREATER}
    // Seems like DrawText can't handle window extents and origin used in
    // BiDiMode so we have to change grid orientation to LeftToRight and
    // recalculate the rectangle
    if BiDiMode = bdRightToLeft then
    begin
      ChangeGridOrientation(False);
      tmpRect := ARect;
      ARect.Left := ClientWidth - tmpRect.Right;
      ARect.Right := ClientWidth - tmpRect.Left;
    end;
{$ENDIF}
    // First fill the background rectangle because DrawText does not
    Canvas.FillRect( ARect );
    // Adjust the text rectangle to show some margin
    // I cannot find a "supported" method for determining an appropriate
    // margin, but this seems to work reasonably well...
    tmpRect.Top := ARect.Top + 1;
    tmpRect.Left := ARect.Left + 1 + 1;
    tmpRect.Bottom := ARect.Bottom - 1;
    tmpRect.Right := ARect.Right - 1 - 2;
    // Now draw the text
    DrawText( Canvas.Handle, PChar(CellDisplayText), -1, tmpRect, tmpFlags );
{$IFDEF IBO_VCL40_OR_GREATER}
    if BiDiMode = bdRightToLeft then
      ChangeGridOrientation(True);
{$ENDIF}
  end;
begin
  AColumn := nil;
  if DataLink.Prepared then
  begin
    if (( not FHideRowSelection and
          ( DataLink.ActiveRecord = DataRow[ ARow ] )) or
       ( DataLink.BufferRowCount = 0 )) then
      AColumn := GridFields[ DataCol[ ACol ]]
    else
    begin
      if ARow >= FixedRows then
        DataLink.BufferRecord := DataRow[ ARow ]
      else
        DataLink.BufferRecord := DataRow[ FixedRows ];
      if Datalink.BDataset.BufferFields.RowState <> rsNone then
        AColumn := BuffFields[ DataCol[ ACol ]];
    end;
  end;
  if IndicateBooleans and
     ( ARow >= FixedRows ) and
     Assigned( AColumn ) and AColumn.IsBoolean then
  begin
    WriteText( Canvas, ARect, 1, 1, EmptyStr, taLeftJustify );
    with FBooleanIndicators do
    begin
      BkColor := Canvas.Brush.Color;
      if ( AColumn.IsNull ) and ( AColumn.Row.RowState <> rsNone ) then
        Indicator := 2
      else
      if AColumn.AsBoolean then
        Indicator := 0
      else
        Indicator := 1;
      if Self.ReadOnly or
         not Ctl3d or
         AColumn.ControlsReadOnly or
         AColumn.Computed or
         ( not FHideRowSelection and
           ( DataLink.ActiveRecord <> DataRow[ ARow ] ) and
           AColumn.PreventEditing ) then
        Inc( Indicator, 3 );
      with ARect do
      begin
        case CellAlignment of
          taLeftJustify:
          begin
            Inc( Left, 2 );
            if Right > Left + Width then
              Right := Left + Width;
          end;
          taRightJustify:
          begin
            Dec( Right, 2 );
            if Left < Right - Width then
              Left := Right - Width;
          end
          else
          if Right - Left > Width then
          begin
            tmpInt := ( Right - Left - Width ) shr 1;
            Inc( Left, tmpInt );
            Dec( Right, tmpInt );
          end;
        end;
        Draw( Canvas, Left, ( Top + Bottom - Height ) shr 1, Indicator );
      end;
    end;
  end
  else
  begin
    if ( ARow = FixedRows - 1 ) then
      WriteLongText( FDrawTitleTextOptions )
    else
      WriteLongText( FDrawCellTextOptions );
  end;
end;

procedure TIB_CustomGrid.DefaultDrawFocusedCell( ACol, ARow: Longint;
                                                 ARect: TRect;
                                                 AState: TGridDrawState;
                                                 CellDisplayText: string;
                                                 CellAlignment: TAlignment );
{$IFDEF IBO_VCL40_OR_GREATER}
var
  iTemp : Integer;  // temporary var, used for exchange rect's left and right
                    // when drawing in BiDi
{$ENDIF}
begin
  if ( [goEditing,
        goAlwaysShowEditor] * Options <> [goEditing,
                                          goAlwaysShowEditor] ) and
     (( not RowSelect and
        not FHideRowSelection ) or
     (( DataLink.Prepared ) and
      ( Datalink.BDataset.Fields.RowState = rsNone ))) then
  begin
{$IFDEF IBO_VCL40_OR_GREATER}
    if BidiMode = bdRightToLeft then
    begin
      // if drawing in BiDi, left and right should be exchanged
      iTemp := ARect.left;
      ARect.Left := ARect.Right;
      ARect.Right := iTemp;
    end;
{$ENDIF}
    DrawFocusRect( Canvas.Handle, ARect );
  end;
end;

procedure TIB_CustomGrid.DefaultDrawTitle( ACol, ARow: longint;
                                           ARect: TRect;
                                           AState: TGridDrawState;
                                           CellDisplayText: string;
                                           CellAlignment: TAlignment );
var
  Indicator: integer;
  tmpRect: TRect;
  tmpNo, j: integer;
  FIndicatorList: TImageList;
  ii: TIB_Grid_GlyphType;
begin
  DefaultDrawCell( ACol, ARow, ARect, AState, CellDisplayText, CellAlignment );
  if IndicateOrdering and ( ARow = FixedRows - 1 ) then
  begin
    Indicator := -1;
    if DataLink.Prepared then
    begin
      if GridFields[ DataCol[ ACol ]] <> nil then
      begin
        with DataLink.Dataset, GridFields[ DataCol[ ACol ]] do
        begin
          tmpNo := OrderingLinkItemNo;
          if tmpNo >= 0 then
          begin
            if Abs( OrderingItemNo ) = tmpNo then
            begin
              if OrderingItemNo > 0 then
              begin
                if GetOrderingSQL( -tmpNo ) <> EmptyStr then
                  Indicator := ord(ggBiUp)
                else
                  Indicator := ord(ggUp);
              end
              else
              if OrderingItemNo < 0 then
              begin
                if GetOrderingSQL( tmpNo ) <> EmptyStr then
                  Indicator := ord(ggBiDown)
                else
                  Indicator := ord(ggDown);
              end
              else
                Indicator := ord(ggNatural);
            end
            else
            begin
              Indicator := ord(ggNaturalSortable);
              if tmpNo <> 0 then
              begin
                if GetOrderingSQL( tmpNo ) <> EmptyStr then
                begin
                  if GetOrderingSQL( -tmpNo ) <> EmptyStr then
                    Indicator := ord(ggBiSortable)
                  else
                    Indicator := ord(ggUpSortable);
                end
                else
                if GetOrderingSQL( -tmpNo ) <> EmptyStr then
                  Indicator := ord(ggDownSortable);
              end;
            end;
          end;
        end;
      end;
    end;
    if Indicator >= 0 then
    begin
{$IFDEF IBO_VCL40_OR_GREATER}
      // in BiDi mode, change the grid orientation and recalc the rect
      // for proper drawing of indicators
      if BidiMode = bdRightToLeft then
      begin
        ChangeGridOrientation(false);
        tmpRect := ARect;
        ARect.left := ClientWidth - tmpRect.Right;
        ARect.Right := ClientWidth - tmpRect.Left
      end;
{$ENDIF}
      if (TIB_Grid_GlyphType(Indicator) in CustomGlyphsSupplied) and
         (CustomGlyphs <> nil) then
        FIndicatorList := FCustomGlyphs
      else
        FIndicatorList := FOrderingIndicators;
      tmpRect := ARect;
      if ColLines or RowLines then
        InflateRect( tmpRect, -GridLineWidth, -GridLineWidth );
      case GetTitleAlignment(ACol,ARow) of
        taLeftJustify:
        begin
          if ( tmpRect.Right - tmpRect.Left ) >
             ( Canvas.TextWidth( CellDisplayText ) + 4 +
               FIndicatorList.Width ) then
            tmpRect.Left := tmpRect.Left + Canvas.TextWidth(CellDisplayText) + 3
          else
            Exit;
        end;
        taRightJustify:
        begin
          if ( tmpRect.Right - tmpRect.Left ) >
             ( Canvas.TextWidth( CellDisplayText ) + 4 +
               FIndicatorList.Width ) then
            tmpRect.Left := tmpRect.Left + 3
          else
            Exit;
        end
        else
        begin
          if ( tmpRect.Right - tmpRect.Left ) >
             ( Canvas.TextWidth( CellDisplayText ) + 4 +
               FIndicatorList.Width * 2 ) then
            tmpRect.Left := tmpRect.Right - FIndicatorList.Width - 3
          else
            Exit;
        end;
      end;
      if (TIB_Grid_GlyphType(Indicator) in CustomGlyphsSupplied) and
         (CustomGlyphs <> nil) then
      begin
        j := -1;
        for ii := ggUpSortable to TIB_Grid_GlyphType(Indicator) do
          if ii in CustomGlyphsSupplied then
            Inc(j);
        if j >= 0 then
          with FCustomGlyphs do
          begin
            FDrawingCustomGlyph := True;
            BkColor := Canvas.Brush.Color;
            Draw( Canvas, tmpRect.Left,
                ( tmpRect.Top + tmpRect.Bottom - Height ) shr 1,
                  j );
            FDrawingCustomGlyph := False;
          end;
      end
      else
      with FOrderingIndicators do
      begin
        BkColor := Canvas.Brush.Color;
        Draw( Canvas, tmpRect.Left,
            ( tmpRect.Top + tmpRect.Bottom - Height ) shr 1,
              ord(Indicator));
      end;
{$IFDEF IBO_VCL40_OR_GREATER}
      // in BiDi mode, restore grid orientation
      // for proper drawing of indicators
      if BidiMode = bdRightToLeft then ChangeGridOrientation(True);
{$ENDIF}
    end;
  end;
end;

function TIB_CustomGrid.SelectCell( ACol, ARow: longint ): boolean;
var
  AGridCoord: TGridCoord;
begin
  AGridCoord.X := Col;
  AGridCoord.Y := Row;
  Result := inherited SelectCell( ACol, ARow );
  if Result then
  begin
    if DataLink.Prepared then
    begin
      AGridCoord.X := ACol;
      AGridCoord.Y := ARow;
    end
    else
    begin
      AGridCoord.X := -1;
      AGridCoord.Y := -1;
    end;
    SysUpdateEditor;
  end;
  SetFocusedCell( AGridCoord );
end;

procedure TIB_CustomGrid.TopLeftChanged;
begin
  inherited TopLeftChanged;
  if Assigned( FOnTopLeftChanged ) then
    FOnTopLeftChanged( Self );
end;

procedure TIB_CustomGrid.KeyPress( var Key: Char );
begin

{ start changes by helmut, fixed by Geoff & Tobias}
  if not FIgnoreKeypress then
  begin
{ end changes by helmut, fixed by Geoff & Tobias}
    if FIncSearchState and ( Key <> #09 ) then
      DoIncSearchKeyPress( Key )
    else
    if Key = #13 then
      SysUpdateData( nil );
{ start changes by helmut, fixed by Geoff & Tobias}
  end;
  FIgnoreKeypress := False;
{ end changes by helmut, fixed by Geoff & Tobias}
  inherited KeyPress( Key );
end;

function TIB_CustomGrid.GetRowLines: boolean;
begin
  Result := goHorzLine in inherited Options;
end;

procedure TIB_CustomGrid.SetRowLines( AValue: boolean );
begin
  if RowLines <> AValue then
  begin
    if AValue then
      inherited Options := Options + [goHorzLine]
    else
      inherited Options := Options - [goHorzLine];
  end;
end;

function TIB_CustomGrid.GetFixedRowLines: boolean;
begin
  Result := goFixedHorzLine in inherited Options;
end;

procedure TIB_CustomGrid.SetFixedRowLines( AValue: boolean );
begin
  if FixedRowLines <> AValue then
  begin
    if AValue then
      inherited Options := Options + [goFixedHorzLine]
    else
      inherited Options := Options - [goFixedHorzLine];
  end;
end;

function TIB_CustomGrid.GetColLines: boolean;
begin
  Result := goVertLine in inherited Options;
end;

procedure TIB_CustomGrid.SetColLines( AValue: boolean );
begin
  if ColLines <> AValue then
  begin
    if AValue then
      inherited Options := Options + [goVertLine]
    else
      inherited Options := Options - [goVertLine];
  end;
end;

function TIB_CustomGrid.GetFixedColLines: boolean;
begin
  Result := goFixedVertLine in inherited Options;
end;

procedure TIB_CustomGrid.SetFixedColLines( AValue: boolean );
begin
  if FixedColLines <> AValue then
  begin
    if AValue then
      inherited Options := Options + [goFixedVertLine]
    else
      inherited Options := Options - [goFixedVertLine];
  end;
end;

function TIB_CustomGrid.GetThumbTracking: boolean;
begin
  Result := goThumbTracking in Options;
end;

procedure TIB_CustomGrid.SetThumbTracking( AValue: boolean );
begin
  if ThumbTracking <> AValue then
  begin
    if AValue then
      inherited Options := Options + [goThumbTracking]
    else
      inherited Options := Options - [goThumbTracking];
  end;
end;

function TIB_CustomGrid.GetAlwaysShowEditor: boolean;
begin
  Result := goAlwaysShowEditor in Options;
end;

procedure TIB_CustomGrid.SetAlwaysShowEditor( AValue: boolean );
begin
  if AlwaysShowEditor <> AValue then
  begin
    if AValue then
      inherited Options := Options + [goAlwaysShowEditor]
    else
      inherited Options := Options - [goAlwaysShowEditor];
    SelectCell( Col, Row );
  end;
end;

function TIB_CustomGrid.GetRowSelect: boolean;
begin
  Result := goRowSelect in Options;
end;

procedure TIB_CustomGrid.SetRowSelect( AValue: boolean );
var
  NewPoint: TGridCoord;
  NewRect: TGridRect;
begin
  if RowSelect <> AValue then
  begin
    if AValue then
      inherited Options := Options + [goRowSelect]
    else
      inherited Options := Options - [goRowSelect];
    if not ( csDestroying in ComponentState ) then
    begin
      NewPoint := FocusedCell;
      if NewPoint.X = - 1 then NewPoint.X := FixedCols;
      if NewPoint.Y = - 1 then NewPoint.Y := Row;
      SelectCell( NewPoint.X, NewPoint.Y );
      if not AValue then
      begin
        NewRect.Top := NewPoint.Y;
        NewRect.Left := NewPoint.X;
        NewRect.Bottom := NewPoint.Y;
        NewRect.Right := NewPoint.X;
        Selection := NewRect;
      end;
    end;
  end;
end;

function TIB_CustomGrid.GetDrawFocusSelected: boolean;
begin
  Result := goDrawFocusSelected in Options;
end;

procedure TIB_CustomGrid.SetDrawFocusSelected( AValue: boolean );
begin
  if DrawFocusSelected <> AValue then
  begin
    if AValue then
      inherited Options := Options + [goDrawFocusSelected]
    else
      inherited Options := Options - [goDrawFocusSelected];
    if not ( csDestroying in ComponentState ) then
      if ( FocusedCell.X <> - 1 ) and ( FocusedCell.Y <> - 1 ) then
        SelectCell( Col, Row );
  end;
end;

function TIB_CustomGrid.GetFixedCols: integer;
begin
  Result := inherited FixedCols;
end;

function TIB_CustomGrid.GetFixedRows: integer;
begin
  Result := inherited FixedRows;
end;

procedure TIB_CustomGrid.SetFixedRows( AValue: integer );
begin
  inherited FixedRows := AValue;
end;

function TIB_CustomGrid.GetOptions: TGridOptions;
begin
  Result := inherited Options;
end;

procedure TIB_CustomGrid.SetTrackGridRow( AValue: boolean );
begin
  if TrackGridRow <> AValue then
  begin
    FTrackGridRow := AValue;
    UpdateScrollBar;
  end;
end;

procedure TIB_CustomGrid.SetIndicateBooleans( AValue: boolean );
begin
  if IndicateBooleans <> AValue then
  begin
    FIndicateBooleans := AValue;
    Invalidate;
  end;
end;

procedure TIB_CustomGrid.SetIndicateOrdering( AValue: boolean );
begin
  if IndicateOrdering <> AValue then
  begin
    FIndicateOrdering := AValue;
    Invalidate;
  end;
end;

procedure TIB_CustomGrid.SetIndicateRow( AValue: boolean );
begin
  if IndicateRow <> AValue then
  begin
    if IndicateRow then
      inherited FixedCols := inherited FixedCols - 1
    else
    begin
      if ColCount < FixedCols + 2 then
        try
          FUpdatingColCount := true;
          ColCount := FixedCols + 2;
        finally
          FUpdatingColCount := false;
        end;
      inherited FixedCols := inherited FixedCols + 1;
    end;
    FIndicateRow := AValue;
    UpdateColumnAttributes;
  end;
end;

procedure TIB_CustomGrid.SetIndicateSelected( AValue: boolean );
begin
  if IndicateSelected <> AValue then
  begin
    FIndicateSelected := AValue;
    Invalidate;
  end;
end;

procedure TIB_CustomGrid.SetIndicateHighlight( AValue: boolean );
begin
  if IndicateHighlight <> AValue then
  begin
    FIndicateHighlight := AValue;
    Invalidate;
  end;
end;

procedure TIB_CustomGrid.SetIndicateTitles( AValue: boolean );
begin
  if IndicateTitles <> AValue then
  begin
    if IndicateTitles then
      inherited FixedRows := inherited FixedRows - 1
    else
    begin
      if RowCount < FixedRows + 2 then
        RowCount := FixedRows + 2;
      inherited FixedRows := inherited FixedRows + 1;
    end;
    FIndicateTitles := AValue;
    UpdateRowCount;
    UpdateScrollBar;
    Invalidate;
  end;
end;

function TIB_CustomGrid.GetIndicateLongTitle: boolean;
begin
  Result := gdtEllipsis in FDrawTitleTextOptions;
end;

procedure TIB_CustomGrid.SetIndicateLongTitle( AValue: boolean );
begin
  if IndicateLongTitle <> AValue then
  begin
    if AValue then
      FDrawTitleTextOptions := FDrawTitleTextOptions + [gdtEllipsis]
    else
      FDrawTitleTextOptions := FDrawTitleTextOptions - [gdtEllipsis];
    Invalidate;
  end;
end;

function TIB_CustomGrid.GetIndicateLongCellText: boolean;
begin
  Result := gdtEllipsis in FDrawCellTextOptions;
end;

procedure TIB_CustomGrid.SetIndicateLongCellText( AValue: boolean );
begin
  if IndicateLongCellText <> AValue then
  begin
    if AValue then
      FDrawCellTextOptions := FDrawCellTextOptions + [gdtEllipsis]
    else
      FDrawCellTextOptions := FDrawCellTextOptions - [gdtEllipsis];
    Invalidate;
  end;
end;

procedure TIB_CustomGrid.SetDrawCellTextOptions(
                                             AValue: TIB_Grid_DrawTextOptions );
begin
  if FDrawCellTextOptions <> AValue then
  begin
    FDrawCellTextOptions := AValue;
    Invalidate;
  end;
end;

procedure TIB_CustomGrid.SetDrawTitleTextOptions(
                                             AValue: TIB_Grid_DrawTextOptions );
begin
  if FDrawTitleTextOptions <> AValue then
  begin
    FDrawTitleTextOptions := AValue;
    Invalidate;
  end;
end;

procedure TIB_CustomGrid.SetBorderRows( AValue: integer );
var
  Delta: integer;
begin
  AValue := Abs( AValue );
  if BorderRows <> AValue then
  begin
    Delta := AValue - BorderRows;
    if RowCount <= FixedRows + Delta then
      RowCount := FixedRows + Delta + 1;
    SetFixedRows( FixedRows + Delta );
    FBorderRows := AValue;
    UpdateRowCount;
    UpdateScrollbar;
    Invalidate;
  end;
end;

procedure TIB_CustomGrid.SetFixedDataCols( AValue: integer );
var
  Delta: integer;
begin
  if FFixedDataCols <> AValue then
  begin
    if AValue < 0 then
      raise EIB_Error.Create( 'Invalid FixedDataCols' );
    Delta := AValue - FFixedDataCols;
    FFixedDataCols := AValue;
    if ColCount <= FixedCols + Delta then
      try
        FUpdatingColCount := true;
        ColCount := FixedCols + Delta + 1;
      finally
        FUpdatingColCount := false;
      end;
    inherited FixedCols := inherited FixedCols + Delta;
    UpdateColumnAttributes;
  end;
end;

procedure TIB_CustomGrid.SetBorderCols( AValue: integer );
var
  Delta: integer;
  ii: integer;
begin
  if BorderCols <> AValue then
  begin
    if AValue < 0 then
      raise EIB_Error.Create( 'Invalid BorderCols' );
    Delta := AValue - BorderCols;
    FBorderCols := AValue;
    if ColCount <= FixedCols + Delta then
      try
        FUpdatingColCount := true;
        ColCount := FixedCols + Delta + 1;
      finally
        FUpdatingColCount := false;
      end;
    if Delta > 0 then
    begin
      inherited FixedCols := inherited FixedCols + Delta;
      Inc( FInGridLayoutLevel );
      try
        for ii := BorderCols - Delta to BorderCols - 1 do
          ColWidths[ ii ] := DefaultColWidth;
      finally
        Dec( FInGridLayoutLevel );
      end;
    end
    else
      inherited FixedCols := inherited FixedCols + Delta;
    UpdateColumnAttributes;
  end;
end;

function TIB_CustomGrid.GetBorderRowHeight( Index: integer ): integer;
begin
  if ( Index >= 0 ) and ( Index < BorderRows ) then
    Result := RowHeights[ Index ]
  else
    Result := DefaultRowHeight;
end;

procedure TIB_CustomGrid.SetBorderRowHeight( Index: integer; AValue: integer );
begin
  if ( Index >= 0 ) and ( Index < BorderRows ) then
    if RowHeights[ Index ] <> AValue then
      RowHeights[ Index ] := AValue;
end;

function TIB_CustomGrid.GetBorderColWidth( Index: integer ): integer;
begin
  if ( Index >= 0 ) and ( Index < BorderCols ) then
    Result := ColWidths[ Index ]
  else
    Result := DefaultColWidth;
end;

procedure TIB_CustomGrid.SetBorderColWidth( Index: integer; AValue: integer );
begin
  if ( Index >= 0 ) and ( Index < BorderCols ) then
    ColWidths[ Index ] := AValue;
end;

procedure TIB_CustomGrid.SetCurrentRowColor( AValue: TColor );
begin
  if CurrentRowColor <> AValue then
  begin
    FCurrentRowColor := AValue;
    InvalidateRow( Row, true );
  end;
end;

procedure TIB_CustomGrid.SetCurrentRowFont( AValue: TFont );
begin
  FCurrentRowFont.Assign( AValue );
  InvalidateRow( Row, true );
end;

procedure TIB_CustomGrid.SetOrderingColor( AValue: TColor );
begin
  if OrderingColor <> AValue then
  begin
    FOrderingColor := AValue;
    Invalidate;
  end;
end;

procedure TIB_CustomGrid.SetOrderingFont( AValue: TFont );
begin
  FOrderingFont.Assign( AValue );
  Invalidate;
end;

procedure TIB_CustomGrid.SetFixedFont( AValue: TFont );
begin
  FFixedFont.Assign( AValue );
  Invalidate;
end;

procedure TIB_CustomGrid.SetGridLinks( AValue: TIB_StringList );
begin
  FGridLinks.Text := AValue.Text;
end;

procedure TIB_CustomGrid.SetEditLinks( AValue: TIB_StringList );
begin
  FEditLinks.Text := AValue.Text;
end;

procedure TIB_CustomGrid.SetTabStopLinks( AValue: TIB_StringList );
begin
  FTabStopLinks.Text := AValue.Text;
end;

procedure TIB_CustomGrid.GridLinksChange( Sender: TObject );
begin
  LayoutChange( nil, nil );
end;

function TIB_CustomGrid.GetColMoving: boolean;
begin
  Result := goColMoving in Options;
end;

function TIB_CustomGrid.GetColSizing: boolean;
begin
  Result := goColSizing in Options;
end;

procedure TIB_CustomGrid.SetColMoving( AValue: boolean );
begin
  if ColMoving <> AValue then
    if AValue then
      inherited Options := Options + [ goColMoving ]
    else
      inherited Options := Options - [ goColMoving ];
end;

procedure TIB_CustomGrid.SetColSizing( AValue: boolean );
begin
  if ColSizing <> AValue then
    if AValue then
      inherited Options := Options + [ goColSizing ]
    else
      inherited Options := Options - [ goColSizing ];
end;

procedure TIB_CustomGrid.ColWidthsChanged;
var
  ii: integer;
  dw: Integer;
begin
  inherited ColWidthsChanged;
  if not InGridLayout then
  begin
    DrawCell( FocusedCell.X, FocusedCell.Y,
              CellRect( FocusedCell.X, FocusedCell.Y ),
              [gdSelected, gdFocused] );
    if not FUpdatingColAttr then
    begin
      for ii := 0 to GridFieldCount - 1 do
      begin
        with GridFields[ ii ] do
        begin
          // CVC 2001 => Cater for GridLinks, we shouldn't affect the TIB_Column
          // if GridLinks is present, otherwise we would affect the dataset and
          // hence all grids, that's the issue we are trying to avoid.
          if GridLinks.Count > 0
          then dw := StrToIntDef(GetGridLinksWidth(ii), DisplayWidth)
          else dw := DisplayWidth;
          if dw <> ColWidths[ ii + FixedCols - FixedDataCols ] then
          begin
            if ListBoxStyle and ( StretchColRef = GridFields[ ii ] ) then
            else begin
              dw := ColWidths[ ii + FixedCols - FixedDataCols ];
              if GridLinks.Count > 0
              then SetGridLinksWidth(ii, IntToStr(dw))
              else DisplayWidth := dw
            end
          end;
        end;
      end;
      if ListBoxStyle or TrackGridRow {?} then
        UpdateColumnAttributes;
    end;
  end;
end;

procedure TIB_CustomGrid.ColumnMoved( FromIndex, ToIndex: Longint );
var
  AGridCoord: TGridCoord;
begin
  if ( FromIndex <= FocusedCell.X ) or
     ( ToIndex <= FocusedCell.X ) then
  begin
    if FocusedCell.X = FromIndex then
      AGridCoord.X := ToIndex
    else
    if ( FocusedCell.X > ToIndex ) and
       ( FocusedCell.X > FromIndex ) then
      AGridCoord.X := FocusedCell.X
    else
    if ( FocusedCell.X > FromIndex ) then
      AGridCoord.X := FocusedCell.X - 1
    else
      AGridCoord.X := FocusedCell.X + 1;
    AGridCoord.Y := Row;
    SetFocusedCell( AGridCoord );
  end;
  Dec( FromIndex, FixedCols - FixedDataCols );
  Dec( ToIndex,   FixedCols - FixedDataCols );
  if GridLinks.Count > 0 then
    GridLinks.Move( integer(FFieldsToGridLinks[FromIndex]),
                    integer(FFieldsToGridLinks[ToIndex]) )
  else
    GridFields[ FromIndex ].Index := GridFields[ ToIndex ].Index;
  FMouseWasMoved := true;
end;

function TIB_CustomGrid.GetInGridLayout: boolean;
begin
  Result := FInGridLayoutLevel > 0;
end;

procedure TIB_CustomGrid.SetDefaultColWidth(Value: Integer);
begin
  inherited DefaultColWidth := Value;
  UpdateColumnAttributes;
end;

procedure TIB_CustomGrid.SetCtl3DShallow( AValue: boolean );
begin
  if Ctl3DShallow <> AValue then
  begin
    FCtl3DShallow := AValue;
    Invalidate;
  end;
end;

procedure TIB_CustomGrid.SetFocusedCell( AValue: TGridCoord );
var
  ii: integer;
  NeedFocus: boolean;
  WCtl: TWinControl;
begin
  // This var used to hold reference to any dropped controls which
  // may need hiding - which I do NOT do until the new focus has
  // been achieved (otherwise the grid gets an exit event).
  WCtl := nil;
  if ( FocusedCell.X <> AValue.X ) or ( FocusedCell.Y <> AValue.Y ) then
  begin
    NeedFocus := false;
    for ii := 0 to ControlCount - 1 do
    begin
      // This was a series of if control is type statements,
      // simplified to test for WinControl type since we only
      // need access to the visible property.
      if (Controls[ii] is TWinControl) and
         (Controls[ii] as TWinControl).Visible and
         not(Controls[ii] = InplaceEditor) then
      begin
        WCtl := TWinControl(Controls[ii]);
        NeedFocus := ( AValue.X <> -1 ) and ( AValue.Y <> -1 );
      end;
    end;
    // Force the inplace-edit control to hide, stops it reappearing when
    // we dont really want it.  It will be shown again if necessary.
    if (WCtl = nil) and (InplaceEditor <> nil) and InplaceEditor.Visible then
    begin
      NeedFocus := ( AValue.X <> -1 ) and ( AValue.Y <> -1 );
      HideEditor;
    end;
    if ( FocusedCell.X <> -1 ) and
       ( FocusedCell.Y <> -1 ) then
    begin
      if HasFocus{generally} and NeedFocus{specifically} and CanFocus then
        SetFocus;
      DoCellLoseFocus( FFocusedCell );
    end;
    if ( AValue.X <> -1 ) and ( AValue.X <> -1 ) then
      DoCellGainFocus( AValue )
    else
      HideEditor;
    FFocusedCell.X := AValue.X;
    FFocusedCell.Y := AValue.Y;
    if FSelRow <> FocusedCell.Y then
    begin
      InvalidateRow( FocusedCell.Y, false );
      InvalidateRow( FSelRow, false );
      if FocusedCell.Y <> - 1 then
        FSelRow := FocusedCell.Y;
    end;
  end;
  if (WCtl <> nil) then
    WCtl.Visible := false;
  if ( FocusedCell.X <> -1 ) and
     ( FocusedCell.Y <> -1 ) then
    InvalidateCell( FocusedCell.X, FocusedCell.Y );
end;

procedure TIB_CustomGrid.DoCellGainFocus( AGridCoord: TGridCoord );
begin
  if not ( csDestroying in ComponentState ) and
     Assigned( FOnCellGainFocus ) then
    FOnCellGainFocus( Self, AGridCoord.X, AGridCoord.Y );
end;

procedure TIB_CustomGrid.DoCellLoseFocus( AGridCoord: TGridCoord );
begin
  if not ( csDestroying in ComponentState ) and
     Assigned( FOnCellLoseFocus ) then
    FOnCellLoseFocus( Self, AGridCoord.X, AGridCoord.Y );
end;

{------------------------------------------------------------------------------}

procedure TIB_CustomGrid.ProcessStatementEvent( AEvent: TIB_StatementEventType;
                                                Info: longint );
var
  AField: TIB_ColumnRef absolute Info;
  tmpCol: integer;
  tmpRow: integer;
begin
  if AEvent = setFieldsRefsChanged then
    DefineFieldMap
  else
  if AEvent = setAfterAssignment then
  begin
    if Assigned( Datalink.BDataset ) and
       not ( Datalink.BDataset is TIB_BDataset ) then
    begin
      DataSource := nil;
      raise EIB_Error.Create( E_MustBe_Buffered_Dataset );
    end
    else
    begin
      HideEditor;
      DefineFieldMap;
      SysStateChanged;
    end;
  end
  else
  if ( AEvent = setInvalidateRows ) or
     ( AEvent = setSelectedChanged ) then
  begin
    if Info < DataLink.BDataset.BofRowNum then
      Invalidate
    else
      InvalidateRow( GridRow[ Info ], (Info = DataLink.BDataset.RowNum) );
  end
  else
  if AEvent = setShowNearest then
    with DataLink do
    begin
    // Try and keep the current record visible in the grid if possible.
      if Info < BDataset.BofRowNum then
        Info := ActiveRecord;
      if Abs( ActiveRecord - Info ) <= VisibleGridRows then
        Info := Info + ( ActiveRecord - Info ) div 2;
    // Make the requested row visible without making it the current selection.
      if IndicateNearest then
      begin
        tmpRow := Info - VisibleGridRows div 2;
      // Prevent pulling in records from the DescCursor for better performance.
        if tmpRow <= DataLink.Dataset.BofRowNum then
          tmpRow := DataLink.Dataset.BofRowNum + 1;
        TopRowNum := tmpRow;
      end;
    end
  else
  if AEvent = setFocusControl then
  begin
  // Don't clear the pointer in order to defer to another control.
    if FGridFields.IndexOf( AField^ ) >= 0 then
    begin
      tmpCol := FGridFields.IndexOf( AField^ );
      if tmpCol <> - 1 then
        MoveCol( GridCol[ tmpCol ], 0 );
    end;
    if Assigned( FParentCombo ) then
    begin
      if FParentCombo.CanFocus and
         (( AField^.FieldName = FParentCombo.DisplayField ) or
          ( Assigned( Datalink.BDataset ) and
          ( AField^.FieldName = Datalink.BDataset.OrderingLink ))) then
        FParentCombo.SetFocus;
    end;
  end;
  if Assigned( FParentCombo ) then
    if AEvent = setAfterAssignment then
      FParentCombo.DataLink.DataSource := DataLink.KeySource
    else
    if AEvent in [ setFieldsDataChange , setOrderingChanged ] then
      FParentCombo.SysDataChange( nil );
end;

procedure TIB_CustomGrid.Paint;
var
  oldBufRow: longint;
  ii: integer;
begin
  Inc( FPaintingLevel );
  try
  if goFixedVertLine in Options then
  begin
    FrameFlags1 := BF_RIGHT;
    FrameFlags2 := BF_LEFT;
  end
  else
  begin
    FrameFlags1 := 0;
    FrameFlags2 := 0;
  end;
  if goFixedHorzLine in Options then
  begin
    FrameFlags1 := FrameFlags1 or BF_BOTTOM;
    FrameFlags2 := FrameFlags2 or BF_TOP;
  end;
  if not DataLink.Disabled and DataLink.Prepared then
    with Datalink.BDataset do
      try
        BeginCallbackFreeze;
        try
          ValidateRows( TopRowNum, TopRowNum + VisibleGridRows - 1 );
        finally
          EndCallbackFreeze;
        end;
      except
        // Ignore any exception here.
      end;
// Since the VCL makes the assumption that the InPlace editor exists in the
// focused cell if FEditorMode is true it does NOT send a DrawCell() call for
// the focused cell. But, with IBO, the CanEditShow() method returns false
// in cases where the embedded lookup combo or check box are to be. Thus,
// I still need the DrawCell() call in order to draw these controls/glyphs
// properly. What this hack does is trick the VCL into thinking that there is
// no InPlace editor so it will send a DrawCell() call for all cells that have
// been invalidated.
// 13-Feb-2002 GMW: The status of FEditorMode may be specifically reset during
// paint processing (eg: via calls to ShowEditor, HideEditor) so instead of
// just resetting FEditorMode to its old value, we must resync according to
// whether the inplace editor is showing (to keep FEditorMode in sync with
// what TCustomGrid expects).
  oldBufRow := DataLink.BufferRecord;
  try
    THackCustomGrid( Self ).FEditorMode := false;
    inherited Paint;
  finally
    if Assigned(InplaceEditor) and
      InplaceEditor.HandleAllocated and InplaceEditor.Visible then
      THackCustomGrid( Self ).FEditorMode := true
    else
      THackCustomGrid( Self ).FEditorMode := false;        
    DataLink.BufferRecord := oldBufRow;
  end;
  for ii := 0 to ControlCount - 1 do
    // This was a series of if control is type statements,
    // simplified to test for WinControl type since we only
    // need access to the visible property.
    if (Controls[ii] is TWinControl) and not(Controls[ii] = InplaceEditor) then
      with TWinControl(Controls[ii]) do
        if Visible and
           (( FocusedCell.X < LeftCol ) or
            ( FocusedCell.X > LeftCol + VisibleColCount )) then
          Visible := false;
  finally
    Dec( FPaintingLevel );
  end;
end;

procedure TIB_CustomGrid.SetParentCombo( AValue: TIB_CustomCombo );
begin
  if ParentCombo <> AValue then
  begin
    if Assigned( ParentCombo ) then
    begin
      ParentCombo.FCustomPopup := nil;
      ParentCombo.SysStateChanged;
    end
    else
    begin
      FOldParent := Parent;
      FOldVisible := Visible;
      if Assigned( FOldParent ) then
        FOldParent.FreeNotification( Self );
    end;
    FParentCombo := AValue;
    if not ( csDesigning in ComponentState ) and
       not ( csDestroying in ComponentState ) then
    begin
      if Assigned( ParentCombo ) then
      begin
        Parent := ParentCombo;
        Visible := false;
      end
      else
      begin
        Parent := FOldParent;
        Visible := FOldVisible;
      end;
      RecreateWnd;
    end;
  end;
end;

procedure TIB_CustomGrid.Invalidate;
begin
  inherited Invalidate;
  if HandleAllocated then
  begin
    // force the update on any control that happens to be there.
    SysUpdateEditor;
    PositionControl( Col, Row, CellRect(Col,Row) );
  end;
end;

procedure TIB_CustomGrid.InvalidateRow( ARow: longint; IsCurrRow: boolean );
var
  ii: integer;
begin
  if not HandleAllocated then Exit;
  inherited InvalidateRow( ARow );
  for ii := VisibleColCount + 2 to ColCount - 1 do
    InvalidateCell( ii, ARow );
  // If invalidating the current row then force the update
  // on any control that happens to be there.
  if IsCurrRow then
  begin
    SysUpdateEditor;
    PositionControl( Col, Row, CellRect(Col,Row) );
  end;
end;

procedure TIB_CustomGrid.InvalidateCol( ACol: longint; IsCurrRow: boolean );
begin
  if not HandleAllocated then Exit;
  inherited InvalidateCol( ACol );
  // If invalidating the current column then force the update
  // on any control that happens to be there.
  if IsCurrRow then
  begin
    SysUpdateEditor;
    PositionControl( Col, Row, CellRect(Col,Row) );
  end;
end;

procedure TIB_CustomGrid.SetCustomGlyphs(Value: TImageList);
begin
  if Assigned( FCustomGlyphs ) then
    FCustomGlyphs.OnChange := nil;
  FCustomGlyphs := Value;
  if Assigned( FCustomGlyphs ) then
    FCustomGlyphs.OnChange := CustomGlyphsChange;
  Invalidate;
end;

procedure TIB_CustomGrid.SetCustomGlyphsSupplied(Value: TIB_Grid_GlyphSet);
begin
  FCustomGlyphsSupplied := Value;
  Invalidate;
end;

procedure TIB_CustomGrid.CustomGlyphsChange(Sender: TObject);
begin
  if not FDrawingCustomGlyph and
     not ( csDestroying in ComponentState ) then
    Invalidate;
end;

procedure TIB_CustomGrid.CMControlListChange(
  var Message: TCMControlListChange );
var
  tmpIntf: IIB_GridWinControl;
begin
  if ( Message.Inserting ) and
     ( Message.Control.Parent = Self ) and
     not (( Message.Control is TInplaceEdit )or
          ( Message.Control is TDatePick ) or
          ( Message.Control is TSpeedButton ) or
          ( Message.Control is TIB_CustomGrid ) or
          ( Message.Control.GetInterface( IIB_GridWinControl, tmpIntf ))) then
    raise EIB_Error.Create( 'Control cannot be placed on the grid' );
end;

// This message function is able intercept the KeyDown event of all child
// components (but nothing similar for KeyPress or KeyUp that I can see).
// I added this to support TCustomEditEnh being dropped on the grid without
// having to add any grid specific items to that control.  However this
// should work for all child controls - and should successfully take over
// from the special processing already being performed in lookupcombo etc.
procedure TIB_CustomGrid.CMChildKey( var Msg: TCMChildKey );
var
  Shift: TShiftState;
  Key: Word;
  NavToGrid: boolean;
  tmpIntf: IIB_GridWinControl;
  // Short function to retrieve keyboard shift state
  // (essentially a copy of similar defined in Control.PAS, but this one
  // also uses GetKeyState for the Alt-key (VK_MENU) since it does not
  // get this information with the message.)
  function GetShiftKeyStates: TShiftState;
  begin
    Result := [];
    if GetKeyState( VK_SHIFT   ) < 0 then Include( Result, ssShift );
    if GetKeyState( VK_CONTROL ) < 0 then Include( Result, ssCtrl  );
    if GetKeyState( VK_MENU    ) < 0 then Include( Result, ssAlt   );
  end;
begin
  if not (csDesigning in ComponentState) then
  begin
    Key := Msg.CharCode;
    Shift := GetShiftKeyStates;
    NavToGrid := false; // default to passing navigation to child
    // if always navigate in browse check for editing state...
    if gnBrowseAlwaysNavigate in FNavigateOptions then
      NavToGrid := not DataLink.Editing;
    // if ctrl key navigation enabled check for ctrl state...
    if (gnCtrlNavigate in FNavigateOptions) and (ssCtrl in Shift) then
      NavToGrid := true;
    if NavToGrid then
    begin
      if ssAlt in Shift then
        NavToGrid := false // always let ssAlt shifted through to control
      else
      begin
        // Some controls may be in state that always wants a navigation key.
        if Msg.Sender.GetInterface(IIB_GridWinControl,tmpIntf) then
          NavToGrid := not tmpIntf.HasActiveChild;
      end;
    end;
    // Pass on the keys that are of importance to the grid.
    if (Key = VK_TAB) or (Key = VK_F2) then
    begin
      Msg.Result := 1;
      FEscKeyControl := nil;
      KeyDown( Key, Shift );
    end
    else
    if (Key = VK_ESCAPE) and (Shift = []) then
    begin
      // The SECOND occurance of escape in a row to the same control
      // gets passed to the grid...
      if (FEscKeyControl = Msg.Sender) then
      begin
        Msg.Result := 1;
        FEscKeyControl := nil;
        KeyDown( Key, Shift );
      end
      else
      begin
        // Otherwise just track the first occurance to see if it happens again
        FEscKeyControl := Msg.Sender;
      end;
    end
    else
    if NavToGrid and (( Key = VK_LEFT  ) or
                      ( Key = VK_RIGHT ) or
                      ( Key = VK_UP    ) or
                      ( Key = VK_DOWN  ) or
                      ( Key = VK_NEXT  ) or
                      ( Key = VK_PRIOR ) or
                      ( Key = VK_HOME  ) or
                      ( Key = VK_END   )) then
    begin
      Msg.Result := 1;
      FEscKeyControl := nil;
      if not (ssShift in Shift) then
        Shift := Shift - [ssCtrl]; // dont pass on Ctrl state
      KeyDown( Key, Shift );
    end
    else
      FEscKeyControl := nil;
  end
  else
    inherited;
end;

// TCustomGrid defines this message and then only processes it
// for InplaceEdit, so I override the command so that we can
// pass change messages to other embedded controls.
procedure TIB_CustomGrid.WMCommand(var Message: TWMCommand);

  // This is a copy of a function from TWinControl, which I had to
  // duplicate because it is not visible to derivatives
  function DoControlMsg(ControlHandle: HWnd; var Message): Boolean;
  var
    Control: TWinControl;
  begin
    DoControlMsg := False;
    Control := FindControl(ControlHandle);
    if Control <> nil then
      with TMessage(Message) do
      begin
        Result := Control.Perform(Msg + CN_BASE, WParam, LParam);
        DoControlMsg := True;
    end;
  end;

begin
  with Message do
    if (InplaceEditor <> nil) and (Ctl = InplaceEditor.Handle) then
      inherited
    else
    if not DoControlMsg(Message.Ctl, Message) then
      inherited;
end;

procedure TIB_CustomGrid.CNKeyDown(var Message: TWMKeyDown);
begin
  if AllowIncSearch then with Message do
  begin
    if DataLink.Prepared and
       Assigned( DataLink.Dataset.OrderingField ) and
       ( DataLink.DataSet.State in [ dssBrowse ] ) and
       ( not FIncSearchState ) and ( IncSearchHotKey <> 0 ) and
       ( IncSearchHotKey = ShortCut( CharCode,
                                     KeyDataToShiftState( KeyData ))) then
    begin
      FIncSearchState := true;
      FIncSearchText := EmptyStr;
      if Assigned( FOnIncSearch ) then
        FOnIncSearch( Self, FIncSearchText, false );
    end;
  end;
  inherited;
end;

procedure TIB_CustomGrid.CNChar(var Message: TWMChar);
begin
  {this source is to catch a char key pressing and under following conditions
  the IncSearch State is set}
  if AllowIncSearch and ( DataLink.Prepared ) and
     Assigned( DataLink.Dataset.OrderingField ) and
     ( DataLink.DataSet.State in [ dssBrowse ] ) and
     ( not FIncSearchState) and
     ( IncSearchHotKey = 0 ) and
     ( Self.ReadOnly or
       Self.RowSelect or
       DataLink.Dataset.ReadOnly ) and
     ( not ( Message.CharCode in [9, 27, 13, 8] ) ) then
  begin
    FIncSearchState := true;
    FIncSearchText := EmptyStr;
    if Assigned( FOnIncSearch ) then
      FOnIncSearch( Self, FIncSearchText, false );
  end;
  inherited;
end;

procedure TIB_CustomGrid.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  {this procedure resolve the problem of accelerators (hot key, menu key).
   If we set DLGC_WANTCHARS bit for Message.Result then we indicate we want to
   process key. It doesn't allow to broadcast the CN_CHAR message to another
   controls (for example with accelerator)}
  inherited;
  if FIncSearchState then Message.Result := Message.Result or DLGC_WANTCHARS;
end;

procedure TIB_CustomGrid.WMDropFiles(var Msg: TMessage);
var
  D: THandle;
  I, J: Integer;
  N: array[0..1023] of Char;
  tmpStrings: TIB_StringList;
begin
  D := THandle( Msg.wParam );
  tmpStrings := TIB_StringList.Create;
  try
    J := DragQueryFile( D, $FFFFFFFF, nil, 0 );
    for I := 0 to J - 1 do
    begin
      DragQueryFile( D, I, N, 1024 );
      tmpStrings.Add( N );
    end;
    DoDropFiles( tmpStrings );
  finally
    tmpStrings.Free;
    DragFinish( D );
    Msg.Result := 0;
  end;
end;

procedure TIB_CustomGrid.DoDropFiles( AFilenames: TStrings );
begin
  if Assigned( FOnDropFiles ) then
    FOnDropFiles( Self, AFilenames );
end;

procedure TIB_CustomGrid.TimedScroll( Direction: TGridScrollDirection );
begin
// Do nothing!
end;

{$IFDEF IBO_VCL40_OR_GREATER}
procedure TIB_CustomGrid.ChangeGridOrientation(RightToLeftOrientation: Boolean);
var
  Org: TPoint;
  Ext: TPoint;
begin
  if RightToLeftOrientation then
  begin
    Org := Point(ClientWidth,0);
    Ext := Point(-1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end
  else
  begin
    Org := Point(0,0);
    Ext := Point(1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end;
end;
{$ENDIF}

{$Define IBG_LookupCombo}
{$DEFINE IB_AutoLabel}
{$I IB_WinControl.IMP}
{$UNDEF IB_AutoLabel}

procedure TIB_LookupComboLink.FocusControl( AField: TIB_ColumnRef );
begin
  if Assigned( AField^ ) and
     Assigned( Control ) and Control.CanFocus then
  begin
    with Control as TIB_CustomCombo do
    begin
      if (( AField^.FieldName = DisplayField ) or
          ( Assigned( PopupList.DataLink.Dataset ) and
          ( AField^.FieldName = PopupList.DataLink.Dataset.OrderingLink ))) then
      try
        Control.SetFocus;
        AField^ := nil;
      except
        on E: Exception do Application.HandleException( E );
      end;
    end;
  end;
end;

constructor TIB_CustomCombo.Create(AOwner: TComponent);
var
  tmpBitmap: TBitmap;
begin
  FAutoLabel := TIB_AutoLabel.Create( Self );
  inherited Create(AOwner);
  inherited ReadOnly := true;
  FDataLink := TIB_LookupComboLink.Create( Self );
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnStateChanged := StateChanged;
  FDataLink.AfterAssignment := StateChanged;
  AutoSize := false;
  FBtnControl := TWinControl.Create(Self);
  FBtnControl.Width := 17;
  FBtnControl.Height := 17;
  FBtnControl.Visible := true;
  FBtnControl.Parent := Self;
  FButton := TIB_ComboButton.Create(Self);
  FButton.SetBounds( 0, 0, FBtnControl.Width, FBtnControl.Height );
  tmpBitmap := TBitmap.Create;
  try
    tmpBitmap.LoadFromResourceName( HInstance, 'IB_GRID_COMBO' );
    FButton.Glyph.Assign( tmpBitmap );
  finally
    tmpBitmap.Free;
  end;
  FButton.Visible := true;
  FButton.Parent := FBtnControl;
  FDefaultPopupList := TIB_LookupList.Create( Self );
  FDefaultPopupList.Height := 500;
  FDefaultPopupList.FParentCombo := Self;
  FDefaultPopupList.Parent := Self;
  FDefaultPopupList.Visible := false;
  FDefaultPopupList.TabStop := false;
  FDefaultPopupList.ReadOnly := true;
  FDefaultPopupList.FAcquireFocus := false;
  inherited Height := 21;
  FDropDownCount := 7;
  FAllowTimeout := true;
  FAutoDropDown := false;
  FSearchKeyByKey := true;
  FCanDropDown := true;
  FPopupAlignment := puAuto;
  FPopupColor := clWindow;
  FPopupFixedColor := clBtnFace;
  FClearSelectionOnExit := False;
end;

destructor TIB_CustomCombo.Destroy;
begin
  {$IFNDEF VER90}
  FAutoLabel.Free;
  FAutoLabel := nil;
  {$ENDIF}
  DataSource := nil;
  with DataLink do
  begin
    Control := nil;
    OnStateChanged := nil;
    OnEditingChanged := nil;
    OnDataChange := nil;
  end;
  CustomPopup := nil;
  if FCanvas <> nil then
  begin
    FCanvas.Free;
    FCanvas := nil;
  end;
  inherited Destroy;
end;

procedure TIB_CustomCombo.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if ( Parent.InheritsFrom( TIB_CustomGrid )) or PopupList.Visible then
    Message.Result := Message.Result or DLGC_WANTTAB
  else
    Message.Result := Message.Result and (not DLGC_WANTALLKEYS);
end;

procedure TIB_CustomCombo.ClearSelection( SetNull: boolean );
var
  tmpKey: char;
begin
  if Assigned( PopupList ) then
  begin
    if PopupList.Visible then
      CloseUp;
  { Clear the search string and set the attached field(s) to NULL... }
    with PopupList.DataLink do
    begin
      if Assigned( BDataset ) then
        with BDataset do
        begin
          Inc( FSearchLevel );
          try
            tmpKey := #27;  //<=-use fake ESC press to clear search
            DoIncSearchKeyPress( tmpKey );
            if SetNull then
              GotoNull;  //<=-this sets the attached field(s) to NULL
          finally
            Dec( FSearchLevel );
          end;
        end;
    end;
  end;
  if Assigned( OnSelectionCleared ) then
    OnSelectionCleared( Self );
end;

procedure TIB_CustomCombo.KeyDown(var Key: Word; Shift: TShiftState);
var
  tmpWord: word;
  ii: integer;
  tmpString: string;
begin
  if ( Key = VK_DELETE ) and Assigned( PopupList ) then
  begin
    ClearSelection( TRUE );
    Key := 0;
    Exit;  //<=-no further processing required
  end;
  if ( Key = VK_ESCAPE ) then
  begin
    if ( SearchText <> '' ) then
    begin
      ClearSelection( FALSE );
      Key := 0;
      Exit;  //<=-no further processing required
    end;
    if ( DataLink.State = dssSearch ) then
      ClearSelection( TRUE )
    else
    if not PopupList.Visible and
       Assigned( DataLink.DataSet ) and
       Assigned( DataSource ) and
       Assigned( DataSource.DataSet ) then
    begin
      DataLink.DataSet.Fields.BeginUpdate;
      try
        for ii:=0 to DataSource.DataSet.Keylinks.Count - 1 do
        begin
          tmpString := DataSource.DataSet.KeyLinks.IndexValues[ii];
          DataLink.DataSet.FieldByName( tmpString ).Revert;
        end;
      finally
        DataLink.DataSet.Fields.EndUpdate( true );
      end;
    end;
  end;
  inherited KeyDown(Key, Shift);
  if ( ssCtrl in Shift ) or ( ssAlt in Shift ) then
  begin
    if ( Key = VK_DOWN ) and not PopupList.Visible then
    begin
      DropDown;
      Key := 0;
    end
    else
    if ( Key = VK_UP ) and PopupList.Visible then
    begin
      CloseUp;
      Key := 0;
    end;
  end;
  if ( Shift = [] ) and
     ( Key in [VK_UP, VK_DOWN, VK_NEXT, VK_PRIOR] ) or
     (( Key in [VK_HOME, VK_END] ) and PopupList.Visible ) then
  begin
    if not PopupList.Visible then
    begin
      if Parent.InheritsFrom( TIB_CustomGrid ) and
         not DataLink.NeedToPost then
        ( Parent as TIB_CustomGrid ).KeyDown( Key, Shift )
      else
      if AutoDropDown then
      begin
        DropDown;
        Key := 0;
      end
      else
      begin
        tmpWord := Key;
        PopupList.KeyDown( tmpWord, Shift );
      end;
    end
    else
    begin
      tmpWord := Key;
      PopupList.KeyDown( tmpWord, Shift );
    end;
  end
  else
  if Parent.InheritsFrom( TIB_CustomGrid ) then
  begin
    with Parent as TIB_CustomGrid do
    begin
      if Key in [ VK_TAB, VK_LEFT, VK_RIGHT ] then
      begin
        Self.CloseUp;
        Self.Visible := false;
        KeyDown( Key, Shift );
        // Only set focus on the grid if it has not already sorted itself out.
        // (Otherwise the grid may steal focus from a valid child control.)
        if not HasFocus then
          SetFocus;
      end
      else
      if not Self.PopupList.Visible then
        KeyDown( Key, Shift );
    end;
  end;
end;

procedure TIB_CustomCombo.KeyPress( var Key: Char);
begin
  inherited KeyPress(Key);
  if Assigned( PopupList ) then with PopupList.DataLink do
  begin
    if PopupList.Visible and ( Key in [ #13, #27 ] ) then
      CloseUp;
    if Assigned( BDataset ) then
    with BDataset do
    begin
      if Key in [ #8, #9, #13, #27, #32..#255 ] then
      begin
        if Active and Assigned( OrderingField ) then
        begin
          DoIncSearchKeyPress( Key );
          if not PopupList.Visible and
             not ( Key in [ #9, #13, #27 ] ) and
             AutoDropDown and Focused then
            DropDown;
        end;
      end
      else
      if Parent.InheritsFrom( TIB_CustomGrid ) then
      begin
        (Parent as TIB_CustomGrid).KeyPress( Key );
      end
      else
        MessageBeep( 0 );
    end;
  end;
end;

procedure TIB_CustomCombo.DoIncSearchKeyPress( var Key: char );
var
  ExactItemFound: boolean;
  tmpStr: string;
begin
  if Assigned( PopupList ) then with PopupList.DataLink do
  begin
    PopupList.CheckPreventModifications;
    if Assigned( BDataset ) then with BDataset do
    begin
      if Assigned( OrderingField ) then try
        Inc( FSearchLevel );
        if ( not ( Key in [ #9, #13 ] )) or ( FSearchText <> '' ) then
        begin
          ExactItemFound := IncSearchKey( Key,
                                          SearchKeyByKey,
                                          AllowTimeout,
                                          SeekNearest );
          case CharCase of
            ecUpperCase: FSearchText := AnsiUpperCase( IncSearchKeyString );
            ecLowerCase: FSearchText := AnsiLowerCase( IncSearchKeyString );
            else         FSearchText := IncSearchKeyString;
          end;
          if not ExactItemFound then
          begin
            if Key in [ #9, #13 ] then
            begin
              if SearchText = '' then
                GotoNull
              else
              begin
                CloseUp;
                tmpStr := Copy( OrderingField.AsString, 1, Length(SearchText));
                if AnsiCompareText( tmpStr, SearchText ) <> 0 then
                  DoNotInList;
              end;
            end;
          end;
          Invalidate;
        end;
      finally
        Dec( FSearchLevel );
      end;
    end;
  end;
end;

procedure TIB_CustomCombo.SetCustomPopup( AValue: TIB_CustomGrid );
begin
  if FCustomPopup <> AValue then
  begin
    if Assigned( FCustomPopup ) then
    begin
      FCustomPopup.FAcquireFocus := true;
      FDefaultPopupList.DataSource := FCustomPopup.DataSource;
      FCustomPopup.ParentCombo := nil;
    end;
    FCustomPopup := AValue;
    if Assigned( FCustomPopup ) then
    begin
      FCustomPopup.FAcquireFocus := false;
      FCustomPopup.ParentCombo := Self;
      if Assigned( FDefaultPopupList.DataSource ) then
      begin
        FCustomPopup.DataSource := FDefaultPopupList.DataSource;
      end;
    end;
    if not ( csDestroying in ComponentState ) then
      SysStateChanged;
  end;
end;

function TIB_CustomCombo.GetPopupList: TIB_CustomGrid;
begin
  if not ( csDesigning in ComponentState ) and
     Assigned( FCustomPopup ) then
    Result := FCustomPopup
  else
    Result := FDefaultPopupList;
end;

procedure TIB_CustomCombo.SetShowButton( AValue: boolean );
begin
  if AValue then
    FBtnControl.Parent := Self
  else
    FBtnControl.Parent := nil;
end;

function  TIB_CustomCombo.GetShowButton: boolean;
begin
  if FBtnControl.Parent = nil then
    Result := false
  else
    Result := true;
end;

function TIB_CustomCombo.GetDataSource: TIB_DataSource;
begin
  Result := PopupList.DataSource;
end;

procedure TIB_CustomCombo.SetDataSource( AValue: TIB_DataSource);
begin
  if Assigned( FDefaultPopupList) then
    FDefaultPopupList.DataSource := AValue;
  if Assigned( CustomPopup ) and
    ( CustomPopup.DataSource <> AValue ) then
    CustomPopup.DataSource := AValue;
// Needed because this does not get setup by IB_Control.IMP like most controls.
{$IFNDEF VER90}
  RemakeAutoLabel;
{$ENDIF}
end;

procedure TIB_CustomCombo.SetDisplayField(const Value: string);
begin
  if DisplayField <> Value then
  begin
    FDisplayField := Value;
    SysDataChange( nil );
  end;
// Needed because this does not get setup by IB_Control.IMP like most controls.
{$IFNDEF VER90}
  RemakeAutoLabel;
{$ENDIF}
end;

function TIB_CustomCombo.GetDefaultRowHeight: integer;
begin
  Result := PopupList.DefaultRowHeight;
end;

procedure TIB_CustomCombo.SetDefaultRowHeight( AValue: integer );
begin
  PopupList.DefaultRowHeight := AValue;
end;

procedure TIB_CustomCombo.StateChanged( Sender: TIB_DataLink;
                                        IB_DataSource: TIB_DataSource );
begin
  if Assigned( FDefaultPopupList ) then
    if FDefaultPopupList.DataSource <> DataSource then
      FDefaultPopupList.DataSource := DataSource;
  if Assigned( CustomPopup ) then
    if CustomPopup.DataSource <> DataSource then
      CustomPopup.DataSource := DataSource;
  if not Assigned( DataSource ) and Focused then
    if Parent.CanFocus then
      Parent.SetFocus;
  SysStateChanged;
end;

procedure TIB_CustomCombo.SysStateChanged;
var
  tmpCol: TIB_Column;
begin
  tmpCol := nil;
  if Assigned( DataSource ) and Assigned( DataSource.Dataset ) then
  begin
    if DataSource.Dataset.Fields.GetByName( DisplayField, tmpCol ) or
       DataSource.Dataset.Fields.GetByName(
         DataSource.Dataset.OrderingLink, tmpCol ) then
    begin
      case tmpCol.CharCase of
        ccUpper: CharCase := ecUpperCase;
        ccLower: CharCase := ecLowerCase;
        else     CharCase := ecNormal;
      end;
    end
    else
      CharCase := ecNormal;
    if DataLink.ColorScheme then
      if Assigned( tmpCol ) then
        inherited Color := DataLink.Color
      else
        inherited Color := Datalink.InvalidColor;
  end;
  SysDataChange( nil );
// Needed because this does not get setup by IB_Control.IMP like most controls.
{$IFNDEF VER90}
  RemakeAutoLabel;
{$ENDIF}
end;

procedure TIB_CustomCombo.SysDataChange;
var
  tmpCol: TIB_Column;
  tmpText:string;
begin
  if Assigned( DataSource ) and Assigned( DataSource.Dataset ) then
  begin
    with DataSource.Dataset do
    begin
      if Fields.GetByName( DisplayField, tmpCol ) or
         Fields.GetByName( OrderingLink, tmpCol ) then
        tmpText := tmpCol.DisplayText
      else
        tmpText := '';
      if FSearchLevel > 0 then
      begin
        if ( tmpText = '' ) and
           (( DisplayField = '' ) or ( DisplayField = OrderingLink )) then
          tmpText := FSearchText;
      end
      else
        FSearchText := '';
      if Assigned( OnGetDisplayText ) then
        OnGetDisplayText( Self, -1, -1, tmpText);
      Text:=tmpText;
    end;
  end
  else
    Text := '';
end;

procedure TIB_CustomCombo.SysUpdateData( IB_Field: TIB_Column );
begin
// Place holder.
end;

procedure TIB_CustomCombo.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TIB_CustomCombo.CreateWnd;
begin
  inherited CreateWnd;
// Added by NVE 27/07/1999
  if Visible then
  begin
    FDefaultPopupList.Color := PopupColor;
    FDefaultPopupList.FixedColor := PopupFixedColor;
    if Parent.InheritsFrom( TIB_CustomGrid ) then
      with Parent as TIB_CustomGrid do
      begin
        FDefaultPopupList.CurrentRowColor := CurrentRowColor;
        FDefaultPopupList.OrderingColor := OrderingColor;
//        FDefaultPopupList.Font.Color := clWindowText;
        FDefaultPopupList.CurrentRowFont.Assign( CurrentRowFont );
        FDefaultPopupList.OrderingFont.Assign( OrderingFont );
      end;
  end;
//
  SetEditRect;
  FDefaultPopupList.HandleNeeded;
  SysDataChange( nil );
end;

procedure TIB_CustomCombo.SetEditRect;
var
  Loc: TRect;
begin
  Loc.Bottom := ClientHeight + 1; {+1 is workaround for windows paint bug}
  Loc.Right := FBtnControl.Left - 2;
  Loc.Top := 0;
  Loc.Left := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
end;

procedure TIB_CustomCombo.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
  if csDesigning in ComponentState then
    FDefaultPopupList.SetBounds( 0, Height + 1, 10, 10 );
  MinHeight := 0;
  if Height < MinHeight then
    Height := MinHeight
  else
  begin
    if NewStyleControls then
      FBtnControl.SetBounds( ClientWidth - FButton.Width, 0,
                             FButton.Width, ClientHeight)
    else
      FBtnControl.SetBounds( ClientWidth - FButton.Width, 1,
                             FButton.Width, ClientHeight - 1);
    FButton.Height := FBtnControl.Height;
    SetEditRect;
  end;
end;

function TIB_CustomCombo.GetDropDownAlign: TIB_DropDownAlign;
begin
  Result := daaLeft;
  case PopupAlignment of
    puRight,
    puParentRight: Result := daaRight;
    puCentered,
    puParentCentered: Result := daaCentered;
  end;
end;

procedure TIB_CustomCombo.SetDropDownAlign( AValue: TIB_DropDownAlign );
begin
  case AValue of
    daaLeft: if not ( PopupAlignment in [ puAuto, puLeft, puParentLeft ] ) then
      FPopupAlignment := puLeft;
    daaRight: if not ( PopupAlignment in [ puRight, puParentRight ] ) then
      FPopupAlignment := puRight;
    daaCentered: if not (PopupAlignment in [ puCentered,puParentCentered ]) then
      FPopupAlignment := puCentered;
  end;
end;

function TIB_CustomCombo.GetIndicateOrdering: boolean;
begin
  Result := PopupList.IndicateOrdering;
end;

procedure TIB_CustomCombo.SetIndicateOrdering( AValue: boolean );
begin
  PopupList.IndicateOrdering := AValue;
end;

function TIB_CustomCombo.GetIndicateSelected: boolean;
begin
  Result := PopupList.IndicateSelected;
end;

procedure TIB_CustomCombo.SetIndicateSelected( AValue: boolean );
begin
  PopupList.IndicateSelected := AValue;
end;

function TIB_CustomCombo.GetIndicateTitles: boolean;
begin
  Result := PopupList.IndicateTitles;
end;

procedure TIB_CustomCombo.SetIndicateTitles( AValue: boolean );
begin
  PopupList.IndicateTitles := AValue;
end;

function TIB_CustomCombo.GetIndicateRow: boolean;
begin
  Result := PopupList.IndicateRow;
end;

procedure TIB_CustomCombo.SetIndicateRow( AValue: boolean );
begin
  PopupList.IndicateRow := AValue;
end;

function TIB_CustomCombo.GetIsDroppedDown: boolean;
begin
  Result := PopupList.Visible;
end;

function TIB_CustomCombo.GetColLines: boolean;
begin
  Result := PopupList.ColLines;
end;

procedure TIB_CustomCombo.SetColLines( AValue: boolean );
begin
  PopupList.ColLines := AValue;
end;

function TIB_CustomCombo.GetRowLines: boolean;
begin
  Result := PopupList.RowLines;
end;

procedure TIB_CustomCombo.SetRowLines( AValue: boolean );
begin
  PopupList.RowLines := AValue;
end;

function TIB_CustomCombo.GetFixedColLines: boolean;
begin
  Result := PopupList.FixedColLines;
end;

procedure TIB_CustomCombo.SetFixedColLines( AValue: boolean );
begin
  PopupList.FixedColLines := AValue;
end;

function TIB_CustomCombo.GetFixedRowLines: boolean;
begin
  Result := PopupList.FixedRowLines;
end;

procedure TIB_CustomCombo.SetFixedRowLines( AValue: boolean );
begin
  PopupList.FixedRowLines := AValue;
end;


function TIB_CustomCombo.GetGridLinks: TIB_StringList;
begin
  Result := PopupList.GridLinks;
end;

procedure TIB_CustomCombo.SetGridLinks( AValue: TIB_StringList );
begin
  PopupList.GridLinks.Text := Trim( AValue.Text );
end;

procedure TIB_CustomCombo.SetOnGetDisplayText( AValue: TIB_GetDisplayTextEvent);
begin
  FOnGetDisplayText:=AValue;
  PopupList.OnGetDisplayText:=AValue;
  end;

procedure TIB_CustomCombo.WMPaint(var Message: TWMPaint);
var
  PS: TPaintStruct;
  ARect: TRect;
  Focused: Boolean;
  DC: HDC;
  S1, S2: string;
  len: integer;
  AFont: TFont;
  AColor: TColor;
  DX, DY: integer;
begin
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then
    DC := BeginPaint( Handle, PS );
  FCanvas.Handle := DC;
  try
    Focused := ( GetFocus = Handle ) or ( GetFocus = PopupList.Handle );
    FCanvas.Font := Font;
    with FCanvas do
    begin
      ARect := ClientRect;
      if showButton then Dec( ARect.Right, FButton.Width ); //Zeichenfläche darf nur eingeschränkt werden, wenn Button sichtbar
      Brush.Style := bsSolid;
//      if Focused then                    {<== add these lines}
//      begin                              {<== add these lines}
//        Brush.Color := clHighlight;      {<== add these lines}
//        Font.Color := clHighlightText;   {<== add these lines}
//      end;                               {<== add these lines}
      AColor := Color;
      AFont := Font;
      DX := 1;
      DY := 1;
      if Assigned( Self.Parent ) and
         Self.Parent.InheritsFrom( TIB_CustomGrid ) then
        with Self.Parent as TIB_CustomGrid do
          GetCellProps( Col, Row, [gdFocused], AColor, AFont );
      Brush.Color := AColor;
      Font := AFont;                     {<== add these lines}
      FillRect (ARect);
      if (csDesigning in ComponentState) and
         (DataLink.State = dssInactive) then
      begin
        S1 := Name;
        FSearchText := '';
      end
      else
        S1 := Text;
      len := Length( SearchText );
      if Focused then
      begin
        DrawFocusRect(ARect);
        Inc( ARect.Top );
        Dec( ARect.Bottom );
        Dec( DY );
        if len > 0 then
        begin
          if AnsiCompareText( SearchText, Copy( Text, 1, len )) = 0 then
          begin
            S2 := Copy( Text, 1, len );
            Delete( S1, 1, len );
          end
          else
            S2 := SearchText;
          FillRect( ARect );
          WriteText( FCanvas, ARect, DX, DY, S2, taLeftJustify );
          Inc( DX, TextWidth( 'i' ));
          Inc( ARect.Left, TextWidth( S2 + 'ii' ));
        end;
        Brush.Color := clHighlight;
        Font.Color := clHighlightText;
      end;
      FillRect( ARect );
      WriteText( FCanvas, ARect, DX, DY, S1, taLeftJustify );
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then
      EndPaint(Handle, PS);
  end;
end;

procedure TIB_CustomCombo.CMGetDataLink(var Message: TMessage);
begin
  if Assigned( PopupList ) then
    Message.Result := Integer( PopupList.DataLink )
  else
    Message.Result := 0;
end;

procedure TIB_CustomCombo.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  FButton.Enabled := Enabled;
  SysStateChanged;
end;

procedure TIB_CustomCombo.WMKillFocus(var Message: TWMKillFocus);
begin
  if PopupList.Visible then
    CloseUp;
  inherited;
end;

procedure TIB_CustomCombo.CMCancelMode(var Message: TCMCancelMode);
begin
  with Message do
    if (Sender <> Self) and
       (Sender <> FBtnControl) and
       (Sender <> FButton) and
       (Sender <> PopupList) then
      if PopupList.Visible then
        CloseUp;
end;

procedure TIB_CustomCombo.CMHintShow(var Message: TMessage);
begin
  Message.Result := Integer(PopupList.Visible);
end;

procedure TIB_CustomCombo.DropDown;
var
  ItemCount: Integer;
  P: TPoint;
  Y: Integer;
  ListWidth, ListHeight, LeftPos: integer;
  SysBorderWidth, SysBorderHeight: integer;
  tmpRow: integer;
  AllowHorizSB: boolean;
begin
  AllowHorizSB := true;
  if not PopupList.Visible and ( Width > 20 ) then
  begin
    DoDropDown;
    if FCanDropDown then
    begin
      ItemCount := DropDownCount;
      if ItemCount <= 0 then
        ItemCount := 7;
      with PopupList do
      begin
        if Assigned( DataLink.Dataset ) then
          with DataLink.Dataset do
          begin
            if not BufferHasBof and not BufferHasEof then
              ValidateRows( RowNum - ItemCount div 2 + 1,
                            RowNum + ItemCount div 2 + 1);
            if BufferHasBof and not BufferHasEof then
              ValidateRows( BofRowNum + 1, BofRowNum + ItemCount );
            if BufferHasEof and not BufferHasBof then
              ValidateRows( EofRowNum - ItemCount, EofRowNum - 1 );
            if ItemCount > BufferRowCount then
              ItemCount := BufferRowCount;
          end;
        Height := HeightForGridRows( ItemCount, AllowHorizSB );
      end;
      if BorderStyle = bsNone then
      begin
        SysBorderWidth := 0;
        SysBorderHeight := 0;
      end
      else
      begin
        SysBorderWidth := GetSystemMetrics(SM_CXBORDER);
        SysBorderHeight := GetSystemMetrics(SM_CYBORDER);
      end;
      P := ClientOrigin;
      if NewStyleControls then
      begin
        Dec( P.X, SysBorderWidth * 2 );
        Dec( P.Y, SysBorderHeight );
      end;
      ListWidth := DropDownWidth;
      if ListWidth <= -1 then
      begin
        ListWidth := Self.Width;
        PopupList.Width := ListWidth;
        PopupList.StretchGridColumns();
        AllowHorizSB := false;
      end
      else
      begin
        if ListWidth = 0 then
        begin
          ListWidth := PopupList.WidthForAllCols;
        end;
        PopupList.Width := ListWidth;
        AllowHorizSB := ListWidth < PopupList.WidthForAllCols;
      end;
      ListHeight := PopupList.HeightForGridRows( ItemCount, AllowHorizSB );
      PopupList.Height := ListHeight;
      if NewStyleControls then
        Y := P.Y + ClientHeight + 3 * SysBorderHeight
      else
        Y := P.Y + Height - 1;
      if ( Y + ListHeight ) > Screen.Height then
      begin
        Y := P.Y - ListHeight + 1;
        if Y < 0 then
        begin
          if NewStyleControls then
            Y := P.Y + ClientHeight + 3 * SysBorderHeight
          else
            Y := P.Y + Height - 1;
        end;
      end;
      if ListWidth = 0 then
      begin
        if NewStyleControls then
          ListWidth := Width + 2 * SysBorderWidth
        else
          ListWidth := Width - 4;
      end;
      LeftPos := P.X;
      case FPopupAlignment of
        puAuto: if ListWidth > ( Parent.ClientOrigin.X +
                                 Parent.ClientRect.Right - P.X ) then
          LeftPos := Parent.ClientOrigin.X +
                     Parent.ClientRect.Right - ListWidth;
        puRight: LeftPos := P.X - ListWidth + ClientWidth;
        puCentered: LeftPos := P.X - (( ListWidth - ClientWidth) div 2 );
        puParentLeft: LeftPos := Parent.ClientOrigin.X;
        puParentRight: LeftPos := Parent.ClientOrigin.X +
                                  Parent.ClientWidth - ListWidth;
        puParentCentered: LeftPos := Parent.ClientOrigin.X -
                                     (( ListWidth - Parent.ClientWidth) div 2 );
      end;
      if not NewStyleControls then
        Inc( LeftPos, Width - ListWidth );

      SetWindowPos( PopupList.Handle,
                    HWND_TOPMOST,
                    LeftPos, Y,
                    ListWidth,
                    ListHeight,
                    SWP_NOACTIVATE );
      tmpRow := PopupList.DataLink.ActiveRecord - ( ItemCount - 1 ) div 2;
      if ( Assigned( PopupList.DataLink.Dataset )) and
         ( tmpRow <= PopupList.DataLink.Dataset.BofRowNum ) then
        tmpRow := PopupList.DataLink.Dataset.BofRowNum + 1;
      PopupList.TopRowNum := tmpRow;
      PopupList.UpdateScrollBar;
      PopupList.Visible := True;
      Windows.SetFocus(Handle);
    end;
    FCanDropDown := true;
  end;
end;

procedure TIB_CustomCombo.CloseUp;
begin
  if PopupList.Visible then
  begin
    PopupList.Visible := false;
    // This does not always work (if Parent Form was just hidden) so...
    ShowWindow( PopupList.Handle, SW_HIDE );
    if Assigned( OnCloseUp ) then
      OnCloseUp( Self );
  end;
end;

procedure TIB_CustomCombo.DoDropDown;
begin
  if Assigned(FOnDropDown) then
    FOnDropDown(Self);
end;

procedure TIB_CustomCombo.DoNotInList;
begin
  if Assigned( FOnNotInList ) then
    FOnNotInList( Self );
  FSearchText := '';
end;

procedure TIB_CustomCombo.WMLButtonDown(var Message: TWMLButtonDown);
begin
  NonEditMouseDown(Message, false);
end;

procedure TIB_CustomCombo.WMLButtonUp(var Message: TWMLButtonUp);
begin
  MouseCapture := False;
  inherited;
end;

procedure TIB_CustomCombo.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  NonEditMouseDown( Message, true );
end;

procedure TIB_CustomCombo.NonEditMouseDown(
  var Message: TWMLButtonDown; IsDblClick: boolean);
var
  CtrlState: TControlState;
begin
  SetFocus;
  HideCaret( Handle );
  if PopupList.Visible then
    CloseUp
  else
  if AutoDropDown then
    DropDown;
  MouseCapture := True;
  if csClickEvents in ControlStyle then
  begin
    if IsDblClick then
      DblClick
    else
    begin
      CtrlState := ControlState;
      Include(CtrlState, csClicked);
      ControlState := CtrlState;
    end;
  end;
  with Message do MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
end;

procedure MouseDragToGrid(Ctrl: TControl; Grid: TIB_CustomGrid; X, Y: Integer);
var
  pt, clientPt: TPoint;
begin
  if Grid.Visible then
  begin
    pt.X := X;
    pt.Y := Y;
    pt := Ctrl.ClientToScreen (pt);
    clientPt := Grid.ClientOrigin;
    if (pt.X >= clientPt.X) and (pt.Y >= clientPt.Y) and
       (pt.X <= clientPt.X + Grid.ClientWidth) and
       (pt.Y <= clientPt.Y + Grid.ClientHeight) then
    begin
      Ctrl.Perform(WM_LBUTTONUP, 0, MakeLong (X, Y));
      pt := Grid.ScreenToClient(pt);
      Grid.Perform(WM_LBUTTONDOWN, 0, MakeLong (pt.x, pt.y));
    end;
  end;
end;

procedure TIB_CustomCombo.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove( Shift, X, Y );
  if ( ssLeft in Shift ) and ( GetCapture = Handle ) then
    MouseDragToGrid( Self, PopupList, X, Y );
end;

procedure TIB_CustomCombo.WMSetFocus( var Message: TWMSetFocus );
begin
  inherited;
  if Assigned( DataLink.DataSource ) then
    DataLink.SetFocus
  else
  if Assigned( PopupList ) then
    PopupList.Datalink.SetFocus;
  HideCaret(Handle);
  Invalidate;
end;

procedure TIB_CustomCombo.CMEnter(var Message: TCMGotFocus);
begin
  inherited;
  Invalidate;
end;

procedure TIB_CustomCombo.CMExit(var Message: TCMGotFocus);
var
  tmpKey: char;
begin
  inherited;
  try
    if FSearchText <> '' then
    begin
      tmpKey := #9;
      DoIncSearchKeyPress( tmpKey );
    end;
    if ClearSelectionOnExit then
      try
        ClearSelection( False );
      except
        on EAbort do
          ; // 'eats' abort exception to prevent focus problems
      end;
    Invalidate;
  except
    SetFocus;
    raise;
  end;
end;

procedure TIB_CustomCombo.CNKeyDown(var Message: TWMKeyDown);
var
  tmpKey: char;
begin
  with Message do
    if CharCode = VK_TAB then
    begin
      if PopupList.Visible then
        CloseUp;
      if FSearchText <> '' then
      begin
        tmpKey := #9;
        DoIncSearchKeyPress( tmpKey );
      end;
    end;
  inherited;
end;

procedure TIB_CustomCombo.Loaded;
begin
  inherited Loaded;
  SysStateChanged;
  SysDataChange( nil );
  {$IFNDEF VER90}
  RemakeAutoLabel;
  {$ENDIF}
end;

procedure TIB_CustomCombo.BoundsChanged;
var
  R: TRect;
begin
{ Determine the size of the text area in the control
  it will be smaller by the width of the button if one is present }
  SetRect( R, 0, 0, ClientWidth - 2, ClientHeight + 1 ); // +1 is workaround for
                                                         // windows paint bug
  Dec( R.Right, FButton.Width );
  SendMessage( Handle, EM_SETRECTNP, 0, LongInt( @R ));
  Repaint;
end;

// IIB_GridWinControl interface functions

function TIB_CustomCombo.IBG_DisplayColumn: TObject;
var
  tmpName: string;
begin
  Result := nil;
  if Assigned( DataSource ) and Assigned( DataSource.Dataset ) then
    with DataSource.Dataset do
      // note that the "( Self.Datalink.BDataset = KeyDataset )" check that
      // used to occur when this code was inside the grid code is no longer
      // possible.  However the IsColLookup check uses column references so
      // the results of the comparison to the column returned from this
      // function should still be accurate and reliable.
      if Assigned( KeyDataset ) then
      begin
        tmpName := DisplayField;
        if tmpName = '' then
          tmpName := OrderingLink;
        Result := KeyDataset.FindField(KeyDescLinks.LinkValues[ tmpName ]);
        if not Assigned( Result ) then
          Result := KeyDataset.FindField( tmpName );
      end;
end;

function TIB_CustomCombo.IBG_GetText: string;
var
  tmpCol: TIB_Column;
begin
  tmpCol := TIB_Column(IBG_DisplayColumn);
  if Assigned(tmpCol) then
    Result := Text
  else
    Result := '';
end;

function TIB_CustomCombo.IBG_TranslateText(AVal: string): string;
begin
  Result := AVal;
end;

function TIB_CustomCombo.IBG_HasActiveChild: boolean;
begin
  Result := IsDroppedDown;
end;

procedure TIB_CustomCombo.IBG_SetBorderStyle( AVal: TBorderStyle );
begin
  BorderStyle := AVal;
end;

function TIB_CustomCombo.IBG_GetFont: TFont;
begin
  Result := Font;
end;

procedure TIB_CustomCombo.IBG_SetFont( const AFont: TFont );
begin
  Font.Assign( AFont );
end;

procedure TIB_CustomCombo.IBG_SetColor( AColor: TColor );
begin
  Color := AColor;
end;

procedure TIB_CustomCombo.IBG_SetVisible( AVal: boolean );
begin
  Visible := AVal;
end;

function TIB_CustomCombo.IBG_GetAutoLabel: TObject;
begin
  Result := FAutoLabel;
end;

{ TIB_ComboButton }

procedure TIB_ComboButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  with TIB_CustomCombo(Parent.Parent) do
    if not PopupList.Visible then
      if (Handle <> GetFocus) and CanFocus then
      begin
        SetFocus;
        if GetFocus <> Handle then
          Exit;
      end;
  inherited MouseDown(Button, Shift, X, Y);
  with TIB_CustomCombo(Parent.Parent) do
  begin
    if PopupList.Visible then
      CloseUp
    else
      DropDown;
  end;
end;

procedure TIB_ComboButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove (Shift, X, Y);
  if (ssLeft in Shift) and (GetCapture = Parent.Handle) then
    MouseDragToGrid(Self, TIB_CustomCombo(Parent.Parent).PopupList, X, Y);
end;
{$UnDef IBG_LookupCombo}

constructor TIB_LookupList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited AllowIncSearch := true;
  inherited RowSelect := true;
  inherited TrackGridRow := true;
  inherited IndicateRow := false;
  inherited IndicateSelected := false;
  inherited IndicateTitles := false;
  inherited RowLines := false;
  inherited ColLines := false;
  inherited ListBoxStyle := true;
  inherited DefaultRowHeight := G_DefaultRowHeight;
  Width := 121;
  Height := 97;
end;

procedure TIB_LookupList.CMHintShow(var Message: TMessage);
begin
  Message.Result := 1;
end;

{$UnDef IBG_CustomGrid}

// Needs to be a short timer!  I tried 100 but in my testing application
// this was not sufficient to ensure that the event got picked up at an
// appropriate place in the processing.
constructor TScrollFixTimer.Create( Owner: TComponent );
begin
  FMessageQueue := TList.Create;
  inherited;
  Enabled := false;
  Interval := 20;
  OnTimer := DoTimer;
end;

destructor TScrollFixTimer.Destroy;
begin
  FMessageQueue.Free;
  FMessageQueue := nil;
  inherited;
end;

// I was going to just override the Timer procedure but there are other
// parts of the base class which check the OnTimer event property so we needed
// a procedure to be assigned to that property.
procedure TScrollFixTimer.DoTimer( Sender: TObject );
var
  tmpMsg: TScrollFixQueuedMessage;
begin
  while( FMessageQueue.Count > 0 ) do
  begin
    tmpMsg := FMessageQueue.Items[0];
    if tmpMsg <> nil then
    begin
      PostMessage( tmpMsg.Handle, tmpMsg.Msg, tmpMsg.WParam, tmpMsg.LParam );
      tmpMsg.Free;
    end;
    FMessageQueue.Delete( 0 );
  end;
  if (FMessageQueue.Count <= 0) and Enabled then
    Enabled := false;
end;

procedure TScrollFixTimer.QueueMessage( WHandle: THandle; const Msg: TMessage );
var
  tmpMsg: TScrollFixQueuedMessage;
begin
  tmpMsg := TScrollFixQueuedMessage.Create;
  tmpMsg.Handle := WHandle;
  tmpMsg.Msg := Msg.Msg;
  tmpMsg.WParam := Msg.WParam;
  tmpMsg.LParam := Msg.LParam;
  FMessageQueue.Add( tmpMsg );
  if (FMessageQueue.Count > 0) and not Enabled then
    Enabled := true;
end;


initialization
  FilImages;
  MessageRequeueTimer := TScrollFixTimer.Create( nil );

finalization
  FBooleanIndicators.Free;
  FBooleanIndicators := nil;
  FRowIndicators.Free;
  FRowIndicators := nil;
  FOrderingIndicators.Free;
  FOrderingIndicators := nil;
  MessageRequeueTimer.Enabled := false;
  MessageRequeueTimer.Free;
  MessageRequeueTimer := nil;

end.
