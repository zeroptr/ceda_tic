�
 TFRMEVENTS 0?  TPF0
TfrmEvents	frmEventsLeftTopyWidth� Height� CaptionEvents DemoColor	clBtnFace
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight TMemomeEventsLeft Top)Width� Height� TabStopAlignalClientReadOnly	TabOrder   TPanel
pnExecProcLeft Top Width� Height)AlignalTop
BevelOuterbvNoneTabOrder TButton
btExecProcLeftTopWidthAHeightCaptionExecProcTabOrder OnClickbtExecProcClick  TButtonbtExitLeftUTopWidthAHeightCaptionExitTabOrderOnClickbtExitClick   TIB_StoredProc
StoredProcDatabaseName2D:\PROJECTS\COMPS\IOBJECTS\SAMPLES\EVENTS\TEST.GDBIB_ConnectionibEventsSQL.StringsEXECUTE PROCEDURE TEST_EVENT StoredProcName
TEST_EVENTLeft Toph  
TIB_Events	IB_EventsAlertOnRegisterInterval�IB_ConnectionibEventsEvents.StringsTEST PassiveOnEventAlertIB_EventsEventAlertLefthToph  	TDatabasedbEventsDatabaseNameTest
DriverNameINTRBASEParams.StringsSERVER NAME=Test.gdbUSER NAME=SYSDBAPASSWORD=masterkey SessionNameDefaultLeft Top8  TIB_DatabaseibEventsPasswordStoragepsNotSecureParams.StringsUSER NAME=SYSDBA7PATH=D:\PROJECTS\COMPS\IOBJECTS\SAMPLES\EVENTS\TEST.GDBSERVER=CX170673-C LefthTop8  
TIB_ScriptscEventsSQL.StringsCREATE DATABASE 'TEST.GDB'  USER 'SYSDBA'  PASSWORD 'masterkey'; SET TERM ^; CREATE PROCEDURE TEST_EVENTASBEGIN  POST_EVENT 'TEST';END^ SET TERM ;^ COMMIT; IB_ConnectionibEventsLeft Top�    