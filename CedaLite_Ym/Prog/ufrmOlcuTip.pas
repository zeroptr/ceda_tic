unit ufrmOlcuTip;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Db, Grids,  ExtCtrls, DBCtrls, Buttons , IB_Components,
  IB_Grid, IB_NavigationBar, IB_UpdateBar, StdCtrls, IB_Controls;

type
  TfrmOlcuTip = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    qryOlcu_Tip: TIB_Query;
    qryOlcu_Bir: TIB_Query;
    dtsOlcu_Tip: TIB_DataSource;
    dtsOlcu_Bir: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    IB_UpdateBar1: TIB_UpdateBar;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_Grid2: TIB_Grid;
    btnVarSay: TButton;
    Panel3: TPanel;
    IB_Text1: TIB_Text;
    IB_NavigationBar2: TIB_NavigationBar;
    IB_UpdateBar2: TIB_UpdateBar;
    btnCikis: TBitBtn;
////////////////////////////////////////////////////////////////////////////////
    function Form_Open(Menu:Boolean):Boolean;
////////////////////////////////////////////////////////////////////////////////
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure IB_Grid1KeyPress(Sender: TObject; var Key: Char);
    procedure qryOlcu_TipBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;      var AllowChange: Boolean);
    procedure qryOlcu_BirAfterInsert(IB_Dataset: TIB_Dataset);
    procedure btnVarSayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryOlcu_TipAfterPost(IB_Dataset: TIB_Dataset);
    procedure qryOlcu_TipAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormCreate(Sender: TObject);
    procedure qryOlcu_BirBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure btnCikisClick(Sender: TObject);
    procedure qryOlcu_TipBeforePost(IB_Dataset: TIB_Dataset);
    procedure qryOlcu_BirBeforePost(IB_Dataset: TIB_Dataset);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    prv_Delete_Manual:Boolean;
    prv_Insert_State:Boolean;
  public
    { Public declarations }
  end;
var
  frmOlcuTip: TfrmOlcuTip;
implementation

uses unDataMod,unFunc,Main;
{$R *.DFM}

