{*******************************************************}
{                                                       }
{       TiPipeJoint Component                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPipeJoint;{$endif}
{$ifdef iCLX}unit QiPipeJoint;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent;{$ENDIF}

type
  TiPipeJoint = class(TiCustomComponent)
  protected
    procedure iPaintTo(Canvas: TCanvas);    override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Width  default 25;
    property Height default 25;

    property BackGroundColor;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiPipeJoint.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 25;
  Height := 25;

  BorderStyle := ibsRaised;
end;
//****************************************************************************************************************************************************
procedure TiPipeJoint.iPaintTo(Canvas: TCanvas);
begin
  DrawBackGround(Canvas, BackGroundColor);
  DrawBorder(Canvas);
end;
//****************************************************************************************************************************************************
end.
