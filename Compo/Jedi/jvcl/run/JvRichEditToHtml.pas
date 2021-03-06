{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvRichEditToHtml.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse att buypin dott com]
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com],
                Andreas Hausladen [Andreas dott Hausladen att gmx dott de].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvRichEditToHtml.pas 12015 2008-11-01 23:55:28Z ahuser $

unit JvRichEditToHtml;

{$I jvcl.inc}
{$I windowsonly.inc}

interface

uses
 Windows,
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  SysUtils, Classes, Graphics, Forms, ComCtrls,
  JvRgbToHtml, JvStrToHtml, JvRichEdit, JvComponentBase, JclStrings;

type
  TJvParaAttributesRec = record
    Alignment: TAlignment;
    Numbering: TNumberingStyle;
  end;

  TJvRichEditParaAttributesRec = record
    Alignment: TParaAlignment;
    Numbering: TJvNumbering;
  end;

  TFontInfo = class(TPersistent)
  private
    FFontData: TFontData;
    FColor: TColor;
    FPixelsPerInch: Integer;
    FLink: Boolean;
    function GetSize: Integer;
    procedure SetSize(const Value: Integer);
  public
    constructor Create(APixelsPerInch: Integer);
    procedure Assign(Source: TPersistent); override;
    property Color: TColor read FColor write FColor;
    property Link: Boolean read FLink write FLink;

    property Size: Integer read GetSize write SetSize;
    property Height: Integer read FFontData.Height write FFontData.Height;
    property Pitch: TFontPitch read FFontData.Pitch write FFontData.Pitch;
    property Style: TFontStylesBase read FFontData.Style write FFontData.Style;
    property Charset: TFontCharset read FFontData.Charset write FFontData.Charset;
    property Name: TFontDataName read FFontData.Name write FFontData.Name;
  end;

  TJvRichEditToHtml = class(TJvComponent)
  private
    FCToH: TJvRgbToHtml;
    FCharToH: TJvStrToHtml;
    FEndSection: string;
    FEndPara: string;
    FTitle: string;
    FFooter: TStringList;
    FHeader: TStringList;
    function AttToHtml(Value: TFontInfo): string;
    function ParaToHtml(Value: TJvParaAttributesRec): string;overload;
    function ParaToHtml(Value: TJvRichEditParaAttributesRec): string;overload;
    function GetFooter: TStrings;
    function GetHeader: TStrings;
    procedure SetFooter(const Value: TStrings);
    procedure SetHeader(const Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ConvertToHtml(Value: TRichEdit; const FileName: string);overload;
    procedure ConvertToHtml(Value: TJvRichEdit; const FileName: string);overload;
    procedure ConvertToHtmlStrings(Value: TRichEdit; Strings: TStrings);overload;
    procedure ConvertToHtmlStrings(Value: TJvRichEdit; Strings: TStrings);overload;
  published
    property Title: string read FTitle write FTitle;
    property Header: TStrings read GetHeader write SetHeader;
    property Footer: TStrings read GetFooter write SetFooter;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/run/JvRichEditToHtml.pas $';
    Revision: '$Revision: 12015 $';
    Date: '$Date: 2008-11-02 00:55:28 +0100 (dim., 02 nov. 2008) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

{$IFNDEF COMPILER12_UP}
uses
  JvJCLUtils;
{$ENDIF ~COMPILER12_UP}

const
  // (rom) needs renaming?
//  cHTMLHeadBegin = '<HTML>';
//  cHTMLBodyBegin = '<BODY>';
//  cHTMLBodyEnd = '</BODY>';
//  cHTMLEnd = '</HTML>';
//  cHTMLTitleFmt = '<TITLE>%s</TITLE>';

  cHTMLBR = '<BR>';
//  cHTMLFontColorBegin = '<FONT COLOR=#';
//  cHTMLSize = ' SIZE=';
//  cHTMLFace = ' FACE="';
  cHTMLFontEnd = '</SPAN>';

  cHTMLBoldBegin = '<B>';
  cHTMLBoldEnd = '</B>';

  cHTMLItalicBegin = '<I>';
  cHTMLItalicEnd = '</I>';

  cHTMLStrikeoutBegin = '<STRIKE>';
  cHTMLStrikeoutEnd = '</STRIKE>';

  cHTMLUnderlineBegin = '<U>';
  cHTMLUnderlineEnd = '</U>';

  cHTMLParaEnd = '</P>';
  cHTMLParaLeft = '<P ALIGN="LEFT">';
  cHTMLParaRight = '<P ALIGN="RIGHT">';
  cHTMLParaCenter = '<P ALIGN="CENTER">';

  cHTMLListBegin = '<LI>';
  cHTMLListEnd = '</LI>';

//=== { TFontInfo } ==========================================================

constructor TFontInfo.Create(APixelsPerInch: Integer);
begin
  inherited Create;
  FPixelsPerInch := APixelsPerInch;
end;

procedure TFontInfo.Assign(Source: TPersistent);
begin
  if Source is TTextAttributes then
  begin
    FFontData.Name := TFontDataName(TTextAttributes(Source).Name);
    FFontData.Height := TTextAttributes(Source).Height;
    FFontData.Pitch := TTextAttributes(Source).Pitch;
    FFontData.Style := TTextAttributes(Source).Style;
    FFontData.Charset := TTextAttributes(Source).Charset;
    FColor := TTextAttributes(Source).Color;
    FLink := False;
  end
  else
  if Source is TJvTextAttributes then
  begin
    FFontData.Name := TFontDataName(TJvTextAttributes(Source).Name);
    FFontData.Height := TJvTextAttributes(Source).Height;
    FFontData.Pitch := TJvTextAttributes(Source).Pitch;
    FFontData.Style := TJvTextAttributes(Source).Style;
    FFontData.Charset := TJvTextAttributes(Source).Charset;
    FColor := TJvTextAttributes(Source).Color;
    FLink := TJvTextAttributes(Source).Link;
  end
  else
  if Source is TFontInfo then
  begin
    FFontData := TFontInfo(Source).FFontData;
    FColor := TFontInfo(Source).FColor;
    FLink := TFontInfo(Source).FLink;
  end
  else
    inherited Assign(Source);
end;

function TFontInfo.GetSize: Integer;
begin
  Result := -MulDiv(Height, 72, FPixelsPerInch);
end;

procedure TFontInfo.SetSize(const Value: Integer);
begin
  FFontData.Height := -MulDiv(Value, FPixelsPerInch, 72);
end;

//=== { TJvRichEditToHtml } ==================================================

constructor TJvRichEditToHtml.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCToH := TJvRgbToHtml.Create(Self);
  FCharToH := TJvStrToHtml.Create(Self);
  FHeader := TStringList.Create;
  FHeader.Add('<HTML>');
  FHeader.Add('  <HEAD>');
  FHeader.Add('    <TITLE><#TITLE></TITLE>');
  FHeader.Add('  </HEAD>');
  FHeader.Add('  <BODY>');

  FFooter := TStringList.Create;
  FFooter.Add('  </BODY>');
  FFooter.Add('</HTML>');
end;

destructor TJvRichEditToHtml.Destroy;
begin
  FCToH.Free;
  FCharToH.Free;
  FHeader.Free;
  FFooter.Free;
  inherited Destroy;
end;

procedure TJvRichEditToHtml.ConvertToHtml(Value: TRichEdit; const FileName: string);
var
  S: TStringList;
begin
  S := TStringList.Create;
  try
    ConvertToHtmlStrings(Value, S);
    S.SaveToFile(FileName);
  finally
    S.Free;
  end;
end;

function TJvRichEditToHtml.AttToHtml(Value: TFontInfo): string;
var
  Size: Integer;
begin
  FEndSection := cHTMLFontEnd;
  FCToH.RgbColor := Value.Color;

  Size := Abs(Value.Size);
  if Size = 0 then
    Size := 8;
  Result := Format('<SPAN style="color: #%s; font-size: %dpt; font-family: %s;">',
    [FCToH.HtmlColor, Size, Value.Name]);
  if fsBold in Value.Style then
  begin
    FEndSection := cHTMLBoldEnd + FEndSection;
    Result := Result + cHTMLBoldBegin;
  end;
  if fsItalic in Value.Style then
  begin
    FEndSection := cHTMLItalicEnd + FEndSection;
    Result := Result + cHTMLItalicBegin;
  end;
  if fsStrikeout in Value.Style then
  begin
    FEndSection := cHTMLStrikeoutEnd + FEndSection;
    Result := Result + cHTMLStrikeoutBegin;
  end;
  if fsUnderline in Value.Style then
  begin
    FEndSection := cHTMLUnderlineEnd + FEndSection;
    Result := Result + cHTMLUnderlineBegin;
  end;

//  if Value.Link then
//  begin
//    FEndSection := '</a>' + FEndSection;
//    Result := Result + '<a href="#">';
//  end;
end;

function Diff(One, Two: TFontInfo): Boolean;
begin
  Result := (One.Color <> Two.Color) or (One.Style <> Two.Style) or
    (One.Name <> Two.Name) or (One.Size <> Two.Size) or
    (One.Link <> Two.Link);
end;

function DiffPara(One, Two: TJvParaAttributesRec): Boolean;overload;
begin
  Result := (One.Alignment <> Two.Alignment) or (One.Numbering <> Two.Numbering);
end;

function DiffPara(One, Two: TJvRichEditParaAttributesRec): Boolean;overload;
begin
  Result := (One.Alignment <> Two.Alignment) or (One.Numbering <> Two.Numbering);
end;

procedure TJvRichEditToHtml.ConvertToHtml(Value: TJvRichEdit; const FileName: string);
var
  S: TStringList;
begin
  S := TStringList.Create;
  try
    ConvertToHtmlStrings(Value, S);
    S.SaveToFile(FileName);
  finally
    S.Free;
  end;
end;

procedure TJvRichEditToHtml.ConvertToHtmlStrings(Value: TRichEdit; Strings: TStrings);
var
  I, J: Integer;
  Datt, Att, CurrAt: TFontInfo;
  DPara, Para, CurrPara: TJvParaAttributesRec;
  St: TStringBuilder;
  FEnd: string;
  LOnChange: TNotifyEvent;
  LOnSelectionChange: TNotifyEvent;
  Text: string;
  Len: Integer;
begin
  LOnChange := Value.OnChange;
  LOnSelectionChange := Value.OnSelectionChange;
  Strings.BeginUpdate;
  Value.Lines.BeginUpdate;
  try
    Value.OnChange := nil;
    Value.OnSelectionChange := nil;

    Strings.Clear;
    if Header.Count > 0 then
      Strings.Add(StringReplace(Header.Text, '<#TITLE>', Title, [rfReplaceAll]));
    Datt := TFontInfo.Create(Value.Font.PixelsPerInch);
    Att := TFontInfo.Create(Value.Font.PixelsPerInch);
    CurrAt := TFontInfo.Create(Value.Font.PixelsPerInch);

    DPara.Alignment := taLeftJustify;
    DPara.Numbering := ComCtrls.nsNone;
    CurrPara.Alignment := DPara.Alignment;
    CurrPara.Numbering := DPara.Numbering;
    Strings.Add(ParaToHtml(Para));

    Datt.Assign(Value.DefAttributes);
    Strings.Add(AttToHtml(Datt));

    CurrAt.Assign(Datt);
    Value.SelStart := 0;
    Value.SelectAll;
    Text := Value.SelText;
    Len := Length(Text);
    St := TStringBuilder.Create;
    try
      I := 1;
      Value.SelLength := 1;
      while I <= Len do
      begin
        // new line
        Value.SelStart := I - 1;
        Att.Assign(Value.SelAttributes);
        Para.Alignment := Value.Paragraph.Alignment;
        Para.Numbering := Value.Paragraph.Numbering;

        St.Length := 0;
        if DiffPara(Para, CurrPara) or (Para.Numbering = ComCtrls.nsBullet) then
        begin
          St.Append(FEndSection).Append(FEndPara);
          CurrPara.Alignment := Para.Alignment;
          CurrPara.Numbering := Para.Numbering;
          CurrAt.Assign(Att);
          St.Append(ParaToHtml(Para)).Append(AttToHtml(Att));
        end;

        J := I;
        while (J <= Len) and not CharInSet(Text[J], [#$A, #$B, #$D]) do { RICHEDIT uses #$B also for line breaking }
        begin
          Att.Assign(Value.SelAttributes);
          if Diff(Att, CurrAt) then
          begin
            St.Append(FEndSection);
            CurrAt.Assign(Att);
            St.Append(AttToHtml(Att));
            Value.SelStart := J;
          end
          else
          begin
            if CharInSet(Text[J], ['A'..'Z', 'a'..'z', '0'..'9']) then
              St.Append(Text[J])
            else
              St.Append(CharToHtml(Text[J]));
            Inc(J);
            Value.SelStart := J;
          end;
        end;
        if I = 1 then
          Strings.Add(St.ToString())
        else
          Strings.Add(cHTMLBR + St.ToString());
        I := J + 1;
      end;
    finally
      St.Free;
    end;
    Strings.Add(FEndSection);
    Strings.Add(FEndPara);

    Datt.Free;
    Att.Free;
    CurrAt.Free;

    Strings.Add(FEnd);
    Strings.AddStrings(Footer);
  finally
    Value.OnChange := LOnChange;
    Value.OnSelectionChange := LOnSelectionChange;
    Strings.EndUpdate;
    Value.Lines.EndUpdate;
  end;
end;

procedure TJvRichEditToHtml.ConvertToHtmlStrings(Value: TJvRichEdit; Strings: TStrings);
var
  I, J: Integer;
  Datt, Att, CurrAt: TFontInfo;
  DPara, Para, CurrPara: TJvRichEditParaAttributesRec;
  St: TStringBuilder;
  FEnd: string;
  LOnChange: TNotifyEvent;
  LOnSelectionChange: TNotifyEvent;
  Text: string;
  Len: Integer;
begin
  LOnChange := Value.OnChange;
  LOnSelectionChange := Value.OnSelectionChange;
  Strings.BeginUpdate;
  Value.Lines.BeginUpdate;
  try
    Value.OnChange := nil;
    Value.OnSelectionChange := nil;

    Strings.Clear;
    if Header.Count > 0 then
      Strings.Add(StringReplace(Header.Text, '<#TITLE>', Title, [rfReplaceAll]));
    Datt := TFontInfo.Create(Value.Font.PixelsPerInch);
    Att := TFontInfo.Create(Value.Font.PixelsPerInch);
    CurrAt := TFontInfo.Create(Value.Font.PixelsPerInch);

    DPara.Alignment := paLeftJustify;
    DPara.Numbering := nsNone;
    CurrPara.Alignment := DPara.Alignment;
    CurrPara.Numbering := DPara.Numbering;
    Strings.Add(ParaToHtml(Para));

    Datt.Assign(Value.DefAttributes);
    Strings.Add(AttToHtml(Datt));

    CurrAt.Assign(Datt);
    Value.SelStart := 0;
    Value.SelectAll;
    Text := Value.SelText;
    Len := Length(Text);
    St := TStringBuilder.Create;
    try
      I := 1;
      Value.SelLength := 1;
      while I <= Len do
      begin
        // new line
        Value.SelStart := I - 1;
        Att.Assign(Value.SelAttributes);
        Para.Alignment := Value.Paragraph.Alignment;
        Para.Numbering := Value.Paragraph.Numbering;

        St.Length := 0;
        if DiffPara(Para, CurrPara) or (Para.Numbering = nsBullet) then
        begin
          St.Append(FEndSection).Append(FEndPara);
          CurrPara.Alignment := Para.Alignment;
          CurrPara.Numbering := Para.Numbering;
          CurrAt.Assign(Att);
          St.Append(ParaToHtml(Para)).Append(AttToHtml(Att));
        end;

        J := I;
        while (J <= Len) and not CharInSet(Text[J], [#$A, #$B, #$D]) do { RICHEDIT uses #$B also for line breaking }
        begin
          Att.Assign(Value.SelAttributes);
          if Diff(Att, CurrAt) then
          begin
            St.Append(FEndSection);
            CurrAt.Assign(Att);
            St.Append(AttToHtml(Att));
          end;

          if CharInSet(Text[J], ['A'..'Z', 'a'..'z', '0'..'9']) then
            St.Append(Text[J])
          else
            St.Append(CharToHtml(Text[J]));
          Inc(J);
          Value.SelStart := J - 1;
        end;
        if I = 1 then
          Strings.Add(St.ToString())
        else
          Strings.Add(cHTMLBR + St.ToString());
        I := J + 1;
      end;
    finally
      St.Free;
    end;
    Strings.Add(FEndSection);
    Strings.Add(FEndPara);

    Datt.Free;
    Att.Free;
    CurrAt.Free;

    Strings.Add(FEnd);
    Strings.AddStrings(Footer);
  finally
    Value.OnChange := LOnChange;
    Value.OnSelectionChange := LOnSelectionChange;
    Strings.EndUpdate;
    Value.Lines.EndUpdate;
  end;
end;

function TJvRichEditToHtml.ParaToHtml(Value: TJvRichEditParaAttributesRec): string;
begin
  case Value.Alignment of
    paLeftJustify:
      Result := 'ALIGN="LEFT"';
    paRightJustify:
      Result := 'ALIGN="RIGHT"';
    paCenter:
      Result := 'ALIGN="CENTER"';
  end;
  if Value.Numbering = nsBullet then
  begin
    Result := '<LI ' + Result + '>';
    FEndPara := '</LI>';
  end
  else
  begin
    Result := '<P ' + Result + '>';
    FEndPara := '</P>';
  end
end;

function TJvRichEditToHtml.ParaToHtml(Value: TJvParaAttributesRec): string;
begin
  case Value.Alignment of
    Classes.taLeftJustify:
      Result := 'ALIGN="LEFT"';
    Classes.taRightJustify:
      Result := 'ALIGN="RIGHT"';
    Classes.taCenter:
      Result := 'ALIGN="CENTER"';
  end;
  if Value.Numbering = ComCtrls.nsBullet then
  begin
    Result := '<LI ' + Result + '>';
    FEndPara := '</LI>';
  end
  else
  begin
    Result := '<P ' + Result + '>';
    FEndPara := '</P>';
  end
end;

function TJvRichEditToHtml.GetFooter: TStrings;
begin
  Result := FFooter;
end;

function TJvRichEditToHtml.GetHeader: TStrings;
begin
  Result := FHeader;
end;

procedure TJvRichEditToHtml.SetFooter(const Value: TStrings);
begin
  FFooter.Assign(Value);
end;

procedure TJvRichEditToHtml.SetHeader(const Value: TStrings);
begin
  FHeader.Assign(Value);
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

