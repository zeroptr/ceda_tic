{**********************************************}
{   TeeChart Export Dialog - Inherited         }
{   Copyright (c) 1996-2009 by David Berneda   }
{**********************************************}
unit TeExport;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ENDIF}
  TeeExport, TeeProcs, TeCanvas, Buttons;

type
  TTeeExportForm = class(TTeeExportFormBase)
  private
    { Private declarations }

    {$IFNDEF CLX}
    {$IFNDEF LCL}
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    {$ENDIF}
    {$ENDIF}
  protected
    Function CreateData:TTeeExportData; override;
    Procedure DoSaveNativeToFile( Const FileName:String;
                                  IncludeData:Boolean); override;
    Function ExistData:Boolean; override;
    Function CreateNativeStream:TStream; override;
    Procedure PrepareOnShow; override;
  public
    { Public declarations }
  end;

{ Show the Export dialog }
{ example: TeeExport(Self,Chart1); }
Procedure TeeExport(AOwner:TComponent; APanel:TCustomTeePanel); overload;
Procedure TeeExport(AOwner:TComponent; APanel:TCustomTeePanel; InitialDir:String); overload;

{ Show the Save dialog and save to AFormat export format }
{ example: TeeSavePanel(TGIFExportFormat,Chart1); }
Procedure TeeSavePanel(AFormat:TTeeExportFormatClass; APanel:TCustomTeePanel);

{ starts the MAPI (eg: Outlook) application with an empty new email
  message with the attachment file "FileName" }
Procedure TeeEmailFile(Const FileName:String; Const Subject:String='TeeChart'); // Do not localize

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeeConst, TeeStore, TeEngine, Chart;

Procedure TeeExport(AOwner:TComponent; APanel:TCustomTeePanel; InitialDir:String);
begin
  With TTeeExportForm.Create(AOwner) do
  try
    ExportPanel:=APanel;
    InitDir:=InitialDir;
    ShowModal;
  finally
    Free;
  end;
end;

Procedure TeeExport(AOwner:TComponent; APanel:TCustomTeePanel);
begin
  TeExport.TeeExport(AOwner,APanel,'');
end;

Procedure TeeSavePanel(AFormat:TTeeExportFormatClass; APanel:TCustomTeePanel);
begin
  TeeExportSavePanel(AFormat,APanel);
end;

Procedure TeeEmailFile(Const FileName:String; Const Subject:String='TeeChart'); // Do not localize
begin
  InternalTeeEmailFile(FileName,Subject);
end;

{ TTeeExportForm }

function TTeeExportForm.CreateData: TTeeExportData;

  Function SelectedSeries:TChartSeries;
  begin
    result:=TChartSeries(CBSeries.SelectedObject);
  end;

  function Chart: TCustomChart;
  begin
    result:=TCustomChart(ExportPanel);
  end;

begin
  Case RGText.ItemIndex of
    0: begin
         result:=TSeriesDataText.Create(Chart,SelectedSeries);
         TSeriesDataText(result).TextDelimiter:=GetSeparator;
         TSeriesDataText(result).TextQuotes:=EQuotes.Text; // 7.0
       end;
    1: result:=TSeriesDataXML.Create(Chart,SelectedSeries);
    2: result:=TSeriesDataHTML.Create(Chart,SelectedSeries);
  else
    result:=TSeriesDataXLS.Create(Chart,SelectedSeries);
  end;

  // Configure options
  With TSeriesData(result) do
  begin
    IncludeLabels:=CBLabels.Checked;
    IncludeIndex :=CBIndex.Checked;
    IncludeHeader:=CBHeader.Checked;
    IncludeColors:=CBColors.Checked;

    UseSeriesFormat:=CBUseSeriesFormat.Checked;

    if not UseSeriesFormat then
       ValueFormat:=LocalToDelphiFormat(SeriesValueFormat.Text);
  end;
end;

function TTeeExportForm.ExistData: Boolean;
begin
  result:=(ExportPanel is TCustomAxisPanel) and
          (TCustomAxisPanel(ExportPanel).SeriesCount>0);
end;

Procedure TTeeExportForm.DoSaveNativeToFile( Const FileName:String;
                                             IncludeData:Boolean);
begin
  case CBNativeFormat.ItemIndex of
    0: SaveChartToFile(TCustomChart(ExportPanel),FileName,IncludeData,False);
    1: SaveChartToFile(TCustomChart(ExportPanel),FileName,IncludeData,True);
    2: SaveChartToXMLFile(TCustomChart(ExportPanel),FileName,IncludeData);
  end;
end;

Procedure TTeeExportForm.PrepareOnShow;
begin
  if ExportPanel is TCustomAxisPanel then
  begin
    FillSeriesItems(CBSeries.Items,TCustomAxisPanel(ExportPanel).SeriesList);

    CBSeries.Items.Insert(0,TeeMsg_All);
    CBSeries.ItemIndex:=0;
  end
  else
  begin
    CBNativeData.Visible:=False;
    TabData.TabVisible:=False;
  end;
end;

Function TTeeExportForm.CreateNativeStream:TStream;
begin
  if ExportPanel is TCustomChart then
  begin
    result:=TMemoryStream.Create;

    case CBNativeFormat.ItemIndex of
      0: SaveChartToStream(TCustomChart(ExportPanel),result,
                           CBNativeData.Checked,False);
      1: SaveChartToStream(TCustomChart(ExportPanel),result,
                           CBNativeData.Checked,True);
      2: SaveChartToXMLStream(TCustomChart(ExportPanel),result,
                              CBNativeData.Checked);
    end;
  end
  else
    result:=inherited CreateNativeStream;
end;

{$IFNDEF CLX}
{$IFNDEF LCL}
procedure TTeeExportForm.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(Parent) then
     Parent.UpdateControlState;
end;
{$ENDIF}
{$ENDIF}

end.
