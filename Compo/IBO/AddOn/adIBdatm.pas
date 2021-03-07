unit
  adIBdatm;

interface

uses
  WinProcs, WinTypes, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs,

  StdCtrls,

  AdDtRegc, { TAdrockDateTimeEdit Component Editor }

  AdDatecN, { TAdrockDateTimeConstants }
  AdDatetm, { TAdrockDateTime class }
  AdDateDt,
  adDateVA,

  DsgnIntf,

  IB_Components,
  IB_FieldDataLink;

type
  TAdrockIB_DateTimeDisplayStyle = ( ibtdsDateStyle,
                                     ibtdsTimeStyle,
                                     ibtdsDateAndTimeStyle,
                                     ibtdsInputStyle,
                                     ibtdsDatabaseFormat,
                                     ibtdsCustom );

  TAdrockIB_DateTimeEdit = class(TAdrockDateTimeEditCustomNoDisplayStyle)
  private
    { Private declarations }
    FCanvas : TControlCanvas;
    fDateBeforeCalendarOpen : TDateTime;    { Holds the date before the calendar was opened }
    fOnChange               : TNotifyEvent;
    fDataLink               : TIB_FieldDataLink;
    InDataChangeEvent       : Boolean;
    fDBDisplayStyle         : TAdrockIB_DateTimeDisplayStyle;
    fRefreshDisplayStyle    : Boolean;
{    fDBGrid                 : TDbGrid;
    fDBGridColumn           : TColumn;
}

    procedure NewChange(Sender: TObject);
    procedure FOnBeforeChangeEvent(Sender : TObject);

    Procedure SetDBDisplayStyle(NewDisplayStyle : TAdrockIB_DateTimeDisplayStyle);

    procedure IB_StateChanged( Sender: TIB_DataLink;
                               IB_DataSource: TIB_DataSource );
    procedure IB_ModifyingChanged( Sender: TIB_DataLink;
                                   IB_DataSource: TIB_DataSource );
    procedure IB_DataChange( Sender: TIB_DataLink;
                             IB_DataSource: TIB_DataSource;
                             IB_Field: TIB_Column );
    procedure IB_UpdateData( Sender: TIB_DataLink;
                             IB_DataSource: TIB_DataSource;
                             IB_Field: TIB_Column );

//  procedure EditingChange(Sender: TObject);
//  procedure UpdateData(Sender: TObject);
//  Procedure DataChange(Sender: TObject);

    Function  GetDate : TAdrockDateTimeValidClass;
    Procedure SetDate(NewDate : TAdrockDateTimeValidClass);

    Function  GetDataField : String;                  { Returns the name of the data field }
    Procedure SetDataField(Const Value : String);   { Assigns name of data field }

    Function  GetDataSource : TIB_DataSource;           { Returns a reference to the data field }
    Procedure SetDataSource(Value : TIB_DataSource);   { Assigns New Data Source }

    function GetColumn: TIB_Column;
    Function GetDisplayText : String; override;
    Procedure OnBeforeCalendarChangeEvent(Sender : Tobject); Override;
    Procedure OnDateChangeEvent(Sender : TObject); override;
  protected
    { Protected declarations }
    procedure   Loaded; override;
    procedure   Notification(AComponent: TComponent; Operation: TOperation); override;
    function    GetColumnText: string;

    Procedure   OpenCalendar; override;
    Function    CloseCalendar : Boolean; override;

    procedure   CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure   CMExit(var Message: TCMExit); message CM_EXIT;

    procedure   WMPaste (var Message: TMessage); message WM_PASTE;
    procedure   WMCut (var Message: TMessage); message WM_CUT;

    Procedure   WMPaint(Var Message : TWMPAINT); message WM_PAINT;
    procedure   KeyPress(var Key: Char); override;
    {$ifdef WIN32}
    procedure   CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    {$ENDIF}
    procedure SysStateChanged;
  public
    { Public declarations }
    Constructor Create(AOwner : TComponent); override;
    Destructor  Destroy; override;

    property Field: TIB_Column read GetColumn;
  published
    { Published declarations }
{
    Property DBGridColumn          : TColumn               Read fDBGridColumn        Write fDBGridColumn;
    Property DBGrid                : TDBGrid               Read fDBGrid              Write fDBGrid;
}
    Property DataSource            : TIB_DataSource        Read GetDataSource        Write SetDataSource;
    Property DataField             : String                Read GetDataField         Write SetDataField;
    Property OnChange              : TNotifyEvent          Read fOnChange            Write fOnChange;

    Property Date                  : TAdrockDateTimeValidClass read GetDate         Write SetDate;
    Property DBDisplayStyle        : TAdrockIB_DateTimeDisplayStyle read fDBDisplayStyle   write SetDBDisplayStyle
       default ibtdsDateStyle;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Adrock', [ TAdrockIB_DateTimeEdit ]);
  RegisterComponentEditor( TAdrockIB_DateTimeEdit,
                           TAdrockDateTimeComponentEditor);
  RegisterPropertyEditor( TypeInfo( string ),
                          TAdrockIB_DateTimeEdit,
                          'DataField',
                          TStringProperty );
