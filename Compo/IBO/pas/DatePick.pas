//==============================================================================
//
// Unit:    DatePick.pas         Copyright (c) 1999 by Lars George
//
// Author:  Lars George
//          lgeorge@gmx.net
//
// Created: 20 February 1999
//
// Purpose: The component TDatePick is a small calendar which could be hooked
//          to e.g. edit controls. The user can select the date which auto-
//          matically will be transfered to the control. It looks like the
//          DatePicker which Outlook 98 uses.
//
// Changes:
//          24 Set 02 LA - Luiz Alves. Fix problem with only rectangle
//                         of the control is painted in design time without
//                         paint days and months

//          24 Set 02 LA - Luiz Alves. Fix problem with rectangle
//                         of the control falling out of the screen when
//                         ib_date is positioned near the corners of the form
//                         and this Form is maximized

//          24 Set 02 LA - Luiz Alves. Alterado ShowCalendar to
//                         improve position of Calendar on screen when
//                         ib_date is positioned near the corners of the form
//                         and this Form is maximized


//          03 May 02 GK - Guido Klapperich. Added three new properties
//                         TopPanelColor, TopPanelFontColor and ArrowColor
//          03 May 02 MM  - Marco Menardi: NormalCellColor now works
//          13 Mar 02 MM bis - Marco Menardi: Today and Cancel buttons now are
//                         properly sized if non default font is used
//          13 Mar 02 MM - Marco Menardi strike-drawing font style bugfix
//                         (doBoldSat/Sun now works)
//          28 Feb 02 jlw - Added various color variables for flexibility.
//                          Enhanced day of week width to a property.
//          26 Feb 02 af - minor strike-drawing changes
//          25 Feb 02 MM - Marco Menardi. added a vertical line separating
//                         number of the week from the days of the calendar.
//                         Added doBoldSaturday, doBoldSunday to display in
//                         boldface Sundays and/or Saturdays.
//                         Day of the week now is 3 letters long.
//                         Cells a bit wider to better accommodate bold fonts,
//                         number of the week and 3 letter name of the day.
//                         Changed day and lines color to clNavy, today border
//                         to clRed (better contrast).
//          21 Jan 02 af - enhanced "OnStrike" event, it can now fill the
//                         day with a solid background color. The number
//                         is colored "black" or "white" to ensure highest
//                         contrast.
//          15 Jan 02 jlw - The DatePick window used in the TIB_Date control
//                          should work fine again.
//          22 Nov 01 jlw - I fixed a Font resource leak
//                          WIP
//                          I added csCaptureMouse to the ControlStyle property
//                          in order to make the MonthWindow receive mousemove
//                          notifications when the mouse is outside of the
//                          datepick window. I noticed this problem because the
//                          selected month would not select when moving the
//                          mouse above the top of the datepick window.
//          25/04/01 af - added a event proc that is called for every
//                        Date that is shown in the calender. You can
//                        proof (in your special context) that the selection
//                        of this date makes any sense
//                        date that makes no sense.
//          23/03/01 ML - Changed IncWidth & IncHeight to properties
//                        Added year arrows & show/hide property
//          29/08/00 af - added property "ChangeOnMonthClick", default=false,
//                        set it to true if you use the OnChange-Event AND
//                        you want to be informend, if the user changed the
//                        month by clicking on the small "month" arrows.
//                        For the default behavior (as a element of TIB_Date)
//                        set it to false.
//          16/08/00 af - added procedure TodayClick; to set Date to today
//                        by external call.
//                        bug: click on small "month" arrows did not fire
//                             OnChanged-event.
//          03/05/00 cw - Removed call to SetFocus in TDatePick.ShowCalendar,
//                        which was causing focus problems with use of TAB.
//
//          21/04/00 cw - Modified ProcessKeyDown to give a more consistent
//                        interface.  Note: the HOME/END modification matches
//                        operation of the M$oft date time picker....
//                          LEFT, RIGHT        - day
//                          UP, DOWN           - week
//                          PUP, PDN           - month
//                          CTRL+PUP, CTRL+PDN - year                ***added***
//
//                          HOME, END - first/last day of month   ***modified***
//                          CTRL+HOME, CTRL+END - 1st/12th month     ***added***
//
//                        Added these for ease of use...
//                          CTRL+LEFT, CTRL+RIGHT - month
//                          CTRL+UP, CTRL+DN      - year
//
//                          SPACE - show today as selected (don't close!!)
//
//                        The following keys work even when the datepick is
//                        not active...
//                          CTRL+SPACE - select today and return dpOK (close)
//                          CTRL+DELETE - clear, return dpClear (close)
//
//                        Also added code to make TAB & SHIFT+TAB return dpOK,
//                        and modified TIB_Date to move to the next control as
//                        is normally expected for TAB key operation.
//
//          20/04/00 cw - Added public method ProcessKeyDown to give more
//                        robust key handling when used as a dropdown in
//                        TIB_Date (called by TIB_CustomDate.WMKeyDown).
//
//          19/04/00 cw - Made TDatePick.HideCalendar hide the MonthWindow, as
//                        it would hang around on some user actions.
//
//          29/11/99 lg - Replaced API call by another one to make calendar
//                        work with StayOnTop forms (see 'ShowCalendar').
//
//          19/05/99 lg - Finished key handling. After diving deep into the VCL
//                        code I found the CNKeyDown message which was it.
//                        Renamed event 'FOnClose' to 'FOnChange' as it makes
//                        more sense.
//
//          29/04/99 lg - Changed calculation of position for calendar to make
//                        it work with all Delphi version as it is important.
//                        Removed obsolete code and fixed second call of Hide-
//                        Calendar after restoring mouse capture.
//
//          23/04/99 lg - Added message handler to close calendar if application
//                        loses its focus, otherwise causes GUI confusion.
//
//          23/04/99 lg - Made changes to make behaviour even more like the
//                        the original MS one. Fixed closing problem after
//                        MonthList was opened due to capture misuse.
//
//          20/04/99 jlw - Adapted to work with Delphi 2 and fixed a design-time
//                         related problem where the calendar would show up off
//                         the form.
//
//          22/02/99 lg - first version written in three days from scratch
//                        -> Delphi rules! :-)
//
// Notes:   21/02/99 lg - doRangeSelect does not work so far
//                        -> future enhancement
//
//==============================================================================
unit DatePick;

{$INCLUDE IB_Directives.inc}

{$IFDEF VER90}
{$O-} // Turn off optimization since there appears to be a bug in Delphi 2.
{$ENDIF}

interface

uses
  Windows, Messages,
  SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls, Buttons, Mask,

  IB_Constants;

//==============================================================================

const
 cStrikeOption_FontStrikeOut = $01000000;
 cStrikeOption_Cross         = $02000000;

