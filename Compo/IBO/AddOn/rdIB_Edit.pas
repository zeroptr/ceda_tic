unit rdIB_Edit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, IB_Controls;

type
  TrdIB_Edit = class(TIB_Edit)
  private
    { Private declarations }
    FActiveColor     : TColor;
    FColorHold       : TColor;
    FActiveFontColor : TColor;
    FFontColorHold   : TColor;
  protected
    { Protected declarations }
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure SetActiveColor(Value : TColor);
    procedure SetActiveFontColor(Value : TColor);
  public
    { Public declarations }
    Constructor Create(AOwner : TComponent); override;
  published
    { Published declarations }
    property ActiveColor     : TColor read FActiveColor write SetActiveColor Default clWindow;
    property ActiveFontColor : TColor read FActiveFontColor write SetActiveFontColor Default clBlack;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RDBS IBO', [TrdIB_Edit]);
end;

{ TrdIB_Edit }

constructor TrdIB_Edit.Create(AOwner: TComponent);
begin
  inherited;
  FColorHold       := Color;
  FFontColorHold   := Font.Color;

  If csDesigning in ComponentState then
  begin
    FActiveColor     := clAqua;
    FActiveFontColor := clNavy;

    Font.Style := [fsBold];
    Font.Color := clNavy;
  end;
end;

procedure TrdIB_Edit.DoEnter;
begin
  inherited;
  If Color <> FActiveColor then
  begin
    FColorHold := Color;
    Color      := FActiveColor;
    FFontColorHold := Font.Color;
    Font.Color := FActiveFontColor;
  end;
end;

procedure TrdIB_Edit.DoExit;
begin
  If FActiveColor <> FColorHold then
  begin
     Color      := FColorHold;
     Font.Color := FFontColorHold;
  end;
  inherited;
end;

procedure TrdIB_Edit.SetActiveColor(Value: TColor);
begin
  If Value <> FActiveColor then
    FActiveColor := Value;

  If (csDesigning in ComponentState) = False then
  begin
    If Focused then
    begin
      Color := FActiveColor;
      Invalidate;
    end;
  end;
end;

procedure TrdIB_Edit.SetActiveFontColor(Value: TColor);
begin
  If Value <> FActiveFontColor then
    FActiveFontColor := Value;

  If (csDesigning in ComponentState) = False then
  begin
    If Focused then
    begin
      Font.Color := FActiveFontColor;
      Invalidate;
    end;
  end;
end;

end.
