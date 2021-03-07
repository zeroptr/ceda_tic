unit ufrmDovKart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, Grids, Buttons, ComCtrls, DBCtrls, StdCtrls, IB_Components, IB_Grid, Mask, IB_Controls,
  OleCtrls,wininet

,  ExtActns, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TfrmDovKart = class(TForm)
    lblGun: TLabel;
    qryDov_Kur: TIB_Query;
    qryDov_Kart: TIB_Query;
    dtsDov_Kur: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    Takvim: TMonthCalendar;
    btnIntDov: TButton;
    btnIntBaglan: TButton;
    btnBagKes: TButton;
    cmdKurGir: TBitBtn;
    cmdKurSil: TBitBtn;
    btnCikis: TBitBtn;
    Panel1: TPanel;
    btn_SonKur: TButton;
    dtsDov_Kart: TIB_DataSource;
    XMLDocument1: TXMLDocument;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure TakvimClick(Sender: TObject);
    procedure qryDovKartBeforeDelete(DataSet: TDataSet);
    procedure cmdKurSilClick(Sender: TObject);
    //procedure btnIntDovClick(Sender: TObject);
    procedure btnIntBaglanClick(Sender: TObject);
    procedure btnBagKesClick(Sender: TObject);
    procedure qryDov_KurBeforePost(IB_Dataset:TIB_Dataset);
    procedure cmdKurGirClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btn_SonKurClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key:Word;Shift:TShiftState);
    procedure qryDov_KurBeforeDelete(IB_Dataset: TIB_Dataset);


      function DownloadURLFile(const UrlFile, LocalFile : TFileName) : boolean;
        function Kontrol(xDate:String;Url: String): String;
        procedure DovizIslemleri(XMLComp: TXMLDocument);
////////////////////////////////////////////////////////////////////////////////
    procedure DovKurIslemler;
    procedure Son_Kur_Getir;
    function  ConnectionKind :Boolean;
    function  Form_Open(Menu:Boolean):Boolean;
    function  Date_MoveNDays(DateValue:TDateTime;DateMovement:Integer):TDateTime;
    function  Date_PriorDay(DateValue:TDateTime):TDateTime;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure qryDov_KurAfterPost(IB_Dataset: TIB_Dataset);
    procedure btnIntDovClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    Bulundu : Boolean;
    ConnAdres:PDWord;
    ConnName:String;
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
  end;
  const cns_dovkart = 1;
var
  frmDovKart: TfrmDovKart;

implementation
uses unDataMod,unFunc,Main, unLogger, DateUtils;
{$R *.DFM}

function TfrmDovKart.Form_Open(Menu:Boolean):Boolean;
var
  local_can_update,local_can_delete:Boolean;
