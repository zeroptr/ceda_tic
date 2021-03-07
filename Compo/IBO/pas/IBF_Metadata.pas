
{                                                                              }
{ IBF_Metadata                                                                 }
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
{     Updates to match changes to IB_Metadata.pas, plus expansion to provide   }
{     script commands for searching and manipulating the resulting script.     }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  07-Jan-2002                                                                 }
{     Original Author.                                                         }
{                                                                              }
{------------------------------------------------------------------------------}

{$INCLUDE IB_Directives.inc}

{: This unit contains the TfrmMetadataExtract dialog.}
unit IBF_Metadata;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, IB_SessionProps,
  IB_Components, IB_TransactionBar, IB_ConnectionBar,
  CheckLst, IBF_Base, IB_Metadata, Menus, Buttons, IB_ConnectionSource,
  IB_TransactionSource;

type
  {: Dialog for accessing TIB_Metadata (DDL extract) features.
See TIB_CustomMetadata for more details.}
  TfrmMetadataExtract = class(TfrmBase)
    BackingPnl: TPanel;
    Pages: TPageControl;
    ConfigurePg: TTabSheet;
    ScriptPg: TTabSheet;
    ScriptPnl: TPanel;
    ScriptEdit: TRichEdit;
    Metadata: TIB_Metadata;
    MetadataGrp: TGroupBox;
    CodeOptionsCL: TCheckListBox;
    CodeOptionsLbl: TLabel;
    EntitiesCL: TCheckListBox;
    EntitiesLbl: TLabel;
    TerminatorLbl: TLabel;
    TerminatorEB: TEdit;
    ExecuteGrp: TGroupBox;
    CodePassLbl: TLabel;
    CodePassCB: TComboBox;
    ExtractBtn: TButton;
    ResetBtn: TButton;
    ResetAllBtn: TButton;
    ProgressGrp: TGroupBox;
    StopBtn: TButton;
    ProgressBar: TProgressBar;
    EntityTypeLbl: TLabel;
    EntityNameLbl: TLabel;
    FilterPg: TTabSheet;
    FiltersTopPnl: TPanel;
    IncludeSystemCB: TCheckBox;
    NameMasksLbl: TLabel;
    FiltersClientPnl: TPanel;
    FiltersMemo: TMemo;
    ScriptBtnPnl: TPanel;
    sdScript: TSaveDialog;
    FindDlg: TFindDialog;
    ScriptMenu: TPopupMenu;
    SaveToFileMI: TMenuItem;
    RunScriptMI: TMenuItem;
    FindMI: TMenuItem;
    ReplaceMI: TMenuItem;
    ClearMI: TMenuItem;
    ScriptCommandsBtn: TSpeedButton;
    UndoMI: TMenuItem;
    CutMI: TMenuItem;
    CopyMI: TMenuItem;
    PasteMI: TMenuItem;
    DeleteMI: TMenuItem;
    Separator1MI: TMenuItem;
    SelectAllMI: TMenuItem;
    Separator2MI: TMenuItem;
    FindNextMI: TMenuItem;
    ReplaceDlg: TReplaceDialog;
    InsertCommitsCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure MetadataConfigure(Sender: TObject);
    procedure ExtractBtnClick(Sender: TObject);
    procedure ResetBtnClick(Sender: TObject);
    procedure ResetAllBtnClick(Sender: TObject);
    procedure MetadataProgress(Sender: TIB_CustomMetadata;
      var Proceed: Boolean);
    procedure StopBtnClick(Sender: TObject);
    procedure MetadataFilterByEntity(Sender: TIB_CustomMetadata;
      AType: TIB_EntityType; AEntity: TIB_DDLEntity;
      var AInclude: Boolean);
    procedure MetadataFilterByName(Sender: TIB_CustomMetadata;
      AType: TIB_EntityType; AName: String; var AInclude: Boolean);
    procedure ScriptCommandsBtnClick(Sender: TObject);
    procedure ScriptMenuPopup(Sender: TObject);
    procedure SaveToFileMIClick(Sender: TObject);
    procedure RunScriptMIClick(Sender: TObject);
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
    procedure csBaseAfterAssignment(Sender: TIB_ConnectionLink;
      AConnection: TIB_Connection);
    procedure tsBaseAfterAssignment(Sender: TIB_TransactionLink;
      ATransaction: TIB_Transaction);
  private
    { Private declarations }
    FInternalUpd: boolean;
    FStopClicked: boolean;
  public
    { Public declarations }
  end;