end;

Constructor TAdrockIB_DateTimeEdit.Create(AOwner : TComponent);
begin
  inherited Create(Aowner);
  {$ifdef win32}
  ControlStyle := ControlStyle + [csReplicatable];
  {$endif}
  InDataChangeEvent := FALSE;
  fRefreshDisplayStyle := FALSE;
  FDataLink              := TIB_FieldDataLink.Create( Self );
  FDataLink.Control      := Self;
  FDataLink.OnStateChanged := IB_StateChanged;
  FDataLink.OnEditingChanged := IB_ModifyingChanged;
  FDataLink.OnDataChange := IB_DataChange;
  FDataLink.OnUpdateData := IB_UpdateData;
  Inherited OnBeforeDataChange := fOnBeforeChangeEvent;
  Inherited OnChange := NewChange;
{  Inherited ReadOnly := TRUE;}
  fDBDisplayStyle := ibtdsDateStyle;
  SetDBDisplayStyle(fDBDisplayStyle);
end;

Destructor  TAdrockIB_DateTimeEdit.Destroy;
begin
  FDataLink.OnDataChange := nil;
  FDataLink.OnEditingChanged := nil;
  FDataLink.OnUpdateData := nil;
  Inherited Destroy;
end;

function TAdrockIB_DateTimeEdit.GetColumn: TIB_Column;
begin
  Result := FDataLink.Field;
end;

procedure TAdrockIB_DateTimeEdit.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  { if the control being removed from the form is the datasource we are linked to then
    unlink it, if we do not then you get access violations and the form will not save
  }
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;

  { if the control being removed from the form is the DBGrid we are linked to then
    unlink it, if we do not then you get access violations and the form will not save
  }
{  if (Operation = opRemove) and (DBGrid <> nil) and
    (AComponent = DBGrid) then DBGrid := nil;
}
end;

{$ifdef WIN32}
procedure TAdrockIB_DateTimeEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;
{$endif}

procedure TAdrockIB_DateTimeEdit.IB_StateChanged( Sender: TIB_DataLink;
                                                IB_DataSource: TIB_DataSource );
begin
  SysStateChanged;
end;

procedure TAdrockIB_DateTimeEdit.SysStateChanged;
begin
  if FDataLink.ColorScheme then begin
    inherited Color := FDataLink.Color;
  end;
end;

procedure TAdrockIB_DateTimeEdit.IB_ModifyingChanged( Sender: TIB_DataLink;
                                                IB_DataSource: TIB_DataSource );
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TAdrockIB_DateTimeEdit.IB_DataChange( Sender: TIB_DataLink;
                                                IB_DataSource: TIB_DataSource;
                                                IB_Field: TIB_Column );
//Var
//  DateTimeStr : String;
begin
  InDataChangeEvent := TRUE;
  try
    if (fRefreshDisplayStyle = TRUE) then begin
      fRefreshDisplayStyle := False;
      SetDBDisplayStyle(fDBDisplayStyle);
    end;
    Inherited Date.BeginUpdate;
    try
      if (FDataLink.Field = nil) then
        Inherited Date.DateTime := 0
      else if (FDataLink.Field.AsString = '') then
        Inherited Date.DateTime := 0
      else if (FDataLink.State = dssSearch) then
        if FDataLink.SearchBuffer <> '' then
          Inherited Date.DateTime := StrToDateTime( FDataLink.SearchBuffer )
        else
          Inherited Date.DateTime := 0
      else
        Inherited Date.DateTime := FDataLink.Field.AsDateTime;
    finally
      Inherited Date.EndUpdate;
    end;
  finally
    InDataChangeEvent := FALSE;
  end;
