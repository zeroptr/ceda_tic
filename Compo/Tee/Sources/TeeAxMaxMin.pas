{**********************************************}
{   TAxisMaxMin Dialog Editor                  }
{   Copyright (c) 1996-2009 by David Berneda   }
{        All Rights Reserved                   }
{**********************************************}
unit TeeAxMaxMin;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  {$IFDEF LCL}
  LCLIntf,
  {$ENDIF}
  Windows, Messages,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons,
  {$ENDIF}
  Classes, SysUtils;

type
  TAxisMaxMin = class(TForm)
    BitBtn1: TButton;
    BitBtn2: TButton;
    EMaximum: TEdit;
    EMinimum: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    IsDateTime : Boolean;
    MaxMin     : Double;
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeProcs, TeeConst, TeeAxisIncr;

procedure TAxisMaxMin.FormShow(Sender: TObject);
begin
  if IsDateTime then
  begin
    if MaxMin>=1 then
       EMaximum.Text:=DateToStr(MaxMin)
    else
       EMaximum.Text:='';

    EMinimum.Text:=TimeToStr(MaxMin);
  end
  else
  begin
    EMaximum.Hint:='';
    EMinimum.Hint:='';

    Label1.Caption:='Value:'; // Do not localize

    EMaximum.Text:=FloatToStr(MaxMin);

    Label2.Visible:=False;
    EMinimum.Visible:=False;
  end;

  TeeTranslateControl(Self);
end;

procedure TAxisMaxMin.BitBtn1Click(Sender: TObject);
begin
  try
    if IsDateTime then
    begin
      if EMaximum.Text<>'' then
         MaxMin:=StrToDateTime(EMaximum.Text+' '+EMinimum.Text)
      else
         MaxMin:=StrToTime(EMinimum.Text);
    end
    else
      MaxMin:=StrToFloat(EMaximum.Text);

    ModalResult:=mrOk;

  except
    on E:Exception do
       TeeShowIncorrect(E.Message);
  end;
end;

procedure TAxisMaxMin.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

end.

