{*******************************************************}
{                                                       }
{       TiKeyBoard Component                            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iKeyBoard;{$endif}
{$ifdef iCLX}unit QiKeyBoard;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iClasses,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiClasses, QiCustomComponent;{$ENDIF}

type
  TiKeyBoardButtonStyle = (ikbbsStandard, ikbbsShift, ikbbsLock, ikbbsAccent, ikbbsScroll, ikbbsCtrl, ikbbsAlt, ikbbsNumLock, ikbbsSpacer);
  TiKeyBoardStyle       = (ikbs104, ikbs87, ikbs74, ikbs61, ikbsNumericKeyPad, ikbsCustom1, ikbsCustom2);

  TKeyData = record
    Style           : TiKeyBoardButtonStyle;

    CaptionStandard : String;
    CaptionShift    : String;

    VirtualKeyCode  : Integer;

    Size            : Integer;
    AcceptLock      : Boolean;
  end;

  TiKeyBoardButton = class(TiButton)
  private
    FVisible             : Boolean;
    FStyle               : TiKeyBoardButtonStyle;
    FBackGroundColor     : TColor;
    FFontColor           : TColor;
    FUseControlFontColor : Boolean;
    FVirtualKeyCode      : Integer;
    FAcceptLock          : Boolean;
    FShiftLocked         : Boolean;

    FRow                 : Integer;
    FSize                : Integer;
    FDoubleHeight        : Boolean;

    FCaptionShift        : String;
    FCaptionStandard     : String;

    FLockActive          : Boolean;
    FShiftActive         : Boolean;
    FCtrlActive          : Boolean;
    FAltActive           : Boolean;
    FShowShift           : Boolean;
    FNumLockActive       : Boolean;
    FDown                : Boolean;
    FFocusHandle         : Integer;

    procedure SetVisible            (const Value: Boolean);
    procedure SetStyle              (const Value: TiKeyBoardButtonStyle);
    procedure SetBackGroundColor    (const Value: TColor);
    procedure SetFontColor          (const Value: TColor);
    procedure SetUseControlFontColor(const Value: Boolean);
    procedure SetAcceptLock         (const Value: Boolean);
    procedure SetShiftLocked        (const Value: Boolean);
    procedure SetCaptionShift       (const Value: String);
    procedure SetCaptionStandard    (const Value: String);
    procedure SetDoubleHeight       (const Value: Boolean);
    procedure SetRow                (const Value: Integer);
    procedure SetSize               (const Value: Integer);
    procedure SetVirtualKeyCode     (const Value: Integer);
  protected
    function GetDisplayString: String;
    function GetIsToggle: Boolean;

    procedure UpdateKeyState;
 public
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer); override;

    procedure Draw(const Canvas : TCanvas; ControlEnabled: Boolean); override;

    constructor Create; override;

    property LockActive            : Boolean               read FLockActive            write FLockActive;
    property ShiftActive           : Boolean               read FShiftActive           write FShiftActive;
    property CtrlActive            : Boolean               read FCtrlActive            write FCtrlActive;
    property AltActive             : Boolean               read FAltActive             write FAltActive;
    property NumLockActive         : Boolean               read FNumLockActive         write FNumLockActive;

    property DisplayString         : String                read GetDisplayString;
    property IsToggle              : Boolean               read GetIsToggle;
    property Down                  : Boolean               read FDown                  write FDown;

    property FocusHandle           : Integer               read FFocusHandle           write FFocusHandle;
  published
    property Visible               : Boolean               read FVisible               write SetVisible               default True;
    property Style                 : TiKeyBoardButtonStyle read FStyle                 write SetStyle;
    property BackGroundColor       : TColor                read FBackGroundColor       write SetBackGroundColor       default clBtnFace;
    property FontColor             : TColor                read FFontColor             write SetFontColor             default clBlack;
    property UseControlFontColor   : Boolean               read FUseControlFontColor   write SetUseControlFontColor   default True;

    property CaptionStandard       : String                read FCaptionStandard       write SetCaptionStandard;
    property CaptionShift          : String                read FCaptionShift          write SetCaptionShift;

    property AcceptLock            : Boolean               read FAcceptLock            write SetAcceptLock;
    property ShiftLocked           : Boolean               read FShiftLocked           write SetShiftLocked;

    property VirtualKeyCode        : Integer               read FVirtualKeyCode        write SetVirtualKeyCode;

    property Row                   : Integer               read FRow                   write SetRow;
    property Size                  : Integer               read FSize                  write SetSize;
    property DoubleHeight          : Boolean               read FDoubleHeight          write SetDoubleHeight;
  end;
  //----------------------------------------------------------------------------------------------
  TiKeyBoard = class(TiCustomComponent)
  private
    FButtonList      : TStringList;
    FRowListManager  : TStringList;

    FFont            : TFont;
    FOuterMargin     : Integer;

    //{$ifdef iVCL}FPreviousFocus : HWND;{$endif}

    FMouseDownObject : TiKeyBoardButton;

    FSecondRowMargin : Integer;
    FStyle           : TiKeyBoardStyle;
    FFocusHandle     : Integer;
    FLockFocusHandle : Boolean;
  private
    procedure SetFocusHandle(const Value: Integer);
  protected
    procedure SetFont           (const Value: TFont);
    procedure SetOuterMargin    (const Value: Integer);
    procedure SetSecondRowMargin(const Value: Integer);

    procedure CalcRects;

    function  CreateDefaultButton: TiKeyBoardButton;
    procedure CreateSpacer(Row, Size: Integer);
    function  CreateButton(VirtualKeyCode, Row, Size: Integer; DoubleHeight, ShiftLocked: Boolean): TiKeyBoardButton;

    function GetKeyCount: Integer;
    function GetKeyButton(Index: Integer): TiKeyBoardButton;

    procedure UnSelectAllOthers(Button: TiKeyBoardButton);
    procedure UnSelectShiftCtrlAlt;

    procedure SetLockStatus   (Value: Boolean);
    procedure SetShiftStatus  (Value: Boolean);
    procedure SetCtrlStatus   (Value: Boolean);
    procedure SetAltStatus    (Value: Boolean);
    procedure SetNumLockStatus(Value: Boolean);
    procedure SetStyle        (const Value: TiKeyBoardStyle);

    procedure ButtonInvalidate(Sender : TObject);
    procedure FontChange      (Sender : TObject);

    procedure ButtonClick     (Sender : TObject);

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    {$ifdef iVCL}procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;{$endif}

    function  GetRowSize(RowList: TStringList): Integer;
    procedure RemoveAllButtons;
    procedure RemoveAllRows;

    procedure Setup104;
    procedure Setup087;
    procedure Setup074;
    procedure Setup061;
    procedure SetupNumericKeyPad;
    procedure SetupCustom1;
    procedure SetupCustom2;

    procedure LoadKeyData(Index, VirtualKeyCode: Integer; Style: TiKeyBoardButtonStyle; CaptionStandard, CaptionShift: String; AcceptLock: Boolean);
    procedure LoadKeyDataArray;

    procedure iDoKillFocus;                      override;
    procedure iPaintTo(Canvas: TCanvas);         override;

    procedure DefineProperties(Filer: TFiler);   override;
    procedure WriteItems      (Writer: TWriter);
    procedure ReadItems       (Reader: TReader);
    function  DoWriteItems: Boolean;

    property KeyCount                  : Integer          read GetKeyCount;
    property KeyButton[Index: Integer] : TiKeyBoardButton read GetKeyButton;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    procedure SavePropertiesToFile  (FileName: String); override;
    procedure LoadPropertiesFromFile(FileName: String); override;

    procedure SetFocusHandleToActiveWindow;

  published
    property Font            : TFont           read FFont            write SetFont;
    property OuterMargin     : Integer         read FOuterMargin     write SetOuterMargin;
    property SecondRowMargin : Integer         read FSecondRowMargin write SetSecondRowMargin;
    property Style           : TiKeyBoardStyle read FStyle           write SetStyle;

    property BackGroundColor;
    property BorderStyle;
    property Width            default 115;
    property Height           default 140;

    property FocusHandle     : Integer         read FFocusHandle     write SetFocusHandle;
  end;

implementation

type
  TWriterAccess = class(TWriter)end;
  TReaderAccess = class(TReader)end;

var
  KeyDataArray : array[0..255] of TKeyData;
//****************************************************************************************************************************************************
constructor TiKeyBoard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
                                     
  Width   := 750;
  Height  := 225;

  FOuterMargin     := 5;
  FSecondRowMargin := 10;

  FFont := TFont.Create; FFont.Style := [fsBold]; Font.OnChange := FontChange;

  FButtonList     := TStringList.Create;
  FRowListManager := TStringList.Create; FRowListManager.Sorted := True;

  LoadKeyDataArray;
  Setup104;
end;
//****************************************************************************************************************************************************
destructor TiKeyBoard.Destroy;
begin
  FFont.Free;

  RemoveAllRows;
  FRowListManager.Free;

  RemoveAllButtons;
  FButtonList.Free;

  inherited;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.RemoveAllButtons;
begin
  while FButtonList.Count > 0 do
    begin
      FButtonList.Objects[0].Free;
      FButtonList.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.RemoveAllRows;
begin
  while FRowListManager.Count > 0 do
    FRowListManager.Delete(0);
end;
//*************************************************************************************************************************************
function TiKeyBoard.GetKeyCount: Integer;
begin
  Result := FButtonList.Count;
end;
//*************************************************************************************************************************************
function TiKeyBoard.GetKeyButton(Index: Integer): TiKeyBoardButton;
begin
  Result := FButtonList.Objects[Index] as TiKeyBoardButton;
end;
//****************************************************************************************************************************************************
function TiKeyBoard.CreateDefaultButton: TiKeyBoardButton;
begin
  Result                 := TiKeyBoardButton.Create;
  Result.OnInvalidate    := ButtonInvalidate;
  Result.OnClick         := ButtonClick;
  FButtonList.AddObject('', Result);
