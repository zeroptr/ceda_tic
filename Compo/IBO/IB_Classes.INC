
{                                                                              }
{  IB_Classes.inc                                                              }
{                                                                              }

// This file contains a lookup table of classes that are used in the generic
// template that provides all properties, methods, events with an IBO aware
// control.

{$IFDEF IBC_Text}           TIB_CustomText.           {$ENDIF}
{$IFDEF IBC_Date}           TIB_CustomDate.           {$ENDIF}
{$IFDEF IBC_DateTimePicker} TIB_CustomDateTimePicker. {$ENDIF}
{$IFDEF IBC_Edit}           TIB_CustomEdit.           {$ENDIF}
{$IFDEF IBC_Memo}           TIB_CustomMemo.           {$ENDIF}
{$IFDEF IBC_RichEdit}       TIB_CustomRichEdit.       {$ENDIF}
{$IFDEF IBC_CheckBox}       TIB_CustomCheckBox.       {$ENDIF}
{$IFDEF IBC_ComboBox}       TIB_CustomComboBox.       {$ENDIF}
{$IFDEF IBC_ListBox}        TIB_CustomListBox.        {$ENDIF}
{$IFDEF IBC_RadioGroup}     TIB_CustomRadioGroup.     {$ENDIF}
{$IFDEF IBC_Image}          TIB_CustomImage.          {$ENDIF}
{$IFDEF IBG_LookupCombo}    TIB_CustomCombo.          {$ELSE}
{$IFDEF IBG_CustomGrid}     TIB_CustomGrid.           {$ENDIF}{$ENDIF}

{$IFDEF IB_UserClass}
{$I IB_UserClasses.INC}
{$ENDIF}
