{*******************************************************}
{                                                       }
{       iTypes                                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iTypes;{$endif}
{$ifdef iCLX}unit QiTypes;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL}Printers; {$ENDIF}
  {$IFDEF iCLX}QPrinters;{$ENDIF}

const
  MaxPixelCount = 32768;
  
{$IFDEF LINUX}
const
  VK_PRIOR = 33;
  VK_NEXT  = 34;
  VK_END   = 35;
  VK_HOME  = 36;
  VK_LEFT  = 37;
  VK_UP    = 38;
  VK_RIGHT = 39;
  VK_DOWN  = 40;
{$endif}

const
  iVK_LBUTTON    = 1;
  iVK_RBUTTON    = 2;
  iVK_CANCEL     = 3;
  iVK_MBUTTON    = 4;

  iVK_BACK       = 8;
  iVK_TAB        = 9;

  iVK_CLEAR      = 12;
  iVK_RETURN     = 13;

  iVK_SHIFT      = 16;
  iVK_CONTROL    = 17;
  iVK_MENU       = 18;
  iVK_PAUSE      = 19;
  iVK_CAPITAL    = 20;
  iVK_KANA       = 21;
  iVK_HANGUL     = 21;

  iVK_JUNJA      = 23;
  iVK_FINAL      = 24;
  iVK_HANJA      = 25;
  iVK_KANJI      = 25;

  iVK_ESCAPE     = 27;
  iVK_CONVERT    = 28;
  iVK_NONCONVERT = 29;
  iVK_ACCEPT     = 30;
  iVK_MODECHANGE = 31;
  iVK_SPACE      = 32;
  iVK_PRIOR      = 33;
  iVK_NEXT       = 34;
  iVK_END        = 35;
  iVK_HOME       = 36;
  iVK_LEFT       = 37;
  iVK_UP         = 38;
  iVK_RIGHT      = 39;
  iVK_DOWN       = 40;
  iVK_SELECT     = 41;
  iVK_PRINT      = 42;
  iVK_EXECUTE    = 43;
  iVK_SNAPSHOT   = 44;
  iVK_INSERT     = 45;
  iVK_DELETE     = 46;
  iVK_HELP       = 47;
  iVK_0          = 48; // 0 and )
  iVK_1          = 49; // 1 and !
  iVK_2          = 50; // 2 and @
  iVK_3          = 51; // 3 and #
  iVK_4          = 52; // 4 and $
  iVK_5          = 53; // 5 and %
  iVK_6          = 54; // 6 and ^
  iVK_7          = 55; // 7 and &
  iVK_8          = 56; // 8 and *
  iVK_9          = 57; // 9 and (

  iVK_A          = 65;
  iVK_B          = 66;
  iVK_C          = 67;
  iVK_D          = 68;
  iVK_E          = 69;
  iVK_F          = 70;
  iVK_G          = 71;
  iVK_H          = 72;
  iVK_I          = 73;
  iVK_J          = 74;
  iVK_K          = 75;
  iVK_L          = 76;
  iVK_M          = 77;
  iVK_N          = 78;
  iVK_O          = 79;
  iVK_P          = 80;
  iVK_Q          = 81;
  iVK_R          = 82;
  iVK_S          = 83;
  iVK_T          = 84;
  iVK_U          = 85;
  iVK_V          = 86;
  iVK_W          = 87;
  iVK_X          = 88;
  iVK_Y          = 89;
  iVK_Z          = 90;
  iVK_LWIN       = 91;
  iVK_RWIN       = 92;
  iVK_APPS       = 93;
  iVK_NUMPAD0    = 96;
  iVK_NUMPAD1    = 97;
  iVK_NUMPAD2    = 98;
  iVK_NUMPAD3    = 99;
  iVK_NUMPAD4    = 100;
  iVK_NUMPAD5    = 101;
  iVK_NUMPAD6    = 102;
  iVK_NUMPAD7    = 103;
  iVK_NUMPAD8    = 104;
  iVK_NUMPAD9    = 105;
  iVK_MULTIPLY   = 106;
  iVK_ADD        = 107;
  iVK_SEPARATOR  = 108;
  iVK_SUBTRACT   = 109;
  iVK_DECIMAL    = 110;
  iVK_DIVIDE     = 111;
  iVK_F1         = 112;
  iVK_F2         = 113;
  iVK_F3         = 114;
  iVK_F4         = 115;
  iVK_F5         = 116;
  iVK_F6         = 117;
  iVK_F7         = 118;
  iVK_F8         = 119;
  iVK_F9         = 120;
  iVK_F10        = 121;
  iVK_F11        = 122;
  iVK_F12        = 123;
  iVK_F13        = 124;
  iVK_F14        = 125;
  iVK_F15        = 126;
  iVK_F16        = 127;
  iVK_F17        = 128;
  iVK_F18        = 129;
  iVK_F19        = 130;
  iVK_F20        = 131;
  iVK_F21        = 132;
  iVK_F22        = 133;
  iVK_F23        = 134;
  iVK_F24        = 135;

  iVK_NUMLOCK    = 144;
  iVK_SCROLL     = 145;

  iVK_POUND      = 65;

  iVK_LSHIFT     = 160;
  iVK_RSHIFT     = 161;
  iVK_LCONTROL   = 162;
  iVK_RCONTROL   = 163;
  iVK_LMENU      = 164;
  iVK_RMENU      = 165;

  iVK_OEM_1      = 186; // ; and :
  iVK_OEM_PLUS   = 187;
  iVK_OEM_COMMA  = 188;
  iVK_OEM_MINUS  = 189;
  iVK_OEM_PERIOD = 190;
  iVK_OEM_2      = 191; // / and ? characters
  iVK_OEM_3      = 192; // ` and ~ Character

  iVK_OEM_4      = 219; // [ and { Character
  iVK_OEM_5      = 220; // \ and | Character
  iVK_OEM_6      = 221; // ] and } Character
  iVK_OEM_7      = 222; // ' and " Character

  iVK_PROCESSKEY = 229;

  iVK_ATTN       = 246;
  iVK_CRSEL      = 247;
  iVK_EXSEL      = 248;
  iVK_EREOF      = 249;
  iVK_PLAY       = 250;
  iVK_ZOOM       = 251;
  iVK_NONAME     = 252;
  iVK_PA1        = 253;
  iVK_OEM_CLEAR  = 254;

  iVK_CTRL_A     = 1;
  iVK_CTRL_V     = 22;
  iVK_CTRL_X     = 24;
  iVK_CTRL_Z     = 26;

  iDMPAPER_LETTER                  = 1;  {Letter 8.5 x 11 in}
  iDMPAPER_LETTERSMALL             = 2;  {Letter Small 8.5 x 11 in}
  iDMPAPER_TABLOID                 = 3;  {Tabloid 11 x 17 in}
  iDMPAPER_LEDGER                  = 4;  {Ledger 17 x 11 in}
  iDMPAPER_LEGAL                   = 5;  {Legal 8.5 x 14 in}
  iDMPAPER_STATEMENT               = 6;  {Statement 5.5 x 8.5 in}
  iDMPAPER_EXECUTIVE               = 7;  {Executive 7.25 x 10.5 in}
  iDMPAPER_A3                      = 8;  {A3 297 x 420 mm}
  iDMPAPER_A4                      = 9;  {A4 210 x 297 mm}
  iDMPAPER_A4SMALL                 = 10; {A4 Small 210 x 297 mm}
  iDMPAPER_A5                      = 11; {A5 148 x 210 mm}
  iDMPAPER_B4                      = 12; {B4 (JIS) 250 x 354}
  iDMPAPER_B5                      = 13; {B5 (JIS) 182 x 257 mm}
  iDMPAPER_FOLIO                   = 14; {Folio 8.5 x 13 in}
  iDMPAPER_QUARTO                  = 15; {Quarto 215 x 275 mm}
  iDMPAPER_10X14                   = 16; {10 x 14 in}
  iDMPAPER_11X17                   = 17; {11 x 17 in}
  iDMPAPER_NOTE                    = 18; {Note 8.5 x 11 in}
  iDMPAPER_ENV_9                   = 19; {Envelope #9 3.875 x 8.875 in}
  iDMPAPER_ENV_10                  = 20; {Envelope #10 4.125 x 9.5}
  iDMPAPER_ENV_11                  = 21; {Envelope #11 4.5 x 10.375}
  iDMPAPER_ENV_12                  = 22; {Envelope #12 4.75 x 11 in}
  iDMPAPER_ENV_14                  = 23; {Envelope #14 5 x 11.5 in}
  iDMPAPER_CSHEET                  = 24; {C size sheet 17 x 22 in}
  iDMPAPER_DSHEET                  = 25; {D size sheet 22 x 34 in}
  iDMPAPER_ESHEET                  = 26; {E size sheet 34 x 44 in}
  iDMPAPER_ENV_DL                  = 27; {Envelope DL 110 x 220 mm}
  iDMPAPER_ENV_C5                  = 28; {Envelope C5 162 x 229 mm}
  iDMPAPER_ENV_C3                  = 29; {Envelope C3 324 x 458 mm}
  iDMPAPER_ENV_C4                  = 30; {Envelope C4 229 x 324 mm}
  iDMPAPER_ENV_C6                  = 31; {Envelope C6 114 x 162 mm}
  iDMPAPER_ENV_C65                 = 32; {Envelope C65 114 x 229 mm}
  iDMPAPER_ENV_B4                  = 33; {Envelope B4 250 x 353 mm}
  iDMPAPER_ENV_B5                  = 34; {Envelope B5 176 x 250 mm}
  iDMPAPER_ENV_B6                  = 35; {Envelope B6 176 x 125 mm}
  iDMPAPER_ENV_ITALY               = 36; {Envelope 110 x 230 mm}
  iDMPAPER_ENV_MONARCH             = 37; {Envelope Monarch 3.875 x 7.5 in}
  iDMPAPER_ENV_PERSONAL            = 38; {6 34 Envelope 3.625 x 6.5 in}
  iDMPAPER_FANFOLD_US              = 39; {US Std Fanfold 14.875 x 11 in}
  iDMPAPER_FANFOLD_STD_GERMAN      = 40; {German Std Fanfold 8.5 x 12 in}
  iDMPAPER_FANFOLD_LGL_GERMAN      = 41; {German Legal Fanfold 8.5 x 13 in}
  iDMPAPER_ISO_B4                  = 42; {B4 (ISO) 250 x 353 mm}
  iDMPAPER_JAPANESE_POSTCARD       = 43; {Japanese Postcard 100 x 148 mm}
  iDMPAPER_9X11                    = 44; {9 x 11 in}
  iDMPAPER_10X11                   = 45; {10 x 11 in}
  iDMPAPER_15X11                   = 46; {15 x 11 in}
  iDMPAPER_ENV_INVITE              = 47; {Envelope Invite 220 x 220 mm}
  iDMPAPER_RESERVED_48             = 48; {RESERVED--DO NOT USE}
  iDMPAPER_RESERVED_49             = 49; {RESERVED--DO NOT USE}
  iDMPAPER_LETTER_EXTRA            = 50; {Letter Extra 9.5 x 12 in}
  iDMPAPER_LEGAL_EXTRA             = 51; {Legal Extra 9.5 x 15 in}
  iDMPAPER_TABLOID_EXTRA           = 52; {Tabloid Extra 11.69 x 18 in}
  iDMPAPER_A4_EXTRA                = 53; {A4 Extra 9.27 x 12.69 in}
  iDMPAPER_LETTER_TRANSVERSE       = 54; {Letter Transverse 8.5 x 11 in}
  iDMPAPER_A4_TRANSVERSE           = 55; {A4 Transverse 210 x 297 mm}
  iDMPAPER_LETTER_EXTRA_TRANSVERSE = 56; {Letter Extra Transverse 9.5 x 12 in}
  iDMPAPER_A_PLUS                  = 57; {SuperASuperAA4 227 x 356 mm}
  iDMPAPER_B_PLUS                  = 58; {SuperBSuperBA3 305 x 487 mm}
  iDMPAPER_LETTER_PLUS             = 59; {Letter Plus 8.5 x 12.69 in}
  iDMPAPER_A4_PLUS                 = 60; {A4 Plus 210 x 330 mm}
  iDMPAPER_A5_TRANSVERSE           = 61; {A5 Transverse 148 x 210 mm}
  iDMPAPER_B5_TRANSVERSE           = 62; {B5 (JIS) Transverse 182 x 257 mm}
  iDMPAPER_A3_EXTRA                = 63; {A3 Extra 322 x 445 mm}
  iDMPAPER_A5_EXTRA                = 64; {A5 Extra 174 x 235 mm}
  iDMPAPER_B5_EXTRA                = 65; {B5 (ISO) Extra 201 x 276 mm}
  iDMPAPER_A2                      = 66; {A2 420 x 594 mm}
  iDMPAPER_A3_TRANSVERSE           = 67; {A3 Transverse 297 x 420 mm}
  iDMPAPER_A3_EXTRA_TRANSVERSE     = 68; {A3 Extra Transverse 322 x 445 mm}
type
  TOnBeforeChangeInteger  = procedure(Sender: TObject; OldValue: Integer; var NewValue: Integer;    var CanChange: Boolean) of object;
  TOnBeforeChangeDouble   = procedure(Sender: TObject; OldValue: Double;  var NewValue: Double;     var CanChange: Boolean) of object;
  TOnBeforeChangeString   = procedure(Sender: TObject; OldValue: String; var NewValue: String;      var CanChange: Boolean) of object;
  TOnCustomizeTickLabel   = procedure(Sender: TObject; Index: Integer; var DisplayText: String)                             of object;
  TOnPositionLimit        = procedure(Sender: TObject; LimitIndex: Integer)                                                 of object;
  TRequestEditEvent       = procedure(Sender: TObject; PropName: String; var CanEdit : Boolean)                             of object;
  TChangePropertyEvent    = procedure(Sender: TObject; PropName: String)                                                    of object;
  TGetDesigningEvent      = procedure(Sender: TObject; var Designing: Boolean)                                              of object;
  TIndexObjectEvent       = procedure(Index: Integer)                                                                       of object;
  TBeforeOPCNewDataEvent  = procedure(Index: Integer; var Data: OleVariant)                                                 of object;
  TOPCObjectUpdate        = procedure(Handle: Integer)                                                                      of object;

  {$ifndef COMPILER_6_UP}TVarType = Word;{$endif}

  {$ifndef COMPILER_6_UP}
  IInterface = interface
    ['{00000000-0000-0000-C000-000000000046}']
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  end;
  {$endif}


  IOPCSignalUpdate = interface(IInterface)
    ['{7F440F9E-2014-4D28-8C84-83B938DBACC0}']
    procedure NewData(Handle: Integer); cdecl;
  end;

  IOPCGroupUpdate = interface(IInterface)
    ['{A2E9253A-E335-4D6E-A298-CFA504F5B837}']
    procedure BeforeUpdate(Handle: Integer); stdcall;
    procedure AfterUpdate (Handle: Integer); stdcall;
  end;


{$ifndef iCLX}
  TRGBTripleArray = array[0..MaxPixelCount-1] of TRGBTriple;
  pRGBTripleArray = ^TRGBTripleArray;
{$endif}

  TiOrientation                = (ioVertical, ioHorizontal);
  TiOrientationSide            = (iosBottomRight, iosTopLeft);

  TiFillDirection              = (ifdTopBottom, ifdBottomTop, ifdLeftRight, ifdRightLeft, ifdTopLeftBottomRight, ifdBottomRightTopLeft,
                                  ifdBottomLeftTopRight, ifdTopRightBottomLeft, ifdRectangleOut, ifdRectangleIn, ifdCircleOut, ifdCircleIn);

  TiPlotMarkerStyle            = (ipmsCircle, ipmsSquare, ipmsDiamond, ipmsCross, ipmsPlus, ipmsTriangleUp, ipmsTriangleDown, ipmsTriangleLeft, ipmsTriangleRight, ipmsVerticalLine, ipmsHorizontalLine, ipmsCharacter);
  TiPlotLineStyle              = (iplsSolid, iplsDash, iplsDot, iplsDashDot, iplsDashDotDot);
  TiPlotExportFormat           = (ipefMetaFile, ipefBitmap, ipefJPEG);
  TiPlotUnitReferenceStyle     = (ipurScale, ipurPercent);

  TiRotationAngle              = (ira000, ira090, ira180, ira270);

  TiQuadDirection              = (iqdLeft, iqdTop, iqdRight, iqdBottom);

  TiPointerFillReferenceStyle  = (ipfrsMin, ipfrsMax, ipfrsValue);

  TiIntegerFormatStyle         = (iifsInteger, iifsHex, iifsBinary, iifsOctal);

  TiBevelStyle                 = (ibsNone, ibsRaised, ibsLowered);
  TiLeadingStyle               = (ilsNone, ilsZeros, ilsSpaces);
  TiDrawSection                = (idsNone, idsSection1, idsSection2, idsSection3, idsSection4, idsSection5);

  TiSideAlignment              = (isaBottom, isaTop, isaLeft, isaRight);
  TiAlignmentVertical          = (iavCenter, iavTop,  iavBottom);
  TiAlignmentHorizontal        = (iahCenter, iahLeft, iahRight);
  TiAlignmentSideVertical      = (iasvTop,  iasvBottom);
  TiTitleHorizontalAlignment   = (ithaCenterDisplay, ithaCenterControl);
  TiSwitchIndicatorAlignment   = (isiaBottom, isiaTop);
  TiTickMinorAlignment         = (itmnaInside, itmnaCenter, itmnaOutside);

  TiDirection                  = (idUp, idDown, idRight, idLeft);
  TiCountDirection             = (icdDown, icdUp);

  TiFilterInputStyle           = (ifisNone, ifisAuto);
  TiScaleAlignStyle            = (itasCenter, itasSide);

  TiPrecisionStyle             = (ipsSignificantDigits, ipsFixedDecimalPoints);
  TiAutoScaleStyle             = (iassAutoMinMax, iassFixedMinMax);
  TiRepaintType                = (irtInvalidate, irtBackGround, irtNone);

  TiSliderTrackStyle           = (istsBox, istsLine, istsBevelLowered, istsBevelRasied);
  TiSliderPointerStyle         = (ispsLed, ispsPointer, ispsBar, ispsLightBar, ispsBarColor, ispsBitmap);

  TiLinearGaugePointerStyle    = (ilgpsPointer, ilgpsTriangle, ilgpsTLine, ilgpsColorBar, ilgpsTube, ilgpsBarSunken, ilgpsBarRaised);
  TiAngularGaugePointerStyle   = (iagpsArrowLine, iagpsArrow, iagpsLine, iagpsTriangle);

  TiSwitchSliderIndicatorStyle = (issisDot, issisLine);
  TiSlidingScalePointerStyle   = (isspsDualArrow, isspsArrow, isspsPointer, isspsLine);
  TiSliderMouseControlStyle    = (ismcsSlideOnly, ismcsSlidePage, ismcsGoto);
  TiRotaryMouseControlStyle    = (irmcsRotate, irmcsGoto);

  TiSwitchMomentaryStyle       = (ismsNone, ismsSimple);

  TiLogLabelStyle              = (illsValue, illsScientific);

  TiMouseControlStyle          = (imcsClickAnyWhere, imcsClickIndicator);


  TiClockHourStyle             = (ichs24, ichs12);

  TiLabelAlignment             = (ilaCenter, ilaJustified);

  TiChannelLineStyle           = (iclsSolid, iclsDash, iclsDot, iclsDashDot, iclsDashDotDot);
  TiChannelDataSatus           = (icdsActual, icdsNull, icdsInterpolated);

  TiTextFlag                   = (itfHLeft, itfHCenter, itfHRight, itfVTop, itfVCenter, itfVBottom, itfWordBreak, itfSingleLine, itfExpandTabs, itfNoClip, itfShowPrefix, itfCalcRect, itfEndEllipsis, itfPathEllipsis, itfWordEllipsis, itfModifyString);
  TiTextFlags                  = set of TiTextFlag;

  TiDrawEdgeStyle              = (idesSunken, idesRaised, idesFlat);

  TiDrawObjectType             = (tidoEllipse, tidoRectangle, tidoLine, tidoText, tidoImage, tidoArc, tidoPolygon);

  TiNameSpaceType              = (instFlat, instHierarchial);
  TiBrowseType                 = (ibtBranch, ibtLeaf, ibtFlat);
  TiNetworkResourceType        = (inrtNetwork, inrtDomain, inrtComputer, inrtRoot, inrtIgnore);

  TiServerData = packed record
    Name        : String;
    VersionType : Integer;
  end;
  TiNetData = packed record
    Assigned      : Boolean;
    ResourceType  : TiNetworkResourceType;
    dwScope       : DWORD;
    dwType        : DWORD;
    dwDisplayType : DWORD;
    dwUsage       : DWORD;
    lpLocalName   : PAnsiChar;
    lpRemoteName  : PAnsiChar;
    lpComment     : PAnsiChar;
    lpProvider    : PAnsiChar;
  end;

  TPointDouble = record
    x: Double;
    y: Double;
  end;

  TiRectDouble = record
    Left   : Double;
    Top    : Double;
    Right  : Double;
    Bottom : Double;
  end;

  PointDoubleDynamicArray  = array of TPointDouble;

  TiTypeKind = TTypeKind;


implementation
end.