type
  TDatePickButton = class(TSpeedButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TDatePick = class;

  TMonthWindow = class(TCustomControl)
  private
    FDate: TDateTime;
    FDirection: Integer;
    FLineHeight: Integer;
    FSelectedLine: Integer;
    FTimer: TTimer;
    function GetLineRect( ALine: Integer ): TRect;
    function GetMonthLabel( AOffset: Integer ): String;
    function GetMouseLine( X, Y: Integer ): Integer;
    function GetSelectedDate: TDateTime;
    procedure ScrollTimer( Sender: TObject );
    procedure WMNCHitTest( var Message: TWMNCHitTest ); message WM_NCHITTEST;
    procedure WMNCPaint( var Message: TMessage ); message WM_NCPAINT;
  protected
    procedure CreateParams( var Params: TCreateParams ); override;
    procedure Paint; override;
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    procedure HideWindow;
    function IsActive: Boolean;
    procedure OpenWindow( Rect: TRect );
    procedure ProcessMouseMove( Shift: TShiftState; X, Y: Integer );
    property Date: TDateTime read FDate write FDate;
    property Font;
    property SelectedDate: TDateTime read GetSelectedDate;
    property SelectedLine: Integer read FSelectedLine;
  end;

  // Define a set of options for this component
  //   doShowWeeks:   Show week number in front of every row
  //   doRangeSelect: Allow selction of range for start/end date selection
  //   doClearButton: Show a button labelled 'Clear' which erases the date
  //   doTodayButton: Show a button labelled 'Today' which selects the current
  //                  date
  //   doShowOverlap: Show days of previous and next month (as grayed numbers)
  //                  too
  //   doBoldSaturday: Show Saturdays in boldface
  //   doBoldSunday:   Show Sundays in boldface

  TDatePickOption = (doShowWeeks, doRangeSelect, doClearButton,
    doTodayButton, doShowOverlap, doBoldSaturday, doBoldSunday );
  TDatePickOptions = set of TDatePickOption;

  // Result values
  //   dpOK:         A date was selected, everything is fine
  //   dpClear:      Clear buttons was pressed, so that attached control
  //                 should clear it's value too.
  //   dpNoChanges: The user has e.g. clicked outside the control
  TDatePickResult = ( dpOK, dpClear, dpNoChanges );

  // New eventhandler prototype for TDatePick component event
  TDatePickChangeEvent = procedure ( Sender: TDatePick;
                                     Value: TDatePickResult ) of object;
  TDatePickStrikeEvent = procedure (     Sender: TDatePick; //AF 2001-04-25
                                         CheckThisDate: TDateTime;
                                     var CrossColor : TColor ) of object;

  // Set of first day of week
  TDatePickStartDay = (sdMon, sdTue, sdWed, sdThu, sdFri, sdSat, sdSun);

  // Set of first week of year
  //   fwFirstJanuary:  first week starts on 1 January
  //   fwFirstFullWeek: first week starts on first full week
  //   fwFirstFourDays: first week starts on first week with at least 4 days
  TDatePickFirstWeek = (fwFirstJanuary, fwFirstFullWeek, fwFirstFourDays);

  TDatePick = class(TCustomPanel)
  private
    FBorderGap: Integer;
    FButtonToday: TDatePickButton;
    FButtonClear: TDatePickButton;
    FCellHeight: Integer;
    FCellGrid: TRect;
    FCellWidth: Integer;
    FIncCellHeight: Integer; //ML  2001-03-23
    FIncCellWidth: Integer;  //ML  2001-03-23
    FDrawYearArrow: boolean; //ML  2001-03-23
    FDate: TDateTime;
    FFirstWeek: TDatePickFirstWeek;
    FFontHeight: Integer;
    FHidden: Boolean;
    FLeftArrow: Boolean;
    FMonthWindow: TMonthWindow;
    FMouseDown: Boolean;
    FOnChange: TDatePickChangeEvent;
    FOnStrike: TDatePickStrikeEvent; //AF 2001-04-25
    FOptions: TDatePickOptions;
    FPanelHeight: Integer;
    FSelectedDate: TDateTime;
    FStartDay: TDatePickStartDay;
    FTimer: TTimer;
    FWasLoaded: Boolean;
    FWeekNumFontSize: Integer;
    FHeaderFontSize: Integer;
    FTodayButtonCaption: string;
    FClearButtonCaption: string;
    FChangeOnMonthClick: boolean; // AF 2000-08-29
    FNormalCellLineColor: TColor;// := clDkGray;
    FSelectedCellColor: TColor;// := clSilver;
    FSelectedCellFontColor: TColor;// := clWhite;
    FNormalCellColor: TColor;// := clWhite;
    FDifMonthFontColor: TColor;// := clDkGray;
    FNormalCellFontColor: TColor;// := clBlack
    FTodayCellColor: TColor;// := clMaroon
    FDayOfWeekStrLen: integer;
    FTopPanelColor: TColor; //GK 2002-05-03
    FTopPanelFontColor: TColor; //GK 2002-05-03
    FArrowColor: TColor; //GK 2002-05-03
    procedure AdjustBounds;
    procedure AdjustButtons;
    procedure ArrowTimer(Sender: TObject);
    procedure BtnClick(Sender: TObject);
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CreateButtons;
    function GetArrowRect(ALeft: Boolean): TRect;
    function GetArrow2Rect(ALeft: Boolean): TRect;
    function GetCellFromPos(X, Y: Integer; var Cell: TPoint): Boolean;
    function GetCellRect(ACol, ARow: Integer): TRect;
    function GetHeaderRect(ACol: Integer): TRect;
    function GetMonthLabelRect: TRect;
    function GetPartOfDate(Index: Integer): Word;
    function SelectCell(X, Y: Integer): Boolean;
    procedure SetStartDay(const Value: TDatePickStartDay);
    procedure SetOptions(const Value: TDatePickOptions);
    procedure SetFirstWeek(const Value: TDatePickFirstWeek);
    procedure SetTodayButtonCaption( AValue: string );
    procedure SetClearButtonCaption( AValue: string );
    procedure SetChangeOnMonthClick( AValue: boolean );
    procedure WMCaptureChanged(var Message:TMessage); message WM_CAPTURECHANGED;
    procedure SetIncCellHeight(AValue: Integer); //ML 2001-03-23
    procedure SetIncCellWidth(AValue: Integer); //ML 2001-03-23
    procedure SetDrawYearArrow(AValue: boolean); //ML 2001-03-23
    procedure SetDayOfWeekStrLen( AValue: integer );
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DoChange(Value: TDatePickResult); dynamic;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure HideCalendar;
    function IsActive: Boolean;
    procedure ShowCalendar(Position: TPoint);
    property Date: TDateTime read FDate write FDate;
    property Day: Word index 1 read GetPartOfDate;
    property Hidden: Boolean read FHidden write FHidden;
    property Month: Word index 2 read GetPartOfDate;
    property Year: Word index 3 read GetPartOfDate;
    procedure ProcessKeyDown(var Message: TWMKeyDown);
    procedure TodayClick;
    procedure DoStrike(     CheckThisDate: TDateTime;
                        var CrossColor: TColor ); dynamic;
  published
    property Enabled;
    property FirstWeek: TDatePickFirstWeek read FFirstWeek write SetFirstWeek;
    property Font;

    property NormalCellLineColor: TColor read FNormalCellLineColor
                                         write FNormalCellLineColor
                                         default clDkGray;
    property SelectedCellColor: TColor read FSelectedCellColor
                                       write FSelectedCellColor
                                       default clSilver;
    property SelectedCellFontColor: TColor read FSelectedCellFontColor
                                           write FSelectedCellFontColor
                                           default clWhite;
    property NormalCellColor: TColor read FNormalCellColor
                                     write FNormalCellColor
                                     default clWhite;
    property DifMonthFontColor: TColor read FDifMonthFontColor
                                       write FDifMonthFontColor
                                       default clDkGray;
    property NormalCellFontColor: TColor read FNormalCellFontColor
                                         write FNormalCellFontColor
                                         default clBlack;
    property TodayCellColor: TColor read FTodayCellColor
                                    write FTodayCellColor
                                    default clMaroon;

    property DayOfWeekStrLen: integer read FDayOfWeekStrLen
                                      write SetDayOfWeekStrLen
                                      default 1;


    property OnChange: TDatePickChangeEvent read FOnChange write FOnChange;
    property OnStrike: TDatePickStrikeEvent read FOnStrike write FOnStrike;
    property Options: TDatePickOptions read FOptions write SetOptions
      default [doClearButton, doTodayButton, doShowOverlap];
    property ParentFont;
    property StartDay: TDatePickStartDay read FStartDay write SetStartDay;
    property TodayButtonCaption: string read FTodayButtonCaption
                                        write SetTodayButtonCaption;
    property ClearButtonCaption: string read FClearButtonCaption
                                        write SetClearButtonCaption;
    property Visible;
    property ChangeOnMonthClick: boolean read FChangeOnMonthClick
                                         write SetChangeOnMonthClick;
    property IncCellHeight: Integer read FIncCellHeight write SetIncCellHeight;
    property IncCellWidth: Integer  read FIncCellWidth write SetIncCellWidth;
    property DrawYearArrow: boolean read FDrawYearArrow write SetDrawYearArrow;

    property TopPanelColor: TColor read FTopPanelColor
                                   write FTopPanelColor
                                   default clSilver; //GK 2002-05-03
    property TopPanelFontColor: TColor read FTopPanelFontColor
                                       write FTopPanelFontColor
                                       default clBlack; //GK 2002-05-03
    property ArrowColor: TColor read FArrowColor
                                write FArrowColor
                                default clBlack; //GK 2002-05-03
  end;

//==============================================================================

implementation

{$R *.RES}

uses
  Forms, Dialogs;

//==============================================================================

const
  INC_ARROW_BORDER  = 6;    // gap between arrows and border
  DEC_ARROW_SIZE    = 3;    // upper and lower gap of arrows to panel height

  INC_ARROWY_BORDER  = 18; // ML 2001-03-23
  INC_ARROWY2_BORDER = 22; // ML 2001-03-23

  INC_CELL_HEIGHT   = 1;    // increase every cell of calendar by this value
  INC_CELL_WIDTH    = 2;    // increase every cell of calendar by this value
// ****  INC_CELL_HEIGHT   = 2;    // increase every cell of calendar by this value
// ****  INC_CELL_WIDTH    = 4;    // increase every cell of calendar by this value
  INC_PANEL_TOP     = 5;    // height of top panel = FontHeight plus this value
  INC_FORM_BOTTOM   = 3;    // gap between lower line and border or buttons
  INC_FORM_BUTTON   = 6;    // gap between buttons and lower border
  INC_BUTTON_HEIGHT = 7;    // height of buttons = FontHeight plus this value
  INC_BUTTON_WIDTH  = 17;   // width of buttons = Caption width plus this value

  OFF_LIST_SLOW     = 10;   // area for slow scrolling month list

  // the next two values only apply when the user clicks and holds the mouse
  // button on top of an arrow. After the initial waiting period the button
  // fires as long as the user releases the mouse button.
  TIM_FIRST         = 400;  // initial waiting period of arrow buttons
  TIM_NEXT          = 150;  // pause between each 'click' of arrow button

  TIM_SCROLL        = 50;   // speed step for month list to scroll

// Modified by JLW so that this can be used with Delphi 2.

{$IFNDEF IBO_VCL30_OR_GREATER}
type
  PDayTable = ^TDayTable;
  TDayTable = array[1..12] of Word;

const
  MonthDays: array [Boolean] of TDayTable =
    ((31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31),
     (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31));

function IsLeapYear(Year: Word): Boolean;
begin
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

function IncMonth(const Date: TDateTime; NumberOfMonths: Integer): TDateTime;
var
  DayTable: PDayTable;
  Year, Month, Day: Word;
  Sign: Integer;
begin
  if NumberOfMonths >= 0 then Sign := 1 else Sign := -1;
  DecodeDate(Date, Year, Month, Day);
  Year := Year + (NumberOfMonths div 12);
  NumberOfMonths := NumberOfMonths mod 12;
  Inc(Month, NumberOfMonths);
  if Word(Month-1) > 11 then    // if Month <= 0, word(Month-1) > 11)
  begin
    Inc(Year, Sign);
    Inc(Month, -12 * Sign);
  end;
  DayTable := @MonthDays[IsLeapYear(Year)];
  if Day > DayTable^[Month] then Day := DayTable^[Month];
  Result := EncodeDate(Year, Month, Day) + Frac(Date);
end;
{$ENDIF}

type
  TDateDetail = (ddYear, ddMonth, ddDay);

//==============================================================================

// Helper: Splits a given date into parts
function DateDetail(Value: TDateTime; Detail: TDateDetail): Word;
var
  wYear, wMonth, wDay: Word;
begin
  Result := 0;
  DecodeDate(Value, wYear, wMonth, wDay);
  case Detail of
    ddYear: Result := wYear;
    ddMonth: Result := wMonth;
    ddDay: Result := wDay;
  end;
end;

//------------------------------------------------------------------------------

// Helper: Return day of week adjusted to start value
// (1 = first day) (7 = last day)
function WeekDay(ADate: TDateTime; StartOfWeek: Word): Integer;
begin
  Result := DayOfWeek(ADate);
  Dec( Result, StartOfWeek + 1 );
  if Result < 1
  then Inc( Result, 7 );
end;

//------------------------------------------------------------------------------

// Helper: Calculate date for given cell (zero based)
function DateFromPos( X, Y, Year, Month, StartOfWeek: Word ): TDateTime;
var
  DayCount: Integer;
  wDay: Word;
begin
  wDay := WeekDay(EncodeDate(Year, Month, 1), StartOfWeek);
  DayCount := Y * 7 + X - wDay + 2;
  // adjust month with first day in first cell to show previous month
  if wDay = 1 then Dec(DayCount, 7); // add one week
  // if DayCount < 1 then the date is in previous month
  if DayCount < 1
  then begin
    if Month = 1 then
      Result := EncodeDate( Year - 1, 12,
                            MonthDays[IsLeapYear(Year - 1), 12] + DayCount )
    else
      Result := EncodeDate( Year, Month - 1,
                            MonthDays[IsLeapYear(Year), Month - 1] + DayCount );
  end
  else
  begin
    // check if DayCount is greater then days in month -> must be next month
    if DayCount > MonthDays[IsLeapYear(Year), Month] then
    begin
      if Month = 12 then
        Result := EncodeDate( Year + 1, 1,
                              DayCount - MonthDays[IsLeapYear(Year), Month] )
      else
        Result := EncodeDate( Year, Month + 1,
                              DayCount - MonthDays[IsLeapYear(Year), Month] );
    end
    else
      Result := EncodeDate( Year, Month, DayCount); // 'normal' date
  end;
end;

//------------------------------------------------------------------------------

// Helper: Compare two dates and return true if Year or Month is different
function IsDifferentMonth(ADate, BDate: TDateTime): Boolean;
begin
  Result := (DateDetail(ADate, ddYear) <> DateDetail(BDate, ddYear)) or
            (DateDetail(ADate, ddMonth) <> DateDetail(BDate, ddMonth));
end;

//------------------------------------------------------------------------------

// Helper: Calculate week number of given date with given parameters
function WeekNumber(ADate: TDateTime; StartOfWeek, StartOfYear: Word): Word;
var
  Year, Month, Day: Word;
  DayCount: Integer;
  I: Integer;
  wDay: Word;
  FirstWeekDay: Integer; // first day of week (could be in previous year)
  LastWeekDay: Integer;  // last day of week
begin
  DecodeDate(ADate, Year, Month, Day);
  // first day
  wDay := WeekDay(EncodeDate(Year, 1, 1), StartOfWeek);
  case StartOfYear of
       // fwFirstJanuary
    0: FirstWeekDay := 2 - wDay;
       // fwFirstFullWeek
    1: if wDay = 1 // only Mon
       then FirstWeekDay := 2 - wDay
       else FirstWeekDay := 9 - wDay;
       // fwFirstFourDays
    else if (wDay >= 1) and (wDay <= 4) // between Mon and Thu
         then FirstWeekDay := 2 - wDay
         else FirstWeekDay := 9 - wDay;
  end;
  // last day
  wDay := WeekDay(EncodeDate(Year + 1, 1, 1), StartOfWeek);
  if IsLeapYear(Year)
  then LastWeekDay := 366
  else LastWeekDay := 365;
  case StartOfYear of
       // fwFirstJanuary
    0: LastWeekDay := LastWeekDay - wDay;
       // fwFirstFullWeek
    1: if wDay = 1 // only Mon
       then LastWeekDay := LastWeekDay - wDay;
       // fwFirstFourDays
    else if (wDay >= 1) and (wDay <= 4) // between Mon and Thu
         then LastWeekDay := LastWeekDay - wDay;
  end;
  // actual day
  DayCount := Day;
  for I := 1 to Month - 1 do
    Inc(DayCount, MonthDays[IsLeapYear(Year), I]);
  // final calculation
  if DayCount > LastWeekDay
  then Result := 1
  else Result := (DayCount - FirstWeekDay) div 7 + 1;
end;

//==============================================================================

// Override: Make button replicable
constructor TDatePickButton.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  ControlStyle := ControlStyle + [ csReplicatable ];
end;

//==============================================================================

// Override: Initialize all needed parameters while creating the control
constructor TMonthWindow.Create(AOwner: TComponent);
//var
//  NonClientMetrics: TNonClientMetrics;
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [ csReplicatable ];
  Color := clWhite;
{
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  if SystemParametersInfo( SPI_GETNONCLIENTMETRICS,
                           0,
                           @NonClientMetrics, 0 ) then
    Canvas.Font.Handle := CreateFontIndirect( NonClientMetrics.lfStatusFont )
  else
}
    Canvas.Font.Size := 8;
  Canvas.Brush.Style := bsClear;
  // force painting on memory DC to avoid flicker
{$IFDEF IBO_VCL40_OR_GREATER}
  DoubleBuffered := True;
{$ENDIF}
  // create timer object
  FTimer := TTimer.Create(Self);
  FTimer.Enabled := False;
  FTimer.OnTimer := ScrollTimer;
end;

destructor TMonthWindow.Destroy;
//var
//  NonClientMetrics: TNonClientMetrics;
begin
{
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  if SystemParametersInfo( SPI_GETNONCLIENTMETRICS,
                           0,
                           @NonClientMetrics, 0 ) then
  begin
    DeleteObject( Canvas.Font.Handle );
    Canvas.Font.Handle := 0;
  end;
}
  inherited Destroy;
end;

//------------------------------------------------------------------------------

// Override: Change windows class styles to force the needed functionality
procedure TMonthWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_BORDER;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    ExStyle := WS_EX_TOOLWINDOW;
  end;
end;

//------------------------------------------------------------------------------

// Helper: Returns the area of one single line in a rect structure
function TMonthWindow.GetLineRect(ALine: Integer): TRect;
begin
  Result := Bounds(0, (FLineHeight * ALine) - 1, ClientWidth, FLineHeight);
end;

//------------------------------------------------------------------------------

// Helper: Assembles a string from a given date plus offset
function TMonthWindow.GetMonthLabel( AOffset: Integer ): String;
var
  TempDate: TDateTime;
begin
  TempDate := IncMonth( FDate, AOffset );
  Result := LongMonthNames[ DateDetail( TempDate, ddMonth ) ] + ' ' +
    IntToStr( DateDetail( TempDate, ddYear ));
end;

//------------------------------------------------------------------------------

// Helper: Converts mouse position into line number (-1 if not possible)
function TMonthWindow.GetMouseLine(X, Y: Integer): Integer;
begin
  Result := -1;
  // check horizontal position
  if (X < Left) or (X > (Left + Width)) then Exit;
  // check vertical position
  if (Y < Top) or (Y > (Top + Height)) then Exit;
  // still here, then calculate line number
  Result := (Y - Top) div FLineHeight;
  {if ((Y - Top) mod FLineHeight) <> 0 then Inc(Result); ???}
end;

//------------------------------------------------------------------------------

// Property Function: Calculate date internally from different informations
function TMonthWindow.GetSelectedDate: TDateTime;
begin
  Result := IncMonth( FDate, FSelectedLine - 3 );
end;

//------------------------------------------------------------------------------

// Method: Hide window as far as it is visible
procedure TMonthWindow.HideWindow;
begin
  if IsActive then
    ShowWindow( Handle, SW_HIDE );
end;

//------------------------------------------------------------------------------

// Method: Retrieves the mode of the window for calling party
function TMonthWindow.IsActive: Boolean;
begin
  Result := HandleAllocated and IsWindowVisible( Handle );
end;

//------------------------------------------------------------------------------

// Method: Set size of window and display it
procedure TMonthWindow.OpenWindow( Rect: TRect );
begin
  Canvas.Font := Font;
  FLineHeight := Rect.Bottom - Rect.Top;
  InflateRect( Rect, 0, 3 * FLineHeight );
  UpdateBoundsRect( Rect );
  if Rect.Top + Height > Screen.Height then
    Rect.Top := Screen.Height - Height;
  if Rect.Left + Width > Screen.Width then
    Rect.Left := Screen.Width - Width;
  if Rect.Left < 0 then
    Rect.Left := 0;
  if Rect.Top < 0 then
    Rect.Top := 0;
  SetWindowPos( Handle,
                HWND_TOPMOST,
                Rect.Left,
                Rect.Top,
                Width,
                Height,
                SWP_SHOWWINDOW or SWP_NOACTIVATE );
  Invalidate;
end;

//------------------------------------------------------------------------------

// Override: Paint list of months and years manually including focus rectangle
procedure TMonthWindow.Paint;
var
  rText: TRect;
  sDate: String;
  nLine: Integer;
begin
  with Canvas do
  begin
    for nLine := 0 to 6 do
    begin
      rText := GetLineRect( nLine );
      if nLine = FSelectedLine then // paint selected line in inverted colors
      begin
        Brush.Style := bsSolid;
        Brush.Color := clBlack;
        Font.Color := clWhite;
        FillRect(rText);
      end
      else
      begin             // paint normal line
        Brush.Style := bsClear;
        Font.Color := clBlack;
      end;
      sDate := GetMonthLabel( nLine - 3 ); // convert to offset
      DrawText( Handle,
                PChar( sDate ),
                Length( sDate ),
                rText,
                DT_SINGLELINE or DT_CENTER or DT_VCENTER );
    end;
  end;
end;

//------------------------------------------------------------------------------

// Method: Handles mouse movements sent from parent window
procedure TMonthWindow.ProcessMouseMove(Shift: TShiftState; X, Y: Integer);
var
  nOldLine: Integer;
begin

  if ( Y >= Top ) and ( Y <= ( Top + Height )) then
    FTimer.Enabled := False;

  // check if line has changed and repaint in this case only
  nOldLine := FSelectedLine;
  FSelectedLine := GetMouseLine( X, Y );
  if nOldLine <> FSelectedLine then
    Invalidate;

  // mouse is above window
  if Y < Top then
  begin
    FDirection := -1;
    // check where mouse is and vary speed of scrolling
    if Y < (Top - OFF_LIST_SLOW * 3) then
      FTimer.Interval := TIM_SCROLL
    else
    if Y < (Top - OFF_LIST_SLOW * 2) then
      FTimer.Interval := TIM_SCROLL * 3
    else
    if Y < (Top - OFF_LIST_SLOW) then
      FTimer.Interval := TIM_SCROLL * 5
    else
      FTimer.Interval := TIM_SCROLL * 8;
    FTimer.Enabled := True;
  end
  else
  // mouse is below window
  if Y > ( Top + Height ) then
  begin
    FDirection := 1;
    // check where mouse is and vary speed of scrolling
    if (Y > ((Top + Height) + OFF_LIST_SLOW * 3)) then
      FTimer.Interval := TIM_SCROLL
    else
    if (Y > ((Top + Height) + OFF_LIST_SLOW * 2)) then
      FTimer.Interval := TIM_SCROLL * 3
    else
    if (Y > ((Top + Height) + OFF_LIST_SLOW)) then
      FTimer.Interval := TIM_SCROLL * 5
    else
      FTimer.Interval := TIM_SCROLL * 8;
    FTimer.Enabled := True;
  end
  else
    FDirection := 0;
end;

//------------------------------------------------------------------------------

// Eventhandler: Timer for list expired, so scroll list accordingly
procedure TMonthWindow.ScrollTimer( Sender: TObject );
begin
  FDate := IncMonth( FDate, FDirection );
  Invalidate;
end;

//------------------------------------------------------------------------------

// Messagehandler: Make window untouchable to mouse messages
procedure TMonthWindow.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

//------------------------------------------------------------------------------

// Messagehandler: Paint border in non-client area with API functions
procedure TMonthWindow.WMNCPaint(var Message: TMessage);
var
  DC: HDC;
  R: TRect;
begin
  DC := GetWindowDC(Handle);
  try
    R := Rect( 0, 0, Width, Height );
    FrameRect( DC, R, GetStockObject( BLACK_BRUSH ));
  finally
    ReleaseDC( Handle, DC );
  end;
end;

//==============================================================================

// Override: Set defaults and create controls
constructor TDatePick.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csFixedHeight, csFixedWidth, csClickEvents{,csCaptureMouse}];
  ControlStyle := ControlStyle + [ csReplicatable ];
  Ctl3D := False;
  Color := clWhite;

  FNormalCellLineColor := clDkGray;
  FSelectedCellColor := clSilver;
  FSelectedCellFontColor := clWhite;
  FNormalCellColor := clWhite;
  FDifMonthFontColor := clDkGray;
  FNormalCellFontColor := clBlack;
  FTodayCellColor := clMaroon;
  FTopPanelColor := clSilver; //GK 2002-05-03
  FTopPanelFontColor := clBlack; //GK 2002-05-03
  FArrowColor := clBlack; //GK 2002-05-03

  FDayOfWeekStrLen := 1;

  BevelOuter := bvNone;
  BevelInner := bvNone;
  FDate := SysUtils.Date;
  FOptions := [ doClearButton, doTodayButton, doShowOverlap ];

  // force painting on memory DC to avoid flicker
{$IFDEF IBO_VCL40_OR_GREATER}
  DoubleBuffered := True;
{$ENDIF}

  // create timer object
  FTimer := TTimer.Create(Self);
  FTimer.Enabled := False;
  FTimer.OnTimer := ArrowTimer;
  // create month list window
  FMonthWindow := TMonthWindow.Create(Self);
  // allow creation of window
  FHidden := False;
  FIncCellHeight := INC_CELL_HEIGHT;
  FIncCellWidth  := INC_CELL_WIDTH;
  FDrawYearArrow := false;
