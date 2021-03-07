
{                                                                              }
{ IB_Controls                                                                  }
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
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains most of the standard data aware controls that come
with IB Objects.}
unit
  IB_Controls;

interface

uses
  SysUtils, Windows, Messages, Classes,

  DatePick, 

{$IFDEF IBO_VCL60_OR_GREATER}
  MaskUtils,
{$ENDIF}

  Controls, Forms, Graphics, Menus, StdCtrls, ExtCtrls, ComCtrls, Mask, Buttons,
  Dialogs, Clipbrd, CommCtrl,

  IB_Header,
  IB_Constants,
  IB_Components,
  IB_ControlInterface,
{$IFDEF IBO_VCL30_OR_GREATER}
  IBC_Label,
{$ENDIF}
  IB_FieldDataLink,
  uRounding,
  IB_Parse;

//IB_Editors
//IB_Grid
//IB_CGrid
//IB_Registration

//IB_Classes.INC
//IB_Control.INT
//IB_Control.PBL
//IB_WinControl.INT
//IB_WinControl.PBL

type
{$DEFINE IB_FieldControl}

{$DEFINE IBC_Text}
{$I IBC_Text.INT}
{$UNDEF IBC_Text}
{$DEFINE IBC_Edit}
{$I IBC_Edit.INT}
{$I IBC_Currency.INT}
{$UNDEF IBC_Edit}
{$DEFINE IBC_Date}
{$I IBC_Date.INT}
{$UNDEF IBC_Date}
{$IFDEF IBO_VCL30_OR_GREATER}
{$DEFINE IBC_DateTimePicker}
{$I IBC_DateTimePicker.INT}
{$UNDEF IBC_DateTimePicker}
{$ENDIF}
{$DEFINE IBC_Memo}
{$I IBC_Memo.INT}
{$UNDEF IBC_Memo}
{$DEFINE IBC_RichEdit}
{$I IBC_RichEdit.INT}
{$UNDEF IBC_RichEdit}
{$DEFINE IBC_CheckBox}
{$I IBC_CheckBox.INT}
{$UNDEF IBC_CheckBox}
{$DEFINE IBC_ComboBox}
{$I IBC_ComboBox.INT}
{$UNDEF IBC_ComboBox}
{$DEFINE IBC_ListBox}
{$I IBC_ListBox.INT}
{$UNDEF IBC_ListBox}
{$DEFINE IBC_RadioGroup}
{$I IBC_RadioGroup.INT}
{$UNDEF IBC_RadioGroup}
{$DEFINE IBC_Image}
{$I IBC_Image.INT}
{$UNDEF IBC_Image}

implementation

uses
  IB_Utils;

{$DEFINE IBC_Text}
{$I IBC_Text.IMP}
{$UNDEF IBC_Text}
{$DEFINE IBC_Edit}
{$I IBC_Edit.IMP}
{$I IBC_Currency.IMP}
{$UNDEF IBC_Edit}
{$DEFINE IBC_Date}
{$I IBC_Date.IMP}
{$UNDEF IBC_Date}
{$IFDEF IBO_VCL30_OR_GREATER}
{$DEFINE IBC_DateTimePicker}
{$I IBC_DateTimePicker.IMP}
{$UNDEF IBC_DateTimePicker}
{$ENDIF}
{$DEFINE IBC_Memo}
{$I IBC_Memo.IMP}
{$UNDEF IBC_Memo}
{$DEFINE IBC_RichEdit}
{$I IBC_RichEdit.IMP}
{$UNDEF IBC_RichEdit}
{$DEFINE IBC_CheckBox}
{$I IBC_CheckBox.IMP}
{$UNDEF IBC_CheckBox}
{$DEFINE IBC_ComboBox}
{$I IBC_ComboBox.IMP}
{$UNDEF IBC_ComboBox}
{$DEFINE IBC_ListBox}
{$I IBC_ListBox.IMP}
{$UNDEF IBC_ListBox}
{$DEFINE IBC_RadioGroup}
{$I IBC_RadioGroup.IMP}
{$UNDEF IBC_RadioGroup}
{$DEFINE IBC_Image}
{$I IBC_Image.IMP}
{$UNDEF IBC_Image}

{$UNDEF IB_FieldControl}

end.
