unit ufrmUrunSDLG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, Grids, ExtCtrls, Buttons, IB_Grid, IB_Components;

type
  TfrmUrunSDLG = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    txtVeri: TEdit;
    btnAra: TButton;
    cboAlanAdi: TComboBox;
    chkGrup: TCheckBox;
    qryUrun: TIB_Query;
    qryUrun_Grup: TIB_Query;
    dtsUrun: TIB_DataSource;
    dtsUrun_Grup: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    IB_Grid2: TIB_Grid;
    btnTamam: TBitBtn;
    btnIptal: TBitBtn;
    procedure UrunSec;
    procedure FormShow(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure btnIptalClick(Sender: TObject);
    procedure txtVeriKeyPress(Sender: TObject; var Key: Char);
    procedure wwDBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure wwDBGrid2DblClick(Sender: TObject);
    function Form_Open(Menu:Boolean;var URUN_KOD:String;var URUN_AD:String;KOMPLEX:Boolean):Boolean;overload;

    procedure IB_Grid2KeyPress(Sender: TObject; var Key: Char);
    procedure chkGrupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboAlanAdiEnter(Sender: TObject);
    procedure cboAlanAdiExit(Sender: TObject);
    procedure txtVeriEnter(Sender: TObject);
    procedure txtVeriExit(Sender: TObject);
    procedure chkGrupEnter(Sender: TObject);
    procedure chkGrupExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtVeriKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
    prv_Komplex:Boolean;
    prv_Urun_Tip:String;

  public
    { Public declarations }
    Kontrol : Boolean;//False:CAriID=0 iptalle cýkýldý true ise tamam ile cýkýldý
    function Form_Open(Urun_Tip:String;Menu:Boolean;var URUN_KOD:String;var URUN_AD:String;KOMPLEX:Boolean):Boolean;overload;
  end;

var
  frmUrunSDLG: TfrmUrunSDLG;

implementation

uses unDataMod,unFunc;
{$R *.DFM}

function TfrmUrunSDLG.Form_Open(Menu:Boolean;Var URUN_KOD:String;VAR URUN_AD:String;KOMPLEX:Boolean):Boolean;
begin
  Application.CreateForm(TfrmUrunSDLG, frmUrunSDLG);
  with frmUrunSDLG do
  begin
    prv_Komplex := KOMPLEX;
    ShowModal;
    if not Kontrol then
    begin
      URUN_KOD:='';
      Result := False;
    end
    else
    begin
      URUN_KOD := qryUrun.FieldByName('URUN_KOD').AsString;
      URUN_AD := qryUrun.FieldByName('URUN_AD').AsString;
      Result := True;
    end;
    Release;
  end;
end;

function TfrmUrunSDLG.Form_Open(Urun_Tip:String;Menu:Boolean;Var URUN_KOD:String;VAR URUN_AD:String;KOMPLEX:Boolean):Boolean;
begin
  Application.CreateForm(TfrmUrunSDLG, frmUrunSDLG);

  with frmUrunSDLG do
  begin
    prv_Komplex := KOMPLEX;
    prv_Urun_Tip :=Urun_Tip;
    ShowModal;
    if not Kontrol then
    begin
      URUN_KOD:='';
      Result := False;
    end
    else
    begin
      URUN_KOD := qryUrun.FieldByName('URUN_KOD').AsString;
      URUN_AD := qryUrun.FieldByName('URUN_AD').AsString;
      Result := True;
    end;
    Release;
  end;
end;


procedure TfrmUrunSDLG.UrunSec ;
var
  strSQL:String;
begin
   if (chkGrup.Checked = True ) then
   begin
     strSQL := 'SELECT  URUN.URUN_KOD'
             + ',URUN.URUN_AD'
             + ',URUN.DOVKOD'
             + ',URUN.BIRIMFIY'
             + ',URUN.OLCUBIRIM'
             + ',URUN.HIZMET '
             + ', MIKTAR_BORC'
             + ', MIKTAR_ALACAK'
             + ' FROM URUN INNER JOIN URUN_GRUP_UYE ON (URUN.URUN_KOD = URUN_GRUP_UYE.URUN_KOD) '
             + ' WHERE URUN_GRUP_UYE.URUN_GRUP_KOD= '+ SQL_Katar(qryUrun_Grup.FieldByName('URUN_GRUP_KOD').AsString);
     if (trim(txtVERI.text) <> '') then //Burak Deðiþtirdi
     begin
       case cboAlanAdi.ItemIndex  of
       0 : strSQL := strSQL + ' AND URUN.URUN_KOD LIKE' + SQL_Katar(txtVeri.Text + '%');
       1 : strSQL := strSQL + ' AND URUN.URUN_AD LIKE' + SQL_Katar(txtVeri.Text + '%');
       end ;
     end;


   end
   else
   begin
     strSQL := 'SELECT  URUN_KOD'
             + ',URUN_AD'
             + ',URUN.DOVKOD'
             + ',URUN.BIRIMFIY'
             + ',URUN.OLCUBIRIM'
             + ',URUN.HIZMET'
             + ', MIKTAR_BORC'
             + ', MIKTAR_ALACAK FROM URUN ';

     if (trim(txtVERI.text) <> '') then
     begin
       case cboAlanAdi.ItemIndex  of
       0 : strSQL := strSQL + ' WHERE URUN_KOD LIKE' + SQL_Katar(txtVeri.Text + '%');
       1 : strSQL := strSQL + ' WHERE URUN_AD LIKE' + SQL_Katar(txtVeri.Text + '%');
       end;//end case
     end
     else
     begin
       strSQL := strSQL + 'WHERE URUN_TIP<>'''' ';

     end;

   end;

       if  prv_Urun_Tip='M' then
        strSQL := strSQL + '  AND URUN_TIP in (' +SQL_Katar('M') + ',' + SQL_Katar('Y') + ')';
       if  prv_Urun_Tip='H' then
       strSQL := strSQL + '  AND (URUN_TIP= ' + SQL_Katar('H')+ 'or URUN_TIP= ' + SQL_Katar('Y')+')';



   {
      if frmUrunSDLG.prv_Komplex = True Then
      if not chkGrup.Checked=False then  //Burak Deðiþtirdi
        strSQL := strSQL + ' And URUN.KOMPLEX=1'
      else
        strSQL := strSQL + ' and URUN.KOMPLEX=0';
   }
   with qryUrun do
   begin
     Active := False;
     SQL.Clear;
     SQL.Add (strSQL);
     Active := True;
   end;
end;

procedure TfrmUrunSDLG.FormShow(Sender: TObject);
begin
  qryUrun_Grup.Active := False;
  qryUrun.Active := False;
  Kontrol := False;
  qryUrun_Grup.Active := True;
  cboAlanAdi.ItemIndex := 1;
end;

procedure TfrmUrunSDLG.btnAraClick(Sender: TObject);
begin
  UrunSec ;
  if not ((qryUrun.Eof) And (qryUrun.Bof)) then
  begin
    //IB_Grid2.SetFocus;
    txtVeri.SetFocus;
  end;
end;

procedure TfrmUrunSDLG.btnTamamClick(Sender: TObject);
begin
  if (qryUrun.Active = True) Then
  begin
    Kontrol := True;
    Close;
  end
  else
  begin
    case Application.MessageBox('Arama yapmadýnýz forma geri dönmek için YES Cýkmak için NO','Dikkat',MB_YESNO) of
    7:
      begin
        Kontrol := False;
        Close;
      end;
    end;
  end;
end;

procedure TfrmUrunSDLG.btnIptalClick(Sender: TObject);
begin
  Kontrol := False;
  Close;
end;

procedure TfrmUrunSDLG.txtVeriKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);

//  if key=#13 then btnAraClick(Self);
  if key=#13 then
  begin
  btnTamamClick(Self);
  Exit;
  end;

  btnAraClick(Self);
end;

procedure TfrmUrunSDLG.wwDBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
  begin
    Kontrol :=True;
    Close;
  end;
end;

procedure TfrmUrunSDLG.wwDBGrid2DblClick(Sender: TObject);
begin
  btnAraClick(self);
end;

procedure TfrmUrunSDLG.IB_Grid2KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 Then
  begin
    btnTamamClick(Self);
  end;
end;

procedure TfrmUrunSDLG.chkGrupClick(Sender: TObject);
begin
  if chkGrup.Checked Then IB_Grid1.Enabled := True  else IB_Grid1.Enabled := False;
end;

procedure TfrmUrunSDLG.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmUrunSDLG);
  frmUrunSDLG.qryUrun.FieldByName('BIRIMFIY').DisplayFormat := glb_DOV_FIELD_PF;
end;

procedure TfrmUrunSDLG.cboAlanAdiEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrunSDLG.cboAlanAdiExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmUrunSDLG.txtVeriEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrunSDLG.txtVeriExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmUrunSDLG.chkGrupEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrunSDLG.chkGrupExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmUrunSDLG.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then btnIptalClick(Self);
end;

procedure TfrmUrunSDLG.txtVeriKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key=Vk_Up then
     begin
          if not qryUrun.Bof then
          qryUrun.Prior;
     end;
     if Key=Vk_Down then
     begin
          if not qryUrun.Eof then
          qryUrun.Next;
     end;
end;

end.
