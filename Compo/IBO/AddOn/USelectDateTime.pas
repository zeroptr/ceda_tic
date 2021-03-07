unit USelectDateTime;
{******************************************************************************}
interface
{******************************************************************************}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Spin, Grids, Calendar, StdCtrls, ExtCtrls;
{******************************************************************************}
function SelectDateTime(OriginalDateTime : TDateTime) : TDateTime;
{******************************************************************************}
type
  TformSelectDateTime = class(TForm)
    Panel8: TPanel;
    Label3: TLabel;
    Label7: TLabel;
    radAM: TRadioButton;
    radPM: TRadioButton;
    Panel9: TPanel;
    calSelectDate: TCalendar;
    Label4: TLabel;
    Label6: TLabel;
    cmbHour: TComboBox;
    cmbMinute: TComboBox;
    cmbYear: TComboBox;
    pnlDateAndTime: TPanel;
    cmbMonth: TComboBox;
    Panel1: TPanel;
    cmdCancel: TBitBtn;
    cmdOk: TBitBtn;
    cmdNow: TBitBtn;
    cmdClear: TBitBtn;
    procedure cmdNowClick(Sender: TObject);
    procedure cmdClearClick(Sender: TObject);
    procedure SetDateTime;
    procedure FormCreate(Sender: TObject);
    procedure calSelectDateChange(Sender: TObject);
    procedure cmbHourChange(Sender: TObject);
    procedure cmbMinuteChange(Sender: TObject);
    procedure radAMClick(Sender: TObject);
    procedure radPMClick(Sender: TObject);
    procedure cmbMonthChange(Sender: TObject);
    procedure cmbYearChange(Sender: TObject);
    procedure SetDateTimeValues(TheDateTime : TDateTime);
    procedure SetToNow;
    procedure FormShow(Sender: TObject);
  public
    SelectedDateTime : TDateTime;
  end;
{******************************************************************************}
var
  formSelectDateTime: TformSelectDateTime;
{******************************************************************************}
implementation
{******************************************************************************}
{$R *.DFM}
{******************************************************************************}
function SelectDateTime(OriginalDateTime : TDateTime) : TDateTime;
var
  formSelectDateTime : TformSelectDateTime;
begin
  formSelectDateTime := TformSelectDateTime.Create(Application);
  with formSelectDateTime do begin
    if OriginalDateTime > 0 then SelectedDateTime := OriginalDateTime else SelectedDateTime := Now;
    pnlDateAndTime.Caption := FormatDateTime('ddd d mmm yyyy h:nn AM/PM',SelectedDateTime);
    SetDateTimeValues(SelectedDateTime);
    ShowModal;
    if ModalResult = mrOk then Result := SelectedDateTime else Result := OriginalDateTime;
    Destroy;
  end;
end;
{******************************************************************************}
procedure TformSelectDateTime.SetDateTimeValues(TheDateTime : TDateTime);
var
  Year,Month,Day : Word;
  i : Integer;
begin
  DecodeDate(TheDateTime,Year,Month,Day);
  calSelectDate.Day := Day;
  calSelectDate.Month := Month;
  calSelectDate.Year := Year;

  for i := 0 to cmbMonth.Items.Count - 1 do begin
    if cmbMonth.Items[i] = FormatDateTime('mmmm',TheDateTime) then begin
      cmbMonth.ItemIndex := i;
      Break;
    end;
  end;

  cmbYear.Text := FormatDateTime('yyyy',TheDateTime);

  if FormatDateTime('hh',TheDateTime) = '00' then begin
    cmbHour.ItemIndex := 11;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '01' then begin
    cmbHour.ItemIndex := 0;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '02' then begin
    cmbHour.ItemIndex := 1;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '03' then begin
    cmbHour.ItemIndex := 2;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '04' then begin
    cmbHour.ItemIndex := 3;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '05' then begin
    cmbHour.ItemIndex := 4;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '06' then begin
    cmbHour.ItemIndex := 5;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '07' then begin
    cmbHour.ItemIndex := 6;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '08' then begin
    cmbHour.ItemIndex := 7;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '09' then begin
    cmbHour.ItemIndex := 8;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '10' then begin
    cmbHour.ItemIndex := 9;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '11' then begin
    cmbHour.ItemIndex := 10;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '12' then begin
    cmbHour.ItemIndex := 11;
    radAM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '13' then begin
    cmbHour.ItemIndex := 0;
    radPM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '14' then begin
    cmbHour.ItemIndex := 1;
    radPM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '15' then begin
    cmbHour.ItemIndex := 2;
    radPM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '16' then begin
    cmbHour.ItemIndex := 3;
    radPM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '17' then begin
    cmbHour.ItemIndex := 4;
    radPM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '18' then begin
    cmbHour.ItemIndex := 5;
    radPM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '19' then begin
    cmbHour.ItemIndex := 6;
    radPM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '20' then begin
    cmbHour.ItemIndex := 7;
    radPM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '21' then begin
    cmbHour.ItemIndex := 8;
    radPM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '22' then begin
    cmbHour.ItemIndex := 9;
    radPM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '23' then begin
    cmbHour.ItemIndex := 10;
    radPM.Checked := True;
  end else if FormatDateTime('hh',TheDateTime) = '24' then begin
    cmbHour.ItemIndex := 11;
    radPM.Checked := True;
  end;

  for i := 0 to cmbMinute.Items.Count - 1 do begin
    if cmbMinute.Items[i] = FormatDateTime('nn',TheDateTime) then begin
      cmbMinute.ItemIndex := i;
      Break;
    end;
  end;
