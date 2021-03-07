{*******************************************************}
{                                                       }
{       TiOPCPropertySelectorForm                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCPropertySelector;{$endif}
{$ifdef iCLX}unit QiOPCPropertySelector;{$endif}

interface

uses
  {$IFDEF iVCL}  iOPCItem,{$ENDIF}
  {$IFDEF iCLX}           {$ENDIF}

  {$I iIncludeUsesForms.inc}
  {$IFDEF iVCL}  iEditorBasicComponents,  StdCtrls,  Controls,  ComCtrls,  ExtCtrls, Classes,  ImgList;{$ENDIF}
  {$IFDEF iCLX}QiEditorBasicComponents,  QStdCtrls, QControls, QComCtrls, QExtCtrls, Classes, QImgList;{$ENDIF}

type
  TiOPCPropertySelectorForm = class(TForm)
    ListView: TListView;
    ImageList: TImageList;
    Panel1: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    StatusBar1: TStatusBar;
    procedure ListBoxDblClick(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListViewKeyPress(Sender: TObject; var Key: Char);
  private
    FPropertyName: String;
    {$IFDEF iVCL}
    function GetObjectProperty(Instance: TPersistent; const PropName: string): TObject;
    {$ENDIF}
  public
    procedure Setup(AObject: TPersistent; Path: String);
    procedure AddUnassigned;

    property PropertyName : String read FPropertyName write FPropertyName;
  end;

var
  iOPCPropertySelectorForm: TiOPCPropertySelectorForm;

implementation

{$IFDEF iVCL}
uses iVCLComponent;
{$ENDIF}

{$IFDEF iVCL}
type
  TiVCLComponentAccess = class(TiVCLComponent);
{$ENDIF}
{$R *.dfm}
//****************************************************************************************************************************************************
{$IFDEF iVCL}
function TiOPCPropertySelectorForm.GetObjectProperty(Instance: TPersistent; const PropName: string): TObject;
var
  PropInfo: PPropInfo;
begin
  Result := nil;
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, PropName);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
    Result := TObject(GetOrdProp(Instance, PropInfo));
end;
{$ENDIF}
//****************************************************************************************************************************************************
procedure TiOPCPropertySelectorForm.Setup(AObject: TPersistent; Path: String);
{$IFDEF iVCL}
var
  Count         : Integer;
  x             : Integer;
  PropInfo      : PPropInfo;
  PropList      : PPropList;
  PropName      : ShortString;
  SubClass      : TObject;
  ListItem      : TListItem;
  iVCLComponent : TiVCLComponent;
  {$ENDIF}
begin
{$IFDEF iVCL}
  if AObject is TiVCLComponent then
    begin
      iVCLComponent := AObject as TiVCLComponent;
      TiVCLComponentAccess(iVCLComponent).UpdateOPCSpecialList;
      for x := 0 to TiVCLComponentAccess(iVCLComponent).OPCSpecialList.Count-1 do
        begin
          ListItem := ListView.Items.Add;
          ListItem.Caption := TiVCLComponentAccess(iVCLComponent).OPCSpecialList.Strings[x];
          ListItem.ImageIndex := 0;
        end;
    end;

  Count := GetTypeData(AObject.ClassInfo)^.PropCount;
  GetMem(PropList, Count * SizeOf(Pointer));
  try
    GetPropInfos(AObject.ClassInfo, PropList);
    for x := 0 to Count-1 do
      begin
        PropInfo := PropList^[x];
        if PropInfo <> nil then
          begin
            if Assigned(PropInfo^.SetProc) then
              begin
                if Trim(Path) <> '' then PropName  := Path + '.' + PropInfo.Name
                  else PropName  := PropInfo.Name;

                if PropName = 'Name' then Continue;
                
                case PropInfo^.PropType^.Kind of
                  tkInteger, tkEnumeration, tkSet, tkChar : begin
                                                             ListItem := ListView.Items.Add;
                                                             ListItem.Caption := PropName;
                                                             ListItem.ImageIndex := 0;
                                                            end;
                  tkFloat                                 : begin
                                                             ListItem := ListView.Items.Add;
                                                             ListItem.Caption := PropName;
                                                             ListItem.ImageIndex := 0;
                                                            end;
                  tkString, tkLString, tkWString          : begin
                                                             ListItem := ListView.Items.Add;
                                                             ListItem.Caption := PropName;
                                                             ListItem.ImageIndex := 0;
                                                            end;
                  tkClass                                 : begin
                                                              SubClass := GetObjectProperty(AObject, PropInfo.Name);
                                                              if SubClass is TPersistent then Setup(SubClass as TPersistent, PropName);
                                                            end;
                end;

              end;
          end
        else Break;
      end;
  finally
    FreeMem(PropList, Count * SizeOf(Pointer));
  end;
{$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiOPCPropertySelectorForm.AddUnassigned;
var
  ListItem : TListItem;
begin
  ListItem := ListView.Items.Add;
  ListItem.Caption := '{Unassigned}';
  ListItem.ImageIndex := 0;
end;
//****************************************************************************************************************************************************
procedure TiOPCPropertySelectorForm.ListBoxDblClick(Sender: TObject);
begin
  if Assigned(ListView.Selected) then ModalResult := mrOk;
end;
//****************************************************************************************************************************************************
procedure TiOPCPropertySelectorForm.ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  PropertyName := Item.Caption;
  OKButton.Enabled := True;
end;
//****************************************************************************************************************************************************
procedure TiOPCPropertySelectorForm.ListViewKeyPress(Sender: TObject; var Key: Char);
begin
  if not Assigned(ListView.Selected) then exit;
  if Key = #13 then
    begin
      Key := #0;
      ModalResult := mrOk;
    end;
end;
//****************************************************************************************************************************************************
end.
