�
 TFRMCREATORMAIN 0`  TPF0TfrmCreatorMainfrmCreatorMainLeft� TopsWidthpHeight�CaptionDatabase Maintaining Utility
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style Menu	MainMenu1ShowHint	OnCreate
FormCreatePixelsPerInch`
TextHeight TPageControlPageControl1LeftTop WidthOHeight]
ActivePage	TabSheet3AlignalClientTabOrder  	TTabSheet	TabSheet1CaptionDatabase TPanelPanel2Left Top WidthGHeightAAlignalClient
BevelOuter	bvLoweredTabOrder  TLabelLabel1LeftTopWidthIHeightCaptionDatabase path:  TPanelPanel4LeftTop� WidthEHeightHAlignalBottomTabOrder  TIB_ConnectionBarIB_ConnectionBar1LeftTopWidth)HeightCtl3DParentCtl3DTabOrder CustomGlyphsSupplied IB_ConnectionDBmainReceiveFocusVisibleButtonscbCreatecbDrop	cbConnectcbDisconnect   TIB_UtilityBarIB_UtilityBar1LeftTop(Width'HeightCustomGlyphsSupplied BaseConnectionDBmainVisibleButtonswbBrowsewbDSQLwbEventswbExportwbDumpwbPumpwbWhowbScript	wbMonitorwbUsers Ctl3DParentCtl3DTabOrder   TDriveComboBoxDriveComboBox1LeftTop� WidthHeightDirListDirectoryListBox1TabOrder  TDirectoryListBoxDirectoryListBox1LeftTopWidthHeight� FileListFileListBox1
ItemHeightTabOrder  TFileListBoxFileListBox1Left(TopWidthHeight� FileEditBaseNameEdit
ItemHeightMask*.gdbTabOrder  TEditBaseNameEditLeft(Top� WidthHeightTabOrderText*.gdbOnChangeBaseNameEditChange    	TTabSheet	TabSheet2CaptionSQL scripts TPanelPanel5Left Top WidthGHeightAAlignalClient
BevelOuter	bvLoweredTabOrder  TPanelPanel6LeftTopWidthEHeight)AlignalBottomTabOrder  TSpeedButtonsbCreateLeft`TopWidthHeightHintExecute SQLEnabled
Glyph.Data
z  v  BMv      v   (                                       �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� UUUUUUUUUUUUUUUUUUUUUUUUUUU�UUUUUUYUUUUUUW�UUUUU��UUUUUUww�UUUUU��UUUUUUww�UUUUY��UUUUWwwUUUU���UUUUwww�UUW���UUUWwuww�UUyUY�UUUwuUWw�UUUUUY�UUUUUWwUUUUUU�UUUUUUw�UUUUUY�UUUUUUWw�UUUUUUyUUUUUUw�UUUUUW�UUUUUUWw�UUUUUUY�UUUUUUWwUUUUUUUUUUUUUUUU	NumGlyphsOnClicksbCreateClick  TSpeedButton	sbSQLsaveLeft�TopWidthHeightHintSave SQL scriptEnabled
Glyph.Data
z  v  BMv      v   (                                       �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333 pw 3333wwww3333 �� 3333w�3w3333 �� 3333w��w3333    ?���wwww        wwwwwwww������333337������?����� �̜�w7swwww����9�3?����w�  �𙙓ww77ww�������?���www �  9�3w7ww7w����9�3?��s7w���3y�3w7�?ww3�����3��swws3   33333www33333	NumGlyphsOnClicksbSQLsaveClick  	TComboBoxcbSystemTablesLeftTopWidthQHeightHintSelect script
ItemHeightItems.Strings������ TabOrder OnChangecbSystemTablesChange   TMemomSQLLeftTopWidthEHeightAlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameLucida Console
Font.Style 
ParentFont
ScrollBarsssBothTabOrderOnChange
mSQLChange    	TTabSheet	TabSheet3Caption	File List TPanelPanel7Left Top WidthGHeight!AlignalTopCaption;All files names starting with SQL_ and have extension .SQL 
Font.ColorclNavyFont.Height�	Font.NameTimes New Roman
Font.StylefsBoldfsItalic 
ParentFontTabOrder   TPanelPanel8Left TopWidthGHeight)AlignalBottom
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder TSpeedButton
sbListSaveLeft0TopWidthHeightHint	Save ListEnabled
Glyph.Data
z  v  BMv      v   (                                       �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333 pw 3333wwww3333 �� 3333w�3w3333 �� 3333w��w3333    ?���wwww        wwwwwwww������333337������?����� �̜�w7swwww����9�3?����w�  �𙙓ww77ww�������?���www �  9�3w7ww7w����9�3?��s7w���3y�3w7�?ww3�����3��swws3   33333www33333	NumGlyphsOnClicksbListSaveClick  TSpeedButtonSpeedButton3LeftTopWidthHeightHint	Open list
Glyph.Data
z  v  BMv      v   (                                       �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333�33;3�3333�;�w{�w{�7����s3�    33wwwwww330����337�333330����337��?�330� 337�sws330����3?����?���� �ww�wssw;������7w��?�ww30�  337�swws330���3337��7�330��3337�sw�330�� ;�337��w7�3�  3�33www3w�;�3;�3;�7s37s37s�33;333;s3373337	NumGlyphsOnClickSpeedButton3Click   TMemomListLeft Top!WidthGHeight� AlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameGaramond
Font.Style 
ParentFontTabOrderOnChangemListChange    TPanelPanel1Left Top WidthHeight]AlignalLeft
BevelOuter	bvLoweredTabOrder  
TStatusBar
StatusBar1Left Top]WidthhHeightPanels SimplePanel	  TIB_DatabaseDBmainParams.StringsPASSWORD=masterkeyUSER NAME=SYSDBACHARACTER SET=WIN1251BUFFERS=100 PATH=F:\CONTROL\CREATOR\main.gdbPAGE SIZE=8192 OnConnectedChangedDBmainConnectedChangedLeft Top�   	TMainMenu	MainMenu1Left Top0 	TMenuItemN1Caption&FileShortCut  	TMenuItemN2CaptionE&xitHintExitShortCut OnClickN2Click    
TIB_Script
ScriptMainSQL.Strings"CREATE DOMAIN NAME AS VARCHAR(50);'CREATE DOMAIN SHORTNAME AS VARCHAR(25); IB_ConnectionDBmainIB_TransactionDBmain.trDBmainLeft Top`   