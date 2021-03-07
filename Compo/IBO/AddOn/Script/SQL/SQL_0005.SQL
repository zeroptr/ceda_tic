/* 
Картка обліку по формі 26
13.08.1998 
*/

/* Table: FORMA26 */
CREATE TABLE FORMA26 (
        OBLAST       OBLAST_ID,
        ROVD         ROVD_ID,
        ID           D_ID,
        NUM          D_ID,
        ORGAN        NAME,
        STATE        NAME,
        AREA         NAME,
        DISTRICT     NAME,
        CITY         NAME,
        PRIBUV_DATE  DATE,
        OSVOB_DATE   DATE,
        NAME_ITU     NAME,
        PRICHINA     NAME,
        SPR_SERIA    VARCHAR(10),
        SPR_NUM      VARCHAR(10),
        SPR_NAME     SHORTNAME,
        ADMIN_NADZOR NAME,
        DATA_POGASH  DATE,
        CONTROL      CHAR(1),
        KOGDA_DATE   DATE,
        KOGDA_NAME_SUD NAME,
        KOGDA_EXPIRE   DATE,
        NA_SROK      SHORTNAME,
        IS_ST_UK     BOOLEAN,
        N_ST_UK      INTEGER,
        DATE_LC      DATE,
        DATE_IN      DATE,
        CLERK        CLERK_SIGN,
        CLERK_LC     CLERK_SIGN,
CONSTRAINT FORMA26_PK PRIMARY KEY (OBLAST, ROVD, ID, NUM));


/* Table: FORMA26_KK */
CREATE TABLE FORMA26_KK (
        OBLAST       OBLAST_ID,
        ROVD         ROVD_ID,
        ID           D_ID,
        NUM          D_ID,
        N_PP         D_ID,
        ST_UK        NAME,
        CONTROL      CHAR(1),
        DATE_LC      DATE,
        DATE_IN      DATE,
        CLERK        CLERK_SIGN,
        CLERK_LC     CLERK_SIGN,
CONSTRAINT FORMA26_KK_PK PRIMARY KEY (OBLAST, ROVD, ID, NUM, N_PP));

SET TERM ^ ;

CREATE TRIGGER FORMA26_INSERTED FOR FORMA26
AFTER INSERT AS
BEGIN
  POST_EVENT "FORMA26_ADDED";
    INSERT INTO JURNAL
    ( OBLAST,
      ROVD  ,
      NUM   ,
      ACTION_TIME,
      ACTION_NAME,
      ACTION_RES ,
      CLERK      
      )
    VALUES
    ( NEW.OBLAST,
      NEW.ROVD,
      NEW.ID,
      "NOW",
      "Forma 26 inserted",
      "0",
      NEW.CLERK);  
END
 ^

CREATE TRIGGER FORMA26_CHANGED FOR FORMA26
AFTER UPDATE AS
BEGIN
  POST_EVENT "FORMA26_CHANGED";
    INSERT INTO JURNAL
    ( OBLAST,
      ROVD  ,
      NUM   ,
      ACTION_TIME,
      ACTION_NAME,
      ACTION_RES ,
      CLERK      
      )
    VALUES
    ( NEW.OBLAST,
      NEW.ROVD,
      NEW.ID,
      "NOW",
      "Forma 26 changed",
      "0",
      NEW.CLERK_LC);  
END
 ^
COMMIT WORK ^
SET TERM ; ^
/* Updated 22.08.1998 4:57:07 PM */
