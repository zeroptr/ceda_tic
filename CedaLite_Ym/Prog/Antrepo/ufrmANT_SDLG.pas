unit ufrmANT_SDLG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, IB_Grid, IB_Components, Buttons,
  Menus;

type
  TfrmANT_SDLG = class(TForm)
    qryARA: TIB_Query;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    txtCARI_KOD: TLabeledEdit;
    btnCARI_LIST: TButton;
    Panel2: TPanel;
    dtsARA: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    cboCARI_AD: TComboBox;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    dtpIslemTar: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    txtKAP_ADET: TLabeledEdit;
    txtKILO: TLabeledEdit;
    txtTASIYICI: TLabeledEdit;
    cboBEYAN: TComboBox;
    txtBEYAN: TLabeledEdit;
    btn_Ara: TButton;
    cboESYA: TComboBox;
    txtDEF_SIRA_NO: TLabeledEdit;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    txtYAS1: TEdit;
    txtYAS2: TEdit;
    PopupMenu1: TPopupMenu;
    GiriFiiniGster1: TMenuItem;
    kFiiYarat1: TMenuItem;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    IB_Grid2: TIB_Grid;
    qryCIKIS: TIB_Query;
    dtsCIKIS: TIB_DataSource;
    PopupMenu2: TPopupMenu;
    mnuCikisFisAC: TMenuItem;
    Splitter1: TSplitter;
    procedure txtBEYANKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    Procedure FillTheCombos;
    function Form_Open(Menu:Boolean;var ANT_MAIN_ID:Integer;Var ANT_DETAIL_ID:Integer; Tip:Byte):Boolean;
    procedure btn_AraClick(Sender: TObject);
    procedure txtKAP_ADETKeyPress(Sender: TObject; var Key: Char);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnTAMAMClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCARI_LISTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GiriFiiniGster1Click(Sender: TObject);
    procedure kFiiYarat1Click(Sender: TObject);
    procedure qryARAAfterScroll(IB_Dataset: TIB_Dataset);
    procedure mnuCikisFisACClick(Sender: TObject);
    Procedure AssignMainSQL;
    procedure IB_Grid1DblClick(Sender: TObject);
  private
    { Private declarations }
    prv_TIP:Byte;
    prv_MAIN_SQL:String;
  public
    { Public declarations }
    Kontrol : Boolean;
  end;

var
  frmANT_SDLG: TfrmANT_SDLG;

implementation
uses unDATAMOD,unFUNC, ufrmCariSDLG, ufrmANT_GIRIS, ufrmANT_CIKIS;
{$R *.dfm}

function TfrmANT_SDLG.Form_Open(Menu:Boolean;var ANT_MAIN_ID:Integer;Var ANT_DETAIL_ID:Integer; Tip:Byte):Boolean;
// Tip
// 1 : Giriþ Kayýtlarý
// 2 : Çýkýþ Kayýtlarý
// 3 : Antrepoda ki Mallar
begin
  Application.CreateForm(TfrmANT_SDLG, frmANT_SDLG);
  with frmANT_SDLG do
  begin
    prv_TIP := TIP;
    AssignMainSQL;
    case  tip of
    1,2:begin
          FormStyle := fsNormal;
          Visible := False;
          Panel2.Visible := False;
          PopupMenu1.AutoPopup := False;
          Splitter1.Visible := False;
        end;
    3,4: begin
         // Panel1.Visible := False;
          WindowState := wsMaximized;
          if prv_TIP = 3 then
          begin
            with qryARA do
            begin
              Close;
              SQL.Add('WHERE ANT_MAIN.GIRCIK = ' + SQL_Katar(GIRIS) + ' AND ANT_DETAIL.KALAN_KAP <> 0');
              Open;
            end;
          end;
       end;
    end; //case  tip of
    Kontrol := False;
    prv_TIP := Tip;
    dtpIslemTar.Date := glb_DONEM_BAS;
    dtpIslemTar2.Date := Date;
    dtpIslemTar.Checked := False;
    dtpIslemTar2.Checked := False;
    if tip in [1,2] then
       ShowModal
    else
       Exit;

    if not Kontrol then
    begin
      ANT_MAIN_ID := 0;
      ANT_DETAIL_ID := 0;
      Result := False;
    end
    else
    begin
      ANT_MAIN_ID := qryARA.FieldByName('ANT_MAIN_ID').AsInteger;
      ANT_DETAIL_ID := qryARA.FieldByName('ANT_DETAIL_ID').AsInteger;
      Result:= True;
    end;
    qryARA.Close;
    Release;
  end;