end;

//------------------------------------------------------------------------------

// Override: Free subcontrols and resources
destructor TDatePick.Destroy;
begin
  inherited Destroy;
end;

//------------------------------------------------------------------------------

procedure TDatePick.SetIncCellHeight(AValue: Integer); //ML 2001-03-23
begin
  if AValue <> FIncCellHeight then
  begin
    FIncCellHeight := AValue;
    if not HandleAllocated then Exit;
    AdjustBounds;
    AdjustButtons;
  end;
end;

procedure TDatePick.SetIncCellWidth(AValue: Integer); //ML 2001-03-23
begin
  if AValue <> FIncCellWidth then
  begin
    FIncCellWidth := AValue;
    if not HandleAllocated then Exit;
    AdjustBounds;
    AdjustButtons;
    Invalidate;
  end;
end;

procedure TDatePick.SetDrawYearArrow(AValue: boolean); //ML 2001-03-23
begin
  if AValue <> FDrawYearArrow then
  begin
    FDrawYearArrow := AValue;
    if not HandleAllocated then Exit;
    AdjustBounds;
    AdjustButtons;
    Invalidate;
  end;
end;

procedure TDatePick.SetDayOfWeekStrLen( AValue: integer );
begin
  if AValue < 1 then AValue := 1;
  if AValue > 3 then AValue := 3;
  if AValue <> DayOfWeekStrLen then
  begin
    FDayOfWeekStrLen := AValue;
    AdjustBounds;
  end;
