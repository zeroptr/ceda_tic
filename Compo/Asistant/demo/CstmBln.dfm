�
 TCUSTOMBALLOON 0�  TPF0TCustomBalloonCustomBalloonLeft� TopkWidth`Height!CaptionCustomBalloonFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PixelsPerInch`
TextHeight TPanelPanel1Left6Top&Width�Height�
BevelOuterbvNoneParentColor	TabOrder  TLabelLabel1LeftTop4Width�Height0Caption�  1. Create a new form.

2. Add oaBaloon to interface uses clause of the unit.

3. Change the form class ancestor from TForm to TAssistantBalloon.

4. Drop one and only one TPanel control on the form.
   At run-time, the balloon's size will be set to the Panel's size.

5. Set the Panel's properties as below:

      ParentColor := True;
      BevelOuter := bvNone;
      Caption := EmptyStr;

6. Instead of the form, put the other controls on the Panel.Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFontShowAccelCharTransparent	  TLabelLabel0LeftTop
Width� HeightCaptionTo create a custom balloon:Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFontShowAccelCharTransparent	  TLabelLabel2LeftSTopZWidth6HeightCaptionoaBaloonFont.CharsetDEFAULT_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFontShowAccelCharTransparent	  TLabelLabel3Left'Top� Width(HeightCaptionTFormFont.CharsetDEFAULT_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFontShowAccelCharTransparent	  TLabelLabel4LefthTop� WidthoHeightCaptionTAssistantBalloonFont.CharsetDEFAULT_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFontShowAccelCharTransparent	  TLabelLabel5Left� Top� Width)HeightCaptionTPanelFont.CharsetDEFAULT_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFontShowAccelCharTransparent	  TBevelBevel1LeftTopwWidth�HeightShapebsFrame  TLabelLabel6LeftjTop� Width HeightCaptionPanelFont.CharsetDEFAULT_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFontShowAccelCharTransparent	  TLabelLabel7Left�TopQWidth HeightCaptionPanelFont.CharsetDEFAULT_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFontShowAccelCharTransparent	  TLabelLabel8LeftxTop� Width HeightCaptionPanelFont.CharsetDEFAULT_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameComic Sans MS
Font.StylefsBold 
ParentFontShowAccelCharTransparent	  TOffice97ButtonOffice97Button1Left� Top�Width^Height!Cancel	CaptionCloseColor��� Default	Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style HoverFont.CharsetDEFAULT_CHARSETHoverFont.ColorclWindowTextHoverFont.Height�HoverFont.NameMS Sans SerifHoverFont.StylefsBold ModalResult
ParentFontTabOrder WordWrapOnClickOffice97Button1Click    