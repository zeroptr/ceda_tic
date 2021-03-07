{------------------------------------------------------------------------------}
{                                                                              }
{  Office Assistant                                                            }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

{$I DELPHIAREA.INC}

unit oaAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TAssistantAbout = class(TForm)
    Icon: TImage;
    Component: TLabel;
    Copyright: TLabel;
    Bevel1: TBevel;
    OKButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Bevel2: TBevel;
    Package: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Label6Click(Sender: TObject);
  public
    class procedure Execute(const ComponentName: String);
  end;

implementation

{$R *.DFM}

uses ShellAPI;

class procedure TAssistantAbout.Execute(const ComponentName: String);
begin
  with Create(Application) do
    try
      Component.Caption := ComponentName;
      ShowModal;
    finally
      Free;
    end;
end;

procedure TAssistantAbout.Label6Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(TLabel(Sender).Hint), nil, nil, SW_SHOW);
end;

end.
