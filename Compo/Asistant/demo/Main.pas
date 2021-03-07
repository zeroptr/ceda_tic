{------------------------------------------------------------------------------}
{                                                                              }
{  Office Assistant Sample Application                                         }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

{$I DELPHIAREA.INC}

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Menus, ComCtrls, oaAssist, oaTypes;

type
  TMainForm = class(TForm)
    StopButton: TButton;
    Animations: TListBox;
    StatusBar: TStatusBar;
    GroupBox1: TGroupBox;
    AutoIdle: TCheckBox;
    Mute: TCheckBox;
    SpeedEdit: TEdit;
    Label1: TLabel;
    ShowButton: TButton;
    HideButton: TButton;
    GroupBox2: TGroupBox;
    ActorName: TLabel;
    SelectButton: TButton;
    Fast: TCheckBox;
    PopupMenu: TPopupMenu;
    MoveTo: TMenuItem;
    Animate: TMenuItem;
    Assistant: TAssistant;
    RightToLeft: TCheckBox;
    Tips1: TMenuItem;
    ActorComments: TMemo;
    Hide1: TMenuItem;
    PlayAllButton: TButton;
    About1: TMenuItem;
    N1: TMenuItem;
    RemoveButton: TButton;
    OpenDialog: TOpenDialog;
    StopAllButton: TButton;
    Office2000Look: TCheckBox;
    HintBulb: TCheckBox;
    ShowCustomBalloon1: TMenuItem;
    Draggable: TCheckBox;
    PlayButton: TButton;
    MoveRandom: TButton;
    BlockingMove: TCheckBox;
    Speed: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure AssistantIdle(Sender: TObject; Level: Integer;
      var Handled: Boolean);
    procedure AssistantPlayStart(Sender: TObject;
      RequestID: Cardinal);
    procedure AssistantPlayStop(Sender: TObject;
      RequestID: Cardinal);
    procedure PlayButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure AnimationsClick(Sender: TObject);
    procedure AnimationsDblClick(Sender: TObject);
    procedure AssistantChange(Sender: TObject);
    procedure AssistantShow(Sender: TObject);
    procedure AssistantHide(Sender: TObject);
    procedure SelectButtonClick(Sender: TObject);
    procedure ShowButtonClick(Sender: TObject);
    procedure HideButtonClick(Sender: TObject);
    procedure AutoIdleClick(Sender: TObject);
    procedure MuteClick(Sender: TObject);
    procedure FastClick(Sender: TObject);
    procedure SpeedEditChange(Sender: TObject);
    procedure MoveToClick(Sender: TObject);
    procedure AssistantDragStart(Sender: TObject);
    procedure AssistantDragStop(Sender: TObject);
    procedure AssistantDragging(Sender: TObject);
    procedure AnimateClick(Sender: TObject);
    procedure RightToLeftClick(Sender: TObject);
    procedure Office2000LookClick(Sender: TObject);
    procedure HintBulbClick(Sender: TObject);
    procedure DraggableClick(Sender: TObject);
    procedure AssistantBalloonShow(Sender: TObject);
    procedure AssistantGuideRequestChange(Sender: TObject);
    procedure AssistantGuideTopicClick(Sender: TObject; TopicID: Integer);
    procedure AssistantGuideSearchClick(Sender: TObject);
    procedure AssistantBalloonHide(Sender: TObject);
    procedure UpdateMemoryStatus(Sender: TObject; var Done: Boolean);
    procedure Tips1Click(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AssistantTipsTipChange(Sender: TObject);
    procedure PlayAllButtonClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure RemoveButtonClick(Sender: TObject);
    function FormHelp(Command: Word; Data: Integer;
      var CallHelp: Boolean): Boolean;
    procedure StopAllButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AssistantClick(Sender: TObject);
    procedure AssistantHintBulbClick(Sender: TObject);
    procedure AssistantHintTopicClick(Sender: TObject; TopicID: Integer);
    procedure ShowCustomBalloon1Click(Sender: TObject);
    procedure MoveRandomClick(Sender: TObject);
    procedure BlockingMoveClick(Sender: TObject);
  protected
    procedure WMDropFiles(var Msg: TMessage); message WM_DROPFILES;
  private
    WritingID: TRequestID;     // Write and WriteContinued do not have auto return animation
    Writing: Boolean;          // so, we hanle them manually.
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

uses ShellAPI, CstmBln;

procedure TMainForm.UpdateMemoryStatus(Sender: TObject; var Done: Boolean);
var
  MemoryStatus: TMemoryStatus;
begin
  GlobalMemoryStatus(MemoryStatus);
  StatusBar.Panels[1].Text := Format('Free Memory: %.1f%%',
    [100. * MemoryStatus.dwAvailPhys / MemoryStatus.dwTotalPhys]);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  WritingID := 0;
  Writing := False;
  // Initializes controls with assistant properties
  AutoIdle.Checked := Assistant.AutoIdle;
  Fast.Checked := Assistant.FastShowHide;
  Mute.Checked := Assistant.Mute;
  RightToLeft.Checked := (Assistant.BiDiMode = bdRightToLeft);
  RightToLeft.Checked := False;
  RightToLeft.Enabled := {$IFDEF COMPILER4_UP} SysLocale.MiddleEast; {$ELSE} False; {$ENDIF}
  Office2000Look.Checked := Assistant.Balloon.Office2000Look;
  HintBulb.Checked := Assistant.HintBulb;
  Draggable.Checked := Assistant.Draggable;
  BlockingMove.Checked := Assistant.BlockingMove;
  Speed.Position := Assistant.Speed;
  if Assistant.DockSite = nil then
  begin
    Assistant.SetPosition(Screen.Width - 150,
                          Screen.Height - 150);
  end
  else
  begin
    Assistant.SetPosition(Assistant.DockSite.ClientWidth - 150,
                          Assistant.DockSite.ClientHeight - 150)
  end;
  // We manually fire the OnChange event of assistant to initialize state of buttons
  AssistantChange(Self);
  // While assistant is not visible, we anchor ballons to the main form
  Assistant.BalloonAnchor := Self;
  // On idle event of application, we display the precent of free physical memory
  Application.OnIdle := UpdateMemoryStatus;
  // If application ran with parameter, we suppose it is the actor library and load it
  if ParamCount > 0 then Assistant.ActorLibrary := ParamStr(1);
  // This enables form to accept draged files
  DragAcceptFiles(Handle, True);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  // This disables form to accept dragged files. This call is necessary.
  DragAcceptFiles(Handle, False);
end;

procedure TMainForm.WMDropFiles(var Msg: TMessage);
var
  DroppedFile: array[0..255] of Char;
begin
  // if any files is drapped on the form
  if DragQueryFile(THandle(Msg.WParam), $FFFFFFFF, nil, 0) > 0 then
  begin
    // we accept the first one
    DragQueryFile(THandle(Msg.WParam), 0, DroppedFile, SizeOf(DroppedFile));
    // if the file is not current loaded actor library
    if Assistant.ActorLibrary <> DroppedFile then
    begin
      // we load the actor library
      Assistant.ActorLibrary := DroppedFile;
      // if assistant is visible we randomly play Wave or Greet action
      if Assistant.Showing then
        {$IFDEF COMPILER4_UP}
        Assistant.Play([aaWave, aaGreet]);
        {$ELSE}
        Assistant.PlayRandom([aaWave, aaGreet]);
        {$ENDIF}
    end;
  end;
  DragFinish(THandle(Msg.WParam));
end;

procedure TMainForm.AssistantIdle(Sender: TObject; Level: Integer;
  var Handled: Boolean);
begin
  // if assistant is not in dragging mode, we display the level of idle on status bar
  if not Assistant.Dragging then
    StatusBar.Panels[0].Text := 'Idling Level ' + IntToStr(Level);
  // Write and WriteContinued have not auto return animation, then if one of this
  // was the last played animation, we play WriteReturn manually
  if Writing then
  begin
    Writing := False;
    Assistant.Play('WriteReturn');
    Handled := True;
  end
  // On idle level 2, if balloon is visible and it is a message dialog, we play
  // GetAttention animation instead of normal idling animation
  else if (Assistant.VisibleBalloon = bkMessage) and (Level = 2) and (Random(10) = 0) then
  begin
    Assistant.Play('GetAttention');
    if Random(5) = 0 then Assistant.Play('GetAttentionContinued');
    Assistant.Play('GetAttentionReturn');
    Handled := True;
  end;
end;

procedure TMainForm.AssistantPlayStart(Sender: TObject;
  RequestID: Cardinal);
var
  AnimName: String;
begin
  // When an animation starts playing, we display its name on the status bar
  AnimName := Assistant.Animations[LoWord(RequestID)].Name;
  StatusBar.Panels[0].Text := 'Playing ' + AnimName;
  // and enable stop buttons
  StopButton.Enabled := True;
  StopAllButton.Enabled := True;
end;

procedure TMainForm.AssistantPlayStop(Sender: TObject;
  RequestID: Cardinal);
begin
  // When an animation stops, we clear its name from the status bar
  StatusBar.Panels[0].Text := EmptyStr;
  // and disable stop buttons
  StopButton.Enabled := False;
  StopAllButton.Enabled := Assistant.Playing and not Assistant.PlayIdling;
end;

procedure TMainForm.PlayButtonClick(Sender: TObject);
begin
  {$IFDEF COMPILER4_UP}
  Assistant.Play(Animations.ItemIndex+1);
  {$ELSE}
  Assistant.PlayIndex(Animations.ItemIndex+1);
  {$ENDIF}
end;

procedure TMainForm.StopButtonClick(Sender: TObject);
begin
  // This stops current playing animation
  Assistant.Stop(Assistant.PlayingID);
end;

procedure TMainForm.StopAllButtonClick(Sender: TObject);
begin
  // This stops current animation and removes all queued animation from the queue
  Assistant.StopAll(False);
end;

procedure TMainForm.AnimationsClick(Sender: TObject);
begin
  PlayButton.Enabled := Assistant.Showing and (Animations.ItemIndex >= 0);
end;

procedure TMainForm.AnimationsDblClick(Sender: TObject);
begin
  if PlayButton.Enabled then
    PlayButtonClick(nil);
end;

procedure TMainForm.AssistantChange(Sender: TObject);
var
  I: Integer;
  Language: String;
begin
  // Initializes controls with actor information
  Language := Assistant.ActorVerInfo['Language'];
  if Language <> EmptyStr then
    ActorName.Caption := Assistant.ActorName + ' - ' + Language
  else
    ActorName.Caption := Assistant.ActorName;
  ActorComments.Text := Assistant.ActorVerInfo['Comments'];
  Animations.Items.BeginUpdate;
  try
    Animations.Clear;
    for I := 1 to Assistant.AnimationCount do
      Animations.Items.Add(Assistant.Animations[I].Name);
  finally
    Animations.Items.EndUpdate;
  end;
  RemoveButton.Enabled := Assistant.ActorName <> EmptyStr;
  HideButton.Enabled := Assistant.Showing;
  ShowButton.Enabled := not Assistant.Showing and not Assistant.Empty;
  PlayButton.Enabled := Assistant.Showing and (Animations.ItemIndex >= 0);
  PlayAllButton.Enabled := Assistant.Showing;
end;

procedure TMainForm.AssistantShow(Sender: TObject);
begin
  // Sets buttons' state
  HideButton.Enabled := True;
  ShowButton.Enabled := False;
  PlayAllButton.Enabled := True;
  PlayButton.Enabled := (Animations.ItemIndex >= 0);
  // When assiatant is visible, we anchor balloons to the assistant
  Assistant.BalloonAnchor := nil;
end;

procedure TMainForm.AssistantHide(Sender: TObject);
begin
  // When assiatant is hidden, we anchor the balloons to the main form
  Assistant.BalloonAnchor := Self;
  // Sets buttons' state
  ShowButton.Enabled := True;
  HideButton.Enabled := False;
  PlayAllButton.Enabled := False;
  PlayButton.Enabled := False;
  Animations.ItemIndex := -1;
end;

procedure TMainForm.SelectButtonClick(Sender: TObject);
var
  OldSize: TSize;
  Pos: TPoint;
begin
  Assistant.OnGuideOptionsClick := nil; // To prevent re-entrance
  try
    OpenDialog.FileName := Assistant.ActorLibrary;
    if OpenDialog.Execute and (Assistant.ActorLibrary <> OpenDialog.FileName) then
    begin
      OldSize.CX := Assistant.Width;
      OldSize.CY := Assistant.Height;
      Pos := Assistant.BoundsRect.TopLeft;
      Assistant.ActorLibrary := OpenDialog.FileName;
      Inc(Pos.X, (OldSize.CX - Assistant.Width) div 2);
      Inc(Pos.Y, (OldSize.CY - Assistant.Height) div 2);
      Assistant.SetPosition(Pos.X, Pos.Y);
      if Assistant.Showing then
        {$IFDEF COMPILER4_UP}
        Assistant.Play([aaWave, aaGreet]);
        {$ELSE}
        Assistant.PlayRandom([aaWave, aaGreet]);
        {$ENDIF}
    end;
  finally
    Assistant.OnGuideOptionsClick := SelectButtonClick;
  end;
end;

procedure TMainForm.ShowButtonClick(Sender: TObject);
begin
  Assistant.Visible := True;
end;

procedure TMainForm.HideButtonClick(Sender: TObject);
begin
  Assistant.Visible := False;
end;

procedure TMainForm.AutoIdleClick(Sender: TObject);
begin
  Assistant.AutoIdle := AutoIdle.Checked;
end;

procedure TMainForm.MuteClick(Sender: TObject);
begin
  Assistant.Mute := Mute.Checked;
end;

procedure TMainForm.FastClick(Sender: TObject);
begin
  Assistant.FastShowHide := Fast.Checked;
end;

procedure TMainForm.RightToLeftClick(Sender: TObject);
begin
  if RightToLeft.Checked then
    Assistant.BiDiMode := bdRightToLeft
  else
    Assistant.BiDiMode := bdLeftToRight;
end;

procedure TMainForm.Office2000LookClick(Sender: TObject);
begin
  Assistant.Balloon.Office2000Look := Office2000Look.Checked;
end;

procedure TMainForm.HintBulbClick(Sender: TObject);
begin
  Assistant.HintBulb := HintBulb.Checked;
end;

procedure TMainForm.DraggableClick(Sender: TObject);
begin
  Assistant.Draggable := Draggable.Checked;
end;

procedure TMainForm.BlockingMoveClick(Sender: TObject);
begin
  Assistant.BlockingMove := BlockingMove.Checked;
end;

procedure TMainForm.SpeedEditChange(Sender: TObject);
begin
  Assistant.Speed := Speed.Position;
  if Integer(Assistant.Speed) <> Speed.Position then
    Speed.Position := Assistant.Speed;
end;

procedure TMainForm.MoveToClick(Sender: TObject);
var
  X, Y: Integer;
begin
  if Assistant.DockSite = nil then
  begin
    X := (Screen.Width - Assistant.Width) div 2;
    Y := (Screen.Height - Assistant.Height) div 2;
  end
  else
  begin
    X := (Assistant.DockSite.ClientWidth - Assistant.Width) div 2;
    Y := (Assistant.DockSite.ClientHeight - Assistant.Height) div 2;
  end;
  Assistant.MoveTo(X, Y);
end;

procedure TMainForm.AssistantDragStart(Sender: TObject);
begin
  StatusBar.Panels[0].Text := 'Dragging';
end;

procedure TMainForm.AssistantDragStop(Sender: TObject);
begin
  StatusBar.Panels[0].Text := EmptyStr;
end;

procedure TMainForm.AssistantDragging(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Format('Dragging (%d,%d)',
    [Assistant.StageLeft, Assistant.StageTop]);
end;

procedure TMainForm.AnimateClick(Sender: TObject);
var
  Action: TActorAction;
begin
  // if an actor is loaded and it has animation
  if Assistant.AnimationCount > 0 then
  begin
    // An actor maybe do not have some predefined actions, so we look for
    // an existing action
    repeat
      Action := TActorAction(Random(Ord(High(TActorAction))+1));
    until Assistant.Play(Action) <> 0;
    if Action = aaHide then Assistant.Play(aaRestPose);
  end;
end;

procedure TMainForm.AssistantBalloonShow(Sender: TObject);
begin
  case Assistant.VisibleBalloon of
    bkMessage:
      case Assistant.BalloonPos of
        bpTopLeft, bpTopRight:
          if not Assistant.IsPlaying([aaGestureUp]) then
            Assistant.Play(aaGestureUp);
        bpBottomLeft, bpBottomRight:
          if not Assistant.IsPlaying([aaGestureDown]) then
            Assistant.Play(aaGestureDown);
        bpLeftTop, bpLeftBottom:
          if not Assistant.IsPlaying([aaGestureRight]) then
            Assistant.Play(aaGestureRight);
        bpRightTop, bpRightBottom:
          if not Assistant.IsPlaying([aaGestureLeft]) then
            Assistant.Play(aaGestureLeft);
      end;
    bkTips, bkHint:
      if not Assistant.IsPlaying([aaSuggest]) then
        Assistant.Play(aaSuggest);
  end;
end;

procedure TMainForm.AssistantGuideRequestChange(Sender: TObject);
begin
  // if the last played animation is Write or WriteContinued
  if Writing then
  begin
    // if the animation is not still playing
    if not Assistant.IsValid(WritingID) then
      // we play WriteContinued animation
      WritingID := Assistant.Play('WriteContinued');
  end
  else
  // otherwise we play Write animation
  begin
    Writing := True;
    WritingID := Assistant.Play('Write');
  end;
end;

procedure TMainForm.AssistantGuideTopicClick(Sender: TObject; TopicID: Integer);
begin
  if Assistant.GuideDlg.RequestResult then
    case TopicID of
      1:
      begin
        Assistant.Play(aaSpeak);
        Assistant.Speak(Format('I have %d animations.', [Assistant.AnimationCount]), 10000);
      end;
      2:
      begin
        Assistant.Play(aaProcess);
        ShellExecute(Handle, 'open', 'http://www.delphiarea.com/products/assistant/',
           nil, nil, SW_SHOWNORMAL);
        Assistant.Play(aaRestPose);
      end;
      3:
      begin
        Assistant.Play(aaAnnounce);
        ShellExecute(Handle, 'open', 'mailto:kambiz@delphiarea.com?subject=Office%20Assistant%20Package',
           nil, nil, SW_SHOWNORMAL);
        Assistant.Play(aaRestPose);
      end;
    end
  else
    Assistant.Think('What is Office Assistant Package?', 7000);
end;

procedure TMainForm.AssistantGuideSearchClick(Sender: TObject);
var
  I: Integer;
begin
  // if the last animation was Write or WriteContinued animation
  // we play WriteReturn animation
  if Writing then
  begin
    Writing := False;
    Assistant.Play('WriteReturn');
  end;
  with Assistant.GuideDlg do
  begin
    // if the entered help request found, we assign help topics
    if Pos('assist', LowerCase(Request)) <> 0 then
    begin
      Description := 'You asked something about me, here is options that I can offer you.';
      Topics.Clear;
      // We add one line space and one line in bold, this lins marked as header
      // so user can not select them.
      Topics.AddStyle('', [tsHeader]);
      Topics.AddStyle('Select one of the following items:', [tsHeader, tsBold]);
      // Because we are going to add some items as random, to know which item
      // is clicked, we assign a unique ID for our three available choices.
      // When user clicks on an item, the ID will be passed to the event handler.
      for I := 0 to Random(8) do
        case Random(100) of
          00..33:
            Topics.AddID('Tell me the number of ' + Assistant.ActorName + '''s animations', 1);
          34..66:
            Topics.AddID('Go to the Assistant''s home page', 2);
          67..99:
            Topics.AddID('Send e-mail to the author', 3);
        end;
      if Random(5) = 0 then
        Assistant.Play(aaCongratulate)
      else
        Assistant.Play(aaPleased);
      RequestResult := True;
    end
    else // otherwise we clear help topics
    begin
      Description := 'I don''t know what you mean.  Please rephrase your question.';
      Topics.Clear;
      Topics.AddStyle('Show me an example', [tsHoverUnderline]);
      {$IFDEF COMPILER4_UP}
      Assistant.Play([aaConfused, aaDecLine, aaSad]);
      {$ELSE}
      Assistant.PlayRandom([aaConfused, aaDecLine, aaSad]);
      {$ENDIF}
      RequestResult := False;
    end;
  end;
end;

procedure TMainForm.AssistantBalloonHide(Sender: TObject);
begin
  // if the last animation was Write or WriteContinued animation
  // we play WriteReturn animation
  if Writing then
  begin
    Writing := False;
    Assistant.Play('WriteReturn');
  end
  else
    Assistant.Play(aaRestPose);
end;

procedure TMainForm.Tips1Click(Sender: TObject);
begin
  if Assistant.VisibleBalloon <> bkTips then
    Assistant.ShowTips;
end;

procedure TMainForm.PopupMenuPopup(Sender: TObject);
begin
  if Assistant.VisibleBalloon <> bkNone then
    Assistant.CloseBalloon;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
const
  Msg = 'Are you sure to exit from Office Assistant demo?';
begin
  if not Assistant.MovingToSync then
  begin
    Assistant.MsgDlg.Title := 'Assistant';
    CanClose := Assistant.MessageDlg(Msg, mtWarning, [mbYes, mbNo], 0) = mrYes;
    if CanClose and Assistant.Showing and (Assistant.DockSite = nil) then
    begin
      Hide;
      Assistant.Visible := False;
    end;
  end
  else
    CanClose := False;
end;

procedure TMainForm.AssistantTipsTipChange(Sender: TObject);
begin
  case Assistant.BalloonPos of
    bpTopLeft, bpTopRight: Assistant.Play(aaGlanceUp);
    bpBottomLeft, bpBottomRight: Assistant.Play(aaGlanceDown);
    bpLeftTop, bpLeftBottom: Assistant.Play(aaGlanceRight);
    bpRightTop, bpRightBottom: Assistant.Play(aaGlanceLeft);
  end;
end;

procedure TMainForm.AssistantClick(Sender: TObject);
begin
  if Assistant.VisibleBalloon = bkNone then
    Assistant.ShowGuide
  else if Assistant.VisibleBalloon in [bkGuide, bkSpeak, bkThink] then
    Assistant.CloseBalloon;
end;

procedure TMainForm.AssistantHintBulbClick(Sender: TObject);
const
  HintStr = 'You can move the assistant on the screen by dragging it or ' +
            'within the application by calling MoveTo(X,Y) method.';
begin
  Assistant.HintDlg.Topics.Clear;
  if Random(2) = 0 then
  begin
    Assistant.HintDlg.Topics.Add('Show Me');
    Assistant.HintDlg.Title := 'Hint by Sample';
    Assistant.HintDlg.Description := HintStr;
  end
  else
  begin
    Assistant.HintDlg.Title := 'Simple Hint';
    Assistant.HintDlg.Description :=
      Assistant.TipsDlg.Tips[Random(Assistant.TipsDlg.Tips.Count)];
  end;
  Assistant.ShowHint;
end;

procedure TMainForm.AssistantHintTopicClick(Sender: TObject; TopicID: Integer);
begin
  Assistant.MoveTo(Random(Screen.Width - Assistant.Width),
                   Random(Screen.Height - Assistant.Height));
end;

procedure TMainForm.PlayAllButtonClick(Sender: TObject);
var
  Index: Integer;
begin
  for Index := 1 to Assistant.AnimationCount do
    {$IFDEF COMPILER4_UP}
    Assistant.Play(Index);
    {$ELSE}
    Assistant.PlayIndex(Index);
    {$ENDIF}
end;

procedure TMainForm.About1Click(Sender: TObject);
const
  AboutStr =
    'Office Assistant Package'#10#13 +
    'by Kambiz R. Khojasteh'#10#13#10#13 +
    'kambiz@delphiarea.com'#10#13 +
    'http://www.delphiarea.com'#10#13 +
    '___________________________________'#10#13#10#13 +
    'Office 97 Style Button Component'#10#13 +
    'by Jonathan Hosking'#10#13#10#13 +
    'jonathan@the-hoskings.freeserve.co.uk'#10#13 +
    'http://www.the-hoskings.freeserve.co.uk';
begin
  Assistant.StopAll(False);
  Assistant.Play(aaSurprised);
  Assistant.Speak(AboutStr, 20000);
end;

procedure TMainForm.RemoveButtonClick(Sender: TObject);
begin
  Assistant.ActorLibrary := EmptyStr;
end;

function TMainForm.FormHelp(Command: Word; Data: Integer;
  var CallHelp: Boolean): Boolean;
const
  NoHelp = 'No help available for this item.';
  Helps: array[1..21] of String = (
    'Click on this button to load an actor library.',
    'Click on this button to unload the actor library.',
    'Here is the information about the currently actor.',
    'Click on this button to show the actor.',
    'Click on this button to hide the actor.',
    'When this option is checked the assistant plays idling animations automatically.',
    'When this option is checked the assistant does not make any sound.',
    'When this option is checked the assistant shows the balloons in Middle East languages style.',
    'When this option is checked the assistant''s balloons look like Office 2000 balloons.',
    'When this option is checked you can move the assistant on the screen by dragging it.',
    'When this option is checked a hint bulb apears beside the assistant.',
    'When this option is checked the assistant does not play SHOW and HIDE animations.',
    'This value determines the speed of the animations related to their original speed.',
    'Click on this button to play the currently selected animation.',
    'Click on this button to stop the current playing animation.',
    'Click on this button to play sequentially all animations of the actor.',
    'Click on this button to stop the current playing animation and all other pending ones.',
    'This list shows the available animations of the currently loaded actor.',
    'Well, this is the status bar! On the right side you see the free percentage of physical memory.',
    'When this option is checked, during actor movement on the screen, MoveTo method does not use a separate thread.',
    'Click here to move the actor randomly on the screen.'
  );
begin
  if Command = 8 then
  begin
    if Data in [Low(Helps)..High(Helps)] then
      Assistant.Speak(Helps[Data], 10000)
    else
      Assistant.Speak(NoHelp, 10000);
    if not Assistant.Showing then
      Assistant.MoveBalloonToCursor;
  end;
  CallHelp := False;
  Result := False;
end;

procedure TMainForm.ShowCustomBalloon1Click(Sender: TObject);
begin
  Assistant.CustomDialog := CustomBalloon;
  Assistant.ShowCustomModal;
end;

procedure TMainForm.MoveRandomClick(Sender: TObject);
var
  X, Y: Integer;
begin
  if Assistant.DockSite = nil then
  begin
    {$IFDEF COMPILER4_UP}
    X := Random(Screen.DesktopWidth - Assistant.Width);
    Y := Random(Screen.DesktopHeight - Assistant.Height);
    {$ELSE}
    X := Random(Screen.Width - Assistant.Width);
    Y := Random(Screen.Height - Assistant.Height);
    {$ENDIF}
  end
  else
  begin
    X := Random(Assistant.DockSite.ClientWidth - Assistant.Width);
    Y := Random(Assistant.DockSite.ClientHeight - Assistant.Height);
  end;
  Assistant.MoveTo(X, Y);
end;

end.