end;

// Helper: Adjust size of panel to current font
procedure TDatePick.AdjustBounds;
var
  nBtnHgt, i: Integer;
begin
  // set font and calc required sizes
  Canvas.Font := Font;
  FFontHeight := Canvas.TextHeight('99');
//  FCellWidth := Canvas.TextWidth('99') + INC_CELL_WIDTH * 2;
  // was FIncCellWidth * 2. Now * 6 to better accommodate bold fonts and week number and 3 letters days
  FCellWidth := Canvas.TextWidth('W9') + FIncCellWidth * 2 * DayOfWeekStrLen;
  // ML 2001-03-23 // MM 2002_02_28

//  FCellHeight := FFontHeight + INC_CELL_HEIGHT * 2;
  FCellHeight := FFontHeight + FIncCellHeight * 2; //ML 2001-03-23

  // calc font size of header font  // MM 2002/02/28
  for i := 1 to 7 do
    while ( Canvas.TextWidth( Copy( ShortDayNames[i],
                                    1,
                                    DayOfWeekStrLen)) >
            ( FCellWidth - (FIncCellWidth*2)) ) and ( Canvas.Font.Size > 4 ) do
      Canvas.Font.Size := Canvas.Font.Size - 1;
  FHeaderFontSize := Canvas.Font.Size;
  Canvas.Font := Font;

  // gap between cell grid and border (left & right)
  FBorderGap := Round(FCellWidth * 1.5) div 2;
  // overall height of top panel
  FPanelHeight := FFontHeight + INC_PANEL_TOP;
  // 4 = width of border (left & top) & 3 = space for dividing line
  FCellGrid := Bounds(4 + FBorderGap, 4 + FPanelHeight + FCellHeight + 3,
    7 * FCellWidth, 6 * FCellHeight);
  // calc font size of week number font
  while (Canvas.TextWidth('52') > FBorderGap - 3) and (Canvas.Font.Size > 4) do
    Canvas.Font.Size := Canvas.Font.Size - 1;
  FWeekNumFontSize := Canvas.Font.Size;
  Canvas.Font := Font;
  // increment overall size if at least one button is visible
  if (FOptions * [doTodayButton, doClearButton]) <> []
  then nBtnHgt := FFontHeight + INC_BUTTON_HEIGHT + INC_FORM_BUTTON
  else nBtnHgt := 0;
  // calculate new size
  Width := (2 * 4) +            // fixed border width left and right
    (7 * FCellWidth) +          // text which should fit = 7 cols
    (FBorderGap * 2);           // gap between cells and border
  Height := (2 * 4) +           // fixed border width left and right
    (FPanelHeight) +            // height of top panel
    (7 * FCellHeight) +         // six day rows and one header = 7
    (2 * 3) +                   // space for two lines top and bottom
    nBtnHgt +                   // heigth of buttons
    INC_FORM_BOTTOM;            // gap at the bottom of form
