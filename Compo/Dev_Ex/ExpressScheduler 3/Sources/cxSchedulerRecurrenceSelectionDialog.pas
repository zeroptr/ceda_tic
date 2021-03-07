{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressScheduler                                 }
{                                                                    }
{       Copyright (c) 2003-2009 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSCHEDULER AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
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

unit cxSchedulerRecurrenceSelectionDialog;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, {$IFDEF DELPHI6} Variants, {$ENDIF} Classes,
  Graphics, Controls, Forms, Dialogs, cxLookAndFeelPainters, ExtCtrls, StdCtrls,
  cxButtons, cxRadioGroup, cxSchedulerStorage, Menus;

type
  { TfmRecurrenceSelection }

  TcxRecurrenceSelectionMode = (rsmOpen, rsmDeleting);

  TfmRecurrenceSelectionForm = class(TForm)
    lbMessage: TLabel;
    rbOccurrence: TcxRadioButton;
    rbSeries: TcxRadioButton;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    Image: TImage;
    pnlControls: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    FEvent: TcxSchedulerEvent;
    FMode: TcxRecurrenceSelectionMode;
  protected
    procedure DoShow; override;
    function GetFormColor: TColor; virtual;
    procedure SetCaptions; virtual;

    property Event: TcxSchedulerEvent read FEvent;
    property Mode: TcxRecurrenceSelectionMode read FMode;
  public
    constructor CreateEx(AEvent: TcxSchedulerEvent;
      AMode: TcxRecurrenceSelectionMode); virtual;
  end;

implementation

uses
  cxGraphics, cxSchedulerStrs, cxClasses, cxSchedulerDialogs;

{$R *.dfm}

{ TfmRecurrenceSelection }

constructor TfmRecurrenceSelectionForm.CreateEx(AEvent: TcxSchedulerEvent;
  AMode: TcxRecurrenceSelectionMode);
begin
  Create(Application);
  FEvent := AEvent;
  FMode := AMode;
  Image.Picture.Icon.Handle := LoadIcon(0, IDI_EXCLAMATION);
  SetCaptions;
end;

procedure TfmRecurrenceSelectionForm.DoShow;
begin
  if UseSchedulerColorInDialogs then
    Color := GetFormColor;
end;

function TfmRecurrenceSelectionForm.GetFormColor: TColor;
begin
  Result := btnOk.LookAndFeel.Painter.DefaultSchedulerControlColor;
end;

procedure TfmRecurrenceSelectionForm.SetCaptions;
var
  AEventCaption: string;
begin
  AEventCaption := '"' + Event.Caption + '" ';
  if Mode = rsmOpen then
  begin
    Caption := cxGetResourceString(@scxEditTypeDialogCaption);
    lbMessage.Caption := AEventCaption +
      cxGetResourceString(@scxEditRecurringEventDescription);
    rbOccurrence.Caption := cxGetResourceString(@scxEditTypeOccurrenceLabel);
    rbSeries.Caption := cxGetResourceString(@scxEditTypeSeriesLabel);
  end
  else
  begin
    Caption := cxGetResourceString(@scxDeleteTypeDialogCaption);
    lbMessage.Caption := AEventCaption +
      cxGetResourceString(@scxDeleteRecurringEventDescription);
    rbOccurrence.Caption := cxGetResourceString(@scxDeleteTypeOccurrenceLabel);
    rbSeries.Caption := cxGetResourceString(@scxDeleteTypeSeriesLabel);
  end;
  btnOk.Caption := cxGetResourcestring(@scxOk);
  btnCancel.Caption := cxGetResourcestring(@scxCancel);
end;

procedure TfmRecurrenceSelectionForm.FormCreate(Sender: TObject);
var
  ADelta: Integer;
begin
  ADelta := cxGetLabelGrowDelta(lbMessage);
  if ADelta > 0 then
  begin
    Height := Height + ADelta;
    pnlControls.Top := pnlControls.Top + ADelta;
  end;
end;

end.
