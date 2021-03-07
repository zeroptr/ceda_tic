{$INCLUDE ..\directive.inc}
unit ufrmCariKart;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Db, DBTables, ExtCtrls, StdCtrls, Mask, DBCtrls, Buttons,
  Grids,  IB_Components, IB_Controls, IB_UpdateBar, IB_Grid,
  IB_StoredProc;

type
  TfrmCariKart = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet1: TTabSheet;
    Bevel1: TBevel;
    TabSheet3: TTabSheet;
    btnEkle: TButton;
    btnGSil: TButton;
    Panel1: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    dtsCari: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit9: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit8: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    IB_Edit14: TIB_Edit;
    IB_Edit15: TIB_Edit;
    txtUlke: TIB_Edit;
    IB_Currency1: TIB_Currency;
    IB_Currency2: TIB_Currency;
    IB_Currency3: TIB_Currency;
    IB_Currency4: TIB_Currency;
    IB_Memo1: TIB_Memo;
    qryBut_Cari_Grup: TIB_Query;
    dtsBut_Cari_Grup: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    chkYurtDisi: TIB_CheckBox;
    IB_Grid2: TIB_Grid;
    qryCari_Grup_Uye: TIB_Query;
    dtsCari_Grup_Uye: TIB_DataSource;
    btnVarSay: TButton;
    qryCari: TIB_Query;
    cboTip: TIB_ComboBox;
    chkMuhtelif: TIB_CheckBox;
    btnAra: TBitBtn;
    btnGrupTanim: TBitBtn;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    btnCikis: TBitBtn;
    StatusBar1: TStatusBar;
    chkDovizli: TIB_CheckBox;
    cboDOVKOD: TIB_ComboBox;
    qrySevk_Adres: TIB_Query;
    dtsSevk_Adres: TIB_DataSource;
    TabSheet4: TTabSheet;
    Panel2: TPanel;
    IB_Edit16: TIB_Edit;
    IB_Edit17: TIB_Edit;
    btn_Te_Sil: TButton;
    btn_Te_Iptal: TButton;
    btn_Te_Kaydet: TButton;
    btn_Te_Yeni: TButton;
    IB_Edit18: TIB_Edit;
    IB_Grid3: TIB_Grid;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    IB_Currency5: TIB_Currency;
    IB_Currency6: TIB_Currency;
    Button1: TButton;
    Button2: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnEkleClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnGSilClick(Sender: TObject);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure qryCariAfterInsert(IB_Dataset: TIB_Dataset);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure btnVarSayClick(Sender: TObject);
    procedure dtsCariStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure chkClick(Sender: TObject);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure cboTipChange(Sender: TObject);
    procedure cboTipEnter(Sender: TObject);
    procedure cboTipExit(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure qryCariBeforeCancel(IB_Dataset: TIB_Dataset);
    procedure qryCariAfterPost(IB_Dataset: TIB_Dataset);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;CARI_KOD:String;Islem:SmallInt);
    procedure DataSet_Open(CARI_KOD:String;ISLEM:SmallInt);
    procedure DataSet_Grup_Open;
    function CariNo(CARI_SAYAC:INTEGER):String;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure qryCariBeforePost(IB_Dataset: TIB_Dataset);
    procedure FormShow(Sender: TObject);
    procedure cboDOVKODEnter(Sender: TObject);
    procedure cboDOVKODExit(Sender: TObject);
    procedure btn_Te_YeniClick(Sender: TObject);
    procedure btn_Te_KaydetClick(Sender: TObject);
    procedure btn_Te_IptalClick(Sender: TObject);
    procedure btn_Te_SilClick(Sender: TObject);
    procedure dtsSevk_AdresStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure qrySevk_AdresAfterInsert(IB_Dataset: TIB_Dataset);
    procedure IB_Edit18KeyPress(Sender: TObject; var Key: Char);
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
    PRV_SAYAC_NO:Integer;
    procedure Geri_AL;
  public
    { Public declarations }
  end;

  const cns_cari_kart = 2;
  
var
  frmCariKart: TfrmCariKart;

implementation

uses unDataMod,unFunc, main,ufrmCariGroup,ufrmCariSDLG,Math,unLogger;

{$R *.DFM}

