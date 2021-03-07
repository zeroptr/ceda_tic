unit ufrmRaporKullaniciHak;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, IB_Components,cxSSHeaders,cxSSTypes;

type
  TfrmRaporKullaniciHak = class(TForm)
    Panel1: TPanel;
    btnRapor: TButton;
    btnCikis: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    cmbUsers: TComboBox;
    procedure Form_Open;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCikisClick(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure Baslik_Alan_Isim_Ekle;
    procedure Rapor_Yaz;
    procedure Kullanici_Bilgisi_Ekle;
    procedure cmbUsersEnter(Sender: TObject);
    procedure cmbUsersExit(Sender: TObject);
  private
    { Private declarations }
    prv_row,prv_col : Integer;
    prv_MODUL_ID : TStringList;
  public
    { Public declarations }
  end;

var
  frmRaporKullaniciHak: TfrmRaporKullaniciHak;

implementation

uses main,unDataMod,ufrmRaporCiktisi,unFunc;

{$R *.dfm}
procedure TfrmRaporKullaniciHak.Form_Open();
var
  qryUsers : TIB_Cursor;
begin
  if not glb_Yonetici then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporKullaniciHak') then
    begin
      DataMod.CreateCursor(qryUsers,nil,False,DataMod.dbaANA);
      with qryUsers do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT USER_NAME FROM KULLANICI ORDER BY USER_NAME');
        Open;
      end;
      Application.CreateForm(TfrmRaporKullaniciHak,frmRaporKullaniciHak);
      with frmRaporKullaniciHak do
      begin
        cmbUsers.Clear;
        qryUsers.First;
        while not qryUsers.Eof do
        begin
          cmbUsers.Items.Add(qryUsers.FieldByName('USER_NAME').asString);
          qryUsers.Next;
        end;
        cmbUsers.Items.Add('HEPSÝ');
        DataMod.ReleaseCursor(qryUsers);
        cmbUsers.ItemIndex := 0;
      end;
    end;
  end;
end;

procedure TfrmRaporKullaniciHak.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporKullaniciHak.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporKullaniciHak.btnRaporClick(Sender: TObject);
var
  CHeader : TcxSSHeader;
  CurCursor : TCursor;
begin
  CurCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  prv_row := 0;
  prv_col := 0;

  with frmRaporCiktisi do
  begin
    form_open;
    grdA.BeginUpdate;
    Baslik_Alan_Isim_Ekle;
    Rapor_Yaz;
    grdA.EndUpdate;

    SetCellAlignment(0,1,1,1,haLEFT,vaCENTER);
    SetCellAlignment(2,1,5,1,haRIGHT,vaCENTER);
    SetCellAlignment(0,2,0,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haLEFT,vaCENTER);
    format_ayarla(2,2,5,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
  end;
  CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
  CHeader.Size[0] := 100;
  CHeader.Size[1] := 100;
  CHeader.Size[2] := 100;
  CHeader.Size[3] := 100;
  CHeader.Size[4] := 100;
  CHeader.Size[5] := 100;

  frmRaporCiktisi.WindowState := wsMaximized;
  Screen.Cursor := CurCursor;
end;

procedure TfrmRaporKullaniciHak.Baslik_Alan_Isim_Ekle;
var
  qryModul : TIB_Cursor;
  res_Cari:TStringList;
begin
  prv_MODUL_ID := TStringList.Create;
  DataMod.CreateCursor(qryModul,nil,False,DataMod.dbaANA);
  with qryModul do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT MODUL_ADI,MODUL_ID FROM MODUL ORDER BY MODUL_ID');
    Open;
    First;
  end;

  frmRaporCiktisi.SetCellText(prv_row,prv_col,'Kullanýcý Haklarý Raporu');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',2);
  inc(prv_row);
  prv_col := 0;

  frmRaporCiktisi.SetCellText(prv_row,prv_col,'Rapor Tarihi : '+FormatDateTime('dd.mm.yyyy',date));
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',0);

  inc(prv_row);
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'Kayýt Ýzleme Kayýt Deðiþtirme Kayýt Silme');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',0);


  inc(prv_row);
  prv_col := 1;
  while not qryModul.Eof do
  begin
   prv_MODUL_ID.Add(qryModul.FieldByName('MODUL_ID').AsString);
   frmRaporCiktisi.SetCellText(prv_row,prv_col,qryModul.FieldByName('MODUL_ADI').AsString);
   inc(prv_col);
   qryModul.Next;
  end;
  frmRaporCiktisi.SetCellFont(1,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',4);
  DataMod.ReleaseCursor(qryModul);
  inc(prv_row);
  prv_col := 0;
end;//end begin


procedure TfrmRaporKullaniciHak.Rapor_Yaz;
var
  qryUser,qryModulHak:TIB_Cursor;
  i,a : Integer;
  KUL_ID,KUL_SID,ValueStr:String;
  strUser : TStringList;
begin
  if cmbUsers.Text <> 'HEPSÝ' then
  begin
    Kullanici_Bilgisi_Ekle;
  end
  else
  begin
    strUser := TStringList.Create;
    strUser.Assign(cmbUsers.Items);
    DataMod.CreateCursor(qryModulHak,nil,False,DataMod.dbaANA);
    for i := 0 to strUser.Count - 2 do
    begin
      prv_col := 0;
      DataMod.CreateCursor(qryUser,nil,False,DataMod.dbaANA);
      with qryUser do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT KULLANICI_ID,KULLANICI_SID FROM KULLANICI WHERE USER_NAME='+SQL_Katar(strUser[i]));
        Open;
      end;
////////////////////////////////////////////////////////////////////////////////
      KUL_ID := qryUser.FieldByName('KULLANICI_ID').AsString;
      KUL_SID := qryUser.FieldByName('KULLANICI_SID').AsString;
////////////////////////////////////////////////////////////////////////////////
      DataMod.ReleaseCursor(qryUser);
////////////////////////////////////////////////////////////////////////////////
      frmRaporCiktisi.SetCellText(prv_row,prv_col,strUser[i]);
      frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',0);
////////////////////////////////////////////////////////////////////////////////
      for a := 0 to prv_MODUL_ID.Count-1 do
      begin
        inc(prv_col);
        ValueStr := '';
        with qryModulHak do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT IZLEME,DEGISTIRME,SILME FROM MODULHAK WHERE MODUL_ID = '+prv_MODUL_ID[a]+' AND KULLANICI_ID = '+KUL_ID+' AND KULLANICI_SID = '+KUL_SID);
          Open;
        end;
        if qryModulHak.FieldByName('IZLEME').AsInteger = 1 then
        begin
          ValueStr := '+ ';
        end
        else
        begin
          ValueStr := '- ';
        end;
        if qryModulHak.FieldByName('DEGISTIRME').AsInteger = 1 then
        begin
          ValueStr := ValueStr + '+ ';
        end
        else
        begin
          ValueStr := ValueStr + '- ';
        end;
        if qryModulHak.FieldByName('SILME').AsInteger = 1 then
        begin
          ValueStr := ValueStr + '+';
        end
        else
        begin
          ValueStr := ValueStr + '-';
        end;
        frmRaporCiktisi.SetCellText(prv_row,prv_col,ValueStr);
      end;
      inc(prv_row);
    end;
    DataMod.ReleaseCursor(qryModulHak);
    strUser.Destroy;
  end;
end;

procedure TfrmRaporKullaniciHak.Kullanici_Bilgisi_Ekle;
var
  qryUser,qryModulHak:TIB_Cursor;
  i : Integer;
  KUL_ID,KUL_SID,ValueStr:String;
begin
  prv_col := 0;
  DataMod.CreateCursor(qryUser,nil,False,DataMod.dbaANA);
  with qryUser do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT KULLANICI_ID,KULLANICI_SID FROM KULLANICI WHERE USER_NAME='+SQL_Katar(cmbUsers.Text));
    Open;
  end;
////////////////////////////////////////////////////////////////////////////////
  KUL_ID := qryUser.FieldByName('KULLANICI_ID').AsString;
  KUL_SID := qryUser.FieldByName('KULLANICI_SID').AsString;
////////////////////////////////////////////////////////////////////////////////
  DataMod.ReleaseCursor(qryUser);
////////////////////////////////////////////////////////////////////////////////
  frmRaporCiktisi.SetCellText(prv_row,prv_col,cmbUsers.Text);
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',0);
////////////////////////////////////////////////////////////////////////////////
  DataMod.CreateCursor(qryModulHak,nil,False,DataMod.dbaANA);
////////////////////////////////////////////////////////////////////////////////
  for i := 0 to prv_MODUL_ID.Count-1 do
  begin
    inc(prv_col);
    ValueStr := '';
    with qryModulHak do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT IZLEME,DEGISTIRME,SILME FROM MODULHAK WHERE MODUL_ID = '+prv_MODUL_ID[i]+' AND KULLANICI_ID = '+KUL_ID+' AND KULLANICI_SID = '+KUL_SID);
      Open;
    end;
    if qryModulHak.FieldByName('IZLEME').AsInteger = 1 then
    begin
      ValueStr := '+ ';
    end
    else
    begin
      ValueStr := '- ';
    end;
    if qryModulHak.FieldByName('DEGISTIRME').AsInteger = 1 then
    begin
      ValueStr := ValueStr + '+ ';
    end
    else
    begin
      ValueStr := ValueStr + '- ';
    end;
    if qryModulHak.FieldByName('SILME').AsInteger = 1 then
    begin
      ValueStr := ValueStr + '+';
    end
    else
    begin
      ValueStr := ValueStr + '-';
    end;
    frmRaporCiktisi.SetCellText(prv_row,prv_col,ValueStr);
  end;
  DataMod.ReleaseCursor(qryModulHak);
end;

procedure TfrmRaporKullaniciHak.cmbUsersEnter(Sender: TObject);
begin
  cmbUsers.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporKullaniciHak.cmbUsersExit(Sender: TObject);
begin
  cmbUsers.Color := clWindow;
end;

end.
