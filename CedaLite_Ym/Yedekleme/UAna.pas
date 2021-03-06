unit UAna;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles,ShellAPI, ShlObj, Buttons,
  IB_Components, MPlayer, Ib_Session;

type
  TForm1 = class(TForm)
    Od: TOpenDialog;
    txtYerel: TEdit;
    Button1: TButton;
    txtAg: TEdit;
    Button2: TButton;
    rg_Aktarma: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    Button4: TButton;
    Btn_Laptop_Ofis: TBitBtn;
    Btn_Ofis_Laptop: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    IB_Conn: TIB_Connection;
    Query_Dosya: TIB_Query;
    Button5: TButton;
    mp: TMediaPlayer;
    Button6: TButton;
    Lbl_Durum: TLabel;
    Label6: TLabel;
    cb_datacopy: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    procedure Buton_Yenile(a: Integer);
    Function Dosya_Al(Tip:String):Boolean;
    function BrowseDialog(const Title: string;
      const Flag: integer): string;
    function CopyDirectory(Ori, Desti: string): Boolean;
    function GetAppPath: string;
    Function Baglanti_Kontrol_Et(Tip:String):Boolean;
    procedure Hata;
    procedure Bitti;
    procedure baglanti_Kontrol;
    { Private declarations }
  public

  AktarIni: TIniFile;
  HostYerelIni: TIniFile;
  HostAgIni: TIniFile;
  Yerel_Main_Dosya:String;
  Ag_Main_Dosya:String;
  Yerel_Log_Dosya:String;
  Ag_Log_Dosya:String;

  Yerel_Log_Dosya_Adi:String;
  Ag_Log_Dosya_Adi:String;

  Yerel_Main_Dosya_Adi:String;
  Ag_Main_Dosya_Adi:String;

  Dosya_Listesi:TStringList;
  Dosya_Listesi_Hedef:TStringList;

  dos_ad,user_name,password,servername:String;
  local_con:Integer;

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

Uses Un_Kul_Con_Fb;

{$R *.dfm}

Function TForm1.CopyDirectory(Ori, Desti : string):Boolean;
var
 Files : integer;
 FOri, FDesti : string;
 ok : boolean;
 Search : TSearchRec;
 Say:Integer;
