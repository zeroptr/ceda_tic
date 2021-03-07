{*******************************************************}
{                                                       }
{       Iocomp Include Uses Forms File                  }
{                                                       }
{       Copyright (c) 1997,2001 Iocomp Software         }
{                                                       }
{*******************************************************}

  {$IFDEF LINUX}    Xlib,    SysUtils, Libc,{$ENDIF}
  {$IFDEF MSWINDOWS}Windows, SysUtils,      {$ENDIF}
                                                    
  TypInfo,                                         
  {$IFDEF iCLX} Qt, QGraphics, QForms, QDialogs, QClipBrd, QTypes, Types,                                {$ENDIF}
  {$IFDEF iVCL}      Graphics,  Forms,  Dialogs,  ClipBrd, {$IFDEF COMPILER_6_UP}Types,{$ENDIF} Messages,{$ENDIF}

