unit unLogger;

interface

uses
  SysUtils, Classes, IB_Components, IB_Monitor,Forms,Windows,Dialogs;

type
  TdmLOGGER = class(TDataModule)
    dbaLOGGER: TIB_Connection;
    dsqlLOGWRITER: TIB_DSQL;
    dbaMAIN_LOGGER: TIB_Monitor;
    Function CreateInsertStatementForTable(TableName:String;
                                           SourceQuery:TIB_Query;
                                           SourceConnection:TIB_Connection;
                                           SelectZeroRecString:String;
                                           var SONUC:String):Boolean;
     Function GetFieldValue(SourceQuery:TIB_Query;FieldName:String;var Deger:string):Boolean;
     Function Write2Log(     BELGE_TUR,
                             BELGE_ID,
                             BELGE_SID,
                             SIRA_NO,
                             ISLEM:Integer;
                             Kayit:WideString;
                             TANIMLAMA:String):Boolean;

     Function CreateUpdateStatementForTable(TableName:String;
                                            SourceQuery:TIB_Query;
                                            SourceConnection:TIB_Connection;
                                            SelectZeroRecString:String;
                                            UpdateWhereClouse:String;
                                            var SONUC:String):Boolean;
    procedure dbaMAIN_LOGGERMonitorOutputItem(Sender: TObject;
      const NewString: String);
    procedure DataModuleCreate(Sender: TObject);
    Function dbaMain_StartMonitoring:Boolean;
    Function dbaMain_StopMonitoring(Const MonitorTables:String;var Sonuc:WideString):Boolean;
    Procedure dbaMain_CancelMonitoring;
    Function dbaMain_StopMonitoringWrite2log(Const MonitorTables:String;
                                                   BELGE_TUR,
                                                   BELGE_ID,
                                                   BELGE_SID,
                                                   SIRA_NO,
                                                   ISLEM:Integer;
                                                   TANIMLAMA:String):Boolean;
    Procedure Connect2LOG_DB;
  private
    { Private declarations }
    prv_LOG_ENABLED:Boolean;
  public
    { Public declarations }
  end;

var
  dmLOGGER: TdmLOGGER;
  lstMONITOR:TStringList;

const
  YeniSatir = #13#10;

implementation

uses unFUNC,unDATAMOD,ufrmProgramHizmetleri;

{$R *.dfm}

Function TdmLOGGER.CreateInsertStatementForTable(TableName:String;
                                                 SourceQuery:TIB_Query;
                                                 SourceConnection:TIB_Connection;
                                                 SelectZeroRecString:String;
                                                 var SONUC:String):Boolean;
var qryTEMP:TIB_Query;
    i:Integer;
    TempStr,FieldsStr,ValuesStr:String;
begin
  try
    try
      FieldsStr := '';
      ValuesStr := '';
      DataMod.CreateQuery(qryTEMP,Nil,False,SourceConnection);
      qryTEMP.sql.Add('SELECT * FROM '+ TableName + ' WHERE '+ SelectZeroRecString);
      qryTEMP.Open;
      For i := 0 to qryTEMP.FieldCount -1 do
      begin
        if GetFieldValue(SourceQuery,qryTEMP.Fields[i].FullFieldName,TempStr) then
        begin
           FieldsStr := FieldsStr + qryTEMP.Fields[i].SQLName + ',';
           ValuesStr := ValuesStr + TempStr + ',';
        end;
      end;
      if Length(FieldsStr) <> 0 then
      begin
         Sonuc := 'INSERT INTO ' + TableName + ' (' + Copy(FieldsStr,1,length(FieldsStr)-1) + ') ' +
                  'VALUES (' + Copy(ValuesStr,1,Length(ValuesStr)-1) +') ;';
         Result := True;
      end
      else
      begin
        SONUC := '';
        Result := False;
      end;
    except
      Result := False;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryTEMP);
  end;
end;

Function TdmLOGGER.GetFieldValue(SourceQuery:TIB_Query;FieldName:String;var Deger:string):Boolean;
var
  SQLTypeSource:String;
