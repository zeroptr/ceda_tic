/* 
Особисті картки
13.08.1998 
*/


/* Table: PERSONA */
CREATE TABLE PERSONA (
        OBLAST        OBLAST_ID,
        ROVD          ROVD_ID,
        ID            D_ID,
        BIRTH_DATE    DATE,
        PERSONAL_COD  VARCHAR(10),
        STATE         NAME,
        AREA          NAME,
        DISTRICT      NAME,
        CITY          NAME,
        R_STATE       NAME,
        R_AREA        NAME,
        R_DISTRICT    NAME,
        R_CITY        NAME,
        E_STATE       NAME,
        E_AREA        NAME,
        E_DISTRICT    NAME,
        E_CITY        NAME,
        SEX           GENDER,
        FIRST_NAME    NAME,
        MIDDLE_NAME   NAME,
        LAST_NAME     NAME,
        R_FIRST_NAME  NAME,
        R_MIDDLE_NAME NAME,
        R_LAST_NAME   NAME,
        E_FIRST_NAME  NAME,
        E_MIDDLE_NAME NAME,
        E_LAST_NAME   NAME,
        NATION        NAME,
        CITIZEN       NAME,
        DATE_IN       DATE,
        DATE_LC       DATE,
        IS_FORMA26    BOOLEAN,
        N_FORMA26     INTEGER,
        IS_HAVE_VISRS BOOLEAN,
        N_H_VISITOR   INTEGER,
        IS_VISITOR    BOOLEAN,
        N_VISITOR     INTEGER,
        IS_EXTL_PASP  BOOLEAN,
        N_E_PASP      INTEGER,
        IS_INT_PASP   BOOLEAN,
        N_I_PASP      INTEGER,
        IS_NEED_CZ    BOOLEAN,
        N_N_CZ        INTEGER,
        IS_VEAPON     BOOLEAN,
        N_VEAPON      INTEGER,
        IS_SCOPE      BOOLEAN,
        N_UNDER_SC    INTEGER,
        IS_WANTED     BOOLEAN,
        N_WANTED      INTEGER,
        IS_MASHINA    BOOLEAN,
        N_MASHINA     INTEGER,
        IS_ADMIN      BOOLEAN,
        N_ADMIN       INTEGER,
        IS_MARRYED    BOOLEAN,
        N_MARRYED     INTEGER,
        IS_DIVORSED   BOOLEAN,
        N_DIVORSED    INTEGER,
        IS_CHILD      BOOLEAN,
        N_CHILD       INTEGER,
        IS_DOC        BOOLEAN,
        N_DOC         INTEGER,
        LIVE_STATE    NAME,
        LIVE_AREA     NAME,
        LIVE_DISTRICT NAME,
        LIVE_CITY     NAME,
        LIVE_STREET   NAME,
        LIVE_BILDING  VARCHAR(10),
        LIVE_FLATCH   VARCHAR(10),
        LIVE_DATE     DATE,
        IS_ALP        BOOLEAN,
        N_ALP         INTEGER,
        IS_ALV        BOOLEAN,
        N_ALV         INTEGER,
        LOC_STATE     NAME,
        LOC_AREA      NAME,
        LOC_DISTRICT  NAME,
        LOC_CITY      NAME,
        LOC_STREET    NAME,
        LOC_BILDING   VARCHAR(10),
        LOC_FLATCH    VARCHAR(10),
        LOC_DATE      DATE,
        INT_P_NUM     PNUM,
        INT_P_SERIA   PSERIA,
        INT_P_DATE    DATE,
        INT_P_VIDAN   NAME,
        EXT_P_NUM     PNUM,
        EXT_P_SERIA   PSERIA,
        EXT_P_DATE    DATE,
        EXT_PE_DATE   DATE,
        EXT_P_VIDAN   NAME,
        SPN_NUM       VARCHAR(15),
        SPN_SERIA     VARCHAR(15),
        SPN_DATE      DATE,
        F_LAST_NAME   NAME,
        F_MIDDLE_NAME NAME,
        F_FIRST_NAME  NAME,
        F_NATION      NAME,
        M_LAST_NAME   NAME,
        M_MIDDLE_NAME NAME,
        M_FIRST_NAME  NAME,
        M_NATION      NAME,
        IS_CH_NAME    BOOLEAN,
        N_CH_NAME     INTEGER,
        IS_FOTO       BOOLEAN,
        N_FOTO        INTEGER,
        FOTO          PICTURE,
        DIRECTION     NAME,
        WORK_PLACE    NAME,
        WORK_DOLJN    NAME,
        IS_WORK       BOOLEAN,
        N_WORK        INTEGER,
        KATEGORY      NAME,
        IS_FAMILY     BOOLEAN,
        N_FAMILY      INTEGER,
        IS_EDUC       BOOLEAN,
        N_EDUC        INTEGER,
        IS_VISA       BOOLEAN,
        N_VISA        INTEGER,
        IS_LIMBO      BOOLEAN,
        N_LIMBO       INTEGER,
        PRINAL        NAME,
        PRIN_DATE     DATE,
        PROVERIL      NAME,
        PROV_DATE     DATE,
        ARCHIVED      CHAR(1),
        DELETED       CHAR(1),
        CLERK         CLERK_SIGN,
        CLERK_LC      CLERK_SIGN,
        CONTROL       CHAR(1),
        COMMENT       NOTE,
        FROM_STATE    NAME,
        FROM_AREA     NAME,
        FROM_DISTRICT NAME,
        FROM_CITY     NAME,
        FROM_DATE     DATE,
        FROM_META     NAME,
CONSTRAINT PERSONA_PK PRIMARY KEY (OBLAST, ROVD, ID));


CREATE INDEX BIRTH_PERSONA ON PERSONA(BIRTH_DATE);
CREATE INDEX FIRST_PERSONA ON PERSONA(FIRST_NAME,MIDDLE_NAME,BIRTH_DATE);
CREATE INDEX MIDDLE_PERSONA ON PERSONA(MIDDLE_NAME);
CREATE INDEX PERSONA_ALL ON PERSONA(LAST_NAME, FIRST_NAME, MIDDLE_NAME, BIRTH_DATE);
CREATE INDEX F26_PERSONA ON PERSONA(IS_FORMA26);

SET TERM ^ ;

CREATE TRIGGER PERSONA_INSERTED FOR PERSONA
AFTER INSERT AS
BEGIN
  POST_EVENT "PERSONA_ADDED";
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
      "Persona inserted",
      "0",
      NEW.CLERK);  
END
^

CREATE TRIGGER PERSONA_CHANGED FOR PERSONA
AFTER UPDATE AS
BEGIN
  POST_EVENT "PERSONA_CHANGED";
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
      "Persona changed",
      "0",
      NEW.CLERK_LC);  
END
^

COMMIT WORK ^
SET TERM ; ^
/* Updated 22.08.1998 4:40:04 PM */
/* Updated 22.08.1998 4:42:45 PM */
