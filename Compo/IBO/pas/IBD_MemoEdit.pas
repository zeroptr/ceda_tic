
{                                                                              }
{ IBD_MemoEdit                                                                 }
{                                                                              }

{***************************************************************}
{                                                               }
{          IB Objects Components and Resources Library          }
{                                                               }
{          Copyright (C) 1996-2001 Jason Wharton                }
{          and Computer Programming Solutions, Mesa, AZ         }
{                                                               }
{  This source code unit is released under the terms of the     }
{  CPS Trustware License.                                       }
{  It may be distributed or deployed as source code or in       }
{  compiled form only in compliance with the terms and          }
{  conditions of the CPS Trustware License which may be         )
{  examined at http://www.ibobjects.com/ibo_trustware.html      )
{                                                               }
{***************************************************************}

{******************************************************************************}
{  CONTRIBUTED MODIFICATIONS                                                   }
{  Additions or modifications listed below using format:                       }
{                                                                              }
{  Joe Citizen <joe@joecitizen.com>                                            }
{  mm/dd/yyyy                                                                  }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{            Copyright (C) 2001 Joe Citizen                                    }
{                                                                              }
{------------------------------------------------------------------------------}
{  Place your credits and information in the top of the section                }
{  below with any other descriptions or explanations desired.                  }
{------------------------------------------------------------------------------}
{                                                                              }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IBD_MemoEdit;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, ExtCtrls,

  IB_Components;

type
  TdlgMemoEdit = class(TForm)
    meMemo: TMemo;
    pnMemoEditBottom: TPanel;
    pnMemoEditButtons: TPanel;
    btMemoEditOK: TButton;
    btMemoEditCancel: TButton;
    procedure meMemoChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btMemoEditOKClick(Sender: TObject);
    procedure btMemoEditCancelClick(Sender: TObject);
  private
    { Private declarations }
    FLinkList: TIB_StringList;
    FChanged: boolean;
    FSourceList: TIB_StringList;
    procedure SaveNewStringList;
    procedure SetLinkList( AValue: TIB_StringList );
    procedure SetSourceList( AValue: TIB_StringList );
  public
    { Public methods }
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    { Public declarations }
    property LinkList: TIB_StringList read FLinkList write SetLinkList;
    property SourceList: TIB_StringList read FSourceList write SetSourceList;
  end;

var
  dlgMemoEdit: TdlgMemoEdit;

implementation

{$R *.DFM}

uses
  IB_Constants;

constructor TdlgMemoEdit.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FLinkList := TIB_StringList.Create;
end;

destructor TdlgMemoEdit.Destroy;
begin
  FLinkList.Free;
  FLinkList := nil;
  inherited Destroy;
end;

procedure TdlgMemoEdit.SetLinkList( AValue: TIB_StringList );
begin
  FLinkList.Assign( AValue );
end;

procedure TdlgMemoEdit.SaveNewStringList;
begin
  if Assigned( FSourceList ) then
  begin
    FSourceList.BeginUpdate;
    try
      FSourceList.Assign( meMemo.Lines );
      FSourceList.RemoveBlankEntries;
    finally
      FSourceList.EndUpdate;
    end;
    ModalResult := mrOk;
  end;
end;

procedure TdlgMemoEdit.SetSourceList( AValue: TIB_StringList );
var
  ii: integer;
  modStrings: TIB_StringList;
begin
  FSourceList := AValue;
  if LinkList.Count > 0 then
  begin
    modStrings := TIB_StringList.Create;
    try
      modStrings.Assign( SourceList );
      for ii := 0 to LinkList.Count - 1 do
        modStrings.LinkValues[ LinkList[ ii ]] :=
          modStrings.LinkValues[ LinkList[ ii ]];
      meMemo.Lines.Assign( modStrings );
    finally
      modStrings.Free;
    end;
  end
  else
    meMemo.Lines.Assign( FSourceList );
  FChanged := false;
end;

procedure TdlgMemoEdit.meMemoChange(Sender: TObject);
begin
  FChanged := true;
end;

procedure TdlgMemoEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := true;
  if FChanged and Assigned( FSourceList ) then
    case MessageDlg( M_Save_Changes,
                     mtConfirmation, [mbYes, mbNo, mbCancel], 0 ) of
      mrYes: SaveNewStringlist;
      mrNo: ModalResult := mrCancel;
      else CanClose := false;
    end;
end;

procedure TdlgMemoEdit.btMemoEditOKClick(Sender: TObject);
begin
  SaveNewStringList;
  FChanged := false;
  ModalResult := mrOk;
end;

procedure TdlgMemoEdit.btMemoEditCancelClick(Sender: TObject);
begin
  if FChanged and
     ( MessageDlg( M_Abort_Changes,
                   mtConfirmation, [mbYes, mbNo], 0 ) <> mrYes ) then
    SysUtils.Abort;
  FChanged := false;
  ModalResult := mrCancel;
end;

end.
