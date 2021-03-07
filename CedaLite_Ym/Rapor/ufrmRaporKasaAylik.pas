unit ufrmRaporKasaAylik;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, ExtCtrls, StdCtrls, Buttons,
  ComCtrls,frxClass, frxIBOSet,cxSSTypes,cxSSHeaders;

type
  TfrmRaporKasaAylik = class(TForm)
    qryKasaAlan: TIB_Query;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    Memo1: TMemo;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    qryRapor: TIB_Cursor;
    GroupBox1: TGroupBox;
    txtKasaKod: TEdit;
    btnKasa: TButton;
    frxIBODts_Kasa_Aylik: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure frmRaporCiktisi_Open(strSQL:String);
    procedure frmRaporCiktisi_Yaz;
    procedure Alan_isimlerini_ekle;
    procedure Ay_isimlerini_ekle;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnKasaClick(Sender: TObject);
    procedure txtKasaKodExit(Sender: TObject);
    procedure txtKasaKodKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKasaKodKeyPress(Sender: TObject; var Key: Char);
    procedure btnRaporClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtKasaKodEnter(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
//////////////////////////////////////////////////////////////////////
  private
    row,col:integer;
    Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_kasa_aylik = 14;

var
  frmRaporKasaAylik: TfrmRaporKasaAylik;

implementation

uses unDataMod,unFunc,ufrmRaporCiktisi,main;

{$R *.dfm}

procedure TfrmRaporKasaAylik.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if DataMod.Modul_Hak(cns_kasa_aylik,local_CanUpdate,local_CanDelete) = False then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporKasaAylik') then
    begin
      Application.CreateForm(TfrmRaporKasaAylik,frmRaporKasaAylik);
      frmRaporKasaAylik.txtKasaKod.SetFocus;
    end;
  end;
end;

procedure TfrmRaporKasaAylik.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmRaporKasaAylik.btnKasaClick(Sender: TObject);
var
  Kasa_Kod,Aciklama,DovKod:String;
begin
  if DataMod.LS_KASA(Kasa_Kod,Aciklama,DovKod) then
  begin
    txtKasaKod.Text := Kasa_Kod;
  end;
end;

procedure TfrmRaporKasaAylik.txtKasaKodExit(Sender: TObject);
var
  Kasa_Ad : String;
begin
  if Length(Trim(txtKasaKod.Text))=0 then
  begin
    txtKasaKod.Color := clWindow;
    exit;
  end;
  if not DataMod.GET_KULLANICI_KASA_KOD(txtkasakod.Text,Kasa_Ad) then
  begin
    txtKasaKod.SetFocus;
  end
  else
  begin
    txtKasaKod.Color := clWindow;
  end;
end;

procedure TfrmRaporKasaAylik.Button3Click(Sender: TObject);
begin
  close;
end;



procedure TfrmRaporKasaAylik.txtKasaKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Kasa_Ad,Kasa_Kod,DovKod:String;
begin
  if Key=VK_F4 Then
  begin
    if DataMod.LS_Kasa(Kasa_Kod,Kasa_Ad,DovKod) then  txtKasaKod.Text := Kasa_Kod;
  end;
end;

procedure TfrmRaporKasaAylik.txtKasaKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporKasaAylik.btnRaporClick(Sender: TObject);
var
  strSQL,SQLSelectFrom,SQLJoin,SQLWhere,SQLOrderBy:String;
begin
  SQLSelectFrom := 'SELECT KASA.DOVKOD,KASA_AY.AY,KASA_AY.BORC,KASA_AY.ALACAK,KASA_AY.BORC_VPB,KASA_AY.ALACAK_VPB FROM KASA_AY';
  SQLJoin := ' LEFT OUTER JOIN KASA ON (KASA_AY.KASA_KOD = KASA.KASA_KOD)';
  SQLWhere := ' WHERE KASA.KASA_KOD = ' + SQL_Katar(txtKasaKod.Text) + ' AND'+' KASA_AY.YIL = ' + IntToStr(glb_CALISMA_YIL);
  SQLOrderBy := ' ORDER BY KASA_AY.AY';
  strSQL := SQLSelectFrom + SQLJoin + SQLWhere + SQLOrderBy;
  memo1.Clear;
  memo1.Text := strSQL;




 if Sender=Btn_Fast then
 begin

{
SELECT KASA.DOVKOD,
KASA_AY.AY,
KASA_AY.BORC,
KASA_AY.ALACAK,
KASA_AY.BORC_VPB,
KASA_AY.ALACAK_VPB,
(case
when
(KASA_AY.BORC_VPB>KASA_AY.ALACAK_VPB)
then 'B'
when
(KASA_AY.ALACAK_VPB>KASA_AY.BORC_VPB)
then 'A'
end ) Tip,
(case
when
(KASA_AY.BORC_VPB>KASA_AY.ALACAK_VPB)
then
KASA_AY.BORC_VPB-KASA_AY.ALACAK_VPB
when
(KASA_AY.ALACAK_VPB>KASA_AY.BORC_VPB)
then
KASA_AY.ALACAK_VPB-KASA_AY.BORC_VPB
end )Bakiye
FROM KASA_AY
LEFT OUTER JOIN KASA ON (KASA_AY.KASA_KOD = KASA.KASA_KOD)

}

       with IB_Query1 do
       begin
         Active := false;
         SQL.Clear;
         SQL.Add(
'SELECT KASA.DOVKOD, '+
'KASA_AY.AY, '+
'KASA_AY.BORC, '+
'KASA_AY.ALACAK, '+
'KASA_AY.BORC_VPB, '+
'KASA_AY.ALACAK_VPB, '+
'(case '+
'when '+
'(KASA_AY.BORC_VPB>KASA_AY.ALACAK_VPB) '+
'then ''B'' '+
'when '+
'(KASA_AY.ALACAK_VPB>KASA_AY.BORC_VPB) '+
'then ''A'' '+
'end ) Tip, '+
'(case '+
'when '+
'(KASA_AY.BORC_VPB>KASA_AY.ALACAK_VPB) '+
'then '+
'KASA_AY.BORC_VPB-KASA_AY.ALACAK_VPB '+
'when '+
'(KASA_AY.ALACAK_VPB>KASA_AY.BORC_VPB) '+
'then '+
'KASA_AY.ALACAK_VPB-KASA_AY.BORC_VPB '+
'end )Bakiye '+
'FROM KASA_AY '+
'LEFT OUTER JOIN KASA ON (KASA_AY.KASA_KOD = KASA.KASA_KOD) '+
' WHERE KASA.KASA_KOD = ' + SQL_Katar(txtKasaKod.Text) + ' AND'+' KASA_AY.YIL = ' + IntToStr(glb_CALISMA_YIL)+
' ORDER BY KASA_AY.AY'         );
         Active := True;
       end;

       if ((IB_Query1.Eof) and (IB_Query1.bof))then
       begin
         Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý. Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
         IB_Query1.Close;
         Exit;
       end;

       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Kasa_Aylik.fr3');
       //frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Kasa_Gunluk.fr3');

      { if cmbGrup.itemindex=0 then
       begin
         a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
         a.Visible:=True;
         a.Height:=20;
       end
       else
         a.Height:=0;
      }
       //frxReport1.PrepareReport();
       frxReport1.showReport;
       Exit;
  end;





  frmRaporCiktisi_Open(strSQL);
end;

procedure TfrmRaporKasaAylik.frmRaporCiktisi_Open(strSQL:String);
begin
  with qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := true;
  end;

  if ((qryRapor.Eof) and (qryRapor.bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    Exit;
  end
  else
  begin
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    frmRaporCiktisi_Yaz;
    if chk_Sirket.Checked then
    begin
      frmRaporCiktisi.SetCellFont(1,2,6,2,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(1,2,6,14,haRight,vaCenter);
    end
    else
    begin
      frmRaporCiktisi.SetCellFont(1,1,6,1,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(1,1,6,13,haRight,vaCenter);
    end;
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryKasaAlan.Close;
    qryRapor.Close;
  end;
end;

procedure TfrmRaporKasaAylik.frmRaporCiktisi_Yaz;
var
  res_Cari : TStringList;
begin
  row := 0;
  col := 0;
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket(res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 1;
  end;
  frmRaporCiktisi.SetCellText(row,col,txtKasaKod.Text);
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+2,'AYLIK KASA RAPORU');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
  Alan_isimlerini_ekle;
  Ay_isimlerini_ekle;
  if chk_Sirket.Checked then
  begin
    row := 3;
    col := 1;
  end
  else
  begin
    row := 2;
    col := 1;
  end;
  qryRapor.First;
  
  if qryRapor.FieldByName('AY').AsInteger>1 then
  Row:=row+qryRapor.FieldByName('AY').AsInteger-1;

  while not qryRapor.Eof do
  begin
    col := 1;
    DataMod.Rapor_Satir_Renklendir(col,row,6);

    case (qryRapor.FieldByName('AY').AsInteger) of
    1:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);

        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);

        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(row,col-2)='B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency-qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(row,col-2)='A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;
        qryRapor.Next;
      end;
    2:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);

        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);

        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency - qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;
        qryRapor.Next;
      end;
    3:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(row,col-2)='B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency - qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;
        qryRapor.Next;
      end;
    4:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(frmRaporKasaAylik.row,frmRaporKasaAylik.col-2) = 'B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency - qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        qryRapor.Next;
      end;
    5:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency - qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        qryRapor.Next;
      end;
    6:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency - qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        qryRapor.Next;
      end;
    7:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency - qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        qryRapor.Next;
      end;
    8:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency - qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;
        qryRapor.Next;
      end;
    9:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency - qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;
        qryRapor.Next;
      end;
    10:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency - qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(frmRaporKasaAylik.row,frmRaporKasaAylik.col-2) = 'A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;
        qryRapor.Next;
      end;
    11:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency - qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        qryRapor.Next;

      end;
    12:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        inc(col);

        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
        if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);

        if (qryRapor.FieldByName('BORC').AsCurrency > qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'B');
        end;

        if (qryRapor.FieldByName('BORC').AsCurrency < qryRapor.FieldByName('ALACAK').AsCurrency) then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'A');
        end;

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
        frmRaporCiktisi.format_ayarla(col,row,col,row);

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'B') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('BORC_VPB').AsCurrency - qryRapor.FieldByName('ALACAK_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;

        if (frmRaporCiktisi.GetCellText(row,col-2) = 'A') then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryRapor.FieldByName('ALACAK_VPB').AsCurrency - qryRapor.FieldByName('BORC_VPB').AsCurrency));
          frmRaporCiktisi.format_ayarla(col,row,col,row);
        end;
        qryRapor.Next;
      end;
      end;//case end
      inc(row);
    end;
