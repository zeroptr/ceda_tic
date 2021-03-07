{------------------------------------------------------------------------------}
{                                                                              }
{  Office Assistant                                                            }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

unit oaTypes;

interface

uses
  Windows, Classes, Controls, SysUtils, Dialogs, Forms;

type

  TRequestID = Cardinal;

  TBalloonKind = (bkNone, bkMessage, bkTips, bkHint, bkGuide, bkSpeak, bkThink, bkQuery, bkCustom);

  TTopicStyle = (tsHeader, tsUnderline, tsBold, tsItalic,
                 tsHoverUnderline, tsHoverBold, tsHoverItalic);
  TTopicStyles = set of TTopicStyle;

  TBalloonPos = (bpCenter, bpTopLeft, bpTopRight, bpRightTop, bpRightBottom,
    bpBottomRight, bpBottomLeft, bpLeftBottom, bpLeftTop);

  TBgMode = (bmNone, bmTiled, bmCentered, bmStretched);

  TTipsDlgBtn = (tbClose, tbNext, tbBack);
  TTipsDlgButtons = set of TTipsDlgBtn;

  TGuideDlgBtn = (gbClose, gbOptions, gbTips, gbSearch, gbBackPage, gbNextPage);
  TGuideDlgCmdBtn = gbClose..gbSearch;
  TGuideDlgNavBtn = gbBackPage..gbNextPage;
  TGuideDlgButtons = set of TGuideDlgCmdBtn;

  THintDlgBtn = (hbClose, hbBackPage, hbNextPage);
  THintDlgCmdBtn = hbClose..hbClose;
  THintDlgNavBtn = hbBackPage..hbNextPage;

  TQueryDlgBtn = (qbOK, qbCancel);
  TQueryDlgButtons = set of TQueryDlgBtn;

  TExitType = (etNone, etAnimation, etExitBranch);

  TActorAction = (aaNone, aaAcknowledge, aaAlert, aaAnnounce, aaBlink,
     aaConfused, aaCongratulate, aaDecline, aaDoMagic, aaDontRecognize,
     aaExplain, aaGestureDown, aaGestureDownLeft, aaGestureDownRight,
     aaGestureLeft, aaGestureRight, aaGestureUp, aaGestureUpLeft,
     aaGestureUpRight, aaGetAttention, aaGetAttentionContinued, aaGlanceDown,
     aaGlanceDownLeft, aaGlanceDownRight, aaGlanceLeft, aaGlanceRight,
     aaGlanceUp, aaGlanceUpLeft, aaGlanceUpRight, aaGreet, aaHear, aaHearing,
     aaHide, aaIdlingLevel1, aaIdlingLevel2, aaIdlingLevel3, aaListen,
     aaListening, aaLookDown, aaLookDownLeft, aaLookDownRight, aaLookLeft,
     aaLookRight, aaLookUp, aaLookUpLeft, aaLookUpRight, aaMoveDown,
     aaMoveDownLeft, aaMoveDownRight, aaMoveLeft, aaMoveRight, aaMoveUp,
     aaMoveUpLeft, aaMoveUpRight, aaPleased, aaProcess, aaProcessing, aaRead,
     aaReadContinued, aaReading, aaRestPose, aaSad, aaSearch, aaSearching,
     aaShow, aaSpeak, aaSpeaking, aaStartListening, aaStopListening, aaSuggest,
     aaSurprised, aaThink, aaThinking, aaUncertain, aaWave, aaWrite,
     aaWriteContinued, aaWriting);

  TOrientedAction = (oaGesture, oaGlance, oaLook, oaMove);

  TIdleLevel = aaIdlingLevel1..aaIdlingLevel3;

  TActorActions = set of TActorAction;

  PAnimationInfo = ^TAnimationInfo;
  TAnimationInfo = packed record
    Name          : String[50];
    Resource      : Word;
    Actions       : TActorActions;
  case ExitType   : TExitType of
    etNone        : ();
    etAnimation   : (ReturnIndex: Word);
    etExitBranch  : ();
  end;

  PActorInfo = ^TActorInfo;
  TActorInfo = packed record
    FormatID: Word;
    ActorName: String[20];
    ScreenWidth: Word;
    ScreenHeight: Word;
    Palette: TMaxLogPalette;
    BlindColorEntry: Byte;
    AnimationCount: Word;
    Animations: array[1..1] of TAnimationInfo;
  end;

  TAnimation = packed record
    Name: String[50];
    Actions: TActorActions;
    case ExitType: TExitType of
      etNone: ();
      etAnimation: (ReturnName: String[50]);
      etExitBranch: ();
  end;

  TIdleEvent = procedure(Sender: TObject; Level: Integer; var Handled: Boolean) of object;
  TPlayEvent = procedure(Sender: TObject; RequestID: TRequestID) of object;

  TTopicClickEvent = procedure(Sender: TObject; TopicID: Integer) of Object;

  TCustomLabelEvent = procedure(Sender: TObject; TheLabel: TControl) of Object;

  TAboutMe = class(TObject);

implementation

end.