end;

//------------------------------------------------------------------------------

// Helper: Switch visibility and position of buttons according to options
procedure TDatePick.AdjustButtons;
var
  nOff: Integer;

  // local helper: switch runtime and designtime visibility
  procedure SetButton(AOption: TDatePickOption; AButton: TDatePickButton);
  begin
    with AButton do
    begin
      if (AOption in FOptions)
      then ControlStyle := ControlStyle - [csNoDesignVisible]
      else ControlStyle := ControlStyle + [csNoDesignVisible];
      Visible := (AOption in FOptions);
      // adjust size and position
      Canvas.Font := Font; // MM 2002/03/13 bis
      Top := GetCellRect(0, 5).Bottom + 3 + INC_FORM_BOTTOM;
      Width := Canvas.TextWidth(Caption) + INC_BUTTON_WIDTH;
      Height := Canvas.TextHeight(Caption) + INC_BUTTON_HEIGHT;
    end;
  end;

begin
  // switch visibility, check size and top position
  SetButton(doClearButton, FButtonClear);
  SetButton(doTodayButton, FButtonToday);
  // change position
  if FButtonClear.Visible and FButtonToday.Visible
  then begin
    nOff := ((Width - FButtonClear.Width) - FButtonToday.Width) div 3;
    FButtonClear.Left := (nOff * 2) + FButtonToday.Width;
    FButtonToday.Left := nOff;
  end
  else if FButtonClear.Visible
       then FButtonClear.Left := (Width - FButtonClear.Width) div 2
       else if FButtonToday.Visible
            then FButtonToday.Left := (Width - FButtonToday.Width) div 2;
end;

//------------------------------------------------------------------------------

// Eventhandler: Timer for arrow buttons expired, so change something
procedure TDatePick.ArrowTimer(Sender: TObject);
const
  Increment: array[Boolean] of Integer = (1, -1);
  YIncrement: array[Boolean] of Integer = (12, -12);
var
  ptMouse: TPoint;
begin
  GetCursorPos( ptMouse );
  ptMouse := ScreenToClient( ptMouse );
  if PtInRect(GetArrowRect(FLeftArrow), ptMouse) then
  begin
    FDate := IncMonth(FDate, Increment[FLeftArrow]);
    Invalidate;
  end;
  if FDrawYearArrow and
     PtInRect( GetArrow2Rect( FLeftArrow ), ptMouse ) then //ML 2001-03-23
  begin
    FDate := IncMonth( FDate, YIncrement[FLeftArrow] );
    Invalidate;
  end;
  FTimer.Interval := TIM_NEXT;
end;

//------------------------------------------------------------------------------

// Eventhandler: Handles the clicks of the Today and Clear button
procedure TDatePick.BtnClick(Sender: TObject);
var
  Result: TDatePickResult;
begin
  Result := dpOK;
  if Sender = FButtonToday then
    FDate := SysUtils.Date;
  if Sender = FButtonClear then
    Result := dpClear;
  Invalidate;
  DoChange( Result );
end;

// AF 2000-08-16
procedure TDatePick.TodayClick;
begin
 FDate := SysUtils.Date;
 Invalidate;
 DoChange(dpOK);
end;

//------------------------------------------------------------------------------

// Messagehandler: After font has changed, adjust panel to new font
procedure TDatePick.CMFontChanged(var Message: TMessage);
begin
  inherited;
  // if hidden and therefore no handle then exit
  if not HandleAllocated then Exit;
  AdjustBounds;
  AdjustButtons;
end;

//------------------------------------------------------------------------------

// Messagehandler: Catch VCL message sent to window with active mouse capture
procedure TDatePick.CNKeyDown(var Message: TWMKeyDown);
//MODIFIED// CW 2000-04-20
begin
  ProcessKeyDown(Message);
end;
//ENDMODIFIED//

//------------------------------------------------------------------------------

// Method: Process a keydown message (called by parent control)
procedure TDatePick.ProcessKeyDown(var Message: TWMKeyDown);
  function StartOfMonth(const Date: TDateTime): TDateTime;
  var
    TmpYear, TmpMonth, TmpDay: Word;
  begin
    DecodeDate(Date, TmpYear, TmpMonth, TmpDay);
    Result := EncodeDate(TmpYear, TmpMonth, 1) + Frac(Date);
  end;
  function Month1(const Date: TDateTime): TDateTime;
  var
    TmpYear, TmpMonth, TmpDay: Word;
  begin
    // note: always 31 days in january, so can just set the month here
    DecodeDate(Date, TmpYear, TmpMonth, TmpDay);
    Result := EncodeDate(TmpYear, 1, TmpDay) + Frac(Date);
  end;
  function Month12(const Date: TDateTime): TDateTime;
  var
    TmpYear, TmpMonth, TmpDay: Word;
  begin
    DecodeDate(Date, TmpYear, TmpMonth, TmpDay);
    // note: always 31 days in december, so can just set the month here
    Result := EncodeDate(TmpYear, 12, TmpDay) + Frac(Date);
  end;
var
  ShiftState: TShiftState;
begin
  with Message do
  begin
    ShiftState := KeyDataToShiftState(KeyData);
    if IsActive then
    begin
      if (CharCode = VK_TAB) and
          ((ShiftState = []) or (ShiftState = [ssShift])) then
      begin
        DoChange(dpOK);  //TODO// cw -- make it go to next control
        Exit;  // allow futher processing of this message
      end;
      if ShiftState = [] then
      begin
        case CharCode of
          VK_ESCAPE: HideCalendar;
          VK_DELETE: DoChange(dpClear);
          VK_RETURN: DoChange(dpOK);
          VK_SPACE: FDate := SysUtils.Date;
          VK_LEFT, VK_SUBTRACT:  FDate := FDate - 1;
          VK_RIGHT, VK_ADD: FDate := FDate + 1;
          VK_UP:    FDate := FDate - 7;
          VK_DOWN:  FDate := FDate + 7;
          VK_PRIOR: FDate := IncMonth(FDate, -1);
          VK_NEXT:  FDate := IncMonth(FDate,  1);
          VK_HOME:  FDate := StartOfMonth(FDate);
          VK_END:   FDate := IncMonth(StartOfMonth(FDate), 1) - 1;
          else CharCode := 0;
        end;
      end
      else
      if ShiftState = [ssCtrl] then
      begin
        case CharCode of
          VK_DELETE: DoChange(dpClear);
          VK_RETURN: DoChange(dpOK);
          VK_SPACE:
          begin
            FDate := SysUtils.Date;
            DoChange(dpOK);
          end;
          VK_LEFT:  FDate := IncMonth(FDate, -1);
          VK_RIGHT: FDate := IncMonth(FDate,  1);
          VK_UP:    FDate := IncMonth(FDate, -12);
          VK_DOWN:  FDate := IncMonth(FDate,  12);
          VK_PRIOR: FDate := IncMonth(FDate, -12);
          VK_NEXT:  FDate := IncMonth(FDate,  12);
          VK_HOME:  FDate := Month1(FDate);
          VK_END:   FDate := Month12(FDate);
          else CharCode := 0;
        end;
      end
      else
      begin
        CharCode := 0;
      end;
      if CharCode <> 0 then Invalidate;
      CharCode := 0;
      Result := 1;
    end
    else
    begin  //...not active
      if ShiftState = [ssCtrl] then
      begin
        case CharCode of
          VK_SPACE:
          begin
            FDate := SysUtils.Date;
            DoChange(dpOK);
            CharCode := 0;
            Result := 1;
          end;
          VK_DELETE:
          begin
            DoChange(dpClear);
            CharCode := 0;
            Result := 1;
          end;
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

// Method: Create buttons according to options
procedure TDatePick.CreateButtons;
begin
  if not Assigned(FButtonClear) then begin
    FButtonClear := TDatePickButton.Create(Self);
    with FButtonClear do begin
      Parent := Self;
      Visible := False;
      if ClearButtonCaption <> '' then begin
        Caption := ClearButtonCaption;
      end else begin
        Caption := C_BTN_CLEAR;
      end;
      Layout := blGlyphBottom; // for better alignment of text (1 pixel upwards)
      OnClick := BtnClick;
    end;
  end;
  if not Assigned(FButtonToday) then begin
    FButtonToday := TDatePickButton.Create(Self);
    with FButtonToday do begin
      Parent := Self;
      Visible := False;
      if TodayButtonCaption <> '' then begin
        Caption := TodayButtonCaption;
      end else begin
        Caption := C_BTN_TODAY;
      end;
      Layout := blGlyphBottom; // for better alignment of text (1 pixel upwards)
      OnClick := BtnClick;
    end;
  end;
end;

//------------------------------------------------------------------------------

// Override: Change windows class styles to force the needed functionality
procedure TDatePick.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := WS_CHILD;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    ExStyle := WS_EX_TOOLWINDOW;
  end;
end;

//------------------------------------------------------------------------------

// Override: After handle is valid create buttons
procedure TDatePick.CreateWnd;
begin
  if FHidden then Exit;
  if not Assigned( Parent ) then begin
    Windows.SetParent( Handle, 0 );
  end else begin
    inherited CreateWnd;
    // make desktop the current parent if control was created dynamically
    if not FWasLoaded and not ( csDesigning in ComponentState ) then begin
      Windows.SetParent(Handle, 0);
    end;
    // call method to create buttons
    CreateButtons;
    AdjustBounds;
    AdjustButtons;
  end;
