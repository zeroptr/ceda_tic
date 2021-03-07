unit ufrmDEVIRKAY;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, IB_Grid, IB_Components, StdCtrls, Buttons,
  ExtCtrls;

type
  TfrmDEVIRKAY = class(TForm)
    tcDEVIR: TTabControl;
    grdCARIDOV: TIB_Grid;
    Panel1: TPanel;
    btnAra: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    qryDEVIR: TIB_Query;
    dtsDEVIR: TIB_DataSource;
    dtDEVIRTAR: TDateTimePicker;
    grdDEVIR: TIB_Grid;
    Splitter1: TSplitter;
    qryCARIDOV: TIB_Query;
    dtsCARIDOV: TIB_DataSource;
    btnDOVHES: TButton;
    qryDOVKART: TIB_Query;
    dsqlCARI_DOV_INSERT: TIB_DSQL;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnAraClick(Sender: TObject);
    procedure dtsDEVIRStateChanged(Sender: TIB_DataSource;      ADataset: TIB_Dataset);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure tcDEVIRChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tcDEVIRChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure btnDOVHESClick(Sender: TObject);
    procedure qryDEVIRAfterScroll(IB_Dataset: TIB_Dataset);
    procedure qryDEVIRBeforePost(IB_Dataset: TIB_Dataset);
    procedure qryDEVIRBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure qryCARIDOVBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure qryCARIDOVBeforePost(IB_Dataset: TIB_Dataset);
////////////////////////////////////////////////////////////////////////////////
    function  Form_Open(Menu:Boolean):Boolean;
    function  DataSet_Open(Menu:Boolean):Boolean;
    procedure Cari_Open;
    procedure Urun_Open;
    procedure KASA_Open;
    procedure Proje_Open;
    procedure Plasiyer_Open;
    procedure Masraf_Open;
    procedure CARIDOV_YARAT;
    procedure Arac_Open;
    procedure Personel_Open;
    procedure Sofor_Open;

////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
  end;

  const cns_devir_kay = 19;

var
  frmDEVIRKAY: TfrmDEVIRKAY;

implementation

uses unDATAMOD, main, ufrmCariSDLG,DateUtils, ufrmUrunSDLG;

{$R *.dfm}

function TfrmDEVIRKAY.Form_Open(Menu:Boolean):Boolean;
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_devir_kay,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application, 'frmDEVIRKAY') then
    begin
      Application.CreateForm(TfrmDEVIRKAY,frmDEVIRKAY);
    end
    else
    begin
      Application.MessageBox('Devir kaydý giriþ modülü zaten açýk','Dikkat',MB_ICONINFORMATION);
      exit;
    end;
    with frmDEVIRKAY do
    begin
      prv_CanUpdate := true;
      prv_CanDelete := true;
      dtDEVIRTAR.Date := StartOfAYear(glb_CALISMA_YIL);
    end;
    Result := DataSet_Open(Menu);
  end;
end;

function TfrmDEVIRKAY.DataSet_Open(Menu:Boolean):Boolean;
begin
  frmDEVIRKAY.tcDEVIR.TabIndex := 0;
  Result := True;
  frmDEVIRKAY.Cari_Open;
end;

procedure TfrmDEVIRKAY.Cari_Open;
begin
  with qryDEVIR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT CARI_KOD, CARI_AD, DEVREDEN_BORC, DEVREDEN_ALACAK FROM CARI ORDER BY CARI_KOD');
    FieldByName('DEVREDEN_BORC').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK').DisplayFormat := glb_VPB_FIELD_PF;


    FieldByName('CARI_KOD').DisplayLabel:='Cari Kodu';
    FieldByName('CARI_AD').DisplayLabel:='Cari Adý';
    FieldByName('DEVREDEN_BORC').DisplayLabel:='Devreden Borc';
    FieldByName('DEVREDEN_ALACAK').DisplayLabel:='Devreden Alacak';

  end;

  with qryCARIDOV do
  begin
    FieldByName('DEVREDEN_BORC').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK').DisplayFormat := glb_DOV_FIELD_PF;
  end;

  grdDEVIR.FixedDataCols := 2;
  qryDEVIR.Active := True;
  grdDEVIR.Align := alTop;
  grdDEVIR.Height := Trunc(tcDEVIR.Height / 2);
  grdCARIDOV.Visible := True;
  qryCARIDOV.Active := True;
  btnDOVHES.Visible := True;
end;

procedure TfrmDEVIRKAY.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmDEVIRKAY.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  if dtsDEVIR.State = dssEDIT then
  begin
    Application.MessageBox('Üzerinde bulunduðunuz kaydý lütfen kaydediniz veyta iptal ediniz','Dikkat',MB_ICONHAND);
    CanClose := False;
  end;
