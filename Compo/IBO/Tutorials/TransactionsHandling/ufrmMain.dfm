?
 TFRMMAIN 0aA  TPF0TfrmMainfrmMainLeft? TopkWidth?Height?CaptionIBO Transaction TutorialColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style Menu	MainMenu1OldCreateOrder	PositionpoScreenCenterOnCreate
FormCreatePixelsPerInch`
TextHeight TPageControlpctlLeft Top WidthxHeight?
ActivePage	TabSheet6AlignalClientTabOrder  	TTabSheet	TabSheet1CaptionIntroduction TMemomeIntroLeft Top WidthpHeightzAlignalClientLines.StringsEThis project is a demostration of using transactions with IB Objects. OWe will see how Commit, CommitRetaining, Rollback and RollbackRetaining work inJthe context of a master/detail relationship and how transactions work withtriggers and stored procedures. HThe first time this program is run, a database is created in the currentMdirectory. Be sure to edit the username and password in the first part of thescript if necessary. Lessons #1.  Simple single table transaction2.  Master/Detail transactions3.  Triggers4.  Stored procedures5.  Isolation DNOTE: You can use the IB_Monitor to trace events associated with theLtransactions. Just a couple of minutes with the monitor and this lesson willNyield quite a bit of insight into the IB_Transaction component. Open it up nowfrom the File menu.    TabOrder    	TTabSheet	TabSheet2CaptionLesson 1 TLabelLabel2LeftTopWidth	HeightCaption)1. Open the dataset and make some changesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFont  TLabelLabel4LeftTop? Width? HeightCaption!2. Commit or rollback the changesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFontWordWrap	  TLabelLabel5LeftTopHWidthHeightCaption03. Repeat until you understand how it all works!Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFontWordWrap	  TIB_UpdateBarIB_UpdateBar1Left)Top0WidthyHeightCtl3DParentCtl3DParentShowHintShowHint	TabOrder
DataSourcedmLesson1.srcMasterReceiveFocusCustomGlyphsSupplied   TMemo	meLesson1Left_Top WidthHeightzAlignalRightLines.StringsSingle Table 8Here we demostrate the most basic transaction control.   5The default explicit transaction settings apply here. These are AutoCommit = false andIsolation = tiConcurrency 6When a dataset is first opened, a physical transaction;is automatically started for you. A physical transaction is2required to do almost everything when working with9statements and datasets. This is different than a logicaltransaction.  5A logical transaction isn't started until a change is6actually made. This is the part the determines whether%changes made are kept or thrown away. 8Both physical and logical transaction aspects need to be'considered when working with InterBase. ;Be sure to try all of the buttons on the transaction bar.  /Each one has a different effect on the dataset. 5If you try the Commit or Rollback buttons the dataset4will be closed. Otherwise, using CommitRetaining and.RollbackRetaining will leave the dataset open. TabOrder   TIB_DatasetBarIB_DatasetBar1LeftTop0WidthHeightCtl3DParentCtl3DTabOrder
DataSourcedmLesson1.srcMasterReceiveFocusCustomGlyphsSupplied 
ToggleOpen	VisibleButtonsdbOpen   TIB_GridIB_Grid1LeftTopPWidth? Height? CustomGlyphsSupplied 
DataSourcedmLesson1.srcMasterTabOrderIndicateRowCtl3DShallow	  TIB_TransactionBarIB_TransactionBar2LeftTopWidth? HeightCtl3DParentCtl3DParentShowHintShowHint	TabOrderCustomGlyphsSupplied IB_TransactiondmLesson1.trnReceiveFocusVisibleButtonstbCommitRetainingtbCommittbRollbackRetaining
tbRollback    	TTabSheet	TabSheet3CaptionLesson 2 TLabelLabel11LeftTop(Width(HeightCaptionMasterFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFont  TLabelLabel12Left? Top(Width!HeightCaptionDetailFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFont  TLabelLabel1LeftTopWidth	HeightCaption)1. Open the dataset and make some changesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFont  TLabelLabel3LeftTop? Width? HeightCaption!2. Commit or rollback the changesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFontWordWrap	  TLabelLabel6LeftTopHWidthHeightCaption03. Repeat until you understand how it all works!Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFontWordWrap	  TIB_UpdateBarIB_UpdateBar3Left? Top@WidthoHeightCtl3DParentCtl3DParentShowHintShowHint	TabOrder
DataSourcedmLesson2.srcDetailReceiveFocusCustomGlyphsSupplied   TIB_UpdateBarIB_UpdateBar2Left)Top@WidthoHeightCtl3DParentCtl3DParentShowHintShowHint	TabOrder
DataSourcedmLesson2.srcMasterReceiveFocusCustomGlyphsSupplied   TMemo	meLesson2LeftjTop WidthHeightzAlignalRightLines.StringsMaster/Detail 6Here we demonstrate explicit transaction control in a master/detail situation. 7We again use the default explicit transaction settings. 4The point of this exercise is for you to see how all6changes in all tables involved in a single transaction2context are committed or rolled back together as asingle unit of work. 2Insert records in both tables and make changes and5then do a rollback and notice that after opening both%tables that all the changes are gone. TabOrder   TIB_DatasetBarIB_DatasetBar2LeftTop@WidthHeightCtl3DParentCtl3DTabOrder
DataSourcedmLesson2.srcMasterReceiveFocusCustomGlyphsSupplied 
ToggleOpen	VisibleButtonsdbOpen   TIB_GridIB_Grid2LeftTop`Width? Height? CustomGlyphsSupplied 
DataSourcedmLesson2.srcMasterTabOrderIndicateRowCtl3DShallow	  TIB_TransactionBarIB_TransactionBar4LeftTopWidth? HeightCtl3DParentCtl3DParentShowHintShowHint	TabOrderCustomGlyphsSupplied IB_TransactiondmLesson2.trnReceiveFocusVisibleButtonstbCommitRetainingtbCommittbRollbackRetaining
tbRollback   TIB_DatasetBarIB_DatasetBar3Left? Top@WidthHeightCtl3DParentCtl3DTabOrder
DataSourcedmLesson2.srcDetailReceiveFocusCustomGlyphsSupplied 
ToggleOpen	VisibleButtonsdbOpen   TIB_GridIB_Grid3Left? Top`Width? Height? CustomGlyphsSupplied 
DataSourcedmLesson2.srcDetailTabOrderGridLinks.StringsDETKEYAFIELDMASKEY IndicateRowCtl3DShallow	   	TTabSheet	TabSheet4CaptionLesson 3 TLabelLabel18LeftTop0WidthHeightCaptionTrig1Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFont  TLabelLabel19Left? Top0WidthHeightCaptionTrig2Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFont  TLabelLabel7LeftTopWidth	HeightCaption)1. Open the dataset and make some changesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFont  TLabelLabel8LeftTop? Width? HeightCaption!2. Commit or rollback the changesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFontWordWrap	  TLabelLabel9LeftTopHWidthHeightCaption03. Repeat until you understand how it all works!Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFontWordWrap	  TIB_UpdateBarIB_UpdateBar5Left? TopHWidth? HeightCtl3DParentCtl3DParentShowHintShowHint	TabOrder
DataSourcedmLesson3.srcTrig2ReceiveFocusCustomGlyphsSupplied VisibleButtonsubEditubInsertubDeleteubPostubCancelubRefreshAll   TIB_UpdateBarIB_UpdateBar4Left)TopHWidthoHeightCtl3DParentCtl3DParentShowHintShowHint	TabOrder
DataSourcedmLesson3.srcTrig1ReceiveFocusCustomGlyphsSupplied   TMemo	meLesson3LeftjTop WidthHeightzAlignalRightLines.StringsTriggers 6Here we demonstrate explicit transaction control with 9respect to triggers.  Trig1 is a table that has a before ;insert trigger that writes a record to trig2.  The trigger source is shown below: CREATE TRIGGER  trg_trigInsertFOR  trig1BEFORE INSERT POSITION 0ASBEGIN  INSERT INTO trig2 ( VCField ).    VALUES( "trig1.aField " || new.IntField );END Things to try: 51. With both datasets open, insert and post a record <to trig1. Notice that the display of trig2 is not updated.  7Try pressing the refresh button for trig2. The inserted)record should now appear upon refreshing.   TabOrder   TIB_DatasetBarIB_DatasetBar4LeftTopHWidthHeightCtl3DParentCtl3DTabOrder
DataSourcedmLesson3.srcTrig1ReceiveFocusCustomGlyphsSupplied 
ToggleOpen	VisibleButtonsdbOpen   TIB_TransactionBarIB_TransactionBar6LeftTopWidth? HeightCtl3DParentCtl3DParentShowHintShowHint	TabOrderCustomGlyphsSupplied IB_TransactiondmLesson3.trnReceiveFocusVisibleButtonstbCommitRetainingtbCommittbRollbackRetaining
tbRollback   TIB_DatasetBarIB_DatasetBar5Left? TopHWidthHeightCtl3DParentCtl3DTabOrder
DataSourcedmLesson3.srcTrig2ReceiveFocusCustomGlyphsSupplied 
ToggleOpen	VisibleButtonsdbOpen   TIB_GridIB_Grid4LeftTophWidthZHeight? CustomGlyphsSupplied 
DataSourcedmLesson3.srcTrig1TabOrderIndicateRowCtl3DShallow	  TIB_GridIB_Grid5Left? TophWidth? Height? CustomGlyphsSupplied 
DataSourcedmLesson3.srcTrig2TabOrderDefaultColWidthdIndicateRowCtl3DShallow	   	TTabSheet	TabSheet5CaptionLesson 4 TLabelLabel10LeftTopWidth	HeightCaption)1. Open the dataset and make some changesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFont  TLabelLabel13LeftTop? Width? HeightCaption!2. Commit or rollback the changesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFontWordWrap	  TLabelLabel14LeftTopHWidthHeightCaption03. Repeat until you understand how it all works!Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFontWordWrap	  TIB_UpdateBaribubLeft)Top0Width? HeightCtl3DParentCtl3DParentShowHintShowHint	TabOrder
DataSourcedmLesson4.srcProcReceiveFocusCustomGlyphsSupplied VisibleButtonsubEditubInsertubDeleteubPostubCancelubRefreshAll   TIB_DatasetBarIB_DatasetBar6LeftTop0WidthHeightCtl3DParentCtl3DTabOrder 
DataSourcedmLesson4.srcProcReceiveFocusCustomGlyphsSupplied 
ToggleOpen	VisibleButtonsdbOpen   TIB_GridIB_Grid6LeftTopPWidth? Height? CustomGlyphsSupplied 
DataSourcedmLesson4.srcProcTabOrderIndicateRowCtl3DShallow	  TIB_TransactionBarIB_TransactionBar8LeftTopWidth? HeightCtl3DParentCtl3DParentShowHintShowHint	TabOrderCustomGlyphsSupplied IB_TransactiondmLesson4.trnReceiveFocusVisibleButtonstbCommitRetainingtbCommittbRollbackRetaining
tbRollback   TMemo	meLesson4LeftjTop WidthHeightzAlignalRightLines.StringsStored Procedure 8A stored procedure called aproc inserts a record into a 7table called proc.  Here is the code for the procedure: CREATE PROCEDURE aprocASBEGIN  INSERT INTO    proc (afield)  VALUES3    ("The number is: " || GEN_ID( gen_keynum, 1 ));END  Things to try: 6After clicking the ExecProc button do a refresh to see3the changes it made in the dataset. Then, apply the4transaction commit or rollback and reopen/refresh tosee how it works. 9Notice that the generator is not affected by a rollback.   TabOrder  TButtonButton1Left? Top0WidthKHeightCaption	Exec ProcTabOrderOnClickButton1Click   	TTabSheet	TabSheet6CaptionLesson 5 TLabelLabel26LeftTopXWidth? HeightCaption&2. Open datasets and make some changesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFont  TLabelLabel28LeftTop? Width? HeightCaption!3. Commit or rollback the changesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFontWordWrap	  TLabelLabel30LeftTopWidthHeightCaption1. Set isolation LevelsFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFont  TLabelLabel15LeftTopHWidthHeightCaption04. Repeat until you understand how it all works!Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameArial
Font.Style 
ParentFontWordWrap	  TIB_UpdateBarIB_UpdateBar7Left? ToppWidth? HeightCtl3DParentCtl3DParentShowHintShowHint	TabOrder
DataSourcedmLesson5.srcMaster2ReceiveFocusCustomGlyphsSupplied VisibleButtonsubEditubInsertubDeleteubPostubCancelubRefreshAll   TIB_UpdateBarIB_UpdateBar6Left)ToppWidth? HeightCtl3DParentCtl3DParentShowHintShowHint	TabOrder
DataSourcedmLesson5.srcMaster1ReceiveFocusCustomGlyphsSupplied VisibleButtonsubEditubInsertubDeleteubPostubCancelubRefreshAll   TMemo	meLesson5Left?Top Width? HeightzAlignalRightLines.StringsTransaction Isolation 1This lesson uses separate transaction contexts to0illustrate the effects of transaction isolation. +Two datsets each with thier own transaction/components are used.  You can set the isolationlevels of each independently. Things to try:.1. Attempt to make a change to the same record+in both datasets. You should get a deadlock/when posting the second one. Rollback the first3and attempt to post the second again. It will work. /2. Experiment with the effects of changes being0visible from one transaction context to another.-Make and commit a change in one side and then0refresh the dataset on the other side and see if/the change appears. Commit or rollback and then.do a refresh and notice that the change always2appears after starting a new physical transaction. +3. Prove to yourself that the tiConcurrency(isolation is indeed "read-repeatable" or+"snapshot" by making and committing lots of.changes in the other and how they don't appear%no matter how many times you refresh. TabOrder   TIB_DatasetBarIB_DatasetBar7LeftToppWidthHeightCtl3DParentCtl3DTabOrder
DataSourcedmLesson5.srcMaster1ReceiveFocusCustomGlyphsSupplied 
ToggleOpen	VisibleButtonsdbOpen   TIB_GridIB_Grid7LeftTop? Width? HeightaCustomGlyphsSupplied 
DataSourcedmLesson5.srcMaster1TabOrderIndicateRowCtl3DShallow	  TIB_TransactionBarIB_TransactionBar10LeftTopWidth? HeightCtl3DParentCtl3DParentShowHintShowHint	TabOrderCustomGlyphsSupplied IB_TransactiondmLesson5.trn1ReceiveFocusVisibleButtonstbCommitRetainingtbCommittbRollbackRetaining
tbRollback   TIB_GridIB_Grid8Left? Top? Width? HeightaCustomGlyphsSupplied 
DataSourcedmLesson5.srcMaster2TabOrderIndicateRowCtl3DShallow	  TIB_DatasetBarIB_DatasetBar8Left? ToppWidthHeightCtl3DParentCtl3DTabOrder
DataSourcedmLesson5.srcMaster2ReceiveFocusCustomGlyphsSupplied 
ToggleOpen	VisibleButtonsdbOpen   TIB_TransactionBarIB_TransactionBar11Left? TopWidth? HeightCtl3DParentCtl3DParentShowHintShowHint	TabOrderCustomGlyphsSupplied IB_TransactiondmLesson5.trn2ReceiveFocusVisibleButtonstbCommitRetainingtbCommittbRollbackRetaining
tbRollback   TRadioGrouprg1LeftTopWidth? Height9Caption trn 1 	ItemIndexItems.Strings
tiComittedtiConcurrency TabOrder	OnClickrg1Click  TRadioGrouprg2Left? TopWidth? Height9Caption trn 2 	ItemIndexItems.Strings
tiComittedtiConcurrency TabOrder
OnClickrg2Click    	TMainMenu	MainMenu1Left8TopX 	TMenuItemFile1Caption&File 	TMenuItemMonitorSQL1CaptionMonitor SQLOnClickMonitorSQL1Click  	TMenuItemExit1CaptionE&xitOnClick
Exit1Click    TIB_MonitorDialogmdBaseKey.Software\CPS\IBO\Tutorials\TransactionTutorialLeft?TopX   