end;
//*************************************************************************************************************************************
function TiKeyBoard.CreateButton(VirtualKeyCode, Row, Size: Integer; DoubleHeight, ShiftLocked: Boolean): TiKeyBoardButton;
begin
  Result                 := CreateDefaultButton;
  Result.Style           := KeyDataArray[VirtualKeyCode].Style;
  Result.VirtualKeyCode  := KeyDataArray[VirtualKeyCode].VirtualKeyCode;
  Result.CaptionStandard := KeyDataArray[VirtualKeyCode].CaptionStandard;
  Result.CaptionShift    := KeyDataArray[VirtualKeyCode].CaptionShift;
  Result.AcceptLock      := KeyDataArray[VirtualKeyCode].AcceptLock;
  Result.Row             := Row;
  Result.Size            := Size;
  Result.DoubleHeight    := DoubleHeight;
  Result.ShiftLocked     := ShiftLocked;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.CreateSpacer(Row, Size: Integer);
var
  iButton : TiKeyBoardButton;
begin
  iButton              := TiKeyBoardButton.Create;
  iButton.Caption      := Caption;
  iButton.Row          := Row;
  iButton.Size         := Size;
  iButton.Style        := ikbbsSpacer;

  FButtonList.AddObject('', iButton);
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.SetOuterMargin    (const Value:Integer);begin SetIntegerProperty(Value,FOuterMargin,    irtInvalidate);end;
procedure TiKeyBoard.SetSecondRowMargin(const Value:Integer);begin SetIntegerProperty(Value,FSecondRowMargin,irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.SetFont(const Value: TFont);begin FFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.FontChange(Sender: TObject);
var
  i       : Integer;
  iButton : TiButton;
begin
  for i := 0 to FButtonList.Count-1 do                                    
    begin
      iButton := FButtonList.Objects[i] as TiButton;
      iButton.Font.Assign(FFont);
    end;
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.SetStyle(const Value: TiKeyBoardStyle);
begin
  if FStyle <> Value then
    begin
      FStyle := Value;
      case FStyle of
        ikbs104           : Setup104;
        ikbs87            : Setup087;
        ikbs74            : Setup074;
        ikbs61            : Setup061;
        ikbsNumericKeyPad : SetupNumericKeyPad;
        ikbsCustom1       : SetupCustom1;
        ikbsCustom2       : SetupCustom2;
      end;
      InvalidateChange;
    end
end;
//*************************************************************************************************************************************
function TiKeyBoardButton.GetIsToggle: Boolean;
begin
  case FStyle of
    ikbbsStandard : Result := False;
    ikbbsShift    : Result := True;
    ikbbsLock     : Result := True;
    ikbbsAccent   : Result := True;
    ikbbsScroll   : Result := True;
    ikbbsCtrl     : Result := True;
    ikbbsAlt      : Result := True;
    ikbbsNumLock  : Result := True;
    ikbbsSpacer   : Result := False;
    else            Result := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.ButtonInvalidate(Sender: TObject);
begin
  InvalidateChange;
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.UnSelectAllOthers(Button: TiKeyBoardButton);
var
  x : Integer;
begin
  for x := 0 to FButtonList.Count-1 do
    begin
      if  FButtonList.Objects[x] = Button                                   then Continue;
      if (FButtonList.Objects[x] as TiKeyBoardButton).Style <> Button.Style then Continue;
      (FButtonList.Objects[x] as TiKeyBoardButton).Down := False;
    end;
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.UnSelectShiftCtrlAlt;
var
  x : Integer;
begin
  for x := 0 to FButtonList.Count-1 do
    begin
      case (FButtonList.Objects[x] as TiKeyBoardButton).Style of
        ikbbsShift, ikbbsCtrl, ikbbsAlt, ikbbsAccent : (FButtonList.Objects[x] as TiKeyBoardButton).Down := False;
      end;
    end;
  SetShiftStatus(False);
  SetCtrlStatus (False);
  SetAltStatus  (False);
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.SetLockStatus(Value: Boolean);
var
  x : Integer;
begin
  for x := 0 to FButtonList.Count-1 do (FButtonList.Objects[x] as TiKeyBoardButton).LockActive := Value
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.SetShiftStatus(Value: Boolean);
var
  x : Integer;
begin
  for x := 0 to FButtonList.Count-1 do (FButtonList.Objects[x] as TiKeyBoardButton).ShiftActive := Value
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.SetCtrlStatus(Value: Boolean);
var
  x : Integer;
begin
  for x := 0 to FButtonList.Count-1 do (FButtonList.Objects[x] as TiKeyBoardButton).CtrlActive := Value
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.SetAltStatus(Value: Boolean);
var
  x : Integer;
begin
  for x := 0 to FButtonList.Count-1 do (FButtonList.Objects[x] as TiKeyBoardButton).AltActive := Value
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.SetNumLockStatus(Value: Boolean);
var
  x : Integer;
begin
  for x := 0 to FButtonList.Count-1 do (FButtonList.Objects[x] as TiKeyBoardButton).NumLockActive := Value
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Buttons', ReadItems, WriteItems, DoWriteItems);
end;
//****************************************************************************************************************************************************
function TiKeyBoard.DoWriteItems: Boolean;
begin
  Result := FButtonList.Count <> 0;
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.WriteItems(Writer: TWriter);
var
  x : Integer;
begin
  TWriterAccess(Writer).WriteValue(vaCollection);
  for x := 0 to FButtonList.Count-1 do
  begin
    Writer.WriteListBegin;
    WriterWriteProperties(Writer, FButtonList.Objects[x] as TPersistent);
    Writer.WriteListEnd;
  end;
  Writer.WriteListEnd;
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.ReadItems(Reader: TReader);
var
  Button : TiKeyBoardButton;
begin
  RemoveAllButtons;
  if not Reader.EndOfList then RemoveAllButtons;
  if TReaderAccess(Reader).ReadValue <> vaCollection then exit;
  while not Reader.EndOfList do
  begin
    Button := CreateDefaultButton;
    Reader.ReadListBegin;
    while not Reader.EndOfList do TReaderAccess(Reader).ReadProperty(Button);
    Reader.ReadListEnd;
  end;
  Reader.ReadListEnd; 
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.ButtonClick(Sender: TObject);
var
  Button : TiKeyBoardButton;
begin
  Button := Sender as TiKeyBoardButton;

  case Button.Style of
    ikbbsStandard : begin
                      UnSelectShiftCtrlAlt;
                    end;
    ikbbsShift    : begin
                      UnselectAllOthers(Sender as TiKeyBoardButton);
                      SetShiftStatus((Sender as TiKeyBoardButton).Down);
                    end;
    ikbbsLock     : begin
                      UnselectAllOthers(Sender as TiKeyBoardButton);
                      SetLockStatus((Sender as TiKeyBoardButton).Down);
                    end;
    ikbbsAccent   : begin
                      UnselectAllOthers(Sender as TiKeyBoardButton);
                    end;
    ikbbsScroll   : begin
                      UnselectAllOthers(Sender as TiKeyBoardButton);
                    end;
    ikbbsCtrl     : begin
                      UnselectAllOthers(Sender as TiKeyBoardButton);
                      SetCtrlStatus((Sender as TiKeyBoardButton).Down);
                    end;
    ikbbsAlt      : begin
                      UnselectAllOthers(Sender as TiKeyBoardButton);
                      SetAltStatus((Sender as TiKeyBoardButton).Down);
                    end;
    ikbbsNumLock  : begin
                      UnselectAllOthers(Sender as TiKeyBoardButton);
                      SetNumLockStatus((Sender as TiKeyBoardButton).Down);
                    end;
    ikbbsSpacer   : begin

                    end;
  end;

end;
//*************************************************************************************************************************************
{$ifdef iVCL}
procedure TiKeyBoard.WMSetFocus(var Message: TMessage);
var
  x : Integer;
begin
  if not FLockFocusHandle then
    begin
      FFocusHandle := Message.WParam;
      for x := 0 to FButtonList.Count-1 do
        (FButtonList.Objects[x] as TiKeyBoardButton).FocusHandle := FFocusHandle;
    end;
end;
{$endif}
//*************************************************************************************************************************************
procedure TiKeyBoard.SetFocusHandleToActiveWindow;
begin
  FLockFocusHandle := True;
  {$ifdef iVCL}
  FocusHandle      := GetActiveWindow;
  {$endif}
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.SetFocusHandle(const Value: Integer);
var
  x : Integer;
begin
  FFocusHandle     := Value;
  FLockFocusHandle := Value <> 0;
  for x := 0 to FButtonList.Count-1 do
    (FButtonList.Objects[x] as TiKeyBoardButton).FocusHandle := Value;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i           : Integer;
  iButton     : TiKeyBoardButton;
  ScreenPoint : TPoint;
begin
  if (csDesigning in ComponentState) then exit;
  if Button <> mbLeft                then exit;
  if not FLockFocusHandle then
    begin
      SetFocus;
      {$ifdef iVCL}Windows.SetFocus(FocusHandle);{$endif}                   
    end
  else
    begin
      {$ifdef iVCL}Windows.SetFocus(FocusHandle);{$endif}
    end;


  ScreenPoint := ClientToScreen(Point(X, Y));

  for i := 0 to FButtonList.Count-1 do
    begin
      iButton := FButtonList.Objects[i] as TiKeyBoardButton;
      if not iButton.Visible then Continue;
      if PtInRect(iButton.DrawRect, Point(X, Y)) then
        begin
          FMouseDownObject := iButton;
          FMouseDownObject.iMouseDown(Button, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.iMouseMove(Shift: TShiftState; X, Y: Integer);
begin

end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ScreenPoint         : TPoint;
  TempMouseDownObject : TiKeyBoardButton;
begin
  if (csDesigning in ComponentState) then Exit;

  //{$ifdef iVCL}Windows.SetFocus(FocusHandle);{$endif}

  ScreenPoint := ClientToScreen(Point(X, Y));

  if Assigned(FMouseDownObject) then
    begin
      TempMouseDownObject := FMouseDownObject;
      TempMouseDownObject.iMouseUp(Button, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y);

      FMouseDownObject := nil;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.iDoKillFocus;
var
  i : Integer;
begin
//  FMouseDownObject := nil;
  if (csDesigning in ComponentState) then exit;

  for i := 0 to FButtonList.Count-1 do
    (FButtonList.Objects[i] as TiButton).MouseDown := False;
  inherited;
end;
//****************************************************************************************************************************************************
function TiKeyBoard.GetRowSize(RowList: TStringList): Integer;
var
  x : Integer;
begin
  Result := 0;
  for x := 0 to RowList.Count-1 do
    Result := Result + (RowList.Objects[x] as TiKeyBoardButton).Size;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.CalcRects;
var
  x           : Integer;
  Row         : Integer;
  Col         : Integer;
  Button      : TiKeyBoardButton;
  RowIndex    : Integer;
  RowList     : TStringList;
  CurrentLeft : Integer;
  RowSize     : Integer;
  RowSizeMax  : Integer;
  XSizePixels : Integer;
  YSizePixels : Integer;
  XStart      : Integer;
  YStart      : Integer;
begin
  RemoveAllRows;

  for x := 0 to FButtonList.Count-1 do
    begin
      Button := (FButtonList.Objects[x] as TiKeyBoardButton);

      RowIndex := FRowListManager.IndexOf(IntToStr(Button.Row));
      if RowIndex = - 1 then
        begin
          RowList := TStringList.Create;
          FRowListManager.AddObject(IntToStr(Button.Row), RowList);
        end
      else RowList := FRowListManager.Objects[RowIndex] as TStringList;

      RowList.AddObject('', Button);
    end;
                         
  RowSizeMax := 1;
  for x := 0 to FRowListManager.Count-1 do
    begin                       
      RowSize := GetRowSize(FRowListManager.Objects[x] as TStringList);
      if RowSize > RowSizeMax then RowSizeMax := RowSize;
    end;


  XSizePixels := (Width -2*FOuterMargin                 ) div RowSizeMax;
  YSizePixels := (Height-2*FOuterMargin-FSecondRowMargin) div FRowListManager.Count;

  XStart := (Width  - XSizePixels*RowSizeMax                             ) div 2;
  YStart := (Height - YSizePixels*FRowListManager.Count -FSecondRowMargin) div 2;


  for Row := 0 to FRowListManager.Count-1 do
    begin
      CurrentLeft := XStart;
      RowList := FRowListManager.Objects[Row] as TStringList;
      for Col := 0 to RowList.Count-1 do
        begin
          Button := (RowList.Objects[Col] as TiKeyBoardButton);
          if Row = 0 then
            Button.Top    := Button.Row * YSizePixels + YStart
          else
            Button.Top    := Button.Row * YSizePixels + YStart + FSecondRowMargin;

          if Button.DoubleHeight then
            Button.Bottom := Button.Top + 2*YSizePixels
          else
            Button.Bottom := Button.Top + YSizePixels;
            
          Button.Left   := CurrentLeft;
          Button.Right  := CurrentLeft + XSizePixels*Button.Size;

          CurrentLeft := Button.Right;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.iPaintTo(Canvas: TCanvas);
var
  i      : Integer;
  Button : TiKeyBoardButton;
begin
  with Canvas do
    begin
      CalcRects;
      DrawBackGround(Canvas, BackGroundColor);
      Font.Assign(FFont);
      Brush.Style := bsClear;

      for i := 0 to FButtonList.Count-1 do
        begin
          Canvas.Font := FFont;
          Button := (FButtonList.Objects[i] as TiKeyBoardButton);
          if not Button.Visible         then Continue;
          if Button.Style = ikbbsSpacer then Continue;
          Button.Draw(Canvas, Enabled);
        end;
    end;
end;
//*************************************************************************************************************************************
constructor TiKeyBoardButton.Create;
begin
  inherited;

  FVisible             := True;
  FBackGroundColor     := clBtnFace;
  FFontColor           := clBlack;
  FUseControlFontColor := True;

  UpdateKeyState;
end;
//*************************************************************************************************************************************
procedure TiKeyBoardButton.SetVisible              (const Value:Boolean              );begin if FVisible              <>Value then begin FVisible              :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetStyle                (const Value:TiKeyBoardButtonStyle);begin if FStyle                <>Value then begin FStyle                :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetBackGroundColor      (const Value:TColor               );begin if FBackGroundColor      <>Value then begin FBackGroundColor      :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetFontColor            (const Value:TColor               );begin if FFontColor            <>Value then begin FFontColor            :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetUseControlFontColor  (const Value:Boolean              );begin if FUseControlFontColor  <>Value then begin FUseControlFontColor  :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetAcceptLock           (const Value:Boolean              );begin if FAcceptLock           <>Value then begin FAcceptLock           :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetShiftLocked          (const Value:Boolean              );begin if FShiftLocked          <>Value then begin FShiftLocked          :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetCaptionShift         (const Value:String               );begin if FCaptionShift         <>Value then begin FCaptionShift         :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetCaptionStandard      (const Value:String               );begin if FCaptionStandard      <>Value then begin FCaptionStandard      :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetDoubleHeight         (const Value:Boolean              );begin if FDoubleHeight         <>Value then begin FDoubleHeight         :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetRow                  (const Value:Integer              );begin if FRow                  <>Value then begin FRow                  :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetSize                 (const Value:Integer              );begin if FSize                 <>Value then begin FSize                 :=Value;Invalidate;end;end;
procedure TiKeyBoardButton.SetVirtualKeyCode       (const Value:Integer              );begin if FVirtualKeyCode       <>Value then begin FVirtualKeyCode       :=Value;Invalidate;end;end;
//*************************************************************************************************************************************
procedure TiKeyBoardButton.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer);
begin
  if not Enabled then Exit;

  if IsToggle then
    begin
      MouseDown := not MouseDown;
    end
  else MouseDown := True;
end;
//*************************************************************************************************************************************
procedure TiKeyBoardButton.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer);
begin
  if not Enabled then Exit;

  begin
    MouseDown := False;
    if PtInRect(DrawRect, Point(X, Y)) then
      begin
        if IsToggle then
          begin
            Down := not Down;
          end;
        if (FStyle = ikbbsStandard) or (FStyle = ikbbsAccent) then
          begin
            Windows.SetFocus(FFocusHandle);
            if FShowShift or FShiftLocked then keybd_event(iVK_SHIFT,        0, 0, 0);
            if FCtrlActive                then keybd_event(iVK_CONTROL,      0, 0, 0);
            if FAltActive                 then keybd_event(iVK_MENU,         0, 0, 0);

                                               keybd_event(FVirtualKeyCode,  0, 0, 0);
                                               keybd_event(FVirtualKeyCode,  0, KEYEVENTF_KEYUP, 0);

            if FAltActive                 then keybd_event(iVK_MENU,         0, KEYEVENTF_KEYUP, 0);
            if FCtrlActive                then keybd_event(iVK_CONTROL,      0, KEYEVENTF_KEYUP, 0);
            if FShowShift or FShiftLocked then keybd_event(iVK_SHIFT,        0, KEYEVENTF_KEYUP, 0);
          end;
        DoChange;
        if Assigned(OnClick) then OnClick(Self);
      end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoardButton.Draw(const Canvas: TCanvas; ControlEnabled: Boolean);
