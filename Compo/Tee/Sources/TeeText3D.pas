{**********************************************}
{   TeeChart - 3D text tool                    }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeeText3D;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  Qt, QGraphics, QControls, QForms, QDialogs, QComCtrls, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  {$ENDIF}
  TeCanvas, TeeProcs, TeEngine, Chart, TeeEdiFont, TeeBrushDlg;

type
  TText3DTool=class(TTeeCustomTool)
  private
    FAngle     : Double;
    FFont      : TTeeFont;
    FPosition  : TFloatXYZ;
    FRotation  : TFloatXYZ;
    FText      : String;

    procedure Changed(Sender:TObject);
    procedure DestroyPolygons;
    procedure SetAngle(const Value:Double);
    procedure SetFont(const Value:TTeeFont);
    procedure SetPosition(const Value:TFloatXYZ);
    procedure SetRotation(const Value:TFloatXYZ);
    procedure SetText(const Value:String);
  protected
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    class Function GetEditorClass:String; override;
  public
    Interior     : Array of Boolean;
    PolygonCount : Integer;
    Polygons     : Array of TPointArray;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Angle:Double read FAngle write SetAngle;
    property Brush;
    property Font:TTeeFont read FFont write SetFont;
    property Pen;
    property Position:TFloatXYZ read FPosition write SetPosition;
    property Rotation:TFloatXYZ read FRotation write SetRotation;
    property Text:String read FText write SetText;
  end;

  TText3DEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabFont: TTabSheet;
    Label1: TLabel;
    MemoText: TMemo;
    TabSheet3: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    ECustLeft: TEdit;
    UDLeft: TUpDown;
    ECustTop: TEdit;
    UDTop: TUpDown;
    Button1: TButton;
    Label2: TLabel;
    Edit1: TEdit;
    UDZ: TUpDown;
    Button2: TButton;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    TBRotation: TTrackBar;
    LRotation: TLabel;
    Label6: TLabel;
    TBElevation: TTrackBar;
    LElevation: TLabel;
    Label7: TLabel;
    TBTilt: TTrackBar;
    LTilt: TLabel;
    procedure ECustLeftChange(Sender: TObject);
    procedure ECustTopChange(Sender: TObject);
    procedure MemoTextChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TBRotationChange(Sender: TObject);
    procedure TBElevationChange(Sender: TObject);
    procedure TBTiltChange(Sender: TObject);
  private
    { Private declarations }
    Tool : TText3DTool;
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
  {$IFDEF CLR}
  System.Runtime.InteropServices,  // Marshal
  {$ENDIF}
  TeeStringsEditor, TeeProCo;

Constructor TText3DTool.Create(AOwner:TComponent);
begin
  inherited;

  FFont:=TTeeFont.Create(CanvasChanged);
  FFont.Size:=24;

  FFont.OutLine.Color:=clWhite;
  FFont.OutLine.Show;

  Brush.Color:=clWhite;
  Brush.BackColor:=Font.Color;

  FPosition:=TFloatXYZ.Create;
  FPosition.X:=50;
  FPosition.Y:=50;
  FPosition.OnChange:=Changed;

  FRotation:=TFloatXYZ.Create;
  FRotation.OnChange:=Changed;
end;

Destructor TText3DTool.Destroy;
begin
  DestroyPolygons;
  FFont.Free;
  FRotation.Free;
  FPosition.Free;
  inherited;
end;

procedure TText3DTool.Changed(Sender:TObject);
begin
  Repaint;
end;

procedure TText3DTool.DestroyPolygons;
var t : Integer;
begin
  Interior:=nil;

  for t:=0 to PolygonCount-1 do
      Polygons[t]:=nil;

  Polygons:=nil;
  PolygonCount:=0;
end;

type
  {$IFNDEF CLR}
  TPArray=packed Array[0..0] of TPoint;
  PTP=^TPArray;
  TBArray=packed Array[0..0] of Byte;
  PTB=^TBArray;
  {$ENDIF}

  TTeeCanvas3DAccess=class(TTeeCanvas3D);
  TChartAccess=class(TCustomChart);