var
  frmMetadataExtract: TfrmMetadataExtract;

implementation

{$R *.DFM}

uses IB_Utils, IB_Constants, IBF_Script;

procedure TfrmMetadataExtract.FormCreate(Sender: TObject);
var
  tmpOpt: TIB_DDLCodeOption;
  tmpEnt: TIB_DDLExtractType;
begin
  // Initialise the controls from Metadata instance at startup.
  FInternalUpd := true;
  try
    Caption := STR_DDL_DialogCaption;
    ConfigurePg.Caption := STR_DDL_Configure;
    FilterPg.Caption := STR_DDL_Filters;
    ScriptPg.Caption := STR_DDL_Script;
    MetadataGrp.Caption := STR_DDL_MetadataControls;
    CodeOptionsLbl.Caption := STR_DDL_CodeOptions;
    EntitiesLbl.Caption := STR_DDL_Entities;
    TerminatorLbl.Caption := STR_DDL_Terminator;
    InsertCommitsCB.Caption := STR_DDL_InsertCommits;
    ExecuteGrp.Caption := STR_DDL_ExecuteControls;
    CodePassLbl.Caption := STR_DDL_CodePass;
    ExtractBtn.Caption := STR_DDL_ExtractToStrings;
    ResetBtn.Caption := STR_DDL_Reset;
    ResetAllBtn.Caption := STR_DDL_ResetAll;
    ProgressGrp.Caption := STR_DDL_ProgressControls;
    StopBtn.Caption := STR_DDL_Stop;
    IncludeSystemCB.Caption := STR_DDL_IncludeSystem;
    NameMasksLbl.Caption := STR_DDL_NameMasks;
    ScriptCommandsBtn.Caption := STR_DDL_ScriptCommands;
    CutMI.Caption := C_BTN_CUT;
    CopyMI.Caption := C_BTN_COPY;
    PasteMI.Caption := C_BTN_PASTE;
    UndoMI.Caption := C_BTN_UNDO;
    DeleteMI.Caption := C_BTN_DELETE;
    FindMI.Caption := C_BTN_FIND;
    FindNextMI.Caption := C_BTN_FINDNEXT;
    ReplaceMI.Caption := C_BTN_REPLACE;
    SelectAllMI.Caption := C_BTN_SELECTALL;
    ClearMI.Caption := C_BTN_CLEAR;
    SaveToFileMI.Caption := STR_DDL_SaveToFile;
    RunScriptMI.Caption := STR_DDL_RunScript;
    for tmpOpt := Low(TIB_DDLCodeOption) to High(TIB_DDLCodeOption) do
    begin
      CodeOptionsCL.Items.Add( CodeOptionToText( tmpOpt ) );
      CodeOptionsCL.Checked[Ord(tmpOpt)] := (tmpOpt in Metadata.CodeOptions);
    end;
    for tmpEnt := Low(TIB_DDLExtractType) to High(TIB_DDLExtractType) do
    begin
      EntitiesCL.Items.Add( EntityTypeToText( tmpEnt ) );
      EntitiesCL.Checked[Ord(tmpEnt)] := (tmpEnt in Metadata.Entities);
    end;
    TerminatorEB.Text := Metadata.Terminator;
    InsertCommitsCB.Checked := (Metadata.InsertCommits <> []);
    CodePassCB.ItemIndex := 0;
    {$IFDEF IBO_VCL30_OR_GREATER}
    ScriptCommandsBtn.Flat := true;
    {$ENDIF}
  finally
    FInternalUpd := false;
  end;
end;

procedure TfrmMetadataExtract.MetadataConfigure(Sender: TObject);
var
  i: integer;
  tmpOpt: TIB_DDLCodeOptions;
  tmpEnt: TIB_DDLExtractTypes;
