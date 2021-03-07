program IBOSource;

uses
  Forms, Registry, IB_Constants,
  IBF_Base in '..\..\IBF_Base.pas' {frmBase},
  FRM_Source in 'FRM_Source.pas' {frmSource};

{$R *.RES}

function FixRegEntries( OldKey, NewKey: string ): string;
begin
  with TRegistry.Create do try
    MoveKey( OldKey, NewKey, False );
    DeleteKey( OldKey );
  finally
    Free;
  end;
  Result := NewKey;
end;

begin
  Application.Initialize;
  Application.HelpFile := 'IBOSOURCE.HLP';
  Application.Title := 'IBO Source Application';
  Application.CreateForm(TfrmSource, frmSource);
  frmSource.BaseKey := FixRegEntries( 'Software\Apps\IBO\Source',
                                      IB_BASEKEY + '\Apps\IBOSource' );
  Application.Run;
end.
