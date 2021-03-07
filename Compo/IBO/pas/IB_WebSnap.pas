unit
  IB_WebSnap;

interface

uses
  Classes, WebAdapt;

type
  TIB_EndUserSessionAdapter = class(TEndUserSessionAdapter)
  private
    FOnGetDisplayName: TEndUserGetNameEvent;
  protected
    function GetDisplayNameValue: string; override;
  published
    property OnGetDisplayName: TEndUserGetNameEvent read FOnGetDisplayName
                                                    write FOnGetDisplayName;
  end;

implementation

function TIB_EndUserSessionAdapter.GetDisplayNameValue: string;
begin
  if Assigned( OnGetDisplayName ) then
    OnGetDisplayName( Self, Result )
  else
    Result := inherited GetDisplayNameValue;
end;
    
end.
