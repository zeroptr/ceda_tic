
{                                                                              }
{ IBD_IBMemoEdit                                                               }
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
  IBD_IBMemoEdit;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, ExtCtrls, Messages,

  IB_Components,
  IB_Controls;

type
  TdlgIBMemoEdit = class(TForm)
    pnMemoEditBottom: TPanel;
    pnMemoEditButtons: TPanel;
    btMemoEditOK: TButton;
    meMemo: TIB_Memo;
    cbWordWrap: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbWordWrapClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FTabExits: boolean;
    procedure CMChildKey(var Msg: TMessage); message CM_CHILDKEY;
  protected
    procedure Loaded; override;
  public
    { Public methods }
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    property TabExits: boolean read FTabExits write FTabExits default false;
  end;

var
  dlgIBMemoEdit: TdlgIBMemoEdit;

implementation

{$R *.DFM}

uses IB_Constants;

constructor TdlgIBMemoEdit.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FTabExits := false;
end;

destructor TdlgIBMemoEdit.Destroy;
begin
  inherited Destroy;
end;

procedure TdlgIBMemoEdit.Loaded;
begin
  inherited;
  btMemoEditOK.Caption := C_BF_OK;
  cbWordWrap.Caption := C_CB_WordWrap;
  cbWordWrapClick( nil );
end;

procedure TdlgIBMemoEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

// We have to find the TAB key as it goes to the child and this is the
// only way I know of getting it reliably.
procedure TdlgIBMemoEdit.CMChildKey( var Msg: TMessage );
var
    Shift: TShiftState;
    Key: Word;
    // Short function to retrieve keyboard shift state
    // (essentially a copy of similar defined in Control.PAS, but this one
    // also uses GetKeyState for the Alt-key (VK_MENU) since it does not
    // get this information with the message.)
    function GetShiftKeyStates: TShiftState;
    begin
    Result := [];
    if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
    if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
    if GetKeyState(VK_MENU) < 0 then Include(Result, ssAlt);
    end;
begin
  if not (csDesigning in ComponentState) then begin
    Key := Msg.WParam;
    // If we get the tab key I call FormKeyDown just to keep the
    // final processing in one place.
    if Key = VK_TAB then begin
      Shift := GetShiftKeyStates;
      FormKeyDown( Self, Key, Shift );
    end;
  end;
end;

procedure TdlgIBMemoEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then begin
    if not meMemo.Modified then
      ModalResult := mrCancel;
  end else if (Key = VK_TAB) and TabExits then begin
    if Shift = [] then begin
      ModalResult := mrYes;
    end else if Shift = [ssShift] then begin
      ModalResult := mrNo;
    end;
  end;
end;

procedure TdlgIBMemoEdit.cbWordWrapClick(Sender: TObject);
begin
  with meMemo do begin
    if cbWordWrap.Checked then begin
      ScrollBars := ssVertical;
      WordWrap := true;
    end else begin
      ScrollBars := ssBoth;
      WordWrap := false;
    end;
  end;
end;

procedure TdlgIBMemoEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  try
    if Assigned( meMemo.DataSource ) then
      if Assigned( meMemo.DataSource.Dataset ) then
        meMemo.DataSource.Dataset.UpdateRecord;
  except
    CanClose := false;
    Application.HandleException( Self );
  end;
end;

end.