end;

procedure TfrmRaporKasaAylik.Ay_isimlerini_ekle;
begin
  col := 0;
  frmRaporCiktisi.SetCellText(row,col,'Ocak');
  frmRaporCiktisi.SetCellText(row+1,col,'Þubat');
  frmRaporCiktisi.SetCellText(row+2,col,'Mart');
  frmRaporCiktisi.SetCellText(row+3,col,'Nisan');
  frmRaporCiktisi.SetCellText(row+4,col,'Mayýs');
  frmRaporCiktisi.SetCellText(row+5,col,'Haziran');
  frmRaporCiktisi.SetCellText(row+6,col,'Temmuz');
  frmRaporCiktisi.SetCellText(row+7,col,'Aðustos');
  frmRaporCiktisi.SetCellText(row+8,col,'Eylül');
  frmRaporCiktisi.SetCellText(row+9,col,'Ekim');
  frmRaporCiktisi.SetCellText(row+10,col,'Kasým');
  frmRaporCiktisi.SetCellText(row+11,col,'Aralýk');
  frmRaporCiktisi.SetCellFont(col,row,col,row+11,[fsBold],8,'MS Sans Serif',4);
  inc(row);
end;

procedure TfrmraporKasaAylik.Alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,IntToStr(glb_CALISMA_YIL));
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
  frmRaporCiktisi.SetCellText(row,col+1,'BORÇ');
  frmRaporCiktisi.SetCellText(row,col+2,'ALACAK');
  frmRaporCiktisi.SetCellText(row,col+3,'B/A');
  frmRaporCiktisi.SetCellText(row,col+4,'BORÇ VPB');
  frmRaporCiktisi.SetCellText(row,col+5,'ALACAK VPB');
  frmRaporCiktisi.SetCellText(row,col+6,'BAKÝYE');
  inc(row);