end;

procedure TAdrockIB_DateTimeEdit.IB_UpdateData( Sender: TIB_DataLink;
                                                IB_DataSource: TIB_DataSource;
                                                IB_Field: TIB_Column );
begin

  if (GetDataField > '') then begin

    if FDataLink.State = dssSearch then begin
      if Date.DateTime <> 0 then
        FDataLink.SearchBuffer := DateTimeToStr( Date.DateTime )
      else
        FDataLink.SearchBuffer := '';
    end else begin
{      try}
         if (Date.DateTime = 0) then
            FDataLink.Field.AsString := ''
//       else if (fDataLink.Field.SQLType = SQL_TEXT ) then
//         FDataLink.Field.AsString := FormatDate('D MMMM, YYYY HH:MM:SS AM/PM', Date.DateTime)
         else
           FDataLink.Field.AsDateTime := Date.DateTime;
{      except
        MessageDlg('Unable to update the database field : TAdrockIB_DateTimeEdit', mtWarning, [mbOK],0);
      end;}
    end;
  end;
end;

Function TAdrockIB_DateTimeEdit.GetDataField : String;
begin
  Result := FDataLink.FieldName;
end;

Procedure TAdrockIB_DateTimeEdit.SetDataField(Const Value:String);
begin
  FDataLink.Fieldname := Value;
end;

Function TAdrockIB_DateTimeEdit.GetDataSource : TIB_DataSource;
begin
   Result := FDataLink.DataSource;
end;

Procedure TAdrockIB_DateTimeEdit.SetDataSource(Value:TIB_DataSource);
begin
  FDataLink.DataSource := Value;
end;

