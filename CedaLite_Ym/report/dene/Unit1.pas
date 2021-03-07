unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, StdCtrls, fs_iibxrtti, DB, IBDatabase, fs_ipascal;

type
  TForm1 = class(TForm)
    frxReport1: TfrxReport;
    Button1: TButton;
    IBDatabase1: TIBDatabase;
    fsIBXRTTI1: TfsIBXRTTI;
    fsPascal1: TfsPascal;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure frxReport1GetValue(const VarName: String;
      var Value: Variant);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
{
user_name=sysdba
password=masterkey
lc_ctype=WIN1254
}

//frxReport1.GetDataset()
(frxReport1.GetParentComponent('IBXDatabase1') as fsIBXRTTI1).


end;

procedure TForm1.frxReport1GetValue(const VarName: String;
  var Value: Variant);
begin
      //
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
{procedure Button1OnClick(Sender: TfrxComponent);
var
a:Integer;
b:String;
begin
       IBXQuery1.Close;
       IBXQuery2.Close;
       IBXQuery1.Sql.Add ('WHERE A.ARAC_KOD<>'''' ');
     // if not cb_listkul.Checked then
       IBXQuery2.Sql.Add ('WHERE A.ARAC_KOD=:ARAC_KOD ');

       //WHERE A.ARAC_KOD=:ARAC_KOD

       if DBLookupComboBox2.KeyValue<>null then
       begin
           IBXQuery1.Close;
           IBXQuery1.Sql.Add (' and A.ARAC_KOD=:ARAC_KOD');
           IBXQuery1.ParamByName('ARAC_KOD').value:=DBLookupComboBox2.KeyValue;
           //IBXQuery1.Open;
           //showmessage(DBLookupComboBox2.Text);
           //showmessage(DBLookupComboBox2.KeyValue);
       end;
      if cbar_Kul.Checked then
      begin
           //showmessage(DateEdit1.Date);
           IBXQuery2.Close;
           // IBXQuery2.Sql.Add (' and A.TARIH=:TARIH');
           IBXQuery2.Sql.Add (' and A.TARIH BETWEEN :TARIH AND :TARIH1');
           IBXQuery2.ParamByName('TARIH').Value:=
           Datetostr(DateEdit1.Date);
           IBXQuery2.ParamByName('TARIH1').Value:=
           Datetostr(DateEdit2.Date);
           DateEdit1.Date;
           //IBXQuery2.Open;
      end;


      if cb_siralama.itemindex>-1 then
      begin
           if cb_siralama.itemindex=0 then
           IBXQuery1.Sql.Add (' ORDER BY A.ARAC_KOD');
           if cb_siralama.itemindex=1 then
           IBXQuery1.Sql.Add (' ORDER BY A.PLAKA');
      end;

      if cb_listkul.Checked then
      begin
         //IBXQuery2.Sql.Add ('WHERE A.ARAC_KOD IN :ARAC_KOD ');
         //IBXQuery2.Sql.Add ('WHERE A.ARAC_KOD IN '+'(''zsfsf'')');
         // { }[]
       //b:='(';
{       if CheckListBox1.items.Count>=0 then
       for a:=0 to CheckListBox1.items.Count-1 do
       begin
             if  CheckListBox1.Checked(a) then
             begin
              if a>0 then b:=b+',';
              // b:=b+''''+CheckListBox1.items.Strings(a)+'''';
              b:=b+''''+CheckListBox1.items.Strings(a)+'''';
            end;
       end;
           // b:=b+')';
          // IBXQuery2.Sql.Add ('WHERE A.ARAC_KOD IN ('+b+') ');
          /// ShowMessage(b);
          //IBXQuery2.ParamByName('ARAC_KOD').Value:=b;
      end;
end;

procedure Button3OnClick(Sender: TfrxComponent);
begin

end;

procedure DialogPage1OnShow(Sender: TfrxComponent);
begin
     IBXQuery1.Open;
     while not IBXQuery1.Eof do
     begin
       CheckListBox1.items.add(IBXQuery1.FieldByname('ARAC_KOD').Value);
       IBXQuery1.Next;
     end;
     IBXQuery1.First;
end;

procedure Panel1OnClick(Sender: TfrxComponent);
begin

end;

procedure DetailData1OnBeforePrint(Sender: TfrxComponent);
begin

end;

procedure DetailData1OnMasterDetail(Sender: TfrxComponent);
begin

end;

procedure MasterData1OnBeforePrint(Sender: TfrxComponent);
begin
     if cb_listkul.Checked then
     begin
        //Showmessage(Inttostr(CheckListBox1.Items.IndexOf(IBXQuery1.FieldByname('ARAC_KOD').Value)));
        //Showmessage(IBXQuery1.FieldByname('ARAC_KOD').Value);
         //if CheckListBox1.Items.IndexOf(IBXQuery1.FieldByname('ARAC_KOD').Value)>-1 then
         //if CheckListBox1.Items.IndexOf(IBXQuery1.FieldByname('ARAC_KOD').Value)>-1 then
         if CheckListBox1.Checked(CheckListBox1.Items.IndexOf(IBXQuery1.FieldByname('ARAC_KOD').Value)) then
         begin
          MasterData1.Visible:=True;
          DetailData1.Visible:=True;
         end
         else
         begin
          MasterData1.Visible:=False;
          DetailData1.Visible:=False;
         end;
     end;
end;


procedure MasterData1OnMasterDetail(Sender: TfrxComponent);
begin
     //{

     //}
{end;

begin

end.
}
end;

end.
