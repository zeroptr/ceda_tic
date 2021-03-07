unit IB_Trackbar;

{$INCLUDE IB_Directives.inc}

interface
{
  This component is a IBO data aware trackbar.
  It supports full search capabilities (escape will cancel the search criteria)

	bugs and ToDo:
    - setting the datafield at design time generates an invalid typecast error
}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, DB, DBCtrls, IB_Header, IB_Constants, IB_Components,
{$IFDEF IBO_VCL30_OR_GREATER}
  IBC_Label,
{$ENDIF}
  IB_FieldDataLink;


type
  TIB_CustomTrackBar = class(TTrackBar)
{$DEFINE IB_FieldControl}

{$I IB_WinControl.INT}
  private
    { Private declarations }
    FDisplayLabelAsCaption: Boolean;
    FDataChanging: boolean;
    procedure SetDisplayLabelAsCaption( AValue: Boolean );
    function GetColor: TColor;
    procedure SetColor(const Value: TColor);
  protected
    { Protected declarations }
	  procedure CreateParams(var Params: TCreateParams); override;
		procedure Loaded; override;
    procedure Changed; override;
    property Color: TColor read GetColor write SetColor stored false;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property DisplayLabelAsCaption: Boolean read FDisplayLabelAsCaption
                                            write SetDisplayLabelAsCaption
                                            default false;
  end;

  TIB_Trackbar = class(TIB_CustomTrackbar)
  {$I IB_WinControl.PBL}
  {$IFNDEF HELPSCAN}
  published
//    property Alignment;
    property Caption;
  {$ENDIF}
  end;

procedure Register;

implementation

 {$R *.dcr}

procedure Register;
begin
  RegisterComponents('TechSys', [TIB_TrackBar]);
end;

{$IFDEF IB_FieldControl}

function TIB_CustomTrackbar.GetSearchBuffer: string;
begin Result := DataLink.SearchBuffer; end;
procedure TIB_CustomTrackbar.SetSearchBuffer( AValue: string );
begin DataLink.SearchBuffer := AValue; end;
procedure TIB_CustomTrackbar.SetSearchWithMask( AValue: boolean );
begin DataLink.SearchWithMask := AValue; end;
function TIB_CustomTrackbar.GetSearchWithMask: boolean;
begin Result := DataLink.SearchWithMask; end;
procedure TIB_CustomTrackbar.SetSearchAlways( AValue: boolean );
begin DataLink.SearchAlways := AValue; end;
function TIB_CustomTrackbar.GetSearchAlways: boolean;
begin Result := DataLink.SearchAlways; end;
function TIB_CustomTrackbar.GetDataField: string;
begin Result := DataLink.FieldName; end;
procedure TIB_CustomTrackbar.SetDataField( const AValue: string );
begin
  DataLink.FieldName := AValue;
{$IFNDEF VER90}
{$IFDEF IB_AutoLabel}
  RemakeAutoLabel;
{$ENDIF}
{$ENDIF}
end;
function TIB_CustomTrackbar.GetField: TIB_Column;
begin Result := DataLink.Field; end;

{$ENDIF}

function TIB_CustomTrackbar.GetOnPrepareSQL: TIB_DataLinkEvent;
begin Result := DataLink.OnPrepareSQL; end;
procedure TIB_CustomTrackbar.SetOnPrepareSQL( AValue: TIB_DataLinkEvent );
begin DataLink.OnPrepareSQL := AValue; end;

{$IFNDEF IBG_LookupCombo}
function TIB_CustomTrackbar.GetDataSource: TIB_DataSource;
begin Result := DataLink.DataSource; end;
procedure TIB_CustomTrackbar.SetDataSource( AValue: TIB_DataSource );
begin
  DataLink.DataSource := AValue;
{$IFNDEF VER90}
{$IFDEF IB_AutoLabel}
  RemakeAutoLabel;
{$ENDIF}
{$ENDIF}
end;
{$ENDIF}

procedure TIB_CustomTrackbar.SetIgnoreColorScheme( AValue: boolean );
begin DataLink.IgnoreColorScheme := AValue; end;
function TIB_CustomTrackbar.GetIgnoreColorScheme: boolean;
begin Result := DataLink.IgnoreColorScheme; end;

{$IFNDEF IBG_LookupCombo}
procedure TIB_CustomTrackbar.CMGetDataLink( var Message: TMessage );
begin Message.Result := Integer( DataLink ); end;
procedure TIB_CustomTrackbar.StateChanged( Sender: TIB_DataLink;
                                            IB_DataSource: TIB_DataSource );