end;
{******************************************************************************}
procedure TformSelectDateTime.SetDateTime;
var
  TheDateTime : TDateTime;
  AMorPM : String;
begin
  if Showing then begin
    if radAM.Checked then AMorPM := 'AM' else AMorPM := 'PM';
    TheDateTime := StrToDateTime(IntToStr(calSelectDate.Month) + '/ ' +
      IntToStr(calSelectDate.Day) + '/ ' + IntToStr(calSelectDate.Year) + ' ' +
      cmbHour.Text + ':' + cmbMinute.Text + AMorPM);

    SelectedDateTime := TheDateTime;
    pnlDateAndTime.Caption := FormatDateTime('ddd d mmm yyyy h:nn AM/PM',SelectedDateTime);
  end;
end;
{******************************************************************************}
procedure TformSelectDateTime.cmdNowClick(Sender: TObject);
begin
  SetToNow;
end;
{******************************************************************************}
procedure TformSelectDateTime.SetToNow;
var
  TheDateTime : TDateTime;
begin
  TheDateTime := Now;
  SetDateTimeValues(TheDateTime);
  SelectedDateTime := TheDateTime;
  pnlDateAndTime.Caption := FormatDateTime('ddd d mmm yyyy h:nn AM/PM',SelectedDateTime);
end;
{******************************************************************************}
procedure TformSelectDateTime.cmdClearClick(Sender: TObject);
begin
  SelectedDateTime := 0;
  pnlDateAndTime.Caption := '';
end;
{******************************************************************************}
procedure TformSelectDateTime.FormCreate(Sender: TObject);
var
  Year,Month,Day : Word;
  i : Integer;
begin
  DecodeDate(Now,Year,Month,Day);
  for i := -50 to 50 do cmbYear.Items.Add(IntToStr(Year + i));
  cmbYear.Text := FormatDateTime('yyyy',Now);
end;
{******************************************************************************}
procedure TformSelectDateTime.calSelectDateChange(Sender: TObject);
begin
  SetDateTime;
end;
{******************************************************************************}
procedure TformSelectDateTime.cmbHourChange(Sender: TObject);
begin
  SetDateTime;
end;
{******************************************************************************}
procedure TformSelectDateTime.cmbMinuteChange(Sender: TObject);
begin
  SetDateTime;
end;
{******************************************************************************}
procedure TformSelectDateTime.radAMClick(Sender: TObject);
begin
  SetDateTime;
end;
{******************************************************************************}
procedure TformSelectDateTime.radPMClick(Sender: TObject);
begin
  SetDateTime;
end;
{******************************************************************************}
procedure TformSelectDateTime.cmbMonthChange(Sender: TObject);
begin
  try
    calSelectDate.Month := cmbMonth.ItemIndex + 1;
  except
    calSelectDate.Day := 1;
    calSelectDate.Month := cmbMonth.ItemIndex + 1;
  end;
end;
{******************************************************************************}
procedure TformSelectDateTime.cmbYearChange(Sender: TObject);
begin
  try
    calSelectDate.Year := StrToInt(cmbYear.Text);
  except
    calSelectDate.Day := 1;
    calSelectDate.Year := StrToInt(cmbYear.Text);
  end;
end;
{******************************************************************************}
procedure TformSelectDateTime.FormShow(Sender: TObject);
begin
  calSelectDate.SetFocus;
end;
{******************************************************************************}
end.
{******************************************************************************}