end;

//------------------------------------------------------------------------------

// Method: Triggers the eventhandler if present
procedure TDatePick.DoChange(Value: TDatePickResult);
begin
  if Assigned(FOnChange) then
   FOnChange(Self, Value);
end;

procedure TDatePick.DoStrike(CheckThisDate : TDateTime; var CrossColor : TColor);
begin
  if Assigned( FOnStrike ) then
   FOnStrike( Self, CheckThisDate, CrossColor );
end;

//------------------------------------------------------------------------------

// Helper: Returns the rect of the left or right arrow
function TDatePick.GetArrowRect(ALeft: Boolean): TRect;
var
  nHgt, nWdt: Integer;
begin
  // calc height, '-2' is for the inner border of the panel (see Paint)
  nHgt := (FPanelHeight - 2) - DEC_ARROW_SIZE * 2;
  nWdt := (nHgt div 2) + INC_ARROW_BORDER * 2;
  if ALeft
  then Result := Bounds(4, 4, nWdt, FPanelHeight - 2)
  else Result := Bounds((Width - 4) - nWdt, 4, nWdt, FPanelHeight - 2);
end;

// Helper: Returns the rect of the left or right arrow
function TDatePick.GetArrow2Rect(ALeft: Boolean): TRect; //ML 2001-03-23
var
  nHgt, nWdt: Integer;
begin
  // calc height, '-2' is for the inner border of the panel (see Paint)
  nHgt := (FPanelHeight - 2) - DEC_ARROW_SIZE * 2;
  nWdt := (nHgt div 2) + INC_ARROW_BORDER * 2;
  if ALeft
  then Result := Bounds( INC_ARROWY_BORDER, 4, nWdt, FPanelHeight - 2 )
  else Result := Bounds(( Width - INC_ARROWY_BORDER ) - nWdt,
                          4,
                          nWdt,
                          FPanelHeight - 2 );
end;

//------------------------------------------------------------------------------

// Helper: Tries to convert position into actual cell, returns success state
function TDatePick.GetCellFromPos(X, Y: Integer; var Cell: TPoint): Boolean;
begin
  Result := False;
  // check if mouse is in cell grid at all, otherwise leave here
  if not PtInRect(FCellGrid, Point(X, Y)) then Exit;
  // make zero based coordinates to allow calculation
  Dec(X, FCellGrid.Left);
  Dec(Y, FCellGrid.Top);
  Cell.X := X div FCellWidth;
  Cell.Y := Y div FCellHeight;
  Result := True;
end;

//------------------------------------------------------------------------------

// Helper: Returns a rect structure for requested cell
function TDatePick.GetCellRect( ACol, ARow: Integer ): TRect;
begin
  // 4 = width of border (left & top)
  Result := Bounds(4, 4, FCellWidth, FCellHeight);
  OffsetRect(Result, FBorderGap + (ACol * FCellWidth),
    // 3 = space for dividing line
    FPanelHeight + FCellHeight + 3 + (ARow * FCellHeight));
end;

//------------------------------------------------------------------------------

// Helper: Returns a rect structure for requested cell
function TDatePick.GetHeaderRect(ACol: Integer): TRect;
begin
  // 4 = width of border (left & top)
  Result := Bounds(4, 4 + FPanelHeight, FCellWidth, FCellHeight);
  OffsetRect(Result, FBorderGap + (ACol * FCellWidth), 0);
end;

//------------------------------------------------------------------------------

// Helper: Returns area of month label inside top panel
function TDatePick.GetMonthLabelRect: TRect;
var
  rArrow: TRect;
begin
  rArrow := GetArrowRect(True);
  // 4 = width of border (left & top)
  Result := Bounds(4, 4, Width - 8, FFontHeight + INC_PANEL_TOP);
  // subtract arrow areas left and right and line width top and bottom
  InflateRect(Result, rArrow.Left - rArrow.Right, -1);
end;

//------------------------------------------------------------------------------

// Property Function: Retrieve a part of the current date
function TDatePick.GetPartOfDate(Index: Integer): Word;
const
  WhatPart: array[1..3] of TDateDetail = (ddDay, ddMonth, ddYear);
begin
  Result := DateDetail(FDate, WhatPart[Index]);
end;

//------------------------------------------------------------------------------

// Method: Hide DatePick window control
procedure TDatePick.HideCalendar;
begin
  //ADDED// CW 2000-04-19
  // hide FMonthWindow first
  FMonthWindow.HideWindow;
  //ENDADDED//

  if HandleAllocated and IsWindowVisible(Handle) and not FWasLoaded then
  begin
    DestroyHandle; // to save resources with multiple instances
    FHidden := True;
    MouseCapture := False; // call here to prevent second call of this method
  end;
end;

//------------------------------------------------------------------------------

// Method: Retrieves the mode of the window for calling party
function TDatePick.IsActive: Boolean;
begin
  Result := HandleAllocated and IsWindowVisible( Handle );
end;

//------------------------------------------------------------------------------

// Override: Call helper to adjust size of panel
procedure TDatePick.Loaded;
begin
  inherited Loaded;
  // set marker that control was on form since designtime
  FWasLoaded := True;
  // if hidden and therefore no handle then exit
  if not HandleAllocated then Exit;
  AdjustBounds;
  AdjustButtons;
end;

//------------------------------------------------------------------------------

// Override: Mouse was pressed, find area and respond to it
procedure TDatePick.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  rWin: TRect;
  ptTopLeft: TPoint;
  bSelect: Boolean;
  function ButtonClick( AOption: TDatePickOption;
                        AButton: TDatePickButton ): boolean;
  var
    BtnX, BtnY: Integer;
  begin
    Result := False;
    if (AOption in FOptions) and
       PtInRect(AButton.BoundsRect, Point(X, Y)) then begin
      BtnX := X - AButton.Left;
      BtnY := Y - AButton.Top;
      AButton.MouseDown(Button, Shift, BtnX, BtnY);
      // mark button as pressed one
      AButton.Tag := 1;
      Result := True;
    end;
  end;

begin
  inherited MouseDown(Button, Shift, X, Y);
  FTimer.Interval := TIM_FIRST;
  // check if previous month (left) arrow was clicked
  if PtInRect(GetArrowRect(True), Point(X, Y)) then
  begin
    FDate := IncMonth(FDate, -1);
    Invalidate;
    FLeftArrow := True;
    FTimer.Enabled := True;
    if FChangeOnMonthClick then // AF 2000-08-16
     DoChange(dpOK);
    Exit;
  end;
  // check if next month (right) arrow was clicked
  if PtInRect(GetArrowRect(False), Point(X, Y)) then
  begin
    FDate := IncMonth(FDate, 1);
    Invalidate;
    FLeftArrow := False;
    FTimer.Enabled := True;
    if FChangeOnMonthClick then // AF 2000-08-16
     DoChange(dpOK);
    Exit;
  end;
  // check if previous year (left) arrow was clicked
  //ML 2001-03-23
  if FDrawYearArrow And PtInRect(GetArrow2Rect(True), Point(X, Y)) then
  begin
    FDate := IncMonth(FDate, -12);
    Invalidate;
    FLeftArrow := True;
    FTimer.Enabled := True;
    if FChangeOnMonthClick then // AF 2000-08-16
      DoChange(dpOK);
    Exit;
  end;
  // check if next year (right) arrow was clicked
  //ML 2001-03-23
  if FDrawYearArrow And PtInRect(GetArrow2Rect(False), Point(X, Y)) then
  begin
    FDate := IncMonth(FDate, 12);
    Invalidate;
    FLeftArrow := False;
    FTimer.Enabled := True;
    if FChangeOnMonthClick then // AF 2000-08-16
      DoChange(dpOK);
    Exit;
  end;

  // check if month label inside top panel was clicked
  rWin := GetMonthLabelRect;
  if PtInRect(rWin, Point(X, Y)) then
  begin
    // translate local points to screen points because it is a separate window
    if FWasLoaded then
      ptTopLeft := Parent.ClientToScreen(Point(Left, Top))
    else
      ptTopLeft := Point(Left, Top);
    OffsetRect(rWin, ptTopLeft.X, ptTopLeft.Y);
    FMonthWindow.Date := FDate;
    FMonthWindow.Font := Font;
    FMonthWindow.OpenWindow(rWin);
    FMouseDown := True;
    Exit;
  end;
  // check if button was pressed, handle it over because of mouse capture
  if ButtonClick(doClearButton, FButtonClear) then Exit;
  if ButtonClick(doTodayButton, FButtonToday) then Exit;
  // check if user clicked within client area, if not close calendar
  bSelect := SelectCell(X, Y);
  FMouseDown := ((Shift * [ssLeft, ssRight]) <> []) and bSelect;
  if not bSelect and not PtInRect(ClientRect, Point(X, Y)) then
    HideCalendar;
end;

//------------------------------------------------------------------------------

// Override: Change selection of day or call month list window
procedure TDatePick.MouseMove(Shift: TShiftState; X, Y: Integer);

  function ButtonMove(AOption: TDatePickOption;
    AButton: TDatePickButton): Boolean;
  var
    BtnX, BtnY: Integer;
  begin
    Result := False;
    if ( AOption in FOptions ) and ( AButton.Tag > 0 ) then
    begin
      BtnX := X - AButton.Left;
      BtnY := Y - AButton.Top;
      AButton.MouseMove( Shift, BtnX, BtnY );
      Result := True;
    end;
  end;