begin
  Result := False;
  if not DataMod.Modul_Hak(cns_dovkart,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm( Application, 'frmDovKart') then
    begin
      Application.CreateForm(TfrmDovKart, frmDovKart);
    end
    else
    begin
      Application.MessageBox('Döviz kartý formu açýk','Dikkat',MB_ICONINFORMATION);
      Exit;
    end;

    with frmDovKart do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      with qryDov_Kur do
      begin
        FieldByName('ALISKUR').DisplayFormat := glb_DOV_KUR_PF;
        FieldByName('SATISKUR').DisplayFormat := glb_DOV_KUR_PF;
        FieldByName('EF_ALISKUR').DisplayFormat := glb_DOV_KUR_PF;
        FieldByName('EF_SATISKUR').DisplayFormat := glb_DOV_KUR_PF;
        Active := True;
      end;
    end;
  end;
  Result := True;
end;


procedure  TfrmDovKart.DovKurIslemler;
begin
  lblGun.Caption := DateToStr(Takvim.Date)+' Tarihinin döviz kurlarý';
  with qryDov_Kur do
  begin
    Active := False;
    ParamByName('PRM_TARIH').AsDate := Takvim.Date;
    Active := True;
  end;
end;

procedure TfrmDovKart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryDov_Kart.Active := False;
  qryDov_Kur.Active := False;
  Action := caFree;
end;

procedure TfrmDovKart.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qryDov_Kart.State in [dssInsert,dssEdit] then
  begin
    case Application.MessageBox('Döviz Kartýnda Yaptýðýnýz Deðiþiklikleri Kaydetmek Ýstermisiniz','Dikkat',MB_YESNOCANCEL) of
    6: qryDov_Kart.Post;
    2: CanClose := False;
    end;
  end;

  if qryDov_Kur.State in [dssInsert,dssEdit] then
  begin
    case Application.MessageBox('Döviz Kurunda Yaptýðýnýz Deðiþiklikleri Kaydetmek Ýstermisiniz','Dikkat',MB_YESNOCANCEL) of
    6: qryDov_Kur.Post;
    2: CanClose := False;
    end;
  end;
end;

procedure TfrmDovKart.FormShow(Sender: TObject);
begin
  Takvim.Date := Now;
  DovKurIslemler;
  if ConnectionKind Then
  begin
    if ConnName <>'MODEM' then
    begin
      btnIntBaglan.Visible := False;
      btnBagKes.Visible := False;
    end
    else
    begin
      btnBagKes.Visible := True;
    end;
  end
  else
  begin
    btnIntDov.Enabled := False;
    btnIntBaglan.Visible := True;
    btnIntBaglan.Enabled := True;
  end;
end;

procedure TfrmDovKart.TakvimClick(Sender: TObject);
begin
  DovKurIslemler;
end;

procedure TfrmDovKart.qryDovKartBeforeDelete(DataSet: TDataSet);
begin
  if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
end;

procedure TfrmDovKart.cmdKurSilClick(Sender: TObject);
var qryExecuter:TIB_Query;
begin
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if Application.MessageBox('Kurlarý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then EXIT;

  DataMod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
  with qryExecuter do
  begin
    Sql.Clear;
    Sql.Add('DELETE FROM DOVKUR WHERE TARIH = '+ SQL_Tarih(Takvim.date));
    Execute;
  end;
  dmLOGGER.Write2Log(0,0,0,0,2,qryExecuter.SQL.Text,'DOVKUR');
  DovKurIslemler;
end;

function TfrmDovKart.ConnectionKind :Boolean;
var
  flags: dword;
begin
  Result := InternetGetConnectedState(@flags, 0);
  if Result then
  begin
    if (flags and INTERNET_CONNECTION_MODEM) = INTERNET_CONNECTION_MODEM then
    begin
      //showmessage('Modem');
      ConnName := 'MODEM';
    end;
    if (flags and INTERNET_CONNECTION_LAN) = INTERNET_CONNECTION_LAN then
    begin
      //showmessage('LAN');
      ConnName := 'LAN';
    end;
    if (flags and INTERNET_CONNECTION_PROXY) = INTERNET_CONNECTION_PROXY then
    begin
      //showmessage('Proxy');
      ConnName := 'PROXY';
    end;
    if (flags and INTERNET_CONNECTION_MODEM_BUSY)=INTERNET_CONNECTION_MODEM_BUSY then
    begin
      //showmessage('Modem Busy');
      ConnName := 'MODEMBUSY';
    end;
  end
  else
   Result := False;
end;

{function DownloadFile(Source, Dest: string): Boolean;
begin
  try
    Result :=  UrlDownloadToFile(nil, PChar(source), PChar(Dest), 0, nil) = 0;
  except
    Result := False;
  end;
end;}

function GetInetFile(const fileURL, FileName: String): boolean;
const BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: DWORD;
  f: File;
  sAppName: string;
begin
  try
    sAppName := ExtractFileName(Application.ExeName);
    hSession := InternetOpen(PChar(sAppName),INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
    try
      hURL := InternetOpenURL(hSession,PChar(fileURL),nil,0,0,0);
      try
        AssignFile(f, FileName);
        Rewrite(f,1);
        repeat
          InternetReadFile(hURL, @Buffer,SizeOf(Buffer), BufferLen);
          BlockWrite(f, Buffer, BufferLen);
        until BufferLen = 0;
        CloseFile(f);
//        Result:=True;
      finally
        InternetCloseHandle(hURL)
      end;
    finally
      InternetCloseHandle(hSession)
    end;
    Result := True;
  except
    Result := False;
  end;
end;


function UrlOlustur(TakvimDate:TDateTime):String;
Var
 Yil,Ay,Gun:Word;
 StrAy,StrGun:String;
Begin
if Int(TakvimDate) = Date Then
  Begin
       //Result:='http://www.tcmb.gov.tr/wps/wcm/connect/tcmb+tr/tcmb+tr/main+page+site+area/bugun';
     //Result:='http://www.tcmb.gov.tr/kurlar/today.html';
          Result:='http://www.tcmb.gov.tr/kurlar/today.xml';
  End
 Else if Int(TakvimDate) < Date Then
 Begin
  DecodeDate(TakvimDate,Yil,Ay,Gun);
  if Length(IntToStr(Ay))=1 then  StrAy := '0' + IntToStr(Ay)  Else StrAy := IntToStr(Ay);
  if Length(IntToStr(Gun))=1 then StrGun := '0' + IntToStr(Gun) Else StrGun := IntToStr(Gun);
  Result:= 'http://www.tcmb.gov.tr/kurlar/'+IntToStr(Yil)+ StrAy + '/'+ StrGun + StrAy +IntToStr(Yil) + '.xml' ;
  //Result:= 'http://www.tcmb.gov.tr/kurlar/'+IntToStr(Yil)+ StrAy + '/'+ StrGun + StrAy +IntToStr(Yil) + '.html' ;
 End;

End;





//Kullanýmý:
//DovizIslemleri(XMLDocument1);

//Uses Vcl.ExtActns;


  function TfrmDovKart.DownloadURLFile(const UrlFile, LocalFile : TFileName) : boolean;
  begin
    Result:=True;

    with TDownLoadURL.Create(nil) do
    try
      URL:=UrlFile;
      Filename:=LocalFile;
      try
        ExecuteTarget(nil);
      except
        Result:=False;
      end;
    finally
      Free;
    end;
  end;

  function TfrmDovKart.Kontrol(xDate:String;Url: String): String;
  var
    D1,
    D2,
    Tmp: String;
  begin
    Tmp := FormatDateTime('t',Now);
    if (Trim(xDate) = '') or (StrToTime(Tmp) < StrToTime('15:30')) then //2. koþulun sebebi saat 15:30 dan önce her zaman bir önceki günün deðeri gelir
      Url := Format(Url,['today'])
    else
    begin
      D1 := FormatDateTime('yyyymm', StrToDate(xDate));
      D2 := FormatDateTime('ddmmyyyy', StrToDate(xDate));
    
      Tmp := D1 + '/' + D2 ;
      Url := Format(Url,[Tmp]); 
    end;
    Result := Url;
  end;

  
procedure TfrmDovKart.DovizIslemleri(XMLComp: TXMLDocument);
var
  I: Integer;
  S,
  LocalFile,
  tmpUrl: String;
  HeaderNode,
  CurrNode: IXMLNode;

  deger:Double;

 ElementNode, AccountNameNode, FullNameNode : IXMLNode;
  Count: Integer;
  NodeName, NodeText: String;





begin
  try 
    LocalFile := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'temp.TMB.xml';
    tmpUrl := Kontrol(DateToStr(Date),'http://www.tcmb.gov.tr/kurlar/%s.xml');
    Screen.Cursor:=crHourglass;
    try
      if not DownloadURLFile(tmpUrl, LocalFile)  then
      begin
        Screen.Cursor:=crDefault;
        Raise Exception.CreateFmt('Ýnternet ile ilgili bir problem ile karþýlaþýldý lütfen tekrar deneyiniz..',[]);
        Exit;
      end;

      if not FileExists(LocalFile) then
      begin
        Screen.Cursor:=crDefault;
        raise exception.Create('Xml Ýndirilemedi!');
        Exit;
      end;
      XMLComp.Active := False;
      XMLComp.FileName := LocalFile;
      XMLComp.Active:=True;

      HeaderNode := XMLComp.DocumentElement;
      S          := HeaderNode.Attributes['Tarih'];// Tarih

      for i := 0 to HeaderNode.ChildNodes.Count - 1 do
      begin
        CurrNode := HeaderNode.ChildNodes.Get(I);



  //AccountNameNode :=
//   CurrNode.ChildNodes.Get(0).NodeValue
//  NodeName := AccountNameNode.NodeName;
 // NodeText := AccountNameNode.Text;

     //PARA KODU

        CurrNode.Attributes['Kod'];
        //<Unit>
         NodeText:=
        CurrNode.ChildNodes.Get(0).NodeValue;
        //<Isim>
        CurrNode.ChildNodes.Get(1).NodeValue;
        //<CurrencyName>
        CurrNode.ChildNodes.Get(2).NodeValue;
        //<ForexBuying>
        deger:=
        CurrNode.ChildNodes.Get(3).NodeValue;
        //<ForexSelling>
        CurrNode.ChildNodes.Get(4).NodeValue;
        //<BanknoteBuying>
        CurrNode.ChildNodes.Get(5).NodeValue;
        //<BanknoteSelling>
        CurrNode.ChildNodes.Get(6).NodeValue;
        //<CrossRateUSD>
        CurrNode.ChildNodes.Get(7).NodeValue;
        //<CrossRateUSD>
        CurrNode.ChildNodes.Get(8).NodeValue;


      end;
    finally
      DeleteFile(LocalFile);
      Screen.Cursor:=crDefault;
    end;
  except
    on E: Exception do ShowMessage(E.Message);
  end;//try
end;


    
procedure TfrmDovKart.btnIntDovClick(Sender: TObject);
var
  KelimeSayac,Sayac:Integer;
  MYList:TStringList;
  Url,Kur,Kur1,TempKelime,Kelime,TempStr,Satir,DovKod,strDOVKOD:String;
  Kontroly:Boolean;
  DeleteKur:TIB_Query;
    LocalFile,
  tmpUrl: String;



  I: Integer;
  S,

  HeaderNode,
  CurrNode: IXMLNode;

  deger:Double;
   XMLComp: TXMLDocument ;
 ElementNode, AccountNameNode, FullNameNode : IXMLNode;
  Count: Integer;
  NodeName, NodeText: String;

begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Screen.Cursor := crHourGlass;
     XMLComp:=XMLDocument1;
  //Url := UrlOlustur(Takvim.Date);
      LocalFile := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'temp.TMB.xml';
    tmpUrl := Kontrol(DateToStr(Takvim.Date),'http://www.tcmb.gov.tr/kurlar/%s.xml');

  if true then
  begin //if  if UrlOlustur(Takvim.Date)<> '' Then begin
    if DownloadURLFile(tmpUrl, LocalFile) then
    begin

      if not ((qryDov_Kur.Eof) And (qryDov_Kur.Eof)) then
      begin
        DataMod.CreateQuery(DeleteKur,nil,False,DataMod.dbaMain);
        with deleteKur do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('DELETE FROM DOVKUR WHERE TARIH='+SQL_Tarih(Takvim.Date));
          Execute;
        end;
        dmLOGGER.Write2Log(0,0,0,0,2,DeleteKur.SQL.Text,'DOVKUR');
        DovKurIslemler;
      end;

      qryDov_Kart.First;
      while not(qryDov_Kart.Eof) do
      begin

      XMLComp.Active := False;
      XMLComp.FileName := LocalFile;
      XMLComp.Active:=True;

      HeaderNode := XMLComp.DocumentElement;
      //S          := HeaderNode.Attributes['Tarih'];// Tarih

      for i := 0 to HeaderNode.ChildNodes.Count - 1 do
      begin
        CurrNode := HeaderNode.ChildNodes.Get(I);


          //if DovKod = 'GBP' Then Break;
          //strDOVKOD := qryDov_Kart.FieldByName('DOVKOD').AsString+'/TRY';
          strDOVKOD := qryDov_Kart.FieldByName('DOVKOD').AsString;
          DovKod:=CurrNode.Attributes['Kod'];
          if DovKod = strDOVKOD then
          begin

            qryDov_Kur.Insert;
            qryDov_Kur.FieldByName('DOVKOD').AsString := qryDov_Kart.FieldByName('DOVKOD').AsString;
            qryDov_Kur.FieldByName('TARIH').AsDate := Takvim.Date ;
            KelimeSayac := 0;

  //AccountNameNode :=
//   CurrNode.ChildNodes.Get(0).NodeValue
//  NodeName := AccountNameNode.NodeName;
 // NodeText := AccountNameNode.Text;

     //PARA KODU
             {
        CurrNode.Attributes['Kod'];
        //<Unit>
         NodeText:=
        CurrNode.ChildNodes.Get(0).NodeValue;
        //<Isim>
        CurrNode.ChildNodes.Get(1).NodeValue;
        //<CurrencyName>
        CurrNode.ChildNodes.Get(2).NodeValue;
        //<ForexBuying>
        deger:=
        CurrNode.ChildNodes.Get(3).NodeValue;
        //<ForexSelling>
        CurrNode.ChildNodes.Get(4).NodeValue;
        //<BanknoteBuying>
        CurrNode.ChildNodes.Get(5).NodeValue;
        //<BanknoteSelling>
        CurrNode.ChildNodes.Get(6).NodeValue;
        //<CrossRateUSD>
        CurrNode.ChildNodes.Get(7).NodeValue;
        //<CrossRateUSD>
        CurrNode.ChildNodes.Get(8).NodeValue;
             }

                      NodeText:=StringReplace(CurrNode.ChildNodes.Get(3).NodeValue,'.',',',[rfReplaceAll]);
                      //deger:= StrToCurr( NodeText);
                      if isNumeric(NodeText) Then
                      begin
                        qryDov_Kur.FieldByName('ALISKUR').AsCurrency := StrToCurr(NodeText);
                      end
                      else
                      begin
                        qryDov_Kur.FieldByName('ALISKUR').AsCurrency := 1 ;
                      end;

                     NodeText:=StringReplace(CurrNode.ChildNodes.Get(4).NodeValue,'.',',',[rfReplaceAll]);
                      if isNumeric(NodeText) Then
                      qryDov_Kur.FieldByName('SATISKUR').AsCurrency := StrToCurr(NodeText)
                      else
                      qryDov_Kur.FieldByName('SATISKUR').AsCurrency := 1 ;

                      NodeText:=StringReplace(CurrNode.ChildNodes.Get(5).NodeValue,'.',',',[rfReplaceAll]);
                      if isNumeric(NodeText) Then
                      qryDov_Kur.FieldByName('EF_ALISKUR').AsCurrency := StrToCurr(NodeText)
                      else
                      qryDov_Kur.FieldByName('EF_ALISKUR').AsCurrency := 1;

                       NodeText:=StringReplace(CurrNode.ChildNodes.Get(6).NodeValue,'.',',',[rfReplaceAll]);
                      if isNumeric(NodeText) Then
                      qryDov_Kur.FieldByName('EF_SATISKUR').AsCurrency :=  StrToCurr(NodeText)
                      else
                      qryDov_Kur.FieldByName('EF_SATISKUR').AsCurrency :=  1;
                      qryDov_Kur.Post;


                Kontroly := True;
                    end;
           //if DovKod = 'GBP' Then Break;
            //until(Kontroly=False);
          end;

        qryDov_Kart.Next;

      end;//end while not(qryDov_Kart.Eof) do

      with qryDov_Kur do
      begin
        Insert;
        FieldByName('DOVKOD').AsString := glb_DEFCUR;
        FieldByName('TARIH').AsDate := Takvim.Date ;
        FieldByName('ALISKUR').AsInteger := 1;
        FieldByName('SATISKUR').AsInteger := 1;
        FieldByName('EF_ALISKUR').AsCurrency := 1;
        FieldByName('EF_SATISKUR').AsCurrency := 1;
        Post;
      end;

      if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
      begin
        with qryDov_Kur do
        begin
          Insert;
          FieldByName('DOVKOD').AsString := 'TRL';
          FieldByName('TARIH').AsDate := Takvim.Date ;
          FieldByName('ALISKUR').AsInteger := 1000000;
          FieldByName('SATISKUR').AsInteger := 1000000;
          FieldByName('EF_ALISKUR').AsCurrency := 1000000;
          FieldByName('EF_SATISKUR').AsCurrency := 1000000;
          Post;
        end;
      end;
      DovKurIslemler;
      DeleteFile(glb_FILES_DIR +'kur.html');
      DeleteFile(LocalFile);
    end
    else
      ShowMessage('Yükleme islemi basarisiz.')
  end;//end if url <> '' then
  DataMod.ReleaseQuery(DeleteKur);
  Screen.Cursor := crDefault;


end;

  {
procedure TfrmDovKart.btnIntDovClick(Sender: TObject);
var
  KelimeSayac,Sayac:Integer;
  MYList:TStringList;
  Url,Kur,Kur1,TempKelime,Kelime,TempStr,Satir,DovKod,strDOVKOD:String;
  Kontrol:Boolean;
  DeleteKur:TIB_Query;
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Screen.Cursor := crHourGlass;
  Url := UrlOlustur(Takvim.Date);
  if Url<>'' then
  begin //if  if UrlOlustur(Takvim.Date)<> '' Then begin
    if GetInetFile(Url, glb_FILES_DIR +'kur.html') then
    begin
      if not ((qryDov_Kur.Eof) And (qryDov_Kur.Eof)) then
      begin
        DataMod.CreateQuery(DeleteKur,nil,False,DataMod.dbaMain);
        with deleteKur do
        begin
          Active := False;
          SQL.Clear;
          SQL.Add('DELETE FROM DOVKUR WHERE TARIH='+SQL_Tarih(Takvim.Date));
          Execute;
        end;
        dmLOGGER.Write2Log(0,0,0,0,2,DeleteKur.SQL.Text,'DOVKUR');
        DovKurIslemler;
      end;
      MYList:=TStringList.Create;
      MYList.Clear;
      MYList.LoadFromFile(glb_FILES_DIR +'kur.html');
      qryDov_Kart.First;
      while not(qryDov_Kart.Eof) do
      begin
        for Sayac:=1 to MYList.Count-1 do
        begin
          Satir:=MYList.Strings[Sayac];
          DovKod:= (Copy(Satir,1,7));
          if DovKod = 'ILS' Then Break;
          strDOVKOD := qryDov_Kart.FieldByName('DOVKOD').AsString+'/TRY';
          if DovKod = strDOVKOD then
          begin
            Satir:=Copy(Satir+' ,',28,Length(Satir));
            TempStr := Satir;
            qryDov_Kur.Insert;
            qryDov_Kur.FieldByName('DOVKOD').AsString := qryDov_Kart.FieldByName('DOVKOD').AsString;
            qryDov_Kur.FieldByName('TARIH').AsDate := Takvim.Date ;
            KelimeSayac := 0;
            repeat
              if Pos(' ',TempStr) <> 0 then
              begin
                TempStr := Copy(TempStr,Pos(' ',TempStr)+1,(Length(TempStr)-Pos(' ',TempStr)));
                if (Pos(' ',TempStr)<>1) then
                begin
                  Kelime := Copy(TempStr,1,Pos(' ',TempStr)-1);
                  Kur := Copy(Kelime,1,Pos(',',Kelime)-1);
                  repeat
                    TempKelime := Copy(Kelime,Pos(',',Kelime)+1,Length(Kelime));
                    Kur := Kur + Copy(TempKelime,1,Pos(',',TempKelime)-1);
                    Kelime := TempKelime;
                  until(Pos(',',Kelime)=0);
                  Kur:=Kur + Kelime;
                  KelimeSayac := KelimeSayac + 1;
                  Kur1 := Copy(Kur,1,Pos('.',Kur)-1);
                  Kur := Kur1+','+Copy(Kur,3,Length(Kur)-2);
                  case KelimeSayac Of
                  1://Alýþ
                    begin
                      if isNumeric(Kur) Then
                      begin
                        qryDov_Kur.FieldByName('ALISKUR').AsCurrency := StrToCurr(Kur);
                      end
                      else
                      begin
                        qryDov_Kur.FieldByName('ALISKUR').AsCurrency := 1 ;
                      end;
                    end;
                  2: //satýþ
                    begin
                    //
                      if isNumeric(Kur) Then
                      qryDov_Kur.FieldByName('SATISKUR').AsCurrency := StrToCurr(Kur)
                      else
                      qryDov_Kur.FieldByName('SATISKUR').AsCurrency := 1 ;
                    end;
                  3:
                    begin
                      if isNumeric(Kur) Then
                      qryDov_Kur.FieldByName('EF_ALISKUR').AsCurrency := StrToCurr(Kur)
                      else
                      qryDov_Kur.FieldByName('EF_ALISKUR').AsCurrency := 1;
                    end;
                  4:
                    begin
                      if isNumeric(Kur) Then
                      qryDov_Kur.FieldByName('EF_SATISKUR').AsCurrency :=  StrToCurr(Kur)
                      else
                      qryDov_Kur.FieldByName('EF_SATISKUR').AsCurrency :=  1;
                      qryDov_Kur.Post;
                    end;
                  end;//end case
                end;//end if (Pos(' ',TempStr)<>1) then
                Kontrol := True;
              end//end if Pos(' ',TempStr) <> 0 then
              else Kontrol:= False;
            until(Kontrol=False);
          end;
        end;//end for Sayac:=1 to MYList.Count-1 do
        qryDov_Kart.Next;
      end;//end while not(qryDov_Kart.Eof) do

      with qryDov_Kur do
      begin
        Insert;
        FieldByName('DOVKOD').AsString := glb_DEFCUR;
        FieldByName('TARIH').AsDate := Takvim.Date ;
        FieldByName('ALISKUR').AsInteger := 1;
        FieldByName('SATISKUR').AsInteger := 1;
        FieldByName('EF_ALISKUR').AsCurrency := 1;
        FieldByName('EF_SATISKUR').AsCurrency := 1;
        Post;
      end;

      if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
      begin
        with qryDov_Kur do
        begin
          Insert;
          FieldByName('DOVKOD').AsString := 'TRL';
          FieldByName('TARIH').AsDate := Takvim.Date ;
          FieldByName('ALISKUR').AsInteger := 1000000;
          FieldByName('SATISKUR').AsInteger := 1000000;
          FieldByName('EF_ALISKUR').AsCurrency := 1000000;
          FieldByName('EF_SATISKUR').AsCurrency := 1000000;
          Post;
        end;
      end;
      DovKurIslemler;
      DeleteFile(glb_FILES_DIR +'kur.html');
    end
    else
      ShowMessage('Yükleme islemi basarisiz.')
  end;//end if url <> '' then
  DataMod.ReleaseQuery(DeleteKur);
  Screen.Cursor := crDefault;
end;
   }
procedure TfrmDovKart.btnIntBaglanClick(Sender: TObject);
var
  b:Cardinal;
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if ConnectionKind Then
  begin
    ///ShowMessage('irfan');
  end
  else
  begin
    b:=0;
    InternetDial(MainForm.Handle,'Dial-up Connection',INTERNET_AUTODIAL_FORCE_ONLINE,@ConnAdres,b);
    btnIntDov.Enabled := True;
    btnBagKes.Visible := True;
    btnBagKes.Enabled := True;
  end;
end;

procedure TfrmDovKart.btnBagKesClick(Sender: TObject);
var
  b:Cardinal;
begin
  b:=0;
  InternetHangUp(Int64(ConnAdres),b);
end;


procedure TfrmDovKart.cmdKurGirClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  qryDov_Kart.Active := True;
  if (qryDov_Kur.Bof and qryDov_Kur.Eof) then
  begin
    qryDov_Kart.First;
    while not (qryDov_Kart.Eof) do
    begin
      with qryDov_Kur do
      begin
        Append;
        FieldByName('DOVKOD').AsString := qryDov_Kart.FieldByName('DOVKOD').AsString;
        FieldByName('TARIH').AsDateTime  := Takvim.Date;
        if qryDov_Kart.FieldByName('DOVKOD').AsString = 'TRL' then
        begin
          if CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0 then
          begin
            FieldByName('ALISKUR').AsCurrency := 1000000;
            FieldByName('SATISKUR').AsCurrency := 1000000;
            FieldByName('EF_ALISKUR').AsCurrency := 1000000;
            FieldByName('EF_SATISKUR').AsCurrency := 1000000;
          end
          else
          begin
            FieldByName('ALISKUR').AsCurrency := 1;
            FieldByName('SATISKUR').AsCurrency := 1;
            FieldByName('EF_ALISKUR').AsCurrency := 1;
            FieldByName('EF_SATISKUR').AsCurrency := 1;
          end;
        end
        else
        begin
          FieldByName('ALISKUR').AsCurrency := 1;
          FieldByName('SATISKUR').AsCurrency := 1;
          FieldByName('EF_ALISKUR').AsCurrency := 1;
          FieldByName('EF_SATISKUR').AsCurrency := 1;
        end;
        Post;
      end;
      qryDov_Kart.Next;
    end; // while end
    with qryDov_Kur do
    begin
      Append;
      FieldByName('DOVKOD').AsString := 'YTL';
      FieldByName('TARIH').AsDateTime  := Takvim.Date;
      FieldByName('ALISKUR').AsInteger := 1;
      FieldByName('SATISKUR').AsInteger := 1;
      FieldByName('EF_ALISKUR').AsCurrency := 1;
      FieldByName('EF_SATISKUR').AsCurrency := 1;
      Post;
    end;
  end
  else
  begin
    while not (qryDov_Kart.Eof) Do
    begin
      Bulundu := qryDov_Kur.Locate('DOVKOD',qryDov_Kart.FieldByName('DOVKOD').AsString,[lopPartialKey]);
      if Bulundu = False then
      begin
        with qryDov_Kur do
        begin
          Append;
          FieldByName('DOVKOD').AsString := qryDov_Kart.FieldByName('DOVKOD').AsString;
          FieldByName('TARIH').AsDateTime  := Takvim.Date;
          if qryDov_Kart.FieldByName('DOVKOD').AsString = 'TRL' then
          begin
            if CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0 then
            begin
              FieldByName('ALISKUR').AsCurrency := 1000000;
              FieldByName('SATISKUR').AsCurrency := 1000000;
              FieldByName('EF_ALISKUR').AsCurrency := 1000000;
              FieldByName('EF_SATISKUR').AsCurrency := 1000000;
            end
            else
            begin
              FieldByName('ALISKUR').AsCurrency := 1;
              FieldByName('SATISKUR').AsCurrency := 1;
              FieldByName('EF_ALISKUR').AsCurrency := 1;
              FieldByName('EF_SATISKUR').AsCurrency := 1;
            end;
          end
          else
          begin
            FieldByName('ALISKUR').AsCurrency := 1;
            FieldByName('SATISKUR').AsCurrency := 1;
            FieldByName('EF_ALISKUR').AsCurrency := 1;
            FieldByName('EF_SATISKUR').AsCurrency := 1;
          end;
          Post;
        end;
      end;
      qryDov_Kart.Next;
    end; //while end
  end;
  IB_Grid1.SetFocus;
  qryDov_Kur.First;
end;

procedure TfrmDovKart.btnCikisClick(Sender: TObject);
begin
  close;
end;

procedure TfrmDovKart.btn_SonKurClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Son_Kur_Getir;
end;

procedure TfrmDovKart.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;
end;

function TfrmDovKart.Date_PriorDay(DateValue:TDateTime):TDateTime;
begin
  Result := Date_MoveNDays(DateValue,-1);
end;

function TfrmDovKart.Date_MoveNDays(DateValue:TDateTime;DateMovement:Integer):TDateTime;
begin
  Result := DateValue + DateMovement;
end;

procedure TfrmDovKart.Son_Kur_Getir;
var
  max_tar : TDate;
  i : byte;
  sec,ekle,deleteKur : TIB_Query;
  kodlar : TStringList;
  strSQL : String;
  msj : String;
begin
  if Application.MessageBox('Bu iþlemde sisteme girilmiþ en son kur bulunarak,bulunan kur bilgileri seçilen tarihteki deðerler ile deðiþtirilecektir,devam etmek istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=ID_NO then
  begin
    exit;
  end;

  kodlar := TStringList.Create;
  DataMod.CreateQuery(sec,nil,False,DataMod.dbaMain);
  DataMod.CreateQuery(ekle,nil,False,DataMod.dbaMain);
  DataMod.CreateQuery(deleteKur,nil,False,DataMod.dbaMain);

  with deleteKur do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('DELETE FROM DOVKUR WHERE TARIH='+SQL_Tarih(Takvim.Date));
    Execute;
  end;
  dmLOGGER.Write2Log(0,0,0,0,2,deleteKur.SQL.Text,'DOVKUR');

  with sec do
  begin
    SQL.Clear;
    SQL.Add('SELECT DOVKOD FROM DOVKART WHERE PARITE = 0');
    Active := True;
  end;

  sec.First;
  while not sec.Eof do
  begin
    kodlar.Add(sec.fieldbyname('DOVKOD').AsString);
    sec.Next;
  end;
  sec.Active := false;

//  max_tar := Takvim.Date;
  max_tar := Date;

  repeat
    max_tar := Date_PriorDay(max_tar);
    with sec do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT TARIH,ALISKUR,SATISKUR FROM DOVKUR WHERE TARIH = '+SQL_Tarih(max_tar));
      Active := True;
    end;
  until (sec.FieldByName('ALISKUR').AsCurrency <> 0) and (sec.FieldByName('SATISKUR').AsCurrency <> 0);
  sec.Active := False;
  msj := 'Kur bulunan tarih : '+ DateToStr(max_tar);

  if Application.MessageBox('Gerçekten kur deðiþim iþlemini yapmak istiyor musunuz?',PChar(msj),MB_YESNO+MB_ICONQUESTION) = ID_NO then
  begin
    DataMod.ReleaseQuery(sec);
    DataMod.ReleaseQuery(ekle);
    DataMod.ReleaseQuery(deleteKur);
    kodlar.Free;
    exit;
  end;
//****************************************************************************//
  for i := 0 to kodlar.Count - 1 do
  begin
    with sec do
    begin
      SQL.Clear;
      strSQL := 'SELECT TARIH,DOVKOD,ALISKUR,SATISKUR,EF_ALISKUR,EF_SATISKUR FROM DOVKUR WHERE TARIH = '+ SQL_Tarih(max_tar)+ ' AND DOVKOD = ' + SQL_Katar(kodlar[i]);
      SQL.Add(strSQL);
      Active := True;
      with ekle do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO DOVKUR(DOVKOD,TARIH,ALISKUR,SATISKUR,EF_ALISKUR,EF_SATISKUR) VALUES (');
        SQL.Add(SQL_Katar(kodlar[i])+','+SQL_Tarih(Takvim.Date)+','+SQL_Para(sec.fieldbyname('ALISKUR').AsCurrency)+',');
        SQL.Add(SQL_Para(sec.fieldbyname('SATISKUR').AsCurrency)+','+SQL_Para(sec.fieldbyname('EF_ALISKUR').AsCurrency)+',');
        SQL.Add(SQL_Para(sec.fieldbyname('EF_SATISKUR').AsCurrency)+')');
        Execute;
        dmLOGGER.Write2Log(0,0,0,0,1,ekle.SQL.Text,'DOVKUR');
      end;//end ekle
    end;//end sec
  end;//end for
//****************************************************************************//
  if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) then
  begin
    with ekle do
    begin
      SQL.Clear;
      SQL.Add('INSERT INTO DOVKUR(DOVKOD,TARIH,ALISKUR,SATISKUR,EF_ALISKUR,EF_SATISKUR) VALUES (');
      SQL.Add(SQL_Katar('YTL')+','+SQL_Tarih(Takvim.Date)+','+SQL_Katar('1')+',');
      SQL.Add(SQL_Katar('1')+','+SQL_Katar('1')+',');
      SQL.Add(SQL_Katar('1')+')');
      Execute;
      dmLOGGER.Write2Log(0,0,0,0,1,ekle.SQL.Text,'DOVKUR');
      Active := False;
    end;
  end;
  DataMod.ReleaseQuery(sec);
  DataMod.ReleaseQuery(ekle);
  DataMod.ReleaseQuery(deleteKur);
  kodlar.Free;
  qryDov_Kur.Refresh;
end;//end begin;


procedure TfrmDovKart.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmDovKart.qryDov_KurBeforeDelete(IB_Dataset: TIB_Dataset);
begin
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;


procedure TfrmDovKart.qryDov_KurAfterPost(IB_Dataset: TIB_Dataset);
begin
  dmLOGGER.dbaMain_StopMonitoringWrite2log('DOVKUR,',0,0,0,0,1,'DOVKUR');
end;

procedure TfrmDovKart.qryDov_KurBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if ((qryDov_Kur.FieldByName('ALISKUR').AsFloat =  0) or
      (qryDov_Kur.FieldByName('SATISKUR').AsFloat =  0)  or
      (qryDov_Kur.FieldByName('EF_ALISKUR').AsFloat =  0) or
      (qryDov_Kur.FieldByName('EF_SATISKUR').AsFloat =  0)  ) then
  begin
    Application.MessageBox('Kur Deðeri "0" Olamaz','Dikkat',MB_ICONWARNING);
    Abort;
  end;
  dmLOGGER.dbaMain_StartMonitoring;
end;

end.