var
  ARect    : TRect;
  AText    : String;
  AFlags   : TiTextFlags;
  APoints  : array[0..6] of TPoint;
  ASize    : Integer;
  ALeft    : Integer;
  ACenterY : Integer;
begin
  UpdateKeyState;

  if not Visible then Exit;

  with Canvas do
    begin
      ARect       := DrawRect;
      InflateRect(ARect, -1, -1);
      AFlags      := [itfHCenter, itfVCenter, itfSingleLine];

      if FVirtualKeyCode = iVK_BACK then
        begin
          Brush.Style := bsSolid;
          Brush.Color := FBackGroundColor;
          FillRect(Rect(ARect.Left+1, ARect.Top+1, ARect.Right, ARect.Bottom));
          iDrawEdge(Canvas, ARect, idesRaised);

          ACenterY := (DrawRect.Top + DrawRect.Bottom) div 2;
          ASize := 2;
          ALeft := (DrawRect.Left + DrawRect.Right) div 2 - (ASize*8) div 2 ;
          APoints[0] := Point(ALeft,           ACenterY);
          APoints[1] := Point(ALeft + ASize*3, ACenterY - ASize*3);
          APoints[2] := Point(ALeft + ASize*3, ACenterY - ASize*1);
          APoints[3] := Point(ALeft + ASize*8, ACenterY - ASize*1);
          APoints[4] := Point(ALeft + ASize*8, ACenterY + ASize*1);
          APoints[5] := Point(ALeft + ASize*3, ACenterY + ASize*1);
          APoints[6] := Point(ALeft + ASize*3, ACenterY + ASize*3);

          Brush.Style := bsSolid;
          Brush.Color := clBlack;
          Pen.Style   := psSolid;
          Pen.Color   := clBlack;
          Polygon(APoints);

          Exit;
        end;

      AText := DisplayString;

      if MouseDown then
        begin
          Brush.Style := bsSolid;
          Brush.Color := ColorOffset(BackGroundColor, $30, True);
          FillRect(Rect(ARect.Left+1, ARect.Top+1, ARect.Right, ARect.Bottom));
          iDrawEdge(Canvas, ARect, idesSunken);

          if not Enabled then
            begin
              Brush.Style := bsClear;
              Font.Color := clBtnHighlight; OffsetRect(ARect, 1 , 1); iDrawText(Canvas, AText, ARect, AFlags, True, clBtnFace);
              Font.Color := clBtnShadow;    OffsetRect(ARect,-1 ,-1); iDrawText(Canvas, AText, ARect, AFlags, True, clBtnFace);
            end
          else
            begin
              OffsetRect(ARect,1 ,1);
              if not FUseControlFontColor then Font.Color := FFontColor;
              iDrawText(Canvas, AText, ARect, AFlags, True, clBtnFace);
            end;
        end
      else
        if Down then
          begin
            Brush.Style := bsSolid;
            Brush.Color := clLime;
            FillRect(Rect(ARect.Left+1, ARect.Top+1, ARect.Right, ARect.Bottom));
            iDrawEdge(Canvas, ARect, idesSunken);

            Brush.Style := bsClear;
            Font.Color := clWhite;
            OffsetRect(ARect, 2, 2);
            iDrawText(Canvas, AText, ARect, AFlags, True, clBtnFace);

            
            Font.Color := clBlack;
            OffsetRect(ARect, -1, -1);
            iDrawText(Canvas, AText, ARect, AFlags, True, clBtnFace);
          end
      else
        begin
          Brush.Style := bsSolid;
          Brush.Color := FBackGroundColor;
          FillRect(Rect(ARect.Left+1, ARect.Top+1, ARect.Right, ARect.Bottom));
          iDrawEdge(Canvas, ARect, idesRaised);

          if not Enabled then
            begin
              Brush.Style := bsClear;
              Font.Color := clBtnHighlight; OffsetRect(ARect, 1 , 1); iDrawText(Canvas, AText, ARect, AFlags, Enabled and ControlEnabled, clBtnFace);
              Font.Color := clBtnShadow;    OffsetRect(ARect,-1 ,-1); iDrawText(Canvas, AText, ARect, AFlags, Enabled and ControlEnabled, clBtnFace);
            end
          else
            begin
              if not FUseControlFontColor then Font.Color := FFontColor;
              iDrawText(Canvas, AText, ARect, AFlags, Enabled and ControlEnabled, clBtnFace);
            end;
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiKeyBoardButton.UpdateKeyState;
begin
  if Style = ikbbsStandard then
    begin
                                                   FShowShift := FShiftActive;
      if Trim(FCaptionShift) =  ''            then FShowShift := False
      else if FAcceptLock then if FLockActive then FShowShift := not FShowShift;

      Enabled := FVirtualKeyCode <> 0;
    end
  else
    begin
      FShowShift := False;
      Enabled    := True;
    end;
