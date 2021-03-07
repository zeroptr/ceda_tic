{*******************************************************}
{                                                       }
{       TiColorDialog Component                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iColorDialog;{$endif}
{$ifdef iCLX}unit QiColorDialog;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL}CommDlg;{$ENDIF}
  {$IFDEF iCLX}CommDlg;{$ENDIF}

type
  TiColorDialog = class(TComponent)            
  private
    FColor          : TColor;
    procedure SetColor(const Value: TColor);
  protected
  public
    function Execute : Boolean;
  published
    property Color : TColor read FColor write SetColor;
  end;

implementation

//****************************************************************************************************************************************************
function TiColorDialog.Execute : Boolean;
{$ifdef iVCL}
var
  ChooseColorRec    : TChooseColor;
  CustomColorsArray : array[0..15] of Longint;
  x                 : Integer;
{$endif}
begin
  {$ifdef iCLX}Result := False;{$endif}
  {$ifdef iVCL}
  FillChar(ChooseColorRec, SizeOf(ChooseColorRec), 0);
  for x := 0 to 15 do CustomColorsArray[x] := $FFFFFF;
  ChooseColorRec.lStructSize  := SizeOf(ChooseColorRec);
  ChooseColorRec.hWndOwner    := (Owner as TWinControl).Handle;
  ChooseColorRec.lpCustColors := @CustomColorsArray;
  ChooseColorRec.rgbResult    := ColorToRGB(FColor);
  ChooseColorRec.Flags        := CC_RGBINIT;

  if ChooseColor(ChooseColorRec) then
    begin
      Result := True;
      FColor := ChooseColorRec.rgbResult;
    end
  else Result := False;
  {$endif}
end;
//****************************************************************************************************************************************************
procedure TiColorDialog.SetColor(const Value: TColor);
begin
  if FColor <> Value then
    begin
      FColor := Value;
    end;
end;
//****************************************************************************************************************************************************
end.