begin
  Say:=0;

  Result:=True;
  Files := FindFirst(Ori + '\*.*', faAnyFile, Search);


  while Files = 0 do
  begin
    if Search.Attr <> faDirectory then
    begin
        //if  Search.Name<>'MAIN.FDB' then
        if Dosya_Listesi.IndexOf(Search.Name)>-1 then
        begin
           FOri := Ori + '\' + Search.Name;
           FDesti := Desti + '\' + Search.Name;
           ok := CopyFile(PChar(FOri),PChar(FDesti),false);
           if not ok then
           begin
             Hata;
             ShowMessage('Dosya Kopyalanamad?: '+Search.Name);
             Result:=False;
           end
           else
           Inc(Say);

       end;
      //ShowMessage('Hedef Dizin Bulunamad?');
    end
    else
    begin
      {//alt dizin kopyalama
      if (Search.Name <> '.') and (Search.Name <> '..') then
      begin
        ok := CreateDir(Desti + '\' + Search.Name);
        if not ok then
        begin
          ShowMessage('Dosya Kopyalanamad?: '+ Search.Name);
          Result:=False;
        end
        else CopyDirectory(Ori+'\'+Search.Name,Desti+'\'+Search.Name);
      end;
      }
    end;
    Files := FindNext(Search);
  end;

  if Say=0 then
  begin
     Hata;
     ShowMessage('Hi? Dosya Kopyalanamad?: '+ Search.Name);
     Result:=False;
  end;

  FindClose(Search);

end;

function TForm1.BrowseDialog(const Title: string; const Flag: integer): string;
var
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of char;
  TempPath : array[0..MAX_PATH] of char;
begin
  Result:='';
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  with BrowseInfo do
  begin
    hwndOwner := Application.Handle;
    pszDisplayName := @DisplayName;
    lpszTitle := PChar(Title);
    ulFlags := Flag;
  end;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then
  begin
    SHGetPathFromIDList(lpItemID, TempPath);
    Result := TempPath;
    Result := Result;
    //Result := Result + '\';
    GlobalFreePtr(lpItemID);
  end;
end;

function TForm1.GetAppPath: string;
begin
  Result := ExtractFilePath(Application.ExeName);
  if Result[Length(Result)] <> '\' then
   Result := Result + '\';
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  a,Bag_Say:Integer;
begin
  Dosya_Listesi:=TStringList.Create;


  HostAgIni := TIniFile.Create(GetAppPath + 'Host_Ag.ini');
  HostYerelIni := TIniFile.Create(GetAppPath + 'Host_Yerel.ini');
  AktarIni := TIniFile.Create(GetAppPath + 'Aktar.ini');

  baglanti_Kontrol;  

end;

procedure TForm1.baglanti_Kontrol;
var
  a,Bag_Say:Integer;
begin

  Yerel_Main_Dosya:=HostYerelIni.ReadString('MainDB', 'DB_PATH', '');
  Ag_Main_Dosya:=HostAgIni.ReadString('MainDB', 'DB_PATH', '');

  Yerel_Main_Dosya_Adi:=ExtractFileName(Yerel_Main_Dosya);
  Ag_Main_Dosya_Adi:=ExtractFileName(Ag_Main_Dosya);

  Yerel_Log_Dosya:=HostYerelIni.ReadString('LOG_DB', 'DB_PATH', '');
  Ag_Log_Dosya:=HostAgIni.ReadString('LOG_DB', 'DB_PATH', '');

  Yerel_Log_Dosya_Adi:=ExtractFileName(Yerel_Log_Dosya);
  Ag_Log_Dosya_Adi:=ExtractFileName(Ag_Log_Dosya);

////////////////main kontrol //////////////////

  user_name:=HostYerelIni.ReadString('MainDB', 'USER', '');
  password:=HostYerelIni.ReadString('MainDB', 'PASS_WORD', '');
  servername:=HostYerelIni.ReadString('MainDB', 'SERVER', '');
  local_con:=HostYerelIni.ReadInteger('MainDB', 'CONN_LOCAL', 0);

  if local_con=1 then
      dos_ad:=Yerel_Main_Dosya else
      dos_ad:=servername+':'+Yerel_Main_Dosya;

  Bag_Say:=kul_bul(user_name, password, dos_ad);
  if (Bag_Say>1) or (Bag_Say=0) then
  begin
      Application.MessageBox(Pchar(dos_ad+' A??k Data var ??lem Yap?lmayacak, A??k Programlar? Kapat?n?z'),'Bilgi',MB_OK);
      //Exit;
      Halt;
  end;

  user_name:=HostAgIni.ReadString('MainDB', 'USER', '');
  password:=HostAgIni.ReadString('MainDB', 'PASS_WORD', '');
  servername:=HostAgIni.ReadString('MainDB', 'SERVER', '');
  local_con:=HostAgIni.ReadInteger('MainDB', 'CONN_LOCAL', 0);

  if local_con=1 then
      dos_ad:=Ag_Main_Dosya
  else
      dos_ad:=servername+':'+Ag_Main_Dosya;

  Bag_Say:=kul_bul(user_name, password, dos_ad);
  if (Bag_Say>1) or (Bag_Say=0) then
  begin
      Application.MessageBox(Pchar(dos_ad+' A??k Data var ??lem Yap?lmayacak, A??k Programlar? Kapat?n?z'),'Bilgi',MB_OK);
      //Exit;
      Halt;
  end;
////////////////main kontrol son//////////////////




////////////////log kontrol //////////////////

  user_name:=HostYerelIni.ReadString('LOG_DB', 'USER', '');
  password:=HostYerelIni.ReadString('LOG_DB', 'PASS_WORD', '');
  servername:=HostYerelIni.ReadString('LOG_DB', 'SERVER', '');
  local_con:=HostYerelIni.ReadInteger('LOG_DB', 'CONN_LOCAL', 0);

  if local_con=1 then
      dos_ad:=Yerel_Log_Dosya
  else
      dos_ad:=servername+':'+Yerel_Log_Dosya;

  Bag_Say:=kul_bul(user_name, password, dos_ad);
  if (Bag_Say>1) or (Bag_Say=0) then
  begin
      Application.MessageBox(Pchar(dos_ad+' A??k Data var ??lem Yap?lmayacak, A??k Programlar? Kapat?n?z'),'Bilgi',MB_OK);
      //Exit;
      Halt;
  end;

  user_name:=HostAgIni.ReadString('LOG_DB', 'USER', '');
  password:=HostAgIni.ReadString('LOG_DB', 'PASS_WORD', '');
  servername:=HostAgIni.ReadString('LOG_DB', 'SERVER', '');
  local_con:=HostAgIni.ReadInteger('LOG_DB', 'CONN_LOCAL', 0);

  if local_con=1 then
      dos_ad:=Ag_Log_Dosya else
      dos_ad:=servername+':'+Ag_Log_Dosya;

  Bag_Say:=kul_bul(user_name, password, dos_ad);
  if (Bag_Say>1) or (Bag_Say=0) then
  begin
      Application.MessageBox(Pchar(dos_ad+' A??k Data var ??lem Yap?lmayacak, A??k Programlar? Kapat?n?z'),'Bilgi',MB_OK);
      //Exit;
      Halt;
  end;
////////////////log kontrol son//////////////////

  txtYerel.Text    := AktarIni.ReadString('Ceda', 'YerelDb', '');
  txtAg.Text       := AktarIni.ReadString('Ceda', 'AnaMakDb', '');
  a                := AktarIni.ReadInteger('Ceda', 'Son_Aktarma', 0);

  {
  if a=0 then  rg_Aktarma.ItemIndex:=1
  else  rg_Aktarma.ItemIndex:=0;
  }

  Buton_Yenile(a);
end;

procedure TForm1.Buton_Yenile(a:Integer);
begin
  if a=0 then
  begin
    Btn_Laptop_Ofis.Font.Color:= ClRed;
    Btn_Ofis_Laptop.Font.Color:= clWindowText;
    Lbl_Durum.Caption:='?u An Laptopdas?n?z';
    Lbl_Durum.Update;
  end
  else
  begin
    Btn_Laptop_Ofis.Font.Color:= clWindowText;
    Btn_Ofis_Laptop.Font.Color:= ClRed;
    Lbl_Durum.Caption:='?u An Ofistesiniz';
    Lbl_Durum.Update;
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  AktarIni.WriteString('Ceda', 'YerelDb', Trim(txtYerel.Text));
  AktarIni.WriteString('Ceda', 'AnaMakDb', Trim(txtAg.Text));
  AktarIni.WriteInteger('Ceda', 'Son_Aktarma', 0 );
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AktarIni.Free;
  HostAgIni.Free;
  HostYerelIni.Free;
  Dosya_Listesi.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
   a,b:Integer;
   ok:Boolean;
begin
Screen.Cursor:=CrHourGlass;

  Dosya_Listesi.Clear;

  if cb_datacopy.checked then
  begin

     if Sender =  Btn_Laptop_Ofis then
     begin
          ok := CopyFile(PChar(GetAppPath+'Host_Ag.Ini'),PChar(GetAppPath+'Host.Ini'),false);
          if not ok then
          begin
            Hata;
            ShowMessage('Host ini Dosyasi Kopyalanamad? ');
            Application.MessageBox('Aktarmada Hatalar Olu?tu Yeniden Deneyiniz','Bilgi',MB_OK);
            Screen.Cursor:=CrDefault;
            Exit;
          end;

          Bitti;
          AktarIni.WriteInteger('Ceda', 'Son_Aktarma',1);
          Buton_Yenile(1);
          Application.MessageBox('Aktarma Tamamland?','Bilgi',MB_OK);
          Screen.Cursor:=CrDefault;
          Exit;

     end;

     if Sender =  Btn_Ofis_Laptop then
     begin
          ok := CopyFile(PChar(GetAppPath+'Host_Yerel.Ini'),PChar(GetAppPath+'Host.Ini'),false);
          if not ok then
          begin
            Hata;
            ShowMessage('Host ini Dosyas? Kopyalanamad? ');
            Application.MessageBox('Aktarmada Hatalar Olu?tu Yeniden Deneyiniz','Bilgi',MB_OK);
            Screen.Cursor:=CrDefault;
            Exit;
          end;

          Bitti;
          AktarIni.WriteInteger('Ceda', 'Son_Aktarma',0);
          Buton_Yenile(0);
          Application.MessageBox('Aktarma Tamamland?','Bilgi',MB_OK);
            Screen.Cursor:=CrDefault;
          Exit;


     end;
  Exit;
  end;

  baglanti_Kontrol;
  try
 // if rg_Aktarma.ItemIndex=0 then
 //
  if Sender =  Btn_Laptop_Ofis then
  if Application.MessageBox('Ana Makinaya Datalar? Aktarmak istiyormusunuz?','Dikkat',MB_YESNO + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDNo then ABORT;

  a:= AktarIni.ReadInteger('Ceda', 'Son_Aktarma', 0);


     //AktarIni.WriteInteger('Ceda', 'Son_Aktarma',rg_Aktarma.ItemIndex );
     //if rg_Aktarma.ItemIndex=0 then
     if Sender =  Btn_Laptop_Ofis then
     begin

        if not Baglanti_Kontrol_Et('Yerel_Ag') then
        begin
           Hata;
           Application.MessageBox('Aktarmada Hatalar Olu?tu Yeniden Deneyiniz','Bilgi',MB_OK);
           IB_Conn.Connected:=False;
            Screen.Cursor:=CrDefault;
           Exit;
        end;

        Dosya_Listesi.Add(Yerel_Log_Dosya_Adi);

        //for b:=0 to Dosya_Listesi.Count-1 do
        //begin
             //ok := CopyFile(PChar(GetAppPath+'Host_Ag.Ini'),PChar(GetAppPath+'Host.Ini'),false);
             //if not ok then
            // begin
            //   ShowMessage('Host ini Dosyasi Kopyalanamad? ');
            //   Application.MessageBox('Aktarmada Hatalar Olu?tu Yeniden Deneyiniz','Bilgi',MB_OK);
            // end;

        //end;
        if CopyDirectory(txtYerel.Text,txtAg.Text)=True then
        begin
          ok := CopyFile(PChar(GetAppPath+'Host_Ag.Ini'),PChar(GetAppPath+'Host.Ini'),false);
          if not ok then
          begin
            Hata;
            ShowMessage('Host ini Dosyasi Kopyalanamad? ');
            Application.MessageBox('Aktarmada Hatalar Olu?tu Yeniden Deneyiniz','Bilgi',MB_OK);
            IB_Conn.Connected:=False;
            Screen.Cursor:=CrDefault;
            Exit;
          end;

          Bitti;
          AktarIni.WriteInteger('Ceda', 'Son_Aktarma',1);
          Buton_Yenile(1);
          Application.MessageBox('Aktarma Tamamland?','Bilgi',MB_OK);
          IB_Conn.Connected:=False;
            Screen.Cursor:=CrDefault;
          Exit;
        end
        else
        begin
          Hata;
          Application.MessageBox('Aktarmada Hatalar Olu?tu Yeniden Deneyiniz','Bilgi',MB_OK);
            Screen.Cursor:=CrDefault;
          Exit;
        end;



     end;

  //
     //if rg_Aktarma.ItemIndex=1 then
     if Sender =  Btn_Ofis_Laptop then
     begin
        if not Baglanti_Kontrol_Et('Ag_Yerel') then
        begin
           Hata;
           Application.MessageBox('Aktarmada Hatalar Olu?tu Yeniden Deneyiniz','Bilgi',MB_OK);
          IB_Conn.Connected:=False;
            Screen.Cursor:=CrDefault;
           Exit;
        end;

        Dosya_Listesi.Add(Ag_Log_Dosya_Adi);

        if CopyDirectory(txtAg.Text,txtYerel.Text)=True then
        begin
          ok := CopyFile(PChar(GetAppPath+'Host_Yerel.Ini'),PChar(GetAppPath+'Host.Ini'),false);
          if not ok then
          begin
            Hata;
            ShowMessage('Host ini Dosyas? Kopyalanamad? ');
            Application.MessageBox('Aktarmada Hatalar Olu?tu Yeniden Deneyiniz','Bilgi',MB_OK);
            IB_Conn.Connected:=False;
            Screen.Cursor:=CrDefault;
            Exit;
          end;

          Bitti;
          AktarIni.WriteInteger('Ceda', 'Son_Aktarma',0);
          Buton_Yenile(0);
          Application.MessageBox('Aktarma Tamamland?','Bilgi',MB_OK);
            IB_Conn.Connected:=False;
            Screen.Cursor:=CrDefault;
          Exit;
        end
        else
        begin
          Hata;
          Application.MessageBox('Aktarmada Hatalar Olu?tu Yeniden Deneyiniz','Bilgi',MB_OK);
            IB_Conn.Connected:=False;
            Screen.Cursor:=CrDefault;
          exit;
        end;


     end;

  except
     AktarIni.WriteInteger('Ceda', 'Son_Aktarma',a );
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//  if Od.Execute then
  txtYerel.Text:=BrowseDialog('Yerel Data Dizini Se?iniz',BIF_RETURNONLYFSDIRS);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//  if Od.Execute then
  txtAg.Text:=BrowseDialog('Yerel Data Dizini Se?iniz',BIF_RETURNONLYFSDIRS);
end;

function TForm1.Baglanti_Kontrol_Et(Tip:String):Boolean;
begin
  //Yerel_Main_Dosya:='';
  //Ag_Main_Dosya:='';
   Result:=False;
   if Tip='Ag_Yerel' then
   begin

     user_name:=HostYerelIni.ReadString('MainDB', 'USER', '');
     password:=HostYerelIni.ReadString('MainDB', 'PASS_WORD', '');
     servername:=HostYerelIni.ReadString('MainDB', 'SERVER', '');
     local_con:=HostYerelIni.ReadInteger('MainDB', 'CONN_LOCAL', 0);
     IB_Conn.Connected:=False;
     IB_Conn.Server:=servername;
     IB_Conn.Password:=password;
     IB_Conn.Username:=user_name;
     if local_con=0 then
     begin
       IB_Conn.Protocol:=cpTCP_IP;
       IB_Conn.DatabaseName:=servername+':'+Yerel_Main_Dosya;
     end
     else
     begin
       IB_Conn.Protocol:=cpLocal;
       IB_Conn.DatabaseName:=Yerel_Main_Dosya;
     end;
     IB_Conn.Connected:=True;
     if not Dosya_Al('') Then Exit;
     //if Tip='Yerel_Ag' then if not Dosya_Al('Kaynak') Then Exit;
     //if Tip='Ag_Yerel' then if not Dosya_Al('Hedef') Then Exit;

     user_name:=HostAgIni.ReadString('MainDB', 'USER', '');
     password:=HostAgIni.ReadString('MainDB', 'PASS_WORD', '');
     servername:=HostAgIni.ReadString('MainDB', 'SERVER', '');
     local_con:=HostAgIni.ReadInteger('MainDB', 'CONN_LOCAL', 0);
     IB_Conn.Connected:=False;
     IB_Conn.Server:=servername;
     IB_Conn.Password:=password;
     IB_Conn.Username:=user_name;
     if local_con=0 then
     begin
       IB_Conn.Protocol:=cpTCP_IP;
       IB_Conn.DatabaseName:=servername+':'+Ag_Main_Dosya;
     end
     else
     begin
       IB_Conn.Protocol:=cpLocal;
       IB_Conn.DatabaseName:=Ag_Main_Dosya;
     end;
     IB_Conn.Connected:=True;
     if not Dosya_Al('') Then Exit;
     //if Tip='Yerel_Ag' then if not Dosya_Al('Hedef') Then Exit;
     //if Tip='Ag_Yerel' then if not Dosya_Al('Kaynak') Then Exit;
   end;

   if Tip='Yerel_Ag' then
   begin
     user_name:=HostAgIni.ReadString('MainDB', 'USER', '');
     password:=HostAgIni.ReadString('MainDB', 'PASS_WORD', '');
     servername:=HostAgIni.ReadString('MainDB', 'SERVER', '');
     local_con:=HostAgIni.ReadInteger('MainDB', 'CONN_LOCAL', 0);
     IB_Conn.Connected:=False;
     if local_con=0 then
     begin
       IB_Conn.Protocol:=cpTCP_IP;
       IB_Conn.DatabaseName:=servername+':'+Ag_Main_Dosya;
     end
     else
     begin
       IB_Conn.Protocol:=cpLocal;
       IB_Conn.DatabaseName:=Ag_Main_Dosya;
     end;
     IB_Conn.Server:=servername;
     IB_Conn.Password:=password;
     IB_Conn.Username:=user_name;
     IB_Conn.Connected:=True;
     if not Dosya_Al('') Then Exit;

     user_name:=HostYerelIni.ReadString('MainDB', 'USER', '');
     password:=HostYerelIni.ReadString('MainDB', 'PASS_WORD', '');
     servername:=HostYerelIni.ReadString('MainDB', 'SERVER', '');
     local_con:=HostYerelIni.ReadInteger('MainDB', 'CONN_LOCAL', 0);
     IB_Conn.Connected:=False;
     IB_Conn.Server:=servername;
     IB_Conn.Password:=password;
     IB_Conn.Username:=user_name;
     if local_con=0 then
     begin
       IB_Conn.Protocol:=cpTCP_IP;
       IB_Conn.DatabaseName:=servername+':'+Yerel_Main_Dosya;
     end
     else
     begin
       IB_Conn.Protocol:=cpLocal;
       IB_Conn.DatabaseName:=Yerel_Main_Dosya;
     end;
     IB_Conn.Connected:=True;
     if not Dosya_Al('') Then Exit;

   end;

   Result:=True;

end;

function TForm1.Dosya_Al(Tip:String):Boolean;
var
 dos_ad:String;
 Bag_Say:Integer;

begin
     Dosya_Listesi.Clear;
     Result:=True;
     try

     Query_Dosya.Active:=False;
     Query_Dosya.SQL.Clear;
     Query_Dosya.SQL.Add('Select CONN_LOCAL,SERVER_NAME,DB_PATH,USER_NAME,PASS_WORD from TERMS');
     Query_Dosya.Active:=True;

     While not Query_Dosya.Eof do
     begin

          if Query_Dosya.fieldbyName('CONN_LOCAL').AsInteger=1 then
          begin
               dos_ad:=Query_Dosya.fieldbyName('DB_PATH').AsString;
          end
          else
          begin
               dos_ad:=
               Query_Dosya.fieldbyName('SERVER_NAME').AsString+':'+
               Query_Dosya.fieldbyName('DB_PATH').AsString;
          end;

          Bag_Say:=kul_bul(Query_Dosya.fieldbyName('USER_NAME').AsString,
          Query_Dosya.fieldbyName('PASS_WORD').AsString,
          dos_ad);

          if (Bag_Say>1) or (Bag_Say=0) then
          begin
              Result:=False;
              hata;
              Application.MessageBox('A??k Data var ??lem Yap?lmayacak, A??k Programlar? Kapat?n?z','Bilgi',MB_OK);
              Exit;
          end;

    {      if Tip='Kaynak' then
          Dosya_Listesi.Add(ExtractFileName(Query_Dosya.fieldbyName('DB_PATH').AsString));

          if Tip='Hedef' then
          Dosya_Listesi_Hedef.Add(ExtractFileName(Query_Dosya.fieldbyName('DB_PATH').AsString));
    }

          Dosya_Listesi.Add(ExtractFileName(Query_Dosya.fieldbyName('DB_PATH').AsString));

          Query_Dosya.Next;
     end;

    {
          if Tip='Kaynak' then
          Dosya_Listesi.Add(ExtractFileName(Query_Dosya.fieldbyName('DB_PATH').AsString));

          if Tip='Hedef' then
          Dosya_Listesi_Hedef.Add(ExtractFileName(Query_Dosya.fieldbyName('DB_PATH').AsString));
    }
    except
       Application.MessageBox('Dosya Listesi Al?namad?','Bilgi',MB_OK);
       Hata;
       Result:=False;
    end;
end;




procedure TForm1.Button5Click(Sender: TObject);
begin
  ShowMessage(ExtractFileName('s:\sgfsdf\ff.rtytyy'));
end;

procedure TForm1.Hata;
begin
     try
     mp.FileName:=GetAppPath+'Durma.wav';
     mp.Open;
     mp.Play;
     except
     end;
end;

procedure TForm1.Bitti;
begin
     try
     mp.FileName:=GetAppPath+'Bildir.wav';
     mp.Open;
     mp.Play;
     except
     end;
end;


procedure TForm1.Button6Click(Sender: TObject);
begin
     mp.FileName:=GetAppPath+'Durma.wav';
     mp.Open;
     mp.Play;

end;

end.
