{**********************************************}
{   TeeChart Link Tool Editor                  }
{   Copyright (c) 2009 by David Berneda        }
{**********************************************}
unit TeeLinkTool;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls,
  QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls,
  {$ENDIF}
  {$IFDEF CLR}
  Types,
  {$ENDIF}
  TeeTools, TeeProcs, TeeAnnToolEdit, TeCanvas, TeePenDlg, TeEngine,
  Chart;

type
  TLinkTool=class(TAnnotationTool)
  private
    FHint : String;
    FURL  : String;

    IOldHint : String;
    procedure SetHint(const Value: String);
    procedure SetURL(const Value: String);
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    Procedure DrawText; overload; override;
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;

    procedure Assign(Source:TPersistent); override;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Cursor default crHandPoint;
    property Hint:String read FHint write SetHint;
    property URL:String read FURL write SetURL;
  end;

  TLinkToolEditor = class(TAnnotationToolEdit)
    TabLink: TTabSheet;
    Label16: TLabel;
    EURL: TEdit;
    Label17: TLabel;
    EHint: TEdit;
    Label18: TLabel;
    EText: TEdit;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure EURLChange(Sender: TObject);
    procedure EHintChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ETextChange(Sender: TObject);
  private
    { Private declarations }
    Link : TLinkTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeeProCo;

{ TLinkTool }
Constructor TLinkTool.Create(AOwner: TComponent);
begin
  inherited;

  Cursor:=crHandPoint;

  with Shape do
  begin
    Transparent:=True;
    Shadow.Visible:=False;
    Font.Color:=clNavy;
    Font.Style:=[fsUnderline];
  end;
end;

class Function TLinkTool.Description:String;
begin
  result:=TeeMsg_LinkTool;
end;

class Function TLinkTool.LongDescription:String;
begin
  result:=TeeMsg_LinkToolDesc;
end;

procedure TLinkTool.SetHint(const Value: String);
begin
  FHint:=Value;
end;

procedure TLinkTool.SetURL(const Value: String);
begin
  if FURL<>Value then
  begin
    FURL:=Value;

    if (Text='') and (URL<>'') then
       Text:=URL;
  end;
end;

procedure TLinkTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp  : String;
    tmp2 : String;

    {$IFNDEF D9}

    {$IFNDEF CLX}
    tmpW    : TWMMouse;

    {$IFDEF CLR}
    tmpWMes : TMessage;
    {$ENDIF}

    {$ENDIF}
    {$ENDIF}
begin
  inherited;

  if (AEvent=cmeDown) and (Button=mbLeft) and Clicked(X,Y) then
  begin
    tmp:=Trim(URL);

    if tmp='' then
    begin
      tmp2:=UpperCase(Trim(Text));

      if (Copy(tmp2,1,4)='WWW.') or (Copy(tmp2,1,7)='HTTP://') then
          tmp:=Trim(Text);
    end;

    if tmp<>'' then
       TeeGotoURL({$IFDEF CLX}nil{$ELSE}Application.Handle{$ENDIF},tmp);

    ParentChart.CancelMouse:=True;
  end
  else
  if (AEvent=cmeMove) then
     if Clicked(X,Y) then
     begin
       if Hint<>'' then
       begin
         if ParentChart.Hint<>Hint then
         begin
           Application.CancelHint;

           ParentChart.ShowHint:=True;

           IOldHint:=ParentChart.Hint;
           ParentChart.Hint:=Hint;

           {$IFNDEF D9}
           // Workaround a bug before Delphi 2005

           {$IFDEF CLX}
           Application.HintMouseMessage(ParentChart,[],X,Y);
           {$ELSE}

           {$IFDEF CLR}
           tmpW:=TWMMouse.Create;
           {$ENDIF}

           tmpW.Msg:=WM_MOUSEMOVE;
           tmpW.XPos:=X;
           tmpW.YPos:=Y;

           {$IFDEF CLR}
           tmpWMes:=TMessage(tmpW);
           Application.HintMouseMessage(ParentChart,tmpWMes);
           {$ELSE} 
           Application.HintMouseMessage(ParentChart,TMessage(tmpW));
           {$ENDIF}

           {$ENDIF}

           {$ENDIF}
         end;

          {$IFDEF D5}
          // Application.ActivateHint(ParentChart.ClientToScreen(TeePoint(X,Y)));
          {$ENDIF}
       end;
     end
     else
     if Hint<>'' then
        if ParentChart.Hint=Hint then
        begin
          Application.CancelHint;
          ParentChart.Hint:=IOldHint;
        end;
end;

procedure TLinkToolEditor.FormShow(Sender: TObject);
begin
  inherited;

  if Assigned(Tool) then
  begin
    Link:=TLinkTool(Tool);

    EText.Text:=Link.Text;
    EURL.Text:=Link.URL;
    EHint.Text:=Link.Hint;
  end;
end;

procedure TLinkToolEditor.EURLChange(Sender: TObject);
begin
  Link.URL:=EURL.Text;
end;

procedure TLinkToolEditor.EHintChange(Sender: TObject);
begin
  Link.Hint:=EHint.Text;
end;

class function TLinkTool.GetEditorClass: String;
begin
  result:='TLinkToolEditor';
end;

procedure TLinkTool.DrawText;
begin
  if Supports(ParentChart.Canvas,ICanvasHyperlinks) then
  begin
    ParentChart.Canvas.AssignFont(Shape.Font);
    (ParentChart.Canvas as ICanvasHyperlinks).AddLink(Left,Top,Text,URL,Hint);
  end
  else
     inherited;
end;

procedure TLinkToolEditor.FormCreate(Sender: TObject);
begin
  inherited;

  Timer1.Enabled:=True;
end;

procedure TLinkToolEditor.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;
  PageControl1.ActivePage:=TabLink;
end;

procedure TLinkToolEditor.ETextChange(Sender: TObject);
begin
  Link.Text:=EText.Text;
end;

procedure TLinkTool.Assign(Source: TPersistent);
begin
  if Source is TLinkTool then
  with TLinkTool(Source) do
  begin
    Self.FHint:=FHint;
    Self.FURL:=FURL;
  end;

  inherited;
end;

initialization
  RegisterClass(TLinkToolEditor);
  RegisterTeeTools([TLinkTool]);
finalization
  UnRegisterTeeTools([TLinkTool]);
end.
