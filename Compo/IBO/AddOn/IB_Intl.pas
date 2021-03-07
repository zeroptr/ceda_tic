unit IB_Intl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TIB_Intl_Session = class(TPersistent)
  private
    FIB_ISC_ERR_CODE_MSG: string;
    FIB_ISC_ERR_MSG_MSG:  string;
  published
    property IB_ISC_ERR_CODE_MSG: string read FIB_ISC_ERR_CODE_MSG write FIB_ISC_ERR_CODE_MSG;
    property IB_ISC_ERR_MSG_MSG: string read FIB_ISC_ERR_MSG_MSG write FIB_ISC_ERR_MSG_MSG;
  end;
  TIB_Intl_Connection = class(TPersistent)
  private
    FE_CONNECTED: string;
    FE_NOT_CONNECTED: string;
  published
    property E_CONNECTED: string read FE_CONNECTED write FE_CONNECTED;
    property E_NOT_CONNECTED: string read FE_NOT_CONNECTED write FE_NOT_CONNECTED;
  end;
//***********************************
  TIB_Intl = class(TComponent)
  private
    FSession: TIB_Intl_Session;
    FConnection: TIB_Intl_Connection;
    FConnected:Boolean;
    FVersion :string;
    Procedure SetConnected(val: boolean);

  protected
    Procedure Loaded; override;
    Procedure Connect;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
     property Session: TIB_Intl_Session read FSession write FSession;
     property Connection: TIB_Intl_Connection read FConnection write FConnection;

     property Connected: boolean read FConnected write SetConnected;
  end;

procedure Register;

var IBOInternational: TIB_Intl;

implementation

uses StdCtrls;

constructor TIB_Intl.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FVersion:= 'XXXX';
   FSession:= TIB_Intl_Session.Create;
   with FSession do begin
     FIB_ISC_ERR_CODE_MSG  :='ISC ERROR CODE:';
     FIB_ISC_ERR_MSG_MSG   := 'ISC ERROR MESSAGE:';
   end;
   FConnection:= TIB_Intl_Connection.Create;
   with FConnection do begin
     FE_CONNECTED          := 'Connection has already been established';
     FE_NOT_CONNECTED      := 'Connection has not been established';
   end;
end;

destructor TIB_Intl.Destroy;
begin
  FSession.Free;
  FConnection.Free;
  inherited Destroy;
  if self=IBOInternational then IBOInternational:= nil;
end;

Procedure TIB_Intl.Loaded;
begin
   inherited Loaded;
   if Connected then Connect;
end;

Procedure TIB_Intl.SetConnected(val: boolean);
begin
    FConnected:= val;
    if not val then exit;
    Connect;
end;

Procedure TIB_Intl.Connect;
//var wwFilterDialog: TwwFilterDialogIntl;
begin
    if self=IBOInternational then exit;

    with Session do begin
      IBOInternational.Session.IB_ISC_ERR_CODE_MSG := FIB_ISC_ERR_CODE_MSG;
      IBOInternational.Session.IB_ISC_ERR_MSG_MSG := FIB_ISC_ERR_MSG_MSG;
    end;
    with Connection do begin
      IBOINternational.Connection.E_CONNECTED:= FE_CONNECTED;
      IBOINternational.Connection.E_NOT_CONNECTED:= FE_NOT_CONNECTED;
    end;
end;

procedure Register;
begin
  RegisterComponents('IB Dialogs', [TIB_Intl]);
end;

procedure InitMainIB_Intl;
begin
  IBOInternational:= TIB_Intl.create(Application);
end;

initialization
  InitMainIB_Intl;
finalization
  IBOInternational.Free;
end.
