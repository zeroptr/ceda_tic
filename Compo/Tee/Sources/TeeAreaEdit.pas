{**********************************************}
{   TAreaSeries Component Editor Dialog        }
{   Copyright (c) 1996-2009 by David Berneda   }
{**********************************************}
unit TeeAreaEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     {$ENDIF}
     Chart, Series, TeCanvas, TeePenDlg, TeeProcs;

type
  TAreaSeriesEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    RGMultiArea: TRadioGroup;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    CBUseOrigin: TCheckBox;
    EOrigin: TEdit;
    UDOrigin: TUpDown;
    GroupBox2: TGroupBox;
    CBStairs: TCheckBox;
    BAreaLinesPen: TButtonPen;
    BAreaLinePen: TButtonPen;
    CBInvStairs: TCheckBox;
    BPattern: TButton;
    Button1: TButton;
    GroupBox5: TGroupBox;
    ETransp: TEdit;
    UDTransp: TUpDown;
    CBDark3D: TCheckBox;
    GroupBox1: TGroupBox;
    CBColorEach: TCheckBox;
    BAreaColor: TButtonColor;
    GroupBox4: TGroupBox;
    CBNulls: TComboFlat;
    GroupBox6: TGroupBox;
    EGroup: TEdit;
    UDGroup: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure RGMultiAreaClick(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure CBStairsClick(Sender: TObject);
    procedure CBInvStairsClick(Sender: TObject);
    procedure CBUseOriginClick(Sender: TObject);
    procedure EOriginChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BPatternClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ETranspChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBNullsChange(Sender: TObject);
    procedure CBDark3DClick(Sender: TObject);
    procedure EGroupChange(Sender: TObject);
  private
    { Private declarations }
    Area : TAreaSeries;
    PointerForm : TCustomForm;
    FGradientForm : TCustomForm;

    Procedure EnableOrigin;
    Function GetAreaColor:TColor;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.dfm}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeEngine, TeeEdiSeri, TeeEdiGrad, TeeBrushDlg, TeePoEdi, TeeConst;

procedure TAreaSeriesEditor.FormShow(Sender: TObject);
begin
  Area:=TAreaSeries({$IFDEF CLR}TObject{$ENDIF}(Tag));

  if Assigned(Area) then
  begin
    with Area do
    begin
      RGMultiArea.ItemIndex :=Ord(MultiArea);
      CBColorEach.Checked   :=ColorEachPoint;
      CBStairs.Checked      :=Stairs;
      CBInvStairs.Checked   :=InvertedStairs;
      CBInvStairs.Enabled   :=Stairs;
      CBUseOrigin.Checked   :=UseYOrigin;
      UDOrigin.Position     :=Round(YOrigin);
      BAreaLinesPen.LinkPen(AreaLinesPen);
      BAreaLinePen.LinkPen(LinePen);
      UDTransp.Position     :=Transparency;
      CBNulls.ItemIndex     :=Ord(TreatNulls);
      CBDark3D.Checked      :=Dark3D;
      UDGroup.Position      :=StackGroup;
    end;

    with BAreaColor do
    begin
      GetColorProc:=GetAreaColor;
      LinkProperty(Area,'SeriesColor'); // Do not localize
      Enabled:=not Area.ColorEachPoint;
    end;

    EnableOrigin;
    EnableControls(Area.MultiArea<>maNone,[EGroup,UDGroup]);

    if not Assigned(PointerForm) then
       PointerForm:=TeeInsertPointerForm(Parent,Area.Pointer,TeeMsg_GalleryPoint);

    // Gradient editor
    if (not Assigned(FGradientForm)) and Assigned(Parent) then
    begin
      FGradientForm:=TFormTeeSeries.InsertSeriesForm(Parent,
                        TTeeGradientEditor,2,TeeMsg_Gradient,Area.Gradient);

      (FGradientForm as TTeeGradientEditor).Panel1.Hide;
    end;
  end;
end;

procedure TAreaSeriesEditor.RGMultiAreaClick(Sender: TObject);
begin
  Area.MultiArea:=TMultiArea(RGMultiArea.ItemIndex);
  EnableControls(Area.MultiArea<>maNone,[EGroup,UDGroup]);
end;

procedure TAreaSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  Area.ColorEachPoint:=CBColorEach.Checked;
  BAreaColor.Enabled:=not Area.ColorEachPoint;
end;

Function TAreaSeriesEditor.GetAreaColor:TColor;
begin
  with Area do
  if AreaColor=clTeeColor then result:=SeriesColor
                          else result:=AreaColor;
end;

procedure TAreaSeriesEditor.CBStairsClick(Sender: TObject);
begin
  Area.Stairs:=CBStairs.Checked;
  CBInvStairs.Enabled:=Area.Stairs;
end;

procedure TAreaSeriesEditor.CBInvStairsClick(Sender: TObject);
begin
  Area.InvertedStairs:=CBInvStairs.Checked;
end;

procedure TAreaSeriesEditor.CBUseOriginClick(Sender: TObject);
begin
  Area.UseYOrigin:=CBUseOrigin.Checked;
  EnableOrigin;
end;

procedure TAreaSeriesEditor.EOriginChange(Sender: TObject);
begin
  if Showing and Assigned(Area) then
     Area.YOrigin:=UDOrigin.Position
end;

Procedure TAreaSeriesEditor.EnableOrigin;
begin
  EOrigin.Enabled:=CBUseOrigin.Checked;
  UDOrigin.Enabled:=EOrigin.Enabled;
end;

procedure TAreaSeriesEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  BorderStyle:=TeeBorderStyle;
end;

procedure TAreaSeriesEditor.BPatternClick(Sender: TObject);
begin
  EditChartBrush(Self,Area.AreaChartBrush);
end;

procedure TAreaSeriesEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,Area.Brush);
end;

procedure TAreaSeriesEditor.ETranspChange(Sender: TObject);
begin
  if Showing then Area.Transparency:=UDTransp.Position;
end;

procedure TAreaSeriesEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(PointerForm);
end;

procedure TAreaSeriesEditor.CBNullsChange(Sender: TObject);
begin
  Area.TreatNulls:=TTreatNullsStyle(CBNulls.ItemIndex);
end;

procedure TAreaSeriesEditor.CBDark3DClick(Sender: TObject);
begin
  Area.Dark3D:=CBDark3D.Checked;
end;

procedure TAreaSeriesEditor.EGroupChange(Sender: TObject);
begin
  if Showing and Assigned(Area) then
     Area.StackGroup:=UDGroup.Position;
end;

initialization
  RegisterClass(TAreaSeriesEditor);
end.
