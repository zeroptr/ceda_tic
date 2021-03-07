{**********************************************}
{  TeeTree   --> QuickReports                  }
{                                              }
{  Component Registration Unit.                }
{                                              }
{  Copyright (c) 1996-2009 by David Berneda    }
{  All Rights Reserved                         }
{**********************************************}

{$I TeeDefs.inc}
unit TreeQRReg;

interface

procedure Register;

implementation

Uses Classes, TreeConst, TeeConst, TreeQR, SysUtils,
     {$IFDEF CLX}
     DesignIntf,
     {$ELSE}
     {$IFDEF D6}
     DesignIntf, DesignEditors,
     {$ELSE}
     DsgnIntf, 
     {$ENDIF}
     {$ENDIF}
     TeePrevi, TreeEd, TeeTree, TreeReg;

//{$R TREEQR.RES}

type
  TQRTreeCompEditor=class(TComponentEditor)
  public
    procedure ExecuteVerb( Index : Integer ); override;
    procedure Edit; override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;

  TQRTreeProperty=class(TClassProperty)
  public
    procedure Edit; override;
    function GetValue: string; override;
    function GetAttributes : TPropertyAttributes; override;
  end;

{ QRTree Editor }
procedure TQRTreeCompEditor.ExecuteVerb( Index : Integer );
Var ATree:TQuickReportTree;
begin
  ATree:=TQRTree(Component).Tree;
  Case Index of
    //3: TeeShowTreeAbout;
    3: TeeShowTreeAbout('');//tom:03/09/2002
    4: Edit;
    5: begin
         //LoadTreeFromFileDialog(TCustomTree(ATree));
         LoadTreeFromFile(TCustomTree(ATree)); //tom:03/09/2002
         Designer.Modified;
       end;
    //6: ChartPreview(nil,ATree);
    6: TreePreview(nil,ATree); //tom:03/09/2002;
    //7: TreeExport(nil,ATree);
    7: ShowTreeExport(nil,ATree); //tom:03/09/2002;
  else
    inherited ExecuteVerb(Index);
  end;
end;

procedure TQRTreeCompEditor.Edit;
begin
  EditTree(nil,TQRTree(Component).Tree);
  Designer.Modified;
end;

function TQRTreeCompEditor.GetVerbCount : Integer;
begin
  Result := 8;
end;

function TQRTreeCompEditor.GetVerb( Index : Integer ) : string;
begin
  result:='';
  Case Index of
    0: result:=TreeMsg_TeeTree;
    1: result:=TeeMsg_TreeCopyright;
    2: result:='-';  { <--- do not change or translate... }
    3: result:=TeeMsg_TreeAbout;
    4: result:=TeeMsg_TreeEdit;
    5: result:=TeeMsg_TreeLoad;
    6: result:=TeeMsg_PrintPreview;
    7: result:=TeeMsg_TreeExportChart;
  end;
end;

{ QRTree property Editor }
procedure TQRTreeProperty.Edit;
begin
  EditTree(nil,TQuickReportTree(GetOrdValue));
  Designer.Modified;
end;

function TQRTreeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TQRTreeProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

procedure Register;
begin
  RegisterNoIcon([TQuickReportTree]);
  RegisterComponents( TeeMsg_TeeTreePalette,[TQRTree] );
  RegisterComponentEditor(TQRTree,TQRTreeCompEditor);
  RegisterPropertyEditor( TypeInfo(TQuickReportTree),TQRTree,'Tree',TQRTreeProperty); { <-- do not translate }
  {$IFDEF D3}
  RegisterNonActiveX([TQuickReportTree,TQRTree] , axrIncludeDescendants );
  {$ENDIF}
end;

end.