begin
  if FInternalUpd then
    Exit;
  if Sender = CodeOptionsCL then
  begin
    tmpOpt := [];
    for i := 0 to CodeOptionsCL.Items.Count - 1 do
      if CodeOptionsCL.Checked[i] then
        tmpOpt := tmpOpt + [ TIB_DDLCodeOption(i) ];
    Metadata.CodeOptions := tmpOpt;
  end
  else
  begin
    if Sender = EntitiesCL then
    begin
      tmpEnt := [];
      for i := 0 to EntitiesCL.Items.Count - 1 do
        if EntitiesCL.Checked[i] then
          tmpEnt := tmpEnt + [ TIB_DDLExtractType(i) ];
      Metadata.Entities := tmpEnt;
    end
    else
    begin
      if Sender = TerminatorEB then
      begin
        if Length(TerminatorEB.Text) > 0 then
          Metadata.Terminator := TerminatorEB.Text;
      end
      else
      begin
        if Sender = CodePassCB then
        begin
          if CodePassCB.ItemIndex >= 0 then
            Metadata.CodePass := TIB_DDLCodePass(CodePassCB.ItemIndex);
        end
        else
        begin
          if Sender = InsertCommitsCB then
          begin
            if InsertCommitsCB.Checked then
              Metadata.InsertCommits := [icAfterInitPass, icAfterFinalPass,
                icAfterLevel1, icAfterLevel2, icAfterEachType]
            else
              Metadata.InsertCommits := [];
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMetadataExtract.ExtractBtnClick(Sender: TObject);
var
  tmpStrs: TStrings;
begin
  tmpStrs := TStringList.Create;
  FStopClicked := false;
  MetadataGrp.Enabled := false;
  ExecuteGrp.Visible := false;
  ProgressGrp.Visible := true;
  try
    Metadata.ExtractToStrings( tmpStrs );
    ScriptEdit.Lines.Text := tmpStrs.Text;
    // You could write directly to the memo lines as in:
    // Metadata.ExtractToStrings( ScriptEdit.Lines );
    // which will _concatenate_ the text to the supplied
    // memo directly.  However this can have performance
    // implications if the generated script is very large.
  finally
    MetadataGrp.Enabled := true;
    ExecuteGrp.Visible := true;
    ProgressGrp.Visible := false;
    tmpStrs.Free;
  end;
  Pages.ActivePage := ScriptPg;
  ScriptEdit.SetFocus;
  ScriptEdit.SelStart := 0; // put us back at the top
end;

procedure TfrmMetadataExtract.ResetBtnClick(Sender: TObject);
begin
  Metadata.Reset;
end;

procedure TfrmMetadataExtract.ResetAllBtnClick(Sender: TObject);
begin
  Metadata.ResetAll;
end;

procedure TfrmMetadataExtract.MetadataProgress(Sender: TIB_CustomMetadata;
  var Proceed: Boolean);
begin
  ProgressBar.Position := Sender.ProgressPerc;
  EntityTypeLbl.Caption := EntityTypeToText(Sender.CurrType);
  if Sender.CurrEntity = nil then
    EntityNameLbl.Caption := '?'
  else
    EntityNameLbl.Caption := Sender.CurrEntity.Name;
  Proceed := not FStopClicked;
  Application.ProcessMessages;
end;

procedure TfrmMetadataExtract.StopBtnClick(Sender: TObject);
begin
  FStopClicked := true;
end;

procedure TfrmMetadataExtract.MetadataFilterByEntity(Sender: TIB_CustomMetadata;
  AType: TIB_EntityType; AEntity: TIB_DDLEntity; var AInclude: Boolean);
begin
  // By default all SystemFlag or Implicit definitions are filtered
  // (AInclude = false) whereas all other entities already have AInclude
  // set to true.  So to in include system objects just test and set.
  if (IncludeSystemCB.Checked) and
    (AEntity.SystemFlag and not AEntity.IsImplicit) then
    AInclude := true;
end;

procedure TfrmMetadataExtract.MetadataFilterByName(Sender: TIB_CustomMetadata;
  AType: TIB_EntityType; AName: String; var AInclude: Boolean);
var
  i: integer;
  tmpPattern, tmpStr: string;
begin
  // Name filtering is done before ByEntity filtering (to assist performance
  // by not having to retrieve items not required by name).  So all entities
  // including system names are parsed through this event.
  // - - -
  // To support filtering by name, the FiltersMemo can support input
  // of values in the format:
  //    <entity_type>.<name_mask>
  // or just
  //    <name_mask>
  // Where <entity_type> is the name of the entity returned by the the
  // EntityTypeToText function (and returned value may be locale specific).
  // The <name_mask> should contain mask values supported by the IsMatch
  // function defined in IB_Utils.  The first entry found which matches
  // will be used and the rest ignored.
  // If any name_mask is specified without a prefixing type then it
  // will match any entity type.
  // - - -
  // Do NOT include quotes around identifiers.
  // - - -
  AInclude := false;
  tmpStr := EntityTypeToText( AType ) + '.' + AName;
  for i := 0 to FiltersMemo.Lines.Count - 1 do
  begin
    tmpPattern := FiltersMemo.Lines.Strings[i];
    if ((Length(tmpPattern) > 0) and (Length(AName) > 0)) and
      (IsMatch( tmpPattern, tmpStr ) or IsMatch( tmpPattern, AName )) then
    begin
      AInclude := true;
      break;
    end;
  end;
