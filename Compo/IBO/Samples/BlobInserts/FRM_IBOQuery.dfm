�
 TFRMBLOBINSERTS 02  TPF0TfrmBlobInsertsfrmBlobInsertsLeftTop� Width�Height� CaptionfrmBlobInsertsFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ShowHint	PixelsPerInch`
TextHeight TDBGridIB_Grid1Left Top%Width�Height}AlignalClient
DataSourcedsTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style   TPanelPanel1Left Top Width�Height%AlignalTopTabOrder TSpeedButton
sbFilteredLeft8TopWidth<Height
AllowAllUp	
GroupIndexCaptionFilteredOnClicksbFilteredClick  TButtonbtFindFirstLeft� TopWidth<HeightCaption
Find FirstTabOrder OnClickbtFindClick  TButton
btFindNextLeftTopWidth<HeightCaption	Find NextTabOrderOnClickbtFindClick  TButtonbtFindPriorLeftHTopWidth<HeightCaption
Find PriorTabOrderOnClickbtFindClick  TButton
btFindLastLeft�TopWidth<HeightCaption	Find LastTabOrderOnClickbtFindClick  TButtonButton1LeftxTopWidthKHeightCaptionInc( tmpID )TabOrderOnClickButton1Click  TButtonButton3LeftTopWidth(HeightCaptionOpenTabOrderOnClickButton3Click   TIB_ConnectioncnDatabaseNameTESTParams.StringsPATH=BLOBINSERTS.GDBUSER NAME=SYSDBASERVER=CX170673-EPASSWORD=masterkey Left0Topp  TIB_TransactiontrIB_Connectioncn	IsolationtiConcurrency
RecVersionLeftPTopp  	TIBOQueryqrDatabaseNameTESTIB_ConnectioncnIB_TransactiontrKeyLinks.StringsID RecordCountAccurate	
BeforeOpenqrBeforeOpenOnFilterRecordqrFilterRecordRequestLive	SQL.Strings	SELECT ID     , STRING_FIELD     , BLOB_FIELD	FROM TEST FieldOptions LeftpTopp  TDataSourcedsDataSetqrLeft� Topp   