
{                                                                              }
{ IBF_Base                                                                     }
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

{: This unit contains the form base class used in the IB_SQL tool and the
component editors for various data access components.
<br><br>
I also use this in numerous applications and find it to be very useful.}
unit
  IBF_Base;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Registry,

  IB_Constants,
  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource;

type
{: This form class is used to simplify often used features needed in the
forms of the IB_SQL tool, which forms are also used in the various
component editors used at design-time.
<br><br>
It makes it easy to save and retreive settings from the registry database.
<br><br>
It automatically stores and restores the form's position on the screen.
<br><br>
It makes it easy to design connection and transaction independant forms that
can quickly adjust upon setting a single property.
<br><br>
It also provides either a status bar or a panel with five buttons for use as
a dialog. They are for my component editor forms. The Apply and Browse buttons
are on their own panel so that it can be made invisible and the others will
slide over to the edge.
<br><br>
The streaming behavior of this form class is activated by setting values to
the BaseKey, Layout and SubKey properties.
<br><br>
The BaseConnection and BaseTransaction properties define the connection and
transaction context of the form. The buttons are also hooked into the
BaseTransaction such that they will reflect the transaction status and take
action on the transaction. Closing the form will also check the transaction
status. These actions only take place if the form also owns the transaction
that it the base transaction.
<br><br>
There are various protected virtual methods that can be hooked into when using
a sub-class of this form. Please refer to the source for more information. The
Lobbyist sample application demonstrates how to use this form class.}
TfrmBase = class( TForm )
  StatusBar: TStatusBar;
  tsBase: TIB_TransactionSource;
  csBase: TIB_ConnectionSource;
  pnClose: TPanel;
  pnOKCancelButtons: TPanel;
  btOK: TButton;
  btCancel: TButton;
  pnApplyButton: TPanel;
  btApply: TButton;
  pnHelpButton: TPanel;
  btHelp: TButton;
  pnBrowseButton: TPanel;
  btBrowse: TButton;
  procedure FormClose(Sender: TObject; var Action: TCloseAction);
  procedure btOKClick(Sender: TObject);
  procedure btCancelClick(Sender: TObject);
  procedure btApplyClick(Sender: TObject);
  procedure FormDeactivate(Sender: TObject);
  procedure FormActivate(Sender: TObject);
  procedure btHelpClick(Sender: TObject);
  procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  function GetIB_Session: TIB_Session;
  procedure btBrowseClick(Sender: TObject);
private
{ Private declarations }
  FRegDB: TRegINIFile;
  FBaseKey: string;
  FSubKey: string;
  FDefaultTop: word;
  FDefaultLeft: word;
  FDefaultHeight: word;
  FDefaultWidth: word;
  LastLayout: string;
  FLayoutNames: TIB_StringList;
  FSaveSettings: boolean;
  FSaveLayout: boolean;
  FSettingsSaved: boolean;
  FLayoutSaved: boolean;
  FNonModalEditor: boolean;
  FLastFocusedDataSource: TIB_DataSource;
  FConstructingLevel: integer;
{$IFNDEF IBO_VCL30_OR_GREATER}
  FPrevHelpFile: string;
  FHelpFile: string;
  procedure SetHelpFile( AHelpFile: string );
{$ENDIF}
{$IFNDEF  IBO_VCL40_OR_GREATER}
  function GetFormState: TFormState;
{$ENDIF}
private
  FDefaultTransaction: TIB_TransactionDefault;
  FWorkUnitNumber: integer;
  FAlwaysSaveSettings: boolean;