end;

procedure TfrmANT_SDLG.GiriFiiniGster1Click(Sender: TObject);
begin
   if qryARA.RecordCount <> 0 then frmANT_GIRIS.Form_Open(False,qryARA.FieldByName('ANT_MAIN.ANT_MAIN_ID').AsInteger,glb_SID);
   Close;
end;

procedure TfrmANT_SDLG.IB_Grid1DblClick(Sender: TObject);
begin
   if prv_TIP in [1,2] then btnTAMAMClick(Self);
end;

procedure TfrmANT_SDLG.kFiiYarat1Click(Sender: TObject);
begin
   frmANT_CIKIS.Form_Open(True,0,glb_SID,qryARA.FieldByName('ANT_DETAIL_ID').AsInteger);
   Close;
end;

procedure TfrmANT_SDLG.mnuCikisFisACClick(Sender: TObject);
begin
   if qryCIKIS.RecordCount > 0 then
   begin
     frmANT_CIKIS.Form_Open(True,qryCIKIS.FieldByName('ANT_MAIN_ID').AsInteger,glb_SID,qryCIKIS.FieldByName('ANT_DETAIL_ID').AsInteger);
     Close;
   end;
end;

procedure TfrmANT_SDLG.qryARAAfterScroll(IB_Dataset: TIB_Dataset);
begin
  if Panel2.Visible then
  begin
    qryCIKIS.Close;
    qryCIKIS.ParamByName('PRM_ANT_DETAIL_ID').AsInteger := qryARA.FieldByName('ANT_DETAIL_ID').AsInteger;
    qryCIKIS.Open;
  end;
end;

procedure TfrmANT_SDLG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree;
end;

procedure TfrmANT_SDLG.FormCreate(Sender: TObject);
begin
  frmANT_SDLG.qryARA.FieldByName('KILO').DisplayFormat := glb_VPB_FIELD_PF;
  frmANT_SDLG.qryARA.FieldByName('KALAN_KILO').DisplayFormat := glb_VPB_FIELD_PF;
  frmANT_SDLG.qryCIKIS.FieldByName('CIK_KILO').DisplayFormat := glb_VPB_FIELD_PF;
  FillTheCombos;
end;

procedure TfrmANT_SDLG.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #27 then btnIPTALClick(Self);
   
end;

procedure TfrmANT_SDLG.txtBEYANKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmANT_SDLG.txtKAP_ADETKeyPress(Sender: TObject; var Key: Char);
begin
   if not isDigit(Key) then Key := #0;

end;

procedure TfrmANT_SDLG.btnCARI_LISTClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
    txtCARI_KOD.Text := Cari_KOD;
  end;
end;

procedure TfrmANT_SDLG.btnIPTALClick(Sender: TObject);
begin
  Kontrol := False;
  Close;
end;

procedure TfrmANT_SDLG.btnTAMAMClick(Sender: TObject);
begin
   if qryARA.RecordCount = 0 then
     Kontrol := False
   else
     Kontrol := True;
    Close;
end;

procedure TfrmANT_SDLG.btn_AraClick(Sender: TObject);
var MainSQL,WhereSQL:String;
    AA:TDate;
