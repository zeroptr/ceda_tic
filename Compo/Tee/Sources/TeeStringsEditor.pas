{**********************************************}
{   TeeChart - Strings editor dialog           }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeeStringsEditor;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  Classes, SysUtils,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QClipbrd,
  QButtons,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Clipbrd, Buttons,
  {$ENDIF}
  TeeProcs, TeeConst;

type
  TStringsEditor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    Button4: TButton;
    Button5: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

// Show an editor dialog to modify "Strings". Returns True if user clicks the OK button.
function TeeEditStrings(AOwner:TComponent; Strings:TStrings; ReadOnly:Boolean=False):Boolean; overload;

// Show an editor dialog to modify "Text" string. Returns True if user clicks the OK button.
function TeeEditStrings(AOwner:TComponent; var Text:String; ReadOnly:Boolean=False):Boolean; overload;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeePenDlg;

procedure TStringsEditor.Button3Click(Sender: TObject);
var tmp : String;
begin
  tmp:=Memo1.SelText;

  if tmp='' then
     tmp:=Memo1.Lines.Text;

  Clipboard.AsText:=tmp;
end;

// Show an editor dialog to modify "Strings".
// Returns True if user clicks OK button.
function TeeEditStrings(AOwner:TComponent; Strings:TStrings; ReadOnly:Boolean=False):Boolean;
var tmp : TStringsEditor;
begin
  tmp:=TStringsEditor.Create(AOwner);
  try
    if Assigned(AOwner) and (not Assigned(AOwner.Owner)) then
       PositionToCenter(tmp);

    tmp.Memo1.Lines:=Strings;
    tmp.Memo1.ReadOnly:=ReadOnly;

    TeeTranslateControl(tmp);

    result:=tmp.ShowModal=mrOk;

    if (not ReadOnly) and result then
       Strings.Assign(tmp.Memo1.Lines);
  finally
    tmp.Free;
  end;
end;

function TeeEditStrings(AOwner:TComponent; var Text:String; ReadOnly:Boolean=False):Boolean;
var tmp : TStringsEditor;
begin
  tmp:=TStringsEditor.Create(AOwner);
  try
    if Assigned(AOwner) then
       PositionToCenter(tmp);

    tmp.Memo1.Lines.Text:=Text;
    tmp.Memo1.ReadOnly:=ReadOnly;

    TeeTranslateControl(tmp);

    result:=tmp.ShowModal=mrOk;

    if (not ReadOnly) and result then
       Text:=tmp.Memo1.Lines.Text;
  finally
    tmp.Free;
  end;
end;

procedure TStringsEditor.Button4Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
     Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TStringsEditor.Button5Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
     Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TStringsEditor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=TeeKey_Escape then
     ModalResult:=mrCancel;
end;

procedure TStringsEditor.FormCreate(Sender: TObject);
begin
  OpenDialog1.Filter:=TeeMsg_TextFile+'|*.txt';
  OpenDialog1.Title:=TeeMsg_SelectTextFile;
  SaveDialog1.Filter:=TeeMsg_TextFile+'|*.txt';
  SaveDialog1.Title:=TeeMsg_SaveTextFile;
end;

end.
