{*******************************************************}
{                                                       }
{       TiEditCustom Component                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iEditCustom;{$endif}
{$ifdef iCLX}unit QiEditCustom;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiEditCustom = class(TiCustomComponent)
  private
    FText               : String;
    FFont               : TFont;
    FDoingAutoSize      : Boolean;

    FPopupMenu          : TPopupMenu;
    FApplyMenuItem      : TMenuItem;
    FUndoMenuItem       : TMenuItem;
    FDivider1MenuItem   : TMenuItem;
    FCutMenuItem        : TMenuItem;
    FCopyMenuItem       : TMenuItem;                            
    FPasteMenuItem      : TMenuItem;
    FDeleteMenuItem     : TMenuItem;
    FDivider2MenuItem   : TMenuItem;
    FSelectAllMenuItem  : TMenuItem;

    FUndoText           : String;

    FMouseDown          : Boolean;
    FMouseDownCharPos   : Integer;
    FMaxWidth           : Integer;
    FAlignment          : TAlignment;
    FAlignmentMargin    : Integer;
    FSelStart           : Integer;
    FSelLength          : Integer;
    FCursorPos          : Integer;
    FCaretCreated       : Boolean;
    FDrawRect           : TRect;
    FDrawFirstCharIndex : Integer;
    FDrawLastCharIndex  : Integer;
    FDoubleClickActive  : Boolean;
    FAutoSelect         : Boolean;
    FAutoSize           : Boolean;
    FOnChange           : TNotifyEvent;
    FOnAutoSize         : TNotifyEvent;
    FMaxLength          : Integer;
    FColor              : TColor;
    FPasswordChar       : String;
    FAcceptOnLostFocus  : Boolean;
  protected
    procedure SetFont           (const Value: TFont);
    procedure SetText           (const Value: String); reintroduce;
    procedure SetAlignment      (const Value: TAlignment);
    procedure SetAlignmentMargin(const Value: Integer);
    procedure SetSelLength      (const Value: Integer);
    procedure SetSelStart       (const Value: Integer);
    procedure SetCursorPos      (const Value: Integer);
    procedure SetMaxLength      (const Value: Integer); virtual;
    procedure SetAutoSelect     (const Value: Boolean);
    procedure SetPasswordChar   (const Value: String);
    procedure iSetAutoSize      (const Value: Boolean);
    procedure SetColor          (const Value: TColor);

    function GetCanUndo  : Boolean;
    function GetModified : Boolean;

    procedure DeleteCaret;
    procedure iCreateCaret;

    procedure PopupMenuOpen         (Sender: TObject);

    procedure ApplyMenuItemClick    (Sender: TObject);
    procedure UndoMenuItemClick     (Sender: TObject);
    procedure CutMenuItemClick      (Sender: TObject);
    procedure CopyMenuItemClick     (Sender: TObject);
    procedure PasteMenuItemClick    (Sender: TObject);
    procedure DeleteMenuItemClick   (Sender: TObject);
    procedure SelectAllMenuItemClick(Sender: TObject);

    procedure iMouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp   (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove (                      Shift: TShiftState; X, Y: Integer); override;

    procedure iDoubleClick;                                                         override;

    procedure iDoSetFocus;                                                          override;
    procedure iDoKillFocus;                                                         override;

    procedure iPaintTo(Canvas: TCanvas);                                            override;

    procedure iKeyPress   (var Key: Char);                                          override;
    procedure iKeyDown   (var CharCode: Word; Shift: TShiftState);                  override;

    {$ifdef iVCL}
    procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;
    {$endif}

    procedure FontChange(Sender : TObject);

    procedure DoChange; virtual;
    procedure DoAutoSize;

    procedure CompleteChange; virtual;

    function AllowKey    (Key: Char    ): Boolean; virtual;

    procedure SelectCalc(StartPos, CurrentPos: Integer);

    function  GetCursorInView: Boolean;

    procedure InsertText(Value: String);

    procedure CursorHome  (Shift: TShiftState);
    procedure CursorEnd   (Shift: TShiftState);
    procedure CursorLeft  (Shift: TShiftState);
    procedure CursorRight (Shift: TShiftState);

    function GetSelText: String;
    procedure SetSelText(const Value: String);

    function GetDisplayText(Value: String): String;
    function GetTextToFit(Canvas: TCanvas; MaxWidth: Integer; DisplayText: String) : String;

    function GetBorderMargin: Integer;
    function PixelsToCharPos(Value: Integer): Integer;

    property CursorPos     : Integer       read FCursorPos    write SetCursorPos;

    property OnAutoSize    : TNotifyEvent  read FOnAutoSize   write FOnAutoSize;

    property Text          : String        read FText         write SetText;
    property UndoText      : String        read FUndoText     write FUndoText;
    property PasswordChar  : String        read FPasswordChar write SetPasswordChar;
  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;

    procedure SelectAll; virtual;
    procedure ClearSelection;

    procedure Apply;
    procedure Undo;
    procedure ClearUndo;
    procedure CopyToClipBoard;
    procedure CutToClipBoard;
    procedure PasteFromClipBoard;

    procedure Clear;

    property SelText           : String       read GetSelText         write SetSelText;
    property SelStart          : Integer      read FSelStart          write SetSelStart;
    property SelLength         : Integer      read FSelLength         write SetSelLength;
    property CanUndo           : Boolean      read GetCanUndo;
    property Modified          : Boolean      read GetModified;
  published
    property Alignment         : TAlignment   read FAlignment         write SetAlignment       default taLeftJustify;
    property AlignmentMargin   : Integer      read FAlignmentMargin   write SetAlignmentMargin default 0;
    property AutoSelect        : Boolean      read FAutoSelect        write SetAutoSelect      default True;
    property AutoSize          : Boolean      read FAutoSize          write iSetAutoSize       default True;
    property MaxLength         : Integer      read FMaxLength         write SetMaxLength;
    property Font              : TFont        read FFont              write SetFont;
    property AcceptOnLostFocus : Boolean      read FAcceptOnLostFocus write FAcceptOnLostFocus default True;
    property Color             : TColor       read FColor             write SetColor           default clWindow;
    property OnChange          : TNotifyEvent read FOnChange          write FOnChange;

    property BorderStyle                                                                       default ibsLowered;
    property TabOrder;
    property TabStop                                                                           default True;

    property Width        default 80;
    property Height       default 21;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiEditCustom.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width   := 80;
  Height  := 21;
  TabStop := True;
  FColor  := clWindow;

  BorderStyle        := ibsLowered;

  FAlignment         := taLeftJustify;
  FAutoSelect        := True;
  FAutoSize          := True;
  FAcceptOnLostFocus := True;

  FFont              := TFont.Create;
  Font.OnChange      := FontChange;

  FPopupMenu         := TPopupMenu.Create(Self);
  FPopupMenu.OnPopup := PopupMenuOpen;

  FApplyMenuItem     := TMenuItem.Create(PopupMenu); FApplyMenuItem.Caption     := 'Apply';      FApplyMenuItem.OnClick     := ApplyMenuItemClick;
  FUndoMenuItem      := TMenuItem.Create(PopupMenu); FUndoMenuItem.Caption      := 'Undo';       FUndoMenuItem.OnClick      := UndoMenuItemClick;
  FDivider1MenuItem  := TMenuItem.Create(PopupMenu); FDivider1MenuItem.Caption  := '-';
  FCutMenuItem       := TMenuItem.Create(PopupMenu); FCutMenuItem.Caption       := 'Cut';        FCutMenuItem.OnClick       := CutMenuItemClick;
  FCopyMenuItem      := TMenuItem.Create(PopupMenu); FCopyMenuItem.Caption      := 'Copy';       FCopyMenuItem.OnClick      := CopyMenuItemClick;
  FPasteMenuItem     := TMenuItem.Create(PopupMenu); FPasteMenuItem.Caption     := 'Paste';      FPasteMenuItem.OnClick     := PasteMenuItemClick;
  FDeleteMenuItem    := TMenuItem.Create(PopupMenu); FDeleteMenuItem.Caption    := 'Delete';     FDeleteMenuItem.OnClick    := DeleteMenuItemClick;
  FDivider2MenuItem  := TMenuItem.Create(PopupMenu); FDivider2MenuItem.Caption  := '-';
  FSelectAllMenuItem := TMenuItem.Create(PopupMenu); FSelectAllMenuItem.Caption := 'Select All'; FSelectAllMenuItem.OnClick := SelectAllMenuItemClick;

  FPopupMenu.Items.Add(FApplyMenuItem);
  FPopupMenu.Items.Add(FUndoMenuItem);
  FPopupMenu.Items.Add(FDivider1MenuItem);
  FPopupMenu.Items.Add(FCutMenuItem);
  FPopupMenu.Items.Add(FCopyMenuItem);
  FPopupMenu.Items.Add(FPasteMenuItem);
  FPopupMenu.Items.Add(FDeleteMenuItem);
  FPopupMenu.Items.Add(FDivider2MenuItem);
  FPopupMenu.Items.Add(FSelectAllMenuItem);
end;
//****************************************************************************************************************************************************
destructor TiEditCustom.Destroy;
begin
  FFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.DoChange;
begin
  if not (csLoading in ComponentState) then
    begin
      if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Value');
      if Assigned(FOnChange)         then FOnChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.FontChange(Sender : TObject);
begin
  DoAutoSize;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.SetAlignmentMargin(const Value: Integer);begin SetIntegerProperty(Value, FAlignmentMargin, irtInvalidate);end;
procedure TiEditCustom.SetAutoSelect     (const Value: Boolean);begin SetBooleanProperty(Value, FAutoSelect,      irtNone      );end;
procedure TiEditCustom.SetMaxLength      (const Value: Integer);begin SetIntegerProperty(Value, FMaxLength,       irtNone      );end;
procedure TiEditCustom.SetColor          (const Value: TColor );begin SetColorProperty  (Value, FColor,           irtInvalidate);end;
procedure TiEditCustom.SetPasswordChar   (const Value: String );begin SetStringProperty (Value, FPasswordChar,    irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiEditCustom.SetText(const Value: String);
begin
  if FText <> Value then
    begin
      FText := Value;
      SelLength := 0;
      CursorPos := 0;
      CompleteChange;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.SetSelLength(const Value: Integer);
var
  TempValue : Integer;
begin
  TempValue := Value;
  if TempValue < 0 then             TempValue := 0;
  if TempValue > Length(FText) then TempValue := Length(FText);

  if FSelLength <> TempValue then
    begin
      FSelLength := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.SetSelStart(const Value: Integer);
var
  TempValue : Integer;
begin
  TempValue := Value;
  if TempValue < 0 then             TempValue := 0;
  if TempValue > Length(FText) then TempValue := Length(FText);

  if FSelStart <> TempValue then
    begin
      FSelStart := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
function TiEditCustom.GetCursorInView: Boolean;
var
  AText : String;
begin
  Result := True;
  if FCursorPos < FDrawFirstCharIndex then
    begin
      Result := False;
      Exit;
    end;

  Canvas.Font.Assign(FFont);
  AText := GetDisplayText(Copy(FText, FDrawFirstCharIndex + 1, FCursorPos - FDrawFirstCharIndex + 1));
  if Canvas.TextWidth(AText) > FMaxWidth then Result := False;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.SetCursorPos(const Value: Integer);
var
  TempValue : Integer;
begin
  TempValue := Value;
  if TempValue < 0 then             TempValue := 0;
  if TempValue > Length(FText) then TempValue := Length(FText);

  if FCursorPos <> TempValue then
    begin
      FCursorPos := TempValue;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then
    begin
      FAlignment := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;
//****************************************************************************************************************************************************
function TiEditCustom.GetBorderMargin: Integer;
begin
  if BorderStyle = ibsNone then Result := 0 else Result := 2;
end;
//****************************************************************************************************************************************************
function TiEditCustom.GetDisplayText(Value: String): String;
var
  x       : Integer;
  ALength : Integer;
begin
  Result := FText;
  if Length(FPasswordChar) <> 0 then
    begin
      ALength := Length(FText);
      Result   := '';
      for x := 0 to ALength-1 do
        Result := Result + Copy(FPasswordChar, 1, 1);
    end;
end;
//****************************************************************************************************************************************************
function TiEditCustom.GetTextToFit(Canvas: TCanvas; MaxWidth: Integer; DisplayText: String) : String;
begin
  with Canvas do
    begin
      FDrawLastCharIndex := Length(DisplayText)-1;
      Result := Copy(DisplayText, FDrawFirstCharIndex + 1, (FDrawLastCharIndex - FDrawFirstCharIndex + 1) );

      while TextWidth(Result) > FMaxWidth do
        begin
          Dec(FDrawLastCharIndex);
          Result := Copy(DisplayText, FDrawFirstCharIndex + 1, (FDrawLastCharIndex - FDrawFirstCharIndex + 1));
        end;

      while TextWidth(Result) > FMaxWidth do
        begin
          Inc(FDrawFirstCharIndex);
          Result := Copy(DisplayText, FDrawFirstCharIndex + 1, (FDrawLastCharIndex - FDrawFirstCharIndex + 1));
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.iPaintTo(Canvas: TCanvas);
var
  AText        : String;
  ARect        : TRect;
  ATextWidth   : Integer;
  ATextFlags   : TiTextFlags;
  BorderMargin : Integer;
  ActualStart  : Integer;
  ActualStop   : Integer;
  DisplayText  : String;
begin
  with Canvas do
    begin
      if ErrorActive then
           DrawBackGround(Canvas, ErrorBackGroundColor)
      else DrawBackGround(Canvas, Self.Color);

      BorderMargin := GetBorderMargin;

      DisplayText := GetDisplayText(FText);
      
      if not ErrorActive then
        begin
          Font.Assign(FFont);

          FMaxWidth := Width - 2*BorderMargin - FAlignmentMargin;

          AText := DisplayText;


          if TextWidth(AText) < FMaxWidth then
            begin
              FDrawFirstCharIndex := 0;
              FDrawLastCharIndex  := Length(FText)-1;
            end
          else
            begin
              if FCursorPos < FDrawFirstCharIndex then FDrawFirstCharIndex := FCursorPos;

              AText := GetTextToFit(Canvas, MaxLength, DisplayText);

              while FCursorPos < FDrawFirstCharIndex do
                begin
                  Dec(FDrawFirstCharIndex);   
                  AText := GetTextToFit(Canvas, MaxLength, DisplayText);
                end;

              while FCursorPos > (FDrawLastCharIndex+1) do
                begin
                  Inc(FDrawFirstCharIndex);
                  AText := GetTextToFit(Canvas, MaxLength, DisplayText);
                end;
            end;
        end
      else
        begin
          Font.Assign(ErrorFont);
          AText := ErrorText;
        end;


      ATextWidth := TextWidth(AText);


      ARect.Top    :=           1+ BorderMargin;
      ARect.Bottom := ARect.Top + TextHeight(AText);

      ATextFlags := [itfHLeft, itfVTop, itfSingleLine, itfNoClip];

      case FAlignment of
        taCenter      : begin
                          ARect.Right := Width div 2 + ATextWidth div 2;
                          ARect.Left  := ARect.Right - ATextWidth;
                        end;
        taLeftJustify : begin
                          ARect.Left  := 2 + BorderMargin-1 + FAlignmentMargin;
                          ARect.Right := ARect.Left + ATextWidth;
                        end;
        else            begin
                          ARect.Right := Width - 2 - BorderMargin - FAlignmentMargin;
                          ARect.Left  := ARect.Right - ATextWidth;
                        end;
      end;

      Brush.Style := bsClear;
      iDrawText(Canvas, AText, ARect, ATextFlags, True, clBtnFace);
      Brush.Style := bsSolid;

      FDrawRect := ARect;

      if not ErrorActive then
        begin
          AText := Copy(DisplayText, FDrawFirstCharIndex + 1, CursorPos - FDrawFirstCharIndex);
          {$ifdef iVCL}
          ATextWidth := TextWidth(AText);
          {$endif}
          if HasFocus then
            begin
              iCreateCaret;
              {$ifdef iVCL}
              ShowCaret(Handle);
              SetCaretPos(ARect.Left + ATextWidth, 3);
              {$endif}
            end;
        end
      else DeleteCaret;

      if (SelLength <> 0) and HasFocus and (not ErrorActive) then
        begin
          Brush.Style := bsSolid;
          Brush.Color := clHighlight;
          Font.Color  := clWhite;


          ActualStart := SelStart;
          ActualStop  := ActualStart + SelLength - 1;

          if ActualStart < FDrawFirstCharIndex then ActualStart := FDrawFirstCharIndex;
          if ActualStop  > FDrawLastCharIndex  then ActualStop  := FDrawLastCharIndex;

          AText := Copy(DisplayText, FDrawFirstCharIndex + 1,  ActualStart - FDrawFirstCharIndex);

          ARect.Left := FDrawRect.Left + TextWidth(AText);

          AText := Copy(DisplayText, ActualStart + 1,  ActualStop - ActualStart + 1);

          ARect.Right := ARect.Left + TextWidth(AText);

          FillRect(ARect);

          iDrawText(Canvas, AText, ARect, ATextFlags, True, clBtnFace);
        end;
      DrawBorder(Canvas);
    end;
end;
//****************************************************************************************************************************************************
function TiEditCustom.PixelsToCharPos(Value: Integer): Integer;
var
  x     : Integer;
  AText : String;
  AChar : String;
  APos  : Integer;
begin
  Result := 0;
  with Canvas do
    begin
      Font.Assign(FFont);
      if Value < FDrawRect.Left then
        begin
          Result := FDrawFirstCharIndex-1;
          if Result < 0 then Result := 0;
        end
      else
        for x := FDrawFirstCharIndex to FDrawLastCharIndex+1 do
          begin
            AText := Copy(GetDisplayText(FText), FDrawFirstCharIndex + 1, x - FDrawFirstCharIndex + 1 - 1);
            AChar := Copy(GetDisplayText(FText), x , 1);
            APos := TextWidth(AText) + TextWidth(AChar) div 2;
            Result := x;
            if (FDrawRect.Left + APos) > Value then Break;
          end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ScreenPoint : TPoint;
begin
  if not HasFocus then
    begin
      SetFocus;
      if FAutoSelect then SelectAll;
    end;

  if (Button = mbRight) and not Assigned(PopupMenu) then
    begin
      ScreenPoint := ClientToScreen(Point(X, Y));
      FPopupMenu.Popup(ScreenPoint.X, ScreenPoint.Y);
      Exit;
    end;

  CursorPos := PixelsToCharPos(X);

  FMouseDown        := True;

  if FDoubleClickActive then
    begin
      FDoubleClickActive := False;
    end
  else
    begin
      SelLength         := 0;
      SelStart          := CursorPos;
      FMouseDownCharPos := CursorPos;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseDown := False;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.iMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  Cursor  := crIBeam;

  if not FMouseDown then Exit;

  CursorPos := PixelsToCharPos(X);

  SelectCalc(FMouseDownCharPos, CursorPos);

  InvalidateChange;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiEditCustom.WMGetDLGCode(var Message: TMessage);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS {+ DLGC_WANTALLKEYS};
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiEditCustom.iDoSetFocus;
begin
  inherited;
  if ErrorActive then Exit;
  Canvas.Font.Assign(FFont);

  iCreateCaret;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.iDoKillFocus;
begin
  inherited;
  DeleteCaret;
  FMouseDown         := False;
  FDoubleClickActive := False;
  if FAcceptOnLostFocus then CompleteChange;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.SelectCalc(StartPos, CurrentPos: Integer);
begin
  if CurrentPos > StartPos then
    begin
      SelStart := StartPos;
      SelLength := CurrentPos - StartPos;
    end
  else
    begin
      SelStart := CurrentPos;
      SelLength := StartPos - CurrentPos;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.iKeyPress(var Key: Char);
begin
  inherited iKeyPress(Key);
  
  if Key = #0 then Exit;

  case ord(Key) of
    iVK_BACK    : begin
                    if SelLength <> 0 then ClearSelection
                    else
                      begin
                        Delete(FText, CursorPos, 1);
                        CursorPos := CursorPos - 1;
                      end;
                  end;
    iVK_RETURN  : begin
                    CompleteChange;
                    SelectAll;
                  end;
    iVK_ESCAPE  : begin
                    Undo;
                  end;
    iVK_CANCEL  : begin //Ctrl-C
                    CopyToClipBoard;
                  end;
    iVK_CTRL_V : begin //Ctrl-V
                   PasteFromClipBoard;
                 end;
    iVK_CTRL_X : begin //Ctrl-X
                   CutToClipBoard;
                 end;
    iVK_CTRL_Z : begin //Ctrl-Z
                   Undo;
                 end;
    iVK_CTRL_A : begin //Ctrl-A
                   SelectAll;
                 end;
    else         begin
                   if AllowKey(Key) then
                     begin
                       if FMaxLength <> 0 then
                         begin
                           if (Length(FText) < MaxLength) or (FSelLength <> 0) then InsertText(Key) else Beep;
                         end
                       else InsertText(Key);
                     end;
                 end
  end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if ssShift in Shift then if SelLength = 0 then
    begin
      FMouseDownCharPos := CursorPos;
    end;

  case CharCode of
    iVK_LEFT   : begin
                   if ssCtrl in Shift then CursorHome(Shift) else CursorLeft(Shift);
                 end;
    iVK_RIGHT  : begin
                   if ssCtrl in Shift then CursorEnd(Shift) else CursorRight(Shift);
                 end;
    iVK_HOME   : begin
                   CursorHome(Shift);
                 end;
    iVK_END    : begin
                   CursorEnd(Shift);
                 end;
    iVK_DELETE : begin
                   if SelLength <> 0 then ClearSelection
                   else                   Delete(FText, CursorPos + 1, 1);
                   InvalidateChange;
                 end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.CursorHome(Shift: TShiftState);
begin
  CursorPos := 0;
  if ssShift in Shift then SelectCalc(FMouseDownCharPos, CursorPos)
  else                     SelLength := 0;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.CursorEnd(Shift: TShiftState);
begin
  CursorPos := Length(FText);
  if ssShift in Shift then SelectCalc(FMouseDownCharPos, CursorPos)
  else                     SelLength := 0;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.CursorLeft(Shift: TShiftState);
begin
  CursorPos := CursorPos - 1;
  if ssShift in Shift then SelectCalc(FMouseDownCharPos, CursorPos)
  else                     SelLength := 0;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.CursorRight(Shift: TShiftState);
begin
  CursorPos := CursorPos + 1;
  if ssShift in Shift then SelectCalc(FMouseDownCharPos, CursorPos)
  else                     SelLength := 0;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.InsertText(Value: String);
begin
  ClearSelection;
  Insert(Value, FText, CursorPos+1);
  CursorPos := CursorPos + Length(Value);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.CopyToClipBoard;
begin
  if ErrorActive        then Clipboard.AsText := GetDisplayText(ErrorText)
  else if SelText <> '' then Clipboard.AsText := GetDisplayText(SelText);
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.CutToClipBoard;
begin
  if ErrorActive then Clipboard.AsText := ErrorText
  else
    begin
      if SelText <> '' then Clipboard.AsText := GetDisplayText(SelText);
      ClearSelection;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.PasteFromClipBoard;
var
  AText : String;
begin
  if ErrorActive then Exit;
  if FMaxLength = 0 then
    begin
      InsertText(Clipboard.AsText);
    end
  else
    begin
      AText := Clipboard.AsText;
      AText := Copy(AText, 1, MaxLength - Length(FText));
      InsertText(AText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.SelectAll;
begin
  SelStart := 0;
  SelLength := Length(FText);
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.ClearSelection;
begin
  if SelLength = 0 then Exit;
  Delete(FText, FSelStart + 1, FSelLength);
  CursorPos := FSelStart;
  SelLength := 0;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.iDoubleClick;
begin
  FDoubleClickActive := True;
  SelectAll;
end;
//****************************************************************************************************************************************************
function TiEditCustom.GetSelText: String;
begin
  Result := Copy(FText, FSelStart + 1, FSelLength);
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.PopupMenuOpen(Sender: TObject);
begin
  FApplyMenuItem.Enabled     := (FUndoText        <> FText) and (not ErrorActive);
  FUndoMenuItem.Enabled      := (FUndoText        <> FText) and (not ErrorActive);
  FCutMenuItem.Enabled       := (SelText          <> '')    and (not ErrorActive);
  FCopyMenuItem.Enabled      := (SelText          <> '')    or  (    ErrorActive);
  FPasteMenuItem.Enabled     := (Clipboard.AsText <> '')    and (not ErrorActive);
  FDeleteMenuItem.Enabled    := (SelText          <> '')    and (not ErrorActive);
  FSelectAllMenuItem.Enabled :=  FSelLength       <> Length(FText);
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.ApplyMenuItemClick(Sender: TObject);
begin
  UserGenerated := True;
  try
    Apply
  finally
    UserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.PasteMenuItemClick    (Sender: TObject);begin PasteFromClipBoard;end;
procedure TiEditCustom.UndoMenuItemClick     (Sender: TObject);begin Undo               end;
procedure TiEditCustom.CutMenuItemClick      (Sender: TObject);begin CutToClipBoard;    end;
procedure TiEditCustom.CopyMenuItemClick     (Sender: TObject);begin CopyToClipBoard;   end;
procedure TiEditCustom.DeleteMenuItemClick   (Sender: TObject);begin ClearSelection;    end;
procedure TiEditCustom.SelectAllMenuItemClick(Sender: TObject);begin SelectAll;         end;
//****************************************************************************************************************************************************
procedure TiEditCustom.Apply;
begin
  CompleteChange;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.Undo;
begin
  FText := FUndoText;
  SelLength := 0;
  CursorHome([]);
  if FAutoSelect then SelectAll;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.CompleteChange;
begin
  if FText <> FUndoText then
    begin
      DoChange;
      FUndoText := FText;
      if FAutoSelect then SelectAll;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.DoAutoSize;
begin
  if FDoingAutoSize                                                   then Exit;
  if csLoading in ComponentState                                      then Exit;
  if not Assigned(Parent) {$ifdef iVCL}and (ParentWindow = 0){$endif} then Exit;

  if FAutoSize then
    begin
      FDoingAutoSize := True;
      try
        with Canvas do
          begin
            Font.Assign(FFont);
            Height := 2*GetBorderMargin + 4 + TextHeight('ABC');
          end;
        if Assigned(FOnAutoSize) then FOnAutoSize(Self);
      finally
        FDoingAutoSize := False;
      end;
    end;
end;                               
//****************************************************************************************************************************************************
procedure TiEditCustom.Clear;
begin
  Text := '';
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.ClearUndo;
begin
  FUndoText := Text;
end;
//****************************************************************************************************************************************************
function TiEditCustom.GetCanUndo: Boolean;
begin
  Result := FUndoText <> FText;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.SetSelText(const Value: String);
var
  SubStringPos : Integer;
begin
  SubStringPos := POS(Value, FText);
  if SubStringPos <> 0 then
    begin
      FSelStart := SubStringPos - 1;
      FSelLength := Length(Value);
    end;
end;
//****************************************************************************************************************************************************
function TiEditCustom.GetModified: Boolean;
begin
  Result := FUndoText <> FText;
end;
//****************************************************************************************************************************************************
function TiEditCustom.AllowKey(Key: Char): Boolean;
begin
  Result := True;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.DeleteCaret;
begin
  if FCaretCreated then
    begin
      {$ifdef iVCL}
      HideCaret(Handle);
      DestroyCaret;
      {$endif}
      FCaretCreated := False;
    end;
end;
//****************************************************************************************************************************************************
procedure TiEditCustom.iCreateCaret;
{$ifdef iVCL}
var
  AHeight : Integer;
{$endif}
begin
  if not FCaretCreated then
    begin
      Canvas.Font.Assign(FFont);

      {$ifdef iVCL}
      AHeight := Canvas.TextHeight('ABC');
      FCaretCreated := CreateCaret(Handle, 0, 0, AHeight);
      ShowCaret(Handle);
      {$endif}

      {$ifdef iCLX}
      {$endif}
    end;
end;
//****************************************************************************************************************************************************
end.


