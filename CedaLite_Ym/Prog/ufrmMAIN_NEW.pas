{$INCLUDE directive.inc}

unit ufrmMAIN_NEW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,IB_Components, IB_Session;

type
  TfrmMAIN_NEW = class(TForm)
    trwMAIN: TTreeView;
    ImageList1: TImageList;
    Panel1: TPanel;
    btnCIKIS: TSpeedButton;
    btnTamam: TBitBtn;
    chkAKTIF_SIRKET: TCheckBox;
    chkAKTIF_DONEM: TCheckBox;
    function Load_trwMAIN : Boolean;
    Function Form_Open(Menu:Boolean):Boolean;
    procedure btnTamamClick(Sender: TObject);
    procedure btnCIKISClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkAKTIF_SIRKETClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    prv_CloseVar:Boolean;
  public
    { Public declarations }

    pbl_CANCEL:Boolean;
  end;
  type
    PMyRec = ^TMyRec;
    TMyRec = record
      SIRKET_ID:INTEGER;
      DONEM_NO:INTEGER;
      DONEM_BAS:TDateTime;
      DONEM_SON:TDateTime;
      DB_PATH:String;
      SERVER_NAME:String;
      CONN_LOCAL:Boolean;
      USER_NAME:String;
      PASS_WORD:String;
      SIRKET_AD:String;
  end;
var
  frmMAIN_NEW: TfrmMAIN_NEW;

implementation

uses unDATAMOD, main, ufrmTERM_FF,unDEKONT_AUT;

{$R *.dfm}

function TfrmMAIN_NEW.Form_Open(Menu:Boolean):Boolean;
begin
   if not Menu then
   begin
     btnCIKIS.Visible := False;
     frmMAIN_NEW.BorderIcons := frmMAIN_NEW.BorderIcons - [biSystemMenu];
     pbl_CANCEL := True;     
   end;
   //pbl_CANCEL := True;
   if not Load_trwMAIN then
   begin
     Result := False;
     exit;
   end
   else
   begin
     frmMAIN_NEW.ShowModal;
     Result := True;
   end;
end;


function TfrmMAIN_NEW.Load_trwMAIN:Boolean;
var
  qrySIRKET,qryTERM:TIB_Query; n1,n2:TTreeNode;
  MyRecPtr: PMyRec;
begin
 Result := False;
 try
   DataMod.CreateQuery(qrySIRKET,nil,False,DataMod.dbaANA);
   DataMod.CreateQuery(qryTERM,nil,False,DataMod.dbaANA);
   with qrySIRKET do
   begin
     qrySIRKET.SQL.Add('SELECT * FROM SIRKET');
     if chkAKTIF_SIRKET.Checked then
     begin
       SQL.Add(' WHERE AKTIF = 1');
     end;

     {if chkAKTIF_SIRKET.Checked then
     begin
       SQL.Add(' WHERE AKTIF = 1 AND');
     end
     else
     begin
       SQL.Add(' WHERE');
     end;
     SQL.Add(' SIRKET_ID IN');
     SQL.Add('(SELECT SIRKETHAK.SIRKET_ID FROM SIRKETHAK');
     SQL.Add('WHERE KULLANICI_ID ='+IntToStr(glb_USER_ID));
     SQL.Add('AND KULLANICI_SID ='+IntToStr(glb_USER_SID)+') ORDER BY SIRKET_ID');}
     
     Open;
   end;
   trwMAIN.Items.Clear;
   if qrySIRKET.RecordCount = 0 then
   begin
     Application.MessageBox('Hiçbir þirkette tanýmlý deðilsiniz.Lütfen sistem yöneticinizle baðlantýya geçiniz.','Dikkat',MB_ICONWARNING);
     Exit;
   end
   else
   begin
     Result := True;
   end;
