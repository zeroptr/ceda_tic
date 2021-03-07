{*******************************************************}
{                                                       }
{       TiValueConverterEdit Form                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iValueConverterEdit;{$endif}
{$ifdef iCLX}unit QiValueConverterEdit;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}
  {$IFDEF iVCL}  iEditorBasicComponents,  StdCtrls,  Controls,  ComCtrls,  ExtCtrls, Classes;{$ENDIF}
  {$IFDEF iCLX}QiEditorBasicComponents,  QStdCtrls, QControls, QComCtrls, QExtCtrls, Classes;{$ENDIF}

type
  TiValueConverterEditForm = class(TiCustomEditorForm)
    Panel2: TPanel;
    OkButton: TiComponentEditorButton;
    CancelButton: TiComponentEditorButton;
    PageControl: TiComponentEditorPageControl;
    IntervalTabSheet: TTabSheet;
    Price32TabSheet: TTabSheet;
    HoursUpDown: TiUpDown;
    MinutesUpDown: TiUpDown;
    SecondsUpDown: TiUpDown;
    MilliSecondsUpDown: TiUpDown;
    DaysUpDown: TiUpDown;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    HoursEdit: TiComponentEditorEdit;
    MinutesEdit: TiComponentEditorEdit;
    SecondsEdit: TiComponentEditorEdit;
    MilliSecondsEdit: TiComponentEditorEdit;
    DaysEdit: TiComponentEditorEdit;
    iUpDown1: TiUpDown;
    iUpDown2: TiUpDown;
    iUpDown3: TiUpDown;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Price32ndsEdit: TiComponentEditorEdit;
    Price256thsEdit: TiComponentEditorEdit;
    PriceIntegerEdit: TiComponentEditorEdit;
    ValueEdit: TiComponentEditorEdit;
    iUpDown4: TiUpDown;
    Label9: TLabel;
    WeeksEdit: TiComponentEditorEdit;
    DateTimeTabSheet: TTabSheet;
    DatePickerLabel: TLabel;
    TimePickerLabel: TLabel;
    SetNowButton: TiComponentEditorButton;
    iComponentEditorButton1: TiComponentEditorButton;
    procedure TimeChange(Sender: TObject);
    procedure Price32Change(Sender: TObject);
    procedure WeeksChange(Sender: TObject);
    procedure DateTimePickerChange(Sender: TObject);
    procedure SetNowButtonClick(Sender: TObject);
    procedure iComponentEditorButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    {$IFDEF iVCL}
    FDatePicker: TDateTimePicker;
    FTimePicker: TDateTimePicker;
    {$ENDIF}

    function  GetValue: Double;
    procedure SetValue(const Value: Double);
  public
    property Value : Double read GetValue write SetValue;
  end;

var
  iValueConverterEditForm: TiValueConverterEditForm;

implementation

{$R *.dfm}
//***********************************************************************************************************************************
procedure TiValueConverterEditForm.FormCreate(Sender: TObject);
begin
  {$IFDEF iVCL}
  FDatePicker          := TDateTimePicker.Create(Self);
  FDatePicker.Parent   := DateTimeTabSheet;
  FDatePicker.Left     := DatePickerLabel.Left + DatePickerLabel.Width + 5;
  FDatePicker.Top      := DatePickerLabel.Top - 3;
  FDatePicker.Width    := 137;
  FDatePicker.Kind     := dtkDate;
  FDatePicker.OnChange := DateTimePickerChange;

  FTimePicker          := TDateTimePicker.Create(Self);
  FTimePicker.Parent   := DateTimeTabSheet;
  FTimePicker.Left     := TimePickerLabel.Left + TimePickerLabel.Width + 5;
  FTimePicker.Top      := TimePickerLabel.Top - 3;
  FTimePicker.Width    := 137;
  FTimePicker.Kind     := dtkTime;
  FTimePicker.OnChange := DateTimePickerChange;
  {$ENDIF}

  {$IFDEF iCLX}
  DateTimeTabSheet.TabVisible := False;
  {$ENDIF}
end;
//***********************************************************************************************************************************
function TiValueConverterEditForm.GetValue: Double;
begin
  Result := ValueEdit.AsFloat;
end;
//***********************************************************************************************************************************
procedure TiValueConverterEditForm.SetValue(const Value: Double);
var
  Hour       : Word;
  Min        : Word;
  Sec        : Word;
  MSec       : Word;
  TempValue  : Double;
begin
  if Value > 1E14 then TempValue := Frac(Value) else TempValue := Value;

  ValueEdit.AsFloat := Value;

  {$IFDEF iVCL}
  FDatePicker.Date := Trunc(TempValue);
  FTimePicker.Time := TempValue - Trunc(TempValue);
  {$ENDIF}

  DaysEdit.AsInteger  := Trunc(TempValue);
  WeeksEdit.AsInteger := Trunc(TempValue) div 7;

  DecodeTime(TempValue, Hour, Min, Sec, MSec);

  HoursEdit.AsInteger        := Hour;
  MinutesEdit.AsInteger      := Min;
  SecondsEdit.AsInteger      := Sec;
  MilliSecondsEdit.AsInteger := MSec;

  PriceIntegerEdit.AsInteger := Trunc(Value);
  Price32ndsEdit.AsInteger   := Trunc(Frac(Value)/(1/32));
  Price256thsEdit.AsInteger  := Trunc((Frac(Value)-Price32ndsEdit.AsInteger*1/32)/(1/256));
end;
//***********************************************************************************************************************************
procedure TiValueConverterEditForm.TimeChange(Sender: TObject);
begin
  ValueEdit.AsFloat := DaysEdit.AsInteger + EncodeTime(HoursEdit.AsInteger, MinutesEdit.AsInteger, SecondsEdit.AsInteger, MilliSecondsEdit.AsInteger);
  SetValue(ValueEdit.AsFloat);
end;
//***********************************************************************************************************************************
procedure TiValueConverterEditForm.Price32Change(Sender: TObject);
begin
  ValueEdit.AsFloat := PriceIntegerEdit.AsInteger + Price32ndsEdit.AsInteger/32 + Price256thsEdit.AsInteger/256;
end;
//***********************************************************************************************************************************
procedure TiValueConverterEditForm.WeeksChange(Sender: TObject);
begin
  ValueEdit.AsFloat := WeeksEdit.AsInteger*7 + EncodeTime(HoursEdit.AsInteger, MinutesEdit.AsInteger, SecondsEdit.AsInteger, MilliSecondsEdit.AsInteger);
  SetValue(ValueEdit.AsFloat);
end;
//***********************************************************************************************************************************
procedure TiValueConverterEditForm.DateTimePickerChange(Sender: TObject);
begin
  {$IFDEF iVCL}
  ValueEdit.AsFloat := Trunc(FDatePicker.Date) + FTimePicker.Time - Trunc(FTimePicker.Time);
  SetValue(ValueEdit.AsFloat);
  {$ENDIF}
end;
//***********************************************************************************************************************************
procedure TiValueConverterEditForm.SetNowButtonClick(Sender: TObject);
begin
  ValueEdit.AsFloat := Now;
  SetValue(ValueEdit.AsFloat);
end;
//***********************************************************************************************************************************
procedure TiValueConverterEditForm.iComponentEditorButton1Click(Sender: TObject);
begin
  ValueEdit.AsFloat := 0;
  SetValue(ValueEdit.AsFloat);
end;
//***********************************************************************************************************************************
end.
