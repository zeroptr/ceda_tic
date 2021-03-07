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

unit oaSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, oaTypes, oaAssist;

type

{ TActorLibDialog }

  TActorLibDialog = class(TForm)
    OpenDialog: TOpenDialog;
    BtnOK: TButton;
    BtnCancel: TButton;
    Panel: TPanel;
    BtnLoad: TButton;
    BtnClear: TButton;
    Information: TPanel;
    VerValue: TMemo;
    VerItems: TListBox;
    Label3: TLabel;
    Label4: TLabel;
    KeyInformation: TPanel;
    ActorName: TLabel;
    ActorLibrary: TLabel;
    Animations: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure AnimationsKeyPress(Sender: TObject; var Key: Char);
    procedure AnimationsDblClick(Sender: TObject);
    procedure BtnLoadClick(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
    procedure VerItemsClick(Sender: TObject);
    procedure PreviewResized(Sender: TObject);
  private
    Preview: TAssistant;
    function GetLibraryName: String;
    procedure SetLibraryName(const Value: String);
  public
    function Execute: Boolean;
  published
    property LibraryName: String read GetLibraryName write SetLibraryName;
  end;

function SelectActor(const Caption: String; var Filename: String): Boolean;

implementation

{$R *.DFM}

const
  ExitTypeNames: array[TExitType] of String =
    ('None', 'Return Animation', 'Use Exit Branching');
  ActorActionNames: array[TActorAction] of String =
    ('None', 'Acknowledge', 'Alert', 'Announce', 'Blink', 'Confused',
     'Congratulate', 'Decline', 'DoMagic', 'DontRecognize', 'Explain',
     'GestureDown', 'GestureDownLeft', 'GestureDownRight', 'GestureLeft',
     'GestureRight', 'GestureUp', 'GestureUpLeft', 'GestureUpRight',
     'GetAttention', 'GetAttentionContinued', 'GlanceDown', 'GlanceDownLeft',
     'GlanceDownRight', 'GlanceLeft', 'GlanceRight', 'GlanceUp', 'GlanceUpLeft',
     'GlanceUpRight', 'Greet', 'Hear', 'Hearing', 'Hide', 'IdlingLevel1',
     'IdlingLevel2', 'IdlingLevel3', 'Listen', 'Listening', 'LookDown',
     'LookDownLeft', 'LookDownRight', 'LookLeft', 'LookRight', 'LookUp',
     'LookUpLeft', 'LookUpRight', 'MoveDown', 'MoveDownLeft', 'MoveDownRight',
     'MoveLeft', 'MoveRight', 'MoveUp', 'MoveUpLeft', 'MoveUpRight', 'Pleased',
     'Process', 'Processing', 'Read', 'ReadContinued', 'Reading', 'RestPose',
     'Sad', 'Search', 'Searching', 'Show', 'Speak', 'Speaking', 'StartListening',
     'StopListening', 'Suggest', 'Surprised', 'Think', 'Thinking', 'Uncertain',
     'Wave', 'Write', 'WriteContinued', 'Writing');
  VerInfoItems: array[1..10] of string = ('FileVersion', 'FileDescription',
    'LegalCopyright', 'CompanyName', 'InternalName', 'LegalTrademarks',
    'OriginalFilename', 'ProductName', 'ProductVersion', 'Comments');

{ TActorLibDialog }

function TActorLibDialog.Execute: Boolean;
begin
  Result := (ShowModal = mrOK);
end;

function TActorLibDialog.GetLibraryName: String;
begin
  Result := Preview.ActorLibrary;
end;

procedure TActorLibDialog.SetLibraryName(const Value: String);
const
  Welcome: array[0..1] of TActorAction = (aaGreet, aaWave);
var
  I: Word;
  Action: TActorAction;
  Language, ActionList: String;
  Item: TListItem;
begin
  if CompareText(Preview.ActorLibrary, Value) <> 0 then
  begin
    Screen.Cursor := crHourglass;
    try
      Preview.ActorLibrary := Value;
      Language := Preview.ActorVerInfo['Language'];
      if Language <> '' then
        ActorName.Caption := Preview.ActorName + ' - ' + Language
      else
        ActorName.Caption := Preview.ActorName;
      ActorLibrary.Caption := Preview.ActorLibrary;
      VerItems.Items.BeginUpdate;
      try
        VerItems.Clear;
        VerItems.ItemIndex := -1;
        for I := Low(VerInfoItems) to High(VerInfoItems) do
          if Preview.ActorVerInfo[VerInfoItems[I]] <> '' then
            VerItems.Items.Add(VerInfoItems[I]);
      finally
        VerItems.Items.EndUpdate;
      end;
      if VerItems.Items.Count > 0 then
        VerItems.ItemIndex := 0;
      VerItemsClick(Self);
      Animations.Items.BeginUpdate;
      try
        Animations.Items.Clear;
        for I := 1 to Preview.AnimationCount do
        begin
          with Preview.Animations[I] do
          begin
            Item := Animations.Items.Add;
            Item.Caption := String(Name);
            if ExitType = etAnimation then
              Item.SubItems.Add(String(ReturnName))
            else
              Item.SubItems.Add(ExitTypeNames[ExitType]);
            if Actions = [] then
              Item.SubItems.Add(ActorActionNames[aaNone])
            else
            begin
              ActionList := '';
              for Action := Low(TActorAction) to High(TActorAction) do
                if Action in Actions then
                begin
                  if ActionList <> '' then
                    ActionList := ActionList + ', ';
                  ActionList := ActionList + ActorActionNames[Action];
                end;
              Item.SubItems.Add(ActionList);
            end;
          end;
        end;
      finally
        Animations.Items.EndUpdate;
        Animations.Columns[2].Width := -1;
      end;
      Update;
      if not Preview.Visible then
        Preview.Show(True)
      else if Preview.Play(Welcome[Random(High(Welcome)+1)]) = 0 then
        Preview.Play(aaRestPose);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TActorLibDialog.FormCreate(Sender: TObject);
begin
  Preview := TAssistant.Create(Self);
  Preview.OnResize := PreviewResized;
  Preview.Draggable := False;
  Preview.DockSite := Panel;
end;

procedure TActorLibDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Preview.StopAll(True);
  CanClose := True;
end;

procedure TActorLibDialog.FormActivate(Sender: TObject);
begin
  Update;
  if Preview.ActorLibrary = '' then
    BtnLoadClick(Self);
end;

procedure TActorLibDialog.AnimationsDblClick(Sender: TObject);
begin
  if Animations.Selected <> nil then
  begin
    if Preview.Playing then Preview.StopAll(False);
    {$IFDEF COMPILER4_UP}
    Preview.Play(Animations.Selected.Index+1);
    {$ELSE}
    Preview.PlayIndex(Animations.Selected.Index+1);
    {$ENDIF}
  end;
end;

procedure TActorLibDialog.AnimationsKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = ' ') and (Animations.Selected <> nil) then
  begin
    if Preview.Playing then Preview.StopAll(False);
    {$IFDEF COMPILER4_UP}
    Preview.Play(Animations.Selected.Index+1);
    {$ELSE}
    Preview.PlayIndex(Animations.Selected.Index+1);
    {$ENDIF}
  end;
