
{                                                                              }
{  FRM_LOB                                                                     }
{                                                                              }

unit
  FRM_Language;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Grids, Buttons,

  IBF_Base,

  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_Grid,
  IB_Controls;

type
  TfrmLanguage = class(TfrmBase)
    qrTranslations: TIB_Query;
    dsTranslations: TIB_DataSource;
    qrLanguage: TIB_Query;
    dsLanguage: TIB_DataSource;
    grQuestions: TIB_Grid;
    lcLanguage: TIB_LookupCombo;
    Splitter2: TSplitter;
    pnQuestions: TPanel;
    meChoices: TIB_Memo;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Panel2: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure lcLanguageNotInList(Sender: TObject);
    procedure qrTranslationsNewRecord(IB_Dataset: TIB_Dataset);
    procedure qrLanguageAfterPost(IB_Dataset: TIB_Dataset);
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Initialize; override;
  end;

implementation

{$R *.DFM}

uses
  FRM_Surveys;

procedure TfrmLanguage.DoReadSettings;
begin
  with RegDB do
  begin
    pnQuestions.Width := ReadInteger( 'Settings', 'pnQuestions.Width', 200 );
  end;
end;

procedure TfrmLanguage.DoWriteSettings;
begin
  with RegDB do
  begin
    WriteInteger( 'Settings', 'pnQuestions.Width', pnQuestions.Width );
  end;
end;

procedure TfrmLanguage.Initialize;
begin
  qrTranslations.Open;
  qrLanguage.Open;
end;

procedure TfrmLanguage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
// If the form is being used as a lookup window then don't free it.
  if Assigned( qrTranslations.MasterSource ) then
  begin
    Action := caHide;
    qrTranslations.Close;
  end;
end;

procedure TfrmLanguage.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if qrTranslations.NeedToPost then
  begin
    CanClose := false;
    qrTranslations.CheckBrowseMode;
  end;
  CanClose := true;
end;

procedure TfrmLanguage.FormResize(Sender: TObject);
begin
  Height := ( Height div 18 ) * 18 + 12;
end;

procedure TfrmLanguage.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  if NewSize < 30 then
    NewSize := 30;
  NewSize := NewSize + 9;
  NewSize := ( NewSize div 18 ) * 18 + 4;
end;

procedure TfrmLanguage.lcLanguageNotInList(Sender: TObject);
begin
  if MessageDlg( 'Add new language: ' + lcLanguage.SearchText + '?',
                 mtConfirmation,
                 [mbYes, mbNo], 0) = mrYes then
  begin
    qrLanguage.Insert;
    try
      qrLanguage.FieldByName('LANGUAGENAME').AsString := lcLanguage.SearchText;
      qrLanguage.Post;
    except
      qrLanguage.Cancel;
      raise;
    end;
  end;
end;

procedure TfrmLanguage.qrTranslationsNewRecord(IB_Dataset: TIB_Dataset);
begin
  qrTranslations.FieldByName( 'CHOICES' ).Assign(
    qrTranslations.MasterSource.Dataset.FieldByName( 'CHOICES' ));
end;

procedure TfrmLanguage.qrLanguageAfterPost(IB_Dataset: TIB_Dataset);
begin
  qrLanguage.Refresh;
end;

end.

 