begin
  try
//****************************************************************************//
    if SourceQuery.FieldByName(FieldName).IsNull then
    begin
      Deger := '';
      Result:= False;
      Exit;
    end;
//****************************************************************************//
    SQLTypeSource := SourceQuery.FieldByName(FieldName).SQLTypeSource;
    Deger := SourceQuery.FieldByName(FieldName).AsString;
    if (Copy(SQLTypeSource,1,7) = 'INTEGER') OR (Copy(SQLTypeSource,1,8) = 'SMALLINT') then
    begin
      Result := True;
      Exit;
    end;
//****************************************************************************//
    // Pos('VARCHAR',SQLTypeSource) + a gerek yok cunku ýcýnde char geciyor
    if (Pos('CHAR',SQLTypeSource) + Pos('BLOB',SQLTypeSource)) > 0 then
    begin
      Deger := SQL_Katar(Deger);
      Result := True;
      Exit;
    end;
//****************************************************************************//
    if (Pos('NUMERIC',SQLTypeSource) +
        Pos('DECIMAL',SQLTypeSource) +
        Pos('FLOAT',SQLTypeSource)   +
        Pos('DOUBLE PRECISION',SQLTypeSource)) > 0 then
    begin
      Deger := SQL_Para(SourceQuery.FieldByName(FieldName).AsExtended);
      Result := True;
      Exit;
    end;
//****************************************************************************//
    if Copy(SQLTypeSource,1,4) = 'DATE' then
    begin
      Deger := SQL_Tarih(SourceQuery.FieldByName(FieldName).AsDate);
      Result := True;
      Exit;
    end;
//****************************************************************************//
    if Copy(SQLTypeSource,1,4) = 'TIME' then
    begin
      Deger := SQL_Saat(SourceQuery.FieldByName(FieldName).AsDateTime);
      Result := True;
      Exit;
    end;
//****************************************************************************//
    if Copy(SQLTypeSource,1,9) = 'TIMESTAMP' then
    begin
      Deger := SQL_TarihSaat(SourceQuery.FieldByName(FieldName).AsDateTime);
      Result := True;
      Exit;
    end;
    Result := True;
  except
    Deger := '';
    Result := False;
  end;
end;

Function TdmLOGGER.Write2Log(BELGE_TUR,
                             BELGE_ID,
                             BELGE_SID,
                             SIRA_NO,
                             ISLEM:Integer;
                             Kayit:WideString;
                             TANIMLAMA:String):Boolean;
begin
  Result := False;
  try
    if not prv_LOG_ENABLED then Exit;
    with dsqlLOGWRITER do
    begin
      ParamByName('PRM_LOGGER_ID').AsInteger := dbaLOGGER.Gen_ID('GEN_LOGGER_ID',1);
      ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
      ParamByName('PRM_DONEM_NO').AsInteger := glb_DONEM_NO;
      ParamByName('PRM_MAKINA_ADI').AsString := glb_MAKINA_ADI;
      ParamByName('PRM_IS_SIST_KULLANICI').AsString := glb_IS_SIST_KULLANICI;
      ParamByName('PRM_KULLANICI_ID').AsInteger := glb_USER_ID;
      ParamByName('PRM_KULLANICI_ADI').AsString := glb_USER_NAME;
      ParamByName('PRM_BELGE_TUR').AsInteger := BELGE_TUR;
      ParamByName('PRM_BELGE_ID').AsInteger := BELGE_ID;
      ParamByName('PRM_BELGE_SID').AsInteger := BELGE_SID;
      ParamByName('PRM_SIRA_NO').AsInteger := SIRA_NO;
      ParamByName('PRM_TARIH').AsDate := DataMod.GET_SERVER_DATE;
      ParamByName('PRM_SAAT').AsDateTime := DataMod.GET_SERVER_DATETIME;
      ParamByName('PRM_ISLEM').AsInteger := ISLEM;
      ParamByName('PRM_KAYIT').AsWideString := Kayit;
      ParamByName('PRM_TANIMLAMA').AsString := TANIMLAMA;
      Execute;
      Result := True;
    end;
  except
    raise;
    Result := False;
  end;
