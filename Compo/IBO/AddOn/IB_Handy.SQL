
// This file is where I put all of my handly little snippets of SQL code.
// I thought I'd get this started and share it with all of you too.


// This SQL will create a script of statements in order to grant privilages
// to all non-system tables. In IB_WISQL connect to the database of choice and
// execute this in the Export form. Change the space delimiter to a blank space
// instead of the double quote and the script will be ready to load into the
// Script form to be executed.
//
// Be sure to replace <USER NAME> with the one you are granting for.

SELECT 'GRANT ALL ON ' || RDB$RELATION_NAME || + ' TO USER <USER NAME>;'
FROM RDB$RELATIONS
WHERE ( RDB$SYSTEM_FLAG <> 1 OR RDB$SYSTEM_FLAG IS NULL )
  AND RDB$VIEW_SOURCE IS NULL
ORDER BY 1


// This procedure is used to return the number of hours from the year 2000.

CREATE PROCEDURE GET_NUMBER_OF_HOURS( ADATE DATE )
RETURNS ( HOURS INTEGER )
AS
declare variable datenotime date;
declare variable basedate date;
declare variable testdate date;
declare variable datetimeonly double precision;
declare variable ii integer;
begin
  basedate = cast( '1.1.2000' as date );
  datenotime = cast( cast( ADate as char(11)) as date );
  Hours = datenotime - basedate;
  Hours = Hours * 24;
  if ( ADate <> datenotime ) then begin
    datetimeonly = ADate - datenotime + 0.000005;
    testdate = basedate + datetimeonly;
    ii = 1;
    while ( ii < 24 ) do begin
      if ( cast( '1.1.2000 ' || 
           cast( ii as char(2)) || ':00' as date ) <= testdate ) then begin
        Hours = Hours + 1;
      end
      ii = ii + 1;
    end
  end
  suspend;
end