protected
  FLayout: string;
  procedure Notification( AComponent: TComponent;
                          Operation: TOperation); override;
  procedure Loaded; override;
{ Not intended for use but made protected and vitual just in case. }
  procedure AfterCompleteWorkUnit( Commit: boolean ); virtual;
  procedure BeforeCompleteWorkUnit( Commit: boolean ); virtual;
  procedure DoRefreshButtons; virtual;
  procedure DoStartWorkUnit; virtual;
  procedure SysStartWorkUnit;
  procedure SysCompleteWorkUnit( Commit: boolean );
  procedure CheckFormPosition; virtual;
  procedure SetBaseKey( AValue: string ); virtual;
  procedure SetSubKey( AValue: string ); virtual;
  procedure SetLayout( AValue: string ); virtual;
  function GetFullKey: string; virtual;
  function GetConnection: TIB_Connection; virtual;
  procedure SetConnection( AValue: TIB_Connection ); virtual;
  function GetTransaction: TIB_Transaction; virtual;
  procedure SetTransaction( AValue: TIB_Transaction ); virtual;
{ Can be overridden to stream in/out settings. }
  procedure ReadInSettings; virtual;
  procedure WriteOutSettings; virtual;
  procedure ReadInLayout; virtual;
  procedure WriteOutLayout; virtual;
{ Use these in later sub-class forms }
  procedure DoBrowseClick; virtual;
  procedure DoReadSettings; virtual;
  procedure DoWriteSettings; virtual;
  procedure DoReadLayout; virtual;
  procedure DoWriteLayout; virtual;
  procedure DoHelpClick; virtual;
  procedure AddLayout( NewLayout: string ); virtual;
  procedure RemoveLayout( OldLayout: string ); virtual;
  procedure WriteStrings( Key: string; Dest: TStrings );
  procedure ReadStrings( Key: string; Dest: TStrings );
  procedure SetDefaultBounds(ALeft, ATop, AWidth, AHeight: Integer);
  property AlwaysSaveSettings: boolean read FAlwaysSaveSettings
                                       write FAlwaysSaveSettings;
  property ConstructingLevel: integer read FConstructingLevel;
public
{ Inherited Methods }

{$IFNDEF HELPSCAN}
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
{$ENDIF}

{ Public declarations }

