{*******************************************************}
{                                                       }
{       Iocomp Include Uses File                        }
{                                                       }
{       Copyright (c) 1997,2001 Iocomp Software         }
{                                                       }
{*******************************************************}

{$I iIncludeUsesForms.inc}

  {$IFDEF LINUX}    Classes, {$ENDIF}
  {$IFDEF MSWINDOWS}Classes, {$ENDIF}

  {$IFDEF COMPILER_6_UP}Variants,{$ENDIF}
  
  {$IFDEF iCLX} QControls, QComCtrls, QStdCtrls, QExtCtrls, {$ENDIF}
  {$IFDEF iVCL}  Controls,  ComCtrls,  StdCtrls,  ExtCtrls, {$ENDIF}

