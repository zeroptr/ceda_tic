unit ufrmSirketTanim;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, IB_Controls, StdCtrls, Mask, IB_Components, IB_UpdateBar,
  IB_NavigationBar, Buttons, ExtDlgs;

type
  Tfrm_Sirket_Tanim = class(TForm)
    Panel1: TPanel;
    qry_Sirket: TIB_Query;
    dts_Sirket: TIB_DataSource;
    IB_Edit3: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit8: TIB_Edit;
    edt_Pk: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    IB_Image1: TIB_Image;
    IB_UpdateBar1: TIB_UpdateBar;
    edt_Ver_No: TIB_Edit;
    btnExit: TBitBtn;
    Button1: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    IB_Edit2: TIB_Edit;
    IB_Edit1: TIB_Edit;
    IB_Edit9: TIB_Edit;
    IB_Edit14: TIB_Edit;
    Button2: TButton;
    IB_CheckBox1: TIB_CheckBox;
    function Form_Open(Menu: Boolean;Islem:Byte): Integer;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit3Enter(Sender: TObject);
    procedure IB_Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure btnExitClick(Sender: TObject);
    procedure qry_SirketBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure IB_Edit3Exit(Sender: TObject);
    procedure qry_SirketBeforePost(IB_Dataset: TIB_Dataset);
    procedure edt_Ver_NoKeyPress(Sender: TObject; var Key: Char);
    procedure edt_Ver_NoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure edt_PkKeyPress(Sender: TObject; var Key: Char);
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure qry_SirketAfterInsert(IB_Dataset: TIB_Dataset);
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
  public
    { Public declarations }
  end;
const cns_muhasebe = 19;
var
  frm_Sirket_Tanim: Tfrm_Sirket_Tanim;

implementation

uses unDataMod,unFunc;
{$R *.DFM}


function Tfrm_Sirket_Tanim.Form_Open(Menu: Boolean;Islem:Byte): Integer;
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_muhasebe,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if (not local_can_update) and (not local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Application.CreateForm(Tfrm_Sirket_Tanim, frm_Sirket_Tanim);
//****************************************************************************//
  with frm_Sirket_Tanim do
  begin
    qry_Sirket.ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
    qry_Sirket.Active := True;
    case Islem of
    0:qry_Sirket.Append;
    1:qry_Sirket.Edit;
    end;
    ShowModal;
    qry_Sirket.Active := False;
    Release;
  end;
//****************************************************************************//
end;

procedure Tfrm_Sirket_Tanim.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
  if key = #27 then
  begin
    if btnExit.Enabled then btnExitClick(Self);
  end;
end;

procedure Tfrm_Sirket_Tanim.IB_Edit3Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure Tfrm_Sirket_Tanim.IB_Edit3KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure Tfrm_Sirket_Tanim.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Sirket_Tanim.qry_SirketBeforeDelete(IB_Dataset: TIB_Dataset);
begin
  if not Form_Before_Delete then Abort;
  if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then Abort;
end;

procedure Tfrm_Sirket_Tanim.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  if dts_Sirket.State in [dssEDIT,dssINSERT] then
  begin
    case Application.MessageBox('Yaptýðýnýz deðiþiklikleri kaydetmek istiyor musunuz?','Dikkat',MB_YESNOCANCEL+ MB_ICONQUESTION ) of
      ID_YES: qry_Sirket.Post;
      ID_NO : qry_Sirket.Cancel;
      ID_CANCEL : Abort;
    end;
  end;
end;

procedure Tfrm_Sirket_Tanim.Button1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute<>False then qry_Sirket.FieldByName('LOGO').LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure Tfrm_Sirket_Tanim.IB_Edit3Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;


procedure Tfrm_Sirket_Tanim.qry_SirketBeforePost(IB_Dataset: TIB_Dataset);
//eser þahin
//22.10.2002
begin
  if not Form_Before_Post then
  begin
    Abort;
  end;
end;

procedure Tfrm_Sirket_Tanim.edt_Ver_NoKeyPress(Sender: TObject;  var Key: Char);
//eser þahin
//22.10.2002
//vergi numarasý alaný üzerinde iken klavyeden space tuþuna basýldýgýnda
//tuþun algýlanmamasýný saðlýyor
//ve basýlan tuþ rakam deðilse yine tuþun algýlanmamasýný saðlýyor.
begin
  if (Length(Trim(Key)))=0 then Key := #0;
  if isDigit(Key)<>True then Key := #0;
end;

procedure Tfrm_Sirket_Tanim.edt_Ver_NoKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
//eser þahin
//22.10.2002
//aþaðýdaki kod vergi numarasý tanýmlanýrken delete tuþuna basýlarak
//üzerinde bulunulan degerin silinmemesini saðlýyor.
begin
  if Key=VK_DELETE then
  begin
    Key := 0;
  end;
end;

procedure Tfrm_Sirket_Tanim.edt_PkKeyPress(Sender: TObject; var Key: Char);
begin
  if isDigit(Key)<>True then Key := #0;
end;

function Tfrm_Sirket_Tanim.Form_Before_Delete: Boolean;
begin
  Result := True;
end;

function Tfrm_Sirket_Tanim.Form_Before_Post: Boolean;
//vergi numarasýnýn uzunluðunu kontrol ediyor.Aslýnda boþluk karakteri ile birlikte
//12 karakter yaptýðý için burada 10 karakter yerine 12 karakter kontrol ediyor
//kullanýcý aslýnda 10 karakter girmeye zorlanýyor.
begin
  Result := False;
  if (Length(Trim(qry_Sirket.FieldByName('VERNO').AsString)))<>12 then
  begin
    edt_Ver_No.SetFocus;
    Application.MessageBox('Vergi Numarasý 10 karakterden oluþmalýdýr.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  Result := True;
end;

procedure Tfrm_Sirket_Tanim.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frm_Sirket_Tanim);
end;

procedure Tfrm_Sirket_Tanim.Button2Click(Sender: TObject);
begin
  qry_Sirket.FieldByName('LOGO').AsString :='';
end;

procedure Tfrm_Sirket_Tanim.qry_SirketAfterInsert(IB_Dataset: TIB_Dataset);
var
  qryTEMP:TIB_Query;
begin
  DataMod.CreateQuery(qryTEMP,Nil,False,DataMod.dbaANA);
  qryTEMP.SQL.Add('SELECT MAX(SIRKET_ID) AS SIR_ID FROM SIRKET');
  qryTEMP.Active := True;
  IB_Dataset.FieldByName('SIRKET_ID').AsInteger := qryTEMP.FieldByName('SIR_ID').AsInteger + 1;
end;

end.
