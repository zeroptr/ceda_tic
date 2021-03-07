
{                                                                              }
{ IB_ControlInterface                                                          }
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
{  Wassim Haddad <lobolo2000@hotmail.com>                                      }
{  06-Jan-2003                                                                 }
{     Added an interface extension to support owner draw controls.             }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  20-Dec-2001                                                                 }
{     Added GetAutoLabel interface routine to support controls with AutoLabel  }
{     property.  Done to allow interface to be used by the AutoLabel routines  }
{     so that any control implementing this interface can optionally be used   }
{     as a model by other AutoLabels.                                          }
{                                                                              }
{  Geoff Worboys is the original author of this unit.                          }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_ControlInterface;

interface

uses
{$IFDEF IBO_VCL60_OR_GREATER}
  Types,
{$ELSE}
  Windows,  
{$ENDIF}
  Forms, Graphics, Classes, Grids, IB_Components;

type

{: Defines the interface required by a TWinControl derivative, in order
that the control can be dropped onto TIB_Grid.
<br><br>
Note also that the Column references are returned as TObject references
not as TIB_Column.  This is done so that (if desired) the interface
implementation can added to a base control class that may not wish to
force the inclusion of all IBO components at that level.  An example
of this is TCustomEditEnh (from the EnhComponents), which defines the
interface but does not return meaningful derivations until later
IBO-aware derivations.  TIB_Grid will (where necessary) check the actual
object type returned from these functions before using it.}
IIB_GridWinControl = interface
['{FC1EAC5C-258B-412E-A07E-53A6B3AD71A5}']
{: Return text that will be displayed by the control.}
  function GetText: string;
{: Translates the given AVal into an appropriate display text value.
Specifically provided for controls such as ComboBox where the field
contents may need to be displayed in user friendly form.  Controls
that dont require such translation should simply return AVal as the
result.  Note that the GetText function should return an already
translated value - this TranslateText function is provided for use
when determining the required display value from a row other than
the current row (which GetText will return).  So in order to achieve
this it is necessary to provide the source (AVal) for the translation.}
  function TranslateText(AVal: string): string;
{: Return the column that will be used as the display value on the grid.
This may (or may not) be the same as IB_Column.  For example lookup
controls that match to a foreign key column but may display a special
computed/calculated value.}
  function DisplayColumn: TObject;
{: Allow change the borderstyle.}
  procedure SetBorderStyle( AVal: TBorderStyle );
{: Allow access to the font.}
  function GetFont: TFont;
{: Allow change the font.}
  procedure SetFont( const AFont: TFont );
{: Allow change the color.}
  procedure SetColor( AColor: TColor );
{: Allow change the visibility.}
  procedure SetVisible( AVal: boolean );
{: Return whether the control has an active sub-control.
Primarily used by ComboBox styled controls that will return true if
the dropdown window is showing.}
  function HasActiveChild: boolean;
{: Allow IB_Grid to set the control bounds.}
  procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
{: Allow IB_Grid to notify of bounds change.}
  procedure BoundsChanged;
{: Allow IB_Grid to determine if the control can be focused.}
  function CanFocus: boolean;
{: Allow IB_Grid to set focus to the control.}
  procedure SetFocus;
{: Allow IB_Grid to invalidate the control display.}
  procedure Invalidate;
{: Return a reference to the IBO "AutoLabel" property of the control,
or nil if no AutoLabel exists.  This interface method is setup to return
a TObject to allow use in base classes and not require embedding the full
IBO library at that point.  The IBO routines will check any non-null return
value to be sure it is based on TIB_AutoLabel.}
  function GetAutoLabel: TObject;
end;

// *************** Changes by Wassim Haddad 6 January 2003 ****************** //
IIB_GridWinControlEx = interface
['{70024470-3B72-45DC-BF33-9002619B79C5}']
  function GetOwnersDraw: boolean;
  procedure SetOwnersDraw(AValue: boolean);
  property OwnersDraw: boolean read GetOwnersDraw write SetOwnersDraw;
  procedure OwnersDrawCell( ACol, ARow: Longint;
                            ARect: TRect;
                            AState: TGridDrawState;
                            CellDisplayText: string; //AColumn: TIB_Column;
                            CellAlignment: TAlignment );
end;
// ************************************************************************** //

implementation

end.