//****************************************************************************//
   qrySIRKET.First;
   repeat
     n1:=trwMAIN.Items.AddChild(nil,qrySIRKET.FieldByName('SIRKET_AD').AsString);
     n1.ImageIndex := 0;
     n1.SelectedIndex := 0;
     with qryTERM do
     begin
       Close;
       SQL.Clear;
       SQL.Add('SELECT TERMS.DONEM_NO');
       SQL.Add(', TERMS.DONEM_BAS');
       SQL.Add(', TERMS.DONEM_SON');
       SQL.Add(', TERMS.DB_PATH');
       SQL.Add(', TERMS.SERVER_NAME');
       SQL.Add(', TERMS.CONN_LOCAL');
       SQL.Add(', TERMS.USER_NAME');
       SQL.Add(', TERMS.PASS_WORD');
       SQL.Add('FROM TERMS');
       SQL.Add('LEFT OUTER JOIN SIRKET ON (SIRKET.SIRKET_ID = TERMS.SIRKET_ID)');
       SQL.Add('WHERE SIRKET.SIRKET_ID = ' + qrySIRKET.FieldByName('SIRKET_ID').AsString);

{ibo 2008
      SQL.Add('LEFT OUTER JOIN DONEMHAK ON (DONEMHAK.SIRKET_ID = TERMS.SIRKET_ID AND DONEMHAK.DONEM_NO = TERMS.DONEM_NO)');
       SQL.Add('WHERE SIRKET.SIRKET_ID = ' + qrySIRKET.FieldByName('SIRKET_ID').AsString);
       SQL.Add('AND');
       SQL.Add('KULLANICI_ID = ' + inttostr(glb_USER_ID));
       SQL.Add('AND');
       SQL.Add('KULLANICI_SID = ' + inttostr(glb_USER_SID));
       }
       if chkAKTIF_DONEM.Checked then
       begin
          SQL.Add(' AND TERMS.AKTIF = 1 ORDER BY TERMS.DONEM_NO ');
       end else

       SQL.Add(' ORDER BY TERMS.DONEM_NO');

     end;
     qryTERM.Open;
     if qryTERM.RecordCount > 0 then
     begin
       repeat
         New(MyRecPtr);
         MyRecPtr^.SIRKET_ID := qrySIRKET.FieldByName('SIRKET_ID').AsInteger;
         MyRecPtr^.DONEM_NO  := qryTERM.FieldByName('DONEM_NO').AsInteger;
         MyRecPtr^.DONEM_BAS := qryTERM.FieldByName('DONEM_BAS').AsDate;
         MyRecPtr^.DONEM_SON := qryTERM.FieldByName('DONEM_SON').AsDate;
         MyRecPtr^.DB_PATH   := qryTERM.FieldByName('DB_PATH').AsString;
         MyRecPtr^.SERVER_NAME := qryTERM.FieldByName('SERVER_NAME').AsString;
         MyRecPtr^.CONN_LOCAL  := (qryTERM.FieldByName('CONN_LOCAL').AsInteger = 1);
         MyRecPtr^.USER_NAME := qryTERM.FieldByName('USER_NAME').AsString;
         MyRecPtr^.PASS_WORD := qryTERM.FieldByName('PASS_WORD').AsString;
         MyRecPtr^.SIRKET_AD := qrySIRKET.FieldByName('SIRKET_AD').AsString;
         n2 := trwMAIN.Items.AddChild(n1,qryTERM.FieldByName('DONEM_NO').AsString + ' ' + qryTERM.FieldByName('DONEM_BAS').AsString + ' - ' + qryTERM.FieldByName('DONEM_SON').AsString);
         n2.ImageIndex := 1;
         n2.SelectedIndex := 1;
         n2.Data := MyRecPtr;
         qryTERM.Next;
       until qryTERM.Eof;
     end;
     qrySIRKET.Next;
   until qrySIRKET.Eof;
 except
   Application.MessageBox('TfrmMAIN_NEW.Load_trwMAIN: Liste Yükleme Sýrasýnda hata oluþtu','Hata', MB_ICONHAND);
 end;
   DataMod.ReleaseQuery(qrySIRKET);
   DataMod.ReleaseQuery(qryTERM);
end;


procedure TfrmMAIN_NEW.btnTamamClick(Sender: TObject);
var
  node:TTreeNode;