{: This class constructor is designed to create an instance of this form and
provide for it some context so that it will mesh into the existing flow of
forms in a user's application.}
  constructor CreateWithContext( AOwner: TComponent;
                                 ABaseKey: string;
                                 ABaseConnection: TIB_Connection;
                                 ABaseTransaction: TIB_Transaction ); virtual;
{: This tells how many units of work have been processed.
<br><br>
It will show 0 for forms that intend to close as soon as OK or Cancel is hit.
Otherwise, each time a unit of work is processed this number will be
incremented.}
  property WorkUnitNumber: integer read FWorkUnitNumber;
{: This method will cause the code that is responsible to refresh the buttons
at the bottom of the form to have their captions and enabled state refreshed.
<br><br>
It will also activate the DoRefreshButtons protected virtual method for all
forms that have subclassed and overridden this method.}
  procedure RefreshButtons; virtual;
{: This method is used to initialize an instance of this form right after it
has been instantiated and the constructor is at the end of completion.}
  procedure Initialize; virtual;
{: This property gives access to the registry database when streaming
values in and out of an application.}
  property RegDB: TRegINIFile read FRegDB;
{: When accessing the registry database this serves as the base key that
is referenced.}
  property BaseKey: string read FBaseKey write SetBaseKey;
{: In addition to the BaseKey this is used to store settings in a specific
place in the registry database on top of the BaseKey location.}
  property SubKey: string read FSubKey write SetSubKey;
{: This property gives a reference to the current full key reference into
the registry database. It takes into consideration any layout that may be
active.}
  property FullKey: string read GetFullKey;
{: This is the default component session.}
  property IB_Session: TIB_Session read GetIB_Session;
{: Each BaseKey can host multiple layouts which serve as an additional
level of depth in the registry database.}
  property Layout: string read FLayout write SetLayout;
{: Thisproperty provides a list of all availiable layout names stored at the
current BaseKey location in the registry database.}
  property LayoutNames: TIB_StringList read FLayoutNames;
{: Stores whether or not the form instance is being used as a non-modal
component editor.}
  property NonModalEditor: boolean read FNonModalEditor write FNonModalEditor;
{: This property indicates whether or not settings should be streamed out
to the registry database when the BaseKey is closed.}
  property SaveSettings: boolean read FSaveSettings write FSaveSettings;
{: This property indicates whether or not settings should be streamed out
to the registry database when the current layout is closed.}
  property SaveLayout: boolean read FSaveLayout write FSaveLayout;
{: This property indicates whether or not any settings were saved after the
BaseKey registry location was closed.}
  property SettingsSaved: boolean read FSettingsSaved;
{: This property indicates whether or not any settings were saved when the
current layout was closed.}
  property LayoutSaved: boolean read FLayoutSaved;
{: This is the default connection for this form. It is here for convenience
in making a form generic and quickly able to adapt to any connection.
<br><br>
I suggest that you use the AfterAssignment event of the IB_ConnectionSource
in order to make IB_Connection assignments to all components on the form
that depend upon the IB_Connection or IB_Database.}
  property BaseConnection: TIB_Connection read GetConnection
                                          write SetConnection;
{: This is the default transaction for this form. It is here for convenience
in making a form generic and quickly able to adapt to any transaction.
<br><br>
I suggest that you use the AfterAssignment event of the IB_TransactionSource
in order to make IB_Transaction assignments to all components on the form
that depend upon the IB_Transaction context.}
  property BaseTransaction: TIB_Transaction read GetTransaction
                                            write SetTransaction;
published
{$IFNDEF  IBO_VCL40_OR_GREATER}
  property FormState: TFormState read GetFormState;
{$ENDIF}
{$IFNDEF IBO_VCL30_OR_GREATER}
  property HelpFile: string read FHelpFile write SetHelpFile;
{$ENDIF}

end;

TIB_BaseFormClass = class of TfrmBase;

implementation

{$R *.DFM}

constructor TfrmBase.Create( AOwner: TComponent );
begin
  FLayoutNames := TIB_StringProperty.Create;
  inherited Create( AOwner );
  FLayout := EmptyStr;
  FLayoutNames.Sorted := true;
  FSaveSettings := true;
  FSaveLayout := true;
end;

constructor TfrmBase.CreateWithContext( AOwner: TComponent;
                                        ABaseKey: string;
                                        ABaseConnection: TIB_Connection;
                                        ABaseTransaction: TIB_Transaction );
var
  ii: integer;
begin
  Inc( FConstructingLevel );
  try
  Create( AOwner );
  BaseConnection := ABaseConnection;
  if not Assigned( BaseConnection ) and IB_Session.AllowDefaultConnection then
    BaseConnection := IB_Session.DefaultConnection;
  if Assigned( ABaseTransaction ) then
    BaseTransaction := ABaseTransaction;
  if Assigned( BaseConnection ) and not Assigned( BaseTransaction ) then
  begin
    if not Assigned( FDefaultTransaction ) then
      FDefaultTransaction := TIB_TransactionDefault.Create( Self );
    FDefaultTransaction.IB_Connection := BaseConnection;
    BaseTransaction := FDefaultTransaction;
  end;
  for ii := 0 to ComponentCount - 1 do
    if Components[ii] is TIB_Statement then
      with Components[ii] as TIB_Statement do
      begin
        if Assigned( BaseConnection ) and not Assigned( IB_Connection ) then
          IB_Connection := BaseConnection;
        if Assigned( BaseTransaction ) and not Assigned( IB_Transaction ) then
          IB_Transaction := BaseTransaction;
      end;
  if (( ABaseKey = EmptyStr ) or ( ABaseKey[1] = '\' )) and
     ( AOwner is TfrmBase ) then
  begin
    if ( ABaseKey = EmptyStr ) then
      BaseKey := ( AOwner as TfrmBase ).BaseKey + Self.ClassName
    else
      BaseKey := ( AOwner as TfrmBase ).BaseKey + ABaseKey;
  end
  else
    BaseKey := ABaseKey;
  Initialize;
  finally
    Dec( FConstructingLevel );
  end;
end;

destructor TfrmBase.Destroy;
begin
  try
    BaseKey := '';
  except
  end;
//  Destroying; This caused a lockup if exception was raised during constructor.
  BaseConnection := nil;
  BaseTransaction := nil;
  inherited Destroy;
  FLayoutNames.Free;
  FLayoutNames := nil;
end;

procedure TfrmBase.Notification( AComponent: TComponent;
                                 Operation: TOperation);
begin
  inherited Notification( AComponent, Operation );
  if Operation = opRemove then
    if AComponent = FLastFocusedDataSource then
      FLastFocusedDataSource := nil;
end;

procedure TfrmBase.Loaded;
begin
  inherited Loaded;
  CheckFormPosition;
end;

procedure TfrmBase.CheckFormPosition;
begin
  if        Width > Screen.Width then Width := Screen.Width - 2;
  if Left + Width > Screen.Width then Left := Screen.Width - Width - 1;
  if       Height > Screen.Height then Height := Screen.Height - 2;
  if Top + Height > Screen.Height then Top := Screen.Height - Height - 1;
end;

function TfrmBase.GetIB_Session: TIB_Session;
begin
  Result := csBase.IB_Session;
end;

procedure TfrmBase.SetBaseKey( AValue: string );
begin
  if FBaseKey <> AValue then
  begin
    SubKey := EmptyStr;
    WriteOutSettings;
    FBaseKey := AValue;
    try
      ReadInSettings;
    except
      SaveSettings := false;
      raise;
    end;
  end;
end;

procedure TfrmBase.SetSubKey( AValue: string );
begin
  if SubKey <> AValue then
  begin
    // Determine if the registry is busy somehwere else.
    if ( SubKey = EmptyStr ) and ( RegDB <> nil ) then
      raise Exception.Create( 'Cannot change sub-key' );
    // Close any existing INI session.
    if RegDB <> nil then
    begin
      FRegDB.Free;
      FRegDB := nil;
    end;
    // Update the new value for SubKey.
    FSubKey := AValue;
    // Open the new INI session.
    if SubKey <> EmptyStr then
    begin
      if CompareText( SubKey, 'Current' ) = 0 then
        FRegDB := TRegINIFile.Create( FullKey )
      else
        FRegDB := TRegINIFile.Create( FullKey + '\' + SubKey );
    end;
  end;
end;

procedure TfrmBase.SetLayout( AValue: string );
begin
  AValue := Trim( AValue );
  if FLayout <> AValue then
  begin
    SubKey := EmptyStr;
    WriteOutLayout;
    FLayout := AValue;
    if Layout <> EmptyStr then
      with LayoutNames do
        if IndexOf( Layout ) = -1 then
          AddLayout( Layout );
    ReadInLayout;
  end;
end;

function TfrmBase.GetConnection: TIB_Connection;
begin Result := csBase.IB_Connection; end;
procedure TfrmBase.SetConnection( AValue: TIB_Connection );
begin csBase.IB_Connection := AValue; end;
function TfrmBase.GetTransaction: TIB_Transaction;
begin Result := tsBase.IB_Transaction; end;
procedure TfrmBase.SetTransaction( AValue: TIB_Transaction );
begin tsBase.IB_Transaction := AValue; end;

function TfrmBase.GetFullKey: string;
begin
  if Layout <> EmptyStr then
    Result := BaseKey + '\LAYOUTS\' + Layout
  else
    Result := BaseKey;
end;

procedure TfrmBase.WriteStrings( Key: string; Dest: TStrings );
begin
  with FRegDB do
  begin
    EraseSection( Key ); // This removes the old system of storing stringlists.
    if Dest <> nil then
      WriteString( EmptyStr, Key, Dest.CommaText )
    else
      WriteString( EmptyStr, Key, EmptyStr );
  end;
end;

procedure TfrmBase.ReadStrings( Key: string; Dest: TStrings );
var
  ii: integer;
  tmpStr: string;
begin
  with FRegDB do
  begin
    ii := 0;
    Dest.BeginUpdate;
    try
      while ReadString( Key, IntToStr( ii ),'<**>' ) <> '<**>' do
      begin
        if ii = 0 then
          Dest.Clear;
        Dest.Add( ReadString( Key, IntToStr( ii ), EmptyStr ));
        Inc( ii );
      end;
      if ii = 0 then
      begin
        tmpStr := ReadString( EmptyStr, Key, '<**>' );
        if tmpStr <> '<**>' then
          Dest.CommaText := tmpStr;
      end
      else
      // Clear out the old system of storing stringlists.
        WriteStrings( Key, Dest );
    finally
      Dest.EndUpdate;
    end;
  end;
end;

procedure TfrmBase.ReadInSettings;
var
  ATop, ALeft, AHeight, AWidth: integer;
  AMaximized: boolean;
begin
  if BaseKey <> EmptyStr then
  begin
    FRegDB := TRegINIFile.Create( BaseKey );
    try
      with FRegDB do
      begin
        AMaximized := ReadBool( 'Settings', 'Maximized', false );
        ATop    := ReadInteger( 'Settings', 'TOP',    FDefaultTop );
        ALeft   := ReadInteger( 'Settings', 'LEFT',   FDefaultLeft );
        AHeight := ReadInteger( 'Settings', 'HEIGHT', FDefaultHeight );
        AWidth  := ReadInteger( 'Settings', 'WIDTH',  FDefaultWidth );
      end;
      if ( AHeight <> 0 ) and ( AWidth <> 0 ) then
        SetBounds( ALeft, ATop, AWidth, AHeight );
      if AMaximized then
        WindowState := wsMaximized;
      CheckFormPosition;
      ReadStrings( 'LayoutNames', LayoutNames );
      DoReadSettings;
      with FRegDB do
        LastLayout := ReadString( 'Settings', 'LAYOUT', EmptyStr );
    finally
      FRegDB.Free;
      FRegDB := nil;
    end;
    Layout := LastLayout;
  end;
end;

procedure TfrmBase.WriteOutSettings;
var
  LastLayout: string;
begin
  if Layout <> EmptyStr then
  begin
    LastLayout := Layout;
    Layout := EmptyStr;
  end;
  if SaveSettings and ( BaseKey <> EmptyStr ) then
  begin
    FRegDB := TRegINIFile.Create( BaseKey );
    try
      with FRegDB do
      begin
        WriteBool( 'Settings', 'Maximized', WindowState = wsMaximized );
        WindowState := wsNormal;
        WriteInteger( 'Settings','TOP', Top );
        WriteInteger( 'Settings','LEFT', Left );
        WriteInteger( 'Settings','HEIGHT', Height );
        WriteInteger( 'Settings','WIDTH', Width );
        WriteString( 'Settings', 'LAYOUT', LastLayout );
      end;
      DoWriteSettings;
      WriteStrings( 'LayoutNames', LayoutNames );
    finally
      FRegDB.Free;
      FRegDB := nil;
    end;
    FSettingsSaved := true;
  end;
end;

procedure TfrmBase.ReadInLayout;
begin
  if ( BaseKey <> EmptyStr ) and ( Layout <> EmptyStr ) then
  begin
    FRegDB := TRegINIFile.Create( FullKey );
    try
      DoReadLayout;
    finally
      FRegDB.Free;
      FRegDB := nil;
    end;
  end;
end;

procedure TfrmBase.WriteOutLayout;
begin
  if ( BaseKey <> EmptyStr ) and ( Layout <> EmptyStr ) then
  begin
    FRegDB := TRegINIFile.Create( FullKey );
    try
      if SaveLayout then
        DoWriteLayout;
    finally
      FRegDB.Free;
      FRegDB := nil;
    end;
    FLayoutSaved := true;
  end;
end;

procedure TfrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmBase.SetDefaultBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  FDefaultLeft := ALeft;
  FDefaultTop := ATop;
  FDefaultWidth := AWidth;
  FDefaultHeight := AHeight;
end;

procedure TfrmBase.AddLayout( NewLayout: string );
begin
  LayoutNames.Add( NewLayout );
end;

procedure TfrmBase.RemoveLayout( OldLayout: string );
var
  ii: integer;
begin
  if Layout = OldLayout then
    Layout := EmptyStr;
  with LayoutNames do
  begin
    ii := IndexOf( OldLayout );
    if ii <> -1 then
    begin
      with TRegINIFile.Create( BaseKey + '\LAYOUTS' ) do try
        EraseSection( Strings[ii] );
      finally
        Free;
      end;
      Delete( ii );
    end;
  end;
end;

{$IFNDEF  IBO_VCL40_OR_GREATER}
{$HINTS OFF}
type
THackFormBaseClass = class(TScrollingWinControl)
private
  FActiveControl: TWinControl;
  FFocusedControl: TWinControl;
  FBorderIcons: TBorderIcons;
  FBorderStyle: TFormBorderStyle;
  FWindowState: TWindowState;
  FShowAction: TShowAction;
  FKeyPreview: Boolean;
  FActive: Boolean;
  FFormStyle: TFormStyle;
  FPosition: TPosition;
  FTileMode: TTileMode;
  FFormState: TFormState;
end;
{$HINTS ON}

function TfrmBase.GetFormState: TFormState;
begin
  Result := THackFormBaseClass( Self ).FFormState;
end;
{$ENDIF}

{$IFNDEF IBO_VCL30_OR_GREATER}
procedure TfrmBase.SetHelpFile( AHelpFile: string );
begin
  if HelpFile <> AHelpFile then
  begin
    if FPrevHelpFile = EmptyStr then
      FPrevHelpFile := Application.HelpFile;
    FHelpFile := AHelpFile;
    Application.HelpFile := AHelpFile;
  end;
end;
{$ENDIF}

procedure TfrmBase.FormActivate(Sender: TObject);
begin
{$IFNDEF IBO_VCL30_OR_GREATER}
  if FPrevHelpFile = EmptyStr then
    FPrevHelpFile := Application.HelpFile;
{$ENDIF}
  if NonModalEditor then 
    ReadInSettings;
  if Assigned( FLastFocusedDataSource ) then
    FLastFocusedDataSource.SetFocus;
end;

procedure TfrmBase.FormDeactivate(Sender: TObject);
begin
{$IFNDEF IBO_VCL30_OR_GREATER}
  Application.HelpFile := FPrevHelpFile;
{$ENDIF}
  if NonModalEditor then
    WriteOutSettings;
  FLastFocusedDataSource := IB_Session.FocusedDataSource;
  if Assigned( FLastFocusedDataSource ) then
    FLastFocusedDataSource.FreeNotification( Self );
end;

procedure TfrmBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
  if Assigned( BaseTransaction ) and ( BaseTransaction.Owner = Self ) then
  begin
    ModalResult := BaseTransaction.CloseWithConfirm;
    CanClose := ModalResult = mrOk;
  end;
end;

procedure TfrmBase.btOKClick( Sender: TObject );
begin
  SaveSettings := true;
  SaveLayout := true;
  if ( Assigned( BaseTransaction )) and
     ( BaseTransaction.Owner = Self ) then
    SysCompleteWorkUnit( true );
  if WorkUnitNumber = 0 then
    if fsModal in FormState then
      ModalResult := mrOk
    else
      Close;
end;

procedure TfrmBase.btCancelClick(Sender: TObject);
var
  tmpStr: string;
begin
  SaveSettings := FAlwaysSaveSettings;
  SaveLayout := FAlwaysSaveSettings;
  if ( Assigned( BaseTransaction )) and
     ( BaseTransaction.Owner = Self ) and
     ( BaseTransaction.TransactionIsActive ) then
  begin
    tmpStr := Trim( BaseTransaction.ConfirmCancelPrompt.Text );
    if tmpStr = EmptyStr then
      tmpStr := M_CancelTransactionPrompt;
    if MessageDlg( tmpStr, mtConfirmation, [mbYes,mbNo], 0 ) <> mrYes then
      SysUtils.Abort;
    SysCompleteWorkUnit( false );
  end
  else
  begin
    if WorkUnitNumber > 0 then
    begin
      SaveSettings := true;
      SaveLayout := true;
    end;
    Close;
  end;
  if WorkUnitNumber = 0 then
    if fsModal in FormState then
      ModalResult := mrCancel
    else 
      Close;
end;

procedure TfrmBase.btApplyClick(Sender: TObject);
begin
  SaveSettings := true;
  SaveLayout := true;
  WriteOutLayout;
  WriteOutSettings;
  if Assigned( BaseTransaction ) and ( BaseTransaction.Owner = Self ) then
    if BaseTransaction.Started then
      BaseTransaction.SavePoint;
end;

procedure TfrmBase.btHelpClick(Sender: TObject);
begin
  DoHelpClick;
end;

procedure TfrmBase.btBrowseClick(Sender: TObject);
begin
  DoBrowseClick;
end;

procedure TfrmBase.DoBrowseClick;
begin {Abstract} end;
procedure TfrmBase.DoReadSettings;
begin {Abstract} end;
procedure TfrmBase.DoWriteSettings;
begin {Abstract} end;
procedure TfrmBase.DoReadLayout;
begin {Abstract} end;
procedure TfrmBase.DoWriteLayout;
begin {Abstract} end;
procedure TfrmBase.DoHelpClick;
begin {Abstract} end;
procedure TfrmBase.Initialize;
begin {Abstract} end;
procedure TfrmBase.AfterCompleteWorkUnit( Commit: boolean );
begin {Abstract} end;
procedure TfrmBase.BeforeCompleteWorkUnit( Commit: boolean );
begin {Abstract} end;
procedure TfrmBase.DoRefreshButtons;
begin {Abstract} end;
procedure TfrmBase.DoStartWorkUnit;
begin {Abstract} end;

{------------------------------------------------------------------------------}

procedure TfrmBase.SysCompleteWorkUnit( Commit: boolean );
begin
  BeforeCompleteWorkUnit( Commit );
  if ( Assigned( BaseTransaction )) and
     ( BaseTransaction.Started or
       BaseTransaction.InTransaction or
       BaseTransaction.TransactionIsActive ) then
  begin
    if Commit then
    begin
      if BaseTransaction.CachedUpdatePendingCount > 0 then
        BaseTransaction.ApplyUpdates( [nil] )
      else
        BaseTransaction.Commit;
    end
    else
    begin
      if BaseTransaction.CachedUpdatePendingCount > 0 then
        BaseTransaction.CancelUpdates( [nil] )
      else
        BaseTransaction.Rollback;
    end;
  end;
  AfterCompleteWorkUnit( Commit );
  if WorkUnitNumber > 0 then
    SysStartWorkUnit;
end;

procedure TfrmBase.SysStartWorkUnit;
begin
  Inc( FWorkUnitNumber );
  DoStartWorkUnit;
  if Assigned( BaseTransaction ) and
     BaseTransaction.AutoCommit and
     not BaseTransaction.InTransaction then
    BaseTransaction.StartTransaction;
  RefreshButtons;
end;

procedure TfrmBase.RefreshButtons;
begin
  if csDestroying in ComponentState then
    Exit;
  if WorkUnitNumber > 0 then
  begin
    if Assigned( BaseTransaction ) and
       BaseTransaction.TransactionIsActive then
    begin
      btOK.Enabled := true;
      if btCancel.Cancel then
        btCancel.Caption := C_BF_CANCEL
      else
        btCancel.Caption := C_BF_CANCEL_ACCEL
    end
    else
    begin
      btOK.Enabled := false;
      if btCancel.Cancel then
        btCancel.Caption := C_BF_CLOSE
      else
        btCancel.Caption := C_BF_CLOSE_ACCEL;
    end;
    if btOK.Default then
      btOK.Caption := C_BF_FINISH
    else
      btOK.Caption := C_BF_FINISH_ACCEL;
  end;
  DoRefreshButtons;
end;

end.