begin
  SysStateChanged;
{$IFNDEF VER90}
{$IFDEF IB_AutoLabel}
  RemakeAutoLabel;
{$ENDIF}
{$ENDIF}
end;
{$ENDIF}
procedure TIB_CustomTrackbar.DataChange( Sender: TIB_DataLink;
                                          IB_DataSource: TIB_DataSource;
                                          IB_Field: TIB_Column );
begin SysDataChange( IB_Field ); end;

{$IFNDEF VER90}
{$IFDEF IB_AutoLabel}
procedure TIB_CustomTrackbar.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin inherited; RemakeAutoLabel; end;
procedure TIB_CustomTrackbar.RemakeAutoLabel;
begin
if Assigned(AutoLabel) and not (csDestroying in ComponentState) and
  (Assigned(AutoLabel.theLabel) or (csDesigning in ComponentState)) then
  AutoLabel.Make;
end;
procedure TIB_CustomTrackbar.SetEnabled(Value: Boolean);
begin inherited; RemakeAutoLabel; end;
{$ENDIF}
{$ENDIF}

{$IFDEF IB_CustomEdit}
{$ELSE}{$IFDEF IBC_ListBox}
{$ELSE}{$IFDEF IBG_CustomGrid}
{$ELSE}
procedure TIB_CustomTrackbar.SetBorderStyle( AValue: TBorderStyle );
begin
  if FBorderStyle <> AValue then begin
    FBorderStyle := AValue;
    RecreateWnd;
  end;
end;
{$ENDIF}{$ENDIF}{$ENDIF}

function TIB_CustomTrackbar.CanModify: Boolean;
begin Result := DataLink.CanModify; end;
function TIB_CustomTrackbar.GetReadOnly: Boolean;
begin Result := DataLink.ControlIsReadOnly; end;
procedure TIB_CustomTrackbar.SetReadOnly( AValue: Boolean );
begin DataLink.ControlIsReadOnly := AValue; end;
function TIB_CustomTrackbar.GetPreventDeleting: Boolean;
begin Result := DataLink.ControlPreventsDeleting; end;
procedure TIB_CustomTrackbar.SetPreventDeleting( AValue: Boolean );
begin DataLink.ControlPreventsDeleting := AValue; end;
function TIB_CustomTrackbar.GetPreventEditing: Boolean;
begin Result := DataLink.ControlPreventsEditing; end;
procedure TIB_CustomTrackbar.SetPreventEditing( AValue: Boolean );
begin DataLink.ControlPreventsEditing := AValue; end;
function TIB_CustomTrackbar.GetPreventInserting: Boolean;
begin Result := DataLink.ControlPreventsInserting; end;
procedure TIB_CustomTrackbar.SetPreventInserting( AValue: Boolean );
begin DataLink.ControlPreventsInserting := AValue; end;
function TIB_CustomTrackbar.GetPreventSearching: Boolean;
begin Result := DataLink.ControlPreventsSearching; end;
procedure TIB_CustomTrackbar.SetPreventSearching( AValue: Boolean );
begin DataLink.ControlPreventsSearching := AValue; end;

{$IFNDEF IBG_LookupCombo}
procedure TIB_CustomTrackbar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  SysStateChanged;
end;
{$ENDIF}

procedure TIB_CustomTrackbar.UpdateData( Sender: TIB_DataLink;
                                          IB_DataSource: TIB_DataSource;
                                          IB_Field: TIB_Column );
begin
  SysUpdateData( IB_Field );
end;

{$IFNDEF IBG_LookupCombo}
procedure TIB_CustomTrackbar.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  DataLink.SetFocus;
{$IFDEF IBC_ComboBox}
  SysDataChange( Field );
{$ENDIF}
end;
{$ENDIF}

{$UNDEF IB_FieldControl}

constructor TIB_CustomTrackbar.Create(AOwner: TComponent);
begin
  FIB_FieldDataLink := TIB_FieldDataLink.Create( Self );
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  DataLink.Control := Self;
  DataLink.OnStateChanged := StateChanged;
//  DataLink.OnEditingChanged := nil;
  DataLink.OnDataChange := DataChange;
  DataLink.OnUpdateData := UpdateData;
  FBorderStyle := bsSingle;
  FDisplayLabelAsCaption := false;
  Position := 0;
  FDataChanging:=false;
end;

