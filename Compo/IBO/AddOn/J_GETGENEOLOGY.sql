/*===========================================================================*/
/*Metadata Extract performed 14-Jul-2000 10:15                               */
/*===========================================================================*/

/*===========================================================================*/
/*Connect to Database                                                        */
/*===========================================================================*/
connect 'C:\WILDDATA\WILDFIRE.GDB' user 'SYSDBA';



/*===========================================================================*/
/*Stored Procedure Definitions                                               */
/*===========================================================================*/
commit work;
set autoddl off;
set term ^;

create procedure j_getgeneology (SPONID integer, SPONGRPDIRNUM varchar(15), SPONDISTLEVEL integer,
 SPONDIRLEVEL integer)
returns (DISTID integer, DISTNUM varchar(15), DISTNAME varchar(30),
 DISTRANK integer, DISTLEVEL integer, DIRLEVEL integer, GRPDIRNUM varchar(15))
as
begin
  exit;
end
^




commit work^
set autoddl on^
set term ;^


/*===========================================================================*/
/*Stored Procedure Definitions                                               */
/*===========================================================================*/
commit work;
set autoddl off;
set term ^;

alter procedure j_getgeneology (SPONID integer, SPONGRPDIRNUM varchar(15), SPONDISTLEVEL integer,
 SPONDIRLEVEL integer)
returns (DISTID integer, DISTNUM varchar(15), DISTNAME varchar(30),
 DISTRANK integer, DISTLEVEL integer, DIRLEVEL integer, GRPDIRNUM varchar(15))
as
Declare Variable  vDistLevel Integer;
  Declare Variable  vDirLevel Integer;
  Declare Variable  vRank Integer;           
  Declare Variable  vDistId INTEGER;
  Declare Variable  vDistNum VARCHAR(15);
  Declare Variable  vDistName VARCHAR(30);
  Declare Variable  xDistLevel Integer;
  Declare Variable  xDirLevel Integer;
  Declare Variable  xDistId INTEGER;
  Declare Variable  xDistNum VARCHAR(15);
  Declare Variable  xDistName VARCHAR(30);  
  Declare Variable  xRank Integer; 
  Declare Variable  vGrpDirNum VARCHAR(15);   
  Declare Variable  xGrpDirNum VARCHAR(15);             
BEGIN
  FOR
   SELECT
     D.DIST_ID,
     D.TRACKBYID,
     D.DISPLAY_NAME,
     D.RANK
   FROM
    DISTRIBUTOR D
   WHERE
     D.Spon_Dist_Id = :SponId
   INTO
    :vDistId,
    :vDistNum,
    :vDistName,
    :vRank
   DO
   BEGIN
     DISTID = :vDistId;
     DISTNUM = :vDistNum;
     DISTNAME = :vDistName;
     DISTRANK = :vRank;
     vDistLevel = :SPONDISTLEVEL + 1; 
     IF ( :vRank >= 2) THEN
     BEGIN
       vDirLevel = :SPONDIRLEVEL + 1;
       vGrpDirNum = :vDistNum;  
     END                     
     ELSE
     BEGIN
       vGrpDirNum = :SPONGRPDIRNUM;
       vDirLevel = :SPONDIRLEVEL;
     END
     DISTLEVEL = :vDistLevel;
     DIRLEVEL = :vDirLevel;
     GRPDIRNUM  = :vGrpDirNum; 
     SUSPEND;
     FOR 
      SELECT
       J.DistId,
       J.DistNum,
       J.DistName,
       J.DistRank,
       J.DistLevel,
       J.DirLevel,
       J.GrpDirNum 
      FROM
        J_GetGeneology( :vDistId, :vGrpDirNum, :vDistLevel, :vDirLevel ) J
      INTO
        :xDistId,
        :xDistNum,
        :xDistName,
        :xRank,
        :xDistLevel,
        :xDirLevel,
        :xGrpDirNum
     DO
     BEGIN
        DISTLEVEL  = :xDistLevel;
        DIRLEVEL = :xDirLevel;
        DISTID = :xDistId;
        DISTNUM = :xDistNum;
        DISTNAME = :xDistName;
        DISTRANK = :xRank;
        GRPDIRNUM  = :xGrpDirNum;
        SUSPEND;
      END
   END
END
^




commit work^
set autoddl on^
set term ;^
