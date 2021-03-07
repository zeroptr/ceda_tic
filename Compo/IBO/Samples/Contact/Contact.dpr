program Contact;

uses
  Forms,
  DM_Contact in 'DM_Contact.pas' {dmContact: TDataModule},
  FRM_Contact in 'FRM_Contact.pas' {frmContact},
  IBF_Base in '..\..\IBF_Base.pas' {frmBase};

{$R *.RES}

begin
  Application.Title := 'Contact';
  Application.CreateForm(TdmContact, dmContact);
  Application.CreateForm(TfrmContact, frmContact);
  frmContact.BaseKey := 'Software\Apps\Contact';
  Application.Run;
end.