destructor TIB_CustomTrackbar.Destroy;
begin
	DataSource := nil;
  DataLink.Control := nil;
  DataLink.OnStateChanged := nil;
//  DataLink.OnEditingChanged := nil;
  DataLink.OnDataChange := nil;
  DataLink.OnUpdateData := nil;
  inherited Destroy;
end;

procedure TIB_CustomTrackbar.Loaded;
begin
  inherited Loaded;
  SysStateChanged;
  SysDataChange( nil );
end;

procedure TIB_CustomTrackbar.SysStateChanged;
begin
  if Enabled then begin
  	if DataLink.CanModify then EnableWindow(Handle, Enabled)
    else EnableWindow(Handle, not enabled);
  end;
  if DataLink.CanModify then
  if DataLink.ColorScheme then begin
    Color := DataLink.Color;
  end;
  if DisplayLabelAsCaption and Assigned( Field ) then begin
    Caption := Field.DisplayName;
  end;
end;

procedure TIB_CustomTrackbar.SysDataChange( IB_Field: TIB_Column );
begin
  if (DataLink.State<>dssSearch) and not SearchAlways then begin
    FDataChanging:=true;
    if not Assigned( Field ) then
      Position := 0
    else if Field.IsNumeric and Field.IsNotNull then
      Position := Field.AsInteger
      else Position:=0;
    FDataChanging:=false;
  end;
end;

procedure TIB_CustomTrackbar.SysUpdateData(IB_Field: TIB_Column);
begin
  if (DataLink.State<>dssSearch) and not SearchAlways then begin
    if Assigned( Field ) then
      if Field.IsNumeric and DataLink.CanModify then begin
        Field.AsInteger:=Position;
      end;
  end;
  DataLink.FieldText:=IntToStr(Position);
end;

procedure TIB_CustomTrackbar.Changed;
begin
	if (DataLink.State<>dssInactive) and not( (DataLink.State=dssBrowse) and (Field.AsInteger=Position) ) then begin
    if not FDataChanging and Assigned( Field ) and
       Field.IsNumeric and
       DataLink.Modify then
    begin
      inherited Changed;
      DataLink.ControlIsModified := true;
    end;
  end;
  if (Datalink.State=dssSearch) or SearchAlways then DataLink.FieldText:=IntToStr(Position);
end;

procedure TIB_CustomTrackbar.CMEnter(var Message: TCMEnter);
begin
  inherited;
end;

procedure TIB_CustomTrackbar.CMExit(var Message: TWMNoParams);
begin
  try
    DataLink.UpdateData;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TIB_CustomTrackbar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  TempPosition: integer;
begin
{  TempPosition:=Position;
  if Assigned( Field ) and Field.IsNumeric and DataLink.Modify then
  begin
    Position:=TempPosition;}
    inherited MouseDown(Button, Shift, X, Y);
//  end;
end;

procedure TIB_CustomTrackbar.KeyPress(var Key: Char);
begin
  case Ord(key) of
    VK_ESCAPE:
    begin
      if DataLink.CanModify then begin
        DataLink.Reset;
        Key:=#0;
      end;
			if ( (DataLink.State=dssSearch) or SearchAlways ) and (DataLink.FieldText<>'') then begin
        Position:=0;
      	DataLink.FieldText:='';
      end;
    end;
    VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_END,
    VK_HOME, VK_PRIOR, VK_NEXT: if not DataLink.CanModify then Key:=#0;
  end;
  inherited KeyPress(Key);
end;

procedure TIB_CustomTrackbar.KeyDown(var Key: Word; Shift: TShiftState);
begin
{  if DataLink.CanModify and (Key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_END,
    VK_HOME, VK_PRIOR, VK_NEXT]) and DataLink.Modify then begin
    inherited KeyDown(Key, Shift)
  end else key := 0; }
end;

procedure TIB_CustomTrackbar.SetDisplayLabelAsCaption( AValue: boolean );
begin
  if DisplayLabelAsCaption <> AValue then begin
    FDisplayLabelAsCaption := AValue;
    if DisplayLabelAsCaption then begin
      SysStateChanged;
    end;
  end;
end;

procedure TIB_CustomTrackBar.SetColor(const Value: TColor);
begin
	if inherited Color <> Value then begin
    inherited Color := Value;
    RecreateWnd;
	end;
end;

function TIB_CustomTrackBar.GetColor: TColor;
begin
	Result := inherited Color;
end;

procedure TIB_CustomTrackBar.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of integer = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := longint(Style) or longint(BorderStyles[FBorderStyle]);
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

end.