Procedure TAdrockIB_DateTimeEdit.WMPaint(Var Message : TWMPAINT); 
var
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
begin
{$ifdef WIN32}  if not (csPaintCopy in ControlState) then {$endif}
  begin
    inherited;
    Exit;
  end;
{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(R);
        InflateRect(R, -1, -1);
      end;
      Brush.Color := Color;

      {$ifDef WIN32} if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then {$Endif}
      begin
        S := FDataLink.Field.DisplayText;
        case CharCase of
          ecUpperCase: S := AnsiUpperCase(S);
          ecLowerCase: S := AnsiLowerCase(S);
        end;
      end
      {$ifDef WIN32}
        else
          S := GetDisplayText;
      {$else}
         ;
      {$endif}
      
      if PasswordChar <> #0 then FillChar(S[1], Length(S), PasswordChar);
      TextRect(R, r.Left, R.Top, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

{************************************************************************************************************************}
{* This routine gets called when the control has loaded                                                                 *}
{************************************************************************************************************************}
procedure TAdrockIB_DateTimeEdit.Loaded;
begin
  Inherited Loaded;
{
  if (DBgrid <> nil) then
    fDBGridColumn := DBgrid.Columns.Items[3]
  else
    fDBGridColumn := NIL;
}
  SysStateChanged;
end;

procedure TAdrockIB_DateTimeEdit.KeyPress(var Key: Char);
begin
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
  inherited KeyPress(Key);
end;

Function TAdrockIB_DateTimeEdit.GetDate : TAdrockDateTimeValidClass;
begin
   Result := Inherited Date;
end;

Procedure TAdrockIB_DateTimeEdit.OnDateChangeEvent(Sender : TObject);
begin
  inherited OnDateChangeEvent(Sender);
  Calendar.Date.DateTime := Date.DateTime;
end;

{************************************************************************************************************************}
{* Set a New date for the control                                                                                       *}
{************************************************************************************************************************}
Procedure TAdrockIB_DateTimeEdit.SetDate(NewDate : TAdrockDateTimeValidClass);
begin
  FDataLink.Edit;
  Inherited Date := NewDate;
end;

procedure TAdrockIB_DateTimeEdit.NewChange(Sender: TObject);
begin
  if (csReading in ComponentState) or (csLoading In ComponentState) or (csDesigning In ComponentState) then
    exit;
  if (InDataChangeEvent = FALSE) and (Inherited ReadOnly = FALSE) then
   FDataLink.ControlIsModified := true;
  if (assigned(fOnChange)) then
    fOnChange(Self);
end;

procedure TAdrockIB_DateTimeEdit.FOnBeforeChangeEvent(Sender : TObject);
begin
   FDataLink.Edit;
end;

function TAdrockIB_DateTimeEdit.GetColumnText: string;
begin
  if FDataLink.Field <> nil then
    Result := FDataLink.Field.DisplayText
  else
    if csDesigning in ComponentState then
        Result := Name
    else
        Result := '';
end;

Function TAdrockIB_DateTimeEdit.GetDisplayText : String;
begin
{$ifdef WIN32}
if csPaintCopy in ControlState then
    Result := GetColumnText
  else {$endif}
    Result := FormatDate(ReturnDisplayFormat, Inherited Date.DateTime);
end;

procedure TAdrockIB_DateTimeEdit.CMExit(var Message: TCMExit);
begin
  inherited;
  if (FDataLink.Editing = TRUE) then
    FDataLink.UpdateRecord; { tell data link to update database }
end;

procedure TAdrockIB_DateTimeEdit.CMEnter(var Message: TCMEnter);
begin
  inherited;
  FDataLink.Reset;
end;

procedure TAdrockIB_DateTimeEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TAdrockIB_DateTimeEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

{************************************************************************************************************************}
{* Set the new display style, WindowShort, WinLong, Custom etc..                                                        *}
{************************************************************************************************************************}
Procedure TAdrockIB_DateTimeEdit.SetDBDisplayStyle(NewDisplayStyle : TAdrockIB_DateTimeDisplayStyle);
Var
  DisplayFormat : String;
begin
  fDBDisplayStyle := NewDisplayStyle;
  if (NewDisplayStyle = ibtdsDatabaseFormat) then begin
    if (FDataLink.Field = nil) then begin
      fRefreshDisplayStyle := TRUE;
      exit;
    end;
    DisplayFormat := FDataLink.Field.DisplayFormat;
    CustomDisplayFormat := DisplayFormat;
    DisplayStyle := dtdsCustom;
  end else begin
    case NewDisplayStyle of
      ibtdsDateStyle         : DisplayStyle := dtdsDateStyle;
      ibtdsTimeStyle         : DisplayStyle := dtdsTimeStyle;
      ibtdsDateAndTimeStyle  : DisplayStyle := dtdsDateAndTimeStyle;
      ibtdsInputStyle        : DisplayStyle := dtdsInputStyle;
      ibtdsDatabaseFormat    : DisplayStyle := dtdsDateStyle;
      ibtdsCustom            : DisplayStyle := dtdsCustom;
    end;
  end;
end;

Procedure TAdrockIB_DateTimeEdit.OpenCalendar;
begin
  fDateBeforeCalendarOpen := Inherited Date.Date;
  inherited OpenCalendar;
end;

Function TAdrockIB_DateTimeEdit.CloseCalendar : Boolean;
Var
 NewDate : TDateTime;
 WasOpen : Boolean;
begin
  WasOpen := inherited CloseCalendar;
  Result := WasOpen;
  { Check to see if the date has changed from when the calendar was opened. If it was then  }
  { we put the Database into Edit Mode. Putting the datbase into edit mode restores the     }
  { Original database date. So we restore the date after the table is in edit mode.         }
  if (WasOpen = TRUE) then
   if (fDateBeforeCalendarOpen <> Inherited Date.Date) then
    begin
     NewDate := Inherited Date.Date; { Read the date from the edit control     }
     fDataLink.Edit; { Put database into edit mode : This looses the new date  }
     Date.DateTime := NewDate; { Put the new date into the control             }
    end;
end;

Procedure TAdrockIB_DateTimeEdit.OnBeforeCalendarChangeEvent(Sender : Tobject);
begin
  fDataLink.Edit;
  Inherited OnBeforeCalendarChangeEvent(Sender);
end;

end.
