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

unit oaReg;

interface

procedure Register;

implementation

uses
  Classes, oaAssist, oaBaloon, oaProps, oaTypes, OffBtn,
  {$IFDEF COMPILER6_UP} DesignIntf, DesignEditors {$ELSE} DsgnIntf {$ENDIF};

procedure Register;
begin
  RegisterComponents('Delphi Area', [TOffice97Button]);
  RegisterComponents('Delphi Area', [TAssistant]);
  RegisterComponentEditor(TAssistant, TAssistantComponentEditor);
  RegisterPropertyEditor(TypeInfo(String), TAssistant, 'ActorLibrary', TActorLibPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TTopicsList), nil, '', TTopicsPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TAboutMe), TAssistant, 'About', TAboutMePropertyEditor);
  {$IFDEF COMPILER6_UP}
  RegisterSelectionEditor(TAssistant, TAssistantSelectionEditor);
  {$ENDIF}
end;

end.
