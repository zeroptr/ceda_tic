{------------------------------------------------------------------------------}
{                                                                              }
{  Office Assistant                                                            }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

{$I DELPHIAREA.INC}

unit oaConst;

interface

uses
  Dialogs, oaTypes;

const

  { Message Balloon Buttons }
  DefMsgDlgBtns: array[mbYes..mbHelp] of String =
    ('&Yes', '&No', '&OK', 'Cancel', '&Abort', '&Retry',
     '&Ignore', 'All', 'No To All', 'Yes To All', '&Help');

  { Tips Balloon Buttons }
  DefTipsDlgBtns: array[TTipsDlgBtn] of String =
    ('Close', '&Next', '&Back');

  { Guide Balloon Buttons }
  DefGuideDlgBtns: array[TGuideDlgBtn] of String =
    ('Close', '&Options', '&Tips', '&Search', 'See previous...', 'See more...');

  { Hint Balloon Buttons }
  DefHintDlgBtns: array[THintDlgBtn] of String =
    ('&OK', 'See previous...', 'See more...');

  { Input Query Balloon Buttons }
  DefQueryDlgBtns: array[TQueryDlgBtn] of String =
    ('&OK', 'Cancel');

implementation

end.