begin
  if  ((Length(Trim(txtYAS1.Text))<> 0) and (Length(Trim(txtYAS2.Text))<> 0)) then
  begin
    if (StrToIntDef(txtYAS1.Text,0) >  StrToIntDef(txtYAS2.Text,0)) then
    begin
      Application.MessageBox('Dikkat Yaþ 1, Yaþ 2 den büyük olamaz', 'Dikkat',MB_ICONINFORMATION);
      Exit;
    end;
  end;

  WhereSQL := '';

    case prv_TIP of
     1,4 : WhereSQL := ' WHERE ANT_MAIN.GIRCIK = ' + SQL_Katar(GIRIS);
     2 : WhereSQL := ' WHERE ANT_MAIN.GIRCIK = ' + SQL_Katar(CIKIS);
     3 : WhereSQL := ' WHERE ANT_MAIN.GIRCIK = ' + SQL_Katar(GIRIS) + ' AND ANT_DETAIL.KALAN_KAP <> 0';
    end;

    if Length(Trim(txtDEF_SIRA_NO.Text))<> 0  then
    begin
      WhereSQL := WhereSQL + ' AND ANT_MAIN.DEF_SIRA_NO = ' + txtDEF_SIRA_NO.Text;
      with qryARA do
      begin
        Close;
        SQL.Clear;
        sql.Add(prv_MAIN_SQL + WhereSQL);
        Open;
        Exit;
      end;
    end;

    if  ((Length(Trim(txtYAS1.Text))<> 0) and (Length(Trim(txtYAS2.Text))= 0)) Then
    begin
      WhereSQL := WhereSQL + ' AND TARIH = ' + SQL_Tarih(Date - StrToInt(txtYAS1.Text));
    end;

    if  ((Length(Trim(txtYAS1.Text)) = 0) and (Length(Trim(txtYAS2.Text))<> 0)) Then
    begin
      WhereSQL := WhereSQL + ' AND TARIH >= ' + SQL_Tarih(Date - StrToInt(txtYAS2.Text));
    end;

    if  ((Length(Trim(txtYAS1.Text)) <> 0) and (Length(Trim(txtYAS2.Text))<> 0)) Then
    begin
      WhereSQL := WhereSQL + ' AND TARIH >= ' + SQL_Tarih(Date - StrToInt(txtYAS2.Text)) + ' AND TARIH <= ' + SQL_Tarih(Date - StrToInt(txtYAS1.Text))
    end;

    if  ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=False)) Then
    begin
      WhereSQL := WhereSQL + ' And TARIH=' + SQL_Tarih(dtpIslemTar.Date);
    end;

    if ((dtpIslemTar.Checked=False) and (dtpIslemTar2.Checked=True)) Then
    begin
      WhereSQL := WhereSQL + ' AND TARIH<=' + SQL_Tarih(dtpIslemTar2.Date);
    end;

    if ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=True)) Then
    begin
      WhereSQL := WhereSQL + ' AND TARIH BETWEEN ' + SQL_Tarih(dtpIslemTar.Date) + ' AND ' + SQL_Tarih(dtpIslemTar2.Date);
    end;

    if Length(Trim(txtCARI_KOD.Text))<> 0  then
    begin
      WhereSQL := WhereSQL + ' AND ANT_DETAIL.CARI_KOD = ' + SQL_Katar(txtCARI_KOD.Text);
    end else
    begin
      if Length(Trim(cboCARI_AD.Text))<> 0  then
      WhereSQL := WhereSQL + ' AND ANT_DETAIL.CARI_AD LIKE ' + SQL_Katar(cboCARI_AD.Text + '%');
    end;

    if Length(Trim(txtBEYAN.Text))<> 0  then
    begin
     case prv_TIP of
     1,3,4: begin
              case cboBEYAN.ItemIndex of
               0: //Antrepo Bey. No
                WhereSQL := WhereSQL + ' AND ANT_DETAIL.ANT_BEYAN_NO LIKE ' + SQL_Katar(txtBEYAN.Text + '%');
               1: //Özet Beyan No
                WhereSQL := WhereSQL + ' AND ANT_MAIN.OZET_BEYAN_NO LIKE ' + SQL_Katar(txtBEYAN.Text + '%');
               2: // Konþimento No
                WhereSQL := WhereSQL + ' AND ANT_DETAIL.KONSIMENTO LIKE ' + SQL_Katar(txtBEYAN.Text + '%');
              end;
            end;
         2:begin
              case cboBEYAN.ItemIndex of
               0: //Çýkýþ Beyan No
                WhereSQL := WhereSQL + ' AND ANT_MAIN.OZET_BEYAN_NO LIKE ' + SQL_Katar(txtBEYAN.Text + '%');
               1: //Gümrk Vezne Alýndýsý
                WhereSQL := WhereSQL + ' AND ANT_MAIN.GUM_VEZ_NO LIKE ' + SQL_Katar(txtBEYAN.Text + '%');
              end;
           end;
     end;

    end;

    if Length(Trim(txtTASIYICI.Text))<> 0  then
    begin
        WhereSQL := WhereSQL + ' AND ANT_MAIN.TASIYAN_ID LIKE ' + SQL_Katar(txtTASIYICI.Text + '%');
    end;

    if Length(Trim(txtKAP_ADET.Text))<> 0  then
    begin
      if prv_TIP = 2 then
        WhereSQL := WhereSQL + ' AND ANT_DETAIL.CIK_KAP = ' + txtKAP_ADET.Text
      else
        WhereSQL := WhereSQL + ' AND ANT_DETAIL.KAP_ADET = ' + txtKAP_ADET.Text;
    end;

    if Length(Trim(txtKILO.Text))<> 0  then
    begin
      if prv_TIP = 2 then
        WhereSQL := WhereSQL + ' AND ANT_DETAIL.CIK_KILO = ' + txtKILO.Text
      else
        WhereSQL := WhereSQL + ' AND ANT_DETAIL.KILO = ' + txtKILO.Text;
    end;

    if Length(Trim(cboESYA.Text))<> 0  then
    begin
        WhereSQL := WhereSQL + ' AND ANT_DETAIL.ESYA LIKE ' + SQL_Katar(cboESYA.Text + '%');
    end;

    WhereSQL := WhereSQL + ' ORDER BY ANT_MAIN.DEVIR DESCENDING,ANT_MAIN.DEF_SIRA_NO ASCENDING,ANT_DETAIL.ANT_DETAIL_ID ASCENDING';

    with qryARA do
    begin
      Close;
      SQL.Clear;
      sql.Add(prv_MAIN_SQL + WhereSQL);
      Open;
    end;