end;

Function TdmLOGGER.CreateUpdateStatementForTable(TableName:String;
                                                 SourceQuery:TIB_Query;
                                                 SourceConnection:TIB_Connection;
                                                 SelectZeroRecString:String;
                                                 UpdateWhereClouse:String;
                                                 var SONUC:String):Boolean;
var qryTEMP:TIB_Query;
    i:Integer;
    TempStr,FieldsStr,ValuesStr:String;
begin
  try
    try
      FieldsStr := '';
      ValuesStr := '';
      DataMod.CreateQuery(qryTEMP,Nil,False,SourceConnection);
      qryTEMP.sql.Add('SELECT * FROM '+ TableName + ' WHERE '+ SelectZeroRecString);
      qryTEMP.Open;
      For i := 0 to qryTEMP.FieldCount -1 do
      begin
        if GetFieldValue(SourceQuery,qryTEMP.Fields[i].FullFieldName,TempStr) then
        begin
           FieldsStr := FieldsStr + qryTEMP.Fields[i].SQLName +  ' = ' + TempStr +',';
        end;
      end;
      if Length(FieldsStr) <> 0 then
      begin
         Sonuc := 'UPDATE ' + TableName + ' SET ' + Copy(FieldsStr,1,length(FieldsStr)-1) + ' WHERE ' + UpdateWhereClouse + ';';
         Result := True;
      end
      else
      begin
        SONUC := '';
        Result := False;
      end;
    except
      Result := False;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryTEMP);
  end;
end;

procedure TdmLOGGER.dbaMAIN_LOGGERMonitorOutputItem(Sender: TObject;
  const NewString: String);
begin
  lstMONITOR.Add(NewString);
end;

procedure TdmLOGGER.DataModuleCreate(Sender: TObject);
begin
  lstMONITOR := TStringList.Create;
end;

function TdmLOGGER.dbaMain_StartMonitoring:Boolean;
begin
  Result := False;
  if not prv_LOG_ENABLED then Exit;
  if dbaMAIN_LOGGER.Enabled then
  begin
    Result := False;
    Application.MessageBox('Loglama meþgül lütfen tekrar deneyiniz.','Dikkat',MB_ICONINFORMATION);
    Exit;
  end;
  lstMONITOR.Clear;
  dbaMAIN_LOGGER.Enabled := True;
  Result := True;
end;

function TdmLOGGER.dbaMain_StopMonitoring(const MonitorTables:String;var Sonuc:WideString):Boolean;
var
  i,x,y,z,q:Integer;
  Line,Karsilastir:String;
label TAMAMLANDI;
    //Monitor  tables mutlaka sonu ',' le bitecek  þekilde gelmeli 'CARI,' gibi
