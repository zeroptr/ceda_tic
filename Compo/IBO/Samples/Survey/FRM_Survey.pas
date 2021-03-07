
{                                                                              }
{  FRM_Survey                                                                  }
{                                                                              }

unit
  FRM_Survey;

interface

uses
  Windows, Classes, Graphics, Forms, Controls, Menus, Dialogs, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, ImgList, Mask, Registry,

  IB_Header,
  IB_Session,
  IB_Constants,
  IB_Controls,
  IB_Dialogs,
  IB_SessionProps,
  IB_Components,
  IB_NavigationBar,
  IB_UpdateBar,
  IB_SearchBar,
  IB_SyncCursor;

type
  TfrmSurvey = class(TForm)
    SpeedPanel: TPanel;
    StatusBar: TStatusBar;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_UpdateBar1: TIB_UpdateBar;
    sp: TIB_SessionProps;
    md: TIB_MonitorDialog;
    Panel1: TPanel;
    btSurveys: TSpeedButton;
    btQuestions: TSpeedButton;
    mn: TMainMenu;
    FileMenu: TMenuItem;
    N2: TMenuItem;
    ExitItem: TMenuItem;
    Help1: TMenuItem;
    MonitorSQL1: TMenuItem;
    N3: TMenuItem;
    About1: TMenuItem;
    cn: TIB_Connection;
    miSurveys: TMenuItem;
    miQuestions: TMenuItem;
    sc: TIB_SyncCursor;
    Label1: TLabel;
    procedure ShowHint(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MonitorSQL1Click(Sender: TObject);
    procedure ExitItemClick(Sender: TObject);
    procedure cnAfterConnect(Sender: TIB_Connection);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSurvey: TfrmSurvey;

implementation

uses
  SysUtils, About,

  IBF_Base,
  FRM_Surveys,
  FRM_Questions;

{$R *.DFM}

procedure TfrmSurvey.ShowHint(Sender: TObject);
begin
  StatusBar.SimpleText := Application.Hint;
end;

procedure TfrmSurvey.MonitorSQL1Click(Sender: TObject);
begin
  md.Show;
end;

procedure TfrmSurvey.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
end;

procedure TfrmSurvey.About1Click(Sender: TObject);
begin
  AboutBox.Version.Caption := cn.Version;
  AboutBox.ShowModal;
end;

procedure TfrmSurvey.ExitItemClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSurvey.btClick(Sender: TObject);
begin
  cn.Connect;
  cn.BeginBusy( true );
  try
    if ( Sender = btSurveys ) or
       ( Sender = miSurveys ) then begin
      TfrmSurveys.CreateWithContext( Self,
                                     'Software\Apps\Survey\Surveys\' +
                                       cn.Username,
                                     cn,
                                     nil ).Show;
    end else if ( Sender = btQuestions ) or
                ( Sender = miQuestions ) then begin
      TfrmQuestions.CreateWithContext( Self,
                                       'Software\Apps\Survey\Questions\' +
                                         cn.Username,
                                       cn,
                                       nil ).Show;
    end;
  finally
    cn.EndBusy;
  end;
end;

procedure TfrmSurvey.cnAfterConnect(Sender: TIB_Connection);
begin
// If you want to be able to see how near real-time synchronization works
// between two separate users applications then execute the DMLCache.SQL
// script against the database and then uncomment out this line of code so
// that it will automatically start receiving and processing DML Cache events
// from other user's apps. 

//  sc.Prepare;

end;

procedure TfrmSurvey.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if cn.HasActiveTransaction then
  begin
    CanClose := false;
    MessageBeep( 0 );
    ShowMessage( 'Cannot close with an active transaction' );
  end;
end;

end.