end;

Procedure TfrmANT_SDLG.FillTheCombos;
var
   qryDeg:TIB_Query;
begin
  try
    DataMod.CreateQuery(qryDeg,Nil,False,DataMod.dbaMain);
    qryDeg.Active:=False;
    qryDeg.SQL.Clear;
    qryDeg.SQL.Text:='SELECT DISTINCT CARI_AD FROM ANT_DETAIL';
    qryDeg.Open;
    While not qryDeg.Eof do
    begin
      cboCARI_AD.Items.Add(qryDeg.FieldByName('CARI_AD').asString);
      qryDeg.Next;
    end;
    qryDeg.Active:=False;
    qryDeg.SQL.Clear;
    qryDeg.SQL.Text:='SELECT DISTINCT ESYA FROM ANT_DETAIL';
    qryDeg.Open;
    While not qryDeg.Eof do
    begin
      cboESYA.Items.Add(qryDeg.FieldByName('ESYA').asString);
      qryDeg.Next;
    end;
    DataMod.ReleaseQuery(qryDeg);
  except on E:  Exception do
    Application.MessageBox(PChar('Hatanýn oluþtuðu yer:TfrmANT_SDLG.FillTheCombos Hata Mesajý:' + E.Message),'Dikkat',MB_ICONERROR);
  end;
