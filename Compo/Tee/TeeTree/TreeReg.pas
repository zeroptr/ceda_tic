{******************************************}
{   TeeTree library                        }
{   Component Registration Unit            }
{       TTree                              }
{       TTreeEdit                          }
{       TImageLevels                       }
{       TTreePageNavigator                 }
{                                          }
{   Copyright (c) 1996-2009 David Berneda  }
{   All Rights Reserved                    }
{                                          }
{******************************************}
{$I TeeDefs.inc}
unit TreeReg;

// See TreeDBReg.pas unit for TDBTree component.

interface

uses
  {$IFDEF CLR}
  Borland.VCL.Design.DesignEditors, Borland.VCL.Design.DesignIntf,
  {$ELSE}
  {$IFDEF CLX}
  DesignIntf, DesignEditors,
  {$ELSE}
  {$IFDEF D6}
  DesignIntf, DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  Classes;

type
  TTreeCompEditor=class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;

  TTreeProperty=class(TClassProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
    function GetValue: string; override;
  end;

Procedure Register;

implementation

{$IFNDEF CLR}
{$IFNDEF C5}
{$IFDEF D5}
  {$DEFINE TEESTRINGSPROPERTY}
{$ENDIF}
{$ENDIF}
{$ENDIF}

Uses
     {$IFDEF CLX}
     QForms, QDialogs, QGraphics,
     {$ELSE}
     Forms, Dialogs, Graphics,
     {$ENDIF}

     {$IFDEF TEESTRINGSPROPERTY}
     StrEdit,
     {$ENDIF}

     TeeTree, TeePrevi, TeeAbout,

     TreeConst, TreeEd, TreeShEd,
     TreeFlow, TreeElectric, TreeUML, TreeTransit, TreeAnimate,
     TreeAnimateEditor, TreeNavigator,

     TeeBrushDlg, TeCanvas, SysUtils, TeeConst, TeeTranslate,
     TeeEdiGrad, TeeProcs, TeePenDlg;

type
  TTreeEditCompEditor=class(TComponentEditor)
  public
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;

  TTreeAnimateCompEditor=class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;

{ TTreeCompEditor }
procedure TTreeCompEditor.Edit;
begin
  EditTree(nil,TCustomTree(Component));
  Designer.Modified;
end;

procedure TTreeCompEditor.ExecuteVerb( Index : Integer );
var ATree : TCustomTree;
begin
  ATree:=TCustomTree(Component);
  Case Index of
    0,1,3: TeeShowTreeAbout('');
    4: Edit;
    5: begin
         LoadTreeFromFile(ATree);
         Designer.Modified;
       end;
    6: begin
         TreePreview(nil,ATree,PrintTeePanel);
         Designer.Modified;
       end;
    7: ShowTreeExport(nil,ATree);
    8: TreeLanguageHook;
  else
    inherited;
  end;
end;

function TTreeCompEditor.GetVerbCount : Integer;
begin
  Result := 8;
  Inc(Result);
end;

function TTreeCompEditor.GetVerb( Index : Integer ) : string;
begin
  result:='';
  Case Index of
    0: result:=TreeMsg_TeeTree;
    1: result:=TeeMsg_TreeCopyright;
    2: result:='-';  { <--- do not change or translate... }
    3: result:=TeeMsg_TreeAbout;
    4: result:=TeeMsg_TreeEdit;
    5: result:=TeeMsg_TreeLoad;
    6: result:=TeeMsg_TreePrintPreview;
    7: result:=TeeMsg_TreeExportChart;
    8: result:=TeeMsg_AskLanguage;
  end;
end;

type
  TTreeBrushProperty=class(TTreeProperty)
  public
    procedure Edit; override;
  end;

{ TTreeProperty }
function TTreeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties,paDialog];
end;

function TTreeProperty.GetValue: string;
begin
  {$IFDEF CLR} 
  result:='('+GetPropType.ToString+')';
  {$ELSE}
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
  {$ENDIF}
end;

{ TreeBrush Editor }
procedure TTreeBrushProperty.Edit;
begin
  if EditChartBrush(nil,TChartBrush({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF})) then
     Designer.Modified;
end;

{ TTreeEditCompEditor }
procedure TTreeEditCompEditor.ExecuteVerb( Index : Integer );
begin
  if Index=0 then TTreeEdit(Component).Execute
             else inherited;
end;

function TTreeEditCompEditor.GetVerbCount : Integer;
begin
  Result := inherited GetVerbCount+1;
end;

function TTreeEditCompEditor.GetVerb( Index : Integer ) : string;
begin
  if Index=0 then result:=TeeMsg_Test
             else result:=inherited GetVerb(Index);
end;

{$IFDEF TEESTRINGSPROPERTY}
type
  TTreeStringsProperty=class(TStringListProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
  end;

{ TTreeStrings }

function TTreeStringsProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=inherited GetAttributes + [paSubProperties];
end;
{$ENDIF}

{ TTreeAnimateCompEditor }

procedure TTreeAnimateCompEditor.Edit;
begin
  if TTreeAnimate(Component).Tree<>nil then
  begin
    TTreeAnimateEditor.ModalShow(nil,TTreeAnimate(Component));
    Designer.Modified;
  end
  else Raise Exception.Create(TreeMsg_TreeNil);
end;

procedure TTreeAnimateCompEditor.ExecuteVerb(Index: Integer);
begin
  if Index=0 then Edit else inherited;
end;

function TTreeAnimateCompEditor.GetVerb(Index: Integer): string;
begin
  if Index=0 then result:=TeeMsg_TreeEdit
             else result:='';
end;

function TTreeAnimateCompEditor.GetVerbCount: Integer;
begin
  result:=inherited GetVerbCount+1;
end;

type
  TAnimationsProperty=class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
  end;

{ TAnimationsProperty }

procedure TAnimationsProperty.Edit;
var Animate : TTreeAnimate;
begin
  Animate:=TAnimations({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF}).Animate;
  TTreeAnimateEditor.ModalShow(nil,Animate);
  Designer.Modified;
end;

function TAnimationsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

Procedure Register;
begin
  RegisterNoIcon( [ TTreeNodeShape, TTreeConnection, TAnimation ]);

  RegisterComponents(TeeMsg_TeeTreePalette,[ TTree,
                                             TTreeEdit,
                                             TImageLevels,
                                             TTreePageNavigator,
                                             TTreeAnimate,
                                             TTreeEditorPanel,
                                             TTreeRuler
                                           ]);

  RegisterComponentEditor(TCustomTree, TTreeCompEditor);
  RegisterComponentEditor(TTreeEdit, TTreeEditCompEditor);
  RegisterComponentEditor(TTreeAnimate, TTreeAnimateCompEditor);

  RegisterPropertyEditor(TypeInfo(TTreeBrush), nil, '',TTreeBrushProperty);

  {$IFDEF TEESTRINGSPROPERTY}
  RegisterPropertyEditor(TypeInfo(TTreeStrings), nil, '',TTreeStringsProperty);
  {$ENDIF}

  RegisterPropertyEditor(TypeInfo(TAnimations), TTreeAnimate, 'Animations',
						             TAnimationsProperty);

  TreeSetLanguage(False);

  {$IFNDEF CLR}
  {$IFNDEF CLX}
  RegisterNonActiveX( [TCustomTree] , axrIncludeDescendants );
  {$ENDIF}
  {$ENDIF}
end;

end.
