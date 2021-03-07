{*****************************************}
{   TeeChart Margins Editor               }
{   Copyright (c) 2009 by Steema Software }
{*****************************************}
unit TeeMargins;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls,
     {$ENDIF}
     TeCanvas, TeeProcs, TeEngine;

type
  TMarginsEditor = class(TForm)
    RGUnits: TRadioGroup;
    Label1: TLabel;
    ELeft: TEdit;
    UDLeft: TUpDown;
    Label2: TLabel;
    ETop: TEdit;
    UDTop: TUpDown;
    Label3: TLabel;
    ERight: TEdit;
    UDRight: TUpDown;
    Label4: TLabel;
    EBottom: TEdit;
    UDBottom: TUpDown;
    procedure RGUnitsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ELeftChange(Sender: TObject);
    procedure ETopChange(Sender: TObject);
    procedure ERightChange(Sender: TObject);
    procedure EBottomChange(Sender: TObject);
  private
    { Private declarations }
    Margins : TMargins;
  public
    { Public declarations }
    procedure RefreshControls(const AMargins:TMargins);
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TMarginsEditor.RGUnitsClick(Sender: TObject);
begin
  case RGUnits.ItemIndex of
     0: Margins.Units:=maPercentFont;
     1: Margins.Units:=maPercentSize;
  else
     Margins.Units:=maPixels;
  end;
end;

procedure TMarginsEditor.FormShow(Sender: TObject);
var tmp : TMargins;
begin
  tmp:=TMargins(Tag);

  if Assigned(tmp) then
  begin
    Margins:=tmp;
    RefreshControls(Margins);
  end;

  TeeTranslateControl(Self);  
end;

procedure TMarginsEditor.RefreshControls(const AMargins:TMargins);
begin
  Margins:=AMargins;

  case Margins.Units of
    maPercentFont : RGUnits.ItemIndex:=0;
    maPercentSize : RGUnits.ItemIndex:=1;
  else
     RGUnits.ItemIndex:=2;
  end;

  RGUnitsClick(Self);

  UDLeft.Position:=Margins.Left;
  UDTop.Position:=Margins.Top;
  UDRight.Position:=Margins.Right;
  UDBottom.Position:=Margins.Bottom;
end;

procedure TMarginsEditor.ELeftChange(Sender: TObject);
begin
  if Showing then
     Margins.Left:=UDLeft.Position;
end;

procedure TMarginsEditor.ETopChange(Sender: TObject);
begin
  if Showing then
     Margins.Top:=UDTop.Position;
end;

procedure TMarginsEditor.ERightChange(Sender: TObject);
begin
  if Showing then
     Margins.Right:=UDRight.Position;
end;

procedure TMarginsEditor.EBottomChange(Sender: TObject);
begin
  if Showing then
     Margins.Bottom:=UDBottom.Position;
end;

end.
