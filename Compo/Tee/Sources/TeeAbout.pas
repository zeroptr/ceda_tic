{**********************************************}
{   TeeChart and TeeTree VCL / CLX About Form  }
{   Copyright (c) 1995-2009 by David Berneda   }
{**********************************************}
unit TeeAbout;
{$I TeeDefs.inc}

interface

uses {$IFDEF LINUX}
     Libc,
     {$ELSE}
     {$IFDEF LCL}
     LCLIntf,
     {$ELSE}
     Windows, Messages,
     {$ENDIF}
     {$ENDIF}
     {$IFDEF CLX}
     Qt, QGraphics, QControls, QForms, QExtCtrls, QStdCtrls, QTypes,
     {$ELSE}
     Graphics, Controls, Forms, ExtCtrls, StdCtrls, Buttons,
     {$ENDIF}

     {$IFNDEF CLX}
     {$IFNDEF CLR}
     jpeg,
     {$ENDIF}
     {$ENDIF}

     Classes, SysUtils, TeeFilters;

type
  TTeeAboutForm = class(TForm)
    BClose: TButton;
    LabelCopy: TLabel;
    LabelVersion: TLabel;
    Label1: TLabel;
    Labelwww: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    LabelEval: TLabel;
    procedure LabelwwwClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{ Displays the TeeChart about-box dialog }
Procedure TeeShowAboutBox(Const ACaption:String=''; Const AVersion:String='');

Var TeeAboutBoxProc:Procedure=nil;
    TeeIsTrial:Boolean=False;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFDEF CLR}
     System.Reflection,
     {$ENDIF}
     TeCanvas, TeeProcs, TeeConst;

Procedure TeeShowAboutBox(Const ACaption:String=''; Const AVersion:String='');
var tmp : TTeeAboutForm;
begin
  tmp:=TTeeAboutForm.Create(nil);

  with tmp do
  try
    if ACaption<>'' then Caption:=ACaption;
    if AVersion<>'' then LabelVersion.Caption:=AVersion;

    {$IFDEF TEEBETA}
    LabelEval.Caption:=LabelEval.Caption+' (BETA)'; // Do not localize
    {$ENDIF}

    if TeeIsTrial then
       LabelEval.Caption:=LabelEval.Caption+' TRIAL'; // Do not localize

    TeeTranslateControl(tmp);
    Labelwww.Width := 313;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TTeeAboutForm.LabelwwwClick(Sender: TObject);
begin
  TeeGotoURL(Handle,LabelWWW.Caption);
end;

procedure TTeeAboutForm.FormCreate(Sender: TObject);
begin
  {$IFNDEF CLX}
  DoubleBuffered:=False;
  {$ENDIF}

  Caption:=Caption+' '+TeeMsg_Version; // Do not localize
  LabelVersion.Caption:=TeeMsg_Version {$IFDEF CLX}+' CLX'{$ENDIF}; // Do not localize

  {$IFDEF CLR}
  LabelVersion.Caption:=LabelVersion.Caption+'   '+ // Do not localize
      System.Reflection.Assembly.GetExecutingAssembly.GetName.Version.ToString;
  LabelVersion.AutoSize:=True;
  {$ENDIF}

  LabelCopy.Caption:=TeeMsg_Copyright;
  BorderStyle:=TeeBorderStyle;
end;

Procedure TeeShowAboutBox2;
begin
  if Assigned(TeeAboutBoxProc) then
  begin
    TeeShowAboutBox;
    TeeAboutBoxProc:=nil;
  end;
end;

initialization
  TeeAboutBoxProc:=TeeShowAboutBox2;
finalization
  TeeAboutBoxProc:=nil;
end.
