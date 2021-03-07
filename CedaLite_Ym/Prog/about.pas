unit About;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    lblUCUNCU: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    Procedure OpenURL(URL:String);
    procedure lblUCUNCUClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

uses SysUtils,unDataMod,ShellAPI;

{$R *.DFM}

Procedure TAboutBox.OpenURL(URL:String);
begin
  ShellExecute(Handle,'open',PChar(URL),nil,nil,sw_ShowMaximized);
end;

procedure TAboutBox.FormShow(Sender: TObject);
begin
  ProductName.Caption := 'TransPort V2';
  Version.Caption := 'Version: ' + IntToStr(VER_MAJOR) + '.' + IntToStr(VER_MINOR) + '.'+ IntToStr(VER_RELEASE);
end;

procedure TAboutBox.lblUCUNCUClick(Sender: TObject);
begin
   OpenURL(lblUCUNCU.Caption);
end;

procedure TAboutBox.FormClick(Sender: TObject);
begin
   Close;
end;

procedure TAboutBox.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then FormClick(Self);
end;

end.

