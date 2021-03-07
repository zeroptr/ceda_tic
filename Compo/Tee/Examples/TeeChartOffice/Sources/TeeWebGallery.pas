{**********************************************}
{   TeeChart Office - Web Charts Gallery       }
{   Copyright (c) 2001 by David Berneda        }
{   All Rights Reserved.                       }
{**********************************************}
unit TeeWebGallery;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  {$ENDIF}
  SysUtils, Classes;

type
  TWebGallery = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    RadioLoad: TRadioButton;
    URL: TComboBox;
    RadioBrowse: TRadioButton;
    RadioUpload: TRadioButton;
    ButtonOK: TButton;
    PanelUpload: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    EditName: TEdit;
    Label4: TLabel;
    EditEMail: TEdit;
    Label5: TLabel;
    EditPassword: TEdit;
    Button2: TButton;
    Label6: TLabel;
    EditChart: TEdit;
    LabelSize: TLabel;
    LabelKB: TLabel;
    PanelMain: TPanel;
    procedure RadioBrowseClick(Sender: TObject);
    procedure RadioLoadClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioUploadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Procedure CheckValidEmail;
    Procedure CheckValidName;
    Procedure LoadFromRegistry;
    Procedure LoadHistoryFromRegistry;
    Procedure SaveToRegistry;
  public
    { Public declarations }
  end;

{ send AStream contents to Web URL }
Procedure TeeUploadFile(Const URL:String; AStream:TMemoryStream);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeOfficeConstants, TeeChartOfficeConstants, TeeUpdateVersion,
     {$IFNDEF LINUX}
     Registry,
     {$ENDIF}
     TeeAbout, TeeConst, TeeProcs;

procedure TWebGallery.RadioBrowseClick(Sender: TObject);
begin
  ButtonOK.Caption:=TeeMsg_Go;
end;

procedure TWebGallery.RadioLoadClick(Sender: TObject);
begin
  ButtonOK.Caption:=TeeMsg_OK;
  URL.SetFocus;
end;

procedure TWebGallery.ButtonOKClick(Sender: TObject);

  Procedure ValidateFields;
  begin
    CheckValidName;
    CheckValidEmail;

    if EditPassword.Text='' then
       Raise Exception.Create(TeeMsg_WrongPassword);

    if EditChart.Text='' then
       Raise Exception.Create(TeeMsg_WrongChartID);
  end;

  Procedure SaveHistoryToRegistry;
  begin
  end;

begin { do the selected action ! }
  if RadioLoad.Checked then
  begin
    { proceed to download a *.Tee file from Web URL }
    SaveHistoryToRegistry;
    ModalResult:=mrOk;
  end
  else
  if RadioBrowse.Checked then
     ModalResult:=mrOk  { proceed to go to Web Charts Gallery }
  else
  if RadioUpload.Checked then
  begin
    if PanelUpload.Visible then
    begin
      { check personal options and proceed to Upload *.tee file to Web }
      ValidateFields;
      SaveToRegistry;
      ModalResult:=mrOk;
    end
    else
    begin
      { show personal options before uploading }
      PanelMain.Visible:=False;
      PanelUpload.Visible:=True;
      ButtonOK.Caption:=TeeMsg_Upload;
    end;
  end;
end;

procedure TWebGallery.FormCreate(Sender: TObject);
begin
  { read your personal info from Windows Registry }
  LoadFromRegistry;

  { read download combo history items from Registry }
  LoadHistoryFromRegistry;
end;

Procedure TWebGallery.LoadHistoryFromRegistry;
var t     : Integer;
    tmp   : Integer;
    tmpSt : String;
begin { read download URL combo history items from Registry }
  With TRegistry.Create do
  try
    if OpenKeyReadOnly(TeeChartOfficeKey+'\WebGallery\Download') then
    begin
      if ValueExists('Count') then
      begin
        tmp:=ReadInteger('Count');
        for t:=0 to tmp-1 do
        begin
          tmpSt:='URL'+IntToStr(t);
          if ValueExists(tmpSt) then
             URL.Items.Add(ReadString(tmpSt));
        end;
      end;
    end;
  finally
    Free;
  end;