end;

procedure TfrmMetadataExtract.ScriptCommandsBtnClick(Sender: TObject);
var
  p: TPoint;
begin
  p.X := ScriptCommandsBtn.Left;
  p.Y := ScriptCommandsBtn.Top + ScriptCommandsBtn.Height;
  p := ScriptBtnPnl.ClientToScreen( p );
  ScriptMenu.Popup( p.X, p.Y );
end;

procedure TfrmMetadataExtract.ScriptMenuPopup(Sender: TObject);
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
    SaveToFileMI.Enabled := FindMI.Enabled;
    RunScriptMI.Enabled := FindMI.Enabled;
  end;
end;

procedure TfrmMetadataExtract.SaveToFileMIClick(Sender: TObject);
begin
  with sdScript do
    if Execute then
    begin
      ScriptEdit.PlainText := true;
      ScriptEdit.Lines.SaveToFile( FileName );
    end;
end;

procedure TfrmMetadataExtract.RunScriptMIClick(Sender: TObject);
begin
  with TfrmScript.CreateWithContext(
    Self,
    BaseKey + '\Script',
    BaseConnection,
    BaseTransaction ) do
  try
    ScriptEdit.Text := Self.ScriptEdit.Text;
    // We show modal to avoid getting confusion between the script form
    // created by this code and script forms generated in other ways.
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmMetadataExtract.FindMIClick(Sender: TObject);
begin
  FindDlg.Position := ScriptPnl.ClientToScreen(
    Point(ScriptEdit.Left + 10, ScriptEdit.Top + 10) );
  FindDlg.Options := FindDlg.Options - [frFindNext];
  FindDlg.FindText := ScriptEdit.SelText;
  FindDlg.Execute;
end;

procedure TfrmMetadataExtract.FindNextMIClick(Sender: TObject);
begin
  FindDlgFind( FindDlg );
end;

procedure TfrmMetadataExtract.ReplaceMIClick(Sender: TObject);
begin
  ReplaceDlg.Position := ScriptPnl.ClientToScreen(
    Point(ScriptEdit.Left + 10, ScriptEdit.Top + 10) );
  //ReplaceDlg.Options := ReplaceDlg.Options - [frFindNext];
  ReplaceDlg.FindText := ScriptEdit.SelText;
  ReplaceDlg.Execute;
end;

procedure TfrmMetadataExtract.ClearMIClick(Sender: TObject);
begin
  ScriptEdit.Clear;
end;

procedure TfrmMetadataExtract.CutMIClick(Sender: TObject);
begin
  ScriptEdit.CutToClipboard;
end;

procedure TfrmMetadataExtract.CopyMIClick(Sender: TObject);
begin
  ScriptEdit.CopyToClipboard;
end;

procedure TfrmMetadataExtract.PasteMIClick(Sender: TObject);
begin
  ScriptEdit.PasteFromClipboard;
end;

procedure TfrmMetadataExtract.UndoMIClick(Sender: TObject);
begin
{$IFDEF IBO_VCL40_OR_GREATER}
  ScriptEdit.Undo;
{$ENDIF}  
end;

procedure TfrmMetadataExtract.DeleteMIClick(Sender: TObject);
begin
  ScriptEdit.ClearSelection;
end;

procedure TfrmMetadataExtract.SelectAllMIClick(Sender: TObject);
begin
  ScriptEdit.SelectAll;
end;

procedure TfrmMetadataExtract.FindDlgFind(Sender: TObject);
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

procedure TfrmMetadataExtract.ReplaceDlgReplace(Sender: TObject);
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

procedure TfrmMetadataExtract.csBaseAfterAssignment(
  Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
begin
  Metadata.IB_Connection := BaseConnection;
end;

procedure TfrmMetadataExtract.tsBaseAfterAssignment(
  Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
begin
  Metadata.IB_Transaction := BaseTransaction;
end;

end.