end;

procedure TfrmDEVIRKAY.btnAraClick(Sender: TObject);
var
  KOD,AD,DKOD:String;
begin
  case tcDEVIR.TabIndex of
  0: //Cari
    begin
      if frmCariSDLG.Form_Open(False,KOD,AD,1) Then
      begin
         qryDEVIR.Locate('CARI_KOD',KOD,[lopCaseInsensitive]);
      end;
    end;
  1: //URUN
    begin
      if frmUrunSDLG.Form_Open(False,Kod,AD,True) then
      begin
        qryDEVIR.Locate('URUN_KOD',KOD,[lopCaseInsensitive]);
      end;
    end;
  2: //KASA
    begin
      if DataMod.LS_KASA(Kod,Ad,DKOD) then
      begin
        qryDEVIR.Locate('KASA_KOD',KOD,[lopCaseInsensitive]);
      end;
    end;
  3: //PROJE
    begin
      if DataMod.LS_Proje(KOD,AD,0) then
      begin
        qryDEVIR.Locate('PROJE_KOD',KOD,[lopCaseInsensitive]);
      end;
    end;
  4: //PLASIYER
    begin
      if DataMod.LS_Plasiyer(KOD,AD,0) then
      begin
        qryDEVIR.Locate('PLASIYER_KOD',KOD,[lopCaseInsensitive]);
      end;
    end;
  end;// case end;
end;

procedure TfrmDEVIRKAY.dtsDEVIRStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) Then
  begin
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
    btnAra.Enabled := False ;
  end
  else
  begin
    btnAra.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmDEVIRKAY.btnKaydetClick(Sender: TObject);
begin
  qryDEVIR.Post;
end;

procedure TfrmDEVIRKAY.btnIPTALClick(Sender: TObject);
begin
  qryDEVIR.Cancel;
end;

procedure TfrmDEVIRKAY.tcDEVIRChanging(Sender: TObject;  var AllowChange: Boolean);
begin
  if dtsDEVIR.State = dssEDIT then
  begin
    Application.MessageBox('Üzerinde bulunduðunuz kaydý kaydediniz!','Dikkat',MB_ICONHAND);
    AllowChange := False;
  end;
end;

procedure TfrmDEVIRKAY.Urun_Open;
begin
  qryCARIDOV.Active := False;
  with qryDEVIR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT URUN_KOD, URUN_AD,DOVKOD,OLCUBIRIM , DEV_BORC,DEV_BORC_VPB,DEV_MIK_BORC FROM URUN  ORDER BY URUN_KOD');
    FieldByName('DEV_BORC').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEV_BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEV_MIK_BORC').DisplayFormat := glb_VPB_FIELD_PF;



    FieldByName('URUN_KOD').DisplayLabel:='Ürün Kodu';
    FieldByName('URUN_AD').DisplayLabel:='Ürün Adý';
    FieldByName('DOVKOD').DisplayLabel:='Döviz Kodu';
    FieldByName('OLCUBIRIM').DisplayLabel:='Ölçü Birimi';


    FieldByName('DEV_BORC').DisplayLabel:='Devreden Borc';
    FieldByName('DEV_BORC_VPB').DisplayLabel:='Devreden Borc Vpb';
    FieldByName('DEV_MIK_BORC').DisplayLabel:='Devreden Miktar Borc';


  end;
  grdDEVIR.FixedDataCols := 4;
  qryDEVIR.Active := True;
  grdDEVIR.Align := alClient;
  grdCARIDOV.Visible := False;
  btnDOVHES.Visible := False;
end;


procedure TfrmDEVIRKAY.tcDEVIRChange(Sender: TObject);
begin
  case tcDEVIR.TabIndex of
  0: Cari_Open;
  1: Urun_Open;
  2: KASA_Open;
  3: Proje_Open;
  4: Plasiyer_Open;
  5: Masraf_Open;
  6: Arac_Open;
  7: Personel_Open;
  //8: Sofor_Open;
  end;
end;

procedure TfrmDEVIRKAY.Sofor_Open;
begin
  qryCARIDOV.Active := False;
  with qryDEVIR do
  begin
    Close;
    SQL.Clear;
//    SQL.Add('SELECT SOFOR_KOD, ADISOY, DOVKOD, DEVREDEN_BORC, DEVREDEN_ALACAK,DEVREDEN_BORC_VPB, DEVREDEN_ALACAK_VPB FROM PLASIYER  ORDER BY PLASIYER_KOD');
    SQL.Add('SELECT SOFOR_KOD, ADI_SOYADI, DEVREDEN_BORC, DEVREDEN_ALACAK FROM SOFOR  ORDER BY SOFOR_KOD');
    FieldByName('DEVREDEN_BORC').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK').DisplayFormat := glb_VPB_FIELD_PF;
