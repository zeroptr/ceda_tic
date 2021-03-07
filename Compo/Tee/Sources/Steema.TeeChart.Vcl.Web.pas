unit Steema.TeeChart.Vcl.Web;

interface

uses
  System.Web.UI, System.Web.UI.WebControls,
  System.ComponentModel,
  System.ComponentModel.Design,
  System.Web.UI.Design,
  System.IO,
  System.Text,
  System.Drawing,
  System.Drawing.Design,
  System.Runtime.Serialization.Formatters.Binary,
  System.Runtime.Serialization.Formatters,
  System.Resources,
  System.Collections,
  Microsoft.Win32,
  //Support for Mouse events
  //postback
  System.Collections.Specialized,
  System.Diagnostics,
  Chart,
  DBChart,
  DBEditCh;

type
  WebChart=class;

  WebChartDesigner=class(System.Web.UI.Design.ControlDesigner)
  strict private
    procedure AddVerbs;
    procedure aboutEvent(sender:System.object; e:System.EventArgs);
    procedure clearEvent(sender:System.object; e:System.EventArgs);
    procedure editorEvent(sender:System.object; e:System.EventArgs);
    procedure exportEvent(sender:System.object; e:System.EventArgs);
    procedure importEvent(sender:System.object; e:System.EventArgs);
    procedure optionsEvent(sender:System.object; e:System.EventArgs);
    procedure previewEvent(sender:System.object; e:System.EventArgs);
    procedure supportEvent(sender:System.object; e:System.EventArgs);
    procedure UpdateConfig;
  public
    constructor Create;
    function GetDesignTimeHtml:String; override;
  end;

  /// <summary>
  /// Summary description for WebChart
  /// </summary>
  [Serializable, Designer(typeof(WebChartDesigner)),
   DefaultProperty('Chart'),
   ToolboxData('<{0}:WebChart runat=server></{0}:WebChart>'),
   ToolboxBitmap(typeof(WebChart),'Images.WebChart.bmp')
   //,LicenseProviderAttribute(typeof(TeeLicenseProvider))
  ]
  WebChart = class(System.Web.UI.WebControls.WebControl,
                   IComponent, INamingContainer, IPostBackEventHandler, IPostBackDataHandler)
  strict private
    FChart : TDBChart;
    FConfig : String;

    procedure SetChart(const Value: TDBChart);
  private
    procedure CreateChart;
    function CreateDesignPictureFile:String;
    procedure CreatePictureFile(writer:HtmlTextWriter);
    function GetBase64(mstr:Stream):String;
    function InternalSaveViewState(value:TCustomChart):System.object;
  strict protected
    procedure Render(Output: HtmlTextWriter); override;
  public
    constructor Create;
    function LoadPostData(postDataKey:String; postCollection:NameValueCollection):Boolean;
    procedure RaisePostBackEvent(eventArgument:String);
    procedure RaisePostDataChangedEvent;
  published
    //PersistenceMode(PersistenceMode.Attribute)]
    property Config:String read FConfig write FConfig;

    property Chart:TDBChart read FChart write SetChart;
  end;

implementation

uses
  TeeConst, TeeProCo, EditChar, TeeAbout, TeExport, TeePrevi,
  TeeDesignOptions;

[assembly: TagPrefix('Steema.TeeChart.Vcl.Web', 'tchart')]

const
  TeeMsg_Clear = 'Clear';
  TeeMsg_ImportChart = 'Import Chart...';
  TeeMsg_OnlineSupport = 'Online Support...';

constructor WebChartDesigner.Create;
begin
  inherited;
  AddVerbs;
end;