Procedure TText3DTool.ChartEvent(AEvent:TChartToolEvent);

  procedure DrawPolygons;

    procedure DoDrawPolygons(AColor,ABack:TColor);
    var t : Integer;
        tt : Integer;
        Clipped  : Boolean;
        PP       : TPointArray;
        tmpZ     : Integer;
    begin
      PP:=nil;

      tmpZ:=Round(FPosition.Z);

      for t:=0 to PolygonCount-1 do
      begin
        if Interior[t] then
        begin
          if FFont.OutLine.Visible then
          begin
            ParentChart.Canvas.Brush.Style:=bsClear;
            ParentChart.Canvas.PolygonWithZ(Polygons[t],tmpZ);
            ParentChart.Canvas.AssignBrush(Brush,ABack,AColor);
          end;
        end
        else
        begin
          Clipped:=False;

          for tt:=0 to PolygonCount-1 do
          if tt<>t then
             if PolygonInPolygon(Polygons[tt],Polygons[t]) then
             begin
               PP:=ParentChart.Canvas.Calc3DPoints(Polygons[tt],tmpZ);
               try
                 ParentChart.Canvas.ClipPolygon(PP,Length(PP),True);
               finally
                 PP:=nil;
               end;

               Clipped:=True;
             end;

          if Assigned(FFont.Picture) and Assigned(FFont.Picture.Graphic) then
          begin
            PP:=ParentChart.Canvas.Calc3DPoints(Polygons[t],tmpZ);
            try
              ParentChart.Canvas.ClipPolygon(PP,Length(PP),False);
              ParentChart.Canvas.StretchDraw(PolygonBounds(PP),FFont.Picture.Filtered);
              Clipped:=True;

              if FFont.OutLine.Visible then
              begin
                ParentChart.Canvas.UnClipRectangle;
                ParentChart.Canvas.Brush.Style:=bsClear;
                ParentChart.Canvas.Polygon(PP);
                ParentChart.Canvas.AssignBrush(Brush,AColor,ABack);
              end;

            finally
              PP:=nil;
            end;
          end
          else
          if FFont.Gradient.Visible then
          begin
            FFont.Gradient.Draw(ParentChart.Canvas,Polygons[t],tmpZ,ParentChart.View3D);

            if FFont.OutLine.Visible then
            begin
              ParentChart.Canvas.Brush.Style:=bsClear;

              PP:=ParentChart.Canvas.Calc3DPoints(Polygons[t],tmpZ);
              try
                ParentChart.Canvas.Polygon(PP);
              finally
                PP:=nil;
              end;

              ParentChart.Canvas.AssignBrush(Brush,AColor,ABack);
            end;
          end
          else
          begin
            {
            if Smooth.Active then
               ParentChart.Canvas.PolygonWithZ(Smooth.Calculate(Polygons[t]),ZPos)
            else
            }
               ParentChart.Canvas.PolygonWithZ(Polygons[t],tmpZ);
          end;

          if Clipped then
             ParentChart.Canvas.UnClipRectangle;
        end;
      end;
    end;

  var t : Integer;
      tt : Integer;
      AShadow  : TTeeShadow;
      tmpColor : TColor;

      OldR,
      OldE : Double;
      OldT : Integer;
      tmpRotate : Boolean;
  begin
    // Apply rotation
    tmpRotate:= (Rotation.X<>0) or (Rotation.Y<>0) or (Rotation.Z<>0);

    if tmpRotate then
    begin
      with ParentChart.Canvas.View3DOptions do
      begin
        oldR:=RotationFloat;
        oldE:=ElevationFloat;
        oldT:=Tilt;

        RotationFloat:=oldR+Self.Rotation.X;
        ElevationFloat:=oldE+Self.Rotation.Y;
        Tilt:=oldT+Round(Self.Rotation.Z);
      end;

      if ParentChart.Canvas is TTeeCanvas3D then
      begin
        TTeeCanvas3DAccess(ParentChart.Canvas).CalcTrigValues;
        TTeeCanvas3DAccess(ParentChart.Canvas).CalcPerspective(ParentChart.ChartRect);
      end;

      // Restore previous rotation
      with ParentChart.Canvas.View3DOptions do
      begin
        RotationFloat:=oldR;
        ElevationFloat:=oldE;
        Tilt:=oldT;
      end;
    end;

    ParentChart.Canvas.AssignBrush(Brush);

    SetLength(Interior,PolygonCount);

    for t:=0 to PolygonCount-1 do
    begin
      Interior[t]:=False;

      for tt:=0 to PolygonCount-1 do
      if tt<>t then
         if PolygonInPolygon(Polygons[t],Polygons[tt]) then
         begin
           Interior[t]:=True;
           break;
         end;
    end;

    AShadow:=FFont.Shadow;

    if AShadow.Visible and (AShadow.Size<>0) then
    begin
      if ParentChart.Canvas is TTeeCanvas3D then
      begin
        Inc(TTeeCanvas3DAccess(ParentChart.Canvas).XCenterOffset,AShadow.HorizSize);
        Inc(TTeeCanvas3DAccess(ParentChart.Canvas).YCenterOffset,AShadow.VertSize);
      end;

      ParentChart.Canvas.AssignBrush(Brush,AShadow.Color,AShadow.Color);
      ParentChart.Canvas.AssignVisiblePenColor(FFont.OutLine,AShadow.Color);

      tmpColor:=AShadow.Color;

      DoDrawPolygons(tmpColor,tmpColor);

      ParentChart.Canvas.AssignBrush(Brush);
      ParentChart.Canvas.AssignVisiblePen(FFont.OutLine);

      if ParentChart.Canvas is TTeeCanvas3D then
      begin
        Dec(TTeeCanvas3DAccess(ParentChart.Canvas).XCenterOffset,AShadow.HorizSize);
        Dec(TTeeCanvas3DAccess(ParentChart.Canvas).YCenterOffset,AShadow.VertSize);
      end;
    end;

    DoDrawPolygons(Brush.Color,Brush.BackColor);

    if tmpRotate then
    if ParentChart.Canvas is TTeeCanvas3D then
    begin
      TTeeCanvas3DAccess(ParentChart.Canvas).CalcTrigValues;
      TTeeCanvas3DAccess(ParentChart.Canvas).CalcPerspective(ParentChart.ChartRect);
    end;
  end;

  Procedure CreatePolygons;

    procedure AddPoint(const P:TPoint);
    var
      tmpCount : Integer;
    begin
      tmpCount:=Length(Polygons[PolygonCount-1]);
      SetLength(Polygons[PolygonCount-1],tmpCount+1);
      Polygons[PolygonCount-1,tmpCount]:=P;
    end;

  var DC : HDC;
      LogRec : TLogFont;
      NewFont,
      OldFont : HFont;

      {$IFDEF CLR}
      P     : Array of TPoint;
      Types : Array of Byte;
      {$ELSE}
      NullP : Pointer;
      NullT : Pointer;
      P     : PTP;
      Types : PTB;
      {$ENDIF}

      tmp   : Integer;
      tmpC  : Integer;
      t     : Integer;
      tmpHeight : Integer;
      tmpNumLines : Integer;
      b     : Byte;
      PL,P0 : TPoint;
      St    : String;
  begin
    DC:={$IFDEF CLX}QPainter_Handle{$ENDIF}(ParentChart.Canvas.Handle);

    if BeginPath(DC) then
    begin
      if FAngle<>0 then
      begin
        {$IFDEF CLR}
        GetObject(ParentChart.Canvas.Font.Handle,
                  Marshal.SizeOf(TypeOf(TLogFont)), LogRec);
        {$ELSE}
        GetObject({$IFDEF CLX}QFont_Handle{$ENDIF}(ParentChart.Canvas.Font.Handle),
                  SizeOf(LogRec), @LogRec);
        {$ENDIF}

        LogRec.lfOrientation:=Round(FAngle*10.0);

        NewFont:=CreateFontIndirect({$IFDEF LCL}@{$ENDIF}LogRec);
        OldFont:=SelectObject(DC,NewFont);

        SetGraphicsMode(DC,GM_ADVANCED);
      end
      else OldFont:=0;

      tmpHeight:=ParentChart.Canvas.FontHeight;
      ParentChart.MultiLineTextWidth(FText,tmpNumLines);

      for t:=1 to tmpNumLines do
      begin
        St:=TeeExtractField(FText,t,TeeLineSeparator);
        Windows.TextOut(DC,Round(FPosition.X),Round(FPosition.Y)+((t-1)*tmpHeight),
                        {$IFNDEF CLR}PChar{$ENDIF}(St),Length(St));
      end;

      if FAngle<>0 then
      begin
        DeleteObject(SelectObject(DC,OldFont));
        SetGraphicsMode(DC,GM_LAST);
      end;

      if not EndPath(DC) then
         {$IFNDEF CLX}
         Abort
         {$ENDIF}
         ;

      if not FlattenPath(DC) then 
         {$IFNDEF CLX}
         Abort
         {$ENDIF}
         ;

      // optional:  WidenPath(DC);

      {$IFDEF CLR}
      tmp:=GetPath(DC,P,Types,0);
      {$ELSE}
      NullP:=nil;
      NullT:=nil;
      tmp:=GetPath(DC,NullP^,NullT^,0);
      {$ENDIF}

      if tmp>0 then
      begin
        {$IFDEF CLR}
        SetLength(P,tmp);
        SetLength(Types,tmp);
        GetPath(DC,P,Types,tmp);
        {$ELSE}
        GetMem(P,SizeOf(TPoint)*tmp);
        GetMem(Types,SizeOf(Byte)*tmp);
        GetPath(DC,P^,Types^,tmp);
        {$ENDIF}

        if tmp=-1 then
        begin
          tmp:=GetLastError;
          Raise Exception.Create('GetPath error: '+IntToStr(tmp));
        end;

        if tmp>0 then
        begin
          PolygonCount:=0;

          for t:=0 to tmp-1 do
          begin
            {$IFOPT R+}
            {$DEFINE WASRANGE}
            {$ENDIF}

            {$R-}

            b:=Types[t];

            case b of
             PT_MOVETO : begin
                           Inc(PolygonCount);
                           SetLength(Polygons,PolygonCount);
                           AddPoint(P[t]);
                         end;
             PT_LINETO : AddPoint(P[t]);
           PT_BEZIERTO : AddPoint(P[t]);

        PT_CLOSEFIGURE : ;
        PT_CLOSEFIGURE+
             PT_LINETO : AddPoint(P[t]);
        PT_CLOSEFIGURE+
        PT_BEZIERTO    :  AddPoint(P[t]);

               {$IFNDEF CLX}
               else
                 Abort;  // error !
               {$ENDIF}
            end;
          end;

          {$IFDEF WASRANGE}
          {$R+}
          {$ENDIF}

          for t:=0 to PolygonCount-1 do
          begin
            tmpC:=Length(Polygons[t])-1;

            if tmpC>0 then
            begin
              P0:=Polygons[t,0];

              while tmpC>1 do
              begin
                PL:=Polygons[t,tmpC];

                if (PL.X=P0.X) and (PL.Y=P0.Y) then
                begin
                  SetLength(Polygons[t],tmpC);
                  Dec(tmpC);
                end
                else Break;
              end;
            end;
          end;
        end;

        {$IFDEF CLR}
        Types:=nil;
        P:=nil;
        {$ELSE}
        FreeMem(Types);
        FreeMem(P);
        {$ENDIF}
      end;
    end;
  end;

