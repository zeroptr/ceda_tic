�
 TFORMDBTREE 0�  TPF0TFormDBTree
FormDBTreeLeft� Top� ActiveControlButton1BorderIconsbiSystemMenu
biMinimize BorderStylebsDialogCaptionDatabase Tree WizardClientHeight@ClientWidth<Color	clBtnFace
ParentFont	OldCreateOrder	PositionpoScreenCenterOnCreate
FormCreate	OnDestroyFormDestroyOnShowFormShowPixelsPerInch`
TextHeight TPanelPanel4Left� Top WidtheHeightTabOrder TLabelLabel8LeftTopWidth>HeightCaptionSample data:  TLabelLabel9Left� TopWidthBHeightCaptionTree Preview:  TMemoMemo1LeftTop Width� Height� Lines.StringsCode 	Parent	 Text!------ 	----------- 	------------  1     	0    	Continents  2     	1      	America  3     	1      	Africa  4     	1      	Australia  5     	2        	USA  6     	5          	California  7     	4        	Sydney TabOrder WantTabs	  TMemoMemo3LeftTop Width� Height� Lines.StringsCountry      	City----------   		---------------AUSTRALIA    	SydneyUSA          	New YorkUK           	LondonAUSTRALIA    	CamberraUK           	ManchesterUK           	LiverpoolUSA          	MichiganUSA          	Chicago TabOrder  TMemoMemo5LeftTop Width� Height� TabStopLines.Strings  Person   Department  -------  --------------  John     Accounting  Chris    Management  Anne     Sales   Person  Month  Salary  ------- ------ ----------   John    April  $1000   Chris   March  $900   Chris   April  $700   Anne  June  $500 ReadOnly	TabOrder  TTreeTreePreviewLeft� Top Width� Height� AllowPanning
pmVerticalAnimatedZoomStepsZoom.AnimatedStepsParentShowHintShowHintTabOrder TTreeNodeShape
TreeShape1Border.Visible
Image.Data
�   TBitmap�   BM�       v   (               h                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ��      �wwwwwp �����p ������ ������ �����w ����p� wwwwww� ������� ������� ����www���������ww����Transparent	X0Y0 Expanded	
ImageIndextiNoneText.Strings
Continents   TTreeNodeShape
TreeShape2Border.Visible
Image.Data
�   TBitmap�   BM�       v   (               h                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �       wwwwwww ������ ������ ������ ������ ������ ������ ������ ������ x���www����������ww����Transparent	
ImageIndextiNoneParent
TreeShape1Text.StringsAmerica   TTreeNodeShape
TreeShape3Border.Visible
Image.Data
�   TBitmap�   BM�       v   (               h                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �       wwwwwww ������ ������ ������ ������ ������ ������ ������ ������ x���www����������ww����Transparent	
ImageIndextiNoneParent
TreeShape1Text.StringsAfrica   TTreeNodeShape
TreeShape4Border.Visible
Image.Data
�   TBitmap�   BM�       v   (               h                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �       wwwwwww ������ ������ ������ ������ ������ ������ ������ ������ x���www����������ww����Transparent	
ImageIndextiNoneParent
TreeShape1Text.Strings	Australia   TTreeConnectionTreeShape1_TreeShape2	FromShape
TreeShape1ToShape
TreeShape2  TTreeConnectionTreeShape1_TreeShape3	FromShape
TreeShape1ToShape
TreeShape3  TTreeConnectionTreeShape1_TreeShape4	FromShape
TreeShape1ToShape
TreeShape4    TPanelPanel3Left� Top WidthfHeightTabOrder TLabelLabel2LeftTopWidthUHeight	AlignmenttaRightJustifyAutoSizeCaption	&Dataset:  TLabelLabel3LeftTop2WidthUHeight	AlignmenttaRightJustifyAutoSizeCaption&Code field:  TLabelLabel4LeftTopRWidthUHeight	AlignmenttaRightJustifyAutoSizeCaption&Parent field:  TLabelLabel5LeftTopsWidthUHeight	AlignmenttaRightJustifyAutoSizeCaption&Text fields:  TLabelLabel6LeftTop� WidthUHeight	AlignmenttaRightJustifyAutoSizeCaptionDetail &Dataset:  TLabelLabel7LeftTop� WidthUHeight	AlignmenttaRightJustifyAutoSizeCaptionDetail fields:  
TComboFlat	CBDataSetLeftaTopWidth� DropDownCountTabOrder OnChangeCBDataSetChange  
TComboFlat	ComboBox2LeftaTop.Width� TabOrderOnChangeComboBox2Change  
TComboFlat	ComboBox3LeftaTopNWidth� TabOrderOnChangeComboBox3Change  
TComboFlat	ComboBox4LeftaTopoWidth� Style
csDropDownTabOrderOnChangeComboBox4Change  
TComboFlat	ComboBox5LeftaTop� Width� TabOrderOnChangeComboBox5Change  
TComboFlat	ComboBox6LeftaTop� Width� Style
csDropDownTabOrderOnChangeComboBox6Change  TButtonButton4Left+TopoWidthHeightCaption...TabOrderOnClickButton4Click  TButtonButton5Left+Top� WidthHeightCaption...TabOrderOnClickButton5Click  TButtonButton7Left+TopNWidthHeightCaption...TabOrderOnClickButton7Click  	TCheckBox	CheckBox1Left	Top� WidthXHeightCaptionMulti-line textChecked	State	cbCheckedTabOrder	OnClickCheckBox1Click  TButtonBNewDataSetLeft+TopWidth,HeightCaption...TabOrder
Visible  TButtonButton6LeftbTop� WidthKHeightCaption
&Format...TabOrderOnClickButton6Click  TButtonButton8Left� Top� WidthKHeightCaption
&Header...TabOrderOnClickButton8Click  TButtonButton9LeftbTop� WidthKHeightCaption
&Format...TabOrderOnClickButton9Click  TButtonButton10Left� Top� WidthKHeightCaption
&Header...TabOrderOnClickButton10Click   TPanelPanel1Left TopWidth<Height)AlignalBottomTabOrder  TButtonButton1Left� TopWidthKHeightCaption&Next >Default	TabOrder OnClickButton1Click  TButtonButton2Left� TopWidthKHeightCaption< &PreviousEnabledTabOrderOnClickButton2Click  TButtonButton3Left�TopWidthKHeightCancel	Caption&CancelTabOrderOnClickButton3Click  TButtonBApplyLeft�TopWidthKHeightCaption&ApplyEnabledTabOrderOnClickBApplyClick   TPanelPanel2Left Top Width� HeightAlignalLeftTabOrder TLabelLabel1LeftTopWidthnHeightCaptionChoose a situation:Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TRadioButtonRadioButton1LeftTop8WidthHeightTabOrder OnClickRadioButton1Click  TMemoMemo2Left(Top8Width� Height)CursorcrHandPointTabStopBorderStylebsNoneColor	clBtnFaceLines.Strings One dataset with a "Code" field $and a "Parent" field pointing to it. ReadOnly	TabOrderOnClick
Memo2Click  TRadioButtonRadioButton2LeftToppWidthHeightTabOrderOnClickRadioButton2Click  TMemoMemo4Left(ToppWidth� Height)CursorcrHandPointTabStopBorderStylebsNoneColor	clBtnFaceLines.StringsOne dataset with optionalgroup-by fields.  ReadOnly	TabOrderOnClick
Memo4Click  TRadioButtonRadioButton3LeftTop� WidthHeightTabOrderOnClickRadioButton3Click  TMemoMemo6Left(Top� Width� Height)CursorcrHandPointTabStopBorderStylebsNoneColor	clBtnFaceLines.Strings A master-detail pair of datasetsforming a tree. ReadOnly	TabOrderOnClick
Memo6Click    