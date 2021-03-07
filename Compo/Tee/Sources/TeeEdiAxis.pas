{**********************************************}
{  TCustomChart (or derived) Editor Dialog     }
{  Copyright (c) 1996-2009 by David Berneda    }
{**********************************************}
unit TeeEdiAxis;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons,
     {$ENDIF}
     TeEngine, TeeEdiFont, TeCanvas, TeeProcs, TeePenDlg, TeeCustomShapeEditor;

type
  TFormTeeAxis = class(TForm)
    PageAxis: TPageControl;
    TabScales: TTabSheet;
    TabTitle: TTabSheet;
    TabLabels: TTabSheet;
    TabTicks: TTabSheet;
    L28: TLabel;
    L29: TLabel;
    BAxisPen: TButtonPen;
    BTickPen: TButtonPen;
    BTickInner: TButtonPen;
    SEAxisTickLength: TEdit;
    SEInnerTicksLength: TEdit;
    CBTickOnLabels: TCheckBox;
    UDInnerTicksLength: TUpDown;
    UDAxisTickLength: TUpDown;
    TabPositions: TTabSheet;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    EPos: TEdit;
    EStart: TEdit;
    EEnd: TEdit;
    UDPos: TUpDown;
    UDStart: TUpDown;
    UDEnd: TUpDown;
    TabMinorTicks: TTabSheet;
    L31: TLabel;
    SEMinorCount: TEdit;
    UDMinorCount: TUpDown;
    BMinorGrid: TButtonPen;
    CBOtherSide: TCheckBox;
    CBHorizAxis: TCheckBox;
    PageTitle: TPageControl;
    TabTitleStyle: TTabSheet;
    L14: TLabel;
    ETitle: TEdit;
    L3: TLabel;
    SETitleAngle: TEdit;
    UDTitleAngle: TUpDown;
    L9: TLabel;
    SETitleSize: TEdit;
    UDTitleSize: TUpDown;
    CBTitleVisible: TCheckBox;
    PageLabels: TPageControl;
    TabLabStyle: TTabSheet;
    CBLabels: TCheckBox;
    CBMultiline: TCheckBox;
    CBOnAxis: TCheckBox;
    CBRoundFirst: TCheckBox;
    SELabelsSize: TEdit;
    L26: TLabel;
    L23: TLabel;
    SELabelsAngle: TEdit;
    UDLabelsAngle: TUpDown;
    UDLabelsSize: TUpDown;
    L20: TLabel;
    SESepar: TEdit;
    UDSepar: TUpDown;
    TabLabelsFont: TTabSheet;
    Panel1: TPanel;
    TabLabFormat: TTabSheet;
    LabelAxisFormat: TLabel;
    CBFormat: TComboFlat;
    CBExpo: TCheckBox;
    CBLabelAlign: TCheckBox;
    Splitter1: TSplitter;
    Panel2: TPanel;
    BAdd: TSpeedButton;
    BDelete: TSpeedButton;
    Panel4: TPanel;
    CBShow: TCheckBox;
    CBAxisBeh: TCheckBox;
    Label1: TLabel;
    LBAxes: TListBox;
    LabelZ: TLabel;
    Edit1: TEdit;
    UDZ: TUpDown;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CBAutoMax: TCheckBox;
    BAxisMax: TButton;
    LAxisMax: TLabel;
    CBAutoMin: TCheckBox;
    BAxisMin: TButton;
    LAxisMin: TLabel;
    Label4: TLabel;
    EMinOff: TEdit;
    UDMinOff: TUpDown;
    Label5: TLabel;
    EMaxOff: TEdit;
    UDMaxOff: TUpDown;
    Label7: TLabel;
    CBPosUnits: TComboFlat;
    Label3: TLabel;
    CBLabelStyle: TComboFlat;
    CBAlternate: TCheckBox;
    Button1: TButton;
    BTickMinor: TButtonPen;
    L30: TLabel;
    SEAxisMinorTickLen: TEdit;
    UDAxisMinorTickLen: TUpDown;
    BAxisGrid: TButtonPen;
    Label6: TLabel;
    Edit2: TEdit;
    UDGridZ: TUpDown;
    CBGridCentered: TCheckBox;
    Label8: TLabel;
    EMarksEvery: TEdit;
    UDEvery: TUpDown;
    TabSheet3: TTabSheet;
    BIncre: TButton;
    L6: TLabel;
    LAxisIncre: TLabel;
    TabSheet4: TTabSheet;
    CBAutomatic: TCheckBox;
    CBLogarithmic: TCheckBox;
    CBVisible: TCheckBox;
    CBInverted: TCheckBox;
    Label2: TLabel;
    ELogBase: TEdit;
    LogE: TCheckBox;
    CBShowAll: TCheckBox;
    CBMinRound: TCheckBox;
    CBMaxRound: TCheckBox;
    TabTitleFormat: TTabSheet;
    PageTitleFormat: TPageControl;
    Label9: TLabel;
    Edit3: TEdit;
    UDMinorC: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure CBVisibleClick(Sender: TObject);
    procedure SEAxisTickLengthChange(Sender: TObject);
    procedure CBAutomaticClick(Sender: TObject);
    procedure ETitleChange(Sender: TObject);
    procedure BAxisMaxClick(Sender: TObject);
    procedure BAxisMinClick(Sender: TObject);
    procedure BIncreClick(Sender: TObject);
    procedure CBLogarithmicClick(Sender: TObject);
    procedure SEInnerTicksLengthChange(Sender: TObject);
    procedure SEAxisMinorTickLenChange(Sender: TObject);
    procedure SEMinorCountChange(Sender: TObject);
    procedure CBAutoMaxClick(Sender: TObject);
    procedure CBInvertedClick(Sender: TObject);
    procedure SETitleAngleChange(Sender: TObject);
    procedure SETitleSizeChange(Sender: TObject);
    procedure CBLabelsClick(Sender: TObject);
    procedure SELabelsAngleChange(Sender: TObject);
    procedure RGLabelStyleClick(Sender: TObject);
    procedure SELabelsSizeChange(Sender: TObject);
    procedure CBOnAxisClick(Sender: TObject);
    procedure SESeparChange(Sender: TObject);
    procedure CBRoundFirstClick(Sender: TObject);
    procedure CBTickOnLabelsClick(Sender: TObject);
    procedure CBGridCenteredClick(Sender: TObject);
    procedure CBMultilineClick(Sender: TObject);
    procedure PageAxisChange(Sender: TObject);
    procedure CBShowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageAxisChanging(Sender: TObject; var AllowChange: Boolean);
    procedure EPosChange(Sender: TObject);
    procedure EStartChange(Sender: TObject);
    procedure EEndChange(Sender: TObject);
    procedure LBAxesClick(Sender: TObject);
    procedure BAddClick(Sender: TObject);
    procedure CBOtherSideClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure CBHorizAxisClick(Sender: TObject);
    procedure ELogBaseChange(Sender: TObject);
    procedure CBTitleVisibleClick(Sender: TObject);
    procedure CBFormatChange(Sender: TObject);
    procedure CBExpoClick(Sender: TObject);
    procedure CBAxisBehClick(Sender: TObject);
    procedure CBLabelAlignClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure EMinOffChange(Sender: TObject);
    procedure EMaxOffChange(Sender: TObject);
    procedure LogEClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure CBPosUnitsChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBAlternateClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EMarksEveryChange(Sender: TObject);
    procedure CBShowAllClick(Sender: TObject);
    procedure CBMinRoundClick(Sender: TObject);
    procedure CBMaxRoundClick(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure PageTitleFormatChange(Sender: TObject);
    procedure PageLabelsChange(Sender: TObject);
    procedure PageTitleChange(Sender: TObject);
  private
    { Private declarations }
    CreatingForm  : Boolean;
    IChangingAuto : Boolean;
    ILabelsFont   : TTeeFontEditor;
    ITitleEditor  : TFormTeeShape;

    Procedure SetAxisIndex;
    Procedure SetAxisScales;
    Procedure EnableLogBaseControls;
    procedure EditAxisMaxMin(Const ATitle:String; ACheckBox:TCheckBox;
                             IsMax:Boolean);
  public
    { Public declarations }
    TheAxis : TChartAxis;
    NotifyCustom : TNotifyEvent;

    Constructor CreateAxis(Owner:TComponent; AAxis:TChartAxis);
  end;

procedure TeeAddAxes(AChart:TCustomAxisPanel; AList:TStrings; AddDepth:Boolean);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses
  TeeConst, TeeAxisIncr, TeeBrushDlg, TeeAxMaxMin, Chart, TeeFormatting;

procedure TeeAddAxes(AChart:TCustomAxisPanel; AList:TStrings; AddDepth:Boolean);
var t : Integer;
begin
  With AList do
  begin
    Clear;
    Add(TeeMsg_LeftAxis);
    Add(TeeMsg_RightAxis);
    Add(TeeMsg_TopAxis);
    Add(TeeMsg_BottomAxis);

    if AddDepth then
    begin
      Add(TeeMsg_DepthAxis);
      Add(TeeMsg_DepthTopAxis);
    end;

    if Assigned(AChart) then
    for t:=TeeInitialCustomAxis to AChart.Axes.Count-1 do
        Add(TeeMsg_CustomAxesEditor+IntToStr(t-TeeInitialCustomAxis));
  end;
end;

Constructor TFormTeeAxis.CreateAxis(Owner:TComponent; AAxis:TChartAxis);
begin
  CreatingForm:=True;
  inherited Create(Owner);
  IChangingAuto:=False;
  TheAxis:=AAxis;
end;

Procedure TFormTeeAxis.SetAxisIndex;
begin
  With TheAxis.ParentChart,LBAxes do
  if TheAxis=LeftAxis   then ItemIndex:=0 else
  if TheAxis=RightAxis  then ItemIndex:=1 else
  if TheAxis=TopAxis    then ItemIndex:=2 else
  if TheAxis=BottomAxis then ItemIndex:=3 else
  if TheAxis=DepthAxis  then ItemIndex:=4 else
  if TheAxis=DepthTopAxis then ItemIndex:=5 else
     ItemIndex:=Axes.IndexOf(TheAxis);
end;

procedure TFormTeeAxis.FormShow(Sender: TObject);
begin
  if Assigned(TheAxis) then
  begin
    TeeAddAxes(TheAxis.ParentChart,LBAxes.Items,True);
    SetAxisIndex;

    CBShow.Checked:=TheAxis.ParentChart.Axes.Visible;
    CBAxisBeh.Checked:=TheAxis.ParentChart.Axes.Behind;

    PageAxis.ActivePage:=TabScales;
    PageLabels.ActivePage:=TabLabStyle;
    PageTitle.ActivePage:=TabTitleStyle;
    PageAxisChange(Self);
  end;
end;

procedure TFormTeeAxis.CBVisibleClick(Sender: TObject);
begin
  TheAxis.Visible:=CBVisible.Checked;
end;

procedure TFormTeeAxis.SEAxisTickLengthChange(Sender: TObject);
begin
  if not CreatingForm then TheAxis.TickLength:=UDAxisTickLength.Position;
end;

procedure TFormTeeAxis.CBAutomaticClick(Sender: TObject);
begin
  if not IChangingAuto then { 5.01 }
  begin
    With TheAxis do
    begin
      Automatic:=CBAutomatic.Checked;

      if Automatic then
         AdjustMaxMin
      else
      begin
        AutomaticMaximum:=False;
        AutomaticMinimum:=False;
      end;
    end;

    SetAxisScales;
  end;
end;

procedure TFormTeeAxis.ETitleChange(Sender: TObject);
{$IFDEF AXUNICODE}
  function CheckChars : Boolean;
  var i : Integer;
  Begin
    result:=True;
    if Pos('@U#',ETitle.Text)=1 then
      for i:=4 to Length(ETitle.Text) do
      Begin
        if not (((ETitle.Text[i]>='0') and (ETitle.Text[i]<='9'))
           or ((UpperCase(ETitle.Text[i])>='A') and (UpperCase(ETitle.Text[i])<='F'))
           or (ETitle.Text[i]=' ')) then
           result:=False;
      end;
  end;
{$ENDIF}
begin
{$IFDEF AXUNICODE}
  if not CheckChars then
    ETitle.Text:=Copy(ETitle.Text,2,Length(ETitle.Text));
{$ENDIF}
  TheAxis.Title.Caption:=ETitle.Text;
end;

procedure TFormTeeAxis.EditAxisMaxMin(Const ATitle:String; ACheckBox:TCheckBox;
                                      IsMax:Boolean);
var tmp : TAxisMaxMin;
begin
  tmp:=TAxisMaxMin.Create(Self);

  with tmp do
  try
    Caption:=ATitle+' '+(TheAxis.ParentChart as TCustomChart).AxisTitleOrName(TheAxis);

    IsDateTime:=TheAxis.IsDateTime;

    if IsMax then MaxMin:=TheAxis.Maximum
             else MaxMin:=TheAxis.Minimum;

    TeeTranslateControl(tmp);

    if ShowModal=mrOk then
    Begin
      if IsMax then TheAxis.Maximum:=MaxMin
               else TheAxis.Minimum:=MaxMin;

      ACheckBox.Checked:=False;
      SetAxisScales;
    end;
  finally
    Free;
  end;
end;

procedure TFormTeeAxis.BAxisMaxClick(Sender: TObject);
begin
  EditAxisMaxMin(TeeMsg_Maximum,CBAutoMax,True);
end;

procedure TFormTeeAxis.BAxisMinClick(Sender: TObject);
begin
  EditAxisMaxMin(TeeMsg_Minimum,CBAutoMin,False);
end;

procedure TFormTeeAxis.BIncreClick(Sender: TObject);
begin
  if TAxisIncrement.ChangeIncrement(Self,TheAxis) then
     SetAxisScales;
end;

procedure TFormTeeAxis.CBLogarithmicClick(Sender: TObject);
begin
  try
    try
      TheAxis.Logarithmic:=CBLogarithmic.Checked;
    except
      on AxisException do
      Begin
        TheAxis.Logarithmic:=False;
        CBLogarithmic.Checked:=False;
        Raise;
      end;
    end;
  finally
    EnableLogBaseControls;
  end;
end;

Procedure TFormTeeAxis.EnableLogBaseControls;
begin
  ELogBase.Enabled:=CBLogarithmic.Checked and CBLogarithmic.Enabled;
  LogE.Enabled:=ELogBase.Enabled;
end;

procedure TFormTeeAxis.SEInnerTicksLengthChange(Sender: TObject);
begin
  if not CreatingForm then
     TheAxis.TickInnerLength:=UDInnerTicksLength.Position;
end;

procedure TFormTeeAxis.SEAxisMinorTickLenChange(Sender: TObject);
begin
  if not CreatingForm then TheAxis.MinorTickLength:=UDAxisMinorTickLen.Position;
end;

procedure TFormTeeAxis.SEMinorCountChange(Sender: TObject);
begin
  if not CreatingForm then
     TheAxis.MinorTickCount:=UDMinorCount.Position;
end;

procedure TFormTeeAxis.CBAutoMaxClick(Sender: TObject);
begin
  if not IChangingAuto then
  begin
    With TheAxis do
    if Sender=CBAutoMax then
    begin
      AutomaticMaximum:=CBAutoMax.Checked;
      CBMaxRound.Enabled:=CBAutoMax.Checked;
    end
    else
    begin
      AutomaticMinimum:=CBAutoMin.Checked;
      CBMinRound.Enabled:=CBAutoMin.Checked;
    end;

    TheAxis.AdjustMaxMin;
    SetAxisScales;
  end;
end;

procedure TFormTeeAxis.CBInvertedClick(Sender: TObject);
begin
  TheAxis.Inverted:=CBInverted.Checked;
end;

procedure TFormTeeAxis.SETitleAngleChange(Sender: TObject);
begin
  if not CreatingForm then TheAxis.Title.Angle:=UDTitleAngle.Position;
end;

procedure TFormTeeAxis.SETitleSizeChange(Sender: TObject);
begin
  if not CreatingForm then TheAxis.TitleSize:=UDTitleSize.Position;
end;

procedure TFormTeeAxis.CBLabelsClick(Sender: TObject);
begin
  TheAxis.Labels:=CBLabels.Checked;
end;

procedure TFormTeeAxis.SELabelsAngleChange(Sender: TObject);
begin
  if not CreatingForm then TheAxis.LabelsAngle:=UDLabelsAngle.Position;
end;

procedure TFormTeeAxis.RGLabelStyleClick(Sender: TObject);
begin
  TheAxis.LabelStyle:=TAxisLabelStyle(CBLabelStyle.ItemIndex);
end;

procedure TFormTeeAxis.SELabelsSizeChange(Sender: TObject);
begin
  if not CreatingForm then TheAxis.LabelsSize:=UDLabelsSize.Position;
end;

procedure TFormTeeAxis.CBOnAxisClick(Sender: TObject);
begin
  TheAxis.LabelsOnAxis:=CBOnAxis.Checked;
end;

procedure TFormTeeAxis.SESeparChange(Sender: TObject);
begin
  if not CreatingForm then
  begin
    TheAxis.LabelsSeparation:=UDSepar.Position;
    CBShowAll.Checked:=TheAxis.LabelsSeparation=0;
  end;
end;

procedure TFormTeeAxis.CBRoundFirstClick(Sender: TObject);
begin
  TheAxis.RoundFirstLabel:=CBRoundFirst.Checked;
end;

procedure TFormTeeAxis.CBTickOnLabelsClick(Sender: TObject);
begin
  TheAxis.TickOnLabelsOnly:=CBTickOnLabels.Checked;
end;

procedure TFormTeeAxis.CBGridCenteredClick(Sender: TObject);
begin
  TheAxis.Grid.Centered:=CBGridCentered.Checked;
end;

procedure TFormTeeAxis.CBMultilineClick(Sender: TObject);
begin
  TheAxis.LabelsMultiLine:=CBMultiline.Checked;
end;

Procedure TFormTeeAxis.SetAxisScales;
Begin
  With TheAxis do
  Begin
    LAxisIncre.Caption:=GetIncrementText(Self,Increment,IsDateTime,ExactDateTime,AxisValuesFormat);

    if IsDateTime then
    begin
      if Minimum>=1 then LAxisMin.Caption:=DateTimeToStr(Minimum)
                    else LAxisMin.Caption:=TimeToStr(Minimum);
      if Maximum>=1 then LAxisMax.Caption:=DateTimeToStr(Maximum)
                    else LAxisMax.Caption:=TimeToStr(Maximum);
    end
    else
    begin
      LAxisMin.Caption:=FormatFloat(AxisValuesFormat,Minimum);
      LAxisMax.Caption:=FormatFloat(AxisValuesFormat,Maximum);
    end;

    IChangingAuto:=True;

    CBAutomatic.Checked:=Automatic;
    CBAutoMax.Checked:=AutomaticMaximum;
    CBAutoMin.Checked:=AutomaticMinimum;
    UDMaxOff.Position:=MaximumOffset;
    UDMinOff.Position:=MinimumOffset;
    CBMaxRound.Checked:=MaximumRound;
    CBMinRound.Checked:=MinimumRound;
    CBMaxRound.Enabled:=AutomaticMaximum;
    CBMinRound.Enabled:=AutomaticMinimum;

    IChangingAuto:=False;

    CBLogarithmic.Checked:=Logarithmic;
    CBLogarithmic.Enabled:=not IsDepthAxis;
    LogE.Checked:=LogarithmicBase=Exp(1);
    eLogBase.Text:=FloatToStr(LogarithmicBase);

    EnableLogBaseControls;

    CBInverted.Checked:=Inverted;
    CBVisible.Checked:=Visible;

    CBShowAll.Checked:=LabelsSeparation=0;
  end;
end;

procedure TFormTeeAxis.PageAxisChange(Sender: TObject);

  Procedure SetAxisLabels;
  var tmp : String;
  begin  { Axis Labels  }
    with TheAxis do
    begin
      CBLabels.Checked:=Labels;
      CBLabelStyle.ItemIndex:=Ord(LabelStyle);
      CBOnAxis.Checked:=LabelsOnAxis;
      CBRoundFirst.Checked:=RoundFirstLabel;
      UDLabelsAngle.Position:=LabelsAngle;
      UDSepar.Position:=LabelsSeparation;
      UDLabelsSize.Position:=LabelsSize;
      CBMultiline.Checked:=LabelsMultiLine;
      CBExpo.Checked:=LabelsExponent;
      CBFormat.Items.Clear;
      CBAlternate.Checked:=LabelsAlternate;

      if IsDateTime then
      begin
        With CBFormat.Items do
        if Maximum-Minimum<=1 then
        begin
          Add(ShortTimeFormat);
          Add(LongTimeFormat);
          Add('hh:nn');
          Add('hh:nn:ss');
          Add('hh:nn:ss.zzz');
        end
        else
        begin
          Add(ShortDateFormat);
          Add(LongDateFormat);
          Add('yyyy-mm-dd');
          Add('mm-dd-yyyy');
          Add('dd-mm-yyyy');
          Add('ddd');
          Add('dddd');
          Add('mmm');
          Add('mmmm');
        end;

        LabelAxisFormat.Caption:=TeeMsg_DateTimeFormat;
        tmp:=DateTimeFormat;
        if tmp='' then tmp:=DateTimeDefaultFormat(Maximum-Minimum);
      end
      else
      begin
        AddDefaultValueFormats(CBFormat.Items);
        LabelAxisFormat.Caption:=TeeMsg_ValuesFormat;
        tmp:=AxisValuesFormat;

        if tmp='' then
           tmp:=TeeMsg_DefValueFormat;

        tmp:=DelphiToLocalFormat(tmp);
      end;

      with CBFormat.Items do
      if IndexOf(tmp)=-1 then
         Add(tmp);

      CBFormat.Text:=tmp;

      if Assigned(ILabelsFont) then
         ILabelsFont.RefreshControls(LabelsFont);
    end;
  end;

  Procedure SetAxisTicks;
  begin
    with TheAxis do
    begin
      UDAxisTickLength.Position:=TickLength;
      UDInnerTicksLength.Position:=TickInnerLength;
      CBTickOnLabels.Checked:=TickOnLabelsOnly;
      UDAxisMinorTickLen.Position:=MinorTickLength;
      UDMinorC.Position:=MinorTickCount;
    end;
  end;

  Procedure SetAxisGrids;
  begin
    with TheAxis do
    begin
      CBGridCentered.Checked:=Grid.Centered;
      UDGridZ.Position:=Round(Grid.ZPosition);
      UDEvery.Position:=Grid.DrawEvery;
      UDMinorCount.Position:=MinorTickCount;
    end;
  end;

  Procedure SetAxisTitle;
  begin
    with TheAxis do
    begin
      ETitle.Text:=Title.Caption;
      UDTitleAngle.Position:=Title.Angle;
      UDTitleSize.Position:=TitleSize;
      CBTitleVisible.Checked:=Title.Visible;

      if Assigned(ITitleEditor) then
         ITitleEditor.RefreshControls(Title);
    end;
  end;

  Procedure SetAxisPositions;
  begin
    with TheAxis do
    begin
      UDPos.Position:=Round(PositionPercent);
      UDStart.Position:=Round(StartPosition);
      UDEnd.Position:=Round(EndPosition);
      UDZ.Position:=Round(ZPosition);
      CBPosUnits.ItemIndex:=Ord(TheAxis.PositionUnits);

      CBOtherSide.Checked:=OtherSide;
      CBOtherSide.Enabled:=LBAxes.ItemIndex>=TeeInitialCustomAxis;
      CBHorizAxis.Checked:=Horizontal;
      CBHorizAxis.Enabled:=LBAxes.ItemIndex>=TeeInitialCustomAxis;
      UDZ.Enabled:=not IsDepthAxis;
      Edit1.Enabled:=not IsDepthAxis;
    end;
  end;

begin
  {$IFDEF CLX}
  if not Showing then Exit;
  {$ENDIF}

  if not Assigned(TheAxis) then Exit;

  With TheAxis do
  begin
    BAxisGrid.LinkPen(Grid);
    BTickMinor.LinkPen(MinorTicks);
    BTickInner.LinkPen(TicksInner);
    BTickPen.LinkPen(Ticks);
    BAxisPen.LinkPen(Axis);
    BMinorGrid.LinkPen(MinorGrid);
  end;

  With PageAxis do
  if ActivePage=TabLabels then SetAxisLabels else
  if ActivePage=TabScales then SetAxisScales else
  if ActivePage=TabTitle then SetAxisTitle else
  if ActivePage=TabTicks then SetAxisTicks else
  if ActivePage=TabMinorTicks then SetAxisGrids else
  if ActivePage=TabPositions then SetAxisPositions;

  BDelete.Enabled:=LBAxes.ItemIndex>=TeeInitialCustomAxis;
  CBVisible.Checked:=TheAxis.Visible;

  CBLabelAlign.Checked:=TheAxis.LabelsAlign=alDefault;
  CBLabelAlign.Enabled:=(not TheAxis.Horizontal) and (not TheAxis.IsDepthAxis);

  CreatingForm:=False;
end;

procedure TFormTeeAxis.CBShowClick(Sender: TObject);
begin
  TheAxis.ParentChart.Axes.Visible:=CBShow.Checked;
end;

procedure TFormTeeAxis.FormCreate(Sender: TObject);
begin
  {$IFDEF TEELITE}
  BAdd.Visible:=False;
  BDelete.Visible:=False;
  {$ENDIF}

  CreatingForm:=True;
end;

procedure TFormTeeAxis.PageAxisChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  CreatingForm:=True;
end;

procedure TFormTeeAxis.EPosChange(Sender: TObject);
begin
  if not CreatingForm then TheAxis.PositionPercent:=UDPos.Position;
end;

procedure TFormTeeAxis.EStartChange(Sender: TObject);
begin
  if not CreatingForm then
    if UDStart.Position<TheAxis.EndPosition then
       TheAxis.StartPosition:=UDStart.Position
    else
       UDStart.Position:=Round(TheAxis.StartPosition);
end;

procedure TFormTeeAxis.EEndChange(Sender: TObject);
begin
  if not CreatingForm then
    if UDEnd.Position>TheAxis.StartPosition then
       TheAxis.EndPosition:=UDEnd.Position
    else
       UDEnd.Position:=Round(TheAxis.EndPosition);
end;

procedure TFormTeeAxis.LBAxesClick(Sender: TObject);
begin
  With TheAxis.ParentChart do
  Case LBAxes.ItemIndex of
    0: TheAxis:=LeftAxis;
    1: TheAxis:=RightAxis;
    2: TheAxis:=TopAxis;
    3: TheAxis:=BottomAxis;
    4: TheAxis:=DepthAxis;
    5: TheAxis:=DepthTopAxis;
  else TheAxis:=Axes[LBAxes.ItemIndex];
  end;

  CreatingForm:=True;

  PageAxisChange(Self);
end;

procedure TFormTeeAxis.BAddClick(Sender: TObject);
begin
  TheAxis:=TChartAxis.Create(TheAxis.ParentChart.CustomAxes);
  TeeAddAxes(TheAxis.ParentChart,LBAxes.Items,True);
  SetAxisIndex;
  PageAxisChange(Self);
end;

procedure TFormTeeAxis.CBOtherSideClick(Sender: TObject);
begin
  TheAxis.OtherSide:=CBOtherSide.Checked;
end;

procedure TFormTeeAxis.BDeleteClick(Sender: TObject);
var tmp : Integer;
begin
  TheAxis.Free;
  With LBAxes do
  begin
    tmp:=ItemIndex;
    Items.Delete(tmp);
    ItemIndex:=tmp-1;
  end;

  LBAxesClick(Self);
end;

procedure TFormTeeAxis.CBHorizAxisClick(Sender: TObject);
begin
  if TheAxis.ParentChart.Axes.IndexOf(TheAxis)>=TeeInitialCustomAxis then
  begin
    TheAxis.Horizontal:=CBHorizAxis.Checked;

    if Assigned(NotifyCustom) then
       NotifyCustom(TheAxis);
  end;
end;

procedure TFormTeeAxis.ELogBaseChange(Sender: TObject);
var tmp : Double;
begin
  if not CreatingForm then
  begin
    tmp:=StrToFloatDef(ELogBase.Text,TheAxis.LogarithmicBase);

    if (tmp<>1) and (tmp<>0) then
    begin
      TheAxis.LogarithmicBase:=tmp;
      LogE.Checked:=TheAxis.LogarithmicBase=Exp(1);
      LogE.Enabled:=not LogE.Checked;
    end;
  end;
end;

procedure TFormTeeAxis.CBTitleVisibleClick(Sender: TObject);
begin
  TheAxis.Title.Visible:=CBTitleVisible.Checked
end;

procedure TFormTeeAxis.CBFormatChange(Sender: TObject);
begin
  With TheAxis do
  if IsDateTime then DateTimeFormat:=CBFormat.Text
                else AxisValuesFormat:=LocalToDelphiFormat(CBFormat.Text);
end;

procedure TFormTeeAxis.CBExpoClick(Sender: TObject);
begin
  TheAxis.LabelsExponent:=CBExpo.Checked;
end;

procedure TFormTeeAxis.CBAxisBehClick(Sender: TObject);
begin
  TheAxis.ParentChart.Axes.Behind:=CBAxisBeh.Checked;
end;

procedure TFormTeeAxis.CBLabelAlignClick(Sender: TObject);
begin
  if CBLabelAlign.Checked then
     TheAxis.LabelsAlign:=alDefault
  else
     TheAxis.LabelsAlign:=alOpposite;
end;

procedure TFormTeeAxis.Edit1Change(Sender: TObject);
begin
  if not CreatingForm then TheAxis.ZPosition:=UDZ.Position;
end;

procedure TFormTeeAxis.EMinOffChange(Sender: TObject);
begin
  if not CreatingForm then TheAxis.MinimumOffset:=UDMinOff.Position;
end;

procedure TFormTeeAxis.EMaxOffChange(Sender: TObject);
begin
  if not CreatingForm then TheAxis.MaximumOffset:=UDMaxOff.Position;
end;

procedure TFormTeeAxis.LogEClick(Sender: TObject);
begin
  ELogBase.Text:=FloatToStr(Exp(1));
  LogE.Enabled:=False;
end;

procedure TFormTeeAxis.Edit2Change(Sender: TObject);
begin
  if not CreatingForm then
     TheAxis.Grid.ZPosition:=UDGridZ.Position;
end;

procedure TFormTeeAxis.CBPosUnitsChange(Sender: TObject);
begin
  if not CreatingForm then
     TheAxis.PositionUnits:=TTeeUnits(CBPosUnits.ItemIndex);
end;

procedure TFormTeeAxis.FormDestroy(Sender: TObject);
begin
  PageAxis.Parent:=Self;
end;

procedure TFormTeeAxis.CBAlternateClick(Sender: TObject);
begin
  TheAxis.LabelsAlternate:=CBAlternate.Checked;
end;

procedure TFormTeeAxis.Button1Click(Sender: TObject);
begin
  CBFormat.Text:=TFormatEditor.Change(Self,CBFormat.Text,TheAxis.IsDateTime);
  CBFormatChange(Self);
end;

procedure TFormTeeAxis.EMarksEveryChange(Sender: TObject);
begin
  if not CreatingForm then
     TheAxis.Grid.DrawEvery:=UDEvery.Position;
end;

procedure TFormTeeAxis.CBShowAllClick(Sender: TObject);
begin
  if CBShowAll.Checked then
     TheAxis.LabelsSeparation:=0
  else
     TheAxis.LabelsSeparation:=TeeDefaultLabelsSeparation;
end;

procedure TFormTeeAxis.CBMinRoundClick(Sender: TObject);
begin
  TheAxis.MinimumRound:=CBMinRound.Checked;
end;

procedure TFormTeeAxis.CBMaxRoundClick(Sender: TObject);
begin
  TheAxis.MaximumRound:=CBMaxRound.Checked;
end;

procedure TFormTeeAxis.Edit3Change(Sender: TObject);
begin
  if not CreatingForm then
     TheAxis.MinorTickCount:=UDMinorC.Position;
end;

procedure TFormTeeAxis.PageTitleFormatChange(Sender: TObject);
begin
  ITitleEditor.PC1Change(Sender);
end;

procedure TFormTeeAxis.PageLabelsChange(Sender: TObject);
begin
  if (PageLabels.ActivePage=TabLabelsFont) and (TabLabelsFont.ControlCount=0) then
  begin
    ILabelsFont:=InsertTeeFontEditor(TabLabelsFont);
    ILabelsFont.RefreshControls(TheAxis.LabelsFont);
  end;
end;

procedure TFormTeeAxis.PageTitleChange(Sender: TObject);
begin
  if (PageTitle.ActivePage=TabTitleFormat) and (PageTitleFormat.PageCount=0) then
  begin
    ITitleEditor:=InsertTeeObjectForm(PageTitleFormat,TheAxis.Title);
    ITitleEditor.RefreshControls(TheAxis.Title);
  end;
end;

end.
