/* 
Бібліотека зовнішніх функцій
22.08.1998
*/

/* Blob functions */

declare external function f_BlobMaxSegmentLength
  blob
  returns integer by value
  entry_point "BlobMaxSegmentLength" module_name "FLib.dll";

declare external function f_BlobSegmentCount
  blob
  returns integer by value
  entry_point "BlobSegmentCount" module_name "FLib.dll";

declare external function f_BlobSize
  blob
  returns integer by value
  entry_point "BlobSize" module_name "FLib.dll";

declare external function f_BlobAsPChar
  blob
  returns cstring(1024) /* or 32000 or whatever... */
  entry_point "BlobAsPChar" module_name "FLib.dll";

declare external function f_BlobLeft
  blob, integer
  returns cstring(1024)
  entry_point "BlobLeft" module_name "FLib.dll";

declare external function f_BlobLine
  blob, integer
  returns cstring(1024)
  entry_point "BlobLine" module_name "FLib.dll";

declare external function f_BlobMid
  blob, integer, integer
  returns cstring(1024)
  entry_point "BlobMid" module_name "FLib.dll";

declare external function f_BlobRight
  blob, integer
  returns cstring(1024)
  entry_point "BlobRight" module_name "FLib.dll";

declare external function f_StrBlob
  cstring(254),
  blob
  returns parameter 2
  entry_point "StrBlob" module_name "FLib.dll";

/* Date/Time routines */

declare external function f_AddMonth
  date,
  integer
  returns
  date
  entry_point "AddMonth" module_name "FLib.dll";

declare external function f_AddYear
  date,
  integer
  returns
  date
  entry_point "AddYear" module_name "FLib.dll";

declare external function f_AgeInDays
  date, date
  returns
  integer by value
  entry_point "AgeInDays" module_name "FLib.dll";

declare external function f_AgeInDaysThreshold
  date, date, integer, integer, integer, integer
  returns
  integer by value
  entry_point "AgeInDaysThreshold" module_name "FLib.dll";

declare external function f_AgeInMonths
  date, date
  returns
  integer by value
  entry_point "AgeInMonths" module_name "FLib.dll";

declare external function f_AgeInMonthsThreshold
  date, date, integer, integer, integer, integer
  returns
  integer by value
  entry_point "AgeInMonthsThreshold" module_name "FLib.dll";

declare external function f_AgeInWeeks
  date, date
  returns
  integer by value
  entry_point "AgeInWeeks" module_name "FLib.dll";

declare external function f_AgeInWeeksThreshold
  date, date, integer, integer, integer, integer
  returns
  integer by value
  entry_point "AgeInWeeksThreshold" module_name "FLib.dll";

declare external function f_CDOWLong
  date
  returns cstring(10)
  entry_point "CDOWLong" module_name "FLib.dll";

declare external function f_CDOWShort
  date
  returns cstring(4)
  entry_point "CDOWShort" module_name "FLib.dll";

declare external function f_CMonthLong
  date
  returns cstring(10)
  entry_point "CMonthLong" module_name "FLib.dll";

declare external function f_CMonthShort
  date
  returns cstring(4)
  entry_point "CMonthShort" module_name "FLib.dll";

declare external function f_DayOfMonth
  date
  returns
  integer by value
  entry_point "DayOfMonth" module_name "FLib.dll";

declare external function f_DayOfWeek
  date
  returns
  integer by value
  entry_point "DayOfWeek" module_name "FLib.dll";

declare external function f_DayOfYear
  date
  returns
  integer by value
  entry_point "DayOfYear" module_name "FLib.dll";

declare external function f_Month
  date
  returns
  integer by value
  entry_point "Month" module_name "FLib.dll";

declare external function f_Quarter
  date
  returns
  integer by value
  entry_point "Quarter" module_name "FLib.dll";

declare external function f_StripDate
  date
  returns
  date
  entry_point "StripDate" module_name "FLib.dll";