function TfrmOlcuTip.Form_Open(Menu:Boolean):Boolean;
begin
  Result := False;
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if MainForm.FindChildFrm(Application, 'frmOlcuTip') = False  then
  begin
    Application.CreateForm(TfrmOlcuTip, frmOlcuTip);
    Result := True;
  end
  else
  begin
    Application.MessageBox('Ölçü iþlemleri formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  frmOlcuTip.PageControl1.ActivePageIndex:=0;
  frmOlcuTip.qryOlcu_Tip.Active := True;
end;

procedure TfrmOlcuTip.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  case  PageControl1.ActivePageIndex  of
  0:
    begin
      if qryOlcu_Tip.State in [dssInsert,dssEdit] Then
      begin
        case Application.MessageBox('Deðiþiklikleri Kaydetmek Ýstermisiniz','Dikkat',MB_YESNOCANCEL) of
        6:
          begin
            qryOlcu_Tip.Post;
          end;
        2: CanClose := False;
        7:
          begin
            qryOlcu_Tip.Cancel;
          end;
        end;//end case
      end;
    end;
  1:
    begin
      if not ((qryOlcu_Bir.Eof) And (qryOlcu_Bir.Bof)) then
      begin
        with DataMod.qryGENEL do
        begin
          Active := False;
          SQL.Clear;
          SQl.Add('SELECT COUNT(*) as DOM_SAY FROM OLCUBIR WHERE DOMINANT=1 AND OLCU_TIP=' +SQL_Katar(qryOlcu_Tip.FieldByName('OLCU_TIP').AsString));
          Active := True;
        end;
        if (DataMod.qryGenel.FieldByName('DOM_SAY').AsInteger = 0) then
        begin
          Application.MessageBox('Dominant Belirlemek Zorundasýnýz','Dikkat',MB_ICONWARNING);
          CanClose := False;
        end;
      end;
    end;
  end;
end;

procedure TfrmOlcuTip.IB_Grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmOlcuTip.qryOlcu_TipBeforeDelete(IB_Dataset: TIB_Dataset);
var
  strMesaj:String;
begin
  if prv_Delete_Manual=not True Then
  begin
    if DataMod.Delete_Control('OLCUTIP',qryOlcu_Tip.FieldByName('OLCU_TIP').AsString,strMesaj) then
    begin
      if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
    end
    else
    begin
      Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
      Abort;
    end;
  end;
end;

procedure TfrmOlcuTip.PageControl1Change(Sender: TObject);
var
  strSQL:String;
begin
  case PageControl1.ActivePageIndex of
  1:
    begin // ölçü birimleri nw girilirkene
      strSQL:='SELECT * FROM OLCUBIR WHERE OLCU_TIP = ' + SQL_Katar(qryOlcu_Tip.FieldByName('OLCU_TIP').AsString);
      with qryOlcu_Bir do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add(strSQL);
        Active:= True;
      end;
      //dsqlDom_Clean.Prepared := True;
    end; //case 1 end
  end; //case PageControl1.ActivePageIndex of end;
end;

procedure TfrmOlcuTip.PageControl1Changing(Sender: TObject;var AllowChange: Boolean);
begin
  case PageControl1.ActivePageIndex of
  0:
    begin
      if (qryOlcu_Tip.State in [dssInsert,dssEdit]) Then
      begin
        Application.MessageBox('Yaptýðýnýz Deðiþiklikleri Kaydetmeden Bu Sayfaya Geçemezsiniz','Dikkat',MB_ICONWARNING);
        AllowChange := False;
      end;
    end;//end case 0
  1:
    begin
      if not ((qryOlcu_Bir.Eof) And (qryOlcu_Bir.Bof)) then
      begin
        with DataMod.qryGENEL do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('SELECT COUNT(*) as DOM_SAY FROM OLCUBIR WHERE DOMINANT=1 AND OLCU_TIP=' + SQL_Katar(qryOlcu_Tip.FieldByName('OLCU_TIP').AsString));
          Active := True;
        end;
        if (DataMod.qryGenel.FieldByName('DOM_SAY').AsInteger=0) Then
        begin
          Application.MessageBox('Dominant Belirlemek Zorundasýnýz','Dikkat',MB_ICONWARNING);
          AllowChange := False;
        end
        else
        begin
          with DataMod.qryGENEL do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('SELECT COUNT(*) as DOM_SAY FROM OLCUBIR WHERE DOMINANT=0 AND DEGERTODOM=0 AND OLCU_TIP=' + SQL_Katar(qryOlcu_Tip.FieldByName('OLCU_TIP').AsString));
            Active := True;
          end;
          if (DataMod.qryGenel.FieldByName('DOM_SAY').AsInteger<>0) then
          begin
            Application.MessageBox('Dominant Olmayan Deðerleri "0" Olmaz','Dikkat',MB_ICONWARNING);
            AllowChange := False;
          end;
        end;//end else
      end//end if not ((qryOlcu_Bir.Eof) And (qryOlcu_Bir.Bof)) then
      else
      begin
        case Application.MessageBox('Tanýmladýðýnýz Ölçü Tipi Ýçin Mutlaka Bir Ölçü Birimi Belirlemek Zorundasýnýz'
                                      + ' Ölçü Birimini Silmek Ýçin Hayýr Tanýmlamak Evet'   ,'DÝKKAT',MB_YESNO) of
        6:
          begin
            AllowChange := False;
          end;
        7:
          begin
            prv_Delete_Manual:=True;
            qryOlcu_Tip.Delete;
            prv_Delete_Manual:=False;
            PageControl1.ActivePageIndex := 0;
          end;
        end;//end case messagebox
      end;//end else
    end;//end case 1
  end; //case PageControl1.ActivePageIndex of end;
end;

procedure TfrmOlcuTip.qryOlcu_BirAfterInsert(IB_Dataset: TIB_Dataset);
begin
  qryOlcu_Bir.FieldByName('OLCU_TIP').AsString := qryOlcu_Tip.FieldByName('OLCU_TIP').AsString;
  qryOlcu_Bir.FieldByName('DOMINANT').AsInteger := 0;
end;

procedure TfrmOlcuTip.btnVarSayClick(Sender: TObject);
var
  strSQL:String;
begin
  //dominant lar siliniyo
  with DataMod.qryGENEL do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE OLCUBIR SET OLCUBIR.DOMINANT=0 WHERE OLCUBIR.OLCU_TIP='+SQL_Katar(qryOlcu_Tip.FieldByName('OLCU_TIP').AsString));
    Active := True;
    // secilli kaydýn dominantý 1 yapýlýyo
    Active := False;
    SQL.Clear;
    SQl.Add('UPDATE OLCUBIR SET OLCUBIR.DOMINANT=1,DEGERTODOM=1 WHERE OLCUBIR.OLCUBIRIM='+SQL_Katar(qryOlcu_Bir.FieldByName('OLCUBIRIM').AsString));
    Active := True;
  end;
  /// table refrsh ediliyo
  strSQL:='SELECT * FROM OLCUBIR WHERE OLCU_TIP=' + SQL_Katar(qryOlcu_Tip.FieldByName('OLCU_TIP').AsString);
  with qryOlcu_Bir do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(strSQL);
    Active:= True;
  end;
end;

procedure TfrmOlcuTip.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmOlcuTip.qryOlcu_TipAfterPost(IB_Dataset: TIB_Dataset);
var
  strSQL:String;
begin
  if prv_Insert_State=True Then
  begin
    Application.MessageBox('Tanýmladýðnýz Ölçü Tipinin Ölçü Birimlerini Tanýmlamalýsýnýz','Dikkat',MB_ICONWARNING);
    strSQL:='SELECT * FROM OLCUBIR WHERE OLCU_TIP=' + SQL_Katar(qryOlcu_Tip.FieldByName('OLCU_TIP').AsString);
    with qryOlcu_Bir do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active:= True;
    end;
    PageControl1.ActivePageIndex := 1;
  end;
  prv_Insert_State := False;
end;

procedure TfrmOlcuTip.qryOlcu_TipAfterInsert(IB_Dataset: TIB_Dataset);
begin
  prv_Insert_State := True ;
end;

procedure TfrmOlcuTip.FormCreate(Sender: TObject);
begin
  prv_Insert_State := False;
  prv_Delete_Manual := False;
end;

procedure TfrmOlcuTip.qryOlcu_BirBeforeDelete(IB_Dataset: TIB_Dataset);
var
  strMesaj:String;
begin
  if DataMod.Delete_Control('OLCUBIR',qryOlcu_Bir.FieldByName('OLCUBIRIM').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmOlcuTip.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOlcuTip.qryOlcu_TipBeforePost(IB_Dataset: TIB_Dataset);
begin
  if qryOlcu_Tip.FieldByName('OLCU_TIP').OldAsString='ADET' then Abort;
  if not DataMod.Post_Update('OLCUTIP',qryOlcu_Tip.FieldByName('OLCU_TIP').OldAsString,qryOlcu_Tip.FieldByName('OLCU_TIP').AsString,Nil) then Abort;
end;

procedure TfrmOlcuTip.qryOlcu_BirBeforePost(IB_Dataset: TIB_Dataset);
begin
  if qryOlcu_Tip.FieldByName('OLCU_TIP').OldAsString='ADET' then
  if qryOlcu_Bir.FieldByName('OLCUBIRIM').OldAsString='ADET' then
  Abort;
  
  if not DataMod.Post_Update('OLCUBIR',qryOlcu_Bir.FieldByName('OLCUBIRIM').OldAsString,qryOlcu_Bir.FieldByName('OLCUBIRIM').AsString,Nil) then Abort;
end;

procedure TfrmOlcuTip.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
end;

end.