begin
  inherited;

  if AEvent=cteAfterDraw then
  begin
    ParentChart.Canvas.BackMode:=cbmTransparent;
    ParentChart.Canvas.AssignVisiblePen(FFont.OutLine);
    ParentChart.Canvas.AssignFont(FFont);
    Brush.BackColor:=Font.Color;

    DestroyPolygons;
    CreatePolygons;
    DrawPolygons;
  end;
end;

class function TText3DTool.Description: String;
begin
  result:=TeeMsg_Text3D;
end;

class function TText3DTool.LongDescription: String;
begin
  result:=TeeMsg_Text3DDesc;
end;

procedure TText3DTool.SetAngle(const Value: Double);
begin
  SetDoubleProperty(FAngle,Value);
end;

procedure TText3DTool.SetFont(const Value: TTeeFont);
begin
  FFont.Assign(Value);
end;

procedure TText3DTool.SetText(const Value: String);
begin
  SetStringProperty(FText,Value);
end;

procedure TText3DTool.SetPosition(const Value: TFloatXYZ);
begin
  FPosition.Assign(Value);
end;

procedure TText3DTool.SetRotation(const Value: TFloatXYZ);
begin
  FRotation.Assign(Value);
end;

procedure TText3DEditor.ECustLeftChange(Sender: TObject);
begin
  if Showing then
     Tool.Position.X:=Round(UDLeft.Position);