procedure WebChartDesigner.AddVerbs;
begin
  // DesignTimeOptions.InitLanguage(true,true);
  Verbs.Add(DesignerVerb.Create(TeeMsg_About,aboutEvent));
  Verbs.Add(DesignerVerb.Create(TeeMsg_Edit, editorEvent));
  Verbs.Add(DesignerVerb.Create(TeeMsg_Clear, clearEvent));
  Verbs.Add(DesignerVerb.Create(TeeMsg_ExportChart,exportEvent));
  Verbs.Add(DesignerVerb.Create(TeeMsg_ImportChart, importEvent));
  Verbs.Add(DesignerVerb.Create(TeeMsg_PrintPreview, previewEvent));
  Verbs.Add(DesignerVerb.Create(TeeMsg_Options, optionsEvent));
  Verbs.Add(DesignerVerb.Create(TeeMsg_OnlineSupport, supportEvent));
end;

procedure WebChartDesigner.editorEvent(sender:System.object; e:System.EventArgs);
var
  ctl : WebChart;
begin
  ctl:=WebChart(Component);
  //ctl.iChart.parent:=ctl;
  EditChart(nil,ctl.Chart);
  IsDirty:=true;
  UpdateConfig;
  UpdateDesignTimeHtml;
end;

procedure WebChartDesigner.aboutEvent(sender:System.object; e:System.EventArgs);
begin
  TeeShowAboutBox('');
end;

procedure WebChartDesigner.exportEvent(sender:System.object; e:System.EventArgs);
begin
  TeeExport(nil,WebChart(Component).Chart);
end;

procedure WebChartDesigner.clearEvent(sender:System.object; e:System.EventArgs);
var
  ctl : WebChart;
begin
  ctl:=WebChart(Component);
  ctl.Chart.Free;
  ctl.CreateChart;
  //ctl.iChart.parent := ctl;
  IsDirty:=True;
  UpdateConfig;
  UpdateDesignTimeHtml;
end;

procedure WebChartDesigner.importEvent(sender:System.object; e:System.EventArgs);
var
  ctl : WebChart;
begin
  ctl:=WebChart(Component);
  //Editors.ImportEditor.ShowModal(ctl.Chart);
  UpdateConfig;
  UpdateDesignTimeHtml;
end;

procedure WebChartDesigner.previewEvent(sender:System.object; e:System.EventArgs);
begin
  TeePreview(nil,WebChart(Component).Chart);
  RaiseComponentChanged(nil,nil,nil);
end;

procedure WebChartDesigner.optionsEvent(sender:System.object; e:System.EventArgs);
begin
  with TOptionsForm.Create(WebChart(Component).Chart) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure WebChartDesigner.supportEvent(sender:System.object; e:System.EventArgs);
begin
  System.Diagnostics.Process.Start('http://www.teechart.net/support/index.php');
end;

/// <summary>
/// Internal use. Creates the Designtime Chart view.
/// </summary>
/// <returns>html string used to call Chart at designtime</returns>
function WebChartDesigner.GetDesignTimeHtml:String;
begin
  result:=WebChart(Component).CreateDesignPictureFile;
end;

/// <summary>
/// Internal use. Updates the inplace WebForm HTML as result of Editor changes
/// </summary>
procedure WebChartDesigner.UpdateConfig;
var
  ctl : WebChart;
  oldVal : String;
  properties:PropertyDescriptorCollection;
  modProperty:PropertyDescriptor;
begin
  ctl := WebChart(Component);
  oldVal:='';
  ctl.Config:=ctl.GetBase64((MemoryStream(ctl.InternalSaveViewState(ctl.Chart))));
  IsDirty:=true;
  properties:=TypeDescriptor.GetProperties(ctl);
  modProperty:=properties.Find('Config', true);
  RaiseComponentChanged (MemberDescriptor(modProperty), oldVal, ctl.Config);
end;

type
  WebChartEditor=class(UITypeEditor)
  public
    function EditValue(context:System.ComponentModel.ITypeDescriptorContext; provider:System.IServiceProvider; value:System.object):System.object; override;
    function GetEditStyle(context:System.ComponentModel.ITypeDescriptorContext):System.Drawing.Design.UITypeEditorEditStyle; override;
  end;