var
  ptPos: TPoint;
begin
  inherited MouseMove( Shift, X, Y );
  // check if at least one mouse button is pressed, otherwise exit here
  if ((Shift * [ssLeft, ssRight]) = []) then Exit;
  // check if button was pressed, handle it over because of mouse capture
  if ButtonMove(doClearButton, FButtonClear) then Exit;
  if ButtonMove(doTodayButton, FButtonToday) then Exit;
  // get real mouse position for windows coordinates
  if not FMouseDown then Exit;
  // is secondary list window active?
  if FMonthWindow.IsActive then
  begin
    GetCursorPos( ptPos );
    FMonthWindow.ProcessMouseMove( Shift, ptPos.X, ptPos.Y );
  end
  else
  begin
    if not SelectCell(X, Y) then // check if mouse is over cell
      if not PtInRect(ClientRect, Point(X, Y)) and (FSelectedDate <> FDate) then
        begin  // otherwise select initial date and redraw screen
          FSelectedDate := FDate;
          Invalidate;
        end;
  end;
end;

//------------------------------------------------------------------------------

// Override: After user releases the button respond to it
procedure TDatePick.MouseUp( Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer );
var
  ptCell: TPoint;
  bMouseDown: Boolean;
  function ButtonUp( AOption: TDatePickOption;
                     AButton: TDatePickButton ): Boolean;
  var
    BtnX, BtnY: Integer;
  begin
    Result := False;
    if (AOption in FOptions) and (AButton.Tag > 0) then
    begin
      BtnX := X - AButton.Left;
      BtnY := Y - AButton.Top;
      AButton.MouseUp(Button, Shift, BtnX, BtnY);
      AButton.Tag := 0;
      Result := True;
    end;
  end;

begin
  inherited MouseUp(Button, Shift, X, Y);
  bMouseDown := FMouseDown;
  FMouseDown := False;
  FTimer.Enabled := False;
  // if list window is open, close it and eventually set date
  if FMonthWindow.IsActive then
  begin
    if FMonthWindow.SelectedLine <> -1 then
      FDate := FMonthWindow.SelectedDate;
    FMonthWindow.HideWindow;
    Invalidate;
    Exit;
  end;

  // check if button was pressed, handle it over because of mouse capture
  if ButtonUp(doClearButton, FButtonClear) then Exit;
  if ButtonUp(doTodayButton, FButtonToday) then Exit;
  // first check if one arrow button was pressed, if so then do nothing here
  if not PtInRect(GetArrowRect(True),  Point(X, Y)) and
     not PtInRect(GetArrowRect(False), Point(X, Y)) and bMouseDown then
  begin
    // mouse was somewhere else, hence select date and fire user event
    FDate := FSelectedDate;
    Invalidate;
    if GetCellFromPos( X, Y, ptCell ) then
      DoChange( dpOK );
  end;
end;

//------------------------------------------------------------------------------

// Override: Use Paint method to draw all required parts of DatePick
procedure TDatePick.Paint;
var
  rFill: TRect;
  sDate: String;

  procedure PaintBorder;
  begin
    // paint border lines
    Frame3D(Canvas, rFill, TColor($00E6E6E6), clBlack, 1);
    Frame3D(Canvas, rFill, clWhite, clDkGray, 1);
    Frame3D(Canvas, rFill, clSilver, clSilver, 1);
    Frame3D(Canvas, rFill, clDkGray, clWhite, 1);
    rFill.Bottom := rFill.Top + FFontHeight + INC_PANEL_TOP;
    Frame3D(Canvas, rFill, clWhite, clDkGray, 1);
  end;

  procedure PaintTopPanel;
  var tmpColor: TColor;
  begin
    with Canvas, rFill do begin
      // fill top panel
      Brush.Color := TopPanelColor; //GK 2002-05-03
      tmpColor:=Font.Color;          //GK 2002-05-03
      Font.Color:=TopPanelFontColor;//GK 2002-05-03

      FillRect(rFill);
      // print out month and year in top panel
      Brush.Style := bsClear;
      sDate := LongMonthNames[Month] + ' ' + IntToStr(Year);
      DrawText(Handle, PChar(sDate), Length(sDate), rFill,
        DT_SINGLELINE or DT_CENTER or DT_VCENTER);
      Font.Color:=tmpColor;  //GK 2002-05-03
    end;
  end;

  procedure PaintArrows;
  var
    nHgt: Integer;
    nWdt: Integer; //ML 2001-03-23
  begin
    // calculate height of arrows
    nHgt := (rFill.Bottom - rFill.Top) - DEC_ARROW_SIZE * 2;
    // make odd number to make arrow even
    if (nHgt mod 2) = 0 then Dec(nHgt);
    nWdt := nHgt div 2;

    with Canvas, rFill do begin
      // draw arrows
      Brush.Color := ArrowColor; //GK 2002-05-03
      Brush.Style := bsSolid;
      Pen.Color := ArrowColor; //GK 2002-05-03
      Polygon([
        Point(Left + INC_ARROW_BORDER, Top + DEC_ARROW_SIZE + (nHgt div 2)),
        Point(Left + INC_ARROW_BORDER + (nHgt div 2), Top + DEC_ARROW_SIZE),
        Point(Left + INC_ARROW_BORDER + (nHgt div 2),
          Top + DEC_ARROW_SIZE + nHgt - 1)]);
      Polygon([
        Point(Right - INC_ARROW_BORDER, Top + DEC_ARROW_SIZE + (nHgt div 2)),
        Point((Right - INC_ARROW_BORDER) - (nHgt div 2), Top + DEC_ARROW_SIZE),
        Point((Right - INC_ARROW_BORDER) - (nHgt div 2),
          Top + DEC_ARROW_SIZE + nHgt - 1)]);

      if FDrawYearArrow then
      begin
        Polygon([
          Point(Left + INC_ARROWY_BORDER, Top + DEC_ARROW_SIZE + nWdt),
          Point(Left + INC_ARROWY_BORDER + nWdt, Top + DEC_ARROW_SIZE),
          Point(Left + INC_ARROWY_BORDER + nWdt,
            Top + DEC_ARROW_SIZE + nHgt - 1)]);
        Polygon([
          Point(Right - INC_ARROWY_BORDER, Top + DEC_ARROW_SIZE + nWdt),
          Point((Right - INC_ARROWY_BORDER) - nWdt, Top + DEC_ARROW_SIZE),
          Point((Right - INC_ARROWY_BORDER) - nWdt,
            Top + DEC_ARROW_SIZE + nHgt - 1)]);

        Polygon([
          Point(Left + (INC_ARROWY2_BORDER), Top + DEC_ARROW_SIZE + nWdt),
          Point(Left + (INC_ARROWY2_BORDER) + nWdt, Top + DEC_ARROW_SIZE),
          Point(Left + (INC_ARROWY2_BORDER) + nWdt,
            Top + DEC_ARROW_SIZE + nHgt - 1)]);
        Polygon([
          Point(Right - (INC_ARROWY2_BORDER), Top + DEC_ARROW_SIZE + nWdt),
          Point((Right - (INC_ARROWY2_BORDER)) - nWdt, Top + DEC_ARROW_SIZE),
          Point((Right - (INC_ARROWY2_BORDER)) - nWdt,
            Top + DEC_ARROW_SIZE + nHgt - 1)]);

//      INC_Y_ARROW_BORDER

      end;
    end;
  end;

  procedure PaintHeader;
  var
    nIndex, nOldSize: Integer;
    rText: TRect;
  begin
    with Canvas do
    begin
      nOldSize := Font.Size;
      Font.Size := FHeaderFontSize;
      Brush.Style := bsClear;
      for nIndex := 0 to 6 do
      begin
        // print out first 3 letters of day
        sDate := copy( ShortDayNames[ (Ord(FStartDay) + nIndex + 1) mod 7 + 1 ],
                       1,
                       DayOfWeekStrLen ); // MM 2002/02/28
        rText := GetHeaderRect(nIndex);