declare external function f_StripTime
  date
  returns
  date
  entry_point "StripTime" module_name "FLib.dll";

declare external function f_WeekOfYear
  date
  returns
  integer by value
  entry_point "WeekOfYear" module_name "FLib.dll";

declare external function f_WOY
  date
  returns
  cstring(254)
  entry_point "WOY" module_name "FLib.dll";

declare external function f_Year
  date
  returns
  integer by value
  entry_point "Year" module_name "FLib.dll";

declare external function f_YearOfYear
  date
  returns
  integer by value
  entry_point "YearOfYear" module_name "FLib.dll";

/* Mathematical functions */
declare external function f_DollarVal
  double precision
  returns
  cstring(254)
  entry_point "DollarVal" module_name "FLib.dll";

declare external function f_FixedPoint
  double precision, integer
  returns
  cstring(254)
  entry_point "FixedPoint" module_name "FLib.dll";

declare external function f_Modulo
  integer, integer
  returns
  integer by value
  entry_point "Modulo" module_name "FLib.dll";

declare external function f_IsDivisibleBy
  integer, integer
  returns
  integer by value
  entry_point "IsDivisibleBy" module_name "FLib.dll";

declare external function f_RoundFloat
  double precision,
  double precision
  returns
  double precision by value
  entry_point "RoundFloat" module_name "FLib.dll";

declare external function f_Truncate
  double precision
  returns integer by value
  entry_point "Truncate" module_name "FLib.dll";

/* String functions */
declare external function f_Character
  integer
  returns cstring(1)
  entry_point "Character" module_name "FLib.dll";

declare external function f_CRLF
  returns cstring(2)
  entry_point "CRLF" module_name "FLib.dll";

declare external function f_Left
  cstring(254), integer
  returns
  cstring(254)
  entry_point "Left" module_name "FLib.dll";

declare external function f_lrTrim
  cstring(254)
  returns
  cstring(254)
  entry_point "lrTrim" module_name "FLib.dll";

declare external function f_lTrim
  cstring(254)
  returns
  cstring(254)
  entry_point "lTrim" module_name "FLib.dll";

declare external function f_Mid
  cstring(254), integer, integer
  returns
  cstring(254)
  entry_point "Mid" module_name "FLib.dll";

declare external function f_PadLeft
  cstring(254),
  cstring(10),
  integer
  returns
  cstring(254)
  entry_point "PadLeft" module_name "FLib.dll";

declare external function f_PadRight
  cstring(254),
  cstring(10),
  integer
  returns
  cstring(254)
  entry_point "PadRight" module_name "FLib.dll";

declare external function f_ProperCase
  cstring(254)
  returns
  cstring(254)
  entry_point "ProperCase" module_name "FLib.dll";

declare external function f_Right
  cstring(254), integer
  returns
  cstring(254)
  entry_point "Right" module_name "FLib.dll";

declare external function f_rTrim
  cstring(254)
  returns
  cstring(254)
  entry_point "rTrim" module_name "FLib.dll";

declare external function f_Strip
  cstring(254),
  cstring(254),
  cstring(254)
  returns
  cstring(254)
  entry_point "Strip" module_name "FLib.dll";

declare external function f_IBPassword
  cstring(32)
  returns
  cstring(32)
  entry_point "IBPassword" module_name "FLib.dll";

/* Miscellaneous functions */

declare external function f_CloseDebuggerOutput
  returns integer by value
  entry_point "CloseDebuggerOutput" module_name "FLib.dll";

declare external function f_Debug
  cstring(1024)
  returns integer by value
  entry_point "Debug" module_name "FLib.dll";

declare external function f_IBTempPath
  returns
  cstring(1024)
  entry_point "IBTempPath" module_name "FLib.dll";

declare external function f_SetDebuggerOutput
  cstring(1024)
  returns integer by value
  entry_point "SetDebuggerOutput" module_name "FLib.dll";


/* Updated 22.08.1998 5:20:37 PM */
