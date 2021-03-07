unit ufrmSube;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_NavigationBar, IB_UpdateBar, ExtCtrls, IB_Components, StdCtrls,
  IB_Controls, Mask, Buttons, Grids, IB_Grid,IB_Session;

type
  Tfrm_Sube = class(TForm)
    Panel2: TPanel;
    qry_Sube: TIB_Query;
    dts_Sube: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit8: TIB_Edit;
    IB_CheckBox1: TIB_CheckBox;
    IB_Edit9: TIB_Edit;
    edt_Sirket: TIB_Edit;
    btnExit: TBitBtn;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Grid1: TIB_Grid;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    btnDuzenle: TButton;
    function Form_Open(Menu:Boolean):Integer;
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnExitClick(Sender: TObject);
    procedure qry_SubeBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure IB_Edit2Enter(Sender: TObject);
    procedure IB_Edit2Exit(Sender: TObject);
    procedure edt_SirketEnter(Sender: TObject);
    procedure edt_SirketExit(Sender: TObject);
    procedure IB_Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit9KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit4KeyPress(Sender: TObject; var Key: Char);
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure qry_SubeBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure Buton_Ayarla(tip : byte);
    procedure FormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnDuzenleClick(Sender: TObject);
    procedure qry_SubeAfterPost(IB_Dataset: TIB_Dataset);
    procedure qry_SubeBeforeScroll(IB_Dataset: TIB_Dataset);
    function HarfCevir(Kelime:String):String;
    procedure qry_SubeAfterDelete(IB_Dataset: TIB_Dataset);
    procedure qry_SubeAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
  public
    { Public declarations }
  end;

var
  frm_Sube: Tfrm_Sube;

implementation
uses unDataMod,unFunc;
{$R *.DFM}

{ Tfrm_Sube }

function Tfrm_Sube.Form_Open(Menu: Boolean): Integer;
begin
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Application.CreateForm(Tfrm_Sube, frm_Sube);
  frm_Sube.qry_Sube.ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  frm_Sube.qry_Sube.Active := True;
  DataMod.Form_Comp_Color(frm_Sube);
  frm_Sube.ShowModal;
  frm_Sube.qry_Sube.Active := False;
  frm_Sube.Release;
end;


procedure Tfrm_Sube.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure Tfrm_Sube.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
  if key = #27 then
  begin
    if btnExit.Enabled then btnExitClick(Self);
  end;
end;

{procedure Tfrm_Sube.edt_SirketButtonClick(Sender: TObject);
var
  Sirket_IDD:Integer;
begin
 Sirket_IDD:=DataMod.LS_Sirket();
 if (Sirket_IDD<>0) then
   begin
     qry_Sube.FieldByName('SIRKET_ID').AsInteger := Sirket_IDD ;
     qry_Sube.FieldByName('SIRKET_AD').AsString := DataMod.Sube_ID_To_Ad(qry_Sube.FieldByName('SIRKET_ID').AsInteger);
   end
   else
   begin
     Application.MessageBox('Þirket seçmeden þube tanýmlayamazsýnýz','Dikkat',MB_ICONWARNING);
     edt_Sirket.SetFocus;
   end;
end;}

procedure Tfrm_Sube.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Sube.qry_SubeBeforeDelete(IB_Dataset: TIB_Dataset);
begin
 if not Form_Before_Delete then Abort;
end;

procedure Tfrm_Sube.IB_Edit2Enter(Sender: TObject);
begin
   ActiveControl.Brush.Color := glb_Art_Alan_Renk;
   my_Active_Comp:=ActiveControl;
end;

procedure Tfrm_Sube.IB_Edit2Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure Tfrm_Sube.edt_SirketEnter(Sender: TObject);
begin
  edt_Sirket.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Sube.edt_SirketExit(Sender: TObject);
begin
   edt_Sirket.Color := clWindow;
end;
procedure Tfrm_Sube.IB_Edit7KeyPress(Sender: TObject; var Key: Char);
begin
  if isDigit(Key)<>True then Key := #0;
end;

procedure Tfrm_Sube.IB_Edit8KeyPress(Sender: TObject; var Key: Char);
begin
  if isDigit(Key)<>True then Key := #0;
end;

procedure Tfrm_Sube.IB_Edit6KeyPress(Sender: TObject; var Key: Char);
begin
  if isDigit(Key)<>True then Key := #0;
end;

procedure Tfrm_Sube.IB_Edit9KeyPress(Sender: TObject; var Key: Char);
begin
  if isDigit(Key)<>True then Key := #0;
end;

procedure Tfrm_Sube.IB_Edit5KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure Tfrm_Sube.IB_Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

function Tfrm_Sube.Form_Before_Delete: Boolean;
begin
  Result := True;
end;