//        InflateRect(rText, -INC_CELL_WIDTH, -INC_CELL_HEIGHT);
        InflateRect(rText, -FIncCellWidth, -FIncCellHeight); //ML 2001-03-23
        DrawText(Handle, PChar(sDate), Length(sDate), rText,
          DT_SINGLELINE or DT_RIGHT or DT_VCENTER);
      end;
      Font.Size := nOldSize;
    end;
  end;

  procedure PaintLines;
  var
    rLeft, rRight, rBottomLeft: TRect;
  begin
    with Canvas do
    begin
      Pen.Color := NormalCellLineColor;
      // use helper to get informations about locations
      rLeft := GetHeaderRect(0);
      rRight := GetHeaderRect(6);
      // upper line
      MoveTo(rLeft.Left, rLeft.Bottom + 1);
      LineTo(rRight.Right, rRight.Bottom + 1);
      // use helper to get informations about locations, again
      rLeft := GetCellRect(0, 5);
      rRight := GetCellRect(6, 5);
      // lower line
      MoveTo(rLeft.Left, rLeft.Bottom + 1);
      LineTo(rRight.Right, rRight.Bottom + 1);
      // left (if week number) line
      if (doShowWeeks in FOptions) then // MM 2002/02/28
      begin
        rLeft := GetCellRect(0, 0);
        rBottomLeft := GetCellRect(0, 5);
        MoveTo(rLeft.left,rLeft.top);
        LineTo(rBottomLeft.Left,rBottomLeft.Bottom);
      end;
    end;
  end;

  procedure PaintWeeks;
  var
    nIndex, nOldSize: Integer;
    rCell: TRect;
    sWeek: String;
  begin
    // check options first
    if not (doShowWeeks in FOptions) then Exit;
    // otherwise proceed
    nOldSize := Canvas.Font.Size;
    Canvas.Font.Size := FWeekNumFontSize;
    Canvas.Brush.Style := bsClear;
    for nIndex := 0 to 5 do
    begin
      rCell := GetCellRect(0, nIndex);
      rCell.Right := rCell.Left - 2; // move rect
      rCell.Left := 4;   // border width
      Inc(rCell.Top, 2); // fine tuning
      sWeek := IntToStr(WeekNumber(DateFromPos(0, nIndex, Year,
        Month, Ord(FStartDay)), Ord(FStartDay), Ord(FFirstWeek)));
      DrawText(Canvas.Handle, PChar(sWeek), Length(sWeek), rCell,
        DT_SINGLELINE or DT_RIGHT or DT_VCENTER);
    end;
    Canvas.Font.Size := nOldSize;
  end;

  procedure PaintCells;
  CONST
   cHalfBrightness = ((0.3 * 255.0) + (0.59 * 255.0) + (0.11 * 255.0)) / 2.0;
  var
    rCell       : TRect;
    nCol, nRow  : Integer;
    CellDate    : TDateTime;
    CrossColor  : TColor; //AF 2001-04-25
    BrightNess  : double;
  begin
    for nRow := 0 to 5 do
      for nCol := 0 to 6 do
        with Canvas do
        begin
          // get number of day by giving its location in the grid
          CellDate := DateFromPos(nCol, nRow, Year, Month, Ord(FStartDay));
          if IsDifferentMonth(CellDate, FDate) and
            not (doShowOverlap in FOptions) // exit if options not valid
          then Continue;
          sDate := IntToStr(DateDetail(CellDate, ddDay));
          rCell := GetCellRect(nCol, nRow);
          // check if an event is pending, if not fake date here
          if not FMouseDown then FSelectedDate := FDate;

          // MM 2002/02/28
          if ((doBoldSaturday in FOptions) and (DayOfWeek(CellDate) = 7)) or
             ((doBoldSunday in FOptions) and (DayOfWeek(CellDate) = 1)) then
             Font.Style := [fsBold]
          else
            Font.Style := [];

          // set canvas to reflect different days
          if CellDate = FSelectedDate then
          begin
            Brush.Color := SelectedCellColor;
            Brush.Style := bsSolid;
            Font.Color := SelectedCellFontColor; //clWhite;
            FillRect(rCell);
          end
          else
          begin
            Brush.Color := NormalCellColor; //clWhite;
            if IsDifferentMonth( CellDate, FDate ) then
              Font.Color := DifMonthFontColor //clDkGray
            else
              Font.Color := NormalCellFontColor;
            if NormalCellColor <> clWhite then
              FillRect(rCell);
          end;
          // paint frame if date is system date
          if ( CellDate = SysUtils.Date ) and
             not IsDifferentMonth(CellDate, FDate) then
          begin
            Brush.Color := TodayCellColor;
            FrameRect(rCell);
          end;
          // paint number
//          InflateRect(rCell, -INC_CELL_WIDTH, -INC_CELL_HEIGHT);

          CrossColor := clDefault;
          DoStrike( CellDate, CrossColor );
          if ( CrossColor <> clDefault ) then
          begin

           if (CrossColor and cStrikeOption_Cross=cStrikeOption_Cross) then
           begin
            // Style: Cross the number
            pen.color := CrossColor AND $FFFFFF;
            MoveTo(rCell.left,rCell.top);
            LineTo(rCell.Right,rCell.Bottom);
            MoveTo(rCell.right,rCell.top);
            LineTo(rCell.left,rCell.Bottom);
           end
           else
           begin
            // Style: Full Background Fill
            Brush.Color := CrossColor AND $FFFFFF;
            with TRGBQuad(Brush.Color) do
             BrightNess := (0.3 * rgbRed) + (0.59 * rgbGreen) + (0.11 * rgbBlue);
            if (Brightness>cHalfBrightNess) then
             Font.color := clblack
            else
             Font.color := clwhite;
            FillRect(rCell);
           end;

           // Style: Strikeout as a Text-Attribute // MM 2002/03/13
           if (CrossColor and cStrikeOption_FontStrikeOut=cStrikeOption_FontStrikeOut) then
            Font.Style := Font.Style + [fsstrikeOut];
          end;

          InflateRect(rCell, -FIncCellWidth, -FIncCellHeight); //ML 2001-03-23
          Brush.Style := bsClear;
          DrawText(Handle, PChar(sDate), Length(sDate), rCell,
            DT_SINGLELINE or DT_RIGHT or DT_VCENTER);

{
          Attributes to come ...

          // (alternate) only Upper Background
          // (alternate) only Lower Background
}

        end;
  end;

begin
  inherited Paint;
  // paint border lines
  rFill := Rect(0, 0, Width, Height);
  PaintBorder;
  // paint rest, watch out: Sequence is important because of rFill rectangle
  PaintTopPanel;
  PaintArrows;
  PaintHeader;
  PaintLines;
  PaintWeeks;
  PaintCells;
end;

//------------------------------------------------------------------------------

// Method: Try to find a cell and change date to matching cell
function TDatePick.SelectCell(X, Y: Integer): Boolean;
var
  ptCell: TPoint;
  TempDate: TDateTime;
begin
  Result := GetCellFromPos(X, Y, ptCell);
  if Result then
  begin
    TempDate := DateFromPos(ptCell.X, ptCell.Y, Year, Month, Ord(FStartDay));
    if not (doShowOverlap in FOptions) and IsDifferentMonth(FDate, TempDate)
    then Result := False
    else if FSelectedDate <> TempDate
      then begin
        FSelectedDate := TempDate;
        Invalidate;
      end;
  end;
end;

//------------------------------------------------------------------------------

// Property Function: Set caption of button to user defined value
procedure TDatePick.SetClearButtonCaption( AValue: string );
begin
  if FClearButtonCaption <> AValue then
  begin
    FClearButtonCaption := AValue;
    if Assigned( FButtonClear ) then
    begin
      if ClearButtonCaption <> '' then
        FButtonClear.Caption := ClearButtonCaption
      else
        FButtonClear.Caption := C_BTN_CLEAR;
    end;
  end;
end;

//------------------------------------------------------------------------------

// Property Function: Set new first week of year value
procedure TDatePick.SetFirstWeek(const Value: TDatePickFirstWeek);
begin
  if Value <> FFirstWeek then
  begin
    FFirstWeek := Value;
    // if hidden and therefore no handle then exit
    if not HandleAllocated then Exit;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

// Property Function: Set new options and refresh everything
procedure TDatePick.SetOptions(const Value: TDatePickOptions);
begin
  FOptions := Value;
  // if hidden and therefore no handle then exit
  if not HandleAllocated then Exit;
  AdjustBounds;
  AdjustButtons;
  Invalidate;
end;

//------------------------------------------------------------------------------

// Property Function: Set new first day of week, so change all
procedure TDatePick.SetStartDay(const Value: TDatePickStartDay);
begin
  if Value <> FStartDay then
  begin
    FStartDay := Value;
    // if hidden and therefore no handle then exit
    if not HandleAllocated then Exit;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

// Property Function: Set caption of button to user defined value
procedure TDatePick.SetTodayButtonCaption( AValue: string );
begin
  if FTodayButtonCaption <> AValue then
  begin
    FTodayButtonCaption := AValue;
    if Assigned( FButtonToday ) then
    begin
      if TodayButtonCaption <> '' then
        FButtonToday.Caption := TodayButtonCaption
      else
        FButtonToday.Caption := C_BTN_TODAY;
    end;
  end;
end;

//------------------------------------------------------------------------------

// Method: Main method to show the control on screen, Position in screen coords
procedure TDatePick.ShowCalendar( Position: TPoint );
begin
  // set given position
  Left := Position.X;
  Top := Position.Y;
  // now check if everything is visible, otherwise change appropriately
  AdjustBounds; // Luiz Alves added
  if Top + Height > Screen.Height then begin
    //Top := Screen.Height - Height -- original;
    //Luiz Alves add
    if (Parent.ClassName = 'TIB_Date') then
       Top := Top-Parent.Height-Height
    else Top := Screen.Height - Height;
    //end Luiz Alves add
  end;
  if Left + Width > Screen.Width then begin
    //Left := Screen.Width - Width --- original;
    //Luiz Alves add
    if (Parent.ClassName = 'TIB_Date') then
       Left := Left + Parent.Width-Width
    else Left := Screen.Width - Width;
    //end Luiz Alves add
  end;
  if Left < 0 then
    Left := 0;
  if Top < 0 then
    Top := 0;

  FHidden := False;
  SetWindowPos( Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
    SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
  // line above instead of ShowWindow(Handle, SW_SHOWNA);
  MouseCapture := True;
  Visible := true;
end;

//------------------------------------------------------------------------------

// Messagehandler: When application loses focus then close calendar
procedure TDatePick.WMCaptureChanged(var Message: TMessage);
begin
  // Luiz Alves added
  if not ( csDesigning in ComponentState ) then
    HideCalendar;
end;

procedure TDatePick.SetChangeOnMonthClick( AValue: boolean );
begin
 FChangeOnMonthClick := AValue;
end;


//==============================================================================

end.
