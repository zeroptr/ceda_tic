unit
  SearchEdit;

interface

uses
  Windows, StdCtrls, Classes, SysUtils, Forms, ExtCtrls;

type
  TSearchState = (stIdle, stWaiting, stSearching);

  TSearchEdit = class(TCustomEdit)
  private
    FDelimiter: Char;
    FTimer: TTimer;
    FOnSearch: TNotifyEvent;
    FOnStateChange: TNotifyEvent;
    FMinLength: byte;
    FSearchState: TSearchState;
    procedure SetSearchState(Value: TSearchState);
    procedure SetDelayTime(Value: Cardinal);
    function  GetDelayTime: Cardinal;
    property InternalSearchState: TSearchState read FSearchState
                                               write setSearchState;
  protected
    procedure KeyPress(var Key: Char); override;
    procedure Change; override;
    procedure Search(Sender : TObject);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property Delimiter: Char read FDelimiter write FDelimiter;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property DelayTime: Cardinal read getDelayTime
                                 write setDelayTime
                                 default 1000;
    property MinLength: byte read FMinLength
                             write FMinLength
                             default 0;
    property SearchState: TSearchState read FSearchState;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnSearch: TNotifyEvent read FOnSearch write FOnSearch;
    property OnStateChange: TNotifyEvent read FOnStateChange
                                         write FOnStateChange;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Custom', [TSearchEdit]);
end;

constructor TSearchEdit.Create(AOwner : TComponent);
begin
  inherited Create(AOwner); // First call the inherited method.
  FTimer := TTimer.Create(Self); // Create the TTimer.
  FTimer.OnTimer := Search;
  FMinLength := 1; // Default Min Search Length.
  InternalSearchState := stIdle; // Initial SearchState.
end;

destructor TSearchEdit.Destroy;
begin
  FTimer.OnTimer := nil; // Make sure the Timer does not call any methods.
  FTimer.Free; // The Free method first Disables then Frees the TTimer.
  inherited Destroy; // Then call the inherited method.
end;

{ This procedure checks if the SearchText has met the minimum-number of valid
  characters ( i.e. excluding white-spaces and the Delimiting Character ).
  If not, then it sets State = Idle, otherwise it sets State = Waiting.
  The OnTimer event can only happen whle State = Waiting. }
procedure TSearchEdit.Change;
var
  lvText : string;
  i, lvLen : integer;
  lvSearch : boolean;
begin
  lvText := Trim(Text); // Knock off all leading and trainling spaces.
  lvLen := Length(lvText); // Get the length of the resulting string.
  { If the string is not empty
    AND it is necessary to check for a minimum-length at all then ... }
  lvSearch := FMinLength = 0;
  if ( not lvSearch ) and ( lvLen > 0 ) then begin
    lvLen := 0; // Initialise the Length variable to 0.
    for i := 1 to Length(lvText) do begin // Iterate thru' all the characters.
      { Increment the Length variable if the current character is not
        a space or the Delimiting character. }
      if not ( lvText[i] in [' ', FDelimiter] ) then begin
        inc(lvLen);
      end;
    end; { for }
    lvSearch := ( lvLen > FMinLength );
  end; { if }
  if lvSearch then begin
    InternalSearchState := stWaiting;
  end else begin
    InternalSearchState := stIdle;
  end;
  inherited Change;
end;

function TSearchEdit.getDelayTime : Cardinal;
begin
  Result := FTimer.Interval;
end;

procedure TSearchEdit.KeyPress(var Key: Char);
begin
  // Do nothing if the actual search is busy happening.
  if InternalSearchState = stSearching then begin
    Key := #0;
    Beep;
  end else begin
    inherited KeyPress(Key);
  end;
end;

procedure TSearchEdit.Search(Sender : TObject);
begin
  try
    InternalSearchState := stSearching;
    if Assigned(FOnSearch) then begin
      FOnSearch(Self);
    end;
  finally
    InternalSearchState := stIdle;
  end; { try }
end;

procedure TSearchEdit.setDelayTime(Value : Cardinal);
begin
  FTimer.Interval := Value;
end;

procedure TSearchEdit.setSearchState(Value : TSearchState);
begin
  if SearchState <> Value then begin
    FSearchState := Value;
    FTimer.Enabled := ( SearchState = stWaiting ) and
                      not ( csDesigning in ComponentState );
    if Assigned(FOnStateChange) then begin
      FOnStateChange(Self);
    end;
  end;
end;

end.