procedure TfrmCariKart.Form_Open(Menu:Boolean;Cari_Kod:String;Islem:SmallInt);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_cari_kart,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((Islem = 0) and (local_can_update = False)) then
    begin
      Application.MessageBox('Bu modülde yeni cari tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
//****************************************************************************//
  if not MainForm.FindChildFrm(Application,'frmCariKart') then
  begin
    Application.CreateForm(TfrmCariKart, frmCariKart);
    with frmCariKart do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      with qryCari do
      begin
        FieldByName('KREDILMT').DisplayFormat := glb_VPB_FIELD_PF;
        FieldByName('RISK').DisplayFormat := glb_VPB_FIELD_PF;
        FieldByName('BORC').DisplayFormat := glb_VPB_FIELD_PF;
        FieldByName('ALACAK').DisplayFormat := glb_VPB_FIELD_PF;
        FieldByName('DEVREDEN_BORC').DisplayFormat := glb_VPB_FIELD_PF;
        FieldByName('DEVREDEN_ALACAK').DisplayFormat := glb_VPB_FIELD_PF;

      end;
    end;
  end
  else
  begin
    Application.MessageBox('Cari kart formu açýk.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  frmCariKart.DataSet_Open(CARI_KOD,ISLEM);
//****************************************************************************//
end;


procedure TfrmCariKart.DataSet_Open(CARI_KOD:String;ISLEM:SmallInt);
begin
// Islem = 0 Yeni Kayýt
// Islem = 1 Edit
  if ((ISLEM = 0) and (frmCariKart.prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni cari tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  with frmCariKart.qryCari do
  begin
    Active := False;
    ParamByName('PRM_CARI_KOD').AsString := CARI_KOD ;
    Active := True;
  end;

  case Islem of
  0:// Yeni Kayýtta Yapýlacak iþlemler
    begin
      frmCariKart.qryCari.Insert;
    end;
  1:// Edit iþleminde Yapýlacak iþlemler
    begin
      if frmCariKart.cboTip.ItemIndex = 2 then
      begin
        frmCariKart.PageControl1.Pages[2].TabVisible := False;
        frmCariKart.PageControl1.Pages[3].TabVisible := False;
      end
      else
      begin
        frmCariKart.PageControl1.Pages[2].TabVisible := True;
        frmCariKart.PageControl1.Pages[3].TabVisible := True;
      end;
      if frmCariKart.qryCari.RecordCount <> 0 then
      begin
        frmCariKart.StatusBar1.Panels[0].Text := frmCariKart.qryCari.FieldByName('CARI_KOD').AsString;
        frmCariKart.StatusBar1.Panels[1].Text := frmCariKart.qryCari.FieldByName('CARI_AD').AsString;

        DataSet_Grup_Open;
        frmCariKart.StatusBar1.Panels[2].Text := frmCariKart.qryCari_Grup_Uye.FieldByName('CGADI').AsString;

       // case Sign(frmCariKart.qryCari.FieldByName('BORC').AsCurrency - frmCariKart.qryCari.FieldByName('ALACAK').AsCurrency) of
        case Sign((frmCariKart.qryCari.FieldByName('BORC').AsCurrency+frmCariKart.qryCari.FieldByName('DEVREDEN_BORC').AsCurrency) - (frmCariKart.qryCari.FieldByName('ALACAK').AsCurrency+frmCariKart.qryCari.FieldByName('DEVREDEN_ALACAK').AsCurrency)) of
        0:
          begin
            with frmCariKart.StatusBar1 do
            begin
              Panels[4].Text := '';
              Panels[5].Text := '0';
            end;
          end;
        1:
          begin
            with frmCariKart.StatusBar1 do
            begin
              Panels[4].Text := BORC;
              Panels[5].Text := FormatFloat(glb_VPB_FIELD_PF,(frmCariKart.qryCari.FieldByName('BORC').AsCurrency+frmCariKart.qryCari.FieldByName('DEVREDEN_BORC').AsCurrency) - (frmCariKart.qryCari.FieldByName('ALACAK').AsCurrency+frmCariKart.qryCari.FieldByName('DEVREDEN_ALACAK').AsCurrency));
            end;
          end;
        -1:
          begin
            with frmCariKart.StatusBar1 do
            begin
              Panels[4].Text := ALACAK;
              Panels[5].Text := FormatFloat(glb_VPB_FIELD_PF,(frmCariKart.qryCari.FieldByName('ALACAK').AsCurrency+frmCariKart.qryCari.FieldByName('DEVREDEN_ALACAK').AsCurrency) - (frmCariKart.qryCari.FieldByName('BORC').AsCurrency+frmCariKart.qryCari.FieldByName('DEVREDEN_BORC').AsCurrency));
            end;
          end;
        end;//end case
      end;//end if frmCariKart.qryCari.RecordCount <> 0 then
    end;//end case 1
  end;//end case Islem of
end;

procedure TfrmCariKart.DataSet_Grup_Open;
begin
//****************************************************************************//
  with qryBut_Cari_Grup do
  begin
    Active := False;
    ParamByName('PRM_CARI_KOD').AsString := qryCari.FieldByName('CARI_KOD').AsString;
    Active := True;
  end;
//****************************************************************************//
  with qryCari_Grup_Uye do
  begin
    Active := False;
    ParamByName('PRM_CARI_KOD').Asstring := qryCari.FieldByName('CARI_KOD').AsString;
    Active := True;
  end;
//****************************************************************************//
end;

procedure TfrmCariKart.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmCariKart.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ActiveControl.Name <> 'IB_Memo1' then
  begin
    if key = #13 then
    begin
      key := #0;
      SelectNext(ActiveControl as tWinControl, True, True );
    end;
  end;
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
end;

procedure TfrmCariKart.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  case PageControl1.ActivePageIndex OF
  0://cari kart
    begin
      if qryCari.State in [dssInsert,dssEdit] then
      begin
        Application.MessageBox('Deðiþiklikleri Kaydediniz Veya Ýptal Ediniz','DÝKKAT',MB_ICONINFORMATION);
        CanClose:= False;
      end;
    end;
  1://note
    begin
      if (qryCari.State in [dssInsert,dssEdit]) Then qryCari.Post;
    end;
  2://gruplama
    begin
      if (qryCari_Grup_Uye.RecordCount<>0) Then
      begin
        with DataMod.qryGENEL do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('SELECT COUNT(*) AS VARSAYCOUNT FROM CARI_GRUP_UYE WHERE CARI_KOD='+SQL_Katar(qryCari.FieldByName('CARI_KOD').AsString)+' AND VARSAY=1');
          Active := True;
        end;
        if (DataMod.qryGENEL.FieldByName('VARSAYCOUNT').AsInteger = 0) then
        begin
          CanClose := False;
          Application.MessageBox('Cari Gruplarýndan en az birini varsayýlan olarak tanýmlamalýsýnýz.','Dikkat',MB_ICONWARNING);
        end
        else
        begin
          qryBut_Cari_Grup.Active := False;
          qryCari_Grup_Uye.Active := False;
        end;
      end;
    end;
  end;//end case
end;

procedure TfrmCariKart.btnEkleClick(Sender: TObject);
var
  qryExecuter,Qry:TIB_Query;
begin
  if qryBut_Cari_Grup.RecordCount <> 0 then
  begin
    DataMod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
    DataMod.CreateQuery(qry,Nil,False,DataMod.dbaMain);

    qry.Close;
    qry.SQL.Text:='Select Count(*) GELEN from CARI_GRUP_UYE where CARI_KOD=:CARI_KOD';
    qry.ParamByName('CARI_KOD').AsString:=QryCari.FieldByName('CARI_KOD').AsString;
    qry.Open;
    if qry.FieldByName('GELEN').AsInteger<=0 then
    begin

    qryExecuter.SQL.Add('INSERT INTO CARI_GRUP_UYE(CARI_GRUP_KOD,CARI_KOD,VARSAY) VALUES ('
                        + SQL_Katar(qryBut_Cari_Grup.FieldByName('CARI_GRUP_KOD').AsString)
                        +','+ SQL_Katar(qryCari.FieldByName('CARI_KOD').AsString) + ',1)');
    qryExecuter.Execute;

    end
    else
    begin
    qryExecuter.SQL.Add('INSERT INTO CARI_GRUP_UYE(CARI_GRUP_KOD,CARI_KOD,VARSAY) VALUES ('
                        + SQL_Katar(qryBut_Cari_Grup.FieldByName('CARI_GRUP_KOD').AsString)
                        +','+ SQL_Katar(qryCari.FieldByName('CARI_KOD').AsString) + ',0)');
    qryExecuter.Execute;
    end;

    dmLOGGER.Write2Log(0,0,0,0,1,qryExecuter.SQL.Text,'CARI_GRUP_UYE');
    DataSet_Grup_Open;
  end;

end;

procedure TfrmCariKart.btnGSilClick(Sender: TObject);
var
  qryExecuter:TIB_Query;
begin
  if qryCari_Grup_Uye.RecordCount<>0 Then
  begin
    DataMod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
    qryExecuter.SQL.Add('DELETE FROM CARI_GRUP_UYE WHERE CARI_KOD='+SQL_Katar(qryCari_Grup_Uye.FieldByName('CARI_KOD').AsString)
                      + ' AND CARI_GRUP_KOD = '+ SQL_Katar(qryCari_Grup_Uye.FieldByName('CARI_GRUP_KOD').AsString));
    qryExecuter.Execute;
    dmLOGGER.Write2Log(0,0,0,0,2,qryExecuter.SQL.Text,'CARI_GRUP_UYE');
    DataSet_Grup_Open;
  end;
end;

procedure TfrmCariKart.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmCariKart.qryCariAfterInsert(IB_Dataset: TIB_Dataset);
begin
  PRV_SAYAC_NO := DataMod.GET_SAYAC_NUM('CARIKART',True,True,0);
  with qryCari do
  begin
    FieldByName('CARI_SID').AsInteger := glb_SID;
    FieldByName('WEB_ADDR').AsString := 'http://';
    FieldByName('TIP').AsInteger := 1;
    FieldByName('CARI_KOD').AsString := CariNo(Int64(PRV_SAYAC_NO));
    FieldByName('YURTDISI').AsInteger := 0;
    FieldByName('ISLEMTIP').AsInteger := 0;
    FieldByName('MUHTELIF').AsSmallInt:=0;
    FieldByName('DOVIZLI').AsSmallInt:=0;
    FieldByName('DOVKOD').AsString := glb_DEFCUR;
    FieldByName('DEVREDEN_BORC').AsFloat:=0;
    FieldByName('DEVREDEN_ALACAK').AsFloat:=0;
  end;
  IB_Edit1.SetFocus;  
end;

procedure TfrmCariKart.PageControl1Change(Sender: TObject);
begin
  case PageControl1.ActivePage.TabIndex of
  0:
    begin
    //
    end;
  1:
    begin
    //
    end;
  2://cari gruplarý
    begin
      DataSet_Grup_Open;
    end;
  end;

  if PageControl1.ActivePage=TabSheet4 then
  begin
        with qrySevk_Adres do
        begin
          Active := False;
          ParamByName('CARI_KOD').AsString := qryCari.FieldByName('CARI_KOD').asString;
          ParamByName('CARI_SID').AsInteger := qryCari.FieldByName('CARI_SID').asInteger;
          Active := True;
        end;
  end;
end;

procedure TfrmCariKart.PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  case PageControl1.ActivePage.TabIndex of
  0:
    if qryCari.State in [dssInsert,dssEdit] then
    begin
      Application.MessageBox('Yaptýðýnýz deðiþiklikleri kaydediniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
    end
    else
    begin
      if ((qryCari.Eof) and (qryCari.Bof)) then
      begin
        Application.MessageBox('Cari Bilgisi olmadan bu alana geçemezsiniz.','Dikkat',MB_ICONWARNING);
        AllowChange := False;
      end;
    end;
  1://note
    begin
      if (qryCari.State in [dssInsert,dssEdit]) then qryCari.Post;
    end;
  2://cari gruplarý
    begin
      if (qryCari_Grup_Uye.RecordCount<>0) then
      begin
        with DataMod.qryGENEL do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('SELECT COUNT(*) AS VARSAYCOUNT FROM CARI_GRUP_UYE WHERE CARI_KOD='+SQL_Katar(qryCari.FieldByName('CARI_KOD').AsString)+' AND VARSAY=1');
          Active := True;
        end;
        if (DataMod.qryGENEL.FieldByName('VARSAYCOUNT').AsInteger=0) then
        begin
          AllowChange := False;
          Application.MessageBox('Ürün Gruplarýndan en az birini varsayýlan olarak tanýmlamalýsýnýz.','Dikkat',MB_ICONWARNING);
        end
        else
        begin
          qryBut_Cari_Grup.Active := False;
          qryCari_Grup_Uye.Active := False;
        end;
      end;//end if (qryCari_Grup_Uye.RecordCount<>0) then
    end;//end 2
  end;//end case

  if PageControl1.ActivePage=TabSheet4 then
  begin
    if qrySevk_Adres.State in [dssInsert,dssEdit] then
    begin
      Application.MessageBox('Yaptýðýnýz deðiþiklikleri kaydediniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
    end;
  end;
end;

procedure TfrmCariKart.btnVarSayClick(Sender: TObject);
var qryExecuter:TIB_Query;
begin
  DataMod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
  with qryExecuter do
  begin
    SQL.Add('UPDATE CARI_GRUP_UYE SET VARSAY = 0 WHERE CARI_KOD = '+SQL_Katar(qryCari_Grup_Uye.FieldByName('CARI_KOD').AsString));
    Execute;
    SQL.Clear;
    SQL.Add('UPDATE CARI_GRUP_UYE SET VARSAY = 1 WHERE CARI_KOD='+SQL_Katar(qryCari_Grup_Uye.FieldByName('CARI_KOD').AsString)
                       +' AND CARI_GRUP_KOD = '+SQL_Katar(qryCari_Grup_Uye.FieldByName('CARI_GRUP_KOD').AsString));
    Execute;
  end;
  dmLOGGER.Write2Log(0,0,0,0,1,qryExecuter.SQL.Text,'CARI_GRUP_UYE');
  DataSet_Grup_Open;
end;

procedure TfrmCariKart.dtsCariStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    btnSil.Enabled := False;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
  end
  else
  begin
    btnYeni.Enabled:=True;
    if not ((qryCari.Eof) And (qryCari.Bof)) then
    begin
      btnSil.Enabled := True;
      Btn_Onceki.Enabled := True;
      Btn_Sonraki.Enabled := True;
    end
    else
    begin
      btnSil.Enabled := False;
      Btn_Onceki.Enabled := False;
      Btn_Sonraki.Enabled := False;
    end;
    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmCariKart.chkClick(Sender: TObject);
begin
  if chkYurtDisi.Checked Then  txtULKE.Enabled := True else txtULKE.Enabled := False;
end;

function TfrmCariKart.CariNo(CARI_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(CARI_SAYAC,TRIM(DataMod.GetParam(cns_cari_kart ,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_cari_kart,'KOD_LENGTH',0)));
end;

procedure TfrmCariKart.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmCariKart.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmCariKart.cboTipChange(Sender: TObject);
begin
  if cboTip.ItemIndex = 2 then
  begin
    PageControl1.Pages[2].TabVisible := False;
    PageControl1.Pages[3].TabVisible := False;
  end
  else
  begin
    PageControl1.Pages[2].TabVisible := True;
    PageControl1.Pages[3].TabVisible := True;
  end;
end;

procedure TfrmCariKart.cboTipEnter(Sender: TObject);
begin
  cboTip.Color := glb_Art_Alan_Renk;
end;

procedure TfrmCariKart.cboTipExit(Sender: TObject);
begin
  cboTip.Color := clWindow;
end;

procedure TfrmCariKart.btnCikisClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCariKart.btnAraClick(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if frmCariSDLG.Form_Open (True,CARI_KOD,CARI_AD,1) then
  begin
    frmCariKart.DataSet_Open(CARI_KOD,1);
  end;
end;

procedure TfrmCariKart.btnYeniClick(Sender: TObject);
begin
  DataSet_Open('',0);
end;

procedure TfrmCariKart.BitBtn1Click(Sender: TObject);
begin
  frmCariGroup.Form_Open(False);
  DataSet_Grup_Open;
end;

procedure TfrmCariKart.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryCari.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('CARI,',0,0,0,0,1,'CARI');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmCariKart.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryCari.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('CARI,',0,0,0,0,2,'CARI');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmCariKart.btnIPTALClick(Sender: TObject);
begin
  qryCari.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;


procedure TfrmCariKart.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Shift = [ssCtrl,ssShift,ssAlt] then
       if key=65 then
       begin
        Button1.Visible:=True;
        Button2.Visible:=True;        
       end;
       
  if PageControl1.ActivePageIndex = 0 Then
  begin
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
      end;// case end;
    end//Shift = [ssCtrl] then end
    else
    if Shift = [] then
    begin
      case Key of
      45://ins kaydet
         begin
           if btnYeni.Enabled then btnYeniClick(Self);
         end;
      end;//acase end
    end; ///if Shift = [] then ENd
  end;
  case Key of
    VK_F6:PageControl1.SelectNextPage(True);
  end;
end;

procedure TfrmCariKart.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  DataMod.Form_Comp_Color(frmCariKart);
end;

procedure TfrmCariKart.qryCariBeforeCancel(IB_Dataset: TIB_Dataset);
begin
  if dtsCari.State = dssINSERT then
  begin
    DataMod.Add_Sayaclar_Nu('CARIKART',PRV_SAYAC_NO,0);
  end;
end;


function TfrmCariKart.Form_Before_Delete: Boolean;
var
  strMesaj:String;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if DataMod.Delete_Control('CARI',qryCari.FieldByName('CARI_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then Exit;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Exit;
  end;
  Result := True;
end;

function TfrmCariKart.Form_Before_Post: Boolean;
var
  FuncDeger:String;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  FuncDeger:=DataMod.Before_Post_Kontrol(qryCari,'CARI','CARI_KOD,CARI_AD','CARI_KOD,CARI_AD');
  if funcDeger<> '' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if qryCari.State in [dssInsert] then
  begin
    if qryCari.FieldByName('MUHTELIF').AsSmallint =1 Then
    begin
      with DataMod.qryGENEL do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT COUNT(CARI_KOD) AS MY_VALUE FROM CARI WHERE MUHTELIF=1');
        Active := True;
      end;
      if DataMod.qryGENEL.FieldByName('MY_VALUE').AsInteger<>0  then
      begin
        Application.MessageBox('Daha öncede muhtelif kaydý yapýlmýþ birden fazla muhtelif kayýt olamaz.','Dikkat',MB_ICONWARNING);
        Exit;
      end;
    end;
  end
  else
  if qryCari.State in [dssEdit] then
  begin
    if qryCari.FieldByName('MUHTELIF').OldAsString<>qryCari.FieldByName('MUHTELIF').AsString then
    begin
      if qryCari.FieldByName('MUHTELIF').AsSmallint =1 Then
      begin
        with DataMod.qryGENEL do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('SELECT COUNT(CARI_KOD) AS MY_VALUE FROM CARI WHERE MUHTELIF=1 AND CARI_KOD<>'+ SQL_Katar(qryCari.FieldByName('CARI_KOD').AsString));
          Active := True;
        end;
        if DataMod.qryGENEL.FieldByName('MY_VALUE').AsInteger<>0  then
        begin
          Application.MessageBox('Birden fazla muhtelif kayýt olamaz.','Dikkat',MB_ICONWARNING);
          Exit;
        end;
      end;
    end;
  end;
  ///muhtelif kontrolü sonu
  Result := True;
end;

procedure TfrmCariKart.qryCariAfterPost(IB_Dataset: TIB_Dataset);
begin
//  if not DataMod.Post_Update('CARI',qryCari.FieldByName('CARI_KOD').OldAsString,qryCari.FieldByName('CARI_KOD').AsString,Nil) then Abort;
end;

procedure TfrmCariKart.qryCariBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not DataMod.Post_Update('CARI',qryCari.FieldByName('CARI_KOD').OldAsString,qryCari.FieldByName('CARI_KOD').AsString,nil) then Abort;
end;

procedure TfrmCariKart.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmCariKart.cboDOVKODEnter(Sender: TObject);
begin
  (Sender as TIB_ComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCariKart.cboDOVKODExit(Sender: TObject);
begin
  (Sender as TIB_ComboBox).Color := clWindow;
end;

procedure TfrmCariKart.btn_Te_YeniClick(Sender: TObject);
begin
  qrySevk_Adres.Insert;
end;

procedure TfrmCariKart.btn_Te_KaydetClick(Sender: TObject);
var
  FuncDeger:String;
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  FuncDeger:=DataMod.Before_Post_Kontrol(qrySevk_Adres,'CARI_SEVKAD','CARI_SEVK_KOD','');
  if funcDeger<> '' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Exit;
  end;
  
  try
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qrySevk_Adres.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log ( 'CARI_SEVKAD,',0,0,0,0,1,'CARI_SEVKAD');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;

end;

procedure TfrmCariKart.btn_Te_IptalClick(Sender: TObject);
begin
  qrySevk_Adres.Cancel;
end;

procedure TfrmCariKart.btn_Te_SilClick(Sender: TObject);
var
  strMesaj:String;
begin

  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if DataMod.Delete_Control('CARI_SEVKAD',qrySevk_Adres.FieldByName('CARI_SEVK_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then Exit;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Exit;
  end;

  try
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
       qrySevk_Adres.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('CARI_SEVKAD,',0,0,0,0,2,'CARI_SEVKAD');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmCariKart.dtsSevk_AdresStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btn_Te_Yeni.Enabled:=False;
    btn_Te_Sil.Enabled := False;
    btn_Te_Kaydet.Enabled := True;
    btn_Te_IPTAL.Enabled := True;
  end
  else
  begin
    btn_Te_Yeni.Enabled:=True;
    if not ((ADataset.Eof) and (ADataset.Bof)) then
    begin
      btn_Te_Sil.Enabled := True
    end
    else
    begin
      btn_Te_Sil.Enabled := False;
    end;
    btn_Te_Kaydet.Enabled := False;
    btn_Te_IPTAL.Enabled := False;
  end;
end;

procedure TfrmCariKart.qrySevk_AdresAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qrySevk_Adres do
  begin
    FieldByName('CARI_SEVK_KOD').AsString := 'SEVK00'+Inttostr(qrySevk_Adres.Gen_ID('GEN_CARI_SEVKID',1));
                                         //SevkNo(Inttostr(qrySevk_Adres.Gen_ID('GEN_CARI_SEVKID',1));
    FieldByName('CARI_KOD').AsString := qryCari.FieldByName('CARI_KOD').AsString;
    FieldByName('CARI_SID').AsInteger := qryCari.FieldByName('CARI_SID').AsInteger;
  end;
  IB_Edit18.SetFocus;  
end;

procedure TfrmCariKart.IB_Edit18KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmCariKart.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 CARI_KOD FROM CARI WHERE CARI_KOD<:CARI_KOD ORDER BY CARI_KOD DESC';
     qryDeg1.ParamByName('CARI_KOD').AsString:=qryCari.FieldByName('CARI_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('CARI_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('CARI_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;

procedure TfrmCariKart.Geri_AL;
begin
     {qryCari_Grup_Uye.CancelUpdates;
     qryBut_Cari_Grup.CancelUpdates;
     qrySevk_Adres.CancelUpdates;
     qryCari.CancelUpdates;
     }
     if qryCari.State in [DssEdit,DssInsert] then qryCari.Cancel;
     qryCari_Grup_Uye.Close;
     qryBut_Cari_Grup.Close;
     qrySevk_Adres.Close;
     qryCari.Close;
end;

procedure TfrmCariKart.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 CARI_KOD FROM CARI WHERE CARI_KOD>:CARI_KOD ORDER BY CARI_KOD';
     qryDeg1.ParamByName('CARI_KOD').AsString:=qryCari.FieldByName('CARI_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('CARI_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('CARI_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;

procedure TfrmCariKart.Button1Click(Sender: TObject);
var
  qryCARI1,qryCARIHAR:TIB_Query;
  trnISLEM:TIB_Transaction;
  BORC_TOP,ALACAK_TOP:Currency;
begin
  try
    try
      DataMod.CreateTransaction(trnISLEM , tiCommitted,DataMod.dbaMain);
      trnISLEM.StartTransaction;
      DataMod.CreateQuery(qryCARI1,trnISLEM,True,DataMod.dbaMain);
      qryCARI1.SQL.Add('SELECT * FROM CARI WHERE CARI_KOD='+Sql_Katar(qryCari.FieldByName('CARI_KOD').AsString));
      qryCARI1.open;
      DataMod.CreateQuery(qryCARIHAR,trnISLEM,False,DataMod.dbaMain);
      While not qryCARI1.Eof do
      begin
        qryCARI1.Edit;
        BORC_TOP := 0; ALACAK_TOP := 0;
        qryCARIHAR.Close;
        qryCARIHAR.SQL.Clear;
        qryCARIHAR.SQL.Add('SELECT SUM(TUTAR_VPB) AS TOPLAM_VPB FROM CARIHAR WHERE CARIHAR.TIP = ' + SQL_Katar(BORC)+ ' AND CARI_KOD = '+ SQL_Katar(qryCARI1.FieldByName('CARI_KOD').AsString) +
                            ' AND CARIHAR.TARIH >= ' + SQL_Tarih(glb_DONEM_BAS) + ' AND CARIHAR.TARIH <= ' + SQL_Tarih(glb_DONEM_SON));
        qryCARIHAR.Open;
        qryCARI1.FieldByName('BORC').AsCurrency := qryCARIHAR.FieldByName('TOPLAM_VPB').AsCurrency;
        qryCARIHAR.Close;
        qryCARIHAR.SQL.Clear;
        qryCARIHAR.SQL.Add('SELECT SUM(TUTAR_VPB) AS TOPLAM_VPB FROM CARIHAR WHERE CARIHAR.TIP = ' + SQL_Katar(ALACAK)+ ' AND CARI_KOD = '+ SQL_Katar(qryCARI1.FieldByName('CARI_KOD').AsString) +
                            ' AND CARIHAR.TARIH >= ' + SQL_Tarih(glb_DONEM_BAS) + ' AND CARIHAR.TARIH <= ' + SQL_Tarih(glb_DONEM_SON));
        qryCARIHAR.Open;
        qryCARI1.FieldByName('ALACAK').AsCurrency := qryCARIHAR.FieldByName('TOPLAM_VPB').AsCurrency;
        qryCARI1.Post;
        qryCARI1.Next;
      end;
    except
      trnISLEM.Rollback;
      Raise;
    end;
  finally
    trnISLEM.Commit;
    DataMod.ReleaseQuery(qryCARI1);
    DataMod.ReleaseQuery(qryCARIHAR);
    DataMod.ReleaseTransaction(trnISLEM);
  end;
    Application.MessageBox('Ýþlem Tamamlandý','Dikkat',MB_ICONWARNING);
end;


procedure TfrmCariKart.Button2Click(Sender: TObject);
var qryCARI1,qryCARIHAR:TIB_Query;
    trnISLEM:TIB_Transaction; ISLEM_ID,ISLEM_SID,ISN:Integer;
    LIMIT_ASIMI:Boolean;
begin
  try
    try
      DataMod.CreateTransaction(trnISLEM , tiCommitted,DataMod.dbaMain);
      trnISLEM.StartTransaction;
      DataMod.CreateQuery(qryCARI1,trnISLEM,False,DataMod.dbaMain);
      qryCARI1.SQL.Add('UPDATE CARI SET BORC = 0 , ALACAK = 0, RISK = 0 WHERE CARI_KOD='+Sql_Katar(qryCari.FieldByName('CARI_KOD').AsString));
      qryCARI1.Execute;
      qryCARI1.SQL.Clear;
      qryCARI1.SQL.Add('UPDATE CARI_DOV SET BORC = 0 , ALACAK = 0, RISK = 0  WHERE CARI_KOD='+Sql_Katar(qryCari.FieldByName('CARI_KOD').AsString));
      qryCARI1.Execute;
      DataMod.CreateQuery(qryCARIHAR,trnISLEM,False,DataMod.dbaMain);
      qryCARIHAR.SQL.Add('SELECT * FROM CARIHAR WHERE CARIHAR.TARIH >= ' + SQL_Tarih(glb_DONEM_BAS) + ' AND CARIHAR.TARIH <= ' + SQL_Tarih(glb_DONEM_SON));


      qryCARIHAR.SQL.Add(' and CARI_KOD='+Sql_Katar(qryCari.FieldByName('CARI_KOD').AsString));
      qryCARIHAR.Open;


      While not qryCARIHAR.Eof do
      begin
        if not DataMod.CARI_BA_UPDATE(trnISLEM,
                                      qryCARIHAR.FieldByName('CARI_KOD').AsString,
                                      qryCARIHAR.FieldByName('DOV_BAZ_TAR').AsDate,
                                      qryCARIHAR.FieldByName('DOVKOD').AsString,
                                      qryCARIHAR.FieldByName('DOVKUR').AsCurrency,
                                      qryCARIHAR.FieldByName('TUTAR').AsCurrency,
                                      qryCARIHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                      qryCARIHAR.FieldByName('TIP').AsString[1],
                                      'TfrmBAKIM.CARI_BA_DUZELT_C_BA_AU:',
                                      LIMIT_ASIMI) then
        begin
          trnISLEM.Rollback;
          Exit;
        end;
        qryCARIHAR.Next;
      end;
      trnISLEM.Commit;
    except
      trnISLEM.Rollback;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryCARI1);
    DataMod.ReleaseQuery(qryCARIHAR);
    DataMod.ReleaseTransaction(trnISLEM);

  end;

end;

end.

