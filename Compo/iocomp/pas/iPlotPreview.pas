{*******************************************************}
{                                                       }
{       TiPlotPreview                                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotPreview;{$endif}
{$ifdef iCLX}unit QiPlotPreview;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} Printers,  iComponent,  iTypes,  iGPFunctions,  iCustomComponent,  iVCLComponent,  iEditorBasicComponents,  iCheckBox,  iRadioGroup,{$ENDIF}
  {$IFDEF iCLX}QPrinters, QiComponent, QiTypes, QiGPFunctions, QiCustomComponent, QiCLXComponent, QiEditorBasicComponents, QiCheckBox, QiRadioGroup,  {$ENDIF}

  {$IFDEF iVCL} StdCtrls,  Controls,  ComCtrls,  ExtCtrls, Classes,  Menus,  Buttons,  iPlotPreviewSettings;{$ENDIF}
  {$IFDEF iCLX}QStdCtrls, QControls, QComCtrls, QExtCtrls, Classes, QMenus, QButtons, QiPlotPreviewSettings;{$ENDIF}

type
  TiPlotPreviewForm = class(TForm)
    Panel2: TPanel;
    CloseButton: TSpeedButton;
    PrintButton: TSpeedButton;
    Preview: TiPaintBox;
    SettingsButton: TButton;
    procedure PreviewPaint(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure SettingsButtonClick(Sender: TObject);
  private
  protected
    procedure DrawPreview(OffScreen: TBitmap);
  public
    iComponent : TiComponent;

    PrintMarginLeft   : Double;
    PrintMarginTop    : Double;
    PrintMarginRight  : Double;
    PrintMarginBottom : Double;
    PrintOrientation  : TPrinterOrientation;
    PrintDocumentName : String;
    PrintSize         : Integer;
    procedure DoTranslation;
  end;

var
  iPlotPreviewForm: TiPlotPreviewForm;

implementation

uses
{$ifdef iVCL} iPlotComponent,  iPlotMasterManager;{$endif}
{$ifdef iCLX}QiPlotComponent, QiPlotMasterManager;{$endif}

type
  TiPlotComponentAccess     = class(TiPlotComponent    )end;
  TiPlotMasterManagerAccess = class(TiPlotMasterManager)end;

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiPlotPreviewForm.DrawPreview(OffScreen: TBitmap);
var
  PaperWidth      : Double;
  PaperHeight     : Double;
  TempDouble      : Double;
  OutlineWidth    : Integer;
  OutlineHeight   : Integer;
  OutlineRect     : TRect;
  DisplayWidth    : Integer;
  DisplayHeight   : Integer;
  PixelsPerInch   : Integer;
  {$ifdef iVCL}
  Picture         : TPicture;
  {$endif}
  iPlotComponent  : TiPlotComponent;
  {$ifdef iCLX}
  ABitmap         : TBitmap;
  ARect           : TRect;
  MaxZoom         : Double;
  {$endif}
  ActualPaperType : Smallint;
begin
  iPlotComponent := iComponent as TiPlotComponent;

  case PrintSize of
    0 :  ActualPaperType := iDMPAPER_LETTER;
    1 :  ActualPaperType := iDMPAPER_LEGAL;
    2 :  ActualPaperType := iDMPAPER_A3;
    3 :  ActualPaperType := iDMPAPER_A4;
    4 :  ActualPaperType := iDMPAPER_A5;
    else ActualPaperType := iDMPAPER_LETTER;
  end;

  GetPaperTypePaperSize(ActualPaperType, PaperWidth, PaperHeight);

  if PrintOrientation = poLandscape then
    begin
      TempDouble  := PaperWidth;
      PaperWidth  := PaperHeight;
      PaperHeight := TempDouble;
    end;

  if ((Preview.Width-20)/PaperWidth) < ((Preview.Height-20)/PaperHeight) then
    begin
      OutlineWidth  := Preview.Width-20;
      OutlineHeight := Round(OutlineWidth/PaperWidth*PaperHeight);
    end
  else
    begin
      OutlineHeight := Preview.Height-20;
      OutlineWidth  := Round(OutlineHeight/PaperHeight*PaperWidth);
    end;

  PixelsPerInch := Round(OutlineWidth / PaperWidth);

  DisplayWidth  := OutlineWidth  - Round(PixelsPerInch*(iPlotComponent.PrintMarginLeft + iPlotComponent.PrintMarginRight ));
  DisplayHeight := OutlineHeight - Round(PixelsPerInch*(iPlotComponent.PrintMarginTop  + iPlotComponent.PrintMarginBottom));

  with OffScreen.Canvas do
    begin
      Pen.Style   := psSolid;
      Pen.Width   := 1;
      Pen.Color   := clBlack;
      Brush.Style := bsSolid;
      Brush.Color := clBtnFace;
      FillRect(Rect(0, 0, OffScreen.Width, OffScreen.Height));

      OutlineRect := Rect(Preview.Width div 2 - OutlineWidth div 2 -5, Preview.Height div 2 - OutlineHeight div 2 -5,
                          Preview.Width div 2 + OutlineWidth div 2 -5, Preview.Height div 2 + OutlineHeight div 2 -5);

      Brush.Color := clBlack;
      OffsetRect(OutlineRect, 7, 7);
      Rectangle(OutlineRect.Left, OutlineRect.Top, OutlineRect.Right, OutlineRect.Bottom);

      Brush.Color := clWhite;
      OffsetRect(OutlineRect, -7, -7);
      Rectangle(OutlineRect.Left, OutlineRect.Top, OutlineRect.Right, OutlineRect.Bottom);
    end;

  {$ifdef iVCL}
  Picture := iPlotComponent.GetSnapShotPicture;

  if DisplayWidth/Picture.Width < DisplayHeight/Picture.Height then
    begin
      Picture.Metafile.Height := Round(DisplayWidth/Picture.Width   * Picture.Height);
      Picture.MetaFile.Width  := DisplayWidth;
    end
  else
    begin
      Picture.Metafile.Width  := Round(DisplayHeight/Picture.Height * Picture.Width);
      Picture.MetaFile.Height := DisplayHeight;
    end;

  OffScreen.Canvas.Draw(OutlineRect.Left + Round(iPlotComponent.PrintMarginLeft * PixelsPerInch),
                        OutlineRect.Top  + Round(iPlotComponent.PrintMarginTop  * PixelsPerInch ), Picture.Metafile);
  Preview.Canvas.Draw(0, 0, OffScreen);
  {$endif}

  {$ifdef iCLX}
  ABitmap := TBitmap.Create;
  try
    ABitmap.Width  := iPlotComponent.Width;
    ABitmap.Height := iPlotComponent.Height;
    TiPlotComponentAccess(iPlotComponent).iPaintTo(ABitmap.Canvas);

    if DisplayWidth/ABitmap.Width < DisplayHeight/ABitmap.Height then
      MaxZoom := DisplayWidth/ABitmap.Width
    else
      MaxZoom := DisplayHeight/ABitmap.Height;

    ARect := Rect(OutlineRect.Left + Round(iPlotComponent.PrintMarginLeft*PixelsPerInch),
                  OutlineRect.Top  + Round(iPlotComponent.PrintMarginTop *PixelsPerInch),
                  OutlineRect.Left + Round(iPlotComponent.PrintMarginLeft*PixelsPerInch + MaxZoom*ABitmap.Width),
                  OutlineRect.Top  + Round(iPlotComponent.PrintMarginTop *PixelsPerInch + MaxZoom*ABitmap.Height));
    OffScreen.Canvas.StretchDraw(ARect, ABitmap);
  finally
    ABitmap.Free;
  end;
  {$endif}
end;
//****************************************************************************************************************************************************
procedure TiPlotPreviewForm.PreviewPaint(Sender: TObject);
var
  ToolBarWasVisible : Boolean;
  OffScreenBitmap   : TBitmap;
  iPlotComponent    : TiPlotComponent;
begin
  iPlotComponent := iComponent as TiPlotComponent;

  OffScreenBitmap := TBitmap.Create;
  try
    OffScreenBitmap.Width  := Preview.Width;
    OffScreenBitmap.Height := Preview.Height;

    with OffScreenBitmap.Canvas do
      begin
        Pen.Style   := psSolid;
        Pen.Width   := 1;
        Pen.Color   := clBlack;
        Brush.Style := bsSolid;
        Brush.Color := clBtnFace;
        FillRect(ClipRect);
      end;

    ToolBarWasVisible  := iPlotComponent.ToolBar[0].Visible;

    iPlotComponent.ToolBar[0].Visible := False;
    if Assigned((iComponent as TiPlotComponent).OnBeforePrint) then (iComponent as TiPlotComponent).OnBeforePrint(Self);

    DrawPreview(OffScreenBitmap);

    Preview.Canvas.Draw(0, 0, OffScreenBitmap);

    iPlotComponent.ToolBar[0].Visible := ToolBarWasVisible;
    if Assigned((iComponent as TiPlotComponent).OnAfterPrint) then (iComponent as TiPlotComponent).OnAfterPrint(Self);

  finally
    OffScreenBitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotPreviewForm.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;
//****************************************************************************************************************************************************
procedure TiPlotPreviewForm.PrintButtonClick(Sender: TObject);
begin
  (iComponent as TiPlotComponent).PrintChart;
  Preview.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotPreviewForm.SettingsButtonClick(Sender: TObject);
begin
  iPlotPreviewSettingsForm := TiPlotPreviewSettingsForm.Create(Application);
  try
    iPlotPreviewSettingsForm.PrintMarginLeftEdit.AsFloat          := PrintMarginLeft;
    iPlotPreviewSettingsForm.PrintMarginTopEdit.AsFloat           := PrintMarginTop;
    iPlotPreviewSettingsForm.PrintMarginRightEdit.AsFloat         := PrintMarginRight;
    iPlotPreviewSettingsForm.PrintMarginBottomEdit.AsFloat        := PrintMarginBottom;

    iPlotPreviewSettingsForm.PrintOrientationRadioGroup.AsInteger := ord(PrintOrientation);
    iPlotPreviewSettingsForm.PrintDocumentNameEdit.AsString       := PrintDocumentName;
    iPlotPreviewSettingsForm.PrintPaperSizeComboBox.AsInteger     := PrintSize;

    TiPlotMasterManagerAccess(TiPlotComponentAccess(iComponent).Master).DoTranslation(iPlotPreviewSettingsForm);


    if iPlotPreviewSettingsForm.ShowModal = mrOK then
      begin
        PrintMarginLeft   := iPlotPreviewSettingsForm.PrintMarginLeftEdit.AsFloat;
        PrintMarginTop    := iPlotPreviewSettingsForm.PrintMarginTopEdit.AsFloat;
        PrintMarginRight  := iPlotPreviewSettingsForm.PrintMarginRightEdit.AsFloat;
        PrintMarginBottom := iPlotPreviewSettingsForm.PrintMarginBottomEdit.AsFloat;       

        PrintOrientation  := TPrinterOrientation(iPlotPreviewSettingsForm.PrintOrientationRadioGroup.AsInteger);
        PrintDocumentName := iPlotPreviewSettingsForm.PrintDocumentNameEdit.AsString;
        PrintSize         := iPlotPreviewSettingsForm.PrintPaperSizeComboBox.AsInteger;

        (iComponent as TiPlotComponent).PrintMarginLeft   := PrintMarginLeft;
        (iComponent as TiPlotComponent).PrintMarginTop    := PrintMarginTop;
        (iComponent as TiPlotComponent).PrintMarginRight  := PrintMarginRight;
        (iComponent as TiPlotComponent).PrintMarginBottom := PrintMarginBottom;
        (iComponent as TiPlotComponent).PrintOrientation  := PrintOrientation;
        (iComponent as TiPlotComponent).PrintDocumentName := PrintDocumentName;
         Caption                                          := PrintDocumentName + ' (Preview)';

        Preview.Invalidate;
      end;
  finally
    iPlotPreviewSettingsForm.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotPreviewForm.DoTranslation;
begin
  TiPlotMasterManagerAccess(TiPlotComponentAccess(iComponent).Master).DoTranslation(Self);
end;
//****************************************************************************************************************************************************
end.
