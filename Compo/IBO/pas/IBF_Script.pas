
{                                                                              }
{ IBF_Script                                                                   }
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
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  04-May-2002                                                                 }
{     Altered the dialog to use a RichEdit and added a popup menu of useful    }
{     commands (such as find, replace etc).                                    }
{                                                                              }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IBF_Script;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls,

  IBF_Base,

  IB_Constants,
  IB_Session,
  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_Script,
  IB_TransactionBar, IB_Process, Menus;

type
  TfrmScript = class(TfrmBase)
    TitlePnl: TPanel;
    btScriptCommands: TSpeedButton;
    btExecute: TSpeedButton;
    cbStore: TCheckBox;
    ScriptEdit: TRichEdit;
    odScript: TOpenDialog;
    sdScript: TSaveDialog;
    IB_Script: TIB_Script;
    cbYield: TCheckBox;
    tbScript: TIB_TransactionBar;
    Panel1: TPanel;
    ScriptMenu: TPopupMenu;
    CutMI: TMenuItem;
    CopyMI: TMenuItem;
    PasteMI: TMenuItem;
    UndoMI: TMenuItem;
    DeleteMI: TMenuItem;
    Separator1MI: TMenuItem;
    FindMI: TMenuItem;
    FindNextMI: TMenuItem;
    ReplaceMI: TMenuItem;
    SelectAllMI: TMenuItem;
    ClearMI: TMenuItem;
    FindDlg: TFindDialog;
    ReplaceDlg: TReplaceDialog;
    Separator2MI: TMenuItem;
    SaveToFileMI: TMenuItem;
    LoadFromFileMI: TMenuItem;
    ExecuteMI: TMenuItem;
    procedure btExecuteClick(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure ScriptEditChange(Sender: TObject);
    procedure IB_ConnectionSourceAfterAssignment(
      Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
    procedure IB_TransactionSourceAfterAssignment(
      Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure IB_ScriptAfterExecute(Sender: TObject);
    procedure IB_ScriptBeforeExecute(Sender: TObject);
    procedure IB_ScriptError(Sender: TObject; const ERRCODE: Longint;
      ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Longint;
      SQLMessage, SQL: TStringList; var RaiseException: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FindMIClick(Sender: TObject);
    procedure FindNextMIClick(Sender: TObject);
    procedure ReplaceMIClick(Sender: TObject);
    procedure ClearMIClick(Sender: TObject);
    procedure CutMIClick(Sender: TObject);
    procedure CopyMIClick(Sender: TObject);
    procedure PasteMIClick(Sender: TObject);
    procedure UndoMIClick(Sender: TObject);
    procedure DeleteMIClick(Sender: TObject);
    procedure SelectAllMIClick(Sender: TObject);
    procedure FindDlgFind(Sender: TObject);
    procedure ReplaceDlgReplace(Sender: TObject);
    procedure ScriptMenuPopup(Sender: TObject);
    procedure ShowScriptMenu(Sender: TObject);
  private
    { Private declarations }
    FPrevCaption: string;
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation ); override;
  public
    { Public declarations }
    ScriptForEdit: TIB_Script;
    FileLoaded: string;
    FileModified: boolean;
    procedure UpdateCaption;
    function CheckSaveChanges: boolean;
  end;

implementation

{$R *.DFM}

procedure TfrmScript.Notification( AComponent: TComponent;
                                   Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if ( AComponent = ScriptForEdit ) and ( Operation = opRemove ) then
  begin
    WriteOutSettings;
    ScriptForEdit := nil;
    SaveSettings := false;
    Close;
  end;
end;

procedure TfrmScript.FormShow(Sender: TObject);
begin
  SetDefaultBounds( 0, 0, 600, 400 );
end;

procedure TfrmScript.DoReadSettings;
begin
  if Assigned( ScriptForEdit ) then with ScriptForEdit do
  begin
    cbYield.Checked := Yield;
    ScriptEdit.Lines.Assign( SQL );
  end
  else if Assigned( RegDB ) then with RegDB do
  begin
    cbStore.Checked := ReadBool( 'Settings', 'Store', false );
    cbYield.Checked := ReadBool( 'Settings', 'Yield', false );
    ReadStrings( 'SQL', ScriptEdit.Lines );
  end;
  if Assigned( RegDB ) then with RegDB do
  begin
    sdScript.Filename := ReadString( 'Settings', 'Filename', '*.SQL' );
    odScript.Filename := sdScript.Filename;
  end;
end;

procedure TfrmScript.DoWriteSettings;
begin
  if Assigned( ScriptForEdit ) then with ScriptForEdit do
  begin
    Yield := cbYield.Checked;
    SQL := ScriptEdit.Lines;
  end
  else if Assigned( RegDB ) then with RegDB do
  begin
    WriteBool( 'Settings', 'Store', cbStore.Checked );
    WriteBool( 'Settings', 'Yield', cbYield.Checked );
    if cbStore.Checked then
      WriteStrings( 'SQL', ScriptEdit.Lines )
    else
      WriteStrings( 'SQL', nil );
  end;
  if Assigned( RegDB ) then with RegDB do
    WriteString( 'Settings', 'Filename', sdScript.Filename );
end;

procedure TfrmScript.IB_ConnectionSourceAfterAssignment(
  Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
begin
  IB_Script.IB_Connection := AConnection;
end;

procedure TfrmScript.IB_TransactionSourceAfterAssignment(
  Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
begin
  IB_Script.IB_Transaction := ATransaction;
  tbScript.IB_Transaction := ATransaction;
end;

{------------------------------------------------------------------------------}

procedure TfrmScript.btExecuteClick(Sender: TObject);
begin
  if CheckSaveChanges then
    with IB_Script do
      if Executing then
      begin
        if MessageDlg( M_SCRIPT_ABORT_EXECUTE,
                       mtConfirmation, mbOkCancel, 0) = mrOk then
          AbortExecuting;
      end
      else
        Execute;
end;

procedure TfrmScript.IB_ScriptBeforeExecute(Sender: TObject);
begin
  with IB_Script do
  begin
    Yield := cbYield.Checked;
    if SQL.Count = 0 then
      SQL.Assign( ScriptEdit.Lines );
    if Yield then
      btExecute.Caption := C_BF_CANCEL
    else
      btExecute.Enabled := false;
    btScriptCommands.Enabled := false;
  end;
end;

procedure TfrmScript.IB_ScriptAfterExecute(Sender: TObject);
begin
  btExecute.Caption := C_BF_EXECUTE;
  btExecute.Enabled := true;
  btScriptCommands.Enabled := true;
  with IB_Script do
    if ExecutingFailed then
      StatusBar.SimpleText := M_SCRIPT_FAILED
    else
    if ExecutingAborted then
      StatusBar.SimpleText := M_SCRIPT_WAS_ABORTED
    else
    if IgnoredExceptions = 0 then
      StatusBar.SimpleText := M_SCRIPT_COMPLETED
    else
      StatusBar.SimpleText := M_SCRIPT_CMPL_EXCEPT;
end;

procedure TfrmScript.btClearClick(Sender: TObject);
begin
  if CheckSaveChanges then
  begin
    ScriptEdit.Lines.Clear;
    ScriptEdit.SetFocus;
    FileLoaded := '';
    FileModified := false;
    UpdateCaption;
  end;
end;

procedure TfrmScript.btLoadClick(Sender: TObject);
begin
  if CheckSaveChanges then
    with odScript do
      if Execute then
      begin
        sdScript.Filename := FileName;
        ScriptEdit.Lines.LoadFromFile( FileName );
        FileModified := false;
        FileLoaded := FileName;
        cbStore.Checked := false;
        UpdateCaption;
      end;
end;

procedure TfrmScript.btSaveClick(Sender: TObject);
var
  tmpStrings: TIB_StringList;
begin
  with sdScript do
    if Execute then
    begin
      odScript.Filename := FileName;
      tmpStrings := TIB_StringList.Create;
      try
        tmpStrings.AddStrings( ScriptEdit.Lines );
        tmpStrings.SaveToFile( FileName );
        FileModified := false;
        FileLoaded := FileName;
        UpdateCaption;
      finally
        tmpStrings.Free;
      end;
    end;
end;

procedure TfrmScript.ScriptEditChange(Sender: TObject);
begin
  IB_Script.SQL.Clear;
  if ( FileLoaded <> '' ) then
  begin
    FileModified := true;
    UpdateCaption;
  end;
end;

procedure TfrmScript.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if IB_Script.Executing then
  begin
    CanClose := false;
    MessageBeep( 0 );
    ShowMessage( M_SCRIPT_IS_EXECUTING );
  end
  else
    CanClose := CheckSaveChanges;
end;

procedure TfrmScript.IB_ScriptError(Sender: TObject;
  const ERRCODE: Longint; ErrorMessage, ErrorCodes: TStringList;
  const SQLCODE: Longint; SQLMessage, SQL: TStringList;
  var RaiseException: Boolean);
begin
  if RaiseException then
    RaiseException := MessageDlg( ErrorMessage.Text +
                                  #13#10 +
                                  M_SCRIPT_CONTINUE_EXECUTING,
                                  mtConfirmation, [mbYes, mbNo], 0) <> mrYes;
end;

procedure TfrmScript.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

procedure TfrmScript.FormCreate(Sender: TObject);
begin
  inherited;
{$IFDEF IBO_VCL30_OR_GREATER}
  btExecute.Flat := true;
  btScriptCommands.Flat := true;
{$ENDIF}
end;

procedure TfrmScript.UpdateCaption;
var
  NewCaption: string;
begin
  if ( FileLoaded <> '' ) then
  begin
    if ( FPrevCaption = '' ) then
      FPrevCaption := Caption;
    NewCaption := FileLoaded;
    if ( FileModified ) then
      NewCaption := NewCaption + ' - ' + M_SCRIPT_MODIFIED;
  end
  else
  if ( FPrevCaption <> '' ) then
  begin
    NewCaption := FPrevCaption;
    FPrevCaption := '';
  end;
  if ( Caption <> NewCaption ) then
    Caption := NewCaption;
end;

function TfrmScript.CheckSaveChanges: boolean;
var
  tmpModalResult: word;
begin
  tmpModalResult := mrOk;
  if ( FileModified ) then
  begin
    tmpModalResult := MessageDlg( M_SCRIPT_SAVE_CHANGES,
                                  mtConfirmation,
                                  [mbYes, mbNo, mbCancel],
                                  0 );
    if ( tmpModalResult = mrYes ) then
    begin
      btSaveClick( Self );
      Result := not FileModified;
      Exit;
    end;
  end;
  Result := not FileModified or ( tmpModalResult <> mrCancel );
end;

procedure TfrmScript.FindMIClick(Sender: TObject);
begin
  FindDlg.Position := Self.ClientToScreen(
    Point(ScriptEdit.Left + 10, ScriptEdit.Top + 10) );
  FindDlg.Options := FindDlg.Options - [frFindNext];
  FindDlg.FindText := ScriptEdit.SelText;
  FindDlg.Execute;
end;

procedure TfrmScript.FindNextMIClick(Sender: TObject);
begin
  FindDlgFind( FindDlg );
end;

procedure TfrmScript.ReplaceMIClick(Sender: TObject);
begin
  ReplaceDlg.Position := Self.ClientToScreen(
    Point(ScriptEdit.Left + 10, ScriptEdit.Top + 10) );
  //ReplaceDlg.Options := ReplaceDlg.Options - [frFindNext];
  ReplaceDlg.FindText := ScriptEdit.SelText;
  ReplaceDlg.Execute;
end;

procedure TfrmScript.ClearMIClick(Sender: TObject);
begin
  ScriptEdit.Clear;
end;

procedure TfrmScript.CutMIClick(Sender: TObject);
begin
  ScriptEdit.CutToClipboard;
end;

procedure TfrmScript.CopyMIClick(Sender: TObject);
begin
  ScriptEdit.CopyToClipboard;
end;

procedure TfrmScript.PasteMIClick(Sender: TObject);
begin
  ScriptEdit.PasteFromClipboard;
end;

procedure TfrmScript.UndoMIClick(Sender: TObject);
begin
{$IFDEF IBO_VCL40_OR_GREATER}
  ScriptEdit.Undo;
{$ENDIF}  
end;

procedure TfrmScript.DeleteMIClick(Sender: TObject);
begin
  ScriptEdit.ClearSelection;
end;

procedure TfrmScript.SelectAllMIClick(Sender: TObject);
begin
  ScriptEdit.SelectAll;
end;

procedure TfrmScript.FindDlgFind(Sender: TObject);
var
  FoundAt: LongInt;
  StartPos, ToEnd: Integer;
  tmpTypes: TSearchTypes;
  ADialog: TFindDialog;
begin
  ADialog := Sender as TFindDialog;
  with ScriptEdit do
  begin
    StartPos := SelStart + SelLength;
    ToEnd := Length(Text) - StartPos;
    tmpTypes := [];
    if (frMatchCase in ADialog.Options) then
      tmpTypes := tmpTypes + [stMatchCase];
    if (frWholeWord in ADialog.Options) then
      tmpTypes := tmpTypes + [stWholeWord];
    FoundAt := FindText(ADialog.FindText, StartPos, ToEnd, tmpTypes);
    if FoundAt <> -1 then
    begin
      SetFocus;
      SelStart := FoundAt;
      SelLength := Length(ADialog.FindText);
    end;
  end;
end;

procedure TfrmScript.ReplaceDlgReplace(Sender: TObject);
var
  FoundAt: LongInt;
  StartPos, ToEnd: Integer;
  tmpTypes: TSearchTypes;
begin
  with ScriptEdit do
  begin
    while true do
    begin
      StartPos := SelStart + SelLength;
      ToEnd := Length(Text) - StartPos;
      tmpTypes := [];
      if (frMatchCase in ReplaceDlg.Options) then
        tmpTypes := tmpTypes + [stMatchCase];
      if (frWholeWord in ReplaceDlg.Options) then
        tmpTypes := tmpTypes + [stWholeWord];
      FoundAt := FindText(ReplaceDlg.FindText, StartPos, ToEnd, tmpTypes);
      if FoundAt <> -1 then
      begin
        SetFocus;
        SelStart := FoundAt;
        SelLength := Length(ReplaceDlg.FindText);
        SelText := ReplaceDlg.ReplaceText;
        SelStart := FoundAt + Length(ReplaceDlg.ReplaceText);
        if not(frReplaceAll in ReplaceDlg.Options) then
          break;
      end
      else
        break;
    end;
  end;
end;

procedure TfrmScript.ScriptMenuPopup(Sender: TObject);
begin
  with ScriptEdit do
  begin
    CutMI.Enabled :=  SelLength > 0;
    CopyMI.Enabled := CutMI.Enabled;
    PasteMI.Enabled := true;//Perform(EM_CANPASTE, 0, 0) <> 0;
    UndoMI.Enabled := true;//Perform(EM_CANUNDO, 0, 0) <> 0;
    DeleteMI.Enabled := CutMI.Enabled;
    FindMI.Enabled :=  Lines.Count > 0;
    FindNextMI.Enabled := FindMI.Enabled and (Length(FindDlg.FindText) > 0);
    ReplaceMI.Enabled :=  FindMI.Enabled;
    SelectAllMI.Enabled := FindMI.Enabled;
    ClearMI.Enabled := FindMI.Enabled;
    SaveToFileMI.Enabled := Lines.Count > 0;
    LoadFromFileMI.Enabled := true;
    ExecuteMI.Enabled := true; // let the btExecute button take care of cancel
  end;
end;

procedure TfrmScript.ShowScriptMenu(Sender: TObject);
var
  p: TPoint;
begin
  p.X := btScriptCommands.Left;
  p.Y := btScriptCommands.Top + btScriptCommands.Height;
  p := TitlePnl.ClientToScreen( p );
  ScriptMenu.Popup( p.X, p.Y );
end;

end.
