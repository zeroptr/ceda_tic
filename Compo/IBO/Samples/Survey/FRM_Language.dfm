?
 TFRMLANGUAGE 0  TPF0?TfrmLanguagefrmLanguageLeft9Top? BorderIconsbiSystemMenu
biMinimize CaptionQuestion TranslationsClientHeight? ClientWidth(OnResize
FormResizePixelsPerInch`
TextHeight ? 	TSplitter	Splitter2LeftQTop WidthHeight? CursorcrHSplitAlignalRightBeveled	  ?
TStatusBar	StatusBarTop? Width(Visible  ?TPanelpnCloseTop? Width( ?TPanelpnOKCancelButtonsLeft?   ?TPanelpnApplyButtonLeft?Visible  ?TPanelpnHelpButtonLeft?  ?TPanelpnBrowseButtonLeft?    ?TIB_GridgrQuestionsLeft Top WidthQHeight? Hint0Enter the translated question and the laqnguage.CustomGlyphsSupplied 
DataSourcedsTranslationsAlignalClientTabOrderDefaultRowHeight
FixedColor?ʦ ListBoxStyle	IndicateLongCellText	DrawCellTextOptionsgdtEllipsis OrderingColorclInfoBkCtl3DShallow	StretchColumnPROMPTTabMovesOut	 TIB_LookupCombo
lcLanguageLeftTopLWidthyHeight
DataSource
dsLanguageVisibleTabOrder DisplayFieldLANGUAGENAMESeekNearest	OnNotInListlcLanguageNotInList   ?TPanelpnQuestionsLeftVTop Width? Height? AlignalRight
BevelOuterbvNoneTabOrder TIB_Memo	meChoicesLeft TopWidth? Heighto	DataFieldCHOICES
DataSourcedsTranslationsAlignalClientTabOrder AutoSize
ScrollBarsssBothWordWrap  TPanelPanel1Left TopWidth? HeightAlignalTop
BevelOuterbvNone
BevelWidthColor?ʦ TabOrder TBevelBevel1Left Top Width? HeightAlignalClientShapebsFrameStylebsRaised  TLabelLabel1LeftTopWidth&HeightCaptionChoices   TPanelPanel2Left Top Width? HeightAlignalTop
BevelOuter	bvLoweredTabOrder   ?TIB_TransactionSourcetsBaseLeft Top  ?TIB_ConnectionSourcecsBaseLeft? Top  	TIB_QueryqrTranslationsColumnAttributes.StringsLANGUAGENAME=NOCASEPROMPT=NOCASE DatabaseNameSurveyFieldsCharCase.StringsPRESENTATION=U FieldsDisplayLabel.StringsQUESTIONID=IDPROMPT=PromptCHOICES=ChoicesLANGUAGENAME=LanguageADD_DATE=AddedEDIT_DATE=Modified FieldsDisplayWidth.StringsQUESTIONID=22ADD_DATE=56EDIT_DATE=60PRESENTATION=64
CHOICES=48REQUIRED=27
PR_DESC=99LANGUAGENAME=74"TABLE_QUESTION_LANGUAGE.PROMPT=273 FieldsVisible.StringsPRESENTATION=FQUESTIONID=FLANGUAGEID=F
SURVEYID=F	CHOICES=F
ADD_DATE=FEDIT_DATE=F SQL.StringsSELECT q.PROMPT     , q.QUESTIONID     , q.LANGUAGEID     , ( SELECT l.LANGUAGENAME         FROM TABLE_LANGUAGE l<         WHERE l.LANGUAGEID = q.LANGUAGEID ) AS LANGUAGENAME     , q.CHOICESFROM TABLE_QUESTION_LANGUAGE q ColorScheme	GeneratorLinks.StringsQUESTIONID=GEN_QUESTIONID KeyLinks.StringsQUESTIONID=QUESTIONIDLANGUAGEID=LANGUAGEID KeyRelationTABLE_QUESTION_LANGUAGEMasterLinks.StringsQUESTIONID=QUESTIONID MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly OrderingItemNoOrderingItems.StringsPrompt=PROMPT; PROMPT desc OrderingLinks.StringsPROMPT=1 RequestLive	OnNewRecordqrTranslationsNewRecordBufferSynchroFlags FetchWholeRows	LeftXTop  TIB_DataSourcedsTranslationsAnnounceFocus	DatasetqrTranslationsLeft? Top  	TIB_Query
qrLanguageColumnAttributes.StringsLANGUAGENAME=NOCASE DatabaseNameSurveyFieldsCharCase.StringsLANGUAGENAME=P FieldsDisplayLabel.StringsLANGUAGENAME=Language FieldsVisible.StringsLANGUAGEID=F SQL.StringsSELECT LANGUAGEID     , LANGUAGENAMEFROM TABLE_LANGUAGE ColorSchemeGeneratorLinks.Stringslanguageid=gen_languageid KeyLinks.StringsLANGUAGEID=LANGUAGEID KeyDescLinks.StringsLANGUAGENAME=LANGUAGENAME 	KeySourcedsTranslationsKeyRelationTABLE_LANGUAGEMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly OrderingItemNoOrderingItems.StringsID=LANGUAGEID; LANGUAGEID desc$Name=LANGUAGENAME; LANGUAGENAME desc OrderingLinks.StringsLANGUAGEID=1LANGUAGENAME=2 RefreshActionraKeepDataPos	AfterPostqrLanguageAfterPostBufferSynchroFlags FetchWholeRows	Left? TopP  TIB_DataSource
dsLanguageDataset
qrLanguageLeft? TopP   