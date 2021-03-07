unit ufrmGRABBER_WINDOW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DSPack,unGLOBALS, DirectShow9,DSUtil, StdCtrls, GR32_Filters,GR32_Image,
  ImgList, ComCtrls, ToolWin, ExtDlgs, ExtCtrls;

type
  TfrmGRABBER_WINDOW = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ImageList1: TImageList;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    dlgOPPict: TOpenPictureDialog;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    VideoWindow: TVideoWindow;
    Filter: TFilter;
    FilterGraph: TFilterGraph;
    SampleGrabber: TSampleGrabber;
    Image1: TImage;
    SavePictureDialog1: TSavePictureDialog;
    procedure StartCapturing;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
  private
    { Private declarations }
  public
        Kaynak:String;
    { Public declarations }
  end;

var
  frmGRABBER_WINDOW: TfrmGRABBER_WINDOW;

implementation

uses ufrmYukleme_Fisi, ufrmArac, ufrmSofor,JPeg,unDataMod;

{$R *.dfm}

procedure TfrmGRABBER_WINDOW.StartCapturing;
var
    SysDev: TSysDevEnum;
    i: Integer;
    DeviceFound:Boolean;
begin
     DeviceFound := False;
     SysDev:= TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
     if SysDev.CountFilters > 0 then
     begin
       for i := 0 to SysDev.CountFilters - 1 do
       begin
         if glb_CapturingSource = SysDev.Filters[i].FriendlyName then
         begin
           DeviceFound := True;
           Break;
         end;
       end;
     end else
     begin
        Application.MessageBox('Can not Find any device to capture from!','Error',MB_ICONERROR);
        exit;
     end;
     if not DeviceFound then
     begin
        Application.MessageBox('The device you chose is not listed in the Video Input Device Category, Please choose another device at Settings module or Plug your Device and resart your machine','Error',MB_ICONERROR);
        exit;
     end;
     FilterGraph.ClearGraph;
     FilterGraph.Active := false;
     Filter.BaseFilter.Moniker := SysDev.GetMoniker(i);
     FilterGraph.Active := true;
     with FilterGraph as ICaptureGraphBuilder2 do
       RenderStream(@PIN_CATEGORY_PREVIEW, nil, Filter as IBaseFilter, SampleGrabber as IBaseFilter, VideoWindow as IbaseFilter);
     FilterGraph.Play;
end;

procedure TfrmGRABBER_WINDOW.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     FilterGraph.Stop;
     FilterGraph.Active := False;
   //  Action := caFree;
end;

procedure TfrmGRABBER_WINDOW.ToolButton1Click(Sender: TObject);
begin
     StartCapturing;
end;

procedure TfrmGRABBER_WINDOW.ToolButton4Click(Sender: TObject);
var
  TempBM:TBitmap;
begin
     if not FilterGraph.Active then
     begin
       Application.MessageBox('Not Capturing right now!, Start Capturing before Get Image','Error',MB_ICONERROR);
       Exit;
     end;
     TempBM := TBitmap.Create;
     SampleGrabber.GetBitmap(TempBM);
     //Image.Bitmap.Assign(TempBM);
     Image1.picture.Bitmap.Assign(TempBM);
     TempBM.Free;
end;

procedure TfrmGRABBER_WINDOW.ToolButton6Click(Sender: TObject);
var
  jpg: TJPEGImage;
  Dosya_Ad:String;
begin
     { dlgOPPict.Title := 'Open Bitmap File';
     if dlgOPPict.Execute then
     begin
       Image.Bitmap.LoadFromFile(dlgOPPict.FileName);
     end;}

    //frmYukleme_Fisi.IB_Image1.Picture.Assign(Image.Bitmap);
    //frmYukleme_Fisi.IB_Image1.Picture.Bitmap.Assign(Image.Bitmap);

    jpg := TJPEGImage.Create;
    jpg.assign(Image1.Picture.Graphic);

    if Kaynak='Komisyon' then
    begin
         //frmYukleme_Fisi.IB_Image1.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
         //frmYukleme_Fisi.IB_Image1.Picture.Assign(Image1.Picture);
         //frmYukleme_Fisi.qry_Komisyon.FieldByName('RESIM').Assign(Image1.Picture.Bitmap);
         //frmYukleme_Fisi.qry_Komisyon.FieldByName('RESIM').LoadFromFile(glb_WINDOWS_DIR+'\tempx.jpg');
         Dosya_Ad:= glb_IMAGE_DIR+'\'+ 'Kom'+Inttostr(frmYukleme_Fisi.qry_Komisyon.FieldByName('Id').AsInteger)+'.Jpg';
         jpg.SaveToFile(Dosya_Ad);
         frmYukleme_Fisi.qry_Komisyon.FieldByName('RESIM').AsString:=Dosya_Ad;
         frmYukleme_Fisi.qry_KomisyonAfterScroll(frmYukleme_Fisi.qry_Komisyon);
    end;

    //frmYukleme_Fisi.qry_Komisyon.FieldByName('RESIM').

    if Kaynak='Arac' then
    begin
         //frmArac.qryArac.FieldByName('RESIM').Assign(Image1.Picture.Bitmap);
         //frmArac.qryArac.FieldByName('RESIM').LoadFromFile(glb_WINDOWS_DIR+'\tempx.jpg');
         Dosya_Ad:= glb_IMAGE_DIR+'\'+ 'Arc'+frmArac.qryArac.FieldByName('ARAC_KOD').AsString+'.Jpg';
         jpg.SaveToFile(Dosya_Ad);
         frmArac.qryArac.FieldByName('RESIM').AsString:=Dosya_Ad;
         frmArac.qryAracAfterScroll(frmArac.qryArac);
    end;

    if Kaynak='Sofor' then
    begin
         //frmSofor.qrySofor.FieldByName('RESIM').Assign(Image1.Picture.Bitmap);
         //frmSofor.qrySofor.FieldByName('RESIM').LoadFromFile(glb_WINDOWS_DIR+'\tempx.jpg');
         Dosya_Ad:= glb_IMAGE_DIR+'\'+ 'Sof'+frmSofor.qrySofor.FieldByName('SOFOR_KOD').AsString+'.Jpg';
         jpg.SaveToFile(Dosya_Ad);
         frmSofor.qrySofor.FieldByName('RESIM').AsString:=Dosya_Ad;
         frmSofor.qrySoforAfterScroll(frmSofor.qrySofor);
    end;

    jpg.Free;

end;

procedure TfrmGRABBER_WINDOW.ToolButton8Click(Sender: TObject);
Var
   Msg:Pchar;
begin
     //dlgOPPict.Title := 'Resmi Dosyaya Kaydet';
     if SavePictureDialog1.Execute then
     begin
         //Msg := Pchar('Kaydedilen Resim Dosyasý ' + dlgOPPict.FileName + ' . Eminmisiniz');
         //if Application.MessageBox(Msg,'Save File',MB_ICONQUESTION+MB_YESNO) = ID_YES then Image.Bitmap.SaveToFile(dlgOPPict.FileName);
         //if Application.MessageBox(Msg,'Dosya Kaydet',MB_ICONQUESTION+MB_YESNO) = ID_YES then
         Image1.Picture.Bitmap.SaveToFile(SavePictureDialog1.FileName);
     end;
end;

end.