function WebChartEditor.GetEditStyle(context:System.ComponentModel.ITypeDescriptorContext):System.Drawing.Design.UITypeEditorEditStyle;
begin
  result:=UITypeEditorEditStyle.Modal;
end;

/// <summary>
/// Internal use. Calls Editor.
/// </summary>
function WebChartEditor.EditValue(context:System.ComponentModel.ITypeDescriptorContext; provider:System.IServiceProvider; value:System.Object):System.Object;
begin
  EditChart(nil,TCustomChart(value));
  if Assigned(context) then
     context.OnComponentChanged;
  result:=value;
end;

/// <summary>
/// Define a public parameterless constructor needed by web controls.
/// </summary>
constructor WebChart.Create;
begin
  inherited;
  CreateChart;
end;

procedure WebChart.CreateChart;
begin
  FChart:=TDBChart.Create(nil);
end;

/// <summary>
/// Postback event support. Internal use.
/// </summary>
function WebChart.LoadPostData(postDataKey:String; postCollection:NameValueCollection):Boolean;
var
  listEnumerator : IEnumerator;
  nameKey : String;
  tmpStr : String;
begin
  listEnumerator := postCollection.GetEnumerator;
  nameKey:=postDataKey;

  while nameKey.IndexOf(':') <> -1 do
    nameKey:=nameKey.Substring(nameKey.IndexOf(':')+1);

  while listEnumerator.MoveNext do
  begin
    tmpStr:=listEnumerator.Current.ToString;
    if tmpStr.LastIndexOf('.') <> -1 then
       tmpStr:=tmpStr.Substring(0,tmpStr.LastIndexOf('.'));

    if tmpStr=nameKey then
    begin
      isObjectevent:=true;
      clickedX:=Convert.ToInt32(postCollection[nameKey+'.x']);
      clickedY:=Convert.ToInt32(postCollection[nameKey+'.y']);

      //Page.RegisterRequiresRaiseEvent(this);
      break;
    end;
  end;

  result:=False;
end;

/// <summary>
/// Internal use. Saves Chart.
/// </summary>
function WebChart.InternalSaveViewState(value:TCustomChart):System.object;
var
  formatter : BinaryFormatter;
  stream : System.IO.MemoryStream;
begin
  formatter:=BinaryFormatter.Create;
  formatter.AssemblyFormat:=FormatterAssemblyStyle.Simple;
  stream:=System.IO.MemoryStream.Create;
  formatter.Serialize(stream,value);
  result:=stream;
end;

/// <summary>
/// Postback event support. Internal use.
/// </summary>
procedure WebChart.RaisePostDataChangedEvent;
begin
  //Not used.
end;

// Method of IPostBackEventHandler that raises change events.
/// <summary>
/// Postback event support. Internal use.
/// </summary>
procedure WebChart.RaisePostBackEvent(eventArgument:String);
begin
  //Not used.
end;

procedure WebChart.Render(Output: HtmlTextWriter);
begin
  CreatePictureFile(Output);
  if AutoPostback then
     Page.GetPostBackClientEvent(Self, '');
end;

procedure WebChart.SetChart(const Value: TDBChart);
begin
  FChart.Assign(Value);
end;

/// <summary>
/// Writes Designtime Chart
/// </summary>
function WebChart.CreateDesignPictureFile:String;
var
  format : Export.ImageExportFormat;
  fileName : String;
begin
  format:=Chart.Export.Image.FromFormat(pictureFormat);

  format.Width:=Width.Value;
  format.Height:=Height.Value;

  fileName:='';

  if Site <> nil then
  begin
    fileName:=ID+'.'+format.FileExtension;
    format.Save(Path.GetTempPath()+'\\'+fileName);
    result:='<IMG SRC=\'''+Path.GetTempPath()+'\\'+fileName+'\>';
  end
  else result:='';
end;