begin
  dbaMAIN_LOGGER.Enabled := False;
  if lstMONITOR.Count = 0 then
  begin
    Result := True;
    Exit;
  end;

  Result := False;

  Sonuc := '';
  for i := 0 to lstMONITOR.Count -1 do
  begin
    Line := lstMONITOR.Strings[i];
    if Pos('PARAMS = [',Line) <> 0 then
    begin
      repeat
        x := Pos(YeniSatir,Line);
        if x >= 10 then
        begin
          if (Copy(Copy(Line,1,x-1),1,10) = 'PARAMS = [') AND not (Trim(Copy(Line,1,x-1)) = 'PARAMS = [  ]' ) then
          begin
            Z := StrToInt(Copy(Line,x-2,2));
            Line := Copy(Line,x+2,Length(Line));
            Karsilastir := MonitorTables;
            repeat
              y := Pos(Copy(Karsilastir,1,Pos(',',Karsilastir)-1),Line);  // ilk virgüle kadar olan tablo adýnýn line içinde geçip geçmediði
              if  y = 0 then // ilk virgüle  kadar bulunamadý
              begin
                Karsilastir := Copy(Karsilastir ,Pos(',',Karsilastir)+1,Length(Karsilastir)); // ilk virgüle kadar olan kýsým kesildi
              end
              else
              begin   // burada aranan kayýtlalardan biri bulundu sonuca eklenecek;
                if Trim(Copy(Line,1,y-1)) <> '' then
                begin
                  Karsilastir := Copy(Karsilastir ,Pos(',',Karsilastir)+1,Length(Karsilastir)); // ilk virgüle kadar olan kýsým kesildi
                  Continue;
                end;
                Sonuc := Sonuc + Copy(Karsilastir,1,Pos(',',Karsilastir)-1)  + YeniSatir;  // virgülden önce gelen ifade  alýndý CARI gýbý
                Sonuc := Sonuc + '----------------------------------------------------------' + YeniSatir;
                for q := 1 to z do
                begin
                  Sonuc := Sonuc + Copy(Line,1,Pos(YeniSatir,Line)-1) + YeniSatir;
                  Line := Copy(Line,Pos(YeniSatir,Line)+2,Length(Line));
                end;
                Sonuc := Sonuc + '----------------------------------------------------------'+ YeniSatir;
                Line := '';
                Goto TAMAMLANDI;
              end;
            until Pos(',',Karsilastir) = 0;
          end;
        end;
        Line := Copy(Line,x+2,Length(Line));
TAMAMLANDI:
      until Pos(YeniSatir,Line) = 0;
    end; // if Pos('PARAMS = [',Line) <> 0 then
  end;
  Result := True;
end;

Procedure TdmLOGGER.dbaMain_CancelMonitoring;
begin
  dbaMAIN_LOGGER.Enabled := False;
  lstMONITOR.Clear;
end;

Function TdmLOGGER.dbaMain_StopMonitoringWrite2log(Const MonitorTables:String;
                                                   BELGE_TUR,
                                                   BELGE_ID,
                                                   BELGE_SID,
                                                   SIRA_NO,
                                                   ISLEM:Integer;
                                                   TANIMLAMA:String):Boolean;
var
  Sonuc:WideString;  //Monitor  tables mutlaka sonu ',' le bitecek  þekilde gelmeli 'CARI,' gibi
begin
  Result := False;
  if not prv_LOG_ENABLED then Exit;
  Result := dbaMain_StopMonitoring(MonitorTables,Sonuc);
  if Result then
  begin
    result := Write2Log(BELGE_TUR,
                        BELGE_ID,
                        BELGE_SID,
                        SIRA_NO,
                        ISLEM,
                        Sonuc,
                        TANIMLAMA);
  end;
end;

Procedure TdmLOGGER.Connect2LOG_DB;
label KONTROL;
begin
  prv_LOG_ENABLED := (DataMod.GETParam(22,'LOG_ENABLE',0)='1');
  dbaLOGGER.Connected := False;
  if prv_LOG_ENABLED then
  begin
KONTROL:
    Application.CreateForm(TfrmProgramHizmetleri, frmProgramHizmetleri);
    frmProgramHizmetleri.Ayar_Yukle;
    if Trim(frmProgramHizmetleri.pbl_LOG_DB_PATH) = '' then
    begin
       frmProgramHizmetleri.ShowModal;
       frmProgramHizmetleri.Release;
       Goto KONTROL;
    end;
    DataMod.AssignConnProps(dmLOGGER.dbaLOGGER,
                            frmProgramHizmetleri.pbl_LOG_CONN_LOCAL,
                            frmProgramHizmetleri.pbl_LOG_SERVER,
                            frmProgramHizmetleri.pbl_LOG_DB_PATH,
                            frmProgramHizmetleri.pbl_LOG_USER,
                            frmProgramHizmetleri.pbl_LOG_PASS_WORD);
    try
      dbaLOGGER.Connect;
    except
      Application.MessageBox('LOG veritabanýna baðlanýlamadý..','Dikkat',MB_ICONERROR);
      frmProgramHizmetleri.ShowModal;
      frmProgramHizmetleri.Release;
      Halt;
    end;
    frmProgramHizmetleri.Release;
  end;
end;
end.
