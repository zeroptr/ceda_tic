{*******************************************************}
{                                                       }
{       TiFontDialog Component                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iFontDialog;{$endif}
{$ifdef iCLX}unit QiFontDialog;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL}CommDlg;{$ENDIF}
  {$IFDEF iCLX}CommDlg;{$ENDIF}               

type
  TiFontDialog = class(TComponent)
  private
    FFont: TFont;
    procedure SetFont(const Value: TFont);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;
    function Execute : Boolean;
  published
    property Font : TFont read FFont write SetFont;
  end;

implementation

//****************************************************************************************************************************************************
constructor TiFontDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFont := TFont.Create;
end;
//****************************************************************************************************************************************************
destructor TiFontDialog.Destroy;
begin
  FFont.Free;
  Inherited;
end;
//****************************************************************************************************************************************************
function TiFontDialog.Execute : Boolean;
{$ifdef iVCL}
var
  ChooseFontRec    : TChooseFont;
  LogFont          : TLogFont;
  Style            : TFontStyles;
  OriginalFaceName : String;
{$endif}
begin
  {$ifdef iVCL}
  GetObject(FFont.Handle, SizeOf(LogFont), @LogFont);
  OriginalFaceName := LogFont.lfFaceName;

  ChooseFontRec.lStructSize    := SizeOf(ChooseFontRec);
  ChooseFontRec.hWndOwner      := (Owner as TWinControl).Handle;
  ChooseFontRec.lpLogFont      := @LogFont;
  ChooseFontRec.rgbColors      := FFont.Color;
  ChooseFontRec.Flags          := CF_SCREENFONTS or CF_EFFECTS or CF_INITTOLOGFONTSTRUCT;

  ChooseFontRec.hInstance      := 0;
  ChooseFontRec.lpfnHook       := nil;
  ChooseFontRec.lpTemplateName := nil;
  ChooseFontRec.nSizeMin       := 0;
  ChooseFontRec.nSizeMax       := 0;
  ChooseFontRec.hDC            := 0;
  ChooseFontRec.iPointSize     := 0;

  if ChooseFont(ChooseFontRec) then
    begin
      Result := True;

      FFont.Color  := ChooseFontRec.rgbColors;
      FFont.Name   := LogFont.lfFaceName;
      FFont.Height := LogFont.lfHeight;

      if AnsiCompareText(OriginalFaceName, LogFont.lfFaceName) <> 0 then Font.Charset := TFontCharset(LogFont.lfCharSet);

      Style := [];
      with LogFont do
      begin
        if lfWeight > FW_REGULAR then Include(Style, fsBold);
        if lfItalic <> 0         then Include(Style, fsItalic);
        if lfUnderline <> 0      then Include(Style, fsUnderline);
        if lfStrikeOut <> 0      then Include(Style, fsStrikeOut);
      end;
      FFont.Style := Style;
    end
  else Result := False;
  {$endif}
  {$ifdef iCLX}Result := False;{$endif}
end;
//****************************************************************************************************************************************************
procedure TiFontDialog.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;
//****************************************************************************************************************************************************
end.


