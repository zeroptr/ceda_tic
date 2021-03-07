unit
  FRM_Threads;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls,
  IB_Components, UN_Threads;

type
  TfrmThreads = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    LRowCnt1: TLabel;
    LRowCnt2: TLabel;
    LRowCnt3: TLabel;
    LRowCnt4: TLabel;
    LIncCnt1: TLabel;
    LIncCnt2: TLabel;
    LIncCnt3: TLabel;
    LIncCnt4: TLabel;
    LIncRowPS1: TLabel;
    LIncRowPS2: TLabel;
    LIncRowPS3: TLabel;
    LIncRowPS4: TLabel;
    LAvg1: TLabel;
    LAvg2: TLabel;
    LAvg3: TLabel;
    LAvg4: TLabel;
    lbRowCount: TLabel;
    lbIncCount: TLabel;
    lbIncRowPerSec: TLabel;
    lbAvgRowPerSec: TLabel;
    btAllThreads: TButton;
    LExcept1: TLabel;
    LExcept2: TLabel;
    LExcept3: TLabel;
    LExcept4: TLabel;
    procedure ThreadButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    procedure ToggleThread(AButton: TButton);
    procedure ThreadTerminated( Sender: TObject );
  public
    FThreads: array[1..4] of record
      MyThread: TMyThread;
      LRowCnt,
      LIncCnt,
      LIncRowPS,
      LAvg,
      LExcept: TLabel;
      Button: TButton;
    end;
  end;

var
  frmThreads: TfrmThreads;

implementation

{$R *.DFM}

procedure TfrmThreads.FormCreate(Sender: TObject);
begin
  FThreads[1].LRowCnt := LRowCnt1;
  FThreads[1].LIncCnt := LIncCnt1;
  FThreads[1].LIncRowPS := LIncRowPS1;
  FThreads[1].LAvg := LAvg1;
  FThreads[1].LExcept := LExcept1;
  FThreads[1].Button := Button1;
  FThreads[2].LRowCnt := LRowCnt2;
  FThreads[2].LIncCnt := LIncCnt2;
  FThreads[2].LIncRowPS := LIncRowPS2;
  FThreads[2].LAvg := LAvg2;
  FThreads[2].LExcept := LExcept2;
  FThreads[2].Button := Button2;
  FThreads[3].LRowCnt := LRowCnt3;
  FThreads[3].LIncCnt := LIncCnt3;
  FThreads[3].LIncRowPS := LIncRowPS3;
  FThreads[3].LAvg := LAvg3;
  FThreads[3].LExcept := LExcept3;
  FThreads[3].Button := Button3;
  FThreads[4].LRowCnt := LRowCnt4;
  FThreads[4].LIncCnt := LIncCnt4;
  FThreads[4].LIncRowPS := LIncRowPS4;
  FThreads[4].LAvg := LAvg4;
  FThreads[4].LExcept := LExcept4;
  FThreads[4].Button := Button4;
end;

procedure TfrmThreads.ToggleThread(AButton: TButton);
var ThreadIndex: Integer;
begin
  ThreadIndex := AButton.Tag;
  with FThreads[ThreadIndex] do
    if not Assigned(MyThread) then
    begin
      LRowCnt.Caption := '-';
      LIncCnt.Caption := '-';
      LIncRowPS.Caption := '-';
      LAvg.Caption := '-';
      LExcept.Caption := '-';
      LExcept.ShowHint := false;
      MyThread := TMyThread.Create(ThreadIndex, ThreadTerminated);
      AButton.Caption := Format('Thread %d started', [ThreadIndex]);
    end
    else
    begin
      AButton.Caption := Format('Thread %d stopping', [ThreadIndex]);
      MyThread.Terminate;
      MyThread.SaferWaitFor; //pointer will be nil'ed in ThreadTerminated
    end;
end;

procedure TfrmThreads.ThreadButtonClick(Sender: TObject);
begin
  if (Sender = Button1) or (Sender = btAllThreads) then ToggleThread(Button1);
  if (Sender = Button2) or (Sender = btAllThreads) then ToggleThread(Button2);
  if (Sender = Button3) or (Sender = btAllThreads) then ToggleThread(Button3);
  if (Sender = Button4) or (Sender = btAllThreads) then ToggleThread(Button4);
end;

procedure TfrmThreads.ThreadTerminated(Sender: TObject);
var
  ThreadIndex: Integer;
begin
  ThreadIndex := (Sender as TMyThread).ThreadIndex;
  with FThreads[ThreadIndex] do
  begin
    Button.Caption := Format('Thread %d finished', [ThreadIndex]);
    if MyThread.FExceptionMsg <> '' then
    begin
      LExcept.Caption := MyThread.FExceptionMsg;
      LExcept.Hint := MyThread.FExceptionMsg;
      LExcept.ShowHint := true;
    end;
    MyThread := nil;
  end;
end;

procedure TfrmThreads.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i: Integer;
begin
  for i := 1 to 4 do
    with FThreads[i] do
      if Assigned(MyThread) then
      begin
        MyThread.Terminate;
        MyThread.SaferWaitFor;
      end;
  CanClose := true;
end;

end.

