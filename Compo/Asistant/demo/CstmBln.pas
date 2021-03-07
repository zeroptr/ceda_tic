{------------------------------------------------------------------------------}
{                                                                              }
{  Office Assistant Sample Application                                         }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

unit CstmBln;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, OffBtn, oaBaloon;

type
  TCustomBalloon = class(TAssistantBalloon)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Office97Button1: TOffice97Button;
    Label0: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure Office97Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CustomBalloon: TCustomBalloon;

implementation

{$R *.DFM}

procedure TCustomBalloon.Office97Button1Click(Sender: TObject);
begin
  Close;
end;

end.
