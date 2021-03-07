{******************************************}
{   TeeTree library                        }
{   Component Registration Unit            }
{                                          }
{       TDBTree                            }
{                                          }
{   Copyright (c) 1996-2009 David Berneda  }
{   All Rights Reserved                    }
{                                          }
{******************************************}
{$I TeeDefs.inc}
unit TreeDBReg;

interface

Procedure Register;

implementation

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

  Classes, SysUtils,
  TreeReg, TreeConst, TeeDBTre, TreeDBEd, TreeShEd, TeeTree, TeePenDlg;

type
  TDBTreeCompEditor=class(TTreeCompEditor)
  protected
  public
    procedure Edit; override;
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;

{ TDBTreeCompEditor }
procedure TDBTreeCompEditor.ExecuteVerb( Index : Integer );
var tmp : Integer;
begin
  tmp:=GetVerbCount;
  if Index=4 then
  begin
    EditDBTree(nil,TCustomDBTree(Component));
    Designer.Modified;
  end
  else
  if Index=tmp-2 then TCustomDBTree(Component).Refresh
  else
  if Index=tmp-1 then
  begin
    ShowDBTreeEditor(nil,TCustomDBTree(Component));
    Designer.Modified;
  end
  else inherited;
end;

function TDBTreeCompEditor.GetVerbCount : Integer;
begin
  Result:=inherited GetVerbCount+2;
end;

function TDBTreeCompEditor.GetVerb( Index : Integer ) : string;
var tmp : Integer;
begin
  tmp:=GetVerbCount;
  if Index=tmp-2 then result:=TeeMsg_TreeDBRefresh
  else
  if Index=tmp-1 then result:=TeeMsg_TreeDBWizard
                 else result:=inherited GetVerb(Index);
end;

procedure TDBTreeCompEditor.Edit;
begin
  EditDBTree(nil,TCustomDBTree(Component));
  Designer.Modified;
end;

type
  TDBLayoutFormatProperty=class(TClassProperty)
  private
    procedure OnShowEditor(Sender:TObject);
  public
    function GetAttributes : TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

  TDBLayoutFieldsProperty=class(TStringProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure Edit; override;
  end;

{ TDBLayoutFormatProperty }

procedure TDBLayoutFormatProperty.OnShowEditor(Sender:TObject);
begin
  with TNodeTreeEditor(Sender) do
  begin
    ShowControls(False,[Label22,CBConnStyle,CheckBox8,Label20,ComboBox5]);
  end;
end;

procedure TDBLayoutFormatProperty.Edit;
begin
  InternalEditTreeShapePage(nil, TTreeNodeShape({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF}),
                            stFormat,False,OnShowEditor);
  Designer.Modified;
end;

function TDBLayoutFormatProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TDBLayoutFormatProperty.GetValue: string;
begin
  {$IFDEF CLR} 
  result:='('+GetPropType.ToString+')';
  {$ELSE}
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
  {$ENDIF}
end;

{ TDBLayoutFieldsProperty }

procedure TDBLayoutFieldsProperty.Edit;
var tmp   : TStrings;
    tmpSt : String;
begin
  with GetComponent(0) as TDBLayout do
  if Assigned(DataSet) then
  begin

// in BDS 5.0 (D11), GetFieldNames must be called with TWideStrings param
//    tmp:={$IFDEF D11}TWideStrings{$ELSE}TStringList{$ENDIF}.Create;

    tmp:=TStringList.Create;
    try
      DataSet.GetFieldNames(tmp);

      tmpSt:=ChooseFields(Fields,tmp,DataSet.Name);

      if Fields<>tmpSt then
      begin
        Fields:=tmpSt;
        Designer.Modified;
      end;
    finally
      tmp.Free;
    end;
  end;
end;

function TDBLayoutFieldsProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=inherited GetAttributes + [paDialog];
end;

Procedure Register;
begin
  RegisterComponents(TeeMsg_TeeTreePalette,[ TDBTree ]);
  RegisterComponentEditor(TCustomDBTree, TDBTreeCompEditor);
  RegisterPropertyEditor(TypeInfo(String), TDBLayout, 'Fields',TDBLayoutFieldsProperty);
  RegisterPropertyEditor(TypeInfo(TTreeNodeShape), TDBLayout, '',TDBLayoutFormatProperty);
end;

end.