end;
//*************************************************************************************************************************************
function TiKeyBoardButton.GetDisplayString: String;
begin
  if FShowShift or FShiftLocked then Result := FCaptionShift else Result := FCaptionStandard;
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.SavePropertiesToFile(FileName: String);
var
  x          : Integer;
  AList      : TStringList;
  IgnoreList : TStringList;
begin
  try
  AList := TStringList.Create;
  try
    IgnoreList := TStringList.Create;
  try
    IgnoreList.Add('Name');
    if not OptionSaveAllProperties then
      begin
        IgnoreList.Add('Left');
        IgnoreList.Add('Top');
        IgnoreList.Add('Width');
        IgnoreList.Add('Height');
        IgnoreList.Add('Align');
        IgnoreList.Add('Cursor');
        IgnoreList.Add('ShowHint');
        IgnoreList.Add('Tag');
        IgnoreList.Add('Visible');
        IgnoreList.Add('Enabled');
        IgnoreList.Add('Hint');
        IgnoreList.Add('HelpContext');
      end;

    AList.Add('File Type = ' + Self.ClassName);
    SaveObjectToStringList(Self, '', AList, IgnoreList);
    AList.Add('KeyCount = ' + IntToStr(KeyCount));

    for x := 0 to KeyCount-1 do SaveObjectToStringList(KeyButton[x], 'Key' + IntToStr(x), AList, nil);

    AList.SaveToFile(FileName);
  finally
    IgnoreList.Free;
  end;
  finally
    AList.Free;
  end;
  except
    on e: Exception do raise Exception.Create('Error Saving Properties - ' + e.message);
  end;
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.LoadPropertiesFromFile(FileName: String);
var
  x       : Integer;
  AList   : TStringList;
  AString : String;
  Found   : Boolean;
  Button  : TiKeyBoardButton;