end;

procedure TText3DEditor.ECustTopChange(Sender: TObject);
begin
  if Showing then
     Tool.Position.Y:=Round(UDTop.Position);
end;

procedure TText3DEditor.MemoTextChange(Sender: TObject);
begin
  Tool.Text:=ReplaceChar(MemoText.Lines.Text,#10);
end;

procedure TText3DEditor.FormShow(Sender: TObject);
begin
  Tool:=TText3DTool(Tag);

  if Assigned(Tool) then
  with Tool do
  begin
    InsertTeeFontEditor(TabFont).RefreshControls(Font);

    UDLeft.Position:=Round(Position.X);
    UDTop.Position:=Round(Position.Y);
    UDZ.Position:=Round(Position.Z);
    MemoText.Text:=Text;

    TBRotation.Position:=Round(Rotation.X);
    TBElevation.Position:=Round(Rotation.Y);
    TBTilt.Position:=Round(Rotation.Z);
  end;
end;

procedure TText3DTool.Assign(Source: TPersistent);
begin
  if Source is TText3DTool then
  with TText3DTool(Source) do
  begin
    Self.FAngle:=FAngle;
    Self.FFont.Assign(FFont);
    Self.FPosition.Assign(FPosition);
    Self.FRotation.Assign(FRotation);
    Self.FText:=FText;
  end;

  inherited;
end;

class function TText3DTool.GetEditorClass: String;
begin
  result:='TText3DEditor'; // Do not localize
end;

procedure TText3DEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,Tool.Brush);
end;

procedure TText3DEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     Tool.Position.Z:=Round(UDZ.Position);
end;

procedure TText3DEditor.Button2Click(Sender: TObject);
begin
  TeeEditStrings(Self,MemoText.Lines);
end;

procedure TText3DEditor.TBRotationChange(Sender: TObject);
begin
  Tool.Rotation.X:=TBRotation.Position;
  LRotation.Caption:=IntToStr(TBRotation.Position);
end;

procedure TText3DEditor.TBElevationChange(Sender: TObject);
begin
  Tool.Rotation.Y:=TBElevation.Position;
  LElevation.Caption:=IntToStr(TBElevation.Position);
end;

procedure TText3DEditor.TBTiltChange(Sender: TObject);
begin
  Tool.Rotation.Z:=TBTilt.Position;
  LTilt.Caption:=IntToStr(TBTilt.Position);
end;

initialization
  RegisterClass(TText3DEditor);
  RegisterTeeTools([TText3DTool]);
finalization
  UnRegisterTeeTools([TText3DTool]);
end.

