/*
Адресні листки прибуття
22.08.1998
*/

/* Table: ALP */
CREATE TABLE ALP (
        OBLAST         OBLAST_ID,
        ROVD           ROVD_ID,
        ID             D_ID,
        NUM            D_ID,
        FROM_STATE     NAME,
        FROM_AREA      NAME,
        FROM_DISTRICT  NAME,
        FROM_CITY      NAME,
        FROM_DATE      DATE,
        AREA           NAME,
        DISTRICT       NAME,
        CITY           NAME,
        STREET         NAME,
        BILDING        VARCHAR(10),
        FLATCH         VARCHAR(10),
        IS_PEREEHAL    BOOLEAN,
        IS_TEMPORARY   BOOLEAN,
        ORGAN          NAME,
        TEMP_DATE      DATE,
        TARGET         NAME,
        CATEGORY       NAME,
        SOSTAVLEN_DATE DATE,
        SOST_SIGN      NAME,
        PROV_DATE      DATE,
        PROV_SIGN      NAME,
        CONTROL        CHAR(1),
        DATE_LC        DATE,
        DATE_IN        DATE,
        IS_KIDS        BOOLEAN,
        N_KIDS         INTEGER,
        CLERK          CLERK_SIGN,
        CLERK_LC       CLERK_SIGN,
CONSTRAINT ALP_PK PRIMARY KEY (OBLAST, ROVD, ID, NUM));

/* Table: ALP_DETI */
CREATE TABLE ALP_DETI (
        OBLAST         OBLAST_ID,
        ROVD           ROVD_ID,
        ID             D_ID,
        NUM            D_ID,
        NUM_PP         D_ID,
        LAST_NAME      NAME,
        FIRST_NAME     NAME,
        MIDDLE_NAME    NAME,
        SEX            GENDER,
        BIRTH_DATE     DATE,
        CONTROL        CHAR(1),
        DATE_LC        DATE,
        DATE_IN        DATE,
        CLERK          CLERK_SIGN,
        CLERK_LC       CLERK_SIGN,
CONSTRAINT ALP_DETI_PK PRIMARY KEY (OBLAST, ROVD, ID, NUM, NUM_PP));



SET TERM ^ ;

CREATE TRIGGER ALP_INSERTED FOR ALP
AFTER INSERT AS
BEGIN
  POST_EVENT "ALP_ADDED";
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
      "Alp inserted",
      "0",
      NEW.CLERK);  
END
 ^

CREATE TRIGGER ALP_CHANGED FOR ALP
AFTER UPDATE AS
BEGIN
  POST_EVENT "ALP_CHANGED";
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
      "Alp changed",
      "0",
      NEW.CLERK_LC);  
END
 ^
COMMIT WORK ^
SET TERM ; ^

/* Updated 22.08.1998 5:09:52 PM */