end;
Procedure TfrmANT_SDLG.AssignMainSQL;
begin
  with frmANT_SDLG do
  begin
    case prv_TIP of
    1,3,4:begin
        prv_MAIN_SQL := 'SELECT ANT_MAIN.ANT_MAIN_ID'+
                        '     , ANT_DETAIL.ANT_DETAIL_ID'+
                        '     , ANT_MAIN.DEF_SIRA_NO'+
                        '     , ANT_MAIN.TARIH'+
                        '     , ANT_MAIN.TASIYAN_ID'+
                        '     , ANT_MAIN.OZET_BEYAN_NO'+
                        '     , ANT_DETAIL.ANT_BEYAN_NO'+
                        '     , ANT_DETAIL.KONSIMENTO'+
                        '     , ANT_DETAIL.CARI_KOD'+
                        '     , ANT_DETAIL.CARI_AD'+
                        '     , ANT_DETAIL.KAP_ADET'+
                        '     , ANT_DETAIL.KILO'+
                        '     , ANT_DETAIL.KALAN_KAP'+
                        '     , ANT_DETAIL.KALAN_KILO'+
                        '     , ANT_DETAIL.ESYA'+
                        '     , ((CURRENT_DATE - ANT_MAIN.TARIH) + 1) AS YASI'+
                        '     , ANT_MAIN.CIK_KAP'+
                        '     , ANT_MAIN.CIK_KILO'+
                        '     , GUM_VEZ_NO'+
                        '     , GUM_KOM_KOD'+
                        '     ,(SELECT CARI_AD FROM CARI WHERE CARI_KOD = ANT_MAIN.GUM_KOM_KOD) AS GUM_KOM_AD '+
                        'FROM ANT_DETAIL '+
                        'INNER JOIN ANT_MAIN ON (ANT_DETAIL.ANT_MAIN_ID = ANT_MAIN.ANT_MAIN_ID)';
        qryARA.SQL.Clear;
        qryARA.SQL.Add(prv_MAIN_SQL);
        qryARA.FieldsVisible.Clear;
        qryARA.FieldsVisible.Add('ANT_DETAIL_ID=FALSE');
        qryARA.FieldsVisible.Add('ANT_MAIN_ID=FALSE');
        qryARA.FieldsVisible.Add('CIK_KAP=FALSE');
        qryARA.FieldsVisible.Add('CIK_KILO=FALSE');
        qryARA.FieldsVisible.Add('GUM_VEZ_NO=FALSE');
        qryARA.FieldsVisible.Add('GUM_KOM_KOD=FALSE');
        qryARA.FieldsVisible.Add('GUM_KOM_AD=FALSE');
      end;
    2:begin
        prv_MAIN_SQL := 'SELECT ANT_MAIN.ANT_MAIN_ID'+
                        '     , ANT_DETAIL.ANT_DETAIL_ID'+
                        '     , ANT_MAIN.DEF_SIRA_NO'+
                        '     , ANT_MAIN.TARIH'+
                        '     , ANT_MAIN.TASIYAN_ID'+
                        '     , ANT_MAIN.OZET_BEYAN_NO'+
                        '     , ANT_DETAIL.ANT_BEYAN_NO'+
                        '     , ANT_DETAIL.KONSIMENTO'+
                        '     , ANT_DETAIL.CARI_KOD'+
                        '     , ANT_DETAIL.CARI_AD'+
                        '     , ANT_DETAIL.KAP_ADET'+
                        '     , ANT_DETAIL.KILO'+
                        '     , ANT_DETAIL.KALAN_KAP'+
                        '     , ANT_DETAIL.KALAN_KILO'+
                        '     , ANT_DETAIL.ESYA'+
                        '     , ((CURRENT_DATE - ANT_MAIN.TARIH) + 1) AS YASI'+
                        '     , ANT_MAIN.CIK_KAP'+
                        '     , ANT_MAIN.CIK_KILO'+
                        '     , GUM_VEZ_NO'+
                        '     , GUM_KOM_KOD'+
                        '     ,(SELECT CARI_AD FROM CARI WHERE CARI_KOD = ANT_MAIN.GUM_KOM_KOD) AS GUM_KOM_AD '+
                        'FROM ANT_MAIN '+
                        'INNER JOIN ANT_DETAIL ON (ANT_MAIN.GIRIS_ANT_DETAIL_ID = ANT_DETAIL.ANT_DETAIL_ID)';
        qryARA.SQL.Clear;
        qryARA.SQL.Add(prv_MAIN_SQL);
        qryARA.FieldsVisible.Clear;
        qryARA.FieldsVisible.Add('ANT_DETAIL_ID=FALSE');
        qryARA.FieldsVisible.Add('ANT_MAIN_ID=FALSE');
        qryARA.FieldsVisible.Add('CIK_KAP=TRUE');
        qryARA.FieldsVisible.Add('CIK_KILO=TRUE');
        qryARA.FieldsVisible.Add('GUM_VEZ_NO=TRUE');
        qryARA.FieldsVisible.Add('GUM_KOM_KOD=TRUE');
        qryARA.FieldsVisible.Add('GUM_KOM_AD=TRUE');
        qryARA.FieldsVisible.Add('YASI=FALSE');
        qryARA.FieldsVisible.Add('KALAN_KILO=FALSE');
        qryARA.FieldsVisible.Add('KALAN_KAP=FALSE');
        qryARA.FieldsVisible.Add('ANT_BEYAN_NO=FALSE');
        cboBEYAN.Items.Clear;
        cboBEYAN.Items.Add('Çýkýþ Beyan No');
        cboBEYAN.Items.Add('Vezne Alýndý No');
        GroupBox3.Visible := False;
      end;
    end;
  end;// with end
end;
end.