//    FieldByName('DEVREDEN_BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
//    FieldByName('DEVREDEN_ALACAK_VPB').DisplayFormat := glb_VPB_FIELD_PF;


    FieldByName('SOFOR_KOD').DisplayLabel:='Söför Kodu';
    FieldByName('ADI_SOYADI').DisplayLabel:='Adý Soyadý';
//    FieldByName('DOVKOD').DisplayLabel:='Döviz Kodu';
    FieldByName('DEVREDEN_BORC').DisplayLabel:='Devreden Borc';
    FieldByName('DEVREDEN_ALACAK').DisplayLabel:='Devreden Alacak';
//    FieldByName('DEVREDEN_BORC_VPB').DisplayLabel:='Devreden Borc Vpb';
//    FieldByName('DEVREDEN_ALACAK_VPB').DisplayLabel:='Devreden Alacak Vpb';

  end;
  grdDEVIR.FixedDataCols := 2;
  qryDEVIR.Active := True;
  grdDEVIR.Align := alClient;
  grdCARIDOV.Visible := False;
  btnDOVHES.Visible := False;
end;

procedure TfrmDEVIRKAY.Personel_Open;
begin
  qryCARIDOV.Active := False;
  with qryDEVIR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PERSONEL_KOD, ADI_SOYADI,  DEVREDEN_BORC, DEVREDEN_ALACAK FROM PERSONEL  ORDER BY PERSONEL_KOD');
    FieldByName('DEVREDEN_BORC').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK').DisplayFormat := glb_VPB_FIELD_PF;
   // FieldByName('DEVREDEN_BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
   // FieldByName('DEVREDEN_ALACAK_VPB').DisplayFormat := glb_VPB_FIELD_PF;


    FieldByName('PERSONEL_KOD').DisplayLabel:='Personel Kodu';
    FieldByName('ADI_SOYADI').DisplayLabel:='Adý Soyadý';
    //FieldByName('DOVKOD').DisplayLabel:='Döviz Kodu';
    FieldByName('DEVREDEN_BORC').DisplayLabel:='Devreden Borc';
    FieldByName('DEVREDEN_ALACAK').DisplayLabel:='Devreden Alacak';
   // FieldByName('DEVREDEN_BORC_VPB').DisplayLabel:='Devreden Borc Vpb';
   // FieldByName('DEVREDEN_ALACAK_VPB').DisplayLabel:='Devreden Alacak Vpb';

  end;
  grdDEVIR.FixedDataCols := 2;
  qryDEVIR.Active := True;
  grdDEVIR.Align := alClient;
  grdCARIDOV.Visible := False;
  btnDOVHES.Visible := False;
end;

procedure TfrmDEVIRKAY.Arac_Open;
begin
  qryCARIDOV.Active := False;
  with qryDEVIR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ARAC_KOD, PLAKA,  DEVREDEN_BORC, DEVREDEN_ALACAK FROM ARAC  ORDER BY ARAC_KOD');
    FieldByName('DEVREDEN_BORC').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK').DisplayFormat := glb_VPB_FIELD_PF;
   // FieldByName('DEVREDEN_BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
   // FieldByName('DEVREDEN_ALACAK_VPB').DisplayFormat := glb_VPB_FIELD_PF;


    FieldByName('ARAC_KOD').DisplayLabel:='Araç Kodu';
    FieldByName('PLAKA').DisplayLabel:='Plaka';
    //FieldByName('DOVKOD').DisplayLabel:='Döviz Kodu';
    FieldByName('DEVREDEN_BORC').DisplayLabel:='Devreden Borc';
    FieldByName('DEVREDEN_ALACAK').DisplayLabel:='Devreden Alacak';
   // FieldByName('DEVREDEN_BORC_VPB').DisplayLabel:='Devreden Borc Vpb';
  //  FieldByName('DEVREDEN_ALACAK_VPB').DisplayLabel:='Devreden Alacak Vpb';

  end;
  grdDEVIR.FixedDataCols := 2;
  qryDEVIR.Active := True;
  grdDEVIR.Align := alClient;
  grdCARIDOV.Visible := False;
  btnDOVHES.Visible := False;
end;