begin
  if trwMAIN.Selected.Level = 0 then Exit;
{  begin
    Application.MessageBox('Dönem seçmediniz.. Lütfen Þirket Altýndan bir dönem seçiniz','Dikkat',MB_ICONINFORMATION);
    Exit;
  end;}
  DataMod.AssignConnProps(DataMod.dbaMain,
                          PMyRec(trwMAIN.Selected.Data)^.CONN_LOCAL,
                          PMyRec(trwMAIN.Selected.Data)^.SERVER_NAME,
                          PMyRec(trwMAIN.Selected.Data)^.DB_PATH,
                          PMyRec(trwMAIN.Selected.Data)^.USER_NAME,
                          PMyRec(trwMAIN.Selected.Data)^.PASS_WORD);

node := trwMAIN.Selected;
glb_SIRKET_ADI:=node.Parent.Text;


  {$IfDef TRANSPORT}
    MainForm.Caption:='Ceda Yazýlým   Kara Nakliyat Programý' + '                 Aktif Þirket :           ' +glb_SIRKET_ADI;
  {$Else}
    MainForm.Caption:='Ceda Yazýlým   ' + '                 Aktif Þirket :           ' +glb_SIRKET_ADI;
  {$EndIf}


// showmessage(node.Parent.Text);
//trwMAIN.SelectionCount;
//trwMAIN.Selected.Index;
//Showmessage(trwMAIN.Items[1].Text);

  try
    glb_DONEM_BAS := PMyRec(trwMAIN.Selected.Data)^.DONEM_BAS;
    glb_DONEM_SON := PMyRec(trwMAIN.Selected.Data)^.DONEM_SON;
    glb_SIRKET_ID := PMyRec(trwMAIN.Selected.Data)^.SIRKET_ID;
    glb_DONEM_NO  := PMyRec(trwMAIN.Selected.Data)^.DONEM_NO;

    glb_Db:=PMyRec(trwMAIN.Selected.Data)^.DB_PATH;
    glb_Pass:=PMyRec(trwMAIN.Selected.Data)^.PASS_WORD;
    glb_User:=PMyRec(trwMAIN.Selected.Data)^.USER_NAME;
    glb_Server:=PMyRec(trwMAIN.Selected.Data)^.SERVER_NAME;
    glb_Con_Tip:=PMyRec(trwMAIN.Selected.Data)^.CONN_LOCAL;

    DataMod.dbaMain.Connect;
  except
    on E: Exception do ShowMessage('Seçtiðiniz Döneme Baðlanýlamadý  '+ E.Message);
  end;

    with MainForm.StatusBar do
    begin
      Panels[2].Text := DateToStr(glb_DONEM_BAS) +  ' - ' + DateToStr(glb_DONEM_SON);
      Panels[5].Text := PMyRec(trwMAIN.Selected.Data)^.SIRKET_AD;
    end;
   {todo:menuý ayarlama kodlarý buradan tasýnararak incelenecek hataya sebep oluyor..}
   // DEKONT_AUT.Menu_ayarla;
   // DataMod.Menu_Kullanni_Rapor_Ekle(MainForm.MainMenu);

  prv_CloseVar := True;
  Close;
end;

procedure TfrmMAIN_NEW.btnCIKISClick(Sender: TObject);
begin
  prv_CloseVar := True;
  if pbl_CANCEL Then Application.Terminate;
  Close;
end;

procedure TfrmMAIN_NEW.FormCreate(Sender: TObject);
begin
  prv_CloseVar := False;
  frmMAIN_NEW.Caption := frmMAIN_NEW.Caption + '  Ver: ' + IntToStr(VER_MAJOR) + '.' + IntToStr(VER_MINOR) + '.'+ IntToStr(VER_RELEASE);
end;

procedure TfrmMAIN_NEW.chkAKTIF_SIRKETClick(Sender: TObject);
begin
  Load_trwMAIN;
end;

procedure TfrmMAIN_NEW.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := prv_CloseVar ;
end;

end.
