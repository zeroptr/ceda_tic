unit unfrmPreview;

interface

uses
  WinTypes, WinProcs, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls,  Buttons, IB_Components, Grids, IB_Grid,
  ComCtrls,Printers, DBCtrls;

type
  TControlClass = class of TControl;
  TfrmPreview = class(TForm)
    Panel1: TPanel;
    btnEnBas: TSpeedButton;
    BtnBas: TSpeedButton;
    btnSon: TSpeedButton;
    btnEnson: TSpeedButton;
    btnPrint: TSpeedButton;
    btnPrintAyar: TSpeedButton;
    txtPageNumber: TEdit;
    PrinterSD: TPrinterSetupDialog;
    PrintD: TPrintDialog;
    pnlTop: TPanel;
    pnlLeft: TPanel;
    PnlRight: TPanel;
    PnlBottom: TPanel;
    Bevel1: TBevel;
    ps: TPageSetupDialog;
    Bevel2: TBevel;
    rbtnTum: TRadioButton;
    rbtnAktif: TRadioButton;
    rbtnBetween: TRadioButton;
    txtTop: TEdit;
    txtLast: TEdit;
    Bevel3: TBevel;

  function CreateControlT (const ControlName: string;X, Y, W, H: Integer): TControl;
  procedure printtopage ();
  Function  ControlRepeat (PNumber : String) : Boolean;
  procedure UnloadImage ();
  Function  GetActivePage () : integer;
  procedure SetActivePage (PNumber : integer);
    procedure BtnBasClick(Sender: TObject);
    procedure btnSonClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintAyarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnEnBasClick(Sender: TObject);
    procedure btnEnsonClick(Sender: TObject);
    procedure txtTopKeyPress(Sender: TObject; var Key: Char);
    procedure txtLastKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
     PGFilename : string;
     PGParameter  :string;

    { Public declarations }
  end;

var
  frmPreview: TfrmPreview;
  PageNumber :integer = 0;
  MaxPageNumber: integer=0;
  MinPageNumber : integer=0;

implementation

uses Windows,Unprn,unfunc;

{$R *.dfm}

Function  TfrmPreview.ControlRepeat (PNumber : String) : Boolean;
Var
  //my_Comp:TWinControl;
  My_Form,b:Tcomponent ;
Begin
   My_Form:= Application.findcomponent ('frmPreview');

   b:=My_Form.FindComponent ('Image' + PNumber);

   if b <> nil  then
     result := True
   else result := False;
end;

procedure TfrmPreview.SetActivePage (PNumber : integer);
var
   Temp : integer;
Begin
    Temp := GetActivePage ;
    if temp<> -1 then
    Begin
          (frmPreview.FindComponent ('Image'+ inttostr (Temp)) as TImage).Visible:=False;
          (frmPreview.FindComponent ('Image'+ inttostr (PNumber)) as TImage).Visible:=True;
           txtPageNumber.Text  := inttostr (PNumber) + ' / ' + inttostr (MaxPageNumber );
    end;
end;

Function  TfrmPreview.GetActivePage () : integer;
Var
  i : integer;
  Bulundu : boolean;
Begin
   bulundu :=False;
   for i:=0 to MaxPageNumber do
   Begin
       if (frmPreview.FindComponent ('Image'+ inttostr (i)) as TImage).Visible = True then
       Begin
           Bulundu:=True;
           break;
       end;
   end;
   if bulundu = True  then
     result := i
   else result := -1;
end;

procedure TfrmPreview.UnloadImage ();
var
    i : integer;
Begin
    for i:=0 to MaxPageNumber do
    begin
        (frmPreview.FindComponent ('Image'+ inttostr (i)) as TImage).destroy;
    end;
    MaxPageNumber :=0;
    PageNumber:=0;
    txtTop.Text :='';
    txtLast.Text :='';
end;

function TfrmPreview.CreateControlT (const ControlName: string;X, Y, W, H: Integer): TControl;
var
  Label1: TImage ;
begin
  if ControlRepeat (controlname)=False then
  Begin
    Label1 := TImage.Create(FrmPreview);
    with Label1 do
    begin
      Align:= alNone; //alClient;
      Parent := frmPreview;
      Name := 'Image' + ControlName;
      Width := PnlRight.Left-PnlRight.Width*2 ;
      Height :=H;
      Left:=pnlLeft.Left+ pnlLeft.Width  ;
      Top:=pnlTop.Top + pnlTop.Height ;
      //SetBounds(X, Y, W, H);
      if ControlName= '0' then  SetActivePage (0)  else Visible:=False;
    end;
    MaxPageNumber := strtoint (ControlName);
    txtPageNumber.Text := '0 / ' + ControlName;
  end;
end;

procedure TfrmPreview.BtnBasClick(Sender: TObject);
var
     Temp : integer;
begin
    Temp := GetActivePage -1;
    if Temp >= 0 then SetActivePage(Temp);
end;

procedure TfrmPreview.btnSonClick(Sender: TObject);
var
   Temp : integer;
begin
    Temp := GetActivePage +1;
    if Temp < MaxPageNumber +1 then SetActivePage(Temp);
end;

procedure TfrmPreview.btnPrintClick(Sender: TObject);
begin
   PrintD.Execute;
   printtopage;
end;

procedure TfrmPreview.printtopage;
Var
    PWhichOne,i  : integer;
Begin
      if rbtnTum.Checked = true then PWhichOne := 1;
      if rbtnAktif.Checked = true then PWhichOne := 2;
      if rbtnBetween.Checked = true then PWhichOne := 3;

      case PWhichOne of
      1: Begin // all
              PrinttoDesignFile (PGFilename,2,1,0,0,PGParameter);
              PrinttoDesignFile (PGFilename,0,1,0,0,PGParameter);
         End;
      2: Begin // curent
            i := GetActivePage ();
            PrinttoDesignFile (PGFilename,2,1,0,0,PGParameter);
            PrinttoDesignFile (PGFilename,0,2,i,0,PGParameter);
         End;
      3: Begin // between
            PrinttoDesignFile (PGFilename,2,1,0,0,PGParameter);
            PrinttoDesignFile (PGFilename,0,3,strtoint (txttop.text) ,strtoint (txtLast.text),PGParameter);
         End;
      end;
end; // printtopage

procedure TfrmPreview.btnPrintAyarClick(Sender: TObject);
begin
     ps.MarginLeft :=0;
     ps.MarginRight :=0;
     ps.MarginTop  :=0;
     ps.MarginBottom :=0;
     ps.Execute ;
end;

procedure TfrmPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    UnloadImage;
end;

procedure TfrmPreview.btnEnBasClick(Sender: TObject);
begin
   SetActivePage(0);
end;

procedure TfrmPreview.btnEnsonClick(Sender: TObject);
begin
    SetActivePage(MaxPageNumber);
end;

procedure TfrmPreview.txtTopKeyPress(Sender: TObject; var Key: Char);
begin
       if isNumeric(Key) = False then key :=#0;
end;

procedure TfrmPreview.txtLastKeyPress(Sender: TObject; var Key: Char);
begin
       if isNumeric(Key) = False then key :=#0;
end;



end.