procedure TfrmDEVIRKAY.KASA_Open;
begin
  qryCARIDOV.Active := False;
  with qryDEVIR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT KASA_KOD, ACIKLAMA, DOVKOD, DEVREDEN_BORC, DEVREDEN_ALACAK,DEVREDEN_BORC_VPB, DEVREDEN_ALACAK_VPB FROM KASA ORDER BY KASA_KOD' );
    FieldByName('DEVREDEN_BORC').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK_VPB').DisplayFormat := glb_VPB_FIELD_PF;


    FieldByName('KASA_KOD').DisplayLabel:='Kasa Kodu';
    FieldByName('ACIKLAMA').DisplayLabel:='Açýklama';
    FieldByName('DOVKOD').DisplayLabel:='Döviz Kodu';
    FieldByName('DEVREDEN_BORC').DisplayLabel:='Devreden Borc';
    FieldByName('DEVREDEN_ALACAK').DisplayLabel:='Devreden Alacak';
    FieldByName('DEVREDEN_BORC_VPB').DisplayLabel:='Devreden Borc Vpb';
    FieldByName('DEVREDEN_ALACAK_VPB').DisplayLabel:='Devreden Alacak Vpb';


  end;
  grdDEVIR.FixedDataCols := 3;
  qryDEVIR.Active := True;
  grdDEVIR.Align := alClient;
  grdCARIDOV.Visible := False;
  btnDOVHES.Visible := False;
end;

procedure TfrmDEVIRKAY.Proje_Open;
begin
  qryCARIDOV.Active := False;
  with qryDEVIR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PROJE_KOD, PROJE_AD, DOVKOD, DEVREDEN_BORC, DEVREDEN_ALACAK,DEVREDEN_BORC_VPB, DEVREDEN_ALACAK_VPB FROM PROJE  ORDER BY PROJE_KOD');
    FieldByName('DEVREDEN_BORC').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK_VPB').DisplayFormat := glb_VPB_FIELD_PF;


    FieldByName('PROJE_KOD').DisplayLabel:='Proje Kodu';
    FieldByName('PROJE_AD').DisplayLabel:='Proje Adý';
    FieldByName('DOVKOD').DisplayLabel:='Döviz Kodu';
    FieldByName('DEVREDEN_BORC').DisplayLabel:='Devreden Borc';
    FieldByName('DEVREDEN_ALACAK').DisplayLabel:='Devreden Alacak';
    FieldByName('DEVREDEN_BORC_VPB').DisplayLabel:='Devreden Borc Vpb';
    FieldByName('DEVREDEN_ALACAK_VPB').DisplayLabel:='Devreden Alacak Vpb';


  end;
  grdDEVIR.FixedDataCols := 3;
  qryDEVIR.Active := True;
  grdDEVIR.Align := alClient;
  grdCARIDOV.Visible := False;
  btnDOVHES.Visible := False;
end;

procedure TfrmDEVIRKAY.Plasiyer_Open;
begin
  qryCARIDOV.Active := False;
  with qryDEVIR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PLASIYER_KOD, ADISOY, DOVKOD, DEVREDEN_BORC, DEVREDEN_ALACAK,DEVREDEN_BORC_VPB, DEVREDEN_ALACAK_VPB FROM PLASIYER  ORDER BY PLASIYER_KOD');
    FieldByName('DEVREDEN_BORC').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK_VPB').DisplayFormat := glb_VPB_FIELD_PF;


    FieldByName('PLASIYER_KOD').DisplayLabel:='Plasiyer Kodu';
    FieldByName('ADISOY').DisplayLabel:='Adý Soyadý';
    FieldByName('DOVKOD').DisplayLabel:='Döviz Kodu';
    FieldByName('DEVREDEN_BORC').DisplayLabel:='Devreden Borc';
    FieldByName('DEVREDEN_ALACAK').DisplayLabel:='Devreden Alacak';
    FieldByName('DEVREDEN_BORC_VPB').DisplayLabel:='Devreden Borc Vpb';
    FieldByName('DEVREDEN_ALACAK_VPB').DisplayLabel:='Devreden Alacak Vpb';

  end;
  grdDEVIR.FixedDataCols := 3;
  qryDEVIR.Active := True;
  grdDEVIR.Align := alClient;
  grdCARIDOV.Visible := False;
  btnDOVHES.Visible := False;
end;

procedure TfrmDEVIRKAY.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key Of
  VK_F6:
    begin
      if tcDEVIR.TabIndex = 4 then tcDEVIR.TabIndex := 0
      else tcDEVIR.TabIndex := tcDEVIR.TabIndex + 1;
      tcDEVIRChange(Self);
    end;
  end;
end;

procedure TfrmDEVIRKAY.btnDOVHESClick(Sender: TObject);
var
  DEGER:Currency;
