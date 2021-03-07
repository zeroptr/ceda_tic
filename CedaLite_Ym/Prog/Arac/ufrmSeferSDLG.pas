unit ufrmSeferSDLG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, IB_Grid, Mask, IB_Controls, StdCtrls, ExtCtrls, ComCtrls,
  Buttons, IB_Components;

type
  TfrmSeferSDLG = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    dtpTanzimTar1: TDateTimePicker;
    Label5: TLabel;
    dtpTanzimTar2: TDateTimePicker;
    btn_Ara: TButton;
    dts_Liste: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    TutarBas: TIB_Currency;
    Label4: TLabel;
    TutarSon: TIB_Currency;
    chkBirim_Fiy: TCheckBox;
    cmdCancel: TBitBtn;
    btnTamam: TBitBtn;
    pnlRAPKOD: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    txtKOD2: TEdit;
    txtKOD3: TEdit;
    txtKOD4: TEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    chkRAPKOD: TCheckBox;
    cmbSube: TComboBox;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    TutarBas1: TIB_Currency;
    TutarSon1: TIB_Currency;
    ChkTutar: TCheckBox;
    GroupBox3: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    TutarBas2: TIB_Currency;
    TutarSon2: TIB_Currency;
    ChkTutarVpb: TCheckBox;
    txtArac: TEdit;
    Button6: TButton;
    LblPlaka: TLabel;
    txtAlanCari: TEdit;
    Button7: TButton;
    Label17: TLabel;
    txtAlanPers: TEdit;
    Button8: TButton;
    Label18: TLabel;
    TxtMazotcu: TEdit;
    Button9: TButton;
    Label19: TLabel;
    qrySefer: TIB_Query;
    GroupBox4: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    TutarBas21: TIB_Currency;
    TutarSon21: TIB_Currency;
    chkBirim_Fiy1: TCheckBox;
    GroupBox5: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    TutarBas22: TIB_Currency;
    TutarSon22: TIB_Currency;
    ChkTutar1: TCheckBox;
    GroupBox6: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    TutarBas23: TIB_Currency;
    TutarSon23: TIB_Currency;
    ChkTutarVpb1: TCheckBox;
    GroupBox7: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    TutarBas31: TIB_Currency;
    TutarSon31: TIB_Currency;
    ChkTutar2: TCheckBox;
    GroupBox8: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    TutarBas32: TIB_Currency;
    TutarSon32: TIB_Currency;
    ChkTutarVpb2: TCheckBox;
    Label28: TLabel;
    Label29: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    txtSeferSay: TEdit;
    Label30: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label31: TLabel;
    Label32: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label33: TLabel;
    ComboBox3: TComboBox;
    Btn_Rapor: TButton;
    Label1: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    cb_Tek_Satir: TCheckBox;
    Label8: TLabel;
    txtISLEMMERKEZI: TEdit;
    Button1: TButton;
    txtKOD1: TEdit;
    Button2: TButton;
    Label9: TLabel;
    txtSefer_No: TEdit;
    Label37: TLabel;
    cb_bf_Hesapla: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    Label38: TLabel;
    Edit1: TEdit;
    Label39: TLabel;
    ComboBox4: TComboBox;
    procedure btnTamamClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure btn_AraClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    function  Form_Open(Menu:Boolean;Var SEFER_ID:Integer;Var SEFER_SID:Integer;RAPOR:Boolean):Boolean;OverLoad;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure txtISLEMMERKEZIExit(Sender: TObject);
    procedure txtKOD1Exit(Sender: TObject);
    procedure txtKOD2Exit(Sender: TObject);
    procedure txtKOD3Exit(Sender: TObject);
    procedure txtKOD4Exit(Sender: TObject);
    procedure IB_Grid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure dtpTanzimTar1Enter(Sender: TObject);
    procedure dtpTanzimTar1Exit(Sender: TObject);
    procedure cboISLEMEnter(Sender: TObject);
    procedure cboISLEMExit(Sender: TObject);
    procedure TutarBasEnter(Sender: TObject);
    procedure TutarBasExit(Sender: TObject);
    procedure txtFisNoExit(Sender: TObject);
    procedure chkRAPKODEnter(Sender: TObject);
    procedure chkRAPKODExit(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure TxtMazotcuExit(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure txtAlanCariExit(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure txtAracExit(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure txtAlanPersExit(Sender: TObject);
    procedure Btn_RaporClick(Sender: TObject);
    procedure IB_Grid1Click(Sender: TObject);
    procedure IB_Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAracKeyPress(Sender: TObject; var Key: Char);
    procedure txtAracKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAlanCariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TxtMazotcuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAlanPersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Grid1DblClick(Sender: TObject);
  private
    Prv_Arama_Fat:Boolean;
    prv_Aktarilan_Idler:String;
    prv_Aktarilan_Idler_Bekleme:String;
    prv_Tipi:Integer;
    prv_Kissas:String;
    { Private declarations }
  public
     Kontrol:Boolean;


function Form_Open(Menu:Boolean;Var SEFER_ID:Integer;Var SEFER_SID:Integer;Alan_Cari:String;Satan_Cari:String;
Giden_Id:TStringList;
Giden_Id_Bek:TStringList;
var Qry:TIb_Query;
Tipi:Integer;
var Tek_Satir:Boolean;
var Bf_Hesapla:Boolean
):Boolean;OverLoad;

function Form_Open(Menu:Boolean;Var SEFER_ID:Integer;Var SEFER_SID:Integer;RAPOR:Boolean;Kissas:String):Boolean;OverLoad;
    { Public declarations }

  end;

var
  frmSeferSDLG: TfrmSeferSDLG;

implementation

uses unDataMod,unFunc, DateUtils, ufrmCekSenSDLG, StdConvs, ufrmCariSDLG ,
  ufrmRaporCiktisi;

{$R *.dfm}

function TfrmSeferSDLG.Form_Open(Menu:Boolean;Var SEFER_ID:Integer;Var SEFER_SID:Integer;
Alan_Cari:String;
Satan_Cari:String;
Giden_Id:TStringList;
Giden_Id_Bek:TStringList;
var Qry:TIb_Query;
Tipi:Integer;
var Tek_Satir:Boolean;
var Bf_Hesapla:Boolean
):Boolean;

var
  qryDeg:TIB_Query;
  a,b,say:Integer;
  Giden_Idd:TStringList;
  qryTemp:TIB_Query;
  Bulundu:Boolean;

label Tekrar;
begin
  Application.CreateForm(TfrmSeferSDLG,frmSeferSDLG);
///////////////////////////////////////////////////////////
  with frmSeferSDLG do
  begin
     qrySefer.FieldByName('SECIM').Visible:=True;
     CheckBox4.Checked:=True;
     Prv_Arama_Fat:=True;


     {for a:=0 to Giden_Id.Count-1 do
     begin
          b:=Giden_Id_Bek.IndexOf(Giden_Id.Strings[a]);
          if (b=-1) then //idlerdeki kayýt beklemede yok ise id sil göster
          Giden_Id.Delete(a);
     end;}

     Giden_Idd:=TStringList.Create;
     for a:=0 to Giden_Id.Count-1 do
     begin
          Giden_Idd.Add(Giden_Id.Strings[a]);
     end;
     {
     for a:=0 to Giden_Id_Bek.Count-1 do
     begin
          Giden_Idd.Add(Giden_Id.Strings[a]);
     end;
     }


     if Tipi=2 then //sadece satýþ için geçerli
     begin
     cb_Tek_Satir.Visible:=False;
     cb_bf_Hesapla.Visible:=False;
     end;

     if Tipi=1 then //sadece satýþ için geçerli
     begin
        {
        for a:=0 to Giden_Id.Count-1 do
        begin
             b:=Giden_Id_Bek.IndexOf(Giden_Id.Strings[a]);
             if (b=-1) then //idlerdeki kayýt beklemede yok ise id sil göster
             begin
                b:=Giden_Idd.IndexOf(Giden_Id.Strings[a]);
                if (b<>-1) then
                Giden_Idd.Delete(b);
             end;
        end;
        }

        for a:=0 to Giden_Id_Bek.Count-1 do
        begin
             b:=Giden_Idd.IndexOf(Giden_Id_Bek.Strings[a]);
             if (b<>-1) then
             begin
                Giden_Idd.Add(Giden_Id_Bek.Strings[a]);
             end;
        end;

        DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaMain);
Tekrar:
        Bulundu:=False;
        for a:=0 to Giden_Idd.Count-1 do
        begin

          with qryTemp do
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM SEFER WHERE BEKLEME_FAT_VAR=1 and SEFER_ID = '+ Giden_Idd.Strings[a]);
            Active := True;

            //bekleme faturasý var ve bekleme kesilmemiþse
            if (qryTemp.FieldByName('SEFER_ID').AsInteger>0) then
            if (qryTemp.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger=0) then
            begin
              //  if (Giden_Id.IndexOf(Giden_Idd.Strings[a])<>-1) and
               if (Giden_Id_bek.IndexOf(Giden_Idd.Strings[a])=-1) then
                begin

                  // b:=Giden_Idd.IndexOf(Giden_Idd.Strings[a]);
                  // if (b<>-1) then
                  // begin
                      Giden_Idd.Delete(a);
                      Bulundu:=True;
                      break;
                   //end;

                end;
            end;
          end;



        end;
       if Bulundu then goto Tekrar;
     end;



     prv_Aktarilan_Idler:=Giden_Idd.CommaText;
     //prv_Aktarilan_Idler:=prv_Aktarilan_Idler+Giden_Id_Bek.CommaText;
     prv_Aktarilan_Idler_Bekleme:=Giden_Id_Bek.CommaText;



     prv_Tipi:=Tipi;

     if Tipi=1 then
     txtAlanCari.Text:=Alan_Cari;
     if Tipi=2 then
     TxtMazotcu.Text:=Satan_Cari;

     if Tipi=1 then CheckBox2.checked:=False;
     if Tipi=1 then CheckBox5.checked:=False;
     if Tipi=2 then CheckBox1.checked:=False;

     CheckBox4.Enabled:=False;
     TxtMazotcu.Enabled:=False;
     Button9.Enabled:=False;
     txtAlanCari.Enabled:=False;
     Button7.Enabled:=False;

     CheckBox2.Enabled:=False;
     CheckBox5.Enabled:=False;
     CheckBox1.Enabled:=False;

     Panel1.Visible:=False;
     pnlRAPKOD.Visible:=False;
     Btn_Rapor.Visible:=False;
  end;
///////////////////////////////////////////////////////////


  with frmSeferSDLG do
  begin
    DataMod.Rapor_Kod_Visible_Fields('SEFER'
                                     ,txtISLEMMERKEZI
                                     ,txtKOD1
                                     ,txtKOD2
                                     ,txtKOD3
                                     ,txtKOD4
                                     ,Button1
                                     ,Button2
                                     ,Button3
                                     ,Button4
                                     ,Button5
                                     ,Label8
                                     ,Label9
                                     ,Label10
                                     ,Label11
                                     ,Label12);
    dtpTanzimTar1.Date := glb_DONEM_BAS;
    dtpTanzimTar2.Date := DataMod.GET_SERVER_DATE;

    if glb_SUBELI then
    begin
      if glb_SUBE_MUDAHALE then
      begin
        DataMod.FillSubeStr(cmbSube.Items);
        with cmbSube do
        begin
          ItemIndex := 0;
          Visible := True;
        end;
      end
      else
      begin
        with cmbSube do
        begin
          Clear;
          Items.Add(DataMod.SubeID2Ad(False,glb_SID));
          ItemIndex := 0;
          Enabled := False;
        end;
      end;
    end
    else
    begin
      cmbSube.Visible := False;
    end;

    TutarBas.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas1.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon1.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas2.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon2.DisplayFormat := glb_VPB_FIELD_PF;



    TutarBas21.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon21.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas22.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon22.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas23.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon23.DisplayFormat := glb_VPB_FIELD_PF;


    TutarBas31.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon31.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas32.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon32.DisplayFormat := glb_VPB_FIELD_PF;


        DataMod.CreateQuery(qryDeg,Nil,False,DataMod.dbaMain);

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT CIK_YER FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox1.Items.Add(qryDeg.FieldByName('CIK_YER').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT BIT_YER FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox2.Items.Add(qryDeg.FieldByName('BIT_YER').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT TASINAN_ESYA FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox3.Items.Add(qryDeg.FieldByName('TASINAN_ESYA').asString);
            qryDeg.Next;
        end;
        qryDeg.Active:=False;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT YUKLEYICI_FIRMA FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox4.Items.Add(qryDeg.FieldByName('YUKLEYICI_FIRMA').asString);
            qryDeg.Next;
        end;
        qryDeg.Active:=False;

    btn_AraClick(Self);

    ShowModal;

///////////////////////////////////////////////////////

///////////////////////////////////////////////////////

    if not Kontrol then
    begin
       SEFER_ID:=0;
       SEFER_SID:=0;

      Result := False;
    end
    else
    begin
       SEFER_ID:=qrySefer.FieldByName('SEFER_ID').AsInteger;
       SEFER_SID:=qrySefer.FieldByName('SEFER_SID').AsInteger;
      Result := True
    end;


    //qrySefer.Close;
    //Release;
{    Qry.Active:=False;
    Qry.Sql.Text:=qrySefer.SQL.Text;
    Qry.Active:=True;
    qrySefer.DisableControls;
    qrySefer.First;

    While not qrySefer.Eof do
    begin
         if qrySefer.FieldByName('SECIM').AsString='1' then
         begin
             qry.Edit;
             qry.FieldByName('SECIM').AsString:='1';
             qry.post;
         end;
         qrySefer.Next;
    end;
    qrySefer.EnableControls;
}
    Qry:=qrySefer;
    Giden_Idd.Free;
    Tek_Satir:=cb_Tek_Satir.Checked;
    Bf_Hesapla:=cb_bf_Hesapla.Checked;

    say:=0;
    if Tek_Satir then
    begin
         qrySefer.First; 
         While Not qrySefer.Eof Do
         begin
              if qrySefer.FieldByName('SECIM').AsString ='1' then
              Inc(Say);
              qrySefer.Next;
         end;
    end;
    if say<2 then Tek_Satir:=False;

{         qrySefer.DisableControls;
         qrySefer.First;
         Qry.First;



         While Not qrySefer.Eof Do
         begin

         Qry.Edit;
         Qry.FieldByName('SECIM').AsInteger:=qrySefer.FieldByName('SECIM').AsInteger;
         Qry.Post;
//         Qry.Next;
         qrySefer.Next;
         end;
         qrySefer.EnableControls;
}
    //qrySefer.CancelUpdates;
    //qrySefer.CommitUpdates;


  end;//with





end;






function TfrmSeferSDLG.Form_Open(Menu:Boolean;Var SEFER_ID:Integer;Var SEFER_SID:Integer;RAPOR:Boolean;Kissas:String):Boolean;
var
  qryDeg:TIB_Query;
begin
  Application.CreateForm(TfrmSeferSDLG,frmSeferSDLG);

  with frmSeferSDLG do
  begin


    prv_Kissas:=Kissas;

    cb_Tek_Satir.Visible:=False;
    cb_bf_Hesapla.Visible:=False;

    if Rapor then
    begin
      Btn_Rapor.Visible := True;
    end
    else
    begin
      Btn_Rapor.Visible := False;
    end;

    qrySefer.FieldByName('SECIM').Visible:=False;

    DataMod.Rapor_Kod_Visible_Fields('SEFER'
                                     ,txtISLEMMERKEZI
                                     ,txtKOD1
                                     ,txtKOD2
                                     ,txtKOD3
                                     ,txtKOD4
                                     ,Button1
                                     ,Button2
                                     ,Button3
                                     ,Button4
                                     ,Button5
                                     ,Label8
                                     ,Label9
                                     ,Label10
                                     ,Label11
                                     ,Label12);
    dtpTanzimTar1.Date := glb_DONEM_BAS;
    dtpTanzimTar2.Date := DataMod.GET_SERVER_DATE;

    if glb_SUBELI then
    begin
      if glb_SUBE_MUDAHALE then
      begin
        DataMod.FillSubeStr(cmbSube.Items);
        with cmbSube do
        begin
          ItemIndex := 0;
          Visible := True;
        end;
      end
      else
      begin
        with cmbSube do
        begin
          Clear;
          Items.Add(DataMod.SubeID2Ad(False,glb_SID));
          ItemIndex := 0;
          Enabled := False;
        end;
      end;
    end
    else
    begin
      cmbSube.Visible := False;
    end;

    TutarBas.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas1.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon1.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas2.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon2.DisplayFormat := glb_VPB_FIELD_PF;



    TutarBas21.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon21.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas22.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon22.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas23.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon23.DisplayFormat := glb_VPB_FIELD_PF;


    TutarBas31.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon31.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas32.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon32.DisplayFormat := glb_VPB_FIELD_PF;


        DataMod.CreateQuery(qryDeg,Nil,False,DataMod.dbaMain);

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT CIK_YER FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox1.Items.Add(qryDeg.FieldByName('CIK_YER').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT BIT_YER FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox2.Items.Add(qryDeg.FieldByName('BIT_YER').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT TASINAN_ESYA FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox3.Items.Add(qryDeg.FieldByName('TASINAN_ESYA').asString);
            qryDeg.Next;
        end;
        qryDeg.Active:=False;


        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT YUKLEYICI_FIRMA FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox4.Items.Add(qryDeg.FieldByName('YUKLEYICI_FIRMA').asString);
            qryDeg.Next;
        end;
        qryDeg.Active:=False;        


    //Panel1.Visible:=False;
    pnlRAPKOD.Visible:=False;
    Btn_Rapor.Visible:=False;
    
    if Prv_Kissas='1' then
    CheckBox4.Checked:=True;
    if Prv_Kissas='0' then
    CheckBox4.Checked:=False;

    btn_AraClick(Self);

    ShowModal;


    if not Kontrol then
    begin
       SEFER_ID:=0;
       SEFER_SID:=0;

      Result := False;
    end
    else
    begin
       SEFER_ID:=qrySefer.FieldByName('SEFER_ID').AsInteger;
       SEFER_SID:=qrySefer.FieldByName('SEFER_SID').AsInteger;
      Result := True
    end;


    qrySefer.Close;
    Release;
  end;//with

end;


function TfrmSeferSDLG.Form_Open(Menu:Boolean;Var SEFER_ID:Integer;Var SEFER_SID:Integer;RAPOR:Boolean):Boolean;
var
  qryDeg:TIB_Query;
begin
  Application.CreateForm(TfrmSeferSDLG,frmSeferSDLG);

  with frmSeferSDLG do
  begin

    cb_Tek_Satir.Visible:=False;
    cb_bf_Hesapla.Visible:=False;

    if Rapor then
    begin
      Btn_Rapor.Visible := True;
    end
    else
    begin
      Btn_Rapor.Visible := False;
    end;

    qrySefer.FieldByName('SECIM').Visible:=False;

    DataMod.Rapor_Kod_Visible_Fields('SEFER'
                                     ,txtISLEMMERKEZI
                                     ,txtKOD1
                                     ,txtKOD2
                                     ,txtKOD3
                                     ,txtKOD4
                                     ,Button1
                                     ,Button2
                                     ,Button3
                                     ,Button4
                                     ,Button5
                                     ,Label8
                                     ,Label9
                                     ,Label10
                                     ,Label11
                                     ,Label12);
    dtpTanzimTar1.Date := glb_DONEM_BAS;
    dtpTanzimTar2.Date := DataMod.GET_SERVER_DATE;

    if glb_SUBELI then
    begin
      if glb_SUBE_MUDAHALE then
      begin
        DataMod.FillSubeStr(cmbSube.Items);
        with cmbSube do
        begin
          ItemIndex := 0;
          Visible := True;
        end;
      end
      else
      begin
        with cmbSube do
        begin
          Clear;
          Items.Add(DataMod.SubeID2Ad(False,glb_SID));
          ItemIndex := 0;
          Enabled := False;
        end;
      end;
    end
    else
    begin
      cmbSube.Visible := False;
    end;

    TutarBas.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas1.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon1.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas2.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon2.DisplayFormat := glb_VPB_FIELD_PF;



    TutarBas21.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon21.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas22.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon22.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas23.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon23.DisplayFormat := glb_VPB_FIELD_PF;


    TutarBas31.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon31.DisplayFormat := glb_VPB_FIELD_PF;
    TutarBas32.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon32.DisplayFormat := glb_VPB_FIELD_PF;


        DataMod.CreateQuery(qryDeg,Nil,False,DataMod.dbaMain);

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT CIK_YER FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox1.Items.Add(qryDeg.FieldByName('CIK_YER').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT BIT_YER FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox2.Items.Add(qryDeg.FieldByName('BIT_YER').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT TASINAN_ESYA FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox3.Items.Add(qryDeg.FieldByName('TASINAN_ESYA').asString);
            qryDeg.Next;
        end;
        qryDeg.Active:=False;


        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT YUKLEYICI_FIRMA FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            ComboBox4.Items.Add(qryDeg.FieldByName('YUKLEYICI_FIRMA').asString);
            qryDeg.Next;
        end;
        qryDeg.Active:=False;


    ShowModal;


    if not Kontrol then
    begin
       SEFER_ID:=0;
       SEFER_SID:=0;

      Result := False;
    end
    else
    begin
       SEFER_ID:=qrySefer.FieldByName('SEFER_ID').AsInteger;
       SEFER_SID:=qrySefer.FieldByName('SEFER_SID').AsInteger;
      Result := True
    end;


    qrySefer.Close;
    Release;
  end;//with

end;











procedure TfrmSeferSDLG.btnTamamClick(Sender: TObject);
begin

  if (qrySefer.Active = True) then
  begin
    if not (qrySefer.RecordCount = 0) then
    begin
      Kontrol := True;
      Close;
    end
    else
    begin
      Kontrol := False;
      Close;
    end;
  end
  else
  if Application.MessageBox('Arama yapmadýnýz forma geri dönmek için YES Cýkmak için NO','Dikkat',MB_YESNO) = IDNO then
  begin
    Kontrol := False;
    Close;
  end;
end;

procedure TfrmSeferSDLG.cmdCancelClick(Sender: TObject);
begin
  Kontrol := False;
  Close;
end;

procedure TfrmSeferSDLG.btn_AraClick(Sender: TObject);
var
  WhereEk:Boolean;
  strSQL,SubeID:String;
begin
  {if lblKASA_KOD.Caption = '' then
  begin
    Application.MessageBox('Önce Kasa Seçmeniz Gerekiyor','Dikkat',MB_ICONSTOP);
    exit;
  end;  }
  //////////////////////////////////////////////////////////////////////////////
  WhereEk := False;
  strSQL :=
' SELECT SEFER_ID '+#13+
'      , SEFER_SID '+#13+
'      , SEFER_SAY '+#13+
'      , ARAC_KOD '+#13+
'      ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD) AS ARAC_PLAKA '+#13+
'      , ALICI_KOD '+#13+
'      ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD) AS ALICI_ADI '+#13+
'      , SATICI_KOD '+#13+
'      ,(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI_KOD) AS SATICI_ADI '+#13+
'      , PERSONEL_KOD '+#13+
'      ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI '+#13+
'      , OLCU_TIP '+#13+
'      , OLCU_BIRIM '+#13+
'      , TASINAN_ESYA '+#13+
'      , BAS_TAR '+#13+
'      , BIT_TAR '+#13+
'      , CIK_YER '+#13+
'      , BIT_YER '+#13+
'      , ALICI_BORC_BIRIM_FIY '+#13+
'      , ALICI_B_DOVKOD '+#13+
'      , ALICI_BORC '+#13+
'      , ALICI_BORC_VPB '+#13+
'      , SATICI_ALACAK_BIRIM_FIY '+#13+
'      , SATICI_A_DOVKOD '+#13+
'      , SATICI_ALACAK '+#13+
'      , SATICI_ALACAK_VPB '+#13+
'      , BEKLEME_FAT_VAR '+#13+
'      , BEKLEME_FAT_TUTAR '+#13+
'      , BEKLEME_FAT_DOV_KOD '+#13+
'      , BEKLEME_FAT_VPB '+#13+
'      , SEFER_NOTLARI '+#13+
'      , SEFER_ALIS_FAT_ALINDI '+#13+
'      , SEFER_SATIS_FAT_KESILDI '+#13+
'      , MASRAF_MERK '+#13+
'      , KOD1 '+#13+
'      , KOD2 '+#13+
'      , KOD3 '+#13+
'      , KOD4 '+#13+
'      , ALICI_B_DOV_BAZ_TAR '+#13+
'      , SATICI_A_DOV_BAZ_TAR '+#13+
'      , BEKLEME_FAT_DOV_BAZ_TAR '+#13+
'      , ALICI_B_DOVKUR '+#13+
'      , SATICI_A_DOVKUR '+#13+
'      , BEKLEME_FAT_DOVKUR '+#13+
'      , SEFER_TAMAMLANDI '+#13+
'      , DORSE_KOD '+#13+
'      , ALIS_URUN_HAR_ID '+#13+
'      , SATIS_URUN_HAR_ID '+#13+
'      , SECIM '+#13+
'      , BEKLEME_FATURASI_KESILDI'+#13+
'      , BEK_FAT_URUN_HAR_ID'+#13+
'      , MIKTAR'+#13+
'      , FATURA_MIK_SEF'+#13+
//y
'      , SBEKLEME_FAT_VAR'+#13+
'      , SBEKLEME_FAT_TUTAR'+#13+
'      , SBEKLEME_FAT_DOV_KOD'+#13+
'      , SBEKLEME_FAT_VPB'+#13+
'      , SBEKLEME_FAT_DOV_BAZ_TAR'+#13+
'      , SBEKLEME_FAT_DOVKUR'+#13+
'      , SBEKLEME_FATURASI_KESILDI'+#13+
'      , SBEK_FAT_URUN_HAR_ID'+#13+
'      , SEFER_TAKIP_ID'+#13+
'      , YUKLEYICI_FIRMA'+#13+
//ys




' FROM SEFER K';
//WHERE SEFER_ID=:PRM_SEFER_ID AND SEFER_SID=:PRM_SEFER_SID

  {
  if txtFisNo.Text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.FIS_NO = '+ txtFisNo.text;
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.FIS_NO = '+ txtFisNo.text;
      WhereEk := True;
    end;//end if WhereEk then
  end; }




  if CheckBox2.State<>cbGrayed then
  if CheckBox2.Checked or (not CheckBox2.Checked)  then
  begin
    if not Prv_Arama_Fat then
    if WhereEk then
    begin
      if CheckBox2.Checked then
      strSQL := strSQL + ' AND K.SEFER_SATIS_FAT_KESILDI =1 ';
      if not CheckBox2.Checked then
      strSQL := strSQL + ' AND K.SEFER_SATIS_FAT_KESILDI =0 ';

    end
    else
    begin
      if CheckBox2.Checked then
      strSQL := strSQL + ' WHERE K.SEFER_SATIS_FAT_KESILDI =1 ';
      if not CheckBox2.Checked then
      strSQL := strSQL + ' WHERE K.SEFER_SATIS_FAT_KESILDI =0 ';

      WhereEk := True;
    end;//end if WhereEk then


    if Prv_Arama_Fat then
    if WhereEk then
    begin
      if CheckBox2.Checked then
      strSQL := strSQL + ' AND (K.SEFER_SATIS_FAT_KESILDI =1 ';
      if not CheckBox2.Checked then
      strSQL := strSQL + ' AND (K.SEFER_SATIS_FAT_KESILDI =0 ';

    end
    else
    begin
      if CheckBox2.Checked then
      strSQL := strSQL + ' WHERE (K.SEFER_SATIS_FAT_KESILDI =1 ';
      if not CheckBox2.Checked then
      strSQL := strSQL + ' WHERE (K.SEFER_SATIS_FAT_KESILDI =0 ';

      WhereEk := True;
    end;//end if WhereEk then

  end;


  if CheckBox5.State<>cbGrayed then
  if CheckBox5.Checked or (not CheckBox5.Checked)  then
  begin
    if not Prv_Arama_Fat then
    if WhereEk then
    begin
      if CheckBox5.Checked then
      strSQL := strSQL + ' AND K.BEKLEME_FATURASI_KESILDI =1 ';
      if not CheckBox5.Checked then
      strSQL := strSQL + ' AND K.BEKLEME_FATURASI_KESILDI =0 ';

    end
    else
    begin
      if CheckBox5.Checked then
      strSQL := strSQL + ' WHERE K.BEKLEME_FATURASI_KESILDI =1 ';
      if not CheckBox5.Checked then
      strSQL := strSQL + ' WHERE K.BEKLEME_FATURASI_KESILDI =0 ';

      WhereEk := True;
    end;//end if WhereEk then

    if Prv_Arama_Fat then
    if WhereEk then
    begin
      if CheckBox5.Checked then
      strSQL := strSQL + ' or K.BEKLEME_FATURASI_KESILDI =1) ';
      if not CheckBox5.Checked then
      strSQL := strSQL + ' or (K.BEKLEME_FATURASI_KESILDI=0 AND BEKLEME_FAT_VAR=1)) ';

    end
    else
    begin
      if CheckBox5.Checked then
      strSQL := strSQL + ' WHERE K.BEKLEME_FATURASI_KESILDI =1 ';
      if not CheckBox5.Checked then
      strSQL := strSQL + ' WHERE (K.BEKLEME_FATURASI_KESILDI=0 AND BEKLEME_FAT_VAR=1) ';

      WhereEk := True;
    end;//end if WhereEk then

  end;



//y

  if CheckBox7.State<>cbGrayed then
  if CheckBox7.Checked or (not CheckBox7.Checked)  then
  begin
    if not Prv_Arama_Fat then
    if WhereEk then
    begin
      if CheckBox7.Checked then
      strSQL := strSQL + ' AND K.SBEKLEME_FATURASI_KESILDI =1 ';
      if not CheckBox7.Checked then
      strSQL := strSQL + ' AND K.EBEKLEME_FATURASI_KESILDI =0 ';

    end
    else
    begin
      if CheckBox7.Checked then
      strSQL := strSQL + ' WHERE K.SBEKLEME_FATURASI_KESILDI =1 ';
      if not CheckBox7.Checked then
      strSQL := strSQL + ' WHERE K.SBEKLEME_FATURASI_KESILDI =0 ';

      WhereEk := True;
    end;//end if WhereEk then

    if Prv_Arama_Fat then
    if WhereEk then
    begin
      if CheckBox7.Checked then
      strSQL := strSQL + ' or K.SBEKLEME_FATURASI_KESILDI =1) ';
      if not CheckBox7.Checked then
      strSQL := strSQL + ' or (K.SBEKLEME_FATURASI_KESILDI=0 AND SBEKLEME_FAT_VAR=1)) ';

    end
    else
    begin
      if CheckBox7.Checked then
      strSQL := strSQL + ' WHERE K.SBEKLEME_FATURASI_KESILDI =1 ';
      if not CheckBox7.Checked then
      strSQL := strSQL + ' WHERE (K.SBEKLEME_FATURASI_KESILDI=0 AND SBEKLEME_FAT_VAR=1) ';

      WhereEk := True;
    end;//end if WhereEk then

  end;


//ys




  if txtSeferSay.Text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.SEFER_SAY = '+ txtSeferSay.text;
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.SEFER_SAY = '+ txtSeferSay.text;
      WhereEk := True;
    end;//end if WhereEk then
  end;


  if txtSefer_No.Text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.SEFER_ID = '+ txtSefer_No.text;
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.SEFER_ID = '+ txtSefer_No.text;
      WhereEk := True;
    end;//end if WhereEk then
  end;






  if txtISLEMMERKEZI.Text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.MASRAF_MERK = '+ Sql_Katar(txtISLEMMERKEZI.text);
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.MASRAF_MERK = '+ Sql_Katar(txtISLEMMERKEZI.text);
      WhereEk := True;
    end;//end if WhereEk then
  end;



    if txtKOD1.Text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.KOD1 = '+ Sql_Katar(txtKOD1.text);
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.KOD1 = '+ Sql_Katar(txtKOD1.text);
      WhereEk := True;
    end;//end if WhereEk then
  end;






  if ComboBox3.text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.TASINAN_ESYA = '+ Sql_Katar(ComboBox3.text);
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.TASINAN_ESYA = '+ Sql_Katar(ComboBox3.text);
      WhereEk := True;
    end;//end if WhereEk then
  end;


  if ComboBox4.text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.YUKLEYICI_FIRMA = '+ Sql_Katar(ComboBox4.text);
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.YUKLEYICI_FIRMA = '+ Sql_Katar(ComboBox4.text);
      WhereEk := True;
    end;//end if WhereEk then
  end;



  if Edit1.text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.KONTEYNER_NO LIKE '+ Sql_Katar(Edit1.text);
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.KONTEYNER_NO LIKE '+ Sql_Katar(Edit1.text);
      WhereEk := True;
    end;//end if WhereEk then
  end;



  if ComboBox1.text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.CIK_YER = '+ Sql_Katar(ComboBox1.text);
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.CIK_YER = '+ Sql_Katar(ComboBox1.text);
      WhereEk := True;
    end;//end if WhereEk then
  end;

  if ComboBox2.text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.BIT_YER = '+ Sql_Katar(ComboBox2.text);
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.BIT_YER = '+ Sql_Katar(ComboBox2.text);
      WhereEk := True;
    end;//end if WhereEk then
  end;


  if CheckBox1.State<>cbGrayed then
  if CheckBox1.Checked or (not CheckBox1.Checked)  then
  begin
    if WhereEk then
    begin
      if CheckBox1.Checked then
      strSQL := strSQL + ' AND (K.SATICI_KOD<>'''' and K.SEFER_ALIS_FAT_ALINDI =1) ';
      if not CheckBox1.Checked then
      strSQL := strSQL + ' AND (K.SATICI_KOD<>'''' and K.SEFER_ALIS_FAT_ALINDI =0) ';

    end
    else
    begin
      if CheckBox1.Checked then
      strSQL := strSQL + ' WHERE (K.SATICI_KOD<>'''' and K.SEFER_ALIS_FAT_ALINDI =1) ';
      if not CheckBox1.Checked then
      strSQL := strSQL + ' WHERE (K.SATICI_KOD<>'''' and K.SEFER_ALIS_FAT_ALINDI =0) ';

      WhereEk := True;
    end;//end if WhereEk then
  end;


  if CheckBox3.State<>cbGrayed then
  if CheckBox3.Checked or (not CheckBox3.Checked)  then
  begin
    if WhereEk then
    begin
      if CheckBox3.Checked then
      strSQL := strSQL + ' AND K.BEKLEME_FAT_VAR =1 ';
      if not CheckBox3.Checked then
      strSQL := strSQL + ' AND K.BEKLEME_FAT_VAR =0 ';

    end
    else
    begin
      if CheckBox3.Checked then
      strSQL := strSQL + ' WHERE K.BEKLEME_FAT_VAR =1 ';
      if not CheckBox3.Checked then
      strSQL := strSQL + ' WHERE K.BEKLEME_FAT_VAR =0 ';

      WhereEk := True;
    end;//end if WhereEk then
  end;



  if CheckBox8.State<>cbGrayed then
  if CheckBox8.Checked or (not CheckBox8.Checked)  then
  begin
    if WhereEk then
    begin
      if CheckBox8.Checked then
      strSQL := strSQL + ' AND K.SBEKLEME_FAT_VAR =1 ';
      if not CheckBox8.Checked then
      strSQL := strSQL + ' AND K.SBEKLEME_FAT_VAR =0 ';

    end
    else
    begin
      if CheckBox8.Checked then
      strSQL := strSQL + ' WHERE K.SBEKLEME_FAT_VAR =1 ';
      if not CheckBox8.Checked then
      strSQL := strSQL + ' WHERE K.SBEKLEME_FAT_VAR =0 ';

      WhereEk := True;
    end;//end if WhereEk then
  end;




  if CheckBox4.State<>cbGrayed then
  if CheckBox4.Checked or (not CheckBox4.Checked)  then
  begin
    if WhereEk then
    begin
      if CheckBox4.Checked then
      strSQL := strSQL + ' AND K.SEFER_TAMAMLANDI =1 ';
      if not CheckBox4.Checked then
      strSQL := strSQL + ' AND K.SEFER_TAMAMLANDI =0 ';

    end
    else
    begin
      if CheckBox4.Checked then
      strSQL := strSQL + ' WHERE K.SEFER_TAMAMLANDI =1 ';
      if not CheckBox4.Checked then
      strSQL := strSQL + ' WHERE K.SEFER_TAMAMLANDI =0 ';

      WhereEk := True;
    end;//end if WhereEk then
  end;

   { if glb_SUBELI then
    begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if WhereEk then
      begin
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND K.SEFER_SID = ' + SubeID;
        end;
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.SEFER_SID = ' + SubeID;
        WhereEk := True;
      end;
    end
    else
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.SEFER_SID = ' + inttostr(glb_sid);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.SEFER_SID = ' + inttostr(glb_sid);
        WhereEk := True;
      end;
    end;  }

    ////////////////////////////////////////////////////////////////////////
    if chkRAPKOD.Checked then
    begin
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD1 = '+ SQL_Katar(txtKOD1.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD1 = '+ SQL_Katar(txtKOD1.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD2 = ' +  SQL_Katar(txtKOD2.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD2 = ' + SQL_Katar(txtKOD2.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD3 = ' + SQL_Katar(txtKOD3.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD3 = '+ SQL_Katar(txtKOD3.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD4 = ' + SQL_Katar(txtKOD4.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD4 = ' + SQL_Katar(txtKOD4.Text);
          WhereEk := True;
        end
      end;
    //////////////////////////////////////////////////////////////////
    end;//end chkRAPKOD.checked
    ////////////////////////////////////////////////////////////////////////

    if chkBirim_Fiy.Checked then
    begin
      if Trim(TutarBas.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.ALICI_BORC_BIRIM_FIY >= '+ SQL_Para(TutarBas.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.ALICI_BORC_BIRIM_FIY >= '+ SQL_Para(TutarBas.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.ALICI_BORC_BIRIM_FIY <= '+ SQL_Para(TutarSon.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.ALICI_BORC_BIRIM_FIY <= '+ SQL_Para(TutarSon.Value);
          WhereEk := True;
        end;
      end;
    end;



    if ChkTutar.Checked then
    begin
      if Trim(TutarBas1.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.ALICI_BORC >= '+ SQL_Para(TutarBas1.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.ALICI_BORC >= '+ SQL_Para(TutarBas1.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon1.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.ALICI_BORC <= '+ SQL_Para(TutarSon1.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.ALICI_BORC <= '+ SQL_Para(TutarSon1.Value);
          WhereEk := True;
        end;
      end;
    end;






    if ChkTutarVpb.Checked then
    begin
      if Trim(TutarBas2.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.ALICI_BORC_VPB >= '+ SQL_Para(TutarBas2.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.ALICI_BORC_VPB >= '+ SQL_Para(TutarBas2.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon2.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.ALICI_BORC_VPB <= '+ SQL_Para(TutarSon2.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.ALICI_BORC_VPB <= '+ SQL_Para(TutarSon2.Value);
          WhereEk := True;
        end;
      end;
    end;



    /////////////////////////////////



    if chkBirim_Fiy1.Checked then
    begin
      if Trim(TutarBas21.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.SATICI_ALACAK_BIRIM_FIY >= '+ SQL_Para(TutarBas21.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.SATICI_ALACAK_BIRIM_FIY >= '+ SQL_Para(TutarBas21.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon21.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.SATICI_ALACAK_BIRIM_FIY <= '+ SQL_Para(TutarSon21.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.SATICI_ALACAK_BIRIM_FIY <= '+ SQL_Para(TutarSon21.Value);
          WhereEk := True;
        end;
      end;
    end;



    if ChkTutar1.Checked then
    begin
      if Trim(TutarBas22.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.SATICI_ALACAK >= '+ SQL_Para(TutarBas22.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.SATICI_ALACAK >= '+ SQL_Para(TutarBas22.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon22.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.SATICI_ALACAK <= '+ SQL_Para(TutarSon22.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.SATICI_ALACAK <= '+ SQL_Para(TutarSon22.Value);
          WhereEk := True;
        end;
      end;
    end;






    if ChkTutarVpb1.Checked then
    begin
      if Trim(TutarBas23.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.SATICI_ALACAK_VPB >= '+ SQL_Para(TutarBas23.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.SATICI_ALACAK_VPB >= '+ SQL_Para(TutarBas23.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon23.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.SATICI_ALACAK_VPB <= '+ SQL_Para(TutarSon23.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.SATICI_ALACAK_VPB <= '+ SQL_Para(TutarSon23.Value);
          WhereEk := True;
        end;
      end;
    end;





    if ChkTutar2.Checked then
    begin
      if Trim(TutarBas31.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.BEKLEME_FAT_TUTAR >= '+ SQL_Para(TutarBas31.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.BEKLEME_FAT_TUTAR >= '+ SQL_Para(TutarBas31.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon31.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.BEKLEME_FAT_TUTAR <= '+ SQL_Para(TutarSon31.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.BEKLEME_FAT_TUTAR <= '+ SQL_Para(TutarSon31.Value);
          WhereEk := True;
        end;
      end;
    end;






    if ChkTutarVpb2.Checked then
    begin
      if Trim(TutarBas32.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.BEKLEME_FAT_VPB >= '+ SQL_Para(TutarBas32.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.BEKLEME_FAT_VPB >= '+ SQL_Para(TutarBas32.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon32.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.BEKLEME_FAT_VPB <= '+ SQL_Para(TutarSon32.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.BEKLEME_FAT_VPB <= '+ SQL_Para(TutarSon32.Value);
          WhereEk := True;
        end;
      end;
    end;



    /////////////////////////////////

    //////////////////////////////////////////////////////////////////////
    if ((dtpTanzimTar1.Checked=True) and (dtpTanzimTar2.Checked=False)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.BAS_TAR = '+ SQL_Tarih(dtpTanzimTar1.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.BAS_TAR = '+ SQL_Tarih(dtpTanzimTar1.date);
        WhereEk := True;
      end;
    end;
    //////////////////////////////////////////////////////////////////////
    if ((dtpTanzimTar1.Checked=False) and (dtpTanzimTar2.Checked=True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.BAS_TAR <= '+ SQL_Tarih(dtpTanzimTar2.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.BAS_TAR <= '+ SQL_Tarih(dtpTanzimTar2.date);
        WhereEk := True;
      end;
    end;
    /////////////////////////////////////////////////////////////////////////
    if ((dtpTanzimTar1.Checked=True) and (dtpTanzimTar2.Checked=True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.BAS_TAR BETWEEN ' + SQL_Tarih(dtpTanzimTar1.date) + ' AND ' + SQL_Tarih(dtpTanzimTar2.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.BAS_TAR BETWEEN ' + SQL_Tarih(dtpTanzimTar1.date) + ' AND ' + SQL_Tarih(dtpTanzimTar2.date);
        WhereEk := True;
      end;
    end;
    ////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////
    if ((DateTimePicker1.Checked=True) and (DateTimePicker2.Checked=False)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.BIT_TAR = '+ SQL_Tarih(DateTimePicker1.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.BIT_TAR = '+ SQL_Tarih(DateTimePicker1.date);
        WhereEk := True;
      end;
    end;
    //////////////////////////////////////////////////////////////////////
    if ((DateTimePicker1.Checked=False) and (DateTimePicker2.Checked=True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.BIT_TAR <= '+ SQL_Tarih(DateTimePicker2.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.BIT_TAR <= '+ SQL_Tarih(DateTimePicker2.date);
        WhereEk := True;
      end;
    end;
    /////////////////////////////////////////////////////////////////////////
    if ((DateTimePicker1.Checked=True) and (DateTimePicker2.Checked=True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.BIT_TAR BETWEEN ' + SQL_Tarih(DateTimePicker1.date) + ' AND ' + SQL_Tarih(DateTimePicker2.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.BIT_TAR BETWEEN ' + SQL_Tarih(DateTimePicker1.date) + ' AND ' + SQL_Tarih(DateTimePicker2.date);
        WhereEk := True;
      end;
    end;


    if glb_SUBELI then
    begin
      if WhereEk then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND K.SEFER_SID = ' + SubeID;
        end;
      end
      else
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
           strSQL := strSQL + ' WHERE K.SEFER_SID = ' + SubeID;
           WhereEk := True;
        end;
      end;
    end
    else
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.SEFER_SID = ' + inttostr(glb_sid);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.SEFER_SID = ' + inttostr(glb_sid);
        WhereEk := True;
      end;
    end;
    ////////////////////////////////////////////////////////////////////////////

      if Trim(txtArac.Text) <> '' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.ARAC_KOD = '+ SQL_Katar(Trim(txtArac.Text));
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.ARAC_KOD = '+ SQL_Katar(Trim(txtArac.Text));
          WhereEk := True;
        end;

      end;


      if Trim(txtAlanPers.Text) <> '' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.PERSONEL_KOD = '+ SQL_Katar(Trim(txtAlanPers.Text));
        end
        else
        begin
          strSQL := strSQL + ' Where K.PERSONEL_KOD = '+ SQL_Katar(Trim(txtAlanPers.Text));
          WhereEk := True;
        end;

      end;

      if Trim(txtAlanCari.Text) <> '' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.ALICI_KOD = '+ SQL_Katar(Trim(txtAlanCari.Text));
        end
        else
        begin
          strSQL := strSQL + ' Where K.ALICI_KOD = '+ SQL_Katar(Trim(txtAlanCari.Text));
          WhereEk := True;
        end;


      end;


      if Trim(TxtMazotcu.Text) <> '' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.SATICI_KOD = '+ SQL_Katar(Trim(TxtMazotcu.Text));
        end
        else
        begin
          strSQL := strSQL + ' Where K.SATICI_KOD = '+ SQL_Katar(Trim(TxtMazotcu.Text));
          WhereEk := True;
        end;

      end;

  //end;


  if Length(Trim(prv_Aktarilan_Idler))>0 then
  begin
        prv_Aktarilan_Idler:='('+prv_Aktarilan_Idler+'))';
        if WhereEk then
        begin
          strSQL := strSQL + ' AND (K.SEFER_ID NOT IN '+ prv_Aktarilan_Idler;
        end
        else
        begin
          strSQL := strSQL + ' Where  (SEFER_ID NOT IN '+ prv_Aktarilan_Idler;
          WhereEk := True;
        end;
  end;

  if CheckBox6.Checked then
  begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND (SATICI_KOD<>'''' and (MASRAF_MERK IS NULL OR MASRAF_MERK=''''))';
        end
        else
        begin
          strSQL := strSQL + ' Where  (SATICI_KOD<>'''' and (MASRAF_MERK IS NULL OR MASRAF_MERK=''''))';
          WhereEk := True;
        end;
  end;

{
if prv_Tipi=1 then //satýþ
begin

  if Length(Trim(prv_Aktarilan_Idler))>0 then
  begin
        prv_Aktarilan_Idler:='('+prv_Aktarilan_Idler+')';
        if WhereEk then
        begin
          strSQL := strSQL + ' AND NOT K.SATIS_URUN_HAR_ID IN '+ prv_Aktarilan_Idler;
        end
        else
        begin
          strSQL := strSQL + ' Where  NOT SATIS_URUN_HAR_ID IN '+ prv_Aktarilan_Idler;
          WhereEk := True;
        end;
  end;

  if Length(Trim(prv_Aktarilan_Idler_Bekleme))>0 then
  begin
        prv_Aktarilan_Idler:='('+prv_Aktarilan_Idler+')';
        if WhereEk then
        begin
          strSQL := strSQL + ' AND NOT K.BEK_FAT_URUN_HAR_ID IN '+ prv_Aktarilan_Idler_Bekleme;
        end
        else
        begin
          strSQL := strSQL + ' Where  NOT BEK_FAT_URUN_HAR_ID IN '+ prv_Aktarilan_Idler_Bekleme;
          WhereEk := True;
        end;
  end;



end;

if prv_Tipi=2 then //alýþ
begin

  if Length(Trim(prv_Aktarilan_Idler))>0 then
  begin
        prv_Aktarilan_Idler:='('+prv_Aktarilan_Idler+')';
        if WhereEk then
        begin
          strSQL := strSQL + ' AND NOT K.ALIS_URUN_HAR_ID IN '+ prv_Aktarilan_Idler;
        end
        else
        begin
          strSQL := strSQL + ' Where  NOT ALIS_URUN_HAR_ID IN '+ prv_Aktarilan_Idler;
          WhereEk := True;
        end;
  end;

end;
}



strSQL := strSQL + ' ORDER BY SEFER_ID ';

  ////////////////////////////////////////////////////////////////////////////
  try
    with qrySefer do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
    end;

    if Prv_Arama_Fat then
    begin
         qrySefer.DisableControls;
         While Not qrySefer.Eof Do
         begin
         qrySefer.Edit;
         //qrySefer.FieldByName('SECIM').AsString:='0';
         qrySefer.FieldByName('SECIM').AsInteger:=0;
         qrySefer.Post;
         qrySefer.Next;
         end;
         qrySefer.EnableControls;

    end;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu.','Dikkat',MB_ICONSTOP);
    ShowMessage(strSQL);
  end;
{  if not Prv_Arama_Fat then
  IB_Grid1.SetFocus;
  if Prv_Kissas<>'' then
  IB_Grid1.SetFocus;
}    
end;

procedure TfrmSeferSDLG.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then cmdCancelClick(self);
  if key = #13 then
  begin
    if ActiveControl = IB_Grid1 then
    begin
      btnTAMAMClick(Self);
      exit;
    end;
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmSeferSDLG.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmSeferSDLG.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmSeferSDLG.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmSeferSDLG.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmSeferSDLG.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmSeferSDLG.txtISLEMMERKEZIExit(Sender: TObject);
begin
  if Length(trim(Self.txtISLEMMERKEZI.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtISLEMMERKEZI,0) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtISLEMMERKEZI.SetFocus;
  end;
end;

procedure TfrmSeferSDLG.txtKOD1Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD1.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD1,1) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD1.SetFocus;
  end;
end;

procedure TfrmSeferSDLG.txtKOD2Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD2.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD2,2) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD2.SetFocus;
  end;
end;

procedure TfrmSeferSDLG.txtKOD3Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD3.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD3,3) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD3.SetFocus;
  end;
end;

procedure TfrmSeferSDLG.txtKOD4Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD4.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD4,4) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD4.SetFocus;
  end;
end;

procedure TfrmSeferSDLG.IB_Grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
  begin
    Kontrol :=True;
    Close;
  end;
end;

procedure TfrmSeferSDLG.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmSeferSDLG);
  with frmSeferSDLG.qrySefer do
  begin
    FieldByName('ALICI_BORC_BIRIM_FIY').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ALICI_BORC').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('ALICI_BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('SATICI_ALACAK_BIRIM_FIY').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('SATICI_ALACAK').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('SATICI_ALACAK_VPB').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('BEKLEME_FAT_TUTAR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('BEKLEME_FAT_VPB').DisplayFormat := glb_DOV_FIELD_PF;
  end;
end;

procedure TfrmSeferSDLG.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSeferSDLG.dtpTanzimTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSeferSDLG.dtpTanzimTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmSeferSDLG.cboISLEMEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSeferSDLG.cboISLEMExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmSeferSDLG.TutarBasEnter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSeferSDLG.TutarBasExit(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := clWindow;
end;

procedure TfrmSeferSDLG.txtFisNoExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmSeferSDLG.chkRAPKODEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSeferSDLG.chkRAPKODExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmSeferSDLG.Button9Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      TxtMazotcu.Text := Cari_KOD;
      Label19.Caption := Cari_AD;
  end;
end;

procedure TfrmSeferSDLG.TxtMazotcuExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(TxtMazotcu.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',TxtMazotcu.Text,CARI_AD) then
    begin
      Label19.Caption := CARI_AD;
      if (Sender is TEdit) then
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      TxtMazotcu.SetFocus;
    end;
  end
  else
  begin
    if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow;
    Label19.Caption := '';
  end;

end;

procedure TfrmSeferSDLG.Button7Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      txtAlanCari.Text := Cari_KOD;
      Label17.Caption := Cari_AD;
  end;
end;

procedure TfrmSeferSDLG.txtAlanCariExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtAlanCari.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtAlanCari.Text,CARI_AD) then
    begin
      Label17.Caption := CARI_AD;
      if (Sender is TEdit) then
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txtAlanCari.SetFocus;
    end;
  end
  else
  begin
      if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow;
    Label17.Caption := '';
  end;

end;

procedure TfrmSeferSDLG.Button6Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      txtArac.Text := ARAC_KOD;
      LblPlaka.Caption:= PLAKA;
      {if OZ_MAL=1 then
      begin
        txtAlanPersonel.Visible:=True;
        IB_Text3.Visible:=True;
        txtAliciKod.Visible:=False;
        IB_Text2.Visible:=False;
        qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := PERSONEL_KOD;
        txtAlanPersonel.Text:= PERSONEL_KOD;
        qryMazot.FieldByName('ALAN_CARI_KOD').AsString := '';
        qryMazot.FieldByName('ALAN_CARI_ADI').AsString := '';
        txtAlanPersonelExit(Self);
      end
      else
      begin
        txtAlanPersonel.Visible:=False;
        IB_Text3.Visible:=False;
        txtAliciKod.Visible:=True;
        IB_Text2.Visible:=True;
        qryMazot.FieldByName('ALAN_CARI_KOD').AsString := CARI_KOD;
        txtAliciKod.Text:= CARI_KOD;
        qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := '';
        qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString := '';
        txtAliciKodExit(Self);
      end;
      }

  end;

end;

procedure TfrmSeferSDLG.txtAracExit(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 SATICI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:String;
begin
  if Trim(txtArac.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','PLAKA',txtArac.Text,PLAKA) then
    begin
      LblPlaka.Caption := PLAKA;
      if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','OZ_MAL',txtArac.Text,OZ_MAL) then
      begin
        {
         if OZ_MAL='1' then
         begin
            txtAlanPersonel.Visible:=True;
            IB_Text3.Visible:=True;
            txtAliciKod.Visible:=False;
            IB_Text2.Visible:=False;

            DataMod.FN_KOD2AD('ARAC','ARAC_KOD','PERSONEL_KOD',txtArac_Kod.Text,PERSONEL_KOD);
            qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := PERSONEL_KOD;
            txtAlanPersonel.Text:= PERSONEL_KOD;
            qryMazot.FieldByName('ALAN_CARI_KOD').AsString := '';
            qryMazot.FieldByName('ALAN_CARI_ADI').AsString := '';
            txtAlanPersonelExit(Self);

         end
         else
         begin
            txtAlanPersonel.Visible:=False;
            IB_Text3.Visible:=False;
            txtAliciKod.Visible:=True;
            IB_Text2.Visible:=True;
            DataMod.FN_KOD2AD('ARAC','ARAC_KOD','CARI_KOD',txtArac_Kod.Text,SATICI_KOD);
            qryMazot.FieldByName('ALAN_CARI_KOD').AsString := SATICI_KOD;
            txtAliciKod.Text:= SATICI_KOD;
            qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := '';
            qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString := '';
            txtAliciKodExit(Self);
         end;
          }
      end;

      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txtArac.SetFocus;
    end;
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
    LblPlaka.Caption := '';
  end;


end;

procedure TfrmSeferSDLG.Button8Click(Sender: TObject);
var
  PERSONEL_KOD, PERSONEL_AD :String;
begin
  if DataMod.LS_Personel(PERSONEL_KOD, PERSONEL_AD) then
  begin
    txtAlanPers.Text:=PERSONEL_KOD;
    Label18.Caption:=PERSONEL_AD;
  end;
end;

procedure TfrmSeferSDLG.txtAlanPersExit(Sender: TObject);
var
  PERSONEL_AD:String;
begin
  txtAlanPers.Color := clWindow;
  if Trim(txtAlanPers.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PERSONEL','PERSONEL_KOD','ADI_SOYADI',txtAlanPers.Text,PERSONEL_AD) then
    begin
      Label18.Caption := PERSONEL_AD
    end
    else
    begin
      txtAlanPers.SetFocus;
    end
  end
  else
  begin
    Label18.Caption := '';
  end;

end;

procedure TfrmSeferSDLG.Btn_RaporClick(Sender: TObject);
var
  row,col : integer;
  res_Cari : TStringList;
begin
  if not qrySefer.Active then
  begin
    Application.MessageBox('Arama iþlemi yapmadan rapor alamazsýnýz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  if qrySefer.RecordCount = 0 then
  begin
    Application.MessageBox('Yapmýþ olduðunuz aramada hiçbir kayýda ulaþýlamadý.Lütfen kriterleri kontrol ediniz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  row := 0;
  col := 0;
////////////////////////////////////////////////////////////////////////////////
  with frmRaporCiktisi do
  begin
    form_open();
    grdA.BeginUpdate;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

    {res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      SetCellText(row,col,res_Cari[1]);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    }
    
    inc(row);
{    case prv_Fatura_Tip of
    1:SetCellText(row,col,'MÜÞTERÝ SÝPARÝÞLERÝ LÝSTESÝ - ' + cmbFATURA_TIP.Text);
    2:SetCellText(row,col,'SATICI SÝPARÝÞLERÝ LÝSTESÝ - ' + cmbFATURA_TIP.Text);
    end;
}
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    inc(row);
    col:=0;
    SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
{    if chkCARI.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Cari Kod : '+ lbl_CARIKOD.Caption+' - Cari Ad : '+lbl_CARI.Caption);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end;

    if ((dtpIslemTar.Checked) and (dtpIslemTar2.Checked)) then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + (DateToStr(dtpIslemTar.Date)+' > - < '+DateToStr(dtpIslemTar2.Date)));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end
    else
    if dtpIslemTar.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + DateToStr(dtpIslemTar.Date));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end
    else
    if dtpIslemTar2.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + DateToStr(dtpIslemTar2.Date));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end;
}
    inc(row);
    col := 0;
    SetCellText(row,col,'Sefer No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Plaka');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Sefer Sayýsý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Alýcý Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Alýcý Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Satýcý Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Satýcý Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Personel Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Adý Soyadý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Ölçü Tipi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Ölçü Birimi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Taþýnan Eþya');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Çýkýþ Yeri');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Baþlama Tarihi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Varýþ Yeri');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Bitiþ Tarihi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Sefer Notlarý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Miktarý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Alýcý Borc tutarý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Satýcý Alacak Tutarý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Bekleme Faturasý Var');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Bekleme Fatura Tutarý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Sefer Tamamlandý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Alýþ Faturasý Alýndý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Satýþ Faturasý Kesildi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Bekleme Faturasý Kesildi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Masraf Merkezi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);



    inc(col);
    SetCellText(row,col,'sBekleme Faturasý Var');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'sBekleme Fatura Tutarý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'sBekleme Faturasý Kesildi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);





    inc(row);
    qrySefer.DisableControls;
    qrySefer.First;
    while not qrySefer.Eof do
    begin
      col := 0;


      SetCellText(row,col,qrySefer.FieldByName('SEFER_ID').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ARAC_KOD').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ARAC_PLAKA').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_SAY').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ALICI_KOD').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ALICI_ADI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SATICI_KOD').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SATICI_ADI').AsString);

      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('PERSONEL_KOD').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('PERSONEL_ADI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('OLCU_TIP').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('OLCU_BIRIM').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('TASINAN_ESYA').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('CIK_YER').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BAS_TAR').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BIT_YER').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BIT_TAR').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_NOTLARI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('MIKTAR').AsString);

      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ALICI_BORC_VPB').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SATICI_ALACAK_VPB').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_TAMAMLANDI').AsString);

      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BEKLEME_FAT_VAR').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BEKLEME_FAT_VPB').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_ALIS_FAT_ALINDI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_SATIS_FAT_KESILDI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BEKLEME_FATURASI_KESILDI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('MASRAF_MERK').AsString);


      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SBEKLEME_FAT_VAR').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SBEKLEME_FAT_VPB').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SBEKLEME_FATURASI_KESILDI').AsString);










      inc(row);
      qrySefer.Next;
    end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    inc(row);
    col := 7;
//    SetCellText(row,col,'=SUM(H4:H'+IntToStr(row-1)+')');
//    SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    SetCellFormat(4,3,4,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    format_ayarla(18,3,20,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
    grdA.EndUpdate;
    WindowState := wsMaximized;
  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  qrySefer.First;
  qrySefer.EnableControls;



end;

procedure TfrmSeferSDLG.IB_Grid1Click(Sender: TObject);
begin
//
end;

procedure TfrmSeferSDLG.IB_Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key=VK_Space then
      IB_Grid1DblClick(nil);
end;

procedure TfrmSeferSDLG.txtAracKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmSeferSDLG.txtAracKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button6Click(Self);
end;

procedure TfrmSeferSDLG.txtAlanCariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button7Click(Self);
end;

procedure TfrmSeferSDLG.TxtMazotcuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button9Click(Self);
end;

procedure TfrmSeferSDLG.txtAlanPersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button8Click(Self);
end;

procedure TfrmSeferSDLG.IB_Grid1DblClick(Sender: TObject);
begin
  if qrySefer.FieldByName('SEFER_ID').AsInteger>0 then
  begin
    if qrySefer.FieldByName('SECIM').AsInteger=1 then
    qrySefer.FieldByName('SECIM').AsInteger:=0
    else
    qrySefer.FieldByName('SECIM').AsInteger:=1;
    qrySefer.Post;
  end;


     if not Prv_Arama_Fat then
     btnTamamClick(Self);
end;

end.
