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

unit oaProps;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, oaTypes, 
  {$IFDEF COMPILER6_UP} DesignIntf, DesignEditors {$ELSE} DsgnIntf {$ENDIF};


type

{ TAboutMePropertyEditor }

  TAboutMePropertyEditor = class(TStringProperty)
  public
    procedure Edit; override;
    function GetValue: String; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

{ TActorLibPropertyEditor }

  TActorLibPropertyEditor = class(TStringProperty)
  private
    Editing: Boolean;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

{ TTopicsPropertyEditor }

  TTopicsPropertyEditor = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetValue: String; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

{ TActorLibComponentEditor }

  TAssistantComponentEditor = class(TComponentEditor)
  private
    Editing: Boolean;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TAssistantSelectionEditor }

  {$IFDEF COMPILER6_UP}
  TAssistantSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;
  {$ENDIF}

implementation

uses
  oaAssist, oaAbout, oaSelect, oaTopics, oaBaloon;

{ TAboutMePropertyEditor }

function TAboutMePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TAboutMePropertyEditor.GetValue: string;
begin
  Result := '(About)'
end;

procedure TAboutMePropertyEditor.Edit;
begin
  TAssistantAbout.Execute(GetComponent(0).ClassName);
end;

{ TActorLibPropertyEditor }

function TActorLibPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TActorLibPropertyEditor.Edit;
var
  Filename: String;
begin
  if not Editing then
  begin
    Editing := True;
    try
     Filename := GetStrValue;
     if SelectActor(GetComponent(0).GetNamePath + '.ActorLibrary', Filename) then
       SetStrValue(Filename);
    finally
      Editing := False;
    end;
  end;
end;

{ TTopicsPropertyEditor }

function TTopicsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadonly];
end;

function TTopicsPropertyEditor.GetValue: string;
begin
  Result := '(' + TTopicsList.ClassName + ')';
end;

procedure TTopicsPropertyEditor.Edit;
var
  Topics: TTopicsList;
begin
  Topics := nil;
  if GetComponent(0) is TGuideDlgOptions then
    Topics := TGuideDlgOptions(GetComponent(0)).Topics
  else if GetComponent(0) is THintDlgOptions then
    Topics := THintDlgOptions(GetComponent(0)).Topics;
  if TTopicsEditor.Execute(GetComponent(0).GetNamePath, Topics) then
    Modified;
end;

{ TAssistantComponentEditor }

procedure TAssistantComponentEditor.ExecuteVerb(Index: Integer);
var
  Filename: String;
begin
  if (Index = 0) and not Editing then
  begin
    Editing := True;
    try
     if Component is TAssistant then
     begin
       Filename := TAssistant(Component).ActorLibrary;
       if SelectActor(Component.GetNamePath + '.ActorLibrary', Filename) then
       begin
         TAssistant(Component).ActorLibrary := Filename;
         Designer.Modified;
       end;
     end;
    finally
      Editing := False;
    end;
  end;
end;

function TAssistantComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Select Actor...'
  else
    Result := '';
end;

function TAssistantComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TAssistantSelectionEditor }

{$IFDEF COMPILER6_UP}
procedure TAssistantSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('oaTypes');
end;
{$ENDIF}

end.