begin
  qryCARIDOV.Open;
  if Application.MessageBox('Dikkat tüm kayýtlar için belirtilen tarih için hesaplama yapacaktýr emin misiniz ?','Dikkat',MB_ICONQUESTION + MB_YESNO) = ID_NO then Exit;
  qryDEVIR.First;
  while not qryDEVIR.Eof do
  begin
    if qryCARIDOV.RecordCount = 0 then CARIDOV_YARAT;
    while not qryCARIDOV.Eof do
    begin
      if qryDEVIR.FieldByName('DEVREDEN_BORC').AsCurrency <> 0 then
      begin
        qryCARIDOV.Edit;
        // hata denetimi özellikle yapýlmýyor
        DataMod.KurluDonustur(dtDEVIRTAR.Date
                              ,glb_DEFCUR
                              ,1
                              ,qryCARIDOV.FieldByName('DOVKOD').AsString
                              ,qryDEVIR.FieldByName('DEVREDEN_BORC').AsCurrency
                              ,glb_SATISKUR
                              ,True
                              ,DEGER);
        qryCARIDOV.FieldByName('DEVREDEN_BORC').AsCurrency := DEGER;
        if DEGER = 0 then
        begin
          //Application.MessageBox('SACMALADIM','Dikkat',MB_ICONHAND);
        end;
        qryCARIDOV.Post;
      end;
      if qryDEVIR.FieldByName('DEVREDEN_ALACAK').AsCurrency <> 0 then
      begin
        qryCARIDOV.Edit;
        DataMod.KurluDonustur(dtDEVIRTAR.Date
                              ,glb_DEFCUR
                              ,1
                              ,qryCARIDOV.FieldByName('DOVKOD').AsString
                              ,qryDEVIR.FieldByName('DEVREDEN_ALACAK').AsCurrency
                              ,glb_SATISKUR
                              ,True
                              ,DEGER);

        qryCARIDOV.FieldByName('DEVREDEN_ALACAK').AsCurrency := DEGER;
        if DEGER = 0 then
        begin
          //Application.MessageBox('SACMALADIM','Dikkat',MB_ICONHAND);
        end;
        qryCARIDOV.Post;
      end;
      qryCARIDOV.Next;
    end;
    qryDEVIR.Next;
  end;
  qryCARIDOV.Close;
  Application.MessageBox('Ýþlem tamamlandý','Dikkat',MB_ICONINFORMATION);
end;

procedure TfrmDEVIRKAY.CARIDOV_YARAT;
begin
  qryDOVKART.First;
  while not qryDOVKART.Eof do
  begin
    with dsqlCARI_DOV_INSERT do
    begin
      ParamByName('PRM_CARI_KOD').AsString := qryDEVIR.FieldByName('CARI_KOD').AsString;
      ParamByName('PRM_DOVKOD').AsString := qryDOVKART.FieldByName('DOVKOD').AsString;


      Execute;
    end;
    qryDOVKART.Next;
  end;
end;

procedure TfrmDEVIRKAY.qryDEVIRAfterScroll(IB_Dataset: TIB_Dataset);
begin
  if tcDEVIR.TabIndex = 0 then
  begin
    qryCARIDOV.Close;
    qryCARIDOV.ParamByName('PRM_CARI_KOD').AsString := qryDEVIR.FieldByName('CARI_KOD').AsString;
    qryCARIDOV.Open;
  end;
end;

procedure TfrmDEVIRKAY.qryDEVIRBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmDEVIRKAY.qryDEVIRBeforeDelete(IB_Dataset: TIB_Dataset);
begin
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmDEVIRKAY.qryCARIDOVBeforeDelete(IB_Dataset: TIB_Dataset);
begin
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmDEVIRKAY.qryCARIDOVBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmDEVIRKAY.Masraf_Open;
begin
  qryCARIDOV.Active := False;
  with qryDEVIR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT MASRAF_KOD, ADI,  DEVREDEN_BORC, DEVREDEN_ALACAK FROM MASRAF');
    FieldByName('DEVREDEN_BORC').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DEVREDEN_ALACAK').DisplayFormat := glb_VPB_FIELD_PF;

    FieldByName('MASRAF_KOD').DisplayLabel:='Masraf Kodu';
    FieldByName('ADI').DisplayLabel:='Adý';
    FieldByName('DEVREDEN_BORC').DisplayLabel:='Devreden Borc';
    FieldByName('DEVREDEN_ALACAK').DisplayLabel:='Devreden Alacak';

  end;
  grdDEVIR.FixedDataCols := 3;
  qryDEVIR.Active := True;
  grdDEVIR.Align := alClient;
  grdCARIDOV.Visible := False;
  btnDOVHES.Visible := False;
end;

end.
