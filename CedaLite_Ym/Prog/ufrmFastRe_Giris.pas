unit ufrmFastRe_Giris;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, IB_Grid, IB_Components, StdCtrls, Mask, IB_Controls,
  Buttons, ExtCtrls, frxClass;

type
  TfrmFastRe_Giris = class(TForm)
    dts_Kul_Rep: TIB_DataSource;
    qry_Kul_Rep: TIB_Query;
    IB_Grid1: TIB_Grid;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    btnCikis: TBitBtn;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_CheckBox1: TIB_CheckBox;
    Od: TOpenDialog;
    btn_Rapor_Duz: TButton;
    IB_CheckBox2: TIB_CheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure IB_Edit7ButtonClick(Sender: TObject);
    procedure qry_Kul_RepAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormCreate(Sender: TObject);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure dts_Kul_RepStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_Rapor_DuzClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure IB_Edit7Enter(Sender: TObject);
    procedure IB_Edit7Exit(Sender: TObject);
  private
    my_Active_Comp:TWinControl;  
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFastRe_Giris: TfrmFastRe_Giris;

implementation

uses unDataMod, UDm_Fast_Report;

{$R *.dfm}

procedure TfrmFastRe_Giris.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if not (qry_Kul_Rep.State in [DssEdit,DssInsert]) then
     Action := CaFree;

     qry_Kul_Rep.Active:=False;
end;

procedure TfrmFastRe_Giris.btnYeniClick(Sender: TObject);
begin
     if not (qry_Kul_Rep.State in [DssEdit,DssInsert]) then
     qry_Kul_Rep.Append;
end;

procedure TfrmFastRe_Giris.btnKaydetClick(Sender: TObject);
begin
     if qry_Kul_Rep.State in [DssEdit,DssInsert] then
     qry_Kul_Rep.Post;
end;

procedure TfrmFastRe_Giris.btnIPTALClick(Sender: TObject);
begin
     if qry_Kul_Rep.State in [DssEdit,DssInsert] then
     qry_Kul_Rep.Cancel;
end;

procedure TfrmFastRe_Giris.btnSilClick(Sender: TObject);
begin
     if qry_Kul_Rep.RecordCount>0 then
     qry_Kul_Rep.Delete;
end;

procedure TfrmFastRe_Giris.btnCikisClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmFastRe_Giris.IB_Edit7ButtonClick(Sender: TObject);
begin
     if Od.Execute then
     qry_Kul_Rep.FieldByName('RAPOR_YERI_ADI').AsString:=Od.FileName;
end;

procedure TfrmFastRe_Giris.qry_Kul_RepAfterInsert(IB_Dataset: TIB_Dataset);
begin
     qry_Kul_Rep.FieldByName('ID').AsInteger:=DataMod.GET_SAYAC_NUM('KUL_RAPOR',True,True,0);
     qry_Kul_Rep.FieldByName('ISLEM_VAR').AsInteger:=0;
     qry_Kul_Rep.FieldByName('ESKI_RAPOR_NO').AsInteger:=0;
     qry_Kul_Rep.FieldByName('UST_ID').AsInteger:=0;
     qry_Kul_Rep.FieldByName('MODUL_ID').AsInteger:=0;
     qry_Kul_Rep.FieldByName('GOSTER').AsInteger:=0;     
end;

procedure TfrmFastRe_Giris.FormCreate(Sender: TObject);
begin
     qry_Kul_Rep.Active:=True;
     DataMod.Form_Comp_Color(frmFastRe_Giris);
end;

procedure TfrmFastRe_Giris.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmFastRe_Giris.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmFastRe_Giris.dts_Kul_RepStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    btnSil.Enabled := False;
    btn_Rapor_Duz.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
  end
  else
  begin
    btnYeni.Enabled:=True;
    if not ((qry_Kul_Rep.Eof) And (qry_Kul_Rep.Bof)) then
    begin
      btnSil.Enabled := True;
    end
    else
    begin
      btnSil.Enabled := False;
    end;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
    btn_Rapor_Duz.Enabled := True;
  end;
end;

procedure TfrmFastRe_Giris.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if Shift = [ssCtrl] then
    begin
      case Key of
      83: //s kaydet
        begin
          if btnKAYDET.Enabled then btnKAYDETClick(Self);
        end; //83 end
      80: //p iptal
        begin
          if btnIptal.Enabled Then btnIptalClick(Self);
        end;
      46: // del delete
        begin
          if btnSIL.Enabled Then btnSILClick(self);
        end;
      end; // case end;
    end//Shift = [ssCtrl] then end
    else
    if Shift = [] then
    begin
      case Key of
      45: //ins kaydet
        begin
          if btnYeni.Enabled then btnYeniClick(Self);
        end;
      end;//acase end
    end; ///if Shift = [] then ENd

end;

procedure TfrmFastRe_Giris.btn_Rapor_DuzClick(Sender: TObject);
begin
     //frxReport1.LoadFromFile(qry_Kul_Rep.FieldByName('RAPOR_YERI_ADI').AsString);
     //frxReport1.DesignReport;
     //Dm_Fast_Report.frxReport1.LoadFromFile(qry_Kul_Rep.FieldByName('RAPOR_YERI_ADI').AsString);
    // Dm_Fast_Report.frxReport1.DesignReport;
end;

procedure TfrmFastRe_Giris.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qry_Kul_Rep.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Yaptýðýnýz deðiþiklikleri kaydediniz veya iptal ediniz.','DÝKKAT',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure TfrmFastRe_Giris.IB_Edit7Enter(Sender: TObject);
begin
     IB_Edit7.Color:=glb_Art_Alan_Renk;
end;

procedure TfrmFastRe_Giris.IB_Edit7Exit(Sender: TObject);
begin
     IB_Edit7.Color:=clWindow;
end;

end.
