{******************************************}
{ TIWChart Component                       }
{ IntraWeb Compatible TeeChart             }
{ Run-Time Unit                            }
{                                          }
{ Copyright (c) 2002-2007 by David Berneda }
{ All Rights Reserved                      }
{                                          }
{ Intraweb is Copyright:                   }
{  Copyright © 2001-2007 AToZed Software.  }
{  All rights Reserved.                    }
{******************************************}
{$I TeeDefs.inc}
unit IWCompTeeChart;

// Updated. May-2007.  Added Intraweb 9.0 support.
// Updated. Feb-2004.  Added Intraweb 7.0 support.
// Updated. Sep-2003.  Added Intraweb 6.0 support.
// Updated. Feb-2002.  Added DBChart support.

interface

uses 
  Classes, 
  Chart, Series, 
  IWExtCtrls, IWHTMLTag, IWRenderContext;

type
  TIWChart=class(TIWDynamicImage)
  private
    FChart: TCustomChart;
    procedure SetChart(const Value: TCustomChart);
  protected
    procedure Notification( AComponent: TComponent; Operation: TOperation); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Function RenderHTML(AContext: TIWBaseHTMLComponentContext):TIWHTMLTag; override;
  published
    property Chart:TCustomChart read FChart write SetChart;
  end;

implementation

uses 
  SysUtils, Graphics, TeeProcs;

{ TIWChart }
Constructor TIWChart.Create(AOwner: TComponent);
begin
  inherited;
  CreatePicture;
end;

Destructor TIWChart.Destroy;
begin
  Chart:=nil;
  inherited;
end;

procedure TIWChart.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

  if Operation=opRemove then
     if Assigned(FChart) and (AComponent=FChart) then
        Chart:=nil;
end;


// If you are using Intraweb with TeeChart **PRO** then you can
// comment this $define to increase speed when generating the chart pictures:

{$DEFINE TEECHARTSTANDARD}

Function TIWChart.RenderHTML(AContext: TIWBaseHTMLComponentContext):TIWHTMLTag;
var tmp : TBitmap;
begin
  if Assigned(FChart) then
  with FChart do
  begin
    FPicture.Bitmap.Width:=Width;
    FPicture.Bitmap.Height:=Height;

    {$IFDEF TEECHARTSTANDARD}

    // For compatibility with TeeChart Standard v4.
    // Use a somewhat slower method to obtain a picture from FChart chart:

    tmp:=TeeCreateBitmap(Color,Rect(0,0,Width,Height));
    try
      FPicture.Assign(tmp);
    finally
      tmp.Free;
    end;

    {$ELSE}

    // With TeeChart Pro do a more aggressive (and fast) way to get FChart picture:

    FPicture.Assign(FChart);
 
    {$ENDIF}

  end;

  result:=inherited RenderHTML(AContext);
end;

procedure TIWChart.SetChart(const Value: TCustomChart);
begin
  if FChart<>Value then
  begin
    {$IFDEF D5}
    if Assigned(FChart) then 
       FChart.RemoveFreeNotification(Self);
    {$ENDIF}

    FChart:=Value;

    if Assigned(FChart) then 
       FChart.FreeNotification(Self);
  end;
end;

end.