begin
  try
  AList := TStringList.Create;
  try
    AList.LoadFromFile(FileName);
    LoadObjectFromStringList(Self, '', AList);
    RemoveAllButtons;

    Found := GetPropertyValueString('KeyCount', AString, AList);
    if Found then
      for x := 0 to StrToInt(AString)-1 do
        begin
          Button := CreateDefaultButton;
          LoadObjectFromStringList(Button, 'Key' + IntToStr(x), AList);
        end;
  finally
    AList.Free;
  end;
  except
    on e: Exception do raise Exception.Create('Error Loading Properties - ' + e.message);
  end;
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.LoadKeyData(Index, VirtualKeyCode: Integer; Style: TiKeyBoardButtonStyle; CaptionStandard, CaptionShift: String; AcceptLock: Boolean);
begin
  KeyDataArray[Index].Style           := Style;
  KeyDataArray[Index].CaptionStandard := CaptionStandard;
  KeyDataArray[Index].CaptionShift    := CaptionShift;
  KeyDataArray[Index].VirtualKeyCode  := Index;
  KeyDataArray[Index].AcceptLock      := AcceptLock;
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.LoadKeyDataArray;
begin
  LoadKeyData(iVK_BACK,         8, ikbbsStandard, 'bksp', '',  False);
  LoadKeyData(iVK_TAB,          9, ikbbsStandard, 'Tab',  '',  False);
  //                           10 Undefined
  //                           11 Undefined
  //                           12 iVK_Clear
  LoadKeyData(iVK_RETURN,      13, ikbbsStandard, 'Enter','',  False);
  //                           14 Undefined
  //                           15 Undefined
  LoadKeyData(iVK_SHIFT,       16, ikbbsShift,    'Shift','',  False);
  LoadKeyData(iVK_CONTROL,     17, ikbbsCtrl,     'Ctrl', '',  False);
  LoadKeyData(iVK_MENU,        18, ikbbsAlt,      'Alt',  '',  False);
  LoadKeyData(iVK_PAUSE,       19, ikbbsStandard, 'brk',  '',  False);
  LoadKeyData(iVK_CAPITAL,     20, ikbbsLock,     'Lock', '',  False);
  //                           21 iVK_KANA or iVK_HANGUEL or iVK_HANGUL
  //                           22 Undefined
  //                           23 iVK_JUNJA
  //                           24 iVK_FINAL
  //                           25 iVK_HANJA or iVK_KANJI
  //                           26 Undefined
  LoadKeyData(iVK_ESCAPE,      27, ikbbsStandard, 'Esc',  '',  False);
  //                           28 iVK_CONVERT (IME)
  //                           29 iVK_NONCONVERT(IME)
  //                           30 iVK_ACCEPT(IME)
  //                           31 iVK_MODECHANGE(IME)
  LoadKeyData(iVK_SPACE,       32, ikbbsStandard, '',     '',  False);
  LoadKeyData(iVK_PRIOR,       33, ikbbsStandard, 'pup',  '',  False);
  LoadKeyData(iVK_NEXT,        34, ikbbsStandard, 'pdn',  '',  False);
  LoadKeyData(iVK_END,         35, ikbbsStandard, 'end',  '',  False);
  LoadKeyData(iVK_HOME,        36, ikbbsStandard, 'hm',   '',  False);
  LoadKeyData(iVK_LEFT,        37, ikbbsStandard, 'L',    '',  False);
  LoadKeyData(iVK_UP,          38, ikbbsStandard, 'U',    '',  False);
  LoadKeyData(iVK_RIGHT,       39, ikbbsStandard, 'R',    '',  False);
  LoadKeyData(iVK_DOWN,        40, ikbbsStandard, 'D',    '',  False);
  //                           41 iVK_SELECT
  //                           42 iVK_PRINT
  //                           43 iVK_EXECUTE
  LoadKeyData(iVK_SNAPSHOT,    44, ikbbsStandard, 'psc',  '',  False);
  LoadKeyData(iVK_INSERT,      45, ikbbsStandard, 'ins',  '',  False);
  LoadKeyData(iVK_DELETE,      46, ikbbsStandard, 'del',  '',  False);
  //                           47 iVK_HELP
  LoadKeyData(iVK_0,           48, ikbbsStandard, '0',   ')',  False);
  LoadKeyData(iVK_1,           49, ikbbsStandard, '1',   '!',  False);
  LoadKeyData(iVK_2,           50, ikbbsStandard, '2',   '@',  False);
  LoadKeyData(iVK_3,           51, ikbbsStandard, '3',   '#',  False);
  LoadKeyData(iVK_4,           52, ikbbsStandard, '4',   '$',  False);
  LoadKeyData(iVK_5,           53, ikbbsStandard, '5',   '%',  False);
  LoadKeyData(iVK_6,           54, ikbbsStandard, '6',   '^',  False);
  LoadKeyData(iVK_7,           55, ikbbsStandard, '7',   '&',  False);
  LoadKeyData(iVK_8,           56, ikbbsStandard, '8',   '*',  False);
  LoadKeyData(iVK_9,           57, ikbbsStandard, '9',   '(',  False);
  //                           58 Undefined
  //                           59 Undefined
  //                           60
  //                           61
  //                           62
  //                           63
  //                           64
  LoadKeyData(iVK_A,           65, ikbbsStandard, 'a',   'A',  True);
  LoadKeyData(iVK_B,           66, ikbbsStandard, 'b',   'B',  True);
  LoadKeyData(iVK_C,           67, ikbbsStandard, 'c',   'C',  True);
  LoadKeyData(iVK_D,           68, ikbbsStandard, 'd',   'D',  True);
  LoadKeyData(iVK_E,           69, ikbbsStandard, 'e',   'E',  True);
  LoadKeyData(iVK_F,           70, ikbbsStandard, 'f',   'F',  True);
  LoadKeyData(iVK_G,           71, ikbbsStandard, 'g',   'G',  True);
  LoadKeyData(iVK_H,           72, ikbbsStandard, 'h',   'H',  True);
  LoadKeyData(iVK_I,           73, ikbbsStandard, 'i',   'I',  True);
  LoadKeyData(iVK_J,           74, ikbbsStandard, 'j',   'J',  True);
  LoadKeyData(iVK_K,           75, ikbbsStandard, 'k',   'K',  True);
  LoadKeyData(iVK_L,           76, ikbbsStandard, 'l',   'L',  True);
  LoadKeyData(iVK_M,           77, ikbbsStandard, 'm',   'M',  True);
  LoadKeyData(iVK_N,           78, ikbbsStandard, 'n',   'N',  True);
  LoadKeyData(iVK_O,           79, ikbbsStandard, 'o',   'O',  True);
  LoadKeyData(iVK_P,           80, ikbbsStandard, 'p',   'P',  True);
  LoadKeyData(iVK_Q,           81, ikbbsStandard, 'q',   'Q',  True);
  LoadKeyData(iVK_R,           82, ikbbsStandard, 'r',   'R',  True);
  LoadKeyData(iVK_S,           83, ikbbsStandard, 's',   'S',  True);
  LoadKeyData(iVK_T,           84, ikbbsStandard, 't',   'T',  True);
  LoadKeyData(iVK_U,           85, ikbbsStandard, 'u',   'U',  True);
  LoadKeyData(iVK_V,           86, ikbbsStandard, 'v',   'V',  True);
  LoadKeyData(iVK_W,           87, ikbbsStandard, 'w',   'W',  True);
  LoadKeyData(iVK_X,           88, ikbbsStandard, 'x',   'X',  True);
  LoadKeyData(iVK_Y,           89, ikbbsStandard, 'y',   'Y',  True);
  LoadKeyData(iVK_Z,           90, ikbbsStandard, 'z',   'Z',  True);

  LoadKeyData(iVK_LWIN,        91, ikbbsStandard, 'W',    '',  False);
  LoadKeyData(iVK_RWIN,        92, ikbbsStandard, 'W',    '',  False);
  LoadKeyData(iVK_APPS,        93, ikbbsStandard, 'L',    '',  False);
  //                           94 Reserved
  //                           95 iVK_SLEEP
  LoadKeyData(iVK_NUMPAD0,     96, ikbbsStandard, '0',    '',  False);
  LoadKeyData(iVK_NUMPAD1,     97, ikbbsStandard, '1',    '',  False);
  LoadKeyData(iVK_NUMPAD2,     98, ikbbsStandard, '2',    '',  False);
  LoadKeyData(iVK_NUMPAD3,     99, ikbbsStandard, '3',    '',  False);
  LoadKeyData(iVK_NUMPAD4,    100, ikbbsStandard, '4',    '',  False);
  LoadKeyData(iVK_NUMPAD5,    101, ikbbsStandard, '5',    '',  False);
  LoadKeyData(iVK_NUMPAD6,    102, ikbbsStandard, '6',    '',  False);
  LoadKeyData(iVK_NUMPAD7,    103, ikbbsStandard, '7',    '',  False);
  LoadKeyData(iVK_NUMPAD8,    104, ikbbsStandard, '8',    '',  False);
  LoadKeyData(iVK_NUMPAD9,    105, ikbbsStandard, '9',    '',  False);
  LoadKeyData(iVK_MULTIPLY,   106, ikbbsStandard, '*',    '',  False);
  LoadKeyData(iVK_ADD,        107, ikbbsStandard, '+',    '',  False);
  //                          108 iVK_SEPARATOR
  LoadKeyData(iVK_SUBTRACT,   109, ikbbsStandard, '-',    '',  False);
  LoadKeyData(iVK_DECIMAL,    110, ikbbsStandard, '.',    '',  False);
  LoadKeyData(iVK_DIVIDE,     111, ikbbsStandard, '/',    '',  False);
  LoadKeyData(iVK_F1,         112, ikbbsStandard, 'F1',   '',  False);
  LoadKeyData(iVK_F2,         113, ikbbsStandard, 'F2',   '',  False);
  LoadKeyData(iVK_F3,         114, ikbbsStandard, 'F3',   '',  False);
  LoadKeyData(iVK_F4,         115, ikbbsStandard, 'F4',   '',  False);
  LoadKeyData(iVK_F5,         116, ikbbsStandard, 'F5',   '',  False);
  LoadKeyData(iVK_F6,         117, ikbbsStandard, 'F6',   '',  False);
  LoadKeyData(iVK_F7,         118, ikbbsStandard, 'F7',   '',  False);
  LoadKeyData(iVK_F8,         119, ikbbsStandard, 'F8',   '',  False);
  LoadKeyData(iVK_F9,         120, ikbbsStandard, 'F9',   '',  False);
  LoadKeyData(iVK_F10,        121, ikbbsStandard, 'F10',  '',  False);
  LoadKeyData(iVK_F11,        122, ikbbsStandard, 'F11',  '',  False);
  LoadKeyData(iVK_F12,        123, ikbbsStandard, 'F12',  '',  False);
  //                          124 iVK_F13
  //                          125 iVK_F14
  //                          126 iVK_F15
  //                          127 iVK_F16
  //                          128 iVK_F17
  //                          129 iVK_F18
  //                          130 iVK_F19
  //                          131 iVK_F20
  //                          132 iVK_F21
  //                          133 iVK_F22
  //                          134 iVK_F23
  //                          135 iVK_F24
  //                          136 Unassigned
  //                          ... ...
  //                          143 Unassigned
  LoadKeyData(iVK_NUMLOCK,    144, ikbbsNumLock,  'nlk',  '',  False);
  LoadKeyData(iVK_SCROLL,     145, ikbbsStandard,   'slk',  '',  False);
  //                          146 OEM Specific
  //                          ... OEM Specific
  //                          150 OEM Specific
  //                          151 Unassigned
  //                          ... Unassigned
  LoadKeyData(iVK_POUND,      65, ikbbsStandard,    '£','£',  False); //£
  //                          159 Unassigned

  LoadKeyData(iVK_LSHIFT,     160, ikbbsShift,    'Shift','',  False);
  LoadKeyData(iVK_RSHIFT,     161, ikbbsShift,    'Shift','',  False);
  LoadKeyData(iVK_LCONTROL,   162, ikbbsCtrl,     'Ctrl', '',  False);
  LoadKeyData(iVK_RCONTROL,   163, ikbbsCtrl,     'Ctrl', '',  False);
  LoadKeyData(iVK_LMENU,      164, ikbbsAlt,      'Alt',  '',  False);
  LoadKeyData(iVK_RMENU,      165, ikbbsAlt,      'Alt',  '',  False);

  LoadKeyData(iVK_OEM_1,      186, ikbbsStandard, ';',    ':', False);

  LoadKeyData(iVK_OEM_PLUS,   187, ikbbsStandard, '=',    '+', False);
  LoadKeyData(iVK_OEM_COMMA,  188, ikbbsStandard, ',',    '<', False);
  LoadKeyData(iVK_OEM_MINUS,  189, ikbbsStandard, '-',    '_', False);
  LoadKeyData(iVK_OEM_PERIOD, 190, ikbbsStandard, '.',    '>', False);
  LoadKeyData(iVK_OEM_2,      191, ikbbsStandard, '/',    '?', False);
  LoadKeyData(iVK_OEM_3,      192, ikbbsStandard, '`',    '~', False);

  LoadKeyData(iVK_OEM_4,      219, ikbbsStandard, '[',    '{', False);
  LoadKeyData(iVK_OEM_5,      220, ikbbsStandard, '\',    '|', False);
  LoadKeyData(iVK_OEM_6,      221, ikbbsStandard, ']',    '}', False);
  LoadKeyData(iVK_OEM_7,      222, ikbbsStandard, '''',   '"', False);
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.Setup104;
var
  Row : Integer;
begin
  RemoveAllButtons;

  Row := 0;
  CreateButton(iVK_ESCAPE,     Row,  2, False, False);
  CreateSpacer(                Row,  2);
  CreateButton(iVK_F1,         Row,  2, False, False);
  CreateButton(iVK_F2,         Row,  2, False, False);
  CreateButton(iVK_F3,         Row,  2, False, False);
  CreateButton(iVK_F4,         Row,  2, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_F5,         Row,  2, False, False);
  CreateButton(iVK_F6,         Row,  2, False, False);
  CreateButton(iVK_F7,         Row,  2, False, False);
  CreateButton(iVK_F8,         Row,  2, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_F9,         Row,  2, False, False);
  CreateButton(iVK_F10,        Row,  2, False, False);
  CreateButton(iVK_F11,        Row,  2, False, False);
  CreateButton(iVK_F12,        Row,  2, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_SNAPSHOT,   Row,  2, False, False);
  CreateButton(iVK_SCROLL,     Row,  2, False, False);
  CreateButton(iVK_PAUSE,      Row,  2, False, False);

  Row := 1;
  CreateButton(iVK_OEM_3,      Row,  2, False, False);
  CreateButton(iVK_1,          Row,  2, False, False);
  CreateButton(iVK_2,          Row,  2, False, False);
  CreateButton(iVK_3,          Row,  2, False, False);
  CreateButton(iVK_4,          Row,  2, False, False);
  CreateButton(iVK_5,          Row,  2, False, False);
  CreateButton(iVK_6,          Row,  2, False, False);
  CreateButton(iVK_7,          Row,  2, False, False);
  CreateButton(iVK_8,          Row,  2, False, False);
  CreateButton(iVK_9,          Row,  2, False, False);
  CreateButton(iVK_0,          Row,  2, False, False);
  CreateButton(iVK_OEM_MINUS,  Row,  2, False, False);
  CreateButton(iVK_OEM_PLUS,   Row,  2, False, False);
  CreateButton(iVK_BACK,       Row,  4, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_INSERT,     Row,  2, False, False);
  CreateButton(iVK_HOME,       Row,  2, False, False);
  CreateButton(iVK_PRIOR,      Row,  2, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_NUMLOCK,    Row,  2, False, False);
  CreateButton(iVK_DIVIDE,     Row,  2, False, False);
  CreateButton(iVK_MULTIPLY,   Row,  2, False, False);
  CreateButton(iVK_SUBTRACT,   Row,  2, False, False);

  Row := 2;
  CreateButton(iVK_TAB,        Row,  3, False, False);
  CreateButton(iVK_Q,          Row,  2, False, False);
  CreateButton(iVK_W,          Row,  2, False, False);
  CreateButton(iVK_E,          Row,  2, False, False);
  CreateButton(iVK_R,          Row,  2, False, False);
  CreateButton(iVK_T,          Row,  2, False, False);
  CreateButton(iVK_Y,          Row,  2, False, False);
  CreateButton(iVK_U,          Row,  2, False, False);
  CreateButton(iVK_I,          Row,  2, False, False);
  CreateButton(iVK_O,          Row,  2, False, False);
  CreateButton(iVK_P,          Row,  2, False, False);
  CreateButton(iVK_OEM_4,      Row,  2, False, False); // [ and {
  CreateButton(iVK_OEM_6,      Row,  2, False, False); // ] and }
  CreateButton(iVK_OEM_5,      Row,  3, False, False); // \ and |
  CreateSpacer(                Row,  1);
  CreateButton(iVK_DELETE,     Row,  2, False, False);
  CreateButton(iVK_END,        Row,  2, False, False);
  CreateButton(iVK_NEXT,       Row,  2, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_NUMPAD7,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD8,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD9,    Row,  2, False, False);
  CreateButton(iVK_ADD,        Row,  2, True,  False);

  Row := 3;
  CreateButton(iVK_CAPITAL,    Row,  4, False, False);
  CreateButton(iVK_A,          Row,  2, False, False);
  CreateButton(iVK_S,          Row,  2, False, False);
  CreateButton(iVK_D,          Row,  2, False, False);
  CreateButton(iVK_F,          Row,  2, False, False);
  CreateButton(iVK_G,          Row,  2, False, False);
  CreateButton(iVK_H,          Row,  2, False, False);
  CreateButton(iVK_J,          Row,  2, False, False);
  CreateButton(iVK_K,          Row,  2, False, False);
  CreateButton(iVK_L,          Row,  2, False, False);
  CreateButton(iVK_OEM_1,      Row,  2, False, False); // ; and :
  CreateButton(iVK_OEM_7,      Row,  2, False, False); // ' and "
  CreateButton(iVK_RETURN,     Row,  4, False, False);
  CreateSpacer(                Row,  8);
  CreateButton(iVK_NUMPAD4,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD5,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD6,    Row,  2, False, False);

  Row := 4;
  CreateButton(iVK_SHIFT,      Row,  5, False, False);
  CreateButton(iVK_Z,          Row,  2, False, False);
  CreateButton(iVK_X,          Row,  2, False, False);
  CreateButton(iVK_C,          Row,  2, False, False);
  CreateButton(iVK_V,          Row,  2, False, False);
  CreateButton(iVK_B,          Row,  2, False, False);
  CreateButton(iVK_N,          Row,  2, False, False);
  CreateButton(iVK_M,          Row,  2, False, False);
  CreateButton(iVK_OEM_COMMA,  Row,  2, False, False);
  CreateButton(iVK_OEM_PERIOD, Row,  2, False, False);
  CreateButton(iVK_OEM_2,      Row,  2, False, False); // / and ?
  CreateButton(iVK_SHIFT,      Row,  5, False, False);
  CreateSpacer(                Row,  3);
  CreateButton(iVK_UP,         Row,  2, False, False);
  CreateSpacer(                Row,  3);
  CreateButton(iVK_NUMPAD1,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD2,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD3,    Row,  2, False, False);
  CreateButton(iVK_RETURN,     Row,  2, True , False);

  Row := 5;
  CreateButton(iVK_CONTROL,    Row,  3, False, False);
  CreateButton(iVK_LWIN,       Row,  2, False, False);
  CreateButton(iVK_MENU,       Row,  3, False, False);
  CreateButton(iVK_SPACE,      Row, 12, False, False);
  CreateButton(iVK_MENU,       Row,  3, False, False);
  CreateButton(iVK_RWIN,       Row,  2, False, False);
  CreateButton(iVK_APPS,       Row,  2, False, False);
  CreateButton(iVK_CONTROL,    Row,  3, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_LEFT,       Row,  2, False, False);
  CreateButton(iVK_DOWN,       Row,  2, False, False);
  CreateButton(iVK_RIGHT,      Row,  2, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_NUMPAD0,    Row,  4, False, False);
  CreateButton(iVK_DECIMAL,    Row,  2, False, False);
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.Setup087;
var
  Row : Integer;
begin
  RemoveAllButtons;

  Row := 0;
  CreateButton(iVK_ESCAPE,     Row,  2, False, False);
  CreateSpacer(                Row,  2);
  CreateButton(iVK_F1,         Row,  2, False, False);
  CreateButton(iVK_F2,         Row,  2, False, False);
  CreateButton(iVK_F3,         Row,  2, False, False);
  CreateButton(iVK_F4,         Row,  2, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_F5,         Row,  2, False, False);
  CreateButton(iVK_F6,         Row,  2, False, False);
  CreateButton(iVK_F7,         Row,  2, False, False);
  CreateButton(iVK_F8,         Row,  2, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_F9,         Row,  2, False, False);
  CreateButton(iVK_F10,        Row,  2, False, False);
  CreateButton(iVK_F11,        Row,  2, False, False);
  CreateButton(iVK_F12,        Row,  2, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_SNAPSHOT,   Row,  2, False, False);
  CreateButton(iVK_SCROLL,     Row,  2, False, False);
  CreateButton(iVK_PAUSE,      Row,  2, False, False);

  Row := 1;
  CreateButton(iVK_OEM_3,      Row,  2, False, False);
  CreateButton(iVK_1,          Row,  2, False, False);
  CreateButton(iVK_2,          Row,  2, False, False);
  CreateButton(iVK_3,          Row,  2, False, False);
  CreateButton(iVK_4,          Row,  2, False, False);
  CreateButton(iVK_5,          Row,  2, False, False);
  CreateButton(iVK_6,          Row,  2, False, False);
  CreateButton(iVK_7,          Row,  2, False, False);
  CreateButton(iVK_8,          Row,  2, False, False);
  CreateButton(iVK_9,          Row,  2, False, False);
  CreateButton(iVK_0,          Row,  2, False, False);
  CreateButton(iVK_OEM_MINUS,  Row,  2, False, False);
  CreateButton(iVK_OEM_PLUS,   Row,  2, False, False);
  CreateButton(iVK_BACK,       Row,  4, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_INSERT,     Row,  2, False, False);
  CreateButton(iVK_HOME,       Row,  2, False, False);
  CreateButton(iVK_PRIOR,      Row,  2, False, False);

  Row := 2;
  CreateButton(iVK_TAB,        Row,  3, False, False);
  CreateButton(iVK_Q,          Row,  2, False, False);
  CreateButton(iVK_W,          Row,  2, False, False);
  CreateButton(iVK_E,          Row,  2, False, False);
  CreateButton(iVK_R,          Row,  2, False, False);
  CreateButton(iVK_T,          Row,  2, False, False);
  CreateButton(iVK_Y,          Row,  2, False, False);
  CreateButton(iVK_U,          Row,  2, False, False);
  CreateButton(iVK_I,          Row,  2, False, False);
  CreateButton(iVK_O,          Row,  2, False, False);
  CreateButton(iVK_P,          Row,  2, False, False);
  CreateButton(iVK_OEM_4,      Row,  2, False, False); // [ and {
  CreateButton(iVK_OEM_6,      Row,  2, False, False); // ] and }
  CreateButton(iVK_OEM_5,      Row,  3, False, False); // \ and |
  CreateSpacer(                Row,  1);
  CreateButton(iVK_DELETE,     Row,  2, False, False);
  CreateButton(iVK_END,        Row,  2, False, False);
  CreateButton(iVK_NEXT,       Row,  2, False, False);

  Row := 3;
  CreateButton(iVK_CAPITAL,    Row,  4, False, False);
  CreateButton(iVK_A,          Row,  2, False, False);
  CreateButton(iVK_S,          Row,  2, False, False);
  CreateButton(iVK_D,          Row,  2, False, False);
  CreateButton(iVK_F,          Row,  2, False, False);
  CreateButton(iVK_G,          Row,  2, False, False);
  CreateButton(iVK_H,          Row,  2, False, False);
  CreateButton(iVK_J,          Row,  2, False, False);
  CreateButton(iVK_K,          Row,  2, False, False);
  CreateButton(iVK_L,          Row,  2, False, False);
  CreateButton(iVK_OEM_1,      Row,  2, False, False); // ; and :
  CreateButton(iVK_OEM_7,      Row,  2, False, False); // ' and "
  CreateButton(iVK_RETURN,     Row,  4, False, False);

  Row := 4;
  CreateButton(iVK_SHIFT,      Row,  5, False, False);
  CreateButton(iVK_Z,          Row,  2, False, False);
  CreateButton(iVK_X,          Row,  2, False, False);
  CreateButton(iVK_C,          Row,  2, False, False);
  CreateButton(iVK_V,          Row,  2, False, False);
  CreateButton(iVK_B,          Row,  2, False, False);
  CreateButton(iVK_N,          Row,  2, False, False);
  CreateButton(iVK_M,          Row,  2, False, False);
  CreateButton(iVK_OEM_COMMA,  Row,  2, False, False);
  CreateButton(iVK_OEM_PERIOD, Row,  2, False, False);
  CreateButton(iVK_OEM_2,      Row,  2, False, False); // / and ?
  CreateButton(iVK_SHIFT,      Row,  5, False, False);
  CreateSpacer(                Row,  3);
  CreateButton(iVK_UP,         Row,  2, False, False);

  Row := 5;
  CreateButton(iVK_CONTROL,    Row,  3, False, False);
  CreateButton(iVK_LWIN,       Row,  2, False, False);
  CreateButton(iVK_MENU,       Row,  3, False, False);
  CreateButton(iVK_SPACE,      Row, 12, False, False);
  CreateButton(iVK_MENU,       Row,  3, False, False);
  CreateButton(iVK_RWIN,       Row,  2, False, False);
  CreateButton(iVK_APPS,       Row,  2, False, False);
  CreateButton(iVK_CONTROL,    Row,  3, False, False);
  CreateSpacer(Row,  1);
  CreateButton(iVK_LEFT,       Row,  2, False, False);
  CreateButton(iVK_DOWN,       Row,  2, False, False);
  CreateButton(iVK_RIGHT,      Row,  2, False, False);
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.Setup074;
var
  Row : Integer;
begin
  RemoveAllButtons;

  Row := 0;
  CreateButton(iVK_ESCAPE,     Row,  2, False, False);
  CreateSpacer(                Row,  2);
  CreateButton(iVK_F1,         Row,  2, False, False);
  CreateButton(iVK_F2,         Row,  2, False, False);
  CreateButton(iVK_F3,         Row,  2, False, False);
  CreateButton(iVK_F4,         Row,  2, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_F5,         Row,  2, False, False);
  CreateButton(iVK_F6,         Row,  2, False, False);
  CreateButton(iVK_F7,         Row,  2, False, False);
  CreateButton(iVK_F8,         Row,  2, False, False);
  CreateSpacer(                Row,  1);
  CreateButton(iVK_F9,         Row,  2, False, False);
  CreateButton(iVK_F10,        Row,  2, False, False);
  CreateButton(iVK_F11,        Row,  2, False, False);
  CreateButton(iVK_F12,        Row,  2, False, False);

  Row := 1;
  CreateButton(iVK_OEM_3,      Row,  2, False, False);
  CreateButton(iVK_1,          Row,  2, False, False);
  CreateButton(iVK_2,          Row,  2, False, False);
  CreateButton(iVK_3,          Row,  2, False, False);
  CreateButton(iVK_4,          Row,  2, False, False);
  CreateButton(iVK_5,          Row,  2, False, False);
  CreateButton(iVK_6,          Row,  2, False, False);
  CreateButton(iVK_7,          Row,  2, False, False);
  CreateButton(iVK_8,          Row,  2, False, False);
  CreateButton(iVK_9,          Row,  2, False, False);
  CreateButton(iVK_0,          Row,  2, False, False);
  CreateButton(iVK_OEM_MINUS,  Row,  2, False, False);
  CreateButton(iVK_OEM_PLUS,   Row,  2, False, False);
  CreateButton(iVK_BACK,       Row,  4, False, False);

  Row := 2;
  CreateButton(iVK_TAB,        Row,  3, False, False);
  CreateButton(iVK_Q,          Row,  2, False, False);
  CreateButton(iVK_W,          Row,  2, False, False);
  CreateButton(iVK_E,          Row,  2, False, False);
  CreateButton(iVK_R,          Row,  2, False, False);
  CreateButton(iVK_T,          Row,  2, False, False);
  CreateButton(iVK_Y,          Row,  2, False, False);
  CreateButton(iVK_U,          Row,  2, False, False);
  CreateButton(iVK_I,          Row,  2, False, False);
  CreateButton(iVK_O,          Row,  2, False, False);
  CreateButton(iVK_P,          Row,  2, False, False);
  CreateButton(iVK_OEM_4,      Row,  2, False, False); // [ and {
  CreateButton(iVK_OEM_6,      Row,  2, False, False); // ] and }
  CreateButton(iVK_OEM_5,      Row,  3, False, False); // \ and |

  Row := 3;
  CreateButton(iVK_CAPITAL,    Row,  4, False, False);
  CreateButton(iVK_A,          Row,  2, False, False);
  CreateButton(iVK_S,          Row,  2, False, False);
  CreateButton(iVK_D,          Row,  2, False, False);
  CreateButton(iVK_F,          Row,  2, False, False);
  CreateButton(iVK_G,          Row,  2, False, False);
  CreateButton(iVK_H,          Row,  2, False, False);
  CreateButton(iVK_J,          Row,  2, False, False);
  CreateButton(iVK_K,          Row,  2, False, False);
  CreateButton(iVK_L,          Row,  2, False, False);
  CreateButton(iVK_OEM_1,      Row,  2, False, False); // ; and :
  CreateButton(iVK_OEM_7,      Row,  2, False, False); // ' and "
  CreateButton(iVK_RETURN,     Row,  4, False, False);

  Row := 4;
  CreateButton(iVK_SHIFT,      Row,  5, False, False);
  CreateButton(iVK_Z,          Row,  2, False, False);
  CreateButton(iVK_X,          Row,  2, False, False);
  CreateButton(iVK_C,          Row,  2, False, False);
  CreateButton(iVK_V,          Row,  2, False, False);
  CreateButton(iVK_B,          Row,  2, False, False);
  CreateButton(iVK_N,          Row,  2, False, False);
  CreateButton(iVK_M,          Row,  2, False, False);
  CreateButton(iVK_OEM_COMMA,  Row,  2, False, False);
  CreateButton(iVK_OEM_PERIOD, Row,  2, False, False);
  CreateButton(iVK_OEM_2,      Row,  2, False, False); // / and ?
  CreateButton(iVK_SHIFT,      Row,  5, False, False);

  Row := 5;
  CreateButton(iVK_CONTROL,    Row,  3, False, False);
  CreateButton(iVK_LWIN,       Row,  2, False, False);
  CreateButton(iVK_MENU,       Row,  3, False, False);
  CreateButton(iVK_SPACE,      Row, 12, False, False);
  CreateButton(iVK_MENU,       Row,  3, False, False);
  CreateButton(iVK_RWIN,       Row,  2, False, False);
  CreateButton(iVK_APPS,       Row,  2, False, False);
  CreateButton(iVK_CONTROL,    Row,  3, False, False);
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.Setup061;
var
  Row : Integer;
begin
  RemoveAllButtons;

  Row := 0;
  CreateButton(iVK_OEM_3,      Row,  2, False, False);
  CreateButton(iVK_1,          Row,  2, False, False);
  CreateButton(iVK_2,          Row,  2, False, False);
  CreateButton(iVK_3,          Row,  2, False, False);
  CreateButton(iVK_4,          Row,  2, False, False);
  CreateButton(iVK_5,          Row,  2, False, False);
  CreateButton(iVK_6,          Row,  2, False, False);
  CreateButton(iVK_7,          Row,  2, False, False);
  CreateButton(iVK_8,          Row,  2, False, False);
  CreateButton(iVK_9,          Row,  2, False, False);
  CreateButton(iVK_0,          Row,  2, False, False);
  CreateButton(iVK_OEM_MINUS,  Row,  2, False, False);
  CreateButton(iVK_OEM_PLUS,   Row,  2, False, False);
  CreateButton(iVK_BACK,       Row,  4, False, False);

  Row := 1;
  CreateButton(iVK_TAB,        Row,  3, False, False);
  CreateButton(iVK_Q,          Row,  2, False, False);
  CreateButton(iVK_W,          Row,  2, False, False);
  CreateButton(iVK_E,          Row,  2, False, False);
  CreateButton(iVK_R,          Row,  2, False, False);
  CreateButton(iVK_T,          Row,  2, False, False);
  CreateButton(iVK_Y,          Row,  2, False, False);
  CreateButton(iVK_U,          Row,  2, False, False);
  CreateButton(iVK_I,          Row,  2, False, False);
  CreateButton(iVK_O,          Row,  2, False, False);
  CreateButton(iVK_P,          Row,  2, False, False);
  CreateButton(iVK_OEM_4,      Row,  2, False, False); // [ and {
  CreateButton(iVK_OEM_6,      Row,  2, False, False); // ] and }
  CreateButton(iVK_OEM_5,      Row,  3, False, False); // \ and |

  Row := 2;
  CreateButton(iVK_CAPITAL,    Row,  4, False, False);
  CreateButton(iVK_A,          Row,  2, False, False);
  CreateButton(iVK_S,          Row,  2, False, False);
  CreateButton(iVK_D,          Row,  2, False, False);
  CreateButton(iVK_F,          Row,  2, False, False);
  CreateButton(iVK_G,          Row,  2, False, False);
  CreateButton(iVK_H,          Row,  2, False, False);
  CreateButton(iVK_J,          Row,  2, False, False);
  CreateButton(iVK_K,          Row,  2, False, False);
  CreateButton(iVK_L,          Row,  2, False, False);
  CreateButton(iVK_OEM_1,      Row,  2, False, False); // ; and :
  CreateButton(iVK_OEM_7,      Row,  2, False, False); // ' and "
  CreateButton(iVK_RETURN,     Row,  4, False, False);

  Row := 3;
  CreateButton(iVK_SHIFT,      Row,  5, False, False);
  CreateButton(iVK_Z,          Row,  2, False, False);
  CreateButton(iVK_X,          Row,  2, False, False);
  CreateButton(iVK_C,          Row,  2, False, False);
  CreateButton(iVK_V,          Row,  2, False, False);
  CreateButton(iVK_B,          Row,  2, False, False);
  CreateButton(iVK_N,          Row,  2, False, False);
  CreateButton(iVK_M,          Row,  2, False, False);
  CreateButton(iVK_OEM_COMMA,  Row,  2, False, False);
  CreateButton(iVK_OEM_PERIOD, Row,  2, False, False);
  CreateButton(iVK_OEM_2,      Row,  2, False, False); // / and ?
  CreateButton(iVK_SHIFT,      Row,  5, False, False);

  Row := 4;
  CreateButton(iVK_CONTROL,    Row,  3, False, False);
  CreateButton(iVK_LWIN,       Row,  2, False, False);
  CreateButton(iVK_MENU,       Row,  3, False, False);
  CreateButton(iVK_SPACE,      Row, 12, False, False);
  CreateButton(iVK_MENU,       Row,  3, False, False);
  CreateButton(iVK_RWIN,       Row,  2, False, False);
  CreateButton(iVK_APPS,       Row,  2, False, False);
  CreateButton(iVK_CONTROL,    Row,  3, False, False);
end;
//*************************************************************************************************************************************
procedure TiKeyBoard.SetupNumericKeyPad;
var
  Row : Integer;
begin
  RemoveAllButtons;

  Row := 0;
  CreateButton(iVK_NUMLOCK,    Row,  2, False, False);
  CreateButton(iVK_DIVIDE,     Row,  2, False, False);
  CreateButton(iVK_MULTIPLY,   Row,  2, False, False);
  CreateButton(iVK_SUBTRACT,   Row,  2, False, False);

  Row := 1;
  CreateButton(iVK_NUMPAD7,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD8,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD9,    Row,  2, False, False);
  CreateButton(iVK_ADD,        Row,  2, True,  False);

  Row := 2;
  CreateButton(iVK_NUMPAD4,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD5,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD6,    Row,  2, False, False);

  Row := 3;
  CreateButton(iVK_NUMPAD1,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD2,    Row,  2, False, False);
  CreateButton(iVK_NUMPAD3,    Row,  2, False, False);
  CreateButton(iVK_RETURN,     Row,  2, True,  False);

  Row := 4;
  CreateButton(iVK_NUMPAD0,    Row,  4, False, False);
  CreateButton(iVK_DECIMAL,    Row,  2, False, False);
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.SetupCustom1;
var
  Row : Integer;
begin
  RemoveAllButtons;

  Row := 0;
  CreateButton(iVK_A,         Row,  2, False, True );
  CreateButton(iVK_B,         Row,  2, False, True );
  CreateButton(iVK_C,         Row,  2, False, True );
  CreateButton(iVK_D,         Row,  2, False, True );
  CreateButton(iVK_E,         Row,  2, False, True );
  CreateButton(iVK_F,         Row,  2, False, True );
  CreateButton(iVK_G,         Row,  2, False, True );
  CreateButton(iVK_BACK,      Row,  2, False, False);
  CreateSpacer(               Row,  2);
  CreateButton(iVK_NUMPAD1,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD2,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD3,   Row,  2, False, False);
  Row := 1;
  CreateButton(iVK_H,         Row,  2, False, True );
  CreateButton(iVK_I,         Row,  2, False, True );
  CreateButton(iVK_J,         Row,  2, False, True );
  CreateButton(iVK_K,         Row,  2, False, True );
  CreateButton(iVK_L,         Row,  2, False, True );
  CreateButton(iVK_M,         Row,  2, False, True );
  CreateButton(iVK_N,         Row,  2, False, True );
  CreateButton(iVK_OEM_PLUS,  Row,  2, False, False);  // + and =
  CreateSpacer(               Row,  2);
  CreateButton(iVK_NUMPAD4,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD5,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD6,   Row,  2, False, False);
  Row := 2;
  CreateButton(iVK_O,         Row,  2, False, True );
  CreateButton(iVK_P,         Row,  2, False, True );
  CreateButton(iVK_Q,         Row,  2, False, True );
  CreateButton(iVK_R,         Row,  2, False, True );
  CreateButton(iVK_S,         Row,  2, False, True );
  CreateButton(iVK_T,         Row,  2, False, True );
  CreateButton(iVK_U,         Row,  2, False, True );
  CreateButton(iVK_OEM_2,     Row,  2, False, False); // / and ?
  CreateSpacer(               Row,  2);
  CreateButton(iVK_NUMPAD7,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD8,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD9,   Row,  2, False, False);
  Row := 3;
  CreateButton(iVK_V,         Row,  2, False, True );
  CreateButton(iVK_W,         Row,  2, False, True );
  CreateButton(iVK_X,         Row,  2, False, True );
  CreateButton(iVK_Y,         Row,  2, False, True );
  CreateButton(iVK_Z,         Row,  2, False, True );
  CreateButton(iVK_OEM_2,     Row,  2, False, True ); // / and ?
  CreateButton(iVK_OEM_COMMA, Row,  2, False, False); // , and <
  CreateButton(iVK_8,         Row,  2, False, True ); // 8 and *
  CreateSpacer(               Row,  2);
  CreateButton(iVK_DECIMAL,   Row,  2, False, False); // . and >
  CreateButton(iVK_NUMPAD0,   Row,  2, False, False);
  CreateButton(iVK_SUBTRACT,  Row,  2, False, False); // - and _
  Row := 4;
  CreateButton(iVK_OEM_5,     Row,  2, False, False); // \ and |
  CreateButton(iVK_OEM_1,     Row,  2, False, True ); // ; and :
  CreateButton(iVK_SPACE,     Row,  6, False, False);
  CreateButton(iVK_1,         Row,  2, False, True ); // 1 and !
  CreateButton(iVK_OEM_COMMA, Row,  2, False, True ); // , and <
  CreateButton(iVK_OEM_PERIOD,Row,  2, False, True ); // . and >
  CreateSpacer(               Row,  2);
  CreateButton(iVK_9,         Row,  2, False, True ); // 9 and (
  CreateButton(iVK_0,         Row,  2, False, True ); // 0 and )
  CreateButton(iVK_OEM_PLUS,  Row,  2, False, True); // = and +
end;
//****************************************************************************************************************************************************
procedure TiKeyBoard.SetupCustom2;
var
  Row : Integer;
begin
  RemoveAllButtons;

  Row := 0;
  CreateButton(iVK_A,         Row,  2, False, False);
  CreateButton(iVK_B,         Row,  2, False, False );
  CreateButton(iVK_C,         Row,  2, False, False );
  CreateButton(iVK_D,         Row,  2, False, False );
  CreateButton(iVK_E,         Row,  2, False, False );
  CreateButton(iVK_F,         Row,  2, False, False );
  CreateButton(iVK_G,         Row,  2, False, False );
  CreateButton(iVK_BACK,      Row,  2, False, False);
  CreateSpacer(               Row,  2);
  CreateButton(iVK_NUMPAD1,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD2,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD3,   Row,  2, False, False);
  Row := 1;
  CreateButton(iVK_H,         Row,  2, False, False );
  CreateButton(iVK_I,         Row,  2, False, False );
  CreateButton(iVK_J,         Row,  2, False, False );
  CreateButton(iVK_K,         Row,  2, False, False );
  CreateButton(iVK_L,         Row,  2, False, False );
  CreateButton(iVK_M,         Row,  2, False, False );
  CreateButton(iVK_N,         Row,  2, False, False );
  CreateButton(iVK_5,         Row,  2, False, True  );  // 5 and %
  CreateSpacer(               Row,  2);
  CreateButton(iVK_NUMPAD4,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD5,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD6,   Row,  2, False, False);
  Row := 2;
  CreateButton(iVK_O,         Row,  2, False, False );
  CreateButton(iVK_P,         Row,  2, False, False );
  CreateButton(iVK_Q,         Row,  2, False, False );
  CreateButton(iVK_R,         Row,  2, False, False );
  CreateButton(iVK_S,         Row,  2, False, False );
  CreateButton(iVK_T,         Row,  2, False, False );
  CreateButton(iVK_U,         Row,  2, False, False );
  CreateButton(iVK_OEM_7,     Row,  2, False, False); // ' and "
  CreateSpacer(               Row,  2);
  CreateButton(iVK_NUMPAD7,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD8,   Row,  2, False, False);
  CreateButton(iVK_NUMPAD9,   Row,  2, False, False);
  Row := 3;
  CreateButton(iVK_V,         Row,  2, False, False );
  CreateButton(iVK_W,         Row,  2, False, False );
  CreateButton(iVK_X,         Row,  2, False, False );
  CreateButton(iVK_Y,         Row,  2, False, False );
  CreateButton(iVK_Z,         Row,  2, False, False );
  CreateButton(iVK_3,         Row,  2, False, True  ); // 3 and #
  CreateButton(iVK_OEM_COMMA, Row,  2, False, False ); // , and <
  CreateButton(iVK_2,         Row,  2, False, True  ); // 2 and @
  CreateSpacer(               Row,  2);
  CreateButton(iVK_4,         Row,  2, False, True  ); // 4 and $
  CreateButton(iVK_NUMPAD0,   Row,  2, False, False );
  CreateButton(iVK_OEM_MINUS, Row,  2, False, True  ); // - and _
  Row := 4;
  CreateButton(iVK_OEM_5,     Row,  2, False, True  ); // \ and |
  CreateButton(iVK_OEM_1,     Row,  2, False, False ); // ; and :
  CreateButton(iVK_SPACE,     Row,  6, False, False );
  CreateButton(iVK_OEM_3,     Row,  2, False, True  ); // ` and ~
  CreateButton(iVK_OEM_4,     Row,  2, False, False ); // [ and {
  CreateButton(iVK_OEM_6,     Row,  2, False, False ); // ] and }
  CreateSpacer(               Row,  2);
  CreateButton(iVK_OEM_4,     Row,  2, False, True  ); // [ and {
  CreateButton(iVK_OEM_6,     Row,  2, False, True  ); // ] and }
  CreateButton(iVK_3,         Row,  2, False, True  ); // £ and £
end;
//*************************************************************************************************************************************
end.