end;

Procedure TWebGallery.LoadFromRegistry;
begin { read your personal info from Windows Registry }
  With TRegistry.Create do
  try
    if OpenKeyReadOnly(TeeChartOfficeKey+'\WebGallery') then
    begin
      if ValueExists('YourName') then
         EditName.Text:=ReadString('YourName');
      if ValueExists('YourEMail') then
         EditEMail.Text:=ReadString('YourEMail');
      if ValueExists('YourPassword') then
         EditPassword.Text:=ReadString('YourPassword');
    end;
  finally
    Free;
  end;
end;

Procedure TWebGallery.SaveToRegistry;
begin { save your personal info to Windows Registry }
  With TRegistry.Create do
  try
    if OpenKey(TeeChartOfficeKey+'\WebGallery',True) then
    begin
      WriteString('YourName',EditName.Text);
      WriteString('YourEMail',EditEmail.Text);
      WriteString('YourPassword',EditPassword.Text);
    end;
  finally
    Free;
  end;
end;

Function Strip(Const S:String):String;
begin { remove blank characters from begin and end of S string }
  result:=S;
  While Copy(result,1,1)=' ' do Delete(result,1,1);
  While Copy(result,Length(result)-1,1)=' ' do
        Delete(result,Length(result)-1,1);
end;

Procedure TWebGallery.CheckValidName;
begin { validate your Name }
  if EditName.Text='' then
  begin
    EditName.SetFocus;
    Raise Exception.Create(TeeMsg_NameNotValid);
  end;
end;

Procedure TWebGallery.CheckValidEmail;
var tmp : String;
    i   : Integer;
begin { validate email address correctness }
  tmp:=Strip(EditEmail.Text);
  if (Length(tmp)>4) and
     (Pos('=',tmp)=0) and
     (Pos(',',tmp)=0) and
     (Pos(' ',tmp)=0) then
  begin
    i:=Pos('@',tmp);
    if i>1 then
    begin
      tmp:=Copy(tmp,i+1,Length(tmp));
      i:=Pos('.',tmp);
      if i>1 then
      begin
        if i<Length(tmp) then
        begin
          exit; { Email "seems" Valid ! }
        end;
      end;
    end;
  end;
  Raise Exception.Create(TeeMsg_EmailNotValid);
  EditEmail.SetFocus;
end;

procedure TWebGallery.Button2Click(Sender: TObject);
var tmp  : TMemoryStream;
    tmpS : TStringList;
begin { connect to Steema.com to obtain your Password }

  { first check for valid Name and Email }
  CheckValidName;
  CheckValidEMail;

  { obtain password }
  tmp:=TeeDownloadFile(TeeSteemaGetPassword+'?email='+EditEMail.Text+'&back=YES',
                       TeeMsg_CannotObtainPassword);
  try
    tmpS:=TStringList.Create;
    try
      tmpS.LoadFromStream(tmp);
      if (tmpS.Count>1) and
         (tmpS[0]=TeeMsg_URLMagic) then { response is ok }
      begin
        if tmpS[1]='OK' then { password has been emailed }
           ShowMessage(TeeMsg_PasswordSent)
        else
        if tmpS[1]='NEW' then { new registration. password has been emailed }
           ShowMessage(TeeMsg_Congrats)
        else
           raise Exception.Create(TeeMsg_CannotObtainPassword+#13+
                                  tmpS[1]);

        { if password received, then fill the edit box }
        if tmpS.Count>2 then
           EditPassword.Text:=tmpS[2];
      end
      else
        { response is not ok }
        raise Exception.Create(TeeMsg_CannotObtainPassword);
    finally
      tmpS.Free;
    end;
  finally
    tmp.Free;
  end;
end;

Procedure TeeUploadFile(Const URL:String; AStream:TMemoryStream);
begin
  Raise Exception.Create('Uploading not implemented yet.');
end;

procedure TWebGallery.RadioUploadClick(Sender: TObject);
begin
  ButtonOK.Caption:=TeeMsg_Next;
end;

procedure TWebGallery.FormShow(Sender: TObject);
begin
  TeeTranslateControl(Self);
end;

end.
