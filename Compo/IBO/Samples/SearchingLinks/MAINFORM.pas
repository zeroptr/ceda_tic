unit MAINFORM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Mask, ExtCtrls,

  IB_Session,
  IB_Constants,
  IB_Components,
  IB_Grid,
  IB_ParamEdit,
  IB_SearchEdit,
  IB_Dialogs;

type
  TfrmSearchingLinks = class(TForm)
    cnSearchingLinks: TIB_Connection;
    qrSearchingLinks: TIB_Query;
    dsSearchingLinks: TIB_DataSource;
    pnSearchingLinks: TPanel;
    grSearchingLinks: TIB_Grid;
    seSearchingLinks: TIB_SearchEdit;
    cbSearchingLinks: TComboBox;
    lbSortOrder: TLabel;
    lbSearchCriteria: TLabel;
    lbEnter: TLabel;
    odGDB: TOpenDialog;
    IB_MonitorDialog1: TIB_MonitorDialog;
    procedure FormActivate(Sender: TObject);
    procedure qrSearchingLinksPrepareSQL(Sender: TIB_Statement);
    procedure cbSearchingLinksChange(Sender: TObject);
    procedure qrSearchingLinksAfterPrepare(Sender: TIB_Statement);
    procedure qrSearchingLinksOrderingChanged(IB_Dataset: TIB_Dataset);
    procedure cnOnConnect(Sender: TIB_Connection);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSearchingLinks: TfrmSearchingLinks;

implementation

uses Registry;

{$R *.DFM}

procedure TfrmSearchingLinks.FormActivate(Sender: TObject);
begin
  qrSearchingLinks.Prepare;
  qrSearchingLinks.Active := True;
end;

procedure TfrmSearchingLinks.qrSearchingLinksPrepareSQL(Sender: TIB_Statement);
var
  tmpStr: string;
begin
  with qrSearchingLinks do begin
    case Abs( OrderingItemNo ) of
      1: begin
        tmpStr := OldParamValueLinks.LinkValues[ 'EMP_NO' ]; 
        if OrderingItemNo > 0 then begin
          SQLWhereItems.Add( 'EMP_NO >= :EMP_NO' );
          if (tmpStr = '-999') or (tmpStr = '') or (tmpStr = '999') then begin
            ParamValueLinks.Add( 'EMP_NO=-999' );
          end;
        end else begin
          SQLWhereItems.Add( 'EMP_NO <= :EMP_NO' );
          if (tmpStr = '-999') or (tmpStr = '') or (tmpStr = '999') then begin
            ParamValueLinks.Add( 'EMP_NO=999' );
          end;
        end;
        seSearchingLinks.ParamRefinePos := 3;
      end;
      2: begin
        SQLWhereItems.Add( 'UPPER( LAST_NAME ) STARTING WITH :LAST_NAME' );
        seSearchingLinks.ParamRefinePos := 2;
      end;
      3: begin
        SQLWhereItems.Add( 'UPPER( FIRST_NAME ) STARTING WITH :FIRST_NAME' );
        seSearchingLinks.ParamRefinePos := 2;
      end;
    end;
    if cbSearchingLinks.ItemIndex <> Abs( OrderingItemNo ) - 1 then
      cbSearchingLinks.ItemIndex := Abs( OrderingItemNo ) - 1;
  end;
end;

procedure TfrmSearchingLinks.cbSearchingLinksChange(Sender: TObject);
begin
  if qrSearchingLinks.OrderingItemNo <> cbSearchingLinks.ItemIndex + 1 then
    qrSearchingLinks.OrderingItemNo := cbSearchingLinks.ItemIndex + 1;
end;

procedure TfrmSearchingLinks.qrSearchingLinksAfterPrepare(
  Sender: TIB_Statement);
begin
  qrSearchingLinks.GetOrderingItemsList( cbSearchingLinks.Items );
end;

procedure TfrmSearchingLinks.qrSearchingLinksOrderingChanged(
  IB_Dataset: TIB_Dataset);
begin
  with qrSearchingLinks do begin
    cbSearchingLinks.ItemIndex := Abs( OrderingItemNo ) - 1;
    if Assigned( OrderingField ) and OrderingField.IsText then begin
      seSearchingLinks.AutoUpdate := true;
      lbEnter.Visible := false;
    end else begin
      seSearchingLinks.AutoUpdate := false;
      lbEnter.Visible := true;
    end;
  end;
  seSearchingLinks.SetFocus;
end;

procedure TfrmSearchingLinks.cnOnConnect(
  Sender: TIB_Connection);
var
  MyReg: TRegINIFile;
begin
  MyReg := TRegIniFile.Create( IB_BASEKEY + '\Samples\Connections' );
  with Sender, odGDB do
  try
    if ConnectionStatus = csConnectPending then
    begin
      Database := MyReg.ReadString( 'Connections', 'Employee', Database );
// Allow a quick change of path if the file about to be opened is not found.
// Do not try and supply a GDB file over a mapped drive! If you do be sure to
// change it's path so that the server process can resolve the file's location.
      if ( Protocol = cpLocal ) and not FileExists( Database ) then
      begin
        FileName := Database;
        if Execute then
          Database := FileName
        else
          SysUtils.Abort;
      end;
    end
    else
    if ConnectionStatus = csConnected then
      MyReg.WriteString( 'Connections', 'Employee', Database );
  finally
    MyReg.Free;
  end;
end;

procedure TfrmSearchingLinks.FormCreate(Sender: TObject);
begin
  IB_MonitorDialog1.Show;
end;

end.


