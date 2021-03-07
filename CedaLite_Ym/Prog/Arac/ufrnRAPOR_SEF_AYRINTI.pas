unit ufrnRAPOR_SEF_AYRINTI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, IB_Components, cxSSTypes, cxSSHeaders;

type
  TfrnRAPOR_SEF_AYRINTI = class(TForm)
    btnRapor: TButton;
    Button3: TButton;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    qrySEFER_AYRINTI: TIB_Query;
    procedure FormCreate(Sender: TObject);
    procedure Form_Open;
    procedure btnRaporClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  const cns_Sefer = 36;

var
  frnRAPOR_SEF_AYRINTI: TfrnRAPOR_SEF_AYRINTI;

implementation
uses unDataMod, ufrmCariSDLG, ufrmRaporCiktisi,UnFunc, main ;
{$R *.dfm}

procedure TfrnRAPOR_SEF_AYRINTI.btnRaporClick(Sender: TObject);
var
  row,col : integer;
  res_Cari : TStringList;
  WhereEk:Boolean;
  strSQL,SubeID:String;
  Sefer_Say:Integer;
  Alici_Tutar,Kiralik_Tutar:Double;
  X1,X2,X3,X4,X5:Double;
  CHeader : TcxSSHeader;
begin
  strSQL := 'SELECT (SELECT ESYA.ESYA_AD FROM ESYA WHERE ESYA.ESYA_ID = SEFER.ESYA_ID)  AS ESYA_ADD ' +
            ' ,SUM(SEFER.SEFER_SAY) AS TOP_SEFER_SAY ' +
            ' ,SUM(SEFER.MIKTAR) AS TOP_MIKTAR ' +
            ' FROM SEFER ' +
            ' WHERE SEFER.BAS_TAR >= ' + SQL_Tarih(dtpIslemTar1.Date) + ' AND SEFER.BAS_TAR <= ' + SQL_Tarih(dtpIslemTar2.Date) +
            ' GROUP BY SEFER.ESYA_ID; ';
  try
    with qrySEFER_AYRINTI do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
    end;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu.','Dikkat',MB_ICONSTOP);
    ShowMessage(strSQL);
  end;
  row := 0;
  col := 0;
 with frmRaporCiktisi do
  begin
    form_open();
    grdA.BeginUpdate;

    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      SetCellText(row,col,res_Cari[1]);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    inc(row);
    col:=5;

    SetCellText(row,col,'Döküman No : ');
    SetCellFont(col,row,col,row,[fsBold],10,'MS Sans Serif',2);
    Inc(Row);
    SetCellText(row,col,'Yayýn Tarihi : ');
    SetCellText(row,col+1,DateToStr(dtpIslemTar2.date));
    SetCellFont(col,row,col+1,row,[fsBold],10,'MS Sans Serif',2);
    Inc(Row);
    SetCellText(Row,0,'Taþýnan Eþya');
    SetCellText(Row,1,'Sefer Sayýsý');
    SetCellText(Row,2,'Miktar');
    SetCellFont(0,row,3,row,[fsBold],8,'MS Sans Serif',4);
    inc(row);
    repeat
      SetCellText(Row,0,qrySEFER_AYRINTI.FieldByName('ESYA_ADD').AsString);
      SetCellText(Row,1,qrySEFER_AYRINTI.FieldByName('TOP_SEFER_SAY').AsString);
      SetCellText(Row,2,qrySEFER_AYRINTI.FieldByName('TOP_MIKTAR').AsString);
      Inc(row);
      qrySEFER_AYRINTI.Next;
    until qrySEFER_AYRINTI.Eof;
    grdA.EndUpdate;
    WindowState := wsMaximized;
    qrySEFER_AYRINTI.Close;
    qrySEFER_AYRINTI.SQL.Clear;;
    Exit;
  end;
end;

procedure TfrnRAPOR_SEF_AYRINTI.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrnRAPOR_SEF_AYRINTI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TfrnRAPOR_SEF_AYRINTI.FormCreate(Sender: TObject);
begin
   dtpIslemTar1.Date := glb_DONEM_BAS;
   dtpIslemTar2.Date := Date;
end;
procedure TfrnRAPOR_SEF_AYRINTI.Form_Open;
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Sefer,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frnRAPOR_SEF_AYRINTI') then
    begin
      Application.CreateForm(TfrnRAPOR_SEF_AYRINTI, frnRAPOR_SEF_AYRINTI);
    end;
  end;
end;

end.
