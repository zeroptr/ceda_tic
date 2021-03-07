unit
  DM_Contact;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 

  IB_Header,
  IB_Session,
  IB_Components,
  IB_Process,
  IB_Script,
  IB_DataScan,
  IB_Export,
  IB_SessionProps;

type
  TdmContact = class(TDataModule)
    trContact: TIB_Transaction;
    qrContact: TIB_Query;
    cnContact: TIB_Connection;
    qrHistory: TIB_Query;
    dsContact: TIB_DataSource;
    scContact: TIB_Script;
    qrType: TIB_Query;
    exContact: TIB_Export;
    sp: TIB_SessionProps;
    procedure dmContactCreate(Sender: TObject);
    procedure cnContactLoginFailure(Sender: TIB_Connection);
    procedure cnContactBeforeConnect(Sender: TIB_Connection);
    procedure qrContactBeforePost(IB_DataSet: TIB_DataSet);
    procedure qrContactAfterPost(IB_DataSet: TIB_DataSet);
    procedure qrContactCalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
    procedure qrContactAfterCancel(IB_DataSet: TIB_DataSet);
    procedure qrContactBeforeOpen(IB_DataSet: TIB_Dataset);
    procedure qrContactAfterScroll(IB_Dataset: TIB_Dataset);
    procedure qrContactFilterRecord(ARow: TIB_Row; var Accept: Boolean);
    procedure qrContactGetCanModify(Sender: TIB_Dataset;
      Action: TIB_DatasetCanModify; var CanModify: Boolean);
  private
    { Private declarations }
    RefreshHist: boolean;
  public
    { Public declarations }
  end;

var
  dmContact: TdmContact;

implementation

{$R *.DFM}

procedure TdmContact.dmContactCreate(Sender: TObject);
begin
  if not cnContact.Connected then
    cnContact.Connect;
  if not cnContact.Connected then
  begin
    ShowMessage( 'Unable to connect to server.'#13#10 +
                 'See your system administrator.');
    Application.Terminate;
  end;
end;

procedure TdmContact.cnContactLoginFailure(Sender: TIB_Connection);
begin
  Application.Terminate;
  SysUtils.Abort;
end;

procedure TdmContact.cnContactBeforeConnect(Sender: TIB_Connection);
begin
// Dynamically create the sample GDB if it does not exist.
  if ( cnContact.Protocol = cpLocal ) and
     not FileExists( cnContact.Database ) then
    scContact.Execute;
end;

procedure TdmContact.qrContactBeforePost(IB_DataSet: TIB_DataSet);
begin
// If any of the three fields listed change then the history query needs to
// be refreshed.
  with qrContact do
    RefreshHist := ( State = dssEdit ) and
                   ( FieldByName( 'LASTNAME' ).IsModified or
                     FieldByName( 'FIRSTNAME' ).IsModified or
                     FieldByName( 'USAPHONE' ).IsModified )
end;

procedure TdmContact.qrContactAfterPost(IB_DataSet: TIB_DataSet);
begin
// If any of the three fields listed above change then the history query needs
// to be refreshed.
  if RefreshHist then
    qrHistory.Refresh;
  RefreshHist := false;
end;

procedure TdmContact.qrContactAfterCancel(IB_DataSet: TIB_DataSet);
begin
// Don't need a refresh of the history dataset if changes are cancelled.
  RefreshHist := false;
end;

procedure TdmContact.qrContactCalculateField(Sender: TIB_Statement;
  ARow: TIB_Row; AField: TIB_Column);
begin
// Display the calculated field as the ID value for an example.
  with AField do
    if FieldName = 'STYLE' then
      Assign( ARow.ByName( 'ID' ))
    else
    if FieldName = 'FULLNAME' then
      AsString := ARow.ByName( 'FIRSTNAME' ).AsString + ' ' +
                  ARow.ByName( 'LASTNAME' ).AsString;
end;

procedure TdmContact.qrContactBeforeOpen(IB_DataSet: TIB_Dataset);
begin
//  qrContact.CachedUpdates := true;
  qrType.Open;
end;

procedure TdmContact.qrContactAfterScroll(IB_Dataset: TIB_Dataset);
begin
//  ShowMessage('Hi there!');
end;

procedure TdmContact.qrContactFilterRecord(ARow: TIB_Row;
  var Accept: Boolean);
begin
// Testing the FindRecord() stuff.
  Accept := ARow.ByName('FirstName').AsString <> 'Jason';
end;

procedure TdmContact.qrContactGetCanModify(Sender: TIB_Dataset;
  Action: TIB_DatasetCanModify; var CanModify: Boolean);
begin
// This is code to test the conditional logic to prevent updates.
{
  if Action = cmEdit then begin
    if qrContact.FieldByName( 'FIRSTNAME' ).AsString = 'Jason' then begin
      CanModify := false;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                end;
  end;
}
end;

end.