/// <summary>
/// Write Runtime Chart
/// </summary>
procedure WebChart.CreatePictureFile(writer:HtmlTextWriter);
var
  format : Export.ImageExportFormat;
  timeStamp, fileRoot, fileName, tmpFile,
  tmpStr, imgStr: String;
  chartImg : MemoryStream;
begin
  Chart.parent:=Self;

  format:=iChart.Export.Image.FromFormat(pictureFormat);

  format.Width:=(int)Width.Value;
  format.Height:=(int)Height.Value;

  timeStamp:=DateTime.Now.ToOADate().ToString();

  fileRoot:=ID.ToString()+Context.Request.UserHostAddress.ToString().Replace('.','')
                  +timeStamp.Replace(',','').Replace('/','').Replace(':','').Replace(' ','').Replace('.','');

  fileName:=fileRoot+'.'+format.FileExtension;

  if isObjectevent then
  begin
    //Create sized bitmap for Graphics g when pre-event checking
    Bitmap b:=Chart.Bitmap(format.Width,format.Height);

    MouseEventArgs mEvents:=new MouseEventArgs(System.Windows.Forms.MouseButtons.Left,1,clickedX,clickedY,0);
    Chart.DoMouseDown(false,mEvents);
    isObjectevent:=False;
    b:=nil;
  end;

  tmpFile=designPath+'\\'+tmpFolder+'\\'+fileName;

  if (tempChart=TempChartStyle.Session) and (Context.Session=nil) then
     tempChart:=TempChartStyle.File;   // <-- force "File" if EnableSessionState is false.

  if tempChart=TempChartStyle.Session then
  begin
    chartImg:=MemoryStream.Create;
    format.Save(chartImg);
    Context.Session.Add(fileRoot,chartImg);
  end
  else
  begin
    MakeShareFolder;
    format.Save(tmpFile);
  end;

  tmpStr:='';

  //Take whole as Attributes
  for key in Attributes.Keys do
     tmpStr:=tmpStr+key+'="'+Attributes[key];

  //used for setting event - not required, optional future use
  //tmpStr=tmpStr+" onclick=javascript:" +Page.GetPostBackEventReference(this);

  imgStr:='';
  if AutoPostback then
     imgStr='<input type="image" ';
  else
     imgStr='<IMG ';

  if tempChart==TempChartStyle.Session
  begin
    writer.Write(imgStr+'SRC=\''+iGetChartFile+'?Chart='+fileRoot+'\' '
					+'id=\''+ID.ToString()+"\" "+"Name=\""+ID.ToString()+"\" "+tmpStr+"; height:"+format.Height+GetUnitType(Height)+"; width:"+format.Width+GetUnitType(Width)+'\'>');
  end
  else
  begin
    writer.Write(imgStr+'SRC="'+shareURL+'/'+tmpFolder+'/'+fileName+'" '
					+'id="'+ID.ToString()+'" '+'Name="'+ID.ToString()+'" '+tmpStr+'; height:'+format.Height+GetUnitType(Height)+'; width:'+format.Width+GetUnitType(Width)+'">');
  end;
end;

function WebChart.GetUnitType(value:Unit):String;
begin
  case value.Type of
    UnitType.Pixel: result:='px';
    UnitType.Percentage: result:='%';
  else
    result:='px';
  end;
end;

function WebChart.GetBase64(mstr:Stream):String;
var
  binaryData : Array of Byte;
  bytesRead : Integer;
begin
  result:='';

  mstr.Position:=0;
  try
    SetLength(binaryData,mstr.Length);
    bytesRead:=mstr.Read(binaryData, 0,mstr.Length);
    mstr.Flush;
    mstr.Close;
  except
    on Exp:System.Exception do
    begin
      System.Console.WriteLine('{0}', exp.Message);
      result:=nil;
    end;
  end;

  result:=Convert.ToBase64String(binaryData,0,binaryData.Length);
  binaryData:=nil;
end;

end.
