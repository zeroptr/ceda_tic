{*******************************************************}
{                                                       }
{       TiCustomComponent Component                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iCustomComponent;{$endif}
{$ifdef iCLX}unit QiCustomComponent;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iVCLComponent;{$ENDIF}
  {$IFDEF iCLX}QiCLXComponent;{$ENDIF}

type
  {$ifdef iVCL} TiCustomComponent = class(TiVCLComponent){$endif}
  {$ifdef iCLX} TiCustomComponent = class(TiCLXComponent){$endif}
  public
  end;

implementation

end.