end;

procedure TActorLibDialog.BtnLoadClick(Sender: TObject);
begin
  OpenDialog.FileName := LibraryName;
  if OpenDialog.Execute then
    LibraryName := OpenDialog.FileName;
end;

procedure TActorLibDialog.BtnClearClick(Sender: TObject);
begin
  LibraryName := '';
end;

procedure TActorLibDialog.VerItemsClick(Sender: TObject);
begin
  if VerItems.ItemIndex >= 0 then
    VerValue.Lines.Text := Preview.ActorVerInfo[VerItems.Items[VerItems.ItemIndex]]
  else
    VerValue.Lines.Clear;
end;

procedure TActorLibDialog.PreviewResized(Sender: TObject);
begin
  Preview.SetPosition((Panel.ClientWidth - Preview.Width) div 2,
                      (Panel.ClientHeight - Preview.Height) div 2);
end;

function SelectActor(const Caption: String; var Filename: String): Boolean;
var
  Dialog: TActorLibDialog;
begin
  Result := False;
  Dialog := TActorLibDialog.Create(Application);
  try
    Dialog.Caption := Caption;
    try
      Dialog.LibraryName := Filename;
    except
      // Ignores exceptions
    end;
    if Dialog.Execute then
    begin
      Filename := Dialog.LibraryName;
      Result := True;
    end;
  finally
    Dialog.Free;
  end;
end;

end.