function Tfrm_Sube.Form_Before_Post: Boolean;
begin
  Result := False;
  if qry_Sube.FieldByName('SUBE_ID').AsInteger <= 0 then
  begin
    Application.MessageBox('Þube numarasý sýfýrdan küçük ya da eþit olamaz.Lütfen kontrol ediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if Trim(qry_Sube.FieldByName('ADI').AsString) = '' then
  begin
    Application.MessageBox('Lütfen þube adýný kontrol ediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if (qry_Sube.FieldByName('ADI').AsString = 'HEPSÝ') then
  begin
    Application.MessageBox('Program içerisinden bu isimde bir þube tanýmlayamazsýnýz.Lütfen gerekli deðiþikliði yapýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure Tfrm_Sube.qry_SubeBeforePost(IB_Dataset: TIB_Dataset);
var
  qryKontrol : TIB_Query;
begin
  if not Form_Before_Post then
  begin
    Abort;
  end;

  DataMod.CreateQuery(qryKontrol,nil,False,DataMod.dbaANA);

  with qryKontrol do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) AS KAYITSAY FROM SUBE WHERE ADI='+SQL_Katar(HarfCevir(IB_Dataset.FieldByName('ADI').AsString)));
    Active := True;
  end;

  if qryKontrol.State in [dssInsert] then
  begin
    if qryKontrol.FieldByName('KAYITSAY').AsInteger <> 0 then
    begin
      Application.MessageBox('Ayný þubeyi tekrar kayýt edemezsiniz.Lütfen adýný deðiþtiriniz ve küçük harf kullanmayýnýz.','Dikkat',MB_ICONWARNING);
      Abort;
    end;
  end;

  if IB_Dataset.FieldByName('VARSAYILAN').AsInteger = 1 then
  begin
    with qryKontrol do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE SUBE SET VARSAYILAN = 0');
      Execute;
    end;
  end;
end;

procedure Tfrm_Sube.btnYeniClick(Sender: TObject);
begin
  if qry_Sube.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Lütfen yaptýðýnýz iþlemi kaydedin yada iptal edin.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    qry_Sube.Append;
    Buton_Ayarla(1);
  end;
end;

procedure Tfrm_Sube.Buton_Ayarla(tip: byte);
begin
  case tip of
  1://yeni
    begin
      btnYeni.Enabled := False;
      btnDuzenle.Enabled := False;
      btnSil.Enabled := False;
      btnKaydet.Enabled := True;
      btnIPTAL.Enabled := True;
    end;
  2://iptal
    begin
      btnIPTAL.Enabled := False;
      btnKaydet.Enabled := False;
      if qry_Sube.RecordCount = 0 then
      begin
         btnDuzenle.Enabled := False;
         btnSil.Enabled := False;
      end
      else
      begin
         btnDuzenle.Enabled := True;
         btnSil.Enabled := True;
      end;
      btnYeni.Enabled := True;
    end;
  3://kaydet
    begin
      btnKaydet.Enabled := False;
      btnIPTAL.Enabled := False;
      btnYeni.Enabled := True;
      btnDuzenle.Enabled := True;
      btnSil.Enabled := True;
    end;
  4://sil
    begin
      if qry_Sube.RecordCount = 0 then
      begin
        btnSil.Enabled := False;
      end
      else
      begin
        btnSil.Enabled := True;
      end;
    end;
  5://duzenle
    begin
      btnDuzenle.Enabled := False;
      btnKaydet.Enabled := True;
      btnIPTAL.Enabled := True;
      btnSil.Enabled := False;
      btnYeni.Enabled := False;
    end;
  end;//end case
end;

procedure Tfrm_Sube.FormShow(Sender: TObject);
begin
  Buton_Ayarla(3);
end;

procedure Tfrm_Sube.btnKaydetClick(Sender: TObject);
begin
  qry_Sube.Post;
  qry_Sube.RefreshAll;
  Buton_Ayarla(3);  
end;

procedure Tfrm_Sube.btnIPTALClick(Sender: TObject);
begin
  if Application.MessageBox('Ýptal etmek istediðinizden emin misiniz?','Dikkat',MB_ICONWARNING+MB_YESNO)=ID_YES then
  begin
    qry_Sube.Cancel;
    Buton_Ayarla(2);
  end;
end;

procedure Tfrm_Sube.btnSilClick(Sender: TObject);
begin
  if qry_Sube.FieldByName('VARSAYILAN').AsInteger = 1 then
  begin
    Application.MessageBox('Varsayýlan olarak seçilen þubeyi silemezsiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý silmek istediðinizden emin misiniz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=ID_YES then
  begin
    qry_Sube.Delete;
    Buton_Ayarla(4);
  end;
end;

procedure Tfrm_Sube.btnDuzenleClick(Sender: TObject);
begin
  if qry_Sube.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Þu anda zaten düzenleme pozisyonundasýnýz.Lütfen yaptýðýnýz iþlemi kontrol ediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    qry_Sube.Edit;
    Buton_Ayarla(5);
  end;
end;

procedure Tfrm_Sube.qry_SubeAfterPost(IB_Dataset: TIB_Dataset);
var
  qryUpdate : TIB_Query;
begin
  try
    DataMod.CreateQuery(qryUpdate,nil,False,DataMod.dbaMain);
    if IB_Dataset.FieldByName('VARSAYILAN').AsInteger = 1 then
    begin
      with qryUpdate do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('UPDATE PARAMETERS SET DEGER ='+SQL_Katar(IB_Dataset.FieldByName('SUBE_ID').AsString)+' WHERE MODUL_ID = 0 AND PARAM_NAME='+SQL_Katar('SUBE_KOD'));
        Execute;
      end;
    end;
    DataMod.SubeADIDYukle;
//****************************************************************************//
    if DataMod.GETPARAM(16,'FAT_SERI',IB_Dataset.FieldByName('SUBE_ID').AsSmallint) = '' then
    begin
      with qryUpdate do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('INSERT INTO PARAMETERS (SUBE_ID,MODUL_ID,PARAM_NAME,DEGER,PARAM_ACK,KODLAMA) VALUES ('+IB_Dataset.FieldByName('SUBE_ID').AsString+',16,'+SQL_Katar('FAT_SERI')+','+SQL_Katar('')+','+SQL_Katar('')+',0)');
        Execute;
      end;
    end;
//****************************************************************************//
    if DataMod.GETPARAM(18,'IRS_SERI',IB_Dataset.FieldByName('SUBE_ID').AsSmallint) = '' then
    begin
      with qryUpdate do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('INSERT INTO PARAMETERS (SUBE_ID,MODUL_ID,PARAM_NAME,DEGER,PARAM_ACK,KODLAMA) VALUES ('+IB_Dataset.FieldByName('SUBE_ID').AsString+',18,'+SQL_Katar('IRS_SERI')+','+SQL_Katar('')+','+SQL_Katar('')+',0)');
        Execute;
      end;
    end;
//****************************************************************************//
    //try
    //except
    //on E : Exception do
    //ShowMessage(E.ClassName+' class isimli hata oluþtu.Hata Mesajý : '+E.Message);
    //ShowMessage('Hata Mesajý : '+E.Message);
    //Application.MessageBox(PChar('Hata Mesajý : '+chr(13)+E.Message),'Dikkat',MB_ICONERROR);
    //end;
  finally
    DataMod.ReleaseQuery(qryUpdate);
  end;
end;

procedure Tfrm_Sube.qry_SubeBeforeScroll(IB_Dataset: TIB_Dataset);
begin
  if IB_Dataset.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Lütfen yaptýðýnýz deðiþiklikleri kaydediniz yada iptal ediniz.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

function Tfrm_Sube.HarfCevir(Kelime: String):String;
var
  uzunluk : integer;
  i : integer;
  tmp_str : string;
begin
  Result := '';
  uzunluk := Length(Kelime);
  for i := 1 to uzunluk do
  begin
    tmp_str := tmp_str + toUpper(Kelime[i]);
  end;
  Result := tmp_str;
end;

procedure Tfrm_Sube.qry_SubeAfterDelete(IB_Dataset: TIB_Dataset);
begin
  DataMod.SubeADIDYukle;
end;

procedure Tfrm_Sube.qry_SubeAfterInsert(IB_Dataset: TIB_Dataset);
begin
  IB_Dataset.FieldByName('SIRKET_ID').AsInteger := glb_SIRKET_ID;
end;

procedure Tfrm_Sube.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  qryKontrol : TIB_Query;
begin
  if qry_Sube.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Lütfen yaptýðýnýz deðiþiklikleri kaydedin yada iptal edin.','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end;

  DataMod.CreateQuery(qryKontrol,nil,False,DataMod.dbaAna);

  {with qryKontrol do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) AS KAYIT_SAY FROM SUBE WHERE VARSAYILAN = 1');
    Active := True;
  end;

  if qryKontrol.FieldByName('KAYIT_SAY').AsInteger = 0 then
  begin
    Application.MessageBox('Mutlaka bir tane þubeyi varsayýlan olarak belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end;
  }
end;

procedure Tfrm_Sube.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //showmessage(inttostr(Key));
  if Shift = [ssCtrl] then
  begin
    case Key of
    83: //s kaydet
      begin
        if btnKAYDET.Enabled Then btnKAYDETClick(Self);
      end; //83 end
    80: //p iptal
      begin
        if btnIptal.Enabled Then btnIptalClick(Self);
      end;
    46: // del delete
      begin
        if btnSIL.Enabled Then btnSILClick(self);
      end;
    68: //d duzenle
      begin
        if btnDuzenle.Enabled Then btnDuzenleClick(Self);
      end; //68 end
    end; // case end;
  end//Shift = [ssCtrl] then end
  else
  if Shift = [] then
  begin
    case Key of
    45: //ins kaydet
       begin
         if btnYeni.Enabled then btnYeniClick(Self);
       end;
    end;//acase end
  end; ///if Shift = [] then ENd
end;

end.
