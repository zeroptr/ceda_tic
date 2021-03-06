unit CPortUTestMainFm;

{ Unit Test Code for CPort Component - main form used by all delphi versions }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, CPortCtl, CPort, CPortTypes;

type
  TCPortUTestMainForm = class(TForm)
    TraceMemo: TMemo;
    PanelTop: TPanel;
    ComComboBox1: TComComboBox;
    Label1: TLabel;
    Button1: TButton;
    LabelResult: TLabel;
    ComPort1: TComPort;
    procedure Button1Click(Sender: TObject);
    procedure ComPort1AfterClose(Sender: TObject);
    procedure ComPort1AfterOpen(Sender: TObject);
    procedure ComPort1BeforeClose(Sender: TObject);
    procedure ComPort1BeforeOpen(Sender: TObject);
    procedure ComPort1Break(Sender: TObject);
    procedure ComPort1CTSChange(Sender: TObject; OnOff: Boolean);
    procedure ComPort1DSRChange(Sender: TObject; OnOff: Boolean);
    procedure ComPort1Error(Sender: TObject; Errors: TComErrors);
  private
    { Private declarations }
    procedure Trace(msg:String);
    procedure Fail;
  public
    { Public declarations }
  end;

var
  CPortUTestMainForm: TCPortUTestMainForm;

implementation

{$R *.dfm}

procedure TCPortUTestMainForm.Fail;
begin
   LabelResult.Caption := 'Result:Fail';
   LabelResult.Font.Color := clRed;

end;
procedure TCPortUTestMainForm.Button1Click(Sender: TObject);
begin
  TraceMemo.Lines.Add('');
  ComComboBox1.ApplySettings; { writes itself out to the com port object }
  ComPort1.Connected := true;
  if ComPort1.Connected then
      Trace('Starting tests.')
  else begin
      Fail;
      exit;
  end;

  Sleep(100);
  Trace('Tests completed. Closing com port.');
  ComPort1.Connected := false;
end;

procedure TCPortUTestMainForm.ComPort1AfterClose(Sender: TObject);
begin
  Trace('event:AfterClose');
end;

procedure TCPortUTestMainForm.ComPort1AfterOpen(Sender: TObject);
begin
  Trace('event:AfterOpen');
end;

procedure TCPortUTestMainForm.ComPort1BeforeClose(Sender: TObject);
begin
  Trace('event:BeforeClose');
end;

procedure TCPortUTestMainForm.ComPort1BeforeOpen(Sender: TObject);
begin
  Trace('event:BeforeOpen');
end;

procedure TCPortUTestMainForm.ComPort1Break(Sender: TObject);
begin
  Trace('event:OnBreak');
end;

procedure TCPortUTestMainForm.ComPort1CTSChange(Sender: TObject;
  OnOff: Boolean);
begin
  Trace('event:OnCtsChange: State:'+BoolToStr(OnOff,true));
end;

procedure TCPortUTestMainForm.ComPort1DSRChange(Sender: TObject;
  OnOff: Boolean);
begin
  Trace('event:OnDSRChange: State:'+BoolToStr(OnOff,true));
end;

procedure TCPortUTestMainForm.ComPort1Error(Sender: TObject;
  Errors: TComErrors);
begin
  Trace('event:Error: '+ComErrorsToStr(Errors));
end;



procedure TCPortUTestMainForm.Trace(msg: String);
begin
  TraceMemo.Lines.Add(FormatDateTime('hh:nn:ss',now)+' : '+msg);
  if TraceMemo.Lines.Count>500 then
      TraceMemo.Lines.Delete(0);
end;

end.