end;

procedure TfrmRaporKasaAylik.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    close;
  end;
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmRaporKasaAylik.txtKasaKodEnter(Sender: TObject);
begin
  txtKasaKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporKasaAylik.chk_SirketEnter(Sender: TObject);
begin
  chk_Sirket.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporKasaAylik.chk_SirketExit(Sender: TObject);
begin
  chk_Sirket.Color := clBtnFace;
end;

procedure TfrmRaporKasaAylik.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporKasaAylik);
end;

procedure TfrmRaporKasaAylik.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
  //a,b,c:TfrxComponent;
  res_Cari : TStringList;
begin
    if not Prv_Yazdirildi then
    begin

         res_Cari := TStringList.Create;
         if DataMod.FN_Sirket (res_Cari) then
         begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:=res_Cari[1];
         end;
         res_Cari.Free;
       {end;
       else
       begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:='';
       end;
        }

       d:=(frxReport1.FindComponent('Memo_Kasa') as TfrxMemoView);
       d.memo.Text:=txtKasaKod.Text;

       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);
      {

       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
      }
        
       Prv_Yazdirildi:=True;
    end;

end;

procedure TfrmRaporKasaAylik.IB_Query1CalculateField(Sender: TIB_Statement;
  ARow: TIB_Row; AField: TIB_Column);
begin
{     if ARow.ByName('AY').AsInteger=1 then ARow.ByName('CALC_AYLAR').AsString := 'OCAK';
     if ARow.ByName('AY').AsInteger=1 then ARow.ByName('CALC_AYLAR').AsString := 'OCAK';
     if ARow.ByName('AY').AsInteger=1 then ARow.ByName('CALC_AYLAR').AsString := 'OCAK';
     if ARow.ByName('AY').AsInteger=1 then ARow.ByName('CALC_AYLAR').AsString := 'OCAK';
}
end;

end.
