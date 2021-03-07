program Survey;

uses
  Forms,
  About in 'ABOUT.PAS' {AboutBox},
  IBF_Base in '..\..\IBF_Base.pas' {frmBase},
  FRM_Language in 'FRM_Language.pas' {frmLanguage},
  FRM_Survey in 'FRM_Survey.pas' {frmSurvey},
  FRM_Surveys in 'FRM_Surveys.pas' {frmSurveys},
  FRM_Questions in 'FRM_Questions.pas' {frmQuestions};

{$R *.RES}

begin
  Application.Title := 'Surveys';
  Application.CreateForm(TfrmSurvey, frmSurvey);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
